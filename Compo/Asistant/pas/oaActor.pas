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

unit oaActor;

interface

uses
  Windows, Classes, Dialogs, SysUtils, Graphics, SyncObjs, oaTypes;

type

  EActorError = class(Exception);

  TAssistantActor = class(TObject)
  private
    fInstance: THandle;
    fPalette: HPalette;
    fTransparentColor: TColor;
    fLibraryName: String;
    fActorInfo: PActorInfo;
    fOnLoad: TNotifyEvent;
    fOnUnload: TNotifyEvent;
    CS: TRTLCriticalSection;
    ActionCount: array[TActorAction] of Word;
    procedure LoadActorLibrary;
    procedure FreeActorLibrary;
    function InitializeActor: Boolean;
    procedure SetLibraryName(const Value: String);
    function GetEmpty: Boolean;
    function GetActorName: String;
    function GetWidth: Word;
    function GetHeight: Word;
    function GetBlindColorEntry: Byte;
    function GetAnimationCount: Word;
    function GetAnimations(Index: Word): TAnimation;
    function GetAnimationInfo(Index: Word): PAnimationInfo;
    function GetActionAnimationCount(Index: TActorAction): Word;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    function VersionInfo(const ValueName: String): String;
    function IndexOfAction(Action: TActorAction; Level: Word): Word;
    function IndexOfName(const Name: String): Word;
    property Empty: Boolean read GetEmpty;
    property Instance: THandle read fInstance;
    property Width: Word read GetWidth;
    property Height: Word read GetHeight;
    property Palette: HPalette read fPalette;
    property BlindColorEntry: Byte read GetBlindColorEntry;
    property TransparentColor: TColor read fTransparentColor;
    property ActorName: String read GetActorName;
    property AnimationCount: Word read GetAnimationCount;
    property Animations[Index: Word]: TAnimation read GetAnimations;
    property AnimationInfo[Index: Word]: PAnimationInfo read GetAnimationInfo;
    property ActionAnimationCount[Index: TActorAction]: Word read GetActionAnimationCount;
    property LibraryName: String read fLibraryName write SetLibraryName;
    property OnLoad: TNotifyEvent read fOnLoad write fOnLoad;
    property OnUnload: TNotifyEvent read fOnUnload write fOnUnload;
  end;

implementation

const
  SBadLibrary = 'File is not a valid actor library';
  SNoLibrary  = 'File not found';

procedure RaiseActorError(const LibraryName, MsgText: String);
begin
  raise EActorError.Create(LibraryName + #13#10 + MsgText);
end;

constructor TAssistantActor.Create;
begin
  inherited Create;
  InitializeCriticalSection(CS);
end;

destructor TAssistantActor.Destroy;
begin
  FreeActorLibrary;
  DeleteCriticalSection(CS);
  inherited Destroy;
end;

procedure TAssistantActor.LoadActorLibrary;
begin
  if fInstance = 0 then
  begin
    if FileExists(LibraryName) then
    begin
      EnterCriticalSection(CS);
      try
        fInstance := LoadLibrary(PChar(LibraryName));
        if (fInstance <> 0) and not InitializeActor then
        begin
          FreeLibrary(fInstance);
          fInstance := 0;
        end;
      finally
        LeaveCriticalSection(CS);
      end;
      if fInstance = 0 then
        RaiseActorError(LibraryName, SBadLibrary)
      else if Assigned(fOnLoad) then
        fOnLoad(Self);
    end
    else
      RaiseActorError(LibraryName, SNoLibrary);
  end;
end;

procedure TAssistantActor.FreeActorLibrary;
begin
  if fInstance <> 0 then
  begin
    if Assigned(fOnUnload) then
      fOnUnload(Self);
    EnterCriticalSection(CS);
    try
      if fPalette <> 0 then
      begin
        DeleteObject(fPalette);
        fPalette := 0;
      end;
      fActorInfo := nil;
      FreeLibrary(fInstance);
      fInstance := 0;
    finally
      LeaveCriticalSection(CS);
    end;
  end;
end;

function TAssistantActor.GetEmpty: boolean;
begin
  Result := (fInstance = 0);
end;

procedure TAssistantActor.SetLibraryName(const Value: String);
begin
  if CompareText(LibraryName, Value) <> 0 then
  begin
    if LibraryName <> '' then
      FreeActorLibrary;
    fLibraryName := Value;
    if LibraryName <> '' then
      try
        LoadActorLibrary;
      except
        fLibraryName := '';
        raise;
      end;
  end;
end;

function TAssistantActor.InitializeActor: Boolean;

  // NOTE: The parameter has not defined as Const because without creating a
  // copy of the palette entries, Windows 98 raises an exception!
  function CreatePaletteMax({const} LogPalette: TMaxLogPalette): HPALETTE;
  begin
    Result := CreatePalette(PLogPalette(@LogPalette)^);
  end;

var
  GetActorInfo: function: Pointer; stdcall;
  Action: TActorAction;
  ValidLib: Boolean;
  I: Word;
begin
  Result := False;
  if fInstance <> 0 then
  begin
    @GetActorInfo := GetProcAddress(fInstance, 'GetActorInfo');
    if Assigned(GetActorInfo) then
    begin
      try
        fActorInfo := PActorInfo(GetActorInfo);
        ValidLib := Assigned(fActorInfo) and (fActorInfo^.FormatID = 200) and
                   (fActorInfo^.AnimationCount > 0);
      except
        Exit;
      end;
      if ValidLib then
      begin
        for Action := Low(TActorAction) to High(TActorAction) do
          ActionCount[Action] := 0;
        for I := fActorInfo^.AnimationCount downto 1 do
          for Action := Low(TActorAction) to High(TActorAction) do
            if Action in fActorInfo^.Animations[I].Actions then
              Inc(ActionCount[Action]);
        fPalette := CreatePaletteMax(fActorInfo^.Palette);
        with fActorInfo^.Palette.palPalEntry[fActorInfo^.BlindColorEntry] do
          fTransparentColor := TColor(RGB(peRed, peGreen, peBlue));
        Result := True;
      end;
    end;
  end;
end;

function TAssistantActor.VersionInfo(const ValueName: String): String;
var
  Trans: PDWord;
  VerInfoSize, ValSize, Dummy: DWord;
  VerInfo, Value: Pointer;
  TransStr, InfoStr: String;
begin
  Result := '';
  if fInstance <> 0 then
  begin
    VerInfoSize := GetFileVersioninfoSize(PChar(LibraryName), Dummy);
    if VerInfoSize <> 0 then
    begin
      GetMem(VerInfo, VerInfoSize);
      try
        if GetFileVersionInfo(PChar(LibraryName), Dummy, VerInfoSize, VerInfo) then
        begin
          VerQueryValue(VerInfo, '\VarFileInfo\Translation', Pointer(Trans), valSize);
          TransStr := IntToHex(LoWord(Trans^), 4) + IntToHex(HiWord(Trans^), 4);
          if CompareText(ValueName, 'Language') <> 0 then
          begin
            InfoStr := '\StringFileInfo\' + TransStr + '\' + ValueName;
            if VerQueryValue(VerInfo, PChar(InfoStr), Value, ValSize) then
              SetString(Result, PChar(Value), ValSize);
          end
          else
          begin
            SetLength(Result, 256);
            VerLanguageName(LoWord(Trans^), PChar(Result), 256);
            SetLength(Result, StrLen(PChar(Result)));
          end;
        end;
      finally
        FreeMem(VerInfo);
      end;
    end;
  end;
end;

function TAssistantActor.GetActorName: String;
begin
  Result := '';
  if Assigned(fActorInfo) then
    Result := String(fActorInfo^.ActorName);
end;

function TAssistantActor.GetAnimationCount: Word;
begin
  Result := 0;
  if Assigned(fActorInfo) then
    Result := fActorInfo^.AnimationCount;
end;

function TAssistantActor.GetWidth: Word;
begin
  Result := 0;
  if Assigned(fActorInfo) then
    Result := fActorInfo^.ScreenWidth;
end;

function TAssistantActor.GetHeight: Word;
begin
  Result := 0;
  if Assigned(fActorInfo) then
    Result := fActorInfo^.ScreenHeight;
end;

function TAssistantActor.GetBlindColorEntry: Byte;
begin
  Result := 0;
  if Assigned(fActorInfo) then
    Result := fActorInfo^.BlindColorEntry;
end;

function TAssistantActor.GetActionAnimationCount(Index: TActorAction): Word;
begin
  Result := 0;
  if Assigned(fActorInfo) and (Index in [Low(TActorAction)..High(TActorAction)]) then
    Result := ActionCount[Index];
end;

function TAssistantActor.GetAnimationInfo(Index: Word): PAnimationInfo;
begin
  Result := nil;
  if Assigned(fActorInfo) and (Index >= 1) and (Index <= fActorInfo^.AnimationCount) then
    Result := @(fActorInfo^.Animations[Index]);
end;

function TAssistantActor.GetAnimations(Index: Word): TAnimation;
var
  RetIndex: Word;
begin
  FillChar(Result, SizeOf(TAnimation), 0);
  if Assigned(fActorInfo) and (Index >= 1) and (Index <= fActorInfo^.AnimationCount) then
  begin
    Result.Name := fActorInfo^.Animations[Index].Name;
    Result.Actions := fActorInfo^.Animations[Index].Actions;
    Result.ExitType := fActorInfo^.Animations[Index].ExitType;
    if Result.ExitType = etAnimation then
      RetIndex := fActorInfo^.Animations[Index].ReturnIndex
    else
      RetIndex := 0;
    if (RetIndex >= 1) and (RetIndex <= fActorInfo^.AnimationCount) then
      Result.ReturnName := fActorInfo^.Animations[RetIndex].Name
    else
      Result.ReturnName := '';
  end;
end;

function TAssistantActor.IndexOfAction(Action: TActorAction; Level: Word): Word;
var
  FoundLevel, I: Word;
begin
  Result := 0;
  if Assigned(fActorInfo) and (Action <> aaNone) and (ActionCount[Action] > 0) then
  begin
    if Level = 0 then
      Level := Random(ActionCount[Action]) + 1
    else if Level > ActionCount[Action] then
      Level := Level mod ActionCount[Action];
    FoundLevel := 0;
    for I := 1 to fActorInfo^.AnimationCount do
      if Action in fActorInfo^.Animations[I].Actions then
      begin
         Result := I;
         Inc(FoundLevel);
         if FoundLevel >= Level then Exit;
      end;
  end;
end;

function TAssistantActor.IndexOfName(const Name: String): Word;
var
  I: Word;
begin
  Result := 0;
  if Assigned(fActorInfo) and (Name <> '') then
  begin
    for I := fActorInfo^.AnimationCount downto 1 do
      if CompareText(String(fActorInfo^.Animations[I].Name), Name) = 0 then
      begin
        Result := I;
        Exit;
      end;
  end;
end;

procedure TAssistantActor.Lock;
begin
  EnterCriticalSection(CS);
end;

procedure TAssistantActor.Unlock;
begin
  LeaveCriticalSection(CS);
end;

end.
