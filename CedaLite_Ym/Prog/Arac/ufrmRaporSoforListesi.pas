unit ufrmRaporSoforListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  IB_Components, frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporSoforListesi = class(TForm)
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
    txtProjeKod1: TEdit;
    Button1: TButton;
    txtProjeKod2: TEdit;
    Button2: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    frxIBODts_Sofor_Lis: TfrxIBODataset;
    frxReport1: TfrxReport;
    qryRapor: TIB_Query;
    Btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
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
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    row,col:integer;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_Sofor_listesi = 35 ;
var
  frmRaporSoforListesi: TfrmRaporSoforListesi;

implementation

uses unDataMod, unFunc, ufrmRaporCiktisi,main;

{$R *.dfm}


procedure TfrmRaporSoforListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Sofor_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporSoforListesi') then
    begin
      Application.CreateForm(TfrmRaporSoforListesi, frmRaporSoforListesi);
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporSoforListesi.cmbSube.Items);
          with frmRaporSoforListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporSoforListesi.cmbSube do
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
        frmRaporSoforListesi.grpSube.Visible := False;
        //frmRaporCariBakiyeliHareket.cmbSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporSoforListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporSoforListesi.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporSoforListesi.txtProjeKod1Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod1);
end;

procedure TfrmRaporSoforListesi.txtProjeKod2Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod2);
end;

procedure TfrmRaporSoforListesi.kod_cikis(kod : TEdit);
var
  Personel_Adi : String;
begin
  if Length(Trim(kod.Text))=0 then
  begin
    kod.Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('SOFOR','SOFOR_KOD','ADI_SOYADI',kod.Text,Personel_Adi) Then
  begin
    Application.MessageBox('Söför Kodu Bulunamadý. Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;

procedure TfrmRaporSoforListesi.txtProjeKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporSoforListesi.txtProjeKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporSoforListesi.txtProjeKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporSoforListesi.Button1Click(Sender: TObject);
var
  SOFOR_KOD,SOFOR_ADI:String;
begin
  if DataMOd.LS_Sofor(SOFOR_KOD,SOFOR_ADI) then
  begin
  txtProjeKod1.Text := SOFOR_KOD;
  end;
end;

procedure TfrmRaporSoforListesi.Button2Click(Sender: TObject);
var
  SOFOR_KOD,SOFOR_ADI:String;
begin
  if DataMOd.LS_Sofor(SOFOR_KOD,SOFOR_ADI) then
  begin
  txtProjeKod2.Text := SOFOR_KOD;
  end;
end;

procedure TfrmRaporSoforListesi.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID:String;
  where_ek : Boolean;
begin
  where_ek := false;
  strSQL :=
  ' SELECT '+
  '    SOFOR_KOD '+
  '    ,SOFOR_SID '+
  '    ,ADI_SOYADI '+
  '    ,ADRESI1 '+
  '    ,ADRESI2 '+
  '    ,TEL_NO1 '+
  '    ,TEL_NO2 '+
  '    ,EHLIYET_NO '+
  '    ,VERGI_NO '+
  '    ,VERGI_DAIRE '+
  '    ,LISTEDEN_CIKAR '+
  '    ,ACIKLAMA '+
  '    ,BORC '+
  '    ,ALACAK '+
  '    ,DEVREDEN_BORC '+
  '    ,DEVREDEN_ALACAK '+
  '    ,RESIM '+
  '    ,KARA_LISTE '+
  ' FROM SOFOR ';


  if ((Length(Trim(txtProjeKod1.Text)) <> 0) and (Length(Trim(txtProjeKod2.Text))<>0)) then
  begin
    strSQL := strSQL + ' WHERE SOFOR.SOFOR_KOD BETWEEN ' + SQL_Katar(txtProjeKod1.Text) + ' AND ' + SQL_Katar(txtProjeKod2.Text);
    where_ek := true;
  end
  else
  if txtProjeKod1.Text<>'' then
  begin
    strSQL := strSQL + ' WHERE SOFOR.SOFOR_KOD = ' + SQL_Katar(txtProjeKod1.Text);
    where_ek := true;
  end;


  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      if where_ek then
      begin
        strSQL := strSQL + ' AND SOFOR.SOFOR_SID = ' + SubeID;
      end
      else
      begin
        strSQL := strSQL + ' WHERE SOFOR.SOFOR_SID = ' + SubeID;
      end;
    end
  end
  else
  begin
    if where_ek then
    begin
      strSQL := strSQL + ' AND SOFOR.SOFOR_SID = ' + inttostr(glb_SID);
    end
    else
    begin
      strSQL := strSQL + ' WHERE SOFOR.SOFOR_SID = ' + inttostr(glb_SID);
    end;
  end;

  case cmb_sirala.ItemIndex of
  0:
    begin
      strSQL := strSQL + ' ORDER BY SOFOR.SOFOR_KOD';
    end;
  1:
    begin
      strSQL := strSQL + ' ORDER BY SOFOR.ADI_SOYADI';
    end;
  end;
  frmRaporCiktisi_Open(Sender,strSQL);
  strSQL := '';
end;


procedure TfrmRaporSoforListesi.frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
begin
  with frmRaporSoforListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporSoforListesi.qryRapor.Eof) and (frmRaporSoforListesi.qryRapor.Bof))then
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
         frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Sofor_Listesi.fr3');

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
      frmRaporCiktisi.SetCellFont(0,2,19,2,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(4,2,5,2,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,19,1,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(4,1,5,1,haRight,vaCenter);
    end;

    frmRaporCiktisi.format_ayarla_text(0,4,19,row);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporSoforListesi.yaz;
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
  frmRaporCiktisi.SetCellText(row,col+2,'SÖFÖR LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  alan_isimlerini_ekle;
  qryRapor.First;
  Inc(Row);
  while not qryRapor.Eof do
  begin
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,11);


    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SOFOR_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADI_SOYADI').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADRESI1').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADRESI2').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TEL_NO1').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TEL_NO2').AsString);
    inc(col);
    frmRaporCiktisi.format_ayarla_text(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('EHLIYET_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('VERGI_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('VERGI_DAIRE').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('KARA_LISTE').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('RESIM').AsString);
 {
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
    qryRapor.Next;
  end;
end;


procedure TfrmRaporSoforListesi.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Söför Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Adý Soyadý');
  frmRaporCiktisi.SetCellText(row,col+2,'Adres1');
  frmRaporCiktisi.SetCellText(row,col+3,'Adres2');
  frmRaporCiktisi.SetCellText(row,col+4,'Telefon1');
  frmRaporCiktisi.SetCellText(row,col+5,'Telefon2');
  frmRaporCiktisi.SetCellText(row,col+6,'Ehliyet No');
  frmRaporCiktisi.SetCellText(row,col+7,'Vergi No');
  frmRaporCiktisi.SetCellText(row,col+8,'Vergi Dairesi');
  frmRaporCiktisi.SetCellText(row,col+9,'Kara Liste');
  frmRaporCiktisi.SetCellText(row,col+10,'Açýklama');
  frmRaporCiktisi.SetCellText(row,col+11,'Resim');
{  frmRaporCiktisi.SetCellText(row,col+11,'Tahsili');
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



procedure TfrmRaporSoforListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporSoforListesi.txtProjeKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSoforListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSoforListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporSoforListesi.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSoforListesi.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporSoforListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporSoforListesi);
end;

procedure TfrmRaporSoforListesi.frxReport1BeforePrint(
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

      {
       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
       }

       Prv_Yazdirildi:=True;
    end;
end;

end.
