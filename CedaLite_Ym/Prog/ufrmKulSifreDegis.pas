unit ufrmKulSifreDegis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, IB_Controls, IB_Components, Buttons;

type
  TfrmKulSifreDegis = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    qryKullanici: TIB_Query;
    dtsKullanici: TIB_DataSource;
    GroupBox1: TGroupBox;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtSIFRE: TEdit;
    txtYENISIFRE: TEdit;
    txtTEKRARSIFRE: TEdit;
    btnCIKIS: TSpeedButton;
    btnTAMAM: TBitBtn;
    procedure Form_Open();
    procedure btnTamamClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure txtSIFREKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKulSifreDegis: TfrmKulSifreDegis;
implementation
uses main,unDataMod,unFunc;
{$R *.dfm}

{ TfrmKulSifreDegis }

procedure TfrmKulSifreDegis.Form_Open;
begin
    Application.CreateForm(TfrmKulSifreDegis,frmKulSifreDegis);
    with frmKulSifreDegis.qryKullanici do
    begin
      Close;
      Prepare;
      ParamByName('PRM_KUL_ID').AsInteger := glb_USER_ID;
      ParamByName('PRM_KUL_SID').AsSmallint := glb_USER_SID;
      Open;
    end;
    frmKulSifreDegis.ShowModal;
    frmKulSifreDegis.Release;
end;

procedure TfrmKulSifreDegis.btnTamamClick(Sender: TObject);
var
  qrySifreUpdate : TIB_Query;
begin
  if Trim(txtsifre.Text) = '' then
  begin
    Application.MessageBox('Þifrenizi yazmadan deðiþiklik yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
  if Length(txtYENISIFRE.Text) < 5 then
  begin
    Application.MessageBox('Verdiðiniz yeni þifre beþ karakterden az olamaz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Trim(trimleft(TrimRight(txtsifre.Text))) = qryKullanici.FieldByName('PASS_WORD').AsString then
  begin
    if trim(txtYENISIFRE.Text) = '' then
    begin
      Application.MessageBox('Yeni þifrenizi boþ býrakamazsýnýz.','Dikkat',MB_ICONWARNING);
      exit;
    end
    else
    begin
      if txtYENISIFRE.Text = txtTEKRARSIFRE.Text then
      begin
        try
          try
            DataMod.CreateQuery(qrySifreUpdate,nil,False,DataMod.dbaANA);
            with qrySifreUpdate do
            begin
              Close;
              SQL.Clear;
              SQL.Add('UPDATE KULLANICI SET PASS_WORD ='+SQL_Katar(txtYENISIFRE.Text)+' WHERE KULLANICI_ID ='+IntToStr(glb_USER_ID)+' AND KULLANICI_SID ='+inttostr(glb_USER_SID));
              Execute;
            end;
          except
            DataMod.ReleaseQuery(qrySifreUpdate);
            Application.MessageBox('Ýþlem sýrasýnda bir hata oluþtu.','Dikkat',MB_ICONWARNING);
            raise;
          end;
        finally
          DataMod.ReleaseQuery(qrySifreUpdate);
        end;
        Close;
      end else
      begin
       Application.MessageBox('Yazdýðýnýz þifreler birbirini tutmuyor lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
       exit;
      end;
    end;
  end
  else
  begin
    Application.MessageBox('Yazdýðýnýz þifre ile þu anda kullanmakta olduðunuz þifre farklý.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmKulSifreDegis.btnIptalClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmKulSifreDegis.txtSIFREKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmKulSifreDegis.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
  if KEY = #27 then
  begin
    key := #0;
    Close;
  end;
end;

end.
