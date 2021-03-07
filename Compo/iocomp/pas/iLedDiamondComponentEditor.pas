{*******************************************************}
{                                                       }
{       TiLedDiamondComponentEditor                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedDiamondComponentEditor;{$endif}
{$ifdef iCLX}unit QiLedDiamondComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLedDiamond,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLedDiamond,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLedDiamondComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    ActiveCheckBox: TiComponentEditorCheckBox;
    BevelStyleRadioGroup: TiComponentEditorRadioGroup;
    ActiveColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    InactiveColorPicker: TiComponentEditorColorPicker;
    Label1: TLabel;
    AutoInactiveColorCheckBox: TiComponentEditorCheckBox;
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
  iLedDiamondComponentEditorForm: TiLedDiamondComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLedDiamondComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLedDiamond.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLedDiamondComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLedDiamond : TiLedDiamond;
begin
  iLedDiamond := Component as TiLedDiamond;

  ActiveCheckBox.AsBoolean            := iLedDiamond.Active;
  AutoInactiveColorCheckBox.AsBoolean := iLedDiamond.AutoInactiveColor;
  TransparentCheckBox.AsBoolean       := iLedDiamond.Transparent;
  AutoFrameRateCheckBox.AsBoolean     := iLedDiamond.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger       := iLedDiamond.UpdateFrameRate;

  ActiveColorPicker.Color             := iLedDiamond.ActiveColor;
  InactiveColorPicker.Color           := iLedDiamond.InactiveColor;
  BackGroundColorPicker.Color         := iLedDiamond.BackGroundColor;

  BevelStyleRadioGroup.AsInteger      := ord(iLedDiamond.BevelStyle);

  UpLoadOPCProperties(iLedDiamond, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiLedDiamondComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLedDiamond : TiLedDiamond;
begin
  iLedDiamond := Component as TiLedDiamond;

  iLedDiamond.Active            := ActiveCheckBox.AsBoolean;
  iLedDiamond.AutoInactiveColor := AutoInactiveColorCheckBox.AsBoolean;
  iLedDiamond.Transparent       := TransparentCheckBox.AsBoolean;
  iLedDiamond.AutoFrameRate     := AutoFrameRateCheckBox.AsBoolean;
  iLedDiamond.UpdateFrameRate   := UpdateFrameRateEdit.AsInteger;

  iLedDiamond.ActiveColor       := ActiveColorPicker.Color;
  iLedDiamond.InactiveColor     := InactiveColorPicker.Color;
  iLedDiamond.BackGroundColor   := BackGroundColorPicker.Color;

  iLedDiamond.BevelStyle        := TiBevelStyle(BevelStyleRadioGroup.AsInteger);

  DownLoadOPCProperties(iLedDiamond, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
