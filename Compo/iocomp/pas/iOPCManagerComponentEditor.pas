{*******************************************************}
{                                                       }
{       TiOPCManagerComponentEditor                     }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCManagerComponentEditor;{$endif}
{$ifdef iCLX}unit QiOPCManagerComponentEditor;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}

  {$IFDEF iVCL} iComponentEditorForm,  iTypes,  iOPCManager,{$ENDIF}
  {$IFDEF iCLX}QiComponentEditorForm, QiTypes, QiOPCManager,{$ENDIF}

  {$IFDEF iVCL}  StdCtrls,  ExtCtrls,  Controls,  ComCtrls, Classes,  iComponentEditorButtonPanel,  iEditorBasicComponents,  iAboutPanel,  iComponent,  iVCLComponent,  iCustomComponent,  iCheckBox,  iOPCBrowserPanel;{$ENDIF}
  {$IFDEF iCLX} QStdCtrls, QExtCtrls, QControls, QComCtrls, Classes, QiComponentEditorButtonPanel, QiEditorBasicComponents, QiAboutPanel, QiComponent, QiCLXComponent, QiCustomComponent, QiCheckBox, QiOPCBrowserPanel;{$ENDIF}

type
  TiOPCManagerComponentEditorForm = class(TiComponentEditorForm)
    PageControl: TiComponentEditorPageControl;
    GeneralTabSheet: TTabSheet;
    AboutTabSheet: TTabSheet;
    iComponentEditorButtonPanel1: TiComponentEditorButtonPanel;
    iAboutPanel1: TiAboutPanel;
    Label1: TLabel;
    Label9: TLabel;
    ItemListBox: TiComponentEditorListBox;
    iGroupItemAddButton: TButton;
    GroupRemoveButton: TButton;
    ItemPropertiesGroupBox: TGroupBox;
    iOPCBrowserPanel: TiOPCBrowserPanel;
    procedure iComponentEditorFormDestroy(Sender: TObject);
    procedure iGroupItemAddButtonClick(Sender: TObject);
    procedure GroupRemoveButtonClick(Sender: TObject);
    procedure ItemListBoxClick(Sender: TObject);
    procedure ItemChange(Sender: TObject);
    procedure ItemListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
    procedure ItemListBoxItemMove(Sender: TObject);
  private
    FLastIndex     : Integer;

    procedure UpdateItemEdit;
    procedure ClearList;
  protected
    procedure CreateThemeInstance;                               override;
    procedure CopyPropertiesToForm     (Component: TWinControl); override;
    procedure CopyPropertiesToComponent(Component: TWinControl); override;
  end;

var
  iOPCManagerComponentEditorForm: TiOPCManagerComponentEditorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.iComponentEditorFormDestroy(Sender: TObject);
begin
  ClearList;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.CreateThemeInstance;
begin

end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.ClearList;
begin
  while ItemListBox.Items.Count > 0 do
    begin
      ItemListBox.Items.Objects[0].Free;
      ItemListBox.Items.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.iGroupItemAddButtonClick(Sender: TObject);
var
  iOPCGroupStream : TiOPCGroupStream;
begin
  iOPCGroupStream            := TiOPCGroupStream.Create;
  iOPCGroupStream.Name       := 'Untitled';
  iOPCGroupStream.UpdateRate := 500;
  ItemListBox.ItemIndex      := ItemListBox.Items.AddObject(iOPCGroupStream.Name, iOPCGroupStream);

  UpdateItemEdit;

  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.GroupRemoveButtonClick(Sender: TObject);
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
procedure TiOPCManagerComponentEditorForm.ItemListBoxClick(Sender: TObject);
begin
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.ItemListBoxGetData(const Index: Integer; var DrawColorBox: Boolean; var AColor: TColor; var AText: String);
begin
  AText := (ItemListBox.Items.Objects[Index] as TiOPCGroupStream).Name;
  DrawColorBox := False;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.ItemListBoxItemMove(Sender: TObject);
begin
  Modified := True;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.UpdateItemEdit;
var
  iOPCGroupStream : TiOPCGroupStream;
begin
  if ItemListBox.ItemIndex = - 1 then
    begin
      iOPCBrowserPanel.RemoveAllItems;
      iOPCBrowserPanel.UpdateItemEdit;

      GroupRemoveButton.Enabled := False;
    end
  else
    begin
      if iOPCBrowserPanel.ItemCount = 0 then iOPCBrowserPanel.AddItem;
      iOPCBrowserPanel.UpdateItemEdit;

      iOPCGroupStream := ItemListBox.Items.Objects[ItemListBox.ItemIndex] as TiOPCGroupStream;

      iOPCBrowserPanel.SetGroupName   (0, iOPCGroupStream.Name);
      iOPCBrowserPanel.SetComputerName(0, iOPCGroupStream.ComputerName);
      iOPCBrowserPanel.SetServerName  (0, iOPCGroupStream.OPCServerName);
      iOPCBrowserPanel.SetUpdateRate  (0, iOPCGroupStream.UpdateRate);

      iOPCBrowserPanel.UpdateItemEdit;

      GroupRemoveButton.Enabled := True;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.ItemChange(Sender: TObject);
var
  iOPCGroupStream : TiOPCGroupStream;
begin
  if ItemListBox.ItemIndex = -1 then Exit;

  iOPCGroupStream := ItemListBox.Items.Objects[ItemListBox.ItemIndex] as TiOPCGroupStream;

  iOPCGroupStream.Name          := iOPCBrowserPanel.GetGroupName(0);
  iOPCGroupStream.ComputerName  := iOPCBrowserPanel.GetComputerName(0);
  iOPCGroupStream.OPCServerName := iOPCBrowserPanel.GetServerName(0);
  iOPCGroupStream.UpdateRate    := iOPCBrowserPanel.GetUpdateRate(0);

  UpdateItemEdit;
  ItemListBox.Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.CopyPropertiesToForm(Component: TWinControl);
var
  x               : Integer;
  iOPCManager     : TiOPCManager;
  iOPCGroupStream : TiOPCGroupStream;
begin
  iOPCManager := Component as TiOPCManager;

  ClearList;

  for x := 0 to iOPCManager.GroupCount-1 do
    begin
      iOPCGroupStream               := TiOPCGroupStream.Create;
      iOPCGroupStream.Name          := iOPCManager.Group[x].Name;
      iOPCGroupStream.ComputerName  := iOPCManager.Group[x].ComputerName;
      iOPCGroupStream.OPCServerName := iOPCManager.Group[x].OPCServerName;
      iOPCGroupStream.UpdateRate    := iOPCManager.Group[x].UpdateRate;

      ItemListBox.Items.AddObject('', iOPCGroupStream)
    end;

  if ItemListBox.Items.Count > FLastIndex then ItemListBox.ItemIndex := FLastIndex;
  UpdateItemEdit;
end;
//****************************************************************************************************************************************************
procedure TiOPCManagerComponentEditorForm.CopyPropertiesToComponent(Component: TWinControl);
var
  x           : Integer;
  iOPCManager : TiOPCManager;
begin
  iOPCManager := Component as TiOPCManager;

  iOPCManager.GroupClear;

  for x := 0 to ItemListBox.Items.Count-1 do
    begin
      iOPCManager.GroupAdd((ItemListBox.Items.Objects[x] as TiOPCGroupStream).Name,
                           (ItemListBox.Items.Objects[x] as TiOPCGroupStream).ComputerName,
                           (ItemListBox.Items.Objects[x] as TiOPCGroupStream).OPCServerName,
                           (ItemListBox.Items.Objects[x] as TiOPCGroupStream).UpdateRate);
    end;
  FLastIndex := ItemListBox.ItemIndex;
end;
//****************************************************************************************************************************************************
end.
