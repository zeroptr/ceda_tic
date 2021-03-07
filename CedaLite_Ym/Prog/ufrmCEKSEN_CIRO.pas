unit ufrmCEKSEN_CIRO;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, IB_Components, Mask, IB_Controls,
  ComCtrls,GenTypes;

type
  TfrmCEKSEN_CIRO = class(TForm)
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
    lblCIROCARI_AD: TLabel;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnCIRO: TButton;
    Label2: TLabel;
    Label4: TLabel;
    lblPrjAd: TLabel;
    lblPlasiyerAd: TLabel;
    trnCekSenHar: TIB_Transaction;
    btnIPTAL: TButton;
    txtDOVKUR: TIB_Currency;
    txtTUTARVPB: TIB_Currency;
    txtKURFARK: TIB_Currency;
    btnCariKod: TButton;
    btnProjeKod: TButton;
    btnPlasiyerKod: TButton;
    txtCARIKOD: TEdit;
    lblCiroCariKod: TLabel;
    txtPROJEKOD: TEdit;
    Label1: TLabel;
    txtPLASIYERKOD: TEdit;
    Label3: TLabel;
    dtpISLEMTAR: TDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    dtpDOVBAZTAR: TDateTimePicker;
    txtCARIHARACK: TEdit;
    txtYEVMIYEACK: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    btnAra: TBitBtn;
    btnSil: TButton;
    btnCIKIS: TBitBtn;
    lblCEKNUML: TLabel;
    lblCEKNUM: TLabel;
    Label18: TLabel;
    lblBelgeFisNo: TLabel;
    rgYAZICI: TRadioGroup;
    btnCikti: TButton;
    grpRapKod: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
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
    procedure txtCARIKODExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtPROJE_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txtPLASIYER_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txt_PLASIYERKODKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;              Shift: TShiftState);
    procedure txt_CARIKODKeyPress(Sender: TObject; var Key: Char);
    procedure txt_CARIKODKeyDown(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure txt_CARIKODButtonClick(Sender: TObject);
    procedure txt_CARIKODExit(Sender: TObject);
    procedure txt_PROJEKODExit(Sender: TObject);
    procedure txt_PROJEKODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txt_PLASIYERKODButtonClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure txtDOVKURExit(Sender: TObject);
    procedure btnCariKodClick(Sender: TObject);
    procedure btnProjeKodClick(Sender: TObject);
    procedure btnPlasiyerKodClick(Sender: TObject);
    procedure txtCARIKODKeyDown(Sender: TObject; var Key: Word;        Shift: TShiftState);
    procedure txtCARIKODKeyPress(Sender: TObject; var Key: Char);
    procedure txtPROJEKODExit(Sender: TObject);
    procedure txtPROJEKODKeyDown(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure txtPROJEKODKeyPress(Sender: TObject; var Key: Char);
    procedure txtPLASIYERKODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPLASIYERKODExit(Sender: TObject);
    procedure txtPLASIYERKODKeyPress(Sender: TObject; var Key: Char);
    procedure txtDOVKURChange(Sender: TObject);
    procedure dtpDOVBAZTARCloseUp(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
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
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure txtKOD1KeyUp(Sender: TObject; var Key: Word;               Shift: TShiftState);
    procedure txtKOD2KeyUp(Sender: TObject; var Key: Word;               Shift: TShiftState);
    procedure txtKOD3KeyUp(Sender: TObject; var Key: Word;               Shift: TShiftState);
    procedure txtKOD4KeyUp(Sender: TObject; var Key: Word;               Shift: TShiftState);
    procedure txtCARIKODEnter(Sender: TObject);
    procedure txtDOVKUREnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpISLEMTAREnter(Sender: TObject);
    procedure dtpISLEMTARExit(Sender: TObject);
    procedure txtCARIHARACKExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer;CEKSENHAR_SID:Integer; CEK_SEN:Byte; ISLEM:Byte);
    procedure DataSet_Open(CEKSENHAR_ID:Integer;CEKSENHAR_SID:Integer);
    procedure TutarFarkHesapla;
    procedure GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
    procedure buton_ayarla(durum:byte);
    procedure EmptyFields;
    procedure btnCiktiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    CEKSEN: Byte;
    tblCEKSEN:TBL_CEKSEN;
    tblCEKSENHAR : TBL_CEKSENHAR;
    prv_BelgeTur:Integer;
    prv_ISLEM : Byte;//CEKSENHAR.ISLEM
    prv_CanUpdate,prv_CanDelete:Boolean;

    prv_ceksen_id:Integer;
    prv_ceksen_sid:Integer;
        
    { Private declarations }
  public
    { Public declarations }
    prnCEKSENHARID,prnCEKSENHARSID:Integer;
  end;
  const cns_cek_ciro = 5;
  const cns_senet_ciro = 6;
var
  frmCEKSEN_CIRO: TfrmCEKSEN_CIRO;
  frmEkstra : TfrmCEKSEN_CIRO;
  frmMusteriCekCirola : TfrmCEKSEN_CIRO;
  frmMusteriSenetCirola : TfrmCEKSEN_CIRO;
  frmMusteriCekTahsilDek : TfrmCEKSEN_CIRO;
  frmMusteriSenetTahsilDek : TfrmCEKSEN_CIRO;
implementation

uses ufrmCariSDLG,unDataMod, ufrmCekSenSDLG, main,unFunc,ufrmCekSenHarSDGL,unCEKSENHAR, ufrmISN_ERRORS,
  unYazici, unLogger, UDm_Fast_Report;

{$R *.dfm}

procedure TfrmCEKSEN_CIRO.Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer; CEK_SEN:Byte; ISLEM:Byte);
var
  local_can_update,local_can_delete:Boolean;
//CEKSEN CEK,SENET
//BT_MCEK_CIRO = 8;  //MUSTERI CEK CIROLAMASI
//BT_MSEN_CIRO = 13; //MUSTERI SENET CIROLAMASI
//BT_BANK_MCEK_TAH    = 28;//BANKADAN GELEN ÇEK TAHSÝL DEKONTU        B CEK TAH DE  CEKSENHAR
//BT_BANK_MSEN_TAH    = 32;//BANKADAN GELEN SENET TAHSÝL DEKONTU      B SEN TAH DE  CEKSENHAR
//CEKSENHAR_ID: çekin veya senetin hareket id'si
//CEKSENHAR_SID: çekin veya senetin hareket sid'si
//ISLEM CÝRO TAHSÝL
begin
  case ISLEM of
  3://ciro
    case CEK_SEN of
    CEK://müþteri çeki
      begin //start
        if not DataMod.Modul_Hak(cns_cek_ciro,local_can_update,local_can_delete) then
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
          if not MainForm.FindChildFrm(Application, 'frmMusteriCekCirola') then
          begin
            Application.CreateForm(TfrmCEKSEN_CIRO,frmMusteriCekCirola);
            with frmMusteriCekCirola do
            begin
              Name := 'frmMusteriCekCirola';
              prv_CanUpdate := local_can_update;
              prv_CanDelete := local_can_delete;
              Caption := 'Müþteri Çeki Cirolama';
              CEKSEN := CEK_SEN;
              prv_BelgeTur := BT_MCEK_CIRO;
              prv_ISLEM := ISLEM;
              rgYAZICI.Visible := True;
              btnCikti.Visible := True;
              DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      end; //stop
    SENET://müþteri seneti
      begin//start
        if not DataMod.Modul_Hak(cns_senet_ciro,local_can_update,local_can_delete) then
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
          if not MainForm.FindChildFrm( Application, 'frmMusteriSenetCirola') then
          begin
            Application.CreateForm(TfrmCEKSEN_CIRO,frmMusteriSenetCirola);
            with frmMusteriSenetCirola do
            begin
              Name := 'frmMusteriSenetCirola';
              prv_CanUpdate := local_can_update;
              prv_CanDelete := local_can_delete;
              Caption := 'Müþteri Seneti Cirolama';
              lblCiroCariKod.Caption := 'Tahsil Edilecek Carinin Kodu';
              CEKSEN := CEK_SEN;
              prv_BelgeTur := BT_MSEN_CIRO;
              prv_ISLEM := ISLEM;
              DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      end;//stop
    end;//end case CEKSEN of
  4://tahsilden gelen tahsil dekontu
    case CEK_SEN of
    CEK://müþteri çeki
      begin //start
        if not DataMod.Modul_Hak(cns_cek_ciro,local_can_update,local_can_delete) then
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
          if not MainForm.FindChildFrm( Application, 'frmMusteriCekTahsilDek') then
          begin
            Application.CreateForm(TfrmCEKSEN_CIRO,frmMusteriCekTahsilDek);
            with frmMusteriCekTahsilDek do
            begin
              Name := 'frmMusteriCekTahsilDek';
              prv_CanUpdate := local_can_update;
              prv_CanDelete := local_can_delete;
              Caption := 'Bankadan Gelen Müþteri Çeki Tahsil Dekontu';
              lblCiroCariKod.Caption := 'Banka Kodu';
              CEKSEN := CEK_SEN;
              prv_BelgeTur := BT_BANK_MCEK_TAH;
              prv_ISLEM := ISLEM;
              DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      end; //stop
    SENET://müþteri seneti
      begin//start
        if not DataMod.Modul_Hak(cns_senet_ciro,local_can_update,local_can_delete) then
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
          if MainForm.FindChildFrm( Application, 'frmMusteriSenetTahsilDek') = False  Then
          begin
            Application.CreateForm(TfrmCEKSEN_CIRO,frmMusteriSenetTahsilDek);
            with frmMusteriSenetTahsilDek do
            begin
              prv_CanUpdate := local_can_update;
              prv_CanDelete := local_can_delete;
              Caption := 'Bankadan Gelen Müþteri Seneti Tahsil Dekontu';
              lblCiroCariKod.Caption := 'Tahsil Edilecek Bankanýn Kodu';
              CEKSEN := CEK_SEN;
              prv_BelgeTur := BT_BANK_MSEN_TAH;
              prv_ISLEM := ISLEM;
              DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
            end;
          end;
        end;
      end;//stop
    end;//end case CEKSEN of
  end;//end case ISLEM of
end;

procedure TfrmCEKSEN_CIRO.DataSet_Open(CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer);
var
  CARI_AD,PROJE_AD,PLASIYER_AD : string;
//BT
//BT_MCEK_CIRO = 8;  //MUSTERI CEK CIROLAMASI
//BT_MSEN_CIRO = 13; //MUSTERI SENET CIROLAMASI
//BELGE_ID: çekin veya senetin id si
//BELGE_SID: çekin veya senetin sid si
begin

     prv_ceksen_id:=0;
     prv_ceksen_sid:=0;

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
                                   ,Self.Label12
                                   ,Self.Label13
                                   ,Self.Label14
                                   ,Self.Label15
                                   ,Self.Label16);

  if not glb_PROJE_UYG then
  begin
    txtPROJEKOD.Visible := false;
    btnProjeKod.Visible := false;
    lblPrjAd.Visible := false;
    Label2.Visible := false;
    label1.Visible := false;
  end;

  if not glb_PLASIYER_UYG then
  begin
    txtPLASIYERKOD.Visible := false;
    btnPlasiyerKod.Visible := false;
    lblPlasiyerAd.Visible := false;
    label4.Visible := false;
    label3.Visible := false;
  end;

  case prv_BelgeTur of
  BT_MSEN_CIRO,BT_BANK_MSEN_TAH:
    begin
      lblCEKNUML.Visible := False;
      lblCEKNUM.Visible  :=  False;
    end;
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
           prv_ceksen_id:=CEKSEN_ID;
           prv_ceksen_sid:=CEKSEN_SID;


        lblBelgeFisNo.Caption := inttostr(CEKSENHAR_ID);
        dtpIslemTar.Date := ISLEM_TAR;
        dtpDovBazTar.Date := DOV_BAZ_TAR;
        txtDOVKUR.Value := DOVKUR;
        txtTutarVPB.Value := TUTAR_VPB;
        txtKURFARK.Value := KUR_FARKI;
        txtCARIHARACK.Text := CARIHAR_ACK;
        txtYEVMIYEACK.text := YEVMIYE_ACK;

        txtISLEMMERKEZI.Text := MASRAF_MERK ;
        txtKOD1.Text := KOD1;
        txtKOD2.Text := KOD2;
        txtKOD3.Text := KOD3;
        txtKOD4.Text := KOD4;

        txtCARIKOD.Text := CARI_KOD;
        txtPROJEKOD.Text := PROJE_KOD;
        txtPLASIYERKOD.Text := PLASIYER_KOD;

        if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCARIKOD.Text,CARI_AD) then
        begin
          lblCIROCARI_AD.Caption := CARI_AD;
        end;

        if  DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',txtPROJEKOD.text,PROJE_AD) then
        begin
          lblPrjAd.Caption := PROJE_AD;
        end;

        if  DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',txtPLASIYERKOD.text,PLASIYER_AD) then
        begin
          lblPlasiyerAd.Caption := PLASIYER_AD;
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
    txtDOVKUR.DisplayFormat := glb_DOV_KUR_PF;
    txtTutarVPB.DisplayFormat := glb_VPB_FIELD_PF;
    txtKURFARK.DisplayFormat := glb_VPB_FIELD_PF;
    btnCEKSENLIST.Enabled := True;
    dtpIslemTar.Date := DataMod.GET_SERVER_DATE;
    dtpDovBazTar.Date := dtpIslemTar.Date;
    buton_ayarla(1);
  end;
end;

procedure TfrmCEKSEN_CIRO.GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
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
      3://ciro
        case CEKSEN of
        CEK:
          begin
            txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çeki cirolama iþlemi.';
            txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çeki cirolama iþlemi.';
          end;
        SENET:
          begin
            txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý seneti cirolama iþlemi.';
            txtYEVMIYEACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý seneti cirolama iþlemi.';
          end;
        end;//end case CEKSEN of
      4://tahsil
        case CEKSEN of
        CEK:
          begin
            txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin tahsil dekontu iþlemi.';
            txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin tahsil dekontu iþlemi.';
          end;
        SENET:
          begin
             txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin tahsil dekontu iþlemi.';
             txtYEVMIYEACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin tahsil dekontu iþlemi.';
          end;
        end;//end case CEKSEN of
      end;//end case prv_ISLEM of
      TutarFarkHesapla;
    end;//end if YENI_KAYIT then

    case prv_BelgeTur of
    BT_MCEK_CIRO,BT_BANK_MCEK_TAH:
      begin
        lblCEKNUM.Caption  :=  tblCEKSEN.CEK_NUM;
      end;
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
    lblCIROCARI_AD.Caption := '';
    txtTutarVPB.Value := 0;
    txtKURFARK.Value := 0;
    txtCARIHARACK.Clear;
    txtYEVMIYEACK.Clear;
    txtISLEMMERKEZI.Text := '';
    txtKOD1.Text := '';
    txtKOD2.Text := '';
    txtKOD3.Text := '';
    txtKOD4.Text := '';
  end;
end;




procedure TfrmCEKSEN_CIRO.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmCEKSEN_CIRO.btnCIKISClick(Sender: TObject);
begin
  Close;
end;

Procedure TfrmCEKSEN_CIRO.EmptyFields;
begin
  txtNO.clear;
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
  lblCIROCARI_AD.Caption := '';
  lblPrjAd.Caption := '';
  lblPlasiyerAd.Caption := '';
  txtCARIKOD.Clear;
  txtPROJEKOD.Clear;
  txtPLASIYERKOD.Clear;
  txtISLEMMERKEZI.Clear;
  txtKOD1.Clear;
  txtKOD2.Clear;
  txtKOD3.Clear;
  txtKOD4.Clear;
  txtCARIHARACK.Clear;
  txtYEVMIYEACK.Clear;
  txtDOVKUR.Value := 0;
  txtKURFARK.Clear;
  txtTutarVPB.Clear;
  btnCEKSENLIST.Enabled := False;
  btnIPTAL.Enabled := False;
  btnCIRO.Enabled := False;
  btnYeni.Enabled := True;
end;

procedure TfrmCEKSEN_CIRO.btnCEKSENLISTClick( Sender: TObject);
var
  BELGE_ID, BELGE_SID:Integer;
  CARI_AD : String;
begin
  case prv_ISLEM of
  3:
    if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,1,True,1,1) Then
    begin
      GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
    end;
  4:
    if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,1,True,1,3) then
    begin
      GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
////////////////////////////////////////////////////////////////////////////////
      if prv_ISLEM = 4 then
      begin
        with DataMod.qryGENEL do
        Begin
           Active := False;
           SQL.Clear;
           SQL.Add('SELECT CARI_KOD FROM CEKSENHAR WHERE ISLEM = 2 AND BELGE_ID =' + IntToStr ( BELGE_ID) + ' AND BELGE_SID ='+  IntToStr (BELGE_SID));
           Active := True;
           txtCARIKOD.Text := fieldbyname('CARI_KOD').AsString;
           Active := False;
           if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCARIKOD.Text,CARI_AD) then lblCIROCARI_AD.Caption := CARI_AD;
        end;
      end;
////////////////////////////////////////////////////////////////////////////////
    end;
  end;//end case prv_ISLEM of
end;

procedure TfrmCEKSEN_CIRO.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0);
end;

procedure TfrmCEKSEN_CIRO.btnIPTALClick(Sender: TObject);
begin
  if Application.MessageBox('Ýþlemi iptal etmek istiyor musunuz?','Dikkat',MB_YESNO+MB_ICONQUESTION) = 6 then
  begin
    EmptyFields;
//****************************************************************************//
    if trnCekSenHar.InTransaction then
       trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//

    buton_ayarla(3);
    prnCEKSENHARID := 0;
    prnCEKSENHARSID := 0;
  end;
end;

procedure TfrmCEKSEN_CIRO.btnCIROClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmCEKSEN_CIRO.TutarFarkHesapla;
var
  Temp,Kur : Currency;
begin
  Kur := DataMod.Get_Doviz_Kur(tblCEKSEN.DOVKOD, dtpDovBazTar.Date,glb_SATISKUR,0);
  if Kur <> 0 then txtDOVKUR.Value:= Kur else txtDOVKUR.Value:= 0;
  if tblCEKSEN.TUTAR = txtTUTARVPB.Value then
  begin
    txtKURFARK.Value := 0
  end
  else
  begin
    Temp := tblCEKSEN.TUTAR * Kur;
    txtKURFARK.Value :=  Temp - tblCEKSEN.TUTAR_VPB;
  end;

  txtTutarVPB.Value := tblCEKSEN.TUTAR * txtDOVKUR.Value ;
end;

procedure TfrmCEKSEN_CIRO.txtCARIKODExit(Sender: TObject);
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
    txtCARIKOD.Clear;
    lblCIROCARI_AD.Caption := '';
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmCEKSEN_CIRO.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCEKSEN_CIRO.txtPROJE_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_CIRO.txtPLASIYER_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_CIRO.txt_PLASIYERKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txt_PLASIYERKODButtonClick(Self);
end;

procedure TfrmCEKSEN_CIRO.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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
         if btnSIL.Enabled Then btnSILClick(self);
       end;
    end; // case end;
  end//Shift = [ssCtrl] then end
  else
  if Shift = [] then
  begin
    case Key of
    45://ins kaydet
       begin
         if btnYeni.Enabled then btnYeniClick(Self);
       end;
    end;//acase end
  end; ///if Shift = [] then ENd
end;

procedure TfrmCEKSEN_CIRO.txt_CARIKODKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_CIRO.txt_CARIKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txt_CARIKODButtonClick(Self);
end;

procedure TfrmCEKSEN_CIRO.txt_CARIKODButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
    txtCARIKOD.Text:=Cari_KOD;
    lblCIROCARI_AD.Caption := Cari_AD;
  end;
end;

procedure TfrmCEKSEN_CIRO.txt_CARIKODExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCARIKOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCARIKOD.Text,CARI_AD) then
    begin
      lblCIROCARI_AD.Caption := CARI_AD;
    end
    else
    begin
      txtCARIKOD.SetFocus;
    end;
  end
  else
  begin
    txtCARIKOD.Clear;
  end;
end;


procedure TfrmCEKSEN_CIRO.txt_PROJEKODExit(Sender: TObject);
var
  PROJE_AD:String;
begin
  if Trim(txtPROJEKOD.Text) <> '' then
  begin
    if  DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',txtPROJEKOD.Text,PROJE_AD) then
    begin
      lblPrjAd.Caption := PROJE_AD;
    end
    else
    begin
      txtPROJEKOD.SetFocus;
    end;
  end;
end;


procedure TfrmCEKSEN_CIRO.txt_PROJEKODKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F4 then btnProjeKodClick(Self);
end;

procedure TfrmCEKSEN_CIRO.txt_PLASIYERKODButtonClick(Sender: TObject);
var
  PLASIYER_KOD, PLASIYER_AD :String;
begin
  if DataMod.LS_Plasiyer(PLASIYER_KOD, PLASIYER_AD,1) then
  begin
    txtPROJEKOD.Text := PLASIYER_KOD;
    lblPlasiyerAd.Caption := PLASIYER_AD;
  end;
end;


procedure TfrmCEKSEN_CIRO.btnAraClick(Sender: TObject);
var
  temp_id,temp_sid : integer;
  islem : byte;
begin
  if frmCekSenHarSDGL.Form_Open(False,
                                CEKSEN //CEK MÝ SENET MÝ
                                ,1//1-MÜÞTERÝ 2-BORÇ
                                ,prv_ISLEM //ISLEM=3 CÝRO ISLEM=4 BANKADAN GELEN TAHSIL DEKONTU
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

procedure TfrmCEKSEN_CIRO.buton_ayarla(durum:byte);
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
  end;//end case
end;

procedure TfrmCEKSEN_CIRO.txtDOVKURExit(Sender: TObject);
begin
  if (txtDOVKUR.value <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada küçük olamaz.Lütfen kontrol ediniz.');
    txtDOVKUR.Value := 1;
    txtDOVKUR.SetFocus;
    exit;
  end;
  (Sender as TIB_Currency).Color := clWindow;  
end;

procedure TfrmCEKSEN_CIRO.btnCariKodClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  case prv_ISLEM of
  3:
    if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
    begin
      txtCARIKOD.Text := Cari_KOD;
      lblCIROCARI_AD.Caption := Cari_AD;
    end;
  4:
    if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,0) Then
    begin
      txtCARIKOD.Text := Cari_KOD;
      lblCIROCARI_AD.Caption := Cari_AD;
    end;
  end;
end;

procedure TfrmCEKSEN_CIRO.btnProjeKodClick(Sender: TObject);
var
  PROJEKOD,PROJEAD:String;
begin
  if DataMod.LS_Proje(PROJEKOD,PROJEAD,1) Then
  begin
    txtPROJEKOD.Text := PROJEKOD;
    lblPrjAd.Caption := PROJEAD;
  end;
end;

procedure TfrmCEKSEN_CIRO.btnPlasiyerKodClick(Sender: TObject);
var
  PLASIYERKOD, PLASIYERAD :String;
begin
  if DataMod.LS_Plasiyer(PLASIYERKOD, PLASIYERAD,1) then
  begin
    txtPLASIYERKOD.Text := PLASIYERKOD;
    lblPlasiyerAd.Caption := PLASIYERAD;
  end;
end;

procedure TfrmCEKSEN_CIRO.txtCARIKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then btnCariKodClick(Self);
end;

procedure TfrmCEKSEN_CIRO.txtCARIKODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_CIRO.txtPROJEKODExit(Sender: TObject);
var
  PROJEAD:String;
begin
  if Trim(txtPROJEKOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',txtPROJEKOD.Text,PROJEAD) then
    begin
      (Sender as TEdit).Color := clWindow;
      lblPrjAd.Caption := PROJEAD;
    end
    else
    begin
      txtPROJEKOD.SetFocus;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
    txtPROJEKOD.Clear;
  end;
end;

procedure TfrmCEKSEN_CIRO.txtPROJEKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then btnProjeKodClick(Self);
end;

procedure TfrmCEKSEN_CIRO.txtPROJEKODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_CIRO.txtPLASIYERKODKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnPlasiyerKodClick(Self);
end;

procedure TfrmCEKSEN_CIRO.txtPLASIYERKODExit(Sender: TObject);
var
  PLASIYERAD:String;
begin
  if Trim(txtPLASIYERKOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',txtPLASIYERKOD.Text,PLASIYERAD) then
    begin
      (Sender as TEdit).Color := clWindow;
      lblPlasiyerAd.Caption := PLASIYERAD;
    end
    else
    begin
      txtPLASIYERKOD.SetFocus;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
    txtPLASIYERKOD.Clear;
  end;
end;

procedure TfrmCEKSEN_CIRO.txtPLASIYERKODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_CIRO.txtDOVKURChange(Sender: TObject);
begin
  txtTutarVPB.Value := tblCEKSEN.TUTAR * txtDOVKUR.Value;
  txtKURFARK.Value := txtTutarVPB.Value - tblCEKSEN.TUTAR_VPB;
end;

procedure TfrmCEKSEN_CIRO.dtpDOVBAZTARCloseUp(Sender: TObject);
var
  Kur_Deger : Currency;
begin
  Kur_Deger := DataMod.Get_Doviz_Kur(tblCEKSEN.DOVKOD,dtpDovBazTar.Date,glb_SATISKUR,0);
  if Kur_Deger <> 0 then txtDOVKUR.Value := Kur_Deger else txtDOVKUR.Value := 1;
end;

procedure TfrmCEKSEN_CIRO.btnSilClick(Sender: TObject);
var
  qryDeg1:TIB_Query;
begin

     if prv_ceksen_id<>0 then
     begin


     DataMod.CreateQuery(qryDeg1,Nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Text:=                                                                                             //satýcý kaþýlýksýz dekontu
     ' SELECT  count(*) Gelen FROM CEKSENHAR WHERE CEKSEN =:TIPI AND BELGE_ID=:BELGE_ID AND BELGE_SID=:BELGE_SID and ISLEM=6';
     qryDeg1.ParamByName('TIPI').AsInteger:=CEKSEN;

     qryDeg1.ParamByName('BELGE_ID').AsInteger:=    prv_ceksen_id;
     qryDeg1.ParamByName('BELGE_SID').AsInteger:=    prv_ceksen_sid;
     qryDeg1.Open;

     if qryDeg1.FieldByName('Gelen').AsInteger<=0 then
     Form_Delete;
     end
     else
     begin
        Application.MessageBox('Satýcý Karþýlýksýz Dekontu Ýptalinden Sonra Bu Ýþlemi Yapabilirsiniz ','Dikkat',MB_ICONQUESTION);
     end;
end;

procedure TfrmCEKSEN_CIRO.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TfrmCEKSEN_CIRO.txtKOD1Exit(Sender: TObject);
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

procedure TfrmCEKSEN_CIRO.txtKOD2Exit(Sender: TObject);
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

procedure TfrmCEKSEN_CIRO.txtKOD3Exit(Sender: TObject);
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

procedure TfrmCEKSEN_CIRO.txtKOD4Exit(Sender: TObject);
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

procedure TfrmCEKSEN_CIRO.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;


procedure TfrmCEKSEN_CIRO.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;


procedure TfrmCEKSEN_CIRO.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_CIRO.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_CIRO.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_CIRO.txtISLEMMERKEZIKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button1Click(Self);
end;

procedure TfrmCEKSEN_CIRO.txtKOD1KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button2Click(Self);
end;

procedure TfrmCEKSEN_CIRO.txtKOD2KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button3Click(Self);
end;

procedure TfrmCEKSEN_CIRO.txtKOD3KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button4Click(Self);
end;

procedure TfrmCEKSEN_CIRO.txtKOD4KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button5Click(Self);
end;

function TfrmCEKSEN_CIRO.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpISLEMTAR.Date,True) then Exit;
  Result := True;
end;

function TfrmCEKSEN_CIRO.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  case CEKSEN of
  1://cek start
    begin
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir çek seçiniz.','Dikkat',MB_ICONQUESTION);
        btnCEKSENLISTClick(Self);
        exit;
      end;

      if (Trim(txtCARIKOD.Text)='') then
      begin
        txtCARIKOD.SetFocus;
        Application.MessageBox('Lütfen listeden bir cari seçiniz.','Dikkat',MB_ICONQUESTION);
        btnCariKodClick(Self);
        exit;
      end;

      if (tblCEKSEN.CARI_KOD = Trim(txtCARIKOD.Text)) then
      begin
        Application.MessageBox('Çeki ayný cariye cirolayamazsýnýz.','Dikkat',MB_ICONWARNING);
        exit;
      end;

      if (txtDOVKUR.Value <= 0) then
      begin
        Application.MessageBox('Çekin döviz sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
        exit;
      end;

      if (txtTUTARVPB.Value <= 0) then
      begin
        Application.MessageBox('Tutar vpb sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
        exit;
      end;

    end;//cek stop
  2:
    begin//senet start
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir senet seçiniz.','Dikkat',MB_ICONQUESTION);
        btnCEKSENLISTClick(Self);
        exit;
      end;

      if (Trim(txtCARIKOD.Text)='') then
      begin
        txtCARIKOD.SetFocus;
        Application.MessageBox('Lütfen listeden bir cari seçiniz.','Dikkat',MB_ICONQUESTION);
        btnCariKodClick(Self);
        exit;
      end;

      if (tblCEKSEN.CARI_KOD = Trim(txtCARIKOD.Text)) then
      begin
        Application.MessageBox('Seneti ayný cariye cirolayamazsýnýz.','Dikkat',MB_ICONWARNING);
        exit;
      end;

      if (txtDOVKUR.Value <= 0) then
      begin
        Application.MessageBox('Senetin döviz kuru sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
        exit;
      end;

      if (txtTUTARVPB.Value <= 0) then
      begin
        Application.MessageBox('Tutar vpb sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
        exit;
      end;
    end;//senet stop
  end;//end case CEKSEN of
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpISLEMTAR.Date,True) then Exit;
  if not DataMod.IsDateInTerm(dtpISLEMTAR.Date, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(dtpDOVBAZTAR.Date, 'Döviz Baz Tarihi') then Exit;
  Result := True;
end;

procedure TfrmCEKSEN_CIRO.Form_Delete;
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
    tblCEKSENHAR.CARI_KOD := Trim(txtCARIKOD.Text);
    tblCEKSENHAR.PROJE_KOD := Trim(txtPROJEKOD.Text);
    tblCEKSENHAR.PLASIYER_KOD := Trim(txtPLASIYERKOD.Text);

    tblCEKSENHAR.ISLEM_TAR := dtpIslemTar.Date;
    tblCEKSENHAR.DOV_BAZ_TAR := dtpDovBazTar.Date;

    tblCEKSENHAR.DOVKUR := txtDOVKUR.Value;
    tblCEKSENHAR.TUTAR_VPB := txtTutarVPB.Value;
    tblCEKSENHAR.KUR_FARKI := txtKURFARK.Value;

    tblCEKSENHAR.MASRAF_MERK := Trim(txtISLEMMERKEZI.Text);
    tblCEKSENHAR.KOD1 := Trim(txtKOD1.Text);
    tblCEKSENHAR.KOD2 := Trim(txtKOD2.Text);
    tblCEKSENHAR.KOD3 := Trim(txtKOD3.Text);
    tblCEKSENHAR.KOD4 := Trim(txtKOD4.Text);

    tblCEKSENHAR.CARIHAR_ACK := Trim(txtCARIHARACK.Text);
    tblCEKSENHAR.YEVMIYE_ACK := Trim(txtYEVMIYEACK.Text);

    tblCEKSENHAR.CEKSEN := CEKSEN;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := prv_ISLEM;
    tblCEKSENHAR.PROTESTO_MASRAF := 0;
    tblCEKSENHAR.GENEL_GIDER := 0;
    tblCEKSENHAR.GENEL_GIDER_MUH_KOD := '';
    tblCEKSENHAR.BORCALHESAP :='';
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
//****************************************************************************//
    trnCekSenHar.Commit;
  except
    trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  EmptyFields;
  buton_ayarla(3);
end;

procedure TfrmCEKSEN_CIRO.Form_Post;
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;
//****************************************************************************//
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trnCekSenHar.InTransaction then
       trnCekSenHar.Rollback;
    trnCekSenHar.StartTransaction;
//****************************************************************************//
    tblCEKSENHAR.CARI_KOD := Trim(txtCARIKOD.Text);
    tblCEKSENHAR.PROJE_KOD := Trim(txtPROJEKOD.Text);
    tblCEKSENHAR.PLASIYER_KOD := Trim(txtPLASIYERKOD.Text);

    tblCEKSENHAR.ISLEM_TAR := dtpIslemTar.Date;
    tblCEKSENHAR.DOV_BAZ_TAR := dtpDovBazTar.Date;

    tblCEKSENHAR.DOVKUR := txtDOVKUR.Value;
    tblCEKSENHAR.TUTAR_VPB := txtTutarVPB.Value;
    tblCEKSENHAR.KUR_FARKI := txtKURFARK.Value;

    tblCEKSENHAR.MASRAF_MERK := Trim(txtISLEMMERKEZI.Text);
    tblCEKSENHAR.KOD1 := Trim(txtKOD1.Text);
    tblCEKSENHAR.KOD2 := Trim(txtKOD2.Text);
    tblCEKSENHAR.KOD3 := Trim(txtKOD3.Text);
    tblCEKSENHAR.KOD4 := Trim(txtKOD4.Text);

    tblCEKSENHAR.CARIHAR_ACK := Trim(txtCARIHARACK.Text);
    tblCEKSENHAR.YEVMIYE_ACK := Trim(txtYEVMIYEACK.Text);

    tblCEKSENHAR.CEKSEN := CEKSEN;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := prv_ISLEM;
    tblCEKSENHAR.PROTESTO_MASRAF := 0;
    tblCEKSENHAR.GENEL_GIDER := 0;
    tblCEKSENHAR.GENEL_GIDER_MUH_KOD := '';
    tblCEKSENHAR.BORCALHESAP :='';
//****************************************************************************//
    if not dmCEKSENHAR.CEKSENHAR_AUD(trnCekSenHar,tblCEKSENHAR,prv_BelgeTur,'',0) then
    begin
      trnCekSenHar.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    prnCEKSENHARID := tblCEKSENHAR.CEKSENHAR_ID;
    prnCEKSENHARSID := tblCEKSENHAR.CEKSENHAR_SID;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,SENET,',
                                             prv_BelgeTur,
                                             prnCEKSENHARID,
                                             prnCEKSENHARSID,
                                             1,1,'');
//****************************************************************************//
    trnCekSenHar.Commit;
//****************************************************************************//
    if rgYAZICI.Visible = True then
    begin
      case CEKSEN of
      CEK:
        begin
          case prv_BelgeTur of
          BT_MCEK_CIRO     : if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(81)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,81,8,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

          Yazici.MCEKCIRO(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
          BT_BANK_MCEK_TAH : if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(281)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,281,28,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

          Yazici.BANKADANMUSTERICEKTAHSIL(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
          end;
        end;
      end;
      prnCEKSENHARID := 0;
      prnCEKSENHARSID := 0;
    end;
//****************************************************************************//
  except
    trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
    Raise;
  end;
  EmptyFields;
  buton_ayarla(2);
end;

procedure TfrmCEKSEN_CIRO.txtCARIKODEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_CIRO.txtDOVKUREnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_CIRO.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(Self);
end;

procedure TfrmCEKSEN_CIRO.dtpISLEMTAREnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_CIRO.dtpISLEMTARExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmCEKSEN_CIRO.txtCARIHARACKExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmCEKSEN_CIRO.btnCiktiClick(Sender: TObject);
begin
  if prnCEKSENHARID<=0 then Exit;
  if (prnCEKSENHARID = 0) or (prnCEKSENHARSID = 0) then
  begin
    Application.MessageBox('Þu anda herhangi bir çýktý alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.Visible = True then
  begin
    case CEKSEN of
    CEK:
      begin
        case prv_BelgeTur of
        BT_MCEK_CIRO     : if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(81)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,81,8,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else
        Yazici.MCEKCIRO(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
        BT_BANK_MCEK_TAH : if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(281)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,281,28,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

        Yazici.BANKADANMUSTERICEKTAHSIL(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
        end;
      end;
    end;
  end;
end;

end.
