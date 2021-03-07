{*******************************************************}
{                                                       }
{       TiOPCItemSelectorForm                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCItemSelector;{$endif}
{$ifdef iCLX}unit QiOPCItemSelector;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}             
  {$IFDEF iVCL}  iEditorBasicComponents,  StdCtrls,  Controls,  ComCtrls,  ExtCtrls,  ImgList, Classes,{$ENDIF}
  {$IFDEF iCLX}QiEditorBasicComponents,  QStdCtrls, QControls, QComCtrls, QExtCtrls, QImgList, Classes,{$ENDIF}

  {$IFDEF iVCL} iOPCDLLLoader,  iTypes;{$ENDIF}
  {$IFDEF iCLX}QiOPCDLLLoader, QiTypes;{$ENDIF}


type
  TiOPCItemSelectorForm = class(TForm)
    ImageList: TImageList;
    TreeView: TTreeView;
    Panel1: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    StatusBar1: TStatusBar;
    OPCItemName: TLabel;
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure ListViewDblClick(Sender: TObject);
    procedure TreeViewExpanded(Sender: TObject; Node: TTreeNode);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewDblClick(Sender: TObject);
    procedure TreeViewKeyPress(Sender: TObject; var Key: Char);
  private
    FSessionHandle : Integer;
  protected
    procedure LoadFlat;
    procedure LoadHierarchial;
    procedure AddLevel(CurrentTreeNode: TTreeNode);
  public
    procedure Setup(MachineName, OPCServerName: String);
    property  SessionHandle : Integer read FSessionHandle write FSessionHandle;
  end;

var
  iOPCItemSelectorForm: TiOPCItemSelectorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.Setup(MachineName, OPCServerName: String);
var
  iNameSpaceType : TiNameSpaceType;
begin
  TreeView.Items.Clear;

  OPCDLLEditorItemSetup(SessionHandle, PChar(MachineName), PChar(OPCServerName));


  iNameSpaceType := OPCDLLEditorItemGetBrowseType(SessionHandle);

  if   iNameSpaceType = instFlat then LoadFlat
  else                                LoadHierarchial;

  OKButton.Enabled := False;
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.LoadFlat;
var
  x          : Integer;
  StringList : TStringList;
begin
  StringList := TStringList.Create;
  try
    StringList.Text := OPCDLLEditorItemGetBranchItems(SessionHandle, ibtFlat);
    for x := 0 to StringList.Count-1 do
      TreeView.Items.Add(nil, StringList.Strings[x]);
  finally
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.LoadHierarchial;
begin
  AddLevel(nil);
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.AddLevel(CurrentTreeNode: TTreeNode);
var
  x          : Integer;
  TreeNode   : TTreeNode;
  StringList : TStringList;
begin
  StringList := TStringList.Create;
  try
    StringList.Text := OPCDLLEditorItemGetBranchItems(SessionHandle, ibtLeaf);
    for x := 0 to StringList.Count-1 do
      begin
        if Assigned(CurrentTreeNode) then
          TreeNode := TreeView.Items.AddChild(CurrentTreeNode, StringList.Strings[x])
        else
          TreeNode := TreeView.Items.Add(nil, StringList.Strings[x]);

        TreeNode.ImageIndex    := 0;
        TreeNode.SelectedIndex := 0;
      end;

    StringList.Text := OPCDLLEditorItemGetBranchItems(SessionHandle, ibtBranch);
    for x := 0 to StringList.Count-1 do
      begin
        if Assigned(CurrentTreeNode) then
          TreeNode := TreeView.Items.AddChild(CurrentTreeNode, StringList.Strings[x])
        else
          TreeNode := TreeView.Items.Add(nil, StringList.Strings[x]);

        TreeView.Items.AddChild(TreeNode, '(Unknown)');

        TreeNode.ImageIndex    := 1;
        TreeNode.SelectedIndex := 1;
      end;

  finally
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
//  OPCItemName.Caption := Item.Caption;
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.ListViewDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.TreeViewExpanded(Sender: TObject; Node: TTreeNode);
var
  CurrentNode : TTreeNode;
  StringList  : TStringList;
begin
  if Node.Count <> 1 then
    begin
      OKButton.Enabled    := False;
      OPCItemName.Caption := '';
      Exit;
    end;

  if (Node.Count = 1) and (Node.Item[0].Text <> '(Unknown)') then Exit;

  Node.Item[0].Free;

  CurrentNode := Node;
  StringList := TStringList.Create;
  try
    StringList.Add(Node.Text);
    while Assigned(CurrentNode.Parent) do
      begin
        CurrentNode := CurrentNode.Parent;
        StringList.Add(CurrentNode.Text);
      end;

    OPCDLLEditorItemSetPath(SessionHandle, PCHar(StringList.Text));

    AddLevel(Node);
  finally
    StringList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
var
  CurrentNode   : TTreeNode;
  StringList    : TStringList;
  TempString    : String;
  NodeText      : String;
begin
  if Node.ImageIndex = 1 then
    begin
      OKButton.Enabled    := False;
      OPCItemName.Caption := '';
      Exit;
    end;

  CurrentNode := Node;
  StringList := TStringList.Create;
  try
    while Assigned(CurrentNode.Parent) do
      begin
        StringList.Add(CurrentNode.Parent.Text);
        CurrentNode := CurrentNode.Parent;
      end;

     NodeText   := Node.Text;
     TempString := OPCDLLEditorItemGetQualifiedName(SessionHandle, PChar(StringList.Text), PChar(NodeText));
     OPCItemName.Caption := TempString;

   finally
     StringList.Free;
   end;
  OKButton.Enabled := True;
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.TreeViewDblClick(Sender: TObject);
begin
  if not Assigned(TreeView.Selected) then Exit;
  if TreeView.Selected.ImageIndex <> 0 then Exit;
  ModalResult := mrOk;
end;
//****************************************************************************************************************************************************
procedure TiOPCItemSelectorForm.TreeViewKeyPress(Sender: TObject; var Key: Char);
begin
  if TreeView.Selected.ImageIndex <> 0 then Exit;
  if Key = #13 then
    begin
      Key := #0;
      ModalResult := mrOk;
    end;
end;
//****************************************************************************************************************************************************
end.
