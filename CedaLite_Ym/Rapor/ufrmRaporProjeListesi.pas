unit ufrmRaporProjeListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  IB_Components,frxClass, frxIBOSet,cxSSTypes,cxSSHeaders ;

type
  TfrmRaporProjeListesi = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    cmb_sirala: TComboBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryRapor: TIB_Cursor;
    GroupBox1: TGroupBox;
    txtProjeKod1: TEdit;
    Button1: TButton;
    txtProjeKod2: TEdit;
    Button2: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    frxIBODts_Proje: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
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

  const cns_proje_listesi = 9 ;
var
  frmRaporProjeListesi: TfrmRaporProjeListesi;

implementation

uses unDataMod, unFunc, ufrmRaporCiktisi,main;

{$R *.dfm}


procedure TfrmRaporProjeListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_proje_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporProjeListesi') then
    begin
      Application.CreateForm(TfrmRaporProjeListesi, frmRaporProjeListesi);
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporProjeListesi.cmbSube.Items);
          with frmRaporProjeListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporProjeListesi.cmbSube do
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
        frmRaporProjeListesi.grpSube.Visible := False;
        //frmRaporCariBakiyeliHareket.cmbSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporProjeListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporProjeListesi.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporProjeListesi.txtProjeKod1Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod1);
end;

procedure TfrmRaporProjeListesi.txtProjeKod2Exit(Sender: TObject);
begin
  kod_cikis(txtProjeKod2);
end;

procedure TfrmRaporProjeListesi.kod_cikis(kod : TEdit);
var
  Proje_Ad : String;
begin
  if Length(Trim(kod.Text))=0 then
  begin
    kod.Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',kod.Text,Proje_Ad) then
  begin
    Application.MessageBox('Proje Kodu Bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;



procedure TfrmRaporProjeListesi.txtProjeKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporProjeListesi.txtProjeKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporProjeListesi.txtProjeKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporProjeListesi.Button1Click(Sender: TObject);
var
  Proje_KOD,Proje_AD : String;
begin
  if DataMod.LS_Proje(Proje_KOD,Proje_AD,0) Then txtProjeKod1.Text := Proje_Kod;
end;

procedure TfrmRaporProjeListesi.Button2Click(Sender: TObject);
var
  Proje_KOD,Proje_AD : String;
begin
  if DataMod.LS_Proje(Proje_KOD,Proje_AD,0) Then txtProjeKod2.Text := Proje_Kod;
end;

procedure TfrmRaporProjeListesi.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID:String;
  where_ek : Boolean;
begin
  where_ek := false;
  strSQL := 'SELECT PROJE.PROJE_KOD,PROJE.PROJE_AD,PROJE.ACIKLAMA,PROJE.DOVKOD,PROJE.BORC,PROJE.ALACAK,PROJE.BORC_VPB,PROJE.ALACAK_VPB FROM PROJE ';
  if ((Length(Trim(txtProjeKod1.Text)) <> 0) and (Length(Trim(txtProjeKod2.Text))<>0)) then
  begin
    strSQL := strSQL + ' WHERE PROJE.PROJE_KOD BETWEEN ' + SQL_Katar(txtProjeKod1.Text) + ' AND ' + SQL_Katar(txtProjeKod2.Text);
    where_ek := true;
  end;

  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      if where_ek then
      begin
        strSQL := strSQL + ' AND PROJE.PROJE_SID = ' + SubeID;
      end
      else
      begin
        strSQL := strSQL + ' WHERE PROJE.PROJE_SID = ' + SubeID;
      end;
    end
  end
  else
  begin
    if where_ek then
    begin
      strSQL := strSQL + ' AND PROJE.PROJE_SID = ' + inttostr(glb_SID);
    end
    else
    begin
      strSQL := strSQL + ' WHERE PROJE.PROJE_SID = ' + inttostr(glb_SID);
    end;
  end;

  case cmb_sirala.ItemIndex of
  0:
    begin
      strSQL := strSQL + ' ORDER BY PROJE.PROJE_KOD';
    end;
  1:
    begin
      strSQL := strSQL + ' ORDER BY PROJE.PROJE_AD';
    end;
  end;
  frmRaporCiktisi_Open(Sender,strSQL);
  strSQL := '';
end;


procedure TfrmRaporProjeListesi.frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
begin
  with frmRaporProjeListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporProjeListesi.qryRapor.Eof) and (frmRaporProjeListesi.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin


       if Sender=Btn_Fast then
       begin

         with IB_Query1 do
         begin
           Active := false;
           SQL.Clear;
           SQL.Add(strSQL);
           Active := True;
         end;

          Prv_Yazdirildi:=False;
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Proje_Listesi.fr3');
          {if chk_Sayfalar.Checked then
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
      frmRaporCiktisi.SetCellFont(0,2,9,2,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(4,2,7,2,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,9,1,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(4,1,7,1,haRight,vaCenter);
    end;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporProjeListesi.yaz;
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
  frmRaporCiktisi.SetCellText(row,col+2,'PROJE LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  alan_isimlerini_ekle;
  qryRapor.First;
  while not qryRapor.Eof do
  begin
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,7);

    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_AD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);

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

    inc(row);
    qryRapor.Next;
  end;
end;


procedure TfrmRaporProjeListesi.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Proje Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Proje Adý');
  frmRaporCiktisi.SetCellText(row,col+2,'Açýklama');
  frmRaporCiktisi.SetCellText(row,col+3,'Para Birimi');
  frmRaporCiktisi.SetCellText(row,col+4,'Borç');
  frmRaporCiktisi.SetCellText(row,col+5,'Alacak');
  frmRaporCiktisi.SetCellText(row,col+6,'Borç VPB');
  frmRaporCiktisi.SetCellText(row,col+7,'Alacak VPB');
  inc(row);
end;



procedure TfrmRaporProjeListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporProjeListesi.txtProjeKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporProjeListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporProjeListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporProjeListesi.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporProjeListesi.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporProjeListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporProjeListesi);
end;

procedure TfrmRaporProjeListesi.frxReport1BeforePrint(
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
