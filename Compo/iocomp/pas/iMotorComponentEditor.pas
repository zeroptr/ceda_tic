{*******************************************************}
{                                                       }
{       TiMotorComponentEditor                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iMotorComponentEditor;{$endif}
{$ifdef iCLX}unit QiMotorComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iMotor,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiMotor,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiMotorComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
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
    PipeGroupBox: TGroupBox;
    PipeShowRightCheckBox: TiComponentEditorCheckBox;
    PipeShowBottomCheckBox: TiComponentEditorCheckBox;
    PipeShowTopCheckBox: TiComponentEditorCheckBox;
    PipeShowLeftCheckBox: TiComponentEditorCheckBox;
    BaseGroupBox: TGroupBox;
    BaseShowCheckBox: TiComponentEditorCheckBox;
    Label177: TLabel;
    BaseStyleComboBox: TiComponentEditorComboBox;
    FanGroupBox: TGroupBox;
    Label4: TLabel;
    FanSequenceUpDown: TiUpDown;
    FanSequenceEdit: TiComponentEditorEdit;
    FanOnCheckBox: TiComponentEditorCheckBox;
    Label5: TLabel;
    FanIntervalUpDown: TiUpDown;
    FanIntervalEdit: TiComponentEditorEdit;
    BladeGroupBox: TGroupBox;
    Label3: TLabel;
    BladeColor1Picker: TiComponentEditorColorPicker;
    Label1: TLabel;
    BladeColor2Picker: TiComponentEditorColorPicker;
    Label2: TLabel;
    BladeColor3Picker: TiComponentEditorColorPicker;
    Label6: TLabel;
    PipeColorPicker: TiComponentEditorColorPicker;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iMotorComponentEditorForm: TiMotorComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiMotorComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiMotor.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiMotorComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iMotor : TiMotor;
begin
  iMotor := Component as TiMotor;

  FanOnCheckBox.AsBoolean          := iMotor.FanOn;
  FanIntervalEdit.AsInteger        := iMotor.FanInterval;
  FanSequenceEdit.AsInteger        := iMotor.FanSequence;

  BladeColor1Picker.Color          := iMotor.BladeColor1;
  BladeColor2Picker.Color          := iMotor.BladeColor2;
  BladeColor3Picker.Color          := iMotor.BladeColor3;

  PipeShowLeftCheckBox.AsBoolean   := iMotor.PipeShowLeft;
  PipeShowTopCheckBox.AsBoolean    := iMotor.PipeShowTop;
  PipeShowRightCheckBox.AsBoolean  := iMotor.PipeShowRight;
  PipeShowBottomCheckBox.AsBoolean := iMotor.PipeShowBottom;
  PipeColorPicker.Color            := iMotor.PipeColor;

  BaseShowCheckBox.AsBoolean       := iMotor.BaseShow;
  BaseStyleComboBox.AsInteger      := ord(iMotor.BaseStyle);

  BackGroundColorPicker.Color      := iMotor.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean  := iMotor.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger    := iMotor.UpdateFrameRate;

  UpLoadOPCProperties(iMotor, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiMotorComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iMotor : TiMotor;
begin
  iMotor := Component as TiMotor;

  iMotor.FanOn            := FanOnCheckBox.AsBoolean;
  iMotor.FanInterval      := FanIntervalEdit.AsInteger;
  iMotor.FanSequence      := FanSequenceEdit.AsInteger;

  iMotor.BladeColor1      := BladeColor1Picker.Color;
  iMotor.BladeColor2      := BladeColor2Picker.Color;
  iMotor.BladeColor3      := BladeColor3Picker.Color;

  iMotor.PipeShowLeft     := PipeShowLeftCheckBox.AsBoolean;
  iMotor.PipeShowTop      := PipeShowTopCheckBox.AsBoolean;
  iMotor.PipeShowRight    := PipeShowRightCheckBox.AsBoolean;
  iMotor.PipeShowBottom   := PipeShowBottomCheckBox.AsBoolean;
  iMotor.PipeColor        := PipeColorPicker.Color;

  iMotor.BaseShow         := BaseShowCheckBox.AsBoolean;
  iMotor.BaseStyle        := TiMotorBaseStyle(BaseStyleComboBox.AsInteger);

  iMotor.BackGroundColor  := BackGroundColorPicker.Color;
  iMotor.AutoFrameRate    := AutoFrameRateCheckBox.AsBoolean;
  iMotor.UpdateFrameRate  := UpdateFrameRateEdit.AsInteger;

  DownLoadOPCProperties(iMotor, iOPCBrowserPanel);  
end;
//****************************************************************************************************************************************************
end.
