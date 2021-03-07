unit ufrmRaporFatura_Sefer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, StdCtrls, ExtCtrls, frxClass,
  frxIBOSet;

type
  TfrmRaporFatura_Sefer = class(TForm)
    Label36: TLabel;
    TxtMazotcu: TEdit;
    Button7: TButton;
    Label19: TLabel;
    qrySefer: TIB_Query;
    Btn_Bul: TButton;
    IB_Grid1: TIB_Grid;
    IB_DataSource1: TIB_DataSource;
    Button1: TButton;
    Rg_Fatura_Tipi: TRadioGroup;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    frxReport1: TfrxReport;
    frxIBODataset1: TfrxIBODataset;
    IB_Query1: TIB_Query;
    Button5: TButton;
    procedure Button7Click(Sender: TObject);
    procedure TxtMazotcuExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Btn_BulClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TxtMazotcuEnter(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure Button5Click(Sender: TObject);
  private
  Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRaporFatura_Sefer: TfrmRaporFatura_Sefer;

implementation

uses unDataMod, ufrmCariSDLG, UnFunc, ufrmFAT_IRS, ufrmSefer, ufrmFAT_Tran,

DateUtils, ufrmCekSenSDLG, StdConvs, 
  ufrmRaporCiktisi;

{$R *.dfm}

procedure TfrmRaporFatura_Sefer.Button7Click(Sender: TObject);

var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      TxtMazotcu.Text := Cari_KOD;
      Label19.Caption := Cari_AD;
  end;

end;

procedure TfrmRaporFatura_Sefer.TxtMazotcuExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(TxtMazotcu.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',TxtMazotcu.Text,CARI_AD) then
    begin
      Label19.Caption := CARI_AD;
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      TxtMazotcu.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    Label19.Caption := '';
  end;

end;

procedure TfrmRaporFatura_Sefer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporFatura_Sefer.Button1Click(Sender: TObject);
begin
     Close;
end;

procedure TfrmRaporFatura_Sefer.Btn_BulClick(Sender: TObject);
var
   ilk_sql:AnsiString;
   ilk_sql1:AnsiString;
   ilk_sql_w,ilk_sql_wO:AnsiString;

begin

     Button2.Enabled:=False;
     Button3.Enabled:=False;
     Button4.Enabled:=False;
          Button5.Enabled:=False;

   ilk_sql:=
'SELECT '+
'S.SEFER_ID '+
',S.SEFER_SID '+#13+
',S.ARAC_KOD '+
',(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ARAC_PLAKA '+
',S.DORSE_KOD '+
',(SELECT PLAKA FROM ARAC AR WHERE AR.ARAC_KOD=SEFER.DORSE_KOD) AS DARAC_PLAKA '+
',S.ALICI_KOD '+
',(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI '+
',S.SATICI_KOD '+
',(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD) AS SATICI_ADI '+
',S.PERSONEL_KOD '+
',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI '+
',S.ALICI_BORC_VPB '+
',S.SATICI_ALACAK_VPB '+


',S.SEFER_ALIS_FAT_ALINDI '+
',S.SEFER_SATIS_FAT_KESILDI '+
    ',S.BEKLEME_FAT_VAR '+
    ',S.BEKLEME_FAT_VPB  '+
    ',S.BEKLEME_FATURASI_KESILDI '+
    ',S.SBEKLEME_FAT_VAR '+
    ',S.SBEKLEME_FAT_VPB '+
    ',S.SBEKLEME_FATURASI_KESILDI  '+
    ',S.SEFER_SAY '+

',FAT_IRS.FAT_IRS_SERI '+
',FAT_IRS.BELGE_NO '+
',FAT_IRS.FAT_IRS_ID '+
',FAT_IRS.GENEL_TOP '+
',FAT_IRS.FAT_IRS_TIP '+
',FAT_IRS.FAT_IRS_SID '+
',FAT_IRS.FAT_IRS_SEP '+
',URUNHAR.URUNHAR_ID '+
'FROM SEFER S ';



ilk_sql_wO:=' ORDER BY FAT_IRS.FAT_IRS_SERI, FAT_IRS.BELGE_NO, FAT_IRS.FAT_IRS_ID ';

   if Trim(TxtMazotcu.Text)<>'' then
   begin
       ilk_sql_w:=
       ' WHERE FAT_IRS.CARI_KOD='+Sql_Katar(Trim(TxtMazotcu.Text))+' ';
//   ' ORDER BY FAT_IRS.FAT_IRS_SERI, FAT_IRS.BELGE_NO, FAT_IRS.FAT_IRS_ID ';
   end;


   qrySefer.Active:=False;
   qrySefer.Sql.Clear;
   qrySefer.Sql.Text:=ilk_sql;

   if Rg_Fatura_Tipi.ItemIndex=0 then
   begin
     qrySefer.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.ALIS_URUN_HAR_ID) ');
     qrySefer.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
     qrySefer.Sql.Add(ilk_sql_w+ilk_sql_wO);
   end;

   if Rg_Fatura_Tipi.ItemIndex=1 then
   begin
     qrySefer.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.SATIS_URUN_HAR_ID) ');
     qrySefer.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
     qrySefer.Sql.Add(ilk_sql_w+ilk_sql_wO);
   end;

   if Rg_Fatura_Tipi.ItemIndex=2 then
   begin
     qrySefer.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.BEK_FAT_URUN_HAR_ID) ');
     qrySefer.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
     qrySefer.Sql.Add(ilk_sql_w+ilk_sql_wO);
   end;

   if Rg_Fatura_Tipi.ItemIndex=3 then
   begin
     qrySefer.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.SBEK_FAT_URUN_HAR_ID) ');
     qrySefer.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
     qrySefer.Sql.Add(ilk_sql_w+ilk_sql_wO);
   end;

  {
   if Rg_Fatura_Tipi.ItemIndex=3 then
   begin
      qrySefer.Sql.Text:=ilk_sql+
      ' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.ALIS_URUN_HAR_ID) '+
      ' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) '+#13+
      ilk_sql_w+#13+
      ' UNION ALL ';
      qrySefer.Sql.Text:=qrySefer.Sql.Text+ilk_sql+
      ' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.SATIS_URUN_HAR_ID) '+
      ' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) '+#13+
      ilk_sql_w+#13+
      ' UNION ALL ';
      qrySefer.Sql.Text:=qrySefer.Sql.Text+ilk_sql+
      ' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.BEK_FAT_URUN_HAR_ID) '+
      ' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) '+
      ilk_sql_w ;
   end;
   }
   qrySefer.Active:=True;

   if qrySefer.RecordCount>0 then
   begin
     Button2.Enabled:=True;
     Button3.Enabled:=True;
     Button4.Enabled:=True;
          Button5.Enabled:=True;
   end;

end;

procedure TfrmRaporFatura_Sefer.Button2Click(Sender: TObject);
begin
  {if qrySefer.FieldByName('FAT_IRS_ID').AsInteger>0 then
  frmFAT_IRS.Form_Open(True,
  qrySefer.FieldByName('FAT_IRS_SEP').AsInteger,
  qrySefer.FieldByName('FAT_IRS_ID').AsInteger,
  qrySefer.FieldByName('FAT_IRS_SID').AsInteger,
  1,
  qrySefer.FieldByName('FAT_IRS_TIP').AsInteger);
  }
  if qrySefer.FieldByName('FAT_IRS_ID').AsInteger>0 then
  frmFAT_Tran.Form_Open(True,
  qrySefer.FieldByName('FAT_IRS_SEP').AsInteger,
  qrySefer.FieldByName('FAT_IRS_ID').AsInteger,
  qrySefer.FieldByName('FAT_IRS_SID').AsInteger,
  1,
  qrySefer.FieldByName('FAT_IRS_TIP').AsInteger);

end;

procedure TfrmRaporFatura_Sefer.Button3Click(Sender: TObject);
begin
  if qrySefer.FieldByName('SEFER_ID').AsInteger>0 then
  frmSefer.Form_Open(True,qrySefer.FieldByName('SEFER_ID').AsInteger,qrySefer.FieldByName('SEFER_SID').AsInteger,1);
end;

procedure TfrmRaporFatura_Sefer.TxtMazotcuEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporFatura_Sefer.Button4Click(Sender: TObject);
var
  strSQL,ilk_sql,ilk_sql1,ilk_sql_w:String;

begin
        IB_Query1.Active:=False;

  ilk_sql :=
  ' SELECT K.SEFER_ID '+#13+
  '      , K.SEFER_SID '+#13+
  '      , K.SEFER_SAY '+#13+
  '      , K.ARAC_KOD '+#13+
  '      ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ARAC_PLAKA '+#13+
  '      , K.ALICI_KOD '+#13+
  '      ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI '+#13+
  '      , K.SATICI_KOD '+#13+
  '      ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD) AS SATICI_ADI '+#13+
  '      , K.PERSONEL_KOD '+#13+
  '      ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI '+#13+
  '      , K.OLCU_TIP '+#13+
  '      , K.OLCU_BIRIM '+#13+
  '      , K.TASINAN_ESYA '+#13+
  '      , K.BAS_TAR '+#13+
  '      , K.BIT_TAR '+#13+
  '      , K.CIK_YER '+#13+
  '      , K.BIT_YER '+#13+
  '      , K.ALICI_BORC_BIRIM_FIY '+#13+
  '      , K.ALICI_B_DOVKOD '+#13+
  '      , K.ALICI_BORC '+#13+
  '      , K.ALICI_BORC_VPB '+#13+
  '      , K.SATICI_ALACAK_BIRIM_FIY '+#13+
  '      , K.SATICI_A_DOVKOD '+#13+
  '      , K.SATICI_ALACAK '+#13+
  '      , K.SATICI_ALACAK_VPB '+#13+
  '      , K.BEKLEME_FAT_VAR '+#13+
  '      , K.BEKLEME_FAT_TUTAR '+#13+
  '      , K.BEKLEME_FAT_DOV_KOD '+#13+
  '      , K.BEKLEME_FAT_VPB '+#13+
  '      , K.SEFER_NOTLARI '+#13+
  '      , K.SEFER_ALIS_FAT_ALINDI '+#13+
  '      , K.SEFER_SATIS_FAT_KESILDI '+#13+
  '      , K.MASRAF_MERK '+#13+
  '      , K.KOD1 '+#13+
  '      , K.KOD2 '+#13+
  '      , K.KOD3 '+#13+
  '      , K.KOD4 '+#13+
  '      , K.ALICI_B_DOV_BAZ_TAR '+#13+
  '      , K.SATICI_A_DOV_BAZ_TAR '+#13+
  '      , K.BEKLEME_FAT_DOV_BAZ_TAR '+#13+
  '      , K.ALICI_B_DOVKUR '+#13+
  '      , K.SATICI_A_DOVKUR '+#13+
  '      , K.BEKLEME_FAT_DOVKUR '+#13+
  '      , K.SEFER_TAMAMLANDI '+#13+
  '      , K.DORSE_KOD '+#13+
  '      , K.ALIS_URUN_HAR_ID '+#13+
  '      , K.SATIS_URUN_HAR_ID '+#13+
  '      , K.SECIM '+#13+
  '      , K.BEKLEME_FATURASI_KESILDI'+#13+
  '      , K.BEK_FAT_URUN_HAR_ID'+#13+
  '      , K.MIKTAR'+#13+
  '   , KONTEYNER_NO '+#13+
  '   , SBEKLEME_FAT_VPB '+#13+
  ' FROM SEFER K';




  ilk_sql1 :=
  ' SELECT K.SEFER_ID '+#13+
  '      , K.SEFER_SID '+#13+
  '      , K.SEFER_SAY '+#13+
  '      , K.ARAC_KOD '+#13+
  '      ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ARAC_PLAKA '+#13+
  '      , K.ALICI_KOD '+#13+
  '      ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI '+#13+
  '      , K.SATICI_KOD '+#13+
  '      ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD) AS SATICI_ADI '+#13+
  '      , K.PERSONEL_KOD '+#13+
  '      ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI '+#13+
  '      , K.OLCU_TIP '+#13+
  '      , K.OLCU_BIRIM '+#13+
  '      , K.TASINAN_ESYA '+#13+
  '      , K.BAS_TAR '+#13+
  '      , K.BIT_TAR '+#13+
  '      , K.CIK_YER '+#13+
  '      , K.BIT_YER '+#13+
  '      , K.ALICI_BORC_BIRIM_FIY '+#13+
  '      , K.ALICI_B_DOVKOD '+#13+
  '      , K.ALICI_BORC '+#13+
  '      , K.ALICI_BORC_VPB '+#13+
  '      , K.SATICI_ALACAK_BIRIM_FIY '+#13+
  '      , K.SATICI_A_DOVKOD '+#13+
  '      , K.SATICI_ALACAK '+#13+
  '      , K.SATICI_ALACAK_VPB '+#13+
  '      , K.BEKLEME_FAT_VAR '+#13+
  '      , K.BEKLEME_FAT_TUTAR '+#13+
  '      , K.BEKLEME_FAT_DOV_KOD '+#13+
  '      , K.BEKLEME_FAT_VPB '+#13+
  '      , K.SEFER_NOTLARI '+#13+
  '      , K.SEFER_ALIS_FAT_ALINDI '+#13+
  '      , K.SEFER_SATIS_FAT_KESILDI '+#13+
  '      , K.MASRAF_MERK '+#13+
  '      , K.KOD1 '+#13+
  '      , K.KOD2 '+#13+
  '      , K.KOD3 '+#13+
  '      , K.KOD4 '+#13+
  '      , K.ALICI_B_DOV_BAZ_TAR '+#13+
  '      , K.SATICI_A_DOV_BAZ_TAR '+#13+
  '      , K.BEKLEME_FAT_DOV_BAZ_TAR '+#13+
  '      , K.ALICI_B_DOVKUR '+#13+
  '      , K.SATICI_A_DOVKUR '+#13+
  '      , K.BEKLEME_FAT_DOVKUR '+#13+
  '      , K.SEFER_TAMAMLANDI '+#13+
  '      , K.DORSE_KOD '+#13+
  '      , K.ALIS_URUN_HAR_ID '+#13+
  '      , K.SATIS_URUN_HAR_ID '+#13+
  '      , K.SECIM '+#13+
  '      , K.BEKLEME_FATURASI_KESILDI'+#13+
  '      , K.BEK_FAT_URUN_HAR_ID'+#13+
  '      , K.MIKTAR'+#13+
  '   , KONTEYNER_NO '+#13+
  '   , SBEKLEME_FAT_VPB '+#13+

  ' FROM SEFER K';


    IB_Query1.SQl.Clear;

    IB_Query1.Sql.Add(ilk_sql);

  ilk_sql_w:=' where FAT_IRS.FAT_IRS_ID='+Inttostr(qrySefer.fieldbyname('FAT_IRS_ID').AsInteger)+#13;

     if Rg_Fatura_Tipi.ItemIndex=0 then
   begin
     IB_Query1.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.ALIS_URUN_HAR_ID) ');
     IB_Query1.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
     IB_Query1.Sql.Add(ilk_sql_w);
     IB_Query1.Sql.Add(' ORDER BY K.ALICI_KOD,K.BAS_TAR,K.SEFER_ID ');
   end;

   if Rg_Fatura_Tipi.ItemIndex=1 then
   begin
     IB_Query1.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.SATIS_URUN_HAR_ID) ');
     IB_Query1.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
     IB_Query1.Sql.Add(ilk_sql_w);
     IB_Query1.Sql.Add(' ORDER BY K.ALICI_KOD,K.BAS_TAR,K.SEFER_ID ');
   end;

   if Rg_Fatura_Tipi.ItemIndex=2 then
   begin
     IB_Query1.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.BEK_FAT_URUN_HAR_ID) ');
     IB_Query1.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
     IB_Query1.Sql.Add(ilk_sql_w);
     IB_Query1.Sql.Add(' ORDER BY K.ALICI_KOD,K.BAS_TAR,K.SEFER_ID ');
   end;

   if Rg_Fatura_Tipi.ItemIndex=3 then
   begin
     IB_Query1.Sql.Add(' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.SBEK_FAT_URUN_HAR_ID) ');
     IB_Query1.Sql.Add(' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) ');
     IB_Query1.Sql.Add(ilk_sql_w);
     IB_Query1.Sql.Add(' ORDER BY K.SATICI_KOD,K.BAS_TAR,K.SEFER_ID ');
   end;


{   if Rg_Fatura_Tipi.ItemIndex=3 then
   begin
      IB_Query1.Sql.Text:=ilk_sql+
      ' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.ALIS_URUN_HAR_ID) '+
      ' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) '+#13+
      ilk_sql_w+
						' ORDER BY K.ALICI_KOD,K.BAS_TAR,K.SEFER_ID '+
      ' UNION ALL ';
      IB_Query1.Sql.Text:=IB_Query1.Sql.Text+ilk_sql+
      ' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.SATIS_URUN_HAR_ID) '+
      ' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) '+#13+
      ilk_sql_w+
						' ORDER BY K.ALICI_KOD,K.BAS_TAR,K.SEFER_ID '+
      ' UNION ALL ';
      IB_Query1.Sql.Text:=IB_Query1.Sql.Text+ilk_sql+
      ' INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.BEK_FAT_URUN_HAR_ID) '+
      ' INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND FAT_IRS_SEP=1) '+
      ilk_sql_w +
      ' ORDER BY K.ALICI_KOD,K.BAS_TAR,K.SEFER_ID ';

   end;

 }



  try
    with IB_Query1 do
    begin
      Active := False;
      //SQL.Clear;
      //SQL.Add(strSQL);
      Active := True;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;


  if not IB_Query1.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  if IB_Query1.RecordCount = 0 then
  begin
    Application.MessageBox('Yapmýþ olduðunuz aramada hiçbir kayýda ulaþýlamadý.Lütfen kriterleri kontrol ediniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;


       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Sefer_listesi.fr3');
       frxReport1.showReport;
       Exit;



end;

procedure TfrmRaporFatura_Sefer.Button5Click(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
begin
  if not qrySefer.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  if qrySefer.RecordCount = 0 then
  begin
    Application.MessageBox('Yapmýþ olduðunuz aramada hiçbir kayýda ulaþýlamadý.Lütfen kriterleri kontrol ediniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  row := 0;
  col := 0;
////////////////////////////////////////////////////////////////////////////////
  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

    {res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      SetCellText(row,col,res_Cari[1]);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    }
    
    inc(row);
{    case prv_Fatura_Tip of
    1:SetCellText(row,col,'MÜÞTERÝ SÝPARÝÞLERÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
    2:SetCellText(row,col,'SATICI SÝPARÝÞLERÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
    end;
}
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    inc(row);
    col:=0;
    SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
{    if chkCARI.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Cari Kod : '+ lbl_CARIKOD.Caption+' - Cari Ad : '+lbl_CARI.Caption);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;

    if ((dtpIslemTar.Checked) and (dtpIslemTar2.Checked)) then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + (DateToStr(dtpIslemTar.Date)+' > - < '+DateToStr(dtpIslemTar2.Date)));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar2.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar2.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;
}
    inc(row);
    col := 0;
    SetCellText(row,col,'Sefer Id');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Plaka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Dorse Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Dorse Plaka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'Alýcý Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Alýcý Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Satýcý Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Satýcý Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Personel Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Adý Soyadý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'Alýcý Borc tutarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Satýcý Alacak Tutarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'Alýþ Faturasý Alýndý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'satýþ Faturasý Kesildi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Bekleme Faturasý Var');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Bekleme Fatura Tutarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Bekleme Faturasý Kesildi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'sBekleme Faturasý Var');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'sBekleme Fatura Tutarý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'sBekleme Faturasý Kesildi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


    inc(col);
    SetCellText(row,col,'Sefer Sayýsý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);



    inc(col);


    SetCellText(row,col,'Fatura Seri');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Fatura No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Fatura Id');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Toplam');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);





    inc(row);
    qrySefer.DisableControls;
    qrySefer.First;
    while not qrySefer.Eof do
    begin
      col := 0;


      SetCellText(row,col,qrySefer.FieldByName('SEFER_ID').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ARAC_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ARAC_PLAKA').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('DORSE_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('DARAC_PLAKA').AsString);

      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ALICI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ALICI_ADI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SATICI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SATICI_ADI').AsString);

      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('PERSONEL_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('PERSONEL_ADI').AsString);


      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ALICI_BORC_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SATICI_ALACAK_VPB').AsString);


      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_SATIS_FAT_KESILDI').AsString);


      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BEKLEME_FAT_VAR').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BEKLEME_FAT_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsString);



      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SBEKLEME_FAT_VAR').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SBEKLEME_FAT_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SBEKLEME_FATURASI_KESILDI').AsString);


      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_SAY').AsString);

      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('FAT_IRS_SERI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BELGE_NO').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('FAT_IRS_ID').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('GENEL_TOP').AsString);









      inc(row);
      qrySefer.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    col := 7;
//    SetCellText(row,col,'=SUM(H4:H'+IntToStr(row-1)+')');
//    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    format_ayarla(18,3,20,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
    grdA.EndUpdate;
    WindowState := wsMaximized;

  end;
end;

procedure TfrmRaporFatura_Sefer.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin
         res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);

       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(Date);



        //c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxComponent);
       //(c as TfrxMemoView).memo.Text:=DateToStr(dtpIslemTar2.Date);


       b:=(frxReport1.FindComponent('Memo_Rapor_Adi') as TfrxMemoView);
       //b.memo.Text:=DateToStr(dtpIslemTar1.Date);
           b.memo.Text:='FATURANIN SEFER BAÐLANTILARI LÝSTESÝ ';

      Prv_Yazdirildi:=True;
    end;





end;

end.




