{*******************************************************}
{                                                       }
{       TiEditComponentEditor                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iEditComponentEditor;{$endif}
{$ifdef iCLX}unit QiEditComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iEdit,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiEdit,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiEditComponentEditorForm = class(TiComponentEditorForm)
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
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    EnabledCheckBox: TiComponentEditorCheckBox;
    AutoSelectCheckBox: TiComponentEditorCheckBox;
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
  iEditComponentEditorForm: TiEditComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiEditComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiEdit.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiEditComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iEdit : TiEdit;
begin
  iEdit := Component as TiEdit;

  ValueEdit.AsString              := iEdit.Value;
  EnabledCheckBox.AsBoolean       := iEdit.Enabled;
  AutoSelectCheckBox.AsBoolean    := iEdit.AutoSelect;
  MaxLengthEdit.AsInteger         := iEdit.MaxLength;
  ColorPicker.Color               := iEdit.Color;
  AlignmentRadioGroup.AsInteger   := ord(iEdit.Alignment);
  AlignmentMarginEdit.AsInteger   := iEdit.AlignmentMargin;
  AutoSizeCheckBox.AsBoolean      := iEdit.AutoSize;

  UpLoadOPCProperties(iEdit, iOPCBrowserPanel);

  FontPicker.Font.Assign(iEdit.Font);
end;
//****************************************************************************************************************************************************
procedure TiEditComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iEdit : TiEdit;
begin
  iEdit := Component as TiEdit;

  iEdit.Value           := ValueEdit.AsString;

  iEdit.Enabled         := EnabledCheckBox.AsBoolean;
  iEdit.AutoSelect      := AutoSelectCheckBox.AsBoolean;
  iEdit.MaxLength       := MaxLengthEdit.AsInteger;
  iEdit.Color           := ColorPicker.Color;
  iEdit.Alignment       := TAlignment(AlignmentRadioGroup.AsInteger);
  iEdit.AlignmentMargin := AlignmentMarginEdit.AsInteger;
  iEdit.AutoSize        := AutoSizeCheckBox.AsBoolean;

  DownLoadOPCProperties(iEdit, iOPCBrowserPanel);

  iEdit.Font.Assign(FontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
