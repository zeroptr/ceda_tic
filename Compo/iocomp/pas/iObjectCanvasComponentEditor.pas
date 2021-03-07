{*******************************************************}
{                                                       }
{       TiObjectCanvasComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iObjectCanvasComponentEditor;{$endif}
{$ifdef iCLX}unit QiObjectCanvasComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorForm,  iTypes,  iObjectCanvas,{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorForm, QiTypes, QiObjectCanvas,{$ENDIF}

  {$IFDEF iVCL} iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,   iAboutPanel, iComponentEditorImageEditorPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel, QiComponentEditorImageEditorPanel;{$ENDIF}

type
  TiObjectCanvasComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    OriginGroupBox: TGroupBox;
    Label12: TLabel;
    Label19: TLabel;
    OriginXEdit: TiComponentEditorEdit;
    OriginYEdit: TiComponentEditorEdit;
    DisplayRangeGroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DisplayRangeXEdit: TiComponentEditorEdit;
    DisplayRangeYEdit: TiComponentEditorEdit;
    DefaultTabSheet: TTabSheet;
    BrushGroupBox: TGroupBox;
    DefaultBrushColorPicker: TiComponentEditorColorPicker;
    Label3: TLabel;
    DefaultBrushStyleRadioGroup: TiComponentEditorRadioGroup;
    PenGroupBox: TGroupBox;
    DefaultPenColorPicker: TiComponentEditorColorPicker;
    Label4: TLabel;
    DefaultPenStyleRadioGroup: TiComponentEditorRadioGroup;
    Label5: TLabel;
    DefaultPenWidthEdit: TiComponentEditorEdit;
    DefaultPenWidthUpDown: TiUpDown;
    DefaultFontPicker: TiComponentEditorFontPicker;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    ImagesTabSheet: TTabSheet;
    ImageEditorPanel0: TiComponentEditorImageEditorPanel;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iObjectCanvasComponentEditorForm: TiObjectCanvasComponentEditorForm;

implementation

type
  TiObjectCanvasAccess = class(TiObjectCanvas) end;
{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiObjectCanvasComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiObjectCanvas.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiObjectCanvasComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iObjectCanvas : TiObjectCanvas;
  FontStyle     : TFontStyles;
begin
  iObjectCanvas := Component as TiObjectCanvas;

  OriginXEdit.AsFloat                   := iObjectCanvas.OriginX;
  OriginYEdit.AsFloat                   := iObjectCanvas.OriginY;

  DisplayRangeXEdit.AsFloat             := iObjectCanvas.DisplayRangeX;
  DisplayRangeYEdit.AsFloat             := iObjectCanvas.DisplayRangeY;

  BackGroundColorPicker.Color           := iObjectCanvas.BackGroundColor;
  BorderStyleRadioGroup.AsInteger       := ord(iObjectCanvas.BorderStyle);
  TransparentCheckBox.Checked           := iObjectCanvas.Transparent;
  AutoFrameRateCheckBox.AsBoolean       := iObjectCanvas.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iObjectCanvas.UpdateFrameRate;

  DefaultBrushColorPicker.Color         := iObjectCanvas.DefaultBrushColor;
  DefaultBrushStyleRadioGroup.AsInteger := ord(iObjectCanvas.DefaultBrushStyle);

  DefaultPenColorPicker.Color           := iObjectCanvas.DefaultPenColor;
  DefaultPenStyleRadioGroup.AsInteger   := ord(iObjectCanvas.DefaultPenStyle);
  DefaultPenWidthEdit.AsInteger         := iObjectCanvas.DefaultPenWidth;

  FontStyle := [];
  if iObjectCanvas.DefaultFontBold      then Include(FontStyle, fsBold);
  if iObjectCanvas.DefaultFontItalic    then Include(FontStyle, fsItalic);
  if iObjectCanvas.DefaultFontUnderLine then Include(FontStyle, fsUnderline);
  if iObjectCanvas.DefaultFontStrikeOut then Include(FontStyle, fsStrikeOut);

  ImageEditorPanel0.UpLoad(TiObjectCanvasAccess(iObjectCanvas).ImageList);

  DefaultFontPicker.Font.Style := FontStyle;
  DefaultFontPicker.Font.Name  := iObjectCanvas.DefaultFontName;
  DefaultFontPicker.Font.Size  := iObjectCanvas.DefaultFontSize;
  DefaultFontPicker.Font.Color := iObjectCanvas.DefaultFontColor;
end;
//****************************************************************************************************************************************************
procedure TiObjectCanvasComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iObjectCanvas : TiObjectCanvas;
begin
  iObjectCanvas := Component as TiObjectCanvas;

  iObjectCanvas.OriginX           := OriginXEdit.AsFloat;
  iObjectCanvas.OriginY           := OriginYEdit.AsFloat;

  iObjectCanvas.DisplayRangeX     := DisplayRangeXEdit.AsFloat;
  iObjectCanvas.DisplayRangeY     := DisplayRangeYEdit.AsFloat;

  iObjectCanvas.BackGroundColor   := BackGroundColorPicker.Color;
  iObjectCanvas.BorderStyle       := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iObjectCanvas.Transparent       := TransparentCheckBox.Checked;
  iObjectCanvas.AutoFrameRate     := AutoFrameRateCheckBox.AsBoolean;
  iObjectCanvas.UpdateFrameRate   := UpdateFrameRateEdit.AsInteger;

  iObjectCanvas.DefaultBrushColor := DefaultBrushColorPicker.Color;
  iObjectCanvas.DefaultBrushStyle := TBrushStyle(DefaultBrushStyleRadioGroup.AsInteger);

  iObjectCanvas.DefaultPenColor   := DefaultPenColorPicker.Color;
  iObjectCanvas.DefaultPenStyle   := TPenStyle(DefaultPenStyleRadioGroup.AsInteger);
  iObjectCanvas.DefaultPenWidth   := DefaultPenWidthEdit.AsInteger;

  ImageEditorPanel0.DownLoad(TiObjectCanvasAccess(iObjectCanvas).ImageList);

  iObjectCanvas.DefaultFontName   := DefaultFontPicker.Font.Name;
  iObjectCanvas.DefaultFontSize   := DefaultFontPicker.Font.Size;
  iObjectCanvas.DefaultFontColor  := DefaultFontPicker.Font.Color;

  if fsBold      in DefaultFontPicker.Font.Style then iObjectCanvas.DefaultFontBold      := True else iObjectCanvas.DefaultFontBold      := False;
  if fsItalic    in DefaultFontPicker.Font.Style then iObjectCanvas.DefaultFontItalic    := True else iObjectCanvas.DefaultFontItalic    := False;
  if fsUnderline in DefaultFontPicker.Font.Style then iObjectCanvas.DefaultFontUnderLine := True else iObjectCanvas.DefaultFontUnderLine := False;
  if fsStrikeOut in DefaultFontPicker.Font.Style then iObjectCanvas.DefaultFontStrikeOut := True else iObjectCanvas.DefaultFontStrikeOut := False;
end;
//****************************************************************************************************************************************************
end.
