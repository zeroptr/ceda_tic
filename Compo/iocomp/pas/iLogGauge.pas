{*******************************************************}
{                                                       }
{       TiLogGauge Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLogGauge;{$endif}
{$ifdef iCLX}unit QiLogGauge;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iClasses, iGPFunctions,  iMath,  iGaugePointer,  iGaugeComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiClasses, QiGPFunctions, QiMath, QiGaugePointer, QiGaugeComponent;{$ENDIF}

type
  TiLogGauge = class(TiGaugeComponent)
  private
    FBarRect              : TRect;

    FOrientation          : TiOrientation;
    FOrientationTickMarks : TiOrientationSide;
    FEndsMargin           : Integer;
    FShowTicksAxis        : Boolean;
    FTickLabelStyle       : TiLogLabelStyle;
    FReverseScale         : Boolean;

    FMouseDownX           : Integer;
    FMouseDownY           : Integer;
    FOldCurrentValue      : Double;
    FOnAutoSize           : TNotifyEvent;
    FPointerOverlap       : Integer;
    FAutoCenter           : Boolean;
    FCenterOffsetX        : Integer;
    FCenterOffsetY        : Integer;

    FMinPointer           : TiGaugePointer;
    FMaxPointer           : TiGaugePointer;

    procedure SetOrientationTickMarks(const Value: TiOrientationSide);
    procedure SetOrientation         (const Value: TiOrientation);
    procedure SetEndsMargin          (const Value: Integer);
    procedure SetPointerStyle        (const Value: TiLinearGaugePointerStyle);
    procedure SetPointerSize         (const Value: Integer);
    procedure SetPointerColor        (const Value: TColor);
    procedure SetShowTicksAxis       (const Value: Boolean);
    procedure SetPointerOffSet       (const Value: Integer);
    procedure SetTickLabelStyle      (const Value: TiLogLabelStyle);
    procedure SetReverseScale        (const Value: Boolean);
    procedure SetAutoCenter          (const Value: Boolean);

    procedure CalcPoints;
    procedure CalcAutoCenterOffsets;

    function  GetTravelRange : Integer;
    property  TravelRange    : Integer read GetTravelRange;
    function  GetPositionPixels(Value: Double): Integer;

    function GetPointerColor : TColor;
    function GetPointerOffSet: Integer;
    function GetPointerSize  : Integer;
    function GetPointerStyle : TiLinearGaugePointerStyle;

    function GetPixelsMin : Integer;
    function GetPixelsMax : Integer;
  protected
    procedure SetPositionMin(const Value : Double); override;

    procedure DrawTicks    (Canvas: TCanvas);
    procedure DrawTickAxis (Canvas: TCanvas);
    procedure DrawSections (Canvas: TCanvas);
    procedure DrawIndicator(Canvas: TCanvas);
    procedure DrawMinMax   (Canvas: TCanvas);
    procedure DrawLimits   (Canvas: TCanvas);
    procedure DrawPointer  (Canvas: TCanvas; APointer: TiGaugePointer);

    procedure InitializePointer(iGaugePointer : TiGaugePointer); override;

    procedure iPaintTo(Canvas: TCanvas);                                           override;
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    property OnAutoSize           : TNotifyEvent              read FOnAutoSize          write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    function GetPointersOffSet(Index: Integer): Integer;
    function GetPointersStyle (Index: Integer): TiLinearGaugePointerStyle;

    procedure SetPointersOffSet(Index: Integer; Value: Integer);
    procedure SetPointersStyle(Index: Integer; Value: TiLinearGaugePointerStyle);

    property PixelsMin            : Integer                   read GetPixelsMin;
    property PixelsMax            : Integer                   read GetPixelsMax;
  published
    property EndsMargin           : Integer                   read FEndsMargin           write SetEndsMargin           default 10;
    property Orientation          : TiOrientation             read FOrientation          write SetOrientation          default ioVertical;
    property OrientationTickMarks : TiOrientationSide         read FOrientationTickMarks write SetOrientationTickMarks default iosBottomRight;

    property PointerOffSet        : Integer                   read GetPointerOffSet      write SetPointerOffSet        default 0;
    property PointerColor         : TColor                    read GetPointerColor       write SetPointerColor         default clBlack;
    property PointerSize          : Integer                   read GetPointerSize        write SetPointerSize          default 10;
    property PointerStyle         : TiLinearGaugePointerStyle read GetPointerStyle       write SetPointerStyle         default ilgpsPointer;

    property ShowTicksAxis        : Boolean                   read FShowTicksAxis        write SetShowTicksAxis        default True;
    property TickLabelStyle       : TiLogLabelStyle           read FTickLabelStyle       write SetTickLabelStyle       default illsValue;
    property ReverseScale         : Boolean                   read FReverseScale         write SetReverseScale         default False;
    property AutoCenter           : Boolean                   read FAutoCenter           write SetAutoCenter           default False;

    property BackGroundPicture;
    property BackGroundColor;
    property BorderStyle;                  
    property CachedDrawing;
    property Transparent;
    property OffsetX;
    property OffsetY;
    property ShowDisabledState;

    property TickMajorStyle;
    property TickMinorStyle;

    property TickMajorColor;
    property TickMajorLength       default 20;
    property TickMinorAlignment;
    property TickMinorColor;
    property TickMinorLength       default 7;
    property TickMargin            default 0;
    property TickLabelMargin;
    property TickLabelFont;
    property TickLabelPrecision;
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
    property MinMaxUserCanMove;
    property Width                 default 60;
    property Height                default 200;
  end;

implementation

type
  TiGaugePointerAccess = class(TiGaugePointer)end;
//****************************************************************************************************************************************************
constructor TiLogGauge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width              := 60;
  Height             := 200;
  TickMajorLength    := 20;
  TickMinorLength    := 7;
  TickMargin         := 0;
  PositionMin        := 1;

  FEndsMargin        := 10;

  FShowTicksAxis     := True;

  FMinPointer        := TiGaugePointer.Create(nil);
  FMaxPointer        := TiGaugePointer.Create(nil);

  CreateBackGroundPicture;
end;
//****************************************************************************************************************************************************
destructor TiLogGauge.Destroy;
begin
  FMinPointer.Free;
  FMaxPointer.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.SetEndsMargin       (const Value:Integer);begin SetIntegerProperty(Value,FEndsMargin,        irtBackGround);end;
procedure TiLogGauge.SetShowTicksAxis    (const Value:Boolean);begin SetBooleanProperty(Value,FShowTicksAxis,     irtBackGround);end;
procedure TiLogGauge.SetReverseScale     (const Value:Boolean);begin SetBooleanProperty(Value,FReverseScale,      irtBackGround);end;
procedure TiLogGauge.SetAutoCenter       (const Value:Boolean);begin SetBooleanProperty(Value,FAutoCenter,        irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiLogGauge.SetOrientationTickMarks(const Value: TiOrientationSide);
begin
  if FOrientationTickMarks <> Value then
    begin
      FOrientationTickMarks := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.SetTickLabelStyle(const Value: TiLogLabelStyle);
begin
  if FTickLabelStyle <> Value then
    begin
      FTickLabelStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.SetPositionMin(const Value: Double);
begin
  if Value <= 0 then raise Exception.Create('Position Min must be greater than 0');
  inherited SetPositionMin(Value);
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.SetOrientation(const Value: TiOrientation);
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
function TiLogGauge.GetTravelRange : Integer;
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
end;
//****************************************************************************************************************************************************
function TiLogGauge.GetPositionPixels(Value : Double) : Integer;
var
  DrawRect    : TRect;
  Distance    : Integer;
begin
  DrawRect := Rect(0, 0 ,Width, Height);
  Distance := Round(TravelRange * (Log10(Value) - Log10(PositionMin))/(Log10(PositionMax) - Log10(PositionMin)));

  with DrawRect do
    case Forientation of
      ioVertical   : begin
                       case FReverseScale of
                         False : Result := Bottom - FEndsMargin - Distance;
                         else    Result := Top    + FEndsMargin + Distance;
                       end;
                     end;
      else           begin
                       case FReverseScale of
                         False : Result := Left  + FEndsMargin + Distance;
                         else    Result := Right - FEndsMargin - Distance;
                       end;
                     end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.CalcPoints;
var
  ClientRect : TRect;
  MaxMargin  : Integer;
  x          : Integer;
begin
  ClientRect := Rect(0, 0 ,Width-1, Height-1);

  MaxMargin := 0;

  for x := 0 to PointerManager.Count -1 do
    begin
      if PointerManager.Items[x].Margin > MaxMargin then MaxMargin := PointerManager.Items[x].Margin;
    end;

  if (ShowMaxPointer or ShowMinPointer) then
    if MinMaxPointerMargin > MaxMargin then MaxMargin := MinMaxPointerMargin;

  for x := 0 to LimitCount - 1 do
    begin
      if (LimitShowUpperPointer[x] or LimitShowLowerPointer[x]) then
        if LimitPointerMargin[x] > MaxMargin then MaxMargin := LimitPointerMargin[x];
    end;

  if MaxMargin < 0 then MaxMargin := 0;

  FPointerOverlap := MaxMargin;

  with ClientRect do
    case FOrientation of
      ioVertical   : case FOrientationTickMarks of
                       iosBottomRight : FBarRect := Rect(Left  + FPointerOverlap,                   Top    + FEndsMargin,
                                                         Left  + FPointerOverlap + TickMajorLength, Bottom - FEndsMargin);
                       iosTopLeft     : FBarRect := Rect(Right - FPointerOverlap - TickMajorLength, Top    + FEndsMargin,
                                                         Right - FPointerOverlap,                   Bottom - FEndsMargin);
                    end;
      ioHorizontal : case FOrientationTickMarks of
                       iosBottomRight : FBarRect := Rect(Left  + FEndsMargin, Top    + FPointerOverlap,
                                                         Right - FEndsMargin, Top    + FPointerOverlap + TickMajorLength);
                       iosTopLeft     : FBarRect := Rect(Left  + FEndsMargin, Bottom - FPointerOverlap - TickMajorLength,
                                                         Right - FEndsMargin, Bottom - FPointerOverlap                  );
                    end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.CalcAutoCenterOffsets;
var
  TotalWidth : Integer;
  ATextWidth : Integer;
begin
  FCenterOffsetX := 0;
  FCenterOffsetY := 0;

  if not FAutoCenter then Exit;

  if ShowTickLabels then
    begin
      with Canvas do
        begin
          Canvas.Font.Assign(TickLabelFont);
          case Orientation of
            ioVertical   : ATextWidth := TextWidth (Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMax])));
            else           ATextWidth := TextHeight(Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMax])));
          end;
          TotalWidth := TickLabelMargin + ATextWidth;
        end;
    end
  else TotalWidth := 0;

  case FOrientation of
    ioVertical   : begin
                     TotalWidth := TotalWidth + FBarRect.Right - FBarRect.Left + FPointerOverlap;
                     FCenterOffsetX := (Width - TotalWidth) div 2;
                   end;
    ioHorizontal : begin
                     TotalWidth     := TotalWidth + FBarRect.Bottom - FBarRect.Top + FPointerOverlap;
                     FCenterOffsetY := (Height - TotalWidth) div 2;
                   end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.iPaintTo(Canvas: TCanvas);
begin
  CalcPoints;
  CalcAutoCenterOffsets;

  case FOrientation of
    ioVertical   : begin
                     case FOrientationTickMarks of
                       iosBottomRight : begin
                                          OffsetRect(FBarRect,   OffsetX, 0);
                                          OffsetRect(FBarRect,   FCenterOffsetX, 0);
                                        end;
                       iosTopLeft     : begin
                                          OffsetRect(FBarRect,   -OffsetX, 0);
                                          OffsetRect(FBarRect,   -FCenterOffsetX, 0);
                                        end;
                     end;
                   end;
    ioHorizontal : begin
                     case FOrientationTickMarks of
                       iosBottomRight : begin
                                          OffsetRect(FBarRect,   0, OffsetY);
                                          OffsetRect(FBarRect,   0, FCenterOffsetY);
                                        end;
                       iosTopLeft     : begin
                                          OffsetRect(FBarRect,   0, -OffsetY);
                                          OffsetRect(FBarRect,   0, -FCenterOffsetY);
                                        end;
                     end;
                   end;
  end;

  if CachedDrawing then
    begin
      if (PointerManager.Items[0].Style = ord(ilgpsColorBar)) or (PointerManager.Items[0].Style = ord(ilgpsTube)) then
        begin
          DrawBackGround(Canvas, BackGroundColor);
          DrawSections  (Canvas);
          DrawIndicator (Canvas);
          DrawTicks     (Canvas);
          DrawTickAxis  (Canvas);
          DrawLimits    (Canvas);
          DrawMinMax    (Canvas);
        end
      else
        begin
          if BackGroundChanged then
            begin
              CreateBackGroundBitmap;
              DrawBackGround(BackGroundBitmap.Canvas, BackGroundColor);
              DrawSections  (BackGroundBitmap.Canvas);
              DrawTicks     (BackGroundBitmap.Canvas);
              DrawTickAxis  (BackGroundBitmap.Canvas);
              ResetBackGroundChange;
            end;

          TransferBackGround(Canvas);

          DrawIndicator (Canvas);
          DrawMinMax    (Canvas);
          DrawLimits    (Canvas);
        end;
    end
  else
    begin
      if (PointerManager.Items[0].Style = ord(ilgpsColorBar)) or (PointerManager.Items[0].Style = ord(ilgpsTube)) then
        begin
          DrawBackGround(Canvas, BackGroundColor);
          DrawSections  (Canvas);
          DrawIndicator (Canvas);
          DrawTicks     (Canvas);
          DrawTickAxis  (Canvas);
          DrawLimits    (Canvas);
          DrawMinMax    (Canvas);
        end
      else
        begin
          DrawBackGround(Canvas, BackGroundColor);
          DrawSections  (Canvas);
          DrawTicks     (Canvas);
          DrawTickAxis  (Canvas);
          DrawIndicator (Canvas);
          DrawMinMax    (Canvas);
          DrawLimits    (Canvas);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.DrawTickAxis(Canvas: TCanvas);
var
  AShowEnabled : Boolean;
begin
  if not FShowTicksAxis then Exit;

  with Canvas, FBarRect do
    begin
      if      not ShowDisabledState then AShowEnabled  := True
      else if not Enabled then           AShowEnabled  := False
      else                               AShowEnabled  := True;

      Pen.Color := TickMajorColor;
      case FOrientation of
        ioVertical   : case FOrientationTickMarks of
                         iosBottomRight : begin
                                            if not AShowEnabled then LineBevel(Canvas, Right, Top, Right, Bottom+1, ibsLowered)
                                            else
                                              begin
                                                Pen.Color := TickMajorColor;
                                                Line(Canvas, Right,   Top, Right,   Bottom+1);
                                                Line(Canvas, Right-1, Top, Right-1, Bottom+1);
                                              end;
                                          end;
                         iosTopLeft     : begin
                                            if not AShowEnabled then LineBevel(Canvas, Left, Top, Left, Bottom+1, ibsLowered)
                                            else
                                              begin
                                                Pen.Color := TickMajorColor;
                                                Line(Canvas, Left,   Top, Left,   Bottom+1);
                                                Line(Canvas, Left+1, Top, Left+1, Bottom+1);
                                              end;
                                          end;
                       end;
        ioHorizontal : case FOrientationTickMarks of
                         iosBottomRight : begin
                                            if not AShowEnabled then LineBevel(Canvas, Left, Bottom, Right, Bottom, ibsLowered)
                                            else
                                              begin
                                                Pen.Color := TickMajorColor;
                                                Line(Canvas, Left, Bottom,   Right, Bottom);
                                                Line(Canvas, Left, Bottom-1, Right, Bottom-1);
                                              end;
                                          end;
                         iosTopLeft     : begin
                                            if not AShowEnabled then LineBevel(Canvas, Left, Top,   Right+1, Top, ibsLowered)
                                            else
                                              begin
                                                Pen.Color := TickMajorColor;
                                                Line(Canvas, Left, Top,   Right+1, Top);
                                                Line(Canvas, Left, Top+1, Right+1, Top+1);
                                              end;
                                          end;
                       end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.DrawSections(Canvas: TCanvas);
var
  x                : Integer;
  CurrentColor     : TColor;
  LastStartPixels  : Integer;
  CurrentEndPixels : Integer;
  LastStart        : Double;
  CurrentEnd       : Double;
begin
  LastStart := PositionMin;
  with Canvas, FBarRect do
    begin
      for x := 1 to SectionCount do
        begin
          case x of
            1 :  begin CurrentColor := SectionColor1; CurrentEnd := SectionEnd1 end;
            2 :  begin CurrentColor := SectionColor2; CurrentEnd := SectionEnd2 end;
            3 :  begin CurrentColor := SectionColor3; CurrentEnd := SectionEnd3 end;
            4 :  begin CurrentColor := SectionColor4; CurrentEnd := SectionEnd4 end;
            else begin CurrentColor := SectionColor5; CurrentEnd := PositionMax end;
          end;

          if CurrentEnd > PositionMax then CurrentEnd := PositionMax;
          if CurrentEnd < PositionMin then CurrentEnd := PositionMin;
          if CurrentEnd < LastStart   then CurrentEnd := PositionMax;
          if x = SectionCount         then CurrentEnd := PositionMax;


          Brush.Color := CurrentColor;
          Pen.Color   := CurrentColor;

          CurrentEndPixels := GetPositionPixels(CurrentEnd);
          LastStartPixels  := GetPositionPixels(LastStart);

          case FOrientation of
            ioVertical   : Rectangle(Left, CurrentEndPixels, Right, LastStartPixels);
            ioHorizontal : Rectangle(LastStartPixels, Top, CurrentEndPixels, Bottom);
          end;

          LastStart := CurrentEnd;

          if CurrentEnd = PositionMax then exit;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.DrawIndicator(Canvas: TCanvas);
var
  PositionPixels : Integer;
  x              : Integer;
  FPointerOffSet : Integer;
  FPointerSize   : Integer;
  PointArray     : Array[0..4] of TPoint;
  ARect          : TRect;
  APointer       : TiGaugePointer;
begin
  for x := 0 to PointerManager.Count - 1 do
    begin
      APointer := PointerManager.Items[x];

      if not APointer.Visible then Continue;

      PositionPixels := GetPositionPixels(GetPointersPosition(x));

      with Canvas, FBarRect do
        begin
          Brush.Color := APointer.Color;
          Pen.Color   := APointer.Color;
          Brush.Style := bsSolid;
          Pen.Style   := psSolid;

          FPointerOffSet := APointer.Margin;
          FPointerSize   := APointer.Size;

          case TiLinearGaugePointerStyle(APointer.Style) of
            ilgpsTriangle : DrawPointer(Canvas, APointer);
            ilgpsPointer  : begin
                              case FOrientation of
                                ioVertical   : case FOrientationTickMarks of
                                                 iosBottomRight : begin
                                                                    PointArray[0] := Point(Left - FPointerOffset,                  PositionPixels - FPointerSize div 2);
                                                                    PointArray[1] := Point(Left - FPointerOffset +   FPointerSize, PositionPixels - FPointerSize div 2);
                                                                    PointArray[2] := Point(Left - FPointerOffset + 2*FPointerSize, PositionPixels                     );
                                                                    PointArray[3] := Point(Left - FPointerOffset +   FPointerSize, PositionPixels + FPointerSize div 2);
                                                                    PointArray[4] := Point(Left - FPointerOffset,                  PositionPixels + FPointerSize div 2);
                                                                  end;
                                                 iosTopLeft     : begin
                                                                    PointArray[0] := Point(Right + FPointerOffset,                 PositionPixels - FPointerSize div 2);
                                                                    PointArray[1] := Point(Right + FPointerOffset -   FPointerSize,PositionPixels - FPointerSize div 2);
                                                                    PointArray[2] := Point(Right + FPointerOffset - 2*FPointerSize,PositionPixels                     );
                                                                    PointArray[3] := Point(Right + FPointerOffset -   FPointerSize,PositionPixels + FPointerSize div 2);
                                                                    PointArray[4] := Point(Right + FPointerOffset,                 PositionPixels + FPointerSize div 2);
                                                                  end;
                                               end;
                                ioHorizontal : case FOrientationTickMarks of
                                                 iosBottomRight : begin
                                                                    PointArray[0] := Point(PositionPixels - FPointerSize div 2, Top    - FPointerOffset                 );
                                                                    PointArray[1] := Point(PositionPixels - FPointerSize div 2, Top    - FPointerOffset +   FPointerSize);
                                                                    PointArray[2] := Point(PositionPixels                     , Top    - FPointerOffset + 2*FPointerSize);
                                                                    PointArray[3] := Point(PositionPixels + FPointerSize div 2, Top    - FPointerOffset +   FPointerSize);
                                                                    PointArray[4] := Point(PositionPixels + FPointerSize div 2, Top    - FPointerOffset                 );
                                                                  end;
                                                 iosTopLeft     : begin
                                                                    PointArray[0] := Point(PositionPixels - FPointerSize div 2, Bottom + FPointerOffset                 );
                                                                    PointArray[1] := Point(PositionPixels - FPointerSize div 2, Bottom + FPointerOffset -   FPointerSize);
                                                                    PointArray[2] := Point(PositionPixels                     , Bottom + FPointerOffset - 2*FPointerSize);
                                                                    PointArray[3] := Point(PositionPixels + FPointerSize div 2, Bottom + FPointerOffset -   FPointerSize);
                                                                    PointArray[4] := Point(PositionPixels + FPointerSize div 2, Bottom + FPointerOffset                 );
                                                                 end;
                                               end;
                              end;
                              Polygon(PointArray);
                              {$IFDEF iVCL}
                              TiGaugePointerAccess(APointer).Region := CreatePolygonRgn(PointArray, 5, ALTERNATE);
                              {$ENDIF}
                            end;
            ilgpsTLine    : case FOrientation of
                              ioVertical   : case FOrientationTickMarks of
                                               iosBottomRight : begin
                                                                  Polyline([Point(Left - FPointerOffset,                 Top             ),
                                                                            Point(Left - FPointerOffset,                 Bottom          )]);
                                                                  Polyline([Point(Left - FPointerOffset+1,               Top             ),
                                                                            Point(Left - FPointerOffset+1,               Bottom          )]);
                                                                  Polyline([Point(Left - FPointerOffset,                 PositionPixels  ),
                                                                            Point(Left - FPointerOffset + FPointerSize,  PositionPixels  )]);
                                                                  Polyline([Point(Left - FPointerOffset,                 PositionPixels+1),
                                                                            Point(Left - FPointerOffset + FPointerSize,  PositionPixels+1)]);
                                                                  Polyline([Point(Left - FPointerOffset,                 PositionPixels-1),
                                                                            Point(Left - FPointerOffset + FPointerSize,  PositionPixels-1)]);

                                                                  ARect := Rect(Left - FPointerOffset, PositionPixels-4, Left - FPointerOffset + FPointerSize, PositionPixels+4);
                                                                  {$IFDEF iVCL}
                                                                  TiGaugePointerAccess(APointer).Region := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                                                                  {$ENDIF}
                                                                end;
                                               iosTopLeft     : begin
                                                                  Polyline([Point(Right + FPointerOffset-1,              Top             ),
                                                                            Point(Right + FPointerOffset-1,              Bottom          )]);
                                                                  Polyline([Point(Right + FPointerOffset-2,              Top             ),
                                                                            Point(Right + FPointerOffset-2,              Bottom          )]);
                                                                  Polyline([Point(Right + FPointerOffset,                PositionPixels  ),
                                                                            Point(Right + FPointerOffset - FPointerSize, PositionPixels  )]);
                                                                  Polyline([Point(Right + FPointerOffset,                PositionPixels+1),
                                                                            Point(Right + FPointerOffset - FPointerSize, PositionPixels+1)]);
                                                                  Polyline([Point(Right + FPointerOffset,                PositionPixels-1),
                                                                            Point(Right + FPointerOffset - FPointerSize, PositionPixels-1)]);

                                                                  ARect := Rect(Right + FPointerOffset - FPointerSize, PositionPixels-4, Right + FPointerOffset, PositionPixels+4);
                                                                  {$IFDEF iVCL}
                                                                  TiGaugePointerAccess(APointer).Region := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                                                                  {$ENDIF}
                                                                end;
                                             end;
                               ioHorizontal : case FOrientationTickMarks of
                                                iosBottomRight : begin
                                                                   Polyline([Point(Left,             Top - FPointerOffset+1               ),
                                                                             Point(Right,            Top - FPointerOffset+1               )]);
                                                                   Polyline([Point(Left,             Top - FPointerOffset+2               ),
                                                                             Point(Right,            Top - FPointerOffset+2               )]);
                                                                   Polyline([Point(Left,             Top - FPointerOffset+3               ),
                                                                             Point(Right,            Top - FPointerOffset+3               )]);
                                                                   Polyline([Point(PositionPixels-1, Top - FPointerOffset + FPointerSize+2),
                                                                             Point(PositionPixels-1, Top - FPointerOffset+2               )]);
                                                                   Polyline([Point(PositionPixels,   Top - FPointerOffset + FPointerSize+2),
                                                                             Point(PositionPixels,   Top - FPointerOffset+2               )]);
                                                                   Polyline([Point(PositionPixels+1, Top - FPointerOffset + FPointerSize+2),
                                                                             Point(PositionPixels+1, Top - FPointerOffset+2               )]);

                                                                  ARect := Rect(PositionPixels-4, Top - FPointerOffset+2, PositionPixels+4, Top - FPointerOffset + FPointerSize+2);
                                                                  {$IFDEF iVCL}
                                                                  TiGaugePointerAccess(APointer).Region := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                                                                  {$ENDIF}
                                                                 end;
                                                iosTopLeft     : begin
                                                                   Polyline([Point(Left,             Bottom + FPointerOffset-1               ),
                                                                             Point(Right,            Bottom + FPointerOffset-1               )]);
                                                                   Polyline([Point(Left,             Bottom + FPointerOffset-2               ),
                                                                             Point(Right,            Bottom + FPointerOffset-2               )]);
                                                                   Polyline([Point(Left,             Bottom + FPointerOffset-3               ),
                                                                             Point(Right,            Bottom + FPointerOffset-3               )]);
                                                                   Polyline([Point(PositionPixels-1, Bottom + FPointerOffset - FPointerSize-2),
                                                                             Point(PositionPixels-1, Bottom + FPointerOffset-2               )]);
                                                                   Polyline([Point(PositionPixels,   Bottom + FPointerOffset - FPointerSize-2),
                                                                             Point(PositionPixels,   Bottom + FPointerOffset-2               )]);
                                                                   Polyline([Point(PositionPixels+1, Bottom + FPointerOffset - FPointerSize-2),
                                                                             Point(PositionPixels+1, Bottom + FPointerOffset-2               )]);

                                                                  ARect := Rect(PositionPixels-4, Bottom + FPointerOffset - FPointerSize-2, PositionPixels+4, Bottom + FPointerOffset-2);
                                                                  {$IFDEF iVCL}
                                                                  TiGaugePointerAccess(APointer).Region := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                                                                  {$ENDIF}
                                                                end;
                                            end;
                            end;
            ilgpsColorBar : begin
                              case FOrientation of
                                ioVertical   : case FReverseScale of
                                                 False : ARect := Rect(Left, PositionPixels, Right,          Bottom        );
                                                 else    ARect := Rect(Left, Top,            Right,          PositionPixels);
                                               end;
                                ioHorizontal : case FReverseScale of
                                                 False : ARect := Rect(Left, Top,            PositionPixels, Bottom);
                                                 else    ARect := Rect(PositionPixels, Top,  Right,          Bottom);
                                               end;
                              end;

                              Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);

                              {$IFDEF iVCL}
                              TiGaugePointerAccess(APointer).Region := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                              {$ENDIF}
                            end;
            ilgpsTube     : begin
                              case FOrientation of
                                ioVertical   : case FReverseScale of
                                                 False : ARect := Rect(Left, PositionPixels, Right,          Bottom        );
                                                 else    ARect := Rect(Left, Top,            Right,          PositionPixels);
                                               end;
                                ioHorizontal : case FReverseScale of
                                                 False : ARect := Rect(Left, Top,            PositionPixels, Bottom);
                                                 else    ARect := Rect(PositionPixels, Top,  Right,          Bottom);
                                               end;
                              end;

                              iDraw.GradientTube(Canvas, ARect, PointerColor, FOrientation);

                              {$IFDEF iVCL}
                              TiGaugePointerAccess(APointer).Region := CreateRectRgn(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                              {$ENDIF}
                            end;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.DrawPointer(Canvas: TCanvas; APointer: TiGaugePointer);
var
  PositionPixels             : Integer;
  ActualOrientationTickMarks : TiOrientationSide;
  PointArray                 : Array[0..2] of TPoint;
begin
  with Canvas, FBarRect, APointer do
    begin
      if DrawScaleSide then
        case FOrientationTickMarks of
          iosBottomRight : ActualOrientationTickMarks := iosTopLeft;
          else             ActualOrientationTickMarks := iosBottomRight;
         end
      else ActualOrientationTickMarks := FOrientationTickMarks;

      PositionPixels := GetPositionPixels(Position);
      Brush.Color := Color;
      Brush.Style := bsSolid;
      Pen.Color   := Color;
      case FOrientation of
        ioVertical   : case ActualOrientationTickMarks of
                         iosBottomRight : begin
                                            PointArray[0] := Point(Left-Margin,      PositionPixels-Size div 2);
                                            PointArray[1] := Point(Left-Margin+Size, PositionPixels           );
                                            PointArray[2] := Point(Left-Margin,      PositionPixels+Size div 2);
                                          end;
                         iosTopLeft     : begin
                                            PointArray[0] := Point(Right+Margin,     PositionPixels-Size div 2);
                                            PointArray[1] := Point(Right+Margin,     PositionPixels+Size div 2);
                                            PointArray[2] := Point(Right+Margin-Size,PositionPixels           );
                                          end;
                       end;
        ioHorizontal : case ActualOrientationTickMarks of
                         iosBottomRight : begin
                                            PointArray[0] := Point(PositionPixels-Size div 2,Top-Margin     );
                                            PointArray[1] := Point(PositionPixels+Size div 2,Top-Margin     );
                                            PointArray[2] := Point(PositionPixels           ,Top-Margin+Size);
                                          end;
                         iosTopLeft     : begin
                                            PointArray[0] := Point(PositionPixels-Size div 2,Bottom+Margin     );
                                            PointArray[1] := Point(PositionPixels+Size div 2,Bottom+Margin     );
                                            PointArray[2] := Point(PositionPixels           ,Bottom+Margin-Size);
                                          end;
                       end;
      end;

    Polygon(PointArray);
    {$IFDEF iVCL}
    TiGaugePointerAccess(APointer).Region := CreatePolygonRgn(PointArray, 3, ALTERNATE);
    {$ENDIF}
  end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.DrawMinMax(Canvas: TCanvas);
begin
  if ShowMaxPointer then
    begin
      FMaxPointer.Position      := CurrentMax;
      FMaxPointer.Margin        := MinMaxPointerMargin;
      FMaxPointer.Size          := MinMaxPointerSize;
      FMaxPointer.DrawScaleSide := False;
      FMaxPointer.Color         := MaxPointerColor;

      DrawPointer(Canvas, FMaxPointer);
    end;

  if ShowMinPointer then
    begin
      FMinPointer.Position      := CurrentMin;
      FMinPointer.Margin        := MinMaxPointerMargin;
      FMinPointer.Size          := MinMaxPointerSize;
      FMinPointer.DrawScaleSide := False;
      FMinPointer.Color         := MinPointerColor;

      DrawPointer(Canvas, FMinPointer);
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.DrawLimits(Canvas: TCanvas);
var
  x        : Integer;
  APointer : TiGaugePointer;
begin
  for x := 0 to LimitCount -1 do
    begin
      if LimitShowUpperPointer[x] then
        begin
          APointer := TiGaugePointer.Create(nil);
          try
            APointer.Position      := LimitUpperValue[x];
            APointer.Margin        := LimitPointerMargin[x];
            APointer.Size          := LimitPointerSize[x];
            APointer.DrawScaleSide := LimitDrawScaleSide[x];
            APointer.Color         := LimitUpperPointerColor[x];

            DrawPointer(Canvas, APointer);
          finally
            APointer.Free;
          end;
        end;

      if LimitShowLowerPointer[x] then
        begin
          APointer := TiGaugePointer.Create(nil);
          try
            APointer.Position      := LimitLowerValue[x];
            APointer.Margin        := LimitPointerMargin[x];
            APointer.Size          := LimitPointerSize[x];
            APointer.DrawScaleSide := LimitDrawScaleSide[x];
            APointer.Color         := LimitLowerPointerColor[x];

            DrawPointer(Canvas, APointer);
          finally
            APointer.Free;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.DrawTicks(Canvas: TCanvas);
var
  MajorCount          : Double;
  MajorLoopCount      : Integer;
  MajorPosition       : Double;
  MajorPositionPixels : Integer;
  MinorPosition       : Integer;
  CenterOffset        : Integer;
  TextString          : String;
  x, y                : Integer;
  ATextHeight         : Integer;
  ATextWidth          : Integer;
  ATextMargin         : Integer;
  AMajorStyle         : TiBevelStyle;
  AMinorStyle         : TiBevelStyle;
  ARect               : TRect;
  AShowEnabled        : Boolean;
begin
  with Canvas, FBarRect do
    begin
      try
        MajorCount := Log10(PositionMax) - Log10(PositionMin);
      except
        MajorCount := 0;
      end;

      MajorLoopCount := Trunc(MajorCount);

      ATextMargin := TickLabelMargin;
      Brush.Style := bsClear;
      Font.Assign(TickLabelFont);

      if      not ShowDisabledState then AShowEnabled  := True
      else if not Enabled then           AShowEnabled  := False
      else                               AShowEnabled  := True;

      if (AShowEnabled) then
        begin
          AMajorStyle := TickMajorStyle;
          AMinorStyle := TickMinorStyle;
        end
      else
        begin
          AMajorStyle := ibsLowered;
          AMinorStyle := ibsLowered;
        end;

      for x := 0 to MajorLoopCount do
        begin
          Pen.Color           := TickMajorColor;
          MajorPosition       := PositionMin * Power(10, x);
          MajorPositionPixels := GetPositionPixels(MajorPosition);
          case Orientation of
            ioVertical : begin
                           case OrientationTickMarks of
                             iosBottomRight : LineBevel(Canvas, Right - TickMajorLength + TickMargin, MajorPositionPixels, Right + TickMargin, MajorPositionPixels, AMajorStyle);
                             iosTopLeft     : LineBevel(Canvas, Right - TickMajorLength - TickMargin, MajorPositionPixels, Right - TickMargin, MajorPositionPixels, AMajorStyle);
                           end;

                         end;
            else         begin
                           case OrientationTickMarks of
                             iosBottomRight : LineBevel(Canvas, MajorPositionPixels, Top + TickMargin, MajorPositionPixels, Top + TickMajorLength + TickMargin, AMajorStyle);
                             iosTopLeft     : LineBevel(Canvas, MajorPositionPixels, Top - TickMargin, MajorPositionPixels, Top + TickMajorLength - TickMargin, AMajorStyle);
                           end;
                         end;
          end;

          for y := 2 to 9 do
            begin
              if (PositionMin * Power(10, x) * y) > PositionMax then Break;
              Pen.Color := TickMinorColor;
              CenterOffset := (TickMajorLength div 2 - TickMinorLength div 2);
              MinorPosition := GetPositionPixels(MajorPosition + MajorPosition*(y-1));
              case Orientation of
                ioVertical   : case OrientationTickMarks of
                                 iosBottomRight : case TickMinorAlignment of
                                                    itmnaInside  : LineBevel(Canvas, Right - TickMinorLength + TickMargin, MinorPosition, Right + TickMargin, MinorPosition, AMinorStyle);
                                                    itmnaCenter  : LineBevel(Canvas, Left + CenterOffset + TickMargin, MinorPosition, Left + CenterOffset + TickMinorLength + TickMargin, MinorPosition, AMinorStyle);
                                                    itmnaOutside : LineBevel(Canvas, Left + TickMargin, MinorPosition, Left  + TickMinorLength + TickMargin, MinorPosition, AMinorStyle);
                                                  end;
                                 iosTopLeft     : case TickMinorAlignment of
                                                    itmnaInside  : LineBevel(Canvas, Left - TickMargin, MinorPosition, Left  + TickMinorLength - TickMargin, MinorPosition, AMinorStyle);
                                                    itmnaCenter  : LineBevel(Canvas, Left + CenterOffset - TickMargin, MinorPosition, Left + CenterOffset + TickMinorLength - TickMargin, MinorPosition, AMinorStyle);
                                                    itmnaOutside : LineBevel(Canvas, Right - TickMinorLength - TickMargin, MinorPosition, Right - TickMargin, MinorPosition, AMinorStyle);
                                                  end;
                               end;
                ioHorizontal : case OrientationTickMarks of
                                 iosBottomRight : case TickMinorAlignment of
                                                    itmnaInside  : LineBevel(Canvas, MinorPosition, Bottom - TickMinorLength + TickMargin, MinorPosition, Bottom + TickMargin, AMinorStyle);
                                                    itmnaCenter  : LineBevel(Canvas, MinorPosition, Top + CenterOffset + TickMargin, MinorPosition, Top + TickMinorLength + CenterOffset + TickMargin, AMinorStyle);
                                                    itmnaOutside : LineBevel(Canvas, MinorPosition, Top + TickMargin, MinorPosition, Top + TickMinorLength + TickMargin, AMinorStyle);
                                                  end;
                                 iosTopLeft     : case TickMinorAlignment of
                                                    itmnaInside  : LineBevel(Canvas, MinorPosition, Top - TickMargin, MinorPosition, Top + TickMinorLength - TickMargin, AMinorStyle);
                                                    itmnaCenter  : LineBevel(Canvas, MinorPosition, Top + CenterOffset - TickMargin, MinorPosition, Top + TickMinorLength + CenterOffset - TickMargin, AMinorStyle);
                                                    itmnaOutside : LineBevel(Canvas, MinorPosition, Bottom - TickMinorLength - TickMargin, MinorPosition, Bottom - TickMargin, AMinorStyle);
                                                  end;
                               end;
              end;
            end;

          if ShowTickLabels then
            begin
              case FTickLabelStyle of
                illsValue      : TextString  := Trim(SysUtils.Format('%.' + IntToStr(TickLabelPrecision  ) + 'f', [MajorPosition]));
                illsScientific : TextString  := Trim(SysUtils.Format('%.' + IntToStr(TickLabelPrecision+1) + 'e', [MajorPosition]));
              end;

              if Assigned(OnCustomizeTickLabel) then TOnCustomizeTickLabel(OnCustomizeTickLabel)(Self, x, TextString);

              ATextHeight := TextHeight(TextString);
              ATextWidth  := TextWidth (TextString);

              case FOrientation of
                ioVertical   : case FOrientationTickMarks of
                                 iosBottomRight : ARect := GetCenterPointRect(Right + ATextWidth div 2 + ATextMargin,  MajorPositionPixels, ATextWidth, ATextHeight);
                                 iosTopLeft     : ARect := GetCenterPointRect(Left  - ATextWidth div 2 - ATextMargin , MajorPositionPixels, ATextWidth, ATextHeight);
                               end;
                ioHorizontal : case FOrientationTickMarks of
                                 iosBottomRight : ARect := GetCenterPointRect(MajorPositionPixels, Bottom + ATextMargin + ATextHeight div 2, ATextWidth, ATextHeight);
                                 iosTopLeft     : ARect := GetCenterPointRect(MajorPositionPixels, Top    - ATextMargin - ATextHeight div 2, ATextWidth, ATextHeight);
                               end;
              end;

              iDrawText(Canvas, TextString, ARect, [itfHCenter, itfVCenter, itfSingleLine], AShowEnabled, BackGroundColor)
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiLogGauge.GetPixelsMin: Integer;
begin
  Result := GetPositionPixels(PositionMin);
end;
//****************************************************************************************************************************************************
function TiLogGauge.GetPixelsMax: Integer;
begin
  Result := GetPositionPixels(PositionMax);
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i        : Integer;
  APointer : TiGaugePointer;
begin
  if (Button = mbLeft) then
    begin
      if MinMaxUserCanMove then
        begin
          FMouseDownX := X;
          FMouseDownY := Y;
          if      ShowMinPointer {$IFDEF iVCL}and (TiGaugePointerAccess(FMinPointer).Region <> 0) and PtInRegion(TiGaugePointerAccess(FMinPointer).Region, X,Y){$ENDIF} then
            begin
              TiGaugePointerAccess(FMinPointer).MouseDown := True;
              FOldCurrentValue                            := CurrentMin;
            end
          else if ShowMaxPointer {$IFDEF iVCL}and (TiGaugePointerAccess(FMaxPointer).Region <> 0) and PtInRegion(TiGaugePointerAccess(FMaxPointer).Region, X,Y){$ENDIF} then
            begin
              TiGaugePointerAccess(FMaxPointer).MouseDown := True;
              FOldCurrentValue                            := CurrentMax;
            end;
          InvalidateChange;
        end;

    if (not TiGaugePointerAccess(FMinPointer).MouseDown) and (not TiGaugePointerAccess(FMaxPointer).MouseDown) then
      for i := 0 to PointerCount-1 do
        begin
          APointer                                 := PointerManager.Items[i];
          TiGaugePointerAccess(APointer).MouseDown := False;
          if not APointer.Visible then Continue;
          {$IFDEF iVCL}
          if PtInRegion(TiGaugePointerAccess(APointer).Region, X, Y) then
            begin
              TiGaugePointerAccess(APointer).MouseDown := True;
              FOldCurrentValue                         := APointer.Position;
              InvalidateChange;
            end;
          {$ENDIF}
        end;
    end
  else
    begin
      for i := 0 to PointerCount-1 do
        begin
          APointer := PointerManager.Items[i];
          if TiGaugePointerAccess(APointer).MouseDown and APointer.UserCanMove then
            begin
              case Forientation of
                ioHorizontal : if FReverseScale then
                                    APointer.Position := FOldCurrentValue + (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin)
                               else APointer.Position := FOldCurrentValue - (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin);
                ioVertical   : if FReverseScale then
                                    APointer.Position := FOldCurrentValue - (FMouseDownY - Y)/TravelRange*(PositionMax - PositionMin)
                               else APointer.Position := FOldCurrentValue + (FMouseDownY - Y)/TravelRange*(PositionMax - PositionMin);
              end;
              break;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  YValue   : Integer;
  i        : Integer;
  APointer : TiGaugePointer;
begin
  if TiGaugePointerAccess(FMaxPointer).MouseDown then
    begin
      case Forientation of
        ioHorizontal : if FReverseScale then
                            CurrentMax := FOldCurrentValue + (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin)
                       else CurrentMax := FOldCurrentValue - (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin);
        ioVertical   : begin
                         if FReverseScale then YValue := Y - FEndsMargin else YValue := Height - FEndsMargin - Y;
                         CurrentMax := Power(10, (Log10(PositionMax)-Log10(PositionMin)) * YValue/TravelRange + Log10(PositionMin));
                       end;
      end;
      if CurrentMin > CurrentMax then CurrentMin := CurrentMax;
    end
  else if TiGaugePointerAccess(FMinPointer).MouseDown then
    begin
      case Forientation of
        ioHorizontal : if FReverseScale then
                            CurrentMin := FOldCurrentValue + (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin)
                       else CurrentMin := FOldCurrentValue - (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin);
        ioVertical   : begin
                         if FReverseScale then YValue := Y - FEndsMargin else YValue := Height - FEndsMargin - Y;
                         CurrentMin := Power(10, (Log10(PositionMax)-Log10(PositionMin)) * YValue/TravelRange + Log10(PositionMin));
                       end;
      end;
      if CurrentMax < CurrentMin then CurrentMax := CurrentMin;
    end
  else
    begin
      for i := 0 to PointerCount-1 do
        begin
          APointer := PointerManager.Items[i];
          if TiGaugePointerAccess(APointer).MouseDown and APointer.UserCanMove then
            begin
              case Forientation of
                ioHorizontal : if FReverseScale then
                                    APointer.Position := FOldCurrentValue + (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin)
                               else APointer.Position := FOldCurrentValue - (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin);
                ioVertical   : begin
                                 if FReverseScale then YValue := Y - FEndsMargin else YValue := Height - FEndsMargin - Y;
                                 APointer.Position := Power(10, (Log10(PositionMax)-Log10(PositionMin)) * YValue/TravelRange + Log10(PositionMin));
                               end;
              end;

              if APointer.Position > PositionMax then APointer.Position := PositionMax;
              if APointer.Position < PositionMin then APointer.Position := PositionMin;
              break;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLogGauge.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i : Integer;
begin
  TiGaugePointerAccess(FMinPointer).MouseDown := False;
  TiGaugePointerAccess(FMaxPointer).MouseDown := False;

  for i := 0 to PointerCount-1 do
    begin
      if not PointerManager.Items[i].Visible then Continue;
      if TiGaugePointerAccess(PointerManager.Items[i]).MouseDown then
        begin
          {$IFDEF iVCL}
          if PtInRegion(TiGaugePointerAccess(PointerManager.Items[i]).Region, X, Y) then if Assigned(OnClickPointer) then OnClickPointer(i);
          {$ENDIF}
        end;
      TiGaugePointerAccess(PointerManager.Items[i]).MouseDown := False;
    end;
end;
//****************************************************************************************************************************************************
function TiLogGauge.GetPointerColor  : TColor;                   begin Result :=                           PointerManager.Items[0].Color; end;
function TiLogGauge.GetPointerOffSet : Integer;                  begin Result :=                           PointerManager.Items[0].Margin;end;
function TiLogGauge.GetPointerSize   : Integer;                  begin Result :=                           PointerManager.Items[0].Size;  end;
function TiLogGauge.GetPointerStyle  : TiLinearGaugePointerStyle;begin Result := TiLinearGaugePointerStyle(PointerManager.Items[0].Style);end;
//****************************************************************************************************************************************************
procedure TiLogGauge.SetPointerOffSet(const Value: Integer);                  begin PointerManager.Items[0].Margin := Value;     end;
procedure TiLogGauge.SetPointerColor (const Value: TColor);                   begin PointerManager.Items[0].Color  := Value;     end;
procedure TiLogGauge.SetPointerSize  (const Value: Integer);                  begin PointerManager.Items[0].Size   := Value;     end;
procedure TiLogGauge.SetPointerStyle (const Value: TiLinearGaugePointerStyle);begin PointerManager.Items[0].Style  := ord(Value);end;
//****************************************************************************************************************************************************
function TiLogGauge.GetPointersOffSet(Index:Integer):Integer;                  begin Result:=PointerManager.Items[Index].Margin;                          end;
function TiLogGauge.GetPointersStyle (Index:Integer):TiLinearGaugePointerStyle;begin Result:=TiLinearGaugePointerStyle(PointerManager.Items[Index].Style);end;
//****************************************************************************************************************************************************
procedure TiLogGauge.SetPointersOffSet(Index,          Value: Integer);                  begin PointerManager.Items[Index].Margin:=Value;     end;
procedure TiLogGauge.SetPointersStyle (Index: Integer; Value: TiLinearGaugePointerStyle);begin PointerManager.Items[Index].Style :=ord(Value);end;
//****************************************************************************************************************************************************
procedure TiLogGauge.InitializePointer(iGaugePointer: TiGaugePointer);
begin
  iGaugePointer.Position := 1;
  iGaugePointer.Size     := 10;
  iGaugePointer.Color    := clBlue;
  iGaugePointer.Style    := ord(ilgpsPointer);
end;
//****************************************************************************************************************************************************
end.
