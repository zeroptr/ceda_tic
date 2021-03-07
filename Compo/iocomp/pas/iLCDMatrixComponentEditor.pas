{*******************************************************}
{                                                       }
{       TiLedMatrixComponentEditor                      }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iLCDMatrixComponentEditor;{$endif}
{$ifdef iCLX}unit QiLCDMatrixComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,{$ENDIF}
  {$IFDEF iCLX}QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes,{$ENDIF}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iLCDMatrix,  iLCDCharacter,  iComponent,  iVCLComponent,  iCustomComponent,  iLedMatrix,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiLCDMatrix, QiLCDCharacter, QiComponent, QiCLXComponent, QiCustomComponent, QiLedMatrix,{$ENDIF}

  {$IFDEF iVCL} iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iRadioGroup, iCheckBox;{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiLCDMatrixComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    iAboutPanel1: TiAboutPanel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    OuterMarginGroupBox: TGroupBox;
    OuterMarginLeftUpDown: TiUpDown;
    OuterMarginTopUpDown: TiUpDown;
    OuterMarginBottomUpDown: TiUpDown;
    OuterMarginRightUpDown: TiUpDown;
    OuterMarginLeftEdit: TiComponentEditorEdit;
    OuterMarginTopEdit: TiComponentEditorEdit;
    OuterMarginBottomEdit: TiComponentEditorEdit;
    OuterMarginRightEdit: TiComponentEditorEdit;
    Label5: TLabel;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    Label214: TLabel;
    TextEdit: TiComponentEditorEdit;
    Character: TTabSheet;
    CellsGroupBox: TGroupBox;
    Label193: TLabel;
    CellsSpacingHorzUpDown: TiUpDown;
    Label6: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    CellsSpacingVertUpDown: TiUpDown;
    Label3: TLabel;
    CellsWidthUpDown: TiUpDown;
    CellsShowOffCheckBox: TiComponentEditorCheckBox;
    CellsSpacingHorzEdit: TiComponentEditorEdit;
    CellsColorOnPicker: TiComponentEditorColorPicker;
    CellsColorOffPicker: TiComponentEditorColorPicker;
    CellsSpacingVertEdit: TiComponentEditorEdit;
    CellsWidthEdit: TiComponentEditorEdit;
    CharacterGroupBox: TGroupBox;
    Label4: TLabel;
    CharacterSpacingHorzUpDown: TiUpDown;
    Label9: TLabel;
    CharacterSpacingVertUpDown: TiUpDown;
    CharacterSpacingHorzEdit: TiComponentEditorEdit;
    CharacterSpacingVertEdit: TiComponentEditorEdit;
    Label10: TLabel;
    CharactersetWidthUpDown: TiUpDown;
    Label7: TLabel;
    CharactersetHeightUpDown: TiUpDown;
    CharactersetWidthEdit: TiComponentEditorEdit;
    CharactersetHeightEdit: TiComponentEditorEdit;
    CharacterMatrixEditor: TiLedMatrix;
    CharacterserSavePicker: TiComponentEditorSavePicker;
    CharacterserLoadPicker: TiComponentEditorOpenPicker;
    LoadDefaultCharactersetButton: TiComponentEditorButton;
    Label8: TLabel;
    CharactersetCharactorCodeUpDown: TiUpDown;
    CharactersetCharactorCodeEdit: TiComponentEditorEdit;
    CharactersetNameLabel: TLabel;
    Label11: TLabel;
    procedure CharactersetSizeUpdate(Sender: TObject);
    procedure LoadDefaultCharactersetButtonClick(Sender: TObject);
    procedure iComponentEditorFormCreate(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure CharactersetCharactorCodeEditUpdate(Sender: TObject);
    procedure CharacterMatrixEditorClickIndicator(Row, Col: Integer);
    procedure CharacterserLoadPickerChange(Sender: TObject);
    procedure CharacterserSavePickerChange(Sender: TObject);
  private
    FCharacterList     : TStringList;
    FLastCharacterCode : Integer;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iLCDMatrixComponentEditorForm: TiLCDMatrixComponentEditorForm;

implementation

type
  TiLCDMatrixAccess = class(TiLCDMatrix) end;
{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.iComponentEditorFormCreate(Sender: TObject);
var
  x         : Integer;
  Character : TiLCDCharacter;
begin
  FCharacterList := TStringList.Create;

  for x := 0 to 255 do
    begin
      Character := TiLCDCharacter.Create;
      FCharacterList.AddObject('', Character);
    end;

  FLastCharacterCode := 65;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  while FCharacterList.Count <> 0 do
    begin
      FCharacterList.Objects[0].Free;
      FCharacterList.Delete(0);
    end;
  FCharacterList.Free;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiLCDMatrix.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  x          : Integer;
  iLCDMatrix : TiLCDMatrix;
begin
  iLCDMatrix := Component as TiLCDMatrix;

  TextEdit.AsString                         := iLCDMatrix.Text;
  CellsColorOnPicker.Color                  := iLCDMatrix.CellsColorOn;
  CellsColorOffPicker.Color                 := iLCDMatrix.CellsColorOff;
  CellsShowOffCheckBox.AsBoolean            := iLCDMatrix.CellsShowOff;
  CellsWidthEdit.AsInteger                  := iLCDMatrix.CellsWidth;
  CellsSpacingHorzEdit.AsInteger            := iLCDMatrix.CellsSpacingHorz;
  CellsSpacingVertEdit.AsInteger            := iLCDMatrix.CellsSpacingVert;

  CharactersetWidthEdit.AsInteger           := iLCDMatrix.CharactersetWidth;
  CharactersetHeightEdit.AsInteger          := iLCDMatrix.CharactersetHeight;

  CharacterSpacingHorzEdit.AsInteger        := iLCDMatrix.CharacterSpacingHorz;
  CharacterSpacingVertEdit.AsInteger        := iLCDMatrix.CharacterSpacingVert;

  OuterMarginTopEdit.AsInteger              := iLCDMatrix.OuterMarginTop;
  OuterMarginBottomEdit.AsInteger           := iLCDMatrix.OuterMarginBottom;
  OuterMarginLeftEdit.AsInteger             := iLCDMatrix.OuterMarginLeft;
  OuterMarginRightEdit.AsInteger            := iLCDMatrix.OuterMarginRight;

  BackGroundColorPicker.Color               := iLCDMatrix.BackGroundColor;
  BorderStyleRadioGroup.AsInteger           := ord(iLCDMatrix.BorderStyle);
  AutoFrameRateCheckBox.AsBoolean           := iLCDMatrix.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger             := iLCDMatrix.UpdateFrameRate;

  UpLoadOPCProperties(iLCDMatrix, iOPCBrowserPanel);

  for x := 0 to 255 do
    (FCharacterList.Objects[x] as TiLCDCharacter).Assign(TiLCDMatrixAccess(iLCDMatrix).CharacterObject[x]);

  CharactersetNameLabel.Caption := iLCDMatrix.CharactersetName;

  CharactersetCharactorCodeEdit.AsInteger := FLastCharacterCode;
  CharactersetSizeUpdate(Self);
  CharactersetCharactorCodeEditUpdate(Self);
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  x          : Integer;
  iLCDMatrix : TiLCDMatrix;
begin
  iLCDMatrix := Component as TiLCDMatrix;

  iLCDMatrix.Text                 :=  TextEdit.AsString;
  iLCDMatrix.CellsColorOn         :=  CellsColorOnPicker.Color;
  iLCDMatrix.CellsColorOff        :=  CellsColorOffPicker.Color;
  iLCDMatrix.CellsShowOff         :=  CellsShowOffCheckBox.AsBoolean;
  iLCDMatrix.CellsWidth           :=  CellsWidthEdit.AsInteger;
  iLCDMatrix.CellsSpacingHorz     :=  CellsSpacingHorzEdit.AsInteger;
  iLCDMatrix.CellsSpacingVert     :=  CellsSpacingVertEdit.AsInteger;

  iLCDMatrix.CharactersetWidth    :=  CharactersetWidthEdit.AsInteger;
  iLCDMatrix.CharactersetHeight   :=  CharactersetHeightEdit.AsInteger;

  iLCDMatrix.CharacterSpacingHorz :=  CharacterSpacingHorzEdit.AsInteger;
  iLCDMatrix.CharacterSpacingVert :=  CharacterSpacingVertEdit.AsInteger;

  iLCDMatrix.OuterMarginTop       :=  OuterMarginTopEdit.AsInteger;
  iLCDMatrix.OuterMarginBottom    :=  OuterMarginBottomEdit.AsInteger;
  iLCDMatrix.OuterMarginLeft      :=  OuterMarginLeftEdit.AsInteger;
  iLCDMatrix.OuterMarginRight     :=  OuterMarginRightEdit.AsInteger;

  iLCDMatrix.BackGroundColor      :=  BackGroundColorPicker.Color;
  iLCDMatrix.BorderStyle          :=  TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iLCDMatrix.AutoFrameRate        :=  AutoFrameRateCheckBox.AsBoolean;
  iLCDMatrix.UpdateFrameRate      :=  UpdateFrameRateEdit.AsInteger;

  for x := 0 to 255 do
    TiLCDMatrixAccess(iLCDMatrix).CharacterObject[x].Assign((FCharacterList.Objects[x] as TiLCDCharacter));

  TiLCDMatrixAccess(iLCDMatrix).SetCharactersetName(CharactersetNameLabel.Caption);

  FLastCharacterCode := CharactersetCharactorCodeEdit.AsInteger;

  DownLoadOPCProperties(iLCDMatrix, iOPCBrowserPanel);

  iLCDMatrix.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.CharactersetSizeUpdate(Sender: TObject);
var
  x : Integer;
begin
  CharacterMatrixEditor.IndicatorWidth  := (CharacterMatrixEditor.Width  - (CharactersetWidthEdit.AsInteger  - 1)) div CharactersetWidthEdit.AsInteger;
  CharacterMatrixEditor.IndicatorHeight := (CharacterMatrixEditor.Height - (CharactersetHeightEdit.AsInteger - 1)) div CharactersetHeightEdit.AsInteger;

  CharacterMatrixEditor.ColCount := CharactersetWidthEdit.AsInteger;
  CharacterMatrixEditor.RowCount := CharactersetHeightEdit.AsInteger;

  for x := 0 to FCharacterList.Count-1 do
    (FCharacterList.Objects[x] as TiLCDCharacter).RowCount := CharactersetHeightEdit.AsInteger;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.LoadDefaultCharactersetButtonClick(Sender: TObject);
var
  x : Integer;
begin
  for x := 0 to FCharacterList.Count-1 do
    (FCharacterList.Objects[x] as TiLCDCharacter).LoadDefault(x);

  CharactersetNameLabel.Caption := '(Default)';

  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.CharactersetCharactorCodeEditUpdate(Sender: TObject);
var
  Row     : Integer;
  Col     : Integer;
  RowData : Integer;
begin
  for Row := 0 to CharactersetHeightEdit.AsInteger-1 do
    begin
      RowData := (FCharacterList.Objects[CharactersetCharactorCodeEdit.AsInteger] as TiLCDCharacter).GetRowData(Row);
      for Col := 0 to CharactersetWidthEdit.AsInteger-1 do
        CharacterMatrixEditor.IndicatorActive[Row, Col] := RowData and (1 shl (CharactersetWidthEdit.AsInteger - Col -1)) > 0;
    end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.CharacterMatrixEditorClickIndicator(Row, Col: Integer);
var
  CurrentCol  : Integer;
  NewRowValue : Integer;
begin
  CharacterMatrixEditor.IndicatorActive[Row, Col] := not CharacterMatrixEditor.IndicatorActive[Row, Col];

  NewRowValue := 0;
  for CurrentCol := 0 to CharactersetWidthEdit.AsInteger-1 do                              
    if CharacterMatrixEditor.IndicatorActive[Row, CurrentCol] then
      NewRowValue := NewRowValue + (1 shl (CharactersetWidthEdit.AsInteger - CurrentCol -1));

  (FCharacterList.Objects[CharactersetCharactorCodeEdit.AsInteger] as TiLCDCharacter).SetRowData(Row, NewRowValue);
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.CharacterserLoadPickerChange(Sender: TObject);
var
  x            : Integer;
  Row          : Integer;
  StringList   : TStringList;
  NewWidth     : Integer;
  NewHeight    : Integer;
  CurrentIndex : Integer;
begin
  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(CharacterserLoadPicker.FileName);

    CurrentIndex := 0;

    NewWidth  := StrToInt(StringList.Strings[CurrentIndex]); Inc(CurrentIndex);
    NewHeight := StrToInt(StringList.Strings[CurrentIndex]); Inc(CurrentIndex);

    if (NewHeight*256 + 2) <> StringList.Count then raise Exception.Create('Invalid Characterset File Format');

    CharactersetNameLabel.Caption := ExtractFileName(CharacterserLoadPicker.FileName);

    CharactersetWidthEdit.AsInteger  := NewWidth;
    CharactersetHeightEdit.AsInteger := NewHeight;
    CharactersetSizeUpdate(Self);

    for x := 0 to 255 do
      for Row := 0 to NewHeight-1 do
        begin
          (FCharacterList.Objects[x] as TiLCDCharacter).RowCount := NewHeight;
          (FCharacterList.Objects[x] as TiLCDCharacter).SetRowData(Row, StrToInt(StringList.Strings[CurrentIndex]));
          Inc(CurrentIndex);
        end;

    CharactersetCharactorCodeEditUpdate(Self);

  finally
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiLCDMatrixComponentEditorForm.CharacterserSavePickerChange(Sender: TObject);
var
  x          : Integer;
  Row        : Integer;
  StringList : TStringList;
begin
  StringList := TStringList.Create;
  try
    StringList.Add(IntToStr(CharactersetWidthEdit.AsInteger));
    StringList.Add(IntToStr(CharactersetHeightEdit.AsInteger));

    for x := 0 to 255 do
      for Row := 0 to CharactersetHeightEdit.AsInteger-1 do
        StringList.Add(IntToStr((FCharacterList.Objects[x] as TiLCDCharacter).GetRowData(Row)));

    StringList.SaveToFile(CharacterserSavePicker.FileName);

    CharactersetNameLabel.Caption := ExtractFileName(CharacterserSavePicker.FileName);
  finally
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
end.
