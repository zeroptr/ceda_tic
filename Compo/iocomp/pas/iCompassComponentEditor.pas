{*******************************************************}
{                                                       }
{       TiCompassComponentEditor                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}


{$ifdef iVCL}unit  iCompassComponentEditor;{$endif}
{$ifdef iCLX}unit QiCompassComponentEditor;{$endif}
                    
interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iCompass,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiCompass,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiCompassComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label3: TLabel;
    Label12: TLabel;
    DirectionEdit: TiComponentEditorEdit;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    PointerGroupBox: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label29: TLabel;
    PointerMarginEdit: TiComponentEditorEdit;
    PointerMarginUpDown: TiUpDown;
    PointerSizeEdit: TiComponentEditorEdit;
    PointerSizeUpDown: TiUpDown;
    PointerStyleRadioGroup: TiComponentEditorRadioGroup;
    DirectionDisplayGroupBox: TGroupBox;
    Label21: TLabel;
    DirectionDisplayPrecisionEdit: TiComponentEditorEdit;
    DirectionDisplayPrecisionUpDown: TiUpDown;
    ShowDirectionDisplayCheckBox: TiComponentEditorCheckBox;
    Label1: TLabel;
    BackGroundColorPicker : TiComponentEditorColorPicker;
    ScaleBackGroundColorPicker : TiComponentEditorColorPicker;
    PointerColorPicker : TiComponentEditorColorPicker;
    DirectionDisplayFontPicker : TiComponentEditorFontPicker;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    TickTabSheet: TTabSheet;
    Label28: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    Label10: TLabel;
    TickMarginUpDown: TiUpDown;
    TickLengthUpDown: TiUpDown;
    TickWidthUpDown: TiUpDown;
    TickColorPicker: TiComponentEditorColorPicker;
    LabelGroupBox: TGroupBox;
    Label15: TLabel;
    Label19: TLabel;
    TickLabelInnerMarginUpDown: TiUpDown;
    TickLabelOuterMarginUpDown: TiUpDown;
    TickLabelFontPicker: TiComponentEditorFontPicker;
    TickLabelInnerMarginEdit: TiComponentEditorEdit;
    TickLabelOuterMarginEdit: TiComponentEditorEdit;
    TickMarginEdit: TiComponentEditorEdit;
    TickLengthEdit: TiComponentEditorEdit;
    TickWidthEdit: TiComponentEditorEdit;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    CaptionsTabSheet: TTabSheet;
    NEdit: TiComponentEditorEdit;
    NEEdit: TiComponentEditorEdit;
    EEdit: TiComponentEditorEdit;
    WEdit: TiComponentEditorEdit;
    SWEdit: TiComponentEditorEdit;
    SEdit: TiComponentEditorEdit;
    SEEdit: TiComponentEditorEdit;
    NWEdit: TiComponentEditorEdit;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iCompassComponentEditorForm: TiCompassComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiCompassComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiCompass.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiCompassComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iCompass : TiCompass;
begin
  iCompass := Component as TiCompass;

  DirectionEdit.AsFloat                    := iCompass.Direction;
  CachedDrawingCheckBox.AsBoolean          := iCompass.CachedDrawing;
  TransparentCheckBox.AsBoolean            := iCompass.Transparent;
  AutoFrameRateCheckBox.AsBoolean          := iCompass.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger            := iCompass.UpdateFrameRate;

  BorderStyleRadioGroup.AsInteger          := ord(iCompass.BorderStyle);
  BackGroundColorPicker.Color              := iCompass.BackGroundColor;
  ScaleBackGroundColorPicker.Color         := iCompass.ScaleBackGroundColor;

  NEdit.AsString                           := iCompass.NCaption;
  NWEdit.AsString                          := iCompass.NWCaption;
  WEdit.AsString                           := iCompass.WCaption;
  SWEdit.AsString                          := iCompass.SWCaption;
  SEdit.AsString                           := iCompass.SCaption;
  SEEdit.AsString                          := iCompass.SECaption;
  EEdit.AsString                           := iCompass.ECaption;
  NEEdit.AsString                          := iCompass.NECaption;

  PointerSizeEdit.AsInteger                := iCompass.PointerSize;
  PointerMarginEdit.AsInteger              := iCompass.PointerMargin;
  PointerColorPicker.Color                 := iCompass.PointerColor;
  PointerStyleRadioGroup.AsInteger         := ord(iCompass.PointerStyle);

  ShowDirectionDisplayCheckBox.AsBoolean   := iCompass.ShowDirectionDisplay;
  DirectionDisplayPrecisionEdit.AsInteger  := iCompass.DirectionDisplayPrecision;

  TickMarginEdit.AsInteger                 := iCompass.TickMargin;
  TickColorPicker.Color                    := iCompass.TickColor;
  TickLengthEdit.AsInteger                 := iCompass.TickLength;
  TickWidthEdit.AsInteger                  := iCompass.TickWidth;

  TickLabelInnerMarginEdit.AsInteger       := iCompass.TickLabelInnerMargin;
  TickLabelOuterMarginEdit.AsInteger       := iCompass.TickLabelOuterMargin;

  UpLoadOPCProperties(iCompass, iOPCBrowserPanel);

  TickLabelFontPicker.Font.Assign       (iCompass.TickLabelFont);
  DirectionDisplayFontPicker.Font.Assign(iCompass.DirectionDisplayFont);
end;
//****************************************************************************************************************************************************
procedure TiCompassComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iCompass : TiCompass;
begin
  iCompass := Component as TiCompass;

  iCompass.Direction                 := DirectionEdit.AsFloat;
  iCompass.CachedDrawing             := CachedDrawingCheckBox.AsBoolean;
  iCompass.Transparent               := TransparentCheckBox.AsBoolean;
  iCompass.AutoFrameRate             := AutoFrameRateCheckBox.AsBoolean;
  iCompass.UpdateFrameRate           := UpdateFrameRateEdit.AsInteger;

  iCompass.BorderStyle               := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iCompass.BackGroundColor           := BackGroundColorPicker.Color;
  iCompass.ScaleBackGroundColor      := ScaleBackGroundColorPicker.Color;

  iCompass.NCaption                  := NEdit.AsString;
  iCompass.NWCaption                 := NWEdit.AsString;
  iCompass.WCaption                  := WEdit.AsString;
  iCompass.SWCaption                 := SWEdit.AsString;
  iCompass.SCaption                  := SEdit.AsString;
  iCompass.SECaption                 := SEEdit.AsString;
  iCompass.ECaption                  := EEdit.AsString;
  iCompass.NECaption                 := NEEdit.AsString;

  iCompass.PointerSize               := PointerSizeEdit.AsInteger;
  iCompass.PointerMargin             := PointerMarginEdit.AsInteger;
  iCompass.PointerColor              := PointerColorPicker.Color;
  iCompass.PointerStyle              := TiCompassPointerStyle(PointerStyleRadioGroup.AsInteger);

  iCompass.ShowDirectionDisplay      := ShowDirectionDisplayCheckBox.AsBoolean;
  iCompass.DirectionDisplayPrecision := DirectionDisplayPrecisionEdit.AsInteger;

  iCompass.TickMargin                := TickMarginEdit.AsInteger;
  iCompass.TickColor                 := TickColorPicker.Color;
  iCompass.TickLength                := TickLengthEdit.AsInteger;
  iCompass.TickWidth                 := TickWidthEdit.AsInteger;

  iCompass.TickLabelInnerMargin      := TickLabelInnerMarginEdit.AsInteger;
  iCompass.TickLabelOuterMargin      := TickLabelOuterMarginEdit.AsInteger;

  DownLoadOPCProperties(iCompass, iOPCBrowserPanel);

  iCompass.TickLabelFont.Assign       (TickLabelFontPicker.Font);
  iCompass.DirectionDisplayFont.Assign(DirectionDisplayFontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
