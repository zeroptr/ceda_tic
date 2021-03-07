{*******************************************************}
{                                                       }
{       TiScope Component                               }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScope;{$endif}
{$ifdef iCLX}unit QiScope;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  Printers,  iGPFunctions,  iComponent,  iPlot,  iPlotDataCursor,  iPlotAxis,  iPlotChannelCustom,  iPlotChannel,  iPlotAnnotation,{$ENDIF}
  {$IFDEF iCLX}QiTypes, QPrinters, QiGPFunctions, QiComponent, QiPlot, QiPlotDataCursor, QiPlotAxis, QiPlotChannelCustom, QiPlotChannel, QiPlotAnnotation,{$ENDIF}

  {$IFDEF iVCL} iScopeEditor,  iScopePanelTimeBase,  iScopePanelTrigger,  iScopePanelChannels,  iScopePanelToolBar,{$ENDIF}
  {$IFDEF iCLX}QiScopeEditor, QiScopePanelTimeBase, QiScopePanelTrigger, QiScopePanelChannels, QiScopePanelToolBar,{$ENDIF}

  {$IFDEF iVCL} iScopeChannel,  iScopeTimeBase,  iScopeTrigger,  iScopeToolBar,  iScopeDisplay;{$ENDIF}
  {$IFDEF iCLX}QiScopeChannel, QiScopeTimeBase, QiScopeTrigger, QiScopeToolBar, QiScopeDisplay;{$ENDIF}


type
  TiScope = class(TCustomControl)
  private
    FCreationComplete       : Boolean;

    FPlot                   : TiPlot;
    FPanelChannels          : TiScopePanelChannels;
    FPanelTimeBase          : TiScopePanelTimeBase;
    FPanelTrigger           : TiScopePanelTrigger;
    FPanelToolBar           : TiScopePanelToolBar;
    FDisplay                : TiScopeDisplay;

    FScopeEditor            : TiScopeEditorForm;

    FTransferringData       : Boolean;

    FTimeBase               : TiScopeTimeBase;
    FTrigger                : TiScopeTrigger;
    FToolBar                : TiScopeToolBar;

    FEditorControlPageIndex : Integer;
    FHideControlPanels      : Boolean;
 protected
    function GetAutoFrameRate    : Boolean;
    function GetUpdateFrameRate  : Integer;
    function GetPrintDocumentName: String;
    function GetPrinterName      : String;
    function GetPrintMarginBottom: Double;
    function GetPrintMarginLeft  : Double;
    function GetPrintMarginRight : Double;
    function GetPrintMarginTop   : Double;
    function GetPrintOrientation : TPrinterOrientation;
    function GetPrintShowDialog  : Boolean;
    function GetSamplesPerSecond : Integer;

    procedure SetAutoFrameRate    (const Value: Boolean);
    procedure SetUpdateFrameRate  (const Value: Integer);
    procedure SetPrintDocumentName(const Value: String);
    procedure SetPrinterName      (const Value: String);
    procedure SetPrintMarginBottom(const Value: Double);
    procedure SetPrintMarginLeft  (const Value: Double);
    procedure SetPrintMarginRight (const Value: Double);
    procedure SetPrintMarginTop   (const Value: Double);
    procedure SetPrintOrientation (const Value: TPrinterOrientation);
    procedure SetPrintShowDialog  (const Value: Boolean);
    procedure SetSamplesPerSecond (const Value: Integer);
    procedure SetHideControlPanels(const Value: Boolean);

    function GetChannel(Index: Integer): TiScopeChannel;
    function GetChannelCount           : Integer;
    function GetNeedPacketsNow         : Boolean;
    function GetDataBlockActive        : Boolean;
    function GetDataBlockSynchronized  : Boolean;
    function GetDataCursor             : TiPlotDataCursor;
    function GetTransferringActve      : Boolean;

    procedure DataCursorCustomizeHintEvent    (Index: Integer; var AText: String);
    procedure LimitLine1PositionChangeEvent   (Index: Integer; OldValue, NewValue : Double);
    procedure AnnotationCoordinatesChangeEvent(Index: Integer);
    procedure ClickAnnotationEvent            (Index: Integer);

    procedure Resize;  override;
    procedure AdjustLayout;
    procedure Loaded;                       override;

    procedure DefineProperties(Filer: TFiler); override;

    procedure ReadFromStreamChannels(Reader: TReader);
    procedure ReadFromStreamDisplay (Reader: TReader);
    procedure ReadFromStreamTimeBase(Reader: TReader);
    procedure ReadFromStreamTrigger (Reader: TReader);

    procedure WriteToStreamChannels (Writer: TWriter);
    procedure WriteToStreamDisplay  (Writer: TWriter);
    procedure WriteToStreamTimeBase (Writer: TWriter);
    procedure WriteToStreamTrigger  (Writer: TWriter);

    procedure DoEditClick(Sender: TObject);

    property PanelChannels : TiScopePanelChannels read FPanelChannels;
    property PanelTimeBase : TiScopePanelTimeBase read FPanelTimeBase;
    property PanelTrigger  : TiScopePanelTrigger  read FPanelTrigger;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure PrintDisplay;

    procedure DataBlockBegin;
    procedure DataBlockEnd;
    procedure DataBlockClear;

    procedure AddChannelData     (Channel: Integer; Y    : Double );
    procedure AddDataBlockChannel(Index  : Integer; Data : Variant);
    procedure AddDataBlock       (                  Data : Variant);

    function  AddChannel: Integer;
    procedure DeleteChannel(Index: Integer);
    procedure RemoveAllChannels;

    property Channel[Index: Integer] : TiScopeChannel      read GetChannel;
    property ChannelCount            : Integer             read GetChannelCount;

    property TimeBase                : TiScopeTimeBase     read FTimeBase;
    property Trigger                 : TiScopeTrigger      read FTrigger;
    property ToolBar                 : TiScopeToolBar      read FToolBar;
    property Display                 : TiScopeDisplay      read FDisplay;

    property DataCursor              : TiPlotDataCursor    read GetDataCursor;

    property TransferringActve       : Boolean             read GetTransferringActve;

    property DataBlockActive         : Boolean             read GetDataBlockActive;
    property DataBlockSynchronized   : Boolean             read GetDataBlockSynchronized;
    property NeedPacketsNow          : Boolean             read GetNeedPacketsNow;

    property Plot                    : TiPlot              read FPlot;
  published
    property Align;

    property SamplesPerSecond        : Integer             read GetSamplesPerSecond     write SetSamplesPerSecond;

    property AutoFrameRate           : Boolean             read GetAutoFrameRate        write SetAutoFrameRate      default True;
    property UpdateFrameRate         : Integer             read GetUpdateFrameRate      write SetUpdateFrameRate    default 20;

    property HideControlPanels       : Boolean             read FHideControlPanels      write SetHideControlPanels;

    property PrintOrientation        : TPrinterOrientation read GetPrintOrientation     write SetPrintOrientation   default poLandscape;
    property PrintMarginLeft         : Double              read GetPrintMarginLeft      write SetPrintMarginLeft;
    property PrintMarginTop          : Double              read GetPrintMarginTop       write SetPrintMarginTop;
    property PrintMarginRight        : Double              read GetPrintMarginRight     write SetPrintMarginRight;
    property PrintMarginBottom       : Double              read GetPrintMarginBottom    write SetPrintMarginBottom;
    property PrintShowDialog         : Boolean             read GetPrintShowDialog      write SetPrintShowDialog    default True;
    property PrintDocumentName       : String              read GetPrintDocumentName    write SetPrintDocumentName;
    property PrinterName             : String              read GetPrinterName          write SetPrinterName;

    property Visible;
    property Enabled;           
    property ShowHint;
    property PopupMenu;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnEnter;
    property OnExit;
  end;

implementation

type
  TiComponentAccess      = class(TiComponent     )end;
  TiPlotDataCursorAccess = class(TiPlotDataCursor)end;
  TiPlotAnnotationAccess = class(TiPlotAnnotation)end;
  TWriterAccess          = class(TWriter         )end;
  TReaderAccess          = class(TReader         )end;
  TiScopeChannelAccess   = class(TiScopeChannel  )end;
  TiScopeDisplayAccess   = class(TiScopeDisplay  )end;
//****************************************************************************************************************************************************
constructor TiScope.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csReplicatable, csOpaque, csAcceptsControls];

  Width   := 725;
  Height  := 310;

  FPlot := TiPlot.Create(Self);
  with FPlot do
    begin
      Parent := Self;
      RemoveAllChannels;

      DataView[0].GridLineColor := clTeal;
      DataView[0].Enabled       := False;

      XAxis[0].CartesianStyle   := ipcsMaster;
      XAxis[0].LabelsVisible    := False;
      XAxis[0].LabelSeparation  := 0;
      XAxis[0].DesiredIncrement := 0.1;
      XAxis[0].ScaleLinesColor  := DataView[0].GridLineColor;
      XAxis[0].MinorCount       := 4;
      XAxis[0].Enabled          := False;
      XAxis[0].Span             := 1;
      XAxis[0].TrackingEnabled  := False;

      YAxis[0].CartesianStyle   := ipcsMaster;
      YAxis[0].LabelsVisible    := False;
      YAxis[0].LabelSeparation  := 0;
      YAxis[0].DesiredIncrement := 12.5;
      YAxis[0].ScaleLinesColor  := DataView[0].GridLineColor;
      YAxis[0].MinorCount       := 4;
      YAxis[0].Enabled          := False;
      YAxis[0].TrackingEnabled  := False;

      ToolBar[0].Visible := False;
      ToolBar[0].DoButtonClickSelect;

      Legend [0].Visible := False;

      TitleVisible       := False;           

      AddXAxis;
      XAxis[1].Name                := 'TimeBase';
      XAxis[1].Visible             := False;
      XAxis[1].TrackingEnabled     := False;

      AddChannel;
      Channel[0].XAxisName := XAxis[0].Name;
      Channel[0].YAxisName := YAxis[0].Name;
      Channel[0].Visible   := False;

      AddAnnotation;
      Annotation[0].Style         := ipasRectangle;
      Annotation[0].Height        := 2;
      Annotation[0].X             := 0.5;
      Annotation[0].Width         := 1;
      Annotation[0].Y             := 3;
      Annotation[0].BrushStyle    := bsClear;
      Annotation[0].Reference     := iprtChannel;
      Annotation[0].ChannelName   := Channel[0].Name;
      Annotation[0].UserCanMove   := True;
      Annotation[0].ShowFocusRect := False;

      AddAnnotation;
      Annotation[1].Style         := ipasText;
      Annotation[1].X             := 90;
      Annotation[1].Y             := 7;
      Annotation[1].Reference     := iprtDataView;
      Annotation[1].Text          := 'Time';
      Annotation[1].Font.Style    := [fsBold];

      DataCursor[0].Color                    := clYellow;
      DataCursor[0].Style                    := ipcsInverseDeltaX;
      DataCursor[0].Pointer2Position         := 60;
      DataCursor[0].Pointer1Position         := 40;
      DataCursor[0].PointerPenWidth          := 3;
      DataCursor[0].ChannelAllowAll          := False;
      DataCursor[0].UserCanEdit              := False;
      DataCursor[0].MenuUserCanChangeOptions := False;
      DataCursor[0].MenuItemVisibleValueXY   := False;

      TiPlotDataCursorAccess(DataCursor[0]).ScopeStyle := True;

      OnDataCursorCustomizeHint     := DataCursorCustomizeHintEvent;
      OnLimitLine1PositionChange    := LimitLine1PositionChangeEvent;
      OnAnnotationCoordinatesChange := AnnotationCoordinatesChangeEvent;
      OnClickAnnotation             := ClickAnnotationEvent;

     UpdateFrameRate := 20;
    end;

  FPanelToolBar := TiScopePanelToolBar.Create(Self);
  with FPanelToolBar do
    begin
      Parent      := Self;
      Scope       := Self;
      OnEditClick := DoEditClick;
    end;

  FPanelChannels := TiScopePanelChannels.Create(Self);
  with FPanelChannels do
    begin
      Parent := Self;
      Scope  := Self;
    end;

  FPanelTrigger := TiScopePanelTrigger.Create(Self);
  with FPanelTrigger do
    begin
      Parent        := Self;
      PanelChannels := FPanelChannels;
      Level         := 50;
      Auto          := True;
    end;

  FPanelTimeBase := TiScopePanelTimeBase.Create(Self);
  with FPanelTimeBase do
    begin
      Parent             := Self;
      Scope              := Self;
      ScrollAnnotation   := FPlot.Annotation[0];
      DisplayAnnotation  := FPlot.Annotation[1];
      XAxis              := FPlot.XAxis[1];
      SamplesPerSecond   := 10 * 100 *200;
      SecPerDiv          := 0.001;
    end;

  FDisplay := TiScopeDisplay.Create;
  with TiScopeDisplayAccess(FDisplay) do
    begin
      Plot                 := FPlot;
      PanelChannels        := FPanelChannels;
      HorzScrollAnnotation := FPlot.Annotation[0];
      TimeBaseAnnotation   := FPlot.Annotation[1];

      GridColor            := $808000;
      TextShow             := False;
      HorzScrollShow       := False;
    end;

  FPanelTrigger.OnManualTrigger := FPanelTimeBase.DoManualTrigger;

  FTimeBase := TiScopeTimeBase.Create(FPanelTimeBase);
  FTrigger  := TiScopeTrigger.Create (FPanelTrigger);
  FToolBar  := TiScopeToolBar.Create (FPanelToolBar);

  AddChannel;

  FCreationComplete := True;
end;
//****************************************************************************************************************************************************
destructor TiScope.Destroy;
begin
  FTimeBase.Free;
  FTrigger.Free;
  FToolBar.Free;

  FPanelChannels.Free;
  FPanelTimeBase.Free;
  FPanelTrigger.Free;
  FPanelToolBar.Free;
  FDisplay.Free;

  FPlot.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiScope.Loaded;
begin
  inherited;
  AdjustLayout;
end;
//*************************************************************************************************************************************
procedure TiScope.SetHideControlPanels(const Value: Boolean);
begin
  if FHideControlPanels <> Value then
    begin
      FHideControlPanels := Value;

      AdjustLayout;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScope.AdjustLayout;
var
  MaxHeight : Integer;
begin
  if not FCreationComplete then Exit;

  if FHideControlPanels then
    begin
      FPanelChannels.Width := 0;
      FPanelTimeBase.Width := 0;
      FPanelTrigger.Width  := 0;
      FPanelToolBar.Width  := 0;

      FPlot.Left   := 0;
      FPlot.Top    := 0;
      FPlot.Height := Height;
      FPlot.Width  := Width;
    end
  else
    begin
      FPanelChannels.Width := 210;
      FPanelTimeBase.Width := 190;
      FPanelTrigger.Width  := 190;
      FPanelToolBar.Width  := 200;

      FPanelTimeBase.AdjustLayout;
      FPanelTrigger.AdjustLayout;

      MaxHeight := 0;
      if FPanelTimeBase.RequiredHeight > MaxHeight then MaxHeight := FPanelTimeBase.RequiredHeight;
      if FPanelTrigger.RequiredHeight  > MaxHeight then MaxHeight := FPanelTrigger.RequiredHeight;

      FPlot.Left   := 0;
      FPlot.Top    := 0;
      FPlot.Height := Height;
      FPlot.Width  := Width  - FPanelTimeBase.Width - FPanelTrigger.Width;

      FPanelToolBar.Left    := FPlot.Left + FPlot.Width;
      FPanelToolBar.Width   := Width - FPlot.Width;

      FPanelTimeBase.Top    := FPanelToolBar.Height;
      FPanelTimeBase.Left   := FPlot.Left + FPlot.Width;
      FPanelTimeBase.Height := MaxHeight;

      FPanelTrigger.Top     := FPanelToolBar.Height;
      FPanelTrigger.Left    := FPanelTimeBase.Left + FPanelTimeBase.Width;
      FPanelTrigger.Height  := MaxHeight;

      FPanelChannels.Top    := FPanelTimeBase.Top + FPanelTimeBase.Height-1;
      FPanelChannels.Left   := FPanelTimeBase.Left;
      FPanelChannels.Height := Height - FPanelToolBar.Height - MaxHeight;
      FPanelChannels.Width  := Width - FPanelChannels.Left;
    end;
end;
//****************************************************************************************************************************************************
procedure TiScope.Resize;
begin
  inherited Resize;
  AdjustLayout;
end;
//****************************************************************************************************************************************************
function TiScope.GetAutoFrameRate    : Boolean;            begin Result := FPlot.AutoFrameRate;            end;
function TiScope.GetUpdateFrameRate  : Integer;            begin Result := FPlot.UpdateFrameRate;          end;
function TiScope.GetPrintDocumentName: String;             begin Result := FPlot.PrintDocumentName;        end;
function TiScope.GetPrinterName      : String;             begin Result := FPlot.PrinterName;              end;
function TiScope.GetPrintMarginBottom: Double;             begin Result := FPlot.PrintMarginBottom;        end;
function TiScope.GetPrintMarginLeft  : Double;             begin Result := FPlot.PrintMarginLeft;          end;
function TiScope.GetPrintMarginRight : Double;             begin Result := FPlot.PrintMarginRight;         end;
function TiScope.GetPrintMarginTop   : Double;             begin Result := FPlot.PrintMarginTop;           end;
function TiScope.GetPrintOrientation : TPrinterOrientation;begin Result := FPlot.PrintOrientation;         end;
function TiScope.GetPrintShowDialog  : Boolean;            begin Result := FPlot.PrintShowDialog;          end;
function TiScope.GetSamplesPerSecond : Integer;            begin Result := FPanelTimeBase.SamplesPerSecond;end;
//****************************************************************************************************************************************************
procedure TiScope.SetAutoFrameRate    (const Value: Boolean);            begin FPlot.AutoFrameRate             := Value;end;
procedure TiScope.SetUpdateFrameRate  (const Value: Integer);            begin FPlot.UpdateFrameRate           := Value;end;
procedure TiScope.SetPrintDocumentName(const Value: String);             begin FPlot.PrintDocumentName         := Value;end;
procedure TiScope.SetPrinterName      (const Value: String);             begin FPlot.PrinterName               := Value;end;
procedure TiScope.SetPrintMarginBottom(const Value: Double);             begin FPlot.PrintMarginBottom         := Value;end;
procedure TiScope.SetPrintMarginLeft  (const Value: Double);             begin FPlot.PrintMarginLeft           := Value;end;
procedure TiScope.SetPrintMarginRight (const Value: Double);             begin FPlot.PrintMarginRight          := Value;end;
procedure TiScope.SetPrintMarginTop   (const Value: Double);             begin FPlot.PrintMarginTop            := Value;end;
procedure TiScope.SetPrintOrientation (const Value: TPrinterOrientation);begin FPlot.PrintOrientation          := Value;end;
procedure TiScope.SetPrintShowDialog  (const Value: Boolean);            begin FPlot.PrintShowDialog           := Value;end;
procedure TiScope.SetSamplesPerSecond (const Value: Integer);            begin FPanelTimeBase.SamplesPerSecond := Value;end;
//****************************************************************************************************************************************************
procedure TiScope.DataBlockBegin;
begin
  FPanelChannels.DataBlockBegin;
end;
//****************************************************************************************************************************************************
procedure TiScope.DataBlockEnd;
begin
  FTransferringData := True;
  try
    FPanelChannels.DataBlockEnd;
    FPanelTimeBase.DataBlockUpdate;
  finally
    FTransferringData := False;
  end;
end;
//*************************************************************************************************************************************
function TiScope.GetDataBlockSynchronized: Boolean;
begin
  Result := FPanelChannels.DataBlockSynchronized;
end;
//*************************************************************************************************************************************
procedure TiScope.DataBlockClear;
begin
  FPanelChannels.DataBlockClear;
end;
//*************************************************************************************************************************************
function TiScope.GetNeedPacketsNow: Boolean;
var
  ElapsedTime     : Double;
  Second          : Double;
  FrameTime       : Double;
begin
  if UpdateFrameRate <> 0 then
    begin
      ElapsedTime := Now - FPanelTimeBase.LastTransferTime;
      Second      := 1/(24*60*60);
      FrameTime   := (1/UpdateFrameRate)*Second;

      if ElapsedTime > FrameTime then
        Result := True
      else
        Result := False;
    end
  else Result := True;
end;
//*************************************************************************************************************************************
function TiScope.GetDataBlockActive: Boolean;
begin
  Result := FPanelChannels.DataBlockActive;
end;
//****************************************************************************************************************************************************
function TiScope.AddChannel: Integer;
begin
  Result := FPanelChannels.AddChannel;
                                         
  FPanelTrigger.SetupSourceSelector;

end;
//****************************************************************************************************************************************************
procedure TiScope.AddChannelData(Channel: Integer; Y: Double);
begin
  FPanelChannels.AddChannelData(Channel, Y);
end;
//****************************************************************************************************************************************************
procedure TiScope.AddDataBlock(Data: Variant);
var
  LowBoundDim1  : Integer;
  LowBoundDim2  : Integer;
  HighBoundDim1 : Integer;
  HighBoundDim2 : Integer;
  ChannelIndex  : Integer;
  DataIndex     : Integer;
begin
  if VarArrayDimCount(Data) <> 2 then raise Exception.Create('Add Data Block array must be 2 dimensional');

  LowBoundDim1  := VarArrayLowBound (Data, 1);
  LowBoundDim2  := VarArrayLowBound (Data, 2);
  HighBoundDim1 := VarArrayHighBound(Data, 1);
  HighBoundDim2 := VarArrayHighBound(Data, 2);

  for DataIndex := LowBoundDim2 to HighBoundDim2 do
    for ChannelIndex := LowBoundDim1 to HighBoundDim1 do
      AddChannelData(ChannelIndex, Data[ChannelIndex, DataIndex]);
end;
//*************************************************************************************************************************************
procedure TiScope.AddDataBlockChannel(Index: Integer; Data: Variant);
var
  LowBound   : Integer;
  HighBound  : Integer;
  DataIndex  : Integer;
begin
  if VarArrayDimCount(Data) <> 1 then raise Exception.Create('Add Data Block Channel array must be 1 dimensional');

  LowBound  := VarArrayLowBound (Data, 1);
  HighBound := VarArrayHighBound(Data, 1);

  for DataIndex := LowBound to HighBound do
    AddChannelData(Index, Data[DataIndex]);
end;
//****************************************************************************************************************************************************
function TiScope.GetChannel(Index: Integer): TiScopeChannel;
begin
  Result := FPanelChannels.ScopeChannel[Index];
end;
//****************************************************************************************************************************************************
function TiScope.GetChannelCount: Integer;
begin
  Result := FPanelChannels.Count;
end;
//****************************************************************************************************************************************************
procedure TiScope.RemoveAllChannels;
begin
  FPanelChannels.RemoveAllChannels;
  FPlot.ClearAllData;
  TiComponentAccess(FPlot).InvalidateNow;
end;
//****************************************************************************************************************************************************
procedure TiScope.DeleteChannel(Index: Integer);
begin
  FPanelChannels.DeleteChannel(Index);
  FPlot.ClearAllData;
  TiComponentAccess(FPlot).InvalidateNow;
end;
//****************************************************************************************************************************************************
procedure TiScope.DoEditClick(Sender: TObject);
var
  x : Integer;
begin
  FScopeEditor := TiScopeEditorForm.Create(Application);
  try
    with FScopeEditor do
      begin
        Scope := Self;
        Left := Screen.Width  div 2 - Width  div 2;
        Top  := Screen.Height div 2 - Height div 2;

        SetActivePageIndex(ControlPageControl, FEditorControlPageIndex);

        ChannelVoltsPerDivSpinSelector.AssignItems(FPanelChannels.VoltageSelector);
        ChannelPositionSpinSelector.AssignItems   (FPanelChannels.PositionSelector);
        ChannelCouplingSpinSelector.AssignItems   (FPanelChannels.CouplingSelector);

        TimeBaseSecPerDivSpinSelector.AssignItems  (FPanelTimeBase.SecPerDivSelector);
        TimeBasePositionSpinSelector.AssignItems   (FPanelTimeBase.PositionSelector);
        TimeBasePreCaptureSpinSelector.AssignItems (FPanelTimeBase.PreCaptureSelector);
        TimeBasePostCaptureSpinSelector.AssignItems(FPanelTimeBase.PostCaptureSelector);

        TriggerLevelSpinSelector.AssignItems(FPanelTrigger.LevelSelector);
        TriggerSourceSpinSelector.AssignItems(FPanelTrigger.SourceSelector);

        PageControl.ActivePage := ControlTabSheet;

        SamplesPerSecondEdit.AsInteger          := SamplesPerSecond;

        UpdateFrameRateEdit.AsInteger           := UpdateFrameRate;
        AutoFrameRateCheckBox.AsBoolean         := AutoFrameRate;

        PrintOrientationRadioGroup.AsInteger    := Ord(PrintOrientation);
        PrintShowDialogCheckBox.AsBoolean       := PrintShowDialog;
        PrintMarginLeftEdit.AsFloat             := PrintMarginLeft;
        PrintMarginTopEdit.AsFloat              := PrintMarginTop;
        PrintMarginRightEdit.AsFloat            := PrintMarginRight;
        PrintMarginBottomEdit.AsFloat           := PrintMarginBottom;
        PrintDocumentNameEdit.AsString          := PrintDocumentName;
                                                                          
        DisplayGridColorPicker.Color            := FDisplay.GridColor;
        DisplayTextShowCheckBox.AsBoolean       := FDisplay.TextShow;
        DisplayHorzScrollShowCheckBox.AsBoolean := FDisplay.HorzScrollShow;

        TimeBaseSecPerDivSpinSelector.Value     := FPanelTimeBase.SecPerDiv;
        TimeBasePositionSpinSelector.Value      := FPanelTimeBase.Position;
        TimeBasePreCaptureSpinSelector.Value    := FPanelTimeBase.PreCapture;
        TimeBasePostCaptureSpinSelector.Value   := FPanelTimeBase.PostCapture;

        TriggerLevelSpinSelector.Value          := FPanelTrigger.Level;
        TriggerSourceSpinSelector.Value         := FPanelTrigger.SourceIndex;
        TriggerPositiveSlopeCheckBox.AsBoolean  := FPanelTrigger.PositiveSlope;
        TriggerAutoCheckBox.AsBoolean           := FPanelTrigger.Auto;

        for x := 0 to ChannelCount - 1 do
          begin
            iChannelListBox.Items.AddObject('', Channel[x]);
          end;

        if iChannelListBox.Items.Count <> 0 then iChannelListBox.ItemIndex := 0;

        UpdateAll;
        ShowModal;

        FEditorControlPageIndex := GetActivePageIndex(ControlPageControl);
      end;
  finally
    FScopeEditor.Free;
  end;
  FScopeEditor := nil;
end;
//****************************************************************************************************************************************************
procedure TiScope.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Channels', ReadFromStreamChannels, WriteToStreamChannels, ChannelCount <> 0);
  Filer.DefineProperty('Display',  ReadFromStreamDisplay,  WriteToStreamDisplay,  True);
  Filer.DefineProperty('TimeBase', ReadFromStreamTimeBase, WriteToStreamTimeBase, True);
  Filer.DefineProperty('Trigger',  ReadFromStreamTrigger,  WriteToStreamTrigger,  True);
end;
//*************************************************************************************************************************************
procedure TiScope.ReadFromStreamChannels(Reader: TReader);
var
  Item : TiScopeChannel;
begin
  RemoveAllChannels;
  if not Reader.EndOfList then RemoveAllChannels;
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Item := Channel[AddChannel];
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(Item);
    Reader.ReadListEnd;
  end;
  Reader.ReadListEnd;
end;
//*************************************************************************************************************************************
procedure TiScope.WriteToStreamChannels(Writer: TWriter);
var
  x : Integer;
begin
  TWriterAccess(Writer).WriteValue(vaCollection);
  for x := 0 to ChannelCount - 1 do
  begin
    Writer.WriteListBegin;
    WriterWriteProperties(Writer, Channel[x]);
    Writer.WriteListEnd;
  end;
  Writer.WriteListEnd;
end;
//*************************************************************************************************************************************
procedure TiScope.ReadFromStreamTimeBase(Reader: TReader);
begin
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(FTimeBase);
    Reader.ReadListEnd;
  end;
  Reader.ReadListEnd;
end;
//*************************************************************************************************************************************
procedure TiScope.WriteToStreamTimeBase(Writer: TWriter);
begin
  TWriterAccess(Writer).WriteValue(vaCollection);

  Writer.WriteListBegin;
  WriterWriteProperties(Writer, FTimeBase);
  Writer.WriteListEnd;

  Writer.WriteListEnd;
end;
//*************************************************************************************************************************************
procedure TiScope.ReadFromStreamTrigger(Reader: TReader);
begin
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(FTrigger);
    Reader.ReadListEnd;
  end;
  Reader.ReadListEnd;
end;
//*************************************************************************************************************************************
procedure TiScope.WriteToStreamTrigger(Writer: TWriter);
begin
  TWriterAccess(Writer).WriteValue(vaCollection);

  Writer.WriteListBegin;
  WriterWriteProperties(Writer, FTrigger);
  Writer.WriteListEnd;

  Writer.WriteListEnd;
end;
//*************************************************************************************************************************************
procedure TiScope.ReadFromStreamDisplay(Reader: TReader);
begin
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(FDisplay);
    Reader.ReadListEnd;
  end;
  Reader.ReadListEnd;
end;
//*************************************************************************************************************************************
procedure TiScope.WriteToStreamDisplay(Writer: TWriter);
begin
  TWriterAccess(Writer).WriteValue(vaCollection);

  Writer.WriteListBegin;
  WriterWriteProperties(Writer, FDisplay);
  Writer.WriteListEnd;

  Writer.WriteListEnd;
end;
//*************************************************************************************************************************************
procedure TiScope.DataCursorCustomizeHintEvent(Index: Integer; var AText: String);
var
  Value : Double;
begin
  case FPlot.DataCursor[0].Style of
    ipcsValueY,
    ipcsDeltaY        : begin
                          Value := FPlot.DataCursor[0].ValueY;


                               if (ABS(Value) < 1E+3 ) and (ABS(Value) >= 1E+2 ) then AText := FormatFloat('0',    Value*1E0 ) + ' V'
                          else if (ABS(Value) < 1E+2 ) and (ABS(Value) >= 1E+1 ) then AText := FormatFloat('0.0',  Value*1E0 ) + ' V'
                          else if (ABS(Value) < 1E+1 ) and (ABS(Value) >= 1E+0 ) then AText := FormatFloat('0.00', Value*1E0 ) + ' V'

                          else if (ABS(Value) < 1E-0 ) and (ABS(Value) >= 1E-1 ) then AText := FormatFloat('0',    Value*1E3 ) + ' mV'
                          else if (ABS(Value) < 1E-1 ) and (ABS(Value) >= 1E-2 ) then AText := FormatFloat('0.0',  Value*1E3 ) + ' mV'
                          else if (ABS(Value) < 1E-2 ) and (ABS(Value) >= 1E-3 ) then AText := FormatFloat('0.00', Value*1E3 ) + ' mV'

                          else if (ABS(Value) < 1E-3 ) and (ABS(Value) >= 1E-4 ) then AText := FormatFloat('0',    Value*1E6 ) + ' µV'
                          else if (ABS(Value) < 1E-4 ) and (ABS(Value) >= 1E-5 ) then AText := FormatFloat('0.0',  Value*1E6 ) + ' µV'
                          else if (ABS(Value) < 1E-5 ) and (ABS(Value) >= 1E-6 ) then AText := FormatFloat('0.00', Value*1E6 ) + ' µV'

                          else if (ABS(Value) < 1E-6 ) and (ABS(Value) >= 1E-7 ) then AText := FormatFloat('0',    Value*1E9 ) + ' nV'
                          else if (ABS(Value) < 1E-7 ) and (ABS(Value) >= 1E-8 ) then AText := FormatFloat('0.0',  Value*1E9 ) + ' nV'
                          else if (ABS(Value) < 1E-8 ) and (ABS(Value) >= 1E-9 ) then AText := FormatFloat('0.00', Value*1E9 ) + ' nV'
                          else AText := AText + ' V';
                        end;

    ipcsValueX,
    ipcsDeltaX        : begin
                          Value := FPlot.DataCursor[0].ValueX;

                               if (Value = 1E0 )  or  (Value = 0     ) then AText := FormatFloat('0',    Value     ) + ' s'

                          else if (Value < 1E-0 ) and (Value >= 1E-1 ) then AText := FormatFloat('0',    Value*1E3 ) + ' ms'
                          else if (Value < 1E-1 ) and (Value >= 1E-2 ) then AText := FormatFloat('0.0',  Value*1E3 ) + ' ms'
                          else if (Value < 1E-2 ) and (Value >= 1E-3 ) then AText := FormatFloat('0.00', Value*1E3 ) + ' ms'

                          else if (Value < 1E-3 ) and (Value >= 1E-4 ) then AText := FormatFloat('0',    Value*1E6 ) + ' µs'
                          else if (Value < 1E-4 ) and (Value >= 1E-5 ) then AText := FormatFloat('0.0',  Value*1E6 ) + ' µs'
                          else if (Value < 1E-5 ) and (Value >= 1E-6 ) then AText := FormatFloat('0.00', Value*1E6 ) + ' µs'

                          else if (Value < 1E-6 ) and (Value >= 1E-7 ) then AText := FormatFloat('0',    Value*1E9 ) + ' ns'
                          else if (Value < 1E-7 ) and (Value >= 1E-8 ) then AText := FormatFloat('0.0',  Value*1E9 ) + ' ns'
                          else if (Value < 1E-8 ) and (Value >= 1E-9 ) then AText := FormatFloat('0.00', Value*1E9 ) + ' ns'

                          else if (Value < 1E-9 ) and (Value >= 1E-10) then AText := FormatFloat('0',    Value*1E12) + ' ps'
                          else if (Value < 1E-10) and (Value >= 1E-11) then AText := FormatFloat('0.0',  Value*1E12) + ' ps'
                          else if (Value < 1E-11) and (Value >= 1E-12) then AText := FormatFloat('0.00', Value*1E12) + ' ps'
                          else AText := AText + ' s';
                        end;

    ipcsInverseDeltaX : begin
                          Value := FPlot.DataCursor[0].ValueX;

                               if (Value >= 1E0 ) and (Value < 1E1 ) then AText := FormatFloat('0.00', Value    ) + ' Hz'
                          else if (Value >= 1E1 ) and (Value < 1E2 ) then AText := FormatFloat('0.0',  Value    ) + ' Hz'
                          else if (Value >= 1E2 ) and (Value < 1E3 ) then AText := FormatFloat('0',    Value    ) + ' Hz'

                          else if (Value >= 1E3 ) and (Value < 1E4 ) then AText := FormatFloat('0.00', Value/1E3) + ' KHz'
                          else if (Value >= 1E4 ) and (Value < 1E5 ) then AText := FormatFloat('0.0',  Value/1E3) + ' KHz'
                          else if (Value >= 1E5 ) and (Value < 1E6 ) then AText := FormatFloat('0',    Value/1E3) + ' KHz'

                          else if (Value >= 1E6 ) and (Value < 1E7 ) then AText := FormatFloat('0.00', Value/1E6) + ' MHz'
                          else if (Value >= 1E7 ) and (Value < 1E8 ) then AText := FormatFloat('0.0',  Value/1E6) + ' MHz'
                          else if (Value >= 1E8 ) and (Value < 1E9 ) then AText := FormatFloat('0',    Value/1E6) + ' MHz'

                          else if (Value >= 1E9 ) and (Value < 1E10) then AText := FormatFloat('0.00', Value/1E9) + ' GHz'
                          else if (Value >= 1E10) and (Value < 1E11) then AText := FormatFloat('0.0',  Value/1E9) + ' GHz'
                          else if (Value >= 1E11) and (Value < 1E12) then AText := FormatFloat('0',    Value/1E9) + ' GHz';
                        end;
  end;
end;
//*************************************************************************************************************************************
procedure TiScope.PrintDisplay;
begin
  FPlot.PrintChart;
end;
//*************************************************************************************************************************************
procedure TiScope.LimitLine1PositionChangeEvent(Index: Integer; OldValue, NewValue: Double);
var
  AScopeChannel : TiScopeChannel;
begin
  if FPlot.Limit[Index].Line1Position > 150 then FPlot.Limit[Index].Line1Position := 150;
  if FPlot.Limit[Index].Line1Position < -50 then FPlot.Limit[Index].Line1Position := -50;

  AScopeChannel := FPanelChannels.GetScopeChannelFromLimitIndex(Index);
  if Assigned(AScopeChannel) then TiScopeChannelAccess(AScopeChannel).RefLimitLineChange(FPlot.Limit[Index].Line1Position);
end;
//*************************************************************************************************************************************
function TiScope.GetTransferringActve: Boolean;
begin
                               Result := False;
  if FPlot.PaintingActive then Result := True;
end;
//*************************************************************************************************************************************
procedure TiScope.AnnotationCoordinatesChangeEvent(Index: Integer);
begin
  if FPlot.Annotation[Index] = FPanelTimeBase.ScrollAnnotation then
    begin
      FPanelTimeBase.ScrollAnnotation.Y := 3;
      if FPanelTimeBase.ScrollAnnotation.X < -0.0 then FPanelTimeBase.ScrollAnnotation.X := -0.0;
      if FPanelTimeBase.ScrollAnnotation.X >  1.0 then FPanelTimeBase.ScrollAnnotation.X :=  1.0;
      FPanelTimeBase.ScrollEvent;
    end;
end;
//*************************************************************************************************************************************
procedure TiScope.ClickAnnotationEvent(Index: Integer);
var
  AScopeChannel : TiScopeChannel;
begin
  if not FPlot.DataCursor[0].Visible then Exit;

  AScopeChannel := FPanelChannels.GetScopeChannelFromAnnotation(Index);
  if Assigned(AScopeChannel) then
    FPlot.DataCursor[0].ChannelName := TiScopeChannelAccess(AScopeChannel).Channel.Name;
end;
//*************************************************************************************************************************************
function TiScope.GetDataCursor: TiPlotDataCursor;
begin
  Result := FPlot.DataCursor[0];
end;
//*************************************************************************************************************************************
end.


