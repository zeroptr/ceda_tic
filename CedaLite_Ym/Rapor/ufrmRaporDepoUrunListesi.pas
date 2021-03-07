unit ufrmRaporDepoUrunListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls,
  IB_Components, frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporDepoUrunListesi = class(TForm)
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    cmb_sirala: TComboBox;
    qryUrunHareket: TIB_Query;
    qryDepoUrun: TIB_Cursor;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    GroupBox1: TGroupBox;
    txtDepoKod: TEdit;
    btnDepo: TButton;
    GroupBox2: TGroupBox;
    txtUrunKod1: TEdit;
    txtUrunKod2: TEdit;
    Button4: TButton;
    Button5: TButton;
    frxIBODts_DepoUrun: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(strSQL:String);
    procedure Alan_isimlerini_ekle;
    procedure yaz;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure btnDepoClick(Sender: TObject);
    procedure txtUrunKod1Exit(Sender: TObject);
    procedure txtUrunKod2Exit(Sender: TObject);
    procedure txtUrunKod2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure txtUrunKod1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure txtUrunKod1KeyPress(Sender: TObject; var Key: Char);
    procedure txtUrunKod2KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtDepoKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtDepoKodKeyDown(Sender: TObject; var Key: Word;Shift:TShiftState);
    procedure txtDepoKodExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure txtDepoKodEnter(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
//***********************************
  private
    strSQL,SQLSelect,SQLWhere,SQLFrom,SQLJoin,SQLOrderBy,SQLBetween:String;
    row,col:integer;
    UrunKod,UrunAd:String;
    DEPO_KOD,DEPO_AD:String;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_depo_urun_listesi = 7;
var
  frmRaporDepoUrunListesi: TfrmRaporDepoUrunListesi;

implementation

uses unDataMod, unFunc, ufrmUrunSDLG, ufrmRaporCiktisi, main;

{$R *.dfm}

procedure TfrmRaporDepoUrunListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_depo_urun_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporDepoUrunListesi') then
    begin
      Application.CreateForm(TfrmRaporDepoUrunListesi,frmRaporDepoUrunListesi);
    end;
  end;
end;


procedure TfrmRaporDepoUrunListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporDepoUrunListesi.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporDepoUrunListesi.btnDepoClick(Sender: TObject);
var
  DEPO_KOD,DEPO_AD:String;
begin
  if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) then txtDepoKod.Text := DEPO_KOD;
end;

procedure TfrmRaporDepoUrunListesi.txtUrunKod1Exit(Sender: TObject);
begin
  if Length(Trim(txtUrunKod1.Text))=0 then
  begin
    txtUrunKod1.Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',txtUrunKod1.Text,UrunAd) then
  begin
    Application.MessageBox('Ürün Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
    txtUrunKod1.Clear;
    txtUrunKod1.SetFocus;
  end
  else
  begin
    txtUrunKod1.Color := clWindow;
    exit;
  end;
end;

procedure TfrmRaporDepoUrunListesi.txtUrunKod2Exit(Sender: TObject);
begin
   if Length(Trim(txtUrunKod2.Text))=0 then
   begin
     txtUrunKod2.Color := clWindow;
     exit;
   end;
   if not DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',txtUrunKod2.Text,UrunAd) then
   begin
     Application.MessageBox('Ürün Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
     txtUrunKod2.Clear;
     txtUrunKod2.SetFocus;
   end
   else
   begin
     txtUrunKod2.Color := clWindow;
   end;
end;

procedure TfrmRaporDepoUrunListesi.txtUrunKod2KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then
  begin
    if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) then txtUrunKod2.Text := UrunKod;
  end;
end;

procedure TfrmRaporDepoUrunListesi.txtUrunKod1KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then
  begin
    if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod1.Text := UrunKod;
  end;
end;

procedure TfrmRaporDepoUrunListesi.txtUrunKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporDepoUrunListesi.txtUrunKod2KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporDepoUrunListesi.txtDepoKodKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporDepoUrunListesi.txtDepoKodKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then
  begin
    if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) then txtDepoKod.Text := DEPO_KOD;
  end;
end;

procedure TfrmRaporDepoUrunListesi.txtDepoKodExit(Sender: TObject);
begin
  if Length(Trim(txtDepoKod.Text))=0 then
  begin
    txtDepoKod.Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('DEPO','DEPO_KOD','ADI',txtDepoKod.Text,Depo_Ad) then
  begin
    Application.MessageBox('Depo Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
    txtDepoKod.Clear;
    txtDepoKod.SetFocus;
  end
  else
  begin
    txtDepoKod.Color := clWindow;
  end;
end;


procedure TfrmRaporDepoUrunListesi.Button1Click(Sender: TObject);
begin
  if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) then txtUrunKod1.Text := UrunKod;
end;

procedure TfrmRaporDepoUrunListesi.Button2Click(Sender: TObject);
begin
  if frmUrunSDLG.Form_Open(True,UrunKod,UrunAd,False) Then  txtUrunKod2.Text := UrunKod;
end;

procedure TfrmRaporDepoUrunListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporDepoUrunListesi.btnRaporClick(Sender: TObject);
var
  where_ek,sec_sql : Boolean;

  c:TfrxMemoView;

begin
  if trim(txtDepoKod.Text)='' then
  begin
    Application.MessageBox('Lütfen depo seçimi yapýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  SQLSelect := 'SELECT URUN.URUN_AD,URUN.URUN_KOD,URUN.DOVKOD,DEPOURUN.BORC,DEPOURUN.ALACAK,DEPOURUN.BORC_VPB,DEPOURUN.ALACAK_VPB,DEPOURUN.MIKTAR_BORC,DEPOURUN.MIKTAR_ALACAK';
  SQLFrom := ' FROM DEPOURUN ';
  SQLJoin := ' LEFT OUTER JOIN URUN ON (URUN.URUN_KOD = DEPOURUN.URUN_KOD)';
  SQLWhere := ' WHERE DEPOURUN.DEPO_KOD = '+ SQL_Katar(txtDepoKod.Text);
  sec_sql := true;
  where_ek := true;
  case cmb_sirala.ItemIndex of
  0:
    begin
      SQLOrderBy := ' ORDER BY URUN.URUN_KOD ';
    end;
  1:
    begin
      SQLOrderBy := ' ORDER BY URUN.URUN_AD ';
    end;
  end;
  if  ((Length(trim(txtUrunKod1.Text))=0) or (Length(trim(txtUrunKod2.Text))=0)) then
  begin
    if sec_sql then
    begin
      strSQL := SQLSelect+SQLFrom+SQLJoin+SQLWhere+SQLOrderBy;
      sec_sql := false;
    end;
  end;
  if  (Length(trim(txtUrunKod1.Text))=0) and (Length(trim(txtUrunKod2.Text))=0) then
  begin
    if sec_sql then
    begin
      strSQL := SQLSelect+SQLFrom+SQLJoin+SQLWhere+SQLOrderBy;
      sec_sql := false;
    end;
  end;
  if (Length(Trim(txtUrunKod1.Text))<>0) and (Length(Trim(txtUrunKod2.Text))<>0) then
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
    end;
  end;


 if Sender=Btn_Fast then
 begin
       with IB_Query1 do
       begin
         Active := false;
         SQL.Clear;
         SQL.Add(strSQL);
         Active := True;
       end;

       if ((IB_Query1.Eof) and (IB_Query1.bof))then
       begin
         Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý. Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
         IB_Query1.Close;
         Exit;
       end;

       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Depo_Urun_Listesi.fr3');


       c:=(frxReport1.FindComponent('Memo_Depo_kod') as TfrxMemoView);
       c.memo.Text:=txtDepoKod.Text;

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

  frmRaporDepoUrunListesi.frmRaporCiktisi_Open(strSQL);
end;

procedure TfrmRaporDepoUrunListesi.frmRaporCiktisi_Open(strSQL:String);
begin
  with qryDepoUrun do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;
  if ((qryDepoUrun.Eof) and (qryDepoUrun.bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryDepoUrun.Close;
    Exit;
  end
  else
  begin
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;
    frmRaporCiktisi.SetCellFont(0,1,8,1,[fsBold],8,'MS Sans Serif',4);
    frmRaporCiktisi.SetCellAlignment(3,1,8,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRight,vaCenter);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryUrunHareket.Close;
    qryDepoUrun.Close;
  end;
end;

procedure TfrmRaporDepoUrunListesi.yaz;
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
    res_Cari.Free;
    row := 1;
  end;
  frmRaporCiktisi.SetCellText(row,col,'DEPO ÜRÜN LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);

  frmRaporCiktisi.SetCellText(row,5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(5,row,5,row,[fsBold],8,'MS Sans Serif',0);

  Alan_isimlerini_ekle;

  qryDepoUrun.First;
  while not qryDepoUrun.Eof do
  begin
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,8);

    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('URUN_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('URUN_AD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('DOVKOD').AsString);
    inc(col);

    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('BORC').AsString);
    if (qryDepoUrun.FieldByName('DOVKOD').AsString = glb_DEFCUR) then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    inc(col);

    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('ALACAK').AsString);
    if (qryDepoUrun.FieldByName('DOVKOD').AsString = glb_DEFCUR) then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    inc(col);

    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('BORC_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);

    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('ALACAK_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);

    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('MIKTAR_BORC').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);

    frmRaporCiktisi.SetCellText(row,col,qryDepoUrun.FieldByName('MIKTAR_ALACAK').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(row);

    qryDepoUrun.Next;
  end;
end;


procedure TfrmRaporDepoUrunListesi.Alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Ürün Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Ürün Adý');
  frmRaporCiktisi.SetCellText(row,col+2,'Para Birimi');
  frmRaporCiktisi.SetCellText(row,col+3,'Borç');
  frmRaporCiktisi.SetCellText(row,col+4,'Alacak');
  frmRaporCiktisi.SetCellText(row,col+5,'Borç VPB');
  frmRaporCiktisi.SetCellText(row,col+6,'Alacak VPB');
  frmRaporCiktisi.SetCellText(row,col+7,'Miktar Borç');
  frmRaporCiktisi.SetCellText(row,col+8,'Miktar Alacak');
  inc(row);
end;

procedure TfrmRaporDepoUrunListesi.txtDepoKodEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporDepoUrunListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporDepoUrunListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporDepoUrunListesi.FormKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  case Key Of
    VK_F6:PageControl1.SelectNextPage(True);
  end;
end;

procedure TfrmRaporDepoUrunListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporDepoUrunListesi);
end;

procedure TfrmRaporDepoUrunListesi.frxReport1BeforePrint(
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
      {

       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
      }
        
       Prv_Yazdirildi:=True;
    end;






end;

end.
