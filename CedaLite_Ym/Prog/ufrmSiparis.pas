unit ufrmSiparis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, IB_Controls, ExtCtrls, StdCtrls,
  Mask, Buttons, ComCtrls;

type
  TfrmSiparis = class(TForm)
    pgFAT_IRS: TPageControl;
    tabFAT_IRS: TTabSheet;
    Label2: TLabel;
    Panel5: TPanel;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnYeni: TBitBtn;
    btnTRN_KAYDET: TButton;
    btnTRN_IPTAL: TButton;
    btnFaturaSil: TBitBtn;
    txtFaturaDepoAD: TIB_Edit;
    txtFaturaPlasiyerAD: TIB_Edit;
    IB_Edit40: TIB_Edit;
    txtFaturaProjeAD: TIB_Edit;
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
    rgYAZICI: TRadioGroup;
    IB_Edit26: TIB_Edit;
    btnCikti: TButton;
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
    grpRapKod: TGroupBox;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit24: TIB_Edit;
    IB_Edit25: TIB_Edit;
    tabKalem: TTabSheet;
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
    lblKAL_ISKONTO_TIP: TLabel;
    btnEKLE: TButton;
    btnKaydet: TButton;
    btnIptal: TButton;
    btnSil: TButton;
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
    IB_Edit4: TIB_Edit;
    IB_Currency7: TIB_Currency;
    cboDOVKOD: TIB_ComboBox;
    grdFatKontrol: TIB_Grid;
    tabToplam: TTabSheet;
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
    txtKasaKod: TIB_Edit;
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
    txtKasaAd: TIB_Edit;
    dtsSiparis: TIB_DataSource;
    qrySiparis: TIB_Query;
    dstSiparis_D: TIB_DataSource;
    qrySiparis_D: TIB_Query;
    trnFAT_IRS: TIB_Transaction;
    qry_Siparis_Fat: TIB_Query;
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
    btnMuhtelifIptal: TButton;
    qryFAT_IRS_MUH_CARI: TIB_Query;
    dtsFAT_IRS_MUH_CARI: TIB_DataSource;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtCariKodButtonClick(Sender: TObject);
    procedure txtFaturaDepoKodButtonClick(Sender: TObject);
    procedure txtPlasiyerKodButtonClick(Sender: TObject);
    procedure txtProjeKodButtonClick(Sender: TObject);
    procedure txtFaturaDepoKodExit(Sender: TObject);
    procedure txtPlasiyerKodExit(Sender: TObject);
    procedure txtProjeKodExit(Sender: TObject);
    procedure txtFaturaDepoKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtPlasiyerKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtProjeKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit5ButtonClick(Sender: TObject);
    procedure IB_Edit6ButtonClick(Sender: TObject);
    procedure IB_Edit7ButtonClick(Sender: TObject);
    procedure IB_Edit24ButtonClick(Sender: TObject);
    procedure IB_Edit25ButtonClick(Sender: TObject);
    procedure txtCariKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtCariKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtOlcuBirimButtonClick(Sender: TObject);
    procedure txtDepoKodButtonClick(Sender: TObject);
    procedure txtKasaKodButtonClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure txtUrunKoduButtonClick(Sender: TObject);
    procedure btnEKLEClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure btnFaturaSilClick(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure IB_Edit5Exit(Sender: TObject);
    procedure IB_Edit6Exit(Sender: TObject);
    procedure IB_Edit7Exit(Sender: TObject);
    procedure IB_Edit24Exit(Sender: TObject);
    procedure IB_Edit25Exit(Sender: TObject);
    procedure IB_Edit25KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit24KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit7KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit6KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure Form_Open(Menu: Boolean; FAT_IRS_SEP: Byte; FAT_IRS_ID, FAT_IRS_SID: Integer; ISLEM: Byte; TIP: SmallInt);
    procedure dtsSiparisDataChange(Sender: TIB_StatementLink; Statement: TIB_Statement; Field: TIB_Column);
    procedure dtsSiparisStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure dstSiparis_DStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdFatIsTipChange(Sender: TObject);
    procedure edtDOVKURExit(Sender: TObject);
    procedure rdIskontoChange(Sender: TObject);
    procedure qrySiparisAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qrySiparis_DAfterDelete(IB_Dataset: TIB_Dataset);
    procedure qrySiparis_DAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qrySiparis_DAfterPost(IB_Dataset: TIB_Dataset);
    procedure qrySiparis_DBeforePost(IB_Dataset: TIB_Dataset);
    procedure dstSiparis_DDataChange(Sender: TIB_StatementLink; Statement: TIB_Statement; Field: TIB_Column);
    procedure btnCiktiClick(Sender: TObject);
    procedure pgFAT_IRSChange(Sender: TObject);
    procedure pgFAT_IRSChanging(Sender: TObject; var AllowChange: Boolean);
    procedure txtKasaKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtUrunKoduKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtDepoKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtOlcuBirimKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
    procedure Panel5DblClick(Sender: TObject);
    procedure txtCariKodExit(Sender: TObject);
    procedure txtUrunKoduExit(Sender: TObject);
    procedure txtDepoKodExit(Sender: TObject);
    procedure txtOlcuBirimExit(Sender: TObject);
    procedure txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
    procedure txtKasaKodExit(Sender: TObject);
    procedure txtUrunKoduEnter(Sender: TObject);
    procedure txtOlcuBirimEnter(Sender: TObject);
    procedure txtDepoKodEnter(Sender: TObject);
    procedure txtCariKodEnter(Sender: TObject);
    procedure txtFaturaDepoKodEnter(Sender: TObject);
    procedure txtPlasiyerKodEnter(Sender: TObject);
    procedure txtProjeKodEnter(Sender: TObject);
    procedure IB_Edit5Enter(Sender: TObject);
    procedure IB_Edit6Enter(Sender: TObject);
    procedure IB_Edit7Enter(Sender: TObject);
    procedure IB_Edit24Enter(Sender: TObject);
    procedure IB_Edit25Enter(Sender: TObject);
    procedure txtKasaKodEnter(Sender: TObject);
    procedure rg_Siparis_TipiClick(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure btnMuhtelifIptalClick(Sender: TObject);
    procedure IB_Edit40Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);

  private
    prv_FAT_TIP,prv_FAT_IRS_SEP:SmallInt;
    prn_FATURA_ID,prn_FATURA_SID,prv_MY_Index:Integer;
    prv_KDV_HESAPLA:Boolean;
    prv_Burut_Top:Currency;
    prv_Temp_Burut_Top:Currency;

    Muh_Kod,Aciklama:String;
    prv_CanUpdate,prv_CanDelete:Boolean;
    prv_OlcuBirim_Kontrol:Boolean;
    prv_ISN:Integer;
    prv_BELGE_TUR:Integer;
    my_Active_Comp:TWinControl;

    procedure Cari2Labels;
    procedure DataSet_Open(FAT_IRS_ID, FAT_IRS_SID: Integer; ISLEM: Byte);
    procedure Form_Delete;
    procedure Form_Post;
    function Form_Before_Delete: Boolean;
    function Form_Before_Post: Boolean;
    procedure ApplyDatasets;
    procedure CancelUpdates;
    procedure CommitUpdates;
    procedure FormatDisplays;
    procedure FaturaToplamHesapla;
    procedure KalemBrutHesapla(Sil: Boolean);
    procedure KalemHesapla;
    procedure FN_BIRIMFIYAT;
    procedure KDV_Hesapla;
    procedure MuhtelifIslemler;

    { Private declarations }
  public
      res_Cari:TStringList;
    procedure Yazdirildi(Sep, Id, Sid: Integer);
    { Public declarations }
  end;
  const cns_musteri_siparis = 23;
  const cns_satici_siparis = 24;

type
  TKDV=Record
  KDV:SmallInt;
  KDVTUTAR:Currency;
end;

var
  frmSiparis: TfrmSiparis;
  arr_KDV:Array [1..6] of TKDV;

implementation

uses unDataMod, ufrmCariSDLG, UnFunc, ufrmUrunSDLG, unLogger, unYazici,
   main, ufrmFAT_IRS_SDLG, ufrmSIP_SDLG, UDm_Fast_Report;

{$R *.dfm}

procedure TfrmSiparis.Form_Open(Menu:Boolean;FAT_IRS_SEP:Byte;FAT_IRS_ID:Integer;FAT_IRS_SID:Integer;ISLEM:Byte;TIP:SmallInt);
//TIP: 1 Satýþ, 2 Alýþ
//FAT_IRS_SEP : 1: FATURA 2: IRSALIYE
var
  qryFAT_PARAMS:TIB_Query;
  local_can_update,local_can_delete:Boolean;
begin
  case FAT_IRS_SEP of
  1:
    begin
      case TIP of
      1://satýþ faturasý
        begin
          if not DataMod.Modul_Hak(cns_musteri_siparis,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if ((ISLEM = 0) and (local_can_update = False)) then
            begin
              Application.MessageBox('Bu modülde yeni sipariþ yetkiniz yok.','Dikkat',MB_ICONWARNING);
              exit;
            end;
          end;
        end;
      2://alýþ faturasý
        begin
          if not DataMod.Modul_Hak(cns_satici_siparis,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if ((ISLEM = 0) and (local_can_update = False)) then
            begin
              Application.MessageBox('Bu modülde yeni sipariþ yetkiniz yok.','Dikkat',MB_ICONWARNING);
              exit;
            end;
          end;
        end;
      end;
    end;
  end;//end case
//****************************************************************************//
  if not MainForm.FindChildFrm( Application, 'frmSiparis') then
  begin
    Application.CreateForm (TfrmSiparis,frmSiparis);
    frmSiparis.prv_CanUpdate := local_can_update;
    frmSiparis.prv_CanDelete := local_can_delete;
  end
  else
  begin
    Application.MessageBox('Sipariþ formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
//****************************************************************************//
    frmSiparis.prv_FAT_TIP := TIP;
    frmSiparis.prv_FAT_IRS_SEP := FAT_IRS_SEP;

   // grpBoxCari.Visible := False;
  with frmSiparis do
  begin
    pgFAT_IRS.ActivePage := frmSiparis.tabFAT_IRS;
    grpBoxCari.Visible := False;
    //grpBoxMuhtelif.Visible := False;
    prv_FAT_TIP := TIP;
    prv_FAT_IRS_SEP := FAT_IRS_SEP;
    DataMod.CreateQuery(qryFAT_PARAMS,Nil,False,DataMod.dbaMain);
    qryFAT_PARAMS.SQL.Add('Select * from FAT_PARAMS WHERE FAT_PARAMS_ID = 1');
    try
      qryFAT_PARAMS.Active := True;
      if qryFAT_PARAMS.RecordCount <> 0 then
      begin
        {if qryFAT_PARAMS.FieldByName('EK_ACK_KUL').AsSmallint = 0 Then
        begin
          tabAciklama.TabVisible  := False;
        end;
        }
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
        Application.MessageBox('Fatura Parametrelerine Ulaþýlamýyor... Lütfen yazýlým hizmet biriminize durumu bildiriniz. Fatura Giriþi yapmayýnýz.','Dikkat',MB_ICONSTOP);
      end;
      qryFAT_PARAMS.Active := False;
    except
      Application.MessageBox('Fatura Parametrelerine Ulaþýlamýyor... Lütfen yazýlým hizmet biriminize durumu bildiriniz. Fatura Giriþi yapmayýnýz.','Dikkat',MB_ICONSTOP);
      qryFAT_PARAMS.Active := False;
    end;
  end;
//****************************************************************************//
  with frmSiparis do
  begin

    case TIP of
    1:
      begin
        Caption := 'Müþteri Sipariþ (Sonraki Sayfa Ýçin F6)';
        prv_BELGE_TUR := BT_MUSTERI_SIPARISI;
        cmbFATURA_TIP.Items.Clear;
        cmbFATURA_TIP.Items.Add('Müþteri Sipariþi');
        cmbFATURA_TIP.ItemValues.Clear;
        cmbFATURA_TIP.ItemValues.Add('1');

        {cmbFATURA_TIP.Items.Add('KAPALI');
        cmbFATURA_TIP.Items.Add('AÇIK');
        cmbFATURA_TIP.Items.Add('ALIÞTAN ÝADE');
        cmbFATURA_TIP.Items.Add('ÝHRACAT');
        cmbFATURA_TIP.ItemValues.Clear;
        cmbFATURA_TIP.ItemValues.Add('1');
        cmbFATURA_TIP.ItemValues.Add('2');
        cmbFATURA_TIP.ItemValues.Add('3');
        cmbFATURA_TIP.ItemValues.Add('4');
        }
      end;
    2:
      begin
        Caption := 'Satýcý Sipariþ (Sonraki Sayfa Ýçin F6)';
        prv_BELGE_TUR := BT_SATICI_SIPARISI;
        cmbFATURA_TIP.Items.Clear;
        cmbFATURA_TIP.Items.Add('Satýcý Sipariþi');
        cmbFATURA_TIP.ItemValues.Clear;
        cmbFATURA_TIP.ItemValues.Add('2');
        rgYAZICI.ItemIndex:=2;

        {cmbFATURA_TIP.Items.Add('KAPALI');
        cmbFATURA_TIP.Items.Add('AÇIK');
        cmbFATURA_TIP.Items.Add('SATIÞTAN ÝADE');
        cmbFATURA_TIP.ItemValues.Clear;
        cmbFATURA_TIP.ItemValues.Add('1');
        cmbFATURA_TIP.ItemValues.Add('2');
        cmbFATURA_TIP.ItemValues.Add('3');
        }
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
  frmSiparis.DataSet_Open(FAT_IRS_ID,FAT_IRS_SID,Islem);
  FormatDisplays;
end;

Procedure TfrmSiparis.FormatDisplays;
begin
//glb_DOV_FIELD_PF
  with frmSiparis.qrySiparis_D do
  begin
    FieldByName('MIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('ISKONTO_TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ISKONTO_TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    {case frmSiparis.prv_FAT_TIP of
    1:FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    2:FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_KUR_PF;
    end;
    }
    FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_KUR_PF;
//    FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_KUR_PF;
//    FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('KDV_TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
  end;
  with frmSiparis.qrySiparis do
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


procedure TfrmSiparis.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmSiparis.txtCariKodButtonClick(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,CARI_KOD,CARI_AD,2) then
  begin
    qrySiparis.FieldByName('CARI_KOD').AsString := CARI_KOD;
    if DataMod.FN_CariKOD2Bilgi(Cari_KOD,res_Cari) then
    begin
        //grpBoxCari.Visible := True;
        //Cari2Labels;
      if res_Cari[15]='0' Then
      begin
        grpBoxCari.Visible := True;
        grpBoxMuhtelif.Visible := False;
        Cari2Labels;
      end
      else
      if res_Cari[15]='1' Then
      begin
        qrySiparis.FieldByName('MUHTELIF').AsSmallint := 1;
        grpBoxCari.Visible := False;
        grpBoxMuhtelif.Visible := True;
        txtCariKod.Enabled := False;
        MuhtelifIslemler;
      end;
    end;
  end;
end;


procedure TfrmSiparis.MuhtelifIslemler;
begin
  with frmSiparis.qryFAT_IRS_MUH_CARI do
  begin
    Active := False;
    //ParamByName('PRM_FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
    ParamByName('PRM_FAT_IRS_SEP').AsInteger := 3;
    ParamByName('PRM_FAT_IRS_ID').AsInteger := qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
    ParamByName('PRM_FAT_IRS_SID').AsInteger := qrySiparis.FieldByName('FAT_IRS_SID').AsInteger;
    Active := True;
  end;

  if ((frmSiparis.qryFAT_IRS_MUH_CARI.Bof) And (frmSiparis.qryFAT_IRS_MUH_CARI.Eof)) then
  begin
    with frmSiparis.qryFAT_IRS_MUH_CARI do
    begin
      Insert;
      //FieldByName('FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
      FieldByName('FAT_IRS_SEP').AsInteger := 3;
      FieldByName('FAT_IRS_ID').AsInteger := qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
      FieldByName('FAT_IRS_SID').AsInteger := qrySiparis.FieldByName('FAT_IRS_SID').AsInteger;
    end;
  end;
end;

procedure TfrmSiparis.Cari2Labels;
begin
  with frmSiparis do
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

procedure TfrmSiparis.txtFaturaDepoKodButtonClick(Sender: TObject);
var
  DEPO_KOD,DEPO_AD:String;
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  
  if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) then
  begin
    with qrySiparis do
    begin
      FieldByName('DEPO_KOD').AsString := DEPO_KOD;
      FieldByName('DEPO_AD').AsString := DEPO_AD;
    end;
  end;
end;

procedure TfrmSiparis.txtPlasiyerKodButtonClick(Sender: TObject);
var
  PLASIYER_KOD,PLASIYER_AD:String;
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMOd.LS_Plasiyer(PLASIYER_KOD,PLASIYER_AD,1) then
  begin
    with qrySiparis do
    begin
      FieldByName('PLASIYER_KOD').AsString := PLASIYER_KOD;
      FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
    end;
  end;
end;

procedure TfrmSiparis.txtProjeKodButtonClick(Sender: TObject);
var
  Proje_KOD,Proje_AD:String;
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_Proje(Proje_KOD,Proje_AD,1) then
  begin
     with qrySiparis do
     begin
       FieldByName('PROJE_KOD').AsString :=Proje_KOD;
       FieldByName('PROJE_AD').AsString :=Proje_AD;
     end;
  end;
end;

procedure TfrmSiparis.txtFaturaDepoKodExit(Sender: TObject);
var
  Depo_Ad:String;
begin
  txtFaturaDepoKod.Color := clWindow;
  if Trim(txtFaturaDepoKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('DEPO','DEPO_KOD','ADI',qrySiparis.FieldByName('DEPO_KOD').AsString,Depo_Ad) Then
    begin
      qrySiparis.FieldByName('DEPO_AD').AsString := Depo_Ad;
    end
    else
    begin
      qrySiparis.FieldByName('DEPO_AD').AsString := '';
      txtFaturaDepoKod.SetFocus;
    end;
  end
  else
  begin
    qrySiparis.FieldByName('DEPO_AD').AsString := '';
  end;
end;

procedure TfrmSiparis.txtPlasiyerKodExit(Sender: TObject);

var
  Plasiyer_Ad:String;
begin
  txtPlasiyerKod.Color := clWindow;
  if Trim(txtPlasiyerKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',qrySiparis.FieldByName('PLASIYER_KOD').AsString,Plasiyer_Ad) Then
    begin
      qrySiparis.FieldByName('PLASIYER_AD').AsString := Plasiyer_Ad;
    end
    else
    begin
      qrySiparis.FieldByName('PLASIYER_AD').AsString := '';
      txtPlasiyerKod.SetFocus;
    end;
  end
  else
  begin
    qrySiparis.FieldByName('PLASIYER_AD').AsString := '';
  end;
end;

procedure TfrmSiparis.txtProjeKodExit(Sender: TObject);
var
  Proje_Ad:String;
begin
  txtProjeKod.Color := clWindow;
  if Trim(txtProjeKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',qrySiparis.FieldByName('PROJE_KOD').AsString,Proje_Ad) Then
    begin
      qrySiparis.FieldByName('PROJE_AD').AsString := PROJE_Ad;
    end
    else
    begin
      qrySiparis.FieldByName('PROJE_AD').AsString := '';
      txtProjeKod.SetFocus;
    end;
  end
  else
  begin
    qrySiparis.FieldByName('PROJE_AD').AsString := '';
  end;
end;

procedure TfrmSiparis.txtFaturaDepoKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtFaturaDepoKodButtonClick(Self);
end;

procedure TfrmSiparis.txtPlasiyerKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtPlasiyerKodButtonClick(Self);
end;

procedure TfrmSiparis.txtProjeKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtProjeKodButtonClick(Self);
end;

procedure TfrmSiparis.IB_Edit5ButtonClick(Sender: TObject);
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qrySiparis.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmSiparis.IB_Edit6ButtonClick(Sender: TObject);
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qrySiparis.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmSiparis.IB_Edit7ButtonClick(Sender: TObject);
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qrySiparis.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmSiparis.IB_Edit24ButtonClick(Sender: TObject);
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qrySiparis.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmSiparis.IB_Edit25ButtonClick(Sender: TObject);
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qrySiparis.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmSiparis.txtCariKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txtCariKodButtonClick(Self);
end;

procedure TfrmSiparis.txtCariKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSiparis.txtOlcuBirimButtonClick(Sender: TObject);
var
  OlcuBir,strSQL:String;
begin
  if not (qrySiparis_D.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if qrySiparis_D.FieldByName('URUN_KOD').AsString <> '' Then
  begin
    strSQL:='SELECT OLCU_TIP FROM URUN WHERE URUN_KOD='+ SQL_Katar(qrySiparis_D.FieldByName('URUN_KOD').AsString);
    with DataMod.qryGENEL do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True ;
    end;

    if DataMod.LS_OlcuBrm(DataMod.qryGenel.FieldByname('OLCU_TIP').AsString  ,OlcuBir) then
    begin
      if not (qrySiparis_D.State in [dssEdit,dssInsert])then qrySiparis_D.Edit;
      qrySiparis_D.FieldByName('OLCUBIRIM').AsString := OlcuBir;
    end;
  end
  else
  begin
     Application.MessageBox('Ürün Seçmeden Ölçü Birimi Seçemezsiniz','DÝKKAT',MB_ICONINFORMATION);
  end;
end;

procedure TfrmSiparis.txtDepoKodButtonClick(Sender: TObject);
var
  Depo_Kod,Depo_Ad:String;
begin
  if not (qrySiparis_D.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Depo(Depo_Kod,Depo_Ad) then
  begin
    with qrySiparis_D do
    begin
      FieldByName('DEPO_KOD').AsString := Depo_Kod;
      FieldByName('DEPO_AD').AsString := Depo_Ad;
    end;
  end;
end;

procedure TfrmSiparis.txtKasaKodButtonClick(Sender: TObject);
var
  Kasa_Kod,Kasa_Ad,DOVKOD:String;
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_KASA(Kasa_Kod,Kasa_Ad,DOVKOD) Then
  begin
    with qrySiparis do
    begin
      FieldByName('KASA_KOD').AsString:=Kasa_Kod;
      FieldByName('KASA_AD').AsString:=Kasa_Ad;
    end;
  end;
end;

procedure TfrmSiparis.btnKaydetClick(Sender: TObject);
begin
  ////kaydetmeden önce kontroller yapýlacak
  if Trim(qrySiparis_D.FieldByName('URUN_KOD').AsString)='' then
  begin
    txtUrunKodu.SetFocus;
    Application.MessageBox('Ürün kodu seçimi yapmadýnýz.!!','Dikkat',MB_ICONWARNING);
    txtUrunKoduButtonClick(Self);
    exit;
  end;
  if qrySiparis_D.FieldByName('MIKTAR').AsCurrency <=0 then
  begin
    IB_Currency7.SetFocus;
    Application.MessageBox('Miktar alaný sýfýrdan küçük ya da eþit olamaz!!','Dikkat',MB_ICONWARNING);
    qrySiparis_D.FieldByName('MIKTAR').AsCurrency := 1;
    exit;
  end;

  if Trim(qrySiparis_D.FieldByName('OLCUBIRIM').AsString)='' then
  begin
    txtOlcuBirim.SetFocus;
    Application.MessageBox('Ölçü Birimi Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Exit;
  end;

  if (qrySiparis_D.FieldByName('BIRIM_FIY').AsCurrency <= 0) then
  begin
    IB_Currency5.SetFocus;
    Application.MessageBox('Birim fiyatý sýfýrdan küçük ya da eþit olamaz!!!','Dikkat',MB_ICONWARNING);
    qrySiparis_D.FieldByName('BIRIM_FIY').AsCurrency := 1;
    exit;
  end;

  if (qrySiparis_D.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    edtDOVKUR.SetFocus;
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    qrySiparis_D.FieldByName('DOVKUR').AsCurrency := 1;
    exit;
  end;

  if (qrySiparis_D.FieldByName('KDV').AsCurrency < 0) then
  begin
    IB_Edit22.SetFocus;
    Application.MessageBox('KDV oraný sýfýrdan küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    qrySiparis_D.FieldByName('KDV').AsCurrency := 0;
    exit;
  end;

  if (qrySiparis_D.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    exit;
  end;

  qrySiparis_D.Post;
//  prv_Burut_Top:=prv_Temp_Burut_Top;
end;

procedure TfrmSiparis.txtUrunKoduButtonClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad,DOVKOD,OlcuBirim, Depo_Kod, Depo_Ad:String;
  KDV_TUTAR,Fiyat:Currency;
  KDV,KDV_DAHIL:Byte;
begin
  if not (qrySiparis_D.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  //if frmUrunSDLG.Form_Open('M',False,Urun_Kod,Urun_AD,True) then
  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_AD,True) then
  begin
    qrySiparis_D.FieldByName('URUN_KOD').AsString := Urun_Kod;
    if DataMod.GET_URUN_FAT_BILGI(trnFAT_IRS,
                                  qrySiparis_D.FieldByName('URUN_KOD').AsString,
                                  qrySiparis.FieldByName('CARI_KOD').AsString,
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
      with qrySiparis_D do
      begin
        FieldByName('URUN_AD').AsString := Urun_Ad;
        FieldByName('ACIKLAMA').AsString := Urun_Ad;
        FieldByName('BIRIM_FIY').AsCurrency := Fiyat;
        FieldByName('DOVKOD').AsString := DOVKOD;
        FieldByName('OLCUBIRIM').AsString := OlcuBirim;
      end;
      //qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency  := KDV_TUTAR;
      if (Trim(qrySiparis_D.FieldByName('DEPO_KOD').AsString) = '') and glb_DEPO_UYG then
      begin
        qrySiparis_D.FieldByName('DEPO_KOD').AsString := Depo_Kod;
        qrySiparis_D.FieldByName('DEPO_AD').AsString := Depo_Ad;
      end;
      if prv_KDV_HESAPLA then
      begin
        qrySiparis_D.FieldByName('KDV').AsSmallInt := KDV;
      end
      else
      begin
        qrySiparis_D.FieldByName('KDV').AsSmallInt := 0;
      end;
    end;
  end;

end;

procedure TfrmSiparis.btnEKLEClick(Sender: TObject);
begin
  qrySiparis_D.Append;
  txtUrunKodu.SetFocus;
end;

procedure TfrmSiparis.btnIptalClick(Sender: TObject);
begin
  qrySiparis_D.Cancel;
end;

procedure TfrmSiparis.btnSilClick(Sender: TObject);
begin
  if qrySiparis_D.FieldByName('AKTARILAN_MIKTAR').AsFloat>0 then
  begin
     Application.MessageBox('Bu Sipariþ Kalemi faturalaþtýrlmýþtýr. Deðiþiklik Yapamazsýnýz','DÝKKAT',MB_ICONWARNING);
     Abort;
  end;

  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Exit;
  qrySiparis_D.Delete;
end;

procedure TfrmSiparis.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSiparis.btnAraClick(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if frmSIP_SDLG.Form_Open(False,prv_FAT_IRS_SEP,FAT_IRS_ID,FAT_IRS_SID,prv_FAT_TIP,False) then
  begin
    DataSet_Open(FAT_IRS_ID,FAT_IRS_SID,1);
  end;
end;

procedure TfrmSiparis.DataSet_Open(FAT_IRS_ID:Integer;FAT_IRS_SID:Integer;ISLEM:Byte);
begin
  if ((ISLEM = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmSiparis do
  begin
    DataMod.Rapor_Kod_Visible_Fields_IB('FAT',ib_edit5,ib_edit6,ib_edit7,ib_edit24,ib_edit25);
    prv_ISN := DataMod.Get_Isn_Num;
    txtCariKod.Enabled := True;
//****************************************************************************//
    with qrySiparis do
    begin
      Active := False;
      ParamByName('PRM_FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
      ParambyName('PRM_FAT_IRS_ID').AsInteger := FAT_IRS_ID;
      ParambyName('PRM_FAT_IRS_SID').AsInteger := FAT_IRS_SID;
      Active := True;
    end;
//****************************************************************************//
    prn_FATURA_ID := FAT_IRS_ID;
    prn_FATURA_SID := FAT_IRS_SID;
//****************************************************************************//
    case Islem of
    0:
      begin
        qrySiparis.Insert;
        prv_KDV_HESAPLA := True;
        cmbFATURA_TIP.Enabled := True;
      end;
    1:
      begin
        if qrySiparis.FieldByName('MUHTELIF').AsSmallint = 1 then
        begin
          grpBoxMuhtelif.Visible := True;
          grpBoxCari.Visible := False;
//****************************************************************************//
          with qryFAT_IRS_MUH_CARI do
          begin
            Active := False;
            //ParamByName('PRM_FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
            ParamByName('PRM_FAT_IRS_SEP').AsInteger := 3;
            ParamByName('PRM_FAT_IRS_ID').AsInteger := FAT_IRS_ID;
            ParamByName('PRM_FAT_IRS_SID').AsInteger := FAT_IRS_SID;
            Active := True;
          end;
//****************************************************************************//

          btnMuhtelifIptal.Visible := False;
          txtCariKod.Enabled := False;
        end
        else
        if qrySiparis.FieldByName('MUHTELIF').AsSmallint = 0 then
        begin
          grpBoxMuhtelif.Visible := False;
          grpBoxCari.Visible := True;
          if DataMod.FN_CariKOD2Bilgi(qrySiparis.FieldByName('CARI_KOD').AsString ,res_Cari) then
          begin
            Cari2Labels;
          end;
        end;
        qrySiparis.Edit;
//****************************************************************************//
//****************************************************************************//
        cmbFATURA_TIP.Enabled := False;
      end;
    end;
//****************************************************************************//
    with qrySiparis_D do
    begin
      Active := False;
      ParamByName('PRM_FATURA_ID').AsInteger :=  qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
      ParamByName('PRM_FATURA_SID').AsInteger := qrySiparis.FieldByName('FAT_IRS_SID').AsInteger;
      Active := True;
    end;
//****************************************************************************//
   { if (qrySiparis.FieldByName('TIP').AsInteger = 1) and (qrySiparis.FieldByName('FAT_IRS_TIP').AsInteger = 4) then
    begin
      prv_KDV_HESAPLA := False;
    end
    else
    begin
      prv_KDV_HESAPLA := True;
    end;
    }
    prv_KDV_HESAPLA := True;
  end;//with
end;

function TfrmSiparis.Form_Before_Post: Boolean;
begin
  Result := False;

  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  KDV_Hesapla;

  if Trim(qrySiparis.FieldByName('FAT_IRS_SERI').AsString) = ''  then
  begin
    IB_Edit1.SetFocus;
    Application.MessageBox('Sipariþ Seri Numarasý Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

//bu kontrol geçici olarak eklendi daha sonra
//parametrelere aktarýlacak fatura aralýklarýný kontrol ediyor
//ve þubelere ait fatura aralýklarýna bakýyor.
//þubelerin yanlýþ fatura numarasý girip kayýt yapmamalarý için
//eklendi.

  if Trim(qrySiparis.FieldByName('BELGE_NO').AsString) = ''  then
  begin
    IB_Edit3.SetFocus;
    Application.MessageBox('Belge No Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  if Trim(qrySiparis.FieldByName('CARI_KOD').AsString) = ''  then
  begin
    txtCariKod.SetFocus;
    Application.MessageBox('Cari Kod Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  if Trim(qrySiparis.FieldByName('ACIKLAMA').AsString) = ''  then
  begin
    IB_Edit40.SetFocus;
    Application.MessageBox('Sipariþ Açýklamasý Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

 {Lite
 if (Trim(qrySiparis.FieldByName('YEV_ACIKLAMA').AsString) = '') then
  begin
    IB_Edit26.SetFocus;
    Application.MessageBox('Yevmiye Açýklamasý Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;
  }
  if qrySiparis_D.RecordCount = 0 then
  begin
    Application.MessageBox('Sipariþ Kalemi Olmadan Sipariþi Kaydedemezsiniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  //if qrySiparis.FieldByName('FAT_IRS_TIP').AsSmallint = 1 Then
  //begin
   { if (Trim(qrySiparis.FieldByName('KASA_KOD').AsString)='') Then
    begin
      Application.MessageBox('Kasa Kodu Alanýna Veri Girmediniz ..!','DÝKKAT',MB_ICONWARNING);
      exit;
    end;
   }
  //end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qrySiparis.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qrySiparis.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qrySiparis.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qrySiparis.FieldByName('VADE_TARIH').AsDate, 'Vade Tarihi') then Exit;

  if qrySiparis.State in [dsSINSERT] then
  if  DataMod.Seri_No_Kontrolu(qrySiparis,'SIPARIS',prv_FAT_IRS_SEP,qrySiparis.FieldByName('FAT_IRS_ID').asInteger,prv_FAT_TIP,
  qrySiparis.FieldByName('FAT_IRS_SERI').asString,
  qrySiparis.FieldByName('BELGE_NO').asString,
  qrySiparis.FieldByName('CARI_KOD').asString) then Exit;

  Result := True;
end;

procedure TfrmSiparis.Form_Post;
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
    prn_FATURA_ID := qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
    prn_FATURA_SID := qrySiparis.FieldByName('FAT_IRS_SID').AsSmallint;
//****************************************************************************//
      //ApplyDatasets;
    qrySiparis.ApplyUpdates;
    qrySiparis.CommitUpdates;

    qrySiparis_D.ApplyUpdates;
    qrySiparis_D.CommitUpdates;

//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SIPARIS,',
                                             prv_BELGE_TUR,
                                             qrySiparis.FieldByName('FAT_IRS_ID').AsInteger,
                                             qrySiparis.FieldByName('FAT_IRS_SID').AsSmallint,
                                             1,1,'SIPARIS');
//****************************************************************************//
    trnFAT_IRS.Commit;
//****************************************************************************//
    if rgYAZICI.ItemIndex < 2 then
    if Dm_Fast_Report.Yeni_Rapor_Varmi(371)>0 then
    begin
         Dm_Fast_Report.Rapor_Ac(0,371,37,1,rgYAZICI.ItemIndex,prn_FATURA_ID,prn_FATURA_SID,0,'');
    end
    else
      if rgYAZICI.ItemIndex < 2 then
      Yazici.SIPARIS(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex);

    prn_FATURA_ID := 0;
    prn_FATURA_SID := 0;
  except
    trnFAT_IRS.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  CommitUpdates;
//****************************************************************************//
  grpBoxCari.Visible := False;
//****************************************************************************//
end;

function TfrmSiparis.Form_Before_Delete:Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  qrySiparis_D.First;
  while not qrySiparis_D.Eof do
  begin
    if qrySiparis_D.FieldByName('AKTARILAN_MIKTAR').AsFloat>0 then
    begin
       Application.MessageBox('Bu Sipariþ Kalemi faturalaþtýrýlmýþtýr. Deðiþiklik Yapamazsýnýz','DÝKKAT',MB_ICONWARNING);
       exit;
    end;
    qrySiparis_D.Next;
  end;

  if not DataMod.EN_GER_KAY_TAR_KONTROL(qrySiparis.FieldByName('TARIH').AsDate,True) then Exit;
  Result := True;
end;

procedure TfrmSiparis.Form_Delete;
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if not Form_Before_Delete then exit;
  if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trnFAT_IRS.InTransaction then
       trnFAT_IRS.Rollback;
    trnFAT_IRS.StartTransaction;
//****************************************************************************//
//****************************************************************************//
    if not ((qrySiparis_D.Eof) and (qrySiparis_D.Bof)) then
    begin
      qrySiparis_D.First;
      while not qrySiparis_D.Eof do
      begin
        qrySiparis_D.Delete;
        qrySiparis_D.First;
      end;
    end;
//****************************************************************************//
    FAT_IRS_ID := qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
    FAT_IRS_SID := qrySiparis.FieldByName('FAT_IRS_SID').AsInteger;
//****************************************************************************//
    qrySiparis.Delete;
    //ApplyDatasets;

    qryFAT_IRS_MUH_CARI.ApplyUpdates;
    qryFAT_IRS_MUH_CARI.CommitUpdates;


    qrySiparis_D.ApplyUpdates;
    qrySiparis_D.CommitUpdates;

    qrySiparis.ApplyUpdates;
    qrySiparis.CommitUpdates;

//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SIPARIS,',
                                             prv_BELGE_TUR,
                                             FAT_IRS_ID,
                                             FAT_IRS_SID,
                                             1,2,'SIPARIS');
//****************************************************************************//
    trnFAT_IRS.Commit;
//****************************************************************************//
  except
    trnFAT_IRS.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  CommitUpdates;
  grpBoxCari.Visible := False;
//  grpBoxMuhtelif.Visible := False;
end;



procedure TfrmSiparis.ApplyDatasets;
begin
  qrySiparis.ApplyUpdates;
  qrySiparis.CommitUpdates;

  qrySiparis_D.ApplyUpdates;
  qrySiparis_D.CommitUpdates;

  qryFAT_IRS_MUH_CARI.ApplyUpdates;
  qryFAT_IRS_MUH_CARI.CommitUpdates;
end;

procedure TfrmSiparis.CommitUpdates;
begin
  qryFAT_IRS_MUH_CARI.Close;
  qrySiparis_D.Close;
  qrySiparis.Close;
end;

procedure TfrmSiparis.CancelUpdates;
begin
  qryFAT_IRS_MUH_CARI.CancelUpdates;
  qrySiparis_D.CancelUpdates;
  qrySiparis.CancelUpdates;

  qryFAT_IRS_MUH_CARI.CommitUpdates;
  qrySiparis_D.CommitUpdates;
  qrySiparis.CommitUpdates;
end;

procedure TfrmSiparis.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmSiparis.btnTRN_KAYDETClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmSiparis.btnTRN_IPTALClick(Sender: TObject);
begin
  if Sender.ClassName <> 'TButton'  then
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
  else
  begin
    if Application.MessageBox('Ýptal etmek istediðinizden emin misiniz?','Dikkat',MB_YESNO+MB_ICONQUESTION)=ID_YES then
    begin
      //if prv_FAT_TIP = 1 then DataMod.Add_Sayaclar_Nu('SATIS_FATURA',qryFAT_IRS.FieldByName('BELGE_NO').AsInteger);
      CancelUpdates;
      CommitUpdates;
//****************************************************************************//
      if trnFAT_IRS.InTransaction then
         trnFAT_IRS.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
      grpBoxCari.Visible := False;
//      grpBoxMuhtelif.Visible := False;
//****************************************************************************//
      prn_FATURA_ID := 0;
      prn_FATURA_SID := 0;
    end;
  end;
end;

procedure TfrmSiparis.btnFaturaSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmSiparis.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmSiparis.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.color :=clWindow;
end;

procedure TfrmSiparis.IB_Edit3Exit(Sender: TObject);
var
  qryTEMP:TIB_Query;
  Msg:PChar;
begin
    {try
      if dtsSiparis.State in [dsSINSERT] then
      begin
        DataMod.CreateQuery(qryTemp,nil,False,DataMod.dbaMain);
        //qryTEMP := TIB_Query.Create(Self);
        //qryTEMP.IB_Connection := DataMod.dbaMain;
        qryTEMP.SQL.Add('SELECT COUNT(FAT_IRS_ID) AS KAY_SAY FROM SIPARIS WHERE SIPARIS.FAT_IRS_SERI= ' + SQL_Katar(IB_Edit1.Text) + ' AND SIPARIS.BELGE_NO = ' + SQL_Katar(IB_Edit3.Text));
        qryTEMP.Open;
        if qryTEMP.FieldByName('KAY_SAY').AsInteger > 0 then
        begin
          Application.MessageBox('Mükerrer Sipariþ Numarasý Giriyorsunuz!','Dikkat',MB_ICONINFORMATION);
          IB_Edit3.SetFocus;
          Exit;
        end;
      end;
      my_Active_Comp.Brush.color := clWindow;
    except
      Msg := PChar(qryTEMP.SQL[0] + ' Sorgusunda hata oluþtu');
      Application.MessageBox(Msg,'Dikkat',MB_ICONHAND);
    end;//end try
    }
      my_Active_Comp.Brush.color := clWindow;
end;

procedure TfrmSiparis.IB_Edit5Exit(Sender: TObject);
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

procedure TfrmSiparis.IB_Edit6Exit(Sender: TObject);
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

procedure TfrmSiparis.IB_Edit7Exit(Sender: TObject);
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

procedure TfrmSiparis.IB_Edit24Exit(Sender: TObject);
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

procedure TfrmSiparis.IB_Edit25Exit(Sender: TObject);
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

procedure TfrmSiparis.IB_Edit25KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit25ButtonClick(Self);
end;

procedure TfrmSiparis.IB_Edit24KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit24ButtonClick(Self);
end;

procedure TfrmSiparis.IB_Edit7KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit7ButtonClick(Self);
end;

procedure TfrmSiparis.IB_Edit6KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit6ButtonClick(Self);
end;

procedure TfrmSiparis.IB_Edit5KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit5ButtonClick(Self);
end;


procedure TfrmSiparis.dtsSiparisDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  if Assigned( Field ) then
  begin
//****************************************************************************//
    if ((Field.FieldName='VADE_TARIH') or (Field.FieldName='TARIH')) then
    begin
      if ((qrySiparis.FieldByName('VADE_TARIH').AsString<>'') and (qrySiparis.FieldByName('TARIH').AsString<>'')) then
      begin
        qrySiparis.FieldByName('VADE_GUN').AsDouble := (qrySiparis.FieldByName('VADE_TARIH').AsDate-qrySiparis.FieldByName('TARIH').AsDate);
      end;
    end;
//****************************************************************************//
    if ((Field.FieldName='ISKONTO_ORAN') and (qrySiparis.FieldByName('ISKONTO_TIP').AsSmallInt=0)) then
    begin
      qrySiparis.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qrySiparis.FieldByName('ISKONTO_ORAN').AsInteger *(qrySiparis.FieldByName('BRUT_TOP').AsCurrency/100);
      qrySiparis.FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := qrySiparis.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency + qrySiparis.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency;
      FaturaToplamHesapla;
    end;
//****************************************************************************//
    if ((Field.FieldName='ISKONTO_TUTAR_VPB') and (qrySiparis.FieldByName('ISKONTO_TIP').AsSmallInt=1)) then
    begin
      qrySiparis.FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := qrySiparis.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency + qrySiparis.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency;
      FaturaToplamHesapla;
    end;
//****************************************************************************//
    if (Field.FieldName='OTV') then
    begin
      FaturaToplamHesapla;
    end;
//****************************************************************************//
    {if (Field.FieldName = 'FAT_IRS_TIP') then
    begin
      //satýþ faturasý ve ithalat ihracat ise
      if (qrySiparis.FieldByName('TIP').AsInteger = 1) and (qrySiparis.FieldByName('FAT_IRS_TIP').AsInteger = 4) then
      begin
        prv_KDV_HESAPLA := False
      end
      else
      begin
        prv_KDV_HESAPLA := True;
      end;
    end;}
        prv_KDV_HESAPLA := True;
//****************************************************************************//
  end;// assigned(field) then end;
end;

procedure TfrmSiparis.FaturaToplamHesapla;
begin
  with qrySiparis do
  begin
    FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency+FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
    FieldByName('NET_TOP').AsCurrency := FieldByName('BRUT_TOP').AsCurrency -(FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency+FieldByName('ISKONTO_TUTAR_VPB').AsCurrency);
    FieldByName('GENEL_TOP').AsCurrency := FieldByName('NET_TOP').AsCurrency + FieldByName('KDV_TOP').AsCurrency+FieldByName('OTV').AsCurrency;
  end;
end;

procedure TfrmSiparis.dtsSiparisStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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

    if qrySiparis.FieldByName('FAT_IRS_ID').AsInteger<=0 then
      btnFaturaSil.Enabled := False
    else
      btnFaturaSil.Enabled := True;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
  end;
end;

procedure TfrmSiparis.dstSiparis_DStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
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
    {if not ((qrySiparis_D.Eof) and (qrySiparis_D.Bof)) then
    begin
      btnSil.Enabled := True
    end
    else
    begin
      btnSil.Enabled := False;
    end;  }

    if ADataset.FieldByName('URUNHAR_ID').AsInteger<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;
          
    btnKAYDET.Enabled := False;
    btnIPTAL.Enabled := False;
    grdFatKontrol.Enabled := True;
  end;
end;

procedure TfrmSiparis.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if qrySiparis.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Sipariþ bilgileri bölümünde yaptýðýnýz deðiþiklikleri kaydeniniz veya iptal ediniz.','DÝKKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmSiparis.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmSiparis);
  res_Cari:=TStringList.Create;
  pgFAT_IRS.ActivePage:=tabFAT_IRS;
  {$IfDef TRANSPORT}
  txtDepoKod.Visible:=False;
  txtDepoAd.Visible:=False;
  txtFaturaDepoKod.Visible:=False;
  txtFaturaDepoAD.Visible:=False;
  txtProjeKod.Visible:=False;
  txtFaturaProjeAD.Visible:=False;
  {$EndIf}
end;

procedure TfrmSiparis.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TfrmSiparis.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmSiparis.FormResize(Sender: TObject);
begin
  btnCikis.Left := frmSiparis.Width  - (btnCikis.Width + 25 );
  btnAra.Left := frmSiparis.Width  - ( btnCikis.Width + btnAra.Width + 28 );
end;

procedure TfrmSiparis.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmSiparis.rdFatIsTipChange(Sender: TObject);
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

procedure TfrmSiparis.edtDOVKURExit(Sender: TObject);
begin
  if not (qrySiparis_D.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if (qrySiparis_D.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
    qrySiparis_D.FieldByName('DOVKUR').AsCurrency := 1;
    edtDOVKUR.SetFocus;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmSiparis.rdIskontoChange(Sender: TObject);
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
  if qrySiparis_D.State in [dssEdit,dssInsert] Then
  begin
    with qrySiparis_D do
    begin
      FieldByName('ISKONTO_ORAN').AsString := '';
      FieldByName('ISKONTO_TUTAR').AsString := '';
    end;
  end;
//****************************************************************************//
end;

procedure TfrmSiparis.qrySiparisAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qrySiparis do
  begin
    FieldByName('FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
    FieldByName('FAT_IRS_ID').AsInteger := qrySiparis.Gen_ID('GEN_SIPARIS',1);
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
    case prv_FAT_TIP of
    1://satýþ faturasý
      begin
        if glb_SUBELI then
        begin
          FieldByName('FAT_IRS_SERI').AsString := DataMod.GETPARAM(cns_musteri_siparis,'SIP_SERI',glb_SID);
          FieldByName('BELGE_NO').AsString := IntToStr(DataMod.GET_SAYAC_NUM('MUSTERI_SIP',True,False,glb_SID));
        end
        else
        begin
          FieldByName('FAT_IRS_SERI').AsString := DataMod.GETPARAM(cns_musteri_siparis,'SIP_SERI',0);
          FieldByName('BELGE_NO').AsString := IntToStr(DataMod.GET_SAYAC_NUM('MUSTERI_SIP',True,False,0));
        end;
      end;
    2://alýþ faturasý
      begin
        //FieldByName('FAT_IRS_SERI').AsString := DataMod.GETPARAM(cns_satis_fatura,'FAT_SERI',glb_SID);
      end;
    end;//end case
  end; //with qryFAT_IRS do
  IB_Edit1.SetFocus;
end;

procedure TfrmSiparis.KalemBrutHesapla(Sil:Boolean);
var
  MyBookMark:String;
  MyBrutTop:Currency;
begin
  try
    MyBrutTop := 0;
    with qrySiparis_D do
    begin
       MyBookMark := Bookmark;
       DisableControls;
       First;
       while not eof do
       begin
         MyBrutTop := MyBrutTop + FieldByName('TUTAR_VPB').AsCurrency;
         Next;
       end;    // whýle
       if Not sil then Bookmark := MyBookMark;
    end;    // wýth
    qrySiparis.FieldByName('BRUT_TOP').AsCurrency := MyBrutTop;
  finally
    qrySiparis_D.EnableControls;
  end;
end;

procedure TfrmSiparis.qrySiparis_DAfterDelete(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(True);
end;

procedure TfrmSiparis.qrySiparis_DAfterInsert(IB_Dataset: TIB_Dataset);
begin
   with IB_Dataset do
   begin
     FieldByName('URUNHAR_ID').AsInteger := qrySiparis_D.Gen_ID('GEN_SIPARIS_D',1);
     FieldByName('URUNHAR_SID').AsInteger := glb_SID;
     FieldByName('MIKTAR').AsInteger := 1;
     FieldByName('FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
     FieldByName('FATURA_ID').AsInteger := qrySiparis.FieldByName('FAT_IRS_ID').AsInteger ;
     FieldByName('FATURA_SID').AsInteger := qrySiparis.FieldByName('FAT_IRS_SID').AsInteger ;
     FieldByName('IRSALIYE_ID').AsInteger := 0;
     FieldByName('IRSALIYE_SID').AsInteger := 0;
     FieldByName('DEPO_KOD').AsString := qrySiparis.FieldByName('DEPO_KOD').AsString;
     FieldByName('DEPO_AD').AsString := qrySiparis.FieldByName('DEPO_AD').AsString ;
     FieldByName('TARIH').AsDate := qrySiparis.FieldByName('TARIH').AsDate;
     FieldByName('DOV_BAZ_TAR').AsDate := qrySiparis.FieldByName('DOV_BAZ_TAR').AsDate;
     FieldByName('BELGE_TUR').AsInteger := prv_BELGE_TUR;
     FieldByName('BELGE_ID').AsInteger := qrySiparis.FieldByName('FAT_IRS_ID').AsInteger ;
     FieldByName('BELGE_SID').AsInteger := qrySiparis.FieldByName('FAT_IRS_SID').AsInteger ;
     FieldByName('BELGE_SIRA_NO').AsInteger := 1;
     FieldByName('ISKONTO_TIP').AsInteger := 0;
     FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := 0 ;

     FieldByName('KAPANDI').AsInteger := 0;
     FieldByName('AKTARILAN_MIKTAR').AsFloat := 0 ;


     FieldByName('DOVKOD').AsString := glb_DEFCUR;
     If (prv_FAT_TIP = 1) then  //SATIÞ
     begin
       FieldByName('TIP').AsString :=  ALACAK;
     end else
     begin   //ALIÞ
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

procedure TfrmSiparis.qrySiparis_DAfterPost(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(False);
end;

procedure TfrmSiparis.qrySiparis_DBeforePost(IB_Dataset: TIB_Dataset);
var
  BIRIMFIY_URN_DOVKOD,
  TUTAR_URN_DOVKOD,
  MIKTAR_URN_OLCUBIRIM,
  BIRIMFIY_VPB:Currency;
  URUN_DOVKOD,URUN_OLCUBIRIM:String;
begin


  if IB_Dataset.FieldByName('AKTARILAN_MIKTAR').AsFloat>0 then
  begin
     Application.MessageBox('Bu Sipariþ Kalemi faturalaþtýrýlmýþtýr. Deðiþiklik Yapamazsýnýz','DÝKKAT',MB_ICONWARNING);
     Abort;
  end;

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
end;

procedure TfrmSiparis.KalemHesapla;
begin
/// ürün secilmediði zaman miktar hesaplamalara 1 olarak katýlacak
// yada hesaplamalardan cýkarýlacak

  qrySiparis_D.FieldByName('TUTAR').AsCurrency := qrySiparis_D.FieldByNAme('MIKTAR').AsCurrency * qrySiparis_D.FieldByName('BIRIM_FIY').AsCurrency;
  qrySiparis_D.FieldByName('TUTAR_VPB').AsCurrency := qrySiparis_D.FieldByNAme('MIKTAR').AsCurrency * qrySiparis_D.FieldByName('BIRIM_FIY').AsCurrency*qrySiparis_D.FieldByName('DOVKUR').AsCurrency;


  if qrySiparis_D.FieldByName('ISKONTO_TIP').AsSmallInt=0 then
  begin //oran yani
    qrySiparis_D.FieldByName('ISKONTO_TUTAR').AsCurrency := qrySiparis_D.FieldByName('ISKONTO_ORAN').AsInteger*(qrySiparis_D.FieldByName('TUTAR').AsCurrency/100);
    qrySiparis_D.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qrySiparis_D.FieldByName('ISKONTO_TUTAR').AsCurrency * qrySiparis_D.FieldByName('DOVKUR').AsCurrency;
  end
  else
  begin // tutar yani
    qrySiparis_D.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qrySiparis_D.FieldByName('ISKONTO_TUTAR').AsCurrency * qrySiparis_D.FieldByName('DOVKUR').AsCurrency;
  end;

  if prv_KDV_HESAPLA then
  begin
    if qrySiparis_D.FieldByName('KDV').AsInteger <> 0 then
    qrySiparis_D.FieldByName('KDV_TUTAR').AsCurrency :=
    (qrySiparis_D.FieldByName('TUTAR_VPB').AsCurrency-qrySiparis_D.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) * (qrySiparis_D.FieldByName('KDV').AsInteger / 100);
  end
  else
  begin
    qrySiparis_D.FieldByName('KDV_TUTAR').AsCurrency := 0;
  end;
end;

procedure TfrmSiparis.FN_BIRIMFIYAT;
var
  Birim:Currency;
  qryURUN:TIB_Query; ErrMsg:PChar;
  Urun_Kod,Urun_Ad,DOVKOD,OlcuBirim, Depo_Kod, Depo_Ad:String;
  KDV_TUTAR,Fiyat:Currency;
  KDV,KDV_DAHIL:Byte;

begin
     if DataMod.GET_URUN_FAT_BILGI(trnFAT_IRS,
                                  qrySiparis_D.FieldByName('URUN_KOD').AsString,
                                  qrySiparis.FieldByName('CARI_KOD').AsString,
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
       datamod.OLCUBIRIM_DONUSTUR(qrySiparis_D.fieldbyname('OLCUBIRIM').AsString,1,OlcuBirim,Birim);
       qrySiparis_D.FieldByName('BIRIM_FIY').AsCurrency :=Birim*Fiyat;
     end;
end;

procedure TfrmSiparis.dstSiparis_DDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
var
  DOV_KUR:Currency;
begin
  if Assigned( Field ) then
  begin
    if (Field.FieldName='DOVKOD') then
    begin
      DOV_KUR := DataMod.Get_Doviz_Kur(qrySiparis_D.FieldByName('DOVKOD').AsString,qrySiparis.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
      if DOV_KUR<>0 then
      begin
        qrySiparis_D.FieldByName('DOVKUR').AsCurrency := DOV_KUR ;
      end
      else
      begin
        qrySiparis_D.FieldByName('DOVKUR').AsCurrency := 1 ;
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
    if ((Field.FieldName='ISKONTO_ORAN') and (qrySiparis_D.FieldByName('ISKONTO_TIP').AsSmallInt=0)) then
    begin
      KalemHesapla;
    end;
//****************************************************************************//
    if ((Field.FieldName='ISKONTO_TUTAR') and (qrySiparis_D.FieldByName('ISKONTO_TIP').AsSmallInt=1)) then
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


procedure TfrmSiparis.KDV_Hesapla;
var
  temp:Array [1..5] of TKDV;
  i,j,Sayac:Integer;
  TopKDV,BURUTTOP,KALISKONTOTOP:Currency;
begin
  //qrySiparis_D.DisableControls;
  dstSiparis_D.DisableControls;
  prv_MY_Index:=-1;
  sayac := 1;
//****************************************************************************//
  for i:=1 to 6 do
  begin
    arr_KDV[i].KDV:=-1;
    arr_KDV[i].KDVTUTAR:=0;
  end;
//****************************************************************************//
  qrySiparis_D.First;
  BURUTTOP := 0;
  KALISKONTOTOP := 0;
//****************************************************************************//
  while not qrySiparis_D.Eof do
  begin
//****************************************************************************//
    for i:=1 to 5 do
    begin
      if arr_KDV[i].KDV=qrySiparis_D.FieldByName('KDV').AsSmallInt Then
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
      arr_KDV[sayac].KDV := qrySiparis_D.FieldByName('KDV').AsSmallInt ;
      arr_KDV[sayac].KDVTUTAR :=
      (qrySiparis_D.FieldByName('TUTAR_VPB').AsCurrency-qrySiparis_D.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) *  qrySiparis_D.FieldByName('KDV').AsSmallInt/100;
      BURUTTOP := BURUTTOP + qrySiparis_D.FieldByName('TUTAR_VPB').AsCurrency;
      KALISKONTOTOP := KALISKONTOTOP + qrySiparis_D.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
      inc(Sayac);
    end
    else
    begin
      arr_KDV[prv_MY_Index].KDVTUTAR :=
      arr_KDV[prv_MY_Index].KDVTUTAR +
      ((qrySiparis_D.FieldByName('TUTAR_VPB').AsCurrency-qrySiparis_D.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) *  qrySiparis_D.FieldByName('KDV').AsSMallInt/100);
      BURUTTOP := BURUTTOP + qrySiparis_D.FieldByName('TUTAR_VPB').AsCurrency;
      KALISKONTOTOP := KALISKONTOTOP + qrySiparis_D.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
    end;
//****************************************************************************//
    qrySiparis_D.Next;
  end;
//****************************************************************************//
  qrySiparis_D.First;
  //qrySiparis_D.EnableControls;
  dstSiparis_D.EnableControls;
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
  if qrySiparis.State in [dssEdit,dssInsert] then
  begin
    with qrySiparis do
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
    /// sýralama sonu
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
        if  prv_KDV_HESAPLA then // KDV Hesaplamamasý gerekiyorsa veri atmýyor
        begin
          qrySiparis.FieldByName('KDV'+ IntToStr(sayac) + '_ORAN').AsSmallint:=arr_KDV[i].KDV;
          qrySiparis.FieldByName('KDV'+ IntToStr(sayac)).AsCurrency :=arr_KDV[i].KDVTUTAR ;
        end;
//****************************************************************************//
        TopKDV := TopKDV +  arr_KDV[i].KDVTUTAR ;
//****************************************************************************//
      end;
//****************************************************************************//
    end;
//****************************************************************************//
    if  prv_KDV_HESAPLA then qrySiparis.FieldByName('KDV_TOP').AsCurrency := TopKDV;
//****************************************************************************//
    with qrySiparis do
    begin
      FieldByName('BRUT_TOP').AsCurrency := BURUTTOP;
      FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency := KALISKONTOTOP;
      FieldByName('NET_TOP').AsCurrency := qrySiparis.FieldByName('BRUT_TOP').AsCurrency -(qrySiparis.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency +qrySiparis.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency);
      FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := qrySiparis.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency + qrySiparis.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
      FieldByName('GENEL_TOP').AsCurrency := qrySiparis.FieldByName('NET_TOP').AsCurrency + qrySiparis.FieldByName('KDV_TOP').AsCurrency ;
    end;
//****************************************************************************//
  end;
end;

procedure TfrmSiparis.btnCiktiClick(Sender: TObject);
begin
  if qrySiparis.FieldByName('FAT_IRS_ID').AsInteger<=0 then Exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(371)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,371,37,1,rgYAZICI.ItemIndex,prn_FATURA_ID,prn_FATURA_SID,0,'');
  end
  else
  if rgYAZICI.ItemIndex < 2 then
  Yazici.SIPARIS(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex);
end;

procedure TfrmSiparis.pgFAT_IRSChange(Sender: TObject);
begin
  try
    if pgFAT_IRS.ActivePage = tabFAT_IRS then
    begin
      if qrySiparis.FieldByName('MUHTELIF').AsInteger = 1 then
      begin
        btnMuhtelifIptal.Visible := False;
      end;
    end
    else
    if pgFAT_IRS.ActivePage = tabKalem then
    begin
      if qrySiparis_D.Active = False then
      begin
        prv_Burut_Top := qrySiparis.FieldByName('BRUT_TOP').AsCurrency;
        prv_Temp_Burut_Top := qrySiparis.FieldByName('BRUT_TOP').AsCurrency;
      end;
    end
    else
    if pgFAT_IRS.ActivePage = tabToplam then
    begin
      {if qrySiparis.FieldByName('FAT_IRS_TIP').AsSmallint =  1 then
      begin
        txtKasaKod.Visible := True;
        txtKasaAd.Visible := True;
      end
      else
      begin
        txtKasaKod.Visible := False;
        txtKasaAd.Visible := False;
      end;}

        txtKasaKod.Visible := False;
        txtKasaAd.Visible := False;

    end
    else
    {if pgFAT_IRS.ActivePage = tabAciklama then
    begin
       EkAciklamaOpen;
    end;
    }
  finally
    qrySiparis_D.EnableControls;
  end;
end;

procedure TfrmSiparis.pgFAT_IRSChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if pgFAT_IRS.ActivePage = tabFAT_IRS Then
  begin
       qrySiparis.UpdateData;
       if Trim(qrySiparis.FieldByName('CARI_KOD').AsString) = '' Then
       begin
         txtCariKod.SetFocus;
         Application.MessageBox('Cari Bilgisi olmadan bu alana geçemezsiniz.','Dikkat',MB_ICONWARNING);
         AllowChange:= False;
         txtCariKodButtonClick(Self);
       end
       else
       if qrySiparis.FieldByName('MUHTELIF').AsSmallInt = 1 Then
       begin
         if qryFAT_IRS_MUH_CARI.State in [dssEdit,dssInsert] Then
         begin
           if qryFAT_IRS_MUH_CARI.FieldByName('CARI_AD').AsString='' Then
           begin
             Application.MessageBox('Cari Adý alanýna bilgi girmelisiniz.','Dikkat',MB_ICONWARNING);
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
    if qrySiparis_D.State in [dssEdit,dssInsert] Then
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
end;

procedure TfrmSiparis.txtKasaKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 Then txtKasaKodButtonClick(Self);
end;

procedure TfrmSiparis.txtUrunKoduKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 Then txtUrunKoduButtonClick(Self);
end;

procedure TfrmSiparis.txtDepoKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 Then txtDepoKodButtonClick(Self);
end;

procedure TfrmSiparis.txtOlcuBirimKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 Then txtOlcuBirimButtonClick(Self);
end;

procedure TfrmSiparis.txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
begin

  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSiparis.Panel5DblClick(Sender: TObject);
begin
   qrySiparis.Edit;
end;

procedure TfrmSiparis.txtCariKodExit(Sender: TObject);
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
          qrySiparis.FieldByName('MUHTELIF').AsSmallint := 1;
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

procedure TfrmSiparis.txtUrunKoduExit(Sender: TObject);
var
 KDV_TUTAR,Fiyat:Currency;
 DOVKOD,Urun_Ad,OlcuBirim,Depo_Kod,Depo_Ad:String;
 KDV,KDV_DAHIL:Byte;
begin
  txtUrunKodu.Color := clWindow;
  if not (qrySiparis_D.State in [dssEdit,dssInsert]) then exit;
//****************************************************************************//
  if Trim(txtUrunKodu.Text) <> '' then
  begin
    if DataMod.GET_URUN_FAT_BILGI(trnFAT_IRS,
                                  txtUrunKodu.Text,
                                  qrySiparis_D.FieldByName('URUN_KOD').AsString,
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
      if Trim(qrySiparis_D.FieldByName('URUN_AD').AsString) <> Urun_Ad then
      // Ayný ise bilgiler le oynama
      begin

        with qrySiparis_D do
        begin
          FieldByName('URUN_AD').AsString := Urun_Ad;
          FieldByName('ACIKLAMA').AsString := Urun_Ad;
          FieldByName('BIRIM_FIY').AsCurrency := Fiyat;
          FieldByName('DOVKOD').AsString := DOVKOD;
          FieldByName('OLCUBIRIM').AsString := OlcuBirim;
        end;

        if (Trim(qrySiparis_D.FieldByName('DEPO_KOD').AsString) = '') AND glb_DEPO_UYG Then
        begin
          with qrySiparis_D do
          begin
            FieldByName('DEPO_KOD').AsString := Depo_Kod;
            FieldByName('DEPO_AD').AsString := Depo_Ad;
          end;
        end;

        if prv_KDV_HESAPLA then
        begin
          with qrySiparis_D do
          begin
            FieldByName('KDV').AsSmallInt := KDV;
            FieldByName('KDV_TUTAR').AsCurrency  := KDV_TUTAR;
          end;
        end
        else
        begin
          with qrySiparis_D do
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
  //
  end;
end;

procedure TfrmSiparis.txtDepoKodExit(Sender: TObject);
var
  Depo_Ad:String;
begin
  txtDepoKod.Color := clWindow;
  if Trim(txtDepoKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('DEPO','DEPO_KOD','ADI',qrySiparis_D.FieldByName('DEPO_KOD').AsString,Depo_Ad) Then
    begin
      qrySiparis_D.FieldByName('DEPO_AD').AsString := Depo_Ad;
    end
    else
    begin
      qrySiparis_D.FieldByName('DEPO_AD').AsString := '';
      txtDepoKod.SetFocus;
    end;
  end
  else
  begin
    qrySiparis_D.FieldByName('DEPO_AD').AsString := '';
  end;
end;

procedure TfrmSiparis.txtOlcuBirimExit(Sender: TObject);
var
  strSQL:string;
  OLCU_TIP:String;
begin
  txtOlcuBirim.Color := clWindow;
  if Trim(txtOlcuBirim.Text)<>'' then
  begin
    if prv_OlcuBirim_Kontrol=True then
    begin
      strSQL:='SELECT OLCU_TIP FROM URUN WHERE URUN_KOD='+SQL_Katar(qrySiparis_D.FieldByName('URUN_KOD').AsString);
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
              + ' AND OLCUBIRIM = '+ SQL_Katar(qrySiparis_D.FieldByName('OLCUBIRIM').AsString));
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

procedure TfrmSiparis.txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuBirim_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSiparis.txtKasaKodExit(Sender: TObject);

var
  Kasa_Ad:String;
begin
  if not (qrySiparis_D.State in [dssInsert,dssEdit]) then
  begin
    txtKasaKod.Color := clWindow;
    exit;
  end;

  txtKasaKod.Color := clWindow;

  if Trim(txtKasaKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('KASA','KASA_KOD','ACIKLAMA',qrySiparis_D.FieldByName('KASA_KOD').AsString,Kasa_Ad) Then
    begin
      qrySiparis_D.FieldByName('KASA_AD').AsString := KASA_Ad;
    end
    else
    begin
      qrySiparis_D.FieldByName('KASA_AD').AsString := '';
      txtKasaKod.SetFocus;
    end;
  end
  else
  begin
    qrySiparis_D.FieldByName('KASA_AD').AsString := '';
  end;
end;

procedure TfrmSiparis.txtUrunKoduEnter(Sender: TObject);
begin
  txtUrunKodu.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.txtOlcuBirimEnter(Sender: TObject);
begin
  txtOlcuBirim.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.txtDepoKodEnter(Sender: TObject);
begin
  txtDepoKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.txtCariKodEnter(Sender: TObject);
begin
  txtCariKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.txtFaturaDepoKodEnter(Sender: TObject);
begin
  txtFaturaDepoKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.txtPlasiyerKodEnter(Sender: TObject);
begin
  txtPlasiyerKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.txtProjeKodEnter(Sender: TObject);
begin
  txtProjeKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.IB_Edit5Enter(Sender: TObject);
begin
  IB_Edit5.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.IB_Edit6Enter(Sender: TObject);
begin
  IB_Edit6.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.IB_Edit7Enter(Sender: TObject);
begin
  IB_Edit7.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.IB_Edit24Enter(Sender: TObject);
begin
  IB_Edit24.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.IB_Edit25Enter(Sender: TObject);
begin
  IB_Edit25.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.txtKasaKodEnter(Sender: TObject);
begin
  txtKasaKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSiparis.rg_Siparis_TipiClick(Sender: TObject);
begin
{  if rg_Siparis_Tipi.ItemIndex=0 then
  qrySiparis_D.Filtered:=False;

  if rg_Siparis_Tipi.ItemIndex>0 then
  begin
  qrySiparis_D.Filtered:=True;
    with qrySiparis_D do
    begin
      Active := False;
      ParamByName('PRM_FATURA_ID').AsInteger :=  qrySiparis.FieldByName('FAT_IRS_ID').AsInteger;
      ParamByName('PRM_FATURA_SID').AsInteger := qrySiparis.FieldByName('FAT_IRS_SID').AsInteger;
      Active := True;
    end;
  end;
}


{SELECT SIPARIS_D_FAT_ID
     , SIPARIS_ID
     , SIPARISD_ID
     , MIKTAR
     , FATURA_ID
     , FATURAD_ID
FROM SIPARIS_D_FAT
WHERE
}
{
qry_Siparis_Fat.Close;
qry_Siparis_Fat.ParamByName('SIPARIS_ID').AsInteger:=qrySiparis_D.FieldbyName('FATURA_ID').AsInteger;
qry_Siparis_Fat.ParamByName('SIPARISD_ID').AsInteger:=qrySiparis_D.FieldbyName('URUNHAR_ID').AsInteger;
qry_Siparis_Fat.Open;
if rg_Siparis_Tipi.ItemIndex=1 then
if qry_Siparis_Fat.FieldByName('SIPARISD_ID').AsInteger>0 then
Accept:=True else Accept:=False;

if rg_Siparis_Tipi.ItemIndex=2 then
if qry_Siparis_Fat.FieldByName('SIPARISD_ID').AsInteger<=0 then
Accept:=True else Accept:=False;
}

end;

procedure TfrmSiparis.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSiparis.btnMuhtelifIptalClick(Sender: TObject);
begin
  qryFAT_IRS_MUH_CARI.Cancel;
  qrySiparis.FieldByName('MUHTELIF').AsSmallint := 0;
  txtCariKod.Enabled := True;
  qrySiparis.FieldByName('CARI_KOD').AsString := '';
  grpBoxMuhtelif.Visible := False;
end;

procedure TfrmSiparis.IB_Edit40Exit(Sender: TObject);
begin
  if not (qrySiparis.State in [dssInsert,dssEdit]) then
  begin
  my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if Trim(qrySiparis.FieldByName('YEV_ACIKLAMA').AsString) = '' then
  begin
    qrySiparis.FieldByName('YEV_ACIKLAMA').AsString := qrySiparis.FieldByName('ACIKLAMA').AsString;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmSiparis.BitBtn2Click(Sender: TObject);
var
  PAKET_KOD,PAKET_ADI:String;
begin
  if (qrySiparis_D.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if datamod.LS_Paket(PAKET_KOD,PAKET_ADI) then
  begin
    DataMod.Paket_At(trnFAT_IRS,qrySiparis_D,PAKET_KOD,prv_FAT_TIP,prv_ISN,prv_KDV_HESAPLA,qrySiparis.FieldByName('CARI_KOD').AsString);
  end;
end;


procedure TfrmSiparis.Yazdirildi(Sep:Integer;Id:Integer;Sid:Integer);
var
   qryDeg:TIb_Query;
begin
     DataMod.CreateQuery(qryDeg,trnFAT_IRS,True,DataMod.dbaMain);
     qryDeg.Active:=False;
     qryDeg.SQL.Clear;
     qryDeg.SQL.Add('SELECT * FROM SIPARIS WHERE FAT_IRS_SEP = 1 AND FAT_IRS_ID='+inttostr(ID)+' AND FAT_IRS_SID='+inttostr(SID));
     qryDeg.Open;
     qryDeg.Edit;
     qryDeg.FieldByName('YAZILDI').AsInteger:=1;
     qryDeg.Post;
     qryDeg.Active:=False;
end;


end.
