{*******************************************************}
{                                                       }
{       TiPipeJointComponentEditor                      }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iScopeComponentEditor;{$endif}
{$ifdef iCLX}unit QiScopeComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  Printers,  iTypes,  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iScope,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QPrinters, QiTypes, QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiScope,{$ENDIF}

  {$IFDEF iVCL} iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iAboutPanel,  iSpinSelector,  iComponent,  iVCLComponent,  iScopeChannel,
  iRadioGroup, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiAboutPanel, QiSpinSelector, QiComponent, QiCLXComponent, QiScopeChannel;{$ENDIF}

type
  TiScopeComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    ControlTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    iAboutPanel1: TiAboutPanel;
    ChannelsTabSheet: TTabSheet;
    TimeBaseTabSheet: TTabSheet;
    TriggerTabSheet: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    TriggerLevelSpinSelector: TiSpinSelector;
    TriggerSourceSpinSelector: TiSpinSelector;
    TriggerPositiveSlopeCheckBox: TiComponentEditorCheckBox;
    TriggerAutoCheckBox: TiComponentEditorCheckBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    TimeBaseSecPerDivSpinSelector: TiSpinSelector;
    TimeBasePositionSpinSelector: TiSpinSelector;
    TimeBasePreCaptureSpinSelector: TiSpinSelector;
    TimeBasePostCaptureSpinSelector: TiSpinSelector;
    iChannelListBox: TiComponentEditorListBox;
    iChannelAddButton: TButton;
    ChannelRemoveButton: TButton;
    ChannelPageControl: TiComponentEditorPageControl;
    ChannelGeneralTabSheet: TTabSheet;
    ControlPageControl: TiComponentEditorPageControl;
    ControlGeneralTabSheet: TTabSheet;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    Label2: TLabel;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    SamplesPerSecondEdit: TiComponentEditorEdit;
    ControlPrintTabSheet: TTabSheet;
    Label175: TLabel;
    PrinterMarginGroupBox: TGroupBox;
    PrintMarginLeftEdit: TiComponentEditorEdit;
    PrintMarginTopEdit: TiComponentEditorEdit;
    PrintMarginBottomEdit: TiComponentEditorEdit;
    PrintMarginRightEdit: TiComponentEditorEdit;
    PrintOrientationRadioGroup: TiComponentEditorRadioGroup;
    PrintShowDialogCheckBox: TiComponentEditorCheckBox;
    PrintDocumentNameEdit: TiComponentEditorEdit;
    HideControlPanelsCheckBox: TiComponentEditorCheckBox;
    Label4: TLabel;
    Label6: TLabel;
    Label208: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    ChannelColorPicker: TiComponentEditorColorPicker;
    ChannelTitleEdit: TiComponentEditorEdit;
    ChannelTraceGroupBox: TGroupBox;
    Label5: TLabel;
    ChannelTraceLineWidthUpDown: TiUpDown;
    ChannelTraceLineWidthEdit: TiComponentEditorEdit;
    ChannelTraceVisibleCheckBox: TiComponentEditorCheckBox;
    ChannelVoltsPerDivSpinSelector: TiSpinSelector;
    ChannelPositionSpinSelector: TiSpinSelector;
    ChannelCouplingSpinSelector: TiSpinSelector;
    ChannelRefLineShowCheckBox: TiComponentEditorCheckBox;
    ChannelScalerGroupBox: TiComponentEditorGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    ChannelScalerMultiplierEdit: TiComponentEditorEdit;
    ChannelScalerOffsetEdit: TiComponentEditorEdit;
    DisplayTabSheet: TTabSheet;
    Label1: TLabel;
    DisplayGridColorPicker: TiComponentEditorColorPicker;
    DisplayTextShowCheckBox: TiComponentEditorCheckBox;
    DisplayHorzScrollShowCheckBox: TiComponentEditorCheckBox;
    procedure iChannelListBoxClick(Sender: TObject);
    procedure iChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure ChannelChange(Sender: TObject);
    procedure iChannelAddButtonClick(Sender: TObject);
    procedure ChannelRemoveButtonClick(Sender: TObject);
  private
    FLastChannelIndex : Integer;

    procedure ClearAllChannels;
    procedure UpdateChannelEdit;
    procedure ReloadTriggerChannelList;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iScopeComponentEditorForm: TiScopeComponentEditorForm;

implementation

type
  TiScopeAccess = class(TiScope)end;
{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.CreateThemeInstance;
begin
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  x             : Integer;
  iScope        : TiScope;
  iScopeChannel : TiScopeChannel;
begin
  iScope := Component as TiScope;

  ChannelVoltsPerDivSpinSelector.AssignItems(TiScopeAccess(iScope).PanelChannels.VoltageSelector);
  ChannelPositionSpinSelector.AssignItems   (TiScopeAccess(iScope).PanelChannels.PositionSelector);
  ChannelCouplingSpinSelector.AssignItems   (TiScopeAccess(iScope).PanelChannels.CouplingSelector);

  TimeBaseSecPerDivSpinSelector.AssignItems  (TiScopeAccess(iScope).PanelTimeBase.SecPerDivSelector);
  TimeBasePositionSpinSelector.AssignItems   (TiScopeAccess(iScope).PanelTimeBase.PositionSelector);
  TimeBasePreCaptureSpinSelector.AssignItems (TiScopeAccess(iScope).PanelTimeBase.PreCaptureSelector);
  TimeBasePostCaptureSpinSelector.AssignItems(TiScopeAccess(iScope).PanelTimeBase.PostCaptureSelector);

  TriggerLevelSpinSelector.AssignItems (TiScopeAccess(iScope).PanelTrigger.LevelSelector);
  TriggerSourceSpinSelector.AssignItems(TiScopeAccess(iScope).PanelTrigger.SourceSelector);
  //--------------------------------------------------------------------------------------------------
  SamplesPerSecondEdit.AsInteger          := iScope.SamplesPerSecond;
  HideControlPanelsCheckBox.AsBoolean     := iScope.HideControlPanels;
  UpdateFrameRateEdit.AsInteger           := iScope.UpdateFrameRate;
  AutoFrameRateCheckBox.AsBoolean         := iScope.AutoFrameRate;

  PrintOrientationRadioGroup.AsInteger    := Ord(iScope.PrintOrientation);
  PrintShowDialogCheckBox.AsBoolean       := iScope.PrintShowDialog;
  PrintMarginLeftEdit.AsFloat             := iScope.PrintMarginLeft;
  PrintMarginTopEdit.AsFloat              := iScope.PrintMarginTop;
  PrintMarginRightEdit.AsFloat            := iScope.PrintMarginRight;
  PrintMarginBottomEdit.AsFloat           := iScope.PrintMarginBottom;
  PrintDocumentNameEdit.AsString          := iScope.PrintDocumentName;

  DisplayTextShowCheckBox.AsBoolean       := iScope.Display.TextShow;
  DisplayHorzScrollShowCheckBox.AsBoolean := iScope.Display.HorzScrollShow;
  DisplayGridColorPicker.Color            := iScope.Display.GridColor;

  TimeBaseSecPerDivSpinSelector.Value     := iScope.TimeBase.SecPerDiv;
  TimeBasePositionSpinSelector.Value      := iScope.TimeBase.Position;
  TimeBasePreCaptureSpinSelector.Value    := iScope.TimeBase.PreCapture;
  TimeBasePostCaptureSpinSelector.Value   := iScope.TimeBase.PostCapture;

  TriggerLevelSpinSelector.Value          := iScope.Trigger.Level;
  TriggerSourceSpinSelector.Value         := iScope.Trigger.SourceIndex;
  TriggerPositiveSlopeCheckBox.AsBoolean  := iScope.Trigger.PositiveSlope;
  TriggerAutoCheckBox.AsBoolean           := iScope.Trigger.Auto;

  ClearAllChannels;
  for x := 0 to iScope.ChannelCount -1 do
    begin
      iScopeChannel := TiScopeChannel.Create;
      iChannelListBox.Items.AddObject('', iScopeChannel);

      iScopeChannel.VoltsPerDivision := iScope.Channel[x].VoltsPerDivision;
      iScopeChannel.Position         := iScope.Channel[x].Position;
      iScopeChannel.Coupling         := iScope.Channel[x].Coupling;
      iScopeChannel.TitleText        := iScope.Channel[x].TitleText;
      iScopeChannel.Color            := iScope.Channel[x].Color;
      iScopeChannel.RefLineShow      := iScope.Channel[x].RefLineShow;
      iScopeChannel.TraceVisible     := iScope.Channel[x].TraceVisible;
      iScopeChannel.TraceLineWidth   := iScope.Channel[x].TraceLineWidth;
      iScopeChannel.ScalerMultiplier := iScope.Channel[x].ScalerMultiplier;
      iScopeChannel.ScalerOffset     := iScope.Channel[x].ScalerOffset;
    end;

  if iChannelListBox.Items.Count > FLastChannelIndex then iChannelListBox.ItemIndex := FLastChannelIndex;

  UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iScope : TiScope;
  x      : Integer;
begin
  iScope := Component as TiScope;

  iScope.SamplesPerSecond := SamplesPerSecondEdit.AsInteger;

  iScope.HideControlPanels       := HideControlPanelsCheckBox.AsBoolean;
  iScope.UpdateFrameRate         := UpdateFrameRateEdit.AsInteger;
  iScope.AutoFrameRate           := AutoFrameRateCheckBox.AsBoolean;

  iScope.PrintOrientation        := TPrinterOrientation(PrintOrientationRadioGroup.AsInteger);
  iScope.PrintShowDialog         := PrintShowDialogCheckBox.AsBoolean;
  iScope.PrintMarginLeft         := PrintMarginLeftEdit.AsFloat;
  iScope.PrintMarginTop          := PrintMarginTopEdit.AsFloat;
  iScope.PrintMarginRight        := PrintMarginRightEdit.AsFloat;
  iScope.PrintMarginBottom       := PrintMarginBottomEdit.AsFloat;
  iScope.PrintDocumentName       := PrintDocumentNameEdit.AsString;

  iScope.Display.TextShow        := DisplayTextShowCheckBox.AsBoolean;
  iScope.Display.HorzScrollShow  := DisplayHorzScrollShowCheckBox.AsBoolean;
  iScope.Display.GridColor       := DisplayGridColorPicker.Color;

  iScope.TimeBase.SecPerDiv      := TimeBaseSecPerDivSpinSelector.Value;
  iScope.TimeBase.Position       := TimeBasePositionSpinSelector.Value;
  iScope.TimeBase.PreCapture     := TimeBasePreCaptureSpinSelector.Value;
  iScope.TimeBase.PostCapture    := TimeBasePostCaptureSpinSelector.Value;

  iScope.Trigger.Level           := TriggerLevelSpinSelector.Value;
  iScope.Trigger.SourceIndex     := TriggerSourceSpinSelector.ItemIndex;
  iScope.Trigger.PositiveSlope   := TriggerPositiveSlopeCheckBox.AsBoolean;
  iScope.Trigger.Auto            := TriggerAutoCheckBox.AsBoolean;

  iScope.RemoveAllChannels;
  for x := 0 to iChannelListBox.Items.Count-1 do
    begin
      iScope.AddChannel;
      iScope.Channel[iScope.ChannelCount-1].VoltsPerDivision := (iChannelListBox.Items.Objects[x] as TiScopeChannel).VoltsPerDivision;
      iScope.Channel[iScope.ChannelCount-1].Position         := (iChannelListBox.Items.Objects[x] as TiScopeChannel).Position;
      iScope.Channel[iScope.ChannelCount-1].Coupling         := (iChannelListBox.Items.Objects[x] as TiScopeChannel).Coupling;
      iScope.Channel[iScope.ChannelCount-1].TitleText        := (iChannelListBox.Items.Objects[x] as TiScopeChannel).TitleText;
      iScope.Channel[iScope.ChannelCount-1].Color            := (iChannelListBox.Items.Objects[x] as TiScopeChannel).Color;
      iScope.Channel[iScope.ChannelCount-1].RefLineShow      := (iChannelListBox.Items.Objects[x] as TiScopeChannel).RefLineShow;
      iScope.Channel[iScope.ChannelCount-1].TraceVisible     := (iChannelListBox.Items.Objects[x] as TiScopeChannel).TraceVisible;
      iScope.Channel[iScope.ChannelCount-1].TraceLineWidth   := (iChannelListBox.Items.Objects[x] as TiScopeChannel).TraceLineWidth;
      iScope.Channel[iScope.ChannelCount-1].ScalerMultiplier := (iChannelListBox.Items.Objects[x] as TiScopeChannel).ScalerMultiplier;
      iScope.Channel[iScope.ChannelCount-1].ScalerOffset     := (iChannelListBox.Items.Objects[x] as TiScopeChannel).ScalerOffset;
    end;

  FLastChannelIndex  := iChannelListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.ClearAllChannels;
begin
  while iChannelListBox.Items.Count <> 0 do
    begin
      iChannelListBox.Items.Objects[0].Free;
      iChannelListBox.Items.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.iChannelListBoxClick(Sender: TObject);
begin
  UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.iChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (iChannelListBox.Items.Objects[Index] as TiScopeChannel).Color;
  AText  := (iChannelListBox.Items.Objects[Index] as TiScopeChannel).TitleText;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.UpdateChannelEdit;
var
  Channel : TiScopeChannel;
begin
  if iChannelListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Channel')
    else
      begin
        EnableAllEditControlsStartingWith('Channel');

        Channel := iChannelListBox.Items.Objects[iChannelListBox.ItemIndex] as TiScopeChannel;

        ChannelTitleEdit.AsString                := Channel.TitleText;
        ChannelColorPicker.Color                 := Channel.Color;
        ChannelRefLineShowCheckBox.AsBoolean     := Channel.RefLineShow;

        ChannelTraceVisibleCheckBox.AsBoolean    := Channel.TraceVisible;
        ChannelTraceLineWidthEdit.AsInteger      := Channel.TraceLineWidth;

        ChannelScalerMultiplierEdit.AsFloat      := Channel.ScalerMultiplier;
        ChannelScalerOffsetEdit.AsFloat          := Channel.ScalerOffset;

        ChannelVoltsPerDivSpinSelector.Value     := Channel.VoltsPerDivision;
        ChannelPositionSpinSelector.Value        := Channel.Position;

        ChannelCouplingSpinSelector.Value        := ord(Channel.Coupling);

        iChannelListBox.Invalidate;
      end;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.ChannelChange(Sender: TObject);
var
  Channel : TiScopeChannel;
begin
  if iChannelListBox.ItemIndex = -1 then exit;

  Channel := iChannelListBox.Items.Objects[iChannelListBox.ItemIndex] as TiScopeChannel;

   Channel.TitleText        := ChannelTitleEdit.AsString;
   Channel.Color            := ChannelColorPicker.Color;
   Channel.RefLineShow      := ChannelRefLineShowCheckBox.AsBoolean;

   Channel.TraceVisible     := ChannelTraceVisibleCheckBox.AsBoolean;
   Channel.TraceLineWidth   := ChannelTraceLineWidthEdit.AsInteger;

   Channel.ScalerMultiplier := ChannelScalerMultiplierEdit.AsFloat;
   Channel.ScalerOffset     := ChannelScalerOffsetEdit.AsFloat;

   Channel.VoltsPerDivision := ChannelVoltsPerDivSpinSelector.Value;
   Channel.Position         := ChannelPositionSpinSelector.Value;
   Channel.Coupling         := TiScopeChannelCoupling(Round(ChannelCouplingSpinSelector.Value));

   UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.iChannelAddButtonClick(Sender: TObject);
var
  iScopeChannel : TiScopeChannel;
begin
  iScopeChannel := TiScopeChannel.Create;
  iScopeChannel.TitleText :=  'CH' + IntToStr(iChannelListBox.Items.Count+1);

  iChannelListBox.Items.AddObject('', iScopeChannel);

  iChannelListBox.SelectLast;
  UpdateChannelEdit;
  ReloadTriggerChannelList;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.ChannelRemoveButtonClick(Sender: TObject);
begin
  iChannelListBox.DeleteSelectedObject;
  UpdateChannelEdit;
  ReloadTriggerChannelList;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiScopeComponentEditorForm.ReloadTriggerChannelList;
var
  i       : Integer;
  OldName : String;
begin
  if TriggerSourceSpinSelector.ItemIndex <> - 1 then
    OldName := TriggerSourceSpinSelector.GetItemCaption(TriggerSourceSpinSelector.ItemIndex)
  else
    OldName := '';

  TriggerSourceSpinSelector.RemoveAllItems;
  for i := 0 to iChannelListBox.Items.Count -1 do
    TriggerSourceSpinSelector.AddItem((iChannelListBox.Items.Objects[i] as TiScopeChannel).TitleText, i);

  TriggerSourceSpinSelector.SetItemIndexByCaption(OldName);
end;
//****************************************************************************************************************************************************
end.
