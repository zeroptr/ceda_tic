unit ufrmRaporSefer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IB_Components, cxSSTypes, cxSSHeaders,
  DB, IBODataset, frxClass, frxDBSet, frxIBOSet;

type
  TfrmRaporSefer = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    chk_Sirket: TCheckBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label34: TLabel;
    Label36: TLabel;
    TxtMazotcu: TEdit;
    txtAlanCari: TEdit;
    txtArac: TEdit;
    Button6: TButton;
    Button7: TButton;
    Button9: TButton;
    Label19: TLabel;
    Label17: TLabel;
    LblPlaka: TLabel;
    qrySefer: TIB_Query;
    Label22: TLabel;
    txtAlanPers: TEdit;
    Button8: TButton;
    Label18: TLabel;
    frxReport1: TfrxReport;
    frxIBODataset1: TfrxIBODataset;
    Btn_Fast: TButton;
    Cb_Yeni_Sayfa: TCheckBox;
    TabSheet2: TTabSheet;
    lblISLEMMERKEZI: TLabel;
    txtISLEMMERKEZI: TEdit;
    btnISLEMMERKEZI: TButton;
    txtKOD1: TEdit;
    lblKOD1: TLabel;
    btnKOD1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure txtAracExit(Sender: TObject);
    procedure txtAlanCariExit(Sender: TObject);
    procedure TxtMazotcuExit(Sender: TObject);
    procedure txtAracKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure txtAlanPersExit(Sender: TObject);
    procedure txtAracEnter(Sender: TObject);
    procedure dtpIslemTar1Enter(Sender: TObject);
    procedure dtpIslemTar1Exit(Sender: TObject);
    procedure txtAracKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAlanPersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TxtMazotcuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAlanCariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure btnISLEMMERKEZIClick(Sender: TObject);
    procedure btnKOD1Click(Sender: TObject);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure txtKOD1Exit(Sender: TObject);
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtKOD1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtKOD1Enter(Sender: TObject);

  private
    Prv_Yazdirildi:Boolean;
    prv_Alici_Satici_Fatura:Integer;

    { Private declarations }

  public

    procedure Form_Open(Alici_Satici_Fatura:Integer);
    { Public declarations }

  end;

  const cns_Sefer = 36 ;

var
  frmRaporSefer: TfrmRaporSefer;

implementation

uses unDataMod, ufrmCariSDLG, ufrmRaporCiktisi,UnFunc, main;

{$R *.dfm}

procedure TfrmRaporSefer.Form_Open(Alici_Satici_Fatura:Integer);
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Sefer,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporSefer') then
    begin
      Application.CreateForm(TfrmRaporSefer, frmRaporSefer);
      frmRaporSefer.prv_Alici_Satici_Fatura:=Alici_Satici_Fatura;
      with frmRaporSefer do
      begin
         if prv_Alici_Satici_Fatura=1 then
         begin
                Label36.Visible:=False;
                TxtMazotcu.Visible:=False;
                Button7.Visible:=False;
                Label19.Visible:=False;

                Label22.Visible:=True;
                txtAlanPers.Visible:=True;
                Button8.Visible:=True;
                Label18.Visible:=True;
         end;

         if prv_Alici_Satici_Fatura=2 then
         begin
                Label36.Visible:=True;
                TxtMazotcu.Visible:=True;
                Button7.Visible:=True;
                Label19.Visible:=True;

                Label22.Visible:=False;
                txtAlanPers.Visible:=False;
                Button8.Visible:=False;
                Label18.Visible:=False;
         end;
      end;
    end;
  end;
end;


procedure TfrmRaporSefer.Button6Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      txtAlanCari.Text := Cari_KOD;
      Label17.Caption := Cari_AD;
  end;
end;

procedure TfrmRaporSefer.Button7Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      TxtMazotcu.Text := Cari_KOD;
      Label19.Caption := Cari_AD;
  end;
end;

procedure TfrmRaporSefer.Button9Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      txtArac.Text := ARAC_KOD;
      LblPlaka.Caption:= PLAKA;
  end;
end;

procedure TfrmRaporSefer.txtAracExit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 SATICI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
begin
  if Trim(txtArac.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PLAKA',txtArac.Text,PLAKA) then
    begin
      LblPlaka.Caption := PLAKA;
      {if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',txtArac.Text,OZ_MAL) then
      begin
      end;
      }
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtArac.SetFocus;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
    LblPlaka.Caption := '';
  end;
end;

procedure TfrmRaporSefer.txtAlanCariExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtAlanCari.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtAlanCari.Text,CARI_AD) then
    begin
      Label17.Caption := CARI_AD;
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtAlanCari.SetFocus;
    end;
  end
  else
  begin
    if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    Label17.Caption := '';
  end;
end;

procedure TfrmRaporSefer.TxtMazotcuExit(Sender: TObject);
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

procedure TfrmRaporSefer.txtAracKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporSefer.FormShow(Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;


procedure TfrmRaporSefer.btnRaporClick(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
  WhereEk:Boolean;
  strSQL,SubeID:String;
  Eski_Alici_Kod:String;
  Eski_Satici_Kod:String;
  Tutar1,Tutar2,Tutar3:Double;

  CHeader : TcxSSHeader;
  Say,Sayx:Integer;
  a:TfrxGroupHeader;//TfrxComponent;

  a1,b1,c1,d1,e1:TfrxMemoView;//TfrxComponent;


procedure Baslik_Ekle;
begin
   with frmRaporCiktisi Do
   begin
       inc(row);
       col := 0;
       SetCellText(row,col,'Sefer No');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
   //    inc(col);
   //    SetCellText(row,col,'Araç Kod');
   //    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Araç Plaka');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Baþlama Tarihi');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Bitiþ Tarihi');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Çýkýþ Yeri');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Varýþ Yeri');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Sefer Sayýsý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Taþýnan Eþya');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Miktarý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
   //    inc(col);
   //    SetCellText(row,col,'Ölçü Birimi');
   //    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Alýcý Borç tutarý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Satýcý Alacak Tutarý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);



   {

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
       SetCellText(row,col,'Sefer Notlarý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Bekleme Faturasý Var');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Bekleme Fatura Tutarý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Sefer Tamamlandý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Alýþ Faturasý Alýndý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Satýþ Faturasý Kesildi');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       inc(col);
       SetCellText(row,col,'Bekleme Faturasý Kesildi');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
   }

   end;
end;


begin
  WhereEk := False;
  strSQL :=
  ' SELECT SEFER_ID '+#13+
  '      , SEFER_SID '+#13+
  '      , SEFER_SAY '+#13+
  '      , ARAC_KOD '+#13+
  '      ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ARAC_PLAKA '+#13+
  '      , ALICI_KOD '+#13+
  '      ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI '+#13+
  '      , SATICI_KOD '+#13+
  '      ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD) AS SATICI_ADI '+#13+
  '      , PERSONEL_KOD '+#13+
  '      ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI '+#13+
  '      , OLCU_TIP '+#13+
  '      , OLCU_BIRIM '+#13+
  '      , TASINAN_ESYA '+#13+
  '      , BAS_TAR '+#13+
  '      , BIT_TAR '+#13+
  '      , CIK_YER '+#13+
  '      , BIT_YER '+#13+
  '      , ALICI_BORC_BIRIM_FIY '+#13+
  '      , ALICI_B_DOVKOD '+#13+
  '      , ALICI_BORC '+#13+
  '      , ALICI_BORC_VPB '+#13+
  '      , SATICI_ALACAK_BIRIM_FIY '+#13+
  '      , SATICI_A_DOVKOD '+#13+
  '      , SATICI_ALACAK '+#13+
  '      , SATICI_ALACAK_VPB '+#13+
  '      , BEKLEME_FAT_VAR '+#13+
  '      , BEKLEME_FAT_TUTAR '+#13+
  '      , BEKLEME_FAT_DOV_KOD '+#13+
  '      , BEKLEME_FAT_VPB '+#13+
  '      , SEFER_NOTLARI '+#13+
  '      , SEFER_ALIS_FAT_ALINDI '+#13+
  '      , SEFER_SATIS_FAT_KESILDI '+#13+
  '      , MASRAF_MERK '+#13+
  '      , KOD1 '+#13+
  '      , KOD2 '+#13+
  '      , KOD3 '+#13+
  '      , KOD4 '+#13+
  '      , ALICI_B_DOV_BAZ_TAR '+#13+
  '      , SATICI_A_DOV_BAZ_TAR '+#13+
  '      , BEKLEME_FAT_DOV_BAZ_TAR '+#13+
  '      , ALICI_B_DOVKUR '+#13+
  '      , SATICI_A_DOVKUR '+#13+
  '      , BEKLEME_FAT_DOVKUR '+#13+
  '      , SEFER_TAMAMLANDI '+#13+
  '      , DORSE_KOD '+#13+
  '      , ALIS_URUN_HAR_ID '+#13+
  '      , SATIS_URUN_HAR_ID '+#13+
  '      , SECIM '+#13+
  '      , BEKLEME_FATURASI_KESILDI'+#13+
  '      , BEK_FAT_URUN_HAR_ID'+#13+
  '      , KONTEYNER_NO'+#13+  
  '      , MIKTAR'+#13+
  ' , SBEKLEME_FAT_VAR'+#13+
  ' , SBEKLEME_FAT_TUTAR'+#13+
  ' , SBEKLEME_FAT_DOV_KOD'+#13+
  ' , SBEKLEME_FAT_VPB'+#13+
  ' , SBEKLEME_FAT_DOV_BAZ_TAR'+#13+
  ' , SBEKLEME_FAT_DOVKUR'+#13+
  ' , SBEKLEME_FATURASI_KESILDI'+#13+
  ' , SBEK_FAT_URUN_HAR_ID'+#13+

  ' FROM SEFER K';


  if WhereEk then
  begin
    strSQL := strSQL + ' AND K.BAS_TAR BETWEEN ' + SQL_Tarih(dtpIslemTar1.date) + ' AND ' + SQL_Tarih(dtpIslemTar2.date);
  end
  else
  begin
    strSQL := strSQL + ' WHERE K.BAS_TAR BETWEEN ' + SQL_Tarih(dtpIslemTar1.date) + ' AND ' + SQL_Tarih(dtpIslemTar2.date);
    WhereEk := True;
  end;


  if Trim(txtArac.Text) <> '' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.ARAC_KOD = '+ SQL_Katar(Trim(txtArac.Text));
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.ARAC_KOD = '+ SQL_Katar(Trim(txtArac.Text));
      WhereEk := True;
    end;
  end;


  if Trim(txtAlanCari.Text) <> '' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.ALICI_KOD = '+ SQL_Katar(Trim(txtAlanCari.Text));
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.ALICI_KOD = '+ SQL_Katar(Trim(txtAlanCari.Text));
      WhereEk := True;
    end;
  end;

  if Trim(TxtMazotcu.Text) <> '' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.SATICI_KOD = '+ SQL_Katar(Trim(TxtMazotcu.Text));
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.SATICI_KOD = '+ SQL_Katar(Trim(TxtMazotcu.Text));
      WhereEk := True;
    end;
  end;

  if Trim(txtAlanPers.Text) <> '' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.PERSONEL_KOD = '+ SQL_Katar(Trim(txtAlanPers.Text));
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.PERSONEL_KOD = '+ SQL_Katar(Trim(txtAlanPers.Text));
      WhereEk := True;
    end;
  end;

  if Trim(txtISLEMMERKEZI.Text) <> '' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.MASRAF_MERK = '+ SQL_Katar(Trim(txtISLEMMERKEZI.Text));
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.MASRAF_MERK = '+ SQL_Katar(Trim(txtISLEMMERKEZI.Text));
      WhereEk := True;
    end;
  end;


  if Trim(txtKOD1.Text) <> '' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.KOD1 = '+ SQL_Katar(Trim(txtKOD1.Text));
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.KOD1 = '+ SQL_Katar(Trim(txtKOD1.Text));
      WhereEk := True;
    end;
  end;

  if prv_Alici_Satici_Fatura=2 then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.SEFER_ALIS_FAT_ALINDI = 0 AND (SATICI_KOD <>'''')';
//      strSQL := strSQL + ' AND K.SEFER_ALIS_FAT_ALINDI = 0 ';
    end
    else
    begin
//      strSQL := strSQL + ' WHERE K.SEFER_ALIS_FAT_ALINDI = 0 ';
      strSQL := strSQL + ' WHERE K.SEFER_ALIS_FAT_ALINDI = 0  AND (SATICI_KOD <>'''')';
      WhereEk := True;
    end;
  end;

  if prv_Alici_Satici_Fatura=1 then
  begin
    if WhereEk then
    begin
      //strSQL := strSQL + ' AND K.SEFER_SATIS_FAT_KESILDI = 0 ';
      strSQL := strSQL + ' AND (K.SEFER_SATIS_FAT_KESILDI = 0 OR (BEKLEME_FATURASI_KESILDI=0 AND BEKLEME_FAT_VAR=1)) AND (ALICI_KOD <>'''')';
    end
    else
    begin
      //strSQL := strSQL + ' WHERE K.SEFER_SATIS_FAT_KESILDI = 0 ';
      strSQL := strSQL + ' WHERE (K.SEFER_SATIS_FAT_KESILDI = 0 OR (BEKLEME_FATURASI_KESILDI=0 AND BEKLEME_FAT_VAR=1)) AND (ALICI_KOD <>'''')';
      WhereEk := True;
    end;
  end;

   if prv_Alici_Satici_Fatura=0 then
  strSQL := strSQL + ' ORDER BY ALICI_KOD,BAS_TAR,SEFER_ID';

   if prv_Alici_Satici_Fatura=1 then
  strSQL := strSQL + ' ORDER BY ALICI_KOD,BAS_TAR,SEFER_ID';

   if prv_Alici_Satici_Fatura=2 then
  strSQL := strSQL + ' ORDER BY SATICI_KOD,BAS_TAR,SEFER_ID';


  try
    with qrySefer do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;

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
  if sender=Btn_Fast then
  begin
       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Sefer_listesi.fr3');

       if CheckBox1.Checked then
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Sefer_listesi_Alicisiz.fr3');

       if not CheckBox1.Checked then
       if CheckBox2.Checked then
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Sefer_listesi_Tek_Satir.fr3');

       if Cb_Yeni_Sayfa.Checked then
       begin
         a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
         a.StartNewPage:=True;
       end;

       if prv_Alici_Satici_Fatura=2 then
       begin
            a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
            a.Condition:='frxIBODataset1."SATICI_KOD"';

            d1:=(frxReport1.FindComponent('Memo30') as TfrxMemoView);
            d1.memo.Text:='Satýcý Kod';

            //e1:=(frxReport1.FindComponent('Memo28') as TfrxMemoView);
            (frxReport1.FindComponent('Memo30') as TfrxMemoView).DataField:='SATICI_KOD';
            (frxReport1.FindComponent('Memo31') as TfrxMemoView).Text:='Satýcý Adý';
            (frxReport1.FindComponent('Memo29') as TfrxMemoView).DataField:='SATICI_ADI';
       end;
       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;
  end;

  Eski_Alici_Kod:='';
  Eski_Satici_Kod:='';
  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    if chk_Sirket.Checked then
    begin
      res_Cari := TStringList.Create;
      if DataMod.FN_Sirket (res_Cari) then
      begin
        SetCellText(row,col,res_Cari[1]);
        SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      end;
      res_Cari.Free;
    end;

    inc(row);
    case prv_Alici_Satici_Fatura of
    0:
    begin
        SetCellText(row,col,'SEFER KAYITLARI LÝSTESÝ ');

        if TxtMazotcu.Text<>'' then
        SetCellText(row,col,TxtMazotcu.Text+' '+Label19.Caption + ' SEFER KAYITLARI LÝSTESÝ ');
    end;

    1:begin
       SetCellText(row,col,'ALICIYA FATURALANMAMIÞ SEFER KAYITLARI LÝSTESÝ ');
       if TxtMazotcu.Text<>'' then
       SetCellText(row,col,TxtMazotcu.Text+' '+Label19.Caption + ' ALICIYA FATURALANMAMIÞ SEFER KAYITLARI LÝSTESÝ');
    end;

    2:begin
       SetCellText(row,col,'SATICININ FATURALAMADIÐI SEFER KAYITLARI LÝSTESÝ ');
       {if TxtMazotcu.Text<>'' then
       SetCellText(row,col,TxtMazotcu.Text+' '+Label19.Caption + ' SATICININ FATURALAMADIÐI SEFER KAYITLARI LÝSTESÝ  ');
       }
    end;

    end;

    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    inc(row);
    col:=0;
    SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

   if (prv_Alici_Satici_Fatura=1) or (prv_Alici_Satici_Fatura=0) then
   begin
       inc(row);
       col := 0;
       SetCellText(row,col,'Alýcý Kod');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('ALICI_KOD').AsString);

       inc(col,2);
       SetCellText(row,col,'Alýcý Adý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('ALICI_ADI').AsString);
       Eski_Alici_Kod:=qrySefer.FieldByName('ALICI_KOD').AsString;
   end;

   if prv_Alici_Satici_Fatura=2 then
   begin
       inc(row);
       col := 0;
       SetCellText(row,col,'Satýcý Kod');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('SATICI_KOD').AsString);

       inc(col,2);
       SetCellText(row,col,'Satýcý Adý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('SATICI_ADI').AsString);
       Eski_Satici_Kod:=qrySefer.FieldByName('SATICI_KOD').AsString;
   end;

   Baslik_Ekle;
   inc(row);
   col := 0;
   qrySefer.DisableControls;
   qrySefer.First;

   Tutar1:=-1;
   Tutar2:=-1;
   Tutar3:=-1;
   Say:=0;
   Sayx:=0;

    while not qrySefer.Eof do
    begin
     if ((prv_Alici_Satici_Fatura=0) and (qrySefer.FieldByName('ALICI_KOD').AsString<>Eski_Alici_Kod))
     or ((prv_Alici_Satici_Fatura=1) and (qrySefer.FieldByName('ALICI_KOD').AsString<>Eski_Alici_Kod))
     or ((prv_Alici_Satici_Fatura=2) and (qrySefer.FieldByName('SATICI_KOD').AsString<>Eski_Satici_Kod))
      then
      begin
       //Inc(Row);
       Col:=8;

       SetCellText(row,col,'Ara Toplam');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,FloatTostr(Tutar1));
       SetCellText(row,col+2,FloatTostr(Tutar2));
       SetCellFont(col+1,row,col+1,row,[fsBold],8,'MS Sans Serif',4);
       SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',4);
       Tutar1:=0;
       Tutar2:=0;



      end;
      col:=0;


   if prv_Alici_Satici_Fatura=0 then
   begin
    if qrySefer.FieldByName('ALICI_KOD').AsString<>Eski_Alici_Kod Then
    begin


       inc(row);
       col := 0;
       SetCellText(row,col,'Alýcý Kod');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('ALICI_KOD').AsString);

       inc(col,2);
       SetCellText(row,col,'Alýcý Adý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('ALICI_ADI').AsString);

       Eski_Alici_Kod:=qrySefer.FieldByName('ALICI_KOD').AsString;

       Tutar3:=0;

       Baslik_Ekle;
       inc(row);
    end;
   end;


   if prv_Alici_Satici_Fatura=1 then
   begin
    if qrySefer.FieldByName('ALICI_KOD').AsString<>Eski_Alici_Kod Then
    begin
       inc(row);
       col := 0;
       SetCellText(row,col,'Alýcý Kod');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('ALICI_KOD').AsString);

       inc(col,2);
       SetCellText(row,col,'Alýcý Adý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('ALICI_ADI').AsString);

       Eski_Alici_Kod:=qrySefer.FieldByName('ALICI_KOD').AsString;
       Baslik_Ekle;
       inc(row);

    end;
   end;

   if prv_Alici_Satici_Fatura=2 then
   begin
    if qrySefer.FieldByName('SATICI_KOD').AsString<>Eski_Satici_Kod Then
    begin
       inc(row);
       col := 0;
       SetCellText(row,col,'Satýcý Kod');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

       SetCellText(row,col+1,qrySefer.FieldByName('SATICI_KOD').AsString);

       inc(col,2);
       SetCellText(row,col,'Satýcý Adý');
       SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
       SetCellText(row,col+1,qrySefer.FieldByName('SATICI_ADI').AsString);

       Eski_Satici_Kod:=qrySefer.FieldByName('SATICI_KOD').AsString;
       Baslik_Ekle;
       inc(row);


    end;
   end;


   Tutar1:=Tutar1+qrySefer.FieldByName('ALICI_BORC_VPB').AsFloat;
   Tutar2:=Tutar2+qrySefer.FieldByName('SATICI_ALACAK_VPB').AsFloat;


      col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,13);

      SetCellText(row,col,qrySefer.FieldByName('SEFER_ID').AsString);
//      inc(col);
//      SetCellText(row,col,qrySefer.FieldByName('ARAC_KOD').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ARAC_PLAKA').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BAS_TAR').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BIT_TAR').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('CIK_YER').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BIT_YER').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_SAY').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('TASINAN_ESYA').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('MIKTAR').AsString);
//      inc(col);
//      SetCellText(row,col,qrySefer.FieldByName('OLCU_BIRIM').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('ALICI_BORC_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SATICI_ALACAK_VPB').AsString);

{

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
      SetCellText(row,col,qrySefer.FieldByName('SEFER_SATIS_FAT_KESILDI').AsString);

      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BEKLEME_FAT_VPB').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_TAMAMLANDI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsString);
      inc(col);
      SetCellText(row,col,qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsString);

}

      inc(row);

      Inc(Say);
      Sayx:=Sayx+qrySefer.FieldByName('SEFER_SAY').AsInteger;

      qrySefer.Next;
    end;

    inc(Row);
    col:=4;
    SetCellText(row,col,'Toplam Satýr Sayýsý');
    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    SetCellText(row,col+2,InttoStr(Say));
    SetCellFont(col+2,row,col+2,row,[],8,'MS Sans Serif',2);

    inc(Row);
    col:=4;
    SetCellText(row,col,'Toplam Sefer Sayýsý');
    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    SetCellText(row,col+2,InttoStr(Sayx));
    SetCellFont(col+2,row,col+2,row,[],8,'MS Sans Serif',2);


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    col := 7;
//    SetCellText(row,col,'=SUM(H4:H'+IntToStr(row-1)+')');
//    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//    SetCellFormat(4,2,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
//    format_ayarla(7,3,7,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
      frmRaporCiktisi.format_ayarla(8,3,10,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
      frmRaporCiktisi.Rapor_Ayarlari(2);
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      CHeader.Size[7] := 150;

      CHeader.Size[5] := 150;
      CHeader.Size[4] := 150;
      
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  qrySefer.First;
  qrySefer.EnableControls;
end;

procedure TfrmRaporSefer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrySefer.Close;
  Action := caFree;
end;

procedure TfrmRaporSefer.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporSefer.Button8Click(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    txtAlanPers.Text:=PERSONEL_KOD;
    Label18.Caption:=PERSONEL_AD;
  end;
end;

procedure TfrmRaporSefer.txtAlanPersExit(Sender: TObject);
var
  PERSONEL_AD:String;
begin
  txtAlanPers.Color := clWindow;
  if Trim(txtAlanPers.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',txtAlanPers.Text,PERSONEL_AD) then
    begin
      Label18.Caption := PERSONEL_AD
    end
    else
    begin
      txtAlanPers.SetFocus;
    end
  end
  else
  begin
    Label18.Caption := '';
  end;
end;

procedure TfrmRaporSefer.txtAracEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSefer.dtpIslemTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSefer.dtpIslemTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporSefer.txtAracKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button9Click(Self);
end;

procedure TfrmRaporSefer.txtAlanPersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button8Click(Self);
end;

procedure TfrmRaporSefer.TxtMazotcuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button7Click(Self);
end;

procedure TfrmRaporSefer.txtAlanCariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button6Click(Self);
end;

procedure TfrmRaporSefer.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin
       if chk_Sirket.Checked then
       begin
         res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;
       end
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(dtpIslemTar2.Date);

       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);

        //c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxComponent);
       //(c as TfrxMemoView).memo.Text:=DateToStr(dtpIslemTar2.Date);


       b:=(frxReport1.FindComponent('Memo_Rapor_Adi') as TfrxMemoView);
       //b.memo.Text:=DateToStr(dtpIslemTar1.Date);

       case prv_Alici_Satici_Fatura of
       0:
       begin
           b.memo.Text:='SEFER KAYITLARI LÝSTESÝ ';
           if TxtMazotcu.Text<>'' then
           b.memo.Text:=TxtMazotcu.Text+' '+Label19.Caption + ' SEFER KAYITLARI LÝSTESÝ ';
       end;

       1:begin
          b.memo.Text:='ALICIYA FATURALANMAMIÞ SEFER KAYITLARI LÝSTESÝ ';
          if TxtMazotcu.Text<>'' then
          b.memo.Text:=TxtMazotcu.Text+' '+Label19.Caption + ' ALICIYA FATURALANMAMIÞ SEFER KAYITLARI LÝSTESÝ';
       end;

       2:begin
          b.memo.Text:='SATICININ FATURALAMADIÐI SEFER KAYITLARI LÝSTESÝ ';
       end
       end;

      Prv_Yazdirildi:=True;
    end;
end;

procedure TfrmRaporSefer.btnISLEMMERKEZIClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSefer.btnKOD1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSefer.txtISLEMMERKEZIExit(Sender: TObject);
begin
  if Trim(Self.txtISLEMMERKEZI.Text) = '' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtISLEMMERKEZI,0) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtISLEMMERKEZI.SetFocus;
  end;
end;

procedure TfrmRaporSefer.txtKOD1Exit(Sender: TObject);
begin
  if Trim(Self.txtKOD1.Text) = '' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD1,1) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD1.SetFocus;
  end;
end;

procedure TfrmRaporSefer.txtISLEMMERKEZIKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnISLEMMERKEZIClick(Self);
end;

procedure TfrmRaporSefer.txtKOD1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD1Click(Self);
end;

procedure TfrmRaporSefer.txtKOD1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

end.
