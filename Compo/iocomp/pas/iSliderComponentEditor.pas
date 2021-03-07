{*******************************************************}
{                                                       }
{       TiSliderComponentEditor                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSliderComponentEditor;{$endif}
{$ifdef iCLX}unit QiSliderComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}
                                                                                
  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSlider,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSlider,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSliderComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    ControlTabSheet: TTabSheet;
    EnabledCheckBox: TiComponentEditorCheckBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    KeyStepSizeGroupBox: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    KeyArrowStepSizeEdit: TiComponentEditorEdit;
    KeyPageStepSizeEdit: TiComponentEditorEdit;
    Label6: TLabel;
    Label4: TLabel;
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
    MouseControlStyleRadioGroup: TiComponentEditorRadioGroup;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label11: TLabel;
    MouseWheelStepSizeEdit: TiComponentEditorEdit;
    DesignTabSheet: TTabSheet;
    DesignPageControl: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    DesignPointerTabSheet: TTabSheet;
    DesignTrackTabSheet: TTabSheet;
    DesignTicksTabSheet: TTabSheet;
    Label1: TLabel;
    Label8: TLabel;
    PointerHeightUpDown: TiUpDown;
    PointerWidthUpDown: TiUpDown;
    PointerHeightEdit: TiComponentEditorEdit;
    PointerWidthEdit: TiComponentEditorEdit;
    PointerStyleRadioGroup: TiComponentEditorRadioGroup;
    IndicatorGroupBox: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    PointerIndicatorActiveColorPicker: TiComponentEditorColorPicker;
    PointerIndicatorInactiveColorPicker: TiComponentEditorColorPicker;
    Label2: TLabel;
    TrackColorPicker: TiComponentEditorColorPicker;
    TrackStyleRadioGroup: TiComponentEditorRadioGroup;
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
    OrientationRadioGroup: TiComponentEditorRadioGroup;
    OrientationTickMarksRadioGroup: TiComponentEditorRadioGroup;
    PrecisionStyleRadioGroup: TiComponentEditorRadioGroup;
    Label3: TLabel;
    Label29: TLabel;
    EndsMarginUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    EndsMarginEdit: TiComponentEditorEdit;
    ReverseScaleCheckBox: TiComponentEditorCheckBox;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    OffsetGroupBox: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    AutoCenterCheckBox: TiComponentEditorCheckBox;
    ShowDisabledStateCheckBox: TiComponentEditorCheckBox;
    PointerFillGroupBox: TGroupBox;
    Label18: TLabel;
    PointerFillColorPicker: TiComponentEditorColorPicker;
    PointerFillEnabledCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSliderComponentEditorForm: TiSliderComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSliderComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSlider.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSliderComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSlider : TiSlider;
begin
  iSlider := Component as TiSlider;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  PositionEdit.AsFloat                             := iSlider.Position;
  PositionMaxEdit.AsFloat                          := iSlider.PositionMax;
  PositionMinEdit.AsFloat                          := iSlider.PositionMin;
  CurrentMaxEdit.AsFloat                           := iSlider.CurrentMax;
  CurrentMinEdit.AsFloat                           := iSlider.CurrentMin;
  EndsMarginEdit.AsInteger                         := iSlider.EndsMargin;
  ShowFocusRectCheckBox.AsBoolean                  := iSlider.ShowFocusRect;
  EnabledCheckBox.AsBoolean                        := iSlider.Enabled;
  ShowDisabledStateCheckBox.AsBoolean              := iSlider.ShowDisabledState;
  ReverseScaleCheckBox.AsBoolean                   := iSlider.ReverseScale;
  TransparentCheckBox.AsBoolean                    := iSlider.Transparent;
  BackGroundColorPicker.Color                      := iSlider.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean                  := iSlider.AutoFrameRate;
  AutoCenterCheckBox.AsBoolean                     := iSlider.AutoCenter;
  UpdateFrameRateEdit.AsInteger                    := iSlider.UpdateFrameRate;

  KeyArrowStepSizeEdit.AsFloat                     := iSlider.KeyArrowStepSize;
  KeyPageStepSizeEdit.AsFloat                      := iSlider.KeyPageStepSize;
  MouseWheelStepSizeEdit.AsFloat                   := iSlider.MouseWheelStepSize;

  BorderStyleRadioGroup.AsInteger                  := ord(iSlider.BorderStyle);
  OrientationRadioGroup.AsInteger                  := ord(iSlider.Orientation);
  OrientationTickMarksRadioGroup.AsInteger         := ord(iSlider.OrientationTickMarks);
  PrecisionStyleRadioGroup.AsInteger               := ord(iSlider.PrecisionStyle);
  MouseControlStyleRadioGroup.AsInteger            := ord(iSlider.MouseControlStyle);

  OffsetXEdit.AsInteger                            := iSlider.OffsetX;
  OffsetYEdit.AsInteger                            := iSlider.OffsetY;
  //-------------- Pointer/Track ---------------------------------------------------------------------------------------------------------------------
  PointerHeightEdit.AsInteger                      := iSlider.PointerHeight;
  PointerWidthEdit.AsInteger                       := iSlider.PointerWidth;
  PointerStyleRadioGroup.AsInteger                 := ord(iSlider.PointerStyle);
  PointerIndicatorActiveColorPicker.Color          := iSlider.PointerIndicatorActiveColor;
  PointerIndicatorInactiveColorPicker.Color        := iSlider.PointerIndicatorInactiveColor;
  PointerFillEnabledCheckBox.AsBoolean             := iSlider.PointerFillEnabled;
  PointerFillColorPicker.Color                     := iSlider.PointerFillColor;

  TrackStyleRadioGroup.AsInteger                   := ord(iSlider.TrackStyle);
  TrackColorPicker.Color                           := iSlider.TrackColor;
  //-------------- Ticks -----------------------------------------------------------------------------------------------------------------------------
  TickMarginEdit.AsInteger                         := iSlider.TickMargin;

  ShowTickLabelsCheckBox.AsBoolean                 := iSlider.ShowTickLabels;
  TickLabelPrecisionEdit.AsInteger                 := iSlider.TickLabelPrecision;
  TickLabelMarginEdit.AsInteger                    := iSlider.TickLabelMargin;

  ShowTicksMajorCheckBox.AsBoolean                 := iSlider.ShowTicksMajor;
  TickMajorCountEdit.AsInteger                     := iSlider.TickMajorCount;
  TickMajorLengthEdit.AsInteger                    := iSlider.TickMajorLength;
  TickMajorColorPicker.Color                       := iSlider.TickMajorColor;
  TickMajorStyleRadioGroup.AsInteger               := ord(iSlider.TickMajorStyle);

  ShowTicksMinorCheckBox.AsBoolean                 := iSlider.ShowTicksMinor;
  TickMinorCountEdit.AsInteger                     := iSlider.TickMinorCount;
  TickMinorLengthEdit.AsInteger                    := iSlider.TickMinorLength;
  TickMinorColorPicker.Color                       := iSlider.TickMinorColor;
  TickMinorAlignmentRadioGroup.AsInteger           := ord(iSlider.TickMinorAlignment);
  TickMinorStyleRadioGroup.AsInteger               := ord(iSlider.TickMinorStyle);
  //-------------- AutoScale --------------------------------------------------------------------------------------------------------------------------
  AutoScaleDesiredTicksEdit.AsInteger              := iSlider.AutoScaleDesiredTicks;
  AutoScaleMaxTicksEdit.AsInteger                  := iSlider.AutoScaleMaxTicks;
  AutoScaleEnabledCheckBox.AsBoolean               := iSlider.AutoScaleEnabled;
  AutoScaleStyleRadioGroup.AsInteger               := ord(iSlider.AutoScaleStyle);

  TickLabelFontPicker.Font.Assign(iSlider.TickLabelFont);

  UpLoadOPCProperties(iSlider, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSliderComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSlider : TiSlider;
begin
  iSlider := Component as TiSlider;

  //-------------- General ---------------------------------------------------------------------------------------------------------------------------
  iSlider.AutoScaleEnabled              := False;  //Required to set Min & Max before AutoScale Activates
  iSlider.Position                      := PositionEdit.AsFloat;
  iSlider.PositionMax                   := PositionMaxEdit.AsFloat;
  iSlider.PositionMin                   := PositionMinEdit.AsFloat;
  iSlider.CurrentMax                    := CurrentMaxEdit.AsFloat;
  iSlider.CurrentMin                    := CurrentMinEdit.AsFloat;
  iSlider.EndsMargin                    := EndsMarginEdit.AsInteger;
  iSlider.ShowFocusRect                 := ShowFocusRectCheckBox.AsBoolean;
  iSlider.Enabled                       := EnabledCheckBox.AsBoolean;
  iSlider.ShowDisabledState             := ShowDisabledStateCheckBox.AsBoolean;
  iSlider.ReverseScale                  := ReverseScaleCheckBox.AsBoolean;
  iSlider.Transparent                   := TransparentCheckBox.AsBoolean;
  iSlider.BackGroundColor               := BackGroundColorPicker.Color;
  iSlider.AutoFrameRate                 := AutoFrameRateCheckBox.AsBoolean;
  iSlider.AutoCenter                    := AutoCenterCheckBox.AsBoolean;
  iSlider.UpdateFrameRate               := UpdateFrameRateEdit.AsInteger;

  iSlider.KeyArrowStepSize              := KeyArrowStepSizeEdit.AsFloat;
  iSlider.KeyPageStepSize               := KeyPageStepSizeEdit.AsFloat;
  iSlider.MouseWheelStepSize            := MouseWheelStepSizeEdit.AsFloat;

  iSlider.BorderStyle                   := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSlider.Orientation                   := TiOrientation(OrientationRadioGroup.AsInteger);
  iSlider.OrientationTickMarks          := TiOrientationSide(OrientationTickMarksRadioGroup.AsInteger);
  iSlider.PrecisionStyle                := TiPrecisionStyle(PrecisionStyleRadioGroup.AsInteger);
  iSlider.MouseControlStyle             := TiSliderMouseControlStyle(MouseControlStyleRadioGroup.AsInteger);

  iSlider.OffsetX                       := OffsetXEdit.AsInteger;
  iSlider.OffsetY                       := OffsetYEdit.AsInteger;
  //-------------- Pointer/Track ---------------------------------------------------------------------------------------------------------------------
  iSlider.PointerHeight                 := PointerHeightEdit.AsInteger;
  iSlider.PointerWidth                  := PointerWidthEdit.AsInteger;
  iSlider.PointerStyle                  := TiSliderPointerStyle(PointerStyleRadioGroup.AsInteger);
  iSlider.PointerIndicatorActiveColor   := PointerIndicatorActiveColorPicker.Color;
  iSlider.PointerIndicatorInactiveColor := PointerIndicatorInactiveColorPicker.Color;
  iSlider.PointerFillEnabled            := PointerFillEnabledCheckBox.AsBoolean;
  iSlider.PointerFillColor              := PointerFillColorPicker.Color;

  iSlider.TrackStyle                    := TiSliderTrackStyle(TrackStyleRadioGroup.AsInteger);
  iSlider.TrackColor                    := TrackColorPicker.Color;
  //-------------- Ticks -----------------------------------------------------------------------------------------------------------------------------
  iSlider.TickMargin                    := TickMarginEdit.AsInteger;

  iSlider.ShowTickLabels                := ShowTickLabelsCheckBox.AsBoolean;
  iSlider.TickLabelPrecision            := TickLabelPrecisionEdit.AsInteger;
  iSlider.TickLabelMargin               := TickLabelMarginEdit.AsInteger;

  iSlider.ShowTicksMajor                := ShowTicksMajorCheckBox.AsBoolean;
  iSlider.TickMajorCount                := TickMajorCountEdit.AsInteger;
  iSlider.TickMajorLength               := TickMajorLengthEdit.AsInteger;
  iSlider.TickMajorColor                := TickMajorColorPicker.Color;
  iSlider.TickMajorStyle                := TiBevelStyle(TickMajorStyleRadioGroup.AsInteger);

  iSlider.ShowTicksMinor                := ShowTicksMinorCheckBox.AsBoolean;
  iSlider.TickMinorCount                := TickMinorCountEdit.AsInteger;
  iSlider.TickMinorLength               := TickMinorLengthEdit.AsInteger;
  iSlider.TickMinorColor                := TickMinorColorPicker.Color;
  iSlider.TickMinorAlignment            := TiTickMinorAlignment(TickMinorAlignmentRadioGroup.AsInteger);
  iSlider.TickMinorStyle                := TiBevelStyle(TickMinorStyleRadioGroup.AsInteger);
  //-------------- AutoScale --------------------------------------------------------------------------------------------------------------------------
  iSlider.AutoScaleDesiredTicks         := AutoScaleDesiredTicksEdit.AsInteger;
  iSlider.AutoScaleMaxTicks             := AutoScaleMaxTicksEdit.AsInteger;
  iSlider.AutoScaleStyle                := TiAutoScaleStyle(AutoScaleStyleRadioGroup.AsInteger);
  iSlider.AutoScaleEnabled              := AutoScaleEnabledCheckBox.AsBoolean;

  iSlider.TickLabelFont.Assign(TickLabelFontPicker.Font);

  DownLoadOPCProperties(iSlider, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
