{*******************************************************}
{                                                       }
{       TiSwitchToggleComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchToggleComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchToggleComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchToggle,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchToggle,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchToggleComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    ActiveCheckBox: TiComponentEditorCheckBox;
    DragToToggleCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
    SwitchGroupBox: TGroupBox;
    SwitchBevelStyleRadioGroup: TiComponentEditorRadioGroup;
    Label1: TLabel;
    SwitchHeightEdit: TiComponentEditorEdit;
    SwitchHeightUpDown: TiUpDown;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    MouseControlStyleRadioGroup: TiComponentEditorRadioGroup;
    SwitchOrientationRadioGroup: TiComponentEditorRadioGroup;
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
    Label32: TLabel;
    ColorPicker: TiComponentEditorColorPicker;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSwitchToggleComponentEditorForm: TiSwitchToggleComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchToggleComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchToggle.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchToggleComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchToggle : TiSwitchToggle;
begin
  iSwitchToggle := Component as TiSwitchToggle;

  ActiveCheckBox.AsBoolean               := iSwitchToggle.Active;
  ShowFocusRectCheckBox.AsBoolean        := iSwitchToggle.ShowFocusRect;
  EnabledCheckBox.AsBoolean              := iSwitchToggle.Enabled;
  DragToToggleCheckBox.AsBoolean         := iSwitchToggle.DragToToggle;
  MouseControlStyleRadioGroup.AsInteger  := ord(iSwitchToggle.MouseControlStyle);
  AutoFrameRateCheckBox.AsBoolean        := iSwitchToggle.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger          := iSwitchToggle.UpdateFrameRate;
  ColorPicker.Color                      := iSwitchToggle.Color;

  SwitchBevelStyleRadioGroup.AsInteger   := ord(iSwitchToggle.SwitchBevelStyle);
  SwitchOrientationRadioGroup.AsInteger  := ord(iSwitchToggle.SwitchOrientation);
  SwitchHeightEdit.AsInteger             := iSwitchToggle.SwitchHeight;

  UpLoadOPCProperties(iSwitchToggle, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSwitchToggleComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchToggle : TiSwitchToggle;
begin
  iSwitchToggle := Component as TiSwitchToggle;

  iSwitchToggle.Active             := ActiveCheckBox.AsBoolean;
  iSwitchToggle.ShowFocusRect      := ShowFocusRectCheckBox.AsBoolean;
  iSwitchToggle.Enabled            := EnabledCheckBox.AsBoolean;
  iSwitchToggle.DragToToggle       := DragToToggleCheckBox.AsBoolean;
  iSwitchToggle.MouseControlStyle  := TiMouseControlStyle(MouseControlStyleRadioGroup.AsInteger);
  iSwitchToggle.AutoFrameRate      := AutoFrameRateCheckBox.AsBoolean;
  iSwitchToggle.UpdateFrameRate    := UpdateFrameRateEdit.AsInteger;
  iSwitchToggle.Color              := ColorPicker.Color;

  iSwitchToggle.SwitchBevelStyle   := TiBevelStyle(SwitchBevelStyleRadioGroup.AsInteger);
  iSwitchToggle.SwitchOrientation  := TiOrientation(SwitchOrientationRadioGroup.AsInteger);
  iSwitchToggle.SwitchHeight       := SwitchHeightEdit.AsInteger;

  DownLoadOPCProperties(iSwitchToggle, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
