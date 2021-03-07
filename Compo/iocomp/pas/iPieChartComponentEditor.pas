{*******************************************************}
{                                                       }
{       TiPieChartComponentEditor                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPieChartComponentEditor;{$endif}
{$ifdef iCLX}unit QiPieChartComponentEditor;{$endif}

interface

uses
{$I iIncludeUsesForms.inc}

{$IFDEF iVCL} iComponentEditorForm,  iTypes,  iPieChart,  iClasses,{$ENDIF}
{$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiPieChart, QiClasses,{$ENDIF}

{$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorThemePanel,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iOPCBrowserPanel,  iAboutPanel,
  iCheckBox, iComponent, iVCLComponent, iCustomComponent, iRadioGroup;{$ENDIF}
{$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorThemePanel, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiOPCBrowserPanel, QiAboutPanel;{$ENDIF}

type
  TiPieChartComponentEditorForm = class(TiComponentEditorForm)
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
    TitleGroupBox: TGroupBox;
    Label35: TLabel;
    TitleMarginEdit: TiComponentEditorEdit;
    TitleEdit: TiComponentEditorEdit;
    TitleFontPicker: TiComponentEditorFontPicker;
    TitleMarginUpDown: TiUpDown;
    Label40: TLabel;
    ItemValueEdit: TiComponentEditorEdit;
    Label2: TLabel;
    TitleHorizontalAlignmentRadioGroup: TiComponentEditorRadioGroup;
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
    Label4: TLabel;
    Label6: TLabel;
    OuterMarginEdit: TiComponentEditorEdit;
    OuterMarginUpDown: TiUpDown;
    StartDegreesEdit: TiComponentEditorEdit;
    StartDegreesUpDown: TiUpDown;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    ThemeTabSheet: TTabSheet;
    iComponentEditorThemePanel: TiComponentEditorThemePanel;
    iAboutPanel1: TiAboutPanel;
    BorderStyleRadioGroup: TiComponentEditorRadioGroup;
    Label31: TLabel;
    Label76: TLabel;
    UpdateFrameRateUpDown: TiUpDown;
    BackGroundColorPicker: TiComponentEditorColorPicker;
    UpdateFrameRateEdit: TiComponentEditorEdit;
    AutoFrameRateCheckBox: TiComponentEditorCheckBox;
    TransparentCheckBox: TiComponentEditorCheckBox;
    OPCTabSheet: TTabSheet;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    procedure iItemAddButtonClick(Sender: TObject);
    procedure ItemRemoveButtonClick(Sender: TObject);
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure ItemListBoxClick(Sender: TObject);
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
  iPieChartComponentEditorForm: TiPieChartComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiPieChartComponentEditorForm.CreateThemeInstance;
begin
  iThemeInstance := TiPieChart.Create(Self);
end;
//****************************************************************************************************************************************************
procedure TiPieChartComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  ClearList;
end;
//****************************************************************************************************************************************************
procedure TiPieChartComponentEditorForm.ClearList;
begin
  while ItemListBox.Items.Count > 0 do
    begin
      ItemListBox.Items.Objects[0].Free;
      ItemListBox.Items.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPieChartComponentEditorForm.iItemAddButtonClick(Sender: TObject);
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
procedure TiPieChartComponentEditorForm.ItemRemoveButtonClick(Sender: TObject);
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
procedure TiPieChartComponentEditorForm.ItemListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AColor := (ItemListBox.Items.Objects[Index] as TiPercentItemObject).Color;
  AText  := (ItemListBox.Items.Objects[Index] as TiPercentItemObject).Title;
end;
//****************************************************************************************************************************************************
procedure TiPieChartComponentEditorForm.ItemListBoxClick(Sender: TObject);
begin
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiPieChartComponentEditorForm.ItemListBoxItemMove(Sender: TObject);
begin
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiPieChartComponentEditorForm.UpdateItemEdit;
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
procedure TiPieChartComponentEditorForm.ItemChange(Sender: TObject);
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
procedure TiPieChartComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  iPieChart          : TiPieChart;
  iPercentItemObject : TiPercentItemObject;
  x                  : Integer;
begin
  iPieChart := Component as TiPieChart;

  ClearList;
  for x := 0 to iPieChart.ItemCount - 1 do
    begin
      iPercentItemObject           := TiPercentItemObject.Create;
      iPercentItemObject.Title     := iPieChart.ItemTitle[x];
      iPercentItemObject.Color     := iPieChart.ItemColor[x];
      iPercentItemObject.Value     := iPieChart.ItemValue[x];
      ItemListBox.Items.AddObject(iPercentItemObject.Title, iPercentItemObject);
    end;

  if ItemListBox.Items.Count <> 0 then ItemListBox.ItemIndex := 0;

  TitleEdit.AsString                           := iPieChart.TitleText;
  TitleMarginEdit.AsInteger                    := iPieChart.TitleMargin;
  TitleHorizontalAlignmentRadioGroup.AsInteger := ord(iPieChart.TitleHorizontalAlignment);

  OuterMarginEdit.AsInteger                    := iPieChart.OuterMargin;
  StartDegreesEdit.AsInteger                   := iPieChart.StartDegrees;
  BackGroundColorPicker.Color                  := iPieChart.BackGroundColor;
  BorderStyleRadioGroup.AsInteger              := ord(iPieChart.BorderStyle);
  TransparentCheckBox.AsBoolean                := iPieChart.Transparent;
  AutoFrameRateCheckBox.AsBoolean              := iPieChart.AutoFrameRate;
  UpdateFrameRateEdit.AsInteger                := iPieChart.UpdateFrameRate;

  LegendMarginEdit.AsInteger                   := iPieChart.LegendMargin;

  LegendShowValueCheckBox.AsBoolean            := iPieChart.LegendShowValue;
  LegendValueMarginEdit.AsInteger              := iPieChart.LegendValueMargin;
  LegendValuePrecisionEdit.AsInteger           := iPieChart.LegendValuePrecision;

  LegendShowPercentCheckBox.AsBoolean          := iPieChart.LegendShowPercent;
  LegendPercentMarginEdit.AsInteger            := iPieChart.LegendPercentMargin;
  LegendPercentPrecisionEdit.AsInteger         := iPieChart.LegendPercentPrecision;

  TitleFontPicker.Font.Assign (iPieChart.TitleFont);
  LegendFontPicker.Font.Assign(iPieChart.LegendFont);

  UpLoadOPCProperties(iPieChart, iOPCBrowserPanel);

  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiPieChartComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  iPieChart          : TiPieChart;
  iPercentItemObject : TiPercentItemObject;
  x                  : Integer;
begin
  iPieChart := Component as TiPieChart;

  for x := 0 to iPieChart.ItemCount - 1 do
    iPieChart.RemoveItem(0);

  for x := 0 to ItemListBox.Items.Count - 1 do
    begin
      iPercentItemObject := ItemListBox.Items.Objects[x] as TiPercentItemObject;
      iPieChart.AddItem(iPercentItemObject.Title, iPercentItemObject.Color, iPercentItemObject.Value);
    end;

  iPieChart.TitleText                := TitleEdit.AsString;
  iPieChart.TitleMargin              := TitleMarginEdit.AsInteger;
  iPieChart.TitleHorizontalAlignment := TiTitleHorizontalAlignment(TitleHorizontalAlignmentRadioGroup.AsInteger);

  iPieChart.OuterMargin              := OuterMarginEdit.AsInteger;
  iPieChart.StartDegrees             := StartDegreesEdit.AsInteger;
  iPieChart.BackGroundColor          := BackGroundColorPicker.Color;
  iPieChart.BorderStyle              := TiBevelStyle(BorderStyleRadioGroup.AsInteger);
  iPieChart.Transparent              := TransparentCheckBox.AsBoolean;
  iPieChart.AutoFrameRate            := AutoFrameRateCheckBox.AsBoolean;
  iPieChart.UpdateFrameRate          := UpdateFrameRateEdit.AsInteger;

  iPieChart.LegendMargin             := LegendMarginEdit.AsInteger;

  iPieChart.LegendShowValue          := LegendShowValueCheckBox.AsBoolean;
  iPieChart.LegendValueMargin        := LegendValueMarginEdit.AsInteger;
  iPieChart.LegendValuePrecision     := LegendValuePrecisionEdit.AsInteger;

  iPieChart.LegendShowPercent        := LegendShowPercentCheckBox.AsBoolean;
  iPieChart.LegendPercentMargin      := LegendPercentMarginEdit.AsInteger;
  iPieChart.LegendPercentPrecision   := LegendPercentPrecisionEdit.AsInteger;

  iPieChart.LegendFont.Assign(LegendFontPicker.Font);
  iPieChart.TitleFont.Assign (TitleFontPicker.Font);

  DownLoadOPCProperties(iPieChart, iOPCBrowserPanel);
end;
//****************************************************************************************************************************************************
end.
