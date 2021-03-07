{*******************************************************}
{                                                       }
{       TiLedMatrixComponentEditor                      }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLedMatrixComponentEditor;{$endif}
{$ifdef iCLX}unit QiLedMatrixComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLedMatrix,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLedMatrix,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLedMatrixComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    iAboutPanel1: TiAboutPanel;
    DesignTabSheet: TTabSheet;
    DesignPageControl: TiComponentEditorPageControl;
    DesignGeneralTabSheet: TTabSheet;
    DesignIndicatorTabSheet: TTabSheet;
    Label7: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    IndicatorHeightUpDown: TiUpDown;
    IndicatorWidthUpDown: TiUpDown;
    IndicatorActiveColorPicker: TiComponentEditorColorPicker;
    IndicatorHeightEdit: TiComponentEditorEdit;
    IndicatorBevelStyleRadioGroup: TiComponentEditorRadioGroup;
    IndicatorWidthEdit: TiComponentEditorEdit;
    IndicatorStyleRadioGroup: TiComponentEditorRadioGroup;
    CaptionGroupBox: TGroupBox;
    IndicatorCaptionActiveFontPicker: TiComponentEditorFontPicker;
    IndicatorCaptionInactiveFontPicker: TiComponentEditorFontPicker;
    IndicatorShowReflectionCheckBox: TiComponentEditorCheckBox;
    SpacingGroupBox: TGroupBox;
    Label6: TLabel;
    Label8: TLabel;
    SpacingHorizontalUpDown: TiUpDown;
    SpacingVerticalUpDown: TiUpDown;
    SpacingHorizontalEdit: TiComponentEditorEdit;
    SpacingVerticalEdit: TiComponentEditorEdit;
    ArrayGroupBox: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    RowCountUpDown: TiUpDown;
    ColCountUpDown: TiUpDown;
    RowCountEdit: TiComponentEditorEdit;
    ColCountEdit: TiComponentEditorEdit;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    Label5: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    Label4: TLabel;
    OuterMarginUpDown: TiUpDown;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    TransparentCheckBox: TiComponentEditorCheckBox;
    OuterMarginEdit: TiComponentEditorEdit;
    CachedDrawingCheckBox: TiComponentEditorCheckBox;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    procedure IndicatorWidthEditChange(Sender: TObject);
    procedure IndicatorHeightEditChange(Sender: TObject);
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iLedMatrixComponentEditorForm: TiLedMatrixComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLedMatrixComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLedMatrix.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLedMatrixComponentEditorForm.IndicatorWidthEditChange(Sender: TObject);
begin
  if IndicatorStyleRadioGroup.AsInteger = 0 then IndicatorHeightEdit.AsInteger := IndicatorWidthEdit.AsInteger;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrixComponentEditorForm.IndicatorHeightEditChange(Sender: TObject);
begin
  if IndicatorStyleRadioGroup.AsInteger = 0 then IndicatorWidthEdit.AsInteger := IndicatorHeightEdit.AsInteger;
end;
//****************************************************************************************************************************************************
procedure TiLedMatrixComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iLedMatrix : TiLedMatrix;
begin
  iLedMatrix := Component as TiLedMatrix;

  AutoSizeCheckBox.AsBoolean                := iLedMatrix.AutoSize;
  CachedDrawingCheckBox.AsBoolean           := iLedMatrix.CachedDrawing;
  TransparentCheckBox.AsBoolean             := iLedMatrix.Transparent;
  OuterMarginEdit.AsInteger                 := iLedMatrix.OuterMargin;
  BackGroundColorPicker.Color               := iLedMatrix.BackGroundColor;
  BorderStyleRadioGroup.AsInteger           := ord(iLedMatrix.BorderStyle);
  AutoFrameRateCheckBox.AsBoolean           := iLedMatrix.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger             := iLedMatrix.UpdateFrameRate;

  SpacingHorizontalEdit.AsInteger           := iLedMatrix.SpacingHorizontal;
  SpacingVerticalEdit.AsInteger             := iLedMatrix.SpacingVertical;

  ColCountEdit.AsInteger                    := iLedMatrix.ColCount;
  RowCountEdit.AsInteger                    := iLedMatrix.RowCount;

  //IndicatorStyle must be set before Width and Height
  IndicatorStyleRadioGroup.AsInteger        := ord(iLedMatrix.IndicatorStyle);

  IndicatorWidthEdit.AsInteger              := iLedMatrix.IndicatorWidth;
  IndicatorHeightEdit.AsInteger             := iLedMatrix.IndicatorHeight;
  IndicatorShowReflectionCheckBox.AsBoolean := iLedMatrix.IndicatorShowReflection;
  IndicatorBevelStyleRadioGroup.AsInteger   := ord(iLedMatrix.IndicatorBevelStyle);
  IndicatorActiveColorPicker.Color          := iLedMatrix.IndicatorActiveColor;

  IndicatorCaptionActiveFontPicker.Font.Assign  (iLedMatrix.IndicatorCaptionActiveFont);
  IndicatorCaptionInactiveFontPicker.Font.Assign(iLedMatrix.IndicatorCaptionInactiveFont);

  UpLoadOPCProperties(iLedMatrix, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiLedMatrixComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iLedMatrix : TiLedMatrix;
begin
  iLedMatrix := Component as TiLedMatrix;

  iLedMatrix.AutoSize                := AutoSizeCheckBox.AsBoolean;
  iLedMatrix.CachedDrawing           := CachedDrawingCheckBox.AsBoolean;
  iLedMatrix.Transparent             := TransparentCheckBox.AsBoolean;
  iLedMatrix.OuterMargin             := OuterMarginEdit.AsInteger;
  iLedMatrix.BackGroundColor         := BackGroundColorPicker.Color;
  iLedMatrix.BorderStyle             := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iLedMatrix.AutoFrameRate           := AutoFrameRateCheckBox.AsBoolean;
  iLedMatrix.UpdateFrameRate         := UpdateFrameRateEdit.AsInteger;

  iLedMatrix.SpacingHorizontal       := SpacingHorizontalEdit.AsInteger;
  iLedMatrix.SpacingVertical         := SpacingVerticalEdit.AsInteger;

  iLedMatrix.ColCount                := ColCountEdit.AsInteger;
  iLedMatrix.RowCount                := RowCountEdit.AsInteger;

  //IndicatorStyle must be set before Width and Height
  iLedMatrix.IndicatorStyle          := TiLedMatrixIndiatorStyle(IndicatorStyleRadioGroup.AsInteger);

  iLedMatrix.IndicatorWidth          := IndicatorWidthEdit.AsInteger;
  iLedMatrix.IndicatorHeight         := IndicatorHeightEdit.AsInteger;
  iLedMatrix.IndicatorShowReflection := IndicatorShowReflectionCheckBox.AsBoolean;
  iLedMatrix.IndicatorBevelStyle     := TiBevelStyle(IndicatorBevelStyleRadioGroup.AsInteger);
  iLedMatrix.IndicatorActiveColor    := IndicatorActiveColorPicker.Color;

  iLedMatrix.IndicatorCaptionActiveFont.Assign(IndicatorCaptionActiveFontPicker.Font);
  iLedMatrix.IndicatorCaptionInactiveFont.Assign(IndicatorCaptionInactiveFontPicker.Font);

  DownLoadOPCProperties(iLedMatrix, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
