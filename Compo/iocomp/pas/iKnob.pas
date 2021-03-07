{*******************************************************}
{                                                       }
{       TiKnob Component                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iKnob;{$endif}
{$ifdef iCLX}unit QiKnob;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iScaleComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiScaleComponent;{$ENDIF}

type
  TiKnobStyle          = (iksRaisedEdge, iksRaised, iksSunken, iksSunkenEdge);
  TiKnobIndicatorStyle = (ikisDotLowered, ikisDotRaised, ikisDot, ikisLineCenter, ikisLineCustom, ikisTriangle);

  TiKnob = class(TiScaleComponent)
  private
    FMouseDownDegrees         : Double;
    FMouseDown                : Boolean;
    FKeyDown                  : Boolean;
    FLastWheelTime            : TDateTime;

    FIndicatorActiveColor     : TColor;
    FIndicatorInactiveColor   : TColor;
    FIndicatorMargin          : Integer;
    FIndicatorSize            : Integer;
    FIndicatorStyle           : TiKnobIndicatorStyle;
    FKeyPageStepSize          : Double;
    FKeyArrowStepSize         : Double;
    FMouseWheelStepSize       : Double;
    FKnobEdgeWidth            : Integer;
    FKnobRadius               : Integer;
    FKnobStyle                : TiKnobStyle;
    FPositionDisplayFont      : TFont;
    FPositionDisplayPrecision : Integer;
    FPositionDisplayUnits     : String;
    FRotationMaxDegrees       : Integer;
    FRotationStartDegrees     : Integer;
    FShowFocusRect            : Boolean;
    FShowPostionDisplay       : Boolean;
    FAutoSize                 : Boolean;
    FOuterMargin              : Integer;
    FUseKeyboard              : Boolean;
    FCenterPoint              : TPoint;

    procedure SetRotationStartDegrees    (const Value: Integer);
    procedure SetRotationMaxDegrees      (const Value: Integer);
    procedure SetKnobRadius              (const Value: Integer);
    procedure SetIndicatorMargin         (const Value: Integer);
    procedure SetIndicatorSize           (const Value: Integer);
    procedure SetShowPostionDisplay      (const Value: Boolean);
    procedure SetPositionDisplayFont     (const Value: TFont);
    procedure SetPositionDisplayPrecision(const Value: Integer);
    procedure SetIndicatorActiveColor    (const Value: TColor);
    procedure SetIndicatorInactiveColor  (const Value: TColor);
    procedure SetPositionDisplayUnits    (const Value: String);
    procedure SetPositionDegrees         (const Value: Double);
    procedure SetIndicatorStyle          (const Value: TiKnobIndicatorStyle);
    procedure SetKnobEdgeWidth           (const Value: Integer);
    procedure SetKnobStyle               (const Value: TiKnobStyle);
    procedure SetKeyArrowStepSize        (const Value: Double);
    procedure SetKeyPageStepSize         (const Value: Double);
    procedure SetMouseWheelStepSize      (const Value: Double);
    procedure SetShowFocusRect           (const Value: Boolean);
    procedure iSetAutoSize               (const Value: Boolean);
    procedure SetOuterMargin             (const Value: Integer);
    procedure SetUseKeyboard             (const Value: Boolean);

    function  GetPositionDegrees : Double;
    function  PositionToDegrees(Value: Double): Double;
  protected
    procedure iPaintTo(Canvas: TCanvas);                                           override;
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;
    property  PositionDegrees : Double read GetPositionDegrees  write SetPositionDegrees;
    procedure DrawKnob        (Canvas: TCanvas; const CenterPoint: TPoint);
    procedure DrawTicks       (Canvas: TCanvas; const CenterPoint: TPoint);
    procedure DrawPosition    (Canvas: TCanvas; const CenterPoint: TPoint);
    procedure DrawIndicator   (Canvas: TCanvas; const CenterPoint: TPoint);
    procedure AdjustKnobRadius(Canvas: TCanvas; const CenterPoint: TPoint);
    function GetXYRadPoint2(AngleDegrees, Radius: Double; OffsetX, OffsetY : Double) : TPoint;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint);             override;
    procedure iKeyUp         (var CharCode: Word; Shift: TShiftState);              override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);              override;

    procedure iDoKillFocus; override;

    {$ifdef iVCL}function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint      ): Boolean; override;{$endif}
    {$ifdef iCLX}function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; const MousePos: TPoint): Boolean; override;{$endif}

    procedure DoOPCPositionChangeFinished; override;

    procedure DefineProperties(Filer : TFiler); override;
    procedure WriteKeyArrowStepSize(Writer : TWriter);
    procedure ReadKeyArrowStepSize (Reader : TReader);
    procedure WriteKeyPageStepSize (Writer : TWriter);
    procedure ReadKeyPageStepSize  (Reader : TReader);
  public
    constructor Create(AOwner: TComponent);                                        override;
    destructor  Destroy;                                                           override;
  published
    property PositionDisplayFont      : TFont                read FPositionDisplayFont      write SetPositionDisplayFont;
    property PositionDisplayPrecision : Integer              read FPositionDisplayPrecision write SetPositionDisplayPrecision default 1;
    property PositionDisplayUnits     : String               read FPositionDisplayUnits     write SetPositionDisplayUnits;
    property IndicatorActiveColor     : TColor               read FIndicatorActiveColor     write SetIndicatorActiveColor     default clAqua;
    property IndicatorInactiveColor   : TColor               read FIndicatorInactiveColor   write SetIndicatorInactiveColor   default clRed;
    property IndicatorMargin          : Integer              read FIndicatorMargin          write SetIndicatorMargin          default 5;
    property IndicatorSize            : Integer              read FIndicatorSize            write SetIndicatorSize            default 4;
    property IndicatorStyle           : TiKnobIndicatorStyle read FIndicatorStyle           write SetIndicatorStyle           default ikisDotLowered;
    property KeyArrowStepSize         : Double               read FKeyArrowStepSize         write SetKeyArrowStepSize;
    property KeyPageStepSize          : Double               read FKeyPageStepSize          write SetKeyPageStepSize;
    property MouseWheelStepSize       : Double               read FMouseWheelStepSize       write SetMouseWheelStepSize;
    property KnobEdgeWidth            : Integer              read FKnobEdgeWidth            write SetKnobEdgeWidth            default 3;
    property KnobRadius               : Integer              read FKnobRadius               write SetKnobRadius               default 35;
    property KnobStyle                : TiKnobStyle          read FKnobStyle                write SetKnobStyle                default iksRaised;
    property RotationMaxDegrees       : Integer              read FRotationMaxDegrees       write SetRotationMaxDegrees       default 270;
    property RotationStartDegrees     : Integer              read FRotationStartDegrees     write SetRotationStartDegrees     default 225;
    property ShowFocusRect            : Boolean              read FShowFocusRect            write SetShowFocusRect            default True;
    property ShowPostionDisplay       : Boolean              read FShowPostiondisplay       write SetShowPostionDisplay       default False;
    property AutoSize                 : Boolean              read FAutoSize                 write iSetAutoSize                default True;
    property OuterMargin              : Integer              read FOuterMargin              write SetOuterMargin              default 2;
    property UseKeyboard              : Boolean              read FUseKeyboard              write SetUseKeyboard              default True;

    property ShowDisabledState                                                                                                default True;

    property BackGroundColor;
    property BackGroundPicture;
    property OffsetX;
    property OffsetY;
    property TabOrder;
    property TabStop              default True;
    property Transparent;

    property ShowTicksMajor;
    property ShowTicksMinor;
    property ShowTickLabels;
    property TickMajorCount;
    property TickMajorColor;
    property TickMajorLength;
    property TickMinorAlignment;
    property TickMinorCount;
    property TickMinorColor       default clGray;
    property TickMinorLength;
    property TickMargin;
    property TickLabelMargin      default 15;
    property TickLabelFont;
    property TickLabelPrecision;
    property PrecisionStyle;

    property AutoScaleEnabled;
    property AutoScaleDesiredTicks;
    property AutoScaleMaxTicks;
    property AutoScaleStyle;

    property OnPositionChangeFinished;
    property OnCustomizeTickLabel;
    property OnPositionChangeUser;
    property CachedDrawing;
    property Color;

    property Width   default 150;
    property Height  default 150;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiKnob.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width             := 150;
  Height            := 150;
  TabStop           := True;
  TickMinorColor    := clGray;
  TickLabelMargin   := 15;

  ShowDisabledState := True;

  FKnobRadius               := 35;
  FKnobStyle                := iksRaised;
  FAutoSize                 := True;
  FKnobEdgeWidth            := 3;

  FUseKeyboard              := True;
  FKeyArrowStepSize         := 0.1;
  FKeyPageStepSize          := 1;
  FMouseWheelStepSize       := 1;

  FIndicatorSize            := 4;
  FIndicatorMargin          := 5;
  FIndicatorActiveColor     := clAqua;
  FIndicatorInactiveColor   := clRed;

  FShowFocusRect            := True;

  FOuterMargin              := 2;

  FRotationStartDegrees     := 225;
  FRotationMaxDegrees       := 270;

  FPositionDisplayPrecision := 1;

  FPositionDisplayFont := TFont.Create; FPositionDisplayFont.OnChange := InvalidateChangeEvent;

  CreateBackGroundPicture;
end;
//****************************************************************************************************************************************************
destructor TiKnob.Destroy;
begin
  FPositionDisplayFont.Free;
  inherited
end;
//****************************************************************************************************************************************************
procedure TiKnob.SetKnobRadius            (const Value:Integer);begin SetIntegerProperty(Value,FKnobRadius,            irtBackGround);end;
procedure TiKnob.SetRotationStartDegrees  (const Value:Integer);begin SetIntegerProperty(Value,FRotationStartDegrees,  irtBackGround);end;
procedure TiKnob.SetRotationMaxDegrees    (const Value:Integer);begin SetIntegerProperty(Value,FRotationMaxDegrees,    irtBackGround);end;
procedure TiKnob.SetIndicatorMargin       (const Value:Integer);begin SetIntegerProperty(Value,FIndicatorMargin,       irtBackGround);end;
procedure TiKnob.SetIndicatorActiveColor  (const Value:TColor );begin SetColorProperty  (Value,FIndicatorActiveColor,  irtBackGround);end;
procedure TiKnob.SetIndicatorInactiveColor(const Value:TColor );begin SetColorProperty  (Value,FIndicatorInactiveColor,irtBackGround);end;
procedure TiKnob.SetShowPostionDisplay    (const Value:Boolean);begin SetBooleanProperty(Value,FShowPostionDisplay,    irtBackGround);end;
procedure TiKnob.SetKnobEdgeWidth         (const Value:Integer);begin SetIntegerProperty(Value,FKnobEdgeWidth,         irtBackGround);end;
procedure TiKnob.SetKeyArrowStepSize      (const Value:Double );begin SetDoubleProperty (Value,FKeyArrowStepSize,      irtInvalidate);end;
procedure TiKnob.SetKeyPageStepSize       (const Value:Double );begin SetDoubleProperty (Value,FKeyPageStepSize,       irtInvalidate);end;
procedure TiKnob.SetMouseWheelStepSize    (const Value:Double );begin SetDoubleProperty (Value,FMouseWheelStepSize,    irtInvalidate);end;
procedure TiKnob.SetShowFocusRect         (const Value:Boolean);begin SetBooleanProperty(Value,FShowFocusRect,         irtInvalidate);end;
procedure TiKnob.iSetAutoSize             (const Value:Boolean);begin SetBooleanProperty(Value,FAutoSize,              irtBackGround);end;
procedure TiKnob.SetOuterMargin           (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin,           irtBackGround);end;
procedure TiKnob.SetUseKeyboard           (const Value:Boolean);begin SetBooleanProperty(Value,FUseKeyboard,           irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiKnob.SetPositionDisplayFont(const Value:TFont);begin FPositionDisplayFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiKnob.SetKnobStyle(const Value: TiKnobStyle);
begin
  if FKnobStyle <> Value then
    begin
      FKnobStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.SetIndicatorStyle(const Value: TiKnobIndicatorStyle);
begin
  if FIndicatorStyle <> Value then
    begin
      FIndicatorStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.SetPositionDegrees(const Value: Double);
begin
  Position := Value * (PositionMax - PositionMin)/FRotationMaxDegrees + PositionMin;
end;
//****************************************************************************************************************************************************
procedure TiKnob.SetPositionDisplayPrecision(const Value: Integer);
begin
  if FPositionDisplayPrecision <> Value then
    begin
      FPositionDisplayPrecision := Value;
      if FPositionDisplayPrecision < 0 then FPositionDisplayPrecision := 0;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.SetIndicatorSize(const Value: Integer);
begin
  if FIndicatorSize <> Value then
    begin
      FIndicatorSize := Value;
      if FIndicatorSize < 1 then FIndicatorSize := 1;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.SetPositionDisplayUnits(const Value: String);
begin
  if FPositionDisplayUnits <> Value then
    begin
      FPositionDisplayUnits := Value;
      if Trim(FPositionDisplayUnits) = '' then FPositionDisplayUnits := '';
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  X1, Y1      : Integer;
begin
  if (Button = mbLeft) and Enabled then
    begin
      PositionDirty := False;
      SetFocus;
      X1 := x - FCenterPoint.x;
      Y1 := y - FCenterPoint.y;
      if Round(Sqrt(X1*X1 + Y1*Y1)) < FKnobRadius then
        begin
          FMouseDown := True;
          FMouseDownDegrees := RadToDeg(ArcTan2(Y-FCenterPoint.Y,X-FCenterPoint.x));
          BackGroundChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  CurrentDegrees : Double;
  DeltaAngle     : Double;
begin
  if FMouseDown then
    begin
      CurrentDegrees  := RadToDeg(ArcTan2(Y-FCenterPoint.y,X-FCenterPoint.x));

      DeltaAngle      := FMouseDownDegrees - CurrentDegrees;
      if DeltaAngle >  200 then DeltaAngle := DeltaAngle - 360;
      if DeltaAngle < -200 then DeltaAngle := DeltaAngle + 360;

      UserGenerated := True;
      try
        PositionDegrees := PositionDegrees - DeltaAngle;
      finally
        UserGenerated := False;
      end;

      FMouseDownDegrees := CurrentDegrees;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  BackGroundChange;
  if FMouseDown then
    begin
      FMouseDown := False;
      DoPositionChangeFinished;
    end;
end;
//****************************************************************************************************************************************************
function TiKnob.GetPositionDegrees : Double;
begin
  if PositionMax = PositionMin then Result := FRotationStartDegrees
    else Result := FRotationMaxDegrees * ValuePercent(Position);
end;
//****************************************************************************************************************************************************
function TiKnob.PositionToDegrees(Value: Double): Double;
begin
  Result := FRotationStartDegrees - FRotationMaxDegrees * ValuePercent(Value);
end;
//****************************************************************************************************************************************************
procedure TiKnob.AdjustKnobRadius(Canvas: TCanvas; const CenterPoint: TPoint);
var
  KnobDiameter : Integer;
  x            : Integer;
  TickValue    : Double;
  TextPoint    : TPoint;
  TextString   : String;

  ATextWidth   : Integer;
  ATextHeight  : Integer;
  MaxWidth     : Integer;
  MaxHeight    : Integer;
begin
  with Canvas do
    begin
      Font.Assign(TickLabelFont);
      if Width < Height then KnobDiameter := Width  - 2*FOuterMargin
        else                 KnobDiameter := Height - 2*FOuterMargin;

      MaxWidth  := 0;
      MaxHeight := 0;

      if ShowTickLabels then
        begin
          for x := 0 to TickMajorCount - 1 do
            begin
              TickValue  := (PositionMax - PositionMin)/(TickMajorCount-1) * x + PositionMin;
              TextPoint  := GetXYRadPoint(PositionToDegrees(TickValue), 1, Point(0,0));

              TextString  := Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [TickValue]));
              ATextWidth  := ABS(TextWidth (TextString) * TextPoint.x);
              ATextHeight := ABS(TextHeight(TextString) * TextPoint.y);

              if ATextWidth  > MaxWidth  then MaxWidth  := ATextWidth;
              if ATextHeight > MaxHeight then MaxHeight := ATextHeight;
            end;

          if MaxWidth > MaxHeight then KnobDiameter := KnobDiameter - MaxWidth
            else                       KnobDiameter := KnobDiameter - MaxHeight;

          KnobDiameter := KnobDiameter - 2*(TickMargin + TickMajorLength + TickLabelMargin + 4);

        end
      else if ShowTicksMajor or ShowTicksMinor then
        begin
          KnobDiameter := KnobDiameter - 2*(TickMargin + TickMajorLength);
        end;
      FKnobRadius := KnobDiameter div 2;
  end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.iPaintTo(Canvas: TCanvas);
begin
  FCenterPoint := GetCenterPoint(Canvas);
  if CachedDrawing then
    begin
      if BackGroundChanged then
        begin
          CreateBackGroundBitmap;
          if FAutoSize then AdjustKnobRadius(BackGroundBitmap.Canvas, FCenterPoint);
          DrawBackGround(BackGroundBitmap.Canvas, BackGroundColor);
          DrawKnob      (BackGroundBitmap.Canvas, FCenterPoint);
          DrawTicks     (BackGroundBitmap.Canvas, FCenterPoint);
          ResetBackGroundChange;
        end;

      TransferBackGround(Canvas);
    end
  else
    begin
      if FAutoSize then AdjustKnobRadius(Canvas, FCenterPoint);
      DrawBackGround(Canvas, BackGroundColor);
      DrawKnob      (Canvas, FCenterPoint);
      DrawTicks     (Canvas, FCenterPoint);
    end;

  DrawPosition (Canvas, FCenterPoint);
  DrawIndicator(Canvas, FCenterPoint);

  if FShowFocusRect and HasFocus then iDrawFocusRect(Canvas, ClientRect, BackGroundColor);
end;
//****************************************************************************************************************************************************
procedure TiKnob.DrawKnob(Canvas: TCanvas; const CenterPoint: TPoint);
var
  OuterRect     : TRect;
  InnerRect     : TRect;
  AColor        : TColor;
begin
  if FMouseDown or FKeyDown then AColor := ColorMouseDownBright(Color)
  else                           AColor := Color;

  with Canvas do
    begin
      OuterRect   := Rect(CenterPoint.x - (FKnobRadius),
                          CenterPoint.y - (FKnobRadius),
                          CenterPoint.x + (FKnobRadius),
                          CenterPoint.y + (FKnobRadius));

      InnerRect   := Rect(CenterPoint.x - (FKnobRadius - FKnobEdgeWidth),
                          CenterPoint.y - (FKnobRadius - FKnobEdgeWidth),
                          CenterPoint.x + (FKnobRadius - FKnobEdgeWidth),
                          CenterPoint.y + (FKnobRadius - FKnobEdgeWidth));

      case FKnobStyle of
        iksRaisedEdge : DrawGradientCircleRaised(Canvas, AColor, CenterPoint, FKnobRadius);
        iksRaised     : DrawGradientCircleRaised(Canvas, AColor, CenterPoint, FKnobRadius);
        iksSunken     : DrawGradientCircleSunken(Canvas, AColor, CenterPoint, FKnobRadius);
        iksSunkenEdge : DrawGradientCircleSunken(Canvas, AColor, CenterPoint, FKnobRadius);
      end;

      if (FKnobStyle = iksRaisedEdge) or (FKnobStyle = ikssunkenEdge) then
        begin
          Brush.Style := bsSolid;
          Brush.Color := AColor;
          Pen.Color   := AColor;
          Ellipse(InnerRect.Left, InnerRect.Top, InnerRect.Right, InnerRect.Bottom);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.DrawIndicator(Canvas: TCanvas; const CenterPoint: TPoint);
var
  InnerPoint           : TPoint;
  OuterPoint           : TPoint;
  IndicatorCenterPoint : Tpoint;
  IndicatorRect        : TRect;
  IndicatorDegrees     : Double;
  PointerEndPoint      : TPoint;
  PointerBasePoint     : TPoint;
  Point1               : TPoint;
  Point2               : Tpoint;
begin
  IndicatorDegrees := RotationStartDegrees - PositionDegrees;

  with Canvas, IndicatorRect do
    begin
      Brush.Style := bsSolid;
      IndicatorCenterPoint := GetXYRadPoint(IndicatorDegrees, FKnobRadius - FIndicatorMargin - FIndicatorSize, CenterPoint);

      IndicatorRect := Rect(IndicatorCenterPoint.x - FIndicatorSize,
                            IndicatorCenterPoint.y - FIndicatorSize,
                            IndicatorCenterPoint.x + FIndicatorSize,
                            IndicatorCenterPoint.y + FIndicatorSize);

      if FMouseDown or FKeyDown then begin Pen.Color := FIndicatorActiveColor;   Brush.Color := FIndicatorActiveColor    end
      else                           begin Pen.Color := FIndicatorInactiveColor; Brush.Color := FIndicatorInactiveColor; end;

      case FIndicatorStyle of
        ikisDotLowered : begin
                           Ellipse(Left, Top, Right, Bottom);
                           Pen.Color := clGray;  Arc(Left, Top, Right, Bottom, Right, Top   , Left , Bottom);
                           Pen.Color := clWhite; Arc(Left, Top, Right, Bottom, Left , Bottom, Right, Top   );
                         end;
        ikisDotRaised  : begin
                           Ellipse(Left, Top, Right, Bottom);
                           Pen.Color := clWhite; Arc(Left, Top, Right, Bottom, Right, Top   , Left , Bottom);
                           Pen.Color := clGray;  Arc(Left, Top, Right, Bottom, Left , Bottom, Right, Top   );
                         end;
        ikisDot        : begin
                           Ellipse(Left, Top, Right, Bottom);
                         end;
        ikisLineCenter : begin
                           OuterPoint:=GetXYRadPoint(IndicatorDegrees,FKnobRadius-FIndicatorMargin,CenterPoint);
                           PolyLine([OuterPoint, CenterPoint]);
                         end;
        ikisLineCustom : begin
                           OuterPoint:=GetXYRadPoint(IndicatorDegrees,FKnobRadius-FIndicatorMargin,               CenterPoint);
                           InnerPoint:=GetXYRadPoint(IndicatorDegrees,FKnobRadius-FIndicatorMargin-FIndicatorSize,CenterPoint);
                           PolyLine([OuterPoint, InnerPoint]);
                         end;
        ikisTriangle   : begin
                           PointerEndPoint :=GetXYRadPoint(IndicatorDegrees,FKnobRadius-FIndicatorMargin,               CenterPoint);
                           PointerBasePoint:=GetXYRadPoint(IndicatorDegrees,FKnobRadius-FIndicatorMargin-FIndicatorSize,CenterPoint);
                           Point1 := GetXYRadPoint(IndicatorDegrees + 90, FIndicatorSize/2, PointerBasePoint);
                           Point2 := GetXYRadPoint(IndicatorDegrees - 90, FIndicatorSize/2, PointerBasePoint);
                           Polygon([Point1, Point2, PointerEndPoint]);
                         end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.DrawTicks(Canvas: TCanvas; const CenterPoint: TPoint);
var
  OuterPoint      : TPoint;
  InnerPoint      : TPoint;
  MajorRadius1    : Double;
  MajorRadius2    : Double;
  MinorRadius1    : Double;
  MinorRadius2    : Double;
  TextRadius      : Double;
  TextPoint       : TPoint;
  ATextRect       : TRect;
  TickValue       : Double;
  TextString      : String;
  x, y            : Integer;
  CurrentMin      : Double;
  CurrentMax      : Double;
  CurrentPosition : Double;
  MajorStepSize   : Double;
  MinorStepSize   : Double;
begin
  with Canvas do
    begin
      Brush.Style := bsClear;

      MajorRadius1 := FKnobRadius + TickMargin - 1;
      MajorRadius2 := FKnobRadius + TickMargin + TickMajorLength;

      case TickMinorAlignment of
        itmnaInside  : begin
                         MinorRadius1 := MajorRadius1;
                         MinorRadius2 := MajorRadius1 + TickMinorLength;
                       end;
        itmnaCenter  : begin
                         MinorRadius1 := (MajorRadius1 + MajorRadius2)/2 - TickMinorLength/2;
                         MinorRadius2 := (MajorRadius1 + MajorRadius2)/2 + TickMinorLength/2;
                       end;
        itmnaOutside : begin
                         MinorRadius1 := MajorRadius2;
                         MinorRadius2 := MajorRadius2 - TickMinorLength;
                       end;
        else           begin
                         MinorRadius1 := 0;
                         MinorRadius2 := 0;
                       end;
      end;

      if not ShowTicksMajor then MajorRadius1 := FKnobRadius;

      if AutoScaleEnabled and (AutoScaleStyle = iassFixedMinMax) then
        begin
          CurrentMin := FAutoScaleMinTick;
          CurrentMax := FAutoScaleMaxTick;
        end
      else
        begin
          CurrentMin := PositionMin;
          CurrentMax := PositionMax;
        end;

      MajorStepSize := (CurrentMax-CurrentMin)/(TickMajorCount - 1);
      MinorStepSize := MajorStepSize /(TickMinorCount + 1);

      for x := 0 to TickMajorCount - 1 do
        begin
          CurrentPosition := CurrentMin + MajorStepSize * x;
          //------------------------------------------------------------------------------------------------------------------------------------------
          if ShowTicksMajor then
            begin
              if Enabled or not ShowDisabledState then Pen.Color := TickMajorColor
              else                                     Pen.Color := clBtnShadow;
              OuterPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MajorRadius1, CenterPoint);
              InnerPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MajorRadius2, CenterPoint);
              Polyline([InnerPoint, OuterPoint]);
            end;
          //------------------------------------------------------------------------------------------------------------------------------------------
          if ShowTickLabels then
            begin
              TickValue := (CurrentMax - CurrentMin) /(TickMajorCount-1) * x + CurrentMin;

              TextString  := Trim(SysUtils.Format('%.' + IntToStr(GetDecimalPoints) + 'f', [TickValue]));

              if Assigned(OnCustomizeTickLabel) then TOnCustomizeTickLabel(OnCustomizeTickLabel)(Self, x, TextString);

              Font.Assign(TickLabelFont);

              TextRadius  := MajorRadius2 + TickLabelMargin + 4;
              TextPoint   := GetXYRadPoint(PositionToDegrees(CurrentPosition), TextRadius, CenterPoint);

              ATextRect   := GetCenterPointRect(TextPoint.X, TextPoint.Y, TextWidth(TextString), TextHeight(TextString));

              if ShowDisabledState then iDrawText(Canvas, TextString, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], Enabled, BackGroundColor)
              else                      iDrawText(Canvas, TextString, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], True,    BackGroundColor);
            end;
          //------------------------------------------------------------------------------------------------------------------------------------------
          if ShowTicksMinor and (x < TickMajorCount - 1) then
            begin
              if Enabled or not ShowDisabledState then Pen.Color := TickMinorColor
              else                                     Pen.Color := clBtnShadow;
              for y := 1 to TickMinorCount do
                begin
                  CurrentPosition := CurrentMin + MajorStepSize*x + MinorStepSize*y;
                  OuterPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MinorRadius1, CenterPoint);
                  InnerPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MinorRadius2, CenterPoint);
                  Polyline([InnerPoint, OuterPoint]);
                end;
            end;
        end;
          //------------------------------------------------------------------------------------------------------------------------------------------
      if (AutoScaleStyle = iassFixedMinMax) and ShowTicksMinor and (MinorStepSize <> 0) then
        begin
          CurrentPosition := FAutoScaleMaxTick + MinorStepSize;
          while CurrentPosition <= PositionMax do
            begin
              OuterPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MinorRadius1, CenterPoint);
              InnerPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MinorRadius2, CenterPoint);
              Polyline([InnerPoint, OuterPoint]);

              CurrentPosition := CurrentPosition + MinorStepSize;
            end;

          CurrentPosition := FAutoScaleMinTick - MinorStepSize;
          while CurrentPosition >= PositionMin do
            begin
              OuterPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MinorRadius1, CenterPoint);
              InnerPoint := GetXYRadPoint(PositionToDegrees(CurrentPosition), MinorRadius2, CenterPoint);
              Polyline([InnerPoint, OuterPoint]);

              CurrentPosition := CurrentPosition - MinorStepSize;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.DrawPosition(Canvas: TCanvas; const CenterPoint: TPoint);
var
  TextString  : String;
  x, y        : Integer;
begin
  with Canvas do
    begin
        if FShowPostionDisplay then
          begin
            Brush.Style := bsClear;
            Font.Assign(FPositionDisplayFont);
            TextString := Trim(Format('%4.' + IntToStr(FPositionDisplayPrecision) + 'f',[Position])) + FPositionDisplayUnits;

            y := CenterPoint.y - TextHeight(TextString) div 2;

            x := CenterPoint.x - TextWidth(TextString) div 2;

            TextOut(x, y, TextString);
          end;
  end;
end;
//****************************************************************************************************************************************************
function TiKnob.GetXYRadPoint2(AngleDegrees, Radius: Double; OffsetX, OffsetY : Double) : TPoint;
begin
  Result := Point(Trunc(OffsetX + Cos(DegToRad(AngleDegrees))*Radius),Trunc(OffsetY - Sin(DegToRad(AngleDegrees))*Radius));
end;                               
//****************************************************************************************************************************************************
procedure TiKnob.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  inherited iWantSpecialKey(CharCode, Result);
  if FUseKeyboard then
    begin
      if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1 else Result := 0;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  inherited;
  BackGroundChange;
  if FKeyDown then
    begin
      FKeyDown := False;
      if PositionDirty then DoPositionChangeFinished;
    end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  if FUseKeyboard then
    begin
      FKeyDown      := True;
      UserGenerated := True;
      try
        //KYLIX TODO
        {$ifndef iCLX}
        if      (CharCode = VK_LEFT) or (CharCode = VK_DOWN) then
          begin
            Position := Position - FKeyArrowStepSize;
            CharCode := 0;
          end
        else if (CharCode = VK_RIGHT) or (CharCode = VK_UP) then
          begin
            Position := Position + FKeyArrowStepSize;
            CharCode := 0;
          end
        else if (CharCode = VK_PRIOR) then //PageUp
          begin
            Position := Position + FKeyPageStepSize;
            CharCode := 0;
          end
        else if (CharCode = VK_NEXT) then //PageDown
          begin
            Position := Position - FKeyPageStepSize;
            CharCode := 0;
          end
        else if (CharCode = VK_HOME) then
          begin
            Position := PositionMin;
            CharCode := 0;
          end
        else if (CharCode = VK_END) then
          begin
            Position := PositionMax;
            CharCode := 0;
          end;
        {$endif}
      finally
        UserGenerated := False;
      end;
  end;

  BackGroundChange;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiKnob.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('KeyArrowStepSize_2', ReadKeyArrowStepSize, WriteKeyArrowStepSize, True);
  Filer.DefineProperty('KeyPageStepSize_2',  ReadKeyPageStepSize, WriteKeyPageStepSize, True);
end;
//****************************************************************************************************************************************************
procedure TiKnob.ReadKeyArrowStepSize(Reader: TReader);
begin
  FKeyArrowStepSize := Reader.ReadFloat;
end;
//****************************************************************************************************************************************************
procedure TiKnob.ReadKeyPageStepSize(Reader: TReader);
begin
  FKeyPageStepSize := Reader.ReadFloat;
end;
//****************************************************************************************************************************************************
procedure TiKnob.WriteKeyArrowStepSize(Writer: TWriter);
begin
  Writer.WriteFloat(FKeyArrowStepSize);
end;
//****************************************************************************************************************************************************
procedure TiKnob.WriteKeyPageStepSize(Writer: TWriter);
begin
  Writer.WriteFloat(FKeyPageStepSize);
end;
//****************************************************************************************************************************************************
procedure TiKnob.DoOPCPositionChangeFinished;
begin
  OPCOutputData('Position', Position);
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}function TiKnob.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint      ): Boolean;{$endif}
{$ifdef iCLX}function TiKnob.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; const MousePos: TPoint): Boolean;{$endif}
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);

  if (Now -FLastWheelTime)*24*60*60*1000 < 30 then Exit;
  FLastWheelTime := Now;

  UserGenerated := True;
  try
    Position := Position + WheelDelta/ABS(WheelDelta) * FMouseWheelStepSize;
    DoPositionChangeFinished;
  finally
    UserGenerated := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiKnob.iDoKillFocus;
begin
  inherited;
  FMouseDown := False;
  FKeyDown   := False;
end;
//****************************************************************************************************************************************************
end.
