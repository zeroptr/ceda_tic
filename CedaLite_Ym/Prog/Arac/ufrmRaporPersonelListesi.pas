unit ufrmRaporPersonelListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  IB_Components, frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporPersonelListesi = class(TForm)
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
    qryRapor: TIB_Query;
    frxReport1: TfrxReport;
    frxIBODts_Pers_Lis: TfrxIBODataset;
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

  const cns_Personel_listesi = 35 ;
var
  frmRaporPersonelListesi: TfrmRaporPersonelListesi;

implementation

uses unDataMod, unFunc, ufrmRaporCiktisi,main;

{$R *.dfm}


procedure TfrmRaporPersonelListesi.Form_Open();
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
    if not MainForm.FindChildFrm(Application,'frmRaporPersonelListesi') then
    begin
      Application.CreateForm(TfrmRaporPersonelListesi, frmRaporPersonelListesi);
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporPersonelListesi.cmbSube.Items);
          with frmRaporPersonelListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporPersonelListesi.cmbSube do
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
        frmRaporPersonelListesi.grpSube.Visible := False;
        //frmRaporCariBakiyeliHareket.cmbSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporPersonelListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporPersonelListesi.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporPersonelListesi.txtProjeKod1Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod1);
end;

procedure TfrmRaporPersonelListesi.txtProjeKod2Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod2);
end;

procedure TfrmRaporPersonelListesi.kod_cikis(kod : TEdit);
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
    Application.MessageBox('Personel Kodu Bulunamad�.L�tfen listeden se�iniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;

procedure TfrmRaporPersonelListesi.txtProjeKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporPersonelListesi.txtProjeKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporPersonelListesi.txtProjeKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporPersonelListesi.Button1Click(Sender: TObject);
var
  PERSONEL_KOD,PERSONEL_ADI:String;
begin
  if DataMOd.LS_Personel(PERSONEL_KOD,PERSONEL_ADI) then
  begin
  txtProjeKod1.Text := PERSONEL_KOD;
  end;
end;

procedure TfrmRaporPersonelListesi.Button2Click(Sender: TObject);
var
  PERSONEL_KOD,PERSONEL_ADI:String;
begin
  if DataMOd.LS_Personel(PERSONEL_KOD,PERSONEL_ADI) then
  begin
  txtProjeKod2.Text := PERSONEL_KOD;
  end;
end;

procedure TfrmRaporPersonelListesi.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID:String;
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
    strSQL := strSQL + ' WHERE PERSONEL.PERSONEL_KOD BETWEEN ' + SQL_Katar(txtProjeKod1.Text) + ' AND ' + SQL_Katar(txtProjeKod2.Text);
    where_ek := true;
  end
  else
  if txtProjeKod1.Text<>'' then
  begin
    strSQL := strSQL + ' WHERE PERSONEL.PERSONEL_KOD = ' + SQL_Katar(txtProjeKod1.Text);
    where_ek := true;    
  end;


  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      if where_ek then
      begin
        strSQL := strSQL + ' AND PERSONEL.PERSONEL_SID = ' + SubeID;
      end
      else
      begin
        strSQL := strSQL + ' WHERE PERSONEL.PERSONEL_SID = ' + SubeID;
      end;
    end
  end
  else
  begin
    if where_ek then
    begin
      strSQL := strSQL + ' AND PERSONEL.PERSONEL_SID = ' + inttostr(glb_SID);
    end
    else
    begin
      strSQL := strSQL + ' WHERE PERSONEL.PERSONEL_SID = ' + inttostr(glb_SID);
    end;
  end;

  case cmb_sirala.ItemIndex of
  0:
    begin
      strSQL := strSQL + ' ORDER BY PERSONEL.PERSONEL_KOD';
    end;
  1:
    begin
      strSQL := strSQL + ' ORDER BY PERSONEL.ADI_SOYADI';
    end;
  end;
  frmRaporCiktisi_Open(Sender,strSQL);
  strSQL := '';
end;


procedure TfrmRaporPersonelListesi.frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
var
  CHeader : TcxSSHeader;
begin
  with frmRaporPersonelListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporPersonelListesi.qryRapor.Eof) and (frmRaporPersonelListesi.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdi�iniz k�s�tlara uygun bir rapor al�namad�.L�tfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin


  if sender=Btn_Fast then
  begin

       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Personel_Listesi.fr3');

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

      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      CHeader.Size[1] := 150;

    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporPersonelListesi.yaz;
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
  frmRaporCiktisi.SetCellText(row,col+2,'PERSONEL L�STES�');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  alan_isimlerini_ekle;
  qryRapor.First;
  while not qryRapor.Eof do
  begin
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,7);

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
    {inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOGUM_TARIH').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOGUM_YER').AsString);

    inc(col);
    if qryRapor.FieldByName('CINSIYET').AsString='E' then Deger:='Erkek';
    if qryRapor.FieldByName('CINSIYET').AsString='K' then Deger:='Kad�n';
    frmRaporCiktisi.SetCellText(row,col,Deger);

    inc(col);
    if qryRapor.FieldByName('TAHSIL').AsString='1' then Deger:='�lkokul';
    if qryRapor.FieldByName('TAHSIL').AsString='2' then Deger:='Ortaokul';
    if qryRapor.FieldByName('TAHSIL').AsString='3' then Deger:='Lise';
    if qryRapor.FieldByName('TAHSIL').AsString='4' then Deger:='�niversite';
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
    if qryRapor.FieldByName('LISTEDEN_CIKAR').AsString='0' then Deger:='Hay�r';
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


procedure TfrmRaporPersonelListesi.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Personel Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Ad� Soyad�');
  frmRaporCiktisi.SetCellText(row,col+2,'Sicil No');
  frmRaporCiktisi.SetCellText(row,col+3,'SSK No');
  frmRaporCiktisi.SetCellText(row,col+4,'Bor�');
  frmRaporCiktisi.SetCellText(row,col+5,'Alacak');
  frmRaporCiktisi.SetCellText(row,col+6,'Giri� Tarihi');
  frmRaporCiktisi.SetCellText(row,col+7,'��k�� Tarihi');
{  frmRaporCiktisi.SetCellText(row,col+8,'Do�um Tarihi');
  frmRaporCiktisi.SetCellText(row,col+9,'Do�um Yeri');
  frmRaporCiktisi.SetCellText(row,col+10,'Cinsiyeti');
  frmRaporCiktisi.SetCellText(row,col+11,'Tahsili');
  frmRaporCiktisi.SetCellText(row,col+12,'Medeni Durumu');
  frmRaporCiktisi.SetCellText(row,col+13,'G�revi');
  frmRaporCiktisi.SetCellText(row,col+14,'Vergi No');
  frmRaporCiktisi.SetCellText(row,col+15,'Vergi Dairesi');
  frmRaporCiktisi.SetCellText(row,col+16,'Vergi Karne Tarihi');
  frmRaporCiktisi.SetCellText(row,col+17,'Telefon No');
  frmRaporCiktisi.SetCellText(row,col+18,'Listeden ��kart');
}
  inc(row);
end;



procedure TfrmRaporPersonelListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporPersonelListesi.txtProjeKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporPersonelListesi.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPersonelListesi.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporPersonelListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporPersonelListesi);
end;

procedure TfrmRaporPersonelListesi.frxReport1BeforePrint(
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
