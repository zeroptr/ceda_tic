{*******************************************************}
{                                                       }
{       TiThermometer Component                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iThermometer;{$endif}
{$ifdef iCLX}unit QiThermometer;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iClasses,  iGPFunctions,  iScaleComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiClasses, QiGPFunctions, QiScaleComponent;{$ENDIF}

type
  TiThermometerIndicatorStyle = (itisBulb, itisBar, itisBarSunken, itisBarRaised);

  TiThermometer = class(TiScaleComponent)
  private
    FBarRect                     : TRect;
    FCenterPoint                 : TPoint;

    FIndicatorColor              : TColor;
    FIndicatorWidth              : Integer;
    FOrientation                 : TiOrientation;
    FOrientationTickMarks        : TiOrientationSide;
    FEndsMargin                  : Integer;
    FIndicatorBulbSize           : Integer;
    FIndicatorBackGroundColor    : TColor;
    FIndicatorClickRect          : TRect;

    FCurrentMaxRect              : TRect;
    FCurrentMinRect              : TRect;
    FMovingMin                   : Boolean;
    FMovingMax                   : Boolean;
    FMovingPointer               : Boolean;
    FMouseDownX                  : Integer;
    FMouseDownY                  : Integer;
    FOldCurrentValue             : Double;

    FIndicatorStyle              : TiThermometerIndicatorStyle;
    FAutoCenter                  : Boolean;
    FReverseScale                : Boolean;
    FIndicatorFillReferenceStyle : TiPointerFillReferenceStyle;
    FIndicatorFillReferenceValue : Double;
    FIndicatorUserCanMove        : Boolean;
    FOnAutoSize                  : TNotifyEvent;

    procedure SetOrientationTickMarks       (const Value: TiOrientationSide);
    procedure SetOrientation                (const Value: TiOrientation);
    procedure SetEndsMargin                 (const Value: Integer);
    procedure SetIndicatorWidth             (const Value: Integer);
    procedure SetIndicatorColor             (const Value: TColor);
    procedure SetIndicatorBulbSize          (const Value: Integer);
    procedure SetIndicatorBackGroundColor   (const Value: TColor);
    procedure SetIndicatorStyle             (const Value: TiThermometerIndicatorStyle);
    procedure SetAutoCenter                 (const Value: Boolean);
    procedure SetReverseScale               (const Value: Boolean);
    procedure SetIndicatorFillReferenceStyle(const Value: TiPointerFillReferenceStyle);
    procedure SetIndicatorFillReferenceValue(const Value: Double);

    function GetPixelsMin : Integer;
    function GetPixelsMax : Integer;
  protected
    procedure DrawTicks        (Canvas: TCanvas);
    procedure DrawIndicatorBulb(Canvas: TCanvas);
    procedure DrawIndicatorBox (Canvas: TCanvas);
    procedure DrawLimits       (Canvas: TCanvas);
    procedure DrawPointer      (Canvas: TCanvas; Position: Double; Margin, Size: Integer; DrawScaleSide: Boolean; AColor: TColor; var PositionRect: TRect);

    procedure iPaintTo(Canvas: TCanvas);                                            override;
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  override;
    procedure iMouseMove(                      Shift : TShiftState; X, Y: Integer); override;
    procedure CalcPoints;

    function  GetCenterPoint(Canvas: TCanvas): TPoint;                              override;
    function  GetPositionPixels(Value : Double) : Integer;
    function  GetTravelRange : Integer;

    property OnAutoSize                  : TNotifyEvent                read FOnAutoSize                  write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent); override;

    property PixelsMin                   : Integer                     read GetPixelsMin;
    property PixelsMax                   : Integer                     read GetPixelsMax;
  published
    property IndicatorWidth              : Integer                     read FIndicatorWidth              write SetIndicatorWidth           default 2;
    property IndicatorBulbSize           : Integer                     read FIndicatorBulbSize           write SetIndicatorBulbSize        default 6;
    property IndicatorStyle              : TiThermometerIndicatorStyle read FIndicatorStyle              write SetIndicatorStyle           default itisBulb;
    property EndsMargin                  : Integer                     read FEndsMargin                  write SetEndsMargin               default 10;
    property IndicatorColor              : TColor                      read FIndicatorColor              write SetIndicatorColor           default clRed;
    property IndicatorBackGroundColor    : TColor                      read FIndicatorBackGroundColor    write SetIndicatorBackGroundColor default clMaroon;
    property Orientation                 : TiOrientation               read FOrientation                 write SetOrientation              default ioVertical;
    property OrientationTickMarks        : TiOrientationSide           read FOrientationTickMarks        write SetOrientationTickMarks     default iosBottomRight;
    property AutoCenter                  : Boolean                     read FAutoCenter                  write SetAutoCenter               default True;
    property ReverseScale                : Boolean                     read FReverseScale                write SetReverseScale             default False;

    property IndicatorFillReferenceStyle : TiPointerFillReferenceStyle read FIndicatorFillReferenceStyle write SetIndicatorFillReferenceStyle;
    property IndicatorFillReferenceValue : Double                      read FIndicatorFillReferenceValue write SetIndicatorFillReferenceValue;
    property IndicatorUserCanMove        : Boolean                     read FIndicatorUserCanMove        write FIndicatorUserCanMove       default False;

    property BackGroundColor;
    property BorderStyle;
    property OffsetX;
    property OffsetY;
    property CachedDrawing;
    property Transparent;
    property ShowDisabledState;

    property ShowTicksMajor;
    property ShowTicksMinor;
    property ShowTickLabels;
    property TickMajorCount;
    property TickMajorColor;
    property TickMajorLength          default 10;
    property TickMajorStyle;
    property TickMinorAlignment;
    property TickMinorCount;
    property TickMinorColor;
    property TickMinorLength          default 6;
    property TickMinorStyle;
    property TickMargin               default 8;
    property TickLabelMargin;
    property TickLabelFont;
    property TickLabelPrecision;
    property PrecisionStyle;
    property OnCustomizeTickLabel;

    property ShowTicksMajorFirstLast;
    property ShowMaxPointer;
    property ShowMinPointer;
    property MinMaxPointerSize;
    property MinMaxPointerMargin      default 5;
    property MaxPointerColor;
    property MinPointerColor;
    property BackGroundPicture;
    property MinMaxUserCanMove;

    property AutoScaleEnabled;
    property AutoScaleDesiredTicks;
    property AutoScaleMaxTicks;
    property AutoScaleStyle;
    property Width                    default 100;
    property Height                   default 150;
  end;

implementation
//*************************************************************************************************************************************
constructor TiThermometer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width               := 100;
  Height              := 150;
  TickMajorLength     := 10;
  TickMinorLength     := 6;
  TickMargin          := 8;
  MinMaxPointerMargin := 5;

  FEndsMargin               := 10;
  FAutoCenter               := True;

  FIndicatorWidth           := 2;
  FIndicatorColor           := clRed;
  FIndicatorBulbSize        := 6;
  FIndicatorBackGroundColor := clMaroon;

  CreateBackGroundPicture;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.SetIndicatorWidth             (const Value:Integer);begin SetIntegerProperty(Value,FIndicatorWidth,             irtBackGround);end;
procedure TiThermometer.SetIndicatorColor             (const Value:TColor); begin SetColorProperty  (Value,FIndicatorColor,             irtBackGround);end;
procedure TiThermometer.SetEndsMargin                 (const Value:Integer);begin SetIntegerProperty(Value,FEndsMargin,                 irtBackGround);end;
procedure TiThermometer.SetAutoCenter                 (const Value:Boolean);begin SetBooleanProperty(Value,FAutoCenter,                 irtBackGround);end;
procedure TiThermometer.SetIndicatorBulbSize          (const Value:Integer);begin SetIntegerProperty(Value,FIndicatorBulbSize,          irtBackGround);end;
procedure TiThermometer.SetIndicatorBackGroundColor   (const Value:TColor); begin SetColorProperty  (Value,FIndicatorBackGroundColor,   irtBackGround);end;
procedure TiThermometer.SetReverseScale               (const Value:Boolean);begin SetBooleanProperty(Value,FReverseScale,               irtBackGround);end;
procedure TiThermometer.SetIndicatorFillReferenceValue(const Value:Double );begin SetDoubleProperty (Value,FIndicatorFillReferenceValue,irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiThermometer.SetOrientationTickMarks(const Value: TiOrientationSide);
begin
  if FOrientationTickMarks<>Value then
    begin
      FOrientationTickMarks := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.SetIndicatorStyle(const Value: TiThermometerIndicatorStyle);
begin
  if FIndicatorStyle <> Value then
    begin
      FIndicatorStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.SetOrientation(const Value: TiOrientation);
var
  TempWidth : Integer;
begin
  if FOrientation <> Value then
    begin
      FOrientation := Value;
      if not Loading then
        begin
          TempWidth := Width;
          Width     := Height;
          Height    := TempWidth;
          if Assigned(FOnAutoSize) then FOnAutoSize(Self);
        end;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.SetIndicatorFillReferenceStyle(const Value: TiPointerFillReferenceStyle);
begin
  if FIndicatorFillReferenceStyle <> Value then
    begin
      FIndicatorFillReferenceStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
function TiThermometer.GetPositionPixels(Value: Double): Integer;
begin
  with FBarRect do
    case FOrientation of
      ioVertical   : begin
                       case FReverseScale and (FIndicatorStyle <> itisBulb) of
                         False : Result := Bottom - Round((Bottom - Top) * ValuePercent(Value));
                         else    Result := Top    + Round((Bottom - Top) * ValuePercent(Value));
                       end;
                     end;
      else           begin
                       case FReverseScale and (FIndicatorStyle <> itisBulb) of
                         False : Result := Left  + Round((Right - Left) * ValuePercent(Value));
                         else    Result := Right - Round((Right - Left) * ValuePercent(Value));
                       end;
                     end;
    end;
end;
//****************************************************************************************************************************************************
function TiThermometer.GetTravelRange : Integer;
var
  DrawRect : TRect;
begin
  DrawRect := Rect(0, 0 ,Width, Height);
  with DrawRect do
    case Forientation of
      ioHorizontal : Result := Right  - Left - (2 * FEndsMargin);
      ioVertical   : Result := Bottom - Top  - (2 * FEndsMargin);
      else           Result := 0;
    end;

  case
    FIndicatorStyle of
      itisBulb : Result := Result - 2*FIndicatorBulbSize;
      itisBar  : Result := Result;
      else       Result := Result - 2;
  end;

end;
//****************************************************************************************************************************************************
function TiThermometer.GetCenterPoint(Canvas: TCanvas): TPoint;
var
  OldPoint            : TPoint;
  MaxTextWidth        : Integer;
  TotalWidth          : Integer;
  ATextWidth          : Integer;
  MaxPointerWidth     : Integer;
  CurrentPointerWidth : Integer;
  x                   : Integer;
begin
  Result := inherited GetCenterPoint(Canvas);
  if not FAutoCenter then exit;
  OldPoint := Result;

  if ShowTickLabels then
    begin
      with Canvas do
        begin
          Canvas.Font  := TickLabelFont;
          case Orientation of
            ioVertical   : begin
                             MaxTextWidth := TextWidth(Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMin])));
                             ATextWidth   := TextWidth(Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMax])));
                           end;
            else           begin
                             MaxTextWidth := TextHeight(Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMin])));
                             ATextWidth   := TextHeight(Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMax])));
                           end;
          end;
          if ATextWidth > MaxTextWidth then MaxTextWidth := ATextWidth;
          MaxTextWidth := MaxTextWidth + TickLabelMargin;
        end;
    end
  else MaxTextWidth := 0;

  TotalWidth := MaxTextWidth - FIndicatorWidth;

  MaxPointerWidth := 0;

  if ShowMaxPointer or ShowMinPointer then
    begin
      CurrentPointerWidth := MinMaxPointerMargin + MinMaxPointerSize;
      if CurrentPointerWidth > MaxPointerWidth then MaxPointerWidth := CurrentPointerWidth;
    end;

  for x := 0 to LimitCount - 1 do
    begin
      if LimitShowUpperPointer[x] or LimitShowLowerPointer[x] then
        begin
          CurrentPointerWidth := LimitPointerMargin[x] + LimitPointerSize[x];
          if CurrentPointerWidth > MaxPointerWidth then MaxPointerWidth := CurrentPointerWidth;
        end;
    end;

  TotalWidth := TotalWidth - MaxPointerWidth;

  if ShowTicksMajor then TotalWidth := TotalWidth + TickMajorLength + TickMargin;

  case Orientation of
    ioVertical   : case OrientationTickMarks of
                     iosBottomRight : Result := Point(OldPoint.x - (TotalWidth div 2), OldPoint.y);
                     iosTopLeft     : Result := Point(OldPoint.x + (TotalWidth div 2), OldPoint.y);
                   end;
    ioHorizontal : case OrientationTickMarks of
                     iosBottomRight : Result := Point(OldPoint.x, OldPoint.y - (TotalWidth div 2));
                     iosTopLeft     : Result := Point(OldPoint.x, OldPoint.y + (TotalWidth div 2));
                   end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.CalcPoints;
var
  ClientRect  : TRect;
begin
  ClientRect   := Rect(0, 0, Width, Height);
  FCenterPoint := GetCenterPoint(Canvas);
  with ClientRect do
      case FOrientation of
        ioVertical   : begin
                         FBarRect := Rect(FCenterPoint.X - FIndicatorWidth, Top    + FEndsMargin + OffsetY,
                                          FCenterPoint.X + FIndicatorWidth, Bottom - FEndsMargin + OffsetY);
                         with FBarRect do
                           case
                             FIndicatorStyle of
                               itisBulb : FBarRect := Rect(Left, Top,     Right, Bottom - 2*FIndicatorBulbSize);
                               itisBar  : FBarRect := FBarRect;
                               else       FBarRect := Rect(Left, Top + 2, Right, Bottom - 2);
                           end;
                       end;
        ioHorizontal : begin
                         FBarRect := Rect(Left  + FEndsMargin + OffsetX, FCenterPoint.Y - FIndicatorWidth,
                                          Right - FEndsMargin + OffsetX, FCenterPoint.Y + FIndicatorWidth);
                         with FBarRect do
                           case FIndicatorStyle of
                             itisBulb : FBarRect := Rect(Left  + 2*FIndicatorBulbSize, Top, Right,   Bottom);
                             itisBar  : FBarRect := FBarRect;
                             else       FBarRect := Rect(Left  + 2,                    Top, Right-2, Bottom);
                           end;
                       end;
      end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.iPaintTo(Canvas: TCanvas);
begin
  CalcPoints;
  if CachedDrawing then
    begin
      if BackGroundChanged then
        begin
          CreateBackGroundBitmap;
          DrawBackGround(BackGroundBitmap.Canvas, BackGroundColor);
          DrawTicks     (BackGroundBitmap.Canvas);
          ResetBackGroundChange;
        end;

      TransferBackGround(Canvas);

      case FIndicatorStyle of
        itisBulb : DrawIndicatorBulb(Canvas);
        else       DrawIndicatorBox (Canvas);
      end;

      if ShowMaxPointer then DrawPointer(Canvas, CurrentMax, MinMaxPointerMargin, MinMaxPointerSize, False, MaxPointerColor, FCurrentMaxRect);
      if ShowMinPointer then DrawPointer(Canvas, CurrentMin, MinMaxPointerMargin, MinMaxPointerSize, False, MinPointerColor, FCurrentMinRect);

      DrawLimits(Canvas);
    end
  else
    begin
      DrawBackGround(Canvas, BackGroundColor);
      DrawTicks     (Canvas);

      case FIndicatorStyle of
        itisBulb : DrawIndicatorBulb(Canvas);
        else       DrawIndicatorBox (Canvas);
      end;

      if ShowMaxPointer then DrawPointer(Canvas, CurrentMax, MinMaxPointerMargin, MinMaxPointerSize, False, MaxPointerColor, FCurrentMaxRect);
      if ShowMinPointer then DrawPointer(Canvas, CurrentMin, MinMaxPointerMargin, MinMaxPointerSize, False, MinPointerColor, FCurrentMinRect);

      DrawLimits(Canvas);
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.DrawIndicatorBulb(Canvas: TCanvas);
var
  BulbCenterPoint : TPoint;
  BulbRect        : TRect;
  BulbRefRect     : TRect;
  PositionLength  : Integer;
  BarRect         : TRect;
  IndicatorRect   : TRect;
begin
  BarRect := FBarRect;
  with Canvas do
    begin
      Brush.Color := FIndicatorColor;
      Brush.Style := bsSolid;
      Pen.Color := FIndicatorColor;
      case FOrientation of
        ioVertical   : begin
                         with BarRect do
                           begin
                             BulbCenterPoint := Point(FCenterPoint.X, Bottom + FIndicatorBulbSize);
                             with BulbCenterPoint do
                               begin
                                 BulbRect    := Rect(X-IndicatorBulbSize,         Y-IndicatorBulbSize,         X+IndicatorBulbSize,         Y+IndicatorBulbSize);
                                 BulbRefRect := Rect(X-(IndicatorBulbSize*2)div 5,Y-(IndicatorBulbSize*2)div 5,X+(IndicatorBulbSize*2)div 5,Y+(IndicatorBulbSize*2)div 5);
                                 OffsetRect(BulbRect,    0, -1);
                                 OffsetRect(BulbRefRect, 0, -1);
                               end;
                             IndicatorRect := Rect(Left, Top, Right, Bottom+1);
                           end;

                         FIndicatorClickRect        := IndicatorRect;
                         FIndicatorClickRect.Bottom := FIndicatorClickRect.Bottom + IndicatorBulbSize;

                         with BulbRect do
                           begin
                             Ellipse(Left, Top, Right, Bottom);
                             Pen.Color := clBtnFace;  Arc(Left, Top, Right, Bottom, (Right + Left) div 2, Top, Left, Bottom);
                             Pen.Color := clBtnShadow;Arc(Left, Top, Right, Bottom, Left, Bottom, (Right + Left) div 2, Top);
                             BulbRect  := Rect(Left - 1, Top - 1, Right + 1, Bottom + 1);
                             Pen.Color := clBtnHighlight; Arc(Left, Top, Right, Bottom, (Right + Left) div 2, Top, Left, Bottom);
                             Pen.Color := clBtnShadow; Arc(Left, Top, Right, Bottom, Left, Bottom, (Right + Left) div 2, Top);

                             with BulbRefRect do
                               begin
                                 Pen.Color   := clWhite;
                                 Arc(Left, Top, Right, Bottom, (Right + Left) div 2, Top, Left, (Top + Bottom) div 2);
                                 BulbRefRect := Rect(Left - 1, Top - 1, Right + 1, Bottom + 1);
                                 Arc(Left, Top, Right, Bottom, (Right + Left) div 2, Top, Left, (Top + Bottom) div 2);
                               end;
                           end;


                         with IndicatorRect do
                           begin
                             Pen.Color   := FIndicatorBackGroundColor;
                             Brush.Color := FIndicatorBackGroundColor;
                             Ellipse(Left, Top, Right, Top + 2*FIndicatorWidth);     //Indicator BackGround Rounded Top
                             Rectangle(Left, Top + FIndicatorWidth, Right, Bottom);  //Indicator BackGround Rectangle

                             PositionLength := Round((Bottom - Top)*ValuePercent(Position));
                             IndicatorRect  := Rect(Left , Bottom - PositionLength, Right, Bottom);
                             Pen.Color      := FIndicatorColor;
                             Brush.Color    := FIndicatorColor;
                             Ellipse(Left, Top, Right, Top + 2*FIndicatorWidth);    //Indicator BackGround Rounded Top
                             Rectangle(Left, Top + FIndicatorWidth, Right, Bottom); //Indicator BackGround Rectangle
                           end;
                       end;
        ioHorizontal : begin
                         with BarRect do
                           begin
                             BulbCenterPoint := Point(Left - FIndicatorBulbSize, FCenterPoint.Y);
                             with BulbCenterPoint do
                               begin
                                 BulbRect         := Rect(X - IndicatorBulbSize, Y  - IndicatorBulbSize, X + IndicatorBulbSize, Y + IndicatorBulbSize);
                                 BulbRefRect      := Rect(X - (IndicatorBulbSize*2)div 5, Y  - (IndicatorBulbSize*2)div 5, X + (IndicatorBulbSize*2)div 5, Y + (IndicatorBulbSize*2)div 5);
                                 OffsetRect(BulbRect,    0, +1);
                                 OffsetRect(BulbRefRect, 0, +1);
                               end;
                             IndicatorRect := Rect(Left, Top, Right + 1, Bottom);
                           end;

                         FIndicatorClickRect      := IndicatorRect;
                         FIndicatorClickRect.Left := FIndicatorClickRect.Left - IndicatorBulbSize;

                         with BulbRect do
                           begin
                             Ellipse(Left, Top, Right, Bottom);
                             Pen.Color := clBtnFace;     Arc(Left, Top, Right, Bottom, (Right + Left) div 2, Top, Left, Bottom);
                             Pen.Color := clBtnShadow;   Arc(Left, Top, Right, Bottom, Left, Bottom, (Right + Left) div 2, Top);
                             BulbRect  := Rect(Left - 1, Top - 1, Right + 1, Bottom + 1);
                             Pen.Color := clBtnHighlight;Arc(Left, Top, Right, Bottom, (Right + Left) div 2, Top, Left, Bottom);
                             Pen.Color := clBtnShadow;   Arc(Left, Top, Right, Bottom, Left, Bottom, (Right + Left) div 2, Top);

                             with BulbRefRect do
                               begin
                                 Pen.Color   := clWhite;
                                 Arc(Left, Top, Right, Bottom, (Right + Left) div 2, Top, Left, (Top + Bottom) div 2);
                                 BulbRefRect := Rect(Left - 1, Top - 1, Right + 1, Bottom + 1);
                                 Arc(Left, Top, Right, Bottom, (Right + Left) div 2, Top, Left, (Top + Bottom) div 2);
                               end;
                           end;


                         with IndicatorRect do
                           begin
                             Pen.Color   := FIndicatorBackGroundColor;
                             Brush.Color := FIndicatorBackGroundColor;
                             Ellipse(Right -2*FIndicatorWidth, Top, Right, Bottom);  //Indicator BackGround Rounded Top
                             Rectangle(Left, Top, Right - FIndicatorWidth, Bottom);  //Indicator BackGround Rectangle

                             PositionLength := Round((Right - Left)*ValuePercent(Position));
                             IndicatorRect  := Rect(Left , Top, Left + PositionLength, Bottom);
                             Pen.Color      := FIndicatorColor;
                             Brush.Color    := FIndicatorColor;
                             Ellipse(Right -2*FIndicatorWidth, Top, Right, Bottom); //Indicator BackGround Rounded Top
                             Rectangle(Left, Top, Right - FIndicatorWidth, Bottom); //Indicator BackGround Rectangle
                           end;
                       end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.DrawIndicatorBox(Canvas: TCanvas);
var
  BarRect        : TRect;
  PixelsStart    : Integer;
  PixelsPosition : Integer;
begin
  BarRect := FBarRect;
  with Canvas, BarRect do
    begin
      Brush.Color := FIndicatorColor;
      Pen.Color   := FIndicatorColor;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;

      case FIndicatorFillReferenceStyle of
        ipfrsMin   : PixelsStart := GetPositionPixels(PositionMin);
        ipfrsMax   : PixelsStart := GetPositionPixels(PositionMax);
        else         PixelsStart := GetPositionPixels(FIndicatorFillReferenceValue);
      end;

      PixelsPosition := GetPositionPixels(Position);

      Pen.Color   := FIndicatorBackGroundColor;
      Brush.Color := FIndicatorBackGroundColor;

      Rectangle(Left, Top, Right, Bottom);

      FIndicatorClickRect := BarRect;

      case FIndicatorStyle of
        itisBarRaised : iDraw.Border(Canvas, BarRect, 2, ibsRaised);
        itisBarSunken : iDraw.Border(Canvas, BarRect, 2, ibsLowered);
      end;

      Pen.Color      := FIndicatorColor;
      Brush.Color    := FIndicatorColor;

      case FOrientation of
        ioVertical   : Rectangle(Left, PixelsPosition, Right, PixelsStart);
        ioHorizontal : Rectangle(PixelsStart, Top, PixelsPosition, Bottom);
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.DrawTicks(Canvas: TCanvas);
var
  AShowEnabled : Boolean;
begin
  ScaleObject.PositionMax          := PositionMax;            
  ScaleObject.PositionMin          := PositionMin;
  ScaleObject.Orientation          := FOrientation;
  ScaleObject.OrientationTickMarks := FOrientationTickMarks;

  ScaleObject.ReverseScale := FReverseScale;

  case FOrientation of
    ioVertical   : begin
                     ScaleObject.Start := FBarRect.Bottom;
                     ScaleObject.Stop  := FBarRect.Top;
                     ScaleObject.Edge  := FCenterPoint.X;
                   end;
    ioHorizontal : begin
                     ScaleObject.Start := FBarRect.Left;
                     ScaleObject.Stop  := FBarRect.Right;
                     ScaleObject.Edge  := FCenterPoint.Y;
                   end;
  end;

  if      not ShowDisabledState then AShowEnabled  := True
  else if not Enabled then           AShowEnabled  := False
  else                               AShowEnabled  := True;

  ScaleObject.Draw(Canvas, AShowEnabled, BackGroundColor);
end;
//****************************************************************************************************************************************************
procedure TiThermometer.DrawLimits(Canvas: TCanvas);
var
  x         : Integer;
  DummyRect : TRect;
begin
  for x := 0 to LimitCount -1 do
    begin
      if LimitShowUpperPointer[x] then DrawPointer(Canvas, LimitUpperValue[x], LimitPointerMargin[x], LimitPointerSize[x], LimitDrawScaleSide[x], LimitUpperPointerColor[x], DummyRect);
      if LimitShowLowerPointer[x] then DrawPointer(Canvas, LimitLowerValue[x], LimitPointerMargin[x], LimitPointerSize[x], LimitDrawScaleSide[x], LimitLowerPointerColor[x], DummyRect);
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.DrawPointer(Canvas: TCanvas; Position: Double; Margin, Size: Integer; DrawScaleSide: Boolean; AColor: TColor; var PositionRect: TRect);
var
  PositionPixels             : Integer;
  ActualOrientationTickMarks : TiOrientationSide;
begin
  ActualOrientationTickMarks := FOrientationTickMarks;
  if DrawScaleSide then if ActualOrientationTickMarks = iosBottomRight then ActualOrientationTickMarks := iosTopLeft else ActualOrientationTickMarks := iosBottomRight;
  with Canvas, FBarRect do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      PositionPixels := GetPositionPixels(Position);
      case FOrientation of
        ioVertical   : begin
                         case ActualOrientationTickMarks of
                           iosBottomRight : begin
                                              Polygon([Point(Left - Margin - Size, PositionPixels - Size div 2),
                                                       Point(Left - Margin,        PositionPixels             ),
                                                       Point(Left - Margin - Size, PositionPixels + Size div 2)]);

                                              PositionRect := Rect(Left-Margin - Size,PositionPixels-Size div 2,
                                                                   Left-Margin       ,PositionPixels+Size div 2);
                                            end;
                           iosTopLeft     : begin
                                              Polygon([Point(Right + Margin + Size, PositionPixels - Size div 2),
                                                       Point(Right + Margin + Size, PositionPixels + Size div 2),
                                                       Point(Right + Margin,        PositionPixels             )]);

                                              PositionRect := Rect(Right+Margin,     PositionPixels-Size div 2,
                                                                   Right+Margin+Size,PositionPixels+Size div 2);
                                            end;
                         end;
                       end;
        ioHorizontal : begin
                         case ActualOrientationTickMarks of
                           iosBottomRight : begin
                                              Polygon([Point(PositionPixels - Size div 2, Top    - Margin - Size),
                                                       Point(PositionPixels + Size div 2, Top    - Margin - Size),
                                                       Point(PositionPixels             , Top    - Margin       )]);

                                              PositionRect := Rect(PositionPixels-Size div 2, Top-Margin - Size,
                                                                   PositionPixels+Size div 2, Top-Margin);
                                            end;
                           iosTopLeft     : begin
                                              Polygon([Point(PositionPixels - Size div 2, Bottom + Margin + Size),
                                                       Point(PositionPixels + Size div 2, Bottom + Margin + Size),
                                                       Point(PositionPixels             , Bottom + Margin       )]);

                                              PositionRect := Rect(PositionPixels-Size div 2, Bottom+Margin,
                                                                   PositionPixels+Size div 2, Bottom+Margin+Size);
                                            end;
                         end;
                       end;
      end;
  end;
end;
//****************************************************************************************************************************************************
function TiThermometer.GetPixelsMin: Integer;
begin
  Result := GetPositionPixels(PositionMin);
end;
//****************************************************************************************************************************************************
function TiThermometer.GetPixelsMax: Integer;
begin
  Result := GetPositionPixels(PositionMax);
end;
//****************************************************************************************************************************************************
procedure TiThermometer.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      FMouseDownX := X;
      FMouseDownY := Y;
      if      ShowMinPointer and MinMaxUserCanMove and PtInRect(FCurrentMinRect, Point(X,Y)) then
        begin
          FMovingMin       := True;
          FOldCurrentValue := CurrentMin;
        end
      else if ShowMaxPointer and MinMaxUserCanMove and PtInRect(FCurrentMaxRect, Point(X,Y)) then
        begin
          FMovingMax       := True;
          FOldCurrentValue := CurrentMax;
        end
      else if IndicatorUserCanMove and PtInRect(FIndicatorClickRect, Point(X,Y)) then
        begin
          FMovingPointer   := True;
          FOldCurrentValue := Position;
        end;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FMovingMax then
    begin
      case Forientation of
        ioHorizontal : CurrentMax := FOldCurrentValue - (FMouseDownX - X)/GetTravelRange*(PositionMax - PositionMin);
        ioVertical   : CurrentMax := FOldCurrentValue + (FMouseDownY - Y)/GetTravelRange*(PositionMax - PositionMin);
      end;
      if CurrentMin > CurrentMax then CurrentMin := CurrentMax;
    end
  else if FMovingMin then
    begin
      case Forientation of
        ioHorizontal : CurrentMin := FOldCurrentValue - (FMouseDownX - X)/GetTravelRange*(PositionMax - PositionMin);
        ioVertical   : CurrentMin := FOldCurrentValue + (FMouseDownY - Y)/GetTravelRange*(PositionMax - PositionMin);
      end;
      if CurrentMax < CurrentMin then CurrentMax := CurrentMin;
    end
  else if FMovingPointer then
    begin
      case Forientation of
        ioHorizontal : Position := FOldCurrentValue - (FMouseDownX - X)/GetTravelRange*(PositionMax - PositionMin);
        ioVertical   : Position := FOldCurrentValue + (FMouseDownY - Y)/GetTravelRange*(PositionMax - PositionMin);
      end;
      if CurrentMax < CurrentMin then CurrentMax := CurrentMin;
    end;
end;
//****************************************************************************************************************************************************
procedure TiThermometer.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FMovingMax     := False;
  FMovingMin     := False;
  FMovingPointer := False;
end;
//****************************************************************************************************************************************************
end.
