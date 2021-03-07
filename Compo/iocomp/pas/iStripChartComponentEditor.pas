{*******************************************************}
{                                                       }
{       TiStripChartComponentEditor                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iStripChartComponentEditor;{$endif}
{$ifdef iCLX}unit QiStripChartComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  Printers,  iTypes,  iClasses, iStripChart, {$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QPrinters, QiTypes, QiClasses, QiStripChart,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiStripChartComponentEditorForm = class(TiComponentEditorForm)
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    PageControl: TiComponentEditorPageControl;
    ChannelsTabSheet: TTabSheet;
    Label1: TLabel;
    Label45: TLabel;
    ChannelListBox: TiComponentEditorListBox;
    iChannelAddButton: TButton;
    ChannelRemoveButton: TButton;
    ChannelPropertiesGroupBox: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ChannelColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    ChannelLineStyleComboBox: TiComponentEditorComboBox;
    ChannelTitleEdit: TiComponentEditorEdit;
    ChannelLineWidthEdit: TiComponentEditorEdit;
    ChannelLineWidthUpDown: TiUpDown;
    GeneralTabSheet: TTabSheet;
    OuterMarginGroupBox: TGroupBox;
    OuterMarginLeftEdit: TiComponentEditorEdit;
    OuterMarginLeftUpDown: TiUpDown;
    OuterMarginTopEdit: TiComponentEditorEdit;
    OuterMarginTopUpDown: TiUpDown;
    OuterMarginBottomEdit: TiComponentEditorEdit;
    OuterMarginBottomUpDown: TiUpDown;
    OuterMarginRightEdit: TiComponentEditorEdit;
    OuterMarginRightUpDown: TiUpDown;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    TitleGroupBox: TGroupBox;
    Label35: TLabel;
    Label40: TLabel;
    TitleMarginEdit: TiComponentEditorEdit;
    TitleEdit: TiComponentEditorEdit;
    TitleFontPicker: TiComponentEditorFontPicker;
    TitleMarginUpDown: TiUpDown;
    BufferMaxSizeGroupBox: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    MaxBufferSizeEdit: TiComponentEditorEdit;
    MinBufferSizeEdit: TiComponentEditorEdit;
    EnableDataDrawMinMaxCheckBox: TiComponentEditorCheckBox;
    DiscontinuousDataEnabledCheckBox: TiComponentEditorCheckBox;
    PrecisionStyleRadioGroup: TiComponentEditorRadioGroup;
    InterpolateMissingDataPointsCheckBox: TiComponentEditorCheckBox;
    AutoScrollScaleTabSheet: TTabSheet;
    AutoScaleGroupBox: TGroupBox;
    Label39: TLabel;
    AutoScaleCheckBox: TiComponentEditorCheckBox;
    AutoScaleHysterisisEdit: TiComponentEditorEdit;
    AutoScaleMaxAdjustEnabledCheckBox: TiComponentEditorCheckBox;
    AutoScaleMinAdjustEnabledCheckBox: TiComponentEditorCheckBox;
    AutoScrollGroupBox: TGroupBox;
    Label38: TLabel;
    AutoScrollEnabledCheckBox: TiComponentEditorCheckBox;
    AutoScrollTypeRadioGroup: TiComponentEditorRadioGroup;
    AutoScrollStepSizeEdit: TiComponentEditorEdit;
    AutoScrollFirstStyleRadioGroup: TiComponentEditorRadioGroup;
    XAxisTabSheet: TTabSheet;
    Label12: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    XAxisMaxEdit: TiComponentEditorEdit;
    XAxisMinEdit: TiComponentEditorEdit;
    XAxisMarginEdit: TiComponentEditorEdit;
    XAxisLabelsGroupBox: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    XAxisTickLabelMarginEdit: TiComponentEditorEdit;
    XAxisTickLabelPrecisionEdit: TiComponentEditorEdit;
    XAxisLabelFontPicker: TiComponentEditorFontPicker;
    XAxisTickLabelMarginUpDown: TiUpDown;
    XAxisTickLabelPrecisionUpDown: TiUpDown;
    XAxisTitleGroupBox: TGroupBox;
    Label23: TLabel;
    XAxisTitleMarginEdit: TiComponentEditorEdit;
    XAxisTitleEdit: TiComponentEditorEdit;
    XAxisTitleFontPicker: TiComponentEditorFontPicker;
    XAxisTitleMarginUpDown: TiUpDown;
    XAxisTicksMajorGroupBox: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    XAxisTickMajorColorPicker: TiComponentEditorColorPicker;
    Label26: TLabel;
    XAxisTickMajorCountEdit: TiComponentEditorEdit;
    XAxisTickMajorLengthEdit: TiComponentEditorEdit;
    XAxisTickMajorCountUpDown: TiUpDown;
    XAxisTickMajorLengthUpDown: TiUpDown;
    XAxisMarginUpDown: TiUpDown;
    XAxisTicksMinorGroupBox: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    XAxisTickMinorColorPicker: TiComponentEditorColorPicker;
    Label29: TLabel;
    XAxisTickMinorCountEdit: TiComponentEditorEdit;
    XAxisTickMinorLengthEdit: TiComponentEditorEdit;
    XAxisTickMinorCountUpDown: TiUpDown;
    XAxisTickMinorLengthUpDown: TiUpDown;
    DateTimeGroupBox: TGroupBox;
    Label41: TLabel;
    XAxisDateTimeEnabled: TiComponentEditorCheckBox;
    XAxisDateTimeFormatStringComboBox: TiComponentEditorComboBox;
    XAxisShowCheckBox: TiComponentEditorCheckBox;
    YAxisTabSheet: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    YAxisMaxEdit: TiComponentEditorEdit;
    YAxisMinEdit: TiComponentEditorEdit;
    YAxisMarginEdit: TiComponentEditorEdit;
    YAxisLabelsGroupBox: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label46: TLabel;
    YAxisTickLabelMarginEdit: TiComponentEditorEdit;
    YAxisTickLabelPrecisionEdit: TiComponentEditorEdit;
    YAxisLabelFontPicker: TiComponentEditorFontPicker;
    YAxisTickLabelMarginUpDown: TiUpDown;
    YAxisTickLabelPrecisionUpDown: TiUpDown;
    YAxisLabelWidthEdit: TiComponentEditorEdit;
    YAxisLabelWidthUpDown: TiUpDown;
    YAxisLabelWidthFixedCheckBox: TiComponentEditorCheckBox;
    YAxisTitleGroupBox: TGroupBox;
    Label11: TLabel;
    YAxisTitleMarginEdit: TiComponentEditorEdit;
    YAxisTitleEdit: TiComponentEditorEdit;
    YAxisTitleFontPicker: TiComponentEditorFontPicker;
    YAxisTitleMarginUpDown: TiUpDown;
    YAxisTicksMajorGroupBox: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    YAxisTickMajorColorPicker: TiComponentEditorColorPicker;
    Label15: TLabel;
    YAxisTickMajorCountEdit: TiComponentEditorEdit;
    YAxisTickMajorLengthEdit: TiComponentEditorEdit;
    YAxisTickMajorCountUpDown: TiUpDown;
    YAxisTickMajorLengthUpDown: TiUpDown;
    YAxisMarginUpDown: TiUpDown;
    YAxisTicksMinorGroupBox: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    YAxisTickMinorColorPicker: TiComponentEditorColorPicker;
    Label18: TLabel;
    YAxisTickMinorCountEdit: TiComponentEditorEdit;
    YAxisTickMinorLengthEdit: TiComponentEditorEdit;
    YAxisTickMinorCountUpDown: TiUpDown;
    YAxisTickMinorLengthUpDown: TiUpDown;
    YAxisShowCheckBox: TiComponentEditorCheckBox;
    YAxisReverseScaleCheckBox: TiComponentEditorCheckBox;
    LegendGridTabSheet: TTabSheet;
    LegendGroupBox: TGroupBox;
    Label34: TLabel;
    Label32: TLabel;
    LegendFontPicker: TiComponentEditorFontPicker;
    LegendMarginEdit: TiComponentEditorEdit;
    LegendMarginUpDown: TiUpDown;
    ShowLegendCheckBox: TiComponentEditorCheckBox;
    LegendWidthEdit: TiComponentEditorEdit;
    LegendWidthUpDown: TiUpDown;
    GridGroupBox: TGroupBox;
    GridBackGroundColorPicker: TiComponentEditorColorPicker;
    Label42: TLabel;
    AxisGridColorPicker: TiComponentEditorColorPicker;
    Label30: TLabel;
    GridLineStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowGridCheckBox: TiComponentEditorCheckBox;
    ToolBarCursorTabSheet: TTabSheet;
    ToolbarGroupBox: TGroupBox;
    ShowToolBarCheckBox: TiComponentEditorCheckBox;
    ToolBarModeRadioGroup: TiComponentEditorRadioGroup;
    ToolBarActiveModeFontPicker: TiComponentEditorFontPicker;
    ToolBarInactiveModeFontPicker: TiComponentEditorFontPicker;
    CursorGroupBox: TGroupBox;
    CursorColorPicker: TiComponentEditorColorPicker;
    Label33: TLabel;
    SelectedChannelGroupBox: TGroupBox;
    CursorChannelBackGroundColorPicker: TiComponentEditorColorPicker;
    Label36: TLabel;
    CursorChannelFontColorPicker: TiComponentEditorColorPicker;
    Label37: TLabel;
    CursorChannelEdit: TiComponentEditorEdit;
    CursorChannelUpDown: TiUpDown;
    CursorHideAllOtherChannelsCheckBox: TiComponentEditorCheckBox;
    RestoreXYAxisOnPlotModeCheckBox: TiComponentEditorCheckBox;
    PrintingTabSheet: TTabSheet;
    PrinterMarginGroupBox: TGroupBox;
    PrinterMarginLeftEdit: TiComponentEditorEdit;
    PrinterMarginTopEdit: TiComponentEditorEdit;
    PrinterMarginBottomEdit: TiComponentEditorEdit;
    PrinterMarginRightEdit: TiComponentEditorEdit;
    PrinterOrientationRadioGroup: TiComponentEditorRadioGroup;
    PrinterShowDialogCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    PrinterCommentLineGroupBox: TGroupBox;
    PrinterCommentLinesFontPicker: TiComponentEditorFontPicker;
    Label48: TLabel;
    PrinterCommentLineSpacingEdit: TiComponentEditorEdit;
    PrinterCommentLineSpacingUpDown: TiUpDown;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    procedure iChannelAddButtonClick(Sender: TObject);
    procedure ChannelRemoveButtonClick(Sender: TObject);
    procedure ChannelListBoxClick(Sender: TObject);
    procedure ChannelChange(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure ChannelListBoxItemMove(Sender: TObject);
    procedure ChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
  private
    FLastChannelIndex  : Integer;
    procedure UpdateChannelEdit;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  public
    procedure ClearList;
  end;

var
  iStripChartComponentEditorForm: TiStripChartComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiStripChart.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  ClearList;
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.ClearList;
begin
    while ChannelListBox.Items.Count > 0 do
      begin
        ChannelListBox.Items.Objects[0].Free;
        ChannelListBox.Items.Delete(0);
      end;
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.ChannelListBoxClick(Sender: TObject);
begin
  UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.ChannelListBoxItemMove(Sender: TObject);
begin
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.ChannelListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (ChannelListBox.Items.Objects[Index] as TiStripChartChannelObject).Color;
  AText  := (ChannelListBox.Items.Objects[Index] as TiStripChartChannelObject).Title;
end;
///****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.iChannelAddButtonClick(Sender: TObject);
var
  iChannelObject : TiStripChartChannelObject;
begin
  iChannelObject           := TiStripChartContinuousDataChannelObject.Create;
  iChannelObject.Title     := 'Untitled';
  iChannelObject.LineStyle := iclsSolid;
  iChannelObject.Color     := clRed;
  ChannelListBox.ItemIndex := ChannelListBox.Items.AddObject(iChannelObject.Title, iChannelObject);
  ChannelListBoxClick(Self);

  CursorChannelUpDown.Max  := ChannelListBox.Items.Count -1;
  if StrToInt(CursorChannelEdit.Text) > CursorChannelUpDown.Max then CursorChannelEdit.Text := IntToStr(CursorChannelUpDown.Max);

  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.ChannelRemoveButtonClick(Sender: TObject);
var
  LastIndex : Integer;
begin
  LastIndex := ChannelListBox.ItemIndex;
  ChannelListBox.Items.Objects[ChannelListBox.ItemIndex].Free;
  ChannelListBox.Items.Delete(ChannelListBox.ItemIndex);
  if ChannelListBox.Items.Count <> 0 then
    begin
      if LastIndex > (ChannelListBox.Items.Count - 1) then ChannelListBox.ItemIndex := LastIndex - 1
        else ChannelListBox.ItemIndex := LastIndex;
    end;

  CursorChannelUpDown.Max  := ChannelListBox.Items.Count -1;
  if StrToInt(CursorChannelEdit.Text) > CursorChannelUpDown.Max then CursorChannelEdit.Text := IntToStr(CursorChannelUpDown.Max);

  UpdateChannelEdit;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.UpdateChannelEdit;
var
  iChannelObject : TiStripChartChannelObject;
begin
  if ChannelListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Channel')
    else
      begin
        EnableAllEditControlsStartingWith('Channel');

        iChannelObject := ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiStripChartChannelObject;

        ChannelTitleEdit.AsString          := iChannelObject.Title;
        ChannelColorPicker.Color           := iChannelObject.Color;
        ChannelLineStyleComboBox.AsInteger := ord(iChannelObject.LineStyle);
        ChannelLineWidthEdit.AsInteger     := iChannelObject.LineWidth;
    end
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.ChannelChange(Sender: TObject);
var
  iChannelObject : TiStripChartChannelObject;
begin
  if ChannelListBox.ItemIndex = -1 then exit;

  iChannelObject := ChannelListBox.Items.Objects[ChannelListBox.ItemIndex] as TiStripChartChannelObject;

  iChannelObject.Title     := ChannelTitleEdit.AsString;
  iChannelObject.LineStyle := TiChannelLineStyle(ChannelLineStyleComboBox.AsInteger);
  iChannelObject.LineWidth := ChannelLineWidthEdit.AsInteger;
  iChannelObject.Color     := ChannelColorPicker.Color;

  ChannelListBox.Invalidate;
  UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iStripChart    : TiStripChart;
  iChannelObject : TiStripChartChannelObject;
  x              : Integer;
begin
  iStripChart := Component as TiStripChart;

  ClearList;
  for x := 0 to iStripChart.ChannelCount - 1 do
    begin
      iChannelObject           := TiStripChartContinuousDataChannelObject.Create;
      iChannelObject.Title     := iStripChart.ChannelTitle[x];
      iChannelObject.LineStyle := iStripChart.ChannelLineStyle[x];
      iChannelObject.LineWidth := iStripChart.ChannelLineWidth[x];
      iChannelObject.Color     := iStripChart.ChannelColor[x];
      ChannelListBox.Items.AddObject(iChannelObject.Title, iChannelObject);
    end;

  if ChannelListBox.Items.Count <> 0 then ChannelListBox.ItemIndex := 0;
  CursorChannelUpDown.Max  := ChannelListBox.Items.Count -1;
  //--------- General --------------------------------------------------------------------------------------------------------------------------------
  BackGroundColorPicker.Color                    := iStripChart.BackGroundColor;

  MaxBufferSizeEdit.AsInteger                    := iStripChart.MaxBufferSize;
  MinBufferSizeEdit.AsInteger                    := iStripChart.MinBufferSize;

  TitleEdit.AsString                             := iStripChart.TitleText;
  TitleMarginEdit.AsInteger                      := iStripChart.TitleMargin;

  EnableDataDrawMinMaxCheckBox.AsBoolean         := iStripChart.EnableDataDrawMinMax;
  DiscontinuousDataEnabledCheckBox.AsBoolean     := iStripChart.DiscontinuousDataEnabled;
  InterpolateMissingDataPointsCheckBox.AsBoolean := iStripChart.InterpolateMissingDataPoints;
  AutoFrameRateCheckBox.AsBoolean                := iStripChart.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger                  := iStripChart.UpdateFrameRate;

  BorderStyleRadioGroup.AsInteger                := ord(iStripChart.BorderStyle);
  PrecisionStyleRadioGroup.AsInteger             := ord(iStripChart.PrecisionStyle);

  OuterMarginLeftEdit.AsInteger                  := iStripChart.OuterMarginLeft;
  OuterMarginTopEdit.AsInteger                   := iStripChart.OuterMarginTop;
  OuterMarginRightEdit.AsInteger                 := iStripChart.OuterMarginRight;
  OuterMarginBottomEdit.AsInteger                := iStripChart.OuterMarginBottom;
  //--------- AutoScroll/Scale -----------------------------------------------------------------------------------------------------------------------
  AutoScaleCheckBox.AsBoolean                    := iStripChart.AutoScaleEnabled;
  AutoScaleMaxAdjustEnabledCheckBox.AsBoolean    := iStripChart.AutoScaleMaxAdjustEnabled;
  AutoScaleMinAdjustEnabledCheckBox.AsBoolean    := iStripChart.AutoScaleMinAdjustEnabled;
  AutoScaleHysterisisEdit.AsFloat                := iStripChart.AutoScaleHysterisis;

  AutoScrollEnabledCheckBox.AsBoolean            := iStripChart.AutoScrollEnabled;
  AutoScrollTypeRadioGroup.AsInteger             := ord(iStripChart.AutoScrollType);
  AutoScrollStepSizeEdit.AsFloat                 := iStripChart.AutoScrollStepSize;
  AutoScrollFirstStyleRadioGroup.AsInteger       := ord(iStripChart.AutoScrollFirstStyle);
  //------------ XAxis -------------------------------------------------------------------------------------------------------------------------------
  XAxisMaxEdit.AsFloat                           := iStripChart.XAxisMax;
  XAxisMinEdit.AsFloat                           := iStripChart.XAxisMin;
  XAxisMarginEdit.AsInteger                      := iStripChart.XAxisMargin;
  XAxisShowCheckBox.AsBoolean                    := iStripChart.XAxisShow;

  XAxisTitleEdit.AsString                        := iStripChart.XAxisTitle;
  XAxisTitleMarginEdit.AsInteger                 := iStripChart.XAxisTitleMargin;

  XAxisTickMajorColorPicker.Color                := iStripChart.XAxisTickMajorColor;
  XAxisTickMajorCountEdit.AsInteger              := iStripChart.XAxisTickMajorCount;
  XAxisTickMajorLengthEdit.AsInteger             := iStripChart.XAxisTickMajorLength;

  XAxisTickMinorColorPicker.Color                := iStripChart.XAxisTickMinorColor;
  XAxisTickMinorCountEdit.AsInteger              := iStripChart.XAxisTickMinorCount;
  XAxisTickMinorLengthEdit.AsInteger             := iStripChart.XAxisTickMinorLength;

  XAxisTickLabelMarginEdit.AsInteger             := iStripChart.XAxisLabelMargin;
  XAxisTickLabelPrecisionEdit.AsInteger          := iStripChart.XAxisLabelPrecision;

  XAxisDateTimeEnabled.AsBoolean                 := iStripChart.XAxisDateTimeEnabled;
  XAxisDateTimeFormatStringComboBox.AsString     := iStripChart.XAxisDateTimeFormatString;
  //------------ YAxis -------------------------------------------------------------------------------------------------------------------------------
  YAxisMaxEdit.AsFloat                           := iStripChart.YAxisMax;
  YAxisMinEdit.AsFloat                           := iStripChart.YAxisMin;
  YAxisMarginEdit.AsInteger                      := iStripChart.YAxisMargin;
  YAxisShowCheckBox.AsBoolean                    := iStripChart.YAxisShow;
  YAxisReverseScaleCheckBox.AsBoolean            := iStripChart.YAxisReverseScale;

  YAxisTitleEdit.AsString                        := iStripChart.YAxisTitle;
  YAxisTitleMarginEdit.AsInteger                 := iStripChart.YAxisTitleMargin;

  YAxisTickMajorColorPicker.Color                := iStripChart.YAxisTickMajorColor;
  YAxisTickMajorCountEdit.AsInteger              := iStripChart.YAxisTickMajorCount;
  YAxisTickMajorLengthEdit.AsInteger             := iStripChart.YAxisTickMajorLength;

  YAxisTickMinorColorPicker.Color                := iStripChart.YAxisTickMinorColor;
  YAxisTickMinorCountEdit.AsInteger              := iStripChart.YAxisTickMinorCount;
  YAxisTickMinorLengthEdit.AsInteger             := iStripChart.YAxisTickMinorLength;

  YAxisTickLabelMarginEdit.AsInteger             := iStripChart.YAxisLabelMargin;
  YAxisTickLabelPrecisionEdit.AsInteger          := iStripChart.YAxisLabelPrecision;
  YAxisLabelWidthEdit.AsInteger                  := iStripChart.YAxisLabelWidth;
  YAxisLabelWidthFixedCheckBox.AsBoolean         := iStripChart.YAxisLabelWidthFixed;
  //--------- LegendGrid -----------------------------------------------------------------------------------------------------------------------------
  ShowLegendCheckBox.AsBoolean                   := iStripChart.ShowLegend;
  LegendMarginEdit.AsInteger                     := iStripChart.LegendMargin;
  LegendWidthEdit.AsInteger                      := iStripChart.LegendWidth;

  ShowGridCheckBox.AsBoolean                     := iStripChart.ShowGrid;
  GridLineStyleRadioGroup.AsInteger              := ord(iStripChart.GridLineStyle);
  AxisGridColorPicker.Color                      := iStripChart.AxisGridColor;
  GridBackGroundColorPicker.Color                := iStripChart.GridBackGroundColor;
  //-------------- ToolBarCursor ---------------------------------------------------------------------------------------------------------------------
  ShowToolBarCheckBox.AsBoolean                  := iStripChart.ShowToolBar;
  ToolBarModeRadioGroup.AsInteger                := ord(iStripChart.ToolBarMode);

  RestoreXYAxisOnPlotModeCheckBox.AsBoolean      := iStripChart.RestoreXYAxisOnPlotMode;

  CursorHideAllOtherChannelsCheckBox.AsBoolean   := iStripChart.CursorHideAllOtherChannels;
  CursorChannelEdit.AsInteger                    := iStripChart.CursorChannel;
  CursorColorPicker.Color                        := iStripChart.CursorColor;
  CursorChannelBackGroundColorPicker.Color       := iStripChart.CursorChannelBackGroundColor;
  CursorChannelFontColorPicker.Color             := iStripChart.CursorChannelFontColor;
  //----------- Printer ------------------------------------------------------------------------------------------------------------------------------
  {$ifdef iVCL}PrinterOrientationRadioGroup.AsInteger := ord(iStripChart.PrinterOrientation);{$endif}
  PrinterMarginLeftEdit.AsFloat                  := iStripChart.PrinterMarginLeft;
  PrinterMarginTopEdit.AsFloat                   := iStripChart.PrinterMarginTop;
  PrinterMarginRightEdit.AsFloat                 := iStripChart.PrinterMarginRight;
  PrinterMarginBottomEdit.AsFloat                := iStripChart.PrinterMarginBottom;
  PrinterShowDialogCheckBox.AsBoolean            := iStripChart.PrinterShowDialog;
  PrinterCommentLineSpacingEdit.AsFloat          := iStripChart.PrinterCommentLineSpacing;
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  TitleFontPicker.Font.Assign              (iStripChart.TitleFont);
  XAxisTitleFontPicker.Font.Assign         (iStripChart.XAxisTitleFont);
  XAxisLabelFontPicker.Font.Assign         (iStripChart.XAxisLabelFont);
  YAxisTitleFontPicker.Font.Assign         (iStripChart.YAxisTitleFont);
  YAxisLabelFontPicker.Font.Assign         (iStripChart.YAxisLabelFont);
  LegendFontPicker.Font.Assign             (iStripChart.LegendFont);
  ToolBarActiveModeFontPicker.Font.Assign  (iStripChart.ToolBarActiveModeFont);
  ToolBarInactiveModeFontPicker.Font.Assign(iStripChart.ToolBarInactiveModeFont);
  PrinterCommentLinesFontPicker.Font.Assign(iStripChart.PrinterCommentLinesFont);

  if ChannelListBox.Items.Count  > FLastChannelIndex  then ChannelListBox.ItemIndex  := FLastChannelIndex;
  UpdateChannelEdit;
end;
//****************************************************************************************************************************************************
procedure TiStripChartComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iStripChart    : TiStripChart;
  iChannelObject : TiStripChartChannelObject;
  x              : Integer;
begin
  iStripChart := Component as TiStripChart;

  iStripChart.RemoveAllChannels;

  for x := 0 to ChannelListBox.Items.Count - 1 do
    begin
      iChannelObject := ChannelListBox.Items.Objects[x] as TiStripChartChannelObject;
      iStripChart.AddChannel(iChannelObject.Title, iChannelObject.Color, iChannelObject.LineStyle, iChannelObject.LineWidth);
    end;
  //--------- General --------------------------------------------------------------------------------------------------------------------------------
  iStripChart.BackGroundColor              := BackGroundColorPicker.Color;

  iStripChart.MaxBufferSize                := MaxBufferSizeEdit.AsInteger;
  iStripChart.MinBufferSize                := MinBufferSizeEdit.AsInteger;

  iStripChart.TitleText                    := TitleEdit.AsString;
  iStripChart.TitleMargin                  := TitleMarginEdit.AsInteger;

  iStripChart.EnableDataDrawMinMax         := EnableDataDrawMinMaxCheckBox.AsBoolean;
  iStripChart.DiscontinuousDataEnabled     := DiscontinuousDataEnabledCheckBox.AsBoolean;
  iStripChart.InterpolateMissingDataPoints := InterpolateMissingDataPointsCheckBox.AsBoolean;
  iStripChart.AutoFrameRate                := AutoFrameRateCheckBox.AsBoolean;
  iStripChart.UpdateFrameRate              := UpdateFrameRateEdit.AsInteger;

  iStripChart.BorderStyle                  := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iStripChart.PrecisionStyle               := TiPrecisionStyle(PrecisionStyleRadioGroup.AsInteger);

  iStripChart.OuterMarginLeft              := OuterMarginLeftEdit.AsInteger;
  iStripChart.OuterMarginTop               := OuterMarginTopEdit.AsInteger;
  iStripChart.OuterMarginRight             := OuterMarginRightEdit.AsInteger;
  iStripChart.OuterMarginBottom            := OuterMarginBottomEdit.AsInteger;
  //--------- AutoScroll/Scale -----------------------------------------------------------------------------------------------------------------------
  iStripChart.AutoScaleEnabled             := AutoScaleCheckBox.AsBoolean;
  iStripChart.AutoScaleMaxAdjustEnabled    := AutoScaleMaxAdjustEnabledCheckBox.AsBoolean;
  iStripChart.AutoScaleMinAdjustEnabled    := AutoScaleMinAdjustEnabledCheckBox.AsBoolean;

  iStripChart.AutoScaleHysterisis          := AutoScaleHysterisisEdit.AsFloat;

  iStripChart.AutoScrollEnabled            := AutoScrollEnabledCheckBox.AsBoolean;
  iStripChart.AutoScrollType               := TiAutoScroll(AutoScrollTypeRadioGroup.AsInteger);
  iStripChart.AutoScrollStepSize           := AutoScrollStepSizeEdit.AsFloat;
  iStripChart.AutoScrollFirstStyle         := TiAutoScrollFirstStyle(AutoScrollFirstStyleRadioGroup.AsInteger);
  //------------ XAxis -------------------------------------------------------------------------------------------------------------------------------
  iStripChart.XAxisMax                     := XAxisMaxEdit.AsFloat;
  iStripChart.XAxisMin                     := XAxisMinEdit.AsFloat;
  iStripChart.XAxisMargin                  := XAxisMarginEdit.AsInteger;
  iStripChart.XAxisShow                    := XAxisShowCheckBox.AsBoolean;

  iStripChart.XAxisTitle                   := XAxisTitleEdit.AsString;
  iStripChart.XAxisTitleMargin             := XAxisTitleMarginEdit.AsInteger;

  iStripChart.XAxisTickMajorColor          := XAxisTickMajorColorPicker.Color;
  iStripChart.XAxisTickMajorCount          := XAxisTickMajorCountEdit.AsInteger;
  iStripChart.XAxisTickMajorLength         := XAxisTickMajorLengthEdit.AsInteger;

  iStripChart.XAxisTickMinorColor          := XAxisTickMinorColorPicker.Color;
  iStripChart.XAxisTickMinorCount          := XAxisTickMinorCountEdit.AsInteger;
  iStripChart.XAxisTickMinorLength         := XAxisTickMinorLengthEdit.AsInteger;

  iStripChart.XAxisLabelMargin             := XAxisTickLabelMarginEdit.AsInteger;
  iStripChart.XAxisLabelPrecision          := XAxisTickLabelPrecisionEdit.AsInteger;

  iStripChart.XAxisDateTimeEnabled         := XAxisDateTimeEnabled.AsBoolean;
  iStripChart.XAxisDateTimeFormatString    := XAxisDateTimeFormatStringComboBox.AsString;
  //---------- YAxis ---------------------------------------------------------------------------------------------------------------------------------
  iStripChart.YAxisMax                     := YAxisMaxEdit.AsFloat;
  iStripChart.YAxisMin                     := YAxisMinEdit.AsFloat;
  iStripChart.YAxisMargin                  := YAxisMarginEdit.AsInteger;
  iStripChart.YAxisShow                    := YAxisShowCheckBox.AsBoolean;
  iStripChart.YAxisReverseScale            := YAxisReverseScaleCheckBox.AsBoolean;

  iStripChart.YAxisTitle                   := YAxisTitleEdit.AsString;
  iStripChart.YAxisTitleMargin             := YAxisTitleMarginEdit.AsInteger;

  iStripChart.YAxisTickMajorColor          := YAxisTickMajorColorPicker.Color;
  iStripChart.YAxisTickMajorCount          := YAxisTickMajorCountEdit.AsInteger;
  iStripChart.YAxisTickMajorLength         := YAxisTickMajorLengthEdit.AsInteger;

  iStripChart.YAxisTickMinorColor          := YAxisTickMinorColorPicker.Color;
  iStripChart.YAxisTickMinorCount          := YAxisTickMinorCountEdit.AsInteger;
  iStripChart.YAxisTickMinorLength         := YAxisTickMinorLengthEdit.AsInteger;

  iStripChart.YAxisLabelMargin             := YAxisTickLabelMarginEdit.AsInteger;
  iStripChart.YAxisLabelPrecision          := YAxisTickLabelPrecisionEdit.AsInteger;
  iStripChart.YAxisLabelWidth              := YAxisLabelWidthEdit.AsInteger;
  iStripChart.YAxisLabelWidthFixed         := YAxisLabelWidthFixedCheckBox.AsBoolean;
  //--------- LegendGrid -----------------------------------------------------------------------------------------------------------------------------
  iStripChart.ShowLegend                   := ShowLegendCheckBox.AsBoolean;
  iStripChart.LegendMargin                 := LegendMarginEdit.AsInteger;
  iStripChart.LegendWidth                  := LegendWidthEdit.AsInteger;

  iStripChart.ShowGrid                     := ShowGridCheckBox.AsBoolean;
  iStripChart.GridLineStyle                := TiChannelLineStyle(GridLineStyleRadioGroup.AsInteger);
  iStripChart.AxisGridColor                := AxisGridColorPicker.Color;
  iStripChart.GridBackGroundColor          := GridBackGroundColorPicker.Color;
  //-------------- ToolBarCursor ---------------------------------------------------------------------------------------------------------------------
  iStripChart.ShowToolBar                  := ShowToolBarCheckBox.AsBoolean;
  iStripChart.ToolBarMode                  := TiStripChartMode(ToolBarModeRadioGroup.AsInteger);

  iStripChart.RestoreXYAxisOnPlotMode      := RestoreXYAxisOnPlotModeCheckBox.AsBoolean;

  iStripChart.CursorHideAllOtherChannels   := CursorHideAllOtherChannelsCheckBox.AsBoolean;
  iStripChart.CursorChannel                := CursorChannelEdit.AsInteger;
  iStripChart.CursorColor                  := CursorColorPicker.Color;
  iStripChart.CursorChannelBackGroundColor := CursorChannelBackGroundColorPicker.Color;
  iStripChart.CursorChannelFontColor       := CursorChannelFontColorPicker.Color;
  //----------- Printer ------------------------------------------------------------------------------------------------------------------------------
  {$ifdef iVCL}iStripChart.PrinterOrientation           := TPrinterOrientation(PrinterOrientationRadioGroup.ItemIndex);{$endif}
  iStripChart.PrinterMarginLeft            := PrinterMarginLeftEdit.AsFloat;
  iStripChart.PrinterMarginTop             := PrinterMarginTopEdit.AsFloat;
  iStripChart.PrinterMarginRight           := PrinterMarginRightEdit.AsFloat;
  iStripChart.PrinterMarginBottom          := PrinterMarginBottomEdit.AsFloat;
  iStripChart.PrinterShowDialog            := PrinterShowDialogCheckBox.AsBoolean;
  iStripChart.PrinterCommentLineSpacing    := PrinterCommentLineSpacingEdit.AsFloat;
  //--------------------------------------------------------------------------------------------------------------------------------------------------
  iStripChart.TitleFont.Assign              (TitleFontPicker.Font);
  iStripChart.XAxisTitleFont.Assign         (XAxisTitleFontPicker.Font);
  iStripChart.XAxisLabelFont.Assign         (XAxisLabelFontPicker.Font);
  iStripChart.YAxisTitleFont.Assign         (YAxisTitleFontPicker.Font);
  iStripChart.YAxisLabelFont.Assign         (YAxisLabelFontPicker.Font);
  iStripChart.LegendFont.Assign             (LegendFontPicker.Font);
  iStripChart.ToolBarActiveModeFont.Assign  (ToolBarActiveModeFontPicker.Font);
  iStripChart.ToolBarInactiveModeFont.Assign(ToolBarInactiveModeFontPicker.Font);
  iStripChart.PrinterCommentLinesFont.Assign(PrinterCommentLinesFontPicker.Font);
  
  FLastChannelIndex  := ChannelListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
end.
