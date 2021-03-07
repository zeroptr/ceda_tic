{*******************************************************}
{                                                       }
{       TiCompass Component                             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iCompass;{$endif}
{$ifdef iCLX}unit QiCompass;{$endif}

interface                           

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions,   iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiCompassPointerStyle = (icpsTriangle, icpsCircle, icpsLine);

  TiCompass = class(TiCustomComponent)
  private
    FPointerMargin             : Integer;
    FPointerColor              : TColor;
    FPointerSize               : Integer;
    FKnobRadius                : Integer;
    FOuterMargin               : Integer;
    FOuterBevelWidth           : Integer;
    FScaleBackGroundColor      : TColor;
    FTickLabelInnerMargin      : Integer;
    FTickLabelOuterMargin      : Integer;
    FTickLength                : Integer;
    FTickMargin                : Integer;
    FTickWidth                 : Integer;
    FTickColor                 : TColor;
    FTickLabelFont             : TFont;
    FDirection                 : Double;
    FPointerStyle              : TiCompassPointerStyle;
    FShowDirectionDisplay      : Boolean;
    FDirectionDisplayPrecision : Integer;
    FDirectionDisplayFont      : TFont;
    FOnCustomizeTickLabel      : TOnCustomizeTickLabel;
    FNCaption                  : String;
    FNWCaption                 : String;
    FWCaption                  : String;
    FSWCaption                 : String;
    FSCaption                  : String;
    FSECaption                 : String;
    FECaption                  : String;
    FNECaption                 : String;

    procedure SetPointerMargin            (const Value: Integer);
    procedure SetPointerColor             (const Value: TColor);
    procedure SetPointerSize              (const Value: Integer);
    procedure SetOuterBevelWidth          (const Value: Integer);
    procedure SetOuterMargin              (const Value: Integer);
    procedure SetScaleBackGroundColor     (const Value: TColor);
    procedure SetTickLabelFont            (const Value: TFont);
    procedure SetTickLabelInnerMargin     (const Value: Integer);
    procedure SetTickLabelOuterMargin     (const Value: Integer);
    procedure SetTickColor                (const Value: TColor);
    procedure SetTickLength               (const Value: Integer);
    procedure SetTickWidth                (const Value: Integer);
    procedure SetTickMargin               (const Value: Integer);
    procedure SetDirection                (const Value: Double);
    procedure SetPointerStyle             (const Value: TiCompassPointerStyle);
    procedure SetDirectionDisplayFont     (const Value: TFont);
    procedure SetDirectionDisplayPrecision(const Value: Integer);
    procedure SetShowDirectionDisplay     (const Value: Boolean);
    procedure SetNCaption                 (const Value: String);
    procedure SetNWCaption                (const Value: String);
    procedure SetWCaption                 (const Value: String);
    procedure SetSWCaption                (const Value: String);
    procedure SetSCaption                 (const Value: String);
    procedure SetSECaption                (const Value: String);
    procedure SetECaption                 (const Value: String);
    procedure SetNECaption                (const Value: String);
  protected
    procedure DrawTicks           (const OffsetPoint: TPoint; Canvas: TCanvas);
    procedure DrawIndicator       (const OffsetPoint: TPoint; Canvas: TCanvas);
    procedure DrawDirectionDisplay(                           Canvas: TCanvas);
    procedure iPaintTo(Canvas: TCanvas);                          override;
    procedure DoChange;
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property PointerMargin             : Integer               read FPointerMargin             write SetPointerMargin             default 1;
    property PointerColor              : TColor                read FPointerColor              write SetPointerColor              default clYellow;
    property PointerSize               : Integer               read FPointerSize               write SetPointerSize               default 12;
    property PointerStyle              : TiCompassPointerStyle read FPointerStyle              write SetPointerStyle              default icpsTriangle;
    property OuterMargin               : Integer               read FOuterMargin               write SetOuterMargin               default 5;
    property OuterBevelWidth           : Integer               read FOuterBevelWidth           write SetOuterBevelWidth           default 5;
    property ScaleBackGroundColor      : TColor                read FScaleBackGroundColor      write SetScaleBackGroundColor      default clNavy;

    property TickColor                 : TColor                read FTickColor                 write SetTickColor                 default clAqua;
    property TickLength                : Integer               read FTickLength                write SetTickLength                default 6;
    property TickWidth                 : Integer               read FTickWidth                 write SetTickWidth                 default 1;
    property TickMargin                : Integer               read FTickMargin                write SetTickMargin                default 4;
    property TickLabelInnerMargin      : Integer               read FTickLabelInnerMargin      write SetTickLabelInnerMargin      default 10;
    property TickLabelOuterMargin      : Integer               read FTickLabelOuterMargin      write SetTickLabelOuterMargin      default 8;
    property TickLabelFont             : TFont                 read FTickLabelFont             write SetTickLabelFont;

    property Direction                 : Double                read FDirection                 write SetDirection;

    property DirectionDisplayFont      : TFont                 read FDirectionDisplayFont      write SetDirectionDisplayFont;
    property DirectionDisplayPrecision : Integer               read FDirectionDisplayPrecision write SetDirectionDisplayPrecision default 1;
    property ShowDirectionDisplay      : Boolean               read FShowDirectionDisplay      write SetShowDirectionDisplay      default True;

    property NCaption                  : String                read FNCaption                  write SetNCaption;
    property NWCaption                 : String                read FNWCaption                 write SetNWCaption;
    property WCaption                  : String                read FWCaption                  write SetWCaption;
    property SWCaption                 : String                read FSWCaption                 write SetSWCaption;
    property SCaption                  : String                read FSCaption                  write SetSCaption;
    property SECaption                 : String                read FSECaption                 write SetSECaption;
    property ECaption                  : String                read FECaption                  write SetECaption;
    property NECaption                 : String                read FNECaption                 write SetNECaption;

    property OnCustomizeTickLabel      : TOnCustomizeTickLabel read FOnCustomizeTickLabel      write FOnCustomizeTickLabel;

    property BackGroundColor;
    property BorderStyle;
    property Transparent;
    property CachedDrawing;
    property Width            default 150;
    property Height           default 150;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiCompass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 150;
  Height := 150;

  FNCaption  := 'N';
  FNWCaption := 'NW';
  FWCaption  := 'W';
  FSWCaption := 'SW';
  FSCaption  := 'S';
  FSECaption := 'SE';
  FECaption  := 'E';
  FNECaption := 'NE';

  FPointerSize               := 12;
  FPointerMargin             := 1;
  FPointerColor              := clYellow;

  FTickWidth                 := 1;
  FTickLength                := 6;
  FTickLabelInnerMargin      := 10;
  FTickLabelOuterMargin      := 8;
  FTickMargin                := 4;
  FTickColor                 := clAqua;

  FOuterMargin               := 5;
  FOuterBevelWidth           := 5;
  FScaleBackGroundColor      := clNavy;
  FShowDirectionDisplay      := True;
  FDirectionDisplayPrecision := 1;

  FTickLabelFont          := TFont.Create;
  FTickLabelFont.Style    := [fsBold];
  FTickLabelFont.Name     := 'MS Sans Serif';
  FTickLabelFont.Size     := 8;
  FTickLabelFont.Color    := clWhite;
  FTickLabelFont.OnChange := BackGroundChangeEvent;

  FDirectionDisplayFont          := TFont.Create;
  FDirectionDisplayFont.Style    := [fsBold];
  FDirectionDisplayFont.Name     := 'MS Sans Serif';
  FDirectionDisplayFont.Size     := 10;
  FDirectionDisplayFont.Color    := clBlack;
  FDirectionDisplayFont.OnChange := BackGroundChangeEvent;
end;
//****************************************************************************************************************************************************
destructor TiCompass.Destroy;
begin
  FTickLabelFont.Free;
  FDirectionDisplayFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiCompass.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if AWidth  <> Width  then AHeight := AWidth;
  if AHeight <> Height then AWidth := AHeight;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;
//****************************************************************************************************************************************************
procedure TiCompass.DoChange;
begin
  if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Direction');
end;
//****************************************************************************************************************************************************
procedure TiCompass.SetPointerMargin            (const Value:Integer);begin SetIntegerProperty(Value,FPointerMargin,            irtBackGround);end;
procedure TiCompass.SetPointerColor             (const Value:TColor); begin SetColorProperty  (Value,FPointerColor,             irtBackGround);end;
procedure TiCompass.SetOuterBevelWidth          (const Value:Integer);begin SetIntegerProperty(Value,FOuterBevelWidth,          irtBackGround);end;
procedure TiCompass.SetOuterMargin              (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin,              irtBackGround);end;
procedure TiCompass.SetScaleBackGroundColor     (const Value:TColor );begin SetColorProperty  (Value,FScaleBackGroundColor,     irtBackGround);end;
procedure TiCompass.SetTickLabelInnerMargin     (const Value:Integer);begin SetIntegerProperty(Value,FTickLabelInnerMargin,     irtBackGround);end;
procedure TiCompass.SetTickLabelOuterMargin     (const Value:Integer);begin SetIntegerProperty(Value,FTickLabelOuterMargin,     irtBackGround);end;
procedure TiCompass.SetTickColor                (const Value:TColor );begin SetColorProperty  (Value,FTickColor,                irtBackGround);end;
procedure TiCompass.SetTickLength               (const Value:Integer);begin SetIntegerProperty(Value,FTickLength,               irtBackGround);end;
procedure TiCompass.SetTickWidth                (const Value:Integer);begin SetIntegerProperty(Value,FTickWidth,                irtBackGround);end;
procedure TiCompass.SetTickMargin               (const Value:Integer);begin SetIntegerProperty(Value,FTickMargin,               irtBackGround);end;
procedure TiCompass.SetDirectionDisplayPrecision(const Value:Integer);begin SetIntegerProperty(Value,FDirectionDisplayPrecision,irtInvalidate);end;
procedure TiCompass.SetShowDirectionDisplay     (const Value:Boolean);begin SetBooleanProperty(Value,FShowDirectionDisplay,     irtInvalidate);end;
procedure TiCompass.SetNCaption                 (const Value:String );begin SetStringProperty (Value,FNCaption,                 irtBackGround);end;
procedure TiCompass.SetNWCaption                (const Value:String );begin SetStringProperty (Value,FNWCaption,                irtBackGround);end;
procedure TiCompass.SetWCaption                 (const Value:String );begin SetStringProperty (Value,FWCaption,                 irtBackGround);end;
procedure TiCompass.SetSWCaption                (const Value:String );begin SetStringProperty (Value,FSWCaption,                irtBackGround);end;
procedure TiCompass.SetSCaption                 (const Value:String );begin SetStringProperty (Value,FSCaption,                 irtBackGround);end;
procedure TiCompass.SetSECaption                (const Value:String );begin SetStringProperty (Value,FSECaption,                irtBackGround);end;
procedure TiCompass.SetECaption                 (const Value:String );begin SetStringProperty (Value,FECaption,                 irtBackGround);end;
procedure TiCompass.SetNECaption                (const Value:String );begin SetStringProperty (Value,FNECaption,                irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiCompass.SetTickLabelFont       (const Value:TFont);begin FTickLabelFont.Assign(Value);       end;
procedure TiCompass.SetDirectionDisplayFont(const Value:TFont);begin FDirectionDisplayFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiCompass.SetDirection(const Value :Double);
var
  CanEdit : Boolean;
begin
  if FDirection <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Direction', CanEdit);
      if CanEdit then
        begin
          FDirection := Value;
          InvalidateChange;
          DoChange;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCompass.SetPointerStyle(const Value: TiCompassPointerStyle);
begin
  if FPointerStyle <> Value then
    begin
      FPointerStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCompass.SetPointerSize(const Value: Integer);
begin
  if FPointerSize <> Value then
    begin
      FPointerSize := Value;
      if FPointerSize < 1 then FPointerSize := 1;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiCompass.iPaintTo(Canvas: TCanvas);
var
  CenterPoint : TPoint;
  OuterRect   : TRect;
  OuterRadius : Integer;
begin
  CenterPoint := GetCenterPoint(Canvas);

  Canvas.Font.Assign(TickLabelFont);
  FKnobRadius := Width div 2 - OuterMargin - OuterBevelWidth - TickMargin - TickLength - TickLabelInnerMargin - TickLabelOuterMargin - Canvas.TextWidth('N');

  if CachedDrawing then
    begin
      if BackGroundChanged then
        begin
          CreateBackGroundBitmap;
          DrawBackGround(BackGroundBitmap.Canvas, BackGroundColor);

          OuterRadius := (Width - 1 - 2*FOuterMargin) div 2;
          DrawGradientCircle(BackGroundBitmap.Canvas, clWhite, ColorToRGB(clBtnFace) and $FFFFFF - $505050, CenterPoint, OuterRadius, True);

          BackGroundBitmap.Canvas.Brush.Style := bsSolid;
          BackGroundBitmap.Canvas.Brush.Color := ScaleBackGroundColor;
          BackGroundBitmap.Canvas.Pen.Color   := ScaleBackGroundColor;

          OuterRect := Rect(CenterPoint.X - OuterRadius + FOuterBevelWidth, CenterPoint.Y - OuterRadius + FOuterBevelWidth,
                            CenterPoint.X + OuterRadius - FOuterBevelWidth, CenterPoint.Y + OuterRadius - FOuterBevelWidth);
          BackGroundBitmap.Canvas.Ellipse(OuterRect.Left, OuterRect.Top, OuterRect.Right, OuterRect.Bottom);

          OuterRect    := Rect(CenterPoint.X - FKnobRadius, CenterPoint.Y - FKnobRadius,
                               CenterPoint.X + FKnobRadius, CenterPoint.Y + FKnobRadius);

          DrawGradientCircle(BackGroundBitmap.Canvas, clWhite, ColorToRGB(clBtnFace) and $FFFFFF - $505050, CenterPoint, FKnobRadius, False);

          DrawTicks   (CenterPoint, BackGroundBitmap.Canvas);
          ResetBackGroundChange;
        end;

      TransferBackGround  (Canvas);
      DrawIndicator       (CenterPoint, Canvas);
      DrawDirectionDisplay(Canvas);
    end
  else
    begin
      DrawBackGround(Canvas, BackGroundColor);
      OuterRadius := (Width - 1 - 2*FOuterMargin) div 2;
      DrawGradientCircle(Canvas, clWhite, ColorToRGB(clBtnFace) and $FFFFFF - $505050, CenterPoint, OuterRadius, True);

      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := ScaleBackGroundColor;
      Canvas.Pen.Color   := ScaleBackGroundColor;

      OuterRect := Rect(CenterPoint.X - OuterRadius + FOuterBevelWidth, CenterPoint.Y - OuterRadius + FOuterBevelWidth,
                        CenterPoint.X + OuterRadius - FOuterBevelWidth, CenterPoint.Y + OuterRadius - FOuterBevelWidth);
      Canvas.Ellipse(OuterRect.Left, OuterRect.Top, OuterRect.Right, OuterRect.Bottom);

      OuterRect    := Rect(CenterPoint.X - FKnobRadius, CenterPoint.Y - FKnobRadius,
                               CenterPoint.X + FKnobRadius, CenterPoint.Y + FKnobRadius);

      DrawGradientCircle(Canvas, clWhite, ColorToRGB(clBtnFace) and $FFFFFF - $505050, CenterPoint, FKnobRadius, False);

      DrawTicks           (CenterPoint, Canvas);
      DrawIndicator       (CenterPoint, Canvas);
      DrawDirectionDisplay(Canvas);
    end;
end;
//****************************************************************************************************************************************************
procedure TiCompass.DrawTicks(const OffsetPoint: TPoint; Canvas: TCanvas);
var
  OuterPoint   : TPoint;
  InnerPoint   : TPoint;
  MajorRadius1 : Double;
  MajorRadius2 : Double;
  TextRadius   : Double;
  TextRect1    : TRect;
  TextPoint    : TPoint;
  TextString   : String;
  x            : Integer;
  DegreeMajor  : Double;
  Point1       : TPoint;
  Point2       : TPoint;
  Point3       : TPoint;
  Point4       : TPoint;
begin
  with Canvas do
    begin
      Brush.Style := bsClear;

      MajorRadius1 := FKnobRadius + TickMargin - 1;
      MajorRadius2 := FKnobRadius + TickMargin + TickLength;

      Font.Assign(TickLabelFont);

      for x := 0 to 7 do
        begin
          DegreeMajor := 360 / 8 * x + 90;
          //------------------------------------------------------------------------------------------------------------------------------------------
          Pen.Color   := TickColor;
          Brush.Color := TickColor;
          Brush.Style := bsSolid;
          OuterPoint := GetXYRadPoint(DegreeMajor, MajorRadius1, OffsetPoint);
          Point1     := GetXYRadPoint(DegreeMajor -90, FTickWidth/2, OuterPoint);
          Point2     := GetXYRadPoint(DegreeMajor +90, FTickWidth/2, OuterPoint);

          InnerPoint := GetXYRadPoint(DegreeMajor, MajorRadius2, OffsetPoint);
          Point3     := GetXYRadPoint(DegreeMajor -90, FTickWidth/2, InnerPoint);
          Point4     := GetXYRadPoint(DegreeMajor +90, FTickWidth/2, InnerPoint);

          Polygon([Point1, Point2, Point4, Point3]);

          //------------------------------------------------------------------------------------------------------------------------------------------
          case x of
            0 : TextString := FNCaption;
            1 : TextString := FNWCaption;
            2 : TextString := FWCaption;
            3 : TextString := FSWCaption;
            4 : TextString := FSCaption;
            5 : TextString := FSECaption;
            6 : TextString := FECaption;
            7 : TextString := FNECaption;
          end;

          if Assigned(FOnCustomizeTickLabel) then FOnCustomizeTickLabel(Self, x, TextString);

          Brush.Style := bsClear;
          TextRadius  := MajorRadius2 + TickLabelInnerMargin + 4;
          TextPoint   := GetXYRadPoint(DegreeMajor, TextRadius, OffsetPoint);

          TextRect1   := Rect(TextPoint.x - TextWidth (TextString) div 2,
                              TextPoint.y - TextHeight(TextString) div 2,
                              TextPoint.x + TextWidth (TextString) div 2,
                              TextPoint.y + TextHeight(TextString) div 2);

          TextOut(TextPoint.x - TextWidth (TextString) div 2, TextPoint.y - TextHeight(TextString) div 2, TextString);
        end;
          //------------------------------------------------------------------------------------------------------------------------------------------
    end;
end;
//****************************************************************************************************************************************************
procedure TiCompass.DrawIndicator(const OffsetPoint: TPoint; Canvas: TCanvas);
var
  PointerEndPoint   : TPoint;
  PointerBasePoint  : TPointDouble;
  Point1            : TPoint;
  Point2            : TPoint;
  Point3            : TPoint;
  Point4            : TPoint;
  OuterPoint        : TPoint;
  InnerPoint        : TPoint;
  ActualAngle       : Double;
  OffsetPointDouble : TPointDouble;
  Point1Double      : TPointDouble;
  Point2Double      : TPointDouble;
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := FPointerColor;
      Pen.Color   := FPointerColor;

      ActualAngle := -FDirection + 90;

      case FPointerStyle of
        icpsTriangle : begin
                         OffsetPointDouble.X := OffsetPoint.X;
                         OffsetPointDouble.Y := OffsetPoint.Y;
                         PointerEndPoint     := GetXYRadPoint(ActualAngle, FKnobRadius + FPointerMargin + FPointerSize, OffsetPoint);

                         PointerBasePoint    := GetXYRadPointDouble(ActualAngle, FKnobRadius + FPointerMargin, OffsetPointDouble);
                         Point1Double        := GetXYRadPointDouble(ActualAngle + 90, FPointerSize/2, PointerBasePoint);
                         Point2Double        := GetXYRadPointDouble(ActualAngle - 90, FPointerSize/2, PointerBasePoint);

                         Point1              := Point(Round(Point1Double.X), Round(Point1Double.Y));
                         Point2              := Point(Round(Point2Double.X), Round(Point2Double.Y));

                         Polygon([Point1, Point2, PointerEndPoint]);
                        end;
        icpsCircle   : begin
                         PointerEndPoint := GetXYRadPoint(ActualAngle, FKnobRadius + FPointerMargin + FPointerSize div 2, OffsetPoint);
                         Ellipse(PointerEndPoint.X - FPointerSize div 2, PointerEndPoint.Y - FPointerSize div 2,
                                 PointerEndPoint.X + FPointerSize div 2, PointerEndPoint.Y + FPointerSize div 2);
                       end;
        icpsLine     : begin
                         OuterPoint := GetXYRadPoint(ActualAngle, FKnobRadius + FPointerMargin + FPointerSize, OffsetPoint);
                         Point1     := GetXYRadPoint(ActualAngle -90, FTickWidth/2, OuterPoint);
                         Point2     := GetXYRadPoint(ActualAngle +90, FTickWidth/2, OuterPoint);

                         InnerPoint := GetXYRadPoint(ActualAngle, FKnobRadius + FPointerMargin, OffsetPoint);
                         Point3     := GetXYRadPoint(ActualAngle -90, FTickWidth/2, InnerPoint);
                         Point4     := GetXYRadPoint(ActualAngle +90, FTickWidth/2, InnerPoint);

                         Polygon([Point1, Point2, Point4, Point3]);
                       end;
      end;

    end;
end;
//****************************************************************************************************************************************************
procedure TiCompass.DrawDirectionDisplay(Canvas: TCanvas);
var
  CenterPoint : TPoint;
  TextString  : String;
  x, y        : Integer;
begin
  if not FShowDirectionDisplay then Exit;
  CenterPoint := GetCenterPoint(Canvas);
  with Canvas do
    begin
      Brush.Style := bsClear;
      Font.Assign(FDirectionDisplayFont);
      TextString := Trim(Format('%.' + IntToStr(FDirectionDisplayPrecision) + 'f',[Direction]));

      y := CenterPoint.y - TextHeight(TextString) div 2;
      x := CenterPoint.x - TextWidth(TextString ) div 2;

      TextOut(x, y, TextString);
    end;
end;
//****************************************************************************************************************************************************
end.
