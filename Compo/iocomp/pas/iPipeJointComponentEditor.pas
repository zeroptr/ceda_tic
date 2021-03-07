{*******************************************************}
{                                                       }
{       TiPipeJointComponentEditor                      }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPipeJointComponentEditor;{$endif}
{$ifdef iCLX}unit QiPipeJointComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iPipeJoint,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiPipeJoint,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiPipeJointComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iPipeJointComponentEditorForm: TiPipeJointComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiPipeJointComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiPipeJoint.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiPipeJointComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iPipeJoint : TiPipeJoint;
begin
  iPipeJoint := Component as TiPipeJoint;

  BackGroundColorPicker.Color := iPipeJoint.BackGroundColor;

  UpLoadOPCProperties(iPipeJoint, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiPipeJointComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iPipeJoint : TiPipeJoint;
begin
  iPipeJoint := Component as TiPipeJoint;

  iPipeJoint.BackGroundColor := BackGroundColorPicker.Color;

  DownLoadOPCProperties(iPipeJoint, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
