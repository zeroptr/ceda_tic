{*******************************************************}
{                                                       }
{       iDualCompassComponentEditor                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iDualCompassComponentEditor;{$endif}
{$ifdef iCLX}unit QiDualCompassComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iDualCompass,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiDualCompass,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiDualCompassComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label31: TLabel;
    ScalePointersCenterDisplayTabSheet: TTabSheet;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    Label41: TLabel;
    OuterMarginEdit: TiComponentEditorEdit;
    OuterMarginUpDown: TiUpDown;
    Label42: TLabel;
    TransparentCheckBox: TiComponentEditorCheckBox;
    Label43: TLabel;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    UpdateFrameRateUpDown: TiUpDown;
    LabelTopGroupBox: TGroupBox;
    Label1: TLabel;
    LabelTopTextEdit: TiComponentEditorEdit;
    Label12: TLabel;
    LabelTopMarginEdit: TiComponentEditorEdit;
    LabelBottomGroupBox: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    LabelBottomTextEdit: TiComponentEditorEdit;
    LabelBottomMarginEdit: TiComponentEditorEdit;
    ScaleGroupBox: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    ScaleLabelMarginEdit: TiComponentEditorEdit;
    CenterDisplayGroupBox: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    CenterDisplayHeightEdit: TiComponentEditorEdit;
    Label6: TLabel;
    CenterDisplayWidthEdit: TiComponentEditorEdit;
    Label7: TLabel;
    CenterDisplayPositionEdit: TiComponentEditorEdit;
    Label8: TLabel;
    CenterDisplayPrecisionEdit: TiComponentEditorEdit;
    CenterDisplayPrecisionUpDown: TiUpDown;
    Pointer1GroupBox: TGroupBox;
    Pointer2GroupBox: TGroupBox;
    Label9: TLabel;
    Pointer1PositionEdit: TiComponentEditorEdit;
    Label19: TLabel;
    Pointer1WidthEdit: TiComponentEditorEdit;
    Pointer1WidthUpDown: TiUpDown;
    Label21: TLabel;
    Label22: TLabel;
    Pointer2PositionEdit: TiComponentEditorEdit;
    Label24: TLabel;
    Pointer2HeightEdit: TiComponentEditorEdit;
    Label25: TLabel;
    Pointer2WidthEdit: TiComponentEditorEdit;
    ShowPointer1CheckBox: TiComponentEditorCheckBox;
    ShowPointer2CheckBox: TiComponentEditorCheckBox;
    ShowCenterDisplayCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    InnerColorPicker: TiComponentEditorColorPicker;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    CenterDisplayBackGroundColorPicker: TiComponentEditorColorPicker;
    ScaleBackGroundColorPicker: TiComponentEditorColorPicker;
    Pointer1ColorPicker: TiComponentEditorColorPicker;
    ScaleFontPicker: TiComponentEditorFontPicker;
    LabelTopFontPicker: TiComponentEditorFontPicker;
    LabelBottomFontPicker: TiComponentEditorFontPicker;
    CenterDisplayFontPicker: TiComponentEditorFontPicker;
    ThemeTabSheet: TTabSheet;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
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
  iDualCompassComponentEditorForm: TiDualCompassComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiDualCompassComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiDualCompass.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiDualCompassComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iDualCompass : TiDualCompass;
begin
  iDualCompass := Component as TiDualCompass;

  //--------------------------- General ------------------------------------------------------------------------
  OuterMarginEdit.AsInteger                := iDualCompass.OuterMargin;
  CachedDrawingCheckBox.AsBoolean          := iDualCompass.CachedDrawing;
  TransparentCheckBox.AsBoolean            := iDualCompass.Transparent;
  AutoFrameRateCheckBox.AsBoolean          := iDualCompass.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger            := iDualCompass.UpdateFrameRate;

  NEdit.AsString                           := iDualCompass.NCaption;
  NWEdit.AsString                          := iDualCompass.NWCaption;
  WEdit.AsString                           := iDualCompass.WCaption;
  SWEdit.AsString                          := iDualCompass.SWCaption;
  SEdit.AsString                           := iDualCompass.SCaption;
  SEEdit.AsString                          := iDualCompass.SECaption;
  EEdit.AsString                           := iDualCompass.ECaption;
  NEEdit.AsString                          := iDualCompass.NECaption;

  LabelTopTextEdit.AsString                := iDualCompass.LabelTopText;
  LabelTopMarginEdit.AsFloat               := iDualCompass.LabelTopMargin;

  LabelBottomTextEdit.AsString             := iDualCompass.LabelBottomText;
  LabelBottomMarginEdit.AsFloat            := iDualCompass.LabelBottomMargin;

  BorderStyleRadioGroup.AsInteger          := ord(iDualCompass.BorderStyle);
  InnerColorPicker.Color                   := iDualCompass.InnerColor;
  BackGroundColorPicker.Color              := iDualCompass.BackGroundColor;
  //--------------------------- Scale/Pointers/Center Display   -------------------------------------------------
  ShowCenterDisplayCheckBox.AsBoolean      := iDualCompass.ShowCenterDisplay;
  CenterDisplayPositionEdit.AsFloat        := iDualCompass.CenterDisplayPosition;
  CenterDisplayPrecisionEdit.AsInteger     := iDualCompass.CenterDisplayPrecision;
  CenterDisplayHeightEdit.AsFloat          := iDualCompass.CenterDisplayHeight;
  CenterDisplayWidthEdit.AsFloat           := iDualCompass.CenterDisplayWidth;
  CenterDisplayBackGroundColorPicker.Color := iDualCompass.CenterDisplayBackGroundColor;

  ScaleLabelMarginEdit.AsFloat             := iDualCompass.ScaleLabelMargin;
  ScaleBackGroundColorPicker.Color         := iDualCompass.ScaleBackGroundColor;

  ShowPointer1CheckBox.AsBoolean           := iDualCompass.ShowPointer1;
  Pointer1PositionEdit.AsFloat             := iDualCompass.Pointer1Position;
  Pointer1WidthEdit.AsInteger              := iDualCompass.Pointer1Width;
  Pointer1ColorPicker.Color                := iDualCompass.Pointer1Color;

  ShowPointer2CheckBox.AsBoolean           := iDualCompass.ShowPointer2;
  Pointer2PositionEdit.AsFloat             := iDualCompass.Pointer2Position;
  Pointer2HeightEdit.AsFloat               := iDualCompass.Pointer2Height;
  Pointer2WidthEdit.AsFloat                := iDualCompass.Pointer2Width;

  UpLoadOPCProperties(iDualCompass, iOPCBrowserPanel);

  ScaleFontPicker.Font.Assign        (iDualCompass.ScaleFont);
  LabelTopFontPicker.Font.Assign     (iDualCompass.LabelTopFont);
  LabelBottomFontPicker.Font.Assign  (iDualCompass.LabelBottomFont);
  CenterDisplayFontPicker.Font.Assign(iDualCompass.CenterDisplayFont);
end;
//****************************************************************************************************************************************************
procedure TiDualCompassComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iDualCompass : TiDualCompass;
begin
  iDualCompass := Component as TiDualCompass;

  //--------------------------- General ------------------------------------------------------------------------
  iDualCompass.OuterMargin                  := OuterMarginEdit.AsInteger;
  iDualCompass.CachedDrawing                := CachedDrawingCheckBox.AsBoolean;
  iDualCompass.Transparent                  := TransparentCheckBox.AsBoolean;
  iDualCompass.AutoFrameRate                := AutoFrameRateCheckBox.AsBoolean;
  iDualCompass.UpdateFrameRate              := UpdateFrameRateEdit.AsInteger;

  iDualCompass.NCaption                     := NEdit.AsString;
  iDualCompass.NWCaption                    := NWEdit.AsString;
  iDualCompass.WCaption                     := WEdit.AsString;
  iDualCompass.SWCaption                    := SWEdit.AsString;
  iDualCompass.SCaption                     := SEdit.AsString;
  iDualCompass.SECaption                    := SEEdit.AsString;
  iDualCompass.ECaption                     := EEdit.AsString;
  iDualCompass.NECaption                    := NEEdit.AsString;

  iDualCompass.LabelTopText                 := LabelTopTextEdit.AsString;
  iDualCompass.LabelTopMargin               := LabelTopMarginEdit.AsFloat;

  iDualCompass.LabelBottomText              := LabelBottomTextEdit.AsString;
  iDualCompass.LabelBottomMargin            := LabelBottomMarginEdit.AsFloat;

  iDualCompass.BorderStyle                  := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iDualCompass.InnerColor                   := InnerColorPicker.Color;
  iDualCompass.BackGroundColor              := BackGroundColorPicker.Color;
  //--------------------------- Scale/Pointers/Center Display   -------------------------------------------------
  iDualCompass.ShowCenterDisplay            := ShowCenterDisplayCheckBox.AsBoolean;
  iDualCompass.CenterDisplayPosition        := CenterDisplayPositionEdit.AsFloat;
  iDualCompass.CenterDisplayPrecision       := CenterDisplayPrecisionEdit.AsInteger;
  iDualCompass.CenterDisplayHeight          := CenterDisplayHeightEdit.AsFloat;
  iDualCompass.CenterDisplayWidth           := CenterDisplayWidthEdit.AsFloat;
  iDualCompass.CenterDisplayBackGroundColor := CenterDisplayBackGroundColorPicker.Color;

  iDualCompass.ScaleLabelMargin             := ScaleLabelMarginEdit.AsFloat;
  iDualCompass.ScaleBackGroundColor         := ScaleBackGroundColorPicker.Color;

  iDualCompass.ShowPointer1                 := ShowPointer1CheckBox.AsBoolean;
  iDualCompass.Pointer1Position             := Pointer1PositionEdit.AsFloat;
  iDualCompass.Pointer1Width                := Pointer1WidthEdit.AsInteger;
  iDualCompass.Pointer1Color                := Pointer1ColorPicker.Color;

  iDualCompass.ShowPointer2                 := ShowPointer2CheckBox.AsBoolean;
  iDualCompass.Pointer2Position             := Pointer2PositionEdit.AsFloat;
  iDualCompass.Pointer2Height               := Pointer2HeightEdit.AsFloat;
  iDualCompass.Pointer2Width                := Pointer2WidthEdit.AsFloat;

  DownLoadOPCProperties(iDualCompass, iOPCBrowserPanel);

  iDualCompass.ScaleFont.Assign        (ScaleFontPicker.Font);
  iDualCompass.LabelTopFont.Assign     (LabelTopFontPicker.Font);
  iDualCompass.LabelBottomFont.Assign  (LabelBottomFontPicker.Font);
  iDualCompass.CenterDisplayFont.Assign(CenterDisplayFontPicker.Font);
end;
//****************************************************************************************************************************************************
end.
