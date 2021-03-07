{*******************************************************}
{                                                       }
{       TiSwitchLeverComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchLeverComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchLeverComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchLever,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchLever,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchLeverComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    ActiveCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    MouseControlStyleRadioGroup: TiComponentEditorRadioGroup;
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
    Label32: TLabel;
    ColorPicker: TiComponentEditorColorPicker;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSwitchLeverComponentEditorForm: TiSwitchLeverComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchLeverComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchLever.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchLeverComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchLever : TiSwitchLever;
begin
  iSwitchLever := Component as TiSwitchLever;

  ActiveCheckBox.AsBoolean              := iSwitchLever.Active;
  EnabledCheckBox.AsBoolean             := iSwitchLever.Enabled;
  ShowFocusRectCheckBox.AsBoolean       := iSwitchLever.ShowFocusRect;
  TransparentCheckBox.AsBoolean         := iSwitchLever.Transparent;
  BackGroundColorPicker.Color           := iSwitchLever.BackGroundColor;
  MouseControlStyleRadioGroup.AsInteger := ord(iSwitchLever.MouseControlStyle);
  AutoFrameRateCheckBox.AsBoolean       := iSwitchLever.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSwitchLever.UpdateFrameRate;
  ColorPicker.Color                     := iSwitchLever.Color;

  UpLoadOPCProperties(iSwitchLever, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSwitchLeverComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchLever : TiSwitchLever;
begin
  iSwitchLever := Component as TiSwitchLever;

  iSwitchLever.Active            := ActiveCheckBox.AsBoolean;
  iSwitchLever.Enabled           := EnabledCheckBox.AsBoolean;
  iSwitchLever.ShowFocusRect     := ShowFocusRectCheckBox.AsBoolean;
  iSwitchLever.Transparent       := TransparentCheckBox.AsBoolean;
  iSwitchLever.BackGroundColor   := BackGroundColorPicker.Color;
  iSwitchLever.MouseControlStyle := TiMouseControlStyle(MouseControlStyleRadioGroup.AsInteger);
  iSwitchLever.AutoFrameRate     := AutoFrameRateCheckBox.AsBoolean;
  iSwitchLever.UpdateFrameRate   := UpdateFrameRateEdit.AsInteger;
  iSwitchLever.Color             := ColorPicker.Color;

  DownLoadOPCProperties(iSwitchLever, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
