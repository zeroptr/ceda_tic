{*******************************************************}
{                                                       }
{       TiScopePanelTrigger Component                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopePanelTrigger;{$endif}
{$ifdef iCLX}unit QiScopePanelTrigger;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}  iTypes,  Buttons, iGPFunctions,   iEditorBasicComponents,  iSpinSelector,  iScopePanelChannels,  iPlotDataScopeList;{$ENDIF}
  {$IFDEF iCLX} QiTypes, QButtons, QiGPFunctions, QiEditorBasicComponents, QiSpinSelector, QiScopePanelChannels, QiPlotDataScopeList;{$ENDIF}

type
  TiScopePanelTrigger = class(TCustomControl)
  private
    FCreationComplete : Boolean;                                           
    FRequiredHeight   : Integer;

    FLabel            : TLabel;
    FLevelLabel       : TLabel;
    FSourceLabel      : TLabel;

    FLevelSelector    : TiSpinSelector;
    FSourceSelector   : TiSpinSelector;
    FPanelChannels    : TiScopePanelChannels;

    FPosSlopeButton   : TSpeedButton;
    FNegSlopeButton   : TSpeedButton;

    FAutoButton       : TSpeedButton;
    FTriggerButton    : TSpeedButton;

    FOnManualTrigger  : TNotifyEvent;
  protected
    procedure SetLevel        (const Value: Double);
    procedure SetPositiveSlope(const Value: Boolean);
    procedure SetAuto         (const Value: Boolean);
    procedure SetSourceIndex  (const Value: Integer);

    function GetSourceIndex  : Integer;
    function GetAuto         : Boolean;
    function GetLevel        : Double;
    function GetPositiveSlope: Boolean;

    procedure Resize;  override;

    procedure AutoButtonClick     (Sender: TObject);
    procedure TriggerButtonClick  (Sender: TObject);

    procedure UpdateAll;

    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure AdjustLayout;

    function CheckForTrigger(DataList: TiPlotDataScopeList; ScanStartIndex, ScanStopIndex: Integer; var TriggerIndex: Integer): Boolean;

    procedure SetupSourceSelector;

    procedure ManualTrigger;

    property RequiredHeight  : Integer              read FRequiredHeight;
    property PanelChannels   : TiScopePanelChannels read FPanelChannels   write FPanelChannels;

    property OnManualTrigger : TNotifyEvent         read FOnManualTrigger write FOnManualTrigger;

    property LevelSelector   : TiSpinSelector       read FLevelSelector;
    property SourceSelector  : TiSpinSelector       read FSourceSelector;
  published
    property Level           : Double               read GetLevel         write SetLevel;
    property PositiveSlope   : Boolean              read GetPositiveSlope write SetPositiveSlope;
    property SourceIndex     : Integer              read GetSourceIndex   write SetSourceIndex;
    property Auto            : Boolean              read GetAuto          write SetAuto;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiScopePanelTrigger.Create(AOwner: TComponent);
var
  x : Integer;
begin
  inherited Create(AOwner);

  Width      := 200;
  Height     := 125;

  FLabel := TLabel.Create(Self);
  with FLabel do
    begin
      Parent      := Self;
      Top         := 3;
      Left        := 3;
      Font.Size   := 10;
      Font.Style  := [fsBold, fsItalic, fsUnderline];
      Caption     := 'Trigger';
      Transparent := True;
    end;

  FLevelLabel := TLabel.Create(Self);
  with FLevelLabel do
    begin
      Parent      := Self;
      Font.Size   := 8;
      Font.Style  := [fsBold];
      Caption     := 'Level';                
      Transparent := True;
    end;

  FLevelSelector := TiSpinSelector.Create(Self);
  with FLevelSelector do
    begin
      Parent         := Self;
      Height         := 24;
      Width          := 100;
      RepeatInterval := 100;
      DefaultValue   := 50;
      FastIncrement  := 5;

      for x := 10 to 90 do
        AddItem(FormatFloat('0.%', x), x);
    end;

  FSourceLabel := TLabel.Create(Self);
  with FSourceLabel do
    begin
      Parent      := Self;
      Font.Size   := 8;
      Font.Style  := [fsBold];
      Caption     := 'Source';
      Transparent := True;
    end;

  FSourceSelector := TiSpinSelector.Create(Self);
  with FSourceSelector do
    begin
      Parent         := Self;
      Height         := 24;
      Width          := 100;
      RepeatInterval := 5;
    end;

  FPosSlopeButton := TSpeedButton.Create(Self);
  with FPosSlopeButton do
    begin
      Parent     := Self;
      Width      := 20;
      Height     := 20;
      GroupIndex := 1;
      Glyph.LoadFromResourceName(HInstance, 'PositiveSlope');
    end;

  FNegSlopeButton := TSpeedButton.Create(Self);
  with FNegSlopeButton do
    begin
      Parent     := Self;
      Width      := 20;
      Height     := 20;                                
      GroupIndex := 1;
      TabStop    := True;
      Glyph.LoadFromResourceName(HInstance, 'NegativeSlope');
    end;

  FAutoButton := TSpeedButton.Create(Self);
  with FAutoButton do
    begin
      Parent     := Self;
      Width      := 50;
      Height     := 23;
      OnClick    := AutoButtonClick;
      Caption    := 'Auto';
      Font.Style := [fsBold];
      GroupIndex := 2;
      AllowAllUp := True;
    end;

  FTriggerButton := TSpeedButton.Create(Self);
  with FTriggerButton do
    begin
      Parent     := Self;
      Width      := 23;
      Height     := 23;
      OnClick    := TriggerButtonClick;
      Glyph.LoadFromResourceName(HInstance, 'Trigger');
    end;

  PositiveSlope := True;

  FCreationComplete := True;
end;
//****************************************************************************************************************************************************
destructor TiScopePanelTrigger.Destroy;
begin
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.Resize;
begin
  inherited Resize;
  AdjustLayout;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.AdjustLayout;
var
  MaxLabelWidth : Integer;
  LeftStart     : Integer;
  TopStart      : Integer;
begin
  if not FCreationComplete then Exit;

  MaxLabelWidth := 0;

  TopStart  := FLabel.Height + 10;

  if FLevelLabel.Width  > MaxLabelWidth then MaxLabelWidth := FLevelLabel.Width;
  if FSourceLabel.Width  > MaxLabelWidth then MaxLabelWidth := FSourceLabel.Width;

  LeftStart := Width - 10 - MaxLabelWidth - FLevelSelector.Width - 5;

  FLevelLabel.Left     := LeftStart + MaxLabelWidth - FLevelLabel.Width;
  FSourceLabel.Left    := LeftStart + MaxLabelWidth - FSourceLabel.Width;

  FLevelSelector.Top   := TopStart;
  FSourceSelector.Top  := FLevelSelector.Top  + FLevelSelector.Height + 2;

  FLevelSelector.Left  := LeftStart + MaxLabelWidth +5;
  FSourceSelector.Left := FLevelSelector.Left;

  iAlignVCenterControl(FLevelSelector, FLevelLabel);
  iAlignVCenterControl(FSourceSelector, FSourceLabel);

  FAutoButton.Top      := FSourceSelector.Top + FSourceSelector.Height + 27;
  FAutoButton.Left     := 10;

  FTriggerButton.Top   := FAutoButton.Top;
  FTriggerButton.Left  := FAutoButton.Left + FAutoButton.Width + 0;

  iAlignVCenterControl(FAutoButton, FNegSlopeButton);
  FNegSlopeButton.Left := FSourceSelector.Left + FSourceSelector.Width - FNegSlopeButton.Width;

  FPosSlopeButton.Top  := FNegSlopeButton.Top;
  FPosSlopeButton.Left := FNegSlopeButton.Left - FPosSlopeButton.Width;

  FRequiredHeight := FAutoButton.Top + FAutoButton.Height + 10;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.UpdateAll;
begin

end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.Paint;
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
procedure TiScopePanelTrigger.SetupSourceSelector;
var
  i       : Integer;
  OldName : String;
begin
  if not Assigned(FPanelChannels) then Exit;

  if FSourceSelector.ItemIndex <> - 1 then
    OldName := FSourceSelector.GetItemCaption(FSourceSelector.ItemIndex)
  else
    OldName := '';

  FSourceSelector.RemoveAllItems;
  for i := 0 to FPanelChannels.Count -1 do
    FSourceSelector.AddItem(FPanelChannels.ScopeChannel[i].TitleText, i);

  FSourceSelector.SetItemIndexByCaption(OldName);

  if (FSourceSelector.ItemCount <> 0) and (FSourceSelector.ItemIndex = -1) then FSourceSelector.ItemIndex := -1;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.SetLevel(const Value: Double);
begin
  FLevelSelector.Value := Value;
end;
//****************************************************************************************************************************************************
function TiScopePanelTrigger.GetLevel: Double;
begin
  Result := FLevelSelector.Value;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.SetPositiveSlope(const Value: Boolean);
begin
  if Value then FPosSlopeButton.Down := True else FNegSlopeButton.Down := True;
end;
//****************************************************************************************************************************************************
function TiScopePanelTrigger.GetPositiveSlope: Boolean;
begin
  Result := FPosSlopeButton.Down;
end;
//****************************************************************************************************************************************************
function TiScopePanelTrigger.CheckForTrigger(DataList: TiPlotDataScopeList; ScanStartIndex, ScanStopIndex: Integer; var TriggerIndex: Integer): Boolean;
var
  DataIndex       : Integer;
  ALevel          : Double;
  ResetFound      : Boolean;
  LevelTarget     : Double;
begin
  Result      := False;
  ResetFound  := False;

  LevelTarget := FLevelSelector.Value;

  for DataIndex := ScanStartIndex to ScanStopIndex do
    begin
      ALevel := DataList.Level[DataIndex];

      case FPosSlopeButton.Down of
        True  : begin
                  if not ResetFound then if ALevel > 5 then Continue;
                  ResetFound := True;

                  if ALevel > LevelTarget then                            
                    begin
                      Result       := True;
                      TriggerIndex := DataIndex;
                      ResetFound   := False; //Keep Checking for More;
                    end;
                end;
        False : begin
                  if not ResetFound then if ALevel < 95 then Continue;
                  ResetFound := True;

                  if ALevel < LevelTarget then
                    begin
                      Result       := True;
                      TriggerIndex := DataIndex;
                      ResetFound   := False; //Keep Checking for More;
                    end;
                end;
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiScopePanelTrigger.GetSourceIndex: Integer;
begin
  Result := FSourceSelector.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.SetSourceIndex(const Value: Integer);
begin
  FSourceSelector.ItemIndex := Value;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.AutoButtonClick(Sender: TObject);
begin
  FTriggerButton.Enabled := not FAutoButton.Down;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.TriggerButtonClick(Sender: TObject);
begin
  ManualTrigger;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.ManualTrigger;
begin
  if Assigned(FOnManualTrigger) then FOnManualTrigger(Self);
end;
//****************************************************************************************************************************************************
function TiScopePanelTrigger.GetAuto: Boolean;
begin
  Result := FAutoButton.Down;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelTrigger.SetAuto(const Value: Boolean);
begin
  FAutoButton.Down := Value;
  FTriggerButton.Enabled := not FAutoButton.Down;
end;
//****************************************************************************************************************************************************
end.


