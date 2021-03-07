{*******************************************************}
{                                                       }
{       TiThermometerComponentEditor                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iThermometerComponentEditor;{$endif}
{$ifdef iCLX}unit QiThermometerComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iThermometer,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiThermometer,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiThermometerComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    Label16: TLabel;
    Label17: TLabel;
    CurrentMaxEdit: TiComponentEditorEdit;
    CurrentMinEdit: TiComponentEditorEdit;
    TransparentCheckBox: TiComponentEditorCheckBox;
    TabSheet1: TTabSheet;
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
    DesignTabSheet: TTabSheet;
    DesignGeneralTabSheet: TTabSheet;
    DesignIndicatorTabSheet: TTabSheet;
    DesignMinMaxTabSheet: TTabSheet;
    DesignTicksTabSheet: TTabSheet;
    DesignPageControl: TiComponentEditorPageControl;
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
    ShowTicksMajorFirstLastCheckBox: TiComponentEditorCheckBox;
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
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    IndicatorWidthUpDown: TiUpDown;
    IndicatorBulbSizeUpDown: TiUpDown;
    Label18: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    IndicatorColorPicker: TiComponentEditorColorPicker;
    IndicatorBackGroundColorPicker: TiComponentEditorColorPicker;
    IndicatorWidthEdit: TiComponentEditorEdit;
    IndicatorBulbSizeEdit: TiComponentEditorEdit;
    IndicatorStyleComboBox: TiComponentEditorComboBox;
    IndicatorFillReferenceStyleComboBox: TiComponentEditorComboBox;
    IndicatorFillReferenceValueEdit: TiComponentEditorEdit;
    OrientationRadioGroup: TiComponentEditorRadioGroup;
    OrientationTickMarksRadioGroup: TiComponentEditorRadioGroup;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    OffsetGroupBox: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    PrecisionStyleRadioGroup: TiComponentEditorRadioGroup;
    ReverseScaleCheckBox: TiComponentEditorCheckBox;
    Label3: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label29: TLabel;
    EndsMarginUpDown: TiUpDown;
    EndsMarginEdit: TiComponentEditorEdit;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    AutoCenterCheckBox: TiComponentEditorCheckBox;
    IndicatorUserCanMoveCheckBox: TiComponentEditorCheckBox;
    ShowDisabledStateCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iThermometerComponentEditorForm: TiThermometerComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiThermometerComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiThermometer.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiThermometerComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iThermometer : TiThermometer;
begin
  iThermometer := Component as TiThermometer;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  PositionEdit.AsFloat                          := iThermometer.Position;
  PositionMaxEdit.AsFloat                       := iThermometer.PositionMax;
  PositionMinEdit.AsFloat                       := iThermometer.PositionMin;
  CurrentMaxEdit.AsFloat                        := iThermometer.CurrentMax;
  CurrentMinEdit.AsFloat                        := iThermometer.CurrentMin;
  EndsMarginEdit.AsInteger                      := iThermometer.EndsMargin;
  BackGroundColorPicker.Color                   := iThermometer.BackGroundColor;
  ReverseScaleCheckBox.AsBoolean                := iThermometer.ReverseScale;
  CachedDrawingCheckBox.AsBoolean               := iThermometer.CachedDrawing;
  TransparentCheckBox.AsBoolean                 := iThermometer.Transparent;
  AutoFrameRateCheckBox.AsBoolean               := iThermometer.AutoFrameRate;
  AutoCenterCheckBox.AsBoolean                  := iThermometer.AutoCenter;
  UpdateFrameRateEdit.AsInteger                 := iThermometer.UpdateFrameRate;
  ShowDisabledStateCheckBox.AsBoolean           := iThermometer.ShowDisabledState;
  EnabledCheckBox.AsBoolean                     := iThermometer.Enabled;

  BorderStyleRadioGroup.AsInteger               := ord(iThermometer.BorderStyle);
  OrientationRadioGroup.AsInteger               := ord(iThermometer.Orientation);
  OrientationTickMarksRadioGroup.AsInteger      := ord(iThermometer.OrientationTickMarks);
  PrecisionStyleRadioGroup.AsInteger            := ord(iThermometer.PrecisionStyle);

  OffsetXEdit.AsInteger                         := iThermometer.OffsetX;
  OffsetYEdit.AsInteger                         := iThermometer.OffsetY;
  //-------------- Indicator/Min&Max ---------------------------------------------------------------------------------------------------------
  IndicatorWidthEdit.AsInteger                  := iThermometer.IndicatorWidth;
  IndicatorBulbSizeEdit.AsInteger               := iThermometer.IndicatorBulbSize;
  IndicatorStyleComboBox.AsInteger              := ord(iThermometer.IndicatorStyle);
  IndicatorColorPicker.Color                    := iThermometer.IndicatorColor;
  IndicatorBackGroundColorPicker.Color          := iThermometer.IndicatorBackGroundColor;
  IndicatorFillReferenceStyleComboBox.AsInteger := ord(iThermometer.IndicatorFillReferenceStyle);
  IndicatorFillReferenceValueEdit.AsFloat       := iThermometer.IndicatorFillReferenceValue;
  IndicatorUserCanMoveCheckBox.AsBoolean        := iThermometer.IndicatorUserCanMove;

  MinMaxPointerSizeEdit.AsInteger               := iThermometer.MinMaxPointerSize;
  MinMaxPointerMarginEdit.AsInteger             := iThermometer.MinMaxPointerMargin;
  MinMaxFixedCheckBox.AsBoolean                 := iThermometer.MinMaxFixed;
  MinMaxUserCanMoveCheckBox.AsBoolean           := iThermometer.MinMaxUserCanMove;

  ShowMaxPointerCheckBox.AsBoolean              := iThermometer.ShowMaxPointer;
  MaxPointerColorPicker.Color                   := iThermometer.MaxPointerColor;

  ShowMinPointerCheckBox.AsBoolean              := iThermometer.ShowMinPointer;
  MinPointerColorPicker.Color                   := iThermometer.MinPointerColor;
  //-------------- Ticks ----------------------------------------------------------------------------------------------------------------------
  TickMarginEdit.AsInteger                      := iThermometer.TickMargin;

  ShowTickLabelsCheckBox.AsBoolean              := iThermometer.ShowTickLabels;
  TickLabelPrecisionEdit.AsInteger              := iThermometer.TickLabelPrecision;
  TickLabelMarginEdit.AsInteger                 := iThermometer.TickLabelMargin;

  ShowTicksMajorCheckBox.AsBoolean              := iThermometer.ShowTicksMajor;
  ShowTicksMajorFirstLastCheckBox.AsBoolean     := iThermometer.ShowTicksMajorFirstLast;
  TickMajorCountEdit.AsInteger                  := iThermometer.TickMajorCount;
  TickMajorLengthEdit.AsInteger                 := iThermometer.TickMajorLength;
  TickMajorColorPicker.Color                    := iThermometer.TickMajorColor;
  TickMajorStyleRadioGroup.AsInteger            := ord(iThermometer.TickMajorStyle);

  ShowTicksMinorCheckBox.AsBoolean              := iThermometer.ShowTicksMinor;
  TickMinorCountEdit.AsInteger                  := iThermometer.TickMinorCount;
  TickMinorLengthEdit.AsInteger                 := iThermometer.TickMinorLength;
  TickMinorColorPicker.Color                    := iThermometer.TickMinorColor;
  TickMinorAlignmentRadioGroup.AsInteger        := ord(iThermometer.TickMinorAlignment);
  TickMinorStyleRadioGroup.AsInteger            := ord(iThermometer.TickMinorStyle);
  //-------------- AutoScale -------------------------------------------------------------------------------------------------------------------
  AutoScaleDesiredTicksEdit.AsInteger           := iThermometer.AutoScaleDesiredTicks;
  AutoScaleMaxTicksEdit.AsInteger               := iThermometer.AutoScaleMaxTicks;
  AutoScaleEnabledCheckBox.AsBoolean            := iThermometer.AutoScaleEnabled;
  AutoScaleStyleRadioGroup.AsInteger            := ord(iThermometer.AutoScaleStyle);

  UpLoadOPCProperties(iThermometer, iOPCBrowserPanel);

  TickLabelFontPicker.Font.Assign(iThermometer.TickLabelFont);
end;
//****************************************************************************************************************************************************
procedure TiThermometerComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iThermometer : TiThermometer;
begin
  iThermometer := Component as TiThermometer;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  iThermometer.AutoScaleEnabled            := False;  //Required to set Min & Max before AutoScale Activates
  iThermometer.Position                    := PositionEdit.AsFloat;
  iThermometer.PositionMax                 := PositionMaxEdit.AsFloat;
  iThermometer.PositionMin                 := PositionMinEdit.AsFloat;
  iThermometer.CurrentMax                  := CurrentMaxEdit.AsFloat;
  iThermometer.CurrentMin                  := CurrentMinEdit.AsFloat;
  iThermometer.EndsMargin                  := EndsMarginEdit.AsInteger;
  iThermometer.BackGroundColor             := BackGroundColorPicker.Color;
  iThermometer.CachedDrawing               := CachedDrawingCheckBox.AsBoolean;
  iThermometer.ReverseScale                := ReverseScaleCheckBox.AsBoolean;
  iThermometer.Transparent                 := TransparentCheckBox.AsBoolean;
  iThermometer.AutoFrameRate               := AutoFrameRateCheckBox.AsBoolean;
  iThermometer.AutoCenter                  := AutoCenterCheckBox.AsBoolean;
  iThermometer.UpdateFrameRate             := UpdateFrameRateEdit.AsInteger;
  iThermometer.ShowDisabledState           := ShowDisabledStateCheckBox.AsBoolean;
  iThermometer.Enabled                     := EnabledCheckBox.AsBoolean;

  iThermometer.BorderStyle                 := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iThermometer.Orientation                 := TiOrientation(OrientationRadioGroup.AsInteger);
  iThermometer.OrientationTickMarks        := TiOrientationSide(OrientationTickMarksRadioGroup.AsInteger);
  iThermometer.PrecisionStyle              := TiPrecisionStyle(PrecisionStyleRadioGroup.AsInteger);

  iThermometer.OffsetX                     := OffsetXEdit.AsInteger;
  iThermometer.OffsetY                     := OffsetYEdit.AsInteger;
  //-------------- Indicator/Min&Max ------------------------------------------------------------------------------------------------------------------
  iThermometer.IndicatorWidth              := IndicatorWidthEdit.AsInteger;
  iThermometer.IndicatorBulbSize           := IndicatorBulbSizeEdit.AsInteger;
  iThermometer.IndicatorStyle              := TiThermometerIndicatorStyle(IndicatorStyleComboBox.AsInteger);
  iThermometer.IndicatorColor              := IndicatorColorPicker.Color;
  iThermometer.IndicatorBackGroundColor    := IndicatorBackGroundColorPicker.Color;
  iThermometer.IndicatorFillReferenceStyle := TiPointerFillReferenceStyle(IndicatorFillReferenceStyleComboBox.AsInteger);
  iThermometer.IndicatorFillReferenceValue := IndicatorFillReferenceValueEdit.AsFloat;
  iThermometer.IndicatorUserCanMove        := IndicatorUserCanMoveCheckBox.AsBoolean;

  iThermometer.MinMaxPointerSize           := MinMaxPointerSizeEdit.AsInteger;
  iThermometer.MinMaxPointerMargin         := MinMaxPointerMarginEdit.AsInteger;
  iThermometer.MinMaxFixed                 := MinMaxFixedCheckBox.AsBoolean;
  iThermometer.MinMaxUserCanMove           := MinMaxUserCanMoveCheckBox.AsBoolean;

  iThermometer.ShowMaxPointer              := ShowMaxPointerCheckBox.AsBoolean;
  iThermometer.MaxPointerColor             := MaxPointerColorPicker.Color;

  iThermometer.ShowMinPointer              := ShowMinPointerCheckBox.AsBoolean;
  iThermometer.MinPointerColor             := MinPointerColorPicker.Color;
  //-------------- Ticks -----------------------------------------------------------------------------------------------------------------------------
  iThermometer.TickMargin                  := TickMarginEdit.AsInteger;

  iThermometer.ShowTickLabels              := ShowTickLabelsCheckBox.AsBoolean;
  iThermometer.TickLabelPrecision          := TickLabelPrecisionEdit.AsInteger;
  iThermometer.TickLabelMargin             := TickLabelMarginEdit.AsInteger;

  iThermometer.ShowTicksMajor              := ShowTicksMajorCheckBox.AsBoolean;
  iThermometer.TickMajorCount              := TickMajorCountEdit.AsInteger;
  iThermometer.TickMajorLength             := TickMajorLengthEdit.AsInteger;
  iThermometer.TickMajorColor              := TickMajorColorPicker.Color;
  iThermometer.TickMajorStyle              := TiBevelStyle(TickMajorStyleRadioGroup.AsInteger);

  iThermometer.ShowTicksMinor              := ShowTicksMinorCheckBox.AsBoolean;
  iThermometer.ShowTicksMajorFirstLast     := ShowTicksMajorFirstLastCheckBox.AsBoolean;
  iThermometer.TickMinorCount              := TickMinorCountEdit.AsInteger;
  iThermometer.TickMinorLength             := TickMinorLengthEdit.AsInteger;
  iThermometer.TickMinorColor              := TickMinorColorPicker.Color;
  iThermometer.TickMinorAlignment          := TiTickMinorAlignment(TickMinorAlignmentRadioGroup.AsInteger);
  iThermometer.TickMinorStyle              := TiBevelStyle(TickMinorStyleRadioGroup.AsInteger);
  //-------------- AutoScale --------------------------------------------------------------------------------------------------------------------------
  iThermometer.AutoScaleDesiredTicks       := AutoScaleDesiredTicksEdit.AsInteger;
  iThermometer.AutoScaleMaxTicks           := AutoScaleMaxTicksEdit.AsInteger;
  iThermometer.AutoScaleStyle              := TiAutoScaleStyle(AutoScaleStyleRadioGroup.AsInteger);
  iThermometer.AutoScaleEnabled            := AutoScaleEnabledCheckBox.AsBoolean;

  DownLoadOPCProperties(iThermometer, iOPCBrowserPanel);

  iThermometer.TickLabelFont.Assign(TickLabelFontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
