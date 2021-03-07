{*******************************************************}
{                                                       }
{       TiAnalogDisplayComponentEditor                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iAnalogDisplayComponentEditor;{$endif}
{$ifdef iCLX}unit QiAnalogDisplayComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iAnalogDisplay,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiAnalogDisplay,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiAnalogDisplayComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label6: TLabel;
    PrecisionEdit: TiComponentEditorEdit;
    PrecisionUpDown: TiUpDown;
    Label8: TLabel;
    ValueEdit: TiComponentEditorEdit;
    FontPicker: TiComponentEditorFontPicker;
    AlignmentGroupBox: TGroupBox;
    AlignmentRadioGroup: TiComponentEditorRadioGroup;
    Label5: TLabel;
    AlignmentMarginEdit: TiComponentEditorEdit;
    AlignmentMarginUpDown: TiUpDown;
    Label2: TLabel;
    UnitsTextEdit: TiComponentEditorEdit;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
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
  iAnalogDisplayComponentEditorForm: TiAnalogDisplayComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiAnalogDisplayComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiAnalogDisplay.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplayComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iAnalogDisplay : TiAnalogDisplay;
begin
  iAnalogDisplay := Component as TiAnalogDisplay;

  ValueEdit.AsFloat               := iAnalogDisplay.Value;
  PrecisionEdit.AsInteger         := iAnalogDisplay.Precision;
  BorderStyleRadioGroup.AsInteger := ord(iAnalogDisplay.BorderStyle);
  BackGroundColorPicker.Color     := iAnalogDisplay.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean := iAnalogDisplay.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger   := iAnalogDisplay.UpdateFrameRate;

  UnitsTextEdit.AsString          := iAnalogDisplay.UnitsText;

  AlignmentRadioGroup.AsInteger   := ord(iAnalogDisplay.Alignment);
  AlignmentMarginEdit.AsInteger   := iAnalogDisplay.AlignmentMargin;

  UpLoadOPCProperties(iAnalogDisplay, iOPCBrowserPanel);

  FontPicker.Font.Assign(iAnalogDisplay.Font);
end;
//****************************************************************************************************************************************************
procedure TiAnalogDisplayComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iAnalogDisplay : TiAnalogDisplay;
begin
  iAnalogDisplay := Component as TiAnalogDisplay;

  iAnalogDisplay.Value           := ValueEdit.AsFloat;
  iAnalogDisplay.Precision       := PrecisionEdit.AsInteger;
  iAnalogDisplay.BorderStyle     := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iAnalogDisplay.BackGroundColor := BackGroundColorPicker.Color;
  iAnalogDisplay.AutoFrameRate   := AutoFrameRateCheckBox.AsBoolean;
  iAnalogDisplay.UpdateFrameRate := UpdateFrameRateEdit.AsInteger;

  iAnalogDisplay.UnitsText       := UnitsTextEdit.AsString;

  iAnalogDisplay.Alignment       := TiAlignmentHorizontal(AlignmentRadioGroup.AsInteger);
  iAnalogDisplay.AlignmentMargin := AlignmentMarginEdit.AsInteger;

  DownLoadOPCProperties(iAnalogDisplay, iOPCBrowserPanel);

  iAnalogDisplay.Font.Assign(FontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
