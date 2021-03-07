{*******************************************************}
{                                                       }
{       TiSwitchSlider Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchSlider;{$endif}
{$ifdef iCLX}unit QiSwitchSlider;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iSwitchMultiPosition;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiSwitchMultiPosition;{$ENDIF}

type
  TiSwitchSlider = class(TiSwitchMultiPosition)
  private
    FEndsMargin                    : Integer;
    FPositionOld                   : Double;
    FPointerIndicatorInactiveColor : TColor;
    FPointerIndicatorActiveColor   : TColor;
    FOrientationLabels             : TiOrientationSide;
    FOrientation                   : TiOrientation;
    FPointerHeight                 : Integer;
    FPointerStyle                  : TiSliderPointerStyle;
    FPointerWidth                  : Integer;
    FTrack3DMargin                 : Integer;
    FTrackColor                    : TColor;
    FTrackStyle                    : TiSliderTrackStyle;
    FPositionIndicatorStyle        : TiSwitchSliderIndicatorStyle;
    FOnAutoSize                    : TNotifyEvent;
    FTrackRect                     : TRect;
    FIndicatorRect                 : TRect;
    FIndicatorOverlap              : Integer;
    FAutoCenter                    : Boolean;
    FCenterOffsetX                 : Integer;
    FCenterOffsetY                 : Integer;
    FPointerHighLightColor         : TColor;
    FPointerColor                  : TColor;
    FPointerBitmap                 : TBitmap;

    function  GetTravelRange : Integer;

    procedure SetEndsMargin                   (const Value: Integer);
    procedure SetPointerIndicatorActiveColor  (const Value: TColor);
    procedure SetPointerIndicatorInactiveColor(const Value: TColor);
    procedure SetOrientationLabels            (const Value: TiOrientationSide);
    procedure SetOrientation                  (const Value: TiOrientation);
    procedure SetPointerHeight                (const Value: Integer);
    procedure SetPointerStyle                 (const Value: TiSliderPointerStyle);
    procedure SetPointerWidth                 (const Value: Integer);
    procedure SetTrackColor                   (const Value: TColor);
    procedure SetTrackStyle                   (const Value: TiSliderTrackStyle);
    procedure SetPositionIndicatorStyle       (const Value: TiSwitchSliderIndicatorStyle);
    procedure SetAutoCenter                   (const Value: Boolean);
    procedure SetPointerColor                 (const Value: TColor);
    procedure SetPointerHighLightColor        (const Value: TColor);
    procedure SetPointerBitmap                (const Value: TBitmap);
  protected
    procedure iPaintTo(Canvas: TCanvas);                                           override;
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;
    property  TravelRange : Integer read GetTravelRange;
    procedure DrawTrack    (Canvas: TCanvas; TrackRect: TRect);
    procedure DrawTicks    (Canvas: TCanvas; TrackRect: TRect);
    procedure DrawIndicator(Canvas: TCanvas; IndicatorRect : TRect);

    procedure CalcPoints;
    procedure CalcAutoCenterOffsets;

    property OnAutoSize                    : TNotifyEvent                 read FOnAutoSize                    write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;
  published
    property EndsMargin                    : Integer                      read FEndsMargin                    write SetEndsMargin                     default 5;
    property PointerIndicatorActiveColor   : TColor                       read FPointerIndicatorActiveColor   write SetPointerIndicatorActiveColor    default clRed;
    property PointerIndicatorInactiveColor : TColor                       read FPointerIndicatorInactiveColor write SetPointerIndicatorInactiveColor  default clBlack;
    property PointerBitmap                 : TBitmap                      read FPointerBitmap                 write SetPointerBitmap;
    property PositionIndicatorStyle        : TiSwitchSliderIndicatorStyle read FPositionIndicatorStyle        write SetPositionIndicatorStyle         default issisDot;
    property Orientation                   : TiOrientation                read FOrientation                   write SetOrientation                    default ioVertical;
    property OrientationLabels             : TiOrientationSide            read FOrientationLabels             write SetOrientationLabels              default iosBottomRight;
    property PointerHeight                 : Integer                      read FPointerHeight                 write SetPointerHeight                  default 8;
    property PointerStyle                  : TiSliderPointerStyle         read FPointerStyle                  write SetPointerStyle                   default ispsPointer;
    property PointerWidth                  : Integer                      read FPointerWidth                  write SetPointerWidth                   default 13;
    property PointerColor                  : TColor                       read FPointerColor                  write SetPointerColor                   default clBtnFace;
    property PointerHighLightColor         : TColor                       read FPointerHighLightColor         write SetPointerHighLightColor          default clBtnHighlight;
    property TrackColor                    : TColor                       read FTrackColor                    write SetTrackColor                     default clWhite;
    property TrackStyle                    : TiSliderTrackStyle           read FTrackStyle                    write SetTrackStyle                     default istsBox;
    property AutoCenter                    : Boolean                      read FAutoCenter                    write SetAutoCenter                     default False;

    property ShowDisabledState                                                                                                                        default True;

    property BackGroundPicture;
    property BackGroundColor;
    property Transparent;
    property OffsetX;
    property OffsetY;
    property BorderStyle;

    property Width            default 80;
    property Height           default 80;
  end;

implementation
//*************************************************************************************************************************************
constructor TiSwitchSlider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 80;
  Height := 80;

  ShowDisabledState := True;

  FEndsMargin                    := 5;
  FPointerIndicatorInactiveColor := clBlack;
  FPointerIndicatorActiveColor   := clRed;
  FPointerStyle                  := ispsPointer;
  FPointerColor                  := clBtnFace;
  FPointerHighLightColor         := clBtnHighlight;

  FPointerHeight                 := 8;
  FPointerWidth                  := 13;
  FTrackColor                    := clWhite;
  FTrack3DMargin                 := 0;
  FMaxPositionCount              := 32;

  PositionLabels                 := 'Low, Medium, High';

  FPointerBitmap := TBitmap.Create;
  FPointerBitmap.Transparent := True;
  FPointerBitmap.OnChange    := InvalidateChangeEvent;

  CreateBackGroundPicture;
end;
//****************************************************************************************************************************************************
destructor TiSwitchSlider.Destroy;
begin
  FPointerBitmap.Free;
  inherited Destroy;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.SetEndsMargin                   (const Value:Integer);begin SetIntegerProperty(Value,FEndsMargin,                   irtInvalidate);end;
procedure TiSwitchSlider.SetPointerIndicatorActiveColor  (const Value:TColor); begin SetColorProperty  (Value,FPointerIndicatorActiveColor,  irtInvalidate);end;
procedure TiSwitchSlider.SetPointerIndicatorInactiveColor(const Value:TColor); begin SetColorProperty  (Value,FPointerIndicatorInactiveColor,irtInvalidate);end;
procedure TiSwitchSlider.SetPointerHeight                (const Value:Integer);begin SetIntegerProperty(Value,FPointerHeight,                irtInvalidate);end;
procedure TiSwitchSlider.SetPointerWidth                 (const Value:Integer);begin SetIntegerProperty(Value,FPointerWidth,                 irtInvalidate);end;
procedure TiSwitchSlider.SetTrackColor                   (const Value:TColor); begin SetColorProperty  (Value,FTrackColor,                   irtInvalidate);end;
procedure TiSwitchSlider.SetAutoCenter                   (const Value:Boolean);begin SetBooleanProperty(Value,FAutoCenter,                   irtBackGround);end;
procedure TiSwitchSlider.SetPointerColor                 (const Value: TColor);begin SetColorProperty  (Value, FPointerColor,                irtBackGround);end;
procedure TiSwitchSlider.SetPointerHighLightColor        (const Value: TColor);begin SetColorProperty  (Value, FPointerHighLightColor,       irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiSwitchSlider.SetOrientationLabels(const Value: TiOrientationSide);
begin
  if FOrientationLabels <> Value then
    begin
      FOrientationLabels := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.SetTrackStyle(const Value: TiSliderTrackStyle);
begin
  if FTrackStyle <> Value then
    begin
      FTrackStyle := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.SetPositionIndicatorStyle(const Value: TiSwitchSliderIndicatorStyle);
begin
  if FPositionIndicatorStyle <> Value then
    begin
      FPositionIndicatorStyle := Value;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.SetPointerBitmap(const Value: TBitmap);
begin
  FPointerBitmap.Assign(Value);
  FPointerBitmap.Transparent     := True;
  FPointerBitmap.TransparentMode := tmAuto;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    begin
      SetFocus;
      FMouseDown   := True;
      FPositionOld := Position;
      MouseMove(Shift, X, Y);
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FMouseDown then
    begin
      UserGenerated := True;
      try
        case Forientation of
          ioHorizontal : Position := Round((X - (EndsMargin + FTrack3DMargin + FPointerHeight div 2)) /(TravelRange/(PositionLabelsList.Count-1)));
          ioVertical   : Position := Round((Height - Y - (EndsMargin + FTrack3DMargin + FPointerHeight div 2)) /(TravelRange/(PositionLabelsList.Count-1)));
        end;
      finally
        UserGenerated := False;
      end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  InvalidateChange;
  if FMouseDown  then
    begin
      FMouseDown := False;
      DoPositionChangeFinished;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.SetOrientation(const Value: TiOrientation);
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
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.SetPointerStyle(const Value: TiSliderPointerStyle);
begin
  if FPointerStyle <> Value then
    begin
      FPointerStyle := Value;
      case FPointerStyle of
        ispsLed      : FTrack3DMargin := 2;
        ispsPointer  : FTrack3DMargin := 0;
        ispsBitmap   : FTrack3DMargin := 0;
        ispsBar      : FTrack3DMargin := 0;
        ispsBarColor : FTrack3DMargin := 0;
        ispsLightBar : FTrack3DMargin := 0;
      end;
      InvalidateChange;
    end;
end;
//*************************************************************************************************************************************
function TiSwitchSlider.GetTravelRange: Integer;
var
  DrawRect : TRect;
begin
  DrawRect := Rect(0, 0 ,Width, Height);
  with DrawRect do
    case Forientation of
      ioHorizontal : Result := Right  - Left - FPointerHeight - (2 * FEndsMargin) - (2 * FTrack3DMargin);
      ioVertical   : Result := Bottom - Top  - FPointerHeight - (2 * FEndsMargin) - (2 * FTrack3DMargin);
      else           Result := 0;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.CalcPoints;
var
  ClientRect       : TRect;
  TrackWidth       : Integer;
  TrackOffet       : Integer;
  IndicatorOffset  : Integer;
begin
  ClientRect := Rect(0, 0 ,Width-1, Height-1);

  case FPointerStyle of
    ispsLed      : begin FIndicatorOverlap := 0; TrackOffet := 0; end;
    ispsPointer  : begin FIndicatorOverlap := 4; TrackOffet := 5; end;
    ispsBitmap   : begin FIndicatorOverlap := 4; TrackOffet := 5; end;
    ispsBar      : begin FIndicatorOverlap := 4; TrackOffet := 5; end;
    ispsBarColor : begin FIndicatorOverlap := 4; TrackOffet := 5; end;
    ispsLightBar : begin FIndicatorOverlap := 4; TrackOffet := 5; end;
    else           begin FIndicatorOverlap := 0; TrackOffet := 0; end;
  end;

  IndicatorOffset := Round(TravelRange /(PositionLabelsList.Count-1) * (Position));

  with ClientRect do
    begin
      TrackWidth := FPointerWidth + 2*FTrack3DMargin;
      case FOrientation of
        ioVertical   : begin
                         case FOrientationLabels of
                           iosTopLeft     : FTrackRect := Rect(Right - TrackOffet - TrackWidth , Top + FEndsMargin, Right - TrackOffet,               Bottom - FEndsMargin);
                           iosBottomRight : FTrackRect := Rect(Left  + TrackOffet              , Top + FEndsMargin, Left  + TrackOffet +  TrackWidth, Bottom - FEndsMargin);
                         end;
                         with FTrackRect do
                           case FPointerStyle of
                             ispsLed      : FIndicatorRect:=Rect(Left+FTrack3DMargin,   Bottom-FTrack3DMargin-IndicatorOffset-FPointerHeight,Right-FTrack3DMargin,   Bottom-FTrack3DMargin-IndicatorOffset);
                             ispsPointer  : FIndicatorRect:=Rect(Left-FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset-FPointerHeight,Right+FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset);
                             ispsBitmap   : FIndicatorRect:=Rect(Left-FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset-FPointerHeight,Right+FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset);
                             ispsBar      : FIndicatorRect:=Rect(Left-FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset-FPointerHeight,Right+FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset);
                             ispsBarColor : FIndicatorRect:=Rect(Left-FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset-FPointerHeight,Right+FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset);
                             ispsLightBar : FIndicatorRect:=Rect(Left-FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset-FPointerHeight,Right+FIndicatorOverlap,Bottom-FTrack3DMargin-IndicatorOffset);
                           end;
                       end;
        else           begin
                         case FOrientationLabels of
                           iosTopLeft     : FTrackRect := Rect(Left + FEndsMargin, Bottom - TrackWidth - TrackOffet, Right - FEndsMargin, Bottom - TrackOffet          );
                           iosBottomRight : FTrackRect := Rect(Left + FEndsMargin, Top    + TrackOffet,              Right - FEndsMargin, Top + TrackWidth + TrackOffet);
                         end;
                         with FTrackRect do
                           case FPointerStyle of
                             ispsLed      : FIndicatorRect:=Rect(Left+FTrack3DMargin+IndicatorOffset,Top+FTrack3DMargin,   Left+FTrack3DMargin+IndicatorOffset+FPointerHeight,Bottom-FTrack3DMargin);
                             ispsPointer  : FIndicatorRect:=Rect(Left+FTrack3DMargin+IndicatorOffset,Top-FIndicatorOverlap,Left+FTrack3DMargin+IndicatorOffset+FPointerHeight,Bottom+FIndicatorOverlap);
                             ispsBitmap   : FIndicatorRect:=Rect(Left+FTrack3DMargin+IndicatorOffset,Top-FIndicatorOverlap,Left+FTrack3DMargin+IndicatorOffset+FPointerHeight,Bottom+FIndicatorOverlap);
                             ispsBar      : FIndicatorRect:=Rect(Left+FTrack3DMargin+IndicatorOffset,Top-FIndicatorOverlap,Left+FTrack3DMargin+IndicatorOffset+FPointerHeight,Bottom+FIndicatorOverlap);
                             ispsBarColor : FIndicatorRect:=Rect(Left+FTrack3DMargin+IndicatorOffset,Top-FIndicatorOverlap,Left+FTrack3DMargin+IndicatorOffset+FPointerHeight,Bottom+FIndicatorOverlap);
                             ispsLightBar : FIndicatorRect:=Rect(Left+FTrack3DMargin+IndicatorOffset,Top-FIndicatorOverlap,Left+FTrack3DMargin+IndicatorOffset+FPointerHeight,Bottom+FIndicatorOverlap);
                           end;
                       end;
      end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.CalcAutoCenterOffsets;
var
  x            : Integer;
  MaxTextWidth : Integer;
  TotalWidth   : Integer;
begin
  FCenterOffsetX := 0;
  FCenterOffsetY := 0;

  if not FAutoCenter then Exit;

  TotalWidth := 0;

  if ShowPositionLabels then
    begin
      with Canvas do
        begin
          MaxTextWidth := 0;
          for x := 0 to PositionLabelsList.Count-1 do
            begin
              Canvas.Font.Assign(PositionLabelActiveFont);

              case Orientation of
                ioVertical   : if TextWidth (PositionLabelsList.Strings[x]) > MaxTextWidth then MaxTextWidth := TextWidth (PositionLabelsList.Strings[x]);
                else           if TextHeight(PositionLabelsList.Strings[x]) > MaxTextWidth then MaxTextWidth := TextHeight(PositionLabelsList.Strings[x]);
              end;

              Font.Assign(PositionLabelInactiveFont);

              case Orientation of
                ioVertical   : if TextWidth (PositionLabelsList.Strings[x]) > MaxTextWidth then MaxTextWidth := TextWidth (PositionLabelsList.Strings[x]);
                else           if TextHeight(PositionLabelsList.Strings[x]) > MaxTextWidth then MaxTextWidth := TextHeight(PositionLabelsList.Strings[x]);
              end;
            end;
        end;
      TotalWidth := TotalWidth + PositionLabelMargin + MaxTextWidth;
    end;

  if ShowPositionIndicators then TotalWidth := TotalWidth + PositionIndicatorMargin + PositionIndicatorSize;

  case FOrientation of
    ioVertical   : begin
                     TotalWidth := TotalWidth + FTrackRect.Right - FTrackRect.Left + FIndicatorOverlap;
                     FCenterOffsetX := (Width - TotalWidth) div 2;
                   end;
    ioHorizontal : begin
                     TotalWidth     := TotalWidth + FTrackRect.Bottom - FTrackRect.Top + FIndicatorOverlap;
                     FCenterOffsetY := (Height - TotalWidth) div 2;
                   end;
  end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.iPaintTo(Canvas: TCanvas);
var
  ClientRect : TRect;
begin
  ClientRect := Rect(0, 0 ,Width, Height);

  CalcPoints;
  CalcAutoCenterOffsets;

  case FOrientation of
    ioVertical   : begin
                     case FOrientationLabels of
                       iosBottomRight : begin
                                          OffsetRect(FTrackRect,     OffsetX, 0);
                                          OffsetRect(FIndicatorRect, OffsetX, 0);

                                          OffsetRect(FTrackRect,     FCenterOffsetX, 0);
                                          OffsetRect(FIndicatorRect, FCenterOffsetX, 0);
                                        end;
                       iosTopLeft     : begin
                                          OffsetRect(FTrackRect,     -OffsetX, 0);
                                          OffsetRect(FIndicatorRect, -OffsetX, 0);

                                          OffsetRect(FTrackRect,     -FCenterOffsetX, 0);
                                          OffsetRect(FIndicatorRect, -FCenterOffsetX, 0);
                                        end;
                     end;
                   end;
    ioHorizontal : begin
                     case FOrientationLabels of
                       iosBottomRight : begin
                                          OffsetRect(FTrackRect,     0, OffsetY);
                                          OffsetRect(FIndicatorRect, 0, OffsetY);

                                          OffsetRect(FTrackRect,     0, FCenterOffsetY);
                                          OffsetRect(FIndicatorRect, 0, FCenterOffsetY);
                                         end;
                       iosTopLeft     : begin
                                          OffsetRect(FTrackRect,     0, -OffsetY);
                                          OffsetRect(FIndicatorRect, 0, -OffsetY);

                                          OffsetRect(FTrackRect,     0, -FCenterOffsetY);
                                          OffsetRect(FIndicatorRect, 0, -FCenterOffsetY);
                                         end;
                     end;
                  end;
  end;

  DrawBackGround(Canvas, BackGroundColor);
  DrawTrack     (Canvas, FTrackRect    );
  DrawTicks     (Canvas, FTrackRect    );
  DrawIndicator (Canvas, FIndicatorRect);

  if ShowFocusRect and HasFocus then iDrawFocusRect(Canvas, ClientRect, BackGroundColor);
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.DrawTrack(Canvas: TCanvas; TrackRect: TRect);
begin
  with Canvas do
    begin
      with TrackRect do
        begin
          case FTrackStyle of
            istsBox          : begin
                                 if Enabled or not ShowDisabledState then Brush.Color := FTrackColor
                                 else                                     Brush.Color := BackGroundColor;
                                 
                                 FillRect(TrackRect);
                                 Pen.Color := clBtnShadow;
                                 PolyLine([Point(Right,Top), Point (Left, Top), Point(Left, Bottom)]);
                                 if BackGroundColor = clWhite then Pen.Color := clBtnShadow;
                                 PolyLine([Point(Right-1,Top+1), Point (Left+1, Top+1), Point(Left+1, Bottom-1)]);
                                 Pen.Color := clBtnHighlight;
                                 PolyLine([Point(Right-1,Top), Point (Right-1, Bottom-1), Point(Left, Bottom-1)]);
                                 Pen.Color := clBtnFace;
                                 PolyLine([Point(Right-2,Top+2), Point (Right-2, Bottom-2), Point(Left, Bottom-2)]);
                               end;
            istsLine         : begin
                                 case FOrientation of
                                   ioHorizontal : begin
                                                    Pen.Color := FTrackColor;
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2), Point(Right - FTrack3DMargin, (Top + Bottom) div 2)]);
                                                  end;
                                   ioVertical   : begin
                                                    Pen.Color := FTrackColor;
                                                    PolyLine([Point((Left + Right) div 2, Top + FTrack3DMargin), Point((Left + Right) div 2, Bottom - FTrack3DMargin)]);
                                                  end;
                                 end;
                               end;
            istsBevelLowered : begin
                                 case FOrientation of
                                   ioHorizontal : begin
                                                    Pen.Color := clBtnShadow;
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2-2), Point(Right - FTrack3DMargin, (Top + Bottom) div 2-2)]);
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2-1), Point(Right - FTrack3DMargin, (Top + Bottom) div 2-1)]);
                                                    Pen.Color := clBtnHighlight;
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2+0), Point(Right - FTrack3DMargin, (Top + Bottom) div 2+0)]);
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2+1), Point(Right - FTrack3DMargin, (Top + Bottom) div 2+1)]);
                                                  end;
                                   ioVertical   : begin
                                                    Pen.Color := clBtnShadow;
                                                    PolyLine([Point((Left + Right) div 2-2, Top + FTrack3DMargin), Point((Left + Right) div 2-2, Bottom - FTrack3DMargin)]);
                                                    PolyLine([Point((Left + Right) div 2-1, Top + FTrack3DMargin), Point((Left + Right) div 2-1, Bottom - FTrack3DMargin)]);
                                                    Pen.Color := clBtnHighlight;
                                                    PolyLine([Point((Left + Right) div 2+0, Top + FTrack3DMargin), Point((Left + Right) div 2+0, Bottom - FTrack3DMargin)]);
                                                    PolyLine([Point((Left + Right) div 2+1, Top + FTrack3DMargin), Point((Left + Right) div 2+1, Bottom - FTrack3DMargin)]);
                                                  end;
                                 end;
                               end;
            istsBevelRasied  : begin
                                 case FOrientation of
                                   ioHorizontal : begin
                                                    Pen.Color := clBtnHighlight;
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2-2), Point(Right - FTrack3DMargin, (Top + Bottom) div 2-2)]);
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2-1), Point(Right - FTrack3DMargin, (Top + Bottom) div 2-1)]);
                                                    Pen.Color := clBtnShadow;
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2+0), Point(Right - FTrack3DMargin, (Top + Bottom) div 2+0)]);
                                                    PolyLine([Point(Left + FTrack3DMargin, (Top + Bottom) div 2+1), Point(Right - FTrack3DMargin, (Top + Bottom) div 2+1)]);
                                                  end;
                                   ioVertical   : begin
                                                    Pen.Color := clBtnHighlight;
                                                    PolyLine([Point((Left + Right) div 2-2, Top + FTrack3DMargin), Point((Left + Right) div 2-2, Bottom - FTrack3DMargin)]);
                                                    PolyLine([Point((Left + Right) div 2-1, Top + FTrack3DMargin), Point((Left + Right) div 2-1, Bottom - FTrack3DMargin)]);
                                                    Pen.Color := clBtnShadow;
                                                    PolyLine([Point((Left + Right) div 2+0, Top + FTrack3DMargin), Point((Left + Right) div 2+0, Bottom - FTrack3DMargin)]);
                                                    PolyLine([Point((Left + Right) div 2+1, Top + FTrack3DMargin), Point((Left + Right) div 2+1, Bottom - FTrack3DMargin)]);
                                                  end;
                                 end;
                               end;
          end;
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiSwitchSlider.DrawIndicator(Canvas: TCanvas; IndicatorRect: TRect);
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
      Pen.Style   := psSolid;

      with IndicatorRect do
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
                          if FMouseDown or FKeyDown then Brush.Color := FPointerHighLightColor else Brush.Color := FPointerColor;
                          Rectangle(Left, Top, Right, Bottom);

                          Pen.Color   := clWhite; PolyLine([Point(Left,  Bottom), Point(Left,  Top   ), Point(Right, Top   )]);
                          Pen.Color   := clBlack; PolyLine([Point(Right, Top   ), Point(Right, Bottom), Point(Left,  Bottom)]);
                        end;
          ispsBarColor :begin
                          Pen.Color   := clBtnFace;
                          if FMouseDown or FKeyDown then Brush.Color := PointerIndicatorActiveColor else Brush.Color := PointerIndicatorInactiveColor;
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

                          if FMouseDown or FKeyDown then
                            begin
                              case FOrientation of
                                ioHorizontal : begin
                                                 Pen.Color:=clBtnShadow;                 Line(Canvas, (Left+Right)div 2 -1,Top+1,(Left+Right)div 2 -1,Bottom-1);
                                                 Pen.Color:=FPointerIndicatorActiveColor;Line(Canvas, (Left+Right)div 2 +0,Top+1,(Left+Right)div 2 +0,Bottom-1);
                                                 Pen.Color:=clBtnHighlight;              Line(Canvas, (Left+Right)div 2 +1,Top+1,(Left+Right)div 2 +1,Bottom-1);
                                               end;
                                ioVertical   : begin
                                                 Pen.Color:=clBtnShadow;                 Line(Canvas, Left+1,(Top+Bottom)div 2 -1,Right-1,(Top+Bottom)div 2 -1);
                                                 Pen.Color:=FPointerIndicatorActiveColor;Line(Canvas, Left+1,(Top+Bottom)div 2 +0,Right-1,(Top+Bottom)div 2 +0);
                                                 Pen.Color:=clBtnHighlight;              Line(Canvas, Left+1,(Top+Bottom)div 2 +1,Right-1,(Top+Bottom)div 2 +1);
                                               end;
                              end;
                            end
                          else
                            begin
                              case FOrientation of
                                ioHorizontal : begin
                                                 Pen.Color:=clBtnShadow;                   Line(Canvas, (Left+Right)div 2 -1, Top+1,(Left+Right)div 2 -1,Bottom-1);
                                                 Pen.Color:=FPointerIndicatorInactiveColor;Line(Canvas, (Left+Right)div 2 +0, Top+1,(Left+Right)div 2 +0,Bottom-1);
                                                 Pen.Color:=clBtnHighlight;                Line(Canvas, (Left+Right)div 2 +1, Top+1,(Left+Right)div 2 +1,Bottom-1);
                                               end;
                                ioVertical   : begin
                                                 Pen.Color:=clBtnShadow;                    Line(Canvas, Left+1,(Top+Bottom)div 2 -1,Right-1,(Top+Bottom)div 2 -1);
                                                 Pen.Color:=FPointerIndicatorInactiveColor; Line(Canvas, Left+1,(Top+Bottom)div 2 +0,Right-1,(Top+Bottom)div 2 +0);
                                                 Pen.Color:=clBtnHighlight;                 Line(Canvas, Left+1,(Top+Bottom)div 2 +1,Right-1,(Top+Bottom)div 2 +1);
                                               end;
                              end;
                            end;

                        end;
          ispsPointer : begin
                          Pen.Color   := clBlack;
                          if FMouseDown or FKeyDown then Brush.Color := FPointerHighLightColor else Brush.Color := FPointerColor;

                          case FOrientation of
                            ioHorizontal : case FOrientationLabels of
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
                            ioVertical   : case FOrientationLabels of
                                             iosTopLeft     : begin
                                                                Point1 := Point(Right, Top);
                                                                Point2 := Point(Left + (Bottom - Top) div 2, Top);
                                                                Point3 := Point(Left, (Bottom + Top) div 2);
                                                                Point4 := Point(Left + (Bottom - Top) div 2, Bottom);
                                                                Point5 := Point(Right, Bottom);
                                                                Polygon([Point1, Point2, Point3, Point4, Point5]);
                                                                Pen.Color := clWhite; PolyLine([Point1, Point2, Point3]);
                                                              end;
                                             iosBottomRight : begin
                                                                Point1 := Point(Left, Top);
                                                                Point2 := Point(Right - (Bottom - Top) div 2, Top);
                                                                Point3 := Point(Right, (Bottom + Top) div 2);
                                                                Point4 := Point(Right - (Bottom - Top) div 2, Bottom);
                                                                Point5 := Point(Left, Bottom);
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
//*************************************************************************************************************************************
procedure TiSwitchSlider.DrawTicks(Canvas: TCanvas; TrackRect: TRect);
var
  LabelString       : String;
  LabelWidth        : Integer;
  LabelHeight       : Integer;
  ATextRect         : TRect;
  x                 : Integer;
  LabelMarginOffset : Integer;
  PositionOffset    : Integer;
  IndicatorRect     : TRect;
  LineIndicatorRect : TRect;
begin
  LabelMarginOffset := PositionLabelMargin;
  if ShowPositionIndicators then LabelMarginOffset := LabelMarginOffset + PositionIndicatorMargin + PositionIndicatorSize;
  with Canvas, TrackRect do
    begin
      for x := 0 to PositionLabelsList.Count-1 do
        begin
          PositionOffset := FTrack3DMargin + (FPointerHeight div 2) + Round(TravelRange /(PositionLabelsList.Count-1) * (x));
          if ShowPositionIndicators then
            begin
              Brush.Style := bsSolid;
              case FOrientation of
                ioVertical   : case FOrientationLabels of
                                 iosBottomRight : IndicatorRect := Rect(Right + PositionIndicatorMargin,                           Bottom - PositionOffset - PositionIndicatorSize,
                                                                        Right + PositionIndicatorMargin + 2*PositionIndicatorSize, Bottom - PositionOffset + PositionIndicatorSize);
                                 iosTopLeft     : IndicatorRect := Rect(Left  - PositionIndicatorMargin - 2*PositionIndicatorSize, Bottom - PositionOffset - PositionIndicatorSize,
                                                                        Left  - PositionIndicatorMargin,                           Bottom - PositionOffset + PositionIndicatorSize);
                               end;
                ioHorizontal : case FOrientationLabels of
                                 iosBottomRight : IndicatorRect := Rect(Left  + PositionOffset - PositionIndicatorSize, Bottom + PositionIndicatorMargin,
                                                                        Left  + PositionOffset + PositionIndicatorSize, Bottom + PositionIndicatorMargin + 2*PositionIndicatorSize);
                                 iosTopLeft     : IndicatorRect := Rect(Left  + PositionOffset - PositionIndicatorSize, Top    - PositionIndicatorMargin - 2*PositionIndicatorSize,
                                                                        Left  + PositionOffset + PositionIndicatorSize, Top    - PositionIndicatorMargin                          );
                               end;
              end;

              case FPositionIndicatorStyle of
                issisDot  : with IndicatorRect do
                              begin
                                Pen.Style   := psClear;
                                if Enabled or not ShowDisabledState then Brush.Color := PositionIndicatorColor
                                else                                     Brush.Color := BackGroundColor;
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
                issisLine : with IndicatorRect do
                              begin
                                if Enabled or not ShowDisabledState then Pen.Color := PositionIndicatorColor
                                else                                     Pen.Color := BackGroundColor;
                                case FOrientation of
                                  ioVertical   : LineIndicatorRect := Rect(Left, (Top + Bottom) div 2, Left + PositionIndicatorSize, (Top + Bottom) div 2);
                                  ioHorizontal : LineIndicatorRect := Rect((Left + Right) div 2, Top, (Left + Right) div 2, Top + PositionIndicatorSize);
                                end;
                                case PositionIndicatorBevelStyle of
                                  ibsNone : Line(Canvas, LineIndicatorRect.Left, LineIndicatorRect.Top, LineIndicatorRect.Right, LineIndicatorRect.Bottom);
                                  else      LineBevel(Canvas, LineIndicatorRect.Left, LineIndicatorRect.Top, LineIndicatorRect.Right, LineIndicatorRect.Bottom, PositionIndicatorBevelStyle);
                                end;
                               end;
              end;
            end;
          if ShowPositionLabels then
            begin
              Brush.Style := bsClear;
              if Position <> x then Font.Assign(PositionLabelInactiveFont) else Font.Assign(PositionLabelActiveFont);

              if x <= PositionLabelsList.Count-1 then LabelString := PositionLabelsList.Strings[x] else LabelString := '???';

              LabelWidth  := TextWidth (LabelString);
              LabelHeight := TextHeight(LabelString);

              case FOrientation of
                ioVertical   : case FOrientationLabels of
                                 iosBottomRight : ATextRect := GetCenterPointRect(Right + LabelWidth div 2 + LabelMarginOffset,  Bottom - PositionOffset, LabelWidth, LabelHeight);
                                 iosTopLeft     : ATextRect := GetCenterPointRect(Left  - LabelWidth div 2 - LabelMarginOffset , Bottom - PositionOffset, LabelWidth, LabelHeight);
                               end;
                ioHorizontal : case FOrientationLabels of
                                 iosBottomRight : ATextRect := GetCenterPointRect(Left + PositionOffset, Bottom + LabelMarginOffset + LabelHeight div 2, LabelWidth, LabelHeight);
                                 iosTopLeft     : ATextRect := GetCenterPointRect(Left + PositionOffset, Top    - LabelMarginOffset - LabelHeight div 2, LabelWidth, LabelHeight);
                               end;
              end;

              if ShowDisabledState then iDrawText(Canvas, LabelString, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], Enabled, BackGroundColor)
              else                      iDrawText(Canvas, LabelString, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], True,    BackGroundColor);

            end;
        end;
    end;
end;
//*************************************************************************************************************************************
end.
