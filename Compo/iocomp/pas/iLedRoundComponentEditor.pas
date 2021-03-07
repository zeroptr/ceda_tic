{*******************************************************}
{                                                       }
{       TiLedRoundComponentEditor                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedRoundComponentEditor;{$endif}
{$ifdef iCLX}unit QiLedRoundComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLedRound,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLedRound,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLedRoundComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    ActiveCheckBox: TiComponentEditorCheckBox;
    BevelStyleRadioGroup: TiComponentEditorRadioGroup;
    ActiveColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    ShowReflectionCheckBox: TiComponentEditorCheckBox;
    AutoInactiveColorCheckBox: TiComponentEditorCheckBox;
    InactiveColorPicker: TiComponentEditorColorPicker;
    Label1: TLabel;
    TransparentCheckBox: TiComponentEditorCheckBox;
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
  iLedRoundComponentEditorForm: TiLedRoundComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLedRoundComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLedRound.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLedRoundComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLedRound : TiLedRound;
begin
  iLedRound := Component as TiLedRound;

  ActiveCheckBox.AsBoolean            := iLedRound.Active;
  ShowReflectionCheckBox.AsBoolean    := iLedRound.ShowReflection;
  AutoInactiveColorCheckBox.AsBoolean := iLedRound.AutoInactiveColor;
  TransparentCheckBox.AsBoolean       := iLedRound.Transparent;
  AutoFrameRateCheckBox.AsBoolean     := iLedRound.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger       := iLedRound.UpdateFrameRate;

  ActiveColorPicker.Color             := iLedRound.ActiveColor;
  InactiveColorPicker.Color           := iLedRound.InactiveColor;
  BackGroundColorPicker.Color         := iLedRound.BackGroundColor;

  BevelStyleRadioGroup.AsInteger      := ord(iLedRound.BevelStyle);

  UpLoadOPCProperties(iLedRound, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiLedRoundComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLedRound : TiLedRound;
begin
  iLedRound := Component as TiLedRound;

  iLedRound.Active            := ActiveCheckBox.AsBoolean;
  iLedRound.ShowReflection    := ShowReflectionCheckBox.AsBoolean;
  iLedRound.AutoInactiveColor := AutoInactiveColorCheckBox.AsBoolean;
  iLedRound.Transparent       := TransparentCheckBox.AsBoolean;
  iLedRound.AutoFrameRate     := AutoFrameRateCheckBox.AsBoolean;
  iLedRound.UpdateFrameRate   := UpdateFrameRateEdit.AsInteger;

  iLedRound.ActiveColor       := ActiveColorPicker.Color;
  iLedRound.InactiveColor     := InactiveColorPicker.Color;
  iLedRound.BackGroundColor   := BackGroundColorPicker.Color;

  iLedRound.BevelStyle        := TiBevelStyle(BevelStyleRadioGroup.AsInteger);

  DownLoadOPCProperties(iLedRound, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
