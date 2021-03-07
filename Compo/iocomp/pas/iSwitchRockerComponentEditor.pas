{*******************************************************}
{                                                       }
{       TiSwitchRockerComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchRockerComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchRockerComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchRocker,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchRocker,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchRockerComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    ActiveCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
    IndicatorGroupBox: TGroupBox;
    Label4: TLabel;
    IndicatorMarginEdit: TiComponentEditorEdit;
    IndicatorMarginUpDown: TiUpDown;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    Label5: TLabel;
    BorderMarginEdit: TiComponentEditorEdit;
    BorderMarginUpDown: TiUpDown;
    IndicatorActiveColorPicker: TiComponentEditorColorPicker;
    Label3: TLabel;
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
  iSwitchRockerComponentEditorForm: TiSwitchRockerComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchRockerComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchRocker.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRockerComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchRocker : TiSwitchRocker;
begin
  iSwitchRocker := Component as TiSwitchRocker;

  ActiveCheckBox.AsBoolean              := iSwitchRocker.Active;
  EnabledCheckBox.AsBoolean             := iSwitchRocker.Enabled;
  ShowFocusRectCheckBox.AsBoolean       := iSwitchRocker.ShowFocusRect;
  TransparentCheckBox.AsBoolean         := iSwitchRocker.Transparent;
  ColorPicker.Color                     := iSwitchRocker.Color;

  BorderMarginEdit.AsInteger            := iSwitchRocker.BorderMargin;
  BackGroundColorPicker.Color           := iSwitchRocker.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean       := iSwitchRocker.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSwitchRocker.UpdateFrameRate;

  MouseControlStyleRadioGroup.AsInteger := ord(iSwitchRocker.MouseControlStyle);

  IndicatorMarginEdit.AsInteger         := iSwitchRocker.IndicatorMargin;
  IndicatorActiveColorPicker.Color      := iSwitchRocker.IndicatorActiveColor;

  UpLoadOPCProperties(iSwitchRocker, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRockerComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchRocker : TiSwitchRocker;
begin
  iSwitchRocker := Component as TiSwitchRocker;

  iSwitchRocker.Active               := ActiveCheckBox.AsBoolean;
  iSwitchRocker.Enabled              := EnabledCheckBox.AsBoolean;
  iSwitchRocker.ShowFocusRect        := ShowFocusRectCheckBox.AsBoolean;
  iSwitchRocker.Transparent          := TransparentCheckBox.AsBoolean;
  iSwitchRocker.Color                := ColorPicker.Color;

  iSwitchRocker.BorderMargin         := BorderMarginEdit.AsInteger;
  iSwitchRocker.BackGroundColor      := BackGroundColorPicker.Color;
  iSwitchRocker.AutoFrameRate        := AutoFrameRateCheckBox.AsBoolean;
  iSwitchRocker.UpdateFrameRate      := UpdateFrameRateEdit.AsInteger;

  iSwitchRocker.MouseControlStyle    := TiMouseControlStyle(MouseControlStyleRadioGroup.AsInteger);

  iSwitchRocker.IndicatorMargin      := IndicatorMarginEdit.AsInteger;
  iSwitchRocker.IndicatorActiveColor := IndicatorActiveColorPicker.Color;

  DownLoadOPCProperties(iSwitchRocker, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
