{*******************************************************}
{                                                       }
{       TiOPCGroupSelectorForm                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCGroupSelector;{$endif}
{$ifdef iCLX}unit QiOPCGroupSelector;{$endif}

interface

uses
  {$IFDEF iVCL}  iOPCItem,{$ENDIF}
  {$IFDEF iCLX}           {$ENDIF}

  {$I iIncludeUsesForms.inc}
  {$IFDEF iVCL}  iEditorBasicComponents,  StdCtrls,  Controls,  ComCtrls,  ExtCtrls, Classes,  ImgList,  iOPCDLLLoader;{$ENDIF}
  {$IFDEF iCLX}QiEditorBasicComponents,  QStdCtrls, QControls, QComCtrls, QExtCtrls, Classes, QImgList, QiOPCDLLLoader;{$ENDIF}

type
  TiOPCGroupSelectorForm = class(TForm)
    ListView: TListView;
    ImageList: TImageList;
    Panel1: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    StatusBar1: TStatusBar;
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure ListViewKeyPress(Sender: TObject; var Key: Char);
  private
    FGroupName : String;
    function GetGroupName: String;
  public
    procedure Setup;

    property GroupName : String read GetGroupName  write FGroupName;
  end;

var
  iOPCGroupSelectorForm: TiOPCGroupSelectorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiOPCGroupSelectorForm.Setup;
var
  x            : Integer;
  ListItem     : TListItem;
  GroupHandle  : Integer;
  IgnoreString : String;
  GroupName    : String;
begin
  ListView.Items.Clear;

  IgnoreString := 'Single Group';

  ListItem            := ListView.Items.Add;
  ListItem.Caption    := '<NONE>';
  ListItem.ImageIndex := 1;

  if OPCDLLNotLoaded then Exit;

  for x := 0 to OPCDLLGroupGetCount-1 do
    begin
      GroupHandle := OPCDLLGroupGetHandle(x);
      GroupName   := OPCDLLGroupGetName(GroupHandle);
      
      if UpperCase(Copy(GroupName, 1, Length(IgnoreString))) = UpperCase(IgnoreString) then Continue;

      ListItem            := ListView.Items.Add;
      ListItem.Caption    := OPCDLLGroupGetName(GroupHandle);
      ListItem.ImageIndex := 0;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCGroupSelectorForm.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  FGroupName := Item.Caption;
  OKButton.Enabled := True;
end;
//****************************************************************************************************************************************************
procedure TiOPCGroupSelectorForm.ListBoxDblClick(Sender: TObject);
begin
  if Assigned(ListView.Selected) then ModalResult := mrOk;
end;
//****************************************************************************************************************************************************
procedure TiOPCGroupSelectorForm.ListViewKeyPress(Sender: TObject; var Key: Char);
begin
  if not Assigned(ListView.Selected) then exit;
  if Key = #13 then
    begin
      Key := #0;
      ModalResult := mrOk;
    end;
end;
//****************************************************************************************************************************************************
function TiOPCGroupSelectorForm.GetGroupName: String;
begin
  if UpperCase(FGroupName) = UpperCase('<NONE>') then Result := '' else Result := FGroupName;
end;
//****************************************************************************************************************************************************
end.
