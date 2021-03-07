unit ufrmSiparis_Fatura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Grids, IB_Grid, Buttons, ExtCtrls,Db;

type
  TfrmSiparis_Fatura = class(TForm)
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
    qry: TIB_Query;
    Label2: TLabel;
    Memo1: TMemo;

    procedure btnCikisClick(Sender: TObject);
    procedure qrySiparisAfterScroll(IB_Dataset: TIB_Dataset);
    procedure IB_Grid1DblClick(Sender: TObject);
    procedure IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Grid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure IB_Grid2DblClick(Sender: TObject);
    procedure qrySiparisBeforePost(IB_Dataset: TIB_Dataset);
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
    function Form_Open(FAT_IRS_SEP: Byte; CARI_KOD: String;Cari_Adi:String;Tip:Integer;Dov_Baz_Tar:TDateTime):Boolean;
    { Public declarations }
  end;

var
  frmSiparis_Fatura: TfrmSiparis_Fatura;

implementation

uses unDataMod, ufrmFAT_IRS, UnFunc, ufrmIRSALIYE;

{$R *.dfm}

function TfrmSiparis_Fatura.Form_Open(FAT_IRS_SEP:Byte;CARI_KOD:String;Cari_Adi:String;Tip:Integer;Dov_Baz_Tar:TDateTime):Boolean;
begin
  Application.CreateForm (TfrmSiparis_Fatura,frmSiparis_Fatura);
  frmSiparis_Fatura.prv_FAT_IRS_SEP:=FAT_IRS_SEP;
  frmSiparis_Fatura.prv_CARI_KOD:=CARI_KOD;
  frmSiparis_Fatura.lblCariAD.Caption:=Cari_Adi;
  frmSiparis_Fatura.prv_Dov_Baz_Tar:=Dov_Baz_Tar;

  frmSiparis_Fatura.prv_tip:=TIP;
{  if TIP=1 then
  frmSiparis_Fatura.prv_tip:=2;

  if TIP=2 then
  frmSiparis_Fatura.prv_tip:=1;

}

  frmSiparis_Fatura.trnFAT_IRS.StartTransaction;
  with frmSiparis_Fatura.qry do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text:=
    'UPDATE SIPARIS_D SET SECIM=0 WHERE FATURA_ID IN (SELECT FAT_IRS_ID FROM SIPARIS WHERE SIPARIS.CARI_KOD=:PRM_CARI_KOD AND SIPARIS.TIP=:TIP)';
    ParamByName('PRM_CARI_KOD').AsString:=frmSiparis_Fatura.prv_CARI_KOD;
    ParamByName('TIP').AsInteger:=frmSiparis_Fatura.prv_TIP;
    ExecSql;
  end;
  with frmSiparis_Fatura.qry do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text:=
    'UPDATE SIPARIS SET SECIM=0 WHERE SIPARIS.CARI_KOD=:PRM_CARI_KOD AND SIPARIS.TIP=:TIP';
    ParamByName('PRM_CARI_KOD').AsString:=frmSiparis_Fatura.prv_CARI_KOD;
    ParamByName('TIP').AsInteger:=frmSiparis_Fatura.prv_TIP;
    ExecSql;
  end;
  frmSiparis_Fatura.trnFAT_IRS.Commit;
  frmSiparis_Fatura.trnFAT_IRS.StartTransaction;
  frmSiparis_Fatura.res_Cari:=TStringList.Create;

  frmSiparis_Fatura.qrySiparis.Active:=False;
  //frmSiparis_Fatura.qrySiparis.ParamByName('PRM_FAT_IRS_SEP').AsInteger:=frmSiparis_Fatura.Prv_FAT_IRS_SEP;
  frmSiparis_Fatura.qrySiparis.ParamByName('PRM_FAT_IRS_SEP').AsInteger:=1;
  frmSiparis_Fatura.qrySiparis.ParamByName('PRM_CARI_KOD').AsString:=frmSiparis_Fatura.prv_CARI_KOD;
  frmSiparis_Fatura.qrySiparis.ParamByName('TIP').AsInteger:=frmSiparis_Fatura.prv_TIP;
  frmSiparis_Fatura.qrySiparis.Active:=True;
  if DataMod.FN_CariKOD2Bilgi(frmSiparis_Fatura.prv_Cari_KOD,frmSiparis_Fatura.Res_Cari) then
  frmSiparis_Fatura.lblCariAD.Caption:=frmSiparis_Fatura.Res_Cari[1];

  frmSiparis_Fatura.ShowModal;

  if not frmSiparis_Fatura.prv_Kontrol Then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;
  frmSiparis_Fatura.Close;
  frmSiparis_Fatura.Release;
end;

procedure TfrmSiparis_Fatura.btnCikisClick(Sender: TObject);
begin

     if prv_FAT_IRS_SEP=1 then
     begin
          frmFAT_IRS.Siparis_Aktarma:=False;
     end;

     if prv_FAT_IRS_SEP=2 then
     begin
          frmIRSALIYE.Siparis_Aktarma:=False;
     end;

     trnFAT_IRS.Commit;
     prv_Kontrol := False;
     Close;
end;

procedure TfrmSiparis_Fatura.qrySiparisAfterScroll( IB_Dataset: TIB_Dataset);
begin
  qrySiparis_D.Active:=False;
  qrySiparis_D.ParamByName('FATURA_SID').AsInteger:=qrySiparis.FieldByName('FAT_IRS_SID').AsInteger;
  qrySiparis_D.ParamByName('FATURA_ID').AsInteger:=qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
  qrySiparis_D.Active:=TRue;
end;

procedure TfrmSiparis_Fatura.IB_Grid1DblClick(Sender: TObject);
begin
  if qrySiparis.FieldByName('FAT_IRS_ID').AsInteger>0 then
  begin
    if qrySiparis.FieldByName('SECIM').AsInteger=1 then
    qrySiparis.FieldByName('SECIM').AsInteger:=0
    else
    qrySiparis.FieldByName('SECIM').AsInteger:=1;
    qrySiparis.Post;
  end;
end;

procedure TfrmSiparis_Fatura.IB_Grid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=VK_Space then
      IB_Grid1.OnDblClick(nil);
end;

procedure TfrmSiparis_Fatura.IB_Grid2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if Key=VK_Space then
      IB_Grid2.OnDblClick(nil);
end;

procedure TfrmSiparis_Fatura.SpeedButton1Click(Sender: TObject);
var
   Sonuc:Boolean;
begin
  if qrySiparis.State in [dssInsert,dssEdit] then
  qrySiparis.Post;
  if qrySiparis_D.State in [dssInsert,dssEdit] then
  qrySiparis_D.Post;
  trnFAT_IRS.CommitRetaining;

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

  if Prv_FAT_IRS_SEP=1 then
  Aktar(frmFAT_IRS.qryURUNHAR);

  if Prv_FAT_IRS_SEP=2 then
  Aktar(frmIRSALIYE.qryURUNHAR);

  trnFAT_IRS.Commit;
  prv_Kontrol := True;
  Close;
end;


procedure TfrmSiparis_Fatura.Aktar(var Kaynak:TIB_Query);

function Miktar_bul_siparis(URUN_KOD:String;BIRIM_FIY:Double;CARI_KOD:String;DOV_KOD:String):Double;
var
   Miktar:Double;
   OLCU_BIRIM:String;
begin
//birden fazla kullan için bir temp alan updatele ve buna göre sorgula
     Result:=0;
     with qry do
     begin
       Active := False;
       SQL.Clear;
       SQL.Text:=
       'SELECT SUM(MIKTAR) MIKTAR, SIPARIS_D.BIRIM_FIY, SIPARIS_D.URUN_KOD,SIPARIS_D.DOVKOD FROM SIPARIS'+
       ' INNER JOIN SIPARIS_D ON (SIPARIS.FAT_IRS_SID=SIPARIS_D.FATURA_SID AND SIPARIS.FAT_IRS_ID=SIPARIS_D.FATURA_ID)'+
       ' WHERE SIPARIS_D.URUN_KOD=:URUN_KOD  and SIPARIS_D.BIRIM_FIY=:BIRIM_FIY'+
       ' AND SIPARIS.SECIM=1 AND SIPARIS_D.SECIM=1 AND SIPARIS.CARI_KOD=:CARI_KOD AND SIPARIS_D.DOVKOD=:DOV_KOD'+
       ' GROUP BY SIPARIS_D.BIRIM_FIY,SIPARIS_D.URUN_KOD, SIPARIS_D.DOVKOD';
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
     result:=qry.FieldByName('MIKTAR').AsFloat;
end;

function Miktar_bul_siparis_fat(URUN_KOD:String;BIRIM_FIY:Double;CARI_KOD:String;DOV_KOD:String):Double;
begin
     Result:=0;
     with qry do
     begin
       Active := False;
       SQL.Clear;
       SQL.Text:=
       'SELECT  sum(SIPARIS_D_FAT.MIKTAR) MIKTAR ,SIPARIS_D.BIRIM_FIY, SIPARIS_D.URUN_KOD,SIPARIS_D.DOVKOD FROM SIPARIS '+
       ' INNER JOIN SIPARIS_D ON (SIPARIS.FAT_IRS_SID=SIPARIS_D.FATURA_SID AND SIPARIS.FAT_IRS_ID=SIPARIS_D.FATURA_ID)'+
       ' left outer  JOIN SIPARIS_D_FAT ON'+
       ' (SIPARIS_D_FAT.SIPARIS_ID=SIPARIS_D.FATURA_ID AND SIPARIS_D_FAT.SIPARISD_ID=SIPARIS_D.URUNHAR_ID)'+
       ' WHERE  SIPARIS_D.URUN_KOD=:URUN_KOD  and SIPARIS_D.BIRIM_FIY=:BIRIM_FIY'+
       ' AND SIPARIS.SECIM=1 AND SIPARIS_D.SECIM=1 AND SIPARIS.CARI_KOD=:CARI_KOD AND SIPARIS_D.DOVKOD=:DOV_KOD'+
       ' and (not (SIPARIS_D.MIKTAR=SIPARIS_D_FAT.MIKTAR) or SIPARIS_D_FAT.MIKTAR is null)'+
       ' GROUP BY SIPARIS_D.BIRIM_FIY,SIPARIS_D.URUN_KOD,SIPARIS_D.DOVKOD';

       qry.ParamByName('URUN_KOD').AsString:=URUN_KOD;
       qry.ParamByName('BIRIM_FIY').AsFloat:=BIRIM_FIY;
       qry.ParamByName('CARI_KOD').AsString:=CARI_KOD;
       qry.ParamByName('DOV_KOD').AsString:=DOV_KOD;
       Active := True;
     end;
     result:=qry.FieldByName('MIKTAR').AsFloat;
end;

function Kac_adet_bul_siparis(URUN_KOD:String;BIRIM_FIY:Double;CARI_KOD:String;DOV_KOD:String):Double;
begin
     result:=0;
     with qry do
     begin
       Active := False;
       SQL.Clear;
       SQL.Text:=
       'SELECT count(*) KAC_ADET, SIPARIS_D.BIRIM_FIY, SIPARIS_D.URUN_KOD,SIPARIS_D.DOVKOD FROM SIPARIS'+
       ' INNER JOIN SIPARIS_D ON (SIPARIS.FAT_IRS_SID=SIPARIS_D.FATURA_SID AND SIPARIS.FAT_IRS_ID=SIPARIS_D.FATURA_ID)'+
       ' WHERE  SIPARIS_D.URUN_KOD=:URUN_KOD  and SIPARIS_D.BIRIM_FIY=:BIRIM_FIY'+
       ' AND SIPARIS.SECIM=1 AND SIPARIS_D.SECIM=1 AND SIPARIS.CARI_KOD=:CARI_KOD AND SIPARIS_D.DOVKOD=:DOV_KOD'+
       ' GROUP BY SIPARIS_D.BIRIM_FIY,SIPARIS_D.URUN_KOD, SIPARIS_D.DOVKOD';
       qry.ParamByName('URUN_KOD').AsString:=URUN_KOD;
       qry.ParamByName('BIRIM_FIY').AsFloat:=BIRIM_FIY;
       qry.ParamByName('CARI_KOD').AsString:=CARI_KOD;
       qry.ParamByName('DOV_KOD').AsString:=DOV_KOD;
       Active := True;
     end;
     result:=qry.FieldByName('KAC_ADET').AsFloat;
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
  qrySiparis_D.ParamByName('FATURA_SID').AsInteger:=qrySiparis.FieldByName('FAT_IRS_SID').AsInteger;
  qrySiparis_D.ParamByName('FATURA_ID').AsInteger:=qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
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
        'SELECT count(*) KAC_ADET, SIPARIS_D.BIRIM_FIY, SIPARIS_D.URUN_KOD, SIPARIS_D.DOVKOD FROM SIPARIS'+
        ' INNER JOIN SIPARIS_D ON (SIPARIS.FAT_IRS_SID=SIPARIS_D.FATURA_SID AND SIPARIS.FAT_IRS_ID=SIPARIS_D.FATURA_ID)'+
        ' LEFT OUTER JOIN SIPARIS_D_FAT ON'+
        ' (SIPARIS_D_FAT.SIPARIS_ID=SIPARIS_D.FATURA_ID AND SIPARIS_D_FAT.SIPARISD_ID=SIPARIS_D.URUNHAR_ID)'+
        ' WHERE  SIPARIS_D.URUN_KOD=:URUN_KOD  and SIPARIS_D.BIRIM_FIY=:BIRIM_FIY'+
        ' AND SIPARIS.SECIM=1 AND SIPARIS_D.SECIM=1 AND SIPARIS.CARI_KOD=:CARI_KOD AND SIPARIS_D.DOVKOD=:DOV_KOD'+
        ' GROUP BY SIPARIS_D.BIRIM_FIY,SIPARIS_D.URUN_KOD, SIPARIS_D.DOVKOD';
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


          if prv_FAT_IRS_SEP=1 then
          begin
          frmFAT_IRS.Siparis_Aktarma:=True;
          frmFAT_IRS.Disaridan_Fatura:=True;
          end;

          if prv_FAT_IRS_SEP=2 then
          begin
          frmIRSALIYE.Siparis_Aktarma:=True;
          frmIRSALIYE.Disaridan_Fatura:=True;
          end;


          if not Birden_Fazla_Urun then
          begin
            //tek kalem ise aktarma tablosuna ekle
            qry_Siparis_Fat.Append;
            qry_Siparis_Fat.FieldByName('SIPARIS_D_FAT_ID').AsInteger:=qry_Siparis_Fat.Gen_ID('GEN_SIPARIS_D_FAT',1);
            qry_Siparis_Fat.FieldByName('SIPARIS_ID').AsInteger:=qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
            qry_Siparis_Fat.FieldByName('SIPARISD_ID').AsInteger:=qrySiparis_D.FieldByName('URUNHAR_ID').AsInteger;
            qry_Siparis_Fat.FieldByName('MIKTAR').AsFloat:=qrySiparis_D.FieldByName('MIKTAR').AsFloat;

            //siparisdfat da da kayýt varsa fark1 de deger olur ozaman kalan miktar aktarýlýr fark1 aktarýlan miktar toplamýdýr
            if qrySiparis_D.FieldByName('FARK1').AsFloat>0 then
            qry_Siparis_Fat.FieldByName('MIKTAR').AsFloat:=
            qrySiparis_D.FieldByName('MIKTAR').AsInteger-
            qrySiparis_D.FieldByName('FARK1').AsFloat;

          if prv_FAT_IRS_SEP=1 then
            qry_Siparis_Fat.FieldByName('FATURA_ID').AsInteger:=Kaynak.FieldByName('FATURA_ID').AsInteger;

          if prv_FAT_IRS_SEP=2 then
            qry_Siparis_Fat.FieldByName('FATURA_ID').AsInteger:=Kaynak.FieldByName('IRSALIYE_ID').AsInteger;

            qry_Siparis_Fat.FieldByName('FATURAD_ID').AsInteger:=Kaynak.FieldByName('URUNHAR_ID').AsInteger;

            qry_Siparis_Fat.FieldByName('NEREDEN').AsString:=IntToStr(prv_FAT_IRS_SEP);
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
            'SELECT SIPARIS_D.URUNHAR_ID, SIPARIS_D.FATURA_ID  FROM SIPARIS '+
            ' INNER JOIN SIPARIS_D ON (SIPARIS.FAT_IRS_SID=SIPARIS_D.FATURA_SID AND SIPARIS.FAT_IRS_ID=SIPARIS_D.FATURA_ID)'+
            ' WHERE  SIPARIS_D.URUN_KOD=:URUN_KOD AND SIPARIS_D.BIRIM_FIY=:BIRIM_FIY'+
            ' AND SIPARIS.SECIM=1 AND SIPARIS_D.SECIM=1 AND SIPARIS.CARI_KOD=:CARI_KOD AND SIPARIS_D.DOVKOD=:DOV_KOD';
            qryDeg.ParamByName('URUN_KOD').AsString:=qrySiparis_D.FieldByName('URUN_KOD').AsString;
            qryDeg.ParamByName('BIRIM_FIY').AsFloat:=qrySiparis_D.FieldByName('BIRIM_FIY').AsFloat;
            qryDeg.ParamByName('CARI_KOD').AsString:=qrySiparis.FieldByName('CARI_KOD').AsString;
            qryDeg.ParamByName('DOV_KOD').AsString:=qrySiparis_D.FieldByName('DOVKOD').AsString;
            qryDeg.Active := True;



            While not qryDeg.Eof do
            begin

              //qrySiparis_D.Locate('URUNHAR_ID',qryDeg.FieldByName('URUNHAR_ID').AsInteger,[]);
              qry_Siparis_Fat.Append;
              qry_Siparis_Fat.FieldByName('SIPARIS_D_FAT_ID').AsInteger:=qry_Siparis_Fat.Gen_ID('GEN_SIPARIS_D_FAT',1);
              qry_Siparis_Fat.FieldByName('SIPARIS_ID').AsInteger:=qryDeg.FieldByName('FATURA_ID').AsInteger;
              qry_Siparis_Fat.FieldByName('SIPARISD_ID').AsInteger:=qryDeg.FieldByName('URUNHAR_ID').AsInteger;

              //qry_Siparis_Fat.FieldByName('MIKTAR').AsFloat:=qrySiparis_D.FieldByName('MIKTAR').AsFloat;

              //eger siparisdfat ile birlikte birden fazla ise ama seçilenler arasýnda tek ise
              //kalan miktar ý atmak için tek lýk kontrolu ile aktarýlan mýktar yazýlýr
              //if Kac_adet_bul_siparis(qrySiparis_D.FieldByName('URUN_KOD').AsString,qrySiparis_D.FieldByName('BIRIM_FIY').AsFloat,qrySiparis.FieldByName('CARI_KOD').AsString)<=1 then
              qry_Siparis_Fat.FieldByName('MIKTAR').AsFloat:=Kaynak.FieldByName('MIKTAR').AsFloat;

          if prv_FAT_IRS_SEP=1 then
              qry_Siparis_Fat.FieldByName('FATURA_ID').AsInteger:=Kaynak.FieldByName('FATURA_ID').AsInteger;
          if prv_FAT_IRS_SEP=2 then
            qry_Siparis_Fat.FieldByName('FATURA_ID').AsInteger:=Kaynak.FieldByName('IRSALIYE_ID').AsInteger;

              qry_Siparis_Fat.FieldByName('FATURAD_ID').AsInteger:=Kaynak.FieldByName('URUNHAR_ID').AsInteger;
              qry_Siparis_Fat.FieldByName('NEREDEN').AsString:=IntToStr(prv_FAT_IRS_SEP);
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
if prv_FAT_IRS_SEP=1 then
begin
  frmFAT_IRS.Siparis_Aktarma:=False;
  frmFAT_IRS.Disaridan_Fatura:=False;
  frmFAT_IRS.trnFAT_IRS.RollbackRetaining;
end;

if prv_FAT_IRS_SEP=2 then
begin
  frmIRSALIYE.Siparis_Aktarma:=False;
  frmIRSALIYE.Disaridan_Fatura:=False;
  frmIRSALIYE.trnFAT_IRS.RollbackRetaining;
end;


  qry_Siparis_Fat.CancelUpdates;
  Application.MessageBox('Aktarma yapýlamadý.','Dikkat',MB_ICONWARNING);
end;
//qrySiparis_D.CancelUpdates;
//qrySiparis.CancelUpdates;

qry_Siparis_Fat.ApplyUpdates;
qry_Siparis_Fat.CommitUpdates;

end;

procedure TfrmSiparis_Fatura.IB_Grid2DblClick(Sender: TObject);
begin
  if qrySiparis_D.FieldByName('URUNHAR_ID').AsInteger>0 then
  begin
    if qrySiparis_D.FieldByName('SECIM').AsInteger=1 then
    qrySiparis_D.FieldByName('SECIM').AsInteger:=0
    else
    qrySiparis_D.FieldByName('SECIM').AsInteger:=1;
    qrySiparis_D.Post;
  end;

 {if qrySiparis.FieldByName('SECIM').AsInteger=0 then
  begin
  qrySiparis.FieldByName('SECIM').AsInteger:=1;
  qrySiparis.Post;
  end;}
end;

procedure TfrmSiparis_Fatura.qrySiparisBeforePost(IB_Dataset: TIB_Dataset);
begin
     {with qry do
     begin
       Active := False;
       SQL.Clear;
       SQL.Text:=
       'UPDATE SIPARIS_D SET SECIM=:SECIM WHERE SIPARIS_D.FATURA_ID=:FATURA_ID AND SIPARIS_D.FATURA_SID=:FATURA_SID';
       ParamByName('FATURA_SID').AsInteger:=qrySiparis.FieldByName('FAT_IRS_SID').AsInteger;
       ParamByName('FATURA_ID').AsInteger:=qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
       ParamByName('SECIM').AsInteger:=qrySiparis.FieldByName('SECIM').AsInteger;
       ExecSql;
     end;
     }

    {qrySiparis_D.DisableControls;
     qrySiparis_D.First;
     While not qrySiparis_D.eof
     do
     begin
        qrySiparis_D.FieldByName('SECIM').AsInteger:=1;
        qrySiparis_D.Post;
        qrySiparis_D.Next;
     end;

     qrySiparis_D.EnableControls;
     }
end;

procedure TfrmSiparis_Fatura.IB_Grid1Exit(Sender: TObject);
begin
  if qrySiparis.State in [dssInsert,dssEdit] then
  qrySiparis.Post;
end;

procedure TfrmSiparis_Fatura.qrySiparisAfterPost(IB_Dataset: TIB_Dataset);
begin
  qrySiparisAfterScroll(Nil);
end;

procedure TfrmSiparis_Fatura.IB_Grid2Exit(Sender: TObject);
begin
  if qrySiparis_D.State in [dssInsert,dssEdit] then
  qrySiparis_D.Post;
end;

procedure TfrmSiparis_Fatura.qrySiparis_DCalculateField( Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
{  with qry do
  begin
    Active := False;
    SQL.Clear;
    SQL.Text:=
    'SELECT SUM(MIKTAR) AKTARILAN FROM SIPARIS_D_FAT WHERE SIPARISD_ID=:URUNHAR_ID';
    //ParamByName('URUNHAR_ID').AsInteger:=qrySiparis_D.FieldByName('URUNHAR_ID').AsInteger;
    ParamByName('URUNHAR_ID').AsInteger:=ARow.ByName('URUNHAR_ID').AsInteger;
    Active := True;
  end;

  with AField do
    if FieldName = 'FARK1' then
    AField.AsFloat:=Qry.FieldByName('AKTARILAN').AsFloat;
   // qrySiparis_D.FieldByName('FARK1').AsFloat:=Qry.FieldByName('AKTARILAN').AsFloat;
}

  with AField do
    if FieldName = 'FARK1' then
    AField.AsFloat:=ARow.ByName('MIKTAR').AsFloat-ARow.ByName('AKTARILAN_MIKTAR').AsFloat;

end;

procedure TfrmSiparis_Fatura.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmSiparis_Fatura);
end;

end.







