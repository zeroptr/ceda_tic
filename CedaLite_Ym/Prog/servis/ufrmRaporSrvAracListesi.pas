unit ufrmRaporSrvAracListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  IB_Components,frxClass, frxIBOSet,cxSSTypes,cxSSHeaders ;

type
  TfrmRaporSrvAracListesi = class(TForm)
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
    txtAracKod1: TEdit;
    Button1: TButton;
    txtAracKod2: TEdit;
    Button2: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    qryRapor: TIB_Query;
    frxReport1: TfrxReport;
    frxIBODts_Srv_Arac_Lis: TfrxIBODataset;
    Btn_Fast: TButton;
    grb1: TGroupBox;
    txtCariKod1: TEdit;
    txtCariKod2: TEdit;
    btnCariListe1: TButton;
    btnCariListe2: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
    procedure alan_isimlerini_ekle;
    procedure yaz;
    procedure kod_cikis(kod : TEdit);
    procedure kod_cikis1(kod: TEdit);
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure txtAracKod1Exit(Sender: TObject);
    procedure txtAracKod2Exit(Sender: TObject);
    procedure txtAracKod1KeyPress(Sender: TObject; var Key: Char);
    procedure txtAracKod1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure txtAracKod2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtAracKod1Enter(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure qryRaporCalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
    procedure btnCariListe1Click(Sender: TObject);
    procedure btnCariListe2Click(Sender: TObject);
    procedure txtCariKod1Exit(Sender: TObject);
    procedure txtCariKod2Exit(Sender: TObject);
    procedure txtCariKod1Enter(Sender: TObject);
    procedure txtCariKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtCariKod2KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
  private
    row,col:integer;
    Prv_Yazdirildi:Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_Arac_listesi = 34 ;
var
  frmRaporSrvAracListesi: TfrmRaporSrvAracListesi;

implementation

uses unDataMod, unFunc, ufrmRaporCiktisi,main, ufrmCariSDLG;

{$R *.dfm}


procedure TfrmRaporSrvAracListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Arac_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporAracListesi') then
    begin
      Application.CreateForm(TfrmRaporSrvAracListesi, frmRaporSrvAracListesi);
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporSrvAracListesi.cmbSube.Items);
          with frmRaporSrvAracListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporSrvAracListesi.cmbSube do
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
        frmRaporSrvAracListesi.grpSube.Visible := False;
        //frmRaporCariBakiyeliHareket.cmbSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporSrvAracListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporSrvAracListesi.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporSrvAracListesi.txtAracKod1Exit(Sender: TObject);
begin
  kod_cikis(txtAracKod1);
end;

procedure TfrmRaporSrvAracListesi.txtAracKod2Exit(Sender: TObject);
begin
  kod_cikis(txtAracKod2);
end;

procedure TfrmRaporSrvAracListesi.kod_cikis(kod : TEdit);
var
 ARAC_KOD:String;
begin
  if Length(Trim(kod.Text))=0 then
  begin
    kod.Color := clWindow;
    exit;
  end;

  if not DataMod.FN_KOD2AD('SRV_ARAC','ARAC_KOD','ARAC_KOD',kod.Text,ARAC_KOD) then
  begin
    Application.MessageBox('araç Kodu Bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;

procedure TfrmRaporSrvAracListesi.txtAracKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporSrvAracListesi.txtAracKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporSrvAracListesi.txtAracKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporSrvAracListesi.Button1Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 SASI_NO:String;
 MARKA_TIP:String;
begin
  if DataMod.LS_Arac_Srv(ARAC_KOD,PLAKA,CARI_KOD,SASI_NO,MARKA_TIP,'') Then
  begin
      txtAracKod1.Text := ARAC_KOD;
  end;
end;

procedure TfrmRaporSrvAracListesi.Button2Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 SASI_NO:String;
 MARKA_TIP:String;
begin
  if DataMod.LS_Arac_Srv(ARAC_KOD,PLAKA,CARI_KOD,SASI_NO,MARKA_TIP,'') Then
  begin
      txtAracKod2.Text := ARAC_KOD;
  end;
end;

procedure TfrmRaporSrvAracListesi.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID:String;
  where_ek : Boolean;
begin
  where_ek := false;

  strSQL :=
  'SELECT ARAC_KOD '+
  '     , ARAC_SID '+
  '     , PLAKA '+
  '     , CARI_KOD '+
  '     ,(SELECT CARI_AD FROM CARI WHERE SRV_ARAC.CARI_KOD=CARI.CARI_KOD) AS CARI_ADI '+
  '     ,(SELECT TEL_NO_1 FROM CARI WHERE SRV_ARAC.CARI_KOD=CARI.CARI_KOD) AS TELEFON1 '+
  '     ,(SELECT TEL_NO_2 FROM CARI WHERE SRV_ARAC.CARI_KOD=CARI.CARI_KOD) AS TELEFON2 '+
  '     , ACIKLAMA '+
  '     , AKTIF_DEGIL '+
  '     , TRF_SIG_GEC_TAR '+
  '     , KASKO_SIG_GEC_TAR '+
  '     , AS_ADISOYADI '+
  '     , AS_DOGUM_YERI '+
  '     , AS_NUFUS_IL '+
  '     , AS_NUFUS_ILCE '+
  '     , AS_DOGUM_TARIHI '+
  '     , AS_IKA_ADRES '+
  '     , AS_SERI_NO '+
  '     , AS_MUYANE_GECERLILIK_SUR '+
  '     , ARAC_MARKA '+
  '     , ARAC_MARKA_TIP '+
  '     , TRAFIK_CIKIS_TAR '+
  '     , MODEL_YILI '+
  '     , SON_ONARIM_KM '+
  '     , RADYO_TEYP '+
  '     , ALARM '+
  '     , SIGORTA_KOD '+
  '     ,(SELECT ADI FROM SRV_ARAC_SIGORTA WHERE SRV_ARAC.SIGORTA_KOD=SRV_ARAC_SIGORTA.SIGORTA_KOD) AS SIGORTA_ADI '+
  '     , BAYI_KOD '+
  '     ,(SELECT BAYI_ADI FROM SRV_ARAC_BAYI WHERE SRV_ARAC.BAYI_KOD=SRV_ARAC_BAYI.BAYI_KOD) AS BAYI_ADI '+
  '     , RADYO_KOD_NUM '+
  '     , LASTIK_EBADI '+
  '     , ANAHTAR_NUMARASI '+
  '     , NOTLAR '+
  '     , IL '+
  '     , ILCE '+
  '     , TESCIL_SIRA_NO '+
  '     , TESCIL_TARIHI '+
  '     , PLAKA_NO '+
  '     , MARKASI '+
  '     , MODELI '+
  '     , CINSI '+
  '     , ARAZI '+
  '     , TIPI '+
  '     , RENGI '+
  '     , MOTOR_NO '+
  '     , SASI_NO '+
  '     , RUHSAT_BILGILERI '+
  '     , SILINDIR_HACMI '+
  '     , MOTOR_GUCU '+
  '     , ISTIAP_HADDI '+
  '     , KISI '+
  '     , IMALATCI_YERLI '+
  '     , KULLANIM_TIPI '+
  '     , YAKIT_TIPI '+
  '     , YUK_TASIMA '+
  '     , ROMORK_TAKMA '+
  '     , TAKSIMETRE '+
  '     , TAKOMETRE '+
  '     , NET_AGIRLIK '+
  '     , KATAR_AGIRLIGI '+
  '     , ROMORK_ISTIAPHAD '+
  '     , MUYANE_GECERLILIK_SUR '+
  '     , ONAYLAYAN_SICIL '+
  '     , SERI_G_NO '+
  '     , BORC '+
  '     , ALACAK '+
  '     , DEVREDEN_BORC '+
  '     , DEVREDEN_ALACAK '+
  '     , RESIM '+
  '     , SON_ONARIM_TARIHI '+
  'FROM SRV_ARAC ';
  //'WHERE ARAC_KOD=:PRM_ARAC_KOD ';

  if ((Length(Trim(txtAracKod1.Text)) <> 0) and (Length(Trim(txtAracKod2.Text))<>0)) then
  begin
    strSQL := strSQL + ' WHERE SRV_ARAC.ARAC_KOD BETWEEN ' + SQL_Katar(txtAracKod1.Text) + ' AND ' + SQL_Katar(txtAracKod2.Text);
    where_ek := true;
  end
  else
  if txtAracKod1.Text<>'' then
  begin
    strSQL := strSQL + ' WHERE SRV_ARAC.ARAC_KOD = ' + SQL_Katar(txtAracKod1.Text);
    where_ek := true;
  end;

  if ((Length(Trim(txtCariKod1.Text)) <> 0) and (Length(Trim(txtCariKod2.Text))<>0)) then
  begin
    strSQL := strSQL + ' WHERE SRV_ARAC.CARI_KOD BETWEEN ' + SQL_Katar(txtCariKod1.Text) + ' AND ' + SQL_Katar(txtCariKod2.Text);
    where_ek := true;
  end
  else
  if txtCariKod1.Text<>'' then
  begin
    strSQL := strSQL + ' WHERE SRV_ARAC.CARI_KOD = ' + SQL_Katar(txtCariKod1.Text);
    where_ek := true;
  end;

  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      if where_ek then
      begin
        strSQL := strSQL + ' AND SRV_ARAC.ARAC_SID = ' + SubeID;
      end
      else
      begin
        strSQL := strSQL + ' WHERE SRV_ARAC.ARAC_SID = ' + SubeID;
      end;
    end
  end
  else
  begin
    if where_ek then
    begin
      strSQL := strSQL + ' AND SRV_ARAC.ARAC_SID = ' + inttostr(glb_SID);
    end
    else
    begin
      strSQL := strSQL + ' WHERE SRV_ARAC.ARAC_SID = ' + inttostr(glb_SID);
    end;
  end;

  case cmb_sirala.ItemIndex of
  0:
    begin
      strSQL := strSQL + ' ORDER BY SRV_ARAC.CARI_KOD,SRV_ARAC.ARAC_KOD';
    end;
  1:
    begin
      strSQL := strSQL + ' ORDER BY SRV_ARAC.CARI_KOD,SRV_ARAC.PLAKA';
    end;
  end;
  frmRaporCiktisi_Open(Sender,strSQL);
  strSQL := '';
end;


procedure TfrmRaporSrvAracListesi.frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
begin
  with frmRaporSrvAracListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporSrvAracListesi.qryRapor.Eof) and (frmRaporSrvAracListesi.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin

    if sender=Btn_Fast then
    begin

         Prv_Yazdirildi:=False;
         frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Srv_Arac_Listesi.fr3');

         {   if Cb_Yeni_Sayfa.Checked then
            begin
            a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
            a.StartNewPage:=True;
            end;
         }

         //frxReport1.PrepareReport();
         frxReport1.showReport;
         Exit;
    end;
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;
    if chk_Sirket.Checked then
    begin
      frmRaporCiktisi.SetCellFont(0,2,14,2,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(5,2,6,2,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,14,1,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(5,1,6,1,haRight,vaCenter);
    end;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporSrvAracListesi.yaz;
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
  frmRaporCiktisi.SetCellText(row,col+2,'ARAÇ LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  alan_isimlerini_ekle;
  qryRapor.First;
  while not qryRapor.Eof do
  begin
    {SELECT ARAC_KOD
     , PLAKA
     , ARAC_TIP
     , OZ_MAL
     , CARI_KOD
     ,(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KOD) AS CARI_ADI
     , ACIKLAMA
     , BORC
     , ALACAK
     , AKTIF_DEGIL
     , YAKIT_LITRE
     , TRF_SIG_GEC_TAR
     , KASKO_SIG_GEC_TAR
     , PERSONEL_KOD
     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=ARAC.PERSONEL_KOD) AS PERSONEL_ADI
     FROM ARAC
     WHERE ARAC_KOD=:PRM_ARAC_KOD}

    col := 0;
    DataMod.Rapor_Satir_Renklendir(col,row,14);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ARAC_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PLAKA').AsString);
    inc(col);


    if qryRapor.FieldByName('ARAC_TIP').AsString='0' then Deger:='Kamyon';
    if qryRapor.FieldByName('ARAC_TIP').AsString='1' then Deger:='Týr';
    if qryRapor.FieldByName('ARAC_TIP').AsString='2' then Deger:='Dorse';
    if qryRapor.FieldByName('ARAC_TIP').AsString='3' then Deger:='Binek';
    if qryRapor.FieldByName('ARAC_TIP').AsString='4' then Deger:='Diðer';

    frmRaporCiktisi.SetCellText(row,col,Deger);
    inc(col);
    if qryRapor.FieldByName('OZ_MAL').AsString='1' then Deger:='Öz Mal';
    if qryRapor.FieldByName('OZ_MAL').AsString='0' then Deger:='Öz Mal Deðil';

    frmRaporCiktisi.SetCellText(row,col,Deger);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_ADI').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PERSONEL_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PERSONEL_ADI').AsString);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
    frmRaporCiktisi.format_ayarla(col-1,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TRF_SIG_GEC_TAR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('KASKO_SIG_GEC_TAR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('YAKIT_LITRE').AsString);
    inc(col);

    if qryRapor.FieldByName('AKTIF_DEGIL').AsString='1' then Deger:='Aktif Deðil';
    if qryRapor.FieldByName('AKTIF_DEGIL').AsString='0' then Deger:='Aktif';

    frmRaporCiktisi.SetCellText(row,col,Deger);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    {
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
    if (qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR) then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
    if (qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR) then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
     }
    inc(row);
    qryRapor.Next;
  end;
end;


procedure TfrmRaporSrvAracListesi.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Araç Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Plaka');
  frmRaporCiktisi.SetCellText(row,col+2,'Araç Tipi');
  frmRaporCiktisi.SetCellText(row,col+3,'Öz Mal');
  frmRaporCiktisi.SetCellText(row,col+4,'Cari Kodu');
  frmRaporCiktisi.SetCellText(row,col+5,'Cari Adý');
  frmRaporCiktisi.SetCellText(row,col+6,'Personel Kodu');
  frmRaporCiktisi.SetCellText(row,col+7,'Personel Adý');
  frmRaporCiktisi.SetCellText(row,col+8,'Borc');
  frmRaporCiktisi.SetCellText(row,col+9,'Alacak');
  frmRaporCiktisi.SetCellText(row,col+10,'Trafik. Sig.Geç.Sür.');
  frmRaporCiktisi.SetCellText(row,col+11,'Kasko Sig.Geç.Sür.');
  frmRaporCiktisi.SetCellText(row,col+12,'Litre/Km Deðeri');
  frmRaporCiktisi.SetCellText(row,col+13,'Aktif Deðil');
  frmRaporCiktisi.SetCellText(row,col+14,'Açýklama');
  inc(row);
end;



procedure TfrmRaporSrvAracListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporSrvAracListesi.txtAracKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSrvAracListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSrvAracListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporSrvAracListesi.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSrvAracListesi.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporSrvAracListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporSrvAracListesi);
end;

procedure TfrmRaporSrvAracListesi.frxReport1BeforePrint(
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
       c.memo.Text:=DateToStr(Date);
       {d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
       } 
       Prv_Yazdirildi:=True;
    end;
end;

procedure TfrmRaporSrvAracListesi.qryRaporCalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
     {if ARow.ByName('ARAC_TIP').AsInteger=0 then
      ARow.ByName('CALC_TIPI').AsString :='Kamyon';
     if ARow.ByName('ARAC_TIP').AsInteger=1 then
      ARow.ByName('CALC_TIPI').AsString :='Týr';
     if ARow.ByName('ARAC_TIP').AsInteger=2 then
      ARow.ByName('CALC_TIPI').AsString :='Dorse';
     if ARow.ByName('ARAC_TIP').AsInteger=3 then
      ARow.ByName('CALC_TIPI').AsString :='Binek';
     if ARow.ByName('ARAC_TIP').AsInteger=4 then
      ARow.ByName('CALC_TIPI').AsString :='Diðer';

     if ARow.ByName('OZ_MAL').AsInteger=0 then
      ARow.ByName('CALC_OZMAL').AsString :='Öz Mal';
     if ARow.ByName('OZ_MAL').AsInteger=1 then
      ARow.ByName('CALC_OZMAL').AsString :='Kiralýk';
     }
end;

procedure TfrmRaporSrvAracListesi.btnCariListe1Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open (True,CARI_KOD,CARI_AD,1) Then txtCariKod1.Text := CARI_KOD;
end;

procedure TfrmRaporSrvAracListesi.btnCariListe2Click(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) Then txtCariKod2.Text := CARI_KOD;
end;


procedure TfrmRaporSrvAracListesi.kod_cikis1(kod : TEdit);
var
  Cari_Ad:String;
begin
  if Length(Trim(kod.Text))=0 then
  begin
    kod.Color := clWindow;
    exit;
  end;

  if not DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',kod.Text,Cari_Ad) then
  begin
    Application.MessageBox('Cari Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;

procedure TfrmRaporSrvAracListesi.txtCariKod1Exit(Sender: TObject);
begin
  kod_cikis1(txtCariKod1);
end;

procedure TfrmRaporSrvAracListesi.txtCariKod2Exit(Sender: TObject);
begin
  kod_cikis1(txtCariKod2);
end;

procedure TfrmRaporSrvAracListesi.txtCariKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSrvAracListesi.txtCariKod1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  CARI_KOD,CARI_AD:String;
begin
  if Key=VK_F4 Then
  begin
    if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) Then txtCariKod1.Text := CARI_KOD;
  end;
end;

procedure TfrmRaporSrvAracListesi.txtCariKod2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  CARI_KOD,CARI_AD:String;
begin
  if Key=VK_F4 Then
  begin
    if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) Then txtCariKod2.Text := CARI_KOD;
  end;
end;

end.
