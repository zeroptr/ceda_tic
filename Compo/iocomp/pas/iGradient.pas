{*******************************************************}
{                                                       }
{       TiGradient Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iGradient;{$endif}
{$ifdef iCLX}unit QiGradient;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiGradient = class(TiCustomComponent)
  private
    FReDrawGradient : Boolean;
    FDirection      : TiFillDirection;
    FColorStart     : TColor;
    FColorStop      : TColor;
  protected
    procedure iPaintTo(Canvas: TCanvas);                          override;
    procedure SetDirection (Value: TiFillDirection);
    procedure SetColorStart(Value: TColor);
    procedure SetColorStop (Value: TColor);
    procedure GradientBitmapChange;
  public
    constructor Create(AOwner: TComponent);                       override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure   PaintToCanvas(ACanvas: TCanvas; ARect: TRect; Direction: TiFillDirection; ColorStart, ColorStop: TColor);
  published
    property Direction  : TiFillDirection read FDirection  write SetDirection  default ifdTopBottom;
    property ColorStart : TColor          read FColorStart write SetColorStart default clBlue;
    property ColorStop  : TColor          read FColorStop  write SetColorStop  default clBlack;
    property Align;
    property CachedDrawing;
    property Width  default 96;
    property Height default 96;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiGradient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csOpaque, csReplicatable, csAcceptsControls];

  Width        := 96;
  Height       := 96;

  FColorStart  := clBlue;
  FColorStop   := clBlack;
end;
//****************************************************************************************************************************************************
procedure TiGradient.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  FReDrawGradient := True;
end;
//****************************************************************************************************************************************************
procedure TiGradient.SetDirection(Value: TiFillDirection);
begin
  if FDirection <> Value then
    begin
      FDirection := Value;
      GradientBitmapChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGradient.SetColorStart(Value: TColor);
begin
  if FColorStart <> Value then
    begin
      FColorStart := Value;
      GradientBitmapChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGradient.SetColorStop(Value: TColor);
begin
  if FColorStop <> Value then
    begin
      FColorStop := Value;
      GradientBitmapChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGradient.GradientBitmapChange;
begin
  FReDrawGradient := True;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiGradient.PaintToCanvas(ACanvas: TCanvas; ARect: TRect; Direction: TiFillDirection; ColorStart, ColorStop: TColor);
var
  Red, Green, Blue : Integer;
  StartRed         : Integer;
  StartGreen       : Integer;
  StartBlue        : Integer;
  StopRed          : Integer;
  StopGreen        : Integer;
  StopBlue         : Integer;
  x                : Integer;
  MaxLines         : Integer;
  NumOfLines       : Integer;
  ReverseColors    : Boolean;
begin
  with ACanvas, ARect do
    begin
      if      Right = Bottom then MaxLines := Right
      else if Right > Bottom then MaxLines := Right
      else                        MaxLines := Bottom;

      StartRed   := (ColorStart and $0000FF);
      StartGreen := (ColorStart and $00FF00) shr 8;
      StartBlue  := (ColorStart and $FF0000) shr 16;

      StopRed   := (ColorStop and $0000FF);
      StopGreen := (ColorStop and $00FF00) shr 8;
      StopBlue  := (ColorStop and $FF0000) shr 16;

      Brush.Style := bsClear;

      case Direction of
        ifdTopBottom          : begin NumOfLines := (Bottom   - 1);      ReverseColors := False; Pen.Width := 1; end;
        ifdBottomTop          : begin NumOfLines := (Bottom   - 1);      ReverseColors := True;  Pen.Width := 1; end;
        ifdLeftRight          : begin NumOfLines := (Right    - 1);      ReverseColors := False; Pen.Width := 1; end;
        ifdRightLeft          : begin NumOfLines := (Right    - 1);      ReverseColors := True;  Pen.Width := 1; end;
        ifdTopLeftBottomRight : begin NumOfLines := (MaxLines - 1)*2;    ReverseColors := False; Pen.Width := 1; end;
        ifdBottomRightTopLeft : begin NumOfLines := (MaxLines - 1)*2;    ReverseColors := True;  Pen.Width := 1; end;
        ifdBottomLeftTopRight : begin NumOfLines := (MaxLines - 1)*2;    ReverseColors := False; Pen.Width := 1; end;
        ifdTopRightBottomLeft : begin NumOfLines := (MaxLines - 1)*2;    ReverseColors := True;  Pen.Width := 1; end;
        ifdRectangleOut       : begin NumOfLines := (MaxLines - 1)div 3; ReverseColors := False; Pen.Width := 2; end;
        ifdRectangleIn        : begin NumOfLines := (MaxLines - 1)div 3; ReverseColors := True;  Pen.Width := 2; end;
        ifdCircleOut          : begin NumOfLines := (MaxLines - 1)div 8; ReverseColors := False; Pen.Width := 16;end;
        ifdCircleIn           : begin NumOfLines := (MaxLines - 1)div 8; ReverseColors := True;  Pen.Width := 16;end;
        else                    begin NumOfLines := 0;                   ReverseColors := False; Pen.Width := 1; end;
      end;

      for x := 0 to NumOfLines do
        begin
          if ReverseColors then
            begin
              Red   := Round((x/NumOfLines*StartRed   + (NumOfLines-x)/NumOfLines*StopRed  ));
              Green := Round((x/NumOfLines*StartGreen + (NumOfLines-x)/NumOfLines*StopGreen));
              Blue  := Round((x/NumOfLines*StartBlue  + (NumOfLines-x)/NumOfLines*StopBlue ));
            end
          else
            begin
              Red   := Round((x/NumOfLines*StopRed    + (NumOfLines-x)/NumOfLines*StartRed  ));
              Green := Round((x/NumOfLines*StopGreen  + (NumOfLines-x)/NumOfLines*StartGreen));
              Blue  := Round((x/NumOfLines*StopBlue   + (NumOfLines-x)/NumOfLines*StartBlue ));
            end;

          Pen.Color := Red + Green shl 8 + Blue shl 16;

          case Direction of
            ifdBottomTop,
            ifdTopBottom           : Polyline([Point(Left   , x      ),
                                               Point(Right  , x      )]);

            ifdRightLeft,
            ifdLeftRight           : Polyline([Point(x      , Top    ),
                                               Point(x      , Bottom)]);

            ifdTopLeftBottomRight,
            ifdBottomRightTopLeft  : Polyline([Point(Round(x/NumOfLines*2*(Right-1))-1, 0),
                                               Point(-1, Round(x/NumOfLines*2*(Bottom-1)))]);

            ifdBottomLeftTopRight,
            ifdTopRightBottomLeft  : Polyline([Point(0, Bottom-1-Round(x/NumOfLines*2*(Bottom-1))),
                                               Point(Round(x/NumOfLines*2*(Right-1)), Bottom-1)]);

            ifdRectangleOut,
            ifdRectangleIn         : Rectangle(Round((Right-1)/2-x/NumOfLines*(Right-1)/2),Round((Bottom-1)/2+x/NumOfLines*(Bottom-1)/2),
                                               Round((Right-1)/2+x/NumOfLines*(Right-1)/2),Round((Bottom-1)/2-x/NumOfLines*(Bottom-1)/2));

            ifdCircleOut,
            ifdCircleIn            : Ellipse  (Round((Right-1)/2-x/NumOfLines*1.414*(Right-1)/2),Round((Bottom-1)/2+x/NumOfLines*1.414*(Bottom-1)/2),
                                               Round((Right-1)/2+x/NumOfLines*1.414*(Right-1)/2),Round((Bottom-1)/2-x/NumOfLines*1.414*(Bottom-1)/2));
          end;
        end;
      //Kylix TODO
      {$ifndef iCLX}
      if Direction = ifdRectangleOut then Pixels[Width div 2 - 1, Height div 2 - 1] := ColorStart;
      if Direction = ifdRectangleIn  then Pixels[Width div 2 - 1, Height div 2 - 1] := ColorStop;
      {$else}
      {$endif}
    end;

  FRedrawGradient := False;
end;
//****************************************************************************************************************************************************
procedure TiGradient.iPaintTo(Canvas: TCanvas);
begin
  if CachedDrawing then
    begin
      CreateBackGroundBitmap;
      if FReDrawGradient then PaintToCanvas(BackGroundBitmap.Canvas, Rect(0, 0 ,Width, Height), FDirection, FColorStart, FColorStop);
      TransferBackGround(Canvas);
    end
  else PaintToCanvas(Canvas, Rect(0, 0 ,Width, Height), FDirection, FColorStart, FColorStop);
end;
//****************************************************************************************************************************************************
end.
