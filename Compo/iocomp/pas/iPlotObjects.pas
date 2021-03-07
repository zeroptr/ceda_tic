{*******************************************************}
{                                                       }
{       iPlotObjects                                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotObjects;{$endif}
{$ifdef iCLX}unit QiPlotObjects;{$endif}

interface                                                       

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}  Menus,  iTypes;{$ENDIF}
  {$IFDEF iCLX} QMenus, QiTypes;{$ENDIF}

type
  TiPlotMouseData = record
    X              : Integer;
    Y              : Integer;
    ScreenX        : Integer;
    ScreenY        : Integer;
    XAxisPixels    : Integer;
    YAxisPixels    : Integer;
    Shift          : TShiftState;
    Button         : TMouseButton;
    DblClickActive : Boolean;
  end;

  TiMenuItem = class(TMenuItem)
  public
    AString : String;
  end;

  TiHintData = record
    Text    : String;
    Top     : Integer;
    Left    : Integer;
    Visible : Boolean;
  end;

  TiPlotRectObject = class(TObject)
  public
    ARect : TRect;
  end;

  TPlotMousePointerEvent = procedure(ACursor : TCursor) of object;

  TiPlotTranslationObject = class(TPersistent)
  private
    FOriginalString    : String;
    FReplacementString : String;
  public
    property OriginalString    : String read FOriginalString    write FOriginalString;
    property ReplacementString : String read FReplacementString write FReplacementString;
  end;

  TiPlotObject = class(TPersistent)
  private
    FName            : String;
    FNameOld         : String;

    FOwner           : TObject;
    FShiftState      : TShiftState;

    FOnChange        : TNotifyEvent;
    FOnLayoutChange  : TNotifyEvent;
    FOnRemove        : TNotifyEvent;
    FOnInsert        : TNotifyEvent;
    FOnRename        : TNotifyEvent;
    FOnSetFocus      : TNotifyEvent;

    FOnEdit          : TNotifyEvent;
    FOnInvalidateNow : TNotifyEvent;

    FVisible         : Boolean;
    FEnabled         : Boolean;
    FLayer           : Integer;
    FPopupEnabled    : Boolean;
    FCanFocus        : Boolean;
    FUserSelected    : Boolean;
    FUserCanEdit     : Boolean;
    FXYAxesReversed  : Boolean;
    FCanDraw         : Boolean;

    FMouseOverObject : TiPlotObject;
    FMouseDown       : Boolean;
    FMouseDownPopup  : Boolean;
  protected
    function GetLayerString: String;

    procedure SetVisible       (const Value: Boolean); virtual;
    procedure SetLayer         (const Value: Integer);
    procedure SetEnabled       (const Value: Boolean); virtual;
    procedure SetXYAxesReversed(const Value: Boolean); virtual;
    procedure SetUserSelected  (const Value: Boolean);
    procedure SetName          (const Value: String);
    procedure SetUserCanEdit   (const Value: Boolean);
    procedure SetShiftState    (const Value: TShiftState);
    procedure SetPopupEnabled  (const Value: Boolean);
    procedure SetCanFocus      (const Value: Boolean);

    procedure TriggerChange       (Sender : TObject); virtual;
    procedure TriggerRename       (Sender : TObject);
    procedure TriggerLayoutChange (Sender : TObject); virtual;
    procedure TriggerInvalidateNow(Sender : TObject);
    procedure TriggerSetFocus     (Sender : TObject);

    procedure SetBooleanProperty(Value : Boolean; var FVariable : Boolean; EventHandler : TNotifyEvent);
    procedure SetIntegerProperty(Value : Integer; var FVariable : Integer; EventHandler : TNotifyEvent);
    procedure SetDoubleProperty (Value : Double;  var FVariable : Double;  EventHandler : TNotifyEvent);
    procedure SetStringProperty (Value : String;  var FVariable : String;  EventHandler : TNotifyEvent);
    procedure SetColorProperty  (Value : TColor;  var FVariable : TColor;  EventHandler : TNotifyEvent);

    procedure NotificationRemove  (Sender : TObject); virtual;
    procedure NotificationRename  (Sender : TObject); virtual;
    procedure NotificationSetFocus(Sender : TObject); virtual;

    procedure DrawSetup(const Canvas: TCanvas);                                                                                                             virtual;
    procedure Draw(const Canvas: TCanvas; const BackGroundColor: TColor);                                                                                   virtual;

    procedure iMouseDown   (Button: TMouseButton;     Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer;                          PopupMenu: TPopupMenu); virtual;
    procedure iMouseMove   (var HintData: TiHintData; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean);                        virtual;
    procedure iMouseUp     (Button: TMouseButton;     Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean; PopupMenu: TPopupMenu); virtual;
    function  iMouseHitTest(MouseData: TiPlotMouseData): Boolean;                                                                                           virtual;
    function  iMouseWheel  (WheelDelta: Integer;      Shift: TShiftState; const MousePos: TPoint): Boolean;                                                 virtual;

    procedure CalcAxisPixels(X, Y: Integer; var XAxisPixels, YAxisPixels: Integer);

    procedure DoMouseHint       (MouseData: TiPlotMouseData; var HintData: TiHintData);                                                                     virtual;
    procedure DoMouseLeft       (MouseData: TiPlotMouseData);                                                                                               virtual;
    procedure DoMouseRight      (MouseData: TiPlotMouseData);                                                                                               virtual;
    procedure DoMouseMove       (MouseData: TiPlotMouseData);                                                                                               virtual;
    procedure DoMouseUp         (MouseData: TiPlotMouseData);                                                                                               virtual;
    procedure DoMouseDoubleClick(MouseData: TiPlotMouseData);                                                                                               virtual;
    function  DoMouseWheel      (WheelDelta: Integer; Shift: TShiftState; AX, AY: Integer): Boolean;                                                        virtual;
    procedure DoSetFocus;                                                                                                                                   virtual;
    procedure DoLostFocus;                                                                                                                                  virtual;
    procedure DoMouseNotOver;                                                                                                                               virtual;

    procedure CancelPopup;

    function  GetMouseObject(X, Y: Integer): TiPlotObject;                                                                                                  virtual;
    function  GetMousePointer(APoint: TPoint): TCursor;                                                                                                     virtual;

    function  GetTranslation(Value: String): String;

    procedure iKeyDown  (var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);                                                                   virtual;

    procedure Loaded;                                                                                                                                       virtual;
    procedure EditMenuItemClick(Sender : TObject);

    procedure AddMenuItems    (PopupMenu: TPopUpMenu);                                                                                                      virtual;
    procedure AddEditMenuItems(PopupMenu: TPopUpMenu);

    property Owner           : TObject      read FOwner;
    property MouseOverObject : TiPlotObject read FMouseOverObject write FMouseOverObject;

    property NameOld         : String       read FNameOld;

    property OnEdit          : TNotifyEvent read FOnEdit           write FOnEdit;
    property OnLayoutChange  : TNotifyEvent read FOnLayoutChange   write FOnLayoutChange;
    property OnInvalidateNow : TNotifyEvent read FOnInvalidateNow  write FOnInvalidateNow;
    property OnSetFocus      : TNotifyEvent read FOnSetFocus       write FOnSetFocus;
    property OnRemove        : TNotifyEvent read FOnRemove         write FOnRemove;
    property OnChange        : TNotifyEvent read FOnChange         write FOnChange;

    property XYAxesReversed  : Boolean      read FXYAxesReversed   write SetXYAxesReversed;

    property MouseDown       : Boolean      read FMouseDown;
    property Shift           : TShiftState  read FShiftState;

    property CanDraw         : Boolean      read FCanDraw          write FCanDraw;

    property LayerString     : String       read GetLayerString;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);          virtual;
    destructor  Destroy; override;

    procedure DoEditMenuItemClick;

    function HitTest(X, Y: Integer): Boolean;

    property UserSelected    : Boolean      read FUserSelected      write SetUserSelected;
    property UserCanEdit     : Boolean      read FUserCanEdit       write SetUserCanEdit;
  published
    property Name            : String       read FName              write SetName;
    property Visible         : Boolean      read FVisible           write SetVisible       default True;
    property Enabled         : Boolean      read FEnabled           write SetEnabled       default True;
    property Layer           : Integer      read FLayer             write SetLayer         default 100;
    property PopupEnabled    : Boolean      read FPopupEnabled      write SetPopupEnabled  default True;
    property CanFocus        : Boolean      read FCanFocus          write SetCanFocus      default True;
  end;


  TiPlotManagerObject = class(TiPlotObject)
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);           override;
  end;

  TiPlotLayoutObject = class(TiPlotManagerObject)
  private
    FStopPercent       : Double;
    FStartPercent      : Double;
    FZOrder            : Integer;
    FHorizontal        : Boolean;
    FReverseSide       : Boolean;
    FBottom            : Integer;
    FLeft              : Integer;
    FTop               : Integer;
    FRight             : Integer;
    FStartStacked      : Boolean;
    FStopStacked       : Boolean;
    FLayoutBottom      : Integer;
    FLayoutLeft        : Integer;
    FLayoutTop         : Integer;
    FLayoutRight       : Integer;
    FForceStacking     : Boolean;
  protected
    procedure SetHorizontal   (const Value: Boolean);
    procedure SetReverseSide  (const Value: Boolean);
    procedure SetStartPercent (const Value: Double);
    procedure SetStopPercent  (const Value: Double);
    procedure SetZOrder       (const Value: Integer);
    procedure SetBottom       (const Value: Integer);
    procedure SetLeft         (const Value: Integer);
    procedure SetRight        (const Value: Integer);
    procedure SetTop          (const Value: Integer);
    procedure SetDrawRect     (const Value: TRect);
    procedure SetLayoutRect   (const Value: TRect);
    procedure SetStartStacked (const Value: Boolean);
    procedure SetStopStacked  (const Value: Boolean);
    procedure SetForceStacking(const Value: Boolean);

    function  GetDrawRect           : TRect;
    function  GetLayoutRect         : TRect;
    function  GetIsHorz             : Boolean; virtual;
    function  GetIsVert             : Boolean; virtual;
    function  GetHeight             : Integer;
    function  GetWidth              : Integer;
    function  GetLayoutHeight       : Integer;
    function  GetLayoutWidth        : Integer;
    function  GetZOrderString       : String;
    function  GetStartPercentString : String;

    function  GetRequiredWidth      (const Canvas : TCanvas): Integer; virtual;
    function  GetRequiredLengthGaurd(const Canvas : TCanvas): Integer; virtual;

    function  iMouseHitTest(MouseData: TiPlotMouseData): Boolean;                              override;

    procedure Loaded;                                                                          override;

    procedure SetStartStopPercent(const Start : Double; const Stop : Double);

    property Left               : Integer read FLeft           write SetLeft;
    property Top                : Integer read FTop            write SetTop;
    property Right              : Integer read FRight          write SetRight;
    property Bottom             : Integer read FBottom         write SetBottom;

    property LayoutLeft         : Integer read FLayoutLeft     write FLayoutLeft;
    property LayoutTop          : Integer read FLayoutTop      write FLayoutTop;
    property LayoutRight        : Integer read FLayoutRight    write FLayoutRight;
    property LayoutBottom       : Integer read FLayoutBottom   write FLayoutBottom;

    property StartStacked       : Boolean read FStartStacked   write SetStartStacked;
    property StopStacked        : Boolean read FStopStacked    write SetStopStacked;
    property ReverseSide        : Boolean read FReverseSide    write SetReverseSide;

    property ForceStacking      : Boolean read FForceStacking write SetForceStacking;

    property ZOrderString       : String  read GetZOrderString;
    property StartPercentString : String  read GetStartPercentString;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                           override;

    property DrawRect           : TRect   read GetDrawRect;
    property LayoutRect         : TRect   read GetLayoutRect;

    property IsHorz             : Boolean read GetIsHorz;
    property IsVert             : Boolean read GetIsVert;
    property LayoutWidth        : Integer read GetLayoutWidth;
    property LayoutHeight       : Integer read GetLayoutHeight;
    property Width              : Integer read GetWidth;
    property Height             : Integer read GetHeight;
  published
    property Horizontal         : Boolean read FHorizontal     write SetHorizontal;
    property ZOrder             : Integer read FZOrder         write SetZOrder;

    property StartPercent       : Double  read FStartPercent   write SetStartPercent;
    property StopPercent        : Double  read FStopPercent    write SetStopPercent;

  end;

  TiPlotButton = class(TiPlotObject)
  private
    FTop               : Integer;
    FBottom            : Integer;
    FRight             : Integer;
    FLeft              : Integer;
    FDown              : Boolean;
    FOnClick           : TNotifyEvent;
    FOnGroupClick      : TNotifyEvent;
    FOnInvalidate      : TNotifyEvent;
    FOnDownChange      : TNotifyEvent;
    FTimer             : TTimer;
    FFirstTimerMessage : Boolean;
    FTimerEnabled      : Boolean;
    FGroupIndex        : Integer;
    procedure SetDown     (const Value: Boolean);
  protected
    procedure SetEnabled(const Value: Boolean); override;

    procedure SetDrawRect(const Value: TRect);
    function  GetDrawRect: TRect;
    function  GetHeight  : Integer;
    function  GetWidth   : Integer;
    procedure Invalidate;
    procedure TimerEvent(Sender: TObject);
    procedure DestroyTimer;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                           override;

    procedure DoMouseLeft(MouseData: TiPlotMouseData); override;
    procedure DoMouseMove(MouseData: TiPlotMouseData); override;
    procedure DoMouseUp  (MouseData: TiPlotMouseData); override;

    property DrawRect     : TRect        read GetDrawRect   write SetDrawRect;
    property Left         : Integer      read FLeft         write FLeft;
    property Top          : Integer      read FTop          write FTop;
    property Right        : Integer      read FRight        write FRight;
    property Bottom       : Integer      read FBottom       write FBottom;
    property Down         : Boolean      read FDown         write SetDown;
    property Width        : Integer      read GetWidth;
    property Height       : Integer      read GetHeight;
    property TimerEnabled : Boolean      read FTimerEnabled write FTimerEnabled;
    property GroupIndex   : Integer      read FGroupIndex   write FGroupIndex;

    property OnInvalidate : TNotifyEvent read FOnInvalidate write FOnInvalidate;
    property OnClick      : TNotifyEvent read FOnClick      write FOnClick;
    property OnGroupClick : TNotifyEvent read FOnGroupClick write FOnGroupClick;
    property OnDownChange : TNotifyEvent read FOnDownChange write FOnDownChange;
  end;

implementation

uses
{$ifdef iVCL} iPlotChannelCustom,  iPlotComponent;{$endif}
{$ifdef iCLX}QiPlotChannelCustom, QiPlotComponent;{$endif}


type
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom)end;
  TiPlotComponentAccess     = class(TiPlotComponent    )end;
//****************************************************************************************************************************************************
{TiPlotObject}
//****************************************************************************************************************************************************
constructor TiPlotObject.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  FOwner     := AOwner;
  FOnChange  := AOnChange;
  FOnInsert  := AOnInsert;
  FOnRemove  := AOnRemove;
  FOnRename  := AOnRename;

  FVisible      := True;
  FEnabled      := True;
  FLayer        := 100;
  FPopupEnabled := True;
  FUserCanEdit  := True;
  FCanFocus     := True;
end;
//****************************************************************************************************************************************************
constructor TiPlotManagerObject.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  if not Assigned(AOwner)     then raise Exception.Create('Owner must be assigned');
  if not Assigned(AOnChange)  then raise Exception.Create('OnChange event handler can not be null');
  if not Assigned(AOnInsert)  then raise Exception.Create('OnInsert event handler can not be null');
  if not Assigned(AOnRemove)  then raise Exception.Create('OnRemove event handler can not be null');
  if not Assigned(AOnRename)  then raise Exception.Create('AOnRename event handler can not be null');

  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.Loaded;
begin
  if Assigned(FOnInsert) then FOnInsert(Self);
end;
//****************************************************************************************************************************************************
destructor TiPlotObject.Destroy;
begin
  if Assigned(FOnRemove) then FOnRemove(Self);
  TriggerLayoutChange(Self);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.NotificationRemove  (Sender: TObject);begin end;
procedure TiPlotObject.NotificationRename  (Sender: TObject);begin end;
procedure TiPlotObject.NotificationSetFocus(Sender: TObject);begin end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetVisible     (const Value:Boolean);begin SetBooleanProperty(Value,FVisible,      TriggerChange);end;
procedure TiPlotObject.SetPopupEnabled(const Value:Boolean);begin SetBooleanProperty(Value,FPopupEnabled, TriggerChange);end;
procedure TiPlotObject.SetCanFocus    (const Value:Boolean);begin SetBooleanProperty(Value,FCanFocus,     TriggerChange);end;
procedure TiPlotObject.SetLayer       (const Value:Integer);begin SetIntegerProperty(Value,FLayer,        TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetEnabled(const Value:Boolean);
begin
  if FEnabled <> Value then
    begin
      FEnabled := Value;
      if not FEnabled then
        begin
          FMouseDown   := False;
          UserSelected := False;
        end;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetXYAxesReversed(const Value: Boolean);
begin
  FXYAxesReversed := Value;
end;
//****************************************************************************************************************************************************
function TiPlotObject.GetLayerString: String;
begin
  Result := IntToStr(FLayer);
  while Length(Result) < 6 do
    Result := '0' + Result;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetUserSelected(const Value:Boolean);
begin
  if FUserSelected <> Value then
    begin
      FUserSelected := Value;
      TriggerInvalidateNow(Self);
      if FUserSelected then
        begin
          TriggerSetFocus(Self);
          DoSetFocus; //Must be after TriggerSetFocus
        end
      else
        begin
          DoLostFocus;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetName(const Value:String);
begin
  if FName <> Value then
    begin
      FNameOld := FName;
      FName    := Value;
      TriggerRename(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetUserCanEdit(const Value: Boolean);
begin
  FUserCanEdit := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetShiftState(const Value: TShiftState);
begin
  FShiftState := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.TriggerChange(Sender: TObject);
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.TriggerRename(Sender: TObject);
begin
  if Assigned(FOnRename) then FOnRename(Self);
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.TriggerLayoutChange(Sender: TObject);
begin
  if Assigned(FOnLayoutChange) then FOnLayoutChange(Self);
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.TriggerInvalidateNow(Sender: TObject);
begin
  if Assigned(FOnInvalidateNow) then FOnInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.TriggerSetFocus(Sender: TObject);
begin
  if Assigned(FOnSetFocus) then FOnSetFocus(Self);
end;
//****************************************************************************************************************************************************
function TiPlotObject.HitTest(X, Y: Integer): Boolean;
var
  MouseData: TiPlotMouseData;
begin
  MouseData.X              := X;
  MouseData.Y              := Y;
  MouseData.ScreenX        := 0;
  MouseData.ScreenY        := 0;
  MouseData.XAxisPixels    := 0;
  MouseData.YAxisPixels    := 0;
  MouseData.Shift          := [];
  MouseData.Button         := mbLeft;
  MouseData.DblClickActive := False;

  Result := iMouseHitTest(MouseData);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetBooleanProperty(Value: Boolean; var FVariable: Boolean; EventHandler : TNotifyEvent);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      if Assigned(EventHandler) then EventHandler(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetColorProperty(Value: TColor; var FVariable: TColor; EventHandler : TNotifyEvent);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      if Assigned(EventHandler) then EventHandler(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetDoubleProperty(Value: Double; var FVariable: Double; EventHandler : TNotifyEvent);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      if Assigned(EventHandler) then EventHandler(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetIntegerProperty(Value: Integer; var FVariable: Integer; EventHandler : TNotifyEvent);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      if Assigned(EventHandler) then EventHandler(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.SetStringProperty(Value: String; var FVariable: String; EventHandler : TNotifyEvent);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      if Assigned(EventHandler) then EventHandler(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DrawSetup(const Canvas: TCanvas);
begin
  FCanDraw := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
begin
end;
//****************************************************************************************************************************************************
function TiPlotObject.GetMouseObject(X, Y: Integer): TiPlotObject;
begin
  Result := Self;
  FMouseOverObject := Result;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.CalcAxisPixels(X, Y: Integer; var XAxisPixels, YAxisPixels: Integer);
begin
  if XYAxesReversed then
    begin
      XAxisPixels := Y;
      YAxisPixels := X;
    end
  else
    begin
      XAxisPixels := X;
      YAxisPixels := Y;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; PopupMenu : TPopupMenu);
var
  XAxisPixels : Integer;
  YAxisPixels : Integer;
  MouseData   : TiPlotMouseData;
begin
  if not Enabled then Exit;
  CalcAxisPixels(X, Y, XAxisPixels, YAxisPixels);

  MouseData.X := X;
  MouseData.Y := Y;
  MouseData.XAxisPixels := XAxisPixels;
  MouseData.YAxisPixels := YAxisPixels;

  FMouseDownPopup := False;

  if Button = mbRight then
    begin
      if PopupEnabled then
        begin
          FMouseDownPopup := True;
        end;
      FMouseDown := True;
      DoMouseRight(MouseData);
    end
  else if Button = mbLeft then
    begin
      FMouseDown := True;
      DoMouseLeft(MouseData);
    end;

  if iMouseHitTest(MouseData) then TiPlotComponentAccess(Owner).DoObjectMouseDown(Self, Button, Shift, X, Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.iMouseMove(var HintData: TiHintData; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean);
var
  XAxisPixels : Integer;
  YAxisPixels : Integer;
  MouseData   : TiPlotMouseData;
begin
  CalcAxisPixels(X, Y, XAxisPixels, YAxisPixels);

  MouseData.X              := X;
  MouseData.Y              := Y;
  MouseData.XAxisPixels    := XAxisPixels;
  MouseData.YAxisPixels    := YAxisPixels;
  MouseData.DblClickActive := DblClickActive;

  if not FMouseDown then
       DoMouseHint(MouseData, HintData)
  else DoMouseMove(MouseData);

  if iMouseHitTest(MouseData) then TiPlotComponentAccess(Owner).DoObjectMouseMove(Self, Shift, X, Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer; DblClickActive: Boolean; PopupMenu: TPopupMenu);
var
  XAxisPixels : Integer;
  YAxisPixels : Integer;
  MouseData   : TiPlotMouseData;
  Cancel      : Boolean;
begin
  CalcAxisPixels(X, Y, XAxisPixels, YAxisPixels);

  MouseData.X              := X;
  MouseData.Y              := Y;
  MouseData.XAxisPixels    := XAxisPixels;
  MouseData.YAxisPixels    := YAxisPixels;
  MouseData.DblClickActive := DblClickActive;

  if FMouseDownPopup and iMouseHitTest(MouseData) then
    begin
      Cancel := False;
      TiPlotComponentAccess(Owner).DoPopUpMenuEvent(Self, Cancel, ScreenX, ScreenY);
      if not Cancel then
        begin
          AddMenuItems(PopupMenu);
          PopupMenu.Popup(ScreenX, ScreenY);
        end;
    end;

  FMouseDownPopup := False;


  DoMouseUp(MouseData);
  if FMouseDown then
    begin
      FMouseDown := False;
      TiPlotComponentAccess(Owner).DoObjectMouseUp(Self, Button, Shift, X, Y);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.CancelPopup;
begin
  FMouseDownPopup := False;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoMouseNotOver;
begin

end;
//****************************************************************************************************************************************************
function TiPlotObject.iMouseWheel(WheelDelta: Integer; Shift: TShiftState; const MousePos: TPoint): Boolean;
begin
  Result := DoMouseWheel(WheelDelta, Shift, MousePos.X, MousePos.Y);

  TiPlotComponentAccess(Owner).DoObjectMouseWheel(Self, WheelDelta, Shift, MousePos.X, MousePos.Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoMouseMove(MouseData: TiPlotMouseData);
begin

end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoMouseUp(MouseData: TiPlotMouseData);
begin

end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoMouseLeft(MouseData: TiPlotMouseData);
begin
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoMouseRight(MouseData: TiPlotMouseData);
begin
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoMouseHint(MouseData: TiPlotMouseData; var HintData: TiHintData);
begin

end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoMouseDoubleClick(MouseData: TiPlotMouseData);
begin

end;
//****************************************************************************************************************************************************
function TiPlotObject.DoMouseWheel(WheelDelta: Integer; Shift: TShiftState; AX, AY: Integer): Boolean;
begin
  Result := False;
end;
//****************************************************************************************************************************************************
function TiPlotObject.GetMousePointer(APoint: TPoint): TCursor;
begin
  Result := crDefault;
  if Assigned(FMouseOverObject) then
    begin
      if FMouseOverObject <> Self then Result := FMouseOverObject.GetMousePointer(APoint);
    end
  else FMouseOverObject := Self;
end;
//****************************************************************************************************************************************************
function TiPlotObject.GetTranslation(Value: String): String;
begin
  Result := TiPlotComponentAccess(Owner).Master.TranslationManager.FindReplacement(Value);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.iKeyDown(var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);
var
  Cancel       : Boolean;
  LayOutObject : TiPlotLayoutObject;
  CenterX      : Integer;
  CenterY      : Integer;
  ScreenPoint  : TPoint;
begin
  if ((CharCode = 121) and (ssShift in Shift)) or (CharCode = 93) then
    begin
      if PopupEnabled then
        begin
          Cancel := False;
          TiPlotComponentAccess(Owner).DoPopUpMenuEvent(Self, Cancel, 0, 0);
          if not Cancel then
            begin
              AddMenuItems(PopupMenu);
              if (Self is TiPlotLayoutObject) then
                begin
                  LayOutObject := Self as TiPlotLayoutObject;
                  CenterX      := (LayOutObject.DrawRect.Left + LayOutObject.DrawRect.Right ) div 2;
                  CenterY      := (LayOutObject.DrawRect.Top  + LayOutObject.DrawRect.Bottom) div 2;
                  ScreenPoint  := TiPlotComponentAccess(Owner).ClientToScreen(Point(CenterX, CenterY));
                  PopupMenu.Popup(ScreenPoint.X, ScreenPoint.Y);
                end
              else if (Self is TiPlotChannelCustom) then
                begin
                  CenterX      := (TiPlotChannelCustomAccess(Self).LegendRect.Left + TiPlotChannelCustomAccess(Self).LegendRect.Right ) div 2;
                  CenterY      := (TiPlotChannelCustomAccess(Self).LegendRect.Top  + TiPlotChannelCustomAccess(Self).LegendRect.Bottom) div 2;
                  ScreenPoint  := TiPlotComponentAccess(Owner).ClientToScreen(Point(CenterX, CenterY));
                  PopupMenu.Popup(ScreenPoint.X, ScreenPoint.Y);
                end;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.AddMenuItems(PopupMenu: TPopUpMenu);
var
  x : Integer;
begin
  for x := PopupMenu.Items.Count - 1 downto 0 do
    PopupMenu.Items[x].Free;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.AddEditMenuItems(PopupMenu: TPopUpMenu);
var
  MenuItem : TMenuItem;
begin
  if FUserCanEdit then
    begin
      MenuItem := TMenuItem.Create(PopupMenu);
      MenuItem.Caption := GetTranslation('Edit...');
      MenuItem.OnClick := EditMenuItemClick;
      MenuItem.Visible := True;

      PopupMenu.Items.Add(MenuItem);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.EditMenuItemClick(Sender: TObject);
begin
  if Assigned(FOnEdit) then FOnEdit(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoEditMenuItemClick;
begin
  EditMenuItemClick(Self);
end;
//****************************************************************************************************************************************************
function TiPlotObject.iMouseHitTest(MouseData: TiPlotMouseData): Boolean;
begin
  Result := False;
end;                                         
//****************************************************************************************************************************************************
{ TiPlotLayoutObject }
//****************************************************************************************************************************************************
constructor TiPlotLayoutObject.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);
  FStopPercent := 100;
end;
//****************************************************************************************************************************************************
destructor TiPlotLayoutObject.Destroy;
begin
  inherited;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetZOrderString: String;
begin
  Result := IntToStr(ZOrder);
  while Length(Result) < 3 do Result := '0' + Result;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetStartPercentString: String;
begin
  Result := IntToStr(Round(StartPercent));
  while Length(Result) < 3 do Result := '0' + Result;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutObject.SetReverseSide  (const Value:Boolean);begin SetBooleanProperty(Value,FReverseSide,  TriggerChange      );end;
procedure TiPlotLayoutObject.SetLeft         (const Value:Integer);begin SetIntegerProperty(Value,FLeft,         nil                );end;
procedure TiPlotLayoutObject.SetTop          (const Value:Integer);begin SetIntegerProperty(Value,FTop,          nil                );end;
procedure TiPlotLayoutObject.SetRight        (const Value:Integer);begin SetIntegerProperty(Value,FRight,        nil                );end;
procedure TiPlotLayoutObject.SetBottom       (const Value:Integer);begin SetIntegerProperty(Value,FBottom,       nil                );end;
procedure TiPlotLayoutObject.SetHorizontal   (const Value:Boolean);begin SetBooleanProperty(Value,FHorizontal,   TriggerLayoutChange);end;
procedure TiPlotLayoutObject.SetZOrder       (const Value:Integer);begin SetIntegerProperty(Value,FZOrder,       TriggerLayoutChange);end;
procedure TiPlotLayoutObject.SetStartStacked (const Value:Boolean);begin SetBooleanProperty(Value,FStartStacked, nil                );end;
procedure TiPlotLayoutObject.SetStopStacked  (const Value:Boolean);begin SetBooleanProperty(Value,FStopStacked,  nil                );end;
procedure TiPlotLayoutObject.SetForceStacking(const Value:Boolean);begin SetBooleanProperty(Value,FForceStacking,TriggerLayoutChange);end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutObject.SetStartPercent(const Value : Double);
var
  TempValue : Double;
begin
  TempValue := Value;
  if TempValue <   0 then TempValue :=   0;
  if TempValue > 100 then TempValue := 100;

  if (FStopPercent - TempValue) < 1 then
    begin
      FStopPercent :=  TempValue + 1;
      if FStopPercent > 100 then
        begin
          TempValue     := 99;
          FStopPercent  := 100;
        end;
    end;

  SetDoubleProperty(TempValue,FStartPercent,TriggerChange)
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutObject.SetStopPercent(const Value : Double);
var
  TempValue : Double;
begin
  TempValue := Value;
  if TempValue <   0 then TempValue :=   0;
  if TempValue > 100 then TempValue := 100;

  if (TempValue - FStartPercent) < 1 then
    begin
      FStartPercent :=  TempValue - 1;
      if FStartPercent < 0 then
        begin
          FStartPercent := 0;
          TempValue     := 1;
        end;
    end;

  SetDoubleProperty(TempValue,FStopPercent,TriggerChange)
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutObject.SetStartStopPercent(const Start : Double; const Stop : Double);
begin
  FStartPercent := Start;
  FStopPercent  := Stop;
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetDrawRect: TRect;
begin
  Result := Rect(FLeft, FTop, FRight, FBottom);
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutObject.SetDrawRect(const Value: TRect);
begin
  Left   := Value.Left;
  Top    := Value.Top;
  Right  := Value.Right;
  Bottom := Value.Bottom;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetIsHorz: Boolean;
begin
  Result := FHorizontal;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetIsVert: Boolean;
begin
  Result := not FHorizontal;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutObject.Loaded;
begin
  inherited Loaded;
  if Assigned(FOnLayoutChange) then FOnLayoutChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetRequiredWidth(const Canvas : TCanvas): Integer;
begin
  Result := 0;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetRequiredLengthGaurd(const Canvas : TCanvas): Integer;
begin
  Result := 0;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetHeight: Integer;
begin
  Result := Bottom - Top;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetWidth: Integer;
begin
  Result := Right - Left;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetLayoutRect: TRect;
begin
  Result := Rect(FLayoutLeft, FLayoutTop, FLayoutRight, FLayoutBottom);
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutObject.SetLayoutRect(const Value: TRect);
begin
  FLayoutLeft   := Value.Left;
  FLayoutTop    := Value.Top;
  FLayoutRight  := Value.Right;
  FLayoutBottom := Value.Bottom;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetLayoutHeight: Integer;
begin
  Result := FLayoutBottom - FLayoutTop;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.GetLayoutWidth: Integer;
begin
  Result := FLayoutRight - FLayoutLeft;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutObject.iMouseHitTest(MouseData: TiPlotMouseData): Boolean;
begin
  Result := PtInRect(DrawRect, Point(MouseData.X, MouseData.Y));
end;
//****************************************************************************************************************************************************
{TiPlotButton}
//****************************************************************************************************************************************************
constructor TiPlotButton.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);
  FEnabled := True;
end;
//****************************************************************************************************************************************************
destructor TiPlotButton.Destroy;
begin
  DestroyTimer;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.SetDrawRect(const Value: TRect);
begin
  Left   := Value.Left;
  Top    := Value.Top;
  Right  := Value.Right;
  Bottom := Value.Bottom;
end;
//****************************************************************************************************************************************************
function TiPlotButton.GetDrawRect: TRect;
begin
  Result := Rect(Left, Top, Right, Bottom)
end;
//****************************************************************************************************************************************************
function TiPlotButton.GetHeight: Integer;
begin
  Result := FBottom - FTop;
end;
//****************************************************************************************************************************************************
function TiPlotButton.GetWidth: Integer;
begin
  Result := FRight - FLeft;
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.DoMouseLeft(MouseData: TiPlotMouseData);
begin
  if FTimerEnabled then
    begin
      if not Assigned(FTimer) then FTimer := TTimer.Create(nil);
      FTimer.Interval    := 500;
      FTimer.Enabled     := True;
      FTimer.OnTimer     := TimerEvent;
      FFirstTimerMessage := True;
    end;
  Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.DoMouseMove(MouseData: TiPlotMouseData);
begin
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.DoMouseUp(MouseData: TiPlotMouseData);
begin
  if MouseDown then
    begin
      FMouseDown := False;
      DestroyTimer;
      Invalidate;

      if PtInRect(DrawRect, Point(MouseData.X, MouseData.Y)) then
        begin
          if FGroupIndex > 0 then
            begin
              if Assigned(FOnGroupClick) then FOnGroupClick(Self);
            end
          else if FGroupIndex < 0 then
            begin
              if Assigned(FOnGroupClick) then FOnGroupClick(Self);
            end;
          if Assigned(FOnClick) then FOnClick(Self);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoSetFocus;
begin
  TiPlotComponentAccess(Owner).DoObjectGotFocus(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotObject.DoLostFocus;
begin
  TiPlotComponentAccess(Owner).DoObjectLostFocus(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.Invalidate;
begin
  if Assigned(FOnInvalidate) then FOnInvalidate(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.TimerEvent(Sender : TObject);
begin
  if FFirstTimerMessage then
    begin
      FTimer.Interval := 50;
      FFirstTimerMessage := False;
    end;
  if Assigned(FOnClick) then FOnClick(Self);
  Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.SetDown(const Value: Boolean);
begin
  if FDown <> Value then
    begin
      FDown := Value;
      Invalidate;
      if Assigned(FOnDownChange) then FOnDownChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.DestroyTimer;
begin
  if Assigned(FTimer) then
    begin
      FTimer.Free;
      FTimer := nil;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotButton.SetEnabled(const Value: Boolean);
begin
  inherited SetEnabled(Value);
  if not Enabled then DestroyTimer;
end;
//****************************************************************************************************************************************************
end.
