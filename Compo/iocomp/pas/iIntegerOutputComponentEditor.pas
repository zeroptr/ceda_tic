{*******************************************************}
{                                                       }
{       TiIntegerOutputComponentEditor                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iIntegerOutputComponentEditor;{$endif}
{$ifdef iCLX}unit QiIntegerOutputComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iIntegerOutput,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiIntegerOutput,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiIntegerOutputComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label8: TLabel;
    ValueEdit: TiComponentEditorEdit;
    FontPicker: TiComponentEditorFontPicker;
    ColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    AlignmentRadioGroup: TiComponentEditorRadioGroup;
    Label5: TLabel;
    MaxLengthEdit: TiComponentEditorEdit;
    MaxLengthUpDown: TiUpDown;
    FormatStyleRadioGroup: TiComponentEditorRadioGroup;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    EnabledCheckBox: TiComponentEditorCheckBox;
    BeepOnErrorCheckBox: TiComponentEditorCheckBox;
    UndoOnErrorCheckBox: TiComponentEditorCheckBox;
    AutoSelectCheckBox: TiComponentEditorCheckBox;
    LeadingZerosCheckBox: TiComponentEditorCheckBox;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    Label1: TLabel;
    AlignmentMarginUpDown: TiUpDown;
    AlignmentMarginEdit: TiComponentEditorEdit;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iIntegerOutputComponentEditorForm: TiIntegerOutputComponentEditorForm;

implementation
{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiIntegerOutputComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiIntegerOutput.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutputComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iIntegerOutput : TiIntegerOutput;
begin
  iIntegerOutput := Component as TiIntegerOutput;

  ValueEdit.AsInteger             := iIntegerOutput.Value;
  MaxLengthEdit.AsInteger         := iIntegerOutput.MaxLength;

  FormatStyleRadioGroup.AsInteger := ord(iIntegerOutput.FormatStyle);
  EnabledCheckBox.AsBoolean       := iIntegerOutput.Enabled;
  LeadingZerosCheckBox.AsBoolean  := iIntegerOutput.LeadingZeros;
  BeepOnErrorCheckBox.AsBoolean   := iIntegerOutput.BeepOnError;
  UndoOnErrorCheckBox.AsBoolean   := iIntegerOutput.UndoOnError;
  AutoSelectCheckBox.AsBoolean    := iIntegerOutput.AutoSelect;
  AutoSizeCheckBox.AsBoolean      := iIntegerOutput.AutoSize;

  AlignmentMarginEdit.AsInteger   := iIntegerOutput.AlignmentMargin;
  AlignmentRadioGroup.AsInteger   := ord(iIntegerOutput.Alignment);
  ColorPicker.Color               := iIntegerOutput.Color;

  UpLoadOPCProperties(iIntegerOutput, iOPCBrowserPanel);

  FontPicker.Font.Assign(iIntegerOutput.Font);
end;
//****************************************************************************************************************************************************
procedure TiIntegerOutputComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iIntegerOutput : TiIntegerOutput;
begin
  iIntegerOutput := Component as TiIntegerOutput;

  iIntegerOutput.FormatStyle     := TiIntegerFormatStyle(FormatStyleRadioGroup.AsInteger);
  iIntegerOutput.Value           := ValueEdit.AsInteger;
  iIntegerOutput.MaxLength       := MaxLengthEdit.AsInteger;

  iIntegerOutput.Enabled         := EnabledCheckBox.AsBoolean;                              
  iIntegerOutput.LeadingZeros    := LeadingZerosCheckBox.AsBoolean;
  iIntegerOutput.BeepOnError     := BeepOnErrorCheckBox.AsBoolean;
  iIntegerOutput.UndoOnError     := UndoOnErrorCheckBox.AsBoolean;
  iIntegerOutput.AutoSelect      := AutoSelectCheckBox.AsBoolean;
  iIntegerOutput.AutoSize        := AutoSizeCheckBox.AsBoolean;

  iIntegerOutput.AlignmentMargin := AlignmentMarginEdit.AsInteger;
  iIntegerOutput.Alignment       := TAlignment(AlignmentRadioGroup.AsInteger);
  iIntegerOutput.Color           := ColorPicker.Color;

  DownLoadOPCProperties(iIntegerOutput, iOPCBrowserPanel);

  iIntegerOutput.Font.Assign(FontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
