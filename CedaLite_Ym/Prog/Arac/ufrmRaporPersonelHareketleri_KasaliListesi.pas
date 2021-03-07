unit ufrmRaporPersonelHareketleri_KasaliListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  frxClass,frxIBOSet,IB_Components,cxSSTypes,cxSSHeaders, Grids, IB_Grid;

type
  TfrmRaporPersonelHareketleri_KasaliListesi = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    cmb_sirala: TComboBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    txtProjeKod1: TEdit;
    Button1: TButton;
    txtProjeKod2: TEdit;
    Button2: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    qryRapor: TIB_Query;
    qryRaporH: TIB_Query;
    frxReport1: TfrxReport;
    frxIBODataset1: TfrxIBODataset;
    frxIBODataset2: TfrxIBODataset;
    Btn_Fast: TButton;
    IB_DataSource1: TIB_DataSource;
    IB_DataSource2: TIB_DataSource;
    Cb_Yeni_Sayfa: TCheckBox;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
    procedure alan_isimlerini_ekle;
    procedure yaz;
    procedure kod_cikis(kod : TEdit);
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure txtProjeKod1Exit(Sender: TObject);
    procedure txtProjeKod2Exit(Sender: TObject);
    procedure txtProjeKod1KeyPress(Sender: TObject; var Key: Char);
    procedure txtProjeKod1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure txtProjeKod2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtProjeKod1Enter(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    Prv_Yazdirildi:Boolean;
    row,col:integer;
    Gnl_Sef_Say:Integer;
    procedure alan_isimlerini_ekleH;
    procedure yazH;
    function Alt_Ac: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_Personel_listesi = 35 ;
var
  frmRaporPersonelHareketleri_KasaliListesi: TfrmRaporPersonelHareketleri_KasaliListesi;

implementation

uses unDataMod, unFunc, ufrmRaporCiktisi,main;

{$R *.dfm}


procedure TfrmRaporPersonelHareketleri_KasaliListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_personel_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporPersonelHareketleri_KasaliListesi') then
    begin
      Application.CreateForm(TfrmRaporPersonelHareketleri_KasaliListesi, frmRaporPersonelHareketleri_KasaliListesi);
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporPersonelHareketleri_KasaliListesi.cmbSube.Items);
          with frmRaporPersonelHareketleri_KasaliListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporPersonelHareketleri_KasaliListesi.cmbSube do
          begin
            Clear;
            Items.Add(DataMod.SubeID2Ad(False,glb_SID));
            ItemIndex := 0;
            Enabled := False;
          end;
        end;
      end
      else
      begin
        frmRaporPersonelHareketleri_KasaliListesi.grpSube.Visible := False;
        //frmRaporCariBakiyeliHareket.cmbSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.txtProjeKod1Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod1);
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.txtProjeKod2Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod2);
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.kod_cikis(kod : TEdit);
var
  Personel_Adi : String;
begin
  if Length(Trim(kod.Text))=0 then
  begin
    kod.Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',kod.Text,Personel_Adi) Then
  begin
    Application.MessageBox('Personel Kodu Bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;



procedure TfrmRaporPersonelHareketleri_KasaliListesi.txtProjeKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.txtProjeKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.txtProjeKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.Button1Click(Sender: TObject);
var
  PERSONEL_KOD,PERSONEL_ADI:String;
begin
  if DataMOd.LS_Personel(PERSONEL_KOD,PERSONEL_ADI) then
  begin
  txtProjeKod1.Text := PERSONEL_KOD;
  end;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.Button2Click(Sender: TObject);
var
  PERSONEL_KOD,PERSONEL_ADI:String;
begin
  if DataMOd.LS_Personel(PERSONEL_KOD,PERSONEL_ADI) then
  begin
  txtProjeKod2.Text := PERSONEL_KOD;
  end;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID:String;
  where_ek : Boolean;
begin
    Gnl_Sef_Say:=0;
  where_ek := false;
  strSQL :=

  'SELECT P.PERSONEL_KOD '+
  '     , P.ADI_SOYADI '+
  '     , P.SICIL_NO '+
  '     , P.SSK_NO '+
  '     , P.GIRIS_TARIH '+
  '     , P.CIKIC_TARIH '+
  '     , P.DOGUM_TARIH '+
  '     , P.DOGUM_YER '+
  '     , P.CINSIYET '+
  '     , P.TAHSIL '+
  '     , P.EVLI '+
  '     , P.GOREVI '+
  '     , P.VERGI_NO '+
  '     , P.VERGI_DAIRE '+
  '     , P.VERGI_KARNE_TARIH '+
  '     , P.TEL_NO '+
  '     , P.LISTEDEN_CIKAR '+
  '     , P.BORC '+
  '     , P.ALACAK '+
  //'     ,(SELECT PLAKA FROM ARAC WHERE ARAC.PERSONEL_KOD=PERSONEL.PERSONEL_KOD) AS ARAC_PLAKA '+
  '     , ARAC.PLAKA AS ARAC_PLAKA'+
  '     , ARAC.ARAC_KOD '+

  ' FROM PERSONEL P'+
  ' LEFT OUTER JOIN ARAC ON (ARAC.PERSONEL_KOD=PERSONEL.PERSONEL_KOD) ';

  if ((Length(Trim(txtProjeKod1.Text)) <> 0) and (Length(Trim(txtProjeKod2.Text))<>0)) then
  begin
    strSQL := strSQL + ' WHERE PERSONEL.PERSONEL_KOD BETWEEN ' + SQL_Katar(txtProjeKod1.Text) + ' AND ' + SQL_Katar(txtProjeKod2.Text);
    where_ek := true;
  end
  else
  if txtProjeKod1.Text<>'' then
  begin
    strSQL := strSQL + ' WHERE PERSONEL.PERSONEL_KOD = ' + SQL_Katar(txtProjeKod1.Text);
    where_ek := true;
  end;


  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      if where_ek then
      begin
        strSQL := strSQL + ' AND PERSONEL.PERSONEL_SID = ' + SubeID;
      end
      else
      begin
        strSQL := strSQL + ' WHERE PERSONEL.PERSONEL_SID = ' + SubeID;
      end;
    end
  end
  else

  begin
    if where_ek then
    begin
      strSQL := strSQL + ' AND PERSONEL.PERSONEL_SID = ' + inttostr(glb_SID);
    end
    else
    begin
      strSQL := strSQL + ' WHERE PERSONEL.PERSONEL_SID = ' + inttostr(glb_SID);
    end;
  end;

  case cmb_sirala.ItemIndex of
  0:
    begin
      strSQL := strSQL + ' ORDER BY PERSONEL.PERSONEL_KOD';
    end;
  1:
    begin
      strSQL := strSQL + ' ORDER BY PERSONEL.ADI_SOYADI';
    end;
  end;
  frmRaporCiktisi_Open(Sender,strSQL);
  strSQL := '';
end;


procedure TfrmRaporPersonelHareketleri_KasaliListesi.frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
var
  CHeader : TcxSSHeader;
  a:TfrxGroupHeader;//TfrxComponent;

begin
  with frmRaporPersonelHareketleri_KasaliListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporPersonelHareketleri_KasaliListesi.qryRapor.Eof) and (frmRaporPersonelHareketleri_KasaliListesi.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin

     if sender=Btn_Fast then
     begin
       qryRaporH.Close;
       qryRaporH.Sql.Clear;       
       qryRaporH.Sql.Add(
       ' SELECT SEFER_ID '+#13+
       ' , SEFER_SID '+#13+
       ' , SEFER_SAY '+#13+
       ' , ARAC_KOD '+#13+
       ' ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ARAC_PLAKA '+#13+
       ' , ALICI_KOD '+#13+
       ' ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI '+#13+
       ' , SATICI_KOD '+#13+
       ' ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD) AS SATICI_ADI '+#13+
       ' , PERSONEL_KOD '+#13+
       ' ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI '+#13+
       ' , OLCU_TIP '+#13+
       ' , OLCU_BIRIM '+#13+
       ' , TASINAN_ESYA '+#13+
       ' , BAS_TAR '+#13+
       ' , BIT_TAR '+#13+
       ' , CIK_YER '+#13+
       ' , BIT_YER '+#13+
       ' , ALICI_BORC_BIRIM_FIY '+#13+
       ' , ALICI_B_DOVKOD '+#13+
       ' , ALICI_BORC '+#13+
       ' , ALICI_BORC_VPB '+#13+
       ' , SATICI_ALACAK_BIRIM_FIY '+#13+
       ' , SATICI_A_DOVKOD '+#13+
       ' , SATICI_ALACAK '+#13+
       ' , SATICI_ALACAK_VPB '+#13+
       ' , BEKLEME_FAT_VAR '+#13+
       ' , BEKLEME_FAT_TUTAR '+#13+
       ' , BEKLEME_FAT_DOV_KOD '+#13+
       ' , BEKLEME_FAT_VPB '+#13+
       ' , SEFER_NOTLARI '+#13+
       ' , SEFER_ALIS_FAT_ALINDI '+#13+
       ' , SEFER_SATIS_FAT_KESILDI '+#13+
       ' , MASRAF_MERK '+#13+
       ' , KOD1 '+#13+
       ' , KOD2 '+#13+
       ' , KOD3 '+#13+
       ' , KOD4 '+#13+
       ' , ALICI_B_DOV_BAZ_TAR '+#13+
       ' , SATICI_A_DOV_BAZ_TAR '+#13+
       ' , BEKLEME_FAT_DOV_BAZ_TAR '+#13+
       ' , ALICI_B_DOVKUR '+#13+
       ' , SATICI_A_DOVKUR '+#13+
       ' , BEKLEME_FAT_DOVKUR '+#13+
       ' , SEFER_TAMAMLANDI '+#13+
       ' , DORSE_KOD '+#13+
       ' , ALIS_URUN_HAR_ID '+#13+
       ' , SATIS_URUN_HAR_ID '+#13+
       ' , SECIM '+#13+
       ' , BEKLEME_FATURASI_KESILDI '+#13+
       ' , BEK_FAT_URUN_HAR_ID '+#13+
       ' , MIKTAR '+#13+
       ' , FATURA_MIK_SEF '+#13+
       ' FROM SEFER K '+#13+
       ' WHERE SEFER_ID>0 ');


       //qryRaporH.Sql.Add(' WHERE K.PERSONEL_KOD=:PRM_PERSONEL_KOD ');
       qryRaporH.Sql.Add(' AND K.BAS_TAR BETWEEN ' + SQL_Tarih(dtpIslemTar1.date) + ' AND ' + SQL_Tarih(dtpIslemTar2.date) );
       qryRaporH.Sql.Add(' ORDER BY ARAC_KOD,BAS_TAR,BIT_TAR ');
       //qryRaporH.ParamByName('PRM_PERSONEL_KOD').AsString:=qryRapor.FieldByName('PERSONEL_KOD').AsString;
       qryRaporH.Open;
       Prv_Yazdirildi:=False;


       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Personel_Sefer.fr3');
       if Cb_Yeni_Sayfa.Checked then
       begin
         a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
         a.StartNewPage:=True;
       end;
       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;
     end;

    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;
    if chk_Sirket.Checked then
    begin
      frmRaporCiktisi.SetCellFont(0,2,19,2,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(4,2,5,2,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,19,1,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(4,1,5,1,haRight,vaCenter);
    end;

    Inc(Row);
    frmRaporCiktisi.SetCellText(row,3,'Gnl.Sefer Say. Top.');
    frmRaporCiktisi.SetCellFont(3,row,3,row,[fsBold],8,'MS Sans Serif',2);
    frmRaporCiktisi.SetCellText(row,4,Inttostr(Gnl_Sef_Say));
    frmRaporCiktisi.SetCellFont(4,row,4,row,[fsBold],8,'MS Sans Serif',2);

    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[2] := 200;
    CHeader.Size[3] := 200;

    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporPersonelHareketleri_KasaliListesi.yaz;
var
  res_Cari : TStringList;
  Deger:String;
begin
  row := 0;
  col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 1;
  end;
  frmRaporCiktisi.SetCellText(row,col+2,'PERSONEL HAREKETLERÝ LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+4,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+4,row,col+4,row,[fsBold],8,'MS Sans Serif',0);
  alan_isimlerini_ekle;
  qryRapor.First;
  while not qryRapor.Eof do
  begin
    col := 0;

    if not Alt_Ac then
    begin
      qryRapor.Next;
      Continue;
    end;

    inc(row);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PERSONEL_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADI_SOYADI').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SICIL_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SSK_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ARAC_PLAKA').AsString);

    frmRaporCiktisi.SetCellFont(0,row,col+4,row,[fsBold],8,'MS Sans Serif',0);

    //inc(row);
    YazH;
    inc(row);
    qryRapor.Next;
  end;
end;


procedure TfrmRaporPersonelHareketleri_KasaliListesi.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Personel Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Adý Soyadý');
  frmRaporCiktisi.SetCellText(row,col+2,'sicil No');
  frmRaporCiktisi.SetCellText(row,col+3,'SSK No');
  frmRaporCiktisi.SetCellText(row,col+4,'Araç Plaka');
  inc(row);
end;


function TfrmRaporPersonelHareketleri_KasaliListesi.Alt_Ac:Boolean;
begin
  Result:=False;

  qryRaporH.Close;
  qryRaporH.SQl.Text:=
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
  '      , MIKTAR'+#13+
  '      , FATURA_MIK_SEF'+#13+
  ' FROM SEFER K'+
  ' WHERE K.PERSONEL_KOD=:PRM_PERSONEL_KOD '+

  ' AND K.BAS_TAR BETWEEN ' + SQL_Tarih(dtpIslemTar1.date) + ' AND ' + SQL_Tarih(dtpIslemTar2.date)+

  ' ORDER BY ARAC_KOD,BAS_TAR,BIT_TAR ';

  qryRaporH.ParamByName('PRM_PERSONEL_KOD').AsString:=qryRapor.FieldByName('PERSONEL_KOD').AsString;
  qryRaporH.Open;

  if qryRaporH.FieldByName('SEFER_ID').AsInteger>0 then
  Result :=True;
  qryRaporH.First;

end;


procedure TfrmRaporPersonelHareketleri_KasaliListesi.yazH;
var
  res_Cari : TStringList;
  Deger:String;
  Sef_Say:Integer;
begin
  Sef_Say:=0;
  {
  row := 0;
  col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 1;
  end;
  frmRaporCiktisi.SetCellText(row,col+2,'ARAÇ LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  }
  alan_isimlerini_ekleH;



  while not qryRaporH.Eof do
  begin
    Inc(Row);
    col := 0;
    DataMod.Rapor_Satir_Renklendir(col,row,5);

    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('BAS_TAR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('BIT_TAR').AsString);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('CIK_YER').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('BIT_YER').AsString);
    inc(col);

    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('SEFER_SAY').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('SEFER_ID').AsString);
    Sef_Say:=Sef_Say+qryRaporH.FieldByName('SEFER_SAY').AsInteger;
    qryRaporH.Next;

  end;
  Inc(Row);
  frmRaporCiktisi.SetCellText(row,3,'Sefer Say. Top.');
  frmRaporCiktisi.SetCellFont(3,row,3,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,4,Inttostr(Sef_Say));
  frmRaporCiktisi.SetCellFont(4,row,4,row,[fsBold],8,'MS Sans Serif',2);

  Gnl_Sef_Say:=Gnl_Sef_Say+Sef_Say;
end;




procedure TfrmRaporPersonelHareketleri_KasaliListesi.alan_isimlerini_ekleH;
begin
  col := 0;
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Baþlangýç Tarihi');
  frmRaporCiktisi.SetCellText(row,col+1,'Bitiþ Tarihi');
  frmRaporCiktisi.SetCellText(row,col+2,'Çýkýþ Yeri');
  frmRaporCiktisi.SetCellText(row,col+3,'Varýþ Yeri');
  frmRaporCiktisi.SetCellText(row,col+4,'Sefer Sayýsý');
  frmRaporCiktisi.SetCellText(row,col+5,'Sefer Kodu');
  frmRaporCiktisi.SetCellFont(0,row,col+5,row,[fsBold],8,'MS Sans Serif',2);
//  inc(row);
end;


procedure TfrmRaporPersonelHareketleri_KasaliListesi.FormKeyPress(Sender: TObject;  var Key: Char);
begin
  if key = #27 then
  begin
    close;
  end;
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.txtProjeKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporPersonelHareketleri_KasaliListesi);
end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.FormShow(
  Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;

end;

procedure TfrmRaporPersonelHareketleri_KasaliListesi.frxReport1BeforePrint(
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
       Prv_Yazdirildi:=True;
    end;
end;

end.
