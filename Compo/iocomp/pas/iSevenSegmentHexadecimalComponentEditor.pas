{*******************************************************}
{                                                       }
{       TiSevenSegmentHexadecimalComponentEditor        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentHexadecimalComponentEditor;{$endif}
{$ifdef iCLX}unit QiSevenSegmentHexadecimalComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSevenSegmentHexadecimal,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSevenSegmentHexadecimal,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSevenSegmentHexadecimalComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label8: TLabel;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    LeadingStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    SegmentGroupBox: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SegmentColorPicker: TiComponentEditorColorPicker;
    Label7: TLabel;
    SegmentOffColorPicker: TiComponentEditorColorPicker;
    Label9: TLabel;
    SegmentSeperationEdit: TiComponentEditorEdit;
    SegmentSeperationUpDown: TiUpDown;
    SegmentSizeEdit: TiComponentEditorEdit;
    SegmentSizeUpDown: TiUpDown;
    SegmentMarginEdit: TiComponentEditorEdit;
    SegmentMarginUpDown: TiUpDown;
    DigitsGroupBox: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    DigitSpacingEdit: TiComponentEditorEdit;
    DigitSpacingUpDown: TiUpDown;
    DigitCountEdit: TiComponentEditorEdit;
    DigitCountUpDown: TiUpDown;
    ValueEdit: TiComponentEditorEdit;
    AutoSegmentOffColorCheckBox: TiComponentEditorCheckBox;
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
  iSevenSegmentHexadecimalComponentEditorForm: TiSevenSegmentHexadecimalComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSevenSegmentHexadecimalComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSevenSegmentHexadecimal.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentHexadecimalComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSevenSegmentHexadecimal : TiSevenSegmentHexadecimal;
begin
  iSevenSegmentHexadecimal := Component as TiSevenSegmentHexadecimal;

  AutoSizeCheckBox.AsBoolean            := iSevenSegmentHexadecimal.AutoSize;
  ShowOffSegmentsCheckBox.AsBoolean     := iSevenSegmentHexadecimal.ShowOffSegments;
  AutoSegmentOffColorCheckBox.AsBoolean := iSevenSegmentHexadecimal.AutoSegmentOffColor;
  TransparentCheckBox.AsBoolean         := iSevenSegmentHexadecimal.Transparent;
  AutoFrameRateCheckBox.AsBoolean       := iSevenSegmentHexadecimal.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSevenSegmentHexadecimal.UpdateFrameRate;

  ValueEdit.AsString                    := iSevenSegmentHexadecimal.Value;

  BackGroundColorPicker.Color           := iSevenSegmentHexadecimal.BackGroundColor;

  BorderStyleRadioGroup.AsInteger       := ord(iSevenSegmentHexadecimal.BorderStyle);
  LeadingStyleRadioGroup.AsInteger      := ord(iSevenSegmentHexadecimal.LeadingStyle);

  DigitCountEdit.AsInteger              := iSevenSegmentHexadecimal.DigitCount;
  DigitSpacingEdit.AsInteger            := iSevenSegmentHexadecimal.DigitSpacing;

  SegmentSizeEdit.AsInteger             := iSevenSegmentHexadecimal.SegmentSize;
  SegmentSeperationEdit.AsInteger       := iSevenSegmentHexadecimal.SegmentSeperation;
  SegmentMarginEdit.AsInteger           := iSevenSegmentHexadecimal.SegmentMargin;
  SegmentColorPicker.Color              := iSevenSegmentHexadecimal.SegmentColor;
  SegmentOffColorPicker.Color           := iSevenSegmentHexadecimal.SegmentOffColor;

  UpLoadOPCProperties(iSevenSegmentHexadecimal, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentHexadecimalComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSevenSegmentHexadecimal : TiSevenSegmentHexadecimal;
begin
  iSevenSegmentHexadecimal := Component as TiSevenSegmentHexadecimal;

  iSevenSegmentHexadecimal.AutoSize            := AutoSizeCheckBox.AsBoolean;
  iSevenSegmentHexadecimal.ShowOffSegments     := ShowOffSegmentsCheckBox.AsBoolean;
  iSevenSegmentHexadecimal.AutoSegmentOffColor := AutoSegmentOffColorCheckBox.AsBoolean;
  iSevenSegmentHexadecimal.Transparent         := TransparentCheckBox.AsBoolean;
  iSevenSegmentHexadecimal.AutoFrameRate       := AutoFrameRateCheckBox.AsBoolean;
  iSevenSegmentHexadecimal.UpdateFrameRate     := UpdateFrameRateEdit.AsInteger;

  iSevenSegmentHexadecimal.Value               := ValueEdit.AsString;

  iSevenSegmentHexadecimal.BackGroundColor     := BackGroundColorPicker.Color;

  iSevenSegmentHexadecimal.BorderStyle         := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSevenSegmentHexadecimal.LeadingStyle        := TiLeadingStyle(LeadingStyleRadioGroup.AsInteger);

  iSevenSegmentHexadecimal.DigitCount          := DigitCountEdit.AsInteger;
  iSevenSegmentHexadecimal.DigitSpacing        := DigitSpacingEdit.AsInteger;

  iSevenSegmentHexadecimal.SegmentSize         := SegmentSizeEdit.AsInteger;
  iSevenSegmentHexadecimal.SegmentSeperation   := SegmentSeperationEdit.AsInteger;
  iSevenSegmentHexadecimal.SegmentMargin       := SegmentMarginEdit.AsInteger;
  iSevenSegmentHexadecimal.SegmentColor        := SegmentColorPicker.Color;
  iSevenSegmentHexadecimal.SegmentOffColor     := SegmentOffColorPicker.Color;

  DownLoadOPCProperties(iSevenSegmentHexadecimal, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
