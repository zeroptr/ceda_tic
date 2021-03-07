unit ufrmRaporUrunFiyatListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Buttons, StdCtrls, ComCtrls,
  ExtCtrls,frxClass, frxIBOSet,cxSSTypes,cxSSHeaders ;

type
  TfrmRaporUrunFiyatListesi = class(TForm)
    qryUrun: TIB_Query;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    cmbGrup: TComboBox;
    qryUrunHareket: TIB_Query;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryRapor: TIB_Cursor;
    Label3: TLabel;
    cmb_sirala: TComboBox;
    GroupBox1: TGroupBox;
    txtUrunKod1: TEdit;
    txtUrunKod2: TEdit;
    Button1: TButton;
    Button2: TButton;
    chk_Sirket: TCheckBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    CbUrun_Tipi: TComboBox;
    IB_Query1: TIB_Query;
    frxIBODts_UrunFiyList: TfrxIBODataset;
    frxReport1: TfrxReport;
    btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure frmRaporCiktisi_Open(strSQL:String);
    procedure Form_Open();
    procedure yaz;
    procedure Rapora_Grupsuzlari_Ekle;
    procedure Rapora_Gruplulari_Ekle;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure txtUrunKod1Exit(Sender: TObject);
    procedure txtUrunKod2Exit(Sender: TObject);
    procedure txtUrunKod1KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtUrunKod2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtUrunKod2KeyPress(Sender: TObject; var Key: Char);
    procedure txtUrunKod1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtUrunKod1Enter(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    //strSQL,SQLSelect,SQLWhere,SQLFrom,SQLJoin,SQLOrderBy,SQLBetween:String;
    row,col:integer;
    grup_adi : string;
    Prv_Yazdirildi:Boolean;    
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_urun_listesi = 7;

var
  frmRaporUrunFiyatListesi: TfrmRaporUrunFiyatListesi;

implementation

uses unDataMod,ufrmRaporCiktisi,unFunc,ufrmUrunSDLG,main;


{$R *.dfm}

procedure TfrmRaporUrunFiyatListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_urun_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporUrunFiyatListesi') then
    begin
      Application.CreateForm(TfrmRaporUrunFiyatListesi,frmRaporUrunFiyatListesi);
    end;
  end;
end;

procedure TfrmRaporUrunFiyatListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmRaporUrunFiyatListesi.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TfrmRaporUrunFiyatListesi.txtUrunKod1Exit(Sender: TObject);
var
  UrunAd : String;
begin
  if Length(Trim(txtUrunKod1.Text))=0 then
  begin
    txtUrunKod1.Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',txtUrunKod1.Text,UrunAd)) then
  begin
    Application.MessageBox('Ürün Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    txtUrunKod1.Clear;
    txtUrunKod1.SetFocus;
  end
  else
  begin
    txtUrunKod1.Color := clWindow;
  end;
end;

procedure TfrmRaporUrunFiyatListesi.txtUrunKod2Exit(Sender: TObject);
var
  UrunAd : String;
begin
  if Length(Trim(txtUrunKod2.Text))=0 then
  begin
    txtUrunKod2.Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',txtUrunKod2.Text,UrunAd)) then
  begin
    Application.MessageBox('Ürün Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    txtUrunKod2.Clear;
    txtUrunKod2.SetFocus;
  end
  else
  begin
    txtUrunKod2.Color := clWindow;
  end;
end;

procedure TfrmRaporUrunFiyatListesi.txtUrunKod1KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
var
  UrunKod,UrunAd : String;
begin
  if Key=VK_F4 Then
  begin
    if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod1.Text := UrunKod;
  end;
end;

procedure TfrmRaporUrunFiyatListesi.txtUrunKod2KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
var
  UrunKod,UrunAd : String;
begin
  if Key=VK_F4 Then
  begin
    if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod2.Text := UrunKod;
  end;
end;

procedure TfrmRaporUrunFiyatListesi.txtUrunKod2KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporUrunFiyatListesi.txtUrunKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporUrunFiyatListesi.Button1Click(Sender: TObject);
var
  UrunKod,UrunAd : String;
begin
  if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod1.Text := UrunKod;
end;

procedure TfrmRaporUrunFiyatListesi.Button2Click(Sender: TObject);
var
  UrunKod,UrunAd : String;
begin
  if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod2.Text := UrunKod;
end;

procedure TfrmRaporUrunFiyatListesi.btnRaporClick(Sender: TObject);
var
  where_ek,sec_sql : Boolean;
  strSQL,SQLSelect,SQLWhere,SQLFrom,SQLJoin,SQLOrderBy,SQLBetween:String;
  c:TfrxMemoView;

begin
  SQLSelect := 'SELECT ';
  SQLFrom := ' FROM URUN ';
  sec_sql := true;
  where_ek := false;
  SQLSelect := SQLSelect + 'URUN.OLCUBIRIM, URUN.BIRIMFIY, URUN.SATISFIY, URUN.URUN_KOD,URUN_GRUP.UGADI,URUN.URUN_AD,URUN.DOVKOD,URUN.BORC,URUN.ALACAK,URUN.ALACAK_VPB,URUN.BORC_VPB,URUN.MIKTAR_BORC,URUN.MIKTAR_ALACAK';
  SQLJoin := 'LEFT OUTER JOIN URUN_GRUP_UYE ON (URUN.URUN_KOD = URUN_GRUP_UYE.URUN_KOD) '
  +'LEFT OUTER JOIN URUN_GRUP ON (URUN_GRUP_UYE.URUN_GRUP_KOD=URUN_GRUP.URUN_GRUP_KOD) ';
//*****************************************************************************************************************
//***************************************************************************************************************
  case cmbGrup.ItemIndex of
  0:
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND URUN_GRUP_UYE.VARSAY = 1 ';
      end
      else
      begin
        SQLWhere := ' WHERE ';
        SQLWhere := SQLWhere + ' URUN_GRUP_UYE.VARSAY = 1 ';
        where_ek := true;
      end;
    end;
  1:
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND URUN_GRUP_UYE.VARSAY = 0 ';
      end
      else
      begin
        SQLWhere := ' WHERE ';
        SQLWhere := SQLWhere + ' URUN_GRUP_UYE.VARSAY = 0 ';
        where_ek := true;
      end;
    end;
  2:
    begin
      SQLWhere := '';
    end;
  end;


  if CbUrun_Tipi.itemIndex<>3 then
  begin
      if where_ek then
      begin
        if CbUrun_Tipi.itemIndex=0 then SQLWhere := SQLWhere + ' AND URUN.URUN_TIP = ''M'' ';
        if CbUrun_Tipi.itemIndex=1 then SQLWhere := SQLWhere + ' AND URUN.URUN_TIP = ''Y'' ';
        if CbUrun_Tipi.itemIndex=2 then SQLWhere := SQLWhere + ' AND URUN.URUN_TIP = ''H'' ';
      end
      else
      begin
        SQLWhere := ' WHERE ';
        if CbUrun_Tipi.itemIndex=0 then SQLWhere := SQLWhere + '  URUN.URUN_TIP = ''M'' ';
        if CbUrun_Tipi.itemIndex=1 then SQLWhere := SQLWhere + '  URUN.URUN_TIP = ''Y'' ';
        if CbUrun_Tipi.itemIndex=2 then SQLWhere := SQLWhere + '  URUN.URUN_TIP = ''H'' ';
        where_ek := true;
      end;
  end;

  SQLOrderBy := ' ORDER BY URUN_GRUP.URUN_GRUP_KOD ASC';

  if  (((Length(trim(txtUrunKod1.Text))=0) or (Length(trim(txtUrunKod2.Text))=0)) and (cmbGrup.ItemIndex=2)) then
  begin
    if sec_sql then
    begin
      strSQL := SQLSelect+SQLFrom+SQLJoin+SQLWhere+SQLOrderBy;
      sec_sql := false;
    end;
  end;

  if  (((Length(trim(txtUrunKod1.Text))=0) or (Length(trim(txtUrunKod2.Text))=0)) and (cmbGrup.ItemIndex<>2)) then
  begin
    if sec_sql then
    begin
      strSQL := SQLSelect+SQLFrom+SQLJoin+SQLWhere+SQLOrderBy;
      sec_sql := false;
    end;
  end;


  if ( (Length(trim(txtUrunKod1.Text))=0) and (Length(trim(txtUrunKod2.Text))=0) and (cmbGrup.ItemIndex<>2) ) then
  begin
    if sec_sql then
    begin
      strSQL := SQLSelect+SQLFrom+SQLJoin+SQLWhere+SQLOrderBy;
      sec_sql := false;
    end;
  end;

  if ( (Length(Trim(txtUrunKod1.Text))=0) and (Length(Trim(txtUrunKod2.Text))=0) and (cmbGrup.ItemIndex=2) ) then
  begin
    if not where_ek then
    begin
      if sec_sql then
      begin
        strSQL := SQLSelect+SQLFrom+SQLJoin+SQLOrderBy;
        sec_sql := false;
      end;
    end
    else
    begin
      if sec_sql then
      begin
        strSQL := SQLSelect+SQLFrom+SQLJoin+SQLWhere+SQLOrderBy;
        sec_sql := false;
      end;
    end;
  end;

  if ( (Length(Trim(txtUrunKod1.Text))<>0) and (Length(Trim(txtUrunKod2.Text))<>0) and (cmbGrup.ItemIndex<>2) ) then
  begin
    if where_ek then
    begin
      SQLBetween := ' AND URUN.URUN_KOD BETWEEN '+SQL_Katar(txtUrunKod1.Text)+' AND '+SQL_Katar(txtUrunKod2.Text);
    end
    else
    begin
      SQLBetween := ' WHERE URUN.URUN_KOD BETWEEN '+SQL_Katar(txtUrunKod1.Text)+' AND '+SQL_Katar(txtUrunKod2.Text);
    end;

    if sec_sql then
    begin
      strSQL := SQLSelect+SQLFrom+SQLJoin+SQLWhere+SQLBetween+SQLOrderBy;
      sec_sql := false;
    end;
  end;

  if ( (Length(Trim(txtUrunKod1.Text))<>0) and (Length(Trim(txtUrunKod2.Text))<>0) and (cmbGrup.ItemIndex=2) )then
  begin
    if where_ek then
    begin
      SQLBetween := ' AND URUN.URUN_KOD BETWEEN '+SQL_Katar(txtUrunKod1.Text)+ ' AND '+SQL_Katar(txtUrunKod2.Text);
    end
    else
    begin
      SQLBetween := ' WHERE URUN.URUN_KOD BETWEEN '+SQL_Katar(txtUrunKod1.Text)+ ' AND '+SQL_Katar(txtUrunKod2.Text);
    end;
    if sec_sql then
    begin
      strSQL := SQLSelect+SQLFrom+SQLJoin+SQLWhere+SQLBetween+SQLOrderBy;
    end;
  end;

 if Sender=Btn_Fast then
 begin
       with frmRaporUrunFiyatListesi.IB_Query1 do
       begin
         Active := false;
         SQL.Clear;
         SQL.Add(strSQL);
         Active := True;
       end;

       if ((frmRaporUrunFiyatListesi.IB_Query1.Eof) and (frmRaporUrunFiyatListesi.IB_Query1.bof))then
       begin
         Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý. Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
         IB_Query1.Close;
         Exit;
       end;

       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Urun_Fiyat_Listesi.fr3');

       if ComboBox1.ItemIndex<2 then
       begin
          c:=(frxReport1.FindComponent('Memo25') as TfrxMemoView);
          c.Visible:=False;
          c:=(frxReport1.FindComponent('Memo20') as TfrxMemoView);
          c.Visible:=False;
       end;
       if ComboBox1.ItemIndex=1 then
       begin
          c:=(frxReport1.FindComponent('Memo24') as TfrxMemoView);
          c.Memo.Text:='Satýþ Fiyatý';
          c:=(frxReport1.FindComponent('Memo19') as TfrxMemoView);
          c.DataField:='SATISFIY';
       end;

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
  frmRaporUrunFiyatListesi.frmRaporCiktisi_Open(strSQL);
end;

procedure TfrmRaporUrunFiyatListesi.frmRaporCiktisi_Open(strSQL:String);
begin
  with frmRaporUrunFiyatListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporUrunFiyatListesi.qryRapor.Eof) and (frmRaporUrunFiyatListesi.qryRapor.bof))then
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
    frmRaporCiktisi.SetCellAlignment(2,3,7,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRight,vaCenter);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryUrun.Close;
    qryUrunHareket.Close;
    qryRapor.Close;
  end;
end;

procedure TfrmRaporUrunFiyatListesi.yaz;
var
  res_Cari : TStringList;
begin
  row := 0;
  col := 0;
  grup_adi := '';
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
     frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
     frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    frmRaporUrunFiyatListesi.row := 1;
  end;

  frmRaporCiktisi.SetCellText(1,0,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(0,1,0,1,[fsBold],8,'MS Sans Serif',0);
  frmRaporCiktisi.SetCellText(row,col+2,'ÜRÜN FÝYAT LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  qryRapor.First;
  while not (qryRapor.Eof) do
  begin
    col :=  0;



    inc(row);
    if (grup_adi<>qryRapor.FieldByName('UGADI').AsString) then
    begin
      if (qryRapor.FieldByName('UGADI').AsString='') then
      begin
        if (grup_adi<>'Diðerleri') then
        begin
          Rapora_Grupsuzlari_Ekle;
        end;
      end
      else
      begin
        Rapora_Gruplulari_Ekle;
      end;
    end;

    if (qryRapor.FieldByName('UGADI').AsString='') then
    begin
      if (grup_adi<>'Diðerleri') then
      begin
        Rapora_Grupsuzlari_Ekle;
      end;
    end;
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,5);


    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('URUN_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('URUN_AD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('OLCUBIRIM').AsString);

    if ComboBox1.ItemIndex=0 then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BIRIMFIY').AsString);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
    end;

    if ComboBox1.ItemIndex=1 then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SATISFIY').AsString);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
    end;

    {if (qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR) then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla(col,row,col,row);
    }
    if ComboBox1.ItemIndex=2 then
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BIRIMFIY').AsString);
      frmRaporCiktisi.format_ayarla(col,row,col,row);

      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SATISFIY').AsString);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
    end;
    {if (qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR) then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla(col,row,col,row);
    }
    {inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MIKTAR_BORC').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MIKTAR_ALACAK').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    }
    qryRapor.Next;
  end;
end;

procedure TfrmRaporUrunFiyatListesi.Rapora_Grupsuzlari_Ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Diðerleri');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellText(row+1,col,'Ürün Kodu');
  frmRaporCiktisi.SetCellText(row+1,col+1,'Ürün Adý');
  frmRaporCiktisi.SetCellText(row+1,col+2,'Para Birimi');
  frmRaporCiktisi.SetCellText(row+1,col+3,'Ölçü Birimi');
  if ComboBox1.ItemIndex=0 then
  begin
       frmRaporCiktisi.SetCellText(row+1,col+4,'Alýþ Fiyatý');
  end;
  if ComboBox1.ItemIndex=1 then
  begin
       frmRaporCiktisi.SetCellText(row+1,col+4,'Satýþ Fiyatý');
  end;
  if ComboBox1.ItemIndex=2 then
  begin
       frmRaporCiktisi.SetCellText(row+1,col+4,'Alýþ Fiyatý');
       frmRaporCiktisi.SetCellText(row+1,col+5,'Satýþ Fiyatý');
  end;
  {frmRaporCiktisi.SetCellText(row+1,col+6,'Alacak VPB');
  frmRaporCiktisi.SetCellText(row+1,col+7,'Miktar Borç');
  frmRaporCiktisi.SetCellText(row+1,col+8,'Miktar Alacak');
  }
  frmRaporCiktisi.SetCellFont(col,row+1,col+8,row+1,[fsBold],8,'MS Sans Serif',4);
  inc(row,2);
  grup_adi := 'Diðerleri';
end;

procedure TfrmRaporUrunFiyatListesi.Rapora_Gruplulari_Ekle;
begin
  inc(row);
  grup_adi := qryRapor.FieldByName('UGADI').AsString;
  frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('UGADI').AsString);
  frmRaporCiktisi.SetCellText(row+1,col,'Ürün Kodu');
  frmRaporCiktisi.SetCellText(row+1,col+1,'Ürün Adý');
  frmRaporCiktisi.SetCellText(row+1,col+2,'Para Birimi');
  frmRaporCiktisi.SetCellText(row+1,col+3,'Ölçü Birimi');
  if ComboBox1.ItemIndex=0 then
  begin
    frmRaporCiktisi.SetCellText(row+1,col+4,'Alýþ Fiyatý');
  end;
  if ComboBox1.ItemIndex=1 then
  begin
    frmRaporCiktisi.SetCellText(row+1,col+4,'Satýþ Fiyatý');
  end;
  if ComboBox1.ItemIndex=2 then
  begin
    frmRaporCiktisi.SetCellText(row+1,col+4,'Alýþ Fiyatý');
    frmRaporCiktisi.SetCellText(row+1,col+5,'Satýþ Fiyatý');
  end;
  {frmRaporCiktisi.SetCellText(row+1,col+6,'Alacak VPB');
  frmRaporCiktisi.SetCellText(row+1,col+7,'Miktar Borç');
  frmRaporCiktisi.SetCellText(row+1,col+8,'Miktar Alacak');
  }
  frmRaporCiktisi.SetCellFont(col,row+1,col+8,row+1,[fsBold],8,'MS Sans Serif',4);
  inc(row,2);
end;


procedure TfrmRaporUrunFiyatListesi.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporUrunFiyatListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporUrunFiyatListesi.txtUrunKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunFiyatListesi.chk_SirketEnter(Sender: TObject);
begin
  chk_Sirket.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporUrunFiyatListesi.chk_SirketExit(Sender: TObject);
begin
  chk_Sirket.Color := clBtnFace;
end;

procedure TfrmRaporUrunFiyatListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporUrunFiyatListesi);
end;

procedure TfrmRaporUrunFiyatListesi.frxReport1BeforePrint(
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
      {d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar.Date);
       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);     }

       Prv_Yazdirildi:=True;
    end;
end;

end.
