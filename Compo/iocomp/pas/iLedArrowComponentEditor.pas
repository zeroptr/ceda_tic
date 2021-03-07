{*******************************************************}
{                                                       }
{       TiLedArrowComponentEditor                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedArrowComponentEditor;{$endif}
{$ifdef iCLX}unit QiLedArrowComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLedArrow,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLedArrow,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLedArrowComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    ActiveCheckBox: TiComponentEditorCheckBox;
    BevelStyleRadioGroup: TiComponentEditorRadioGroup;
    ActiveColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    ArrowGroupBox: TGroupBox;
    Label3: TLabel;
    ArrowBodyLengthEdit: TiComponentEditorEdit;
    Label1: TLabel;
    ArrowHeadSizeEdit: TiComponentEditorEdit;
    StyleRadioGroup: TiComponentEditorRadioGroup;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    InactiveColorPicker: TiComponentEditorColorPicker;
    Label2: TLabel;
    AutoInactiveColorCheckBox: TiComponentEditorCheckBox;
    TransparentCheckBox: TiComponentEditorCheckBox;
    ArrowHeadSizeUpDown: TiUpDown;
    ArrowBodyLengthUpDown: TiUpDown;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
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
  iLedArrowComponentEditorForm: TiLedArrowComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLedArrowComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLedArrow.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLedArrowComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLedArrow : TiLedArrow;
begin
  iLedArrow := Component as TiLedArrow;

  ActiveCheckBox.AsBoolean            := iLedArrow.Active;
  AutoSizeCheckBox.AsBoolean          := iLedArrow.AutoSize;
  AutoInactiveColorCheckBox.AsBoolean := iLedArrow.AutoInactiveColor;
  TransparentCheckBox.AsBoolean       := iLedArrow.Transparent;
  AutoFrameRateCheckBox.AsBoolean     := iLedArrow.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger       := iLedArrow.UpdateFrameRate;

  ActiveColorPicker.Color             := iLedArrow.ActiveColor;
  InactiveColorPicker.Color           := iLedArrow.InactiveColor;
  BackGroundColorPicker.Color         := iLedArrow.BackGroundColor;

  StyleRadioGroup.AsInteger           := ord(iLedArrow.Style);

  ArrowHeadSizeEdit.AsInteger         := iLedArrow.ArrowHeadSize;
  ArrowBodyLengthEdit.AsInteger       := iLedArrow.ArrowBodyLength;

  BevelStyleRadioGroup.AsInteger      := ord(iLedArrow.BevelStyle);

  UpLoadOPCProperties(iLedArrow, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiLedArrowComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLedArrow : TiLedArrow;
begin
  iLedArrow := Component as TiLedArrow;

  iLedArrow.Active            := ActiveCheckBox.AsBoolean;
  iLedArrow.AutoSize          := AutoSizeCheckBox.AsBoolean;
  iLedArrow.AutoInactiveColor := AutoInactiveColorCheckBox.AsBoolean;
  iLedArrow.Transparent       := TransparentCheckBox.AsBoolean;
  iLedArrow.AutoFrameRate     := AutoFrameRateCheckBox.AsBoolean;
  iLedArrow.UpdateFrameRate   := UpdateFrameRateEdit.AsInteger;

  iLedArrow.ActiveColor       := ActiveColorPicker.Color;
  iLedArrow.InactiveColor     := InactiveColorPicker.Color;
  iLedArrow.BackGroundColor   := BackGroundColorPicker.Color;

  iLedArrow.Style             := TiLedArrowStyle(StyleRadioGroup.AsInteger);

  iLedArrow.ArrowHeadSize     := ArrowHeadSizeEdit.AsInteger;
  iLedArrow.ArrowBodyLength   := ArrowBodyLengthEdit.AsInteger;

  iLedArrow.BevelStyle        := TiBevelStyle(BevelStyleRadioGroup.AsInteger);

  DownLoadOPCProperties(iLedArrow, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
