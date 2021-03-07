unit ufrmLOGIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,IB_Components;

type
  TfrmLOGIN = class(TForm)
    txtUSER_NAME: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtPASS_WORD: TEdit;
    btnCIKIS: TSpeedButton;
    btnTamam: TBitBtn;
    Version: TLabel;
    procedure btnTamamClick(Sender: TObject);
    procedure btnCIKISClick(Sender: TObject);
    Function Form_Open:Boolean;
    procedure FormCreate(Sender: TObject);
    procedure txtUSER_NAMEKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    prv_CloseVar:Boolean;

  public
    { Public declarations }

    pbl_LOGGED:Boolean;
     pbl_Cikis:Boolean;
  end;

var
  frmLOGIN: TfrmLOGIN;

implementation

uses unDataMod, unFUNC,ufrmProgramHizmetleri, Main, unRegistry;

{$R *.dfm}

procedure TfrmLOGIN.btnTamamClick(Sender: TObject);
var
  qryKULLANICI:TIB_Query;
begin
   pbl_Cikis :=False;
  if ((Trim(txtUSER_NAME.Text) = '') OR (Trim(txtPASS_WORD.Text) = '')) then
  begin
    Application.MessageBox('Kullanýcý Adý ya da Þifre Boþ','Dikkat',MB_ICONHAND );
    Exit;
  end;

  DataMod.CreateQuery(qryKULLANICI,Nil,False,DataMod.dbaANA);
  qryKULLANICI.SQL.Add('SELECT * FROM KULLANICI WHERE KULLANICI.USER_NAME = '+ SQL_Katar(txtUSER_NAME.Text) + ' AND KULLANICI.PASS_WORD = '+ SQL_Katar(txtPASS_WORD.Text));
  qryKULLANICI.Open;

  if qryKULLANICI.RecordCount = 0 then
  begin
    qryKULLANICI.Close;
    Application.MessageBox('Yazdýðýnýz kullanýcý adý veya þifre yanlýþ.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  glb_USER_NAME := upper(Trim(txtUSER_NAME.Text));
  glb_USER_ID := qryKULLANICI.FieldByName('KULLANICI_ID').AsInteger;
  glb_USER_SID := qryKULLANICI.FieldByName('KULLANICI_SID').AsInteger;
  glb_YONETICI := (qryKULLANICI.FieldByName('YONETICI').AsInteger = 1);
  qryKULLANICI.Close;
  with MainForm.StatusBar do
  begin
    Panels[1].Text := glb_USER_NAME;
    Panels[3].Text := DateToStr(DataMod.GET_SERVER_DATE);
  end;

//  glb_SID :=

  pbl_LOGGED := True;
  prv_CloseVar := True;
  WriteToRegistry(RegSection+'\'+UserSubSection+'\', 'USERNAME', glb_USER_NAME);
  Close;
end;

procedure TfrmLOGIN.btnCIKISClick(Sender: TObject);
begin
 if Application.MessageBox('Programdan çýkacaksýnýz emin misiniz?','Programdan Çýkýþ',MB_YESNO+MB_ICONQUESTION) = ID_YES then
 begin
  prv_CloseVar := True;
   pbl_Cikis :=True ;
//    Application.Terminate;
// Halt;
ModalREsult:=MrOk;
Close;
 end;
end;

function TfrmLOGIN.Form_Open:Boolean;
  //MustShow = True ise ParamStr(1) ne olursa olsun gösterim yapýlýr.
begin
  try
    DataMod.AssignConnProps(DataMod.dbaANA,
                            frmProgramHizmetleri.pbl_CONN_LOCAL,
                            frmProgramHizmetleri.pbl_SERVER,
                            frmProgramHizmetleri.pbl_DB_PATH,
                            frmProgramHizmetleri.pbl_USER,
                            frmProgramHizmetleri.pbl_PASS_WORD);
    DataMod.dbaANA.Connect;
    pbl_LOGGED:= False;
    if ParamStr(1) = 'nouser' then
    begin
     txtUSER_NAME.Text := ParamStr(2);
     txtPASS_WORD.Text := ParamStr(3);
     btnTamamClick(self);
     Close;
     Exit;
   end;
    frmLOGIN.ShowModal;
  except
    Application.MessageBox('MAIN veri tabanýna baðlanýlamadý.. Program ayarlarýný kontrol ediniz.','Hata',MB_ICONHAND);
    frmProgramHizmetleri.ShowModal;
    Application.Terminate;
  end;
end;
procedure TfrmLOGIN.FormCreate(Sender: TObject);
begin
  txtUSER_NAME.Text := ReadStringFromRegistry(RegSection+'\'+ UserSubSection + '\' , 'USERNAME' );
  Version.Caption := 'Ver: ' + IntToStr(VER_MAJOR) + '.' + IntToStr(VER_MINOR) + '.'+ IntToStr(VER_RELEASE);
  prv_CloseVar := False;
end;

procedure TfrmLOGIN.txtUSER_NAMEKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmLOGIN.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := prv_CloseVar;
end;

procedure TfrmLOGIN.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Halt;
  end;
end;

procedure TfrmLOGIN.FormActivate(Sender: TObject);
begin
  if Length(txtUSER_NAME.Text) <> 0 then txtPASS_WORD.SetFocus;
end;

end.
