{$INCLUDE directive.inc}

unit ufrmDekontSDLG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, Buttons, ComCtrls, StdCtrls,
  ExtCtrls, Mask, IB_Controls;

type
  TfrmDekontSDLG = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    txtDekontKod: TEdit;
    btnAraTar: TButton;
    Panel1: TPanel;
    IB_Grid1: TIB_Grid;
    dts_Dekont: TIB_DataSource;
    cmdCancel: TBitBtn;
    btnTamam: TBitBtn;
    pnlRAPKOD: TPanel;
    chkRAPKOD: TCheckBox;
    Button5: TButton;
    txtKOD4: TEdit;
    Label9: TLabel;
    Button4: TButton;
    txtKOD3: TEdit;
    Label8: TLabel;
    Button3: TButton;
    txtKOD2: TEdit;
    Label7: TLabel;
    Button2: TButton;
    txtKOD1: TEdit;
    Label4: TLabel;
    Button1: TButton;
    txtISLEMMERKEZI: TEdit;
    Label3: TLabel;
    cmbSube: TComboBox;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    TutarBas: TIB_Currency;
    TutarSon: TIB_Currency;
    chkTutar: TCheckBox;
    GroupBox1: TGroupBox;
    dtpIslemTar: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    cmbIslemTip: TComboBox;
    qry_Dekont: TIB_Query;
    GroupBox3: TGroupBox;
    rgCM: TRadioGroup;
    txtKod: TEdit;
    btnLstCM: TButton;
    Label2: TLabel;
    chkKod: TCheckBox;
    Label10: TLabel;
    Edt_Ack: TEdit;
    function Form_Open(Menu:Boolean;Var Dekont_ID:Integer;var Dekont_SID:Integer;Tip:Byte):Boolean;
    procedure cmdCancelClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure btnAraTarClick(Sender: TObject);
    procedure txtDekontKodKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);
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
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure chkRAPKODEnter(Sender: TObject);
    procedure chkRAPKODExit(Sender: TObject);
    procedure txtDekontKodExit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure dtpIslemTarEnter(Sender: TObject);
    procedure dtpIslemTarExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtKodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLstCMClick(Sender: TObject);
    procedure rgCMEnter(Sender: TObject);
    procedure rgCMExit(Sender: TObject);
    procedure TutarBasEnter(Sender: TObject);
    procedure TutarBasExit(Sender: TObject);
  private
    { Private declarations }
    prv_Kontrol:Boolean;
    prv_tip : Byte;
  public
    { Public declarations }
  end;

var
  frmDekontSDLG: TfrmDekontSDLG;

implementation

uses unDataMod, Math, unFunc, ufrmCariSDLG;

{$R *.dfm}


function TfrmDekontSDLG.Form_Open(Menu:Boolean;Var Dekont_ID:Integer;var Dekont_SID:Integer;Tip:Byte):Boolean;
begin
  Application.CreateForm(TfrmDekontSDLG, frmDekontSDLG);
  DataMod.Rapor_Kod_Visible_Fields('DEKONT'
                                   ,frmDekontSDLG.txtISLEMMERKEZI
                                   ,frmDekontSDLG.txtKOD1
                                   ,frmDekontSDLG.txtKOD2
                                   ,frmDekontSDLG.txtKOD3
                                   ,frmDekontSDLG.txtKOD4
                                   ,frmDekontSDLG.Button1
                                   ,frmDekontSDLG.Button2
                                   ,frmDekontSDLG.Button3
                                   ,frmDekontSDLG.Button4
                                   ,frmDekontSDLG.Button5
                                   ,frmDekontSDLG.Label3
                                   ,frmDekontSDLG.Label4
                                   ,frmDekontSDLG.Label7
                                   ,frmDekontSDLG.Label8
                                   ,frmDekontSDLG.Label9);
  frmDekontSDLG.pnlRAPKOD.Visible := (frmDekontSDLG.txtISLEMMERKEZI.Visible OR frmDekontSDLG.txtKOD1.Visible OR frmDekontSDLG.txtKOD2.Visible OR frmDekontSDLG.txtKOD3.Visible OR frmDekontSDLG.txtKOD4.Visible );
  frmDekontSDLG.dtpIslemTar.DateTime := glb_DONEM_BAS;
  frmDekontSDLG.dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
  frmDekontSDLG.dtpIslemTar2.Checked := False;
  frmDekontSDLG.prv_tip := Tip;
  case frmDekontSDLG.prv_tip of
  1:frmDekontSDLG.Caption := 'Dekont Listesi';
  2:frmDekontSDLG.Caption := 'Ürün Dekontu Listesi';
  end;
  //frmDekontSDLG.qry_Dekont.FieldByName('DEKONT_TOPLAMI').DisplayFormat := glb_VPB_FIELD_PF;



  if glb_SUBELI then
  begin
    if glb_SUBE_MUDAHALE then
    begin
      DataMod.FillSubeStr(frmDekontSDLG.cmbSube.Items);
      with frmDekontSDLG.cmbSube do
      begin
        ItemIndex := 0;
        Visible := True;
      end;
    end
    else
    begin
      with frmDekontSDLG.cmbSube do
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
    frmDekontSDLG.cmbSube.Visible := False;
  end;

  frmDekontSDLG.ShowModal;
  if Not frmDekontSDLG.prv_Kontrol Then
  begin
    Dekont_ID := 0;
    Dekont_SID := 0;
    Result := False;
  end
  else
  begin
    Dekont_ID := frmDekontSDLG.qry_Dekont.FieldByName('DEKONT_ID').AsInteger;
    Dekont_SID := frmDekontSDLG.qry_Dekont.FieldByName('DEKONT_SID').AsInteger;
    Result := True;
  end;
  frmDekontSDLG.qry_Dekont.Close;
  frmDekontSDLG.Release;
end;


procedure TfrmDekontSDLG.cmdCancelClick(Sender: TObject);
begin
  prv_Kontrol := False;
  Close;
end;

procedure TfrmDekontSDLG.btnTamamClick(Sender: TObject);
begin
  prv_Kontrol := True;
  Close;
end;

procedure TfrmDekontSDLG.btnAraTarClick(Sender: TObject);
var
  strSQL,SubeID:String;
begin
  if chkKod.Checked then
  begin
    if Trim(txtKod.Text) = '' then
    begin
      txtKod.SetFocus;
      Application.MessageBox('Lütfen bir cari yada masraf kodu seçiniz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;

  if chkTutar.Checked then
  begin
    case cmbIslemTip.ItemIndex of
    0:
      begin
        strSQL := 'SELECT'
                 +' DEKONT.ISLEM_TAR,'
                 +'DEKONT.ACIKLAMA,'
                 +'DEKONT.DEKONT_ID,'
                 +'DEKONT.DEKONT_SID,'
                 +'DEKONT.CARI_KOD,'
                 +'(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=DEKONT.CARI_KOD) AS CARI_ADI,'
                 +'SUM(DEKONT_D.TUTAR_VPB) AS DEKONT_TOPLAMI'
                 +' FROM DEKONT'
                 +' INNER JOIN DEKONT_D ON (DEKONT_D.DEKONT_ID = DEKONT.DEKONT_ID AND DEKONT_D.DEKONT_SID = DEKONT.DEKONT_SID)'
                 +' WHERE (DEKONT_D.BA = '+SQL_Katar(BORC)+')'
                 +' AND DEKONT.TIP = '+IntToStr(prv_tip);
      end;
    1:
      begin
        strSQL := 'SELECT'
                 +' DEKONT.ISLEM_TAR,'
                 +'DEKONT.ACIKLAMA,'
                 +'DEKONT.DEKONT_ID,'
                 +'DEKONT.DEKONT_SID,'
                 +'DEKONT.CARI_KOD,'
                 +'(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=DEKONT.CARI_KOD) AS CARI_ADI,'
                 +'DEKONT_D.TUTAR_VPB'
                 +' FROM DEKONT'
                 +' INNER JOIN DEKONT_D ON (DEKONT_D.DEKONT_ID = DEKONT.DEKONT_ID AND DEKONT_D.DEKONT_SID = DEKONT.DEKONT_SID)'
                 //+' WHERE (DEKONT_D.BA = '+SQL_Katar(BORC)+')'
                 +' WHERE DEKONT.TIP = '+IntToStr(prv_tip);
//****************************************************************************//
        if chkKod.Checked then
        begin
          case rgCM.ItemIndex of
          0:strSQL := strSQL + ' AND DEKONT_D.MC='+SQL_Katar('C')+' AND DEKONT_D.KARSI_KOD = '+SQL_Katar(txtKod.Text);
          1:strSQL := strSQL + ' AND DEKONT_D.MC='+SQL_Katar('M')+' AND DEKONT_D.KARSI_KOD = '+SQL_Katar(txtKod.Text);
          end;
        end;
//****************************************************************************//
      end;
    end;
  end
  else
  begin
{
    strSQL := 'SELECT DEKONT.ISLEM_TAR,DEKONT.ACIKLAMA,DEKONT.DEKONT_ID,DEKONT.DEKONT_SID'
             +',(SELECT SUM(DEKONT_D.TUTAR_VPB) FROM DEKONT_D WHERE (DEKONT_D.DEKONT_ID = DEKONT.DEKONT_ID) and (DEKONT_D.DEKONT_SID = DEKONT.DEKONT_SID)'
             +' and (DEKONT_D.BA = '+ SQL_Katar(BORC) +')) as DEKONT_TOPLAMI FROM DEKONT WHERE DEKONT.TIP = '+IntToStr(prv_tip);
}

    strSQL := 'SELECT'
             +' DEKONT.ISLEM_TAR,'
             +'DEKONT.ACIKLAMA,'
             +'DEKONT.DEKONT_ID,'
             +'DEKONT.DEKONT_SID,'
             +'DEKONT.CARI_KOD,'
             +'(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=DEKONT.CARI_KOD) AS CARI_ADI,'
             +'SUM(DEKONT_D.TUTAR_VPB) AS DEKONT_TOPLAMI'
             +' FROM DEKONT'
             +' INNER JOIN DEKONT_D ON (DEKONT_D.DEKONT_ID = DEKONT.DEKONT_ID AND DEKONT_D.DEKONT_SID = DEKONT.DEKONT_SID)'
             +' WHERE DEKONT.TIP = '+IntToStr(prv_tip);
//****************************************************************************//
    if chkKod.Checked then
    begin
      case rgCM.ItemIndex of
      0:strSQL := strSQL + ' AND DEKONT_D.MC='+SQL_Katar('C')+' AND DEKONT_D.KARSI_KOD = '+SQL_Katar(txtKod.Text);
      1:strSQL := strSQL + ' AND DEKONT_D.MC='+SQL_Katar('M')+' AND DEKONT_D.KARSI_KOD = '+SQL_Katar(txtKod.Text);
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND DEKONT_D.BA = '+SQL_Katar(BORC);
    end;
//****************************************************************************//
  end;
//****************************************************************************//
  
    if Length(Trim(Edt_Ack.Text)) <> 0 then
    begin
      strSQL := strSQL + ' AND DEKONT.ACIKLAMA LIKE ' + SQL_Katar('%'+ Edt_Ack.Text+  '%');
    end;

  if Trim(txtDekontKod.Text) <> '' then
  begin
    strSQL := strSQL + ' AND DEKONT.DEKONT_ID = ' + txtDekontKod.Text;
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND DEKONT.DEKONT_SID =' + SubeID;
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND DEKONT.DEKONT_SID = ' + inttostr(glb_sid);
    end;
    case cmbIslemTip.ItemIndex of
    0: strSQL := strSQL + ' GROUP BY DEKONT.DEKONT_ID,DEKONT.DEKONT_SID,DEKONT.CARI_KOD,DEKONT.ISLEM_TAR,DEKONT.ACIKLAMA';
    1: strSQL := strSQL + ' GROUP BY DEKONT.DEKONT_ID,DEKONT.DEKONT_SID,DEKONT.CARI_KOD,DEKONT_D.TUTAR_VPB,DEKONT.ISLEM_TAR,DEKONT.ACIKLAMA';
    end;

  end
  else
  begin
    if chkRAPKOD.Checked then
    begin
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND DEKONT.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND DEKONT.KOD1 = '+ SQL_Katar(txtKOD1.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND DEKONT.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND DEKONT.KOD3 = ' + SQL_Katar(txtKOD3.Text);
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        strSQL := strSQL + ' AND DEKONT.KOD4 = ' + SQL_Katar(txtKOD4.Text);
      end;
      ////////////////////////////////////////////////////////////////
    end;//end chkRAPKOD.checked
    //////////////////////////////////////////////////////////////////
    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=False)) then
    begin
      strSQL := strSQL + ' AND ISLEM_TAR >= ' + SQL_Tarih(dtpIslemTar.Date);
    end;
    //////////////////////////////////////////////////////////////////
    if ((dtpIslemTar.Checked=False) and (dtpIslemTar2.Checked=True)) then
    begin
      strSQL := strSQL + ' AND ISLEM_TAR <= ' + SQL_Tarih(dtpIslemTar2.Date);
    end;
    //////////////////////////////////////////////////////////////////
    if ((dtpIslemTar.Checked=True) and (dtpIslemTar2.Checked=True)) then
    begin
      strSQL := strSQL + ' AND ISLEM_TAR BETWEEN ' + SQL_Tarih(dtpIslemTar.Date) + ' AND '+ SQL_Tarih(dtpIslemTar2.Date);
    end;
    //////////////////////////////////////////////////////////////////////////
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND DEKONT.DEKONT_SID =' + SubeID;
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND DEKONT.DEKONT_SID = ' + inttostr(glb_sid);
    end;



    if chkTutar.Checked then
    begin
      case cmbIslemTip.ItemIndex of
      1:
        begin
          if (Trim(TutarBas.Text) <> '') and (Trim(TutarSon.Text) <> '') then
          begin
            strSQL := strSQL + ' AND DEKONT_D.TUTAR_VPB >= ' + SQL_Para(TutarBas.Value)+' AND ';
            strSQL := strSQL + ' DEKONT_D.TUTAR_VPB <= '+ SQL_Para(TutarSon.Value);
          end
          else
          if (Trim(TutarBas.Text) <> '') then
          begin
            strSQL := strSQL + ' AND DEKONT_D.TUTAR_VPB >= ' + SQL_Para(TutarBas.Value);
          end
          else
          if (Trim(TutarSon.Text) <> '') then
          begin
            strSQL := strSQL + ' AND DEKONT_D.TUTAR_VPB <= '+ SQL_Para(TutarSon.Value);
          end;
        end;
      end;
    end;
    //////////////////////////////////////////////////////////////////////////
    case cmbIslemTip.ItemIndex of
    0: strSQL := strSQL + ' GROUP BY DEKONT.DEKONT_ID,DEKONT.DEKONT_SID,DEKONT.CARI_KOD,DEKONT.ISLEM_TAR,DEKONT.ACIKLAMA';
    1: strSQL := strSQL + ' GROUP BY DEKONT.DEKONT_ID,DEKONT.DEKONT_SID,DEKONT.CARI_KOD,DEKONT_D.TUTAR_VPB,DEKONT.ISLEM_TAR,DEKONT.ACIKLAMA';
    end;
    //////////////////////////////////////////////////////////////////////////
    if chkTutar.Checked then
    begin
      case cmbIslemTip.ItemIndex of
      0:
        begin
          if (Trim(TutarBas.Text) <> '') and (Trim(TutarSon.Text) <> '') then
          begin
            strSQL := strSQL + ' HAVING SUM(DEKONT_D.TUTAR_VPB) >= ' + SQL_Para(TutarBas.Value)+' AND ';
            strSQL := strSQL + ' SUM(DEKONT_D.TUTAR_VPB) <= '+ SQL_Para(TutarSon.Value);
          end
          else
          if (Trim(TutarBas.Text) <> '') then
          begin
            strSQL := strSQL + ' HAVING SUM(DEKONT_D.TUTAR_VPB) >= ' + SQL_Para(TutarBas.Value);
          end
          else
          if (Trim(TutarSon.Text) <> '') then
          begin
            strSQL := strSQL + ' HAVING SUM(DEKONT_D.TUTAR_VPB) <= '+ SQL_Para(TutarSon.Value);
          end;
        end;
      end;
    end;
//****************************************************************************//
    strSQL := strSQL + ' ORDER BY DEKONT.DEKONT_ID,DEKONT.ISLEM_TAR';
  end;//end else if Trim(txtDekontKod.Text)
//****************************************************************************//
  try
//****************************************************************************//
    with qry_Dekont do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
//****************************************************************************//
    if chkTutar.Checked then
    begin
      case cmbIslemTip.ItemIndex of
      0:qry_Dekont.FieldByName('DEKONT_TOPLAMI').DisplayFormat := glb_VPB_FIELD_PF;
      1:qry_Dekont.FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
      end;
    end
    else
    begin
      qry_Dekont.FieldByName('DEKONT_TOPLAMI').DisplayFormat := glb_VPB_FIELD_PF;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;
end;

procedure TfrmDekontSDLG.txtDekontKodKeyPress(Sender: TObject;  var Key: Char);
begin
  if isDigit(Key)<>True then Key := #0;
  if key=#13 then
  begin
    btnAraTarClick(Self);
  end;
end;

procedure TfrmDekontSDLG.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then btnTamamClick(Self);
end;

procedure TfrmDekontSDLG.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmDekontSDLG.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmDekontSDLG.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmDekontSDLG.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmDekontSDLG.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmDekontSDLG.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TfrmDekontSDLG.txtKOD1Exit(Sender: TObject);
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

procedure TfrmDekontSDLG.txtKOD2Exit(Sender: TObject);
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

procedure TfrmDekontSDLG.txtKOD3Exit(Sender: TObject);
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

procedure TfrmDekontSDLG.txtKOD4Exit(Sender: TObject);
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

procedure TfrmDekontSDLG.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontSDLG.chkRAPKODEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontSDLG.chkRAPKODExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmDekontSDLG.txtDekontKodExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmDekontSDLG.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontSDLG.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmDekontSDLG.dtpIslemTarEnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontSDLG.dtpIslemTarExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmDekontSDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmDekontSDLG);
  {$IfDef TRANSPORT}
     pnlRAPKOD.Visible:=False;
  {$EndIf}

end;

procedure TfrmDekontSDLG.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    cmdCancelClick(Self);
  end;
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

procedure TfrmDekontSDLG.txtKodKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key=VK_F4 Then
  begin
    btnLstCMClick(Self);
  end;
end;

procedure TfrmDekontSDLG.btnLstCMClick(Sender: TObject);
var
  KOD,AD:String;
begin
  case rgCM.ItemIndex of
  0:if frmCariSDLG.Form_Open(True,KOD,AD,1) then txtKod.Text := KOD;
  1:if DataMod.LS_MASRAFTAN(KOD) then txtKod.Text := KOD;
  end;
end;

procedure TfrmDekontSDLG.rgCMEnter(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontSDLG.rgCMExit(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := clBtnFace;
end;

procedure TfrmDekontSDLG.TutarBasEnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontSDLG.TutarBasExit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

end.
