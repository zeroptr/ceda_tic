{*******************************************************}
{                                                       }
{       TiOPCComputerSelectorForm                       }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCComputerSelector;{$endif}
{$ifdef iCLX}unit QiOPCComputerSelector;{$endif}

interface

uses
  {$I iIncludeUsesForms.inc}             
  {$IFDEF iVCL} StdCtrls,  Controls,  ComCtrls,  ExtCtrls,  ImgList, Classes,  iOPCDLLLoader,  iTypes;{$ENDIF}
  {$IFDEF iCLX}QStdCtrls, QControls, QComCtrls, QExtCtrls, QImgList, Classes, QiOPCDLLLoader, QiTypes;{$ENDIF}

type
  TNetObject = class(TObject)
  public
    dwScope       : DWORD;
    dwType        : DWORD;
    dwDisplayType : DWORD;
    dwUsage       : DWORD;
    lpLocalName   : String;
    lpRemoteName  : String;
    lpComment     : String;
    lpProvider    : String;
  end;

type
  TiOPCComputerSelectorForm = class(TForm)
    ImageList: TImageList;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    TreeView: TTreeView;
    procedure TreeViewExpanded(Sender: TObject; Node: TTreeNode);
    procedure TreeViewDblClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewKeyPress(Sender: TObject; var Key: Char);
    procedure TreeViewDeletion(Sender: TObject; Node: TTreeNode);
  private
    FComputerName  : String;
    FSessionHandle : Integer;
  protected
    procedure AddBranch     (CurrentTreeNode: TTreeNode);
    procedure AddBranchItems(CurrentTreeNode: TTreeNode);
  public
    procedure Setup;

    property ComputerName  : String  read FComputerName  write FComputerName;
    property SessionHandle : Integer read FSessionHandle write FSessionHandle;
  end;

var
  iOPCComputerSelectorForm: TiOPCComputerSelectorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiOPCComputerSelectorForm.Setup;
begin
  TreeView.Items.Clear;
  AddBranch(nil);
end;
//****************************************************************************************************************************************************
procedure TiOPCComputerSelectorForm.AddBranch(CurrentTreeNode: TTreeNode);
var
  NetObject : TNetObject;
  iNetData  : TiNetData;
begin
  if Assigned(CurrentTreeNode) then
    begin
      NetObject              := CurrentTreeNode.Data;

      iNetData.Assigned      := True;
      iNetData.dwScope       := NetObject.dwScope;
      iNetData.dwType        := NetObject.dwType;
      iNetData.dwDisplayType := NetObject.dwDisplayType;
      iNetData.dwUsage       := NetObject.dwUsage;
      iNetData.lpLocalName   := PChar(NetObject.lpLocalName);
      iNetData.lpRemoteName  := PChar(NetObject.lpRemoteName);
      iNetData.lpComment     := PChar(NetObject.lpComment);
      iNetData.lpProvider    := PChar(NetObject.lpProvider);

      OPCDLLEditorComputerBranchOpen(SessionHandle, iNetData);
      try
        AddBranchItems(CurrentTreeNode);
      finally
        OPCDLLEditorComputerBranchClose(SessionHandle);
      end;
    end
  else
    begin
      iNetData.Assigned := False;
      OPCDLLEditorComputerBranchOpen(SessionHandle, iNetData);
      try
        AddBranchItems(CurrentTreeNode);
      finally
        OPCDLLEditorComputerBranchClose(SessionHandle);
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCComputerSelectorForm.AddBranchItems(CurrentTreeNode: TTreeNode);
var
  x         : Integer;
  NetObject : TNetObject;
  iNetData  : TiNetData;
  TreeNode  : TTreeNode;
begin
  for x := 0 to OPCDLLEditorComputerBranchGetItemCount(SessionHandle)-1 do
    begin
      iNetData := OPCDLLEditorComputerBranchGetItemData(SessionHandle, x);

      case iNetData.ResourceType of
        inrtNetwork, inrtDomain : begin
                                    NetObject := TNetObject.Create;

                                    NetObject.dwScope       := iNetData.dwScope;
                                    NetObject.dwType        := iNetData.dwType;
                                    NetObject.dwDisplayType := iNetData.dwDisplayType;
                                    NetObject.dwUsage       := iNetData.dwUsage;
                                    NetObject.lpLocalName   := iNetData.lpLocalName;
                                    NetObject.lpRemoteName  := iNetData.lpRemoteName;
                                    NetObject.lpComment     := iNetData.lpComment;
                                    NetObject.lpProvider    := iNetData.lpProvider;

                                    TreeNode := TreeView.Items.AddChildObject(CurrentTreeNode, iNetData.lpRemoteName, NetObject);

                                    if iNetData.ResourceType = inrtNetwork then
                                      begin
                                        TreeNode.ImageIndex    := 0;
                                        TreeNode.SelectedIndex := 0;
                                      end
                                    else
                                      begin
                                        TreeNode.ImageIndex    := 1;
                                        TreeNode.SelectedIndex := 1;
                                      end;

                                    TreeView.Items.AddChild(TreeNode, '(Unknown)');
                                  end;
        inrtComputer            : begin
                                    if Trim(ComputerName) = '' then ComputerName := 'Local';

                                    TreeNode := TreeView.Items.AddChildObject(CurrentTreeNode, iNetData.lpRemoteName, nil);
                                    TreeNode.ImageIndex    := 2;
                                    TreeNode.SelectedIndex := 2;
                                  end;
      end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCComputerSelectorForm.TreeViewExpanded(Sender: TObject; Node: TTreeNode);
begin
  if Node.Count <> 1 then Exit;
  if (Node.Count = 1) and (Node.Item[0].Text <> '(Unknown)') then Exit;

  Node.Item[0].Free;

  Screen.Cursor := crHourGlass;
  try
    AddBranch(Node);
  finally
    Screen.Cursor := crDefault;
  end;
end;
//****************************************************************************************************************************************************
procedure TiOPCComputerSelectorForm.TreeViewDblClick(Sender: TObject);
begin
  if not Assigned(TreeView.Selected) then Exit;
  if TreeView.Selected.ImageIndex <> 2 then Exit;
  ComputerName := TreeView.Selected.Text;
  ModalResult := mrOk;
end;
//****************************************************************************************************************************************************
procedure TiOPCComputerSelectorForm.TreeViewChange(Sender: TObject; Node: TTreeNode);
begin
  if Node.ImageIndex <> 2 then
    begin
      ComputerName := '';
      OKButton.Enabled := False;
    end
  else
    begin
      ComputerName := Node.Text;
      OKButton.Enabled := True;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCComputerSelectorForm.TreeViewKeyPress(Sender: TObject; var Key: Char);
begin
  if TreeView.Selected.ImageIndex <> 2 then Exit;
  if Key = #13 then
    begin
      Key := #0;
      ModalResult := mrOk;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCComputerSelectorForm.TreeViewDeletion(Sender: TObject; Node: TTreeNode);
begin
  if Assigned(Node.Data) then
    begin
      TObject(Node.Data).Free;
      Node.Data := nil
    end;
end;
//****************************************************************************************************************************************************
end.
