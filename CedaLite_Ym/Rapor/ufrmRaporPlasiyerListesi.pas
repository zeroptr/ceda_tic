unit ufrmRaporPlasiyerListesi;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, IB_Components,
  ExtCtrls, frxClass, frxIBOSet, cxSSTypes,cxSSHeaders;

type
  TfrmRaporPlasiyerListesi = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    cmb_sirala: TComboBox;
    qryPlasiyer: TIB_Query;
    qryRapor: TIB_Cursor;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    GroupBox1: TGroupBox;
    txtPlasiyerKod1: TEdit;
    txtPlasiyerKod2: TEdit;
    Button1: TButton;
    Button2: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    frxIBODts_Plasiyer: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    Btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure alan_isimlerini_ekle;
    procedure yaz;
    procedure kod_cikis(kod : TEdit);
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtPlasiyerKod1Exit(Sender: TObject);
    procedure txtPlasiyerKod2Exit(Sender: TObject);
    procedure txtPlasiyerKod1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure txtPlasiyerKod1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure txtPlasiyerKod2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnRaporClick(Sender: TObject);
    procedure frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtPlasiyerKod1Enter(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    row,col:integer;
    PlasiyerKOD,PlasiyerAD:String;
    Prv_Yazdirildi:Boolean;    
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_plasiyer_listesi = 10;
var
  frmRaporPlasiyerListesi: TfrmRaporPlasiyerListesi;

implementation
uses unDataMod,unFunc,ufrmRaporCiktisi,main;
{$R *.dfm}
procedure TfrmRaporPlasiyerListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_plasiyer_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporPlasiyerListesi') then
    begin
      Application.CreateForm(TfrmRaporPlasiyerListesi,frmRaporPlasiyerListesi);
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporPlasiyerListesi.cmbSube.Items);
          with frmRaporPlasiyerListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporPlasiyerListesi.cmbSube do
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
        frmRaporPlasiyerListesi.grpSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporPlasiyerListesi.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryPlasiyer.Close;
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporPlasiyerListesi.txtPlasiyerKod1Exit(Sender: TObject);
begin
  kod_cikis(txtPlasiyerKod1);
end;

procedure TfrmRaporPlasiyerListesi.txtPlasiyerKod2Exit(Sender: TObject);
begin
  kod_cikis(txtPlasiyerKod2);
end;


procedure TfrmRaporPlasiyerListesi.kod_cikis(kod : TEdit);
var
  Proje_Ad:String;
begin
   if Length(Trim(kod.Text))=0 then
   begin
     kod.Color := clWindow;
     Exit;
   end;
   if not DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',kod.Text,Proje_Ad) then
   begin
     Application.MessageBox('Proje Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
     kod.Clear;
     kod.SetFocus;
   end
   else
   begin
     kod.Color := clWindow;
   end;
end;

procedure TfrmRaporPlasiyerListesi.txtPlasiyerKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporPlasiyerListesi.Button1Click(Sender: TObject);
begin
  if DataMod.LS_Plasiyer(PlasiyerKOD,PlasiyerAD,0) Then txtPlasiyerKod1.Text := PlasiyerKod;
end;

procedure TfrmRaporPlasiyerListesi.Button2Click(Sender: TObject);
begin
  if DataMod.LS_Plasiyer(PlasiyerKOD,PlasiyerAD,0) Then txtPlasiyerKod2.Text := PlasiyerKod;
end;

procedure TfrmRaporPlasiyerListesi.txtPlasiyerKod1KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporPlasiyerListesi.txtPlasiyerKod2KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporPlasiyerListesi.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID:String;
begin
  strSQL := 'SELECT PLASIYER.*,'
            +' (SELECT SUM(CARIHAR.TUTAR_VPB) FROM CARIHAR WHERE CARIHAR.PLASIYER_KOD = PLASIYER.PLASIYER_KOD AND CARIHAR.TIP = '+SQL_Katar(BORC)+') AS BORC_TOP,'
            +' (SELECT SUM(CARIHAR.TUTAR_VPB) FROM CARIHAR WHERE CARIHAR.PLASIYER_KOD = PLASIYER.PLASIYER_KOD AND CARIHAR.TIP = '+SQL_Katar(ALACAK)+') AS ALACAK_TOP'
            +' FROM PLASIYER ';

  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      strSQL := strSQL + ' WHERE PLASIYER.PLASIYER_SID = ' + SubeID;
    end;
  end
  else
  begin
    strSQL := strSQL + ' WHERE PLASIYER.PLASIYER_SID = ' + inttostr(glb_SID);
  end;

  if ((Length(Trim(txtPlasiyerKod1.Text)) <> 0) and (Length(Trim(txtPlasiyerKod2.Text))<>0)) then
  begin
    strSQL := strSQL + ' AND PLASIYER.PLASIYER_KOD BETWEEN ' + SQL_Katar(txtPlasiyerKod1.Text) + ' AND ' + SQL_Katar(txtPlasiyerKod2.Text);
  end;


  case cmb_sirala.ItemIndex of
  0:
    begin
      strSQL := strSQL + ' ORDER BY PLASIYER.PLASIYER_KOD';
    end;
  1:
    begin
      strSQL := strSQL + ' ORDER BY PLASIYER.ADISOY';
    end;
  end;
  frmRaporCiktisi_Open(Sender,strSQL);
end;


procedure TfrmRaporPlasiyerListesi.frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
begin
  with frmRaporPlasiyerListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporPlasiyerListesi.qryRapor.Eof) and (frmRaporPlasiyerListesi.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz','Dikkat',MB_ICONWARNING);
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
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Plasiyer_Listesi.fr3');
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
      frmRaporCiktisi.SetCellAlignment(2,2,2,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRight,vaCenter);
      frmRaporCiktisi.SetCellAlignment(6,2,9,2,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,9,1,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(6,1,9,1,haRight,vaCenter);
      frmRaporCiktisi.SetCellAlignment(2,1,2,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRight,vaCenter);
    end;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryPlasiyer.Close;
    qryRapor.Close;
  end;
end;

procedure TfrmRaporPlasiyerListesi.yaz;
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
  frmRaporCiktisi.SetCellText(row,col+2,'PLASÝYER LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  alan_isimlerini_ekle;
  qryRapor.First;
  while not qryRapor.Eof do
  begin
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,7);

    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PLASIYER_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADISOY').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TELNO_1').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ILCE').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SEHIR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_TOP').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_TOP').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(row);
    qryRapor.Next;
  end;
end;


procedure TfrmRaporPlasiyerListesi.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Plasiyer Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Plasiyer Adý Soyadý');
  frmRaporCiktisi.SetCellText(row,col+2,'Telefon Numarasý (1)');
  frmRaporCiktisi.SetCellText(row,col+3,'Ýlçe');
  frmRaporCiktisi.SetCellText(row,col+4,'Þehir');
  frmRaporCiktisi.SetCellText(row,col+5,'Para Birimi');
  frmRaporCiktisi.SetCellText(row,col+6,'Borç');
  frmRaporCiktisi.SetCellText(row,col+7,'Alacak');
  inc(row);
end;

procedure TfrmRaporPlasiyerListesi.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporPlasiyerListesi.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporPlasiyerListesi.txtPlasiyerKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPlasiyerListesi.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPlasiyerListesi.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporPlasiyerListesi.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporPlasiyerListesi.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporPlasiyerListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporPlasiyerListesi);
end;

procedure TfrmRaporPlasiyerListesi.frxReport1BeforePrint(
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


       {d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
       }

       Prv_Yazdirildi:=True;
    end;



end;

end.
