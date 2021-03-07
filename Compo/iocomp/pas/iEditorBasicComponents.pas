{*******************************************************}
{                                                       }
{       Iocomp Editor Basic Components                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iEditorBasicComponents;{$endif}
{$ifdef iCLX}unit QiEditorBasicComponents;{$endif}

interface

uses
  {$I iIncludeUses.inc}

  {$IFDEF iVCL}  iTypes,  iCheckBox,  iRadioGroup,  iGPFunctions,  iColorDialog,  iFontDialog,  iOpenDialog,  iSaveDialog;{$ENDIF}
  {$IFDEF iCLX} QiTypes, QiCheckBox, QiRadioGroup, QiGPFunctions;                                                         {$ENDIF}

type
  TiValueConverterPageType = (ivcptInterval, ivcptDateTime, ivcptPrice32nd);

  TFormTranslationMethod = procedure (AForm: TCustomForm) of object;

  TiListBoxGetDataEvent  = procedure(const Index: Integer; var DrawColorBox : Boolean; var AColor : TColor; var AText : String) of object;
  //****************************************************************************
  TiCustomEditorForm = class(TCustomForm)
  public
    procedure UserChange; virtual;
    property  FormStyle;
  published
    property Caption;
    property ClientHeight;
    property ClientWidth;
    property PixelsPerInch;
    property OnCreate;
    property OnDestroy;
    property OnClose;
    property AutoScroll;
  end;
  //****************************************************************************
  TiComponentEditorEdit = class(TCustomEdit)
  private
    FBlockingEvents : Boolean;
    FOriginalText   : String;
    FOnUpdate       : TNotifyEvent;

    function  GetAsInteger  : Integer;
    function  GetAsString   : String;
    function  GetAsFloat    : Double;
    function  GetAsDateTime : Double;

    procedure SetAsInteger (const Value: Integer);
    procedure SetAsString  (const Value: String);
    procedure SetAsFloat   (const Value: Double);
    procedure SetAsDateTime(const Value: Double);
  protected
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure DoUpdate;
    procedure DoExit;  override;
    {$ifdef iVCL}procedure SetEnabled(      Value: Boolean); override;{$endif}
    {$ifdef iCLX}procedure SetEnabled(const Value: Boolean); override;{$endif}
    {$ifdef iVCL}procedure WMKillFocus     (var Message: TMessage         );message WM_KILLFOCUS;     {$endif}
    {$ifdef iVCL}procedure WMGetDLGCode    (var Message: TMessage         );message WM_GETDLGCODE;    {$endif}
    {$ifdef iVCL}procedure CMWantSpecialKey(var Message: TCMWantSpecialKey);message CM_WANTSPECIALKEY;{$endif}
    {$ifdef iVCL}procedure CreateParams(var Params: TCreateParams); override;{$endif}
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Disable;
    procedure   DisableNoClear;
    procedure   Enable;

    procedure   SetStringWithEvent (Value : String);
    procedure   SetIntegerWithEvent(Value : Integer);
    procedure   SetDoubleWithEvent (Value : Double );

    property AsInteger  : Integer     read GetAsInteger  write SetAsInteger;
    property AsString   : String      read GetAsString   write SetAsString;
    property AsFloat    : Double      read GetAsFloat    write SetAsFloat;
    property AsDateTime : Double      read GetAsDateTime write SetAsDateTime;

    property Color;
  published
    property OnUpdate : TNotifyEvent read FOnUpdate    write FOnUpdate;

    property TabOrder;
    property ReadOnly;
    property Height default 21;
    property Visible;
  end;
  //****************************************************************************
  TiUpDown = class(TGraphicControl)
  private
    FTimer              : TTimer;
    FFirstTimerMessage  : Boolean;

    FAssociate          : TiComponentEditorEdit;
    FMin                : SmallInt;
    FMax                : SmallInt;
    FIncrement          : Integer;

    FMouseDown          : Boolean;
    FMouseDownX         : Integer;
    FMouseDownY         : Integer;

    FUpButtonPressed    : Boolean;
    FDownButtonPressed  : Boolean;
    FUpButtonRect       : TRect;
    FDownButtonRect     : TRect;
    FUserGenerated      : Boolean;

    function GetPosition: Integer;
    procedure SetPosition (const Value: Integer);
    procedure SetAssociate(const Value: TiComponentEditorEdit);
    procedure SetMax      (const Value: SmallInt);
    procedure SetMin      (const Value: SmallInt);
    procedure SetIncrement(const Value: Integer);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const Value: Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);        override;
    procedure DrawButton(DrawRect : TRect; ShowDown : Boolean);
    procedure CalcButtons;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y : Integer);                      override;
    procedure MouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure TimerEvent(Sender: TObject);
  public
    constructor Create(AOwner: TComponent);                                       override;
    destructor  Destroy;                                                          override;
    procedure   Paint;                                                            override;

    procedure   Disable;
    procedure   Enable;

    property    AsInteger : Integer read GetAsInteger write SetAsInteger;
  published
    property Associate : TiComponentEditorEdit  read FAssociate  write SetAssociate;
    property Min       : SmallInt               read FMin        write SetMin        default 0;
    property Max       : SmallInt               read FMax        write SetMax        default 100;
    property Increment : Integer                read FIncrement  write SetIncrement  default 1;
    property Width  default 15;
    property Height default 21;
  end;
  //****************************************************************************
  TiComponentEditorPageControl = class(TPageControl)
  private
    FTabIndex : Integer;
  protected
    {$IFDEF iVCL}procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;{$endif}
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;{$endif}
    procedure KeyPress(var Key: Char); override;
  published
    property TabIndex : Integer read FTabIndex write FTabIndex;
  end;
  //****************************************************************************
  TiComponentEditorButton = class(TButton)
  protected
    procedure KeyPress(var Key: Char); override;
    {$ifdef iVCL} procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE; {$endif}
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;{$endif}
  end;
  //****************************************************************************
  TiComponentEditorCheckBox = class(TiCheckBox)
  private
    FBlockingEvents : Boolean;
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(const Value: Boolean);
  protected
    procedure KeyPress(var Key: Char); override;
    {$IFDEF iVCL}procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;{$endif}
    procedure DoEnter; override;
    procedure DoChange; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Disable;
    procedure   Enable;

    property    AsBoolean : Boolean read GetAsBoolean  write SetAsBoolean;
  end;
  //****************************************************************************
  TiComponentEditorRadioGroup = class(TiRadioGroup)
  private
    FBlockingEvents : Boolean;
  protected
    function GetAsInteger: Integer;
    procedure SetAsInteger(const Value: Integer);
    procedure KeyPress(var Key: Char); override;
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;{$endif}
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Click;                      override;
    procedure   Disable;
    procedure   Enable;
    property    AsInteger : Integer read GetAsInteger write SetAsInteger;
  end;
  //****************************************************************************
  TiComponentEditorMemo = class(TMemo)
  private
    FOriginalText   : String;
    FBlockingEvents : Boolean;
    FOnUpdate       : TNotifyEvent;
  protected
    function GetAsString: String;
    procedure SetAsString(const Value: String);
    procedure KeyPress(var Key: Char); override;
    procedure DoUpdate;

    {$ifdef iVCL}procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;{$endif}
    {$ifdef iVCL}procedure WMKillFocus (var Message: TMessage); message WM_KILLFOCUS; {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Disable;
    procedure   Enable;

    property AsString : String       read GetAsString  write SetAsString;
  published
    property OnUpdate : TNotifyEvent read FOnUpdate    write FOnUpdate;
  end;
  //****************************************************************************
  TiComponentEditorComboBox = class(TComboBox)
  private
    FBlockingEvents : Boolean;
  protected
    function GetAsInteger: Integer;
    function GetAsString : String;

    procedure SetAsInteger(const Value: Integer);
    procedure SetAsString (const Value: String);

    procedure KeyPress(var Key: Char); override;
    {$IFDEF iVCL}procedure WMGetDLGCode    (var Message: TMessage);         message WM_GETDLGCODE;   {$endif}
    {$ifdef iVCL}procedure CMWantSpecialKey(var Message: TCMWantSpecialKey);message CM_WANTSPECIALKEY;{$endif}
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;           {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Click;                      override;
    procedure   Disable;
    procedure   Enable;
    property    AsInteger : Integer read GetAsInteger write SetAsInteger;
    property    AsString  : String  read GetAsString  write SetAsString;
  published
    property Visible;
  end;
  //****************************************************************************
  TiComponentEditorListBox = class(TCustomListBox)
  private
    FOnGetData  : TiListBoxGetDataEvent;
    FOnItemMove : TNotifyEvent;
  protected
    {$ifdef iVCL}procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);          override;{$endif}
    {$ifdef iCLX}function  DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState): Boolean; override;{$endif}

    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;

    {$ifdef iVCL}procedure CNCommand   (var Message: TWMCommand); message CN_COMMAND;   {$endif}
    {$ifdef iVCL}procedure WMGetDLGCode(var Message: TMessage  ); message WM_GETDLGCODE;{$endif}
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;           {$endif}

    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;

    procedure SelectLast;
    procedure DeleteSelectedObject;
    procedure DeleteObjectIndex(AObject: TObject);

    property Items;
  published
    property Enabled;
    property Font;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property Style    default lbOwnerDrawFixed;
    property Sorted   default False;
    property OnGetData  : TiListBoxGetDataEvent read FOnGetData  write FOnGetData;
    property OnItemMove : TNotifyEvent          read FOnItemMove write FOnItemMove;
    property OnDrawItem;

    property DragMode default dmAutomatic;
  end;
  //****************************************************************************
  TiComponentEditorColorPicker = class(TCustomControl)
  private
    FButton      : TButton;
    FColor       : TColor;
    FOnChange    : TNotifyEvent;
    procedure SetColor(const Value: TColor);
  protected
    {$IFDEF iVCL}procedure OpenVCL;{$endif}
    {$IFDEF iCLX}procedure OpenCLX;{$endif}

    procedure ButtonClick(Sender: TObject);
    procedure Paint;    override;
    procedure DblClick; override;
    procedure KeyPress(var Key: Char); override;
    {$IFDEF iVCL}procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;{$endif}
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;         {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure   Disable;
    procedure   Enable;

    property Color    : TColor       read FColor    write SetColor;
  published
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    property TabOrder;
  end;
  //****************************************************************************
  TiComponentEditorComputerPicker = class(TiComponentEditorButton)
  private
    FComputerName : String;
    FOnChange     : TNotifyEvent;
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Click;                      override;
  published
    property OnChange     : TNotifyEvent read FOnChange     write FOnChange;
    property ComputerName : String       read FComputerName write FComputerName;
  end;
  //****************************************************************************
  TiComponentEditorFontPicker = class(TiComponentEditorButton)
  private
    FFont     : TFont;
    FOnChange : TNotifyEvent;
  protected
    {$IFDEF iVCL}procedure OpenVCL;{$endif}
    {$IFDEF iCLX}procedure OpenCLX;{$endif}

    procedure SetFont(const Value: TFont);
    procedure KeyPress(var Key: Char); override;
    {$IFDEF iVCL}procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;{$endif}
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;
    procedure   Click;                      override;
    procedure   Disable;
    procedure   Enable;

    property Font     : TFont        read FFont     write SetFont;
  published
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
  end;
  //****************************************************************************
  TiComponentEditorOpenPicker = class(TiComponentEditorButton)
  private
    FFileName         : String;
    FFilter           : String;
    FDefaultExt       : String;
    FFileMustExist    : Boolean;
    FAllowMultiSelect : Boolean;
    FOnChange         : TNotifyEvent;
    FFiles: TStrings;
  protected
    {$IFDEF iVCL}procedure OpenVCL;{$endif}
    {$IFDEF iCLX}procedure OpenCLX;{$endif}

    procedure KeyPress(var Key: Char); override;
    {$IFDEF iVCL}procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;{$endif}
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;         {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;       override;
    procedure   Click;                      override;
    procedure   Disable;
    procedure   Enable;

    property Files            : TStrings     read FFiles;
  published
    property FileName         : String       read FFileName         write FFileName;
    property Filter           : String       read FFilter           write FFilter;
    property DefaultExt       : String       read FDefaultExt       write FDefaultExt;
    property FileMustExist    : Boolean      read FFileMustExist    write FFileMustExist;
    property AllowMultiSelect : Boolean      read FAllowMultiSelect write FAllowMultiSelect;
    property OnChange         : TNotifyEvent read FOnChange         write FOnChange;
    property Caption;
    property Font;
    property TabOrder;
    property TabStop default True;
  end;
  //****************************************************************************
  TiComponentEditorSavePicker = class(TiComponentEditorButton)
  private
    FFileName   : String;
    FFilter     : String;
    FDefaultExt : String;
    FOnChange   : TNotifyEvent;
  protected
    {$IFDEF iVCL}function OpenVCL: Boolean;{$endif}
    {$IFDEF iCLX}function OpenCLX: Boolean;{$endif}

    procedure KeyPress(var Key: Char); override;
    {$IFDEF iVCL}procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;{$endif}
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;         {$endif}
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Click;                      override;
    procedure   Disable;
    procedure   Enable;

    function Execute: Boolean;
  published
    property FileName      : String       read FFileName      write FFileName;
    property Filter        : String       read FFilter        write FFilter;
    property DefaultExt    : String       read FDefaultExt    write FDefaultExt;
    property OnChange      : TNotifyEvent read FOnChange      write FOnChange;
    property Caption;
    property Font;
    property TabOrder;
    property TabStop default True;
  end;
  //****************************************************************************
  TiComponentEditorValueConverterPicker = class(TiComponentEditorButton)
  private
    FDateTime          : Double;
    FOnChange          : TNotifyEvent;
    FAssociate         : TiComponentEditorEdit;
    FDefaultPage       : TiValueConverterPageType;
    FTranslationMethod : TFormTranslationMethod;
  protected
    procedure KeyPress(var Key: Char); override;
    {$IFDEF iVCL}procedure WMGetDLGCode(var Message: TMessage); message WM_GETDLGCODE;{$endif}
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;         {$endif}
    procedure Notification(AComponent: TComponent; Operation: TOperation);        override;
    procedure SetAssociate(const Value: TiComponentEditorEdit);
  public
    constructor Create(AOwner: TComponent); override;
    procedure   Click;                      override;
    procedure   Disable;
    procedure   Enable;
  published
    property Associate : TiComponentEditorEdit  read FAssociate  write SetAssociate;
    property DateTime  : Double                 read FDateTime   write FDateTime;
    property OnChange  : TNotifyEvent           read FOnChange   write FOnChange;
    property Caption;
    property Font;
    property TabOrder;
    property TabStop default True;
    property DefaultPage       : TiValueConverterPageType read FDefaultPage       write FDefaultPage;
    property TranslationMethod : TFormTranslationMethod   read FTranslationMethod write FTranslationMethod;
  end;
  //****************************************************************************
  TiComponentEditorPanel = class(TPanel)
  protected
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;{$endif}
  end;
  //****************************************************************************
  TiComponentEditorGroupBox = class(TGroupBox)
  protected
    {$IFDEF iVCL}procedure CreateParams(var Params: TCreateParams); override;{$endif}
  end;
  //****************************************************************************
  TiPaintBox = class(TCustomControl)
  private
    FOnPaint : TNotifyEvent;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property Canvas;
    property Align;
  end;
  //****************************************************************************
implementation

{$IFDEF iVCL} uses  iValueConverterEdit,  iOPCComputerSelector;{$ENDIF}
{$IFDEF iCLX} uses QiValueConverterEdit, QiOPCComputerSelector;{$ENDIF}

type
  TWinControlAccess = class(TWinControl)end;
//****************************************************************************************************************************************************
procedure TiCustomEditorForm.UserChange;
begin

end;
//***********************************************************************************************************************************
constructor TiComponentEditorEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF iVCL}
  Ctl3D   := True;
  {$ENDIF}

  Height := 21;

  FOriginalText := '';
end;
//***********************************************************************************************************************************
procedure TiComponentEditorEdit.Disable;
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange      := OnChange;
  OnChange          := nil;
  FBlockingEvents   := True;
  try
    Enabled         := False;
    Text            := '';
    FOriginalText   := '';
    Color           := clBtnFace;
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorEdit.DisableNoClear;
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange      := OnChange;
  OnChange          := nil;
  FBlockingEvents   := True;
  try
    Enabled         := False;
    Color           := clBtnFace;
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorEdit.Enable;
begin
  Enabled := True;
  Color := clWindow;
end;
//***********************************************************************************************************************************
function TiComponentEditorEdit.GetAsInteger: Integer;
begin
  try
    if Trim(Text) = '' then Result := 0 else Result := StrToInt(Trim(Text));
  except
    on Exception do Result := 0;
  end;
end;
//***********************************************************************************************************************************
function TiComponentEditorEdit.GetAsString: String;
begin
  Result := Text;
end;
//***********************************************************************************************************************************
function TiComponentEditorEdit.GetAsFloat: Double;
begin
  try
    if Trim(Text) = '' then Result := 0 else Result := StrToFloat(Trim(Text));
  except
    on Exception do Result := 0;
  end;
end;
//***********************************************************************************************************************************
function TiComponentEditorEdit.GetAsDateTime: Double;
begin
  Result := StrToDateTime(Trim(Text));
end;
//***********************************************************************************************************************************
procedure TiComponentEditorEdit.SetAsFloat(const Value: Double);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange      := OnChange;
  OnChange          := nil;
  FBlockingEvents   := True;
  try
    Text            := FloatToStr(Value);
    FOriginalText   := FloatToStr(Value);
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorEdit.SetAsInteger(const Value: Integer);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange      := OnChange;
  OnChange          := nil;
  FBlockingEvents   := True;
  try
    Text            := IntToStr(Value);
    FOriginalText   := IntToStr(Value);
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorEdit.SetAsString(const Value: String);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange      := OnChange;
  OnChange          := nil;
  FBlockingEvents   := True;
  try
    Text            := Value;
    FOriginalText   := Value;
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorEdit.SetAsDateTime(const Value: Double);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange      := OnChange;
  OnChange          := nil;
  FBlockingEvents   := True;
  try
    Text            := DateTimeToStr(Value);
    FOriginalText   := DateTimeToStr(Value);
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorEdit.SetStringWithEvent(Value: String);
begin
  Text := Value;
  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
  DoUpdate;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorEdit.SetIntegerWithEvent(Value: Integer);
begin
  Text := IntToStr(Value);
  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
  DoUpdate;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorEdit.SetDoubleWithEvent(Value: Double);
begin
  Text := FloatToStr(Value);
  if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
  DoUpdate;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorEdit.WMKillFocus(var Message: TMessage);
begin
  inherited;
  DoUpdate;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiComponentEditorEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    begin
      DoUpdate;
      Key   := 0;
      SelectAll;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorEdit.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #10 then Key := #0;

  if Key = #13 then
    begin
      DoUpdate;
      Key   := #0;
      SelectAll;
    end;

  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  if Key = #27 then
    begin
      Key  := #0;
      Text := FOriginalText;
      SelectAll;
    end;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorEdit.DoUpdate;
begin
  if FOriginalText <> Text then
    begin
      FOriginalText := Text;
      if Assigned(FOnUpdate) then FOnUpdate(Self);
      if not FBlockingEvents then if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
    end;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorEdit.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result + DLGC_WANTTAB + DLGC_WANTARROWS;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorEdit.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  if Message.CharCode in [VK_LEFT, VK_RIGHT] then Message.Result := 1 else Message.Result := 0;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiComponentEditorEdit.DoExit;
begin
  inherited;
  DoUpdate;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}procedure TiComponentEditorEdit.SetEnabled(      Value: Boolean);{$endif}
{$ifdef iCLX}procedure TiComponentEditorEdit.SetEnabled(const Value: Boolean);{$endif}
begin
  inherited;
  if Enabled then Color := clWindow else Color := clBtnFace;
end;
//****************************************************************************************************************************************************
constructor TiUpDown.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  Width   := 15;
  Height  := 21;

  FMax       := 100;
  FIncrement := 1;

  FTimer         := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.OnTimer := TimerEvent;
end;
//****************************************************************************************************************************************************
destructor TiUpDown.Destroy;
begin
  FTimer.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.SetPosition(const Value: Integer);
var
  TempPosition : Integer;
begin
  if not Assigned(FAssociate) then exit;
  TempPosition := Value;

  if (FMax <> 0) or (FMin <> 0) then
    begin
      if TempPosition > FMax then TempPosition := FMax;
      if TempPosition < FMin then TempPosition := FMin;
    end;

  if FUserGenerated then FAssociate.SetIntegerWithEvent(TempPosition)
    else                 FAssociate.AsInteger := TempPosition;
end;
//****************************************************************************************************************************************************
function TiUpDown.GetPosition: Integer;
begin
  if Assigned(FAssociate) then Result := FAssociate.AsInteger else Result := 0;
end;
//****************************************************************************************************************************************************
function TiUpDown.GetAsInteger: Integer;
begin
  Result := GetPosition;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.SetAsInteger(const Value: Integer);
begin
  SetPosition(Value);
end;
//****************************************************************************************************************************************************
procedure TiUpDown.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FAssociate) then FAssociate := nil;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.SetAssociate(const Value: TiComponentEditorEdit);
begin
  FAssociate := Value;
  if Assigned(FAssociate) then
    begin
      Left   := FAssociate.Left + FAssociate.Width;
      Top    := FAssociate.Top;
      Height := FAssociate.Height;
    end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.SetIncrement(const Value: Integer);
begin
  if FIncrement <> Value then
    begin
      FIncrement := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.SetMax(const Value: SmallInt);
begin
  if FMax <> Value then
    begin
      FMax := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.SetMin(const Value: SmallInt);
begin
  if FMin <> Value then
    begin
      FMin := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.DrawButton(DrawRect: TRect; ShowDown: Boolean);
begin
  with Canvas, DrawRect do
    begin
      if ShowDown then
        begin
          iDrawEdge(Canvas, DrawRect, idesSunken);
        end
      else
        begin
          iDrawEdge(Canvas, DrawRect, idesRaised);
       end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.Paint;
var
  MaxSize     : Integer;
  Length      : Integer;
  CenterPoint : TPoint;
begin
  CalcButtons;
  DrawButton(FUpButtonRect, FUpButtonPressed);
  DrawButton(FDownButtonRect, FDownButtonPressed);

  if Width > (Height div 2) then MaxSize := (Height div 2) else MaxSize := Width;
  Length := MaxSize div 7;

  if Enabled then
    begin
      Canvas.Brush.Color := clBlack;
      Canvas.Pen.Color   := clBlack;
    end
  else
    begin
      Canvas.Brush.Color := clGray;
      Canvas.Pen.Color   := clGray;
    end;

  CenterPoint := Point((FUpButtonRect.Right + FUpButtonRect.Left) div 2, (FUpButtonRect.Bottom + FUpButtonRect.Top) div 2);

  Canvas.Polygon([Point(CenterPoint.X - 2*Length, CenterPoint.Y + Length),
                  Point(CenterPoint.X           , CenterPoint.Y - Length),
                  Point(CenterPoint.X + 2*Length, CenterPoint.Y + Length)]);

  CenterPoint := Point((FDownButtonRect.Right + FDownButtonRect.Left) div 2, (FDownButtonRect.Bottom + FDownButtonRect.Top) div 2);

  Canvas.Polygon([Point(CenterPoint.X - 2*Length, CenterPoint.Y - Length),
                  Point(CenterPoint.X + 2*Length, CenterPoint.Y - Length),
                  Point(CenterPoint.X           , CenterPoint.Y + Length)]);


end;
//****************************************************************************************************************************************************
procedure TiUpDown.CalcButtons;
var
  DrawRect     : TRect;
  ButtonHeight : Integer;
begin
  with DrawRect do
    begin
      DrawRect := GetClientRect;

      ButtonHeight := (DrawRect.Bottom - 1) div 2;

      FUpButtonRect   := Rect(0, 0, Right, ButtonHeight);
      FDownButtonRect := Rect(0, Bottom - ButtonHeight, Right, Bottom);

      if FMouseDown then
        begin
          if PtInRect(FUpButtonRect,   Point(FMouseDownX,FMouseDownY)) then FUpButtonPressed   := True else FUpButtonPressed   := False;
          if PtInRect(FDownButtonRect, Point(FMouseDownX,FMouseDownY)) then FDownButtonPressed := True else FDownButtonPressed := False;
        end
      else
        begin
          FUpButtonPressed   := False;
          FDownButtonPressed := False;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
    begin
      FMouseDown  := True;
      FMouseDownX := X;
      FMouseDownY := Y;

      CalcButtons;

      FTimer.Interval := 500;
      FTimer.Enabled := True;
      FFirstTimerMessage := True;

      FUserGenerated := True;
      try
        if FUpButtonPressed then SetPosition(GetPosition + FIncrement) else SetPosition(GetPosition - FIncrement);
      finally
        FUserGenerated := False;
      end;
      Invalidate;
    end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  FMouseDownX := X;
  FMouseDownY := Y;
  if FMouseDown then Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FMouseDown then
    begin
      FMouseDown := False;
      FTimer.Enabled := False;
      Invalidate;
    end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.TimerEvent(Sender: TObject);
begin
  if FFirstTimerMessage then
    begin
      FTimer.Interval := 50;
      FFirstTimerMessage := False;
    end;

  FUserGenerated := True;
  try
    if FUpButtonPressed then SetPosition(GetPosition + FIncrement) else SetPosition(GetPosition - FIncrement);
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.Disable;
begin
  Enabled := False;
  if Assigned(FAssociate) then FAssociate.Disable;
  Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiUpDown.Enable;
begin
  Enabled := True;
  if Assigned(FAssociate) then FAssociate.Enable;
  Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorPageControl.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorPageControl.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result + DLGC_WANTALLKEYS + DLGC_WANTTAB;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorPageControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  Params.Style := Params.Style and     WS_CHILD;

  Params.ExStyle := Params.ExStyle or WS_EX_CONTROLPARENT;
  {$ENDIF}
end;
{$endif}
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorButton.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiComponentEditorButton.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//***********************************************************************************************************************************
constructor TiComponentEditorCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorCheckBox.DoChange;
begin                                                           
  inherited;
  if not FBlockingEvents then if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
  if Assigned(OnClick) then OnClick(Self);
end;
//***********************************************************************************************************************************
procedure TiComponentEditorCheckBox.Disable;
var
  TempOnClick : TNotifyEvent;
begin
  TempOnClick     := OnClick;
  OnClick         := nil;
  FBlockingEvents := True;
  try
    Enabled := False;
    Checked := False;
  finally
    FBlockingEvents := False;
    OnClick := TempOnClick;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorCheckBox.Enable;
begin
  Enabled := True;
end;
//***********************************************************************************************************************************
function TiComponentEditorCheckBox.GetAsBoolean: Boolean;
begin
  Result := Checked;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorCheckBox.SetAsBoolean(const Value: Boolean);
var
  TempOnClick : TNotifyEvent;
begin
  TempOnClick     := OnClick;
  OnClick         := nil;
  FBlockingEvents := True;
  try
    Checked := Value;
  finally
    FBlockingEvents := False;
    OnClick := TempOnClick;
  end;
end;
//***********************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorCheckBox.WMGetDLGCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTTAB;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiComponentEditorCheckBox.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorCheckBox.DoEnter;
begin
  inherited;
//  SetParentsToTopMost(Self);
end;
//***********************************************************************************************************************************
constructor TiComponentEditorRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
//***********************************************************************************************************************************
procedure TiComponentEditorRadioGroup.Click;
begin
  inherited;
  if not FBlockingEvents then if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorRadioGroup.Disable;
var
  TempOnClick : TNotifyEvent;
begin
  TempOnClick     := OnClick;
  OnClick         := nil;
  FBlockingEvents := True;
  try
    Enabled   := False;
    ItemIndex := -1;
  finally
    FBlockingEvents := False;
    OnClick         := TempOnClick;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorRadioGroup.Enable;
begin
  Enabled := True;
end;
//***********************************************************************************************************************************
function TiComponentEditorRadioGroup.GetAsInteger: Integer;
begin
  Result := ItemIndex;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorRadioGroup.SetAsInteger(const Value: Integer);
var
  TempOnClick  : TNotifyEvent;
  TempOnChange : TNotifyEvent;
begin
  TempOnClick     := OnClick;
  TempOnChange    := OnChange;
  OnClick         := nil;
  OnChange        := nil;
  FBlockingEvents := True;
  try
    ItemIndex := Value;
  finally
    FBlockingEvents := False;
    OnClick         := TempOnClick;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorRadioGroup.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//***********************************************************************************************************************************
constructor TiComponentEditorMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOriginalText := '';
end;
//***********************************************************************************************************************************
procedure TiComponentEditorMemo.Disable;
var
  TempOnClick  : TNotifyEvent;
begin
  TempOnClick     := OnClick;
  OnClick         := nil;
  OnClick         := nil;
  FBlockingEvents := True;
  try
    Enabled      := False;
    Color         := clBtnFace;
    Text          := '';
    FOriginalText := '';
  finally
    FBlockingEvents := False;
    OnClick         := TempOnClick;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorMemo.Enable;
begin
  Enabled := True;
  Color   := clWindow;
end;
//***********************************************************************************************************************************
function TiComponentEditorMemo.GetAsString: String;
begin
  Result := Text;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorMemo.SetAsString(const Value: String);
var
  TempOnClick  : TNotifyEvent;
  TempOnChange : TNotifyEvent;
begin
  TempOnClick     := OnClick;
  TempOnChange    := OnChange;
  OnClick         := nil;
  OnChange        := nil;
  FBlockingEvents := True;
  try
    Text          := Value;
    FOriginalText := Value;
  finally
    FBlockingEvents := False;
    OnClick         := TempOnClick;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorMemo.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if not WantReturns then
    begin
      if Key = #13 then
        begin
          DoUpdate;
          Key := #0;
          SelectAll;
        end;
    end;

  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorMemo.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result + DLGC_WANTTAB;
end;
{$endif}
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorMemo.WMKillFocus(var Message: TMessage);
begin
  inherited;
  DoUpdate;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiComponentEditorMemo.DoUpdate;
begin
  if FOriginalText <> Text then
    begin
      FOriginalText := Text;
      if Assigned(FOnUpdate) then FOnUpdate(Self);
      if not FBlockingEvents then if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
    end;
end;
//***********************************************************************************************************************************
constructor TiComponentEditorComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
//***********************************************************************************************************************************
procedure TiComponentEditorComboBox.Click;
begin
  //inherited;
  if not FBlockingEvents then if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorComboBox.Disable;
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange    := OnChange;
  OnChange        := nil;
  FBlockingEvents := True;
  try                                         
    Enabled   := False;
    Color     := clBtnFace;
    ItemIndex := -1;
    Text      := '';
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorComboBox.Enable;
begin
  Enabled := True;
  Color   := clWindow;
end;
//***********************************************************************************************************************************
function TiComponentEditorComboBox.GetAsInteger: Integer;
begin
  Result := ItemIndex;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorComboBox.SetAsInteger(const Value: Integer);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange    := OnChange;
  OnChange        := nil;
  FBlockingEvents := True;
  try
    ItemIndex := Value;
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
function TiComponentEditorComboBox.GetAsString: String;
begin
  Result := Text;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorComboBox.SetAsString(const Value: String);
var
  TempOnChange : TNotifyEvent;
begin
  TempOnChange    := OnChange;
  OnChange        := nil;
  FBlockingEvents := True;
  try
    Text := Value;
  finally
    FBlockingEvents := False;
    OnChange        := TempOnChange;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorComboBox.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorComboBox.WMGetDLGCode(var Message: TMessage);
begin
  inherited;
  Message.Result := Message.Result + DLGC_WANTTAB + DLGC_WANTARROWS;
end;
{$endif}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorComboBox.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  if Message.CharCode in [VK_LEFT, VK_RIGHT] then Message.Result := 1 else Message.Result := 0;
end;
{$endif}
//****************************************************************************************************************************************************
//***********************************************************************************************************************************
constructor TiComponentEditorListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Style    := lbOwnerDrawFixed;
  DragMode := dmAutomatic;
  Sorted   := False;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorListBox.DragDrop(Source: TObject; X, Y: Integer);
var
  Row : Integer;
begin
  Row := (Y  + TopIndex * ItemHeight)div ItemHeight;
  if Row > (Items.Count - 1) then Row := Items.Count - 1;

  if Row <> ItemIndex then
    begin
      Items.Move(ItemIndex, Row);
      ItemIndex := Row;
      if Assigned(FOnItemMove) then FOnItemMove(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorListBox.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = Self then Accept := True else Accept := False;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}procedure TiComponentEditorListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);         {$endif}
{$ifdef iCLX}function  TiComponentEditorListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState): Boolean;{$endif}
var
  DrawColorBox : Boolean;
  AColor       : TColor;
  AText        : String;
begin
  if Assigned(OnDrawItem) then
    begin
      {$ifdef iVCL}          inherited;{$endif}
      {$ifdef iCLX}Result := inherited DrawItem(Index, Rect, State);{$endif}
      Exit;
    end;

  DrawColorBox := True;
  AColor       := clRed;
  AText        := Items.Strings[Index];

  if Assigned(FOnGetData) then FOnGetData(Index, DrawColorBox, AColor, AText);

  with Canvas, Rect do
    begin
      if odSelected in State then
        begin
          Brush.Color := clTeal;
          Font.Color  := clWhite;
        end
      else
        begin
          Brush.Color := clWindow;
          Font.Color  := clBlack;
        end;

      FillRect(Rect);

      if DrawColorBox then
        begin
          TextOut(Left + 22, Top, AText);
          Brush.Color := AColor;
          Pen.Color   := clBlack;
          Rectangle(Left + 2, Top+1, Left + 18, Bottom-1);
        end
      else TextOut(Left + 2, Top, AText);
    end;
{$ifdef iCLX}Result:= True;{$endif}
end;
//***********************************************************************************************************************************
procedure TiComponentEditorListBox.SelectLast;
begin
  ItemIndex := Items.Count - 1;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorListBox.DeleteSelectedObject;
var
  LastIndex : Integer;
  AObject   : TObject;
begin
  if Items.Count = 0 then exit;

  LastIndex := ItemIndex;
  AObject   := Items.Objects[ItemIndex];

  Items.Delete(ItemIndex);
  AObject.Free;

  if Items.Count <> 0 then
    begin
      if LastIndex > (Items.Count - 1) then ItemIndex := LastIndex - 1
        else ItemIndex := LastIndex;
    end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorListBox.DeleteObjectIndex(AObject: TObject);
var
  LastIndex : Integer;
  Index     : Integer;
begin
  Index := Items.IndexOfObject(AObject);
  if Index = -1 then Exit;

  LastIndex := ItemIndex;
  Items.Delete(Index);

  if Items.Count <> 0 then
    begin
      if LastIndex < Items.Count then ItemIndex := LastIndex
        else ItemIndex := Items.Count-1;
    end;
end;
//***********************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorListBox.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    LBN_SELCHANGE : Click;
    LBN_DBLCLK    : DblClick;
  end;
end;
{$endif}
//***********************************************************************************************************************************
procedure TiComponentEditorListBox.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorListBox.WMGetDLGCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTTAB;
end;
{$endif}
//****************************************************************************************************************************************************
constructor TiComponentEditorColorPicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csOpaque, csDoubleClicks, csReplicatable];

  Width   := 47;
  Height  := 21;

  FColor := clRed;

  FButton := TButton.Create(Self);
  with FButton do
    begin
      Parent := Self;
      Width := 21;
      Height := 21;
      Left := Self.Width - Width;
      Caption := '...';
      Font.Style := [fsBold];
      OnClick := ButtonClick;
    end;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorColorPicker.OpenVCL;
var
  ColorDialog : TiColorDialog;
begin
  ColorDialog := TiColorDialog.Create(Self);

  try
    ColorDialog.Color := FColor;
    if ColorDialog.Execute then
      begin
        FColor := ColorDialog.Color;
        if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
        Invalidate;
        if Assigned(FOnChange) then FOnChange(Self);
      end;
  finally
    ColorDialog.Free;
  end;
end;
{$endif}
//****************************************************************************************************************************************************
{$ifdef iCLX}
procedure TiComponentEditorColorPicker.OpenCLX;
var
  ColorDialog : TColorDialog;

begin
  ColorDialog := TColorDialog.Create(Self);
  try
    ColorDialog.Color := FColor;
    if ColorDialog.Execute then
      begin
        FColor := ColorDialog.Color;
        if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
        Invalidate;
        if Assigned(FOnChange) then FOnChange(Self);
      end;
  finally
    ColorDialog.Free;
  end;
end;
{$endif}
//***********************************************************************************************************************************
procedure TiComponentEditorColorPicker.ButtonClick(Sender: TObject);
begin
{$ifdef iVCL}OpenVCL;{$endif}
{$ifdef iCLX}OpenCLX;{$endif}
end;
//***********************************************************************************************************************************
procedure TiComponentEditorColorPicker.Paint;
begin
  with Canvas do
    begin
      if Enabled then Brush.Color := FColor else Brush.Color := clBtnFace;
      Pen.Color   := clBlack;
      Rectangle(0, 0, Width - FButton.Width -1, Height);
      end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorColorPicker.SetColor(const Value: TColor);
begin
  if FColor <> Value then
    begin
      FColor := Value;
      Invalidate;
    end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorColorPicker.DblClick;
begin
  inherited;
  ButtonClick(Self);
end;
//***********************************************************************************************************************************
procedure TiComponentEditorColorPicker.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if Assigned(FButton) then FButton.Left   := Width - FButton.Width;
  if Assigned(FButton) then FButton.Height := Height;
  if not (csLoading in ComponentState) then if Assigned(FButton) then FButton.Left := Width - FButton.Width;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorColorPicker.Disable;
begin
  Enabled         := False;
  FButton.Enabled := False;
  Invalidate;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorColorPicker.Enable;
begin
  Enabled         := True;
  FButton.Enabled := True;
  Invalidate;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorColorPicker.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorColorPicker.WMGetDLGCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTTAB;
end;
{$endif}
//***********************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorColorPicker.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$endif}
//***********************************************************************************************************************************
constructor TiComponentEditorFontPicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 75;
  Height := 25;

  Caption := 'Font';

  FFont := TFont.Create;
end;
//***********************************************************************************************************************************
destructor TiComponentEditorFontPicker.Destroy;
begin
  FFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorFontPicker.OpenVCL;
var
  FontDialog : TiFontDialog;
begin
  FontDialog := TiFontDialog.Create(Self);

  try
    FontDialog.Font.Assign(FFont);
    if FontDialog.Execute then
      begin
        FFont.Assign(FontDialog.Font);
        if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
        Invalidate;
        if Assigned(FOnChange) then FOnChange(Self);
      end;
  finally
    FontDialog.Free;
  end;
end;
{$endif}
//****************************************************************************************************************************************************
{$ifdef iCLX}
procedure TiComponentEditorFontPicker.OpenCLX;
var
  FontDialog : TFontDialog;
begin
  FontDialog := TFontDialog.Create(Self);
  try
    FontDialog.Font.Assign(FFont);
    if FontDialog.Execute then
      begin
        FFont.Assign(FontDialog.Font);
        if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
        Invalidate;
        if Assigned(FOnChange) then FOnChange(Self);
      end;
  finally
    FontDialog.Free;
  end;
end;
{$endif}
//***********************************************************************************************************************************
procedure TiComponentEditorFontPicker.Click;
begin
  inherited;
{$ifdef iVCL}OpenVCL;{$endif}
{$ifdef iCLX}OpenCLX;{$endif}
end;
//***********************************************************************************************************************************
procedure TiComponentEditorFontPicker.SetFont(const Value: TFont);
begin
  Font.Assign(Value)
end;
//***********************************************************************************************************************************
procedure TiComponentEditorFontPicker.Disable;
begin
  Enabled := False;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorFontPicker.Enable;
begin
  Enabled := True;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorFontPicker.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorFontPicker.WMGetDLGCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTTAB;
end;
{$endif}
//***********************************************************************************************************************************
constructor TiComponentEditorOpenPicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Caption := 'Open';
  Width   := 75;
  Height  := 25;
  TabStop := True;

  FFiles := TStringList.Create;
end;
//****************************************************************************************************************************************************
destructor TiComponentEditorOpenPicker.Destroy;
begin
  FFiles.Free;
  inherited;
end;
//***********************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorOpenPicker.CreateParams(var Params: TCreateParams);
const
  ButtonStyles: array[Boolean] of DWORD = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'BUTTON');
  Params.Style := Params.Style or ButtonStyles[False];
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$endif}
//***********************************************************************************************************************************
{$ifdef iVCL}
procedure TiComponentEditorOpenPicker.OpenVCL;
var
  OpenDialog   : TiOpenDialog;
  TempFileName : String;
begin
  inherited;

  OpenDialog := TiOpenDialog.Create(Self);
  OpenDialog.FileMustExist := FFileMustExist;

  TempFileName := FFileName;
  if Copy(TempFileName, Length(TempFileName), 1) = '\' then TempFileName := TempFileName + 'Untitled';

  try
    OpenDialog.FileName         := TempFileName;
    OpenDialog.Filter           := FFilter;
    OpenDialog.DefaultExt       := FDefaultExt;
    OpenDialog.AllowMultiSelect := FAllowMultiSelect;
    if OpenDialog.Execute then
      begin
        FileName := OpenDialog.FileName;
        FFiles.Assign(OpenDialog.Files);
        if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
        Invalidate;
        if Assigned(FOnChange) then FOnChange(Self);
      end;
  finally                    
    OpenDialog.Free;
  end;
end;
{$endif}
//***********************************************************************************************************************************
{$ifdef iCLX}
procedure TiComponentEditorOpenPicker.OpenCLX;
var
 OpenDialog : TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(Self);
  if FFileMustExist then OpenDialog.Options := [ofFileMustExist] else OpenDialog.Options := [];
  if FAllowMultiSelect then  OpenDialog.Options :=  OpenDialog.Options + [ofAllowMultiSelect];

  try
    OpenDialog.FileName   := FFileName;
    OpenDialog.Filter     := FFilter;
    OpenDialog.DefaultExt := FDefaultExt;
    if OpenDialog.Execute then
      begin
        FileName := OpenDialog.FileName;
        FFiles.Assign(OpenDialog.Files);
        if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
        Invalidate;
        if Assigned(FOnChange) then FOnChange(Self);
      end;
  finally
    OpenDialog.Free;
  end;
end;
{$endif}
//***********************************************************************************************************************************
procedure TiComponentEditorOpenPicker.Click;
begin
  inherited;
{$ifdef iVCL}OpenVCL;{$endif}
{$ifdef iCLX}OpenCLX;{$endif}
end;
//***********************************************************************************************************************************
procedure TiComponentEditorOpenPicker.Disable;
begin
  Enabled := False;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorOpenPicker.Enable;
begin
  Enabled := True;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorOpenPicker.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorOpenPicker.WMGetDLGCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTTAB;
end;
{$endif}
//***********************************************************************************************************************************
constructor TiComponentEditorSavePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Caption := 'Save';
  Width   := 75;
  Height  := 25;
  TabStop := True;
end;
//***********************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorSavePicker.CreateParams(var Params: TCreateParams);
const
  ButtonStyles: array[Boolean] of DWORD = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'BUTTON');
  Params.Style := Params.Style or ButtonStyles[False];
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$endif}
//****************************************************************************************************************************************************
{$ifdef iVCL}
function TiComponentEditorSavePicker.OpenVCL: Boolean;
var
  SaveDialog   : TiSaveDialog;
  TempFileName : String;
begin
  inherited;

  TempFileName := FFileName;
  if Copy(TempFileName, Length(TempFileName), 1) = '\' then TempFileName := TempFileName + 'Untitled';

  SaveDialog := TiSaveDialog.Create(Self);
  try
    SaveDialog.FileName   := TempFileName;
    SaveDialog.Filter     := FFilter;
    SaveDialog.DefaultExt := FDefaultExt;
    if SaveDialog.Execute then
      begin
        Result := True;
        FileName := SaveDialog.FileName;
        if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
        Invalidate;
        if Assigned(FOnChange) then FOnChange(Self);
      end
    else Result := False;
  finally
    SaveDialog.Free;
  end;
end;
{$endif}
//****************************************************************************************************************************************************
{$ifdef iCLX}
function TiComponentEditorSavePicker.OpenCLX: Boolean;
var
  SaveDialog : TSaveDialog;
begin
  inherited;

  SaveDialog := TSaveDialog.Create(Self);
  try
    SaveDialog.FileName   := FFileName;
    SaveDialog.Filter     := FFilter;
    SaveDialog.DefaultExt := FDefaultExt;
    if SaveDialog.Execute then
      begin
        Result := True;
        FileName := SaveDialog.FileName;
        if (Owner is TiCustomEditorForm) then (Owner as TiCustomEditorForm).UserChange;
        Invalidate;
        if Assigned(FOnChange) then FOnChange(Self);
      end
    else Result := False;
  finally
    SaveDialog.Free;
  end;
end;
{$endif}
//****************************************************************************************************************************************************
function TiComponentEditorSavePicker.Execute: Boolean;
begin
  {$ifdef iVCL}Result := OpenVCL;{$endif}
  {$ifdef iCLX}Result := OpenCLX;{$endif}
end;
//***********************************************************************************************************************************
procedure TiComponentEditorSavePicker.Click;
begin
  inherited;
  Execute;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorSavePicker.Disable;
begin
  Enabled := False;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorSavePicker.Enable;
begin
  Enabled := True;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorSavePicker.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;
      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;
  inherited;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorSavePicker.WMGetDLGCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTTAB;
end;
{$endif}
//***********************************************************************************************************************************
constructor TiComponentEditorValueConverterPicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Caption := '...';
  Width   := 21;
  Height  := 21;
  TabStop := True;
end;
//***********************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorValueConverterPicker.CreateParams(var Params: TCreateParams);
const
  ButtonStyles: array[Boolean] of DWORD = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'BUTTON');
  Params.Style := Params.Style or ButtonStyles[False];
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$endif}
//***********************************************************************************************************************************
procedure TiComponentEditorValueConverterPicker.Click;
begin
  inherited;
  iValueConverterEditForm := TiValueConverterEditForm.Create(Self);
  try
    case FDefaultPage of
      ivcptInterval  : iValueConverterEditForm.PageControl.ActivePage := iValueConverterEditForm.IntervalTabSheet;
      ivcptDateTime  : iValueConverterEditForm.PageControl.ActivePage := iValueConverterEditForm.DateTimeTabSheet;
      ivcptPrice32nd : iValueConverterEditForm.PageControl.ActivePage := iValueConverterEditForm.Price32TabSheet;
    end;

    if Assigned(FTranslationMethod) then FTranslationMethod(iValueConverterEditForm);

    if Assigned(FAssociate) then
      iValueConverterEditForm.Value := FAssociate.AsFloat
    else
      iValueConverterEditForm.Value := DateTime;

    if iValueConverterEditForm.ShowModal = mrOk then
      begin
        FDateTime := iValueConverterEditForm.Value;

        if Assigned(FAssociate) then FAssociate.SetDoubleWithEvent(iValueConverterEditForm.Value);
        if Assigned(FOnChange)  then FOnChange(Self);
      end;
  finally
    iValueConverterEditForm.Free;
  end;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorValueConverterPicker.Disable;
begin
  Enabled := False;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorValueConverterPicker.Enable;
begin
  Enabled := True;
end;
//***********************************************************************************************************************************
procedure TiComponentEditorValueConverterPicker.KeyPress(var Key: Char);
var
  AOwner : TCustomForm;
begin
  if Key = #9 then
    begin
      Key := #0;

      if Owner is TCustomForm then
        begin
          AOwner := Owner as TCustomForm;

          if GetShiftDown then
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, False, True)
          else
            TWinControlAccess(AOwner).SelectNext(AOwner.ActiveControl, True, True);
        end;
    end;

  inherited;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorValueConverterPicker.WMGetDLGCode(var Message: TMessage);
begin
  Message.Result := DLGC_WANTALLKEYS + DLGC_WANTTAB;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiComponentEditorValueConverterPicker.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FAssociate) then FAssociate := nil;
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorValueConverterPicker.SetAssociate(const Value: TiComponentEditorEdit);
begin
  FAssociate := Value;
  if Assigned(FAssociate) then
    begin
      Left   := FAssociate.Left + FAssociate.Width;
      Top    := FAssociate.Top;
      Height := FAssociate.Height;
    end;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}

end;
{$endif}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}

end;
{$endif}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorGroupBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  Params.Style := Params.Style and     WS_CHILD;

  Params.ExStyle := Params.ExStyle or WS_EX_CONTROLPARENT;
  {$ENDIF}
end;
{$endif}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}

end;
{$endif}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorButton.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}

end;
{$endif}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiComponentEditorRadioGroup.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {$IFDEF iActiveX}
  Params.Style := Params.Style and not WS_TABSTOP;
  Params.Style := Params.Style and not WS_GROUP;
  {$ENDIF}
end;
{$endif}
//****************************************************************************************************************************************************
constructor TiComponentEditorComputerPicker.Create(AOwner: TComponent);
begin
  inherited;
  Width   := 25;
  Height  := 25;
  Caption := '...';
end;
//****************************************************************************************************************************************************
procedure TiComponentEditorComputerPicker.Click;
begin
  inherited;

  iOPCComputerSelectorForm := TiOPCComputerSelectorForm.Create(Self);
  try
    iOPCComputerSelectorForm.ComputerName := FComputerName;
    iOPCComputerSelectorForm.Setup;
    if iOPCComputerSelectorForm.ShowModal = mrOk then
      begin
        FComputerName := iOPCComputerSelectorForm.ComputerName;
        if Assigned(FOnChange) then FOnChange(Self);
      end;
  finally
    iOPCComputerSelectorForm.Free;
  end;
end;
//****************************************************************************************************************************************************
{ TiPaintBox }
constructor TiPaintBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFDEF iVCL}
  DoubleBuffered := True;
  {$ENDIF}
  ControlStyle := ControlStyle + [csOpaque];
end;
//****************************************************************************************************************************************************
procedure TiPaintBox.Paint;
begin
  if csDesigning in ComponentState then
    with Canvas do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;

  if Assigned(FOnPaint) then FOnPaint(Self);
end;
//****************************************************************************************************************************************************
end.
