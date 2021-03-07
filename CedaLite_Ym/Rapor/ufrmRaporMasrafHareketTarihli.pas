{$INCLUDE directive.inc}

unit ufrmRaporMasrafHareketTarihli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IB_Components,
  frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporMasrafHareketTarihli = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryRapor: TIB_Cursor;
    qryToplam: TIB_Cursor;
    GroupBox1: TGroupBox;
    chkDEVIR: TCheckBox;
    chk_Sirket: TCheckBox;
    GroupBox4: TGroupBox;
    txtGrpKod: TEdit;
    btnMasrafGrpListe: TButton;
    TabSheet2: TTabSheet;
    lblISLEMMERKEZI: TLabel;
    lblKOD1: TLabel;
    lblKOD2: TLabel;
    lblKOD3: TLabel;
    lblKOD4: TLabel;
    txtISLEMMERKEZI: TEdit;
    btnISLEMMERKEZI: TButton;
    txtKOD1: TEdit;
    btnKOD1: TButton;
    txtKOD2: TEdit;
    btnKOD2: TButton;
    txtKOD3: TEdit;
    btnKOD3: TButton;
    txtKOD4: TEdit;
    btnKOD4: TButton;
    frxIBODts_Ma_H_grp: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
    IB_Query2: TIB_Query;
    frxIBODts_Ma_H_grpsz: TfrxIBODataset;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(strSQL:String);
    procedure frmRaporCiktisi_Open_Gruplu;
    procedure yaz();
    procedure Alan_isimlerini_ekle;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpIslemTar1Enter(Sender: TObject);
    procedure dtpIslemTar1Exit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure chkDEVIREnter(Sender: TObject);
    procedure chkDEVIRExit(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtGrpKodEnter(Sender: TObject);
    procedure txtGrpKodExit(Sender: TObject);
    procedure txtGrpKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMasrafGrpListeClick(Sender: TObject);
    procedure txtGrpKodKeyPress(Sender: TObject; var Key: Char);
    procedure btnISLEMMERKEZIClick(Sender: TObject);
    procedure btnKOD1Click(Sender: TObject);
    procedure btnKOD2Click(Sender: TObject);
    procedure btnKOD3Click(Sender: TObject);
    procedure btnKOD4Click(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure txtKOD1Exit(Sender: TObject);
    procedure txtKOD2Exit(Sender: TObject);
    procedure txtKOD3Exit(Sender: TObject);
    procedure txtKOD4Exit(Sender: TObject);
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKOD1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKOD2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKOD3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKOD4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure btn_FastClick(Sender: TObject);
    procedure IB_Query2CalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
  private
    { Private declarations }
    row,col:integer;
    Prv_Yazdirildi:Boolean;
  public
    { Public declarations }
  end;
  const cns_masraf_hareket_tarihli = 21;
var
  frmRaporMasrafHareketTarihli: TfrmRaporMasrafHareketTarihli;

implementation

{$R *.dfm}
uses unDataMod,ufrmRaporCiktisi,unFunc,main;

procedure TfrmRaporMasrafHareketTarihli.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if DataMod.Modul_Hak(cns_masraf_hareket_tarihli,local_CanUpdate,local_CanDelete) = False then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporMasrafHareketTarihli') then
    begin
      Application.CreateForm(TfrmRaporMasrafHareketTarihli,frmRaporMasrafHareketTarihli);
      with frmRaporMasrafHareketTarihli do
      begin
        PageControl1.ActivePageIndex := 0;
        dtpIslemTar1.Date := glb_DONEM_BAS;
        dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;

  {$IfDef TRANSPORT}
        TabSheet2.Visible := false;
  {$EndIf}
      end;

      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporMasrafHareketTarihli.cmbSube.Items);
          with frmRaporMasrafHareketTarihli do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporMasrafHareketTarihli.cmbSube do
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
        frmRaporMasrafHareketTarihli.grpSube.Visible := False;
      end;//end else if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryToplam.Close;
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporMasrafHareketTarihli.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporMasrafHareketTarihli.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporMasrafHareketTarihli);
end;

procedure TfrmRaporMasrafHareketTarihli.dtpIslemTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareketTarihli.dtpIslemTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporMasrafHareketTarihli.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareketTarihli.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporMasrafHareketTarihli.chkDEVIREnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareketTarihli.chkDEVIRExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporMasrafHareketTarihli.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID : String;
begin
  case frmRaporCiktisi.Tarih_Karsilastir(dtpIslemTar1.Date,dtpIslemTar2.Date) of
  2:
    begin
      Application.MessageBox('Ýkinci iþlem tarihi birinci tarihten küçük olamaz.Lütfen iþlem tarihlerini kontrol ediniz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
  end;

  if Length(Trim(txtGrpKod.Text)) <> 0 then
  begin
    frmRaporCiktisi_Open_Gruplu;
  end
  else
  begin
    strSQL := 'SELECT MASRAFHAR.MASRAF_KOD'
            + ',(SELECT MASRAF.ADI FROM MASRAF WHERE MASRAF.MASRAF_KOD=MASRAFHAR.MASRAF_KOD) as MASRAF_AD'
            + ',MASRAFHAR.BELGE_ID'
            + ',MASRAFHAR.BA'
            + ',MASRAFHAR.KOD1'
            + ',MASRAFHAR.TUTAR_VPB AS TOPLAM'
            + ',MASRAFHAR.TARIH'
            + ',MASRAFHAR.ACIKLAMA'
            + ',MASRAFHAR.MASRAF_MERK'
            + ',MASRAFHAR.BELGE_TUR'
            + ' FROM MASRAFHAR'
            + ' WHERE MASRAFHAR.TARIH BETWEEN ' + SQL_Tarih(dtpIslemTar1.Date) + ' AND ' + SQL_Tarih(dtpIslemTar2.Date);
////////////////////////////////////////////////////////////////////////////////
    if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND MASRAFHAR.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
    end;
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    if Length(Trim(txtKOD1.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND MASRAFHAR.KOD1 = '+ SQL_Katar(txtKOD1.Text);
    end;
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    if Length(Trim(txtKOD2.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND MASRAFHAR.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
    end;
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    if Length(Trim(txtKOD3.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND MASRAFHAR.KOD3 = ' + SQL_Katar(txtKOD3.Text);
    end;
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    if Length(Trim(txtKOD4.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND MASRAFHAR.KOD4 = ' + SQL_Katar(txtKOD4.Text);
    end;
////////////////////////////////////////////////////////////////////////////////

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
    strSQL := strSQL + ' ORDER BY MASRAFHAR.TARIH';
    frmRaporCiktisi_Open(strSQL);
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.frmRaporCiktisi_Open(strSQL: String);
var
  CHeader : TcxSSHeader;
begin
  with qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if (qryRapor.Eof and qryRapor.Bof)then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    exit;
  end
  else
  begin
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;
    frmRaporCiktisi.SetCellFormat(1,3,1,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    frmRaporCiktisi.SetCellAlignment(0,2,0,2,haright,vaCenter);
    frmRaporCiktisi.SetCellAlignment(2,2,2,2,haright,vaCenter);
    frmRaporCiktisi.SetCellAlignment(5,2,8,2,haright,vaCenter);
    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[1] := 100;
    CHeader.Size[2] := 300;
    CHeader.Size[3] := 100;
    CHeader.Size[4] := 250;
    CHeader.Size[5] := 125;
    CHeader.Size[6] := 125;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
    qryToplam.Close;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.yaz;
var
  baslik_yazildi : Boolean;
  res_Cari : TStringList;
  SubeID : String;
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
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(1,0,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(0,1,0,1,[fsBold],8,'MS Sans Serif',0);
  Inc(row);
  Alan_isimlerini_ekle;

  if chkDEVIR.Checked then
  begin
    with qryToplam do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM MASRAF WHERE (DEVREDEN_BORC-DEVREDEN_ALACAK) <> 0');
      Active := True;
    end;
    qryToplam.First;
    while not (qryToplam.Eof) do
    begin
      col :=  0;
      DataMod.Rapor_Satir_Renklendir(col,row,9);
      Inc(row);
      frmRaporCiktisi.SetCellDate(col,row,glb_DONEM_BAS);
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('MASRAF_KOD').AsString);
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('ADI').AsString);
      Inc(col,2);
      frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,'0');
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,'DEVÝR KAYDI');

      if qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency > qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency then
      begin
        frmRaporCiktisi.SetCellText(row,col-3,'B');
        Inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency - qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency));
        Inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,'0');
      end
      else
      if qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency < qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency then
      begin
        frmRaporCiktisi.SetCellText(row,col-3,'A');
        Inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,'0');
        Inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency - qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency));
      end
      else
      begin
        Inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,'0');
        Inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,'0');
      end;
      qryToplam.Next;
    end;
    Inc(row);
  end;

  if not chkDEVIR.Checked then Inc(row);
  qryRapor.First;
  while not (qryRapor.Eof) do
  begin
    col :=  0;
    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TARIH').AsDate);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MASRAF_KOD').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MASRAF_AD').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BA').AsString);
    Inc(col);
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
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
      end;
    end;//end case
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    Inc(col);
    if qryRapor.FieldByName('BA').AsString = 'B' then
    begin
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TOPLAM').AsString);
      Inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,'0');
    end;
    if qryRapor.FieldByName('BA').AsString = 'A' then
    begin
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,'0');
      Inc(col);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TOPLAM').AsString);
    end;
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MASRAF_MERK').AsString);
    Inc(row);
    qryRapor.Next;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.Alan_isimlerini_ekle;
begin
  Inc(row);
  frmRaporCiktisi.SetCellText(row,col,'TARÝH');
  frmRaporCiktisi.SetCellText(row,col+1,'MASRAF KODU');
  frmRaporCiktisi.SetCellText(row,col+2,'ADI');
  frmRaporCiktisi.SetCellText(row,col+3,'TÝP');
  frmRaporCiktisi.SetCellText(row,col+4,'BELGE TÜRÜ');
  frmRaporCiktisi.SetCellText(row,col+5,'FÝÞ NUMARASI');
  frmRaporCiktisi.SetCellText(row,col+6,'AÇIKLAMA');
  frmRaporCiktisi.SetCellText(row,col+7,'BORÇ');
  frmRaporCiktisi.SetCellText(row,col+8,'ALACAK');
  frmRaporCiktisi.SetCellText(row,col+9,'ÝÞLEM MERKEZÝ');
  frmRaporCiktisi.SetCellFont(col,row,col+9,row,[fsBold],8,'MS Sans Serif',4);
  col := 0;
end;


procedure TfrmRaporMasrafHareketTarihli.FormKeyPress(Sender: TObject;
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

procedure TfrmRaporMasrafHareketTarihli.txtGrpKodEnter(Sender: TObject);
begin
  txtGrpKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareketTarihli.txtGrpKodExit(Sender: TObject);
var
  MasrafGrpAd : String;
begin
  if Length(Trim(txtGrpKod.Text))=0 then
  begin
    txtGrpKod.Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('MASRAF_GRUP','MASRAF_GRUP_KOD','MASRAF_GRUP_ADI',txtGrpKod.Text,MasrafGrpAd)) then
  begin
    Application.MessageBox('Girdiðiniz masraf grup kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    txtGrpKod.Clear;
    txtGrpKod.SetFocus;
  end
  else
  begin
    txtGrpKod.Color := clWindow;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.txtGrpKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
  begin
    btnMasrafGrpListeClick(Self);
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.btnMasrafGrpListeClick(Sender: TObject);
var
  KOD,AD : String;
begin
  if DataMod.LS_MasrafGroup(KOD,AD) then
  begin
    txtGrpKod.Text := KOD;
  end;
end;


procedure TfrmRaporMasrafHareketTarihli.txtGrpKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporMasrafHareketTarihli.frmRaporCiktisi_Open_Gruplu;
var
  CHeader : TcxSSHeader;
  qryMasraf:TIB_Cursor;
  strSQL,SubeID : String;
  baslik_yazildi : Boolean;
  res_Cari : TStringList;
  bakiye : Currency;
begin
//****************************************************************************//
  strSQL := 'SELECT MASRAF_KOD FROM MASRAF_GRUP_UYE'
          + ' LEFT OUTER JOIN MASRAF_GRUP ON (MASRAF_GRUP.MASRAF_GRUP_KOD = MASRAF_GRUP_UYE.MASRAF_GRUP_KOD)'
          + ' WHERE MASRAF_GRUP.MASRAF_GRUP_KOD ='+SQL_Katar(txtGrpKod.Text);
  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      strSQL := strSQL + ' AND MASRAF_GRUP.MASRAF_GRUP_SID = '+ SubeID;
    end;
  end
  else
  begin
    strSQL := strSQL + ' AND MASRAF_GRUP.MASRAF_GRUP_SID = '+ inttostr(glb_SID);
  end;
  strSQL := strSQL + ' ORDER BY MASRAF_GRUP_UYE.MASRAF_KOD';
//****************************************************************************//
  DataMod.CreateCursor(qryMasraf,nil,False,DataMod.dbaMain);
  with qryMasraf do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  end;
//****************************************************************************//
  if (qryMasraf.Eof and qryMasraf.Bof) then
  begin
    qryMasraf.Close;
    Application.MessageBox('Ýstenilen gruba ait masraf kodu bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;
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
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(1,0,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(0,1,0,1,[fsBold],8,'MS Sans Serif',0);
  Inc(row);
//****************************************************************************//
  Inc(row);
  frmRaporCiktisi.SetCellText(row,col,'MASRAF KODU');
  frmRaporCiktisi.SetCellText(row,col+1,'ADI');
  frmRaporCiktisi.SetCellText(row,col+2,'BORÇ');
  frmRaporCiktisi.SetCellText(row,col+3,'ALACAK');
  frmRaporCiktisi.SetCellText(row,col+4,'TÝP');
  frmRaporCiktisi.SetCellText(row,col+5,'BAKÝYE');
  frmRaporCiktisi.SetCellFont(col,row,col+5,row,[fsBold],8,'MS Sans Serif',4);
  Inc(row);
//****************************************************************************//
  qryMasraf.First;
  while not qryMasraf.Eof do
  begin
    strSQL := 'SELECT'
            + ' MASRAF.MASRAF_KOD,'
            + 'MASRAF.ADI,'
            + 'MASRAF.DEVREDEN_ALACAK,'
            + 'MASRAF.DEVREDEN_BORC,'
            + '(SELECT SUM(MASRAFHAR.TUTAR_VPB) FROM MASRAFHAR'
            + ' LEFT OUTER JOIN MASRAF ON (MASRAF.MASRAF_KOD = MASRAFHAR.MASRAF_KOD)'
            + ' WHERE MASRAFHAR.BA = ' + SQL_Katar('B')
            + ' AND MASRAFHAR.TARIH BETWEEN ' + SQL_Tarih(dtpIslemTar1.Date) + ' AND ' + SQL_Tarih(dtpIslemTar2.Date)
            + ' AND MASRAFHAR.MASRAF_KOD = ' + SQL_Katar(qryMasraf.FieldByName('MASRAF_KOD').AsString)
            + ') AS BORC,'
            + '(SELECT SUM(MASRAFHAR.TUTAR_VPB) FROM MASRAFHAR'
            + ' LEFT OUTER JOIN MASRAF ON (MASRAF.MASRAF_KOD = MASRAFHAR.MASRAF_KOD)'
            + ' WHERE MASRAFHAR.BA = ' + SQL_Katar('A')
            + ' AND MASRAFHAR.TARIH BETWEEN ' + SQL_Tarih(dtpIslemTar1.Date)+' AND ' + SQL_Tarih(dtpIslemTar2.Date)
            + ' AND MASRAFHAR.MASRAF_KOD = ' + SQL_Katar(qryMasraf.FieldByName('MASRAF_KOD').AsString)
            + ') AS ALACAK'
            + ' FROM MASRAF'
            + ' WHERE MASRAF.MASRAF_KOD = ' + SQL_Katar(qryMasraf.FieldByName('MASRAF_KOD').AsString);
    with qryRapor do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    end;
//****************************************************************************//
    qryRapor.First;
    while not (qryRapor.Eof) do
    begin
      col :=  0;
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MASRAF_KOD').AsString);
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADI').AsString);
      Inc(col);
      bakiye := (qryRapor.FieldByName('DEVREDEN_BORC').AsCurrency+qryRapor.FieldByName('BORC').AsCurrency);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(bakiye));
      Inc(col);
      bakiye := (qryRapor.FieldByName('DEVREDEN_ALACAK').AsCurrency+qryRapor.FieldByName('ALACAK').AsCurrency);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(bakiye));
      Inc(col);
      if (qryRapor.FieldByName('DEVREDEN_BORC').AsCurrency+qryRapor.FieldByName('BORC').AsCurrency)
      > (qryRapor.FieldByName('DEVREDEN_ALACAK').AsCurrency+qryRapor.FieldByName('ALACAK').AsCurrency) then
      begin
        frmRaporCiktisi.SetCellText(row,col,'B');
        inc(col);
        bakiye := (qryRapor.FieldByName('DEVREDEN_BORC').AsCurrency+qryRapor.FieldByName('BORC').AsCurrency)
                - (qryRapor.FieldByName('DEVREDEN_ALACAK').AsCurrency+qryRapor.FieldByName('ALACAK').AsCurrency);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(bakiye));
      end
      else
      if (qryRapor.FieldByName('DEVREDEN_ALACAK').AsCurrency+qryRapor.FieldByName('ALACAK').AsCurrency)
      > (qryRapor.FieldByName('DEVREDEN_BORC').AsCurrency+qryRapor.FieldByName('BORC').AsCurrency) then
      begin
        frmRaporCiktisi.SetCellText(row,col,'A');
        inc(col);
        bakiye := (qryRapor.FieldByName('DEVREDEN_ALACAK').AsCurrency+qryRapor.FieldByName('ALACAK').AsCurrency)
                - (qryRapor.FieldByName('DEVREDEN_BORC').AsCurrency+qryRapor.FieldByName('BORC').AsCurrency);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(bakiye));
      end
      else
      if (qryRapor.FieldByName('DEVREDEN_ALACAK').AsCurrency+qryRapor.FieldByName('ALACAK').AsCurrency)
      = (qryRapor.FieldByName('DEVREDEN_BORC').AsCurrency+qryRapor.FieldByName('BORC').AsCurrency) then
      begin
        frmRaporCiktisi.SetCellText(row,col,'');
        inc(col);
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        frmRaporCiktisi.SetCellText(row,col,'0');
      end;
      qryRapor.Next;
    end;
    Inc(row);
    qryMasraf.Next;
  end;
  frmRaporCiktisi.SetCellFormat(0,3,1,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
  frmRaporCiktisi.SetCellAlignment(0,2,0,2,haright,vaCenter);
  frmRaporCiktisi.SetCellAlignment(2,2,2,2,haright,vaCenter);
  frmRaporCiktisi.SetCellAlignment(5,2,8,2,haright,vaCenter);
  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[0] := 120;
  CHeader.Size[1] := 250;
  CHeader.Size[2] := 120;
  CHeader.Size[3] := 120;
  CHeader.Size[4] := 50;
  CHeader.Size[5] := 120;
  CHeader.Size[6] := 120;
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
  qryRapor.Close;
end;

procedure TfrmRaporMasrafHareketTarihli.btnISLEMMERKEZIClick( Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.btnKOD1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.btnKOD2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.btnKOD3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.btnKOD4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.txtISLEMMERKEZIEnter( Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafHareketTarihli.txtISLEMMERKEZIExit( Sender: TObject);
begin
  if Length(trim(Self.txtISLEMMERKEZI.Text)) = 0 then
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

procedure TfrmRaporMasrafHareketTarihli.txtKOD1Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD1.Text)) = 0 then
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

procedure TfrmRaporMasrafHareketTarihli.txtKOD2Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD2.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD2,2) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD2.SetFocus;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.txtKOD3Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD3.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD3,3) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD3.SetFocus;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.txtKOD4Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD4.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD4,4) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD4.SetFocus;
  end;
end;

procedure TfrmRaporMasrafHareketTarihli.txtISLEMMERKEZIKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnISLEMMERKEZIClick(Self);
end;

procedure TfrmRaporMasrafHareketTarihli.txtKOD1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD1Click(Self);
end;

procedure TfrmRaporMasrafHareketTarihli.txtKOD2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD2Click(Self);
end;

procedure TfrmRaporMasrafHareketTarihli.txtKOD3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD3Click(Self);
end;

procedure TfrmRaporMasrafHareketTarihli.txtKOD4KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD4Click(Self);
end;

procedure TfrmRaporMasrafHareketTarihli.frxReport1BeforePrint(
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
      {
       c:=(frxReport1.FindComponent('Memo1') as TfrxMemoView);
       c.memo.Text:=txtMasrafKod.Text;
        }
       {c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
       }
       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);
       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
       Prv_Yazdirildi:=True;
    end;
end;

procedure TfrmRaporMasrafHareketTarihli.btn_FastClick(Sender: TObject);
var
   sqlstr:String;
begin
   if Trim(txtGrpKod.Text)='' then
   begin
      if chkDEVIR.checked then
      begin
         sqlstr:=
         'SELECT '+
         'MASRAF_KOD, '+
         'CAST(''01.01.2007'' AS DATE) TARIH, '+
         'CAST(0 AS INTEGER) MASRAFHAR_ID, '+
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

         'union  '+
         'SELECT '+
         'MASRAF_KOD, '+
         'CAST(''01.01.2007'' AS DATE) TARIH, '+
         'CAST(0 AS INTEGER) MASRAFHAR_ID, '+
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
         '(SELECT SUM(TUTAR_VPB) FROM MASRAFHAR WHERE (MASRAFHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and MASRAFHAR.MASRAF_KOD =MASRAF.MASRAF_KOD and MASRAFHAR.BA=''B'') CBorc, '+
         '(SELECT SUM(TUTAR_VPB) FROM MASRAFHAR WHERE (MASRAFHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and MASRAFHAR.MASRAF_KOD =MASRAF.MASRAF_KOD and MASRAFHAR.BA=''A'') CAlacak '+
         'FROM MASRAF '+

         'union  '+
         'SELECT '+
         'MASRAFHAR.MASRAF_KOD, '+
         'MASRAFHAR.TARIH, '+
         'MASRAFHAR.MASRAFHAR_ID, '+
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
         ' WHERE (MASRAFHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+') ';


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
         ' ORDER BY MASRAFHAR.TARIH,MASRAFHAR.MASRAFHAR_ID ASC';
      end;
   end;


   if Trim(txtGrpKod.Text)<>'' then
   begin

      sqlstr:=
      'SELECT '+
      'MASRAFHAR.MASRAF_KOD '+
      ',sum(case when  MASRAFHAR.BA=''B'' then '+
      'MASRAFHAR.TUTAR_VPB else 0 end) CBorc '+
      ',Sum(case when  MASRAFHAR.BA=''A'' then '+
      'MASRAFHAR.TUTAR_VPB else 0 end) CAlacak '+
      'FROM MASRAFHAR '+
      'group by MASRAFHAR.MASRAF_KOD ';
       with IB_Query2 do
       begin
         Active := false;
         SQL.Clear;
         SQL.Add(sqlstr);
         Active := True;
       end;

       if ((IB_Query2.Eof) and (IB_Query2.bof))then
       begin
         Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý. Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
         IB_Query2.Close;
         Exit;
       end;

       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Masraf_Hareket_grp.fr3');
       frxReport1.showReport;
       exit;

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
    frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Masraf_Hareket_grpsuz.fr3');

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

procedure TfrmRaporMasrafHareketTarihli.IB_Query2CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin

    if ARow.ByName('CBORC').AsFloat>ARow.ByName('CALACAK').AsFloat then
    begin
      ARow.ByName('TIP').AsString :='BORC';
      ARow.ByName('BAKIYE').AsFloat :=ARow.ByName('CBORC').AsFloat-ARow.ByName('CALACAK').AsFloat;
    end;
    if ARow.ByName('CALACAK').AsFloat>ARow.ByName('CBORC').AsFloat then
    begin
      ARow.ByName('TIP').AsString :='ALACAK';
      ARow.ByName('BAKIYE').AsFloat :=ARow.ByName('CALACAK').AsFloat-ARow.ByName('CBORC').AsFloat;
    end;

    with qryToplam do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('SELECT ADI FROM MASRAF WHERE MASRAF_KOD= '+Sql_Katar(ARow.ByName('MASRAF_KOD').AsString));
      Active := true;
    end;

    ARow.ByName('CALC_MASRAFADI').AsString :=qryToplam.FieldByName('ADI').AsString;
end;

procedure TfrmRaporMasrafHareketTarihli.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
var
   SubeID:String;
begin
     if ARow.ByName('BELGE_TUR').AsInteger>0 then
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('BELGE_TUR').AsInteger);

    with qryToplam do
    begin
      Active := false;
      SQL.Clear;
      SQL.Add('SELECT ADI FROM MASRAF WHERE MASRAF_KOD= '+Sql_Katar(ARow.ByName('MASRAF_KOD').AsString));
      Active := true;
    end;

    ARow.ByName('CALC_MASRAFADI').AsString :=qryToplam.FieldByName('ADI').AsString;

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
