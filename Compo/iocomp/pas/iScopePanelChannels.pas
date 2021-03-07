{*******************************************************}
{                                                       }
{       TiScopePanelChannels Component                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopePanelChannels;{$endif}
{$ifdef iCLX}unit QiScopePanelChannels;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  Buttons,  iEditorBasicComponents,  iSpinSelector,  iLinkedListBox,  iCheckBox,{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QButtons, QiEditorBasicComponents, QiSpinSelector, QiLinkedListBox, QiCheckBox,{$ENDIF}
  {$IFDEF iVCL} iPlot,  iPlotChannel,  iPlotChannelCustom,  iScopeChannel, iPlotAxis,   iPlotDataScopeList;{$ENDIF}
  {$IFDEF iCLX}QiPlot, QiPlotChannel, QiPlotChannelCustom, QiScopeChannel, QiPlotAxis, QiPlotDataScopeList;{$ENDIF}

type
  TiScopePanelChannels = class(TCustomControl)
  private
    FScope               : TWinControl;

    FScopeChannelList    : TStringList;
    FBlockActive         : Boolean;

    FLabel               : TLabel;
    FVoltageLabel        : TLabel;
    FPositionLabel       : TLabel;
    FCouplingLabel       : TLabel;

    FChannelListDisplay  : TiLinkedListBox;
    FVoltageSelector     : TiSpinSelector;
    FPositionSelector    : TiSpinSelector;
    FCouplingSelector    : TiSpinSelector;
    FVisibleCheckBox     : TiCheckBox;
    FRefLineCheckBox     : TiCheckBox;

    FMaxWidthTitle       : Integer;
    FMaxWidthCoupling    : Integer;
    FMaxWidthVoltsPerDiv : Integer;
    FMaxWidthPosition    : Integer;

    FCreationComplete    : Boolean;
    function GetDataBlockSynchronized: Boolean;
  protected
    procedure Paint;   override;
    procedure Resize;  override;
    procedure AdjustLayout;
    procedure AdjustAnnotations;

    function GetScopeChannel(Index: Integer): TiScopeChannel;
    function GetCount: Integer;

    procedure VoltageSelectorChange (Sender: TObject);
    procedure PositionSelectorChange(Sender: TObject);
    procedure CouplingChange        (Sender: TObject);
    procedure VisibleClick          (Sender: TObject);
    procedure RefLineClick          (Sender: TObject);

    procedure ChannelChange         (Sender: TObject);

    function  GetCouplingText   (Value: TiScopeChannelCoupling): String;
    function  GetVoltsPerDivText(Value: Double)                : String;
    function  GetPositionText   (Value: Double)                : String;

    procedure ChannelListGetItemCount (Sender: TObject;                 var Value : Integer);
    procedure ChannelListGetItemString(Sender: TObject; Index: Integer; var Value : String );
    procedure ChannelListPaintItem    (Sender: TObject; Canvas: TCanvas; ARect: TRect; State: TOwnerDrawState; Index: Integer; AText: String; var Handled: Boolean);
    procedure ChannelListChange       (Sender: TObject);
    procedure ChannelListPaintSetup   (Sender: TObject; Canvas: TCanvas);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure DataBlockBegin;
    procedure DataBlockEnd;
    procedure DataBlockClear;

    property  DataBlockActive      : Boolean read FBlockActive;
    property DataBlockSynchronized : Boolean read GetDataBlockSynchronized;

    procedure AddChannelData(Channel: Integer; Y: Double);

    function  GetScopeChannelFromLimitIndex(Index: Integer): TiScopeChannel;
    function GetScopeChannelFromAnnotation (Index: Integer): TiScopeChannel;

    procedure CheckForSynchronizedData;

    procedure UpdateDisplay;

    function  AddChannel: Integer;
    procedure RemoveAllChannels;
    procedure DeleteChannel(Index: Integer);


    property ScopeChannel[Index: Integer]: TiScopeChannel read GetScopeChannel;
    property Count : Integer read GetCount;

    property Scope            : TWinControl    read FScope write FScope;

    property VoltageSelector  : TiSpinSelector read FVoltageSelector;
    property PositionSelector : TiSpinSelector read FPositionSelector;
    property CouplingSelector : TiSpinSelector read FCouplingSelector;
  end;

implementation

uses
  {$IFDEF iVCL} iScope;{$ENDIF}
  {$IFDEF iCLX}QiScope;{$ENDIF}

type
  TiScopeAccess        = class(TiScope       )end;
  TiScopeChannelAccess = class(TiScopeChannel)end;
//****************************************************************************************************************************************************
constructor TiScopePanelChannels.Create(AOwner: TComponent);
var
  x : Integer;
begin
  inherited Create(AOwner);

  Width      := 210;
  Height     := 125;

  FLabel := TLabel.Create(Self);
  with FLabel do
    begin
      Parent      := Self;
      Top         := 3;
      Left        := 3;
      Font.Size   := 10;
      Font.Style  := [fsBold, fsItalic, fsUnderline];
      Caption     := 'Channels';
      Transparent := True;
    end;

  FChannelListDisplay := TiLinkedListBox.Create(Self);
  with FChannelListDisplay do
    begin
      Parent               := Self;
      Color                := clBlack;
      Font.Color           := clWhite;
      ShowFocusNoSelection := False;
      OnGetItemCount       := ChannelListGetItemCount;
      OnGetItemString      := ChannelListGetItemString;
      OnPaintItem          := ChannelListPaintItem;
      OnPaintSetup         := ChannelListPaintSetup;
      OnChange             := ChannelListChange;
    end;

  FVoltageLabel := TLabel.Create(Self);
  with FVoltageLabel do
    begin
      Parent      := Self;
      Font.Size   := 8;
      Font.Style  := [fsBold];
      Caption     := 'Volts/DIV';
      Transparent := True;
    end;

  FVoltageSelector := TiSpinSelector.Create(Self);
  with FVoltageSelector do
    begin
      Parent         := Self;
      Height         := 24;
      Width          := 93;
      RepeatInterval := 200;
      DefaultValue   := 5;

      OnChange       := VoltageSelectorChange;

      AddItem('1 µV',    0.000001);
      AddItem('2 µV',    0.000002);
      AddItem('5 µV',    0.000005);
      AddItem('10 µV',   0.000010);
      AddItem('20 µV',   0.000020);
      AddItem('50 µV',   0.000050);
      AddItem('100 µV',  0.000100);
      AddItem('1 mV',    0.001000);
      AddItem('2 mV',    0.002000);
      AddItem('5 mV',    0.005000);
      AddItem('10 mV',   0.010000);
      AddItem('20 mV',   0.020000);
      AddItem('50 mV',   0.050000);
      AddItem('100 mV',  0.100000);
      AddItem('200 mV',  0.200000);
      AddItem('500 mV',  0.500000);
      AddItem('1 V',     1.000000);
      AddItem('2 V',     2.000000);
      AddItem('5 V',     5.000000);
      AddItem('10 V',   10.000000);
      AddItem('20 V',   20.000000);
      AddItem('50 V',   50.000000);
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
      DefaultValue   := 0;
      OnChange       := PositionSelectorChange;

      for x := -1000 to 1000 do
        AddItem(FormatFloat('0.0%', x/10), x/10);
    end;

  FCouplingLabel := TLabel.Create(Self);
  with FCouplingLabel do
    begin
      Parent      := Self;
      Font.Size   := 8;
      Font.Style  := [fsBold];
      Caption     := 'Coupling';
      Transparent := True;
    end;

  FCouplingSelector := TiSpinSelector.Create(Self);
  with FCouplingSelector do
    begin
      Parent         := Self;
      Height         := 24;
      Width          := 93;
      RepeatInterval := 5;
      DefaultValue   := 1;
      OnChange       := CouplingChange;

      AddItem('DC',  0.000);
      AddItem('AC',  1.000);
      AddItem('GND', 2.000);
    end;

  FVisibleCheckBox := TiCheckBox.Create(Self);
  with FVisibleCheckBox do
    begin
      Parent     := Self;
      Width      := 75;
      Caption    := 'Visible';
      OnChange   := VisibleClick;
    end;

  FRefLineCheckBox := TiCheckBox.Create(Self);
  with FRefLineCheckBox do
    begin
      Parent     := Self;
      Width      := 75;
      Caption    := 'Ref Line';
      OnChange   := RefLineClick;
    end;

  FScopeChannelList := TStringList.Create;

  FCreationComplete := True;
end;
//****************************************************************************************************************************************************
destructor TiScopePanelChannels.Destroy;
begin
  while FScopeChannelList.Count <> 0 do
    begin
      FScopeChannelList.Objects[0].Free;
      FScopeChannelList.Delete(0);
    end;

  FScopeChannelList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.Resize;
begin
  inherited Resize;
  AdjustLayout;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.AdjustLayout;
var
  MaxLabelWidth : Integer;
  LeftStart     : Integer;
  TopStart      : Integer;
begin
  if not FCreationComplete then Exit;

  MaxLabelWidth := 0;

  TopStart  := FLabel.Height + 10;

  FChannelListDisplay.Left   := 10;
  FChannelListDisplay.Top    := TopStart;
  FChannelListDisplay.Width  := Width div 3;
  FChannelListDisplay.Height := Height - FChannelListDisplay.Top - 10;

  if FVoltageLabel.Width  > MaxLabelWidth then MaxLabelWidth := FVoltageLabel.Width;
  if FPositionLabel.Width > MaxLabelWidth then MaxLabelWidth := FPositionLabel.Width;
  if FCouplingLabel.Width > MaxLabelWidth then MaxLabelWidth := FCouplingLabel.Width;

  LeftStart := Width - 10 - MaxLabelWidth - FVoltageSelector.Width - 5;

  FVoltageLabel.Left     := LeftStart + MaxLabelWidth - FVoltageLabel.Width;
  FPositionLabel.Left    := LeftStart + MaxLabelWidth - FPositionLabel.Width;
  FCouplingLabel.Left    := LeftStart + MaxLabelWidth - FCouplingLabel.Width;

  FVoltageSelector.Left  := FVoltageLabel.Left  + FVoltageLabel.Width  + 5;
  FPositionSelector.Left := FPositionLabel.Left + FPositionLabel.Width + 5;
  FCouplingSelector.Left := FCouplingLabel.Left + FCouplingLabel.Width + 5;

  FVoltageSelector.Top   := FChannelListDisplay.Top;
  FPositionSelector.Top  := FVoltageSelector.Top  + FVoltageSelector.Height  + 2;
  FCouplingSelector.Top  := FPositionSelector.Top + FPositionSelector.Height + 2;

  iAlignVCenterControl(FPositionSelector, FPositionLabel);
  iAlignVCenterControl(FVoltageSelector,  FVoltageLabel);
  iAlignVCenterControl(FCouplingSelector, FCouplingLabel);

  FChannelListDisplay.Width := FVoltageLabel.Left - 10 - FChannelListDisplay.Left;

  FVisibleCheckBox.Top  := FCouplingSelector.Top + FCouplingSelector.Height + 5;
  FVisibleCheckBox.Left := FChannelListDisplay.Left + FChannelListDisplay.Width + 10;

  FRefLineCheckBox.Top  := FVisibleCheckBox.Top;
  FRefLineCheckBox.Left := FVisibleCheckBox.Left + FVisibleCheckBox.Width + 5;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.ChannelListGetItemCount(Sender: TObject; var Value: Integer);
begin
  if Assigned(FScopeChannelList) then
    Value := FScopeChannelList.Count
  else Value := 0;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.ChannelListGetItemString(Sender: TObject; Index: Integer; var Value: String);
begin
  if Assigned(TiScopeChannelAccess(ScopeChannel[Index]).Channel) then
    begin
      Value := TiScopeChannelAccess(ScopeChannel[Index]).Channel.TitleText;
    end
  else Value :=  'Unassigned';
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.GetCouplingText(Value: TiScopeChannelCoupling): String;
begin
  case Value of
    isccDC     : Result := 'DC';
    isccAC     : Result := 'AC';
    isccGround : Result := 'GND';
  end;
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.GetVoltsPerDivText(Value: Double): String;
begin
  Result := FVoltageSelector.GetItemCaptionByValue(Value) + '/DIV';
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.GetPositionText(Value: Double): String;
begin
  Result := FPositionSelector.GetItemCaptionByValue(Value);
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.ChannelListPaintSetup(Sender: TObject; Canvas: TCanvas);
var
  x : Integer;
begin
  FMaxWidthTitle       := 0;
  FMaxWidthCoupling    := 0;
  FMaxWidthVoltsPerDiv := 0;
  FMaxWidthPosition    := 0;

  with Canvas do
    begin
      for x := 0 to Count-1 do
        if TextWidth(ScopeChannel[x].TitleText) > FMaxWidthTitle then FMaxWidthTitle := TextWidth(ScopeChannel[x].TitleText);

      FMaxWidthCoupling    := FCouplingSelector.GetMaxItemsWidth(Canvas);
      FMaxWidthVoltsPerDiv := FVoltageSelector.GetMaxItemsWidth (Canvas) + TextWidth('/DIV');
      FMaxWidthPosition    := FPositionSelector.GetMaxItemsWidth(Canvas);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.ChannelListPaintItem(Sender: TObject; Canvas: TCanvas; ARect: TRect; State: TOwnerDrawState; Index: Integer; AText: String; var Handled: Boolean);
var
  ATextRect   : TRect;
  AColorRect  : TRect;
  AFocusRect  : TRect;
begin
  AFocusRect     := ARect;
  ATextRect      := ARect;

  AColorRect.Top    := ARect.Top    + 2;
  AColorRect.Bottom := ARect.Bottom - 2;
  AColorRect.Left   := ARect.Left   + 2;
  AColorRect.Right  := AColorRect.Left + AColorRect.Bottom - AColorRect.Top;

  ATextRect.Left := AColorRect.Right + 5;

  with Canvas do
    begin
      if odSelected in State then
        begin
          Brush.Style := bsSolid;
          Brush.Color := (Sender as TiLinkedListBox).SelectedColor;
          Pen.Style   := psSolid;
          Pen.Color   := Brush.Color;
          Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
          Font.Color := (Sender as TiLinkedListBox).SelectedFontColor;
        end;

      iDrawText(Canvas, AText, ATextRect, [itfVCenter, itfHLeft, itfSingleLine], True, clBtnFace);

      //------------------------------------------------------------------------------
      AText          := GetCouplingText(ScopeChannel[Index].Coupling);
      ATextRect.Left := AColorRect.Right + 5 + FMaxWidthTitle + 5 + FMaxWidthCoupling - TextWidth(AText);

      iDrawText(Canvas, AText, ATextRect, [itfVCenter, itfHLeft, itfSingleLine], True, clBtnFace);
      //------------------------------------------------------------------------------
      AText          := GetVoltsPerDivText(ScopeChannel[Index].VoltsPerDivision);
      ATextRect.Left := AColorRect.Right + 5 + FMaxWidthTitle + 5 + FMaxWidthCoupling + 5 + FMaxWidthVoltsPerDiv - TextWidth(AText);

      iDrawText(Canvas, AText, ATextRect, [itfVCenter, itfHLeft, itfSingleLine], True, clBtnFace);
      //------------------------------------------------------------------------------
      AText          := GetPositionText(ScopeChannel[Index].Position);
      ATextRect.Left := AColorRect.Right + 5 + FMaxWidthTitle + 5 + FMaxWidthCoupling + 5 + FMaxWidthVoltsPerDiv + 5 + FMaxWidthPosition - TextWidth(AText);

      iDrawText(Canvas, AText, ATextRect, [itfVCenter, itfHLeft, itfSingleLine], True, clBtnFace);
      //------------------------------------------------------------------------------
      Brush.Style := bsSolid;
      Brush.Color := TiScopeChannelAccess(ScopeChannel[Index]).Channel.Color;
      Pen.Style   := psSolid;
      Pen.Color   := Brush.Color;
      Rectangle(AColorRect.Left, AColorRect.Top, AColorRect.Right, AColorRect.Bottom);

      if odFocused in State then
        begin
          iDrawFocusRect(Canvas, AFocusRect, clNavy);
        end;
    end;

  Handled := True;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.Paint;
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
procedure TiScopePanelChannels.AddChannelData(Channel: Integer; Y: Double);
begin
  if not FBlockActive then raise Exception.Create('Error Adding Channel Data: Data Block not Active');
  TiScopeChannelAccess(FScopeChannelList.Objects[Channel]).AddData(Y);
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.DataBlockBegin;
begin
  if FBlockActive then raise Exception.Create('Begin Data Block Error: Data Block already Active');
  FBlockActive := True;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.DataBlockEnd;
begin
  if FBlockActive then
    begin
      FBlockActive := False;
      CheckForSynchronizedData;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.CheckForSynchronizedData;
begin
  if not DataBlockSynchronized then raise Exception.Create('End Data Block Error: All Channels must have the same Number of Data Elements');
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.GetDataBlockSynchronized: Boolean;
var
  ChannelIndex : Integer;
  RefCount     : Integer;
begin
  Result := True;
  if Count > 1 then
    begin
      RefCount := TiScopeChannelAccess(ScopeChannel[0]).RawData.Count;
      for ChannelIndex := 1 to Count-1 do
        if TiScopeChannelAccess(ScopeChannel[ChannelIndex]).RawData.Count <> RefCount then
          begin
            Result := False;
            Exit;
          end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.DataBlockClear;
var
  ChannelIndex : Integer;
begin
  for ChannelIndex := 0 to Count-1 do
    TiScopeChannelAccess(ScopeChannel[ChannelIndex]).RawData.Clear;
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.GetScopeChannel(Index: Integer): TiScopeChannel;
begin
  Result := FScopeChannelList.Objects[Index] as TiScopeChannel;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.ChannelListChange(Sender: TObject);
begin
  UpdateDisplay;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.UpdateDisplay;
begin
  if FChannelListDisplay.ItemIndex = -1 then
    begin
      FVoltageSelector.Enabled  := False;
      FPositionSelector.Enabled := False;
      FCouplingSelector.Enabled := False;
      FVisibleCheckBox.Enabled  := False;
      FRefLineCheckBox.Enabled  := False;
    end
  else
    begin
      FVoltageSelector.Enabled  := True;
      FPositionSelector.Enabled := True;
      FCouplingSelector.Enabled := True;
      FVisibleCheckBox.Enabled  := True;
      FRefLineCheckBox.Enabled  := True;

      FVoltageSelector.Value  := ScopeChannel[FChannelListDisplay.ItemIndex].VoltsPerDivision;
      FPositionSelector.Value := ScopeChannel[FChannelListDisplay.ItemIndex].Position;
      FCouplingSelector.Value :=(ord(ScopeChannel[FChannelListDisplay.ItemIndex].Coupling));
      FVisibleCheckBox.Checked := ScopeChannel[FChannelListDisplay.ItemIndex].TraceVisible;
      FRefLineCheckBox.Checked := ScopeChannel[FChannelListDisplay.ItemIndex].RefLineShow;

      //FChannelListDisplay.Invalidate;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.VoltageSelectorChange(Sender: TObject);
begin
  if FChannelListDisplay.ItemIndex = -1 then Exit;
  ScopeChannel[FChannelListDisplay.ItemIndex].VoltsPerDivision := FVoltageSelector.GetItemValue(FVoltageSelector.ItemIndex);
  FChannelListDisplay.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.PositionSelectorChange(Sender: TObject);
begin
  if FChannelListDisplay.ItemIndex = -1 then Exit;
  ScopeChannel[FChannelListDisplay.ItemIndex].Position := FPositionSelector.GetItemValue(FPositionSelector.ItemIndex);
  FChannelListDisplay.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.CouplingChange(Sender: TObject);
begin
  if FChannelListDisplay.ItemIndex = -1 then Exit;
  ScopeChannel[FChannelListDisplay.ItemIndex].Coupling := TiScopeChannelCoupling(Round(FCouplingSelector.GetItemValue(FCouplingSelector.ItemIndex)));
  FChannelListDisplay.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.VisibleClick(Sender: TObject);
begin
  if FChannelListDisplay.ItemIndex = -1 then Exit;
  ScopeChannel[FChannelListDisplay.ItemIndex].TraceVisible := FVisibleCheckBox.Checked;
  FChannelListDisplay.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.RefLineClick(Sender: TObject);
begin
  if FChannelListDisplay.ItemIndex = -1 then Exit;
  ScopeChannel[FChannelListDisplay.ItemIndex].RefLineShow := FRefLineCheckBox.Checked;
  FChannelListDisplay.Invalidate;
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.GetCount: Integer;
begin
  Result := FScopeChannelList.Count;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.AdjustAnnotations;
var
  x : Integer;
begin
  for x := 0 to Count-1 do
    begin
      TiScopeChannelAccess(ScopeChannel[x]).Annotation.X := X*20 + 3;
    end;
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.AddChannel: Integer;
var
  ScopeChannel : TiScopeChannel;
begin
  ScopeChannel := TiScopeChannel.Create;
  TiScopeChannelAccess(ScopeChannel).OnChange := ChannelChange;

  Result := FScopeChannelList.AddObject('', ScopeChannel);

  if Assigned(FScope) then
    with TiScopeChannelAccess(ScopeChannel) do
      begin                                           
        Channel              := TiScopeAccess(FScope as TiScope).Plot.Channel[TiScopeAccess(FScope as TiScope).Plot.AddChannel];
        Channel.DataStyle    := ipdsCompactInterval;
        Channel.PopupEnabled := False;

        Scope                 := FScope;
        Channel.TitleText     := 'CH' + IntToStr(FScopeChannelList.Count);
        YAxis                 := TiScopeAccess(FScope as TiScope).Plot.YAxis[TiScopeAccess(FScope as TiScope).Plot.AddYAxis];
        YAxis.Visible         := False;
        YAxis.TrackingEnabled := False;
        Channel.XAxisName     := TiScopeAccess(FScope as TiScope).Plot.XAxis[1].Name;

        Channel.YAxisName := YAxis.Name;

        Channel.XAxisTrackingEnabled := False;
        Channel.YAxisTrackingEnabled := False;

        Annotation         := TiScopeAccess(FScope as TiScope).Plot.Annotation[TiScopeAccess(FScope as TiScope).Plot.AddAnnotation];
        Annotation.Visible := TiScopeAccess(FScope as TiScope).Display.TextShow;
        Annotation.Text    := FVoltageSelector.GetItemCaptionByValue(VoltsPerDivision) + ' ' +
                              FCouplingSelector.GetItemCaptionByValue(ord(Coupling));

        RefLine := TiScopeAccess(FScope as TiScope).Plot.Limit[TiScopeAccess(FScope as TiScope).Plot.AddLimit];

        if FChannelListDisplay.ItemIndex = -1 then FChannelListDisplay.ItemIndex := 0;
        FChannelListDisplay.Invalidate;
      end;
  AdjustAnnotations;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.RemoveAllChannels;
begin
  while Count > 0 do
    DeleteChannel(0);
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.DeleteChannel(Index: Integer);
begin
  FScopeChannelList.Objects[Index].Free;
  FScopeChannelList.Delete(Index);
  ChannelListChange(Self);
  FChannelListDisplay.Invalidate;
  AdjustAnnotations;
end;
//****************************************************************************************************************************************************
procedure TiScopePanelChannels.ChannelChange(Sender: TObject);
begin
  UpdateDisplay;
  with TiScopeChannelAccess(Sender as TiScopeChannel) do
    begin
      Annotation.Text := FVoltageSelector.GetItemCaptionByValue(VoltsPerDivision) + ' ' + FCouplingSelector.GetItemCaptionByValue(ord(Coupling));
    end;
  FChannelListDisplay.Invalidate;
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.GetScopeChannelFromLimitIndex(Index: Integer): TiScopeChannel;
var
  x : Integer;
begin
  Result := nil;
  for x := 0 to Count-1 do
    if TiScopeChannelAccess(ScopeChannel[x]).RefLine = TiScopeAccess(FScope as TiScope).Plot.Limit[Index] then
      begin
        Result := ScopeChannel[x];
        Break;
      end;
end;
//****************************************************************************************************************************************************
function TiScopePanelChannels.GetScopeChannelFromAnnotation(Index: Integer): TiScopeChannel;
var
  x : Integer;
begin
  Result := nil;
  for x := 0 to Count-1 do
    if TiScopeChannelAccess(ScopeChannel[x]).Annotation = TiScopeAccess(FScope as TiScope).Plot.Annotation[Index] then
      begin
        Result := ScopeChannel[x];
        Break;
      end;
end;
//****************************************************************************************************************************************************
end.


