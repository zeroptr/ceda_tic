{*******************************************************}
{                                                       }
{       TiPanelComponentEditor                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPanelComponentEditor;{$endif}
{$ifdef iCLX}unit QiPanelComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iPanel,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiPanel,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiPanelComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    TitleGroupBox: TGroupBox;
    Label5: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    TitleMarginLeftUpDown: TiUpDown;
    TitleMarginTopUpDown: TiUpDown;
    TitleMarginLeftEdit: TiComponentEditorEdit;
    TitleTextEdit: TiComponentEditorEdit;
    FontPicker: TiComponentEditorFontPicker;
    TitleMarginTopEdit: TiComponentEditorEdit;
    TitleBevelGroubBox: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    TitleBevelMarginEndsUpDown: TiUpDown;
    TitleBevelMarginTopUpDown: TiUpDown;
    ShowTitleBevelCheckBox: TiComponentEditorCheckBox;
    TitleBevelMarginEndsEdit: TiComponentEditorEdit;
    TitleBevelMarginTopEdit: TiComponentEditorEdit;
    TitleAlignmentRadioGroup: TiComponentEditorRadioGroup;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iPanelComponentEditorForm: TiPanelComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiPanelComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiPanel.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiPanelComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iPanel : TiPanel;
begin
  iPanel := Component as TiPanel;

  BorderStyleRadioGroup.AsInteger     := ord(iPanel.BorderStyle);
  BackGroundColorPicker.Color         := iPanel.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean     := iPanel.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger       := iPanel.UpdateFrameRate;

  TitleTextEdit.AsString              := iPanel.TitleText;
  TitleMarginLeftEdit.AsInteger       := iPanel.TitleMarginLeft;
  TitleMarginTopEdit.AsInteger        := iPanel.TitleMarginTop;
  TitleAlignmentRadioGroup.AsInteger  := ord(iPanel.TitleAlignment);

  ShowTitleBevelCheckBox.AsBoolean    := iPanel.ShowTitleBevel;
  TitleBevelMarginEndsEdit.AsInteger  := iPanel.TitleBevelMarginEnds;
  TitleBevelMarginTopEdit.AsInteger   := iPanel.TitleBevelMarginTop;

  UpLoadOPCProperties(iPanel, iOPCBrowserPanel);

  FontPicker.Font.Assign(iPanel.TitleFont);
end;
//****************************************************************************************************************************************************
procedure TiPanelComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iPanel : TiPanel;
begin
  iPanel := Component as TiPanel;

  iPanel.BorderStyle          := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iPanel.BackGroundColor      := BackGroundColorPicker.Color;
  iPanel.AutoFrameRate        := AutoFrameRateCheckBox.AsBoolean;
  iPanel.UpdateFrameRate      := UpdateFrameRateEdit.AsInteger;

  iPanel.TitleText            := TitleTextEdit.AsString;
  iPanel.TitleMarginLeft      := TitleMarginLeftEdit.AsInteger;
  iPanel.TitleMarginTop       := TitleMarginTopEdit.AsInteger;
  iPanel.TitleAlignment       := TiAlignmentHorizontal(TitleAlignmentRadioGroup.AsInteger);

  iPanel.ShowTitleBevel       := ShowTitleBevelCheckBox.AsBoolean;
  iPanel.TitleBevelMarginEnds := TitleBevelMarginEndsEdit.AsInteger;
  iPanel.TitleBevelMarginTop  := TitleBevelMarginTopEdit.AsInteger;

  DownLoadOPCProperties(iPanel, iOPCBrowserPanel);

  iPanel.TitleFont.Assign(FontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
