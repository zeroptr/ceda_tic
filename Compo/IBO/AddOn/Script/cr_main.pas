unit cr_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IB_Components, Menus, ComCtrls, IB_Monitor, IB_ConnectionBar,
  ExtCtrls, Mask, IB_Process, IB_Script, Buttons,
  IB_UtilityBar, FileCtrl;

type
  TfrmCreatorMain = class(TForm)
    DBmain: TIB_Database;
    PageControl1: TPageControl;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    cbSystemTables: TComboBox;
    sbCreate: TSpeedButton;
    sbSQLsave: TSpeedButton;
    mSQL: TMemo;
    ScriptMain: TIB_Script;
    Panel7: TPanel;
    Panel8: TPanel;
    sbListSave: TSpeedButton;
    mList: TMemo;
    SpeedButton3: TSpeedButton;
    Panel4: TPanel;
    IB_ConnectionBar1: TIB_ConnectionBar;
    IB_UtilityBar1: TIB_UtilityBar;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    BaseNameEdit: TEdit;
    StatusBar1: TStatusBar;
    procedure N2Click(Sender: TObject);
    procedure BaseNameEditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbCreateClick(Sender: TObject);
    procedure sbSQLsaveClick(Sender: TObject);
    procedure DBmainConnectedChanged(Sender: TIB_Connection);
    procedure cbSystemTablesChange(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure sbListSaveClick(Sender: TObject);
    procedure mListChange(Sender: TObject);
    procedure mSQLChange(Sender: TObject);
    procedure mShowHint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCreatorMain: TfrmCreatorMain;

implementation

{$R *.DFM}

procedure TfrmCreatorMain.N2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmCreatorMain.BaseNameEditChange(Sender: TObject);
begin
  DBmain.Connected := False;
  DBmain.Path := BaseNameEdit.Text;
end;

procedure TfrmCreatorMain.mShowHint(Sender: TObject);
begin
  StatusBar1.SimpleText := ' '+Application.Hint;
end;

procedure TfrmCreatorMain.FormCreate(Sender: TObject);
var mPath,mFile : String;
    i : integer;
begin
  Application.OnHint := mShowHint;
  mPath := ExtractFilePath(Application.ExeName);
  mFile := mPath+'SQL\list.txt';
  if fileExists(mFile) then begin
    mSQL.Lines.LoadFromFile(mFile);
    cbSystemTables.Items.Clear;
    For i:=0 to mSQL.Lines.Count-1 Do Begin
     cbSystemTables.Items.Add(mSQL.Lines[i]);
    End;
     cbSystemTables.Text := cbSystemTables.Items[0];
     mFile := mPath+'SQL\SQL_'+COPY(cbSystemTables.Text,1,4)+'.SQL';
     if fileExists(mFile) then begin
         mSQL.Lines.LoadFromFile(mFile);
     end else
     //CfgError.Show;
  end else Begin
   //CfgError.Show;
  End;
  PageControl1.ActivePage := TabSheet1;
end;

procedure TfrmCreatorMain.sbCreateClick(Sender: TObject);
begin
  ScriptMain.SQL := mSQL.Lines;
  ScriptMain.Execute;
end;

procedure TfrmCreatorMain.sbSQLsaveClick(Sender: TObject);
Var mPath, mFile : String;
begin
  mPath := ExtractFilePath(Application.ExeName);
  mFile := mPath+'SQL\SQL_'+COPY(cbSystemTables.Text,1,4)+'.SQL';
  mSQL.Lines.Add('/* Updated '+DateTimeToStr(Now)+' */');
  mSQL.Lines.SaveToFile(mFile);
  sbSQLsave.Enabled := False;
end;


procedure TfrmCreatorMain.DBmainConnectedChanged(Sender: TIB_Connection);
begin
  if DBmain.Connected then begin
    sbCreate.Enabled := True;
  end else begin
    sbCreate.Enabled := False;
  end;
end;

procedure TfrmCreatorMain.cbSystemTablesChange(Sender: TObject);
Var mPath, mFile : String;
begin
  mPath := ExtractFilePath(Application.ExeName);
  mFile := mPath+'SQL\SQL_'+COPY(cbSystemTables.Text,1,4)+'.SQL';
  if fileExists(mFile) then begin
    mSQL.Lines.LoadFromFile(mFile);
  end else begin
    mSQL.Lines.Clear;
    mSQL.Text := '/* Файл опису ситруктур відсутній */';
  end;
  sbSQLsave.Enabled := False;
end;

procedure TfrmCreatorMain.SpeedButton3Click(Sender: TObject);
Var mPath, mFile : String;
begin
  mPath := ExtractFilePath(Application.ExeName);
  mFile := mPath+'SQL\LIST.TXT';
  if fileExists(mFile) then begin
    mList.Lines.LoadFromFile(mFile);
  end else begin
    mList.Lines.Clear;
    mList.Text := '/* Список файлів відсутній */';
  end;
end;

procedure TfrmCreatorMain.sbListSaveClick(Sender: TObject);
Var mPath, mFile : String;
    i : integer;
begin
  mPath := ExtractFilePath(Application.ExeName);
  mFile := mPath+'SQL\LIST.TXT';
  mList.Lines.SaveToFile(mFile);
  sbListSave.Enabled := False;
//
  cbSystemTables.Items.Clear;
    For i:=0 to mList.Lines.Count-1 Do Begin
     cbSystemTables.Items.Add(mList.Lines[i]);
    End;
  cbSystemTables.Text := cbSystemTables.Items[0];
end;

procedure TfrmCreatorMain.mListChange(Sender: TObject);
begin
  sbListSave.Enabled := True;
end;

procedure TfrmCreatorMain.mSQLChange(Sender: TObject);
begin
 sbSQLsave.Enabled := True;
end;

end.
