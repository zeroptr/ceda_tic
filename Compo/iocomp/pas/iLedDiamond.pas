{*******************************************************}
{                                                       }
{       TiLedDiamond Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedDiamond;{$endif}
{$ifdef iCLX}unit QiLedDiamond;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iLed;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiLed;{$ENDIF}

type
  TiLedDiamond = class(TiLed)
  private
  protected
    procedure iPaintTo(Canvas: TCanvas);                          override;
  public
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property Active;
    property ActiveColor;
    property BevelStyle;
    property OnChange;
    property BackGroundColor;
    property Transparent;
  end;

implementation
//****************************************************************************************************************************************************
procedure TiLedDiamond.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if AWidth  <> Width  then AHeight := AWidth;
  if AHeight <> Height then AWidth := AHeight;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;
//****************************************************************************************************************************************************
procedure TiLedDiamond.iPaintTo(Canvas: TCanvas);
var
  DrawRect    : TRect;                          //      1
  Point1      : TPoint;                         //      *
  Point2      : TPoint;                         //  4 *   * 2
  Point3      : TPoint;                         //     * *
  Point4      : TPoint;                         //      *
  CenterPoint : TPoint;                         //      3
  HalfSize    : Integer;
begin
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      DrawRect    := Rect(0, 0 ,Width, Height);
      CenterPoint := GetCenterPoint(Canvas);
      HalfSize    := (Width - 1) div 2;

      if Active then
        begin
          Brush.Color := ActiveColor;
          Pen.Color   := ActiveColor;
        end
      else
        begin
          if AutoInactiveColor then
            begin
              Brush.Color := DimColor(ActiveColor, 3);
              Pen.Color   := Brush.Color;
            end
          else
            begin
              Brush.Color := InactiveColor;
              Pen.Color   := Brush.Color;
            end
        end;

      Point1 := Point(CenterPoint.X,            CenterPoint.Y - HalfSize);
      Point2 := Point(CenterPoint.X + HalfSize, CenterPoint.Y);
      Point3 := Point(CenterPoint.X,            CenterPoint.Y + HalfSize);
      Point4 := Point(CenterPoint.X - HalfSize, CenterPoint.Y);

      Polygon([Point1, Point2, Point3 ,Point4]);

      case BevelStyle of
        ibsLowered : begin
                       Pen.Color := clBlack;
                       Polygon([Point1, Point4]);

                       Pen.Color := clBtnShadow;
                       Polygon([Point1, Point2]);
                       Polygon([Point3, Point4]);

                       Pen.Color := clBtnHighlight;
                       Polygon([Point2, Point3]);
                     end;
        ibsRaised  : begin
                       Pen.Color := clBlack;
                       Polygon([Point2, Point3]);
                       Pen.Color := clBtnHighlight;
                       Polygon([Point1, Point4]);

                       Pen.Color := clBtnShadow;
                       Polygon([Point1, Point2]);
                       Polygon([Point3, Point4]);
                     end;
      end;
    end;
end;
//****************************************************************************************************************************************************
end.
