{$INCLUDE directive.inc}

unit ufrmIRSALIYE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  IB_Controls, Mask, Grids, IB_Grid, Menus;

type
  TfrmIRSALIYE = class(TForm)
    qryFAT_IRS: TIB_Query;
    trnFAT_IRS: TIB_Transaction;
    dtsFAT_IRS: TIB_DataSource;
    pgFAT_IRS: TPageControl;
    tabFAT_IRS: TTabSheet;
    tabKalem: TTabSheet;
    tabToplam: TTabSheet;
    tabAciklama: TTabSheet;
    Panel5: TPanel;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnYeni: TBitBtn;
    btnTRN_KAYDET: TButton;
    txtFaturaDepoAD: TIB_Edit;
    txtFaturaPlasiyerAD: TIB_Edit;
    grpBoxCari: TGroupBox;
    Label4: TLabel;
    lblCariAD: TLabel;
    lblYETKISI: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    lblVNO: TLabel;
    lblVDAIRE: TLabel;
    Adres: TLabel;
    lblADRES_1: TLabel;
    lblADRES_2: TLabel;
    lblILCE: TLabel;
    lblSEHIR: TLabel;
    lblPOSTA_KOD: TLabel;
    Label1: TLabel;
    Label14: TLabel;
    Label38: TLabel;
    grpBoxMuhtelif: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Edit14: TIB_Edit;
    IB_Edit15: TIB_Edit;
    IB_Edit16: TIB_Edit;
    IB_Edit17: TIB_Edit;
    IB_Edit18: TIB_Edit;
    IB_Edit19: TIB_Edit;
    IB_Edit20: TIB_Edit;
    IB_Edit21: TIB_Edit;
    qryFAT_IRS_MUH_CARI: TIB_Query;
    dtsFAT_IRS_MUH_CARI: TIB_DataSource;
    btnMuhtelifIptal: TButton;
    Panel4: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    IB_Text1: TIB_Text;
    IB_Text2: TIB_Text;
    IB_Text3: TIB_Text;
    Label21: TLabel;
    IB_Text4: TIB_Text;
    IB_Text5: TIB_Text;
    Panel1: TPanel;
    IB_Text22: TIB_Text;
    Label37: TLabel;
    Panel3: TPanel;
    btnEKLE: TButton;
    btnKaydet: TButton;
    btnIptal: TButton;
    btnSil: TButton;
    grdFatKontrol: TIB_Grid;
    qryURUNHAR: TIB_Query;
    dtsURUNHAR: TIB_DataSource;
    txtUrunKodu: TIB_Edit;
    IB_Edit23: TIB_Edit;
    txtOlcuBirim: TIB_Edit;
    IB_Currency5: TIB_Currency;
    edtDOVKUR: TIB_Currency;
    edtTUTAR: TIB_Currency;
    IB_Currency1: TIB_Currency;
    IB_Edit22: TIB_Edit;
    txtDepoKod: TIB_Edit;
    txtDepoAd: TIB_Edit;
    rdIskonto: TIB_RadioGroup;
    txtIskontoOran: TIB_Edit;
    txtIskontoTutar: TIB_Currency;
    txtISKONTO_TUTAR_VPB: TIB_Currency;
    IB_Edit28: TIB_Edit;
    lblKAL_ISKONTO_TIP: TLabel;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    lblTOP_PAG_KAL_ISK_TOP: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    IB_Text15: TIB_Text;
    txtTOP_PAG_KAL_ISK_TOP: TIB_Text;
    IB_Text17: TIB_Text;
    IB_Text18: TIB_Text;
    IB_Text19: TIB_Text;
    Label35: TLabel;
    IB_Text21: TIB_Text;
    Label36: TLabel;
    rdFatIsTip: TIB_RadioGroup;
    txtFatIskontoOran: TIB_Currency;
    txtFatIskontoTutar: TIB_Currency;
    IB_Currency6: TIB_Currency;
    GroupBox3: TGroupBox;
    IB_Text6: TIB_Text;
    IB_Text7: TIB_Text;
    IB_Text8: TIB_Text;
    IB_Text9: TIB_Text;
    IB_Text10: TIB_Text;
    IB_Text11: TIB_Text;
    IB_Text12: TIB_Text;
    IB_Text13: TIB_Text;
    IB_Text14: TIB_Text;
    IB_Text20: TIB_Text;
    IB_Text23: TIB_Text;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    txtKasaKod: TIB_Edit;
    txtKasaAd: TIB_Edit;
    lblAck301: TIB_Text;
    txtAck301: TIB_Edit;
    txtAck302: TIB_Edit;
    lblAck302: TIB_Text;
    txtAck303: TIB_Edit;
    lblAck303: TIB_Text;
    txtAck501: TIB_Edit;
    lblAck501: TIB_Text;
    lblAck502: TIB_Text;
    txtAck502: TIB_Edit;
    lblAck503: TIB_Text;
    txtAck503: TIB_Edit;
    lblAck504: TIB_Text;
    txtAck504: TIB_Edit;
    lblAck505: TIB_Text;
    txtAck505: TIB_Edit;
    txtAck1001: TIB_Edit;
    txtAck1002: TIB_Edit;
    lblAck1002: TIB_Text;
    lblAck1001: TIB_Text;
    lblAck1003: TIB_Text;
    txtAck1003: TIB_Edit;
    lblAck1004: TIB_Text;
    txtAck1004: TIB_Edit;
    txtAck1005: TIB_Edit;
    lblAck1005: TIB_Text;
    qryFAT_IRS_ACK: TIB_Query;
    dtsFAT_IRS_ACK: TIB_DataSource;
    IB_Edit40: TIB_Edit;
    txtFaturaProjeAD: TIB_Edit;
    Label3: TLabel;
    IB_Edit4: TIB_Edit;
    Label2: TLabel;
    IB_Edit1: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Date1: TIB_Date;
    cmbFATURA_TIP: TIB_ComboBox;
    IB_Date2: TIB_Date;
    IB_Edit9: TIB_Edit;
    IB_Date4: TIB_Date;
    txtCariKod: TIB_Edit;
    txtFaturaDepoKod: TIB_Edit;
    txtPlasiyerKod: TIB_Edit;
    txtProjeKod: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    IB_Currency7: TIB_Currency;
    rgYAZICI: TRadioGroup;
    IB_Edit26: TIB_Edit;
    btnTRN_IPTAL: TButton;
    btnFaturaSil: TBitBtn;
    cboDOVKOD: TIB_ComboBox;
    btnCikti: TButton;
    grpRapKod: TGroupBox;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit24: TIB_Edit;
    IB_Edit25: TIB_Edit;
    PopupMenu1: TPopupMenu;
    FaturaKopyala1: TMenuItem;
    Btn_Siparis_Secimi: TBitBtn;
    trn_Sip: TIB_Transaction;
    txt_Sevk_Adres: TIB_Edit;
    BitBtn2: TBitBtn;
////////////////////////////////////////////////////////////////////////////////
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure Form_Open(Menu:Boolean;FAT_IRS_SEP:Byte;FAT_IRS_ID:Integer;FAT_IRS_SID:Integer;ISLEM:Byte;TIP:SmallInt);
    procedure DataSet_Open(FAT_IRS_ID:Integer;FAT_IRS_SID:Integer;ISLEM:Byte);
    procedure Cari2Labels;
    procedure MuhtelifIslemler;
    procedure KalemHesapla;
    procedure KDV_Hesapla;
    procedure EkAciklamaOpen;
    procedure ApplyDatasets;
    procedure CommitUpdates;
    procedure CancelUpdates;
    procedure FormatDisplays;
    procedure KalemBrutHesapla(Sil:Boolean);
    procedure Form_Post;
    procedure Form_Delete;
    function  URUN_HAR_SIL:Boolean;

    function  Form_Before_Delete:Boolean;
    function  Form_Before_Post:Boolean;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCikisClick(Sender: TObject);
    procedure txtFaturaDepoKodButtonClick(Sender: TObject);
    procedure txtPlasiyerKodButtonClick(Sender: TObject);
    procedure qryFAT_IRSAfterInsert(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure txtCariKodButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMuhtelifIptalClick(Sender: TObject);
    procedure pgFAT_IRSChanging(Sender: TObject;      var AllowChange: Boolean);
    procedure txtUrunKoduButtonClick(Sender: TObject);
    procedure pgFAT_IRSChange(Sender: TObject);
    procedure dtsURUNHARStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
    procedure btnEKLEClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure qryURUNHARAfterInsert(IB_Dataset: TIB_Dataset);
    procedure txtUrunKoduKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtDepoKodButtonClick(Sender: TObject);
    procedure txtDepoKodKeyUp(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure dtsURUNHARDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure txtUrunKoduEnter(Sender: TObject);
    procedure dtsFAT_IRSStateChanged(Sender: TIB_DataSource;         ADataset: TIB_Dataset);
    procedure dtsFAT_IRSDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure FaturaToplamHesapla;
    procedure txtKasaKodButtonClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure txtCariKodEnter(Sender: TObject);
    procedure txtCariKodExit(Sender: TObject);
    procedure txtCariKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtCariKodKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit24Enter(Sender: TObject);
    procedure IB_Edit24Exit(Sender: TObject);
    procedure txtProjeKodButtonClick(Sender: TObject);
    procedure txtProjeKodEnter(Sender: TObject);
    procedure txtProjeKodExit(Sender: TObject);
    procedure txtProjeKodKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPlasiyerKodKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtFaturaDepoKodEnter(Sender: TObject);
    procedure txtFaturaDepoKodExit(Sender: TObject);
    procedure txtFaturaDepoKodKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure cmbFATURA_TIPEnter(Sender: TObject);
    procedure cmbFATURA_TIPExit(Sender: TObject);
    procedure txtPlasiyerKodEnter(Sender: TObject);
    procedure txtPlasiyerKodExit(Sender: TObject);
    procedure btnFaturaSilClick(Sender: TObject);
    procedure rdIskontoChange(Sender: TObject);
    procedure rdFatIsTipChange(Sender: TObject);
    procedure txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
    procedure txtUrunKoduExit(Sender: TObject);
    procedure txtDepoKodEnter(Sender: TObject);
    procedure txtDepoKodExit(Sender: TObject);
    procedure txtDepoKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtOlcuBirimButtonClick(Sender: TObject);
    procedure txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
    procedure txtOlcuBirimExit(Sender: TObject);
    procedure txtOlcuBirimEnter(Sender: TObject);
    procedure txtOlcuBirimKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtFaturaDepoKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtPlasiyerKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtProjeKodKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtKasaKodEnter(Sender: TObject);
    procedure txtKasaKodExit(Sender: TObject);
    procedure txtKasaKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtKasaKodKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure qryURUNHARAfterPost(IB_Dataset: TIB_Dataset);
    procedure qryURUNHARAfterDelete(IB_Dataset: TIB_Dataset);
    procedure IB_Edit5ButtonClick(Sender: TObject);
    procedure IB_Edit6ButtonClick(Sender: TObject);
    procedure IB_Edit7ButtonClick(Sender: TObject);
    procedure IB_Edit24ButtonClick(Sender: TObject);
    procedure IB_Edit25ButtonClick(Sender: TObject);
    procedure IB_Edit5Exit(Sender: TObject);
    procedure IB_Edit6Exit(Sender: TObject);
    procedure IB_Edit7Exit(Sender: TObject);
    procedure IB_Edit25Exit(Sender: TObject);
    procedure IB_Edit5KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit6KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit7KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit24KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit25KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit40Exit(Sender: TObject);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure edtDOVKURExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
    procedure qryURUNHARBeforePost(IB_Dataset: TIB_Dataset);
    procedure FaturaKopyala1Click(Sender: TObject);
    procedure Btn_Siparis_SecimiClick(Sender: TObject);
    procedure IB_Edit5Enter(Sender: TObject);
    procedure IB_Edit6Enter(Sender: TObject);
    procedure IB_Edit7Enter(Sender: TObject);
    procedure IB_Edit25Enter(Sender: TObject);
    procedure txt_Sevk_AdresButtonClick(Sender: TObject);
    procedure txt_Sevk_AdresEnter(Sender: TObject);
    procedure txt_Sevk_AdresExit(Sender: TObject);
    procedure txt_Sevk_AdresKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure qryURUNHARBeforeEdit(IB_Dataset: TIB_Dataset);
  private
    { Private declarations }
    prv_FAT_TIP,prv_FAT_IRS_SEP:SmallInt;
    prn_FATURA_ID,prn_FATURA_SID,prv_MY_Index:Integer;
    prv_Burut_Top:Currency;
    prv_Temp_Burut_Top:Currency;
    my_Active_Comp:TWinControl;
    prv_ISN:Integer;
    prv_BELGE_TUR:Integer;
    prv_OlcuBirim_Kontrol:Boolean;
    prv_KDV_HESAPLA:Boolean;
    Muh_Kod,Aciklama:String;
    prv_CanUpdate,prv_CanDelete:Boolean;
    prv_Ilk_Miktar:Double;
    prv_Ilk_Olcu_Birimi:String;        
    procedure Fatura_Aktarma_Bag_Sil_Tek(Transaction: TIB_Transaction; Fatura_Id, FaturaD_Id: Integer);
    procedure Fatura_Aktarma_Bag_Sil_Tumu(Transaction: TIB_Transaction; Fatura_Id: Integer);
    procedure FN_BIRIMFIYAT;

  public
    { Public declarations }
    Siparis_Aktarma:Boolean;
    Disaridan_Fatura:Boolean;    
    res_Cari:TStringList;
  end;
  const cns_alis_irsaliye = 17;
  const cns_satis_irsaliye = 18;

type
  TKDV=Record
  KDV:SmallInt;
  KDVTUTAR:Currency;
end;

var
  frmIRSALIYE  : TfrmIRSALIYE;
  arr_KDV:Array [1..6] of TKDV;

implementation

uses main,
     unDataMod,
     ufrmCariSDLG,
     ufrmUrunSDLG,
     unFunc,
     
     unYazici,
     ufrmFAT_IRS_SDLG,
     ufrmISN_ERRORS,
     unLogger, unDEKONT_AUT, ufrmSiparis_Fatura, UDm_Fast_Report;

{$R *.dfm}

procedure TfrmIRSALIYE.Form_Open(Menu:Boolean;FAT_IRS_SEP:Byte;FAT_IRS_ID:Integer;FAT_IRS_SID:Integer;ISLEM:Byte;TIP:SmallInt);
//TIP 1:Sat??  2:Al??
//FAT_IRS_SEP : 1:FATURA 2:IRSALIYE
var
  qryFAT_PARAMS:TIB_Query;
  local_can_update,local_can_delete:Boolean;
begin
  case FAT_IRS_SEP of
  2:
    begin
      case TIP of
      1://sat?? irsaliyesi
        begin
          if not DataMod.Modul_Hak(cns_satis_irsaliye,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if ((ISLEM = 0) and (local_can_update = False)) then
            begin
              Application.MessageBox('Bu mod?lde yeni sat?? irsaliyesi yetkiniz yok.','Dikkat',MB_ICONWARNING);
              exit;
            end;
          end;
        end;
      2://al?? irsaliyesi
        begin
          if not DataMod.Modul_Hak(cns_alis_irsaliye,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if ((ISLEM = 0) and (local_can_update = False)) then
            begin
              Application.MessageBox('Bu mod?lde yeni al?? irsaliyesi yetkiniz yok.','Dikkat',MB_ICONWARNING);
              exit;
            end;
          end;
        end;
      end;
    end;
  end;
//****************************************************************************//
  if not MainForm.FindChildFrm( Application, 'frmIRSALIYE') then
  begin
    Application.CreateForm (TfrmIRSALIYE,frmIRSALIYE);
    frmIRSALIYE.prv_CanUpdate := local_can_update;
    frmIRSALIYE.prv_CanDelete := local_can_delete;
  end
  else
  begin
    Application.MessageBox('?rsaliye formu a??k.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
//****************************************************************************//
  with frmIRSALIYE do
  begin
    pgFAT_IRS.ActivePage := frmIRSALIYE.tabFAT_IRS;
    grpBoxCari.Visible := False;
    grpBoxMuhtelif.Visible := False;
    prv_FAT_TIP := TIP;
    prv_FAT_IRS_SEP := FAT_IRS_SEP;
    DataMod.CreateQuery(qryFAT_PARAMS,Nil,False,DataMod.dbaMain);
    //FAT_PARAMS_ID = 2 SATI? ?RSAL?YES? FAT_PARAMS TABLOSUNDA FAT_PARAMS_ID = 2
    //OLARAK TANILMLI OLDUGU ICIN BU ID ILE DATA CEKILIYOR
    //SATIS FATURASI ICIN ISE BU ID 1 OLARAK TANIMLI VE YONETICI KISMINDAKI
    //FATURA PARAMETRELERI VE IRSALIYE PARAMETRELERI FORMUDA BU ID'LERI
    //KULLANARAK DATA CEKIYOR.
    qryFAT_PARAMS.SQL.Add('SELECT * FROM FAT_PARAMS WHERE FAT_PARAMS_ID = 2');
    try
      qryFAT_PARAMS.Active := True;
      if qryFAT_PARAMS.RecordCount <> 0 then
      begin
        if qryFAT_PARAMS.FieldByName('EK_ACK_KUL').AsSmallint = 0 Then
        begin
          tabAciklama.TabVisible  := False;
        end;
        // KALEM BAZINDA ISKONTO KULLANIYOR MU?
        rdIskonto.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        txtIskontoOran.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        txtIskontoTutar.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        txtISKONTO_TUTAR_VPB.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        lblKAL_ISKONTO_TIP.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        lblTOP_PAG_KAL_ISK_TOP.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        txtTOP_PAG_KAL_ISK_TOP.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        //KALEM BAZINDA ISKONTO KULLANIYOR MU? END
      end
      else
      begin
        Application.MessageBox('?rsaliye Parametrelerine Ula??lam?yor... L?tfen yaz?l?m hizmet biriminize durumu bildiriniz. Fatura Giri?i yapmay?n?z.','Dikkat',MB_ICONSTOP);
      end;
      qryFAT_PARAMS.Active := False;
    except
      Application.MessageBox('?rsaliye Parametrelerine Ula??lam?yor... L?tfen yaz?l?m hizmet biriminize durumu bildiriniz. Fatura Giri?i yapmay?n?z.','Dikkat',MB_ICONSTOP);
      qryFAT_PARAMS.Active := False;
    end;
//****************************************************************************//
    case TIP of
    1:
      begin
        Caption := 'Sat?? ?rsaliyesi (Sonraki Sayfa ??in F6)';
        prv_BELGE_TUR := BT_SATIS_IRS;
        cmbFATURA_TIP.Items.Clear;
        cmbFATURA_TIP.Items.Add('KAPALI');
        cmbFATURA_TIP.Items.Add('A?IK');
        cmbFATURA_TIP.Items.Add('ALI?TAN ?ADE');
        cmbFATURA_TIP.Items.Add('?HRACAT');
        cmbFATURA_TIP.ItemValues.Clear;
        cmbFATURA_TIP.ItemValues.Add('1');
        cmbFATURA_TIP.ItemValues.Add('2');
        cmbFATURA_TIP.ItemValues.Add('3');
        cmbFATURA_TIP.ItemValues.Add('4');
      end;
    2:
      begin
        Caption := 'Al?? ?rsaliyesi (Sonraki Sayfa ??in F6)';
        prv_BELGE_TUR := BT_ALIS_IRS;
        cmbFATURA_TIP.Items.Clear;
        cmbFATURA_TIP.Items.Add('KAPALI');
        cmbFATURA_TIP.Items.Add('A?IK');
        cmbFATURA_TIP.Items.Add('SATI?TAN ?ADE');
        cmbFATURA_TIP.ItemValues.Clear;
        cmbFATURA_TIP.ItemValues.Add('1');
        cmbFATURA_TIP.ItemValues.Add('2');
        cmbFATURA_TIP.ItemValues.Add('3');

        btnCikti.Visible:=False;
        rgYAZICI.Visible:=False;
        IB_CheckBox1.Visible:=False;
      end;
    end;//end case
  {$IfnDef TRANSPORT}
//****************************************************************************//
    if glb_DEPO_UYG then
    begin
      txtDepoKod.Visible := True;
      txtDepoAd.Visible:= True;
      txtFaturaDepoKod.Visible := False;
      txtFaturaDepoAD.Visible := False;
    end
    else
    begin
      txtDepoKod.Visible := False;
      txtDepoAd.Visible:= False;
      txtFaturaDepoKod.Visible := False;
      txtFaturaDepoAD.Visible := False;
    end;
//****************************************************************************//
    if glb_PROJE_UYG then
    begin
      txtProjeKod.Visible := True;
      txtFaturaProjeAD.Visible := True;
    end
    else
    begin
      txtProjeKod.Visible := False;
      txtFaturaProjeAD.Visible := False;
    end;
//****************************************************************************//
  {$EndIf}
    if glb_PLASIYER_UYG then
    begin
      txtPlasiyerKod.Visible := True;
      txtFaturaPlasiyerAD.Visible := True;
    end
    else
    begin
      txtPlasiyerKod.Visible := False;
      txtFaturaPlasiyerAD.Visible := False;
    end;
//****************************************************************************//
  end;//with FaturaBur
//****************************************************************************//
  frmIRSALIYE.DataSet_Open(FAT_IRS_ID,FAT_IRS_SID,Islem);
  FormatDisplays;
end;

procedure TfrmIRSALIYE.DataSet_Open(FAT_IRS_ID:Integer;FAT_IRS_SID:Integer;ISLEM:Byte);
begin
   Siparis_Aktarma:=False;
   if trn_Sip.InTransaction then
   trn_Sip.Rollback;
   trn_Sip.StartTransaction;

  if ((ISLEM = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu mod?lde yeni kay?t yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmIRSALIYE do
  begin
    DataMod.Rapor_Kod_Visible_Fields_IB('FAT',ib_edit5,ib_edit6,ib_edit7,ib_edit24,ib_edit25);
    prv_ISN := DataMod.Get_Isn_Num;
    txtCariKod.Enabled := True;
//****************************************************************************//
    with qryFAT_IRS do
    begin
      Active := False;
      ParamByName('PRM_FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
      ParambyName('PRM_FAT_IRS_ID').AsInteger := FAT_IRS_ID;
      ParambyName('PRM_FAT_IRS_SID').AsInteger := FAT_IRS_SID;
      Active := True;
    end;

    if qryFAT_IRS.FieldbyName('KAPANDI').AsString ='1' then
    begin
         qryFAT_IRS.ReadOnly:=True;
         qryURUNHAR.ReadOnly:=True;
         qryFAT_IRS_MUH_CARI.ReadOnly:=True;
         qryFAT_IRS_ACK.ReadOnly:=True;
         btnFaturaSil.Enabled:=False;
         Btn_Siparis_Secimi.Enabled:=False;
    end
    else
    begin
         qryFAT_IRS.ReadOnly:=False;
         qryURUNHAR.ReadOnly:=False;
         qryFAT_IRS_MUH_CARI.ReadOnly:=False;
         qryFAT_IRS_ACK.ReadOnly:=False;
         Btn_Siparis_Secimi.Enabled:=True;
    end;


//****************************************************************************//
    prn_FATURA_ID := FAT_IRS_ID;
    prn_FATURA_SID := FAT_IRS_SID;
//****************************************************************************//
    case Islem of
    0:
      begin
        qryFAT_IRS.Insert;
        prv_KDV_HESAPLA := True;
        cmbFATURA_TIP.Enabled := True;
      end;
    1:
      begin
        if qryFAT_IRS.FieldByName('MUHTELIF').AsSmallint = 1 then
        begin
          grpBoxMuhtelif.Visible := True;
          grpBoxCari.Visible := False;
//****************************************************************************//
          with qryFAT_IRS_MUH_CARI do
          begin
            Active := False;
            ParamByName('PRM_FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
            ParamByName('PRM_FAT_IRS_ID').AsInteger := FAT_IRS_ID;
            ParamByName('PRM_FAT_IRS_SID').AsInteger := FAT_IRS_SID;
            Active := True;
          end;
//****************************************************************************//
          btnMuhtelifIptal.Visible := False;
          txtCariKod.Enabled := False;
        end
        else
        if qryFAT_IRS.FieldByName('MUHTELIF').AsSmallint = 0 then
        begin
          grpBoxMuhtelif.Visible := False;
          grpBoxCari.Visible := True;
          if DataMod.FN_CariKOD2Bilgi(qryFAT_IRS.FieldByName('CARI_KOD').AsString ,res_Cari) then
          begin
            Cari2Labels;
          end;
        end;

        if qryFAT_IRS.FieldbyName('KAPANDI').AsString ='0' then
        qryFAT_IRS.Edit;
//****************************************************************************//
        cmbFATURA_TIP.Enabled := False;
      end;
    end;
//****************************************************************************//
    with qryURUNHAR do
    begin
      Active := False;
      ParamByName('PRM_IRSALIYE_ID').AsInteger :=  qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
      ParamByName('PRM_IRSALIYE_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
      Active := True;
    end;
//****************************************************************************//
    if (qryFAT_IRS.FieldByName('TIP').AsInteger = 1) and (qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsInteger = 4) then
    begin
      prv_KDV_HESAPLA := False;
    end
    else
    begin
      prv_KDV_HESAPLA := True;
    end;
  end;//with
end;

procedure TfrmIRSALIYE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmIRSALIYE.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmIRSALIYE.txtFaturaDepoKodButtonClick(Sender: TObject);
var
  DEPO_KOD,DEPO_AD:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) then
  begin
    with qryFAT_IRS do
    begin
      FieldByName('DEPO_KOD').AsString := DEPO_KOD;
      FieldByName('DEPO_AD').AsString := DEPO_AD;
    end;
  end;
end;

procedure TfrmIRSALIYE.txtPlasiyerKodButtonClick(Sender: TObject);
var
  PLASIYER_KOD,PLASIYER_AD:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  
  if DataMOd.LS_Plasiyer(PLASIYER_KOD,PLASIYER_AD,1) then
  begin
    with qryFAT_IRS do
    begin
      FieldByName('PLASIYER_KOD').AsString := PLASIYER_KOD;
      FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
    end;
  end;
end;

procedure TfrmIRSALIYE.qryFAT_IRSAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryFAT_IRS do
  begin
    FieldByName('FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
    FieldByName('FAT_IRS_ID').AsInteger := qryFAT_IRS.Gen_ID('GEN_FAT_IRS',1);
    FieldByName('FAT_IRS_SID').AsInteger := glb_SID;
    FieldByName('REF_BELGE_TUR').AsSmallInt := 0;
    FieldByName('REF_BELGE_ID').AsInteger := 0;
    FieldByName('REF_BELGE_SID').AsInteger := 0;
    FieldByName('YAZILDI').AsInteger := 0;
    FieldByName('IPTAL').AsInteger := 0;
    FieldByName('TARIH').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('DOV_BAZ_TAR').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('VADE_TARIH').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('TIP').AsSmallint := prv_FAT_TIP ;
    FieldByName('BRUT_TOP').AsCurrency := 0 ;
    FieldByName('NET_TOP').AsCurrency := 0 ;
    FieldByName('KDV_TOP').AsCurrency := 0 ;
    FieldByName('GENEL_TOP').AsCurrency := 0 ;
    FieldByName('SAAT').AsDateTime := DataMod.GET_SERVER_DATETIME;
    FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency := 0 ;
    FieldByName('ISKONTO_TIP').AsSmallInt := 0 ;
    FieldByName('ISKONTO_ORAN').AsCurrency := 0 ;
    FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := 0 ;
    FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := 0 ;
    FieldByName('KDV1').AsCurrency := 0 ;
    FieldByName('KDV2').AsCurrency := 0 ;
    FieldByName('KDV3').AsCurrency := 0 ;
    FieldByName('KDV4').AsCurrency := 0 ;
    FieldByName('KDV5').AsCurrency := 0 ;
    FieldByName('OTV').AsCurrency := 0 ;
    FieldByName('KDV1_ORAN').AsSmallInt := 0;
    FieldByName('KDV2_ORAN').AsSmallInt := 0;
    FieldByName('KDV3_ORAN').AsSmallInt := 0;
    FieldByName('KDV4_ORAN').AsSmallInt := 0;
    FieldByName('KDV5_ORAN').AsSmallInt := 0;
    FieldByName('FAT_IRS_TIP').AsSmallInt := 2;
    FieldByName('MUHTELIF').AsSmallint:=0;
    FieldByName('KAPANDI').AsString :='0';
        
    case prv_FAT_TIP of
    1://sat?? irsaliyesi
      begin
        if glb_SUBELI then
        begin
          FieldByName('FAT_IRS_SERI').AsString := DataMod.GETPARAM(cns_satis_irsaliye,'IRS_SERI',glb_SID);
          FieldByName('BELGE_NO').AsString := IntToStr(DataMod.GET_SAYAC_NUM('SATIS_IRSALIYE',True,False,glb_SID));
        end
        else
        begin
          FieldByName('FAT_IRS_SERI').AsString := DataMod.GETPARAM(cns_satis_irsaliye,'IRS_SERI',0);
          FieldByName('BELGE_NO').AsString := IntToStr(DataMod.GET_SAYAC_NUM('SATIS_IRSALIYE',True,False,0));
        end;
      end;
    2://al?? irsaliyesi
      begin
        //FieldByName('FAT_IRS_SERI').AsString := DataMod.GETPARAM(cns_satis_fatura,'FAT_SERI',glb_SID);
      end;
    end;//end case
  end; //with qryFAT_IRS do
  IB_Edit1.SetFocus;  
end;


procedure TfrmIRSALIYE.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmIRSALIYE.btnTRN_KAYDETClick(Sender: TObject);
begin
  Form_Post;
end;

{
procedure TfrmFAT_IRS.TRN_IPTALClick(Silent:Boolean);
begin
  if Silent then
  begin
    CancelUpdates;
//****************************************************************************//
    if trnFAT_IRS.InTransaction then
       trnFAT_IRS.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
    grpBoxCari.Visible := False;
    grpBoxMuhtelif.Visible := False;
//****************************************************************************//
    prn_FATURA_ID := 0;
    prn_FATURA_SID := 0;
  end;
end;
}

procedure TfrmIRSALIYE.btnTRN_IPTALClick(Sender: TObject);
begin
{  if Sender.ClassName <> 'TButton'  then
  begin
    CancelUpdates;
    CommitUpdates;
//****************************************************************************//
    if trnFAT_IRS.InTransaction then
       trnFAT_IRS.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
    grpBoxCari.Visible := False;
    grpBoxMuhtelif.Visible := False;
//****************************************************************************//
    prn_FATURA_ID := 0;
    prn_FATURA_SID := 0;
  end
  else}
  begin
    if Application.MessageBox('?ptal etmek istedi?inizden emin misiniz?','Dikkat',MB_YESNO+MB_ICONQUESTION)=ID_YES then
    begin



      if (qryFAT_IRS.State = DssInsert) and Siparis_Aktarma then
      begin
         Fatura_Aktarma_Bag_Sil_Tumu(trn_Sip,qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger);
         if trn_Sip.InTransaction then
         trn_Sip.Commit;
      end;
      

      if (qryFAT_IRS.State = DssEdit) then
      begin
         if trn_Sip.InTransaction then
         trn_Sip.Rollback;
      end;

      //if prv_FAT_TIP = 1 then DataMod.Add_Sayaclar_Nu('SATIS_FATURA',qryFAT_IRS.FieldByName('BELGE_NO').AsInteger);
      CancelUpdates;
      CommitUpdates;
//****************************************************************************//
      if trnFAT_IRS.InTransaction then
         trnFAT_IRS.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
      grpBoxCari.Visible := False;
      grpBoxMuhtelif.Visible := False;
//****************************************************************************//
      prn_FATURA_ID := 0;
      prn_FATURA_SID := 0;
    end;
  end;
end;

procedure TfrmIRSALIYE.txtCariKodButtonClick(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  
  if frmCariSDLG.Form_Open(False,CARI_KOD,CARI_AD,2) then
  begin
    qryFAT_IRS.FieldByName('CARI_KOD').AsString := CARI_KOD;
    if DataMod.FN_CariKOD2Bilgi(Cari_KOD,res_Cari) then
    begin
      if res_Cari[15]='0' Then
      begin
        grpBoxCari.Visible := True;
        grpBoxMuhtelif.Visible := False;
        Cari2Labels;
      end
      else
      if res_Cari[15]='1' Then
      begin
        qryFAT_IRS.FieldByName('MUHTELIF').AsSmallint := 1;
        grpBoxCari.Visible := False;
        grpBoxMuhtelif.Visible := True;
        txtCariKod.Enabled := False;
        MuhtelifIslemler;
      end;
    end;
  end;
end;

procedure TfrmIRSALIYE.MuhtelifIslemler;
begin
  with frmIRSALIYE.qryFAT_IRS_MUH_CARI do
  begin
    Active := False;
    ParamByName('PRM_FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
    ParamByName('PRM_FAT_IRS_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
    ParamByName('PRM_FAT_IRS_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
    Active := True;
  end;

  if ((frmIRSALIYE.qryFAT_IRS_MUH_CARI.Bof) And (frmIRSALIYE.qryFAT_IRS_MUH_CARI.Eof)) then
  begin
    with frmIRSALIYE.qryFAT_IRS_MUH_CARI do
    begin
      Insert;
      FieldByName('FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
      FieldByName('FAT_IRS_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
      FieldByName('FAT_IRS_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
    end;
  end;
end;

procedure TfrmIRSALIYE.Cari2Labels;
begin
  with frmIRSALIYE do
  begin
    lblCariAD.Caption := res_Cari[1];
    lblYETKISI.Caption := res_Cari[2];
    lblVDAIRE.Caption := res_Cari[3];
    lblVNO.Caption := res_Cari[4];
    lblADRES_1.Caption := res_Cari[5];
    lblADRES_2.Caption := res_Cari[6];
    lblILCE.Caption := res_Cari[7];
    lblSEHIR.Caption := res_Cari[8];
    lblPOSTA_KOD.Caption := res_Cari[9];
  end;
end;

procedure TfrmIRSALIYE.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmIRSALIYE);
  res_Cari:=TStringList.Create;
  {$IfDef TRANSPORT}
  txtDepoKod.Visible:=False;
  txtDepoAd.Visible:=False;
  txtFaturaDepoKod.Visible:=False;
  txtFaturaDepoAD.Visible:=False;
  txtProjeKod.Visible:=False;
  txtFaturaProjeAD.Visible:=False;
  {$EndIf}
end;

procedure TfrmIRSALIYE.btnMuhtelifIptalClick(Sender: TObject);
begin
  qryFAT_IRS_MUH_CARI.Cancel;
  qryFAT_IRS.FieldByName('MUHTELIF').AsSmallint := 0;
  txtCariKod.Enabled := True;
  qryFAT_IRS.FieldByName('CARI_KOD').AsString := '';
  grpBoxMuhtelif.Visible := False;
end;

procedure TfrmIRSALIYE.pgFAT_IRSChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if pgFAT_IRS.ActivePage = tabFAT_IRS Then
  begin
    qryFAT_IRS.UpdateData;
    if Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString) = '' Then
    begin
      txtCariKod.SetFocus;
      Application.MessageBox('Cari Bilgisi olmadan bu alana ge?emezsiniz.','Dikkat',MB_ICONWARNING);
      AllowChange:= False;
      txtCariKodButtonClick(Self);
    end
    else
    if qryFAT_IRS.FieldByName('MUHTELIF').AsSmallInt = 1 Then
    begin
      if qryFAT_IRS_MUH_CARI.State in [dssEdit,dssInsert] Then
      begin
        if qryFAT_IRS_MUH_CARI.FieldByName('CARI_AD').AsString='' Then
        begin
          Application.MessageBox('Cari Ad? alan?na bilgi girmelisiniz.','Dikkat',MB_ICONWARNING);
          AllowChange := False;
          Exit;
        end;
        qryFAT_IRS_MUH_CARI.Post;
      end;
    end;
  end
  else
  if pgFAT_IRS.ActivePage = tabKalem Then
  begin
    if qryURUNHAR.State in [dssEdit,dssInsert] Then
    begin
      Application.MessageBox('Kalem bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end
    else
    begin
      KDV_Hesapla;
    end;
  end
  else
  if pgFAT_IRS.ActivePage = tabAciklama Then
  begin
    if qryFAT_IRS_ACK.State in [dssEdit,dssInsert] Then qryFAT_IRS_ACK.Post;
  end;
end;

procedure TfrmIRSALIYE.pgFAT_IRSChange(Sender: TObject);
begin
  try
    if pgFAT_IRS.ActivePage = tabFAT_IRS then
    begin
      if qryFAT_IRS.FieldByName('MUHTELIF').AsInteger = 1 then
      begin
        btnMuhtelifIptal.Visible := False;
      end;
    end
    else
    if pgFAT_IRS.ActivePage = tabKalem then
    begin
      if qryURUNHAR.Active = False then
      begin
        prv_Burut_Top := qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency;
        prv_Temp_Burut_Top := qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency;
      end;
    end
    else
    if pgFAT_IRS.ActivePage = tabToplam then
    begin
      if qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsSmallint =  1 then
      begin
        txtKasaKod.Visible := True;
        txtKasaAd.Visible := True;
      end
      else
      begin
        txtKasaKod.Visible := False;
        txtKasaAd.Visible := False;
      end;
    end
    else
    if pgFAT_IRS.ActivePage = tabAciklama then
    begin
       EkAciklamaOpen;
    end;
  finally
    qryURUNHAR.EnableControls;
  end;
end;

procedure TfrmIRSALIYE.dtsURUNHARStateChanged(Sender:TIB_DataSource;ADataset:TIB_Dataset);
begin
  if ADataset.State in [dssINSERT,dssEDIT] then
  begin
    btnEKLE.Enabled := False;
    btnSIL.Enabled := False;
    btnKAYDET.Enabled := True;
    btnIPTAL.Enabled := True;
    grdFatKontrol.Enabled := False;
  end
  else
  begin
    btnEKLE.Enabled := True;

    if qryFAT_IRS.FieldbyName('KAPANDI').AsString <>'1' then
    begin
    {if not ((qryURUNHAR.Eof) and (qryURUNHAR.Bof)) then
    begin
      btnSil.Enabled := True
    end
    else
    begin
      btnSil.Enabled := False;
    end;}


    if ADataset.FieldByName('URUNHAR_ID').AsInteger<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;

    end
    else
    begin
      btnEKLE.Enabled := False;
      btnSil.Enabled := False;
    end;

    btnKAYDET.Enabled := False;
    btnIPTAL.Enabled := False;
    grdFatKontrol.Enabled := True;
  end;
end;

procedure TfrmIRSALIYE.btnEKLEClick(Sender: TObject);
begin
  qryURUNHAR.Append;
  txtUrunKodu.SetFocus;
end;

procedure TfrmIRSALIYE.btnKaydetClick(Sender: TObject);
begin
  ////kaydetmeden ?nce kontroller yap?lacak
  if Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString)='' then
  begin
    txtUrunKodu.SetFocus;
    Application.MessageBox('?r?n kodu se?imi yapmad?n?z.!!','Dikkat',MB_ICONWARNING);
    txtUrunKoduButtonClick(Self);
    exit;
  end;
  if qryURUNHAR.FieldByName('MIKTAR').AsCurrency <=0 then
  begin
    IB_Currency7.SetFocus;
    Application.MessageBox('Miktar alan? s?f?rdan k???k ya da e?it olamaz!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('MIKTAR').AsCurrency := 1;
    exit;
  end;

  if Trim(qryURUNHAR.FieldByName('OLCUBIRIM').AsString)='' then
  begin
    txtOlcuBirim.SetFocus;
    Application.MessageBox('?l?? Birimi Alan?na Veri Girmediniz!!!','D?KKAT',MB_ICONWARNING);
    Exit;
  end;

  if (qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency <= 0) then
  begin
    IB_Currency5.SetFocus;
    Application.MessageBox('Birim fiyat? s?f?rdan k???k ya da e?it olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency := 1;
    exit;
  end;

  if (qryURUNHAR.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    edtDOVKUR.SetFocus;
    Application.MessageBox('D?viz kuru s?f?ra e?it yada k???k olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('DOVKUR').AsCurrency := 1;
    exit;
  end;

  if (qryURUNHAR.FieldByName('KDV').AsCurrency < 0) then
  begin
    IB_Edit22.SetFocus;
    Application.MessageBox('KDV oran? s?f?rdan k???k olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('KDV').AsCurrency := 0;
    exit;
  end;

  if (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    Application.MessageBox('Tutar vpb de?eri s?f?ra e?it yada k???k olamaz!!!','Dikkat',MB_ICONWARNING);
    exit;
  end;

  qryURUNHAR.Post;
  prv_Burut_Top:=prv_Temp_Burut_Top;
end;

procedure TfrmIRSALIYE.btnIptalClick(Sender: TObject);
begin
  qryURUNHAR.Cancel;
end;

procedure TfrmIRSALIYE.btnSilClick(Sender: TObject);
begin
  if Application.MessageBox('?zerinde bulundu?unuz kayd? ger?ekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Exit;

  Fatura_Aktarma_Bag_Sil_Tek(trn_Sip,qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger);

  qryURUNHAR.Delete;
end;

procedure TfrmIRSALIYE.txtUrunKoduButtonClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad,DOVKOD,OlcuBirim, Depo_Kod, Depo_Ad:String;
  KDV_TUTAR,Fiyat:Currency;
  KDV,KDV_DAHIL:Byte;
begin
  if not (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_AD,True) then
  begin
    qryURUNHAR.FieldByName('URUN_KOD').AsString := Urun_Kod;
    if DataMod.GET_URUN_FAT_BILGI(trnFAT_IRS,
                                  qryURUNHAR.FieldByName('URUN_KOD').AsString,
                                  qryFAT_IRS.FieldByName('CARI_KOD').AsString,
                                  prv_FAT_TIP,
                                  prv_ISN,
                                  Fiyat,
                                  DOVKOD,
                                  Urun_Ad,
                                  OlcuBirim,
                                  Depo_Kod,
                                  Depo_Ad,
                                  KDV,
                                  KDV_TUTAR,
                                  KDV_DAHIL) then
    begin
      with qryURUNHAR do
      begin
        FieldByName('URUN_AD').AsString := Urun_Ad;
        FieldByName('ACIKLAMA').AsString := Urun_Ad;
        FieldByName('BIRIM_FIY').AsCurrency := Fiyat;
        FieldByName('DOVKOD').AsString := DOVKOD;
        FieldByName('OLCUBIRIM').AsString := OlcuBirim;
      end;
      //qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency  := KDV_TUTAR;
      if (Trim(qryURUNHAR.FieldByName('DEPO_KOD').AsString) = '') and glb_DEPO_UYG then
      begin
        qryURUNHAR.FieldByName('DEPO_KOD').AsString := Depo_Kod;
        qryURUNHAR.FieldByName('DEPO_AD').AsString := Depo_Ad;
      end;
      if prv_KDV_HESAPLA then
      begin
        qryURUNHAR.FieldByName('KDV').AsSmallInt := KDV;
      end
      else
      begin
        qryURUNHAR.FieldByName('KDV').AsSmallInt := 0;
      end;
    end;
  end;
end;

procedure TfrmIRSALIYE.qryURUNHARAfterInsert(IB_Dataset: TIB_Dataset);
begin
   with IB_Dataset do
   begin
     FieldByName('URUNHAR_ID').AsInteger := qryURUNHAR.Gen_ID('GEN_URUNHAR',1);
     FieldByName('URUNHAR_SID').AsInteger := glb_SID;
     FieldByName('MIKTAR').AsInteger := 1;
//****************************************************************************//
     FieldByName('FATURA_ID').AsInteger := 0;
     FieldByName('FATURA_SID').AsInteger := 0;
//****************************************************************************//
     FieldByName('IRSALIYE_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
     FieldByName('IRSALIYE_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
//****************************************************************************//
     FieldByName('DEPO_KOD').AsString := qryFAT_IRS.FieldByName('DEPO_KOD').AsString;
     FieldByName('DEPO_AD').AsString := qryFAT_IRS.FieldByName('DEPO_AD').AsString ;
     FieldByName('TARIH').AsDate := qryFAT_IRS.FieldByName('TARIH').AsDate;
     FieldByName('DOV_BAZ_TAR').AsDate := qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDate;
     FieldByName('BELGE_TUR').AsInteger := prv_BELGE_TUR;
     FieldByName('BELGE_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger ;
     FieldByName('BELGE_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger ;
     FieldByName('BELGE_SIRA_NO').AsInteger := 1;
     FieldByName('ISKONTO_TIP').AsInteger := 0;
     FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := 0 ;
     FieldByName('DOVKOD').AsString := glb_DEFCUR;
     FieldByName('CIKIS_MIKTAR').AsCurrency := 0;
          
     If (prv_FAT_TIP = 1) then  //SATI?
     begin
       FieldByName('TIP').AsString :=  ALACAK;
     end else
     begin   //ALI?
       FieldByName('TIP').AsString :=  BORC;
     end;
     if prv_KDV_HESAPLA then
     begin
        FieldByName('KDV').AsInteger := 18
     end
     else
     begin
        FieldByName('KDV').AsInteger := 0;
     end;
   end;
   if pgFAT_IRS.ActivePage=tabKalem then
   txtUrunKodu.SetFocus;
end;

procedure TfrmIRSALIYE.KalemHesapla;
begin
/// ?r?n secilmedi?i zaman miktar hesaplamalara 1 olarak kat?lacak
// yada hesaplamalardan c?kar?lacak

  qryURUNHAR.FieldByName('TUTAR').AsCurrency := qryURUNHAR.FieldByNAme('MIKTAR').AsCurrency * qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency;
  qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency := qryURUNHAR.FieldByNAme('MIKTAR').AsCurrency * qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency*qryURUNHAR.FieldByName('DOVKUR').AsCurrency;

  if qryURUNHAR.FieldByName('ISKONTO_TIP').AsSmallInt=0 then
  begin //oran yani
    qryURUNHAR.FieldByName('ISKONTO_TUTAR').AsCurrency := qryURUNHAR.FieldByName('ISKONTO_ORAN').AsInteger*(qryURUNHAR.FieldByName('TUTAR').AsCurrency/100);
    qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qryURUNHAR.FieldByName('ISKONTO_TUTAR').AsCurrency * qryURUNHAR.FieldByName('DOVKUR').AsCurrency;
  end
  else
  begin // tutar yani
    qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qryURUNHAR.FieldByName('ISKONTO_TUTAR').AsCurrency * qryURUNHAR.FieldByName('DOVKUR').AsCurrency;
  end;

  if prv_KDV_HESAPLA then
  begin
    if qryURUNHAR.FieldByName('KDV').AsInteger <> 0 then
    qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency :=
    (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency-qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency)
    * (qryURUNHAR.FieldByName('KDV').AsInteger / 100);
  end
  else
  begin
    qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency := 0;
  end;

end;

procedure TfrmIRSALIYE.txtUrunKoduKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key= VK_F4 Then txtUrunKoduButtonClick(Sender);
end;

procedure TfrmIRSALIYE.txtDepoKodButtonClick(Sender: TObject);
var
  Depo_Kod,Depo_Ad:String;
begin
  if not (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Depo(Depo_Kod,Depo_Ad) then
  begin
    with qryURUNHAR do
    begin
      FieldByName('DEPO_KOD').AsString := Depo_Kod;
      FieldByName('DEPO_AD').AsString := Depo_Ad;
    end;
  end;
end;

procedure TfrmIRSALIYE.txtDepoKodKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
 if key= VK_F4 Then txtDepoKodButtonClick(self);
end;

procedure TfrmIRSALIYE.dtsURUNHARDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
var
  DOV_KUR:Currency;
begin
  if Assigned( Field ) then
  begin
    if (Field.FieldName='DOVKOD') then
    begin
      DOV_KUR := DataMod.Get_Doviz_Kur(qryURUNHAR.FieldByName('DOVKOD').AsString,qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
      if DOV_KUR<>0 then
      begin
        qryURUNHAR.FieldByName('DOVKUR').AsCurrency := DOV_KUR ;
      end
      else
      begin
        qryURUNHAR.FieldByName('DOVKUR').AsCurrency := 1 ;
        KalemHesapla;
      end;
    end;
//****************************************************************************//
    if  (Field.FieldName='DOVKUR') then
    begin
      KalemHesapla;
    end;
//****************************************************************************//
    if  (Field.FieldName='MIKTAR') then
    begin
      KalemHesapla;
    end;
//****************************************************************************//
    if  (Field.FieldName='BIRIM_FIY') then
    begin
      KalemHesapla;
    end;
//****************************************************************************//
    if  (Field.FieldName='KDV') then
    begin
      KalemHesapla;
    end;
//****************************************************************************//
    if ((Field.FieldName='ISKONTO_ORAN') and (qryURUNHAR.FieldByName('ISKONTO_TIP').AsSmallInt=0)) then
    begin
      KalemHesapla;
    end;
//****************************************************************************//
    if ((Field.FieldName='ISKONTO_TUTAR') and (qryURUNHAR.FieldByName('ISKONTO_TIP').AsSmallInt=1)) then
    begin
      KalemHesapla;
    end;

    if (Field.FieldName='OLCUBIRIM') then
    begin
        FN_BIRIMFIYAT;
    end;
        
//****************************************************************************//
  end; //Assigned( Field ) Then
end;


procedure TfrmIRSALIYE.FN_BIRIMFIYAT;
var
  Birim:Currency;
  qryURUN:TIB_Query; ErrMsg:PChar;
  Urun_Kod,Urun_Ad,DOVKOD,OlcuBirim, Depo_Kod, Depo_Ad:String;
  KDV_TUTAR,Fiyat:Currency;
  KDV,KDV_DAHIL:Byte;
begin
     if DataMod.GET_URUN_FAT_BILGI(trnFAT_IRS,
                                  qryURUNHAR.FieldByName('URUN_KOD').AsString,
                                  qryFAT_IRS.FieldByName('CARI_KOD').AsString,
                                  prv_FAT_TIP,
                                  prv_ISN,
                                  Fiyat,
                                  DOVKOD,
                                  Urun_Ad,
                                  OlcuBirim,
                                  Depo_Kod,
                                  Depo_Ad,
                                  KDV,
                                  KDV_TUTAR,
                                  KDV_DAHIL) then
     begin
       datamod.OLCUBIRIM_DONUSTUR(qryURUNHAR.fieldbyname('OLCUBIRIM').AsString,1,OlcuBirim,Birim);
       qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency :=Birim*Fiyat;
     end;
end;

procedure TfrmIRSALIYE.txtUrunKoduEnter(Sender: TObject);
begin
  txtUrunKodu.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.KDV_Hesapla;
var
  temp:Array [1..5] of TKDV;
  i,j,Sayac:Integer;
  TopKDV,BURUTTOP,KALISKONTOTOP:Currency;
begin
  //qryURUNHAR.DisableControls;
  dtsURUNHAR.DisableControls;
  prv_MY_Index:=-1;
  sayac := 1;
//****************************************************************************//
  for i:=1 to 6 do
  begin
    arr_KDV[i].KDV:=-1;
    arr_KDV[i].KDVTUTAR:=0;
  end;
//****************************************************************************//
  qryURUNHAR.First;
  BURUTTOP := 0;
  KALISKONTOTOP := 0;
//****************************************************************************//
  while not qryURUNHAR.Eof do
  begin
//****************************************************************************//
    for i:=1 to 5 do
    begin
      if arr_KDV[i].KDV=qryURUNHAR.FieldByName('KDV').AsSmallInt Then
      begin
        prv_MY_Index:=i;
        Break;
      end
      else
      begin
        prv_MY_Index:=-1;
      end;
    end;
//****************************************************************************//
    if prv_MY_Index=-1 Then
    begin
      arr_KDV[sayac].KDV := qryURUNHAR.FieldByName('KDV').AsSmallInt ;
      arr_KDV[sayac].KDVTUTAR :=
      (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency -qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency)*  qryURUNHAR.FieldByName('KDV').AsSmallInt/100;
      BURUTTOP := BURUTTOP + qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency;
      KALISKONTOTOP := KALISKONTOTOP + qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
      inc(Sayac);
    end
    else
    begin
      arr_KDV[prv_MY_Index].KDVTUTAR :=
      arr_KDV[prv_MY_Index].KDVTUTAR +
      ((qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency-qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) *  qryURUNHAR.FieldByName('KDV').AsSMallInt/100);
      BURUTTOP := BURUTTOP + qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency;
      KALISKONTOTOP := KALISKONTOTOP + qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
    end;
//****************************************************************************//
    qryURUNHAR.Next;
  end;
//****************************************************************************//
  qryURUNHAR.First;
  //qryURUNHAR.EnableControls;
  dtsURUNHAR.EnableControls;
//****************************************************************************//
  ////siralama
  for i:=1 to 4 Do
  begin
//****************************************************************************//
    for j:=i to 5 do
    begin
      if arr_KDV[i].KDV>arr_KDV[j].KDV then
      begin
        temp[i]:=arr_KDV[i];
        arr_KDV[i]:=arr_KDV[j];
        arr_KDV[j]:=temp[i];
      end;
    end;
//****************************************************************************//
  end;
//****************************************************************************//
  if qryFAT_IRS.State in [dssEdit,dssInsert] then
  begin
    with qryFAT_IRS do
    begin
      FieldByName('KDV1_ORAN').AsSmallint := 0;
      FieldByName('KDV2_ORAN').AsSmallint := 0;
      FieldByName('KDV3_ORAN').AsSmallint := 0;
      FieldByName('KDV4_ORAN').AsSmallint := 0;
      FieldByName('KDV5_ORAN').AsSmallint := 0;
      FieldByName('KDV1').AsCurrency := 0;
      FieldByName('KDV2').AsCurrency := 0;
      FieldByName('KDV3').AsCurrency := 0;
      FieldByName('KDV4').AsCurrency := 0;
      FieldByName('KDV5').AsCurrency := 0;
    end;
    /// s?ralama sonu
    Sayac := 0;
    TopKDV := 0 ;
//****************************************************************************//
    for i:=1 to 5 do
    begin
//****************************************************************************//
      if arr_KDV[i].KDV<>-1 Then
      begin
        inc(Sayac);
//****************************************************************************//
        if  prv_KDV_HESAPLA then // KDV Hesaplamamas? gerekiyorsa veri atm?yor
        begin
          qryFAT_IRS.FieldByName('KDV'+ IntToStr(sayac) + '_ORAN').AsSmallint:=arr_KDV[i].KDV;
          qryFAT_IRS.FieldByName('KDV'+ IntToStr(sayac)).AsCurrency :=arr_KDV[i].KDVTUTAR ;
        end;
//****************************************************************************//
        TopKDV := TopKDV +  arr_KDV[i].KDVTUTAR ;
//****************************************************************************//
      end;
//****************************************************************************//
    end;
//****************************************************************************//
    if  prv_KDV_HESAPLA then qryFAT_IRS.FieldByName('KDV_TOP').AsCurrency := TopKDV;
//****************************************************************************//
    with qryFAT_IRS do
    begin
      FieldByName('BRUT_TOP').AsCurrency := BURUTTOP;
      FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency := KALISKONTOTOP;
      FieldByName('NET_TOP').AsCurrency := qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency -(qryFAT_IRS.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency +qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency);
      FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := qryFAT_IRS.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency + qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
      FieldByName('GENEL_TOP').AsCurrency := qryFAT_IRS.FieldByName('NET_TOP').AsCurrency + qryFAT_IRS.FieldByName('KDV_TOP').AsCurrency ;
    end;
//****************************************************************************//
  end;
end;

procedure TfrmIRSALIYE.dtsFAT_IRSStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    if ADataset.State = dssEDIT then
    begin
      btnFaturaSil.Enabled := True;
      cmbFATURA_TIP.Enabled := False;
    end
    else
    begin
      btnFaturaSil.Enabled := False;
      cmbFATURA_TIP.Enabled := True;
    end;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnTRN_KAYDET.Enabled := True;
    btnTRN_IPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    {if ADataset.RecordCount > 0 then
    begin
      btnFaturaSil.Enabled := True
    end
    else
    begin
      btnFaturaSil.Enabled := False;
    end;}
    if qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger<=0 then
      btnFaturaSil.Enabled := False
    else
      btnFaturaSil.Enabled := True;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
  end;
end;

procedure TfrmIRSALIYE.dtsFAT_IRSDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  if Assigned( Field ) then
  begin
//****************************************************************************//
    if ((Field.FieldName='VADE_TARIH') or (Field.FieldName='TARIH')) then
    begin
      if ((qryFAT_IRS.FieldByName('VADE_TARIH').AsString<>'') and (qryFAT_IRS.FieldByName('TARIH').AsString<>'')) then
      begin
        qryFAT_IRS.FieldByName('VADE_GUN').AsDouble := (qryFAT_IRS.FieldByName('VADE_TARIH').AsDate-qryFAT_IRS.FieldByName('TARIH').AsDate);
      end;
    end;
//****************************************************************************//
    if ((Field.FieldName='ISKONTO_ORAN') and (qryFAT_IRS.FieldByName('ISKONTO_TIP').AsSmallInt=0)) then
    begin
      qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qryFAT_IRS.FieldByName('ISKONTO_ORAN').AsInteger *(qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency/100);
      qryFAT_IRS.FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency + qryFAT_IRS.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency;
      FaturaToplamHesapla;
    end;
//****************************************************************************//
    if ((Field.FieldName='ISKONTO_TUTAR_VPB') and (qryFAT_IRS.FieldByName('ISKONTO_TIP').AsSmallInt=1)) then
    begin
      qryFAT_IRS.FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency + qryFAT_IRS.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency;
      FaturaToplamHesapla;
    end;
//****************************************************************************//
    if (Field.FieldName='OTV') then
    begin
      FaturaToplamHesapla;
    end;
//****************************************************************************//
    if (Field.FieldName = 'FAT_IRS_TIP') then
    begin
      //sat?? faturas? ve ithalat ihracat ise
      if (qryFAT_IRS.FieldByName('TIP').AsInteger = 1) and (qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsInteger = 4) then
      begin
        prv_KDV_HESAPLA := False
      end
      else
      begin
        prv_KDV_HESAPLA := True;
      end;
    end;
//****************************************************************************//
  end;// assigned(field) then end;
end;

procedure TfrmIRSALIYE.FaturaToplamHesapla;
begin
  with qryFAT_IRS do
  begin
    FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency+FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
    FieldByName('NET_TOP').AsCurrency := FieldByName('BRUT_TOP').AsCurrency -(FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency+FieldByName('ISKONTO_TUTAR_VPB').AsCurrency);
    FieldByName('GENEL_TOP').AsCurrency := FieldByName('NET_TOP').AsCurrency + FieldByName('KDV_TOP').AsCurrency+FieldByName('OTV').AsCurrency;
  end;
end;

procedure TfrmIRSALIYE.txtKasaKodButtonClick(Sender: TObject);
var
  Kasa_Kod,Kasa_Ad,DOVKOD:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_KASA(Kasa_Kod,Kasa_Ad,DOVKOD) Then
  begin
    with qryFAT_IRS do
    begin
      FieldByName('KASA_KOD').AsString:=Kasa_Kod;
      FieldByName('KASA_AD').AsString:=Kasa_Ad;
    end;
  end;
end;

procedure TfrmIRSALIYE.EkAciklamaOpen ;
var
  my_lblTop,my_txtTop,my_lblTopA,my_txtTopA:Integer;
begin
  with DataMod.qryGENEL do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM FAT_PARAMS');
    Active := True;
  end;
  my_lblTop := 2;
  my_txtTop := 13;
  my_lblTopA := 31;
  my_txtTopA  := 31;
  if not ((DataMod.qryGENEL.Bof) and (DataMod.qryGENEL.Eof)) then /// b?yle bi ?ey olmazki salak
  begin
    if DataMod.qryGENEL.FieldByName('EK_ACK_KUL').AsSmallint = 0 then
    begin
      tabAciklama.Enabled := False;
    end
    else
    begin
      tabAciklama.Enabled := True;
      with qryFAT_IRS_ACK do
      begin
        Active := False;
        ParamByName('PRM_FAT_IRS_SEP').AsInteger := qryFAT_IRS.FieldbyName('FAT_IRS_SEP').AsInteger;
        ParamByName('PRM_FAT_IRS_ID').AsInteger := qryFAT_IRS.FieldbyName('FAT_IRS_ID').AsInteger;
        ParamByName('PRM_FAT_IRS_SID').AsInteger := qryFAT_IRS.FieldbyName('FAT_IRS_SID').AsInteger;
        Active := True;
      end;

      if ((qryFAT_IRS_ACK.Bof) and (qryFAT_IRS_ACK.Eof)) then
      begin
//****************************************************************************//
        with qryFAT_IRS_ACK do
        begin
          Insert;
          FieldByName('FAT_IRS_SEP').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SEP').AsInteger;
          FieldByName('FAT_IRS_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
          FieldByName('FAT_IRS_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
        end;
//****************************************************************************//

        if DataMod.qryGENEL.FieldByName('ACK_30K_1_KUL').AsSmallint = 0 then
        begin
          lblAck301.Visible := False;
          txtAck301.Visible := False;
        end
        else
        begin
          lblAck301.Top := my_lblTop ;
          txtAck301.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_30K_1_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_30K_1_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_30K_2_KUL').AsSmallint = 0 then
        begin
          lblAck302.Visible := False;
          txtAck302.Visible := False;
        end;
//****************************************************************************//
        qryFAT_IRS_ACK.FieldByName('ACK_30K_2_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_30K_2_CAP').AsString;
        if DataMod.qryGENEL.FieldByName('ACK_30K_3_KUL') .AsSmallint =0 then
        begin
          lblAck303.Visible := False;
          txtAck303.Visible := False;
        end
        else
        begin
          lblAck303.Top := my_lblTop ;
          txtAck303.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_30K_3_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_30K_3_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_1_KUL') .AsSmallint =0 then
        begin
          lblAck501.Visible := False;
          txtAck501.Visible := False;
        end
        else
        begin
          lblAck501.Top := my_lblTop ;
          txtAck501.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_50K_1_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_50K_1_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_2_KUL') .AsSmallint =0 then
        begin
          lblAck502.Visible := False;
          txtAck502.Visible := False;
        end
        else
        begin
          lblAck502.Top := my_lblTop ;
          txtAck502.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_50K_2_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_50K_2_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_3_KUL') .AsSmallint =0 then
        begin
          lblAck503.Visible := False;
          txtAck503.Visible := False;
        end
        else
        begin
          lblAck503.Top := my_lblTop ;
          txtAck503.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_50K_3_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_50K_3_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_4_KUL') .AsSmallint =0 then
        begin
          lblAck504.Visible := False;
          txtAck504.Visible := False;
        end
        else
        begin
          lblAck504.Top := my_lblTop ;
          txtAck504.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_50K_4_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_50K_4_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_5_KUL') .AsSmallint =0 then
        begin
          lblAck505.Visible := False;
          txtAck505.Visible := False;
        end
        else
        begin
          lblAck505.Top := my_lblTop ;
          txtAck505.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_50K_5_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_50K_5_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_1_KUL') .AsSmallint =0 then
        begin
          lblAck1001.Visible := False;
          txtAck1001.Visible := False;
        end
        else
        begin
          lblAck1001.Top := my_lblTop ;
          txtAck1001.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_100K_1_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_100K_1_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_2_KUL') .AsSmallint =0 then
        begin
          lblAck1002.Visible := False;
          txtAck1002.Visible := False;
        end
        else
        begin
          lblAck1002.Top := my_lblTop ;
          txtAck1002.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_100K_2_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_100K_2_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_3_KUL') .AsSmallint =0 then
        begin
          lblAck1003.Visible := False;
          txtAck1003.Visible := False;
        end
        else
        begin
          lblAck1003.Top := my_lblTop ;
          txtAck1003.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_100K_3_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_100K_3_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_4_KUL') .AsSmallint =0 then
        begin
          lblAck1004.Visible := False;
          txtAck1004.Visible := False;
        end
        else
        begin
          lblAck1004.Top := my_lblTop ;
          txtAck1004.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
          qryFAT_IRS_ACK.FieldByName('ACK_100K_4_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_100K_4_CAP').AsString;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_5_KUL') .AsSmallint =0 then
        begin
          lblAck1005.Visible := False;
          txtAck1005.Visible := False;
        end
        else
        begin
          lblAck1005.Top := my_lblTop ;
          txtAck1005.Top := my_txtTop ;
          qryFAT_IRS_ACK.FieldByName('ACK_100K_5_CAP').AsString := DataMod.qryGENEL.FieldByName('ACK_100K_5_CAP').AsString;
        end;
//****************************************************************************//
      end
      else
      begin
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_30K_1_KUL').AsSmallint = 0 then
        begin
          lblAck301.Visible := False;
          txtAck301.Visible := False;
        end
        else
        begin
          lblAck301.Top := my_lblTop ;
          txtAck301.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_30K_2_KUL').AsSmallint = 0 then
        begin
          lblAck302.Visible := False;
          txtAck302.Visible := False;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_30K_3_KUL') .AsSmallint =0 then
        begin
          lblAck303.Visible := False;
          txtAck303.Visible := False;
        end
        else
        begin
          lblAck303.Top := my_lblTop ;
          txtAck303.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_1_KUL') .AsSmallint =0 then
        begin
          lblAck501.Visible := False;
          txtAck501.Visible := False;
        end
        else
        begin
          lblAck501.Top := my_lblTop ;
          txtAck501.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_2_KUL') .AsSmallint =0 then
        begin
          lblAck502.Visible := False;
          txtAck502.Visible := False;
        end
        else
        begin
          lblAck502.Top := my_lblTop ;
          txtAck502.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_3_KUL') .AsSmallint =0 then
        begin
          lblAck503.Visible := False;
          txtAck503.Visible := False;
        end
        else
        begin
          lblAck503.Top := my_lblTop ;
          txtAck503.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_4_KUL') .AsSmallint =0 then
        begin
          lblAck504.Visible := False;
          txtAck504.Visible := False;
        end
        else
        begin
          lblAck504.Top := my_lblTop ;
          txtAck504.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_50K_5_KUL') .AsSmallint =0 then
        begin
          lblAck505.Visible := False;
          txtAck505.Visible := False;
        end
        else
        begin
          lblAck505.Top := my_lblTop ;
          txtAck505.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_1_KUL') .AsSmallint =0 then
        begin
          lblAck1001.Visible := False;
          txtAck1001.Visible := False;
        end
        else
        begin
          lblAck1001.Top := my_lblTop ;
          txtAck1001.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_2_KUL') .AsSmallint =0 then
        begin
          lblAck1002.Visible := False;
          txtAck1002.Visible := False;
        end
        else
        begin
          lblAck1002.Top := my_lblTop ;
          txtAck1002.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_3_KUL') .AsSmallint =0 then
        begin
          lblAck1003.Visible := False;
          txtAck1003.Visible := False;
        end
        else
        begin
          lblAck1003.Top := my_lblTop ;
          txtAck1003.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_4_KUL') .AsSmallint =0 then
        begin
          lblAck1004.Visible := False;
          txtAck1004.Visible := False;
        end
        else
        begin
          lblAck1004.Top := my_lblTop ;
          txtAck1004.Top := my_txtTop ;
          my_lblTop := my_lblTop + my_lblTopA ;
          my_txtTop := my_txtTop + my_txtTopA ;
        end;
//****************************************************************************//
        if DataMod.qryGENEL.FieldByName('ACK_100K_5_KUL') .AsSmallint =0 then
        begin
          lblAck1005.Visible := False;
          txtAck1005.Visible := False;
        end
        else
        begin
          lblAck1005.Top := my_lblTop ;
          txtAck1005.Top := my_txtTop ;
        end;
//****************************************************************************//
      end;
    end;
  end;
end;

procedure TfrmIRSALIYE.btnAraClick(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if frmFAT_IRS_SDLG.Form_Open(False,prv_FAT_IRS_SEP,FAT_IRS_ID,FAT_IRS_SID,prv_FAT_TIP,False) then
  begin
    DataSet_Open(FAT_IRS_ID,FAT_IRS_SID,1);
  end;
end;

procedure TfrmIRSALIYE.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmIRSALIYE.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmIRSALIYE.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.color :=clWindow;
end;

procedure TfrmIRSALIYE.txtCariKodEnter(Sender: TObject);
begin
  txtCariKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txtCariKodExit(Sender: TObject);
begin
  txtCariKod.Color := clWindow;
  if Trim(txtCariKod.Text) <> '' then
  begin
    if DataMod.FN_CariKOD2Bilgi(txtCariKod.Text,res_Cari) then
    begin
      if res_Cari[15]='0' Then
      begin
        grpBoxCari.Visible := True;
        grpBoxMuhtelif.Visible := False;
        Cari2Labels;
      end
      else
      begin
        if res_Cari[15]='1' Then
        begin
          qryFAT_IRS.FieldByName('MUHTELIF').AsSmallint := 1;
          grpBoxCari.Visible := False;
          grpBoxMuhtelif.Visible := True;
          txtCariKod.Enabled := False;
          MuhtelifIslemler;
        end;
      end;
    end
    else
    begin
      txtCariKod.SetFocus;
    end;
  end
  else
  begin
    grpBoxCari.Visible := False;
    grpBoxMuhtelif.Visible := False;
  end;


end;

procedure TfrmIRSALIYE.txtCariKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmIRSALIYE.txtCariKodKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if Key = VK_F4 Then txtCariKodButtonClick(Self);
end;

procedure TfrmIRSALIYE.IB_Edit24Enter(Sender: TObject);
begin
//  IB_Edit24.Color := glb_Art_Alan_Renk;
//  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
//  my_Active_Comp:=ActiveControl;
  IB_Edit24.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.IB_Edit24Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit24.Text)) = 0 then
  begin
    IB_Edit24.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit24,nil,3) then
  begin
    IB_Edit24.Color := clWindow;
  end
  else
  begin
    IB_Edit24.SetFocus;
  end;
      IB_Edit24.Color := clWindow;
end;

procedure TfrmIRSALIYE.txtProjeKodButtonClick(Sender: TObject);
var
  Proje_KOD,Proje_AD:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_Proje(Proje_KOD,Proje_AD,1) then
  begin
     with qryFAT_IRS do
     begin
       FieldByName('PROJE_KOD').AsString :=Proje_KOD;
       FieldByName('PROJE_AD').AsString :=Proje_AD;
     end;  
  end;
end;

procedure TfrmIRSALIYE.txtProjeKodEnter(Sender: TObject);
begin
  txtProjeKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txtProjeKodExit(Sender: TObject);
var
  Proje_Ad:String;
begin
  txtProjeKod.Color := clWindow;
  if Trim(txtProjeKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',qryFAT_IRS.FieldByName('PROJE_KOD').AsString,Proje_Ad) Then
    begin
      qryFAT_IRS.FieldByName('PROJE_AD').AsString := PROJE_Ad;
    end
    else
    begin
      qryFAT_IRS.FieldByName('PROJE_AD').AsString := '';
      txtProjeKod.SetFocus;
    end;
  end
  else
  begin
    qryFAT_IRS.FieldByName('PROJE_AD').AsString := '';
  end;
end;

procedure TfrmIRSALIYE.txtProjeKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 Then txtProjeKodButtonClick(Self);
end;

procedure TfrmIRSALIYE.txtPlasiyerKodKeyUp(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
  if Key = VK_F4 Then txtPlasiyerKodButtonClick(self);
end;

procedure TfrmIRSALIYE.txtFaturaDepoKodEnter(Sender: TObject);
begin
  txtFaturaDepoKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txtFaturaDepoKodExit(Sender: TObject);
var
  Depo_Ad:String;
begin
  txtFaturaDepoKod.Color := clWindow;
  if qryFAT_IRS.ReadOnly then Exit;  
  if Trim(txtFaturaDepoKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('DEPO','DEPO_KOD','ADI',qryFAT_IRS.FieldByName('DEPO_KOD').AsString,Depo_Ad) Then
    begin
      qryFAT_IRS.FieldByName('DEPO_AD').AsString := Depo_Ad;
    end
    else
    begin
      qryFAT_IRS.FieldByName('DEPO_AD').AsString := '';
      txtFaturaDepoKod.SetFocus;
    end;
  end
  else
  begin
    qryFAT_IRS.FieldByName('DEPO_AD').AsString := '';
  end;
end;

procedure TfrmIRSALIYE.txtFaturaDepoKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtFaturaDepoKodButtonClick(Self);
end;

procedure TfrmIRSALIYE.cmbFATURA_TIPEnter(Sender: TObject);
begin
  cmbFATURA_TIP.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.cmbFATURA_TIPExit(Sender: TObject);
begin
  cmbFATURA_TIP.Color := clWindow;
end;

procedure TfrmIRSALIYE.txtPlasiyerKodEnter(Sender: TObject);
begin
  txtPlasiyerKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txtPlasiyerKodExit(Sender: TObject);
var
  Plasiyer_Ad:String;
begin
  txtPlasiyerKod.Color := clWindow;
  if qryFAT_IRS.ReadOnly then Exit;
  if Trim(txtPlasiyerKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',qryFAT_IRS.FieldByName('PLASIYER_KOD').AsString,Plasiyer_Ad) Then
    begin
      qryFAT_IRS.FieldByName('PLASIYER_AD').AsString := Plasiyer_Ad;
    end
    else
    begin
      qryFAT_IRS.FieldByName('PLASIYER_AD').AsString := '';
      txtPlasiyerKod.SetFocus;
    end;
  end
  else
  begin
    qryFAT_IRS.FieldByName('PLASIYER_AD').AsString := '';
  end;
end;

procedure TfrmIRSALIYE.btnFaturaSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmIRSALIYE.rdIskontoChange(Sender: TObject);
begin
//****************************************************************************//
  if rdIskonto.ItemIndex=0 then
  begin
     txtIskontoOran.Enabled := True;
     txtIskontoTutar.Enabled := False;
  end
  else
  begin
    txtIskontoTutar.Enabled := True;
    txtIskontoOran.Enabled := False;
  end;
//****************************************************************************//
  if qryURUNHAR.State in [dssEdit,dssInsert] Then
  begin
    with qryURUNHAR do
    begin
      FieldByName('ISKONTO_ORAN').AsString := '';
      FieldByName('ISKONTO_TUTAR').AsString := '';
    end;
  end;
//****************************************************************************//
end;

procedure TfrmIRSALIYE.rdFatIsTipChange(Sender: TObject);
begin
  if rdFatIsTip.ItemIndex=0 Then
  begin
    txtFatIskontoOran.Enabled := True;
    txtFatIskontoTutar.Enabled := False;
    txtFatIskontoTutar.Text := '0';
  end
  else
  begin
    txtFatIskontoTutar.Enabled := True;
    txtFatIskontoOran.Enabled := False;
    txtFatIskontoOran.Text := '0';
  end;
end;

procedure TfrmIRSALIYE.txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmIRSALIYE.txtUrunKoduExit(Sender: TObject);
var
 KDV_TUTAR,Fiyat:Currency;
 DOVKOD,Urun_Ad,OlcuBirim,Depo_Kod,Depo_Ad:String;
 KDV,KDV_DAHIL:Byte;
begin
  txtUrunKodu.Color := clWindow;
  if not (qryURUNHAR.State in [dssEdit,dssInsert]) then exit;
//****************************************************************************//
  if Trim(txtUrunKodu.Text) <> '' then
  begin
    if DataMod.GET_URUN_FAT_BILGI(trnFAT_IRS,
                                  txtUrunKodu.Text,
                                  qryFAT_IRS.FieldByName('CARI_KOD').AsString,
                                  prv_FAT_TIP,
                                  prv_ISN,
                                  Fiyat,
                                  DOVKOD,
                                  Urun_Ad,
                                  OlcuBirim,
                                  Depo_Kod,
                                  Depo_Ad,
                                  KDV,
                                  KDV_TUTAR,
                                  KDV_DAHIL) then
    begin
      if Trim(qryURUNHAR.FieldByName('URUN_AD').AsString) <> Urun_Ad then
      // Ayn? ise bilgiler le oynama
      begin

        with qryURUNHAR do
        begin
          FieldByName('URUN_AD').AsString := Urun_Ad;
          FieldByName('ACIKLAMA').AsString := Urun_Ad;
          FieldByName('BIRIM_FIY').AsCurrency := Fiyat;
          FieldByName('DOVKOD').AsString := DOVKOD;
          FieldByName('OLCUBIRIM').AsString := OlcuBirim;
        end;

        if (Trim(qryURUNHAR.FieldByName('DEPO_KOD').AsString) = '') AND glb_DEPO_UYG Then
        begin
          with qryURUNHAR do
          begin
            FieldByName('DEPO_KOD').AsString := Depo_Kod;
            FieldByName('DEPO_AD').AsString := Depo_Ad;
          end;
        end;

        if prv_KDV_HESAPLA then
        begin
          with qryURUNHAR do
          begin
            FieldByName('KDV').AsSmallInt := KDV;
            FieldByName('KDV_TUTAR').AsCurrency  := KDV_TUTAR;
          end;
        end
        else
        begin
          with qryURUNHAR do
          begin
            FieldByName('KDV').AsSmallInt := 0;
            FieldByName('KDV_TUTAR').AsCurrency  := 0;
          end;
        end;
      end;
    end
    else
    begin
      txtUrunKodu.SetFocus;
      txtUrunKoduButtonClick(Self);
    end;
  end
  else
  begin
    {
    if qryURUNHAR.State in [dssEdit,dssInsert] Then
    begin
      qryURUNHAR.FieldByName('URUN_AD').AsString := '';
      qryURUNHAR.FieldByName('ACIKLAMA').AsString := '';
      qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency := 0;
      qryURUNHAR.FieldByName('DOVKOD').AsString := glb_DEFCUR;
      qryURUNHAR.FieldByName('OLCUBIRIM').AsString := '';
      qryURUNHAR.FieldByName('DEPO_KOD').AsString := '';
      qryURUNHAR.FieldByName('DEPO_AD').AsString := '';
      if prv_KDV_HESAPLA then
         qryURUNHAR.FieldByName('KDV').AsSmallInt := 18
      else
        qryURUNHAR.FieldByName('KDV').AsSmallInt := 0;
    end;
    }
  end;
end;

procedure TfrmIRSALIYE.txtDepoKodEnter(Sender: TObject);
begin
  txtDepoKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txtDepoKodExit(Sender: TObject);
var
  Depo_Ad:String;
begin
  txtDepoKod.Color := clWindow;
  if Trim(txtDepoKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('DEPO','DEPO_KOD','ADI',qryURUNHAR.FieldByName('DEPO_KOD').AsString,Depo_Ad) Then
    begin
      qryURUNHAR.FieldByName('DEPO_AD').AsString := Depo_Ad;
    end
    else
    begin
      qryURUNHAR.FieldByName('DEPO_AD').AsString := '';
      txtDepoKod.SetFocus;
    end;
  end
  else
  begin
    qryURUNHAR.FieldByName('DEPO_AD').AsString := '';
  end;
end;

procedure TfrmIRSALIYE.txtDepoKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmIRSALIYE.txtOlcuBirimButtonClick(Sender: TObject);
var
  OlcuBir,strSQL:String;
begin
  if not (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if qryURUNHAR.FieldByName('URUN_KOD').AsString <> '' Then
  begin
    strSQL:='SELECT OLCU_TIP FROM URUN WHERE URUN_KOD='+ SQL_Katar(qryURUNHAR.FieldByName('URUN_KOD').AsString);
    with DataMod.qryGENEL do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True ;
    end;

    if DataMod.LS_OlcuBrm(DataMod.qryGenel.FieldByname('OLCU_TIP').AsString  ,OlcuBir) then
    begin
      if not (qryURUNHAR.State in [dssEdit,dssInsert])then qryURUNHAR.Edit;
      qryURUNHAR.FieldByName('OLCUBIRIM').AsString := OlcuBir;
    end;
  end
  else
  begin
     Application.MessageBox('?r?n Se?meden ?l?? Birimi Se?emezsiniz','D?KKAT',MB_ICONINFORMATION);
  end;
end;

procedure TfrmIRSALIYE.txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuBirim_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmIRSALIYE.txtOlcuBirimExit(Sender: TObject);
var
  strSQL:string;
  OLCU_TIP:String;
begin
  txtOlcuBirim.Color := clWindow;
  if Trim(txtOlcuBirim.Text)<>'' then
  begin
    if prv_OlcuBirim_Kontrol=True then
    begin
      strSQL:='SELECT OLCU_TIP FROM URUN WHERE URUN_KOD='+SQL_Katar(qryURUNHAR.FieldByName('URUN_KOD').AsString);
//****************************************************************************//
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add(strSQL);
        Active := True;
      end;
//****************************************************************************//
      OLCU_TIP:=DataMod.qryGenel.FieldByname('OLCU_TIP').AsString;
//****************************************************************************//
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT * FROM OLCUBIR WHERE OLCU_TIP=' + SQL_Katar(OLCU_TIP)
              + ' AND OLCUBIRIM = '+ SQL_Katar(qryURUNHAR.FieldByName('OLCUBIRIM').AsString));
        Active := True;
      end;
//****************************************************************************//
      if not ((DataMod.qryGENEL.Bof) And (DataMod.qryGENEL.Eof)) Then
      begin
        prv_OlcuBirim_Kontrol := False;
      end
      else
      begin
        prv_OlcuBirim_Kontrol := True;
        txtOlcuBirim.SetFocus;
      end;
//****************************************************************************//
    end;
  end
  else
  begin
    prv_OlcuBirim_Kontrol := True;
  end;
end;

procedure TfrmIRSALIYE.txtOlcuBirimEnter(Sender: TObject);
begin
  txtOlcuBirim.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txtOlcuBirimKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key= VK_F4 then  txtOlcuBirimButtonClick(Self);
end;

procedure TfrmIRSALIYE.txtFaturaDepoKodKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmIRSALIYE.txtPlasiyerKodKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmIRSALIYE.txtProjeKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmIRSALIYE.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if dtsFAT_IRS.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('?rsaliye bilgileri b?l?m?nde yapt???n?z de?i?iklikleri kaydeniniz veya iptal ediniz.','D?KKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmIRSALIYE.txtKasaKodEnter(Sender: TObject);
begin
  txtKasaKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txtKasaKodExit(Sender: TObject);
var
  Kasa_Ad:String;
begin
  if not (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    txtKasaKod.Color := clWindow;
    exit;
  end;

  txtKasaKod.Color := clWindow;

  if Trim(txtKasaKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('KASA','KASA_KOD','ACIKLAMA',qryFAT_IRS.FieldByName('KASA_KOD').AsString,Kasa_Ad) Then
    begin
      qryFAT_IRS.FieldByName('KASA_AD').AsString := KASA_Ad;
    end
    else
    begin
      qryFAT_IRS.FieldByName('KASA_AD').AsString := '';
      txtKasaKod.SetFocus;
    end;
  end
  else
  begin
    qryFAT_IRS.FieldByName('KASA_AD').AsString := '';
  end;

end;

procedure TfrmIRSALIYE.txtKasaKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmIRSALIYE.txtKasaKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtKasaKodButtonClick(Self);
end;

procedure TfrmIRSALIYE.FormResize(Sender: TObject);
begin
  btnCikis.Left := frmIRSALIYE.Width  - (btnCikis.Width + 25 );
  btnAra.Left := frmIRSALIYE.Width  - ( btnCikis.Width + btnAra.Width + 28 );
end;





function TfrmIRSALIYE.URUN_HAR_SIL:Boolean;
var
  qryS_URUNHAR:TIB_Query;
//  URUN_HAR_TIP:Char;
begin
  DataMod.CreateQuery(qryS_URUNHAR,trnFAT_IRS,False,DataMod.dbaMain);
  with qryS_URUNHAR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM URUNHAR WHERE IRSALIYE_ID = '+ qryFAT_IRS.FieldByName('FAT_IRS_ID').AsString + ' AND IRSALIYE_SID = ' + qryFAT_IRS.FieldByName('FAT_IRS_SID').AsString);
    Active := True;
  end;

  if qryS_URUNHAR.RecordCount = 0 then
  begin
    Result := True;
    Exit;
  end;
  qryS_URUNHAR.First;
  while not qryS_URUNHAR.Eof Do
  begin
//****************************************************************************//
//alttaki kodlar kullan?lm?yor.asagidaki bilgi kullan?l?yor.
//qryURUNHAR.FieldByName('TIP').AsString[1]
//        if prv_FAT_TIP = 1 then
//           URUN_HAR_TIP := ALACAK
//        else
//           URUN_HAR_TIP := BORC;
//****************************************************************************//
    if (Trim(qryS_URUNHAR.FieldByName('URUN_KOD').AsString) <> '') and (qryS_URUNHAR.FieldByName('FATURA_ID').AsInteger = 0) then
    begin
      if not DataMod.URUN_HAR_AUD(trnFAT_IRS,
                                  qryS_URUNHAR.FieldByName('URUN_KOD').AsString,
                                  qryS_URUNHAR.FieldByName('DEPO_KOD').AsString,
                                  qryS_URUNHAR.FieldByName('TIP').AsString[1],
                                  (0 - qryS_URUNHAR.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency),
                                  (0 - qryS_URUNHAR.FieldByName('TUTAR_VPB').AsCurrency),
                                  (0 - qryS_URUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency)) then
      begin
        Result := False;
        Exit;
      end;
    end;
    qryS_URUNHAR.Next;
  end;//while end
  Result := True;
end;

procedure TfrmIRSALIYE.ApplyDatasets;
begin
  qryFAT_IRS.ApplyUpdates;
  qryFAT_IRS.CommitUpdates;

  qryURUNHAR.ApplyUpdates;
  qryURUNHAR.CommitUpdates;

  qryFAT_IRS_MUH_CARI.ApplyUpdates;
  qryFAT_IRS_MUH_CARI.CommitUpdates;

  qryFAT_IRS_ACK.ApplyUpdates;
  qryFAT_IRS_ACK.CommitUpdates;
end;

procedure TfrmIRSALIYE.CommitUpdates;
begin
  qryFAT_IRS_MUH_CARI.Close;
  qryFAT_IRS_ACK.Close;
  qryURUNHAR.Close;
  qryFAT_IRS.Close;
end;

procedure TfrmIRSALIYE.CancelUpdates;
begin
  qryFAT_IRS_MUH_CARI.CancelUpdates;
  qryFAT_IRS_ACK.CancelUpdates;
  qryURUNHAR.CancelUpdates;
  qryFAT_IRS.CancelUpdates;
  qryFAT_IRS_MUH_CARI.CommitUpdates;
  qryFAT_IRS_ACK.CommitUpdates;
  qryURUNHAR.CommitUpdates;
  qryFAT_IRS.CommitUpdates;
end;

procedure TfrmIRSALIYE.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  case pgFAT_IRS.ActivePageIndex of
  0:
    begin
      if Shift = [ssCtrl] then
      begin                
        case Key Of
        35:  ///end transaction kaydet
          begin
            if btnTRN_KAYDET.Enabled Then btnTRN_KAYDETClick(self);
          end; // 35 End;
        65://   A transaction iptal
          begin
            if btnTRN_IPTAL.Enabled Then btnTRN_IPTALClick(Self);
          end;
        46: // del delete
          begin
            if btnFaturaSil.Enabled Then btnFaturaSilClick(self);
          end;
        end; //case end;
      end;// Shift = [ssCtrl] then end
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
  1:
    begin
      if Shift = [ssCtrl] then
      begin
        case Key of
        83: //s kaydet
          begin
            if btnKAYDET.Enabled Then btnKAYDETClick(Self);
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
            if btnEKLE.Enabled then btnEKLEClick(Self);
          end;
        end;//acase end
      end; ///if Shift = [] then ENd
    end;
  end;//end case pgFatura.ActivePageIndex of
  case Key of // F6
  117:pgFAT_IRS.SelectNextPage(True);
  end;
end;

Procedure TfrmIRSALIYE.FormatDisplays;
begin
//glb_DOV_FIELD_PF
  with frmIRSALIYE.qryURUNHAR do
  begin
    FieldByName('MIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('ISKONTO_TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ISKONTO_TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    case frmIRSALIYE.prv_FAT_TIP of
    1:FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    2:FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_KUR_PF;
    end;
//    FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_KUR_PF;
//    FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('KDV_TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
  end;
  with frmIRSALIYE.qryFAT_IRS do
  begin
    FieldByName('BRUT_TOP').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('NET_TOP').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('GENEL_TOP').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KDV_TOP').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KALEM_ISKONTO_TOPLAM_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ISKONTO_TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ISKONTO_TOPLAM_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KDV1').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KDV2').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KDV3').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KDV4').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KDV5').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('OTV').DisplayFormat := glb_VPB_FIELD_PF;
  end;
end;

procedure TfrmIRSALIYE.KalemBrutHesapla(Sil:Boolean);
var
  MyBookMark:String;
  MyBrutTop:Currency;
begin
  try
    MyBrutTop := 0;
    with qryURUNHAR do
    begin
       MyBookMark := Bookmark;
       DisableControls;
       First;
       while not eof do
       begin
         MyBrutTop := MyBrutTop + FieldByName('TUTAR_VPB').AsCurrency;
         Next;
       end;    // wh?le
       if Not sil then Bookmark := MyBookMark;
    end;    // w?th
    qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency := MyBrutTop;
  finally
    qryURUNHAR.EnableControls;
  end;
end;

procedure TfrmIRSALIYE.qryURUNHARAfterPost(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(False);
end;

procedure TfrmIRSALIYE.qryURUNHARAfterDelete(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(True);
end;

procedure TfrmIRSALIYE.IB_Edit5ButtonClick(Sender: TObject);
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qryFAT_IRS.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmIRSALIYE.IB_Edit6ButtonClick(Sender: TObject);
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qryFAT_IRS.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmIRSALIYE.IB_Edit7ButtonClick(Sender: TObject);
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qryFAT_IRS.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmIRSALIYE.IB_Edit24ButtonClick(Sender: TObject);
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qryFAT_IRS.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmIRSALIYE.IB_Edit25ButtonClick(Sender: TObject);
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qryFAT_IRS.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmIRSALIYE.IB_Edit5Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit5.Text)) = 0 then
  begin
    IB_Edit5.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit5,nil,0) then
  begin
    IB_Edit5.Color := clWindow;
  end
  else
  begin
    IB_Edit5.SetFocus;
  end;
    IB_Edit5.Color := clWindow;  
end;

procedure TfrmIRSALIYE.IB_Edit6Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit6.Text)) = 0 then
  begin
    IB_Edit6.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit6,nil,1) then
  begin
    IB_Edit6.Color := clWindow;
  end
  else
  begin
    IB_Edit6.SetFocus;
  end;
    IB_Edit6.Color := clWindow;
end;

procedure TfrmIRSALIYE.IB_Edit7Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit7.Text)) = 0 then
  begin
    IB_Edit7.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit7,nil,2) then
  begin
    IB_Edit7.Color := clWindow;
  end
  else
  begin
    IB_Edit7.SetFocus;
  end;
    IB_Edit7.Color := clWindow;
end;

procedure TfrmIRSALIYE.IB_Edit25Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit25.Text)) = 0 then
  begin
    IB_Edit25.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit25,nil,4) then
  begin
    IB_Edit25.Color := clWindow;
  end
  else
  begin
    IB_Edit25.SetFocus;
  end;
    IB_Edit25.Color := clWindow;
end;

procedure TfrmIRSALIYE.IB_Edit5KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit5ButtonClick(Self);
end;

procedure TfrmIRSALIYE.IB_Edit6KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit6ButtonClick(Self);
end;

procedure TfrmIRSALIYE.IB_Edit7KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit7ButtonClick(Self);
end;

procedure TfrmIRSALIYE.IB_Edit24KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit24ButtonClick(Self);
end;

procedure TfrmIRSALIYE.IB_Edit25KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit25ButtonClick(Self);
end;

procedure TfrmIRSALIYE.IB_Edit40Exit(Sender: TObject);
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
  my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if Trim(qryFAT_IRS.FieldByName('YEV_ACIKLAMA').AsString) = '' then
  begin
    qryFAT_IRS.FieldByName('YEV_ACIKLAMA').AsString := qryFAT_IRS.FieldByName('ACIKLAMA').AsString;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmIRSALIYE.IB_Edit3Exit(Sender: TObject);
var
  qryTEMP:TIB_Query;
  Msg:PChar;
begin
{    try
      if dtsFAT_IRS.State in [dsSINSERT] then
      begin
        DataMod.CreateQuery(qryTemp,nil,False,DataMod.dbaMain);
        //qryTEMP := TIB_Query.Create(Self);
        //qryTEMP.IB_Connection := DataMod.dbaMain;
        qryTEMP.SQL.Add('SELECT COUNT(FAT_IRS_ID) AS KAY_SAY FROM FAT_IRS WHERE FAT_IRS.FAT_IRS_SERI= ' + SQL_Katar(IB_Edit1.Text) + ' AND FAT_IRS.BELGE_NO = ' + SQL_Katar(IB_Edit3.Text));
        qryTEMP.Open;
        if qryTEMP.FieldByName('KAY_SAY').AsInteger > 0 then
        begin
          Application.MessageBox('M?kerrer ?rsaliye Numaras? Giriyorsunuz!','Dikkat',MB_ICONINFORMATION);
          IB_Edit3.SetFocus;
          Exit;
        end;
      end;
      my_Active_Comp.Brush.color := clWindow;
    except
      Msg := PChar(qryTEMP.SQL[0] + ' Sorgusunda hata olu?tu');
      Application.MessageBox(Msg,'Dikkat',MB_ICONHAND);
    end;//end try
}
      my_Active_Comp.Brush.color := clWindow;
end;

function TfrmIRSALIYE.Form_Before_Post: Boolean;
begin
  Result := False;

  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu mod?lde de?i?iklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryFAT_IRS.FieldByName('FAT_IRS_SERI').AsString) = ''  then
  begin
    IB_Edit1.SetFocus;
    Application.MessageBox('?rsaliye Seri Numaras? Alan?na Veri Girmediniz!!!','D?KKAT',MB_ICONWARNING);
    exit;
  end;

//bu kontrol ge?ici olarak eklendi daha sonra
//parametrelere aktar?lacak fatura aral?klar?n? kontrol ediyor
//ve ?ubelere ait fatura aral?klar?na bak?yor.
//?ubelerin yanl?? fatura numaras? girip kay?t yapmamalar? i?in
//eklendi.

  if Trim(qryFAT_IRS.FieldByName('BELGE_NO').AsString) = ''  then
  begin
    IB_Edit3.SetFocus;
    Application.MessageBox('?rsaliye No Alan?na Veri Girmediniz!!!','D?KKAT',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString) = ''  then
  begin
    txtCariKod.SetFocus;
    Application.MessageBox('Cari Kod Alan?na Veri Girmediniz!!!','D?KKAT',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryFAT_IRS.FieldByName('ACIKLAMA').AsString) = ''  then
  begin
    IB_Edit40.SetFocus;
    Application.MessageBox('?rsaliye A??klamas? Girmediniz!!!','D?KKAT',MB_ICONWARNING);
    exit;
  end;
  {Lite
  if (Trim(qryFAT_IRS.FieldByName('YEV_ACIKLAMA').AsString) = '') then
  begin
    IB_Edit26.SetFocus;
    Application.MessageBox('Yevmiye A??klamas? Girmediniz!!!','D?KKAT',MB_ICONWARNING);
    exit;
  end;
  }
  if qryURUNHAR.RecordCount = 0 then
  begin
    Application.MessageBox('?rsaliye Kalemi Olmadan ?rsaliyeyi Kaydedemezsiniz!!!','D?KKAT',MB_ICONWARNING);
    exit;
  end;

  if qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsSmallint = 1 Then
  begin
    if (Trim(qryFAT_IRS.FieldByName('KASA_KOD').AsString)='') Then
    begin
      Application.MessageBox('Kasa Kodu Alan?na Veri Girmediniz ..!','D?KKAT',MB_ICONWARNING);
      exit;
    end;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryFAT_IRS.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('TARIH').AsDate, '??lem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDate, 'D?viz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('VADE_TARIH').AsDate, 'Vade Tarihi') then Exit;


 if qryFAT_IRS.State in [dsSINSERT] then
 if  DataMod.Seri_No_Kontrolu(qryFAT_IRS,'FAT_IRS',prv_FAT_IRS_SEP,qryFAT_IRS.FieldByName('FAT_IRS_ID').asInteger,prv_FAT_TIP,
  qryFAT_IRS.FieldByName('FAT_IRS_SERI').asString,
  qryFAT_IRS.FieldByName('BELGE_NO').asString,
  qryFAT_IRS.FieldByName('CARI_KOD').asString) then Exit;


  Result := True;
end;


function TfrmIRSALIYE.Form_Before_Delete:Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu mod?lde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryFAT_IRS.FieldByName('TARIH').AsDate,True) then Exit;
  Result := True;
end;


procedure TfrmIRSALIYE.Form_Post;
var
  URUN_HAR_TIP : Char;
  SIPARIS_D_FAT_ID,URUNHAR_ID:Integer;
  qryDeg1,qryDeg:TIb_Query;
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
    if trnFAT_IRS.InTransaction then
       trnFAT_IRS.Rollback;
    trnFAT_IRS.StartTransaction;
//****************************************************************************//
    prn_FATURA_ID := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
    prn_FATURA_SID := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsSmallint;
//****************************************************************************//
    if not URUN_HAR_SIL then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    qryURUNHAR.DisableControls;
    qryURUNHAR.First;
    while not qryURUNHAR.Eof Do
    begin
      //prv_FAT_TIP 1:Sat?? 2:Al??
//****************************************************************************//
      if prv_FAT_TIP = 1 then
         URUN_HAR_TIP := ALACAK
      else
         URUN_HAR_TIP := BORC;
//****************************************************************************//
      if (qryURUNHAR.FieldByName('URUN_KOD').AsString <> '') and (qryURUNHAR.FieldByName('FATURA_ID').AsInteger = 0) then
      begin
        if not DataMod.URUN_HAR_AUD(trnFAT_IRS,
                                    qryURUNHAR.FieldByName('URUN_KOD').AsString,
                                    qryURUNHAR.FieldByName('DEPO_KOD').AsString,
                                    URUN_HAR_TIP,
                                    qryURUNHAR.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency,
                                    qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                    qryURUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency) then
        begin
          Exit;
        end;
      end;
      qryURUNHAR.Next;
    end;
    qryURUNHAR.EnableControls;
//****************************************************************************//
    ApplyDatasets;
//****************************************************************************//

    qryURUNHAR.First;
    if DataMod.Siparis_Faturami(qryURUNHAR.FieldByName('IRSALIYE_ID').AsInteger)>0 then
    While not qryURUNHAR.Eof do
    begin
      if DataMod.Siparis_Fat_Kac_Adet(qryURUNHAR.FieldByName('IRSALIYE_ID').AsInteger,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,'2')>1 then
      begin
        DataMod.Siparis_Fat_Ayarla(trn_Sip,qryURUNHAR.FieldByName('IRSALIYE_ID').AsInteger,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,0,QryURUNHAR.FieldByName('MIKTAR').AsFloat,'2');
      end
      else
      begin
           DataMod.CreateQuery(qryDeg1,trn_Sip,False,DataMod.dbaMain);
           DataMod.CreateQuery(qryDeg,trn_Sip,False,DataMod.dbaMain);
           qryDeg1.Active := False;
           qryDeg1.SQL.Clear;
           qryDeg1.SQL.Text:=
           'SELECT SIPARIS_D_FAT.SIPARIS_D_FAT_ID, SIPARIS_D_FAT.SIPARISD_ID FROM SIPARIS_D_FAT '+
           ' WHERE  SIPARIS_D_FAT.FATURA_ID=:FATURA_ID and SIPARIS_D_FAT.FATURAD_ID=:FATURAD_ID AND SIPARIS_D_FAT.NEREDEN=:NEREDEN';
           qryDeg1.ParamByName('FATURA_ID').AsInteger:=qryURUNHAR.FieldByName('IRSALIYE_ID').AsInteger;
           qryDeg1.ParamByName('FATURAD_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
           qryDeg1.ParamByName('NEREDEN').AsString:='2';
           qryDeg1.Active := True;

           if qryDeg1.FieldByName('SIPARIS_D_FAT_ID').AsInteger>0 then
           begin
             SIPARIS_D_FAT_ID:=qryDeg1.FieldByName('SIPARIS_D_FAT_ID').AsInteger;
             URUNHAR_ID:=qryDeg1.FieldByName('SIPARISD_ID').AsInteger;
             qryDeg.Active := False;
             qryDeg.SQL.Clear;
             qryDeg.SQL.Text:=
             ' UPDATE SIPARIS_D_FAT SET MIKTAR=:MIKTAR WHERE SIPARIS_D_FAT.SIPARIS_D_FAT_ID=:SIPARIS_D_FAT_ID';
             qryDeg.ParamByName('SIPARIS_D_FAT_ID').AsInteger:=SIPARIS_D_FAT_ID;
             qryDeg.ParamByName('MIKTAR').AsFloat:=qryURUNHAR.FieldByName('MIKTAR').AsFloat;
             qryDeg.ExecSql;


             qryDeg.Active := False;
             qryDeg.SQL.Clear;
             //qryDeg.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=AKTARILAN_MIKTAR+:MIKTAR WHERE URUNHAR_ID=:URUNHAR_ID';
             qryDeg.SQL.Text:='UPDATE SIPARIS_D SET SIPARIS_D.AKTARILAN_MIKTAR= (SELECT SUM(SIPARIS_D_FAT.MIKTAR) FROM SIPARIS_D_FAT WHERE SIPARIS_D_FAT.SIPARISD_ID=:URUNHAR_ID) WHERE SIPARIS_D.URUNHAR_ID=:URUNHAR_ID';
             qryDeg.ParamByName('URUNHAR_ID').AsInteger:=URUNHAR_ID;
             //qryDeg.ParamByName('MIKTAR').Asfloat:=qryURUNHAR.FieldByName('MIKTAR').AsFloat;
             qryDeg.ExecSql;



             qryDeg.Active:=False;
             qryDeg.SQL.Clear;
             qryDeg.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=0 WHERE URUNHAR_ID=:URUNHAR_ID and (AKTARILAN_MIKTAR IS NULL)';
             qryDeg.ParamByName('URUNHAR_ID').AsInteger:=URUNHAR_ID;
             qryDeg.ExecSql;

             qryDeg.Active := False;
             qryDeg.SQL.Clear;
             qryDeg.SQL.Text:='UPDATE SIPARIS_D SET KAPANDI=1 WHERE URUNHAR_ID=:URUNHAR_ID and MIKTAR=AKTARILAN_MIKTAR';
             qryDeg.ParamByName('URUNHAR_ID').AsInteger:=URUNHAR_ID;
             qryDeg.ExecSql;
           end;

      end;
      qryURUNHAR.Next;
    end;

    if Siparis_Aktarma then Siparis_Aktarma:=False;


    dmLOGGER.dbaMain_StopMonitoringWrite2log('FAT_IRS,URUNHAR,FAT_IRS_MUH_CARI,FAT_IRS_ACK,',
                                             prv_BELGE_TUR,
                                             qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger,
                                             qryFAT_IRS.FieldByName('FAT_IRS_SID').AsSmallint,
                                             1,1,'');
//****************************************************************************//
    trnFAT_IRS.Commit;
    if trn_Sip.InTransaction then
    trn_Sip.Commit;
//****************************************************************************//
//    if rgYAZICI.ItemIndex < 2 then
//         Yazici.FATURA(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex);
  if rgYAZICI.ItemIndex < 2 then
//  if Dm_Fast_Report.Yeni_Rapor_Varmi(361)>0 then
//  begin
//       Dm_Fast_Report.Rapor_Ac(0,361,36,1,rgYAZICI.ItemIndex,prn_FATURA_ID,prn_FATURA_SID,0,'');
//  end
//  else

  if rgYAZICI.ItemIndex < 2 then Yazici.FATURA(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex,2,qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);

    prn_FATURA_ID := 0;
    prn_FATURA_SID := 0;
  except
    trnFAT_IRS.RollbackRetaining;
    trn_Sip.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  CommitUpdates;
//****************************************************************************//
  grpBoxCari.Visible := False;
  grpBoxMuhtelif.Visible := False;
//****************************************************************************//
end;

procedure TfrmIRSALIYE.Form_Delete;
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if not Form_Before_Delete then exit;
  if Application.MessageBox('Kayd? silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trnFAT_IRS.InTransaction then
       trnFAT_IRS.Rollback;
    trnFAT_IRS.StartTransaction;
//****************************************************************************//
    if not URUN_HAR_SIL then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;


//****************************************************************************//
    if qryFAT_IRS_ACK.Active = False then
    begin
      with qryFAT_IRS_ACK do
      begin
        ParamByName('PRM_FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
        ParamByName('PRM_FAT_IRS_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
        ParamByName('PRM_FAT_IRS_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
        Active := True;
      end;
    end;
//****************************************************************************//
    if not ((qryFAT_IRS_ACK.Eof) and (qryFAT_IRS_ACK.Bof)) then
    begin
      qryFAT_IRS_ACK.Delete;
    end;
//****************************************************************************//
    if qryFAT_IRS.FieldByName('MUHTELIF').AsSmallint = 1 Then
    begin
      if not ((qryFAT_IRS_MUH_CARI.Eof) and (qryFAT_IRS_MUH_CARI.Bof)) then
      begin
        qryFAT_IRS_MUH_CARI.Delete;
      end;
    end;
//****************************************************************************//


//****************************************************************************//
    if not ((qryURUNHAR.Eof) and (qryURUNHAR.Bof)) then
    begin
      qryURUNHAR.First;
      while not qryURUNHAR.Eof do
      begin
        qryURUNHAR.Delete;
        qryURUNHAR.First;
      end;
    end;
//****************************************************************************//

    //sipari? baglar?n? sil
    Fatura_Aktarma_Bag_Sil_Tumu(trn_Sip,qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger);




    FAT_IRS_ID := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
    FAT_IRS_SID := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
//****************************************************************************//
    qryFAT_IRS.Delete;
    ApplyDatasets;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('FAT_IRS,URUNHAR,FAT_IRS_MUH_CARI,FAT_IRS_ACK,',
                                             prv_BELGE_TUR,
                                             FAT_IRS_ID,
                                             FAT_IRS_SID,
                                             1,2,'');
//****************************************************************************//
    trnFAT_IRS.Commit;

    if trn_Sip.InTransaction then
    trn_Sip.Commit;
//****************************************************************************//
  except
    trnFAT_IRS.RollbackRetaining;
    trn_Sip.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  CommitUpdates;
  grpBoxCari.Visible := False;
  grpBoxMuhtelif.Visible := False;
end;



procedure TfrmIRSALIYE.edtDOVKURExit(Sender: TObject);
begin
  if not (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if (qryURUNHAR.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('D?viz kuru s?f?ra e?it yada s?f?rdan k???k olamaz.L?tfen kontrol ediniz.');
    qryURUNHAR.FieldByName('DOVKUR').AsCurrency := 1;
    edtDOVKUR.SetFocus;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmIRSALIYE.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmIRSALIYE.cboDOVKODExit(Sender: TObject);
begin
  if not (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    cboDOVKOD.Color := clWindow;
    exit;
  end;
  cboDOVKOD.Color := clWindow;
end;

procedure TfrmIRSALIYE.cboDOVKODEnter(Sender: TObject);
begin
  cboDOVKOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.btnCiktiClick(Sender: TObject);
begin
  if qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger<=0 then Exit;
  if Application.MessageBox('Kayd?n ??kt?s?n? almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.ItemIndex < 2 then
//  if Dm_Fast_Report.Yeni_Rapor_Varmi(361)>0 then
//  begin
//       Dm_Fast_Report.Rapor_Ac(0,361,36,1,rgYAZICI.ItemIndex,prn_FATURA_ID,prn_FATURA_SID,0,'');
//  end
//  else

  if rgYAZICI.ItemIndex < 2 then Yazici.FATURA(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex,2,qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);
end;

procedure TfrmIRSALIYE.qryURUNHARBeforePost(IB_Dataset: TIB_Dataset);
var
  BIRIMFIY_URN_DOVKOD,
  TUTAR_URN_DOVKOD,
  MIKTAR_URN_OLCUBIRIM,
  BIRIMFIY_VPB:Currency;
  URUN_DOVKOD,URUN_OLCUBIRIM:String;
  qryDegX1:TIB_Query;  
begin
  if DataMod.GET_URUNHAR_URUN_BILGI(IB_Dataset.FieldByName('URUN_KOD').AsString,
                                    IB_Dataset.FieldByName('TIP').AsString[1],
                                    IB_Dataset.FieldByName('DOVKOD').AsString,
                                    IB_Dataset.FieldByName('OLCUBIRIM').AsString,
                                    IB_Dataset.FieldByName('DOV_BAZ_TAR').AsDate,
                                    IB_Dataset.FieldByName('BIRIM_FIY').AsCurrency,
                                    IB_Dataset.FieldByName('TUTAR').AsCurrency,
                                    IB_Dataset.FieldByName('DOVKUR').AsCurrency,
                                    IB_Dataset.FieldByName('MIKTAR').AsCurrency,
                                    BIRIMFIY_URN_DOVKOD,
                                    BIRIMFIY_VPB,
                                    TUTAR_URN_DOVKOD,
                                    MIKTAR_URN_OLCUBIRIM,
                                    URUN_DOVKOD,
                                    URUN_OLCUBIRIM) then
  begin
    IB_Dataset.FieldByName('BIRIM_FIY_URN_DOVKOD').AsCurrency := BIRIMFIY_URN_DOVKOD;
    IB_Dataset.FieldByName('BIRIM_FIY_VPB').AsCurrency := BIRIMFIY_VPB;
    IB_Dataset.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency := TUTAR_URN_DOVKOD;
    IB_Dataset.FieldByName('MIKTAR_URN_OB').AsCurrency := MIKTAR_URN_OLCUBIRIM;
    IB_Dataset.FieldByName('URUN_DOVKOD').AsString := URUN_DOVKOD;
    IB_Dataset.FieldByName('OLCUBIRIM_URN_OB').AsString := URUN_OLCUBIRIM;
  end
  else
  begin
    Abort;
  end;



  if qryURUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency=qryURUNHAR.FieldByName('MIKTAR').AsCurrency then
  qryURUNHAR.FieldByName('BIRIM_FIY_URN_OB').AsCurrency := qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency
  else
  qryURUNHAR.FieldByName('BIRIM_FIY_URN_OB').AsCurrency :=
  qryURUNHAR.FieldByName('TUTAR').AsCurrency/
  qryURUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency;

  
  if qryURUNHAR.State=DssEdit then
  begin


  DataMod.CreateQuery(qryDegX1,nil,False,DataMod.dbaMain);
  qryDegX1.active := False;
  qryDegX1.SQL.Clear;
  qryDegX1.SQL.Text:=
  'SELECT SIPARIS_D_FAT.SIPARIS_D_FAT_ID,SIPARIS_D_FAT.SIPARIS_ID,SIPARIS_D_FAT.SIPARISD_ID, SIPARIS_D_FAT.MIKTAR FROM SIPARIS_D_FAT '+
  ' WHERE SIPARIS_D_FAT.FATURA_ID=:FATURA_ID and SIPARIS_D_FAT.FATURAD_ID=:FATURAD_ID';
  qryDegX1.ParamByName('FATURA_ID').AsInteger:=qryURUNHAR.FieldByName('IRSALIYE_ID').AsInteger;
  qryDegX1.ParamByName('FATURAD_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
  qryDegX1.Active := True;

  if (qryDegX1.FieldByName('SIPARIS_D_FAT_ID').AsInteger > 0) then
  if qryURUNHAR.FieldByName('MIKTAR').AsFloat > prv_Ilk_Miktar then
  begin
    Application.MessageBox('Aktar?lan fazla miktar giri?i yapamazs?n?z','Dikkat',MB_ICONWARNING);
    Abort;
  end;

  if (qryDegX1.FieldByName('SIPARIS_D_FAT_ID').AsInteger > 0) then
  if qryURUNHAR.FieldByName('OLCUBIRIM').AsString <> prv_Ilk_Olcu_Birimi then
  begin
    Application.MessageBox('Aktar?lan kayd?n ?l?? biriminide de?i?iklik yapamazs?n?z','Dikkat',MB_ICONWARNING);
    Abort;
  end;
  
  qryDegX1.Active := False;

  end;

end;

procedure TfrmIRSALIYE.FaturaKopyala1Click(Sender: TObject);
var
  ID,SID:String;
  FAT_IRS_SEP : Byte;
begin
  if qryFAT_IRS.FieldByName('FAT_IRS_SEP').AsSmallInt <> 2 then
  begin
    Application.MessageBox('Bu se?enek ?zerinde ?rsaliye d???nda kopyalama i?lemi yapamazs?n?z.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if not qryFAT_IRS.Active then
  begin
    Application.MessageBox('Olmayan bir irsaliye ?zerinden kopyalama i?lemi yapamazs?n?z.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryFAT_IRS.State in [dssInsert] then
  begin
    Application.MessageBox('Yeni kay?t durumunda irsaliye ?zerinden kopyalama i?lemi yapamazs?n?z.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  ID := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsString;
  SID := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsString;
  FAT_IRS_SEP := qryFAT_IRS.FieldByName('FAT_IRS_SEP').AsSmallint;

  rgYAZICI.ItemIndex := 2;

  btnTRN_IPTALClick(Self);

  if not qryFAT_IRS.Active then
  begin
    if not DEKONT_AUT.IrsaliyeKopyala(ID,SID,FAT_IRS_SEP) then
    begin
      Application.MessageBox('?rsaliye kopyalama i?lemi s?ras?nda hata olu?tu.','Dikkat',MB_ICONWARNING);
    end;
  end;

end;

procedure TfrmIRSALIYE.Btn_Siparis_SecimiClick(Sender: TObject);
begin
   if frmIRSALIYE.Siparis_Aktarma then exit;
   
//   qryFAT_IRS.UpdateData;
   if not (Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString)='') then
   begin
     if frmSiparis_Fatura.Form_Open(prv_FAT_IRS_SEP,qryFAT_IRS.FieldByName('CARI_KOD').AsString,qryFAT_IRS.FieldByName('CARI_AD').AsString,prv_FAT_TIP,qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDateTime) then
     begin
          with qryURUNHAR do
          begin
            Active := False;
            ParamByName('PRM_IRSALIYE_ID').AsInteger :=  qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
            ParamByName('PRM_IRSALIYE_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
            Active := True;
          end;
          frmIRSALIYE.KalemHesapla;
          if (qryURUNHAR.State in [dssInsert,dssEdit]) then
          begin
               qryURUNHAR.Post;
          end;          
          pgFAT_IRS.ActivePage:=tabKalem;
     end;
  end
  else
  begin
    txtCariKod.SetFocus;
    Application.MessageBox('Cari Bilgisi olmadan bu alana ge?emezsiniz.','Dikkat',MB_ICONWARNING);
    txtCariKodButtonClick(Self);
  end;
end;

procedure TfrmIRSALIYE.Fatura_Aktarma_Bag_Sil_Tumu(Transaction:TIB_Transaction;Fatura_Id:Integer);
var
  SIPARIS_D_FAT_ID,SIPARIS_ID,SIPARISD_ID:Integer;
  MIKTAR:Double;
  qryDeg,qryDeg1:TIb_Query;
begin
  DataMod.CreateQuery(qryDeg,Transaction,False,DataMod.dbaMain);
  DataMod.CreateQuery(qryDeg1,Transaction,False,DataMod.dbaMain);
  qryDeg.Active := False;
  qryDeg.SQL.Clear;
  qryDeg.SQL.Text:=
  'SELECT SIPARIS_D_FAT.SIPARIS_D_FAT_ID,SIPARIS_D_FAT.SIPARIS_ID,SIPARIS_D_FAT.SIPARISD_ID, SIPARIS_D_FAT.MIKTAR FROM SIPARIS_D_FAT '+
  ' WHERE SIPARIS_D_FAT.FATURA_ID=:FATURA_ID and NEREDEN=''2''';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.Active := True;
  While not qryDeg.eof do
  begin
    SIPARIS_D_FAT_ID:=qryDeg.FieldByName('SIPARIS_D_FAT_ID').AsInteger;
    SIPARIS_ID:=qryDeg.FieldByName('SIPARIS_ID').AsInteger;
    SIPARISD_ID:=qryDeg.FieldByName('SIPARISD_ID').AsInteger;
    MIKTAR:=qryDeg.FieldByName('MIKTAR').AsInteger;

    qryDeg1.Active := False;
    qryDeg1.SQL.Clear;
    qryDeg1.SQL.Text:=
    ' DELETE FROM SIPARIS_D_FAT WHERE SIPARIS_D_FAT.SIPARIS_D_FAT_ID=:SIPARIS_D_FAT_ID';
    qryDeg1.ParamByName('SIPARIS_D_FAT_ID').AsInteger:=SIPARIS_D_FAT_ID;
    qryDeg1.ExecSql;

    qryDeg1.Active := False;
    qryDeg1.SQL.Clear;
    //qryDeg1.SQL.Text:=
    //' UPDATE SIPARIS_D SET KAPANDI=0,AKTARILAN_MIKTAR=AKTARILAN_MIKTAR-:MIKTAR WHERE SIPARIS_D.URUNHAR_ID=:SIPARISD_ID AND  SIPARIS_D.FATURA_ID=:SIPARIS_ID';
    //' UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=AKTARILAN_MIKTAR-:MIKTAR WHERE SIPARIS_D.URUNHAR_ID=:SIPARISD_ID AND  SIPARIS_D.FATURA_ID=:SIPARIS_ID';
    //qryDeg1.ParamByName('SIPARIS_ID').AsInteger:=SIPARIS_ID;
    //qryDeg1.ParamByName('SIPARISD_ID').AsInteger:=SIPARISD_ID;
    //qryDeg1.ParamByName('MIKTAR').AsFloat:=MIKTAR;
    qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET SIPARIS_D.AKTARILAN_MIKTAR= (SELECT SUM(SIPARIS_D_FAT.MIKTAR) FROM SIPARIS_D_FAT WHERE SIPARIS_D_FAT.SIPARISD_ID=:URUNHAR_ID) WHERE SIPARIS_D.URUNHAR_ID=:URUNHAR_ID';
    qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;

    qryDeg1.ExecSql;


    qryDeg1.Active:=False;
    qryDeg1.SQL.Clear;
    qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=0 WHERE URUNHAR_ID=:URUNHAR_ID and AKTARILAN_MIKTAR IS NULL';
    qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
    qryDeg1.ExecSql;


    qryDeg1.Active:=False;
    qryDeg1.SQL.Clear;
    qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET KAPANDI=1 WHERE URUNHAR_ID=:URUNHAR_ID and MIKTAR=AKTARILAN_MIKTAR';
    qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
    qryDeg1.ExecSql;

    qryDeg1.Active:=False;
    qryDeg1.SQL.Clear;
    qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET KAPANDI=0 WHERE URUNHAR_ID=:URUNHAR_ID and MIKTAR<>AKTARILAN_MIKTAR';
    qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
    qryDeg1.ExecSql;


    qryDeg.Next;
  end;


end;

procedure TfrmIRSALIYE.Fatura_Aktarma_Bag_Sil_Tek(Transaction:TIB_Transaction;Fatura_Id:Integer;FaturaD_Id:Integer);
var
  SIPARIS_D_FAT_ID,SIPARIS_ID,SIPARISD_ID:Integer;
  MIKTAR:Double;
  qryDeg,qryDeg1:TIb_Query;
begin
  DataMod.CreateQuery(qryDeg,Transaction,False,DataMod.dbaMain);
  DataMod.CreateQuery(qryDeg1,Transaction,False,DataMod.dbaMain);
  qryDeg.Active := False;
  qryDeg.SQL.Clear;
  qryDeg.SQL.Text:=
  'SELECT SIPARIS_D_FAT.SIPARIS_D_FAT_ID,SIPARIS_D_FAT.SIPARIS_ID,SIPARIS_D_FAT.SIPARISD_ID,SIPARIS_D_FAT.MIKTAR  FROM SIPARIS_D_FAT '+
  ' WHERE  SIPARIS_D_FAT.FATURA_ID=:FATURA_ID and SIPARIS_D_FAT.FATURAD_ID=:FATURAD_ID AND NEREDEN=''2''';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_Id;
  qryDeg.Active := True;
  While not qryDeg.eof do
  begin
    SIPARIS_D_FAT_ID:=qryDeg.FieldByName('SIPARIS_D_FAT_ID').AsInteger;
    SIPARIS_ID:=qryDeg.FieldByName('SIPARIS_ID').AsInteger;
    SIPARISD_ID:=qryDeg.FieldByName('SIPARISD_ID').AsInteger;
    MIKTAR:=qryDeg.FieldByName('MIKTAR').AsInteger;

    qryDeg1.Active := False;
    qryDeg1.SQL.Clear;
    qryDeg1.SQL.Text:=
    ' DELETE FROM SIPARIS_D_FAT WHERE SIPARIS_D_FAT.SIPARIS_D_FAT_ID=:SIPARIS_D_FAT_ID';
    qryDeg1.ParamByName('SIPARIS_D_FAT_ID').AsInteger:=SIPARIS_D_FAT_ID;
    qryDeg1.ExecSql;


    qryDeg1.Active := False;
    qryDeg1.SQL.Clear;
    //qryDeg1.SQL.Text:=
    //' UPDATE SIPARIS_D SET KAPANDI=0,AKTARILAN_MIKTAR=AKTARILAN_MIKTAR-:MIKTAR WHERE SIPARIS_D.URUNHAR_ID=:SIPARISD_ID AND  SIPARIS_D.FATURA_ID=:SIPARIS_ID';
    //' UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=AKTARILAN_MIKTAR-:MIKTAR WHERE SIPARIS_D.URUNHAR_ID=:SIPARISD_ID AND  SIPARIS_D.FATURA_ID=:SIPARIS_ID';
    //qryDeg1.ParamByName('SIPARIS_ID').AsInteger:=SIPARIS_ID;
    //qryDeg1.ParamByName('SIPARISD_ID').AsInteger:=SIPARISD_ID;
    //qryDeg1.ParamByName('MIKTAR').AsFloat:=MIKTAR;

    qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET SIPARIS_D.AKTARILAN_MIKTAR= (SELECT SUM(SIPARIS_D_FAT.MIKTAR) FROM SIPARIS_D_FAT WHERE SIPARIS_D_FAT.SIPARISD_ID=:URUNHAR_ID) WHERE SIPARIS_D.URUNHAR_ID=:URUNHAR_ID';
    qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
    qryDeg1.ExecSql;

    qryDeg1.Active:=False;
    qryDeg1.SQL.Clear;
    qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=0 WHERE URUNHAR_ID=:URUNHAR_ID and AKTARILAN_MIKTAR IS NULL';
    qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
    qryDeg1.ExecSql;

    qryDeg1.Active:=False;
    qryDeg1.SQL.Clear;
    qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET KAPANDI=1 WHERE URUNHAR_ID=:URUNHAR_ID and MIKTAR=AKTARILAN_MIKTAR';
    qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
    qryDeg1.ExecSql;

    qryDeg1.Active:=False;
    qryDeg1.SQL.Clear;
    qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET KAPANDI=0 WHERE URUNHAR_ID=:URUNHAR_ID and MIKTAR<>AKTARILAN_MIKTAR';
    qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
    qryDeg1.ExecSql;
    qryDeg.Next;
  end;
end;


procedure TfrmIRSALIYE.IB_Edit5Enter(Sender: TObject);
begin
  IB_Edit5.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.IB_Edit6Enter(Sender: TObject);
begin
  IB_Edit6.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.IB_Edit7Enter(Sender: TObject);
begin
  IB_Edit7.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.IB_Edit25Enter(Sender: TObject);
begin
  IB_Edit25.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txt_Sevk_AdresButtonClick(Sender: TObject);
var
  SEVK_ADRES_KOD:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_Sevk_Adres(SEVK_ADRES_KOD,
  qryFAT_IRS.FieldByName('CARI_KOD').AsString,
  qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger) then
  begin
    with qryFAT_IRS do
    begin
      FieldByName('SEVK_ADRES_KOD').AsString := SEVK_ADRES_KOD;
    end;
  end;
end;

procedure TfrmIRSALIYE.txt_Sevk_AdresEnter(Sender: TObject);
begin
  txt_Sevk_Adres.Color := glb_Art_Alan_Renk;
end;

procedure TfrmIRSALIYE.txt_Sevk_AdresExit(Sender: TObject);
var
  Sevk_Adres_Kod:String;
  Sevk_Adres:String;
begin
  txt_Sevk_Adres.Color := clWindow;

  if Trim(txt_Sevk_Adres.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD(
    ' and CARI_KOD='+SQL_Katar(qryFAT_IRS.FieldByName('CARI_KOD').AsString)+
    ' and CARI_SID='+Inttostr(qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger),
    'CARI_SEVKAD','CARI_SEVK_KOD','ADRES_1',qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString,Sevk_Adres) Then
    begin
     // qryFAT_IRS.FieldByName('SEVK_ADRES').AsString := Sevk_Adres_Kod;
    end
    else
    begin
      txt_Sevk_Adres.SetFocus;
    end;
  end
  else
  begin
    qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString := '';
  end;
end;

procedure TfrmIRSALIYE.txt_Sevk_AdresKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 Then txt_Sevk_AdresButtonClick(Self);
end;

procedure TfrmIRSALIYE.BitBtn2Click(Sender: TObject);
var
  PAKET_KOD,PAKET_ADI:String;
begin
  if (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if datamod.LS_Paket(PAKET_KOD,PAKET_ADI) then
  begin
    DataMod.Paket_At(trnFAT_IRS,qryURUNHAR,PAKET_KOD,prv_FAT_TIP,prv_ISN,prv_KDV_HESAPLA,qryFAT_IRS.FieldByName('CARI_KOD').AsString);
  end;
end;

procedure TfrmIRSALIYE.qryURUNHARBeforeEdit(IB_Dataset: TIB_Dataset);
begin
     prv_Ilk_Miktar:=qryURUNHAR.FieldByName('MIKTAR').AsFloat;
     prv_Ilk_Olcu_Birimi:=qryURUNHAR.FieldByName('OLCUBIRIM').AsString;
end;

end.
