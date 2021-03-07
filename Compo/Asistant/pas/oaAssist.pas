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

unit oaAssist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, oaDirect, oaStage, oaBaloon, oaTypes;

type

  {$IFNDEF COMPILER4_UP}
  TBiDiMode = (bdLeftToRight, bdRightToLeft, bdRightToLeftNoAlign,
    bdRightToLeftReadingOnly);
  {$ENDIF}

  TAssistant = class(TComponent)
  private
    Stage: TAssistantStage;
    Director: TAssistantDirector;
    DefaultDialog: TAssistantBalloon;
    Dialog: TAssistantBalloon;
    fAbout: TAboutMe;
    fCustomDialog: TAssistantBalloon;
    fDockSite: TWinControl;
    fHintBulb: Boolean;
    fFastShowHide: Boolean;
    fVisible: Boolean;
    fMoveStep: Byte;
    fBlockingMove: Boolean;
    fDragging: Boolean;
    MoveCount: Integer;
    NoMoveEvent: THandle;
    MoveCS: TRTLCriticalSection;
    MoveAction: TActorAction;
    MoveDest, PendedMoveDest: TPoint;
    CancellingMove: Boolean;
    ShowingPhase: Boolean;
    HiddingPhase: Boolean;
    fOnPlayStart: TPlayEvent;
    fOnPlayStop: TPlayEvent;
    fOnDragStart: TNotifyEvent;
    fOnDragging: TNotifyEvent;
    fOnDragStop: TNotifyEvent;
    fOnMoveStart: TNotifyEvent;
    fOnMoving: TNotifyEvent;
    fOnMoveStop: TNotifyEvent;
    fOnIdle: TIdleEvent;
    fOnClick: TNotifyEvent;
    fOnDblClick: TNotifyEvent;
    fOnChange: TNotifyEvent;
    fOnShow: TNotifyEvent;
    fOnHide: TNotifyEvent;
    fOnResize: TNotifyEvent;
    fOnBalloonShow: TNotifyEvent;
    fOnBalloonHide: TNotifyEvent;
    fOnAdjustCustomLabel: TCustomLabelEvent;
    fOnTipsTipChange: TNotifyEvent;
    fOnGuideRequestChange: TNotifyEvent;
    fOnGuideTopicClick: TTopicClickEvent;
    fOnGuideSearchClick: TNotifyEvent;
    fOnGuideOptionsClick: TNotifyEvent;
    fOnHintTopicClick: TTopicClickEvent;
    fOnHintBulbClick: TNotifyEvent;
    procedure SetHintBulb(Value: Boolean);
    procedure SetMute(Value: Boolean);
    function GetMute: Boolean;
    function GetSpeed: Word;
    procedure SetSpeed(Value: Word);
    function GetPriority: TThreadPriority;
    procedure SetPriority(Value: TThreadPriority);
    procedure SetMoveStep(Value: Byte);
    procedure SetVisible(Value: Boolean);
    procedure SetAutoIdle(Value: Boolean);
    function GetAutoIdle: Boolean;
    procedure SetMinIdleTime(Value: Word);
    function GetMinIdleTime: Word;
    procedure SetMaxIdleTime(Value: Word);
    function GetMaxIdleTime: Word;
    procedure SetPopupMenu(Value: TPopupMenu);
    function GetPopupMenu: TPopupMenu;
    procedure SetBiDiMode(Value: TBiDiMode);
    function GetBiDiMode: TBiDiMode;
    procedure SetStageLeft(Value: Integer);
    function GetStageLeft: Integer;
    procedure SetStageTop(Value: Integer);
    function GetStageTop: Integer;
    function GetStageWidth: Integer;
    function GetStageHeight: Integer;
    function GetStageBoundsRect: TRect;
    function GetShowing: Boolean;
    procedure SetDraggable(Value: Boolean);
    function GetDraggable: Boolean;
    procedure SetAlwaysOnTop(Value: Boolean);
    function GetAlwaysOnTop: Boolean;
    function GetMovingTo: Boolean;
    function GetMovingToSync: Boolean;
    procedure SetActorLibrary(const Value: String);
    function GetActorLibrary: String;
    function GetActorName: String;
    function GetActorVerInfo(const InfoName: String): String;
    function GetAnimationCount: Word;
    function GetAnimations(Index: Word): TAnimation;
    procedure SetCustomDialog(Value: TAssistantBalloon);
    procedure SetDockSite(Value: TWinControl);
    procedure SetBalloonOptions(Value: TBalloonOptions);
    function GetBalloonOptions: TBalloonOptions;
    procedure SetMsgDlgOptions(Value: TMsgDlgOptions);
    function GetMsgDlgOptions: TMsgDlgOptions;
    procedure SetTipsDlgOptions(Value: TTipsDlgOptions);
    function GetTipsDlgOptions: TTipsDlgOptions;
    procedure SetGuideDlgOptions(Value: TGuideDlgOptions);
    function GetGuideDlgOptions: TGuideDlgOptions;
    procedure SetHintDlgOptions(Value: THintDlgOptions);
    function GetHintDlgOptions: THintDlgOptions;
    procedure SetBalloonAnchor(Value: TWinControl);
    function GetBalloonAnchor: TWinControl;
    function GetEmpty: Boolean;
    function GetPlaying: Boolean;
    function GetPlayingID: TRequestID;
    function GetPlayIdling: Boolean;
    function GetBalloonPos: TBalloonPos;
    function GetModalBalloon: Boolean;
    function GetVisibleBalloon: TBalloonKind;
    procedure FrameChanged(Sender: TObject);
    procedure PlayStarted(Sendr: TObject; RequestID: TRequestID);
    procedure PlayStopped(Sendr: TObject; RequestID: TRequestID);
    procedure IdleEntered(Sendr: TObject; Level: Integer; var Handled: Boolean);
    procedure StageBeginDrag(Sender: TObject);
    procedure StageDragging(Sender: TObject);
    procedure StageEndDrag(Sender: TObject);
    procedure StageResize(Sender: TObject);
    procedure StageShow(Sender: TObject);
    procedure StageHide(Sender: TObject);
    procedure StageClick(Sender: TObject);
    procedure StageDblClick(Sender: TObject);
    procedure HintBulbClick(Sender: TObject);
    procedure BalloonShow(Sender: TObject);
    procedure BalloonHide(Sender: TObject);
    procedure AdjustCustomLabel(Sender: TObject; TheLabel: TControl);
    procedure TipsTipChanged(Sender: TObject);
    procedure GuideRequestChanged(Sender: TObject);
    procedure GuideGetBtnStates(Sender: TObject; var OptionsBtn, SearchBtn: Boolean);
    procedure GuideTopicClicked(Sender: TObject; TopicIndex: Integer);
    procedure GuideSearchClicked(Sender: TObject);
    procedure GuideOptionsClicked(Sender: TObject);
    procedure HintTopicClicked(Sender: TObject; TopicIndex: Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    function PrepareMove: Boolean; virtual;
    function MoveOneStep(SX, SY: Integer): Boolean; virtual;
    procedure UnprepareMove; virtual;
    procedure CancelMove; virtual;
    procedure ValidateDockSite; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Show(Fast: Boolean {$IFDEF COMPILER4_UP} = False {$ENDIF});
    procedure Hide(Fast: Boolean {$IFDEF COMPILER4_UP} = False {$ENDIF});
    procedure BringToFront;
    procedure SetPosition(X, Y: Integer);
    {$IFDEF COMPILER4_UP}
    function Play(Index: Word): TRequestID; overload;
    function Play(const Name: String): TRequestID; overload;
    function Play(Action: TActorAction): TRequestID; overload;
    function Play(const Actions: array of TActorAction): TRequestID; overload;
    {$ELSE}
    function PlayIndex(Index: Word): TRequestID;
    function PlayName(Name: String): TRequestID;
    function PlayAction(Action: TActorAction): TRequestID;
    function PlayRandom(const Actions: array of TActorAction): TRequestID;
    function Play(V: Variant): TRequestID;
    {$ENDIF}
    function PlaySafe(Action: TActorAction): TRequestID;
    function WaitFor(RequestID: TRequestID {$IFDEF COMPILER4_UP} = 0 {$ENDIF}): Boolean;
    procedure Stop(RequestID: TRequestID {$IFDEF COMPILER4_UP} = 0 {$ENDIF});
    procedure StopAll(Cut: Boolean {$IFDEF COMPILER4_UP} = False {$ENDIF});
    procedure ResetIdle;
    function IsValid(RequestID: TRequestID): Boolean;
    function IsPlaying(Actions: TActorActions {$IFDEF COMPILER4_UP} = [] {$ENDIF}): Boolean;
    function IsJustPlayed(Actions: TActorActions {$IFDEF COMPILER4_UP} = [] {$ENDIF}): Boolean;
    function GestureAt(X, Y: Integer): TRequestID;
    function GlanceAt(X, Y: Integer): TRequestID;
    function LookAt(X, Y: Integer): TRequestID;
    procedure MoveTo(X, Y: Integer);
    function WaitForMove: Boolean;
    procedure CloseBalloon;
    function InputQuery(const ACaption, APrompt: String; var Value: String): Boolean;
    function MessageDlg(const Msg: String; AType: TMsgDlgType;
      AButtons: TMsgDlgButtons; HelpCtx: LongInt): Word;
    function MessageDlgDef(const Msg: String; AType: TMsgDlgType;
      AButtons: TMsgDlgButtons; HelpCtx: LongInt; DefButton: TMsgDlgBtn): Word;
    procedure Speak(const Msg: String; Timeout: Integer {$IFDEF COMPILER4_UP} = 0 {$ENDIF});
    procedure Think(const Msg: String; Timeout: Integer {$IFDEF COMPILER4_UP} = 0 {$ENDIF});
    procedure ShowTips;
    procedure ShowHint;
    procedure ShowGuide;
    procedure ShowCustom;
    function ShowGuideModal: Word;
    function ShowHintModal: Word;
    function ShowCustomModal: Word;
    procedure MoveBalloonToCursor;
    procedure MoveBalloonTo(Point: TPoint);
    procedure MoveBalloonToControl(Control: TControl);
    property Empty: Boolean read GetEmpty;
    property Showing: Boolean read GetShowing;
    property Playing: Boolean read GetPlaying;
    property PlayingID: TRequestID read GetPlayingID;
    property PlayIdling: Boolean read GetPlayIdling;
    property Dragging: Boolean read fDragging;
    property MovingTo: Boolean read GetMovingTo;
    property MovingToSync: Boolean read GetMovingToSync;
    property ModalBalloon: Boolean read GetModalBalloon;
    property BalloonPos: TBalloonPos read GetBalloonPos;
    property VisibleBalloon: TBalloonKind read GetVisibleBalloon;
    property BalloonAnchor: TWinControl read GetBalloonAnchor write SetBalloonAnchor;
    property CustomDialog: TAssistantBalloon read fCustomDialog write SetCustomDialog;
    property ActorName: String read GetActorName;
    property Width: Integer read GetStageWidth;
    property Height: Integer read GetStageHeight;
    property BoundsRect: TRect read GetStageBoundsRect;
    property ActorVerInfo[const InfoName: String]: String read GetActorVerInfo;
    property AnimationCount: Word read GetAnimationCount;
    property Animations[Index: Word]: TAnimation read GetAnimations;
  published
    property About: TAboutMe read fAbout write fAbout stored False;
    property ActorLibrary: String read GetActorLibrary write SetActorLibrary;
    property AlwaysOnTop: Boolean read GetAlwaysOnTop write SetAlwaysOnTop default True;
    property AutoIdle: Boolean read GetAutoIdle write SetAutoIdle default True;
    property BiDiMode: TBiDiMode read GetBiDiMode write SetBiDiMode default bdLeftToRight;
    property BlockingMove: Boolean read fBlockingMove write fBlockingMove default False;
    property Draggable: Boolean read GetDraggable write SetDraggable default True;
    property DockSite: TWinControl read fDockSite write SetDockSite;
    property FastShowHide: Boolean read fFastShowHide write fFastShowHide default False;
    property StageLeft: Integer read GetStageLeft write SetStageLeft default 0;
    property StageTop: Integer read GetStageTop write SetStageTop default 0;
    property HintBulb: Boolean read fHintBulb write SetHintBulb default False;
    property PopupMenu: TPopupMenu read GetPopupMenu write SetPopupMenu;
    property Priority: TThreadPriority read GetPriority write SetPriority default tpNormal;
    property MinIdleTime: Word read GetMinIdleTime write SetMinIdleTime default 1000;
    property MaxIdleTime: Word read GetMaxIdleTime write SetMaxIdleTime default 8000;
    property MoveStep: Byte read fMoveStep write SetMoveStep default 8;
    property Mute: Boolean read GetMute write SetMute default False;
    property Speed: Word read GetSpeed write SetSpeed default 100;
    property Balloon: TBalloonOptions read GetBalloonOptions write SetBalloonOptions;
    property MsgDlg: TMsgDlgOptions read GetMsgDlgOptions write SetMsgDlgOptions;
    property TipsDlg: TTipsDlgOptions read GetTipsDlgOptions write SetTipsDlgOptions;
    property GuideDlg: TGuideDlgOptions read GetGuideDlgOptions write SetGuideDlgOptions;
    property HintDlg: THintDlgOptions read GetHintDlgOptions write SetHintDlgOptions;
    property Visible: Boolean read fVisible write SetVisible default False;
    property OnAdjustCustomLabel: TCustomLabelEvent read fOnAdjustCustomLabel write fOnAdjustCustomLabel;
    property OnBalloonShow: TNotifyEvent read fOnBalloonShow write fOnBalloonShow;
    property OnBalloonHide: TNotifyEvent read fOnBalloonHide write fOnBalloonHide;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property OnClick: TNotifyEvent read fOnClick write fOnClick;
    property OnDblClick: TNotifyEvent read fOnDblClick write fOnDblClick;
    property OnDragging: TNotifyEvent read fOnDragging write fOnDragging;
    property OnDragStart: TNotifyEvent read fOnDragStart write fOnDragStart;
    property OnDragStop: TNotifyEvent read fOnDragStop write fOnDragStop;
    property OnHide: TNotifyEvent read fOnHide write fOnHide;
    property OnHintBulbClick: TNotifyEvent read fOnHintBulbClick write fOnHintBulbClick;
    property OnHintTopicClick: TTopicClickEvent read fOnHintTopicClick write fOnHintTopicClick;
    property OnIdle: TIdleEvent read fOnIdle write fOnIdle;
    property OnGuideRequestChange: TNotifyEvent read fOnGuideRequestChange write fOnGuideRequestChange;
    property OnGuideTopicClick: TTopicClickEvent read fOnGuideTopicClick write fOnGuideTopicClick;
    property OnGuideSearchClick: TNotifyEvent read fOnGuideSearchClick write fOnGuideSearchClick;
    property OnGuideOptionsClick: TNotifyEvent read fOnGuideOptionsClick write fOnGuideOptionsClick;
    property OnMoving: TNotifyEvent read fOnMoving write fOnMoving;
    property OnMoveStart: TNotifyEvent read fOnMoveStart write fOnMoveStart;
    property OnMoveStop: TNotifyEvent read fOnMoveStop write fOnMoveStop;
    property OnPlayStart: TPlayEvent read fOnPlayStart write fOnPlayStart;
    property OnPlayStop: TPlayEvent read fOnPlayStop write fOnPlayStop;
    property OnResize: TNotifyEvent read fOnResize write fOnResize;
    property OnShow: TNotifyEvent read fOnShow write fOnShow;
    property OnTipsTipChange: TNotifyEvent read fOnTipsTipChange write fOnTipsTipChange;
  end;

implementation

uses
  oaEngine;

// TStageMoverThread

type
  TStageMoverThread = class(TThread)
  private
    Assistant: TAssistant;
  protected
    procedure Execute; override;
  public
    constructor Create(AOwner: TAssistant); 
  end;

constructor TStageMoverThread.Create(AOwner: TAssistant);
begin
  Assistant := AOwner;
  inherited Create(True);
  FreeOnTerminate := True;
  Resume;
end;

procedure TStageMoverThread.Execute;
begin
  with Assistant do
  begin
    ResetEvent(NoMoveEvent);
    try
      if PrepareMove then
        try
          while MoveOneStep(MoveStep, MoveStep) do
            SleepEx(10, True);
        finally
          UnprepareMove;
        end;
    finally
      SetEvent(NoMoveEvent);
    end;
  end;
end;

// TAssistant

constructor TAssistant.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitializeCriticalSection(MoveCS);
  NoMoveEvent := CreateEvent(nil, True, True, nil);
  Director := TAssistantDirector.Create;
  Director.Engine.OnFrameChange := FrameChanged;
  Director.OnPlayStart := PlayStarted;
  Director.OnPlayStop := PlayStopped;
  Director.OnIdle := IdleEntered;
  Stage := TAssistantStage.Create(Director);
  Stage.SetBounds(0, 0, 0, 0);
  Stage.Draggable := True;
  Stage.OnShow := StageShow;
  Stage.OnHide := StageHide;
  Stage.OnClick := StageClick;
  Stage.OnDblClick := StageDblClick;
  Stage.OnBeginDrag := StageBeginDrag;
  Stage.OnDragging := StageDragging;
  Stage.OnEndDrag := StageEndDrag;
  Stage.OnResize := StageResize;
  Stage.HintBulb.OnClick := HintBulbClick;
  DefaultDialog := TAssistantBalloon.Create(nil);
  DefaultDialog.Anchor := Stage;
  DefaultDialog.OnBalloonHide := BalloonHide;
  DefaultDialog.OnBalloonShow := BalloonShow;
  DefaultDialog.OnCustomLabel := AdjustCustomLabel;
  DefaultDialog.TipsDlgOptions.OnTipsTipChange := TipsTipChanged;
  DefaultDialog.GuideDlgOptions.OnGuideRequestChange := GuideRequestChanged;
  DefaultDialog.GuideDlgOptions.OnGuideTopicClick := GuideTopicClicked;
  DefaultDialog.GuideDlgOptions.OnGuideSearchClick := GuideSearchClicked;
  DefaultDialog.GuideDlgOptions.OnGuideOptionsClick := GuideOptionsClicked;
  DefaultDialog.GuideDlgOptions.OnGuideGetBtnStates := GuideGetBtnStates;
  DefaultDialog.HintDlgOptions.OnHintTopicClick := HintTopicClicked;
  Dialog := DefaultDialog;
  fMoveStep := 8;
end;

destructor TAssistant.Destroy;
begin
  CancelMove;
  Director.Terminate;
  Director.WaitFor;
  DefaultDialog.Free;
  Stage.Free;
  Director.Free;
  CloseHandle(NoMoveEvent);
  DeleteCriticalSection(MoveCS);
  inherited Destroy;
end;

procedure TAssistant.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(Acomponent, Operation);
  if (Operation = opRemove) and (AComponent = DockSite) then
    DockSite := nil;
end;

procedure TAssistant.Loaded;
begin
  inherited Loaded;
  if Visible and not Director.Actor.Empty then
    Show(FastShowHide);
end;

procedure TAssistant.ValidateDockSite;
begin
  if DockSite <> nil then
    Stage.ParentWindow := DockSite.Handle
  else
    Stage.ParentWindow := 0;
  Stage.BringToFront;
  Stage.RefreshRegion;
end;

procedure TAssistant.SetCustomDialog(Value: TAssistantBalloon);
var
  CurVisible: Boolean;
  CurAnchor: TWinControl;
begin
  if fCustomDialog <> Value then
  begin
    CurVisible := Dialog.Visible;
    CurAnchor := Dialog.Anchor;
    if Assigned(fCustomDialog) then
    begin
      fCustomDialog.OnBalloonShow := nil;
      fCustomDialog.OnBalloonHide := nil;
      fCustomDialog.Visible := False;
      fCustomDialog.Anchor := nil;
    end;
    fCustomDialog := Value;
    if Assigned(FCustomDialog) then
    begin
      if Dialog <> DefaultDialog then
        Dialog := fCustomDialog;
      fCustomDialog.OnBalloonShow := BalloonShow;
      fCustomDialog.OnBalloonHide := BalloonHide;
      fCustomDialog.Anchor := CurAnchor;
      fCustomDialog.Visible := CurVisible;
    end
    else
      Dialog := DefaultDialog;
  end;
end;

procedure TAssistant.SetDockSite(Value: TWinControl);
begin
  if DockSite <> Value then
  begin
    fDockSite := Value;
    if DockSite <> nil then
      FreeNotification(Self);
    if not ((csLoading in ComponentState) or (csDestroying in ComponentState)) then
    begin
      if Stage.Visible then
        ValidateDockSite
      else
        Stage.ParentWindow := 0;
      if (Dialog.Anchor = Stage) and Dialog.Visible then
        Dialog.Reposition;
    end;
  end;
end;

procedure TAssistant.SetMute(Value: Boolean);
begin
  Director.Engine.Mute := Value;
end;

function TAssistant.GetMute: Boolean;
begin
  Result := Director.Engine.Mute;
end;

procedure TAssistant.SetAutoIdle(Value: Boolean);
begin
  Director.AutoIdle := Value;
end;

function TAssistant.GetAutoIdle: Boolean;
begin
  Result := Director.AutoIdle;
end;

procedure TAssistant.SetMinIdleTime(Value: Word);
begin
  Director.MinIdleTime := Value;
end;

function TAssistant.GetMinIdleTime: Word;
begin
  Result := Director.MinIdleTime;
end;

procedure TAssistant.SetMaxIdleTime(Value: Word);
begin
  Director.MaxIdleTime := Value;
end;

function TAssistant.GetMaxIdleTime: Word;
begin
  Result := Director.MaxIdleTime;
end;

procedure TAssistant.SetMoveStep(Value: Byte);
begin
  if Value <> 0 then fMoveStep := Value;
end;

procedure TAssistant.SetSpeed(Value: Word);
begin
  if Value <> 0 then Director.Engine.Speed := Value;
end;

function TAssistant.GetSpeed: Word;
begin
  Result := Director.Engine.Speed;
end;

procedure TAssistant.SetPriority(Value: TThreadPriority);
begin
  Director.Engine.Priority := Value;
  Director.Priority := Value;
end;

function TAssistant.GetPriority: TThreadPriority;
begin
  Result := Director.Engine.Priority;
end;

procedure TAssistant.SetActorLibrary(const Value: String);
begin
  if CompareText(ActorLibrary, Value) <> 0 then
    try
      if Dialog.Anchor = Stage then
        Dialog.InternalHide := True;
      try
        Director.Actor.LibraryName := Value;
      finally
        if not Director.Actor.Empty then
        begin
          Stage.SetBounds(Stage.Left, Stage.Top,
            Director.Actor.Width, Director.Actor.Height);
          if Stage.Visible then
          begin
            ValidateDockSite;
            Stage.Perform(WM_QUERYNEWPALETTE, 0, 0);
            Director.PlayAction(aaRestPose);
          end
          else if Visible then
            Show(True);
        end
        else if Stage.Visible then
        begin
          Hide(True);
          fVisible := True;
        end;
        if Dialog.Anchor = Stage then
          Dialog.InternalHide := False;
        if Assigned(fOnChange) then
          fOnChange(Self);
      end;
    except
      if not (csLoading in ComponentState) then raise;
    end;
end;

function TAssistant.GetActorLibrary: String;
begin
  Result := Director.Actor.LibraryName;
end;

function TAssistant.GetActorName: String;
begin
  Result := Director.Actor.ActorName;
end;

function TAssistant.GetActorVerInfo(const InfoName: String): String;
begin
  Result := Director.Actor.VersionInfo(InfoName);
end;

function TAssistant.GetAnimationCount: Word;
begin
  Result := Director.Actor.AnimationCount;
end;

function TAssistant.GetAnimations(Index: Word): TAnimation;
begin
  Result := Director.Actor.Animations[Index];
end;

procedure TAssistant.SetHintBulb(Value: Boolean);
begin
  if HintBulb <> Value then
  begin
    fHintBulb := Value;
    Stage.HintBulb.Visible :=
      HintBulb and not MovingTo and
      not (ShowingPhase or HiddingPhase) and
      not (VisibleBalloon in [bkHint, bkTips]);
  end;
end;

procedure TAssistant.SetPopupMenu(Value: TPopupMenu);
begin
  if Stage.PopupMenu <> Value then
  begin
    Stage.PopupMenu := Value;
    {$IFDEF COMPILER4_UP}
    Stage.PopupMenu.BiDiMode := Stage.BiDiMode;
    {$ENDIF}
  end;
end;

function TAssistant.GetPopupMenu: TPopupMenu;
begin
  Result := Stage.PopupMenu;
end;

procedure TAssistant.SetBiDiMode(Value: TBiDiMode);
begin
  {$IFDEF COMPILER4_UP}
  Stage.BiDiMode := Value;
  Dialog.BiDiMode := Value;
  {$ENDIF}
end;

function TAssistant.GetBiDiMode: TBiDiMode;
begin
  {$IFDEF COMPILER4_UP}
  Result := Stage.BiDiMode;
  {$ELSE}
  Result := bdLeftToRight;
  {$ENDIF}
end;

procedure TAssistant.SetStageLeft(Value: Integer);
begin
  if Stage.Left <> Value then
  begin
    Stage.Left := Value;
    if (Dialog.Anchor = Stage) and Dialog.Visible then
      Dialog.Reposition;
  end;
end;

function TAssistant.GetStageLeft: Integer;
begin
  Result := Stage.Left;
end;

procedure TAssistant.SetStageTop(Value: Integer);
begin
  if Stage.Top <> Value then
  begin
    Stage.Top := Value;
    if (Dialog.Anchor = Stage) and Dialog.Visible then
      Dialog.Reposition;
  end;
end;

function TAssistant.GetStageTop: Integer;
begin
  Result := Stage.Top;
end;

procedure TAssistant.SetPosition(X, Y: Integer);
begin
  if (Stage.Left <> X) or (Stage.Top <> Y) then
  begin
    Stage.SetBounds(X, Y, Stage.Width, Stage.Height);
    if (Dialog.Anchor = Stage) and Dialog.Visible then
      Dialog.Reposition;
  end;
end;

function TAssistant.GetStageWidth: Integer;
begin
  Result := Stage.Width;
end;

function TAssistant.GetStageHeight: Integer;
begin
  Result := Stage.Height;
end;

function TAssistant.GetStageBoundsRect: TRect;
begin
  Result := Stage.BoundsRect;
end;

function TAssistant.GetShowing: Boolean;
begin
  Result := Stage.Visible;
end;

procedure TAssistant.SetDraggable(Value: Boolean);
begin
  Stage.Draggable := Value;
end;

function TAssistant.GetDraggable: Boolean;
begin
  Result := Stage.Draggable;
end;

procedure TAssistant.SetAlwaysOnTop(Value: Boolean);
begin
  Stage.AlwaysOnTop := Value;
end;

function TAssistant.GetAlwaysOnTop: Boolean;
begin
  Result := Stage.AlwaysOnTop;
end;

function TAssistant.GetMovingTo: Boolean;
begin
  Result := (MoveCount <> 0);
end;

function TAssistant.GetMovingToSync: Boolean;
begin
  Result := (WaitForSingleObject(NoMoveEvent, 0) <> WAIT_TIMEOUT) and MovingTo;
end;

procedure TAssistant.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
  begin
    fVisible := Value;
    if Visible <> Stage.Visible then
      if not Visible then
        Hide(FastShowHide)
      else if not Director.Actor.Empty then
        Show(FastShowHide);
  end;
end;

procedure TAssistant.SetBalloonOptions(Value: TBalloonOptions);
begin
  if Value <> nil then DefaultDialog.Options.Assign(Value);
end;

function TAssistant.GetBalloonOptions: TBalloonOptions;
begin
  Result := DefaultDialog.Options;
end;

procedure TAssistant.SetMsgDlgOptions(Value: TMsgDlgOptions);
begin
  if Value <> nil then DefaultDialog.MsgDlgOptions.Assign(Value);
end;

function TAssistant.GetMsgDlgOptions: TMsgDlgOptions;
begin
  Result := DefaultDialog.MsgDlgOptions;
end;

procedure TAssistant.SetTipsDlgOptions(Value: TTipsDlgOptions);
begin
  if Value <> nil then DefaultDialog.TipsDlgOptions.Assign(Value);
end;

function TAssistant.GetTipsDlgOptions: TTipsDlgOptions;
begin
  Result := DefaultDialog.TipsDlgOptions;
end;

procedure TAssistant.SetGuideDlgOptions(Value: TGuideDlgOptions);
begin
  if Value <> nil then DefaultDialog.GuideDlgOptions.Assign(Value);
end;

function TAssistant.GetGuideDlgOptions: TGuideDlgOptions;
begin
  Result := DefaultDialog.GuideDlgOptions;
end;

procedure TAssistant.SetHintDlgOptions(Value: THintDlgOptions);
begin
  if Value <> nil then DefaultDialog.HintDlgOptions.Assign(Value);
end;

function TAssistant.GetHintDlgOptions: THintDlgOptions;
begin
  Result := DefaultDialog.HintDlgOptions;
end;

procedure TAssistant.SetBalloonAnchor(Value: TWinControl);
begin
  if Value = nil then
    Value := Stage;
  DefaultDialog.Anchor := Value;
  if fCustomDialog <> nil then
    fCustomDialog.Anchor := Value;
end;

function TAssistant.GetBalloonAnchor: TWinControl;
begin
  if Dialog.Anchor <> Stage then
    Result := Dialog.Anchor
  else
    Result := nil;
end;

procedure TAssistant.FrameChanged(Sender: TObject);
begin
  if Director.Enabled then Stage.RefreshRegion;
end;

procedure TAssistant.PlayStarted(Sendr: TObject; RequestID: TRequestID);
begin
  if Assigned(fOnPlayStart) then
    fOnPlayStart(Self, RequestID);
end;

procedure TAssistant.PlayStopped(Sendr: TObject; RequestID: TRequestID);
begin
  if Assigned(fOnPlayStop) and not (csDestroying in ComponentState) then
    fOnPlayStop(Self, RequestID);
end;

procedure TAssistant.IdleEntered(Sendr: TObject; Level: Integer;
  var Handled: Boolean);
begin
  if not Stage.Visible then
    Handled := True
  else if Assigned(fOnIdle) then
    fOnIdle(Self, Level, Handled);
end;

procedure TAssistant.StageBeginDrag(Sender: TObject);
begin
  fDragging := True;
  Director.IdleLevel := Low(TIdleLevel);
  if Dialog.Anchor = Stage then
    Dialog.InternalHide := True;
  if Assigned(fOnDragStart) then
    fOnDragStart(Self);
end;

procedure TAssistant.StageDragging(Sender: TObject);
begin
  if Assigned(fOnDragging) then
    fOnDragging(Self);
end;

procedure TAssistant.StageEndDrag(Sender: TObject);
begin
  fDragging := False;
  Director.IdleLevel := Low(TIdleLevel);
  if Dialog.Anchor = Stage then
    Dialog.InternalHide := False;
  if Assigned(fOnDragStop) then
    fOnDragStop(Self);
end;

procedure TAssistant.StageResize(Sender: TObject);
begin
  if not Director.Actor.Empty and Assigned(fOnResize) then
    fOnResize(Self);
end;

procedure TAssistant.StageShow(Sender: TObject);
begin
  if Assigned(fOnShow) then
    fOnShow(Self);
  if (Dialog.Anchor = Stage) and Dialog.Visible then
    Dialog.Reposition;
end;

procedure TAssistant.StageHide(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then
  begin
    if (Dialog.Anchor = Stage) and Dialog.Visible then
      if Dialog.Modal then
        Dialog.Reposition
      else
        Dialog.Close;
    if Assigned(fOnHide) then
      fOnHide(Self);
  end;
end;

procedure TAssistant.HintBulbClick(Sender: TObject);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if Assigned(fOnHintBulbClick) then
    fOnHintBulbClick(Self);
end;

procedure TAssistant.StageClick(Sender: TObject);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if not Dialog.Modal and not HiddingPhase and Assigned(fOnClick) then
    fOnClick(Self);
end;

procedure TAssistant.StageDblClick(Sender: TObject);
begin
  if not Dialog.Modal and not HiddingPhase and Assigned(fOnClick) then
    fOnDblClick(Self);
end;

procedure TAssistant.BringToFront;
begin
  Stage.BringToFront;
  Dialog.BringToFront;
end;

procedure TAssistant.Show(Fast: Boolean);
var
  ShowID: TRequestID;
begin
  if not ShowingPhase and not Stage.Visible and
     not (csLoading in ComponentState) then
  begin
    ShowingPhase := True;
    try
      fVisible := True;
      Director.Enabled := True;
      if Dialog.Anchor = Stage then
        Dialog.InternalHide := True;
      ValidateDockSite;
      Stage.Visible := True;
      if not Fast then
      begin
        ShowID := Director.PlayAction(aaShow);
        if ShowID <> 0 then
          Director.WaitForRequest(ShowID)
        else
          Director.PlayAction(aaRestPose);
      end
      else
        Director.PlayAction(aaRestPose);
      Dialog.InternalHide := False;
      Stage.HintBulb.Visible := HintBulb;
    finally
      ShowingPhase := False;
    end;
  end;
end;

procedure TAssistant.Hide(Fast: Boolean);
begin
  if not HiddingPhase and Stage.Visible then
  begin
    HiddingPhase := True;
    try
      Stage.HintBulb.Visible := False;
      if Dialog.Anchor = Stage then
        Dialog.InternalHide := True;
      if Fast then
        CancelMove
      else
        WaitForSyncObject(NoMoveEvent, INFINITE);
      if not Fast then
      begin
        Director.StopAll(False);
        Director.WaitForRequest(Director.PlayAction(aaHide));
      end;
      Director.Enabled := False;
      Dialog.InternalHide := False;
      Stage.Visible := False;
      Stage.ParentWindow := 0;
      fDragging := False;
      fVisible := False;
    finally
      HiddingPhase := False;
    end;
  end;
end;

{$IFDEF COMPILER4_UP}
function TAssistant.Play(Index: Word): TRequestID;
{$ELSE}
function TAssistant.PlayIndex(Index: Word): TRequestID;
{$ENDIF}
begin
  if not HiddingPhase and Showing then
    Result := Director.PlayIndex(Index)
  else
    Result := 0;
end;

{$IFDEF COMPILER4_UP}
function TAssistant.Play(const Name: String): TRequestID;
{$ELSE}
function TAssistant.PlayName(Name: String): TRequestID;
{$ENDIF}
begin
  if not HiddingPhase and Showing then
    Result := Director.PlayName(Name)
  else
    Result := 0;
end;

{$IFDEF COMPILER4_UP}
function TAssistant.Play(Action: TActorAction): TRequestID;
{$ELSE}
function TAssistant.PlayAction(Action: TActorAction): TRequestID;
{$ENDIF}
begin
  if not HiddingPhase and Showing then
    Result := Director.PlayAction(Action)
  else
    Result := 0;
end;

{$IFDEF COMPILER4_UP}
function TAssistant.Play(const Actions: array of TActorAction): TRequestID;
{$ELSE}
function TAssistant.PlayRandom(const Actions: array of TActorAction): TRequestID;
{$ENDIF}
begin
  if not HiddingPhase and Showing then
    Result := Director.PlayRandom(Actions)
  else
    Result := 0;
end;

{$IFNDEF COMPILER4_UP}
function TAssistant.Play(V: Variant): TRequestID;
begin
  if not HiddingPhase and Showing then
    case VarType(V) and varTypeMask of
      varString:
        Result := PlayName(String(V));
      varByte, varInteger:
        if TActorAction(V) in [Low(TActorAction)..High(TActorAction)] then
          Result := PlayAction(TActorAction(V))
        else
          Result := PlayIndex(Integer(V));
    else
      Result := 0;
    end
  else
    Result := 0;
end;
{$ENDIF}

function TAssistant.PlaySafe(Action: TActorAction): TRequestID;
begin
  Result := 0;
  if not Director.Playing or Director.PlayIdling then
    case Action of
      aaGetAttention:
        if Director.IsJustPlayed([aaGetAttention, aaGetAttentionContinued]) then
          Result := Director.PlayAction(aaGetAttentionContinued)
        else
          Result := Director.PlayAction(aaGetAttention);
      aaRead:
        if Director.IsJustPlayed([aaRead, aaReadContinued]) then
          Result := Director.PlayAction(aaReadContinued)
        else
          Result := Director.PlayAction(aaRead);
      aaWrite:
        if Director.IsJustPlayed([aaWrite, aaWriteContinued]) then
          Result := Director.PlayAction(aaWriteContinued)
        else
          Result := Director.PlayAction(aaWrite);
    else
      Result := Director.PlayAction(Action);
    end;
end;

function TAssistant.WaitFor(RequestID: TRequestID): Boolean;
begin
  if RequestID = 0 then
    RequestID := Director.PlayingID;
  if RequestID <> 0 then
    Result := Director.WaitForRequest(RequestID)
  else
    Result := True;
end;

procedure TAssistant.Stop(RequestID: TRequestID);
begin
  if RequestID = 0 then
    RequestID := Director.PlayingID;
  if (RequestID <> 0) and ((RequestID <> Director.PlayingID) or not MovingTo) then
    Director.Stop(RequestID);
end;

procedure TAssistant.StopAll(Cut: Boolean);
begin
  WaitForMove;
  Director.StopAll(Cut);
end;

procedure TAssistant.ResetIdle;
begin
  if Director.IdleLevel <> Low(TIdleLevel) then
    Director.IdleLevel := Low(TIdleLevel)
  else
    Director.PlayAction(aaRestPose);
end;

function TAssistant.IsValid(RequestID: TRequestID): Boolean;
begin
  Result := Director.IsValidRequest(RequestID);
end;

function TAssistant.IsPlaying(Actions: TActorActions): Boolean;
begin
  Result := Director.IsPlaying(Actions);
end;

function TAssistant.IsJustPlayed(Actions: TActorActions): Boolean;
begin
  Result := Director.IsJustPlayed(Actions);
end;

function TAssistant.GetEmpty: Boolean;
begin
  Result := Director.Actor.Empty;
end;

function TAssistant.GetPlaying: Boolean;
begin
  Result := Director.Playing;
end;

function TAssistant.GetPlayingID: TRequestID;
begin
  Result := Director.PlayingID;
end;

function TAssistant.GetPlayIdling: Boolean;
begin
  Result := Director.PlayIdling;
end;

function TAssistant.GetBalloonPos: TBalloonPos;
begin
  if Dialog.Visible then
    Result := Dialog.BalloonPos
  else
    Result := bpCenter;
end;

function TAssistant.GetVisibleBalloon: TBalloonKind;
begin
  if Dialog.Visible or Dialog.InternalHide then
    Result := Dialog.BalloonKind
  else
    Result := bkNone;
end;

function TAssistant.GetModalBalloon: Boolean;
begin
  if Dialog.Visible or Dialog.InternalHide then
    Result := Dialog.Modal
  else
    Result := False;
end;

procedure TAssistant.CloseBalloon;
begin
  if Dialog.Visible then Dialog.Close
end;

function TAssistant.GestureAt(X, Y: Integer): TRequestID;
var
  Action: TActorAction;
  Origin: TPoint;
begin
  if Stage.Visible and not HiddingPhase then
  begin
    Origin.X := Stage.Left + Stage.Width div 2;
    Origin.Y := Stage.Top + Stage.Height div 2;
    Action := Director.ActionOfOrientation(oaGesture, Origin, Point(X, Y));
    Result := Director.PlayAction(Action);
  end
  else
    Result := 0;
end;

function TAssistant.GlanceAt(X, Y: Integer): TRequestID;
var
  Action: TActorAction;
  Origin: TPoint;
begin
  if Stage.Visible and not HiddingPhase then
  begin
    Origin.X := Stage.Left + Stage.Width div 2;
    Origin.Y := Stage.Top + Stage.Height div 2;
    Action := Director.ActionOfOrientation(oaGlance, Origin, Point(X, Y));
    Result := Director.PlayAction(Action);
  end
  else
    Result := 0;
end;

function TAssistant.LookAt(X, Y: Integer): TRequestID;
var
  Action: TActorAction;
  Origin: TPoint;
begin
  if Stage.Visible and not HiddingPhase then
  begin
    Origin.X := Stage.Left + Stage.Width div 2;
    Origin.Y := Stage.Top + Stage.Height div 2;
    Action := Director.ActionOfOrientation(oaLook, Origin, Point(X, Y));
    Result := Director.PlayAction(Action);
  end
  else
    Result := 0;
end;

procedure TAssistant.MoveTo(X, Y: Integer);
var
  Action: TActorAction;
begin
  PendedMoveDest.X := X;
  PendedMoveDest.Y := Y;
  EnterCriticalSection(MoveCS);
  try
    if MovingTo and not CancellingMove then
    begin
      Action := Director.ActionOfOrientation(oaMove, Stage.BoundsRect.TopLeft, PendedMoveDest);
      if MoveAction = Action then
        MoveDest := PendedMoveDest
      else
      begin
        LeaveCriticalSection(MoveCS);
        try
          CancelMove;
        finally
          EnterCriticalSection(MoveCS);
        end;
      end;
    end;
    if not MovingTo and ((Stage.Left <> PendedMoveDest.X) or (Stage.Top <> PendedMoveDest.Y)) then
    begin
      MoveDest := PendedMoveDest;
      if not BlockingMove and Showing then
      begin
        TStageMoverThread.Create(Self);
        repeat until WaitForSingleObject(NoMoveEvent, 0) = WAIT_TIMEOUT;
      end
      else if PrepareMove then
        try
          while MoveOneStep(FMoveStep, FMoveStep) do
            WaitForSyncObject(GetCurrentThread, 10);
        finally
          UnprepareMove;
        end;
    end;
  finally
    LeaveCriticalSection(MoveCS);
  end;
end;

function TAssistant.WaitForMove: Boolean;
begin
  Result := False;
  if not MovingToSync then
  begin
    Result := True;
    while MovingTo do WaitForSyncObject(NoMoveEvent, INFINITE);
  end;
end;

function TAssistant.PrepareMove: Boolean;
begin
  Inc(MoveCount);
  Result := False;
  if Stage.Visible and not HiddingPhase then
  begin
    Stage.Enabled := False;
    Dialog.InternalHide := True;
    Stage.HintBulb.Visible := False;
    MoveAction := Director.ActionOfOrientation(oaMove, Stage.BoundsRect.TopLeft, MoveDest);
    Director.StopAll(False);
    Director.WaitForRequest(Director.PlayAction(MoveAction));
    Director.SuspendPlay;
    Result := True;
    if Assigned(fOnMoveStart) then
      fOnMoveStart(Self);
  end
  else
  begin
    Stage.SetBounds(MoveDest.X, MoveDest.Y, Stage.Width, Stage.Height);
    Dec(MoveCount);
  end;
end;

procedure TAssistant.UnprepareMove;
begin
  if not Director.Playing then
    Director.PlayAction(aaRestPose);
  Director.ResumePlay;
  Dialog.InternalHide := False;
  Stage.HintBulb.Visible :=  HintBulb and
      not (ShowingPhase or HiddingPhase) and
      not (VisibleBalloon in [bkHint, bkTips]);
  Stage.Enabled := True;
  if Assigned(fOnMoveStop) then
    fOnMoveStop(Self);
  Dec(MoveCount);
end;

function TAssistant.MoveOneStep(SX, SY: Integer): Boolean;
var
  Delta: TPoint;
  NewPos: TPoint;
begin
  EnterCriticalSection(MoveCS);
  try
    if not CancellingMove then
    begin
      NewPos := Point(Stage.Left, Stage.Top);
      Delta.X := MoveDest.X-Stage.Left;
      Delta.Y := MoveDest.Y-Stage.Top;
      if Abs(Delta.X) > Abs(Delta.Y) then
        SY := SX * Abs(Delta.Y) div Abs(Delta.X)
      else if Delta.Y <> 0 then
        SX := SY * Abs(Delta.X) div Abs(Delta.Y);
      if SX = 0 then SX := 1;
      if SY = 0 then SY := 1;
      if Delta.X <> 0 then
      begin
        if Delta.X > 0 then
        begin
          NewPos.X := Stage.Left + SX;
          if NewPos.X > MoveDest.X then
            NewPos.X := MoveDest.X;
        end
        else
        begin
          NewPos.X := Stage.Left - SX;
          if NewPos.X < MoveDest.X then
            NewPos.X := MoveDest.X;
        end;
      end;
      if Delta.Y <> 0 then
      begin
        if Delta.Y > 0 then
        begin
          NewPos.Y := Stage.Top + SY;
          if NewPos.Y > MoveDest.Y then
            NewPos.Y := MoveDest.Y;
        end
        else
        begin
          NewPos.Y := Stage.Top - SY;
          if NewPos.Y < MoveDest.Y then
            NewPos.Y := MoveDest.Y;
        end;
      end;
    end
    else
      NewPos := MoveDest;
    Result := (NewPos.X <> MoveDest.X) or (NewPos.Y <> MoveDest.Y);
  finally
    LeaveCriticalSection(MoveCS);
  end;
  if Result then
  begin
    SetWindowPos(Stage.Handle, HWND_TOP, NewPos.X, NewPos.Y, 0, 0,
      SWP_NOSIZE or SWP_NOOWNERZORDER or SWP_NOACTIVATE);
    if Assigned(fOnMoving) then
      fOnMoving(Self);
  end
  else if not CancellingMove or HiddingPhase then
    Stage.SetBounds(NewPos.X, NewPos.Y, Stage.Width, Stage.Height);
end;

procedure TAssistant.CancelMove;
begin
  if MovingTo then
  begin
    CancellingMove := True;
    try
      if MovingToSync then
        MoveDest := Stage.BoundsRect.TopLeft
      else
        repeat WaitForSyncObject(NoMoveEvent, INFINITE) until not MovingTo;
    finally
      CancellingMove := False;
    end;
  end;
end;


function TAssistant.InputQuery(const ACaption, APrompt: String;
  var Value: String): Boolean;
var
  Popup: TPopupMenu;
begin
  Dialog := DefaultDialog;
  Popup := Stage.PopupMenu;
  Stage.PopupMenu := nil;
  try
    Result := Dialog.InputQuery(ACaption, APrompt, Value);
  finally
    Stage.PopupMenu := Popup;
  end;
end;

function TAssistant.MessageDlg(const Msg: String; AType: TMsgDlgType;
  AButtons: TMsgDlgButtons; HelpCtx: LongInt): Word;
begin
  Result := MessageDlgDef(Msg, AType, AButtons, HelpCtx, mbNone);
end;

function TAssistant.MessageDlgDef(const Msg: String; AType: TMsgDlgType;
  AButtons: TMsgDlgButtons; HelpCtx: LongInt; DefButton: TMsgDlgBtn): Word;
var
  Popup: TPopupMenu;
begin
  Result := mrNone;
  if WaitForMove then
  begin
    Dialog := DefaultDialog;
    Popup := Stage.PopupMenu;
    Stage.PopupMenu := nil;
    try
      Result := Dialog.ShowMsgDlg(Msg, AType, AButtons, HelpCtx, DefButton);
    finally
      Stage.PopupMenu := Popup;
    end;
  end;
end;

procedure TAssistant.Speak(const Msg: String; Timeout: Integer);
begin
  WaitForMove;
  Dialog := DefaultDialog;
  Dialog.ShowMessage(Msg, Timeout, bsSpeakShape);
end;

procedure TAssistant.Think(const Msg: String; Timeout: Integer);
begin
  WaitForMove;
  Dialog := DefaultDialog;
  Dialog.ShowMessage(Msg, Timeout, bsThinkShape);
end;

procedure TAssistant.ShowTips;
begin
  WaitForMove;
  Dialog := DefaultDialog;
  if Dialog.TipsDlgOptions.Tips.Count > 0 then
    Dialog.ShowTipsDlg;
end;

procedure TAssistant.ShowHint;
begin
  WaitForMove;
  Dialog := DefaultDialog;
  Dialog.ShowHintDlg;
end;

procedure TAssistant.ShowGuide;
begin
  WaitForMove;
  Dialog := DefaultDialog;
  Dialog.ShowGuideDlg;
end;

procedure TAssistant.ShowCustom;
begin
  WaitForMove;
  Dialog := CustomDialog;
  Dialog.ShowCustomDlg;
end;

function TAssistant.ShowHintModal: Word;
var
  Popup: TPopupMenu;
begin
  Result := mrNone;
  if WaitForMove then
  begin
    Dialog := DefaultDialog;
    Popup := Stage.PopupMenu;
    Stage.PopupMenu := nil;
    try
      Result := Dialog.ShowHintDlgModal;
    finally
      Stage.PopupMenu := Popup;
    end;
  end;
end;

function TAssistant.ShowGuideModal: Word;
var
  Popup: TPopupMenu;
begin
  Result := mrNone;
  if WaitForMove then
  begin
    Dialog := DefaultDialog;
    Popup := Stage.PopupMenu;
    Stage.PopupMenu := nil;
    try
      Result := Dialog.ShowGuideDlgModal;
    finally
      Stage.PopupMenu := Popup;
    end;
  end;
end;

function TAssistant.ShowCustomModal: Word;
var
  Popup: TPopupMenu;
begin
  Result := mrNone;
  if WaitForMove then
  begin
    Dialog := CustomDialog;
    Popup := Stage.PopupMenu;
    Stage.PopupMenu := nil;
    try
      Result := Dialog.ShowCustomDlgModal;
    finally
      Stage.PopupMenu := Popup;
    end;
  end;
end;

procedure TAssistant.MoveBalloonTo(Point: TPoint);
begin
  Dialog.MoveTo(Point);
end;

procedure TAssistant.MoveBalloonToCursor;
var
  MousePos: TPoint;
begin
  GetCursorPos(MousePos);
  Dialog.MoveTo(MousePos);
end;

procedure TAssistant.MoveBalloonToControl(Control: TControl);
var
  P: TPoint;
begin
  if Assigned(Control) then
  begin
    P.X := 0;
    P.Y := 0;
    {$IFDEF COMPILER4_UP}
    if Stage.UseRightToLeftAlignment then
      P.X := Control.Width;
    {$ENDIF}
    P := Control.ClientToScreen(P);
    Dialog.MoveTo(P);
  end;
end;

procedure TAssistant.BalloonShow(Sender: TObject);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if Dialog.BalloonKind in [bkHint, bkTips] then
    Stage.HintBulb.Visible := False;
  if Dialog.Modal then
    Stage.HintBulb.Enabled := False;
  if Assigned(fOnBalloonShow) then
    fOnBalloonShow(Self);
end;

procedure TAssistant.BalloonHide(Sender: TObject);
begin
  Director.IdleLevel := Low(TIdleLevel);
  Stage.HintBulb.Enabled := Assigned(fOnHintBulbClick);
  Stage.HintBulb.Visible :=
    HintBulb and not MovingTo and
    not (ShowingPhase or HiddingPhase);
  if Assigned(fOnBalloonHide) and not (csDestroying in ComponentState) then
    fOnBalloonHide(Self);
end;

procedure TAssistant.AdjustCustomLabel(Sender: TObject; TheLabel: TControl);
begin
  if Assigned(fOnAdjustCustomLabel) then
    fOnAdjustCustomLabel(Self, TheLabel);
end;

procedure TAssistant.TipsTipChanged(Sender: TObject);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if Assigned(fOnTipsTipChange) then
    fOnTipsTipChange(Self);
end;

procedure TAssistant.GuideRequestChanged(Sender: TObject);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if Assigned(fOnGuideRequestChange) then
    fOnGuideRequestChange(Self);
end;

procedure TAssistant.GuideTopicClicked(Sender: TObject; TopicIndex: Integer);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if Assigned(fOnGuideTopicClick) then
    fOnGuideTopicClick(Self, TopicIndex);
end;

procedure TAssistant.GuideSearchClicked(Sender: TObject);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if Assigned(FOnGuideSearchClick) then
    fOnGuideSearchClick(Self);
end;

procedure TAssistant.GuideOptionsClicked(Sender: TObject);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if Assigned(fOnGuideOptionsClick) then
  begin
    Dialog.Close;
    fOnGuideOptionsClick(Self);
  end;
end;

procedure TAssistant.GuideGetBtnStates(Sender: TObject;
  var OptionsBtn, SearchBtn: Boolean);
begin
  OptionsBtn := OptionsBtn and Assigned(fOnGuideOptionsClick);
  SearchBtn := SearchBtn and Assigned(fOnGuideSearchClick);
end;

procedure TAssistant.HintTopicClicked(Sender: TObject; TopicIndex: Integer);
begin
  Director.IdleLevel := Low(TIdleLevel);
  if Assigned(fOnHintTopicClick) then
    fOnHintTopicClick(Self, TopicIndex);
end;

end.


