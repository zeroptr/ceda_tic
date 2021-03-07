unit ufrmRaporPlasiyerHareketleri;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, IB_Components, StdCtrls, Buttons, ComCtrls, frxClass, frxIBOSet,
  cxSSTypes,cxSSHeaders;

type
  TfrmRaporPlasiyerHareketleri = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    qryRapor: TIB_Cursor;
    qryPlasiyer: TIB_Query;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    txtPlasiyerKod1: TEdit;
    Button1: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    frxIBODts_Plasiyer_Har: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
///user defined procedures and functions
//start
    procedure alan_isimlerini_ekle;
    procedure yaz;
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(strSQL:String);
    procedure kod_cikis(kod : TEdit);
//stop
    procedure btnRaporClick(Sender: TObject);
    procedure txtPlasiyerKod1KeyPress(Sender: TObject; var Key: Char);
    procedure txtPlasiyerKod1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure txtPlasiyerKod1KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtPlasiyerKod1Enter(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure btn_FastClick(Sender: TObject);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);

  private
    row,col:integer;
    prv_borc,prv_alacak : Currency;
    dvr_borc,dvr_alacak : Currency;
    prv_dovkod : String;
    Prv_Yazdirildi:Boolean;
    sqlstr:String;
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_plasiyer_hareketleri = 10;

var
  frmRaporPlasiyerHareketleri: TfrmRaporPlasiyerHareketleri;

implementation

uses unDataMod, unFunc, ufrmRaporCiktisi,main;
{$R *.dfm}

procedure TfrmRaporPlasiyerHareketleri.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_plasiyer_hareketleri,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporPlasiyerHareketleri') then
    begin
      Application.CreateForm(TfrmRaporPlasiyerHareketleri,frmRaporPlasiyerHareketleri);
      frmRaporPlasiyerHareketleri.dtpIslemTar1.Date := glb_DONEM_BAS;
      frmRaporPlasiyerHareketleri.dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporPlasiyerHareketleri.cmbSube.Items);
          with frmRaporPlasiyerHareketleri do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporPlasiyerHareketleri.cmbSube do
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
        frmRaporPlasiyerHareketleri.grpSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;


procedure TfrmRaporPlasiyerHareketleri.frmRaporCiktisi_Open(strSQL : String);
begin
  with frmRaporPlasiyerHareketleri.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;
  if ((frmRaporPlasiyerHareketleri.qryRapor.Eof) and (frmRaporPlasiyerHareketleri.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz','Dikkat',MB_ICONWARNING);
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
      frmRaporCiktisi.SetCellFont(0,2,1,2,[fsBold],8,'MS Sans Serif',2);
      frmRaporCiktisi.SetCellAlignment(0,3,0,3,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(1,3,1,3,haLEFT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(2,3,2,3,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(5,3,5,3,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(7,3,8,3,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellFont(0,3,8,3,[fsBold],8,'MS Sans Serif',4);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,1,1,[fsBold],8,'MS Sans Serif',2);
      frmRaporCiktisi.SetCellAlignment(0,2,0,2,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(1,2,1,2,haLEFT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(2,2,2,2,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(5,2,5,2,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(7,2,8,2,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellFont(0,2,8,2,[fsBold],8,'MS Sans Serif',4);
    end;
    prv_borc := prv_borc + dvr_borc;
    prv_alacak := prv_alacak + dvr_alacak;
    inc(row);
    frmRaporCiktisi.SetCellText(row,3,'Borç');
    frmRaporCiktisi.SetCellText(row,4,'Alacak');
    frmRaporCiktisi.SetCellText(row,5,'Bakiye');
    inc(row);
    frmRaporCiktisi.SetCellText(row,3,CurrToStr(prv_borc));
    frmRaporCiktisi.SetCellFormat(3,row,3,row,3);
    frmRaporCiktisi.SetCellText(row,4,CurrToStr(prv_alacak));
    frmRaporCiktisi.SetCellFormat(4,row,4,row,3);
    frmRaporCiktisi.SetCellFormat(5,row,5,row,3);

    if prv_borc > prv_alacak then
    begin
      frmRaporCiktisi.SetCellText(row,5,CurrToStr(prv_borc - prv_alacak));
    end
    else
    if prv_borc < prv_alacak then
    begin
      frmRaporCiktisi.SetCellText(row,5,CurrToStr(prv_alacak - prv_borc));
    end
    else
    begin
      frmRaporCiktisi.SetCellText(row,5,'0');
    end;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
    qryPlasiyer.Close;
  end;
end;

procedure TfrmRaporPlasiyerHareketleri.yaz;
var
  res_Cari : TStringList;
  SubeID : String;
begin
  row := 0;
  col := 0;
  dvr_borc := 0;
  dvr_alacak := 0;
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
  frmRaporCiktisi.SetCellText(row,col+2,'PLASÝYER HAREKETLERÝ LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  inc(row);
  col := 0;
////////////////////////////////////////////////////////////////////////////////
  frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PLASIYER_KOD').AsString);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADISOY').AsString);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,glb_DEFCUR);
////////////////////////////////////////////////////////////////////////////////
  col := 0;
  alan_isimlerini_ekle;
  with qryPlasiyer do
  begin
    if Active then Active := false;
    SQL.Clear;
    SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM PLASIYER WHERE PLASIYER_KOD=' + SQL_Katar(txtPlasiyerKod1.Text));
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add(' AND PLASIYER.PLASIYER_SID = ' + SubeID);
      end;
    end
    else
    begin
      SQL.Add(' AND PLASIYER.PLASIYER_SID = ' + inttostr(glb_SID));
    end;
    Active := True;
    dvr_borc := FieldByName('DEVREDEN_BORC').AsCurrency;
    dvr_alacak := FieldByName('DEVREDEN_ALACAK').AsCurrency;
    Active := False;
  end;

  if dvr_borc > dvr_alacak then
  begin
    dvr_borc := dvr_borc - dvr_alacak;
    dvr_alacak := 0;
    col := 3;
    frmRaporCiktisi.SetCellText(row,col,'Borç');
    col := 4;
    frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
    col := 8;
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(dvr_borc));
    inc(row);
  end
  else
  if dvr_borc < dvr_alacak then
  begin
    dvr_alacak := dvr_alacak - dvr_borc;
    dvr_borc := 0;
    col := 3;
    frmRaporCiktisi.SetCellText(row,col,'Alacak');
    col := 4;
    frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
    col := 8;
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(dvr_alacak));
    inc(row);
  end
  else
  if dvr_borc = dvr_alacak then
  begin
    dvr_borc := 0;
    dvr_alacak := 0;
  end;
  qryRapor.First;
  while not qryRapor.Eof do
  begin
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,5);

    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TARIH').AsDateTime);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRapor.FieldByName('BELGE_TUR').AsInteger));
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
    inc(col);
    if qryRapor.FieldByName('TIP').AsString = 'A' then
    begin
      frmRaporCiktisi.SetCellText(row,col,'ALACAK');
      inc(col);
    end;
    if qryRapor.FieldByName('TIP').AsString = 'B' then
    begin
      frmRaporCiktisi.SetCellText(row,col,'BORÇ');
      inc(col);
    end;
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    inc(col);

    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    if qryRapor.FieldByName('TIP').AsString = 'A' then
    begin
      prv_alacak := prv_alacak + qryRapor.FieldByName('TUTAR_VPB').AsCurrency;
    end;
    if qryRapor.FieldByName('TIP').AsString = 'B' then
    begin
      prv_borc := prv_borc + qryRapor.FieldByName('TUTAR_VPB').AsCurrency;
    end;
    inc(row);
    qryRapor.Next;
  end;
end;




procedure TfrmRaporPlasiyerHareketleri.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Tarih');
  frmRaporCiktisi.SetCellText(row,col+1,'Belge Türü');
  frmRaporCiktisi.SetCellText(row,col+2,'Fiþ Numarasý');
  frmRaporCiktisi.SetCellText(row,col+3,'Tip');
  frmRaporCiktisi.SetCellText(row,col+4,'Açýklama');
  frmRaporCiktisi.SetCellText(row,col+5,'Tutar');
  frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
  inc(row);
end;

procedure TfrmRaporPlasiyerHareketleri.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryRapor.Close;
  qryPlasiyer.Close;
  Action := caFree;
end;

procedure TfrmRaporPlasiyerHareketleri.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID:String;
begin
  if (Length(Trim(txtPlasiyerKod1.Text)) = 0) then
  begin
    Application.MessageBox('Lütfen bir plasiyer seçiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  prv_borc := 0;
  prv_alacak := 0;

  strSQL := 'SELECT PLASIYER.PLASIYER_KOD'
           +',PLASIYER.ADISOY'
//           +',BELGETUR.ADI'
           +',CARIHAR.BELGE_TUR'
           +',CARIHAR.BELGE_ID'
           +',CARIHAR.TARIH'
           +',CARIHAR.DOV_BAZ_TAR'
           +',CARIHAR.TIP'
           +',CARIHAR.DOVKOD'
           +',CARIHAR.TUTAR'
           +',CARIHAR.ACIKLAMA'
           +',CARIHAR.DOVKUR'
           +',(case when  CARIHAR.TIP=''B'' then '
           +'CARIHAR.TUTAR_VPB else 0 end) CBorc '
           +',(case when  CARIHAR.TIP=''A'' then '
           +'CARIHAR.TUTAR_VPB else 0 end ) CAlacak '
           +',CARIHAR.TUTAR_VPB FROM PLASIYER'
           +' INNER JOIN CARIHAR ON (CARIHAR.PLASIYER_KOD = PLASIYER.PLASIYER_KOD)'
//           +' INNER JOIN BELGETUR ON (CARIHAR.BELGE_TUR=BELGETUR.BELGE_TUR)'
           +' WHERE PLASIYER.PLASIYER_KOD =' + SQL_Katar(txtPlasiyerKod1.Text)
           + ' and (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';
           if glb_SUBELI then
           begin
             SubeID := DataMod.SubeAd2ID(cmbSube.Text);
             if SubeID <> '0' then
             begin
               strSQL := strSQL + ' AND PLASIYER.PLASIYER_SID = ' + SubeID;
             end;
           end
           else
           begin
             strSQL := strSQL + ' AND PLASIYER.PLASIYER_SID = ' + inttostr(glb_SID);
           end;
  strSQL := strSQL + ' ORDER BY CARIHAR.TARIH,CARIHAR.CARIHAR_ID';


  frmRaporCiktisi_Open(strSQL);
  strSQL := '';
end;

procedure TfrmRaporPlasiyerHareketleri.txtPlasiyerKod1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;



procedure TfrmRaporPlasiyerHareketleri.kod_cikis(kod : TEdit);
var
  PlasiyerAd : String;
begin
  if Length(Trim(kod.Text)) = 0 then
  begin
    kod.Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',kod.Text,PlasiyerAd) then
  begin
    Application.MessageBox('Plasiyer kodu bulunamadý.Lütfen listeden seçiniz.','DÝKKAT',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;

procedure TfrmRaporPlasiyerHareketleri.txtPlasiyerKod1Exit(Sender: TObject);
begin
  kod_cikis(txtPlasiyerKod1);
end;

procedure TfrmRaporPlasiyerHareketleri.Button1Click(Sender: TObject);
var
  PlasiyerKOD,PlasiyerAD : String;
begin
  if DataMod.LS_Plasiyer(PlasiyerKOD,PlasiyerAD,0) Then txtPlasiyerKod1.Text := PlasiyerKod;
end;

procedure TfrmRaporPlasiyerHareketleri.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporPlasiyerHareketleri.txtPlasiyerKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button1Click(Self);
end;

procedure TfrmRaporPlasiyerHareketleri.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporPlasiyerHareketleri.txtPlasiyerKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPlasiyerHareketleri.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPlasiyerHareketleri.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporPlasiyerHareketleri.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPlasiyerHareketleri.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporPlasiyerHareketleri.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporPlasiyerHareketleri);
end;

procedure TfrmRaporPlasiyerHareketleri.frxReport1BeforePrint(
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
       end;
        }


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);


       c:=(frxReport1.FindComponent('Memo1') as TfrxMemoView);
       c.memo.Text:=txtPlasiyerKod1.Text;

       {c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
       }


      { d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
      }

       Prv_Yazdirildi:=True;
    end;


end;

procedure TfrmRaporPlasiyerHareketleri.btn_FastClick(Sender: TObject);
var
  strSQLD:String;
  SubeID:String;
begin
  if (Length(Trim(txtPlasiyerKod1.Text)) = 0) then
  begin
    Application.MessageBox('Lütfen bir plasiyer seçiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;


           strSQLd :=
           'SELECT PLASIYER.PLASIYER_KOD'
           +',PLASIYER.ADISOY'
           +',CAST(''01.01.2007'' AS DATE) TARIH'
           +',CAST(0 AS INTEGER) BELGE_ID'
           +',CAST(0 AS INTEGER) BELGE_TUR'
           +',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
           +',CAST('''' AS CHAR(1)) TIP'
           +',CAST('''' AS VARCHAR(5)) DOVKOD'
           +',CAST(0 AS NUMERIC(18,4)) TUTAR'
           +',CAST(''Önceki Tarihten Hesaplanan'' AS VARCHAR(100)) ACIKLAMA'
           +',CAST(0 AS NUMERIC(18,4)) DOVKUR'
           + ', (SELECT SUM(TUTAR_VPB) FROM CARIHAR WHERE (CARIHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and CARIHAR.PLASIYER_KOD =PLASIYER.PLASIYER_KOD and CARIHAR.TIP=''B'') CBorc '
           + ', (SELECT SUM(TUTAR_VPB) FROM CARIHAR WHERE (CARIHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and CARIHAR.PLASIYER_KOD =PLASIYER.PLASIYER_KOD and CARIHAR.TIP=''A'') CAlacak '
           +',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB FROM PLASIYER'
           +' WHERE PLASIYER.PLASIYER_KOD =' + SQL_Katar(txtPlasiyerKod1.Text);

           if glb_SUBELI then
           begin
             SubeID := DataMod.SubeAd2ID(cmbSube.Text);
             if SubeID <> '0' then
             begin
               strSQLd := strSQLd + ' AND PLASIYER.PLASIYER_SID = ' + SubeID;
             end;
           end
           else
           begin
             strSQLd := strSQLd + ' AND PLASIYER.PLASIYER_SID = ' + inttostr(glb_SID);
           end;

           strSQLd := strSQLd
           +' GROUP BY PLASIYER.PLASIYER_KOD,PLASIYER.ADISOY '
           +' UNION ';

           strSQLd := strSQLd+
           'SELECT PLASIYER.PLASIYER_KOD'
           +',PLASIYER.ADISOY'
           +',CAST(''01.01.2007'' AS DATE) TARIH'
           +',CAST(0 AS INTEGER) BELGE_ID'
           +',CAST(0 AS INTEGER) BELGE_TUR'
           +',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
           +',CAST('''' AS CHAR(1)) TIP'
           +',CAST('''' AS VARCHAR(5)) DOVKOD'
           +',CAST(0 AS NUMERIC(18,4)) TUTAR'
           +',CAST(''DEVÝR'' AS VARCHAR(100)) ACIKLAMA'
           +',CAST(0 AS NUMERIC(18,4)) DOVKUR'
           +',PLASIYER.DEVREDEN_BORC_VPB CBORC'
           +',PLASIYER.DEVREDEN_ALACAK_VPB CALACAK'
           +',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB FROM PLASIYER'
           +' WHERE PLASIYER.PLASIYER_KOD =' + SQL_Katar(txtPlasiyerKod1.Text);
           if glb_SUBELI then
           begin
             SubeID := DataMod.SubeAd2ID(cmbSube.Text);
             if SubeID <> '0' then
             begin
               strSQLd := strSQLd + ' AND PLASIYER.PLASIYER_SID = ' + SubeID;
             end;
           end
           else
           begin
             strSQLd := strSQLd + ' AND PLASIYER.PLASIYER_SID = ' + inttostr(glb_SID);
           end;


           strSQLd :=strSQLd+ ' UNION '+
           ' SELECT PLASIYER.PLASIYER_KOD'
           +',PLASIYER.ADISOY'
           +',CARIHAR.TARIH'
           +',CARIHAR.BELGE_ID'
           +',CARIHAR.BELGE_TUR'
           +',CARIHAR.DOV_BAZ_TAR'
           +',CARIHAR.TIP'
           +',CARIHAR.DOVKOD'
           +',CARIHAR.TUTAR'
           +',CARIHAR.ACIKLAMA'
           +',CARIHAR.DOVKUR'
           +',(case when  CARIHAR.TIP=''B'' then '
           +'CARIHAR.TUTAR_VPB else 0 end) CBorc '
           +',(case when  CARIHAR.TIP=''A'' then '
           +'CARIHAR.TUTAR_VPB else 0 end ) CAlacak '
           +',CARIHAR.TUTAR_VPB FROM PLASIYER'
           +' INNER JOIN CARIHAR ON (CARIHAR.PLASIYER_KOD = PLASIYER.PLASIYER_KOD)'
           +' WHERE PLASIYER.PLASIYER_KOD =' + SQL_Katar(txtPlasiyerKod1.Text)
           + ' and (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';
           if glb_SUBELI then
           begin
             SubeID := DataMod.SubeAd2ID(cmbSube.Text);
             if SubeID <> '0' then
             begin
               strSQLd := strSQLd + ' AND PLASIYER.PLASIYER_SID = ' + SubeID;
             end;
           end
           else
           begin
             strSQLd := strSQLd + ' AND PLASIYER.PLASIYER_SID = ' + inttostr(glb_SID);
           end;

  with frmRaporPlasiyerHareketleri.IB_Query1 do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQLd);
    Active := True;
  end;
  if ((frmRaporPlasiyerHareketleri.IB_Query1.Eof) and (frmRaporPlasiyerHareketleri.IB_Query1.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz','Dikkat',MB_ICONWARNING);
    IB_Query1.Close;
    Exit;
  end;

  Prv_Yazdirildi:=False;
  frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Plasiyer_Hareket.fr3');

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
  Exit;
end;

procedure TfrmRaporPlasiyerHareketleri.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
    if ARow.ByName('BELGE_TUR').AsInteger>0 then
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('BELGE_TUR').AsInteger);
end;

end.
