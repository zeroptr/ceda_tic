{*******************************************************}
{                                                       }
{       TiAngularGaugeComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iAngularGaugeComponentEditor;{$endif}
{$ifdef iCLX}unit QiAngularGaugeComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iAngularGauge,  iGaugePointer,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiAngularGauge, QiGaugePointer,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiAngularGaugeComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    SectionsTabSheet: TTabSheet;
    Label43: TLabel;
    Label44: TLabel;
    CurrentMaxEdit: TiComponentEditorEdit;
    CurrentMinEdit: TiComponentEditorEdit;
    AutoScaleTabSheet: TTabSheet;
    AutoScaleEnabledCheckBox: TiComponentEditorCheckBox;
    Label46: TLabel;
    AutoScaleDesiredTicksEdit: TiComponentEditorEdit;
    AutoScaleDesiredTicksUpDown: TiUpDown;
    Label47: TLabel;
    AutoScaleMaxTicksEdit: TiComponentEditorEdit;
    AutoScaleMaxTicksUpDown: TiUpDown;
    AutoScaleStyleRadioGroup: TiComponentEditorRadioGroup;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
    DesignPageControl: TiComponentEditorPageControl;
    DesignSectionsTabSheet: TTabSheet;
    DesignGeneralTabSheet: TTabSheet;
    DesignPointersTabSheetTabSheet: TTabSheet;
    DesignTicksTabSheet: TTabSheet;
    Label10: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    SectionCountUpDown: TiUpDown;
    SectionColor1Picker: TiComponentEditorColorPicker;
    SectionColor2Picker: TiComponentEditorColorPicker;
    SectionColor3Picker: TiComponentEditorColorPicker;
    SectionColor4Picker: TiComponentEditorColorPicker;
    SectionColor5Picker: TiComponentEditorColorPicker;
    SectionEnd1Edit: TiComponentEditorEdit;
    SectionEnd2Edit: TiComponentEditorEdit;
    SectionCountEdit: TiComponentEditorEdit;
    SectionEnd3Edit: TiComponentEditorEdit;
    SectionEnd4Edit: TiComponentEditorEdit;
    Label28: TLabel;
    TickMarginUpDown: TiUpDown;
    LabelsGroupBox: TGroupBox;
    Label15: TLabel;
    Label19: TLabel;
    TickLabelPrecisionUpDown: TiUpDown;
    TickLabelMarginUpDown: TiUpDown;
    ShowTickLabelsCheckBox: TiComponentEditorCheckBox;
    TickLabelFontPicker: TiComponentEditorFontPicker;
    TickLabelPrecisionEdit: TiComponentEditorEdit;
    TickLabelMarginEdit: TiComponentEditorEdit;
    TickLabelAlignmentRadioGroup: TiComponentEditorRadioGroup;
    MinorGroupBox: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    TickMinorCountUpDown: TiUpDown;
    TickMinorLengthUpDown: TiUpDown;
    TickMinorColorPicker: TiComponentEditorColorPicker;
    ShowTicksMinorCheckBox: TiComponentEditorCheckBox;
    TickMinorCountEdit: TiComponentEditorEdit;
    TickMinorLengthEdit: TiComponentEditorEdit;
    TickMinorAlignmentRadioGroup: TiComponentEditorRadioGroup;
    TickMarginEdit: TiComponentEditorEdit;
    MajorGroupBox: TGroupBox;
    Label20: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    TickMajorCountUpDown: TiUpDown;
    TickMajorLengthUpDown: TiUpDown;
    TickMajorColorPicker: TiComponentEditorColorPicker;
    ShowTicksMajorCheckBox: TiComponentEditorCheckBox;
    TickMajorCountEdit: TiComponentEditorEdit;
    TickMajorLengthEdit: TiComponentEditorEdit;
    iPointerListBox: TiComponentEditorListBox;
    iPointerAddButton: TButton;
    PointerRemoveButton: TButton;
    PointersGeneralPageControl: TiComponentEditorPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label4: TLabel;
    PointerMarginUpDown: TiUpDown;
    PointerSizeUpDown: TiUpDown;
    Label9: TLabel;
    Label50: TLabel;
    PointerMarginEdit: TiComponentEditorEdit;
    PointerSizeEdit: TiComponentEditorEdit;
    PointerStyleRadioGroup: TiComponentEditorRadioGroup;
    PointerColorPicker: TiComponentEditorColorPicker;
    PointerPositionEdit: TiComponentEditorEdit;
    DesignMinMaxTabSheet: TTabSheet;
    DesignLablesTabSheet: TTabSheet;
    Label2: TLabel;
    Label11: TLabel;
    MinMaxPointerSizeUpDown: TiUpDown;
    MinMaxPointerMarginUpDown: TiUpDown;
    MinMaxPointerSizeEdit: TiComponentEditorEdit;
    MinMaxPointerMarginEdit: TiComponentEditorEdit;
    MaxGroupBox: TGroupBox;
    Label7: TLabel;
    MaxPointerColorPicker: TiComponentEditorColorPicker;
    ShowMaxPointerCheckBox: TiComponentEditorCheckBox;
    MinGroupBox: TGroupBox;
    Label8: TLabel;
    MinPointerColorPicker: TiComponentEditorColorPicker;
    ShowMinPointerCheckBox: TiComponentEditorCheckBox;
    MinMaxPointerStyleRadioGroup: TiComponentEditorRadioGroup;
    MinMaxFixedCheckBox: TiComponentEditorCheckBox;
    MinMaxUserCanMoveCheckBox: TiComponentEditorCheckBox;
    Label1GroupBox: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label1OffsetXUpDown: TiUpDown;
    Label1OffsetYUpDown: TiUpDown;
    Label1AlignHorizontalRadioGroup: TiComponentEditorRadioGroup;
    Label1AlignVerticalRadioGroup: TiComponentEditorRadioGroup;
    Label1OffsetXEdit: TiComponentEditorEdit;
    Label1OffsetYEdit: TiComponentEditorEdit;
    Label1FontPicker: TiComponentEditorFontPicker;
    Label1TextEdit: TiComponentEditorEdit;
    ShowLabel1CheckBox: TiComponentEditorCheckBox;
    Label2GroupBox: TGroupBox;
    Label39: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label2OffsetXUpDown: TiUpDown;
    Label2OffsetYUpDown: TiUpDown;
    Label2AlignHorizontalRadioGroup: TiComponentEditorRadioGroup;
    Label2AlignVerticalRadioGroup: TiComponentEditorRadioGroup;
    Label2OffsetXEdit: TiComponentEditorEdit;
    Label2OffsetYEdit: TiComponentEditorEdit;
    Label2FontPicker: TiComponentEditorFontPicker;
    Label2TextEdit: TiComponentEditorEdit;
    ShowLabel2CheckBox: TiComponentEditorCheckBox;
    DesignArcHubTabSheet: TTabSheet;
    ArcGroupBox: TGroupBox;
    Label29: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    ArcRadiusUpDown: TiUpDown;
    ArcRangeDegreesUpDown: TiUpDown;
    ArcStartDegreesUpDown: TiUpDown;
    ArcRadiusEdit: TiComponentEditorEdit;
    ArcRangeDegreesEdit: TiComponentEditorEdit;
    ArcStartDegreesEdit: TiComponentEditorEdit;
    HubGroupBox: TGroupBox;
    Label36: TLabel;
    Label45: TLabel;
    HubSizeUpDown: TiUpDown;
    HubColorPicker: TiComponentEditorColorPicker;
    HubSizeEdit: TiComponentEditorEdit;
    ShowHubCheckBox: TiComponentEditorCheckBox;
    OffsetGroupBox: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    ShowInnerArcRadiusCheckBox: TiComponentEditorCheckBox;
    ShowOuterArcRadiusCheckBox: TiComponentEditorCheckBox;
    ReverseScaleCheckBox: TiComponentEditorCheckBox;
    AutoCenterCheckBox: TiComponentEditorCheckBox;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    Label3: TLabel;
    Label49: TLabel;
    OuterMarginUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    OuterMarginEdit: TiComponentEditorEdit;
    PrecisionStyleRadioGroup: TiComponentEditorRadioGroup;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    PointerVisibleCheckBox: TiComponentEditorCheckBox;
    FaceGroupBox: TGroupBox;
    Label51: TLabel;
    FaceColorPicker: TiComponentEditorColorPicker;
    ShowFaceCheckBox: TiComponentEditorCheckBox;
    Hub3DCheckBox: TiComponentEditorCheckBox;
    Label52: TLabel;
    FaceStyleComboBox: TiComponentEditorComboBox;
    FaceBevelGroupBox: TGroupBox;
    Label48: TLabel;
    FaceBevelSizeUpDown: TiUpDown;
    FaceBevelSizeEdit: TiComponentEditorEdit;
    Label53: TLabel;
    FaceBevelStyleComboBox: TiComponentEditorComboBox;
    PointerUserCanMoveCheckBox: TiComponentEditorCheckBox;
    ShowDisabledStateCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
    procedure iPointerListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure iComponentEditorFormCreate(Sender: TObject);
    procedure iPointerAddButtonClick(Sender: TObject);
    procedure PointerChange(Sender: TObject);
    procedure iPointerListBoxClick(Sender: TObject);
    procedure PointerRemoveButtonClick(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure PositionEditChange(Sender: TObject);
  private
    FPointerManager   : TiGaugePointerManager;
    FLastPointerIndex : Integer;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;

    procedure InsertEvent(Sender: TObject);
    procedure RemoveEvent(Sender: TObject);
    procedure ChangeEvent(Sender: TObject);

    procedure UpdatePointers;
  end;

var
  iAngularGaugeComponentEditorForm: TiAngularGaugeComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.CreateThemeInstance();
begin
  iThemeInstance := TiAngularGauge.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iAngularGauge : TiAngularGauge;
  x             : Integer;
begin
  iAngularGauge := Component as TiAngularGauge;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  PositionEdit.AsFloat                      := iAngularGauge.Position;
  PositionMaxEdit.AsFloat                   := iAngularGauge.PositionMax;
  PositionMinEdit.AsFloat                   := iAngularGauge.PositionMin;
  CurrentMaxEdit.AsFloat                    := iAngularGauge.CurrentMax;
  CurrentMinEdit.AsFloat                    := iAngularGauge.CurrentMin;
  ShowInnerArcRadiusCheckBox.AsBoolean      := iAngularGauge.ShowInnerArcRadius;
  ShowOuterArcRadiusCheckBox.AsBoolean      := iAngularGauge.ShowOuterArcRadius;
  ShowDisabledStateCheckBox.AsBoolean       := iAngularGauge.ShowDisabledState;
  EnabledCheckBox.AsBoolean                 := iAngularGauge.Enabled;
  BackGroundColorPicker.Color               := iAngularGauge.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean           := iAngularGauge.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger             := iAngularGauge.UpdateFrameRate;

  BorderStyleRadioGroup.AsInteger           := ord(iAngularGauge.BorderStyle);
  PrecisionStyleRadioGroup.AsInteger        := ord(iAngularGauge.PrecisionStyle);

  ArcRadiusEdit.AsInteger                   := iAngularGauge.ArcRadius;
  ArcRangeDegreesEdit.AsInteger             := iAngularGauge.ArcRangeDegrees;
  ArcStartDegreesEdit.AsInteger             := iAngularGauge.ArcStartDegrees;

  ShowHubCheckBox.AsBoolean                 := iAngularGauge.ShowHub;
  Hub3DCheckBox.AsBoolean                   := iAngularGauge.Hub3D;
  HubSizeEdit.AsInteger                     := iAngularGauge.HubSize;
  HubColorPicker.Color                      := iAngularGauge.HubColor;

  ShowFaceCheckBox.AsBoolean                := iAngularGauge.ShowFace;
  FaceStyleComboBox.AsInteger               := ord(iAngularGauge.FaceStyle);
  FaceBevelSizeEdit.AsInteger               := iAngularGauge.FaceBevelSize;
  FaceBevelStyleComboBox.AsInteger          := ord(iAngularGauge.FaceBevelStyle);
  FaceColorPicker.Color                     := iAngularGauge.FaceColor;

  OffsetXEdit.AsInteger                     := iAngularGauge.OffsetX;
  OffsetYEdit.AsInteger                     := iAngularGauge.OffsetY;

  AutoSizeCheckBox.AsBoolean                := iAngularGauge.AutoSize;
  OuterMarginEdit.AsInteger                 := iAngularGauge.OuterMargin;
  AutoCenterCheckBox.AsBoolean              := iAngularGauge.AutoCenter;

  ReverseScaleCheckBox.AsBoolean            := iAngularGauge.ReverseScale;
  CachedDrawingCheckBox.AsBoolean           := iAngularGauge.CachedDrawing;
  TransparentCheckBox.AsBoolean             := iAngularGauge.Transparent;
  //-------------- Pointers -------------------------------------------------------------------------------------------------------------------
  MinMaxPointerSizeEdit.AsInteger           := iAngularGauge.MinMaxPointerSize;
  MinMaxPointerMarginEdit.AsInteger         := iAngularGauge.MinMaxPointerMargin;
  MinMaxFixedCheckBox.AsBoolean             := iAngularGauge.MinMaxFixed;
  MinMaxUserCanMoveCheckBox.AsBoolean       := iAngularGauge.MinMaxUserCanMove;
  MinMaxPointerStyleRadioGroup.AsInteger    := ord(iAngularGauge.MinMaxPointerStyle);

  ShowMaxPointerCheckBox.AsBoolean          := iAngularGauge.ShowMaxPointer;
  MaxPointerColorPicker.Color               := iAngularGauge.MaxPointerColor;

  ShowMinPointerCheckBox.AsBoolean          := iAngularGauge.ShowMinPointer;
  MinPointerColorPicker.Color               := iAngularGauge.MinPointerColor;
  //-------------- Ticks ----------------------------------------------------------------------------------------------------------------------
  TickMarginEdit.AsInteger                  := iAngularGauge.TickMargin;

  ShowTickLabelsCheckBox.AsBoolean          := iAngularGauge.ShowTickLabels;
  TickLabelPrecisionEdit.AsInteger          := iAngularGauge.TickLabelPrecision;
  TickLabelMarginEdit.AsInteger             := iAngularGauge.TickLabelMargin;
  TickLabelAlignmentRadioGroup.AsInteger    := ord(iAngularGauge.TickLabelAlignment);

  ShowTicksMajorCheckBox.AsBoolean          := iAngularGauge.ShowTicksMajor;
  TickMajorCountEdit.AsInteger              := iAngularGauge.TickMajorCount;
  TickMajorLengthEdit.AsInteger             := iAngularGauge.TickMajorLength;
  TickMajorColorPicker.Color                := iAngularGauge.TickMajorColor;

  ShowTicksMinorCheckBox.AsBoolean          := iAngularGauge.ShowTicksMinor;
  TickMinorCountEdit.AsInteger              := iAngularGauge.TickMinorCount;
  TickMinorLengthEdit.AsInteger             := iAngularGauge.TickMinorLength;
  TickMinorColorPicker.Color                := iAngularGauge.TickMinorColor;
  TickMinorAlignmentRadioGroup.AsInteger    := ord(iAngularGauge.TickMinorAlignment);
  //-------------- Sections -------------------------------------------------------------------------------------------------------------------
  SectionCountEdit.AsInteger                := iAngularGauge.SectionCount;

  SectionColor1Picker.Color                 := iAngularGauge.SectionColor1;
  SectionColor2Picker.Color                 := iAngularGauge.SectionColor2;
  SectionColor3Picker.Color                 := iAngularGauge.SectionColor3;
  SectionColor4Picker.Color                 := iAngularGauge.SectionColor4;
  SectionColor5Picker.Color                 := iAngularGauge.SectionColor5;

  SectionEnd1Edit.AsFloat                   := iAngularGauge.SectionEnd1;
  SectionEnd2Edit.AsFloat                   := iAngularGauge.SectionEnd2;
  SectionEnd3Edit.AsFloat                   := iAngularGauge.SectionEnd3;
  SectionEnd4Edit.AsFloat                   := iAngularGauge.SectionEnd4;
  //-------------- Labels ---------------------------------------------------------------------------------------------------------------------
  Label1TextEdit.AsString                   := iAngularGauge.Label1Text;
  ShowLabel1CheckBox.AsBoolean              := iAngularGauge.ShowLabel1;
  Label1OffsetXEdit.AsInteger               := iAngularGauge.Label1OffsetX;
  Label1OffsetYEdit.AsInteger               := iAngularGauge.Label1OffsetY;
  Label1AlignHorizontalRadioGroup.AsInteger := ord(iAngularGauge.Label1AlignHorizontal);
  Label1AlignVerticalRadioGroup.AsInteger   := ord(iAngularGauge.Label1AlignVertical);

  Label2TextEdit.AsString                   := iAngularGauge.Label2Text;
  ShowLabel2CheckBox.AsBoolean              := iAngularGauge.ShowLabel2;
  Label2OffsetXEdit.AsInteger               := iAngularGauge.Label2OffsetX;
  Label2OffsetYEdit.AsInteger               := iAngularGauge.Label2OffsetY;
  Label2AlignHorizontalRadioGroup.AsInteger := ord(iAngularGauge.Label2AlignHorizontal);
  Label2AlignVerticalRadioGroup.AsInteger   := ord(iAngularGauge.Label2AlignVertical);
  //-------------- AutoScale -------------------------------------------------------------------------------------------------------------------
  AutoScaleDesiredTicksEdit.AsInteger       := iAngularGauge.AutoScaleDesiredTicks;
  AutoScaleMaxTicksEdit.AsInteger           := iAngularGauge.AutoScaleMaxTicks;
  AutoScaleEnabledCheckBox.AsBoolean        := iAngularGauge.AutoScaleEnabled;
  AutoScaleStyleRadioGroup.AsInteger        := ord(iAngularGauge.AutoScaleStyle);

  UpLoadOPCProperties(iAngularGauge, iOPCBrowserPanel);

  FPointerManager.Clear;

  for x := 0 to iAngularGauge.PointerCount-1 do
    begin
      FPointerManager.Add;
      FPointerManager.Items[x].Visible     := iAngularGauge.Pointers[x].Visible;
      FPointerManager.Items[x].UserCanMove := iAngularGauge.Pointers[x].UserCanMove;
      FPointerManager.Items[x].Position    := iAngularGauge.Pointers[x].Position;
      FPointerManager.Items[x].Size        := iAngularGauge.Pointers[x].Size;
      FPointerManager.Items[x].Margin      := iAngularGauge.Pointers[x].Margin;
      FPointerManager.Items[x].Color       := iAngularGauge.Pointers[x].Color;
      FPointerManager.Items[x].Style       := iAngularGauge.Pointers[x].Style;
    end;

  TickLabelFontPicker.Font.Assign(iAngularGauge.TickLabelFont);
  Label1FontPicker.Font.Assign(iAngularGauge.Label1Font);
  Label2FontPicker.Font.Assign(iAngularGauge.Label2Font);

  if iPointerListBox.Items.Count > FLastPointerIndex then iPointerListBox.ItemIndex := FLastPointerIndex;

  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iAngularGauge : TiAngularGauge;
  x             : Integer;
begin
  iAngularGauge := Component as TiAngularGauge;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  iAngularGauge.AutoScaleEnabled      := False;  //Required to set Min & Max before AutoScale Activates
  iAngularGauge.PositionMin           := PositionMinEdit.AsFloat;
  iAngularGauge.PositionMax           := PositionMaxEdit.AsFloat;
  iAngularGauge.CurrentMax            := CurrentMaxEdit.AsFloat;
  iAngularGauge.CurrentMin            := CurrentMinEdit.AsFloat;
  iAngularGauge.ShowInnerArcRadius    := ShowInnerArcRadiusCheckBox.AsBoolean;
  iAngularGauge.ShowOuterArcRadius    := ShowOuterArcRadiusCheckBox.AsBoolean;
  iAngularGauge.ShowDisabledState     := ShowDisabledStateCheckBox.AsBoolean;
  iAngularGauge.Enabled               := EnabledCheckBox.AsBoolean;
  iAngularGauge.BackGroundColor       := BackGroundColorPicker.Color;
  iAngularGauge.AutoFrameRate         := AutoFrameRateCheckBox.AsBoolean;
  iAngularGauge.UpdateFrameRate       := UpdateFrameRateEdit.AsInteger;

  iAngularGauge.BorderStyle           := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iAngularGauge.PrecisionStyle        := TiPrecisionStyle(PrecisionStyleRadioGroup.AsInteger);

  iAngularGauge.ArcRadius             := ArcRadiusEdit.AsInteger;
  iAngularGauge.ArcRangeDegrees       := ArcRangeDegreesEdit.AsInteger;
  iAngularGauge.ArcStartDegrees       := ArcStartDegreesEdit.AsInteger;

  iAngularGauge.ShowHub               := ShowHubCheckBox.AsBoolean;
  iAngularGauge.Hub3D                 := Hub3DCheckBox.AsBoolean;
  iAngularGauge.HubSize               := HubSizeEdit.AsInteger;
  iAngularGauge.HubColor              := HubColorPicker.Color;

  iAngularGauge.ShowFace              := ShowFaceCheckBox.AsBoolean;
  iAngularGauge.FaceStyle             := TiDrawEdgeStyle(FaceStyleComboBox.AsInteger);
  iAngularGauge.FaceBevelSize         := FaceBevelSizeEdit.AsInteger;
  iAngularGauge.FaceBevelStyle        := TiDrawEdgeStyle(FaceBevelStyleComboBox.AsInteger);
  iAngularGauge.FaceColor             := FaceColorPicker.Color;

  iAngularGauge.OffsetX               := OffsetXEdit.AsInteger;
  iAngularGauge.OffsetY               := OffsetYEdit.AsInteger;

  iAngularGauge.AutoCenter            := AutoCenterCheckBox.AsBoolean;
  iAngularGauge.AutoSize              := AutoSizeCheckBox.AsBoolean;
  iAngularGauge.OuterMargin           := OuterMarginEdit.AsInteger;

  iAngularGauge.ReverseScale          := ReverseScaleCheckBox.AsBoolean;
  iAngularGauge.CachedDrawing         := CachedDrawingCheckBox.AsBoolean;
  iAngularGauge.Transparent           := TransparentCheckBox.AsBoolean;
  //-------------- Pointers -----------------------------------------------------------------------------------------------------------------------
  iAngularGauge.MinMaxPointerSize     := MinMaxPointerSizeEdit.AsInteger;
  iAngularGauge.MinMaxPointerMargin   := MinMaxPointerMarginEdit.AsInteger;
  iAngularGauge.MinMaxFixed           := MinMaxFixedCheckBox.AsBoolean;
  iAngularGauge.MinMaxUserCanMove     := MinMaxUserCanMoveCheckBox.AsBoolean;
  iAngularGauge.MinMaxPointerStyle    := TiAngularGaugePointerStyle(MinMaxPointerStyleRadioGroup.AsInteger);

  iAngularGauge.ShowMaxPointer        := ShowMaxPointerCheckBox.AsBoolean;
  iAngularGauge.MaxPointerColor       := MaxPointerColorPicker.Color;

  iAngularGauge.ShowMinPointer        := ShowMinPointerCheckBox.AsBoolean;
  iAngularGauge.MinPointerColor       := MinPointerColorPicker.Color;
  //-------------- Ticks --------------------------------------------------------------------------------------------------------------------------
  iAngularGauge.TickMargin            := TickMarginEdit.AsInteger;

  iAngularGauge.ShowTickLabels        := ShowTickLabelsCheckBox.AsBoolean;
  iAngularGauge.TickLabelPrecision    := TickLabelPrecisionEdit.AsInteger;
  iAngularGauge.TickLabelMargin       := TickLabelMarginEdit.AsInteger;
  iAngularGauge.TickLabelAlignment    := TiLabelAlignment(TickLabelAlignmentRadioGroup.AsInteger);

  iAngularGauge.ShowTicksMajor        := ShowTicksMajorCheckBox.AsBoolean;
  iAngularGauge.TickMajorCount        := TickMajorCountEdit.AsInteger;
  iAngularGauge.TickMajorLength       := TickMajorLengthEdit.AsInteger;
  iAngularGauge.TickMajorColor        := TickMajorColorPicker.Color;

  iAngularGauge.ShowTicksMinor        := ShowTicksMinorCheckBox.AsBoolean;
  iAngularGauge.TickMinorCount        := TickMinorCountEdit.AsInteger;
  iAngularGauge.TickMinorLength       := TickMinorLengthEdit.AsInteger;
  iAngularGauge.TickMinorColor        := TickMinorColorPicker.Color;
  iAngularGauge.TickMinorAlignment    := TiTickMinorAlignment(TickMinorAlignmentRadioGroup.AsInteger);
  //-------------- Sections -----------------------------------------------------------------------------------------------------------------------
  iAngularGauge.SectionCount          := SectionCountEdit.AsInteger;
  iAngularGauge.SectionColor1         := SectionColor1Picker.Color;
  iAngularGauge.SectionColor2         := SectionColor2Picker.Color;
  iAngularGauge.SectionColor3         := SectionColor3Picker.Color;
  iAngularGauge.SectionColor4         := SectionColor4Picker.Color;
  iAngularGauge.SectionColor5         := SectionColor5Picker.Color;

  iAngularGauge.SectionEnd1           := SectionEnd1Edit.AsFloat;
  iAngularGauge.SectionEnd2           := SectionEnd2Edit.AsFloat;
  iAngularGauge.SectionEnd3           := SectionEnd3Edit.AsFloat;
  iAngularGauge.SectionEnd4           := SectionEnd4Edit.AsFloat;
  //-------------- Labels -------------------------------------------------------------------------------------------------------------------------
  iAngularGauge.Label1Text            := Label1TextEdit.AsString;
  iAngularGauge.ShowLabel1            := ShowLabel1CheckBox.AsBoolean;
  iAngularGauge.Label1OffsetX         := Label1OffsetXEdit.AsInteger;
  iAngularGauge.Label1OffsetY         := Label1OffsetYEdit.AsInteger;
  iAngularGauge.Label1AlignHorizontal := TiAlignmentHorizontal(Label1AlignHorizontalRadioGroup.AsInteger);
  iAngularGauge.Label1AlignVertical   := TiAlignmentVertical(Label1AlignVerticalRadioGroup.AsInteger);

  iAngularGauge.Label2Text            := Label2TextEdit.AsString;
  iAngularGauge.ShowLabel2            := ShowLabel2CheckBox.AsBoolean;
  iAngularGauge.Label2OffsetX         := Label2OffsetXEdit.AsInteger;
  iAngularGauge.Label2OffsetY         := Label2OffsetYEdit.AsInteger;
  iAngularGauge.Label2AlignHorizontal := TiAlignmentHorizontal(Label2AlignHorizontalRadioGroup.AsInteger);
  iAngularGauge.Label2AlignVertical   := TiAlignmentVertical(Label2AlignVerticalRadioGroup.AsInteger);
  //-------------- AutoScale -----------------------------------------------------------------------------------------------------------------------
  iAngularGauge.AutoScaleDesiredTicks := AutoScaleDesiredTicksEdit.AsInteger;
  iAngularGauge.AutoScaleMaxTicks     := AutoScaleMaxTicksEdit.AsInteger;
  iAngularGauge.AutoScaleStyle        := TiAutoScaleStyle(AutoScaleStyleRadioGroup.AsInteger);
  iAngularGauge.AutoScaleEnabled      := AutoScaleEnabledCheckBox.AsBoolean;

  DownLoadOPCProperties(iAngularGauge, iOPCBrowserPanel);

  iAngularGauge.RemoveAllPointers;
  for x := 0 to FPointerManager.Count-1 do
    begin
      if x <> 0 then iAngularGauge.AddPointer;

      iAngularGauge.Pointers[x].Visible     := FPointerManager.Items[x].Visible;
      iAngularGauge.Pointers[x].UserCanMove := FPointerManager.Items[x].UserCanMove;
      iAngularGauge.Pointers[x].Position    := FPointerManager.Items[x].Position;
      iAngularGauge.Pointers[x].Size        := FPointerManager.Items[x].Size;
      iAngularGauge.Pointers[x].Margin      := FPointerManager.Items[x].Margin;
      iAngularGauge.Pointers[x].Color       := FPointerManager.Items[x].Color;
      iAngularGauge.Pointers[x].Style       := FPointerManager.Items[x].Style;
    end;

  iAngularGauge.TickLabelFont.Assign(TickLabelFontPicker.Font);
  iAngularGauge.Label1Font.Assign(Label1FontPicker.Font);
  iAngularGauge.Label2Font.Assign(Label2FontPicker.Font);

  FLastPointerIndex := iPointerListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.iComponentEditorFormCreate(Sender: TObject);
begin
  FPointerManager := TiGaugePointerManager.Create(ChangeEvent, InsertEvent, RemoveEvent, nil);
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  FPointerManager.Free;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.iPointerListBoxClick(Sender: TObject);
begin
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.iPointerListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (iPointerListBox.Items.Objects[Index] as TiGaugePointer).Color;
  AText  := 'Pointer(' + IntToStr(Index) + ')';
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.InsertEvent(Sender: TObject);
begin
  if Sender is TiGaugePointer then  iPointerListBox.Items.AddObject('',Sender);
  iPointerListBox.SelectLast;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.RemoveEvent(Sender: TObject);
begin
  iPointerListBox.Items.Delete(iPointerListBox.Items.IndexOfObject(Sender));
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.ChangeEvent(Sender: TObject);
begin
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.iPointerAddButtonClick(Sender: TObject);
begin
  FPointerManager.Add;
  UpdatePointers;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.PointerRemoveButtonClick(Sender: TObject);
begin
  iPointerListBox.DeleteSelectedObject;
  UpdatePointers;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.PositionEditChange(Sender: TObject);
begin
  FPointerManager.Items[0].Position := PositionEdit.AsFloat;
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.UpdatePointers;
var
  iPointer : TiGaugePointer;
begin
  if iPointerListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Pointer')
    else
      begin
        EnableAllEditControlsStartingWith('Pointer');

        iPointer := iPointerListBox.Items.Objects[iPointerListBox.ItemIndex] as TiGaugePointer;

        PointerVisibleCheckBox.AsBoolean     := iPointer.Visible;
        PointerUserCanMoveCheckBox.AsBoolean := iPointer.UserCanMove;
        PointerPositionEdit.AsFloat          := iPointer.Position;
        PointerSizeEdit.AsInteger            := iPointer.Size;
        PointerMarginEdit.AsInteger          := iPointer.Margin;
        PointerColorPicker.Color             := iPointer.Color;
        PointerStyleRadioGroup.AsInteger     := iPointer.Style;

        iPointerListBox.Invalidate;

        if iPointerListBox.ItemIndex = 0 then PointerRemoveButton.Enabled := False;
      end;
end;
//****************************************************************************************************************************************************
procedure TiAngularGaugeComponentEditorForm.PointerChange(Sender: TObject);
var
  iPointer : TiGaugePointer;
begin
  if iPointerListBox.ItemIndex = -1 then exit;

  iPointer := iPointerListBox.Items.Objects[iPointerListBox.ItemIndex] as TiGaugePointer;

  iPointer.Visible     := PointerVisibleCheckBox.AsBoolean;
  iPointer.UserCanMove := PointerUserCanMoveCheckBox.AsBoolean;
  iPointer.Position    := PointerPositionEdit.AsFloat;
  iPointer.Size        := PointerSizeEdit.AsInteger;
  iPointer.Margin      := PointerMarginEdit.AsInteger;
  iPointer.Color       := PointerColorPicker.Color;
  iPointer.Style       := PointerStyleRadioGroup.AsInteger;

  if iPointerListBox.ItemIndex = 0 then
    begin
      PositionEdit.AsFloat := PointerPositionEdit.AsFloat;
    end;

  UpdatePointers;
end;
//****************************************************************************************************************************************************
end.
