{$INCLUDE directive.inc}

unit ufrmRaporSeferKasali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IB_Components, cxSSTypes, cxSSHeaders,Db,
  frxClass, frxIBOSet;

type
  TfrmRaporSeferKasali = class(TForm)
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
    IB_Query1: TIB_Query;
    TabSheet2: TTabSheet;
    lblISLEMMERKEZI: TLabel;
    txtISLEMMERKEZI: TEdit;
    btnISLEMMERKEZI: TButton;
    txtKOD1: TEdit;
    btnKOD1: TButton;
    lblKOD1: TLabel;
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
    procedure txtKOD1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);

  private
    Prv_Yazdirildi:Boolean;
    prv_Sirket_Kiralik:Integer;

    Memo_Toplam_Sefer:Double;
    Memo_Toplam_Ciro:Double;
    Memo_Kiralik_Ciro:Double;
    Memo_Kiralik_Odenen:Double;
    Memo_Kiralik_Kalan:Double;
    Memo_Ciro_Kalan:Double;

    Ton_Miktar:Double;
    K20lik_Miktar:Double;
    K40lik_Miktar:Double;
    
    procedure Where_Ekle(Tipi: Integer; var strSQL: String);
    { Private declarations }

  public

    procedure Form_Open(Sirket_Kiralik:Integer);
    { Public declarations }
  end;

  const cns_Sefer = 36 ;

var
  frmRaporSeferKasali: TfrmRaporSeferKasali;

implementation

uses unDataMod, ufrmCariSDLG, ufrmRaporCiktisi,UnFunc, main;

{$R *.dfm}

procedure TfrmRaporSeferKasali.Form_Open(Sirket_Kiralik:Integer);
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
      Application.CreateForm(TfrmRaporSeferKasali, frmRaporSeferKasali);
      frmRaporSeferKasali.prv_Sirket_Kiralik:=Sirket_Kiralik;
      with frmRaporSeferKasali do
      begin
        if prv_Sirket_Kiralik=1 then
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

        if prv_Sirket_Kiralik=2 then
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
        if prv_Sirket_Kiralik=4 then
        btnRapor.Visible:=False;


      end;
    end;
  end;
end;


procedure TfrmRaporSeferKasali.Button6Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      txtAlanCari.Text := Cari_KOD;
      Label17.Caption := Cari_AD;
  end;
end;

procedure TfrmRaporSeferKasali.Button7Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      TxtMazotcu.Text := Cari_KOD;
      Label19.Caption := Cari_AD;
  end;
end;

procedure TfrmRaporSeferKasali.Button9Click(Sender: TObject);
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

procedure TfrmRaporSeferKasali.txtAracExit(Sender: TObject);
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

procedure TfrmRaporSeferKasali.txtAlanCariExit(Sender: TObject);
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

procedure TfrmRaporSeferKasali.TxtMazotcuExit(Sender: TObject);
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

procedure TfrmRaporSeferKasali.txtAracKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporSeferKasali.FormShow(Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;



procedure  TfrmRaporSeferKasali.Where_Ekle(Tipi:Integer;var strSQL:String);
var
WhereEk:Boolean;
begin
  WhereEk := False;
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


  if Tipi=1 then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.SATICI_KOD='''' ';
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.SATICI_KOD='''' ';
      WhereEk := True;
    end;
  end;


  if Tipi=2 then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.PERSONEL_KOD=''''';
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.PERSONEL_KOD=''''';
      WhereEk := True;
    end;
  end;

end;


procedure TfrmRaporSeferKasali.btnRaporClick(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
  WhereEk:Boolean;
  strSQL,SubeID:String;
  Sefer_Say:Integer;
  Alici_Tutar,Kiralik_Tutar:Double;
  X1,X2,X3,X4,X5:Double;

  CHeader : TcxSSHeader;
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
  '      , (ALICI_BORC_VPB-SATICI_ALACAK_VPB) as FARK '+#13+

  ' FROM SEFER K';


  Where_Ekle(prv_Sirket_Kiralik,strSQL);
  strSql:=strSQL;
  strSQL := strSQL + ' ORDER BY K.BAS_TAR,K.SEFER_ID';
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

    case prv_Sirket_Kiralik of
      1: frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Gunluk_Sefer.fr3');

      2:
      {$IfDef EKINCI}
        frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kiralik_Sefer_Ack.fr3');
      {$Else}
        frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kiralik_Sefer.fr3');
      {$EndIf}
      4: frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kiralik_Sefer_Ekinci.fr3');
    end;


       //frxReport1.PrepareReport();
    case prv_Sirket_Kiralik of
     1,2,4:begin
       frxReport1.showReport;
       Exit;
       end;
     end;
  end;



  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;

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
    col:=5;

    if prv_Sirket_Kiralik=1 then col:=3;

    if prv_Sirket_Kiralik=2 then col:=7;
  {$IfDef EKINCI}
    if prv_Sirket_Kiralik=2 then col:=8;
  {$EndIf}

    SetCellText(row,col,'Döküman No : ');
    Inc(Row);
    SetCellText(row,col,'Yayýn Tarihi : ');
//    SetCellText(row,col+1,DateToStr(DataMod.GET_SERVER_DATE));
    SetCellText(row,col+1,DateToStr(dtpIslemTar2.date));


    Inc(Row);

    case prv_Sirket_Kiralik of
      1:SetCellText(row,1,'GÜNLÜK SEFER RAPORU ');
      2:SetCellText(row,1,'KÝRALIK ARAÇ SEFER RAPORU ');
      3:SetCellText(row,1,'TOPLAM ÝCMAL RAPORU ');
    end;
    SetCellFont(1,row,1,row,[fsBold],10,'MS Sans Serif',2);

    SetCellText(row,col,'Revizyon Tarihi : ');
    Inc(Row);
    SetCellText(row,col,'Revizyon No : ');
    Inc(Row);

////////////////////////////////////////////////////////////////////////////////

    if prv_Sirket_Kiralik=1 then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Araç Plaka');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Cari Adý');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Sefer Sayýsý');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Birim Fiyatý');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Toplam Ödenen');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    end;


    if prv_Sirket_Kiralik=2 then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Araç Plaka');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Saglayýcý');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Müþteri');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


  {$IfDef EKINCI}

      inc(col);
      SetCellText(row,col,'Sefer Notlarý');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

  {$EndIf}


      inc(col);
      SetCellText(row,col,'Sefer Sayýsý');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Birim Fiyatý');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Tutar');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Kiralýk Bf');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Kiralýk Tutar');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(col);
      SetCellText(row,col,'Kalan');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    end;


    if prv_Sirket_Kiralik=3 then
    begin
    Col:=2;
      strSQL :=
      //' SELECT Count(SEFER_ID) SEFER_SAYISI '+#13+
      ' SELECT SUM(SEFER_SAY) SEFER_SAYISI '+#13+
      ' FROM SEFER K';
       Where_Ekle(4,strSQL);
      try
        with IB_Query1 do
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
    Inc(Row);
    SetCellText(row,col,'Toplam Sefer : ');
    SetCellText(row,col+2,InttoStr(IB_Query1.FieldbyName('SEFER_SAYISI').AsInteger));
    frmRaporCiktisi.SetCellFont(col,row,col+2,row,[fsBold],8,'MS Sans Serif',0);

    Memo_Toplam_Sefer:=IB_Query1.FieldbyName('SEFER_SAYISI').AsInteger;



      strSQL :=
      ' SELECT SUM(ALICI_BORC_VPB) ALICI_BORC_VPB '+#13+
      ' FROM SEFER K';
       Where_Ekle(4,strSQL);
      try
        with IB_Query1 do
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
    Inc(Row);
    SetCellText(row,col,'Toplam Ciro : ');
    x1:=IB_Query1.FieldbyName('ALICI_BORC_VPB').AsFloat;
    SetCellText(row,col+2,FloattoStr(x1));
    format_ayarla(col+2,row,col+2,row);
    frmRaporCiktisi.SetCellFont(col,row,col+2,row,[fsBold],8,'MS Sans Serif',0);


    Memo_Toplam_Ciro:=X1;



      strSQL :=
//      ' SELECT SUM(SATICI_ALACAK_VPB) SATICI_ALACAK_VPB '+#13+
      ' SELECT SUM(ALICI_BORC_VPB) SATICI_ALACAK_VPB '+#13+
      ' FROM SEFER K';
       Where_Ekle(2,strSQL);
      try
        with IB_Query1 do
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
    Inc(Row);
    SetCellText(row,col,'Kiralýk Ciro : ');
    x2:=IB_Query1.FieldbyName('SATICI_ALACAK_VPB').AsFloat;
    SetCellText(row,col+2,FloattoStr(x2));
    format_ayarla(col+2,row,col+2,row);
    frmRaporCiktisi.SetCellFont(col,row,col+2,row,[fsBold],8,'MS Sans Serif',0);

    Memo_Kiralik_Ciro:=X2;


      strSQL :=
      ' SELECT SUM(SATICI_ALACAK_VPB) SATICI_ALACAK_VPB '+#13+
      ' FROM SEFER K';
       Where_Ekle(2,strSQL);
      // strSQL:=strSQL+ ' AND SEFER_SATIS_FAT_KESILDI=1';
      try
        with IB_Query1 do
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

    Inc(Row);
    SetCellText(row,col,'Kiralýk Ödenen : ');
    x3:=IB_Query1.FieldbyName('SATICI_ALACAK_VPB').AsFloat;
    SetCellText(row,col+2,FloattoStr(x3));
    format_ayarla(col+2,row,col+2,row);
    frmRaporCiktisi.SetCellFont(col,row,col+2,row,[fsBold],8,'MS Sans Serif',0);

    Memo_Kiralik_Odenen:=X3;


    Inc(Row);
    SetCellText(row,col,'Kiralýk Kalan : ');
    SetCellText(row,col+2,FloattoStr(x2-x3));
    format_ayarla(col+2,row,col+2,row);
    frmRaporCiktisi.SetCellFont(col,row,col+2,row,[fsBold],8,'MS Sans Serif',0);
    Inc(Row);
//    SetCellText(row,col,'Toplam Ciro - Kiralýk Kalan : ');
    SetCellText(row,col,'Toplam Ciro - Kiralýk Ödenen : ');
 //   SetCellText(row,col+2,FloattoStr((x1-x2)+(x2-x3)));
    SetCellText(row,col+2,FloattoStr(x1-x3));
    format_ayarla(col+2,row,col+2,row);
    frmRaporCiktisi.SetCellFont(col,row,col+2,row,[fsBold],8,'MS Sans Serif',0);
    Inc(Row);

    Memo_Kiralik_Kalan:=(x2-x3);

    //Memo_Ciro_Kalan:=(x1-x2)+(x2-x3);
    Memo_Ciro_Kalan:=(x1-x3);


//    SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
//    format_ayarla(7,3,7,frmRaporCiktisi.grdA.ActiveSheet.RowCount);



   {

      strSQL :=
      //' SELECT Count(SEFER_ID) SEFER_SAYISI '+#13+
      ' SELECT SUM(MIKTAR) TON_MIKTAR '+#13+
      ' FROM SEFER K';
       Where_Ekle(4,strSQL);
      try
        with IB_Query1 do
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

     Ton_Miktar:=IB_Query1.FieldbyName('TON_MIKTAR').AsFloat;


      strSQL :=
      //' SELECT Count(SEFER_ID) SEFER_SAYISI '+#13+
      ' SELECT SUM(MIKTAR) TON_MIKTAR '+#13+
      ' FROM SEFER K';
       Where_Ekle(5,strSQL);

      try
        with IB_Query1 do
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

     K20lik_Miktar:=IB_Query1.FieldbyName('TON_MIKTAR').AsFloat;


      strSQL :=
      //' SELECT Count(SEFER_ID) SEFER_SAYISI '+#13+
      ' SELECT SUM(MIKTAR) TON_MIKTAR '+#13+
      ' FROM SEFER K';
       Where_Ekle(5,strSQL);

      try
        with IB_Query1 do
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

     K40lik_Miktar:=IB_Query1.FieldbyName('TON_MIKTAR').AsFloat;
    }


  //if prv_Sirket_Kiralik=3 then
  if sender=Btn_Fast then
  begin
       frmRaporCiktisi.Close;
       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Toplam_Kg_Sefer.fr3');
       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;

  end;

  {
  if prv_Sirket_Kiralik=4 then
  if sender=Btn_Fast then
  begin
       frmRaporCiktisi.Close;
       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Toplam_Kg_Sefer_Detayli.fr3');
       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;

  end; }


    frmRaporCiktisi.Rapor_Ayarlari(1);
    grdA.EndUpdate;
    WindowState := wsMaximized;
    qrySefer.First;
    qrySefer.EnableControls;
    Exit;
    end;

    inc(row);
    qrySefer.DisableControls;
    qrySefer.First;
    Sefer_Say:=0;
    Alici_Tutar:=0;
    Kiralik_Tutar:=0;

    while not qrySefer.Eof do
    begin
         if prv_Sirket_Kiralik=1 then
         begin
           col := 0;


           DataMod.Rapor_Satir_Renklendir(col,row,4);



           SetCellText(row,col,qrySefer.FieldByName('ARAC_PLAKA').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('ALICI_ADI').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('SEFER_SAY').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('ALICI_BORC').AsString);
           inc(row);
         end;

         if prv_Sirket_Kiralik=2 then
         begin
           col := 0;
           DataMod.Rapor_Satir_Renklendir(col,row,8);
  {$IfDef EKINCI}
           DataMod.Rapor_Satir_Renklendir(col,row,9);
  {$EndIf}
           SetCellText(row,col,qrySefer.FieldByName('ARAC_PLAKA').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('SATICI_ADI').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('ALICI_ADI').AsString);


  {$IfDef EKINCI}
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('SEFER_NOTLARI').AsString);
  {$EndIf}


           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('SEFER_SAY').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('ALICI_BORC').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsString);
           inc(col);
           SetCellText(row,col,qrySefer.FieldByName('SATICI_ALACAK').AsString);
           inc(col);
           SetCellText(row,col,Floattostr(qrySefer.FieldByName('ALICI_BORC').AsFloat-qrySefer.FieldByName('SATICI_ALACAK').AsFloat));

           inc(row);
         end;


         Sefer_Say:=Sefer_Say+qrySefer.FieldByName('SEFER_SAY').AsInteger;
         Alici_Tutar:=Alici_Tutar+qrySefer.FieldByName('ALICI_BORC').Asfloat;
         Kiralik_Tutar:=Kiralik_Tutar+qrySefer.FieldByName('SATICI_ALACAK').Asfloat;

         qrySefer.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    if prv_Sirket_Kiralik=1 then
    begin
      col := 1;
      SetCellText(row,col,'Toplam');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      SetCellText(row,2,Inttostr(Sefer_Say));
      SetCellText(row,4,Floattostr(Alici_Tutar));
    end;

    if prv_Sirket_Kiralik=2 then
    begin
      col := 2;

      SetCellText(row,col,'Sefer');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      SetCellText(row,col+1,Inttostr(Sefer_Say));

      inc(row);
      SetCellText(row,col,'Tutar');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      SetCellText(row,col+1,Floattostr(Alici_Tutar));
      format_ayarla(col+1,row,col+1,row);

      inc(row);
      SetCellText(row,col,'Kiralik');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      SetCellText(row,col+1,Floattostr(Kiralik_Tutar));
      format_ayarla(col+1,row,col+1,row);

      inc(row);
      SetCellText(row,col,'Kalan');
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      SetCellText(row,col+1,Floattostr(Alici_Tutar-Kiralik_Tutar));
      format_ayarla(col+1,row,col+1,row);
    end;


    inc(row);
    col := 7;
////////////////////////////////////////////////////////////////////////////////
    SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    //format_ayarla(7,3,7,frmRaporCiktisi.grdA.ActiveSheet.RowCount);



    if prv_Sirket_Kiralik=1 then
    begin
      format_ayarla(3,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      CHeader.Size[1] := 250;
      frmRaporCiktisi.Rapor_Ayarlari(1);
		end;

    if prv_Sirket_Kiralik=2 then
    begin
  {$IfnDef EKINCI}
      format_ayarla(4,7,8,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
  {$EndIf}

  {$IfDef EKINCI}
      format_ayarla(5,7,9,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
  {$EndIf}
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      CHeader.Size[1] := 150;
      CHeader.Size[2] := 150;
  {$IfDef EKINCI}
      CHeader.Size[3] := 150;
  {$EndIf}

      frmRaporCiktisi.Rapor_Ayarlari(2);
    end;


   // if prv_Sirket_Kiralik=3 then
    //format_ayarla(9,3,10,frmRaporCiktisi.grdA.ActiveSheet.RowCount);


    qrySefer.Close;
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
//  qrySefer.First;
//  qrySefer.EnableControls;


end;

procedure TfrmRaporSeferKasali.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrySefer.Close;
  Action := caFree;
end;

procedure TfrmRaporSeferKasali.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporSeferKasali.Button8Click(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    txtAlanPers.Text:=PERSONEL_KOD;
    Label18.Caption:=PERSONEL_AD;
  end;
end;

procedure TfrmRaporSeferKasali.txtAlanPersExit(Sender: TObject);
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

procedure TfrmRaporSeferKasali.txtAracEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSeferKasali.dtpIslemTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSeferKasali.dtpIslemTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporSeferKasali.txtAracKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button9Click(Self);
end;

procedure TfrmRaporSeferKasali.txtAlanPersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button8Click(Self);
end;

procedure TfrmRaporSeferKasali.TxtMazotcuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button7Click(Self);
end;

procedure TfrmRaporSeferKasali.txtAlanCariKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button6Click(Self);
end;

procedure TfrmRaporSeferKasali.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e,f:TfrxMemoView;//TfrxComponent;
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



    if prv_Sirket_Kiralik=3 then
    begin
       a:=(frxReport1.FindComponent('Memo_Toplam_Sefer') as TfrxMemoView);
       a.memo.Text:=FormatFloat(glb_VPB_FIELD_PF,Memo_Toplam_Sefer); //FloattoStr(Memo_Toplam_Sefer);

       b:=(frxReport1.FindComponent('Memo_Toplam_Ciro') as TfrxMemoView);
       b.memo.Text:=FormatFloat(glb_VPB_FIELD_PF,Memo_Toplam_Ciro);//FloattoStr(Memo_Toplam_Ciro);
       c:=(frxReport1.FindComponent('Memo_Kiralik_Ciro') as TfrxMemoView);
       c.memo.Text:=FormatFloat(glb_VPB_FIELD_PF,Memo_Kiralik_Ciro);//FloattoStr(Memo_Kiralik_Ciro);
       d:=(frxReport1.FindComponent('Memo_Kiralik_Odenen') as TfrxMemoView);
       d.memo.Text:=FormatFloat(glb_VPB_FIELD_PF,Memo_Kiralik_Odenen);//FloattoStr(Memo_Kiralik_Odenen);
       e:=(frxReport1.FindComponent('Memo_Kiralik_Kalan') as TfrxMemoView);
       e.memo.Text:=FormatFloat(glb_VPB_FIELD_PF,Memo_Kiralik_Kalan);//FloattoStr(Memo_Kiralik_Kalan);
       f:=(frxReport1.FindComponent('Memo_Ciro_Kalan') as TfrxMemoView);
       f.memo.Text:=FormatFloat(glb_VPB_FIELD_PF,Memo_Ciro_Kalan);//FloattoStr(Memo_Ciro_Kalan);

    end;


   
       Prv_Yazdirildi:=True;    
    end;
end;

procedure TfrmRaporSeferKasali.btnISLEMMERKEZIClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSeferKasali.btnKOD1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSeferKasali.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TfrmRaporSeferKasali.txtKOD1Exit(Sender: TObject);
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

procedure TfrmRaporSeferKasali.txtKOD1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD1Click(Self);
end;

procedure TfrmRaporSeferKasali.txtISLEMMERKEZIKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnISLEMMERKEZIClick(Self);
end;

procedure TfrmRaporSeferKasali.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

end.
