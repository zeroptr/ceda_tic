{$INCLUDE directive.inc}

unit ufrmFAT_Tran;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  IB_Controls, Mask, Grids, IB_Grid, Menus;

type
  TfrmFAT_Tran = class(TForm)
    qryFAT_IRS: TIB_Query;
    trnFAT_IRS: TIB_Transaction;
    dtsFAT_IRS: TIB_DataSource;
    pgFAT_IRS: TPageControl;
    tabFAT_IRS: TTabSheet;
    tabAciklama: TTabSheet;
    Panel5: TPanel;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnYeni: TBitBtn;
    btnTRN_KAYDET: TButton;
    qryFAT_IRS_MUH_CARI: TIB_Query;
    dtsFAT_IRS_MUH_CARI: TIB_DataSource;
    qryURUNHAR: TIB_Query;
    dtsURUNHAR: TIB_DataSource;
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
    Label3: TLabel;
    btnTRN_IPTAL: TButton;
    btnFaturaSil: TBitBtn;
    PopupMenu1: TPopupMenu;
    FaturaKopyala1: TMenuItem;
    qry_Temp: TIB_Query;
    QryDegTrans: TIB_Query;
    Btn_Onceki: TBitBtn;
    Btn_Sonraki: TBitBtn;
    Qry_Asl_Urun_Har: TIB_Query;
    Panel1: TPanel;
    Label2: TLabel;
    IB_Edit40: TIB_Edit;
    IB_Edit1: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Date1: TIB_Date;
    cmbFATURA_TIP: TIB_ComboBox;
    txtCariKod: TIB_Edit;
    IB_Edit2: TIB_Edit;
    Panel2: TPanel;
    Panel3: TPanel;
    btnEKLE: TButton;
    btnKaydet: TButton;
    btnIptal: TButton;
    btnSil: TButton;
    Panel4: TPanel;
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
    GrdFatKontrol: TIB_Grid;
    qry_Temp1: TIB_Query;
    IB_Text5: TIB_Text;
    IB_Text1: TIB_Text;
    Memo1: TMemo;
    IB_Text2: TIB_Text;
    Button2: TButton;
    IB_CheckBox1: TIB_CheckBox;
    rgYAZICI: TRadioGroup;
    btnCikti: TButton;
    Btn_Sefer_Bilgisi: TButton;
    Btn_Mazot_Bilgisi: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCikisClick(Sender: TObject);
    procedure qryFAT_IRSAfterInsert(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure txtCariKodButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMuhtelifIptalClick(Sender: TObject);
    procedure pgFAT_IRSChanging(Sender: TObject;      var AllowChange: Boolean);
    procedure pgFAT_IRSChange(Sender: TObject);
    procedure dtsURUNHARStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
    procedure btnEKLEClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure qryURUNHARAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dtsURUNHARDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
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
    procedure cmbFATURA_TIPEnter(Sender: TObject);
    procedure cmbFATURA_TIPExit(Sender: TObject);
    procedure btnFaturaSilClick(Sender: TObject);
    procedure rdFatIsTipChange(Sender: TObject);
    procedure txtUrunKoduExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtKasaKodEnter(Sender: TObject);
    procedure txtKasaKodExit(Sender: TObject);
    procedure txtKasaKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtKasaKodKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure qryURUNHARAfterPost(IB_Dataset: TIB_Dataset);
    procedure qryURUNHARAfterDelete(IB_Dataset: TIB_Dataset);
    procedure IB_Edit40Exit(Sender: TObject);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
    procedure qryURUNHARBeforePost(IB_Dataset: TIB_Dataset);
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
    function  ON_MUH_ENT(SIL:Byte):Boolean;
    function  URUN_HAR_SIL:Boolean;
    function  Form_Before_Delete:Boolean;
    function  Form_Before_Post:Boolean;
    procedure FaturaKopyala1Click(Sender: TObject);
    procedure qryURUNHARBeforeEdit(IB_Dataset: TIB_Dataset);
    procedure Btn_Sefer_BilgisiClick(Sender: TObject);
    procedure Btn_Mazot_BilgisiClick(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Qry_Asl_Urun_HarBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryURUNHARBeforeInsert(IB_Dataset: TIB_Dataset);
    procedure Qry_Asl_Urun_HarAfterDelete(IB_Dataset: TIB_Dataset);
    procedure Qry_Asl_Urun_HarAfterInsert(IB_Dataset: TIB_Dataset);
    procedure Qry_Asl_Urun_HarAfterPost(IB_Dataset: TIB_Dataset);
    procedure GrdFatKontrolKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure GrdFatKontrolDblClick(Sender: TObject);
    procedure Qry_Asl_Urun_HarBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qryURUNHARBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure Button1Click(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }

    prv_FAT_TIP,prv_FAT_IRS_SEP:SmallInt;
    prn_FATURA_ID,prn_FATURA_SID,prv_MY_Index:Integer;
    prv_os_Id,prv_os_SId:Integer;

    prv_FAT_IRS_SERI,prv_BELGE_NO:String;

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
    prv_Sefer_Kaydi:Boolean;
    Silinen_Idler:TStringList;
//    Birlestir_Idler:TStringList;
    Gelen_Idler:TStringList;
    Gelen_Idler_Bekleme:TStringList;
    Gelen_Idler_Mazot:TStringList;
    Giden_Idler:TStringList;
    Giden_Idler_Bekleme:TStringList;
    Giden_Idler_Mazot:TStringList;
    Asil_Urun_Har_Sil_Id:Integer;
		Asil_Urun_Har_Sil_Kod:String;

    procedure FN_BIRIMFIYAT;
    procedure Fatura_Aktarma_Bag_Sil_Tek(Transaction:TIB_Transaction;Fatura_Id: Integer;FaturaD_Id:Integer);
    procedure Fatura_Aktarma_Bag_Sil_Tumu(Transaction:TIB_Transaction;Fatura_Id: Integer);
    function Fatura_Bag_Varmi(Transaction: TIB_Transaction; Fatura_Id, FaturaD_Id: Integer): Boolean;
    function Sefer_Hareketleri_Olusturma(Gelen_Id: Integer;Urun_Kod:String): Boolean;
    procedure Geri_AL;
    procedure KalemBrutHesaplaT(Sil: Boolean);
    procedure KalemHesaplaT;
    procedure txtUrunKoduButtonClick(Sender: TObject);

    procedure Sefer_Mazot_Id_Duzenle(Nereden, Islem: String; Bekleme:Boolean; Id: Integer;Mazot_Sefer:Integer);
    procedure Sefer_Mazot_Id_Doldur;
    function Sefer_Mazot_Hareketleri_Duzenle:Boolean;
    function Sefer_Mazot_Hareketleri_Duzenle_Yeni: Boolean;


  public
    { Public declarations }
    res_Cari:TStringList;
    Disaridan_Fatura:Boolean;
    Sefer_Aktarma:Boolean;
    Mazot_Aktarma:Boolean;
    Sefer_Aktarma_b:Boolean;
    Mazot_Aktarma_b:Boolean;
    procedure Yazdirildi(Sep:Integer;Id:Integer;Sid:Integer);

  end;

  const cns_alis_fatura = 11;
  const cns_satis_fatura = 16;

type
  TKDV=Record
  KDV:SmallInt;
  KDVTUTAR:Currency;
end;

type
  TTek_Satir_Tutar=Record
  Merkez:String;
  TUTAR:Currency;
  Bekleme:Boolean;
  MIKTAR:Currency;
end;

type
  TTek_Satir_Id=Record
  ids:Integer;
  urun_har_id:Integer;
  Sefer_id:Integer;
  Bekleme:Boolean;
end;

var
  frmFAT_Tran  : TfrmFAT_Tran;
  arr_KDV:Array [1..6] of TKDV;
  arr_Tek_Satir_Tutar:Array [1..10000] of TTek_Satir_Tutar;
  arr_Tek_Satir_Id:Array [1..10000] of TTek_Satir_Id;

implementation

uses main,
     unDataMod,
     ufrmCariSDLG,
     ufrmUrunSDLG,
     unFunc,

     unYazici,
     ufrmFAT_IRS_SDLG,
     ufrmISN_ERRORS,
     unLogger, unDEKONT_AUT,  ufrmCariKart,
     ufrmSeferSDLG, ufrmSefer, ufrmMazotSDLG, UDm_Fast_Report;

{$R *.dfm}

procedure TfrmFAT_Tran.Form_Open(Menu:Boolean;FAT_IRS_SEP:Byte;FAT_IRS_ID:Integer;FAT_IRS_SID:Integer;ISLEM:Byte;TIP:SmallInt);
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

          if not DataMod.Modul_Hak(cns_satis_fatura,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if ((ISLEM = 0) and (local_can_update = False)) then
            begin
              Application.MessageBox('Bu modülde yeni satýþ faturasý yetkiniz yok.','Dikkat',MB_ICONWARNING);
              exit;
            end;
          end;
        end;
      2://alýþ faturasý
        begin
          if not DataMod.Modul_Hak(cns_alis_fatura,local_can_update,local_can_delete) then
          begin
            Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
            exit;
          end
          else
          begin
            if ((ISLEM = 0) and (local_can_update = False)) then
            begin
              Application.MessageBox('Bu modülde yeni alýþ faturasý yetkiniz yok.','Dikkat',MB_ICONWARNING);
              exit;
            end;
          end;
        end;
      end;
    end;
  end;//end case
//****************************************************************************//
  if not MainForm.FindChildFrm( Application, 'frmFAT_Tran') then
  begin
    Application.CreateForm (TfrmFAT_Tran,frmFAT_Tran);
    frmFAT_Tran.prv_CanUpdate := local_can_update;
    frmFAT_Tran.prv_CanDelete := local_can_delete;
  end
  else
  begin
    Application.MessageBox('Fatura formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
//****************************************************************************//
  with frmFAT_Tran do
  begin
    pgFAT_IRS.ActivePage := frmFAT_Tran.tabFAT_IRS;
    grpBoxCari.Visible := False;
    grpBoxMuhtelif.Visible := False;
    prv_FAT_TIP := TIP;
    prv_FAT_IRS_SEP := FAT_IRS_SEP;
    DataMod.CreateQuery(qryFAT_PARAMS,Nil,False,DataMod.dbaMain);
    qryFAT_PARAMS.SQL.Add('Select * from FAT_PARAMS WHERE FAT_PARAMS_ID = 1');
    try
      qryFAT_PARAMS.Active := True;
      if qryFAT_PARAMS.RecordCount <> 0 then
      begin
        if qryFAT_PARAMS.FieldByName('EK_ACK_KUL').AsSmallint = 0 Then
        begin
          tabAciklama.TabVisible  := False;
        end;
        // KALEM BAZINDA ISKONTO KULLANIYOR MU?
        {
        rdIskonto.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        txtIskontoOran.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        txtIskontoTutar.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        txtISKONTO_TUTAR_VPB.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        lblKAL_ISKONTO_TIP.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        lblTOP_PAG_KAL_ISK_TOP.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        txtTOP_PAG_KAL_ISK_TOP.Visible := (qryFAT_PARAMS.FieldByName('KAL_BAZ_ISK').AsSmallint = 1);
        }
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
//****************************************************************************//
    case TIP of
    1:
      begin
        Btn_Mazot_Bilgisi.Visible:=False;
        Caption := 'Satýþ Faturasý';
        prv_BELGE_TUR := BT_SATIS_FAT;
        cmbFATURA_TIP.Items.Clear;
        cmbFATURA_TIP.Items.Add('KAPALI');
        cmbFATURA_TIP.Items.Add('AÇIK');
        cmbFATURA_TIP.Items.Add('ALIÞTAN ÝADE');
        cmbFATURA_TIP.Items.Add('ÝHRACAT');
        cmbFATURA_TIP.ItemValues.Clear;
        cmbFATURA_TIP.ItemValues.Add('1');
        cmbFATURA_TIP.ItemValues.Add('2');
        cmbFATURA_TIP.ItemValues.Add('3');
        cmbFATURA_TIP.ItemValues.Add('4');
      end;
    2:
      begin
        //Btn_Sefer_Bilgisi.Visible:=False;
        Caption := 'Alýþ Faturasý';
        prv_BELGE_TUR := BT_ALIS_FAT;
        cmbFATURA_TIP.Items.Clear;
        cmbFATURA_TIP.Items.Add('KAPALI');
        cmbFATURA_TIP.Items.Add('AÇIK');
        cmbFATURA_TIP.Items.Add('SATIÞTAN ÝADE');
        cmbFATURA_TIP.ItemValues.Clear;
        cmbFATURA_TIP.ItemValues.Add('1');
        cmbFATURA_TIP.ItemValues.Add('2');
        cmbFATURA_TIP.ItemValues.Add('3');


        btnCikti.Visible:=False;
        rgYAZICI.Visible:=False;
        IB_CheckBox1.Visible:=False;

      end;
    end;//end case


  {$IfDef TRANSPORT}
      rgYAZICI.itemindex:=2;
  {$EndIf}


//****************************************************************************//
  end;//with FaturaBur
//****************************************************************************//
  frmFAT_Tran.DataSet_Open(FAT_IRS_ID,FAT_IRS_SID,Islem);
  FormatDisplays;
end;

procedure TfrmFAT_Tran.DataSet_Open(FAT_IRS_ID:Integer;FAT_IRS_SID:Integer;ISLEM:Byte);
begin
   Gelen_Idler_Mazot.Clear;
   Gelen_Idler.Clear;
   Gelen_Idler_Bekleme.Clear;
   Silinen_Idler.Clear;
   Giden_Idler.Clear;
   Giden_Idler_Bekleme.Clear;
   Giden_Idler_Mazot.Clear;

   Sefer_Aktarma:=False;
   Mazot_Aktarma:=False;


    trnFAT_IRS.Rollback;
    {if trnFAT_IRS.InTransaction then
    trnFAT_IRS.Rollback;}
    trnFAT_IRS.StartTransaction;


  if ((ISLEM = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmFAT_Tran do
  begin

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
    prv_FAT_IRS_SERI:=qryFAT_IRS.FieldByName('FAT_IRS_SERI').AsString;
    prv_BELGE_NO:=qryFAT_IRS.FieldByName('BELGE_NO').AsString;


    with Qry_Asl_Urun_Har do
    begin
      Active := False;
      ParamByName('PRM_FATURA_ID').AsInteger :=  qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
      ParamByName('PRM_FATURA_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
      Active := True;
    end;

    //ilk hareketleri açýlþta geri al
    {Qry_Asl_Urun_Har.First;
    While not Qry_Asl_Urun_Har.eof do
    begin
       Qry_Asl_Urun_Har.Delete;
       Qry_Asl_Urun_Har.First;
    end;
    }
//****************************************************************************//
    prn_FATURA_ID := FAT_IRS_ID;
    prn_FATURA_SID := FAT_IRS_SID;
    prv_os_id:=FAT_IRS_ID;
//****************************************************************************//
    case Islem of
    0:
      begin
        qryFAT_IRS.Insert;
        prv_os_id:=qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;

        prv_KDV_HESAPLA := True;
        cmbFATURA_TIP.Enabled := True;

        prv_FAT_IRS_SERI:=qryFAT_IRS.FieldByName('FAT_IRS_SERI').AsString;
        prv_BELGE_NO:=qryFAT_IRS.FieldByName('BELGE_NO').AsString;
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
        qryFAT_IRS.Edit;
//****************************************************************************//
//****************************************************************************//
        cmbFATURA_TIP.Enabled := False;
      end;
    end;
//****************************************************************************//
    with qryURUNHAR do
    begin
      Active := False;
      ParamByName('PRM_FATURA_ID').AsInteger :=  qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
      ParamByName('PRM_FATURA_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
      Active := True;
    end;

    Sefer_Mazot_Id_Doldur;

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

procedure TfrmFAT_Tran.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmFAT_Tran.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmFAT_Tran.qryFAT_IRSAfterInsert(IB_Dataset: TIB_Dataset);
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
    1://satýþ faturasý
      begin
        if glb_SUBELI then
        begin
          FieldByName('FAT_IRS_SERI').AsString := DataMod.GETPARAM(cns_satis_fatura,'FAT_SERI',glb_SID);
          FieldByName('BELGE_NO').AsString := IntToStr(DataMod.GET_SAYAC_NUM('SATIS_FATURA',True,False,glb_SID));
        end
        else
        begin
          FieldByName('FAT_IRS_SERI').AsString := DataMod.GETPARAM(cns_satis_fatura,'FAT_SERI',0);
          FieldByName('BELGE_NO').AsString := IntToStr(DataMod.GET_SAYAC_NUM('SATIS_FATURA',True,False,0));
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


procedure TfrmFAT_Tran.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmFAT_Tran.btnTRN_KAYDETClick(Sender: TObject);
begin
  Form_Post;
end;



function TfrmFAT_Tran.Fatura_Bag_Varmi(Transaction:TIB_Transaction;Fatura_Id:Integer;FaturaD_Id:Integer):Boolean;
var
  qryDeg:TIb_Query;
begin
  Result:=False;
  DataMod.CreateQuery(qryDeg,Nil,False,DataMod.dbaMain);
  qryDeg.Active := False;
  qryDeg.SQL.Clear;
  qryDeg.SQL.Text:=
  'SELECT SIPARIS_D_FAT.SIPARIS_D_FAT_ID,SIPARIS_D_FAT.SIPARIS_ID,SIPARIS_D_FAT.SIPARISD_ID, SIPARIS_D_FAT.MIKTAR FROM SIPARIS_D_FAT '+
  ' WHERE  SIPARIS_D_FAT.FATURA_ID=:FATURA_ID and SIPARIS_D_FAT.FATURAD_ID=:FATURAD_ID';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_Id;
  qryDeg.Active := True;
  if qryDeg.FieldByName('SIPARIS_D_FAT_ID').AsInteger>0 then
  Result:=True;
end;

procedure TfrmFAT_Tran.Fatura_Aktarma_Bag_Sil_Tumu(Transaction:TIB_Transaction;Fatura_Id:Integer);
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
  ' WHERE SIPARIS_D_FAT.FATURA_ID=:FATURA_ID';
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

procedure TfrmFAT_Tran.Fatura_Aktarma_Bag_Sil_Tek(Transaction:TIB_Transaction;Fatura_Id:Integer;FaturaD_Id:Integer);
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
  ' WHERE  SIPARIS_D_FAT.FATURA_ID=:FATURA_ID and SIPARIS_D_FAT.FATURAD_ID=:FATURAD_ID';
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

procedure TfrmFAT_Tran.btnTRN_IPTALClick(Sender: TObject);
var
  qryDeg,qryDeg1:TIB_Query;
begin
    if Application.MessageBox('Ýptal etmek istediðinizden emin misiniz?','Dikkat',MB_YESNO+MB_ICONQUESTION)=ID_YES then
    begin

      CancelUpdates;
      CommitUpdates;
//****************************************************************************//
      trnFAT_IRS.Rollback;
//      trnFAT_IRS.RollbackRetaining;

      dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
      grpBoxCari.Visible := False;
      grpBoxMuhtelif.Visible := False;
//****************************************************************************//
      prn_FATURA_ID := 0;
      prn_FATURA_SID := 0;
    end;
end;

procedure TfrmFAT_Tran.txtCariKodButtonClick(Sender: TObject);
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
    qryFAT_IRS.FieldByName('CARI_AD').AsString:= CARI_AD;
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

procedure TfrmFAT_Tran.MuhtelifIslemler;
begin
  with frmFAT_Tran.qryFAT_IRS_MUH_CARI do
  begin
    Active := False;
    ParamByName('PRM_FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
    ParamByName('PRM_FAT_IRS_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
    ParamByName('PRM_FAT_IRS_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
    Active := True;
  end;

  if ((frmFAT_Tran.qryFAT_IRS_MUH_CARI.Bof) And (frmFAT_Tran.qryFAT_IRS_MUH_CARI.Eof)) then
  begin
    with frmFAT_Tran.qryFAT_IRS_MUH_CARI do
    begin
      Insert;
      FieldByName('FAT_IRS_SEP').AsInteger := prv_FAT_IRS_SEP;
      FieldByName('FAT_IRS_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
      FieldByName('FAT_IRS_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
    end;
  end;
end;

procedure TfrmFAT_Tran.Cari2Labels;
begin
  with frmFAT_Tran do
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

procedure TfrmFAT_Tran.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmFAT_Tran);

  IB_Edit1.Font.Color:=clRed;
  IB_Edit3.Font.Color:=clRed;
  IB_CheckBox1.Font.Color:=clRed;  


  res_Cari:=TStringList.Create;

  Gelen_Idler:=TStringList.Create;
  Gelen_Idler_Mazot:=TStringList.Create;
  Gelen_Idler_Bekleme:=TStringList.Create;
  Silinen_Idler:=TStringList.Create;
  Giden_Idler:=TStringList.Create;
  Giden_Idler_Bekleme:=TStringList.Create;
  Giden_Idler_Mazot:=TStringList.Create;

end;

procedure TfrmFAT_Tran.btnMuhtelifIptalClick(Sender: TObject);
begin
  qryFAT_IRS_MUH_CARI.Cancel;
  qryFAT_IRS.FieldByName('MUHTELIF').AsSmallint := 0;
  txtCariKod.Enabled := True;
  qryFAT_IRS.FieldByName('CARI_KOD').AsString := '';
  grpBoxMuhtelif.Visible := False;
end;

procedure TfrmFAT_Tran.pgFAT_IRSChanging(Sender: TObject; var AllowChange: Boolean);
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
    end
    else
    if qryFAT_IRS.FieldByName('MUHTELIF').AsSmallInt = 1 Then
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
  if pgFAT_IRS.ActivePage = tabAciklama Then
  begin
    if qryFAT_IRS_ACK.State in [dssEdit,dssInsert] Then qryFAT_IRS_ACK.Post;
  end;
end;

procedure TfrmFAT_Tran.pgFAT_IRSChange(Sender: TObject);
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
    if pgFAT_IRS.ActivePage = tabAciklama then
    begin
       EkAciklamaOpen;
    end;
  finally
    qryURUNHAR.EnableControls;
  end;
end;

procedure TfrmFAT_Tran.dtsURUNHARStateChanged(Sender:TIB_DataSource;ADataset:TIB_Dataset);
begin
  if ADataset.State in [dssINSERT,dssEDIT] then
  begin
    btnEKLE.Enabled := False;
    btnSIL.Enabled := False;
    btnKAYDET.Enabled := True;
    btnIPTAL.Enabled := True;

  end
  else
  begin
    btnEKLE.Enabled := True;
    if not ((qryURUNHAR.Eof) and (qryURUNHAR.Bof)) then
    begin
      btnSil.Enabled := True
    end
    else
    begin
      btnSil.Enabled := False;
    end;

    {if ADataset.FieldByName('URUNHAR_ID').AsInteger<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;
     }

    btnKAYDET.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmFAT_Tran.btnEKLEClick(Sender: TObject);
begin
  qryURUNHAR.Append;
end;

procedure TfrmFAT_Tran.btnKaydetClick(Sender: TObject);
begin
  ////kaydetmeden önce kontroller yapýlacak
  {if Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString)='' then
  begin
    Application.MessageBox('Ürün kodu seçimi yapmadýnýz.!!','Dikkat',MB_ICONWARNING);
    //txtUrunKoduButtonClick(Self);
    exit;
  end;

  if qryURUNHAR.FieldByName('MIKTAR').AsCurrency <=0 then
  begin
    Application.MessageBox('Miktar alaný sýfýrdan küçük ya da eþit olamaz!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('MIKTAR').AsCurrency := 1;
    exit;
  end;

  if Trim(qryURUNHAR.FieldByName('OLCUBIRIM').AsString)='' then
  begin
    Application.MessageBox('Ölçü Birimi Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Exit;
  end;

  if (qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency <= 0) then
  begin

    Application.MessageBox('Birim fiyatý sýfýrdan küçük ya da eþit olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency := 1;
    exit;
  end;

  if (qryURUNHAR.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('DOVKUR').AsCurrency := 1;
    exit;
  end;

  if (qryURUNHAR.FieldByName('KDV').AsCurrency < 0) then
  begin
    Application.MessageBox('KDV oraný sýfýrdan küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    qryURUNHAR.FieldByName('KDV').AsCurrency := 0;
    exit;
  end;

  if (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!!','Dikkat',MB_ICONWARNING);
    exit;
  end;
   }
  qryURUNHAR.Post;
  prv_Burut_Top:=prv_Temp_Burut_Top;
end;

procedure TfrmFAT_Tran.btnIptalClick(Sender: TObject);
begin
  qryURUNHAR.Cancel;
end;

procedure TfrmFAT_Tran.btnSilClick(Sender: TObject);
begin
  if qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger>0 then
  begin
       if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Exit;
       qryURUNHAR.Delete;
  end;
end;

procedure TfrmFAT_Tran.qryURUNHARAfterInsert(IB_Dataset: TIB_Dataset);
begin
   //Sleep(200);
   with IB_Dataset do
   begin
     FieldByName('URUNHAR_ID').AsInteger := qryURUNHAR.Gen_ID('GEN_URUNHAR',1);
     FieldByName('URUNHAR_SID').AsInteger := glb_SID;

     FieldByName('FATURA_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
     FieldByName('FATURA_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
     FieldByName('IRSALIYE_ID').AsInteger := 0;
     FieldByName('IRSALIYE_SID').AsInteger := 0;
     FieldByName('DEPO_KOD').AsString := qryFAT_IRS.FieldByName('DEPO_KOD').AsString;
     FieldByName('DEPO_AD').AsString := qryFAT_IRS.FieldByName('DEPO_AD').AsString ;

     FieldByName('BELGE_TUR').AsInteger := prv_BELGE_TUR;
     FieldByName('BELGE_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger ;
     FieldByName('BELGE_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger ;
     FieldByName('BELGE_SIRA_NO').AsInteger := 1;
     FieldByName('ISKONTO_TIP').AsInteger := 0;
     FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := 0 ;
     FieldByName('DOVKOD').AsString := glb_DEFCUR;

     FieldByName('CIKIS_MIKTAR').AsCurrency := 0;

     FieldByName('OLCUBIRIM').AsString:='ADET';
     FieldByName('OLCUBIRIM_URN_OB').AsString:='ADET';
     FieldByName('URUN_DOVKOD').AsString:='YTL';

     FieldByName('SEFER_ID').AsInteger := 0;
     FieldByName('MAZOT_FISI_ID').AsInteger := 0;
     FieldByName('SEFER_BEKLEME').AsInteger := 0;

     If (prv_FAT_TIP = 1) then  //SATIÞ
     begin
       FieldByName('TIP').AsString :=  ALACAK;
     end else
     begin   //ALIÞ
       FieldByName('TIP').AsString :=  BORC;
     end;

     FieldByName('KDV').AsInteger := 0;

     if prv_KDV_HESAPLA then
     begin
        FieldByName('KDV').AsInteger := 18
     end
     else
     begin
        FieldByName('KDV').AsInteger := 0;
     end;


   end;
   //Sleep(200);
end;

procedure TfrmFAT_Tran.KalemHesapla;
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
    if qryURUNHAR.FieldByName('KDV').AsInteger <> 0 then  qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency :=
    (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency-qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) * (qryURUNHAR.FieldByName('KDV').AsInteger / 100);
  end
  else
  begin
    qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency := 0;
  end;

end;

procedure TfrmFAT_Tran.dtsURUNHARDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
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
    {if (Field.FieldName='OLCUBIRIM') then
    begin
        FN_BIRIMFIYAT;
    end;
    }
//****************************************************************************//
  end; //Assigned( Field ) Then
end;
procedure TfrmFAT_Tran.FN_BIRIMFIYAT;
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

procedure TfrmFAT_Tran.KDV_Hesapla;
var
  temp:Array [1..5] of TKDV;
  i,j,Sayac:Integer;
  TopKDV,BURUTTOP,KALISKONTOTOP:Currency;
  gnl_iskonto_orn:double;  
begin

  if (qryURUNHAR.Eof) or (qryURUNHAR.Eof)
  or (qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger<0) then Exit;

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
      (qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency-qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency) *  qryURUNHAR.FieldByName('KDV').AsSmallInt/100;
      BURUTTOP := BURUTTOP + qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency;
      KALISKONTOTOP := KALISKONTOTOP + qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
      inc(Sayac);
    end
    else
    begin
      arr_KDV[prv_MY_Index].KDVTUTAR := arr_KDV[prv_MY_Index].KDVTUTAR +
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

      {if qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency>0 then
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

procedure TfrmFAT_Tran.dtsFAT_IRSStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
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
    end;
    }

    if qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger<=0 then
    begin
      btnFaturaSil.Enabled := False;
//      Btn_Onceki.Enabled := False;
//      Btn_Sonraki.Enabled := False;
    end
    else
    begin
      btnFaturaSil.Enabled := True;
//      Btn_Onceki.Enabled := True;
//      Btn_Sonraki.Enabled := True;
    end;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
  end;
end;

procedure TfrmFAT_Tran.dtsFAT_IRSDataChange(Sender: TIB_StatementLink;
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
      //satýþ faturasý ve ithalat ihracat ise
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

procedure TfrmFAT_Tran.FaturaToplamHesapla;
begin
  with qryFAT_IRS do
  begin
    FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency := FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency+FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
    FieldByName('NET_TOP').AsCurrency := FieldByName('BRUT_TOP').AsCurrency -(FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency+FieldByName('ISKONTO_TUTAR_VPB').AsCurrency);
    FieldByName('GENEL_TOP').AsCurrency := FieldByName('NET_TOP').AsCurrency + FieldByName('KDV_TOP').AsCurrency+FieldByName('OTV').AsCurrency;
  end;
end;

procedure TfrmFAT_Tran.txtKasaKodButtonClick(Sender: TObject);
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

procedure TfrmFAT_Tran.EkAciklamaOpen ;
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
  if not ((DataMod.qryGENEL.Bof) and (DataMod.qryGENEL.Eof)) then /// böyle bi þey olmazki salak
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

procedure TfrmFAT_Tran.btnAraClick(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if frmFAT_IRS_SDLG.Form_Open(False,prv_FAT_IRS_SEP,FAT_IRS_ID,FAT_IRS_SID,prv_FAT_TIP,False) then
  begin
    DataSet_Open(FAT_IRS_ID,FAT_IRS_SID,1);
  end;
end;

procedure TfrmFAT_Tran.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmFAT_Tran.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmFAT_Tran.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.color :=clWindow;
end;

procedure TfrmFAT_Tran.txtCariKodEnter(Sender: TObject);
begin
  txtCariKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmFAT_Tran.txtCariKodExit(Sender: TObject);
var
   FaturaTipi:String;
begin
  txtCariKod.Color := clWindow;
  if Trim(txtCariKod.Text) <> '' then
  begin
    if DataMod.FN_CariKOD2Bilgi(txtCariKod.Text,res_Cari) then
    begin
      qryFAT_IRS.FieldByName('CARI_AD').AsString:= res_Cari[1];
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

  if Trim(qryFAT_IRS.FieldByName('ACIKLAMA').AsString) = '' then
  begin

    if prv_FAT_TIP=1  then FaturaTipi:=' Satýþ Faturasý ';
    if prv_FAT_TIP=2  then FaturaTipi:=' Alýþ Faturasý ';

    qryFAT_IRS.FieldByName('ACIKLAMA').AsString :=
    qryFAT_IRS.FieldByName('FAT_IRS_SERI').AsString + ' '+
    qryFAT_IRS.FieldByName('BELGE_NO').AsString+ ' Nolu '+FaturaTipi;

  end;

end;

procedure TfrmFAT_Tran.txtCariKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmFAT_Tran.txtCariKodKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if Key = VK_F4 Then txtCariKodButtonClick(Self);
end;

procedure TfrmFAT_Tran.cmbFATURA_TIPEnter(Sender: TObject);
begin
  cmbFATURA_TIP.Color := glb_Art_Alan_Renk;
end;

procedure TfrmFAT_Tran.cmbFATURA_TIPExit(Sender: TObject);
begin
  cmbFATURA_TIP.Color := clWindow;
end;

procedure TfrmFAT_Tran.btnFaturaSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmFAT_Tran.rdFatIsTipChange(Sender: TObject);
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

procedure TfrmFAT_Tran.txtUrunKoduExit(Sender: TObject);
var
 KDV_TUTAR,Fiyat:Currency;
 DOVKOD,Urun_Ad,OlcuBirim,Depo_Kod,Depo_Ad:String;
 KDV,KDV_DAHIL:Byte;
begin
  if not (qryURUNHAR.State in [dssEdit,dssInsert]) then exit;
//****************************************************************************//
  if Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString) <> '' then
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


    end;
  end;
end;

procedure TfrmFAT_Tran.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if dtsFAT_IRS.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Fatura bilgileri bölümünde yaptýðýnýz deðiþiklikleri kaydeniniz veya iptal ediniz.','DÝKKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmFAT_Tran.txtKasaKodEnter(Sender: TObject);
begin
  txtKasaKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmFAT_Tran.txtKasaKodExit(Sender: TObject);
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

procedure TfrmFAT_Tran.txtKasaKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmFAT_Tran.txtKasaKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then txtKasaKodButtonClick(Self);
end;

procedure TfrmFAT_Tran.FormResize(Sender: TObject);
begin
  btnCikis.Left := frmFAT_Tran.Width  - (btnCikis.Width + 25 );
  btnAra.Left := frmFAT_Tran.Width  - ( btnCikis.Width + btnAra.Width + 28 );

end;


function TfrmFAT_Tran.ON_MUH_ENT(SIL:Byte):Boolean;
var
  BELGE_ID,BELGE_SID,a:Integer;
  Proje_BA,KASA_GC,Cari_BA,URUN_HAR_TIP:Char;
  Proje_Sil,KASA_SIL,ISLEM_SIRA_NO:Byte;
  qryKASAHAR:TIB_Query;
  KASA_DOVKOD:String;
  Ent_Message:PChar;
  KasaDeger:Currency;

begin
  //TIP: 1 Satýþ, 2 Alýþ
  case qryFAT_IRS.FieldByName('TIP').AsInteger of
  1: // satýþ
    begin
      case qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsInteger of
      1:// KAPALI
        begin
          Cari_BA := BORC;
          Proje_BA := BORC;
          KASA_GC := GIRIS;
        end;
      2://AÇIK
        begin
          Cari_BA := BORC;
          Proje_BA := BORC;
          KASA_GC := GIRIS;
        end;
      3://ÝADE
        begin
          Cari_BA := BORC;
          Proje_BA := ALACAK;
          KASA_GC := CIKIS;
        end;
      4: //ÝTHALAT / ÝHRACAT
        begin
          Cari_BA := BORC;
          Proje_BA := BORC;
          KASA_GC := GIRIS;
        end;
      end;//end case qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsInteger of
    end;
  2: // alis
    begin
      case qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsInteger of
      1: // KAPALI
        begin
          Cari_BA     := ALACAK;
          Proje_BA    := ALACAK;
          KASA_GC     := CIKIS;
        end;
      2: //AÇIK
        begin
           Cari_BA     := ALACAK;
           Proje_BA    := ALACAK;
           KASA_GC     := CIKIS;
        end;
      3: //ÝADE
        begin
           Cari_BA     := ALACAK;
           Proje_BA    := BORC;
           KASA_GC     := GIRIS;
        end;
      end;
    end;
  end;
  try
    try
      ISLEM_SIRA_NO := 1;
      if SIL = 0 then
      begin
        //silme iþleminde urun hareketleri URUN_HAR_SIL tarafýndan zaten silinmiþ olacaðýndan bu URUNHAR_AUD prosedurü tekrar calýþtýrýlmaz
        qry_Asl_Urun_Har.DisableControls;
        qry_Asl_Urun_Har.First;
        while not qry_Asl_Urun_Har.Eof Do
        begin

          if prv_FAT_TIP = 1 then
             URUN_HAR_TIP := ALACAK
          else
             URUN_HAR_TIP := BORC;

          //if (qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString <> '') or (qry_Asl_Urun_Har.FieldByName('IRSALIYE_ID').AsInteger = 0) then
          if (qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString <> '') and (qry_Asl_Urun_Har.FieldByName('IRSALIYE_ID').AsInteger = 0) then
          begin
            if not DataMod.URUN_HAR_AUD(trnFAT_IRS,
                                        qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,
                                        qry_Asl_Urun_Har.FieldByName('DEPO_KOD').AsString,
                                        URUN_HAR_TIP,
                                        qry_Asl_Urun_Har.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency,
                                        qry_Asl_Urun_Har.FieldByName('TUTAR_VPB').AsCurrency,
                                        qry_Asl_Urun_Har.FieldByName('MIKTAR_URN_OB').AsCurrency) then
            begin
              Result := False;
              Exit;
            end;
          end;
          qry_Asl_Urun_Har.Next;
        end;
      end;

      if (qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsInteger <> 1) then //kapalý fatura deðil ise
      begin
        if not DataMod.CARIHAR_AUD(trnFAT_IRS,
                          prv_BELGE_TUR,
                          qryFAT_IRS.FieldbyName('FAT_IRS_ID').AsInteger,
                          qryFAT_IRS.FieldbyName('FAT_IRS_SID').AsInteger,
                          ISLEM_SIRA_NO,
                          qryFAT_IRS.FieldbyName('CARI_KOD').AsString,
                          Cari_BA,
                          qryFAT_IRS.FieldbyName('TARIH').AsDate,
                          qryFAT_IRS.FieldbyName('TARIH').AsDate,
                          qryFAT_IRS.FieldbyName('TARIH').AsDate,
                          qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency,
                          glb_DEFCUR,
                          1,
                          qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency,
                          qryFAT_IRS.FieldbyName('VADE_TARIH').AsDate,
                          qryFAT_IRS.FieldbyName('ACIKLAMA').AsString,
                          SIL,
                          PRV_ISN,
                          qryFAT_IRS.FieldByName('MASRAF_MERK').AsString,
                          qryFAT_IRS.FieldByName('KOD1').AsString,
                          qryFAT_IRS.FieldByName('KOD2').AsString,
                          qryFAT_IRS.FieldByName('KOD3').AsString,
                          qryFAT_IRS.FieldByName('KOD4').AsString,
                          qryFAT_IRS.FieldByName('PLASIYER_KOD').AsString,
                          qryFAT_IRS.FieldByName('PROJE_KOD').AsString,
                          BELGE_ID,
                          BELGE_SID) then
        begin
          Result := False;
          Exit;
        end;
      end;
      //cari har end
      // proje begin
      if SIL = 0 then if Trim(qryFAT_IRS.FieldByName('PROJE_KOD').AsString) = '' then Proje_Sil:=1 Else Proje_Sil :=0
      else Proje_Sil:=1;
      if not DataMod.PROJEHAR_AUD(trnFAT_IRS,
                            prv_BELGE_TUR,
                            qryFAT_IRS.FieldbyName('FAT_IRS_ID').AsInteger,
                            qryFAT_IRS.FieldbyName('FAT_IRS_SID').AsInteger,
                            ISLEM_SIRA_NO,
                            qryFAT_IRS.FieldbyName('PROJE_KOD').AsString,
                            qryFAT_IRS.FieldbyName('TARIH').AsDate,
                            qryFAT_IRS.FieldbyName('TARIH').AsDate,
                            qryFAT_IRS.FieldbyName('TARIH').AsDate,
                            qryFAT_IRS.FieldbyName('VADE_TARIH').AsDate,
                            Proje_BA,
                            glb_DEFCUR,
                            1,
                            qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency,
                            qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency,
                            Proje_Sil,
                            qryFAT_IRS.FieldbyName('ACIKLAMA').AsString,
                            PRV_ISN,
                            qryFAT_IRS.FieldByName('MASRAF_MERK').AsString,
                            qryFAT_IRS.FieldByName('KOD1').AsString,
                            qryFAT_IRS.FieldByName('KOD2').AsString,
                            qryFAT_IRS.FieldByName('KOD3').AsString,
                            qryFAT_IRS.FieldByName('KOD4').AsString,
                            BELGE_ID,
                            BELGE_SID) then
      begin
        Result := False;
        Exit;
      end;
      //proje end
      // kasa har

      if SIL = 0 then
        if qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsSmallint = 1 Then
          if Trim(qryFAT_IRS.FieldByName('KASA_KOD').AsString) = '' then KASA_SIL := 1 else KASA_SIL := 0
        else KASA_SIL := 1
      else KASA_SIL := 1;

      DataMod.CreateQuery(qryKASAHAR,trnFAT_IRS,True,DataMod.dbaMain);
        //qryKASAHAR := TIB_Query.Create(Self);
      for a:=1 to 2 do
      begin

      if a=2 then
      if SIL = 0 then
        if qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsSmallint = 1 Then
          if Trim(qryFAT_IRS.FieldByName('KASA_KOD').AsString) = '' then KASA_SIL := 1 else KASA_SIL := 0
        else KASA_SIL := 1
      else KASA_SIL := 1;

          if a=1 then KASA_SIL:=1 ;
      with qryKASAHAR do
      begin
        //IB_Connection := DataMod.dbaMain;
        //IB_Transaction := trnFAT_IRS;

        Active := False;
        sql.Clear;
        sql.add('SELECT * FROM KASAHAR WHERE KASAHAR_ID = 0 AND KASAHAR_SID = 0');
        Active := True;
        if KASA_SIL = 0 then // KASA HAREKETÝ YARATIRILIYOR
        begin
          insert;
          FieldByName('KASAHAR_ID').AsInteger := Gen_ID('GEN_KASAHAR',1);
          FieldByName('KASAHAR_SID').AsInteger := glb_SID;
          FieldByName('KASA_KOD').AsString := Trim(qryFAT_IRS.FieldByName('KASA_KOD').AsString);
          FieldByName('TARIH').AsDate := qryFAT_IRS.FieldByName('TARIH').AsDate;
          FieldByName('DOV_BAZ_TAR').AsDate := qryFAT_IRS.FieldByName('TARIH').AsDate;
          FieldByName('BELGE_TUR').AsInteger := prv_BELGE_TUR;
          FieldByName('BELGE_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
          FieldByName('BELGE_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
          FieldByName('TIP').AsString := KASA_GC;
          FieldByName('ACIKLAMA').AsString := qryFAT_IRS.FieldByName('ACIKLAMA').AsString;
          FieldByName('ISLEM_TIP').AsInteger := 2;
          FieldByName('PROJE_KOD').AsString := qryFAT_IRS.FieldByName('PROJE_KOD').AsString;
          FieldByName('PLASIYER_KOD').AsString := qryFAT_IRS.FieldByName('PLASIYER_KOD').AsString;
          FieldByName('MC').AsString := 'C';
          FieldByName('KARSIKOD').AsString := qryFAT_IRS.FieldByName('CARI_KOD').AsString;
          FieldByName('SIRA_NO').AsInteger := ISLEM_SIRA_NO;
          FieldByName('DOVKOD').AsString := glb_DEFCUR;
          FieldByName('DOVKUR').AsCurrency := 1;
          FieldByName('TUTAR').AsCurrency := qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency;
          FieldByName('TUTAR_VPB').AsCurrency := qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency;
          //KASADEÐER HESAPLA
          DataMod.FN_KOD2AD('KASA','KASA_KOD','DOVKOD',Trim(qryFAT_IRS.FieldByName('KASA_KOD').AsString),KASA_DOVKOD);
          if KASA_DOVKOD <> '' then
          begin
            if not DataMod.KurluDonustur(qryFAT_IRS.FieldByName('TARIH').AsDate,glb_DEFCUR,1,KASA_DOVKOD,qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency,glb_SATISKUR,True,KasaDeger) then
            begin
              Application.MessageBox('TfrmFAT_Tran.ON_MUH_ENT : Kasadeðeri içiçn kur dönüþümü yapýlamadý','Dikkat',MB_ICONERROR);
              Result := False;
              Exit;
            end;
            FieldByName('KASADEGER').AsCurrency := KasaDeger;
          end
          else
          begin
            Ent_Message := Pchar(qryFAT_IRS.FieldByName('KASA_KOD').AsString + ' Kodlu kasanýn Para Birimi bilgisine ulaþýlamýyor. Kasa Modulunden ilgili bilgiyi giriniz');
            Application.MessageBox(Ent_Message,'Dikkat', MB_ICONSTOP);
            Result := False;
          end;
          //KASADEÐER HESAPLA SON
          FieldByName('OLCUBIRIM').AsString := '';
          FieldByName('MIKTAR').AsInteger :=  0;
          Post;
        end
        else
        begin
          sql.Clear;
          sql.add('DELETE FROM KASAHAR WHERE BELGE_TUR = '+ IntToStr(prv_BELGE_TUR) + ' AND BELGE_ID = ' + IntToStr(qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger) + ' AND BELGE_SID = ' + IntToStr(qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger));
          Execute;
        end;
         Active := False;
         Result := True;
      end;    // with
      if SIL = 1 then Break;      
      end;
    except
      Result := False;
    end;
  finally
    DataMod.ReleaseQuery(qryKASAHAR);
    qry_Asl_Urun_Har.EnableControls;
  end;
end;

function TfrmFAT_Tran.URUN_HAR_SIL:Boolean;
var
  qryS_URUNHAR:TIB_Query;
//  URUN_HAR_TIP:Char;
begin
  DataMod.CreateQuery(qryS_URUNHAR,trnFAT_IRS,False,DataMod.dbaMain);
  with qryS_URUNHAR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM URUNHAR WHERE FATURA_ID = '+ qryFAT_IRS.FieldByName('FAT_IRS_ID').AsString + ' AND FATURA_SID = ' + qryFAT_IRS.FieldByName('FAT_IRS_SID').AsString);
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
//alttaki kodlar kullanýlmýyor.asagidaki bilgi kullanýlýyor.
//qryURUNHAR.FieldByName('TIP').AsString[1]
//        if prv_FAT_TIP = 1 then
//           URUN_HAR_TIP := ALACAK
//        else
//           URUN_HAR_TIP := BORC;
//****************************************************************************//
//    if (Trim(qryS_URUNHAR.FieldByName('URUN_KOD').AsString) <> '') or  (qryS_URUNHAR.FieldByName('IRSALIYE_ID').AsInteger = 0) then
    if (Trim(qryS_URUNHAR.FieldByName('URUN_KOD').AsString) <> '') and (qryS_URUNHAR.FieldByName('IRSALIYE_ID').AsInteger = 0) then
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

procedure TfrmFAT_Tran.ApplyDatasets;
begin

  qryFAT_IRS.ApplyUpdates;
  qryFAT_IRS.CommitUpdates;

  Qry_Asl_Urun_Har.ApplyUpdates;
  Qry_Asl_Urun_Har.CommitUpdates;

  qryURUNHAR.ApplyUpdates;
  qryURUNHAR.CommitUpdates;

  qryFAT_IRS_ACK.ApplyUpdates;
  qryFAT_IRS_ACK.CommitUpdates;

  qryFAT_IRS_MUH_CARI.ApplyUpdates;
  qryFAT_IRS_MUH_CARI.CommitUpdates;

end;

procedure TfrmFAT_Tran.CommitUpdates;
begin
  qryFAT_IRS_MUH_CARI.Close;
  qryFAT_IRS_ACK.Close;
  Qry_Asl_Urun_Har.Close;
  qryURUNHAR.Close;
  qryFAT_IRS.Close;
end;

procedure TfrmFAT_Tran.CancelUpdates;
begin
  qryFAT_IRS_MUH_CARI.CancelUpdates;
  qryFAT_IRS_ACK.CancelUpdates;
  Qry_Asl_Urun_Har.CancelUpdates;
  qryURUNHAR.CancelUpdates;
  qryFAT_IRS.CancelUpdates;

  qryFAT_IRS_MUH_CARI.CommitUpdates;
  qryFAT_IRS_ACK.CommitUpdates;
  Qry_Asl_Urun_Har.CommitUpdates;
  qryURUNHAR.CommitUpdates;
  qryFAT_IRS.CommitUpdates;
end;

procedure TfrmFAT_Tran.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Shift = [ssCtrl,ssShift,ssAlt] then
       if key=65 then Button2.Visible:=True;

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

Procedure TfrmFAT_Tran.FormatDisplays;
begin
//glb_DOV_FIELD_PF
  with frmFAT_Tran.qryURUNHAR do
  begin
    FieldByName('MIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('ISKONTO_TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ISKONTO_TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    case frmFAT_Tran.prv_FAT_TIP of
    1:FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    2:FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_KUR_PF;
    end;
    FieldByName('KDV_TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
  end;
  with frmFAT_Tran.qryFAT_IRS do
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

procedure TfrmFAT_Tran.KalemBrutHesapla(Sil:Boolean);
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

procedure TfrmFAT_Tran.KalemBrutHesaplaT(Sil:Boolean);
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


procedure TfrmFAT_Tran.qryURUNHARAfterPost(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(False);
  KDV_HESAPLA;
end;

procedure TfrmFAT_Tran.qryURUNHARAfterDelete(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(True);
end;

procedure TfrmFAT_Tran.IB_Edit40Exit(Sender: TObject);
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

procedure TfrmFAT_Tran.IB_Edit3Exit(Sender: TObject);
begin
      my_Active_Comp.Brush.color := clWindow;
end;

function TfrmFAT_Tran.Form_Before_Post: Boolean;
begin
  Result := False;

  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if not DataMod.KAY_TAR_KONTROL(qryFAT_IRS.FieldByName('TARIH').AsDate,True) then Exit;

  if Trim(qryFAT_IRS.FieldByName('FAT_IRS_SERI').AsString) = ''  then
  begin
    IB_Edit1.SetFocus;
    Application.MessageBox('Fatura Seri Numarasý Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;



//bu kontrol geçici olarak eklendi daha sonra
//parametrelere aktarýlacak fatura aralýklarýný kontrol ediyor
//ve þubelere ait fatura aralýklarýna bakýyor.
//þubelerin yanlýþ fatura numarasý girip kayýt yapmamalarý için
//eklendi.

  if Trim(qryFAT_IRS.FieldByName('BELGE_NO').AsString) = ''  then
  begin
    IB_Edit3.SetFocus;
    Application.MessageBox('Fatura No Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString) = ''  then
  begin
    txtCariKod.SetFocus;
    Application.MessageBox('Cari Kod Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryFAT_IRS.FieldByName('ACIKLAMA').AsString) = ''  then
  begin
    IB_Edit40.SetFocus;
    Application.MessageBox('Fatura Açýklamasý Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
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
    Application.MessageBox('Fatura Kalemi Olmadan Faturayý Kaydedemezsiniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  if qryFAT_IRS.FieldByName('FAT_IRS_TIP').AsSmallint = 1 Then
  begin
    if (Trim(qryFAT_IRS.FieldByName('KASA_KOD').AsString)='') Then
    begin
      Application.MessageBox('Kasa Kodu Alanýna Veri Girmediniz ..!','DÝKKAT',MB_ICONWARNING);
      exit;
    end;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryFAT_IRS.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryFAT_IRS.FieldByName('VADE_TARIH').AsDate, 'Vade Tarihi') then Exit;



// if qryFAT_IRS.State in [dsSINSERT] then
 if  DataMod.Seri_No_Kontrolu(qryFAT_IRS,'FAT_IRS',prv_FAT_IRS_SEP,qryFAT_IRS.FieldByName('FAT_IRS_ID').asInteger,prv_FAT_TIP,
  qryFAT_IRS.FieldByName('FAT_IRS_SERI').asString,
  qryFAT_IRS.FieldByName('BELGE_NO').asString,
  qryFAT_IRS.FieldByName('CARI_KOD').asString) then Exit;


  Result := True;
  KDV_Hesapla;
end;


function TfrmFAT_Tran.Form_Before_Delete:Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryFAT_IRS.FieldByName('TARIH').AsDate,True) then Exit;
  Result := True;
end;


procedure TfrmFAT_Tran.Form_Post;
var
  a,SIPARIS_D_FAT_ID,URUNHAR_ID:Integer;
  qryDeg1,qryDeg:TIb_Query;
  Urun_Hareket_Var:Boolean;

begin
  Urun_Hareket_Var:=False;

  if qryURUNHAR.State in [DssEdit,DssInsert] then
  qryURUNHAR.Post;

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
{
    if trnFAT_IRS.InTransaction then
//       trnFAT_IRS.Rollback;
       trnFAT_IRS.RollbackRetaining;
}
//    trnFAT_IRS.StartTransaction;

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

    for a:=0 to Silinen_Idler.Count-1 do
    begin
         if Qry_Asl_Urun_Har.Locate('URUNHAR_ID',StrToInt(Silinen_Idler.Strings[a]),[]) then
         Qry_Asl_Urun_Har.Delete;


          qry_Temp.Active:=False;
          qry_Temp.sql.Clear;
          qry_Temp.sql.Text:='Select * from Sefer Where SATIS_URUN_HAR_ID=:SATIS_URUN_HAR_ID or BEK_FAT_URUN_HAR_ID=:SATIS_URUN_HAR_ID or ALIS_URUN_HAR_ID=:SATIS_URUN_HAR_ID';
          qry_Temp.ParamByName('SATIS_URUN_HAR_ID').AsInteger:=StrToInt(Silinen_Idler.Strings[a]);
          qry_Temp.Active:=True;

          if qry_Temp.RecordCount >0 then
          begin
               {qry_Temp.Edit;
               qry_Temp.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger:=0;
               qry_Temp.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=0;
               qry_Temp.Post;
               }


               qry_Temp.Edit;
               if qry_Temp.FieldByName('SATIS_URUN_HAR_ID').AsInteger=StrToInt(Silinen_Idler.Strings[a]) then
               begin
               qry_Temp.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=0;
               qry_Temp.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger:=0;
               end;

               if qry_Temp.FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger=StrToInt(Silinen_Idler.Strings[a]) then
               begin
               qry_Temp.FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger:=0;
               qry_Temp.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger:=0;

               end;

               if qry_Temp.FieldByName('ALIS_URUN_HAR_ID').AsInteger=StrToInt(Silinen_Idler.Strings[a]) then
               begin
               qry_Temp.FieldByName('ALIS_URUN_HAR_ID').AsInteger:=0;
               qry_Temp.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger:=0;
               end;

               qry_Temp.Post;

          end;
    end;

    qryURUNHAR.First;
    While not qryURUNHAR.Eof Do
    begin

         if Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString)<>'' then
         begin
            if Qry_Asl_Urun_Har.Locate('URUNHAR_ID',qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,[]) then
            Qry_Asl_Urun_Har.Edit
            else begin
            Qry_Asl_Urun_Har.Insert;
            Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsVariant:=qryURUNHAR.FieldByName('URUNHAR_ID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('URUNHAR_SID').AsVariant:=qryURUNHAR.FieldByName('URUNHAR_SID').AsVariant;
            end;
            Qry_Asl_Urun_Har.FieldByName('TARIH').AsVariant:=qryURUNHAR.FieldByName('TARIH').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('FIILI_TAR').AsVariant:=qryURUNHAR.FieldByName('FIILI_TAR').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('DOV_BAZ_TAR').AsVariant:=qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsVariant:=qryURUNHAR.FieldByName('URUN_KOD').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('URUN_AD').AsVariant:=qryURUNHAR.FieldByName('URUN_AD').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('ACIKLAMA').AsVariant:=qryURUNHAR.FieldByName('ACIKLAMA').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('TIP').AsVariant:=qryURUNHAR.FieldByName('TIP').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('BELGE_TUR').AsVariant:=qryURUNHAR.FieldByName('BELGE_TUR').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('BELGE_ID').AsVariant:=qryURUNHAR.FieldByName('BELGE_ID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('BELGE_SID').AsVariant:=qryURUNHAR.FieldByName('BELGE_SID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('BELGE_SIRA_NO').AsVariant:=qryURUNHAR.FieldByName('BELGE_SIRA_NO').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('OLCUBIRIM').AsVariant:=qryURUNHAR.FieldByName('OLCUBIRIM').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('OLCUBIRIM_URN_OB').AsVariant:=qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('MIKTAR').AsVariant:=qryURUNHAR.FieldByName('MIKTAR').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('MIKTAR_URN_OB').AsVariant:=qryURUNHAR.FieldByName('MIKTAR_URN_OB').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('DOVKOD').AsVariant:=qryURUNHAR.FieldByName('DOVKOD').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('DOVKUR').AsVariant:=qryURUNHAR.FieldByName('DOVKUR').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('TUTAR').AsVariant:=qryURUNHAR.FieldByName('TUTAR').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('TUTAR_VPB').AsVariant:=qryURUNHAR.FieldByName('TUTAR_VPB').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('URUN_DOVKOD').AsVariant:=qryURUNHAR.FieldByName('URUN_DOVKOD').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('TUTAR_URUN_DOVKOD').AsVariant:=qryURUNHAR.FieldByName('TUTAR_URUN_DOVKOD').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('BIRIM_FIY').AsVariant:=qryURUNHAR.FieldByName('BIRIM_FIY').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('BIRIM_FIY_VPB').AsVariant:=qryURUNHAR.FieldByName('BIRIM_FIY_VPB').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('BIRIM_FIY_URN_DOVKOD').AsVariant:=qryURUNHAR.FieldByName('BIRIM_FIY_URN_DOVKOD').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('ISKONTO_TIP').AsVariant:=qryURUNHAR.FieldByName('ISKONTO_TIP').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('ISKONTO_ORAN').AsVariant:=qryURUNHAR.FieldByName('ISKONTO_ORAN').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('ISKONTO_TUTAR').AsVariant:=qryURUNHAR.FieldByName('ISKONTO_TUTAR').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('ISKONTO_TUTAR_VPB').AsVariant:=qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('DEPO_KOD').AsVariant:=qryURUNHAR.FieldByName('DEPO_KOD').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('DEPO_AD').AsVariant:=qryURUNHAR.FieldByName('DEPO_AD').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('FATURA_ID').AsVariant:=qryURUNHAR.FieldByName('FATURA_ID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('FATURA_SID').AsVariant:=qryURUNHAR.FieldByName('FATURA_SID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('IRSALIYE_ID').AsVariant:=qryURUNHAR.FieldByName('IRSALIYE_ID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('IRSALIYE_SID').AsVariant:=qryURUNHAR.FieldByName('IRSALIYE_SID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('MASRAF_MERK').AsVariant:=qryURUNHAR.FieldByName('MASRAF_MERK').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('KDV').AsVariant:=qryURUNHAR.FieldByName('KDV').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('KDV_TUTAR').AsVariant:=qryURUNHAR.FieldByName('KDV_TUTAR').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('KOD1').AsVariant:=qryURUNHAR.FieldByName('KOD1').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('KOD2').AsVariant:=qryURUNHAR.FieldByName('KOD2').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('KOD3').AsVariant:=qryURUNHAR.FieldByName('KOD3').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('KOD4').AsVariant:=qryURUNHAR.FieldByName('KOD4').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('BIRIM_FIY_URN_OB').AsVariant:=qryURUNHAR.FieldByName('BIRIM_FIY_URN_OB').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('SECIM').AsVariant:=qryURUNHAR.FieldByName('SECIM').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('CIKIS_MIKTAR').AsVariant:=qryURUNHAR.FieldByName('CIKIS_MIKTAR').AsVariant;

            Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsVariant:=qryURUNHAR.FieldByName('SEFER_ID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('MAZOT_FISI_ID').AsVariant:=qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsVariant;
            Qry_Asl_Urun_Har.FieldByName('SEFER_BEKLEME').AsVariant:=qryURUNHAR.FieldByName('SEFER_BEKLEME').AsVariant;


            Urun_Hareket_Var:=True;
            Qry_Asl_Urun_Har.Post;
         end;
         qryURUNHAR.Next;
    end;

    Qry_Asl_Urun_Har.DisableControls;
    if not Sefer_Mazot_Hareketleri_Duzenle_Yeni then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
    Qry_Asl_Urun_Har.EnableControls;


//****************************************************************************//
    if not ON_MUH_ENT(0) then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
//****************************************************************************//
    ApplyDatasets;


//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('FAT_IRS,URUNHAR,FAT_IRS_MUH_CARI,FAT_IRS_ACK,',
                                             prv_BELGE_TUR,
                                             qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger,
                                             qryFAT_IRS.FieldByName('FAT_IRS_SID').AsSmallint,
                                             1,1,'');

//****************************************************************************//


//    trnFAT_IRS.Commit;
  //if rgYAZICI.ItemIndex < 2 then
    trnFAT_IRS.CommitRetaining;
  {else
  trnFAT_IRS.Commit;
  }
  
  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(201)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,201,20,1,rgYAZICI.ItemIndex,prn_FATURA_ID,prn_FATURA_SID,1,'');
       //Dm_Fast_Report.Duzenle(0,201);
  end
  else
    if rgYAZICI.ItemIndex < 2 then Yazici.FATURA(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex,1,qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);


  //if rgYAZICI.ItemIndex < 2 then
    trnFAT_IRS.Commit;

//****************************************************************************//



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
  grpBoxMuhtelif.Visible := False;
//****************************************************************************//

end;

procedure TfrmFAT_Tran.Form_Delete;
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
  qryDeg:TIB_Query;
begin
  if not Form_Before_Delete then exit;
  if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
{    if trnFAT_IRS.InTransaction then
       trnFAT_IRS.Rollback;
    trnFAT_IRS.StartTransaction;
}
//****************************************************************************//
    if not URUN_HAR_SIL then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;
//****************************************************************************//
    if not ON_MUH_ENT(1) then
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
   { if qryFAT_IRS.FieldByName('MUHTELIF').AsSmallint = 1 Then
    begin
      if not ((qryFAT_IRS_MUH_CARI.Eof) and (qryFAT_IRS_MUH_CARI.Bof)) then
      begin
        qryFAT_IRS_MUH_CARI.Delete;
      end;
    end;
    }
//****************************************************************************//

    DataMod.CreateQuery(qryDeg,trnFAT_IRS,False,DataMod.dbaMain);

    if not ((qryURUNHAR.Eof) and (qryURUNHAR.Bof)) then
    begin
      qryURUNHAR.First;
      while not qryURUNHAR.Eof do
      begin
        qryURUNHAR.Delete;
        qryURUNHAR.First;
      end;
    end;

    if not ((Qry_Asl_Urun_Har.Eof) and (Qry_Asl_Urun_Har.Bof)) then
    begin
      Qry_Asl_Urun_Har.First;
      while not Qry_Asl_Urun_Har.Eof do
      begin
        Qry_Asl_Urun_Har.Delete;
        Qry_Asl_Urun_Har.First;
      end;
    end;

//****************************************************************************//
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


//****************************************************************************//
  except
    trnFAT_IRS.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  CommitUpdates;

  grpBoxCari.Visible := False;
  grpBoxMuhtelif.Visible := False;
end;



procedure TfrmFAT_Tran.btnCiktiClick(Sender: TObject);
begin
  if qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger<=0 then Exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;

  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(201)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,201,20,1,rgYAZICI.ItemIndex,prn_FATURA_ID,prn_FATURA_SID,1,'');
       //Dm_Fast_Report.Duzenle(0,201);
  end
  else
  if rgYAZICI.ItemIndex < 2 then Yazici.FATURA(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex,1,qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);
end;

procedure TfrmFAT_Tran.qryURUNHARBeforePost(IB_Dataset: TIB_Dataset);
var
  BIRIMFIY_URN_DOVKOD,
  TUTAR_URN_DOVKOD,
  MIKTAR_URN_OLCUBIRIM,
  BIRIMFIY_VPB:Currency;
  URUN_DOVKOD,URUN_OLCUBIRIM:String;
  qryDegX1:TIB_Query;
begin
  if Trim(IB_Dataset.FieldByName('ACIKLAMA').AsString) = ''  then
  begin
    Application.MessageBox('Açýklama Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Abort;
  end;

  if Trim(IB_Dataset.FieldByName('URUN_KOD').AsString)='' then
  begin
  IB_Dataset.FieldByName('BIRIM_FIY').AsCurrency:=0;
  IB_Dataset.FieldByName('MIKTAR').AsCurrency:=0;
  KalemHesapla;
  IB_Dataset.FieldByName('TUTAR').AsVariant:=Null;
  IB_Dataset.FieldByName('TUTAR_VPB').AsVariant:=Null;
  IB_Dataset.FieldByName('BIRIM_FIY').AsVariant:=Null;
  IB_Dataset.FieldByName('MIKTAR').AsVariant:=Null;
  IB_Dataset.FieldByName('KDV').AsVariant:=Null;
  //IB_Dataset.FieldByName('DOVKOD').AsVariant:=Null;

  
  end;



  if Trim(IB_Dataset.FieldByName('URUN_KOD').AsString)<>'' then
  begin

  end;

   if Sefer_Aktarma_b or Mazot_Aktarma_b then
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

    with IB_Dataset do
    begin
      if FieldByName('MIKTAR_URN_OB').AsCurrency=FieldByName('MIKTAR').AsCurrency then
      FieldByName('BIRIM_FIY_URN_OB').AsCurrency := FieldByName('BIRIM_FIY').AsCurrency
      else
      FieldByName('BIRIM_FIY_URN_OB').AsCurrency :=
      FieldByName('TUTAR').AsCurrency/
      FieldByName('MIKTAR_URN_OB').AsCurrency;


      if (FieldByName('DOVKUR').AsCurrency <= 0) then
      begin
        Showmessage('Döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
        FieldByName('DOVKUR').AsCurrency := 1;
        Abort;
      end;

    end;
   end;

end;

procedure TfrmFAT_Tran.FaturaKopyala1Click(Sender: TObject);
var
  ID,SID:String;
  FAT_IRS_SEP : Byte;
begin
  {if qryFAT_IRS.FieldByName('FAT_IRS_SEP').AsSmallInt = 2 then
  begin
    Application.MessageBox('Bu seçenek üzerinde Ýrsaliye üzerinden kopyalama iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if not qryFAT_IRS.Active then
  begin
    Application.MessageBox('Olmayan bir fatura üzerinden kopyalama iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryFAT_IRS.State in [dssInsert] then
  begin
    Application.MessageBox('Yeni kayýt durumunda fatura üzerinden kopyalama iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  ID := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsString;
  SID := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsString;
  FAT_IRS_SEP := qryFAT_IRS.FieldByName('FAT_IRS_SEP').AsSmallint;

  rgYAZICI.ItemIndex := 2;

  btnTRN_IPTALClick(Self);

  if not qryFAT_IRS.Active then
  begin
    if not DEKONT_AUT.FaturaKopyala(ID,SID,FAT_IRS_SEP) then
    begin
      Application.MessageBox('Fatura kopyalama iþlemi sýrasýnda hata oluþtu.','Dikkat',MB_ICONWARNING);
    end;
  end;
  }
end;

procedure TfrmFAT_Tran.qryURUNHARBeforeEdit(IB_Dataset: TIB_Dataset);
begin

     prv_Ilk_Miktar:=qryURUNHAR.FieldByName('MIKTAR').AsFloat;
     prv_Ilk_Olcu_Birimi:=qryURUNHAR.FieldByName('OLCUBIRIM').AsString;

     prv_Sefer_Kaydi:=False;
     qry_Temp.Active:=False;
     qry_Temp.sql.Clear;
     qry_Temp.sql.Text:='Select MAZOT_FIS_ID from MAZOT_FISI Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID';
     qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
     qry_Temp.Active:=True;
     if qry_Temp.FieldByName('MAZOT_FIS_ID').AsInteger>0 then
     prv_Sefer_Kaydi:=True;

     qry_Temp.Active:=False;
     qry_Temp.sql.Clear;
     qry_Temp.sql.Text:='Select SEFER_ID from SEFER Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID or SATIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID or BEK_FAT_URUN_HAR_ID=:ALIS_URUN_HAR_ID';
     qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
     qry_Temp.Active:=True;
     if qry_Temp.FieldByName('SEFER_ID').AsInteger>0 then
     prv_Sefer_Kaydi:=True;

end;

procedure TfrmFAT_Tran.Btn_Sefer_BilgisiClick(Sender: TObject);
var
  Sefer_ID,Sefer_SID:Integer;
  Gelen_Qry:TIb_Query;
  qry_Urun_Masraf:TIb_Query;
  Toplam_Tutar,Toplam_Miktar:Double;
  CARI_SIL:Byte;
  Tek_Satir,Bf_Hesapla,Bulundu:Boolean;
  Tek_Satir_Say,Tek_Satir_Ne,a,b:Integer;
  Idd,Har_Id:Integer;
begin
   if (Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString)='') then
   begin
     Application.MessageBox('Cari Kodu Olmadan Sefer Seçemezsiniz','Dikkat',MB_ICONWARNING);
     Exit;
   end;
  txtCariKod.Enabled:=False;
  DataMod.CreateQuery(Gelen_Qry,trnFAT_IRS,True,DataMod.dbaMain);
  DataMod.CreateQuery(qry_Urun_Masraf,trnFAT_IRS,True,DataMod.dbaMain);

  QryDegTrans.Active:=False;
  QryDegTrans.Sql.Clear;

  if prv_FAT_TIP=1 then //satýþ
  if frmSeferSDLG.Form_Open(False,Sefer_ID,Sefer_SID,
    qryFAT_IRS.FieldByName('CARI_KOD').AsString,
    qryFAT_IRS.FieldByName('CARI_KOD').AsString,
    Giden_Idler,Giden_Idler_Bekleme,Gelen_Qry,prv_FAT_TIP,Tek_Satir,Bf_Hesapla)then
  begin

    Sefer_Aktarma_b:=True;


    QryDegTrans.Active:=False;
    QryDegTrans.Sql.Text:=Gelen_Qry.SQL.Text;
    QryDegTrans.Active:=True;

    Gelen_Qry.DisableControls;
    Gelen_Qry.First;

    While not Gelen_Qry.Eof do
    begin
         if Gelen_Qry.FieldByName('SECIM').AsString='1' then
         begin
             QryDegTrans.Locate('SEFER_ID',Gelen_Qry.FieldByName('SEFER_ID').AsInteger,[]);
             QryDegTrans.Edit;
             QryDegTrans.FieldByName('SECIM').AsString:='1';
             QryDegTrans.post;
         end
         else
         begin
             QryDegTrans.Locate('SEFER_ID',Gelen_Qry.FieldByName('SEFER_ID').AsInteger,[]);
             QryDegTrans.Edit;
             QryDegTrans.FieldByName('SECIM').AsString:='0';
             QryDegTrans.post;
         end;

         QryDegTrans.Next;
         Gelen_Qry.Next;
    end;

    Gelen_Qry.EnableControls;
    frmSeferSDLG.qrySefer.CancelUpdates;
    frmSeferSDLG.qrySefer.CommitUpdates;

    QryDegTrans.First;

   Idd:=0;

   for a:=1 to length(arr_Tek_Satir_Tutar) do
   begin
       arr_Tek_Satir_Tutar[a].Merkez:='';
       arr_Tek_Satir_Tutar[a].TUTAR:=0;
       arr_Tek_Satir_Tutar[a].Bekleme:=False;
       arr_Tek_Satir_Tutar[a].MIKTAR:=0;
   end;
   for a:=1 to length(arr_Tek_Satir_Id) do
   begin
       arr_Tek_Satir_Id[a].Ids:=0;
       arr_Tek_Satir_Id[a].Sefer_Id:=0;
       arr_Tek_Satir_Id[a].urun_har_id:=0;
       arr_Tek_Satir_Id[a].Bekleme:=False;
   end;

//ShowMessage(Inttostr(length(arr_Tek_Satir_Tutar))+ '   '+Inttostr(length(arr_Tek_Satir_Id)));
    if Tek_Satir then
    begin
        Toplam_Tutar:=0;
        Toplam_Miktar:=0;

        Tek_Satir_Say:=1;

        arr_Tek_Satir_Tutar[1].Merkez:='ASL_BEKLEME00#11';//girilen merkezlerle uymamasý için
        arr_Tek_Satir_Tutar[1].TUTAR:=0;

        While not QryDegTrans.Eof do
        begin
             if QryDegTrans.FieldByName('SECIM').AsInteger=1 then
             begin
             if Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString)<>'' then
             begin

               if QryDegTrans.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger=0 then
               begin
                  Bulundu:=False;
                  for a:=1 to length(arr_Tek_Satir_Tutar) do
                  begin
                       if arr_Tek_Satir_Tutar[a].Merkez=Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString) then
                       begin
                         Bulundu:=True;
                         Tek_Satir_Ne:=a;
                         Break;
                       end;
                  end;

                  if not Bulundu then
                  begin
                    Inc(Tek_Satir_Say);
                    Tek_Satir_Ne:=Tek_Satir_Say;
                  end;

                  arr_Tek_Satir_Tutar[Tek_Satir_Ne].Merkez:=Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString);

                  //if QryDegTrans.FieldByName('MIKTAR').AsFloat=0 then
                  //begin
                    arr_Tek_Satir_Tutar[Tek_Satir_Ne].TUTAR:=arr_Tek_Satir_Tutar[Tek_Satir_Ne].TUTAR+QryDegTrans.FieldByName('ALICI_BORC_VPB').AsFloat;
                    arr_Tek_Satir_Tutar[Tek_Satir_Ne].MIKTAR:=arr_Tek_Satir_Tutar[Tek_Satir_Ne].MIKTAR+QryDegTrans.FieldByName('SEFER_SAY').AsFloat;
                  //end
                  //else
                  //begin
                  //  arr_Tek_Satir_Tutar[Tek_Satir_Ne].TUTAR:=arr_Tek_Satir_Tutar[Tek_Satir_Ne].TUTAR+QryDegTrans.FieldByName('ALICI_BORC_VPB').AsFloat
                  //  *QryDegTrans.FieldByName('MIKTAR').AsFloat;
                  //end;

                  Inc(Idd);
                  arr_Tek_Satir_Id[Idd].ids:=Idd;
                  arr_Tek_Satir_Id[Idd].urun_har_id:= Tek_Satir_Ne;
                  arr_Tek_Satir_Id[Idd].Sefer_id:=QryDegTrans.FieldByName('SEFER_ID').AsInteger;
                  arr_Tek_Satir_Id[Idd].Bekleme:=False;
               end;


                  if (QryDegTrans.FieldByName('BEKLEME_FAT_VAR').AsInteger=1)
                  and (QryDegTrans.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=0)
                   then
                  begin

                     if DataMod.Urun_Kod_Merkez_Karsilastir( glb_BEK_HIZ_URN_KOD, Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString)) then
                     begin

                       Bulundu:=False;
                       for a:=1 to length(arr_Tek_Satir_Tutar) do
                       begin
                            if arr_Tek_Satir_Tutar[a].Merkez=Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString) then
                            begin
                              Bulundu:=True;
                              Tek_Satir_Ne:=a;
                              Break;
                            end;
                       end;

                       if not Bulundu then
                       begin
                         Inc(Tek_Satir_Say);
                         Tek_Satir_Ne:=Tek_Satir_Say;
                       end;

                       //Inc(Tek_Satir_Say);
                       //Tek_Satir_Ne:=Tek_Satir_Say;
                       arr_Tek_Satir_Tutar[Tek_Satir_Ne].Merkez:=Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString);
                       arr_Tek_Satir_Tutar[Tek_Satir_Ne].TUTAR:=arr_Tek_Satir_Tutar[Tek_Satir_Ne].TUTAR+QryDegTrans.FieldByName('BEKLEME_FAT_VPB').AsFloat;
                       arr_Tek_Satir_Tutar[Tek_Satir_Ne].Bekleme:=True;

                       arr_Tek_Satir_Tutar[Tek_Satir_Ne].MIKTAR:=arr_Tek_Satir_Tutar[Tek_Satir_Ne].MIKTAR+QryDegTrans.FieldByName('SEFER_SAY').AsFloat;


                       Inc(Idd);
                       arr_Tek_Satir_Id[Idd].ids:=Idd;
                       arr_Tek_Satir_Id[Idd].urun_har_id:= Tek_Satir_Ne;
                       arr_Tek_Satir_Id[Idd].Sefer_id:=QryDegTrans.FieldByName('SEFER_ID').AsInteger;
                       arr_Tek_Satir_Id[Idd].Bekleme:=True;

                     end
                     else
                     begin
                       arr_Tek_Satir_Tutar[1].TUTAR:=arr_Tek_Satir_Tutar[1].TUTAR+QryDegTrans.FieldByName('BEKLEME_FAT_VPB').AsFloat;
                       arr_Tek_Satir_Tutar[1].MIKTAR:=arr_Tek_Satir_Tutar[1].MIKTAR+QryDegTrans.FieldByName('SEFER_SAY').AsFloat;

                       Inc(Idd);
                       arr_Tek_Satir_Id[Idd].ids:=Idd;
                       arr_Tek_Satir_Id[Idd].urun_har_id:= 1;
                       arr_Tek_Satir_Id[Idd].Sefer_id:=QryDegTrans.FieldByName('SEFER_ID').AsInteger;
                       arr_Tek_Satir_Id[Idd].Bekleme:=True;

                     end;
                  end;


             end
             else
             begin
                  //if QryDegTrans.FieldByName('MIKTAR').AsFloat=0 then
                  //begin
               if QryDegTrans.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger=0 then
               begin

                    Toplam_Tutar:=Toplam_Tutar+QryDegTrans.FieldByName('ALICI_BORC_VPB').AsFloat;

                    Toplam_Miktar:=Toplam_Miktar+QryDegTrans.FieldByName('SEFER_SAY').AsFloat;
                  //end
                  //else
                  //begin
                  //  Toplam_Tutar:=Toplam_Tutar+QryDegTrans.FieldByName('ALICI_BORC_VPB').AsFloat
                  //  *QryDegTrans.FieldByName('MIKTAR').AsFloat;
                  //end;
                  Inc(Idd);
                  arr_Tek_Satir_Id[Idd].ids:=Idd;
                  arr_Tek_Satir_Id[Idd].urun_har_id:= 0;
                  arr_Tek_Satir_Id[Idd].Sefer_id:=QryDegTrans.FieldByName('SEFER_ID').AsInteger;
                  arr_Tek_Satir_Id[Idd].Bekleme:=False;

               end;

                  if (QryDegTrans.FieldByName('BEKLEME_FAT_VAR').AsInteger=1) and
                  (QryDegTrans.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=0) then
                  begin
                    arr_Tek_Satir_Tutar[1].TUTAR:=arr_Tek_Satir_Tutar[1].TUTAR+QryDegTrans.FieldByName('BEKLEME_FAT_VPB').AsFloat;
                    arr_Tek_Satir_Tutar[1].MIKTAR:=arr_Tek_Satir_Tutar[1].MIKTAR+QryDegTrans.FieldByName('SEFER_SAY').AsFloat;

                    Inc(Idd);
                    arr_Tek_Satir_Id[Idd].ids:=Idd;
                    arr_Tek_Satir_Id[Idd].urun_har_id:= 1;
                    arr_Tek_Satir_Id[Idd].Sefer_id:=QryDegTrans.FieldByName('SEFER_ID').AsInteger;
                    arr_Tek_Satir_Id[Idd].Bekleme:=True;
                  end;
             end;
             end;
             QryDegTrans.Next;
        end;



        if not ((arr_Tek_Satir_Tutar[2].Tutar>0) or (arr_Tek_Satir_Tutar[1].Tutar>0)) then
        begin
          //qryURUNHAR.Insert;
          qryURUNHAR.Append;
          Har_Id:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
          qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
          txtUrunKoduExit(Self);

          if Bf_Hesapla then
          begin
          qryURUNHAR.FieldByName('MIKTAR').AsFloat:=Toplam_Miktar;
          qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=Toplam_Tutar/Toplam_Miktar;
          end
          else
          begin
          qryURUNHAR.FieldByName('MIKTAR').AsFloat:=1;
          qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=Toplam_Tutar;
          end;

          qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDateTime:=Date;
          qryURUNHAR.FieldByName('DOVKOD').AsString:=glb_DEFCUR;
          qryURUNHAR.FieldByName('DOVKUR').AsFloat:=1;
          qryURUNHAR.FieldByName('TUTAR').AsFloat:=Toplam_Tutar;
          qryURUNHAR.FieldByName('TUTAR_VPB').AsFloat:=Toplam_Tutar;
          qryURUNHAR.FieldByName('TARIH').AsDate := Date;
          qryURUNHAR.FieldByName('OLCUBIRIM').AsString:='ADET';
          qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsString:='ADET';
          qryURUNHAR.FieldByName('CINSI').AsString:='';
          qryURUNHAR.FieldByName('SECIM').AsString:='X';
          qryURUNHAR.FieldByName('ACIKLAMA').AsString:=
          QryDegTrans.FieldByName('CIK_YER').AsString+ ' '+QryDegTrans.FieldByName('BIT_YER').AsString;
          //qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
          qryURUNHAR.FieldByName('SEFER_ID').AsInteger:=1999999;
          qryURUNHAR.Post;
          //tum kodlar dizilere aktarýlýr

          for b:=1 to Length(arr_Tek_Satir_Id) do
          begin
               if arr_Tek_Satir_Id[b].urun_har_id=0 then
               if QryDegTrans.Locate('SEFER_ID',arr_Tek_Satir_Id[b].Sefer_id,[]) then
               if QryDegTrans.FieldByName('SECIM').AsInteger=1 then
               begin
                  //Sefer_Mazot_Id_Duzenle('SEFER','EKLE',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,arr_Tek_Satir_Id[b].Sefer_id);
                  Sefer_Mazot_Id_Duzenle('SEFER','EKLE',False,Har_Id,arr_Tek_Satir_Id[b].Sefer_id);

                  if Giden_Idler.indexof(InttoStr(arr_Tek_Satir_Id[b].Sefer_id))=-1 then
                  Giden_Idler.Add(InttoStr(arr_Tek_Satir_Id[b].Sefer_id));

                  QryDegTrans.Edit;
                  //QryDegTrans.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                  QryDegTrans.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=Har_Id;
                  QryDegTrans.Post;

               end;
               //QryDegTrans.Next;

               if arr_Tek_Satir_Id[b].ids=0 then Break;
          end;


          Sefer_Aktarma:=True;
        end
        else
        //if (arr_Tek_Satir_Tutar[2].Tutar>0) or (arr_Tek_Satir_Tutar[1].Tutar>0) then
        begin




            bulundu:=False;
            for b:=1 to Length(arr_Tek_Satir_Id) do
            begin
                 if arr_Tek_Satir_Id[b].urun_har_id=0 then
                 if arr_Tek_Satir_Id[b].Sefer_id>0 then
                 begin
                   bulundu:=True;
                   Break;
                 end;
            end;
            //tutar ve merkezsizde var
            if Bulundu then
            begin
               //qryURUNHAR.Insert;
               qryURUNHAR.Append;
               Har_Id:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
               qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
               txtUrunKoduExit(Self);

               if Bf_Hesapla then
               begin
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=Toplam_Miktar;
                 qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=Toplam_Tutar/Toplam_Miktar;
               end
               else
               begin
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=1;
                 qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=Toplam_Tutar;
               end;

               qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDateTime:=Date;
               qryURUNHAR.FieldByName('DOVKOD').AsString:=glb_DEFCUR;
               qryURUNHAR.FieldByName('DOVKUR').AsFloat:=1;
               qryURUNHAR.FieldByName('TUTAR').AsFloat:=Toplam_Tutar;
               qryURUNHAR.FieldByName('TUTAR_VPB').AsFloat:=Toplam_Tutar;
               qryURUNHAR.FieldByName('TARIH').AsDate := Date;
               qryURUNHAR.FieldByName('OLCUBIRIM').AsString:='ADET';
               qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsString:='ADET';
               qryURUNHAR.FieldByName('CINSI').AsString:='';
               qryURUNHAR.FieldByName('SECIM').AsString:='X';
               qryURUNHAR.FieldByName('ACIKLAMA').AsString:=
               QryDegTrans.FieldByName('CIK_YER').AsString+ ' '+QryDegTrans.FieldByName('BIT_YER').AsString;
               qryURUNHAR.FieldByName('SEFER_ID').AsInteger:=1999999;
               qryURUNHAR.Post;
               //tum kodlar dizilere aktarýlýr

               for b:=1 to Length(arr_Tek_Satir_Id) do
               begin
                    if arr_Tek_Satir_Id[b].urun_har_id=0 then
                    if QryDegTrans.Locate('SEFER_ID',arr_Tek_Satir_Id[b].Sefer_id,[]) then
                    if QryDegTrans.FieldByName('SECIM').AsInteger=1 then
                    begin
                       Sefer_Mazot_Id_Duzenle('SEFER','EKLE',False,Har_Id,arr_Tek_Satir_Id[b].Sefer_id);
                       //Sefer_Mazot_Id_Duzenle('SEFER','EKLE',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,arr_Tek_Satir_Id[b].Sefer_id);

                       if Giden_Idler.indexof(InttoStr(arr_Tek_Satir_Id[b].Sefer_id))=-1 then
                       Giden_Idler.Add(InttoStr(arr_Tek_Satir_Id[b].Sefer_id));

                       QryDegTrans.Edit;
                       //QryDegTrans.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                       QryDegTrans.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=Har_Id;
                       QryDegTrans.Post;

                    end;
                    //QryDegTrans.Next;

                    if arr_Tek_Satir_Id[b].ids=0 then Break;
               end;
               Sefer_Aktarma:=True;
            end;
            //for a:=1 to length(arr_Tek_Satir_Tutar) do
            for a:=length(arr_Tek_Satir_Tutar) downto 1 do
            begin
               if arr_Tek_Satir_Tutar[a].Tutar>0 then
               begin
                  //qryURUNHAR.Insert;
                  qryURUNHAR.Append;
                  Har_Id:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;

                  if (a>1) and (arr_Tek_Satir_Tutar[a].Bekleme=False) then
                  begin
                       qry_Urun_Masraf.Close;
                       qry_Urun_Masraf.sql.Text:='SELECT ID, URUN_KOD, MASRAF_MERKEZI, YENI_URUN_KOD FROM NETSIS_AKTARMA '
                       + 'WHERE URUN_KOD='+Sql_Katar(glb_NAK_HIZ_URN_KOD) + ' AND MASRAF_MERKEZI='+Sql_Katar(arr_Tek_Satir_Tutar[a].Merkez);
                       qry_Urun_Masraf.Active:=True;
                       if qry_Urun_Masraf.RecordCount>0 then
                       begin
                         qryURUNHAR.FieldByName('URUN_KOD').AsString:=qry_Urun_Masraf.FieldByName('YENI_URUN_KOD').asString;
                         txtUrunKoduExit(Self);
                       end
                       else
                       begin
                         Application.MessageBox('Ürün kodu Masraf Karþýlaþtýrmasýnda masraf merkezi bulunamadý','Dikkat',MB_ICONWARNING);
                       end;

                  end;

                  if (a>1) and (arr_Tek_Satir_Tutar[a].Bekleme=True) then
                  begin
                       //hizmetten merkez yok ise beklemeye bak
                       qry_Urun_Masraf.Close;
                       qry_Urun_Masraf.sql.Text:='SELECT ID, URUN_KOD, MASRAF_MERKEZI, YENI_URUN_KOD FROM NETSIS_AKTARMA '
                       + 'WHERE URUN_KOD='+Sql_Katar(glb_BEK_HIZ_URN_KOD) + ' AND MASRAF_MERKEZI='+Sql_Katar(arr_Tek_Satir_Tutar[a].Merkez);
                       qry_Urun_Masraf.Active:=True;
                       if qry_Urun_Masraf.RecordCount>0 then
                       begin
                         qryURUNHAR.FieldByName('URUN_KOD').AsString:=qry_Urun_Masraf.FieldByName('YENI_URUN_KOD').asString;
                         txtUrunKoduExit(Self);
                       end
                       else
                       begin
                         Application.MessageBox('Ürün kodu Masraf Karþýlaþtýrmasýnda masraf merkezi bulunamadý','Dikkat',MB_ICONWARNING);
                       end;
                  end;

                  if a=1 then
                  begin
                  qryURUNHAR.FieldByName('URUN_KOD').AsString:= glb_BEK_HIZ_URN_KOD;
                  txtUrunKoduExit(Self);
                  end;

                  if Bf_Hesapla then
                  begin
                  qryURUNHAR.FieldByName('MIKTAR').AsFloat:=arr_Tek_Satir_Tutar[a].Miktar;
                  qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=arr_Tek_Satir_Tutar[a].Tutar/arr_Tek_Satir_Tutar[a].Miktar;
                  end
                  else
                  begin
                  qryURUNHAR.FieldByName('MIKTAR').AsFloat:=1;
                  qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=arr_Tek_Satir_Tutar[a].Tutar;
                  end;

                  qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDateTime:=Date;
                  qryURUNHAR.FieldByName('DOVKOD').AsString:=glb_DEFCUR;
                  qryURUNHAR.FieldByName('DOVKUR').AsFloat:=1;
                  qryURUNHAR.FieldByName('TUTAR').AsFloat:=arr_Tek_Satir_Tutar[a].Tutar;
                  qryURUNHAR.FieldByName('TUTAR_VPB').AsFloat:=arr_Tek_Satir_Tutar[a].Tutar;
                  qryURUNHAR.FieldByName('TARIH').AsDate := Date;
                  qryURUNHAR.FieldByName('OLCUBIRIM').AsString:='ADET';
                  qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsString:='ADET';
                  qryURUNHAR.FieldByName('CINSI').AsString:='';
                  qryURUNHAR.FieldByName('SECIM').AsString:='X';
                  qryURUNHAR.FieldByName('ACIKLAMA').AsString:=
                  QryDegTrans.FieldByName('CIK_YER').AsString+ ' '+
                  QryDegTrans.FieldByName('BIT_YER').AsString;
                  qryURUNHAR.FieldByName('SEFER_ID').AsInteger:=1999999;

                  if a=1 then  qryURUNHAR.FieldByName('SEFER_BEKLEME').AsInteger:=1
                  else qryURUNHAR.FieldByName('SEFER_BEKLEME').AsInteger:=0;

                  qryURUNHAR.Post;

                  for b:=1 to Length(arr_Tek_Satir_Id) do
                  begin
                       if arr_Tek_Satir_Id[b].urun_har_id=a then
                       if QryDegTrans.Locate('SEFER_ID',arr_Tek_Satir_Id[b].Sefer_id,[]) then
                       if QryDegTrans.FieldByName('SECIM').AsInteger=1 then
                       begin

                          //Sefer_Mazot_Id_Duzenle('SEFER','EKLE',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,arr_Tek_Satir_Id[b].Sefer_id);
                          Sefer_Mazot_Id_Duzenle('SEFER','EKLE',False,Har_Id,arr_Tek_Satir_Id[b].Sefer_id);

                          if Giden_Idler.indexof(InttoStr(arr_Tek_Satir_Id[b].Sefer_id))=-1 then
                          Giden_Idler.Add(InttoStr(arr_Tek_Satir_Id[b].Sefer_id));

                          QryDegTrans.Edit;

                          if not arr_Tek_Satir_Id[b].Bekleme then
                          QryDegTrans.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=Har_Id;
                          //QryDegTrans.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;

                          if QryDegTrans.FieldByName('BEKLEME_FAT_VAR').AsInteger=1 then
                          if arr_Tek_Satir_Id[b].Bekleme then
                          //QryDegTrans.FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                          QryDegTrans.FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger:=Har_Id;
                          QryDegTrans.Post;

                       end;

                       if arr_Tek_Satir_Id[b].ids=0 then Break;
                  end;


                  Sefer_Aktarma:=True;
               end;
            end;
            //üste alýn belme sonra gelme için

        end;
        //else  //merkez yok sa ana kodlardan
    end;

    if not Tek_Satir then
    While not QryDegTrans.Eof do
    begin

         if QryDegTrans.FieldByName('SECIM').AsInteger=1 then
         begin
              if (Giden_Idler.indexOf(Inttostr(QryDegTrans.FieldByName('SEFER_ID').AsInteger))=-1)
              and
              (QryDegTrans.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger =0)
              then
              begin
                 qryURUNHAR.Insert;


                 if Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString)<> '' then
                 begin
                    qry_Urun_Masraf.Close;
                    qry_Urun_Masraf.sql.Text:='SELECT ID, URUN_KOD, MASRAF_MERKEZI, YENI_URUN_KOD FROM NETSIS_AKTARMA '
                    + 'WHERE URUN_KOD='+Sql_Katar(glb_NAK_HIZ_URN_KOD) + ' AND MASRAF_MERKEZI='+Sql_Katar(QryDegTrans.FieldByName('MASRAF_MERK').AsString);
                    qry_Urun_Masraf.Active:=True;
                    if qry_Urun_Masraf.RecordCount>0 then
                    begin
                      qryURUNHAR.FieldByName('URUN_KOD').AsString:=qry_Urun_Masraf.FieldByName('YENI_URUN_KOD').asString;
                      txtUrunKoduExit(Self);
                    end
                    else
                    begin
                      qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
                      txtUrunKoduExit(Self);
                         //qryURUNHAR.Cancel;
                         //Abort;
                    end;
                 end
                 else
                 begin
                      qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
                      txtUrunKoduExit(Self);
                 end;

                 if QryDegTrans.FieldByName('MIKTAR').AsFloat<>0 then
                 if QryDegTrans.FieldByName('FATURA_MIK_SEF').AsInteger=2 then
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=QryDegTrans.FieldByName('SEFER_SAY').AsFloat
                 *QryDegTrans.FieldByName('MIKTAR').AsFloat;

                 if QryDegTrans.FieldByName('FATURA_MIK_SEF').AsInteger=1 then
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=QryDegTrans.FieldByName('SEFER_SAY').AsFloat;


                 if QryDegTrans.FieldByName('FATURA_MIK_SEF').AsInteger=3 then
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=QryDegTrans.FieldByName('MIKTAR').AsFloat;

                 qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=QryDegTrans.FieldByName('ALICI_BORC_BIRIM_FIY').AsFloat;
                 qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDateTime:=QryDegTrans.FieldByName('ALICI_B_DOV_BAZ_TAR').AsDateTime;
                 qryURUNHAR.FieldByName('DOVKOD').AsString:=QryDegTrans.FieldByName('ALICI_B_DOVKOD').AsString;
                 qryURUNHAR.FieldByName('DOVKUR').AsFloat:=QryDegTrans.FieldByName('ALICI_B_DOVKUR').AsFloat;
                 //if QryDegTrans.FieldByName('MIKTAR').AsFloat=0 then
                 //begin
                   qryURUNHAR.FieldByName('TUTAR').AsFloat:=QryDegTrans.FieldByName('ALICI_BORC').AsFloat;
                   qryURUNHAR.FieldByName('TUTAR_VPB').AsFloat:=QryDegTrans.FieldByName('ALICI_BORC_VPB').AsFloat;
                 //end
                 //else
                 //begin
                 //  qryURUNHAR.FieldByName('TUTAR').AsFloat:=QryDegTrans.FieldByName('ALICI_BORC').AsFloat
                 //  *QryDegTrans.FieldByName('MIKTAR').AsFloat;
                 //  qryURUNHAR.FieldByName('TUTAR_VPB').AsFloat:=QryDegTrans.FieldByName('ALICI_BORC_VPB').AsFloat
                 //  *QryDegTrans.FieldByName('MIKTAR').AsFloat;
                 //end;

                 qryURUNHAR.FieldByName('TARIH').AsDate := QryDegTrans.FieldByName('BIT_TAR').AsDate;
                 qryURUNHAR.FieldByName('OLCUBIRIM').AsString:=QryDegTrans.FieldByName('OLCU_BIRIM').AsString;
                 qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsString:=QryDegTrans.FieldByName('OLCU_BIRIM').AsString;
                 qryURUNHAR.FieldByName('CINSI').AsString:=QryDegTrans.FieldByName('TASINAN_ESYA').AsString;

                 qryURUNHAR.FieldByName('SECIM').AsString:='X';
                 qryURUNHAR.FieldByName('ACIKLAMA').AsString:=
                 QryDegTrans.FieldByName('CIK_YER').AsString+ ' '+
                 QryDegTrans.FieldByName('BIT_YER').AsString;
                 //qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
                 qryURUNHAR.FieldByName('SEFER_ID').AsInteger:=QryDegTrans.FieldByName('SEFER_ID').AsInteger;
                 qryURUNHAR.Post;

                 Sefer_Mazot_Id_Duzenle('SEFER','EKLE',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qryURUNHAR.FieldByName('SEFER_ID').AsInteger);

                 if Giden_Idler.indexof(InttoStr(QryDegTrans.FieldByName('SEFER_ID').AsInteger))=-1 then
                 Giden_Idler.Add(InttoStr(QryDegTrans.FieldByName('SEFER_ID').AsInteger));

                 QryDegTrans.Edit;
                 QryDegTrans.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                 QryDegTrans.Post;




                 Sefer_Aktarma:=True;

              end;

              if QryDegTrans.FieldByName('BEKLEME_FAT_VAR').AsInteger=1 then
              begin
                   if (Giden_Idler_Bekleme.indexOf(Inttostr(QryDegTrans.FieldByName('SEFER_ID').AsInteger))=-1)
                   and
                  (QryDegTrans.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger =0)

                  then
                   begin
                     qryURUNHAR.Insert;

                     if Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString)<> '' then
                     begin
                        qry_Urun_Masraf.Close;
                        qry_Urun_Masraf.sql.Text:='SELECT ID, URUN_KOD, MASRAF_MERKEZI, YENI_URUN_KOD FROM NETSIS_AKTARMA '
                        + 'WHERE URUN_KOD='+Sql_Katar(glb_BEK_HIZ_URN_KOD) + ' AND MASRAF_MERKEZI='+Sql_Katar(QryDegTrans.FieldByName('MASRAF_MERK').AsString);
                        qry_Urun_Masraf.Active:=True;
                        if qry_Urun_Masraf.RecordCount>0 then
                        begin
                          qryURUNHAR.FieldByName('URUN_KOD').AsString:=qry_Urun_Masraf.FieldByName('YENI_URUN_KOD').asString;
                          txtUrunKoduExit(Self);
                        end
                        else
                        begin
                         qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_BEK_HIZ_URN_KOD;
                         txtUrunKoduExit(Self);
                         //qryURUNHAR.Cancel;
                         //Abort;
                        end;
                     end
                     else
                     begin
                          qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_BEK_HIZ_URN_KOD;
                          txtUrunKoduExit(Self);
                     end;


                     //qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_BEK_HIZ_URN_KOD;
                     //txtUrunKoduExit(Self);
                     qryURUNHAR.FieldByName('MIKTAR').AsFloat:=1;
                     qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=QryDegTrans.FieldByName('BEKLEME_FAT_TUTAR').AsFloat;
                     qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDateTime:=QryDegTrans.FieldByName('BEKLEME_FAT_DOV_BAZ_TAR').AsDateTime;
                     qryURUNHAR.FieldByName('DOVKOD').AsString:=QryDegTrans.FieldByName('BEKLEME_FAT_DOV_KOD').AsString;
                     qryURUNHAR.FieldByName('DOVKUR').AsFloat:=QryDegTrans.FieldByName('BEKLEME_FAT_DOVKUR').AsFloat;
                     qryURUNHAR.FieldByName('TUTAR').AsFloat:=QryDegTrans.FieldByName('BEKLEME_FAT_TUTAR').AsFloat;
                     qryURUNHAR.FieldByName('TUTAR_VPB').AsFloat:=QryDegTrans.FieldByName('BEKLEME_FAT_VPB').AsFloat;
                     qryURUNHAR.FieldByName('TARIH').AsDate := QryDegTrans.FieldByName('BIT_TAR').AsDate;
                     qryURUNHAR.FieldByName('SECIM').AsString:='X';
                     qryURUNHAR.FieldByName('ACIKLAMA').AsString:=
                     QryDegTrans.FieldByName('CIK_YER').AsString+ ' '+
                     QryDegTrans.FieldByName('BIT_YER').AsString;
                     qryURUNHAR.FieldByName('OLCUBIRIM').AsString:=QryDegTrans.FieldByName('OLCU_BIRIM').AsString;
                     qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsString:=QryDegTrans.FieldByName('OLCU_BIRIM').AsString;
                     //qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_BEK_HIZ_URN_KOD;
                     qryURUNHAR.FieldByName('SEFER_ID').AsInteger:=QryDegTrans.FieldByName('SEFER_ID').AsInteger;
                     qryURUNHAR.FieldByName('SEFER_BEKLEME').AsInteger:=1;

                     qryURUNHAR.Post;
                     Sefer_Mazot_Id_Duzenle('SEFER','EKLE',True,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qryURUNHAR.FieldByName('SEFER_ID').AsInteger);

                     if Giden_Idler_Bekleme.indexof(InttoStr(QryDegTrans.FieldByName('SEFER_ID').AsInteger))=-1 then
                     Giden_Idler_Bekleme.Add(InttoStr(QryDegTrans.FieldByName('SEFER_ID').AsInteger));

                     QryDegTrans.Edit;
                     QryDegTrans.FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                     QryDegTrans.Post;


                   end;
                   Sefer_Aktarma:=True;
              end;


         end;

         QryDegTrans.Next;
    end;
    Sefer_Aktarma_b:=False;
    frmSeferSDLG.Free;
  end;






  if prv_FAT_TIP=2 then //alýþ
  if frmSeferSDLG.Form_Open(False,Sefer_ID,Sefer_SID,
    qryFAT_IRS.FieldByName('CARI_KOD').AsString,
    qryFAT_IRS.FieldByName('CARI_KOD').AsString,
    Giden_Idler,Giden_Idler_Bekleme,Gelen_Qry,prv_FAT_TIP,Tek_Satir,Bf_Hesapla)then
  begin
    Sefer_Aktarma_b:=True;

    QryDegTrans.Active:=False;
    QryDegTrans.Sql.Text:=Gelen_Qry.SQL.Text;
    QryDegTrans.Active:=True;
    Gelen_Qry.DisableControls;
    Gelen_Qry.First;

    While not Gelen_Qry.Eof do
    begin
         if Gelen_Qry.FieldByName('SECIM').AsString='1' then
         begin
             QryDegTrans.Edit;
             QryDegTrans.FieldByName('SECIM').AsString:='1';
             QryDegTrans.post;
         end
         else
         begin
             QryDegTrans.Edit;
             QryDegTrans.FieldByName('SECIM').AsString:='0';
             QryDegTrans.post;
         end;

         QryDegTrans.Next;
         Gelen_Qry.Next;


    end;
    Gelen_Qry.EnableControls;
    frmSeferSDLG.qrySefer.CancelUpdates;
    frmSeferSDLG.qrySefer.CommitUpdates;

    QryDegTrans.First;
    if not Tek_Satir then
    While not QryDegTrans.Eof do
    begin
         if QryDegTrans.FieldByName('SECIM').AsInteger=1 then
         begin
              if (Giden_Idler.indexOf(Inttostr(QryDegTrans.FieldByName('SEFER_ID').AsInteger))=-1)
              and (QryDegTrans.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger =0) then
              begin
                qryURUNHAR.Insert;

                if Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString)<> '' then
                begin
                   qry_Urun_Masraf.Close;
                   qry_Urun_Masraf.sql.Text:='SELECT ID, URUN_KOD, MASRAF_MERKEZI, YENI_URUN_KOD  FROM NETSIS_AKTARMA '
                   + 'WHERE URUN_KOD='+Sql_Katar(glb_NAK_HIZ_URN_KOD) + ' AND MASRAF_MERKEZI='+Sql_Katar(QryDegTrans.FieldByName('MASRAF_MERK').AsString);
                   qry_Urun_Masraf.Active:=True;
                   if qry_Urun_Masraf.RecordCount>0 then
                   begin
                     qryURUNHAR.FieldByName('URUN_KOD').AsString:=qry_Urun_Masraf.FieldByName('YENI_URUN_KOD').asString;
                     txtUrunKoduExit(Self);
                   end
                   else
                   begin
                     qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
                     txtUrunKoduExit(Self);
                    //    qryURUNHAR.Cancel;
                    //    Abort;
                   end;
                end
                else
                begin
                     qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
                     txtUrunKoduExit(Self);
                end;


                //qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_NAK_HIZ_URN_KOD;
                //txtUrunKoduExit(Self);
                //qryURUNHAR.FieldByName('MIKTAR').AsFloat:=QryDegTrans.FieldByName('SEFER_SAY').AsFloat;

                 if QryDegTrans.FieldByName('MIKTAR').AsFloat<>0 then
                 if QryDegTrans.FieldByName('FATURA_MIK_SEF').AsInteger=2 then
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=QryDegTrans.FieldByName('SEFER_SAY').AsFloat
                 *QryDegTrans.FieldByName('MIKTAR').AsFloat;

                 if QryDegTrans.FieldByName('FATURA_MIK_SEF').AsInteger=1 then
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=QryDegTrans.FieldByName('SEFER_SAY').AsFloat;

                 if QryDegTrans.FieldByName('FATURA_MIK_SEF').AsInteger=3 then
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=QryDegTrans.FieldByName('MIKTAR').AsFloat;


                qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=QryDegTrans.FieldByName('SATICI_ALACAK_BIRIM_FIY').AsFloat;
                qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDateTime:=QryDegTrans.FieldByName('SATICI_A_DOV_BAZ_TAR').AsDateTime;
                qryURUNHAR.FieldByName('DOVKOD').AsString:=QryDegTrans.FieldByName('SATICI_A_DOVKOD').AsString;
                qryURUNHAR.FieldByName('DOVKUR').AsFloat:=QryDegTrans.FieldByName('SATICI_A_DOVKUR').AsFloat;
                qryURUNHAR.FieldByName('TUTAR').AsFloat:=QryDegTrans.FieldByName('SATICI_ALACAK').AsFloat;
                qryURUNHAR.FieldByName('TUTAR_VPB').AsFloat:=QryDegTrans.FieldByName('SATICI_ALACAK_VPB').AsFloat;
                qryURUNHAR.FieldByName('TARIH').AsDate := QryDegTrans.FieldByName('BIT_TAR').AsDate;
                qryURUNHAR.FieldByName('SECIM').AsString:='X';
                qryURUNHAR.FieldByName('ACIKLAMA').AsString:=
                QryDegTrans.FieldByName('CIK_YER').AsString+ ' '+
                QryDegTrans.FieldByName('BIT_YER').AsString;
                qryURUNHAR.FieldByName('OLCUBIRIM').AsString:=QryDegTrans.FieldByName('OLCU_BIRIM').AsString;
                qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsString:=QryDegTrans.FieldByName('OLCU_BIRIM').AsString;
                qryURUNHAR.FieldByName('SEFER_ID').AsInteger:=QryDegTrans.FieldByName('SEFER_ID').AsInteger;

                qryURUNHAR.Post;

                Sefer_Mazot_Id_Duzenle('SEFER','EKLE',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qryURUNHAR.FieldByName('SEFER_ID').AsInteger);

                if Giden_Idler.indexof(InttoStr(QryDegTrans.FieldByName('SEFER_ID').AsInteger))=-1 then
                Giden_Idler.Add(InttoStr(QryDegTrans.FieldByName('SEFER_ID').AsInteger));

                 QryDegTrans.Edit;
                 QryDegTrans.FieldByName('ALIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                 QryDegTrans.Post;

              end;
         end;
         QryDegTrans.Next;
    end;
  Sefer_Aktarma_b:=False;
  frmSeferSDLG.Free;
  end;

//  QryDegTrans.app
  QryDegTrans.Active:=False;
//  QryDegTrans.CancelUpdates;

  qryURUNHAR.UpdateData;

end;

function TfrmFAT_Tran.Sefer_Hareketleri_Olusturma(Gelen_Id:Integer;Urun_Kod:String):Boolean;
var
  CARI_SIL:Byte;
begin
  Result:=False;

  if prv_FAT_TIP=1 then //Satýþ
  begin

     qry_Temp.Active:=False;
     qry_Temp.sql.Clear;
     qry_Temp.sql.Text:='Select * from Sefer Where SATIS_URUN_HAR_ID=:SATIS_URUN_HAR_ID or BEK_FAT_URUN_HAR_ID=:SATIS_URUN_HAR_ID';
     qry_Temp.ParamByName('SATIS_URUN_HAR_ID').AsInteger:=Gelen_Id;
     qry_Temp.Active:=True;


     if qry_Temp.FieldByName('SEFER_ID').AsInteger>0 then
     begin

          //if Urun_Kod=glb_NAK_HIZ_URN_KOD then
          qry_Temp.First;
          While not qry_Temp.Eof Do //birden fazla birleþtirmeli kayýt için
          begin
               if DataMod.Urun_Kod_Karsilastir(Urun_Kod,glb_NAK_HIZ_URN_KOD) then
               begin

                     if not DataMod.ALICI_CARI_HAR(0,BORC,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
                     begin
                       frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
                       Result := False;
                       Exit;
                     end;


                     qry_Temp.Edit;
                     qry_Temp.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger:=0;
                     qry_Temp.FieldByName('SATIS_URUN_HAR_ID').AsInteger:=0;
                     qry_Temp.Post;

               end;
               qry_Temp.Next;
          end;

          //if Urun_Kod=glb_BEK_HIZ_URN_KOD then


          qry_Temp.First;
          While not qry_Temp.Eof Do //birden fazla birleþtirmeli kayýt için
          begin

               if DataMod.Urun_Kod_Karsilastir(Urun_Kod,glb_BEK_HIZ_URN_KOD) then
               begin

                    if qry_Temp.FieldbyName('BEKLEME_FAT_VAR').AsInteger=1 then
                    CARI_SIL:=0
                    else
                    CARI_SIL:=1;

                    if qry_Temp.FieldbyName('BEKLEME_FAT_VAR').AsInteger=1 then
                    begin
                      if not DataMod.ALICI_BEKLEME_CARI_HAR(CARI_SIL,BORC,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
                      begin
                        frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
                        Result := False;
                        Exit;
                      end;

                      qry_Temp.Edit;
                      qry_Temp.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger:=0;
                      qry_Temp.FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger:= 0;
                      qry_Temp.Post;
                    end;
               end;
               qry_Temp.Next;
          end;
     end;
  end;

  if prv_FAT_TIP=2 then //Alýþ
  begin
       qry_Temp.Active:=False;
       qry_Temp.sql.Clear;
       qry_Temp.sql.Text:='Select * from MAZOT_FISI Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID';
       qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=Gelen_Id;
       qry_Temp.Active:=True;

       if qry_Temp.FieldByName('MAZOT_FIS_ID').aSInteger>0 then
       begin
          qry_Temp.First;
          While not qry_Temp.Eof Do //birden fazla birleþtirmeli kayýt için
          begin

            if not DataMod.MAZOTCU_CARI_HAR(0,ALACAK,PRV_ISN,BT_MAZOT,qry_Temp,trnFAT_IRS) then
            begin
              frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
              Result := False;
              Exit;
            end;
            qry_Temp.Edit;
            qry_Temp.FieldByName('ALIS_FATURASI_ALINDI').AsInteger:=0;
            qry_Temp.FieldByName('ALIS_URUN_HAR_ID').AsInteger:=0;
            qry_Temp.Post;

            qry_Temp.Next;
          end;
       end;




       qry_Temp.Active:=False;
       qry_Temp.sql.Clear;
       qry_Temp.sql.Text:='Select * from Sefer Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID';
       qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=Gelen_Id;
       qry_Temp.Active:=True;
       if qry_Temp.FieldByName('SEFER_ID').aSInteger>0 then
       begin

          qry_Temp.First;
          While not qry_Temp.Eof Do //birden fazla birleþtirmeli kayýt için
          begin

            if not DataMod.SATICI_CARI_HAR(0,ALACAK,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
            begin
              frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
              Result := False;
              Exit;
            end;

            qry_Temp.Edit;
            qry_Temp.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger:=0;
            qry_Temp.FieldByName('ALIS_URUN_HAR_ID').AsInteger:=0;
            qry_Temp.Post;

            qry_Temp.Next;

          end;
       end;
  end;

  Result:=True;

end;


procedure TfrmFAT_Tran.Btn_Mazot_BilgisiClick(Sender: TObject);
var
  Mazot_ID,Mazot_SID:Integer;
  Gelen_Qry:TIb_Query;
  qry_Urun_Masraf:TIb_Query;
  Tek_Satir:Boolean;
begin
  if (Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString)='') then
  begin
    Application.MessageBox('Cari Kodu Olmadan Sefer Seçemezsiniz','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if prv_FAT_TIP<>2 then Exit;
  txtCariKod.Enabled:=False;

  DataMod.CreateQuery(Gelen_Qry,trnFAT_IRS,True,DataMod.dbaMain);

  DataMod.CreateQuery(qry_Urun_Masraf,trnFAT_IRS,True,DataMod.dbaMain);

  QryDegTrans.Active:=False;
  QryDegTrans.Sql.Clear;

  if frmMazotSDLG.Form_Open(False,Mazot_ID,Mazot_SID,
    qryFAT_IRS.FieldByName('CARI_KOD').AsString,
    qryFAT_IRS.FieldByName('CARI_KOD').AsString,
    Giden_Idler_Mazot,Gelen_Qry,prv_FAT_TIP,Tek_Satir) then
  begin

    Mazot_Aktarma_b:=True;

    QryDegTrans.Active:=False;
    QryDegTrans.Sql.Text:=Gelen_Qry.SQL.Text;
    QryDegTrans.Active:=True;

    Gelen_Qry.DisableControls;
    Gelen_Qry.First;

    While not Gelen_Qry.Eof do
    begin
         if Gelen_Qry.FieldByName('SECIM').AsString='1' then
         begin
             QryDegTrans.Edit;
             QryDegTrans.FieldByName('SECIM').AsString:='1';
             QryDegTrans.post;
         end
         else
         begin
             QryDegTrans.Edit;
             QryDegTrans.FieldByName('SECIM').AsString:='0';
             QryDegTrans.post;
         end;

         QryDegTrans.Next;
         Gelen_Qry.Next;
    end;
    Gelen_Qry.EnableControls;
    frmMazotSDLG.qryMazot.CancelUpdates;
    frmMazotSDLG.qryMazot.CommitUpdates;

    QryDegTrans.First;

{     if Tek_Satir then
     begin

        While not QryDegTrans.Eof do
        begin



             QryDegTrans.Next;
        end;

     end;

}
     if not Tek_Satir then
     While not QryDegTrans.Eof do
     begin

          if QryDegTrans.FieldByName('SECIM').AsInteger=1 then
          begin
               if Giden_Idler_Mazot.indexOf(Inttostr(QryDegTrans.FieldByName('MAZOT_FIS_ID').AsInteger))=-1 then
               begin
                 qryURUNHAR.Insert;

                 if Trim(QryDegTrans.FieldByName('MASRAF_MERK').AsString)<> '' then
                 begin
                    qry_Urun_Masraf.Close;
                    qry_Urun_Masraf.sql.Text:='SELECT ID, URUN_KOD, MASRAF_MERKEZI, YENI_URUN_KOD  FROM NETSIS_AKTARMA '
                    + 'WHERE URUN_KOD='+Sql_Katar(glb_MAZ_HIZ_URN_KOD) + ' AND MASRAF_MERKEZI='+Sql_Katar(QryDegTrans.FieldByName('MASRAF_MERK').AsString);
                    qry_Urun_Masraf.Active:=True;
                    if qry_Urun_Masraf.RecordCount>0 then
                    begin
                      qryURUNHAR.FieldByName('URUN_KOD').AsString:=qry_Urun_Masraf.FieldByName('YENI_URUN_KOD').asString;
                      txtUrunKoduExit(Self);
                    end
                    else
                    begin
                         //Application.MessageBox('Ürün kodu Masraf Karþýlaþtýrmasýnda bulunamadý Ýþlem Ýptal Edilecek'),'Dikkat',MB_ICONWARNING);
                        qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_MAZ_HIZ_URN_KOD;
                        txtUrunKoduExit(Self);
                         //qryURUNHAR.Cancel;
                         //Abort;
                    end;
                 end
                 else
                 begin
                      qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_MAZ_HIZ_URN_KOD;
                      txtUrunKoduExit(Self);
                 end;


                 //qryURUNHAR.FieldByName('URUN_KOD').AsString:=glb_MAZ_HIZ_URN_KOD;
                 //txtUrunKoduExit(Self);
                 qryURUNHAR.FieldByName('MIKTAR').AsFloat:=QryDegTrans.FieldByName('LITRE').AsFloat;
                 qryURUNHAR.FieldByName('BIRIM_FIY').AsFloat:=QryDegTrans.FieldByName('LITRE_FIYAT').AsFloat;
                 qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDateTime:=QryDegTrans.FieldByName('DOV_BAZ_TAR').AsDateTime;
                 qryURUNHAR.FieldByName('DOVKOD').AsString:=QryDegTrans.FieldByName('DOVKOD').AsString;
                 qryURUNHAR.FieldByName('DOVKUR').AsFloat:=QryDegTrans.FieldByName('DOVKUR').AsFloat;
                 qryURUNHAR.FieldByName('TUTAR').AsFloat:=QryDegTrans.FieldByName('TUTAR').AsFloat;
                 qryURUNHAR.FieldByName('TUTAR_VPB').AsFloat:=QryDegTrans.FieldByName('TUTAR_VPB').AsFloat;
                 qryURUNHAR.FieldByName('TARIH').AsDate := QryDegTrans.FieldByName('TARIH').AsDate;
                 qryURUNHAR.FieldByName('OLCUBIRIM').AsString:='KÝLO';
                 qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsString:='KÝLO';
                 qryURUNHAR.FieldByName('SECIM').AsString:='X';
                 qryURUNHAR.FieldByName('ACIKLAMA').AsString:=' ';
                 qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger:=QryDegTrans.FieldByName('MAZOT_FIS_ID').AsInteger;

                 qryURUNHAR.Post;

                 QryDegTrans.Edit;
                 QryDegTrans.FieldByName('ALIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                 QryDegTrans.Post;

                 Sefer_Mazot_Id_Duzenle('MAZOT','EKLE',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger);

                 if Giden_Idler_Mazot.indexof(InttoStr(QryDegTrans.FieldByName('MAZOT_FIS_ID').AsInteger))=-1 then
                 Giden_Idler_Mazot.Add(InttoStr(QryDegTrans.FieldByName('MAZOT_FIS_ID').AsInteger));



                 Mazot_Aktarma:=True;

               end;
          end;

          QryDegTrans.Next;
     end;
     Mazot_Aktarma_b:=False;
     frmMazotSDLG.Free;
  end;

//  QryDegTrans.CancelUpdates;
  QryDegTrans.Active:=False;
end;

procedure TfrmFAT_Tran.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;

     if prv_BELGE_TUR =BT_SATIS_FAT then
//     qryDeg1.SQL.Text:='SELECT  FIRST 1 FAT_IRS_ID,FAT_IRS_SID FROM FAT_IRS WHERE FAT_IRS_SEP=:FAT_IRS_SEP AND FAT_IRS_ID<:FAT_IRS_ID AND TIP=:TIP ORDER BY FAT_IRS_SERI,BELGE_NO DESC'
     qryDeg1.SQL.Text:='SELECT FIRST 1 FAT_IRS_ID,FAT_IRS_SID FROM FAT_IRS WHERE FAT_IRS_SEP=:FAT_IRS_SEP AND FAT_IRS_SERI<=:FAT_IRS_SERI and BELGE_NO<:BELGE_NO AND TIP=:TIP ORDER BY FAT_IRS_SERI,BELGE_NO DESC'
     else
     qryDeg1.SQL.Text:='SELECT  FIRST 1 FAT_IRS_ID,FAT_IRS_SID FROM FAT_IRS WHERE FAT_IRS_SEP=:FAT_IRS_SEP AND FAT_IRS_ID<:FAT_IRS_ID AND TIP=:TIP ORDER BY FAT_IRS_ID DESC';


     qryDeg1.ParamByName('TIP').AsInteger:=prv_FAT_TIP;
     qryDeg1.ParamByName('FAT_IRS_SEP').AsInteger:=prv_FAT_IRS_SEP;
//     qryDeg1.ParamByName('FAT_IRS_ID').AsInteger:=qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;

     if prv_BELGE_TUR =BT_ALIS_FAT then
     qryDeg1.ParamByName('FAT_IRS_ID').AsInteger:=prv_os_id;

     if prv_BELGE_TUR =BT_SATIS_FAT then
     begin
     qryDeg1.ParamByName('FAT_IRS_SERI').AsString:=prv_FAT_IRS_SERI;
     qryDeg1.ParamByName('BELGE_NO').AsString:=prv_BELGE_NO;
     end;


     qryDeg1.Open;
     if qryDeg1.FieldByName('FAT_IRS_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('FAT_IRS_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('FAT_IRS_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmFAT_Tran.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;

     if prv_BELGE_TUR =BT_SATIS_FAT then
//     qryDeg1.SQL.Text:='SELECT FIRST 1 FAT_IRS_ID,FAT_IRS_SID FROM FAT_IRS WHERE FAT_IRS_SEP=:FAT_IRS_SEP AND FAT_IRS_ID>:FAT_IRS_ID AND TIP=:TIP ORDER BY FAT_IRS_SERI,BELGE_NO'
     qryDeg1.SQL.Text:='SELECT FIRST 1 FAT_IRS_ID,FAT_IRS_SID FROM FAT_IRS WHERE FAT_IRS_SEP=:FAT_IRS_SEP AND FAT_IRS_SERI>=:FAT_IRS_SERI and BELGE_NO>:BELGE_NO AND TIP=:TIP ORDER BY FAT_IRS_SERI,BELGE_NO'
     else
     qryDeg1.SQL.Text:='SELECT FIRST 1 FAT_IRS_ID,FAT_IRS_SID FROM FAT_IRS WHERE FAT_IRS_SEP=:FAT_IRS_SEP AND FAT_IRS_ID>:FAT_IRS_ID AND TIP=:TIP ORDER BY FAT_IRS_ID';

     qryDeg1.ParamByName('FAT_IRS_SEP').AsInteger:=prv_FAT_IRS_SEP;
     qryDeg1.ParamByName('TIP').AsInteger:=prv_FAT_TIP;
//     qryDeg1.ParamByName('FAT_IRS_ID').AsInteger:=qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;

     if prv_BELGE_TUR =BT_ALIS_FAT then
     qryDeg1.ParamByName('FAT_IRS_ID').AsInteger:=prv_os_id;

     if prv_BELGE_TUR =BT_SATIS_FAT then
     begin
     qryDeg1.ParamByName('FAT_IRS_SERI').AsString:=prv_FAT_IRS_SERI;
     qryDeg1.ParamByName('BELGE_NO').AsString:=prv_BELGE_NO;
     end;

     qryDeg1.Open;
     if qryDeg1.FieldByName('FAT_IRS_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('FAT_IRS_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('FAT_IRS_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;


procedure TfrmFAT_Tran.Geri_AL;
begin
     CancelUpdates;
     CommitUpdates;

     if trnFAT_IRS.InTransaction then  trnFAT_IRS.Rollback;
end;


procedure TfrmFAT_Tran.Qry_Asl_Urun_HarBeforePost(IB_Dataset: TIB_Dataset);
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


     if IB_Dataset.FieldByName('MIKTAR_URN_OB').AsCurrency = IB_Dataset.FieldByName('MIKTAR').AsCurrency then
     IB_Dataset.FieldByName('BIRIM_FIY_URN_OB').AsCurrency := IB_Dataset.FieldByName('BIRIM_FIY').AsCurrency
     else
     IB_Dataset.FieldByName('BIRIM_FIY_URN_OB').AsCurrency :=
     IB_Dataset.FieldByName('TUTAR').AsCurrency/
     IB_Dataset.FieldByName('MIKTAR_URN_OB').AsCurrency;

     KalemHesaplaT;

end;

procedure TfrmFAT_Tran.qryURUNHARBeforeInsert(IB_Dataset: TIB_Dataset);
begin
   if (Trim(qryFAT_IRS.FieldByName('CARI_KOD').AsString)='') then
   begin
     Application.MessageBox('Cari Kodu Olmadan Hereket Giremezsiniz','Dikkat',MB_ICONWARNING);
     Abort;
   end;
end;

procedure TfrmFAT_Tran.Qry_Asl_Urun_HarAfterDelete(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesapla(True);
end;

procedure TfrmFAT_Tran.Qry_Asl_Urun_HarAfterInsert( IB_Dataset: TIB_Dataset);
begin
   with IB_Dataset do
   begin
     //FieldByName('URUNHAR_ID').AsInteger := Qry_Asl_Urun_Har.Gen_ID('GEN_URUNHAR',1);
     //ShowMessage(Inttostr(FieldByName('URUNHAR_ID').AsInteger));
     //FieldByName('URUNHAR_SID').AsInteger := glb_SID;
     FieldByName('MIKTAR').AsInteger := 0;
     FieldByName('FATURA_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger ;
     FieldByName('FATURA_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger ;
     FieldByName('IRSALIYE_ID').AsInteger := 0;
     FieldByName('IRSALIYE_SID').AsInteger := 0;
     FieldByName('DEPO_KOD').AsString := qryFAT_IRS.FieldByName('DEPO_KOD').AsString;
     FieldByName('DEPO_AD').AsString := qryFAT_IRS.FieldByName('DEPO_AD').AsString ;
     //FieldByName('TARIH').AsDate := qryFAT_IRS.FieldByName('TARIH').AsDate;
     //FieldByName('DOV_BAZ_TAR').AsDate := qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDate;
     FieldByName('BELGE_TUR').AsInteger := prv_BELGE_TUR;
     FieldByName('BELGE_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger ;
     FieldByName('BELGE_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger ;
     FieldByName('BELGE_SIRA_NO').AsInteger := 1;
     FieldByName('ISKONTO_TIP').AsInteger := 0;
     FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := 0 ;
     FieldByName('DOVKOD').AsString := glb_DEFCUR;

     FieldByName('CIKIS_MIKTAR').AsCurrency := 0;

     FieldByName('OLCUBIRIM').AsString:='ADET';
     FieldByName('OLCUBIRIM_URN_OB').AsString:='ADET';
     FieldByName('URUN_DOVKOD').AsString:='YTL';

     FieldByName('SEFER_ID').AsInteger := 0;
     FieldByName('MAZOT_FISI_ID').AsInteger := 0;
     FieldByName('SEFER_BEKLEME').AsInteger := 0;

     FieldByName('KDV_TUTAR').AsCurrency := 0;

     If (prv_FAT_TIP = 1) then  //SATIÞ
     begin
       FieldByName('TIP').AsString :=  ALACAK;
     end else
     begin   //ALIÞ
       FieldByName('TIP').AsString :=  BORC;
     end;
     FieldByName('KDV').AsInteger := 0;

     if prv_KDV_HESAPLA then
     begin
        FieldByName('KDV').AsInteger := 18
     end
     else
     begin
        FieldByName('KDV').AsInteger := 0;
     end;
   end;

end;

procedure TfrmFAT_Tran.Qry_Asl_Urun_HarAfterPost(IB_Dataset: TIB_Dataset);
begin
  KalemBrutHesaplaT(False);
end;

procedure TfrmFAT_Tran.KalemHesaplaT;
begin
/// ürün secilmediði zaman miktar hesaplamalara 1 olarak katýlacak
// yada hesaplamalardan cýkarýlacak

  Qry_Asl_Urun_Har.FieldByName('TUTAR').AsCurrency := Qry_Asl_Urun_Har.FieldByNAme('MIKTAR').AsCurrency * Qry_Asl_Urun_Har.FieldByName('BIRIM_FIY').AsCurrency;
  Qry_Asl_Urun_Har.FieldByName('TUTAR_VPB').AsCurrency := Qry_Asl_Urun_Har.FieldByNAme('MIKTAR').AsCurrency * Qry_Asl_Urun_Har.FieldByName('BIRIM_FIY').AsCurrency*Qry_Asl_Urun_Har.FieldByName('DOVKUR').AsCurrency;

  if prv_KDV_HESAPLA then
  begin
    if Qry_Asl_Urun_Har.FieldByName('KDV').AsInteger <> 0 then  Qry_Asl_Urun_Har.FieldByName('KDV_TUTAR').AsCurrency := qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency * (Qry_Asl_Urun_Har.FieldByName('KDV').AsInteger / 100);
  end
  else
  begin
    Qry_Asl_Urun_Har.FieldByName('KDV_TUTAR').AsCurrency := 0;
  end;

  if Qry_Asl_Urun_Har.FieldByName('ISKONTO_TIP').AsSmallInt=0 then
  begin //oran yani
    Qry_Asl_Urun_Har.FieldByName('ISKONTO_TUTAR').AsCurrency := Qry_Asl_Urun_Har.FieldByName('ISKONTO_ORAN').AsInteger*(Qry_Asl_Urun_Har.FieldByName('TUTAR').AsCurrency/100);
    Qry_Asl_Urun_Har.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := Qry_Asl_Urun_Har.FieldByName('ISKONTO_TUTAR').AsCurrency * Qry_Asl_Urun_Har.FieldByName('DOVKUR').AsCurrency;
  end
  else
  begin // tutar yani
    Qry_Asl_Urun_Har.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := Qry_Asl_Urun_Har.FieldByName('ISKONTO_TUTAR').AsCurrency * Qry_Asl_Urun_Har.FieldByName('DOVKUR').AsCurrency;
  end;
end;


procedure TfrmFAT_Tran.GrdFatKontrolKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
     if key = vk_up then
     if not  ((qryURUNHAR.Eof) and (qryURUNHAR.Bof))  then
     Abort;

     if (Shift=[ssCtrl]) and (key=vk_Return) then
     if GrdFatKontrol.SelectedField=qryURUNHAR.FieldByName('URUN_KOD') then txtUrunKoduButtonClick(Self);
end;

procedure TfrmFAT_Tran.txtUrunKoduButtonClick(Sender: TObject);
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
        FieldByName('TARIH').AsDate := Date;
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



procedure TfrmFAT_Tran.GrdFatKontrolDblClick(Sender: TObject);
begin
   if GrdFatKontrol.SelectedField= qryURUNHAR.FieldByName('URUN_KOD') then txtUrunKoduButtonClick(Self);
end;

procedure TfrmFAT_Tran.Qry_Asl_Urun_HarBeforeDelete( IB_Dataset: TIB_Dataset);
begin
    if not Sefer_Hareketleri_Olusturma(IB_Dataset.FieldByName('URUNHAR_ID').AsInteger,
    IB_Dataset.FieldByName('URUN_KOD').AsString) then
    begin
       trnFAT_IRS.Rollback;
       Application.MessageBox('Sefer , Mazot Bilgileri Yeniden Oluþturmada Hata Ýþlemden Vazgeçilecek','Dikkat',MB_ICONWARNING);
       Abort;
    end;
end;

procedure TfrmFAT_Tran.qryURUNHARBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  qry_Temp.Active:=False;
  qry_Temp.sql.Clear;
  qry_Temp.sql.Text:='Delete from Fatura_D Where URUNHAR_ID=:SATIS_URUN_HAR_ID';
  qry_Temp.ParamByName('SATIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
  qry_Temp.Execute;

  //if qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger >0 then
  if (qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger >0) and (qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger <>1999999) then
  Sefer_Mazot_Id_Duzenle('MAZOT','SIL',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger);

  if qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger =1999999 then
  begin
       qry_Temp.Active:=False;
       qry_Temp.sql.Clear;
       qry_Temp.sql.Text:='Select * from MAZOT_FISI Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID';
       qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
       qry_Temp.Active:=True;
       While not qry_Temp.Eof do
       begin
          Sefer_Mazot_Id_Duzenle('MAZOT','SIL',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qry_Temp.FieldByName('MAZOT_FIS_ID').AsInteger);
          qry_Temp.Next;

       end;
  end;


  //if qryURUNHAR.FieldByName('SEFER_ID').AsInteger >0 then
  if (qryURUNHAR.FieldByName('SEFER_ID').AsInteger >0) and (qryURUNHAR.FieldByName('SEFER_ID').AsInteger <>1999999) then
  begin
    //if qryURUNHAR.FieldByName('URUN_KOD').AsString=glb_BEK_HIZ_URN_KOD then
    if qryURUNHAR.FieldByName('SEFER_BEKLEME').AsInteger=1 then
    if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_BEK_HIZ_URN_KOD) then
    Sefer_Mazot_Id_Duzenle('SEFER','SIL',True,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qryURUNHAR.FieldByName('SEFER_ID').AsInteger);

    //if qryURUNHAR.FieldByName('URUN_KOD').AsString=glb_NAK_HIZ_URN_KOD then
    if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) then
    Sefer_Mazot_Id_Duzenle('SEFER','SIL',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qryURUNHAR.FieldByName('SEFER_ID').AsInteger)
  end;

  if qryURUNHAR.FieldByName('SEFER_ID').AsInteger =1999999 then
  begin
       qry_Temp.Active:=False;
       qry_Temp.sql.Clear;
       qry_Temp.sql.Text:='Select * from SEFER Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID or SATIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID or BEK_FAT_URUN_HAR_ID=:ALIS_URUN_HAR_ID';
       qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
       qry_Temp.Active:=True;
       While not qry_Temp.Eof do
       begin

         if qryURUNHAR.FieldByName('SEFER_BEKLEME').AsInteger=1 then
         if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_BEK_HIZ_URN_KOD) then
         Sefer_Mazot_Id_Duzenle('SEFER','SIL',True,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qry_Temp.FieldByName('SEFER_ID').AsInteger);

         if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) then
         Sefer_Mazot_Id_Duzenle('SEFER','SIL',False,qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger,qry_Temp.FieldByName('SEFER_ID').AsInteger);

         qry_Temp.Next;
       end;
  end;



end;


procedure TfrmFAT_Tran.Sefer_Mazot_Id_Doldur;
begin
     Gelen_Idler.Clear;
     Gelen_Idler_Bekleme.Clear;
     Gelen_Idler_Mazot.Clear;

     Giden_Idler.Clear;
     Giden_Idler_Bekleme.Clear;
     Giden_Idler_Mazot.Clear;

     qryURUNHAR.DisableControls;
     qryURUNHAR.First;

     while not qryURUNHAR.eof Do
     begin
            //if Trim(qryURUNHAR.FieldByName('URUN_KODU').AsString)<>'' then //3 tanýmlý kodtan ise
         {   if (Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString)=glb_NAK_HIZ_URN_KOD) or
            (Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString)=glb_BEK_HIZ_URN_KOD) or
            (Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString)=glb_MAZ_HIZ_URN_KOD) then
         }
         if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) or
         DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_BEK_HIZ_URN_KOD) or
         DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_MAZ_HIZ_URN_KOD)
         then
         begin
               if (qryURUNHAR.FieldByName('SEFER_ID').AsInteger>0) and (qryURUNHAR.FieldByName('SEFER_ID').AsInteger<>1999999) then
               begin
                  //if (Trim(qryURUNHAR.FieldByName('URUN_KOD').AsString)=glb_NAK_HIZ_URN_KOD) then
                  if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) then
                  begin
                     Gelen_Idler.Add(Inttostr(qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger));
                     Giden_Idler.Add(Inttostr(qryURUNHAR.FieldByName('SEFER_ID').AsInteger));
                  end;

                  if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_BEK_HIZ_URN_KOD) then
                  if qryURUNHAR.FieldByName('SEFER_BEKLEME').AsInteger=1 then
                  begin
                    Gelen_Idler_Bekleme.Add(Inttostr(qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger));
                    Giden_Idler_Bekleme.Add(Inttostr(qryURUNHAR.FieldByName('SEFER_ID').AsInteger));
                  end;
               end;

               if qryURUNHAR.FieldByName('SEFER_ID').AsInteger=1999999 then
               begin

                  qry_Temp.Active:=False;
                  qry_Temp.sql.Clear;
                  qry_Temp.sql.Text:='Select * from Sefer Where ALIS_URUN_HAR_ID=:SEFER_ID or SATIS_URUN_HAR_ID=:SEFER_ID or BEK_FAT_URUN_HAR_ID=:SEFER_ID';
                  qry_Temp.ParamByName('SEFER_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                  qry_Temp.Active:=True;
                  While not qry_Temp.Eof do
                  begin
                      if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) then
                      if (qry_Temp.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger=1) or
                       (qry_Temp.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger=1)
                      then
                      begin
                         Gelen_Idler.Add(Inttostr(qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger));
                         Giden_Idler.Add(Inttostr(qry_Temp.FieldByName('SEFER_ID').AsInteger));
                      end;

                      if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_BEK_HIZ_URN_KOD) then
                      if qry_Temp.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=1 then
                      begin
                          Gelen_Idler_Bekleme.Add(Inttostr(qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger));
                          Giden_Idler_Bekleme.Add(Inttostr(qry_Temp.FieldByName('SEFER_ID').AsInteger));
                      end;
                      qry_Temp.Next;
                  end;

               end;


               if (qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger>0) and (qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger<>1999999) then
//               if qry_Temp.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1 then
               begin
                 Gelen_Idler_Mazot.Add(Inttostr(qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger));
                 Giden_Idler_Mazot.Add(Inttostr(qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger));
               end;

               if qryURUNHAR.FieldByName('MAZOT_FISI_ID').AsInteger=1999999 then
               begin
                  qry_Temp.Active:=False;
                  qry_Temp.sql.Clear;
                  qry_Temp.sql.Text:='Select * from  MAZOT_FISI  Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID';
                  qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger;
                  qry_Temp.Active:=True;
                  While not qry_Temp.Eof do
                  begin
                      if DataMod.Urun_Kod_Karsilastir(qryURUNHAR.FieldByName('URUN_KOD').AsString,glb_MAZ_HIZ_URN_KOD) then
                      if qry_Temp.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1 then
                      begin
                       Gelen_Idler_Mazot.Add(Inttostr(qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger));
                       Giden_Idler_Mazot.Add(Inttostr(qry_Temp.FieldByName('MAZOT_FIS_ID').AsInteger));
                      end;
                      qry_Temp.Next;
                  end;
               end;

         end;

         qryURUNHAR.Next;
     end;
     qryURUNHAR.First;
     qryURUNHAR.EnableControls;
end;


procedure TfrmFAT_Tran.Sefer_Mazot_Id_Duzenle(Nereden:String;Islem:String;Bekleme:Boolean;Id:Integer;Mazot_Sefer:Integer);
var
   a:Integer;
   Hangi:Integer;
   Yap:Boolean;
begin

     if Nereden='SEFER' then
     begin

          if Islem='EKLE' then
          begin
             Yap:=True;
             for a:=0 to Gelen_Idler.Count-1 do
             begin
                  if StrToInt(Gelen_Idler.Strings[a])=Id then Yap:=False;
             end;
             if Yap then Gelen_Idler.Add(Inttostr(Id));

             if Bekleme then
             begin
                Yap:=True;
                for a:=0 to Gelen_Idler_Bekleme.Count-1 do
                begin
                     if StrToInt(Gelen_Idler_Bekleme.Strings[a])=Id then Yap:=False;
                end;
                if Yap then Gelen_Idler_Bekleme.Add(Inttostr(Id));
             end;
          end;

          Hangi:=0;
          if Islem='SIL' then
          begin
             if not Bekleme then
             begin
               Yap:=False;
               for a:=0 to Gelen_Idler.Count-1 do
               begin
                    if StrToInt(Gelen_Idler.Strings[a])=Id then
                    begin
                      Yap:=True;
                      Hangi:=a;
                    end;
               end;
               if Yap then Gelen_Idler.Delete(Hangi);
             end;

             if Bekleme then
             begin
                Yap:=False;
                for a:=0 to Gelen_Idler_Bekleme.Count-1 do
                begin
                     if StrToInt(Gelen_Idler_Bekleme.Strings[a])=Id then
                     begin
                     Yap:=True;
                     Hangi:=a;
                     end;
                end;
                if Yap then Gelen_Idler_Bekleme.Delete(Hangi);
             end;


             Yap:=True;
             for a:=0 to Silinen_Idler.Count-1 do
             begin
                  if StrToInt(Silinen_Idler.Strings[a])=Id then Yap:=False;
             end;
             if Yap then Silinen_Idler.Add(Inttostr(Id));


             if not Bekleme then
             begin
                     //ShowMessage(Giden_Idler.CommaText);
                a:=Giden_Idler.IndexOf(InttoStr(Mazot_Sefer));
                if a>-1 then
                Giden_Idler.Delete(a);
             end;


             if Bekleme then
             begin
                     //ShowMessage(Giden_Idler_Bekleme.CommaText);
                a:=Giden_Idler_Bekleme.IndexOf(InttoStr(Mazot_Sefer));
                if a>-1 then
                Giden_Idler_Bekleme.Delete(a);
             end;
          end;
     end;

     if Nereden='MAZOT' then
     begin
          if Islem='EKLE' then
          begin
             Yap:=True;
             for a:=0 to Gelen_Idler_Mazot.Count-1 do
             begin
                  if StrToInt(Gelen_Idler_Mazot.Strings[a])=Id then Yap:=False;
             end;
             if Yap then Gelen_Idler_Mazot.Add(Inttostr(Id));
          end;

          Hangi:=0;
          if Islem='SIL' then
          begin

             Yap:=False;
             for a:=0 to Gelen_Idler_Mazot.Count-1 do
             begin
                  if StrToInt(Gelen_Idler_Mazot.Strings[a])=Id then
                  begin
                    Yap:=True;
                    Hangi:=a;
                  end;
             end;
             if Yap then Gelen_Idler_Mazot.Delete(Hangi);


             Yap:=True;
             for a:=0 to Silinen_Idler.Count-1 do
             begin
                  if StrToInt(Silinen_Idler.Strings[a])=Id then Yap:=False;
             end;
             if Yap then Silinen_Idler.Add(Inttostr(Id));


             a:=Giden_Idler_Mazot.IndexOf(InttoStr(Mazot_Sefer));
             if a>-1 then
             Giden_Idler_Mazot.Delete(a);

          end;
     end;
end;

function TfrmFAT_Tran.Sefer_Mazot_Hareketleri_Duzenle:Boolean;
begin
     Result:=False;

     if prv_FAT_TIP=1 then //satýþ
     begin

       Qry_Asl_Urun_Har.First;
       While not Qry_Asl_Urun_Har.eof Do
       begin

          if Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger<= 0 then
          begin
             Qry_Asl_Urun_Har.Next;
             Continue;
          end;

          //if (Trim(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString)=glb_NAK_HIZ_URN_KOD) then
          if DataMod.Urun_Kod_Karsilastir(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) then
          begin
             qry_Temp.Active:=False;
             qry_Temp.sql.Clear;
             qry_Temp.sql.Text:='Select * from Sefer Where SEFER_ID=:SEFER_ID';
             qry_Temp.ParamByName('SEFER_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger;
             qry_Temp.Active:=True;

             qry_Temp.Edit;
             qry_Temp.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger:=1;
             qry_Temp.FieldByName('SATIS_URUN_HAR_ID').AsInteger:= Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
             qry_Temp.Post;

             if not DataMod.ALICI_CARI_HAR(1,BORC,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
             begin
               frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
               Result := False;
               Exit;
             end;
          end;


          //if (Trim(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString)=glb_BEK_HIZ_URN_KOD) then
          if DataMod.Urun_Kod_Karsilastir(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,glb_BEK_HIZ_URN_KOD) then
          begin
             qry_Temp.Active:=False;
             qry_Temp.sql.Clear;
             qry_Temp.sql.Text:='Select * from Sefer Where SEFER_ID=:SEFER_ID';
             qry_Temp.ParamByName('SEFER_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger;
             qry_Temp.Active:=True;

             if qry_Temp.FieldByName('BEKLEME_FAT_VAR').AsInteger=1 then
             begin

               qry_Temp.Edit;
               qry_Temp.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger:=1;
               qry_Temp.FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger:= Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
               qry_Temp.Post;

               if not DataMod.ALICI_BEKLEME_CARI_HAR(1,BORC,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
               begin
                 frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
                 Result := False;
                 Exit;
               end;
             end;
          end;

          Qry_Asl_Urun_Har.Next;
       end;

     end;

     if prv_FAT_TIP=2 then //alýþ
     begin

       Qry_Asl_Urun_Har.First;
       While not Qry_Asl_Urun_Har.eof Do
       begin
          if Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger<= 0 then
          begin
             Qry_Asl_Urun_Har.Next;
             Continue;
          end;

          //if (Trim(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString)=glb_NAK_HIZ_URN_KOD) then
          if DataMod.Urun_Kod_Karsilastir(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) then
          begin

            qry_Temp.Active:=False;
            qry_Temp.sql.Clear;
            qry_Temp.sql.Text:='Select * from Sefer Where SEFER_ID=:SEFER_ID';
            qry_Temp.ParamByName('SEFER_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger;
            qry_Temp.Active:=True;


            qry_Temp.Edit;
            qry_Temp.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger:=1;
            qry_Temp.FieldByName('ALIS_URUN_HAR_ID').AsInteger:= Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
            qry_Temp.Post;
            if not DataMod.SATICI_CARI_HAR(1,ALACAK,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
            begin
              frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
              Result := False;
              Exit;
            end;
          end;

          Qry_Asl_Urun_Har.Next;
       end;

       Qry_Asl_Urun_Har.First;
       While not Qry_Asl_Urun_Har.eof Do
       begin
          if Qry_Asl_Urun_Har.FieldByName('MAZOT_FISI_ID').AsInteger<= 0 then
          begin
             Qry_Asl_Urun_Har.Next;
             Continue;
          end;

          //if (Trim(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString)=glb_MAZ_HIZ_URN_KOD) then
          if DataMod.Urun_Kod_Karsilastir(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,glb_MAZ_HIZ_URN_KOD) then
          begin

            qry_Temp.Active:=False;
            qry_Temp.sql.Clear;
            qry_Temp.sql.Text:='Select * from MAZOT_FISI Where MAZOT_FIS_ID=:MAZOT_FIS_ID';
            qry_Temp.ParamByName('MAZOT_FIS_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('MAZOT_FISI_ID').AsInteger;
            qry_Temp.Active:=True;

            qry_Temp.Edit;
            qry_Temp.FieldByName('ALIS_URUN_HAR_ID').AsInteger:= Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
            qry_Temp.FieldByName('ALIS_FATURASI_ALINDI').AsInteger:=1;
            qry_Temp.Post;

            if not DataMod.MAZOTCU_CARI_HAR(1,ALACAK,PRV_ISN,BT_MAZOT,qry_Temp,trnFAT_IRS) then
            begin
              frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
              Result := False;
              Exit;
            end;
          end;

          Qry_Asl_Urun_Har.Next;
       end;

     end;
     Result := True;
end;


function TfrmFAT_Tran.Sefer_Mazot_Hareketleri_Duzenle_Yeni:Boolean;
begin
     Result:=False;

     if prv_FAT_TIP=1 then //satýþ
     begin

       Qry_Asl_Urun_Har.First;
       While not Qry_Asl_Urun_Har.eof Do
       begin

          if Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger<= 0 then
          begin
             Qry_Asl_Urun_Har.Next;
             Continue;
          end;

          //if (Trim(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString)=glb_NAK_HIZ_URN_KOD) then
          if DataMod.Urun_Kod_Karsilastir(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) then
          begin
             qry_Temp.Active:=False;
             qry_Temp.sql.Clear;
             qry_Temp.sql.Text:='Select * from Sefer Where SATIS_URUN_HAR_ID=:SATIS_URUN_HAR_ID or SEFER_ID=:SEFER_ID';
             qry_Temp.ParamByName('SATIS_URUN_HAR_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
             qry_Temp.ParamByName('SEFER_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger;
             qry_Temp.Active:=True;


             While not qry_Temp.Eof Do
             begin

                qry_Temp.Edit;
                qry_Temp.FieldByName('SEFER_SATIS_FAT_KESILDI').AsInteger:=1;
                qry_Temp.FieldByName('SATIS_URUN_HAR_ID').AsInteger:= Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
                qry_Temp.Post;

                if not DataMod.ALICI_CARI_HAR(1,BORC,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
                begin
                  frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
                  Result := False;
                  Exit;
                end;

                qry_Temp.Next;

             end;
          end;


          //if (Trim(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString)=glb_BEK_HIZ_URN_KOD) then
          if DataMod.Urun_Kod_Karsilastir(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,glb_BEK_HIZ_URN_KOD) then
          begin
             qry_Temp.Active:=False;
             qry_Temp.sql.Clear;
             qry_Temp.sql.Text:='Select * from Sefer Where BEK_FAT_URUN_HAR_ID=:BEK_FAT_URUN_HAR_ID or SEFER_ID=:SEFER_ID';
             qry_Temp.ParamByName('BEK_FAT_URUN_HAR_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
             qry_Temp.ParamByName('SEFER_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger;
             qry_Temp.Active:=True;

             While not qry_Temp.Eof Do
             begin


                 if qry_Temp.FieldByName('BEKLEME_FAT_VAR').AsInteger=1 then
                 begin
                   qry_Temp.Edit;
                   qry_Temp.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger:=1;
                   qry_Temp.FieldByName('BEK_FAT_URUN_HAR_ID').AsInteger:= Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
                   qry_Temp.Post;

                   if not DataMod.ALICI_BEKLEME_CARI_HAR(1,BORC,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
                   begin
                     frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
                     Result := False;
                     Exit;
                   end;
                 end;

                 qry_Temp.Next;
             end;
          end;

          Qry_Asl_Urun_Har.Next;
       end;

     end;

     if prv_FAT_TIP=2 then //alýþ
     begin

       Qry_Asl_Urun_Har.First;
       While not Qry_Asl_Urun_Har.eof Do
       begin
          if Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger<= 0 then
          begin
             Qry_Asl_Urun_Har.Next;
             Continue;
          end;

          //if (Trim(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString)=glb_NAK_HIZ_URN_KOD) then
          if DataMod.Urun_Kod_Karsilastir(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,glb_NAK_HIZ_URN_KOD) then
          begin

            qry_Temp.Active:=False;
            qry_Temp.sql.Clear;
            qry_Temp.sql.Text:='Select * from Sefer Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID or SEFER_ID=:SEFER_ID';
            qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
            qry_Temp.ParamByName('SEFER_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('SEFER_ID').AsInteger;
            qry_Temp.Active:=True;

            While not qry_Temp.Eof Do
            begin

               qry_Temp.Edit;
               qry_Temp.FieldByName('SEFER_ALIS_FAT_ALINDI').AsInteger:=1;
               qry_Temp.FieldByName('ALIS_URUN_HAR_ID').AsInteger:= Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
               qry_Temp.Post;
               if not DataMod.SATICI_CARI_HAR(1,ALACAK,PRV_ISN,BT_SEFER,qry_Temp,trnFAT_IRS) then
               begin
                 frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
                 Result := False;
                 Exit;
               end;

               qry_Temp.Next;
            end;

          end;

          Qry_Asl_Urun_Har.Next;
       end;

       Qry_Asl_Urun_Har.First;
       While not Qry_Asl_Urun_Har.eof Do
       begin
          if Qry_Asl_Urun_Har.FieldByName('MAZOT_FISI_ID').AsInteger<= 0 then
          begin
             Qry_Asl_Urun_Har.Next;
             Continue;
          end;

          //if (Trim(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString)=glb_MAZ_HIZ_URN_KOD) then
          if DataMod.Urun_Kod_Karsilastir(Qry_Asl_Urun_Har.FieldByName('URUN_KOD').AsString,glb_MAZ_HIZ_URN_KOD) then
          begin

            qry_Temp.Active:=False;
            qry_Temp.sql.Clear;
            qry_Temp.sql.Text:='Select * from MAZOT_FISI Where ALIS_URUN_HAR_ID=:ALIS_URUN_HAR_ID or MAZOT_FIS_ID=:MAZOT_FIS_ID';
            qry_Temp.ParamByName('ALIS_URUN_HAR_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
            qry_Temp.ParamByName('MAZOT_FIS_ID').AsInteger:=Qry_Asl_Urun_Har.FieldByName('MAZOT_FISI_ID').AsInteger;
            qry_Temp.Active:=True;

            While not qry_Temp.Eof Do
            begin

                 qry_Temp.Edit;
                 qry_Temp.FieldByName('ALIS_URUN_HAR_ID').AsInteger:= Qry_Asl_Urun_Har.FieldByName('URUNHAR_ID').AsInteger;
                 qry_Temp.FieldByName('ALIS_FATURASI_ALINDI').AsInteger:=1;
                 qry_Temp.Post;

                 if not DataMod.MAZOTCU_CARI_HAR(1,ALACAK,PRV_ISN,BT_MAZOT,qry_Temp,trnFAT_IRS) then
                 begin
                   frmISN_ERRORS.AnyErr(trnFAT_IRS,PRV_ISN,0);
                   Result := False;
                   Exit;
                 end;

                 qry_Temp.Next;
            end;

          end;

          Qry_Asl_Urun_Har.Next;
       end;

     end;
     Result := True;
end;


procedure TfrmFAT_Tran.Button1Click(Sender: TObject);
var
   i:Integer;
begin
   for i:=1 to 100 do begin
      qryURUNHAR.Insert;
      qryURUNHAR.FieldByName('ACIKLAMA').AsString := IntToStr(i);
      qryURUNHAR.Post;
   end;
end;

procedure TfrmFAT_Tran.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmFAT_Tran.Button2Click(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT FAT_IRS_ID,FAT_IRS_SID FROM FAT_IRS WHERE FAT_IRS_SEP=:FAT_IRS_SEP and TIP=:TIP ORDER BY FAT_IRS_ID';
     qryDeg1.ParamByName('FAT_IRS_SEP').AsInteger:=prv_FAT_IRS_SEP;
     qryDeg1.ParamByName('TIP').AsInteger:=prv_FAT_TIP;

     qryDeg1.Open;
     While not qryDeg1.Eof Do
     begin

     if qryDeg1.FieldByName('FAT_IRS_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('FAT_IRS_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('FAT_IRS_SID').AsInteger;
          DataSet_Open(Id,Sid,1);

          btnTRN_KAYDETClick(btnTRN_KAYDET);

     end;
         qryDeg1.Next;

     end;

     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmFAT_Tran.Yazdirildi(Sep:Integer;Id:Integer;Sid:Integer);
var
   qryDeg:TIb_Query;
begin
     DataMod.CreateQuery(qryDeg,trnFAT_IRS,True,DataMod.dbaMain);
     qryDeg.Active:=False;
     qryDeg.SQL.Clear;
     qryDeg.SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_SEP = '+inttostr(Sep)+' AND FAT_IRS_ID='+inttostr(ID)+' AND FAT_IRS_SID='+inttostr(SID));
     qryDeg.Open;
     qryDeg.Edit;
     qryDeg.FieldByName('YAZILDI').AsInteger:=1;
     qryDeg.Post;
     qryDeg.Active:=False;
end;

procedure TfrmFAT_Tran.FormActivate(Sender: TObject);
begin
  //left:=0;
  //top:=0;
  WindowState:=wsMaximized;

end;

end.


