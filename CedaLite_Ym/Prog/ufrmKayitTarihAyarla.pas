unit ufrmKayitTarihAyarla;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, IB_Grid, StdCtrls, Mask, IB_Controls, Buttons, ExtCtrls,
  IB_Components;

type
  TfrmKayitTarihAyarla = class(TForm)
    qry_Kullanici: TIB_Query;
    dts_Kullanici: TIB_DataSource;
    Panel1: TPanel;
    btnCikis: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox9: TGroupBox;
    IB_CheckBox5: TIB_CheckBox;
    IB_Date1: TIB_Date;
    grdKULLANICI1: TIB_Grid;
    function Form_Open(Menu:Boolean):Integer;
    procedure btnCikisClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_kayit_tarih = 22;
var
  frmKayitTarihAyarla: TfrmKayitTarihAyarla;

implementation
uses unDataMod,unFunc;
{$R *.dfm}

{ TfrmKayitTarihAyarla }

function TfrmKayitTarihAyarla.Form_Open(Menu: Boolean): Integer;
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_kayit_tarih,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if (local_can_update = False) then
    begin
      Application.MessageBox('Bu modüle giriþ yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    Application.CreateForm(TfrmKayitTarihAyarla,frmKayitTarihAyarla);
    with frmKayitTarihAyarla do
    begin
      qry_Kullanici.Open;
      ShowModal;
      qry_Kullanici.Close;
      Release;
    end;
  end;
end;

procedure TfrmKayitTarihAyarla.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmKayitTarihAyarla.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Kullanici.State in [dssEdit] then
  begin
    qry_Kullanici.Post;
  end;
end;

end.


{SELECT KULLANICI_ID
     , KULLANICI_SID
     , AD_SOY
     , USER_NAME
     , PASS_WORD
     , YONETICI
     , E_MAIL
     , SMTP_SERVER
     , SMTP_USER
     , SMTP_PASSWOD
     , SMTP_AUTHENTICATE
     , SUBE_ID
     , RAPKOD_UYG
     , RAPKOD
     , RAPKOD_GOR
     , SUBE_MUDAHALE
     , EN_GER_KAY_TAR
     , KAY_TAR_UYG
FROM KULLANICI
}
