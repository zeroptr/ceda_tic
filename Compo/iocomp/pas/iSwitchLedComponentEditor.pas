{*******************************************************}
{                                                       }
{       TiSwitchLedComponentEditor                      }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSwitchLedComponentEditor;{$endif}
{$ifdef iCLX}unit QiSwitchLedComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSwitchLed,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSwitchLed,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiSwitchLedComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    ActiveCheckBox: TiComponentEditorCheckBox;
    ActiveColorPicker: TiComponentEditorColorPicker;
    Label3: TLabel;
    AutoLedSizeCheckBox: TiComponentEditorCheckBox;
    EnabledCheckBox: TiComponentEditorCheckBox;
    IndicatorGroupBox: TGroupBox;
    Label1: TLabel;
    IndicatorHeightEdit: TiComponentEditorEdit;
    IndicatorHeightUpDown: TiUpDown;
    Label2: TLabel;
    IndicatorWidthEdit: TiComponentEditorEdit;
    IndicatorWidthUpDown: TiUpDown;
    Label4: TLabel;
    IndicatorMarginEdit: TiComponentEditorEdit;
    IndicatorMarginUpDown: TiUpDown;
    ShowFocusRectCheckBox: TiComponentEditorCheckBox;
    CaptionGroupBox: TGroupBox;
    Label8: TLabel;
    CaptionEdit: TiComponentEditorEdit;
    Label6: TLabel;
    CaptionMarginEdit: TiComponentEditorEdit;
    CaptionMarginUpDown: TiUpDown;
    CaptionFontPicker: TiComponentEditorFontPicker;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    WordWrapCheckBox: TiComponentEditorCheckBox;
    BorderGroupBox: TGroupBox;
    Label9: TLabel;
    BorderSizeUpDown: TiUpDown;
    BorderSizeEdit: TiComponentEditorEdit;
    Label20: TLabel;
    IndicatorAlignmentComboBox: TiComponentEditorComboBox;
    Label11: TLabel;
    CaptionAlignmentComboBox: TiComponentEditorComboBox;
    Label10: TLabel;
    BorderHighlightColorPicker: TiComponentEditorColorPicker;
    Label12: TLabel;
    BorderShadowColorPicker: TiComponentEditorColorPicker;
    GlyphTabSheet: TTabSheet;
    ImagePicker: TiComponentEditorOpenPicker;
    GlyphPreviewGroupBox: TGroupBox;
    ImagePreview: TImage;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    procedure ImagePickerChange(Sender: TObject);
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSwitchLedComponentEditorForm: TiSwitchLedComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSwitchLedComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSwitchLed.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSwitchLedComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSwitchLed : TiSwitchLed;
begin
  iSwitchLed := Component as TiSwitchLed;

  ActiveCheckBox.AsBoolean               := iSwitchLed.Active;
  AutoLedSizeCheckBox.AsBoolean          := iSwitchLed.AutoLedSize;
  WordWrapCheckBox.AsBoolean             := iSwitchLed.WordWrap;
  ShowFocusRectCheckBox.AsBoolean        := iSwitchLed.ShowFocusRect;
  EnabledCheckBox.AsBoolean              := iSwitchLed.Enabled;
  ActiveColorPicker.Color                := iSwitchLed.ActiveColor;
  BackGroundColorPicker.Color            := iSwitchLed.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean        := iSwitchLed.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger          := iSwitchLed.UpdateFrameRate;

  CaptionEdit.AsString                   := iSwitchLed.Caption;
  CaptionMarginEdit.AsInteger            := iSwitchLed.CaptionMargin;
  CaptionAlignmentComboBox.AsInteger     := Ord(iSwitchLed.CaptionAlignment);

  IndicatorAlignmentComboBox.AsInteger   := ord(iSwitchLed.IndicatorAlignment);
  IndicatorHeightEdit.AsInteger          := iSwitchLed.IndicatorHeight;
  IndicatorWidthEdit.AsInteger           := iSwitchLed.IndicatorWidth;
  IndicatorMarginEdit.AsInteger          := iSwitchLed.IndicatorMargin;

  BorderSizeEdit.AsInteger               := iSwitchLed.BorderSize;
  BorderHighlightColorPicker.Color       := iSwitchLed.BorderHighlightColor;
  BorderShadowColorPicker.Color          := iSwitchLed.BorderShadowColor;

  UpLoadOPCProperties(iSwitchLed, iOPCBrowserPanel);

  CaptionFontPicker.Font.Assign(iSwitchLed.CaptionFont);
  ImagePreview.Picture.Assign(iSwitchLed.Glyph);
end;
//****************************************************************************************************************************************************
procedure TiSwitchLedComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSwitchLed : TiSwitchLed;
begin
  iSwitchLed := Component as TiSwitchLed;

  iSwitchLed.Active               := ActiveCheckBox.AsBoolean;
  iSwitchLed.AutoLedSize          := AutoLedSizeCheckBox.AsBoolean;
  iSwitchLed.WordWrap             := WordWrapCheckBox.AsBoolean;
  iSwitchLed.ShowFocusRect        := ShowFocusRectCheckBox.AsBoolean;
  iSwitchLed.Enabled              := EnabledCheckBox.AsBoolean;
  iSwitchLed.ActiveColor          := ActiveColorPicker.Color;
  iSwitchLed.BackGroundColor      := BackGroundColorPicker.Color;
  iSwitchLed.AutoFrameRate        := AutoFrameRateCheckBox.AsBoolean;
  iSwitchLed.UpdateFrameRate      := UpdateFrameRateEdit.AsInteger;

  iSwitchLed.Caption              := CaptionEdit.AsString;
  iSwitchLed.CaptionMargin        := CaptionMarginEdit.AsInteger;
  iSwitchLed.CaptionAlignment     := TiSwitchLedCaptionAlignment(CaptionAlignmentComboBox.AsInteger);

  iSwitchLed.IndicatorAlignment   := TiSideAlignment(IndicatorAlignmentComboBox.AsInteger);
  iSwitchLed.IndicatorHeight      := IndicatorHeightEdit.AsInteger;
  iSwitchLed.IndicatorWidth       := IndicatorWidthEdit.AsInteger;
  iSwitchLed.IndicatorMargin      := IndicatorMarginEdit.AsInteger;

  iSwitchLed.BorderSize           := BorderSizeEdit.AsInteger;
  iSwitchLed.BorderHighlightColor := BorderHighlightColorPicker.Color;
  iSwitchLed.BorderShadowColor    := BorderShadowColorPicker.Color;

  DownLoadOPCProperties(iSwitchLed, iOPCBrowserPanel);

  iSwitchLed.CaptionFont.Assign(CaptionFontPicker.Font);
  iSwitchLed.Glyph.Assign(ImagePreview.Picture);
end;
//****************************************************************************************************************************************************
procedure TiSwitchLedComponentEditorForm.ImagePickerChange(Sender: TObject);
begin
  ImagePreview.Picture.LoadFromFile(ImagePicker.FileName);
end;
//****************************************************************************************************************************************************
end.
