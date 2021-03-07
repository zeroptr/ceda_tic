{$INCLUDE directive.inc}

unit ufrmAracMasrafSDGL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, IB_Grid, Mask, IB_Controls, StdCtrls, ExtCtrls, ComCtrls,
  Buttons, IB_Components;

type
  TfrmAracMasrafSDGL = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    btnCARI: TButton;
    Label2: TLabel;
    dtpTanzimTar1: TDateTimePicker;
    Label5: TLabel;
    dtpTanzimTar2: TDateTimePicker;
    Label1: TLabel;
    btn_Ara: TButton;
    lblKASA_AD: TLabel;
    lblKASA_KOD: TLabel;
    dts_Liste: TIB_DataSource;
    qry_Kasa_Liste: TIB_Query;
    IB_Grid1: TIB_Grid;
    txtFisNo: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    TutarBas: TIB_Currency;
    Label4: TLabel;
    TutarSon: TIB_Currency;
    chkTutar: TCheckBox;
    cmdCancel: TBitBtn;
    btnTamam: TBitBtn;
    pnlRAPKOD: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
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
    procedure btnCARIClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure btn_AraClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    function  Form_Open(Menu:Boolean; Var KASAHAR_ID:Integer;Var KASAHAR_SID:Integer):Boolean;
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
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure dtpTanzimTar1Enter(Sender: TObject);
    procedure dtpTanzimTar1Exit(Sender: TObject);
    procedure cboISLEMEnter(Sender: TObject);
    procedure cboISLEMExit(Sender: TObject);
    procedure TutarBasEnter(Sender: TObject);
    procedure TutarBasExit(Sender: TObject);
    procedure txtFisNoExit(Sender: TObject);
    procedure chkRAPKODEnter(Sender: TObject);
    procedure chkRAPKODExit(Sender: TObject);
  private
    { Private declarations }
  public
     Kontrol:Boolean;
    { Public declarations }
  end;
var
  frmAracMasrafSDGL: TfrmAracMasrafSDGL;

implementation

uses unDataMod,unFunc, DateUtils, ufrmCekSenSDLG, StdConvs;

{$R *.dfm}

procedure TfrmAracMasrafSDGL.btnCARIClick(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
    lblKASA_KOD.Caption := ARAC_KOD;
    lblKASA_AD.Caption := PLAKA;
  end;
end;

function TfrmAracMasrafSDGL.Form_Open(Menu:Boolean; Var KASAHAR_ID:Integer;Var KASAHAR_SID:Integer):Boolean;
begin
  Application.CreateForm(TfrmAracMasrafSDGL,frmAracMasrafSDGL);
  with frmAracMasrafSDGL do
  begin
    DataMod.Rapor_Kod_Visible_Fields('ARACHAR'
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
                                     ,Label8
                                     ,Label9
                                     ,Label10
                                     ,Label11
                                     ,Label12);
    dtpTanzimTar1.Date := glb_DONEM_BAS;
    dtpTanzimTar2.Date := DataMod.GET_SERVER_DATE;
    {if IslemTip <> 0 then
    begin
      cboISLEM.ItemIndex := islemtip -1;
      cboISLEM.Enabled :=False;
    end;
    if KasaKod = '' then
    begin
      if DataMod.GET_DEFAULT_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) then btnCARI.Enabled:=True;
      lblKASA_KOD.Caption := KASA_KOD;
      lblKASA_AD.Caption := KASA_AD;
      lblKASA_DOVKOD.Caption := KASA_DOVKOD;
    end
    else
    begin
      if DataMod.GET_KASA_FROM_KASA_KOD(KasaKod,KASA_AD,KASA_DOVKOD) then lblKASA_KOD.Caption := KasaKod;
      lblKASA_AD.Caption := KASA_AD;
      lblKASA_DOVKOD.Caption := KASA_DOVKOD;
      btnCARI.Enabled:=False;
    end;
        }
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

    TutarBas.DisplayFormat := glb_VPB_FIELD_PF;
    TutarSon.DisplayFormat := glb_VPB_FIELD_PF;

    ShowModal;
    if not Kontrol then
    begin
      KASAHAR_ID:=0;
      KASAHAR_SID:=0;
      Result := False;
    end
    else
    begin
      KASAHAR_ID:= qry_Kasa_Liste.FieldByName('ARACHAR_ID').AsInteger;
      KASAHAR_SID:=qry_Kasa_Liste.FieldByName('ARACHAR_SID').AsInteger;
    end;
    qry_Kasa_Liste.Close;
    Release;
  end;//with
end;

procedure TfrmAracMasrafSDGL.btnTamamClick(Sender: TObject);
begin
  if (qry_Kasa_Liste.Active = True) then
  begin
    if not (qry_Kasa_Liste.RecordCount = 0) then
    begin
      Kontrol := True;
      Close;
    end
    else
    begin
      Kontrol := False;
      Close;
    end;
  end
  else
  if Application.MessageBox('Arama yapmadýnýz forma geri dönmek için YES Cýkmak için NO','Dikkat',MB_YESNO) = IDNO then
  begin
    Kontrol := False;
    Close;
  end;
end;

procedure TfrmAracMasrafSDGL.cmdCancelClick(Sender: TObject);
begin
  Kontrol := False;
  Close;
end;

procedure TfrmAracMasrafSDGL.btn_AraClick(Sender: TObject);
var
  WhereEk:Boolean;
  strSQL,SubeID:String;
begin
{  if lblKASA_KOD.Caption = '' then
  begin
    Application.MessageBox('Önce Araç Seçmeniz Gerekiyor','Dikkat',MB_ICONSTOP);
    exit;
  end;
  }
  //////////////////////////////////////////////////////////////////////////////
  WhereEk := False;
  strSQL :=
  'SELECT ARACHAR_ID '+
  '   , ARACHAR_SID '+
  '   , ARAC_KOD '+
  '   ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=ARACHAR.ARAC_KOD) AS ARAC_PLAKA '+
  '   , TARIH '+
  '   , BA '+
  '   , DOVKOD '+
  '   , DOVKUR '+
  '   , TUTAR '+
  '   , TUTAR_VPB '+
  '   , ACIKLAMA '+
  '   , BELGE_TUR '+
  '   , BELGE_ID '+
  '   , BELGE_SID '+
  '   , SIRA_NO '+
  '   , MASRAF_MERK '+
  '   , KOD1 '+
  '   , KOD2 '+
  '   , KOD3 '+
  '   , KOD4 '+
  '   , DOV_BAZ_TAR '+
  'FROM ARACHAR K '+
  'WHERE BA=''B'' and BELGE_TUR='+ Inttostr(BT_ARAC_MASRAF)+' ';

  WhereEk:=True;
  if txtFisNo.Text <>'' then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND K.ARACHAR_ID = '+ txtFisNo.text;
    end
    else
    begin
      strSQL := strSQL + ' WHERE K.ARACHAR_ID = '+ txtFisNo.text;
      WhereEk := True;
    end;//end if WhereEk then

   { case cboISLEM.ItemIndex of
    0..5:
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.ISLEM_TIP = '+ IntToStr(cboISLEM.ItemIndex + 1);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.ISLEM_TIP = '+ IntToStr(cboISLEM.ItemIndex + 1);
        WhereEk := True;
      end;
    end;//end case cboISLEM.ItemIndex

    case cboTAHSIL.ItemIndex of
    0..1:
      if WhereEk then
      begin
        case cboTAHSIL.ItemIndex of
        0: strSQL := strSQL + ' AND K.TIP = '+ SQL_Katar(GIRIS);
        1: strSQL := strSQL + ' AND K.TIP = '+ SQL_Katar(CIKIS);
        end;
      end
      else
      begin
        case cboTAHSIL.ItemIndex of
        0: strSQL := strSQL + ' WHERE K.TIP = '+ SQL_Katar(GIRIS);
        1: strSQL := strSQL + ' WHERE K.TIP = '+ SQL_Katar(CIKIS);
        end;
        WhereEk := True;
      end
    end;//end case cboTAHSIL.ItemIndex of
    }
    if glb_SUBELI then
    begin
      if WhereEk then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND K.ARACHAR_SID = ' + SubeID;
        end;
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.ARACHAR_SID = ' + SubeID;
        WhereEk := True;
      end;
    end
    else
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.ARACHAR_SID = ' + inttostr(glb_sid);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.ARACHAR_SID = ' + inttostr(glb_sid);
        WhereEk := True;
      end;
    end;
  end
  else
  begin
    ////////////////////////////////////////////////////////////////////////
    if chkRAPKOD.Checked then
    begin
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD1 = '+ SQL_Katar(txtKOD1.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD1 = '+ SQL_Katar(txtKOD1.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD2 = ' + SQL_Katar(txtKOD2.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD3 = ' + SQL_Katar(txtKOD3.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD3 = '+ SQL_Katar(txtKOD3.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.KOD4 = ' + SQL_Katar(txtKOD4.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.KOD4 = ' + SQL_Katar(txtKOD4.Text);
          WhereEk := True;
        end
      end;
    //////////////////////////////////////////////////////////////////
    end;//end chkRAPKOD.checked
    ////////////////////////////////////////////////////////////////////////
   { case cboISLEM.ItemIndex of
    0..5:
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.ISLEM_TIP = '+ IntToStr(cboISLEM.ItemIndex + 1);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.ISLEM_TIP = '+ IntToStr(cboISLEM.ItemIndex + 1);
        WhereEk := True;
      end
    end;//end case cboISLEM.ItemIndex
    }
    if chkTutar.Checked then
    begin
      if Trim(TutarBas.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.TUTAR >= '+ SQL_Para(TutarBas.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.TUTAR >= '+ SQL_Para(TutarBas.Value);
          WhereEk := True;
        end;
      end;

      if Trim(TutarSon.Text) <>'' then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND K.TUTAR <= '+ SQL_Para(TutarSon.Value);
        end
        else
        begin
          strSQL := strSQL + ' WHERE K.TUTAR <= '+ SQL_Para(TutarSon.Value);
          WhereEk := True;
        end;
      end;
    end;
  {  /////////////////////////////////
    case cboTAHSIL.ItemIndex of
    0..1:
      if WhereEk then
      begin
        case cboTAHSIL.ItemIndex of
        0: strSQL := strSQL + ' AND K.TIP = '+ SQL_Katar(GIRIS);
        1: strSQL := strSQL + ' AND K.TIP = '+ SQL_Katar(CIKIS);
        end;
      end
      else
      begin
        case cboTAHSIL.ItemIndex of
        0: strSQL := strSQL + ' WHERE K.TIP = '+ SQL_Katar(GIRIS);
        1: strSQL := strSQL + ' WHERE K.TIP = '+ SQL_Katar(CIKIS);
        end;
        WhereEk := True;
      end
    end;//end case cboTAHSIL.ItemIndex of
     }
    //////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=True) and (dtpTanzimTar2.Checked=False)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.TARIH = '+ SQL_Tarih(dtpTanzimTar1.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.TARIH = '+ SQL_Tarih(dtpTanzimTar1.date);
        WhereEk := True;
      end;
    end;
    //////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=False) and (dtpTanzimTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.TARIH <= '+ SQL_Tarih(dtpTanzimTar2.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.TARIH <= '+ SQL_Tarih(dtpTanzimTar2.date);
        WhereEk := True;
      end;
    end;
    /////////////////////////////////////////////////////////////////////////
    if ((dtpTanzimTar1.Checked=True) and (dtpTanzimTar2.Checked=True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.TARIH BETWEEN ' + SQL_Tarih(dtpTanzimTar1.date) + ' AND ' + SQL_Tarih(dtpTanzimTar2.date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.TARIH BETWEEN ' + SQL_Tarih(dtpTanzimTar1.date) + ' AND ' + SQL_Tarih(dtpTanzimTar2.date);
        WhereEk := True;
      end;
    end;
    ////////////////////////////////////////////////////////////////////////////
    if glb_SUBELI then
    begin
      if WhereEk then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND K.ARACHAR_SID = ' + SubeID;
        end;
      end
      else
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
           strSQL := strSQL + ' WHERE K.ARACHAR_SID = ' + SubeID;
           WhereEk := True;
        end;
      end;
    end
    else
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND K.ARACHAR_SID = ' + inttostr(glb_sid);
      end
      else
      begin
        strSQL := strSQL + ' WHERE K.ARACHAR_SID = ' + inttostr(glb_sid);
        WhereEk := True;
      end;
    end;
    ////////////////////////////////////////////////////////////////////////////
  end;//end if txtFisNo.Text <>''

  if Trim(lblKASA_KOD.Caption)<>'' then
  if WhereEk then

  begin
    strSQL := strSQL + ' AND ARAC_KOD=' + SQL_Katar(lblKASA_KOD.Caption);
  end
  else
  begin
    strSQL := strSQL + ' WHERE ARAC_KOD='+ SQL_Katar(lblKASA_KOD.Caption);
  end;

  ////////////////////////////////////////////////////////////////////////////
  try
    with qry_Kasa_Liste do
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
  IB_Grid1.SetFocus;
end;

procedure TfrmAracMasrafSDGL.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then cmdCancelClick(self);
  if key = #13 then
  begin
    if ActiveControl = IB_Grid1 then
    begin
      btnTAMAMClick(Self);
      exit;
    end;
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmAracMasrafSDGL.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmAracMasrafSDGL.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmAracMasrafSDGL.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmAracMasrafSDGL.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmAracMasrafSDGL.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmAracMasrafSDGL.txtISLEMMERKEZIExit(Sender: TObject);
begin
  if Length(trim(Self.txtISLEMMERKEZI.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtISLEMMERKEZI,0) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtISLEMMERKEZI.SetFocus;
  end;
end;

procedure TfrmAracMasrafSDGL.txtKOD1Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD1.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD1,1) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD1.SetFocus;
  end;
end;

procedure TfrmAracMasrafSDGL.txtKOD2Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD2.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD2,2) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD2.SetFocus;
  end;
end;

procedure TfrmAracMasrafSDGL.txtKOD3Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD3.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD3,3) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD3.SetFocus;
  end;
end;

procedure TfrmAracMasrafSDGL.txtKOD4Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD4.Text)) = 0 then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD4,4) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD4.SetFocus;
  end;
end;

procedure TfrmAracMasrafSDGL.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    Kontrol :=True;
    Close;
  end;
end;

procedure TfrmAracMasrafSDGL.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmAracMasrafSDGL);
  with frmAracMasrafSDGL.qry_Kasa_Liste do
  begin
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_DOV_FIELD_PF;
  end;
  {$IfDef TRANSPORT}
     pnlRAPKOD.Visible:=False;
  {$EndIf}
end;

procedure TfrmAracMasrafSDGL.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmAracMasrafSDGL.dtpTanzimTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmAracMasrafSDGL.dtpTanzimTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmAracMasrafSDGL.cboISLEMEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmAracMasrafSDGL.cboISLEMExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmAracMasrafSDGL.TutarBasEnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmAracMasrafSDGL.TutarBasExit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure TfrmAracMasrafSDGL.txtFisNoExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmAracMasrafSDGL.chkRAPKODEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmAracMasrafSDGL.chkRAPKODExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

end.
