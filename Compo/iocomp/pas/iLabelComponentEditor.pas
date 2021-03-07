{*******************************************************}
{                                                       }
{       TiLabelComponentEditor                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLabelComponentEditor;{$endif}
{$ifdef iCLX}unit QiLabelComponentEditor;{$endif}

interface

uses                                      
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLabel,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLabel,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLabelComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    FontPicker: TiComponentEditorFontPicker;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    AlignmentRadioGroup: TiComponentEditorRadioGroup;
    OuterMarginGroupBox: TGroupBox;
    OuterMarginLeftEdit: TiComponentEditorEdit;
    OuterMarginLeftUpDown: TiUpDown;
    OuterMarginTopEdit: TiComponentEditorEdit;
    OuterMarginTopUpDown: TiUpDown;
    OuterMarginBottomEdit: TiComponentEditorEdit;
    OuterMarginBottomUpDown: TiUpDown;
    OuterMarginRightEdit: TiComponentEditorEdit;
    OuterMarginRightUpDown: TiUpDown;
    ShadowGroupBox: TGroupBox;
    ShadowShowCheckBox: TiComponentEditorCheckBox;
    Label2: TLabel;
    ShadowOffsetXEdit: TiComponentEditorEdit;
    ShadowOffsetXUpDown: TiUpDown;
    Label3: TLabel;
    ShadowOffsetYEdit: TiComponentEditorEdit;
    ShadowOffsetYUpDown: TiUpDown;
    Label4: TLabel;
    ShadowColorPicker: TiComponentEditorColorPicker;
    TransparentCheckBox: TiComponentEditorCheckBox;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label13: TLabel;
    CaptionEdit: TiComponentEditorMemo;
    Label1: TLabel;
    WordWrapCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iLabelComponentEditorForm: TiLabelComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLabelComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLabel.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLabelComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLabel : TiLabel;
begin
  iLabel := Component as TiLabel;

  CaptionEdit.AsString            := iLabel.Caption;
  AutoFrameRateCheckBox.AsBoolean := iLabel.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger   := iLabel.UpdateFrameRate;
  BackGroundColorPicker.Color     := iLabel.BackGroundColor;
  AutoSizeCheckBox.AsBoolean      := iLabel.AutoSize;
  TransparentCheckBox.AsBoolean   := iLabel.Transparent;
  WordWrapCheckBox.AsBoolean      := iLabel.WordWrap;

  BorderStyleRadioGroup.AsInteger := ord(iLabel.BorderStyle);
  AlignmentRadioGroup.AsInteger   := ord(iLabel.Alignment);

  OuterMarginLeftEdit.AsInteger   := iLabel.OuterMarginLeft;
  OuterMarginTopEdit.AsInteger    := iLabel.OuterMarginTop;
  OuterMarginRightEdit.AsInteger  := iLabel.OuterMarginRight;
  OuterMarginBottomEdit.AsInteger := iLabel.OuterMarginBottom;

  ShadowShowCheckBox.AsBoolean    := iLabel.ShadowShow;
  ShadowColorPicker.Color         := iLabel.ShadowColor;
  ShadowOffsetXEdit.AsInteger     := iLabel.ShadowXOffset;
  ShadowOffsetYEdit.AsInteger     := iLabel.ShadowYOffset;

  UpLoadOPCProperties(iLabel, iOPCBrowserPanel);

  FontPicker.Font.Assign(iLabel.Font);
end;
//****************************************************************************************************************************************************
procedure TiLabelComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLabel : TiLabel;
begin
  iLabel := Component as TiLabel;

  iLabel.Caption           := CaptionEdit.AsString;
  iLabel.AutoFrameRate     := AutoFrameRateCheckBox.AsBoolean;
  iLabel.UpdateFrameRate   := UpdateFrameRateEdit.AsInteger;
  iLabel.BackGroundColor   := BackGroundColorPicker.Color;
  iLabel.AutoSize          := AutoSizeCheckBox.AsBoolean;
  iLabel.Transparent       := TransparentCheckBox.AsBoolean;
  iLabel.WordWrap          := WordWrapCheckBox.AsBoolean;

  iLabel.BorderStyle       := TiLabelBorderStyle(BorderStyleRadioGroup.AsInteger);
  iLabel.Alignment         := TiAlignmentHorizontal(AlignmentRadioGroup.AsInteger);

  iLabel.OuterMarginLeft   := OuterMarginLeftEdit.AsInteger;
  iLabel.OuterMarginTop    := OuterMarginTopEdit.AsInteger;
  iLabel.OuterMarginRight  := OuterMarginRightEdit.AsInteger;
  iLabel.OuterMarginBottom := OuterMarginBottomEdit.AsInteger;

  iLabel.ShadowShow        := ShadowShowCheckBox.AsBoolean;
  iLabel.ShadowColor       := ShadowColorPicker.Color;
  iLabel.ShadowXOffset     := ShadowOffsetXEdit.AsInteger;
  iLabel.ShadowYOffset     := ShadowOffsetYEdit.AsInteger;

  DownLoadOPCProperties(iLabel, iOPCBrowserPanel);

  iLabel.Font.Assign(FontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
