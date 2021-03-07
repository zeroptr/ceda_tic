unit ufrmSIP_SDLG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, IB_Components, Grids, IB_Grid, ComCtrls,
  Mask, IB_Controls, frxClass, frxIBOSet;

type
  TfrmSIP_SDLG = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    IB_Grid1: TIB_Grid;
    qryFAT_IRS: TIB_Query;
    dtsFAT_IRS: TIB_DataSource;
    btn_Ara: TButton;
    GroupBox1: TGroupBox;
    lbl_CARIKOD: TLabel;
    lbl_CARI: TLabel;
    btnCARI: TButton;
    chkCARI: TCheckBox;
    GroupBox2: TGroupBox;
    dtpIslemTar: TDateTimePicker;
    Label4: TLabel;
    dtpIslemTar2: TDateTimePicker;
    GroupBox3: TGroupBox;
    Tutar1: TIB_Currency;
    Tutar2: TIB_Currency;
    Label1: TLabel;
    GroupBox4: TGroupBox;
    Fat_No: TEdit;
    btnIPTAL: TBitBtn;
    btnTAMAM: TBitBtn;
    GroupBox6: TGroupBox;
    cmbFATURA_TIP: TComboBox;
    pnlRAPKOD: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    txtISLEMMERKEZI: TEdit;
    txtKOD1: TEdit;
    txtKOD2: TEdit;
    txtKOD3: TEdit;
    txtKOD4: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    chkRAPKOD: TCheckBox;
    cmbTIPSEC: TComboBox;
    btnRapor: TButton;
    cmbSube: TComboBox;
    frxIBODts_SiparisList: TfrxIBODataset;
    frxReport1: TfrxReport;
    btn_Fast: TButton;
    procedure btnCariClick(Sender: TObject);
    function Form_Open(Menu:Boolean;FAT_IRS_SEP:SmallInt;var FAT_IRS_ID:Integer;var FAT_IRS_SID:Integer;FAT_IRS_TIP:SmallInt;RAPOR:Boolean):Boolean;
    procedure btn_AraClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnTAMAMClick(Sender: TObject);
    procedure chkCariClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure txtKOD1Exit(Sender: TObject);
    procedure txtKOD2Exit(Sender: TObject);
    procedure txtKOD3Exit(Sender: TObject);
    procedure txtKOD4Exit(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure chkRAPKODEnter(Sender: TObject);
    procedure chkRAPKODExit(Sender: TObject);
    procedure cmbTIPSECEnter(Sender: TObject);
    procedure cmbTIPSECExit(Sender: TObject);
    procedure Fat_NoExit(Sender: TObject);
    procedure dtpIslemTarEnter(Sender: TObject);
    procedure dtpIslemTarExit(Sender: TObject);
    procedure Tutar1Enter(Sender: TObject);
    procedure Tutar1Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    { Private declarations }
    prv_FAT_IRS_SEP,prv_Fatura_Tip:SmallInt;
    prv_Kontrol:Boolean;
    prv_Cari_KOD:String;
    Prv_Yazdirildi:Boolean;
  public
    { Public declarations }
  end;

var
  frmSIP_SDLG: TfrmSIP_SDLG;

implementation

uses ufrmCariSDLG, unDataMod,unFunc, ufrmRaporCiktisi;

{$R *.DFM}

function TfrmSIP_SDLG.Form_Open(Menu:Boolean;FAT_IRS_SEP:Smallint;var FAT_IRS_ID:Integer;var FAT_IRS_SID:Integer;FAT_IRS_TIP:SmallInt;RAPOR:Boolean):Boolean;
begin
  Application.CreateForm(TfrmSIP_SDLG, frmSIP_SDLG);
  with frmSIP_SDLG do
  begin
    DataMod.Rapor_Kod_Visible_Fields('FAT'
                                     ,txtISLEMMERKEZI
                                     ,txtKOD1
                                     ,txtKOD2
                                     ,txtKOD3
                                     ,txtKOD4
                                     ,Button1
                                     ,Button2
                                     ,Button3
                                     ,Button4
                                     ,Button5
                                     ,Label2
                                     ,Label3
                                     ,Label7
                                     ,Label8
                                     ,Label9);
    pnlRAPKOD.Visible := (txtISLEMMERKEZI.Visible or txtKOD1.Visible or txtKOD2.Visible or txtKOD3.Visible or txtKOD4.Visible);
    dtpIslemTar.Date := glb_DONEM_BAS;
    dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
    prv_Fatura_Tip := FAT_IRS_TIP;
    prv_Cari_KOD:= '';
    prv_Kontrol := False ;
    prv_FAT_IRS_SEP := FAT_IRS_SEP;
    lbl_CARI.Caption := '';
    lbl_CARIKOD.Caption := '';

{    case FAT_IRS_TIP of
    1:
      begin
        cmbFATURA_TIP.Items.Clear;
        {cmbFATURA_TIP.Items.Add('KAPALI');
        cmbFATURA_TIP.Items.Add('AÇIK');
        cmbFATURA_TIP.Items.Add('ÝADE');
        cmbFATURA_TIP.Items.Add('ÝTHALAT / ÝHRACAT');
        cmbFATURA_TIP.Items.Add('HEPSÝ');
        cmbFATURA_TIP.ItemIndex := 4;

        cmbFATURA_TIP.Items.Add('Müþteri Sipariþ');
        cmbFATURA_TIP.Items.Add('Satýcý Sipariþ');
        cmbFATURA_TIP.Items.Add('HEPSÝ');
        cmbFATURA_TIP.ItemIndex := 2;
{
      end;
    2:
      begin
        cmbFATURA_TIP.Items.Clear;
        cmbFATURA_TIP.Items.Add('KAPALI');
        cmbFATURA_TIP.Items.Add('AÇIK');
        cmbFATURA_TIP.Items.Add('ÝADE');
        cmbFATURA_TIP.Items.Add('HEPSÝ');
        cmbFATURA_TIP.ItemIndex := 3;
      end;
    end;
    case FAT_IRS_SEP of
    1:case FAT_IRS_TIP of
       1: Caption := 'Satýþ Faturasý Listesi';
       2: Caption := 'Alýþ Faturasý Listesi';
      end;
    2:case FAT_IRS_TIP of
       1: Caption := 'Satýþ Irsaliyesi Listesi';
       2: Caption := 'Alýþ Irsaliyesi Listesi';
      end;
    end;
 }
    //frmFaturaSDLG.btn_AraClick(Self);
    if Rapor then
    begin
      btnRapor.Visible := True;
      btn_Fast.Visible := True;
      btnIPTAL.Visible := False;
      btnTAMAM.Visible := False;
    end
    else
    begin
      btnRapor.Visible := False;
      btn_Fast.Visible := False;
    end;

    if glb_SUBELI then
    begin
      if glb_SUBE_MUDAHALE then
      begin
        DataMod.FillSubeStr(cmbSube.Items);
        with cmbSube do
        begin
          ItemIndex := 0;
          Visible := True;
        end;
      end
      else
      begin
        with cmbSube do
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
      cmbSube.Visible := False;
    end;

    with cmbTIPSEC do
    begin
      Clear;
      {case FAT_IRS_SEP of
      1:
        begin
          Items.Add('Fiþ Numarasý');
          Items.Add('Fatura Numarasý');
        end;
      2:
        begin
          Items.Add('Fiþ Numarasý');
          Items.Add('Ýrsaliye Numarasý');
        end;
      end;
      }
      Items.Add('Fiþ Numarasý');
      Items.Add('Siparis Numarasý');
      ItemIndex := 0;
    end;

    ShowModal;
    if not prv_Kontrol Then
    begin
      FAT_IRS_ID := 0;
      FAT_IRS_SID := 0;
      Result := False;
    end
    else
    begin
      FAT_IRS_ID := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
      FAT_IRS_SID := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
      Result := True;
    end;
    qryFAT_IRS.Close;
    Release;
  end;
end;

procedure TfrmSIP_SDLG.btnCariClick(Sender: TObject);
var
  CARI_KOD,CARI_AD : String;
begin
  if frmCariSDLG.Form_Open(False,CARI_KOD,CARI_AD,1) Then
  begin
    chkCARI.Checked := True;
    lbl_CARIKOD.Caption := CARI_KOD;
    lbl_CARI.Caption := CARI_AD;
    prv_Cari_KOD := CARI_KOD;
  end;
end;

procedure TfrmSIP_SDLG.btn_AraClick(Sender: TObject);
var
  strSQL,SubeID:String;
begin
  {strSQL := 'SELECT FATURA_ID,FATURA_SID,TARIH,FATSERI,FATURA_NO,CARI_KOD'
          + ',(Select CARI.CARI_AD FROM CARI WHERE CARI.CARI_KOD=FATURA.CARI_KOD) As CARI_AD'
          + ',GENEL_TOP,ACIKLAMA FROM FATURA WHERE TIP=' + IntToStr(prv_Fatura_Tip);}
  strSQL := 'SELECT FAT_IRS_SEP'
           +', FAT_IRS_ID'
           +', FAT_IRS_SID'
           +', TARIH'
           +', CARI_KOD'
           +', (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=SIPARIS.CARI_KOD ) As CARI_AD'
           +', FAT_IRS_SERI'
           +', BELGE_NO'
           +', GENEL_TOP'
           +', ACIKLAMA'
           +' FROM SIPARIS'
           +' WHERE FAT_IRS_SEP = ' + IntToStr(prv_FAT_IRS_SEP)
           +' AND TIP = '+ IntToStr(prv_Fatura_Tip);

  if length(Trim(Fat_No.Text)) <> 0 then
  begin
    case cmbTIPSEC.ItemIndex of
    0:
      begin
        strSQL := strSQL + ' AND FAT_IRS_ID = '+ Fat_No.Text;
      end;//end case 0
    1:
      begin
        strSQL := strSQL + ' AND BELGE_NO = '+ Fat_No.Text;
      end;
    end;//end case
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND FAT_IRS_SID = ' + SubeID;
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND FAT_IRS_SID = ' + inttostr(glb_sid);
    end;
  end
  else
  begin
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
{    case prv_Fatura_Tip of
    1:
      begin
        if cmbFATURA_TIP.ItemIndex <> 4 then
        begin
          strSQL := strSQL + ' AND FAT_IRS_TIP = ' + SQL_Katar(IntToStr(cmbFATURA_TIP.ItemIndex+1));
        end;
      end;
    2:
      begin
        if cmbFATURA_TIP.ItemIndex <> 3 then
        begin
          strSQL := strSQL + ' AND FAT_IRS_TIP = ' + SQL_Katar(IntToStr(cmbFATURA_TIP.ItemIndex+1));
        end;
      end;
    end;
}
        //if cmbFATURA_TIP.ItemIndex <> 2 then

      //  if cmbFATURA_TIP.ItemIndex <> 2 then
       // begin
      //    strSQL := strSQL + ' AND FAT_IRS_TIP = ' + SQL_Katar(IntToStr(prv_Fatura_Tip));
       // end;

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if chkCari.Checked then
    begin
      strSQL := strSQL + ' AND CARI_KOD='+ SQL_Katar(prv_Cari_KOD);
    end;

    if chkRAPKOD.Checked then
    begin
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND MASRAF_MERK = ' + SQL_Katar(txtISLEMMERKEZI.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOD1 = ' + SQL_Katar(txtKOD1.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOD2 = ' + SQL_Katar(txtKOD2.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOD3 = ' + SQL_Katar(txtKOD3.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND KOD4 = '+ SQL_Katar(txtKOD4.Text);
      end;
    end;//end chkRAPKOD.checked


    if  ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=False)) Then
    begin
      strSQL := strSQL + ' And TARIH=' + SQL_Tarih(dtpIslemTar.Date);
    end;

    if ((dtpIslemTar.Checked=False) and (dtpIslemTar2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND TARIH<=' + SQL_Tarih(dtpIslemTar2.Date);
    end;

    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND TARIH BETWEEN ' + SQL_Tarih(dtpIslemTar.Date) + ' AND ' + SQL_Tarih(dtpIslemTar2.Date);
    end;

    if ((tutar1.Value<>0) and (tutar2.Value = 0)) then
    begin
      strSQL := strSQL + ' AND GENEL_TOP>= '+ SQL_Para(Tutar1.Value);
    end;

    if ((tutar1.Value=0) and (tutar2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND GENEL_TOP<= '+ SQL_Para(Tutar1.Value);
    end;

    if ((tutar1.Value<>0) and (tutar2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND GENEL_TOP BETWEEN ' + SQL_Para(Tutar1.Value) + ' AND ' + SQL_Para(Tutar2.Value);
    end;

    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND FAT_IRS_SID = ' + SubeID;
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND FAT_IRS_SID = ' + inttostr(glb_sid);
    end;
  end;//end else
  strSQL := strSQL + ' ORDER BY TARIH,CARI_KOD,GENEL_TOP';
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  try
    with qryFAT_IRS do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;
end;

procedure TfrmSIP_SDLG.btnIPTALClick(Sender: TObject);
begin
  prv_Kontrol := False;
  Close;
end;

procedure TfrmSIP_SDLG.btnTAMAMClick(Sender: TObject);
begin
  if not ((qryFAT_IRS.Eof) and (qryFAT_IRS.Bof)) Then
  begin
    prv_Kontrol := True;
    Close;
  end;
end;

procedure TfrmSIP_SDLG.chkCariClick(Sender: TObject);
begin
  if chkCari.Checked=False then
  begin
    prv_Cari_KOD:= '' ;
    lbl_CARIKOD.Caption := '';
    lbl_CARI.Caption := '';
  end;
end;

procedure TfrmSIP_SDLG.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmSIP_SDLG.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmSIP_SDLG.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmSIP_SDLG.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmSIP_SDLG.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmSIP_SDLG.txtISLEMMERKEZIExit(Sender: TObject);
begin
  if Length(trim(txtISLEMMERKEZI.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,txtISLEMMERKEZI,0) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    txtISLEMMERKEZI.SetFocus;
  end;
end;

procedure TfrmSIP_SDLG.txtKOD1Exit(Sender: TObject);
begin
  if Length(trim(txtKOD1.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,txtKOD1,1) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    txtKOD1.SetFocus;
  end;
end;

procedure TfrmSIP_SDLG.txtKOD2Exit(Sender: TObject);
begin
  if Length(trim(txtKOD2.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,txtKOD2,2) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    txtKOD2.SetFocus;
  end;
end;

procedure TfrmSIP_SDLG.txtKOD3Exit(Sender: TObject);
begin
  if Length(trim(txtKOD3.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,txtKOD3,3) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    txtKOD3.SetFocus;
  end;
end;

procedure TfrmSIP_SDLG.txtKOD4Exit(Sender: TObject);
begin
  if Length(trim(txtKOD4.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,txtKOD4,4) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    txtKOD4.SetFocus;
  end;
end;

procedure TfrmSIP_SDLG.btnRaporClick(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
begin
  if not qryFAT_IRS.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  if qryFAT_IRS.RecordCount = 0 then
  begin
    Application.MessageBox('Yapmýþ olduðunuz aramada hiçbir kayýda ulaþýlamadý.Lütfen kriterleri kontrol ediniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;

  if sender=Btn_Fast then
  begin
       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Siparis_Listesi.fr3');

       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;
  end;

  row := 0;
  col := 0;
////////////////////////////////////////////////////////////////////////////////
  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      SetCellText(row,col,res_Cari[1]);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    inc(row);
    case prv_Fatura_Tip of
    1:SetCellText(row,col,'MÜÞTERÝ SÝPARÝÞLERÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
    2:SetCellText(row,col,'SATICI SÝPARÝÞLERÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
    end;
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    inc(row);
    col:=0;
    SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    if chkCARI.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Cari Kod : '+ lbl_CARIKOD.Caption+' - Cari Ad : '+lbl_CARI.Caption);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;

    if ((dtpIslemTar.Checked) and (dtpIslemTar2.Checked)) then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + (DateToStr(dtpIslemTar.Date)+' > - < '+DateToStr(dtpIslemTar2.Date)));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar2.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar2.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;
    inc(row);
    col := 0;
    SetCellText(row,col,'Fiþ No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Tarih');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Seri');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Belge No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Cari Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Cari Ad');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Açýklama');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Genel Toplam');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(row);
    qryFAT_IRS.DisableControls;
    qryFAT_IRS.First;
    while not qryFAT_IRS.Eof do
    begin
      col := 0;
      SetCellText(row,col,qryFAT_IRS.FieldByName('FAT_IRS_ID').AsString);
      inc(col);
      SetCellText(row,col,qryFAT_IRS.FieldByName('TARIH').AsString);
      inc(col);
      SetCellText(row,col,qryFAT_IRS.FieldByName('FAT_IRS_SERI').AsString);
      inc(col);
      SetCellText(row,col,qryFAT_IRS.FieldByName('BELGE_NO').AsString);
      inc(col);
      SetCellText(row,col,qryFAT_IRS.FieldByName('CARI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryFAT_IRS.FieldByName('CARI_AD').AsString);
      inc(col);
      SetCellText(row,col,qryFAT_IRS.FieldByName('ACIKLAMA').AsString);
      inc(col);
      SetCellText(row,col,qryFAT_IRS.FieldByName('GENEL_TOP').AsString);
      inc(row);
      qryFAT_IRS.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    col := 7;
    SetCellText(row,col,'=SUM(H4:H'+IntToStr(row-1)+')');
    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    format_ayarla(7,3,7,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  qryFAT_IRS.First;
  qryFAT_IRS.EnableControls;

end;

procedure TfrmSIP_SDLG.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    prv_Kontrol :=True;
    Close;
  end;
end;

procedure TfrmSIP_SDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmSIP_SDLG);
  with frmSIP_SDLG.qryFAT_IRS do
  begin
    FieldByName('GENEL_TOP').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmSIP_SDLG.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSIP_SDLG.chkRAPKODEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSIP_SDLG.chkRAPKODExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmSIP_SDLG.cmbTIPSECEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSIP_SDLG.cmbTIPSECExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmSIP_SDLG.Fat_NoExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmSIP_SDLG.dtpIslemTarEnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSIP_SDLG.dtpIslemTarExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmSIP_SDLG.Tutar1Enter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSIP_SDLG.Tutar1Exit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure TfrmSIP_SDLG.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    btnIPTALClick(self);
  end;
  if key = #13 then
  begin
    if ActiveControl = IB_Grid1 then
    begin
      btnTAMAMClick(Self);
      exit;
    end;
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True);
  end;
end;

procedure TfrmSIP_SDLG.frxReport1BeforePrint(Sender: TfrxReportComponent);
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
       c.memo.Text:=DateToStr(dtpIslemTar2.Date);

       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
       Prv_Yazdirildi:=True;
    end;
end;

end.
