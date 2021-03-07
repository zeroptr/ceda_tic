{$INCLUDE directive.inc}

unit ufrmRaporSerbestDekont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, IB_Components, frxClass, frxIBOSet;

type
  TfrmRaporSerbestDekont = class(TForm)
    pnlRAPKOD: TPanel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    chkRAPKOD: TCheckBox;
    Button5: TButton;
    txtKOD4: TEdit;
    Button4: TButton;
    txtKOD3: TEdit;
    Button3: TButton;
    txtKOD2: TEdit;
    Button2: TButton;
    txtKOD1: TEdit;
    Button1: TButton;
    txtISLEMMERKEZI: TEdit;
    Panel2: TPanel;
    Label2: TLabel;
    dtpIslemTar: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    qry_Dekont: TIB_Cursor;
    chk_Sirket: TCheckBox;
    qry_Dekont_D: TIB_Cursor;
    Panel1: TPanel;
    cmbSube: TComboBox;
    frxIBODts_Serbes_Dekont: TfrxIBODataset;
    IB_Query1: TIB_Query;
    frxReport1: TfrxReport;
    btnAraTar: TButton;
    btn_Fast: TButton;
    Button6: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure Rapor_Baslik_Ekle;
    procedure Rapor_Alan_Ekle;
    procedure Master_Data_Yaz;
    procedure Detail_Data_Yaz;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnAraTarClick(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure chkRAPKODEnter(Sender: TObject);
    procedure chkRAPKODExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpIslemTarEnter(Sender: TObject);
    procedure dtpIslemTarExit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Button6Click(Sender: TObject);
    procedure btn_FastClick(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
  private
    row,col:integer;
    qryTemp : TIB_Query;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_serbest_dekont = 15;

var
  frmRaporSerbestDekont: TfrmRaporSerbestDekont;


implementation

uses unDataMod,ufrmRaporCiktisi,main,unFunc;

{$R *.dfm}

procedure TfrmRaporSerbestDekont.Form_Open;
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if DataMod.Modul_Hak(cns_serbest_dekont,local_CanUpdate,local_CanDelete)=False then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporSerbestDekont') then
    begin
      Application.CreateForm(TfrmRaporSerbestDekont,frmRaporSerbestDekont);
      frmRaporSerbestDekont.dtpIslemTar.DateTime := glb_DONEM_BAS;
      frmRaporSerbestDekont.dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;

  {$IfDef TRANSPORT}
        frmRaporSerbestDekont.pnlRAPKOD.Visible := false;
  {$EndIf}

      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          frmRaporSerbestDekont.panel1.Visible := True;
          DataMod.FillSubeStr(frmRaporSerbestDekont.cmbSube.Items);
          frmRaporSerbestDekont.cmbSube.ItemIndex := 0;
        end
        else
        begin
          with frmRaporSerbestDekont.cmbSube do
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
        frmRaporSerbestDekont.panel1.Visible := False;
      end;
    end;
  end;
end;

procedure TfrmRaporSerbestDekont.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qry_Dekont.Close;
  qry_Dekont_D.Close;
  Action := caFree;
end;

procedure TfrmRaporSerbestDekont.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSerbestDekont.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSerbestDekont.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSerbestDekont.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSerbestDekont.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporSerbestDekont.btnAraTarClick(Sender: TObject);
var
  WhereEk:Boolean;
  SubeID:String;
begin
  WhereEk := false;
  with qry_Dekont do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add('SELECT DEKONT.ISLEM_TAR');
    SQL.Add('     , DEKONT.ACIKLAMA');
    SQL.Add('     , DEKONT.DEKONT_ID');
    SQL.Add('     , DEKONT.DEKONT_SID');
    SQL.Add('     , DEKONT.MASRAF_MERK');
//    SQL.Add('     ,(SELECT SUM(DEKONT_D.TUTAR_VPB) FROM DEKONT_D WHERE (DEKONT_D.DEKONT_ID = DEKONT.DEKONT_ID) and (DEKONT_D.DEKONT_SID = DEKONT.DEKONT_SID)) as DEKONT_TOPLAMI');
    SQL.Add('     FROM DEKONT ');
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add('WHERE DEKONT.DEKONT_SID = ' + SubeID);
        WhereEk := True;
      end;
    end
    else
    begin
      SQL.Add('WHERE DEKONT.DEKONT_SID = ' + IntToStr(glb_SID));
      WhereEk := True;
    end;
    if chkRAPKOD.Checked then
    begin
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.KOD1 = '+ SQL_Katar(txtKOD1.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.KOD1 = '+SQL_Katar(txtKOD1.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.KOD2 = '+SQL_Katar(txtKOD2.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.KOD2 = '+SQL_Katar(txtKOD2.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.KOD3 = '+SQL_Katar(txtKOD3.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.KOD3 = '+SQL_Katar(txtKOD3.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.KOD4 = '+SQL_Katar(txtKOD4.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.KOD4 = '+SQL_Katar(txtKOD4.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    end;//end chkRAPKOD.checked
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=False)) then
    begin
      if WhereEk then
      begin
        SQL.Add(' AND ISLEM_TAR = '+SQL_Tarih(dtpIslemTar.Date));
      end
      else
      begin
        SQL.Add(' WHERE ISLEM_TAR = '+SQL_Tarih(dtpIslemTar.Date));
        WhereEk := True;
      end;
    end;

    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        SQL.Add(' AND ISLEM_TAR BETWEEN '+SQL_Tarih(dtpIslemTar.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date));
      end
      else
      begin
        SQL.Add(' WHERE ISLEM_TAR BETWEEN '+SQL_Tarih(dtpIslemTar.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date));
        WhereEk := True;
      end;
    end;

    if ((dtpIslemTar.Checked=False) and (dtpIslemTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        SQL.Add(' AND ISLEM_TAR < '+SQL_Tarih(dtpIslemTar2.Date));
      end
      else
      begin
        SQL.Add(' WHERE ISLEM_TAR <'+SQL_Tarih(dtpIslemTar2.Date));
      end;
    end;
    SQL.Add(' ORDER BY DEKONT.DEKONT_ID,DEKONT.ISLEM_TAR');
  end;
  try
    qry_Dekont.Active := True;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu','Dikkat',MB_ICONSTOP);
  end;

  if ((qry_Dekont.Eof) and (qry_Dekont.Bof)) then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qry_Dekont.Close;
    qry_Dekont_D.Close;
    exit;
  end
  else
  begin
    row := 0;
    col := 0;
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    Rapor_Baslik_Ekle;
    Rapor_Alan_Ekle;
    Master_Data_Yaz;
   // frmRaporCiktisi.SetCellFormat(5,4,5,frmRaporCiktisi.grdA.ActiveSheet.RowCount,3);
    frmRaporCiktisi.SetCellFont(0,1,14,1,[fsBold],8,'MS Sans Serif',4);
    frmRaporCiktisi.SetCellFont(0,2,14,2,[fsBold],8,'MS Sans Serif',0);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qry_Dekont.Close;
    qry_Dekont_D.Close;
  end;
end;

procedure TfrmRaporSerbestDekont.Rapor_Baslik_Ekle;
var
  res_Cari : TStringList;
begin
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 0;
  end;
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  frmRaporCiktisi.SetCellText(row,col+2,'SERBEST DEKONT LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
end;

procedure TfrmRaporSerbestDekont.Rapor_Alan_Ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Dekont No');
  frmRaporCiktisi.SetCellText(row,col+1,'Ýþlem Tarihi');
  frmRaporCiktisi.SetCellText(row,col+2,'Açýklama');

  {$IfnDef TRANSPORT}
  frmRaporCiktisi.SetCellText(row,col+3,'Ýþlem Merkezi');
  {$EndIf}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  frmRaporCiktisi.SetCellText(row+1,col+1,'MC');
  frmRaporCiktisi.SetCellText(row+1,col+2,'BA');
  frmRaporCiktisi.SetCellText(row+1,col+3,'Karþý Kod');
  frmRaporCiktisi.SetCellText(row+1,col+4,'Karþý Ad');
  frmRaporCiktisi.SetCellText(row+1,col+5,'Para Birimi');
  frmRaporCiktisi.SetCellText(row+1,col+6,'Döviz Kuru');
  frmRaporCiktisi.SetCellText(row+1,col+7,'Tutar');
  frmRaporCiktisi.SetCellText(row+1,col+8,'Tutar VPB');
  frmRaporCiktisi.SetCellText(row+1,col+9,'Açýklama');
  {$IfnDef TRANSPORT}
  frmRaporCiktisi.SetCellText(row+1,col+10,'Proje Kodu');
  {$EndIf}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmRaporSerbestDekont.Master_Data_Yaz;
begin
  DataMod.CreateQuery(qryTemp,nil,False,DataMod.dbaMain);

  qry_Dekont.First;
  qry_Dekont_D.Prepare;
  while not (qry_Dekont.Eof) do
  begin
    row := row + 2;
    col := 0;
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont.FieldByName('DEKONT_ID').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont.FieldByName('ISLEM_TAR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont.FieldByName('ACIKLAMA').AsString);

  {$IfnDef TRANSPORT}
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont.FieldByName('MASRAF_MERK').AsString);
  {$EndIf}

    frmRaporCiktisi.setcellfont(0,row,col,row,[fsBold],8,'MS Sans Serif',4);

    Detail_Data_Yaz;
    qry_Dekont.Next;
  end;
  DataMod.ReleaseQuery(qryTemp);
  qry_Dekont.Active := False;
end;

procedure TfrmRaporSerbestDekont.Detail_Data_Yaz;
begin
  with qry_Dekont_D do
  begin
    Active := False;
    ParamByName('PRM_DEKONT_ID').AsInteger := qry_Dekont.FieldByName('DEKONT_ID').AsInteger;
    ParamByName('PRM_DEKONT_SID').AsSmallint := qry_Dekont.FieldByName('DEKONT_SID').AsSmallint;
    Active := True;
  end;

  qry_Dekont_D.First;
  while not (qry_Dekont_D.Eof) do
  begin
    inc(row);
    col := 1;
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont_D.FieldByName('MC').AsString);
    inc(col);
    with qryTemp do
    begin
      Active := False;
      SQL.Clear;
      if qry_Dekont_D.FieldByName('MC').AsString = 'C' then
      begin
        SQL.Add('SELECT CARI_AD AS KARSI_AD FROM CARI WHERE CARI_KOD = ' + SQL_Katar(qry_Dekont_D.FieldByName('KARSI_KOD').AsString));
      end
      else
      begin


        //Lite
        //SQL.Add('SELECT HESAP_ADI AS KARSI_AD FROM MUH_PLAN WHERE HESAP_KOD = ' + SQL_Katar(qry_Dekont_D.FieldByName('KARSI_KOD').AsString));
      end;
      Active := True;
    end;

    DataMod.Rapor_Satir_Renklendir(col,row,9);

    frmRaporCiktisi.SetCellText(row,col,qry_Dekont_D.FieldByName('BA').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont_D.FieldByName('KARSI_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryTemp.FieldByName('KARSI_AD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,' '+qry_Dekont_D.FieldByName('DOVKOD').AsString);
    inc(col);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont_D.FieldByName('DOVKUR').AsString);
    inc(col);
    if qry_Dekont_D.FieldByName('DOVKOD').AsString = glb_DEFCUR then
    begin
      frmRaporCiktisi.format_ayarla(col,row,col,row);
    end
    else
    begin
      frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;

    frmRaporCiktisi.SetCellText(row,col,qry_Dekont_D.FieldByName('TUTAR').AsString);
    inc(col);
    //frmRaporCiktisi.format_ayarla(col,row,col,row);
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont_D.FieldByName('TUTAR_VPB').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont_D.FieldByName('ACIKLAMA1').AsString);
  {$IfnDef TRANSPORT}
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qry_Dekont_D.FieldByName('PROJE_KOD').AsString);
  {$EndIf}

    qry_Dekont_D.Next;
  end;
  qry_Dekont_D.Active := False;
end;


procedure TfrmRaporSerbestDekont.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSerbestDekont.txtISLEMMERKEZIExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmRaporSerbestDekont.chkRAPKODEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSerbestDekont.chkRAPKODExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporSerbestDekont.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporSerbestDekont);
end;

procedure TfrmRaporSerbestDekont.dtpIslemTarEnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSerbestDekont.dtpIslemTarExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporSerbestDekont.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSerbestDekont.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporSerbestDekont.FormKeyPress(Sender: TObject;
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

procedure TfrmRaporSerbestDekont.Button6Click(Sender: TObject);
begin
   Close;
end;

procedure TfrmRaporSerbestDekont.btn_FastClick(Sender: TObject);
var
  WhereEk:Boolean;
  SubeID:String;
begin
IB_Query1.Active:=False;
IB_Query1.Sql.Clear;
with IB_Query1 Do
begin
Sql.Add(
'SELECT DEKONT.ISLEM_TAR '+
', DEKONT.ACIKLAMA '+
', DEKONT.DEKONT_ID '+
', DEKONT.DEKONT_SID '+
', DEKONT.MASRAF_MERK '+
',DEKONT_D.MC, '+
'DEKONT_D.BA, '+
'DEKONT_D.KARSI_KOD, '+
'DEKONT_D.DOVKOD, '+
'DEKONT_D.DOVKUR, '+
'DEKONT_D.TUTAR, '+
'DEKONT_D.TUTAR_VPB, '+
'DEKONT_D.PROJE_KOD, '+
'DEKONT_D.ACIKLAMA1 '+
'FROM DEKONT '+
'LEFT OUTER JOIN DEKONT_D ON ( DEKONT_D.DEKONT_ID=DEKONT.DEKONT_ID AND DEKONT_D.DEKONT_SID=DEKONT.DEKONT_SID) ');


    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add('WHERE DEKONT.DEKONT_SID = ' + SubeID);
        WhereEk := True;
      end;
    end
    else
    begin
      SQL.Add('WHERE DEKONT.DEKONT_SID = ' + IntToStr(glb_SID));
      WhereEk := True;
    end;
    if chkRAPKOD.Checked then
    begin
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.KOD1 = '+ SQL_Katar(txtKOD1.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.KOD1 = '+SQL_Katar(txtKOD1.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.KOD2 = '+SQL_Katar(txtKOD2.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.KOD2 = '+SQL_Katar(txtKOD2.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.KOD3 = '+SQL_Katar(txtKOD3.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.KOD3 = '+SQL_Katar(txtKOD3.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          sql.Add (' AND DEKONT.KOD4 = '+SQL_Katar(txtKOD4.Text));
        end
        else
        begin
          sql.Add (' WHERE DEKONT.KOD4 = '+SQL_Katar(txtKOD4.Text));
          WhereEk := True;
        end
      end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    end;//end chkRAPKOD.checked
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=False)) then
    begin
      if WhereEk then
      begin
        SQL.Add(' AND ISLEM_TAR = '+SQL_Tarih(dtpIslemTar.Date));
      end
      else
      begin
        SQL.Add(' WHERE ISLEM_TAR = '+SQL_Tarih(dtpIslemTar.Date));
        WhereEk := True;
      end;
    end;

    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        SQL.Add(' AND ISLEM_TAR BETWEEN '+SQL_Tarih(dtpIslemTar.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date));
      end
      else
      begin
        SQL.Add(' WHERE ISLEM_TAR BETWEEN '+SQL_Tarih(dtpIslemTar.Date)+' AND '+SQL_Tarih(dtpIslemTar2.Date));
        WhereEk := True;
      end;
    end;

    if ((dtpIslemTar.Checked=False) and (dtpIslemTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        SQL.Add(' AND ISLEM_TAR < '+SQL_Tarih(dtpIslemTar2.Date));
      end
      else
      begin
        SQL.Add(' WHERE ISLEM_TAR <'+SQL_Tarih(dtpIslemTar2.Date));
      end;
    end;

    SQL.Add(' ORDER BY DEKONT.DEKONT_ID,DEKONT.ISLEM_TAR');
  end;

  try
    IB_Query1.Active := True;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu','Dikkat',MB_ICONSTOP);
  end;

  if ((IB_Query1.Eof) and (IB_Query1.Bof)) then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    IB_Query1.Close;
    exit;
  end;


          Prv_Yazdirildi:=False;
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Serbest_Dekont.fr3');
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

procedure TfrmRaporSerbestDekont.frxReport1BeforePrint(
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
       c.memo.Text:=DateToStr(dtpIslemTar.Date);


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);

       Prv_Yazdirildi:=True;
    end;


end;

procedure TfrmRaporSerbestDekont.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
    if ARow.ByName('MC').AsString = 'C' then
    begin
    DataMod.CreateQuery(qryTemp,nil,False,DataMod.dbaMain);
    with qryTemp do
    begin
      Active := False;
      SQL.Clear;
      if ARow.ByName('MC').AsString = 'C' then
      begin
        SQL.Add('SELECT CARI_AD AS KARSI_AD FROM CARI WHERE CARI_KOD = ' + SQL_Katar(qry_Dekont_D.FieldByName('KARSI_KOD').AsString));
        Active := True;
        ARow.ByName('CALC_KARS_AD').AsString :=qryTemp.FieldByName('KARSI_AD').AsString;
      end
      else
      begin
        //Lite
        //SQL.Add('SELECT HESAP_ADI AS KARSI_AD FROM MUH_PLAN WHERE HESAP_KOD = ' + SQL_Katar(qry_Dekont_D.FieldByName('KARSI_KOD').AsString));
      //Active := True;
      end;
    end;
    end;
end;

end.
