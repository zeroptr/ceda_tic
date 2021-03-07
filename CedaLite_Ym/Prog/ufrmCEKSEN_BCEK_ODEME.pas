unit ufrmCEKSEN_BCEK_ODEME;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, IB_Controls, ComCtrls, Buttons, ExtCtrls,GenTypes,
  IB_Components;

type
  TfrmCEKSEN_BCEK_ODEME = class(TForm)
    lblNO: TLabel;
    txtNO: TEdit;
    btnCEKSENLIST: TButton;
    lblSUBEKODL: TLabel;
    lblSUBEKOD: TLabel;
    lblCARIKOD: TLabel;
    lblCARIAD: TLabel;
    lblTANZIMTAR: TLabel;
    lblSAHIPL: TLabel;
    lblTANZIMTARL: TLabel;
    lblCEKSAHIBI: TLabel;
    lblDOVKUR: TLabel;
    lblTUTAR: TLabel;
    lblDOVKOD: TLabel;
    lblTUTARBIL: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnCIRO: TButton;
    btnIPTAL: TButton;
    btnAra: TBitBtn;
    btnSil: TButton;
    txtPROJEKOD: TEdit;
    lblPrjAd: TLabel;
    Label2: TLabel;
    txtPLASIYERKOD: TEdit;
    btnProjeKod: TButton;
    btnPlasiyerKod: TButton;
    lblPlasiyerAd: TLabel;
    Label4: TLabel;
    dtpIslemTar: TDateTimePicker;
    dtpDovBazTar: TDateTimePicker;
    txtDOVKUR: TIB_Currency;
    txtTutarVPB: TIB_Currency;
    txtKURFARK: TIB_Currency;
    Label1: TLabel;
    Label3: TLabel;
    lblTUTAR_VPB: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblCiroCariKod: TLabel;
    lblBANKAAD: TLabel;
    lblBANKAKOD: TLabel;
    Label8: TLabel;
    trnCekSenHar: TIB_Transaction;
    btnCIKIS: TBitBtn;
    Label7: TLabel;
    Label12: TLabel;
    txtCARIHARACK: TEdit;
    txtYEVMIYEACK: TEdit;
    lblCEKNUML: TLabel;
    lblCEKNUM: TLabel;
    rgYAZICI: TRadioGroup;
    btnCikti: TButton;
    Label18: TLabel;
    lblBelgeFisNo: TLabel;
    grpRapKod: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
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
    procedure btnCEKSENLISTClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnProjeKodClick(Sender: TObject);
    procedure txtPROJEKODExit(Sender: TObject);
    procedure txtPROJEKODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPROJEKODKeyPress(Sender: TObject; var Key: Char);
    procedure btnPlasiyerKodClick(Sender: TObject);
    procedure txtPLASIYERKODExit(Sender: TObject);
    procedure txtPLASIYERKODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPLASIYERKODKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;                 Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnCIKISClick(Sender: TObject);
    procedure dtpDovBazTarCloseUp(Sender: TObject);
    procedure txtPROJEKODEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpIslemTarEnter(Sender: TObject);
    procedure dtpIslemTarExit(Sender: TObject);
    procedure txtDOVKUREnter(Sender: TObject);
    procedure txtDOVKURExit(Sender: TObject);
    procedure btnCIROClick(Sender: TObject);
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
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKOD1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKOD2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKOD3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKOD4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtDOVKURChange(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure txtCARIHARACKEnter(Sender: TObject);
    procedure txtCARIHARACKExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;CEKSENHAR_ID,CEKSENHAR_SID:Integer);
    procedure DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID:Integer);
    procedure GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
    procedure Buton_Ayarla(durum:byte);
    procedure TutarFarkHesapla;
    procedure EmptyFields;
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
////////////////////////////////////////////////////////////////////////////////
  private
    tblCEKSEN:TBL_CEKSEN;
    tblCEKSENHAR : TBL_CEKSENHAR;
    prv_BelgeTur:Integer;
    prv_ISLEM : Byte;//CEKSENHAR.ISLEM
    prv_CanUpdate,prv_CanDelete:Boolean;
    { Private declarations }
  public
    { Public declarations }
    prnCEKSENHARID,prnCEKSENHARSID:Integer;
  end;
  const cns_bcek_odeme = 5;
var
  frmCEKSEN_BCEK_ODEME: TfrmCEKSEN_BCEK_ODEME;

implementation
uses unDataMod,main,unFunc, ufrmISN_ERRORS,StdConvs,ufrmCekSenHarSDGL,ufrmCekSenSDLG, unCEKSENHAR,unYazici,
  unLogger, UDm_Fast_Report;
{$R *.dfm}


procedure TfrmCEKSEN_BCEK_ODEME.Form_Open(Menu:Boolean;CEKSENHAR_ID, CEKSENHAR_SID: Integer);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_bcek_odeme,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm( Application, 'frmCEKSEN_BCEK_ODEME') then
    begin
      if ((CEKSENHAR_ID = 0) and (CEKSENHAR_SID = 0) and (local_can_update = False)) then
      begin
        Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
        exit;
      end;
      Application.CreateForm(TfrmCEKSEN_BCEK_ODEME,frmCEKSEN_BCEK_ODEME);
      with frmCEKSEN_BCEK_ODEME do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
        prv_ISLEM := 17;//17- Bankadan Borç Çeki Ödeme Dekontu
        prv_BelgeTur := BT_BORC_CEK_ODE;//BT_BORC_CEK_ODE = 29;
        //BORÇ ÇEKÝ ÖDEME DEKONTU BCEK ODEME CEKSENHAR
        DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
      end;
    end;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.DataSet_Open(CEKSENHAR_ID, CEKSENHAR_SID: Integer);
var
  PROJE_AD,PLASIYER_AD : String;
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
                                    ,Self.Label13
                                    ,Self.Label14
                                    ,Self.Label15
                                    ,Self.Label16
                                    ,Self.Label17);
  if not glb_PROJE_UYG then
  begin
    txtPROJEKOD.Visible := false;
    btnProjeKod.Visible := false;
    label1.Visible := false;
    label2.Visible := false;
    lblPrjAd.Visible := false;
  end;

  if not glb_PLASIYER_UYG then
  begin
    txtPLASIYERKOD.Visible := false;
    btnPlasiyerKod.Visible := false;
    label3.Visible := false;
    label4.Visible := false;
    lblPlasiyerAd.Visible := false;
  end;

  if (CEKSENHAR_ID <> 0)  and (CEKSENHAR_SID <> 0) then
  begin
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    tblCEKSENHAR.CEKSENHAR_ID := CEKSENHAR_ID;
    tblCEKSENHAR.CEKSENHAR_SID := CEKSENHAR_SID;

    prnCEKSENHARID := tblCEKSENHAR.CEKSENHAR_ID;
    prnCEKSENHARSID := tblCEKSENHAR.CEKSENHAR_SID;
    if dmCEKSENHAR.GET_CEKSENHAR(tblCEKSENHAR,False) then
    begin
      //Gösterim Gereçlerine bilgiler aktarýlýyor.
      GET_BELGE_BILGI(tblCEKSENHAR.CEKSEN_ID,tblCEKSENHAR.CEKSEN_SID,False);
      with tblCEKSENHAR do
      begin
        lblBelgeFisNo.Caption := inttostr(CEKSENHAR_ID);
        dtpIslemTar.Date := ISLEM_TAR;
        dtpDovBazTar.Date := DOV_BAZ_TAR;

        txtISLEMMERKEZI.Text := MASRAF_MERK;
        txtKOD1.Text := KOD1;
        txtKOD2.Text := KOD2;
        txtKOD3.Text := KOD3;
        txtKOD4.Text := KOD4;

        txtPROJEKOD.Text := PROJE_KOD;
        txtPLASIYERKOD.Text := PLASIYER_KOD;
        txtDOVKUR.Value := DOVKUR;
        txtTutarVPB.Value := TUTAR_VPB;
        txtKURFARK.Value := KUR_FARKI;
        txtCARIHARACK.Text := CARIHAR_ACK;
        txtYEVMIYEACK.text := YEVMIYE_ACK;

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
    //btnSIL.Enabled:=True;
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


procedure TfrmCEKSEN_BCEK_ODEME.GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
var
  CARI_AD : String;
begin
  tblCEKSEN.CEKSEN := CEK;
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

    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',tblCEKSEN.BANKA_KOD,CARI_AD) then
    begin
      lblBANKAAD.Caption := CARI_AD;
      lblBANKAKOD.Caption := tblCEKSEN.BANKA_KOD;
    end;

    lblCARIKOD.Caption := tblCEKSEN.CARI_KOD;
    txtNO.Text := IntToStr(tblCEKSEN.CEKSEN_ID);

    if YENI_KAYIT then
    begin
      txtISLEMMERKEZI.Text := tblCEKSEN.MASRAF_MERK;
      txtKOD1.Text := tblCEKSEN.KOD1;
      txtKOD2.Text := tblCEKSEN.KOD2;
      txtKOD3.Text := tblCEKSEN.KOD3;
      txtKOD4.Text := tblCEKSEN.KOD4;
      dtpDovBazTarCloseUp(self);
      txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin '+ lblBANKAKOD.Caption  +' dan ödenmesi';
      txtYEVMIYEACK.Text := tblCEKSEN.CEK_NUM+' numaralý çekin '+ lblBANKAKOD.Caption  +' dan ödenmesi';
    end;
    lblCEKNUM.Caption := tblCEKSEN.CEK_NUM;
    lblTANZIMTAR.Caption := DateToStr(tblCEKSEN.TANZIMTAR);
    lblCEKSAHIBI.Caption := tblCEKSEN.BELGE_SAHIBI;
    lblDOVKOD.Caption := tblCEKSEN.DOVKOD;
    lblDOVKUR.Caption := FormatCurr(glb_VPB_FIELD_PF,tblCEKSEN.DOVKUR);
    lblTUTAR.Caption := FormatCurr(glb_DOV_FIELD_PF,tblCEKSEN.TUTAR);
    lblTUTAR_VPB.Caption := FormatCurr(glb_VPB_FIELD_PF,tblCEKSEN.TUTAR_VPB);
  end
  else
  begin
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
    lblBelgeFisNo.Caption := '';
    txtCARIHARACK.Clear;
    txtYEVMIYEACK.Clear;
    txtISLEMMERKEZI.Text := '';
    txtKOD1.Text := '';
    txtKOD2.Text := '';
    txtKOD3.Text := '';
    txtKOD4.Text := '';
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.Buton_Ayarla(durum:byte);
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
      btnPlasiyerKod.Enabled := true;
      btnProjeKod.Enabled := true;
   end;
  2://kaydete bastýktan sonra çaðrýlacak
    begin
      btnCIRO.Enabled := False;
      btnIPTAL.Enabled := False;
      btnYeni.Enabled := True;
      btnAra.Enabled := True;
      btnCIKIS.enabled:=True;
      btnSIL.Enabled := False;
      btnPlasiyerKod.Enabled := false;
      btnProjeKod.Enabled := false;
    end;
  3://iptale bastýktan sonra çaðrýlacak
    begin
      btnCiro.Enabled := False;
      btnIptal.Enabled := False;
      btnYeni.Enabled := True;
      btnAra.Enabled := True;
      btnCIKIS.enabled:=True;
      btnSIL.Enabled := False;
      btnPlasiyerKod.Enabled := false;
      btnProjeKod.Enabled := false;
    end;
  end;//case durum of
end;

procedure TfrmCEKSEN_BCEK_ODEME.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TfrmCEKSEN_BCEK_ODEME.TutarFarkHesapla;
var
  Temp,Kur : Currency;
begin
  Kur := DataMod.Get_Doviz_Kur(tblCEKSEN.DOVKOD,dtpDovBazTar.Date,glb_SATISKUR,0);
  if Kur <> 0 then   txtDOVKUR.Value:= Kur else txtDOVKUR.Value:= 1;
  ////////////////////////////////////////////////////////////////////////////////
  if tblCEKSEN.TUTAR = txtTutarVPB.Value then
  begin
    txtKURFARK.Value := 0;
  end
  else
  begin
    Temp := tblCEKSEN.TUTAR * Kur;
    txtKURFARK.Value :=  Temp - tblCEKSEN.TUTAR_VPB;
  end;
////////////////////////////////////////////////////////////////////////////////
  txtTutarVPB.Value := tblCEKSEN.TUTAR * txtDOVKUR.Value;
end;


procedure TfrmCEKSEN_BCEK_ODEME.btnCEKSENLISTClick(Sender: TObject);
var
  BELGE_ID,BELGE_SID:Integer;
begin
  if frmCekSenSDLG.Form_Open(False,1,BELGE_ID,BELGE_SID,2,True,1,2) Then
  begin
    GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
  end;
end;


procedure TfrmCEKSEN_BCEK_ODEME.btnAraClick(Sender: TObject);
var
  temp_id,temp_sid : integer;
  islem : byte;
begin
  if frmCekSenHarSDGL.Form_Open(False,
                                CEK//CEK MÝ SENET MÝ
                                ,2//1-MÜÞTERÝ 2-BORÇ
                                ,prv_ISLEM //17- Bankadan Borç Çeki Ödeme Dekontu
                                ,FALSE//TERCÝHLÝ
                                ,0//BELGE_ID
                                ,0//BELGE_SID
                                ,islem
                                ,temp_id
                                ,temp_sid) then
  begin
    DataSet_Open(temp_id,temp_sid);
    btnSil.Enabled := True;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.btnProjeKodClick(Sender: TObject);
var
  PROJE_KOD,PROJE_AD:String;
begin
  if DataMod.LS_Proje(PROJE_KOD,PROJE_AD,1) Then
  begin
    txtPROJEKOD.Text := PROJE_KOD;
    lblPrjAd.Caption := PROJE_AD;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtPROJEKODExit(Sender: TObject);
var
  PROJE_AD:String;
begin
  if Trim(txtPROJEKOD.Text) <> '' then
  begin
    if  DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',txtPROJEKOD.Text,PROJE_AD) then
    begin
      lblPrjAd.Caption := PROJE_AD;
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtPROJEKOD.SetFocus;
    end;
  end
  else
  begin
    txtPROJEKOD.Clear;
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtPROJEKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then btnProjeKodClick(Self);
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtPROJEKODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_BCEK_ODEME.btnPlasiyerKodClick(Sender: TObject);
var
  PLASIYER_KOD, PLASIYER_AD :String;
begin
  if DataMod.LS_Plasiyer(PLASIYER_KOD, PLASIYER_AD,1) then
  begin
    txtPLASIYERKOD.Text := PLASIYER_KOD;
    lblPlasiyerAd.Caption := PLASIYER_AD;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtPLASIYERKODExit(Sender: TObject);
var
  PLASIYER_AD:String;
begin
  if Trim(txtPLASIYERKOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',txtPLASIYERKOD.Text,PLASIYER_AD) then
    begin
      lblPlasiyerAd.Caption := PLASIYER_AD;
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtPLASIYERKOD.SetFocus;
    end;
  end
  else
  begin
    txtPROJEKOD.Clear;
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtPLASIYERKODKeyDown(Sender: TObject;      var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F4 then btnPlasiyerKodClick(Self);
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtPLASIYERKODKeyPress(Sender: TObject;     var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_BCEK_ODEME.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    case Key of
    83: //s kaydet
      begin
         //if btnCIRO.Enabled Then btnCIROClick(Self);
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
    45: //ins kaydet
      begin
        if btnYeni.Enabled then btnYeniClick(Self);
      end;
    end;//end case
  end; ///end if Shift = [] then
end;

procedure TfrmCEKSEN_BCEK_ODEME.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCEKSEN_BCEK_ODEME.btnIPTALClick(Sender: TObject);
begin
  if Application.MessageBox('Ýþlemi iptal etmek istiyor musunuz?','Dikkat',MB_YESNO+MB_ICONQUESTION) = 6 then
  begin
    EmptyFields;
//****************************************************************************//
    if trnCekSenHar.InTransaction then
       trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
    prnCEKSENHARID := 0;
    prnCEKSENHARSID := 0;
    buton_ayarla(3);
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.EmptyFields;
begin
  txtNO.clear;
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
  lblBANKAAD.Caption := '';
  lblBANKAKOD.Caption := '';
  lblPrjAd.Caption := '';
  lblPlasiyerAd.Caption := '';
  lblBelgeFisNo.Caption := '';
  txtPROJEKOD.Clear;
  txtPLASIYERKOD.Clear;
  txtCARIHARACK.Clear;
  txtYEVMIYEACK.Clear;
  txtDOVKUR.Value := 0;
  txtKURFARK.Clear;
  txtTutarVPB.Clear;

  txtISLEMMERKEZI.Clear;
  txtKOD1.Clear;
  txtKOD2.Clear;
  txtKOD3.Clear;
  txtKOD4.Clear;

  dtpDovBazTar.Date := DataMod.GET_SERVER_DATE;
  dtpIslemTar.Date := dtpDovBazTar.Date;

  btnCEKSENLIST.Enabled := False;
  btnIPTAL.Enabled := False;
  btnCIRO.Enabled := False;
  btnYeni.Enabled := True;
  btnProjeKod.Enabled := false;
  btnPlasiyerKod.Enabled := false;
end;

procedure TfrmCEKSEN_BCEK_ODEME.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmCEKSEN_BCEK_ODEME.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0);
end;

procedure TfrmCEKSEN_BCEK_ODEME.btnCIKISClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCEKSEN_BCEK_ODEME.dtpDovBazTarCloseUp(Sender: TObject);
var
  Kur_Deger : Currency;
begin
  if btnYeni.Enabled then exit;
  Kur_Deger := DataMod.Get_Doviz_Kur(tblCEKSEN.DOVKOD,dtpDovBazTar.Date,glb_SATISKUR,0);
  if Kur_Deger <> 0 then txtDOVKUR.Value := Kur_Deger else txtDOVKUR.Value := 1;
  txtTutarVPB.Value := txtDOVKUR.Value * tblCEKSEN.TUTAR;
  txtKURFARK.Value := (txtTutarVPB.Value - tblCEKSEN.TUTAR_VPB);
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtPROJEKODEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_BCEK_ODEME.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmCEKSEN_BCEK_ODEME);
end;

procedure TfrmCEKSEN_BCEK_ODEME.dtpIslemTarEnter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;


procedure TfrmCEKSEN_BCEK_ODEME.dtpIslemTarExit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtDOVKUREnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtDOVKURExit(Sender: TObject);
begin
  if (txtDOVKUR.value <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada küçük olamaz.Lütfen kontrol ediniz.');
    txtDOVKUR.Value := 1;
    txtDOVKUR.SetFocus;
    exit;
  end;
  txtDOVKUR.Color := clWindow;
end;

procedure TfrmCEKSEN_BCEK_ODEME.btnCIROClick(Sender: TObject);
begin
  Form_Post;
end;


procedure TfrmCEKSEN_BCEK_ODEME.Button1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.Button2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.Button3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.Button5Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtISLEMMERKEZIExit(Sender: TObject);
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

procedure TfrmCEKSEN_BCEK_ODEME.txtKOD1Exit(Sender: TObject);
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

procedure TfrmCEKSEN_BCEK_ODEME.txtKOD2Exit(Sender: TObject);
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

procedure TfrmCEKSEN_BCEK_ODEME.txtKOD3Exit(Sender: TObject);
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

procedure TfrmCEKSEN_BCEK_ODEME.txtKOD4Exit(Sender: TObject);
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

procedure TfrmCEKSEN_BCEK_ODEME.txtISLEMMERKEZIKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button1Click(Self);
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtKOD1KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button2Click(Self);
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtKOD2KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button3Click(Self);
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtKOD3KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button4Click(Self);
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtKOD4KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then Button5Click(Self);
end;

function TfrmCEKSEN_BCEK_ODEME.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if (Length(Trim(txtNO.Text)) = 0) then
  begin
    Application.MessageBox('Lütfen listeden bir çek seçiniz.','Dikkat',MB_ICONQUESTION);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  Result := True;
end;

function TfrmCEKSEN_BCEK_ODEME.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if (Length(Trim(txtNO.Text)) = 0) then
  begin
    Application.MessageBox('Lütfen listeden bir çek seçiniz.','Dikkat',MB_ICONQUESTION);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  if not DataMod.IsDateInTerm(dtpIslemTar.Date, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(dtpDovBazTar.Date, 'Döviz Baz Tarihi') then Exit;
  Result := True;
end;

procedure TfrmCEKSEN_BCEK_ODEME.Form_Delete;
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
    tblCEKSENHAR.DOV_BAZ_TAR := dtpDovBazTar.Date;
    tblCEKSENHAR.CEKSEN := CEK;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := prv_ISLEM;
    tblCEKSENHAR.DOVKUR := txtDOVKUR.Value;
    tblCEKSENHAR.TUTAR_VPB := txtTutarVPB.Value;
    tblCEKSENHAR.KUR_FARKI := txtKURFARK.Value;
    tblCEKSENHAR.CARI_KOD := Trim(lblBANKAKOD.Caption);
    tblCEKSENHAR.PLASIYER_KOD := Trim(txtPLASIYERKOD.Text);
    tblCEKSENHAR.PROJE_KOD := Trim(txtPROJEKOD.Text);
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
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,',
                                             prv_BelgeTur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,2,'');
//****************************************************************************//
    trnCekSenHar.Commit;
//****************************************************************************//
  except
    trnCekSenHar.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  EmptyFields;
  buton_ayarla(3);
end;

procedure TfrmCEKSEN_BCEK_ODEME.Form_Post;
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
    tblCEKSENHAR.ISLEM_TAR := dtpIslemTar.Date;
    tblCEKSENHAR.DOV_BAZ_TAR := dtpDovBazTar.Date;
    tblCEKSENHAR.CEKSEN := CEK;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := prv_ISLEM;
    tblCEKSENHAR.DOVKUR := txtDOVKUR.Value;
    tblCEKSENHAR.TUTAR_VPB := txtTutarVPB.Value;
    tblCEKSENHAR.KUR_FARKI := txtKURFARK.Value;
    tblCEKSENHAR.CARI_KOD := Trim(lblBANKAKOD.Caption);//CARÝ KOD BANKA KODU
    tblCEKSENHAR.PLASIYER_KOD := Trim(txtPLASIYERKOD.Text);
    tblCEKSENHAR.PROJE_KOD := Trim(txtPROJEKOD.Text);
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
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,',
                                             prv_BelgeTur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,1,'');
//****************************************************************************//
    trnCekSenHar.Commit;
//****************************************************************************//
    if rgYAZICI.Visible = True then
    begin
      if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(291)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,291,29,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

      Yazici.BCEKODEME(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
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
  buton_ayarla(2);
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtDOVKURChange(Sender: TObject);
begin
  txtTutarVPB.Value := tblCEKSEN.TUTAR * txtDOVKUR.Value;
  txtKURFARK.Value := txtTutarVPB.Value - tblCEKSEN.TUTAR_VPB;
end;

procedure TfrmCEKSEN_BCEK_ODEME.btnCiktiClick(Sender: TObject);
begin
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.Visible = True then
  begin
    if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(291)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,291,29,1,rgYAZICI.ItemIndex,prnCEKSENHARID,prnCEKSENHARSID,0,'');
  end
  else

    Yazici.BCEKODEME(prnCEKSENHARID,prnCEKSENHARSID,rgYAZICI.ItemIndex);
  end;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtISLEMMERKEZIEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtCARIHARACKEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmCEKSEN_BCEK_ODEME.txtCARIHARACKExit(Sender: TObject);
begin
  (Sender as TEdit).Color := clWindow;
end;

end.





