{*******************************************************}
{                                                       }
{       TiSlider Component                              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSlider;{$endif}
{$ifdef iCLX}unit QiSlider;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iScaleComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiScaleComponent;{$ENDIF}

type
  TiSlider = class(TiScaleComponent)
  private
    FPositionOld                   : Double;
    FMouseDown                     : Boolean;
    FMouseDownX                    : Integer;
    FMouseDownY                    : Integer;
    FLastWheelTime                 : TDateTime;
    FKeyDown                       : Boolean;
    FPointerRect                   : TRect;
    FPointerFillRect               : TRect;
    FTrackRect                     : TRect;
    FPointerOverlap                : Integer;

    FCenterOffsetX                 : Integer;
    FCenterOffsetY                 : Integer;

    FEndsMargin                    : Integer;
    FPointerIndicatorInactiveColor : TColor;
    FPointerIndicatorActiveColor   : TColor;
    FKeyPageStepSize               : Double;
    FKeyArrowStepSize              : Double;
    FMouseWheelStepSize            : Double;
    FPointerHeight                 : Integer;
    FPointerWidth                  : Integer;
    FPointerStyle                  : TiSliderPointerStyle;
    FOrientationTickMarks          : TiOrientationSide;
    FOrientation                   : TiOrientation;
    FTrack3DMargin                 : Integer;
    FTrackColor                    : TColor;
    FTrackStyle                    : TiSliderTrackStyle;
    FShowFocusRect                 : Boolean;
    FReverseScale                  : Boolean;
    FMouseControlStyle             : TiSliderMouseControlStyle;
    FOnAutoSize                    : TNotifyEvent;
    FAutoCenter                    : Boolean;
    FPointerBitmap                 : TBitmap;
    FPointerFillEnabled            : Boolean;
    FPointerFillColor              : TColor;

    procedure SetPointerIndicatorActiveColor  (const Value: TColor);
    procedure SetPointerIndicatorInactiveColor(const Value: TColor);
    procedure SetOrientationTickMarks         (const Value: TiOrientationSide);
    procedure SetOrientation                  (const Value: TiOrientation);
    procedure SetPointerWidth                 (const Value: Integer);
    procedure SetEndsMargin                   (const Value: Integer);
    procedure SetTrackColor                   (const Value: TColor);
    procedure SetTrackStyle                   (const Value: TiSliderTrackStyle);
    procedure SetPointerStyle                 (const Value: TiSliderPointerStyle);
    procedure SetPointerHeight                (const Value: Integer);
    procedure SetShowFocusRect                (const Value: Boolean);
    procedure SetKeyArrowStepSize             (const Value: Double);
    procedure SetKeyPageStepSize              (const Value: Double);
    procedure SetMouseWheelStepSize           (const Value: Double);
    procedure SetReverseScale                 (const Value: Boolean);
    procedure SetMouseControlStyle            (const Value: TiSliderMouseControlStyle);
    procedure SetAutoCenter                   (const Value: Boolean);
    procedure SetPointerBitmap                (const Value: TBitmap);
    procedure SetPointerFillEnabled           (const Value: Boolean);
    procedure SetPointerFillColor             (const Value: TColor);
    function  GetTravelRange : Integer;

    function GetPixelsMin : Integer;
    function GetPixelsMax : Integer;
  protected
    procedure iPaintTo(Canvas: TCanvas);                                           override;

    procedure DrawBar      (Canvas: TCanvas);
    procedure DrawTicks    (Canvas: TCanvas);
    procedure DrawIndicator(Canvas: TCanvas);
    property  TravelRange : Integer read GetTravelRange;
    function  GetPixelsToPosition(Value : Integer) : Double;
    procedure CalcPoints;
    procedure CalcAutoCenterOffsets;

    procedure DoOPCPositionChangeFinished; override;

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint);            override;
    procedure iKeyUp         (var CharCode: Word; Shift: TShiftState);             override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);             override;

    procedure iDoKillFocus; override;

    {$ifdef iVCL}function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint      ): Boolean; override;{$endif}
    {$ifdef iCLX}function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; const MousePos: TPoint): Boolean; override;{$endif}

    procedure DefineProperties     (Filer: TFiler); override;
    procedure WriteKeyArrowStepSize(Writer: TWriter);
    procedure ReadKeyArrowStepSize (Reader: TReader);
    procedure WriteKeyPageStepSize (Writer: TWriter);
    procedure ReadKeyPageStepSize  (Reader: TReader);

    property OnAutoSize                    : TNotifyEvent              read FOnAutoSize                    write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    property PixelsMin                     : Integer                   read GetPixelsMin;
    property PixelsMax                     : Integer                   read GetPixelsMax;
  published
    property EndsMargin                    : Integer                   read FEndsMargin                    write SetEndsMargin                    default 5;
    property PointerIndicatorInactiveColor : TColor                    read FPointerIndicatorInactiveColor write SetPointerIndicatorInactiveColor default clBlack;
    property PointerIndicatorActiveColor   : TColor                    read FPointerIndicatorActiveColor   write SetPointerIndicatorActiveColor   default clRed;
    property PointerBitmap                 : TBitmap                   read FPointerBitmap                 write SetPointerBitmap;
    property KeyArrowStepSize              : Double                    read FKeyArrowStepSize              write SetKeyArrowStepSize;
    property KeyPageStepSize               : Double                    read FKeyPageStepSize               write SetKeyPageStepSize;
    property MouseWheelStepSize            : Double                    read FMouseWheelStepSize            write SetMouseWheelStepSize;
    property Orientation                   : TiOrientation             read FOrientation                   write SetOrientation                   default ioVertical;
    property OrientationTickMarks          : TiOrientationSide         read FOrientationTickMarks          write SetOrientationTickMarks          default iosBottomRight;
    property PointerHeight                 : Integer                   read FPointerHeight                 write SetPointerHeight                 default 10;
    property PointerStyle                  : TiSliderPointerStyle      read FPointerStyle                  write SetPointerStyle                  default ispsLed;
    property PointerWidth                  : Integer                   read FPointerWidth                  write SetPointerWidth                  default 15;
    property ShowFocusRect                 : Boolean                   read FShowFocusRect                 write SetShowFocusRect                 default True;
    property TrackColor                    : TColor                    read FTrackColor                    write SetTrackColor                    default clWhite;
    property TrackStyle                    : TiSliderTrackStyle        read FTrackStyle                    write SetTrackStyle                    default istsBox;
    property MouseControlStyle             : TiSliderMouseControlStyle read FMouseControlStyle             write SetMouseControlStyle             default ismcsSlideOnly;
    property ReverseScale                  : Boolean                   read FReverseScale                  write SetReverseScale                  default False;
    property AutoCenter                    : Boolean                   read FAutoCenter                    write SetAutoCenter                    default False;
    property PointerFillEnabled            : Boolean                   read FPointerFillEnabled            write SetPointerFillEnabled            default False;
    property PointerFillColor              : TColor                    read FPointerFillColor              write SetPointerFillColor              default clBlue;

    property ShowDisabledState                                                                                                                    default True;

    property BackGroundColor;
    property BorderStyle;
    property BackGroundPicture;
    property Transparent;


    property OffsetX;
    property OffsetY;

    property ShowTicksMajor;
    property ShowTicksMinor;
    property ShowTickLabels;
    property TickMajorCount;
    property TickMajorColor;
    property TickMajorLength;
    property TickMinorAlignment;
    property TickMinorCount;
    property TickMinorColor;
    property TickMinorLength;
    property TickMargin;
    property TickLabelMargin;
    property TickLabelFont;
    property TickLabelPrecision;
    property PrecisionStyle;
    property OnCustomizeTickLabel;

    property TickMajorStyle;
    property TickMinorStyle;
    property TabOrder;
    property TabStop                   default True;
    property OnPositionChangeFinished;
    property OnPositionChangeUser;

    property AutoScaleEnabled;
    property AutoScaleDesiredTicks;
    property AutoScaleMaxTicks;
    property AutoScaleStyle;
    property Width                    default 70;
    property Height                   default 200;
  end;

implementation

uses iComponent;
//****************************************************************************************************************************************************
constructor TiSlider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width   := 70;
  Height  := 200;
  TabStop := True;

  ShowDisabledState := True;

  FEndsMargin                    := 5;
  FPointerIndicatorInactiveColor := clBlack;
  FPointerIndicatorActiveColor   := clRed;

  FPointerHeight                 := 10;
  FPointerWidth                  := 15;
  FTrackColor                    := clWhite;
  FTrack3DMargin                 := 2;
  FShowFocusRect                 := True;

  FKeyArrowStepSize              := 1;
  FKeyPageStepSize               := 10;
  FMouseWheelStepSize            := 1;

  FPointerBitmap                 := TBitmap.Create;
  FPointerBitmap.Transparent     := True;
  FPointerBitmap.OnChange        := InvalidateChangeEvent;

  FPointerFillColor              := clBlue;

  CreateBackGroundPicture;
end;
//****************************************************************************************************************************************************
destructor TiSlider.Destroy;
begin
  FPointerBitmap.Free;
  inherited Destroy;
end;
//****************************************************************************************************************************************************
procedure TiSlider.SetPointerIndicatorActiveColor  (const Value:TColor );begin SetColorProperty  (Value,FPointerIndicatorActiveColor,  irtBackGround);end;
procedure TiSlider.SetPointerIndicatorInactiveColor(const Value:TColor );begin SetColorProperty  (Value,FPointerIndicatorInactiveColor,irtBackGround);end;
procedure TiSlider.SetPointerHeight                (const Value:Integer);begin SetIntegerProperty(Value,FPointerHeight,                irtBackGround);end;
procedure TiSlider.SetPointerWidth                 (const Value:Integer);begin SetIntegerProperty(Value,FPointerWidth,                 irtBackGround);end;
procedure TiSlider.SetEndsMargin                   (const Value:Integer);begin SetIntegerProperty(Value,FEndsMargin,                   irtBackGround);end;
procedure TiSlider.SetTrackColor                   (const Value:TColor );begin SetColorProperty  (Value,FTrackColor,                   irtBackGround);end;
procedure TiSlider.SetReverseScale                 (const Value:Boolean);begin SetBooleanProperty(Value,FReverseScale,                 irtBackGround);end;
procedure TiSlider.SetShowFocusRect                (const Value:Boolean);begin SetBooleanProperty(Value,FShowFocusRect,                irtInvalidate);end;
procedure TiSlider.SetKeyArrowStepSize             (const Value:Double );begin SetDoubleProperty (Value,FKeyArrowStepSize,             irtInvalidate);end;
procedure TiSlider.SetKeyPageStepSize              (const Value:Double );begin SetDoubleProperty (Value,FKeyPageStepSize,              irtInvalidate);end;
procedure TiSlider.SetMouseWheelStepSize           (const Value:Double );begin SetDoubleProperty (Value,FMouseWheelStepSize,           irtInvalidate);end;
procedure TiSlider.SetAutoCenter                   (const Value:Boolean);begin SetBooleanProperty(Value,FAutoCenter,                   irtBackGround);end;
procedure TiSlider.SetPointerFillEnabled           (const Value:Boolean);begin SetBooleanProperty(Value,FPointerFillEnabled,           irtBackGround);end;
procedure TiSlider.SetPointerFillColor             (const Value:TColor );begin SetColorProperty  (Value,FPointerFillColor,             irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiSlider.SetOrientationTickMarks(const Value: TiOrientationSide);
begin
  if FOrientationTickMarks <> Value then
    begin
      FOrientationTickMarks := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.SetTrackStyle(const Value: TiSliderTrackStyle);
begin
  if FTrackStyle <> Value then
    begin
      FTrackStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.SetMouseControlStyle(const Value: TiSliderMouseControlStyle);
begin
  if FMouseControlStyle <> Value then
    begin
      FMouseControlStyle := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.SetOrientation(const Value: TiOrientation);
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
procedure TiSlider.SetPointerStyle(const Value: TiSliderPointerStyle);
begin
  if FPointerStyle <> Value then
    begin
      FPointerStyle := Value;
      case FPointerStyle of
        ispsLed      : FTrack3DMargin := 2;
        ispsPointer  : FTrack3DMargin := 0;
        ispsBar      : FTrack3DMargin := 0;
        ispsLightBar : FTrack3DMargin := 0;
        ispsBarColor : FTrack3DMargin := 0;
        ispsBitmap   : FTrack3DMargin := 0;
      end;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.SetPointerBitmap(const Value: TBitmap);
begin
  FPointerBitmap.Assign(Value);
  FPointerBitmap.Transparent     := True;
  FPointerBitmap.TransparentMode := tmAuto;
end;
//****************************************************************************************************************************************************
function TiSlider.GetTravelRange: Integer;
var
  DrawRect : TRect;
begin
  DrawRect := Rect(0, 0 ,Width, Height);
  with DrawRect do
    case FOrientation of
      ioVertical   : Result := Bottom - Top  - FPointerHeight - (2 * FEndsMargin) - (2 * FTrack3DMargin);
      else           Result := Right  - Left - FPointerHeight - (2 * FEndsMargin) - (2 * FTrack3DMargin);
    end;
end;
//****************************************************************************************************************************************************
function TiSlider.GetPixelsToPosition(Value: Integer): Double;
var
  DrawRect          : TRect;
  PointRangePercent : Double;
  StartPosition     : Double;
begin
  DrawRect := Rect(0, 0 ,Width, Height);
  with DrawRect do
    case FOrientation of
      ioVertical   : if FReverseScale then StartPosition := Top    + FEndsMargin + FTrack3DMargin + FPointerHeight/2
                       else                StartPosition := Bottom - FEndsMargin - FTrack3DMargin - FPointerHeight/2;
      else           if FReverseScale then StartPosition := Right  - FEndsMargin - FTrack3DMargin - FPointerHeight/2
                       else                StartPosition := Left   + FEndsMargin + FTrack3DMargin + FPointerHeight/2;
    end;

  with DrawRect do                             
    case FOrientation of
      ioVertical   : if FReverseScale then PointRangePercent := (Value - StartPosition)/TravelRange
                       else                PointRangePercent := (StartPosition - Value)/TravelRange;
      else           if FReverseScale then PointRangePercent := (StartPosition - Value)/TravelRange
                       else                PointRangePercent := (Value - StartPosition)/TravelRange;
    end;

  if PointRangePercent > 1 then PointRangePercent := 1;
  if PointRangePercent < 0 then PointRangePercent := 0;

  Result := PointRangePercent*(PositionMax - PositionMin) + PositionMin;
end;
//****************************************************************************************************************************************************
procedure TiSlider.CalcPoints;
var
  ClientRect      : TRect;
  PointerOffset   : Integer;
  TrackWidth      : Integer;
  TrackOffet      : Integer;
begin
  FPointerRect := Rect(0,0,0,0);

  ClientRect := Rect(0, 0 ,Width-1, Height-1);

  case FPointerStyle of
    ispsLed      : begin FPointerOverlap := 0; TrackOffet := 0; end;
    ispsPointer  : begin FPointerOverlap := 4; TrackOffet := 5; end;
    ispsBitmap   : begin FPointerOverlap := 4; TrackOffet := 5; end;
    ispsBar      : begin FPointerOverlap := 4; TrackOffet := 5; end;
    ispsBarColor : begin FPointerOverlap := 4; TrackOffet := 5; end;
    ispsLightBar : begin FPointerOverlap := 4; TrackOffet := 5; end;
    else           begin FPointerOverlap := 0; TrackOffet := 0; end;
  end;

  if FReverseScale then
       PointerOffset := TravelRange - Round(TravelRange * ValuePercent(Position))
  else PointerOffset := Round(TravelRange * ValuePercent(Position));

  with ClientRect do
    begin
      TrackWidth := FPointerWidth + 2*FTrack3DMargin;
      case FOrientation of
        ioVertical   : begin
                         case FOrientationTickMarks of
                           iosTopLeft     : FTrackRect := Rect(Right-TrackOffet-TrackWidth-2,Top+FEndsMargin,Right-TrackOffet-2,           Bottom-FEndsMargin);
                           iosBottomRight : FTrackRect := Rect(Left +TrackOffet           +2,Top+FEndsMargin,Left +TrackOffet+TrackWidth+2,Bottom-FEndsMargin);
                         end;
                         with FTrackRect do
                           case FPointerStyle of
                             ispsLed      : FPointerRect:=Rect(Left+FTrack3DMargin, Bottom-FTrack3DMargin-PointerOffset-FPointerHeight,Right-FTrack3DMargin, Bottom-FTrack3DMargin-PointerOffset);
                             ispsPointer  : FPointerRect:=Rect(Left-FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset-FPointerHeight,Right+FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset);
                             ispsBitmap   : FPointerRect:=Rect(Left-FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset-FPointerHeight,Right+FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset);
                             ispsBar      : FPointerRect:=Rect(Left-FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset-FPointerHeight,Right+FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset);
                             ispsBarColor : FPointerRect:=Rect(Left-FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset-FPointerHeight,Right+FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset);
                             ispsLightBar : FPointerRect:=Rect(Left-FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset-FPointerHeight,Right+FPointerOverlap,Bottom-FTrack3DMargin-PointerOffset);
                           end;

                         with FTrackRect do
                           FPointerFillRect:=iRect(Left  + 2, Bottom -2-PointerOffset,
                                                   Right - 2, Bottom -2);
                       end;
        ioHorizontal : begin
                         case FOrientationTickMarks of
                           iosTopLeft     : FTrackRect := Rect(Left + FEndsMargin, Bottom - TrackWidth - TrackOffet -2, Right - FEndsMargin, Bottom - TrackOffet -2          );
                           iosBottomRight : FTrackRect := Rect(Left + FEndsMargin, Top    + TrackOffet              +2, Right - FEndsMargin, Top + TrackWidth + TrackOffet +2);
                         end;
                         with FTrackRect do
                           case FPointerStyle of
                             ispsLed      : FPointerRect:=Rect(Left+FTrack3DMargin+PointerOffset,Top+FTrack3DMargin, Left+FTrack3DMargin+PointerOffset+FPointerHeight,Bottom-FTrack3DMargin);
                             ispsPointer  : FPointerRect:=Rect(Left+FTrack3DMargin+PointerOffset,Top-FPointerOverlap,Left+FTrack3DMargin+PointerOffset+FPointerHeight,Bottom+FPointerOverlap);
                             ispsBitmap   : FPointerRect:=Rect(Left+FTrack3DMargin+PointerOffset,Top-FPointerOverlap,Left+FTrack3DMargin+PointerOffset+FPointerHeight,Bottom+FPointerOverlap);
                             ispsBar      : FPointerRect:=Rect(Left+FTrack3DMargin+PointerOffset,Top-FPointerOverlap,Left+FTrack3DMargin+PointerOffset+FPointerHeight,Bottom+FPointerOverlap);
                             ispsBarColor : FPointerRect:=Rect(Left+FTrack3DMargin+PointerOffset,Top-FPointerOverlap,Left+FTrack3DMargin+PointerOffset+FPointerHeight,Bottom+FPointerOverlap);
                             ispsLightBar : FPointerRect:=Rect(Left+FTrack3DMargin+PointerOffset,Top-FPointerOverlap,Left+FTrack3DMargin+PointerOffset+FPointerHeight,Bottom+FPointerOverlap);
                           end;

                         with FTrackRect do
                           FPointerFillRect:=iRect(Left+2,               Top    + 2,
                                                   Left+2+PointerOffset, Bottom - 2);
                       end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.CalcAutoCenterOffsets;
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
          Font.Assign(TickLabelFont);
          case Orientation of
            ioVertical   : ATextWidth := TextWidth (Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMax])));
            else           ATextWidth := TextHeight(Trim(Format('%.' + IntToStr(GetDecimalPoints) + 'f', [PositionMax])));
          end;
          TotalWidth := TickMargin + TickMajorLength + TickLabelMargin + ATextWidth;
        end;
    end
  else if ShowTicksMajor then TotalWidth := TickMargin + TickMajorLength
  else                        TotalWidth := 0;

  case FOrientation of
    ioVertical   : begin
                     TotalWidth := TotalWidth + FTrackRect.Right - FTrackRect.Left + FPointerOverlap;
                     FCenterOffsetX := (Width - TotalWidth) div 2;
                   end;
    ioHorizontal : begin
                     TotalWidth     := TotalWidth + FTrackRect.Bottom - FTrackRect.Top + FPointerOverlap;
                     FCenterOffsetY := (Height - TotalWidth) div 2;
                   end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.iPaintTo(Canvas: TCanvas);
begin
  CalcPoints;
  CalcAutoCenterOffsets;

  case FOrientation of
    ioVertical   : begin
                     case FOrientationTickMarks of
                       iosBottomRight : begin
                                          OffsetRect(FTrackRect,       OffsetX, 0);
                                          OffsetRect(FPointerRect,     OffsetX, 0);
                                          OffsetRect(FPointerFillRect, OffsetX, 0);

                                          OffsetRect(FTrackRect,       FCenterOffsetX, 0);
                                          OffsetRect(FPointerRect,     FCenterOffsetX, 0);
                                          OffsetRect(FPointerFillRect, FCenterOffsetX, 0);
                                        end;
                       iosTopLeft     : begin
                                          OffsetRect(FTrackRect,       -OffsetX, 0);
                                          OffsetRect(FPointerRect,     -OffsetX, 0);
                                          OffsetRect(FPointerFillRect, -OffsetX, 0);

                                          OffsetRect(FTrackRect,       -FCenterOffsetX, 0);
                                          OffsetRect(FPointerRect,     -FCenterOffsetX, 0);
                                          OffsetRect(FPointerFillRect, -FCenterOffsetX, 0);
                                        end;
                     end;
                   end;
    ioHorizontal : begin
                     case FOrientationTickMarks of
                       iosBottomRight : begin
                                          OffsetRect(FTrackRect,       0, OffsetY);
                                          OffsetRect(FPointerRect,     0, OffsetY);
                                          OffsetRect(FPointerFillRect, 0, OffsetY);

                                          OffsetRect(FTrackRect,       0, FCenterOffsetY);
                                          OffsetRect(FPointerRect,     0, FCenterOffsetY);
                                          OffsetRect(FPointerFillRect, 0, FCenterOffsetY);
                                        end;
                       iosTopLeft     : begin
                                          OffsetRect(FTrackRect,       0, -OffsetY);
                                          OffsetRect(FPointerRect,     0, -OffsetY);
                                          OffsetRect(FPointerFillRect, 0, -OffsetY);

                                          OffsetRect(FTrackRect,       0, -FCenterOffsetY);
                                          OffsetRect(FPointerRect,     0, -FCenterOffsetY);
                                          OffsetRect(FPointerFillRect, 0, -FCenterOffsetY);
                                        end;
                     end;
                   end;
  end;

  DrawBackGround(Canvas, BackGroundColor);
  DrawBar       (Canvas);
  DrawTicks     (Canvas);
  DrawIndicator (Canvas);

  if FShowFocusRect and HasFocus then iDrawFocusRect(Canvas, ClientRect, BackGroundColor);
end;
//****************************************************************************************************************************************************
procedure TiSlider.DrawBar(Canvas: TCanvas);
begin
  with Canvas, FTrackRect do
    begin
      Brush.Style := bsSolid;
      case FTrackStyle of
        istsBox          : begin
                             if Enabled or not ShowDisabledState then Brush.Color := FTrackColor
                             else                                     Brush.Color := BackGroundColor;
                             
                             FillRect(FTrackRect);
                             Pen.Color := clBtnShadow;
                             PolyLine([Point(Right,Top), Point (Left, Top), Point(Left, Bottom)]);
                             if BackGroundColor = clWhite then Pen.Color := clBlack;
                             PolyLine([Point(Right-1,Top+1), Point (Left+1, Top+1), Point(Left+1, Bottom-1)]);
                             Pen.Color := clBtnHighlight;
                             PolyLine([Point(Right-1,Top), Point (Right-1, Bottom-1), Point(Left, Bottom-1)]);
                             Pen.Color := clSilver;
                             PolyLine([Point(Right-2,Top+2), Point (Right-2, Bottom-2), Point(Left, Bottom-2)]);
                           end;
        istsLine         : begin
                             case FOrientation of
                               ioHorizontal : begin
                                                Pen.Color := FTrackColor;
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2),Point(Right-FTrack3DMargin,(Top+Bottom)div 2)]);
                                              end;
                               ioVertical   : begin
                                                Pen.Color := FTrackColor;
                                                PolyLine([Point((Left+Right)div 2,Top+FTrack3DMargin),Point((Left+Right)div 2,Bottom-FTrack3DMargin)]);
                                              end;
                             end;
                           end;
        istsBevelLowered : begin
                             case FOrientation of
                               ioHorizontal : begin
                                                Pen.Color := clBtnShadow;
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2 -2),Point(Right-FTrack3DMargin,(Top+Bottom)div 2- 2)]);
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2 -1),Point(Right-FTrack3DMargin,(Top+Bottom)div 2- 1)]);
                                                Pen.Color := clBtnHighlight;
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2 +0),Point(Right-FTrack3DMargin,(Top+Bottom)div 2+ 0)]);
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2 +1),Point(Right-FTrack3DMargin,(Top+Bottom)div 2+ 1)]);
                                              end;
                               ioVertical   : begin
                                                Pen.Color := clBtnShadow;
                                                PolyLine([Point((Left+Right)div 2 -2,Top+FTrack3DMargin),Point((Left+Right)div 2 -2, Bottom-FTrack3DMargin)]);
                                                PolyLine([Point((Left+Right)div 2 -1,Top+FTrack3DMargin),Point((Left+Right)div 2 -1, Bottom-FTrack3DMargin)]);
                                                Pen.Color := clBtnHighlight;
                                                PolyLine([Point((Left+Right)div 2 +0,Top+FTrack3DMargin),Point((Left+Right)div 2 +0, Bottom-FTrack3DMargin)]);
                                                PolyLine([Point((Left+Right)div 2 +1,Top+FTrack3DMargin),Point((Left+Right)div 2 +1, Bottom-FTrack3DMargin)]);
                                              end;
                             end;
                           end;
        istsBevelRasied  : begin
                             case FOrientation of
                               ioHorizontal : begin
                                                Pen.Color := clBtnHighlight;
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2 -2),Point(Right-FTrack3DMargin,(Top+Bottom)div 2 -2)]);
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2 -1),Point(Right-FTrack3DMargin,(Top+Bottom)div 2 -1)]);
                                                Pen.Color := clBtnShadow;
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2 +0),Point(Right-FTrack3DMargin,(Top+Bottom)div 2 +0)]);
                                                PolyLine([Point(Left+FTrack3DMargin,(Top+Bottom)div 2 +1),Point(Right-FTrack3DMargin,(Top+Bottom)div 2 +1)]);
                                              end;
                               ioVertical   : begin
                                                Pen.Color := clBtnHighlight;
                                                PolyLine([Point((Left+Right)div 2 -2,Top+FTrack3DMargin),Point((Left+Right)div 2 -2,Bottom-FTrack3DMargin)]);
                                                PolyLine([Point((Left+Right)div 2 -1,Top+FTrack3DMargin),Point((Left+Right)div 2 -1,Bottom-FTrack3DMargin)]);
                                                Pen.Color := clBtnShadow;
                                                PolyLine([Point((Left+Right)div 2 +0,Top+FTrack3DMargin),Point((Left+Right)div 2 +0,Bottom-FTrack3DMargin)]);
                                                PolyLine([Point((Left+Right)div 2 +1,Top+FTrack3DMargin),Point((Left+Right)div 2 +1,Bottom-FTrack3DMargin)]);
                                              end;
                             end;
                           end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.DrawIndicator(Canvas: TCanvas);
var
  Point1             : TPoint;
  Point2             : TPoint;
  Point3             : TPoint;
  Point4             : TPoint;
  Point5             : TPoint;
  IndicatorInnerRect : TRect;
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;

      if FPointerFillEnabled then
        begin
          Pen.Color   := FPointerFillColor;
          Brush.Color := FPointerFillColor;
          Rectangle(FPointerFillRect.Left, FPointerFillRect.Top, FPointerFillRect.Right, FPointerFillRect.Bottom);
        end;

      with FPointerRect do
        case FPointerStyle of
          ispsLed  :    begin

                          Pen.Color   := clBtnFace;
                          Brush.Color := clBtnFace;
                          Rectangle(Left, Top, Right, Bottom);

                          if FMouseDown or FKeyDown then
                            begin
                              Pen.Color   := FPointerIndicatorActiveColor;
                              Brush.Color := FPointerIndicatorActiveColor;
                            end
                          else
                            begin
                              Pen.Color   := FPointerIndicatorInactiveColor;
                              Brush.Color := FPointerIndicatorInactiveColor;
                            end;

                          IndicatorInnerRect := Rect(Left+1, Top+1, Right-2, Bottom-2);

                          with IndicatorInnerRect do
                            begin
                              Rectangle(Left, Top, Right, Bottom);
                              Pen.Color := clGray;  Polyline([Point(Left,  Bottom), Point(Left, Top), Point(Right, Top)]); // Draw Indicator 3D Sunken;
                              Pen.Color := clWhite; Polyline([Point(Left + 2, Top + 2), Point(Left + 4, Top + 2)]);        // Draw Indicator Reflection
                            end;

                        end;
          ispsBar :     begin
                          Pen.Color   := clBtnFace;
                          if FMouseDown then Brush.Color := clBtnHighlight else Brush.Color := clBtnFace;
                          Rectangle(Left, Top, Right, Bottom);

                          Pen.Color   := clWhite; PolyLine([Point(Left,  Bottom), Point(Left,  Top   ), Point(Right, Top   )]);
                          Pen.Color   := clBlack; PolyLine([Point(Right, Top   ), Point(Right, Bottom), Point(Left,  Bottom)]);
                        end;
          ispsBarColor :begin
                          if FMouseDown then Brush.Color := FPointerIndicatorActiveColor else Brush.Color := FPointerIndicatorInactiveColor;
                          Pen.Color   := Brush.Color;
                          Rectangle(Left, Top, Right, Bottom);

                          Pen.Color   := clWhite; PolyLine([Point(Left,  Bottom), Point(Left,  Top   ), Point(Right, Top   )]);
                          Pen.Color   := clBlack; PolyLine([Point(Right, Top   ), Point(Right, Bottom), Point(Left,  Bottom)]);
                        end;
          ispsLightBar :begin
                          Pen.Color   := clBtnFace;
                          Brush.Color := clBtnFace;
                          Rectangle(Left, Top, Right, Bottom);

                          Pen.Color   := clWhite; PolyLine([Point(Left,  Bottom), Point(Left,  Top   ), Point(Right, Top   )]);
                          Pen.Color   := clBlack; PolyLine([Point(Right, Top   ), Point(Right, Bottom), Point(Left,  Bottom)]);

                          if FMouseDown then
                            begin
                              case FOrientation of
                                ioHorizontal : begin
                                                 Pen.Color :=clBlack;                     Line(Canvas, (Left+Right)div 2 -1,Top+1,(Left+Right)div 2 -1,Bottom-1);
                                                 Pen.Color :=FPointerIndicatorActiveColor;Line(Canvas, (Left+Right)div 2 +0,Top+1,(Left+Right)div 2 +0,Bottom-1);
                                                 Pen.Color :=clWhite;                     Line(Canvas, (Left+Right)div 2 +1,Top+1,(Left+Right)div 2 +1,Bottom-1);
                                               end;
                                ioVertical   : begin
                                                 Pen.Color :=clBlack;                     Line(Canvas, Left+1,(Top+Bottom)div 2 -1,Right-1,(Top+Bottom)div 2 -1);
                                                 Pen.Color :=FPointerIndicatorActiveColor;Line(Canvas, Left+1,(Top+Bottom)div 2 +0,Right-1,(Top+Bottom)div 2 +0);
                                                 Pen.Color :=clWhite;                     Line(Canvas, Left+1,(Top+Bottom)div 2 +1,Right-1,(Top+Bottom)div 2 +1);
                                               end;
                              end;
                            end
                          else
                            begin
                              case FOrientation of
                                ioHorizontal : begin
                                                 Pen.Color :=clBlack;                       Line(Canvas, (Left+Right)div 2 -1,Top+1,(Left+Right)div 2 -1,Bottom-1);
                                                 Pen.Color :=FPointerIndicatorInactiveColor;Line(Canvas, (Left+Right)div 2 +0,Top+1,(Left+Right)div 2 +0,Bottom-1);
                                                 Pen.Color :=clWhite;                       Line(Canvas, (Left+Right)div 2 +1,Top+1,(Left+Right)div 2 +1,Bottom-1);
                                               end;
                                ioVertical   : begin
                                                 Pen.Color :=clBlack;                       Line(Canvas, Left+1,(Top+Bottom)div 2 -1,Right-1,(Top+Bottom)div 2 -1);
                                                 Pen.Color :=FPointerIndicatorInactiveColor;Line(Canvas, Left+1,(Top+Bottom)div 2 +0,Right-1,(Top+Bottom)div 2 +0);
                                                 Pen.Color :=clWhite;                       Line(Canvas, Left+1,(Top+Bottom)div 2 +1,Right-1,(Top+Bottom)div 2 +1);
                                               end;
                              end;
                            end;
                              
                        end;
          ispsPointer : begin
                          Pen.Color   := clBlack;
                          if FMouseDown then Brush.Color := clBtnHighlight else Brush.Color := clBtnFace;

                          case FOrientation of
                            ioVertical   : case FOrientationTickMarks of
                                             iosTopLeft     : begin
                                                                Point1 := Point(Right, Top);
                                                                Point2 := Point(Left + (Bottom - Top) div 2, Top);
                                                                Point3 := Point(Left,  (Bottom + Top) div 2);
                                                                Point4 := Point(Left + (Bottom - Top) div 2, Bottom);
                                                                Point5 := Point(Right, Bottom);
                                                                Polygon([Point1, Point2, Point3, Point4, Point5]);
                                                                Pen.Color := clWhite; PolyLine([Point1, Point2, Point3]);
                                                              end;
                                             iosBottomRight : begin
                                                                Point1 := Point(Left, Top);
                                                                Point2 := Point(Right - (Bottom - Top) div 2, Top);
                                                                Point3 := Point(Right,  (Bottom + Top) div 2);
                                                                Point4 := Point(Right - (Bottom - Top) div 2, Bottom);
                                                                Point5 := Point(Left, Bottom);
                                                                Polygon([Point1, Point2, Point3, Point4, Point5]);
                                                                Pen.Color := clWhite; PolyLine([Point5, Point1, Point2, Point3]);
                                                              end;
                                          end;
                            ioHorizontal : case FOrientationTickMarks of
                                             iosTopLeft     : begin
                                                                Point1 := Point(Left, Bottom);
                                                                Point2 := Point(Left, Top + (Right - Left) div 2);
                                                                Point3 := Point((Right + Left) div 2, Top);
                                                                Point4 := Point(Right, Top + (Right - Left) div 2);
                                                                Point5 := Point(Right, Bottom);
                                                                Polygon([Point1, Point2, Point3, Point4, Point5]);
                                                                Pen.Color := clWhite; PolyLine([Point1, Point2, Point3]);
                                                              end;
                                             iosBottomRight : begin
                                                                Point1 := Point(Left, Top);
                                                                Point2 := Point(Left, Bottom - (Right - Left) div 2);
                                                                Point3 := Point((Right + Left) div 2, Bottom);
                                                                Point4 := Point(Right, Bottom - (Right - Left) div 2);
                                                                Point5 := Point(Right, Top);
                                                                Polygon([Point1, Point2, Point3, Point4, Point5]);
                                                                Pen.Color := clWhite; PolyLine([Point5, Point1, Point2, Point3]);
                                                              end;
                                           end;
                          end;
                        end;
          ispsBitmap  : begin
                          Draw((Left + Right) div 2 - FPointerBitmap.Width div 2, (Top + Bottom) div 2 - FPointerBitmap.Height div 2, FPointerBitmap);
                        end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.DrawTicks(Canvas: TCanvas);
begin
  ScaleObject.PositionMax          := PositionMax;
  ScaleObject.PositionMin          := PositionMin;               
  ScaleObject.Orientation          := FOrientation;
  ScaleObject.OrientationTickMarks := FOrientationTickMarks;
  ScaleObject.ReverseScale         := FReverseScale;

  case FOrientation of
    ioVertical    : begin
                     ScaleObject.Start := FTrackRect.Bottom - FTrack3DMargin - (FPointerHeight div 2)-1;
                     ScaleObject.Stop  := FTrackRect.Top    + FTrack3DMargin + (FPointerHeight div 2);
                     case FOrientationTickMarks of
                       iosBottomRight : ScaleObject.Edge  := FTrackRect.Right;
                       iosTopLeft     : ScaleObject.Edge  := FTrackRect.Left;
                     end;
                  end;
    ioHorizontal : begin
                     ScaleObject.Start := FTrackRect.Left  + FTrack3DMargin + (FPointerHeight div 2);
                     ScaleObject.Stop  := FTrackRect.Right - FTrack3DMargin - (FPointerHeight div 2);
                     case FOrientationTickMarks of
                       iosBottomRight : ScaleObject.Edge  := FTrackRect.Bottom;
                       iosTopLeft     : ScaleObject.Edge  := FTrackRect.Top;
                     end;
                   end;
  end;

  if ShowDisabledState then ScaleObject.Draw(Canvas, Enabled, BackGroundColor)
  else                      ScaleObject.Draw(Canvas, True,    BackGroundColor);
end;
//****************************************************************************************************************************************************
function TiSlider.GetPixelsMin: Integer;
begin
  if (not ReverseScale) then Result := ScaleObject.Start else Result := ScaleObject.Stop;
end;
//****************************************************************************************************************************************************
function TiSlider.GetPixelsMax: Integer;
begin
  if (not ReverseScale) then Result := ScaleObject.Stop else Result := ScaleObject.Start;
end;
//****************************************************************************************************************************************************
procedure TiSlider.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AfterPointer  : Boolean;
  BeforePointer : Boolean;
begin
  if Button = mbLeft then
    begin
      PositionDirty := False;
      SetFocus;
      UserGenerated := True;
      try
        case FMouseControlStyle of
          ismcsSlideOnly : begin
                             FMouseDown   := True;
                             FMouseDownX  := X;
                             FMouseDownY  := Y;
                             FPositionOld := Position;
                           end;
          ismcsSlidePage : begin
                             AfterPointer  := False;
                             BeforePointer := False;
                             case FOrientation of
                               ioVertical   : begin
                                                if (X < FPointerRect.Left) or (X > FPointerRect.Right) then exit;
                                                if FReverseScale then
                                                  begin
                                                    if Y < FPointerRect.Top    then BeforePointer := True;
                                                    if Y > FPointerRect.Bottom then AfterPointer  := True;
                                                  end
                                                else
                                                  begin
                                                    if Y < FPointerRect.Top    then AfterPointer  := True;
                                                    if Y > FPointerRect.Bottom then BeforePointer := True;
                                                  end;
                                              end;
                               else           begin
                                                if (Y < FPointerRect.Top) or (Y > FPointerRect.Bottom) then exit;
                                                if FReverseScale then
                                                  begin
                                                    if X < FPointerRect.Left   then AfterPointer  := True;
                                                    if X > FPointerRect.Right  then BeforePointer := True;
                                                  end
                                                else
                                                  begin
                                                    if X < FPointerRect.Left   then BeforePointer := True;
                                                    if X > FPointerRect.Right  then AfterPointer  := True;
                                                  end;
                                              end;
                             end;
                             if BeforePointer then Position := Position - FKeyPageStepSize
                               else if AfterPointer then Position := Position + FKeyPageStepSize
                                 else
                                   begin
                                     FMouseDown   := True;
                                     FMouseDownX  := X;
                                     FMouseDownY  := Y;
                                     FPositionOld := Position;
                                   end;
                           end;
          ismcsGoto      : begin
                             case FOrientation of
                               ioVertical   : Position := GetPixelsToPosition(y);
                               else           Position := GetPixelsToPosition(x);
                             end;
                             FMouseDown   := True;
                           end;

        end;
      finally
        UserGenerated := False;
      end;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      UserGenerated := True;
      try
        case FMouseControlStyle of
          ismcsSlideOnly : begin
                             if (TravelRange = 0) then
                               begin
                                 if (FMouseDownX - X) < 0 then Position := PositionMax
                                 else                          Position := PositionMin
                               end
                             else
                               case Forientation of
                                 ioHorizontal : if FReverseScale then
                                                     Position := FPositionOld + (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin)
                                                else Position := FPositionOld - (FMouseDownX - X)/TravelRange*(PositionMax - PositionMin);
                                 ioVertical   : if FReverseScale then
                                                     Position := FPositionOld - (FMouseDownY - Y)/TravelRange*(PositionMax - PositionMin)
                                                else Position := FPositionOld + (FMouseDownY - Y)/TravelRange*(PositionMax - PositionMin);
                               end;
                           end;
          ismcsSlidePage,
          ismcsGoto      : begin
                             case FOrientation of
                               ioVertical   : Position := GetPixelsToPosition(y);
                               else           Position := GetPixelsToPosition(x);
                             end;
                           end;
        end;
      finally
        UserGenerated := False;
      end;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  InvalidateChange;
  if FMouseDown  then
    begin
      FMouseDown := False;
      DoPositionChangeFinished;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1 else Result := 0;
end;
//****************************************************************************************************************************************************
procedure TiSlider.iKeyUp(var CharCode: Word; Shift: TShiftState);
begin
  inherited;
  InvalidateChange;
  if FKeyDown then
    begin
      FKeyDown := False;
      if PositionDirty then DoPositionChangeFinished;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlider.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  FKeyDown := True;
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
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiSlider.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('KeyArrowStepSize_2', ReadKeyArrowStepSize, WriteKeyArrowStepSize, True);
  Filer.DefineProperty('KeyPageStepSize_2',  ReadKeyPageStepSize, WriteKeyPageStepSize, True);
end;
//****************************************************************************************************************************************************
procedure TiSlider.ReadKeyArrowStepSize(Reader: TReader);
begin
  FKeyArrowStepSize := Reader.ReadFloat;
end;
//****************************************************************************************************************************************************
procedure TiSlider.ReadKeyPageStepSize(Reader: TReader);
begin
  FKeyPageStepSize := Reader.ReadFloat;
end;
//****************************************************************************************************************************************************
procedure TiSlider.WriteKeyArrowStepSize(Writer: TWriter);
begin
  Writer.WriteFloat(FKeyArrowStepSize);
end;
//****************************************************************************************************************************************************
procedure TiSlider.WriteKeyPageStepSize(Writer: TWriter);
begin
  Writer.WriteFloat(FKeyPageStepSize);
end;
//****************************************************************************************************************************************************
procedure TiSlider.DoOPCPositionChangeFinished;
begin
  OPCOutputData('Position', Position);
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}function TiSlider.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint      ): Boolean;{$endif}
{$ifdef iCLX}function TiSlider.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; const MousePos: TPoint): Boolean;{$endif}
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
procedure TiSlider.iDoKillFocus;
begin
  inherited;
  FMouseDown := False;
  FKeyDown   := False;
end;
//****************************************************************************************************************************************************
end.
