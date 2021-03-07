{*******************************************************}
{                                                       }
{       TiLinearGaugeComponentEditor                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLinearGaugeComponentEditor;{$endif}
{$ifdef iCLX}unit QiLinearGaugeComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLinearGauge,  iGaugePointer,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLinearGauge, QiGaugePointer,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,  iRadioGroup,  iComponent,  iVCLComponent,  iCustomComponent,  iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel, QiRadioGroup, QiComponent, QiCLXComponent, QiCustomComponent, QiCheckBox;{$ENDIF}

type
  TiLinearGaugeComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    DesignTabSheet: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    CurrentMaxEdit: TiComponentEditorEdit;
    CurrentMinEdit: TiComponentEditorEdit;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AutoScaleTabSheet: TTabSheet;
    Label46: TLabel;
    Label47: TLabel;
    AutoScaleEnabledCheckBox: TiComponentEditorCheckBox;
    AutoScaleDesiredTicksEdit: TiComponentEditorEdit;
    AutoScaleDesiredTicksUpDown: TiUpDown;
    AutoScaleMaxTicksEdit: TiComponentEditorEdit;
    AutoScaleMaxTicksUpDown: TiUpDown;
    AutoScaleStyleRadioGroup: TiComponentEditorRadioGroup;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
    DesignPageControl: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    DesignPointersTabSheet: TTabSheet;
    DesignMinMaxTabSheet: TTabSheet;
    DesignSectionsTabSheet: TTabSheet;
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
    DesignTicksTabSheet: TTabSheet;
    iPointerListBox: TiComponentEditorListBox;
    PointersGeneralPageControl: TiComponentEditorPageControl;
    TabSheet1: TTabSheet;
    iPointerAddButton: TButton;
    PointerRemoveButton: TButton;
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
    MinMaxFixedCheckBox: TiComponentEditorCheckBox;
    MinMaxUserCanMoveCheckBox: TiComponentEditorCheckBox;
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
    TickMinorStyleRadioGroup: TiComponentEditorRadioGroup;
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
    TickMajorStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowTicksAxisCheckBox: TiComponentEditorCheckBox;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label3: TLabel;
    Label29: TLabel;
    EndsMarginUpDown: TiUpDown;
    OrientationRadioGroup: TiComponentEditorRadioGroup;
    OrientationTickMarksRadioGroup: TiComponentEditorRadioGroup;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    OffsetGroupBox: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    PrecisionStyleRadioGroup: TiComponentEditorRadioGroup;
    ReverseScaleCheckBox: TiComponentEditorCheckBox;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    EndsMarginEdit: TiComponentEditorEdit;
    AutoCenterCheckBox: TiComponentEditorCheckBox;
    OffsetLabel: TLabel;
    Label4: TLabel;
    PointerOffsetUpDown: TiUpDown;
    PointerSizeUpDown: TiUpDown;
    Label9: TLabel;
    Label50: TLabel;
    PointerOffsetEdit: TiComponentEditorEdit;
    PointerSizeEdit: TiComponentEditorEdit;
    PointerColorPicker: TiComponentEditorColorPicker;
    PointerPositionEdit: TiComponentEditorEdit;
    PointerVisibleCheckBox: TiComponentEditorCheckBox;
    PointerUserCanMoveCheckBox: TiComponentEditorCheckBox;
    ShowDisabledStateCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
    PointerStyle3DCheckBox: TiComponentEditorCheckBox;
    PointerStyleComboBox: TiComponentEditorComboBox;
    Label1: TLabel;
    PointerEnabledCheckBox: TiComponentEditorCheckBox;
    MinMaxStyle3DCheckBox: TiComponentEditorCheckBox;
    PointerDrawScaleSideCheckBox: TiComponentEditorCheckBox;
    PointerUseDisabledColorCheckBox: TiComponentEditorCheckBox;
    Label36: TLabel;
    PointerDisabledColorPicker: TiComponentEditorColorPicker;
    KeyStepSizeGroupBox: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    KeyArrowStepSizeEdit: TiComponentEditorEdit;
    KeyPageStepSizeEdit: TiComponentEditorEdit;
    MouseWheelStepSizeEdit: TiComponentEditorEdit;
    AllowFocusCheckBox: TiComponentEditorCheckBox;
    procedure iComponentEditorFormCreate(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure iPointerListBoxClick(Sender: TObject);
    procedure iPointerListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure iPointerAddButtonClick(Sender: TObject);
    procedure PointerRemoveButtonClick(Sender: TObject);
    procedure PositionEditChange(Sender: TObject);
    procedure PointerChange(Sender: TObject);
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
  iLinearGaugeComponentEditorForm: TiLinearGaugeComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLinearGauge.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLinearGauge : TiLinearGauge;
  x            : Integer;
begin
  iLinearGauge := Component as TiLinearGauge;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  PositionEdit.AsFloat                             := iLinearGauge.Position;
  PositionMaxEdit.AsFloat                          := iLinearGauge.PositionMax;
  PositionMinEdit.AsFloat                          := iLinearGauge.PositionMin;
  CurrentMaxEdit.AsFloat                           := iLinearGauge.CurrentMax;
  CurrentMinEdit.AsFloat                           := iLinearGauge.CurrentMin;
  EndsMarginEdit.AsInteger                         := iLinearGauge.EndsMargin;
  BackGroundColorPicker.Color                      := iLinearGauge.BackGroundColor;

  BorderStyleRadioGroup.AsInteger                  := ord(iLinearGauge.BorderStyle);
  OrientationRadioGroup.AsInteger                  := ord(iLinearGauge.Orientation);
  OrientationTickMarksRadioGroup.AsInteger         := ord(iLinearGauge.OrientationTickMarks);
  PrecisionStyleRadioGroup.AsInteger               := ord(iLinearGauge.PrecisionStyle);
  ReverseScaleCheckBox.AsBoolean                   := iLinearGauge.ReverseScale;
  CachedDrawingCheckBox.AsBoolean                  := iLinearGauge.CachedDrawing;
  TransparentCheckBox.AsBoolean                    := iLinearGauge.Transparent;
  AutoFrameRateCheckBox.AsBoolean                  := iLinearGauge.AutoFrameRate;
  AutoCenterCheckBox.AsBoolean                     := iLinearGauge.AutoCenter;
  UpdateFrameRateEdit.AsInteger                    := iLinearGauge.UpdateFrameRate;
  ShowDisabledStateCheckBox.AsBoolean              := iLinearGauge.ShowDisabledState;
  EnabledCheckBox.AsBoolean                        := iLinearGauge.Enabled;

  KeyArrowStepSizeEdit.AsFloat                     := iLinearGauge.KeyArrowStepSize;
  KeyPageStepSizeEdit.AsFloat                      := iLinearGauge.KeyPageStepSize;
  MouseWheelStepSizeEdit.AsFloat                   := iLinearGauge.MouseWheelStepSize;

  AllowFocusCheckBox.AsBoolean                     := iLinearGauge.AllowFocus;

  OffsetXEdit.AsInteger                            := iLinearGauge.OffsetX;
  OffsetYEdit.AsInteger                            := iLinearGauge.OffsetY;
  //-------------- Pointers --------------------------------------------------------------------------------------------------------------------------
  MinMaxPointerSizeEdit.AsInteger                  := iLinearGauge.MinMaxPointerSize;
  MinMaxPointerMarginEdit.AsInteger                := iLinearGauge.MinMaxPointerMargin;
  MinMaxFixedCheckBox.AsBoolean                    := iLinearGauge.MinMaxFixed;
  MinMaxUserCanMoveCheckBox.AsBoolean              := iLinearGauge.MinMaxUserCanMove;
  MinMaxStyle3DCheckBox.AsBoolean                  := iLinearGauge.MinMaxStyle3D;

  ShowMaxPointerCheckBox.AsBoolean                 := iLinearGauge.ShowMaxPointer;
  MaxPointerColorPicker.Color                      := iLinearGauge.MaxPointerColor;

  ShowMinPointerCheckBox.AsBoolean                 := iLinearGauge.ShowMinPointer;
  MinPointerColorPicker.Color                      := iLinearGauge.MinPointerColor;
  //-------------- Ticks -----------------------------------------------------------------------------------------------------------------------------
  ShowTicksAxisCheckBox.AsBoolean                  := iLinearGauge.ShowTicksAxis;
  TickMarginEdit.AsInteger                         := iLinearGauge.TickMargin;

  ShowTickLabelsCheckBox.AsBoolean                 := iLinearGauge.ShowTickLabels;
  TickLabelPrecisionEdit.AsInteger                 := iLinearGauge.TickLabelPrecision;
  TickLabelMarginEdit.AsInteger                    := iLinearGauge.TickLabelMargin;

  ShowTicksMajorCheckBox.AsBoolean                 := iLinearGauge.ShowTicksMajor;
  TickMajorCountEdit.AsInteger                     := iLinearGauge.TickMajorCount;
  TickMajorLengthEdit.AsInteger                    := iLinearGauge.TickMajorLength;
  TickMajorColorPicker.Color                       := iLinearGauge.TickMajorColor;
  TickMajorStyleRadioGroup.AsInteger               := ord(iLinearGauge.TickMajorStyle);

  ShowTicksMinorCheckBox.AsBoolean                 := iLinearGauge.ShowTicksMinor;
  TickMinorCountEdit.AsInteger                     := iLinearGauge.TickMinorCount;
  TickMinorLengthEdit.AsInteger                    := iLinearGauge.TickMinorLength;
  TickMinorColorPicker.Color                       := iLinearGauge.TickMinorColor;
  TickMinorAlignmentRadioGroup.AsInteger           := ord(iLinearGauge.TickMinorAlignment);
  TickMinorStyleRadioGroup.AsInteger               := ord(iLinearGauge.TickMinorStyle);
  //-------------- Sections --------------------------------------------------------------------------------------------------------------------------
  SectionCountEdit.AsInteger                       := iLinearGauge.SectionCount;
  SectionColor1Picker.Color                        := iLinearGauge.SectionColor1;
  SectionColor2Picker.Color                        := iLinearGauge.SectionColor2;
  SectionColor3Picker.Color                        := iLinearGauge.SectionColor3;
  SectionColor4Picker.Color                        := iLinearGauge.SectionColor4;
  SectionColor5Picker.Color                        := iLinearGauge.SectionColor5;

  SectionEnd1Edit.AsFloat                          := iLinearGauge.SectionEnd1;
  SectionEnd2Edit.AsFloat                          := iLinearGauge.SectionEnd2;
  SectionEnd3Edit.AsFloat                          := iLinearGauge.SectionEnd3;
  SectionEnd4Edit.AsFloat                          := iLinearGauge.SectionEnd4;
  //-------------- AutoScale --------------------------------------------------------------------------------------------------------------------------
  AutoScaleDesiredTicksEdit.AsInteger              := iLinearGauge.AutoScaleDesiredTicks;
  AutoScaleMaxTicksEdit.AsInteger                  := iLinearGauge.AutoScaleMaxTicks;
  AutoScaleEnabledCheckBox.AsBoolean               := iLinearGauge.AutoScaleEnabled;
  AutoScaleStyleRadioGroup.AsInteger               := ord(iLinearGauge.AutoScaleStyle);

  UpLoadOPCProperties(iLinearGauge, iOPCBrowserPanel);

  FPointerManager.Clear;

  for x := 0 to iLinearGauge.PointerCount-1 do
    begin
      FPointerManager.Add;
      FPointerManager.Items[x].Visible          := iLinearGauge.Pointers[x].Visible;
      FPointerManager.Items[x].Enabled          := iLinearGauge.Pointers[x].Enabled;
      FPointerManager.Items[x].UserCanMove      := iLinearGauge.Pointers[x].UserCanMove;
      FPointerManager.Items[x].Position         := iLinearGauge.Pointers[x].Position;
      FPointerManager.Items[x].Size             := iLinearGauge.Pointers[x].Size;
      FPointerManager.Items[x].Margin           := iLinearGauge.Pointers[x].Margin;
      FPointerManager.Items[x].Color            := iLinearGauge.Pointers[x].Color;
      FPointerManager.Items[x].DisabledColor    := iLinearGauge.Pointers[x].DisabledColor;
      FPointerManager.Items[x].Style            := iLinearGauge.Pointers[x].Style;
      FPointerManager.Items[x].Style3D          := iLinearGauge.Pointers[x].Style3D;
      FPointerManager.Items[x].DrawScaleSide    := iLinearGauge.Pointers[x].DrawScaleSide;
      FPointerManager.Items[x].UseDisabledColor := iLinearGauge.Pointers[x].UseDisabledColor;
    end;

  TickLabelFontPicker.Font.Assign(iLinearGauge.TickLabelFont);

  if iPointerListBox.Items.Count > FLastPointerIndex then iPointerListBox.ItemIndex := FLastPointerIndex;

  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLinearGauge : TiLinearGauge;
  x            : Integer;
begin
  iLinearGauge := Component as TiLinearGauge;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  iLinearGauge.AutoScaleEnabled         := False;  //Required to set Min & Max before AutoScale Activates
  iLinearGauge.PositionMax              := PositionMaxEdit.AsFloat;
  iLinearGauge.PositionMin              := PositionMinEdit.AsFloat;
  iLinearGauge.CurrentMax               := CurrentMaxEdit.AsFloat;
  iLinearGauge.CurrentMin               := CurrentMinEdit.AsFloat;
  iLinearGauge.EndsMargin               := EndsMarginEdit.AsInteger;
  iLinearGauge.BackGroundColor          := BackGroundColorPicker.Color;

  iLinearGauge.BorderStyle              := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iLinearGauge.Orientation              := TiOrientation(OrientationRadioGroup.AsInteger);
  iLinearGauge.OrientationTickMarks     := TiOrientationSide(OrientationTickMarksRadioGroup.AsInteger);
  iLinearGauge.PrecisionStyle           := TiPrecisionStyle(PrecisionStyleRadioGroup.AsInteger);
  iLinearGauge.ReverseScale             := ReverseScaleCheckBox.AsBoolean;
  iLinearGauge.CachedDrawing            := CachedDrawingCheckBox.AsBoolean;
  iLinearGauge.Transparent              := TransparentCheckBox.AsBoolean;
  iLinearGauge.AutoFrameRate            := AutoFrameRateCheckBox.AsBoolean;
  iLinearGauge.AutoCenter               := AutoCenterCheckBox.AsBoolean;
  iLinearGauge.UpdateFrameRate          := UpdateFrameRateEdit.AsInteger;
  iLinearGauge.ShowDisabledState        := ShowDisabledStateCheckBox.AsBoolean;
  iLinearGauge.Enabled                  := EnabledCheckBox.AsBoolean;

  iLinearGauge.KeyArrowStepSize         := KeyArrowStepSizeEdit.AsFloat;
  iLinearGauge.KeyPageStepSize          := KeyPageStepSizeEdit.AsFloat;
  iLinearGauge.MouseWheelStepSize       := MouseWheelStepSizeEdit.AsFloat;

  iLinearGauge.AllowFocus               := AllowFocusCheckBox.AsBoolean;

  iLinearGauge.OffsetX                  := OffsetXEdit.AsInteger;
  iLinearGauge.OffsetY                  := OffsetYEdit.AsInteger;
  //-------------- Pointers --------------------------------------------------------------------------------------------------------------------------
  iLinearGauge.MinMaxPointerSize        := MinMaxPointerSizeEdit.AsInteger;
  iLinearGauge.MinMaxPointerMargin      := MinMaxPointerMarginEdit.AsInteger;
  iLinearGauge.MinMaxFixed              := MinMaxFixedCheckBox.AsBoolean;
  iLinearGauge.MinMaxUserCanMove        := MinMaxUserCanMoveCheckBox.AsBoolean;
  iLinearGauge.MinMaxStyle3D            := MinMaxStyle3DCheckBox.AsBoolean;

  iLinearGauge.ShowMaxPointer           := ShowMaxPointerCheckBox.AsBoolean;
  iLinearGauge.MaxPointerColor          := MaxPointerColorPicker.Color;

  iLinearGauge.ShowMinPointer           := ShowMinPointerCheckBox.AsBoolean;
  iLinearGauge.MinPointerColor          := MinPointerColorPicker.Color;
  //-------------- Ticks -----------------------------------------------------------------------------------------------------------------------------
  iLinearGauge.ShowTicksAxis            := ShowTicksAxisCheckBox.AsBoolean;
  iLinearGauge.TickMargin               := TickMarginEdit.AsInteger;

  iLinearGauge.ShowTickLabels           := ShowTickLabelsCheckBox.AsBoolean;
  iLinearGauge.TickLabelPrecision       := TickLabelPrecisionEdit.AsInteger;
  iLinearGauge.TickLabelMargin          := TickLabelMarginEdit.AsInteger;

  iLinearGauge.ShowTicksMajor           := ShowTicksMajorCheckBox.AsBoolean;
  iLinearGauge.TickMajorCount           := TickMajorCountEdit.AsInteger;
  iLinearGauge.TickMajorLength          := TickMajorLengthEdit.AsInteger;
  iLinearGauge.TickMajorColor           := TickMajorColorPicker.Color;
  iLinearGauge.TickMajorStyle           := TiBevelStyle(TickMajorStyleRadioGroup.AsInteger);

  iLinearGauge.ShowTicksMinor           := ShowTicksMinorCheckBox.AsBoolean;
  iLinearGauge.TickMinorCount           := TickMinorCountEdit.AsInteger;
  iLinearGauge.TickMinorLength          := TickMinorLengthEdit.AsInteger;
  iLinearGauge.TickMinorColor           := TickMinorColorPicker.Color;
  iLinearGauge.TickMinorAlignment       := TiTickMinorAlignment(TickMinorAlignmentRadioGroup.AsInteger);
  iLinearGauge.TickMinorStyle           := TiBevelStyle(TickMinorStyleRadioGroup.AsInteger);
  //-------------- Sections --------------------------------------------------------------------------------------------------------------------------
  iLinearGauge.SectionCount             := SectionCountEdit.AsInteger;
  iLinearGauge.SectionColor1            := SectionColor1Picker.Color;
  iLinearGauge.SectionColor2            := SectionColor2Picker.Color;
  iLinearGauge.SectionColor3            := SectionColor3Picker.Color;
  iLinearGauge.SectionColor4            := SectionColor4Picker.Color;
  iLinearGauge.SectionColor5            := SectionColor5Picker.Color;

  iLinearGauge.SectionEnd1              := SectionEnd1Edit.AsFloat;
  iLinearGauge.SectionEnd2              := SectionEnd2Edit.AsFloat;
  iLinearGauge.SectionEnd3              := SectionEnd3Edit.AsFloat;
  iLinearGauge.SectionEnd4              := SectionEnd4Edit.AsFloat;
  //-------------- AutoScale --------------------------------------------------------------------------------------------------------------------------
  iLinearGauge.AutoScaleDesiredTicks    := AutoScaleDesiredTicksEdit.AsInteger;
  iLinearGauge.AutoScaleMaxTicks        := AutoScaleMaxTicksEdit.AsInteger;
  iLinearGauge.AutoScaleStyle           := TiAutoScaleStyle(AutoScaleStyleRadioGroup.AsInteger);
  iLinearGauge.AutoScaleEnabled         := AutoScaleEnabledCheckBox.AsBoolean;

  DownLoadOPCProperties(iLinearGauge, iOPCBrowserPanel);

  iLinearGauge.RemoveAllPointers;
  for x := 0 to FPointerManager.Count-1 do
    begin
      if x <> 0 then iLinearGauge.AddPointer;

      iLinearGauge.Pointers[x].Visible          := FPointerManager.Items[x].Visible;
      iLinearGauge.Pointers[x].Enabled          := FPointerManager.Items[x].Enabled;
      iLinearGauge.Pointers[x].UserCanMove      := FPointerManager.Items[x].UserCanMove;
      iLinearGauge.Pointers[x].Position         := FPointerManager.Items[x].Position;
      iLinearGauge.Pointers[x].Size             := FPointerManager.Items[x].Size;
      iLinearGauge.Pointers[x].Margin           := FPointerManager.Items[x].Margin;
      iLinearGauge.Pointers[x].Color            := FPointerManager.Items[x].Color;
      iLinearGauge.Pointers[x].DisabledColor    := FPointerManager.Items[x].DisabledColor;
      iLinearGauge.Pointers[x].Style            := FPointerManager.Items[x].Style;
      iLinearGauge.Pointers[x].Style3D          := FPointerManager.Items[x].Style3D;
      iLinearGauge.Pointers[x].DrawScaleSide    := FPointerManager.Items[x].DrawScaleSide;
      iLinearGauge.Pointers[x].UseDisabledColor := FPointerManager.Items[x].UseDisabledColor;
    end;

  iLinearGauge.TickLabelFont.Assign(TickLabelFontPicker.Font);

  FLastPointerIndex := iPointerListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.iComponentEditorFormCreate(Sender: TObject);
begin
  FPointerManager := TiGaugePointerManager.Create(ChangeEvent, InsertEvent, RemoveEvent, nil);
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  FPointerManager.Free;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.iPointerListBoxClick(Sender: TObject);
begin
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.iPointerListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (iPointerListBox.Items.Objects[Index] as TiGaugePointer).Color;
  AText  := 'Pointer(' + IntToStr(Index) + ')';
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.InsertEvent(Sender: TObject);
begin
  if Sender is TiGaugePointer then
    begin
      iPointerListBox.Items.AddObject('',Sender);
      with Sender as TiGaugePointer do
        begin
          Size  := 10;
          Color := clBlue;
          Style := ord(ilgpsPointer);
        end;
      iPointerListBox.SelectLast;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.RemoveEvent(Sender: TObject);
begin
  iPointerListBox.Items.Delete(iPointerListBox.Items.IndexOfObject(Sender));
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.ChangeEvent(Sender: TObject);
begin

end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.iPointerAddButtonClick(Sender: TObject);
begin
  FPointerManager.Add;
  UpdatePointers;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.PointerRemoveButtonClick(Sender: TObject);
begin
  iPointerListBox.DeleteSelectedObject;
  UpdatePointers;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.PositionEditChange(Sender: TObject);
begin
  FPointerManager.Items[0].Position := PositionEdit.AsFloat;
  UpdatePointers;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.UpdatePointers;
var
  iPointer : TiGaugePointer;
begin
  if iPointerListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Pointer')
    else
      begin
        EnableAllEditControlsStartingWith('Pointer');

        iPointer := iPointerListBox.Items.Objects[iPointerListBox.ItemIndex] as TiGaugePointer;

        PointerVisibleCheckBox.AsBoolean          := iPointer.Visible;
        PointerEnabledCheckBox.AsBoolean          := iPointer.Enabled;
        PointerUserCanMoveCheckBox.AsBoolean      := iPointer.UserCanMove;
        PointerPositionEdit.AsFloat               := iPointer.Position;
        PointerSizeEdit.AsInteger                 := iPointer.Size;
        PointerOffSetEdit.AsInteger               := iPointer.Margin;
        PointerColorPicker.Color                  := iPointer.Color;
        PointerStyleComboBox.AsInteger            := iPointer.Style;
        PointerStyle3DCheckBox.AsBoolean          := iPointer.Style3D;
        PointerDrawScaleSideCheckBox.AsBoolean    := iPointer.DrawScaleSide;
        PointerUseDisabledColorCheckBox.AsBoolean := iPointer.UseDisabledColor;
        PointerDisabledColorPicker.Color          := iPointer.DisabledColor;

        iPointerListBox.Invalidate;

        if iPointerListBox.ItemIndex = 0 then PointerRemoveButton.Enabled := False;
      end;
end;
//****************************************************************************************************************************************************
procedure TiLinearGaugeComponentEditorForm.PointerChange(Sender: TObject);
var
  iPointer : TiGaugePointer;
begin
  if iPointerListBox.ItemIndex = -1 then exit;

  iPointer := iPointerListBox.Items.Objects[iPointerListBox.ItemIndex] as TiGaugePointer;

  iPointer.Visible          := PointerVisibleCheckBox.AsBoolean;
  iPointer.Enabled          := PointerEnabledCheckBox.AsBoolean;
  iPointer.UserCanMove      := PointerUserCanMoveCheckBox.AsBoolean;
  iPointer.Position         := PointerPositionEdit.AsFloat;
  iPointer.Size             := PointerSizeEdit.AsInteger;
  iPointer.Margin           := PointerOffSetEdit.AsInteger;
  iPointer.Color            := PointerColorPicker.Color;
  iPointer.Style            := PointerStyleComboBox.AsInteger;
  iPointer.Style3D          := PointerStyle3DCheckBox.AsBoolean;
  iPointer.DrawScaleSide    := PointerDrawScaleSideCheckBox.AsBoolean;
  iPointer.UseDisabledColor := PointerUseDisabledColorCheckBox.AsBoolean;
  iPointer.DisabledColor    := PointerDisabledColorPicker.Color;

  if iPointerListBox.ItemIndex = 0 then
    begin
      PositionEdit.AsFloat := PointerPositionEdit.AsFloat;
    end;

  UpdatePointers;
end;
//****************************************************************************************************************************************************
end.
