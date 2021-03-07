unit ufrmCEKSEN_TAHSILVER;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ComCtrls, Mask, IB_Controls, Buttons, ExtCtrls,
  StdCtrls,GenTypes;

type
  TfrmCEKSEN_TAHSILVER = class(TForm)
    lblNO: TLabel;
    lblSUBEKODL: TLabel;
    lblSUBEKOD: TLabel;
    lblCARIKOD: TLabel;
    lblCARIAD: TLabel;
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
    lblCiroCariKod: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtNO: TEdit;
    btnCEKSENLIST: TButton;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnCIRO: TButton;
    btnIPTAL: TButton;
    btnAra: TBitBtn;
    btnSil: TButton;
    btnCariKod: TButton;
    txtCARIKOD: TEdit;
    dtpIslemTar: TDateTimePicker;
    txtCARIHARACK: TEdit;
    trnCekSenHar: TIB_Transaction;
    Label12: TLabel;
    btnCIKIS: TBitBtn;
    lblCEKNUML: TLabel;
    lblCEKNUM: TLabel;
    Label18: TLabel;
    lblBelgeFisNo: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCIKISClick(Sender: TObject);
    Procedure EmptyFields;
    procedure btnCEKSENLISTClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnCIROClick(Sender: TObject);
    procedure txtCARIKODExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txt_CARIKODKeyPress(Sender: TObject; var Key: Char);
    procedure txt_CARIKODKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txt_CARIKODButtonClick(Sender: TObject);
    procedure txt_CARIKODExit(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnCariKodClick(Sender: TObject);
    procedure txtCARIKODKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtCARIKODKeyPress(Sender: TObject; var Key: Char);
    procedure buton_ayarla(durum:byte);
////////////////////////////////////////////////////////////////////////////////
    procedure GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
    procedure Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer; CEK_SEN:Byte);
    procedure DataSet_Open(CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer);
    procedure Form_Post;
    procedure Form_Delete;
    function  Form_Before_Post:Boolean;
    function  Form_Before_Delete:Boolean;
    procedure btnSilClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    tblCEKSEN:TBL_CEKSEN;
    tblCEKSENHAR:TBL_CEKSENHAR;
    CEKSEN: Byte;
    prv_BelgeTur:Integer;
    prv_CanUpdate,prv_CanDelete:Boolean;

    prv_ceksen_id:Integer;
    prv_ceksen_sid:Integer;
    
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_cek_tahsilver = 5;
  const cns_senet_tahsilver = 6;
var
  frmCEKSEN_TAHSILVER: TfrmCEKSEN_TAHSILVER;
  frmEkstra : TfrmCEKSEN_TAHSILVER;
implementation

uses ufrmCariSDLG,unDataMod, ufrmCekSenSDLG, main,unFunc, ufrmISN_ERRORS, ufrmCekSenHarSDGL, unCEKSENHAR,
  unLogger;

{$R *.dfm}

procedure TfrmCEKSEN_TAHSILVER.Form_Open(Menu:Boolean;CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer; CEK_SEN : Byte);
var
  local_can_update,local_can_delete:Boolean;
//   BT_MCEK_TAHSIL_VER  = 21;//MUSTERI CEKI TAHSILE VERME               CEK TAHSIL VER   CEKSENHAR
//   BT_MSEN_TAHSIL_VER  = 22;//MUSTERI SENEDI TAHSILE VERME             SEN TAHSIL VER   CEKSENHAR
begin
  case CEK_SEN of
  CEK://müþteri çeki
    begin
      if not DataMod.Modul_Hak(cns_cek_tahsilver,local_can_update,local_can_delete) then
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
        if MainForm.FindChildFrm( Application, 'frmMusteriCekTahsilVer') = False  Then
        begin
          frmEkstra := TfrmCEKSEN_TAHSILVER.Create(Application);
          with frmEkstra do
          begin
            Name := 'frmMusteriCekTahsilVer';
            Caption := 'Müþteri Çeki Tahsile Verme';
            prv_CanUpdate := local_can_update;
            prv_CanDelete := local_can_delete;
            CEKSEN := CEK_SEN;
            prv_BelgeTur := BT_MCEK_TAHSIL_VER;
            DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
          end;
        end;
      end;
    end;
  SENET://müþteri seneti
    begin
      if not DataMod.Modul_Hak(cns_senet_tahsilver,local_can_update,local_can_delete) then
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
        if MainForm.FindChildFrm( Application, 'frmMusteriSenTahsilVer') = False  Then
        begin
          frmEkstra := TfrmCEKSEN_TAHSILVER.Create(Application);
          with frmEkstra do
          begin
            Name := 'frmMusteriSenTahsilVer';
            Caption := 'Müþteri Senedi Tahsile Verme';
            prv_CanUpdate := local_can_update;
            prv_CanDelete := local_can_delete;
            lblCiroCariKod.Caption := 'Tahsil Edilecek Bankanýn Kodu';
            CEKSEN := CEK_SEN;
            prv_BelgeTur := BT_MSEN_TAHSIL_VER;
            DataSet_Open(CEKSENHAR_ID,CEKSENHAR_SID);
          end;
        end;
      end;
    end;
  end;//end case CEKSEN of
end;

procedure TfrmCEKSEN_TAHSILVER.DataSet_Open(CEKSENHAR_ID:Integer; CEKSENHAR_SID:Integer);
var
 CARI_AD : String;
//CEKSENHAR_ID: çekin veya senetin hareket id si
//CEKSENHAR_SID: çekin veya senetin hareket sid si
begin
     prv_ceksen_id:=0;
     prv_ceksen_sid:=0;
     
  if ((CEKSENHAR_ID = 0) and (CEKSENHAR_SID = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if CEKSEN<>CEK then
  begin
    lblCEKNUML.Visible := False;
    lblCEKNUM.Visible := False;
  end;

  if (CEKSENHAR_ID <> 0)  and (CEKSENHAR_SID <> 0) then
  begin
    tblCEKSENHAR.CEKSENHAR_ID := CEKSENHAR_ID;
    tblCEKSENHAR.CEKSENHAR_SID := CEKSENHAR_SID;
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
        txtCARIHARACK.Text := CARIHAR_ACK;
        txtCARIKOD.Text := CARI_KOD;
        if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCARIKOD.Text,CARI_AD) then
        begin
          lblCIROCARI_AD.Caption := CARI_AD;
        end;
      end;// end with tblCEKSENHAR do
    end;//end if dmCEKSENHAR.GET_CEKSENHAR(tblCEKSENHAR) then
    buton_ayarla(1);
    btnSil.Enabled:=True;
  end
  else
  begin
    EmptyFields;
    btnCEKSENLIST.Enabled := True;
    dtpIslemTar.Date := DataMod.GET_SERVER_DATE;
    buton_ayarla(1);
  end;
end;



procedure TfrmCEKSEN_TAHSILVER.GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer; YENI_KAYIT:Boolean);
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
      case CEKSEN of
      CEK:
        begin
          txtCARIHARACK.Text := tblCEKSEN.CEK_NUM+' numaralý çeki tahsile verme iþlemi.';
        end;
      SENET:
        begin
          txtCARIHARACK.Text := IntToStr(tblCEKSEN.CEKSEN_ID)+' numaralý seneti tahsile verme iþlemi.';
        end;
      end;
    end;
    if CEKSEN = CEK then
    begin
      lblCEKNUM.Caption  :=  tblCEKSEN.CEK_NUM;
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
    lblCIROCARI_AD.Caption := '';
    txtCARIHARACK.Clear;
  end;//end if dmCEKSENHAR.GET_CEKSEN(tblCEKSEN) then
end;

procedure TfrmCEKSEN_TAHSILVER.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmCEKSEN_TAHSILVER.btnCIKISClick(Sender: TObject);
begin
  Close;
end;

Procedure TfrmCEKSEN_TAHSILVER.EmptyFields;
begin
  txtNO.clear;
  txtCARIKOD.Clear;
  txtCARIHARACK.Clear;
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
  btnCEKSENLIST.Enabled := False;
  btnIPTAL.Enabled := False;
  btnCIRO.Enabled := False;
  btnYeni.Enabled := True;
end;

procedure TfrmCEKSEN_TAHSILVER.btnCEKSENLISTClick( Sender: TObject);
var
  BELGE_ID, BELGE_SID:Integer;
begin
  if frmCekSenSDLG.Form_Open(False,CEKSEN,BELGE_ID,BELGE_SID,1,True,1,1) Then
  begin
    GET_BELGE_BILGI(BELGE_ID,BELGE_SID,True);
  end;
end;

procedure TfrmCEKSEN_TAHSILVER.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0);
end;

procedure TfrmCEKSEN_TAHSILVER.btnIPTALClick(Sender: TObject);
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


procedure TfrmCEKSEN_TAHSILVER.btnCIROClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmCEKSEN_TAHSILVER.txtCARIKODExit(Sender: TObject);
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
    lblCIROCARI_AD.Caption := '';
  end;
end;

procedure TfrmCEKSEN_TAHSILVER.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCEKSEN_TAHSILVER.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
//         if btnSIL.Enabled Then btnSILClick(self);
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

procedure TfrmCEKSEN_TAHSILVER.txt_CARIKODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmCEKSEN_TAHSILVER.txt_CARIKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txt_CARIKODButtonClick(Self);
end;

procedure TfrmCEKSEN_TAHSILVER.txt_CARIKODButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
    txtCARIKOD.Text   := Cari_KOD;
    lblCIROCARI_AD.Caption := Cari_AD;
  end;
end;

procedure TfrmCEKSEN_TAHSILVER.txt_CARIKODExit(Sender: TObject);
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

procedure TfrmCEKSEN_TAHSILVER.btnAraClick(Sender: TObject);
var
  temp_id,temp_sid : integer;
  islem : byte;
begin
  if frmCekSenHarSDGL.Form_Open(False,
                                CEKSEN //CEK MÝ SENET MÝ
                                ,1//1-MÜÞTERÝ 2-BORÇ
                                ,2 //ISLEM=2 TAHSILE VERME
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

procedure TfrmCEKSEN_TAHSILVER.buton_ayarla(durum:byte);
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


procedure TfrmCEKSEN_TAHSILVER.btnCariKodClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,0) Then
  begin
    txtCARIKOD.Text := Cari_KOD;
    lblCIROCARI_AD.Caption := Cari_AD;
  end;
end;


procedure TfrmCEKSEN_TAHSILVER.txtCARIKODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then btnCariKodClick(Self);
end;

procedure TfrmCEKSEN_TAHSILVER.txtCARIKODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

function TfrmCEKSEN_TAHSILVER.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  Result := True;
end;

function TfrmCEKSEN_TAHSILVER.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  case CEKSEN of
  1: //cek start
    begin
      if (Length(Trim(txtNO.Text)) = 0) then
      begin
        Application.MessageBox('Lütfen listeden bir çek seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;

      if (Trim(txtCARIKOD.Text)='') then
      begin
        Application.MessageBox('Lütfen listeden bir banka seçiniz.','Dikkat',MB_ICONQUESTION);
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
      if (Trim(txtCARIKOD.Text)='') then
      begin
        Application.MessageBox('Lütfen listeden bir banka seçiniz.','Dikkat',MB_ICONQUESTION);
        exit;
      end;
    end;//senet stop
  end;//case end
  if not DataMod.EN_GER_KAY_TAR_KONTROL(dtpIslemTar.Date,True) then Exit;
  if not DataMod.IsDateInTerm(dtpIslemTar.Date, 'Ýþlem Tarihi') then Exit;
  Result := True;
end;

procedure TfrmCEKSEN_TAHSILVER.Form_Post;
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
    tblCEKSENHAR.ISLEM := 2;//2- Tahsile Verme
    tblCEKSENHAR.CARI_KOD := Trim(txtCARIKOD.Text);
    tblCEKSENHAR.CARIHAR_ACK := Trim(txtCARIHARACK.Text);
    tblCEKSENHAR.YEVMIYE_ACK := Trim(txtCARIHARACK.Text);
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

procedure TfrmCEKSEN_TAHSILVER.Form_Delete;
begin
  if not Form_Before_Delete then exit;
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Exit;
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trnCekSenHar.InTransaction then
       trnCekSenHar.Rollback;
//****************************************************************************//
    trnCekSenHar.StartTransaction;
//****************************************************************************//
    tblCEKSENHAR.ISLEM_TAR := dtpIslemTar.Date;
    tblCEKSENHAR.DOV_BAZ_TAR := tblCEKSEN.DOV_BAZ_TAR;//belgenin üzerindeki döviz baz tarihi aktarýlýyor.
    tblCEKSENHAR.CEKSEN := CEKSEN;
    tblCEKSENHAR.CEKSEN_ID := tblCEKSEN.CEKSEN_ID;
    tblCEKSENHAR.CEKSEN_SID:= tblCEKSEN.CEKSEN_SID;
    tblCEKSENHAR.ISLEM := 2;//2- Tahsile Verme
    tblCEKSENHAR.CARI_KOD := Trim(txtCARIKOD.Text);
    tblCEKSENHAR.CARIHAR_ACK := Trim(txtCARIHARACK.Text);
    tblCEKSENHAR.YEVMIYE_ACK := Trim(txtCARIHARACK.Text);
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
    Raise;
  end;
  EmptyFields;
  buton_ayarla(3);
end;

procedure TfrmCEKSEN_TAHSILVER.btnSilClick(Sender: TObject);
var
  qryDeg1:TIB_Query;
begin
{  //111
  Form_Delete;
  }


     if prv_ceksen_id<>0 then
     begin


     DataMod.CreateQuery(qryDeg1,Nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;                                                                                          //tahsil edilmediyse karsýlýksýz alýnmadýysa
     qryDeg1.SQL.Text:=
     ' SELECT  count(*) Gelen FROM CEKSENHAR WHERE CEKSEN =:TIPI AND BELGE_ID=:BELGE_ID AND BELGE_SID=:BELGE_SID and (ISLEM=4 or ISLEM=5 or ISLEM=7 )';
     qryDeg1.ParamByName('TIPI').AsInteger:=CEKSEN;

     qryDeg1.ParamByName('BELGE_ID').AsInteger:=    prv_ceksen_id;
     qryDeg1.ParamByName('BELGE_SID').AsInteger:=    prv_ceksen_sid;
     qryDeg1.Open;

     if qryDeg1.FieldByName('Gelen').AsInteger<=0 then
     Form_Delete;

    end
    else
    begin
        Application.MessageBox('Tahsil ve Karþýlýksýz Dekontlarý Ýptalinden Sonra Bu Ýþlemi Yapabilirsiniz ','Dikkat',MB_ICONQUESTION);
    end;

end;

end.
