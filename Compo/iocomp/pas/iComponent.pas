{*******************************************************}
{                                                       }
{       TiComponent                                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iComponent;{$endif}
{$ifdef iCLX}unit QiComponent;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions,   iMath, ActiveX;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath;         {$ENDIF}

type
  TiPaintEvent = procedure(Sender: TObject; Canvas: TCanvas) of object;

  TiComponent = class(TCustomControl)
  private
    FOnPaint                      : TiPaintEvent;
    FCreationTime                 : Double;
    F10MinTimeout                 : Boolean;
    FUpdateActive                 : Boolean;
    FUpdateFrameRate              : Integer;
    FLastUpdate                   : Double;
    FNeedsInvalidateChange        : Boolean;
    FNeedsBackGroundChange        : Boolean;
    FBackGroundBitmap             : TBitmap;
    FOffScreenBitmap              : TBitmap;
    FBackGroundPicture            : TBitmap;
    FBackGroundColor              : TColor;
    FBackGroundChanged            : Boolean;

    FBorderStyle                  : TiBevelStyle;
    FOffsetY                      : Integer;
    FOffsetX                      : Integer;
    FShowDisabledState            : Boolean;

    FHasFocus                     : Boolean;
    FOnChangeProtected            : TChangePropertyEvent;
    FOnRequestEdit                : TRequestEditEvent;
    FAutoFrameRate                : Boolean;
    FLoading                      : Boolean;
    FOnGetDesigning               : TGetDesigningEvent;
    FActiveXDesigning             : Boolean;
    FCachedDrawing                : Boolean;
    FOptionSaveAllProperties      : Boolean;
    FUserGenerated                : Boolean;

    FErrorActive                  : Boolean;
    FErrorText                    : String;
    FErrorBackGroundColor         : TColor;
    FErrorFont                    : TFont;
    FLicensed                     : Boolean;
  protected
    function GetCenterPointDouble(Canvas:TCanvas): TPointDouble;
    function GetLoading           : Boolean;
    function GetBorderMargin      : Integer;
    function GetCenterPoint     (Canvas:TCanvas): TPoint;                    virtual;

    procedure SetOffsetX             (const Value: Integer);
    procedure SetOffsetY             (const Value: Integer);
    procedure SetShowDisabledState   (const Value: Boolean);
    procedure SetBackGroundPicture   (const Value: TBitmap);
    procedure SetUpdateFrameRate     (const Value: Integer);
    procedure SetAutoFrameRate       (const Value: Boolean);
    procedure SetCachedDrawing       (const Value: Boolean);      virtual;
    procedure SetBorderStyle         (const Value: TiBevelStyle); virtual;
    procedure SetBackGroundColor     (const Value: TColor      ); virtual;

    procedure SetErrorActive         (const Value: Boolean);
    procedure SetErrorText           (const Value: String);
    procedure SetErrorBackGroundColor(const Value: TColor);
    procedure SetErrorFont           (const Value: TFont);

    procedure DrawBackGround      (Canvas: TCanvas; BackGroundColor: TColor); virtual;
    procedure DrawBorder          (Canvas: TCanvas);                          virtual;

    procedure CreateBackGroundBitmap;
    procedure CreateOffScreenBitmap;

    procedure ShowOffScreenBitmap (Bitmap: TBitmap);
    procedure ShowBackGround;

    procedure BackGroundChange;
    procedure InvalidateChange;                  
    procedure InvalidateNow;

    procedure BackGroundChangeEvent(Sender : TObject);
    procedure InvalidateChangeEvent(Sender : TObject);
    procedure InvalidateNowEvent   (Sender : TObject);

    function  GetIsDesigning: Boolean;
    function  GetBackGroundBitmap: TBitmap;
                                                      
    procedure ResetBackGroundChange;
    procedure TransferBackGround(Canvas: TCanvas);
    procedure DoRepaintType(Value : TiRepaintType);
    property  BackGroundBitmap  : TBitmap      read GetBackGroundBitmap;
    property  BackGroundChanged : Boolean      read FBackGroundChanged;

    procedure SetLoading(Value: Boolean);

    function  GetPropertyType(Instance: TPersistent; Path: String; PropertyName: String): TiTypeKind;

    procedure PropertyVarType(PropertyName: String; var AVarType: TiTypeKind);

    function  GetTimerRunning : Boolean;                   virtual; abstract;
    procedure TimerStart(InitialDelay, Interval: Integer); virtual; abstract;
    procedure TimerStop;                                   virtual; abstract;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure DblClick;                                                           override;

    procedure KeyDown (var Key: Word; Shift: TShiftState); override;
    procedure KeyUp   (var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char);                     override;

    function OPCOutputData(PropertyName: String; Value: OleVariant): Boolean; virtual;

    procedure iDoSetFocus;  virtual;
    procedure iDoKillFocus; virtual;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint); virtual;
    procedure iKeyUp         (var CharCode: Word; Shift: TShiftState);  virtual;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);  virtual;
    procedure iKeyPress      (var Key: Char);                           virtual;

    procedure iMouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer         );          virtual;
    procedure iMouseUp   (Button: TMouseButton; Shift: TShiftState; X, Y: Integer         );          virtual;
    procedure iMouseMove (                      Shift: TShiftState; X, Y: Integer         );          virtual;

    procedure iDoubleClick;                                                                           virtual;

    function  iMouseWheel(WheelDelta: Integer;  Shift: TShiftState; const MousePos: TPoint): Boolean; virtual;

    function  GetXYRadPoint(AngleDegrees, Radius: Double; Offset : TPoint) : TPoint;

    procedure Paint;                     override;

    procedure PaintToDC;
    procedure PaintToMetaFile;
    procedure PaintEvalExpired;
    procedure iPaintTo(Canvas: TCanvas); virtual; abstract;

    procedure CreateBackGroundPicture;

    procedure SetBooleanProperty(Value : Boolean; var FVariable : Boolean; RepaintType : TiRepaintType);
    procedure SetIntegerProperty(Value : Integer; var FVariable : Integer; RepaintType : TiRepaintType);
    procedure SetDoubleProperty (Value : Double;  var FVariable : Double;  RepaintType : TiRepaintType);
    procedure SetStringProperty (Value : String;  var FVariable : String;  RepaintType : TiRepaintType);
    procedure SetColorProperty  (Value : TColor;  var FVariable : TColor;  RepaintType : TiRepaintType);
    procedure SetWideStringProperty(Value: WideString; var FVariable: WideString; RepaintType: TiRepaintType);

    {$IFDEF iVCL}procedure SetEnabled(      Value: Boolean); override;{$ENDIF}
    {$IFDEF iCLX}procedure SetEnabled(const Value: Boolean); override;{$ENDIF}

    procedure DoRepaint;
    procedure DoFrameRate;
    procedure DoIsDesigning(Sender: TObject; var Designing: Boolean);

    property  HasFocus              : Boolean              read FHasFocus;
    property  Loading               : Boolean              read GetLoading;
    property  UpdateActive          : Boolean              read FUpdateActive;

    property OnRequestEditProtected : TRequestEditEvent    read FOnRequestEdit        write FOnRequestEdit;
    property OnChangeProtected      : TChangePropertyEvent read FOnChangeProtected    write FOnChangeProtected;


    property BorderMargin         : Integer            read GetBorderMargin;

    property IsDesigning          : Boolean            read GetIsDesigning;
    property OnGetDesigning       : TGetDesigningEvent read FOnGetDesigning       write FOnGetDesigning;
    property ActiveXDesigning     : Boolean            read FActiveXDesigning     write FActiveXDesigning;

    property UserGenerated        : Boolean            read FUserGenerated        write FUserGenerated;
    property OnPaint              : TiPaintEvent       read FOnPaint              write FOnPaint;

    property BackGroundColor      : TColor             read FBackGroundColor      write SetBackGroundColor       default clBtnFace;
    property BackGroundPicture    : TBitmap            read FBackGroundPicture    write SetBackGroundPicture;
    property OffsetX              : Integer            read FOffsetX              write SetOffsetX               default 0;
    property OffsetY              : Integer            read FOffsetY              write SetOffsetY               default 0;
    property ShowDisabledState    : Boolean            read FShowDisabledState    write SetShowDisabledState     default False;
    property CachedDrawing        : Boolean            read FCachedDrawing        write SetCachedDrawing         default True;

    property ErrorActive          : Boolean            read FErrorActive          write SetErrorActive;
    property ErrorText            : String             read FErrorText            write SetErrorText;
    property ErrorFont            : TFont              read FErrorFont            write SetErrorFont;
    property ErrorBackGroundColor : TColor             read FErrorBackGroundColor write SetErrorBackGroundColor;

    property Licensed             : Boolean            read FLicensed             write FLicensed;
  public
    property    BorderStyle       : TiBevelStyle       read FBorderStyle          write SetBorderStyle           default ibsNone;

    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
    procedure   RepaintAll;  virtual;
    procedure   BeginUpdate; virtual;
    procedure   EndUpdate;   virtual;
    procedure   Lock;        virtual; abstract;
    procedure   Unlock;      virtual; abstract;

    procedure SaveImageToBitmap  (FileName: String);

    procedure SavePropertiesToFile  (FileName: String); virtual;
    procedure LoadPropertiesFromFile(FileName: String); virtual;
  published
    property Visible;
    property Enabled;
    property ShowHint;
    property PopupMenu;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnEnter;
    property OnExit;
    property Anchors;
    property Constraints;

    property OptionSaveAllProperties : Boolean read FOptionSaveAllProperties write FOptionSaveAllProperties default False;
    property AutoFrameRate           : Boolean read FAutoFrameRate           write SetAutoFrameRate         default False;
    property UpdateFrameRate         : Integer read FUpdateFrameRate         write SetUpdateFrameRate       default 60;
  end;

{$ifdef iVCL}{$R  iIocompCommon.res} {$endif}
{$ifdef iCLX}{$R QiIocompCommon.res}{$endif}

implementation

{$IFDEF EVAL}
{$ifdef iVCL}uses  Evaluation, Controls; {$endif}
{$ifdef iCLX}uses QEvaluation;{$endif}
{$ENDIF}


type
  TWinControlAccess = class(TWinControl) end;
//****************************************************************************************************************************************************
constructor TiComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csReplicatable, csOpaque];

  FCreationTime      := Now;
  FBackGroundColor   := clBtnFace;
  FBackGroundChanged := True;                                                   
  FLastUpdate        := Now;
  FCachedDrawing     := True;
  FUpdateFrameRate   := 60;
  FAutoFrameRate     := False;
  FOffsetX           := 0;
  FOffsetY           := 0;
  FShowDisabledState := False;

  FLicensed          := True;

  FErrorFont := TFont.Create;
  with FErrorFont do
    begin
      FErrorFont.Color := clRed;
      FErrorFont.Style := [fsBold];
      OnChange := InvalidateChangeEvent;
    end;

  FErrorText := 'Error';
end;
//****************************************************************************************************************************************************
destructor TiComponent.Destroy;
begin
  if Assigned(FBackGroundBitmap)  then FBackGroundBitmap.Free;
  if Assigned(FBackGroundPicture) then FBackGroundPicture.Free;

  FErrorFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetBackGroundPicture(const Value: TBitmap);
begin
  FBackGroundPicture.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiComponent.DoRepaint;
begin
  FNeedsBackGroundChange := False;
  FNeedsInvalidateChange := False;
  FLastUpdate            := Now;
  Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiComponent.DoFrameRate;
var
  UpdateInterval : Double;
begin
  if not FAutoFrameRate   then
    begin
      DoRepaint;
      Exit;
    end;

  if FUpdateFrameRate = 0 then
    begin
      DoRepaint;
      Exit;
    end;

  UpdateInterval := 1/(FUpdateFrameRate *24*60*60);
  if Now > (FLastUpdate + UpdateInterval) then DoRepaint;
end;
//****************************************************************************************************************************************************
procedure TiComponent.BeginUpdate;
begin
  FUpdateActive := True;
end;
//****************************************************************************************************************************************************
procedure TiComponent.EndUpdate;
begin
  FUpdateActive := False;

  if FNeedsBackGroundChange or FNeedsInvalidateChange then DoFrameRate
end;
//****************************************************************************************************************************************************
procedure TiComponent.BackGroundChange;
begin
  FBackGroundChanged := True;

  if FUpdateActive then
    begin
      FNeedsBackGroundChange := True;
    end
  else if FAutoFrameRate then
    begin
      FNeedsBackGroundChange := True;
      DoFrameRate;
    end
  else DoRepaint;
end;
//****************************************************************************************************************************************************
procedure TiComponent.InvalidateChange;
begin
  if FUpdateActive then
    begin
      FNeedsInvalidateChange := True;
    end
  else if FAutoFrameRate then
    begin
      FNeedsInvalidateChange := True;
      DoFrameRate;
    end
  else DoRepaint;
end;
//****************************************************************************************************************************************************
procedure TiComponent.InvalidateNow;
begin
  DoRepaint;
end;
//****************************************************************************************************************************************************
procedure TiComponent.ShowOffScreenBitmap(Bitmap : TBitmap);
begin
  Canvas.Draw(0, 0, Bitmap);
end;
//****************************************************************************************************************************************************
procedure TiComponent.TransferBackGround (Canvas : TCanvas);begin Canvas.Draw(0, 0, FBackGroundBitmap);end;
procedure TiComponent.ShowBackGround;                       begin Canvas.Draw(0, 0, FBackGroundBitmap);end;
//****************************************************************************************************************************************************
procedure TiComponent.SetErrorActive         (const Value: Boolean);begin SetBooleanProperty(Value, FErrorActive,         irtBackGround);end;
procedure TiComponent.SetErrorText           (const Value: String );begin SetStringProperty (Value, FErrorText,           irtBackGround);end;
procedure TiComponent.SetErrorBackGroundColor(const Value: TColor );begin SetColorProperty  (Value, FErrorBackGroundColor,irtBackGround);end;
procedure TiComponent.SetBackGroundColor     (const Value: TColor );begin SetColorProperty  (Value, FBackGroundColor,     irtBackGround);end;
procedure TiComponent.SetOffsetX             (const Value: Integer);begin SetIntegerProperty(Value, FOffsetX,             irtBackGround);end;
procedure TiComponent.SetOffsetY             (const Value: Integer);begin SetIntegerProperty(Value, FOffsetY,             irtBackGround);end;
procedure TiComponent.SetUpdateFrameRate     (const Value: Integer);begin SetIntegerProperty(Value, FUpdateFrameRate,     irtBackGround);end;
procedure TiComponent.SetShowDisabledState   (const Value:Boolean );begin SetBooleanProperty(Value, FShowDisabledState,   irtBackGround);end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}procedure TiComponent.SetEnabled(      Value : Boolean);{$ENDIF}
{$IFDEF iCLX}procedure TiComponent.SetEnabled(const Value : Boolean);{$ENDIF}
begin
  inherited SetEnabled(Value);                        

  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetErrorFont(const Value: TFont);
begin
  FErrorFont.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetBorderStyle(const Value: TiBevelStyle);
begin
  if FBorderStyle <> Value then
    begin
      FBorderStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetAutoFrameRate(const Value: Boolean);
begin
  if FAutoFrameRate <> Value then
    begin
      FAutoFrameRate := Value;
      if not FAutoFrameRate then EndUpdate else BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.DrawBackGround(Canvas : TCanvas; BackGroundColor: TColor);
var
  NeedsBackGroundPictureDrawn : Boolean;
begin
  FBackGroundChanged := False;
  with Canvas do
    begin
      NeedsBackGroundPictureDrawn := True;

      if Assigned(FBackGroundPicture) then
        begin
          if FBackGroundPicture.Width = 0 then NeedsBackGroundPictureDrawn := False;
        end
      else NeedsBackGroundPictureDrawn := False;

      if NeedsBackGroundPictureDrawn then
        begin
          Canvas.StretchDraw(Rect(0,0,Width, Height),FBackGroundPicture);
        end
      else
        begin
          Brush.Style := bsSolid;             
          Brush.Color := BackGroundColor;
          FillRect(Rect(0, 0, Width, Height));
          DrawBorder(Canvas);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.DrawBorder(Canvas : TCanvas);
var
  DrawRect : TRect;
begin
  with Canvas do
    begin
      DrawRect := Rect(0, 0, Width, Height);
      case FBorderStyle of
        ibsLowered : iDrawEdge(Canvas, DrawRect, idesSunken);
        ibsRaised  : iDrawEdge(Canvas, DrawRect, idesRaised);
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.RepaintAll;
begin
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiComponent.ResetBackGroundChange;
begin
  FBackGroundChanged := False;
end;
//****************************************************************************************************************************************************
function TiComponent.GetCenterPoint(Canvas:TCanvas): TPoint;
begin
  Result := Point((Width) div 2 + OffsetX, (Height) div 2 + OffsetY);
end;
//****************************************************************************************************************************************************
function TiComponent.GetCenterPointDouble(Canvas:TCanvas): TPointDouble;
begin
  Result.x := (Width  - 1)/2;
  Result.y := (Height - 1)/2;
end;
//****************************************************************************************************************************************************
function TiComponent.GetXYRadPoint(AngleDegrees, Radius: Double; Offset : TPoint) : TPoint;
begin
  Result := Point(Offset.x + Round(Cos(DegToRad(AngleDegrees))*Radius),Offset.y - Round(Sin(DegToRad(AngleDegrees))*Radius));
end;
//****************************************************************************************************************************************************
procedure TiComponent.BackGroundChangeEvent(Sender: TObject);
begin
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiComponent.InvalidateChangeEvent(Sender: TObject);
begin
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiComponent.InvalidateNowEvent(Sender: TObject);
begin
  InvalidateNow;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetBooleanProperty(Value: Boolean; var FVariable: Boolean; RepaintType : TiRepaintType);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      DoRepaintType(RepaintType);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetIntegerProperty(Value: Integer; var FVariable: Integer; RepaintType : TiRepaintType);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      DoRepaintType(RepaintType);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetDoubleProperty(Value: Double; var FVariable: Double; RepaintType: TiRepaintType);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      DoRepaintType(RepaintType);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetStringProperty(Value: String; var FVariable: String; RepaintType: TiRepaintType);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      DoRepaintType(RepaintType);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetWideStringProperty(Value: WideString; var FVariable: WideString; RepaintType: TiRepaintType);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      DoRepaintType(RepaintType);
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetColorProperty(Value: TColor; var FVariable: TColor; RepaintType : TiRepaintType);
begin
  if FVariable <> Value then
    begin
      FVariable := Value;
      DoRepaintType(RepaintType);
    end;
end;
//****************************************************************************************************************************************************
function TiComponent.GetLoading: Boolean;
begin
  Result := False;
  if csLoading in ComponentState then Result := True;
  if FLoading                    then Result := True;
end;
//****************************************************************************************************************************************************
procedure TiComponent.DoRepaintType(Value: TiRepaintType);
begin
  case Value of
    irtInvalidate : InvalidateChange;
    irtBackGround : BackGroundChange;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.CreateOffScreenBitmap;
begin
  FOffScreenBitmap         := TBitmap.Create;
  FOffScreenBitmap.Width   := Width;
  FOffScreenBitmap.Height  := Height;
end;
//****************************************************************************************************************************************************
procedure TiComponent.CreateBackGroundBitmap;
begin
  if not Assigned(FBackGroundBitmap) then
    begin
      FBackGroundBitmap        := TBitmap.Create;
      FBackGroundBitmap.Width  := Width;
      FBackGroundBitmap.Height := Height;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.CreateBackGroundPicture;
begin
  FBackGroundPicture          := TBitmap.Create;
  FBackGroundPicture.OnChange := BackGroundChangeEvent;
end;
//****************************************************************************************************************************************************
function TiComponent.GetBackGroundBitmap: TBitmap;
begin
  CreateBackGroundBitmap;
  Result := FBackGroundBitmap;
end;
//****************************************************************************************************************************************************
procedure TiComponent.Paint;
begin
  {$IFDEF EVAL}
  TEvaluationForm.DoEvalCheck;
  {$ENDIF}
  if Licensed then PaintToDC
  else
    begin
      if FCreationTime > Now              then F10MinTimeout := True;
      if Now > FCreationTime + 10/(24*60) then F10MinTimeout := True;

      if F10MinTimeout then PaintEvalExpired
      else                  PaintToDC;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.PaintEvalExpired;
var
  ARect       : TRect;
  AText       : String;
  ATextHeight : Integer;
begin
  with Canvas do
    begin
      AText := 'License Not Found!' + #13+#10+ 'Evaluation 10 Minute Limit Exceeded.';
      ARect := Rect(0, 0, Width, Height);
      Brush.Color := clBlack;
      Font.Color  := clWhite;
      FillRect(ARect);

      ATextHeight := iDrawText(Canvas, AText, ARect, [itfHCenter, itfVCenter, itfWordBreak, itfCalcRect, itfNoClip], True, clBtnFace);

      ARect := Rect(0,     Height div 2 - ATextHeight div 2,
                    Width, Height div 2 + ATextHeight div 2);

      iDrawText(Canvas, AText, ARect, [itfHCenter, itfVCenter, itfWordBreak,  itfNoClip], True, clBtnFace)
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.PaintToMetaFile;
var
  OldCachedDrawing : Boolean;
begin
  try
    Lock;
    try
      OldCachedDrawing := FCachedDrawing;
      FCachedDrawing := False;
      try
        iPaintTo(Canvas);
      finally
        FCachedDrawing := OldCachedDrawing;
      end;
    finally
      Unlock;
    end;
  except
    on exception do;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.PaintToDC;
var
  ARect : TRect;
begin
  try                                                                                                      
    Lock;
    try
      CreateOffScreenBitmap;
      try
        FOffScreenBitmap.Canvas.Brush.Style := bsSolid;
        FOffScreenBitmap.Canvas.Pen.Style   := psSolid;
        try
          iPaintTo(FOffScreenBitmap.Canvas);
        except
          on e: Exception do
            begin
              with FOffScreenBitmap.Canvas do
                begin
                  ARect := GetClientRect;
                  Brush.Color := clBlack;            
                  FillRect(ARect);
                  Font.Color := clWhite;
                  iDrawText(FOffScreenBitmap.Canvas, e.Message, ARect, [itfWordBreak], True, clBtnFace);
              end;
          end;
        end;


        if Assigned(FOnPaint) then FOnPaint(Self, FOffScreenBitmap.Canvas);

        ShowOffScreenBitmap(FOffScreenBitmap);
      finally
        FOffScreenBitmap.Free;
      end;
    finally
      Unlock;
    end;
  except
    on exception do;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.iDoKillFocus;
begin
  try
    FHasFocus := False;
    iMouseUp(mbLeft, [], 0, 0);
    Invalidate;
  except
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.iDoSetFocus;
begin
  FHasFocus := True;
  Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiComponent.KeyUp(var Key: Word; Shift: TShiftState);
begin
  FUserGenerated := True;
  try
    try
      inherited KeyUp(Key, Shift);
      iKeyUp(Key, Shift);
    except
      on exception do;
    end;
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FUserGenerated := True;
  try
    try
      inherited KeyDown(Key, Shift);
      {$IFNDEF NASA_KENNEDY}
      iKeyDown(Key, Shift);
      {$ENDIF}
    except
      on exception do;
    end;
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.KeyPress(var Key: Char);
begin
  FUserGenerated := True;
  try
    try
      inherited KeyPress(Key);
      {$IFNDEF NASA_KENNEDY}
      iKeyPress(Key);
      {$ENDIF}
    except
      on exception do;
    end;
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FUserGenerated := True;
  try
    {$IFNDEF NASA_KENNEDY}
    iMouseDown(Button, Shift, X, Y);
    {$ENDIF}

    inherited MouseDown(Button, Shift, X, Y);
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  FUserGenerated := True;
  try
    iMouseMove(Shift, X, Y);
    inherited MouseMove(Shift, X, Y);
  finally
    FUserGenerated := False;
  end;
end;                                                           
//****************************************************************************************************************************************************
procedure TiComponent.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FUserGenerated := True;
  try
    iMouseUp(Button, Shift, X, Y);
    inherited MouseUp(Button, Shift, X, Y);
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.DblClick;
begin
  FUserGenerated := True;
  try
    iDoubleClick;
    inherited DblClick;
  finally
    FUserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.iWantSpecialKey(var CharCode: Word; var Result: Longint);begin end;
procedure TiComponent.iKeyUp         (var CharCode: Word; Shift: TShiftState); begin end;
procedure TiComponent.iKeyDown       (var CharCode: Word; Shift: TShiftState); begin end;
procedure TiComponent.iKeyPress      (var Key: Char);                          begin end;
//****************************************************************************************************************************************************
procedure TiComponent.iMouseUp    (Button: TMouseButton; Shift: TShiftState; X, Y: Integer         );         begin                 end;
procedure TiComponent.iMouseDown  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer         );         begin                 end;
procedure TiComponent.iMouseMove  (                      Shift: TShiftState; X, Y: Integer         );         begin                 end;
function  TiComponent.iMouseWheel (WheelDelta: Integer;  Shift: TShiftState; const MousePos: TPoint): Boolean;begin Result := False;end;
procedure TiComponent.iDoubleClick;                                                                           begin                 end;
//****************************************************************************************************************************************************
function TiComponent.GetBorderMargin: Integer;
begin
  if FBorderStyle <> ibsNone then Result := 2 else Result := 0;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SaveImageToBitmap(FileName: String);
var
  Bitmap : TBitmap;
begin
  HandleNeeded;
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width  := Width;
    Bitmap.Height := Height;
    iPaintTo(Bitmap.Canvas);

    {$IFDEF EVAL}
    with Bitmap.Canvas do
      begin
        Brush.Color := clBlack;
        Font.Color  := clYellow;
        Font.Style  := [fsBold];
        TextOut(0,0, 'Iocomp Evaluation');
      end;
    {$ENDIF}

    if not Licensed then
      begin
        with Bitmap.Canvas do
          begin
            Brush.Color := clBlack;
            Font.Color  := clYellow;
            Font.Style  := [fsBold];
            Font.Size   := 10;
            TextOut(0,0, 'Iocomp Evaluation');
          end;
      end;

    Bitmap.SaveToFile(FileName);
  finally
    Bitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetLoading(Value: Boolean);
begin
  FLoading := Value
end;
//****************************************************************************************************************************************************
procedure TiComponent.DoIsDesigning(Sender: TObject; var Designing: Boolean);
begin
  Designing := IsDesigning;
end;
//****************************************************************************************************************************************************
function TiComponent.GetIsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState);
  if Assigned(FOnGetDesigning) then FOnGetDesigning(Self, Result);
end;
//****************************************************************************************************************************************************
procedure TiComponent.SetCachedDrawing(const Value: Boolean);
begin
  if FCachedDrawing <> Value then
    begin
      FCachedDrawing := Value;
      BackGroundChange;
      if not FCachedDrawing then
        begin
          if Assigned(FBackGroundBitmap) then FBackGroundBitmap.Free;
          FBackGroundBitmap := nil;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.SavePropertiesToFile(FileName: String);
var
  AList      : TStringList;
  IgnoreList : TStringList;
begin
  try
  AList := TStringList.Create;
  try
    IgnoreList := TStringList.Create;
  try
    IgnoreList.Add('Name');
    if not FOptionSaveAllProperties then
      begin
        IgnoreList.Add('Left');
        IgnoreList.Add('Top');
        IgnoreList.Add('Width');
        IgnoreList.Add('Height');
        IgnoreList.Add('Align');
        IgnoreList.Add('Cursor');
        IgnoreList.Add('ShowHint');
        IgnoreList.Add('Tag');
        IgnoreList.Add('Visible');
        IgnoreList.Add('Enabled');
        IgnoreList.Add('Hint');
        IgnoreList.Add('HelpContext');
      end;

    AList.Add('File Type = ' + Self.ClassName);

    SaveObjectToStringList(Self, '', AList, IgnoreList);

    AList.SaveToFile(FileName);
  finally
    IgnoreList.Free;
  end;
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Saving Properties - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.LoadPropertiesFromFile(FileName: String);
var
  AList : TStringList;
begin
  try
  AList := TStringList.Create;
  try
    AList.LoadFromFile(FileName);
    BeginUpdate;
    LoadObjectFromStringList(Self, '', AList);
    EndUpdate;
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Loading Properties - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
function TiComponent.OPCOutputData(PropertyName: String; Value: OleVariant): Boolean;
begin
  Result := False;
end;
//****************************************************************************************************************************************************
function TiComponent.GetPropertyType(Instance: TPersistent; Path: String; PropertyName: String): TiTypeKind;
var
  i         : Integer;
  Count     : Integer;
  PropName  : String;
  PropInfo  : PPropInfo;                                                                     
  PropList  : PPropList;
  SubClass  : TObject;
  Found     : Boolean;
begin
  Result := TiTypeKind(tkUnknown);
  Count := GetTypeData(Instance.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      GetPropInfos(Instance.ClassInfo, PropList);
      for i := 0 to Count - 1 do
      begin
        PropInfo := PropList^[i];
        if PropInfo <> nil then
          begin
            if Assigned(PropInfo^.SetProc) then
              begin
                if Trim(Path) <> '' then PropName  := Path + '.' + PropInfo.Name
                  else PropName  := PropInfo.Name;

                Found := True;
                if PropInfo^.PropType^.Kind <> tkClass then Found := UpperCase(PropertyName) = UpperCase(PropName);

                if not Found then Continue;

                if PropInfo^.PropType^.Kind <> tkClass then
                  begin
                    Result := TiTypeKind(PropInfo^.PropType^.Kind);
                    Exit;
                  end;

                case PropInfo^.PropType^.Kind of
                  tkClass : begin
                              SubClass := GetObjectProperty(Instance, PropInfo.Name);
                              if SubClass is TPersistent then
                                GetPropertyType(SubClass as TPersistent, PropName, PropertyName);
                            end;
                end;
              end;
          end
        else Break;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiComponent.PropertyVarType(PropertyName: String; var AVarType: TiTypeKind);
begin
  AVarType := GetPropertyType(Self, '', PropertyName);
end;
//****************************************************************************************************************************************************
end.





