unit ufrmOnarim_Fatura_Bir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Grids, IB_Grid, Buttons, ExtCtrls,Db;

type
  TfrmOnarim_Fatura_Bir = class(TForm)
    IB_Grid1: TIB_Grid;
    IB_Grid2: TIB_Grid;
    Label1: TLabel;
    lblCariAD: TLabel;
    qrySiparis: TIB_Query;
    qrySiparis_D: TIB_Query;
    dtsSiparis: TIB_DataSource;
    dstSiparis_D: TIB_DataSource;
    Panel1: TPanel;
    btnCikis: TBitBtn;
    SpeedButton1: TSpeedButton;
    qry_Siparis_Fat: TIB_Query;
    IB_DataSource1: TIB_DataSource;
    trnFAT_IRS: TIB_Transaction;
    qryx: TIB_Query;
    Label2: TLabel;
    Memo1: TMemo;
    cb_Birlestir: TCheckBox;

    procedure btnCikisClick(Sender: TObject);
    procedure qrySiparisAfterScroll(IB_Dataset: TIB_Dataset);
    procedure IB_Grid1DblClick(Sender: TObject);
    procedure IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Grid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure IB_Grid2DblClick(Sender: TObject);
    procedure IB_Grid1Exit(Sender: TObject);
    procedure qrySiparisAfterPost(IB_Dataset: TIB_Dataset);
    procedure IB_Grid2Exit(Sender: TObject);
    procedure qrySiparis_DCalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
    procedure FormCreate(Sender: TObject);

  private
    prv_FAT_IRS_SEP:Integer;
    prv_CARI_KOD:String;
    prv_TIP:Integer;
    prv_Kontrol :Boolean;
    prv_Dov_Baz_Tar:TDate;
        
    procedure Aktar(var Kaynak: TIB_Query);

    { Private declarations }
  public
    Sec:Boolean;
    res_Cari:TStringList;
    function Form_Open(CARI_KOD: String;Cari_Adi:String;Tip:Integer;Dov_Baz_Tar:TDateTime;
    Giden_Id:TStringList;
    var Donen_Id:TStringList;
    var Qry:TIb_Query;
    var Qry1:TIb_Query;
    var Tek_Satir:Boolean):Boolean;
    { Public declarations }
  end;

var
  frmOnarim_Fatura_Bir: TfrmOnarim_Fatura_Bir;

implementation

uses unDataMod, UnFunc, ufrmFAT_Srv;

{$R *.dfm}

function TfrmOnarim_Fatura_Bir.Form_Open(CARI_KOD:String;Cari_Adi:String;Tip:Integer;Dov_Baz_Tar:TDateTime;
Giden_Id:TStringList;
var Donen_Id:TStringList;
var Qry:TIb_Query;
var Qry1:TIb_Query;
var Tek_Satir:Boolean

):Boolean;

var
say:Integer;
begin
  Application.CreateForm (TfrmOnarim_Fatura_Bir,frmOnarim_Fatura_Bir);
  frmOnarim_Fatura_Bir.prv_CARI_KOD:=CARI_KOD;
  frmOnarim_Fatura_Bir.lblCariAD.Caption:=Cari_Adi;
  frmOnarim_Fatura_Bir.prv_Dov_Baz_Tar:=Dov_Baz_Tar;



  frmOnarim_Fatura_Bir.trnFAT_IRS.StartTransaction;
  with frmOnarim_Fatura_Bir.qryx do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text:=
    'UPDATE SRV_ARAC_ONARIM_D SET SECIM=0 WHERE ONARIM_ID IN (SELECT ONARIM_ID FROM SRV_ARAC_ONARIM WHERE SRV_ARAC_ONARIM.CARI_KOD=:PRM_CARI_KOD )';
    ParamByName('PRM_CARI_KOD').AsString:=frmOnarim_Fatura_Bir.prv_CARI_KOD;
    ExecSql;
  end;
  with frmOnarim_Fatura_Bir.qryx do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text:=
    'UPDATE SRV_ARAC_ONARIM SET SECIM=0 WHERE SRV_ARAC_ONARIM.CARI_KOD=:PRM_CARI_KOD ';
    ParamByName('PRM_CARI_KOD').AsString:=frmOnarim_Fatura_Bir.prv_CARI_KOD;
    ExecSql;
  end;
  frmOnarim_Fatura_Bir.trnFAT_IRS.Commit;
  frmOnarim_Fatura_Bir.trnFAT_IRS.StartTransaction;
  frmOnarim_Fatura_Bir.res_Cari:=TStringList.Create;


  frmOnarim_Fatura_Bir.qrySiparis.Active:=False;
  //frmSiparis_Fatura.qrySiparis.ParamByName('PRM_FAT_IRS_SEP').AsInteger:=frmSiparis_Fatura.Prv_FAT_IRS_SEP;
  frmOnarim_Fatura_Bir.qrySiparis.ParamByName('PRM_CARI_KOD').AsString:=frmOnarim_Fatura_Bir.prv_CARI_KOD;
  frmOnarim_Fatura_Bir.qrySiparis.Active:=True;

  if DataMod.FN_CariKOD2Bilgi(frmOnarim_Fatura_Bir.prv_Cari_KOD,frmOnarim_Fatura_Bir.Res_Cari) then
  frmOnarim_Fatura_Bir.lblCariAD.Caption:=frmOnarim_Fatura_Bir.Res_Cari[1];




  frmOnarim_Fatura_Bir.ShowModal;

  if not frmOnarim_Fatura_Bir.prv_Kontrol Then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;


//    Qry:=qrySiparis_D;
//    Qry:=qrySiparis_D;
//    Giden_Id.Free;
    with frmOnarim_Fatura_Bir do
    begin
    Tek_Satir:=cb_Birlestir.Checked;

    Donen_ID.Clear;

    say:=0;
    if Tek_Satir then
    begin
         qrySiparis.First;
         While Not qrySiparis.Eof Do
         begin
              if qrySiparis.FieldByName('SECIM').AsString ='1' then
              begin
                  qrySiparis_D.First;
                  While Not qrySiparis_D.Eof Do
                  begin
                       if qrySiparis_D.FieldByName('SECIM').AsString ='1' then
                       begin
                          Inc(Say);
                          Donen_ID.Add(Inttostr(qrySiparis_D.FieldByName('Urunhar_Id').AsInteger))
                       end;
                       qrySiparis_D.Next;
                  end;
              end;
              qrySiparis.Next;
         end;

    end;
    if say<2 then Tek_Satir:=False;


    qry:=qrySiparis;
    qry1:=qrySiparis_D;
    
    end;
//  frmOnarim_Fatura_Bir.Close;
//  frmOnarim_Fatura_Bir.Release;





end;


procedure TfrmOnarim_Fatura_Bir.btnCikisClick(Sender: TObject);
begin

  frmFAT_Srv.Onarim_Aktarma:=False;

  //trnFAT_IRS.Commit;
  prv_Kontrol := False;
  Close;
end;

procedure TfrmOnarim_Fatura_Bir.qrySiparisAfterScroll( IB_Dataset: TIB_Dataset);
begin
  qrySiparis_D.Active:=False;
  qrySiparis_D.ParamByName('ONARIM_SID').AsInteger:=qrySiparis.FieldByName('ONARIM_SID').AsInteger;
  qrySiparis_D.ParamByName('ONARIM_ID').AsInteger:=qrySiparis.FieldByName('ONARIM_ID').AsInteger;
  qrySiparis_D.Active:=TRue;
qrySiparis_D.DisableControls;
if qrySiparis.FieldByName('ONARIM_ID').AsInteger>0 then
While not qrySiparis_D.Eof do
begin
  if qrySiparis_D.FieldByName('URUNHAR_ID').AsInteger>0 then
  begin
    if qrySiparis.FieldByName('SECIM').AsInteger=1 then
    qrySiparis_D.FieldByName('SECIM').AsInteger:=1
    else
    qrySiparis_D.FieldByName('SECIM').AsInteger:=0;
    qrySiparis_D.Post;
  end;
  qrySiparis_D.Next;
end;
qrySiparis_D.EnableControls;
end;

procedure TfrmOnarim_Fatura_Bir.IB_Grid1DblClick(Sender: TObject);
begin
  if qrySiparis.FieldByName('ONARIM_ID').AsInteger>0 then
  begin
    if qrySiparis.FieldByName('SECIM').AsInteger=1 then
    qrySiparis.FieldByName('SECIM').AsInteger:=0
    else
    qrySiparis.FieldByName('SECIM').AsInteger:=1;
    qrySiparis.Post;
  end;
end;

procedure TfrmOnarim_Fatura_Bir.IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=VK_Space then
      IB_Grid1.OnDblClick(nil);
end;

procedure TfrmOnarim_Fatura_Bir.IB_Grid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
{    if Key=VK_Space then
      IB_Grid2.OnDblClick(nil);
}
end;

procedure TfrmOnarim_Fatura_Bir.SpeedButton1Click(Sender: TObject);
var
   Sonuc:Boolean;
begin

  if qrySiparis.State in [dssInsert,dssEdit] then
  qrySiparis.Post;
  if qrySiparis_D.State in [dssInsert,dssEdit] then
  qrySiparis_D.Post;
  //trnFAT_IRS.CommitRetaining;

  //if qrySiparis.RecordCount<=0 then Exit;

  Sonuc:=False;

  qrySiparis_D.DisableControls;
  qrySiparis.DisableControls;

  qrySiparis.First;
  qrySiparis_D.First;

  While Not qrySiparis.Eof Do
  begin
    if qrySiparis.FieldByName('Secim').AsInteger=1 then
    While Not qrySiparis_D.Eof Do
    begin
     if qrySiparis_D.FieldByName('Secim').AsInteger=1 then
     Sonuc:=True;
     qrySiparis_D.Next;
    end;
     qrySiparis.Next;
  end;

  if not Sonuc then
  begin
    Application.MessageBox('Seçili Kayýt Yok. Ýþlemden Vazgeçildi','Dikkat',MB_ICONWARNING);
    qrySiparis_D.EnableControls;
    qrySiparis.EnableControls;

    exit;
  end;


  //Aktar(frmFAT_SRV.qryURUNHAR);
  //trnFAT_IRS.Commit;



  prv_Kontrol := True;
  Close;
end;


procedure TfrmOnarim_Fatura_Bir.Aktar(var Kaynak:TIB_Query);

function Miktar_bul_siparis(URUN_KOD:String;BIRIM_FIY:Double;CARI_KOD:String;DOV_KOD:String):Double;
var
   Miktar:Double;
   OLCU_BIRIM:String;
begin
//birden fazla kullan için bir temp alan updatele ve buna göre sorgula
     Result:=0;
     with qryx do
     begin
       Active := False;
       SQL.Clear;
       SQL.Text:=
       'SELECT SUM(MIKTAR) MIKTAR, SRV_ARAC_ONARIM_D.BIRIM_FIY, SRV_ARAC_ONARIM_D.URUN_KOD,SRV_ARAC_ONARIM_D.DOVKOD FROM SRV_ARAC_ONARIM'+
       ' INNER JOIN SRV_ARAC_ONARIM_D ON (SRV_ARAC_ONARIM.ONARIM_SID=SRV_ARAC_ONARIM_D.ONARIM_SID AND SRV_ARAC_ONARIM.ONARIM_ID=SRV_ARAC_ONARIM_D.ONARIM_ID)'+
       ' WHERE SRV_ARAC_ONARIM_D.URUN_KOD=:URUN_KOD  and SRV_ARAC_ONARIM_D.BIRIM_FIY=:BIRIM_FIY'+
       ' AND SRV_ARAC_ONARIM.SECIM=1 AND SRV_ARAC_ONARIM_D.SECIM=1 AND SRV_ARAC_ONARIM.CARI_KOD=:CARI_KOD AND SRV_ARAC_ONARIM_D.DOVKOD=:DOV_KOD'+
       ' GROUP BY SRV_ARAC_ONARIM_D.BIRIM_FIY,SRV_ARAC_ONARIM_D.URUN_KOD, SRV_ARAC_ONARIM_D.DOVKOD';
       ParamByName('URUN_KOD').AsString:=URUN_KOD;
       ParamByName('BIRIM_FIY').AsFloat:=BIRIM_FIY;
       ParamByName('CARI_KOD').AsString:=CARI_KOD;
       ParamByName('DOV_KOD').AsString:=DOV_KOD;
       Active := True;
       {OLCU_BIRIM:=DataMod.Planlama_Urun_Olcu_Birim(qrySiparis_D.FieldByName('URUN_KOD').AsString);
       While not qry.eof do
       begin
       //urun default bul ona göre miktarlarý hesapla

           //if OLCU_BIRIM

           //DataMod:=Planlama_Olcu_Birim_Miktar_Hes(URUN_KOD:String;OLCUBIRIM:String;Miktar:Double):Double;
       end;
       }
     end;
     result:=qryx.FieldByName('MIKTAR').AsFloat;
end;

function Miktar_bul_siparis_fat(URUN_KOD:String;BIRIM_FIY:Double;CARI_KOD:String;DOV_KOD:String):Double;
begin
     Result:=0;
     with qryx do
     begin
       Active := False;
       SQL.Clear;
       SQL.Text:=
       'SELECT  sum(ONARIM_D_FAT.MIKTAR) MIKTAR ,SRV_ARAC_ONARIM_D.BIRIM_FIY, SRV_ARAC_ONARIM_D.URUN_KOD,SRV_ARAC_ONARIM_D.DOVKOD FROM SRV_ARAC_ONARIM '+
       ' INNER JOIN SRV_ARAC_ONARIM_D ON (SRV_ARAC_ONARIM.ONARIM_SID=SRV_ARAC_ONARIM_D.ONARIM_SID AND SRV_ARAC_ONARIM.ONARIM_ID=SRV_ARAC_ONARIM_D.ONARIM_ID)'+
       ' left outer  JOIN ONARIM_D_FAT ON'+
       ' (ONARIM_D_FAT.ONARIM_ID=SRV_ARAC_ONARIM_D.ONARIM_ID AND ONARIM_D_FAT.ONARIMD_ID=SRV_ARAC_ONARIM_D.URUNHAR_ID)'+
       ' WHERE  SRV_ARAC_ONARIM_D.URUN_KOD=:URUN_KOD  and SRV_ARAC_ONARIM_D.BIRIM_FIY=:BIRIM_FIY'+
       ' AND SRV_ARAC_ONARIM.SECIM=1 AND SRV_ARAC_ONARIM_D.SECIM=1 AND SRV_ARAC_ONARIM.CARI_KOD=:CARI_KOD AND SRV_ARAC_ONARIM_D.DOVKOD=:DOV_KOD'+
       ' and (not (SRV_ARAC_ONARIM_D.MIKTAR=ONARIM_D_FAT.MIKTAR) or ONARIM_D_FAT.MIKTAR is null)'+
       ' GROUP BY SRV_ARAC_ONARIM_D.BIRIM_FIY,SRV_ARAC_ONARIM_D.URUN_KOD,SRV_ARAC_ONARIM_D.DOVKOD';

       qryx.ParamByName('URUN_KOD').AsString:=URUN_KOD;
       qryx.ParamByName('BIRIM_FIY').AsFloat:=BIRIM_FIY;
       qryx.ParamByName('CARI_KOD').AsString:=CARI_KOD;
       qryx.ParamByName('DOV_KOD').AsString:=DOV_KOD;
       Active := True;
     end;
     result:=qryx.FieldByName('MIKTAR').AsFloat;
end;

function Kac_adet_bul_siparis(URUN_KOD:String;BIRIM_FIY:Double;CARI_KOD:String;DOV_KOD:String):Double;
begin
     result:=0;
     with qryx do
     begin
       Active := False;
       SQL.Clear;
       SQL.Text:=
       'SELECT count(*) KAC_ADET, SRV_ARAC_ONARIM_D.BIRIM_FIY, SRV_ARAC_ONARIM_D.URUN_KOD,SRV_ARAC_ONARIM_D.DOVKOD FROM SRV_ARAC_ONARIM'+
       ' INNER JOIN SRV_ARAC_ONARIM_D ON (SRV_ARAC_ONARIM.ONARIM_SID=SRV_ARAC_ONARIM_D.ONARIM_SID AND SRV_ARAC_ONARIM.ONARIM_ID=SRV_ARAC_ONARIM_D.ONARIM_ID)'+
       ' WHERE  SRV_ARAC_ONARIM_D.URUN_KOD=:URUN_KOD  and SRV_ARAC_ONARIM_D.BIRIM_FIY=:BIRIM_FIY'+
       ' AND SRV_ARAC_ONARIM.SECIM=1 AND SRV_ARAC_ONARIM_D.SECIM=1 AND SRV_ARAC_ONARIM.CARI_KOD=:CARI_KOD AND SRV_ARAC_ONARIM_D.DOVKOD=:DOV_KOD'+
       ' GROUP BY SRV_ARAC_ONARIM_D.BIRIM_FIY,SRV_ARAC_ONARIM_D.URUN_KOD, SRV_ARAC_ONARIM_D.DOVKOD';
       qryx.ParamByName('URUN_KOD').AsString:=URUN_KOD;
       qryx.ParamByName('BIRIM_FIY').AsFloat:=BIRIM_FIY;
       qryx.ParamByName('CARI_KOD').AsString:=CARI_KOD;
       qryx.ParamByName('DOV_KOD').AsString:=DOV_KOD;
       Active := True;
     end;
     result:=qryx.FieldByName('KAC_ADET').AsFloat;
end;

var
  Birden_Fazla_Urun,Uygula:Boolean;
  Aktarilmis_Urun:TStringList;
  qryDeg:TIb_Query;
  DOV_KUR:Currency;
  a:Integer;
begin


for a:=0 to glb_DOV_LIST.Count-1 do
begin
      DOV_KUR := DataMod.Get_Doviz_Kur(glb_DOV_LIST[a],prv_Dov_Baz_Tar,glb_SATISKUR,0);
      if DOV_KUR<>0 then
      begin
//        qryURUNHAR.FieldByName('DOVKUR').AsCurrency := DOV_KUR ;
      end
      else
      begin
        Application.MessageBox('Aktarma Yapýlamadý. Döviz Kurlarýný Girip Tekrar Deneyiniz','Dikkat',MB_ICONWARNING);
        Abort;
      end;
end;

  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  Aktarilmis_Urun:= TStringList.Create;

  qrySiparis.DisableControls;
  qrySiparis_D.DisableControls;
  trnFAT_IRS.CommitRetaining;

try
  qrySiparis.First;
  qrySiparis_D.First;
  While Not qrySiparis.Eof Do
  begin

    if qrySiparis.FieldByName('Secim').AsInteger=1 then
    begin
  qrySiparis_D.Active:=False;
  qrySiparis_D.ParamByName('ONARIM_SID').AsInteger:=qrySiparis.FieldByName('ONARIM_SID').AsInteger;
  qrySiparis_D.ParamByName('ONARIM_ID').AsInteger:=qrySiparis.FieldByName('ONARIM_ID').AsInteger;
  qrySiparis_D.Active:=TRue;

    qrySiparis_D.First;
    While Not qrySiparis_D.Eof Do
    begin

      if qrySiparis_D.FieldByName('Secim').AsInteger=1 then
      begin

        Birden_Fazla_Urun:=False;
        Uygula:=True;

        qryDeg.Active := False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:=
        'SELECT count(*) KAC_ADET, SRV_ARAC_ONARIM_D.BIRIM_FIY, SRV_ARAC_ONARIM_D.URUN_KOD, SRV_ARAC_ONARIM_D.DOVKOD FROM SRV_ARAC_ONARIM'+
        ' INNER JOIN SRV_ARAC_ONARIM_D ON (SRV_ARAC_ONARIM.ONARIM_SID=SRV_ARAC_ONARIM_D.ONARIM_SID AND SRV_ARAC_ONARIM.ONARIM_ID=SRV_ARAC_ONARIM_D.ONARIM_ID)'+
        ' LEFT OUTER JOIN ONARIM_D_FAT ON'+
        ' (ONARIM_D_FAT.ONARIM_ID=SRV_ARAC_ONARIM_D.ONARIM_ID AND ONARIM_D_FAT.ONARIMD_ID=SRV_ARAC_ONARIM_D.URUNHAR_ID)'+
        ' WHERE  SRV_ARAC_ONARIM_D.URUN_KOD=:URUN_KOD  and SRV_ARAC_ONARIM_D.BIRIM_FIY=:BIRIM_FIY'+
        ' AND SRV_ARAC_ONARIM.SECIM=1 AND SRV_ARAC_ONARIM_D.SECIM=1 AND SRV_ARAC_ONARIM.CARI_KOD=:CARI_KOD AND SRV_ARAC_ONARIM_D.DOVKOD=:DOV_KOD'+
        ' GROUP BY SRV_ARAC_ONARIM_D.BIRIM_FIY,SRV_ARAC_ONARIM_D.URUN_KOD, SRV_ARAC_ONARIM_D.DOVKOD';
        qryDeg.ParamByName('URUN_KOD').AsString:=qrySiparis_D.FieldByName('URUN_KOD').AsString;
        qryDeg.ParamByName('BIRIM_FIY').AsFloat:=qrySiparis_D.FieldByName('BIRIM_FIY').AsFloat;
        qryDeg.ParamByName('CARI_KOD').AsString:=qrySiparis.FieldByName('CARI_KOD').AsString;
        qryDeg.ParamByName('DOV_KOD').AsString:=qrySiparis_D.FieldByName('DOVKOD').AsString;
        qryDeg.Active := True;
        if qryDeg.FieldByName('KAC_ADET').AsInteger>=1 then
        Birden_Fazla_Urun:=True;


        //ayný urunden birden fazla ise biri akratýlmýþsa aktarma
        if Birden_Fazla_Urun then
        begin
          if Aktarilmis_Urun.IndexOf(qrySiparis_D.FieldByName('URUNHAR_ID').AsString)>-1 then
          begin
            Birden_Fazla_Urun:=False;
            Uygula:=False;
          end;
        end;

        if Uygula then
        begin
          Kaynak.Append;
          Kaynak.FieldByName('URUN_KOD').AsString:=qrySiparis_D.FieldByName('URUN_KOD').AsString;
          Kaynak.FieldByName('TIP').AsString:=qrySiparis_D.FieldByName('TIP').AsString;
          Kaynak.FieldByName('BELGE_TUR').AsInteger:=qrySiparis_D.FieldByName('BELGE_TUR').AsInteger;
          Kaynak.FieldByName('BELGE_ID').AsInteger:=qrySiparis_D.FieldByName('BELGE_ID').AsInteger;
          Kaynak.FieldByName('BELGE_SID').AsInteger:=qrySiparis_D.FieldByName('BELGE_SID').AsInteger;
          Kaynak.FieldByName('BELGE_SIRA_NO').AsInteger:=qrySiparis_D.FieldByName('BELGE_SIRA_NO').AsInteger;
          Kaynak.FieldByName('TARIH').AsDateTime:=qrySiparis_D.FieldByName('TARIH').AsDateTime;
          Kaynak.FieldByName('FIILI_TAR').AsDateTime:=qrySiparis_D.FieldByName('FIILI_TAR').AsDateTime;
          Kaynak.FieldByName('DOV_BAZ_TAR').AsDateTime:=qrySiparis_D.FieldByName('DOV_BAZ_TAR').AsDateTime;
          Kaynak.FieldByName('MIKTAR').AsFloat:=qrySiparis_D.FieldByName('MIKTAR').AsFloat;

          if qrySiparis_D.FieldByName('FARK1').AsFloat>0 then
          //Kaynak.FieldByName('MIKTAR').AsFloat:=qrySiparis_D.FieldByName('MIKTAR').AsInteger-qrySiparis_D.FieldByName('FARK1').AsFloat;

          if (qrySiparis_D.FieldByName('MIKTAR').AsInteger-qrySiparis_D.FieldByName('FARK1').AsFloat)>0 then
          Kaynak.FieldByName('MIKTAR').AsFloat:=qrySiparis_D.FieldByName('MIKTAR').AsInteger-qrySiparis_D.FieldByName('FARK1').AsFloat;

          if Birden_Fazla_Urun then
          begin
            //if (DataMod.qryGENEL.FieldByName('KAC_ADET').AsInteger>=1) then
            Kaynak.FieldByName('MIKTAR').AsFloat:=
            Miktar_bul_siparis(qrySiparis_D.FieldByName('URUN_KOD').AsString,qrySiparis_D.FieldByName('BIRIM_FIY').AsFloat,qrySiparis.FieldByName('CARI_KOD').AsString,qrySiparis_D.FieldByName('DOVKOD').AsString)-
            Miktar_bul_siparis_fat(qrySiparis_D.FieldByName('URUN_KOD').AsString,qrySiparis_D.FieldByName('BIRIM_FIY').AsFloat,qrySiparis.FieldByName('CARI_KOD').AsString,qrySiparis_D.FieldByName('DOVKOD').AsString);
          end;


          Kaynak.FieldByName('OLCUBIRIM').AsString:=qrySiparis_D.FieldByName('OLCUBIRIM').AsString;

          {if Birden_Fazla_Urun then
          begin
             Kaynak.FieldByName('OLCUBIRIM').AsString:=DataMod.Planlama_Urun_Olcu_Birim(qrySiparis_D.FieldByName('URUN_KOD').AsString);
          end;
          }

          Kaynak.FieldByName('DOVKOD').AsString:=qrySiparis_D.FieldByName('DOVKOD').AsString;
          Kaynak.FieldByName('DOVKUR').AsFloat:=qrySiparis_D.FieldByName('DOVKUR').AsFloat;
          Kaynak.FieldByName('TUTAR').AsFloat:=qrySiparis_D.FieldByName('TUTAR').AsFloat;
          Kaynak.FieldByName('TUTAR_VPB').AsFloat:=qrySiparis_D.FieldByName('TUTAR_VPB').AsFloat;
          Kaynak.FieldByName('URUN_DOVKOD').AsString:=qrySiparis_D.FieldByName('URUN_DOVKOD').AsString;
          Kaynak.FieldByName('TUTAR_URUN_DOVKOD').AsFloat:=qrySiparis_D.FieldByName('TUTAR_URUN_DOVKOD').AsFloat;
          Kaynak.FieldByName('BIRIM_FIY').AsFloat:=qrySiparis_D.FieldByName('BIRIM_FIY').AsFloat;
          Kaynak.FieldByName('BIRIM_FIY_VPB').AsFloat:=qrySiparis_D.FieldByName('BIRIM_FIY_VPB').AsFloat;
          Kaynak.FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat:=qrySiparis_D.FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat;
          Kaynak.FieldByName('ISKONTO_TUTAR').AsFloat:=qrySiparis_D.FieldByName('ISKONTO_TUTAR').AsFloat;
          Kaynak.FieldByName('ISKONTO_TUTAR_VPB').AsFloat:=qrySiparis_D.FieldByName('ISKONTO_TUTAR_VPB').AsFloat;
          Kaynak.FieldByName('OLCUBIRIM_URN_OB').AsString:=qrySiparis_D.FieldByName('OLCUBIRIM_URN_OB').AsString;
          Kaynak.FieldByName('MIKTAR_URN_OB').AsFloat:=qrySiparis_D.FieldByName('MIKTAR_URN_OB').AsFloat;
          Kaynak.FieldByName('DEPO_KOD').AsString:=qrySiparis_D.FieldByName('DEPO_KOD').AsString;
          Kaynak.FieldByName('KOD1').AsString:=qrySiparis_D.FieldByName('KOD1').AsString;
          Kaynak.FieldByName('KOD2').AsString:=qrySiparis_D.FieldByName('KOD2').AsString;
          Kaynak.FieldByName('KOD3').AsString:=qrySiparis_D.FieldByName('KOD3').AsString;
          Kaynak.FieldByName('KOD4').AsString:=qrySiparis_D.FieldByName('KOD4').AsString;
          Kaynak.FieldByName('ACIKLAMA').AsString:=qrySiparis_D.FieldByName('ACIKLAMA').AsString;
          Kaynak.FieldByName('ISKONTO_TIP').AsInteger:=qrySiparis_D.FieldByName('ISKONTO_TIP').AsInteger;
          Kaynak.FieldByName('ISKONTO_ORAN').AsInteger:=qrySiparis_D.FieldByName('ISKONTO_ORAN').AsInteger;
          Kaynak.FieldByName('KDV').AsInteger:=qrySiparis_D.FieldByName('KDV').AsInteger;
          Kaynak.FieldByName('KDV_TUTAR').AsFloat:=qrySiparis_D.FieldByName('KDV_TUTAR').AsFloat;
          Kaynak.Post;


          frmFAT_Srv.Disaridan_Fatura:=True;



          if not Birden_Fazla_Urun then
          begin
            //tek kalem ise aktarma tablosuna ekle
            qry_Siparis_Fat.Append;
            qry_Siparis_Fat.FieldByName('ONARIM_D_FAT_ID').AsInteger:=qry_Siparis_Fat.Gen_ID('GEN_ONARIM_D_FAT',1);
            qry_Siparis_Fat.FieldByName('ONARIM_ID').AsInteger:=qrySiparis.FieldByName('ONARIM_ID').AsInteger;
            qry_Siparis_Fat.FieldByName('ONARIMD_ID').AsInteger:=qrySiparis_D.FieldByName('URUNHAR_ID').AsInteger;
            qry_Siparis_Fat.FieldByName('MIKTAR').AsFloat:=qrySiparis_D.FieldByName('MIKTAR').AsFloat;

            //siparisdfat da da kayýt varsa fark1 de deger olur ozaman kalan miktar aktarýlýr fark1 aktarýlan miktar toplamýdýr
            if qrySiparis_D.FieldByName('FARK1').AsFloat>0 then
            qry_Siparis_Fat.FieldByName('MIKTAR').AsFloat:=
            qrySiparis_D.FieldByName('MIKTAR').AsInteger-
            qrySiparis_D.FieldByName('FARK1').AsFloat;

            qry_Siparis_Fat.FieldByName('FATURA_ID').AsInteger:=Kaynak.FieldByName('FATURA_ID').AsInteger;

            qry_Siparis_Fat.FieldByName('FATURAD_ID').AsInteger:=Kaynak.FieldByName('URUNHAR_ID').AsInteger;

            qry_Siparis_Fat.FieldByName('NEREDEN').AsString:='0';//IntToStr(prv_FAT_IRS_SEP);
            qry_Siparis_Fat.FieldByName('TAM_AKTARIM').AsString:='1';

            qry_Siparis_Fat.Post;
          end
          else
          begin
            //ayný birim fiyata ait seçilmiþ ayný urun varsa bunlarýn hareket idlerinin alarak aktarma tablosuna tüm kayýtlarý yaz
            DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
            qryDeg.Active := False;
            qryDeg.SQL.Clear;
            qryDeg.SQL.Text:=
            'SELECT SRV_ARAC_ONARIM_D.URUNHAR_ID, SRV_ARAC_ONARIM_D.ONARIM_ID  FROM SRV_ARAC_ONARIM '+
            ' INNER JOIN SRV_ARAC_ONARIM_D ON (SRV_ARAC_ONARIM.ONARIM_SID=SRV_ARAC_ONARIM_D.ONARIM_SID AND SRV_ARAC_ONARIM.ONARIM_ID=SRV_ARAC_ONARIM_D.ONARIM_ID)'+
            ' WHERE  SRV_ARAC_ONARIM_D.URUN_KOD=:URUN_KOD AND SRV_ARAC_ONARIM_D.BIRIM_FIY=:BIRIM_FIY'+
            ' AND SRV_ARAC_ONARIM.SECIM=1 AND SRV_ARAC_ONARIM_D.SECIM=1 AND SRV_ARAC_ONARIM.CARI_KOD=:CARI_KOD AND SRV_ARAC_ONARIM_D.DOVKOD=:DOV_KOD';
            qryDeg.ParamByName('URUN_KOD').AsString:=qrySiparis_D.FieldByName('URUN_KOD').AsString;
            qryDeg.ParamByName('BIRIM_FIY').AsFloat:=qrySiparis_D.FieldByName('BIRIM_FIY').AsFloat;
            qryDeg.ParamByName('CARI_KOD').AsString:=qrySiparis.FieldByName('CARI_KOD').AsString;
            qryDeg.ParamByName('DOV_KOD').AsString:=qrySiparis_D.FieldByName('DOVKOD').AsString;
            qryDeg.Active := True;



            While not qryDeg.Eof do
            begin

              //qrySiparis_D.Locate('URUNHAR_ID',qryDeg.FieldByName('URUNHAR_ID').AsInteger,[]);
              qry_Siparis_Fat.Append;
              qry_Siparis_Fat.FieldByName('ONARIM_D_FAT_ID').AsInteger:=qry_Siparis_Fat.Gen_ID('GEN_ONARIM_D_FAT',1);
              qry_Siparis_Fat.FieldByName('ONARIM_ID').AsInteger:=qryDeg.FieldByName('ONARIM_ID').AsInteger;
              qry_Siparis_Fat.FieldByName('ONARIMD_ID').AsInteger:=qryDeg.FieldByName('URUNHAR_ID').AsInteger;

              //qry_Siparis_Fat.FieldByName('MIKTAR').AsFloat:=qrySiparis_D.FieldByName('MIKTAR').AsFloat;

              //eger siparisdfat ile birlikte birden fazla ise ama seçilenler arasýnda tek ise
              //kalan miktar ý atmak için tek lýk kontrolu ile aktarýlan mýktar yazýlýr
              //if Kac_adet_bul_siparis(qrySiparis_D.FieldByName('URUN_KOD').AsString,qrySiparis_D.FieldByName('BIRIM_FIY').AsFloat,qrySiparis.FieldByName('CARI_KOD').AsString)<=1 then
              qry_Siparis_Fat.FieldByName('MIKTAR').AsFloat:=Kaynak.FieldByName('MIKTAR').AsFloat;

              qry_Siparis_Fat.FieldByName('FATURA_ID').AsInteger:=Kaynak.FieldByName('FATURA_ID').AsInteger;

              qry_Siparis_Fat.FieldByName('FATURAD_ID').AsInteger:=Kaynak.FieldByName('URUNHAR_ID').AsInteger;
              qry_Siparis_Fat.FieldByName('NEREDEN').AsString:='0';//IntToStr(prv_FAT_IRS_SEP);
              qry_Siparis_Fat.FieldByName('TAM_AKTARIM').AsString:='0';

              qry_Siparis_Fat.Post;
              Aktarilmis_Urun.Add(qryDeg.FieldByName('URUNHAR_ID').AsString);

              qryDeg.Next;
            end;
          end;//birden fazla ürün

        end;//uygula



      end;//secim
      qrySiparis_D.Next;
    end;
    end;
    qrySiparis.Next;
  end;

except
  frmFAT_Srv.Onarim_Aktarma:=False;
  frmFAT_Srv.Disaridan_Fatura:=False;
  frmFAT_Srv.trnFAT_IRS.RollbackRetaining;

  qry_Siparis_Fat.CancelUpdates;
  Application.MessageBox('Aktarma yapýlamadý.','Dikkat',MB_ICONWARNING);
end;


//qrySiparis_D.CancelUpdates;

//qrySiparis.CancelUpdates;

qry_Siparis_Fat.ApplyUpdates;
qry_Siparis_Fat.CommitUpdates;




end;

procedure TfrmOnarim_Fatura_Bir.IB_Grid2DblClick(Sender: TObject);
begin
{  if qrySiparis_D.FieldByName('URUNHAR_ID').AsInteger>0 then
  begin
    if qrySiparis_D.FieldByName('SECIM').AsInteger=1 then
    qrySiparis_D.FieldByName('SECIM').AsInteger:=0
    else
    qrySiparis_D.FieldByName('SECIM').AsInteger:=1;
    qrySiparis_D.Post;
  end;
}
end;

procedure TfrmOnarim_Fatura_Bir.IB_Grid1Exit(Sender: TObject);
begin
  if qrySiparis.State in [dssInsert,dssEdit] then
  qrySiparis.Post;
end;

procedure TfrmOnarim_Fatura_Bir.qrySiparisAfterPost(IB_Dataset: TIB_Dataset);
begin
  qrySiparisAfterScroll(Nil);
end;

procedure TfrmOnarim_Fatura_Bir.IB_Grid2Exit(Sender: TObject);
begin
  if qrySiparis_D.State in [dssInsert,dssEdit] then
  qrySiparis_D.Post;
end;

procedure TfrmOnarim_Fatura_Bir.qrySiparis_DCalculateField( Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
  with AField do
    if FieldName = 'FARK1' then
    AField.AsFloat:=ARow.ByName('MIKTAR').AsFloat-ARow.ByName('AKTARILAN_MIKTAR').AsFloat;
end;

procedure TfrmOnarim_Fatura_Bir.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmOnarim_Fatura_Bir);
end;

end.



{
and SRV_ARAC_ONARIM_D.AKTARILAN_MIKTAR<SRV_ARAC_ONARIM_D.MIKTAR

and AKTARILAN_MIKTAR<MIKTAR





