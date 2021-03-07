{*******************************************************}
{                                                       }
{       TiKnobComponentEditor                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iKnobComponentEditor;{$endif}
{$ifdef iCLX}unit QiKnobComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iKnob,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiKnob,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiKnobComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    EnabledCheckBox: TiComponentEditorCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    KeyStepSizeGroupBox: TGroupBox;
    Label6: TLabel;
    Label29: TLabel;
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
    Label5: TLabel;
    Label7: TLabel;
    KeyArrowStepSizeEdit: TiComponentEditorEdit;
    KeyPageStepSizeEdit: TiComponentEditorEdit;
    Label31: TLabel;
    MouseWheelStepSizeEdit: TiComponentEditorEdit;
    DesignTabSheet: TTabSheet;
    iComponentEditorPageControl1: TiComponentEditorPageControl;
    DesignKnobTabSheet: TTabSheet;
    DesignIndicatorTabSheet: TTabSheet;
    DesignPositionTabSheet: TTabSheet;
    DesignTicksTabSheet: TTabSheet;
    DesignGeneralTabSheet: TTabSheet;
    Label17: TLabel;
    Label18: TLabel;
    KnobEdgeWidthUpDown: TiUpDown;
    KnobRadiusUpDown: TiUpDown;
    KnobStyleRadioGroup: TiComponentEditorRadioGroup;
    KnobEdgeWidthEdit: TiComponentEditorEdit;
    KnobRadiusEdit: TiComponentEditorEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    Label16: TLabel;
    IndicatorSizeUpDown: TiUpDown;
    IndicatorMarginUpDown: TiUpDown;
    IndicatorInactiveColorPicker: TiComponentEditorColorPicker;
    IndicatorActiveColorPicker: TiComponentEditorColorPicker;
    IndicatorStyleRadioGroup: TiComponentEditorRadioGroup;
    IndicatorSizeEdit: TiComponentEditorEdit;
    IndicatorMarginEdit: TiComponentEditorEdit;
    Label21: TLabel;
    Label22: TLabel;
    PositionDisplayPrecisionUpDown: TiUpDown;
    PositionDisplayFontPicker: TiComponentEditorFontPicker;
    PositionDisplayPrecisionEdit: TiComponentEditorEdit;
    PositionDisplayUnitsEdit: TiComponentEditorEdit;
    ShowPositionDisplayCheckBox: TiComponentEditorCheckBox;
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
    OffsetGroupBox: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    Label3: TLabel;
    Label30: TLabel;
    OuterMarginUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    OuterMarginEdit: TiComponentEditorEdit;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    PrecisionStyleRadioGroup: TiComponentEditorRadioGroup;
    RotationGroupBox: TGroupBox;
    Label1: TLabel;
    Label8: TLabel;
    RotationStartDegreesEdit: TiComponentEditorComboBox;
    RotationMaxDegreesEdit: TiComponentEditorComboBox;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    Label32: TLabel;
    ColorPicker: TiComponentEditorColorPicker;
    ShowDisabledStateCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iKnobComponentEditorForm: TiKnobComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiKnobComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiKnob.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiKnobComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iKnob : TiKnob;
begin
  iKnob := Component as TiKnob;
  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  PositionEdit.AsFloat                      := iKnob.Position;
  PositionMaxEdit.AsFloat                   := iKnob.PositionMax;
  PositionMinEdit.AsFloat                   := iKnob.PositionMin;
  CurrentMaxEdit.AsFloat                    := iKnob.CurrentMax;
  CurrentMinEdit.AsFloat                    := iKnob.CurrentMin;
  OuterMarginEdit.AsInteger                 := iKnob.OuterMargin;
  ShowFocusRectCheckBox.AsBoolean           := iKnob.ShowFocusRect;
  EnabledCheckBox.AsBoolean                 := iKnob.Enabled;
  ShowDisabledStateCheckBox.AsBoolean       := iKnob.ShowDisabledState;
  CachedDrawingCheckBox.AsBoolean           := iKnob.CachedDrawing;
  TransparentCheckBox.AsBoolean             := iKnob.Transparent;
  AutoSizeCheckBox.AsBoolean                := iKnob.AutoSize;
  AutoFrameRateCheckBox.AsBoolean           := iKnob.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger             := iKnob.UpdateFrameRate;
  ColorPicker.Color                         := iKnob.Color;

  BackGroundColorPicker.Color               := iKnob.BackGroundColor;
  PrecisionStyleRadioGroup.AsInteger        := ord(iKnob.PrecisionStyle);

  RotationStartDegreesEdit.AsString         := IntToStr(iKnob.RotationStartDegrees); //Must be set with Text
  RotationMaxDegreesEdit.AsString           := IntToStr(iKnob.RotationMaxDegrees);   //Must be set with Text

  KeyArrowStepSizeEdit.AsFloat              := iKnob.KeyArrowStepSize;
  KeyPageStepSizeEdit.AsFloat               := iKnob.KeyPageStepSize;
  MouseWheelStepSizeEdit.AsFloat            := iKnob.MouseWheelStepSize;

  ShowPositionDisplayCheckBox.AsBoolean     := iKnob.ShowPostionDisplay;
  PositionDisplayPrecisionEdit.AsInteger    := iKnob.PositionDisplayPrecision;
  PositiondisplayUnitsEdit.AsString         := iKnob.PositionDisplayUnits;

  OffsetXEdit.AsInteger                     := iKnob.OffsetX;
  OffsetYEdit.AsInteger                     := iKnob.OffsetY;
  //-------------- Knob/Indicator -------------------------------------------------------------------------------------------------------------
  KnobStyleRadioGroup.AsInteger             := ord(iKnob.KnobStyle);
  KnobRadiusEdit.AsInteger                  := iKnob.KnobRadius;
  KnobEdgeWidthEdit.AsInteger               := iKnob.KnobEdgeWidth;

  IndicatorActiveColorPicker.Color          := iKnob.IndicatorActiveColor;
  IndicatorInactiveColorPicker.Color        := iKnob.IndicatorInactiveColor;
  IndicatorSizeEdit.AsInteger               := iKnob.IndicatorSize;
  IndicatorMarginEdit.AsInteger             := iKnob.IndicatorMargin;
  IndicatorStyleRadioGroup.AsInteger        := ord(iKnob.IndicatorStyle);
  //-------------- Ticks ----------------------------------------------------------------------------------------------------------------------
  TickMarginEdit.AsInteger                  := iKnob.TickMargin;

  ShowTickLabelsCheckBox.AsBoolean          := iKnob.ShowTickLabels;
  TickLabelPrecisionEdit.AsInteger          := iKnob.TickLabelPrecision;
  TickLabelMarginEdit.AsInteger             := iKnob.TickLabelMargin;

  ShowTicksMajorCheckBox.AsBoolean          := iKnob.ShowTicksMajor;
  TickMajorCountEdit.AsInteger              := iKnob.TickMajorCount;
  TickMajorLengthEdit.AsInteger             := iKnob.TickMajorLength;
  TickMajorColorPicker.Color                := iKnob.TickMajorColor;

  ShowTicksMinorCheckBox.AsBoolean          := iKnob.ShowTicksMinor;
  TickMinorCountEdit.AsInteger              := iKnob.TickMinorCount;
  TickMinorLengthEdit.AsInteger             := iKnob.TickMinorLength;
  TickMinorColorPicker.Color                := iKnob.TickMinorColor;
  TickMinorAlignmentRadioGroup.AsInteger    := ord(iKnob.TickMinorAlignment);

  //-------------- AutoScale -------------------------------------------------------------------------------------------------------------------
  AutoScaleDesiredTicksEdit.AsInteger       := iKnob.AutoScaleDesiredTicks;
  AutoScaleMaxTicksEdit.AsInteger           := iKnob.AutoScaleMaxTicks;
  AutoScaleEnabledCheckBox.AsBoolean        := iKnob.AutoScaleEnabled;
  AutoScaleStyleRadioGroup.AsInteger        := ord(iKnob.AutoScaleStyle);

  UpLoadOPCProperties(iKnob, iOPCBrowserPanel);

  PositionDisplayFontPicker.Font.Assign(iKnob.PositionDisplayFont);
  TickLabelFontPicker.Font.Assign(iKnob.TickLabelFont);
end;
//****************************************************************************************************************************************************
procedure TiKnobComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iKnob : TiKnob;
begin
  iKnob := Component as TiKnob;

  iKnob.AutoScaleEnabled         := False;  //Required to set Min & Max before AutoScale Activates
  iKnob.Position                 := PositionEdit.AsFloat;
  iKnob.PositionMax              := PositionMaxEdit.AsFloat;
  iKnob.PositionMin              := PositionMinEdit.AsFloat;
  iKnob.CurrentMax               := CurrentMaxEdit.AsFloat;
  iKnob.CurrentMin               := CurrentMinEdit.AsFloat;
  iKnob.OuterMargin              := OuterMarginEdit.AsInteger;
  iKnob.ShowFocusRect            := ShowFocusRectCheckBox.AsBoolean;
  iKnob.Enabled                  := EnabledCheckBox.AsBoolean;
  iKnob.ShowDisabledState        := ShowDisabledStateCheckBox.AsBoolean;
  iKnob.CachedDrawing            := CachedDrawingCheckBox.AsBoolean;
  iKnob.Transparent              := TransparentCheckBox.AsBoolean;
  iKnob.AutoSize                 := AutoSizeCheckBox.AsBoolean;
  iKnob.AutoFrameRate            := AutoFrameRateCheckBox.AsBoolean;
  iKnob.UpdateFrameRate          := UpdateFrameRateEdit.AsInteger;
  iKnob.Color                    := ColorPicker.Color;

  iKnob.BackGroundColor          := BackGroundColorPicker.Color;
  iKnob.PrecisionStyle           := TiPrecisionStyle(PrecisionStyleRadioGroup.AsInteger);

  iKnob.RotationStartDegrees     := StrToInt(RotationStartDegreesEdit.AsString);
  iKnob.RotationMaxDegrees       := StrToInt(RotationMaxDegreesEdit.AsString);

  iKnob.KeyArrowStepSize         := KeyArrowStepSizeEdit.AsFloat;
  iKnob.KeyPageStepSize          := KeyPageStepSizeEdit.AsFloat;
  iKnob.MouseWheelStepSize       := MouseWheelStepSizeEdit.AsFloat;

  iKnob.ShowPostionDisplay       := ShowPositionDisplayCheckBox.AsBoolean;
  iKnob.PositionDisplayPrecision := PositionDisplayPrecisionEdit.AsInteger;
  iKnob.PositionDisplayUnits     := PositiondisplayUnitsEdit.AsString;

  iKnob.OffsetX                  := OffsetXEdit.AsInteger;
  iKnob.OffsetY                  := OffsetYEdit.AsInteger;

  iKnob.KnobStyle                := TiKnobStyle(KnobStyleRadioGroup.AsInteger);
  iKnob.KnobRadius               := KnobRadiusEdit.AsInteger;
  iKnob.KnobEdgeWidth            := KnobEdgeWidthEdit.AsInteger;

  iKnob.IndicatorActiveColor     := IndicatorActiveColorPicker.Color;
  iKnob.IndicatorInactiveColor   := IndicatorInactiveColorPicker.Color;
  iKnob.IndicatorSize            := IndicatorSizeEdit.AsInteger;
  iKnob.IndicatorMargin          := IndicatorMarginEdit.AsInteger;
  iKnob.IndicatorStyle           := TiKnobIndicatorStyle(IndicatorStyleRadioGroup.AsInteger);

  iKnob.TickMargin               := TickMarginEdit.AsInteger;

  iKnob.ShowTickLabels           := ShowTickLabelsCheckBox.AsBoolean;
  iKnob.TickLabelPrecision       := TickLabelPrecisionEdit.AsInteger;
  iKnob.TickLabelMargin          := TickLabelMarginEdit.AsInteger;

  iKnob.ShowTicksMajor           := ShowTicksMajorCheckBox.AsBoolean;
  iKnob.TickMajorCount           := TickMajorCountEdit.AsInteger;
  iKnob.TickMajorLength          := TickMajorLengthEdit.AsInteger;
  iKnob.TickMajorColor           := TickMajorColorPicker.Color;

  iKnob.ShowTicksMinor           := ShowTicksMinorCheckBox.AsBoolean;
  iKnob.TickMinorCount           := TickMinorCountEdit.AsInteger;
  iKnob.TickMinorLength          := TickMinorLengthEdit.AsInteger;
  iKnob.TickMinorColor           := TickMinorColorPicker.Color;
  iKnob.TickMinorAlignment       := TiTickMinorAlignment(TickMinorAlignmentRadioGroup.AsInteger);

  //-------------- AutoScale --------------------------------------------------------------------------------------------------------------------------
  iKnob.AutoScaleDesiredTicks    := AutoScaleDesiredTicksEdit.AsInteger;
  iKnob.AutoScaleMaxTicks        := AutoScaleMaxTicksEdit.AsInteger;
  iKnob.AutoScaleStyle           := TiAutoScaleStyle(AutoScaleStyleRadioGroup.AsInteger);
  iKnob.AutoScaleEnabled         := AutoScaleEnabledCheckBox.Checked;

  DownLoadOPCProperties(iKnob, iOPCBrowserPanel);

  iKnob.PositionDisplayFont.Assign(PositionDisplayFontPicker.Font);
  iKnob.TickLabelFont.Assign(TickLabelFontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
