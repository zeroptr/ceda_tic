{*******************************************************}
{                                                       }
{       TiSevenSegmentIntegerComponentEditor            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentIntegerComponentEditor;{$endif}
{$ifdef iCLX}unit QiSevenSegmentIntegerComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSevenSegmentInteger,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSevenSegmentInteger,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSevenSegmentIntegerComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label8: TLabel;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    LeadingStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    ShowSignCheckBox: TiComponentEditorCheckBox;
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
  iSevenSegmentIntegerComponentEditorForm: TiSevenSegmentIntegerComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSevenSegmentIntegerComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSevenSegmentInteger.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentIntegerComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSevenSegmentInteger : TiSevenSegmentInteger;
begin
  iSevenSegmentInteger := Component as TiSevenSegmentInteger;

  AutoSizeCheckBox.AsBoolean            := iSevenSegmentInteger.AutoSize;
  ShowOffSegmentsCheckBox.AsBoolean     := iSevenSegmentInteger.ShowOffSegments;
  AutoSegmentOffColorCheckBox.AsBoolean := iSevenSegmentInteger.AutoSegmentOffColor;
  ShowSignCheckBox.AsBoolean            := iSevenSegmentInteger.ShowSign;
  TransparentCheckBox.AsBoolean         := iSevenSegmentInteger.Transparent;
  AutoFrameRateCheckBox.AsBoolean       := iSevenSegmentInteger.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSevenSegmentInteger.UpdateFrameRate;

  ValueEdit.AsInteger                   := iSevenSegmentInteger.Value;

  BackGroundColorPicker.Color           := iSevenSegmentInteger.BackGroundColor;

  BorderStyleRadioGroup.AsInteger       := ord(iSevenSegmentInteger.BorderStyle);
  LeadingStyleRadioGroup.AsInteger      := ord(iSevenSegmentInteger.LeadingStyle);

  DigitCountEdit.AsInteger              := iSevenSegmentInteger.DigitCount;
  DigitSpacingEdit.AsInteger            := iSevenSegmentInteger.DigitSpacing;

  SegmentSizeEdit.AsInteger             := iSevenSegmentInteger.SegmentSize;
  SegmentSeperationEdit.AsInteger       := iSevenSegmentInteger.SegmentSeperation;
  SegmentMarginEdit.AsInteger           := iSevenSegmentInteger.SegmentMargin;
  SegmentColorPicker.Color              := iSevenSegmentInteger.SegmentColor;
  SegmentOffColorPicker.Color           := iSevenSegmentInteger.SegmentOffColor;

  UpLoadOPCProperties(iSevenSegmentInteger, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentIntegerComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSevenSegmentInteger : TiSevenSegmentInteger;
begin
  iSevenSegmentInteger := Component as TiSevenSegmentInteger;

  iSevenSegmentInteger.AutoSize            := AutoSizeCheckBox.AsBoolean;
  iSevenSegmentInteger.ShowOffSegments     := ShowOffSegmentsCheckBox.AsBoolean;
  iSevenSegmentInteger.AutoSegmentOffColor := AutoSegmentOffColorCheckBox.AsBoolean;
  iSevenSegmentInteger.ShowSign            := ShowSignCheckBox.AsBoolean;
  iSevenSegmentInteger.Transparent         := TransparentCheckBox.AsBoolean;
  iSevenSegmentInteger.AutoFrameRate       := AutoFrameRateCheckBox.AsBoolean;
  iSevenSegmentInteger.UpdateFrameRate     := UpdateFrameRateEdit.AsInteger;

  iSevenSegmentInteger.Value               := ValueEdit.AsInteger;

  iSevenSegmentInteger.BackGroundColor     := BackGroundColorPicker.Color;

  iSevenSegmentInteger.BorderStyle         := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSevenSegmentInteger.LeadingStyle        := TiLeadingStyle(LeadingStyleRadioGroup.AsInteger);

  iSevenSegmentInteger.DigitCount          := DigitCountEdit.AsInteger;
  iSevenSegmentInteger.DigitSpacing        := DigitSpacingEdit.AsInteger;

  iSevenSegmentInteger.SegmentSize         := SegmentSizeEdit.AsInteger;
  iSevenSegmentInteger.SegmentSeperation   := SegmentSeperationEdit.AsInteger;
  iSevenSegmentInteger.SegmentMargin       := SegmentMarginEdit.AsInteger;
  iSevenSegmentInteger.SegmentColor        := SegmentColorPicker.Color;
  iSevenSegmentInteger.SegmentOffColor     := SegmentOffColorPicker.Color;

  DownLoadOPCProperties(iSevenSegmentInteger, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
