unit ufrmANT_REPORT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxIBOSet, IB_Components, StdCtrls, ExtCtrls,cxSSTypes;

type
  TfrmANT_REPORT = class(TForm)
    qryANT_DETAIL: TIB_Query;
    qryANT_MAIN: TIB_Query;
    frxANT_MAIN: TfrxIBODataset;
    frxANT_DETAIL: TfrxIBODataset;
    frxReport1: TfrxReport;
    frxSIRKET: TfrxIBODataset;
    qrySIRKET: TIB_Query;
    qryANT_RAPOR: TIB_Query;
    frxANT_RAPOR: TfrxIBODataset;
    procedure ANT_GIRIS_FISI(ANT_MAIN_ID,ANT_MAIN_SID:Integer;Islem:Byte);
    procedure ANT_CIKIS_FISI(ANT_MAIN_ID,ANT_MAIN_SID,ANT_DETAIL_ID:Integer;Islem:Byte);
    procedure Sirket_Ac;
    procedure frxReport1ClosePreview(Sender: TObject);
    Procedure Form_Open(TIP:Byte);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmANT_REPORT: TfrmANT_REPORT;

implementation
uses unDATAMOD,unFUNC;
{$R *.dfm}

procedure TfrmANT_REPORT.ANT_GIRIS_FISI(ANT_MAIN_ID,ANT_MAIN_SID:Integer;Islem:Byte);
var qryTOPLAMLAR:TIB_Query;
    a,b:TfrxMemoView;//TfrxComponent;
begin
  Application.CreateForm(TfrmANT_REPORT,frmANT_REPORT);
  with frmANT_REPORT do
  begin
    Sirket_Ac;
    with qryANT_MAIN do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ANT_MAIN_ID ');
      sql.Add('     , ANT_MAIN_SID ');
      sql.Add('     , DEF_SIRA_NO ');
      sql.Add('     , TARIH ');
      sql.Add('     , GIRCIK ');
      sql.Add('     , TASIYAN ');
      sql.Add('     , TASIYAN_ID ');
      sql.Add('     , OZET_BEYAN_NO ');
      sql.Add('     , OZET_BEYAN_TAR ');
      sql.Add('     , KONSIMENTO ');
      sql.Add('     , GIRIS_ANT_DETAIL_ID ');
      sql.Add('     , CIK_KAP ');
      sql.Add('     , CIK_KILO ');
      sql.Add('     , FATURA_ID ');
      sql.Add('     , GUM_VEZ_NO ');
      sql.Add('     , GUM_VEZ_TAR ');
      sql.Add('     , GUM_KOM_KOD ');
      sql.Add('     , KAP_BOL ');
      sql.Add('FROM ANT_MAIN ');
      sql.Add('WHERE ANT_MAIN_ID ='+ IntToStr(ANT_MAIN_ID));
      Open;
    end;

    with qryANT_DETAIL do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ANT_DETAIL_ID ');
      sql.Add('     , ANT_MAIN_ID ');
      sql.Add('     , ANT_BEYAN_NO ');
      sql.Add('     , ANT_BEYAN_TAR ');
      sql.Add('     , KONSIMENTO ');
      sql.Add('     , CARI_AD ');
      sql.Add('     , CARI_KOD ');
      sql.Add('     , KAP_ADET ');
      sql.Add('     , KILO ');
      sql.Add('     , ESYA ');
      sql.Add('     , YANICI ');
      sql.Add('     , ARDIYE_FIY ');
      sql.Add('     , ARD_DOVKOD ');
      sql.Add('     , HAMMALIYE ');
      sql.Add('     , HAMM_DOVKOD ');
      sql.Add('     , KALAN_KAP ');
      sql.Add('     , KALAN_KILO ');
      sql.Add('FROM ANT_DETAIL ');
      sql.Add('WHERE ANT_DETAIL.ANT_MAIN_ID=' + IntToStr(ANT_MAIN_ID) );
      Open;
    end;
    DataMod.CreateQuery(qryTOPLAMLAR,Nil,False,DataMod.dbaMain);
    qryTOPLAMLAR.SQL.Add('SELECT SUM(KAP_ADET) AS TOPLAM_KAP , SUM(KILO) AS TOPLAM_KILO FROM ANT_DETAIL WHERE ANT_MAIN_ID = ' + IntToStr(ANT_MAIN_ID));
    qryTOPLAMLAR.Open;
    frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ANT_GIRIS_LISTE.fr3',True);
    a:=(frxReport1.FindComponent('Memo30') as TfrxMemoView);
    a.memo.Text:= 'Yalnýz, '+  Param(qryTOPLAMLAR.FieldByName('TOPLAM_KAP').asInteger) + ' KAP';

    b:=(frxReport1.FindComponent('Memo51') as TfrxMemoView);
    b.memo.Text:= 'Yalnýz, ' + KiloYaziIle(qryTOPLAMLAR.FieldByName('TOPLAM_KILO').AsCurrency) + ' dir.';
   frxReport1.ShowReport(True);
  end;
end;
procedure TfrmANT_REPORT.frxReport1ClosePreview(Sender: TObject);
begin
   frmANT_REPORT.Release;
end;

procedure TfrmANT_REPORT.Sirket_Ac;
begin
  with frmANT_REPORT do
  begin
    qrySIRKET.ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
    qrySIRKET.Open;
  end;
end;

procedure TfrmANT_REPORT.ANT_CIKIS_FISI(ANT_MAIN_ID,ANT_MAIN_SID,ANT_DETAIL_ID:Integer;Islem:Byte);
var a,b:TfrxMemoView;//TfrxComponent;
begin
  Application.CreateForm(TfrmANT_REPORT,frmANT_REPORT);
  with frmANT_REPORT do
  begin
    Sirket_Ac;
    with qryANT_MAIN do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ANT_MAIN_ID ');
      sql.Add('     , ANT_MAIN_SID ');
      sql.Add('     , DEF_SIRA_NO ');
      sql.Add('     , TARIH ');
      sql.Add('     , GIRCIK ');
      sql.Add('     , TASIYAN ');
      sql.Add('     , TASIYAN_ID ');
      sql.Add('     , OZET_BEYAN_NO ');
      sql.Add('     , OZET_BEYAN_TAR ');
      sql.Add('     , KONSIMENTO ');
      sql.Add('     , GIRIS_ANT_DETAIL_ID ');
      sql.Add('     , CIK_KAP ');
      sql.Add('     , CIK_KILO ');
      sql.Add('     , FATURA_ID ');
      sql.Add('     , GUM_VEZ_NO ');
      sql.Add('     , GUM_VEZ_TAR ');
      sql.Add('     , GUM_KOM_KOD ');
      sql.Add('     , KAP_BOL ');
      sql.Add('FROM ANT_MAIN ');
      sql.Add('WHERE ANT_MAIN_ID ='+ IntToStr(ANT_MAIN_ID));
      Open;
    end;

    with qryANT_DETAIL do
    begin
      Close;
      sql.Clear;
      sql.Add('SELECT ANT_DETAIL_ID ');
      sql.Add('     , ANT_DETAIL.ANT_MAIN_ID ');
      sql.Add('     , ANT_BEYAN_NO ');
      sql.Add('     , ANT_BEYAN_TAR ');
      sql.Add('     , ANT_DETAIL.KONSIMENTO ');
      sql.Add('     , ANT_MAIN.OZET_BEYAN_NO ');
      sql.Add('     , ANT_MAIN.OZET_BEYAN_TAR ');
      sql.Add('     , CARI_AD ');
      sql.Add('     , CARI_KOD ');
      sql.Add('     , KAP_ADET ');
      sql.Add('     , KILO ');
      sql.Add('     , ESYA ');
      sql.Add('     , YANICI ');
      sql.Add('     , ARDIYE_FIY ');
      sql.Add('     , ARD_DOVKOD ');
      sql.Add('     , HAMMALIYE ');
      sql.Add('     , HAMM_DOVKOD ');
      sql.Add('     , KALAN_KAP ');
      sql.Add('     , KALAN_KILO ');
      sql.Add('FROM ANT_DETAIL ');
      sql.Add('INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MAIN_ID)');
      sql.Add('WHERE ANT_DETAIL.ANT_DETAIL_ID=' + IntToStr(ANT_DETAIL_ID));
      Open;
    end;
    frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ANT_CIKIS_FISI.fr3',True);
    a:=(frxReport1.FindComponent('Memo30') as TfrxMemoView);
    a.memo.Text:= 'Yukarýda yazýlý '+  Param(qryANT_MAIN.FieldByName('CIK_KAP').asInteger) + ' kap eþya ' +
                  qryANT_MAIN.FieldByName('TARIH').AsString + ' tarihinde ambardan çýkmýþtýr.';

    frxReport1.ShowReport(True);
  end;
end;

Procedure TfrmANT_REPORT.Form_Open(TIP:Byte);
var a,b:TfrxMemoView;//TfrxComponent;
begin
  Application.CreateForm(TfrmANT_REPORT,frmANT_REPORT);
  with frmANT_REPORT do
  begin
    Sirket_Ac;
    qryANT_RAPOR.ParamByName('PRM_RAPOR_TIP').AsInteger := TIP;
    frxReport1.LoadFromFile(glb_REPORTS_DIR + '\Antrepo\ANT_RAPOR.fr3',True);
    a:=(frxReport1.FindComponent('txtREPORT_NAME') as TfrxMemoView);
    case TIP of
     1: a.memo.Text := 'Geçici Depolama Giriþ ve Çýkýþ Stok Listesi';
     2: a.memo.Text := 'Antrepo Giriþ ve Çýkýþ Stok Listesi';
     3: a.memo.Text := 'Stok Defteri';
     4: a.memo.Text := 'Tüm Antrepo Hareket Dökümü';
    end;
    frxReport1.ShowReport(True);
  end;
end;

end.
