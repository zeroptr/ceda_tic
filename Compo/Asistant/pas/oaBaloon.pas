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

unit oaBaloon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, oaTypes, OffBtn;

const
  mbNone: TMsgDlgBtn = TMsgDlgBtn(-1);

type

{ TTopicOptions }

  TTopicOptions = class(TPersistent)
  private
    fID: Integer;
    fStyles: TTopicStyles;
    fOnSelect: TTopicClickEvent;
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property ID: Integer read fID write fID;
    property Styles: TTopicStyles read fStyles write fStyles;
    property OnSelect: TTopicClickEvent read fOnSelect write fOnSelect;
  end;

{ TTopicsList }

  TTopicsList = class(TStringList)
  private
    function GetOptions(Index: Integer): TTopicOptions;
    procedure SetOptions(Index: Integer; Value: TTopicOptions);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function AddItem(const S: String; O: TTopicOptions): Integer;
  public
    destructor Destroy; override;
    procedure Delete(Index: Integer); override;
    procedure Clear; override;
    function AddObject(const S: String; AObject : TObject): Integer; override;
    function Add(const S: String): Integer; override;
    function AddID(const S: String; ID: Integer): Integer;
    function AddStyle(const S: String; AStyles: TTopicStyles): Integer;
    function AddStyleID(const S: String; AStyles: TTopicStyles; ID: Integer): Integer;
    function AddOptions(const S: String; AOptions: TTopicOptions): Integer;
    property Options[Index: Integer]: TTopicOptions read GetOptions write SetOptions;
  end;

{ TBalloonMetrics }

  TBalloonMetrics = class(Tpersistent)
  private
    FBalloonOffset: Integer;
    FArrowThickness: Word;
    FArrowLength: Word;
    FThoughtLength: Word;
    FRoundCorner: Word;
    FControlSpacing: Word;
    FMaxButtonSpacing: Word;
    FMinButtonWidth: Word;
    FMinButtonHeight: Word;
    FMinGuideDlgWidth: Word;
    FMinHintDlgWidth: Word;
    FMinTipsDlgWidth: Word;
    FMinMsgDlgWidth: Word;
    FMinQueryDlgWidth: Word;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property BalloonOffset: Integer read FBalloonOffset write FBalloonOffset default -5;
    property ArrowThickness: Word read FArrowThickness write FArrowThickness default 10;
    property ArrowLength: Word read FArrowLength write FArrowLength default 17;
    property ThoughtLength: Word read FThoughtLength write FThoughtLength default 60;
    property RoundCorner: Word read FRoundCorner write FRoundCorner default 15;
    property ControlSpacing: Word read FControlSpacing write FControlSpacing default 7;
    property MaxButtonSpacing: Word read FMaxButtonSpacing write FMaxButtonSpacing default 26;
    property MinButtonWidth: Word read FMinButtonWidth write FMinButtonWidth default 58;
    property MinButtonHeight: Word read FMinButtonHeight write FMinButtonHeight default 20;
    property MinMsgDlgWidth: Word read FMinMsgDlgWidth write FMinMsgDlgWidth default 175;
    property MinTipsDlgWidth: Word read FMinTipsDlgWidth write FMinTipsDlgWidth default 480;
    property MinGuideDlgWidth: Word read FMinGuideDlgWidth write FMinGuideDlgWidth default 170;
    property MinHintDlgWidth: Word read FMinHintDlgWidth write FMinHintDlgWidth default 160;
    property MinQueryDlgWidth: Word read FMinQueryDlgWidth write FMinQueryDlgWidth default 280;
  end;

{ TBalloonOptions }

  TControlClass = class of TControl;

  TBalloonOptions = class(TPersistent)
  private
    FColor: TColor;
    FBorderColor: TColor;
    FOffice2000Look: Boolean;
    FMetrics: TBalloonMetrics;
    FFont: TFont;
    FHoverFont: TFont;
    FLabelClass: TControlClass;
    FOnChange: TNotifyEvent;
    IsFontChanged: Boolean;
    IsHoverFontChanged: Boolean;
    procedure SetColor(Value: TColor);
    procedure SetBorderColor(Value: TColor);
    procedure SetOffice2000Look(Value: Boolean);
    procedure SetMetrics(Value: TBalloonMetrics);
    procedure SetLabelClass(Value: TControlClass);
    procedure SetFont(Value: TFont);
    procedure SetHoverFont(Value: TFont);
    procedure FontChanged(Sender: TObject);
    procedure HoverFontChanged(Sender: TObject);
    function IsFontStored: Boolean;
    function IsHoverFontStored: Boolean;
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property LabelClass: TControlClass read FLabelClass write SetLabelClass;
  published
    property Metrics: TBalloonMetrics read FMetrics write SetMetrics;
    property Color: TColor read FColor write SetColor default $00C0FFFF;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property HoverFont: TFont read FHoverFont write SetHoverFont stored IsHoverFontStored;
    property Office2000Look: Boolean read FOffice2000Look write SetOffice2000Look default True;
  end;

{ TCheckBoxOptions }

  TCheckBoxOptions = class(TPersistent)
  private
    FCaption: String;
    FHint: String;
    FAllowGrayed: Boolean;
    FState: TCheckBoxState;
    FEnabled: Boolean;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    procedure SetCaption(const Value: String);
    procedure SetHint(const Value: String);
    procedure SetAllowGrayed(Value: Boolean);
    procedure SetState(Value: TCheckBoxState);
    function GetChecked: Boolean;
    procedure SetChecked(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetVisible(Value: Boolean);
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: String read FCaption write SetCaption;
    property Hint: String read FHint write SetHint;
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default False;
    property State: TCheckBoxState read FState write SetState default cbUnchecked;
    property Checked: Boolean read GetChecked write SetChecked stored False;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

{ TMsgDlgOptions }

  TMsgDlgOptions = class(TPersistent)
  private
    FTitle: String;
    FCustomIcon: TIcon;
    FCheckBox: TCheckBoxOptions;
    FOnChange: TNotifyEvent;
    InternalChange: Boolean;
    procedure SetTitle(const Value: String);
    procedure SetCustomIcon(Value: TIcon);
    procedure SetCheckBox(Value: TCheckBoxOptions);
    procedure CustomIconChanged(Sender: TObject);
    procedure CheckBoxChanged(Sender: TObject);
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property CustomIcon: TIcon read FCustomIcon write SetCustomIcon;
    property Title: String read FTitle write SetTitle;
    property CheckBox: TCheckBoxOptions read FCheckBox write SetCheckBox;
  end;

{ TTipsDlgOptions }

  TTipsDlgOptions = class(TPersistent)
  private
    FIcon: TIcon;
    FTips: TStringList;
    FTipIndex: Integer;
    FVisibleButtons: TTipsDlgButtons;
    FOnTipsTipChange: TNotifyEvent;
    FOnChange: TNotifyEvent;
    InternalChange: Boolean;
    procedure SetVisibleButtons(Value: TTipsDlgButtons);
    procedure SetTips(Value: TStringList);
    procedure SetTipIndex(Value: Integer);
    procedure TipsChanged(Sender: TObject);
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Icon: TIcon read FIcon;
  published
    property VisibleButtons: TTipsDlgButtons read FVisibleButtons write SetVisibleButtons
      default [Low(TTipsDlgBtn)..High(TTipsDlgBtn)];
    property Tips: TStringList read FTips write SetTips;
    property TipIndex: Integer read FTipIndex write SetTipIndex default -1;
    property OnTipsTipChange: TNotifyEvent read FOnTipsTipChange write FOnTipsTipChange;
  end;

{ TGuideDlgOptions }

  TGuideGetBtnStatesEvent = procedure(Sender: TObject;
    var OptionsBtn, SearchBtn: Boolean) of object;

  TGuideDlgOptions = class(TPersistent)
  private
    FIcon: TIcon;
    FTitle: String;
    FRequest: String;
    FTopics: TTopicsList;
    FDescription: String;
    FAcceptRequest: Boolean;
    FRequestResult: Boolean;
    FVisibleButtons: TGuideDlgButtons;
    FOnGuideRequestChange: TNotifyEvent;
    FOnGuideTopicClick: TTopicClickEvent;
    FOnGuideOptionsClick: TNotifyEvent;
    FOnGuideSearchClick: TNotifyEvent;
    FOnGuideGetBtnStates: TGuideGetBtnStatesEvent;
    FOnChange: TNotifyEvent;
    InternalChange: Boolean;
    procedure SetVisibleButtons(Value: TGuideDlgButtons);
    procedure SetAcceptRequest(Value: Boolean);
    procedure SetRequestResult(Value: Boolean);
    procedure SetTopics(Value: TTopicsList);
    procedure SetTitle(const Value: String);
    procedure SetRequest(const Value: String);
    procedure SetDescription(const Value: String);
    procedure SetIcon(Value: TIcon);
    procedure TopicsChanged(Sender: TObject);
    procedure IconChanged(Sender: TObject);
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property VisibleButtons: TGuideDlgButtons read FVisibleButtons write SetVisibleButtons
      default [Low(TGuideDlgCmdBtn)..High(TGuideDlgCmdBtn)];
    property Icon: TIcon read FIcon write SetIcon;
    property AcceptRequest: Boolean read FAcceptRequest write SetAcceptRequest default True;
    property RequestResult: Boolean read FRequestResult write SetRequestResult default False;
    property Topics: TTopicsList read FTopics write SetTopics;
    property Title: String read FTitle write SetTitle;
    property Request: String read FRequest write SetRequest;
    property Description: String read FDescription write SetDescription;
    property OnGuideRequestChange: TNotifyEvent read FOnGuideRequestChange write FOnGuideRequestChange;
    property OnGuideTopicClick: TTopicClickEvent read FOnGuideTopicClick write FOnGuideTopicClick;
    property OnGuideOptionsClick: TNotifyEvent read FOnGuideOptionsClick write FOnGuideOptionsClick;
    property OnGuideSearchClick: TNotifyEvent read FOnGuideSearchClick write FOnGuideSearchClick;
    property OnGuideGetBtnStates: TGuideGetBtnStatesEvent read FOnGuideGetBtnStates write FOnGuideGetBtnStates;
  end;

{ THintDlgOptions }

  THintDlgOptions = class(TPersistent)
  private
    FIcon: TIcon;
    FTitle: String;
    FTopics: TTopicsList;
    FDescription: String;
    FOnHintTopicClick: TTopicClickEvent;
    FOnChange: TNotifyEvent;
    InternalChange: Boolean;
    procedure SetTopics(Value: TTopicsList);
    procedure SetTitle(const Value: String);
    procedure SetDescription(const Value: String);
    procedure SetIcon(Value: TIcon);
    procedure TopicsChanged(Sender: TObject);
    procedure IconChanged(Sender: TObject);
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Icon: TIcon read FIcon write SetIcon;
    property Topics: TTopicsList read FTopics write SetTopics;
    property Title: String read FTitle write SetTitle;
    property Description: String read FDescription write SetDescription;
    property OnHintTopicClick: TTopicClickEvent read FOnHintTopicClick write FOnHintTopicClick;
  end;

{ TAssistantBalloon }

  TBalloonShape = (bsSpeakShape, bsThinkShape);

  TAssistantBalloon = class(TForm)
    ClientPanel: TPanel;
    Msg: TLabel;
    Icon: TImage;
    DividerTop: TShape;
    DividerBottom: TShape;
    TopicsPanel: TPanel;
    InputBoxBorder: TShape;
    InputBox: TMemo;
    Title: TLabel;
    CheckBox: TCheckBox;
    procedure InputBoxChange(Sender: TObject);
    procedure InputBoxKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxClick(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoCreate; {$IFDEF COMPILER5_UP} override; {$ENDIF}
    procedure DoHide; override;
    procedure Paint; override;
    procedure KeyPress(var Key: Char); override;
    procedure CloseModal;
    function GetWindowOverThis: HWND;
  private
    FOptions: TBalloonOptions;
    FMsgDlgOptions: TMsgDlgOptions;
    FTipsDlgOptions: TTipsDlgOptions;
    FGuideDlgOptions: TGuideDlgOptions;
    FHintDlgOptions: THintDlgOptions;
    FAnchor: TWinControl;
    FBalloonKind: TBalloonKind;
    FBalloonPos: TBalloonPos;
    FInternalHide: Boolean;
    FOnBalloonShow: TNotifyEvent;
    FOnBalloonHide: TNotifyEvent;
    FOnCustomLabel: TCustomLabelEvent;
    FNoActivate: Boolean;
    FModal: Boolean;
    FVisible: Boolean;
    HideTimer: Integer;
    AnimateTimer: Integer;
    BalloonShape: TBalloonShape;
    AutoHideDelay: Integer;
    BtnHeight: Integer;
    ButtonSpace: Integer;
    LineHeight: Integer;
    RelativeOffset: Integer;
    AbsolutePositioning: Boolean;
    FocusedControl: TWinControl;
    ClientSize: TPoint;
    ClientOrg: TPoint;
    ExtraSize: Integer;
    ScrBounds: TRect;
    RefBounds: TRect;
    procedure SetVisible(Value: Boolean);
    procedure SetAnchor(Value: TWinControl);
    procedure SetBalloonKind(Value: TBalloonKind);
    procedure SetInternalHide(Value: Boolean);
    procedure SetOptions(Value: TBalloonOptions);
    procedure SetMsgDlgOptions(Value: TMsgDlgOptions);
    procedure SetTipsDlgOptions(Value: TTipsDlgOptions);
    procedure SetGuideDlgOptions(Value: TGuideDlgOptions);
    procedure SetHintDlgOptions(Value: THintDlgOptions);
    function CalcScreenBounds: TRect;
    function CalcBalloonBounds: TRect;
    function CalcBalloonPos(Horizontally: Boolean): TBalloonPos;
    function CreateSpeakRgn: HRgn;
    function CreateThinkRgn: HRgn;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
    {$IFNDEF COMPILER5_UP}
    procedure WMCreate(var Msg: TMessage); message WM_CREATE;
    {$ENDIF}
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMEnable(var Msg: TWMEnable); message WM_ENABLE;
    procedure WMWindowPosChanging(var Msg: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    {$IFDEF COMPILER4_UP}
    procedure CMBiDiModeChanged(var Msg: TMessage); message CM_BIDIMODECHANGED;
    {$ENDIF}
    procedure OptionsChanged(Sender: TObject);
    procedure AnimateBalloon;
    procedure StartAnimateTimer;
    procedure StopAnimateTimer;
    procedure StartHideTimer;
    procedure StopHideTimer;
    procedure Rebuild(ForceUpdate: Boolean);
    function RebuildIconTitleMsg(MinW, BtnsW: Integer): Integer;
    procedure ChangeLabelClass(var ALabel: TControl; ALabelClass: TControlClass);
  private  // Message Balloons
    MsgType: TMsgDlgType;
    MsgButtons: TMsgDlgButtons;
    MsgBtnCount: Integer;
    MsgBtnWidth: Integer;
    MsgBtn: array[TMsgDlgBtn] of TOffice97Button;
    procedure RebuildMsgDlg;
    procedure SelectMsgIcon;
    procedure CreateMsgButtons(DefButton: TMsgDlgBtn);
    procedure MsgBtnClick(Sender: TObject);
  private  // Tips Balloon
    TipPadStr: String;
    TipsBtnCount: Integer;
    TipsBtnWidth: Integer;
    TipsBtn: array[TTipsDlgBtn] of TOffice97Button;
    procedure RebuildTipsDlg;
    procedure SelectTip;
    procedure CreateTipsButtons;
    procedure CreateTipsPadStr;
    procedure TipsBtnClick(Sender: TObject);
  private  // Guide Balloon
    TopGTopic: Word;
    GTopicBtns: TList;
    VisibleGTopics: Word;
    GuideBtnCount: Integer;
    GuideBtnWidth: Integer;
    GuideBtn: array[TGuideDlgBtn] of TOffice97Button;
    procedure DoSearch;
    procedure ShowGuideNextPage;
    procedure ShowGuideBackPage;
    procedure RebuildGuideDlg;
    procedure CreateGuideButtons;
    procedure GuideBtnClick(Sender: TObject);
  private  // Hint Balloon
    TopHTopic: Word;
    HTopicBtns: TList;
    VisibleHTopics: Word;
    HintBtnWidth: Integer;
    HintBtn: array[THintDlgBtn] of TOffice97Button;
    procedure ShowHintNextPage;
    procedure ShowHintBackPage;
    procedure RebuildHintDlg;
    procedure CreateHintButtons;
    procedure HintBtnClick(Sender: TObject);
  private  // InputQuery
    QueryBtnWidth: Integer;
    QueryBtn: array[TQueryDlgBtn] of TOffice97Button;
    procedure RebuildQueryDlg;
    procedure CreateQueryButtons;
    procedure QueryBtnClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowNoActivate;
    procedure Show; virtual;
    function ShowModal: Integer; {$IFDEF COMPILER4_UP} override; {$ENDIF}
    procedure Reposition;
    procedure MoveTo(const Pos: TPoint);
    procedure BringToFront;
    function InputQuery(const ACaption, APrompt: String; var Value: String): Boolean;
    function ShowMsgDlg(const AMsg: String; AType: TMsgDlgType;
      AButtons: TMsgDlgButtons; HelpCtx: LongInt; DefButton: TMsgDlgBtn): Word;
    procedure ShowMessage(const AMsg: String; Timeout: Integer; Shape: TBalloonShape);
    procedure ShowTipsDlg;
    procedure ShowGuideDlg;
    function ShowGuideDlgModal: Word;
    procedure ShowHintDlg;
    function ShowHintDlgModal: Word;
    procedure ShowCustomDlg;
    function ShowCustomDlgModal: Word;
    property Modal: Boolean read FModal;
    property NoActivate: Boolean read FNoActivate write FNoActivate;
    property BalloonPos: TBalloonPos read FBalloonPos;
    property Options: TBalloonOptions read FOptions write SetOptions;
    property MsgDlgOptions: TMsgDlgOptions read FMsgDlgOptions write SetMsgDlgOptions;
    property TipsDlgOptions: TTipsDlgOptions read FTipsDlgOptions write SetTipsDlgOptions;
    property GuideDlgOptions: TGuideDlgOptions read FGuideDlgOptions write SetGuideDlgOptions;
    property HintDlgOptions: THintDlgOptions read FHintDlgOptions write SetHintDlgOptions;
    property Visible: Boolean read FVisible write SetVisible;
    property Anchor: TWinControl read FAnchor write SetAnchor;
    property InternalHide: Boolean read FInternalHide write SetInternalHide;
    property BalloonKind: TBalloonKind read FBalloonKind write SetBalloonKind;
    property OnBalloonShow: TNotifyEvent read FOnBalloonShow write FOnBalloonShow;
    property OnBalloonHide: TNotifyEvent read FOnBalloonHide write FOnBalloonHide;
    property OnCustomLabel: TCustomLabelEvent read FOnCustomLabel write FOnCustomLabel;
  end;


implementation

{$R *.DFM}
{$R *.RES}

uses
  oaConst, oaStage, oaDirect;

const
  DrawTextFlags = DT_NOPREFIX or DT_WORDBREAK or DT_CALCRECT;
  SWPActivateFlags: array[Boolean] of Integer = (0, SWP_NOACTIVATE);
  SWShowFlags: array[Boolean] of Integer = (SW_SHOW, SW_SHOWNOACTIVATE);

{ Helper Functions }

function IsW95NT4OrLower: Boolean;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    Result := (Win32MajorVersion <= 4)
  else
    Result := (Win32MajorVersion <= 4) or
             ((Win32MajorVersion = 4) and (Win32MinorVersion = 0));
end;

function GetDesktopRect: TRect;
const
  SM_XVIRTUALSCREEN = 76;
  SM_YVIRTUALSCREEN = 77;
  SM_CXVIRTUALSCREEN = 78;
  SM_CYVIRTUALSCREEN = 79;
begin
  if not IsW95NT4OrLower then
  begin // Windows 98/Me, Windows 2000/XP
    Result.Left := GetSystemMetrics(SM_XVIRTUALSCREEN);
    Result.Top := GetSystemMetrics(SM_YVIRTUALSCREEN);
    Result.Right := Result.Left + GetSystemMetrics(SM_CXVIRTUALSCREEN);
    Result.Bottom := Result.Top + GetSystemMetrics(SM_CYVIRTUALSCREEN);
  end
  else // Windows 95, NT 4.0
  begin
    Result.Left := 0;
    Result.Top := 0;
    Result.Right := GetSystemMetrics(SM_CXSCREEN);
    Result.Bottom := GetSystemMetrics(SM_CYSCREEN);
  end;
end;

{$IFDEF COMPILER4_UP}
{$IFNDEF COMPILER6_UP}
function MonitorFromWindow(Window: THandle): TMonitor;
var
  MonitorRect: TRect;
  WindowRect: TRect;
  Monitor: TMonitor;
  I: Integer;
begin
  Result := nil;
  GetWindowRect(Window, WindowRect);
  for I := 0 to Screen.MonitorCount - 1 do
  begin
    Monitor := Screen.Monitors[I];
    MonitorRect.Left := Monitor.Left;
    MonitorRect.Top := Monitor.Top;
    MonitorRect.Right := MonitorRect.Left + Monitor.Width;
    MonitorRect.Bottom := MonitorRect.Top + Monitor.Height;
    if IntersectRect(MonitorRect, MonitorRect, WindowRect) then
    begin
      Result := Monitor;
      Exit;
    end;
  end;
end;
{$ENDIF}
{$ENDIF}

{ TTopicOptions}

constructor TTopicOptions.Create;
begin
  inherited Create;
  ID := -1;
  Styles := [];
  OnSelect := nil;
end;

procedure TTopicOptions.Assign(Source: TPersistent);
begin
  if Source is TTopicOptions then
  begin
    ID := TTopicOptions(Source).ID;
    Styles := TTopicOptions(Source).Styles;
    OnSelect := TTopicOptions(Source).OnSelect;
  end
  else
    inherited Assign(Source);
end;

procedure TTopicOptions.ReadData(Stream: TStream);
begin
  Stream.ReadBuffer(fID, SizeOf(fID));
  Stream.ReadBuffer(fStyles, SizeOf(fStyles));
end;

procedure TTopicOptions.WriteData(Stream: TStream);
begin
  Stream.WriteBuffer(fID, SizeOf(fID));
  Stream.WriteBuffer(fStyles, SizeOf(fStyles));
end;

{ TTopicsList }

destructor TTopicsList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TTopicsList.Delete(Index: Integer);
begin
  Options[Index].Free;
  inherited Delete(Index);
end;

procedure TTopicsList.Clear;
var
  I: Integer;
begin
  for I := Count-1 downto 0 do
    Options[I].Free;
  inherited Clear;
end;

function TTopicsList.AddObject(const S: String; AObject: TObject): Integer;
begin
  if AObject is TTopicOptions then
    Result := AddOptions(S, AObject as TTopicOptions)
  else
    Result := AddOptions(S, nil);
end;

function TTopicsList.Add(const S: String): Integer;
begin
  Result := AddOptions(S, nil);
end;

function TTopicsList.AddID(const S: String; ID: Integer): Integer;
var
  Options: TTopicOptions;
begin
  Options := TTopicOptions.Create;
  Options.ID := ID;
  Result := AddItem(S, Options);
end;

function TTopicsList.AddStyle(const S: String; AStyles: TTopicStyles): Integer;
var
  Options: TTopicOptions;
begin
  Options := TTopicOptions.Create;
  Options.Styles := AStyles;
  Result := AddItem(S, Options);
end;

function TTopicsList.AddStyleID(const S: String; AStyles: TTopicStyles; ID: Integer): Integer;
var
  Options: TTopicOptions;
begin
  Options := TTopicOptions.Create;
  Options.Styles := AStyles;
  Options.ID := ID;
  Result := AddItem(S, Options);
end;

function TTopicsList.AddOptions(const S: String; AOptions: TTopicOptions): Integer;
var
  Options: TTopicOptions;
begin
  Options := TTopicOptions.Create;
  if Assigned(AOptions) then
    Options.Assign(AOptions);
  Result := AddItem(S, Options);
end;

function TTopicsList.GetOptions(Index: Integer): TTopicOptions;
begin
  Result := TTopicOptions(Objects[Index]);
end;

procedure TTopicsList.SetOptions(Index: Integer; Value: TTopicOptions);
begin
  TTopicOptions(Objects[Index]).Assign(Value);
end;

procedure TTopicsList.ReadData(Stream: TStream);
var
  I: Integer;
begin
  for I := 0 to Count-1 do
    Options[I].ReadData(Stream);
end;

procedure TTopicsList.WriteData(Stream: TStream);
var
  I: Integer;
begin
  for I := 0 to Count-1 do
    Options[I].WriteData(Stream);
end;

procedure TTopicsList.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Options', ReadData, WriteData, Count > 0);
end;

function TTopicsList.AddItem(const S: String; O: TTopicOptions): Integer;
begin
  {$IFDEF COMPILER6_UP}
  Result := inherited AddObject(S, O);
  {$ELSE}
  Result := inherited Add(S);
  Objects[Result] := O;
  {$ENDIF}
end;

{ TBalloonMetrics }

constructor TBalloonMetrics.Create;
begin
  fBalloonOffset := -5;
  fArrowThickness := 10;
  fArrowLength := 17;
  fThoughtLength := 60;
  fRoundCorner := 15;
  fControlSpacing := 7;
  fMaxButtonSpacing := 26;
  fMinButtonWidth := 58;
  fMinButtonHeight := 20;
  fMinMsgDlgWidth := 175;
  fMinTipsDlgWidth := 480;
  fMinGuideDlgWidth := 170;
  fMinHintDlgWidth := 160;
  fMinQueryDlgWidth := 280;
end;

procedure TBalloonMetrics.Assign(Source: TPersistent);
begin
  if Source is TBalloonMetrics then
  begin
    BalloonOffset := TBalloonMetrics(Source).BalloonOffset;
    ArrowThickness := TBalloonMetrics(Source).ArrowThickness;
    ArrowLength := TBalloonMetrics(Source).ArrowLength;
    ThoughtLength := TBalloonMetrics(Source).ThoughtLength;
    RoundCorner := TBalloonMetrics(Source).RoundCorner;
    ControlSpacing := TBalloonMetrics(Source).ControlSpacing;
    MaxButtonSpacing := TBalloonMetrics(Source).MaxButtonSpacing;
    MinButtonWidth := TBalloonMetrics(Source).MinButtonWidth;
    MinButtonHeight := TBalloonMetrics(Source).MinButtonHeight;
    MinMsgDlgWidth := TBalloonMetrics(Source).MinMsgDlgWidth;
    MinTipsDlgWidth := TBalloonMetrics(Source).MinTipsDlgWidth;
    MinGuideDlgWidth := TBalloonMetrics(Source).MinGuideDlgWidth;
    MinHintDlgWidth := TBalloonMetrics(Source).MinHintDlgWidth;
    MinQueryDlgWidth := TBalloonMetrics(Source).MinQueryDlgWidth;
  end
  else
    inherited Assign(Source);
end;

{ TBalloonOptions }

constructor TBalloonOptions.Create;
begin
  inherited Create;
  FColor := $00C0FFFF;
  FBorderColor := clBlack;
  FOffice2000Look := True;
  FLabelClass := TLabel;
  FFont := TFont.Create;
  FFont.Color := clBlack;
  FFont.OnChange := FontChanged;
  IsFontChanged := False;
  FHoverFont := TFont.Create;
  FHoverFont.Color := clBlack;
  FHoverFont.OnChange := HoverFontChanged;
  IsHoverFontChanged := False;
  FMetrics := TBalloonMetrics.Create;
end;

destructor TBalloonOptions.Destroy;
begin
  FFont.Free;
  FHoverFont.Free;
  FMetrics.Free;
  inherited Destroy;
end;

procedure TBalloonOptions.Assign(Source: TPersistent);
begin
  if Source is TBalloonOptions then
  begin
    Metrics := TBalloonOptions(Source).Metrics;
    Color := TBalloonOptions(Source).Color;
    BorderColor := TBalloonOptions(Source).BorderColor;
    Office2000Look := TBalloonOptions(Source).Office2000Look;
    LabelClass := TBalloonOptions(Source).LabelClass;
    Font := TBalloonOptions(Source).Font;
    HoverFont := TBalloonOptions(Source).HoverFont;
  end
  else
    inherited Assign(Source);
end;

procedure TBalloonOptions.SetMetrics(Value: TBalloonMetrics);
begin
  FMetrics.Assign(Value);
end;

procedure TBalloonOptions.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TBalloonOptions.SetBorderColor(Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TBalloonOptions.SetOffice2000Look(Value: Boolean);
begin
  if FOffice2000Look <> Value then
  begin
    FOffice2000Look := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TBalloonOptions.SetLabelClass(Value: TControlClass);
begin
  if FLabelClass <> Value then
  begin
    FLabelClass := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TBalloonOptions.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TBalloonOptions.SetHoverFont(Value: TFont);
begin
  FHoverFont.Assign(Value);
end;

procedure TBalloonOptions.FontChanged(Sender: TObject);
begin
  IsFontChanged := True;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TBalloonOptions.HoverFontChanged(Sender: TObject);
begin
  IsHoverFontChanged := True;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TBalloonOptions.IsFontStored: Boolean;
begin
  Result := IsFontChanged;
end;

function TBalloonOptions.IsHoverFontStored: Boolean;
begin
  Result := IsHoverFontChanged;
end;

{ TCheckBoxOptions }

constructor TCheckBoxOptions.Create;
begin
  inherited Create;
  FCaption := '';
  FHint := '';
  FAllowGrayed := False;
  FState := cbUnchecked;
  FEnabled := True;
  FVisible := False;
end;

procedure TCheckBoxOptions.Assign(Source: TPersistent);
begin
  if Source is TCheckBoxOptions then
  begin
    Caption := TCheckBoxOptions(Source).Caption;
    Hint := TCheckBoxOptions(Source).Hint;
    AllowGrayed := TCheckBoxOptions(Source).AllowGrayed;
    State := TCheckBoxOptions(Source).State;
    Enabled := TCheckBoxOptions(Source).Enabled;
    Visible := TCheckBoxOptions(Source).Visible;
  end
  else
    inherited Assign(Source);
end;

procedure TCheckBoxOptions.SetCaption(const Value: String);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TCheckBoxOptions.SetHint(const Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TCheckBoxOptions.SetAllowGrayed(Value: Boolean);
begin
  if FAllowGrayed <> Value then
  begin
    FAllowGrayed := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TCheckBoxOptions.SetState(Value: TCheckBoxState);
begin
  if FState <> Value then
  begin
    FState := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

function TCheckBoxOptions.GetChecked: Boolean;
begin
  Result := (FState = cbChecked);
end;

procedure TCheckBoxOptions.SetChecked(Value: Boolean);
begin
  if Value then
    State := cbChecked
  else
    State := cbUnchecked;
end;

procedure TCheckBoxOptions.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TCheckBoxOptions.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

{ TMsgDlgBtns }

const
  MsgBtnResult: array[mbYes..mbHelp] of TModalResult =
    (mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry,
     mrIgnore, mrAll, mrNoToAll, mrYesToAll, mrNone);

{ TMsgDlgOptions }

constructor TMsgDlgOptions.Create;
begin
  inherited Create;
  FTitle := '';
  FCustomIcon := TIcon.Create;
  FCustomIcon.OnChange := CustomIconChanged;
  FCheckBox := TCheckBoxOptions.Create;
  FCheckBox.OnChange := CheckBoxChanged;
  InternalChange := False;
end;

destructor TMsgDlgOptions.Destroy;
begin
  FCheckBox.Free;
  FCustomIcon.Free;
  inherited Destroy;
end;

procedure TMsgDlgOptions.Assign(Source: TPersistent);
begin
  if Source is TMsgDlgOptions then
  begin
    Title := TMsgDlgOptions(Source).Title;
    CustomIcon := TMsgDlgOptions(Source).CustomIcon;
    CheckBox := TMsgDlgOptions(Source).CheckBox;
  end
  else
    inherited Assign(Source);
end;

procedure TMsgDlgOptions.SetTitle(const Value: String);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TMsgDlgOptions.SetCustomIcon(Value: TIcon);
begin
  if FCustomIcon <> Value then
    if Value <> nil then
      FCustomIcon.Assign(Value)
    else
      FCustomIcon.Handle := 0;
end;

procedure TMsgDlgOptions.SetCheckBox(Value: TCheckBoxOptions);
begin
  if FCheckBox <> Value then
    FCheckBox.Assign(Value);
end;

procedure TMsgDlgOptions.CustomIconChanged(Sender: TObject);
begin
  if not InternalChange and Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TMsgDlgOptions.CheckBoxChanged(Sender: TObject);
begin
  if not InternalChange and Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TTipsDlgOptions }

constructor TTipsDlgOptions.Create;
begin
  inherited Create;
  FVisibleButtons := [Low(TTipsDlgBtn)..High(TTipsDlgBtn)];
  FIcon := TIcon.Create;
  FIcon.Handle := LoadIcon(hInstance, 'OABULBICON');
  FTips := TStringList.Create;
  FTips.OnChange := TipsChanged;
  FTipIndex := -1;
  InternalChange := False;
end;

destructor TTipsDlgOptions.Destroy;
begin
  FTips.Free;
  FIcon.Free;
  inherited Destroy;
end;

procedure TTipsDlgOptions.Assign(Source: TPersistent);
begin
  if Source is TTipsDlgOptions then
  begin
    VisibleButtons := TTipsDlgOptions(Source).VisibleButtons;
    Tips := TTipsDlgOptions(Source).Tips;
    TipIndex := TTipsDlgOptions(Source).TipIndex;
    OnTipsTipChange := TTipsDlgOptions(Source).OnTipsTipChange;
  end
  else
    inherited Assign(Source);
end;

procedure TTipsDlgOptions.SetTips(Value: TStringList);
begin
  if FTips <> Value then
  begin
    if Value = nil then
      FTips.Clear
    else
      FTips.Assign(Value);
  end;
end;

procedure TTipsDlgOptions.TipsChanged(Sender: TObject);
begin
  if FTipIndex >= FTips.Count then
    FTipIndex := FTips.Count-1
  else if (FTipIndex = -1) and (FTips.Count > 0) then
    FTipIndex := 0;
  if not InternalChange and Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TTipsDlgOptions.SetTipIndex(Value: Integer);
begin
  if Value < 0 then
    Value := 0;
  if Value >= FTips.Count then
    Value := FTips.Count-1;
  if FTipIndex <> Value then
  begin
    FTipIndex := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TTipsDlgOptions.SetVisibleButtons(Value: TTipsDlgButtons);
begin
  if FVisibleButtons <> Value then
  begin
    FVisibleButtons := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

{ TGuideDlgOptions }

constructor TGuideDlgOptions.Create;
begin
  inherited Create;
  FVisibleButtons := [Low(TGuideDlgCmdBtn)..High(TGuideDlgCmdBtn)];
  FTopics := TTopicsList.Create;
  FTopics.OnChange := TopicsChanged;
  FIcon := TIcon.Create;
  FIcon.OnChange := IconChanged;
  FTitle := '';
  FRequest := '';
  FDescription := '';
  FAcceptRequest := True;
  FRequestResult := False;
  InternalChange := False;
end;

destructor TGuideDlgOptions.Destroy;
begin
  FTopics.Free;
  FIcon.Free;
  inherited Destroy;
end;

procedure TGuideDlgOptions.Assign(Source: TPersistent);
begin
  if Source is TGuideDlgOptions then
  begin
    VisibleButtons := TGuideDlgOptions(Source).VisibleButtons;
    Topics := TGuideDlgOptions(Source).Topics;
    Icon := TGuideDlgOptions(Source).Icon;
    Title := TGuideDlgOptions(Source).Title;
    Request := TGuideDlgOptions(Source).Request;
    Description := TGuideDlgOptions(Source).Description;
    AcceptRequest := TGuideDlgOptions(Source).AcceptRequest;
    RequestResult := TGuideDlgOptions(Source).RequestResult;
    OnGuideRequestChange := TGuideDlgOptions(Source).OnGuideRequestChange;
    OnGuideOptionsClick := TGuideDlgOptions(Source).OnGuideOptionsClick;
    OnGuideTopicClick := TGuideDlgOptions(Source).OnGuideTopicClick;
    OnGuideSearchClick := TGuideDlgOptions(Source).OnGuideSearchClick;
    OnGuideGetBtnStates := TGuideDlgOptions(Source).OnGuideGetBtnStates;
  end
  else
    inherited Assign(Source);
end;

procedure TGuideDlgOptions.SetTopics(Value: TTopicsList);
begin
  if FTopics <> Value then
  begin
    if Value = nil then begin
      FTopics.Clear;
    end
    else
      FTopics.Assign(Value);
  end;
end;

procedure TGuideDlgOptions.TopicsChanged(Sender: TObject);
begin
  if not InternalChange and Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TGuideDlgOptions.SetVisibleButtons(Value: TGuideDlgButtons);
begin
  if FVisibleButtons <> Value then
  begin
    FVisibleButtons := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TGuideDlgOptions.SetTitle(const Value: String);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TGuideDlgOptions.SetRequest(const Value: String);
begin
  if FRequest <> Value then
  begin
    FRequest := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TGuideDlgOptions.SetAcceptRequest(Value: Boolean);
begin
  if FAcceptRequest <> Value then
  begin
    FAcceptRequest := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TGuideDlgOptions.SetRequestResult(Value: Boolean);
begin
  if FRequestResult <> Value then
  begin
    FRequestResult := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TGuideDlgOptions.SetDescription(const Value: String);
begin
  if FDescription <> Value then
  begin
    FDescription := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TGuideDlgOptions.SetIcon(Value: TIcon);
begin
  if FIcon <> Value then
    if Value <> nil then
      FIcon.Assign(Value)
    else
      FIcon.Handle := 0;
end;

procedure TGuideDlgOptions.IconChanged(Sender: TObject);
begin
  if not InternalChange and Assigned(FOnChange) then
    FOnChange(Self);
end;

{ THintDlgOptions }

constructor THintDlgOptions.Create;
begin
  inherited Create;
  FTopics := TTopicsList.Create;
  FTopics.OnChange := TopicsChanged;
  FIcon := TIcon.Create;
  FIcon.OnChange := IconChanged;
  FTitle := '';
  FDescription := '';
  InternalChange := False;
end;

destructor THintDlgOptions.Destroy;
begin
  FTopics.Free;
  FIcon.Free;
  inherited Destroy;
end;

procedure THintDlgOptions.Assign(Source: TPersistent);
begin
  if Source is THintDlgOptions then
  begin
    Topics := THintDlgOptions(Source).Topics;
    Icon := THintDlgOptions(Source).Icon;
    Title := THintDlgOptions(Source).Title;
    Description := THintDlgOptions(Source).Description;
    OnHintTopicClick := THintDlgOptions(Source).OnHintTopicClick;
  end
  else
    inherited Assign(Source);
end;

procedure THintDlgOptions.SetTopics(Value: TTopicsList);
begin
  if FTopics <> Value then
  begin
    if Value = nil then
      FTopics.Clear
    else
      FTopics.Assign(Value);
  end;
end;

procedure THintDlgOptions.TopicsChanged(Sender: TObject);
begin
  if not InternalChange and Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure THintDlgOptions.SetTitle(const Value: String);
begin
  if FTitle <> Value then
  begin
    FTitle := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure THintDlgOptions.SetDescription(const Value: String);
begin
  if FDescription <> Value then
  begin
    FDescription := Value;
    if not InternalChange and Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure THintDlgOptions.SetIcon(Value: TIcon);
begin
  if FIcon <> Value then
    if Value <> nil then
      FIcon.Assign(Value)
    else
      FIcon.Handle := 0;
end;

procedure THintDlgOptions.IconChanged(Sender: TObject);
begin
  if not InternalChange and Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TAssistantBalloon }

constructor TAssistantBalloon.Create(AOwner: TComponent);
begin
  FOptions := TBalloonOptions.Create;
  FMsgDlgOptions := TMsgDlgOptions.Create;
  FTipsDlgOptions := TTipsDlgOptions.Create;
  FGuideDlgOptions := TGuideDlgOptions.Create;
  FHintDlgOptions := THintDlgOptions.Create;
  GTopicBtns := TList.Create;
  HTopicBtns := TList.Create;
  BalloonShape := bsSpeakShape;
  inherited Create(Owner);
  BorderStyle := bsNone;
  {$IFDEF COMPILER4_UP}
  DefaultMonitor := dmDesktop;
  {$ENDIF}
end;

destructor TAssistantBalloon.Destroy;
begin
  FAnchor := nil;
  HTopicBtns.Free;
  GTopicBtns.Free;
  FOptions.Free;
  FMsgDlgOptions.Free;
  FTipsDlgOptions.Free;
  FGuideDlgOptions.Free;
  FHintDlgOptions.Free;
  inherited Destroy;
end;

procedure TAssistantBalloon.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params);
  Params.Style := WS_POPUP;
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and ((Win32MajorVersion > 5) or
     ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)))
  then // Windows XP
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;

procedure TAssistantBalloon.DoCreate;
begin
  FOptions.OnChange := OptionsChanged;
  FMsgDlgOptions.OnChange := OptionsChanged;
  FTipsDlgOptions.OnChange := OptionsChanged;
  FGuideDlgOptions.OnChange := OptionsChanged;
  FHintDlgOptions.OnChange := OptionsChanged;
  OptionsChanged(FOptions);
  {$IFDEF COMPILER5_UP}
  inherited DoCreate;
  {$ENDIF}
end;

procedure TAssistantBalloon.DoHide;
begin
  FVisible := False;
  StopHideTimer;
  if not FInternalHide then
  begin
    if Assigned(FOnBalloonHide) then
      FOnBalloonHide(Self);
    AutoHideDelay := 0;
    ClientOrg := Point(0,0);
    FocusedControl := nil;
    ClientPanel.Visible := False;
  end
  else
    FocusedControl := ActiveControl;
  inherited DoHide;
end;

procedure TAssistantBalloon.ShowNoActivate;
begin
  FNoActivate := True;
  if InternalHide then
    ClientPanel.Visible := True
  else
    Visible := True;
end;

procedure TAssistantBalloon.Show;
begin
  FNoActivate := False;
  if InternalHide then
    ClientPanel.Visible := True
  else
    Visible := True;
end;

function TAssistantBalloon.ShowModal: Integer;
var
  WindowList: Pointer;
  SaveCursor: TCursor;
  SaveFocus: THandle;
  SaveActiveWindow: HWnd;
begin
  if InternalHide then
    ClientPanel.Visible := True
  else
  begin
    CancelDrag;
    if GetCapture <> 0 then
      SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    ReleaseCapture;
    SaveActiveWindow := GetActiveWindow;
    SaveFocus := GetFocus;
    SaveCursor := Screen.Cursor;
    Screen.Cursor := crDefault;
    try
      FNoActivate := False;
      FModal := True;
      Visible := True;
      {$IFDEF COMPILER4_UP}
      Include(FFormState, fsModal);
      {$ENDIF}
      try
        repeat
          Application.ProcessMessages;
        until AnimateTimer = 0;
        WindowList := DisableTaskWindows(WindowHandle);
        try
          SendMessage(WindowHandle, CM_ACTIVATE, 0, 0);
          ModalResult := 0;
          repeat
            Application.HandleMessage;
            if Application.Terminated then
              ModalResult := mrCancel
            else if ModalResult <> 0 then
              CloseModal;
          until ModalResult <> 0;
          SendMessage(WindowHandle, CM_DEACTIVATE, 0, 0);
          if GetActiveWindow <> WindowHandle then
            SaveActiveWindow := 0;
        finally
          EnableTaskWindows(WindowList);
        end;
      finally
        {$IFDEF COMPILER4_UP}
        Exclude(FFormState, fsModal);
        {$ENDIF}
        Visible := False;
        FModal := False;
      end;
    finally
      Screen.Cursor := SaveCursor;
      if SaveActiveWindow <> 0 then
      begin
        SetActiveWindow(SaveActiveWindow);
        if SaveFocus <> 0 then
          Windows.SetFocus(SaveFocus);
      end;
    end;
  end;
  Result := ModalResult;
end;

procedure TAssistantBalloon.CloseModal;
var
  CloseAction: TCloseAction;
begin
  try
    CloseAction := caNone;
    if CloseQuery then
    begin
      CloseAction := caHide;
      {$IFDEF COMPILER4_UP}
      DoClose(CloseAction);
      {$ENDIF}
    end;
    case CloseAction of
      caNone: ModalResult := 0;
      caFree: Release;
    end;
  except
    ModalResult := 0;
    Application.HandleException(Self);
  end;
end;

procedure TAssistantBalloon.BringToFront;
begin
  if Visible then
  begin
    SetWindowPos(WindowHandle, GetWindowOverThis, 0, 0, 0, 0, SWP_NOMOVE or
      SWP_NOSIZE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING or
      SWPActivateFlags[FNoActivate and not FModal]);
  end;
end;

procedure TAssistantBalloon.Paint;
var
  Rgn: HRgn;
begin
  if ClientPanel.Visible then
  begin
    Rgn := CreateRectRgn(0, 0, 0, 0);
    try
      GetWindowRgn(WindowHandle, Rgn);
      Canvas.Brush.Color := Options.BorderColor;
      FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);
      Canvas.Brush.Color := Options.Color;
    finally
      DeleteObject(Rgn);
    end;
  end;
end;

procedure TAssistantBalloon.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if ((BalloonKind <> bkMessage) or (MsgBtnCount = 0)) and (Key = Chr(VK_ESCAPE)) then
  begin
    Key := #0;
    Close;
  end
end;

function TAssistantBalloon.GetWindowOverThis: HWND;
var
  AnchorParentForm: TWinControl;
begin
  if (Anchor <> nil) and Anchor.Visible then
  begin
    AnchorParentForm := GetParentForm(Anchor);
    if AnchorParentForm <> nil then
      Result := GetWindow(AnchorParentForm.Handle, GW_HWNDPREV)
    else
      Result := GetWindow(Anchor.Handle, GW_HWNDPREV);
    if Result = 0 then
    begin
      if (Anchor is TAssistantStage) and
         ((AnchorParentForm = nil) or (AnchorParentForm = Anchor))
      then
        Result := HWND_TOPMOST
      else
        Result := HWND_TOP;
    end;
  end
  else
    Result := HWND_TOPMOST;
end;

procedure TAssistantBalloon.SetVisible(Value: Boolean);
begin
  if Visible <> Value then
  begin
    FVisible := Value;
    if Value then
    begin
      Reposition;
      if not FInternalHide then
        StartAnimateTimer
      else
        FInternalHide := False;
      if GetCurrentThreadID = MainThreadID then
      begin
        SetWindowPos(WindowHandle, GetWindowOverThis, 0, 0, 0, 0,
          SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW or SWP_NOOWNERZORDER or
          SWPActivateFlags[FNoActivate and not FModal]);
        inherited Visible := True;
      end
      else
        ShowWindowAsync(WindowHandle, SWShowFlags[FNoActivate and not FModal]);
    end
    else
    begin
      if GetCurrentThreadID = MainThreadID then
        inherited Visible := False
      else
        ShowWindowAsync(WindowHandle, SW_HIDE);
    end;
  end;
end;

procedure TAssistantBalloon.SetAnchor(Value: TWinControl);
begin
  if FAnchor <> Value then
  begin
    FAnchor := Value;
    if Visible then Reposition;
  end;
end;

procedure TAssistantBalloon.SetInternalHide(Value: Boolean);
begin
  if FInternalHide <> Value then
  begin
    if Value then
    begin
      FInternalHide := True;
      Visible := False;
    end
    else
    begin
      if ClientPanel.Visible then Visible := True;
      FInternalHide := False;
    end;
  end;
end;

procedure TAssistantBalloon.SetOptions(Value: TBalloonOptions);
begin
  if (FOptions <> Value) and Assigned(Value) then
    FOptions.Assign(Value);
end;

procedure TAssistantBalloon.SetMsgDlgOptions(Value: TMsgDlgOptions);
begin
  if (FMsgDlgOptions <> Value) and Assigned(Value) then
    FMsgDlgOptions.Assign(Value);
end;

procedure TAssistantBalloon.SetTipsDlgOptions(Value: TTipsDlgOptions);
begin
  if (FTipsDlgOptions <> Value) and Assigned(Value) then
    FTipsDlgOptions.Assign(Value);
end;

procedure TAssistantBalloon.SetGuideDlgOptions(Value: TGuideDlgOptions);
begin
  if (FGuideDlgOptions <> Value) and Assigned(Value) then
    FGuideDlgOptions.Assign(Value);
end;

procedure TAssistantBalloon.SetHintDlgOptions(Value: THintDlgOptions);
begin
  if (FHintDlgOptions <> Value) and Assigned(Value) then
    FHintDlgOptions.Assign(Value);
end;

type
  TWinControlHack = class(TWinControl);

procedure TAssistantBalloon.Reposition;
var
  I: Integer;
  CustomPanel: TCustomPanel;
begin
  HandleNeeded;
  ScrBounds := CalcScreenBounds;
  if fAnchor <> nil then
  begin
    RefBounds := fAnchor.BoundsRect;
    if fAnchor.ParentWindow <> 0 then
      MapWindowPoints(fAnchor.ParentWindow, 0, RefBounds, 2)
    else if fAnchor.Parent <> nil then
      MapWindowPoints(fAnchor.Parent.Handle, 0, RefBounds, 2);
  end;
  if BalloonShape = bsSpeakShape then
    ExtraSize := Options.Metrics.ArrowLength
  else
    ExtraSize := Options.Metrics.ThoughtLength;
  CustomPanel := nil;
  if BalloonKind = bkCustom then
  begin
    for I := 0 to ControlCount-1 do
      if (Controls[I] is TCustomPanel) and (Controls[I] <> ClientPanel) then
      begin
        CustomPanel := TCustomPanel(Controls[I]);
        ClientPanel.Width := CustomPanel.Width;
        ClientPanel.Height := CustomPanel.Height;
        Break;
      end;
  end;
  ClientSize.X := ClientPanel.Width + Options.Metrics.RoundCorner div 2;
  ClientSize.Y := ClientPanel.Height + Options.Metrics.RoundCorner div 2;
  if not AbsolutePositioning then
    fBalloonPos := CalcBalloonPos(BalloonKind = bkTips);
  if fBalloonPos in [bpRightTop, bpRightBottom] then
    ClientOrg.X := ExtraSize
  else
    ClientOrg.X := 0;
  if fBalloonPos in [bpBottomLeft, bpBottomRight] then
    ClientOrg.Y := ExtraSize
  else
    ClientOrg.Y := 0;
  ClientPanel.SetBounds(ClientOrg.X + Options.Metrics.RoundCorner div 4,
                        ClientOrg.Y + Options.Metrics.RoundCorner div 4,
                        ClientPanel.Width, ClientPanel.Height);
  if CustomPanel <> nil then
    CustomPanel.BoundsRect := ClientPanel.BoundsRect;
  BoundsRect := CalcBalloonBounds;
  if InternalHide or (Visible and (AnimateTimer = 0)) then
  begin
    if BalloonShape = bsSpeakShape then
      SetWindowRgn(WindowHandle, CreateSpeakRgn, True)
    else
      SetWindowRgn(WindowHandle, CreateThinkRgn, True);
    if Visible then
    begin
      InvalidateRect(WindowHandle, nil, True);
      UpdateWindow(WindowHandle);
    end;
  end;
end;

procedure TAssistantBalloon.MoveTo(const Pos: TPoint);
var
  NewBalloonPos: TBalloonPos;
begin
  if not AbsolutePositioning then
  begin
    AbsolutePositioning := True;
    NewBalloonPos := bpTopRight;
    {$IFDEF COMPILER4_UP}
    if UseRightToLeftAlignment then
      NewBalloonPos := bpTopLeft;
    {$ENDIF}
    if FBalloonPos <> NewBalloonPos then
    begin
      FBalloonPos := NewBalloonPos;
      Reposition;
    end;
    AbsolutePositioning := False;
  end;
  case FBalloonPos of
    bpTopLeft:
      SetBounds(Pos.X - RelativeOffset, Pos.Y - Height, Width, Height);
    bpTopRight:
      SetBounds(Pos.X - (Width - RelativeOffset), Pos.Y - Height, Width, Height);
    bpRightTop:
      SetBounds(Pos.X, Pos.Y - RelativeOffset, Width, Height);
    bpRightBottom:
      SetBounds(Pos.X, Pos.Y - (Height - RelativeOffset), Width, Height);
    bpLeftTop:
      SetBounds(Pos.X - Width, Pos.Y - RelativeOffset, Width, Height);
    bpLeftBottom:
      SetBounds(Pos.X - Width, Pos.Y - (Height - RelativeOffset), Width, Height);
    bpBottomLeft:
      SetBounds(Pos.X - RelativeOffset, Pos.Y, Width, Height);
    bpBottomRight:
      SetBounds(Pos.X - (Width - RelativeOffset), Pos.Y, Width, Height);
    bpCenter:
      SetBounds(Pos.X - (Width div 2), Pos.Y - (Height div 2), Width, Height);
  end;
end;

function TAssistantBalloon.CalcScreenBounds: TRect;
{$IFDEF COMPILER4_UP}
var
  NearestMonitor: TMonitor;
{$ENDIF}
begin
  {$IFDEF COMPILER4_UP}
  if AbsolutePositioning or (Anchor = nil) or
     IsW95NT4OrLower or (Screen.MonitorCount < 2)
  then
    Result := GetDesktopRect
  else
  begin
    {$IFDEF COMPILER6_UP}
    NearestMonitor := Screen.MonitorFromWindow(Anchor.Handle);
    {$ELSE}
    NearestMonitor := MonitorFromWindow(Anchor.Handle);
    {$ENDIF}
    if NearestMonitor <> nil then
    begin
      {$IFDEF COMPILER6_UP}
      Result := NearestMonitor.WorkareaRect;
      {$ELSE}
      Result.Left := NearestMonitor.Left;
      Result.Top := NearestMonitor.Top;
      Result.Right := Result.Left + NearestMonitor.Width;
      Result.Bottom := Result.Top + NearestMonitor.Height;
      {$ENDIF}
    end
    else
      Result := GetDesktopRect;
  end;
  {$ELSE}
  Result := GetDesktopRect;
  {$ENDIF}
end;

function TAssistantBalloon.CalcBalloonBounds: TRect;
begin
  case fBalloonPos of
    bpTopRight:
    begin
      Result.Left := RefBounds.Right - ClientSize.X;
      Result.Top := RefBounds.Top - (ClientSize.Y + ExtraSize) - Options.Metrics.BalloonOffset;
      Result.Right := Result.Left + ClientSize.X;
      Result.Bottom := Result.Top + ClientSize.Y + ExtraSize;
    end;
    bpTopLeft:
    begin
      Result.Left := RefBounds.Left;
      Result.Top := RefBounds.Top - (ClientSize.Y + ExtraSize) - Options.Metrics.BalloonOffset;
      Result.Right := Result.Left + ClientSize.X;
      Result.Bottom := Result.Top + ClientSize.Y + ExtraSize;
    end;
    bpRightTop:
    begin
      Result.Left := RefBounds.Right + Options.Metrics.BalloonOffset;
      Result.Top := RefBounds.Top;
      Result.Right := Result.Left + ClientSize.X + ExtraSize;
      Result.Bottom := Result.Top + ClientSize.Y;
    end;
    bpRightBottom:
    begin
      Result.Left := RefBounds.Right + Options.Metrics.BalloonOffset;
      Result.Top := RefBounds.Bottom - ClientSize.Y;
      Result.Right := Result.Left + ClientSize.X + ExtraSize;
      Result.Bottom := Result.Top + ClientSize.Y;
    end;
    bpBottomLeft:
    begin
      Result.Left := RefBounds.Left;
      Result.Top := RefBounds.Bottom + Options.Metrics.BalloonOffset;
      Result.Right := Result.Left + ClientSize.X;
      Result.Bottom := Result.Top + ClientSize.Y + ExtraSize;
    end;
    bpBottomRight:
    begin
      Result.Left := RefBounds.Right - ClientSize.X;
      Result.Top := RefBounds.Bottom + Options.Metrics.BalloonOffset;
      Result.Right := Result.Left + ClientSize.X;
      Result.Bottom := Result.Top + ClientSize.Y + ExtraSize;
    end;
    bpLeftBottom:
    begin
      Result.Left := RefBounds.Left - (ClientSize.X + ExtraSize) - Options.Metrics.BalloonOffset;
      Result.Top := RefBounds.Bottom - ClientSize.Y;
      Result.Right := Result.Left + ClientSize.X + ExtraSize;
      Result.Bottom := Result.Top + ClientSize.Y;
    end;
    bpLeftTop:
    begin
      Result.Left := RefBounds.Left - (ClientSize.X + ExtraSize) - Options.Metrics.BalloonOffset;
      Result.Top := RefBounds.Top;
      Result.Right := Result.Left + ClientSize.X + ExtraSize;
      Result.Bottom := Result.Top + ClientSize.Y;
    end;
  else
    Result.Left := (Screen.Width - ClientSize.X) div 2;
    Result.Top := (Screen.Height - ClientSize.Y) div 2;
    Result.Right := Result.Left + ClientSize.X;
    Result.Bottom := Result.Top + ClientSize.Y;
  end;
  if Result.Left <= ScrBounds.Left then
    OffsetRect(Result, ScrBounds.Left - Result.Left + 1, 0);
  if Result.Right >= ScrBounds.Right then
    OffsetRect(Result, ScrBounds.Right - Result.Right - 1, 0);
  if Result.Top <= ScrBounds.Top then
    OffsetRect(Result, 0, ScrBounds.Top - Result.Top + 1);
  if Result.Bottom >= ScrBounds.Bottom then
    OffsetRect(Result, 0, ScrBounds.Bottom - Result.Bottom - 1);
end;

function TAssistantBalloon.CalcBalloonPos(Horizontally: Boolean): TBalloonPos;
var
  Space, ExSpace: TRect;
  MaxV, MaxH: Integer;

  function FindPosHorizontally: TBalloonPos;
  var
    V, H: TBalloonPos;
  begin
    V := bpTopLeft;
    if ((ExSpace.Top > ExSpace.Bottom) and (ExSpace.Top < ClientSize.Y)) or (RefBounds.Top < 0) then
      V := bpBottomLeft;
    {$IFDEF COMPILER4_UP}
    if UseRightToLeftAlignment then
    begin
      H := bpLeftTop;
      if (Space.Left < Space.Right) and (Space.Left < (ClientSize.X + ExtraSize)) then
        H := bpRightTop;
    end
    else
    {$ENDIF}
    begin
      H := bpRightTop;
      if (Space.Right < Space.Left) and (Space.Right < (ClientSize.X + ExtraSize)) then
        H := bpLeftTop;
    end;
    if V = bpTopLeft then
      if H = bpLeftTop then
        Result := bpLeftTop
      else
        Result := bpRightTop
    else
      if H = bpLeftTop then
        Result := bpLeftBottom
      else
        Result := bpRightBottom;
  end;

  function FindPosVertically: TBalloonPos;
  var
    V, H: TBalloonPos;
  begin
    {$IFDEF COMPILER4_UP}
    if UseRightToLeftAlignment then
    begin
      H := bpRightTop;
      if (ExSpace.Right > ExSpace.Left) and (ExSpace.Left < ClientSize.X) then
        H := bpLeftTop;
    end
    else
    {$ENDIF}
    begin
      H := bpLeftTop;
      if (ExSpace.Left > ExSpace.Right) and (ExSpace.Right < ClientSize.X) then
        H := bpRightTop;
    end;
    V := bpTopLeft;
    if (Space.Top < Space.Bottom) and (Space.Top < (ClientSize.Y + ExtraSize)) then
      V := bpBottomLeft;
    if V = bpTopLeft then
      if H = bpLeftTop then
        Result := bpTopLeft
      else
        Result := bpTopRight
    else
      if H = bpLeftTop then
        Result := bpBottomLeft
      else
        Result := bpBottomRight;
  end;

begin
  if (fAnchor = nil) or not fAnchor.Visible then
    Result := bpCenter
  else
  begin
    Space.Left := RefBounds.Left - ScrBounds.Left;
    Space.Top := RefBounds.Top - ScrBounds.Top;
    Space.Right := ScrBounds.Right - RefBounds.Right;
    Space.Bottom := ScrBounds.Bottom - RefBounds.Bottom;
    ExSpace.Left := Space.Left + (RefBounds.Right - RefBounds.Left);
    ExSpace.Top := Space.Top + (RefBounds.Bottom - RefBounds.Top) ;
    ExSpace.Right := Space.Right + (RefBounds.Right - RefBounds.Left);
    ExSpace.Bottom := Space.Bottom + (RefBounds.Bottom - RefBounds.Top);
    if Space.Right >= Space.Left then
      MaxH := Space.Right
    else
      MaxH := Space.Left;
    if Space.Top >= Space.Bottom then
      MaxV := Space.Top
    else
      MaxV := Space.Bottom;
    Horizontally := Horizontally or (Space.Top < (ClientSize.Y + ExtraSize));
    if (Horizontally and (MaxH >= (ClientSize.X + ExtraSize))) or
       (MaxV < (ClientSize.Y + ExtraSize))
    then
      Result := FindPosHorizontally
    else
      Result := FindPosVertically;
  end;
end;

function TAssistantBalloon.CreateSpeakRgn: HRgn;
var
  AP: array[0..2] of TPoint;
  Offset, hOffset: Integer;
  Rgn: HRgn;
begin
  if fBalloonPos in [bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight] then
  begin
    if Width < (RefBounds.Right - RefBounds.Left) then
      Offset := 3 * Width div 4
    else
      Offset := 2 * (RefBounds.Right - RefBounds.Left) div 3;
    if RefBounds.Left <= ScrBounds.Left then
      Dec(Offset, ScrBounds.Left - RefBounds.Left + 1);
    if RefBounds.Right >= ScrBounds.Right then
      Inc(Offset, ScrBounds.Right - RefBounds.Right - 1);
    if Offset < Options.Metrics.RoundCorner then
      Offset := Options.Metrics.RoundCorner
    else if Offset > Width then
      Offset := Width - Options.Metrics.RoundCorner - Options.Metrics.ArrowThickness;
  end
  else
  begin
    Offset := 40;
    if (Top < RefBounds.Top) and (fBalloonPos in [bpLeftTop, bpRightTop]) then
      Inc(Offset, RefBounds.Top - Top)
    else if ((Top + Height) > RefBounds.Bottom) and
      (fBalloonPos in [bpLeftBottom, bpRightBottom])
    then
      Inc(Offset, (Top + Height) - RefBounds.Bottom);
    if RefBounds.Top <= ScrBounds.Top then
      Inc(Offset, ScrBounds.Top - RefBounds.Top + 1);
    if RefBounds.Bottom >= ScrBounds.Bottom then
      Inc(Offset, ScrBounds.Bottom - RefBounds.Bottom - 1);
    if Offset < Options.Metrics.RoundCorner then
      Offset := Options.Metrics.RoundCorner
    else if Offset > Height then
      Offset := Height - Options.Metrics.RoundCorner - Options.Metrics.ArrowThickness;
  end;
  case fBalloonPos of
    bpTopLeft:
    begin
      AP[0] := Point(Offset, Height-Options.Metrics.ArrowLength-1);
      AP[1] := Point(Offset+Options.Metrics.ArrowThickness, Height-Options.Metrics.ArrowLength-1);
      AP[2] := Point(Offset, Height-1);
    end;
    bpTopRight:
    begin
      AP[0] := Point(Width-Offset-Options.Metrics.ArrowThickness-1, Height-Options.Metrics.ArrowLength-1);
      AP[1] := Point(Width-Offset-1, Height-Options.Metrics.ArrowLength-1);
      AP[2] := Point(Width-Offset-1, Height-1);
    end;
    bpBottomLeft:
    begin
      AP[0] := Point(Offset, Options.Metrics.ArrowLength);
      AP[1] := Point(Offset+Options.Metrics.ArrowThickness, Options.Metrics.ArrowLength);
      AP[2] := Point(Offset, 0);
    end;
    bpBottomRight:
    begin
      AP[0] := Point(Width-Offset-Options.Metrics.ArrowThickness-1, Options.Metrics.ArrowLength);
      AP[1] := Point(Width-Offset-1, Options.Metrics.ArrowLength);
      AP[2] := Point(Width-Offset-1, 0);
    end;
    bpRightTop:
    begin
      // Fixed by Riceball, substract RoundCorner
      hOffset := Offset-Options.Metrics.RoundCorner;
      if hOffset < Options.Metrics.RoundCorner then
        hOffset := Options.Metrics.RoundCorner;
      AP[0] := Point(Options.Metrics.ArrowLength, hOffset);
      AP[1] := Point(Options.Metrics.ArrowLength, hOffset+Options.Metrics.ArrowThickness);
      AP[2] := Point(0, hOffset);
    end;
    bpRightBottom:
    begin
      // Fixed by Riceball, substract RoundCorner
      hOffset := Height-Offset-Options.Metrics.RoundCorner;
      if hOffset < Options.Metrics.RoundCorner then
        hOffset := Options.Metrics.RoundCorner;
      AP[0] := Point(Options.Metrics.ArrowLength, hOffset);
      AP[1] := Point(Options.Metrics.ArrowLength, hOffset+Options.Metrics.ArrowThickness);
      AP[2] := Point(0, hOffset);
    end;
    bpLeftTop:
    begin
      // Fixed by Riceball, substract RoundCorner
      hOffset := Offset-Options.Metrics.RoundCorner;
      if hOffset < Options.Metrics.RoundCorner then
        hOffset := Options.Metrics.RoundCorner;
      AP[0] := Point(Width-Options.Metrics.ArrowLength-1, hOffset);
      AP[1] := Point(Width-Options.Metrics.ArrowLength-1, hOffset+Options.Metrics.ArrowThickness);
      AP[2] := Point(Width-1, hOffset);
    end;
    bpLeftBottom:
    begin
      // Fixed by Riceball, Substract RoundCorner
      hOffset := Height-Offset-Options.Metrics.RoundCorner;
      if hOffset < Options.Metrics.RoundCorner then
        hOffset := Options.Metrics.RoundCorner;
      AP[0] := Point(Width-Options.Metrics.ArrowLength-1, hOffset);
      AP[1] := Point(Width-Options.Metrics.ArrowLength-1, hOffset+Options.Metrics.ArrowThickness);
      AP[2] := Point(Width-1, hOffset);
    end;
  end;
  Result := CreateRoundRectRgn(ClientOrg.X, ClientOrg.Y,
    ClientOrg.X + ClientSize.X, ClientOrg.Y + ClientSize.Y,
    Options.Metrics.RoundCorner, Options.Metrics.RoundCorner);
  if FBalloonPos <> bpCenter then
  begin
    Rgn := CreatePolygonRgn(AP, 3, WINDING);
    CombineRgn(Result, Result, Rgn, RGN_OR);
    DeleteObject(Rgn);
  end;
  RelativeOffset := Offset;
end;

function TAssistantBalloon.CreateThinkRgn: HRgn;
var
  Offset1, Offset2, Radius: Integer;
  I, X, Y: Integer;
  Rgns: array[1..3] of HRgn;
begin
  if FBalloonPos in [bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight] then
  begin
    Offset1 := (RefBounds.Right - RefBounds.Left) div 2 + 5;
    if RefBounds.Left <= ScrBounds.Left then
      Dec(Offset1, ScrBounds.Left - RefBounds.Left + 1);
    if RefBounds.Right >= ScrBounds.Right then
      Inc(Offset1, ScrBounds.Right - RefBounds.Right - 1);
    if Offset1 < Options.Metrics.RoundCorner then
      Offset1 := Options.Metrics.RoundCorner
    else if Offset1 > Width then
      Offset1 := Width - Options.Metrics.RoundCorner;
    Offset2 := ClientPanel.Width div 2;
  end
  else
  begin
    Offset1 := 30;
    if RefBounds.Top <= ScrBounds.Top then
      Inc(Offset1, ScrBounds.Top - RefBounds.Top + 1);
    if RefBounds.Bottom >= ScrBounds.Bottom then
      Inc(Offset1, ScrBounds.Bottom - RefBounds.Bottom - 1);
    if Offset1 < Options.Metrics.RoundCorner then
      Offset1 := Options.Metrics.RoundCorner
    else if Offset1 > Height then
      Offset1 := Height - Options.Metrics.RoundCorner;
    Offset2 := ClientPanel.Height div 2;
  end;
  case FBalloonPos of
    bpTopLeft:
      for I := 1 to 3 do
      begin
        Y := Height - (2 * I - 1) * Options.Metrics.ThoughtLength div 6 + 2 * I;
        X := OffSet1 + (I - 1) * (Offset2 - Offset1) div 3;
        Radius := (Options.Metrics.ThoughtLength div 7) + 2 * I - 4;
        Rgns[I] := CreateEllipticRgn(X - Radius, Y - Radius, X + Radius, Y + Radius);
      end;
    bpTopRight:
      for I := 1 to 3 do
      begin
        Y := Height - (2 * I - 1) * Options.Metrics.ThoughtLength div 6 + 2 * I;
        X := Width - OffSet1 - (I - 1) * (Offset2 - Offset1) div 3;
        Radius := (Options.Metrics.ThoughtLength div 7) + 2 * I - 4;
        Rgns[I] := CreateEllipticRgn(X - Radius, Y - Radius, X + Radius, Y + Radius);
      end;
    bpBottomLeft:
      for I := 1 to 3 do
      begin
        Y := (2 * I - 1) * Options.Metrics.ThoughtLength div 6 - 2 * I;
        X := OffSet1 + (I - 1) * (Offset2 - Offset1) div 3;
        Radius := (Options.Metrics.ThoughtLength div 7) + 2 * I - 4;
        Rgns[I] := CreateEllipticRgn(X - Radius, Y - Radius, X + Radius, Y + Radius);
      end;
    bpBottomRight:
      for I := 1 to 3 do
      begin
        Y := (2 * I - 1) * Options.Metrics.ThoughtLength div 6 - 2 * I;
        X := Width - OffSet1 - (I - 1) * (Offset2 - Offset1) div 3;
        Radius := (Options.Metrics.ThoughtLength div 7) + 2 * I - 4;
        Rgns[I] := CreateEllipticRgn(X - Radius, Y - Radius, X + Radius, Y + Radius);
      end;
    bpLeftTop:
      for I := 1 to 3 do
      begin
        X := Width - (2 * I - 1) * Options.Metrics.ThoughtLength div 6 + 2 * I;
        Y := OffSet1 + (I - 1) * (Offset2 - Offset1) div 3;
        Radius := (Options.Metrics.ThoughtLength div 7) + 2 * I - 4;
        Rgns[I] := CreateEllipticRgn(X - Radius, Y - Radius, X + Radius, Y + Radius);
      end;
    bpLeftBottom:
      for I := 1 to 3 do
      begin
        X := Width - (2 * I - 1) * Options.Metrics.ThoughtLength div 6 + 2 * I;
        Y := Height - OffSet1 - (I - 1) * (Offset2 - Offset1) div 3;
        Radius := (Options.Metrics.ThoughtLength div 7) + 2 * I - 4;
        Rgns[I] := CreateEllipticRgn(X - Radius, Y - Radius, X + Radius, Y + Radius);
      end;
    bpRightTop:
      for I := 1 to 3 do
      begin
        X := (2 * I - 1) * Options.Metrics.ThoughtLength div 6 - 2 * I;
        Y := OffSet1 + (I - 1) * (Offset2 - Offset1) div 3;
        Radius := (Options.Metrics.ThoughtLength div 7) + 2 * I - 4;
        Rgns[I] := CreateEllipticRgn(X - Radius, Y - Radius, X + Radius, Y + Radius);
      end;
    bpRightBottom:
      for I := 1 to 3 do
      begin
        X := (2 * I - 1) * Options.Metrics.ThoughtLength div 6 - 2 * I;
        Y := Height - OffSet1 - (I - 1) * (Offset2 - Offset1) div 3;
        Radius := (Options.Metrics.ThoughtLength div 7) + 2 * I - 4;
        Rgns[I] := CreateEllipticRgn(X - Radius, Y - Radius, X + Radius, Y + Radius);
      end;
  end;
  Result := CreateRoundRectRgn(ClientOrg.X, ClientOrg.Y,
    ClientOrg.X + ClientSize.X, ClientOrg.Y + ClientSize.Y,
    Options.Metrics.RoundCorner, Options.Metrics.RoundCorner);
  if FBalloonPos <> bpCenter then
    for I := 1 to 3 do
    begin
      CombineRgn(Result, Result, Rgns[I], RGN_OR);
      DeleteObject(Rgns[I]);
    end;
  RelativeOffset := Offset1;
end;

procedure TAssistantBalloon.StartHideTimer;
begin
  HideTimer := SetTimer(Handle, 1999, AutoHideDelay, nil);
end;

procedure TAssistantBalloon.StopHideTimer;
begin
  if HideTimer <> 0 then
  begin
    KillTimer(Handle, HideTimer);
    HideTimer := 0;
  end;
end;

procedure TAssistantBalloon.AnimateBalloon;
var
  R: TRect;
  I: Integer;
  Rgn1, Rgn2: HRgn;
begin
  for I := 1 to 4 do
  begin
    with ClientPanel do
    begin
      SetRect(R, Width div 2,  Height div 2, Width div 2, Height div 2);
      InflateRect(R, Width * I div 10, Height * I div 10);
    end;
    OffsetRect(R, ClientOrg.X, ClientOrg.Y);
    Rgn1 := CreateRectRgnIndirect(R);
    InflateRect(R, -1, -1);
    Rgn2 := CreateRectRgnIndirect(R);
    CombineRgn(Rgn1, Rgn2, Rgn1, RGN_XOR);
    DeleteObject(Rgn2);
    SetWindowRgn(WindowHandle, Rgn1, True);
    WaitForSyncObject(GetCurrentThread, 90 - 20 * I);
  end;
  Color := FOptions.Color;
  if BalloonShape = bsSpeakShape then
    SetWindowRgn(WindowHandle, CreateSpeakRgn, True)
  else
    SetWindowRgn(WindowHandle, CreateThinkRgn, True);
  ClientPanel.Visible := True;
  UpdateWindow(WindowHandle);
  if Assigned(FocusedControl) then
    ActiveControl := FocusedControl;
  if AutoHideDelay > 0 then
    StartHideTimer;
  if Assigned(FOnBalloonShow) then
    FOnBalloonShow(Self);
end;

procedure TAssistantBalloon.StartAnimateTimer;
begin
  Color := FOptions.BorderColor;
  SetWindowRgn(WindowHandle, CreateRectRgn(0, 0, 0, 0), True);
  AnimateTimer := SetTimer(WindowHandle, 1970, 0, nil);
end;

procedure TAssistantBalloon.StopAnimateTimer;
begin
  if AnimateTimer <> 0 then
  begin
    KillTimer(Handle, AnimateTimer);
    AnimateTimer := 0;
  end;
end;

procedure TAssistantBalloon.WMTimer(var Msg: TWMTimer);
begin
  if Msg.TimerID = AnimateTimer then
  begin
    StopAnimateTimer;
    AnimateBalloon;
  end
  else if Msg.TimerID = HideTimer then
  begin
    StopHideTimer;
    FInternalHide := False;
    Close;
  end;
end;

{$IFNDEF COMPILER5_UP}
procedure TAssistantBalloon.WMCreate(var Msg: TMessage);
begin
  DoCreate;
  inherited;
end;
{$ENDIF}

procedure TAssistantBalloon.WMMouseActivate(var Msg: TWMMouseActivate);
begin
  if FNoActivate and not FModal then
  begin
    Msg.Result := MA_NOACTIVATE;
    if ActiveControl = nil then Close;
  end
  else
    inherited;
end;

procedure TAssistantBalloon.WMEnable(var Msg: TWMEnable);
begin
  inherited;
  if Visible and not Msg.Enabled then
  begin
    SetWindowPos(WindowHandle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOSIZE or
      SWP_NOMOVE or SWP_NOREPOSITION or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING);
    EnableWindow(WindowHandle, True);
    Application.NormalizeAllTopMosts;
    SetWindowPos(WindowHandle, GetWindowOverThis, 0, 0, 0, 0, SWP_NOSIZE or
      SWP_NOMOVE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING);
  end;
end;

procedure TAssistantBalloon.WMWindowPosChanging(var Msg: TWMWindowPosMsg);
begin
  if Visible then
    Msg.WindowPos^.hwndInsertAfter := GetWindowOverThis
  else
    inherited;
end;

{$IFDEF COMPILER4_UP}
procedure TAssistantBalloon.CMBiDiModeChanged(var Msg: TMessage);
begin
  inherited;
  ClientPanel.Visible := False;
  Rebuild(False);
  if Visible then InvalidateRect(WindowHandle, nil, True);
  ClientPanel.Visible := Visible or FInternalHide;
end;
{$ENDIF}

procedure TAssistantBalloon.ChangeLabelClass(var ALabel: TControl;
  ALabelClass: TControlClass);
var
  NewLabel: TControl;
begin
  NewLabel := ALabelClass.Create(ClientPanel);
  NewLabel.Visible := False;
  NewLabel.Parent := ClientPanel;
  if NewLabel is TLabel then
  begin
    TLabel(NewLabel).AutoSize := False;
    TLabel(NewLabel).ShowAccelChar := False;
    TLabel(NewLabel).WordWrap := True;
  end
  else if Assigned(FOnCustomLabel) then
  begin
    try
      FOnCustomLabel(Self, NewLabel);
    except
      Newlabel.Free;
      raise;
    end;
  end;
  ALabel.Free;
  ALabel := NewLabel;
end;

procedure TAssistantBalloon.OptionsChanged(Sender: TObject);
begin
  if csDestroying in ComponentState then Exit;
  if Sender is TBalloonOptions then
  begin
    if not (Title is Options.LabelClass) then
      ChangeLabelClass(TControl(Title), Options.LabelClass);
    if not (Msg is Options.LabelClass) then
      ChangeLabelClass(TControl(Msg), Options.LabelClass);
    Color := Options.Color;
    Font := Options.Font;
    LineHeight := Canvas.TextHeight('H');
    BtnHeight := LineHeight + 10;
    if BtnHeight < Options.Metrics.MinButtonHeight then
      BtnHeight := Options.Metrics.MinButtonHeight;
    Title.Font := Options.Font;
    Title.Font.Style := Options.Font.Style + [fsBold];
    if Options.Office2000Look then
      ButtonSpace := Options.Metrics.MaxButtonSpacing div 2
    else
      ButtonSpace := Options.Metrics.MaxButtonSpacing;
    CreateMsgButtons(mbNone);
    CreateTipsButtons;
    CreateGuideButtons;
    CreateHintButtons;
    CreateQueryButtons;
    Rebuild(False);
  end
  else if ((Sender is TMsgDlgOptions) and (BalloonKind in [bkMessage, bkSpeak, bkThink])) or
          ((Sender is TTipsDlgOptions) and (BalloonKind = bkTips)) or
          ((Sender is TGuideDlgOptions) and (BalloonKind = bkGuide)) or
          ((Sender is THintDlgOptions) and (BalloonKind = bkHint)) then
    Rebuild(False);
end;

procedure TAssistantBalloon.SetBalloonKind(Value: TBalloonKind);
var
  I: Integer;
begin
  if BalloonKind <> Value then
  begin
    FBalloonKind := Value;
    for I := 0 to ClientPanel.ControlCount-1 do
      ClientPanel.Controls[I].Visible := False;
    for I := 0 to TopicsPanel.ControlCount-1 do
      TopicsPanel.Controls[I].Visible := False;
    Rebuild(False);
  end;
end;

procedure TAssistantBalloon.Rebuild(ForceUpdate: Boolean);
begin
  if Visible or ForceUpdate then
  begin
    case BalloonKind of
      bkSpeak, bkThink, bkMessage: RebuildMsgDlg;
      bkTips: RebuildTipsDlg;
      bkGuide: RebuildGuideDlg;
      bkHint: RebuildHintDlg;
      bkQuery: RebuildQueryDlg;
    end;
    if Visible then Reposition;
  end;
end;

function TAssistantBalloon.RebuildIconTitleMsg(MinW, BtnsW: Integer): Integer;
var
  MsgRect: TRect;
  TitleRect: TRect;
  IconSpace: Integer;
  MsgTopPos: Integer;
begin
  Dec(MinW, 2 * Options.Metrics.ControlSpacing);
  if BtnsW > MinW then MinW := BtnsW;
  MsgTopPos := Options.Metrics.ControlSpacing;
  SetRect(MsgRect, 0, 0, MinW, 0);
  DrawText(Canvas.Handle, PChar(Msg.Caption), Length(Msg.Caption), MsgRect,
    {$IFDEF COMPILER4_UP}DrawTextBiDiModeFlags{$ENDIF}(DrawTextFlags));
  if MsgRect.Right < MinW then MsgRect.Right := MinW;
  IconSpace := 0;
  if (Icon.Picture.Graphic <> nil) and not Icon.Picture.Graphic.Empty then
  begin
    Icon.SetBounds(Options.Metrics.ControlSpacing, Options.Metrics.ControlSpacing, Icon.Width, Icon.Height);
    IconSpace := Icon.Width + Options.Metrics.ControlSpacing;
    MsgTopPos := Icon.Height + 5 * Options.Metrics.ControlSpacing div 2;
    Icon.Visible := True;
  end
  else
    Icon.Visible := False;
  if Length(Title.Caption) > 0 then
  begin
    SetRect(TitleRect, 0, 0, MsgRect.Right - IconSpace, 0);
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    DrawText(Canvas.Handle, PChar(Title.Caption), Length(Title.Caption),
      TitleRect, {$IFDEF COMPILER4_UP}DrawTextBiDiModeFlags{$ENDIF}(DrawTextFlags));
    Canvas.Font.Style := Options.Font.Style;
    if (TitleRect.Right + IconSpace) > MsgRect.Right then
    begin
      SetRect(MsgRect, 0, 0, TitleRect.Right + IconSpace, 0);
      DrawText(Canvas.Handle, PChar(Msg.Caption), Length(Msg.Caption), MsgRect,
        {$IFDEF COMPILER4_UP}DrawTextBiDiModeFlags{$ENDIF}(DrawTextFlags));
      if (TitleRect.Right + IconSpace) > MsgRect.Right then
        MsgRect.Right := TitleRect.Right + IconSpace
      else
        TitleRect.Right := MsgRect.Right - IconSpace;
    end
    else
      TitleRect.Right := MsgRect.Right - IconSpace;
    if Icon.Visible and (Icon.Height >= TitleRect.Bottom) then
      OffsetRect(TitleRect, Options.Metrics.ControlSpacing + IconSpace,
        Icon.Top + Icon.Height - TitleRect.Bottom)
    else
      OffsetRect(TitleRect, Options.Metrics.ControlSpacing + IconSpace, Options.Metrics.ControlSpacing);
    MsgTopPos := TitleRect.Bottom + 2 * Options.Metrics.ControlSpacing;
    Title.BoundsRect := TitleRect;
    Title.Visible := True;
  end
  else
    Title.Visible := False;
  ClientPanel.Width := MsgRect.Right + 2 * Options.Metrics.ControlSpacing;
  OffsetRect(MsgRect, Options.Metrics.ControlSpacing, MsgTopPos);
  if Length(Msg.Caption) > 0 then
  begin
    Msg.BoundsRect := MsgRect;
    Msg.Visible := True;
    Result := MsgRect.Bottom + Options.Metrics.ControlSpacing;
  end
  else
  begin
    Msg.Visible := False;
    Result := MsgRect.Top;
  end;
end;

function TAssistantBalloon.ShowMsgDlg(const AMsg: String; AType: TMsgDlgType;
  AButtons: TMsgDlgButtons; HelpCtx: LongInt; DefButton: TMsgDlgBtn): Word;
begin
  Visible := False;
  BalloonKind := bkMessage;
  BalloonShape := bsSpeakShape;
  HelpContext := HelpCtx;
  Title.Caption := MsgDlgOptions.Title;
  Msg.Caption := AMsg;
  MsgType := AType;
  MsgButtons := AButtons;
  SelectMsgIcon;
  CreateMsgButtons(DefButton);
  Rebuild(True);
  if AButtons <> [] then
    Result := ShowModal
  else
  begin
    ShowNoActivate;
    Result := mrNone;
  end;
end;

procedure TAssistantBalloon.ShowMessage(const AMsg: String; Timeout: Integer;
  Shape: TBalloonShape);
begin
  Visible := False;
  if Shape = bsSpeakShape then
    BalloonKind := bkSpeak
  else
    BalloonKind := bkThink;
  BalloonShape := Shape;
  AutoHideDelay := Timeout;
  Title.Caption := '';
  Msg.Caption := AMsg;
  Icon.Picture.Graphic := nil;
  MsgButtons := [];
  CreateMsgButtons(mbNone);
  HelpContext := 0;
  Rebuild(True);
  ShowNoActivate;
end;

procedure TAssistantBalloon.RebuildMsgDlg;
var
  B: TMsgDlgBtn;
  BtnsWidth, CheckWidth: Integer;
  TopPos, BtnLeft: Integer;
begin
  CheckBox.Visible := MsgDlgOptions.CheckBox.Visible and (BalloonKind = bkMessage);
  CheckWidth := 0;
  if CheckBox.Visible then
  begin
    CheckBox.Caption := MsgDlgOptions.CheckBox.Caption;
    CheckBox.Hint := MsgDlgOptions.CheckBox.Hint;
    CheckBox.State := MsgDlgOptions.CheckBox.State;
    CheckBox.AllowGrayed := MsgDlgOptions.CheckBox.AllowGrayed;
    CheckBox.Enabled := MsgDlgOptions.CheckBox.Enabled;
    CheckWidth := Canvas.TextWidth(MsgDlgOptions.CheckBox.Caption) + 20;
  end;
  BtnsWidth := MsgBtnCount * (MsgBtnWidth + Options.Metrics.ControlSpacing) - Options.Metrics.ControlSpacing;
  if CheckWidth > BtnsWidth then
    TopPos := RebuildIconTitleMsg(Options.Metrics.MinMsgDlgWidth, CheckWidth)
  else
    TopPos := RebuildIconTitleMsg(Options.Metrics.MinMsgDlgWidth, BtnsWidth);
  if CheckBox.Visible then
  begin
    CheckBox.SetBounds(Options.Metrics.ControlSpacing, TopPos + Options.Metrics.ControlSpacing, CheckWidth, CheckBox.Height);
    Inc(TopPos, CheckBox.Height + 2 * Options.Metrics.ControlSpacing);
  end;
  if MsgBtnCount > 0 then
  begin
    DividerBottom.SetBounds(Options.Metrics.ControlSpacing, TopPos, ClientPanel.Width - 2 * Options.Metrics.ControlSpacing, DividerBottom.Height);
    DividerBottom.Visible := True;
    Inc(TopPos, DividerBottom.Height + Options.Metrics.ControlSpacing);
    BtnLeft := (ClientPanel.Width - BtnsWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if Assigned(MsgBtn[B]) then
      begin
        MsgBtn[B].Left := BtnLeft;
        MsgBtn[B].Top := TopPos;
        Inc(BtnLeft, MsgBtnWidth + Options.Metrics.ControlSpacing);
      end;
    Inc(TopPos, BtnHeight + Options.Metrics.ControlSpacing);
  end;
  ClientPanel.Height := TopPos;
  {$IFDEF COMPILER4_UP}
  if UseRightToLeftAlignment then
    ClientPanel.FlipChildren(True);
  {$ENDIF}
end;

procedure TAssistantBalloon.SelectMsgIcon;
begin
  if MsgType <> mtCustom then
  begin
    case MsgType of
      mtWarning: Icon.Picture.Icon.Handle := LoadIcon(0, IDI_EXCLAMATION);
      mtError: Icon.Picture.Icon.Handle := LoadIcon(0, IDI_HAND);
      mtInformation: Icon.Picture.Icon.Handle := LoadIcon(0, IDI_ASTERISK);
      mtConfirmation: Icon.Picture.Icon.Handle := LoadIcon(0, IDI_QUESTION);
    end;
  end
  else
    Icon.Picture.Assign(MsgDlgOptions.CustomIcon);
end;

procedure TAssistantBalloon.CreateMsgButtons(DefButton: TMsgDlgBtn);
var
  ThisBtnWidth: Integer;
  B, DefaultButton, CancelButton: TMsgDlgBtn;
begin
  // Calculates maximum width of buttons
  MsgBtnCount := 0;
  MsgBtnWidth := Options.Metrics.MinButtonWidth;
  Canvas.Font := Options.HoverFont;
  for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    if B in MsgButtons then
    begin
      ThisBtnWidth := Canvas.TextWidth(DefMsgDlgBtns[B]) + ButtonSpace;
      if MsgBtnWidth < ThisBtnWidth then MsgBtnWidth := ThisBtnWidth;
    end;
  Canvas.Font := Options.Font;
  // Creates necessary buttons and applies balloon's options to them
  for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    if B in MsgButtons then
    begin
      Inc(MsgBtnCount);
      ThisBtnWidth := Canvas.TextWidth(DefMsgDlgBtns[B]) + ButtonSpace;
      if MsgBtnWidth < ThisBtnWidth then MsgBtnWidth := ThisBtnWidth;
    end;
  if mbOk in MsgButtons then DefaultButton := mbOk else
    if mbYes in MsgButtons then DefaultButton := mbYes else
      DefaultButton := mbRetry;
  if mbCancel in MsgButtons then CancelButton := mbCancel else
    if mbNo in MsgButtons then CancelButton := mbNo else
      CancelButton := mbOk;
  FocusedControl := nil;
  for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
    if B in MsgButtons then
    begin
      if not Assigned(MsgBtn[B]) then
      begin
        MsgBtn[B]:= TOffice97Button.Create(Self);
        MsgBtn[B].Parent := ClientPanel;
        MsgBtn[B].Tag := Ord(B);
        MsgBtn[B].WordWrap := False;
        MsgBtn[B].OnClick := MsgBtnClick;
      end;
      MsgBtn[B].Caption := DefMsgDlgBtns[B];
      MsgBtn[B].Width := MsgBtnWidth;
      MsgBtn[B].Height := BtnHeight;
      MsgBtn[B].Office2000Look := Options.Office2000Look;
      MsgBtn[B].ShowGlyph := not Options.Office2000Look;
      MsgBtn[B].Color := Options.Color;
      MsgBtn[B].Font := Options.Font;
      MsgBtn[B].HoverFont := Options.HoverFont;
      MsgBtn[B].Visible := (BalloonKind = bkMessage);
      MsgBtn[B].Cancel := (B = CancelButton);
      if MsgBtn[B].Visible and (((FocusedControl = nil) and
        (B = DefaultButton)) or (B = DefButton))
      then
        FocusedControl := MsgBtn[B];
      if B = mbHelp then
        MsgBtn[B].Enabled := (HelpContext <> 0);
    end
    else if Assigned(MsgBtn[B]) then
    begin
      MsgBtn[B].Free;
      MsgBtn[B] := nil;
    end;
end;

procedure TAssistantBalloon.MsgBtnClick(Sender: TObject);
var
  B: TMsgDlgBtn;
begin
  B := TMsgDlgBtn(TOffice97Button(Sender).Tag);
  if B <> mbHelp then
    ModalResult := MsgBtnResult[B]
  else
    Application.HelpContext(HelpContext);
end;

procedure TAssistantBalloon.CheckBoxClick(Sender: TObject);
begin
  MsgDlgOptions.InternalChange := True;
  try
    MsgDlgOptions.CheckBox.State := CheckBox.State;
  finally
    MsgDlgOptions.InternalChange := False;
  end;
end;

procedure TAssistantBalloon.ShowTipsDlg;
begin
  Visible := False;
  BalloonKind := bkTips;
  BalloonShape := bsSpeakShape;
  Icon.Picture.Assign(FTipsDlgOptions.Icon);
  CreateTipsButtons;
  Rebuild(True);
  Show;
end;

procedure TAssistantBalloon.RebuildTipsDlg;
var
  TextRect: TRect;
  B: TTipsDlgBtn;
  BtnsWidth: Integer;
  TextHeight: Integer;
  ButtonLeft, ButtonTop: integer;
begin
  CreateTipsPadStr;
  SelectTip;
  TextHeight := Canvas.TextHeight('H');
  BtnsWidth := TipsBtnCount * (MsgBtnWidth + Options.Metrics.ControlSpacing) - Options.Metrics.ControlSpacing;
  SetRect(TextRect, 0, 0, Options.Metrics.MinTipsDlgWidth - 2 * Options.Metrics.ControlSpacing, 0);
  if TextRect.Right < BtnsWidth then TextRect.Right := BtnsWidth;
  DrawText(Canvas.Handle, PChar(Msg.Caption), Length(Msg.Caption), TextRect,
    {$IFDEF COMPILER4_UP}DrawTextBiDiModeFlags{$ENDIF}(DrawTextFlags));
  if TextRect.Right < (Options.Metrics.MinTipsDlgWidth - 2 * Options.Metrics.ControlSpacing) then
    TextRect.Right := Options.Metrics.MinTipsDlgWidth - 2 * Options.Metrics.ControlSpacing;
  if TextRect.Right < BtnsWidth then TextRect.Right := BtnsWidth;
  if TextRect.Bottom < (2 * TextHeight) then Inc(TextRect.Bottom, TextHeight);
  if Icon.Height >= TextHeight then
  begin
    Icon.Top := Options.Metrics.ControlSpacing;
    OffsetRect(TextRect, Options.Metrics.ControlSpacing, Icon.Top + Icon.Height - TextHeight + 1);
  end
  else
  begin
    Icon.Top := Options.Metrics.ControlSpacing + (TextHeight - Icon.Height) div 2;
    OffsetRect(TextRect, Options.Metrics.ControlSpacing, Icon.Top - (TextHeight - Icon.Height) div 2);
  end;
  ICon.Visible := True;
  Msg.BoundsRect := TextRect;
  Msg.Visible := True;
  ButtonTop := TextRect.Bottom + Options.Metrics.ControlSpacing;
  {$IFDEF COMPILER4_UP}
  if UseRightToLeftAlignment then
  begin
    Icon.Left := TextRect.Right - Icon.Width;
    ButtonLeft := TextRect.Left;
    for B := Low(TTipsDlgBtn) to High(TTipsDlgBtn) do
      if Assigned(TipsBtn[B]) then
      begin
        TipsBtn[B].Left := ButtonLeft;
        TipsBtn[B].Top := ButtonTop;
        Inc(ButtonLeft, TipsBtnWidth + Options.Metrics.ControlSpacing);
      end;
  end
  else
  {$ENDIF}
  begin
    Icon.Left := Options.Metrics.ControlSpacing;
    ButtonLeft := TextRect.Right - TipsBtnWidth;
    for B := Low(TTipsDlgBtn) to High(TTipsDlgBtn) do
      if Assigned(TipsBtn[B]) then
      begin
        TipsBtn[B].Left := ButtonLeft;
        TipsBtn[B].Top := ButtonTop;
        Dec(ButtonLeft, TipsBtnWidth + Options.Metrics.ControlSpacing);
      end;
  end;
  ClientPanel.Width := Msg.Width + 2 * Options.Metrics.ControlSpacing;
  if TipsBtnCount = 0 then
    ClientPanel.SetBounds(ClientPanel.Left, ClientPanel.Top,
      Msg.Width + 2 * Options.Metrics.ControlSpacing, ButtonTop)
  else
    ClientPanel.SetBounds(ClientPanel.Left, ClientPanel.Top,
      Msg.Width + 2 * Options.Metrics.ControlSpacing, ButtonTop + BtnHeight + Options.Metrics.ControlSpacing);
end;

procedure TAssistantBalloon.SelectTip;
var
  B: TTipsDlgBtn;
begin
  with TipsDlgOptions do
  begin
    if (TipIndex >= 0) and (TipIndex < TipsDlgOptions.Tips.Count) then
      Msg.Caption := TipPadStr + Tips[TipIndex]
    else
      Msg.Caption := '';
    if Assigned(TipsBtn[tbNext]) then
      TipsBtn[tbNext].Enabled := TipIndex < Tips.Count-1;
    if Assigned(TipsBtn[tbBack]) then
      TipsBtn[tbBack].Enabled := TipIndex > 0;
    for B := Low(TTipsDlgBtn) to High(TTipsDlgBtn) do
      if Assigned(TipsBtn[B]) then TipsBtn[B].Invalidate;
    if Assigned(OnTipsTipChange) then
      OnTipsTipChange(Self);
  end;
end;

procedure TAssistantBalloon.CreateTipsButtons;
var
  ThisBtnWidth: Integer;
  B: TTipsDlgBtn;
begin
  // Calculates maximum width of buttons
  TipsBtnCount := 0;
  TipsBtnWidth := Options.Metrics.MinButtonWidth;
  Canvas.Font := Options.HoverFont;
  for B := Low(TTipsDlgBtn) to High(TTipsDlgBtn) do
  begin
    if B in TipsDlgOptions.VisibleButtons then
    begin
      ThisBtnWidth := Canvas.TextWidth(DefTipsDlgBtns[B]) + ButtonSpace;
      if TipsBtnWidth < ThisBtnWidth then TipsBtnWidth := ThisBtnWidth;
    end;
  end;
  Canvas.Font := Options.Font;
  for B := Low(TTipsDlgBtn) to High(TTipsDlgBtn) do
  begin
    if B in TipsDlgOptions.VisibleButtons then
    begin
      Inc(TipsBtnCount);
      ThisBtnWidth := Canvas.TextWidth(DefTipsDlgBtns[B]) + ButtonSpace;
      if TipsBtnWidth < ThisBtnWidth then TipsBtnWidth := ThisBtnWidth;
    end;
  end;
  // Creates necessary buttons and applies balloon's options to them
  for B := Low(TTipsDlgBtn) to High(TTipsDlgBtn) do
  begin
    if B in TipsDlgOptions.VisibleButtons then
    begin
      if not Assigned(TipsBtn[B]) then
      begin
        TipsBtn[B]:= TOffice97Button.Create(Self);
        TipsBtn[B].Parent := ClientPanel;
        TipsBtn[B].Tag := Ord(B);
        TipsBtn[B].WordWrap := False;
        TipsBtn[B].OnClick := TipsBtnClick;
      end;
      TipsBtn[B].Caption := DefTipsDlgBtns[B];
      TipsBtn[B].Width := TipsBtnWidth;
      TipsBtn[B].Height := BtnHeight;
      TipsBtn[B].Office2000Look := Options.Office2000Look;
      TipsBtn[B].ShowGlyph := not Options.Office2000Look;
      TipsBtn[B].Color := Options.Color;
      TipsBtn[B].Font := Options.Font;
      TipsBtn[B].HoverFont := Options.HoverFont;
      TipsBtn[B].Visible := (BalloonKind = bkTips);
    end
    else if Assigned(TipsBtn[B]) then
    begin
      TipsBtn[B].Free;
      TipsBtn[B] := nil;
    end;
  end;
end;

procedure TAssistantBalloon.CreateTipsPadStr;
var
  N: Integer;
begin
  TipPadStr := '';
  for N := 1 to (Icon.Width + Options.Metrics.ControlSpacing div 2) div Canvas.TextWidth(' ') do
    TipPadStr := TipPadStr + ' ';
end;

procedure TAssistantBalloon.TipsBtnClick(Sender: TObject);
begin
  case TTipsDlgBtn(TOffice97Button(Sender).Tag) of
    tbClose: Close;
    tbNext: TipsDlgOptions.TipIndex := TipsDlgOptions.TipIndex + 1;
    tbBack: TipsDlgOptions.TipIndex := TipsDlgOptions.TipIndex - 1;
  end;
  ClientPanel.Update;
end;

procedure TAssistantBalloon.ShowGuideDlg;
begin
  Visible := False;
  BalloonKind := bkGuide;
  BalloonShape := bsSpeakShape;
  CreateGuideButtons;
  TopGTopic := 0;
  Rebuild(True);
  if ClientPanel.Height > 2 * Options.Metrics.ControlSpacing then
    Show;
end;

// Felix Ritter
function TAssistantBalloon.ShowGuideDlgModal: Word;
begin
  Visible := False;
  BalloonKind := bkGuide;
  BalloonShape := bsSpeakShape;
  CreateGuideButtons;
  TopGTopic := 0;
  Rebuild(True);
  if ClientPanel.Height > 2 * Options.Metrics.ControlSpacing then
    Result := ShowModal
  else
    Result := mrNone;
end;

procedure TAssistantBalloon.RebuildGuideDlg;
var
  B: TGuideDlgBtn;
  OptionsBtn, SearchBtn: Boolean;
  BtnsWidth, TopPos, BtnLeft: Integer;
  MaxTopicsHeight, I: Integer;
  FontStyle: TFontStyles;
  TopicStyle: TTopicStyles;
begin
  Icon.Picture.Assign(GuideDlgOptions.Icon);
  Title.Caption := GuideDlgOptions.Title;
  Msg.Caption := GuideDlgOptions.Description;
  InputBox.OnChange := nil;
  InputBox.Text := GuideDlgOptions.Request;
  InputBox.OnChange := InputBoxChange;
  if Options.Office2000Look then
    InputBoxBorder.Pen.Color := clSilver
  else
    InputBoxBorder.Pen.Color := clBlack;
  BtnsWidth := GuideBtnCount * (GuideBtnWidth + Options.Metrics.ControlSpacing) - Options.Metrics.ControlSpacing;
  TopPos := RebuildIconTitleMsg(Options.Metrics.MinGuideDlgWidth, BtnsWidth);
  if GuideDlgOptions.Topics.Count > 0 then
  begin
    TopicsPanel.SetBounds(Options.Metrics.ControlSpacing, TopPos, ClientPanel.Width - 2 * Options.Metrics.ControlSpacing, TopicsPanel.Height);
    MaxTopicsHeight := (3 * Screen.Height div 5) - TopPos;
    if GuideDlgOptions.AcceptRequest then
    begin
      Dec(MaxTopicsHeight, InputBox.Height + 4 + 2 * Options.Metrics.ControlSpacing);
      if Assigned(GuideBtn[gbSearch]) and not FOptions.Office2000Look then
        Dec(MaxTopicsHeight, BtnHeight + 4 * Options.Metrics.ControlSpacing);
    end;
    if GuideBtnCount > 0 then
    begin
      Dec(MaxTopicsHeight, BtnHeight + 2 * Options.Metrics.ControlSpacing);
      if not FOptions.Office2000Look then
        Dec(MaxTopicsHeight, 2 * Options.Metrics.ControlSpacing);
    end;
    TopPos := 0;
    if TopGTopic > 0 then
    begin
      GuideBtn[gbBackPage].TabOrder := 0;
      GuideBtn[gbBackPage].Top := TopPos;
      GuideBtn[gbBackPage].Width := TopicsPanel.Width;
      GuideBtn[gbBackPage].Visible := True;
      Inc(TopPos, GuideBtn[gbBackPage].Height + Options.Metrics.ControlSpacing + 1);
    end
    else
      GuideBtn[gbBackPage].Visible := False;
    VisibleGTopics := 0;
    for I := TopGTopic to GuideDlgOptions.Topics.Count-1 do
    begin
      if VisibleGTopics >= GTopicBtns.Count then
      begin
        GTopicBtns.Add(TOffice97Button.Create(TopicsPanel));
        with TOffice97Button(GTopicBtns[VisibleGTopics]) do
        begin
          GuideBtn[gbBackPage].TabOrder := VisibleGTopics + 1;
          Parent := TopicsPanel;
          WordWrap := True;
          Left := 0;
        end;
      end;
      with TOffice97Button(GTopicBtns[VisibleGTopics]) do
      begin
        // Felix Ritter
        if not (tsHeader in GuideDlgOptions.Topics.Options[I].Styles) then
        begin
          OnClick := GuideBtnClick;
          Cursor := crHandPoint;
        end
        else
        begin
          OnClick := nil;
          Cursor := crDefault;
        end;
        Top := TopPos;
        Width := TopicsPanel.Width;
        Caption := GuideDlgOptions.Topics[I];
        Office2000Look := Options.Office2000Look;
        Font := Options.Font;
        HoverFont := Options.Font;
        if GuideDlgOptions.RequestResult then
          ControlType := bsRadioButton
        else
          ControlType := bsHintButton;
        TopicStyle := GuideDlgOptions.Topics.Options[I].Styles;
        FontStyle := [];
        if tsUnderline in TopicStyle then Include(FontStyle, fsUnderline);
        if tsBold in TopicStyle then Include(FontStyle, fsBold);
        if tsItalic in TopicStyle then Include(FontStyle, fsItalic);
        Font.Style := FontStyle;
        if tsHoverUnderline in TopicStyle then Include(FontStyle, fsUnderline);
        if tsHoverBold in TopicStyle then Include(FontStyle, fsBold);
        if tsHoverItalic in TopicStyle then Include(FontStyle, fsItalic);
        HoverFont.Style := FontStyle;
        if not (tsHeader in TopicStyle) then
        begin
          ShowGlyph := True;
          Enabled := True;
          TabStop := True;
          AdjustHeight;
        end
        else
        begin
          ShowGlyph := False;
          Enabled := False;
          InactiveColor := Options.Font.Color;
          TabStop := False;
          AdjustHeight;
          Height := MulDiv(Height, 120, 100);
        end;
        TabOrder := VisibleGTopics;
        Color := Options.Color;
        Tag := TopGTopic + VisibleGTopics;
        if (Top + Height < MaxTopicsHeight - BtnHeight) or (VisibleGTopics = 0) then
        begin
          Inc(TopPos, Height + Options.Metrics.ControlSpacing);
          Visible := True;
          Inc(VisibleGTopics);
        end
        else
          Break;
      end;
    end;
    if (TopGTopic + VisibleGTopics) < GuideDlgOptions.Topics.Count then
    begin
      if TopGTopic <> 0 then
      begin
        I := TopicsPanel.Height - (GuideBtn[gbNextPage].Height + Options.Metrics.ControlSpacing);
        if I > TopPos then TopPos := I;
      end;
      GuideBtn[gbNextPage].TabOrder := VisibleGTopics + 1;
      GuideBtn[gbNextPage].Top := TopPos;
      GuideBtn[gbNextPage].Width := TopicsPanel.Width;
      GuideBtn[gbNextPage].Visible := True;
      Inc(TopPos, GuideBtn[gbNextPage].Height + Options.Metrics.ControlSpacing);
    end
    else
    begin
      if (TopGTopic <> 0) and (TopicsPanel.Height > TopPos) then
        TopPos := TopicsPanel.Height;
      GuideBtn[gbNextPage].Visible := False;
    end;
    TopicsPanel.Height := TopPos;
    for I := VisibleGTopics to GTopicBtns.Count-1 do
      TOffice97Button(GTopicBtns[I]).Visible := False;
    TopicsPanel.Visible := True;
    TopPos := TopicsPanel.Top + TopicsPanel.Height;
  end
  else
    TopicsPanel.Visible := False;
  if not Options.Office2000Look and GuideDlgOptions.AcceptRequest and
    ((VisibleGTopics > 0) or Icon.Visible or Title.Visible or Msg.Visible) then
  begin
    DividerTop.SetBounds(Options.Metrics.ControlSpacing, TopPos, ClientPanel.Width - 2 * Options.Metrics.ControlSpacing, DividerTop.Height);
    DividerTop.Visible := True;
    Inc(TopPos, DividerTop.Height + Options.Metrics.ControlSpacing);
  end
  else
    DividerTop.Visible := False;
  if GuideDlgOptions.AcceptRequest then
  begin
    InputBoxBorder.SetBounds(Options.Metrics.ControlSpacing, TopPos,
      ClientPanel.Width - 2 * Options.Metrics.ControlSpacing, 2 * LineHeight + 4);
    InputBoxBorder.Visible := True;
    InputBox.SetBounds(Options.Metrics.ControlSpacing + 1, TopPos + 2, ClientPanel.Width - 2 * Options.Metrics.ControlSpacing - 2, 2 * LineHeight);
    InputBox.Visible := True;
    Inc(TopPos, InputBoxBorder.Height + Options.Metrics.ControlSpacing);
  end
  else
  begin
    InputBox.Visible := False;
    InputBoxBorder.Visible := False;
  end;
  if Options.Office2000Look then
  begin
    if Assigned(GuideBtn[gbSearch]) then
    begin
      GuideBtn[gbSearch].Top := TopPos;
      if GuideBtnCount = 2 then
        GuideBtn[gbSearch].Left := ClientPanel.Width - GuideBtn[gbSearch].Width - Options.Metrics.ControlSpacing
      else
        GuideBtn[gbSearch].Left := (ClientPanel.Width - GuideBtn[gbSearch].Width) div 2;
    end;
    if Assigned(GuideBtn[gbOptions]) then
    begin
      GuideBtn[gbOptions].Top := TopPos;
      if GuideBtnCount = 2 then
        GuideBtn[gbOptions].Left := Options.Metrics.ControlSpacing
      else
        GuideBtn[gbOptions].Left := (ClientPanel.Width - GuideBtn[gbOptions].Width) div 2;
    end;
    if GuideBtnCount > 0 then
      Inc(TopPos, BtnHeight + Options.Metrics.ControlSpacing);
    DividerBottom.Visible := False;
  end
  else // not Options.Office2000Look
  begin
    if Assigned(GuideBtn[gbSearch]) then
    begin
      GuideBtn[gbSearch].Top := TopPos;
      GuideBtn[gbSearch].Left := (ClientPanel.Width - GuideBtn[gbSearch].Width) div 2;
      Inc(TopPos, BtnHeight + Options.Metrics.ControlSpacing);
    end;
    if GuideBtnCount > 0 then
    begin
      DividerBottom.SetBounds(Options.Metrics.ControlSpacing, TopPos, ClientPanel.Width - 2 * Options.Metrics.ControlSpacing - 2, DividerBottom.Height);
      Inc(TopPos, DividerBottom.Height + Options.Metrics.ControlSpacing);
      DividerBottom.Visible := True;
      BtnLeft := (ClientPanel.Width - BtnsWidth) div 2;
      for B := Pred(High(TGuideDlgCmdBtn)) downto Low(TGuideDlgCmdBtn) do
        if Assigned(GuideBtn[B]) then
        begin
          GuideBtn[B].Left := BtnLeft;
          GuideBtn[B].Top := TopPos;
          Inc(BtnLeft, GuideBtnWidth + Options.Metrics.ControlSpacing);
        end;
      Inc(TopPos, BtnHeight + Options.Metrics.ControlSpacing);
    end
    else
      DividerBottom.Visible := False;
  end;
  ClientPanel.Height := TopPos;
  {$IFDEF COMPILER4_UP}
  if UseRightToLeftAlignment then
    ClientPanel.FlipChildren(True);
  {$ENDIF}
  OptionsBtn := Assigned(GuideDlgOptions.OnGuideOptionsClick);
  SearchBtn := Assigned(GuideDlgOptions.OnGuideSearchClick);
  if Assigned(GuideDlgOptions.OnGuideGetBtnStates) then
    GuideDlgOptions.OnGuideGetBtnStates(Self, OptionsBtn, SearchBtn);
  if Assigned(GuideBtn[gbOptions]) then
    GuideBtn[gbOptions].Enabled := OptionsBtn;
  if Assigned(GuideBtn[gbTips]) then
    GuideBtn[gbTips].Enabled := TipsDlgOptions.Tips.Count > 0;
  if Assigned(GuideBtn[gbSearch]) then
    GuideBtn[gbSearch].Enabled := SearchBtn;
  if InputBox.Visible then
  begin
    InputBox.SelectAll;
    FocusedControl := InputBox;
  end;
end;

procedure TAssistantBalloon.CreateGuideButtons;
var
  ThisBtnWidth: Integer;
  B: TGuideDlgBtn;
begin
  // Calculates maximum width of buttons
  GuideBtnCount := 0;
  GuideBtnWidth := Options.Metrics.MinButtonWidth;
  if Options.Office2000Look  then
  begin
    Canvas.Font := Options.HoverFont;
    if GuideDlgOptions.AcceptRequest and (gbSearch in GuideDlgOptions.VisibleButtons) then
    begin
      ThisBtnWidth := Canvas.TextWidth(DefGuideDlgBtns[gbSearch]) + ButtonSpace;
      if GuideBtnWidth < ThisBtnWidth then GuideBtnWidth := ThisBtnWidth;
    end;
    if gbOptions in GuideDlgOptions.VisibleButtons then
    begin
      ThisBtnWidth := Canvas.TextWidth(DefGuideDlgBtns[gbOptions]) + ButtonSpace;
      if GuideBtnWidth < ThisBtnWidth then GuideBtnWidth := ThisBtnWidth;
    end;
    Canvas.Font := Options.Font;
    if GuideDlgOptions.AcceptRequest and (gbSearch in GuideDlgOptions.VisibleButtons) then
    begin
      Inc(GuideBtnCount);
      ThisBtnWidth := Canvas.TextWidth(DefGuideDlgBtns[gbSearch]) + ButtonSpace;
      if GuideBtnWidth < ThisBtnWidth then GuideBtnWidth := ThisBtnWidth;
    end;
    if gbOptions in GuideDlgOptions.VisibleButtons then
    begin
      Inc(GuideBtnCount);
      ThisBtnWidth := Canvas.TextWidth(DefGuideDlgBtns[gbOptions]) + ButtonSpace;
      if GuideBtnWidth < ThisBtnWidth then GuideBtnWidth := ThisBtnWidth;
    end;
  end
  else
  begin
    Canvas.Font := Options.HoverFont;
    for B := Low(TGuideDlgCmdBtn) to High(TGuideDlgCmdBtn) do
    begin
      if (B in GuideDlgOptions.VisibleButtons) and (B <> gbSearch) then
      begin
        ThisBtnWidth := Canvas.TextWidth(DefGuideDlgBtns[B]) + ButtonSpace;
        if GuideBtnWidth < ThisBtnWidth then GuideBtnWidth := ThisBtnWidth;
      end;
    end;
    Canvas.Font := Options.Font;
    for B := Low(TGuideDlgCmdBtn) to High(TGuideDlgCmdBtn) do
    begin
      if (B in GuideDlgOptions.VisibleButtons) and (B <> gbSearch) then
      begin
        Inc(GuideBtnCount);
        ThisBtnWidth := Canvas.TextWidth(DefGuideDlgBtns[B]) + ButtonSpace;
        if GuideBtnWidth < ThisBtnWidth then GuideBtnWidth := ThisBtnWidth;
      end;
    end;
  end;
  // Creates necessary buttons and applies balloon's options to them
  for B := Low(TGuideDlgCmdBtn) to High(TGuideDlgCmdBtn) do
  begin
    if (B in GuideDlgOptions.VisibleButtons) and
       not (Options.Office2000Look and (B in [gbTips, gbClose])) and
       (GuideDlgOptions.AcceptRequest or (B <> gbSearch)) then
    begin
      if not Assigned(GuideBtn[B]) then
      begin
        GuideBtn[B]:= TOffice97Button.Create(Self);
        GuideBtn[B].Parent := ClientPanel;
        GuideBtn[B].Tag := Ord(B);
        GuideBtn[B].WordWrap := False;
        GuideBtn[B].OnClick := GuideBtnClick;
      end;
      GuideBtn[B].Caption := DefGuideDlgBtns[B];
      GuideBtn[B].Height := BtnHeight;
      GuideBtn[B].Font := Options.Font;
      GuideBtn[B].HoverFont := Options.HoverFont;
      if (B = gbSearch) and not Options.Office2000Look then
      begin
        GuideBtn[B].Width := Canvas.TextWidth(DefGuideDlgBtns[B]) + 2 * ButtonSpace;
        GuideBtn[B].ParentFont := True;
        GuideBtn[B].Font.Style := GuideBtn[B].Font.Style + [fsBold];
        GuideBtn[B].HoverFont.Style := GuideBtn[B].HoverFont.Style + [fsBold];
      end
      else
        GuideBtn[B].Width := GuideBtnWidth;
      GuideBtn[B].Office2000Look := Options.Office2000Look;
      GuideBtn[B].ShowGlyph := not Options.Office2000Look;
      GuideBtn[B].Color := Options.Color;
      GuideBtn[B].Visible := (BalloonKind = bkGuide);
    end
    else if Assigned(GuideBtn[B]) then
    begin
      GuideBtn[B].Free;
      GuideBtn[B] := nil;
    end;
  end;
  for B := Low(TGuideDlgNavBtn) to High(TGuideDlgNavBtn) do
  begin
    if not Assigned(GuideBtn[B]) then
    begin
      GuideBtn[B]:= TOffice97Button.Create(TopicsPanel);
      GuideBtn[B].Parent := TopicsPanel;
      GuideBtn[B].Tag := Ord(B);
      GuideBtn[B].WordWrap := False;
      GuideBtn[B].Left := 0;
      if B = gbBackPage then
        GuideBtn[B].ControlType := bsUpButton
      else
        GuideBtn[B].ControlType := bsDownButton;
      GuideBtn[B].OnClick := GuideBtnClick;
    end;
    GuideBtn[B].Caption := DefGuideDlgBtns[B];
    GuideBtn[B].Office2000Look := Options.Office2000Look;
    GuideBtn[B].ShowGlyph := True;
    GuideBtn[B].Color := Options.Color;
    GuideBtn[B].Font := Options.Font;
    GuideBtn[B].HoverFont := Options.HoverFont;
    GuideBtn[B].Visible := False;
    GuideBtn[B].AdjustHeight;
  end;
end;

procedure TAssistantBalloon.DoSearch;
begin
  if Assigned(GuideDlgOptions.OnGuideSearchClick) then
  begin
    Visible := False;
    TopGTopic := 0;
    GuideDlgOptions.InternalChange := True;
    GuideDlgOptions.Topics.BeginUpdate;
    try
      GuideDlgOptions.OnGuideSearchClick(Self);
    finally
      GuideDlgOptions.Topics.EndUpdate;
      GuideDlgOptions.InternalChange := False;
      RebuildGuideDlg;
    end;
    Visible := True;
  end;
end;

procedure TAssistantBalloon.ShowGuideNextPage;
var
  H: Integer;
begin
  if (TopGTopic + VisibleGTopics) < GuideDlgOptions.Topics.Count then
  begin
    Inc(TopGTopic, VisibleGTopics);
    H := TopicsPanel.Height;
    RebuildGuideDlg;
    if H <> TopicsPanel.Height then Reposition;
    if (TopGTopic + VisibleGTopics) = GuideDlgOptions.Topics.Count then
      ActiveControl := GuideBtn[gbBackPage];
  end;
end;

procedure TAssistantBalloon.ShowGuideBackPage;
var
  I, H, T: Integer;
  B: TOffice97Button;
begin
  if TopGTopic > 0 then
  begin
    B := TOffice97Button(GTopicBtns[VisibleGTopics-1]);
    H := TopicsPanel.Height - (GuideBtn[gbNextPage].Height + Options.Metrics.ControlSpacing);
    T := TopGTopic;
    for I := TopGTopic-1 downto 0 do
    begin
      B.Caption := GuideDlgOptions.Topics[I];
      B.AdjustHeight;
      if (T = TopGTopic) or (H >= B.Height + Options.Metrics.ControlSpacing) then
      begin
        Dec(T);
        Dec(H, B.Height + Options.Metrics.ControlSpacing);
      end
      else
        Break;
    end;
    if (T > 0) and (H < GuideBtn[gbNextPage].Height + Options.Metrics.ControlSpacing) then
      Inc(T);
    TopGTopic := T;
    H := TopicsPanel.Height;
    RebuildGuideDlg;
    if H <> TopicsPanel.Height then Reposition;
    if TopGTopic = 0 then ActiveControl := GuideBtn[gbNextPage];
  end;
end;


procedure TAssistantBalloon.GuideBtnClick(Sender: TObject);
var
  TopicIndex: Integer;
  TopicID: Integer;
begin
  if Sender is TOffice97Button then
  begin
    if TOffice97Button(Sender).ControlType in [bsHintButton, bsRadioButton] then
    begin
      TopicIndex := TOffice97Button(Sender).Tag;
      if GuideDlgOptions.Topics.Options[TopicIndex].ID >= 0 then
        TopicID := GuideDlgOptions.Topics.Options[TopicIndex].ID
      else
        TopicID := TopicIndex;
      if not FModal then
      begin
        if Assigned(GuideDlgOptions.Topics.Options[TopicIndex].OnSelect) then
          GuideDlgOptions.Topics.Options[TopicIndex].OnSelect(Self, TopicID)
        else if Assigned(GuideDlgOptions.OnGuideTopicClick) then
          GuideDlgOptions.OnGuideTopicClick(Self, TopicID);
      end
      else
        ModalResult := TopicID;
    end
    else
      case TGuideDlgBtn(TOffice97Button(Sender).Tag) of
        gbClose:
          Close;
        gbOptions:
          if Assigned(GuideDlgOptions.OnGuideOptionsClick) then
            GuideDlgOptions.OnGuideOptionsClick(Self);
        gbTips:
          if TipsDlgOptions.Tips.Count > 0 then
            ShowTipsDlg;
        gbBackPage:
          ShowGuideBackPage;
        gbNextPage:
          ShowGuideNextPage;
        gbSearch:
          DoSearch;
      end;
  end;
end;

procedure TAssistantBalloon.InputBoxChange(Sender: TObject);
begin
  GuideDlgOptions.InternalChange := True;
  try
    GuideDlgOptions.Request := InputBox.Text;
  finally
    GuideDlgOptions.InternalChange := False;
  end;
  if Assigned(GuideDlgOptions.OnGuideRequestChange) then
    GuideDlgOptions.OnGuideRequestChange(Self);
end;

procedure TAssistantBalloon.InputBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = Chr(VK_RETURN) then
    if BalloonKind = bkGuide then
      DoSearch
    else if BalloonKind = bkQuery then
      QueryBtnClick(QueryBtn[qbOK]);
end;

procedure TAssistantBalloon.ShowHintDlg;
begin
  Visible := False;
  BalloonKind := bkHint;
  BalloonShape := bsSpeakShape;
  CreateHintButtons;
  TopHTopic := 0;
  Rebuild(True);
  if ClientPanel.Height > 2 * Options.Metrics.ControlSpacing then
    Show;
end;

function TAssistantBalloon.ShowHintDlgModal: Word;
begin
  Visible := False;
  BalloonKind := bkHint;
  BalloonShape := bsSpeakShape;
  CreateHintButtons;
  TopHTopic := 0;
  Rebuild(True);
  if ClientPanel.Height > 2 * Options.Metrics.ControlSpacing then
    Result := ShowModal
  else
    Result := mrNone;
end;

procedure TAssistantBalloon.RebuildHintDlg;
var
  TopPos, MaxTopicsHeight, I: Integer;
  FontStyle: TFontStyles;
  TopicStyle: TTopicStyles;
begin
  Icon.Picture.Assign(HintDlgOptions.Icon);
  Title.Caption := HintDlgOptions.Title;
  Msg.Caption := HintDlgOptions.Description;
  TopPos := RebuildIconTitleMsg(Options.Metrics.MinHintDlgWidth, HintBtnWidth);
  if HintDlgOptions.Topics.Count > 0 then
  begin
    TopicsPanel.SetBounds(Options.Metrics.ControlSpacing, TopPos, ClientPanel.Width - 2 * Options.Metrics.ControlSpacing, TopicsPanel.Height);
    MaxTopicsHeight := (3 * Screen.Height div 5) - TopPos - BtnHeight - 4 * Options.Metrics.ControlSpacing;
    TopPos := 0;
    if TopHTopic > 0 then
    begin
      HintBtn[hbBackPage].TabOrder := 0;
      HintBtn[hbBackPage].Top := TopPos;
      HintBtn[hbBackPage].Width := TopicsPanel.Width;
      HintBtn[hbBackPage].Visible := True;
      Inc(TopPos, HintBtn[hbBackPage].Height + Options.Metrics.ControlSpacing);
    end
    else
      HintBtn[hbBackPage].Visible := False;
    VisibleHTopics := 0;
    for I := TopHTopic to HintDlgOptions.Topics.Count-1 do
    begin
      if VisibleHTopics >= HTopicBtns.Count then
      begin
        HTopicBtns.Add(TOffice97Button.Create(TopicsPanel));
        with TOffice97Button(HTopicBtns[VisibleHTopics]) do
        begin
          HintBtn[hbBackPage].TabOrder := VisibleHTopics + 1;
          Parent := TopicsPanel;
          WordWrap := True;
          Left := 0;
          OnClick := HintBtnClick;
        end;
      end;
      with TOffice97Button(HTopicBtns[VisibleHTopics]) do
      begin
        if not (tsHeader in HintDlgOptions.Topics.Options[I].Styles) then
        begin
          OnClick := HintBtnClick;
          Cursor := crHandPoint;
        end
        else
        begin
          OnClick := nil;
          Cursor := crDefault;
        end;
        Top := TopPos;
        Width := TopicsPanel.Width;
        ControlType := bsRadioButton;
        Office2000Look := Options.Office2000Look;
        Font := Options.Font;
        HoverFont := Options.Font;
        Caption := HintDlgOptions.Topics[I];
        TopicStyle := HintDlgOptions.Topics.Options[I].Styles;
        FontStyle := [];
        if tsUnderline in TopicStyle then Include(FontStyle, fsUnderline);
        if tsBold in TopicStyle then Include(FontStyle, fsBold);
        if tsItalic in TopicStyle then Include(FontStyle, fsItalic);
        Font.Style := FontStyle;
        if tsHoverUnderline in TopicStyle then Include(FontStyle, fsUnderline);
        if tsHoverBold in TopicStyle then Include(FontStyle, fsBold);
        if tsHoverItalic in TopicStyle then Include(FontStyle, fsItalic);
        HoverFont.Style := FontStyle;
        if not (tsHeader in TopicStyle) then
        begin
          ShowGlyph := True;
          Enabled := True;
          TabStop := True;
          AdjustHeight;
        end
        else
        begin
          ShowGlyph := False;
          Enabled := False;
          InactiveColor := clBlack;
          TabStop := False;
          AdjustHeight;
          Height := MulDiv(Height, 120, 100);
        end;
        Tag := TopHTopic + VisibleHTopics;
        Color := Options.Color;
        if (Top + Height < MaxTopicsHeight - BtnHeight) or (VisibleHTopics = 0) then
        begin
          Inc(TopPos, Height + Options.Metrics.ControlSpacing);
          Visible := True;
          Inc(VisibleHTopics);
        end
        else
          Break;
      end;
    end;
    if (TopHTopic + VisibleHTopics) < HintDlgOptions.Topics.Count then
    begin
      if TopHTopic <> 0 then
      begin
        I := TopicsPanel.Height - (GuideBtn[gbNextPage].Height + Options.Metrics.ControlSpacing);
        if I > TopPos then TopPos := I;
      end;
      HintBtn[hbNextPage].Visible := True;
      HintBtn[hbNextPage].TabOrder := VisibleHTopics + 1;
      HintBtn[hbNextPage].Width := TopicsPanel.Width;
      Inc(TopPos, HintBtn[hbNextPage].Height + Options.Metrics.ControlSpacing);
    end
    else
    begin
      if (TopHTopic <> 0) and (TopicsPanel.Height > TopPos) then
        TopPos := TopicsPanel.Height;
      HintBtn[hbNextPage].Visible := False;
    end;
    TopicsPanel.Height := TopPos;
    for I := VisibleHTopics to HTopicBtns.Count-1 do
      TOffice97Button(HTopicBtns[I]).Visible := False;
    TopicsPanel.Visible := True;
    TopPos := TopicsPanel.Top + TopicsPanel.Height;
  end
  else
    TopicsPanel.Visible := False;
  if Assigned(HintBtn[hbClose]) then
  begin
    DividerBottom.SetBounds(Options.Metrics.ControlSpacing, TopPos, ClientPanel.Width - 2 * Options.Metrics.ControlSpacing - 2, DividerBottom.Height);
    Inc(TopPos, DividerBottom.Height + Options.Metrics.ControlSpacing);
    DividerBottom.Visible := True;
    HintBtn[hbClose].Top := TopPos;
    HintBtn[hbClose].Left := (ClientPanel.Width - HintBtn[hbClose].Width) div 2;
    Inc(TopPos, BtnHeight + Options.Metrics.ControlSpacing);
    FocusedControl := HintBtn[hbClose];
  end;
  ClientPanel.Height := TopPos;
  {$IFDEF COMPILER4_UP}
  if UseRightToLeftAlignment then
    ClientPanel.FlipChildren(True);
  {$ENDIF}
end;

procedure TAssistantBalloon.CreateHintButtons;
var
  B: THintDlgBtn;
  ThisBtnWidth: Integer;
begin
  // Calculates maximum width of buttons
  HintBtnWidth := Options.Metrics.MinButtonWidth;
  Canvas.Font := Options.HoverFont;
  for B := Low(THintDlgCmdBtn) to High(THintDlgCmdBtn) do
  begin
    ThisBtnWidth := Canvas.TextWidth(DefHintDlgBtns[B]) + ButtonSpace;
    if HintBtnWidth < ThisBtnWidth then HintBtnWidth := ThisBtnWidth;
  end;
  Canvas.Font := Options.Font;
  for B := Low(THintDlgCmdBtn) to High(THintDlgCmdBtn) do
  begin
    ThisBtnWidth := Canvas.TextWidth(DefHintDlgBtns[B]) + ButtonSpace;
    if HintBtnWidth < ThisBtnWidth then HintBtnWidth := ThisBtnWidth;
  end;
  // Creates necessary buttons and applies balloon's options to them
  for B := Low(THintDlgCmdBtn) to High(THintDlgCmdBtn) do
  begin
    if not Assigned(HintBtn[B]) then
    begin
      HintBtn[B]:= TOffice97Button.Create(Self);
      HintBtn[B].Parent := ClientPanel;
      HintBtn[B].Tag := Ord(B);
      HintBtn[B].WordWrap := False;
      HintBtn[B].OnClick := HintBtnClick;
      HintBtn[B].Cancel := True;
    end;
    HintBtn[B].Caption := DefHintDlgBtns[B];
    HintBtn[B].Height := BtnHeight;
    HintBtn[B].Width := HintBtnWidth;
    HintBtn[B].Office2000Look := Options.Office2000Look;
    HintBtn[B].ShowGlyph := not Options.Office2000Look;
    HintBtn[B].Color := Options.Color;
    HintBtn[B].Font := Options.Font;
    HintBtn[B].HoverFont := Options.HoverFont;
    HintBtn[B].Visible := (BalloonKind = bkHint);
  end;
  HintBtnWidth := HintBtn[hbClose].Width;
  for B := Low(THintDlgNavBtn) to High(THintDlgNavBtn) do
  begin
    if not Assigned(HintBtn[B]) then
    begin
      HintBtn[B]:= TOffice97Button.Create(TopicsPanel);
      HintBtn[B].Parent := TopicsPanel;
      HintBtn[B].Tag := Ord(B);
      HintBtn[B].WordWrap := False;
      HintBtn[B].Left := 0;
      if B = hbBackPage then
        HintBtn[B].ControlType := bsUpButton
      else
        HintBtn[B].ControlType := bsDownButton;
      HintBtn[B].OnClick := HintBtnClick;
    end;
    HintBtn[B].Caption := DefHintDlgBtns[B];
    HintBtn[B].Office2000Look := Options.Office2000Look;
    HintBtn[B].ShowGlyph := True;
    HintBtn[B].Color := Options.Color;
    HintBtn[B].Font := Options.Font;
    HintBtn[B].HoverFont := Options.HoverFont;
    HintBtn[B].Visible := False;
    HintBtn[B].AdjustHeight;
  end;
end;

procedure TAssistantBalloon.ShowHintNextPage;
var
  H: Integer;
begin
  if (TopHTopic + VisibleHTopics) < HintDlgOptions.Topics.Count then
  begin
    Inc(TopHTopic, VisibleHTopics);
    H := TopicsPanel.Height;
    RebuildHintDlg;
    if H <> TopicsPanel.Height then Reposition;
    if (TopHTopic + VisibleHTopics) = HintDlgOptions.Topics.Count then
      ActiveControl := HintBtn[hbBackPage];
  end;
end;

procedure TAssistantBalloon.ShowHintBackPage;
var
  I, H, T: Integer;
  B: TOffice97Button;
begin
  if TopHTopic > 0 then
  begin
    B := TOffice97Button(HTopicBtns[VisibleHTopics-1]);
    H := TopicsPanel.Height - (HintBtn[hbNextPage].Height + Options.Metrics.ControlSpacing);
    T := TopHTopic;
    for I := TopHTopic-1 downto 0 do
    begin
      B.Caption := HintDlgOptions.Topics[I];
      B.AdjustHeight;
      if (T = TopHTopic) or (H >= B.Height + Options.Metrics.ControlSpacing) then
      begin
        Dec(T);
        Dec(H, B.Height + Options.Metrics.ControlSpacing);
      end
      else
        Break;
    end;
    if (T > 0) and (H < HintBtn[hbNextPage].Height + Options.Metrics.ControlSpacing) then
      Inc(T);
    TopHTopic := T;
    H := TopicsPanel.Height;
    RebuildHintDlg;
    if H <> TopicsPanel.Height then Reposition;
    if TopHTopic = 0 then ActiveControl := HintBtn[hbNextPage];
  end;
end;

procedure TAssistantBalloon.HintBtnClick(Sender: TObject);
var
  TopicIndex: Integer;
  TopicID: Integer;
begin
  if Sender is TOffice97Button then
  begin
    if TOffice97Button(Sender).ControlType in [bsHintButton, bsRadioButton] then
    begin
      TopicIndex := TOffice97Button(Sender).Tag;
      if HintDlgOptions.Topics.Options[TopicIndex].ID >= 0 then
        TopicID := HintDlgOptions.Topics.Options[TopicIndex].ID
      else
        TopicID := TopicIndex;
      if not FModal then
      begin
        if Assigned(HintDlgOptions.Topics.Options[TopicIndex].OnSelect) then
          HintDlgOptions.Topics.Options[TopicIndex].OnSelect(Self, TopicID)
        else if Assigned(HintDlgOptions.OnHintTopicClick) then
          HintDlgOptions.OnHintTopicClick(Self, TopicID);
      end
      else
        ModalResult :=  TopicID;
    end
    else
      case THintDlgBtn(TOffice97Button(Sender).Tag) of
        hbClose:
          Close;
        hbBackPage:
          ShowHintBackPage;
        hbNextPage:
          ShowHintNextPage;
      end;
  end;
end;

function TAssistantBalloon.InputQuery(const ACaption, APrompt: String;
  var Value: String): Boolean;
begin
  Visible := False;
  Icon.Picture.Graphic := nil;
  BalloonKind := bkQuery;
  BalloonShape := bsSpeakShape;
  Title.Caption := ACaption;
  Msg.Caption := APrompt;
  InputBox.OnChange := nil;
  InputBox.Text := Value;
  CreateQueryButtons;
  Rebuild(True);
  if ShowModal = mrOK then
  begin
    Value := InputBox.Text;
    Result := True;
  end
  else
    Result := False;
  InputBox.OnChange := InputBoxChange;
end;

procedure TAssistantBalloon.RebuildQueryDlg;
var
  BtnsWidth, TopPos: Integer;
begin
  if Options.Office2000Look then
    InputBoxBorder.Pen.Color := clSilver
  else
    InputBoxBorder.Pen.Color := clBlack;
  BtnsWidth := 2 * QueryBtnWidth + Options.Metrics.ControlSpacing;
  TopPos := RebuildIconTitleMsg(Options.Metrics.MinQueryDlgWidth, BtnsWidth);
  InputBoxBorder.SetBounds(Options.Metrics.ControlSpacing, TopPos,
    ClientPanel.Width - 2 * Options.Metrics.ControlSpacing, LineHeight + 4);
  InputBoxBorder.Visible := True;
  InputBox.SetBounds(Options.Metrics.ControlSpacing + 1, TopPos + 2, ClientPanel.Width - 2 * Options.Metrics.ControlSpacing - 2, LineHeight);
  InputBox.Visible := True;
  Inc(TopPos, InputBoxBorder.Height + Options.Metrics.ControlSpacing);
  QueryBtn[qbOK].Top := TopPos;
  QueryBtn[qbOK].Left := (ClientPanel.Width - ButtonSpace) div 2 - QueryBtnWidth;
  QueryBtn[qbCancel].Top := TopPos;
  QueryBtn[qbCancel].Left := (ClientPanel.Width + ButtonSpace) div 2;
  Inc(TopPos, BtnHeight + Options.Metrics.ControlSpacing);
  ClientPanel.Height := TopPos;
  InputBox.SelectAll;
  FocusedControl := InputBox;
  {$IFDEF COMPILER4_UP}
  if UseRightToLeftAlignment then
    ClientPanel.FlipChildren(True);
  {$ENDIF}
end;

procedure TAssistantBalloon.CreateQueryButtons;
var
  B: TQueryDlgBtn;
  ThisBtnWidth: Integer;
begin
  // Calculates maximum width of buttons
  QueryBtnWidth := Options.Metrics.MinButtonWidth;
  Canvas.Font := Options.HoverFont;
  for B := Low(TQueryDlgBtn) to High(TQueryDlgBtn) do
  begin
    ThisBtnWidth := Canvas.TextWidth(DefQueryDlgBtns[B]) + ButtonSpace;
    if QueryBtnWidth < ThisBtnWidth then QueryBtnWidth := ThisBtnWidth;
  end;
  Canvas.Font := Options.Font;
  for B := Low(TQueryDlgBtn) to High(TQueryDlgBtn) do
  begin
    ThisBtnWidth := Canvas.TextWidth(DefQueryDlgBtns[B]) + ButtonSpace;
    if QueryBtnWidth < ThisBtnWidth then QueryBtnWidth := ThisBtnWidth;
  end;
  // Creates necessary buttons and applies balloon's options to them
  for B := Low(TQueryDlgBtn) to High(TQueryDlgBtn) do
  begin
    if not Assigned(QueryBtn[B]) then
    begin
      QueryBtn[B]:= TOffice97Button.Create(Self);
      QueryBtn[B].Parent := ClientPanel;
      QueryBtn[B].Tag := Ord(B);
      QueryBtn[B].WordWrap := False;
      QueryBtn[B].OnClick := QueryBtnClick;
      QueryBtn[B].Cancel := (B = qbCancel);
    end;
    QueryBtn[B].Caption := DefQueryDlgBtns[B];
    QueryBtn[B].Height := BtnHeight;
    QueryBtn[B].Width := QueryBtnWidth;
    QueryBtn[B].Office2000Look := Options.Office2000Look;
    QueryBtn[B].ShowGlyph := not Options.Office2000Look;
    QueryBtn[B].Color := Options.Color;
    QueryBtn[B].Font := Options.Font;
    QueryBtn[B].HoverFont := Options.HoverFont;
    QueryBtn[B].Visible := (BalloonKind = bkQuery);
  end;
end;

procedure TAssistantBalloon.QueryBtnClick(Sender: TObject);
var
  B: TQueryDlgBtn;
begin
  B := TQueryDlgBtn(TOffice97Button(Sender).Tag);
  if B = qbOK then
    ModalResult := mrOK
  else
    ModalResult := mrCancel;
end;

// Felix Ritter
procedure TAssistantBalloon.ShowCustomDlg;
begin
  Visible := False;
  BalloonKind := bkCustom;
  BalloonShape := bsSpeakShape;
  Rebuild(True);
  if ClientPanel.Height > 2 * Options.Metrics.ControlSpacing then
    Show;
end;

// Felix Ritter
function TAssistantBalloon.ShowCustomDlgModal: Word;
begin
  Visible := False;
  BalloonKind := bkCustom;
  BalloonShape := bsSpeakShape;
  Rebuild(True);
  if ClientPanel.Height > 2 * Options.Metrics.ControlSpacing then
    Result := ShowModal
  else
    Result := mrNone;
end;

end.

