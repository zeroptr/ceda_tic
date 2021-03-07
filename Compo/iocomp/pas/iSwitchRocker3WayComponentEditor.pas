{*******************************************************}
{                                                       }
{       TiSwitchRocker3WayComponentEditor               }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchRocker3WayComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchRocker3WayComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchRocker3Way,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchRocker3Way,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchRocker3WayComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    EnabledCheckBox: TiComponentEditorCheckBox;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    Label5: TLabel;
    BorderMarginEdit: TiComponentEditorEdit;
    BorderMarginUpDown: TiUpDown;
    RepeatGroupBox: TGroupBox;
    Label2: TLabel;
    Label6: TLabel;
    RepeatInitialDelayEdit: TiComponentEditorEdit;
    RepeatInitialDelayUpDown: TiUpDown;
    RepeatIntervalEdit: TiComponentEditorEdit;
    RepeatIntervalUpDown: TiUpDown;
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
    Label3: TLabel;
    IncrementEdit: TiComponentEditorEdit;
    Label12: TLabel;
    ValueEdit: TiComponentEditorEdit;
    UseArrowKeysCheckBox: TiComponentEditorCheckBox;
    Label32: TLabel;
    ColorPicker: TiComponentEditorColorPicker;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSwitchRocker3WayComponentEditorForm: TiSwitchRocker3WayComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchRocker3WayComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchRocker3Way.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3WayComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchRocker3Way : TiSwitchRocker3Way;
begin
  iSwitchRocker3Way := Component as TiSwitchRocker3Way;

  ValueEdit.AsFloat                  := iSwitchRocker3Way.Value;
  IncrementEdit.AsFloat              := iSwitchRocker3Way.Increment;
  ColorPicker.Color                  := iSwitchRocker3Way.Color;

  EnabledCheckBox.AsBoolean          := iSwitchRocker3Way.Enabled;
  UseArrowKeysCheckBox.AsBoolean     := iSwitchRocker3Way.UseArrowKeys;
  ShowFocusRectCheckBox.AsBoolean    := iSwitchRocker3Way.ShowFocusRect;
  TransparentCheckBox.AsBoolean      := iSwitchRocker3Way.Transparent;

  BorderMarginEdit.AsInteger         := iSwitchRocker3Way.BorderMargin;
  BackGroundColorPicker.Color        := iSwitchRocker3Way.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean    := iSwitchRocker3Way.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger      := iSwitchRocker3Way.UpdateFrameRate;

  RepeatInitialDelayEdit.AsInteger   := iSwitchRocker3Way.RepeatInitialDelay;
  RepeatIntervalEdit.AsInteger       := iSwitchRocker3Way.RepeatInterval;

  UpLoadOPCProperties(iSwitchRocker3Way, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSwitchRocker3WayComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchRocker3Way : TiSwitchRocker3Way;
begin
  iSwitchRocker3Way := Component as TiSwitchRocker3Way;

  iSwitchRocker3Way.Value              := ValueEdit.AsFloat;
  iSwitchRocker3Way.Increment          := IncrementEdit.AsFloat;
  iSwitchRocker3Way.Color              := ColorPicker.Color;

  iSwitchRocker3Way.Enabled            := EnabledCheckBox.AsBoolean;
  iSwitchRocker3Way.UseArrowKeys       := UseArrowKeysCheckBox.AsBoolean;
  iSwitchRocker3Way.ShowFocusRect      := ShowFocusRectCheckBox.AsBoolean;
  iSwitchRocker3Way.Transparent        := TransparentCheckBox.AsBoolean;

  iSwitchRocker3Way.BorderMargin       := BorderMarginEdit.AsInteger;
  iSwitchRocker3Way.BackGroundColor    := BackGroundColorPicker.Color;
  iSwitchRocker3Way.AutoFrameRate      := AutoFrameRateCheckBox.AsBoolean;
  iSwitchRocker3Way.UpdateFrameRate    := UpdateFrameRateEdit.AsInteger;

  iSwitchRocker3Way.RepeatInitialDelay := RepeatInitialDelayEdit.AsInteger;
  iSwitchRocker3Way.RepeatInterval     := RepeatIntervalEdit.AsInteger;

  DownLoadOPCProperties(iSwitchRocker3Way, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
