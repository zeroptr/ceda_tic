{*******************************************************}
{                                                       }
{       TiThreadTimersComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iThreadTimersComponentEditor;{$endif}
{$ifdef iCLX}unit QiThreadTimersComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iThreadTimers,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiThreadTimers,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiThreadTimersComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Enabled1CheckBox: TiComponentEditorCheckBox;
    Interval1Edit: TiComponentEditorEdit;
    Enabled2CheckBox: TiComponentEditorCheckBox;
    Interval2Edit: TiComponentEditorEdit;
    Enabled3CheckBox: TiComponentEditorCheckBox;
    Interval3Edit: TiComponentEditorEdit;
    Enabled4CheckBox: TiComponentEditorCheckBox;
    Interval4Edit: TiComponentEditorEdit;
    Enabled5CheckBox: TiComponentEditorCheckBox;
    Interval5Edit: TiComponentEditorEdit;
    Enabled6CheckBox: TiComponentEditorCheckBox;
    Interval6Edit: TiComponentEditorEdit;
    Enabled7CheckBox: TiComponentEditorCheckBox;
    Interval7Edit: TiComponentEditorEdit;
    Enabled8CheckBox: TiComponentEditorCheckBox;
    Interval8Edit: TiComponentEditorEdit;
    Enabled9CheckBox: TiComponentEditorCheckBox;
    Interval9Edit: TiComponentEditorEdit;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    ThreadPriority1ComboBox: TiComponentEditorComboBox;
    ThreadPriority2ComboBox: TiComponentEditorComboBox;
    ThreadPriority3ComboBox: TiComponentEditorComboBox;
    ThreadPriority4ComboBox: TiComponentEditorComboBox;
    ThreadPriority5ComboBox: TiComponentEditorComboBox;
    ThreadPriority6ComboBox: TiComponentEditorComboBox;
    ThreadPriority7ComboBox: TiComponentEditorComboBox;
    ThreadPriority8ComboBox: TiComponentEditorComboBox;
    ThreadPriority9ComboBox: TiComponentEditorComboBox;
    iAboutPanel1: TiAboutPanel;
    Label19: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    ThreadPolicyLinux1Edit: TiComponentEditorComboBox;
    ThreadPolicyLinux2Edit: TiComponentEditorComboBox;
    ThreadPolicyLinux3Edit: TiComponentEditorComboBox;
    ThreadPolicyLinux4Edit: TiComponentEditorComboBox;
    ThreadPolicyLinux5Edit: TiComponentEditorComboBox;
    ThreadPolicyLinux6Edit: TiComponentEditorComboBox;
    ThreadPolicyLinux7Edit: TiComponentEditorComboBox;
    ThreadPolicyLinux8Edit: TiComponentEditorComboBox;
    ThreadPolicyLinux9Edit: TiComponentEditorComboBox;
    PolicyLinuxLabel: TLabel;
    ThreadPriorityLinux1ComboBox: TiComponentEditorEdit;
    ThreadPriorityLinux2ComboBox: TiComponentEditorEdit;
    ThreadPriorityLinux3ComboBox: TiComponentEditorEdit;
    ThreadPriorityLinux4ComboBox: TiComponentEditorEdit;
    ThreadPriorityLinux5ComboBox: TiComponentEditorEdit;
    ThreadPriorityLinux6ComboBox: TiComponentEditorEdit;
    ThreadPriorityLinux7ComboBox: TiComponentEditorEdit;
    ThreadPriorityLinux8ComboBox: TiComponentEditorEdit;
    ThreadPriorityLinux9ComboBox: TiComponentEditorEdit;
    PriorityLinuxLabel: TLabel;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
    procedure Loaded;                                            override;
  end;

var
  iThreadTimersComponentEditorForm: TiThreadTimersComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiThreadTimersComponentEditorForm.Loaded;
begin
  inherited Loaded;
  {$IFDEF iCLX}
  PriorityLinuxLabel.Visible           := True;

  ThreadPriorityLinux1ComboBox.Visible := True;
  ThreadPriorityLinux2ComboBox.Visible := True;
  ThreadPriorityLinux3ComboBox.Visible := True;
  ThreadPriorityLinux4ComboBox.Visible := True;
  ThreadPriorityLinux5ComboBox.Visible := True;
  ThreadPriorityLinux6ComboBox.Visible := True;
  ThreadPriorityLinux7ComboBox.Visible := True;
  ThreadPriorityLinux8ComboBox.Visible := True;
  ThreadPriorityLinux9ComboBox.Visible := True;

  PolicyLinuxLabel.Visible             := True;

  ThreadPolicyLinux1Edit.Visible       := True;
  ThreadPolicyLinux2Edit.Visible       := True;
  ThreadPolicyLinux3Edit.Visible       := True;
  ThreadPolicyLinux4Edit.Visible       := True;
  ThreadPolicyLinux5Edit.Visible       := True;
  ThreadPolicyLinux6Edit.Visible       := True;
  ThreadPolicyLinux7Edit.Visible       := True;
  ThreadPolicyLinux8Edit.Visible       := True;
  ThreadPolicyLinux9Edit.Visible       := True;
  {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiThreadTimersComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiThreadTimers.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiThreadTimersComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iThreadTimers : TiThreadTimers;
begin
  iThreadTimers := Component as TiThreadTimers;

  Enabled1CheckBox.AsBoolean        := iThreadTimers.Enabled1;
  Enabled2CheckBox.AsBoolean        := iThreadTimers.Enabled2;
  Enabled3CheckBox.AsBoolean        := iThreadTimers.Enabled3;
  Enabled4CheckBox.AsBoolean        := iThreadTimers.Enabled4;
  Enabled5CheckBox.AsBoolean        := iThreadTimers.Enabled5;
  Enabled6CheckBox.AsBoolean        := iThreadTimers.Enabled6;
  Enabled7CheckBox.AsBoolean        := iThreadTimers.Enabled7;
  Enabled8CheckBox.AsBoolean        := iThreadTimers.Enabled8;
  Enabled9CheckBox.AsBoolean        := iThreadTimers.Enabled9;
  Interval1Edit.AsInteger           := iThreadTimers.Interval1;
  Interval2Edit.AsInteger           := iThreadTimers.Interval2;
  Interval3Edit.AsInteger           := iThreadTimers.Interval3;
  Interval4Edit.AsInteger           := iThreadTimers.Interval4;
  Interval5Edit.AsInteger           := iThreadTimers.Interval5;
  Interval6Edit.AsInteger           := iThreadTimers.Interval6;
  Interval7Edit.AsInteger           := iThreadTimers.Interval7;
  Interval8Edit.AsInteger           := iThreadTimers.Interval8;
  Interval9Edit.AsInteger           := iThreadTimers.Interval9;

  {$IFDEF iVCL}
  ThreadPriority1ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority1);
  ThreadPriority2ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority2);
  ThreadPriority3ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority3);
  ThreadPriority4ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority4);
  ThreadPriority5ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority5);
  ThreadPriority6ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority6);
  ThreadPriority7ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority7);
  ThreadPriority8ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority8);
  ThreadPriority9ComboBox.AsInteger := ord(iThreadTimers.ThreadPriority9);
  {$ENDIF}
  {$IFDEF iCLX}
  ThreadPriority1ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows1);
  ThreadPriority2ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows2);
  ThreadPriority3ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows3);
  ThreadPriority4ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows4);
  ThreadPriority5ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows5);
  ThreadPriority6ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows6);
  ThreadPriority7ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows7);
  ThreadPriority8ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows8);
  ThreadPriority9ComboBox.AsInteger := ord(iThreadTimers.ThreadPriorityWindows9);

  ThreadPriorityLinux1ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux1;
  ThreadPriorityLinux2ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux2;
  ThreadPriorityLinux3ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux3;
  ThreadPriorityLinux4ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux4;
  ThreadPriorityLinux5ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux5;
  ThreadPriorityLinux6ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux6;
  ThreadPriorityLinux7ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux7;
  ThreadPriorityLinux8ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux8;
  ThreadPriorityLinux9ComboBox.AsInteger := iThreadTimers.ThreadPriorityLinux9;

  ThreadPolicyLinux1Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux1);
  ThreadPolicyLinux2Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux2);
  ThreadPolicyLinux3Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux3);
  ThreadPolicyLinux4Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux4);
  ThreadPolicyLinux5Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux5);
  ThreadPolicyLinux6Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux6);
  ThreadPolicyLinux7Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux7);
  ThreadPolicyLinux8Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux8);
  ThreadPolicyLinux9Edit.AsInteger := ord(iThreadTimers.ThreadPolicyLinux9);
  {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiThreadTimersComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iThreadTimers : TiThreadTimers;
begin
  iThreadTimers := Component as TiThreadTimers;

  iThreadTimers.Enabled1        := Enabled1CheckBox.AsBoolean;
  iThreadTimers.Enabled2        := Enabled2CheckBox.AsBoolean;
  iThreadTimers.Enabled3        := Enabled3CheckBox.AsBoolean;
  iThreadTimers.Enabled4        := Enabled4CheckBox.AsBoolean;
  iThreadTimers.Enabled5        := Enabled5CheckBox.AsBoolean;
  iThreadTimers.Enabled6        := Enabled6CheckBox.AsBoolean;
  iThreadTimers.Enabled7        := Enabled7CheckBox.AsBoolean;
  iThreadTimers.Enabled8        := Enabled8CheckBox.AsBoolean;
  iThreadTimers.Enabled9        := Enabled9CheckBox.AsBoolean;
  iThreadTimers.Interval1       := Interval1Edit.AsInteger;
  iThreadTimers.Interval2       := Interval2Edit.AsInteger;
  iThreadTimers.Interval3       := Interval3Edit.AsInteger;
  iThreadTimers.Interval4       := Interval4Edit.AsInteger;
  iThreadTimers.Interval5       := Interval5Edit.AsInteger;
  iThreadTimers.Interval6       := Interval6Edit.AsInteger;
  iThreadTimers.Interval7       := Interval7Edit.AsInteger;
  iThreadTimers.Interval8       := Interval8Edit.AsInteger;
  iThreadTimers.Interval9       := Interval9Edit.AsInteger;

  {$IFDEF iVCL}
  iThreadTimers.ThreadPriority1 := TThreadPriority(ThreadPriority1ComboBox.AsInteger);
  iThreadTimers.ThreadPriority2 := TThreadPriority(ThreadPriority2ComboBox.AsInteger);
  iThreadTimers.ThreadPriority3 := TThreadPriority(ThreadPriority3ComboBox.AsInteger);
  iThreadTimers.ThreadPriority4 := TThreadPriority(ThreadPriority4ComboBox.AsInteger);
  iThreadTimers.ThreadPriority5 := TThreadPriority(ThreadPriority5ComboBox.AsInteger);
  iThreadTimers.ThreadPriority6 := TThreadPriority(ThreadPriority6ComboBox.AsInteger);
  iThreadTimers.ThreadPriority7 := TThreadPriority(ThreadPriority7ComboBox.AsInteger);
  iThreadTimers.ThreadPriority8 := TThreadPriority(ThreadPriority8ComboBox.AsInteger);
  iThreadTimers.ThreadPriority9 := TThreadPriority(ThreadPriority9ComboBox.AsInteger);
  {$ENDIF}
  {$IFDEF iCLX}
  iThreadTimers.ThreadPriorityWindows1 := TiThreadPriority(ThreadPriority1ComboBox.AsInteger);
  iThreadTimers.ThreadPriorityWindows2 := TiThreadPriority(ThreadPriority2ComboBox.AsInteger);
  iThreadTimers.ThreadPriorityWindows3 := TiThreadPriority(ThreadPriority3ComboBox.AsInteger);
  iThreadTimers.ThreadPriorityWindows4 := TiThreadPriority(ThreadPriority4ComboBox.AsInteger);
  iThreadTimers.ThreadPriorityWindows5 := TiThreadPriority(ThreadPriority5ComboBox.AsInteger);
  iThreadTimers.ThreadPriorityWindows6 := TiThreadPriority(ThreadPriority6ComboBox.AsInteger);
  iThreadTimers.ThreadPriorityWindows7 := TiThreadPriority(ThreadPriority7ComboBox.AsInteger);
  iThreadTimers.ThreadPriorityWindows8 := TiThreadPriority(ThreadPriority8ComboBox.AsInteger);
  iThreadTimers.ThreadPriorityWindows9 := TiThreadPriority(ThreadPriority9ComboBox.AsInteger);

  iThreadTimers.ThreadPriorityLinux1 := ThreadPriorityLinux1ComboBox.AsInteger;
  iThreadTimers.ThreadPriorityLinux2 := ThreadPriorityLinux2ComboBox.AsInteger;
  iThreadTimers.ThreadPriorityLinux3 := ThreadPriorityLinux3ComboBox.AsInteger;
  iThreadTimers.ThreadPriorityLinux4 := ThreadPriorityLinux4ComboBox.AsInteger;
  iThreadTimers.ThreadPriorityLinux5 := ThreadPriorityLinux5ComboBox.AsInteger;
  iThreadTimers.ThreadPriorityLinux6 := ThreadPriorityLinux6ComboBox.AsInteger;
  iThreadTimers.ThreadPriorityLinux7 := ThreadPriorityLinux7ComboBox.AsInteger;
  iThreadTimers.ThreadPriorityLinux8 := ThreadPriorityLinux8ComboBox.AsInteger;
  iThreadTimers.ThreadPriorityLinux9 := ThreadPriorityLinux9ComboBox.AsInteger;

  iThreadTimers.ThreadPolicyLinux1 := TiThreadPolicy(ThreadPolicyLinux1Edit.AsInteger);
  iThreadTimers.ThreadPolicyLinux2 := TiThreadPolicy(ThreadPolicyLinux2Edit.AsInteger);
  iThreadTimers.ThreadPolicyLinux3 := TiThreadPolicy(ThreadPolicyLinux3Edit.AsInteger);
  iThreadTimers.ThreadPolicyLinux4 := TiThreadPolicy(ThreadPolicyLinux4Edit.AsInteger);
  iThreadTimers.ThreadPolicyLinux5 := TiThreadPolicy(ThreadPolicyLinux5Edit.AsInteger);
  iThreadTimers.ThreadPolicyLinux6 := TiThreadPolicy(ThreadPolicyLinux6Edit.AsInteger);
  iThreadTimers.ThreadPolicyLinux7 := TiThreadPolicy(ThreadPolicyLinux7Edit.AsInteger);
  iThreadTimers.ThreadPolicyLinux8 := TiThreadPolicy(ThreadPolicyLinux8Edit.AsInteger);
  iThreadTimers.ThreadPolicyLinux9 := TiThreadPolicy(ThreadPolicyLinux9Edit.AsInteger);
  {$ENDIF}
end;
//****************************************************************************************************************************************************
end.
