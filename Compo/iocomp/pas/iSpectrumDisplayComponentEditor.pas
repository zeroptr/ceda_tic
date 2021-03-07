{*******************************************************}
{                                                       }
{       TiSpectrumDisplayComponentEditor                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSpectrumDisplayComponentEditor;{$endif}
{$ifdef iCLX}unit QiSpectrumDisplayComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSpectrumDisplay,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSpectrumDisplay,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSpectrumDisplayComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    OuterMarginGroupBox: TGroupBox;
    OuterMarginLeftEdit: TiComponentEditorEdit;
    OuterMarginLeftUpDown: TiUpDown;
    OuterMarginTopEdit: TiComponentEditorEdit;
    OuterMarginTopUpDown: TiUpDown;
    OuterMarginBottomEdit: TiComponentEditorEdit;
    OuterMarginBottomUpDown: TiUpDown;
    OuterMarginRightEdit: TiComponentEditorEdit;
    OuterMarginRightUpDown: TiUpDown;
    PeakGroupBox: TGroupBox;
    PeakShowCheckBox: TiComponentEditorCheckBox;
    Label4: TLabel;
    PeakLineColorPicker: TiComponentEditorColorPicker;
    BarGroupBox: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BarCountEdit: TiComponentEditorEdit;
    BarCountUpDown: TiUpDown;
    BarWidthEdit: TiComponentEditorEdit;
    BarWidthUpDown: TiUpDown;
    BarColorPicker: TiComponentEditorColorPicker;
    Label2: TLabel;
    BarSpacingEdit: TiComponentEditorEdit;
    BarSpacingUpDown: TiUpDown;
    DecayGroupBox: TGroupBox;
    DecayEnabledCheckBox: TiComponentEditorCheckBox;
    Label3: TLabel;
    Label8: TLabel;
    DecayIntervalEdit: TiComponentEditorEdit;
    DecayIntervalUpDown: TiUpDown;
    DecayInitialDelayEdit: TiComponentEditorEdit;
    DecayInitialDelayUpDown: TiUpDown;
    TransparentCheckBox: TiComponentEditorCheckBox;
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
  iSpectrumDisplayComponentEditorForm: TiSpectrumDisplayComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSpectrumDisplayComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSpectrumDisplay.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplayComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSpectrumDisplay : TiSpectrumDisplay;
begin
  iSpectrumDisplay := Component as TiSpectrumDisplay;

  AutoSizeCheckBox.AsBoolean      := iSpectrumDisplay.AutoSize;
  TransparentCheckBox.AsBoolean   := iSpectrumDisplay.Transparent;
  BackGroundColorPicker.Color     := iSpectrumDisplay.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean := iSpectrumDisplay.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger   := iSpectrumDisplay.UpdateFrameRate;

  BorderStyleRadioGroup.AsInteger := ord(iSpectrumDisplay.BorderStyle);

  OuterMarginLeftEdit.AsInteger   := iSpectrumDisplay.OuterMarginLeft;
  OuterMarginTopEdit.AsInteger    := iSpectrumDisplay.OuterMarginTop;
  OuterMarginRightEdit.AsInteger  := iSpectrumDisplay.OuterMarginRight;
  OuterMarginBottomEdit.AsInteger := iSpectrumDisplay.OuterMarginBottom;

  PeakShowCheckBox.AsBoolean      := iSpectrumDisplay.PeakShow;
  PeakLineColorPicker.Color       := iSpectrumDisplay.PeakLineColor;

  BarCountEdit.AsInteger          := iSpectrumDisplay.BarCount;
  BarWidthEdit.AsInteger          := iSpectrumDisplay.BarWidth;
  BarSpacingEdit.AsInteger        := iSpectrumDisplay.BarSpacing;
  BarColorPicker.Color            := iSpectrumDisplay.BarColor;

  DecayEnabledCheckBox.AsBoolean  := iSpectrumDisplay.DecayEnabled;
  DecayIntervalEdit.AsInteger     := iSpectrumDisplay.DecayInterval;
  DecayInitialDelayEdit.AsInteger := iSpectrumDisplay.DecayInitialDelay;

  UpLoadOPCProperties(iSpectrumDisplay, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSpectrumDisplayComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSpectrumDisplay : TiSpectrumDisplay;
begin
  iSpectrumDisplay := Component as TiSpectrumDisplay;

  iSpectrumDisplay.AutoSize          := AutoSizeCheckBox.AsBoolean;
  iSpectrumDisplay.Transparent       := TransparentCheckBox.AsBoolean;
  iSpectrumDisplay.BackGroundColor   := BackGroundColorPicker.Color;
  iSpectrumDisplay.AutoFrameRate     := AutoFrameRateCheckBox.AsBoolean;
  iSpectrumDisplay.UpdateFrameRate   := UpdateFrameRateEdit.AsInteger;

  iSpectrumDisplay.BorderStyle       := TiBevelStyle(BorderStyleRadioGroup.AsInteger);

  iSpectrumDisplay.OuterMarginLeft   := OuterMarginLeftEdit.AsInteger;
  iSpectrumDisplay.OuterMarginTop    := OuterMarginTopEdit.AsInteger;
  iSpectrumDisplay.OuterMarginRight  := OuterMarginRightEdit.AsInteger;
  iSpectrumDisplay.OuterMarginBottom := OuterMarginBottomEdit.AsInteger;

  iSpectrumDisplay.PeakShow          := PeakShowCheckBox.AsBoolean;
  iSpectrumDisplay.PeakLineColor     := PeakLineColorPicker.Color;

  iSpectrumDisplay.BarCount          := BarCountEdit.AsInteger;
  iSpectrumDisplay.BarWidth          := BarWidthEdit.AsInteger;
  iSpectrumDisplay.BarSpacing        := BarSpacingEdit.AsInteger;
  iSpectrumDisplay.BarColor          := BarColorPicker.Color;

  iSpectrumDisplay.DecayEnabled      := DecayEnabledCheckBox.AsBoolean;
  iSpectrumDisplay.DecayInterval     := DecayIntervalEdit.AsInteger;
  iSpectrumDisplay.DecayInitialDelay := DecayInitialDelayEdit.AsInteger;

  DownLoadOPCProperties(iSpectrumDisplay, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
