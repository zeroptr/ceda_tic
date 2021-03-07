unit ufrmCEKSEN_KASA;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, IB_Components, Mask, IB_Controls,
  ComCtrls,GenTypes;

type
  TfrmCEKSEN_KASA = class(TForm)
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
    lblKASA_AD: TLabel;
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
    btnKASAKOD: TButton;
    btnProjeKod: TButton;
    btnPlasiyerKod: TButton;
    txtKASAKOD: TEdit;
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
    rgYAZICI: TRadioGroup;
    lblCEKNUML: TLabel;
    lblCEKNUM: TLabel;
    btnCikti: TButton;
    Label18: TLabel;
    lblBelgeFisNo: TLabel;
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
    procedure txtKASAKODExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtPROJE_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txtPLASIYER_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txt_PLASIYERKODKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;              Shift: TShiftState);
    procedure txt_PROJEKODExit(Sender: TObject);
    procedure txt_PROJEKODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txt_PLASIYERKODButtonClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure txtDOVKURExit(Sender: TObject);
    procedure btnKASAKODClick(Sender: TObject);
    procedure btnProjeKodClick(Sender: TObject);
    procedure btnPlasiyerKodClick(Sender: TObject);
    procedure txtKASAKODKeyDown(Sender: TObject; var Key: Word;        Shift: TShiftState);
    procedure txtKASAKODKeyPress(Sender: TObject; var Key: Char);
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
    procedure btnCiktiClick(Sender: TObject);
    procedure txtKASAKODEnter(Sender: TObject);
    procedure dtpISLEMTAREnter(Sender: TObject);
    procedure dtpISLEMTARExit(Sender: TObject);
    procedure txtDOVKUREnter(Sender: TObject);
    procedure txtCARIHARACKExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    procedure EmptyFields;
    procedure Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer;CEKSENHAR_SID:Integer; CEK_SEN:Byte; ISLEM:Byte;  CEKSENTIP:Byte);
    procedure DataSet_Open(CEKSENHAR_ID:Integer;CEKSENHAR_SID:Integer);
    procedure TutarFarkHesapla;
    procedure GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
    procedure buton_ayarla(durum:byte);
    procedure txtdisable(tip:Boolean);
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
////////////////////////////////////////////////////////////////////////////////
  private
    CEKSEN: Byte;
    tblCEKSEN:TBL_CEKSEN;
    tblCEKSENHAR : TBL_CEKSENHAR;
    prv_BelgeTur:Integer;
    prv_ISLEM : Byte;//CEKSENHAR.ISLEM
    prv_CEKSENTIP : Byte;//
    prv_CanUpdate,prv_CanDelete:Boolean;
    { Private declarations }
  public
    { Public declarations }
    prnCEKSENHARID,prnCEKSENHARSID:Integer;
  end;
  const cns_cek_kasa = 5;
  const cns_senet_kasa = 6;
var
  frmCEKSEN_KASA: TfrmCEKSEN_KASA;
  frmKasayaTahsilEdilenCek: TfrmCEKSEN_KASA;
  frmKasadanTediyeEdilenCek: TfrmCEKSEN_KASA;
  frmKasayaTahsilEdilenSenet: TfrmCEKSEN_KASA;
  frmKasadanTediyeEdilenSenet: TfrmCEKSEN_KASA;
implementation

uses ufrmCariSDLG,unDataMod, ufrmCekSenSDLG, main,unFunc,ufrmCekSenHarSDGL,unCEKSENHAR, ufrmISN_ERRORS,UnYazici,
  unLogger, UDm_Fast_Report;

{$R *.dfm}

procedure TfrmCEKSEN_KASA.Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer; CEK_SEN:Byte; ISLEM:Byte; CEKSENTIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
//CEKSEN CEK,SENET
//ISLEM
//9- Kasaya Tahsil
//CEKSENHAR_ID: çekin veya senetin hareket id'si
//CEKSENHAR_SID: çekin veya senetin hareket sid'si
//BT_MCEK_TAHSIL_VER  = 21;//MUSTERI CEKI TAHSILE VERME               CEK TAHSIL VER   CEKSENHAR
//BT_MSEN_TAHSIL_VER  = 22;//MUSTERI SENEDI TAHSILE VERME             SEN TAHSIL VER   CEKSENHAR
begin
  case CEK_SEN of
  CEK://
    begin //start
      case CEKSENTIP of
      1:
        begin
          if not DataMod.Modul_Hak(cns_cek_kasa,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm(Application, 'frmKasayaTahsilEdilenCek') then
            begin
              Application.CreateForm(TfrmCEKSEN_KASA,frmKasayaTahsilEdilenCek);
              with frmKasayaTahsilEdilenCek do
              begin
                Name := 'frmKasayaTahsilEdilenCek';
                Caption := 'Kasaya Çek Tahsili';
                prv_CanUpdate := local_can_update;
                prv_CanDelete := local_can_delete;
                CEKSEN := CEK_SEN;
                prv_BelgeTur := BT_KASA_CEKSEN_TAH;
                prv_ISLEM := ISLEM;
                prv_CEKSENTIP := CEKSENTIP;
                DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
              end;
            end;
          end;
        end;
      2:
        begin//start 2
          if not DataMod.Modul_Hak(cns_cek_kasa,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm(Application, 'frmKasadanTediyeEdilenCek') then
            begin
              Application.CreateForm(TfrmCEKSEN_KASA,frmKasadanTediyeEdilenCek);
              with frmKasadanTediyeEdilenCek do
              begin
                Name := 'frmKasadanTediyeEdilenCek';
                Caption := 'Kasadan Çek Tediyesi';
                prv_CanUpdate := local_can_update;
                prv_CanDelete := local_can_delete;
                CEKSEN := CEK_SEN;
                prv_BelgeTur := BT_KASA_CEKSEN_TED;
                prv_ISLEM := ISLEM;
                prv_CEKSENTIP := CEKSENTIP;
                DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
              end;
            end;
          end;
        end;//stop 2
      end;//end case CEKSENTIP of
    end; //CEK stop
  SENET://
    begin//start
      case CEKSENTIP of
      1:
        begin
          if not DataMod.Modul_Hak(cns_senet_kasa,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm( Application, 'frmKasayaTahsilEdilenSenet') then
            begin
              Application.CreateForm(TfrmCEKSEN_KASA,frmKasayaTahsilEdilenSenet);
              with frmKasayaTahsilEdilenSenet do
              begin
                Name := 'frmKasayaTahsilEdilenSenet';
                Caption := 'Kasaya Senet Tahsili';
                prv_CanUpdate := local_can_update;
                prv_CanDelete := local_can_delete;
                CEKSEN := CEK_SEN;
                prv_BelgeTur := BT_KASA_CEKSEN_TAH;
                prv_ISLEM := ISLEM;
                prv_CEKSENTIP := CEKSENTIP;
                DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
              end;
            end;
          end;
        end;
      2:
        begin//start 2
          if not DataMod.Modul_Hak(cns_senet_kasa,local_can_update,local_can_delete) then
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
            if not MainForm.FindChildFrm( Application, 'frmKasadanTediyeEdilenSenet') then
            begin
              Application.CreateForm(TfrmCEKSEN_KASA,frmKasadanTediyeEdilenSenet);
              with frmKasadanTediyeEdilenSenet do
              begin
                Name := 'frmKasadanTediyeEdilenSenet';
                Caption := 'Kasadan Senet Tediyesi';
                prv_CanUpdate := local_can_update;
                prv_CanDelete := local_can_delete;
                CEKSEN := CEK_SEN;
                prv_BelgeTur := BT_KASA_CEKSEN_TED;
                prv_ISLEM := ISLEM;
                prv_CEKSENTIP := CEKSENTIP;
                DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
              end;
            end;
          end;
        end;//stop 2
      end;//end case CEKSENTIP of
    end;//stop
  end;//end case CEKSEN of
end;

procedure TFRMCEKSEN_KASA.DataSet_Open(CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer);
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
                                   ,Self.Label12
                                   ,Self.Label13
                                   ,Self.Label14
                                   ,Self.Label15
                                   ,Self.Label16);

  if not glb_PROJE_UYG then
  begin
    txtPROJEKOD.Visible := false;
    btnProjeKod.Visible := false;
  end;

  if not glb_PLASIYER_UYG then
  begin
    txtPLASIYERKOD.Visible := false;
    btnPlasiyerKod.Visible := false;
  end;

  if CEKSEN <> CEK then
  begin
    lblCEKNUML.Visible := False;
    lblCEKNUM.Visible := False;
  end;

  if (CEKSENHAR_ID <> 0)  and (CEKSENHAR_SID <> 0) then
  begin
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
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

        txtKASAKOD.Text := KASA_KOD;
        txtPROJEKOD.Text := PROJE_KOD;
        txtPLASIYERKOD.Text := PLASIYER_KOD;

        if DataMod.FN_KOD2AD('KASA','KASA_KOD','ACIKLAMA',txtKASAKOD.Text,CARI_AD) then
        begin
          lblKASA_AD.Caption := CARI_AD;
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
    buton_ayarla(4);
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
    txtdisable(True);
  end;
end;

procedure TFRMCEKSEN_KASA.GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
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
      txtdisable(false);
      txtKASAKODExit(Self);
      {
      case prv_CEKSENTIP of
      1:
        begin
          case CEKSEN of
          CEK:
            begin
              txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin kasaya tahsili.';
              txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin kasaya tahsili.';
            end;
          SENET:
            begin
              txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin kasaya tahsili.';
              txtYEVMIYEACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin kasaya tahsili.';
            end;
          end;//end case CEKSEN of
        end;
      2:
        begin
          case CEKSEN of
          CEK:
            begin
              txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin kasadan tediyesi.';
              txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin kasadan tediyesi.';
            end;
          SENET:
            begin
              txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin kasadan tediyesi.';
              txtYEVMIYEACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý senetin kasadan tediyesi.';
            end;
          end;//end case CEKSEN of
        end;
      end;//end case prv_CEKSENTIP of
      }
      TutarFarkHesapla;
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
    lblCEKNUM.Caption := '';
    lblCEKSAHIBI.Caption := '';
    lblCARIKOD.Caption := '';
    lblCARIAD.Caption := '';
    lblTANZIMTAR.Caption := '';
    lblDOVKOD.Caption := '';
    lblDOVKUR.Caption := '';
    lblTUTAR.Caption := '';
    lblTUTAR_VPB.Caption := '';
    lblKASA_AD.Caption := '';
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

procedure TFRMCEKSEN_KASA.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TFRMCEKSEN_KASA.btnCIKISClick(Sender: TObject);
begin
  Close;
end;

Procedure TFRMCEKSEN_KASA.EmptyFields;
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
  lblKASA_AD.Caption := '';
  lblPrjAd.Caption := '';
  lblPlasiyerAd.Caption := '';
  txtKASAKOD.Clear;

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

procedure TFRMCEKSEN_KASA.btnCEKSENLISTClick( Sender: TObject);
var
  BELGE_ID, BELGE_SID:Integer;
begin
  case prv_CEKSENTIP of
  1:
    begin
      case CEKSEN of
      CEK:
        begin
          //müþteri çekleri
          if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,1,True,1,1) then
          begin
            GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
          end;
          /////////////
        end;
      SENET:
        begin
        //müþteri senetleri
          if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,1,True,1,1) then
          begin
            GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
          end;
          /////////////
        end;
      end;//end case CEKSEN of
    end;
  2:
    begin
      case CEKSEN of
      CEK:
        begin
        //borç çekleri
          if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,2,True,1,2) then
          begin
            GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
          end;
          /////////////
        end;
      SENET:
        begin
        //borç senetleri
          if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,2,True,1,2) then
          begin
            GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
          end;
          /////////////
        end;
      end;//end case CEKSEN of
    end;
  end;//end case prv_CEKSENTIP of
end;

procedure TFRMCEKSEN_KASA.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0);
end;

procedure TFRMCEKSEN_KASA.btnIPTALClick(Sender: TObject);
begin
  if Application.MessageBox('Ýþlemi iptal etmek istiyor musunuz?','Dikkat',MB_YESNO+MB_ICONQUESTION) = 6 then
  begin
    EmptyFields;
//****************************************************************************//
    if trnCekSenHar.InTransaction then
       trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
    txtdisable(true);
    buton_ayarla(3);
    prnCEKSENHARID := 0;
    prnCEKSENHARSID := 0;
  end;
end;

procedure TFRMCEKSEN_KASA.btnCIROClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TFRMCEKSEN_KASA.TutarFarkHesapla;
var
  Temp,Kur : Currency;
begin
  Kur := DataMod.Get_Doviz_Kur(tblCEKSEN.DOVKOD, dtpDovBazTar.Date,glb_SATISKUR,0);
  if Kur <> 0 then  txtDOVKUR.Value:= Kur else txtDOVKUR.Value:= 1;

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

procedure TFRMCEKSEN_KASA.txtKASAKODExit(Sender: TObject);
var
  KASA_AD:String;
  qry_temp : TIB_Query;
begin
  if Trim(txtKASAKOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('KASA','KASA_KOD','ACIKLAMA',txtKASAKOD.Text,KASA_AD) then
    begin
      (Sender as TEdit).Color := clWindow;
      lblKASA_AD.Caption := KASA_AD;
      TutarFarkHesapla;
    end
    else
    begin
      txtKASAKOD.SetFocus;
    end;
  end
  else
  begin
    txtKASAKOD.Clear;
    lblKASA_AD.Caption := '';
    txtKASAKOD.Color := clWindow;
  end;

  if (Trim(txtNO.Text)<>'') and (Trim(txtKASAKOD.Text)<>'') and (Trim(txtYEVMIYEACK.Text)='') and (Trim(txtCARIHARACK.Text)='') then
  begin
    case CEKSEN of
    CEK:
      case prv_CEKSENTIP of
      1://tahsil
        begin
          txtCARIHARACK.Text := lblCEKNUM.Caption + ' nolu çekin ' + txtKASAKOD.Text + ' e tahsili';
          {Lite
          DataMod.CreateQuery(qry_temp,nil,False,DataMod.dbaMain);
          with qry_temp do
          begin
            Active := false;
            SQL.Clear;
            SQL.Add('SELECT MUHASKOD AS KASA_MUHASKOD FROM KASA WHERE KASA.KASA_KOD=:PRM_KASA_KOD');
            ParamByName('PRM_KASA_KOD').AsString := txtKASAKOD.Text;
            Active := True;
          end;
          ///////////////////////////////////
          txtYEVMIYEACK.Text := lblCEKNUM.Caption + ' nolu çekin ' + qry_temp.FieldByName('KASA_MUHASKOD').AsString + ' a Tahsili';
          }
        end;
      2://tediye
        begin
          txtCARIHARACK.Text := lblCEKNUM.Caption + ' nolu çekin ' + txtKASAKOD.Text + ' e tediyesi';
          {Lite
          DataMod.CreateQuery(qry_temp,nil,False,DataMod.dbaMain);
          with qry_temp do
          begin
            Active := false;
            SQL.Clear;
            SQL.Add('SELECT MUHASKOD AS KASA_MUHASKOD FROM KASA WHERE KASA.KASA_KOD=:PRM_KASA_KOD');
            ParamByName('PRM_KASA_KOD').AsString := txtKASAKOD.Text;
            Active := True;
          end;
          ///////////////////////////////////
          txtYEVMIYEACK.Text := lblCEKNUM.Caption + ' nolu çekin ' + qry_temp.FieldByName('KASA_MUHASKOD').AsString + ' a Tediye';
          }
        end;
      end;
    SENET:
      case prv_CEKSENTIP of
      1://tahsil
        begin
          txtCARIHARACK.Text := txtNO.Text + ' nolu senetin ' + txtKASAKOD.Text + ' e tahsili';
          {Lite
          DataMod.CreateQuery(qry_temp,nil,False,DataMod.dbaMain);
          with qry_temp do
          begin
            Active := false;
            SQL.Clear;
            SQL.Add('SELECT MUHASKOD AS KASA_MUHASKOD FROM KASA WHERE KASA.KASA_KOD=:PRM_KASA_KOD');
            ParamByName('PRM_KASA_KOD').AsString := txtKASAKOD.Text;
            Active := True;
          end;
          ///////////////////////////////////
          txtYEVMIYEACK.Text := txtNO.Text + ' nolu senetin ' + qry_temp.FieldByName('KASA_MUHASKOD').AsString + ' a Tahsili';
          }
        end;
      2://tediye
        begin
          txtCARIHARACK.Text := txtNO.Text + ' nolu senetin ' + txtKASAKOD.Text + ' e tediyesi';
          {Lite
          DataMod.CreateQuery(qry_temp,nil,False,DataMod.dbaMain);
          with qry_temp do
          begin
            Active := false;
            SQL.Clear;
            SQL.Add('SELECT MUHASKOD AS KASA_MUHASKOD FROM KASA WHERE KASA.KASA_KOD=:PRM_KASA_KOD');
            ParamByName('PRM_KASA_KOD').AsString := txtKASAKOD.Text;
            Active := True;
          end;
          ///////////////////////////////////
          txtYEVMIYEACK.Text := txtNO.Text + ' nolu senetin ' + qry_temp.FieldByName('KASA_MUHASKOD').AsString + ' a Tediye';
          }
        end;
      end;
  end;//end case CEKSEN of

  end;

{
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString +' dan ' + qryKASAHAR.FieldByName('KARSIKOD').AsString + ' a Tediye ';
      ///////////////////////////////////
      DataMod.CreateQuery(qry_temp,nil,False,True);
      //qry_temp := TIB_Query.Create(Self);
      with qry_temp do
      begin
        //IB_Connection := DataMod.dbaMain;
        Active := false;
        SQL.Clear;
        SQL.Add('SELECT KASA.MUHASKOD AS KASA_MUHASKOD, CARI.MUHASKOD AS CARI_MUHASKOD FROM CARI,KASA WHERE KASA.KASA_KOD=:PRM_KASA_KOD AND CARI.CARI_KOD=:PRM_CARI_KOD');
        ParamByName('PRM_KASA_KOD').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString;
        ParamByName('PRM_CARI_KOD').AsString := qryKASAHAR.FieldByName('KARSIKOD').AsString;
        Active := True;
      end;
      ///////////////////////////////////
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qry_temp.FieldByName('KASA_MUHASKOD').AsString +' dan ' + qry_temp.FieldByName('CARI_MUHASKOD').AsString + ' a Tediye ';
      DataMod.ReleaseQuery(qry_temp);
      //qry_temp.Close;
      //qry_temp.Free;
      ///////////////////////////////////
    end;
  end;
}
end;

procedure TFRMCEKSEN_KASA.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TFRMCEKSEN_KASA.txtPROJE_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TFRMCEKSEN_KASA.txtPLASIYER_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TFRMCEKSEN_KASA.txt_PLASIYERKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txt_PLASIYERKODButtonClick(Self);
end;

procedure TFRMCEKSEN_KASA.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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






procedure TFRMCEKSEN_KASA.txt_PROJEKODExit(Sender: TObject);
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


procedure TFRMCEKSEN_KASA.txt_PROJEKODKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F4 then btnProjeKodClick(Self);
end;

procedure TFRMCEKSEN_KASA.txt_PLASIYERKODButtonClick(Sender: TObject);
var
  PLASIYER_KOD, PLASIYER_AD :String;
begin
  if DataMod.LS_Plasiyer(PLASIYER_KOD, PLASIYER_AD,1) then
  begin
    txtPROJEKOD.Text := PLASIYER_KOD;
    lblPlasiyerAd.Caption := PLASIYER_AD;
  end;
end;


procedure TFRMCEKSEN_KASA.btnAraClick(Sender: TObject);
var
  temp_id,temp_sid : integer;
  islem : byte;
begin
  if frmCekSenHarSDGL.Form_Open(False,
                                CEKSEN //CEK MÝ SENET MÝ
                                ,prv_CEKSENTIP//1-MÜÞTERÝ 2-BORÇ
                                ,prv_ISLEM //ISLEM=3 CÝRO ISLEM=4 BANKADAN GELEN TAHSIL DEKONTU
                                ,FALSE//TERCÝHLÝ
                                ,0//BELGE_ID
                                ,0//BELGE_SID
                                ,islem
                                ,temp_id
                                ,temp_sid) then
  begin
    DataSet_Open(temp_id,temp_sid);
    txtdisable(false);
  end;
end;

procedure TFRMCEKSEN_KASA.buton_ayarla(durum:byte);
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
  4://ara butonundan sonra çaðrýlacak
    begin
      btnCIRO.Enabled := True;
      btnIPTAL.Enabled := True;
      btnYeni.Enabled := False;
      btnAra.Enabled := False;
      btnCIKIS.enabled:=False;
      btnSIL.Enabled := True;
   end;
  end;//end case
end;

procedure TFRMCEKSEN_KASA.txtDOVKURExit(Sender: TObject);
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

procedure TFRMCEKSEN_KASA.btnKASAKODClick(Sender: TObject);
var
  KASA_KOD,KASA_AD,DOVKOD:String;
begin
  if DataMod.LS_KASA(KASA_KOD,KASA_AD,DOVKOD) then
  begin
    txtKASAKOD.Text := KASA_KOD;
    lblKASA_AD.Caption := KASA_AD;
    TutarFarkHesapla;
    txtKASAKOD.SetFocus;
  end;
end;

procedure TFRMCEKSEN_KASA.btnProjeKodClick(Sender: TObject);
var
  PROJEKOD,PROJEAD:String;
begin
  if DataMod.LS_Proje(PROJEKOD,PROJEAD,1) Then
  begin
    txtPROJEKOD.Text := PROJEKOD;
    lblPrjAd.Caption := PROJEAD;
  end;
end;

procedure TFRMCEKSEN_KASA.btnPlasiyerKodClick(Sender: TObject);
var
  PLASIYERKOD, PLASIYERAD :String;
begin
  if DataMod.LS_Plasiyer(PLASIYERKOD, PLASIYERAD,1) then
  begin
    txtPLASIYERKOD.Text := PLASIYERKOD;
    lblPlasiyerAd.Caption := PLASIYERAD;
  end;
end;

procedure TFRMCEKSEN_KASA.txtKASAKODKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then btnKASAKODClick(Self);
end;

procedure TFRMCEKSEN_KASA.txtKASAKODKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TFRMCEKSEN_KASA.txtPROJEKODExit(Sender: TObject);
var PROJEAD:String;
begin
  if Trim(txtPROJEKOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',txtPROJEKOD.Text,PROJEAD) then
    begin
      lblPrjAd.Caption := PROJEAD;
      (Sender as TEdit).Color := clWindow;
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

procedure TFRMCEKSEN_KASA.txtPROJEKODKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then btnProjeKodClick(Self);
end;

procedure TFRMCEKSEN_KASA.txtPROJEKODKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TFRMCEKSEN_KASA.txtPLASIYERKODKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnPlasiyerKodClick(Self);
end;

procedure TFRMCEKSEN_KASA.txtPLASIYERKODExit(Sender: TObject);
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

procedure TFRMCEKSEN_KASA.txtPLASIYERKODKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TFRMCEKSEN_KASA.txtDOVKURChange(Sender: TObject);
begin
  txtTutarVPB.Value := tblCEKSEN.TUTAR * txtDOVKUR.Value;
  txtKURFARK.Value := txtTutarVPB.Value - tblCEKSEN.TUTAR_VPB;
end;

procedure TFRMCEKSEN_KASA.dtpDOVBAZTARCloseUp(Sender: TObject);
var
  Kur_Deger : Currency;
begin
  Kur_Deger := DataMod.Get_Doviz_Kur(tblCEKSEN.DOVKOD,dtpDovBazTar.Date,glb_SATISKUR,0);
  if Kur_Deger <> 0 then txtDOVKUR.Value := Kur_Deger else txtDOVKUR.Value := 1;
end;

procedure TFRMCEKSEN_KASA.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TFRMCEKSEN_KASA.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TFRMCEKSEN_KASA.txtKOD1Exit(Sender: TObject);
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

procedure TFRMCEKSEN_KASA.txtKOD2Exit(Sender: TObject);
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

procedure TFRMCEKSEN_KASA.txtKOD3Exit(Sender: TObject);
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

procedure TFRMCEKSEN_KASA.txtKOD4Exit(Sender: TObject);
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

procedure TFRMCEKSEN_KASA.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;


procedure TFRMCEKSEN_KASA.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;


procedure TFRMCEKSEN_KASA.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TFRMCEKSEN_KASA.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TFRMCEKSEN_KASA.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TFRMCEKSEN_KASA.txtISLEMMERKEZIKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button1Click(Self);
end;

procedure TFRMCEKSEN_KASA.txtKOD1KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button2Click(Self);
end;

procedure TFRMCEKSEN_KASA.txtKOD2KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button3Click(Self);
end;

procedure TFRMCEKSEN_KASA.txtKOD3KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button4Click(Self);
end;

procedure TFRMCEKSEN_KASA.txtKOD4KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button5Click(Self);
end;

function TfrmCEKSEN_KASA.Form_Before_Delete: Boolean;
var
  KASA_DOVKOD:string;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if not DataMod.FN_KOD2AD('KASA','KASA_KOD','DOVKOD',Trim(txtKASAKOD.Text),KASA_DOVKOD) then
  begin
    Application.MessageBox('Belirtilen Kasaya ait Para Birimi bilgisi alýnamadý','Dikkat',MB_ICONHAND);
    Exit;
  end;

  case CEKSEN of
  1://cek start
    begin
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir çek seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;

      if (Trim(txtKASAKOD.Text)='') then
      begin
        Application.MessageBox('Lütfen listeden bir KASA seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;

      if (txtDOVKUR.Value = 0) then
      begin
        Application.MessageBox('Döviz kuru sýfýr olamaz.','Dikkat',MB_ICONWARNING);
        exit;
      end;
    end;//cek stop
  2:
    begin//senet start
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir senet seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;

      if (Trim(txtKASAKOD.Text)='') then
      begin
        Application.MessageBox('Lütfen listeden bir KASA seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;


      if (txtDOVKUR.Value = 0) then
      begin
        Application.MessageBox('Döviz kuru sýfýr olamaz.','Dikkat',MB_ICONWARNING);
        exit;
      end;
    end;//senet stop
  end;//end case CEKSEN of
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  Result := True;
end;

function TfrmCEKSEN_KASA.Form_Before_Post: Boolean;
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
        exit;
      end;

      if (Trim(txtKASAKOD.Text)='') then
      begin
        Application.MessageBox('Lütfen listeden bir KASA seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;

      if (txtDOVKUR.Value <= 0) then
      begin
        Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
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
        exit;
      end;

      if (Trim(txtKASAKOD.Text)='') then
      begin
        Application.MessageBox('Lütfen listeden bir KASA seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;

      if (txtDOVKUR.Value <= 0) then
      begin
        Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
        exit;
      end;

      if (txtTUTARVPB.Value <= 0) then
      begin
        Application.MessageBox('Tutar vpb sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
        exit;
      end;
    end;//senet stop
  end;//end case CEKSEN of


  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  if not DataMod.IsDateInTerm(dtpISLEMTAR.Date, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(dtpDOVBAZTAR.Date, 'Döviz Baz Tarihi') then Exit;
  Result := True;
end;

procedure TfrmCEKSEN_KASA.Form_Delete;
var
  KASA_DOVKOD:string;
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
    tblCEKSENHAR.CARI_KOD := tblCEKSEN.CARI_KOD;
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

    if not DataMod.FN_KOD2AD('KASA','KASA_KOD','DOVKOD',Trim(txtKASAKOD.Text),KASA_DOVKOD) then
    begin
      trnCekSenHar.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      Application.MessageBox('Belirtilen Kasaya ait Para Birimi bilgisi alýnamadý','Dikkat',MB_ICONHAND);
      exit;
    end;
//****************************************************************************//
    if not dmCEKSENHAR.CEKSENHAR_AUD(trnCekSenHar,tblCEKSENHAR,prv_BelgeTur,KASA_DOVKOD,1) then
    begin
      trnCekSenHar.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,KASAHAR,CEK,SENET,',
                                             prv_BelgeTur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,2,'');
//****************************************************************************//
    trnCekSenHar.Commit;
  except
    trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
    Raise;
  end;
  EmptyFields;
  txtdisable(false);
  buton_ayarla(3);
end;

procedure TfrmCEKSEN_KASA.Form_Post;
var
  KASA_DOVKOD:string;
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
    tblCEKSENHAR.CARI_KOD := tblCEKSEN.CARI_KOD;// Trim(txtCARIKOD.Text);
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
    tblCEKSENHAR.KASA_KOD := Trim(txtKASAKOD.Text);
//****************************************************************************//
    if not DataMod.FN_KOD2AD('KASA','KASA_KOD','DOVKOD',Trim(txtKASAKOD.Text),KASA_DOVKOD) then
    begin
      trnCekSenHar.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      Application.MessageBox('Belirtilen Kasaya ait Para Birimi bilgisi alýnamadý','Dikkat',MB_ICONHAND);
      exit;
    end;
//****************************************************************************//
    if not dmCEKSENHAR.CEKSENHAR_AUD(trnCekSenHar,tblCEKSENHAR,prv_BelgeTur,KASA_DOVKOD,0) then
    begin
      trnCekSenHar.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    prnCEKSENHARID := tblCEKSENHAR.CEKSENHAR_ID;
    prnCEKSENHARSID := tblCEKSENHAR.CEKSENHAR_SID;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,KASAHAR,CEK,SENET,',
                                             prv_BelgeTur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,1,'');
//****************************************************************************//
    trnCekSenHar.Commit;
//****************************************************************************//
    if rgYAZICI.Visible = True then
    begin
      case CEKSEN of
      CEK :
        begin
          case prv_BelgeTur of
          BT_KASA_CEKSEN_TAH:if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(331)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,331,33,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

          Yazici.KASAYACEKTAHSILI(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
          BT_KASA_CEKSEN_TED:if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(341)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,341,34,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

          Yazici.KASADANCEKTEDIYESI(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
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
    raise;
  end;
  EmptyFields;
  txtdisable(true);
  buton_ayarla(2);
end;

procedure TfrmCEKSEN_KASA.txtdisable(tip: Boolean);
begin
  if tip then
  begin
    txtKASAKOD.Enabled := False;
    btnKASAKOD.Enabled := False;
  end
  else
  begin
    txtKASAKOD.Enabled := True;
    btnKASAKOD.Enabled := True;
  end;
end;

procedure TfrmCEKSEN_KASA.btnCiktiClick(Sender: TObject);
begin
  if prnCEKSENHARID<=0 then Exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.Visible = True then
  begin
    case CEKSEN of
    CEK :
      begin
        case prv_BelgeTur of
        BT_KASA_CEKSEN_TAH:if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(331)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,331,33,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

        Yazici.KASAYACEKTAHSILI(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
        BT_KASA_CEKSEN_TED:if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(341)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,341,34,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

        Yazici.KASADANCEKTEDIYESI(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
        end;
      end;
    end;
  end;
end;

procedure TfrmCEKSEN_KASA.txtKASAKODEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_KASA.dtpISLEMTAREnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_KASA.dtpISLEMTARExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmCEKSEN_KASA.txtDOVKUREnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_KASA.txtCARIHARACKExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

procedure TfrmCEKSEN_KASA.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(Self); 
end;

end.
