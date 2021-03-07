{*******************************************************}
{                                                       }
{       TiAnalogOutputComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iAnalogOutputComponentEditor;{$endif}
{$ifdef iCLX}unit QiAnalogOutputComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iAnalogOutput,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiAnalogOutput,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiAnalogOutputComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label6: TLabel;
    PrecisionEdit: TiComponentEditorEdit;
    PrecisionUpDown: TiUpDown;
    Label8: TLabel;
    ValueEdit: TiComponentEditorEdit;
    FontPicker: TiComponentEditorFontPicker;
    ColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    AlignmentRadioGroup: TiComponentEditorRadioGroup;
    Label3: TLabel;
    ValueMaxEdit: TiComponentEditorEdit;
    Label4: TLabel;
    ValueMinEdit: TiComponentEditorEdit;
    Label5: TLabel;
    MaxLengthEdit: TiComponentEditorEdit;
    MaxLengthUpDown: TiUpDown;
    Label2: TLabel;
    UnitsTextEdit: TiComponentEditorEdit;
    FilterStyleRadioGroup: TiComponentEditorRadioGroup;
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
    Label1: TLabel;
    AlignmentMarginUpDown: TiUpDown;
    AlignmentMarginEdit: TiComponentEditorEdit;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iAnalogOutputComponentEditorForm: TiAnalogOutputComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiAnalogOutputComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiAnalogOutput.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutputComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iAnalogOutput : TiAnalogOutput;
begin
  iAnalogOutput := Component as TiAnalogOutput;

  ValueMaxEdit.AsFloat            := iAnalogOutput.ValueMax;
  ValueMinEdit.AsFloat            := iAnalogOutput.ValueMin;
  ValueEdit.AsFloat               := iAnalogOutput.Value;
  UnitsTextEdit.AsString          := iAnalogOutput.UnitsText;

  EnabledCheckBox.AsBoolean       := iAnalogOutput.Enabled;
  BeepOnErrorCheckBox.AsBoolean   := iAnalogOutput.BeepOnError;
  UndoOnErrorCheckBox.AsBoolean   := iAnalogOutput.UndoOnError;
  AutoSelectCheckBox.AsBoolean    := iAnalogOutput.AutoSelect;

  PrecisionEdit.AsInteger         := iAnalogOutput.Precision;
  MaxLengthEdit.AsInteger         := iAnalogOutput.MaxLength;
  ColorPicker.Color               := iAnalogOutput.Color;

  AlignmentRadioGroup.AsInteger   := ord(iAnalogOutput.Alignment);
  AlignmentMarginEdit.AsInteger   := iAnalogOutput.AlignmentMargin;
  FilterStyleRadioGroup.AsInteger := ord(iAnalogOutput.FilterStyle);

  UpLoadOPCProperties(iAnalogOutput, iOPCBrowserPanel);

  FontPicker.Font.Assign(iAnalogOutput.Font);
end;
//****************************************************************************************************************************************************
procedure TiAnalogOutputComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iAnalogOutput : TiAnalogOutput;
begin
  iAnalogOutput                 := Component as TiAnalogOutput;

  iAnalogOutput.Value           := ValueEdit.AsFloat;
  iAnalogOutput.ValueMax        := ValueMaxEdit.AsFloat;
  iAnalogOutput.ValueMin        := ValueMinEdit.AsFloat;
  iAnalogOutput.UnitsText       := UnitsTextEdit.AsString;

  iAnalogOutput.Enabled         := EnabledCheckBox.AsBoolean;
  iAnalogOutput.BeepOnError     := BeepOnErrorCheckBox.AsBoolean;
  iAnalogOutput.UndoOnError     := UndoOnErrorCheckBox.AsBoolean;
  iAnalogOutput.AutoSelect      := AutoSelectCheckBox.AsBoolean;

  iAnalogOutput.Precision       := PrecisionEdit.AsInteger;
  iAnalogOutput.MaxLength       := MaxLengthEdit.AsInteger;
  iAnalogOutput.Color           := ColorPicker.Color;

  iAnalogOutput.Alignment       := TAlignment(AlignmentRadioGroup.AsInteger);
  iAnalogOutput.AlignmentMargin := AlignmentMarginEdit.AsInteger;
  iAnalogOutput.FilterStyle     := TiFilterInputStyle(FilterStyleRadioGroup.AsInteger);

  DownLoadOPCProperties(iAnalogOutput, iOPCBrowserPanel);

  iAnalogOutput.Font.Assign(FontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
