{*******************************************************}
{                                                       }
{       TiLedBar Component                              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedBar;{$endif}
{$ifdef iCLX}unit QiLedBar;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iProgressComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiProgressComponent;{$ENDIF}

type
  TiLedBarSegmentStyle = (ilbssRectangle, ilbssCircle, ilbssTriangle);

  TiLedBar = class(TiProgressComponent)
  private
    FSegmentDirection     : TiDirection;
    FSegmentSize          : Integer;
    FSegmentSpacing       : Integer;
    FSegmentMargin        : Integer;
    FSegmentStyle         : TiLedBarSegmentStyle;
    FOnAutoSize           : TNotifyEvent;
    FFillReferenceValue   : Double;
    FFillReferenceEnabled : Boolean;
  protected
    procedure SetSegmentStyle        (const Value: TiLedBarSegmentStyle);
    procedure SetSegmentSize         (const Value: Integer);
    procedure SetSegmentSpacing      (const Value: Integer);
    procedure SetSegmentMargin       (const Value: Integer);
    procedure SetSegmentDirection    (const Value: TiDirection);
    procedure SetFillReferenceValue  (const Value: Double);
    procedure SetFillReferenceEnabled(const Value: Boolean);

    procedure iPaintTo     (Canvas: TCanvas); override;
    procedure DrawRectangle(Canvas: TCanvas; DrawRect: TRect; Active: Boolean; ActiveColor, InactiveColor: TColor);
    procedure DrawCircle   (Canvas: TCanvas; DrawRect: TRect; Active: Boolean; ActiveColor, InactiveColor: TColor);
    procedure DrawTriangle (Canvas: TCanvas; DrawRect: TRect; Active: Boolean; ActiveColor, InactiveColor: TColor);

    property OnAutoSize       : TNotifyEvent         read FOnAutoSize       write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent);   override;
  published
    property SegmentDirection     : TiDirection          read FSegmentDirection     write SetSegmentDirection     default idUp;
    property SegmentMargin        : Integer              read FSegmentMargin        write SetSegmentMargin        default 2;
    property SegmentSize          : Integer              read FSegmentSize          write SetSegmentSize          default 5;
    property SegmentSpacing       : Integer              read FSegmentSpacing       write SetSegmentSpacing       default 2;
    property SegmentStyle         : TiLedBarSegmentStyle read FSegmentStyle         write SetSegmentStyle         default ilbssRectangle;
    property FillReferenceValue   : Double               read FFillReferenceValue   write SetFillReferenceValue;
    property FillReferenceEnabled : Boolean              read FFillReferenceEnabled write SetFillReferenceEnabled default False;
    property BackGroundColor                                                                                      default clBlack;
    property BorderStyle;
    property Transparent;
    property Width            default 16;
    property Height           default 200;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLedBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 16;
  Height := 200;

  FSegmentSize          := 5;
  FSegmentSpacing       := 2;
  FSegmentMargin        := 2;
  FFillReferenceEnabled := False;

  BackGroundColor := clBlack;
end;
//****************************************************************************************************************************************************
procedure TiLedBar.SetSegmentSize         (const Value:Integer);begin SetIntegerProperty(Value,FSegmentSize,          irtInvalidate);end;
procedure TiLedBar.SetSegmentSpacing      (const Value:Integer);begin SetIntegerProperty(Value,FSegmentSpacing,       irtInvalidate);end;
procedure TiLedBar.SetSegmentMargin       (const Value:Integer);begin SetIntegerProperty(Value,FSegmentMargin,        irtInvalidate);end;
procedure TiLedBar.SetFillReferenceValue  (const Value:Double );begin SetDoubleProperty (Value,FFillReferenceValue,   irtInvalidate);end;
procedure TiLedBar.SetFillReferenceEnabled(const Value:Boolean);begin SetBooleanProperty(Value,FFillReferenceEnabled, irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiLedBar.SetSegmentStyle(const Value: TiLedBarSegmentStyle);
begin
  if FSegmentStyle <> Value then
    begin
      FSegmentStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedBar.SetSegmentDirection(const Value: TiDirection);
var
  Swap      : Boolean;
  TempWidth : Integer;
begin
  if FSegmentDirection <> Value then
    begin
      if not Loading then
        begin
          Swap := False;
          if (FSegmentDirection = idUp   ) and (Value <> idDown ) then Swap := True;
          if (FSegmentDirection = idDown ) and (Value <> idUp   ) then Swap := True;
          if (FSegmentDirection = idRight) and (Value <> idLeft ) then Swap := True;
          if (FSegmentDirection = idLeft ) and (Value <> idRight) then Swap := True;

          if Swap then
            begin
              TempWidth := Width;
              Width     := Height;
              Height    := TempWidth;
              if Assigned(FOnAutoSize) then FOnAutoSize(Self);
            end;
        end;
      FSegmentDirection := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedBar.iPaintTo(Canvas: TCanvas);
var
  i                   : Integer;
  DrawRect            : TRect;
  SegmentsTotal       : Integer;
  SegmentsIlluminated : Integer;
  SegmentDrawRect     : TRect;
  SegmentStepSize     : Integer;
  DrawAreaHeight      : Integer;
  ActiveColor         : TColor;
  InactiveColor       : TColor;
  CurrentDrawSection  : TiDrawSection;
  ActiveState         : Boolean;
  SectionCount1       : Integer;
  SectionCount2       : Integer;
  SectionCount3       : Integer;
  SectionCount4       : Integer;
  Offset              : Integer;
  CurrentValue        : Double;
begin
  with Canvas do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      DrawRect           := Rect(0, 0 ,Width, Height);

      case BorderStyle of
        ibsLowered : DrawRect := Rect(DrawRect.Left + 2, DrawRect.Top + 2, DrawRect.Right - 2, drawRect.Bottom - 2);
        ibsRaised  : DrawRect := Rect(DrawRect.Left + 2, DrawRect.Top + 2, DrawRect.Right - 2, drawRect.Bottom - 2);
      end;

      with DrawRect do
        begin
          case FSegmentDirection of
            idUp, idDown   : DrawAreaHeight := Bottom - Top - 2*FSegmentMargin+2;
            else             DrawAreaHeight := Right - Left - 2*FSegmentMargin+2;
          end;

          SegmentStepSize     := FSegmentSize + FSegmentSpacing;
          if SegmentStepSize = 0 then
            begin
              SegmentsTotal := 0;
              Offset        := 0
            end
          else
            begin
              SegmentsTotal := DrawAreaHeight div SegmentStepSize;
              Offset        := (DrawAreaHeight mod SegmentStepSize) div 2;
            end;
          SegmentsIlluminated := Round(SegmentsTotal * ValuePercent(Position) + 0.5);

          if (PositionMax <> PositionMin) and (SegmentsTotal <> 0) then
            begin
              SectionCount1 := Round((SectionEnd1-PositionMin)/(PositionMax-PositionMin)*SegmentsTotal);
              SectionCount2 := Round((SectionEnd2-PositionMin)/(PositionMax-PositionMin)*SegmentsTotal);
              SectionCount3 := Round((SectionEnd3-PositionMin)/(PositionMax-PositionMin)*SegmentsTotal);
              SectionCount4 := Round((SectionEnd4-PositionMin)/(PositionMax-PositionMin)*SegmentsTotal);
            end
          else
            begin
              SectionCount1 := 0;
              SectionCount2 := 0;
              SectionCount3 := 0;
              SectionCount4 := 0;
            end;

          case FSegmentDirection of
            idUp    : SegmentDrawRect := Rect(DrawRect.Left  + FSegmentMargin,                DrawRect.Bottom - Offset - FSegmentMargin - FSegmentSize,
                                              DrawRect.Right - FSegmentMargin,                DrawRect.Bottom - Offset - FSegmentMargin);

            idDown  : SegmentDrawRect := Rect(DrawRect.Left  + FSegmentMargin,                DrawRect.Top    + Offset+ FSegmentMargin,
                                              DrawRect.Right - FSegmentMargin,                DrawRect.Top    + Offset+ FSegmentMargin + FSegmentSize);

            idRight : SegmentDrawRect := Rect(DrawRect.Left  + FSegmentMargin,                DrawRect.Top    + FSegmentMargin,
                                              DrawRect.Left  + FSegmentMargin + FSegmentSize, DrawRect.Bottom - FSegmentMargin);

            idLeft  : SegmentDrawRect := Rect(DrawRect.Right - FSegmentMargin - FSegmentSize, DrawRect.Top    + FSegmentMargin,
                                              DrawRect.Right - FSegmentMargin,                DrawRect.Bottom - FSegmentMargin);
          end;

          i := 0;
          CurrentDrawSection := idsSection1;

          while i < SegmentsTotal  do
            begin
              CurrentValue := (PositionMax - PositionMin)/SegmentsTotal*i + PositionMin;

              if (i = SegmentsIlluminated) then if not ShowOffSegments then Break;

              if SectionCount > 1 then if i >= SectionCount1 then CurrentDrawSection := idsSection2;
              if SectionCount > 2 then if i >= SectionCount2 then CurrentDrawSection := idsSection3;
              if SectionCount > 3 then if i >= SectionCount3 then CurrentDrawSection := idsSection4;
              if SectionCount > 4 then if i >= SectionCount4 then CurrentDrawSection := idsSection5;

              if i < SegmentsIlluminated then ActiveState := True else ActiveState := False;

              if FFillReferenceEnabled then
                begin
                  if (CurrentValue >= FillReferenceValue) and (CurrentValue <= Position) or
                     (CurrentValue <  FillReferenceValue) and (CurrentValue >= Position) then ActiveState := True else ActiveState := False;
                end;

              case CurrentDrawSection of
                idsSection1 : ActiveColor := SectionColor1;
                idsSection2 : ActiveColor := SectionColor2;
                idsSection3 : ActiveColor := SectionColor3;
                idsSection4 : ActiveColor := SectionColor4;
                else          ActiveColor := SectionColor5;
              end;

              InactiveColor := DimColor(ActiveColor, 3);

              if (not ActiveState) and (not ShowOffSegments) then InactiveColor := BackGroundColor;

              case FSegmentStyle of
                ilbssRectangle : DrawRectangle(Canvas, SegmentDrawRect, ActiveState, ActiveColor, InactiveColor);
                ilbssCircle    : DrawCircle   (Canvas, SegmentDrawRect, ActiveState, ActiveColor, InactiveColor);
                ilbssTriangle  : DrawTriangle (Canvas, SegmentDrawRect, ActiveState, ActiveColor, InactiveColor);
              end;

              case FSegmentDirection of
                idUp    : OffsetRect(SegmentDrawRect, 0, -SegmentStepSize);
                idDown  : OffsetRect(SegmentDrawRect, 0, +SegmentStepSize);
                idRight : OffsetRect(SegmentDrawRect, +SegmentStepSize, 0);
                idLeft  : OffsetRect(SegmentDrawRect, -SegmentStepSize, 0);
              end;
              inc(i);
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedBar.DrawRectangle(Canvas: TCanvas; DrawRect: TRect; Active: Boolean; ActiveColor, InactiveColor: TColor);
begin
  with Canvas do
    begin
      if Active then
        begin
          Brush.Color := ActiveColor;
          Pen.Color   := ActiveColor;
        end
      else
        begin
          Brush.Color := InactiveColor;
          Pen.Color   := InactiveColor;
        end;

      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      Rectangle(DrawRect.Left, DrawRect.Top, DrawRect.Right, DrawRect.Bottom);
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedBar.DrawTriangle(Canvas: TCanvas; DrawRect: TRect; Active: Boolean; ActiveColor, InactiveColor: TColor);
var
  CenterX : Integer;
  CenterY : Integer;
begin
  with Canvas, DrawRect do
    begin
      if Active then
        begin
          Brush.Color := ActiveColor;
          Pen.Color   := ActiveColor;
        end
      else
        begin
          Brush.Color := InactiveColor;
          Pen.Color   := InactiveColor;
        end;

      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      CenterX := (Right  + Left) div 2;
      CenterY := (Bottom + Top ) div 2;

      case FSegmentDirection of
        idUp    : Polygon([Point(CenterX  - (FSegmentSize div 2), Bottom),
                           Point(CenterX  + (FSegmentSize div 2), Bottom),
                           Point(CenterX,                         Top   )]);
        idDown  : Polygon([Point(CenterX  - (FSegmentSize div 2), Top),
                           Point(CenterX  + (FSegmentSize div 2), Top),
                           Point(CenterX,                         Bottom)]);
        idRight : Polygon([Point(Left,  CenterY - (FSegmentSize div 2)),
                           Point(Left,  CenterY + (FSegmentSize div 2)),
                           Point(Right, CenterY                      )]);
        idLeft  : Polygon([Point(Right, CenterY - (FSegmentSize div 2)),
                           Point(Right, CenterY + (FSegmentSize div 2)),
                           Point(Left,  CenterY                      )]);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedBar.DrawCircle(Canvas: TCanvas; DrawRect: TRect; Active: Boolean; ActiveColor, InactiveColor: TColor);
var
  TempDrawRect : TRect;
  CenterX      : Integer;
  CenterY      : Integer;
begin
  with Canvas do
    begin
      if Active then
        begin
          Brush.Color := ActiveColor;
          Pen.Color   := ActiveColor;
        end
      else
        begin
          Brush.Color := InactiveColor;
          Pen.Color   := InactiveColor;
        end;

      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      CenterX := (DrawRect.Right  + DrawRect.Left) div 2;
      CenterY := (DrawRect.Bottom + DrawRect.Top ) div 2;

      TempDrawRect := Rect(CenterX  - FSegmentSize div 2,
                           CenterY  - FSegmentSize div 2,
                           CenterX  + FSegmentSize - (FSegmentSize div 2),
                           CenterY  + FSegmentSize - (FSegmentSize div 2));
      with TempDrawRect do
        begin
          Ellipse(Left, Top, Right, Bottom);

          if Active then Pen.Color := clWhite else Pen.Color := ActiveColor;

          Arc(Left+FSegmentSize div 4,  Top+FSegmentSize div 4,  Right-FSegmentSize div 4,  Bottom-FSegmentSize div 4,  Right - FSegmentSize div 2,Top,Left,Bottom - FSegmentSize div 2);
          Arc(Left+FSegmentSize div 4+1,Top+FSegmentSize div 4+1,Right-FSegmentSize div 4-1,Bottom-FSegmentSize div 4-1,Right - FSegmentSize div 2,Top,Left,Bottom - FSegmentSize div 2);
        end;
    end;
end;
//****************************************************************************************************************************************************
end.
