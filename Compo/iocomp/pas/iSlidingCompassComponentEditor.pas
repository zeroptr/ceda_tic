{*******************************************************}
{                                                       }
{       TiSlidingCompassComponentEditor                 }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSlidingCompassComponentEditor;{$endif}
{$ifdef iCLX}unit QiSlidingCompassComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSlidingCompass,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSlidingCompass,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSlidingCompassComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
    DesignTabSheet: TTabSheet;
    DesignPageControl: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    DesignPointersTabSheet: TTabSheet;
    DesignScaleTabSheet: TTabSheet;
    DesignTicksTabSheet: TTabSheet;
    Pointer1GroupBox: TGroupBox;
    Label14: TLabel;
    Label17: TLabel;
    Pointer1SizeUpDown: TiUpDown;
    Pointer1ColorPicker: TiComponentEditorColorPicker;
    PointerLineGroupBox: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Pointer1LineWidthUpDown: TiUpDown;
    Pointer1LineColorPicker: TiComponentEditorColorPicker;
    Pointer1LineWidthEdit: TiComponentEditorEdit;
    Pointer1SizeEdit: TiComponentEditorEdit;
    Pointer1StyleRadioGroup: TiComponentEditorRadioGroup;
    Pointer2GroupBox: TGroupBox;
    Label18: TLabel;
    Label20: TLabel;
    Pointer2SizeUpDown: TiUpDown;
    Pointer2ColorPicker: TiComponentEditorColorPicker;
    Pointer2LineGroupBox: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Pointer2LineWidthUpDown: TiUpDown;
    Pointer2LineColorPicker: TiComponentEditorColorPicker;
    Pointer2LineWidthEdit: TiComponentEditorEdit;
    Pointer2SizeEdit: TiComponentEditorEdit;
    Pointer2StyleRadioGroup: TiComponentEditorRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    ScaleBackGroundColorPicker: TiComponentEditorColorPicker;
    ScaleShadowColorPicker: TiComponentEditorColorPicker;
    ScaleAlignStyleRadioGroup: TiComponentEditorRadioGroup;
    ScaleAntiAliasedEnabledCheckBox: TiComponentEditorCheckBox;
    ScaleOrientationRadioGroup: TiComponentEditorRadioGroup;
    ScaleShadowEnabledCheckBox: TiComponentEditorCheckBox;
    MajorGroupBox: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label24: TLabel;
    Label1: TLabel;
    TickMajorCountUpDown: TiUpDown;
    TickMajorLengthUpDown: TiUpDown;
    TickMajorWidthUpDown: TiUpDown;
    TickMajorColorPicker: TiComponentEditorColorPicker;
    TickMajorCountEdit: TiComponentEditorEdit;
    TickMajorLengthEdit: TiComponentEditorEdit;
    TickMajorWidthEdit: TiComponentEditorEdit;
    TickMajorLabelGroupBox: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    TickMajorLabelPrecisionUpDown: TiUpDown;
    TickMajorLabelFontPicker: TiComponentEditorFontPicker;
    TickMajorLabelPrecisionEdit: TiComponentEditorEdit;
    TickMajorLabelMarginEdit: TiComponentEditorEdit;
    MinorGroupBox: TGroupBox;
    Label9: TLabel;
    Label12: TLabel;
    Label19: TLabel;
    Label25: TLabel;
    TickMinorCountUpDown: TiUpDown;
    TickMinorLengthUpDown: TiUpDown;
    TickMinorWidthUpDown: TiUpDown;
    TickMinorColorPicker: TiComponentEditorColorPicker;
    TickMinorCountEdit: TiComponentEditorEdit;
    TickMinorLengthEdit: TiComponentEditorEdit;
    TickMinorWidthEdit: TiComponentEditorEdit;
    MidGroupBox: TGroupBox;
    Label21: TLabel;
    Label26: TLabel;
    Label35: TLabel;
    TickMidLengthUpDown: TiUpDown;
    TickMidWidthUpDown: TiUpDown;
    TickMidColorPicker: TiComponentEditorColorPicker;
    TickMidLengthEdit: TiComponentEditorEdit;
    TickMidWidthEdit: TiComponentEditorEdit;
    ShowMidTicksCheckBox: TiComponentEditorCheckBox;
    TickMidLabelGroupBox: TGroupBox;
    Label11: TLabel;
    Label13: TLabel;
    TickMidLabelPrecisionUpDown: TiUpDown;
    TickMidLabelFontPicker: TiComponentEditorFontPicker;
    TickMidLabelPrecisionEdit: TiComponentEditorEdit;
    TickMidLabelMarginEdit: TiComponentEditorEdit;
    ShowMidTickLabelsCheckBox: TiComponentEditorCheckBox;
    Label31: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    OuterMarginGroupBox: TGroupBox;
    OuterMarginLeftUpDown: TiUpDown;
    OuterMarginTopUpDown: TiUpDown;
    OuterMarginBottomUpDown: TiUpDown;
    OuterMarginRightUpDown: TiUpDown;
    OuterMarginLeftEdit: TiComponentEditorEdit;
    OuterMarginTopEdit: TiComponentEditorEdit;
    OuterMarginBottomEdit: TiComponentEditorEdit;
    OuterMarginRightEdit: TiComponentEditorEdit;
    OrientationRadioGroup: TiComponentEditorRadioGroup;
    PointerOrientationRadioGroup: TiComponentEditorRadioGroup;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    DesignTitleTabSheet: TTabSheet;
    Label10: TLabel;
    Label40: TLabel;
    TitleMarginEdit: TiComponentEditorEdit;
    TitleTextEdit: TiComponentEditorEdit;
    TitleFontPicker: TiComponentEditorFontPicker;
    TitleAlignmentRadioGroup: TiComponentEditorRadioGroup;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label4: TLabel;
    ScaleSpanEdit: TiComponentEditorEdit;
    Label42: TLabel;
    Pointer1PositionEdit: TiComponentEditorEdit;
    Label27: TLabel;
    Pointer2PositionEdit: TiComponentEditorEdit;
    ReverseScaleCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSlidingCompassComponentEditorForm: TiSlidingCompassComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSlidingCompassComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSlidingCompass.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSlidingCompassComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSlidingCompass : TiSlidingCompass;
begin
  iSlidingCompass := Component as TiSlidingCompass;
  //--------------------------- General ------------------------------------------------------------------------
  ReverseScaleCheckBox.AsBoolean               := iSlidingCompass.ReverseScale;
  CachedDrawingCheckBox.AsBoolean              := iSlidingCompass.CachedDrawing;
  TransparentCheckBox.AsBoolean                := iSlidingCompass.Transparent;
  OrientationRadioGroup.AsInteger              := ord(iSlidingCompass.Orientation);
  PointerOrientationRadioGroup.AsInteger       := ord(iSlidingCompass.PointerOrientation);
  BorderStyleRadioGroup.AsInteger              := ord(iSlidingCompass.BorderStyle);
  BackGroundColorPicker.Color                  := iSlidingCompass.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean              := iSlidingCompass.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger                := iSlidingCompass.UpdateFrameRate;

  OuterMarginLeftEdit.AsInteger                := iSlidingCompass.OuterMarginLeft;
  OuterMarginTopEdit.AsInteger                 := iSlidingCompass.OuterMarginTop;
  OuterMarginRightEdit.AsInteger               := iSlidingCompass.OuterMarginRight;
  OuterMarginBottomEdit.AsInteger              := iSlidingCompass.OuterMarginBottom;

  TitleTextEdit.AsString                       := iSlidingCompass.TitleText;
  TitleMarginEdit.AsFloat                      := iSlidingCompass.TitleMargin;
  TitleAlignmentRadioGroup.AsInteger           := ord(iSlidingCompass.TitleAlignment);
  //--------------------------- Pointer ------------------------------------------------------------------------
  Pointer1PositionEdit.AsFloat                 := iSlidingCompass.Pointer1Position;
  Pointer1SizeEdit.AsInteger                   := iSlidingCompass.Pointer1Size;
  Pointer1ColorPicker.Color                    := iSlidingCompass.Pointer1Color;
  Pointer1StyleRadioGroup.AsInteger            := ord(iSlidingCompass.Pointer1Style);
  Pointer1LineWidthEdit.AsInteger              := iSlidingCompass.Pointer1LineWidth;
  Pointer1LineColorPicker.Color                := iSlidingCompass.Pointer1LineColor;

  Pointer2PositionEdit.AsFloat                 := iSlidingCompass.Pointer2Position;
  Pointer2SizeEdit.AsInteger                   := iSlidingCompass.Pointer2Size;
  Pointer2ColorPicker.Color                    := iSlidingCompass.Pointer2Color;
  Pointer2StyleRadioGroup.AsInteger            := ord(iSlidingCompass.Pointer2Style);
  Pointer2LineWidthEdit.AsInteger              := iSlidingCompass.Pointer2LineWidth;
  Pointer2LineColorPicker.Color                := iSlidingCompass.Pointer2LineColor;
  //---------------------------  Scale -------------------------------------------------------------------------
  ScaleSpanEdit.AsFloat                        := iSlidingCompass.ScaleSpan;
  ScaleAntiAliasedEnabledCheckBox.AsBoolean    := iSlidingCompass.ScaleAntiAliasEnabled;
  ScaleShadowEnabledCheckBox.AsBoolean         := iSlidingCompass.ScaleShadowEnabled;
  ScaleAlignStyleRadioGroup.AsInteger          := ord(iSlidingCompass.ScaleAlignStyle);
  ScaleOrientationRadioGroup.AsInteger         := ord(iSlidingCompass.ScaleOrientation);
  ScaleShadowColorPicker.Color                 := iSlidingCompass.ScaleShadowColor;
  ScaleBackGroundColorPicker.Color             := iSlidingCompass.ScaleBackgroundColor;
  //--------------------------- Ticks --------------------------------------------------------------------------
  TickMajorCountEdit.AsInteger                 := iSlidingCompass.TickMajorCount;
  TickMajorLengthEdit.AsInteger                := iSlidingCompass.TickMajorLength;
  TickMajorWidthEdit.AsInteger                 := iSlidingCompass.TickMajorWidth;
  TickMajorColorPicker.Color                   := iSlidingCompass.TickMajorColor;
  TickMajorLabelMarginEdit.AsFloat             := iSlidingCompass.TickMajorLabelMargin;
  TickMajorLabelPrecisionEdit.AsInteger        := iSlidingCompass.TickMajorLabelPrecision;

  ShowMidTicksCheckBox.AsBoolean               := iSlidingCompass.ShowMidTicks;
  TickMidLengthEdit.AsInteger                  := iSlidingCompass.TickMidLength;
  TickMidWidthEdit.AsInteger                   := iSlidingCompass.TickMidWidth;
  TickMidColorPicker.Color                     := iSlidingCompass.TickMidColor;
  ShowMidTickLabelsCheckBox.AsBoolean          := iSlidingCompass.ShowMidTickLabels;
  TickMidLabelMarginEdit.AsFloat               := iSlidingCompass.TickMidLabelMargin;
  TickMidLabelPrecisionEdit.AsInteger          := iSlidingCompass.TickMidLabelPrecision;

  TickMinorCountEdit.AsInteger                 := iSlidingCompass.TickMinorCount;
  TickMinorLengthEdit.AsInteger                := iSlidingCompass.TickMinorLength;
  TickMinorWidthEdit.AsInteger                 := iSlidingCompass.TickMinorWidth;
  TickMinorColorPicker.Color                   := iSlidingCompass.TickMinorColor;

  TitleFontPicker.Font.Assign         (iSlidingCompass.TitleFont);
  TickMajorLabelFontPicker.Font.Assign(iSlidingCompass.TickMajorLabelFont);
  TickMidLabelFontPicker.Font.Assign  (iSlidingCompass.TickMidLabelFont);

  UpLoadOPCProperties(iSlidingCompass, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSlidingCompassComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSlidingCompass : TiSlidingCompass;
begin
  iSlidingCompass := Component as TiSlidingCompass;
  //--------------------------- General ------------------------------------------------------------------------
  iSlidingCompass.ReverseScale            := ReverseScaleCheckBox.AsBoolean;
  iSlidingCompass.CachedDrawing           := CachedDrawingCheckBox.AsBoolean;
  iSlidingCompass.Transparent             := TransparentCheckBox.AsBoolean;
  iSlidingCompass.Orientation             := TiOrientation(OrientationRadioGroup.AsInteger);
  iSlidingCompass.PointerOrientation      := TiOrientationSide(PointerOrientationRadioGroup.AsInteger);
  iSlidingCompass.BorderStyle             := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSlidingCompass.BackGroundColor         := BackGroundColorPicker.Color;
  iSlidingCompass.AutoFrameRate           := AutoFrameRateCheckBox.AsBoolean;
  iSlidingCompass.UpdateFrameRate         := UpdateFrameRateEdit.AsInteger;

  iSlidingCompass.OuterMarginLeft         := OuterMarginLeftEdit.AsInteger;
  iSlidingCompass.OuterMarginTop          := OuterMarginTopEdit.AsInteger;
  iSlidingCompass.OuterMarginRight        := OuterMarginRightEdit.AsInteger;
  iSlidingCompass.OuterMarginBottom       := OuterMarginBottomEdit.AsInteger;

  iSlidingCompass.TitleText               := TitleTextEdit.AsString;
  iSlidingCompass.TitleMargin             := TitleMarginEdit.AsFloat;
  iSlidingCompass.TitleAlignment          := TiAlignmentSideVertical(TitleAlignmentRadioGroup.AsInteger);
  //--------------------------- Pointer ------------------------------------------------------------------------
  iSlidingCompass.Pointer1Position        := Pointer1PositionEdit.AsFloat;
  iSlidingCompass.Pointer1Size            := Pointer1SizeEdit.AsInteger;
  iSlidingCompass.Pointer1Color           := Pointer1ColorPicker.Color;
  iSlidingCompass.Pointer1Style           := TiSlidingScalePointerStyle(Pointer1StyleRadioGroup.AsInteger);
  iSlidingCompass.Pointer1LineWidth       := Pointer1LineWidthEdit.AsInteger;
  iSlidingCompass.Pointer1LineColor       := Pointer1LineColorPicker.Color;

  iSlidingCompass.Pointer2Position        := Pointer2PositionEdit.AsFloat;
  iSlidingCompass.Pointer2Size            := Pointer2SizeEdit.AsInteger;
  iSlidingCompass.Pointer2Color           := Pointer2ColorPicker.Color;
  iSlidingCompass.Pointer2Style           := TiSlidingScalePointerStyle(Pointer2StyleRadioGroup.AsInteger);
  iSlidingCompass.Pointer2LineWidth       := Pointer2LineWidthEdit.AsInteger;
  iSlidingCompass.Pointer2LineColor       := Pointer2LineColorPicker.Color;
  //---------------------------  Scale -------------------------------------------------------------------------
  iSlidingCompass.ScaleSpan               := ScaleSpanEdit.AsFloat;
  iSlidingCompass.ScaleAntiAliasEnabled   := ScaleAntiAliasedEnabledCheckBox.AsBoolean;
  iSlidingCompass.ScaleShadowEnabled      := ScaleShadowEnabledCheckBox.AsBoolean;
  iSlidingCompass.ScaleAlignStyle         := TiScaleAlignStyle(ScaleAlignStyleRadioGroup.AsInteger);
  iSlidingCompass.ScaleOrientation        := TiOrientationSide(ScaleOrientationRadioGroup.AsInteger);
  iSlidingCompass.ScaleShadowColor        := ScaleShadowColorPicker.Color;
  iSlidingCompass.ScaleBackgroundColor    := ScaleBackGroundColorPicker.Color;
  //--------------------------- Ticks --------------------------------------------------------------------------
  iSlidingCompass.TickMajorCount          := TickMajorCountEdit.AsInteger;
  iSlidingCompass.TickMajorLength         := TickMajorLengthEdit.AsInteger;
  iSlidingCompass.TickMajorWidth          := TickMajorWidthEdit.AsInteger;
  iSlidingCompass.TickMajorColor          := TickMajorColorPicker.Color;
  iSlidingCompass.TickMajorLabelMargin    := TickMajorLabelMarginEdit.AsFloat;
  iSlidingCompass.TickMajorLabelPrecision := TickMajorLabelPrecisionEdit.AsInteger;

  iSlidingCompass.ShowMidTicks            := ShowMidTicksCheckBox.AsBoolean;
  iSlidingCompass.TickMidLength           := TickMidLengthEdit.AsInteger;
  iSlidingCompass.TickMidWidth            := TickMidWidthEdit.AsInteger;
  iSlidingCompass.TickMidColor            := TickMidColorPicker.Color;
  iSlidingCompass.ShowMidTickLabels       := ShowMidTickLabelsCheckBox.AsBoolean;
  iSlidingCompass.TickMidLabelMargin      := TickMidLabelMarginEdit.AsFloat;
  iSlidingCompass.TickMidLabelPrecision   := TickMidLabelPrecisionEdit.AsInteger;

  iSlidingCompass.TickMinorCount          := TickMinorCountEdit.AsInteger;
  iSlidingCompass.TickMinorLength         := TickMinorLengthEdit.AsInteger;
  iSlidingCompass.TickMinorWidth          := TickMinorWidthEdit.AsInteger;
  iSlidingCompass.TickMinorColor          := TickMinorColorPicker.Color;

  iSlidingCompass.TitleFont.Assign         (TitleFontPicker.Font);
  iSlidingCompass.TickMajorLabelFont.Assign(TickMajorLabelFontPicker.Font);
  iSlidingCompass.TickMidLabelFont.Assign  (TickMidLabelFontPicker.Font);

  DownLoadOPCProperties(iSlidingCompass, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
