{*******************************************************}
{                                                       }
{       TiPercentBarComponentEditor                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPercentBarComponentEditor;{$endif}
{$ifdef iCLX}unit QiPercentBarComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iPercentBar,  iClasses,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiPercentBar, QiClasses,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiPercentBarComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    ItemsTabSheet: TTabSheet;
    Label1: TLabel;
    ItemListBox: TiComponentEditorListBox;
    iItemAddButton: TButton;
    ItemRemoveButton: TButton;
    ItemPropertiesGroupBox: TGroupBox;
    Label3: TLabel;
    ItemColorPicker: TiComponentEditorColorPicker;
    Label5: TLabel;
    ItemTitleEdit: TiComponentEditorEdit;
    GeneralTabSheet: TTabSheet;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    TitleGroupBox: TGroupBox;
    Label35: TLabel;
    TitleMarginEdit: TiComponentEditorEdit;
    TitleEdit: TiComponentEditorEdit;
    TitleFontPicker: TiComponentEditorFontPicker;
    TitleMarginUpDown: TiUpDown;
    Label40: TLabel;
    ItemValueEdit: TiComponentEditorEdit;
    Label2: TLabel;
    OuterMarginEdit: TiComponentEditorEdit;
    OuterMarginUpDown: TiUpDown;
    Label4: TLabel;
    TitleHorizontalAlignmentRadioGroup: TiComponentEditorRadioGroup;
    Label6: TLabel;
    BarWidthEdit: TiComponentEditorEdit;
    BarWidthUpDown: TiUpDown;
    LegendTabSheet: TTabSheet;
    ValueGroupBox: TGroupBox;
    Label34: TLabel;
    LegendFontPicker: TiComponentEditorFontPicker;
    LegendMarginEdit: TiComponentEditorEdit;
    LegendMarginUpDown: TiUpDown;
    LegendShowValueCheckBox: TiComponentEditorCheckBox;
    Label23: TLabel;
    LegendValueMarginEdit: TiComponentEditorEdit;
    LegendValueMarginUpDown: TiUpDown;
    Label24: TLabel;
    LegendValuePrecisionEdit: TiComponentEditorEdit;
    LegendValuePrecisionUpDown: TiUpDown;
    PercentGroupBox: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    LegendShowPercentCheckBox: TiComponentEditorCheckBox;
    LegendPercentMarginEdit: TiComponentEditorEdit;
    LegendPercentMarginUpDown: TiUpDown;
    LegendPercentPrecisionEdit: TiComponentEditorEdit;
    LegendPercentPrecisionUpDown: TiUpDown;
    Label9: TLabel;
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
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    procedure iItemAddButtonClick(Sender: TObject);
    procedure ItemRemoveButtonClick(Sender: TObject);
    procedure ItemListBoxClick(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure ItemChange(Sender: TObject);
    procedure ItemListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure ItemListBoxItemMove(Sender: TObject);
  private
    procedure UpdateItemEdit;
    procedure ClearList;
  protected
    procedure CreateThemeInstance; override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iPercentBarComponentEditorForm: TiPercentBarComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiPercentBar.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  ClearList;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.ClearList;
begin
  while ItemListBox.Items.Count > 0 do
    begin
      ItemListBox.Items.Objects[0].Free;
      ItemListBox.Items.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.iItemAddButtonClick(Sender: TObject);
var
  iPercentItemObject : TiPercentItemObject;
begin
  iPercentItemObject        := TiPercentItemObject.Create;
  iPercentItemObject.Title  := 'Untitled';
  iPercentItemObject.Color  := clRed;
  iPercentItemObject.Value  := 100;
  ItemListBox.ItemIndex     := ItemListBox.Items.AddObject(iPercentItemObject.Title, iPercentItemObject);

  UpdateItemEdit;

  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.ItemRemoveButtonClick(Sender: TObject);
var
  LastIndex : Integer;
begin
  LastIndex := ItemListBox.ItemIndex;
  ItemListBox.Items.Objects[ItemListBox.ItemIndex].Free;
  ItemListBox.Items.Delete(ItemListBox.ItemIndex);
  if ItemListBox.Items.Count <> 0 then
    begin
      if LastIndex > (ItemListBox.Items.Count - 1) then ItemListBox.ItemIndex := LastIndex - 1
        else ItemListBox.ItemIndex := LastIndex;
    end;

  UpdateItemEdit;
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.ItemListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (ItemListBox.Items.Objects[Index] as TiPercentItemObject).Color;
  AText  := (ItemListBox.Items.Objects[Index] as TiPercentItemObject).Title;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.ItemListBoxClick(Sender: TObject);
begin
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.ItemListBoxItemMove(Sender: TObject);
begin
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.UpdateItemEdit;
var
  iPercentItemObject : TiPercentItemObject;
begin
  if ItemListBox.ItemIndex = - 1 then DisableAllEditControlsStartingWith('Item')
    else
      begin
        EnableAllEditControlsStartingWith('Item');

        iPercentItemObject := ItemListBox.Items.Objects[ItemListBox.ItemIndex] as TiPercentItemObject;

        ItemTitleEdit.AsString := iPercentItemObject.Title;
        ItemColorPicker.Color  := iPercentItemObject.Color;
        ItemValueEdit.AsFloat  := iPercentItemObject.Value;
      end
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.ItemChange(Sender: TObject);
var
  iPercentItemObject : TiPercentItemObject;
begin
  if ItemListBox.ItemIndex = -1 then exit;

  iPercentItemObject := ItemListBox.Items.Objects[ItemListBox.ItemIndex] as TiPercentItemObject;

  iPercentItemObject.Title := ItemTitleEdit.AsString;
  iPercentItemObject.Color := ItemColorPicker.Color;
  iPercentItemObject.Value := ItemValueEdit.AsFloat;

  UpdateItemEdit;
  ItemListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iPercentBar        : TiPercentBar;
  iPercentItemObject : TiPercentItemObject;
  x                  : Integer;
begin
  iPercentBar := Component as TiPercentBar;

  ClearList;
  for x := 0 to iPercentBar.ItemCount - 1 do
    begin
      iPercentItemObject       := TiPercentItemObject.Create;
      iPercentItemObject.Title := iPercentBar.ItemTitle[x];
      iPercentItemObject.Color := iPercentBar.ItemColor[x];
      iPercentItemObject.Value := iPercentBar.ItemValue[x];
      ItemListBox.Items.AddObject(iPercentItemObject.Title, iPercentItemObject);
    end;

  if ItemListBox.Items.Count <> 0 then ItemListBox.ItemIndex := 0;

  TitleEdit.AsString                           := iPercentBar.TitleText;
  TitleMarginEdit.AsInteger                    := iPercentBar.TitleMargin;
  TitleHorizontalAlignmentRadioGroup.AsInteger := ord(iPercentBar.TitleHorizontalAlignment);

  OuterMarginEdit.AsInteger                    := iPercentBar.OuterMargin;
  BarWidthEdit.AsInteger                       := iPercentBar.BarWidth;
  BackGroundColorPicker.Color                  := iPercentBar.BackGroundColor;
  BorderStyleRadioGroup.AsInteger              := ord(iPercentBar.BorderStyle);
  TransparentCheckBox.AsBoolean                := iPercentBar.Transparent;
  AutoFrameRateCheckBox.AsBoolean              := iPercentBar.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger                := iPercentBar.UpdateFrameRate;

  LegendMarginEdit.AsInteger                   := iPercentBar.LegendMargin;

  LegendShowValueCheckBox.AsBoolean            := iPercentBar.LegendShowValue;
  LegendValueMarginEdit.AsInteger              := iPercentBar.LegendValueMargin;
  LegendValuePrecisionEdit.AsInteger           := iPercentBar.LegendValuePrecision;

  LegendShowPercentCheckBox.AsBoolean          := iPercentBar.LegendShowPercent;
  LegendPercentMarginEdit.AsInteger            := iPercentBar.LegendPercentMargin;
  LegendPercentPrecisionEdit.AsInteger         := iPercentBar.LegendPercentPrecision;

  TitleFontPicker.Font.Assign (iPercentBar.TitleFont);
  LegendFontPicker.Font.Assign(iPercentBar.LegendFont);

  UpLoadOPCProperties(iPercentBar, iOPCBrowserPanel);

  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiPercentBarComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iPercentBar        : TiPercentBar;
  iPercentItemObject : TiPercentItemObject;
  x                  : Integer;
begin
  iPercentBar := Component as TiPercentBar;

  for x := 0 to iPercentBar.ItemCount - 1 do
    iPercentBar.RemoveItem(0);

  for x := 0 to ItemListBox.Items.Count - 1 do
    begin
      iPercentItemObject := ItemListBox.Items.Objects[x] as TiPercentItemObject;
      iPercentBar.AddItem(iPercentItemObject.Title, iPercentItemObject.Color, iPercentItemObject.Value);
    end;

  iPercentBar.TitleText                := TitleEdit.AsString;
  iPercentBar.TitleMargin              := TitleMarginEdit.AsInteger;
  iPercentBar.TitleHorizontalAlignment := TiTitleHorizontalAlignment(TitleHorizontalAlignmentRadioGroup.AsInteger);

  iPercentBar.OuterMargin              := OuterMarginEdit.AsInteger;
  iPercentBar.BarWidth                 := BarWidthEdit.AsInteger;
  iPercentBar.BackGroundColor          := BackGroundColorPicker.Color;
  iPercentBar.BorderStyle              := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iPercentBar.Transparent              := TransparentCheckBox.AsBoolean;
  iPercentBar.AutoFrameRate            := AutoFrameRateCheckBox.AsBoolean;
  iPercentBar.UpdateFrameRate          := UpdateFrameRateEdit.AsInteger;

  iPercentBar.LegendMargin             := LegendMarginEdit.AsInteger;

  iPercentBar.LegendShowValue          := LegendShowValueCheckBox.AsBoolean;
  iPercentBar.LegendValueMargin        := LegendValueMarginEdit.AsInteger;
  iPercentBar.LegendValuePrecision     := LegendValuePrecisionEdit.AsInteger;

  iPercentBar.LegendShowPercent        := LegendShowPercentCheckBox.AsBoolean;
  iPercentBar.LegendPercentMargin      := LegendPercentMarginEdit.AsInteger;
  iPercentBar.LegendPercentPrecision   := LegendPercentPrecisionEdit.AsInteger;

  iPercentBar.LegendFont.Assign(LegendFontPicker.Font);
  iPercentBar.TitleFont.Assign (TitleFontPicker.Font);

  DownLoadOPCProperties(iPercentBar, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
