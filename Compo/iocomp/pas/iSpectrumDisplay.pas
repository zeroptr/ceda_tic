{*******************************************************}
{                                                       }
{       TiSpectrumDisplay Component                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSpectrumDisplay;{$endif}
{$ifdef iCLX}unit QiSpectrumDisplay;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iCustomComponent, iThreadTimers, iOPCItem;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiCustomComponent, QiThreadTimers;         {$ENDIF}

type
  TiSpectrumData = record
    Value          : Double;
    Peak           : Double;
    PeakUpdateTime : TDateTime;
    Color          : TColor;
  end;

  TiSpectrumDisplay = class(TiCustomComponent)
  private
    FData              : array[0..1023] of TiSpectrumData;

    FDecayTimer        : TiThreadTimers;

    FBarWidth          : Integer;
    FBarSpacing        : Integer;
    FBarHeight         : Integer;
    FBarBottom         : Integer;
    FStartLeft         : Integer;

    FAutoSize          : Boolean;
    FOnAutoSize        : TNotifyEvent;
    FDoingAutoSize     : Boolean;
    FBarCount          : Integer;
    FDecayEnabled      : Boolean;
    FDecayInterval     : Integer;
    FDecayInitialDelay : Integer;
    FBarColor          : TColor;
    FOuterMarginLeft   : Integer;
    FOuterMarginRight  : Integer;
    FOuterMarginBottom : Integer;
    FOuterMarginTop    : Integer;
    FPeakLineColor     : TColor;
    FPeakShow          : Boolean;
    FScaleMax          : Double;
    FScaleMin          : Double;
  protected
    procedure SetBarCount         (const Value: Integer);
    procedure iSetAutoSize        (const Value: Boolean);
    procedure SetDecayInitialDelay(const Value: Integer);
    procedure SetDecayEnabled     (const Value: Boolean);
    procedure SetDecayInterval    (const Value: Integer);
    procedure SetBarSpacing       (const Value: Integer);
    procedure SetBarWidth         (const Value: Integer);
    procedure SetBarColor         (const Value: TColor);
    procedure SetOuterMarginBottom(const Value: Integer);
    procedure SetOuterMarginLeft  (const Value: Integer);
    procedure SetOuterMarginRight (const Value: Integer);
    procedure SetOuterMarginTop   (const Value: Integer);
    procedure SetPeakLineColor    (const Value: TColor);
    procedure SetPeakShow         (const Value: Boolean);
    procedure SetScaleMax         (const Value: Double);
    procedure SetScaleMin         (const Value: Double);

    function  GetBarValue (Index: Integer): Double;
    function  GetBarXColor(Index: Integer): TColor;

    procedure SetBarValue (Index: Integer; const Value: Double);
    procedure SetBarXColor(Index: Integer; const Value: TColor);

    procedure CalcRects;
    procedure DecayTimerEvent(Sender : TObject);

    procedure SetBorderStyle(const Value: TiBevelStyle); override;

    property  OnAutoSize : TNotifyEvent read FOnAutoSize write FOnAutoSize;

    procedure DoAutoSize;
    procedure iPaintTo(Canvas: TCanvas);     override;
    procedure Loaded;                        override;

    {$ifdef iVCL}
    procedure UpdateOPCSpecialList;                                                  override;
    function  OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean; override;
    {$endif}
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;

    procedure Clear;

    property BarValue [Index : Integer]  : Double  read GetBarValue        write SetBarValue;
    property BarXColor[Index : Integer]  : TColor  read GetBarXColor       write SetBarXColor;
  published
    property AutoSize                    : Boolean read FAutoSize          write iSetAutoSize         default True;
    property OuterMarginLeft             : Integer read FOuterMarginLeft   write SetOuterMarginLeft   default 5;
    property OuterMarginTop              : Integer read FOuterMarginTop    write SetOuterMarginTop    default 0;
    property OuterMarginRight            : Integer read FOuterMarginRight  write SetOuterMarginRight  default 5;
    property OuterMarginBottom           : Integer read FOuterMarginBottom write SetOuterMarginBottom default 0;

    property DecayEnabled                : Boolean read FDecayEnabled      write SetDecayEnabled      default True;
    property DecayInterval               : Integer read FDecayInterval     write SetDecayInterval     default 40;
    property DecayInitialDelay           : Integer read FDecayInitialDelay write SetDecayInitialDelay default 750;

    property BarCount                    : Integer read FBarCount          write SetBarCount          default 32;
    property BarWidth                    : Integer read FBarWidth          write SetBarWidth          default 6;
    property BarSpacing                  : Integer read FBarSpacing        write SetBarSpacing        default 1;
    property BarColor                    : TColor  read FBarColor          write SetBarColor          default $0000B000;

    property PeakShow                    : Boolean read FPeakShow          write SetPeakShow          default True;
    property PeakLineColor               : TColor  read FPeakLineColor     write SetPeakLineColor     default clWhite;

    property ScaleMin                    : Double  read FScaleMin          write SetScaleMin;
    property ScaleMax                    : Double  read FScaleMax          write SetScaleMax;

    property BorderStyle      default ibsLowered;
    property BackGroundColor  default clBlack;
    property Transparent;
    property Width            default 238;
    property Height           default 125;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiSpectrumDisplay.Create(AOwner: TComponent);
var
  x : Integer;
begin
  inherited Create(AOwner);

  Width           := 238;
  Height          := 125;
  BorderStyle     := ibsLowered;
  BackGroundColor := clBlack;

  FAutoSize          := True;
  
  FOuterMarginLeft   := 5;
  FOuterMarginRight  := 5;

  FDecayEnabled      := True;
  FDecayInitialDelay := 750;
  FDecayInterval     := 40;

  FBarCount          := 32;
  FBarSpacing        := 1;
  FBarWidth          := 6;
  FBarColor          := $0000B000;

  FPeakShow          := True;
  FPeakLineColor     := clWhite;

  FScaleMax          := 100;

  for x := 0  to 1023 do
    begin
      FData[x].Value := Random(90) + 10;
      FData[x].Color := FBarColor;
    end;

  FDecayTimer           := TiThreadTimers.Create(Self);
  FDecayTimer.Interval1 := 40;
  FDecayTimer.OnTimer1  := DecayTimerEvent;
end;
//****************************************************************************************************************************************************
destructor TiSpectrumDisplay.Destroy;
begin
  FDecayTimer.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.Loaded;
begin
  inherited;
  if FDecayEnabled and not(csDesigning in ComponentState) then
    begin
      FDecayTimer.Enabled1 := True;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.Clear;
var
  x : Integer;
begin
  for x := 0 to FBarCount - 1 do
    begin
      FData[x].Value := 0;
      FData[x].Peak  := 0;
      FData[x].PeakUpdateTime := Now;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetBorderStyle(const Value: TiBevelStyle);
begin
  inherited;
  DoAutoSize;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetDecayInitialDelay(const Value:Integer);begin SetIntegerProperty(Value,FDecayInitialDelay,irtInvalidate);end;
procedure TiSpectrumDisplay.SetPeakLineColor    (const Value:TColor );begin SetColorProperty  (Value,FPeakLineColor,    irtInvalidate);end;
procedure TiSpectrumDisplay.SetPeakShow         (const Value:Boolean);begin SetBooleanProperty(Value,FPeakShow,         irtInvalidate);end;
procedure TiSpectrumDisplay.SetScaleMax         (const Value:Double );begin SetDoubleProperty(Value, FScaleMax,         irtInvalidate);end;
procedure TiSpectrumDisplay.SetScaleMin         (const Value:Double );begin SetDoubleProperty(Value, FScaleMin,         irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetBarColor(const Value: TColor);
var
  x : Integer;
begin
  if FBarColor <> Value then
   begin
     FBarColor := Value;
     for x := 0 to 1023 do
       FData[x].Color := FBarColor;
     InvalidateChange;
   end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetDecayEnabled(const Value: Boolean);
begin
  if FDecayEnabled <> Value then
    begin
      FDecayEnabled := Value;

      if not(csDesigning in ComponentState) then
        begin
          FDecayTimer.Enabled1 := Value;
        end
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetDecayInterval(const Value:Integer);
begin
  if FDecayInterval <> Value then
    begin
      FDecayInterval := Value;
      FDecayTimer.Interval1 := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetOuterMarginBottom(const Value: Integer);
begin
  if FOuterMarginBottom <> Value then
    begin
      FOuterMarginBottom := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetOuterMarginLeft(const Value: Integer);
begin
  if FOuterMarginLeft <> Value then
    begin
      FOuterMarginLeft := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetOuterMarginRight(const Value: Integer);
begin
  if FOuterMarginRight <> Value then
    begin
      FOuterMarginRight := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetOuterMarginTop(const Value: Integer);
begin
  if FOuterMarginTop <> Value then
    begin
      FOuterMarginTop := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetBarCount(const Value: Integer);
begin
  if (Value < 1) or (Value > 1024) then raise Exception.Create('Bar Count must be between 1 and 1024');
  if FBarCount <> Value then
    begin
      FBarCount := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetBarSpacing(const Value: Integer);
begin
  if FBarSpacing <> Value then
    begin
      FBarSpacing := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetBarWidth(const Value: Integer);
begin
  if FBarWidth <> Value then
    begin
      FBarWidth := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.iSetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> Value then
    begin
      FAutoSize := Value;
      DoAutoSize;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.DoAutoSize;
begin
  if FDoingAutoSize              then Exit;
  if csLoading in ComponentState then Exit;

  if FAutoSize then
    begin
      FDoingAutoSize := True;
      try
        with Canvas do
          begin
            Width := FOuterMarginLeft + FOuterMarginRight + FBarCount*(FBarWidth) + (FBarCount-1)*FBarSpacing + 2*BorderMargin;
          end;
        if Assigned(FOnAutoSize) then FOnAutoSize(Self);
      finally
        FDoingAutoSize := False;
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiSpectrumDisplay.GetBarValue(Index: Integer): Double;
begin
  Result := FData[Index].Value;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetBarValue(Index: Integer; const Value: Double);
begin
  if (Index < 0) or (Index > FBarCount - 1) then raise Exception.Create('Index out of Bounds');
  FData[Index].Value := Value;
  if Value > FData[Index].Peak then
    begin
      FData[Index].Peak           := Value;
      FData[Index].PeakUpdateTime := Now;
    end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiSpectrumDisplay.GetBarXColor(Index: Integer): TColor;
begin
  if (Index < 0) or (Index > FBarCount - 1) then raise Exception.Create('Index out of Bounds');
  Result := FData[Index].Color;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.SetBarXColor(Index: Integer; const Value: TColor);
begin
  if (Index < 0) or (Index > FBarCount - 1) then raise Exception.Create('Index out of Bounds');
  FData[Index].Color := Value;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.DecayTimerEvent(Sender: TObject);
var
  x : Integer;
begin
  for x := 0 to FBarCount - 1 do
    begin
      if FData[x].Peak > FData[x].Value then
        if Now > (FData[x].PeakUpdateTime + FDecayInitialDelay/(24*60*60*1000)) then
          begin
            FData[x].Peak := FData[x].Peak - (FScaleMax - FScaleMin)/100;
            if FData[x].Peak < FData[x].Value then FData[x].Peak := FData[x].Value;
            InvalidateChange;
          end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.CalcRects;
begin
//  FBarWidth  := (Width - 2*BorderMargin - FOuterMarginLeft - FOuterMarginRight) div FBarCount - FBarSpacing;
  FStartLeft := (Width - 2*BorderMargin - FOuterMarginLeft - FOuterMarginRight - FBarCount*(FBarWidth) - (FBarCount-1)*FBarSpacing) div 2 + FOuterMarginLeft + BorderMargin;
  FBarBottom := Height - FOuterMarginBottom - BorderMargin;
  FBarHeight := Height - FOuterMarginTop - FOuterMarginBottom - 2*BorderMargin;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.iPaintTo(Canvas: TCanvas);
var
  x      : Integer;
  ALeft  : Integer;
  ATop   : Integer;
  AValue : Double;
begin
  with Canvas do
    begin
      DrawBackGround(Canvas, BackGroundColor);

      if (FScaleMax - FScaleMin) = 0 then Exit;

      CalcRects;

      ALeft := FStartLeft;

      for x := 0 to FBarCount - 1 do
        begin
          Brush.Color := GetBarXColor(x);
          Pen.Color   := GetBarXColor(x);

          AValue := FData[x].Value;

          if AValue > FScaleMax then AValue := FScaleMax;
          if AValue < FScaleMin then AValue := FScaleMin;

          ATop := FBarBottom - Round(FBarHeight * (AValue - FScaleMin)/(FScaleMax - FScaleMin));
          if FBarWidth = 1 then
            begin
              Polyline([Point(ALeft, ATop), Point(ALeft, FBarBottom)]);
            end
          else
            begin
              Rectangle(ALeft, ATop, ALeft + FBarWidth, FBarBottom);
            end;
          ALeft := ALeft + FBarWidth + FBarSpacing;
        end;

      if FPeakShow then
        begin
          ALeft     := FStartLeft;
          Pen.Color := FPeakLineColor;

          for x := 0 to FBarCount - 1 do
            begin
              if FData[x].Peak > FData[x].Value then
                begin
                  AValue := FData[x].Peak;

                  if AValue > FScaleMax then AValue := FScaleMax;
                  if AValue < FScaleMin then AValue := FScaleMin;

                  ATop := FBarBottom - Round(FBarHeight * (AValue - FScaleMin)/(FScaleMax - FScaleMin));

                  PolyLine([Point(ALeft, ATop), Point(ALeft + FBarWidth, ATop)]);
                end;
              ALeft := ALeft + FBarWidth + FBarSpacing;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
function TiSpectrumDisplay.OPCNewDataSpecial(PropertyName: String; NewData: OleVariant): Boolean;
var
  x : Integer;
begin
  Result := inherited OPCNewDataSpecial(PropertyName, NewData);

  for x := 0 to FBarCount-1 do
    if UpperCase('Bar(' + IntToStr(x) + ').Value') = UpperCase(PropertyName) then
      begin
        Result := True;
        BarValue[x] := NewData;
      end;
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplay.UpdateOPCSpecialList;
var
  x : Integer;
begin
  if not Assigned(OPCSpecialList) then Exit;
  OPCSpecialList.Clear;
  for x := 0 to FBarCount-1 do
    OPCSpecialList.Add('Bar(' + IntToStr(x) + ').Value');
end;
{$endif}
//****************************************************************************************************************************************************
end.


