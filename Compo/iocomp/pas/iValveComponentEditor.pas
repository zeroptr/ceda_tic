{*******************************************************}
{                                                       }
{       TiValveComponentEditor                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iValveComponentEditor;{$endif}
{$ifdef iCLX}unit QiValveComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iValve,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiValve,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiValveComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label3: TLabel;
    OpenedColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    ClosedColorPicker: TiComponentEditorColorPicker;
    OpenedCheckBox: TiComponentEditorCheckBox;
    ChangeBodyColorCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
    OrientationRadioGroup: TiComponentEditorRadioGroup;
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
  iValveComponentEditorForm: TiValveComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiValveComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiValve.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiValveComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iValve : TiValve;
begin
  iValve := Component as TiValve;

  OpenedCheckBox.AsBoolean          := iValve.Opened;
  ChangeBodyColorCheckBox.AsBoolean := iValve.ChangeBodyColor;
  EnabledCheckBox.AsBoolean         := iValve.Enabled;
  OrientationRadioGroup.AsInteger   := ord(iValve.Orientation);

  OpenedColorPicker.Color           := iValve.OpenedColor;
  ClosedColorPicker.Color           := iValve.ClosedColor;
  BackGroundColorPicker.Color       := iValve.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean   := iValve.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger     := iValve.UpdateFrameRate;

  UpLoadOPCProperties(iValve, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiValveComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iValve : TiValve;
begin
  iValve := Component as TiValve;

  iValve.Opened          := OpenedCheckBox.AsBoolean;
  iValve.ChangeBodyColor := ChangeBodyColorCheckBox.AsBoolean;
  iValve.Enabled         := EnabledCheckBox.AsBoolean;
  iValve.Orientation     := TiOrientation(OrientationRadioGroup.AsInteger);

  iValve.OpenedColor     := OpenedColorPicker.Color;
  iValve.ClosedColor     := ClosedColorPicker.Color;
  iValve.BackGroundColor := BackGroundColorPicker.Color;
  iValve.AutoFrameRate   := AutoFrameRateCheckBox.AsBoolean;
  iValve.UpdateFrameRate := UpdateFrameRateEdit.AsInteger;

  DownLoadOPCProperties(iValve, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
