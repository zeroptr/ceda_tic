{*******************************************************}
{                                                       }
{       TiSwitchRotaryComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchRotaryComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchRotaryComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchRotary,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchRotary,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchRotaryComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    EnabledCheckBox: TiComponentEditorCheckBox;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
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
    iComponentEditorPageControl1: TiComponentEditorPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DesignPointerTabSheet: TTabSheet;
    PositionLabelsGroupBox: TGroupBox;
    Label6: TLabel;
    Label13: TLabel;
    PositionLabelMarginUpDown: TiUpDown;
    PositionLabelMarginEdit: TiComponentEditorEdit;
    PositionLabelActiveFontPicker: TiComponentEditorFontPicker;
    PositionLabelInactiveFontPicker: TiComponentEditorFontPicker;
    PositionLabelAlignmentRadioGroup: TiComponentEditorRadioGroup;
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
    Label31: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    RotationStartDegreesRadioGroup: TiComponentEditorRadioGroup;
    OffsetGroupBox: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    OffsetXUpDown: TiUpDown;
    OffsetYUpDown: TiUpDown;
    OffsetXEdit: TiComponentEditorEdit;
    OffsetYEdit: TiComponentEditorEdit;
    MouseControlStyleRadioGroup: TiComponentEditorRadioGroup;
    Label1: TLabel;
    Label8: TLabel;
    PointerHeightUpDown: TiUpDown;
    PointerLengthUpDown: TiUpDown;
    Label14: TLabel;
    PointerHeightEdit: TiComponentEditorEdit;
    PointerLengthEdit: TiComponentEditorEdit;
    PointerStyleComboBox: TiComponentEditorComboBox;
    Label3: TLabel;
    PointerColorPicker: TiComponentEditorColorPicker;
    Label15: TLabel;
    PointerHighlightColorPicker: TiComponentEditorColorPicker;
    RotationDesiredSpacingRadioGroup: TiComponentEditorRadioGroup;
    DesignFaceTabSheet: TTabSheet;
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
    FaceGroupBox: TGroupBox;
    Label16: TLabel;
    PointerFaceColorPicker: TiComponentEditorColorPicker;
    ShowPointerFaceCheckBox: TiComponentEditorCheckBox;
    PointerFaceBevelGroupBox: TGroupBox;
    Label18: TLabel;
    PointerFaceBevelSizeUpDown: TiUpDown;
    Label19: TLabel;
    PointerFaceBevelSizeEdit: TiComponentEditorEdit;
    PointerFaceBevelStyleComboBox: TiComponentEditorComboBox;
    Label17: TLabel;
    OuterMarginUpDown: TiUpDown;
    OuterMarginEdit: TiComponentEditorEdit;
    ShowDisabledStateCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSwitchRotaryComponentEditorForm: TiSwitchRotaryComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchRotaryComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchRotary.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRotaryComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchRotary : TiSwitchRotary;
  x             : Integer;
begin
  iSwitchRotary := Component as TiSwitchRotary;

  PositionEdit.AsInteger                          := iSwitchRotary.Position;
  ShowFocusRectCheckBox.AsBoolean                 := iSwitchRotary.ShowFocusRect;
  EnabledCheckBox.AsBoolean                       := iSwitchRotary.Enabled;
  ShowDisabledStateCheckBox.AsBoolean             := iSwitchRotary.ShowDisabledState;
  TransparentCheckBox.AsBoolean                   := iSwitchRotary.Transparent;
  AutoFrameRateCheckBox.AsBoolean                 := iSwitchRotary.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger                   := iSwitchRotary.UpdateFrameRate;

  KeyArrowStepSizeEdit.AsInteger                  := iSwitchRotary.KeyArrowStepSize;
  KeyPageStepSizeEdit.AsInteger                   := iSwitchRotary.KeyPageStepSize;

  OffsetXEdit.AsInteger                           := iSwitchRotary.OffsetX;
  OffsetYEdit.AsInteger                           := iSwitchRotary.OffsetY;

  BackGroundColorPicker.Color                     := iSwitchRotary.BackGroundColor;

  RotationStartDegreesRadioGroup.AsInteger        := ord(iSwitchRotary.RotationStartDegrees);
  RotationDesiredSpacingRadioGroup.AsInteger      := ord(iSwitchRotary.RotationDesiredSpacing);
  MouseControlStyleRadioGroup.AsInteger           := ord(iSwitchRotary.MouseControlStyle);

  ShowFaceCheckBox.AsBoolean                      := iSwitchRotary.ShowFace;
  FaceStyleComboBox.AsInteger                     := ord(iSwitchRotary.FaceStyle);
  FaceBevelSizeEdit.AsInteger                     := iSwitchRotary.FaceBevelSize;
  FaceBevelStyleComboBox.AsInteger                := ord(iSwitchRotary.FaceBevelStyle);
  FaceColorPicker.Color                           := iSwitchRotary.FaceColor;
  OuterMarginEdit.AsInteger                       := iSwitchRotary.OuterMargin;

  PointerHeightEdit.AsInteger                     := iSwitchRotary.PointerHeight;
  PointerLengthEdit.AsInteger                     := iSwitchRotary.PointerLength;
  PointerStyleComboBox.AsInteger                  := ord(iSwitchRotary.PointerStyle);
  PointerColorPicker.Color                        := iSwitchRotary.PointerColor;
  PointerHighlightColorPicker.Color               := iSwitchRotary.PointerHighLightColor;

  ShowPointerFaceCheckBox.AsBoolean               := iSwitchRotary.ShowPointerFace;
  PointerFaceBevelSizeEdit.AsInteger              := iSwitchRotary.PointerFaceBevelSize;
  PointerFaceBevelStyleComboBox.AsInteger         := ord(iSwitchRotary.PointerFaceBevelStyle);
  PointerFaceColorPicker.Color                    := iSwitchRotary.PointerFaceColor;

  ShowPositionLabelsCheckBox.AsBoolean            := iSwitchRotary.ShowPositionLabels;
  PositionLabelAlignmentRadioGroup.AsInteger      := ord(iSwitchRotary.PositionLabelAlignment);
  PositionLabelMarginEdit.AsInteger               := iSwitchRotary.PositionLabelMargin;

  PositionLabelsListBox.Lines.Clear;
  for x := 0 to iSwitchRotary.PositionLabelCount - 1 do
    PositionLabelsListBox.Lines.Add(iSwitchRotary.PositionLabel[x]);

  PositionIndicatorBevelStyleRadioGroup.AsInteger := ord(iSwitchRotary.PositionIndicatorBevelStyle);
  ShowPositionIndicatorsCheckBox.AsBoolean        := iSwitchRotary.ShowPositionIndicators;
  PositionIndicatorColorPicker.Color              := iSwitchRotary.PositionIndicatorColor;
  PositionIndicatorSizeEdit.AsInteger             := iSwitchRotary.PositionIndicatorSize;
  PositionIndicatorMarginEdit.AsInteger           := iSwitchRotary.PositionIndicatorMargin;

  UpLoadOPCProperties(iSwitchRotary, iOPCBrowserPanel);

  PositionLabelActiveFontPicker.Font.Assign  (iSwitchRotary.PositionLabelActiveFont);
  PositionLabelInactiveFontPicker.Font.Assign(iSwitchRotary.PositionLabelInactiveFont);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRotaryComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchRotary : TiSwitchRotary;
  x             : Integer;
  TempString    : String;
begin
  iSwitchRotary := Component as TiSwitchRotary;

  iSwitchRotary.ShowFocusRect               := ShowFocusRectCheckBox.AsBoolean;
  iSwitchRotary.Enabled                     := EnabledCheckBox.AsBoolean;
  iSwitchRotary.ShowDisabledState           := ShowDisabledStateCheckBox.AsBoolean;
  iSwitchRotary.Transparent                 := TransparentCheckBox.AsBoolean;
  iSwitchRotary.AutoFrameRate               := AutoFrameRateCheckBox.AsBoolean;
  iSwitchRotary.UpdateFrameRate             := UpdateFrameRateEdit.AsInteger;

  iSwitchRotary.KeyArrowStepSize            := KeyArrowStepSizeEdit.AsInteger;
  iSwitchRotary.KeyPageStepSize             := KeyPageStepSizeEdit.AsInteger;

  iSwitchRotary.OffsetX                     := OffsetXEdit.AsInteger;
  iSwitchRotary.OffsetY                     := OffsetYEdit.AsInteger;

  iSwitchRotary.BackGroundColor             := BackGroundColorPicker.Color;

  iSwitchRotary.RotationStartDegrees        := TiRotaryStartDegrees(RotationStartDegreesRadioGroup.AsInteger);
  iSwitchRotary.RotationDesiredSpacing      := TiRotaryDesiredSpacing(RotationDesiredSpacingRadioGroup.AsInteger);
  iSwitchRotary.MouseControlStyle           := TiRotaryMouseControlStyle(MouseControlStyleRadioGroup.AsInteger);

  iSwitchRotary.ShowFace                    := ShowFaceCheckBox.AsBoolean;
  iSwitchRotary.FaceStyle                   := TiDrawEdgeStyle(FaceStyleComboBox.AsInteger);
  iSwitchRotary.FaceBevelSize               := FaceBevelSizeEdit.AsInteger;
  iSwitchRotary.FaceBevelStyle              := TiDrawEdgeStyle(FaceBevelStyleComboBox.AsInteger);
  iSwitchRotary.FaceColor                   := FaceColorPicker.Color;
  iSwitchRotary.OuterMargin                 := OuterMarginEdit.AsInteger;

  iSwitchRotary.PointerHeight               := PointerHeightEdit.AsInteger;
  iSwitchRotary.PointerLength               := PointerLengthEdit.AsInteger;
  iSwitchRotary.PointerStyle                := TiSwitchRotaryPointerStyle(PointerStyleComboBox.AsInteger);
  iSwitchRotary.PointerColor                := PointerColorPicker.Color;
  iSwitchRotary.PointerHighLightColor       := PointerHighlightColorPicker.Color;

  iSwitchRotary.ShowPointerFace             := ShowPointerFaceCheckBox.AsBoolean;
  iSwitchRotary.PointerFaceBevelSize        := PointerFaceBevelSizeEdit.AsInteger;
  iSwitchRotary.PointerFaceBevelStyle       := TiDrawEdgeStyle(PointerFaceBevelStyleComboBox.AsInteger);
  iSwitchRotary.PointerFaceColor            := PointerFaceColorPicker.Color;

  iSwitchRotary.ShowPositionLabels          := ShowPositionLabelsCheckBox.AsBoolean;
  iSwitchRotary.PositionLabelAlignment      := TiLabelAlignment(PositionLabelAlignmentRadioGroup.AsInteger);
  iSwitchRotary.PositionLabelMargin         := PositionLabelMarginEdit.AsInteger;

  TempString := '';
  for x := 0 to PositionLabelsListBox.Lines.Count - 1 do
    begin
      if Trim(PositionLabelsListBox.Lines.Strings[x]) <> '' then
        begin
          if x <> 0 then TempString := TempString + ', ';
          TempString := TempString + PositionLabelsListBox.Lines.Strings[x];
        end;
    end;
  iSwitchRotary.PositionLabels              := TempString;

  iSwitchRotary.Position                    := PositionEdit.AsInteger ; //Must be set after position labels

  iSwitchRotary.PositionIndicatorBevelStyle := TiBevelStyle(PositionIndicatorBevelStyleRadioGroup.AsInteger);
  iSwitchRotary.ShowPositionIndicators      := ShowPositionIndicatorsCheckBox.AsBoolean;
  iSwitchRotary.PositionIndicatorColor      := PositionIndicatorColorPicker.Color;
  iSwitchRotary.PositionIndicatorSize       := PositionIndicatorSizeEdit.AsInteger;
  iSwitchRotary.PositionIndicatorMargin     := PositionIndicatorMarginEdit.AsInteger;

  DownLoadOPCProperties(iSwitchRotary, iOPCBrowserPanel);

  iSwitchRotary.PositionLabelActiveFont.Assign  (PositionLabelActiveFontPicker.Font);
  iSwitchRotary.PositionLabelInactiveFont.Assign(PositionLabelInactiveFontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
