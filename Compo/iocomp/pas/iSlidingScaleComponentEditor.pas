{*******************************************************}
{                                                       }
{       TiSlidingScaleComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSlidingScaleComponentEditor;{$endif}
{$ifdef iCLX}unit QiSlidingScaleComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSlidingScale,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSlidingScale,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSlidingScaleComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label42: TLabel;
    PositionEdit: TiComponentEditorEdit;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    DesignTabSheet: TTabSheet;
    DesignPageControl: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    DesingTitleTabSheet: TTabSheet;
    DesignPointerTabSheet: TTabSheet;
    DesignScaleTabSheet: TTabSheet;
    DesignTicksTabSheet: TTabSheet;
    Label14: TLabel;
    Label17: TLabel;
    PointerSizeUpDown: TiUpDown;
    PointerColorPicker: TiComponentEditorColorPicker;
    PointerOrientationRadioGroup: TiComponentEditorRadioGroup;
    PointerLineGroupBox: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    PointerLineWidthUpDown: TiUpDown;
    PointerLineColorPicker: TiComponentEditorColorPicker;
    PointerLineWidthEdit: TiComponentEditorEdit;
    PointerSizeEdit: TiComponentEditorEdit;
    PointerStyleRadioGroup: TiComponentEditorRadioGroup;
    Label10: TLabel;
    Label40: TLabel;
    TitleMarginEdit: TiComponentEditorEdit;
    TitleTextEdit: TiComponentEditorEdit;
    TitleFontPicker: TiComponentEditorFontPicker;
    TitleAlignmentRadioGroup: TiComponentEditorRadioGroup;
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
    OrientationRadioGroup: TiComponentEditorRadioGroup;
    OuterMarginGroupBox: TGroupBox;
    OuterMarginLeftUpDown: TiUpDown;
    OuterMarginTopUpDown: TiUpDown;
    OuterMarginBottomUpDown: TiUpDown;
    OuterMarginRightUpDown: TiUpDown;
    OuterMarginLeftEdit: TiComponentEditorEdit;
    OuterMarginTopEdit: TiComponentEditorEdit;
    OuterMarginBottomEdit: TiComponentEditorEdit;
    OuterMarginRightEdit: TiComponentEditorEdit;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    Label4: TLabel;
    ScaleSpanEdit: TiComponentEditorEdit;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label76: TLabel;
    TransparentCheckBox: TiComponentEditorCheckBox;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    ReverseScaleCheckBox: TiComponentEditorCheckBox;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSlidingScaleComponentEditorForm: TiSlidingScaleComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSlidingScaleComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSlidingScale.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSlidingScaleComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSlidingScale : TiSlidingScale;
begin
  iSlidingScale := Component as TiSlidingScale;
  //--------------------------- General ------------------------------------------------------------------------
  PositionEdit.AsFloat                      := iSlidingScale.Position;
  ReverseScaleCheckBox.AsBoolean            := iSlidingScale.ReverseScale;
  CachedDrawingCheckBox.AsBoolean           := iSlidingScale.CachedDrawing;
  TransparentCheckBox.AsBoolean             := iSlidingScale.Transparent;
  OrientationRadioGroup.ItemIndex           := ord(iSlidingScale.Orientation);
  BorderStyleRadioGroup.ItemIndex           := ord(iSlidingScale.BorderStyle);
  BackGroundColorPicker.Color               := iSlidingScale.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean           := iSlidingScale.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger             := iSlidingScale.UpdateFrameRate;

  OuterMarginLeftEdit.AsInteger             := iSlidingScale.OuterMarginLeft;
  OuterMarginTopEdit.AsInteger              := iSlidingScale.OuterMarginTop;
  OuterMarginRightEdit.AsInteger            := iSlidingScale.OuterMarginRight;
  OuterMarginBottomEdit.AsInteger           := iSlidingScale.OuterMarginBottom;

  TitleTextEdit.AsString                    := iSlidingScale.TitleText;
  TitleMarginEdit.AsFloat                   := iSlidingScale.TitleMargin;
  TitleAlignmentRadioGroup.AsInteger        := ord(iSlidingScale.TitleAlignment);
  //--------------------------- Pointer ------------------------------------------------------------------------
  PointerSizeEdit.AsInteger                 := iSlidingScale.PointerSize;
  PointerColorPicker.Color                  := iSlidingScale.PointerColor;
  PointerOrientationRadioGroup.AsInteger    := ord(iSlidingScale.PointerOrientation);
  PointerStyleRadioGroup.AsInteger          := ord(iSlidingScale.PointerStyle);
  PointerLineWidthEdit.AsInteger            := iSlidingScale.PointerLineWidth;
  PointerLineColorPicker.Color              := iSlidingScale.PointerLineColor;
  //---------------------------  Scale -------------------------------------------------------------------------
  ScaleSpanEdit.AsFloat                     := iSlidingScale.ScaleSpan;
  ScaleAntiAliasedEnabledCheckBox.AsBoolean := iSlidingScale.ScaleAntiAliasEnabled;
  ScaleShadowEnabledCheckBox.AsBoolean      := iSlidingScale.ScaleShadowEnabled;
  ScaleAlignStyleRadioGroup.AsInteger       := ord(iSlidingScale.ScaleAlignStyle);
  ScaleOrientationRadioGroup.AsInteger      := ord(iSlidingScale.ScaleOrientation);
  ScaleShadowColorPicker.Color              := iSlidingScale.ScaleShadowColor;
  ScaleBackGroundColorPicker.Color          := iSlidingScale.ScaleBackgroundColor;
  //--------------------------- Ticks --------------------------------------------------------------------------
  TickMajorCountEdit.AsInteger              := iSlidingScale.TickMajorCount;
  TickMajorLengthEdit.AsInteger             := iSlidingScale.TickMajorLength;
  TickMajorWidthEdit.AsInteger              := iSlidingScale.TickMajorWidth;
  TickMajorColorPicker.Color                := iSlidingScale.TickMajorColor;
  TickMajorLabelMarginEdit.AsFloat          := iSlidingScale.TickMajorLabelMargin;
  TickMajorLabelPrecisionEdit.AsInteger     := iSlidingScale.TickMajorLabelPrecision;

  ShowMidTicksCheckBox.AsBoolean            := iSlidingScale.ShowMidTicks;
  TickMidLengthEdit.AsInteger               := iSlidingScale.TickMidLength;
  TickMidWidthEdit.AsInteger                := iSlidingScale.TickMidWidth;
  TickMidColorPicker.Color                  := iSlidingScale.TickMidColor;
  ShowMidTickLabelsCheckBox.AsBoolean       := iSlidingScale.ShowMidTickLabels;
  TickMidLabelMarginEdit.AsFloat            := iSlidingScale.TickMidLabelMargin;
  TickMidLabelPrecisionEdit.AsInteger       := iSlidingScale.TickMidLabelPrecision;

  TickMinorCountEdit.AsInteger              := iSlidingScale.TickMinorCount;
  TickMinorLengthEdit.AsInteger             := iSlidingScale.TickMinorLength;
  TickMinorWidthEdit.AsInteger              := iSlidingScale.TickMinorWidth;
  TickMinorColorPicker.Color                := iSlidingScale.TickMinorColor;

  TitleFontPicker.Font.Assign         (iSlidingScale.TitleFont);
  TickMajorLabelFontPicker.Font.Assign(iSlidingScale.TickMajorLabelFont);
  TickMidLabelFontPicker.Font.Assign  (iSlidingScale.TickMidLabelFont);

  UpLoadOPCProperties(iSlidingScale, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSlidingScaleComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSlidingScale : TiSlidingScale;
begin
  iSlidingScale := Component as TiSlidingScale;
  //--------------------------- General ------------------------------------------------------------------------
  iSlidingScale.Position                := PositionEdit.AsFloat;
  iSlidingScale.ReverseScale            := ReverseScaleCheckBox.AsBoolean;
  iSlidingScale.CachedDrawing           := CachedDrawingCheckBox.AsBoolean;
  iSlidingScale.Transparent             := TransparentCheckBox.AsBoolean;
  iSlidingScale.Orientation             := TiOrientation(OrientationRadioGroup.AsInteger);
  iSlidingScale.BorderStyle             := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iSlidingScale.BackGroundColor         := BackGroundColorPicker.Color;
  iSlidingScale.AutoFrameRate           := AutoFrameRateCheckBox.AsBoolean;
  iSlidingScale.UpdateFrameRate         := UpdateFrameRateEdit.AsInteger;

  iSlidingScale.OuterMarginLeft         := OuterMarginLeftEdit.AsInteger;
  iSlidingScale.OuterMarginTop          := OuterMarginTopEdit.AsInteger;
  iSlidingScale.OuterMarginRight        := OuterMarginRightEdit.AsInteger;
  iSlidingScale.OuterMarginBottom       := OuterMarginBottomEdit.AsInteger;

  iSlidingScale.TitleText               := TitleTextEdit.AsString;
  iSlidingScale.TitleMargin             := TitleMarginEdit.AsFloat;
  iSlidingScale.TitleAlignment          := TiAlignmentSideVertical(TitleAlignmentRadioGroup.AsInteger);
  //--------------------------- Pointer ------------------------------------------------------------------------
  iSlidingScale.PointerSize             := PointerSizeEdit.AsInteger;
  iSlidingScale.PointerColor            := PointerColorPicker.Color;
  iSlidingScale.PointerOrientation      := TiOrientationSide(PointerOrientationRadioGroup.AsInteger);
  iSlidingScale.PointerStyle            := TiSlidingScalePointerStyle(PointerStyleRadioGroup.AsInteger);
  iSlidingScale.PointerLineWidth        := PointerLineWidthEdit.AsInteger;
  iSlidingScale.PointerLineColor        := PointerLineColorPicker.Color;
  //---------------------------  Scale -------------------------------------------------------------------------
  iSlidingScale.ScaleSpan               := ScaleSpanEdit.AsFloat;
  iSlidingScale.ScaleAntiAliasEnabled   := ScaleAntiAliasedEnabledCheckBox.AsBoolean;
  iSlidingScale.ScaleShadowEnabled      := ScaleShadowEnabledCheckBox.AsBoolean;
  iSlidingScale.ScaleAlignStyle         := TiScaleAlignStyle(ScaleAlignStyleRadioGroup.AsInteger);
  iSlidingScale.ScaleOrientation        := TiOrientationSide(ScaleOrientationRadioGroup.AsInteger);
  iSlidingScale.ScaleShadowColor        := ScaleShadowColorPicker.Color;
  iSlidingScale.ScaleBackgroundColor    := ScaleBackGroundColorPicker.Color;
  //--------------------------- Ticks --------------------------------------------------------------------------
  iSlidingScale.TickMajorCount          := TickMajorCountEdit.AsInteger;
  iSlidingScale.TickMajorLength         := TickMajorLengthEdit.AsInteger;
  iSlidingScale.TickMajorWidth          := TickMajorWidthEdit.AsInteger;
  iSlidingScale.TickMajorColor          := TickMajorColorPicker.Color;
  iSlidingScale.TickMajorLabelMargin    := TickMajorLabelMarginEdit.AsFloat;
  iSlidingScale.TickMajorLabelPrecision := TickMajorLabelPrecisionEdit.AsInteger;

  iSlidingScale.ShowMidTicks            := ShowMidTicksCheckBox.AsBoolean;
  iSlidingScale.TickMidLength           := TickMidLengthEdit.AsInteger;
  iSlidingScale.TickMidWidth            := TickMidWidthEdit.AsInteger;
  iSlidingScale.TickMidColor            := TickMidColorPicker.Color;
  iSlidingScale.ShowMidTickLabels       := ShowMidTickLabelsCheckBox.AsBoolean;
  iSlidingScale.TickMidLabelMargin      := TickMidLabelMarginEdit.AsFloat;
  iSlidingScale.TickMidLabelPrecision   := TickMidLabelPrecisionEdit.AsInteger;

  iSlidingScale.TickMinorCount          := TickMinorCountEdit.AsInteger;
  iSlidingScale.TickMinorLength         := TickMinorLengthEdit.AsInteger;
  iSlidingScale.TickMinorWidth          := TickMinorWidthEdit.AsInteger;
  iSlidingScale.TickMinorColor          := TickMinorColorPicker.Color;

  iSlidingScale.TitleFont.Assign         (TitleFontPicker.Font);
  iSlidingScale.TickMajorLabelFont.Assign(TickMajorLabelFontPicker.Font);
  iSlidingScale.TickMidLabelFont.Assign  (TickMidLabelFontPicker.Font);

  DownLoadOPCProperties(iSlidingScale, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
