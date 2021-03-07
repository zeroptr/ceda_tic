unit ufrmSefer_Takip2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, IBODataset,
  IB_Components, cxMRUEdit, cxButtonEdit, cxCalendar, cxTextEdit,
  cxCurrencyEdit, cxCheckBox, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxLabel, cxContainer, cxMaskEdit,
  cxDropDownEdit, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPScxCommon, dxPScxGrid6Lnk,cxGridExportLink, cxLocalization, cxSpinEdit;

type
  TfrmSefer_Takip = class(TForm)
    cxG1DBTV1: TcxGridDBTableView;
    cxGL1: TcxGridLevel;
    cxG1: TcxGrid;
    dtsSefer_Takip: TDataSource;
    qry_Sefer_Takip: TIBOQuery;
    qry_Sefer_TakipSEFER_TAKIP_ID: TIntegerField;
    qry_Sefer_TakipSEFER_TAKIP_SID: TSmallintField;
    qry_Sefer_TakipGUN_SIRA: TIntegerField;
    qry_Sefer_TakipYUKLEME_TARIHI: TDateField;
    qry_Sefer_TakipGIRIS_TARIHI: TDateField;
    qry_Sefer_TakipCEKICI: TStringField;
    qry_Sefer_TakipDORSE: TStringField;
    qry_Sefer_TakipINDIREN: TStringField;
    qry_Sefer_TakipGIDECEGI_YER: TStringField;
    qry_Sefer_TakipYUKLEYICI_FIRMA: TStringField;
    qry_Sefer_TakipKONT_ALIS_YERI: TStringField;
    qry_Sefer_TakipKONT_TESLIM: TStringField;
    qry_Sefer_TakipKUMPANYA: TStringField;
    qry_Sefer_TakipBOOKING_NO: TStringField;
    qry_Sefer_TakipKONTROL_NO: TStringField;
    qry_Sefer_TakipMUHUR_NO: TStringField;
    qry_Sefer_TakipGONDEREN_FIRMA: TStringField;
    qry_Sefer_TakipGEMI_ADI: TStringField;
    qry_Sefer_TakipTAHLIYE_LIMANI: TStringField;
    qry_Sefer_TakipFATURA_NO: TStringField;
    qry_Sefer_TakipFATURA_TUTAR: TBCDField;
    qry_Sefer_TakipSATICI_FATURA_TUTAR: TBCDField;
    qry_Sefer_TakipSEFER_TAMAMLANDI: TSmallintField;
    qry_Sefer_TakipSATIS_FATURASI_KESILDI: TSmallintField;
    qry_Sefer_TakipALIS_FATURASI_ALINDI: TSmallintField;
    qry_Sefer_TakipPERSONEL_KOD: TStringField;
    qry_Sefer_TakipSEFERLESTI: TSmallintField;
    qry_Sefer_TakipSEFER_ID: TIntegerField;
    cxG1DBTV1SEFER_TAKIP_ID: TcxGridDBColumn;
    cxG1DBTV1SEFER_TAKIP_SID: TcxGridDBColumn;
    cxG1DBTV1GUN_SIRA: TcxGridDBColumn;
    cxG1DBTV1YUKLEME_TARIHI: TcxGridDBColumn;
    cxG1DBTV1GIRIS_TARIHI: TcxGridDBColumn;
    cxG1DBTV1CEKICI: TcxGridDBColumn;
    cxG1DBTV1DORSE: TcxGridDBColumn;
    cxG1DBTV1INDIREN: TcxGridDBColumn;
    cxG1DBTV1GIDECEGI_YER: TcxGridDBColumn;
    cxG1DBTV1YUKLEYICI_FIRMA: TcxGridDBColumn;
    cxG1DBTV1KONT_ALIS_YERI: TcxGridDBColumn;
    cxG1DBTV1KONT_TESLIM: TcxGridDBColumn;
    cxG1DBTV1NEVI: TcxGridDBColumn;
    cxG1DBTV1KUMPANYA: TcxGridDBColumn;
    cxG1DBTV1BOOKING_NO: TcxGridDBColumn;
    cxG1DBTV1KONTROL_NO: TcxGridDBColumn;
    cxG1DBTV1MUHUR_NO: TcxGridDBColumn;
    cxG1DBTV1GONDEREN_FIRMA: TcxGridDBColumn;
    cxG1DBTV1GEMI_ADI: TcxGridDBColumn;
    cxG1DBTV1TAHLIYE_LIMANI: TcxGridDBColumn;
    cxG1DBTV1FATURA_NO: TcxGridDBColumn;
    cxG1DBTV1FATURA_TUTAR: TcxGridDBColumn;
    cxG1DBTV1SATICI_FATURA_TUTAR: TcxGridDBColumn;
    cxG1DBTV1SEFER_TAMAMLANDI: TcxGridDBColumn;
    cxG1DBTV1SATIS_FATURASI_KESILDI: TcxGridDBColumn;
    cxG1DBTV1ALIS_FATURASI_ALINDI: TcxGridDBColumn;
    cxG1DBTV1PERSONEL_KOD: TcxGridDBColumn;
    cxG1DBTV1SEFERLESTI: TcxGridDBColumn;
    cxG1DBTV1SEFER_ID: TcxGridDBColumn;
    qry_Sefer_TakipCEKICI_PLAKA: TStringField;
    qry_Sefer_TakipDORSE_PLAKA: TStringField;
    qry_Sefer_TakipINDIREN_PLAKA: TStringField;
    qry_Sefer_TakipNEVI_ESYA_AD: TStringField;
    qry_Sefer_TakipGONDEREN_FIRMA_ADI: TStringField;
    qry_Sefer_TakipPERSONEL_ADI: TStringField;
    cxG1DBTV1CEKICI_PLAKA: TcxGridDBColumn;
    cxG1DBTV1DORSE_PLAKA: TcxGridDBColumn;
    cxG1DBTV1INDIREN_PLAKA: TcxGridDBColumn;
    cxG1DBTV1NEVI_ESYA_AD: TcxGridDBColumn;
    cxG1DBTV1GONDEREN_FIRMA_ADI: TcxGridDBColumn;
    cxG1DBTV1PERSONEL_ADI: TcxGridDBColumn;
    cxBu_Seferlerstir: TcxButton;
    cxButton2: TcxButton;
    cxBu_Sefere_Git: TcxButton;
    cxGridPopupMenu1: TcxGridPopupMenu;
    cxDateEdit1: TcxDateEdit;
    cxDateEdit2: TcxDateEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxBu_Kayit_Getir: TcxButton;
    qrySefer: TIB_Query;
    dtsSefer: TIB_DataSource;
    trnSefer: TIB_Transaction;
    qry_Sefer_TakipNEVI: TIntegerField;
    qry_Sefer_TakipKIRALIK: TStringField;
    qry_Sefer_TakipKIRALIK_FIRMA_ADI: TStringField;
    cxG1DBTV1KIRALIK: TcxGridDBColumn;
    cxG1DBTV1KIRALIK_FIRMA_ADI: TcxGridDBColumn;
    cxBu_Sefer_Kaydi_Iptal_Et: TcxButton;
    cxBu_GKa: TcxButton;
    cxBu_GGe: TcxButton;
    qry_Sefer_TakipKONT_ALINDI: TSmallintField;
    qry_Sefer_TakipKIRALIK_BILDIRILDI: TSmallintField;
    qry_Sefer_TakipFIRMAYA_BILDIRILDI: TSmallintField;
    cxG1DBTV1KONT_ALINDI: TcxGridDBColumn;
    cxG1DBTV1KIRALIK_BILDIRILDI: TcxGridDBColumn;
    cxG1DBTV1FIRMAYA_BILDIRILDI: TcxGridDBColumn;
    PoMen: TPopupMenu;
    AktifKaydiSeferlestir: TMenuItem;
    AktifKaydinSeferiniIptalEt: TMenuItem;
    AktifKaydinSeferineGit: TMenuItem;
    KonteynirAlindi: TMenuItem;
    KiralikBildirildi: TMenuItem;
    FirmayaBildirildi: TMenuItem;
    SeferTamamlandi: TMenuItem;
    dxComponentPrinter1: TdxComponentPrinter;
    dxComponentPrinter1Link1: TdxGridReportLink;
    cxButton1: TcxButton;
    SaveDialog1: TSaveDialog;
    cxButton3: TcxButton;
    N1: TMenuItem;
    N2: TMenuItem;
    GruplarKapat1: TMenuItem;
    GruplarA1: TMenuItem;
    cxChGd: TcxCheckBox;
    cxLocalizer1: TcxLocalizer;
    cxStyleRepository1: TcxStyleRepository;
    SaveDialog2: TSaveDialog;
    qry_Sefer_TakipFIRMA_EKKOD: TStringField;
    qry_Sefer_TakipACIKLAMA: TStringField;
    cxG1DBTV1FIRMA_EKKOD: TcxGridDBColumn;
    cxG1DBTV1ACIKLAMA: TcxGridDBColumn;
    cxBu_Yapistir: TcxButton;
    cxSp_Kay_Say: TcxSpinEdit;
    N3: TMenuItem;
    Kopyala1: TMenuItem;
    AklamaOlutur1: TMenuItem;
    qry_Sefer_TakipBEKLEME_FAT_VAR: TSmallintField;
    qry_Sefer_TakipBEKLEME_FAT_TUTAR: TBCDField;
    qry_Sefer_TakipBEKLEME_FAT_KESILDI: TSmallintField;
    qry_Sefer_TakipSBEKLEME_FAT_VAR: TSmallintField;
    qry_Sefer_TakipSBEKLEME_FAT_TUTAR: TBCDField;
    qry_Sefer_TakipSBEKLEME_FAT_KESILDI: TSmallintField;
    cxG1DBTV1BEKLEME_FAT_VAR: TcxGridDBColumn;
    cxG1DBTV1BEKLEME_FAT_TUTAR: TcxGridDBColumn;
    cxG1DBTV1BEKLEME_FAT_KESILDI: TcxGridDBColumn;
    cxG1DBTV1SBEKLEME_FAT_VAR: TcxGridDBColumn;
    cxG1DBTV1SBEKLEME_FAT_TUTAR: TcxGridDBColumn;
    cxG1DBTV1SBEKLEME_FAT_KESILDI: TcxGridDBColumn;
    AktifKaydnSeferiniGncelle1: TMenuItem;
    qry_Sefer_TakipY_DORSE_PLAKA: TStringField;
    qry_Sefer_TakipY_DORSE_PLAKAS: TStringField;
    qry_Sefer_TakipHARCIRAH: TBCDField;
    qry_Sefer_TakipNOTLAR: TStringField;
    cxG1DBTV1Y_DORSE_PLAKA: TcxGridDBColumn;
    cxG1DBTV1Y_DORSE_PLAKAS: TcxGridDBColumn;
    cxG1DBTV1HARCIRAH: TcxGridDBColumn;
    cxG1DBTV1NOTLAR: TcxGridDBColumn;
    qry_Sefer_TakipNOTLAR_IND: TStringField;
    cxG1DBTV1NOTLAR_IND: TcxGridDBColumn;
    mnuALT_SEFER: TMenuItem;
    qry_Sefer_TakipMASTER_S_TAKIP_ID: TIntegerField;
    cxG1DBTV1MASTER_S_TAKIP_ID: TcxGridDBColumn;
    cxG1TableView1: TcxGridTableView;
    cxStyle1: TcxStyle;
    procedure cxG1DBTV1CEKICI_PLAKAPropertiesButtonClick(Sender: TObject;   AButtonIndex: Integer);

    function Form_Open(Menuden:Boolean;Sefer_ID, Sefer_SID: Integer; Islem : Byte): Boolean;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure qry_Sefer_TakipAfterInsert(DataSet: TDataSet);
    procedure cxG1DBTV1DORSE_PLAKAPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxG1DBTV1INDIREN_PLAKAPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxButton2Click(Sender: TObject);
    procedure cxG1DBTV1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxG1DBTV1YUKLEME_TARIHICustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxG1DBTV1PERSONEL_ADIPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxG1DBTV1NEVI_ESYA_ADPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxG1DBTV1KUMPANYAPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxG1DBTV1GONDEREN_FIRMA_ADIPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxBu_Kayit_GetirClick(Sender: TObject);
    procedure qry_Sefer_TakipBeforePost(DataSet: TDataSet);
    procedure cxBu_Sefere_GitClick(Sender: TObject);
    procedure qrySeferAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qrySeferBeforeEdit(IB_Dataset: TIB_Dataset);
    procedure dtsSeferDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure cxBu_SeferlerstirClick(Sender: TObject);
    procedure cxG1DBTV1KIRALIK_FIRMA_ADIPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxBu_Sefer_Kaydi_Iptal_EtClick(Sender: TObject);
    procedure qry_Sefer_TakipBeforeDelete(DataSet: TDataSet);
    procedure cxBu_GKaClick(Sender: TObject);
    procedure cxBu_GGeClick(Sender: TObject);
    procedure qry_Sefer_TakipAfterScroll(DataSet: TDataSet);
    procedure KonteynirAlindiClick(Sender: TObject);
    procedure KiralikBildirildiClick(Sender: TObject);
    procedure FirmayaBildirildiClick(Sender: TObject);
    procedure SeferTamamlandiClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure GruplarKapat1Click(Sender: TObject);
    procedure GruplarA1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Kopyala1Click(Sender: TObject);
    procedure cxBu_YapistirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AklamaOlutur1Click(Sender: TObject);
    procedure qry_Sefer_TakipBeforeCancel(DataSet: TDataSet);
    procedure cxG1DBTV1Y_DORSE_PLAKASPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure mnuALT_SEFERClick(Sender: TObject);

  private

prv_CanUpdate,prv_CanDelete:Boolean;


      PRV_SAYAC_NO:Integer;
      PRV_SAYAC_NOS:Integer;

//SEFERDEN
    PRV_ISN,prnSeferID,prnSeferSID:Integer;
    Prv_Id_Os:Integer;
    Prv_IdD_Os:Integer;
    my_Active_Comp:TWinControl;

    prv_OlcuTip_Kontrol:Boolean;
    prv_OlcuBirim_Kontrol:Boolean;
    Eski_Sefer_Tamamlandi:Boolean;
    prv_Har_Say:Integer;
    Bekleme_Ilk_Giris:Boolean;
    sBekleme_Ilk_Giris:Boolean;
    Kopyalancak_Kayit_No:Integer;
    Kayit_Esnasi:Boolean;

  public
      procedure DataSet_Openx(Sefer_ID, Sefer_SID: Integer; Islem : Byte);
      function Form_Before_Post(Kes_Kontrol:Boolean):Boolean;
      procedure Form_Post;
      procedure Form_Delete;
      function OM_HAR_KAYDET(SIL:Boolean):Boolean;
      function OM_HAR_KAYDET_SIL(Id:Integer;Sid:Integer):Boolean;
      function Form_Before_Delete: Boolean;
      procedure Degerleri_Ata;
  end;

var
  frmSefer_Takip: TfrmSefer_Takip;


  const cns_Sefer_Takip = 36;

implementation


uses unDATAMOD, main,
ufrmCariSDLG,ufrmSefer, unLogger, ufrmISN_ERRORS,unfunc;

//Application.CreateForm(TfrmSefer,frmSefer);
{$R *.dfm}
procedure TfrmSefer_Takip.cxG1DBTV1DORSE_PLAKAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
        qry_Sefer_Takip.Edit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      qry_Sefer_Takip.FieldByName('DORSE_PLAKA').AsString := PLAKA;
      qry_Sefer_Takip.FieldByName('DORSE').AsString := ARAC_KOD;

      //        qry_Sefer_Takip.FieldByName('DORSE').AsString := DORSE_KOD;
        //txtDorse.Text:= DORSE_KOD;
        //txtDorseExit(Self);

      if OZ_MAL=1 then
      begin


        {
        txtPERSONEL_KOD.Enabled:=True;
        IB_Text5.Enabled:=True;
        txtSaticiKod.Enabled:=False;
        IB_Text4.Enabled:=False;

        qrySefer.FieldByName('PERSONEL_KOD').AsString := PERSONEL_KOD;
        txtPERSONEL_KOD.Text:= PERSONEL_KOD;
        qrySefer.FieldByName('SATICI_KOD').AsString := '';
        qrySefer.FieldByName('SATICI_ADI').AsString := '';
        txtPERSONEL_KODExit(Self);
        GroupBox2.Enabled:=False;
        }
      end;

  end
  else
  begin
      qry_Sefer_Takip.FieldByName('DORSE_PLAKA').AsString := '';
      qry_Sefer_Takip.FieldByName('DORSE').AsString := '';
    {
    txtPERSONEL_KOD.Enabled:=False;
    IB_Text5.Enabled:=False;
    txtSaticiKod.Enabled:=True;
    IB_Text4.Enabled:=True;

    qrySefer.FieldByName('SATICI_KOD').AsString := CARI_KOD;
    txtSaticiKod.Text:= CARI_KOD;
    qrySefer.FieldByName('PERSONEL_KOD').AsString := '';
    qrySefer.FieldByName('PERSONEL_ADI').AsString := '';
    txtSaticiKodExit(Self);
    GroupBox2.Enabled:=True;
    }
  end;
end;


procedure TfrmSefer_Takip.cxG1DBTV1GONDEREN_FIRMA_ADIPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  Cari_KOD,Cari_AD:String;
begin

  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
        qry_Sefer_Takip.Edit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qry_Sefer_Takip.FieldByName('GONDEREN_FIRMA').AsString := Cari_KOD;
      qry_Sefer_Takip.FieldByName('GONDEREN_FIRMA_ADI').AsString := Cari_AD;
  end;

end;

procedure TfrmSefer_Takip.cxG1DBTV1INDIREN_PLAKAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
        qry_Sefer_Takip.Edit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      qry_Sefer_Takip.FieldByName('INDIREN_PLAKA').AsString := PLAKA;
      qry_Sefer_Takip.FieldByName('INDIREN').AsString := ARAC_KOD;

      //        qry_Sefer_Takip.FieldByName('DORSE').AsString := DORSE_KOD;
        //txtDorse.Text:= DORSE_KOD;
        //txtDorseExit(Self);

      if OZ_MAL=1 then
      begin
        {
        txtPERSONEL_KOD.Enabled:=True;
        IB_Text5.Enabled:=True;
        txtSaticiKod.Enabled:=False;
        IB_Text4.Enabled:=False;

        qrySefer.FieldByName('PERSONEL_KOD').AsString := PERSONEL_KOD;
        txtPERSONEL_KOD.Text:= PERSONEL_KOD;
        qrySefer.FieldByName('SATICI_KOD').AsString := '';
        qrySefer.FieldByName('SATICI_ADI').AsString := '';
        txtPERSONEL_KODExit(Self);
        GroupBox2.Enabled:=False;
        }
      end;

  end
  else
  begin
        qry_Sefer_Takip.FieldByName('INDIREN_PLAKA').AsString := '';
      qry_Sefer_Takip.FieldByName('INDIREN').AsString := '';
    {
    txtPERSONEL_KOD.Enabled:=False;
    IB_Text5.Enabled:=False;
    txtSaticiKod.Enabled:=True;
    IB_Text4.Enabled:=True;

    qrySefer.FieldByName('SATICI_KOD').AsString := CARI_KOD;
    txtSaticiKod.Text:= CARI_KOD;
    qrySefer.FieldByName('PERSONEL_KOD').AsString := '';
    qrySefer.FieldByName('PERSONEL_ADI').AsString := '';
    txtSaticiKodExit(Self);
    GroupBox2.Enabled:=True;
    }
  end;
end;


procedure TfrmSefer_Takip.cxG1DBTV1KIRALIK_FIRMA_ADIPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  Cari_KOD,Cari_AD:String;
begin

  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
        qry_Sefer_Takip.Edit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qry_Sefer_Takip.FieldByName('KIRALIK').AsString := Cari_KOD;
      qry_Sefer_Takip.FieldByName('KIRALIK_FIRMA_ADI').AsString := Cari_AD;
  end
  else
  begin
      qry_Sefer_Takip.FieldByName('KIRALIK').AsString := '';
      qry_Sefer_Takip.FieldByName('KIRALIK_FIRMA_ADI').AsString := '';
  end;

end;

procedure TfrmSefer_Takip.cxG1DBTV1KUMPANYAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  Cari_KOD,Cari_AD:String;
begin

  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
        qry_Sefer_Takip.Edit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      //qry_Sefer_Takip.FieldByName('MAZOTCU_CARI_KOD').AsString := Cari_KOD;
      qry_Sefer_Takip.FieldByName('KUMPANYA').AsString := Cari_AD;
  end;

end;

procedure TfrmSefer_Takip.cxG1DBTV1NEVI_ESYA_ADPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  Esya_Id :Integer;
  Esya_Ad :String;
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsedit]) then  qry_Sefer_Takip.Edit;
  if DataMod.LS_Esya(Esya_Id, Esya_Ad) then
  begin
    qry_Sefer_Takip.FieldByName('NEVI').AsInteger := Esya_Id;
    qry_Sefer_Takip.FieldByName('NEVI_ESYA_AD').AsString := Esya_Ad;
  end;

end;

procedure TfrmSefer_Takip.cxG1DBTV1PERSONEL_ADIPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
        qry_Sefer_Takip.Edit;
  end;
  
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    qry_Sefer_Takip.FieldByName('PERSONEL_KOD').AsString := PERSONEL_KOD;
    qry_Sefer_Takip.FieldByName('PERSONEL_ADI').AsString := PERSONEL_AD;
  end;

end;

procedure TfrmSefer_Takip.cxG1DBTV1YUKLEME_TARIHICustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
{
        if qry_Sefer_TakipSEFER_TAKIP_ID.Value=1 then
        begin

        ACanvas.Brush.Color:= clRed;
        ACanvas.Font.Color:= clBlack;
        end

        else if qry_Sefer_TakipSEFER_TAKIP_ID.Value=2 then
        begin

        ACanvas.Brush.Color:= clBlue;
        ACanvas.Font.Color:= clCream;
        end
        else
        begin
               ADone:=False;
        end;
     }

end;

procedure TfrmSefer_Takip.cxG1DBTV1Y_DORSE_PLAKASPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);

var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
        qry_Sefer_Takip.Edit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      qry_Sefer_Takip.FieldByName('Y_DORSE_PLAKAS').AsString := PLAKA;
      qry_Sefer_Takip.FieldByName('Y_DORSE_PLAKA').AsString := ARAC_KOD;

      //        qry_Sefer_Takip.FieldByName('DORSE').AsString := DORSE_KOD;
        //txtDorse.Text:= DORSE_KOD;
        //txtDorseExit(Self);

      if OZ_MAL=1 then
      begin


        {
        txtPERSONEL_KOD.Enabled:=True;
        IB_Text5.Enabled:=True;
        txtSaticiKod.Enabled:=False;
        IB_Text4.Enabled:=False;

        qrySefer.FieldByName('PERSONEL_KOD').AsString := PERSONEL_KOD;
        txtPERSONEL_KOD.Text:= PERSONEL_KOD;
        qrySefer.FieldByName('SATICI_KOD').AsString := '';
        qrySefer.FieldByName('SATICI_ADI').AsString := '';
        txtPERSONEL_KODExit(Self);
        GroupBox2.Enabled:=False;
        }
      end;

  end
  else
  begin
      qry_Sefer_Takip.FieldByName('Y_DORSE_PLAKAS').AsString := '';
      qry_Sefer_Takip.FieldByName('Y_DORSE_PLAKA').AsString := '';
    {
    txtPERSONEL_KOD.Enabled:=False;
    IB_Text5.Enabled:=False;
    txtSaticiKod.Enabled:=True;
    IB_Text4.Enabled:=True;

    qrySefer.FieldByName('SATICI_KOD').AsString := CARI_KOD;
    txtSaticiKod.Text:= CARI_KOD;
    qrySefer.FieldByName('PERSONEL_KOD').AsString := '';
    qrySefer.FieldByName('PERSONEL_ADI').AsString := '';
    txtSaticiKodExit(Self);
    GroupBox2.Enabled:=True;
    }
  end;
end;


procedure TfrmSefer_Takip.FirmayaBildirildiClick(Sender: TObject);
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Edit;
  end;

  if qry_Sefer_TakipFIRMAYA_BILDIRILDI.Value=1 then
  qry_Sefer_TakipFIRMAYA_BILDIRILDI.Value:=0
  else
  qry_Sefer_TakipFIRMAYA_BILDIRILDI.Value:=1;

  qry_Sefer_Takip.Post;
end;



procedure TfrmSefer_Takip.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmSefer_Takip.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Post;
  end;

  if (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
       CanClose:=False;
  end;
end;

procedure TfrmSefer_Takip.FormCreate(Sender: TObject);
begin
     //  ShowMessage(GetAppPath+'Turkce.ini');
try
     cxLocalizer1.FileName:=GetAppPath+'Turkce.ini';

finally

end;

//cxLocalizer1.Language  :='Türkçe';
     cxLocalizer1.Active:=True;
     cxLocalizer1.Locale:= 1055;



            //  cxG1DBTV1.DataController.Summary.DefaultGroupSummaryItems.Assign(
            //  cxG1DBTV1.DataController.Summary.FooterSummaryItems);
              //cxGrid1DBTableView1.OptionsView.GroupFooters:=gfAlwaysVisible;
              //cxGrid1DBTableView1.OptionsView.GroupFooterMultiSummaries:=True;
              //cxGrid1DBTableView1.OptionsView.FooterMultiSummaries:=True;

        // cxGrid1DBTableView1.DataController.Summary.FooterSummaryItems.Clear;



  with frmSefer_Takip.qry_Sefer_Takip do
  begin
    //FieldByName('ALICI_BORC_BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    //FieldByName('ALICI_BORC').DisplayFormat := glb_DOV_KUR_PF;
       {
    FieldByName('ALICI_BORC_BIRIM_FIY').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ALICI_BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('MIKTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALICI_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('SATICI_ALACAK_BIRIM_FIY').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('SATICI_ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('SATICI_ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('BEKLEME_FAT_TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('BEKLEME_FAT_VPB').DisplayFormat := glb_VPB_FIELD_PF;

    FieldByName('SBEKLEME_FAT_TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('SBEKLEME_FAT_VPB').DisplayFormat := glb_VPB_FIELD_PF;
         }

    cxDateEdit1.Date:=Date;
    cxDateEdit2.Date:=Date;
    try
   // cxG1DBTV1.RestoreFromIniFile('Sefer_Takip',False,False,[],'');
    finally

    end;
  end;
end;

procedure TfrmSefer_Takip.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    case Key of

    69: //e edit
      begin
        //if btnKAYDET.Enabled Then btnKAYDETClick(Self);
        qry_Sefer_Takip.Edit;
      end; //83 end

    83: //s kaydet
      begin
        //if btnKAYDET.Enabled Then btnKAYDETClick(Self);
        qry_Sefer_Takip.Post;
      end; //83 end
    80: //p iptal
      begin
        //if btnIptal.Enabled Then btnIptalClick(Self);
        qry_Sefer_Takip.Cancel;
      end;
    46: // del delete
      begin
        //if btnSIL.Enabled Then btnSILClick(self);
        qry_Sefer_Takip.Delete;
      end;
    end; // case end;
  end//Shift = [ssCtrl] then end
  else
  if Shift = [] then
  begin
    case Key of
    45: //ins kaydet
       begin
         //if btnYeni.Enabled then btnYeniClick(Self);
         qry_Sefer_Takip.Append;
       end;
    end;//acase end
  end; ///if Shift = [] then ENd
end;



function  TfrmSefer_Takip.Form_Open(Menuden:Boolean;Sefer_ID, Sefer_SID: Integer; Islem : Byte): Boolean;
var
  local_can_update,local_can_delete:Boolean;
  qryDeg:TIB_Query;
begin
  if not DataMod.Modul_Hak(cns_Sefer_Takip,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((Sefer_ID=0) and (Sefer_SID=0) and (local_can_update=False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt hakkýnýz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;

    //Result := True;


    if not MainForm.FindChildFrm(Application, 'frmSefer_Takip') then
    begin
      Application.CreateForm(TfrmSefer_Takip,frmSefer_Takip);
      with frmSefer_Takip do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;

          qry_Sefer_Takip.ParamByName('TAR1').AsDate:=cxDateEdit1.Date;
          qry_Sefer_Takip.ParamByName('TAR2').AsDate:=cxDateEdit2.Date;
        qry_Sefer_Takip.Open;



        //Pg_Sefer.ActivePage:=Ts_Sefer;

        //DataSet_Open(Sefer_ID,Sefer_SID,Islem);


        DataMod.CreateQuery(qryDeg,trnSefer,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT GIDECEGI_YER FROM SEFER_TAKIP';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin

            (cxG1DBTV1GIDECEGI_YER.Properties as cxMRUEdit.TcxMRUEditProperties)
            .LookupItems.Add(qryDeg.FieldByName('GIDECEGI_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT YUKLEYICI_FIRMA FROM SEFER_TAKIP';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            (cxG1DBTV1YUKLEYICI_FIRMA.Properties as cxMRUEdit.TcxMRUEditProperties)
            .LookupItems.Add(qryDeg.FieldByName('YUKLEYICI_FIRMA').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT KONT_ALIS_YERI FROM SEFER_TAKIP';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            (cxG1DBTV1KONT_ALIS_YERI.Properties as cxMRUEdit.TcxMRUEditProperties)
            .LookupItems.Add(qryDeg.FieldByName('KONT_ALIS_YERI').asString);
            qryDeg.Next;
        end;


        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT KONT_TESLIM FROM SEFER_TAKIP';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            (cxG1DBTV1KONT_TESLIM.Properties as cxMRUEdit.TcxMRUEditProperties)
            .LookupItems.Add(qryDeg.FieldByName('KONT_TESLIM').asString);
            qryDeg.Next;
        end;


        {
        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT FIRMA_EKKOD FROM SEFER_TAKIP';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            (cxG1DBTV1FIRMA_EKKOD.Properties as cxMRUEdit.TcxMRUEditProperties)
            .LookupItems.Add(qryDeg.FieldByName('FIRMA_EKKOD').asString);
            qryDeg.Next;
        end;


        qryDeg.Active:=False;
        }

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT KUMPANYA FROM SEFER_TAKIP';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            (cxG1DBTV1KUMPANYA.Properties as cxMRUEdit.TcxMRUEditProperties)
            .LookupItems.Add(qryDeg.FieldByName('KUMPANYA').asString);
            qryDeg.Next;
        end;


        Result := True;
      end;
    end
    else
    begin
      Application.MessageBox('Sefer formu açýk.','Dikkat',MB_ICONWARNING);
      Exit;
    end;

  end;
end;


procedure TfrmSefer_Takip.qry_Sefer_TakipAfterInsert(DataSet: TDataSet);
var
  qryDeg:TIB_Query;
begin

  with qry_Sefer_Takip do

  begin
   PRV_SAYAC_NO:=   DataMod.GET_SAYAC_NUM('SEFER_TAKIP',True,True,0);
   FieldByName('SEFER_TAKIP_ID').AsInteger := PRV_SAYAC_NO;

   //DataMod.GET_SAYAC_NUM('SEFER_TAKIP',True,False,0);


   FieldByName('SEFER_TAKIP_SID').AsInteger :=1;
   FieldByName('YUKLEME_TARIHI').AsDateTime :=date;
   FieldByName('GIRIS_TARIHI').AsDateTime :=date;


        DataMod.CreateQuery(qryDeg,trnSefer,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT MAX(GUN_SIRA) AS GUN_SIRA FROM SEFER_TAKIP WHERE GIRIS_TARIHI=:TARIH';
        qryDeg.ParamByName('TARIH').AsDate:= Date;
        qryDeg.Open;

        FieldByName('GUN_SIRA').AsInteger :=qryDeg.FieldByName('GUN_SIRA').asInteger+1;
        qryDeg.Close();
        DataMod.ReleaseQuery(qryDeg);
   //FieldByName('GUN_SIRA').AsInteger :=0;

   FieldByName('KONT_ALINDI').AsInteger :=0;
   FieldByName('KIRALIK_BILDIRILDI').AsInteger :=0;
   FieldByName('FIRMAYA_BILDIRILDI').AsInteger :=0;

   FieldByName('SEFER_TAMAMLANDI').AsInteger :=0;
   FieldByName('SATIS_FATURASI_KESILDI').AsInteger :=0;
   FieldByName('ALIS_FATURASI_ALINDI').AsInteger :=0;
   FieldByName('SEFERLESTI').AsCurrency :=0;
   FieldByName('SATICI_FATURA_TUTAR').AsCurrency :=0;

   FieldByName('BEKLEME_FAT_VAR').AsInteger :=0;
   FieldByName('BEKLEME_FAT_TUTAR').AsCurrency :=0;
   FieldByName('BEKLEME_FAT_KESILDI').AsInteger :=0;

   FieldByName('SBEKLEME_FAT_VAR').AsInteger :=0;
   FieldByName('SBEKLEME_FAT_TUTAR').AsCurrency :=0;
   FieldByName('SBEKLEME_FAT_KESILDI').AsInteger :=0;

   FieldByName('MASTER_S_TAKIP_ID').AsInteger :=0;

  end;
end;

procedure TfrmSefer_Takip.qry_Sefer_TakipAfterScroll(DataSet: TDataSet);
begin
    if qry_Sefer_TakipSEFERLESTI.value=1 then
    begin
         AktifKaydiSeferlestir.Enabled:=False;
         AktifKaydinSeferineGit.Enabled:=True;
         AktifKaydinSeferiniIptalEt.Enabled:=True;
         AktifKaydnSeferiniGncelle1.Enabled:=True;
         //mnuALT_SEFER.Visible := False;
    end
    else
    begin
         AktifKaydiSeferlestir.Enabled:=True;
         AktifKaydinSeferineGit.Enabled:=False;
         AktifKaydinSeferiniIptalEt.Enabled:=False;
         AktifKaydnSeferiniGncelle1.Enabled:=False;
         //mnuALT_SEFER.Visible := True;
    end;


    if qry_Sefer_TakipKONT_ALINDI.Value=1 then
    begin
          KonteynirAlindi.Checked:=True;
          KonteynirAlindi.Caption:='Konteyner Alýndý Ýptal Et';
    end
    else
    begin
          KonteynirAlindi.Checked:=False;
          KonteynirAlindi.Caption:='Konteyner Alýndý Olarak Ýþaretle';
    end;

    if qry_Sefer_TakipKIRALIK_BILDIRILDI.Value=1 then
    begin
          KiralikBildirildi.Checked:=True;
          KiralikBildirildi.Caption:='Kiralýk Bildirildi Ýptal Et';
    end
    else
    begin
          KiralikBildirildi.Caption:='Kiralýk Bildirildi Olarak Ýþaretle';
          KiralikBildirildi.Checked:=False;
    end;

    if qry_Sefer_TakipFIRMAYA_BILDIRILDI.Value=1 then
    begin
          FirmayaBildirildi.Checked:=True;
          FirmayaBildirildi.Caption:='Firmaya Bildirildi Ýptal Et';

    end
    else
    begin
           FirmayaBildirildi.Checked:=False;
           FirmayaBildirildi.Caption:='Firmaya Bildirildi Olarak Ýþaretle';
    end;

    if qry_Sefer_TakipSEFER_TAMAMLANDI.Value=1 then
    begin
          SeferTamamlandi.Checked:=True;
          SeferTamamlandi.Caption:='Sefer Tamamlandý Ýptal Et';

    end
    else
    begin
           SeferTamamlandi.Checked:=False;
           SeferTamamlandi.Caption:='Sefer Tamamlandý Olarak Ýþaretle';
    end;
  
end;

procedure TfrmSefer_Takip.qry_Sefer_TakipBeforeCancel(DataSet: TDataSet);
begin
  if dtsSefer_Takip.State = dsINSERT then
  begin
    DataMod.Add_Sayaclar_Nu('SEFER_TAKIP',PRV_SAYAC_NO,0);
  end;
end;

procedure TfrmSefer_Takip.qry_Sefer_TakipBeforeDelete(DataSet: TDataSet);
begin
  if Application.MessageBox('Sefer Takip Kaydýný silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON2+ MB_ICONQUESTION) = IDCANCEL then
  begin
  Abort;
  //Exit;
  end;

    if qry_Sefer_TakipSEFER_ID.Value>0 then
    begin
      DataSet_Openx(qry_Sefer_TakipSEFER_ID.Value,qry_Sefer_TakipSEFER_TAKIP_SID.Value,1);
      Form_Delete;
    end;

end;

procedure TfrmSefer_Takip.qry_Sefer_TakipBeforePost(DataSet: TDataSet);
begin
     //cxBu_SeferlerstirClick(Self);
     if not Kayit_Esnasi then
     
  if (qry_Sefer_Takip.FieldByName('SEFERLESTI').AsInteger=1)
  then
  begin
      Application.MessageBox('Kayýt Seferleþtiði için bu deðiþiklik sefere iþlenmeyecektir ','Dikkat',MB_ICONWARNING);
      //exit;
  end;

end;



procedure TfrmSefer_Takip.SeferTamamlandiClick(Sender: TObject);
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Edit;
  end;

  if qry_Sefer_TakipSEFER_TAMAMLANDI.Value=1 then
  qry_Sefer_TakipSEFER_TAMAMLANDI.Value:=0
  else
  qry_Sefer_TakipSEFER_TAMAMLANDI.Value:=1;

  qry_Sefer_Takip.Post;
end;

procedure TfrmSefer_Takip.cxBu_GGeClick(Sender: TObject);
begin
if cxChGd.Checked=False then
begin

     cxG1DBTV1.RestoreFromIniFile('Sefer_Takip',False,False,[],'');
end
else

begin

     if SaveDialog1.Execute then
     begin
        cxG1DBTV1.RestoreFromIniFile(SaveDialog1.FileName,False,False,[],'');
     end;
end;

end;

procedure TfrmSefer_Takip.cxBu_GKaClick(Sender: TObject);
begin

if cxChGd.Checked=False then
begin

     cxG1DBTV1.StoreToIniFile('Sefer_Takip',True,[]);
end
else
begin

     if SaveDialog1.Execute then
     begin
        cxG1DBTV1.StoreToIniFile(SaveDialog1.FileName,True,[]);
     end;
end;




end;

procedure TfrmSefer_Takip.AklamaOlutur1Click(Sender: TObject);
begin
//
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Edit;
  end;

  if qry_Sefer_Takip.State in [DsEdit,DsInsert] then
  begin
    //if Trim(qry_Sefer_Takip.FieldByName('SEFER_NOTLARI').AsString)='' then
    qry_Sefer_Takip.FieldByName('ACIKLAMA').AsString:=
    qry_Sefer_Takip.FieldByName('KONT_ALIS_YERI').AsString + ' '+
    qry_Sefer_Takip.FieldByName('GIDECEGI_YER').AsString + ' '+
    qry_Sefer_Takip.FieldByName('NEVI_ESYA_AD').AsString+ ' '+
    qry_Sefer_Takip.FieldByName('YUKLEYICI_FIRMA').AsString;
  end;
    qry_Sefer_Takip.Post;
end;

procedure TfrmSefer_Takip.cxButton1Click(Sender: TObject);
begin
     dxComponentPrinter1.Preview(true,dxComponentPrinter1Link1);
end;

procedure TfrmSefer_Takip.cxButton2Click(Sender: TObject);
begin
     Close();
end;





procedure TfrmSefer_Takip.cxButton3Click(Sender: TObject);
begin

     if SaveDialog2.Execute then
     begin
       try
       //ExportGridToHTML(SaveDialog1.FileName+'.html', cxG1,True,True);
       //ExportGridToXML(SaveDialog1.FileName+'.xml', cxG1, True,True);
       ExportGridToExcel(SaveDialog2.FileName+'.xls', cxG1,True,True,True,'xls');
      except

      end;
     end;

end;

procedure TfrmSefer_Takip.cxBu_Kayit_GetirClick(Sender: TObject);
var SQL_STR:String;
begin
      qry_Sefer_Takip.Close;
      SQL_STR := qry_Sefer_Takip.SQL.Text;
      qry_Sefer_Takip.ParamByName('TAR1').AsDate:=cxDateEdit1.Date;
      qry_Sefer_Takip.ParamByName('TAR2').AsDate:=cxDateEdit2.Date;
      qry_Sefer_Takip.Open;
end;

procedure TfrmSefer_Takip.cxG1DBTV1CEKICI_PLAKAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
 DORSE_ADI:String;
  PERSONEL_AD,CARI_AD:String;
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Edit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      qry_Sefer_Takip.FieldByName('CEKICI_PLAKA').AsString := PLAKA;
      qry_Sefer_Takip.FieldByName('CEKICI').AsString := ARAC_KOD;

      {
      qry_Sefer_Takip.FieldByName('DORSE').AsString := DORSE_KOD;

      if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PLAKA',DORSE_KOD,DORSE_ADI) then
      begin
           qry_Sefer_Takip.FieldByName('DORSE_PLAKA').AsString := DORSE_ADI;
      end;
      }
        //txtDorse.Text:= DORSE_KOD;
        //txtDorseExit(Self);

      if OZ_MAL=1 then
      begin
        qry_Sefer_Takip.FieldByName('KIRALIK').AsString := '';
        qry_Sefer_Takip.FieldByName('KIRALIK_FIRMA_ADI').AsString := '';

        qry_Sefer_Takip.FieldByName('PERSONEL_KOD').AsString := PERSONEL_KOD;
        //qry_Sefer_Takip.FieldByName('PERSONEL_ADI').AsString := '';

        qry_Sefer_Takip.FieldByName('SATICI_FATURA_TUTAR').AsCurrency:=0;

        if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',PERSONEL_KOD,PERSONEL_AD) then
        begin
          qry_Sefer_Takip.FieldByName('PERSONEL_ADI').AsString := PERSONEL_AD;
        end;

      end
      else
      begin
        qry_Sefer_Takip.FieldByName('PERSONEL_ADI').AsString :='';
        qry_Sefer_Takip.FieldByName('PERSONEL_KOD').AsString :='';
      
        qry_Sefer_Takip.FieldByName('KIRALIK').AsString := CARI_KOD;
        if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',CARI_KOD,CARI_AD) then
        begin
          qry_Sefer_Takip.FieldByName('KIRALIK_FIRMA_ADI').AsString := CARI_AD;
        end
      end;

  end
  else
  begin
    {
    txtPERSONEL_KOD.Enabled:=False;
    IB_Text5.Enabled:=False;
    txtSaticiKod.Enabled:=True;
    IB_Text4.Enabled:=True;

    qrySefer.FieldByName('SATICI_KOD').AsString := CARI_KOD;
    txtSaticiKod.Text:= CARI_KOD;
    qrySefer.FieldByName('PERSONEL_KOD').AsString := '';
    qrySefer.FieldByName('PERSONEL_ADI').AsString := '';
    txtSaticiKodExit(Self);
    GroupBox2.Enabled:=True;
    }

      qry_Sefer_Takip.FieldByName('CEKICI_PLAKA').AsString := '';
      qry_Sefer_Takip.FieldByName('CEKICI').AsString := '';
      qry_Sefer_Takip.FieldByName('KIRALIK').AsString := '';
      qry_Sefer_Takip.FieldByName('KIRALIK_FIRMA_ADI').AsString := '';
      qry_Sefer_Takip.FieldByName('PERSONEL_ADI').AsString :='';
      qry_Sefer_Takip.FieldByName('PERSONEL_KOD').AsString :='';

  end;
end;



procedure TfrmSefer_Takip.cxG1DBTV1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
  val: string;
  valInt:Integer;

   AColumn: TcxGridDBColumn;
begin
  if (AViewInfo.GridRecord.RecordIndex mod 2) = 0 then
  begin
     ACanvas.Brush.Color := clWhite;
  end
  else begin
     ACanvas.Brush.Color := clAqua;
  end;

  AColumn := TcxGridDBColumn((Sender as TcxGridDBTableView).GetColumnByFieldName('MASTER_S_TAKIP_ID'));
  if Assigned(Acolumn) then
  begin
    if VarAsType(TcxGridDBTableView(Sender).DataController.Values[AViewInfo.GridRecord.RecordIndex, AColumn.Index], varInteger) <> 0 then
    ACanvas.Brush.Color := clYellow ;
  end;


  with cxG1DBTV1 do
       begin
            if (Columns[cxG1DBTV1KUMPANYA.Index] = AViewInfo.Item) then
            begin
                 ACanvas.Font.Color:= clRed;
            end;

            if (Columns[cxG1DBTV1YUKLEME_TARIHI.Index] = AViewInfo.Item) then
            begin
                 val := VarAsType( AViewInfo.GridRecord.DisplayTexts[ cxG1DBTV1KONT_ALINDI.Index ],   varString );
                 if val='True' then ACanvas.Font.Color:= clBlack;
                 if val='False' then ACanvas.Font.Color:= clRed;
            end;

            if (Columns[cxG1DBTV1KIRALIK_FIRMA_ADI.Index] = AViewInfo.Item) then
            begin
                 val := VarAsType( AViewInfo.GridRecord.DisplayTexts[ cxG1DBTV1KIRALIK_BILDIRILDI.Index ],   varString );
                 if val='True' then ACanvas.Font.Color:= clBlack;
                 if val='False' then ACanvas.Font.Color:= clRed;
            end;

            if (Columns[cxG1DBTV1KONTROL_NO.Index] = AViewInfo.Item) then
            begin
                 val := VarAsType( AViewInfo.GridRecord.DisplayTexts[ cxG1DBTV1FIRMAYA_BILDIRILDI.Index ],   varString );
                 if val='True' then ACanvas.Font.Color:= clBlack;
                 if val='False' then ACanvas.Font.Color:= clRed;
            end;

           // if (Columns[cxG1DBTV1MASTER_S_TAKIP_ID.Index] = AViewInfo.Item) then
           // begin
           //      valInt := VarAsType( AViewInfo.GridRecord.DisplayTexts[ cxG1DBTV1MASTER_S_TAKIP_ID.Index ],   varInteger );
           //      if valInt > 0  then ACanvas.Brush.Color:= clGreen;
           // end;

       end;


end;


procedure TfrmSefer_Takip.Degerleri_Ata;
begin

        qrySefer.FieldByName('ARAC_KOD').AsString:=   qry_Sefer_Takip.FieldByName('CEKICI').AsString;
        qrySefer.FieldByName('ALICI_KOD').AsString:=  qry_Sefer_Takip.FieldByName('GONDEREN_FIRMA').AsString;
        qrySefer.FieldByName('SATICI_KOD').AsString:=  qry_Sefer_Takip.FieldByName('KIRALIK').AsString;
        qrySefer.FieldByName('PERSONEL_KOD').AsString:= qry_Sefer_Takip.FieldByName('PERSONEL_KOD').AsString;
        qrySefer.FieldByName('DORSE_KOD').AsString:=  qry_Sefer_Takip.FieldByName('DORSE').AsString;
        qrySefer.FieldByName('ESYA_ID').AsInteger:= qry_Sefer_Takip.FieldByName('NEVI').AsInteger;

        qrySefer.FieldByName('TASINAN_ESYA').AsString:= qry_Sefer_Takip.FieldByName('NEVI_ESYA_AD').AsString;

        qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency:= qry_Sefer_Takip.FieldByName('FATURA_TUTAR').AsCurrency;
        qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency:= qry_Sefer_Takip.FieldByName('SATICI_FATURA_TUTAR').AsCurrency;


        qrySefer.FieldByName('BAS_TAR').AsDate:=   qry_Sefer_Takip.FieldByName('YUKLEME_TARIHI').AsDateTime;
        qrySefer.FieldByName('BIT_TAR').AsDate:=   qry_Sefer_Takip.FieldByName('GIRIS_TARIHI').AsDateTime;

        qrySefer.FieldByName('ALICI_B_DOV_BAZ_TAR').AsDate:=   qrySefer.FieldByName('BAS_TAR').AsDate ;

        qrySefer.FieldByName('SATICI_A_DOV_BAZ_TAR').AsDate := qrySefer.FieldByName('BAS_TAR').AsDate;
        qrySefer.FieldByName('BEKLEME_FAT_DOV_BAZ_TAR').AsDate := qrySefer.FieldByName('BAS_TAR').AsDate;
        qrySefer.FieldByName('SEFER_TAKIP_ID').AsInteger:=   qry_Sefer_Takip.FieldByName('SEFER_TAKIP_ID').AsInteger;

        qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger:=   qry_Sefer_Takip.FieldByName('SEFER_TAMAMLANDI').AsInteger;


        qrySefer.FieldByName('CIK_YER').AsString:=   qry_Sefer_Takip.FieldByName('KONT_ALIS_YERI').AsString;
        qrySefer.FieldByName('BIT_YER').AsString:=   qry_Sefer_Takip.FieldByName('GIDECEGI_YER').AsString;
        qrySefer.FieldByName('KONTEYNER_NO').AsString:=   qry_Sefer_Takip.FieldByName('KONTROL_NO').AsString;
        qrySefer.FieldByName('SEFER_NOTLARI').AsString:=   qry_Sefer_Takip.FieldByName('ACIKLAMA').AsString;

        qrySefer.FieldByName('YUKLEYICI_FIRMA').AsString:=   qry_Sefer_Takip.FieldByName('YUKLEYICI_FIRMA').AsString;

        qrySefer.FieldByName('BEKLEME_FAT_VAR').AsInteger:=   qry_Sefer_Takip.FieldByName('BEKLEME_FAT_VAR').AsInteger;
        qrySefer.FieldByName('BEKLEME_FAT_TUTAR').AsCurrency:= qry_Sefer_Takip.FieldByName('BEKLEME_FAT_TUTAR').AsCurrency;

        qrySefer.FieldByName('SBEKLEME_FAT_VAR').AsInteger:=   qry_Sefer_Takip.FieldByName('SBEKLEME_FAT_VAR').AsInteger;
        qrySefer.FieldByName('SBEKLEME_FAT_TUTAR').AsCurrency:= qry_Sefer_Takip.FieldByName('SBEKLEME_FAT_TUTAR').AsCurrency;

end;

procedure TfrmSefer_Takip.cxBu_Sefere_GitClick(Sender: TObject);
begin
//Application.CreateForm(TfrmSefer,frmSefer);
//TfrmSefer.Create(frmSefer_Takip);
//frmsefer.form
if qry_Sefer_TakipSEFER_ID.Value>0 then
begin
    frmSefer.Form_Open(True,qry_Sefer_TakipSEFER_ID.Value,qry_Sefer_TakipSEFER_TAKIP_SID.value,1);
end;

end;


procedure TfrmSefer_Takip.cxBu_SeferlerstirClick(Sender: TObject);
begin


  if (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Post;
  end;

  if (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
       Exit;
  end;

    if MainForm.FindChildFrm(Application, 'frmSefer') then
    begin
        Application.MessageBox('Sefer formu açýk. Ýþlemden Vazgeçildi','Dikkat',MB_ICONWARNING);
        Exit;
    end;

{
        qrySefer.FieldByName('ARAC_KOD').AsString:=   qry_Sefer_Takip.FieldByName('CEKICI').AsString;
        qrySefer.FieldByName('ALICI_KOD').AsString:=  qry_Sefer_Takip.FieldByName('GONDEREN_FIRMA').AsString;
        qrySefer.FieldByName('SATICI_KOD').AsString:=  qry_Sefer_Takip.FieldByName('KIRALIK').AsString;
        qrySefer.FieldByName('PERSONEL_KOD').AsString:= qry_Sefer_Takip.FieldByName('PERSONEL_KOD').AsString;
        qrySefer.FieldByName('DORSE_KOD').AsString:=  qry_Sefer_Takip.FieldByName('DORSE').AsString;
        qrySefer.FieldByName('ESYA_ID').AsInteger:= qry_Sefer_Takip.FieldByName('NEVI').AsInteger;
        qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency:= qry_Sefer_Takip.FieldByName('FATURA_TUTAR').AsCurrency;
        qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency:= qry_Sefer_Takip.FieldByName('SATICI_FATURA_TUTAR').AsCurrency;

 }
  if (qry_Sefer_Takip.FieldByName('CEKICI').AsString='') or
  (qry_Sefer_Takip.FieldByName('CEKICI').AsVariant=null)
  then
  begin
      Application.MessageBox('Lütfen Çekici Bilgisi Giriniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;


  if (qry_Sefer_Takip.FieldByName('NEVI').AsString='') or
  (qry_Sefer_Takip.FieldByName('NEVI').AsVariant=null)
  then
  begin
      Application.MessageBox('Lütfen Nevi Seçiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;


  if (qry_Sefer_Takip.FieldByName('GONDEREN_FIRMA').AsString='') or
  (qry_Sefer_Takip.FieldByName('GONDEREN_FIRMA').AsVariant=null)
  then
  begin
      Application.MessageBox('Lütfen Gönderen Firma Giriniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;


  if (qry_Sefer_Takip.FieldByName('FATURA_TUTAR').AsCurrency<=0) or
  (qry_Sefer_Takip.FieldByName('FATURA_TUTAR').AsVariant=null)
  then
  begin
      Application.MessageBox('Lütfen Fatura Tutarýný Giriniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;

         if DataMod.Get_Doviz_Kur_Kontrol(qry_Sefer_Takip.FieldByName('YUKLEME_TARIHI').AsDateTime) =false then
    begin
        Application.MessageBox(PChar(qry_Sefer_Takip.FieldByName('YUKLEME_TARIHI').asString+' Döviz Kurlarý Yok, Ýþlem Yapýlmayacak'),'Dikkat',MB_ICONWARNING);
        Exit;
    end;

             if DataMod.Get_Doviz_Kur_Kontrol( qry_Sefer_Takip.FieldByName('GIRIS_TARIHI').AsDateTime) =false then
    begin
        Application.MessageBox(PChar(qry_Sefer_Takip.FieldByName('GIRIS_TARIHI').asString+' Döviz Kurlarý Yok, Ýþlem Yapýlmayacak'),'Dikkat',MB_ICONWARNING);
        Exit;
    end;


    //frmSefer.Form_Open(True,qry_Sefer_TakipSEFER_ID.Value,qry_Sefer_TakipSEFER_TAKIP_SID.value,1);
if qry_Sefer_TakipSEFER_ID.Value<=0 then
begin
      DataSet_Openx(0,0,0);
//      degerleri aktar



Degerleri_Ata;
//                 PERSONEL_KOD
        Form_Post;
        //Application.MessageBox('Kayýt Seferleþtirildi','Dikkat',MB_ICONWARNING);
end
else
begin

      DataSet_Openx(qry_Sefer_TakipSEFER_ID.Value,qry_Sefer_TakipSEFER_TAKIP_SID.Value,1);
      Degerleri_Ata;
      Form_Post;
      //Application.MessageBox('Kayýt Seferi Güncelleþtirildi','Dikkat',MB_ICONWARNING);
  //mesaj
end;

  {
if qry_Sefer_TakipSEFER_ID.Value>0 then
begin
      DataSet_Openx(qry_Sefer_TakipSEFER_ID.Value,qry_Sefer_TakipSEFER_TAKIP_SID.Value,1);
      Degerleri_Ata;
      Form_Post;
end;
}

end;


procedure TfrmSefer_Takip.cxBu_Sefer_Kaydi_Iptal_EtClick(Sender: TObject);
begin
    if MainForm.FindChildFrm(Application, 'frmSefer') then
    begin
        Application.MessageBox('Sefer formu açýk. Ýþlemden Vazgeçildi','Dikkat',MB_ICONWARNING);
        Exit;
    end;

    if qry_Sefer_TakipSEFER_ID.Value>0 then
    begin
      DataSet_Openx(qry_Sefer_TakipSEFER_ID.Value,qry_Sefer_TakipSEFER_TAKIP_SID.Value,1);
      Form_Delete;
    end;
end;

procedure TfrmSefer_Takip.cxBu_YapistirClick(Sender: TObject);
var
  a: Integer;

  qryDeg:TIB_Query;
begin
      if Kopyalancak_Kayit_No<=0 then exit;

      for a := 1 to cxSp_Kay_Say.Value do
      begin
        DataMod.CreateQuery(qryDeg,trnSefer,False,DataMod.dbaMain);
        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:=
     'SELECT SEFER_TAKIP_ID '+
     ', SEFER_TAKIP_SID '+
     ', GUN_SIRA '+
     ', YUKLEME_TARIHI '+
     ', GIRIS_TARIHI '+
     ', CEKICI '+
     ',(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.CEKICI) AS CEKICI_PLAKA '+
     ', DORSE '+
     ',(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.DORSE) AS DORSE_PLAKA '+
     ', INDIREN '+
     ',(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.INDIREN) AS INDIREN_PLAKA '+
     ', KIRALIK '+
     ',(SELECT CARI_AD FROM CARI WHERE SEFER_TAKIP.KIRALIK=CARI.CARI_KOD) AS KIRALIK_FIRMA_ADI '+
     ', GIDECEGI_YER '+
     ', YUKLEYICI_FIRMA '+
     ', KONT_ALIS_YERI '+
     ', KONT_TESLIM '+
     ', NEVI '+
     ',(SELECT ESYA_AD FROM ESYA WHERE ESYA.ESYA_ID=SEFER_TAKIP.NEVI) AS NEVI_ESYA_AD '+
     ', KUMPANYA '+
     ', BOOKING_NO '+
     ', KONTROL_NO '+
     ', MUHUR_NO '+
     ', GONDEREN_FIRMA '+
     ',(SELECT CARI_AD FROM CARI WHERE SEFER_TAKIP.GONDEREN_FIRMA=CARI.CARI_KOD) AS GONDEREN_FIRMA_ADI '+
     ', GEMI_ADI '+
     ', TAHLIYE_LIMANI '+
     ', FATURA_NO '+
     ', FATURA_TUTAR '+
     ', SATICI_FATURA_TUTAR '+
     ', SEFER_TAMAMLANDI '+
     ', SATIS_FATURASI_KESILDI '+
     ', ALIS_FATURASI_ALINDI '+
     ', PERSONEL_KOD '+
     ',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER_TAKIP.PERSONEL_KOD) AS PERSONEL_ADI '+
     ', SEFERLESTI '+
     ', SEFER_ID '+
     ', KONT_ALINDI '+
     ', KIRALIK_BILDIRILDI '+
     ', FIRMAYA_BILDIRILDI '+
     ', FIRMA_EKKOD '+
     ', ACIKLAMA '+

        ' FROM SEFER_TAKIP WHERE SEFER_TAKIP_ID=:ID';
        qryDeg.ParamByName('ID').AsInteger:= Kopyalancak_Kayit_No;
        qryDeg.Open;



        qry_Sefer_Takip.Append;


        with qry_Sefer_Takip do
        begin
         //FieldByName('YUKLEME_TARIHI').AsDateTime :=qryDeg.FieldByName('YUKLEME_TARIHI').AsDateTime;
         //FieldByName('GIRIS_TARIHI').AsDateTime :=qryDeg.FieldByName('GIRIS_TARIHI').AsDateTime;
         FieldByName('CEKICI').AsString :=qryDeg.FieldByName('CEKICI').AsString;
         FieldByName('CEKICI_PLAKA').AsString :=qryDeg.FieldByName('CEKICI_PLAKA').AsString;
         FieldByName('DORSE').AsString :=qryDeg.FieldByName('DORSE').AsString;
         FieldByName('DORSE_PLAKA').AsString :=qryDeg.FieldByName('DORSE_PLAKA').AsString;
         FieldByName('INDIREN').AsString :=qryDeg.FieldByName('INDIREN').AsString;
         FieldByName('INDIREN_PLAKA').AsString :=qryDeg.FieldByName('INDIREN_PLAKA').AsString;
         FieldByName('KIRALIK').AsString :=qryDeg.FieldByName('KIRALIK').AsString;
         FieldByName('KIRALIK_FIRMA_ADI').AsString :=qryDeg.FieldByName('KIRALIK_FIRMA_ADI').AsString;
         FieldByName('GIDECEGI_YER').AsString :=qryDeg.FieldByName('GIDECEGI_YER').AsString;
         FieldByName('YUKLEYICI_FIRMA').AsString :=qryDeg.FieldByName('YUKLEYICI_FIRMA').AsString;
         FieldByName('KONT_ALIS_YERI').AsString :=qryDeg.FieldByName('KONT_ALIS_YERI').AsString;
         FieldByName('KONT_TESLIM').AsString :=qryDeg.FieldByName('KONT_TESLIM').AsString;
         FieldByName('NEVI').AsInteger :=qryDeg.FieldByName('NEVI').AsInteger;
         FieldByName('NEVI_ESYA_AD').AsString :=qryDeg.FieldByName('NEVI_ESYA_AD').AsString;
         FieldByName('KUMPANYA').AsString :=qryDeg.FieldByName('KUMPANYA').AsString;
         FieldByName('BOOKING_NO').AsString :=qryDeg.FieldByName('BOOKING_NO').AsString;
         FieldByName('KONTROL_NO').AsString :=qryDeg.FieldByName('KONTROL_NO').AsString;
         FieldByName('MUHUR_NO').AsString :=qryDeg.FieldByName('MUHUR_NO').AsString;
         FieldByName('GONDEREN_FIRMA').AsString :=qryDeg.FieldByName('GONDEREN_FIRMA').AsString;
         FieldByName('GONDEREN_FIRMA_ADI').AsString :=qryDeg.FieldByName('GONDEREN_FIRMA_ADI').AsString;
         FieldByName('GEMI_ADI').AsString :=qryDeg.FieldByName('GEMI_ADI').AsString;
         FieldByName('TAHLIYE_LIMANI').AsString :=qryDeg.FieldByName('TAHLIYE_LIMANI').AsString;
         FieldByName('FATURA_NO').AsString :=qryDeg.FieldByName('FATURA_NO').AsString;
         FieldByName('FATURA_TUTAR').AsCurrency :=qryDeg.FieldByName('FATURA_TUTAR').AsCurrency;
         FieldByName('SATICI_FATURA_TUTAR').AsCurrency :=qryDeg.FieldByName('SATICI_FATURA_TUTAR').AsCurrency;
         FieldByName('PERSONEL_KOD').AsString :=qryDeg.FieldByName('PERSONEL_KOD').AsString;
         FieldByName('PERSONEL_ADI').AsString :=qryDeg.FieldByName('PERSONEL_ADI').AsString;
         FieldByName('FIRMA_EKKOD').AsString :=qryDeg.FieldByName('FIRMA_EKKOD').AsString;
         FieldByName('ACIKLAMA').AsString :=qryDeg.FieldByName('ACIKLAMA').AsString;

        end;

        qry_Sefer_Takip.Post;
      end;

end;

//*******************************************************************************


procedure TfrmSefer_Takip.qrySeferAfterInsert(IB_Dataset: TIB_Dataset);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin
  Bekleme_Ilk_Giris:=False;
  sBekleme_Ilk_Giris:=False;
  with qrySefer do
  begin
       PRV_SAYAC_NOS:=   DataMod.GET_SAYAC_NUM('SEFER',True,True,0);
    FieldByName('SEFER_ID').AsInteger := PRV_SAYAC_NOS;//qrySefer.Gen_ID('GEN_SEFER',1);

    if FieldByName('SEFER_ID').AsInteger=1999999 then
    begin
    PRV_SAYAC_NOS:=   DataMod.GET_SAYAC_NUM('SEFER',True,True,0);
    FieldByName('SEFER_ID').AsInteger := PRV_SAYAC_NOS;
    //qrySefer.Gen_ID('GEN_SEFER',1);

    end;

    FieldByName('SEFER_SID').AsInteger := glb_SID;
    FieldByName('BAS_TAR').AsDate := DataMod.GET_SERVER_DATE ;
    FieldByName('ALICI_B_DOV_BAZ_TAR').AsDate := FieldByName('BAS_TAR').AsDate;
    FieldByName('BIT_TAR').AsDate := FieldByName('BAS_TAR').AsDate;
    FieldByName('ALICI_B_DOV_BAZ_TAR').AsDate := FieldByName('BAS_TAR').AsDate;
    FieldByName('SATICI_A_DOV_BAZ_TAR').AsDate := FieldByName('BAS_TAR').AsDate;
    FieldByName('BEKLEME_FAT_DOV_BAZ_TAR').AsDate := FieldByName('BAS_TAR').AsDate;


    FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency := 0;

    FieldByName('SEFER_SAY').AsInteger := 1;
    FieldByName('SATICI_A_DOVKOD').AsString := glb_DEFCUR;
    FieldByName('BEKLEME_FAT_DOV_KOD').AsString := glb_DEFCUR;
    FieldByName('ALICI_B_DOVKOD').AsString := glb_DEFCUR;

    FieldByName('ALICI_B_DOVKUR').AsCurrency := 1;
    FieldByName('SATICI_A_DOVKUR').AsCurrency := 1;
    FieldByName('BEKLEME_FAT_DOVKUR').AsCurrency := 1;

    FieldByName('BEKLEME_FAT_VAR').AsInteger := 0;
    FieldByName('BEKLEME_FAT_TUTAR').AsCurrency := 0;

    FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger := 0;
    FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger := 0;
    FieldByName('SEFER_TAMAMLANDI').AsInteger := 0;
    FieldByName('DORSE_KOD').AsString :='';

    FieldByName('ALIS_URUN_HAR_ID').AsInteger := 0;
    FieldByName('SATIS_URUN_HAR_ID').AsInteger := 0;

    FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger := 0;
    FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger := 0;
    FieldByName('SECIM').AsString := '0';
    FieldByName('OLCU_TIP').AsString := 'ADET';
    FieldByName('OLCU_BIRIM').AsString := 'ADET';
    FieldByName('MIKTAR').AsCurrency := 0;
    FieldByName('FATURA_MIK_SEF').AsInteger := glb_FATURA_MIK_SEF;


//y
    FieldByName('SBEKLEME_FAT_DOV_BAZ_TAR').AsDate := FieldByName('BAS_TAR').AsDate;
    FieldByName('SBEKLEME_FAT_DOV_KOD').AsString := glb_DEFCUR;
    FieldByName('SBEKLEME_FAT_VAR').AsInteger := 0;
    FieldByName('SBEKLEME_FAT_TUTAR').AsCurrency := 0;
    FieldByName('SBEKLEME_FATURASI_KESILDI').AsInteger := 0;
    FieldByName('SBEK_FAT_URUN_HAR_ID').AsInteger := 0;
    FieldByName('SBEKLEME_FAT_DOVKUR').AsCurrency := 1;



//ys

  end;

end;

procedure TfrmSefer_Takip.qrySeferBeforeEdit(IB_Dataset: TIB_Dataset);
begin
    if qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger=1 then
    Eski_Sefer_Tamamlandi:=True
    else
    Eski_Sefer_Tamamlandi:=False;
end;

procedure TfrmSefer_Takip.DataSet_Openx(Sefer_ID, Sefer_SID: Integer; Islem : Byte);
{
  ISLEM
  0 : Yeni Kayýt
  1 : Edit
}
begin
  if ((Sefer_ID=0) and (Sefer_SID=0) and (prv_CanUpdate=False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt hakkýnýz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;


        prv_Har_Say:=5;
    PRV_ISN := DataMod.Get_Isn_Num;
    try
      case Islem of
      0:
        begin
          with qrySefer do
          begin
            ParamByName('PRM_SEFER_ID').AsInteger := 0;
            ParamByName('PRM_SEFER_SID').AsInteger := 0;
            Insert;
          end;
        end;
      1:
        begin
          with qrySefer do
          begin
            Active := False;
            ParamByName('PRM_SEFER_ID').AsInteger := Sefer_ID;
            ParamByName('PRM_SEFER_SID').AsInteger := Sefer_SID;
            Active := True;
                 Prv_Id_Os:=Sefer_ID;
                 Prv_IdD_Os:=Sefer_SID;
            //txtArac_KodExit(txtArac_Kod);
            Edit;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
          end;


          if qrySefer.RecordCount = 0 then
          begin
            Application.MessageBox('Kayýta ulaþýlamadý.','Dikkat',MB_ICONWARNING);
          end;
          prnSeferID := qrySefer.FieldByName('SEFER_ID').AsInteger;
          prnSeferSID := qrySefer.FieldByName('SEFER_SID').AsInteger;
        end;
      end;//end case Islem of
    except
      Application.MessageBox('Veri Tabaný iþlemleri sýrasýnda Hata Oluþtu','Dikkat',MB_ICONWARNING);
      Close;
    end;


end;

procedure TfrmSefer_Takip.dtsSeferDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
var Kur:Currency;
begin
  if  Assigned( Field ) Then
  begin

    {if Field.FieldName = 'SEFER_TAMAMLANDI' then
    begin
     if Eski_Sefer_Tamamlandi=True then
     if qrySefer.State =DssEdit then
     qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger:=1;
    end;
    }


    if (Field.FieldName = 'BEKLEME_FAT_VAR') then
    begin
         {
         if qrySefer.FieldByName('BEKLEME_FAT_VAR').AsInteger=1 then
         IB_Currency7.TabStop:=True
         else
         IB_Currency7.TabStop:=False;
         }
    end;


   //Y
    if (Field.FieldName = 'SBEKLEME_FAT_VAR') then
    begin
         {if qrySefer.FieldByName('SBEKLEME_FAT_VAR').AsInteger=1 then
         IB_Currency16.TabStop:=True
         else
         IB_Currency16.TabStop:=False;
         }
    end;
   //YS

    if (Field.FieldName = 'FATURA_MIK_SEF') or (Field.FieldName = 'ALICI_BORC_BIRIM_FIY') or (Field.FieldName = 'SEFER_SAY')  or (Field.FieldName = 'MIKTAR') then
    begin




         if qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=1 then
         begin
             qrySefer.FieldByName('ALICI_BORC').AsCurrency:=
             qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency*
             qrySefer.FieldByName('SEFER_SAY').AsCurrency;
         end;

         if qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=2 then
         begin
              if qrySefer.FieldByName('MIKTAR').AsCurrency<=0 then
               qrySefer.FieldByName('ALICI_BORC').AsCurrency:=
               qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency*
               qrySefer.FieldByName('SEFER_SAY').AsCurrency
               else
               qrySefer.FieldByName('ALICI_BORC').AsCurrency:=
               qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency*
               (qrySefer.FieldByName('SEFER_SAY').AsCurrency *
               qrySefer.FieldByName('MIKTAR').AsCurrency);
         end;

         if qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=3 then
         begin
              if qrySefer.FieldByName('MIKTAR').AsCurrency<=0 then
               qrySefer.FieldByName('ALICI_BORC').AsCurrency:=
               qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency
               else
               qrySefer.FieldByName('ALICI_BORC').AsCurrency:=
               qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency*
               qrySefer.FieldByName('MIKTAR').AsCurrency;
         end;

    end;


    if (Field.FieldName = 'FATURA_MIK_SEF') or (Field.FieldName = 'SATICI_ALACAK_BIRIM_FIY') or (Field.FieldName = 'SEFER_SAY') or (Field.FieldName = 'MIKTAR') then
    begin
         if qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=3 then
         begin
              if qrySefer.FieldByName('MIKTAR').AsCurrency<=0 then
               qrySefer.FieldByName('SATICI_ALACAK').AsCurrency:=
               qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency
               else
               qrySefer.FieldByName('SATICI_ALACAK').AsCurrency:=
               qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency*
               qrySefer.FieldByName('MIKTAR').AsCurrency;

         end;

         if qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=1 then
         begin
             qrySefer.FieldByName('SATICI_ALACAK').AsCurrency:=
             qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency*
             qrySefer.FieldByName('SEFER_SAY').AsCurrency;
         end;


         if qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=2 then
         begin

        if qrySefer.FieldByName('MIKTAR').AsCurrency<=0 then
         qrySefer.FieldByName('SATICI_ALACAK').AsCurrency:=
         qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency*
         qrySefer.FieldByName('SEFER_SAY').AsCurrency
         else
         qrySefer.FieldByName('SATICI_ALACAK').AsCurrency:=
         qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency*
         (qrySefer.FieldByName('SEFER_SAY').AsCurrency*
         qrySefer.FieldByName('MIKTAR').AsCurrency);


         end;

    end;


    if Field.FieldName = 'ALICI_B_DOVKOD' then
    begin
      KUR := DataMod.Get_Doviz_Kur(qrySefer.FieldByName('ALICI_B_DOVKOD').AsString,
      qrySefer.FieldByName('ALICI_B_DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur <> 0 then qrySefer.FieldByName('ALICI_B_DOVKUR').AsCurrency := Kur else
      qrySefer.FieldByName('ALICI_B_DOVKUR').AsCurrency := 1;
    end;
    if (Field.FieldName = 'ALICI_BORC') or (Field.FieldName = 'ALICI_B_DOVKUR') then
    begin
      qrySefer.FieldByName('ALICI_BORC_VPB').AsCurrency := qrySefer.FieldByName('ALICI_BORC').AsCurrency
       * qrySefer.FieldByName('ALICI_B_DOVKUR').AsCurrency ;
    end;


    if Field.FieldName = 'SATICI_A_DOVKOD' then
    begin
      KUR := DataMod.Get_Doviz_Kur(qrySefer.FieldByName('SATICI_A_DOVKOD').AsString,
      qrySefer.FieldByName('SATICI_A_DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur <> 0 then qrySefer.FieldByName('SATICI_A_DOVKUR').AsCurrency := Kur else
      qrySefer.FieldByName('SATICI_A_DOVKUR').AsCurrency := 1;
    end;
    if (Field.FieldName = 'SATICI_ALACAK') or (Field.FieldName = 'SATICI_A_DOVKUR') then
    begin
      qrySefer.FieldByName('SATICI_ALACAK_VPB').AsCurrency := qrySefer.FieldByName('SATICI_ALACAK').AsCurrency
       * qrySefer.FieldByName('SATICI_A_DOVKUR').AsCurrency ;
    end;



    if Field.FieldName = 'BEKLEME_FAT_DOV_KOD' then
    begin
      KUR := DataMod.Get_Doviz_Kur(qrySefer.FieldByName('BEKLEME_FAT_DOV_KOD').AsString,
      qrySefer.FieldByName('BEKLEME_FAT_DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur <> 0 then qrySefer.FieldByName('BEKLEME_FAT_DOVKUR').AsCurrency := Kur else
      qrySefer.FieldByName('BEKLEME_FAT_DOVKUR').AsCurrency := 1;
    end;

    if (Field.FieldName = 'BEKLEME_FAT_TUTAR') or (Field.FieldName = 'BEKLEME_FAT_DOVKUR') then
    begin
      qrySefer.FieldByName('BEKLEME_FAT_VPB').AsCurrency := qrySefer.FieldByName('BEKLEME_FAT_TUTAR').AsCurrency
       * qrySefer.FieldByName('BEKLEME_FAT_DOVKUR').AsCurrency ;
    end;




   //Y
    if Field.FieldName = 'SBEKLEME_FAT_DOV_KOD' then
    begin
      KUR := DataMod.Get_Doviz_Kur(qrySefer.FieldByName('SBEKLEME_FAT_DOV_KOD').AsString,
      qrySefer.FieldByName('SBEKLEME_FAT_DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur <> 0 then qrySefer.FieldByName('SBEKLEME_FAT_DOVKUR').AsCurrency := Kur else
      qrySefer.FieldByName('SBEKLEME_FAT_DOVKUR').AsCurrency := 1;
    end;

    if (Field.FieldName = 'SBEKLEME_FAT_TUTAR') or (Field.FieldName = 'SBEKLEME_FAT_DOVKUR') then
    begin
      qrySefer.FieldByName('SBEKLEME_FAT_VPB').AsCurrency := qrySefer.FieldByName('SBEKLEME_FAT_TUTAR').AsCurrency
       * qrySefer.FieldByName('SBEKLEME_FAT_DOVKUR').AsCurrency ;
    end;
    //YS


  end;

end;




function TfrmSefer_Takip.Form_Before_Post(Kes_Kontrol:Boolean):Boolean;
var
   FuncDeger:String;

 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
 DORSE_KOD:String;

begin

  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  //if not DataMod.KAY_TAR_KONTROL(qrySefer.FieldByName('ALICI_B_DOV_BAZ_TAR').AsDate,True) then Exit;
  //if not DataMod.KAY_TAR_KONTROL(qrySefer.FieldByName('SATICI_A_DOV_BAZ_TAR').AsDate,True) then Exit;
  //if not DataMod.KAY_TAR_KONTROL(qrySefer.FieldByName('BAS_TAR').AsDate,True) then Exit;


//  FuncDeger:=DataMod.Before_Post_Kontrol(qrySefer,'SEFER','SEFER_SAY,ALICI_BORC_BIRIM_FIY,ARAC_KOD,ARAC_PLAKA,ALICI_KOD,OLCU_TIP,OLCU_BIRIM,BAS_TAR','SEFER_ID');
  FuncDeger:=DataMod.Before_Post_Kontrol(qrySefer,'SEFER','SEFER_SAY,ALICI_BORC_BIRIM_FIY,ARAC_KOD,ALICI_KOD,OLCU_TIP,OLCU_BIRIM,BAS_TAR,ESYA_ID','SEFER_ID');
  if  funcDeger<> '' Then
  begin
    ShowMessage(funcDeger);
    Exit;
  end;

        {
        if qrySefer.FieldByName('ESYA_ID').AsInteger < 1 then
         begin
           Application.MessageBox('Lütfen Nevi Seçiniz.','Dikkat',MB_ICONWARNING);
           Exit;
        end;
          }

//  (qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger=1) or
//  (qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=1)

  if (qrySefer.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger=1) AND
  (qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger=0)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Seferin Tamamlandýsýný Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;

  if (qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger=1) AND
  (qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger=0)
  then
  begin
      Application.MessageBox('Faturasý Alýnan Seferin Tamamlandýsýný Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;


  if (qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=1) AND
  (qrySefer.FieldByName('BEKLEME_FAT_VAR').AsInteger=0)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Seferin Beklemesini Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;


  if (qrySefer.FieldByName('SBEKLEME_FATURASI_KESILDI').AsInteger=1) AND
  (qrySefer.FieldByName('SBEKLEME_FAT_VAR').AsInteger=0)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Seferin Beklemesini Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;




  if qrySefer.State =DssEdit then
  if (qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger=1) AND
  (qrySefer.FieldByName('SATICI_KOD').AsString<>qrySefer.FieldByName('SATICI_KOD').oldAsString)
  then
  begin
      Application.MessageBox('Faturasý Alýnan Seferin Satýcý Kodunu Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;



  if qrySefer.State =DssEdit then
  if (qrySefer.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger=1) AND
  (qrySefer.FieldByName('ALICI_KOD').AsString<>qrySefer.FieldByName('ALICI_KOD').oldAsString)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Seferin Alýcý Kodunu Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;


  if qrySefer.State =DssEdit then
  if (qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=1) AND
  (qrySefer.FieldByName('ALICI_KOD').AsString<>qrySefer.FieldByName('ALICI_KOD').oldAsString)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Seferin Alýcý Kodunu Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;


  //y
  if qrySefer.State =DssEdit then
  if (qrySefer.FieldByName('SBEKLEME_FATURASI_KESILDI').AsInteger=1) AND
  (qrySefer.FieldByName('SATICI_KOD').AsString<>qrySefer.FieldByName('SATICI_KOD').oldAsString)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Seferin Satýcý Kodunu Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;


        if qrySefer.FieldByName('SEFER_SAY').AsInteger < 1 then
         begin
           Application.MessageBox('Sefer Sayýsý Giriniz.','Dikkat',MB_ICONWARNING);
           Exit;
        end;


        if qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger < 1 then
         begin
           Application.MessageBox('Hesaplama Tipini Giriniz.','Dikkat',MB_ICONWARNING);
           Exit;
        end;


  if qrySefer.FieldByName('BEKLEME_FAT_VAR').AsInteger=1 then
  begin
         if qrySefer.FieldByName('BEKLEME_FAT_TUTAR').AsFloat <= 0 then
         begin
           Application.MessageBox('Bekleme Faturasý Tutarýný Giriniz.','Dikkat',MB_ICONWARNING);
           Exit;
        end;
  end;
//y
  if qrySefer.FieldByName('SBEKLEME_FAT_VAR').AsInteger=1 then
  begin
         if qrySefer.FieldByName('SBEKLEME_FAT_TUTAR').AsFloat <= 0 then
         begin
           Application.MessageBox(' Satýcý Bekleme Faturasý Tutarýný Giriniz.','Dikkat',MB_ICONWARNING);
           Exit;
        end;
  end;
//ys




         if (qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=3) or (qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=2) then
         begin
        if qrySefer.FieldByName('MIKTAR').AsInteger <=0 then
        begin
           Application.MessageBox('Miktar Giriniz.','Dikkat',MB_ICONWARNING);
           Exit;
        end;

         end;


//  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',qrySefer.FieldByName('ARAC_KOD').AsString ,OZ_MAL) then
  begin

      if OZ_MAL='1' then
      begin
         if Length(Trim(qrySefer.FieldByName('PERSONEL_KOD').AsString)) <= 0 then
         begin
           Application.MessageBox('Personel Kodu Seçiniz.','Dikkat',MB_ICONWARNING);
           Exit;
         end;

       qrySefer.FieldByName('SATICI_KOD').AsString := '';
       qrySefer.FieldByName('SATICI_ADI').AsString := '';




       qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency:= 0;



      end;

      if OZ_MAL='0' then
      begin
         if Length(Trim(qrySefer.FieldByName('SATICI_KOD').AsString)) <= 0 then
         begin
           Application.MessageBox('Kiralýk Kodu Seçiniz.','Dikkat',MB_ICONWARNING);
           Exit;;
        end;
        qrySefer.FieldByName('PERSONEL_KOD').AsString := '';
        qrySefer.FieldByName('PERSONEL_ADI').AsString := '';
//        qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency:=
      end;

  end;

  if qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger=1 then
  if qrySefer.FieldByName('BIT_TAR').AsVariant=null then
  begin
    Application.MessageBox('Sefer Bitiþ Tarihini Giriniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  {

  if qrySefer.FieldByName('TUTAR').AsCurrency <= 0 then
  begin

    Application.MessageBox('Tutar deðeri sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if (qrySefer.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin

    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if (qrySefer.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin

    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;
  }

  if Oz_mal='0' then
  if qrySefer.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsCurrency <= 0 then
  begin
    Application.MessageBox('Satýcý alacaðý sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;


  if qrySefer.FieldByName('ALICI_BORC_BIRIM_FIY').AsCurrency <= 0 then
  begin
    Application.MessageBox('Alýcý borcu sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;


  if qrySefer.FieldByName('BEKLEME_FAT_VAR').AsInteger=0 then
  begin
       qrySefer.FieldByName('BEKLEME_FAT_TUTAR').AsFloat:= 0;
       qrySefer.FieldByName('BEKLEME_FAT_VPB').AsFloat:= 0;
  end;

  //Y
  if qrySefer.FieldByName('SBEKLEME_FAT_VAR').AsInteger=0 then
  begin
       qrySefer.FieldByName('SBEKLEME_FAT_TUTAR').AsFloat:= 0;
       qrySefer.FieldByName('SBEKLEME_FAT_VPB').AsFloat:= 0;
  end;
  //YS

  if not DataMod.EN_GER_KAY_TAR_KONTROL(qrySefer.FieldByName('BAS_TAR').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('BAS_TAR').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('ALICI_B_DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('SATICI_A_DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('BEKLEME_FAT_DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  //Y
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('SBEKLEME_FAT_DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;

  Result := True;
end;


procedure TfrmSefer_Takip.Form_Post;
begin
  if not Form_Before_Post(False) then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
     try
        qrySefer.Cancel;
        qrySefer.Close();
     finally

     end;


  if trnSefer.InTransaction then
     trnSefer.Rollback;


    exit;

  end;


  {if (qrySefer.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger=1) or
  (qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger=1) or
  (qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=1)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Sefer Üzerinde Deðiþiklik Yapamazsýnýz','Dikkat',MB_ICONWARNING);
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
  end;
  }
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if trnSefer.InTransaction then
     trnSefer.Rollback;
  trnSefer.StartTransaction;
//****************************************************************************//
  try
//****************************************************************************//
    prnSeferID := qrySefer.FieldByName('Sefer_ID').AsInteger;
    prnSeferSID := qrySefer.FieldByName('Sefer_SID').AsSmallint;
//****************************************************************************//


/////////silme eklemeleri
    if (qrySefer.State in [dssEdit]) then
    begin



        if OM_HAR_KAYDET_SIL(prnSeferID,prnSeferSID) = False then
        begin
          trnSefer.RollbackRetaining;
          dmLOGGER.dbaMain_CancelMonitoring;
          exit;
        end;

    end;

/////////silme eklemeleri son

    if qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger=1 then
    if OM_HAR_KAYDET(False) = False then
    begin
      trnSefer.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
    //else

    if qrySefer.State=DssEdit then
    if qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger=0 then
    if OM_HAR_KAYDET(True) = False then
    begin
      trnSefer.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;


//****************************************************************************//
    qrySefer.Post;



    qrySefer.ApplyUpdates;
    qrySefer.CommitUpdates;

    Kayit_Esnasi:=True;
    if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
    begin
      qry_Sefer_Takip.Edit;
    end;

    qry_Sefer_TakipSEFERLESTI.Value:=1;
    qry_Sefer_TakipSEFER_ID.Value:=
    qrySefer.FieldByName('SEFER_ID').AsInteger;
    qry_Sefer_Takip.Post;

    Kayit_Esnasi:=False;

//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SEFER,MAZOT_FISI,SEFER_KONT,ARAC,ARACHAR,PERSONEL,PERSONEL_HAR,CARI,CARIHAR,',
                                             BT_SEFER,
                                             qrySefer.FieldByName('SEFER_ID').AsInteger,
                                             qrySefer.FieldByName('SEFER_SID').AsInteger,
                                             1,1,'SEFER');
//****************************************************************************//
    trnSefer.Commit;
//****************************************************************************//



    prnSeferID := 0;
    prnSeferSID := 0;
//****************************************************************************//
  except
    trnSefer.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  qrySefer.Close;

end;


procedure TfrmSefer_Takip.GruplarA1Click(Sender: TObject);
begin
    cxG1DBTV1.DataController.Groups.FullExpand;


end;

procedure TfrmSefer_Takip.GruplarKapat1Click(Sender: TObject);
begin
       cxG1DBTV1.DataController.Groups.FullCollapse;
end;

procedure TfrmSefer_Takip.KiralikBildirildiClick(Sender: TObject);
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Edit;
  end;

  if qry_Sefer_TakipKIRALIK_BILDIRILDI.Value=1 then
  qry_Sefer_TakipKIRALIK_BILDIRILDI.Value:=0
  else
  qry_Sefer_TakipKIRALIK_BILDIRILDI.Value:=1;

  qry_Sefer_Takip.Post;
end;

procedure TfrmSefer_Takip.KonteynirAlindiClick(Sender: TObject);
begin
  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Edit;
  end;

  if qry_Sefer_TakipKONT_ALINDI.Value=1 then
  qry_Sefer_TakipKONT_ALINDI.Value:=0
  else
  qry_Sefer_TakipKONT_ALINDI.Value:=1;

  qry_Sefer_Takip.Post;
end;

procedure TfrmSefer_Takip.Kopyala1Click(Sender: TObject);
begin

      Kopyalancak_Kayit_No:=qry_Sefer_Takip.FieldByName('SEFER_TAKIP_ID').AsInteger;
      if Kopyalancak_Kayit_No>0 then
      begin
        cxBu_Yapistir.Enabled:=true;
      end;
end;

procedure TfrmSefer_Takip.mnuALT_SEFERClick(Sender: TObject);
var Active_Sefer_ID,Nevi:INTEGER;
    Aciklama,Kumpanya, Booking_No,Kont_No,Muhur_No,Gonderen_Firm,Gemi_Adi, Tah_liman,Yukleyici_Firm : String;
begin
    with qry_Sefer_Takip do
    begin
      Active_Sefer_ID := FieldByName('SEFER_TAKIP_ID').AsInteger;
      Nevi := FieldByName('NEVI').AsInteger;
      Kumpanya := FieldByName('KUMPANYA').AsString;
      Booking_No := FieldByName('BOOKING_NO').AsString;
      Kont_No := FieldByName('KONTROL_NO').AsString;
      Muhur_No := FieldByName('MUHUR_NO').AsString;
      Gonderen_Firm := FieldByName('GONDEREN_FIRMA').AsString;
      Gemi_Adi := FieldByName('GEMI_ADI').AsString;
      Tah_liman := FieldByName('TAHLIYE_LIMANI').AsString;
      Yukleyici_Firm := FieldByName('YUKLEYICI_FIRMA').AsString;
      Aciklama := FieldByName('ACIKLAMA').AsString;

      Append;
      FieldByName('MASTER_S_TAKIP_ID').AsInteger := Active_Sefer_ID;
      FieldByName('NEVI').AsInteger := Nevi;
      FieldByName('KUMPANYA').AsString := Kumpanya;
      FieldByName('BOOKING_NO').AsString := Booking_No;
      FieldByName('KONTROL_NO').AsString := Kont_No;
      FieldByName('MUHUR_NO').AsString := Muhur_No;
      FieldByName('GONDEREN_FIRMA').AsString := Gonderen_Firm;
      FieldByName('GEMI_ADI').AsString := Gemi_Adi;
      FieldByName('TAHLIYE_LIMANI').AsString := Tah_liman;
      FieldByName('YUKLEYICI_FIRMA').AsString := Yukleyici_Firm;
      FieldByName('ACIKLAMA').AsString := Aciklama;
      Post;

    end;
end;

function TfrmSefer_Takip.OM_HAR_KAYDET(SIL:Boolean):Boolean;
var CARI_YON,PERSONEL_YON,ARAC_YON,ALICI_CARI_YON,SALICI_CARI_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    ARAC_SIL,PERSONEL_SIL,CARI_SIL:Byte;
begin
    CARI_YON := ALACAK;
    PERSONEL_YON := ALACAK;
    ARAC_YON:= ALACAK;

    ALICI_CARI_YON := BORC;

    SALICI_CARI_YON := ALACAK;

  try
      // CARI HAREKET
    if SIL then
    begin
      CARI_SIL := 1
    end
    else
    begin
      CARI_SIL := 0;
    end;

    {if not DataMod.CARIHAR_AUD(trnSefer,
                              BT_SEFER,
                              qrySefer.FieldbyName('Sefer_ID').AsInteger,
                              qrySefer.FieldbyName('Sefer_SID').AsInteger,
                              1,
                              qrySefer.FieldbyName('SATICI_KOD').AsString,
                              CARI_YON,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('SATICI_A_DOV_BAZ_TAR').AsDate,
                              qrySefer.FieldbyName('SATICI_ALACAK').AsCurrency,
                              qrySefer.FieldbyName('SATICI_A_DOVKOD').AsString,
                              qrySefer.FieldbyName('SATICI_A_DOVKUR').AsCurrency,
                              qrySefer.FieldbyName('SATICI_ALACAK_VPB').AsCurrency,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('SEFER_NOTLARI').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              qrySefer.FieldByName('MASRAF_MERK').AsString,
                              qrySefer.FieldByName('KOD1').AsString,
                              qrySefer.FieldByName('KOD2').AsString,
                              qrySefer.FieldByName('KOD3').AsString,
                              qrySefer.FieldByName('KOD4').AsString,
                              //qrySefer.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qrySefer.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    }


//    if qrySefer.FieldbyName('SATICI_ALACAK_BIRIM_FIY').AsCurrency>0 then

    if Trim(qrySefer.FieldbyName('SATICI_KOD').AsString)='' then
    CARI_SIL := 1;


    if qrySefer.FieldbyName('SEFER_ALIS_FAT_ALINDI').AsInteger=1 then
    CARI_SIL := 1;

    if not DataMod.SATICI_CARI_HAR(CARI_SIL,CARI_YON,PRV_ISN,BT_SEFER,qrySefer,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;





      // ALICI CARI HAREKET
    if SIL then
    begin
      CARI_SIL := 1
    end
    else
    begin
      CARI_SIL := 0;
    end;
    {if not DataMod.CARIHAR_AUD(trnSefer,
                              BT_SEFER,
                              qrySefer.FieldbyName('Sefer_ID').AsInteger,
                              qrySefer.FieldbyName('Sefer_SID').AsInteger,
                              1,
                              qrySefer.FieldbyName('ALICI_KOD').AsString,
                              ALICI_CARI_YON,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('ALICI_B_DOV_BAZ_TAR').AsDate,
                              qrySefer.FieldbyName('ALICI_BORC').AsCurrency,
                              qrySefer.FieldbyName('ALICI_B_DOVKOD').AsString,
                              qrySefer.FieldbyName('ALICI_B_DOVKUR').AsCurrency,
                              qrySefer.FieldbyName('ALICI_BORC_VPB').AsCurrency,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('SEFER_NOTLARI').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              qrySefer.FieldByName('MASRAF_MERK').AsString,
                              qrySefer.FieldByName('KOD1').AsString,
                              qrySefer.FieldByName('KOD2').AsString,
                              qrySefer.FieldByName('KOD3').AsString,
                              qrySefer.FieldByName('KOD4').AsString,
                              //qrySefer.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qrySefer.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    }
    if qrySefer.FieldbyName('SEFER_SATIS_FAT_KESILDI').AsInteger=1 then
    CARI_SIL := 1;


    if not DataMod.ALICI_CARI_HAR(CARI_SIL,ALICI_CARI_YON,PRV_ISN,BT_SEFER,qrySefer,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;



    if SIL then
    CARI_SIL:=1
    else
    if qrySefer.FieldbyName('BEKLEME_FAT_VAR').AsInteger=1 then
    CARI_SIL:=0;

    if not SIL then
    if qrySefer.FieldbyName('BEKLEME_FAT_VAR').AsInteger=1 then
    CARI_SIL:=0;


    if qrySefer.FieldbyName('BEKLEME_FAT_VAR').AsInteger=0 then
    CARI_SIL:=1;


    if qrySefer.FieldbyName('BEKLEME_FATURASI_KESILDI').AsInteger=1 then
    CARI_SIL := 1;


    if not DataMod.ALICI_BEKLEME_CARI_HAR(CARI_SIL,ALICI_CARI_YON,PRV_ISN,BT_SEFER,qrySefer,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;





//Y
    if SIL then
    CARI_SIL:=1
    else
    if qrySefer.FieldbyName('SBEKLEME_FAT_VAR').AsInteger=1 then
    CARI_SIL:=0;

    if not SIL then
    if qrySefer.FieldbyName('SBEKLEME_FAT_VAR').AsInteger=1 then
    CARI_SIL:=0;


    if qrySefer.FieldbyName('SBEKLEME_FAT_VAR').AsInteger=0 then
    CARI_SIL:=1;


    if qrySefer.FieldbyName('SBEKLEME_FATURASI_KESILDI').AsInteger=1 then
    CARI_SIL := 1;


    if not DataMod.SALICI_BEKLEME_CARI_HAR(CARI_SIL,SALICI_CARI_YON,PRV_ISN,BT_SEFER,qrySefer,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;




//YS


    //ARAC HAREKETÝ
      ARAC_SIL:=1 ;
      ARAC_SIL:=0;

    if SIL then
    begin
      ARAC_SIL := 1;
    end;


if Trim(qrySefer.FieldbyName('SATICI_KOD').AsString)<>'' then
begin
    if not DataMod.ARACHAR_AUD(trnSefer,
                               BT_SEFER,
                               qrySefer.FieldbyName('Sefer_ID').AsInteger,
                               qrySefer.FieldbyName('Sefer_SID').AsInteger,
                               1,
                               qrySefer.FieldbyName('ARAC_KOD').AsString,
                               ARAC_YON,
                               qrySefer.FieldbyName('BAS_TAR').AsDate,
                               qrySefer.FieldbyName('SATICI_A_DOV_BAZ_TAR').AsDate,
                               qrySefer.FieldbyName('SATICI_ALACAK').AsCurrency,
                               qrySefer.FieldbyName('SATICI_A_DOVKOD').AsString,
                               qrySefer.FieldbyName('SATICI_A_DOVKUR').AsCurrency,
                               qrySefer.FieldbyName('SATICI_ALACAK_VPB').AsCurrency,
                               qrySefer.FieldbyName('SEFER_NOTLARI').AsString,
                               ARAC_SIL,
                               qrySefer.FieldByName('MASRAF_MERK').AsString,
                               qrySefer.FieldByName('KOD1').AsString,
                               qrySefer.FieldByName('KOD2').AsString,
                               qrySefer.FieldByName('KOD3').AsString,
                               qrySefer.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;
end
else
begin

    if not DataMod.ARACHAR_AUD(trnSefer,
                               BT_SEFER,
                               qrySefer.FieldbyName('Sefer_ID').AsInteger,
                               qrySefer.FieldbyName('Sefer_SID').AsInteger,
                               1,
                               qrySefer.FieldbyName('ARAC_KOD').AsString,
                               ARAC_YON,
                               qrySefer.FieldbyName('BAS_TAR').AsDate,
                               qrySefer.FieldbyName('ALICI_B_DOV_BAZ_TAR').AsDate,
                               qrySefer.FieldbyName('ALICI_BORC').AsCurrency,
                               qrySefer.FieldbyName('ALICI_B_DOVKOD').AsString,
                               qrySefer.FieldbyName('ALICI_B_DOVKUR').AsCurrency,
                               qrySefer.FieldbyName('ALICI_BORC_VPB').AsCurrency,
                               qrySefer.FieldbyName('SEFER_NOTLARI').AsString,
                               ARAC_SIL,
                               qrySefer.FieldByName('MASRAF_MERK').AsString,
                               qrySefer.FieldByName('KOD1').AsString,
                               qrySefer.FieldByName('KOD2').AsString,
                               qrySefer.FieldByName('KOD3').AsString,
                               qrySefer.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;





end;
    //PERSONEL HAREKETÝ
      PERSONEL_SIL:=1 ;
      PERSONEL_SIL:=0;

    if SIL then
    begin
      PERSONEL_SIL := 1;
    end;

    if Trim(qrySefer.FieldbyName('PERSONEL_KOD').AsString)='' then
    PERSONEL_SIL := 1;

    if not DataMod.PERSONELHAR_AUD(trnSefer,
                               BT_SEFER,
                               qrySefer.FieldbyName('Sefer_ID').AsInteger,
                               qrySefer.FieldbyName('Sefer_SID').AsInteger,
                               1,
                               qrySefer.FieldbyName('PERSONEL_KOD').AsString,
                               PERSONEL_YON,
                               qrySefer.FieldbyName('BAS_TAR').AsDate,

{                               qrySefer.FieldbyName('SATICI_A_DOV_BAZ_TAR').AsDate,
                               qrySefer.FieldbyName('SATICI_ALACAK').AsCurrency,
                               qrySefer.FieldbyName('SATICI_A_DOVKOD').AsString,
                               qrySefer.FieldbyName('SATICI_A_DOVKUR').AsCurrency,
                               qrySefer.FieldbyName('SATICI_ALACAK_VPB').AsCurrency,
}
                               qrySefer.FieldbyName('ALICI_B_DOV_BAZ_TAR').AsDate,
                               qrySefer.FieldbyName('ALICI_BORC').AsCurrency,
                               qrySefer.FieldbyName('ALICI_B_DOVKOD').AsString,
                               qrySefer.FieldbyName('ALICI_B_DOVKUR').AsCurrency,
                               qrySefer.FieldbyName('ALICI_BORC_VPB').AsCurrency,

                               qrySefer.FieldbyName('SEFER_NOTLARI').AsString,
                               PERSONEL_SIL,
                               qrySefer.FieldByName('MASRAF_MERK').AsString,
                               qrySefer.FieldByName('KOD1').AsString,
                               qrySefer.FieldByName('KOD2').AsString,
                               qrySefer.FieldByName('KOD3').AsString,
                               qrySefer.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;



    Result := True;
  except
    Result := False;
  end; //try end;

end; //FUNCTION END;






function TfrmSefer_Takip.Form_Before_Delete: Boolean;
begin
  Result := False;

  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qrySefer.FieldByName('BAS_TAR').AsDate,True) then Exit;

  if (qrySefer.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger=1) or
  (qrySefer.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger=1) or
  (qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=1) or
  (qrySefer.FieldByName('SBEKLEME_FATURASI_KESILDI').AsInteger=1)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Seferi Silemezsiniz','Dikkat',MB_ICONWARNING);
      exit;
  end;

  if Application.MessageBox('Sefer Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Exit;

  if qrySefer.State =DssEdit then
  qrySefer.Cancel;

  qrySefer.CancelUpdates;


  qrySefer.ApplyUpdates;





  Result := True;
end;


procedure TfrmSefer_Takip.Form_Delete;
var
  Sefer_ID,Sefer_SID : Integer;
begin
  if not Form_Before_Delete then exit;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if trnSefer.InTransaction then
     trnSefer.Rollback;
  trnSefer.StartTransaction;
//****************************************************************************//
  try






    //storedprocs
//****************************************************************************//
    if OM_HAR_KAYDET(True) = False then
    begin
      trnSefer.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;
//****************************************************************************//
    Sefer_ID := qrySefer.FieldByName('SEFER_ID').AsInteger;
    Sefer_SID := qrySefer.FieldByName('SEFER_SID').AsInteger;
//****************************************************************************//


    qrySefer.Delete;
    qrySefer.ApplyUpdates;
    qrySefer.CommitUpdates;



//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SEFER,MAZOT_FISI,SEFER_KONT,ARAC,ARACHAR,PERSONEL,PERSONEL_HAR,CARI,CARIHAR,',
                                             BT_SEFER,
                                             SEFER_ID,
                                             SEFER_SID,
                                             1,2,'SEFER');
//****************************************************************************//
    trnSefer.Commit;

    Kayit_Esnasi:=True;

  if not (qry_Sefer_Takip.State in [dsInsert,dsEdit]) then
  begin
    qry_Sefer_Takip.Edit;
  end;

    qry_Sefer_TakipSEFERLESTI.Value:=0;
    qry_Sefer_TakipSEFER_ID.Value:=0;
    //qrySefer.FieldByName('SEFER_ID').AsInteger;
    qry_Sefer_Takip.Post;

    
        Kayit_Esnasi:=False;

  except
    trnSefer.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  qrySefer.Close;
end;


function TfrmSefer_Takip.OM_HAR_KAYDET_SIL(Id:Integer;Sid:Integer):Boolean;
var CARI_YON,PERSONEL_YON,ARAC_YON,ALICI_CARI_YON,SALICI_CARI_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    ARAC_SIL,PERSONEL_SIL,CARI_SIL:Byte;
    Qry:TIb_Query;
begin
    CARI_YON := ALACAK;
    PERSONEL_YON := ALACAK;
    ARAC_YON:= ALACAK;

    ALICI_CARI_YON := BORC;

    SALICI_CARI_YON := ALACAK;




     DataMod.CreateQuery(Qry,nil,True,DataMod.dbaMain);
     Qry.Active:=False;
     Qry.SQL.Clear;
     Qry.SQL.Text:='SELECT * from SEFER WHERE SEFER_ID=:SEFER_ID and SEFER_SID=:SEFER_SID';
     Qry.ParamByName('SEFER_ID').AsInteger:=Id;
     Qry.ParamByName('SEFER_SID').AsInteger:=Sid;
     Qry.Open;

  try
      // CARI HAREKET

      CARI_SIL := 1;


    {if not DataMod.CARIHAR_AUD(trnSefer,
                              BT_SEFER,
                              qrySefer.FieldbyName('Sefer_ID').AsInteger,
                              qrySefer.FieldbyName('Sefer_SID').AsInteger,
                              1,
                              qrySefer.FieldbyName('SATICI_KOD').AsString,
                              CARI_YON,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('SATICI_A_DOV_BAZ_TAR').AsDate,
                              qrySefer.FieldbyName('SATICI_ALACAK').AsCurrency,
                              qrySefer.FieldbyName('SATICI_A_DOVKOD').AsString,
                              qrySefer.FieldbyName('SATICI_A_DOVKUR').AsCurrency,
                              qrySefer.FieldbyName('SATICI_ALACAK_VPB').AsCurrency,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('SEFER_NOTLARI').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              qrySefer.FieldByName('MASRAF_MERK').AsString,
                              qrySefer.FieldByName('KOD1').AsString,
                              qrySefer.FieldByName('KOD2').AsString,
                              qrySefer.FieldByName('KOD3').AsString,
                              qrySefer.FieldByName('KOD4').AsString,
                              //qrySefer.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qrySefer.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    }


//    if qrySefer.FieldbyName('SATICI_ALACAK_BIRIM_FIY').AsCurrency>0 then


    if Qry.FieldbyName('SATICI_KOD').AsString<>qrySefer.FieldbyName('SATICI_KOD').AsString then

    if not DataMod.SATICI_CARI_HAR(CARI_SIL,CARI_YON,PRV_ISN,BT_SEFER,Qry,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;





      // ALICI CARI HAREKET

      CARI_SIL := 1;

    {if not DataMod.CARIHAR_AUD(trnSefer,
                              BT_SEFER,
                              qrySefer.FieldbyName('Sefer_ID').AsInteger,
                              qrySefer.FieldbyName('Sefer_SID').AsInteger,
                              1,
                              qrySefer.FieldbyName('ALICI_KOD').AsString,
                              ALICI_CARI_YON,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('ALICI_B_DOV_BAZ_TAR').AsDate,
                              qrySefer.FieldbyName('ALICI_BORC').AsCurrency,
                              qrySefer.FieldbyName('ALICI_B_DOVKOD').AsString,
                              qrySefer.FieldbyName('ALICI_B_DOVKUR').AsCurrency,
                              qrySefer.FieldbyName('ALICI_BORC_VPB').AsCurrency,
                              qrySefer.FieldbyName('BAS_TAR').AsDate,
                              qrySefer.FieldbyName('SEFER_NOTLARI').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              qrySefer.FieldByName('MASRAF_MERK').AsString,
                              qrySefer.FieldByName('KOD1').AsString,
                              qrySefer.FieldByName('KOD2').AsString,
                              qrySefer.FieldByName('KOD3').AsString,
                              qrySefer.FieldByName('KOD4').AsString,
                              //qrySefer.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qrySefer.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    }



    if Qry.FieldbyName('ALICI_KOD').AsString<>qrySefer.FieldbyName('ALICI_KOD').AsString then

    if not DataMod.ALICI_CARI_HAR(CARI_SIL,ALICI_CARI_YON,PRV_ISN,BT_SEFER,Qry,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;



    CARI_SIL := 1;


    if Qry.FieldbyName('ALICI_KOD').AsString<>qrySefer.FieldbyName('ALICI_KOD').AsString then

    if not DataMod.ALICI_BEKLEME_CARI_HAR(CARI_SIL,ALICI_CARI_YON,PRV_ISN,BT_SEFER,Qry,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;
//Y

    CARI_SIL := 1;


    if Qry.FieldbyName('SATICI_KOD').AsString<>qrySefer.FieldbyName('SATICI_KOD').AsString then

    if not DataMod.SALICI_BEKLEME_CARI_HAR(CARI_SIL,SALICI_CARI_YON,PRV_ISN,BT_SEFER,Qry,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;

//YS



    //ARAC HAREKETÝ
      ARAC_SIL:=1 ;


if Trim(Qry.FieldbyName('SATICI_KOD').AsString)<>'' then
begin
    if Qry.FieldbyName('ARAC_KOD').AsString<>qrySefer.FieldbyName('ARAC_KOD').AsString then

    if not DataMod.ARACHAR_AUD(trnSefer,
                               BT_SEFER,
                               Qry.FieldbyName('Sefer_ID').AsInteger,
                               Qry.FieldbyName('Sefer_SID').AsInteger,
                               1,
                               Qry.FieldbyName('ARAC_KOD').AsString,
                               ARAC_YON,
                               Qry.FieldbyName('BAS_TAR').AsDate,
                               Qry.FieldbyName('SATICI_A_DOV_BAZ_TAR').AsDate,
                               Qry.FieldbyName('SATICI_ALACAK').AsCurrency,
                               Qry.FieldbyName('SATICI_A_DOVKOD').AsString,
                               Qry.FieldbyName('SATICI_A_DOVKUR').AsCurrency,
                               Qry.FieldbyName('SATICI_ALACAK_VPB').AsCurrency,
                               Qry.FieldbyName('SEFER_NOTLARI').AsString,
                               ARAC_SIL,
                               Qry.FieldByName('MASRAF_MERK').AsString,
                               Qry.FieldByName('KOD1').AsString,
                               Qry.FieldByName('KOD2').AsString,
                               Qry.FieldByName('KOD3').AsString,
                               Qry.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;
end
else
begin

    if Qry.FieldbyName('ARAC_KOD').AsString<>qrySefer.FieldbyName('ARAC_KOD').AsString then

    if not DataMod.ARACHAR_AUD(trnSefer,
                               BT_SEFER,
                               Qry.FieldbyName('Sefer_ID').AsInteger,
                               Qry.FieldbyName('Sefer_SID').AsInteger,
                               1,
                               Qry.FieldbyName('ARAC_KOD').AsString,
                               ARAC_YON,
                               Qry.FieldbyName('BAS_TAR').AsDate,
                               Qry.FieldbyName('ALICI_B_DOV_BAZ_TAR').AsDate,
                               Qry.FieldbyName('ALICI_BORC').AsCurrency,
                               Qry.FieldbyName('ALICI_B_DOVKOD').AsString,
                               Qry.FieldbyName('ALICI_B_DOVKUR').AsCurrency,
                               Qry.FieldbyName('ALICI_BORC_VPB').AsCurrency,
                               Qry.FieldbyName('SEFER_NOTLARI').AsString,
                               ARAC_SIL,
                               Qry.FieldByName('MASRAF_MERK').AsString,
                               Qry.FieldByName('KOD1').AsString,
                               Qry.FieldByName('KOD2').AsString,
                               Qry.FieldByName('KOD3').AsString,
                               Qry.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;





end;
    //PERSONEL HAREKETÝ
      PERSONEL_SIL:=1 ;


    if Qry.FieldbyName('PERSONEL_KOD').AsString<>qrySefer.FieldbyName('PERSONEL_KOD').AsString then

    if not DataMod.PERSONELHAR_AUD(trnSefer,
                               BT_SEFER,
                               Qry.FieldbyName('Sefer_ID').AsInteger,
                               Qry.FieldbyName('Sefer_SID').AsInteger,
                               1,
                               Qry.FieldbyName('PERSONEL_KOD').AsString,
                               PERSONEL_YON,
                               Qry.FieldbyName('BAS_TAR').AsDate,

{                               qrySefer.FieldbyName('SATICI_A_DOV_BAZ_TAR').AsDate,
                               qrySefer.FieldbyName('SATICI_ALACAK').AsCurrency,
                               qrySefer.FieldbyName('SATICI_A_DOVKOD').AsString,
                               qrySefer.FieldbyName('SATICI_A_DOVKUR').AsCurrency,
                               qrySefer.FieldbyName('SATICI_ALACAK_VPB').AsCurrency,
}
                               Qry.FieldbyName('ALICI_B_DOV_BAZ_TAR').AsDate,
                               Qry.FieldbyName('ALICI_BORC').AsCurrency,
                               Qry.FieldbyName('ALICI_B_DOVKOD').AsString,
                               Qry.FieldbyName('ALICI_B_DOVKUR').AsCurrency,
                               Qry.FieldbyName('ALICI_BORC_VPB').AsCurrency,

                               Qry.FieldbyName('SEFER_NOTLARI').AsString,
                               PERSONEL_SIL,
                               Qry.FieldByName('MASRAF_MERK').AsString,
                               Qry.FieldByName('KOD1').AsString,
                               Qry.FieldByName('KOD2').AsString,
                               Qry.FieldByName('KOD3').AsString,
                               Qry.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;



    Result := True;
  except
    Result := False;
  end; //try end;

end; //FUNCTION END;



end.


{
Sefer takip’e günlük kur almadan sefer girince ; seferleþtirirken hata veriyor(buna sefer x diyelim) , ve bu kaydý seferleþtiremezsiniz diyor. (buraya kadar ok)
Sonra kur alýnca sefer id 1 atlayýp devam ediyor. Ve yeniden seferi girip seferleþtiriyoruz (buna da sefer y diyelim)
Sefer takipte ve Hesap hareketi raporlarýnda sefer x görünmüyor. Ancak satýcýya faturalanmamýþ sefer kayýtlarý raporunda sefer x görünüyor. Sefer x ve y için ayný fatura baðlantýsý veriyor. Sefer listesinden sefer x i bulup kaydetle çýkarsak bunu da cariye atýyor. Böylece 1 seferimiz ama 2 farklý id li mükerrer sefer çýkýyor piyasaya.
Sanýrým günlük kur kontrolü seferleþtirme kontrolünden sonra geliyor. Bu yüzden seferi kaydedip sonra hata veriyor ve sefer takibe iþlemiyor. Ama arka tarafta sefer kalýyor. Bu konuda da bir düzeltme yapabilirseniz sevinirim.
}
