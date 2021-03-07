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

unit oaDirect;

interface

uses
  Windows, Messages, Classes, Graphics, oaEngine, oaActor, oaTypes;

type

  TSpecialNames = class;
  TRequestQueue = class;

  TAssistantDirector = class(TThread)
  private
    State3List: TSpecialNames;
    Requests: TRequestQueue;
    RunningID: TRequestID;
    StoppedID: TRequestID;
    IdleID: TRequestID;
    IdleTimeout: DWORD;
    IdleRetryCount: Byte;
    ActiveEvent: THandle;
    IdleEvent: THandle;
    SuspendCount: Integer;
    fActor: TAssistantActor;
    fEngine: TAssistantEngine;
    fEnabled: Boolean;
    fAutoIdle: Boolean;
    fIdleLevel: TIdleLevel;
    fMinIdleTime: Word;
    fMaxIdleTime: Word;
    fOnPlayStart: TPlayEvent;
    fOnPlayStop: TPlayEvent;
    fOnIdle: TIdleEvent;
    procedure SetEnabled(Value: Boolean);
    procedure SetAutoIdle(Value: Boolean);
    procedure SetIdleLevel(Value: TIdleLevel);
    procedure ActorLoaded(Sender: TObject);
    procedure ActorUnloaded(Sender: TObject);
    procedure SequenceStarted(Sender: TObject);
    procedure SequenceStopped(Sender: TObject);
    procedure AdjustIdleTimeout;
    procedure Initialize;
    procedure Finalize;
    procedure PlayRequest;
    procedure PlayIdle;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Terminate;
    function PlayIndex(Index: Word): TRequestID;
    function PlayName(const Name: String): TRequestID;
    function PlayAction(Action: TActorAction): TRequestID;
    function PlayRandom(const ActionList: array of TActorAction): TRequestID;
    procedure Stop(RequestID: TRequestID);
    procedure StopAll(Cut: Boolean);
    procedure SuspendPlay;
    procedure ResumePlay;
    function Playing: Boolean;
    function PlayingID: TRequestID;
    function PlayIdling: Boolean;
    function IsSuspended: Boolean;
    function WaitForRequest(RequestID: TRequestID): Boolean;
    function IsValidRequest(RequestID: TRequestID): Boolean;
    function IsPlaying(Actions: TActorActions): Boolean;
    function IsJustPlayed(Actions: TActorActions): Boolean;
    function ActionOfOrientation(Kind: TOrientedAction;
      const Origin, Target: TPoint): TActorAction;
    property Actor: TAssistantActor read fActor;
    property Engine: TAssistantEngine read fEngine;
    property AutoIdle: Boolean read fAutoIdle write SetAutoIdle;
    property IdleLevel: TIdleLevel read fIdleLevel write SetIdleLevel;
    property MinIdleTime: Word read fMinIdleTime write fMinIdleTime;
    property MaxIdleTime: Word read fMaxIdleTime write fMaxIdleTime;
    property Enabled: Boolean read fEnabled write SetEnabled;
    property OnPlayStart: TPlayEvent read fOnPlayStart write fOnPlayStart;
    property OnPlayStop: TPlayEvent read fOnPlayStop write fOnPlayStop;
    property OnIdle: TIdleEvent read fOnIdle write fOnIdle;
  end;

  TRequestQueue = class(TList)
  private
    fEnabled: Boolean;
    LastID: Word;
    NoEmptyEvent: THandle;
    CS: TRTLCriticalSection;
    procedure SetEnabled(Value: Boolean);
    function GetRequests(Index: Integer): TRequestID;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    procedure Clear; {$IFDEF COMPILER4_UP} override; {$ENDIF}
    function First: TRequestID;
    function Last: TRequestID;
    function Get: TRequestID;
    function Put(AnimationIndex: Word): TRequestID;
    procedure Cancel(RequestID: TRequestID);
    function Query(RequestID: TRequestID): Boolean;
    function WaitFor(Timeout: DWORD): Boolean;
    property Enabled: Boolean read fEnabled write SetEnabled;
    property Requests[Index: Integer]: TRequestID read GetRequests; default;
  end;

  TSpecialNames = class(TStringList)
  public
    constructor Create;
    procedure Reindex(Actor: TAssistantActor);
    function IndexOfAnimation(AnimIndex: Word): Integer;
    function AnimationOf(Index: Integer): Word;
    function ReturnIndexOf(ID: TRequestID): Integer;
    function NoConfilict(Index: Integer; ID: TRequestID): Boolean;
  end;

function WaitForSyncObject(SyncObject: THandle; Timeout: DWORD): DWORD;

implementation

function WaitForSyncObject(SyncObject: THandle; Timeout: DWORD): DWORD;
const
  EVENTMASK = QS_PAINT or QS_TIMER or QS_SENDMESSAGE or QS_POSTMESSAGE;
var
  Msg: TMsg;
  StartTime: DWORD;
  EllapsedTime: DWORD;
  Handle: THandle;
begin
  Handle := SyncObject;
  if (SyncObject = GetCurrentThread) or (SyncObject = GetCurrentProcess) then
    DuplicateHandle(GetCurrentProcess, SyncObject, GetCurrentProcess, @Handle, SYNCHRONIZE, False, 0);
  try
    repeat
      StartTime := GetTickCount;
      Result := MsgWaitForMultipleObjects(1, Handle, False, Timeout, EVENTMASK);
      if Result = WAIT_OBJECT_0 + 1 then
      begin
        while PeekMessage(Msg, 0, 0, 0, PM_REMOVE) do
        begin
          if ((Msg.message < WM_KEYFIRST) or (Msg.message > WM_KEYLAST)) and
             ((Msg.message < WM_MOUSEFIRST) or (Msg.message > WM_MOUSELAST)) then
          begin
            TranslateMessage(Msg);
            DispatchMessage(Msg);
            if Msg.message = WM_QUIT then Exit;
          end;
        end;
        if Timeout <> INFINITE then
        begin
          EllapsedTime := GetTickCount - StartTime;
          if EllapsedTime < Timeout then
            Dec(Timeout, EllapsedTime)
          else
            Timeout := 0;
        end;
      end;
    until Result <> WAIT_OBJECT_0 + 1;
  finally
    if SyncObject <> Handle then
      CloseHandle(Handle);
  end;
end;

{ TSpecialNames }

constructor TSpecialNames.Create;
begin
  inherited Create;
  Append('GetAttention');
  Append('GetAttentionContinued');
  Append('GetAttentionReturn');
  Append('Read');
  Append('ReadContinued');
  Append('ReadReturn');
  Append('Write');
  Append('WriteContinued');
  Append('WriteReturn');
end;

procedure TSpecialNames.Reindex(Actor: TAssistantActor);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Objects[I] := TObject(Actor.IndexOfName(Strings[I]));
end;

function TSpecialNames.IndexOfAnimation(AnimIndex: Word): Integer;
begin
  Result := IndexOfObject(TObject(AnimIndex));
end;

function TSpecialNames.AnimationOf(Index: Integer): Word;
begin
  if (Index >= 0) and (Index < Count) then
    Result := Word(Objects[Index])
  else
    Result := 0;
end;

function TSpecialNames.ReturnIndexOf(ID: TRequestID): Integer;
var
  Index: Integer;
begin
  Index := IndexOfObject(TObject(LoWord(ID)));
  if (Index >= 0) and ((Index + 1) mod 3 <> 0) then
    Result := ((Index div 3) * 3) + 2
  else
    Result := -1;
end;

function TSpecialNames.NoConfilict(Index: Integer; ID: TRequestID): Boolean;
var
  TestIndex: Integer;
begin
  TestIndex := IndexOfObject(TObject(LoWord(ID)));
  Result := (TestIndex < 0) or ((TestIndex mod 3) = 0) or
            ((TestIndex div 3) <> (Index div 3));
end;

{ TRequestQueue }

constructor TRequestQueue.Create;
begin
  inherited Create;
  InitializeCriticalSection(CS);
  NoEmptyEvent := CreateEvent(nil, True, False, nil);
  fEnabled := True;
end;

destructor TRequestQueue.Destroy;
begin
  inherited Destroy;
  CloseHandle(NoEmptyEvent);
  DeleteCriticalSection(CS);
end;

procedure TRequestQueue.Lock;
begin
  EnterCriticalSection(CS);
end;

procedure TRequestQueue.Unlock;
begin
  LeaveCriticalSection(CS);
end;

procedure TRequestQueue.Clear;
begin
  EnterCriticalSection(CS);
  try
    ResetEvent(NoEmptyEvent);
    inherited Clear;
  finally
    LeaveCriticalSection(CS);
  end;
end;

function TRequestQueue.First: TRequestID;
begin
  EnterCriticalSection(CS);
  try
    if Count > 0 then
      Result := Requests[0]
    else
      Result := 0;
  finally
    LeaveCriticalSection(CS);
  end;
end;

function TRequestQueue.Last: TRequestID;
begin
  EnterCriticalSection(CS);
  try
    if Count > 0 then
      Result := Requests[Count - 1]
    else
      Result := 0;
  finally
    LeaveCriticalSection(CS);
  end;
end;

function TRequestQueue.Get: TRequestID;
begin
  EnterCriticalSection(CS);
  try
    if Count > 0 then
    begin
      Result := Requests[0];
      Delete(0);
      if Count = 0 then ResetEvent(NoEmptyEvent);
    end
    else
      Result := 0;
  finally
    LeaveCriticalSection(CS);
  end;
end;

function TRequestQueue.Put(AnimationIndex: Word): TRequestID;
begin
  Result := 0;
  if Enabled and (AnimationIndex > 0) then
  begin
    EnterCriticalSection(CS);
    try
      Inc(LastID);
      Result := (DWORD(LastID) shl 16) or AnimationIndex;
      if Add(Pointer(Result)) >= 0 then
        SetEvent(NoEmptyEvent)
      else
        Result := 0;
    finally
      LeaveCriticalSection(CS);
    end;
  end;
end;

procedure TRequestQueue.Cancel(RequestID: TRequestID);
var
  Index: Integer;
begin
  EnterCriticalSection(CS);
  try
    Index := IndexOf(Pointer(RequestID));
    if Index >= 0 then Delete(Index);
    if Count = 0 then ResetEvent(NoEmptyEvent);
  finally
    LeaveCriticalSection(CS);
  end;
end;

function TRequestQueue.Query(RequestID: TRequestID): Boolean;
begin
  EnterCriticalSection(CS);
  try
    Result := (IndexOf(Pointer(RequestID)) >= 0);
  finally
    LeaveCriticalSection(CS);
  end;
end;

function TRequestQueue.WaitFor(Timeout: DWORD): Boolean;
begin
  Result := (WaitForSingleObject(NoEmptyEvent, Timeout) <> WAIT_TIMEOUT);
end;

procedure TRequestQueue.SetEnabled(Value: Boolean);
begin
  if Enabled <> Value then
  begin
    EnterCriticalSection(CS);
    try
      fEnabled := Value;
      if Enabled then
        ResetEvent(NoEmptyEvent)
      else
      begin
        inherited Clear;
        SetEvent(NoEmptyEvent);
      end;
    finally
      LeaveCriticalSection(CS);
    end;
  end;
end;

function TRequestQueue.GetRequests(Index: Integer): TRequestID;
begin
  EnterCriticalSection(CS);
  try
    if (Index >= 0) and (Index < Count) then
      Result := TRequestID(inherited Get(Index))
    else
      Result := 0;
  finally
    LeaveCriticalSection(CS);
  end;
end;

{ TAssistantDirector }

constructor TAssistantDirector.Create;
begin
  inherited Create(True);
  ActiveEvent := CreateEvent(nil, True, False, nil);
  IdleEvent := CreateEvent(nil, True, True, nil);
  State3List := TSpecialNames.Create;
  Requests := TRequestQueue.Create;
  Requests.Enabled := False;
  fActor := TAssistantActor.Create;
  fActor.OnLoad := ActorLoaded;
  fActor.OnUnload := ActorUnloaded;
  fEngine := TAssistantEngine.Create(Actor);
  fEngine.OnSequenceStart := SequenceStarted;
  fEngine.OnSequenceStop := SequenceStopped;
  fAutoIdle := True;
  fMinIdleTime := 1000;
  fMaxIdleTime := 8000;
  IdleLevel := Low(TIdleLevel);
  Randomize;
  Resume;
end;

destructor TAssistantDirector.Destroy;
begin
  fActor.Free;
  fEngine.Free;
  Requests.Free;
  State3List.Free;
  CloseHandle(IdleEvent);
  CloseHandle(ActiveEvent);
  inherited Destroy;
end;

procedure TAssistantDirector.Terminate;
begin
  SuspendPlay;
  Engine.Terminate;
  Engine.WaitFor;
  inherited Terminate;
  SetEvent(IdleEvent);
  Enabled := False;
  SetEvent(ActiveEvent);
end;

procedure TAssistantDirector.Execute;
var
  AnyRequest: Boolean;
begin
  while not Terminated do
  begin
    WaitForSingleObject(ActiveEvent, INFINITE);
    if Enabled then
    begin
      AnyRequest := Requests.WaitFor(IdleTimeout);
      if Requests.Enabled and (SuspendCount = 0) then
      begin
        if AnyRequest then
        begin
          if (RunningID <> 0) and (RunningID = IdleID) then
            Engine.Sequencing := False;
          WaitForSingleObject(IdleEvent, INFINITE);
          if Requests.Enabled and (SuspendCount = 0) then
            PlayRequest;
          if (RunningID = 0) or (RunningID <> IdleID) then
            WaitForSingleObject(IdleEvent, INFINITE);
        end
        else if WaitForSingleObject(IdleEvent, 0) <> WAIT_TIMEOUT then
          PlayIdle;
      end;
    end;
  end;
end;

procedure TAssistantDirector.PlayRequest;

  function Play: Boolean;
  begin
    Result := False;
    RunningID := Requests.Get;
    if RunningID <> 0 then
    begin
      if Engine.LoadSequence(LoWord(RunningID)) then
      begin
        if RunningID <> IdleID then
          IdleLevel := Low(TIdleLevel);
        Engine.Sequencing := True;
        Result := True;
      end
      else
        RunningID := 0;
    end;
  end;

  function PlayReturn: Boolean;
  begin
    Result := False;
    if Engine.PrepareToReturn then
    begin
      Engine.Sequencing := True;
      Result := True;
    end;
  end;

  function PlayReturn3: Boolean;
  var
    Return3Index: Integer;
  begin
    Result := False;
    Return3Index := State3List.ReturnIndexOf(StoppedID);
    if (Return3Index >= 0) and
       State3List.NoConfilict(Return3Index, Requests.First) and
       Engine.LoadSequence(State3List.AnimationOf(Return3Index)) then
    begin
      Engine.Sequencing := True;
      Result := True;
    end;
  end;

begin
  ResetEvent(IdleEvent);
  if ((StoppedID = 0) or not (PlayReturn or PlayReturn3)) and not Play then
    SetEvent(IdleEvent);
end;

procedure TAssistantDirector.PlayIdle;
var
  Handled: Boolean;
  ThisLevel: Integer;
begin
  Dec(IdleRetryCount);
  if (IdleRetryCount = 0) and (IdleLevel < High(TIdleLevel)) then
    IdleLevel := Succ(IdleLevel)
  else
    AdjustIdleTimeout;
  Handled := False;
  if Assigned(fOnIdle) then
  begin
    ThisLevel := Ord(IdleLevel) - Ord(Low(TIdleLevel)) + 1;
    try
      fOnIdle(Self, ThisLevel, Handled);
    finally
      fIdleLevel := TIdleLevel(Ord(Low(TIdleLevel)) + ThisLevel - 1);
    end;
  end;
  if not Handled then
    IdleID := Requests.Put(Actor.IndexOfAction(IdleLevel, 0))
  else
    IdleID := Requests.First;
end;

procedure TAssistantDirector.SetEnabled(Value: Boolean);
begin
  if Enabled <> Value then
  begin
    fEnabled := Value;
    if not Actor.Empty then
      if Enabled then
        Initialize
      else
        Finalize;
  end;
end;

procedure TAssistantDirector.SetAutoIdle(Value: Boolean);
begin
  if AutoIdle <> Value then
  begin
    fAutoIdle := Value;
    SuspendPlay;
    try
      IdleLevel := Low(TIdleLevel);
      AdjustIdleTimeout;
      if Requests.Enabled and (Requests.Count = 0) then
      begin
        Requests.Enabled := False;
        Sleep(0);
        Requests.Enabled := True;
      end;
    finally
      ResumePlay;
    end;
  end;
end;

procedure TAssistantDirector.SetIdleLevel(Value: TIdleLevel);
var
  R: Integer;
begin
  if (IdleLevel <> Value) and (Value in [Low(TIdleLevel)..High(TIdleLevel)]) then
  begin
    if (IdleLevel > Low(TIdleLevel)) and (IdleLevel > Value) and
       (IdleID <> 0) and (GetCurrentThreadID <> ThreadID)
    then
      Stop(IdleID);
    fIdleLevel := Value;
    AdjustIdleTimeout;
  end;
  R := 5 * (Ord(High(TIdleLevel)) - Ord(IdleLevel) + 1);
  IdleRetryCount := R + Random(R);
end;

procedure TAssistantDirector.Initialize;
begin
  IdleLevel := Low(TIdleLevel);
  Engine.Initialize;
  Requests.Enabled := True;
  SetEvent(ActiveEvent);
end;

procedure TAssistantDirector.Finalize;
begin
  ResetEvent(ActiveEvent);
  Requests.Enabled := False;
  Requests.Clear;
  Engine.Sequencing := False;
  WaitForSyncObject(IdleEvent, INFINITE);
  Engine.Finalize;
  RunningID := 0;
  StoppedID := 0;
  IdleID := 0;
end;

procedure TAssistantDirector.AdjustIdleTimeout;
begin
  if AutoIdle then
    IdleTimeout := MinIdleTime + Random(MaxIdleTime - MinIdleTime + 1)
  else
    IdleTimeout := INFINITE;
end;

procedure TAssistantDirector.ActorLoaded(Sender: TObject);
begin
  State3List.Reindex(Actor);
  if Enabled then Initialize;
end;

procedure TAssistantDirector.ActorUnloaded(Sender: TObject);
begin
  if Enabled then Finalize;
end;

procedure TAssistantDirector.SequenceStarted(Sender: TObject);
begin
  if (RunningID <> 0) and (RunningID <> IdleID) and Assigned(fOnPlayStart) then
    fOnPlayStart(Self, RunningID);
end;

procedure TAssistantDirector.SequenceStopped(Sender: TObject);
begin
  try
    StoppedID := RunningID;
    RunningID := 0;
    if StoppedID = IdleID then
      IdleID := 0
    else if (StoppedID <> 0) and Assigned(fOnPlayStop) then
      fOnPlayStop(Self, StoppedID);
  finally
    SetEvent(IdleEvent);
  end;
end;

function TAssistantDirector.IsValidRequest(RequestID: TRequestID): Boolean;
begin
  Result := (RequestID <> 0) and (Requests.Query(RequestID) or
   ((RequestID = RunningID) and (WaitForSingleObject(IdleEvent, 0) = WAIT_TIMEOUT)));
end;

function TAssistantDirector.PlayIndex(Index: Word): TRequestID;
begin
  Result := Requests.Put(Index);
end;

function TAssistantDirector.PlayName(const Name: String): TRequestID;
begin
  Result := PlayIndex(Actor.IndexOfName(Name));
end;

function TAssistantDirector.PlayAction(Action: TActorAction): TRequestID;
begin
  Result := PlayIndex(Actor.IndexOfAction(Action, 0));
end;

function TAssistantDirector.PlayRandom(const ActionList: array of TActorAction): TRequestID;
type
  PActorActionArray = ^TActorActionArray;
  TActorActionArray = array[0..MaxShort] of TActorAction;
var
  List: PActorActionArray;
  Count, Index: Integer;
begin
  Result := 0;
  if Requests.Enabled then
  begin
    Count := High(ActionList) + 1;
    GetMem(List, Count * SizeOf(TActorAction));
    try
      for Index := 0 to Count - 1 do
        List[Index] := ActionList[Index];
      while (Count > 0) and (Result = 0) do
      begin
        Index := Random(Count);
        if List[Index] <> aaNone then
        begin
          Result := PlayAction(List[Index]);
          if Result = 0 then
          begin
            Dec(Count);
            for Index := Index to Count - 1 do
              List[Index] := List[Index + 1];
          end;
        end
        else
          Break;
      end;
    finally
      FreeMem(List);
    end;
  end;
end;

procedure TAssistantDirector.Stop(RequestID: TRequestID);
begin
  SuspendPlay;
  try
    if RequestID <> 0 then
    begin
      if RunningID = RequestID then
      begin
        Engine.Sequencing := False;
        WaitForSyncObject(IdleEvent, INFINITE);
        if Requests.Count = 0 then
          PlayAction(aaRestPose);
      end
      else
        Requests.Cancel(RequestID);
    end;
  finally
    ResumePlay;
  end;
end;

procedure TAssistantDirector.StopAll(Cut: Boolean);
begin
  SuspendPlay;
  try
    Requests.Clear;
    if RunningID <> 0 then
    begin
      Engine.Sequencing := False;
      WaitForSyncObject(IdleEvent, INFINITE);
      if Cut then
        StoppedID := 0
      else
        PlayAction(aaRestPose);
    end;
  finally
    ResumePlay;
  end;
end;

function TAssistantDirector.WaitForRequest(RequestID: TRequestID): Boolean;
begin
  Result := True;
  while Result and IsValidRequest(RequestID) do
    if (RunningID = 0) or not Engine.SequenceIsInfinite then
      WaitForSyncObject(IdleEvent, INFINITE)
    else
      Result := False;
end;

function TAssistantDirector.Playing: Boolean;
begin
  Result := (RunningID <> 0) or (Requests.Count > 0);
end;

function TAssistantDirector.PlayingID: TRequestID;
begin
  Result := RunningID;
end;

function TAssistantDirector.PlayIdling: Boolean;
begin
  Result := IsValidRequest(IdleID);
end;

function TAssistantDirector.IsPlaying(Actions: TActorActions): Boolean;
var
  Index: Integer;
  AnimInfo: PAnimationInfo;
begin
  Result := False;
  if RunningID <> 0 then
  begin
    if Actions = [] then
      Result := True
    else
    begin
      AnimInfo := Actor.AnimationInfo[LoWord(RunningID)];
      if (AnimInfo <> nil) and (AnimInfo^.Actions * Actions <> []) then
        Result := True;
    end;
  end;
  if not Result then
  begin
    if (Actions = []) and (Requests.Count <> 0) then
      Result := True
    else
    begin
      for Index := Requests.Count - 1 downto 0 do
      begin
        AnimInfo := Actor.AnimationInfo[LoWord(Requests[Index])];
        if (AnimInfo <> nil) and (AnimInfo^.Actions * Actions <> []) then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

function TAssistantDirector.IsJustPlayed(Actions: TActorActions): Boolean;
var
  AnimInfo: PAnimationInfo;
begin
  Result := False;
  if StoppedID <> 0 then
  begin
    if Actions = [] then
      Result := True
    else
    begin
      AnimInfo := Actor.AnimationInfo[LoWord(StoppedID)];
      if (AnimInfo <> nil) and (AnimInfo^.Actions * Actions <> []) then
        Result := True;
    end;
  end;
end;

procedure TAssistantDirector.ResumePlay;
begin
  Dec(SuspendCount);
end;

procedure TAssistantDirector.SuspendPlay;
begin
  Inc(SuspendCount);
end;

function TAssistantDirector.IsSuspended: Boolean;
begin
  Result := (SuspendCount <> 0);
end;

function TAssistantDirector.ActionOfOrientation(Kind: TOrientedAction;
  const Origin, Target: TPoint): TActorAction;
type
  TDirX = (xNone, Left, Right);
  TDirY = (yNone, Down, Up);
const
  Actions: array[TOrientedAction, TDirX, TDirY] of TActorAction = (
    // oaGesture
    ((aaNone, aaGestureDown, aaGestureUp),
     (aaGestureLeft, aaGestureDownLeft, aaGestureUpLeft),
     (aaGestureRight, aaGestureDownRight, aaGestureUpRight)),
    // oaGlance
    ((aaNone, aaGlanceDown, aaGlanceUp),
     (aaGlanceLeft, aaGlanceDownLeft, aaGlanceUpLeft),
     (aaGlanceRight, aaGlanceDownRight, aaGlanceUpRight)),
    // oaLook
    ((aaNone, aaLookDown, aaLookUp),
     (aaLookLeft, aaLookDownLeft, aaLookUpLeft),
     (aaLookRight, aaLookDownRight, aaLookUpRight)),
    // oaMove
    ((aaNone, aaMoveDown, aaMoveUp),
     (aaMoveLeft, aaMoveDownLeft, aaMoveUpLeft),
     (aaMoveRight, aaMoveDownRight, aaMoveUpRight)));
var
  DirX: TDirX;
  DirY: TDirY;
begin
  if (Abs(Origin.x - Target.x) > (Actor.Width div 2)) or (Kind = oaMove) then
    if Origin.x > Target.x then
      DirX := Right
    else
      DirX := Left
  else
    DirX := xNone;
  if (Abs(Origin.y - Target.y) > (Actor.Height div 2)) or (Kind = oaMove) then
    if Origin.y > Target.y then
      DirY := Up
    else
      DirY := Down
  else
    DirY := yNone;
  Result := Actions[Kind, DirX, DirY];
  if Actor.IndexOfAction(Result, 0) = 0 then
  begin
    if Abs(Origin.x - Target.x) < Abs(Origin.y - Target.y) then
      DirX := xNone
    else
      DirY := yNone;
    Result := Actions[Kind, DirX, DirY];
  end;
end;

end.
