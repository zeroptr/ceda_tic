unit ufrmRaporMasrafListesi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, IB_Components,
  frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporMasrafListesi = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    chkDEVIR: TCheckBox;
    GroupBox1: TGroupBox;
    txtMasrafKod2: TEdit;
    txtMasrafKod1: TEdit;
    Button1: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    Button2: TButton;
    qryYaz: TIB_Cursor;
    frxIBODts_Masraf: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    Btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure Kod_Aralikli_Rapor(Sender: TObject);
    procedure Tek_Kodlu_Rapor(Sender: TObject);
    procedure Genel_Rapor(Sender: TObject);
    procedure Rapor_Olustur(Sender: TObject;SQL:String;tip:Byte);
    procedure yaz;
    procedure format_ayarla;
    procedure baslik_ekle;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure txtMasrafKod1Enter(Sender: TObject);
    procedure txtMasrafKod1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure txtMasrafKod1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure txtMasrafKod2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure chkDEVIREnter(Sender: TObject);
    procedure chkDEVIRExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
  private
    { Private declarations }
    row,col : integer;
    Prv_Yazdirildi:Boolean;    
  public
    { Public declarations }
  end;
  const cns_masraf_listesi = 21;
var
  frmRaporMasrafListesi: TfrmRaporMasrafListesi;

implementation

{$R *.dfm}
uses unDataMod,ufrmRaporCiktisi,unFunc,main;

procedure TfrmRaporMasrafListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_masraf_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporMasrafListesi') then
    begin
      Application.CreateForm(TfrmRaporMasrafListesi,frmRaporMasrafListesi);
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporMasrafListesi.cmbSube.Items);
          with frmRaporMasrafListesi do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporMasrafListesi.cmbSube do
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
        frmRaporMasrafListesi.grpSube.Visible := False;
      end;//end else if glb_SUBELI then
    end;
  end;
end;


procedure TfrmRaporMasrafListesi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  qryYaz.Close;
  Action := caFree;
end;

procedure TfrmRaporMasrafListesi.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporMasrafListesi.txtMasrafKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafListesi.txtMasrafKod1Exit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmRaporMasrafListesi.Button1Click(Sender: TObject);
var
  KARSI_KOD : String;
begin
  if DataMod.LS_MASRAFTAN(KARSI_KOD) then
  begin
    txtMasrafKod1.Text := KARSI_KOD;
  end;
end;

procedure TfrmRaporMasrafListesi.Button2Click(Sender: TObject);
var
  KARSI_KOD : String;
begin
  if DataMod.LS_MASRAFTAN(KARSI_KOD) then
  begin
    txtMasrafKod2.Text := KARSI_KOD;
  end;
end;

procedure TfrmRaporMasrafListesi.txtMasrafKod1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
  begin
    Button1Click(Self);
  end;
end;

procedure TfrmRaporMasrafListesi.txtMasrafKod2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then
  begin
    Button2Click(Self);
  end;
end;

procedure TfrmRaporMasrafListesi.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafListesi.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporMasrafListesi.chkDEVIREnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMasrafListesi.chkDEVIRExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporMasrafListesi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporMasrafListesi);
end;

procedure TfrmRaporMasrafListesi.btnRaporClick(Sender: TObject);
begin
  if (Trim(txtMasrafKod1.Text)<>'') and (Trim(txtMasrafKod2.Text)<>'') then
  begin
    Kod_Aralikli_Rapor(Sender);
  end
  else
  if Trim(txtMasrafKod1.Text)<>'' then
  begin
    Tek_Kodlu_Rapor(Sender);
  end
  else
  begin
    Genel_Rapor(Sender);
  end;
end;

procedure TfrmRaporMasrafListesi.Genel_Rapor(Sender: TObject);
var
  strSQL : String;
begin
  if chkDEVIR.Checked then
  begin
    strSQL := 'SELECT MASRAF_KOD,ADI,ACIKLAMA,(BORC+DEVREDEN_BORC) AS TOPLAM_BORC,(ALACAK+DEVREDEN_ALACAK) AS TOPLAM_ALACAK FROM MASRAF';
  end
  else
  begin
    strSQL := 'SELECT MASRAF_KOD,ADI,ACIKLAMA,BORC AS TOPLAM_BORC,ALACAK AS TOPLAM_ALACAK FROM MASRAF';
  end;
  Rapor_Olustur(Sender,strSQL,0);
end;

procedure TfrmRaporMasrafListesi.Kod_Aralikli_Rapor(Sender: TObject);
var
  strSQL : String;
begin
  if chkDEVIR.Checked then
  begin
    strSQL := 'SELECT MASRAF_KOD,ADI,ACIKLAMA,(BORC+DEVREDEN_BORC) AS TOPLAM_BORC,(ALACAK+DEVREDEN_ALACAK) AS TOPLAM_ALACAK FROM MASRAF'
             +' WHERE MASRAF_KOD BETWEEN '+ SQL_Katar(txtMasrafKod1.Text) + ' AND '+ SQL_Katar(txtMasrafKod1.Text);
  end
  else
  begin
    strSQL := 'SELECT MASRAF_KOD,ADI,ACIKLAMA,BORC AS TOPLAM_BORC,ALACAK AS TOPLAM_ALACAK FROM MASRAF'
             +' WHERE MASRAF_KOD BETWEEN '+ SQL_Katar(txtMasrafKod1.Text) + ' AND '+ SQL_Katar(txtMasrafKod1.Text);
  end;
  Rapor_Olustur(Sender,strSQL,1);
end;

procedure TfrmRaporMasrafListesi.Tek_Kodlu_Rapor(Sender: TObject);
var
  strSQL,SubeID : String;
begin
  if chkDEVIR.Checked then
  begin
    strSQL := 'SELECT MASRAF_KOD,ADI,ACIKLAMA,(BORC+DEVREDEN_BORC) AS TOPLAM_BORC,(ALACAK+DEVREDEN_ALACAK) AS TOPLAM_ALACAK FROM MASRAF'
             +' WHERE MASRAF_KOD = '+SQL_Katar(txtMasrafKod1.Text);
  end
  else
  begin
    strSQL := 'SELECT MASRAF_KOD,ADI,ACIKLAMA,BORC AS TOPLAM_BORC,ALACAK AS TOPLAM_ALACAK FROM MASRAF'
             +' WHERE MASRAF_KOD = '+SQL_Katar(txtMasrafKod1.Text);
  end;
  Rapor_Olustur(Sender,strSQL,1);
end;

procedure TfrmRaporMasrafListesi.Rapor_Olustur(Sender: TObject;SQL:String; tip: Byte);
var
  strSQL,SubeID:String;
  CHeader : TcxSSHeader;
begin
  strSQL := SQL;
  DataMod.CreateCursor(qryYaz,nil,False,DataMod.dbaMain);
  case tip of
  0:
    begin
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' WHERE MASRAF_SID =' + SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' WHERE MASRAF_SID = ' + inttostr(glb_sid);
      end;
    end;
  1:
    begin
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND MASRAF_SID =' + SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' AND MASRAF_SID = ' + inttostr(glb_sid);
      end;
    end;
  end;//end case
  strSQL := strSQL + ' ORDER BY MASRAF_KOD';

  with qryYaz do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((qryYaz.Eof) and (qryYaz.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryYaz.Active := False;
    exit;
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
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Masraf_Listesi.fr3');
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
    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[1] := 350;
    CHeader.Size[2] := 120;
    frmRaporCiktisi.SetCellFormat(0,3,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    frmRaporCiktisi.SetCellAlignment(0,3,0,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haLEFT,vaCenter);
    frmRaporCiktisi.SetCellAlignment(2,2,2,frmRaporCiktisi.grdA.ActiveSheet.RowCount,haRight,vaCenter);
    frmRaporCiktisi.SetCellAlignment(5,2,6,2,haRight,vaCenter);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.grdA.ActivePage := 0;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryYaz.Active := False;
  end;
end;

procedure TfrmRaporMasrafListesi.yaz;
var
  res_Cari : TStringList;
begin
  //DataMod.CreateQuery(qryRapor,nil,False,True);
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
    row := 0;
  end;
  frmRaporCiktisi.SetCellText(row,5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(5,row,5,row,[fsBold],8,'MS Sans Serif',0);

  frmRaporCiktisi.SetCellText(row,col+2,'MASRAF LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);

  baslik_ekle;
  inc(row);
  col := 0;

  qryYaz.First;
  while not qryYaz.Eof do
  begin

    DataMod.Rapor_Satir_Renklendir(col,row,6);

    frmRaporCiktisi.SetCellText(row,col,qryYaz.FieldByName('MASRAF_KOD').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryYaz.FieldByName('ADI').AsString);
    Inc(col);
    format_ayarla;
    frmRaporCiktisi.SetCellText(row,col,qryYaz.FieldByName('ACIKLAMA').AsString);
    Inc(col);
    format_ayarla;
    frmRaporCiktisi.SetCellText(row,col,qryYaz.FieldByName('TOPLAM_BORC').AsString);
    Inc(col);
    format_ayarla;
    frmRaporCiktisi.SetCellText(row,col,qryYaz.FieldByName('TOPLAM_ALACAK').AsString);
    Inc(col);
    if qryYaz.FieldByName('TOPLAM_ALACAK').AsCurrency > qryYaz.FieldByName('TOPLAM_BORC').AsCurrency then
    begin
      frmRaporCiktisi.SetCellText(row,col,'A');
      Inc(col);
      format_ayarla;
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryYaz.FieldByName('TOPLAM_ALACAK').AsCurrency - qryYaz.FieldByName('TOPLAM_BORC').AsCurrency));
    end
    else
    if qryYaz.FieldByName('TOPLAM_ALACAK').AsCurrency < qryYaz.FieldByName('TOPLAM_BORC').AsCurrency then
    begin
      frmRaporCiktisi.SetCellText(row,col,'B');
      Inc(col);
      format_ayarla;
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryYaz.FieldByName('TOPLAM_BORC').AsCurrency - qryYaz.FieldByName('TOPLAM_ALACAK').AsCurrency));
    end
    else
    begin
      Inc(col);
      format_ayarla;
      frmRaporCiktisi.SetCellText(row,col,'0');
    end;
    Inc(row);
    col := 0;
    qryYaz.Next;
  end;
end;

procedure TfrmRaporMasrafListesi.format_ayarla;
begin
  frmRaporCiktisi.SetCellFormat(col,row,col,row,3);
end;


procedure TfrmRaporMasrafListesi.baslik_ekle;
begin
  frmRaporCiktisi.SetCellText(row+1,col,'Masraf Kodu');
  frmRaporCiktisi.SetCellText(row+1,col+1,'Adý');
  frmRaporCiktisi.SetCellText(row+1,col+2,'Açýklama');
  frmRaporCiktisi.SetCellText(row+1,col+3,'Borç');
  frmRaporCiktisi.SetCellText(row+1,col+4,'Alacak');
  frmRaporCiktisi.SetCellText(row+1,col+5,'B/A');
  frmRaporCiktisi.SetCellText(row+1,col+6,'Bakiye');
  frmRaporCiktisi.SetCellFont(col,row+1,col+7,row+1,[fsBold],8,'MS Sans Serif',4);
  Inc(row,2);
end;

procedure TfrmRaporMasrafListesi.FormKeyPress(Sender: TObject;
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

procedure TfrmRaporMasrafListesi.frxReport1BeforePrint(
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

procedure TfrmRaporMasrafListesi.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin

    if ARow.ByName('TOPLAM_BORC').AsFloat>ARow.ByName('TOPLAM_ALACAK').AsFloat then
    begin
        ARow.ByName('CALC_BA').AsString :='BORC';
        ARow.ByName('CALC_BAKIYE').AsFloat :=ARow.ByName('TOPLAM_BORC').AsFloat-ARow.ByName('TOPLAM_ALACAK').AsFloat;
    end;

    if ARow.ByName('TOPLAM_ALACAK').AsFloat>ARow.ByName('TOPLAM_BORC').AsFloat then
    begin
        ARow.ByName('CALC_BA').AsString :='ALACAK';
        ARow.ByName('CALC_BAKIYE').AsFloat :=ARow.ByName('TOPLAM_ALACAK').AsFloat-ARow.ByName('TOPLAM_BORC').AsFloat;
    end;
end;

end.
