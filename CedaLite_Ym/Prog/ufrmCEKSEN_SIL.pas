unit ufrmCEKSEN_SIL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, StdCtrls, Buttons, ExtCtrls,GenTypes;

type
  TfrmCEKSEN_SIL = class(TForm)
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
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtNO: TEdit;
    btnCEKSENLIST: TButton;
    trnCekSenHar: TIB_Transaction;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnCIKIS: TBitBtn;
    GroupBox1: TGroupBox;
    IB_Grid1: TIB_Grid;
    dtsCEKSENHAR: TIB_DataSource;
    qryCEKSENHAR: TIB_Query;
    lblCEKNUML: TLabel;
    lblCEKNUM: TLabel;
    procedure btnCEKSENLISTClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCIKISClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure qryCEKSENHARCalculateField(Sender: TIB_Statement;      ARow: TIB_Row; AField: TIB_Column);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Delete;
    function  Form_Before_Delete:Boolean;
    procedure Form_Open(Menu:Boolean;CEKSEN_ID,CEKSEN_SID:Integer;CEKSEN,TIP:Byte);
    procedure GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer);
    procedure BUTON_AYARLA(durum:byte);
    procedure EMPTYFIELDS;
    function  GET_CEKSENHAR():Boolean;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prvCEKSEN,prvTIP : Byte;
    tblCEKSEN:TBL_CEKSEN;
    tblCEKSENHAR : TBL_CEKSENHAR;
    Hareket : Boolean;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;

  const cns_cek_sil = 5;
  const cns_senet_sil = 6;

var
  frmCEKSEN_SIL : TfrmCEKSEN_SIL;
  frmMusteriCekiSil : TfrmCEKSEN_SIL;
  frmBorcCekiSil : TfrmCEKSEN_SIL;
  frmMusteriSenetiSil : TfrmCEKSEN_SIL;
  frmBorcSenetiSil : TfrmCEKSEN_SIL;
implementation
uses unDataMod, main, unCEKSENHAR, ufrmCekSenSDLG, unLogger;
{$R *.dfm}

{ TfrmCEKSEN_SIL }

////////////////////////////////////////////////////////////////////////////////
//müþteri çeki - YENI
//Form_Open(0,0,CEK,1)
//borç çeki - YENI
//Form_Open(0,0,CEK,1)
//müþteri seneti - YENI
//Form_Open(0,0,SENET,1)
//borç esneti - YENI
// Form_Open(0,0,SENET,2)
////////////////////////////////////////////////////////////////////////////////
procedure TfrmCEKSEN_SIL.Form_Open(Menu:Boolean;CEKSEN_ID, CEKSEN_SID: Integer; CEKSEN, TIP: Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  case CEKSEN of
  CEK:
    begin
      case TIP of
      1://müþteri çeki
        begin
          if not DataMod.Modul_Hak(cns_cek_sil,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if not MainForm.FindChildFrm(Application, 'frmMusteriCekiSil') then
            begin
              Application.CreateForm(TfrmCEKSEN_SIL,frmMusteriCekiSil);
              with frmMusteriCekiSil do
              begin
                Name := 'frmMusteriCekiSil';
                Caption := 'Sistemden Müþteri Çeki Silme';
                prv_CanUpdate := local_can_update;
                prv_CanDelete := local_can_delete;
                prvCEKSEN := CEKSEN;
                prvTIP := TIP;
              end;
            end;
          end;
        end;
      2://borç çeki
        begin
          if not DataMod.Modul_Hak(cns_cek_sil,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if not MainForm.FindChildFrm(Application, 'frmBorcCekiSil') then
            begin
              Application.CreateForm(TfrmCEKSEN_SIL,frmBorcCekiSil);
              with frmBorcCekiSil do
              begin
                Name := 'frmBorcCekiSil';
                Caption := 'Sistemden Borç Çeki Silme';
                prv_CanUpdate := local_can_update;
                prv_CanDelete := local_can_delete;
                prvCEKSEN := CEKSEN;
                prvTIP := TIP;
              end;
            end;
          end;
        end;
      end;//end case TIP of
    end;
  SENET:
    begin
      case TIP of
      1://müþteri seneti
        begin
          if not DataMod.Modul_Hak(cns_senet_sil,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if not MainForm.FindChildFrm(Application, 'frmMusteriSenetiSil') then
            begin
              Application.CreateForm(TfrmCEKSEN_SIL,frmMusteriSenetiSil);
              with frmMusteriSenetiSil do
              begin
                Name := 'frmMusteriSenetiSil';
                Caption := 'Sistemden Müþteri Seneti Silme';
                prv_CanUpdate := local_can_update;
                prv_CanDelete := local_can_delete;
                prvCEKSEN := CEKSEN;
                prvTIP := TIP;
                lblCEKNUML.Visible := False;
                lblCEKNUM.Visible := False;
              end;
            end;
          end;
        end;
      2://borç seneti
        begin
          if not DataMod.Modul_Hak(cns_senet_sil,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if not MainForm.FindChildFrm(Application,'frmBorcSenetiSil') then
            begin
              Application.CreateForm(TfrmCEKSEN_SIL,frmBorcSenetiSil);
              with frmBorcSenetiSil do
              begin
                Name := 'frmBorcSenetiSil';
                Caption := 'Sistemden Borç Seneti Silme';
                prv_CanUpdate := local_can_update;
                prv_CanDelete := local_can_delete;
                prvCEKSEN := CEKSEN;
                prvTIP := TIP;
                lblCEKNUML.Visible := False;
                lblCEKNUM.Visible := False;
              end;
            end;
          end;
        end;
      end;//end case TIP of
    end;
  end;//end case CEKSEN of
end;


procedure TfrmCEKSEN_SIL.GET_BELGE_BILGI(BELGE_ID, BELGE_SID :integer);
var
  CARI_AD : String;
begin
  tblCEKSEN.CEKSEN := prvCEKSEN;
  tblCEKSEN.CEKSEN_ID := BELGE_ID;
  tblCEKSEN.CEKSEN_SID := BELGE_SID;
  if dmCEKSENHAR.GET_CEKSEN(tblCEKSEN) then
  begin
    if not GET_CEKSENHAR then
    begin
      Hareket := False;
    end
    else
    begin
      Hareket := True;
    end;
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
    if prvCEKSEN = CEK then
    begin
      lblCEKNUM.Caption := tblCEKSEN.CEK_NUM;
    end;
    txtNO.Text := IntToStr(tblCEKSEN.CEKSEN_ID);
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
  end;
end;

function TfrmCEKSEN_SIL.GET_CEKSENHAR():Boolean;
begin
  try
    qryCEKSENHAR.FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    with qryCEKSENHAR do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM CEKSENHAR WHERE CEKSEN = '+InttoStr(tblCEKSEN.CEKSEN)+ ' AND BELGE_ID ='+IntToStr(tblCEKSEN.CEKSEN_ID) + ' AND BELGE_SID = '+IntToStr(tblCEKSEN.CEKSEN_SID) + ' ORDER BY ISLEM');
      Active := True;
    end;

    if qryCEKSENHAR.Recordcount = 0 then
    begin
      Application.MessageBox('Tanýmlama numaralarý gönderilen ÇEK veya SENET Hareketi ile ilgili kayýt bulunamadý.','Dikkat',MB_ICONHAND);
      qryCEKSENHAR.Active := False;
      Result := False;
      Exit;
    end;
    Result := True;
  except
    raise;
  end;// try except end;
end;





procedure TfrmCEKSEN_SIL.btnCEKSENLISTClick(Sender: TObject);
var
  BELGE_ID,BELGE_SID : Integer;
begin
  case prvCEKSEN of
  CEK://start
    begin
      case prvTIP of
      1:
        begin
          if frmCekSenSDLG.Form_Open(True,CEK,BELGE_ID,BELGE_SID,prvTIP,False,1,1) then
          begin
            GET_BELGE_BILGI(BELGE_ID,BELGE_SID);
          end;
        end;
      2:
        begin
          if frmCekSenSDLG.Form_Open(True,CEK,BELGE_ID,BELGE_SID,prvTIP,False,1,1) then
          begin
            GET_BELGE_BILGI(BELGE_ID,BELGE_SID);
          end;
        end;
      end;//end case prvTIP of
    end;//end
  SENET://start
    begin//start
      case prvTIP of
      1:
        begin
          if frmCekSenSDLG.Form_Open(True,SENET,BELGE_ID,BELGE_SID,prvTIP,False,1,2) then
          begin
            GET_BELGE_BILGI(BELGE_ID,BELGE_SID);
          end;
        end;
      2:
        begin
          if frmCekSenSDLG.Form_Open(True,SENET,BELGE_ID,BELGE_SID,prvTIP,False,1,2) then
          begin
            GET_BELGE_BILGI(BELGE_ID,BELGE_SID);
          end;
        end;
      end;//end case prvTIP of
    end;//end senet
  end;//end case prvCEKSEN of
end;//end procedure

procedure TfrmCEKSEN_SIL.buton_ayarla(durum:byte);
begin
  case durum of
  1://yeni kayýtta çaðrýlacak
    begin
      btnCEKSENLIST.Enabled := True;
      btnIPTAL.Enabled := True;
      btnYeni.Enabled := False;
      btnSIL.Enabled := True;
   end;
  2://kaydete bastýktan sonra çaðrýlacak
    begin
      btnIPTAL.Enabled := False;
      btnYeni.Enabled := True;
      btnSIL.Enabled := False;
    end;
  3://iptale bastýktan sonra çaðrýlacak
    begin
      btnCEKSENLIST.Enabled := False;
      btnIptal.Enabled := False;
      btnYeni.Enabled := True;
      btnSIL.Enabled := False;
    end;
  end;//end case
end;


procedure TfrmCEKSEN_SIL.EmptyFields;
begin
  txtNO.clear;
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
  btnCEKSENLIST.Enabled := False;
  btnIPTAL.Enabled := False;
  btnYeni.Enabled := True;
end;


procedure TfrmCEKSEN_SIL.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCEKSEN_SIL.btnCIKISClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCEKSEN_SIL.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  EMPTYFIELDS;
  buton_ayarla(1);
end;

procedure TfrmCEKSEN_SIL.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmCEKSEN_SIL.btnIPTALClick(Sender: TObject);
begin
  EmptyFields;
//****************************************************************************//
  if trnCekSenHar.InTransaction then
     trnCekSenHar.Rollback;
  dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
  buton_ayarla(3);
end;

procedure TfrmCEKSEN_SIL.qryCEKSENHARCalculateField(Sender: TIB_Statement;  ARow: TIB_Row; AField: TIB_Column);
begin
  case  ARow.GetColumnValue('ISLEM') of
  1:  ARow.SetColumnValue('ISLEM_ACK','ALIM');
  2:  ARow.SetColumnValue('ISLEM_ACK','TAHSÝLE VERME');
  3:  ARow.SetColumnValue('ISLEM_ACK','CÝROLAMA');
  4:  ARow.SetColumnValue('ISLEM_ACK','Tahsilden Gelen Tahsil Dekontu');
  5:  ARow.SetColumnValue('ISLEM_ACK','Tahsilden Gelen Karþýlýksýz Dekontu');
  6:  ARow.SetColumnValue('ISLEM_ACK','Satýcýdan  Gelen Karþýlýksýz  Dekontu');
  7:  ARow.SetColumnValue('ISLEM_ACK','Portfoyde  Karþýlýksýz Dekontu');
  8:  ARow.SetColumnValue('ISLEM_ACK','Portfoyde Iade Dekontu');
  9:  ARow.SetColumnValue('ISLEM_ACK','Kasaya Tahsil');
  15:  ARow.SetColumnValue('ISLEM_ACK','Verim');
  16:  ARow.SetColumnValue('ISLEM_ACK','Ýade dekontu');
  17:  ARow.SetColumnValue('ISLEM_ACK','Bankadan Borç Çeki Ödeme Dekontu');
  18:  ARow.SetColumnValue('ISLEM_ACK','Kasadan Çek Senet Ödeme');
  end;
end;

function TfrmCEKSEN_SIL.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Length(Trim(txtNO.Text)) = 0 then
  begin
    Application.MessageBox('Belge seçmeden silme iþlemi yapamazsýnýz..!!!','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;


procedure TfrmCEKSEN_SIL.Form_Delete;
var
  qryTemp : TIB_Query;
  Belge_Tur : Byte;
  k_kod,k_ad,k_dovkod : String;
begin
  if not Form_Before_Delete then exit;
  if Hareket then
  begin//belgenin hareketi var ise
    try
      try
//****************************************************************************//
        if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
        if trnCekSenHar.InTransaction then
           trnCekSenHar.Rollback;
        trnCekSenHar.StartTransaction;
//****************************************************************************//
        qryCEKSENHAR.DisableControls;
        qryCEKSENHAR.Last;
        while not qryCEKSENHAR.Bof do
        begin
          if (qryCEKSENHAR.FieldByName('ISLEM').AsInteger = 1) or (qryCEKSENHAR.FieldByName('ISLEM').AsInteger = 15) then
          begin
            //en sondaki 1 parametresinin silme iþlemi yapmasý gerekiyor.
            DataMod.CreateQuery(qryTemp,trnCekSenHar,True,DataMod.dbaMain);
            with qryTemp do
            begin
              SQL.Clear;
              if tblCEKSEN.CEKSEN = CEK then
              begin
                SQL.Add('SELECT * FROM CEK WHERE CEK_ID =' + IntToStr(tblCEKSEN.CEKSEN_ID) + ' AND CEK_SID = '+ IntToStr(tblCEKSEN.CEKSEN_SID))
              end
              else
              begin
                SQL.Add('SELECT * FROM SENET WHERE SENET_ID =' + IntToStr(tblCEKSEN.CEKSEN_ID) + ' AND SENET_SID = '+ IntToStr(tblCEKSEN.CEKSEN_SID));
              end;
              Active := True;
            end;//end with qryTemp do
//****************************************************************************//
            if not dmCEKSENHAR.CEKSEN_AUD(trnCekSenHar,prvCEKSEN,qryTemp,1) then
            begin
              qryCEKSENHAR.EnableControls;
              trnCekSenHar.Rollback;
              dmLOGGER.dbaMain_CancelMonitoring;
              EMPTYFIELDS;
              BUTON_AYARLA(3);
              Application.MessageBox('dmCEKSENHAR.CEKSEN_AUD rutininde hata oluþtu.','Dikkat',MB_ICONHAND);
              Exit;
            end;
//****************************************************************************//
            qryTemp.Delete;
          end
          else
          begin
            with qryCEKSENHAR do
            begin
              tblCEKSENHAR.CEKSENHAR_ID := FieldByName('CEKSENHAR_ID').AsInteger;
              tblCEKSENHAR.CEKSENHAR_SID := FieldByName('CEKSENHAR_SID').AsInteger;
              tblCEKSENHAR.ISLEM_TAR := FieldByName('ISLEM_TAR').AsDate;
              tblCEKSENHAR.DOV_BAZ_TAR := FieldByName('DOV_BAZ_TAR').AsDate;
              tblCEKSENHAR.CEKSEN := FieldByName('CEKSEN').AsInteger;
              tblCEKSENHAR.CEKSEN_ID := FieldByName('BELGE_ID').AsInteger;
              tblCEKSENHAR.CEKSEN_SID := FieldByName('BELGE_SID').AsInteger;
              tblCEKSENHAR.ISLEM := FieldByName('ISLEM').AsInteger;
              tblCEKSENHAR.DOVKUR := FieldByName('DOVKUR').AsCurrency;
              tblCEKSENHAR.TUTAR_VPB := FieldByName('TUTAR_VPB').AsCurrency;
              tblCEKSENHAR.KUR_FARKI := FieldByName('KUR_FARKI').AsCurrency;
              tblCEKSENHAR.CARI_KOD := FieldByName('CARI_KOD').AsString;
              tblCEKSENHAR.PLASIYER_KOD := FieldByName('PLASIYER_KOD').AsString;
              tblCEKSENHAR.PROJE_KOD := FieldByName('PROJE_KOD').AsString;
              tblCEKSENHAR.CARIHAR_ACK := FieldByName('CARIHAR_ACK').AsString;
              tblCEKSENHAR.YEVMIYE_ACK := FieldByName('YEVMIYE_ACK').AsString;
              tblCEKSENHAR.PROTESTO_MASRAF := FieldByName('PROTESTO_MASRAF').AsCurrency;
              tblCEKSENHAR.GENEL_GIDER := FieldByName('GENEL_GIDER').AsCurrency;
              tblCEKSENHAR.GENEL_GIDER_MUH_KOD := FieldByName('GENEL_GIDER_MUH_KOD').AsString;
              tblCEKSENHAR.BORCALHESAP := FieldByName('BORCALHESAP').AsString;
              tblCEKSENHAR.MASRAF_MERK := FieldByName('MASRAF_MERK').AsString;
              tblCEKSENHAR.KOD1 := FieldByName('KOD1').AsString;
              tblCEKSENHAR.KOD2 := FieldByName('KOD2').AsString;
              tblCEKSENHAR.KOD3 := FieldByName('KOD3').AsString;
              tblCEKSENHAR.KOD4 := FieldByName('KOD4').AsString;
              //alttaki kod sonradan eklendi.
              //islem 9 ise kasa kodu gerekir.
              if tblCEKSENHAR.ISLEM = 9 then
              begin
                tblCEKSENHAR.KASA_KOD := FieldByName('KASA_KOD').AsString;
              end;
            end;

            {
            Müþteri Çek ve Senetleri
            1- Alým
            2- Tahsile Verme
            3- Cirolama
            4- Tahsilden Gelen “Tahsil” Dekontu
            5- Tahsilden Gelen “Karþýlýksýz” Dekontu
            6- Satýcýdan  Gelen “Karþýlýksýz”  Dekontu
            7- Portfoyde  “Karþýlýksýz” Dekontu
            8- Portfoyde “Iade” Dekontu
            9- Kasaya Tahsil

            Borç Çek ve Senetleri
            15- Verim
            16- Ýade dekontu
            17- Bankadan Borç Çeki Ödeme Dekontu
            18- Kasadan Çek Senet Ödeme
            }
            //burak aþaðýdaki case'leri mutlaka kontrol et...
            case prvCEKSEN of
            CEK:
              begin
                case tblCEKSENHAR.ISLEM of
                  //burada 1 ile 15 deðerlerini alarak gelemez.
                  2: Belge_Tur := BT_MCEK_TAHSIL_VER;
                  3: Belge_Tur := BT_MCEK_CIRO;
                  4: Belge_Tur := BT_BANK_MCEK_TAH;
                  5: Belge_Tur := BT_BANK_KARS_CEK;
                  6: Belge_Tur := BT_SATICI_KARS_CEK;
                  7: Belge_Tur := BT_PORT_CEK_KARS;
                  8: Belge_Tur := BT_MCEK_IADE;
                  9: Belge_Tur := BT_KASA;
                  16: Belge_Tur := BT_BORC_CEK_IADE;
                  17: Belge_Tur := BT_BORC_CEK_ODE;
                  18: Belge_Tur := BT_KASA;
                end;// case tblCEKSENHAR.ISLEM of
              end;
            SENET:
              begin
                case tblCEKSENHAR.ISLEM of
                  //burada 1 ile 15 deðerlerini alarak gelemez.
                  2: Belge_Tur := BT_MSEN_TAHSIL_VER;
                  3: Belge_Tur := BT_MSEN_CIRO;
                  4: Belge_Tur := BT_BANK_MSEN_TAH;
                  5: Belge_Tur := BT_BANK_PROT_SEN;
                  6: Belge_Tur := BT_SATICI_PROT_SEN;
                  7: Belge_Tur := BT_PORT_SEN_KARS;
                  8: Belge_Tur := BT_MSEN_IADE;
                  9: Belge_Tur := BT_KASA;  //
                  16: Belge_Tur := BT_BORC_SEN_IADE;
                  18: Belge_Tur := BT_KASA;
                end;// case tblCEKSENHAR.ISLEM of
              end;
            end;//end case prvCEKSEN of

            if Belge_Tur <> 0 then
            begin

              case Belge_Tur of
              BT_KASA:
                begin
                  k_kod := tblCEKSENHAR.KASA_KOD;
                  if not DataMod.GET_KASA_FROM_KASA_KOD(k_kod,k_ad,k_dovkod) then
                  begin
                    Application.MessageBox('Seçilen kasa ile ilgili bilgilere ulaþýlamadý.Lütfen kontrol ediniz','Dikkat',MB_ICONWARNING);
                    exit;
                  end
                  else
                  begin
                    if not dmCEKSENHAR.CEKSENHAR_AUD(trnCekSenHar,tblCEKSENHAR,Belge_Tur,k_dovkod,1) then
                    begin
                      qryCEKSENHAR.EnableControls;
                      trnCekSenHar.Rollback;
                      dmLOGGER.dbaMain_CancelMonitoring;
                      EMPTYFIELDS;
                      BUTON_AYARLA(3);
                      exit;
                    end;
                  end;
                  k_kod := '';
                  k_ad := '';
                  k_dovkod := '';
                end;//end case bt_kasa
                else
                begin
                  if not dmCEKSENHAR.CEKSENHAR_AUD(trnCekSenHar,tblCEKSENHAR,Belge_Tur,'',1) then
                  begin
                    qryCEKSENHAR.EnableControls;
                    trnCekSenHar.Rollback;
                    dmLOGGER.dbaMain_CancelMonitoring;
                    EMPTYFIELDS;
                    BUTON_AYARLA(3);
                    exit;
                  end;
                end;
              end;//end case
            end
            else
            begin
              Application.MessageBox('Seçili hareket üzerinde sistemde tanýmlý olmayan bir ISLEM deðeri bulunuyor.Lütfen yazýlým bölümü ile baðlantýya geçiniz.Yapýlan iþlem iptal edilecektir.','Dikkat',MB_ICONERROR);
              qryCEKSENHAR.EnableControls;
              qryCEKSENHAR.Active := False;
              trnCekSenHar.Rollback;
              dmLOGGER.dbaMain_CancelMonitoring;
              EMPTYFIELDS;
              BUTON_AYARLA(3);
              exit;
            end;
          end;
          Belge_Tur := 0;
          qryCEKSENHAR.Prior;
        end;//end while
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,SENET,',
                                             Belge_Tur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,2,'');
//****************************************************************************//
        trnCekSenHar.Commit;
        qryCEKSENHAR.EnableControls;
        qryCEKSENHAR.Active := False;
      except
        trnCekSenHar.Rollback;
        dmLOGGER.dbaMain_CancelMonitoring;
        raise;
      end;
    finally
      qryCEKSENHAR.EnableControls;
      DataMod.ReleaseQuery(qryTemp);
      //if qryTemp <> nil then
      //begin
      //  qryTemp.Close;
      //  qryTemp.Free;
      //end;
    end;//end finally
    EMPTYFIELDS;
    buton_ayarla(3);
  end//end belgenin hareketi var ise
  else
  begin//belgenin hareketi yok ise
    try
      try
//****************************************************************************//
        if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
        if trnCekSenHar.InTransaction then
           trnCekSenHar.Rollback;
        trnCekSenHar.StartTransaction;
        DataMod.CreateQuery(qryTemp,trnCekSenHar,True,DataMod.dbaMain);
        //qryTemp := TIB_Query.Create(Application);
        with qryTemp do
        begin
          //IB_Connection := DataMod.dbaMain;
          //IB_Transaction := trnCekSenHar;
          //ReadOnly := False;
          //RequestLive := True;
          SQL.Clear;
          if tblCEKSEN.CEKSEN = CEK then
          begin
            SQL.Add('SELECT * FROM CEK WHERE CEK_ID =' + IntToStr(tblCEKSEN.CEKSEN_ID) + ' AND CEK_SID = '+ IntToStr(tblCEKSEN.CEKSEN_SID))
          end
          else
          begin
            SQL.Add('SELECT * FROM SENET WHERE SENET_ID =' + IntToStr(tblCEKSEN.CEKSEN_ID) + ' AND SENET_SID = '+ IntToStr(tblCEKSEN.CEKSEN_SID));
          end;
          Active := True;
        end;//end with qryTemp do

        if not dmCEKSENHAR.CEKSEN_AUD(trnCekSenHar,prvCEKSEN,qryTemp,1) then
        begin
          trnCekSenHar.Rollback;
          dmLOGGER.dbaMain_CancelMonitoring;
          Application.MessageBox('dmCEKSENHAR.CEKSEN_AUD rutininde hata oluþtu.','Dikkat',MB_ICONHAND);
          Exit;
        end;
        qryTemp.Delete;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEKSENHAR,CEK,SENET,',
                                             Belge_Tur,
                                             tblCEKSENHAR.CEKSENHAR_ID,
                                             tblCEKSENHAR.CEKSENHAR_SID,
                                             1,2,'');
//****************************************************************************//
        trnCekSenHar.Commit;
      except
        trnCekSenHar.Rollback;
        dmLOGGER.dbaMain_CancelMonitoring;
        raise;
      end;//end try except
    finally
      qryCEKSENHAR.EnableControls;
      DataMod.ReleaseQuery(qryTemp);
    end;//end try finally
    EMPTYFIELDS;
    buton_ayarla(3);
  end;//end belgenin hareketi yok ise
end;

procedure TfrmCEKSEN_SIL.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmCEKSEN_SIL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    case Key of
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
    45: //s kaydet
       begin
         if btnYeni.Enabled then btnYeniClick(Self);
       end; //83 end
    end;//acase end
  end; ///if Shift = [] then ENd
end;

end.
