unit ufrmCEKSEN_IADE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ComCtrls, StdCtrls, Buttons, ExtCtrls,GenTypes;

type
  TfrmCEKSEN_IADE = class(TForm)
    lblSUBEKODL: TLabel;
    lblSUBEKOD: TLabel;
    lblCARIKOD: TLabel;
    lblCARIAD: TLabel;
    lblTANZIMTAR: TLabel;
    lblTANZIMTARL: TLabel;
    lblDOVKUR: TLabel;
    lblTUTAR: TLabel;
    lblTUTAR_VPB: TLabel;
    lblSAHIPL: TLabel;
    lblCEKSAHIBI: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnKAYDET: TButton;
    btnIPTAL: TButton;
    txtNO: TEdit;
    btnCEKSENLIST: TButton;
    txtYEVMIYEACK: TEdit;
    dtpIslemTar: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    lblPlasiyerKod: TLabel;
    lblProjeKod: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    trnIADE: TIB_Transaction;
    Label15: TLabel;
    txtCARIHARACK: TEdit;
    lblDOVKOD: TLabel;
    Label17: TLabel;
    btnSil: TButton;
    btnAra: TBitBtn;
    btnCIKIS: TBitBtn;
    lblCEKNUML: TLabel;
    lblCEKNUM: TLabel;
    rgYAZICI: TRadioGroup;
    btnCikti: TButton;
    Label18: TLabel;
    lblBelgeFisNo: TLabel;
    grpRapKod: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
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
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKAYDETClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnCIKISClick(Sender: TObject);
    procedure btnCEKSENLISTClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure txtKOD1Exit(Sender: TObject);
    procedure txtKOD2Exit(Sender: TObject);
    procedure txtKOD3Exit(Sender: TObject);
    procedure txtKOD4Exit(Sender: TObject);
    procedure txtKOD1KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD2KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD3KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD4KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtNOKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
    procedure dtpIslemTarEnter(Sender: TObject);
    procedure dtpIslemTarExit(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure txtCARIHARACKEnter(Sender: TObject);
    procedure txtCARIHARACKExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    procedure buton_ayarla(durum:byte);
    procedure Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer;CEK_SEN:Byte;Belge_Tur: Byte);
    procedure DataSet_Open(CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer);
    procedure EmptyFields;
    procedure GET_BELGE_BILGI(BELGE_ID, BELGE_SID : Integer; YENI_KAYIT:Boolean);
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  private
    CEKSEN : Byte;//CEK,SENET
    tblCEKSEN:TBL_CEKSEN;
    tblCEKSENHAR : TBL_CEKSENHAR;
    prv_BelgeTur : Integer;//BELGETUR
    prv_ISLEM : Byte;//CEKSENHAR.ISLEM
    prv_CanUpdate,prv_CanDelete:Boolean;
    { Private declarations }
  public
    { Public declarations }
    prnCEKSENHARID,prnCEKSENHARSID:Integer;
  end;
  const cns_cek_iade = 5;
  const cns_senet_iade = 6;
var
  frmCEKSEN_IADE: TfrmCEKSEN_IADE;
  frmCekIadeDekontu : TfrmCEKSEN_IADE;
  frmBorcCekIadeDekontu : TfrmCEKSEN_IADE;
  frmSenetIadeDekontu : TfrmCEKSEN_IADE;
  frmBorcSenetIadeDekontu : TfrmCEKSEN_IADE;

implementation

{$R *.dfm}
uses ufrmCekSenSDLG, unDataMod, main, ufrmISN_ERRORS, unCEKSENHAR,ufrmCekSenHarSDGL,
  unYazici, unLogger, UDm_Fast_Report;
{ TfrmCEKSENiade }

procedure TfrmCEKSEN_IADE.Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer;CEK_SEN:Byte;Belge_Tur: Byte);
var
  local_can_update,local_can_delete:Boolean;
//CEKSEN_ID : Çek veya senedin ID'si
//CEKSEN_SID : Çek veya senedin SID'si
//Tip :
//     1----> Çek
//     2----> Senet
//Belge_Tur : prv_BelgeTur 'ye aktarýlacak deger
begin
  case CEK_SEN of
  CEK:
    case Belge_Tur of
    BT_MCEK_IADE:
    begin
      if not DataMod.Modul_Hak(cns_cek_iade,local_can_update,local_can_delete) then
      begin
        Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if ((CEKSENHAR_ID = 0) and (CEKSENHAR_SID = 0) and (local_can_update = False)) then
        begin
          Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
          exit;
        end;
        if not MainForm.FindChildFrm(Application, 'frmCekIadeDekontu') then
        begin
          Application.CreateForm(TfrmCEKSEN_IADE,frmCekIadeDekontu);
          with frmCekIadeDekontu do
          begin
            Name := 'frmCekIadeDekontu';
            prv_CanUpdate := local_can_update;
            prv_CanDelete := local_can_delete;
            Caption := 'Müþteri Çeki Ýade Dekontu';
            prv_BelgeTur := Belge_Tur;
            CEKSEN := CEK;
            prv_ISLEM := 8;
            rgYAZICI.Visible := True;
            btnCikti.Visible := True;
            DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
          end;
        end;
      end;
    end;
    BT_BORC_CEK_IADE:
    begin
      if not DataMod.Modul_Hak(cns_cek_iade,local_can_update,local_can_delete) then
      begin
        Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if ((CEKSENHAR_ID = 0) and (CEKSENHAR_SID = 0) and (local_can_update = False)) then
        begin
          Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
          exit;
        end;
        if not MainForm.FindChildFrm( Application, 'frmBorcCekIadeDekontu') then
        begin
          Application.CreateForm(TfrmCEKSEN_IADE,frmBorcCekIadeDekontu);
          with frmBorcCekIadeDekontu do
          begin
            Name := 'frmBorcCekIadeDekontu';
            prv_CanUpdate := local_can_update;
            prv_CanDelete := local_can_delete;
            Caption := 'Borç Çeki Ýade Dekontu';
            prv_BelgeTur := Belge_Tur;
            CEKSEN := CEK;
            prv_ISLEM := 16;
            rgYAZICI.Visible := True;
            btnCikti.Visible := True;
            DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
          end;
        end;
      end;
    end;
    end;//end case belge_tur
  SENET:
    case Belge_Tur of
    BT_MSEN_IADE:
    begin
      if not DataMod.Modul_Hak(cns_senet_iade,local_can_update,local_can_delete) then
      begin
        Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if ((CEKSENHAR_ID = 0) and (CEKSENHAR_SID = 0) and (local_can_update = False)) then
        begin
          Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
          exit;
        end;
        if not MainForm.FindChildFrm( Application, 'frmSenetIadeDekontu') then
        begin
          Application.CreateForm(TfrmCEKSEN_IADE,frmSenetIadeDekontu);
          with frmSenetIadeDekontu do
          begin
            Name := 'frmSenetIadeDekontu';
            prv_CanUpdate := local_can_update;
            prv_CanDelete := local_can_delete;
            Caption := 'Müþteri Seneti Ýade Dekontu';
            prv_BelgeTur := Belge_Tur;
            CEKSEN := SENET;
            prv_ISLEM := 8;
            DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
          end;
        end;
      end;
    end;

    BT_BORC_SEN_IADE:
    begin
      if not DataMod.Modul_Hak(cns_senet_iade,local_can_update,local_can_delete) then
      begin
        Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if ((CEKSENHAR_ID = 0) and (CEKSENHAR_SID = 0) and (local_can_update = False)) then
        begin
          Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
          exit;
        end;
        if not MainForm.FindChildFrm( Application, 'frmBorcSenetIadeDekontu') then
        begin
          Application.CreateForm(TfrmCEKSEN_IADE,frmBorcSenetIadeDekontu);
          with frmBorcSenetIadeDekontu do
          begin
            Name := 'frmBorcSenetIadeDekontu';
            prv_CanUpdate := local_can_update;
            prv_CanDelete := local_can_delete;
            Caption := 'Borç Seneti Ýade Dekontu';
            prv_BelgeTur := Belge_Tur;
            CEKSEN := SENET;
            prv_ISLEM := 16;
            DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
          end;
        end;
      end;
    end;
  end;//end case belge_tur
  end;//end case
end;


procedure TfrmCEKSEN_IADE.DataSet_Open(CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer);
var
  CARI_AD,PROJE_AD,PLASIYER_AD : string;
//BT
//BT_MCEK_CIRO = 8;  //MUSTERI CEK CIROLAMASI
//BT_MSEN_CIRO = 13; //MUSTERI SENET CIROLAMASI
//BELGE_ID: çekin veya senetin id si
//BELGE_SID: çekin veya senetin sid si
begin
  if ((CEKSENHAR_ID = 0) and (CEKSENHAR_SID = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.Rapor_Kod_Visible_Fields('CEKSEN'
                                   ,Self.txtISLEMMERKEZI
                                   ,Self.txtKOD1
                                   ,Self.txtKOD2
                                   ,Self.txtKOD3
                                   ,Self.txtKOD4
                                   ,Self.Button1
                                   ,Self.Button2
                                   ,Self.Button3
                                   ,Self.Button4
                                   ,Self.Button5
                                   ,Self.Label10
                                   ,Self.Label11
                                   ,Self.Label12
                                   ,Self.Label13
                                   ,Self.Label14);

  if CEKSEN <> CEK then
  begin
    lblCEKNUML.Visible := False;
    lblCEKNUM.Visible := False;
  end;
  if (CEKSENHAR_ID <> 0)  and (CEKSENHAR_SID <> 0) then
  begin
//****************************************************************************//
//****************************************************************************//
    tblCEKSENHAR.CEKSENHAR_ID := CEKSENHAR_ID;
    tblCEKSENHAR.CEKSENHAR_SID := CEKSENHAR_SID;
    prnCEKSENHARID := CEKSENHAR_ID;
    prnCEKSENHARSID := CEKSENHAR_SID;

    if dmCEKSENHAR.GET_CEKSENHAR(tblCEKSENHAR,False) then
    begin
      //Gösterim Gereçlerine bilgiler aktarýlýyor.
      GET_BELGE_BILGI(tblCEKSENHAR.CEKSEN_ID,tblCEKSENHAR.CEKSEN_SID,False);
      with tblCEKSENHAR do
      begin
        lblBelgeFisNo.Caption := inttostr(CEKSENHAR_ID);
        dtpIslemTar.Date := ISLEM_TAR;
        txtCARIHARACK.Text := CARIHAR_ACK;
        txtYEVMIYEACK.text := YEVMIYE_ACK;

        txtISLEMMERKEZI.Text := MASRAF_MERK ;
        txtKOD1.Text := KOD1;
        txtKOD2.Text := KOD2;
        txtKOD3.Text := KOD3;
        txtKOD4.Text := KOD4;
      end;// end with tblCEKSENHAR do
    end;//end if dmCEKSENHAR.GET_CEKSENHAR(tblCEKSENHAR) then
    buton_ayarla(1);
    btnCEKSENLIST.Enabled := False;
    btnSIL.Enabled:=True;
  end
  else
  begin
    EmptyFields;
    btnCEKSENLIST.Enabled := True;
    dtpIslemTar.Date := DataMod.GET_SERVER_DATE;
    buton_ayarla(1);
  end;
end;





procedure TfrmCEKSEN_IADE.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmCEKSEN_IADE.btnCIKISClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCEKSEN_IADE.FormShow(Sender: TObject);
begin
  buton_ayarla(1);
end;


procedure TfrmCEKSEN_IADE.buton_ayarla(durum:byte);
begin
  case durum of
  1://yeni kayýtta çaðrýlacak
    begin
      btnKAYDET.Enabled := True;
      btnIPTAL.Enabled := True;
      btnCEKSENLIST.Enabled := True;
      btnYeni.Enabled := False;
      btnAra.Enabled := False;
      btnCIKIS.enabled:=False;
   end;
  2://kaydete bastýktan sonra çaðrýlacak
    begin
      btnKAYDET.Enabled := False;
      btnIPTAL.Enabled := False;
      btnYeni.Enabled := True;
      btnAra.Enabled := True;
      btnCIKIS.enabled:=True;
      btnSIL.Enabled := False;
      btnCEKSENLIST.Enabled := False;
    end;
  3://iptale bastýktan sonra çaðrýlacak
    begin
      btnKAYDET.Enabled := False;
      btnIptal.Enabled := False;
      btnYeni.Enabled := True;
      btnAra.Enabled := True;
      btnCIKIS.enabled:=True;
      btnSIL.Enabled := False;
      btnCEKSENLIST.Enabled := False;
    end;
  end;//end case
end;

procedure TfrmCEKSEN_IADE.btnYeniClick(Sender: TObject);
begin
  DataMod.Rapor_Kod_Visible_Fields('CEKSEN'
                                 ,Self.txtISLEMMERKEZI
                                 ,Self.txtKOD1
                                 ,Self.txtKOD2
                                 ,Self.txtKOD3
                                 ,Self.txtKOD4
                                 ,Self.Button1
                                 ,Self.Button2
                                 ,Self.Button3
                                 ,Self.Button4
                                 ,Self.Button5
                                 ,Self.Label10
                                 ,Self.Label11
                                 ,Self.Label12
                                 ,Self.Label13
                                 ,Self.Label14);
  buton_ayarla(1);
end;

procedure TfrmCEKSEN_IADE.btnKAYDETClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmCEKSEN_IADE.btnIPTALClick(Sender: TObject);
begin
  if Application.MessageBox('Ýþlemi iptal etmek istiyor musunuz?','Dikkat',MB_YESNO+MB_ICONQUESTION) = 6 then
  begin
    EmptyFields;
    buton_ayarla(3);
//****************************************************************************//
    if trnIADE.InTransaction then
       trnIADE.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
    prnCEKSENHARID := 0;
    prnCEKSENHARSID := 0;
  end;
end;

procedure TfrmCEKSEN_IADE.EmptyFields;
begin
  txtNO.clear;
  lblBelgeFisNo.Caption := '';
  lblCEKNUM.Caption := '';
  lblSUBEKOD.Caption := '';
  lblCEKSAHIBI.Caption := '';
  lblCARIKOD.Caption := '';
  lblCARIAD.Caption := '';
  lblTANZIMTAR.Caption := '';
  lblPlasiyerKod.Caption := '';
  lblProjeKod.Caption := '';
  lblDOVKUR.Caption := '';
  lblDOVKOD.Caption := '';
  lblTUTAR.Caption := '';
  lblTUTAR_VPB.Caption := '';
  lblPlasiyerKod.Caption := '';
  lblProjeKod.Caption := '';
  txtCARIHARACK.Clear;
  txtYEVMIYEACK.Clear;
  btnCEKSENLIST.Enabled := False;
  txtISLEMMERKEZI.Text := '';
  txtKOD1.Text := '';
  txtKOD2.Text := '';
  txtKOD3.Text := '';
  txtKOD4.Text := '';
end;

procedure TfrmCEKSEN_IADE.GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
var
  CARI_AD : String;
begin
  tblCEKSEN.CEKSEN := CEKSEN;
  tblCEKSEN.CEKSEN_ID := BELGE_ID;
  tblCEKSEN.CEKSEN_SID := BELGE_SID;
  if dmCEKSENHAR.GET_CEKSEN(tblCEKSEN) then
  begin
    if Length(Trim(tblCEKSEN.CARI_KOD)) = 0 then
    begin
      lblSUBEKOD.Caption := '';
      lblCARIAD.Caption := '';
    end
    else
    begin
      lblSUBEKOD.Caption := IntToStr(tblCEKSEN.CEKSEN_SID);
      if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',tblCEKSEN.CARI_KOD,CARI_AD) then
      begin
        lblCARIAD.Caption := CARI_AD;
      end;
    end;//end if

    if YENI_KAYIT then
    begin
      txtISLEMMERKEZI.Text := tblCEKSEN.MASRAF_MERK;
      txtKOD1.Text := tblCEKSEN.KOD1;
      txtKOD2.Text := tblCEKSEN.KOD2;
      txtKOD3.Text := tblCEKSEN.KOD3;
      txtKOD4.Text := tblCEKSEN.KOD4;

      case CEKSEN of
      CEK:
        begin
          txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çeki iade iþlemi.';
          txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çeki iade iþlemi.';
        end;
      SENET:
        begin
          txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senedi iade iþlemi.';
          txtYEVMIYEACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senedi iade iþlemi.';
        end;
      end;
    end;

    if CEKSEN = CEK then
    begin
      lblCEKNUM.Caption  :=  tblCEKSEN.CEK_NUM;
    end;

    txtNO.Text := inttostr(tblCEKSEN.CEKSEN_ID);
    lblSUBEKOD.Caption := inttostr(tblCEKSEN.CEKSEN_SID);
    lblCARIKOD.Caption := tblCEKSEN.CARI_KOD;
    lblTANZIMTAR.Caption := DateToStr(tblCEKSEN.TANZIMTAR);
    lblCEKSAHIBI.Caption := tblCEKSEN.BELGE_SAHIBI;
    lblDOVKOD.Caption := tblCEKSEN.DOVKOD;
    lblDOVKUR.Caption := FormatCurr(glb_VPB_FIELD_PF,tblCEKSEN.DOVKUR);
    lblTUTAR.Caption := FormatCurr(glb_DOV_FIELD_PF,tblCEKSEN.TUTAR);
    lblTUTAR_VPB.Caption := FormatCurr(glb_VPB_FIELD_PF,tblCEKSEN.TUTAR_VPB);
    lblPlasiyerKod.Caption := tblCEKSEN.PLASIYER_KOD;
    lblProjeKod.Caption := tblCEKSEN.PROJE_KOD;
    buton_ayarla(1);
  end
  else
  begin
    lblBelgeFisNo.Caption := '';
    lblSUBEKOD.Caption := '';
    lblCEKSAHIBI.Caption := '';
    lblCARIKOD.Caption := '';
    lblCARIAD.Caption := '';
    lblTANZIMTAR.Caption := '';
    lblDOVKOD.Caption := '';
    lblDOVKUR.Caption := '';
    lblTUTAR.Caption := '';
    lblTUTAR_VPB.Caption := '';
    lblPlasiyerKod.Caption := '';
    lblProjeKod.Caption := '';
    txtCARIHARACK.Clear;
    txtYEVMIYEACK.Clear;
    txtISLEMMERKEZI.Text := '';
    txtKOD1.Text := '';
    txtKOD2.Text := '';
    txtKOD3.Text := '';
    txtKOD4.Text := '';
    buton_ayarla(1);
  end;
end;




procedure TfrmCEKSEN_IADE.btnCEKSENLISTClick(Sender: TObject);
var
  BELGE_ID, BELGE_SID:Integer;
begin
  case prv_BelgeTur of
  BT_MCEK_IADE:
    begin
      if frmCekSenSDLG.Form_Open(False,CEK,BELGE_ID,BELGE_SID,1,True,1,1) Then
      begin
        GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
      end
      else
      begin
        exit;
      end;
    end;
  BT_MSEN_IADE:
    begin
      if frmCekSenSDLG.Form_Open(False,SENET,BELGE_ID,BELGE_SID,1,True,1,1) Then
      begin
        GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
      end
      else
      begin
        exit;
      end;
    end;
  BT_BORC_CEK_IADE:
    begin
      if frmCekSenSDLG.Form_Open(False,CEK,BELGE_ID,BELGE_SID,2,True,1,2) Then
      begin
        GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
      end
      else
      begin
        exit;
      end;
    end;
  BT_BORC_SEN_IADE:
    begin
      if frmCekSenSDLG.Form_Open(False,SENET,BELGE_ID,BELGE_SID,2,True,1,2) Then
      begin
        GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
      end
      else
      begin
        exit;
      end;
    end;
  end;
end;


procedure TfrmCEKSEN_IADE.txtNOKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then btnCEKSENLISTClick(Self);
end;

procedure TfrmCEKSEN_IADE.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
   txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_IADE.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
   txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_IADE.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
   txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_IADE.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
   txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_IADE.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
   txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_IADE.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TfrmCEKSEN_IADE.txtKOD1Exit(Sender: TObject);
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

procedure TfrmCEKSEN_IADE.txtKOD2Exit(Sender: TObject);
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

procedure TfrmCEKSEN_IADE.txtKOD3Exit(Sender: TObject);
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

procedure TfrmCEKSEN_IADE.txtKOD4Exit(Sender: TObject);
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

procedure TfrmCEKSEN_IADE.txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button1Click(Self);
end;

procedure TfrmCEKSEN_IADE.txtKOD1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button2Click(Self);
end;

procedure TfrmCEKSEN_IADE.txtKOD2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button3Click(Self);
end;

procedure TfrmCEKSEN_IADE.txtKOD3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button4Click(Self);
end;

procedure TfrmCEKSEN_IADE.txtKOD4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button5Click(Self);
end;

procedure TfrmCEKSEN_IADE.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmCEKSEN_IADE.btnAraClick(Sender: TObject);
var
  islem : byte;
  temp_id,temp_sid : integer;
  tip:byte;
begin
  case prv_ISLEM of
  8: tip := 1;
  16: tip := 2;
  end;

  if frmCekSenHarSDGL.Form_Open(False,
                                CEKSEN //CEK MÝ SENET MÝ
                                ,tip//1-MÜÞTERÝ 2-BORÇ
                                ,prv_ISLEM //
                                ,FALSE//TERCÝHLÝ
                                ,0//BELGE_ID
                                ,0//BELGE_SID
                                ,islem
                                ,temp_id
                                ,temp_sid) then
  begin
    //GET_BELGE_BILGI(temp_id,temp_sid,false);
    DataSet_Open(temp_id,temp_sid);
    prnCEKSENHARID := temp_id;
    prnCEKSENHARSID := temp_sid;
  end;

end;

function TfrmCEKSEN_IADE.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  case CEKSEN of
  1: //cek
    begin
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir çek seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;
    end;//end cek
  2:
    begin//senet start
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir senet seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;
    end;//end senet
  end;//end case CEKSEN of
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  Result := True;
end;

function TfrmCEKSEN_IADE.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  case CEKSEN of
  1: //cek
    begin
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir çek seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;
    end;//end cek
  2:
    begin//senet start
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir senet seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;
    end;//end senet
  end;//end case CEKSEN of
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  if not DataMod.IsDateInTerm(dtpIslemTar.Date, 'Ýþlem Tarihi') then Exit;
  Result := True;
end;

procedure TfrmCEKSEN_IADE.Form_Delete;
begin
  if not Form_Before_Delete then exit;
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trnIADE.InTransaction then
       trnIADE.Rollback;
    trnIADE.StartTransaction;
//****************************************************************************//
    tblCEKSENHAR.ISLEM_TAR := dtpIslemTar.Date;
    tblCEKSENHAR.MASRAF_MERK := Trim(txtISLEMMERKEZI.Text);
    tblCEKSENHAR.KOD1 := Trim(txtKOD1.Text);
    tblCEKSENHAR.KOD2 := Trim(txtKOD2.Text);
    tblCEKSENHAR.KOD3 := Trim(txtKOD3.Text);
    tblCEKSENHAR.KOD4 := Trim(txtKOD4.Text);

    tblCEKSENHAR.CEKSEN := CEKSEN;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := prv_ISLEM;
    tblCEKSENHAR.DOV_BAZ_TAR := tblCEKSEN.DOV_BAZ_TAR;//belgenin üzerindeki döviz baz tarihi aktarýlýyor.
    tblCEKSENHAR.DOVKUR := tblCEKSEN.DOVKUR;
    tblCEKSENHAR.TUTAR_VPB := tblCEKSEN.TUTAR_VPB;
    tblCEKSENHAR.KUR_FARKI := 0;//burada kur farký yoktur.Ben sýfýr olarak deðer atýyorum.<-ESER

    tblCEKSENHAR.PLASIYER_KOD := lblPlasiyerKod.Caption;
    tblCEKSENHAR.PROJE_KOD := lblProjeKod.Caption;

    tblCEKSENHAR.CARI_KOD := tblCEKSEN.CARI_KOD;
    tblCEKSENHAR.PLASIYER_KOD := tblCEKSEN.PLASIYER_KOD;
    tblCEKSENHAR.PROJE_KOD := tblCEKSEN.PROJE_KOD;

    tblCEKSENHAR.CARIHAR_ACK := Trim(txtYEVMIYEACK.Text);
    tblCEKSENHAR.YEVMIYE_ACK := Trim(txtYEVMIYEACK.Text);

    tblCEKSENHAR.PROTESTO_MASRAF := 0;
    tblCEKSENHAR.GENEL_GIDER := 0;
    tblCEKSENHAR.GENEL_GIDER_MUH_KOD := '';
    tblCEKSENHAR.BORCALHESAP :='';
//****************************************************************************//
    if not dmCEKSENHAR.CEKSENHAR_AUD(trnIADE,tblCEKSENHAR,prv_BelgeTur,'',1) then
    begin
      trnIADE.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,SENET,',
                                             prv_BelgeTur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,2,'');
//****************************************************************************//
    trnIADE.Commit;
  except
    trnIADE.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
    Raise;
  end;
  buton_ayarla(2);
  EmptyFields;
end;

procedure TfrmCEKSEN_IADE.Form_Post;
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;

  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trnIADE.InTransaction then
       trnIADE.Rollback;
    trnIADE.StartTransaction;
//****************************************************************************//
    tblCEKSENHAR.ISLEM_TAR := dtpIslemTar.Date;
    tblCEKSENHAR.MASRAF_MERK := Trim(txtISLEMMERKEZI.Text);
    tblCEKSENHAR.KOD1 := Trim(txtKOD1.Text);
    tblCEKSENHAR.KOD2 := Trim(txtKOD2.Text);
    tblCEKSENHAR.KOD3 := Trim(txtKOD3.Text);
    tblCEKSENHAR.KOD4 := Trim(txtKOD4.Text);

    tblCEKSENHAR.CEKSEN := CEKSEN;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := prv_ISLEM;
    tblCEKSENHAR.DOV_BAZ_TAR := tblCEKSEN.DOV_BAZ_TAR;//belgenin üzerindeki döviz baz tarihi aktarýlýyor.
    tblCEKSENHAR.DOVKUR := tblCEKSEN.DOVKUR;
    tblCEKSENHAR.TUTAR_VPB := tblCEKSEN.TUTAR_VPB;
    tblCEKSENHAR.KUR_FARKI := 0;//burada kur farký yoktur.Ben sýfýr olarak deðer atýyorum.<-ESER

    tblCEKSENHAR.PLASIYER_KOD := lblPlasiyerKod.Caption;
    tblCEKSENHAR.PROJE_KOD := lblProjeKod.Caption;

    tblCEKSENHAR.CARI_KOD := tblCEKSEN.CARI_KOD;
    tblCEKSENHAR.PLASIYER_KOD := tblCEKSEN.PLASIYER_KOD;
    tblCEKSENHAR.PROJE_KOD := tblCEKSEN.PROJE_KOD;

    tblCEKSENHAR.CARIHAR_ACK := Trim(txtCARIHARACK.Text);
    tblCEKSENHAR.YEVMIYE_ACK := Trim(txtYEVMIYEACK.Text);

    tblCEKSENHAR.PROTESTO_MASRAF := 0;
    tblCEKSENHAR.GENEL_GIDER := 0;
    tblCEKSENHAR.GENEL_GIDER_MUH_KOD := '';
    tblCEKSENHAR.BORCALHESAP :='';
//****************************************************************************//
    if not dmCEKSENHAR.CEKSENHAR_AUD(trnIADE,tblCEKSENHAR,prv_BelgeTur,'',0) then
    begin
      trnIADE.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    prnCEKSENHARID := tblCEKSENHAR.CEKSENHAR_ID;
    prnCEKSENHARSID := tblCEKSENHAR.CEKSENHAR_SID;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,SENET,',
                                             prv_BelgeTur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,1,'');
//****************************************************************************//
    trnIADE.Commit;
    if rgYAZICI.Visible = True then
    begin
      case CEKSEN of
      CEK:
        begin
          case prv_ISLEM of
          8://müþteri
            begin
              if rgYAZICI.Visible = True then
              begin
                if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(111)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,111,11,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

                Yazici.MCEKIADE(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
              end;
            end;
          16://borc
            begin
              if rgYAZICI.Visible = True then
              begin
                if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(301)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,301,30,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

                Yazici.BCEKIADE(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
              end;
            end;
          end;
        end;
      end;
      prnCEKSENHARID := 0;
      prnCEKSENHARSID := 0;
    end;
  except
    trnIADE.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
    Raise;
  end;
  buton_ayarla(2);
  EmptyFields;
end;

procedure TfrmCEKSEN_IADE.btnCiktiClick(Sender: TObject);
begin
  if prnCEKSENHARID<=0 then Exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  case CEKSEN of
  CEK:
    begin
      case prv_ISLEM of
      8://müþteri
        begin
          if rgYAZICI.Visible = True then
          begin
            if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(111)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,111,11,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

            Yazici.MCEKIADE(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
          end;
        end;
      16://borc
        begin
          if rgYAZICI.Visible = True then
          begin
            if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(301)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,301,30,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

            Yazici.BCEKIADE(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmCEKSEN_IADE.dtpIslemTarEnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_IADE.dtpIslemTarExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmCEKSEN_IADE.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_IADE.txtCARIHARACKEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_IADE.txtCARIHARACKExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmCEKSEN_IADE.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

end.
