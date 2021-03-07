unit ufrmCekSenSDLG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, Grids, IB_Grid, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfrmCekSenSDLG = class(TForm)
    qry_Cek_Liste: TIB_Query;
    dts_Liste: TIB_DataSource;
    qry_Senet_Liste: TIB_Query;
    Panel2: TPanel;
    btnTAMAM: TBitBtn;
    btnIPTAL: TBitBtn;
    pnlRAPKOD: TPanel;
    Label1: TLabel;
    Label4: TLabel;
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
    pnlCek: TPanel;
    txtCekNo: TEdit;
    IB_Grid1: TIB_Grid;
    Panel1: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    dtpTanzimTar1: TDateTimePicker;
    dtpTanzimTar2: TDateTimePicker;
    dtpVadeTar1: TDateTimePicker;
    dtpVadeTar2: TDateTimePicker;
    rgDURUM: TRadioGroup;
    rgYERKOD: TRadioGroup;
    GroupBox1: TGroupBox;
    lbl_CARIKOD: TLabel;
    lbl_CARI: TLabel;
    btnCARI: TButton;
    chkCARI: TCheckBox;
    cboCEKIDNUM: TComboBox;
    cmbSube: TComboBox;
    btn_Ara: TButton;
//****************************************************************************//
    function Form_Open(Menu:Boolean;CekSen:Byte;Var BELGE_ID:Integer;var BELGE_SID:Integer;TIP:Byte;Tercihli:Boolean;Durum,Yer_Kod:Integer):Boolean;
    procedure CekAra;
    procedure SenetAra;
//****************************************************************************//
    procedure btnTAMAMClick(Sender: TObject);
    procedure btnCARIClick(Sender: TObject);
    procedure btn_AraClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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
    procedure FormCreate(Sender: TObject);
    procedure dtpTanzimTar1Enter(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure dtpTanzimTar1Exit(Sender: TObject);
    procedure rgDURUMEnter(Sender: TObject);
    procedure rgDURUMExit(Sender: TObject);
    procedure cboCEKIDNUMEnter(Sender: TObject);
    procedure cboCEKIDNUMExit(Sender: TObject);
    procedure txtCekNoExit(Sender: TObject);
    procedure chkRAPKODEnter(Sender: TObject);
    procedure chkRAPKODExit(Sender: TObject);
    procedure txtCekNoKeyPress(Sender: TObject; var Key: Char);
  private
    prv_CekSen_Tipi:Byte;
    prv_CekSen:Byte; // 1 Çek 2 Senet
   { Private declarations }
  public
    Kontrol:Boolean;
    { Public declarations }
  end;
  
var
  frmCekSenSDLG: TfrmCekSenSDLG;

implementation

uses unDataMod,unFunc,ufrmCek, main, ufrmCariSDLG;

{$R *.DFM}

{ TfrmCekSenSDLG }


function TfrmCekSenSDLG.Form_Open(Menu:Boolean;CekSen:Byte;Var BELGE_ID:Integer;var BELGE_SID:Integer;TIP:Byte;Tercihli:Boolean;Durum,Yer_Kod:Integer):Boolean;
// CekSen 1 : Cek 2 : Senet
// Tercihli : Kullanýcýnýn Durum ve yer kodunu deðiþtirmesi istenmediði durumlarda kullanýlýyo;
begin
  Application.CreateForm(TfrmCekSenSDLG, frmCekSenSDLG);
  with frmCekSenSDLG do
  begin
    prv_CekSen_Tipi := TIP;
    prv_CekSen := CekSen;
    DataMod.Rapor_Kod_Visible_Fields('CEKSEN'
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
                                    ,Label1
                                    ,Label4
                                    ,Label7
                                    ,Label8
                                    ,Label9);
    pnlRAPKOD.Visible := (txtISLEMMERKEZI.Visible or txtKOD1.Visible or txtKOD2.Visible or txtKOD3.Visible or txtKOD4.Visible);
    case CekSen of
    1:
      begin
        case TIP of
        1:Caption := 'Müþteri Çekleri Listesi';
        2:Caption := 'Borç Çekleri Listesi';
        end;
        //pnlCek.Visible := True;
        cboCEKIDNUM.Visible := True;
        txtCekNo.Visible := True;
        cmbSube.Visible := True;

        dts_Liste.Dataset := qry_Cek_Liste;
      end;
    2:
      begin
        case TIP of
        1:Caption := 'Müþteri Senetleri Listesi';
        2:Caption := 'Borç Senetleri Listesi';
        end;
        //pnlCek.Visible := False;
        cboCEKIDNUM.Visible := False;
        txtCekNo.Visible := False;
        cmbSube.Visible := False;
        
        dts_Liste.Dataset := qry_Senet_Liste;
      end;
    end;
    dtpTanzimTar1.Date := glb_DONEM_BAS;
    dtpVadeTar1.Date := glb_DONEM_BAS;
    dtpTanzimTar2.Date := DataMod.GET_SERVER_DATE;
    dtpVadeTar2.Date := dtpTanzimTar2.Date;
    dtpTanzimTar1.Checked := False;
    dtpTanzimTar2.Checked := False;
    dtpVadeTar1.Checked := False;
    dtpVadeTar2.Checked := False;
    if Tercihli then // Tercihli then
    begin
      rgDURUM.ItemIndex := Durum -1;
      rgDURUM.Enabled := False;
      rgYERKOD.ItemIndex := Yer_Kod - 1;
      rgYERKOD.Enabled := False;
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
    ShowModal;
    if not Kontrol then
    begin
      BELGE_ID := 0;
      BELGE_SID := 0;
      Result := False;
    end
    else
    begin
      case CekSen of
      1:
        begin
          BELGE_ID := frmCekSenSDLG.qry_Cek_Liste.FieldByName('CEK_ID').AsInteger;
          BELGE_SID := frmCekSenSDLG.qry_Cek_Liste.FieldByName('CEK_SID').AsInteger;
        end;
      2:
        begin
          BELGE_ID := frmCekSenSDLG.qry_Senet_Liste.FieldByName('SENET_ID').AsInteger;
          BELGE_SID := frmCekSenSDLG.qry_Senet_Liste.FieldByName('SENET_SID').AsInteger;
        end;
      end;//end case
      Result := True;
    end;
    qry_Cek_Liste.Close;
    qry_Senet_Liste.Close;
    Release;
  end;
end;


procedure TfrmCekSenSDLG.btnTAMAMClick(Sender: TObject);
begin
  case prv_CekSen of
  1:
    begin
      if (qry_Cek_Liste.Active = True) then
      begin
        if not (qry_Cek_Liste.RecordCount = 0) then
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
  2:
    begin
      if (qry_Senet_Liste.Active = True) then
      begin
        if not (qry_Senet_Liste.RecordCount = 0) then
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
  end;
end;


procedure TfrmCekSenSDLG.btnCARIClick(Sender: TObject);
var CARI_KOD,CARI_AD : String;
begin
  if frmCariSDLG.Form_Open(False,CARI_KOD,CARI_AD,1) Then
  begin
    chkCARI.Checked  := True;
    lbl_CARIKOD.Caption := CARI_KOD;
    lbl_CARI.Caption := CARI_AD;
  end;
end;


procedure TfrmCekSenSDLG.btn_AraClick(Sender: TObject);
begin
  case prv_CekSen of
  1:
    begin
      CekAra;
      IB_Grid1.SetFocus;
    end;
  2:
    begin
      SenetAra;
      IB_Grid1.SetFocus;
    end;
  end;
end;

procedure TfrmCekSenSDLG.btnIPTALClick(Sender: TObject);
begin
  Kontrol := False;
  Close;
end;

procedure TfrmCekSenSDLG.FormShow(Sender: TObject);
begin
  lbl_CARI.Caption := '';
  lbl_CARIKOD.Caption := '';
end;

procedure TfrmCekSenSDLG.CekAra;
var
  WhereEk:Boolean;
  SubeID,strSQL : String;
begin
  WhereEk := False;
  strSQL := 'SELECT CEK_ID,CEK_SID,TANZIMTAR,VADETAR,CEK_NUM,CARI_KOD,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = CEK.CARI_KOD) AS CARI_AD'
           +',BANKA_AD,DOVKOD,TUTAR,TUTAR_VPB FROM CEK';
  if Trim(txtCekNo.Text)='' then
  begin
    if chkCARI.Checked  then
    begin
      strSQL := strSQL + ' WHERE CEK.CARI_KOD = '+ SQL_Katar(lbl_CARIKOD.Caption);
      WhereEk := True;
    end;

    if chkRAPKOD.Checked then
    begin
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND CEK.MASRAF_MERK = ' + SQL_Katar(txtISLEMMERKEZI.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE CEK.MASRAF_MERK = ' + SQL_Katar(txtISLEMMERKEZI.Text);
          WhereEk := True;
        end;
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND CEK.KOD1 = ' + SQL_Katar(txtKOD1.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE CEK.KOD1 = ' + SQL_Katar(txtKOD1.Text);
          WhereEk := True;
        end;
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND CEK.KOD2 = ' + SQL_Katar(txtKOD2.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE CEK.KOD2 = ' + SQL_Katar(txtKOD2.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND CEK.KOD3 = ' + SQL_Katar(txtKOD3.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE CEK.KOD3 = ' + SQL_Katar(txtKOD3.Text);
          WhereEk := True;
        end
      end;
      //////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        if WhereEk then
        begin
          strSQL := strSQL + ' AND CEK.KOD4 = ' + SQL_Katar(txtKOD4.Text);
        end
        else
        begin
          strSQL := strSQL + ' WHERE CEK.KOD4 = ' + SQL_Katar(txtKOD4.Text);
          WhereEk := True;
        end
      end;
    end;

    case rgDURUM.ItemIndex of
    0..3:
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.DURUM = '+ IntToStr(rgDURUM.ItemIndex + 1 );
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.DURUM = '+ IntToStr(rgDURUM.ItemIndex + 1);
        WhereEk := True;
      end;
    end;//end case rgDURUM

    case rgYERKOD.ItemIndex of
    0..2:
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.YER_KOD = '+ IntToStr(rgYERKOD.ItemIndex + 1);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.YER_KOD = '+ IntToStr(rgYERKOD.ItemIndex + 1);
        WhereEk := True;
      end;
    end;

    if ((dtpTanzimTar1.Checked = True) and (dtpTanzimTar2.Checked = False)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.TANZIMTAR = '+ SQL_Tarih(dtpTanzimTar1.Date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.TANZIMTAR = '+ SQL_Tarih(dtpTanzimTar1.Date);
        WhereEk := True;
      end;
    end;

    if ((dtpTanzimTar1.Checked = False) and (dtpTanzimTar2.Checked = True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.TANZIMTAR <= '+ SQL_Tarih(dtpTanzimTar2.Date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.TANZIMTAR <= '+ SQL_Tarih(dtpTanzimTar2.Date);
        WhereEk := True;
      end;
    end;

    if ((dtpTanzimTar1.Checked = True) and (dtpTanzimTar2.Checked = True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.TANZIMTAR BETWEEN '+ SQL_Tarih(dtpTanzimTar1.Date) + ' AND ' + SQL_Tarih(dtpTanzimTar2.Date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.TANZIMTAR BETWEEN '+ SQL_Tarih(dtpTanzimTar1.Date) + ' AND ' + SQL_Tarih(dtpTanzimTar2.Date);
        WhereEk := True;
      end;
    end;

    if ((dtpVadeTar1.Checked = True) and (dtpVadeTar2.Checked = False)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.VADETAR = '+ SQL_Tarih(dtpVadeTar1.Date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.VADETAR = '+ SQL_Tarih(dtpVadeTar1.Date);
        WhereEk := True;
      end;
    end;

    if ((dtpVadeTar1.Checked = False) and (dtpVadeTar1.Checked = True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.VADETAR <= '+ SQL_Tarih(dtpVadeTar2.Date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.VADETAR <= '+ SQL_Tarih(dtpVadeTar2.Date);
        WhereEk := True;
      end;
    end;

    if ((dtpVadeTar1.Checked = True) and (dtpVadeTar2.Checked = True)) then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.VADETAR BETWEEN '+ SQL_Tarih(dtpVadeTar1.Date) + ' AND ' + SQL_Tarih(dtpVadeTar2.Date);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.VADETAR BETWEEN '+ SQL_Tarih(dtpVadeTar1.Date) + ' AND ' + SQL_Tarih(dtpVadeTar2.Date);
        WhereEk := True;
      end;
    end;

    if glb_SUBELI then
    begin
      if WhereEk then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND CEK.CEK_SID = ' + SubeID;
        end;
      end
      else
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL +  ' WHERE CEK.CEK_SID = ' + SubeID;
          WhereEk := True;
        end;
      end;
    end
    else
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.CEK_SID = '+inttostr(glb_sid);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.CEK_SID = '+inttostr(glb_sid);
        WhereEk := True;
      end;
    end;
  end
  else
  begin
    if WhereEk then
    begin
      case cboCEKIDNUM.ItemIndex of
      0:
        begin
          strSQL := strSQL + ' AND CEK.CEK_NUM = ' + SQL_Katar(txtCekNo.Text);
        end;
      1:
        begin
          strSQL := strSQL + ' AND CEK.CEK_ID = ' + txtCekNo.Text;
        end;
      end; //case end;
    end
    else
    begin
      case cboCEKIDNUM.ItemIndex of
      0:
        begin
          strSQL := strSQL + ' WHERE CEK.CEK_NUM = ' +  SQL_Katar(txtCekNo.Text);
          WhereEk := True;
        end;
      1:
        begin
          strSQL := strSQL + ' WHERE CEK.CEK_ID = ' +  txtCekNo.Text;
          WhereEk := True;
        end;
      end; //case end;
    end;

    if glb_SUBELI then
    begin
      if WhereEk then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' AND CEK.CEK_SID = ' + SubeID;
        end;
      end
      else
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          strSQL := strSQL + ' WHERE CEK.CEK_SID = ' + SubeID;
          WhereEk := True;
        end;
      end;
    end
    else
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.CEK_SID = '+inttostr(glb_sid);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.CEK_SID = '+inttostr(glb_sid);
        WhereEk := True;
      end;
    end;

    case rgDURUM.ItemIndex of
    0..3:
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.DURUM = '+ IntToStr(rgDURUM.ItemIndex + 1);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.DURUM = '+ IntToStr(rgDURUM.ItemIndex + 1);
        WhereEk := True;
      end
    end;//end case rgDURUM

    case rgYERKOD.ItemIndex of
    0..2:
      if WhereEk then
      begin
        strSQL := strSQL + ' AND CEK.YER_KOD = '+ IntToStr(rgYERKOD.ItemIndex + 1);
      end
      else
      begin
        strSQL := strSQL + ' WHERE CEK.YER_KOD = '+ IntToStr(rgYERKOD.ItemIndex + 1);
        WhereEk := True;
      end;
    end;
  end;

  if WhereEk then
  begin
    strSQL := strSQL + ' AND CEK.TIP = '+ IntToStr(prv_CekSen_Tipi);
  end
  else
  begin
    strSQL := strSQL + ' WHERE CEK.TIP = '+ IntToStr(prv_CekSen_Tipi);
  end;

  try
    with qry_Cek_Liste do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
  except
    ShowMessage(qry_Cek_Liste.SQL.Text);
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
  end;
end;

procedure TfrmCekSenSDLG.SenetAra;
var
  WhereEk:Boolean;
  strSQL,SubeID : String;
begin
  WhereEk := False;
  strSQL := 'SELECT SENET_ID,SENET_SID,TANZIMTAR,VADETAR,CARI_KOD,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = SENET.CARI_KOD) AS CARI_AD'
           +',TANZIM_YER,DOVKOD,TUTAR,TUTAR_VPB FROM SENET';
  if chkCARI.Checked  then
  begin
    strSQL := strSQL + ' WHERE SENET.CARI_KOD = '+ SQL_Katar(lbl_CARIKOD.Caption);
    WhereEk := True;
  end;

  if chkRAPKOD.Checked then
  begin
  //////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////
    if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND SENET.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
      end
      else
      begin
        strSQL := strSQL + ' WHERE SENET.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
        WhereEk := True;
      end;
    end;
    /////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    if Length(Trim(txtKOD1.Text)) <> 0 then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND SENET.KOD1 = '+ SQL_Katar(txtKOD1.Text);
      end
      else
      begin
        strSQL := strSQL + ' WHERE SENET.KOD1 = '+ SQL_Katar(txtKOD1.Text);
        WhereEk := True;
      end
    end;
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    if Length(Trim(txtKOD2.Text)) <> 0 then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND SENET.KOD2 = '+ SQL_Katar(txtKOD2.Text);
      end
      else
      begin
        strSQL := strSQL + ' WHERE SENET.KOD2 = '+ SQL_Katar(txtKOD2.Text);
        WhereEk := True;
      end
    end;
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    if Length(Trim(txtKOD3.Text)) <> 0 then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND SENET.KOD3 = '+ SQL_Katar(txtKOD3.Text);
      end
      else
      begin
        strSQL := strSQL + ' WHERE SENET.KOD3 = '+ SQL_Katar(txtKOD3.Text);
        WhereEk := True;
      end
    end;
    //////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////
    if Length(Trim(txtKOD4.Text)) <> 0 then
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND SENET.KOD4 = '+ SQL_Katar(txtKOD4.Text);
      end
      else
      begin
        strSQL := strSQL + ' WHERE SENET.KOD4 = '+ SQL_Katar(txtKOD4.Text);
        WhereEk := True;
      end;
    end;
    //////////////////////////////////////////////////////////////////
  end;//end chkRAPKOD.checked

  case rgDURUM.ItemIndex of
  0..2:
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND SENET.DURUM = '+ IntToStr(rgDURUM.ItemIndex + 1);
      end
      else
      begin
        strSQL := strSQL + ' WHERE SENET.DURUM = '+ IntToStr(rgDURUM.ItemIndex + 1);
        WhereEk := True;
      end;
    end;
  end;//end case rgDURUM

  case rgYERKOD.ItemIndex of
  0..2:
    begin
      if WhereEk then
      begin
        strSQL := strSQL + ' AND SENET.YER_KOD = '+ IntToStr(rgYERKOD.ItemIndex + 1);
      end
      else
      begin
        strSQL := strSQL + ' WHERE SENET.YER_KOD = '+ IntToStr(rgYERKOD.ItemIndex + 1);
        WhereEk := True;
      end;
    end;
  end;//end case rgYERKOD

  if dtpTanzimTar1.Checked then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND SENET.TANZIMTAR >= '+ SQL_Tarih(dtpTanzimTar1.date);
    end
    else
    begin
      strSQL := strSQL + ' WHERE SENET.TANZIMTAR >= '+ SQL_Tarih(dtpTanzimTar1.date);
      WhereEk := True;
    end;
  end;

  if dtpTanzimTar2.Checked then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND SENET.TANZIMTAR <= '+ SQL_Tarih(dtpTanzimTar2.date);
    end
    else
    begin
      strSQL := strSQL + ' WHERE SENET.TANZIMTAR <= '+ SQL_Tarih(dtpTanzimTar2.date);
      WhereEk := True;
    end;
  end;

  if dtpVadeTar1.Checked then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND SENET.VADETAR >= '+ SQL_Tarih(dtpVadeTar1.date);
    end
    else
    begin
      strSQL := strSQL + ' WHERE SENET.VADETAR >= '+ SQL_Tarih(dtpVadeTar1.date);
      WhereEk := True;
    end;
  end;

  if dtpVadeTar2.Checked then
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND SENET.VADETAR <= '+ SQL_Tarih(dtpVadeTar2.date);
    end
    else
    begin
      strSQL := strSQL + ' WHERE SENET.VADETAR <= '+ SQL_Tarih(dtpVadeTar2.date);
      WhereEk := True;
    end;
  end;

  if WhereEk then
  begin
    strSQL := strSQL + ' AND SENET.TIP = '+ IntToStr(prv_CekSen_Tipi);
  end
  else
  begin
    strSQL := strSQL + ' WHERE SENET.TIP = '+ IntToStr(prv_CekSen_Tipi);
    WhereEk := True;
  end;

  if glb_SUBELI then
  begin
    if WhereEk then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND SENET.SENET_SID = ' + SubeID;
      end;
    end
    else
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' WHERE SENET.SENET_SID = ' + SubeID;
      end;
    end;
  end
  else
  begin
    if WhereEk then
    begin
      strSQL := strSQL + ' AND SENET.SENET_SID = ' + inttostr(glb_sid);
    end
    else
    begin
      strSQL := strSQL + ' WHERE SENET.SENET_SID = ' + inttostr(glb_sid);
    end;
  end;

  try
    with qry_Senet_Liste do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := true;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(qry_Senet_Liste.sql.text);
  end;
end;

procedure TfrmCekSenSDLG.FormKeyPress(Sender: TObject; var Key: Char);
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
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmCekSenSDLG.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key =#13 then
  begin
    Kontrol :=True;
    Close;
  end;
end;

procedure TfrmCekSenSDLG.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmCekSenSDLG.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmCekSenSDLG.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmCekSenSDLG.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmCekSenSDLG.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmCekSenSDLG.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TfrmCekSenSDLG.txtKOD1Exit(Sender: TObject);
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

procedure TfrmCekSenSDLG.txtKOD2Exit(Sender: TObject);
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


procedure TfrmCekSenSDLG.txtKOD4Exit(Sender: TObject);
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

procedure TfrmCekSenSDLG.txtKOD3Exit(Sender: TObject);
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

procedure TfrmCekSenSDLG.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmCekSenSDLG);
  with frmCekSenSDLG.qry_Cek_Liste do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_DOV_FIELD_PF;
  end;

  with frmCekSenSDLG.qry_Senet_Liste do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmCekSenSDLG.dtpTanzimTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCekSenSDLG.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCekSenSDLG.dtpTanzimTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmCekSenSDLG.rgDURUMEnter(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCekSenSDLG.rgDURUMExit(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := clBtnFace;
end;

procedure TfrmCekSenSDLG.cboCEKIDNUMEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCekSenSDLG.cboCEKIDNUMExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmCekSenSDLG.txtCekNoExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmCekSenSDLG.chkRAPKODEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCekSenSDLG.chkRAPKODExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmCekSenSDLG.txtCekNoKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then btn_AraClick(Self);
end;

end.
