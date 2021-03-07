{**************************************************************************
 * This module created by Dmitry Yatchenko dimon@kremen.ukrtel.net        *
 *	Ported to IBO by Andrew Semack 	   sammy@centr-office.poltava.ua  *
 **************************************************************************}

unit IB_Treeview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, IB_Components, Menus,CommCtrl;
type
  tSaveSelection = procedure(id:integer) of object;
  tClearData     = procedure of object;
  tSaveData      = procedure(id,master:integer) of object;
  tNewData       = function(master:integer;auto:boolean;var id:integer):boolean of object;
  tChangeData    = function(master, id:integer;  var name:string):boolean of object;
  tCopyData      = function(sourceID, destinID:integer; var name:string ):boolean of object;
  tReadWrite     = (modeRead,modeWrite);
  TIB_TreeView = class(TCustomTreeView)
  private
    { Private declarations }
    FDataSet    :tib_Dataset;
    FKeyField   :string;
    FMasterField:string;
    FDataField  :string;
    FSelectionField:string;
    FSaveSelection:tSaveSelection;
    FClearSelection:tClearData;
    FSaveData:tSaveData;
    FDeleteData:tSaveSelection;
    FNewData:tNewData;
    FChangeData:tChangeData;
    FCopyData:tCopyData;
    FRootID:longint;
    FTrashID:longint;
    FReadWrite:tReadWrite;
    FCopyEnable:boolean;
    FSelectEnable:boolean;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;

  protected
    { Protected declarations }
    PopupMenu1: TPopupMenu;
    Select1: TMenuItem;
    Cut1:    TMenuItem;
    Delete1: TMenuItem;
    Change1: TMenuItem;
    Move1:   TMenuItem;
    Copy1:   TMenuItem;
    Save1:   TMenuItem;
    Insert1:   TMenuItem;
    Insert2:   TMenuItem;
    ImageList1:tImageList;

    old1,old2:ttreenode;
    Function FindNext(var nod:tTreeNode):boolean;
    Function FindNextChild(parent:tTreeNode;var nod:tTreeNode):boolean;
    Procedure SelectMe(Sender: TObject);
    Procedure DeleteMe(Sender: TObject);
    Procedure CutMe(Sender: TObject);
    Procedure MoveMe(Sender: TObject);
    Procedure RefreshMe(Sender: TObject);
    Procedure InsertMe(Sender: TObject);
    Procedure InsertUp(Sender: TObject);
    Procedure ChangeMe(Sender: TObject);
    Procedure CopyMe(Sender: TObject);
    Function  GetCurrentID:integer;
    Procedure SetReadWrite(value:treadwrite);
    Procedure EnableCopy(value:boolean);
    Procedure EnableSelection(value:boolean);

  public
    { Public declarations }
    Constructor Create(AOwner: TComponent);override;
    Procedure LoadData;
    Procedure SaveAll;
    Procedure SaveMe(Sender: TObject);
    Function  FindNode(id:integer):tTreeNode;
  published
    { Published declarations }
    property Align;
    property Font;
    property OnChange;

    property DataSet :tib_Dataset read fDataSet     write fDataSet;
    property Field_Key    :string   read FKeyField    write FKeyField;
    property Field_Master :string   read FMasterField write FMasterField;
    property Field_Data   :string   read FDataField   write FDataField;
    property Field_Selection   :string   read FSelectionField   write FSelectionField;
    property SaveSelection:tSaveSelection read FSaveSelection write FSaveSelection;
    property ClearSelection:tClearData read fClearSelection write FClearSelection;
    property SaveData:tSaveData read FSaveData write FSaveData;
    property DeleteData:tSaveSelection read FDeleteData write FDeleteData;
    property NewData:tNewData read FNewData write FNewData ;
    property ChangeData:tChangeData read FChangeData write FChangeData;
    property CurrentID:integer read GetCurrentID;
    property RootID:longint  read FRootID write FRootID default 0;
    property CopyData:tCopyData read FCopyData write FCopyData;
    property ReadWrite:tReadWrite read fReadWrite write SetReadWrite;
    property CopyEnable:boolean  read FCopyEnable write EnableCopy default False;
    property TrashID:longint read FTrashID write FTrashID ;
    property SelectEnable:boolean read FSelectEnable write EnableSelection;
  end;
tMissed=record
   Name:string;
   key:integer;
   master:integer;
   selection:boolean;
   End;
pMissed=^tMissed;
procedure Register;

implementation
{$R IB_TreeView.res}

procedure TIB_TreeView.WMNotify(var Message: TWMNotify);
begin
// if FToolTips then inherited;
end;


Procedure TIB_TreeView.LoadData;
Var
   NotFound:tList;
   nod:tTreeNode;
   Missed:pMissed;
   pos,old:integer;
   dat:pinteger;
Label
   SkipItem;
Begin
NotFound:=tlist.Create;
items.Clear;
Old1:=nil;
Old2:=nil;
if not assigned(FDataSet) or not (FDataSet.Active) then
   exit;
FDataSet.First;
while not FDataSet.eof do Begin
   if (FDataSet.FieldByName(FMasterField).asinteger=RootID)or(FDataSet.FieldByName(FKeyField).asinteger=TrashID) then
      nod:=nil
   else Begin
      Nod:=FindNode(FDataSet.FieldByName(FMasterField).asinteger);
      if not assigned(nod) then Begin
         New(Missed);
         Missed.Name  :=FDataSet.FieldByName(FDataField).asstring;
         Missed.key   :=FDataSet.FieldByName(FKeyField).asinteger;
         Missed.master:=FDataSet.FieldByName(FMasterField).asinteger;
         Missed.selection:=(FSelectionField<>'') and (FDataSet.FieldByName(FSelectionField).isNull);
         NotFound.Add(Missed);
         Goto SkipItem;
         End;
      End;
   New(dat);
   dat^:=FDataSet.FieldByName(FKeyField).asinteger;
   nod:=Self.Items.AddChildObject(nod,FDataSet.FieldByName(FDataField).asstring,dat);
   if (FSelectionField<>'') and (FDataSet.FieldByName(FSelectionField).isNull) then
      nod.ImageIndex:=1;
   nod.SelectedIndex:=nod.ImageIndex;
   old1:=nod;
   old2:=nod.parent;
 SkipItem:
   FDataSet.Next;
   End;
old:=-1;
while (NotFound.Count>0)and(old<>NotFound.Count) do Begin
   old:=NotFound.Count;
   for pos:=NotFound.Count downto 1 do Begin
       missed:=NotFound[pos-1];
       nod:=FindNode(missed.master);
       if assigned(nod) then Begin
          New(dat);
          dat^:=missed.key;
          nod:=Self.Items.AddChildObject(nod,missed.Name,dat);
          if missed.selection then
             nod.ImageIndex:=1;
          nod.SelectedIndex:=nod.ImageIndex;
          old1:=nod;
          old2:=nod.parent;
          NotFound.Delete(pos-1);
          End;
       End;
   End;
NotFound.Destroy;
End;

Function TIB_TreeView.FindNode(id:integer):tTreeNode;
Var
   nnod:ttReeNode;

Begin
nnod:=Self.Items.GetFirstNode;
if Assigned(old1) and (Integer(old1.Data^)=id)then
   nnod:=old1
else
   if Assigned(old2) and (Integer(old2.Data^)=id)then
      nnod:=old2
   else
      while assigned(nnod) and (Integer(nnod.Data^)<>id) do
            if nnod.HasChildren then
               nnod:=nnod.GetFirstChild
            else Begin
                while assigned(nnod.parent) and not assigned(pointer(nnod.GetNextSibling))  do
                      nnod:=nnod.parent;
                nnod:=nnod.GetNextSibling
                End;
FindNode:=nnod;
End;

Constructor TIB_TreeView.Create(AOwner: TComponent);
Var
   Bmp:tBitmap;
Begin
inherited Create(AOwner);

if not (csDesigning in ComponentState) then begin
PopupMenu1:=TPopupMenu.Create(Self);
Select1:=TMenuItem.Create(Self);

Select1.Caption := 'Select';
Select1.ShortCut := 45;
Select1.OnClick := SelectMe;
Select1.Enabled := FSelectEnable;
Select1.Visible := FSelectEnable;
PopupMenu1.Items.Add(Select1);

Save1:=TMenuItem.Create(Self);
Save1.Caption := 'Save';
Save1.ShortCut := 113;
Save1.OnClick := SaveMe;
Save1.Enabled := FSelectEnable;
Save1.Visible := FSelectEnable;
PopupMenu1.Items.Add(Save1);


Change1:=TMenuItem.Create(Self);
Change1.Caption := 'Change';
Change1.ShortCut := 115;
Change1.onclick:=ChangeMe;
Change1.Enabled := Readwrite=modeWrite;
PopupMenu1.Items.Add(Change1);

Move1:=TMenuItem.Create(Self);
Move1.Caption := 'Move';
Move1.Enabled := False;
Move1.Visible:=false;
Move1.ShortCut := 116;
Move1.onclick:=MoveMe;
PopupMenu1.Items.Add(Move1);

Copy1:=TMenuItem.Create(Self);
Copy1.Caption := 'Copy';
Copy1.Enabled := False;
Copy1.Visible:=false;
Copy1.ShortCut := 8308;
Copy1.onclick:=CopyMe;
PopupMenu1.Items.Add(Copy1);

Cut1:=TMenuItem.Create(Self);
Cut1.Caption := 'Cut';
Cut1.ShortCut := 117;
Cut1.onclick:=CutMe;
Cut1.Enabled := Readwrite=modeWrite;
PopupMenu1.Items.Add(Cut1);

Insert1:=   TMenuItem.Create(Self);
Insert1.Caption := 'Insert';
Insert1.ShortCut := 118;
Insert1.onclick:=InsertUp;
Insert1.Enabled := Readwrite=modeWrite;
PopupMenu1.Items.Add(Insert1);

Insert2:=   TMenuItem.Create(Self);
Insert2.Caption := 'Add';
Insert2.ShortCut := 8310;
Insert2.onclick:=InsertMe;
Insert2.Enabled := Readwrite=modeWrite;
PopupMenu1.Items.Add(Insert2);

Delete1:=TMenuItem.Create(Self);
Delete1.Caption := 'Delete';
Delete1.ShortCut := 119;
Delete1.OnClick := DeleteMe;
Delete1.Enabled := Readwrite=modeWrite;
PopupMenu1.Items.Add(Delete1);


PopupMenu1.AutoPopup := True;
PopupMenu:=PopupMenu1;

ImageList1:=TImageList.Create(Self);
Bmp:=tBitmap.Create;
Bmp.LoadFromResourceName(HInstance,'CHECK');
ImageList1.Add(Bmp,nil);

Bmp:=tBitmap.Create;
Bmp.LoadFromResourceName(HInstance,'UNCHECK');
ImageList1.Add(Bmp,nil);

Bmp:=tBitmap.Create;
Bmp.LoadFromResourceName(HInstance,'CUT');
ImageList1.Add(Bmp,nil);

Images:=ImageList1;
End;
ReadOnly:=True;

End;


Procedure TIB_TreeView.SelectMe;
Var
  Nod:tTreeNode;
  val:integer;
Begin
if not assigned(Selected)then exit;
nod:=nil;
while FindNext(nod) do
if nod.ImageIndex=2 then Begin
   nod.ImageIndex:=1;
   nod.SelectedIndex:=1;
   End;
val:=1-Selected.ImageIndex;
nod:=nil;
while FindNextChild(Selected,nod) do Begin
  nod.ImageIndex:=val;
  nod.SelectedIndex:=val;
  End;

Repaint;
End;

Procedure TIB_TreeView.DeleteMe;
Var
   trash,nod,nextnode:ttreenode;
Begin
if not assigned(selected)then exit;
trash:=FindNode(TrashID);
if selected=Trash then exit;
if not assigned(selected.parent) then exit;
nextnode:=selected;
selected:=selected.parent;
nod:=nil;
if assigned(Selected) and (MessageDlg('ѕодтвердите удаление выбранной ветки.', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then Begin
   if assigned(FDeleteData)and(nextnode.parent=Trash)then Begin
      FDeleteData(Integer(nextnode.Data^));
      Items.Delete(nextnode);
      End
    else
      repeat
        nod:=nil;
        while FindNextChild(nextnode,nod) do
           if not nod.HasChildren then Begin
              nod.MoveTo(Trash,naAddChild);
              if nod<>nextnode then
                 nod:=nil;
              End;
      Trash.Collapse(True);
      until nextnode.parent=Trash;
   End;
while FindNext(nod) do
   if nod.ImageIndex=2 then Begin
      nod.ImageIndex:=1;
      nod.SelectedIndex:=1;
      End;
Move1.Enabled := false;
Move1.Visible := false;
Copy1.Enabled := false;
Copy1.Visible := false;
End;

Procedure TIB_TreeView.CutMe(Sender: TObject);
Var
   nod:ttreenode;
   sel:boolean;
Begin
if not assigned(Selected)then exit;
nod:=nil;
sel:=Selected.SelectedIndex<>2;
while self.FindNext(nod) do
   if nod.ImageIndex=2 then Begin
   nod.ImageIndex:=1;
   nod.SelectedIndex:=1;
   End;
nod:=nil;
if sel then
   while FindNextChild(Selected,nod) do Begin
     nod.ImageIndex:=2;
     nod.SelectedIndex:=2;
     End;
Move1.Enabled := sel;
Move1.Visible := sel;

Copy1.Enabled := Move1.Enabled and FCopyEnable;
Copy1.Visible := Move1.Visible and FCopyEnable;
Repaint;
End;

Function TIB_TreeView.FindNext(var nod:tTreeNode):boolean;
Begin
if not assigned(nod) then
   nod:=items.GetFirstNode
else
   if nod.HasChildren then
      nod:=nod.GetFirstChild
   else Begin
      while assigned(nod.parent) and not assigned(pointer(nod.GetNextSibling))  do
         nod:=nod.parent;
      nod:=nod.GetNextSibling
      End;
FindNext:=Assigned(nod);
End;

Function TIB_TreeView.FindNextChild(parent:tTreeNode;var nod:tTreeNode):boolean;
Begin
if not assigned(nod) then
   nod:=parent
else
   if nod.HasChildren then
      nod:=nod.GetFirstChild
   else Begin
      while (nod<>parent)and not assigned(pointer(nod.GetNextSibling))  do
         nod:=nod.parent;
      if Nod=parent then Begin
         FindNextChild:=false;
         Exit;
         End;
      nod:=nod.GetNextSibling
      End;
FindNextChild:=Assigned(nod);
End;

Procedure TIB_TreeView.MoveMe(Sender: TObject);
Var
   nod:ttreenode;
//   parent:integer;
Begin
if not assigned(Selected)then exit;
if selected.ImageIndex=2 then exit;
nod:=nil;
while FindNext(nod) do
   if nod.ImageIndex=2 then
      Break;
if assigned(nod)  then
   nod.MoveTo(selected,naAddChild);
End;

Procedure TIB_TreeView.SaveMe(Sender: TObject);
Var
   nod:ttreenode;
Begin
nod:=nil;
If assigned(FClearSelection) then
   ClearSelection;
if assigned(FSaveSelection) then
while FindNext(nod) do
   if nod.ImageIndex=0 then
      SaveSelection(integer(nod.data^))
End;


Procedure TIB_TreeView.RefreshMe(Sender: TObject);
Begin
Items.Clear;
LoadData;
End;

Procedure TIB_TreeView.InsertMe(Sender: TObject);
Var
   master,id:integer;
   ss:string;
   pin:pinteger;
   nod:ttreenode;
Begin
if assigned(selected) then
   master:=Integer(Selected.Data^)
else
   master:=RootID;
ss:='';
if assigned(FNewData)then
   if FNewData(master,false,id) then
      if assigned(FChangeData)then
         if FChangeData(master,id,ss)then Begin
            New(pin);
            pin^:=id;
            Selected:=Items.AddChildObject(Selected,ss,pin);
            nod:=nil;
            while FindNext(nod) do
            if nod.ImageIndex=2 then Begin
               nod.ImageIndex:=1;
               nod.SelectedIndex:=1;
               End;
            End;
End;

Procedure TIB_TreeView.ChangeMe(Sender: TObject);
Var
   parent:integer;
   ss:string;
Begin
if not assigned(Selected)then exit;
if assigned(selected.parent) then
   parent:=Integer(Selected.parent.Data^)
else
   parent:=RootID;
ss:=Selected.Text;
if assigned(FChangeData)then
   if FChangeData(parent,Integer(Selected.Data^),ss)then
      Selected.text:=ss;
End;

Procedure TIB_TreeView.SaveAll;
Var
   nod:ttreenode;
   parent:integer;

Begin
nod:=nil;
If assigned(FClearSelection) then
   ClearSelection;
if assigned(FSaveData) then
while FindNext(nod) do Begin
   if assigned(nod.parent) then
      parent:=Integer(nod.parent.Data^)
   else
      parent:=RootID;
   SaveData(integer(nod.data^),parent);
   End;
End;

Procedure TIB_TreeView.InsertUp;
Var
   ss:string;
   parent,id:integer;
   nod:ttreenode;
   pin:pinteger;
Begin
nod:=selected;
if assigned(nod)then
   nod:=nod.parent;
if assigned(nod) then
   parent:=Integer(nod.Data^)
else
   parent:=RootID;
ss:='';
if assigned(FNewData)then
   if FNewData(parent,false,id) then
      if assigned(FChangeData)then
         if FChangeData(parent,id,ss)then Begin
            New(pin);
            pin^:=id;
            Selected:=Items.AddChildObject(nod,ss,pin);
            nod:=nil;
            while FindNext(nod) do
            if nod.ImageIndex=2 then Begin
               nod.ImageIndex:=1;
               nod.SelectedIndex:=1;
               End;
            End;
End;

Function  TIB_TreeView.GetCurrentID:integer;
Begin
if assigned(Selected) then
   GetCurrentID:=integer(Selected.data^)
else
   GetCurrentID:=-1;
End;

Procedure TIB_TreeView.SetReadWrite(value:treadwrite);
Var
   nod:ttreenode;
Begin
freadwrite:=value;
nod:=nil;
while FindNext(nod) do
   if nod.ImageIndex=2 then Begin
      nod.ImageIndex:=1;
      nod.SelectedIndex:=1;
      End;
if not (csDesigning in ComponentState) then
case readwrite of
 modeRead :Begin
    Cut1.Enabled:=false;
    Delete1.Enabled:=false;
    Change1.Enabled:=false;
    Insert1.Enabled:=false;
    Insert2.Enabled:=false;

    Cut1.Visible:=false;
    Delete1.Visible:=false;
    Change1.Visible:=false;
    Insert1.Visible:=false;
    Insert2.Visible:=false;

    Move1.Enabled:=false;
    Move1.Visible:=false;
    Copy1.Enabled := Move1.Enabled and FCopyEnable;
    Copy1.Visible := Move1.Visible and FCopyEnable;
    End;
 modeWrite:Begin
    Cut1.Enabled:=true;
    Delete1.Enabled:=true;
    Change1.Enabled:=true;
    Insert1.Enabled:=true;
    Insert2.Enabled:=true;

    Cut1.Visible:=true;
    Delete1.Visible:=true;
    Change1.Visible:=true;
    Insert1.Visible:=true;
    Insert2.Visible:=true;
    End;
    End;
Repaint;
End;

Procedure TIB_TreeView.EnableCopy(value:boolean);
Begin
FCopyEnable:=value;
if not (csDesigning in ComponentState) then Begin
   Copy1.Enabled := Move1.Enabled and FCopyEnable;
   Copy1.Visible := Move1.Visible and FCopyEnable;
   End;
End;

Procedure TIB_TreeView.CopyMe(Sender: TObject);
Var
   rootnod,nod,parentnode,oldnode:ttreenode;
   id:integer;
   pin:pinteger;
   name:string;
   autocopy:boolean;
Begin
autocopy := False;
if not assigned(Selected)then exit;
if selected.ImageIndex=2 then exit;
case MessageDlg('Copy. Are you shure?', mtConfirmation, [mbOk, mbAll, mbCancel], 0)of
 mrOk  :autocopy:=false;
 mrAll :autocopy:=true;
 mrCancel:exit;
End;
rootnod:=nil;
oldnode:=nil;
parentnode:=selected;
while FindNext(rootnod) do
   if rootnod.ImageIndex=2 then
      Break;
nod:=nil;
if assigned(FNewData)then
   while FindNextChild(rootnod,nod) do Begin
      if assigned(oldnode)then
         While assigned(oldnode.Parent)do
         if oldnode=nod.Parent then
            break
         else
         if oldnode.Parent=nod.Parent then Begin
            parentnode:=parentnode.Parent;
            oldnode:=oldnode.Parent;
            End;

      if not FNewData(integer(parentnode.data^),true,id)then
         Break;
      Name:=nod.text;
      if assigned(FCopyData) then
         if not FCopyData(integer(nod.data^),id,Name) then
            break;
      if assigned(FChangeData)and not autocopy then
         FChangeData(integer(parentnode.data^),id,Name);
      New(pin);
      pin^:=id;
      parentnode:=Items.AddChildObject(parentnode,name,pin);
      parentnode.ImageIndex:=1;
      parentnode.SelectedIndex:=1;
      oldnode:=nod;
      End;
End;

Procedure TIB_TreeView.EnableSelection(value:boolean);
Begin
FSelectEnable:=Value;
if not (csDesigning in ComponentState) then begin
   Select1.Enabled := FSelectEnable;
   Select1.Visible := FSelectEnable;
   Save1.Enabled := FSelectEnable;
   Save1.Visible := FSelectEnable;
   End;
End;

procedure Register;
begin
  RegisterComponents('iboControls', [TIB_TreeView]);
end;

end.
