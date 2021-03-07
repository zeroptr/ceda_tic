{*******************************************************}
{                                                       }
{       TiSevenSegmentCharacterComponentEditor          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSevenSegmentCharacterComponentEditor;{$endif}
{$ifdef iCLX}unit QiSevenSegmentCharacterComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iSevenSegmentCharacter,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiSevenSegmentCharacter,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,  iRadioGroup,  iComponent,  iVCLComponent,  iCustomComponent,  iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel, QiRadioGroup, QiComponent, QiCLXComponent, QiCustomComponent, QiCheckBox;{$ENDIF}

type
  TiSevenSegmentCharacterComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    ShowOffSegmentsCheckBox: TiComponentEditorCheckBox;
    SegmentGroupBox: TGroupBox;
    Label2: TLabel;
    SegmentSeperationEdit: TiComponentEditorEdit;
    SegmentSeperationUpDown: TiUpDown;
    Label3: TLabel;
    SegmentSizeEdit: TiComponentEditorEdit;
    SegmentSizeUpDown: TiUpDown;
    Label4: TLabel;
    SegmentMarginEdit: TiComponentEditorEdit;
    SegmentMarginUpDown: TiUpDown;
    SegmentColorPicker: TiComponentEditorColorPicker;
    Label7: TLabel;
    AutoSizeCheckBox: TiComponentEditorCheckBox;
    SegmentBitsTabSheet: TTabSheet;
    SegFShape: TShape;
    SegEShape: TShape;
    SegBShape: TShape;
    SegCShape: TShape;
    SegAShape: TShape;
    SegGShape: TShape;
    SegDShape: TShape;
    UseSegmentBitsCheckBox: TiComponentEditorCheckBox;
    SegAOnCheckBox: TiComponentEditorCheckBox;
    SegBOnCheckBox: TiComponentEditorCheckBox;
    SegCOnCheckBox: TiComponentEditorCheckBox;
    SegDOnCheckBox: TiComponentEditorCheckBox;
    SegEOnCheckBox: TiComponentEditorCheckBox;
    SegFOnCheckBox: TiComponentEditorCheckBox;
    SegGOnCheckBox: TiComponentEditorCheckBox;
    Label1: TLabel;
    SegmentBitsEdit: TiComponentEditorEdit;
    AutoSegmentOffColorCheckBox: TiComponentEditorCheckBox;
    SegmentOffColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    TransparentCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    Label8: TLabel;
    Label9: TLabel;
    CharacterRadioGroup: TiComponentEditorRadioGroup;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    procedure SegmentBitsEditUpdate(Sender: TObject);
    procedure CalcSegmentBits(Sender: TObject);
  private
    procedure UpdateShapes;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iSevenSegmentCharacterComponentEditorForm: TiSevenSegmentCharacterComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacterComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiSevenSegmentCharacter.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacterComponentEditorForm.CalcSegmentBits(Sender: TObject);
var
  Value : Integer;
begin
  Value := 0;

  if SegAOnCheckBox.Checked then Value := Value or $01;
  if SegBOnCheckBox.Checked then Value := Value or $02;
  if SegCOnCheckBox.Checked then Value := Value or $04;
  if SegDOnCheckBox.Checked then Value := Value or $08;
  if SegEOnCheckBox.Checked then Value := Value or $10;
  if SegFOnCheckBox.Checked then Value := Value or $20;
  if SegGOnCheckBox.Checked then Value := Value or $40;

  SegmentBitsEdit.AsInteger := Value;

  UpdateShapes;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacterComponentEditorForm.SegmentBitsEditUpdate(Sender: TObject);
var
  Value : Integer;
begin
  Value := SegmentBitsEdit.AsInteger;

  SegAOnCheckBox.AsBoolean := Value and $01 <> 0;
  SegBOnCheckBox.AsBoolean := Value and $02 <> 0;
  SegCOnCheckBox.AsBoolean := Value and $04 <> 0;
  SegDOnCheckBox.AsBoolean := Value and $08 <> 0;
  SegEOnCheckBox.AsBoolean := Value and $10 <> 0;
  SegFOnCheckBox.AsBoolean := Value and $20 <> 0;
  SegGOnCheckBox.AsBoolean := Value and $40 <> 0;

  UpdateShapes;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacterComponentEditorForm.UpdateShapes;
begin
  if SegAOnCheckBox.AsBoolean then SegAShape.Brush.Color := clLime else SegAShape.Brush.Color := clGreen;
  if SegBOnCheckBox.AsBoolean then SegBShape.Brush.Color := clLime else SegBShape.Brush.Color := clGreen;
  if SegCOnCheckBox.AsBoolean then SegCShape.Brush.Color := clLime else SegCShape.Brush.Color := clGreen;
  if SegDOnCheckBox.AsBoolean then SegDShape.Brush.Color := clLime else SegDShape.Brush.Color := clGreen;
  if SegEOnCheckBox.AsBoolean then SegEShape.Brush.Color := clLime else SegEShape.Brush.Color := clGreen;
  if SegFOnCheckBox.AsBoolean then SegFShape.Brush.Color := clLime else SegFShape.Brush.Color := clGreen;
  if SegGOnCheckBox.AsBoolean then SegGShape.Brush.Color := clLime else SegGShape.Brush.Color := clGreen;
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacterComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iSevenSegmentCharacter : TiSevenSegmentCharacter;
begin
  iSevenSegmentCharacter := Component as TiSevenSegmentCharacter;

  AutoSizeCheckBox.AsBoolean            := iSevenSegmentCharacter.AutoSize;
  ShowOffSegmentsCheckBox.AsBoolean     := iSevenSegmentCharacter.ShowOffSegments;
  AutoSegmentOffColorCheckBox.AsBoolean := iSevenSegmentCharacter.AutoSegmentOffColor;
  TransparentCheckBox.AsBoolean         := iSevenSegmentCharacter.Transparent;
  BackGroundColorPicker.Color           := iSevenSegmentCharacter.BackGroundColor;
  AutoFrameRateCheckBox.AsBoolean       := iSevenSegmentCharacter.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger         := iSevenSegmentCharacter.UpdateFrameRate;

  SegmentSizeEdit.AsInteger             := iSevenSegmentCharacter.SegmentSize;
  SegmentSeperationEdit.AsInteger       := iSevenSegmentCharacter.SegmentSeperation;
  SegmentMarginEdit.AsInteger           := iSevenSegmentCharacter.SegmentMargin;
  SegmentColorPicker.Color              := iSevenSegmentCharacter.SegmentColor;
  SegmentOffColorPicker.Color           := iSevenSegmentCharacter.SegmentOffColor;

  CharacterRadioGroup.AsInteger         := ord(iSevenSegmentCharacter.Value);

  UseSegmentBitsCheckBox.AsBoolean      := iSevenSegmentCharacter.UseSegmentBits;
  SegmentBitsEdit.AsInteger             := iSevenSegmentCharacter.SegmentBits;

  UpLoadOPCProperties(iSevenSegmentCharacter, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
procedure TiSevenSegmentCharacterComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iSevenSegmentCharacter : TiSevenSegmentCharacter;
begin
  iSevenSegmentCharacter := Component as TiSevenSegmentCharacter;

  iSevenSegmentCharacter.AutoSize            := AutoSizeCheckBox.AsBoolean;
  iSevenSegmentCharacter.ShowOffSegments     := ShowOffSegmentsCheckBox.AsBoolean;
  iSevenSegmentCharacter.AutoSegmentOffColor := AutoSegmentOffColorCheckBox.AsBoolean;
  iSevenSegmentCharacter.Transparent         := TransparentCheckBox.AsBoolean;
  iSevenSegmentCharacter.BackGroundColor     := BackGroundColorPicker.Color;
  iSevenSegmentCharacter.AutoFrameRate       := AutoFrameRateCheckBox.AsBoolean;
  iSevenSegmentCharacter.UpdateFrameRate     := UpdateFrameRateEdit.AsInteger;

  iSevenSegmentCharacter.SegmentSize         := SegmentSizeEdit.AsInteger;
  iSevenSegmentCharacter.SegmentSeperation   := SegmentSeperationEdit.AsInteger;
  iSevenSegmentCharacter.SegmentMargin       := SegmentMarginEdit.AsInteger;
  iSevenSegmentCharacter.SegmentColor        := SegmentColorPicker.Color;
  iSevenSegmentCharacter.SegmentOffColor     := SegmentOffColorPicker.Color;

  iSevenSegmentCharacter.Value               := TSevenSegmentCharacter(CharacterRadioGroup.AsInteger);

  iSevenSegmentCharacter.UseSegmentBits      := UseSegmentBitsCheckBox.AsBoolean;
  iSevenSegmentCharacter.SegmentBits         := SegmentBitsEdit.AsInteger;

  DownLoadOPCProperties(iSevenSegmentCharacter, iOPCBrowserPanel);

  SegmentBitsEditUpdate(Self);
end;
//****************************************************************************************************************************************************
end.
