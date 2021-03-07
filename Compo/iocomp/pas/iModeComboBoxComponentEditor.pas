{*******************************************************}
{                                                       }
{       TiModeComboBoxComponentEditor                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iModeComboBoxComponentEditor;{$endif}
{$ifdef iCLX}unit QiModeComboBoxComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iModeComboBox,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiModeComboBox,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iComponent, iVCLComponent, iCustomComponent, iCheckBox;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiModeComboBoxComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    FontPicker: TiComponentEditorFontPicker;
    ColorPicker: TiComponentEditorColorPicker;
    Label31: TLabel;
    EnabledCheckBox: TiComponentEditorCheckBox;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    iAboutPanel1: TiAboutPanel;
    iItemPropertiesGroupBox: TGroupBox;
    Label3: TLabel;
    Label2: TLabel;
    ItemCaptionEdit: TiComponentEditorEdit;
    ItemValueEdit: TiComponentEditorEdit;
    ItemListBox: TiComponentEditorListBox;
    iItemAddButton: TButton;
    ItemRemoveButton: TButton;
    Label1: TLabel;
    DropDownColorPicker: TiComponentEditorColorPicker;
    procedure iItemAddButtonClick(Sender: TObject);
    procedure ItemRemoveButtonClick(Sender: TObject);
    procedure ItemListBoxClick(Sender: TObject);
    procedure ItemListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure ItemChange(Sender: TObject);
  private
    FLastItemIndex : Integer;
    procedure UpdateItemEdit;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iModeComboBoxComponentEditorForm: TiModeComboBoxComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiModeComboBox.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iComponent : TiModeComboBox;
  x          : Integer;
begin
  iComponent := Component as TiModeComboBox;

  EnabledCheckBox.AsBoolean := iComponent.Enabled;
  ColorPicker.Color         := iComponent.Color;
  DropDownColorPicker.Color := iComponent.DropDownColor;

  ItemListBox.Clear;

  for x := 0 to iComponent.ItemCount-1 do
    ItemListBox.Items.AddObject(iComponent.GetItemCaption(x), TObject(iComponent.GetItemValue(x)));

  UpLoadOPCProperties(iComponent, iOPCBrowserPanel);

  FontPicker.Font.Assign(iComponent.Font);

  ItemListBox.SelectLast;
  if ItemListBox.Items.Count >= FLastItemIndex then ItemListBox.ItemIndex := FLastItemIndex;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iComponent : TiModeComboBox;
  x          : Integer;
begin
  iComponent := Component as TiModeComboBox;

  iComponent.Enabled       := EnabledCheckBox.AsBoolean;
  iComponent.Color         := ColorPicker.Color;
  iComponent.DropDownColor := DropDownColorPicker.Color;

  iComponent.RemoveAllItems;
  for x := 0 to ItemListBox.Items.Count - 1 do
     iComponent.AddItem(ItemListBox.Items.Strings[x], Integer(ItemListBox.Items.Objects[x]));

  DownLoadOPCProperties(iComponent, iOPCBrowserPanel);

  iComponent.Font.Assign(FontPicker.Font);

  FLastItemIndex := ItemListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.iItemAddButtonClick(Sender: TObject);
begin           
  ItemListBox.ItemIndex := ItemListBox.Items.AddObject('No Name', TObject(0));
  Modified := True;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.ItemRemoveButtonClick(Sender: TObject);
var
  LastIndex : Integer;
begin
  LastIndex := ItemListBox.ItemIndex;
  ItemListBox.Items.Delete(ItemListBox.ItemIndex);

  if ItemListBox.Items.Count <> 0 then
    begin
      if LastIndex > (ItemListBox.Items.Count - 1) then ItemListBox.ItemIndex := LastIndex - 1
        else ItemListBox.ItemIndex := LastIndex;
    end;

  Modified := True;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.UpdateItemEdit;
begin
  if ItemListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Item')
    else
      begin
        EnableAllEditControlsStartingWith('Item');
        ItemCaptionEdit.AsString := ItemListBox.Items.Strings[ItemListBox.ItemIndex];
        ItemValueEdit.AsInteger  := Integer(ItemListBox.Items.Objects[ItemListBox.ItemIndex])
      end;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.ItemListBoxClick(Sender: TObject);
begin
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.ItemListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  DrawColorBox := False;
  AText := ItemListBox.Items.Strings[Index] + ' (' + IntToStr(Integer(ItemListBox.Items.Objects[Index])) + ')';
end;
//****************************************************************************************************************************************************
procedure TiModeComboBoxComponentEditorForm.ItemChange(Sender: TObject);
begin
  if ItemListBox.ItemIndex = -1 then exit;

  ItemListBox.Items.Strings[ItemListBox.ItemIndex] := ItemCaptionEdit.AsString;
  ItemListBox.Items.Objects[ItemListBox.ItemIndex] := TObject(ItemValueEdit.AsInteger);

  UpdateItemEdit;
  ItemListBox.Invalidate;
end;
//****************************************************************************************************************************************************
end.
