{*******************************************************}
{                                                       }
{       TiSwitchRotary Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchRotary;{$endif}
{$ifdef iCLX}unit QiSwitchRotary;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iSwitchMultiPosition;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiSwitchMultiPosition;{$ENDIF}

type
  TiRotaryStartDegrees       = (irsd000, irsd045, irsd090, irsd135, irsd180, irsd225, irsd270, irsd315);
  TiSwitchRotaryPointerStyle = (isrpsPointer, isrpsRectangle);
  TiRotaryDesiredSpacing     = (irds22p5, irds45, irds90);

  TiSwitchRotary = class(TiSwitchMultiPosition)
  private
    FMouseDownDegrees       : Double;
    FCenterPoint            : TPoint;
    FDegreesStep            : Double;

    FPointerLength          : Integer;
    FPointerHeight          : Integer;
    FPositionLabelAlignment : TiLabelAlignment;
    FPointerStyle           : TiSwitchRotaryPointerStyle;
    FRotationStartDegrees   : TiRotaryStartDegrees;
    FMouseControlStyle      : TiRotaryMouseControlStyle;
    FPointerColor           : TColor;
    FPointerHighLightColor  : TColor;
    FRotationDesiredSpacing : TiRotaryDesiredSpacing;

    FShowFace               : Boolean;
    FFaceColor              : TColor;
    FFaceStyle              : TiDrawEdgeStyle;
    FFaceBevelSize          : Integer;
    FFaceBevelStyle         : TiDrawEdgeStyle;
    FOuterMargin            : Integer;

    FShowPointerFace        : Boolean;
    FPointerFaceColor       : TColor;
    FPointerFaceBevelSize   : Integer;
    FPointerFaceBevelStyle  : TiDrawEdgeStyle;

    function  AngleOffset : Integer;

    procedure SetPointerLength         (const Value: Integer);
    procedure SetPointerHeight         (const Value: Integer);
    procedure SetPositionLabelAlignment(const Value: TiLabelAlignment);
    procedure SetPointerStyle          (const Value: TiSwitchRotaryPointerStyle);
    procedure SetRotationStartDegrees  (const Value: TiRotaryStartDegrees);
    procedure SetMouseControlStyle     (const Value: TiRotaryMouseControlStyle);
    procedure SetPointerColor          (const Value: TColor);
    procedure SetPointerHighLightColor (const Value: TColor);
    procedure SetRotationDesiredSpacing(const Value: TiRotaryDesiredSpacing);
    procedure SetShowFace              (const Value: Boolean);
    procedure SetFaceColor             (const Value: TColor);
    procedure SetFaceStyle             (const Value: TiDrawEdgeStyle);
    procedure SetFaceBevelSize         (const Value: Integer);
    procedure SetFaceBevelStyle        (const Value: TiDrawEdgeStyle);
    procedure SetOuterMargin           (const Value: Integer);
    procedure SetShowPointerFace       (const Value: Boolean);
    procedure SetPointerFaceColor      (const Value: TColor);
    procedure SetPointerFaceBevelSize  (const Value: Integer);
    procedure SetPointerFaceBevelStyle (const Value: TiDrawEdgeStyle);
  protected
    procedure SetPositionFromMouse(X, Y : Integer);
    function  GetCenterPoint(Canvas: TCanvas): TPoint;                             override;
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;
    procedure iDoKillFocus;                                                        override;
    procedure iPaintTo(Canvas: TCanvas);                                           override;
    procedure DrawIndicator         (Canvas: TCanvas; CenterPoint: TPoint; Angle: Double);
    procedure DrawIndicatorPointer  (Canvas: TCanvas; CenterPoint: TPoint; Angle: Double);
    procedure DrawIndicatorRectangle(Canvas: TCanvas; CenterPoint: TPoint; Angle: Double);
    procedure DrawTicks             (Canvas: TCanvas; CenterPoint: TPoint; AngleOffset: Double);
    procedure DrawFace              (Canvas: TCanvas; const OffsetPoint: TPoint);
    procedure DrawPointerFace       (Canvas: TCanvas; const OffsetPoint: TPoint);
  public
    constructor Create(AOwner: TComponent);  override;
  published
    property PositionLabelAlignment : TiLabelAlignment           read FPositionLabelAlignment write SetPositionLabelAlignment default ilaCenter;
    property RotationStartDegrees   : TiRotaryStartDegrees       read FRotationStartDegrees   write SetRotationStartDegrees   default irsd180;
    property RotationDesiredSpacing : TiRotaryDesiredSpacing     read FRotationDesiredSpacing write SetRotationDesiredSpacing default irds45;
    property PointerLength          : Integer                    read FPointerLength          write SetPointerLength          default 25;
    property PointerHeight          : Integer                    read FPointerHeight          write SetPointerHeight          default 6;
    property PointerStyle           : TiSwitchRotaryPointerStyle read FPointerStyle           write SetPointerStyle           default isrpsPointer;
    property PointerColor           : TColor                     read FPointerColor           write SetPointerColor           default clBtnFace;
    property PointerHighLightColor  : TColor                     read FPointerHighLightColor  write SetPointerHighLightColor  default clBtnHighlight;
    property MouseControlStyle      : TiRotaryMouseControlStyle  read FMouseControlStyle      write SetMouseControlStyle      default irmcsGoto;

    property ShowFace               : Boolean                    read FShowFace               write SetShowFace               default False;
    property FaceColor              : TColor                     read FFaceColor              write SetFaceColor              default clWhite;
    property FaceStyle              : TiDrawEdgeStyle            read FFaceStyle              write SetFaceStyle              default idesFlat;
    property FaceBevelSize          : Integer                    read FFaceBevelSize          write SetFaceBevelSize          default 5;
    property FaceBevelStyle         : TiDrawEdgeStyle            read FFaceBevelStyle         write SetFaceBevelStyle         default idesSunken;
    property OuterMargin            : Integer                    read FOuterMargin            write SetOuterMargin            default 5;

    property ShowPointerFace        : Boolean                    read FShowPointerFace        write SetShowPointerFace        default False;
    property PointerFaceColor       : TColor                     read FPointerFaceColor       write SetPointerFaceColor       default clWhite;
    property PointerFaceBevelSize   : Integer                    read FPointerFaceBevelSize   write SetPointerFaceBevelSize   default 5;
    property PointerFaceBevelStyle  : TiDrawEdgeStyle            read FPointerFaceBevelStyle  write SetPointerFaceBevelStyle  default idesSunken;

    property ShowDisabledState                                                                                                default True;

    property BackGroundPicture;
    property BackGroundColor;
    property OffsetX;
    property OffsetY;
    property Transparent;
    property PositionLabelMargin default 15;
    property Width               default 100;
    property Height              default 80;
  end;

implementation
//*************************************************************************************************************************************
constructor TiSwitchRotary.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 100;
  Height  := 80;

  ShowDisabledState := True;

  FMaximumLabels          := 16;
  FDegreesStep            := 45;

  FPointerLength          := 25;
  FPointerHeight          := 6;
  FPointerColor           := clBtnFace;
  FPointerHighLightColor  := clBtnHighlight;
  FMaxPositionCount       := 8;
  FRotationStartDegrees   := irsd180;
  FRotationDesiredSpacing := irds45;

  FShowFace               := False;
  FFaceColor              := clWhite;
  FFaceStyle              := idesFlat;
  FFaceBevelSize          := 5;
  FFaceBevelStyle         := idesSunken;

  FOuterMargin            := 5;

  FShowPointerFace       := False;
  FPointerFaceColor      := clWhite;
  FPointerFaceBevelSize  := 5;
  FPointerFaceBevelStyle := idesSunken;

  PositionLabelMargin     := 15;

  MouseControlStyle       := irmcsGoto;

  CreateBackGroundPicture;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.SetPositionLabelAlignment(const Value:TiLabelAlignment);          begin if FPositionLabelAlignment<>Value then begin FPositionLabelAlignment:=Value;BackGroundChange;end;end;
procedure TiSwitchRotary.SetPointerStyle          (const Value:TiSwitchRotaryPointerStyle);begin if FPointerStyle          <>Value then begin FPointerStyle          :=Value;BackGroundChange;end;end;
procedure TiSwitchRotary.SetRotationStartDegrees  (const Value:TiRotaryStartDegrees);      begin if FRotationStartDegrees  <>Value then begin FRotationStartDegrees  :=Value;BackGroundChange;end;end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.SetPointerColor          (const Value: TColor);begin SetColorProperty  (Value, FPointerColor,          irtBackGround);end;
procedure TiSwitchRotary.SetPointerHighLightColor (const Value: TColor);begin SetColorProperty  (Value, FPointerHighLightColor, irtBackGround);end;
procedure TiSwitchRotary.SetFaceColor             (const Value:TColor );begin SetColorProperty  (Value,FFaceColor,              irtBackGround);end;
procedure TiSwitchRotary.SetFaceBevelSize         (const Value:Integer);begin SetIntegerProperty(Value,FFaceBevelSize,          irtBackGround);end;
procedure TiSwitchRotary.SetShowFace              (const Value:Boolean);begin SetBooleanProperty(Value,FShowFace,               irtBackGround);end;
procedure TiSwitchRotary.SetOuterMargin           (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin,            irtBackGround);end;
procedure TiSwitchRotary.SetPointerFaceColor      (const Value:TColor );begin SetColorProperty  (Value,FPointerFaceColor,       irtBackGround);end;
procedure TiSwitchRotary.SetPointerFaceBevelSize  (const Value:Integer);begin SetIntegerProperty(Value,FPointerFaceBevelSize,   irtBackGround);end;
procedure TiSwitchRotary.SetShowPointerFace       (const Value:Boolean);begin SetBooleanProperty(Value,FShowPointerFace,        irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiSwitchRotary.SetFaceStyle(const Value: TiDrawEdgeStyle);
begin
  if FFaceStyle <> Value then
    begin
      FFaceStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchRotary.SetFaceBevelStyle(const Value: TiDrawEdgeStyle);
begin
  if FFaceBevelStyle <> Value then
    begin
      FFaceBevelStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchRotary.SetPointerFaceBevelStyle(const Value: TiDrawEdgeStyle);
begin
  if FPointerFaceBevelStyle <> Value then
    begin
      FPointerFaceBevelStyle := Value;
      BackGroundChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.SetPointerLength(const Value:Integer);
begin
  if FPointerLength <> Value then
    begin
      FPointerLength := Value;
      if FPointerHeight > FPointerLength then FPointerLength := FPointerHeight;
      BackGroundChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.SetPointerHeight(const Value:Integer);
begin
  if FPointerHeight <> Value then
    begin
      FPointerHeight := Value;
      if FPointerHeight > FPointerLength then FPointerLength := FPointerHeight;
      BackGroundChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.SetMouseControlStyle(const Value: TiRotaryMouseControlStyle);
begin
  if FMouseControlStyle <> Value then
    begin
      FMouseControlStyle := Value;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.SetRotationDesiredSpacing(const Value: TiRotaryDesiredSpacing);
begin
  if FRotationDesiredSpacing <> Value then
    begin
      FRotationDesiredSpacing := Value;
      BackGroundChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.SetPositionFromMouse(X, Y: Integer);
var
  Degrees     : Double;
  NewPosition : Integer;
begin
  Degrees := RadToDeg(ArcTan2(Y-FCenterPoint.Y,X-FCenterPoint.x));
  if Degrees < 0 then Degrees := Degrees + 360;
  Degrees := Degrees + AngleOffset + FDegreesStep/2;
  if Degrees >= 360 then Degrees := Degrees - 360;
  if Degrees > (PositionLabelCount*FDegreesStep + FDegreesStep/2) then exit;
  NewPosition := Trunc(Degrees/FDegreesStep);
  if NewPosition > PositionLabelCount then NewPosition := NewPosition - 8;
  Position := NewPosition;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      SetFocus;
      UserGenerated := True;
      try
        case FMouseControlStyle of
          irmcsRotate : begin
                          FMouseDown        := True;
                          FMouseDownDegrees := RadToDeg(ArcTan2(Y-FCenterPoint.Y,X-FCenterPoint.x));
                          InvalidateChange;
                        end;
          irmcsGoto   : begin
                          FMouseDown        := True;
                          SetPositionFromMouse(X, Y);
                          InvalidateChange;
                        end;
        end;
      finally
        UserGenerated := False;
      end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  CurrentDegrees : Double;
  DeltaAngle     : Double;
begin
  if FMouseDown then
    begin
      UserGenerated := True;
      try
        case FMouseControlStyle of
          irmcsRotate : begin
                          CurrentDegrees  := RadToDeg(ArcTan2(Y-FCenterPoint.y,X-FCenterPoint.x));

                          DeltaAngle      := FMouseDownDegrees - CurrentDegrees;
                          if DeltaAngle >  200 then DeltaAngle := DeltaAngle - 360;
                          if DeltaAngle < -200 then DeltaAngle := DeltaAngle + 360;

                          if DeltaAngle > (FDegreesStep/2) then
                            begin
                              Position          := Position - 1;
                              FMouseDownDegrees := CurrentDegrees  - FDegreesStep;
                            end
                          else if DeltaAngle < -FDegreesStep/2 then
                            begin
                              Position          := Position + 1;
                              FMouseDownDegrees := CurrentDegrees + FDegreesStep;
                            end;
                        end;
          irmcsGoto   : SetPositionFromMouse(X, Y);
        end;
      finally
        UserGenerated := False;
      end;
   end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  InvalidateChange;
  if FMouseDown  then
    begin
      FMouseDown := False;
      DoPositionChangeFinished;
    end;
end;
//*************************************************************************************************************************************
function TiSwitchRotary.AngleOffset: Integer;
begin
  case FRotationStartDegrees of
    irsd000 : Result :=   0;
    irsd045 : Result :=  45;
    irsd090 : Result :=  90;
    irsd135 : Result := 135;
    irsd180 : Result := 180;
    irsd225 : Result := 225;
    irsd270 : Result := 270;
    irsd315 : Result := 315;
    else      Result := 0;
  end;
end;
//*************************************************************************************************************************************
function TiSwitchRotary.GetCenterPoint(Canvas: TCanvas): TPoint;
var
  ClientRect     : TRect;
  CenterPoint    : TPoint;
  TempPoint      : TPoint;
  MinX, MaxX     : Double;
  MinY, MaxY     : Double;
  MaxRadius      : Integer;
  x              : Integer;
  MaxLabelHeight : Integer;
begin
  Result := inherited GetCenterPoint(Canvas);
  FCenterPoint := Result;

  if ShowFace then Exit;

  ClientRect  := Rect(0, 0, Width, Height);
  CenterPoint := Result;

  MaxRadius   := FPointerLength;
  if ShowPositionIndicators then MaxRadius := MaxRadius + PositionIndicatorMargin + PositionIndicatorSize;

  MaxLabelHeight := 0;
  Canvas.Font.Assign(PositionLabelActiveFont);   if Canvas.TextHeight('A') > MaxLabelHeight then MaxLabelHeight := Canvas.TextHeight('A');
  Canvas.Font.Assign(PositionLabelInactiveFont); if Canvas.TextHeight('A') > MaxLabelHeight then MaxLabelHeight := Canvas.TextHeight('A');

  if FPositionLabelAlignment = ilaJustified then MaxLabelHeight := MaxLabelHeight + MaxLabelHeight div 2;

  MaxRadius := MaxRadius + PositionLabelMargin + MaxLabelHeight;

  TempPoint := GetXYRadPoint(AngleOffset, MaxRadius, Point(0,0));
  MaxX      := TempPoint.x;
  MinX      := TempPoint.x;
  MaxY      := TempPoint.y;
  MinY      := TempPoint.y;

  for x := 2 to PositionLabelsList.Count do
    begin
      TempPoint := GetXYRadPoint(AngleOffset - (x - 1)*FDegreesStep, MaxRadius, Point(0,0));
      if TempPoint.x > MaxX then MaxX := TempPoint.x;
      if TempPoint.x < MinX then MinX := TempPoint.x;
      if TempPoint.y > MaxY then MaxY := TempPoint.y;
      if TempPoint.y < MinY then MinY := TempPoint.y;
      TempPoint := GetXYRadPoint(AngleOffset - (x - 1)*FDegreesStep, -FPointerLength, Point(0,0));
      if TempPoint.x > MaxX then MaxX := TempPoint.x;
      if TempPoint.x < MinX then MinX := TempPoint.x;
      if TempPoint.y > MaxY then MaxY := TempPoint.y;
      if TempPoint.y < MinY then MinY := TempPoint.y;
    end;

  Result := Point(CenterPoint.x - Round((MaxX + MinX)/2), CenterPoint.y - Round((MaxY + MinY)/2));

  FCenterPoint := Result;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.iPaintTo(Canvas: TCanvas);
var
  DrawRect    : TRect;
  Angle       : Double;
  CenterPoint : TPoint;
begin
  case FRotationDesiredSpacing of
    irds22p5 : FDegreesStep := 22.5;
    irds45   : FDegreesStep := 45;
    irds90   : FDegreesStep := 90;
  end;

  if PositionLabelCount > 4 then if FDegreesStep > 45   then FDegreesStep := 45;
  if PositionLabelCount > 8 then if FDegreesStep > 22.5 then FDegreesStep := 22.5;

  CenterPoint := GetCenterPoint(Canvas);
  DrawRect := Rect(0,0,Width-1, Height-1);

  Angle := AngleOffset - (Position)*FDegreesStep;

  if Angle >= 360 then Angle := Angle - 360;
  if Angle <    0 then Angle := Angle + 360;

  DrawBackGround (Canvas, BackGroundColor);
  DrawFace       (Canvas, CenterPoint);
  DrawPointerFace(Canvas, CenterPoint);
  DrawIndicator  (Canvas, CenterPoint, Angle);
  DrawTicks      (Canvas, CenterPoint, AngleOffset);

  if ShowFocusRect and HasFocus then iDrawFocusRect(Canvas, ClientRect, BackGroundColor);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRotary.DrawFace(Canvas: TCanvas; const OffsetPoint: TPoint);
var
  AFaceRadius   : Integer;                                         
  ASmallerDepth : Integer;
begin
  if not FShowFace then Exit;

  with Canvas do
    begin
      if Width < Height then ASmallerDepth := Width
      else                   ASmallerDepth := Height;

      AFaceRadius := ASmallerDepth div 2 - FOuterMargin;

      case FFaceBevelStyle of
        idesSunken : DrawGradientCircleSunken(Canvas, BackGroundColor, OffsetPoint, AFaceRadius);
        idesRaised : DrawGradientCircleRaised(Canvas, BackGroundColor, OffsetPoint, AFaceRadius);
      end;

      AFaceRadius := AFaceRadius - FFaceBevelSize;

      case FFaceStyle of
        idesFlat   : begin
                       Pen.Color   := FFaceColor;
                       Brush.Color := FFaceColor;
                       Canvas.Ellipse(OffsetPoint.X - AFaceRadius, OffsetPoint.Y - AFaceRadius, OffsetPoint.X + AFaceRadius, OffsetPoint.Y + AFaceRadius);
                     end;
        idesSunken : DrawGradientCircle(Canvas, clWhite, FFaceColor, OffsetPoint, AFaceRadius, True);
        idesRaised : DrawGradientCircle(Canvas, clWhite, FFaceColor, OffsetPoint, AFaceRadius, False);
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSwitchRotary.DrawPointerFace(Canvas: TCanvas; const OffsetPoint: TPoint);
var
  AFaceRadius : Integer;
begin
  if not FShowPointerFace then Exit;

  with Canvas do                                       
    begin
      AFaceRadius := PointerLength + FPointerFaceBevelSize;
                                                               
      case FPointerFaceBevelStyle of
        idesSunken : DrawGradientCircleSunken(Canvas, BackGroundColor, OffsetPoint, AFaceRadius);
        idesRaised : DrawGradientCircleRaised(Canvas, BackGroundColor, OffsetPoint, AFaceRadius);
      end;

      AFaceRadius := AFaceRadius - FPointerFaceBevelSize;

      Pen.Color   := FPointerFaceColor;
      Brush.Color := FPointerFaceColor;
      Canvas.Ellipse(OffsetPoint.X - AFaceRadius, OffsetPoint.Y - AFaceRadius, OffsetPoint.X + AFaceRadius, OffsetPoint.Y + AFaceRadius);
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.DrawIndicator(Canvas: TCanvas; CenterPoint: TPoint; Angle: Double);
begin
  case FPointerStyle of
    isrpsPointer   : DrawIndicatorPointer  (Canvas, CenterPoint, Angle);
    isrpsRectangle : DrawIndicatorRectangle(Canvas, CenterPoint, Angle);
  end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.DrawIndicatorRectangle(Canvas: TCanvas; CenterPoint: TPoint; Angle: Double);
var
  Point1          : TPoint;
  Point2          : TPoint;
  Point3          : TPoint;
  Point4          : TPoint;
  TempCenterPoint : TPoint;
  IndicatorPoint1 : TPoint;
  IndicatorPoint2 : TPoint;
begin
  CenterPoint := GetCenterPoint(Canvas);
  with Canvas, CenterPoint do
    begin
      TempCenterPoint  := GetXYRadPoint(Angle,       FPointerLength, CenterPoint);
      Point1           := GetXYRadPoint(Angle - 270, FPointerHeight, TempCenterPoint);
      Point2           := GetXYRadPoint(Angle -  90, FPointerHeight, TempCenterPoint);

      IndicatorPoint1  := GetXYRadPoint(Angle,       FPointerLength,     CenterPoint);
      IndicatorPoint2  := GetXYRadPoint(Angle,       FPointerLength - 8, CenterPoint);

      TempCenterPoint  := GetXYRadPoint(Angle - 180, FPointerLength, CenterPoint);
      Point3           := GetXYRadPoint(Angle -  90, FPointerHeight, TempCenterPoint);
      Point4           := GetXYRadPoint(Angle - 270, FPointerHeight, TempCenterPoint);
                                   
      Brush.Style := bsSolid;
      Pen.Color   := clWhite;
      if FMouseDown or FKeyDown then Brush.Color := FPointerHighLightColor else Brush.Color := FPointerColor;

      Polygon([Point1, Point2, Point3, Point4]);

      Pen.Color := clBlack;

      if      Angle =   0.0 then Polyline([Point1, Point2, Point3])
      else if Angle = 337.5 then Polyline([Point1, Point2, Point3])
      else if Angle = 315.0 then Polyline([Point1, Point2, Point3])
      else if Angle = 292.5 then Polyline([Point1, Point2, Point3])

      else if Angle = 270.0 then Polyline([Point4, Point1, Point2])
      else if Angle = 247.5 then Polyline([Point4, Point1, Point2])
      else if Angle = 225.0 then Polyline([Point4, Point1, Point2])
      else if Angle = 202.5 then Polyline([Point4, Point1, Point2])

      else if Angle = 180.0 then Polyline([Point3, Point4, Point1])
      else if Angle = 157.5 then Polyline([Point3, Point4, Point1])
      else if Angle = 135.0 then Polyline([Point3, Point4, Point1])
      else if Angle = 112.5 then Polyline([Point3, Point4, Point1])

      else if Angle =  90.0 then Polyline([Point2, Point3, Point4])
      else if Angle =  67.5 then Polyline([Point2, Point3, Point4])
      else if Angle =  45.0 then Polyline([Point2, Point3, Point4])
      else if Angle =  22.5 then Polyline([Point2, Point3, Point4]);

      if      (Angle =   0) or (Angle = 180) then
        begin
          PolyLine([Point(IndicatorPoint1.x + 0, IndicatorPoint1.y - 1), Point(IndicatorPoint2.x + 0, IndicatorPoint2.y - 1)]);
          PolyLine([Point(IndicatorPoint1.x + 0, IndicatorPoint1.y + 0), Point(IndicatorPoint2.x + 0, IndicatorPoint2.y + 0)]);
          Pen.Color := clWhite;
          PolyLine([Point(IndicatorPoint1.x + 0, IndicatorPoint1.y + 1), Point(IndicatorPoint2.x + 0, IndicatorPoint2.y + 1)]);
        end
      else if (Angle = 135) or (Angle = 112.5)  or (Angle = 157.5)  or (Angle = 315)  or (Angle = 292.5)  or (Angle = 337.5) then
        begin
          PolyLine([Point(IndicatorPoint1.x + 1, IndicatorPoint1.y - 1), Point(IndicatorPoint2.x + 1, IndicatorPoint2.y - 1)]);
          PolyLine([Point(IndicatorPoint1.x + 0, IndicatorPoint1.y + 0), Point(IndicatorPoint2.x + 0, IndicatorPoint2.y + 0)]);
          Pen.Color := clWhite;
          PolyLine([Point(IndicatorPoint1.x - 1, IndicatorPoint1.y + 1), Point(IndicatorPoint2.x - 1, IndicatorPoint2.y + 1)]);
        end
      else if (Angle =  90) or (Angle = 270) then
        begin
          PolyLine([Point(IndicatorPoint1.x - 1, IndicatorPoint1.y + 0), Point(IndicatorPoint2.x - 1, IndicatorPoint2.y + 0)]);
          PolyLine([Point(IndicatorPoint1.x + 0, IndicatorPoint1.y + 0), Point(IndicatorPoint2.x + 0, IndicatorPoint2.y + 0)]);
          Pen.Color := clWhite;
          PolyLine([Point(IndicatorPoint1.x + 1, IndicatorPoint1.y + 0), Point(IndicatorPoint2.x + 1, IndicatorPoint2.y + 0)]);
        end
      else if (Angle =  45) or (Angle = 22.5)  or (Angle = 67.5)  or (Angle = 225)  or (Angle = 202.5)  or (Angle = 247.5) then
        begin
          PolyLine([Point(IndicatorPoint1.x - 1, IndicatorPoint1.y - 1), Point(IndicatorPoint2.x - 1, IndicatorPoint2.y - 1)]);
          PolyLine([Point(IndicatorPoint1.x + 0, IndicatorPoint1.y + 0), Point(IndicatorPoint2.x + 0, IndicatorPoint2.y + 0)]);
          Pen.Color := clWhite;
          PolyLine([Point(IndicatorPoint1.x + 1, IndicatorPoint1.y + 1), Point(IndicatorPoint2.x + 1, IndicatorPoint2.y + 1)]);
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.DrawIndicatorPointer(Canvas: TCanvas; CenterPoint: TPoint; Angle: Double);
var
  Point1          : TPoint;
  Point2          : TPoint;
  Point3          : TPoint;
  Point4          : TPoint;
  Point5          : TPoint;
  TempCenterPoint : TPoint;
begin
  with Canvas, CenterPoint do
    begin
      TempCenterPoint  := GetXYRadPoint(Angle,       FPointerLength - 2*FPointerHeight, CenterPoint);
      Point1           := GetXYRadPoint(Angle - 270, FPointerHeight, TempCenterPoint);
      Point2           := GetXYRadPoint(Angle,       FPointerLength, CenterPoint);
      Point3           := GetXYRadPoint(Angle -  90, FPointerHeight, TempCenterPoint);

      TempCenterPoint  := GetXYRadPoint(Angle - 180, FPointerLength, CenterPoint);
      Point4           := GetXYRadPoint(Angle -  90, FPointerHeight, TempCenterPoint);
      Point5           := GetXYRadPoint(Angle - 270, FPointerHeight, TempCenterPoint);

      Brush.Style := bsSolid;
      if FMouseDown or FKeyDown then Brush.Color := FPointerHighLightColor else Brush.Color := FPointerColor;

      Pen.Style   := psClear;
      Polygon([Point1, Point2, Point3, Point4, Point5]);

      Pen.Style   := psSolid;

      if Angle = 0 then
        begin
          Pen.Color := clBlack; Polyline([Point2, Point3, Point4]);
          Pen.Color := clWhite; Polyline([Point4, Point5, Point1, Point2]);
        end
      else if (Angle = 337.5) or (Angle = 315) or (Angle = 292.5) then
        begin
          Pen.Color := clBlack; Polyline([Point2, Point3, Point4]);
          Pen.Color := clWhite; Polyline([Point4, Point5, Point1, Point2]);
        end
      else if Angle = 270 then
        begin
          Pen.Color := clBlack; Polyline([Point5, Point1, Point2]);
          Pen.Color := clWhite; Polyline([Point2, Point3, Point4, Point5]);
        end
      else if (Angle = 247.5) or (Angle = 225) or (Angle = 202.5) then
        begin
          Pen.Color := clBlack; Polyline([Point4, Point5, Point1, Point2]);
            Pen.Color := clWhite; Polyline([Point2, Point3, Point4]);
        end
      else if Angle = 180 then
        begin
          Pen.Color := clWhite; Polyline([Point2, Point3, Point4]);
          Pen.Color := clBlack; Polyline([Point4, Point5, Point1, Point2]);
        end
      else if (Angle = 157.5) or (Angle = 135) or (Angle = 112.5) then
        begin
          Pen.Color := clWhite; Polyline([Point2, Point3, Point4]);
          Pen.Color := clBlack; Polyline([Point4, Point5, Point1, Point2]);
        end
      else if Angle = 90 then
        begin
          Pen.Color := clBlack; Polyline([Point2, Point3, Point4, Point5]);
          Pen.Color := clWhite; Polyline([Point5, Point1, Point2]);
        end
      else if (Angle = 67.5) or (Angle = 45) or (Angle = 22.5) then
        begin
          Pen.Color := clWhite; Polyline([Point4, Point5, Point1, Point2]);
          Pen.Color := clBlack; Polyline([Point2, Point3, Point4]);
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.DrawTicks(Canvas: TCanvas; CenterPoint: TPoint; AngleOffset: Double);
var
  TextRadius     : Double;
  ATextRect      : TRect;
  TextPoint      : TPoint;
  AText          : String;
  AX             : Integer;
  AY             : Integer;
  ATextWidth     : Integer;
  ATextHeight    : Integer;
  IndicatorPoint : TPoint;
  IndicatorRect  : TRect;
  x              : Integer;
  Angle          : Double;
begin
  with Canvas do
    begin
      Brush.Style := bsClear;

      for x := 0 to PositionLabelsList.Count-1 do
        begin
          Angle := AngleOffset - (x)*FDegreesStep;
          if Angle >= 360 then Angle := Angle - 360;
          if Angle <    0 then Angle := Angle + 360;

          if x <= PositionLabelsList.Count-1 then AText  := PositionLabelsList.Strings[x] else AText := '???';
          TextRadius  := FPointerLength + PositionLabelMargin + 4;
          if ShowPositionIndicators then TextRadius := TextRadius + PositionIndicatorMargin + PositionIndicatorSize;
          TextPoint   := GetXYRadPoint(Angle, TextRadius, CenterPoint);

          if ShowPositionIndicators then
            begin
              IndicatorPoint := GetXYRadPoint(Angle, FPointerLength + PositionIndicatorMargin + PositionIndicatorSize/2, CenterPoint);
              IndicatorRect  := Rect(IndicatorPoint.x - PositionIndicatorSize, IndicatorPoint.y - PositionIndicatorSize,
                                     IndicatorPoint.x + PositionIndicatorSize, IndicatorPoint.y + PositionIndicatorSize);
              with IndicatorRect do
                begin
                  Pen.Style   := psClear;
                  if Enabled or not ShowDisabledState then Brush.Color := PositionIndicatorColor
                  else                                     Brush.Color := BackGroundColor;
                  Brush.Style := bsSolid;
                  Ellipse(Left, Top, Right, Bottom);
                  Pen.Style   := psSolid;
                  case PositionIndicatorBevelStyle of
                    ibsRaised  : begin
                                   Pen.Color := clWhite;
                                   Arc(Left, Top, Right, Bottom, Right, Top, Left, Bottom);
                                   Pen.Color := clGray;
                                   Arc(Left, Top, Right, Bottom, Left, Bottom, Right, Top);
                                 end;
                    ibsLowered : begin
                                   Pen.Color := clGray;
                                   Arc(Left, Top, Right, Bottom, Right, Top, Left, Bottom);
                                   Pen.Color := clWhite;
                                   Arc(Left, Top, Right, Bottom, Left, Bottom, Right, Top);
                                 end;
                  end;
                end;
            end;

          Brush.Style := bsClear;

          if ShowPositionLabels then
            begin
              if Position <> x then Font.Assign(PositionLabelInactiveFont) else Font.Assign(PositionLabelActiveFont);

              AX          := TextPoint.X;
              AY          := TextPoint.Y;
              ATextWidth  := TextWidth (AText);
              ATextHeight := TextHeight(AText);

              case FPositionLabelAlignment of
                ilaCenter    : begin
                                 ATextRect := GetCenterPointRect(TextPoint.X, TextPoint.Y, ATextWidth, ATextHeight);
                                 if ShowDisabledState then iDrawText(Canvas, AText, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], Enabled, BackGroundColor)
                                 else                      iDrawText(Canvas, AText, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], True,    BackGroundColor);
                               end;
                ilaJustified : begin
                                 if      (Angle > 90) and (Angle < 270) then ATextRect := GetCenterPointRect(AX - ATextWidth div 2, AY,                     ATextWidth, ATextHeight)
                                 else if (Angle = 90)                   then ATextRect := GetCenterPointRect(AX,                    AY - ATextHeight div 2, ATextWidth, ATextHeight)
                                 else if (Angle = 270)                  then ATextRect := GetCenterPointRect(AX,                    AY + ATextHeight div 2, ATextWidth, ATextHeight)
                                 else                                        ATextRect := GetCenterPointRect(AX + ATextWidth div 2, AY,                     ATextWidth, ATextHeight);

                                 if ShowDisabledState then iDrawText(Canvas, AText, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], Enabled, BackGroundColor)
                                 else                      iDrawText(Canvas, AText, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], True,    BackGroundColor);
                               end;
              end;
            end;
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchRotary.iDoKillFocus;
begin
  FMouseDown := False;
  FKeyDown   := False;
  inherited;
end;
//*************************************************************************************************************************************
end.


