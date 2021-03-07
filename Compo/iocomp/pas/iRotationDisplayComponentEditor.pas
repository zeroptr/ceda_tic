{*******************************************************}
{                                                       }
{       TiRotationDisplayComponentEditor                }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iRotationDisplayComponentEditor;{$endif}
{$ifdef iCLX}unit QiRotationDisplayComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iRotationDisplay,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiRotationDisplay,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}


type
  TiRotationDisplayComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    Label8: TLabel;
    RotationAngleEdit: TiComponentEditorEdit;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    PictureTabSheet: TTabSheet;
    ImagePicker: TiComponentEditorOpenPicker;
    GlyphPreviewGroupBox: TGroupBox;
    ImagePreview: TImage;
    procedure ImagePickerChange(Sender: TObject);
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iRotationDisplayComponentEditorForm: TiRotationDisplayComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiRotationDisplayComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiRotationDisplay.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplayComponentEditorForm.ImagePickerChange(Sender: TObject);
begin
  ImagePreview.Picture.LoadFromFile(ImagePicker.FileName);
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplayComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iRotationDisplay : TiRotationDisplay;
begin
  iRotationDisplay := Component as TiRotationDisplay;

  RotationAngleEdit.AsFloat       := iRotationDisplay.RotationAngle;
  AutoSizeCheckBox.AsBoolean      := iRotationDisplay.AutoSize;
  CachedDrawingCheckBox.AsBoolean := iRotationDisplay.CachedDrawing;
  BorderStyleRadioGroup.AsInteger := ord(iRotationDisplay.BorderStyle);
  BackGroundColorPicker.Color     := iRotationDisplay.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean := iRotationDisplay.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger   := iRotationDisplay.UpdateFrameRate;

  UpLoadOPCProperties(iRotationDisplay, iOPCBrowserPanel);

  ImagePreview.Picture.Assign(iRotationDisplay.Picture);
end;
//****************************************************************************************************************************************************
procedure TiRotationDisplayComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iRotationDisplay : TiRotationDisplay;
begin
  iRotationDisplay := Component as TiRotationDisplay;

  iRotationDisplay.RotationAngle   := RotationAngleEdit.AsFloat;
  iRotationDisplay.AutoSize        := AutoSizeCheckBox.AsBoolean;
  iRotationDisplay.CachedDrawing   := CachedDrawingCheckBox.AsBoolean;
  iRotationDisplay.BorderStyle     := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iRotationDisplay.BackGroundColor := BackGroundColorPicker.Color;
  iRotationDisplay.AutoFrameRate   := AutoFrameRateCheckBox.AsBoolean;
  iRotationDisplay.UpdateFrameRate := UpdateFrameRateEdit.AsInteger;

  DownLoadOPCProperties(iRotationDisplay, iOPCBrowserPanel);

  iRotationDisplay.Picture.Assign(ImagePreview.Picture);
end;
//****************************************************************************************************************************************************
end.


