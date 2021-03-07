unit ufrmRaporMasrafHareket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  IB_Components, frxClass, frxIBOSet, cxSSTypes,cxSSHeaders;

type
  TfrmRaporMasrafHareket = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    txtMasrafKod: TEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    chk_Sirket: TCheckBox;
    chk_devir: TCheckBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryRapor: TIB_Cursor;
    qryToplam: TIB_Cursor;
    btn_Fast: TButton;
    frxIBODts_Masraf_Har: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure Rapor_Ciktisi_Open(strSQL:String);
    procedure DevirIcinToplamBul;
    procedure Alan_isimlerini_ekle;
    procedure ToplamBul;
    procedure yaz;
    procedure rapor_bitti;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtMasrafKodEnter(Sender: TObject);
    procedure txtMasrafKodExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure txtMasrafKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dtpIslemTar1Enter(Sender: TObject);
    procedure dtpIslemTar1Exit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure chk_devirEnter(Sender: TObject);
    procedure chk_devirExit(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btn_FastClick(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
  private
    { Private declarations }
    row,col:integer;
    genel_alacak,genel_borc:Currency;
    Prv_Yazdirildi:Boolean;
  public
    { Public declarations }
  end;
  const cns_masraf_hareket = 21;
var
  frmRaporMasrafHareket: TfrmRaporMasrafHareket;

implementation

{$R *.dfm}

uses unDataMod,ufrmRaporCiktisi,unFunc,main;

procedure TfrmRaporMasrafHareket.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if DataMod.Modul_Hak(cns_masraf_hareket,local_CanUpdate,local_CanDelete) = False then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporMasrafHareket') then
    begin
      Application.CreateForm(TfrmRaporMasrafHareket,frmRaporMasrafHareket);
      frmRaporMasrafHareket.dtpIslemTar1.Date := glb_DONEM_BAS;
      frmRaporMasrafHareket.dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporMasrafHareket.cmbSube.Items);
          with frmRaporMasrafHareket do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporMasrafHareket.cmbSube do
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
        frmRaporMasrafHareket.grpSube.Visible := False;
      end;//end else if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporMasrafHareket.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryRapor.Close;
  qryToplam.Close;
  Action := caFree;
end;

procedure TfrmRaporMasrafHareket.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporMasrafHareket.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporMasrafHareket);
end;

procedure TfrmRaporMasrafHareket.txtMasrafKodEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareket.txtMasrafKodExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmRaporMasrafHareket.Button1Click(Sender: TObject);
var
  KARSI_KOD : String;
begin
  if DataMod.LS_MASRAFTAN(KARSI_KOD) then
  begin
    txtMasrafKod.Text := KARSI_KOD;
  end;
end;


procedure TfrmRaporMasrafHareket.txtMasrafKodKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
  begin
    Button1Click(Self);
  end;
end;

procedure TfrmRaporMasrafHareket.dtpIslemTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareket.dtpIslemTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporMasrafHareket.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareket.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporMasrafHareket.chk_devirEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareket.chk_devirExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporMasrafHareket.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID : String;
begin
  if Trim(txtMasrafKod.Text) = '' then
  begin
    Application.MessageBox('Masraf kodu seçmeden rapor alamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  case frmRaporCiktisi.Tarih_Karsilastir(dtpIslemTar1.Date,dtpIslemTar2.Date) of
  2:
    begin
      Application.MessageBox('Ýkinci iþlem tarihi birinci tarihten küçük olamaz.Lütfen iþlem tarihlerini kontrol ediniz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;

  strSQL := 'SELECT MASRAFHAR.MASRAFHAR_ID,'
          + '       MASRAF_KOD,'
          + '       BA,'
          + '       MASRAFHAR.BELGE_TUR,'
          + '       BELGE_ID,'
          + '       BELGE_SID,'
          + '       SIRA_NO,'
          + '       TARIH,'
          + '       DOV_BAZ_TAR,'
          + '       DOVKOD,'
          + '       DOVKUR,'
          + '       TUTAR,'
          + '       TUTAR_VPB,'
          + '       ACIKLAMA'
          + ' FROM MASRAFHAR'
          + ' WHERE MASRAFHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)
          + ' AND MASRAFHAR.MASRAF_KOD = '+SQL_Katar(txtMasrafKod.Text);
  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      strSQL := strSQL + ' AND MASRAFHAR.MASRAFHAR_SID = '+ SubeID;
    end;
  end
  else
  begin
    strSQL := strSQL + ' AND MASRAFHAR.MASRAFHAR_SID = '+ inttostr(glb_SID);
  end;
  strSQL := strSQL + ' ORDER BY MASRAFHAR.TARIH,MASRAFHAR.MASRAFHAR_ID ASC';
  Rapor_Ciktisi_Open(strSQL);
end;

procedure TfrmRaporMasrafHareket.Rapor_Ciktisi_Open(strSQL:String);
var
  CHeader : TcxSSHeader;
begin
  with qryRapor do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((qryRapor.Eof) and (qryRapor.Bof)) then
  begin
    if chk_devir.Checked then
    begin
      frmRaporCiktisi.form_open();
      frmRaporCiktisi.grdA.BeginUpdate;

      DevirIcinToplamBul;

      frmRaporCiktisi.SetCellAlignment(0,2,0,2,haright,vaCenter);
      frmRaporCiktisi.SetCellAlignment(2,2,2,2,haright,vaCenter);
      frmRaporCiktisi.SetCellAlignment(5,2,8,2,haright,vaCenter);

      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      CHeader.Size[3] := 250;
      CHeader.Size[2] := 100;
      CHeader.Size[1] := 100;
      CHeader.Size[4] := 125;
      CHeader.Size[5] := 125;
      CHeader.Size[6] := 125;
      frmRaporCiktisi.grdA.EndUpdate;
      frmRaporCiktisi.WindowState := wsMaximized;
      qryRapor.Close;
      qryToplam.Close;
    end
    else
    begin
      Application.MessageBox('Seçtiðiniz koda ait hiçbir hareket kaydý bulunamadý.','Dikkat',MB_ICONWARNING);
    end;
    Exit;
  end
  else
  begin
    if chk_devir.Checked then
    begin
      ToplamBul;
    end;
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;

    frmRaporCiktisi.SetCellAlignment(0,2,0,2,haright,vaCenter);
    frmRaporCiktisi.SetCellAlignment(2,2,2,2,haright,vaCenter);
    frmRaporCiktisi.SetCellAlignment(5,2,8,2,haright,vaCenter);

    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[3] := 250;
    CHeader.Size[2] := 100;
    CHeader.Size[1] := 100;
    CHeader.Size[4] := 125;
    CHeader.Size[5] := 125;
    CHeader.Size[6] := 125;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
    qryToplam.Close;
  end;
end;

procedure TfrmRaporMasrafHareket.DevirIcinToplamBul;
var
  res_Cari : TStringList;
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
    inc(row);
    col := 0;
    res_Cari.Free;
  end;

  with qryToplam do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT ADI,MASRAF_KOD,DEVREDEN_BORC,DEVREDEN_ALACAK FROM MASRAF WHERE MASRAF_KOD = ' + SQL_Katar(txtMasrafKod.Text));
    Active := True;
  end;

  inc(row);
  frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('ADI').AsString);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,txtMasrafKod.Text);
  frmRaporCiktisi.SetCellFormat(row,col,row,col,1);
  frmRaporCiktisi.SetCellFont(row,col,row,col,[fsBold],8,'MS Sans Serif',2);
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
//  inc(row);
  Alan_isimlerini_ekle;
  inc(row,2);
  inc(col,3);
  frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
  inc(col);
  frmRaporCiktisi.format_ayarla(col,row,col,row);
  frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEVREDEN_BORC').AsString);
  inc(col);
  frmRaporCiktisi.format_ayarla(col,row,col,row);
  frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEVREDEN_ALACAK').AsString);
  if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency > qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
  begin
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'0');
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency - qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency));
  end;
  if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency < qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
  begin
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency - qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency));
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'0');
  end;
  if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency = qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
  begin
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'0');
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'0');
  end;
end;

procedure TfrmRaporMasrafHareket.Alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'TARÝH');
  frmRaporCiktisi.SetCellText(row,col+1,'BELGE TÜRÜ');
  frmRaporCiktisi.SetCellText(row,col+2,'FÝÞ NUMARASI');
  frmRaporCiktisi.SetCellText(row,col+3,'AÇIKLAMA');
  frmRaporCiktisi.SetCellText(row,col+4,'BORÇ');
  frmRaporCiktisi.SetCellText(row,col+5,'ALACAK');
  frmRaporCiktisi.SetCellText(row,col+6,'BORÇ BAKÝYESÝ');
  frmRaporCiktisi.SetCellText(row,col+7,'ALACAK BAKÝYESÝ');
  frmRaporCiktisi.SetCellFont(col,row,col+7,row,[fsBold],8,'MS Sans Serif',4);
end;

procedure TfrmRaporMasrafHareket.ToplamBul;
var
  SQLToplam,SubeID : String;
begin
  if frmRaporCiktisi.Tarih_Karsilastir(dtpIslemTar1.Date,glb_DONEM_BAS)=2 then
  begin
    with qryToplam do
    begin
      Active := false;
      SQL.Clear;
      SQLToplam := ' SELECT MASRAFHAR.BA,SUM(MASRAFHAR.TUTAR_VPB) AS TOPLAM FROM MASRAFHAR'
                 + ' WHERE MASRAFHAR.TARIH BETWEEN '+ SQL_Tarih(glb_DONEM_BAS) + ' AND ' + SQL_Tarih(frmRaporCiktisi.Date_PriorDay(dtpIslemTar1.Date)) + ' AND MASRAFHAR.MASRAF_KOD = ' + SQL_Katar(txtMasrafKod.Text);
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          SQLToplam := SQLToplam + ' AND MASRAFHAR.MASRAFHAR_SID = '+ SubeID;
        end;
      end
      else
      begin
        SQLToplam := SQLToplam + ' AND MASRAFHAR.MASRAFHAR_SID = '+ inttostr(glb_SID);
      end;
      SQLToplam := SQLToplam + ' GROUP BY MASRAFHAR.BA';
      SQL.Add(SQLToplam);
      Active := True;
    end;
///*************************************
    qryToplam.First;
    while not qryToplam.Eof do
    begin
      if qryToplam.FieldByName('BA').AsString = 'A' then
      begin
        genel_alacak := qryToplam.FieldByName('TOPLAM').AsCurrency;
      end;
      if qryToplam.FieldByName('BA').AsString = 'B' then
      begin
        genel_borc := qryToplam.FieldByName('TOPLAM').AsCurrency;
      end;
      qryToplam.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
    with qryToplam do
    begin
      if Active then Active := false;
      SQL.Clear;
      SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM MASRAF WHERE MASRAF_KOD = ' + SQL_Katar(txtMasrafKod.Text));
      Active := True;
      genel_alacak := genel_alacak + FieldByName('DEVREDEN_ALACAK').AsCurrency;
      genel_borc :=  genel_borc + FieldByName('DEVREDEN_BORC').AsCurrency;
      Active := False;
    end;
////////////////////////////////////////////////////////////////////////////////
  end
  else
  begin
    with qryToplam do
    begin
      if Active then Active := false;
      SQL.Clear;
      SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM MASRAF WHERE MASRAF_KOD = ' + SQL_Katar(txtMasrafKod.Text));
      Active := True;
      genel_alacak := FieldByName('DEVREDEN_ALACAK').AsCurrency;
      genel_borc := FieldByName('DEVREDEN_BORC').AsCurrency;
      Active := False;
    end;
  end;
end;

procedure TfrmRaporMasrafHareket.yaz;
var
  baslik_yazildi : Boolean;
  res_Cari : TStringList;
  SubeID,KARSI_AD : String;
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
    inc(row);
    col := 0;
  end;
  baslik_yazildi := false;
  qryRapor.First;
  while not (qryRapor.Eof) do
  begin
  //cari adý bakiyeli hareket dökümü açýklamasýný ve current date'i ekleyen kýsým
  //start
    if not baslik_yazildi then
    begin
      if DataMod.FN_KOD2AD('MASRAF','MASRAF_KOD','ADI',txtMasrafKod.Text,KARSI_AD) then
      begin
        frmRaporCiktisi.SetCellText(row,col,KARSI_AD);
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      end;
      inc(row);
      frmRaporCiktisi.SetCellText(row,col,txtMasrafKod.Text);
      frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      inc(row);
      frmRaporCiktisi.SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      inc(row);
      baslik_yazildi := true;
      //alan isimlerini ekleyen prosedür
      Alan_isimlerini_ekle;
      if chk_devir.Checked then
      begin
        inc(row,2);
        //qryToplam'dan elde edilen ve genel_borc ve genel_alacak deðiþkenlerine atýlan
        //deðerler burada karþýlaþtýrýlýyor ve gerekli deðerler atanýyor.
        inc(col,3);
        frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
        inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
       //burada qytoplam'dan alýnan genel_borc gride ekleniyor.
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        //stop
        inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);        //burada qrytoplam'dan alýnan genel_alacak gride ekleniyor.
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        //burada genel_alacak ve genel_borc deðiþkenleri karþýlaþtýrýlarak borç bakiyesi ve alacak bakiyesi
        //gride ekleniyor.
        if (genel_alacak > genel_borc) then
        begin
          //*******
          genel_alacak := genel_alacak - genel_borc;
          //*********
          genel_borc := 0;
          inc(col);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          inc(col);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        end;
        //burada genel_alacak ve genel_borc deðiþkenleri karþýlaþtýrýlarak borç bakiyesi ve alacak bakiyesi
        //gride ekleniyor.
        if (genel_alacak < genel_borc) then
        begin
          //start
          genel_borc := genel_borc - genel_alacak;
          genel_alacak := 0;
          //stop
          inc(col);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          //start
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          //stop
          inc(col);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          //start
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
          //stop
        end;
        //burada genel_alacak ve genel_borc deðiþkenleri karþýlaþtýrýlarak borç bakiyesi ve alacak bakiyesi
        //gride ekleniyor.
        if (genel_alacak = genel_borc) then
        begin
          genel_alacak := 0;
          genel_borc := 0;
          inc(col);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
          inc(col);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        end;
      end;//end chk_devir.checked
    end;
    col :=  0;
    inc(row);

    DataMod.Rapor_Satir_Renklendir(col,row,7);
    //////////////////////////////////////////////////////////////////////////////
    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TARIH').AsDate);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRapor.FieldByName('BELGE_TUR').AsInteger));
    case qryRapor.FieldByName('BELGE_TUR').AsInteger of
    14:
      begin
        with qryToplam do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT ISLEM_TIP,BELGE_ID FROM KASAHAR WHERE KASAHAR_ID = '+qryRapor.FieldByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND KASAHAR_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND KASAHAR_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;
        if qryToplam.FieldByName('ISLEM_TIP').AsInteger = 5 then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('BELGE_ID').AsString);
          qryToplam.Active := False;
        end
        else
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
          qryToplam.Active := False;
        end;
      end;
    17:
      begin
        with qryToplam do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT DEKONT_ID FROM DEKONT_D WHERE DEKONT_D.DEKONT_D_ID ='+qryRapor.FieldByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND DEKONT_D.DEKONT_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND DEKONT_D.DEKONT_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEKONT_ID').AsString);
        qryToplam.Active := False;
      end;
    else
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
      end;
    end;//end case
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    //inc(col);
    //frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_KOD').AsString);
    inc(col);
    if qryRapor.FieldByName('BA').AsString = 'B' then
    begin
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
      inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,'0');
      genel_borc := genel_borc + qryRapor.FieldByName('TUTAR_VPB').AsCurrency;
    end;
    if qryRapor.FieldByName('BA').AsString = 'A' then
    begin
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,'0');
      inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
      genel_alacak := genel_alacak + qryRapor.FieldByName('TUTAR_VPB').AsCurrency;
    end;
    if (genel_alacak > genel_borc) then
    begin
      genel_alacak := genel_alacak - genel_borc;
      genel_borc := 0;
      inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
    end;
    if (genel_alacak < genel_borc) then
    begin
      genel_borc := genel_borc - genel_alacak;
      genel_alacak := 0;
      inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
    end;
    if (genel_alacak = genel_borc) then
    begin
      genel_alacak := 0;
      genel_borc := 0;
      inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
    end;
    qryRapor.Next;
  end;
  rapor_bitti;
end;

procedure TfrmRaporMasrafHareket.rapor_bitti;
begin
  inc(row);
  col := 3;
  frmRaporCiktisi.SetCellText(row,col,'TOPLAM');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  inc(col);
  frmRaporCiktisi.format_ayarla(col,row,col,row);
  if (chk_devir.Checked and chk_Sirket.Checked) then
  begin
    frmRaporCiktisi.SetCellText(row,col,'=SUM(E6:E'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F6:F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  end
  else
  if (chk_devir.Checked or chk_Sirket.Checked) then
  begin
    frmRaporCiktisi.SetCellText(row,col,'=SUM(E5:E'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F5:F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  end
  else if not ((chk_devir.Checked and chk_Sirket.Checked)) then
  begin
    frmRaporCiktisi.SetCellText(row,col,'=SUM(E4:E'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F4:F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  end;
  inc(col);
  frmRaporCiktisi.format_ayarla(col,row,col,row);
  frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  inc(col);
  frmRaporCiktisi.format_ayarla(col,row,col,row);
  frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  genel_borc := 0;
  genel_alacak := 0;
end;

procedure TfrmRaporMasrafHareket.FormKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmRaporMasrafHareket.btn_FastClick(Sender: TObject);
var
   sqlstr:String;
begin

   if chk_devir.checked then
   begin
      sqlstr:=
      'SELECT '+
      'CAST(''01.01.2007'' AS DATE) TARIH, '+
      'CAST(0 AS INTEGER) MASRAFHAR_ID, '+
      'CAST('''' AS VARCHAR(15)) MASRAF_KOD, '+
      'CAST('''' AS CHAR(1)) BA, '+
      'CAST(0 AS INTEGER) BELGE_TUR, '+
      'CAST(0 AS INTEGER) BELGE_ID, '+
      'CAST(0 AS INTEGER) BELGE_SID, '+
      'CAST(0 AS smallint) SIRA_NO, '+
      'CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR, '+
      'CAST('''' AS VARCHAR(5)) DOVKOD, '+
      'CAST(0 AS NUMERIC(15,4)) DOVKUR, '+
      'CAST(0 AS NUMERIC(15,4)) TUTAR, '+
      'CAST(0 AS NUMERIC(15,4)) TUTAR_VPB, '+
      'CAST(''DEVÝR'' AS VARCHAR(50)) ACIKLAMA, '+
      'MASRAF.DEVREDEN_BORC CBorc, '+
      'MASRAF.DEVREDEN_ALACAK CAlacak '+
      'FROM MASRAF '+
      ' WHERE MASRAF.MASRAF_KOD = '+SQL_Katar(txtMasrafKod.Text)+' '+

      'union  '+
      'SELECT '+
      'CAST(''01.01.2007'' AS DATE) TARIH, '+
      'CAST(0 AS INTEGER) MASRAFHAR_ID, '+
      'CAST('''' AS VARCHAR(15)) MASRAF_KOD, '+
      'CAST('''' AS CHAR(1)) BA, '+
      'CAST(0 AS INTEGER) BELGE_TUR, '+
      'CAST(0 AS INTEGER) BELGE_ID, '+
      'CAST(0 AS INTEGER) BELGE_SID, '+
      'CAST(0 AS smallint) SIRA_NO, '+
      'CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR, '+
      'CAST('''' AS VARCHAR(5)) DOVKOD, '+
      'CAST(0 AS NUMERIC(15,4)) DOVKUR, '+
      'CAST(0 AS NUMERIC(15,4)) TUTAR, '+
      'CAST(0 AS NUMERIC(15,4)) TUTAR_VPB, '+
      'CAST(''Önceki Tarihten Hesaplanan'' AS VARCHAR(50)) ACIKLAMA, '+
      '(SELECT SUM(TUTAR_VPB) FROM MASRAFHAR WHERE (MASRAFHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and MASRAFHAR.MASRAF_KOD=MASRAF.MASRAF_KOD and MASRAFHAR.BA=''B'') CBorc, '+
      '(SELECT SUM(TUTAR_VPB) FROM MASRAFHAR WHERE (MASRAFHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and MASRAFHAR.MASRAF_KOD=MASRAF.MASRAF_KOD and MASRAFHAR.BA=''A'') CAlacak '+
      ' FROM MASRAF '+
      ' WHERE MASRAF.MASRAF_KOD = '+SQL_Katar(txtMasrafKod.Text)+' '+

      'union  '+
      'SELECT '+
      'MASRAFHAR.TARIH, '+
      'MASRAFHAR.MASRAFHAR_ID, '+
      'MASRAFHAR.MASRAF_KOD, '+
      'MASRAFHAR.BA, '+
      'MASRAFHAR.BELGE_TUR, '+
      'MASRAFHAR.BELGE_ID, '+
      'MASRAFHAR.BELGE_SID, '+
      'MASRAFHAR.SIRA_NO, '+
      'MASRAFHAR.DOV_BAZ_TAR, '+
      'MASRAFHAR.DOVKOD, '+
      'MASRAFHAR.DOVKUR, '+
      'MASRAFHAR.TUTAR, '+
      'MASRAFHAR.TUTAR_VPB, '+
      'MASRAFHAR.ACIKLAMA '+
      ',(case when  MASRAFHAR.BA=''B'' then '+
      'MASRAFHAR.TUTAR_VPB else 0 end) CBorc '+
      ',(case when  MASRAFHAR.BA=''A'' then '+
      'MASRAFHAR.TUTAR_VPB else 0 end ) CAlacak '+
      'FROM MASRAFHAR '+
      ' WHERE (MASRAFHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+') '+
      ' AND MASRAFHAR.MASRAF_KOD = '+SQL_Katar(txtMasrafKod.Text)+' ';
   end
   else
   begin
      sqlstr:=
      'SELECT '+
      'MASRAFHAR.MASRAFHAR_ID, '+
      'MASRAFHAR.MASRAF_KOD, '+
      'MASRAFHAR.BA, '+
      'MASRAFHAR.BELGE_TUR, '+
      'MASRAFHAR.BELGE_ID, '+
      'MASRAFHAR.BELGE_SID, '+
      'MASRAFHAR.SIRA_NO, '+
      'MASRAFHAR.TARIH, '+
      'MASRAFHAR.DOV_BAZ_TAR, '+
      'MASRAFHAR.DOVKOD, '+
      'MASRAFHAR.DOVKUR, '+
      'MASRAFHAR.TUTAR, '+
      'MASRAFHAR.TUTAR_VPB, '+
      'MASRAFHAR.ACIKLAMA '+
      ',(case when  MASRAFHAR.BA=''B'' then '+
      'MASRAFHAR.TUTAR_VPB else 0 end) CBorc '+
      ',(case when  MASRAFHAR.BA=''A'' then '+
      'MASRAFHAR.TUTAR_VPB else 0 end ) CAlacak '+
      'FROM MASRAFHAR '+
      ' WHERE (MASRAFHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+') '+
      ' AND MASRAFHAR.MASRAF_KOD = '+SQL_Katar(txtMasrafKod.Text)+' '+
      ' ORDER BY MASRAFHAR.TARIH,MASRAFHAR.MASRAFHAR_ID ASC';
   end;

    with IB_Query1 do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add(sqlstr);
      Active := True;
    end;


    if ((IB_Query1.Eof) and (IB_Query1.bof))then
    begin
      Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý. Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
      IB_Query1.Close;
      Exit;
    end;

    Prv_Yazdirildi:=False;
    frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Masraf_Hareket.fr3');

   { if cmbGrup.itemindex=0 then
    begin
      a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
      a.Visible:=True;
      a.Height:=20;
    end
    else
      a.Height:=0;
   }
    //frxReport1.PrepareReport();
    frxReport1.showReport;
end;

procedure TfrmRaporMasrafHareket.frxReport1BeforePrint(
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
       {end;
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;}

       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
       c:=(frxReport1.FindComponent('Memo1') as TfrxMemoView);
       c.memo.Text:=txtMasrafKod.Text;

       {c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);}


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);


       Prv_Yazdirildi:=True;
    end;
end;

procedure TfrmRaporMasrafHareket.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
var
   SubeID:String;
begin
    if ARow.ByName('BELGE_TUR').AsInteger>0 then
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('BELGE_TUR').AsInteger);
    case ARow.ByName('BELGE_TUR').AsInteger of
    14:
      begin
        with qryToplam do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT ISLEM_TIP,BELGE_ID FROM KASAHAR WHERE KASAHAR_ID = '+ARow.ByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND KASAHAR_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND KASAHAR_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;
        if qryToplam.FieldByName('ISLEM_TIP').AsInteger = 5 then
        begin
          ARow.ByName('CALC_BELGE_ID').AsInteger :=qryToplam.FieldByName('BELGE_ID').AsInteger;
          qryToplam.Active := False;
        end
        else
        begin
          ARow.ByName('CALC_BELGE_ID').AsInteger :=ARow.ByName('BELGE_ID').AsInteger;
          qryToplam.Active := False;
        end;
      end;
    17:
      begin
        with qryToplam do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT DEKONT_ID FROM DEKONT_D WHERE DEKONT_D.DEKONT_D_ID ='+ARow.ByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND DEKONT_D.DEKONT_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND DEKONT_D.DEKONT_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;
          ARow.ByName('CALC_BELGE_ID').AsInteger :=qryToplam.FieldByName('DEKONT_ID').AsInteger;
        qryToplam.Active := False;
      end;
    else
      begin
          ARow.ByName('CALC_BELGE_ID').AsInteger :=ARow.ByName('BELGE_ID').AsInteger;
      end;
    end;//end case
end;

end.


{SELECT
MASRAFHAR.MASRAFHAR_ID,
MASRAFHAR.MASRAF_KOD,
MASRAFHAR.BA,
MASRAFHAR.BELGE_TUR,
MASRAFHAR.BELGE_ID,
MASRAFHAR.BELGE_SID,
MASRAFHAR.SIRA_NO,
MASRAFHAR.TARIH,
MASRAFHAR.DOV_BAZ_TAR,
MASRAFHAR.DOVKOD,
MASRAFHAR.DOVKUR,
MASRAFHAR.TUTAR,
MASRAFHAR.TUTAR_VPB,
MASRAFHAR.ACIKLAMA
,(case when  MASRAFHAR.BA='B' then
MASRAFHAR.TUTAR_VPB else 0 end) CBorc
,(case when  MASRAFHAR.BA='A' then
MASRAFHAR.TUTAR_VPB else 0 end ) CAlacak

FROM MASRAFHAR

union

SELECT
CAST(0 AS INTEGER) MASRAFHAR_ID,
CAST('' AS VARCHAR(15)) MASRAF_KOD,
CAST('' AS CHAR(1)) BA,
CAST(0 AS INTEGER) BELGE_TUR,
CAST(0 AS INTEGER) BELGE_ID,
CAST(0 AS INTEGER) BELGE_SID,
CAST(0 AS smallint) SIRA_NO,
CAST('01.01.2007' AS DATE) TARIH,
CAST('01.01.2007' AS DATE) DOV_BAZ_TAR,
CAST('''' AS VARCHAR(5)) DOVKOD,
CAST(0 AS NUMERIC(15,4)) DOVKUR,
CAST(0 AS NUMERIC(15,4)) TUTAR,
CAST(0 AS NUMERIC(15,4)) TUTAR_VPB,
CAST('' AS VARCHAR(50)) ACIKLAMA,
MASRAF.DEVREDEN_BORC CBorc,
MASRAF.DEVREDEN_ALACAK CAlacak

FROM MASRAF}
