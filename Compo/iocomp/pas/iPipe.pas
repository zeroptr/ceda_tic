{*******************************************************}
{                                                       }
{       TiPipe Component                                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPipe;{$endif}
{$ifdef iCLX}unit QiPipe;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent;{$ENDIF}

type
  TiPipeFlowIndicatorStyle = (ipfisCircle, ipfisBox, ipfisTriangle);

  TiPipe = class(TiCustomComponent)
  private
    FFlowOn                    : Boolean;
    FFlowInterval              : Integer;
    FFlowIndicatorHideWhenOff  : Boolean;
    FFlowReverse               : Boolean;
    FFlowIndicatorSize         : Integer;
    FFlowIndicatorSpacing      : Integer;
    FFlowIndicatorColor        : TColor;
    FFlowIndicatorUseTubeColor : Boolean;
    FTubeColor                 : TColor;

    FFlowStep                  : Integer;
    FHorizontal                : Boolean;
    FTubeHighlightColor        : TColor;
    FFLowIndicatorHalfSize     : Integer;
    FFlowIndicatorStyle        : TiPipeFlowIndicatorStyle;
  protected
    procedure SetFlowOn                   (const Value: Boolean);
    procedure SetFlowInterval             (const Value: Integer);
    procedure SetFlowIndicatorHideWhenOff (const Value: Boolean);
    procedure SetFlowReverse              (const Value: Boolean);
    procedure SetFlowIndicatorColor       (const Value: TColor);
    procedure SetFlowIndicatorSize        (const Value: Integer);
    procedure SetFlowIndicatorSpacing     (const Value: Integer);
    procedure SetFlowIndicatorUseTubeColor(const Value: Boolean);
    procedure SetTubeColor                (const Value: TColor);
    procedure SetFlowIndicatorStyle       (const Value: TiPipeFlowIndicatorStyle);

    procedure iPaintTo(Canvas: TCanvas);                          override;

    procedure CalcRects(Canvas: TCanvas);

    procedure DrawTube(Canvas: TCanvas);
    procedure DrawFlow(Canvas: TCanvas);

    procedure TimerEvent     (Sender: TObject);
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
  published
    property FlowInterval              : Integer                  read FFlowInterval              write SetFlowInterval    default 1000;
    property FlowOn                    : Boolean                  read FFlowOn                    write SetFlowOn          default False;

    property FlowReverse               : Boolean                  read FFlowReverse               write SetFlowReverse;

    property FlowIndicatorStyle        : TiPipeFlowIndicatorStyle read FFlowIndicatorStyle        write SetFlowIndicatorStyle;
    property FlowIndicatorSize         : Integer                  read FFlowIndicatorSize         write SetFlowIndicatorSize;
    property FlowIndicatorSpacing      : Integer                  read FFlowIndicatorSpacing      write SetFlowIndicatorSpacing;
    property FlowIndicatorColor        : TColor                   read FFlowIndicatorColor        write SetFlowIndicatorColor;
    property FlowIndicatorUseTubeColor : Boolean                  read FFlowIndicatorUseTubeColor write SetFlowIndicatorUseTubeColor;
    property FlowIndicatorHideWhenOff  : Boolean                  read FFlowIndicatorHideWhenOff  write SetFlowIndicatorHideWhenOff;

    property TubeColor                 : TColor                   read FTubeColor                 write SetTubeColor;

    property Width  default 300;
    property Height default 17;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPipe.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width  := 300;
  Height := 17;

  FFlowInterval              := 50;
  FFlowIndicatorSize         := 6;
  FFlowIndicatorSpacing      := 8;
  FFlowIndicatorColor        := clRed;
  FFlowIndicatorUseTubeColor := True;
  FFlowIndicatorHideWhenOff  := True;
  FTubeColor                 := $00888800;

  OnInternalTimer            := TimerEvent;
end;
//****************************************************************************************************************************************************
destructor TiPipe.Destroy;
begin
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPipe.SetFlowIndicatorHideWhenOff (const Value:Boolean);begin SetBooleanProperty(Value, FFlowIndicatorHideWhenOff, irtInvalidate);end;
procedure TiPipe.SetFlowReverse              (const Value:Boolean);begin SetBooleanProperty(Value, FFlowReverse,              irtNone      );end;
procedure TiPipe.SetFlowIndicatorColor       (const Value:TColor );begin SetColorProperty  (Value, FFlowIndicatorColor,       irtInvalidate);end;
procedure TiPipe.SetFlowIndicatorUseTubeColor(const Value:Boolean);begin SetBooleanProperty(Value, FFlowIndicatorUseTubeColor,irtInvalidate);end;
procedure TiPipe.SetTubeColor                (const Value:TColor );begin SetColorProperty  (Value, FTubeColor,                irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiPipe.SetFlowIndicatorSize(const Value: Integer);
begin
  if Value < 1 then Exit;
  SetIntegerProperty(Value, FFlowIndicatorSize, irtInvalidate);
end;
//****************************************************************************************************************************************************
procedure TiPipe.SetFlowIndicatorSpacing(const Value: Integer);
begin
  if Value < 0 then Exit;
  SetIntegerProperty(Value, FFlowIndicatorSpacing, irtInvalidate);
end;
//****************************************************************************************************************************************************
procedure TiPipe.SetFlowIndicatorStyle(const Value: TiPipeFlowIndicatorStyle);
begin
  if FFlowIndicatorStyle <> Value then
    begin
      FFlowIndicatorStyle := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPipe.SetFlowInterval(const Value:Integer);
begin
  if FFlowInterval <> Value then
    begin
      FFlowInterval := Value;

      if TimerRunning then
        begin
          TimerStop;
          TimerStart(FFlowInterval, FFlowInterval);
        end;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPipe.SetFlowOn(const Value: Boolean);
begin
  if FFlowOn <> Value then
    begin
      FFlowOn := Value;
      if FFlowOn then
        begin
          if not GetIsDesigning then
            TimerStart(FFlowInterval, FFlowInterval);
        end
      else
        begin
          if TimerRunning then TimerStop;
        end;
    end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPipe.TimerEvent(Sender: TObject);
begin
  if FFlowReverse then
    begin
      Dec(FFlowStep);
      if FFlowStep < 0 then FFlowStep := 3;
    end
  else
    begin
      Inc(FFlowStep);
      if FFlowStep > 3 then FFlowStep := 0;
    end;

  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPipe.iPaintTo(Canvas: TCanvas);
begin
  DrawBackGround(Canvas, BackGroundColor);

  CalcRects(Canvas);
  DrawTube(Canvas);
  DrawFlow(Canvas);
  DrawBorder(Canvas);
end;
//****************************************************************************************************************************************************
procedure TiPipe.CalcRects(Canvas: TCanvas);
var
  ARed   : Integer;
  AGreen : Integer;
  ABlue  : Integer;
begin
  ARed   := (FTubeColor and $0000FF);
  AGreen := (FTubeColor and $00FF00) shr 8;
  ABlue  := (FTubeColor and $FF0000) shr 16;

  ARed   := ARed   + 128;
  AGreen := AGreen + 128;
  ABlue  := ABlue  + 128;

  if ARed   > 255 then ARed   := 255;
  if AGreen > 255 then AGreen := 255;
  if ABlue  > 255 then ABlue  := 255;

  FTubeHighlightColor := ARed + AGreen shl 8 + ABlue shl 16;

  FHorizontal := Width > Height;

  FFLowIndicatorHalfSize := FFlowIndicatorSize div 2;
end;
//****************************************************************************************************************************************************
procedure TiPipe.DrawTube(Canvas: TCanvas);
begin
  if FHorizontal then
    begin
      DrawGradientDirection(Canvas, Rect(0,            0, Width, Height div 2), ifdTopBottom, FTubeColor,          FTubeHighlightColor);
      DrawGradientDirection(Canvas, Rect(0, Height div 2, Width, Height      ), ifdTopBottom, FTubeHighlightColor, FTubeColor);
    end
  else
    begin
      DrawGradientDirection(Canvas, Rect(0,           0, Width div 2, Height), ifdLeftRight, FTubeColor,          FTubeHighlightColor);
      DrawGradientDirection(Canvas, Rect(Width div 2, 0, Width,       Height), ifdLeftRight, FTubeHighlightColor, FTubeColor);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPipe.DrawFlow(Canvas: TCanvas);
var
  CurrentPos : Integer;
  ARect      : TRect;
begin
  if not FFlowOn and FFlowIndicatorHideWhenOff then Exit;
  with Canvas do
    begin
      CurrentPos := - FFlowIndicatorSize;

      CurrentPos := CurrentPos + Round(FFlowStep/4 * (FFlowIndicatorSize + FFlowIndicatorSpacing));

      if FFlowIndicatorUseTubeColor then
        begin
          Brush.Color := FTubeColor;
          Pen.Color   := FTubeColor;
        end
      else
        begin
          Brush.Color := FFlowIndicatorColor;
          Pen.Color   := FFlowIndicatorColor;
        end;

      Brush.Style := bsSolid;

      while True do
        begin
          if FHorizontal then
            begin
              ARect := Rect(CurrentPos,                              Height div 2 - FFLowIndicatorHalfSize,
                            CurrentPos + FFLowIndicatorHalfSize * 2, Height div 2 + FFLowIndicatorHalfSize);

              case FFlowIndicatorStyle of
                ipfisCircle   : Ellipse  (ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                ipfisBox      : Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                ipfisTriangle : if FFlowReverse then
                                  iDrawTriangle(Canvas, ARect, idLeft)
                                else
                                  iDrawTriangle(Canvas, ARect, idRight);
              end;

              CurrentPos := CurrentPos + FFlowIndicatorSize + FFlowIndicatorSpacing;
              if CurrentPos > Width then Break;
            end
          else
            begin
              ARect := Rect(Width div 2 - FFLowIndicatorHalfSize, Height - CurrentPos - FFLowIndicatorHalfSize * 2,
                            Width div 2 + FFLowIndicatorHalfSize, Height - CurrentPos);

              case FFlowIndicatorStyle of
                ipfisCircle   : Ellipse  (ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                ipfisBox      : Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
                ipfisTriangle : if FFlowReverse then
                                  iDrawTriangle(Canvas, ARect, idDown)
                                else
                                  iDrawTriangle(Canvas, ARect, idUp);
              end;


              CurrentPos := CurrentPos + FFlowIndicatorSize + FFlowIndicatorSpacing;
              if CurrentPos > Height then Break;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
end.
