{*******************************************************}
{                                                       }
{       TiLedArrow Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedArrow;{$endif}
{$ifdef iCLX}unit QiLedArrow;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iClasses,  iLed;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiClasses, QiLed;{$ENDIF}

type
  TiLedArrowStyle = (ilasRight, ilasLeft, ilasUp, ilasDown, ilasLeftRight, ilasUpDown);

  TiPointRecord = record
    Point   : TPoint;
    Shadow  : Boolean;
  end;
   
  TiLedArrow = class(TiLed)
  private
    FStyle           : TiLedArrowStyle;
    FAutoSize        : Boolean;
    FDoingAutoSize   : Boolean;
    FArrowBodyLength : Integer;
    FArrowHeadSize   : Integer;
    FOnAutoSize      : TNotifyEvent;
    procedure SetStyle          (const Value: TiLedArrowStyle);
    procedure iSetAutoSize      (const Value: Boolean);
    procedure SetArrowBodyLength(const Value: Integer);
    procedure SetArrowHeadSize  (const Value: Integer);
  protected
    procedure iPaintTo(Canvas: TCanvas);                          override;
    procedure DoAutoSize;

    property OnAutoSize       : TNotifyEvent    read FOnAutoSize      write FOnAutoSize;
  public
    constructor Create(AOwner: TComponent);                       override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property AutoSize         : Boolean         read FAutoSize        write iSetAutoSize        default True;
    property Style            : TiLedArrowStyle read FStyle           write SetStyle            default ilasRight;
    property ArrowBodyLength  : Integer         read FArrowBodyLength write SetArrowBodyLength  default 20;
    property ArrowHeadSize    : Integer         read FArrowHeadSize   write SetArrowHeadSize    default 20;
    property Active;
    property ActiveColor;
    property BevelStyle;
    property OnChange;              
    property BackGroundColor;
    property Transparent;
    property Width            default 40;
    property Height           default 20;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiLedArrow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width            := 40;
  Height           := 20;

  FArrowHeadSize   := 20;
  FArrowBodyLength := 20;
  iSetAutoSize(True);
end;
//****************************************************************************************************************************************************
procedure TiLedArrow.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  case FStyle of
    ilasRight, ilasLeft : if AWidth  <   AHeight then AWidth  :=   AHeight;
    ilasLeftRight       : if AWidth  < 2*AHeight then AWidth  := 2*AHeight;
    ilasUp, ilasDown    : if AHeight <   AWidth  then AHeight :=   AWidth;
    ilasUpDown          : if AHeight < 2*AWidth  then AHeight := 2*AWidth;
  end;

  inherited;
  if FAutoSize and (not FDoingAutoSize) then
    begin
      case FStyle of
        ilasRight, ilasLeft : begin
                                FArrowHeadSize   := AHeight;
                                FArrowBodyLength := AWidth - FArrowHeadSize;
                              end;
        ilasLeftRight       : begin
                                FArrowHeadSize   := AHeight;
                                FArrowBodyLength := (AWidth - 2*FArrowHeadSize) div 2;
                              end;
        ilasUp, ilasDown    : begin
                                FArrowHeadSize   := AWidth;
                                FArrowBodyLength := AHeight - FArrowHeadSize;
                              end;
        ilasUpDown          : begin
                                FArrowHeadSize   := AWidth;
                                FArrowBodyLength := (AHeight - 2*FArrowHeadSize) div 2;
                              end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedArrow.DoAutoSize;
begin
  if FAutoSize then
    begin
      FDoingAutoSize := True;
      case FStyle of
        ilasRight, ilasLeft : begin
                                Height := FArrowHeadSize;
                                Width  := FArrowBodyLength + FArrowHeadSize;
                              end;
        ilasLeftRight       : begin
                                Height := FArrowHeadSize;
                                Width  := 2*FArrowBodyLength + 2*FArrowHeadSize;
                              end;
        ilasUp, ilasDown    : begin
                                Height := FArrowBodyLength + FArrowHeadSize;
                                Width  := FArrowHeadSize;
                              end;
        ilasUpDown          : begin
                                Width  := FArrowHeadSize;
                                Height := 2*FArrowBodyLength + 2*FArrowHeadSize;
                              end;
      end;
      FDoingAutoSize := False;
      if Assigned(FOnAutoSize) then FOnAutoSize(Self);
  end;
end;
//****************************************************************************************************************************************************
procedure TiLedArrow.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedArrow.SetArrowBodyLength(const Value: Integer);
begin
  if FArrowBodyLength <> Value then
    begin
      FArrowBodyLength := Value;
      BackGroundChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedArrow.SetArrowHeadSize(const Value: Integer);
begin
  if FArrowHeadSize <> Value then
    begin
      FArrowHeadSize := Value;
      BackGroundChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedArrow.SetStyle(const Value: TiLedArrowStyle);
begin
  if FStyle <> Value then
    begin
      FStyle := Value;
      BackGroundChange;
      DoAutoSize;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLedArrow.iPaintTo(Canvas: TCanvas);
var
  DrawRect        : TRect;
  PointArray      : Array [1..10] of TiPointRecord;
  PointCount      : Integer;
  HighLightColor  : TColor;
  ShawdowColor    : TColor;
begin
  with Canvas, DrawRect do
    begin
      DrawBackGround(Canvas, BackGroundColor);
      DrawRect    := Rect(0, 0 ,Width, Height);

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

      if BevelStyle = ibsRaised then
        begin
          HighLightColor := clBtnHighlight;
          ShawdowColor   := clBtnShadow;
        end
      else
        begin
          HighLightColor := clBtnShadow;
          ShawdowColor   := clBtnHighlight;
        end;
      PointCount := 7;

      case FStyle of
        ilasRight     : begin
                          PointArray[1].Point := Point(Right,                                     Top + FArrowHeadSize div 2                 ); PointArray[1].Shadow := False;
                          PointArray[2].Point := Point(Right - FArrowHeadSize,                    Top + FArrowHeadSize                       ); PointArray[2].Shadow := True;
                          PointArray[3].Point := Point(Right - FArrowHeadSize,                    Top + FArrowHeadSize - FArrowHeadSize div 4); PointArray[3].Shadow := False;
                          PointArray[4].Point := Point(Right - FArrowHeadSize - FArrowBodyLength, Top + FArrowHeadSize - FArrowHeadSize div 4); PointArray[4].Shadow := True;
                          PointArray[5].Point := Point(Right - FArrowHeadSize - FArrowBodyLength, Top + FArrowHeadSize div 4                 ); PointArray[5].Shadow := True;
                          PointArray[6].Point := Point(Right - FArrowHeadSize,                    Top + FArrowHeadSize div 4                 ); PointArray[6].Shadow := True;
                          PointArray[7].Point := Point(Right - FArrowHeadSize,                    Top                                        ); PointArray[7].Shadow := True;

                          PointCount := 7;
                        end;
        ilasLeft      : begin
                          PointArray[1].Point := Point(Left,                                     Top + FArrowHeadSize div 2                 ); PointArray[1].Shadow := False;
                          PointArray[2].Point := Point(Left + FArrowHeadSize,                    Top + FArrowHeadSize                       ); PointArray[2].Shadow := False;
                          PointArray[3].Point := Point(Left + FArrowHeadSize,                    Top + FArrowHeadSize - FArrowHeadSize div 4); PointArray[3].Shadow := False;
                          PointArray[4].Point := Point(Left + FArrowHeadSize + FArrowBodyLength, Top + FArrowHeadSize - FArrowHeadSize div 4); PointArray[4].Shadow := False;
                          PointArray[5].Point := Point(Left + FArrowHeadSize + FArrowBodyLength, Top + FArrowHeadSize div 4                 ); PointArray[5].Shadow := True;
                          PointArray[6].Point := Point(Left + FArrowHeadSize,                    Top + FArrowHeadSize div 4                 ); PointArray[6].Shadow := False;
                          PointArray[7].Point := Point(Left + FArrowHeadSize,                    Top                                        ); PointArray[7].Shadow := True;

                          PointCount := 7;
                        end;
        ilasLeftRight : begin
                          PointArray[ 1].Point := Point(Right,                                         Top + FArrowHeadSize div 2                 ); PointArray[ 1].Shadow := False;
                          PointArray[ 2].Point := Point(Right - FArrowHeadSize,                        Top + FArrowHeadSize                       ); PointArray[ 2].Shadow := True;
                          PointArray[ 3].Point := Point(Right - FArrowHeadSize,                        Top + FArrowHeadSize - FArrowHeadSize div 4); PointArray[ 3].Shadow := False;
                          PointArray[ 4].Point := Point(Right - FArrowHeadSize   - 2*FArrowBodyLength, Top + FArrowHeadSize - FArrowHeadSize div 4); PointArray[ 4].Shadow := False;
                          PointArray[ 5].Point := Point(Right - FArrowHeadSize   - 2*FArrowBodyLength, Top + FArrowHeadSize                       ); PointArray[ 5].Shadow := False;
                          PointArray[ 6].Point := Point(Right - 2*FArrowHeadSize - 2*FArrowBodyLength, Top + FArrowHeadSize div 2                 ); PointArray[ 6].Shadow := True;
                          PointArray[ 7].Point := Point(Right - FArrowHeadSize   - 2*FArrowBodyLength, Top                                        ); PointArray[ 7].Shadow := False;
                          PointArray[ 8].Point := Point(Right - FArrowHeadSize   - 2*FArrowBodyLength, Top + FArrowHeadSize div 4                 ); PointArray[ 8].Shadow := True;
                          PointArray[ 9].Point := Point(Right - FArrowHeadSize,                        Top + FArrowHeadSize div 4                 ); PointArray[ 9].Shadow := True;
                          PointArray[10].Point := Point(Right - FArrowHeadSize,                        Top                                        ); PointArray[10].Shadow := True;

                          PointCount := 10;
                        end;
        ilasUp        : begin
                          PointArray[1].Point := Point(Left + FArrowHeadSize div 2,                  Top                                    ); PointArray[1].Shadow := True;
                          PointArray[2].Point := Point(Left + FArrowHeadSize,                        Top + FArrowHeadSize                   ); PointArray[2].Shadow := False;
                          PointArray[3].Point := Point(Left + FArrowHeadSize - FArrowHeadSize div 4, Top + FArrowHeadSize                   ); PointArray[3].Shadow := False;
                          PointArray[4].Point := Point(Left + FArrowHeadSize - FArrowHeadSize div 4, Top + FArrowHeadSize + FArrowBodyLength); PointArray[4].Shadow := False;
                          PointArray[5].Point := Point(Left + FArrowHeadSize div 4,                  Top + FArrowHeadSize + FArrowBodyLength); PointArray[5].Shadow := True;
                          PointArray[6].Point := Point(Left + FArrowHeadSize div 4,                  Top + FArrowHeadSize                   ); PointArray[6].Shadow := False;
                          PointArray[7].Point := Point(Left,                                         Top + FArrowHeadSize                   ); PointArray[7].Shadow := True;

                          PointCount := 7;
                        end;
        ilasDown      : begin
                          PointArray[1].Point := Point(Left + FArrowHeadSize div 2,                  Bottom                                    ); PointArray[1].Shadow := False;
                          PointArray[2].Point := Point(Left + FArrowHeadSize,                        Bottom - FArrowHeadSize                   ); PointArray[2].Shadow := True;
                          PointArray[3].Point := Point(Left + FArrowHeadSize - FArrowHeadSize div 4, Bottom - FArrowHeadSize                   ); PointArray[3].Shadow := False;
                          PointArray[4].Point := Point(Left + FArrowHeadSize - FArrowHeadSize div 4, Bottom - FArrowHeadSize - FArrowBodyLength); PointArray[4].Shadow := True;
                          PointArray[5].Point := Point(Left + FArrowHeadSize div 4,                  Bottom - FArrowHeadSize - FArrowBodyLength); PointArray[5].Shadow := True;
                          PointArray[6].Point := Point(Left + FArrowHeadSize div 4,                  Bottom - FArrowHeadSize                   ); PointArray[6].Shadow := True;
                          PointArray[7].Point := Point(Left,                                         Bottom - FArrowHeadSize                   ); PointArray[7].Shadow := True;

                          PointCount := 7;
                        end;
        ilasUpDown    : begin
                          PointArray[ 1].Point := Point(Left + FArrowHeadSize div 2,                  Top                                        ); PointArray[ 1].Shadow := True;
                          PointArray[ 2].Point := Point(Left + FArrowHeadSize,                        Top + FArrowHeadSize                       ); PointArray[ 2].Shadow := False;
                          PointArray[ 3].Point := Point(Left + FArrowHeadSize - FArrowHeadSize div 4, Top + FArrowHeadSize                       ); PointArray[ 3].Shadow := False;
                          PointArray[ 4].Point := Point(Left + FArrowHeadSize - FArrowHeadSize div 4, Top + FArrowHeadSize   + 2*FArrowBodyLength); PointArray[ 4].Shadow := True;
                          PointArray[ 5].Point := Point(Left + FArrowHeadSize,                        Top + FArrowHeadSize   + 2*FArrowBodyLength); PointArray[ 5].Shadow := False;
                          PointArray[ 6].Point := Point(Left + FArrowHeadSize div 2,                  Top + 2*FArrowHeadSize + 2*FArrowBodyLength); PointArray[ 6].Shadow := True;
                          PointArray[ 7].Point := Point(Left,                                         Top + FArrowHeadSize   + 2*FArrowBodyLength); PointArray[ 7].Shadow := True;
                          PointArray[ 8].Point := Point(Left + FArrowHeadSize div 4,                  Top + FArrowHeadSize   + 2*FArrowBodyLength); PointArray[ 8].Shadow := True;
                          PointArray[ 9].Point := Point(Left + FArrowHeadSize div 4,                  Top + FArrowHeadSize                       ); PointArray[ 9].Shadow := False;
                          PointArray[10].Point := Point(Left,                                         Top + FArrowHeadSize                       ); PointArray[10].Shadow := True;

                          PointCount := 10;
                       end;
      end;

      if PointCount = 7 then
        begin
          Polygon([PointArray[1].Point,
                   PointArray[2].Point,
                   PointArray[3].Point,
                   PointArray[4].Point,
                   PointArray[5].Point,
                   PointArray[6].Point,
                   PointArray[7].Point]);

          if (BevelStyle <> ibsnone) then
            begin
              if PointArray[1].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[1].Point, PointArray[2].Point]);
              if PointArray[2].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[2].Point, PointArray[3].Point]);
              if PointArray[3].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[3].Point, PointArray[4].Point]);
              if PointArray[4].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[4].Point, PointArray[5].Point]);
              if PointArray[5].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[5].Point, PointArray[6].Point]);
              if PointArray[6].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[6].Point, PointArray[7].Point]);
              if PointArray[7].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[7].Point, PointArray[1].Point]);
            end;
        end
      else
        begin
          Polygon([PointArray[1].Point,
                   PointArray[2].Point,
                   PointArray[3].Point,
                   PointArray[4].Point,
                   PointArray[5].Point,
                   PointArray[6].Point,
                   PointArray[7].Point,
                   PointArray[8].Point,
                   PointArray[9].Point,
                   PointArray[10].Point]);

          if (BevelStyle <> ibsnone) then
            begin
              if PointArray[ 1].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 1].Point, PointArray[ 2].Point]);
              if PointArray[ 2].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 2].Point, PointArray[ 3].Point]);
              if PointArray[ 3].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 3].Point, PointArray[ 4].Point]);
              if PointArray[ 4].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 4].Point, PointArray[ 5].Point]);
              if PointArray[ 5].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 5].Point, PointArray[ 6].Point]);
              if PointArray[ 6].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 6].Point, PointArray[ 7].Point]);
              if PointArray[ 7].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 7].Point, PointArray[ 8].Point]);
              if PointArray[ 8].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 8].Point, PointArray[ 9].Point]);
              if PointArray[ 9].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[ 9].Point, PointArray[10].Point]);
              if PointArray[10].Shadow then Pen.Color := HighLightColor else Pen.Color := ShawdowColor; PolyLine([PointArray[10].Point, PointArray[ 1].Point]);
            end;
        end;

    end;
end;
//****************************************************************************************************************************************************
end.
