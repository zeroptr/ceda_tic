{*******************************************************}
{                                                       }
{       TiSlidingScale Component                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSlidingScale;{$endif}
{$ifdef iCLX}unit QiSlidingScale;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiCustomComponent;{$ENDIF}

type
  TiSlidingScale = class(TiCustomComponent)
  private
    FCenterPoint                : TPoint;
    FScaleRect                  : TRect;
    FScaleStartPosition         : Double;
    FScaleStopPosition          : Double;
    FRangePixels                : Integer;
    FTickMajorStepValue         : Double;
    FTickMajorLabelMarginPixels : Integer;
    FTickMinorStepValue         : Double;
    FTickMidLabelMarginPixels   : Integer;
    FMidTicksEnabled            : Boolean;
    FMidTickNumber              : Integer;
    FHalfMajorLength            : Integer;
    FHalfMidLength              : Integer;
    FHalfMinorLength            : Integer;

    FTickMajorLength            : Integer;
    FPosition                   : Double;
    FTickMidLength              : Integer;
    FPointerSize                : Integer;
    FTickMajorLabelMargin       : Double;
    FScaleSpan                  : Double;
    FTickMidLabelMargin         : Double;
    FTickMidWidth               : Integer;
    FTickMajorWidth             : Integer;
    FTickMajorCount             : Integer;
    FPointerLineWidth           : Integer;
    FTickMinorCount             : Integer;
    FTickMajorLabelPrecision    : Integer;
    FTickMinorWidth             : Integer;
    FTickMajorColor             : TColor;
    FPointerColor               : TColor;
    FScaleBackgroundColor       : TColor;
    FTickMinorColor             : TColor;
    FTickMidColor               : TColor;
    FPointerLineColor           : TColor;
    FTickMajorLabelFont         : TFont;
    FTickMidLabelFont           : TFont;
    FPointerStyle               : TiSlidingScalePointerStyle;
    FScaleAlignStyle            : TiScaleAlignStyle;
    FTickMinorLength            : Integer;
    FTickMidLabelPrecision      : Integer;
    FShowMidTickLabels          : Boolean;
    FShowMidTicks               : Boolean;
    FReverseScale               : Boolean;
    FOrientation                : TiOrientation;
    FScaleOrientation           : TiOrientationSide;
    FScaleAntiAliasEnabled      : Boolean;
    FScaleShadowEnabled         : Boolean;
    FScaleShadowColor           : TColor;
    FPointerOrientation         : TiOrientationSide;
    FOuterMarginTop             : Integer;
    FOuterMarginLeft            : Integer;
    FOuterMarginRight           : Integer;
    FOuterMarginBottom          : Integer;
    FTitleText                  : String;
    FTitleFont                  : TFont;
    FTitleAlignment             : TiAlignmentSideVertical;
    FTitleMargin                : Double;
    FOnAutoSize                 : TNotifyEvent;

    procedure SetPointerColor           (const Value: TColor);
    procedure SetPointerLineColor       (const Value: TColor);
    procedure SetPointerLineWidth       (const Value: Integer);
    procedure SetPointerSize            (const Value: Integer);
    procedure SetPointerStyle           (const Value: TiSlidingScalePointerStyle);
    procedure SetPosition               (const Value: Double);
    procedure SetScaleBackgroundColor   (const Value: TColor);
    procedure SetScaleSpan              (const Value: Double);
    procedure SetScaleAlignStyle        (const Value: TiScaleAlignStyle);
    procedure SetTickMajorColor         (const Value: TColor);
    procedure SetTickMajorCount         (const Value: Integer);
    procedure SetTickMajorLabelFont     (const Value: TFont);
    procedure SetTickMajorLabelMargin   (const Value: Double);
    procedure SetTickMajorLabelPrecision(const Value: Integer);
    procedure SetTickMajorLength        (const Value: Integer);
    procedure SetTickMajorWidth         (const Value: Integer);
    procedure SetTickMidColor           (const Value: TColor);
    procedure SetTickMidLabelFont       (const Value: TFont);
    procedure SetTickMidLabelMargin     (const Value: Double);
    procedure SetTickMidLength          (const Value: Integer);
    procedure SetTickMidWidth           (const Value: Integer);
    procedure SetTickMinorColor         (const Value: TColor);
    procedure SetTickMinorCount         (const Value: Integer);
    procedure SetTickMinorWidth         (const Value: Integer);
    procedure SetTickMinorLength        (const Value: Integer);
    procedure SetTickMidLabelPrecision  (const Value: Integer);
    procedure SetShowMidTickLabels      (const Value: Boolean);
    procedure SetShowMidTicks           (const Value: Boolean);
    procedure SetReverseScale           (const Value: Boolean);
    procedure SetOrientation            (const Value: TiOrientation);
    procedure SetScaleOrientation       (const Value: TiOrientationSide);
    procedure SetScaleAntiAliasEnabled  (const Value: Boolean);
    procedure SetScaleShadowEnabled     (const Value: Boolean);
    procedure SetScaleShadowColor       (const Value: TColor);
    procedure SetPointerOrientation     (const Value: TiOrientationSide);
    procedure SetOuterMarginBottom      (const Value: Integer);
    procedure SetOuterMarginLeft        (const Value: Integer);
    procedure SetOuterMarginRight       (const Value: Integer);
    procedure SetOuterMarginTop         (const Value: Integer);
    procedure SetTitleText              (const Value: String);
    procedure SetTitleAlignment         (const Value: TiAlignmentSideVertical);
    procedure SetTitleFont              (const Value: TFont);
    procedure SetTitleMargin            (const Value: Double);
  protected
    procedure CalcPoints(Canvas: TCanvas);
    procedure iPaintTo(Canvas: TCanvas);                          override;
    function  GetPositionToPixels(Value : Double) : Integer;

    procedure DrawScaleBackGround (Canvas : TCanvas);
    procedure DrawTitle           (Canvas : TCanvas);
    procedure DrawPointer         (Canvas : TCanvas);
    procedure DrawPointerDualArrow(Canvas : TCanvas);
    procedure DrawPointerArrow    (Canvas : TCanvas);
    procedure DrawPointerPointer  (Canvas : TCanvas);
    procedure DrawScale           (Canvas : TCanvas);

    property OnAutoSize              : TNotifyEvent               read FOnAutoSize              write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent);override;
    destructor  Destroy;                   override;
  published
    property Position                : Double                     read FPosition                write SetPosition;
    property Orientation             : TiOrientation              read FOrientation             write SetOrientation             default ioHorizontal;
    property ReverseScale            : Boolean                    read FReverseScale            write SetReverseScale            default False;

    property ScaleSpan               : Double                     read FScaleSpan               write SetScaleSpan;
    property ScaleBackgroundColor    : TColor                     read FScaleBackgroundColor    write SetScaleBackgroundColor    default clWhite;
    property ScaleAlignStyle         : TiScaleAlignStyle          read FScaleAlignStyle         write SetScaleAlignStyle         default itasSide;
    property ScaleAntiAliasEnabled   : Boolean                    read FScaleAntiAliasEnabled   write SetScaleAntiAliasEnabled   default True;
    property ScaleShadowEnabled      : Boolean                    read FScaleShadowEnabled      write SetScaleShadowEnabled      default True;
    property ScaleShadowColor        : TColor                     read FScaleShadowColor        write SetScaleShadowColor        default clBlack;
    property ScaleOrientation        : TiOrientationSide          read FScaleOrientation        write SetScaleOrientation        default iosTopLeft;

    property TickMajorCount          : Integer                    read FTickMajorCount          write SetTickMajorCount          default 5;
    property TickMajorWidth          : Integer                    read FTickMajorWidth          write SetTickMajorWidth          default 2;
    property TickMajorLength         : Integer                    read FTickMajorLength         write SetTickMajorLength         default 9;
    property TickMajorColor          : TColor                     read FTickMajorColor          write SetTickMajorColor          default clBlack;
    property TickMajorLabelFont      : TFont                      read FTickMajorLabelFont      write SetTickMajorLabelFont;
    property TickMajorLabelPrecision : Integer                    read FTickMajorLabelPrecision write SetTickMajorLabelPrecision default 0;
    property TickMajorLabelMargin    : Double                     read FTickMajorLabelMargin    write SetTickMajorLabelMargin;

    property TickMidWidth            : Integer                    read FTickMidWidth            write SetTickMidWidth            default 2;
    property TickMidLength           : Integer                    read FTickMidLength           write SetTickMidLength           default 7;
    property TickMidColor            : TColor                     read FTickMidColor            write SetTickMidColor            default clBlack;
    property TickMidLabelFont        : TFont                      read FTickMidLabelFont        write SetTickMidLabelFont;
    property TickMidLabelPrecision   : Integer                    read FTickMidLabelPrecision   write SetTickMidLabelPrecision   default 1;
    property TickMidLabelMargin      : Double                     read FTickMidLabelMargin      write SetTickMidLabelMargin;

    property TickMinorCount          : Integer                    read FTickMinorCount          write SetTickMinorCount          default 4;
    property TickMinorWidth          : Integer                    read FTickMinorWidth          write SetTickMinorWidth          default 1;
    property TickMinorLength         : Integer                    read FTickMinorLength         write SetTickMinorLength         default 5;
    property TickMinorColor          : TColor                     read FTickMinorColor          write SetTickMinorColor          default clBlack;

    property PointerStyle            : TiSlidingScalePointerStyle read FPointerStyle            write SetPointerStyle            default isspsDualArrow;
    property PointerColor            : TColor                     read FPointerColor            write SetPointerColor            default clYellow;
    property PointerSize             : Integer                    read FPointerSize             write SetPointerSize             default 10;
    property PointerOrientation      : TiOrientationSide          read FPointerOrientation      write SetPointerOrientation      default iosTopLeft;
    property PointerLineColor        : TColor                     read FPointerLineColor        write SetPointerLineColor        default clBlue;
    property PointerLineWidth        : Integer                    read FPointerLineWidth        write SetPointerLineWidth        default 2;

    property ShowMidTicks            : Boolean                    read FShowMidTicks            write SetShowMidTicks            default False;
    property ShowMidTickLabels       : Boolean                    read FShowMidTickLabels       write SetShowMidTickLabels       default False;

    property TitleText               : String                     read FTitleText               write SetTitleText;
    property TitleMargin             : Double                     read FTitleMargin             write SetTitleMargin;
    property TitleFont               : TFont                      read FTitleFont               write SetTitleFont;
    property TitleAlignment          : TiAlignmentSideVertical    read FTitleAlignment          write SetTitleAlignment          default iasvTop;

    property OuterMarginLeft         : Integer                    read FOuterMarginLeft         write SetOuterMarginLeft         default 0;
    property OuterMarginTop          : Integer                    read FOuterMarginTop          write SetOuterMarginTop          default 0;
    property OuterMarginRight        : Integer                    read FOuterMarginRight        write SetOuterMarginRight        default 0;
    property OuterMarginBottom       : Integer                    read FOuterMarginBottom       write SetOuterMarginBottom       default 0;

    property BackGroundColor;
    property BorderStyle;
    property Transparent;
    property CachedDrawing;
    property Width            default 250;
    property Height           default 60;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSlidingScale.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 250;
  Height := 60;

  FOrientation             := ioHorizontal;
  FScaleAntiAliasEnabled   := True;

  FScaleSpan               := 100;
  FScaleAlignStyle         := itasSide;
  FScaleBackgroundColor    := clWhite;
  FScaleOrientation        := iosTopLeft;
  FScaleShadowEnabled      := True;

  FTickMajorCount          := 5;
  FTickMinorCount          := 4;

  FTickMajorLength         := 9;
  FTickMidLength           := 7;
  FTickMinorLength         := 5;

  FTickMajorWidth          := 2;
  FTickMidWidth            := 2;
  FTickMinorWidth          := 1;

  FTickMidColor            := clBlack;
  FTickMinorColor          := clBlack;
  FTickMajorColor          := clBlack;

  FTickMajorLabelMargin    := 0.25;
  FTickMidLabelMargin      := 0.25;

  FTickMajorLabelPrecision := 0;
  FTickMidLabelPrecision   := 1;

  FPointerSize             := 10;
  FPointerOrientation      := iosTopLeft;
  FPointerStyle            := isspsDualArrow;
  FPointerLineWidth        := 2;
  FPointerColor            := clYellow;
  FPointerLineColor        := clBlue;

  FTitleMargin             := 0.5;

  FTickMajorLabelFont      := TFont.Create; FTickMajorLabelFont.OnChange := InvalidateChangeEvent;
  FTickMidLabelFont        := TFont.Create; FTickMidLabelFont.OnChange   := InvalidateChangeEvent;
  FTitleFont               := TFont.Create; FTitleFont.OnChange          := BackGroundChangeEvent;
end;
//****************************************************************************************************************************************************
destructor TiSlidingScale.Destroy;
begin
  FTickMajorLabelFont.Free;
  FTickMidLabelFont.Free;
  FTitleFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetPointerColor           (const Value:TColor );begin SetColorProperty  (Value,FPointerColor,           irtBackGround);end;
procedure TiSlidingScale.SetPointerLineColor       (const Value:TColor );begin SetColorProperty  (Value,FPointerLineColor,       irtBackGround);end;
procedure TiSlidingScale.SetPointerLineWidth       (const Value:Integer);begin SetIntegerProperty(Value,FPointerLineWidth,       irtBackGround);end;
procedure TiSlidingScale.SetPointerSize            (const Value:Integer);begin SetIntegerProperty(Value,FPointerSize,            irtBackGround);end;
procedure TiSlidingScale.SetScaleBackgroundColor   (const Value:TColor );begin SetColorProperty  (Value,FScaleBackgroundColor,   irtBackGround);end;
procedure TiSlidingScale.SetTickMajorColor         (const Value:TColor );begin SetColorProperty  (Value,FTickMajorColor,         irtBackGround);end;
procedure TiSlidingScale.SetTickMajorCount         (const Value:Integer);begin SetIntegerProperty(Value,FTickMajorCount,         irtBackGround);end;
procedure TiSlidingScale.SetTickMajorLabelMargin   (const Value:Double );begin SetDoubleProperty (Value,FTickMajorLabelMargin,   irtBackGround);end;
procedure TiSlidingScale.SetTickMajorLabelPrecision(const Value:Integer);begin SetIntegerProperty(Value,FTickMajorLabelPrecision,irtBackGround);end;
procedure TiSlidingScale.SetTickMajorLength        (const Value:Integer);begin SetIntegerProperty(Value,FTickMajorLength,        irtBackGround);end;
procedure TiSlidingScale.SetTickMajorWidth         (const Value:Integer);begin SetIntegerProperty(Value,FTickMajorWidth,         irtBackGround);end;
procedure TiSlidingScale.SetTickMidColor           (const Value:TColor );begin SetColorProperty  (Value,FTickMidColor,           irtBackGround);end;
procedure TiSlidingScale.SetTickMidLabelMargin     (const Value:Double );begin SetDoubleProperty (Value,FTickMidLabelMargin,     irtBackGround);end;
procedure TiSlidingScale.SetTickMidLength          (const Value:Integer);begin SetIntegerProperty(Value,FTickMidLength,          irtBackGround);end;
procedure TiSlidingScale.SetTickMidWidth           (const Value:Integer);begin SetIntegerProperty(Value,FTickMidWidth,           irtBackGround);end;
procedure TiSlidingScale.SetTickMinorColor         (const Value:TColor );begin SetColorProperty  (Value,FTickMinorColor,         irtBackGround);end;
procedure TiSlidingScale.SetTickMinorCount         (const Value:Integer);begin SetIntegerProperty(Value,FTickMinorCount,         irtBackGround);end;
procedure TiSlidingScale.SetTickMinorWidth         (const Value:Integer);begin SetIntegerProperty(Value,FTickMinorWidth,         irtBackGround);end;
procedure TiSlidingScale.SetTickMinorLength        (const Value:Integer);begin SetIntegerProperty(Value,FTickMinorLength,        irtBackGround);end;
procedure TiSlidingScale.SetTickMidLabelPrecision  (const Value:Integer);begin SetIntegerProperty(Value,FTickMidLabelPrecision,  irtBackGround);end;
procedure TiSlidingScale.SetShowMidTickLabels      (const Value:Boolean);begin SetBooleanProperty(Value,FShowMidTickLabels,      irtBackGround);end;
procedure TiSlidingScale.SetShowMidTicks           (const Value:Boolean);begin SetBooleanProperty(Value,FShowMidTicks,           irtBackGround);end;
procedure TiSlidingScale.SetReverseScale           (const Value:Boolean);begin SetBooleanProperty(Value,FReverseScale,           irtBackGround);end;
procedure TiSlidingScale.SetScaleAntiAliasEnabled  (const Value:Boolean);begin SetBooleanProperty(Value,FScaleAntiAliasEnabled,  irtBackGround);end;
procedure TiSlidingScale.SetScaleShadowEnabled     (const Value:Boolean);begin SetBooleanProperty(Value,FScaleShadowEnabled,     irtBackGround);end;
procedure TiSlidingScale.SetScaleShadowColor       (const Value:TColor );begin SetColorProperty  (Value,FScaleShadowColor,       irtBackGround);end;
procedure TiSlidingScale.SetOuterMarginBottom      (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginBottom,      irtBackGround);end;
procedure TiSlidingScale.SetOuterMarginLeft        (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginLeft,        irtBackGround);end;
procedure TiSlidingScale.SetOuterMarginRight       (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginRight,       irtBackGround);end;
procedure TiSlidingScale.SetOuterMarginTop         (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginTop,         irtBackGround);end;
procedure TiSlidingScale.SetTitleText              (const Value:String );begin SetStringProperty (Value,FTitleText,              irtBackGround);end;
procedure TiSlidingScale.SetTitleMargin            (const Value:Double );begin SetDoubleProperty (Value,FTitleMargin,            irtBackGround);end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetTickMajorLabelFont(const Value: TFont);begin FTickMajorLabelFont.Assign(Value);end;
procedure TiSlidingScale.SetTickMidLabelFont  (const Value: TFont);begin FTickMidLabelFont.Assign(Value);  end;
procedure TiSlidingScale.SetTitleFont         (const Value: TFont);begin FTitleFont.Assign(Value);         end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetScaleSpan(const Value:Double );
var
  TempValue : Double;
begin
  TempValue := Value;
  if TempValue < 0.1 then TempValue := 0.1;
  SetDoubleProperty (TempValue,FScaleSpan, irtBackGround);
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetPointerStyle(const Value: TiSlidingScalePointerStyle);
begin
  if FPointerStyle <> Value then
    begin
      FPointerStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetScaleAlignStyle(const Value: TiScaleAlignStyle);
begin
  if FScaleAlignStyle <> Value then
    begin
      FScaleAlignStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetOrientation(const Value: TiOrientation);
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
procedure TiSlidingScale.SetScaleOrientation(const Value: TiOrientationSide);
begin
  if FScaleOrientation <> Value then
    begin
      FScaleOrientation := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetPointerOrientation(const Value: TiOrientationSide);
begin
  if FPointerOrientation <> Value then
    begin
      FPointerOrientation := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetTitleAlignment(const Value: TiAlignmentSideVertical);
begin
  if FTitleAlignment <> Value then
    begin
      FTitleAlignment := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.SetPosition(const Value: Double);
var
  CanEdit : Boolean;
begin
  if FPosition <> Value then
    begin
      CanEdit := True;
      if Assigned(OnRequestEditProtected) then OnRequestEditProtected(Self, 'Position', CanEdit);
      if CanEdit then
        begin
          FPosition := Value;
          InvalidateChange;
          if Assigned(OnChangeProtected) then OnChangeProtected(Self, 'Position');
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiSlidingScale.GetPositionToPixels(Value: Double): Integer;
var
  Center : Integer;
begin
  case FOrientation of
    ioVertical   :   begin
                       Center := (FScaleRect.Bottom + FScaleRect.Top ) div 2;
                       if FScaleSpan = 0     then Result := Center
                       else if FReverseScale then Result := Center + Round((FPosition - Value)/FScaleSpan*FRangePixels)
                       else                       Result := Center - Round((FPosition - Value)/FScaleSpan*FRangePixels);
                     end;
    else             begin
                       Center := (FScaleRect.Left + FScaleRect.Right) div 2;
                       if FScaleSpan = 0     then Result := Center
                       else if FReverseScale then Result := Center + Round((FPosition - Value)/FScaleSpan*FRangePixels)
                       else                       Result := Center - Round((FPosition - Value)/FScaleSpan*FRangePixels);
                     end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.CalcPoints(Canvas: TCanvas);
var
  WidthStart        : Integer;
  WidthStop         : Integer;
  HeightStart       : integer;
  HeightStop        : Integer;
  ScaleWidthStart   : Integer;
  ScaleWidthStop    : Integer;
  TickCount         : Integer;
  DrawRect          : TRect;
  TitleTotalHeight  : Integer;
begin
  FCenterPoint := GetCenterPoint(Canvas);

  if Length(Trim(FTitleText)) <> 0 then
    begin
     Canvas.Font.Assign(FTitleFont);
     TitleTotalHeight  := Round(Canvas.TextHeight(FTitleText) * (1 + FTitleMargin));
    end
  else TitleTotalHeight := 0;

  case FTitleAlignment of
    iasvTop : DrawRect := Rect(FOuterMarginLeft, FOuterMarginTop + TitleTotalHeight, Width - FOuterMarginRight, Height - FOuterMarginBottom);
    else      DrawRect := Rect(FOuterMarginLeft, FOuterMarginTop, Width - FOuterMarginRight, Height - FOuterMarginBottom - TitleTotalHeight);
  end;

  case FOrientation of
    ioVertical   : begin
                     WidthStart  := DrawRect.Left;
                     WidthStop   := DrawRect.Right;
                     HeightStart := DrawRect.Bottom;
                     HeightStop  := DrawRect.Top;
                   end;
    else           begin
                     WidthStart  := DrawRect.Top;
                     WidthStop   := DrawRect.Bottom;
                     HeightStart := DrawRect.Left;
                     HeightStop  := DrawRect.Right;
                   end;
  end;

  case FPointerStyle of
    isspsDualArrow : begin
                       case FPointerOrientation of
                         iosBottomRight : begin
                                            ScaleWidthStart := WidthStart + FPointerSize;
                                            ScaleWidthStop  := WidthStop  - FPointerSize;
                                          end;
                         else             begin
                                            ScaleWidthStart := WidthStart + FPointerSize;
                                            ScaleWidthStop  := WidthStop  - FPointerSize;
                                          end;
                       end;
                     end;
    isspsArrow     : begin
                       case FPointerOrientation of
                         iosBottomRight : begin
                                            ScaleWidthStart := WidthStart;
                                            ScaleWidthStop  := WidthStop - FPointerSize;
                                          end;
                         else             begin
                                            ScaleWidthStart := WidthStart + FPointerSize;
                                            ScaleWidthStop  := WidthStop;
                                          end;
                       end;
                     end;
    isspsPointer   : begin
                       case FPointerOrientation of
                         iosBottomRight : begin
                                            ScaleWidthStart := WidthStart;
                                            ScaleWidthStop  := WidthStop - 2*FPointerSize;
                                          end;
                         else             begin
                                            ScaleWidthStart := WidthStart + 2*FPointerSize;
                                            ScaleWidthStop  := WidthStop;
                                          end;
                       end;
                     end;
    else             begin
                       ScaleWidthStart   := WidthStart;
                       ScaleWidthStop    := WidthStop;
                     end;
  end;

  FRangePixels   := HeightStop - HeightStart;

  if FScaleAntiAliasEnabled then
    begin
      TickCount := (FTickMajorCount) * (FTickMinorCount+1);
      FRangePixels := Trunc((FRangePixels)/TickCount)*TickCount;
    end;

  case FOrientation of
    ioVertical   : FScaleRect := Rect(ScaleWidthStart, HeightStop, ScaleWidthStop, HeightStart);
    ioHorizontal : FScaleRect := Rect(HeightStart, ScaleWidthStart, HeightStop, ScaleWidthStop);
  end;
  
  FHalfMajorLength       := FTickMajorLength;
  FHalfMidLength         := FTickMidLength;
  FHalfMinorLength       := FTickMinorLength;

  FTickMajorStepValue  := FScaleSpan / FTickMajorCount;
  FTickMinorStepValue  := FTickMajorStepValue /(FTickMinorCount+1);

  Canvas.Font.Assign(FTickMajorLabelFont);
  FTickMajorLabelMarginPixels := Round(Canvas.TextWidth('0') * FTickMajorLabelMargin);

  Canvas.Font.Assign(FTickMidLabelFont);
  FTickMidLabelMarginPixels := Round(Canvas.TextWidth('0') * FTickMidLabelMargin);

  if FShowMidTicks and (FTickMinorCount mod 2 = 1) then
    begin
      FMidTicksEnabled := True;
      FMidTickNumber   := FTickMinorCount div 2;
    end
  else FMidTicksEnabled := False;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.iPaintTo(Canvas: TCanvas);
{$ifdef iVCL}
var
  ARegion : HRGN;
{$endif}
begin
  FScaleStartPosition := Trunc(FPosition/FScaleSpan) * FScaleSpan  - FScaleSpan;
  if FPosition < 0 then FScaleStartPosition := FScaleStartPosition - FScaleSpan;

  FScaleStopPosition  := FScaleStartPosition + 3*FScaleSpan;

  if CachedDrawing then
    begin
      if BackGroundChanged then
        begin
          CreateBackGroundBitmap;
          CalcPoints(Canvas);
          DrawBackGround     (BackGroundBitmap.Canvas, BackGroundColor);
          DrawScaleBackGround(BackGroundBitmap.Canvas);
          ResetBackGroundChange;
        end;

      TransferBackGround(Canvas);

      {$ifdef iVCL}
      ARegion := CreateRectRgn(FScaleRect.Left, FScaleRect.Top, FScaleRect.Right, FScaleRect.Bottom);
      try
        SelectClipRgn(Canvas.Handle, ARegion);
      {$endif}
        DrawScale          (Canvas);
      {$ifdef iVCL}
        SelectClipRgn(Canvas.Handle, 0);
      finally
        DeleteObject(ARegion);
      end;
      {$endif}

      DrawPointer        (Canvas);
      DrawTitle          (Canvas);
      DrawBorder         (Canvas);
    end
  else
    begin
      CalcPoints(Canvas);
      DrawBackGround     (Canvas, BackGroundColor);
      DrawScaleBackGround(Canvas);

      {$ifdef iVCL}
      ARegion := CreateRectRgn(FScaleRect.Left, FScaleRect.Top, FScaleRect.Right, FScaleRect.Bottom);
      try
        SelectClipRgn(Canvas.Handle, ARegion);
      {$endif}
        DrawScale          (Canvas);
      {$ifdef iVCL}
        SelectClipRgn(Canvas.Handle, 0);
      finally
        DeleteObject(ARegion);
      end;
      {$endif}

      DrawPointer        (Canvas);
      DrawTitle          (Canvas);
      DrawBorder         (Canvas);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.DrawTitle(Canvas: TCanvas);
var
  AText       : String;
  ARect       : TRect;
  ATextHeight : Integer;
begin
  with Canvas do
    begin
      Font.Assign(FTitleFont);
      Brush.Style := bsClear;
      AText       := FTitleText;
      ATextHeight := TextHeight(AText);
      case FTitleAlignment of
        iasvTop    : ARect := Rect(FCenterPoint.x, FOuterMarginTop,   FCenterPoint.x, FOuterMarginTop   + ATextHeight);
        iasvBottom : ARect := Rect(FCenterPoint.x, Height - FOuterMarginBottom - ATextHeight, FCenterPoint.x, Height - FOuterMarginBottom);
      end;

      with ARect do
        TextOut((Left + Right) div 2 - TextWidth(AText) div 2, (Top + Bottom) div 2 - TextHeight(AText) div 2, AText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.DrawScaleBackGround(Canvas: TCanvas);
var
  Red, Green, Blue : Integer;
  StartRed         : Integer;
  StartGreen       : Integer;
  StartBlue        : Integer;
  StopRed          : Integer;
  StopGreen        : Integer;
  StopBlue         : Integer;
  x                : Integer;
  NumOfLines       : Integer;
  Center           : Integer;
begin
  with Canvas do
    begin
      Brush.Color := FScaleBackGroundColor;
      Pen.Color   := FScaleBackGroundColor;
      Rectangle(FScaleRect.Left, FScaleRect.Top, FScaleRect.Right, FScaleRect.Bottom);

      if not FScaleShadowEnabled then exit;

      StartRed   := (FScaleBackgroundColor and $0000FF);
      StartGreen := (FScaleBackgroundColor and $00FF00) shr 8;
      StartBlue  := (FScaleBackgroundColor and $FF0000) shr 16;

      StopRed    := (FScaleShadowColor and $0000FF);
      StopGreen  := (FScaleShadowColor and $00FF00) shr 8;
      StopBlue   := (FScaleShadowColor and $FF0000) shr 16;
      Brush.Style := bsClear;

      case FOrientation of
        ioVertical : begin
                       NumOfLines := (FScaleRect.Bottom - FScaleRect.Top ) div 2;
                       Center     := (FScaleRect.Bottom + FScaleRect.Top ) div 2;
                     end;
        else         begin
                       NumOfLines := (FScaleRect.Right  - FScaleRect.Left) div 2;
                       Center     := (FScaleRect.Right  + FScaleRect.Left) div 2;
                     end;
      end;

      if NumOfLines = 0 then exit;

      for x := 0 to NumOfLines do

        begin
          Red   := Round((x/NumOfLines*StopRed    + (NumOfLines-x)/NumOfLines*StartRed  ));
          Green := Round((x/NumOfLines*StopGreen  + (NumOfLines-x)/NumOfLines*StartGreen));
          Blue  := Round((x/NumOfLines*StopBlue   + (NumOfLines-x)/NumOfLines*StartBlue ));

          Pen.Color := Red + (Green shl 8) + (Blue shl 16);

          case FOrientation of
            ioVertical : begin
                           Polyline([Point(FScaleRect.Left, Center + x+1), Point(FScaleRect.Right, Center + x+1)]);
                           Polyline([Point(FScaleRect.Left, Center - x  ), Point(FScaleRect.Right, Center - x  )]);
                         end;
            else         begin
                           Polyline([Point(Center + x+1, FScaleRect.Top), Point(Center + x+1, FScaleRect.Bottom)]);
                           Polyline([Point(Center - x,   FScaleRect.Top), Point(Center - x,   FScaleRect.Bottom)]);
                         end;
          end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.DrawPointer(Canvas: TCanvas);
var
  PositionPixels : Integer;
begin
  with Canvas do
    begin
      PositionPixels := GetPositionToPixels(Position);
      Pen.Color := PointerLineColor;
      Pen.Width := PointerLineWidth;
      case FOrientation of
        ioVertical : Polyline([Point(FScaleRect.Left, PositionPixels), Point(FScaleRect.Right, PositionPixels   )]);
        else         Polyline([Point(PositionPixels,  FScaleRect.Top), Point(PositionPixels,   FScaleRect.Bottom)]);
      end;

      case FPointerStyle of
        isspsDualArrow : DrawPointerDualArrow(Canvas);
        isspsArrow     : DrawPointerArrow    (Canvas);
        isspsPointer   : DrawPointerPointer  (Canvas);
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.DrawPointerArrow(Canvas: TCanvas);
var
  Point1         : TPoint;
  Point2         : TPoint;
  Point3         : TPoint;
  PositionPixels : Integer;
begin
  with Canvas do
    begin
      PositionPixels := GetPositionToPixels(Position);
      Brush.Style    := bsSolid;
      Brush.Color    := FPointerColor;
      Pen.Color      := FPointerColor;
      Pen.Width      := 1;

      case FOrientation of
        ioVertical : case FPointerOrientation of
                       iosBottomRight : begin
                                          Point1 := Point(FScaleRect.Right,                PositionPixels                     );
                                          Point2 := Point(FScaleRect.Right + FPointerSize, PositionPixels + FPointerSize div 2);
                                          Point3 := Point(FScaleRect.Right + FPointerSize, PositionPixels - FPointerSize div 2);
                                        end;
                       else             begin
                                          Point1 := Point(FScaleRect.Left,                PositionPixels                     );
                                          Point2 := Point(FScaleRect.Left - FPointerSize, PositionPixels + FPointerSize div 2);
                                          Point3 := Point(FScaleRect.Left - FPointerSize, PositionPixels - FPointerSize div 2);
                                        end;
                     end;
        else         case FPointerOrientation of
                       iosBottomRight : begin
                                          Point1 := Point(PositionPixels,                      FScaleRect.Bottom               );
                                          Point2 := Point(PositionPixels + FPointerSize div 2, FScaleRect.Bottom + FPointerSize);
                                          Point3 := Point(PositionPixels - FPointerSize div 2, FScaleRect.Bottom + FPointerSize);
                                        end;
                       else             begin
                                          Point1 := Point(PositionPixels,                      FScaleRect.Top               );
                                          Point2 := Point(PositionPixels + FPointerSize div 2, FScaleRect.Top - FPointerSize);
                                          Point3 := Point(PositionPixels - FPointerSize div 2, FScaleRect.Top - FPointerSize);
                                        end;
                     end;
      end;
      Polygon([Point1, Point2, Point3]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.DrawPointerDualArrow(Canvas: TCanvas);
var
  Point1         : TPoint;
  Point2         : TPoint;
  Point3         : TPoint;
  PositionPixels : Integer;
begin
  with Canvas do
    begin
      PositionPixels := GetPositionToPixels(Position);
      //---------------- Arrow 1 ----------------------------------------
      Brush.Style := bsSolid;
      Brush.Color := FPointerColor;
      Pen.Color   := FPointerColor;
      Pen.Width   := 1;

      case FOrientation of
        ioVertical : begin
                       Point1 := Point(FScaleRect.Left,                PositionPixels                     );
                       Point2 := Point(FScaleRect.Left - FPointerSize, PositionPixels + FPointerSize div 2);
                       Point3 := Point(FScaleRect.Left - FPointerSize, PositionPixels - FPointerSize div 2);
                     end;
        else         begin
                       Point1 := Point(PositionPixels,                      FScaleRect.Top               );
                       Point2 := Point(PositionPixels + FPointerSize div 2, FScaleRect.Top - FPointerSize);
                       Point3 := Point(PositionPixels - FPointerSize div 2, FScaleRect.Top - FPointerSize);
                     end;
      end;
      Polygon([Point1, Point2, Point3]);
      //---------------- Arrow 2 ----------------------------------------
      case FOrientation of
        ioVertical : begin
                       Point1 := Point(FScaleRect.Right,                PositionPixels                     );
                       Point2 := Point(FScaleRect.Right + FPointerSize, PositionPixels + FPointerSize div 2);
                       Point3 := Point(FScaleRect.Right + FPointerSize, PositionPixels - FPointerSize div 2);
                     end;
        else         begin
                       Point1 := Point(PositionPixels,                      FScaleRect.Bottom               );
                       Point2 := Point(PositionPixels + FPointerSize div 2, FScaleRect.Bottom + FPointerSize);
                       Point3 := Point(PositionPixels - FPointerSize div 2, FScaleRect.Bottom + FPointerSize);
                     end;
      end;
      Polygon([Point1, Point2, Point3]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.DrawPointerPointer(Canvas: TCanvas);
var
  Point1         : TPoint;
  Point2         : TPoint;
  Point3         : TPoint;
  Point4         : TPoint;
  Point5         : TPoint;
  PositionPixels : Integer;
begin
  with Canvas do
    begin
      PositionPixels := GetPositionToPixels(Position);
      Brush.Style    := bsSolid;
      Brush.Color    := FPointerColor;
      Pen.Color      := FPointerColor;
      Pen.Width      := 1;

      case FOrientation of
        ioVertical : case FPointerOrientation of
                       iosBottomRight : begin
                                          Point1 := Point(FScaleRect.Right,                  PositionPixels                     );
                                          Point2 := Point(FScaleRect.Right +   FPointerSize, PositionPixels + FPointerSize div 2);
                                          Point3 := Point(FScaleRect.Right + 2*FPointerSize, PositionPixels + FPointerSize div 2);
                                          Point4 := Point(FScaleRect.Right + 2*FPointerSize, PositionPixels - FPointerSize div 2);
                                          Point5 := Point(FScaleRect.Right +   FPointerSize, PositionPixels - FPointerSize div 2);
                                        end;
                       else             begin
                                          Point1 := Point(FScaleRect.Left,                  PositionPixels                     );
                                          Point2 := Point(FScaleRect.Left -   FPointerSize, PositionPixels + FPointerSize div 2);
                                          Point3 := Point(FScaleRect.Left - 2*FPointerSize, PositionPixels + FPointerSize div 2);
                                          Point4 := Point(FScaleRect.Left - 2*FPointerSize, PositionPixels - FPointerSize div 2);
                                          Point5 := Point(FScaleRect.Left -   FPointerSize, PositionPixels - FPointerSize div 2);
                                        end;
                     end;
        else         case FPointerOrientation of
                       iosBottomRight : begin
                                          Point1 := Point(PositionPixels,                      FScaleRect.Bottom                 );
                                          Point2 := Point(PositionPixels + FPointerSize div 2, FScaleRect.Bottom +   FPointerSize);
                                          Point3 := Point(PositionPixels + FPointerSize div 2, FScaleRect.Bottom + 2*FPointerSize);
                                          Point4 := Point(PositionPixels - FPointerSize div 2, FScaleRect.Bottom + 2*FPointerSize);
                                          Point5 := Point(PositionPixels - FPointerSize div 2, FScaleRect.Bottom +   FPointerSize);
                                        end;
                       else             begin
                                          Point1 := Point(PositionPixels,                      FScaleRect.Top                 );
                                          Point2 := Point(PositionPixels + FPointerSize div 2, FScaleRect.Top -   FPointerSize);
                                          Point3 := Point(PositionPixels + FPointerSize div 2, FScaleRect.Top - 2*FPointerSize);
                                          Point4 := Point(PositionPixels - FPointerSize div 2, FScaleRect.Top - 2*FPointerSize);
                                          Point5 := Point(PositionPixels - FPointerSize div 2, FScaleRect.Top -   FPointerSize);
                                        end;
                     end;
      end;
      Polygon([Point1, Point2, Point3, Point4, Point5]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiSlidingScale.DrawScale(Canvas: TCanvas);
var
  CurentPosition  : Double;
  PositionPixels  : Integer;
  AText           : String;
  ARect           : TRect;
  AFlags          : TiTextFlags;
  x               : Integer;
  MajorStart      : Integer;
  MajorStop       : Integer;
  MinorStart      : Integer;
  MinorStop       : Integer;
  MidStart        : Integer;
  MidStop         : Integer;
  MajorLabelStart : Integer;
  MidLabelStart   : Integer;
  Polarity        : Integer;
  Edge            : Integer;
begin
  case FScaleOrientation of
    iosBottomRight : begin
                       Polarity := -1;
                       case FOrientation of
                         ioVertical : begin
                                        AFlags := [itfVCenter, itfHRight, itfSingleLine, itfNoClip];
                                        case FScaleAlignStyle of
                                          itasCenter : Edge := (FScaleRect.Left + FScaleRect.Right) div 2;
                                          else         Edge := FScaleRect.Right;
                                        end;
                                      end;
                         else         begin
                                        AFlags := [itfVBottom, itfHCenter, itfSingleLine, itfNoClip];
                                        case FScaleAlignStyle of
                                          itasCenter : Edge := (FScaleRect.Top + FScaleRect.Bottom) div 2;
                                          else         Edge := FScaleRect.Bottom;
                                        end;
                                      end;
                       end;
                     end;
    else             begin
                       Polarity := +1;
                       case FOrientation of
                         ioVertical : begin
                                        AFlags := [itfVCenter, itfHLeft, itfSingleLine, itfNoClip];
                                        case FScaleAlignStyle of
                                          itasCenter : Edge := (FScaleRect.Left + FScaleRect.Right) div 2;
                                          else         Edge := FScaleRect.Left;
                                        end;
                                      end;
                         else         begin
                                        AFlags := [itfVTop, itfHCenter, itfSingleLine, itfNoClip];
                                        case FScaleAlignStyle of
                                          itasCenter : Edge := (FScaleRect.Top + FScaleRect.Bottom) div 2;
                                          else         Edge := FScaleRect.Top;
                                        end;
                                      end;
                       end;
                     end;
  end;

  case FScaleAlignStyle of
    itasCenter : begin
                   MajorStart := Edge - (Polarity)*FHalfMajorLength;
                   MajorStop  := Edge + (Polarity)*FHalfMajorLength;
                   MinorStart := Edge - (Polarity)*FHalfMinorLength;
                   MinorStop  := Edge + (Polarity)*FHalfMinorLength;
                   MidStart   := Edge - (Polarity)*FHalfMidLength;
                   MidStop    := Edge + (Polarity)*FHalfMidLength;
                 end;
    else         begin
                   MajorStart := Edge;
                   MajorStop  := Edge + (Polarity)*2*FHalfMajorLength;
                   MinorStart := Edge;
                   MinorStop  := Edge + (Polarity)*2*FHalfMinorLength;
                   MidStart   := Edge;
                   MidStop    := Edge + (Polarity)*2*FHalfMidLength;
                 end;
  end;

  MajorLabelStart := MajorStop + (Polarity)*FTickMajorLabelMarginPixels;
  MidLabelStart   := MidStop   + (Polarity)*FTickMidLabelMarginPixels;

  with Canvas do
    begin
      CurentPosition := FScaleStartPosition;
      Brush.Style := bsClear;
      while True do
        begin
          //--------------- Major ----------------------------------------------------------
          if Pen.Color <> FTickMajorColor then Pen.Color := FTickMajorColor;
          if Pen.Width <> FTickMajorWidth then Pen.Width := FTickMajorWidth;
          PositionPixels := GetPositionToPixels(CurentPosition);
          PolyLine([PointOrientation(MajorStart, PositionPixels, FOrientation),
                    PointOrientation(MajorStop,  PositionPixels, FOrientation)]);

          Font.Assign(FTickMajorLabelFont);
          AText := iFormatPrecisionStyle(CurentPosition, FScaleSpan, FTickMajorLabelPrecision, ipsFixedDecimalPoints);
          ARect := RectOrientation(MajorLabelStart, PositionPixels, MajorLabelStart, PositionPixels, FOrientation);
          iDrawText(Canvas, AText, ARect, AFlags, True, BackGroundColor);
          //--------------- Minor ----------------------------------------------------------
          Font.Assign(FTickMidLabelFont);
          for x := 0 to FTickMinorCount - 1 do
            begin
              CurentPosition := CurentPosition + FTickMinorStepValue;

              PositionPixels := GetPositionToPixels(CurentPosition);
              if FMidTicksEnabled and (FMidTickNumber = x) then
                begin            
                  if Pen.Color <> FTickMidColor then Pen.Color := FTickMidColor;
                  if Pen.Width <> FTickMidWidth then Pen.Width := FTickMidWidth;
                  PolyLine([PointOrientation(MidStart, PositionPixels, FOrientation),
                            PointOrientation(MidStop,  PositionPixels, FOrientation)]);

                  if FShowMidTickLabels then
                    begin
                      AText := iFormatPrecisionStyle(CurentPosition, FScaleSpan, FTickMidLabelPrecision, ipsFixedDecimalPoints);
                      ARect := RectOrientation(MidLabelStart, PositionPixels, MidLabelStart, PositionPixels, FOrientation);
                      iDrawText(Canvas, AText, ARect, AFlags, True, BackGroundColor);
                    end;
                end
              else
                begin
                  if Pen.Color <> FTickMinorColor then Pen.Color := FTickMinorColor;
                  if Pen.Width <> FTickMinorWidth then Pen.Width := FTickMinorWidth;
                  PolyLine([PointOrientation(MinorStart, PositionPixels, FOrientation),
                            PointOrientation(MinorStop,  PositionPixels, FOrientation)]);
                end;

            end;
          CurentPosition := CurentPosition + FTickMinorStepValue;
          if CurentPosition > FScaleStopPosition then Break;
        end;
    end;
end;
//****************************************************************************************************************************************************
end.

