{*******************************************************}
{                                                       }
{       TiOPCServerSelectorForm                         }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCServerSelector;{$endif}
{$ifdef iCLX}unit QiOPCServerSelector;{$endif}

interface

uses
  {$IFDEF iVCL} iOPCDLLLOader,  iTypes,{$ENDIF}
  {$IFDEF iCLX}QiOPCDLLLOader, QiTypes,{$ENDIF}

  {$I iIncludeUsesForms.inc}
  {$IFDEF iVCL}  iEditorBasicComponents,  StdCtrls,  Controls,  ComCtrls,  ExtCtrls, Classes,  ImgList;{$ENDIF}
  {$IFDEF iCLX}QiEditorBasicComponents,  QStdCtrls, QControls, QComCtrls, QExtCtrls, Classes, QImgList;{$ENDIF}

type
  TiOPCServerSelectorForm = class(TForm)
    ImageList: TImageList;
    ListView: TListView;
    Panel1: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    StatusBar1: TStatusBar;
    procedure ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure ListViewDblClick(Sender: TObject);
    procedure ListViewKeyPress(Sender: TObject; var Key: Char);
  private
    FServerName    : String;
    FSessionHandle : Integer;
  public
    procedure Setup(MachineName: String);

    property ServerName    : String  read FServerName    write FServerName;
    property SessionHandle : Integer read FSessionHandle write FSessionHandle;
  end;

var
  iOPCServerSelectorForm: TiOPCServerSelectorForm;

implementation

{$R *.dfm}
//****************************************************************************************************************************************************
procedure TiOPCServerSelectorForm.Setup(MachineName: String);
var
  x           : Integer;
  ListItem    : TListItem;
  iServerData : TiServerData;
begin
  ListView.Items.Clear;

  OPCDLLEditorServerSetup(SessionHandle, PChar(MachineName));

  for x := 0 to OPCDLLEditorServerGetCount(SessionHandle)-1 do
    begin
      ListItem            := ListView.Items.Add;
      iServerData         := OPCDLLEditorServerGetData(SessionHandle, x);
      ListItem.Caption    := iServerData.Name;
      ListItem.ImageIndex := iServerData.VersionType;
    end;
end;
//****************************************************************************************************************************************************
procedure TiOPCServerSelectorForm.ListViewSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  ServerName := Item.Caption;
  OKButton.Enabled := True;
end;
//****************************************************************************************************************************************************
procedure TiOPCServerSelectorForm.ListViewDblClick(Sender: TObject);
begin
  if Assigned(ListView.Selected) then ModalResult := mrOk;
end;
//****************************************************************************************************************************************************
procedure TiOPCServerSelectorForm.ListViewKeyPress(Sender: TObject; var Key: Char);
begin
  if not Assigned(ListView.Selected) then exit;
  if Key = #13 then
    begin
      Key := #0;
      ModalResult := mrOk;
    end;
end;
//****************************************************************************************************************************************************
end.
