
(*

Here is simple component for providing readonly 
DBTree with TIBQuery component.

Properties:

FieldId - key field for table.
FieldName - text field, which will be in TreeView nodes.
FieldParentId -field with  reference to parent id.
IB_Connection, IB_Transaction - ...
RootId - identifier of root node
RootName - text in root node

Forexample, thereis table TREE:
TREE_ID integer not null primary key,
TREE_PARENT_ID integer not null references TREE,
TREE_NODE_TEXT varchar(120)

Values:
1,1,"Tree root" 
2,1,"First node"
3,1,"Second node"
4,2,"Under the first node"

Property values:
FieldId = "TREE_ID"
FieldName = "TREE_NODE_TEXT"
FieldParentId = "TREE_PARENT_ID"
RootId = 1
RootName = "Sample tree"

Methods:
ClearTree
BuildTree
... and any of TTreeView methods.

______________________
Ruslan Strelba
Email: RUST@FARLEP.NET

*)


unit DBTrees;

interface

uses ComCtrls, DB, Classes, SysUtils, IBDataSet, IB_Components;

type

TTreeNodeInfo=record
   Id:Integer;
   ParentId:Integer;
end;

TDB_TreeView=class(TTreeView)
private
     //
     FId,FParentId,FName:string;
     FRootId : Integer;
     FTableName : String;
     FIB_Connection  : TIB_Connection;
     FIB_Transaction : TIB_Transaction;
     FQuery : TIBQuery;
     FRootName : String;
     //
     procedure BuildNode(ParentId:Integer;ParentNode:TTreeNode);
     procedure OnExpand(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
public
     procedure BuildTree;
     procedure ClearTree;
     //
     constructor Create(AOwner:TComponent); override;
     destructor  Destroy; virtual;
     //
     procedure RebuildNode(ParentNode:TTreeNode);
     function GetId : Integer;
published
     property IB_Connection : TIB_Connection read FIB_Connection write FIB_Connection;
     property IB_Transaction : TIB_Transaction read FIB_Transaction write FIB_Transaction;
     property RootId : Integer read FRootId write FRootId;
     property TableName : string read FTableName write FTableName;
     property FieldId:string Read FId Write FId;
     property FieldParentId:string Read FParentId Write FParentId;
     property FieldName:string Read FName Write FName;
     property RootName : String read FRootName write FRootName;
end;

procedure Register;

implementation

function TDB_TreeView.GetId : Integer;
begin
     Result:=Integer(Selected.Data);
end;

constructor TDB_TreeView.Create(AOwner:TComponent);
begin
     inherited Create(AOwner);
     //
     FQuery:=TIBQuery.Create(Self);
     //
     Self.OnExpanding:=OnExpand;
end;

procedure TDB_TreeView.OnExpand(Sender: TObject; Node: TTreeNode; var AllowExpansion: Boolean);
begin
     //Items.BeginUpdate;
     BuildNode(Integer(Node.Data),Node);
     //Items.EndUpdate;
end;

destructor TDB_TreeView.Destroy;
begin
     inherited;
     FQuery.Free;
end;

procedure TDB_TreeView.BuildNode(ParentId:Integer;ParentNode:TTreeNode);
var NodeInfo:^TTreeNodeInfo;
    parent_node:TTreeNode;
    node:TTreeNode;
begin
     if (ParentNode=nil)  then
     begin
          ClearTree;
          //
          parent_node:=Items.AddObject(Selected,FRootName,NodeInfo);
          parent_node.Data:=Pointer(FRootId);
     end
     else
     begin
          ParentNode.DeleteChildren;
          parent_node:=ParentNode;
     end;
     //
     FQuery.Close;
     FQuery.IB_Connection := FIB_Connection;
     FQuery.IB_Transaction := FIB_Transaction;
     FQuery.SQL.Clear;
     if ParentId>=0
     then FQuery.SQL.Add(Format('Select c1.%s,c1.%s,(select count(*) from %s c2 where c2.%s=c1.%s) ChildCount From %s c1 Where c1.%s=%d and c1.%s<>%d Order by c1.%s',[FId,FName,FTableName,FParentId,FId,FTableName,FParentId,ParentId,FId,FRootId,FName]))
     else FQuery.SQL.Add(Format('Select c1.%s,c1.%s,(select count(*) from %s c2 where c2.%s=c1.%s) ChildCount From %s c1 Where c1.%s is null Order by c1.%s',[FId,FName,FTableName,FParentId,FId,FTableName,FParentId,FId,FName]));
     FQuery.Open;
     //
     FQuery.First;
     while not FQuery.EOF do
     begin
          //
          node:=Items.AddChild(parent_node,FQuery.FieldByName(FName).AsString);
          node.Data:=Pointer(FQuery.FieldByName(FId).AsInteger);
          node.ImageIndex := -1;
          if FQuery.FieldByName('ChildCount').AsInteger>0 then Items.AddChild(node,'');
          //
          FQuery.Next;
     end;
end;

procedure TDB_TreeView.BuildTree;
begin
     Items.BeginUpdate;
     BuildNode(FRootId,nil);
     Items.EndUpdate;
end;

procedure TDB_TreeView.ClearTree;
begin
     Items.BeginUpdate;
     While Items.Count>0 do Items.Delete(Items[0]);
     Items.EndUpdate;
end;

procedure TDB_TreeView.RebuildNode(ParentNode:TTreeNode);
var ParentId:Integer;
begin
     //
     BuildNode(Integer(ParentNode),ParentNode);
     //ParentNode.Expand(True);
end;


procedure Register;
begin
     RegisterComponents('Data Controls',[TDB_TreeView]);
end;

end.
