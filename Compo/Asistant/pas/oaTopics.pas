{------------------------------------------------------------------------------}
{                                                                              }
{  Office Assistant                                                            }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}

{$I DELPHIAREA.INC}

unit oaTopics;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, oaBaloon;

type
  TTopicsEditor = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Items: TGroupBox;
    TopicItems: TTreeView;
    btnNew: TButton;
    btnDelete: TButton;
    btnClear: TButton;
    ItemProperties: TGroupBox;
    Label1: TLabel;
    TopicCaption: TEdit;
    Styles: TGroupBox;
    cbHeader: TCheckBox;
    cbBold: TCheckBox;
    cbUnderline: TCheckBox;
    cbItalic: TCheckBox;
    cbHoverBold: TCheckBox;
    cbHoverUnderline: TCheckBox;
    cbHoverItalic: TCheckBox;
    Label2: TLabel;
    TopicIDEdit: TEdit;
    DefaultID: TLabel;
    TopicID: TUpDown;
    btnMoveUp: TButton;
    btnMoveDown: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure TopicCaptionChange(Sender: TObject);
    procedure cbHeaderClick(Sender: TObject);
    procedure cbBoldClick(Sender: TObject);
    procedure cbUnderlineClick(Sender: TObject);
    procedure cbItalicClick(Sender: TObject);
    procedure cbHoverBoldClick(Sender: TObject);
    procedure cbHoverUnderlineClick(Sender: TObject);
    procedure cbHoverItalicClick(Sender: TObject);
    procedure TopicIDChange(Sender: TObject);
    procedure TopicIDEditKeyPress(Sender: TObject; var Key: Char);
    procedure TopicItemsChange(Sender: TObject; Node: TTreeNode);
    procedure TopicItemsEdited(Sender: TObject; Node: TTreeNode; var S: String);
    procedure TopicItemsDeletion(Sender: TObject; Node: TTreeNode);
    procedure TopicItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TopicItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    Topics: TTopicsList;
    procedure LoadTopics;
    procedure SaveTopics;
    procedure CheckHoverStates;
  public
    class function Execute(const AClassPath: String; ATopics: TTopicsList): Boolean;
  end;

implementation

{$R *.DFM}

uses oaTypes;

class function TTopicsEditor.Execute(const AClassPath: String;
  ATopics: TTopicsList): Boolean;
begin
  Result := False;
  if Assigned(ATopics) then
  begin
    with Create(Application) do
      try
        Topics := ATopics;
        Caption := AClassPath + '.' + Caption;
        {$IFDEF COMPILER4_UP}
        TopicItems.BorderWidth := 1;
        {$ENDIF}
        Result := (ShowModal = mrOK);
      finally
        Free;
      end;
  end;
end;

procedure TTopicsEditor.LoadTopics;
var
  I: Integer;
  Node: TTreeNode;
begin
  TopicItems.Items.BeginUpdate;
  try
    TopicItems.Items.Clear;
    for I := 0 to Topics.Count-1 do
    begin
      Node := TopicItems.Items.Add(nil, Topics[I]);
      Node.Data := TTopicOptions.Create;
      TTopicOptions(Node.Data).Assign(Topics.Options[I]);
    end;
  finally
    TopicItems.Items.EndUpdate;
  end;
  if TopicItems.Items.Count > 0 then
    TopicItems.Selected := TopicItems.Items[0]
  else
    TopicItemsChange(TopicItems, TopicItems.Selected);
end;

procedure TTopicsEditor.SaveTopics;
var
  I: Integer;
begin
  Topics.BeginUpdate;
  try
    Topics.Clear;
    for I := 0 to TopicItems.Items.Count-1 do
      with TopicItems.Items[I] do
        Topics.AddOptions(Text, TTopicOptions(Data));
  finally
    Topics.EndUpdate;
  end;
end;

procedure TTopicsEditor.CheckHoverStates;
begin
  cbHoverBold.Enabled := not (cbHeader.Checked or cbBold.Checked);
  cbHoverBold.Checked := (cbHoverBold.Checked or cbBold.Checked);
  cbHoverUnderline.Enabled := not (cbHeader.Checked or cbUnderline.Checked);
  cbHoverUnderline.Checked := (cbHoverUnderline.Checked or cbUnderline.Checked);
  cbHoverItalic.Enabled := not (cbHeader.Checked or cbItalic.Checked);
  cbHoverItalic.Checked := (cbHoverItalic.Checked or cbItalic.Checked);
end;

procedure TTopicsEditor.FormShow(Sender: TObject);
begin
  LoadTopics;
end;

procedure TTopicsEditor.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (ActiveControl = TopicItems) and
     (GetFocus <> TopicItems.Handle) and
     (TopicItems.Selected <> nil) then
  begin
    TopicItems.Selected.EndEdit(ModalResult = mrCancel);
    CanClose := False;
  end
  else if ModalResult = mrOK then
    SaveTopics;
end;

procedure TTopicsEditor.btnNewClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  Node := TopicItems.Items.AddChildObject(nil, '', TTopicOptions.Create);
  TopicItems.Selected := Node;
  Node.EditText;
end;

procedure TTopicsEditor.btnDeleteClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := TopicItems.Selected.Index;
  TTopicOptions(TopicItems.Selected.Data).Free;
  TopicItems.Selected.Delete;
  if Index = TopicItems.Items.Count then
    Dec(Index);
  if Index >= 0 then
    TopicItems.Selected := TopicItems.Items[Index]
  else
    TopicItemsChange(TopicItems, TopicItems.Selected);
end;

procedure TTopicsEditor.btnClearClick(Sender: TObject);
begin
  TopicItems.Items.Clear;
  TopicItemsChange(TopicItems, TopicItems.Selected);
end;

procedure TTopicsEditor.btnMoveUpClick(Sender: TObject);
var
  Src, Dst: TTreeNode;
begin
  Src := TopicItems.Selected;
  if Assigned(Src) then
  begin
    Dst := Src.getPrevSibling;
    if Assigned(Dst) then
    begin
      Src.MoveTo(Dst, naInsert);
      TopicItemsChange(TopicItems, TopicItems.Selected);
    end;
  end;
end;

procedure TTopicsEditor.btnMoveDownClick(Sender: TObject);
var
  Src, Dst: TTreeNode;
begin
  Dst := TopicItems.Selected;
  if Assigned(Dst) then
  begin
    Src := Dst.getNextSibling;
    if Assigned(Src) then
    begin
      Src.MoveTo(Dst, naInsert);
      TopicItemsChange(TopicItems, TopicItems.Selected);
    end;
  end;
end;

procedure TTopicsEditor.TopicCaptionChange(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
    TopicItems.Selected.Text := TopicCaption.Text;
end;

procedure TTopicsEditor.cbHeaderClick(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
  begin
    with TTopicOptions(TopicItems.Selected.Data) do
      if cbHeader.Checked then
        Styles := Styles + [tsHeader]
      else
        Styles := Styles - [tsHeader];
    CheckHoverStates;
  end
end;

procedure TTopicsEditor.cbBoldClick(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
  begin
    with TTopicOptions(TopicItems.Selected.Data) do
      if cbBold.Checked then
        Styles := Styles + [tsBold]
      else
        Styles := Styles - [tsBold];
    CheckHoverStates;
  end;
end;

procedure TTopicsEditor.cbUnderlineClick(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
  begin
    with TTopicOptions(TopicItems.Selected.Data) do
      if cbUnderline.Checked then
        Styles := Styles + [tsUnderline]
      else
        Styles := Styles - [tsUnderline];
    CheckHoverStates;
  end;
end;

procedure TTopicsEditor.cbItalicClick(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
  begin
    with TTopicOptions(TopicItems.Selected.Data) do
      if cbItalic.Checked then
        Styles := Styles + [tsItalic]
      else
        Styles := Styles - [tsItalic];
    CheckHoverStates;
  end;
end;

procedure TTopicsEditor.cbHoverBoldClick(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
  begin
    with TTopicOptions(TopicItems.Selected.Data) do
      if cbHoverBold.Checked then
        Styles := Styles + [tsHoverBold]
      else
        Styles := Styles - [tsHoverBold];
  end;
end;

procedure TTopicsEditor.cbHoverUnderlineClick(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
  begin
    with TTopicOptions(TopicItems.Selected.Data) do
      if cbHoverUnderline.Checked then
        Styles := Styles + [tsHoverUnderline]
      else
        Styles := Styles - [tsHoverUnderline];
  end;
end;

procedure TTopicsEditor.cbHoverItalicClick(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
  begin
    with TTopicOptions(TopicItems.Selected.Data) do
      if cbHoverItalic.Checked then
        Styles := Styles + [tsHoverItalic]
      else
        Styles := Styles - [tsHoverItalic];
  end;
end;

procedure TTopicsEditor.TopicIDChange(Sender: TObject);
begin
  if TopicItems.Selected <> nil then
  begin
    TTopicOptions(TopicItems.Selected.Data).ID := TopicID.Position;
    if TopicID.Position < 0 then
      DefaultID.Caption := Format('Default ID = %d', [TopicItems.Selected.Index])
    else
      DefaultID.Caption := '';
  end;
end;

procedure TTopicsEditor.TopicIDEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not (AnsiChar(Key) in ['-', '0'..'9', ^V, ^C, ^X, #8]) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
end;

procedure TTopicsEditor.TopicItemsChange(Sender: TObject; Node: TTreeNode);
begin
  btnClear.Enabled := (TopicItems.Items.Count > 0);
  btnMoveUp.Enabled := Assigned(Node) and (Node.Index > 0);
  btnMoveDown.Enabled := Assigned(Node) and (Node.Index < TopicItems.Items.Count - 1);
  btnDelete.Enabled := Assigned(Node);
  ItemProperties.Enabled := Assigned(Node);
  if Node = nil then
  begin
    TopicCaption.Text := '';
    cbHeader.Checked := False;
    cbBold.Checked := False;
    cbUnderline.Checked := False;
    cbItalic.Checked := False;
    cbHoverBold.Checked := False;
    cbHoverUnderline.Checked := False;
    cbHoverItalic.Checked := False;
    cbHoverBold.Enabled := True;
    cbHoverUnderline.Enabled := True;
    cbHoverItalic.Enabled := True;
    TopicID.Position := -1;
    TopicID.Associate := nil;
    TopicIDEdit.Text := '';
    DefaultID.Caption := '';
  end
  else
  begin
    TopicCaption.Text := Node.Text;
    cbHeader.Checked := (tsHeader in TTopicOptions(Node.Data).Styles);
    cbBold.Checked := (tsBold in TTopicOptions(Node.Data).Styles);
    cbUnderline.Checked := (tsUnderline in TTopicOptions(Node.Data).Styles);
    cbItalic.Checked := (tsItalic in TTopicOptions(Node.Data).Styles);
    cbHoverBold.Checked := (tsHoverBold in TTopicOptions(Node.Data).Styles);
    cbHoverUnderline.Checked := (tsHoverUnderline in TTopicOptions(Node.Data).Styles);
    cbHoverItalic.Checked := (tsHoverItalic in TTopicOptions(Node.Data).Styles);
    CheckHoverStates;
    TopicID.Position := TTopicOptions(Node.Data).ID;
    TopicID.Associate := TopicIDEdit;
    if TTopicOptions(Node.Data).ID < 0 then
      DefaultID.Caption := Format('Default ID = %d', [Node.Index])
    else
      DefaultID.Caption := '';
  end;
end;

procedure TTopicsEditor.TopicItemsEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  TopicCaption.Text := S;
end;

procedure TTopicsEditor.TopicItemsDeletion(Sender: TObject;
  Node: TTreeNode);
begin
  if Assigned(Node.Data) then
  begin
    TTopicOptions(Node.Data).Free;
    Node.Data := nil;
  end;
end;

procedure TTopicsEditor.TopicItemsDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Sender = Source);
end;

procedure TTopicsEditor.TopicItemsDragDrop(Sender, Source: TObject;
  X, Y: Integer);
var
  Src, Dst: TTreeNode;
begin
  Src := TopicItems.Selected;
  Dst := TopicItems.DropTarget;
  if Assigned(Src) and Assigned(Dst) and (Src <> Dst) then
  begin
    if Dst.getNextSibling = nil then
      Src.MoveTo(nil, naAdd)
    else if Src = Dst.getPrevSibling then
      Dst.MoveTo(Src, naInsert)
    else
      Src.MoveTo(Dst, naInsert);
    TopicItemsChange(TopicItems, TopicItems.Selected);
  end;
end;

end.
