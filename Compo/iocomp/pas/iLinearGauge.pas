{*******************************************************}
{                                                       }
{       TiLinearGauge Component                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLinearGauge;{$endif}
{$ifdef iCLX}unit QiLinearGauge;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iGaugePointer,  iGaugeComponent,  iClasses;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiGaugePointer, QiGaugeComponent, QiClasses;{$ENDIF}

type
  TiLinearGauge = class(TiGaugeComponent)
  private
    FBarRect              : TRect;

    FOrientation          : TiOrientation;
    FOrientationTickMarks : TiOrientationSide;
    FEndsMargin           : Integer;
    FReverseScale         : Boolean;

    FMouseDownX           : Integer;
    FMouseDownY           : Integer;
    FMouseDownValue       : Double;
    FMouseDownPosition    : Double;

    FOnAutoSize           : TNotifyEvent;
    FPointerOverlap       : Integer;
    FAutoCenter           : Boolean;
    FCenterOffsetX        : Integer;
    FCenterOffsetY        : Integer;

    FAllowFocus           : Boolean;

    FKeyPageStepSize      : Double;
    FKeyArrowStepSize     : Double;
    FMouseWheelStepSize   : Double;

    procedure SetOrientationTickMarks(const Value: TiOrientationSide);
    procedure SetOrientation         (const Value: TiOrientation);
    procedure SetEndsMargin          (const Value: Integer);
    procedure SetReverseScale        (const Value: Boolean);
    procedure SetAutoCenter          (const Value: Boolean);
    procedure SetAllowFocus          (const Value: Boolean);

    procedure SetPointerStyle        (const Value: TiLinearGaugePointerStyle);
    procedure SetPointerSize         (const Value: Integer);
    procedure SetPointerColor        (const Value: TColor);
    procedure SetPointerOffSet       (const Value: Integer);

    procedure SetKeyArrowStepSize    (const Value: Double);
    procedure SetKeyPageStepSize     (const Value: Double);
    procedure SetMouseWheelStepSize  (const Value: Double);

    function GetPointerStyle  : TiLinearGaugePointerStyle;
    function GetPointerSize   : Integer;
    function GetPointerColor  : TColor;
    function GetPointerOffSet : Integer;

    function GetPixelsMin     : Integer;
    function GetPixelsMax     : Integer;
  protected
    procedure DrawTicks    (Canvas: TCanvas);
    procedure DrawSections (Canvas: TCanvas);
    procedure DrawIndicator(Canvas: TCanvas; Pointer: TiGaugePointer);
    procedure DrawMinMax   (Canvas: TCanvas);
    procedure DrawLimits   (Canvas: TCanvas);

    procedure CalcPoints;
    procedure CalcAutoCenterOffsets;

    procedure InitializePointer(GaugePointer : TiGaugePointer); override;

    procedure iPaintTo(Canvas: TCanvas);                                           override;
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Integer); override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);              override;

    property OnAutoSize           : TNotifyEvent              read FOnAutoSize           write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent); override;

    property PixelsMin            : Integer                   read GetPixelsMin;
    property PixelsMax            : Integer                   read GetPixelsMax;
  published
    property EndsMargin           : Integer                   read FEndsMargin           write SetEndsMargin            default 10;
    property Orientation          : TiOrientation             read FOrientation          write SetOrientation           default ioVertical;
    property OrientationTickMarks : TiOrientationSide         read FOrientationTickMarks write SetOrientationTickMarks  default iosBottomRight;

    property PointerStyle         : TiLinearGaugePointerStyle read GetPointerStyle       write SetPointerStyle          default ilgpsPointer;
    property PointerSize          : Integer                   read GetPointerSize        write SetPointerSize           default 10;
    property PointerColor         : TColor                    read GetPointerColor       write SetPointerColor          default clBlack;
    property PointerOffSet        : Integer                   read GetPointerOffSet      write SetPointerOffSet         default 0;

    property ReverseScale         : Boolean                   read FReverseScale         write SetReverseScale          default False;
    property AutoCenter           : Boolean                   read FAutoCenter           write SetAutoCenter            default False;

    property AllowFocus           : Boolean                   read FAllowFocus           write SetAllowFocus            default False;

    property KeyArrowStepSize     : Double                    read FKeyArrowStepSize     write SetKeyArrowStepSize;
    property KeyPageStepSize      : Double                    read FKeyPageStepSize      write SetKeyPageStepSize;
    property MouseWheelStepSize   : Double                    read FMouseWheelStepSize   write SetMouseWheelStepSize;

    property BackGroundColor;
    property BorderStyle;
    property BackGroundPicture;
    property CachedDrawing;
    property Transparent;
    property OffsetX;
    property OffsetY;
    property ShowDisabledState;
    property TabOrder;
    property TabStop;

    property TickMajorStyle;
    property TickMinorStyle;

    property ShowTicksAxis;
    property ShowTicksMajor;
    property ShowTicksMinor;
    property ShowTickLabels;
    property TickMajorCount;
    property TickMajorColor;
    property TickMajorLength        default 20;
    property TickMinorAlignment;
    property TickMinorCount;
    property TickMinorColor;
    property TickMinorLength        default 7;
    property TickMargin             default 0;
    property TickLabelMargin;
    property TickLabelFont;
    property TickLabelPrecision;
    property PrecisionStyle;
    property OnCustomizeTickLabel;

    property SectionColor1;
    property SectionColor2;
    property SectionColor3;

    property SectionColor4;
    property SectionColor5;
    property SectionCount;
    property SectionEnd1;
    property SectionEnd2;
    property SectionEnd3;
    property SectionEnd4;

    property ShowMaxPointer;
    property ShowMinPointer;
    property MinMaxPointerSize;
    property MinMaxPointerMargin;
    property MaxPointerColor;
    property MinPointerColor;
    property MinMaxStyle3D;

    property MinMaxUserCanMove;

    property AutoScaleEnabled;
    property AutoScaleDesiredTicks;
    property AutoScaleMaxTicks;
    property AutoScaleStyle;
    property Width                  default 60;
    property Height                 default 200;
  end;

implementation

type
  TiGaugePointerAccess = class(TiGaugePointer)end;
//****************************************************************************************************************************************************
constructor TiLinearGauge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width               := 60;
  Height              := 200;
  TickMajorLength     := 20;
  TickMinorLength     := 7;
  TickMargin          := 0;

  FEndsMargin         := 10;
  FAllowFocus         := False;

  FKeyArrowStepSize   := 0.1;
  FKeyPageStepSize    := 1;
  FMouseWheelStepSize := 1;

  CreateBackGroundPicture;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.SetEndsMargin        (const Value:Integer);begin SetIntegerProperty(Value,FEndsMargin,        irtBackGround);end;
procedure TiLinearGauge.SetReverseScale      (const Value:Boolean);begin SetBooleanProperty(Value,FReverseScale,      irtBackGround);end;
procedure TiLinearGauge.SetAutoCenter        (const Value:Boolean);begin SetBooleanProperty(Value,FAutoCenter,        irtBackGround);end;
procedure TiLinearGauge.SetAllowFocus        (const Value:Boolean);begin SetBooleanProperty(Value,FAllowFocus,        irtBackGround);end;
procedure TiLinearGauge.SetKeyArrowStepSize  (const Value:Double );begin SetDoubleProperty (Value,FKeyArrowStepSize,  irtNone      );end;
procedure TiLinearGauge.SetKeyPageStepSize   (const Value:Double );begin SetDoubleProperty (Value,FKeyPageStepSize,   irtNone      );end;
procedure TiLinearGauge.SetMouseWheelStepSize(const Value:Double );begin SetDoubleProperty (Value,FMouseWheelStepSize,irtNone      );end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.SetOrientationTickMarks(const Value: TiOrientationSide);
begin
  if FOrientationTickMarks <> Value then
    begin
      FOrientationTickMarks := Value;                                       
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.SetOrientation(const Value: TiOrientation);
var
  ATempWidth : Integer;
begin
  if FOrientation <> Value then
    begin
      FOrientation := Value;
      if not Loading then
        begin
          ATempWidth := Width;
          Width      := Height;
          Height     := ATempWidth;
          if Assigned(FOnAutoSize) then FOnAutoSize(Self);
        end;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.CalcPoints;
var
  i           : Integer;
  AClientRect : TRect;
  AMaxMargin  : Integer;
  ASide       : TiQuadDirection;
begin
  AClientRect := Rect(0, 0 ,Width-1, Height-1);
  ASide       := GetQuadDirection(FOrientation, FOrientationTickMarks, False, False);
  AMaxMargin  := 0;

  for i := 0 to PointerManager.Count -1 do
    if PointerManager.Items[i].Margin > AMaxMargin then AMaxMargin := PointerManager.Items[i].Margin;

  if (ShowMaxPointer or ShowMinPointer) then
    if MinMaxPointerMargin > AMaxMargin then AMaxMargin := MinMaxPointerMargin;

  for i := 0 to LimitCount - 1 do
    if (LimitShowUpperPointer[i] or LimitShowLowerPointer[i]) then
      if LimitPointerMargin[i] > AMaxMargin then AMaxMargin := LimitPointerMargin[i];

  if AMaxMargin < 0 then AMaxMargin := 0;

  FPointerOverlap := AMaxMargin;

  with AClientRect do
    case Aside of
      iqdRight  : FBarRect := Rect(Left +FPointerOverlap,                 Top+FEndsMargin, Left +FPointerOverlap+TickMajorLength, Bottom-FEndsMargin);
      iqdLeft   : FBarRect := Rect(Right-FPointerOverlap-TickMajorLength, Top+FEndsMargin, Right-FPointerOverlap,                 Bottom-FEndsMargin);

      iqdBottom : FBarRect := Rect(Left+FEndsMargin, Top   +FPointerOverlap,                 Right-FEndsMargin, Top    +FPointerOverlap+TickMajorLength);
      iqdTop    : FBarRect := Rect(Left+FEndsMargin, Bottom-FPointerOverlap-TickMajorLength, Right-FEndsMargin, Bottom -FPointerOverlap                );
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.CalcAutoCenterOffsets;
var
  ATotalWidth : Integer;
  ATextWidth  : Integer;
begin
  FCenterOffsetX := 0;
  FCenterOffsetY := 0;

  if not FAutoCenter then Exit;

  if ShowTickLabels then
    begin
      Canvas.Font.Assign(TickLabelFont);
      case Orientation of
        ioVertical   : ATextWidth := Canvas.TextWidth (Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMax])));
        else           ATextWidth := Canvas.TextHeight(Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMax])));
      end;
      ATotalWidth := TickLabelMargin + ATextWidth;
    end
  else ATotalWidth := 0;

  case FOrientation of
    ioVertical   : begin
                     ATotalWidth    := ATotalWidth + FBarRect.Right - FBarRect.Left + FPointerOverlap;
                     FCenterOffsetX := (Width  - ATotalWidth) div 2;
                   end;
    ioHorizontal : begin
                     ATotalWidth    := ATotalWidth + FBarRect.Bottom - FBarRect.Top + FPointerOverlap;
                     FCenterOffsetY := (Height - ATotalWidth) div 2;
                   end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.iPaintTo(Canvas: TCanvas);
var
  i     : Integer;
  ASide : TiQuadDirection;
begin
  CalcPoints;
  CalcAutoCenterOffsets;

  ASide := GetQuadDirection(FOrientation, FOrientationTickMarks, False, False);

  case ASide of
    iqdRight  : begin
                  OffsetRect(FBarRect, OffsetX, 0);
                  OffsetRect(FBarRect, FCenterOffsetX, 0);
                end;
    iqdLeft   : begin
                  OffsetRect(FBarRect, -OffsetX, 0);
                  OffsetRect(FBarRect, -FCenterOffsetX, 0);
                end;
    iqdBottom : begin
                  OffsetRect(FBarRect, 0, OffsetY);
                  OffsetRect(FBarRect, 0, FCenterOffsetY);
                end;
    iqdTop    : begin
                  OffsetRect(FBarRect, 0, -OffsetY);
                  OffsetRect(FBarRect, 0, -FCenterOffsetY);
                end;
  end;

  ScaleObject.PositionMax           := PositionMax;
  ScaleObject.PositionMin           := PositionMin;
  ScaleObject.Orientation           := FOrientation;
  ScaleObject.OrientationTickMarks  := FOrientationTickMarks;
  ScaleObject.ReverseTickMinorAlign := True;
  ScaleObject.ReverseScale          := FReverseScale;

  case FOrientation of
    ioVertical   : begin
                     ScaleObject.Start := FBarRect.Bottom;
                     ScaleObject.Stop  := FBarRect.Top;
                     case FOrientationTickMarks of
                       iosBottomRight : ScaleObject.Edge := FBarRect.Left;
                       iosTopLeft     : ScaleObject.Edge := FBarRect.Right;
                     end;
                   end;
    ioHorizontal : begin
                     ScaleObject.Start := FBarRect.Left;
                     ScaleObject.Stop  := FBarRect.Right;
                     case FOrientationTickMarks of
                       iosBottomRight : ScaleObject.Edge := FBarRect.Top;
                       iosTopLeft     : ScaleObject.Edge := FBarRect.Bottom;
                     end;
                   end;
  end;

  if CachedDrawing then
    begin
      if (PointerManager.Items[0].Style = ord(ilgpsColorBar)) or (PointerManager.Items[0].Style = ord(ilgpsTube)) then
        begin
          DrawBackGround(Canvas, BackGroundColor);
          DrawSections  (Canvas);

          for i := 0 to PointerManager.Count - 1 do
            DrawIndicator(Canvas, PointerManager.Items[i]);

          DrawTicks (Canvas);
          DrawLimits(Canvas);
          DrawMinMax(Canvas);
        end
      else
        begin
          if BackGroundChanged then
            begin
              CreateBackGroundBitmap;
              DrawBackGround(BackGroundBitmap.Canvas, BackGroundColor);
              DrawSections  (BackGroundBitmap.Canvas);
              DrawTicks     (BackGroundBitmap.Canvas);
              ResetBackGroundChange;
            end;
          TransferBackGround(Canvas);

          for i := 0 to PointerManager.Count - 1 do
            DrawIndicator(Canvas, PointerManager.Items[i]);

          DrawMinMax(Canvas);
          DrawLimits(Canvas);
        end;
    end
  else
    begin
      if (PointerManager.Items[0].Style = ord(ilgpsColorBar)) or (PointerManager.Items[0].Style = ord(ilgpsTube)) then
        begin
          DrawBackGround(Canvas, BackGroundColor);
          DrawSections  (Canvas);

          for i := 0 to PointerManager.Count - 1 do
            DrawIndicator(Canvas, PointerManager.Items[i]);

          DrawTicks (Canvas);
          DrawLimits(Canvas);
          DrawMinMax(Canvas);
        end
      else
        begin
          DrawBackGround(Canvas, BackGroundColor);
          DrawSections  (Canvas);
          DrawTicks     (Canvas);

          for i := 0 to PointerManager.Count - 1 do
            DrawIndicator(Canvas, PointerManager.Items[i]);

          DrawMinMax(Canvas);
          DrawLimits(Canvas);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.DrawSections(Canvas: TCanvas);
var
  i                 : Integer;
  ACurrentColor     : TColor;
  ALastStartPixels  : Integer;
  ACurrentEndPixels : Integer;
  ALastStart        : Double;
  ACurrentEnd       : Double;
begin
  ALastStart := PositionMin;
  with Canvas, FBarRect do
    begin
      for i := 1 to SectionCount do
        begin
          case i of
            1 :  begin ACurrentColor := SectionColor1; ACurrentEnd := SectionEnd1 end;
            2 :  begin ACurrentColor := SectionColor2; ACurrentEnd := SectionEnd2 end;
            3 :  begin ACurrentColor := SectionColor3; ACurrentEnd := SectionEnd3 end;
            4 :  begin ACurrentColor := SectionColor4; ACurrentEnd := SectionEnd4 end;
            else begin ACurrentColor := SectionColor5; ACurrentEnd := PositionMax end;
          end;

          if ACurrentEnd > PositionMax then ACurrentEnd := PositionMax;
          if ACurrentEnd < PositionMin then ACurrentEnd := PositionMin;
          if ACurrentEnd < ALastStart  then ACurrentEnd := PositionMax;
          if i = SectionCount          then ACurrentEnd := PositionMax;


          Brush.Color := ACurrentColor;
          Pen.Color   := ACurrentColor;

          ACurrentEndPixels := ScaleObject.ValueToPixels(ACurrentEnd);
          ALastStartPixels  := ScaleObject.ValueToPixels(ALastStart);

          case FOrientation of
            ioVertical   : Rectangle(Left, ACurrentEndPixels, Right, ALastStartPixels);
            ioHorizontal : Rectangle(ALastStartPixels, Top, ACurrentEndPixels, Bottom);
          end;             

          ALastStart := ACurrentEnd;

          if ACurrentEnd = PositionMax then exit;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.DrawIndicator(Canvas: TCanvas; Pointer: TiGaugePointer);
var
  APosition         : Double;
  APos              : Integer;
  APosMin           : Integer;
  APosMax           : Integer;
  AOffset           : Integer;
  ASize             : Integer;
  AColor            : TColor;
  AEnabled          : Boolean;
  AUseDisabledColor : Boolean;
  ARect             : TRect;
  ARect2            : TRect;
  ASide             : TiQuadDirection;
  AStyle            : TiLinearGaugePointerStyle;
  AStyle3D          : TiBevelStyle;
  APointer          : TiGaugePointerAccess;
begin
  if not Pointer.Visible then Exit;

  ASide     := GetQuadDirection(FOrientation, FOrientationTickMarks, False, Pointer.DrawScaleSide);
  APosition := Pointer.Position;

  if APosition < PositionMin then APosition := PositionMin;
  if APosition > PositionMax then APosition := PositionMax;

  APos     := ScaleObject.ValueToPixels(APosition);
  APosMin  := ScaleObject.ValueToPixels(PositionMin);
  APosMax  := ScaleObject.ValueToPixels(PositionMax);
  AOffset  := Pointer.Margin;
  ASize    := Pointer.Size;
  AStyle   := TiLinearGaugePointerStyle(Pointer.Style);
  AEnabled := Pointer.Enabled;
  APointer := TiGaugePointerAccess(Pointer);
  AColor   := Pointer.ColorDraw;

  if Pointer.Style3D then AStyle3D := ibsRaised
  else                    AStyle3D := ibsNone;

  with Canvas, FBarRect do
    begin
      Brush.Color := AColor;
      Pen.Color   := AColor;
      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      case AStyle of
        ilgpsTriangle  : begin
                           case ASide of
                             iqdRight  : ARect := Rect(Left -AOffset,       APos-ASize div 2, Left -AOffset+ASize, APos+ASize div 2);
                             iqdLeft   : ARect := Rect(Right+AOffset-ASize, APos-ASize div 2, Right+AOffset,       APos+ASize div 2);

                             iqdBottom : ARect := Rect(APos-ASize div 2, Top   -AOffset,       APos+ASize div 2, Top   -AOffset+ASize);
                             iqdTop    : ARect := Rect(APos-ASize div 2, Bottom+AOffset-ASize, APos+ASize div 2, Bottom+AOffset);
                           end;
                           APointer.Region := iDraw.Triangle(Canvas, ARect, ASide, AStyle3D, AColor, AEnabled);
                         end;
        ilgpsPointer   : begin
                           case ASide of
                             iqdRight  : ARect := Rect(Left -AOffset,         APos-ASize div 2, Left - AOffset + 2*ASize, APos+ASize div 2);
                             iqdLeft   : ARect := Rect(Right+AOffset-2*ASize, APos-ASize div 2, Right+AOffset,            APos+ASize div 2);

                             iqdBottom : ARect := Rect(APos-ASize div 2, Top   -AOffset,         APos+ASize div 2, Top   -AOffset+2*ASize);
                             iqdTop    : ARect := Rect(APos-ASize div 2, Bottom+AOffset-2*ASize, APos+ASize div 2, Bottom+AOffset);
                           end;
                           APointer.Region := iDraw.Pointer(Canvas, ARect, ASide, AStyle3D, AColor, AEnabled);
                         end;
        ilgpsTLine     : begin
                           case ASide of
                             iqdRight  : begin
                                           Polyline([Point(Left - AOffset,   Top   ), Point(Left - AOffset,          Bottom)]);
                                           Polyline([Point(Left - AOffset+1, Top   ), Point(Left - AOffset+1,        Bottom)]);
                                           Polyline([Point(Left - AOffset,   APos  ), Point(Left - AOffset + ASize,  APos  )]);
                                           Polyline([Point(Left - AOffset,   APos+1), Point(Left - AOffset + ASize,  APos+1)]);
                                           Polyline([Point(Left - AOffset,   APos-1), Point(Left - AOffset + ASize,  APos-1)]);

                                           ARect := Rect(Left - AOffset, APos-4, Left - AOffset + ASize, APos+4);
                                         end;
                             iqdLeft   : begin
                                           Polyline([Point(Right + AOffset-1, Top   ), Point(Right + AOffset-1,       Bottom)]);
                                           Polyline([Point(Right + AOffset-2, Top   ), Point(Right + AOffset-2,       Bottom)]);
                                           Polyline([Point(Right + AOffset,   APos  ), Point(Right + AOffset - ASize, APos  )]);
                                           Polyline([Point(Right + AOffset,   APos+1), Point(Right + AOffset - ASize, APos+1)]);
                                           Polyline([Point(Right + AOffset,   APos-1), Point(Right + AOffset - ASize, APos-1)]);

                                           ARect := Rect(Right + AOffset - ASize, APos-4, Right + AOffset, APos+4);
                                         end;
                             iqdBottom : begin
                                            Polyline([Point(Left,   Top - AOffset+1        ), Point(Right,  Top - AOffset+1)]);
                                            Polyline([Point(Left,   Top - AOffset+2        ), Point(Right,  Top - AOffset+2)]);
                                            Polyline([Point(Left,   Top - AOffset+3        ), Point(Right,  Top - AOffset+3)]);
                                            Polyline([Point(APos-1, Top - AOffset + ASize+2), Point(APos-1, Top - AOffset+2)]);
                                            Polyline([Point(APos,   Top - AOffset + ASize+2), Point(APos,   Top - AOffset+2)]);
                                            Polyline([Point(APos+1, Top - AOffset + ASize+2), Point(APos+1, Top - AOffset+2)]);

                                           ARect := Rect(APos-4, Top - AOffset+2, APos+4, Top - AOffset + ASize+2);
                                         end;
                             iqdTop    : begin
                                            Polyline([Point(Left,   Bottom + AOffset-1),         Point(Right,  Bottom + AOffset-1)]);
                                            Polyline([Point(Left,   Bottom + AOffset-2),         Point(Right,  Bottom + AOffset-2)]);
                                            Polyline([Point(Left,   Bottom + AOffset-3),         Point(Right,  Bottom + AOffset-3)]);
                                            Polyline([Point(APos-1, Bottom + AOffset - ASize-2), Point(APos-1, Bottom + AOffset-2)]);
                                            Polyline([Point(APos,   Bottom + AOffset - ASize-2), Point(APos,   Bottom + AOffset-2)]);
                                            Polyline([Point(APos+1, Bottom + AOffset - ASize-2), Point(APos+1, Bottom + AOffset-2)]);

                                           ARect := Rect(APos-4, Bottom + AOffset - ASize-2, APos+4, Bottom + AOffset-2);
                                         end;
                           end;
                           {$IFDEF iVCL}TiGaugePointerAccess(Pointer).Region := CreateRectRgnIndirect(ARect);{$ENDIF}
                           {$IFDEF iCLX}TiGaugePointerAccess(Pointer).Region := ARect;                       {$ENDIF}
                         end;
        ilgpsBarSunken,
        ilgpsBarRaised : begin
                           case ASide of
                             iqdRight  : ARect := iRect(Left - AOffset,          APosMax, Left  - AOffset + ASize, APosMin);
                             iqdLeft   : ARect := iRect(Right + AOffset - ASize, APosMax, Right + AOffset,         APosMin);

                             iqdBottom : ARect := Rect(APosMax, Top    - AOffset,         APosMin, Top    - AOffset + ASize);
                             iqdTop    : ARect := Rect(APosMax, Bottom + AOffset - ASize, APosMin, Bottom + AOffset);
                           end;

                           Brush.Color := ColorOffset(AColor, $80, False);
                           Pen.Color   := Brush.Color;

                           Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                           //---------------------------------------------------------------------------------------
                           case FOrientation of
                             ioVertical   : ARect2 := iRect(Left - AOffset, APos, Left - AOffset + ASize, APosMin);
                             ioHorizontal : ARect2 := iRect(APos, Top - AOffset, APosMin, Top - AOffset + ASize);
                           end;

                           Brush.Color := AColor;
                           Pen.Color   := Brush.Color;

                           Rectangle(ARect2.Left, ARect2.Top, ARect2.Right, ARect2.Bottom);
                           //---------------------------------------------------------------------------------------
                           if AStyle = ilgpsBarSunken then  iDraw.Border(Canvas, ARect, 2, ibsLowered);
                           if AStyle = ilgpsBarRaised then  iDraw.Border(Canvas, ARect, 2, ibsRaised);
                           //---------------------------------------------------------------------------------------
                           {$IFDEF iVCL}TiGaugePointerAccess(Pointer).Region := CreateRectRgnIndirect(ARect);{$ENDIF}
                           {$IFDEF iCLX}TiGaugePointerAccess(Pointer).Region := ARect;                       {$ENDIF}
                         end;
      ilgpsColorBar  : begin
                           case FOrientation of
                             ioVertical   : ARect := iRect(Left, APos, Right, APosMin);
                             ioHorizontal : ARect := iRect(APosMin, Top,  APos,  Bottom);
                           end;

                           Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

                           {$IFDEF iVCL}TiGaugePointerAccess(Pointer).Region := CreateRectRgnIndirect(ARect);{$ENDIF}
                           {$IFDEF iCLX}TiGaugePointerAccess(Pointer).Region := ARect;                       {$ENDIF}
                         end;
        ilgpsTube      : begin
                           case FOrientation of
                             ioVertical   : ARect := iRect(Left, APos, Right, APosMin);
                             ioHorizontal : ARect := iRect(APosMin, Top,  APos,  Bottom);
                           end;

                           iDraw.GradientTube(Canvas, ARect, PointerColor, FOrientation);

                           {$IFDEF iVCL}TiGaugePointerAccess(Pointer).Region := CreateRectRgnIndirect(ARect);{$ENDIF}
                           {$IFDEF iCLX}TiGaugePointerAccess(Pointer).Region := ARect;                       {$ENDIF}
                         end;
      end;
    end;
  if HasFocus and AllowFocus and Pointer.Focused then
    begin
      InflateRect(ARect, 1, 1);
      iDrawFocusRect(Canvas, ARect, BackGroundColor);
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.DrawMinMax(Canvas: TCanvas);
begin
  if ShowMaxPointer then
    begin
      MaxPointer.Position      := CurrentMax;
      MaxPointer.Style         := ord(ilgpsTriangle);
      MaxPointer.Margin        := MinMaxPointerMargin;
      MaxPointer.Size          := MinMaxPointerSize;
      MaxPointer.DrawScaleSide := False;
      MaxPointer.Color         := MaxPointerColor;
      MaxPointer.UserCanMove   := MinMaxUserCanMove;

      DrawIndicator(Canvas, MaxPointer);
    end;

  if ShowMinPointer then
    begin
      MinPointer.Position      := CurrentMin;
      MinPointer.Style         := ord(ilgpsTriangle);
      MinPointer.Margin        := MinMaxPointerMargin;
      MinPointer.Size          := MinMaxPointerSize;
      MinPointer.DrawScaleSide := False;
      MinPointer.Color         := MinPointerColor;
      MinPointer.UserCanMove   := MinMaxUserCanMove;

      DrawIndicator(Canvas, MinPointer);
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.DrawLimits(Canvas: TCanvas);
var
  i        : Integer;
  APointer : TiGaugePointer;
begin
  for i := 0 to LimitCount -1 do
    begin
      if LimitShowUpperPointer[i] then
        begin
          APointer := TiGaugePointer.Create(nil);
          try
            APointer.Position      := LimitUpperValue[i];
            APointer.Margin        := LimitPointerMargin[i];
            APointer.Style         := ord(ilgpsTriangle);
            APointer.Size          := LimitPointerSize[i];
            APointer.DrawScaleSide := LimitDrawScaleSide[i];
            APointer.Color         := LimitUpperPointerColor[i];

            DrawIndicator(Canvas, APointer);
          finally
            APointer.Free;
          end;
        end;

      if LimitShowLowerPointer[i] then
        begin
          APointer := TiGaugePointer.Create(nil);
          try
            APointer.Position      := LimitLowerValue[i];
            APointer.Margin        := LimitPointerMargin[i];
            APointer.Style         := ord(ilgpsTriangle);
            APointer.Size          := LimitPointerSize[i];
            APointer.DrawScaleSide := LimitDrawScaleSide[i];
            APointer.Color         := LimitLowerPointerColor[i];

            DrawIndicator(Canvas, APointer);
          finally
            APointer.Free;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.DrawTicks(Canvas: TCanvas);
var
  AShowEnabled : Boolean;
begin
  if      not ShowDisabledState then AShowEnabled  := True
  else if not Enabled then           AShowEnabled  := False
  else                               AShowEnabled  := True;

  ScaleObject.Draw         (Canvas, AShowEnabled, BackGroundColor);
  ScaleObject.DrawScaleLine(Canvas, AShowEnabled);
end;
//****************************************************************************************************************************************************
function TiLinearGauge.GetPixelsMin: Integer;begin Result := ScaleObject.ValueToPixels(PositionMin);end;
function TiLinearGauge.GetPixelsMax: Integer;begin Result := ScaleObject.ValueToPixels(PositionMax);end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i           : Integer;
  APointer    : TiGaugePointer;
  AAnyFocused : Boolean;
begin
  if (Button = mbLeft) then
    begin
      //------------------------------------------------------------------------
      AAnyFocused := False;

      if MinPointer.Focused then AAnyFocused := True;
      if MaxPointer.Focused then AAnyFocused := True;

      for i := 0 to PointerCount-1 do
        begin
          APointer := PointerManager.Items[i];
          if not APointer.Visible then Continue;

          if APointer.Focused then AAnyFocused := True;
        end;

      if AAnyFocused and FAllowFocus then SetFocus;

      FMouseDownX := X;
      FMouseDownY := Y;
      //------------------------------------------------------------------------
      if FOrientation = ioVertical then FMouseDownValue := ScaleObject.PixelsToValue(Y)
      else                              FMouseDownValue := ScaleObject.PixelsToValue(X);

      if MinMaxUserCanMove then
        begin
          if      MinPointer.iMouseHitTest(X, Y) then
            begin
              PointerManager.ClearAllFocus;
              MinPointer.Focused := True;
              MaxPointer.Focused := False;
              if FAllowFocus then SetFocus;
              TiGaugePointerAccess(MinPointer).MouseDown := True;
              FMouseDownPosition                         := CurrentMin;
            end
          else if MaxPointer.iMouseHitTest(X, Y) then
            begin
              PointerManager.ClearAllFocus;
              MinPointer.Focused := False;
              MaxPointer.Focused := True;
              if FAllowFocus then SetFocus;
              TiGaugePointerAccess(MaxPointer).MouseDown := True;
              FMouseDownPosition                         := CurrentMax;
            end;
        end;

      for i := PointerCount-1 downto 0 do
        begin
          APointer := PointerManager.Items[i];
          if not APointer.Visible then Continue;

          if APointer.iMouseHitTest(X, Y) then
            begin
              MinPointer.Focused := False;
              MaxPointer.Focused := False;
              PointerManager.ClearAllFocus;
              APointer.Focused := True;
              if FAllowFocus then SetFocus;
              TiGaugePointerAccess(APointer).MouseDown := True;
              FMouseDownPosition                       := APointer.Position;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  i        : Integer;
  APointer : TiGaugePointer;
  ACursor  : TCursor;
  AValue   : Double;
  ADelta   : Double;
begin
  ACursor := crDefault;

  if MinPointer.iMouseHitTest(X, Y) then ACursor := MinPointer.GetMousePointer;
  if MaxPointer.iMouseHitTest(X, Y) then ACursor := MaxPointer.GetMousePointer;

  for i := 0 to PointerCount-1 do
    if PointerManager.Items[i].iMouseHitTest(X, Y) then
      begin
        ACursor := PointerManager.Items[i].GetMousePointer;
        break;
      end;

  Cursor := ACursor;

  if FOrientation = ioVertical then AValue := ScaleObject.PixelsToValue(Y)
  else                              AValue := ScaleObject.PixelsToValue(X);

  ADelta := AValue - FMouseDownValue;

  if TiGaugePointerAccess(MaxPointer).MouseDown then
    begin
      CurrentMax := FMouseDownPosition + ADelta;
      if CurrentMin > CurrentMax then CurrentMin := CurrentMax;
    end
  else if TiGaugePointerAccess(MinPointer).MouseDown then
    begin
      CurrentMin := FMouseDownPosition + ADelta;
      if CurrentMax < CurrentMin then CurrentMax := CurrentMin;
    end
  else
    for i := 0 to PointerCount-1 do
      begin
        APointer := PointerManager.Items[i];
        if TiGaugePointerAccess(APointer).MouseDown and APointer.UserCanMove then
          begin
            APointer.Position := FMouseDownPosition + ADelta;
            break;
          end;
      end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i        : Integer;
  APointer : TiGaugePointer;
begin
  TiGaugePointerAccess(MinPointer).MouseDown := False;
  TiGaugePointerAccess(MaxPointer).MouseDown := False;

  for i := 0 to PointerCount-1 do
    begin
      APointer := PointerManager.Items[i];
      if TiGaugePointerAccess(APointer).MouseDown and APointer.iMouseHitTest(X, Y) then
        if Assigned(OnClickPointer) then OnClickPointer(i);
      TiGaugePointerAccess(APointer).MouseDown := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  inherited iWantSpecialKey(CharCode, Result);
  if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1 else Result := 0;
end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.iKeyDown(var CharCode: Word; Shift: TShiftState);
var
  i        : Integer;
  APointer : TiGaugePointer;
begin
  //FKeyDown      := True;
  UserGenerated := True;

  APointer := nil;
  if      MinPointer.Focused then APointer := MinPointer
  else if MaxPointer.Focused then APointer := MinPointer
  else
    for i := 0 to PointerCount-1 do
      if PointerManager.Items[i].Focused then APointer := PointerManager.Items[i];

  if APointer = nil then Exit;

  try
    //KYLIX TODO
    {$ifndef iCLX}
    if      (CharCode = VK_LEFT) or (CharCode = VK_DOWN) then
      begin
        APointer.Position := APointer.Position - FKeyArrowStepSize;
        CharCode := 0;
      end
    else if (CharCode = VK_RIGHT) or (CharCode = VK_UP) then
      begin
        APointer.Position := APointer.Position + FKeyArrowStepSize;
        CharCode := 0;
      end
    else if (CharCode = VK_PRIOR) then //PageUp
      begin
        APointer.Position := APointer.Position + FKeyPageStepSize;
        CharCode := 0;
      end
    else if (CharCode = VK_NEXT) then //PageDown
      begin
        APointer.Position := APointer.Position - FKeyPageStepSize;
        CharCode := 0;
      end
    else if (CharCode = VK_HOME) then
      begin
        APointer.Position := PositionMin;
        CharCode := 0;
      end
    else if (CharCode = VK_END) then
      begin
        APointer.Position := PositionMax;
        CharCode := 0;
      end;
    {$endif}
  finally
    UserGenerated := False;
  end;

  BackGroundChange;
  inherited;
end;
//****************************************************************************************************************************************************
function TiLinearGauge.GetPointerColor  : TColor;                   begin Result :=                           PointerManager.Items[0].Color;  end;
function TiLinearGauge.GetPointerOffSet : Integer;                  begin Result :=                           PointerManager.Items[0].Margin; end;
function TiLinearGauge.GetPointerSize   : Integer;                  begin Result :=                           PointerManager.Items[0].Size;   end;
function TiLinearGauge.GetPointerStyle  : TiLinearGaugePointerStyle;begin Result := TiLinearGaugePointerStyle(PointerManager.Items[0].Style); end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.SetPointerOffSet(const Value: Integer);                  begin PointerManager.Items[0].Margin := Value;     end;
procedure TiLinearGauge.SetPointerColor (const Value: TColor);                   begin PointerManager.Items[0].Color  := Value;     end;
procedure TiLinearGauge.SetPointerSize  (const Value: Integer);                  begin PointerManager.Items[0].Size   := Value;     end;
procedure TiLinearGauge.SetPointerStyle (const Value: TiLinearGaugePointerStyle);begin PointerManager.Items[0].Style  := ord(Value);end;
//****************************************************************************************************************************************************
procedure TiLinearGauge.InitializePointer(GaugePointer: TiGaugePointer);
begin
  GaugePointer.Size  := 10;
  GaugePointer.Color := clBlue;
  GaugePointer.Style := ord(ilgpsPointer);
end;
//****************************************************************************************************************************************************
end.
