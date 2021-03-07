{*******************************************************}
{                                                       }
{       TiPhonePadComponentEditorForm                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iKeyBoardComponentEditor;{$endif}
{$ifdef iCLX}unit QiKeyBoardComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iKeyBoard,  iGPFunctions,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiKeyBoard, QiGPFunctions,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiKeyBoardComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    FontPicker: TiComponentEditorFontPicker;
    Label3: TLabel;
    OuterMarginEdit: TiComponentEditorEdit;
    Label4: TLabel;
    SecondRowMarginEdit: TiComponentEditorEdit;
    Label11: TLabel;
    StyleComboBox: TiComponentEditorComboBox;
    iAboutPanel1: TiAboutPanel;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    KeysTabSheet: TTabSheet;
    iKeyListBox: TiComponentEditorListBox;
    ItemPropertiesGroupBox: TGroupBox;
    Label1: TLabel;
    KeyStandardCaptionEdit: TiComponentEditorEdit;
    Label2: TLabel;
    KeyShiftCaptionEdit: TiComponentEditorEdit;
    Label5: TLabel;
    Label7: TLabel;
    KeyStyleComboBox: TiComponentEditorComboBox;
    KeyAcceptLockCheckBox: TiComponentEditorCheckBox;
    PropertiesGroupBox: TGroupBox;
    LoadPropertiesPicker: TiComponentEditorOpenPicker;
    SavePropertiesPicker: TiComponentEditorSavePicker;
    Label89: TLabel;
    KeyVirtualKeyCodeEdit: TiComponentEditorEdit;
    Label6: TLabel;
    KeyBackGroundColorPicker: TiComponentEditorColorPicker;
    KeyVisibleLockCheckBox: TiComponentEditorCheckBox;
    KeyUseControlFontColorCheckBox: TiComponentEditorCheckBox;
    Label8: TLabel;
    KeyFontColorPicker: TiComponentEditorColorPicker;
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure iKeyListBoxClick(Sender: TObject);
    procedure KeyChange(Sender: TObject);
    procedure StyleComboBoxChange(Sender: TObject);
    procedure LoadPropertiesPickerChange(Sender: TObject);
    procedure SavePropertiesPickerChange(Sender: TObject);
  private
    FLastKeyIndex : Integer;

    {$IFDEF iVCL}procedure iKeyListBoxDrawItem(Control: TWinControl; Index: Integer;  Rect: TRect; State: TOwnerDrawState);              {$ENDIF}
    {$IFDEF iCLX}procedure iKeyListBoxDrawItem(Control: TObject; Index: Integer; Rect: TRect; State: TOwnerDrawState; var Handled:Boolean);{$ENDIF}
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;

    procedure UpdateItemEdit;
    procedure ClearList;
  end;

var
  iKeyBoardComponentEditorForm: TiKeyBoardComponentEditorForm;

implementation

type
  TiKeyBoardAccess = class(TiKeyBoard)end;

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  ClearList;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiKeyBoard.Create(Self);
  iKeyListBox.OnDrawItem := iKeyListBoxDrawItem;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iKeyBoard      : TiKeyBoard;
  KeyBoardButton : TiKeyBoardButton;
  x              : Integer;
begin
  iKeyBoard := Component as TiKeyBoard;

  StyleComboBox.AsInteger         := ord(iKeyBoard.Style);
  SecondRowMarginEdit.AsInteger   := iKeyBoard.SecondRowMargin;
  OuterMarginEdit.AsInteger       := iKeyBoard.OuterMargin;
  BackGroundColorPicker.Color     := iKeyBoard.BackGroundColor;
  BorderStyleRadioGroup.AsInteger := ord(iKeyBoard.BorderStyle);
  AutoFrameRateCheckBox.AsBoolean := iKeyBoard.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger   := iKeyBoard.UpdateFrameRate;

  if Component <> iThemeInstance then
    begin
      ClearList;
      for x := 0 to TiKeyBoardAccess(iKeyBoard).KeyCount-1 do
        begin
          KeyBoardButton                     := TiKeyBoardButton.Create;
          KeyBoardButton.Visible             := TiKeyBoardAccess(iKeyBoard).KeyButton[x].Visible;
          KeyBoardButton.Style               := TiKeyBoardAccess(iKeyBoard).KeyButton[x].Style;
          KeyBoardButton.UseControlFontColor := TiKeyBoardAccess(iKeyBoard).KeyButton[x].UseControlFontColor;
          KeyBoardButton.FontColor           := TiKeyBoardAccess(iKeyBoard).KeyButton[x].FontColor;
          KeyBoardButton.BackGroundColor     := TiKeyBoardAccess(iKeyBoard).KeyButton[x].BackGroundColor;
          KeyBoardButton.VirtualKeyCode      := TiKeyBoardAccess(iKeyBoard).KeyButton[x].VirtualKeyCode;
          KeyBoardButton.CaptionStandard     := TiKeyBoardAccess(iKeyBoard).KeyButton[x].CaptionStandard;
          KeyBoardButton.CaptionShift        := TiKeyBoardAccess(iKeyBoard).KeyButton[x].CaptionShift;
          KeyBoardButton.Row                 := TiKeyBoardAccess(iKeyBoard).KeyButton[x].Row;
          KeyBoardButton.AcceptLock          := TiKeyBoardAccess(iKeyBoard).KeyButton[x].AcceptLock;
          iKeyListBox.Items.AddObject('', KeyBoardButton)
        end;
    end;

  FontPicker.Font.Assign(iKeyBoard.Font);

  if iKeyListBox.Items.Count > FLastKeyIndex then iKeyListBox.ItemIndex := FLastKeyIndex;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iKeyBoard      : TiKeyBoard;
  KeyBoardButton : TiKeyBoardButton;
  x              : Integer;
begin
  iKeyBoard := Component as TiKeyBoard;

  iKeyBoard.Style              := TiKeyBoardStyle(StyleComboBox.AsInteger);
  iKeyBoard.SecondRowMargin    := SecondRowMarginEdit.AsInteger;
  iKeyBoard.OuterMargin        := OuterMarginEdit.AsInteger;
  iKeyBoard.BackGroundColor    := BackGroundColorPicker.Color;
  iKeyBoard.BorderStyle        := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iKeyBoard.AutoFrameRate      := AutoFrameRateCheckBox.AsBoolean;
  iKeyBoard.UpdateFrameRate    := UpdateFrameRateEdit.AsInteger;

  if Component <> iThemeInstance then
    begin
      for x := 0 to iKeyListBox.Items.Count -1 do
        begin
          KeyBoardButton := iKeyListBox.Items.Objects[x] as TiKeyBoardButton;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].Style               := KeyBoardButton.Style;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].Visible             := KeyBoardButton.Visible;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].BackGroundColor     := KeyBoardButton.BackGroundColor;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].UseControlFontColor := KeyBoardButton.UseControlFontColor;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].FontColor           := KeyBoardButton.FontColor;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].VirtualKeyCode      := KeyBoardButton.VirtualKeyCode;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].CaptionStandard     := KeyBoardButton.CaptionStandard;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].CaptionShift        := KeyBoardButton.CaptionShift;
          TiKeyBoardAccess(iKeyBoard).KeyButton[x].AcceptLock          := KeyBoardButton.AcceptLock;
        end;
    end;

  iKeyBoard.Font.Assign(FontPicker.Font);

  FLastKeyIndex := iKeyListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.ClearList;
begin
  while iKeyListBox.Items.Count > 0 do
    begin
      iKeyListBox.Items.Objects[0].Free;
      iKeyListBox.Items.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}procedure TiKeyBoardComponentEditorForm.iKeyListBoxDrawItem(Control: TWinControl; Index: Integer;  Rect: TRect; State: TOwnerDrawState);               {$ENDIF}
{$IFDEF iCLX}procedure TiKeyBoardComponentEditorForm.iKeyListBoxDrawItem(Control: TObject; Index: Integer; Rect: TRect; State: TOwnerDrawState; var Handled:Boolean);{$ENDIF}
var
  KeyBoardButton : TiKeyBoardButton;
  AWidth         : Integer;
  ARect          : TRect;
begin
  KeyBoardButton := iKeyListBox.Items.Objects[Index] as TiKeyBoardButton;

  with (Control as TCustomListBox).Canvas, Rect do
    begin
      if odSelected in State then
        begin
          Brush.Color := clTeal;
          Font.Color  := clWhite;
        end
      else
        begin
          Brush.Color := clWindow;
          Font.Color  := clBlack;
        end;

      FillRect(Rect);

      AWidth := TextWidth('A');

      if KeyBoardButton.Style = ikbbsSpacer then
        begin
          Font.Style := [fsBold];
          TextOut(Left + 2 + AWidth*2, Top, 'Spacer');
          Font.Style := [];
        end
      else TextOut(Left + 2 + AWidth*2, Top, KeyBoardButton.CaptionStandard);

      Brush.Color := clBlue;
      ARect := iRect(Left + 2, Top+1, Left - 2 + AWidth*2, Bottom-1);
      FillRect(ARect);
      Font.Color := clWhite;
      iDrawText((Control as TCustomListBox).Canvas, IntToStr(KeyBoardButton.Row), ARect, [itfHCenter, itfVCenter, itfSingleLine], True, clWhite);
    end;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.iKeyListBoxClick(Sender: TObject);
begin
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.StyleComboBoxChange(Sender: TObject);
begin
  ClearList;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.UpdateItemEdit;
var
  KeyBoardButton : TiKeyBoardButton;
begin
  if iKeyListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Key')
    else
      begin
        EnableAllEditControlsStartingWith('Key');

        KeyBoardButton := iKeyListBox.Items.Objects[iKeyListBox.ItemIndex] as TiKeyBoardButton;

        if KeyBoardButton.Style = ikbbsSpacer then
          begin
            DisableAllEditControlsStartingWith('Key');
            Exit;
          end;

        KeyVisibleLockCheckBox.AsBoolean         := KeyBoardButton.Visible;
        KeyStyleComboBox.AsInteger               := ord(KeyBoardButton.Style);
        KeyUseControlFontColorCheckBox.AsBoolean := KeyBoardButton.UseControlFontColor;
        KeyFontColorPicker.Color                 := KeyBoardButton.FontColor;
        KeyBackGroundColorPicker.Color           := KeyBoardButton.BackGroundColor;
        KeyVirtualKeyCodeEdit.AsInteger          := KeyBoardButton.VirtualKeyCode;
        KeyStandardCaptionEdit.AsString          := KeyBoardButton.CaptionStandard;
        KeyShiftCaptionEdit.AsString             := KeyBoardButton.CaptionShift;
        KeyAcceptLockCheckBox.AsBoolean          := KeyBoardButton.AcceptLock;
      end
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.KeyChange(Sender: TObject);
var
  KeyBoardButton : TiKeyBoardButton;
begin
  if iKeyListBox.ItemIndex = -1 then exit;

  KeyBoardButton := iKeyListBox.Items.Objects[iKeyListBox.ItemIndex] as TiKeyBoardButton;

  KeyBoardButton.Visible             := KeyVisibleLockCheckBox.AsBoolean;
  KeyBoardButton.Style               := TiKeyBoardButtonStyle(KeyStyleComboBox.AsInteger);
  KeyBoardButton.UseControlFontColor := KeyUseControlFontColorCheckBox.AsBoolean;
  KeyBoardButton.FontColor           := KeyFontColorPicker.Color;
  KeyBoardButton.BackGroundColor     := KeyBackGroundColorPicker.Color;
  KeyBoardButton.VirtualKeyCode      := KeyVirtualKeyCodeEdit.AsInteger;
  KeyBoardButton.CaptionStandard     := KeyStandardCaptionEdit.AsString;
  KeyBoardButton.CaptionShift        := KeyShiftCaptionEdit.AsString;
  KeyBoardButton.AcceptLock          := KeyAcceptLockCheckBox.AsBoolean;

  UpdateItemEdit;
  iKeyListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.LoadPropertiesPickerChange(Sender: TObject);
begin
  (iComponent as TiKeyBoard).LoadPropertiesFromFile(LoadPropertiesPicker.FileName);
  CopyPropertiesToForm(iComponent);
end;
//****************************************************************************************************************************************************
procedure TiKeyBoardComponentEditorForm.SavePropertiesPickerChange(Sender: TObject);
begin
  CopyPropertiesToComponent(iComponent);
  (iComponent as TiKeyBoard).SavePropertiesToFile(SavePropertiesPicker.FileName);
end;
//****************************************************************************************************************************************************
end.
