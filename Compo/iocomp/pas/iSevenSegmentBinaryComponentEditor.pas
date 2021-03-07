{*******************************************************}
{                                                       }
{       TiSevenSegmentBinaryComponentEditor             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentBinaryComponentEditor;{$endif}
{$ifdef iCLX}unit QiSevenSegmentBinaryComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSevenSegmentBinary,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSevenSegmentBinary,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSevenSegmentBinaryComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    LeadingStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
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
    SegmentOffColorPicker: TiComponentEditorColorPicker;
    Label9: TLabel;
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
  iSevenSegmentBinaryComponentEditorForm: TiSevenSegmentBinaryComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSevenSegmentBinaryComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSevenSegmentBinary.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentBinaryComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSevenSegmentBinary : TiSevenSegmentBinary;
begin
  iSevenSegmentBinary := Component as TiSevenSegmentBinary;

  AutoSizeCheckBox.AsBoolean            := iSevenSegmentBinary.AutoSize;
  ShowOffSegmentsCheckBox.AsBoolean     := iSevenSegmentBinary.ShowOffSegments;
  AutoSegmentOffColorCheckBox.AsBoolean := iSevenSegmentBinary.AutoSegmentOffColor;
  TransparentCheckBox.AsBoolean         := iSevenSegmentBinary.Transparent;
  AutoFrameRateCheckBox.AsBoolean       := iSevenSegmentBinary.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSevenSegmentBinary.UpdateFrameRate;

  ValueEdit.AsString                    := iSevenSegmentBinary.Value;

  BackGroundColorPicker.Color           := iSevenSegmentBinary.BackGroundColor;

  BorderStyleRadioGroup.AsInteger       := ord(iSevenSegmentBinary.BorderStyle);
  LeadingStyleRadioGroup.AsInteger      := ord(iSevenSegmentBinary.LeadingStyle);

  DigitCountEdit.AsInteger              := iSevenSegmentBinary.DigitCount;
  DigitSpacingEdit.AsInteger            := iSevenSegmentBinary.DigitSpacing;

  SegmentSizeEdit.AsInteger             := iSevenSegmentBinary.SegmentSize;
  SegmentSeperationEdit.AsInteger       := iSevenSegmentBinary.SegmentSeperation;
  SegmentMarginEdit.AsInteger           := iSevenSegmentBinary.SegmentMargin;
  SegmentColorPicker.Color              := iSevenSegmentBinary.SegmentColor;
  SegmentOffColorPicker.Color           := iSevenSegmentBinary.SegmentOffColor;

  UpLoadOPCProperties(iSevenSegmentBinary, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentBinaryComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSevenSegmentBinary : TiSevenSegmentBinary;
begin
  iSevenSegmentBinary := Component as TiSevenSegmentBinary;

  iSevenSegmentBinary.AutoSize            := AutoSizeCheckBox.AsBoolean;
  iSevenSegmentBinary.ShowOffSegments     := ShowOffSegmentsCheckBox.AsBoolean;
  iSevenSegmentBinary.AutoSegmentOffColor := AutoSegmentOffColorCheckBox.AsBoolean;
  iSevenSegmentBinary.Transparent         := TransparentCheckBox.AsBoolean;
  iSevenSegmentBinary.AutoFrameRate       := AutoFrameRateCheckBox.AsBoolean;
  iSevenSegmentBinary.UpdateFrameRate     := UpdateFrameRateEdit.AsInteger;

  iSevenSegmentBinary.Value               := ValueEdit.AsString;

  iSevenSegmentBinary.BackGroundColor     := BackGroundColorPicker.Color;

  iSevenSegmentBinary.BorderStyle         := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSevenSegmentBinary.LeadingStyle        := TiLeadingStyle(LeadingStyleRadioGroup.AsInteger);

  iSevenSegmentBinary.DigitCount          := DigitCountEdit.AsInteger;
  iSevenSegmentBinary.DigitSpacing        := DigitSpacingEdit.AsInteger;

  iSevenSegmentBinary.SegmentSize         := SegmentSizeEdit.AsInteger;
  iSevenSegmentBinary.SegmentSeperation   := SegmentSeperationEdit.AsInteger;
  iSevenSegmentBinary.SegmentMargin       := SegmentMarginEdit.AsInteger;
  iSevenSegmentBinary.SegmentColor        := SegmentColorPicker.Color;
  iSevenSegmentBinary.SegmentOffColor     := SegmentOffColorPicker.Color;

  DownLoadOPCProperties(iSevenSegmentBinary, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
