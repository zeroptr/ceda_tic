unit ufrmCEKSEN_KARS;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, IB_Components, Mask, IB_Controls,
  ComCtrls, GenTypes;

type
  TfrmCEKSEN_KARS = class(TForm)
    lblNO: TLabel;
    txtNO: TEdit;
    lblSUBEKODL: TLabel;
    lblSUBEKOD: TLabel;
    lblCARIKOD: TLabel;
    lblCARIAD: TLabel;
    btnCEKSENLIST: TButton;
    lblTANZIMTAR: TLabel;
    lblTANZIMTARL: TLabel;
    lblTUTARBIL: TLabel;
    lblDOVKOD: TLabel;
    lblDOVKUR: TLabel;
    lblTUTAR: TLabel;
    lblTUTAR_VPB: TLabel;
    lblSAHIPL: TLabel;
    lblCEKSAHIBI: TLabel;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnCIRO: TButton;
    trnCekSenHar: TIB_Transaction;
    btnIPTAL: TButton;
    txtCARIHARACK: TEdit;
    txtYEVMIYEACK: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    btnAra: TBitBtn;
    dtpIslemTar: TDateTimePicker;
    Label5: TLabel;
    lblCiroCariKod: TLabel;
    lblCIROCARI_AD: TLabel;
    txtCARIKOD: TEdit;
    btnCariKod: TButton;
    btnSil: TButton;
    btnCIKIS: TBitBtn;
    lblCEKNUML: TLabel;
    lblCEKNUM: TLabel;
    Label18: TLabel;
    lblBelgeFisNo: TLabel;
    grpRapKod: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCIKISClick(Sender: TObject);
    procedure btnCEKSENLISTClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnCIROClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtPROJE_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txtPLASIYER_KODKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txt_CARIKODKeyPress(Sender: TObject; var Key: Char);
    procedure btnAraClick(Sender: TObject);
    procedure buton_ayarla(durum:byte);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure txtKOD1Exit(Sender: TObject);
    procedure txtKOD2Exit(Sender: TObject);
    procedure txtKOD3Exit(Sender: TObject);
    procedure txtKOD4Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD1KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD2KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD3KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD4KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtCARIKODExit(Sender: TObject);
    procedure txtCARIKODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtCARIKODKeyPress(Sender: TObject; var Key: Char);
    procedure btnCariKodClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure txtCARIKODEnter(Sender: TObject);
    procedure txtCARIHARACKExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure EmptyFields;
    procedure Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer;CEKSENHAR_SID:Integer; CEK_SEN:Byte; ISLEM:Byte);
    procedure DataSet_Open(CEKSENHAR_ID:Integer;CEKSENHAR_SID:Integer);
    procedure GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer;  YENI_KAYIT:Boolean);
////////////////////////////////////////////////////////////////////////////////
  private
    CEKSEN : Byte;//CEK,SENET
    tblCEKSEN:TBL_CEKSEN;
    tblCEKSENHAR : TBL_CEKSENHAR;
    prv_BelgeTur : Integer;//BELGETUR
    prv_ISLEM : Byte;//CEKSENHAR.ISLEM
    Muh_Kod,Aciklama:String;
    prv_CanUpdate,prv_CanDelete:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_cek_kars = 5;
  const cns_senet_kars = 6;
var
  frmCEKSEN_KARS: TfrmCEKSEN_KARS;
  frmEkstra : TfrmCEKSEN_KARS;
implementation

uses ufrmCariSDLG,unDataMod, ufrmCekSenSDLG, main,unFunc, ufrmISN_ERRORS,
  ufrmCekSenHarSDGL, unCEKSENHAR, unLogger;

{$R *.dfm}

procedure TfrmCEKSEN_KARS.Form_Open(Menu:Boolean;CEKSENHAR_ID : Integer; CEKSENHAR_SID:Integer; CEK_SEN:Byte; ISLEM:Byte);
var
  local_can_update,local_can_delete:Boolean;
//ISLEM
//5- Tahsilden Gelen “Karþýlýksýz” Dekontu
//6- Satýcýdan  Gelen “Karþýlýksýz”  Dekontu
//7- Portfoyde  “Karþýlýksýz” Dekontu
//BELGE_TUR
//BT_PORT_CEK_KARS    = 15;//PORTFOYDE KI ÇEK KARÞILIKSIZ  DEKONTU    P CEK KARSZ      CEKSENHAR
//BT_PORT_SEN_KARS    = 16;//PORTFOYDE KI SENET KARÞILIKSIZ  DEKONTU  P SEN KARSZ      CEKSENHAR
//BT_SATICI_KARS_CEK  = 24;//SATICIDAN GELEN KARÞILIKSIZ ÇEK          S KSIZ CEK       CEKSENHAR
//BT_SATICI_PROT_SEN  = 26;//SATICIDAN GELEN PROTESTOLU SENET         S PROT SENET     CEKSENHAR
//BT_BANK_KARS_CEK    = 25;//BANKADAN GELEN KARÞILIKSIZ ÇEK           B KSIZ CEK       CEKSENHAR
//BT_BANK_PROT_SEN    = 27;//BANKADAN GELEN PROTESTOLU SENET          B PROT SENET     CEKSENHAR

begin
  case ISLEM of
  5://tahsilden gelen karþýlýksýz dekontlar
    begin
      case CEK_SEN of
      CEK://tahsilden gelen karþýlýksýz çek
        begin
          if not DataMod.Modul_Hak(cns_cek_kars,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm( Application, 'frmMusteriCekTahsilKar') then
            begin
              frmEkstra := TfrmCEKSEN_KARS.Create(Application);
              frmEkstra.Name := 'frmMusteriCekTahsilKar';
              frmEkstra.prv_CanUpdate := local_can_update;
              frmEkstra.prv_CanDelete := local_can_delete;
              frmEkstra.Caption := 'Bankadan Gelen Müþteri Çeki Karþýlýksýz Dekontu';
              frmEkstra.CEKSEN := CEK_SEN;
              frmEkstra.prv_ISLEM := ISLEM;
              frmEkstra.prv_BelgeTur := BT_BANK_KARS_CEK;
              frmEkstra.DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      SENET://tahsilden gelen karþýlýksýz senet
        begin
          if not DataMod.Modul_Hak(cns_senet_kars,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm( Application, 'frmMusteriSenetTahsilKar') then
            begin
              frmEkstra := TfrmCEKSEN_KARS.Create(Application);
              frmEkstra.Name := 'frmMusteriSenetTahsilKar';
              frmEkstra.prv_CanUpdate := local_can_update;
              frmEkstra.prv_CanDelete := local_can_delete;
              frmEkstra.Caption := 'Bankadan Gelen Müþteri Senedi Karþýlýksýz Dekontu';
              frmEkstra.CEKSEN := CEK_SEN;
              frmEkstra.prv_ISLEM := ISLEM;
              frmEkstra.prv_BelgeTur := BT_BANK_PROT_SEN;
              frmEkstra.DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      end;//end case CEKSEN of
    end;
  6://satýcýdan gelen karþýlýksýz dekontlar
    begin
      case CEK_SEN of
      CEK://satýcýdan gelen karþýlýksýz çek
        begin
          if not DataMod.Modul_Hak(cns_cek_kars,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm( Application, 'frmMusteriCekSaticidanKar') then
            begin
              frmEkstra := TfrmCEKSEN_KARS.Create(Application);
              frmEkstra.Name := 'frmMusteriCekSaticidanKar';
              frmEkstra.prv_CanUpdate := local_can_update;
              frmEkstra.prv_CanDelete := local_can_delete;
              frmEkstra.Caption := 'Satýcýdan Gelen Müþteri Çeki Karþýlýksýz Dekontu';
              frmEkstra.CEKSEN := CEK_SEN;
              frmEkstra.prv_ISLEM := ISLEM;
              frmEkstra.prv_BelgeTur := BT_SATICI_KARS_CEK;
              frmEkstra.lblCiroCariKod.Visible := True;
              frmEkstra.txtCARIKOD.Visible := True;
              frmEkstra.btnCariKod.Visible := True;
              frmEkstra.lblCIROCARI_AD.Visible := True;
              frmEkstra.DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      SENET://satýcýdan gelen karþýlýksýz senet
        begin
          if not DataMod.Modul_Hak(cns_senet_kars,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm( Application, 'frmMusteriSenetSaticidanKar') then
            begin
              frmEkstra := TfrmCEKSEN_KARS.Create(Application);
              frmEkstra.Name := 'frmMusteriSenetSaticidanKar';
              frmEkstra.prv_CanUpdate := local_can_update;
              frmEkstra.prv_CanDelete := local_can_delete;
              frmEkstra.Caption := 'Satýcýdan Gelen Müþteri Senedi Karþýlýksýz Dekontu';
              frmEkstra.CEKSEN := CEK_SEN;
              frmEkstra.prv_ISLEM := ISLEM;
              frmEkstra.prv_BelgeTur := BT_SATICI_PROT_SEN;
              frmEkstra.lblCiroCariKod.Visible := True;
              frmEkstra.txtCARIKOD.Visible := True;
              frmEkstra.btnCariKod.Visible := True;
              frmEkstra.lblCIROCARI_AD.Visible := True;
              frmEkstra.DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      end;//end case CEKSEN of
    end;
  7://portföyden gelen karþýlýksýz dekontlar
    begin
      case CEK_SEN of
      CEK://portföyden gelen karþýlýksýz çek
        begin
          if not DataMod.Modul_Hak(cns_cek_kars,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm( Application, 'frmMusteriCekPortFoyKar') then
            begin
              frmEkstra := TfrmCEKSEN_KARS.Create(Application);
              frmEkstra.Name := 'frmMusteriCekPortFoyKar';
              frmEkstra.prv_CanUpdate := local_can_update;
              frmEkstra.prv_CanDelete := local_can_delete;
              frmEkstra.Caption := 'Portföydeki Müþteri Çeki Karþýlýksýz Dekontu';
              frmEkstra.CEKSEN := CEK_SEN;
              frmEkstra.prv_ISLEM := ISLEM;
              frmEkstra.prv_BelgeTur := BT_PORT_CEK_KARS;
              frmEkstra.DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      SENET://portföyden gelen karþýlýksýz senet
        begin
          if not DataMod.Modul_Hak(cns_senet_kars,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm( Application, 'frmMusteriSenetPortFoyKar') then
            begin
              frmEkstra := TfrmCEKSEN_KARS.Create(Application);
              frmEkstra.Name := 'frmMusteriSenetPortFoyKar';
              frmEkstra.prv_CanUpdate := local_can_update;
              frmEkstra.prv_CanDelete := local_can_delete;
              frmEkstra.Caption := 'Portföydeki Müþteri Senedi Karþýlýksýz Dekontu';
              frmEkstra.CEKSEN := CEK_SEN;
              frmEkstra.prv_ISLEM := ISLEM;
              frmEkstra.prv_BelgeTur := BT_PORT_SEN_KARS;
              frmEkstra.DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      end;//end case CEKSEN of
    end;
  end;//end case ISLEM of
end;

procedure TfrmCEKSEN_KARS.DataSet_Open(CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer);
var
  CARI_AD : String;
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
                                   ,Self.Label1
                                   ,Self.Label2
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
    if dmCEKSENHAR.GET_CEKSENHAR(tblCEKSENHAR,False) then
    begin
      GET_BELGE_BILGI(tblCEKSENHAR.CEKSEN_ID,tblCEKSENHAR.CEKSEN_SID,False);
      //Gösterim Gereçlerine bilgiler aktarýlýyor.
      with tblCEKSENHAR do
      begin
        lblBelgeFisNo.Caption := inttostr(CEKSENHAR_ID);
        dtpIslemTar.Date := ISLEM_TAR;
        txtCARIHARACK.Text := CARIHAR_ACK;
        txtYEVMIYEACK.Text := YEVMIYE_ACK;


        txtISLEMMERKEZI.Text := MASRAF_MERK ;
        txtKOD1.Text := KOD1;
        txtKOD2.Text := KOD2;
        txtKOD3.Text := KOD3;
        txtKOD4.Text := KOD4;


        if prv_ISLEM = 6 then
        begin
          txtCARIKOD.Text := CARI_KOD;
          if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCARIKOD.Text,CARI_AD) then
          begin
            lblCIROCARI_AD.Caption := CARI_AD;
          end;
        end;

      end;// end with tblCEKSENHAR do
    end;//end if dmCEKSENHAR.GET_CEKSENHAR(tblCEKSENHAR) then
    buton_ayarla(1);
    //111
    btnSIL.Enabled:=True;
  end
  else
  begin
    EmptyFields;
    btnCEKSENLIST.Enabled := True;
    dtpIslemTar.Date := DataMod.GET_SERVER_DATE;
    txtCARIHARACK.Clear;
    txtYEVMIYEACK.Clear;
    buton_ayarla(1);
  end;
end;


procedure TfrmCEKSEN_KARS.GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
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

    txtNO.Text := IntToStr(tblCEKSEN.CEKSEN_ID);

    if YENI_KAYIT then
    begin
      txtISLEMMERKEZI.Text := tblCEKSEN.MASRAF_MERK;
      txtKOD1.Text := tblCEKSEN.KOD1;
      txtKOD2.Text := tblCEKSEN.KOD2;
      txtKOD3.Text := tblCEKSEN.KOD3;
      txtKOD4.Text := tblCEKSEN.KOD4;

      case prv_ISLEM of
      5:////5- Tahsilden Gelen “Karþýlýksýz” Dekontu
        case CEKSEN of
        CEK:
          begin
            txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin tahsilden gelen karþýlýksýz dekont iþlemi.';
            txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin tahsilden gelen karþýlýksýz dekont iþlemi.';
          end;
        SENET:
          begin
            txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin tahsilden gelen karþýlýksýz dekont iþlemi.';
            txtYEVMIYEACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin tahsilden gelen karþýlýksýz dekont iþlemi.';
          end;
        end;//end case CEKSEN of
      6:////6- Satýcýdan  Gelen “Karþýlýksýz”  Dekontu
        case CEKSEN of
        CEK:
          begin
            txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin satýcýdan gelen karþýlýksýz dekont iþlemi.';
            txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin satýcýdan gelen karþýlýksýz dekont iþlemi.';
          end;
        SENET:
          begin
             txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin satýcýdan gelen karþýlýksýz dekont iþlemi.';
             txtYEVMIYEACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin satýcýdan gelen karþýlýksýz dekont iþlemi.';
          end;
        end;//end case CEKSEN of
      7:////7- Portfoyde  “Karþýlýksýz” Dekontu
        case CEKSEN of
        CEK:
          begin
            txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin portföydeki karþýlýksýz dekont iþlemi.';
            txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin portföydeki karþýlýksýz dekont iþlemi.';
          end;
        SENET:
          begin
             txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin portföydeki karþýlýksýz dekont iþlemi.';
             txtYEVMIYEACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin portföydeki karþýlýksýz dekont iþlemi.';
          end;
        end;//end case CEKSEN of

      end;//end case prv_ISLEM of
    end;//end if YENI_KAYIT then

    if CEKSEN = CEK then
    begin
      lblCEKNUM.Caption := tblCEKSEN.CEK_NUM;
    end;
    lblCARIKOD.Caption := tblCEKSEN.CARI_KOD;
    lblTANZIMTAR.Caption := DateToStr(tblCEKSEN.TANZIMTAR);
    lblCEKSAHIBI.Caption := tblCEKSEN.BELGE_SAHIBI;
    lblDOVKOD.Caption := tblCEKSEN.DOVKOD;
    lblDOVKUR.Caption := FormatCurr(glb_VPB_FIELD_PF,tblCEKSEN.DOVKUR);
    lblTUTAR.Caption := FormatCurr(glb_DOV_FIELD_PF,tblCEKSEN.TUTAR);
    lblTUTAR_VPB.Caption := FormatCurr(glb_VPB_FIELD_PF,tblCEKSEN.TUTAR_VPB);
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
    txtCARIHARACK.Clear;
    txtYEVMIYEACK.Clear;
    txtISLEMMERKEZI.Text := '';
    txtKOD1.Text := '';
    txtKOD2.Text := '';
    txtKOD3.Text := '';
    txtKOD4.Text := '';
  end;
end;




procedure TfrmCEKSEN_KARS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmCEKSEN_KARS.btnCIKISClick(Sender: TObject);
begin
  Close;
end;

Procedure TfrmCEKSEN_KARS.EmptyFields;
begin
  txtNO.clear;
  txtCARIHARACK.Clear;
  txtYEVMIYEACK.Clear;

  txtISLEMMERKEZI.Text := '';
  txtKOD1.Text := '';
  txtKOD2.Text := '';
  txtKOD3.Text := '';
  txtKOD4.Text := '';

  txtCARIKOD.Clear;
  lblCIROCARI_AD.Caption := '';
  lblBelgeFisNo.Caption := '';
  lblCEKNUM.Caption := '';
  lblSUBEKOD.Caption := '';
  lblCEKSAHIBI.Caption := '';
  lblCARIKOD.Caption := '';
  lblCARIAD.Caption := '';
  lblTANZIMTAR.Caption := '';
  lblDOVKOD.Caption := '';
  lblDOVKUR.Caption := '';
  lblTUTAR.Caption := '';
  lblTUTAR_VPB.Caption := '';

  btnCEKSENLIST.Enabled := False;
  btnIPTAL.Enabled := False;
  btnCIRO.Enabled := False;
  btnYeni.Enabled := True;
end;

procedure TfrmCEKSEN_KARS.btnCEKSENLISTClick( Sender: TObject);
var
  BELGE_ID, BELGE_SID:Integer;
begin
  case prv_ISLEM of
  5://tahsil
    begin
      if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,1,True,1,3) Then
      begin
        GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
      end;
    end;
  6://satýcý
    begin
      if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,1,True,1,2) Then
      begin
        GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
      end;
    end;
  7://portfoy
    begin
      if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,1,True,1,1) Then
      begin
        GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
      end;
    end;
  end;//end case prv_ISLEM of
end;

procedure TfrmCEKSEN_KARS.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0);
end;

procedure TfrmCEKSEN_KARS.btnIPTALClick(Sender: TObject);
begin
  if Application.MessageBox('Ýþlemi iptal etmek istiyor musunuz','Dikkat',MB_YESNO+MB_ICONQUESTION) = 6 then
  begin
    EmptyFields;
//****************************************************************************//
    if trnCekSenHar.InTransaction then
       trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
    buton_ayarla(3);
  end;
end;


procedure TfrmCEKSEN_KARS.btnCIROClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmCEKSEN_KARS.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCEKSEN_KARS.txtPROJE_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_KARS.txtPLASIYER_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_KARS.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    case Key of
    83: //s kaydet
      begin
        if btnCIRO.Enabled Then btnCIROClick(Self);
      end; //83 end
    80: //p iptal
      begin
        if btnIptal.Enabled Then btnIptalClick(Self);
      end;
    46: // del delete
      begin
        //if btnSIL.Enabled Then btnSILClick(self);
      end;
    end; // case end;
  end//Shift = [ssCtrl] then end
  else
  if Shift = [] then
  begin
    case Key of
    45: //ins kaydet
      begin
        if btnYeni.Enabled then btnYeniClick(Self);
      end;
    end;//acase end
  end; ///if Shift = [] then ENd
end;

procedure TfrmCEKSEN_KARS.txt_CARIKODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;


procedure TfrmCEKSEN_KARS.btnAraClick(Sender: TObject);
var
  temp_id,temp_sid : integer;
  ISLEM:byte;
begin
//prv_ISLEM
//5- Tahsilden Gelen “Karþýlýksýz” Dekontu
//6- Satýcýdan  Gelen “Karþýlýksýz”  Dekontu
//7- Portfoyde  “Karþýlýksýz” Dekontu
  if frmCekSenHarSDGL.Form_Open(False,
                                CEKSEN //CEK MÝ SENET MÝ
                                ,1//1-MÜÞTERÝ <- bu formlar sadece müþteri için
                                ,prv_ISLEM
                                ,FALSE//TERCÝHLÝ
                                ,0//BELGE_ID
                                ,0//BELGE_SID
                                ,islem
                                ,temp_id
                                ,temp_sid) then
  begin
    DataSet_Open(temp_id,temp_sid);
  end;
end;

procedure TfrmCEKSEN_KARS.buton_ayarla(durum:byte);
begin
  case durum of
  1://yeni kayýtta çaðrýlacak
    begin
      btnCIRO.Enabled := True;
      btnIPTAL.Enabled := True;
      btnYeni.Enabled := False;
      btnAra.Enabled := False;
      btnCIKIS.enabled:=False;
      btnSIL.Enabled := False;
   end;
  2://kaydete bastýktan sonra çaðrýlacak
    begin
      btnCIRO.Enabled := False;
      btnIPTAL.Enabled := False;
      btnYeni.Enabled := True;
      btnAra.Enabled := True;
      btnCIKIS.enabled:=True;
      btnSIL.Enabled := False;
    end;
  3://iptale bastýktan sonra çaðrýlacak
    begin
      btnCiro.Enabled := False;
      btnIptal.Enabled := False;
      btnYeni.Enabled := True;
      btnAra.Enabled := True;
      btnCIKIS.enabled:=True;
      btnSIL.Enabled := False;
    end;
  end;
end;


procedure TfrmCEKSEN_KARS.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TfrmCEKSEN_KARS.txtKOD1Exit(Sender: TObject);
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

procedure TfrmCEKSEN_KARS.txtKOD2Exit(Sender: TObject);
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

procedure TfrmCEKSEN_KARS.txtKOD3Exit(Sender: TObject);
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

procedure TfrmCEKSEN_KARS.txtKOD4Exit(Sender: TObject);
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

procedure TfrmCEKSEN_KARS.Button1Click(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_KARS.Button2Click(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_KARS.Button3Click(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_KARS.Button4Click(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_KARS.Button5Click(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_KARS.txtISLEMMERKEZIKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button1Click(Self);
end;

procedure TfrmCEKSEN_KARS.txtKOD1KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button2Click(Self);
end;

procedure TfrmCEKSEN_KARS.txtKOD2KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button3Click(Self);
end;

procedure TfrmCEKSEN_KARS.txtKOD3KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button4Click(Self);
end;

procedure TfrmCEKSEN_KARS.txtKOD4KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button5Click(Self);
end;

procedure TfrmCEKSEN_KARS.txtCARIKODExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCARIKOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCARIKOD.Text,CARI_AD) then
    begin
      (Sender as TEdit).Color := clWindow;
      lblCIROCARI_AD.Caption := CARI_AD;
    end
    else
    begin
      txtCARIKOD.SetFocus;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
    txtCARIKOD.Clear;
    lblCIROCARI_AD.Caption := '';
  end;
end;

procedure TfrmCEKSEN_KARS.txtCARIKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then btnCariKodClick(Self);
end;

procedure TfrmCEKSEN_KARS.txtCARIKODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_KARS.btnCariKodClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,3) Then
  begin
    txtCARIKOD.Text := Cari_KOD;
    lblCIROCARI_AD.Caption := Cari_AD;
  end;
end;

procedure TfrmCEKSEN_KARS.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

function TfrmCEKSEN_KARS.Form_Before_Delete: Boolean;
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

function TfrmCEKSEN_KARS.Form_Before_Post: Boolean;
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
        Application.MessageBox('Lütfen listeden bir senet seçiniz.','Dikkat',MB_ICONWARNING);
        exit;
      end;
    end;//end senet
  end;//end case CEKSEN of

  if prv_ISLEM = 6 then
  begin
    if Trim(txtCARIKOD.Text) = '' then
    begin
      txtCARIKOD.SetFocus;
      Application.MessageBox('Cari kodu boþ býrakamazsýnýz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  if not DataMod.IsDateInTerm(dtpIslemTar.Date,'Ýþlem Tarihi') then Exit;
  Result := True;
end;

procedure TfrmCEKSEN_KARS.Form_Delete;
begin
  if not Form_Before_Delete then exit;
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz?','Dikkat',MB_YESNO+MB_ICONQUESTION) = IDNO then Exit;
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trnCekSenHar.InTransaction then
       trnCekSenHar.Rollback;
    trnCekSenHar.StartTransaction;
//****************************************************************************//
    tblCEKSENHAR.ISLEM_TAR := dtpIslemTar.Date;
    tblCEKSENHAR.DOV_BAZ_TAR := tblCEKSEN.DOV_BAZ_TAR;//belgenin üzerindeki döviz baz tarihi aktarýlýyor.
    tblCEKSENHAR.CEKSEN := CEKSEN;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := prv_ISLEM;
//****************************************************************************//
    case prv_ISLEM of
    5://tahsilden gelen karþýlýksýz dekontlar
      begin
        tblCEKSENHAR.CARI_KOD := '';
      end;
    6://satýcýdan gelen karþýlýksýz dekontlar
      begin
        tblCEKSENHAR.CARI_KOD := Trim(txtCARIKOD.Text);
      end;
    7://portföyden gelen karþýlýksýz dekontlar
      begin
        tblCEKSENHAR.CARI_KOD := '';
      end;
    end;//end case prv_ISLEM of
//****************************************************************************//
    tblCEKSENHAR.CARIHAR_ACK := Trim(txtCARIHARACK.Text);
    tblCEKSENHAR.YEVMIYE_ACK := Trim(txtYEVMIYEACK.Text);
    tblCEKSENHAR.PROTESTO_MASRAF := 0;
    tblCEKSENHAR.GENEL_GIDER := 0;
    tblCEKSENHAR.GENEL_GIDER_MUH_KOD := '';
    tblCEKSENHAR.BORCALHESAP :='';
    tblCEKSENHAR.MASRAF_MERK := Trim(txtISLEMMERKEZI.Text);
    tblCEKSENHAR.KOD1 := Trim(txtKOD1.Text);
    tblCEKSENHAR.KOD2 := Trim(txtKOD2.Text);
    tblCEKSENHAR.KOD3 := Trim(txtKOD3.Text);
    tblCEKSENHAR.KOD4 := Trim(txtKOD4.Text);
//****************************************************************************//
    if not dmCEKSENHAR.CEKSENHAR_AUD(trnCekSenHar,tblCEKSENHAR,prv_BelgeTur,'',1) then
    begin
      trnCekSenHar.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,SENET,',
                                             prv_BelgeTur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,2,'');
////////////////////////////////////////////////////////////////////////////////
    trnCekSenHar.Commit;
  except
    trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  EmptyFields;
  buton_ayarla(3);
end;

procedure TfrmCEKSEN_KARS.Form_Post;
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
    if trnCekSenHar.InTransaction then
       trnCekSenHar.Rollback;
    trnCekSenHar.StartTransaction;
//****************************************************************************//
    tblCEKSENHAR.ISLEM_TAR := dtpIslemTar.Date;
    tblCEKSENHAR.DOV_BAZ_TAR := tblCEKSEN.DOV_BAZ_TAR;//belgenin üzerindeki döviz baz tarihi aktarýlýyor.
    tblCEKSENHAR.CEKSEN := CEKSEN;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := prv_ISLEM;
//****************************************************************************//
    case prv_ISLEM of
    5://tahsilden gelen karþýlýksýz dekontlar
      begin
        tblCEKSENHAR.CARI_KOD := '';
      end;
    6://satýcýdan gelen karþýlýksýz dekontlar
      begin
        tblCEKSENHAR.CARI_KOD := Trim(txtCARIKOD.Text);
      end;
    7://portföyden gelen karþýlýksýz dekontlar
      begin
        tblCEKSENHAR.CARI_KOD := '';
      end;
    end;//end case prv_ISLEM of
//****************************************************************************//
    tblCEKSENHAR.CARIHAR_ACK := Trim(txtCARIHARACK.Text);
    tblCEKSENHAR.YEVMIYE_ACK := Trim(txtYEVMIYEACK.Text);
    tblCEKSENHAR.PROTESTO_MASRAF := 0;
    tblCEKSENHAR.GENEL_GIDER := 0;
    tblCEKSENHAR.GENEL_GIDER_MUH_KOD := '';
    tblCEKSENHAR.BORCALHESAP :='';
    tblCEKSENHAR.DOVKUR := tblCEKSEN.DOVKUR;
    tblCEKSENHAR.TUTAR_VPB := tblCEKSEN.TUTAR_VPB;
    tblCEKSENHAR.KUR_FARKI := 0;

    tblCEKSENHAR.MASRAF_MERK := Trim(txtISLEMMERKEZI.Text);
    tblCEKSENHAR.KOD1 := Trim(txtKOD1.Text);
    tblCEKSENHAR.KOD2 := Trim(txtKOD2.Text);
    tblCEKSENHAR.KOD3 := Trim(txtKOD3.Text);
    tblCEKSENHAR.KOD4 := Trim(txtKOD4.Text);
//****************************************************************************//
    if not dmCEKSENHAR.CEKSENHAR_AUD(trnCekSenHar,tblCEKSENHAR,prv_BelgeTur,'',0) then
    begin
      trnCekSenHar.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,SENET,',
                                             prv_BelgeTur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,1,'');
//****************************************************************************//
    trnCekSenHar.Commit;
  except
    trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  EmptyFields;
  buton_ayarla(2);
end;

procedure TfrmCEKSEN_KARS.txtCARIKODEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_KARS.txtCARIHARACKExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

end.
