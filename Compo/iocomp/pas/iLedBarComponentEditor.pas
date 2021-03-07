{*******************************************************}
{                                                       }
{       TiLedBarComponentEditor                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedBarComponentEditor;{$endif}
{$ifdef iCLX}unit QiLedBarComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLedBar,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLedBar,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLedBarComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label8: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    Label14: TLabel;
    Label29: TLabel;
    CurrentMaxEdit: TiComponentEditorEdit;
    CurrentMinEdit: TiComponentEditorEdit;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    DesignTabSheet: TTabSheet;
    DesignPageControl: TiComponentEditorPageControl;
    DesignSegmentsTabSheet: TTabSheet;
    DesignSectionsTabSheet: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SegmentSpacingUpDown: TiUpDown;
    SegmentSizeUpDown: TiUpDown;
    SegmentMarginUpDown: TiUpDown;
    SegmentSpacingEdit: TiComponentEditorEdit;
    SegmentSizeEdit: TiComponentEditorEdit;
    SegmentMarginEdit: TiComponentEditorEdit;
    SegmentDirectionRadioGroup: TiComponentEditorRadioGroup;
    SegmentStyleRadioGroup: TiComponentEditorRadioGroup;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    SectionCountUpDown: TiUpDown;
    SectionColor1Picker: TiComponentEditorColorPicker;
    SectionColor2Picker: TiComponentEditorColorPicker;
    SectionColor3Picker: TiComponentEditorColorPicker;
    SectionEnd1Edit: TiComponentEditorEdit;
    SectionEnd2Edit: TiComponentEditorEdit;
    SectionCountEdit: TiComponentEditorEdit;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label5: TLabel;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    FillReferenceGroupBox: TiComponentEditorGroupBox;
    FillReferenceEnabledCheckBox: TiComponentEditorCheckBox;
    Label15: TLabel;
    FillReferenceValueEdit: TiComponentEditorEdit;
    Label30: TLabel;
    Label31: TLabel;
    SectionColor4Picker: TiComponentEditorColorPicker;
    SectionColor5Picker: TiComponentEditorColorPicker;
    Label32: TLabel;
    Label33: TLabel;
    SectionEnd3Edit: TiComponentEditorEdit;
    SectionEnd4Edit: TiComponentEditorEdit;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iLedBarComponentEditorForm: TiLedBarComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLedBarComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLedBar.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLedBarComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLedBar : TiLedBar;
begin
  iLedBar := Component as TiLedBar;

  PositionEdit.AsFloat                   := iLedBar.Position;
  PositionMaxEdit.AsFloat                := iLedBar.PositionMax;
  PositionMinEdit.AsFloat                := iLedBar.PositionMin;
  CurrentMaxEdit.AsFloat                 := iLedBar.CurrentMax;
  CurrentMinEdit.AsFloat                 := iLedBar.CurrentMin;
  ShowOffSegmentsCheckBox.AsBoolean      := iLedBar.ShowOffSegments;
  BackGroundColorPicker.Color            := iLedBar.BackGroundColor;
  TransparentCheckBox.AsBoolean          := iLedBar.Transparent;
  FillReferenceEnabledCheckBox.AsBoolean := iLedBar.FillReferenceEnabled;
  FillReferenceValueEdit.AsFloat         := iLedBar.FillReferenceValue;
  AutoFrameRateCheckBox.AsBoolean        := iLedBar.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger          := iLedBar.UpdateFrameRate;

  BorderStyleRadioGroup.AsInteger        := ord(iLedBar.BorderStyle);
  SegmentSizeEdit.AsInteger              := iLedBar.SegmentSize;
  SegmentSpacingEdit.AsInteger           := iLedBar.Segmentspacing;
  SegmentMarginEdit.AsInteger            := iLedBar.SegmentMargin;
  SegmentDirectionRadioGroup.AsInteger   := ord(iLedBar.SegmentDirection);
  SegmentStyleRadioGroup.AsInteger       := ord(iLedBar.SegmentStyle);

  SectionCountEdit.AsInteger             := iLedBar.SectionCount;
  
  SectionColor1Picker.Color              := iLedBar.SectionColor1;
  SectionColor2Picker.Color              := iLedBar.SectionColor2;
  SectionColor3Picker.Color              := iLedBar.SectionColor3;
  SectionColor4Picker.Color              := iLedBar.SectionColor4;
  SectionColor5Picker.Color              := iLedBar.SectionColor5;

  SectionEnd1Edit.AsFloat                := iLedBar.SectionEnd1;
  SectionEnd2Edit.AsFloat                := iLedBar.SectionEnd2;
  SectionEnd3Edit.AsFloat                := iLedBar.SectionEnd3;
  SectionEnd4Edit.AsFloat                := iLedBar.SectionEnd4;

  UpLoadOPCProperties(iLedBar, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiLedBarComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLedBar : TiLedBar;
begin
  iLedBar := Component as TiLedBar;

  iLedBar.Position             := PositionEdit.AsFloat;
  iLedBar.PositionMax          := PositionMaxEdit.AsFloat;
  iLedBar.PositionMin          := PositionMinEdit.AsFloat;
  iLedBar.CurrentMax           := CurrentMaxEdit.AsFloat;
  iLedBar.CurrentMin           := CurrentMinEdit.AsFloat;
  iLedBar.ShowOffSegments      := ShowOffSegmentsCheckBox.AsBoolean;
  iLedBar.BackGroundColor      := BackGroundColorPicker.Color;
  iLedBar.Transparent          := TransparentCheckBox.AsBoolean;
  iLedBar.FillReferenceEnabled := FillReferenceEnabledCheckBox.AsBoolean;
  iLedBar.FillReferenceValue   := FillReferenceValueEdit.AsFloat;
  iLedBar.AutoFrameRate        := AutoFrameRateCheckBox.AsBoolean;
  iLedBar.UpdateFrameRate      := UpdateFrameRateEdit.AsInteger;

  iLedBar.BorderStyle          := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iLedBar.SegmentSize          := SegmentSizeEdit.AsInteger;
  iLedBar.Segmentspacing       := SegmentSpacingEdit.AsInteger;
  iLedBar.SegmentMargin        := SegmentMarginEdit.AsInteger;
  iLedBar.SegmentDirection     := TiDirection(SegmentDirectionRadioGroup.AsInteger);
  iLedBar.SegmentStyle         := TiLedBarSegmentStyle(SegmentStyleRadioGroup.AsInteger);

  iLedBar.SectionCount         := SectionCountEdit.AsInteger;

  iLedBar.SectionColor1        := SectionColor1Picker.Color;
  iLedBar.SectionColor2        := SectionColor2Picker.Color;
  iLedBar.SectionColor3        := SectionColor3Picker.Color;
  iLedBar.SectionColor4        := SectionColor4Picker.Color;
  iLedBar.SectionColor5        := SectionColor5Picker.Color;

  iLedBar.SectionEnd1          := SectionEnd1Edit.AsFloat;
  iLedBar.SectionEnd2          := SectionEnd2Edit.AsFloat;
  iLedBar.SectionEnd3          := SectionEnd3Edit.AsFloat;
  iLedBar.SectionEnd4          := SectionEnd4Edit.AsFloat;

  DownLoadOPCProperties(iLedBar, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
