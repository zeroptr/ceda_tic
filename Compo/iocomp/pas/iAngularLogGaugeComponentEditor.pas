{*******************************************************}
{                                                       }
{       TiAngularLogGaugeComponentEditor                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iAngularLogGaugeComponentEditor;{$endif}
{$ifdef iCLX}unit QiAngularLogGaugeComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iAngularLogGauge,  iGaugePointer,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiAngularLogGauge, QiGaugePointer,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel, iRadioGroup,   iComponent,  iVCLComponent,  iCustomComponent,  iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel, QiRadioGroup, QiComponent, QiCLXComponent, QiCustomComponent, QiCheckBox;{$ENDIF}

type
  TiAngularLogGaugeComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    DesignTabSheet: TTabSheet;
    Label43: TLabel;
    Label44: TLabel;
    CurrentMaxEdit: TiComponentEditorEdit;
    CurrentMinEdit: TiComponentEditorEdit;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
    iComponentEditorPageControl1: TiComponentEditorPageControl;
    DesignSectionsTabSheet: TTabSheet;
    DesignGeneralTabSheet: TTabSheet;
    DesignArcHubTabSheet: TTabSheet;
    DesignPointersTabSheet: TTabSheet;
    DesignTicksTabSheet: TTabSheet;
    DesignLabelsTabSheet: TTabSheet;
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
    DesignMinMaxTabSheet: TTabSheet;
    ShowInnerArcRadiusCheckBox: TiComponentEditorCheckBox;
    ShowOuterArcRadiusCheckBox: TiComponentEditorCheckBox;
    Label3: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    OffsetGroupBox: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
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
    Label28: TLabel;
    TickMarginUpDown: TiUpDown;
    LabelsGroupBox: TGroupBox;
    Label15: TLabel;
    Label19: TLabel;
    TickLabelPrecisionUpDown: TiUpDown;
    TickLabelMarginUpDown: TiUpDown;
    TickLabelFontPicker: TiComponentEditorFontPicker;
    TickLabelPrecisionEdit: TiComponentEditorEdit;
    TickLabelMarginEdit: TiComponentEditorEdit;
    TickLabelStyleRadioGroup: TiComponentEditorRadioGroup;
    MinorGroupBox: TGroupBox;
    Label25: TLabel;
    Label27: TLabel;
    TickMinorLengthUpDown: TiUpDown;
    TickMinorColorPicker: TiComponentEditorColorPicker;
    TickMinorLengthEdit: TiComponentEditorEdit;
    TickMinorAlignmentRadioGroup: TiComponentEditorRadioGroup;
    TickMarginEdit: TiComponentEditorEdit;
    MajorGroupBox: TGroupBox;
    Label20: TLabel;
    Label24: TLabel;
    TickMajorLengthUpDown: TiUpDown;
    TickMajorColorPicker: TiComponentEditorColorPicker;
    TickMajorLengthEdit: TiComponentEditorEdit;
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
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    PointerVisibleCheckBox: TiComponentEditorCheckBox;
    Label49: TLabel;
    OuterMarginUpDown: TiUpDown;
    AutoCenterCheckBox: TiComponentEditorCheckBox;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    OuterMarginEdit: TiComponentEditorEdit;
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
    Hub3DCheckBox: TiComponentEditorCheckBox;
    FaceGroupBox: TGroupBox;
    Label51: TLabel;
    Label52: TLabel;
    FaceColorPicker: TiComponentEditorColorPicker;
    ShowFaceCheckBox: TiComponentEditorCheckBox;
    FaceStyleComboBox: TiComponentEditorComboBox;
    FaceBevelGroupBox: TGroupBox;
    Label48: TLabel;
    FaceBevelSizeUpDown: TiUpDown;
    Label53: TLabel;
    FaceBevelSizeEdit: TiComponentEditorEdit;
    FaceBevelStyleComboBox: TiComponentEditorComboBox;
    PointerUserCanMoveCheckBox: TiComponentEditorCheckBox;
    ShowDisabledStateCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
    ReverseScaleCheckBox: TiComponentEditorCheckBox;
    procedure PointerChange(Sender: TObject);
    procedure iPointerAddButtonClick(Sender: TObject);
    procedure PointerRemoveButtonClick(Sender: TObject);
    procedure iPointerListBoxClick(Sender: TObject);
    procedure iPointerListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure PositionEditChange(Sender: TObject);
    procedure iComponentEditorFormCreate(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
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
  iAngularLogGaugeComponentEditorForm: TiAngularLogGaugeComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiAngularLogGauge.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iAngularLogGauge : TiAngularLogGauge;
  x                : Integer;
begin
  iAngularLogGauge := Component as TiAngularLogGauge;

  //-------------- General --------------------------------------------------------------------------------------------------------------------
  PositionEdit.AsFloat                      := iAngularLogGauge.Position;
  PositionMaxEdit.AsFloat                   := iAngularLogGauge.PositionMax;
  PositionMinEdit.AsFloat                   := iAngularLogGauge.PositionMin;
  CurrentMaxEdit.AsFloat                    := iAngularLogGauge.CurrentMax;
  CurrentMinEdit.AsFloat                    := iAngularLogGauge.CurrentMin;
  ShowInnerArcRadiusCheckBox.AsBoolean      := iAngularLogGauge.ShowInnerArcRadius;
  ShowOuterArcRadiusCheckBox.AsBoolean      := iAngularLogGauge.ShowOuterArcRadius;
  ReverseScaleCheckBox.AsBoolean            := iAngularLogGauge.ReverseScale;
  ShowDisabledStateCheckBox.AsBoolean       := iAngularLogGauge.ShowDisabledState;
  EnabledCheckBox.AsBoolean                 := iAngularLogGauge.Enabled;
  BackGroundColorPicker.Color               := iAngularLogGauge.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean           := iAngularLogGauge.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger             := iAngularLogGauge.UpdateFrameRate;

  BorderStyleRadioGroup.AsInteger           := ord(iAngularLogGauge.BorderStyle);

  ArcRadiusEdit.AsInteger                   := iAngularLogGauge.ArcRadius;
  ArcRangeDegreesEdit.AsInteger             := iAngularLogGauge.ArcRangeDegrees;
  ArcStartDegreesEdit.AsInteger             := iAngularLogGauge.ArcStartDegrees;

  ShowHubCheckBox.AsBoolean                 := iAngularLogGauge.ShowHub;
  Hub3DCheckBox.AsBoolean                   := iAngularLogGauge.Hub3D;
  HubSizeEdit.AsInteger                     := iAngularLogGauge.HubSize;
  HubColorPicker.Color                      := iAngularLogGauge.HubColor;

  ShowFaceCheckBox.AsBoolean                := iAngularLogGauge.ShowFace;
  FaceStyleComboBox.AsInteger               := ord(iAngularLogGauge.FaceStyle);
  FaceBevelSizeEdit.AsInteger               := iAngularLogGauge.FaceBevelSize;
  FaceBevelStyleComboBox.AsInteger          := ord(iAngularLogGauge.FaceBevelStyle);
  FaceColorPicker.Color                     := iAngularLogGauge.FaceColor;

  OffsetXEdit.AsInteger                     := iAngularLogGauge.OffsetX;
  OffsetYEdit.AsInteger                     := iAngularLogGauge.OffsetY;

  AutoSizeCheckBox.AsBoolean                := iAngularLogGauge.AutoSize;
  OuterMarginEdit.AsInteger                 := iAngularLogGauge.OuterMargin;
  AutoCenterCheckBox.AsBoolean              := iAngularLogGauge.AutoCenter;

  CachedDrawingCheckBox.AsBoolean           := iAngularLogGauge.CachedDrawing;
  TransparentCheckBox.AsBoolean             := iAngularLogGauge.Transparent;
  //-------------- Pointers -------------------------------------------------------------------------------------------------------------------
  MinMaxPointerSizeEdit.AsInteger           := iAngularLogGauge.MinMaxPointerSize;
  MinMaxPointerMarginEdit.AsInteger         := iAngularLogGauge.MinMaxPointerMargin;
  MinMaxFixedCheckBox.AsBoolean             := iAngularLogGauge.MinMaxFixed;
  MinMaxUserCanMoveCheckBox.AsBoolean       := iAngularLogGauge.MinMaxUserCanMove;
  MinMaxPointerStyleRadioGroup.AsInteger    := ord(iAngularLogGauge.MinMaxPointerStyle);

  ShowMaxPointerCheckBox.AsBoolean          := iAngularLogGauge.ShowMaxPointer;
  MaxPointerColorPicker.Color               := iAngularLogGauge.MaxPointerColor;

  ShowMinPointerCheckBox.AsBoolean          := iAngularLogGauge.ShowMinPointer;
  MinPointerColorPicker.Color               := iAngularLogGauge.MinPointerColor;
  //-------------- Ticks ----------------------------------------------------------------------------------------------------------------------
  TickMarginEdit.AsInteger                  := iAngularLogGauge.TickMargin;

  TickLabelPrecisionEdit.AsInteger          := iAngularLogGauge.TickLabelPrecision;
  TickLabelMarginEdit.AsInteger             := iAngularLogGauge.TickLabelMargin;
  TickLabelStyleRadioGroup.AsInteger        := ord(iAngularLogGauge.TickLabelStyle);

  TickMajorLengthEdit.AsInteger             := iAngularLogGauge.TickMajorLength;
  TickMajorColorPicker.Color                := iAngularLogGauge.TickMajorColor;

  TickMinorLengthEdit.AsInteger             := iAngularLogGauge.TickMinorLength;
  TickMinorColorPicker.Color                := iAngularLogGauge.TickMinorColor;
  TickMinorAlignmentRadioGroup.AsInteger    := ord(iAngularLogGauge.TickMinorAlignment);
  //-------------- Sections -------------------------------------------------------------------------------------------------------------------
  SectionCountEdit.AsInteger                := iAngularLogGauge.SectionCount;

  SectionColor1Picker.Color                 := iAngularLogGauge.SectionColor1;
  SectionColor2Picker.Color                 := iAngularLogGauge.SectionColor2;
  SectionColor3Picker.Color                 := iAngularLogGauge.SectionColor3;
  SectionColor4Picker.Color                 := iAngularLogGauge.SectionColor4;
  SectionColor5Picker.Color                 := iAngularLogGauge.SectionColor5;

  SectionEnd1Edit.AsFloat                   := iAngularLogGauge.SectionEnd1;
  SectionEnd2Edit.AsFloat                   := iAngularLogGauge.SectionEnd2;
  SectionEnd3Edit.AsFloat                   := iAngularLogGauge.SectionEnd3;
  SectionEnd4Edit.AsFloat                   := iAngularLogGauge.SectionEnd4;
  //-------------- Labels ---------------------------------------------------------------------------------------------------------------------
  Label1TextEdit.AsString                   := iAngularLogGauge.Label1Text;
  ShowLabel1CheckBox.AsBoolean              := iAngularLogGauge.ShowLabel1;
  Label1OffsetXEdit.AsInteger               := iAngularLogGauge.Label1OffsetX;
  Label1OffsetYEdit.AsInteger               := iAngularLogGauge.Label1OffsetY;
  Label1AlignHorizontalRadioGroup.AsInteger := ord(iAngularLogGauge.Label1AlignHorizontal);
  Label1AlignVerticalRadioGroup.AsInteger   := ord(iAngularLogGauge.Label1AlignVertical);

  Label2TextEdit.AsString                   := iAngularLogGauge.Label2Text;
  ShowLabel2CheckBox.AsBoolean              := iAngularLogGauge.ShowLabel2;
  Label2OffsetXEdit.AsInteger               := iAngularLogGauge.Label2OffsetX;
  Label2OffsetYEdit.AsInteger               := iAngularLogGauge.Label2OffsetY;
  Label2AlignHorizontalRadioGroup.AsInteger := ord(iAngularLogGauge.Label2AlignHorizontal);
  Label2AlignVerticalRadioGroup.AsInteger   := ord(iAngularLogGauge.Label2AlignVertical);

  UpLoadOPCProperties(iAngularLogGauge, iOPCBrowserPanel);

  FPointerManager.Clear;

  for x := 0 to iAngularLogGauge.PointerCount-1 do
    begin
      FPointerManager.Add;
      FPointerManager.Items[x].Visible     := iAngularLogGauge.Pointers[x].Visible;
      FPointerManager.Items[x].UserCanMove := iAngularLogGauge.Pointers[x].UserCanMove;
      FPointerManager.Items[x].Position    := iAngularLogGauge.Pointers[x].Position;
      FPointerManager.Items[x].Size        := iAngularLogGauge.Pointers[x].Size;
      FPointerManager.Items[x].Margin      := iAngularLogGauge.Pointers[x].Margin;
      FPointerManager.Items[x].Color       := iAngularLogGauge.Pointers[x].Color;
      FPointerManager.Items[x].Style       := iAngularLogGauge.Pointers[x].Style;
    end;

  TickLabelFontPicker.Font.Assign(iAngularLogGauge.TickLabelFont);
  Label1FontPicker.Font.Assign(iAngularLogGauge.Label1Font);
  Label2FontPicker.Font.Assign(iAngularLogGauge.Label2Font);
  
  if iPointerListBox.Items.Count > FLastPointerIndex then iPointerListBox.ItemIndex := FLastPointerIndex;

  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iAngularLogGauge : TiAngularLogGauge;
  x                : Integer;
begin
  iAngularLogGauge := Component as TiAngularLogGauge;

  //-------------- General ------------------------------------------------------------------------------------------------------------------------
  iAngularLogGauge.PositionMax           := PositionMaxEdit.AsFloat;
  iAngularLogGauge.PositionMin           := PositionMinEdit.AsFloat;
  iAngularLogGauge.CurrentMax            := CurrentMaxEdit.AsFloat;
  iAngularLogGauge.CurrentMin            := CurrentMinEdit.AsFloat;
  iAngularLogGauge.ShowInnerArcRadius    := ShowInnerArcRadiusCheckBox.AsBoolean;
  iAngularLogGauge.ShowOuterArcRadius    := ShowOuterArcRadiusCheckBox.AsBoolean;
  iAngularLogGauge.ReverseScale          := ReverseScaleCheckBox.AsBoolean;
  iAngularLogGauge.ShowDisabledState     := ShowDisabledStateCheckBox.AsBoolean;
  iAngularLogGauge.Enabled               := EnabledCheckBox.AsBoolean;
  iAngularLogGauge.BackGroundColor       := BackGroundColorPicker.Color;
  iAngularLogGauge.AutoFrameRate         := AutoFrameRateCheckBox.AsBoolean;
  iAngularLogGauge.UpdateFrameRate       := UpdateFrameRateEdit.AsInteger;

  iAngularLogGauge.BorderStyle           := TiBevelStyle(BorderStyleRadioGroup.AsInteger);

  iAngularLogGauge.ArcRadius             := ArcRadiusEdit.AsInteger;
  iAngularLogGauge.ArcRangeDegrees       := ArcRangeDegreesEdit.AsInteger;
  iAngularLogGauge.ArcStartDegrees       := ArcStartDegreesEdit.AsInteger;

  iAngularLogGauge.ShowHub               := ShowHubCheckBox.AsBoolean;
  iAngularLogGauge.Hub3D                 := Hub3DCheckBox.AsBoolean;
  iAngularLogGauge.HubSize               := HubSizeEdit.AsInteger;
  iAngularLogGauge.HubColor              := HubColorPicker.Color;

  iAngularLogGauge.ShowFace              := ShowFaceCheckBox.AsBoolean;
  iAngularLogGauge.FaceStyle             := TiDrawEdgeStyle(FaceStyleComboBox.AsInteger);
  iAngularLogGauge.FaceBevelSize         := FaceBevelSizeEdit.AsInteger;
  iAngularLogGauge.FaceBevelStyle        := TiDrawEdgeStyle(FaceBevelStyleComboBox.AsInteger);
  iAngularLogGauge.FaceColor             := FaceColorPicker.Color;

  iAngularLogGauge.OffsetX               := OffsetXEdit.AsInteger;
  iAngularLogGauge.OffsetY               := OffsetYEdit.AsInteger;

  iAngularLogGauge.AutoCenter            := AutoCenterCheckBox.AsBoolean;
  iAngularLogGauge.AutoSize              := AutoSizeCheckBox.AsBoolean;
  iAngularLogGauge.OuterMargin           := OuterMarginEdit.AsInteger;

  iAngularLogGauge.CachedDrawing         := CachedDrawingCheckBox.AsBoolean;
  iAngularLogGauge.Transparent           := TransparentCheckBox.AsBoolean;
  //-------------- Pointers -----------------------------------------------------------------------------------------------------------------------
  iAngularLogGauge.MinMaxPointerSize     := MinMaxPointerSizeEdit.AsInteger;
  iAngularLogGauge.MinMaxPointerMargin   := MinMaxPointerMarginEdit.AsInteger;
  iAngularLogGauge.MinMaxFixed           := MinMaxFixedCheckBox.AsBoolean;
  iAngularLogGauge.MinMaxUserCanMove     := MinMaxUserCanMoveCheckBox.AsBoolean;
  iAngularLogGauge.MinMaxPointerStyle    := TiAngularGaugePointerStyle(MinMaxPointerStyleRadioGroup.AsInteger);

  iAngularLogGauge.ShowMaxPointer        := ShowMaxPointerCheckBox.AsBoolean;
  iAngularLogGauge.MaxPointerColor       := MaxPointerColorPicker.Color;

  iAngularLogGauge.ShowMinPointer        := ShowMinPointerCheckBox.AsBoolean;
  iAngularLogGauge.MinPointerColor       := MinPointerColorPicker.Color;
  //-------------- Ticks --------------------------------------------------------------------------------------------------------------------------
  iAngularLogGauge.TickMargin            := TickMarginEdit.AsInteger;

  iAngularLogGauge.TickLabelPrecision    := TickLabelPrecisionEdit.AsInteger;
  iAngularLogGauge.TickLabelMargin       := TickLabelMarginEdit.AsInteger;
  iAngularLogGauge.TickLabelStyle        := TiLogLabelStyle(TickLabelStyleRadioGroup.AsInteger);

  iAngularLogGauge.TickMajorLength       := TickMajorLengthEdit.AsInteger;
  iAngularLogGauge.TickMajorColor        := TickMajorColorPicker.Color;

  iAngularLogGauge.TickMinorLength       := TickMinorLengthEdit.AsInteger;
  iAngularLogGauge.TickMinorColor        := TickMinorColorPicker.Color;
  iAngularLogGauge.TickMinorAlignment    := TiTickMinorAlignment(TickMinorAlignmentRadioGroup.AsInteger);
  //-------------- Sections -----------------------------------------------------------------------------------------------------------------------
  iAngularLogGauge.SectionCount          := SectionCountEdit.AsInteger;
  iAngularLogGauge.SectionColor1         := SectionColor1Picker.Color;
  iAngularLogGauge.SectionColor2         := SectionColor2Picker.Color;
  iAngularLogGauge.SectionColor3         := SectionColor3Picker.Color;
  iAngularLogGauge.SectionColor4         := SectionColor4Picker.Color;
  iAngularLogGauge.SectionColor5         := SectionColor5Picker.Color;

  iAngularLogGauge.SectionEnd1           := SectionEnd1Edit.AsFloat;
  iAngularLogGauge.SectionEnd2           := SectionEnd2Edit.AsFloat;
  iAngularLogGauge.SectionEnd3           := SectionEnd3Edit.AsFloat;
  iAngularLogGauge.SectionEnd4           := SectionEnd4Edit.AsFloat;
  //-------------- Labels -------------------------------------------------------------------------------------------------------------------------
  iAngularLogGauge.Label1Text            := Label1TextEdit.AsString;
  iAngularLogGauge.ShowLabel1            := ShowLabel1CheckBox.AsBoolean;
  iAngularLogGauge.Label1OffsetX         := Label1OffsetXEdit.AsInteger;
  iAngularLogGauge.Label1OffsetY         := Label1OffsetYEdit.AsInteger;
  iAngularLogGauge.Label1AlignHorizontal := TiAlignmentHorizontal(Label1AlignHorizontalRadioGroup.AsInteger);
  iAngularLogGauge.Label1AlignVertical   := TiAlignmentVertical(Label1AlignVerticalRadioGroup.AsInteger);

  iAngularLogGauge.Label2Text            := Label2TextEdit.AsString;
  iAngularLogGauge.ShowLabel2            := ShowLabel2CheckBox.AsBoolean;
  iAngularLogGauge.Label2OffsetX         := Label2OffsetXEdit.AsInteger;
  iAngularLogGauge.Label2OffsetY         := Label2OffsetYEdit.AsInteger;
  iAngularLogGauge.Label2AlignHorizontal := TiAlignmentHorizontal(Label2AlignHorizontalRadioGroup.AsInteger);
  iAngularLogGauge.Label2AlignVertical   := TiAlignmentVertical(Label2AlignVerticalRadioGroup.AsInteger);

  DownLoadOPCProperties(iAngularLogGauge, iOPCBrowserPanel);

  iAngularLogGauge.RemoveAllPointers;
  for x := 0 to FPointerManager.Count-1 do
    begin
      if x <> 0 then iAngularLogGauge.AddPointer;

      iAngularLogGauge.Pointers[x].Visible     := FPointerManager.Items[x].Visible;
      iAngularLogGauge.Pointers[x].UserCanMove := FPointerManager.Items[x].UserCanMove;
      iAngularLogGauge.Pointers[x].Position    := FPointerManager.Items[x].Position;
      iAngularLogGauge.Pointers[x].Size        := FPointerManager.Items[x].Size;
      iAngularLogGauge.Pointers[x].Margin      := FPointerManager.Items[x].Margin;
      iAngularLogGauge.Pointers[x].Color       := FPointerManager.Items[x].Color;
      iAngularLogGauge.Pointers[x].Style       := FPointerManager.Items[x].Style;
    end;

  iAngularLogGauge.TickLabelFont.Assign(TickLabelFontPicker.Font);
  iAngularLogGauge.Label1Font.Assign(Label1FontPicker.Font);
  iAngularLogGauge.Label2Font.Assign(Label2FontPicker.Font);

  FLastPointerIndex := iPointerListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.iComponentEditorFormCreate(Sender: TObject);
begin
  FPointerManager := TiGaugePointerManager.Create(ChangeEvent, InsertEvent, RemoveEvent, nil);
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  FPointerManager.Free;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.iPointerListBoxClick(Sender: TObject);
begin
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.iPointerListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (iPointerListBox.Items.Objects[Index] as TiGaugePointer).Color;
  AText  := 'Pointer(' + IntToStr(Index) + ')';
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.InsertEvent(Sender: TObject);
begin
  if Sender is TiGaugePointer then (Sender as TiGaugePointer).Position := 1;
  if Sender is TiGaugePointer then  iPointerListBox.Items.AddObject('',Sender);
  iPointerListBox.SelectLast;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.RemoveEvent(Sender: TObject);
begin
  iPointerListBox.Items.Delete(iPointerListBox.Items.IndexOfObject(Sender));
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.ChangeEvent(Sender: TObject);
begin
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.iPointerAddButtonClick(Sender: TObject);
begin
  FPointerManager.Add;
  UpdatePointers;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.PointerRemoveButtonClick(Sender: TObject);
begin
  iPointerListBox.DeleteSelectedObject;
  UpdatePointers;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.PositionEditChange(Sender: TObject);
begin
  FPointerManager.Items[0].Position := PositionEdit.AsFloat;
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiAngularLogGaugeComponentEditorForm.UpdatePointers;
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
procedure TiAngularLogGaugeComponentEditorForm.PointerChange(Sender: TObject);
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
