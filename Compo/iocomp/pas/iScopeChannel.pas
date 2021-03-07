{*******************************************************}
{                                                       }
{       TiScopeChannel Object                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopeChannel;{$endif}
{$ifdef iCLX}unit QiScopeChannel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions, {$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions,{$ENDIF}
  {$IFDEF iVCL} iPlot,  iPlotChannel,  iPlotAxis,  iPlotAnnotation,  iPlotLimit,  iPlotDataCompactIntervalList,  iPlotDataScopeList; {$ENDIF}
  {$IFDEF iCLX}QiPlot, QiPlotChannel, QiPlotAxis, QiPlotAnnotation, QiPlotLimit, QiPlotDataCompactIntervalList, QiPlotDataScopeList;{$ENDIF}

type
  TiScopeChannelCoupling = (isccDC, isccAC, isccGround);

  TiScopeChannel = class(TPersistent)
  private
    FScope            : TWinControl;
    FSettingPosition  : Boolean;

    FVoltsPerDivision : Double;
    FPosition         : Double;
    FTitleText        : String;
    FColor            : TColor;
    FTraceLineWidth   : Integer;
    FTraceVisible     : Boolean;

    FCoupling         : TiScopeChannelCoupling;
    FRawData          : TiPlotDataScopeList;
    FYAxis            : TiPlotYAxis;
    FChannel          : TiPlotChannel;
    FCapacitor        : Double;
    FOnChange         : TNotifyEvent;

    FScalerMultiplier : Double;
    FScalerOffset     : Double;
    FAnnotation       : TiPlotAnnotation;
    FRefLine          : TiPlotLimit;
    FRefLineShow      : Boolean;
  protected
    procedure SetCoupling        (const Value: TiScopeChannelCoupling);
    procedure SetPosition        (const Value: Double);
    procedure SetVoltsPerDivision(const Value: Double);
    procedure SetYAxis           (const Value: TiPlotYAxis);
    procedure SetChannel         (const Value: TiPlotChannel);
    procedure SetAnnotation      (const Value: TiPlotAnnotation);
    procedure SetRefLine         (const Value: TiPlotLimit);

    procedure SetTitleText       (const Value: String);
    procedure SetColor           (const Value: TColor);
    procedure SetTraceLineWidth  (const Value: Integer);
    procedure SetTraceVisible    (const Value: Boolean);
    procedure SetScalerMultiplier(const Value: Double);
    procedure SetScalerOffset    (const Value: Double);
    procedure SetRefLineShow     (const Value: Boolean);
    procedure SetPositionVoltage (const Value: Double);

    function GetTitleText      : String;
    function GetColor          : TColor;
    function GetTraceLineWidth : Integer;
    function GetTraceVisible   : Boolean;
    function GetPositionVoltage: Double;
    function GetBufferCount    : Integer;

    function GetYDisplay(Index: Integer): Double;

    procedure DoChange;

    procedure UpdateYAxis;
    procedure AddData(Y: Double);
    procedure RefLimitLineChange(NewValue: Double);

    property RawData          : TiPlotDataScopeList    read FRawData;
    property OnChange         : TNotifyEvent           read FOnChange          write FOnChange;

    property Scope            : TWinControl            read FScope             write FScope;
    property YAxis            : TiPlotYAxis            read FYAxis             write SetYAxis;
    property Channel          : TiPlotChannel          read FChannel           write SetChannel;
    property Annotation       : TiPlotAnnotation       read FAnnotation        write SetAnnotation;
    property RefLine          : TiPlotLimit            read FRefLine           write SetRefLine;
  public
    constructor Create;  virtual;
    destructor  Destroy; override;

    property Capacitor        : Double                 read FCapacitor;
    property BufferCount      : Integer                read GetBufferCount;
    property PositionVoltage  : Double                 read GetPositionVoltage write SetPositionVoltage;
  published
    property VoltsPerDivision : Double                 read FVoltsPerDivision  write SetVoltsPerDivision;
    property Position         : Double                 read FPosition          write SetPosition;
    property Coupling         : TiScopeChannelCoupling read FCoupling          write SetCoupling;

    property ScalerMultiplier : Double                 read FScalerMultiplier  write SetScalerMultiplier;
    property ScalerOffset     : Double                 read FScalerOffset      write SetScalerOffset;

    property TitleText        : String                 read GetTitleText       write SetTitleText;
    property Color            : TColor                 read GetColor           write SetColor           default clAqua;

    property TraceVisible     : Boolean                read GetTraceVisible    write SetTraceVisible    default True;
    property TraceLineWidth   : Integer                read GetTraceLineWidth  write SetTraceLineWidth  default 1;

    property RefLineShow      : Boolean                read FRefLineShow       write SetRefLineShow     default True;
  end;

implementation

uses
  {$IFDEF iVCL} iScope;{$ENDIF}
  {$IFDEF iCLX}QiScope;{$ENDIF}

type
  TiScopeAccess = class(TiScope)end;
//****************************************************************************************************************************************************
constructor TiScopeChannel.Create;
begin
  FRawData := TiPlotDataScopeList.Create;

  FVoltsPerDivision := 5;
  FPosition         := 0;
  FCoupling         := isccAC;

  FRefLineShow      := True;

  FTitleText        := 'CH';
  FColor            := clAqua;

  FTraceVisible     := True;
  FTraceLineWidth   := 1;
end;
//****************************************************************************************************************************************************
destructor TiScopeChannel.Destroy;
begin
  FRawData.Free;

  if Assigned(FYAxis)      then FYAxis.Free;
  if Assigned(FChannel)    then FChannel.Free;
  if Assigned(FAnnotation) then FAnnotation.Free;
  if Assigned(FRefLine)    then FRefLine.Free;

  inherited Destroy;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.DoChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.AddData(Y: Double);
var
  ScaledData : Double;
begin
                                 ScaledData := Y;
                                 ScaledData := ScaledData + FScalerOffset;
  if FScalerMultiplier <> 0 then ScaledData := ScaledData * FScalerMultiplier;

  case FCoupling of
    isccDC     : FRawData.Add(0, ScaledData, False, False);
    isccAC     : begin
                   FCapacitor := FCapacitor - FCapacitor/25000;
                   FCapacitor := FCapacitor + ScaledData/25000;
                   FRawData.Add(0, ScaledData, False, False);
                 end;
    isccGround : FRawData.Add(0, 0, False, False);
  end;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetCoupling(const Value: TiScopeChannelCoupling);
begin
  FCoupling := Value;
  DoChange;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetPosition(const Value: Double);
begin
  if FPosition <> Value then
    begin
      FPosition := Value;

      FSettingPosition := True;
      try
        if Assigned(FRefLine) then FRefLine.Line1Position := Value + 50;
      finally
        FSettingPosition := False;
      end;

      UpdateYAxis;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
function TiScopeChannel.GetPositionVoltage: Double;
begin
  Result := -(FYAxis.Min + FYAxis.Span/2);
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.RefLimitLineChange(NewValue: Double);
var
  NewPosition : Double;
begin
  if FSettingPosition then Exit;

  NewPosition := NewValue -50;
  NewPosition := (Trunc(ABS(NewPosition) * 10 + 0.0001)/10) * GetSign(NewPosition);
  Position := NewPosition;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetPositionVoltage(const Value: Double);
var
  NewPosition : Double;
begin
  NewPosition := Value/FYAxis.Span*100;
  NewPosition := Trunc(NewPosition*10 + 0.0001)/10;
  Position    := NewPosition;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetVoltsPerDivision(const Value: Double);
begin
  if FVoltsPerDivision <> Value then
    begin
      FVoltsPerDivision := Value;
      UpdateYAxis;
      DoChange;
    end;                         
end;
//****************************************************************************************************************************************************
function TiScopeChannel.GetTitleText     : String; begin if Assigned(FChannel) then Result := FChannel.TitleText      else Result := FTitleText;     end;
function TiScopeChannel.GetColor         : TColor; begin if Assigned(FChannel) then Result := FChannel.Color          else Result := FColor;         end;
function TiScopeChannel.GetTraceLineWidth: Integer;begin if Assigned(FChannel) then Result := FChannel.TraceLineWidth else Result := FTraceLineWidth;end;
function TiScopeChannel.GetTraceVisible  : Boolean;begin if Assigned(FChannel) then Result := FChannel.TraceVisible   else Result := FTraceVisible;  end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetTitleText     (const Value: String );begin FTitleText     :=Value;if Assigned(FChannel) then FChannel.TitleText     :=Value;DoChange;end;
procedure TiScopeChannel.SetTraceLineWidth(const Value: Integer);begin FTraceLineWidth:=Value;if Assigned(FChannel) then FChannel.TraceLineWidth:=Value;DoChange;end;
procedure TiScopeChannel.SetTraceVisible  (const Value: Boolean);begin FTraceVisible  :=Value;if Assigned(FChannel) then FChannel.TraceVisible  :=Value;DoChange;end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetColor(const Value: TColor);
begin
  if FColor <> Value then
    begin
      FColor := Value;
      if Assigned(FChannel)    then FChannel.Color         :=Value;
      if Assigned(FAnnotation) then FAnnotation.Font.Color :=Value;
      if Assigned(FRefLine)    then FRefLine.Color         :=Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetScalerMultiplier(const Value: Double);
begin
  FScalerMultiplier := Value;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetRefLineShow(const Value: Boolean);
begin
  if FRefLineShow <> Value then
    begin
      FRefLineShow := Value;
      if Assigned(FRefLine) then FRefLine.Visible := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetScalerOffset(const Value: Double);
begin
  FScalerOffset := Value;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetYAxis(const Value: TiPlotYAxis);
begin
  if FYAxis <> Value then
    begin
      FYAxis := Value;
      UpdateYAxis
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetChannel(const Value: TiPlotChannel);
begin
  FChannel                := Value;
  FChannel.Color          := FColor;
  FChannel.TitleText      := FTitleText;
  FChannel.TraceLineWidth := FTraceLineWidth;
  FChannel.TraceVisible   := FTraceVisible;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetAnnotation(const Value: TiPlotAnnotation);
begin
  FAnnotation                   := Value;
  FAnnotation.X                 := 5;
  FAnnotation.Y                 := 7;
  FAnnotation.Style             := ipasText;
  FAnnotation.Text              := 'N/A';
  FAnnotation.Font.Color        := FColor;
  FAnnotation.Font.Style        := [fsBold];
  FAnnotation.TextHorzAlignment := iahLeft;
  FAnnotation.TextHorzMargin    := 0;
  FAnnotation.Visible           := False;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.SetRefLine(const Value: TiPlotLimit);
begin
  FRefLine               := Value;
  FRefLine.Style         := iplsLineY;
  FRefLine.YAxisName     := TiScopeAccess(FScope as TiScope).Plot.YAxis[0].Name;
  FRefLine.LineStyle     := psDot;
  FRefLine.Color         := FColor;
  FRefLine.Layer         := 101;
  FRefLine.UserCanMove   := True;
  FRefLine.UserCanEdit   := False;
end;
//****************************************************************************************************************************************************
procedure TiScopeChannel.UpdateYAxis;
begin
  if Assigned(FYAxis) then
    begin
      FYAxis.Span             := 8*FVoltsPerDivision;
      FYAxis.Min              := -FYAxis.Span/2 - FYAxis.Span*FPosition/100;
      FYAxis.DesiredIncrement := FVoltsPerDivision;
    end;
end;
//****************************************************************************************************************************************************
function TiScopeChannel.GetYDisplay(Index: Integer): Double;
begin
  case FCoupling of
    isccDC     : Result := FRawData.Y[Index];
    isccAC     : Result := FRawData.Y[Index] - FCapacitor;
    else         Result := FRawData.Y[Index];
  end;
end;
//****************************************************************************************************************************************************
function TiScopeChannel.GetBufferCount: Integer;
begin
  Result := FRawData.Count;
end;
//****************************************************************************************************************************************************
end.


