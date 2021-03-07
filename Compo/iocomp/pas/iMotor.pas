{*******************************************************}
{                                                       }
{       TiMotor Component                               }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iMotor;{$endif}
{$ifdef iCLX}unit QiMotor;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiMotorBaseStyle = (imbsTrapezoid, imbsFeet);

  TiMotor = class(TiCustomComponent)
  private
    FPipeShowLeft   : Boolean;
    FPipeShowRight  : Boolean;
    FPipeShowTop    : Boolean;
    FPipeShowBottom : Boolean;
    FBaseShow       : Boolean;
    FFanSequence    : Integer;
    FBladeColor1    : TColor;
    FBladeColor2    : TColor;
    FBladeColor3    : TColor;
    FBaseStyle      : TiMotorBaseStyle;
    FFanOn          : Boolean;
    FFanInterval    : Integer;
    FPipeColor: TColor;
    procedure SetPipeColor(const Value: TColor);
  protected
    procedure SetPipeShowLeft  (const Value: Boolean);
    procedure SetPipeShowRight (const Value: Boolean);
    procedure SetPipeShowTop   (const Value: Boolean);
    procedure SetPipeShowBottom(const Value: Boolean);
    procedure SetBaseShow      (const Value: Boolean);
    procedure SetFanSequence   (const Value: Integer);
    procedure SetBladeColor1   (const Value: TColor);
    procedure SetBladeColor2   (const Value: TColor);
    procedure SetBladeColor3   (const Value: TColor);
    procedure SetBaseStyle     (const Value: TiMotorBaseStyle);
    procedure SetFanOn         (const Value: Boolean);
    procedure SetFanInterval   (const Value: Integer);

    function GetSequenceColor: TColor;

    procedure TimerEvent     (Sender: TObject);

    procedure iPaintTo (Canvas: TCanvas);    override;
    procedure DrawBase (Canvas: TCanvas);
    procedure DrawMotor(Canvas: TCanvas);
  public
    constructor Create(AOwner: TComponent); override;

    procedure IncrementFanSequence;
  published
    property Width  default 50;
    property Height default 50;

    property PipeShowLeft   : Boolean          read FPipeShowLeft    write SetPipeShowLeft;
    property PipeShowTop    : Boolean          read FPipeShowTop     write SetPipeShowTop;
    property PipeShowRight  : Boolean          read FPipeShowRight   write SetPipeShowRight;
    property PipeShowBottom : Boolean          read FPipeShowBottom  write SetPipeShowBottom;
    property PipeColor      : TColor read FPipeColor write SetPipeColor;

    property BaseShow       : Boolean          read FBaseShow        write SetBaseShow;
    property BaseStyle      : TiMotorBaseStyle read FBaseStyle       write SetBaseStyle;

    property BladeColor1    : TColor           read FBladeColor1     write SetBladeColor1;
    property BladeColor2    : TColor           read FBladeColor2     write SetBladeColor2;
    property BladeColor3    : TColor           read FBladeColor3     write SetBladeColor3;

    property FanSequence    : Integer          read FFanSequence     write SetFanSequence;

    property FanOn          : Boolean          read FFanOn           write SetFanOn       default False;
    property FanInterval    : Integer          read FFanInterval     write SetFanInterval default 100;

    property BackGroundColor;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiMotor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 80;
  Height := 80;

  FPipeShowLeft   := True;
  FPipeShowRight  := True;
  FPipeColor      := clBtnFace;

  FBaseShow       := False;

  FBladeColor1    := clRed;
  FBladeColor2    := clBlue;
  FBladeColor3    := clYellow;

  FFanInterval    := 100;

  OnInternalTimer := TimerEvent;
end;
//****************************************************************************************************************************************************
procedure TiMotor.SetPipeShowLeft   (const Value: Boolean);begin SetBooleanProperty(Value, FPipeShowLeft,   irtInvalidate);end;
procedure TiMotor.SetPipeShowRight  (const Value: Boolean);begin SetBooleanProperty(Value, FPipeShowRight,  irtInvalidate);end;
procedure TiMotor.SetPipeShowTop    (const Value: Boolean);begin SetBooleanProperty(Value, FPipeShowTop,    irtInvalidate);end;
procedure TiMotor.SetPipeShowBottom (const Value: Boolean);begin SetBooleanProperty(Value, FPipeShowBottom, irtInvalidate);end;
procedure TiMotor.SetBaseShow       (const Value: Boolean);begin SetBooleanProperty(Value, FBaseShow,       irtInvalidate);end;
procedure TiMotor.SetBladeColor1    (const Value: TColor );begin SetColorProperty  (Value, FBladeColor1,    irtInvalidate);end;
procedure TiMotor.SetBladeColor2    (const Value: TColor );begin SetColorProperty  (Value, FBladeColor2,    irtInvalidate);end;
procedure TiMotor.SetBladeColor3    (const Value: TColor );begin SetColorProperty  (Value, FBladeColor3,    irtInvalidate);end;
procedure TiMotor.SetPipeColor      (const Value: TColor );begin SetColorProperty  (Value, FPipeColor,      irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiMotor.SetFanSequence(const Value: Integer);
begin
  if Value < 0 then Exit;
  if Value > 2 then Exit;
  SetIntegerProperty(Value, FFanSequence, irtInvalidate);
end;
//****************************************************************************************************************************************************
procedure TiMotor.SetBaseStyle(const Value: TiMotorBaseStyle);
begin
  if FBaseStyle <> Value then
    begin
      FBaseStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiMotor.DrawBase(Canvas: TCanvas);
var
  DrawRect    : TRect;
  CenterPoint : TPoint;
  WidthThird  : Integer;
  InputSize   : Integer;
  Point1      : TPoint;
  Point2      : TPoint;
  Point3      : TPoint;
  Point4      : TPoint;
begin
  DrawRect    := Rect(0, 0, Width-1, Height-1);
  CenterPoint := GetCenterPoint(Canvas);

  with Canvas, DrawRect do
    begin
      WidthThird := Right div 3;
      InputSize  := Right div 6;

      Brush.Style := bsSolid;

      if FBaseShow then
        begin
          Brush.Color := clBtnFace;
          Pen.Color := clWhite;
          Pen.Style := psClear;

          case FBaseStyle of
            imbsFeet     : begin
                             Point1 := Point(CenterPoint.X - WidthThird, Bottom);
                             Point2 := Point(CenterPoint.X - InputSize,  Bottom - 2*WidthThird);
                             Point3 := Point(Point2.X + InputSize, Point2.Y);
                             Point4 := Point(Point1.X + InputSize, Point1.Y);

                             Polygon([Point1, Point2, Point3, Point4]);

                             Pen.Style := psSolid;

                             Pen.Color := clWhite;
                             PolyLine([Point1, Point2]);

                             Pen.Color := clGray;
                             PolyLine([Point3, Point4]);

                             Pen.Color := clBlack;
                             PolyLine([Point4, Point1]);

                             Point1 := Point(CenterPoint.X + WidthThird, Bottom);
                             Point2 := Point(CenterPoint.X + InputSize,  Bottom - 2*WidthThird);
                             Point3 := Point(Point2.X - InputSize, Point2.Y);
                             Point4 := Point(Point1.X - InputSize, Point1.Y);

                             Polygon([Point1, Point2, Point3, Point4]);

                             Pen.Style := psSolid;

                             Pen.Color := clGray;
                             PolyLine([Point1, Point2]);

                             Pen.Color := clWhite;
                             PolyLine([Point3, Point4]);

                             Pen.Color := clBlack;
                             PolyLine([Point4, Point1]);
                           end;
            imbsTrapezoid: begin
                             Point1 := Point(CenterPoint.X - WidthThird, Bottom);
                             Point2 := Point(CenterPoint.X - InputSize,  Bottom - 2*WidthThird);
                             Point3 := Point(CenterPoint.X + InputSize,  Bottom - 2*WidthThird);
                             Point4 := Point(CenterPoint.X + WidthThird, Bottom);

                             Polygon([Point1, Point2, Point3, Point4]);

                             Pen.Style := psSolid;

                             Pen.Color := clWhite;
                             PolyLine([Point1, Point2]);

                             Pen.Color := clGray;
                             PolyLine([Point3, Point4]);

                             Pen.Color := clBlack;
                             PolyLine([Point4, Point1]);
                           end;
          end;
        end;

      Brush.Color := FPipeColor;

      if FPipeShowLeft then
        begin
          Pen.Color := clWhite;
          Rectangle(CenterPoint.X, CenterPoint.Y - InputSize, Left, CenterPoint.Y + InputSize);
          Pen.Color := clBlack;
          Polyline([Point(CenterPoint.X, CenterPoint.Y + InputSize -1), Point(Left, CenterPoint.Y + InputSize-1)]);
        end;

      if FPipeShowRight then
        begin
          Pen.Color := clBlack;
          Rectangle(CenterPoint.X, CenterPoint.Y - InputSize, Right, CenterPoint.Y + InputSize);
          Pen.Color := clWhite;
          Polyline([Point(CenterPoint.X, CenterPoint.Y - InputSize), Point(Right, CenterPoint.Y - InputSize)]);
        end;

      if FPipeShowTop then
        begin
          Pen.Color := clWhite;
          Rectangle(CenterPoint.X - InputSize, 0, CenterPoint.X + InputSize , CenterPoint.Y);
          Pen.Color := clBlack;
          Polyline([Point(CenterPoint.X + InputSize-1, 0), Point(CenterPoint.X + InputSize-1, CenterPoint.Y)]);
        end;

      if FPipeShowBottom then
        begin
          Pen.Color := clBlack;
          Rectangle(CenterPoint.X - InputSize, CenterPoint.Y, CenterPoint.X + InputSize , Bottom);
          Pen.Color := clWhite;
          Polyline([Point(CenterPoint.X - InputSize, CenterPoint.Y), Point(CenterPoint.X - InputSize, Bottom)]);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiMotor.DrawMotor(Canvas: TCanvas);
var
  DrawRect     : TRect;
  CenterPoint  : TPoint;
  RadiusInner  : Integer;
  RadiusOuter  : Integer;
  FanRect      : TRect;
  Angle        : Integer;
  AngleStep    : Integer;
  Point1       : TPoint;
  Point2       : TPoint;
begin
  DrawRect := Rect(0, 0, Width-1, Height-1);
  CenterPoint := GetCenterPoint(Canvas);

  with Canvas, DrawRect do
    begin
      RadiusOuter  := Width div 3;
      RadiusInner  := RadiusOuter -5;

      FanRect      := Rect(CenterPoint.X - RadiusInner, CenterPoint.Y - RadiusInner,
                           CenterPoint.X + RadiusInner+1, CenterPoint.Y + RadiusInner);

      DrawGradientCircle(Canvas, clWhite, ColorToRGB(clBtnFace) and $FFFFFF - $505050, CenterPoint, RadiusOuter, False);

      Pen.Width   := 1;
      Pen.Style   := psClear;

      Angle       := 0;
      AngleStep   := 60;

      while Angle < 360 do
        begin
          Pen.Color   := GetSequenceColor;
          Brush.Color := GetSequenceColor;
          Brush.Style := bsSolid;

          Inc(FFanSequence); if FFanSequence > 2 then FFanSequence := 0;

          Point2 := GetXYRadPoint(Angle + AngleStep, RadiusOuter +1, CenterPoint);
          Point1 := GetXYRadPoint(Angle            , RadiusOuter +1, CenterPoint);

          {$ifdef iVCL}
          Pie(FanRect.Left, FanRect.Top, FanRect.Right, FanRect.Bottom, Point1.X, Point1.Y, Point2.X, Point2.Y);
          {$endif}
          {$ifdef iCLX}
          Pie(FanRect.Left, FanRect.Top, FanRect.Right - FanRect.Left, FanRect.Bottom - FanRect.Top, Angle*16, AngleStep*16);
          {$endif}
          Angle := Angle + AngleStep;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiMotor.iPaintTo(Canvas: TCanvas);
begin
  DrawBackGround(Canvas, BackGroundColor);
  DrawBase      (Canvas);
  DrawMotor     (Canvas);
end;
//****************************************************************************************************************************************************
function TiMotor.GetSequenceColor: TColor;
begin
  case FFanSequence of
    0 :   Result := FBladeColor1;
    1 :   Result := FBladeColor2;
    else  Result := FBladeColor3;
  end;
end;
//****************************************************************************************************************************************************
procedure TiMotor.IncrementFanSequence;
begin
  Inc(FFanSequence); if FFanSequence > 2 then FFanSequence := 0;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiMotor.SetFanOn(const Value: Boolean);
begin
  if FFanOn <> Value then
    begin
      FFanOn := Value;
      if FFanOn then
        begin
          if not GetIsDesigning then TimerStart(FFanInterval, FFanInterval);
        end
      else
        begin
          if TimerRunning then TimerStop;
        end;
    end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiMotor.SetFanInterval(const Value: Integer);
begin
  if FFanInterval <> Value then
    begin
      FFanInterval := Value;

      if TimerRunning then
        begin
          TimerStop;
          TimerStart(FFanInterval, FFanInterval);
        end;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiMotor.TimerEvent(Sender: TObject);
begin
  IncrementFanSequence;
end;
//****************************************************************************************************************************************************
end.
