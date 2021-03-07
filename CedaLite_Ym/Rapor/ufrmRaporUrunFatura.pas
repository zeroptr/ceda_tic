unit ufrmRaporUrunFatura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, IB_Components,cxSSTypes,cxSSHeaders;

type
  TfrmRaporUrunFatura = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chkSirket: TCheckBox;
    Panel1: TPanel;
    btnRapor: TButton;
    btnCikis: TButton;
    GroupBox1: TGroupBox;
    txtUrunKod1: TEdit;
    txtUrunKod2: TEdit;
    btnUrunKod1: TButton;
    btnUrunKod2: TButton;
    GroupBox2: TGroupBox;
    dtpTarih1: TDateTimePicker;
    dtpTarih2: TDateTimePicker;
    GroupBox3: TGroupBox;
    cmbFaturaTip: TComboBox;
    qryRapor: TIB_Cursor;
    qryDekontD: TIB_Cursor;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open;
    procedure Baslik_Ekle;
    procedure Baslik_Ekle_Hepsi;
    procedure TekUrunYaz;
    procedure HepsiniYaz;
    procedure yaz;
    procedure yazhepsi(Urun_Kod,Urun_Ad:String);
////////////////////////////////////////////////////////////////////////////////
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtUrunKod1Exit(Sender: TObject);
    procedure txtUrunKod1Enter(Sender: TObject);
    procedure chkSirketEnter(Sender: TObject);
    procedure chkSirketExit(Sender: TObject);
    procedure txtUrunKod1KeyPress(Sender: TObject; var Key: Char);
    procedure txtUrunKod1KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtUrunKod2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure dtpTarih1Enter(Sender: TObject);
    procedure dtpTarih1Exit(Sender: TObject);
    procedure cmbFaturaTipEnter(Sender: TObject);
    procedure cmbFaturaTipExit(Sender: TObject);
    procedure btnUrunKod1Click(Sender: TObject);
    procedure btnUrunKod2Click(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    row,col:Integer;
    prv_satis,prv_alis : integer;
  public
    { Public declarations }
  end;
  const cns_urun_fatura = 7;
var
  frmRaporUrunFatura: TfrmRaporUrunFatura;

implementation

uses main,unDataMod,ufrmRaporCiktisi,unFunc,ufrmUrunSDLG;

{$R *.dfm}

{ TfrmRaporUrunFatura }

procedure TfrmRaporUrunFatura.Form_Open;
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_urun_fatura,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporUrunFatura') then
    begin
      Application.CreateForm(TfrmRaporUrunFatura,frmRaporUrunFatura);
    end;
  end;
end;

procedure TfrmRaporUrunFatura.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporUrunFatura);
end;

procedure TfrmRaporUrunFatura.FormShow(Sender: TObject);
begin
  dtpTarih1.Date := glb_DONEM_BAS;
  dtpTarih2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporUrunFatura.btnCikisClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporUrunFatura.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporUrunFatura.txtUrunKod1Exit(Sender: TObject);
var
  UrunAd : String;
begin
  if Length(Trim((Sender as TEdit).Text))=0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',(Sender as TEdit).Text,UrunAd)) then
  begin
    (Sender as TEdit).SetFocus;
    Application.MessageBox('Ürün Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmRaporUrunFatura.txtUrunKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunFatura.chkSirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunFatura.chkSirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporUrunFatura.txtUrunKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporUrunFatura.txtUrunKod1KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then
  begin
    btnUrunKod1Click(Self);
  end;
end;

procedure TfrmRaporUrunFatura.txtUrunKod2KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then
  begin
    btnUrunKod2Click(Self);
  end;
end;

procedure TfrmRaporUrunFatura.dtpTarih1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunFatura.dtpTarih1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporUrunFatura.cmbFaturaTipEnter(Sender: TObject);
begin
  ( Sender as TComboBox ).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunFatura.cmbFaturaTipExit(Sender: TObject);
begin
  ( Sender as TComboBox ).Color := clWindow;
end;

procedure TfrmRaporUrunFatura.btnUrunKod1Click(Sender: TObject);
var
  UrunKod,UrunAd:String;
begin
  if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod1.Text := UrunKod;
end;

procedure TfrmRaporUrunFatura.btnUrunKod2Click(Sender: TObject);
var
  UrunKod,UrunAd:String;
begin
  if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod2.Text := UrunKod;
end;

procedure TfrmRaporUrunFatura.btnRaporClick(Sender: TObject);
var
  strSQL:String;
  CHeader : TcxSSHeader;
begin
//****************************************************************************//
  if (Trim(txtUrunKod1.Text)='') and (Trim(txtUrunKod2.Text)='') then
  begin
    HepsiniYaz;
    exit;
  end;
//****************************************************************************//
  if Trim(txtUrunKod1.Text)='' then
  begin
    txtUrunKod1.SetFocus;
    Application.MessageBox('Lütfen bir ürün kodu seçiniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end
  else
    TekUrunYaz;
//****************************************************************************//
end;

procedure TfrmRaporUrunFatura.TekUrunYaz;
var
  strSQL:String;
  CHeader : TcxSSHeader;
begin
  if dtpTarih1.DateTime > dtpTarih2.DateTime then
  begin
    dtpTarih1.SetFocus;
    Application.MessageBox('Birinci iþlem tarihi ikinci tarihten büyük olamaz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;

  strSQL := 'SELECT'
           +' URUNHAR.URUN_KOD,'
           +' (SELECT URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD = URUNHAR.URUN_KOD) AS URUN_AD,'
           +' FAT_IRS.TARIH,'
           +' FAT_IRS.BELGE_NO,'
           +' FAT_IRS.CARI_KOD,'
           +' (SELECT CARI.CARI_AD FROM CARI WHERE CARI.CARI_KOD=FAT_IRS.CARI_KOD) as CARI_AD,'
           +' FAT_IRS.TIP,'
           +' URUNHAR.MIKTAR,'
           +' URUNHAR.TUTAR_VPB'
           +' FROM URUNHAR'
           +' INNER JOIN FAT_IRS ON (FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)';

  if (Trim(txtUrunKod1.Text) <> '') and (Trim(txtUrunKod2.Text)<> '') then
  begin
    strSQL := strSQL + ' WHERE URUNHAR.URUN_KOD BETWEEN '+SQL_Katar(txtUrunKod1.Text)+' AND '+SQL_Katar(txtUrunKod2.Text);
  end
  else
  if (Trim(txtUrunKod1.Text) <> '') then
  begin
    strSQL := strSQL + ' WHERE URUNHAR.URUN_KOD = '+SQL_Katar(txtUrunKod1.Text);
  end;

  strSQL := strSQL + ' AND FAT_IRS.TARIH BETWEEN '+SQL_Tarih(dtpTarih1.Date)+' AND '+SQL_Tarih(dtpTarih2.Date)+' AND FAT_IRS.FAT_IRS_SID = '+IntToStr(glb_SID);

  case cmbFaturaTip.ItemIndex of
  0: strSQL := strSQL + ' AND FAT_IRS.TIP = 1';
  1: strSQL := strSQL + ' AND FAT_IRS.TIP = 2';
  end;

  strSQL := strSQL + ' ORDER BY FAT_IRS.TARIH';

  with qryRapor do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;
//****************************************************************************//
  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;
  Baslik_Ekle;
  yaz;
  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[3] := 100;
  CHeader.Size[2] := 100;
  CHeader.Size[1] := 100;
  CHeader.Size[4] := 200;
  CHeader.Size[5] := 100;
  CHeader.Size[6] := 100;
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
  qryRapor.Close;
//****************************************************************************//
end;

procedure TfrmRaporUrunFatura.yaz;
var
  satis,alis : integer;
  qryUrunListe,qryTmpDekontD:TIB_Cursor;
  strSQL : String;
begin
  satis := 0;
  alis := 0;
  DataMod.CreateCursor(qryUrunListe,nil,False,DataMod.dbaMain);
////////////////////////////////////////////////////////////////////////////////
  with qryUrunListe do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT DOVKOD,DEV_MIK_ALACAK,DEV_MIK_BORC,DEV_BORC,DEV_ALACAK,DEV_BORC_VPB,DEV_ALACAK_VPB FROM URUN WHERE URUN_KOD = '+SQL_Katar(qryRapor.FieldByName('URUN_KOD').AsString));
    Open;
  end;

  satis := 0;
  alis := 0;
  col := 5;

  if qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger > qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger then
  begin
    alis := qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger - qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger;
    satis := 0;
    frmRaporCiktisi.SetCellText(row,col,'DEVÝR KAYDI');
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,inttostr(alis));
  end
  else
  if qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger < qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger then
  begin
    satis := qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger - qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger;
    alis := 0;
    frmRaporCiktisi.SetCellText(row,col,'DEVÝR KAYDI');
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,inttostr(satis));
  end
  else
  if qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger = qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger then
  begin
    satis := 0;
    alis := 0;
    frmRaporCiktisi.SetCellText(row,col,'DEVÝR KAYDI');
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,'0');
  end;
////////////////////////////////////////////////////////////////////////////////
  if qryUrunListe.FieldByName('DOVKOD').AsString = glb_DEFCUR then
  begin
    if qryUrunListe.FieldByName('DEV_BORC_VPB').AsCurrency > qryUrunListe.FieldByName('DEV_ALACAK_VPB').AsCurrency then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryUrunListe.FieldByName('DEV_BORC_VPB').AsCurrency - qryUrunListe.FieldByName('DEV_ALACAK_VPB').AsCurrency));
    end
    else
    if qryUrunListe.FieldByName('DEV_BORC_VPB').AsCurrency < qryUrunListe.FieldByName('DEV_ALACAK_VPB').AsCurrency then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryUrunListe.FieldByName('DEV_ALACAK_VPB').AsCurrency - qryUrunListe.FieldByName('DEV_BORC_VPB').AsCurrency));
    end
    else
    if qryUrunListe.FieldByName('DEV_BORC_VPB').AsCurrency = qryUrunListe.FieldByName('DEV_ALACAK_VPB').AsCurrency then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'0');
    end;
  end
  else
  begin
    if qryUrunListe.FieldByName('DEV_BORC').AsCurrency > qryUrunListe.FieldByName('DEV_ALACAK').AsCurrency then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryUrunListe.FieldByName('DEV_BORC').AsCurrency - qryUrunListe.FieldByName('DEV_ALACAK').AsCurrency));
    end
    else
    if qryUrunListe.FieldByName('DEV_BORC').AsCurrency < qryUrunListe.FieldByName('DEV_ALACAK').AsCurrency then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryUrunListe.FieldByName('DEV_ALACAK').AsCurrency - qryUrunListe.FieldByName('DEV_BORC').AsCurrency));
    end
    else
    if qryUrunListe.FieldByName('DEV_BORC').AsCurrency = qryUrunListe.FieldByName('DEV_ALACAK').AsCurrency then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'0');
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
  inc(row);
  qryRapor.First;
////////////////////////////////////////////////////////////////////////////////
  while not qryRapor.Eof do
  begin
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,6);

    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('URUN_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TARIH').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_KOD').AsString);
    frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_AD').AsString);
    inc(col);
////////////////////////////////////////////////////////////////////////////////
    case qryRapor.FieldByName('TIP').AsInteger of
    1: frmRaporCiktisi.SetCellText(row,col,'SATIÞ FATURASI');
    2: frmRaporCiktisi.SetCellText(row,col,'ALIÞ FATURASI');
    end;
////////////////////////////////////////////////////////////////////////////////
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MIKTAR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
    frmRaporCiktisi.SetCellFormat(col,row,col,row,3);
////////////////////////////////////////////////////////////////////////////////
    if cmbFaturaTip.ItemIndex = 2 then
    begin
      case qryRapor.FieldByName('TIP').AsInteger of
      1: satis := satis + qryRapor.FieldByName('MIKTAR').AsInteger;
      2: alis := alis + qryRapor.FieldByName('MIKTAR').AsInteger;
      end;
    end;
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    qryRapor.Next;
  end;
////////////////////////////////////////////////////////////////////////////////
  {
  strSQL := 'SELECT'+
            ' DEKONT.DEKONT_ID,'+
            'DEKONT.ISLEM_TAR,'+
            'DEKONT_D.BA,'+
            'DEKONT_D.MIKTAR,'+
            'DEKONT_D.KARSI_KOD,'+
            'DEKONT_D.TUTAR_VPB'+
            ' FROM DEKONT_D'+
            ' LEFT OUTER JOIN DEKONT ON (DEKONT.DEKONT_ID = DEKONT_D.DEKONT_ID AND DEKONT.DEKONT_SID = DEKONT_D.DEKONT_SID)'+
            ' WHERE DEKONT_D.KARSI_KOD = '+SQL_Katar(txtUrunKod1.Text)+
            ' AND DEKONT.TIP = 2'+
            ' AND DEKONT_D.MC='+ SQL_Katar('U');
////////////////////////////////////////////////////////////////////////////////
  DataMod.CreateCursor(qryTmpDekontD,nil,False,DataMod.dbaMain);
  with qryTmpDekontD do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  end;
////////////////////////////////////////////////////////////////////////////////
  if qryTmpDekontD.RecordCount <> 0 then
  begin
    inc(row);
    qryTmpDekontD.First;
    repeat
      col := 0;

      DataMod.Rapor_Satir_Renklendir(col,row,6);

      frmRaporCiktisi.SetCellText(row,col,txtUrunKod1.Text);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryTmpDekontD.FieldByName('ISLEM_TAR').AsString);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryTmpDekontD.FieldByName('DEKONT_ID').AsString);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'');
      frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'');
      inc(col);
////////////////////////////////////////////////////////////////////////////////
//      case qryRapor.FieldByName('TIP').AsInteger of
//      1: frmRaporCiktisi.SetCellText(row,col,'SATIÞ FATURASI');
//      2: frmRaporCiktisi.SetCellText(row,col,'ALIÞ FATURASI');
//      end;
      frmRaporCiktisi.SetCellText(row,col,'SERBEST DEKONT');
////////////////////////////////////////////////////////////////////////////////
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryTmpDekontD.FieldByName('MIKTAR').AsString);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryTmpDekontD.FieldByName('TUTAR_VPB').AsString);
      frmRaporCiktisi.SetCellFormat(col,row,col,row,3);
////////////////////////////////////////////////////////////////////////////////
      if qryTmpDekontD.FieldByName('BA').AsString = BORC then
      begin
        alis := alis + qryTmpDekontD.FieldByName('MIKTAR').AsInteger;
      end
      else
      if qryTmpDekontD.FieldByName('BA').AsString = ALACAK then
      begin
        satis := satis + qryTmpDekontD.FieldByName('MIKTAR').AsInteger;
      end;
      qryTmpDekontD.Next;
      inc(row);
    until qryTmpDekontD.Eof;
  end;
  qryTmpDekontD.Close;
////////////////////////////////////////////////////////////////////////////////
  DataMod.ReleaseCursor(qryTmpDekontD);
////////////////////////////////////////////////////////////////////////////////
  if cmbFaturaTip.ItemIndex = 2 then
  begin
    col := 5;
    inc(row);
    frmRaporCiktisi.SetCellText(row,col,'Toplam');
    frmRaporCiktisi.SetCellFormat(col,row,col,row,3);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,inttostr(alis-satis));
    frmRaporCiktisi.SetCellFormat(col,row,col,row,3);
  end;
////////////////////////////////////////////////////////////////////////////////
}
  qryRapor.Active := False;
end;


procedure TfrmRaporUrunFatura.HepsiniYaz;
var
  strSQL:String;
  CHeader : TcxSSHeader;
  qryUrunListe : TIB_Cursor;
begin
  if dtpTarih1.DateTime > dtpTarih2.DateTime then
  begin
    dtpTarih1.SetFocus;
    Application.MessageBox('Birinci iþlem tarihi ikinci tarihten büyük olamaz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
//****************************************************************************//
  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;
  DataMod.CreateCursor(qryUrunListe,nil,False,DataMod.dbaMain);
  with qryUrunListe do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_KOD,URUN_AD,DEV_MIK_ALACAK,DEV_MIK_BORC FROM URUN ORDER BY URUN.URUN_KOD ');
    Open;
  end;
  Baslik_Ekle_Hepsi;
  qryUrunListe.First;
  repeat
//*************************************start**********************************//
    prv_satis := 0;
    prv_alis := 0;
    if qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger > qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger then
    begin
      prv_alis := qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger - qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger;
      prv_satis := 0;
    end
    else
    if qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger < qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger then
    begin
      prv_satis := qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger - qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger;
      prv_alis := 0;
    end
    else
    if qryUrunListe.FieldByName('DEV_MIK_BORC').AsInteger = qryUrunListe.FieldByName('DEV_MIK_ALACAK').AsInteger then
    begin
      prv_satis := 0;
      prv_alis := 0;
    end;

    strSQL := 'SELECT'
             +' URUNHAR.URUN_KOD,'
             +' (SELECT URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD = URUNHAR.URUN_KOD) AS URUN_AD,'
             +' FAT_IRS.TARIH,'
             +' FAT_IRS.BELGE_NO,'
             +' FAT_IRS.CARI_KOD,'
             +' (SELECT CARI.CARI_AD FROM CARI WHERE CARI.CARI_KOD=FAT_IRS.CARI_KOD) as CARI_AD,'
             +' FAT_IRS.TIP,'
             +' URUNHAR.MIKTAR,'
             +' URUNHAR.TUTAR_VPB'
             +' FROM URUNHAR'
             +' INNER JOIN FAT_IRS ON (FAT_IRS.FAT_IRS_ID=URUNHAR.FATURA_ID AND FAT_IRS.FAT_IRS_SID=URUNHAR.FATURA_SID)';
    strSQL := strSQL + ' WHERE URUNHAR.URUN_KOD = '+SQL_Katar(qryUrunListe.FieldByName('URUN_KOD').AsString);
    strSQL := strSQL + ' AND FAT_IRS.TARIH BETWEEN '+SQL_Tarih(dtpTarih1.Date)+' AND '+SQL_Tarih(dtpTarih2.Date)+' AND FAT_IRS.FAT_IRS_SID = '+IntToStr(glb_SID);

    case cmbFaturaTip.ItemIndex of
    0: strSQL := strSQL + ' AND FAT_IRS.TIP = 1';
    1: strSQL := strSQL + ' AND FAT_IRS.TIP = 2';
    end;

    strSQL := strSQL + ' ORDER BY FAT_IRS.TARIH';

    with qryRapor do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
//*************************************stop***********************************//
//    if not ((qryRapor.Bof) and (qryRapor.Eof)) then
//    begin
      yazhepsi(qryUrunListe.FieldByName('URUN_KOD').AsString,qryUrunListe.FieldByName('URUN_AD').AsString);
      inc(row);
      qryDekontD.Close;
//    end;
//****************************************************************************//
    qryUrunListe.Next;
  until qryUrunListe.Eof;
  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[3] := 100;
  CHeader.Size[2] := 100;
  CHeader.Size[1] := 100;
  CHeader.Size[4] := 200;
  CHeader.Size[5] := 100;
  CHeader.Size[6] := 100;
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
  qryRapor.Close;
//****************************************************************************//
end;

procedure TfrmRaporUrunFatura.Baslik_Ekle;
var
  res_Cari : TStringList;
begin
  row := 0;
  col := 0;
  if chkSirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
     frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
     frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 1;
  end;

  frmRaporCiktisi.SetCellText(row,col,'Ürün Kodu');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Tarih');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'No');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Cari Kod');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Cari Ad');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Tip');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Miktar');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Tutar VPB');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  if cmbFaturaTip.ItemIndex = 3 then
  begin
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,'Borç');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,'Alacak');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  end;
  col := 0;
  inc(row);
end;


procedure TfrmRaporUrunFatura.Baslik_Ekle_Hepsi;
var
  res_Cari : TStringList;
begin
  row := 0;
  col := 0;
  if chkSirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
     frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
     frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 1;
  end;
  frmRaporCiktisi.SetCellText(row,col,'Ürün Kodu');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Ürün Adý');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Toplam');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  col := 0;
  inc(row);
end;


procedure TfrmRaporUrunFatura.yazhepsi(Urun_Kod,Urun_Ad:String);
var
  satis,alis : integer;
begin
  satis := prv_satis;
  alis := prv_alis;
////////////////////////////////////////////////////////////////////////////////
  qryRapor.First;
  col := 0;
  frmRaporCiktisi.SetCellText(row,col,Urun_Kod);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,Urun_Ad);
  inc(Row);
////////////////////////////////////////////////////////////////////////////////
  while not qryRapor.Eof do
  begin

       DataMod.Rapor_Satir_Renklendir(col,row,6);

col := 0;
    {col := 0;
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('URUN_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('URUN_AD').AsString);
    }
    //inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_KOD').AsString);
    frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_AD').AsString);
    inc(col);
////////////////////////////////////////////////////////////////////////////////
    case qryRapor.FieldByName('TIP').AsInteger of
    1: frmRaporCiktisi.SetCellText(row,col,'SATIÞ FATURASI');
    2: frmRaporCiktisi.SetCellText(row,col,'ALIÞ FATURASI');
    end;
////////////////////////////////////////////////////////////////////////////////
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MIKTAR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
    frmRaporCiktisi.SetCellFormat(col,row,col,row,3);
////////////////////////////////////////////////////////////////////////////////

    if cmbFaturaTip.ItemIndex = 2 then
    begin
      case qryRapor.FieldByName('TIP').AsInteger of
      1: satis := satis + qryRapor.FieldByName('MIKTAR').AsInteger;
      2: alis := alis + qryRapor.FieldByName('MIKTAR').AsInteger;
      end;
    end;
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    qryRapor.Next;
  end;
////////////////////////////////////////////////////////////////////////////////
  {with qryDekontD do
  begin
    Close;
    ParamByName('PRM_KARSI_KOD').AsString := Urun_Kod;
    Open;
  end;
  if qryDekontD.RecordCount <> 0 then
  begin
    qryDekontD.First;
    repeat
      if qryDekontD.FieldByName('BA').AsString = BORC then
      begin
        alis := alis + qryDekontD.FieldByName('MIKTAR').AsInteger;
      end
      else
      if qryDekontD.FieldByName('BA').AsString = ALACAK then
      begin
        satis := satis + qryDekontD.FieldByName('MIKTAR').AsInteger;
      end;
      qryDekontD.Next;
    until qryDekontD.Eof;
  end;
  qryDekontD.Close;
////////////////////////////////////////////////////////////////////////////////
  if cmbFaturaTip.ItemIndex = 2 then
  begin
    inc(col);
    //col := 5;
//    inc(row);
//    frmRaporCiktisi.SetCellText(row,col,'Toplam');
//    frmRaporCiktisi.SetCellFormat(col,row,col,row,3);
//    inc(col);
    frmRaporCiktisi.SetCellText(row,col,inttostr(alis-satis));
    frmRaporCiktisi.SetCellFormat(col,row,col,row,3);
  end;
  }
////////////////////////////////////////////////////////////////////////////////
  qryRapor.Active := False;
end;

procedure TfrmRaporUrunFatura.FormKeyPress(Sender: TObject; var Key: Char);
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

end.
