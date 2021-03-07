{*******************************************************}
{                                                       }
{       TiLedRectangleComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedRectangleComponentEditor;{$endif}
{$ifdef iCLX}unit QiLedRectangleComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLedRectangle,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLedRectangle,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLedRectangleComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    ActiveCheckBox: TiComponentEditorCheckBox;
    BevelStyleRadioGroup: TiComponentEditorRadioGroup;
    ActiveColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    CenterLabelGroupBox: TGroupBox;
    Label40: TLabel;
    CenterLabelTextEdit: TiComponentEditorEdit;
    CenterLabelFontPicker: TiComponentEditorFontPicker;
    CenterLabelFontInactiveColorPicker: TiComponentEditorColorPicker;
    Label37: TLabel;
    CenterLabelFontActiveColorPicker: TiComponentEditorColorPicker;
    Label1: TLabel;
    ShowReflectionCheckBox: TiComponentEditorCheckBox;
    InactiveColorPicker: TiComponentEditorColorPicker;
    Label2: TLabel;
    AutoInactiveColorCheckBox: TiComponentEditorCheckBox;
    CenterLabelWordWrapCheckBox: TiComponentEditorCheckBox;
    Label4: TLabel;
    CenterLabelEndsMarginEdit: TiComponentEditorEdit;
    CenterLabelEndsMarginUpDown: TiUpDown;
    CenterLabelAlignmentRadioGroup: TiComponentEditorRadioGroup;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iLedRectangleComponentEditorForm: TiLedRectangleComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLedRectangleComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLedRectangle.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLedRectangleComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLedRectangle : TiLedRectangle;
begin
  iLedRectangle := Component as TiLedRectangle;

  ActiveCheckBox.AsBoolean                 := iLedRectangle.Active;
  ActiveColorPicker.Color                  := iLedRectangle.ActiveColor;
  InactiveColorPicker.Color                := iLedRectangle.InactiveColor;
  BevelStyleRadioGroup.AsInteger           := ord(iLedRectangle.BevelStyle);
  ShowReflectionCheckBox.AsBoolean         := iLedRectangle.ShowReflection;
  AutoInactiveColorCheckBox.AsBoolean      := iLedRectangle.AutoInactiveColor;
  CenterLabelAlignmentRadioGroup.AsInteger := ord(iLedRectangle.CenterLabelAlignment);
  AutoFrameRateCheckBox.AsBoolean          := iLedRectangle.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger            := iLedRectangle.UpdateFrameRate;

  CenterLabelTextEdit.AsString             := iLedRectangle.CenterLabelText;
  CenterLabelFontActiveColorPicker.Color   := iLedRectangle.CenterLabelFontActiveColor;
  CenterLabelFontInactiveColorPicker.Color := iLedRectangle.CenterLabelFontInactiveColor;
  CenterLabelWordWrapCheckBox.AsBoolean    := iLedRectangle.CenterLabelWordWrap;
  CenterLabelEndsMarginEdit.AsInteger      := iLedRectangle.CenterLabelEndsMargin;

  UpLoadOPCProperties(iLedRectangle, iOPCBrowserPanel);

  CenterLabelFontPicker.Font.Assign(iLedRectangle.CenterLabelFont);
end;
//****************************************************************************************************************************************************
procedure TiLedRectangleComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLedRectangle : TiLedRectangle;
begin
  iLedRectangle := Component as TiLedRectangle;

  iLedRectangle.Active                       := ActiveCheckBox.AsBoolean;
  iLedRectangle.ActiveColor                  := ActiveColorPicker.Color;
  iLedRectangle.InactiveColor                := InactiveColorPicker.Color;
  iLedRectangle.BevelStyle                   := TiBevelStyle(BevelStyleRadioGroup.AsInteger);
  iLedRectangle.ShowReflection               := ShowReflectionCheckBox.AsBoolean;
  iLedRectangle.AutoInactiveColor            := AutoInactiveColorCheckBox.AsBoolean;
  iLedRectangle.CenterLabelAlignment         := TiAlignmentHorizontal(CenterLabelAlignmentRadioGroup.AsInteger);
  iLedRectangle.AutoFrameRate                := AutoFrameRateCheckBox.AsBoolean;
  iLedRectangle.UpdateFrameRate              := UpdateFrameRateEdit.AsInteger;

  iLedRectangle.CenterLabelText              := CenterLabelTextEdit.AsString;
  iLedRectangle.CenterLabelFontActiveColor   := CenterLabelFontActiveColorPicker.Color;
  iLedRectangle.CenterLabelFontInactiveColor := CenterLabelFontInactiveColorPicker.Color;
  iLedRectangle.CenterLabelWordWrap          := CenterLabelWordWrapCheckBox.AsBoolean;
  iLedRectangle.CenterLabelEndsMargin        := CenterLabelEndsMarginEdit.AsInteger;

  DownLoadOPCProperties(iLedRectangle, iOPCBrowserPanel);

  iLedRectangle.CenterLabelFont.Assign(CenterLabelFontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
