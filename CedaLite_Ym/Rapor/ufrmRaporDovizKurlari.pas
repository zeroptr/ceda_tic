unit ufrmRaporDovizKurlari;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IB_Components, ExtCtrls, Buttons, 
   frxClass, frxIBOSet, cxSSTypes, cxSSHeaders;

type
  TfrmRaporDovizKurlari = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryDoviz: TIB_Query;
    qryRapor: TIB_Cursor;
    chk_Sirket: TCheckBox;
    GroupBox1: TGroupBox;
    cmbParaBirimi: TComboBox;
    GroupBox2: TGroupBox;
    IslemTar1: TDateTimePicker;
    IslemTar2: TDateTimePicker;
    frxReport1: TfrxReport;
    frxIBODts_DovKur: TfrxIBODataset;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(strSQL:String);
    procedure Rapor_Baslik_Ekle;
    procedure yaz;
    procedure rapor_yaz_hepsi;
    procedure rapor_yaz_doviz;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cmbParaBirimiEnter(Sender: TObject);
    procedure IslemTar1Enter(Sender: TObject);
    procedure cmbParaBirimiExit(Sender: TObject);
    procedure IslemTar1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    row,col:integer;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_doviz_kurlari = 1;

var
  frmRaporDovizKurlari: TfrmRaporDovizKurlari;

implementation

uses unDataMod, ufrmRaporCiktisi,main,unFunc;

{$R *.dfm}



procedure TfrmRaporDovizKurlari.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_doviz_kurlari,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporDovizKurlari') then
    begin
      Application.CreateForm(TfrmRaporDovizKurlari,frmRaporDovizKurlari);
      with frmRaporDovizKurlari.cmbParaBirimi do
      begin
        SetFocus;
        Items.add(glb_DEFCUR);
        Items.AddStrings(glb_TAK_DOV_LIST);
        Items.add('HEPSÝ');
        ItemIndex := 0;
      end;
    end;
  end;
end;


procedure TfrmRaporDovizKurlari.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmRaporDovizKurlari.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  IslemTar1.Date := glb_DONEM_BAS;
  IslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporDovizKurlari.btnRaporClick(Sender: TObject);
var
  strSQL,SQLSelect,SQLWhere:String;
begin
  if (DateToStr(IslemTar1.Date) = DateToStr(IslemTar2.Date)) then
  begin
    Application.MessageBox('Ýþlem tarihleri ayný olamaz.Lütfen iþlem tarihlerini kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if (IslemTar1.Date>IslemTar2.Date) then
  begin
    Application.MessageBox('Ýkinci iþlem tarihi birinci tarihten küçük olamaz.Lütfen iþlem tarihlerini kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if (cmbParaBirimi.text = 'HEPSÝ') then
  begin
    SQLSelect := 'SELECT DOVKUR.DOVKOD,DOVKUR.TARIH,DOVKUR.ALISKUR,DOVKUR.SATISKUR,DOVKUR.EF_ALISKUR,DOVKUR.EF_SATISKUR FROM DOVKUR';
    SQLWhere := ' WHERE DOVKUR.TARIH BETWEEN ' + SQL_Tarih(IslemTar1.Date) + ' AND ' + SQL_Tarih(IslemTar2.Date) + ' ORDER BY TARIH ASC';
    strSQL := SQLSelect+SQLWhere;
  end
  else
  begin
    SQLSelect := 'SELECT DOVKUR.DOVKOD,DOVKUR.TARIH,DOVKUR.ALISKUR,DOVKUR.SATISKUR,DOVKUR.EF_ALISKUR,DOVKUR.EF_SATISKUR FROM DOVKUR';
    SQLWhere := ' WHERE DOVKUR.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text) + ' AND DOVKUR.TARIH BETWEEN ' + SQL_Tarih(IslemTar1.Date) + ' AND ' + SQL_Tarih(IslemTar2.Date) + ' ORDER BY TARIH ASC';
    strSQL := SQLSelect+SQLWhere;
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
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Doviz_Kurlari.fr3');

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








  frmRaporCiktisi_Open(strSQL);
end;

procedure TfrmRaporDovizKurlari.frmRaporCiktisi_Open(strSQL:String);
//rapor tipi 1 ise glb_defcur seçilidir.
//rapor tipi 2 ise takipli kurlardan birisi seçilidir.
begin
  with frmRaporDovizKurlari.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;
  if ((frmRaporDovizKurlari.qryRapor.Eof) and (frmRaporDovizKurlari.qryRapor.bof))then
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
    if cmbParaBirimi.Text <> 'HEPSÝ' then
    begin
      frmRaporCiktisi.SetCellAlignment(0,2,4,2,haRight,vaCenter);
    end;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;




procedure TfrmRaporDovizKurlari.yaz;
var
  res_Cari : TStringList;
  grup_adi : String;
begin
  grup_adi := '';
  row := 0;
  col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    frmRaporDovizKurlari.row := 0;
  end;
  frmRaporCiktisi.SetCellText(1,5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(5,1,5,1,[fsBold],8,'MS Sans Serif',0);
  frmRaporCiktisi.SetCellText(row,col+2,'DÖVÝZ KUR LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  if cmbParaBirimi.Text <> 'HEPSÝ' then
  begin
    rapor_yaz_hepsi;
  end
  else
  begin
    rapor_yaz_doviz;
  end;
end;

procedure TfrmRaporDovizKurlari.rapor_yaz_hepsi;
var
  doviz_kodu : string;
begin
  qryRapor.First;
  doviz_kodu := '';
  while not (qryRapor.Eof) do
  begin

    if doviz_kodu = '' then
    begin
      doviz_kodu := qryRapor.FieldByName('DOVKOD').AsString;
      inc(row);
      col := 0;
      frmRaporCiktisi.SetCellText(row,col,'Döviz Tipi :');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      col := 1;
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      col := 0;
      Rapor_Baslik_Ekle;
    end
    else
    begin
      if (doviz_kodu <> qryRapor.FieldByName('DOVKOD').AsString) then
      begin
        inc(row);
        col := 0;
        frmRaporCiktisi.SetCellText(row,col,'Döviz Tipi');
        col := 1;
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);
        col := 0;
        Rapor_Baslik_Ekle;
        doviz_kodu := qryRapor.FieldByName('DOVKOD').AsString;
      end;
    end;
    
    DataMod.Rapor_Satir_Renklendir(col,row,14);

    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TARIH').AsDate);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALISKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SATISKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('EF_ALISKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('EF_SATISKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(row);
    col := 0;
    frmRaporCiktisi.Refresh;
    qryRapor.Next;
  end;
end;

procedure TfrmRaporDovizKurlari.rapor_yaz_doviz;
var
  doviz_tarihi : string;
begin
  qryRapor.First;
  doviz_tarihi := '';
  while not (qryRapor.Eof) do
  begin
    if doviz_tarihi = '' then
    begin
      doviz_tarihi := qryRapor.FieldByName('TARIH').AsString;
      inc(row);
      col := 0;
      frmRaporCiktisi.SetCellText(row,col,'Tarih :');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
      col := 1;
      frmRaporCiktisi.SetCellText(row,col,qryRapor.fieldbyName('TARIH').asstring);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      col := 0;
      Rapor_Baslik_Ekle;
    end
    else
    begin
      if (doviz_tarihi <> qryRapor.FieldByName('TARIH').AsString) then
      begin
        inc(row);
        col := 0;
        frmRaporCiktisi.SetCellText(row,col,'Tarih :');
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
        col := 1;
        frmRaporCiktisi.SetCellText(row,col,qryRapor.fieldbyName('TARIH').asstring);
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
        col := 0;
        Rapor_Baslik_Ekle;
        doviz_tarihi := qryRapor.FieldByName('TARIH').AsString;
      end;
    end;
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALISKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SATISKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('EF_ALISKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('EF_SATISKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(row);
    col := 0;
    frmRaporCiktisi.Refresh;
    qryRapor.Next;
  end;
end;


procedure TfrmRaporDovizKurlari.Rapor_Baslik_Ekle;
begin
  inc(row);
  if cmbParaBirimi.Text = 'HEPSÝ' then
  begin
    frmRaporCiktisi.SetCellText(row,col,'Döviz Tipi');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    frmRaporCiktisi.SetCellAlignment(col,row,col,row,haLEFT,vaCenter);
  end
  else
  begin
    frmRaporCiktisi.SetCellText(row,col,'Tarih');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRight,vaCenter);
  end;
  frmRaporCiktisi.SetCellText(row,col+1,'Alýþ Kuru');
  frmRaporCiktisi.SetCellFont(col+1,row,col+1,row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(col+1,row,col+1,row,haRight,vaCenter);
  frmRaporCiktisi.SetCellText(row,col+2,'Satýþ Kuru');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(col+2,row,col+2,row,haRight,vaCenter);
  frmRaporCiktisi.SetCellText(row,col+3,'Efektif Alýþ Kuru');
  frmRaporCiktisi.SetCellFont(col+3,row,col+3,row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(col+3,row,col+3,row,haRight,vaCenter);
  frmRaporCiktisi.SetCellText(row,col+4,'Efektif Satýþ Kuru');
  frmRaporCiktisi.SetCellFont(col+4,row,col+4,row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(col+4,row,col+4,row,haRight,vaCenter);
  inc(row);
end;

procedure TfrmRaporDovizKurlari.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporDovizKurlari.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporDovizKurlari.cmbParaBirimiEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporDovizKurlari.IslemTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporDovizKurlari.cmbParaBirimiExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporDovizKurlari.IslemTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporDovizKurlari.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporDovizKurlari);
end;

procedure TfrmRaporDovizKurlari.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporDovizKurlari.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporDovizKurlari.frxReport1BeforePrint(
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

       c:=(frxReport1.FindComponent('Memo_Kur_Tip') as TfrxMemoView);
       c.memo.Text:=cmbParaBirimi.Text;


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(IslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(IslemTar2.Date);
    
        
       Prv_Yazdirildi:=True;
    end;




end;

end.
