{*******************************************************}
{                                                       }
{       TiTankComponentEditor                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iTankComponentEditor;{$endif}
{$ifdef iCLX}unit QiTankComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iTank,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiTank,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiTankComponentEditorForm = class(TiComponentEditorForm)
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
    Label2: TLabel;
    Label6: TLabel;
    PositionEdit: TiComponentEditorEdit;
    PositionMaxEdit: TiComponentEditorEdit;
    PositionMinEdit: TiComponentEditorEdit;
    Label3: TLabel;
    Label5: TLabel;
    TankColorPicker: TiComponentEditorColorPicker;
    TankShadowColorPicker: TiComponentEditorColorPicker;
    PointerGroupBox: TGroupBox;
    Label4: TLabel;
    PointerColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label124: TLabel;
    PointerStyleComboBox: TiComponentEditorComboBox;
    OrientationRadioGroup: TiComponentEditorRadioGroup;
    PointerReverseCheckBox: TiComponentEditorCheckBox;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AutoTankShadowColorCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iTankComponentEditorForm: TiTankComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiTankComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiTank.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiTankComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iTank : TiTank;
begin
  iTank := Component as TiTank;

  PositionEdit.AsFloat                  := iTank.Position;
  PositionMaxEdit.AsFloat               := iTank.PositionMax;
  PositionMinEdit.AsFloat               := iTank.PositionMin;

  TransparentCheckBox.AsBoolean         := iTank.Transparent;

  OrientationRadioGroup.AsInteger       := ord(iTank.Orientation);

  PointerColorPicker.Color              := iTank.PointerColor;
  PointerStyleComboBox.AsInteger        := ord(iTank.PointerStyle);
  PointerReverseCheckBox.AsBoolean      := iTank.PointerReverse;

  TankColorPicker.Color                 := iTank.TankColor;
  TankShadowColorPicker.Color           := iTank.TankShadowColor;
  BackGroundColorPicker.Color           := iTank.BackGroundColor;
  AutoTankShadowColorCheckBox.AsBoolean := iTank.AutoTankShadowColor;
  AutoFrameRateCheckBox.AsBoolean       := iTank.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iTank.UpdateFrameRate;

  UpLoadOPCProperties(iTank, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiTankComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iTank : TiTank;
begin
  iTank := Component as TiTank;

  iTank.Position            := PositionEdit.AsFloat;
  iTank.PositionMax         := PositionMaxEdit.AsFloat;
  iTank.PositionMin         := PositionMinEdit.AsFloat;

  iTank.Transparent         := TransparentCheckBox.AsBoolean;

  iTank.Orientation         := TiOrientation(OrientationRadioGroup.AsInteger);

  iTank.PointerColor        := PointerColorPicker.Color;
  iTank.PointerStyle        := TiTankPointerStyle(PointerStyleComboBox.AsInteger);
  iTank.PointerReverse      := PointerReverseCheckBox.AsBoolean;

  iTank.TankColor           := TankColorPicker.Color;
  iTank.TankShadowColor     := TankShadowColorPicker.Color;
  iTank.BackGroundColor     := BackGroundColorPicker.Color;
  iTank.AutoTankShadowColor := AutoTankShadowColorCheckBox.Checked;
  iTank.AutoFrameRate       := AutoFrameRateCheckBox.AsBoolean;
  iTank.UpdateFrameRate     := UpdateFrameRateEdit.AsInteger;

  DownLoadOPCProperties(iTank, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
