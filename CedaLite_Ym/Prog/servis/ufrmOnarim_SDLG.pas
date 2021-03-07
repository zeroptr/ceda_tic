{$INCLUDE directive.inc}

unit ufrmOnarim_SDLG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, IB_Components, Grids, IB_Grid, ComCtrls,
  Mask, IB_Controls, frxClass, frxIBOSet;

type
  TfrmOnarim_SDLG = class(TForm)
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
    cmbSube: TComboBox;
    cb_Yazdirildi: TCheckBox;
    frxReport1: TfrxReport;
    frxIBODts_Onarim_Fis_Lis: TfrxIBODataset;
    btn_Fast: TButton;
    txtArac: TEdit;
    Button6: TButton;
    Label5: TLabel;
    LblPlaka: TLabel;
    GroupBox5: TGroupBox;
    Label6: TLabel;
    dtpIslemTart: TDateTimePicker;
    dtpIslemTart2: TDateTimePicker;
    Label10: TLabel;
    IB_Grid2: TIB_Grid;
    qryURUNHAR: TIB_Query;
    dtsURUNHAR: TIB_DataSource;
    cb_Iptal: TCheckBox;
    cb_Fatura: TCheckBox;
    IB_Query1: TIB_Query;
    frxIBODts_On_Fis_Lis_Det: TfrxIBODataset;
    CheckBox3: TCheckBox;
    procedure btnCariClick(Sender: TObject);
    function Form_Open(Menu:Boolean;var ONARIM_ID:Integer;var ONARIM_SID:Integer;RAPOR:Boolean):Boolean;
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
    procedure txtKOD4KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Grid1CellDblClick(Sender: TObject; ACol, ARow: Integer; AButton: TMouseButton; AShift: TShiftState);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure Button6Click(Sender: TObject);
    procedure txtAracExit(Sender: TObject);
    procedure qryFAT_IRSAfterScroll(IB_Dataset: TIB_Dataset);
  private
    { Private declarations }
    Prv_Yazdirildi:Boolean;
    prv_Kontrol:Boolean;
    prv_Cari_KOD:String;
    strSQL1,strSQL,Temp_Sql:String;
  public
    { Public declarations }
  end;

var
  frmOnarim_SDLG: TfrmOnarim_SDLG;

implementation

uses ufrmCariSDLG, unDataMod,unFunc, ufrmRaporCiktisi, main;

{$R *.DFM}

function TfrmOnarim_SDLG.Form_Open(Menu:Boolean;var ONARIM_ID:Integer;var ONARIM_SID:Integer;RAPOR:Boolean):Boolean;
begin
  if not MainForm.FindChildFrm(Application,'frmOnarim_SDLG') then
  Application.CreateForm(TfrmOnarim_SDLG, frmOnarim_SDLG);

  with frmOnarim_SDLG do
  begin
    DataMod.Rapor_Kod_Visible_Fields('ONR'
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
  {$IfDef TRANSPORT}
        pnlRAPKOD.Visible := false;
  {$EndIf}

    dtpIslemTar.Date := glb_DONEM_BAS;
    dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
    prv_Cari_KOD:= '';
    prv_Kontrol := False ;
    //lbl_CARI.Caption := '';
    //lbl_CARIKOD.Caption := '';

    //frmFaturaSDLG.btn_AraClick(Self);
    if Rapor then
    begin
      btn_Fast.Visible := True;
      CheckBox3.Visible := True;
      btnIPTAL.Visible := False;
      btnTAMAM.Visible := False;
    end
    else
    begin
      btn_Fast.Visible := False;
      CheckBox3.Visible := False;
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

    Temp_Sql:=IB_Query1.Sql.Text;

    ShowModal;


    if not prv_Kontrol Then
    begin
      ONARIM_ID := 0;
      ONARIM_SID := 0;
      Result := False;
    end
    else
    begin
      ONARIM_ID := qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger;
      ONARIM_SID := qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger;
      Result := True;
    end;
    qryFAT_IRS.Close;
    Release;
  end;
end;

procedure TfrmOnarim_SDLG.btnCariClick(Sender: TObject);
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

procedure TfrmOnarim_SDLG.btn_AraClick(Sender: TObject);
var
SubeID:String;
begin
  {strSQL := 'SELECT FATURA_ID,FATURA_SID,TARIH,FATSERI,FATURA_NO,CARI_KOD'
          + ',(Select CARI.CARI_AD FROM CARI WHERE CARI.CARI_KOD=FATURA.CARI_KOD) As CARI_AD'
          + ',GENEL_TOP,ACIKLAMA FROM FATURA WHERE TIP=' + IntToStr(prv_Fatura_Tip);}
{  strSQL := 'SELECT '
           +'  ONARIM_ID'
           +', ONARIM_SID'
           +', GIRIS_TARIH'
           +', CARI_KOD'
           +', (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=SRV_ARAC_ONARIM.CARI_KOD ) As CARI_AD'
           +', ARAC_KODU '
           +',(SELECT PLAKA FROM SRV_ARAC WHERE SRV_ARAC_ONARIM.ARAC_KODU=SRV_ARAC.ARAC_KOD) AS ARAC_PLAKA'
           +', GENEL_TOP'
           +', ACIKLAMA'
           +' FROM SRV_ARAC_ONARIM'
           +' WHERE  ONARIM_ID>0 ';
}
strSQL1 :=
'SELECT ONARIM_ID '+
'     , ONARIM_SID '+
'     , ARAC_KODU '+
'     ,(SELECT PLAKA FROM SRV_ARAC WHERE SRV_ARAC_ONARIM.ARAC_KODU=SRV_ARAC.ARAC_KOD) AS ARAC_PLAKA '+
'     , GELIS_NEDENI '+
'     , GIRIS_KM '+
'     , ONCEKI_KM '+
'     , ODEME_SEKLI '+
'     , YAKIT_SEVIYESI '+
'     , GARANTI_ISLEMI '+
'     , EXSPERTIZ_ISLEMI '+
'     , SOK_PAR_IADE '+
'     , TESLIM_EDEN '+
'     , ALACAK_OLAN '+
'     , TELEFON '+
'     , SIGORTA_KOD '+
'     , TESLIM_TAR '+
'     , TESLIM_SAAT '+
'     , TAHMINI_PARCA_TUTAR '+
'     , TAHMINI_ISCILIK_TUTAR '+
'     , GIRIS_TARIH '+
'     , GIRIS_SAAT '+
'     , ONARIM_ISTEKLERI '+
'     , MUSTERI_SIKAYETI '+
'     , SERVIS_NOTU '+
'     , YAZILDI '+
'     , ACIKLAMA '+
'     , BRUT_TOP '+
'     , NET_TOP '+
'     , GENEL_TOP '+
'     , KDV_TOP '+
'     , DEPO_KOD '+
'     , SAAT '+
'     , KALEM_ISKONTO_TOPLAM_VPB '+
'     , ISKONTO_TIP '+
'     , ISKONTO_ORAN '+
'     , ISKONTO_TUTAR_VPB '+
'     , ISKONTO_TOPLAM_VPB '+
'     , KDV1 '+
'     , KDV2 '+
'     , KDV3 '+
'     , KDV4 '+
'     , KDV5 '+
'     , OTV '+
'     , VADE_GUN '+
'     , VADE_TARIH '+
'     , KDV1_ORAN '+
'     , KDV2_ORAN '+
'     , KDV3_ORAN '+
'     , KDV4_ORAN '+
'     , KDV5_ORAN '+
'     , ODEMETAR '+
'     , PROJE_KOD '+
'     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=SRV_ARAC_ONARIM.PROJE_KOD) As PROJE_AD '+
'     , MASRAF_MERK '+
'     , KOD1 '+
'     , KOD2 '+
'     , KOD3 '+
'     , KOD4 '+
'     , SECIM '+
'     , KAPANDI '+
'     , SEVK_ADRES_KOD '+
'     , CARI_KOD '+
'     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ONARIM.CARI_KOD) AS CARI_ADI '+
'FROM SRV_ARAC_ONARIM '+
'WHERE SRV_ARAC_ONARIM.ONARIM_ID>0 ';





    strSQL :='';

    if Fat_No.Text <> '' then
    begin
       strSQL := strSQL + ' AND SRV_ARAC_ONARIM.ONARIM_ID = ' + Fat_No.Text;
    end;


    if chkCari.Checked then
    begin
      prv_Cari_KOD:=lbl_CARIKOD.Caption;
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.CARI_KOD='+ SQL_Katar(prv_Cari_KOD);
    end;


    if txtArac.Text <>'' then
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.ARAC_KODU='+ SQL_Katar(txtArac.Text);
    end;



    if chkRAPKOD.Checked then
    begin
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND SRV_ARAC_ONARIM.MASRAF_MERK = ' + SQL_Katar(txtISLEMMERKEZI.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND SRV_ARAC_ONARIM.KOD1 = ' + SQL_Katar(txtKOD1.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND SRV_ARAC_ONARIM.KOD2 = ' + SQL_Katar(txtKOD2.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND SRV_ARAC_ONARIM.KOD3 = ' + SQL_Katar(txtKOD3.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND SRV_ARAC_ONARIM.KOD4 = '+ SQL_Katar(txtKOD4.Text);
      end;
    end;//end chkRAPKOD.checked


    if  ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=False)) Then
    begin
      strSQL := strSQL + ' And SRV_ARAC_ONARIM.GIRIS_TARIH=' + SQL_Tarih(dtpIslemTar.Date);
    end;

    if ((dtpIslemTar.Checked=False) and (dtpIslemTar2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.GIRIS_TARIH<=' + SQL_Tarih(dtpIslemTar2.Date);
    end;

    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.GIRIS_TARIH BETWEEN ' + SQL_Tarih(dtpIslemTar.Date) + ' AND ' + SQL_Tarih(dtpIslemTar2.Date);
    end;




    if  ((dtpIslemTart.Checked=True) and (dtpIslemTart2.Checked=False)) Then
    begin
      strSQL := strSQL + ' And SRV_ARAC_ONARIM.TESLIM_TAR=' + SQL_Tarih(dtpIslemTart.Date);
    end;

    if ((dtpIslemTart.Checked=False) and (dtpIslemTart2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.TESLIM_TAR<=' + SQL_Tarih(dtpIslemTart2.Date);
    end;

    if ((dtpIslemTart.Checked=True) and (dtpIslemTart2.Checked=True)) Then
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.TESLIM_TAR BETWEEN ' + SQL_Tarih(dtpIslemTart.Date) + ' AND ' + SQL_Tarih(dtpIslemTart2.Date);
    end;



    if ((tutar1.Value<>0) and (tutar2.Value = 0)) then
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.GENEL_TOP>= '+ SQL_Para(Tutar1.Value);
    end;

    if ((tutar1.Value=0) and (tutar2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.GENEL_TOP<= '+ SQL_Para(Tutar1.Value);
    end;

    if ((tutar1.Value<>0) and (tutar2.Value<>0)) then
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.GENEL_TOP BETWEEN ' + SQL_Para(Tutar1.Value) + ' AND ' + SQL_Para(Tutar2.Value);
    end;


    if cb_Yazdirildi.State<>cbGrayed then
    begin
        if cb_Yazdirildi.Checked then
        begin
          strSQL := strSQL + ' AND SRV_ARAC_ONARIM.YAZILDI=1 ';
        end;

        if not cb_Yazdirildi.Checked then
        begin
          strSQL := strSQL + ' AND SRV_ARAC_ONARIM.YAZILDI=0 ';
        end;
    end;

    if cb_Iptal.State<>cbGrayed then
    begin
        if cb_Iptal.Checked then
        begin
          strSQL := strSQL + ' AND SRV_ARAC_ONARIM.IPTAL=1 ';
        end;

        if not cb_Iptal.Checked then
        begin
          strSQL := strSQL + ' AND SRV_ARAC_ONARIM.IPTAL=0 ';
        end;
    end;


    if cb_Fatura.State<>cbGrayed then
    begin
        if cb_Fatura.Checked then
        begin
          strSQL := strSQL + ' AND SRV_ARAC_ONARIM.KAPANDI=''1'' ';
        end;

        if not cb_Fatura.Checked then
        begin
          strSQL := strSQL + ' AND SRV_ARAC_ONARIM.KAPANDI=''0'' ';
        end;
    end;





    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND SRV_ARAC_ONARIM.ONARIM_SID = ' + SubeID;
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND SRV_ARAC_ONARIM.ONARIM_SID = ' + inttostr(glb_sid);
    end;
//  strSQL := strSQL + ' ORDER BY GIRIS_TARIH,CARI_KOD,ARAC_KODU,GENEL_TOP';

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  try
    with qryFAT_IRS do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL1+strSQL+
      ' ORDER BY SRV_ARAC_ONARIM.GIRIS_TARIH,SRV_ARAC_ONARIM.CARI_KOD,SRV_ARAC_ONARIM.ARAC_KODU,SRV_ARAC_ONARIM.GENEL_TOP');
      Active := True;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL1+strSQL);
  end;
end;

procedure TfrmOnarim_SDLG.btnIPTALClick(Sender: TObject);
begin
  prv_Kontrol := False;
  Close;
end;

procedure TfrmOnarim_SDLG.btnTAMAMClick(Sender: TObject);
begin
  if not ((qryFAT_IRS.Eof) and (qryFAT_IRS.Bof)) Then
  begin
    prv_Kontrol := True;
    Close;
  end;
end;

procedure TfrmOnarim_SDLG.chkCariClick(Sender: TObject);
begin
  if chkCari.Checked=False then
  begin
    prv_Cari_KOD:= '' ;
    lbl_CARIKOD.Caption := '';
    lbl_CARI.Caption := '';
  end;
end;

procedure TfrmOnarim_SDLG.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmOnarim_SDLG.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmOnarim_SDLG.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmOnarim_SDLG.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmOnarim_SDLG.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmOnarim_SDLG.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TfrmOnarim_SDLG.txtKOD1Exit(Sender: TObject);
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

procedure TfrmOnarim_SDLG.txtKOD2Exit(Sender: TObject);
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

procedure TfrmOnarim_SDLG.txtKOD3Exit(Sender: TObject);
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

procedure TfrmOnarim_SDLG.txtKOD4Exit(Sender: TObject);
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

procedure TfrmOnarim_SDLG.btnRaporClick(Sender: TObject);
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


       if CheckBox3.Checked then
       begin

          IB_Query1.Active:=False;
          IB_Query1.Sql.Text:=Temp_Sql;
          IB_Query1.Sql.Add(' '+strSql);
          IB_Query1.Sql.Add(' ORDER BY O.ONARIM_ID,OD.URUNHAR_ID');
          IB_Query1.Active:=True;

          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Onarim_Fisi_Listesi_Det.fr3');

       end
       else
       begin
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Onarim_Fisi_Listesi.fr3');

       end;


       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;
  end;
{
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

    case prv_FAT_IRS_SEP of
    1:
      case prv_Fatura_Tip of
      1:SetCellText(row,col,'SATIÞ FATURASI LÝSTESÝ - ' + cmbFATURA_TIP.Text);
      2:SetCellText(row,col,'ALIÞ FATURASI LÝSTESÝ - ' + cmbFATURA_TIP.Text);
      end;

    2:
      case prv_Fatura_Tip of
      1:SetCellText(row,col,'SATIÞ ÝRSALÝYESÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
      2:SetCellText(row,col,'ALIÞ ÝRSALÝYESÝ LÝSTESÝ - ' + cmbFATURA_TIP.Text);
      end;

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
      DataMod.Rapor_Satir_Renklendir(Col,Row,7);
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
 }
end;

procedure TfrmOnarim_SDLG.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    prv_Kontrol :=True;
    Close;
  end;
end;

procedure TfrmOnarim_SDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmONARIM_SDLG);
  with frmONARIM_SDLG.qryFAT_IRS do
  begin
    FieldByName('GENEL_TOP').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmOnarim_SDLG.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim_SDLG.chkRAPKODEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim_SDLG.chkRAPKODExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmOnarim_SDLG.cmbTIPSECEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim_SDLG.cmbTIPSECExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmOnarim_SDLG.Fat_NoExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmOnarim_SDLG.dtpIslemTarEnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim_SDLG.dtpIslemTarExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmOnarim_SDLG.Tutar1Enter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim_SDLG.Tutar1Exit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure TfrmOnarim_SDLG.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmOnarim_SDLG.txtKOD4KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOnarim_SDLG.IB_Grid1CellDblClick(Sender: TObject; ACol,
  ARow: Integer; AButton: TMouseButton; AShift: TShiftState);
begin
//Showmessage(Inttostr(ARow)+'  '+Inttostr(ACol));
   btnTAMAMClick(Self);
end;

procedure TfrmOnarim_SDLG.frxReport1BeforePrint(
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
       c.memo.Text:=DateToStr(dtpIslemTar2.Date);


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);


       Prv_Yazdirildi:=True;
    end;


end;

procedure TfrmOnarim_SDLG.Button6Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 SASI_NO:String;
 MARKA_TIP:String;
begin
  if DataMod.LS_Arac_Srv(ARAC_KOD,PLAKA,CARI_KOD,SASI_NO,MARKA_TIP,'') then
  begin
      txtArac.Text := ARAC_KOD;
      LblPlaka.Caption:= PLAKA;
  end;


end;

procedure TfrmOnarim_SDLG.txtAracExit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
begin
  if Trim(txtArac.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('SRV_ARAC','ARAC_KOD','PLAKA',txtArac.Text,PLAKA) then
    begin
      LblPlaka.Caption := PLAKA;
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtArac.SetFocus;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
      LblPlaka.Caption := '';
  end;
end;

procedure TfrmOnarim_SDLG.qryFAT_IRSAfterScroll(IB_Dataset: TIB_Dataset);
begin
  qryURUNHAR.Active:=False;
  qryURUNHAR.ParamByName('PRM_ONARIM_SID').AsInteger:=qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger;
  qryURUNHAR.ParamByName('PRM_ONARIM_ID').AsInteger:=qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger;
  qryURUNHAR.Active:=TRue;
end;

end.
