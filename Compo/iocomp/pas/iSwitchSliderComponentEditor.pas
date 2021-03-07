{*******************************************************}
{                                                       }
{       TiSwitchSliderComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchSliderComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchSliderComponentEditor;{$endif}

interface

uses                                                              
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchSlider,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchSlider,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchSliderComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    EnabledCheckBox: TiComponentEditorCheckBox;
    Label12: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionUpDown: TiUpDown;
    KeyStepSizeGroupBox: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    KeyArrowStepSizeEdit: TiComponentEditorEdit;
    KeyArrowStepSizeUpDown: TiUpDown;
    KeyPageStepSizeEdit: TiComponentEditorEdit;
    KeyPageStepSizeUpDown: TiUpDown;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    DesignTabSheet: TTabSheet;
    DesignPageControl: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    DesignLabelsIndicatorsTabSheet: TTabSheet;
    DesignPointerTrackTabSheet: TTabSheet;
    Label3: TLabel;
    OrientationRadioGroup: TiComponentEditorRadioGroup;
    OrientationLabelsRadioGroup: TiComponentEditorRadioGroup;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    OffsetGroupBox: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    Label29: TLabel;
    EndsMarginUpDown: TiUpDown;
    EndsMarginEdit: TiComponentEditorEdit;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    AutoCenterCheckBox: TiComponentEditorCheckBox;
    PositionLabelsGroupBox: TGroupBox;
    Label6: TLabel;
    Label13: TLabel;
    PositionLabelMarginUpDown: TiUpDown;
    PositionLabelMarginEdit: TiComponentEditorEdit;
    PositionLabelActiveFontPicker: TiComponentEditorFontPicker;
    PositionLabelInactiveFontPicker: TiComponentEditorFontPicker;
    PositionLabelsListBox: TiComponentEditorMemo;
    ShowPositionLabelsCheckBox: TiComponentEditorCheckBox;
    PositionIndicatorGroupBox: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label11: TLabel;
    PositionIndicatorSizeUpDown: TiUpDown;
    PositionIndicatorMarginUpDown: TiUpDown;
    PositionIndicatorColorPicker: TiComponentEditorColorPicker;
    PositionIndicatorBevelStyleRadioGroup: TiComponentEditorRadioGroup;
    PositionIndicatorSizeEdit: TiComponentEditorEdit;
    PositionIndicatorMarginEdit: TiComponentEditorEdit;
    ShowPositionIndicatorsCheckBox: TiComponentEditorCheckBox;
    PositionIndicatorStyleRadioGroup: TiComponentEditorRadioGroup;
    PointerGroupBox: TGroupBox;
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
    TrackGroupBox: TGroupBox;
    Label15: TLabel;
    TrackColorPicker: TiComponentEditorColorPicker;
    TrackStyleRadioGroup: TiComponentEditorRadioGroup;
    Label14: TLabel;
    Label18: TLabel;
    PointerColorPicker: TiComponentEditorColorPicker;
    PointerHighlightColorPicker: TiComponentEditorColorPicker;
    ShowDisabledStateCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSwitchSliderComponentEditorForm: TiSwitchSliderComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchSliderComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchSlider.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchSliderComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchSlider : TiSwitchSlider;
  x             : Integer;
begin
  iSwitchSlider := Component as TiSwitchSlider;

  PositionEdit.AsInteger                           := iSwitchSlider.Position;
  EndsMarginEdit.AsInteger                         := iSwitchSlider.EndsMargin;
  ShowFocusRectCheckBox.AsBoolean                  := iSwitchSlider.ShowFocusRect;
  EnabledCheckBox.AsBoolean                        := iSwitchSlider.Enabled;
  ShowDisabledStateCheckBox.AsBoolean              := iSwitchSlider.ShowDisabledState;
  TransparentCheckBox.AsBoolean                    := iSwitchSlider.Transparent;
  AutoFrameRateCheckBox.AsBoolean                  := iSwitchSlider.AutoFrameRate;
  AutoCenterCheckBox.AsBoolean                     := iSwitchSlider.AutoCenter;
  UpdateFrameRateEdit.AsInteger                    := iSwitchSlider.UpdateFrameRate;

  KeyArrowStepSizeEdit.AsInteger                   := iSwitchSlider.KeyArrowStepSize;
  KeyPageStepSizeEdit.AsInteger                    := iSwitchSlider.KeyPageStepSize;

  BackGroundColorPicker.Color                      := iSwitchSlider.BackGroundColor;

  BorderStyleRadioGroup.AsInteger                  := ord(iSwitchSlider.BorderStyle);
  OrientationRadioGroup.AsInteger                  := ord(iSwitchSlider.Orientation);
  OrientationLabelsRadioGroup.AsInteger            := ord(iSwitchSlider.OrientationLabels);

  ShowPositionLabelsCheckBox.AsBoolean             := iSwitchSlider.ShowPositionLabels;
  PositionLabelMarginEdit.AsInteger                := iSwitchSlider.PositionLabelMargin;

  OffsetXEdit.AsInteger                            := iSwitchSlider.OffsetX;
  OffsetYEdit.AsInteger                            := iSwitchSlider.OffsetY;

  PositionLabelsListBox.Lines.Clear;
  for x := 0 to iSwitchSlider.PositionLabelCount - 1 do
    PositionLabelsListBox.Lines.Add(iSwitchSlider.PositionLabel[x]);

  PositionIndicatorStyleRadioGroup.AsInteger       := ord(iSwitchSlider.PositionIndicatorStyle);
  PositionIndicatorBevelStyleRadioGroup.AsInteger  := ord(iSwitchSlider.PositionIndicatorBevelStyle);
  ShowPositionIndicatorsCheckBox.AsBoolean         := iSwitchSlider.ShowPositionIndicators;
  PositionIndicatorColorPicker.Color               := iSwitchSlider.PositionIndicatorColor;
  PositionIndicatorSizeEdit.AsInteger              := iSwitchSlider.PositionIndicatorSize;
  PositionIndicatorMarginEdit.AsInteger            := iSwitchSlider.PositionIndicatorMargin;

  PointerHeightEdit.AsInteger                      := iSwitchSlider.PointerHeight;
  PointerWidthEdit.AsInteger                       := iSwitchSlider.PointerWidth;
  PointerStyleRadioGroup.AsInteger                 := ord(iSwitchSlider.PointerStyle);
  PointerIndicatorActiveColorPicker.Color          := iSwitchSlider.PointerIndicatorActiveColor;
  PointerIndicatorInactiveColorPicker.Color        := iSwitchSlider.PointerIndicatorInactiveColor;
  PointerColorPicker.Color                         := iSwitchSlider.PointerColor;
  PointerHighlightColorPicker.Color                := iSwitchSlider.PointerHighLightColor;

  TrackStyleRadioGroup.AsInteger                   := ord(iSwitchSlider.TrackStyle);
  TrackColorPicker.Color                           := iSwitchSlider.TrackColor;

  UpLoadOPCProperties(iSwitchSlider, iOPCBrowserPanel);

  PositionLabelActiveFontPicker.Font.Assign  (iSwitchSlider.PositionLabelActiveFont);
  PositionLabelInactiveFontPicker.Font.Assign(iSwitchSlider.PositionLabelInactiveFont);
end;
//****************************************************************************************************************************************************
procedure TiSwitchSliderComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchSlider : TiSwitchSlider;
  x             : Integer;
begin
  iSwitchSlider := Component as TiSwitchSlider;

  iSwitchSlider.EndsMargin                    := EndsMarginEdit.AsInteger;
  iSwitchSlider.ShowFocusRect                 := ShowFocusRectCheckBox.AsBoolean;
  iSwitchSlider.Enabled                       := EnabledCheckBox.AsBoolean;
  iSwitchSlider.ShowDisabledState             := ShowDisabledStateCheckBox.AsBoolean;
  iSwitchSlider.Transparent                   := TransparentCheckBox.AsBoolean;
  iSwitchSlider.AutoFrameRate                 := AutoFrameRateCheckBox.AsBoolean;
  iSwitchSlider.AutoCenter                    := AutoCenterCheckBox.AsBoolean;
  iSwitchSlider.UpdateFrameRate               := UpdateFrameRateEdit.AsInteger;

  iSwitchSlider.KeyArrowStepSize              := KeyArrowStepSizeEdit.AsInteger;
  iSwitchSlider.KeyPageStepSize               := KeyPageStepSizeEdit.AsInteger;

  iSwitchSlider.BackGroundColor               := BackGroundColorPicker.Color;

  iSwitchSlider.BorderStyle                   := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSwitchSlider.Orientation                   := TiOrientation(OrientationRadioGroup.AsInteger);
  iSwitchSlider.OrientationLabels             := TiOrientationSide(OrientationLabelsRadioGroup.AsInteger);

  iSwitchSlider.ShowPositionLabels            := ShowPositionLabelsCheckBox.AsBoolean;
  iSwitchSlider.PositionLabelMargin           := PositionLabelMarginEdit.AsInteger;

  iSwitchSlider.OffsetX                       := OffsetXEdit.AsInteger;
  iSwitchSlider.OffsetY                       := OffsetYEdit.AsInteger;

  iSwitchSlider.PositionLabels := '';

  for x := 0 to PositionLabelsListBox.Lines.Count - 1 do
    begin
      if Trim(PositionLabelsListBox.Lines.Strings[x]) <> '' then
        begin
          if x <> 0 then iSwitchSlider.PositionLabels := iSwitchSlider.PositionLabels + ', ';
          iSwitchSlider.PositionLabels := iSwitchSlider.PositionLabels + PositionLabelsListBox.Lines.Strings[x];
        end;
    end;

  iSwitchSlider.Position                      := PositionEdit.AsInteger ; //Must be set after position labels

  iSwitchSlider.PositionIndicatorStyle        := TiSwitchSliderIndicatorStyle(PositionIndicatorStyleRadioGroup.AsInteger);
  iSwitchSlider.PositionIndicatorBevelStyle   := TiBevelStyle(PositionIndicatorBevelStyleRadioGroup.AsInteger);
  iSwitchSlider.ShowPositionIndicators        := ShowPositionIndicatorsCheckBox.AsBoolean;
  iSwitchSlider.PositionIndicatorColor        := PositionIndicatorColorPicker.Color;
  iSwitchSlider.PositionIndicatorSize         := PositionIndicatorSizeEdit.AsInteger;
  iSwitchSlider.PositionIndicatorMargin       := PositionIndicatorMarginEdit.AsInteger;

  iSwitchSlider.PointerHeight                 := PointerHeightEdit.AsInteger;
  iSwitchSlider.PointerWidth                  := PointerWidthEdit.AsInteger;
  iSwitchSlider.PointerStyle                  := TiSliderPointerStyle(PointerStyleRadioGroup.AsInteger);
  iSwitchSlider.PointerIndicatorActiveColor   := PointerIndicatorActiveColorPicker.Color;
  iSwitchSlider.PointerIndicatorInactiveColor := PointerIndicatorInactiveColorPicker.Color;
  iSwitchSlider.PointerColor                  := PointerColorPicker.Color;
  iSwitchSlider.PointerHighLightColor         := PointerHighlightColorPicker.Color;

  iSwitchSlider.TrackStyle                    := TiSliderTrackStyle(TrackStyleRadioGroup.AsInteger);
  iSwitchSlider.TrackColor                    := TrackColorPicker.Color;

  DownLoadOPCProperties(iSwitchSlider, iOPCBrowserPanel);

  iSwitchSlider.PositionLabelActiveFont.Assign  (PositionLabelActiveFontPicker.Font);
  iSwitchSlider.PositionLabelInactiveFont.Assign(PositionLabelInactiveFontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
