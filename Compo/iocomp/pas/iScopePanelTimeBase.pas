{*******************************************************}
{                                                       }
{       TiScopePanelTimeBase Component                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopePanelTimeBase;{$endif}
{$ifdef iCLX}unit QiScopePanelTimeBase;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions,   iEditorBasicComponents,  iSpinSelector,{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiEditorBasicComponents, QiSpinSelector,{$ENDIF}
  {$IFDEF iVCL} iPlot,  iPlotChannelCustom,  iPlotAxis,  iPlotAnnotation,{$ENDIF}
  {$IFDEF iCLX}QiPlot, QiPlotChannelCustom, QiPlotAxis, QiPlotAnnotation,{$ENDIF}
  {$IFDEF iVCL} iPlotDataScopeList,  iScopePanelChannels,  iScopePanelTrigger,  iScopeChannel;{$ENDIF}
  {$IFDEF iCLX}QiPlotDataScopeList, QiScopePanelChannels, QiScopePanelTrigger, QiScopeChannel;{$ENDIF}

type
  TiScopePanelTimeBase = class(TCustomControl)
  private
    FCreationComplete     : Boolean;
    FRequiredHeight       : Integer;

    FScope                : TWinControl;
    FXAxis                : TiPlotXAxis;
    FScrollAnnotation     : TiPlotAnnotation;
    FDisplayAnnotation    : TiPlotAnnotation;
    FLastTransferTime     : Double;

    FLabel                : TLabel;
    FSecPerDivLabel       : TLabel;
    FPositionLabel        : TLabel;
    FPreCaptureLabel      : TLabel;
    FPostCaptureLabel     : TLabel;

    FSecPerDivSelector    : TiSpinSelector;
    FPositionSelector     : TiSpinSelector;
    FPreCaptureSelector   : TiSpinSelector;
    FPostCaptureSelector  : TiSpinSelector;

    FFrameTime            : Double;
    FSampleInterval       : Double;
    FSamplesPerFrame      : Integer;
    FSamplesPerSecond     : Integer;

    FSweepSamples         : Integer;
    FPreSamples           : Integer;
    FPostSamples          : Integer;

    FMaxContinuousSamples : Integer;
    FNeedsManualTrigger   : Boolean;
    FEventActive          : Boolean;
  protected
    procedure SetSamplesPerSecond    (const Value: Integer);
    procedure SetSecPerDiv           (const Value: Double);
    procedure SetPosition            (const Value: Double);
    procedure SetPostCapture         (const Value: Double);
    procedure SetPreCapture          (const Value: Double);
    procedure SetMaxContinuousSamples(const Value: Integer);

    procedure SetXAxis               (const Value: TiPlotXAxis);
    procedure SetScrollAnnotation    (const Value: TiPlotAnnotation);
    procedure SetDisplayAnnotation   (const Value: TiPlotAnnotation);

    function GetPosition   : Double;
    function GetSecPerDiv  : Double;
    function GetPostCapture: Double;
    function GetPreCapture : Double;

    procedure SecondsPerDivisionSelectorChange(Sender: TObject);
    procedure PositionSelectorChangeEvent     (Sender: TObject);

    procedure Resize;  override;

    procedure UpdateAll;
    procedure RemoveRawSamples(Value: Integer);

    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure AdjustLayout;
    procedure DataBlockUpdate;

    procedure DoManualTrigger(Sender: Tobject);

    procedure ScrollEvent;
                                   
    property RequiredHeight       : Integer              read FRequiredHeight;
    property LastTransferTime     : Double               read FLastTransferTime;

    property Scope                : TWinControl          read FScope                write FScope;
    property XAxis                : TiPlotXAxis          read FXAxis                write SetXAxis;
    property ScrollAnnotation     : TiPlotAnnotation     read FScrollAnnotation     write SetScrollAnnotation;
    property DisplayAnnotation    : TiPlotAnnotation     read FDisplayAnnotation    write SetDisplayAnnotation;


    property SecPerDivSelector    : TiSpinSelector       read FSecPerDivSelector;
    property PositionSelector     : TiSpinSelector       read FPositionSelector;
    property PreCaptureSelector   : TiSpinSelector       read FPreCaptureSelector;
    property PostCaptureSelector  : TiSpinSelector       read FPostCaptureSelector;
  published
    property SamplesPerSecond     : Integer              read FSamplesPerSecond     write SetSamplesPerSecond;
    property MaxContinuousSamples : Integer              read FMaxContinuousSamples write SetMaxContinuousSamples;
    property SecPerDiv            : Double               read GetSecPerDiv          write SetSecPerDiv;
    property Position             : Double               read GetPosition           write SetPosition;

    property PreCapture           : Double               read GetPreCapture         write SetPreCapture;
    property PostCapture          : Double               read GetPostCapture        write SetPostCapture;
  end;

implementation

uses
  {$IFDEF iVCL} iScope;{$ENDIF}
  {$IFDEF iCLX}QiScope;{$ENDIF}

type
  TiScopeAccess             = class(TiScope            )end;
  TiScopeChannelAccess      = class(TiScopeChannel     )end;
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom)end;
//****************************************************************************************************************************************************
constructor TiScopePanelTimeBase.Create(AOwner: TComponent);
var
  x : Integer;
begin
  inherited Create(AOwner);

  Width      := 150;
  Height     := 125;

  FLabel := TLabel.Create(Self);
  with FLabel do
    begin
      Parent      := Self;
      Top         := 3;
      Left        := 3;
      Font.Size   := 10;
      Font.Style  := [fsBold, fsItalic, fsUnderline];
      Caption     := 'Time Base';
      Transparent := True;
    end;

  FSecPerDivLabel := TLabel.Create(Self);
  with FSecPerDivLabel do
    begin
      Parent      := Self;
      Font.Size   := 8;
      Font.Style  := [fsBold];
      Caption     := 'SEC/DIV';
      Transparent := True;
    end;

  FSecPerDivSelector := TiSpinSelector.Create(Self);
  with FSecPerDivSelector do
    begin
      Parent         := Self;
      Height         := 24;
      Width          := 93;
      RepeatInterval := 200;
      DefaultValue   := 0.001;
      OnChange       := SecondsPerDivisionSelectorChange;

      AddItem('10 ns',   0.000000010);
      AddItem('20 ns',   0.000000020);
      AddItem('50 ns',   0.000000050);
      AddItem('0.1 us',  0.000000100);
      AddItem('0.2 us',  0.000000200);
      AddItem('0.5 us',  0.000000500);
      AddItem('1 us',    0.000001000);
      AddItem('2 us',    0.000002000);
      AddItem('5 us',    0.000005000);
      AddItem('10 us',   0.000010000);
      AddItem('20 us',   0.000020000);
      AddItem('50 us',   0.000050000);
      AddItem('0.1 ms',  0.000100000);
      AddItem('0.2 ms',  0.000200000);
      AddItem('0.5 ms',  0.000500000);
      AddItem('1 ms',    0.001000000);
      AddItem('2 ms',    0.002000000);
      AddItem('5 ms',    0.005000000);
      AddItem('10 ms',   0.010000000);
      AddItem('20 ms',   0.020000000);
      AddItem('50 ms',   0.050000000);
      AddItem('0.1 s',   0.100000000);
      FSecPerDivSelector.Value := 0.001;
    end;

  FPositionLabel := TLabel.Create(Self);
  with FPositionLabel do
    begin                                                
      Parent      := Self;
      Font.Size   := 8;
      Font.Style  := [fsBold];
      Caption     := 'Position';
      Transparent := True;
    end;

  FPositionSelector := TiSpinSelector.Create(Self);
  with FPositionSelector do
    begin
      Parent         := Self;
      Height         := 24;
      Width          := 93;
      RepeatInterval := 50;
      FastIncrement  := 10;
      OnChange       := PositionSelectorChangeEvent;

      for x := -500 to 500 do
        AddItem(FormatFloat('0.0%', x/10), x/10);

      FPositionSelector.Value := 0;
    end;

  FPreCaptureLabel := TLabel.Create(Self);
  with FPreCaptureLabel do
    begin
      Parent      := Self;
      Font.Size   := 8;
      Font.Style  := [fsBold];
      Caption     := 'Pre-Capture';
      Transparent := True;                                         
    end;

  FPreCaptureSelector := TiSpinSelector.Create(Self);
  with FPreCaptureSelector do
    begin
      Parent         := Self;
      Height         := 24;
      Width          := 93;
      RepeatInterval := 50;

      for x := 0 to 5 do
        AddItem(FormatFloat('0. DIV', x), x);

      FPreCaptureSelector.Value := 0;
    end;

  FPostCaptureLabel := TLabel.Create(Self);
  with FPostCaptureLabel do
    begin
      Parent      := Self;
      Font.Size   := 8;
      Font.Style  := [fsBold];
      Caption     := 'Post-Capture';
      Transparent := True;
    end;

  FPostCaptureSelector := TiSpinSelector.Create(Self);
  with FPostCaptureSelector do
    begin
      Parent         := Self;
      Height         := 24;
      Width          := 93;
      RepeatInterval := 50;

      for x := 0 to 5 do
        AddItem(FormatFloat('0. DIV', x), x);

      FPostCaptureSelector.Value := 0;
    end;

  FCreationComplete := True;
end;
//****************************************************************************************************************************************************
destructor TiScopePanelTimeBase.Destroy;
begin
  inherited Destroy;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.Resize;
begin
  inherited Resize;
  AdjustLayout;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.AdjustLayout;
var
  MaxLabelWidth : Integer;
  LeftStart     : Integer;
  TopStart      : Integer;
begin
  if not FCreationComplete then Exit;

  MaxLabelWidth := 0;

  TopStart  := FLabel.Height + 10;

  if FSecPerDivLabel.Width   > MaxLabelWidth then MaxLabelWidth := FSecPerDivLabel.Width;
  if FPositionLabel.Width    > MaxLabelWidth then MaxLabelWidth := FPositionLabel.Width;
  if FPreCaptureLabel.Width  > MaxLabelWidth then MaxLabelWidth := FPreCaptureLabel.Width;
  if FPostCaptureLabel.Width > MaxLabelWidth then MaxLabelWidth := FPostCaptureLabel.Width;

  LeftStart := Width - 10 - MaxLabelWidth - FSecPerDivSelector.Width - 5;

  FSecPerDivLabel.Left      := LeftStart + MaxLabelWidth - FSecPerDivLabel.Width;
  FPositionLabel.Left       := LeftStart + MaxLabelWidth - FPositionLabel.Width;
  FPreCaptureLabel.Left     := LeftStart + MaxLabelWidth - FPreCaptureLabel.Width;
  FPostCaptureLabel.Left    := LeftStart + MaxLabelWidth - FPostCaptureLabel.Width;

  FSecPerDivSelector.Top    := TopStart;
  FPositionSelector.Top     := FSecPerDivSelector.Top  + FSecPerDivSelector.Height  + 2;
  FPreCaptureSelector.Top   := FPositionSelector.Top   + FPositionSelector.Height   + 2;
  FPostCaptureSelector.Top  := FPreCaptureSelector.Top + FPreCaptureSelector.Height + 2;

  FSecPerDivSelector.Left   := LeftStart + MaxLabelWidth +5;
  FPositionSelector.Left    := FSecPerDivSelector.Left;
  FPreCaptureSelector.Left  := FSecPerDivSelector.Left;
  FPostCaptureSelector.Left := FSecPerDivSelector.Left;

  iAlignVCenterControl(FSecPerDivSelector,   FSecPerDivLabel);
  iAlignVCenterControl(FPositionSelector,    FPositionLabel);
  iAlignVCenterControl(FPreCaptureSelector,  FPreCaptureLabel);
  iAlignVCenterControl(FPostCaptureSelector, FPostCaptureLabel);

  FRequiredHeight := FPostCaptureSelector.Top + FPostCaptureSelector.Height + 10;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.RemoveRawSamples(Value: Integer);
var
  ScopeChannel      : TiScopeChannel;
  ChannelIndex      : Integer;
begin
  for ChannelIndex := 0 to TiScopeAccess(FScope as TiScope).PanelChannels.Count-1 do
    begin
      ScopeChannel := TiScopeAccess(FScope as TiScope).PanelChannels.ScopeChannel[ChannelIndex];
      TiScopeChannelAccess(ScopeChannel).RawData.DeletePoints(Value);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.DataBlockUpdate;
var
  TriggerChannel    : TiScopeChannel;
  ScopeChannel      : TiScopeChannel;
  ChannelIndex      : Integer;
  TriggerIndex      : Integer;
  DataIndex         : Integer;
  TriggerStartIndex : Integer;
  TriggerStopIndex  : Integer;
  NeededSamples     : Integer;

  StartIndex        : Integer;
  StopIndex         : Integer;
  TimeIndex         : Integer;
  AutoTrigger       : Boolean;
  TriggerFound      : Boolean;
  RawData           : TiPlotDataScopeList;
  XData             : Double;
  YData             : Double;
begin
  TiScopeAccess(FScope as TiScope).Plot.BeginUpdate;

  UpdateAll;

  TriggerChannel := TiScopeAccess(FScope as TiScope).PanelChannels.ScopeChannel[TiScopeAccess(FScope as TiScope).PanelTrigger.SourceIndex];
  RawData        := TiScopeChannelAccess(TriggerChannel).RawData;

  NeededSamples := FSweepSamples;

  AutoTrigger   := TiScopeAccess(FScope as TiScope).PanelTrigger.Auto;

  if FSamplesPerFrame = 0 then
    begin
      TiScopeAccess(FScope as TiScope).Plot.ClearAllData;
      RemoveRawSamples(RawData.Count);
      Exit;
    end;

  while RawData.Count > NeededSamples do
    begin
      TriggerFound := False;
      if AutoTrigger then                    
        begin
          TriggerStartIndex := FPreSamples;
          TriggerStopIndex  := RawData.Count - (FSamplesPerFrame + FPostSamples);

          RawData.UpdateLevel(TriggerStartIndex, TriggerStopIndex);
          TriggerFound := TiScopeAccess(FScope as TiScope).PanelTrigger.CheckForTrigger(RawData, TriggerStartIndex, TriggerStopIndex, TriggerIndex);
        end
      else if FNeedsManualTrigger then
        begin
          TriggerIndex := RawData.Count - (FSamplesPerFrame + FPostSamples);
          TriggerFound := True;
          FNeedsManualTrigger := False;
        end
      else
        begin
          if (RawData.Count > 3*NeededSamples) then
            RemoveRawSamples(RawData.Count - 2*NeededSamples)
          else
            Break;
        end;

      if TriggerFound then
        begin
          TiScopeAccess(FScope as TiScope).Plot.ClearAllData;

          StartIndex := TriggerIndex - FPreSamples;
          StopIndex  := TriggerIndex + FSamplesPerFrame -1 + FPostSamples;

          for ChannelIndex := 0 to TiScopeAccess(FScope as TiScope).PanelChannels.Count-1 do
            begin
              ScopeChannel := TiScopeAccess(FScope as TiScope).PanelChannels.ScopeChannel[ChannelIndex];

              for DataIndex := StartIndex to StopIndex do
                begin
                  TimeIndex := DataIndex - StartIndex - FPreSamples;
                  XData     := TimeIndex*FSampleInterval;
                  YData     := TiScopeChannelAccess(ScopeChannel).GetYDisplay(DataIndex);
                  TiPlotChannelCustomAccess(TiScopeChannelAccess(ScopeChannel).Channel).DataList.Add(XData, YData, False, False);
                end;
            end;

          FLastTransferTime := Now;

          RemoveRawSamples(StopIndex);
        end
      else
        begin
          if (RawData.Count > 2*NeededSamples) then
            RemoveRawSamples(RawData.Count - NeededSamples)
          else
            Break;
        end;
    end;
  TiScopeAccess(FScope as TiScope).Plot.EndUpdate;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.Paint;
var
  DrawRect : TRect;
begin
  inherited;
  with Canvas do
    begin
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      DrawRect := Rect(0, 0, Width, Height);
      FillRect(DrawRect);
      iDrawEdge(Canvas, DrawRect, idesRaised);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.SecondsPerDivisionSelectorChange(Sender: TObject);
begin                                          
  if not Assigned(FScope) then Exit;
                                                                    
  TiScopeAccess(FScope as TiScope).Plot.ClearAllData;
  FDisplayAnnotation.Text := FSecPerDivSelector.Text;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.PositionSelectorChangeEvent(Sender: TObject);
begin
  if FEventActive then Exit;
  FEventActive := True;
  try
    if Assigned(FScrollAnnotation) then FScrollAnnotation.X := -FPositionSelector.Value/100 + 0.5;
  finally
    FEventActive := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.SetSamplesPerSecond    (const Value:Integer    );begin if FSamplesPerSecond    <>Value then FSamplesPerSecond    := Value;end;
procedure TiScopePanelTimeBase.SetMaxContinuousSamples(const Value:Integer    );begin if FMaxContinuousSamples<>Value then FMaxContinuousSamples:= Value;end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.SetXAxis            (const Value:TiPlotXAxis);     begin FXAxis             := Value;end;
procedure TiScopePanelTimeBase.SetScrollAnnotation (const Value:TiPlotAnnotation);begin FScrollAnnotation  := Value;end;
procedure TiScopePanelTimeBase.SetDisplayAnnotation(const Value:TiPlotAnnotation);begin FDisplayAnnotation := Value; FDisplayAnnotation.Text := FSecPerDivSelector.Text end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.SetSecPerDiv  (const Value:Double);begin FSecPerDivSelector.Value   := Value;end;
procedure TiScopePanelTimeBase.SetPreCapture (const Value:Double);begin FPreCaptureSelector.Value  := Value;end;
procedure TiScopePanelTimeBase.SetPostCapture(const Value:Double);begin FPostCaptureSelector.Value := Value;end;
//****************************************************************************************************************************************************
function TiScopePanelTimeBase.GetPosition   : Double;begin Result := FPositionSelector.Value;   end;
function TiScopePanelTimeBase.GetSecPerDiv  : Double;begin Result := FSecPerDivSelector.Value;  end;
function TiScopePanelTimeBase.GetPostCapture: Double;begin Result := FPostCaptureSelector.Value;end;
function TiScopePanelTimeBase.GetPreCapture : Double;begin Result := FPreCaptureSelector.Value; end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.SetPosition(const Value:Double);
begin
  if FPositionSelector.Value <> Value then
    begin
      FPositionSelector.Value := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.UpdateAll;
begin
  FFrameTime       := 10 * FSecPerDivSelector.Value;
  FSamplesPerFrame := Round(FSamplesPerSecond * FFrameTime) +1;
  FPreSamples      := Round(FSamplesPerFrame/10 * FPreCaptureSelector.Value);
  FPostSamples     := Round(FSamplesPerFrame/10 * FPostCaptureSelector.Value);
  FSweepSamples    := FPreSamples + FSamplesPerFrame + FPostSamples;

  if not Assigned(FXAxis) then Exit;
  XAxis.Span := FFrameTime;
  XAxis.Min  := (XAxis.Span * FPositionSelector.Value)/100;

  if FSamplesPerSecond = 0 then Exit;
  FSampleInterval  := 1/FSamplesPerSecond;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.ScrollEvent;
var
  NewPosition : Double;
begin
  if FEventActive then Exit;
  FEventActive := True;
  try
    NewPosition := -(FScrollAnnotation.X -0.5)*100;
    if NewPosition >= 0 then
      NewPosition := Trunc(NewPosition*10  + 0.0001)/10
    else
      NewPosition := Trunc(NewPosition*10)/10;
    Position := NewPosition;
  finally
    FEventActive := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTimeBase.DoManualTrigger(Sender: Tobject);
begin
  FNeedsManualTrigger := True;
  TiScopeAccess(FScope as TiScope).Plot.ClearAllData;
  DataBlockUpdate;
end;
//****************************************************************************************************************************************************
end.


