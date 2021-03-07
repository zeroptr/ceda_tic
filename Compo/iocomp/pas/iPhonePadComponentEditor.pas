{*******************************************************}
{                                                       }
{       TiPhonePadComponentEditorForm                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPhonePadComponentEditor;{$endif}
{$ifdef iCLX}unit QiPhonePadComponentEditor;{$endif}

interface

uses
{$I iIncludeUsesForms.inc}

{$IFDEF iVCL} iComponentEditorForm,  iTypes,  iPhonePad,{$ENDIF}
{$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiPhonePad,{$ENDIF}

{$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
{$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiPhonePadComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    FontPicker: TiComponentEditorFontPicker;
    Label3: TLabel;
    Label4: TLabel;
    OuterMarginEdit: TiComponentEditorEdit;
    ButtonSpacingEdit: TiComponentEditorEdit;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    ButtonCaptionGroupBox: TGroupBox;
    ButtonCaption1Edit: TiComponentEditorEdit;
    ButtonCaption4Edit: TiComponentEditorEdit;
    ButtonCaption7Edit: TiComponentEditorEdit;
    ButtonCaptionAEdit: TiComponentEditorEdit;
    ButtonCaption2Edit: TiComponentEditorEdit;
    ButtonCaption5Edit: TiComponentEditorEdit;
    ButtonCaption8Edit: TiComponentEditorEdit;
    ButtonCaption0Edit: TiComponentEditorEdit;
    ButtonCaption3Edit: TiComponentEditorEdit;
    ButtonCaption6Edit: TiComponentEditorEdit;
    ButtonCaption9Edit: TiComponentEditorEdit;
    ButtonCaptionPEdit: TiComponentEditorEdit;
    ButtonVisibleGroupBox: TGroupBox;
    ButtonVisible1CheckBox: TiComponentEditorCheckBox;
    ButtonVisible4CheckBox: TiComponentEditorCheckBox;
    ButtonVisible7CheckBox: TiComponentEditorCheckBox;
    ButtonVisibleACheckBox: TiComponentEditorCheckBox;
    ButtonVisible2CheckBox: TiComponentEditorCheckBox;
    ButtonVisible5CheckBox: TiComponentEditorCheckBox;
    ButtonVisible8CheckBox: TiComponentEditorCheckBox;
    ButtonVisible0CheckBox: TiComponentEditorCheckBox;
    ButtonVisible3CheckBox: TiComponentEditorCheckBox;
    ButtonVisible6CheckBox: TiComponentEditorCheckBox;
    ButtonVisible9CheckBox: TiComponentEditorCheckBox;
    ButtonVisiblePCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
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
  iPhonePadComponentEditorForm: TiPhonePadComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiPhonePadComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiPhonePad.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiPhonePadComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iPhonePad : TiPhonePad;
begin
  iPhonePad := Component as TiPhonePad;

  ShowFocusRectCheckBox.AsBoolean := iPhonePad.ShowFocusRect;
  TransparentCheckBox.AsBoolean   := iPhonePad.Transparent;
  OuterMarginEdit.AsFloat         := iPhonePad.OuterMargin;
  ButtonSpacingEdit.AsFloat       := iPhonePad.ButtonSpacing;
  BackGroundColorPicker.Color     := iPhonePad.BackGroundColor;
  BorderStyleRadioGroup.AsInteger := ord(iPhonePad.BorderStyle);
  AutoFrameRateCheckBox.AsBoolean := iPhonePad.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger   := iPhonePad.UpdateFrameRate;

  ButtonCaption0Edit.AsString     := iPhonePad.ButtonCaption0;
  ButtonCaption1Edit.AsString     := iPhonePad.ButtonCaption1;
  ButtonCaption2Edit.AsString     := iPhonePad.ButtonCaption2;
  ButtonCaption3Edit.AsString     := iPhonePad.ButtonCaption3;
  ButtonCaption4Edit.AsString     := iPhonePad.ButtonCaption4;
  ButtonCaption5Edit.AsString     := iPhonePad.ButtonCaption5;
  ButtonCaption6Edit.AsString     := iPhonePad.ButtonCaption6;
  ButtonCaption7Edit.AsString     := iPhonePad.ButtonCaption7;
  ButtonCaption8Edit.AsString     := iPhonePad.ButtonCaption8;
  ButtonCaption9Edit.AsString     := iPhonePad.ButtonCaption9;
  ButtonCaptionAEdit.AsString     := iPhonePad.ButtonCaptionStar;
  ButtonCaptionPEdit.AsString     := iPhonePad.ButtonCaptionPound;

  ButtonVisible0CheckBox.AsBoolean  := iPhonePad.ButtonVisible0;
  ButtonVisible1CheckBox.AsBoolean  := iPhonePad.ButtonVisible1;
  ButtonVisible2CheckBox.AsBoolean  := iPhonePad.ButtonVisible2;
  ButtonVisible3CheckBox.AsBoolean  := iPhonePad.ButtonVisible3;
  ButtonVisible4CheckBox.AsBoolean  := iPhonePad.ButtonVisible4;
  ButtonVisible5CheckBox.AsBoolean  := iPhonePad.ButtonVisible5;
  ButtonVisible6CheckBox.AsBoolean  := iPhonePad.ButtonVisible6;
  ButtonVisible7CheckBox.AsBoolean  := iPhonePad.ButtonVisible7;
  ButtonVisible8CheckBox.AsBoolean  := iPhonePad.ButtonVisible8;
  ButtonVisible9CheckBox.AsBoolean  := iPhonePad.ButtonVisible9;
  ButtonVisibleACheckBox.AsBoolean  := iPhonePad.ButtonVisibleStar;
  ButtonVisiblePCheckBox.AsBoolean  := iPhonePad.ButtonVisiblePound;

  FontPicker.Font.Assign(iPhonePad.Font);
end;
//****************************************************************************************************************************************************
procedure TiPhonePadComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iPhonePad : TiPhonePad;
begin
  iPhonePad := Component as TiPhonePad;

  iPhonePad.ShowFocusRect      := ShowFocusRectCheckBox.AsBoolean;
  iPhonePad.Transparent        := TransparentCheckBox.AsBoolean;
  iPhonePad.OuterMargin        := OuterMarginEdit.AsFloat;
  iPhonePad.ButtonSpacing      := ButtonSpacingEdit.AsFloat;
  iPhonePad.BackGroundColor    := BackGroundColorPicker.Color;
  iPhonePad.BorderStyle        := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iPhonePad.AutoFrameRate      := AutoFrameRateCheckBox.AsBoolean;
  iPhonePad.UpdateFrameRate    := UpdateFrameRateEdit.AsInteger;

  iPhonePad.ButtonCaption0     := ButtonCaption0Edit.AsString;
  iPhonePad.ButtonCaption1     := ButtonCaption1Edit.AsString;
  iPhonePad.ButtonCaption2     := ButtonCaption2Edit.AsString;
  iPhonePad.ButtonCaption3     := ButtonCaption3Edit.AsString;
  iPhonePad.ButtonCaption4     := ButtonCaption4Edit.AsString;
  iPhonePad.ButtonCaption5     := ButtonCaption5Edit.AsString;
  iPhonePad.ButtonCaption6     := ButtonCaption6Edit.AsString;
  iPhonePad.ButtonCaption7     := ButtonCaption7Edit.AsString;
  iPhonePad.ButtonCaption8     := ButtonCaption8Edit.AsString;
  iPhonePad.ButtonCaption9     := ButtonCaption9Edit.AsString;
  iPhonePad.ButtonCaptionStar  := ButtonCaptionAEdit.AsString;
  iPhonePad.ButtonCaptionPound := ButtonCaptionPEdit.AsString;

  iPhonePad.ButtonVisible0     := ButtonVisible0CheckBox.AsBoolean;
  iPhonePad.ButtonVisible1     := ButtonVisible1CheckBox.AsBoolean;
  iPhonePad.ButtonVisible2     := ButtonVisible2CheckBox.AsBoolean;
  iPhonePad.ButtonVisible3     := ButtonVisible3CheckBox.AsBoolean;
  iPhonePad.ButtonVisible4     := ButtonVisible4CheckBox.AsBoolean;
  iPhonePad.ButtonVisible5     := ButtonVisible5CheckBox.AsBoolean;
  iPhonePad.ButtonVisible6     := ButtonVisible6CheckBox.AsBoolean;
  iPhonePad.ButtonVisible7     := ButtonVisible7CheckBox.AsBoolean;
  iPhonePad.ButtonVisible8     := ButtonVisible8CheckBox.AsBoolean;
  iPhonePad.ButtonVisible9     := ButtonVisible9CheckBox.AsBoolean;
  iPhonePad.ButtonVisibleStar  := ButtonVisibleACheckBox.AsBoolean;
  iPhonePad.ButtonVisiblePound := ButtonVisiblePCheckBox.AsBoolean;

  iPhonePad.Font.Assign(FontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
