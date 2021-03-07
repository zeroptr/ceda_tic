{*******************************************************}
{                                                       }
{       TiSevenSegmentAnalogComponentEditor             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentAnalogComponentEditor;{$endif}
{$ifdef iCLX}unit QiSevenSegmentAnalogComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSevenSegmentAnalog,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSevenSegmentAnalog,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSevenSegmentAnalogComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    LeadingStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    Label6: TLabel;
    PrecisionEdit: TiComponentEditorEdit;
    PrecisionUpDown: TiUpDown;
    ShowSignCheckBox: TiComponentEditorCheckBox;
    SegmentGroupBox: TGroupBox;
    Label2: TLabel;
    SegmentSeperationEdit: TiComponentEditorEdit;
    SegmentSeperationUpDown: TiUpDown;
    Label3: TLabel;
    SegmentSizeEdit: TiComponentEditorEdit;
    SegmentSizeUpDown: TiUpDown;
    Label4: TLabel;
    SegmentMarginEdit: TiComponentEditorEdit;
    SegmentMarginUpDown: TiUpDown;
    SegmentColorPicker: TiComponentEditorColorPicker;
    Label7: TLabel;
    DigitsGroupBox: TGroupBox;
    Label1: TLabel;
    DigitSpacingEdit: TiComponentEditorEdit;
    DigitSpacingUpDown: TiUpDown;
    Label5: TLabel;
    DigitCountEdit: TiComponentEditorEdit;
    DigitCountUpDown: TiUpDown;
    Label8: TLabel;
    ValueEdit: TiComponentEditorEdit;
    AutoSegmentOffColorCheckBox: TiComponentEditorCheckBox;
    SegmentOffColorPicker: TiComponentEditorColorPicker;
    Label9: TLabel;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSevenSegmentAnalogComponentEditorForm: TiSevenSegmentAnalogComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSevenSegmentAnalogComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSevenSegmentAnalog.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentAnalogComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSevenSegmentAnalog : TiSevenSegmentAnalog;
begin
  iSevenSegmentAnalog := Component as TiSevenSegmentAnalog;

  AutoSizeCheckBox.AsBoolean            := iSevenSegmentAnalog.AutoSize;
  ShowOffSegmentsCheckBox.AsBoolean     := iSevenSegmentAnalog.ShowOffSegments;
  AutoSegmentOffColorCheckBox.AsBoolean := iSevenSegmentAnalog.AutoSegmentOffColor;
  ShowSignCheckBox.AsBoolean            := iSevenSegmentAnalog.ShowSign;
  TransparentCheckBox.AsBoolean         := iSevenSegmentAnalog.Transparent;
  AutoFrameRateCheckBox.AsBoolean       := iSevenSegmentAnalog.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSevenSegmentAnalog.UpdateFrameRate;

  ValueEdit.AsFloat                     := iSevenSegmentAnalog.Value;

  PrecisionEdit.AsInteger               := iSevenSegmentAnalog.Precision;
  BackGroundColorPicker.Color           := iSevenSegmentAnalog.BackGroundColor;

  BorderStyleRadioGroup.AsInteger       := ord(iSevenSegmentAnalog.BorderStyle);
  LeadingStyleRadioGroup.AsInteger      := ord(iSevenSegmentAnalog.LeadingStyle);

  DigitCountEdit.AsInteger              := iSevenSegmentAnalog.DigitCount;
  DigitSpacingEdit.AsInteger            := iSevenSegmentAnalog.DigitSpacing;

  SegmentSizeEdit.AsInteger             := iSevenSegmentAnalog.SegmentSize;
  SegmentSeperationEdit.AsInteger       := iSevenSegmentAnalog.SegmentSeperation;
  SegmentMarginEdit.AsInteger           := iSevenSegmentAnalog.SegmentMargin;
  SegmentColorPicker.Color              := iSevenSegmentAnalog.SegmentColor;
  SegmentOffColorPicker.Color           := iSevenSegmentAnalog.SegmentOffColor;

  UpLoadOPCProperties(iSevenSegmentAnalog, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentAnalogComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSevenSegmentAnalog : TiSevenSegmentAnalog;
begin
  iSevenSegmentAnalog := Component as TiSevenSegmentAnalog;

  iSevenSegmentAnalog.AutoSize            := AutoSizeCheckBox.AsBoolean;
  iSevenSegmentAnalog.ShowOffSegments     := ShowOffSegmentsCheckBox.AsBoolean;
  iSevenSegmentAnalog.AutoSegmentOffColor := AutoSegmentOffColorCheckBox.AsBoolean;
  iSevenSegmentAnalog.ShowSign            := ShowSignCheckBox.AsBoolean;
  iSevenSegmentAnalog.Transparent         := TransparentCheckBox.AsBoolean;
  iSevenSegmentAnalog.AutoFrameRate       := AutoFrameRateCheckBox.AsBoolean;
  iSevenSegmentAnalog.UpdateFrameRate     := UpdateFrameRateEdit.AsInteger;

  iSevenSegmentAnalog.Value               := ValueEdit.AsFloat;

  iSevenSegmentAnalog.Precision           := PrecisionEdit.AsInteger;
  iSevenSegmentAnalog.BackGroundColor     := BackGroundColorPicker.Color;

  iSevenSegmentAnalog.BorderStyle         := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSevenSegmentAnalog.LeadingStyle        := TiLeadingStyle(LeadingStyleRadioGroup.AsInteger);

  iSevenSegmentAnalog.DigitCount          := DigitCountEdit.AsInteger;
  iSevenSegmentAnalog.DigitSpacing        := DigitSpacingEdit.AsInteger;

  iSevenSegmentAnalog.SegmentSize         := SegmentSizeEdit.AsInteger;
  iSevenSegmentAnalog.SegmentSeperation   := SegmentSeperationEdit.AsInteger;
  iSevenSegmentAnalog.SegmentMargin       := SegmentMarginEdit.AsInteger;
  iSevenSegmentAnalog.SegmentColor        := SegmentColorPicker.Color;
  iSevenSegmentAnalog.SegmentOffColor     := SegmentOffColorPicker.Color;

  DownLoadOPCProperties(iSevenSegmentAnalog, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
