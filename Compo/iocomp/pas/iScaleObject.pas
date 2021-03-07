{*******************************************************}
{                                                       }
{       TiScaleObject                                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScaleObject;{$endif}
{$ifdef iCLX}unit QiScaleObject;{$endif}

interface

uses
  SysUtils, Classes,
{$IFDEF LINUX}
  Xlib,
{$ENDIF}
{$IFDEF MSWINDOWS}
  Windows, Messages,
{$ENDIF}
{$ifdef iCLX}
  Qt, QGraphics, QControls, Types,
  QiMath, QiTypes, QiGPFunctions;
{$else}
  Graphics, Controls, 
  iMath, iTypes, iGPFunctions;
{$endif}

type
  TiScaleObject = class(TObject)
  private
    FShowTicksAxis           : Boolean;
    FShowTicksMinor          : Boolean;
    FShowTicksMajor          : Boolean;
    FShowTickLabels          : Boolean;
    FTickMinorCount          : Integer;
    FTickMinorLength         : Integer;
    FTickMajorLength         : Integer;
    FTickMargin              : Integer;
    FTickMajorCount          : Integer;
    FTickLabelPrecision      : Integer;
    FTickLabelMargin         : Integer;
    FTickMinorColor          : TColor;
    FTickMajorColor          : TColor;
    FTickLabelFont           : TFont;
    FOnChange                : TNotifyEvent;
    FPositionMax             : Double;
    FPositionMin             : Double;
    FStart                   : Integer;
    FStop                    : Integer;
    FTickMinorAlignment      : TiTickMinorAlignment;
    FOrientation             : TiOrientation;
    FOrientationTickMarks    : TiOrientationSide;
    FEdge                    : Integer;
    FTickMajorStyle          : TiBevelStyle;
    FTickMinorStyle          : TiBevelStyle;
    FShowTicksMajorFirstLast : Boolean;
    FReverseTickMinorAlign   : Boolean;
    FReverseScale            : Boolean;
    FPrecisionStyle          : TiPrecisionStyle;
    FOnCustomizeTickLabel    : TOnCustomizeTickLabel;
    FAutoScaleEnabled        : Boolean;
    FAutoScaleMaxTicks       : Integer;
    FAutoScaleDesiredTicks   : Integer;
    FAutoScaleStyle          : TiAutoScaleStyle;
    FAutoScaleMinTick        : Double;
    FAutoScaleMaxTick        : Double;
    
    procedure SetShowTicksAxis          (const Value: Boolean);
    procedure SetShowTickLabels         (const Value: Boolean);
    procedure SetShowTicksMajor         (const Value: Boolean);
    procedure SetShowTicksMinor         (const Value: Boolean);
    procedure SetTickLabelFont          (const Value: TFont);
    procedure SetTickLabelMargin        (const Value: Integer);
    procedure SetTickLabelPrecision     (const Value: Integer);
    procedure SetTickMajorColor         (const Value: TColor);
    procedure SetTickMajorCount         (const Value: Integer);
    procedure SetTickMajorLength        (const Value: Integer);
    procedure SetTickMargin             (const Value: Integer);
    procedure SetTickMinorColor         (const Value: TColor);
    procedure SetTickMinorCount         (const Value: Integer);
    procedure SetTickMinorLength        (const Value: Integer);
    procedure SetTickMinorAlignment     (const Value: TiTickMinorAlignment);
    procedure SetTickMajorStyle         (const Value: TiBevelStyle);
    procedure SetTickMinorStyle         (const Value: TiBevelStyle);
    procedure SetShowTicksMajorFirstLast(const Value: Boolean);
    procedure SetReverseScale           (const Value: Boolean);
    procedure SetPrecisionStyle         (const Value: TiPrecisionStyle);
    function  GetDecimalPoints : Integer;
  protected
    procedure Change;
    procedure FontChange(Sender : TObject);
  public
    constructor Create;
    destructor  Destroy; override;

    function  ValueToPixels(Value: Double ): Integer;
    function  PixelsToValue(Value: Integer): Double;

    procedure Draw         (Canvas: TCanvas; Enabled: Boolean; ABackgroundColor: TColor);
    procedure DrawScaleLine(Canvas: TCanvas; Enabled: Boolean);
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    property Start                   : Integer               read FStart                   write FStart;
    property Stop                    : Integer               read FStop                    write FStop;
    property Edge                    : Integer               read FEdge                    write FEdge;
    property PositionMax             : Double                read FPositionMax             write FPositionMax;
    property PositionMin             : Double                read FPositionMin             write FPositionMin;
    property Orientation             : TiOrientation         read FOrientation             write FOrientation;
    property OrientationTickMarks    : TiOrientationSide     read FOrientationTickMarks    write FOrientationTickMarks;
    property ReverseTickMinorAlign   : Boolean               read FReverseTickMinorAlign   write FReverseTickMinorAlign;
    property AutoScaleEnabled        : Boolean               read FAutoScaleEnabled        write FAutoScaleEnabled;
    property AutoScaleDesiredTicks   : Integer               read FAutoScaleDesiredTicks   write FAutoScaleDesiredTicks;
    property AutoScaleMaxTicks       : Integer               read FAutoScaleMaxTicks       write FAutoScaleMaxTicks;
    property AutoScaleStyle          : TiAutoScaleStyle      read FAutoScaleStyle          write FAutoScaleStyle;
    property AutoScaleMaxTick        : Double                read FAutoScaleMaxTick        write FAutoScaleMaxTick;
    property AutoScaleMinTick        : Double                read FAutoScaleMinTick        write FAutoScaleMinTick;

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    property ShowTicksAxis          : Boolean                read FShowTicksAxis           write SetShowTicksAxis;

    property ShowTicksMajor          : Boolean               read FShowTicksMajor          write SetShowTicksMajor;
    property ShowTicksMinor          : Boolean               read FShowTicksMinor          write SetShowTicksMinor;
    property ShowTickLabels          : Boolean               read FShowTickLabels          write SetShowTickLabels;
    property ShowTicksMajorFirstLast : Boolean               read FShowTicksMajorFirstLast write SetShowTicksMajorFirstLast;
    property TickMajorCount          : Integer               read FTickMajorCount          write SetTickMajorCount;
    property TickMajorColor          : TColor                read FTickMajorColor          write SetTickMajorColor;
    property TickMajorLength         : Integer               read FTickMajorLength         write SetTickMajorLength;
    property TickMajorStyle          : TiBevelStyle          read FTickMajorStyle          write SetTickMajorStyle;
    property TickMinorAlignment      : TiTickMinorAlignment  read FTickMinorAlignment      write SetTickMinorAlignment;
    property TickMinorCount          : Integer               read FTickMinorCount          write SetTickMinorCount;
    property TickMinorColor          : TColor                read FTickMinorColor          write SetTickMinorColor;
    property TickMinorLength         : Integer               read FTickMinorLength         write SetTickMinorLength;
    property TickMinorStyle          : TiBevelStyle          read FTickMinorStyle          write SetTickMinorStyle;
    property TickMargin              : Integer               read FTickMargin              write SetTickMargin;
    property TickLabelMargin         : Integer               read FTickLabelMargin         write SetTickLabelMargin;
    property TickLabelFont           : TFont                 read FTickLabelFont           write SetTickLabelFont;
    property TickLabelPrecision      : Integer               read FTickLabelPrecision      write SetTickLabelPrecision;
    property ReverseScale            : Boolean               read FReverseScale            write SetReverseScale;
    property PrecisionStyle          : TiPrecisionStyle      read FPrecisionStyle          write SetPrecisionStyle;
    property OnChange                : TNotifyEvent          read FOnChange                write FOnChange;
    property OnCustomizeTickLabel    : TOnCustomizeTickLabel read FOnCustomizeTickLabel    write FOnCustomizeTickLabel;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiScaleObject.Create;
begin
  FTickMajorCount          := 5;
  FTickMajorLength         := 7;

  FTickMinorLength         := 3;
  FTickMinorCount          := 4;

  FTickLabelMargin         := 5;
  FTickLabelPrecision      := 0;
  FTickMargin              := 5;

  FShowTicksMajorFirstLast := True;

  FTickLabelFont := TFont.Create; FTickLabelFont.OnChange := FontChange;
end;
//****************************************************************************************************************************************************
destructor TiScaleObject.Destroy;
begin
  FTickLabelFont.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetShowTickLabels(const Value: Boolean);
begin
  if FShowTickLabels <> Value then
    begin
      FShowTickLabels := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetShowTicksAxis(const Value: Boolean);
begin
  if FShowTicksAxis <> Value then
    begin
      FShowTicksAxis := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetShowTicksMajor(const Value: Boolean);
begin
  if FShowTicksMajor <> Value then
    begin
      FShowTicksMajor := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetShowTicksMinor(const Value: Boolean);
begin
  if FShowTicksMinor <> Value then
    begin
      FShowTicksMinor := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetShowTicksMajorFirstLast(const Value: Boolean);
begin
  if FShowTicksMajorFirstLast <> Value then
    begin
      FShowTicksMajorFirstLast := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickLabelFont(const Value: TFont);
begin
  FTickLabelFont.Assign(Value);
  Change;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickLabelMargin(const Value: Integer);
begin
  if FTickLabelMargin <> Value then
    begin
      FTickLabelMargin := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickLabelPrecision(const Value: Integer);
begin
  if FTickLabelPrecision <> Value then
    begin
      FTickLabelPrecision := Value;
      if FTickLabelPrecision < 0 then FTickLabelPrecision := 0;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMajorColor(const Value: TColor);
begin
  if FTickMajorColor <> Value then
    begin
      FTickMajorColor := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMajorCount(const Value: Integer);
begin
  if FTickMajorCount <> Value then
    begin
      FTickMajorCount := Value;
      if FTickMajorCount <   2 then FTickMajorCount := 2;
      if FTickMajorCount > 100 then FTickMajorCount := 100;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMajorLength(const Value: Integer);
begin
  if FTickMajorLength <> Value then
    begin
      FTickMajorLength := Value;
      if FTickMajorLength < 1 then FTickMajorLength := 1;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMajorStyle(const Value: TiBevelStyle);
begin
  if FTickMajorStyle <> Value then
    begin
      FTickMajorStyle := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMargin(const Value: Integer);
begin
  if FTickMargin <> Value then
    begin
      FTickMargin := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMinorAlignment(const Value: TiTickMinorAlignment);
begin
  if FTickMinorAlignment <> Value then
    begin
      FTickMinorAlignment := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMinorColor(const Value: TColor);
begin
  if FTickMinorColor <> Value then
    begin
      FTickMinorColor := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMinorCount(const Value: Integer);
begin
  if FTickMinorCount <> Value then
    begin
      FTickMinorCount := Value;
      if FTickMinorCount <   1 then FTickMinorCount := 1;
      if FTickMinorCount > 100 then FTickMinorCount := 100;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMinorLength(const Value: Integer);
begin
  if FTickMinorLength <> Value then
    begin
      FTickMinorLength := Value;
      if FTickMinorLength < 1 then FTickMinorLength := 1;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetTickMinorStyle(const Value: TiBevelStyle);
begin
  if FTickMinorStyle <> Value then
    begin
      FTickMinorStyle := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetReverseScale(const Value: Boolean);
begin
  if FReverseScale <> Value then
    begin
      FReverseScale := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.SetPrecisionStyle(const Value: TiPrecisionStyle);
begin
  if FPrecisionStyle <> Value then
    begin
      FPrecisionStyle := Value;
      Change;
    end;
end;
//****************************************************************************************************************************************************
function TiScaleObject.ValueToPixels(Value: Double): Integer;
var
  ActualStart : Integer;
  ActualStop  : Integer;
  APixelsSpan : Integer;
  AMin        : Double;
  AMax        : Double;
  ASpan       : Double;
begin
  if FReverseScale then begin ActualStart := FStop;  ActualStop := FStart;end
  else                  begin ActualStart := FStart; ActualStop := FStop; end;

  AMin        := PositionMin;
  AMax        := PositionMax;
  ASpan       := AMax - AMin;
  APixelsSpan := ActualStart - ActualStop;

  if ASpan <> 0 then Result := ActualStart - Round((Value - AMin)/ASpan*APixelsSpan)
  else               Result := (ActualStart + ActualStop) div 2;
end;
//****************************************************************************************************************************************************
function TiScaleObject.PixelsToValue(Value: Integer): Double;
var
  ActualStart : Integer;
  ActualStop  : Integer;
  APixelsSpan : Integer;
  AMin        : Double;
  AMax        : Double;
  ASpan       : Double;
begin
  if FReverseScale then begin ActualStart := FStop;  ActualStop := FStart;end
  else                  begin ActualStart := FStart; ActualStop := FStop; end;

  AMin        := PositionMin;
  AMax        := PositionMax;
  ASpan       := AMax - AMin;
  APixelsSpan := ActualStart - ActualStop;            

  if APixelsSpan <> 0 then Result := (ActualStart - Value)/APixelsSpan*ASpan + AMin
  else                     Result := (AMax + AMin)/2;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.DrawScaleLine(Canvas: TCanvas; Enabled: Boolean);
var
  APixelsMin    : Integer;
  APixelsMax    : Integer;
  AEdge         : Integer;
  ASidePolarity : Integer;
begin
  if not FShowTicksAxis then Exit;

  APixelsMin := ValueToPixels(PositionMin);
  APixelsMax := ValueToPixels(PositionMax);

  if APixelsMin > APixelsMax then SwapIntegers(APixelsMin, APixelsMax);

  case FOrientationTickMarks of
    iosBottomRight : ASidePolarity :=  1;
    else             ASidePolarity := -1;
  end;

  with Canvas do
    begin
      Pen.Color := TickMajorColor;
      case FOrientation of
        ioVertical   : case FOrientationTickMarks of
                         iosBottomRight : begin
                                            AEdge := Edge + ASidePolarity*TickMajorLength;
                                            if not Enabled then LineBevel(Canvas, AEdge, APixelsMin, AEdge, APixelsMax+1, ibsLowered)
                                            else
                                              begin
                                                Line(Canvas, AEdge,   APixelsMin, AEdge,   APixelsMax+1);
                                                Line(Canvas, AEdge+1, APixelsMin, AEdge+1, APixelsMax+1);
                                              end;
                                          end;
                         iosTopLeft     : begin
                                            AEdge := Edge - TickMajorLength;
                                            if not Enabled then LineBevel(Canvas, AEdge, APixelsMin, AEdge, APixelsMax, ibsLowered)
                                            else
                                              begin
                                                Line(Canvas, AEdge,   APixelsMin, AEdge,   APixelsMax+1);
                                                Line(Canvas, AEdge-1, APixelsMin, AEdge-1, APixelsMax+1);
                                              end;
                                          end;
                       end;
        ioHorizontal : case FOrientationTickMarks of
                         iosBottomRight : begin
                                            AEdge := Edge + TickMajorLength;
                                            if not Enabled then LineBevel(Canvas, APixelsMin, AEdge, APixelsMax+1, AEdge, ibsLowered)
                                            else
                                              begin
                                                Line(Canvas, APixelsMin, AEdge,   APixelsMax+1, AEdge);
                                                Line(Canvas, APixelsMin, AEdge+1, APixelsMax+1, AEdge+1);
                                              end;
                                          end;
                         iosTopLeft     : begin
                                            AEdge := Edge - TickMajorLength;
                                            if not Enabled then LineBevel(Canvas, APixelsMin, AEdge, APixelsMax, AEdge, ibsLowered)
                                            else
                                              begin
                                                Line(Canvas, APixelsMin, AEdge,   APixelsMax+1, AEdge);
                                                Line(Canvas, APixelsMin, AEdge-1, APixelsMax+1, AEdge-1);
                                              end;
                                          end;
                       end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.Draw(Canvas: TCanvas; Enabled: Boolean; ABackgroundColor: TColor);
var
  SidePolarity             : Integer;
  MinorEdge                : Integer;
  MajorEdge                : Integer;
  LabelEdge                : Integer;
  x, y                     : Integer;
  TextString               : String;
  ShowMajorTick            : Boolean;
  TempRect                 : TRect;
  ATextHeight              : Integer;
  ATextWidth               : Integer;
  ATextRect                : TRect;
  ActualTickMinorAlignment : TiTickMinorAlignment;
  ActualMin                : Double;
  ActualMax                : Double;
  CurrentPosition          : Double;
  MajorStepValue           : Double;
  MinorStepValue           : Double;
  PositionPixels           : Integer;
begin
  if AutoScaleEnabled and (AutoScaleStyle = iassFixedMinMax) then
    begin
      ActualMin   := FAutoScaleMinTick;
      ActualMax   := FAutoScaleMaxTick;
    end
  else
    begin
      ActualMin   := PositionMin;
      ActualMax   := PositionMax;
    end;

  if FReverseTickMinorAlign then
    case FTickMinorAlignment of
      itmnaInside  : ActualTickMinorAlignment := itmnaOutside;
      itmnaOutside : ActualTickMinorAlignment := itmnaInside;
      else           ActualTickMinorAlignment := itmnaCenter;
    end
  else ActualTickMinorAlignment := FTickMinorAlignment;

  MajorStepValue := (ActualMax - ActualMin)/(TickMajorCount-1);
  MinorStepValue := MajorStepValue/(TickMinorCount+1);

  with Canvas do
    begin
      Brush.Style := bsClear;
      Font.Assign(TickLabelFont);

      case FOrientationTickMarks of
        iosBottomRight : SidePolarity :=  1;
        else             SidePolarity := -1;
      end;

      MajorEdge := FEdge + SidePolarity*FTickMargin;
      LabelEdge := MajorEdge + SidePolarity*(FTickMajorLength + FTickLabelMargin);

      case ActualTickMinorAlignment of
        itmnaInside  : MinorEdge := MajorEdge;
        itmnaCenter  : MinorEdge := MajorEdge + SidePolarity*(FTickMajorLength div 2 - FTickMinorLength div 2);
        else           MinorEdge := MajorEdge + SidePolarity*(FTickMajorLength       - FTickMinorLength      );
      end;


      for x := 0 to FTickMajorCount - 1 do
        begin
          CurrentPosition := ActualMin + (MajorStepValue*x);
          PositionPixels  := ValueToPixels(CurrentPosition);

          //-------------------------------------------------------------------------------------------------------------------------------
          if FShowTicksMajor then
            begin
              ShowMajorTick := True;
              if not FShowTicksMajorFirstLast and (x = 0               ) then ShowMajorTick := False;
              if not FShowTicksMajorFirstLast and (x = TickMajorCount-1) then ShowMajorTick := False;
              if ShowMajorTick then
                begin
                  Pen.Color      := FTickMajorColor;
                  case FOrientation of
                    ioVertical   : TempRect := Rect(MajorEdge, PositionPixels, MajorEdge + SidePolarity*FTickMajorLength, PositionPixels);
                    ioHorizontal : TempRect := Rect(PositionPixels, MajorEdge, PositionPixels, MajorEdge + SidePolarity*FTickMajorLength);
                  end;
                  if Enabled then LineBevel(Canvas, TempRect.Left, TempRect.Top, TempRect.Right, TempRect.Bottom, FTickMajorStyle)
                  else            LineBevel(Canvas, TempRect.Left, TempRect.Top, TempRect.Right, TempRect.Bottom, ibsLowered);
                end;
            end;                                                    
          //-------------------------------------------------------------------------------------------------------------------------------
          if FShowTickLabels then
            begin
              TextString  := Trim(SysUtils.Format('%.' + IntToStr(GetDecimalPoints) + 'f', [CurrentPosition]));
              if Assigned(OnCustomizeTickLabel) then TOnCustomizeTickLabel(OnCustomizeTickLabel)(Self, x, TextString);

              ATextHeight := TextHeight(TextString);
              ATextWidth  := TextWidth (TextString);

              case FOrientation of
                ioVertical : case FOrientationTickMarks of
                               iosBottomRight : ATextRect := GetCenterPointRect(LabelEdge + ATextWidth div 2, PositionPixels, ATextWidth, ATextHeight);
                               else             ATextRect := GetCenterPointRect(LabelEdge - ATextWidth div 2, PositionPixels, ATextWidth, ATextHeight);
                             end;
                else         case FOrientationTickMarks of
                               iosBottomRight : ATextRect := GetCenterPointRect(PositionPixels, LabelEdge + ATextHeight div 2, ATextWidth, ATextHeight);
                               else             ATextRect := GetCenterPointRect(PositionPixels, LabelEdge - ATextHeight div 2, ATextWidth, ATextHeight);
                             end;
              end;

              iDrawText(Canvas, TextString, ATextRect, [itfHCenter, itfVCenter, itfSingleLine], Enabled, ABackgroundColor);
            end;
          //-------------------------------------------------------------------------------------------------------------------------------
          if FShowTicksMinor and FShowTicksMajor and (x < FTickMajorCount - 1) then
            begin
              Pen.Color := FTickMinorColor;
              for y := 1 to FTickMinorCount do
                begin
                  PositionPixels  := ValueToPixels(ActualMin + MajorStepValue*x + MinorStepValue*y);
                  case FOrientation of
                    ioVertical   : TempRect := Rect(MinorEdge, PositionPixels, MinorEdge + SidePolarity*FTickMinorLength, PositionPixels);
                    ioHorizontal : TempRect := Rect(PositionPixels, MinorEdge, PositionPixels, MinorEdge + SidePolarity*FTickMinorLength);
                  end;
                  if Enabled then LineBevel(Canvas, TempRect.Left, TempRect.Top, TempRect.Right, TempRect.Bottom, FTickMinorStyle)
                  else            LineBevel(Canvas, TempRect.Left, TempRect.Top, TempRect.Right, TempRect.Bottom, ibsLowered);
                end;
            end;
          //-------------------------------------------------------------------------------------------------------------------------------
        end;

      if (FAutoScaleStyle = iassFixedMinMax) and FShowTicksMinor and (MinorStepValue <> 0) then
        begin
          CurrentPosition := ActualMax + MinorStepValue;
          while CurrentPosition <= FPositionMax do
            begin
              PositionPixels  := ValueToPixels(CurrentPosition);
              case FOrientation of
                ioVertical   : TempRect := Rect(MinorEdge, PositionPixels, MinorEdge + SidePolarity*FTickMinorLength, PositionPixels);
                ioHorizontal : TempRect := Rect(PositionPixels, MinorEdge, PositionPixels, MinorEdge + SidePolarity*FTickMinorLength);
              end;
              LineBevel(Canvas, TempRect.Left, TempRect.Top, TempRect.Right, TempRect.Bottom, FTickMinorStyle);

              CurrentPosition := CurrentPosition + MinorStepValue;
            end;

          CurrentPosition := ActualMin - MinorStepValue;
          while CurrentPosition >= FPositionMin do
            begin
              PositionPixels  := ValueToPixels(CurrentPosition);
              case FOrientation of
                ioVertical   : TempRect := Rect(MinorEdge, PositionPixels, MinorEdge + SidePolarity*FTickMinorLength, PositionPixels);
                ioHorizontal : TempRect := Rect(PositionPixels, MinorEdge, PositionPixels, MinorEdge + SidePolarity*FTickMinorLength);
              end;
              LineBevel(Canvas, TempRect.Left, TempRect.Top, TempRect.Right, TempRect.Bottom, FTickMinorStyle);

              CurrentPosition := CurrentPosition - MinorStepValue;
            end;
        end;

    end;
end;
//****************************************************************************************************************************************************
procedure TiScaleObject.FontChange(Sender: TObject);
begin
  Change;
end;
//****************************************************************************************************************************************************
function TiScaleObject.GetDecimalPoints: Integer;
var
  Span : Double;
begin
  Result := 0;
  case FPrecisionStyle of
    ipsSignificantDigits : if FTickLabelPrecision > 0 then
                             begin
                               Span := ABS(PositionMax - PositionMin);
                               if Span <> 0 then Result := FTickLabelPrecision - (Trunc(Log10(Span))+1) else Result := 0;
                               if Span < 1 then Result := Result + 1;
                               if Result < 0 then Result := 0;
                             end;
    ipsFixedDecimalPoints : Result := FTickLabelPrecision;
  end;
end;
//****************************************************************************************************************************************************
end.
