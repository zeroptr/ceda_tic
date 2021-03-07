{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant                                                            }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit oaEngine;

interface

uses
  Windows, Classes, Graphics, SyncObjs, oaActor;

const
  MaxBranch = 4;

type

  TNormalBranch = record
    Precent: 0..100;
    Frame: Byte;
  end;

  TExitBranch = record
    Enabled: Boolean;
    Frame: Byte;
  end;

  TAssistantEngine = class(TThread)
  private
    DIBits: PByte;
    DIBytesPerRow: Integer;
    FrameBytesPerRow: Integer;
    FrameBitmap: TBitmap;
    FrameRegion: HRGN;
    FrameWidth: Integer;
    FrameHeight: Integer;
    Stream: TMemoryStream;
    Regions: array[Byte] of HRGN;
    Delays: array[Byte] of Byte;
    Branches: array[Byte, 1..MaxBranch] of TNormalBranch;
    ExitBranches: array[Byte] of TExitBranch;
    Sounds: array[Byte] of Word;
    CurrentSequence: Word;
    BlindEntry: Byte;
    UseReturnPath: Boolean;
    Completed: Boolean;
    FrameCount: Integer;
    CurrentFrame: Byte;
    SequenceEvent: THandle;
    BreakEvent: THandle;
    Actor: TAssistantActor;
    CS: TRTLCriticalSection;
    fSpeed: Word;
    fMute: Boolean;
    fOnSequenceStart: TNotifyEvent;
    fOnSequenceStop: TNotifyEvent;
    fOnFrameChange: TNotifyEvent;
    function GetEmpty: Boolean;
    function GetSequenceHasSound: Boolean;
    function GetSequenceHasExitBranch: Boolean;
    function GetSequenceIsInfinite: Boolean;
    function GetSequencing: Boolean;
    procedure SetSequencing(Value: Boolean);
  protected
    procedure Execute; override;
    procedure CreateRegions;
    procedure DoFrameChange;
    function FindNextFrame(Frame: Byte; UseExitBranch: Boolean): Byte;
  public
    constructor Create(AssistantActor: TAssistantActor);
    destructor Destroy; override;
    procedure Terminate;
    procedure Initialize;
    procedure Finalize;
    function LoadSequence(Index: Word): Boolean;
    function PrepareToReturn: Boolean;
    procedure DrawFrame(DC: HDC; X, Y: Integer);
    property Empty: Boolean read GetEmpty;
    property Bitmap: TBitmap read FrameBitmap;
    property Region: HRGN read FrameRegion;
    property Width: Integer read FrameWidth;
    property Height: Integer read FrameHeight;
    property SequenceHasSound: Boolean read GetSequenceHasSound;
    property SequenceHasExitBranch: Boolean read GetSequenceHasExitBranch;
    property SequenceIsInfinite: Boolean read GetSequenceIsInfinite;
    property Sequencing: Boolean read GetSequencing write SetSequencing;
    property Mute: Boolean read fMute write fMute;
    property Speed: Word read fSpeed write fSpeed;
    property OnSequenceStart: TNotifyEvent read fOnSequenceStart write fOnSequenceStart;
    property OnSequenceStop: TNotifyEvent read fOnSequenceStop write fOnSequenceStop;
    property OnFrameChange: TNotifyEvent read fOnFrameChange write fOnFrameChange;
  end;

implementation

uses
  SysUtils, MMSystem, oaTypes, oaBitmap, oaLZRWKH;

{ TAssistantEngine }

constructor TAssistantEngine.Create(AssistantActor: TAssistantActor);
begin
  inherited Create(True);
  Actor := AssistantActor;
  Stream := TMemoryStream.Create;
  FrameBitmap := TBitmap.Create;
  SequenceEvent := CreateEvent(nil, True, False, nil);
  BreakEvent := CreateEvent(nil, True, True, nil);
  InitializeCriticalSection(CS);
  fSpeed := 100;
  Resume;
end;

destructor TAssistantEngine.Destroy;
begin
  Stream.Free;
  FrameBitmap.Free;
  CloseHandle(BreakEvent);
  CloseHandle(SequenceEvent);
  DeleteCriticalSection(CS);
  inherited Destroy;
end;

procedure TAssistantEngine.Initialize;
begin
  FrameWidth := Actor.Width;
  FrameHeight := Actor.Height;
  FrameBitmap.Canvas.Lock;
  try
    FrameBitmap.Width := FrameWidth;
    FrameBitmap.Height := FrameHeight;
    FrameBitmap.PixelFormat := pf8bit;
    FrameBitmap.Palette := CopyPalette(Actor.Palette);
  finally
    FrameBitmap.Canvas.Unlock;
  end;
  BlindEntry := Actor.BlindColorEntry;
  FrameBytesPerRow := BytesPerScanline(FrameWidth, 8, 32);
end;

procedure TAssistantEngine.Finalize;
begin
  Sequencing := False;
  while FrameCount > 0 do
  begin
    Dec(FrameCount);
    DeleteObject(Regions[FrameCount]);
  end;
  FillChar(Regions, SizeOf(Regions), 0);
  FillChar(Sounds, SizeOf(Sounds), 0);
  FillChar(Delays, SizeOf(Delays), 0);
  FillChar(Branches, SizeOf(Branches), 0);
  FillChar(ExitBranches, SizeOf(ExitBranches), 0);
  CurrentFrame := 0;
  UseReturnPath := False;
  Completed := False;
  FrameRegion := 0;
  FrameBitmap.Handle := 0;
  FrameBitmap.Palette := 0;
  CurrentSequence := 0;
  Stream.Clear;
end;

procedure TAssistantEngine.CreateRegions;
const
  AllocBy = 1000; // Rects
var
  RectAllocated: Integer;
  RectFound: Integer;
  RgnData: PRgnData;
  RgnSize: Integer;
  Rects: PRect;
  X, Y: Integer;
  Start: Integer;
  Skipping: Boolean;
  Entries: PByte;
  Entry: PByte;
  Frame: Integer;

  procedure AddRect;
  begin
    if RectFound = RectAllocated then
    begin
      Inc(RectAllocated, AllocBy);
      Inc(RgnSize, AllocBy * SizeOf(TRect));
      ReallocMem(RgnData, RgnSize);
      Rects := PRect(@(RgnData^.Buffer));
      Inc(Rects, RectFound);
    end;
    with Rects^ do
    begin
      Left := Start;
      Top := Y;
      Right := X;
      Bottom := Y + 1;
    end;
    Inc(RectFound);
    Inc(Rects);
  end;

begin
  RgnData := nil;
  RectAllocated := AllocBy;
  ReallocMem(RgnData, SizeOf(TRgnData) + (RectAllocated * SizeOf(TRect)));
  try
    with RgnData^.rdh do
    begin
      dwSize := SizeOf(TRgnDataHeader);
      iType := RDH_RECTANGLES;
      nRgnSize := SizeOf(TRect);
      rcBound.Left := 0;
      rcBound.Top := 0;
      rcBound.Right := FrameWidth - 1;
      rcBound.Bottom := FrameHeight - 1;
    end;
    for Frame := 0 to FrameCount - 1 do
    begin
      RectFound := 0;
      Rects := PRect(@(RgnData^.Buffer));
      Entries := PByte(Integer(DIBits) + Frame * FrameWidth);
      for Y := 0 to FrameHeight - 1 do
      begin
        Start := 0;
        Entry := Entries;
        Skipping := (Entry^ <> BlindEntry);
        for X := 0 to FrameWidth - 1 do
        begin
          if Skipping then
          begin
            if Entry^ = BlindEntry then
            begin
              AddRect;
              Skipping := False;
            end;
          end
          else if Entry^ <> BlindEntry then
          begin
            Skipping := True;
            Start := X;
          end;
          Inc(Entry);
        end;
        if Skipping then AddRect;
        Inc(Entries, DIBytesPerRow);
      end;
      RgnSize := SizeOf(TRgnData) + (RectFound * SizeOf(TRect));
      RgnData^.rdh.nCount := RectFound;
      Regions[Frame] := ExtCreateRegion(nil, RgnSize, RgnData^);
    end;
  finally
    ReallocMem(RgnData, 0);
  end;
end;

function TAssistantEngine.LoadSequence(Index: Word): Boolean;
var
  ResStream: TResourceStream;
begin
  Actor.Lock;
  try
    Result := False;
    if (Index > 0) and (Index <= Actor.AnimationCount) then
    begin
      Sequencing := False;
      if CurrentSequence <> Index then
      begin
        CurrentSequence := Index;
        while FrameCount > 0 do
        begin
          Dec(FrameCount);
          DeleteObject(Regions[FrameCount]);
        end;
        Stream.Position := 0;
        ResStream := TResourceStream.CreateFromID(Actor.Instance,
          Actor.AnimationInfo[Index].Resource, RT_RCDATA);
        try
          DecompressStream(ResStream, Stream);
        finally
          ResStream.Free;
        end;
        Stream.Position := 0;
        Stream.Read(FrameCount, SizeOf(FrameCount));
        Stream.Read(Sounds, FrameCount * SizeOf(Word));
        Stream.Read(Delays, FrameCount * SizeOf(Byte));
        Stream.Read(Branches, MaxBranch * FrameCount * SizeOf(TNormalBranch));
        Stream.Read(ExitBranches, FrameCount * SizeOf(TExitBranch));
        DIBits := PByte(Integer(Stream.Memory) + Stream.Position);
        DIBytesPerRow := BytesPerScanline(FrameCount * FrameWidth, 8, 8);
        CreateRegions;
      end;
      UseReturnPath := False;
      CurrentFrame := 0;
      Result := True;
    end;
  finally
    Actor.Unlock;
  end;
end;

function TAssistantEngine.PrepareToReturn: Boolean;
var
  AnimInfo: PAnimationInfo;
begin
  Actor.Lock;
  try
    Result := False;
    if (CurrentSequence <> 0) and not UseReturnPath then
    begin
      AnimInfo := Actor.AnimationInfo[CurrentSequence];
      if ((AnimInfo.ExitType = etExitBranch) or not Completed) and SequenceHasExitBranch then
      begin
        UseReturnPath := True;
        Result := True;
      end
      else if Completed and (AnimInfo.ExitType = etAnimation) then
        Result := LoadSequence(AnimInfo.ReturnIndex);
    end;
  finally
    Actor.Unlock;
  end;
end;

function TAssistantEngine.GetSequenceIsInfinite: Boolean;
var
  I, J: Integer;
begin
  Result := False;
  for I := 0 to FrameCount - 1 do
    for J := 1 to MaxBranch do
      if (Branches[I,J].Precent = 100) and (Branches[I,J].Frame <= I) then
      begin
        Result := True;
        Exit;
      end;
end;

function TAssistantEngine.GetSequenceHasSound: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := FrameCount - 1 downto 0 do
    if Sounds[I] <> 0 then
    begin
      Result := True;
      Exit;
    end;
end;

function TAssistantEngine.GetSequenceHasExitBranch: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := FrameCount - 1 downto 0 do
    if ExitBranches[I].Enabled then
    begin
      Result := True;
      Exit;
    end;
end;

function TAssistantEngine.GetEmpty: Boolean;
begin
  Result := (FrameCount = 0);
end;

function TAssistantEngine.GetSequencing: Boolean;
begin
  Result := (WaitForSingleObject(BreakEvent, 0) = WAIT_TIMEOUT);
end;

procedure TAssistantEngine.SetSequencing(Value: Boolean);
begin
  EnterCriticalSection(CS);
  try
    if FrameCount = 0 then
      Value := False;
    if Sequencing <> Value then
    begin
      if Value then
      begin
        ResetEvent(BreakEvent);
        SetEvent(SequenceEvent);
      end
      else
        SetEvent(BreakEvent);
    end;
  finally
    LeaveCriticalSection(CS);
  end;
end;

procedure TAssistantEngine.DrawFrame(DC: HDC; X, Y: Integer);
begin
  with FrameBitmap do
  begin
    Canvas.Lock;
    try
      if not Empty then
        BitBlt(DC, X, Y, FrameWidth, FrameHeight, Canvas.Handle, 0, 0, SRCCOPY);
    finally
      Canvas.Unlock;
    end;
  end;
end;

procedure TAssistantEngine.DoFrameChange;
var
  DstBytes, SrcBytes: PByte;
  Row, Col: Integer;
  D, S: PByte;
begin
  FrameBitmap.Canvas.Lock;
  try
    SrcBytes := PByte(Integer(DIBits) + CurrentFrame * FrameWidth);
    DstBytes := FrameBitmap.ScanLine[0];
    for Row := FrameHeight - 1 downto 0 do
    begin
      S := SrcBytes;
      D := DstBytes;
      for Col := FrameWidth - 1 downto 0 do
      begin
        D^ := S^;
        Inc(S);
        Inc(D);
      end;
      Inc(SrcBytes, DIBytesPerRow);
      Dec(DstBytes, FrameBytesPerRow);
    end;
  finally
    FrameBitmap.Canvas.Unlock;
  end;
  FrameRegion := Regions[CurrentFrame];
  if Assigned(fOnFrameChange) and Sequencing then
    fOnFrameChange(Self);
  if not Mute and (Sounds[CurrentFrame] > 0) and Sequencing then
    PlaySound(MakeIntResource(Sounds[CurrentFrame]), Actor.Instance,
      SND_RESOURCE or SND_NOWAIT or SND_NOSTOP or SND_ASYNC or SND_NODEFAULT);
end;

function TAssistantEngine.FindNextFrame(Frame: Byte; UseExitBranch: Boolean): Byte;
var
  B, P: Byte;
  Branched: Boolean;
begin
  Result := Frame;
  if UseExitBranch then
    if Frame < FrameCount - 1 then
      if ExitBranches[Frame].Enabled then
        Result := ExitBranches[Frame].Frame
      else
        Result := Frame + 1
    else
      Completed := True
  else
  begin
    P := 100;
    Branched := False;
    for B := 1 to MaxBranch do
    begin
      if Random(P) < Branches[Frame, B].Precent then
      begin
        Result := Branches[Frame, B].Frame;
        Branched := True;
        Break;
      end
      else
        Dec(P, Branches[Frame, B].Precent);
    end;
    if not Branched then
    begin
      if Frame < FrameCount - 1 then
        Result := Frame + 1
      else
        Completed := True;
    end;
  end;
  if (Delays[Result] = 0) and (Result = FrameCount - 1) then
    Completed := True;
end;

procedure TAssistantEngine.Terminate;
begin
  inherited Terminate;
  Sequencing := False;
  SetEvent(SequenceEvent);
end;

procedure TAssistantEngine.Execute;
var
  DelayTime: DWORD;
  NextFrame: Integer;
begin
  NextFrame := -1;
  while not Terminated do
  begin
    WaitForSingleObject(SequenceEvent, INFINITE);
    if not Terminated then
    begin
      if NextFrame < 0 then
      begin
        Completed := False;
        if Assigned(fOnSequenceStart) then
          fOnSequenceStart(Self);
      end;
      if Delays[CurrentFrame] > 0 then
        DoFrameChange;
      if Speed > 0 then
        DelayTime := (1000 * Delays[CurrentFrame]) div Speed
      else
        DelayTime := INFINITE;
      NextFrame := FindNextFrame(CurrentFrame, UseReturnPath);
      if (WaitForSingleObject(BreakEvent, DelayTime) <> WAIT_TIMEOUT) or Completed then
      begin
        EnterCriticalSection(CS);
        try
          SetEvent(BreakEvent);
          ResetEvent(SequenceEvent);
        finally
          LeaveCriticalSection(CS);
        end;
        if Completed then
          CurrentFrame := FindNextFrame(CurrentFrame, not UseReturnPath)
        else
        begin
          CurrentFrame := NextFrame;
          PlaySound(nil, Actor.Instance, 0);
        end;
        NextFrame := -1;
        if not Terminated and Assigned(fOnSequenceStop) then
          fOnSequenceStop(Self);
      end
      else
        CurrentFrame := NextFrame;
    end;
  end;
end;

end.

