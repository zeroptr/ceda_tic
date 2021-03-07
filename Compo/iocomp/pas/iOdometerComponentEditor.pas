{*******************************************************}
{                                                       }
{       TiOdometerComponentEditor                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOdometerComponentEditor;{$endif}
{$ifdef iCLX}unit QiOdometerComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iOdometer,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiOdometer,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiOdometerComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label8: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    ValueEdit: TiComponentEditorEdit;
    TransparentCheckBox: TiComponentEditorCheckBox;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    DesignTabSheet: TTabSheet;
    iComponentEditorPageControl1: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    Label6: TLabel;
    BorderMarginUpDown: TiUpDown;
    Label31: TLabel;
    BorderMarginEdit: TiComponentEditorEdit;
    ShowDecimalPointCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    TabSheet2: TTabSheet;
    DigitsGroupBox: TGroupBox;
    Label1: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    DigitWidthUpDown: TiUpDown;
    DigitCountUpDown: TiUpDown;
    DigitsBackgroundColorPicker: TiComponentEditorColorPicker;
    DigitWidthEdit: TiComponentEditorEdit;
    DigitCountEdit: TiComponentEditorEdit;
    DigitsFontPicker: TiComponentEditorFontPicker;
    DigitBorderGroupBox: TGroupBox;
    Label4: TLabel;
    DigitBorderShowCheckBox: TiComponentEditorCheckBox;
    DigitBorderColorPicker: TiComponentEditorColorPicker;
    TenthsGroupBox: TGroupBox;
    Label7: TLabel;
    Label3: TLabel;
    TenthsDigitCountUpDown: TiUpDown;
    TenthsBackgroundColorPicker: TiComponentEditorColorPicker;
    TenthsFontPicker: TiComponentEditorFontPicker;
    ShowTenthsCheckBox: TiComponentEditorCheckBox;
    TenthsDigitCountEdit: TiComponentEditorEdit;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iOdometerComponentEditorForm: TiOdometerComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiOdometerComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiOdometer.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiOdometerComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iOdometer : TiOdometer;
begin
  iOdometer := Component as TiOdometer;

  AutoSizeCheckBox.AsBoolean         := iOdometer.AutoSize;
  TransparentCheckBox.AsBoolean      := iOdometer.Transparent;
  BorderMarginEdit.AsInteger         := iOdometer.BorderMargin;
  BorderStyleRadioGroup.AsInteger    := ord(iOdometer.BorderStyle);
  BackGroundColorPicker.Color        := iOdometer.BackGroundColor;
  ValueEdit.AsFloat                  := iOdometer.Value;
  AutoFrameRateCheckBox.AsBoolean    := iOdometer.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger      := iOdometer.UpdateFrameRate;

  ShowTenthsCheckBox.AsBoolean       := iOdometer.ShowTenths;
  ShowDecimalPointCheckBox.AsBoolean := iOdometer.ShowDecimalPoint;
  TenthsBackGroundColorPicker.Color  := iOdometer.TenthsBackGroundColor;
  TenthsDigitCountEdit.AsInteger     := iOdometer.TenthsDigitCount;

  DigitCountEdit.AsInteger           := iOdometer.DigitsCount;
  DigitWidthEdit.AsInteger           := iOdometer.DigitWidth;
  DigitsBackGroundColorPicker.Color  := iOdometer.DigitBackGroundColor;
  DigitBorderShowCheckBox.AsBoolean  := iOdometer.DigitBorderShow;
  DigitBorderColorPicker.Color       := iOdometer.DigitBorderColor;

  UpLoadOPCProperties(iOdometer, iOPCBrowserPanel);

  TenthsFontPicker.Font.Assign(iOdometer.TenthsFont);
  DigitsFontPicker.Font.Assign(iOdometer.DigitFont);
end;
//****************************************************************************************************************************************************
procedure TiOdometerComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iOdometer : TiOdometer;
begin
  iOdometer := Component as TiOdometer;

  iOdometer.AutoSize              := AutoSizeCheckBox.AsBoolean;
  iOdometer.Transparent           := TransparentCheckBox.AsBoolean;
  iOdometer.BorderMargin          := BorderMarginEdit.AsInteger;
  iOdometer.BorderStyle           := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iOdometer.BackGroundColor       := BackGroundColorPicker.Color;
  iOdometer.Value                 := ValueEdit.AsFloat;
  iOdometer.AutoFrameRate         := AutoFrameRateCheckBox.AsBoolean;
  iOdometer.UpdateFrameRate       := UpdateFrameRateEdit.AsInteger;

  iOdometer.ShowTenths            := ShowTenthsCheckBox.AsBoolean;
  iOdometer.ShowDecimalPoint      := ShowDecimalPointCheckBox.AsBoolean;
  iOdometer.TenthsBackGroundColor := TenthsBackGroundColorPicker.Color;
  iOdometer.TenthsDigitCount      := TenthsDigitCountEdit.AsInteger;

  iOdometer.DigitsCount           := DigitCountEdit.AsInteger;
  iOdometer.DigitWidth            := DigitWidthEdit.AsInteger;
  iOdometer.DigitBackGroundColor  := DigitsBackGroundColorPicker.Color;
  iOdometer.DigitBorderShow       := DigitBorderShowCheckBox.AsBoolean;
  iOdometer.DigitBorderColor      := DigitBorderColorPicker.Color;      

  DownLoadOPCProperties(iOdometer, iOPCBrowserPanel);

  iOdometer.TenthsFont.Assign(TenthsFontPicker.Font);
  iOdometer.DigitFont.Assign(DigitsFontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
