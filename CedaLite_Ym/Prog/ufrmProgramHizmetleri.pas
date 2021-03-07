unit ufrmProgramHizmetleri;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,IniFiles,ShellAPI, ShlObj,Undatamod;

type
  TfrmProgramHizmetleri = class(TForm)
    Panel1: TPanel;
    btnExit: TBitBtn;
    btnTRN_KAYDET: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    txtFiles: TEdit;
    btnFiles: TButton;
    Label2: TLabel;
    txtScripts: TEdit;
    btnScript: TButton;
    Label3: TLabel;
    txtReports: TEdit;
    btnReports: TButton;
    dlgFileOpen: TOpenDialog;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtLOG_SERVER: TEdit;
    chkLOG_CONNLOCAL: TCheckBox;
    txtLOG_DB_PATH: TEdit;
    Button2: TButton;
    txtLOG_USER_NAME: TEdit;
    txtLOG_PASS_WORD: TEdit;
    btnLOG_TEST: TButton;
    grpMAINDB: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    txtSERVER: TEdit;
    chkCONNLOCAL: TCheckBox;
    txtDB_PATH: TEdit;
    Button1: TButton;
    txtUSER_NAME: TEdit;
    txtPASS_WORD: TEdit;
    mnuTEST: TButton;
    procedure btnFilesClick(Sender: TObject);
    procedure btnScriptClick(Sender: TObject);
    procedure btnReportsClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    function Ayar_Yukle:Boolean;
    procedure Button1Click(Sender: TObject);
    procedure mnuTESTClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnLOG_TESTClick(Sender: TObject);
  private
    { Private declarations }
    procedure Ayar_Kaydet;
    Procedure Ayar_Oku;
    function BrowseDialog (const Title: string; const Flag: integer): string;
  public
    { Public declarations }
    pbl_CONN_LOCAL:Boolean;
    pbl_SERVER,pbl_DB_PATH,pbl_USER,pbl_PASS_WORD:String;
    pbl_LOG_CONN_LOCAL:Boolean;
    pbl_LOG_SERVER,pbl_LOG_DB_PATH,pbl_LOG_USER,pbl_LOG_PASS_WORD:String;
    function GlbDegHostIniOku (): boolean;
  end;

var
  frmProgramHizmetleri: TfrmProgramHizmetleri;

implementation

uses unFUNC;

{$R *.dfm}



procedure TfrmProgramHizmetleri.Ayar_Kaydet;
var
  HostIni: TIniFile;
begin
  if (Trim(txtFiles.Text) = '') or (Trim(txtScripts.Text) = '') or (Trim(txtReports.Text) = '') then
  begin
    ShowMessage('Lütfen tüm alanlarý doldurunuz...!');
    Exit;
  end;
  HostIni := TIniFile.Create(GetAppPath + 'Host.ini');
  HostIni.WriteString('Ceda', 'FilesDir', Trim(txtFiles.Text));
  HostIni.WriteString('Ceda', 'ScriptsDir', Trim(txtScripts.Text));
  HostIni.WriteString('Ceda', 'ReportsDir', Trim(txtReports.Text));
  HostIni.WriteBool('MainDB','CONN_LOCAL',chkCONNLOCAL.Checked);
  HostIni.WriteString('MainDB','SERVER',Trim(txtSERVER.Text));
  HostIni.WriteString('MainDB','DB_PATH',Trim(txtDB_PATH.Text));
  HostIni.WriteString('MainDB','USER',Trim(txtUSER_NAME.Text));
  HostIni.WriteString('MainDB','PASS_WORD',Trim(txtPASS_WORD.Text));
  HostIni.WriteBool('LOG_DB','CONN_LOCAL',chkLOG_CONNLOCAL.Checked);
  HostIni.WriteString('LOG_DB','SERVER',Trim(txtLOG_SERVER.Text));
  HostIni.WriteString('LOG_DB','DB_PATH',Trim(txtLOG_DB_PATH.Text));
  HostIni.WriteString('LOG_DB','USER',Trim(txtLOG_USER_NAME.Text));
  HostIni.WriteString('LOG_DB','PASS_WORD',Trim(txtLOG_PASS_WORD.Text));
  HostIni.Free;
  GlbDegHostIniOku;
  close;
end;

function TfrmProgramHizmetleri.GlbDegHostIniOku (): boolean;
var
  HostIni: TIniFile;
begin
  if  (FileExists(GetAppPath + 'Host.ini')<>True) then
  begin
    Result :=False;
    Exit;
  end;
  HostIni := TIniFile.Create(GetAppPath + 'Host.ini');
  glb_FILES_DIR   := HostIni.ReadString('Ceda', 'FilesDir', '');
  glb_IMAGE_DIR   := HostIni.ReadString('Ceda', 'ImageDir', '');
  glb_SCRIPTS_DIR := HostIni.ReadString('Ceda', 'ScriptsDir', '');
  glb_REPORTS_DIR := HostIni.ReadString('Ceda', 'ReportsDir', '');
  if (glb_FILES_DIR ='') or (glb_SCRIPTS_DIR ='') or (glb_REPORTS_DIR='') then Result :=False else Result :=True;
  pbl_CONN_LOCAL := HostIni.ReadBool('MainDB','CONN_LOCAL',True);
  pbl_SERVER     := HostIni.ReadString('MainDB','SERVER', '');
  pbl_DB_PATH    := HostIni.ReadString('MainDB','DB_PATH','');
  pbl_USER       := HostIni.ReadString('MainDB','USER','');
  pbl_PASS_WORD  := HostIni.ReadString('MainDB','PASS_WORD','');
  pbl_LOG_CONN_LOCAL := HostIni.ReadBool('LOG_DB','CONN_LOCAL',True);
  pbl_LOG_SERVER     := HostIni.ReadString('LOG_DB','SERVER', '');
  pbl_LOG_DB_PATH    := HostIni.ReadString('LOG_DB','DB_PATH','');
  pbl_LOG_USER       := HostIni.ReadString('LOG_DB','USER','');
  pbl_LOG_PASS_WORD  := HostIni.ReadString('LOG_DB','PASS_WORD','');
  HostIni.Free;
end;

Procedure TfrmProgramHizmetleri.Ayar_Oku;
var
  HostIni: TIniFile;
begin
  HostIni := TIniFile.Create(GetAppPath + 'Host.ini');
  txtFiles.Text    := HostIni.ReadString('Ceda', 'FilesDir', '');
  txtScripts.Text  := HostIni.ReadString('Ceda', 'ScriptsDir', '');
  txtReports.Text  := HostIni.ReadString('Ceda', 'ReportsDir', '');
  chkCONNLOCAL.Checked := HostIni.ReadBool('MainDB','CONN_LOCAL',True);
  txtSERVER.Text   := HostIni.ReadString('MainDB','SERVER', '');
  glb_SERVER_NAME:=Trim(txtSERVER.Text);
  txtDB_PATH.Text  := HostIni.ReadString('MainDB','DB_PATH','');
  txtUSER_NAME.Text:= HostIni.ReadString('MainDB','USER','');
  txtPASS_WORD.Text:= HostIni.ReadString('MainDB','PASS_WORD','');
  chkLOG_CONNLOCAL.Checked := HostIni.ReadBool('LOG_DB','CONN_LOCAL',True);
  txtLOG_SERVER.Text   := HostIni.ReadString('LOG_DB','SERVER', '');
  txtLOG_DB_PATH.Text  := HostIni.ReadString('LOG_DB','DB_PATH','');
  txtLOG_USER_NAME.Text:= HostIni.ReadString('LOG_DB','USER','');
  txtLOG_PASS_WORD.Text:= HostIni.ReadString('LOG_DB','PASS_WORD','');
  HostIni.Free;
end;

function TfrmProgramHizmetleri.BrowseDialog(const Title: string; const Flag: integer): string;
var
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  Result:='';
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  with BrowseInfo do
  begin
    hwndOwner := Application.Handle;
    pszDisplayName := @DisplayName;
    lpszTitle := PChar(Title);
    ulFlags := Flag;
  end;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then
  begin
    SHGetPathFromIDList(lpItemID, TempPath);
    Result := TempPath;
    Result := Result + '\';
    GlobalFreePtr(lpItemID);
  end;
end;

procedure TfrmProgramHizmetleri.btnFilesClick(Sender: TObject);
begin
  txtFiles.Text   := BrowseDialog('Dizin Seçiniz', BIF_RETURNONLYFSDIRS);
end;

procedure TfrmProgramHizmetleri.btnScriptClick(Sender: TObject);
begin
  txtScripts.Text   := BrowseDialog('Dizin Seçiniz', BIF_RETURNONLYFSDIRS);
end;

procedure TfrmProgramHizmetleri.btnReportsClick(Sender: TObject);
begin
  txtReports.Text   := BrowseDialog('Dizin Seçiniz', BIF_RETURNONLYFSDIRS);
end;

procedure TfrmProgramHizmetleri.btnExitClick(Sender: TObject);
begin
  Halt;
end;

procedure TfrmProgramHizmetleri.btnTRN_KAYDETClick(Sender: TObject);
begin
  Ayar_Kaydet;
end;

function  TfrmProgramHizmetleri.Ayar_Yukle:Boolean;
begin
  Ayar_Oku;
  Result := frmProgramHizmetleri.GlbDegHostIniOku;
  if Result = False then frmProgramHizmetleri.ShowModal;
end;


procedure TfrmProgramHizmetleri.Button1Click(Sender: TObject);
begin
  dlgFileOpen.execute;
  if dlgFileOpen.FileName <> '' then txtDB_PATH.Text :=dlgFileOpen.FileName ;
end;

procedure TfrmProgramHizmetleri.mnuTESTClick(Sender: TObject);
begin
  DataMod.TestConnection(chkCONNLOCAL.Checked,txtSERVER.Text,txtDB_PATH.Text,txtUSER_NAME.Text,txtPASS_WORD.Text,True);
end;

procedure TfrmProgramHizmetleri.Button2Click(Sender: TObject);
begin
  dlgFileOpen.execute;
  if dlgFileOpen.FileName <> '' then txtLOG_DB_PATH.Text :=dlgFileOpen.FileName ;
end;

procedure TfrmProgramHizmetleri.btnLOG_TESTClick(Sender: TObject);
begin
  DataMod.TestConnection(chkLOG_CONNLOCAL.Checked,txtLOG_SERVER.Text,txtLOG_DB_PATH.Text,txtLOG_USER_NAME.Text,txtLOG_PASS_WORD.Text,True);
end;

end.

