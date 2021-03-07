{*******************************************************}
{                                                       }
{       TiLedSpiralComponentEditor                      }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedSpiralComponentEditor;{$endif}
{$ifdef iCLX}unit QiLedSpiralComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLedSpiral,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLedSpiral,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLedSpiralComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    Label2: TLabel;
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
    DesignGeneralTabSheet: TTabSheet;
    DesignSectionsTabSheet: TTabSheet;
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
    StyleRadioGroup: TiComponentEditorRadioGroup;
    SegmentGroupBox: TGroupBox;
    Label3: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    SegmentSizeUpDown: TiUpDown;
    SegmentWidthUpDown: TiUpDown;
    SegmentCountUpDown: TiUpDown;
    SegmentSizeEdit: TiComponentEditorEdit;
    SegmentWidthEdit: TiComponentEditorEdit;
    SegmentCountEdit: TiComponentEditorEdit;
    Label15: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    OuterRadiusUpDown: TiUpDown;
    RangeDegreesUpDown: TiUpDown;
    StartDegreesUpDown: TiUpDown;
    OuterRadiusEdit: TiComponentEditorEdit;
    RangeDegreesEdit: TiComponentEditorEdit;
    StartDegreesEdit: TiComponentEditorEdit;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    Label4: TLabel;
    OuterMarginUpDown: TiUpDown;
    OuterMarginEdit: TiComponentEditorEdit;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
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
  iLedSpiralComponentEditorForm: TiLedSpiralComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLedSpiralComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLedSpiral.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLedSpiralComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLedSpiral : TiLedSpiral;
begin
  iLedSpiral := Component as TiLedSpiral;

  PositionEdit.AsFloat               := iLedSpiral.Position;
  PositionMaxEdit.AsFloat            := iLedSpiral.PositionMax;
  PositionMinEdit.AsFloat            := iLedSpiral.PositionMin;
  CurrentMaxEdit.AsFloat             := iLedSpiral.CurrentMax;
  CurrentMinEdit.AsFloat             := iLedSpiral.CurrentMin;
  OuterRadiusEdit.AsInteger          := iLedSpiral.OuterRadius;
  StartDegreesEdit.AsInteger         := iLedSpiral.StartDegrees;
  RangeDegreesEdit.AsInteger         := iLedSpiral.RangeDegrees;
  OuterMarginEdit.AsInteger          := iLedSpiral.OuterMargin;
  AutoFrameRateCheckBox.AsBoolean    := iLedSpiral.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger      := iLedSpiral.UpdateFrameRate;

  ShowOffSegmentsCheckBox.AsBoolean  := iLedSpiral.ShowOffSegments;
  BackGroundColorPicker.Color        := iLedSpiral.BackGroundColor;
  TransparentCheckBox.AsBoolean      := iLedSpiral.Transparent;
  AutoSizeCheckBox.AsBoolean         := iLedSpiral.AutoSize;

  StyleRadioGroup.AsInteger          := ord(iLedSpiral.Style);
  BorderStyleRadioGroup.AsInteger    := ord(iLedSpiral.BorderStyle);

  SegmentSizeEdit.AsInteger          := iLedSpiral.SegmentSize;
  SegmentWidthEdit.AsInteger         := iLedSpiral.SegmentWidth;

  SectionCountEdit.AsInteger         := iLedSpiral.SectionCount;

  SectionColor1Picker.Color          := iLedSpiral.SectionColor1;
  SectionColor2Picker.Color          := iLedSpiral.SectionColor2;
  SectionColor3Picker.Color          := iLedSpiral.SectionColor3;
  SectionColor4Picker.Color          := iLedSpiral.SectionColor4;
  SectionColor5Picker.Color          := iLedSpiral.SectionColor5;

  SectionEnd1Edit.AsFloat            := iLedSpiral.SectionEnd1;
  SectionEnd2Edit.AsFloat            := iLedSpiral.SectionEnd2;
  SectionEnd3Edit.AsFloat            := iLedSpiral.SectionEnd3;
  SectionEnd4Edit.AsFloat            := iLedSpiral.SectionEnd4;

  UpLoadOPCProperties(iLedSpiral, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiLedSpiralComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLedSpiral : TiLedSpiral;
begin
  iLedSpiral := Component as TiLedSpiral;

  iLedSpiral.Position        := PositionEdit.AsFloat;
  iLedSpiral.PositionMax     := PositionMaxEdit.AsFloat;
  iLedSpiral.PositionMin     := PositionMinEdit.AsFloat;
  iLedSpiral.CurrentMax      := CurrentMaxEdit.AsFloat;
  iLedSpiral.CurrentMin      := CurrentMinEdit.AsFloat;
  iLedSpiral.OuterRadius     := OuterRadiusEdit.AsInteger;
  iLedSpiral.StartDegrees    := StartDegreesEdit.AsInteger;
  iLedSpiral.RangeDegrees    := RangeDegreesEdit.AsInteger;
  iLedSpiral.OuterMargin     := OuterMarginEdit.AsInteger;
  iLedSpiral.AutoFrameRate   := AutoFrameRateCheckBox.AsBoolean;
  iLedSpiral.UpdateFrameRate := UpdateFrameRateEdit.AsInteger;

  iLedSpiral.ShowOffSegments := ShowOffSegmentsCheckBox.AsBoolean;
  iLedSpiral.BackGroundColor := BackGroundColorPicker.Color;
  iLedSpiral.Transparent     := TransparentCheckBox.AsBoolean;
  iLedSpiral.AutoSize        := AutoSizeCheckBox.AsBoolean;

  iLedSpiral.Style           := TiLedSpiralStyle(StyleRadioGroup.AsInteger);
  iLedSpiral.BorderStyle     := TiBevelStyle(BorderStyleRadioGroup.AsInteger);

  iLedSpiral.SegmentCount    := SegmentCountEdit.AsInteger;
  iLedSpiral.SegmentSize     := SegmentSizeEdit.AsInteger;
  iLedSpiral.SegmentWidth    := SegmentWidthEdit.AsInteger;

  iLedSpiral.SectionCount    := SectionCountEdit.AsInteger;

  iLedSpiral.SectionColor1   := SectionColor1Picker.Color;
  iLedSpiral.SectionColor2   := SectionColor2Picker.Color;
  iLedSpiral.SectionColor3   := SectionColor3Picker.Color;
  iLedSpiral.SectionColor4   := SectionColor4Picker.Color;
  iLedSpiral.SectionColor5   := SectionColor5Picker.Color;

  iLedSpiral.SectionEnd1     := SectionEnd1Edit.AsFloat;
  iLedSpiral.SectionEnd2     := SectionEnd2Edit.AsFloat;
  iLedSpiral.SectionEnd3     := SectionEnd3Edit.AsFloat;
  iLedSpiral.SectionEnd4     := SectionEnd4Edit.AsFloat;

  DownLoadOPCProperties(iLedSpiral, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
