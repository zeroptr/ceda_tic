{*******************************************************}
{                                                       }
{       TiGradientComponentEditor                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iGradientComponentEditor;{$endif}
{$ifdef iCLX}unit QiGradientComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iGradient,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiGradient,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiGradientComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    ColorStartPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    DirectionRadioGroup: TiComponentEditorRadioGroup;
    ColorStopPicker: TiComponentEditorColorPicker;
    Label1: TLabel;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iGradientComponentEditorForm: TiGradientComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiGradientComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiGradient.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiGradientComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iGradient : TiGradient;
begin
  iGradient := Component as TiGradient;

  CachedDrawingCheckBox.AsBoolean := iGradient.CachedDrawing;
  ColorStartPicker.Color          := iGradient.ColorStart;
  ColorStopPicker.Color           := iGradient.ColorStop;
  DirectionRadioGroup.AsInteger   := ord(iGradient.Direction);
  AutoFrameRateCheckBox.AsBoolean := iGradient.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger   := iGradient.UpdateFrameRate;

  UpLoadOPCProperties(iGradient, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiGradientComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iGradient : TiGradient;
begin
  iGradient := Component as TiGradient;

  iGradient.CachedDrawing   := CachedDrawingCheckBox.AsBoolean;
  iGradient.ColorStart      := ColorStartPicker.Color;
  iGradient.ColorStop       := ColorStopPicker.Color;
  iGradient.Direction       := TiFillDirection(DirectionRadioGroup.AsInteger);
  iGradient.AutoFrameRate   := AutoFrameRateCheckBox.AsBoolean;
  iGradient.UpdateFrameRate := UpdateFrameRateEdit.AsInteger;

  DownLoadOPCProperties(iGradient, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
