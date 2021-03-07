{*******************************************************}
{                                                       }
{       TiLedSpiral Component                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedSpiral;{$endif}
{$ifdef iCLX}unit QiLedSpiral;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iProgressComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiProgressComponent;{$ENDIF}

type
  TiLedSpiralStyle = (ilssProgress, ilssPointer);
  TiLedSpiral = class(TiProgressComponent)
  private
    FOuterRadius  : Integer;
    FSegmentCount : Integer;
    FSegmentSize  : Integer;
    FSegmentWidth : Integer;
    FRangeDegrees : Integer;
    FStartDegrees : Integer;
    FAutoSize     : Boolean;
    FOuterMargin  : Integer;
    FStyle: TiLedSpiralStyle;
    procedure SetStyle(const Value: TiLedSpiralStyle);
  protected
    procedure SetOuterRadius (const Value: Integer);
    procedure SetSegmentCount(const Value: Integer);
    procedure SetSegmentSize (const Value: Integer);
    procedure SetSegmentWidth(const Value: Integer);
    procedure SetRangeDegrees(const Value: Integer);
    procedure SetStartDegrees(const Value: Integer);
    procedure iSetAutoSize   (const Value: Boolean);
    procedure SetOuterMargin (const Value: Integer);

    procedure iPaintTo(Canvas: TCanvas);    override;

    procedure DrawSegments(Canvas: TCanvas);
    procedure DrawPointer (Canvas: TCanvas);
    procedure AdjustOuterRadius;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property SegmentCount : Integer          read FSegmentCount write SetSegmentCount  default 32;
    property SegmentSize  : Integer          read FSegmentSize  write SetSegmentSize   default 1;
    property SegmentWidth : Integer          read FSegmentWidth write SetSegmentWidth  default 10;
    property OuterRadius  : Integer          read FOuterRadius  write SetOuterRadius   default 50;
    property RangeDegrees : Integer          read FRangeDegrees write SetRangeDegrees  default 360;
    property StartDegrees : Integer          read FStartDegrees write SetStartDegrees  default 180;
    property AutoSize     : Boolean          read FAutoSize     write iSetAutoSize     default True;
    property OuterMargin  : Integer          read FOuterMargin  write SetOuterMargin   default 5;
    property Style        : TiLedSpiralStyle read FStyle        write SetStyle         default ilssProgress;
    property BackGroundPicture;
    property BackGroundColor;
    property BorderStyle;
    property Transparent;
    property Width            default 110;
    property Height           default 110;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLedSpiral.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 110;
  Height := 110;

  FOuterRadius  := 50;
  FSegmentWidth := 10;
  FSegmentSize  := 1;
  FSegmentCount := 32;

  FRangeDegrees := 360;
  FStartDegrees := 180;
  FOuterMargin  := 5;

  FAutoSize     := True;

  CreateBackGroundPicture;
end;
//****************************************************************************************************************************************************
procedure TiLedSpiral.SetSegmentWidth(const Value:Integer);begin SetIntegerProperty(Value,FSegmentWidth,irtInvalidate);end;
procedure TiLedSpiral.SetOuterRadius (const Value:Integer);begin SetIntegerProperty(Value,FOuterRadius, irtInvalidate);end;
procedure TiLedSpiral.SetSegmentSize (const Value:Integer);begin SetIntegerProperty(Value,FSegmentSize, irtInvalidate);end;
procedure TiLedSpiral.SetSegmentCount(const Value:Integer);begin SetIntegerProperty(Value,FSegmentCount,irtInvalidate);end;
procedure TiLedSpiral.SetStartDegrees(const Value:Integer);begin SetIntegerProperty(Value,FStartDegrees,irtInvalidate);end;
procedure TiLedSpiral.iSetAutoSize   (const Value:Boolean);begin SetBooleanProperty(Value,FAutoSize,    irtInvalidate);end;
procedure TiLedSpiral.SetOuterMargin (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin, irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiLedSpiral.SetStyle(const Value: TiLedSpiralStyle);
begin
  if FStyle <> Value then
    begin
      FStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedSpiral.SetRangeDegrees(const Value: Integer);
begin
  if FRangeDegrees <> Value then
    begin
      FRangeDegrees := Value;
      if FRangeDegrees > 360 then FRangeDegrees := 360;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedSpiral.AdjustOuterRadius;
var
  Diameter : Integer;
begin
  if Width < Height then Diameter := Width  - 2*FOuterMargin
    else                 Diameter := Height - 2*FOuterMargin;
  FOuterRadius := Diameter div 2;
end;
//****************************************************************************************************************************************************
procedure TiLedSpiral.iPaintTo(Canvas: TCanvas);
begin
  DrawSegments(Canvas);
end;
//****************************************************************************************************************************************************
procedure TiLedSpiral.DrawSegments(Canvas: TCanvas);
var
  x                   : Integer;
  SegmentsIlluminated : Integer;
  SegmentValue        : Double;
  StepSize            : Double;
  CurrentAngle        : Double;
  CurrentColor        : TColor;
  TempPoint           : TPointDouble;
  Point1              : TPointDouble;
  Point2              : TPointDouble;
  Point3              : TPointDouble;
  Point4              : TPointDouble;
  ShowOn              : Boolean;
begin
  with Canvas do
    begin
      if FAutoSize then AdjustOuterRadius;

      DrawBackGround(Canvas, BackGroundColor);

      SegmentsIlluminated := Round(FSegmentCount * ValuePercent(Position) + 0.5);

      if FRangeDegrees mod 360 = 0 then
        StepSize            := FRangeDegrees/(FSegmentCount)
      else
        StepSize            := FRangeDegrees/(FSegmentCount-1);

      for x := 0 to FSegmentCount -1 do
        begin
          SegmentValue := x * PositionMax/FSegmentCount;

                                                                      CurrentColor := SectionColor1;
          if (SectionCount > 1) and (SegmentValue > SectionEnd1) then CurrentColor := SectionColor2;
          if (SectionCount > 2) and (SegmentValue > SectionEnd2) then CurrentColor := SectionColor3;
          if (SectionCount > 3) and (SegmentValue > SectionEnd3) then CurrentColor := SectionColor4;
          if (SectionCount > 4) and (SegmentValue > SectionEnd4) then CurrentColor := SectionColor5;

          case FStyle of
            ilssProgress : begin
                             if x > (SegmentsIlluminated-1) then
                               begin
                                 ShowOn := False;
                                 if not ShowOffSegments then Break;
                               end
                             else ShowOn := True;
                           end;
            else           begin
                             ShowOn := x = (SegmentsIlluminated-1);
                             if (x = 0) and (SegmentsIlluminated = 0) then ShowOn := True;
                             if not ShowOn then if not ShowOffSegments then Continue;
                           end;
          end;

          if ShowOn then
            begin
              Brush.Color := CurrentColor;
              Pen.Color   := CurrentColor;
            end
          else
            begin
              Brush.Color := DimColor(CurrentColor, 3);
              Pen.Color   := Brush.Color;
            end;

          CurrentAngle := FStartDegrees - x*StepSize;

          TempPoint := GetXYRadPointDouble(CurrentAngle,    FOuterRadius, GetCenterPointDouble(Canvas));
          Point1    := GetXYRadPointDouble(CurrentAngle-90, FSegmentSize, TempPoint);
          Point2    := GetXYRadPointDouble(CurrentAngle+90, FSegmentSize, TempPoint);

          TempPoint := GetXYRadPointDouble(CurrentAngle,    FOuterRadius-FSegmentWidth, GetCenterPointDouble(Canvas));
          Point3    := GetXYRadPointDouble(CurrentAngle-90, FSegmentSize, TempPoint);
          Point4    := GetXYRadPointDouble(CurrentAngle+90, FSegmentSize, TempPoint);

          Polygon([PointDoubleToPoint(Point1), PointDoubleToPoint(Point2), PointDoubleToPoint(Point4), PointDoubleToPoint(Point3)]);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedSpiral.DrawPointer(Canvas: TCanvas);
var
  TempPoint    : TPointDouble;
  CurrentAngle : Double;
  Point1       : TPointDouble;
  Point2       : TPointDouble;
  Point3       : TPointDouble;
  Point4       : TPointDouble;
begin
  with Canvas do
    begin
      if FAutoSize then AdjustOuterRadius;

      DrawBackGround(Canvas, BackGroundColor);

      Brush.Color := SectionColor1;
      Pen.Color   := SectionColor1;

      CurrentAngle := FStartDegrees - ValuePercent(Position)*FRangeDegrees;

      TempPoint := GetXYRadPointDouble(CurrentAngle,    FOuterRadius, GetCenterPointDouble(Canvas));
      Point1    := GetXYRadPointDouble(CurrentAngle-90, FSegmentSize, TempPoint);
      Point2    := GetXYRadPointDouble(CurrentAngle+90, FSegmentSize, TempPoint);

      TempPoint := GetXYRadPointDouble(CurrentAngle,    FOuterRadius-FSegmentWidth, GetCenterPointDouble(Canvas));
      Point3    := GetXYRadPointDouble(CurrentAngle-90, FSegmentSize, TempPoint);
      Point4    := GetXYRadPointDouble(CurrentAngle+90, FSegmentSize, TempPoint);

      Polygon([PointDoubleToPoint(Point1), PointDoubleToPoint(Point2), PointDoubleToPoint(Point4), PointDoubleToPoint(Point3)]);
    end;
end;
//****************************************************************************************************************************************************
end.
