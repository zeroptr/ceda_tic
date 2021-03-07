{*******************************************************}
{                                                       }
{       TiSwitchQuadComponentEditor                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchQuadComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchQuadComponentEditor;{$endif}

interface

uses                                                            
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchQuad,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchQuad,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchQuadComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    RepeatGroupBox: TGroupBox;
    Label1: TLabel;
    RepeatInitialDelayEdit: TiComponentEditorEdit;
    RepeatInitialDelayUpDown: TiUpDown;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    Label12: TLabel;
    ValueXEdit: TiComponentEditorEdit;
    Label2: TLabel;
    ValueYEdit: TiComponentEditorEdit;
    Label3: TLabel;
    IncrementXEdit: TiComponentEditorEdit;
    Label4: TLabel;
    IncrementYEdit: TiComponentEditorEdit;
    UseArrowKeysCheckBox: TiComponentEditorCheckBox;
    Label5: TLabel;
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
    Label32: TLabel;
    ColorPicker: TiComponentEditorColorPicker;
    EnabledCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSwitchQuadComponentEditorForm: TiSwitchQuadComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchQuadComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchQuad.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchQuadComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchQuad : TiSwitchQuad;
begin
  iSwitchQuad := Component as TiSwitchQuad;

  ValueXEdit.AsFloat               := iSwitchQuad.ValueX;
  ValueYEdit.AsFloat               := iSwitchQuad.ValueY;
  IncrementXEdit.AsFloat           := iSwitchQuad.IncrementX;
  IncrementYEdit.AsFloat           := iSwitchQuad.IncrementY;
  ColorPicker.Color                := iSwitchQuad.Color;

  EnabledCheckBox.AsBoolean        := iSwitchQuad.Enabled;
  ShowFocusRectCheckBox.AsBoolean  := iSwitchQuad.ShowFocusRect;
  UseArrowKeysCheckBox.AsBoolean   := iSwitchQuad.UseArrowKeys;
  TransparentCheckBox.AsBoolean    := iSwitchQuad.Transparent;
  BackGroundColorPicker.Color      := iSwitchQuad.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean  := iSwitchQuad.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger    := iSwitchQuad.UpdateFrameRate;

  RepeatInitialDelayEdit.AsInteger := iSwitchQuad.RepeatInitialDelay;
  RepeatIntervalEdit.AsInteger     := iSwitchQuad.RepeatInterval;

  UpLoadOPCProperties(iSwitchQuad, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSwitchQuadComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchQuad : TiSwitchQuad;
begin
  iSwitchQuad := Component as TiSwitchQuad;

  iSwitchQuad.ValueX             := ValueXEdit.AsFloat;
  iSwitchQuad.ValueY             := ValueYEdit.AsFloat;
  iSwitchQuad.IncrementX         := IncrementXEdit.AsFloat;
  iSwitchQuad.IncrementY         := IncrementYEdit.AsFloat;
  iSwitchQuad.Color              := ColorPicker.Color;

  iSwitchQuad.Enabled            := EnabledCheckBox.AsBoolean;
  iSwitchQuad.ShowFocusRect      := ShowFocusRectCheckBox.AsBoolean;
  iSwitchQuad.UseArrowKeys       := UseArrowKeysCheckBox.AsBoolean;
  iSwitchQuad.Transparent        := TransparentCheckBox.AsBoolean;
  iSwitchQuad.BackGroundColor    := BackGroundColorPicker.Color;
  iSwitchQuad.AutoFrameRate      := AutoFrameRateCheckBox.AsBoolean;
  iSwitchQuad.UpdateFrameRate    := UpdateFrameRateEdit.AsInteger;

  iSwitchQuad.RepeatInitialDelay := RepeatInitialDelayEdit.AsInteger;
  iSwitchQuad.RepeatInterval     := RepeatIntervalEdit.AsInteger;

  DownLoadOPCProperties(iSwitchQuad, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
