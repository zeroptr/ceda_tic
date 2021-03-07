{$INCLUDE directive.inc}

unit ufrmOnarim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  IB_Controls, Mask, Grids, IB_Grid, Menus, frxClass, frxIBOSet;

type
  TfrmOnarim = class(TForm)
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
    IB_Edit40: TIB_Edit;
    txtFaturaProjeAD: TIB_Edit;
    Label3: TLabel;
    IB_Edit4: TIB_Edit;
    txtCariKod: TIB_Edit;
    txtProjeKod: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    IB_Currency7: TIB_Currency;
    rgYAZICI: TRadioGroup;
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
    qry_Temp: TIB_Query;
    txt_Sevk_Adres: TIB_Edit;
    BitBtn2: TBitBtn;
    IB_Text16: TIB_Text;
    Btn_Onceki: TBitBtn;
    Btn_Sonraki: TBitBtn;
    IB_Text24: TIB_Text;
    txtArac_Kod: TIB_Edit;
    IB_Text25: TIB_Text;
    rg_Yakit_Seviyesi: TIB_RadioGroup;
    cb_Odeme_Sekli: TIB_ComboBox;
    cr_Onceki_km: TIB_Currency;
    cr_Giris_Km: TIB_Currency;
    cr_Tahmini_Parca: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_CheckBox2: TIB_CheckBox;
    IB_CheckBox3: TIB_CheckBox;
    IB_CheckBox4: TIB_CheckBox;
    IB_Edit1: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Edit8: TIB_Edit;
    Label1: TLabel;
    IB_Date2: TIB_Date;
    IB_Date3: TIB_Date;
    IB_Date1: TIB_Date;
    IB_Date4: TIB_Date;
    IB_Memo1: TIB_Memo;
    IB_Memo2: TIB_Memo;
    IB_Memo3: TIB_Memo;
    Button1: TButton;
    frxIBODts_Onarim_fis: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    IB_CheckBox5: TIB_CheckBox;
    txtPersonel: TIB_Edit;
    IB_Text26: TIB_Text;
    txt_Gel_Neden: TIB_Edit;
    IB_Text27: TIB_Text;
    IB_Date5: TIB_Date;
    IB_Date6: TIB_Date;
    IB_CheckBox6: TIB_CheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCikisClick(Sender: TObject);
    procedure qryFAT_IRSAfterInsert(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure txtCariKodButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    procedure txtProjeKodKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtKasaKodKeyPress(Sender: TObject; var Key: Char);
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
    procedure edtDOVKURExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
    procedure qryURUNHARBeforePost(IB_Dataset: TIB_Dataset);
////////////////////////////////////////////////////////////////////////////////
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure Form_Open(Menu:Boolean;ONARIM_ID:Integer;ONARIM_SID:Integer;ISLEM:Byte);
    procedure DataSet_Open(ONARIM_ID:Integer;ONARIM_SID:Integer;ISLEM:Byte);
    procedure KalemHesapla;
    procedure KDV_Hesapla;

    procedure ApplyDatasets;
    procedure CommitUpdates;
    procedure CancelUpdates;
    procedure FormatDisplays;
    procedure KalemBrutHesapla(Sil:Boolean);
    procedure Form_Post;
    procedure Form_Delete;
    function  Form_Before_Delete:Boolean;
    function  Form_Before_Post:Boolean;
    procedure qryURUNHARBeforeEdit(IB_Dataset: TIB_Dataset);
    procedure IB_Edit5Enter(Sender: TObject);
    procedure IB_Edit6Enter(Sender: TObject);
    procedure IB_Edit7Enter(Sender: TObject);
    procedure IB_Edit25Enter(Sender: TObject);
    procedure txt_Sevk_AdresButtonClick(Sender: TObject);
    procedure txt_Sevk_AdresEnter(Sender: TObject);
    procedure txt_Sevk_AdresExit(Sender: TObject);
    procedure txt_Sevk_AdresKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure txtArac_KodButtonClick(Sender: TObject);
    procedure txtArac_KodEnter(Sender: TObject);
    procedure txtArac_KodExit(Sender: TObject);
    procedure txtArac_KodKeyPress(Sender: TObject; var Key: Char);
    procedure txtArac_KodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure txtPersonelButtonClick(Sender: TObject);
    procedure txtPersonelEnter(Sender: TObject);
    procedure txtPersonelExit(Sender: TObject);
    procedure txtPersonelKeyPress(Sender: TObject; var Key: Char);
    procedure txtPersonelKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);


    procedure txt_Gel_NedenButtonClick(Sender: TObject);
    procedure txt_Gel_NedenEnter(Sender: TObject);
    procedure txt_Gel_NedenExit(Sender: TObject);
    procedure txt_Gel_NedenKeyPress(Sender: TObject; var Key: Char);
    procedure txt_Gel_NedenKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frxReport1AfterPrintReport(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }

    prn_ONARIM_ID,prn_ONARIM_SID,prv_MY_Index:Integer;

    prv_os_Id,prv_os_SId:Integer;

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
    Prv_Yazdirildi:boolean;

    procedure FN_BIRIMFIYAT;
    procedure Geri_AL;
    function Onceki_Km(Arac_Kod:String): Integer;
    function Son_Onarim_Tarihi: TDateTime;
    procedure Yazdir(ONARIM_ID, ONARIM_SID: Integer;Kapandi:String);

  public
    { Public declarations }
    res_Cari:TStringList;
  end;

  const cns_Onarim_Fisi = 65;

type
  TKDV=Record
  KDV:SmallInt;
  KDVTUTAR:Currency;
end;

var
  frmOnarim  : TfrmOnarim;
  arr_KDV:Array [1..6] of TKDV;

implementation

uses main,
     unDataMod,
     ufrmCariSDLG,
     ufrmUrunSDLG,
     unFunc,
     unYazici,
     ufrmISN_ERRORS,
     unLogger, ufrmCariKart,
     UDm_Fast_Report, ufrmOnarim_SDLG;

{$R *.dfm}

procedure TfrmOnarim.Form_Open(Menu:Boolean;ONARIM_ID:Integer;ONARIM_SID:Integer;ISLEM:Byte);
var
  qryFAT_PARAMS:TIB_Query;
  local_can_update,local_can_delete:Boolean;
begin
   if not DataMod.Modul_Hak(cns_Onarim_Fisi,local_can_update,local_can_delete) then
   begin
     Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
     exit;
   end
   else
   begin
     if ((ISLEM = 0) and (local_can_update = False)) then
     begin
       Application.MessageBox('Bu modülde yeni onarým fiþi yetkiniz yok.','Dikkat',MB_ICONWARNING);
       exit;
     end;
   end;

//****************************************************************************//
  if not MainForm.FindChildFrm( Application, 'frmOnarim') then
  begin
    Application.CreateForm (TfrmOnarim,frmOnarim);
    frmOnarim.prv_CanUpdate := local_can_update;
    frmOnarim.prv_CanDelete := local_can_delete;

  end
  else
  begin
    Application.MessageBox('Onarým Fiþi formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
//****************************************************************************//
  with frmOnarim do
  begin
    pgFAT_IRS.ActivePage := frmOnarim.tabFAT_IRS;
    DataMod.CreateQuery(qryFAT_PARAMS,Nil,False,DataMod.dbaMain);
    qryFAT_PARAMS.SQL.Add('Select * from FAT_PARAMS WHERE FAT_PARAMS_ID = 1');
    prv_BELGE_TUR := BT_ONARIM_FISI;
    try
      qryFAT_PARAMS.Active := True;
      if qryFAT_PARAMS.RecordCount <> 0 then
      begin
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
        Application.MessageBox('Fatura Parametrelerine Ulaþýlamýyor... Lütfen yazýlým hizmet biriminize durumu bildiriniz. Onarým Fiþi Giriþi yapmayýnýz.','Dikkat',MB_ICONSTOP);
      end;
      qryFAT_PARAMS.Active := False;
    except
      Application.MessageBox('Fatura Parametrelerine Ulaþýlamýyor... Lütfen yazýlým hizmet biriminize durumu bildiriniz. Onarým Fiþi Giriþi yapmayýnýz.','Dikkat',MB_ICONSTOP);
      qryFAT_PARAMS.Active := False;
    end;
//****************************************************************************//
{    if glb_PROJE_UYG then
    begin
      txtProjeKod.Visible := True;
      txtFaturaProjeAD.Visible := True;
    end
    else
    begin
      txtProjeKod.Visible := False;
      txtFaturaProjeAD.Visible := False;
    end;
 }

      txtProjeKod.Visible := False;
      txtFaturaProjeAD.Visible := False;
       
//****************************************************************************//
  end;//with FaturaBur
//****************************************************************************//
  frmOnarim.DataSet_Open(ONARIM_ID,ONARIM_SID,Islem);
  FormatDisplays;
end;

procedure TfrmOnarim.DataSet_Open(ONARIM_ID:Integer;ONARIM_SID:Integer;ISLEM:Byte);
begin


  if ((ISLEM = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmOnarim do
  begin
    DataMod.Rapor_Kod_Visible_Fields_IB('ONR',ib_edit5,ib_edit6,ib_edit7,ib_edit24,ib_edit25);
    prv_ISN := DataMod.Get_Isn_Num;
    txtCariKod.Enabled := True;
//****************************************************************************//
    with qryFAT_IRS do
    begin
      Active := False;
      ParambyName('PRM_ONARIM_ID').AsInteger := ONARIM_ID;
      ParambyName('PRM_ONARIM_SID').AsInteger := ONARIM_SID;
      Active := True;
    end;

//****************************************************************************//
    prn_ONARIM_ID := ONARIM_ID;
    prn_ONARIM_SID := ONARIM_SID;
    prv_os_id:=ONARIM_ID;
    prv_os_Sid:=ONARIM_SID;
//****************************************************************************//
    prv_KDV_HESAPLA := True;
    case Islem of
    0:
      begin
        qryFAT_IRS.Insert;
        prv_os_id:=qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger;
        prv_os_Sid:=qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger;

      end;
    1:
      begin
        qryFAT_IRS.Edit;
      end;
    end;
//****************************************************************************//
    with qryURUNHAR do
    begin
      Active := False;
      ParamByName('PRM_ONARIM_ID').AsInteger :=  qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger;
      ParamByName('PRM_ONARIM_SID').AsInteger := qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger;
      Active := True;
    end;
//****************************************************************************//
  end;//with
end;

procedure TfrmOnarim.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmOnarim.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmOnarim.qryFAT_IRSAfterInsert(IB_Dataset: TIB_Dataset);
var
   qryDeg1:TIb_Query;
begin
   {if trn_Sip.InTransaction then
       trn_Sip.Rollback;
   trn_Sip.StartTransaction;
   }
  with qryFAT_IRS do
  begin
    FieldByName('ONARIM_ID').AsInteger := qryFAT_IRS.Gen_ID('GEN_ONARIM',1);
    FieldByName('ONARIM_SID').AsInteger := glb_SID;
    FieldByName('GIRIS_TARIH').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('GIRIS_SAAT').AsDATE:= Time;
    FieldByName('TESLIM_TAR').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('TESLIM_SAAT').AsDATE:= Time;
    FieldByName('VADE_TARIH').AsDATE:= DataMod.GET_SERVER_DATE;
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
    FieldByName('GARANTI_ISLEMI').AsSmallInt := 0;
    FieldByName('EXSPERTIZ_ISLEMI').AsSmallInt := 0;
    FieldByName('SOK_PAR_IADE').AsSmallInt := 0;
    FieldByName('MALZEME_FIYATI').AsCurrency := 0 ;
    FieldByName('ISCILIK_FIYATI').AsCurrency := 0 ;
    FieldByName('DIAGNOSTIK_FIYATI').AsCurrency := 0 ;
    FieldByName('YAZILDI').AsSmallInt:=0;
    FieldByName('IPTAL').AsSmallInt:=0;
    FieldByName('KAPANDI').AsString:='0';
    FieldByName('ODEME_SEKLI').AsSmallInt := 3;
    //FieldByName('KAPANDI').AsString :='0';
    FieldByName('ONCEKI_KM').AsInteger := 0;
  end;
  //with qryFAT_IRS do
  IB_Edit1.SetFocus;
end;

function TfrmOnarim.Onceki_Km(Arac_Kod:String):Integer;
var
   qryDeg1:TIb_Query;
begin
     Result:=0;
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     //ONCEKI_KM
     qryDeg1.SQL.Text:='SELECT FIRST 1 ONARIM_ID,GIRIS_KM FROM SRV_ARAC_ONARIM WHERE ARAC_KODU=:ARAC_KODU ORDER BY ONARIM_ID DESC';
     qryDeg1.ParamByName('ARAC_KODU').AsString:=Arac_Kod;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ONARIM_ID').AsInteger>0 then
     begin
          Result:=qryDeg1.FieldByName('GIRIS_KM').AsInteger;
     end;
     qryDeg1.Close;
end;

function TfrmOnarim.Son_Onarim_Tarihi:TDatetime;
var
   qryDeg1:TIb_Query;
begin
     Result:=Date;
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT FIRST 1 ONARIM_ID,GIRIS_TARIH FROM SRV_ARAC_ONARIM WHERE WHERE ORDER BY ONARIM_ID DESC';
     qryDeg1.Open;
     if qryDeg1.FieldByName('ONARIM_ID').AsInteger>0 then
     begin
          Result:=qryDeg1.FieldByName('GIRIS_TARIH').AsDateTime;
     end;
     qryDeg1.Close;
end;

procedure TfrmOnarim.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmOnarim.btnTRN_KAYDETClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmOnarim.btnTRN_IPTALClick(Sender: TObject);
var
  qryDeg,qryDeg1:TIB_Query;
begin

  begin
    if Application.MessageBox('Ýptal etmek istediðinizden emin misiniz?','Dikkat',MB_YESNO+MB_ICONQUESTION)=ID_YES then
    begin
      CancelUpdates;
      CommitUpdates;
//****************************************************************************//
      if trnFAT_IRS.InTransaction then
         trnFAT_IRS.Rollback;

      dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
      prn_ONARIM_ID := 0;
      prn_ONARIM_SID := 0;
    end;
  end;
end;

procedure TfrmOnarim.txtCariKodButtonClick(Sender: TObject);
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
    qryFAT_IRS.FieldByName('CARI_ADI').AsString:= CARI_AD;
    if DataMod.FN_CariKOD2Bilgi(Cari_KOD,res_Cari) then
    begin
//
    end;
  end;
end;


procedure TfrmOnarim.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmOnarim);
  res_Cari:=TStringList.Create;
end;

procedure TfrmOnarim.pgFAT_IRSChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if pgFAT_IRS.ActivePage = tabFAT_IRS Then
  begin
    qryFAT_IRS.UpdateData;
    if Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString) = '' Then
    begin
      txtCariKod.SetFocus;
      Application.MessageBox('Cari Bilgisi olmadan bu alana geçemezsiniz.','Dikkat',MB_ICONWARNING);
      AllowChange:= False;
      txtCariKodButtonClick(Self);
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
  end;
end;

procedure TfrmOnarim.pgFAT_IRSChange(Sender: TObject);
begin
  try
    if pgFAT_IRS.ActivePage = tabKalem then
    begin
      if qryURUNHAR.Active = False then
      begin
        prv_Burut_Top := qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency;
        prv_Temp_Burut_Top := qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency;
      end;
    end;

  finally
    qryURUNHAR.EnableControls;
  end;
end;

procedure TfrmOnarim.dtsURUNHARStateChanged(Sender:TIB_DataSource;ADataset:TIB_Dataset);
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
    {if not ((qryURUNHAR.Eof) and (qryURUNHAR.Bof)) then
    begin
      btnSil.Enabled := True
    end
    else
    begin
      btnSil.Enabled := False;
    end; }

    if ADataset.FieldByName('URUNHAR_ID').AsInteger<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;


    btnKAYDET.Enabled := False;
    btnIPTAL.Enabled := False;
    grdFatKontrol.Enabled := True;
  end;
end;

procedure TfrmOnarim.btnEKLEClick(Sender: TObject);
begin
  qryURUNHAR.Append;
  txtUrunKodu.SetFocus;
end;

procedure TfrmOnarim.btnKaydetClick(Sender: TObject);
begin
  ////kaydetmeden önce kontroller yapýlacak
  if Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString)='' then
  begin
    txtUrunKodu.SetFocus;
    Application.MessageBox('Ürün kodu seçimi yapmadýnýz.!!','Dikkat',MB_ICONWARNING);
    txtUrunKoduButtonClick(Self);
    exit;
  end;
  if qryURUNHAR.FieldByName('MIKTAR').AsCurrency <=0 then
  begin
    IB_Currency7.SetFocus;
    Application.MessageBox('Miktar alaný sýfýrdan küçük ya da eþit olamaz!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('MIKTAR').AsCurrency := 1;
    exit;
  end;

  if Trim(qryURUNHAR.FieldByName('OLCUBIRIM').AsString)='' then
  begin
    txtOlcuBirim.SetFocus;
    Application.MessageBox('Ölçü Birimi Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Exit;
  end;

  if (qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency <= 0) then
  begin
    IB_Currency5.SetFocus;
    Application.MessageBox('Birim fiyatý sýfýrdan küçük ya da eþit olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency := 1;
    exit;
  end;

  if (qryURUNHAR.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    edtDOVKUR.SetFocus;
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('DOVKUR').AsCurrency := 1;
    exit;
  end;

  if (qryURUNHAR.FieldByName('KDV').AsCurrency < 0) then
  begin
    IB_Edit22.SetFocus;
    Application.MessageBox('KDV oraný sýfýrdan küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('KDV').AsCurrency := 0;
    exit;
  end;

  if (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    exit;
  end;

  qryURUNHAR.Post;
  prv_Burut_Top:=prv_Temp_Burut_Top;
end;

procedure TfrmOnarim.btnIptalClick(Sender: TObject);
begin
  qryURUNHAR.Cancel;
end;

procedure TfrmOnarim.btnSilClick(Sender: TObject);
begin
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Exit;

  qryURUNHAR.Delete;
end;

procedure TfrmOnarim.txtUrunKoduButtonClick(Sender: TObject);
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
                                  1,
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

procedure TfrmOnarim.qryURUNHARAfterInsert(IB_Dataset: TIB_Dataset);
begin
   with IB_Dataset do
   begin
     FieldByName('URUNHAR_ID').AsInteger := qryURUNHAR.Gen_ID('GEN_ONARIMD',1);
     FieldByName('URUNHAR_SID').AsInteger := glb_SID;
     FieldByName('MIKTAR').AsInteger := 1;
     FieldByName('ONARIM_ID').AsInteger := qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger ;
     FieldByName('ONARIM_SID').AsInteger := qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger ;
     FieldByName('FAT_IRS_SEP').AsInteger := 0;
     FieldByName('FATURA_ID').AsInteger := 0;
     FieldByName('FATURA_SID').AsInteger := 0;
     FieldByName('IRSALIYE_ID').AsInteger := 0;
     FieldByName('IRSALIYE_SID').AsInteger := 0;
//     FieldByName('DEPO_KOD').AsString := qryFAT_IRS.FieldByName('DEPO_KOD').AsString;
//     FieldByName('DEPO_AD').AsString := qryFAT_IRS.FieldByName('DEPO_AD').AsString ;
     FieldByName('TARIH').AsDate := qryFAT_IRS.FieldByName('GIRIS_TARIH').AsDate;
     FieldByName('DOV_BAZ_TAR').AsDate := qryFAT_IRS.FieldByName('GIRIS_TARIH').AsDate;
     FieldByName('BELGE_TUR').AsInteger := prv_BELGE_TUR;
     FieldByName('BELGE_ID').AsInteger := qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger ;
     FieldByName('BELGE_SID').AsInteger := qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger ;
     FieldByName('BELGE_SIRA_NO').AsInteger := 1;
     FieldByName('ISKONTO_TIP').AsInteger := 0;
     FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := 0 ;
     FieldByName('DOVKOD').AsString := glb_DEFCUR;

     //FieldByName('CIKIS_MIKTAR').AsCurrency := 0;

     FieldByName('FATURA_URUN_HAR_ID').AsFloat := 0;
     FieldByName('AKTARILAN_MIKTAR').AsFloat := 0;

       FieldByName('TIP').AsString :=  ALACAK;
       FieldByName('TIP').AsString :=  BORC;

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

procedure TfrmOnarim.KalemHesapla;
begin
/// ürün secilmediði zaman miktar hesaplamalara 1 olarak katýlacak
// yada hesaplamalardan cýkarýlacak

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
//    qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency * (qryURUNHAR.FieldByName('KDV').AsInteger / 100);

    (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency-qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) * (qryURUNHAR.FieldByName('KDV').AsInteger / 100);
  end
  else
  begin
    qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency := 0;
  end;
end;

procedure TfrmOnarim.txtUrunKoduKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key= VK_F4 Then txtUrunKoduButtonClick(Sender);
end;

procedure TfrmOnarim.txtDepoKodButtonClick(Sender: TObject);
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

procedure TfrmOnarim.txtDepoKodKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
 if key= VK_F4 Then txtDepoKodButtonClick(self);
end;

procedure TfrmOnarim.dtsURUNHARDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
var
  DOV_KUR:Currency;
begin
  if Assigned( Field ) then
  begin
    if (Field.FieldName='DOVKOD') then
    begin
      DOV_KUR := DataMod.Get_Doviz_Kur(qryURUNHAR.FieldByName('DOVKOD').AsString,qryFAT_IRS.FieldByName('GIRIS_TARIH').AsDate,glb_SATISKUR,0);
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

procedure TfrmOnarim.FN_BIRIMFIYAT;
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
                                  1,
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

procedure TfrmOnarim.txtUrunKoduEnter(Sender: TObject);
begin
  txtUrunKodu.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.KDV_Hesapla;
var
  temp:Array [1..5] of TKDV;
  i,j,Sayac:Integer;
  TopKDV,BURUTTOP,KALISKONTOTOP:Currency;
  gnl_iskonto_orn:double;
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
      //arr_KDV[sayac].KDVTUTAR := qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency *  qryURUNHAR.FieldByName('KDV').AsSmallInt/100;
      arr_KDV[sayac].KDVTUTAR := (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency-qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) *  qryURUNHAR.FieldByName('KDV').AsSmallInt/100;
      BURUTTOP := BURUTTOP + qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency;
      KALISKONTOTOP := KALISKONTOTOP + qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
      inc(Sayac);
    end
    else
    begin
      //arr_KDV[prv_MY_Index].KDVTUTAR := arr_KDV[prv_MY_Index].KDVTUTAR +(qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency *  qryURUNHAR.FieldByName('KDV').AsSMallInt/100);
      arr_KDV[prv_MY_Index].KDVTUTAR := arr_KDV[prv_MY_Index].KDVTUTAR +((qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency-qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) *  qryURUNHAR.FieldByName('KDV').AsSMallInt/100);
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
      {
      if qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency>0 then
      begin
          //gnl_iskonto_orn:=1;
          if qryFAT_IRS.FieldByName('ISKONTO_TIP').AsInteger=0 then
          gnl_iskonto_orn:=qryFAT_IRS.FieldByName('ISKONTO_ORAN').AsInteger
          else
          begin
          gnl_iskonto_orn:=BURUTTOP/qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsInteger
          end;


          qryFAT_IRS.FieldByName('KDV_TOP').AsCurrency := TopKDV-((TopKDV*gnl_iskonto_orn)/100);
          FieldByName('GENEL_TOP').AsCurrency := qryFAT_IRS.FieldByName('NET_TOP').AsCurrency + qryFAT_IRS.FieldByName('KDV_TOP').AsCurrency ;
      end;
      }
    end;
//****************************************************************************//
  end;
end;

procedure TfrmOnarim.dtsFAT_IRSStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    if ADataset.State = dssEDIT then
    begin
      btnFaturaSil.Enabled := True;
    end
    else
    begin
      btnFaturaSil.Enabled := False;
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
    end;
    }

    if qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger<=0 then
    begin
      btnFaturaSil.Enabled := False;
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;
    end
    else
    begin
      btnFaturaSil.Enabled := True;
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;
    end;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
  end;
end;

procedure TfrmOnarim.dtsFAT_IRSDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  if Assigned( Field ) then
  begin
//****************************************************************************//
   { if ((Field.FieldName='VADE_TARIH') or (Field.FieldName='TARIH')) then
    begin
      if ((qryFAT_IRS.FieldByName('VADE_TARIH').AsString<>'') and (qryFAT_IRS.FieldByName('TARIH').AsString<>'')) then
      begin
        qryFAT_IRS.FieldByName('VADE_GUN').AsDouble := (qryFAT_IRS.FieldByName('VADE_TARIH').AsDate-qryFAT_IRS.FieldByName('TARIH').AsDate);
      end;
    end;
   }
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
    prv_KDV_HESAPLA := True;
//****************************************************************************//
  end;// assigned(field) then end;
end;

procedure TfrmOnarim.FaturaToplamHesapla;
begin
  with qryFAT_IRS do
  begin
    FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency+FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
    FieldByName('NET_TOP').AsCurrency := FieldByName('BRUT_TOP').AsCurrency -(FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency+FieldByName('ISKONTO_TUTAR_VPB').AsCurrency);
    FieldByName('GENEL_TOP').AsCurrency := FieldByName('NET_TOP').AsCurrency + FieldByName('KDV_TOP').AsCurrency+FieldByName('OTV').AsCurrency;
  end;
end;

procedure TfrmOnarim.btnAraClick(Sender: TObject);
var
  ONARIM_ID,ONARIM_SID:Integer;
begin
  if frmONARIM_SDLG.Form_Open(True,ONARIM_ID,ONARIM_SID,False) then
  begin
    DataSet_Open(ONARIM_ID,ONARIM_SID,1);
  end;
end;

procedure TfrmOnarim.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if ActiveControl.ClassName<>'TIB_Memo' then
  if key = #13 then
  begin
    key := #0;
//    ShowMessage(ActiveControl.ClassName);

    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmOnarim.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmOnarim.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.color :=clWindow;
end;

procedure TfrmOnarim.txtCariKodEnter(Sender: TObject);
begin
  txtCariKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txtCariKodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCarikod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCarikod.Text,CARI_AD) then
    begin
      qryFAT_IRS.FieldByName('CARI_ADI').AsString := CARI_AD;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtCarikod.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qryFAT_IRS.FieldByName('CARI_ADI').AsString := '';
  end;
end;

procedure TfrmOnarim.txtCariKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOnarim.txtCariKodKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if Key = VK_F4 Then txtCariKodButtonClick(Self);
end;

procedure TfrmOnarim.IB_Edit24Enter(Sender: TObject);
begin
  IB_Edit24.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.IB_Edit24Exit(Sender: TObject);
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

procedure TfrmOnarim.txtProjeKodButtonClick(Sender: TObject);
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

procedure TfrmOnarim.txtProjeKodEnter(Sender: TObject);
begin
  txtProjeKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txtProjeKodExit(Sender: TObject);
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

procedure TfrmOnarim.txtProjeKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 Then txtProjeKodButtonClick(Self);
end;

procedure TfrmOnarim.btnFaturaSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmOnarim.rdIskontoChange(Sender: TObject);
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

procedure TfrmOnarim.rdFatIsTipChange(Sender: TObject);
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

procedure TfrmOnarim.txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOnarim.txtUrunKoduExit(Sender: TObject);
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
                                  2,
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
      // Ayný ise bilgiler le oynama
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

procedure TfrmOnarim.txtDepoKodEnter(Sender: TObject);
begin
  txtDepoKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txtDepoKodExit(Sender: TObject);
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

procedure TfrmOnarim.txtDepoKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOnarim.txtOlcuBirimButtonClick(Sender: TObject);
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
     Application.MessageBox('Ürün Seçmeden Ölçü Birimi Seçemezsiniz','DÝKKAT',MB_ICONINFORMATION);
  end;
end;

procedure TfrmOnarim.txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuBirim_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOnarim.txtOlcuBirimExit(Sender: TObject);
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

procedure TfrmOnarim.txtOlcuBirimEnter(Sender: TObject);
begin
  txtOlcuBirim.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txtOlcuBirimKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key= VK_F4 then  txtOlcuBirimButtonClick(Self);
end;

procedure TfrmOnarim.txtProjeKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOnarim.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if dtsFAT_IRS.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Onarým Fiþi bilgileri bölümünde yaptýðýnýz deðiþiklikleri kaydeniniz veya iptal ediniz.','DÝKKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmOnarim.txtKasaKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOnarim.FormResize(Sender: TObject);
begin
  btnCikis.Left := frmOnarim.Width  - (btnCikis.Width + 25 );
  btnAra.Left := frmOnarim.Width  - ( btnCikis.Width + btnAra.Width + 28 );
end;


procedure TfrmOnarim.ApplyDatasets;
begin
  qryFAT_IRS.ApplyUpdates;
  qryFAT_IRS.CommitUpdates;
  qryURUNHAR.ApplyUpdates;
  qryURUNHAR.CommitUpdates;
end;

procedure TfrmOnarim.CommitUpdates;
begin
  qryURUNHAR.Close;
  qryFAT_IRS.Close;
end;

procedure TfrmOnarim.CancelUpdates;
begin
  qryURUNHAR.CancelUpdates;
  qryFAT_IRS.CancelUpdates;
  qryURUNHAR.CommitUpdates;
  qryFAT_IRS.CommitUpdates;
end;

procedure TfrmOnarim.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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

Procedure TfrmOnarim.FormatDisplays;
begin
//glb_DOV_FIELD_PF
  with frmOnarim.qryURUNHAR do
  begin
    FieldByName('MIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('ISKONTO_TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ISKONTO_TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('KDV_TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
  end;

  with frmOnarim.qryFAT_IRS do
  begin
    FieldByName('TAHMINI_PARCA_TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TAHMINI_ISCILIK_TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
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

procedure TfrmOnarim.KalemBrutHesapla(Sil:Boolean);
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
       end;    // whýle
       if Not sil then Bookmark := MyBookMark;
    end;    // wýth
    qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency := MyBrutTop;
  finally
    qryURUNHAR.EnableControls;
  end;
end;

procedure TfrmOnarim.qryURUNHARAfterPost(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(False);
end;

procedure TfrmOnarim.qryURUNHARAfterDelete(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(True);
end;

procedure TfrmOnarim.IB_Edit5ButtonClick(Sender: TObject);
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

procedure TfrmOnarim.IB_Edit6ButtonClick(Sender: TObject);
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

procedure TfrmOnarim.IB_Edit7ButtonClick(Sender: TObject);
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

procedure TfrmOnarim.IB_Edit24ButtonClick(Sender: TObject);
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

procedure TfrmOnarim.IB_Edit25ButtonClick(Sender: TObject);
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

procedure TfrmOnarim.IB_Edit5Exit(Sender: TObject);
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

procedure TfrmOnarim.IB_Edit6Exit(Sender: TObject);
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

procedure TfrmOnarim.IB_Edit7Exit(Sender: TObject);
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

procedure TfrmOnarim.IB_Edit25Exit(Sender: TObject);
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


procedure TfrmOnarim.IB_Edit5KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit5ButtonClick(Self);
end;

procedure TfrmOnarim.IB_Edit6KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit6ButtonClick(Self);
end;

procedure TfrmOnarim.IB_Edit7KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit7ButtonClick(Self);
end;

procedure TfrmOnarim.IB_Edit24KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit24ButtonClick(Self);
end;

procedure TfrmOnarim.IB_Edit25KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit25ButtonClick(Self);
end;

procedure TfrmOnarim.IB_Edit40Exit(Sender: TObject);
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

function TfrmOnarim.Form_Before_Post: Boolean;
begin
  Result := False;

  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryFAT_IRS.FieldByName('ARAC_KODU').AsString) = ''  then
  begin
    txtCariKod.SetFocus;
    Application.MessageBox('Araç Kodu Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString) = ''  then
  begin
    txtCariKod.SetFocus;
    Application.MessageBox('Cari Kod Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;
  {
  if Trim(qryFAT_IRS.FieldByName('ACIKLAMA').AsString) = ''  then
  begin
    IB_Edit40.SetFocus;
    Application.MessageBox('Onarým Fiþi Açýklamasý Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;
  }

  if qryFAT_IRS.FieldByName('IPTAL').AsInteger = 1  then
  if qryFAT_IRS.FieldByName('KAPANDI').AsString = '1'  then
  begin
    Application.MessageBox(' Faturasý Kesilen Onarým Fiþini Ýptal Edemezsiniz!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  if qryFAT_IRS.FieldByName('KAPANDI').AsString = '1'  then
  begin
    Application.MessageBox(' Faturasý Kesilen Onarým Fiþini Üzerinde Deðiþiklik Yapamazsiniz!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  {Lite
  if (Trim(qryFAT_IRS.FieldByName('YEV_ACIKLAMA').AsString) = '') then
  begin
    IB_Edit26.SetFocus;
    Application.MessageBox('Yevmiye Açýklamasý Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;
  }
  if qryURUNHAR.RecordCount = 0 then
  begin
    Application.MessageBox('Onarým Fiþi Kalemi Olmadan Onarým Fiþi Kaydedemezsiniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryFAT_IRS.FieldByName('GIRIS_TARIH').AsDate,True) then Exit;
  {
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryFAT_IRS.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('VADE_TARIH').AsDate, 'Vade Tarihi') then Exit;
  }

  Result := True;
  KDV_Hesapla;
end;


function TfrmOnarim.Form_Before_Delete:Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryFAT_IRS.FieldByName('KAPANDI').AsString = '1'  then
  begin
    Application.MessageBox(' Faturasý Kesilen Onarým Fiþini Silemezsiniz!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryFAT_IRS.FieldByName('GIRIS_TARIH').AsDate,True) then Exit;
  Result := True;
end;

procedure TfrmOnarim.Form_Post;
var
  SIPARIS_D_FAT_ID,URUNHAR_ID:Integer;
  qryDeg1,qryDeg:TIb_Query;
  Kapandi:String;
  Arac_Kodu:String;
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
    prn_ONARIM_ID := qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger;
    prn_ONARIM_SID := qryFAT_IRS.FieldByName('ONARIM_SID').AsSmallint;
//****************************************************************************//

//****************************************************************************//
    if not DataMod.Onarim_ON_MUH_ENT(0,trnFAT_IRS,qryFAT_IRS,Prv_Isn) then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
{
    qryFAT_IRS.FieldByName('MALZEME_FIYATI').AsCurrency :=
    DataMod.Onarim_Grup_Toplam(trnFAT_IRS,prn_ONARIM_ID,prn_ONARIM_SID,'MAL');
    qryFAT_IRS.FieldByName('ISCILIK_FIYATI').AsCurrency :=
    DataMod.Onarim_Grup_Toplam(trnFAT_IRS,prn_ONARIM_ID,prn_ONARIM_SID,'ISCI');
    qryFAT_IRS.FieldByName('DIAGNOSTIK_FIYATI').AsCurrency :=
    DataMod.Onarim_Grup_Toplam(trnFAT_IRS,prn_ONARIM_ID,prn_ONARIM_SID,'DIAG');
}
    Kapandi:=qryFAT_IRS.FieldByName('KAPANDI').AsString;
    Arac_Kodu:=qryFAT_IRS.FieldByName('ARAC_KODU').AsString;
    ApplyDatasets;

    DataMod.Onarim_Grup_Toplam(trnFAT_IRS,prn_ONARIM_ID,prn_ONARIM_SID,'MAL');
    DataMod.Onarim_Grup_Toplam(trnFAT_IRS,prn_ONARIM_ID,prn_ONARIM_SID,'ISCI');
    DataMod.Onarim_Grup_Toplam(trnFAT_IRS,prn_ONARIM_ID,prn_ONARIM_SID,'DIAG');

    DataMod.Son_Onarim_Tar_Ayarla(trnFAT_IRS,Arac_Kodu);

//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC_ONARIM ,SRV_ARAC_ONARIM_D,CARI,CARIHAR,PROJE,PROJEHAR,',
                                             prv_BELGE_TUR,
                                             prn_ONARIM_ID,
                                             prn_ONARIM_SID,
                                             1,1,'SRV_ARAC_ONARIM');
//****************************************************************************//
    trnFAT_IRS.CommitRetaining;

//****************************************************************************//
//  if rgYAZICI.ItemIndex < 2 then
//  Dm_Fast_Report.Rapor_Ac(0,201,20,1,rgYAZICI.ItemIndex,prn_ONARIM_ID,prn_ONARIM_SID,1,qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);
  if rgYAZICI.ItemIndex < 2 then
   Yazdir(prn_ONARIM_ID,prn_ONARIM_SID,Kapandi);

    trnFAT_IRS.Commit;

    prn_ONARIM_ID := 0;
    prn_ONARIM_SID := 0;
  except
    trnFAT_IRS.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  CommitUpdates;
end;

procedure TfrmOnarim.Form_Delete;
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
    Prn_ONARIM_ID := qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger;
    Prn_ONARIM_SID := qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger;
//****************************************************************************//

//****************************************************************************//
    if not DataMod.Onarim_ON_MUH_ENT(0,trnFAT_IRS,qryFAT_IRS,Prv_Isn) then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;
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

    DataMod.Son_Onarim_Tar_Ayarla(trnFAT_IRS,qryFAT_IRS.FieldByName('ARAC_KODU').AsString);

    qryFAT_IRS.Delete;

    ApplyDatasets;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC_ONARIM ,SRV_ARAC_ONARIM_D,CARI,CARIHAR,PROJE,PROJEHAR,',
                                             prv_BELGE_TUR,
                                             Prn_ONARIM_ID,
                                             Prn_ONARIM_SID,
                                             1,2,'SRV_ARAC_ONARIM');
//****************************************************************************//
    trnFAT_IRS.Commit;
//****************************************************************************//
  except
    trnFAT_IRS.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  CommitUpdates;
end;

procedure TfrmOnarim.edtDOVKURExit(Sender: TObject);
begin
  if not (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if (qryURUNHAR.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
    qryURUNHAR.FieldByName('DOVKUR').AsCurrency := 1;
    edtDOVKUR.SetFocus;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmOnarim.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmOnarim.cboDOVKODExit(Sender: TObject);
begin
  if not (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    cboDOVKOD.Color := clWindow;
    exit;
  end;
  cboDOVKOD.Color := clWindow;
end;

procedure TfrmOnarim.cboDOVKODEnter(Sender: TObject);
begin
  cboDOVKOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.btnCiktiClick(Sender: TObject);
begin
  if qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger<=0 then Exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;

//  Dm_Fast_Report.Rapor_Ac(0,601,60,1,rgYAZICI.ItemIndex,prn_ONARIM_ID,prn_ONARIM_SID,1,qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);
  if rgYAZICI.ItemIndex < 2 then
   Yazdir(qryFAT_IRS.FieldByName('ONARIM_ID').AsInteger,qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger,qryFAT_IRS.FieldByName('KAPANDI').AsString);

end;

procedure TfrmOnarim.qryURUNHARBeforePost(IB_Dataset: TIB_Dataset);
var
  BIRIMFIY_URN_DOVKOD,
  TUTAR_URN_DOVKOD,
  MIKTAR_URN_OLCUBIRIM,
  BIRIMFIY_VPB:Currency;
  URUN_DOVKOD,URUN_OLCUBIRIM:String;
  qryDegX1:TIB_Query;
begin

  if IB_Dataset.FieldByName('FATURA_URUN_HAR_ID').AsInteger > 0  then
  begin
    Application.MessageBox(' Faturasý Kesilen Onarým Fiþini Kalemi Üzerinde Deðiþiklik Yapamazsýnýz!','DÝKKAT',MB_ICONWARNING);
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

procedure TfrmOnarim.qryURUNHARBeforeEdit(IB_Dataset: TIB_Dataset);
begin
     prv_Ilk_Miktar:=qryURUNHAR.FieldByName('MIKTAR').AsFloat;
     prv_Ilk_Olcu_Birimi:=qryURUNHAR.FieldByName('OLCUBIRIM').AsString;
end;

procedure TfrmOnarim.IB_Edit5Enter(Sender: TObject);
begin
  IB_Edit5.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.IB_Edit6Enter(Sender: TObject);
begin
  IB_Edit6.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.IB_Edit7Enter(Sender: TObject);
begin
  IB_Edit7.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.IB_Edit25Enter(Sender: TObject);
begin
  IB_Edit25.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txt_Sevk_AdresButtonClick(Sender: TObject);
var
  SEVK_ADRES_KOD:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_Sevk_Adres(SEVK_ADRES_KOD,
  qryFAT_IRS.FieldByName('CARI_KOD').AsString,
  qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger) then
  begin
    with qryFAT_IRS do
    begin
      FieldByName('SEVK_ADRES_KOD').AsString := SEVK_ADRES_KOD;
    end;
  end;
end;

procedure TfrmOnarim.txt_Sevk_AdresEnter(Sender: TObject);
begin
  txt_Sevk_Adres.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txt_Sevk_AdresExit(Sender: TObject);
var
  Sevk_Adres_Kod:String;
  Sevk_Adres:String;
begin
  txt_Sevk_Adres.Color := clWindow;

  if Trim(txt_Sevk_Adres.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD(
    ' and CARI_KOD='+SQL_Katar(qryFAT_IRS.FieldByName('CARI_KOD').AsString)+
    ' and CARI_SID='+Inttostr(qryFAT_IRS.FieldByName('ONARIM_SID').AsInteger),
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

procedure TfrmOnarim.txt_Sevk_AdresKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txt_Sevk_AdresButtonClick(Self);
end;

procedure TfrmOnarim.BitBtn2Click(Sender: TObject);
var
  PAKET_KOD,PAKET_ADI:String;
begin
  if (qryURUNHAR.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if datamod.LS_Paket(PAKET_KOD,PAKET_ADI) then
  begin
    DataMod.Paket_At(trnFAT_IRS,qryURUNHAR,PAKET_KOD,2,prv_ISN,prv_KDV_HESAPLA,qryFAT_IRS.FieldByName('CARI_KOD').AsString);
  end;
end;

procedure TfrmOnarim.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT FIRST 1 ONARIM_ID,ONARIM_SID FROM SRV_ARAC_ONARIM WHERE ONARIM_ID<:ONARIM_ID AND ONARIM_SID=:ONARIM_SID ORDER BY ONARIM_ID DESC';
     qryDeg1.ParamByName('ONARIM_ID').AsInteger:=prv_os_Id;
     qryDeg1.ParamByName('ONARIM_SID').AsInteger:=prv_os_SId;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ONARIM_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('ONARIM_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('ONARIM_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmOnarim.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT FIRST 1 ONARIM_ID,ONARIM_SID FROM SRV_ARAC_ONARIM WHERE ONARIM_ID>:ONARIM_ID AND ONARIM_SID=:ONARIM_SID ORDER BY ONARIM_ID';
     qryDeg1.ParamByName('ONARIM_ID').AsInteger:=prv_os_Id;
     qryDeg1.ParamByName('ONARIM_SID').AsInteger:=prv_os_SId;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ONARIM_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('ONARIM_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('ONARIM_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;


procedure TfrmOnarim.Geri_AL;
begin
      CancelUpdates;
      CommitUpdates;
      if trnFAT_IRS.InTransaction then trnFAT_IRS.Rollback;
end;


procedure TfrmOnarim.txtArac_KodButtonClick(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 SASI_NO:String;
 MARKA_TIP:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Arac_Srv(ARAC_KOD,PLAKA,CARI_KOD,SASI_NO,MARKA_TIP,'') Then
  begin
      qryFAT_IRS.FieldByName('ARAC_PLAKA').AsString := PLAKA;
      qryFAT_IRS.FieldByName('ARAC_KODU').AsString := ARAC_KOD;
      //qryFAT_IRS.FieldByName('SASI_NO').AsString := SASI_NO;
      //qryFAT_IRS.FieldByName('MARKA_TIP').AsString := MARKA_TIP;
      qryFAT_IRS.FieldByName('CARI_KOD').AsString := CARI_KOD;
      qryFAT_IRS.FieldByName('ONCEKI_KM').AsInteger := Onceki_Km(ARAC_KOD);
      txtCariKodExit(txtCariKod);
  end;
end;

procedure TfrmOnarim.txtArac_KodEnter(Sender: TObject);
begin
  txtArac_Kod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txtArac_KodExit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
begin
  if Trim(txtArac_Kod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('SRV_ARAC','ARAC_KOD','PLAKA',txtArac_Kod.Text,PLAKA) then
    begin
      qryFAT_IRS.FieldByName('ARAC_PLAKA').AsString := PLAKA;
      if qryFAT_IRS.State =DssInsert then
      qryFAT_IRS.FieldByName('ONCEKI_KM').AsInteger := Onceki_Km(txtArac_Kod.Text);

      txtCariKodExit(txtCariKod);

      (Sender as TIb_Edit).Color := clWindow;
    end
    else
    begin
      txtArac_kod.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIb_Edit).Color := clWindow;
      qryFAT_IRS.FieldByName('ARAC_PLAKA').AsString := '';
  end;
end;

procedure TfrmOnarim.txtArac_KodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmOnarim.txtArac_KodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txtArac_KodButtonClick(Self);
end;

procedure TfrmOnarim.Button1Click(Sender: TObject);
var
  ONARIM_ID,ONARIM_SID:Integer;
begin
     //if not qryFAT_IRS.State in [dssEdit,DssInsert] then  Geri_AL;

     Application.CreateForm(TfrmOnarim_SDLG,frmOnarim_SDLG);

     frmOnarim_SDLG.chkCARI.Checked:=True;
     frmOnarim_SDLG.lbl_CARIKOD.Caption:=txtCariKod.Text;
     frmOnarim_SDLG.lbl_CARI.Caption:=qryFAT_IRS.FieldByName('CARI_ADI').asString;
     frmOnarim_SDLG.lbl_CARIKOD.Visible:=True;
     frmOnarim_SDLG.lbl_CARI.Visible:=True;
     frmOnarim_SDLG.txtArac.Text:=txtArac_Kod.Text;
     frmOnarim_SDLG.txtAracExit(frmOnarim_SDLG.txtArac);
     frmOnarim_SDLG.btn_AraClick(frmOnarim_SDLG.btn_Ara);
     frmOnarim_SDLG.btn_Fast.Visible:=False;
     frmOnarim_SDLG.CheckBox3.Visible:=False;
     //frmONARIM_SDLG.Form_Open(False,ONARIM_ID,ONARIM_SID,False);
     frmOnarim_SDLG.ShowModal;
     frmOnarim_SDLG.Free;
end;

procedure TfrmOnarim.frxReport1BeforePrint(Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin
      { if chk_Sirket.Checked then
       begin
         res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;
       end
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;
       }

       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);

       c:=(frxReport1.FindComponent('Memo_Bit_Saat') as TfrxMemoView);
       c.memo.Text:=TimeToStr(Time);

       {
       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
       }

       Prv_Yazdirildi:=True;
    end;
end;

procedure TfrmOnarim.txtPersonelButtonClick(Sender: TObject);
var
  PERSONEL_KOD,PERSONEL_ADI:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMOd.LS_Personel(PERSONEL_KOD,PERSONEL_ADI) then
  begin
    with qryFAT_IRS do
    begin
      FieldByName('KABUL_EDEN_PERS').AsString := PERSONEL_KOD;
      FieldByName('PERSONEL_ADI').AsString := PERSONEL_ADI;
    end;
  end;
end;

procedure TfrmOnarim.txtPersonelEnter(Sender: TObject);
begin
  txtPersonel.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txtPersonelExit(Sender: TObject);
var
  Personel_Adi:String;
begin
  txtPersonel.Color := clWindow;
  if Trim(txtPersonel.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',qryFAT_IRS.FieldByName('KABUL_EDEN_PERS').AsString,Personel_Adi) Then
    begin
      qryFAT_IRS.FieldByName('PERSONEL_ADI').AsString := Personel_Adi;
    end
    else
    begin
      qryFAT_IRS.FieldByName('PERSONEL_ADI').AsString := '';
      txtPersonel.SetFocus;
    end;
  end
  else
  begin
    qryFAT_IRS.FieldByName('PERSONEL_ADI').AsString := '';
  end;
end;

procedure TfrmOnarim.txtPersonelKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmOnarim.txtPersonelKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then txtPersonelButtonClick(Self);
end;

procedure TfrmOnarim.txt_Gel_NedenButtonClick(Sender: TObject);
var
  NEDEN_KOD,ACIKLAMA:String;
begin
  if not (qryFAT_IRS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMOd.LS_Gelis_Nedeni(NEDEN_KOD,ACIKLAMA) then
  begin
    with qryFAT_IRS do
    begin
      FieldByName('GELIS_NEDENI_KOD').AsString := NEDEN_KOD;
      FieldByName('NEDEN_ACIKLAMA').AsString := ACIKLAMA;
      FieldByName('ACIKLAMA').AsString := ACIKLAMA;
    end;
  end;
end;

procedure TfrmOnarim.txt_Gel_NedenEnter(Sender: TObject);
begin
  txt_Gel_Neden.Color := glb_Art_Alan_Renk;
end;

procedure TfrmOnarim.txt_Gel_NedenExit(Sender: TObject);
var
  Aciklama:String;
begin
  txt_Gel_Neden.Color := clWindow;
  if Trim(txt_Gel_Neden.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('SRV_GELIS_NEDENI','NEDEN_KOD','ACIKLAMA',qryFAT_IRS.FieldByName('GELIS_NEDENI_KOD').AsString,Aciklama) Then
    begin
      qryFAT_IRS.FieldByName('NEDEN_ACIKLAMA').AsString := Aciklama;
      qryFAT_IRS.FieldByName('ACIKLAMA').AsString := ACIKLAMA;
    end
    else
    begin
      qryFAT_IRS.FieldByName('NEDEN_ACIKLAMA').AsString := '';
      txt_Gel_Neden.SetFocus;
    end;
  end
  else
  begin
    qryFAT_IRS.FieldByName('NEDEN_ACIKLAMA').AsString := '';
  end;
end;

procedure TfrmOnarim.txt_Gel_NedenKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmOnarim.txt_Gel_NedenKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then txt_Gel_NedenButtonClick(Self);
end;



procedure TfrmOnarim.Yazdir(ONARIM_ID:Integer;ONARIM_SID:Integer;Kapandi:String);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
begin
    IB_Query1.Active:=False;
    IB_Query1.ParamByName('PRM_ONARIM_ID').AsInteger:=ONARIM_ID;
    IB_Query1.ParamByName('PRM_ONARIM_SID').AsInteger:=ONARIM_SID;
    IB_Query1.Active:=True;
    Prv_Yazdirildi:=False;
    
    frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Onarim_Fisi_Mu.fr3');

    c:=(frxReport1.FindComponent('Memo_Fatura') as TfrxMemoView);
    if Kapandi='0' then
    c.Visible:=False;

    //frxReport1.PrepareReport();

    if rgYAZICI.ItemIndex=0 then
    frxReport1.Print;

    if rgYAZICI.ItemIndex=1 then
    frxReport1.showReport;
end;


procedure TfrmOnarim.frxReport1AfterPrintReport(Sender: TObject);
var
   qryDeg:TIb_Query;
begin
      DataMod.CreateQuery(qryDeg,Nil,True,DataMod.dbaMain);
      qryDeg.Active:=False;
      qryDeg.SQL.Clear;
      qryDeg.SQL.Add('SELECT * FROM SRV_ARAC_ONARIM WHERE ONARIM_ID='+inttostr(prn_ONARIM_ID)+' AND ONARIM_sID='+inttostr(prn_ONARIM_SID));
      qryDeg.Open;
      qryDeg.Edit;
      qryDeg.FieldByName('YAZILDI').AsInteger:=1;
      qryDeg.Post;
      qryDeg.Active:=False;
end;

end.
