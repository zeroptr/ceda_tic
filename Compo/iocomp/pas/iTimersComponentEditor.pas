{*******************************************************}
{                                                       }
{       TiTimersComponentEditor                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iTimersComponentEditor;{$endif}
{$ifdef iCLX}unit QiTimersComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iTimers,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiTimers,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiTimersComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Enabled1CheckBox: TiComponentEditorCheckBox;
    Label2: TLabel;
    Interval1Edit: TiComponentEditorEdit;
    Enabled2CheckBox: TiComponentEditorCheckBox;
    Label1: TLabel;
    Interval2Edit: TiComponentEditorEdit;
    Enabled3CheckBox: TiComponentEditorCheckBox;
    Label3: TLabel;
    Interval3Edit: TiComponentEditorEdit;
    Enabled4CheckBox: TiComponentEditorCheckBox;
    Label4: TLabel;
    Interval4Edit: TiComponentEditorEdit;
    Enabled5CheckBox: TiComponentEditorCheckBox;
    Label5: TLabel;
    Interval5Edit: TiComponentEditorEdit;
    Enabled6CheckBox: TiComponentEditorCheckBox;
    Label6: TLabel;
    Interval6Edit: TiComponentEditorEdit;
    Enabled7CheckBox: TiComponentEditorCheckBox;
    Label7: TLabel;
    Interval7Edit: TiComponentEditorEdit;
    Enabled8CheckBox: TiComponentEditorCheckBox;
    Label8: TLabel;
    Interval8Edit: TiComponentEditorEdit;
    Enabled9CheckBox: TiComponentEditorCheckBox;
    Label9: TLabel;
    Interval9Edit: TiComponentEditorEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    iAboutPanel1: TiAboutPanel;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iTimersComponentEditorForm: TiTimersComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiTimersComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiTimers.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiTimersComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iTimers : TiTimers;
begin
  iTimers := Component as TiTimers;

  Enabled1CheckBox.AsBoolean := iTimers.Enabled1;
  Enabled2CheckBox.AsBoolean := iTimers.Enabled2;
  Enabled3CheckBox.AsBoolean := iTimers.Enabled3;
  Enabled4CheckBox.AsBoolean := iTimers.Enabled4;
  Enabled5CheckBox.AsBoolean := iTimers.Enabled5;
  Enabled6CheckBox.AsBoolean := iTimers.Enabled6;
  Enabled7CheckBox.AsBoolean := iTimers.Enabled7;
  Enabled8CheckBox.AsBoolean := iTimers.Enabled8;
  Enabled9CheckBox.AsBoolean := iTimers.Enabled9;
  Interval1Edit.AsInteger    := iTimers.Interval1;
  Interval2Edit.AsInteger    := iTimers.Interval2;
  Interval3Edit.AsInteger    := iTimers.Interval3;
  Interval4Edit.AsInteger    := iTimers.Interval4;
  Interval5Edit.AsInteger    := iTimers.Interval5;
  Interval6Edit.AsInteger    := iTimers.Interval6;
  Interval7Edit.AsInteger    := iTimers.Interval7;
  Interval8Edit.AsInteger    := iTimers.Interval8;
  Interval9Edit.AsInteger    := iTimers.Interval9;
end;
//****************************************************************************************************************************************************
procedure TiTimersComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iTimers : TiTimers;
begin
  iTimers := Component as TiTimers;

  iTimers.Enabled1  := Enabled1CheckBox.AsBoolean;
  iTimers.Enabled2  := Enabled2CheckBox.AsBoolean;
  iTimers.Enabled3  := Enabled3CheckBox.AsBoolean;
  iTimers.Enabled4  := Enabled4CheckBox.AsBoolean;
  iTimers.Enabled5  := Enabled5CheckBox.AsBoolean;
  iTimers.Enabled6  := Enabled6CheckBox.AsBoolean;
  iTimers.Enabled7  := Enabled7CheckBox.AsBoolean;
  iTimers.Enabled8  := Enabled8CheckBox.AsBoolean;
  iTimers.Enabled9  := Enabled9CheckBox.AsBoolean;
  iTimers.Interval1 := Interval1Edit.AsInteger;
  iTimers.Interval2 := Interval2Edit.AsInteger;
  iTimers.Interval3 := Interval3Edit.AsInteger;
  iTimers.Interval4 := Interval4Edit.AsInteger;
  iTimers.Interval5 := Interval5Edit.AsInteger;
  iTimers.Interval6 := Interval6Edit.AsInteger;
  iTimers.Interval7 := Interval7Edit.AsInteger;
  iTimers.Interval8 := Interval8Edit.AsInteger;
  iTimers.Interval9 := Interval9Edit.AsInteger;
end;
//****************************************************************************************************************************************************
end.
