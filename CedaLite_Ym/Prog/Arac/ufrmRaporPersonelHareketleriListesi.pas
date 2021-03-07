unit ufrmRaporPersonelHareketleriListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  IB_Components, frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporPersonelHareketleriListesi = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    cmb_sirala: TComboBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryRapor: TIB_Cursor;
    GroupBox1: TGroupBox;
    txtProjeKod1: TEdit;
    Button1: TButton;
    txtProjeKod2: TEdit;
    Button2: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    qryRaporH: TIB_Cursor;
    frxIBODts_Pers_Hark: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    Btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(strSQL : String);
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
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
  private
    row,col:integer;
    Prv_Yazdirildi:Boolean;
    procedure alan_isimlerini_ekleH;
    procedure yazH;
    function Alt_Ac: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_Personel_listesi = 35 ;
var
  frmRaporPersonelHareketleriListesi: TfrmRaporPersonelHareketleriListesi;

implementation

uses unDataMod, unFunc, ufrmRaporCiktisi,main;

{$R *.dfm}


procedure TfrmRaporPersonelHareketleriListesi.Form_Open();
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
    if not MainForm.FindChildFrm(Application,'frmRaporPersonelHareketleriListesi') then
    begin
      Application.CreateForm(TfrmRaporPersonelHareketleriListesi, frmRaporPersonelHareketleriListesi);
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporPersonelHareketleriListesi.cmbSube.Items);
          with frmRaporPersonelHareketleriListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporPersonelHareketleriListesi.cmbSube do
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
        frmRaporPersonelHareketleriListesi.grpSube.Visible := False;
        //frmRaporCariBakiyeliHareket.cmbSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporPersonelHareketleriListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporPersonelHareketleriListesi.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporPersonelHareketleriListesi.txtProjeKod1Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod1);
end;

procedure TfrmRaporPersonelHareketleriListesi.txtProjeKod2Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod2);
end;

procedure TfrmRaporPersonelHareketleriListesi.kod_cikis(kod : TEdit);
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

procedure TfrmRaporPersonelHareketleriListesi.txtProjeKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporPersonelHareketleriListesi.txtProjeKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporPersonelHareketleriListesi.txtProjeKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporPersonelHareketleriListesi.Button1Click(Sender: TObject);
var
  PERSONEL_KOD,PERSONEL_ADI:String;
begin
  if DataMOd.LS_Personel(PERSONEL_KOD,PERSONEL_ADI) then
  begin
  txtProjeKod1.Text := PERSONEL_KOD;
  end;
end;

procedure TfrmRaporPersonelHareketleriListesi.Button2Click(Sender: TObject);
var
  PERSONEL_KOD,PERSONEL_ADI:String;
begin
  if DataMOd.LS_Personel(PERSONEL_KOD,PERSONEL_ADI) then
  begin
  txtProjeKod2.Text := PERSONEL_KOD;
  end;
end;

procedure TfrmRaporPersonelHareketleriListesi.btnRaporClick(Sender: TObject);
var
  strSQL,wstrSQL,SubeID:String;
  where_ek : Boolean;
begin
  where_ek := false;
  strSQL :=

  'SELECT PERSONEL_KOD '+
  '     , ADI_SOYADI '+
  '     , SICIL_NO '+
  '     , SSK_NO '+
  '     , GIRIS_TARIH '+
  '     , CIKIC_TARIH '+
  '     , DOGUM_TARIH '+
  '     , DOGUM_YER '+
  '     , CINSIYET '+
  '     , TAHSIL '+
  '     , EVLI '+
  '     , GOREVI '+
  '     , VERGI_NO '+
  '     , VERGI_DAIRE '+
  '     , VERGI_KARNE_TARIH '+
  '     , TEL_NO '+
  '     , LISTEDEN_CIKAR '+
  '     , BORC '+
  '     , ALACAK '+
  ' FROM PERSONEL ';
  if ((Length(Trim(txtProjeKod1.Text)) <> 0) and (Length(Trim(txtProjeKod2.Text))<>0)) then
  begin
    wstrSQL := wstrSQL + ' WHERE PERSONEL.PERSONEL_KOD BETWEEN ' + SQL_Katar(txtProjeKod1.Text) + ' AND ' + SQL_Katar(txtProjeKod2.Text);
    where_ek := true;
  end
  else
  if txtProjeKod1.Text<>'' then
  begin
    wstrSQL := wstrSQL + ' WHERE PERSONEL.PERSONEL_KOD = ' + SQL_Katar(txtProjeKod1.Text);
    where_ek := true;
  end;

  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      if where_ek then
      begin
        wstrSQL := wstrSQL + ' AND PERSONEL.PERSONEL_SID = ' + SubeID;
      end
      else
      begin
        wstrSQL := wstrSQL + ' WHERE PERSONEL.PERSONEL_SID = ' + SubeID;
        where_ek := true;
      end;
    end
  end
  else
  begin
    if where_ek then
    begin
      wstrSQL := wstrSQL + ' AND PERSONEL.PERSONEL_SID = ' + inttostr(glb_SID);
    end
    else
    begin
      wstrSQL := wstrSQL + ' WHERE PERSONEL.PERSONEL_SID = ' + inttostr(glb_SID);
      where_ek := true;
    end;
  end;

  if sender=Btn_Fast then
  begin

     if where_ek then
     wstrSQL:= wstrSQL+' AND PERSONEL_HAR.TARIH BETWEEN '+Sql_Tarih(dtpIslemTar1.date)+' AND '+Sql_Tarih(dtpIslemTar2.date)+' '
     else
     wstrSQL:= wstrSQL+' WHERE PERSONEL_HAR.TARIH BETWEEN '+Sql_Tarih(dtpIslemTar1.date)+' AND '+Sql_Tarih(dtpIslemTar2.date)+' ';

  end;

  case cmb_sirala.ItemIndex of
  0:
    begin
      wstrSQL := wstrSQL + ' ORDER BY PERSONEL.PERSONEL_KOD';
    end;
  1:
    begin
      wstrSQL := wstrSQL + ' ORDER BY PERSONEL.ADI_SOYADI';
    end;
  end;







  if sender=Btn_Fast then
  begin



  with IB_Query1 do
  begin
    Active := false;
    sql.Clear;
    sql.Add(
    'SELECT PERSONEL.PERSONEL_KOD '+
    ', PERSONEL.ADI_SOYADI '+
    ', PERSONEL.SICIL_NO '+
    ', PERSONEL.SSK_NO '+
    ', PERSONEL.GIRIS_TARIH '+
    ', PERSONEL.CIKIC_TARIH '+
    ', PERSONEL.DOGUM_TARIH '+
    ', PERSONEL.CINSIYET '+
    ', PERSONEL.TAHSIL '+
    ', PERSONEL.EVLI '+
    ', PERSONEL.GOREVI '+
    ', PERSONEL.VERGI_NO '+
    ', PERSONEL.VERGI_DAIRE '+
    ', PERSONEL.VERGI_KARNE_TARIH '+
    ', PERSONEL.TEL_NO '+
    ', PERSONEL.LISTEDEN_CIKAR '+
    ', PERSONEL.BORC '+
    ', PERSONEL.ALACAK '+
    ',PERSONEL_HAR.PERSONELHAR_ID '+
    ',PERSONEL_HAR.PERSONELHAR_SID '+
    ',PERSONEL_HAR.PERSONEL_KOD '+
    ',PERSONEL_HAR.BA '+
    ',PERSONEL_HAR.TARIH '+
    ',PERSONEL_HAR.DOVKOD '+
    ',PERSONEL_HAR.DOVKUR '+
    ',PERSONEL_HAR.TUTAR '+
    ',PERSONEL_HAR.TUTAR_VPB '+
    ',PERSONEL_HAR.ACIKLAMA '+
    ',PERSONEL_HAR.BELGE_TUR '+
    ',PERSONEL_HAR.BELGE_ID '+
    ',PERSONEL_HAR.BELGE_SID '+
    ',PERSONEL_HAR.SIRA_NO '+
    ',PERSONEL_HAR.MASRAF_MERK '+
    ',PERSONEL_HAR.KOD1 '+
    ',PERSONEL_HAR.KOD2 '+
    ',PERSONEL_HAR.KOD3 '+
    ',PERSONEL_HAR.KOD4 '+
    ',(case when  ba=''B'' then '+
    'PERSONEL_HAR.TUTAR_VPB else 0 end) CBorc '+
    ',(case when  ba=''A'' then '+
    'PERSONEL_HAR.TUTAR_VPB else 0 end ) CAlacak '+
    ' FROM PERSONEL '+
    ' INNER JOIN PERSONEL_HAR ON (PERSONEL_HAR.PERSONEL_KOD=PERSONEL.PERSONEL_KOD) ');
    sql.Add(wstrSQL);
    Active := True;
  end;

  if ((IB_Query1.Eof) and (IB_Query1.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end;
       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Personel_Hareket.fr3');
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
  frmRaporCiktisi_Open(strSQL+wstrSQL);
  strSQL := '';
end;


procedure TfrmRaporPersonelHareketleriListesi.frmRaporCiktisi_Open(strSQL : String);
var
  CHeader : TcxSSHeader;
begin
  with frmRaporPersonelHareketleriListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporPersonelHareketleriListesi.qryRapor.Eof) and (frmRaporPersonelHareketleriListesi.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin
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
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      CHeader.Size[1] := 150;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporPersonelHareketleriListesi.yaz;
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
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
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

    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PERSONEL_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADI_SOYADI').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SICIL_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SSK_NO').AsString);


    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
    frmRaporCiktisi.format_ayarla(col-1,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('GIRIS_TARIH').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CIKIC_TARIH').AsString);

{    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOGUM_TARIH').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOGUM_YER').AsString);

    inc(col);
    if qryRapor.FieldByName('CINSIYET').AsString='E' then Deger:='Erkek';
    if qryRapor.FieldByName('CINSIYET').AsString='K' then Deger:='Kadýn';
    frmRaporCiktisi.SetCellText(row,col,Deger);

    inc(col);
    if qryRapor.FieldByName('TAHSIL').AsString='1' then Deger:='Ýlkokul';
    if qryRapor.FieldByName('TAHSIL').AsString='2' then Deger:='Ortaokul';
    if qryRapor.FieldByName('TAHSIL').AsString='3' then Deger:='Lise';
    if qryRapor.FieldByName('TAHSIL').AsString='4' then Deger:='Üniversite';
    if qryRapor.FieldByName('TAHSIL').AsString='5' then Deger:='Yok';
    frmRaporCiktisi.SetCellText(row,col,Deger);

    inc(col);
    if qryRapor.FieldByName('EVLI').AsString='E' then Deger:='Evli';
    if qryRapor.FieldByName('EVLI').AsString='B' then Deger:='Bekar';
    if qryRapor.FieldByName('EVLI').AsString='D' then Deger:='Dul';
    frmRaporCiktisi.SetCellText(row,col,Deger);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('GOREVI').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('VERGI_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('VERGI_DAIRE').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('VERGI_KARNE_TARIH').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TEL_NO').AsString);
    inc(col);
    if qryRapor.FieldByName('LISTEDEN_CIKAR').AsString='0' then Deger:='Hayýr';
    if qryRapor.FieldByName('LISTEDEN_CIKAR').AsString='1' then Deger:='Evet';

    frmRaporCiktisi.SetCellText(row,col,Deger);
}
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
    YazH;
    inc(row);
    qryRapor.Next;
  end;
end;


procedure TfrmRaporPersonelHareketleriListesi.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Personel Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Adý Soyadý');
  frmRaporCiktisi.SetCellText(row,col+2,'sicil No');
  frmRaporCiktisi.SetCellText(row,col+3,'SSK No');
  frmRaporCiktisi.SetCellText(row,col+4,'Borç');
  frmRaporCiktisi.SetCellText(row,col+5,'Alacak');
  frmRaporCiktisi.SetCellText(row,col+6,'Giriþ Tarihi');
  frmRaporCiktisi.SetCellText(row,col+7,'Çýkýþ Tarihi');
{  frmRaporCiktisi.SetCellText(row,col+8,'Doðum Tarihi');
  frmRaporCiktisi.SetCellText(row,col+9,'Doðum Yeri');
  frmRaporCiktisi.SetCellText(row,col+10,'Cinsiyeti');
  frmRaporCiktisi.SetCellText(row,col+11,'Tahsili');
  frmRaporCiktisi.SetCellText(row,col+12,'Medeni Durumu');
  frmRaporCiktisi.SetCellText(row,col+13,'Görevi');
  frmRaporCiktisi.SetCellText(row,col+14,'Vergi No');
  frmRaporCiktisi.SetCellText(row,col+15,'Vergi Dairesi');
  frmRaporCiktisi.SetCellText(row,col+16,'Vergi Karne Tarihi');
  frmRaporCiktisi.SetCellText(row,col+17,'Telefon No');
  frmRaporCiktisi.SetCellText(row,col+18,'Listeden Çýkart');
}
  inc(row);
end;



function TfrmRaporPersonelHareketleriListesi.Alt_Ac:Boolean;
begin
  Result:=False;
  qryRaporH.Close;
  qryRaporH.SQl.Text:=
  ' Select '+
  '    PERSONELHAR_ID '+
  '    ,PERSONELHAR_SID '+
  '    ,PERSONEL_KOD '+
  '    ,BA '+
  '    ,TARIH '+
  '    ,DOVKOD   '+
  '    ,DOVKUR '+
  '    ,TUTAR '+
  '    ,TUTAR_VPB '+
  '    ,ACIKLAMA '+
  '    ,BELGE_TUR '+
  '    ,BELGE_ID '+
  '    ,BELGE_SID '+
  '    ,SIRA_NO '+
  '    ,MASRAF_MERK '+
  '    ,KOD1 '+
  '    ,KOD2 '+
  '    ,KOD3 '+
  '    ,KOD4 '+
  '    from PERSONEL_HAR ' +
  ' WHERE PERSONEL_KOD=:PRM_PERSONEL_KOD '+

' AND PERSONEL_HAR.TARIH BETWEEN '+Sql_Tarih(dtpIslemTar1.date)+' AND '+Sql_Tarih(dtpIslemTar2.date);

  qryRaporH.ParamByName('PRM_PERSONEL_KOD').AsString:=qryRapor.FieldByName('PERSONEL_KOD').AsString;
  qryRaporH.Open;

  if qryRaporH.FieldByName('PERSONELHAR_ID').AsInteger>0 then
  Result :=True;
  qryRaporH.First;
end;


procedure TfrmRaporPersonelHareketleriListesi.yazH;
var
  res_Cari : TStringList;
  Deger:String;
begin
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

    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('TARIH').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('BELGE_ID').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRaporH.FieldByName('BELGE_TUR').AsInteger));
    inc(col);

    if qryRaporH.FieldByName('BA').AsString='B' then Deger:='Borç';
    if qryRaporH.FieldByName('BA').AsString='A' then Deger:='Alacak';

    frmRaporCiktisi.SetCellText(row,col,Deger);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('TUTAR_VPB').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('ACIKLAMA').AsString);
    qryRaporH.Next;
  end;
end;




procedure TfrmRaporPersonelHareketleriListesi.alan_isimlerini_ekleH;
begin
  col := 0;
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Tarih');
  frmRaporCiktisi.SetCellText(row,col+1,'Belge No');
  frmRaporCiktisi.SetCellText(row,col+2,'Belge Türü');
  frmRaporCiktisi.SetCellText(row,col+3,'Borç/Alacak');
  frmRaporCiktisi.SetCellText(row,col+4,'Tutar');
  frmRaporCiktisi.SetCellText(row,col+5,'Açýklama');
  frmRaporCiktisi.SetCellFont(0,row,col+5,row,[fsBold],8,'MS Sans Serif',2);
  inc(row);
end;


procedure TfrmRaporPersonelHareketleriListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporPersonelHareketleriListesi.txtProjeKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelHareketleriListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelHareketleriListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporPersonelHareketleriListesi.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelHareketleriListesi.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporPersonelHareketleriListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporPersonelHareketleriListesi);
end;

procedure TfrmRaporPersonelHareketleriListesi.FormShow(Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;

end;

procedure TfrmRaporPersonelHareketleriListesi.frxReport1BeforePrint(
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


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);


       Prv_Yazdirildi:=True;
    end;
end;

procedure TfrmRaporPersonelHareketleriListesi.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
     if ARow.ByName('BELGE_TUR').AsInteger>0 then
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('BELGE_TUR').AsInteger);
end;

end.

//if not isDigit(Key) then Key := toUpper(Key);
