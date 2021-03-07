unit ufrmSefer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Buttons, ExtCtrls, IB_Controls, Mask,
  Menus, ComCtrls, Grids, IB_Grid;

type
  TfrmSefer = class(TForm)
    Pg_Sefer: TPageControl;
    Ts_Sefer: TTabSheet;
    Ts_Mazot: TTabSheet;
    IB_Text2: TIB_Text;
    IB_Text4: TIB_Text;
    IB_Text5: TIB_Text;
    IB_Text1: TIB_Text;
    IB_Edit1: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_Date2: TIB_Date;
    txtAliciKod: TIB_Edit;
    txtPERSONEL_KOD: TIB_Edit;
    IB_Edit5: TIB_Edit;
    grpRapKod: TGroupBox;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Currency1: TIB_Currency;
    txtSaticiKod: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    IB_CheckBox2: TIB_CheckBox;
    IB_CheckBox3: TIB_CheckBox;
    IB_Edit27: TIB_Edit;
    IB_Edit6: TIB_Edit;
    txtArac_Kod: TIB_Edit;
    GroupBox1: TGroupBox;
    IB_Currency4: TIB_Currency;
    cboDOVKOD: TIB_ComboBox;
    IB_Currency2: TIB_Currency;
    IB_Currency9: TIB_Currency;
    IB_Date3: TIB_Date;
    GroupBox2: TGroupBox;
    IB_Currency6: TIB_Currency;
    cboDOVKOD1: TIB_ComboBox;
    IB_Currency5: TIB_Currency;
    IB_Currency10: TIB_Currency;
    IB_Date4: TIB_Date;
    Cb_Cik_Yer: TIB_ComboBox;
    Cb_Bit_Yer: TIB_ComboBox;
    Cb_Tas_Esya: TIB_ComboBox;
    qrySefer: TIB_Query;
    dtsSefer: TIB_DataSource;
    trnSefer: TIB_Transaction;
    GroupBox3: TGroupBox;
    IB_Currency7: TIB_Currency;
    IB_Currency8: TIB_Currency;
    cboDOVKOD2: TIB_ComboBox;
    IB_Date5: TIB_Date;
    IB_CheckBox4: TIB_CheckBox;
    dtsKont: TIB_DataSource;
    qryKont: TIB_Query;
    dtsMazot: TIB_DataSource;
    qryMazot: TIB_Query;
    IB_Text3: TIB_Text;
    IB_Text8: TIB_Text;
    IB_Edit2: TIB_Edit;
    IB_Date6: TIB_Date;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Currency3: TIB_Currency;
    IB_Currency11: TIB_Currency;
    IB_ComboBox1: TIB_ComboBox;
    IB_Date7: TIB_Date;
    IB_Edit14: TIB_Edit;
    IB_Date8: TIB_Date;
    IB_Currency12: TIB_Currency;
    IB_Currency13: TIB_Currency;
    IB_Currency14: TIB_Currency;
    IB_Edit15: TIB_Edit;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    Panel2: TPanel;
    BtnMYeni: TBitBtn;
    BtnMKaydet: TButton;
    BtnMIptal: TButton;
    BtnMSil: TButton;
    txtDorse: TIB_Edit;
    IB_Text6: TIB_Text;
    IB_Grid2: TIB_Grid;
    IB_CheckBox5: TIB_CheckBox;
    IB_CheckBox6: TIB_CheckBox;
    Label1: TLabel;
    IB_Grid1: TIB_Grid;
    BtnKont_Sil: TButton;
    BtnKont_Iptal: TButton;
    BtnKont_Kaydet: TButton;
    BtnKont_Ekle: TButton;
    Label2: TLabel;
    IB_Text7: TIB_Text;
    IB_Text9: TIB_Text;
    Label3: TLabel;
    Panel3: TPanel;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    IB_Edit8: TIB_Edit;
    IB_Currency15: TIB_Currency;
    IB_Edit10: TIB_Edit;
    IB_ComboBox2: TIB_ComboBox;
    IB_Text10: TIB_Text;
    IB_Text11: TIB_Text;
    IB_Text12: TIB_Text;
    Button1: TButton;
    IB_ComboBox3: TIB_ComboBox;
    IB_LookupCombo1: TIB_LookupCombo;
    qryESYA: TIB_Query;
    dtsESYA: TIB_DataSource;
    procedure qrySeferAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure dtsSeferStateChanged(Sender: TIB_DataSource;       ADataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure dtsSeferDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure FormCreate(Sender: TObject);
    procedure IB_Edit3ButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit3Enter(Sender: TObject);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure txtPERSONEL_KODExit(Sender: TObject);
    procedure txtPERSONEL_KODEnter(Sender: TObject);
    procedure txtPERSONEL_KODButtonClick(Sender: TObject);
    procedure txtPERSONEL_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPERSONEL_KODKeyPress(Sender: TObject; var Key: Char);
    procedure btnYeniClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure btnSilClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure IB_Edit8ButtonClick(Sender: TObject);
    procedure IB_Edit10ButtonClick(Sender: TObject);
    procedure IB_Edit11ButtonClick(Sender: TObject);
    procedure IB_Edit12ButtonClick(Sender: TObject);
    procedure IB_Edit13ButtonClick(Sender: TObject);
    procedure IB_Edit8Exit(Sender: TObject);
    procedure IB_Edit10Exit(Sender: TObject);
    procedure IB_Edit11Exit(Sender: TObject);
    procedure IB_Edit12Exit(Sender: TObject);
    procedure IB_Edit13Exit(Sender: TObject);
    procedure IB_Edit8KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit10KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit11KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit12KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit13KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menuden:Boolean;Sefer_ID, Sefer_SID: Integer; Islem : Byte): Boolean;
    procedure DataSet_Open(Sefer_ID, Sefer_SID: Integer; Islem : Byte);
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post(Kes_Kontrol:Boolean):Boolean;
    function Form_Before_Delete:Boolean;
    function OM_HAR_KAYDET(SIL:Boolean):Boolean;
    procedure IB_Edit3Exit(Sender: TObject);
    procedure txtSaticiKodButtonClick(Sender: TObject);
    procedure txtSaticiKodEnter(Sender: TObject);
    procedure IB_Edit27ButtonClick(Sender: TObject);
    procedure IB_Edit27Enter(Sender: TObject);
    procedure IB_Edit27Exit(Sender: TObject);
    procedure IB_Edit27KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit27KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit6ButtonClick(Sender: TObject);
    procedure IB_Edit6Enter(Sender: TObject);
    procedure IB_Edit6Exit(Sender: TObject);
    procedure IB_Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit6KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtArac_KodButtonClick(Sender: TObject);
    procedure txtArac_KodEnter(Sender: TObject);
    procedure txtArac_KodExit(Sender: TObject);
    procedure txtArac_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtArac_KodKeyPress(Sender: TObject; var Key: Char);
    procedure txtSaticiKodExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IB_Edit8Enter(Sender: TObject);
    procedure IB_Edit10Enter(Sender: TObject);
    procedure IB_Edit11Enter(Sender: TObject);
    procedure IB_Edit12Enter(Sender: TObject);
    procedure IB_Edit13Enter(Sender: TObject);
    procedure txtSaticiKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAliciKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Pg_SeferChange(Sender: TObject);
    procedure qryKontAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qryMazotAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dtsMazotDataChange(Sender: TIB_StatementLink;Statement: TIB_Statement; Field: TIB_Column);
    procedure dtsMazotStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qryMazotBeforePost(IB_Dataset: TIB_Dataset);
    procedure BtnMIptalClick(Sender: TObject);
    procedure BtnMSilClick(Sender: TObject);
    procedure BtnMYeniClick(Sender: TObject);
    procedure BtnMKaydetClick(Sender: TObject);
    procedure txtDorseButtonClick(Sender: TObject);
    procedure txtDorseExit(Sender: TObject);
    procedure txtDorseEnter(Sender: TObject);
    procedure txtDorseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtDorseKeyPress(Sender: TObject; var Key: Char);
    procedure Pg_SeferChanging(Sender: TObject; var AllowChange: Boolean);
    procedure qryKontBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryKontBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure IB_Edit3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit14ButtonClick(Sender: TObject);
    procedure IB_Edit14Exit(Sender: TObject);
    procedure IB_Edit14KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit14Enter(Sender: TObject);
    procedure txtAliciKodButtonClick(Sender: TObject);
    procedure txtAliciKodEnter(Sender: TObject);
    procedure txtAliciKodExit(Sender: TObject);
    procedure qrySeferBeforeEdit(IB_Dataset: TIB_Dataset);
    procedure BtnKont_SilClick(Sender: TObject);
    procedure qryMazotAfterPost(IB_Dataset: TIB_Dataset);
    procedure qryKontAfterPost(IB_Dataset: TIB_Dataset);
    procedure IB_CheckBox3Click(Sender: TObject);
    procedure BtnKont_IptalClick(Sender: TObject);
    procedure BtnKont_KaydetClick(Sender: TObject);
    procedure BtnKont_EkleClick(Sender: TObject);
    procedure dtsKontStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure IB_Edit5Enter(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure IB_Edit4Enter(Sender: TObject);
    procedure IB_Text10DblClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    PRV_ISN,prnSeferID,prnSeferSID:Integer;
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    prv_OlcuTip_Kontrol:Boolean;
    prv_OlcuBirim_Kontrol:Boolean;
    Eski_Sefer_Tamamlandi:Boolean;
    prv_Har_Say:Integer;
    Bekleme_Ilk_Giris:Boolean;
    function MForm_Before_Post: Boolean;
    function OM_HAR_KAYDET_MAZOT(SIL: Boolean): Boolean;
    procedure Geri_AL;
    function OM_HAR_KAYDET_SIL(Id, Sid: Integer): Boolean;
    function OM_HAR_KAYDET_MAZOT_SIL(Id, Sid: Integer): Boolean;
  public



    { Public declarations }
  end;

  const cns_Sefer = 36;

var
  frmSefer: TfrmSefer;

implementation

uses unDATAMOD, main, ufrmISN_ERRORS, ufrmCariSDLG,unFUNC,  ufrmKasaSDGL, unYazici, unLogger,
  ufrmSeferSDLG;

{$R *.dfm}

function  TfrmSefer.Form_Open(Menuden:Boolean;Sefer_ID, Sefer_SID: Integer; Islem : Byte): Boolean;
var
  local_can_update,local_can_delete:Boolean;
  qryDeg:TIB_Query;
begin
  if not DataMod.Modul_Hak(cns_sEFER,local_can_update,local_can_delete) then
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

    if not MainForm.FindChildFrm(Application, 'frmSefer') then
    begin
      Application.CreateForm(TfrmSefer,frmSefer);
      with frmSefer do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
        Pg_Sefer.ActivePage:=Ts_Sefer;
        
        DataSet_Open(Sefer_ID,Sefer_SID,Islem);


        DataMod.CreateQuery(qryDeg,trnSefer,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT CIK_YER FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            Cb_Cik_Yer.Items.Add(qryDeg.FieldByName('CIK_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT BIT_YER FROM SEFER';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            Cb_Bit_Yer.Items.Add(qryDeg.FieldByName('BIT_YER').asString);
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

procedure TfrmSefer.DataSet_Open(Sefer_ID, Sefer_SID: Integer; Islem : Byte);
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
  with frmSefer do
  begin
        {txtPERSONEL_KOD.Enabled:=False;
        IB_Text5.Enabled:=False;
        txtSaticiKod.Enabled:=False;
        IB_Text4.Enabled:=False;
        }
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
            txtArac_KodExit(txtArac_Kod);
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
    DataMod.Rapor_Kod_Visible_Fields_IB('SEFER',frmSefer.ib_edit8,frmSefer.ib_edit10,frmSefer.ib_edit11,frmSefer.ib_edit12,frmSefer.ib_edit13);

    with qryKont do
    begin
      Active := False;
      ParamByName('PRM_SEFER_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
      Active := True;
    end;

    qryESYA.Open;

    IB_Currency1.SetFocus;
  end;
end;


procedure TfrmSefer.qrySeferAfterInsert(IB_Dataset: TIB_Dataset);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin
  Bekleme_Ilk_Giris:=False;
  with qrySefer do
  begin
    FieldByName('SEFER_ID').AsInteger := qrySefer.Gen_ID('GEN_SEFER',1);

    if FieldByName('SEFER_ID').AsInteger=1999999 then
    FieldByName('SEFER_ID').AsInteger := qrySefer.Gen_ID('GEN_SEFER',1);

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

  end;
  IB_Currency1.SetFocus;
end;


procedure TfrmSefer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmSefer.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmSefer.Form_Post;
begin
  if not Form_Before_Post(False) then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
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

        with qryMazot do
        begin
          Active := False;
          ParamByName('PRM_SEFER_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
          Active := True;
        end;

        While not qryMazot.Eof Do
        begin

             if OM_HAR_KAYDET_MAZOT_SIL(qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger) = False then
             begin
               trnSefer.RollbackRetaining;
               dmLOGGER.dbaMain_CancelMonitoring;
               exit;
             end;

             qryMazot.Next;
        end;


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

    ////////////////////////////
    with qryMazot do
    begin
      Active := False;
      ParamByName('PRM_SEFER_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
      Active := True;
    end;

    qryMazot.First;
    While not qryMazot.Eof do
    begin
         if OM_HAR_KAYDET_MAZOT(False) = False then
         begin
           trnSefer.RollbackRetaining;
           dmLOGGER.dbaMain_CancelMonitoring;
           exit;
         end;
         qryMazot.Next;
    end;
    ////////////////////////////


    qrySefer.ApplyUpdates;
    qrySefer.CommitUpdates;
    qryMazot.ApplyUpdates;
    qryMazot.CommitUpdates;
    qryKont.ApplyUpdates;
    qryKont.CommitUpdates;
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
  btnYeni.SetFocus;
end;

procedure TfrmSefer.Form_Delete;
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

      with qryKont do
      begin
        Active := False;
        ParamByName('PRM_SEFER_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
        Active := True;
      end;

      with qryMazot do
      begin
        Active := False;
        ParamByName('PRM_SEFER_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
        //ParamByName('PRM_MAZOT_FIS_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
        Active := True;
      end;


      While not qryKont.Eof do
      begin
        qryKont.Delete;
        qryKont.First;
      end;

    ////////////////////////////
  if qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger>0 then
  if Application.MessageBox('Mazot Fiþlerinide Silmek Ýstiyor musunuz ?','Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDYES then
  begin
      While not qryMazot.Eof do
      begin

        if (qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1)  then
        begin
             qryMazot.Edit;
             qryMazot.FieldByName('SEFER_ID').AsInteger:=0;
             qryMazot.Post;
             qryMazot.Next;
             Continue;
        end
        else
        if OM_HAR_KAYDET_MAZOT(True) = False then
        begin
          trnSefer.RollbackRetaining;
          dmLOGGER.dbaMain_CancelMonitoring;
          Exit;
        end;

        if not (qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1)  then
        begin
          //Hareketleri Sil
          qryMazot.Delete;
          qryMazot.First;
        end;

      end;
  end
  else
  begin
      While not qryMazot.Eof do
      begin
        qryMazot.Edit;
        qryMazot.FieldByName('SEFER_ID').AsInteger:=0;
        qryMazot.Post;

        qryMazot.Next;
      end;
  end;
    ////////////////////////////

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

    qryMazot.ApplyUpdates;
    qryMazot.CommitUpdates;

    qryKont.ApplyUpdates;
    qryKont.CommitUpdates;

//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SEFER,MAZOT_FISI,SEFER_KONT,ARAC,ARACHAR,PERSONEL,PERSONEL_HAR,CARI,CARIHAR,',
                                             BT_SEFER,
                                             SEFER_ID,
                                             SEFER_SID,
                                             1,2,'SEFER');
//****************************************************************************//
    trnSefer.Commit;
  except
    trnSefer.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  qrySefer.Close;
end;

procedure TfrmSefer.btnIPTALClick(Sender: TObject);
begin
  case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO) of
  ID_YES:
    begin
      qrySefer.CancelUpdates;
      qrySefer.CommitUpdates;
      qryMazot.CancelUpdates;
      qryMazot.CommitUpdates;
      qryKont.CancelUpdates;
      qryKont.CommitUpdates;

//****************************************************************************//
      if trnSefer.InTransaction then
         trnSefer.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
      prnSeferID := 0;
      prnSeferSID := 0;
    end;
  end;//end case
end;

procedure TfrmSefer.dtsSeferStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
begin
  case ADataSet.State of
  dssEdit,dssInsert:
    begin
      btnYeni.Enabled := False;
      btnCikis.Enabled := False;
      btnAra.Enabled := False;
      if ADataSet.State <> dssEdit then
      begin
      btnSil.Enabled := False;
       Btn_Onceki.Enabled := False;
       Btn_Sonraki.Enabled := False;
      end
      else
      begin
      btnSil.Enabled := True;
       Btn_Onceki.Enabled := True;
       Btn_Sonraki.Enabled := True;
      end;
      btnKaydet.Enabled := True;
      btnIPTAL.Enabled := True;
    end;
    else
    begin
      btnYeni.Enabled := True;
      btnCikis.Enabled := true;
      btnAra.Enabled := True;
      btnSil.Enabled := False;
      btnKaydet.Enabled := False;
      btnIPTAL.Enabled := False;
       Btn_Onceki.Enabled := False;
       Btn_Sonraki.Enabled := False;
    end;
  end;
end;

procedure TfrmSefer.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSefer.dtsSeferDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
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
         if qrySefer.FieldByName('BEKLEME_FAT_VAR').AsInteger=1 then
         IB_Currency7.TabStop:=True
         else
         IB_Currency7.TabStop:=False;
    end;


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


  end;
end;

procedure TfrmSefer.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmSefer);
  with frmSefer.qrySefer do
  begin
    //FieldByName('ALICI_BORC_BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
    //FieldByName('ALICI_BORC').DisplayFormat := glb_DOV_KUR_PF;

    FieldByName('ALICI_BORC_BIRIM_FIY').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ALICI_BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('MIKTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALICI_BORC_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('SATICI_ALACAK_BIRIM_FIY').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('SATICI_ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('SATICI_ALACAK_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('BEKLEME_FAT_TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('BEKLEME_FAT_VPB').DisplayFormat := glb_VPB_FIELD_PF;
  end;

  with frmSefer.qryMazot do
  begin
    FieldByName('LITRE_FIYAT').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DOVKUR ').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    {
    //glb_DOV_FIELD_PF
    FieldByName('LITRE_FIYAT').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DOVKUR ').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    }
  end;

end;

procedure TfrmSefer.IB_Edit3ButtonClick(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    qryMazot.FieldByName('VEREN_PERSONEL_KOD').AsString := PERSONEL_KOD;
    qryMazot.FieldByName('VEREN_PERSONEL_ADI').AsString := PERSONEL_AD;
  end;
end;

procedure TfrmSefer.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmSefer.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmSefer.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmSefer.IB_Edit3Enter(Sender: TObject);
begin
  IB_Edit3.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmSefer.txtPERSONEL_KODExit(Sender: TObject);
var
  PERSONEL_AD:String;
begin
  txtPERSONEL_KOD.Color := clWindow;
  if Trim(txtPERSONEL_KOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',txtPERSONEL_KOD.Text,PERSONEL_AD) then
    begin
      qrySefer.FieldByName('PERSONEL_ADI').AsString := PERSONEL_AD
    end
    else
    begin
      txtPERSONEL_KOD.SetFocus;
    end
  end
  else
  begin
    qrySefer.FieldByName('PERSONEL_ADI').AsString := '';
  end;
end;

procedure TfrmSefer.txtPERSONEL_KODEnter(Sender: TObject);
begin
  txtPERSONEL_KOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.txtPERSONEL_KODButtonClick(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    qrySefer.FieldByName('PERSONEL_KOD').AsString := PERSONEL_KOD;
    qrySefer.FieldByName('PERSONEL_ADI').AsString := PERSONEL_AD;
  end;
end;

procedure TfrmSefer.txtPERSONEL_KODKeyDown(Sender: TObject;   var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtPERSONEL_KODButtonClick(Self);
end;

procedure TfrmSefer.txtPERSONEL_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmSefer.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmSefer.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Shift = [ssCtrl,ssShift,ssAlt] then
       if key=65 then Button1.Visible:=True;
       
case Pg_Sefer.ActivePageIndex of
0:begin
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
         if btnYeni.Enabled then btnYeniClick(Self);
       end;
    end;//acase end
  end; ///if Shift = [] then ENd
end;
1:begin

  if Shift = [ssCtrl] then
  begin
    case Key of
    83: //s kaydet
      begin
        if btnMKAYDET.Enabled Then btnMKAYDETClick(Self);
      end; //83 end
    80: //p iptal
      begin
        if btnMIptal.Enabled Then btnMIptalClick(Self);
      end;
    46: // del delete
      begin
        if btnMSIL.Enabled Then btnMSILClick(self);
      end;
    end; // case end;
  end//Shift = [ssCtrl] then end
  else
  if Shift = [] then
  begin
    case Key of
    45: //ins kaydet
       begin
         if btnMYeni.Enabled then btnMYeniClick(Self);
       end;
    end;//acase end
  end; ///if Shift = [] then ENd

end;
end;

end;

procedure TfrmSefer.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

function TfrmSefer.Form_Before_Delete: Boolean;
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
  (qrySefer.FieldByName('BEKLEME_FATURASI_KESILDI').AsInteger=1)
  then
  begin
      Application.MessageBox('Faturasý Kesilen Seferi Silemezsiniz','Dikkat',MB_ICONWARNING);
      exit;
  end;

  if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Exit;

  if qrySefer.State =DssEdit then
  qrySefer.Cancel;

  qrySefer.CancelUpdates;
  qryMazot.CancelUpdates;
  qryKont.CancelUpdates;

  qrySefer.ApplyUpdates;
  qryMazot.ApplyUpdates;
  qryKont.ApplyUpdates;



  Result := True;
end;


function TfrmSefer.Form_Before_Post(Kes_Kontrol:Boolean):Boolean;
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




  FuncDeger:=DataMod.Before_Post_Kontrol(qrySefer,'SEFER','SEFER_SAY,ALICI_BORC_BIRIM_FIY,ARAC_KOD,ARAC_PLAKA,ALICI_KOD,OLCU_TIP,OLCU_BIRIM,BAS_TAR','SEFER_ID');
  if  funcDeger<> '' Then
  begin
    ShowMessage(funcDeger);
    Exit;
  end;

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



         if (qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=3) or (qrySefer.FieldByName('FATURA_MIK_SEF').AsInteger=2) then
         begin
        if qrySefer.FieldByName('MIKTAR').AsInteger <=0 then
        begin
           Application.MessageBox('Miktar Giriniz.','Dikkat',MB_ICONWARNING);
           Exit;
        end;

         end;


//  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',txtArac_Kod.Text,OZ_MAL) then
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

      end;

      if OZ_MAL='0' then
      begin
         if Length(Trim(qrySefer.FieldByName('SATICI_KOD').AsString)) <= 0 then
         begin
           Application.MessageBox('Satýcý Kodu Seçiniz.','Dikkat',MB_ICONWARNING);
           Exit;;
        end;
        qrySefer.FieldByName('PERSONEL_KOD').AsString := '';
        qrySefer.FieldByName('PERSONEL_ADI').AsString := '';
      end;

  end;

  if qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger=1 then
  if qrySefer.FieldByName('BIT_TAR').AsVariant=null then
  begin
    Application.MessageBox('Sefer Biritiþ Tarihini Giriniz.','Dikkat',MB_ICONWARNING);
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


  if not DataMod.EN_GER_KAY_TAR_KONTROL(qrySefer.FieldByName('BAS_TAR').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('BAS_TAR').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('ALICI_B_DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('SATICI_A_DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qrySefer.FieldByName('BEKLEME_FAT_DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;

  Result := True;
end;



function TfrmSefer.OM_HAR_KAYDET(SIL:Boolean):Boolean;
var CARI_YON,PERSONEL_YON,ARAC_YON,ALICI_CARI_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    ARAC_SIL,PERSONEL_SIL,CARI_SIL:Byte;
begin
    CARI_YON := ALACAK;
    PERSONEL_YON := ALACAK;
    ARAC_YON:= ALACAK;

    ALICI_CARI_YON := BORC;
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




function TfrmSefer.OM_HAR_KAYDET_SIL(Id:Integer;Sid:Integer):Boolean;
var CARI_YON,PERSONEL_YON,ARAC_YON,ALICI_CARI_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    ARAC_SIL,PERSONEL_SIL,CARI_SIL:Byte;
    Qry:TIb_Query;
begin
    CARI_YON := ALACAK;
    PERSONEL_YON := ALACAK;
    ARAC_YON:= ALACAK;

    ALICI_CARI_YON := BORC;




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








function TfrmSefer.OM_HAR_KAYDET_MAZOT(SIL:Boolean):Boolean;
var CARI_YON,PERSONEL_YON,ARAC_YON,CARI_MAZOTCU_YON,VEREN_PERSONEL_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    ARAC_SIL,PERSONEL_SIL,CARI_SIL:Byte;

begin
    CARI_YON := BORC;
    PERSONEL_YON := BORC;
    ARAC_YON:= BORC;
    CARI_MAZOTCU_YON := ALACAK;
    VEREN_PERSONEL_YON := ALACAK;
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
    //Inc(prv_Har_Say);
    if not DataMod.CARIHAR_AUD(trnSefer,
                              BT_MAZOT_CARI,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
//                              prv_Har_Say,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('ALAN_CARI_KOD').AsString,
                              CARI_YON,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('DOV_BAZ_TAR').AsDate,
                              qryMazot.FieldbyName('TUTAR').AsCurrency,
                              qryMazot.FieldbyName('DOVKOD').AsString,
                              qryMazot.FieldbyName('DOVKUR').AsCurrency,
                              qryMazot.FieldbyName('TUTAR_VPB').AsCurrency,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('ACIKLAMA').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              qryMazot.FieldByName('MASRAF_MERK').AsString,
                              qryMazot.FieldByName('KOD1').AsString,
                              qryMazot.FieldByName('KOD2').AsString,
                              qryMazot.FieldByName('KOD3').AsString,
                              qryMazot.FieldByName('KOD4').AsString,
                              //qryMazot.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qryMazot.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;




//ESKÝ CARÝ HAREKETLERÝ SÝLÝNMESÝ ÝÇÝN
    if not DataMod.CARIHAR_AUD(trnSefer,
                              BT_MAZOT,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('ALAN_CARI_KOD').AsString,
                              CARI_YON,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('DOV_BAZ_TAR').AsDate,
                              qryMazot.FieldbyName('TUTAR').AsCurrency,
                              qryMazot.FieldbyName('DOVKOD').AsString,
                              qryMazot.FieldbyName('DOVKUR').AsCurrency,
                              qryMazot.FieldbyName('TUTAR_VPB').AsCurrency,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('ACIKLAMA').AsString,
                              1,
                              PRV_ISN,
                              qryMazot.FieldByName('MASRAF_MERK').AsString,
                              qryMazot.FieldByName('KOD1').AsString,
                              qryMazot.FieldByName('KOD2').AsString,
                              qryMazot.FieldByName('KOD3').AsString,
                              qryMazot.FieldByName('KOD4').AsString,
                              //qryMazot.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qryMazot.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;








      // MAZOTCU CARI HAREKET
    if SIL then
    begin
      CARI_SIL := 1
    end
    else
    begin
      CARI_SIL := 0;
    end;
    {if not DataMod.CARIHAR_AUD(trnMazot,
                              BT_MAZOT,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                              1,
                              qryMazot.FieldbyName('MAZOTCU_CARI_KOD').AsString,
                              CARI_MAZOTCU_YON,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('DOV_BAZ_TAR').AsDate,
                              qryMazot.FieldbyName('TUTAR').AsCurrency,
                              qryMazot.FieldbyName('DOVKOD').AsString,
                              qryMazot.FieldbyName('DOVKUR').AsCurrency,
                              qryMazot.FieldbyName('TUTAR_VPB').AsCurrency,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('ACIKLAMA').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              qryMazot.FieldByName('MASRAF_MERK').AsString,
                              qryMazot.FieldByName('KOD1').AsString,
                              qryMazot.FieldByName('KOD2').AsString,
                              qryMazot.FieldByName('KOD3').AsString,
                              qryMazot.FieldByName('KOD4').AsString,
                              //qryMazot.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qryMazot.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnMazot,PRV_ISN,0);
      Result := False;
      Exit;
    end;}


    if qryMazot.FieldbyName('ALIS_FATURASI_ALINDI').AsInteger=1 then
    CARI_SIL := 1;

    if not DataMod.MAZOTCU_CARI_HAR(CARI_SIL,CARI_MAZOTCU_YON,PRV_ISN,BT_MAZOT,qryMazot,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;



    //ARAC HAREKETÝ
    //  ARAC_SIL:=1 ;
    //  ARAC_SIL:=0;


    if SIL then
    begin
      ARAC_SIL := 1;
    end
    else
    begin
      ARAC_SIL := 0;
    end;

    if not DataMod.ARACHAR_AUD(trnSefer,
                               BT_MAZOT,
                               qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               1,
                               qryMazot.FieldbyName('ARAC_KOD').AsString,
                               ARAC_YON,
                               qryMazot.FieldbyName('TARIH').AsDate,
                               qryMazot.FieldbyName('DOV_BAZ_TAR').AsDate,
                               qryMazot.FieldbyName('TUTAR').AsCurrency,
                               qryMazot.FieldbyName('DOVKOD').AsString,
                               qryMazot.FieldbyName('DOVKUR').AsCurrency,
                               qryMazot.FieldbyName('TUTAR_VPB').AsCurrency,
                               qryMazot.FieldbyName('ACIKLAMA').AsString,
                               ARAC_SIL,
                               qryMazot.FieldByName('MASRAF_MERK').AsString,
                               qryMazot.FieldByName('KOD1').AsString,
                               qryMazot.FieldByName('KOD2').AsString,
                               qryMazot.FieldByName('KOD3').AsString,
                               qryMazot.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;





    //PERSONEL HAREKETÝ
    //  PERSONEL_SIL:=1 ;
      PERSONEL_SIL:=0;

    if SIL then
    begin
      PERSONEL_SIL := 1;
    end;

    if Trim(qryMazot.FieldbyName('ALAN_PERSONEL_KOD').AsString)='' then
    PERSONEL_SIL := 1;

    if not DataMod.PERSONELHAR_AUD(trnSefer,
                               BT_MAZOT,
                               qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               1,
                               qryMazot.FieldbyName('ALAN_PERSONEL_KOD').AsString,
                               PERSONEL_YON,
                               qryMazot.FieldbyName('TARIH').AsDate,
                               qryMazot.FieldbyName('DOV_BAZ_TAR').AsDate,
                               qryMazot.FieldbyName('TUTAR').AsCurrency,
                               qryMazot.FieldbyName('DOVKOD').AsString,
                               qryMazot.FieldbyName('DOVKUR').AsCurrency,
                               qryMazot.FieldbyName('TUTAR_VPB').AsCurrency,
                               qryMazot.FieldbyName('ACIKLAMA').AsString,
                               PERSONEL_SIL,
                               qryMazot.FieldByName('MASRAF_MERK').AsString,
                               qryMazot.FieldByName('KOD1').AsString,
                               qryMazot.FieldByName('KOD2').AsString,
                               qryMazot.FieldByName('KOD3').AsString,
                               qryMazot.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;





    //VEREN PERSONEL HAREKETÝ
    //  PERSONEL_SIL:=1 ;
      PERSONEL_SIL:=0;

    if SIL then
    begin
      PERSONEL_SIL := 1;
    end;


    if Trim(qryMazot.FieldbyName('VEREN_PERSONEL_KOD').AsString)='' then
    PERSONEL_SIL := 1;
    
    if not DataMod.PERSONELHAR_AUD(trnSefer,
                               BT_MAZOT,
                               qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               2,
                               qryMazot.FieldbyName('VEREN_PERSONEL_KOD').AsString,
                               VEREN_PERSONEL_YON,
                               qryMazot.FieldbyName('TARIH').AsDate,
                               qryMazot.FieldbyName('DOV_BAZ_TAR').AsDate,
                               qryMazot.FieldbyName('TUTAR').AsCurrency,
                               qryMazot.FieldbyName('DOVKOD').AsString,
                               qryMazot.FieldbyName('DOVKUR').AsCurrency,
                               qryMazot.FieldbyName('TUTAR_VPB').AsCurrency,
                               qryMazot.FieldbyName('ACIKLAMA').AsString,
                               PERSONEL_SIL,
                               qryMazot.FieldByName('MASRAF_MERK').AsString,
                               qryMazot.FieldByName('KOD1').AsString,
                               qryMazot.FieldByName('KOD2').AsString,
                               qryMazot.FieldByName('KOD3').AsString,
                               qryMazot.FieldByName('KOD4').AsString,
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













function TfrmSefer.OM_HAR_KAYDET_MAZOT_SIL(Id, Sid: Integer): Boolean;
var CARI_YON,PERSONEL_YON,ARAC_YON,CARI_MAZOTCU_YON,VEREN_PERSONEL_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    ARAC_SIL,PERSONEL_SIL,CARI_SIL:Byte;
    Qry:TIb_Query;
begin
    CARI_YON := BORC;
    PERSONEL_YON := BORC;
    ARAC_YON:= BORC;
    CARI_MAZOTCU_YON := ALACAK;
    VEREN_PERSONEL_YON := ALACAK;
  try

     DataMod.CreateQuery(Qry,nil,True,DataMod.dbaMain);
     Qry.Active:=False;
     Qry.SQL.Clear;
     Qry.SQL.Text:='SELECT * from MAZOT_FISI WHERE MAZOT_FIS_ID=:MAZOT_FIS_ID and MAZOT_FIS_SID=:MAZOT_FIS_SID';
     Qry.ParamByName('MAZOT_FIS_ID').AsInteger:=Id;
     Qry.ParamByName('MAZOT_FIS_SID').AsInteger:=Sid;
     Qry.Open;




      // CARI HAREKET

      CARI_SIL := 1;

    //Inc(prv_Har_Say);
    if Qry.FieldbyName('ALAN_CARI_KOD').AsString<>qryMazot.FieldbyName('ALAN_CARI_KOD').AsString then

    if not DataMod.CARIHAR_AUD(trnSefer,
                              BT_MAZOT,
                              Qry.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              Qry.FieldbyName('MAZOT_FIS_SID').AsInteger,
//                              prv_Har_Say,
                              Qry.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              Qry.FieldbyName('ALAN_CARI_KOD').AsString,
                              CARI_YON,
                              Qry.FieldbyName('TARIH').AsDate,
                              Qry.FieldbyName('TARIH').AsDate,
                              Qry.FieldbyName('DOV_BAZ_TAR').AsDate,
                              Qry.FieldbyName('TUTAR').AsCurrency,
                              Qry.FieldbyName('DOVKOD').AsString,
                              Qry.FieldbyName('DOVKUR').AsCurrency,
                              Qry.FieldbyName('TUTAR_VPB').AsCurrency,
                              Qry.FieldbyName('TARIH').AsDate,
                              Qry.FieldbyName('ACIKLAMA').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              Qry.FieldByName('MASRAF_MERK').AsString,
                              Qry.FieldByName('KOD1').AsString,
                              Qry.FieldByName('KOD2').AsString,
                              Qry.FieldByName('KOD3').AsString,
                              Qry.FieldByName('KOD4').AsString,
                              //qryMazot.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qryMazot.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;





      // MAZOTCU CARI HAREKET

      CARI_SIL := 1;

    {if not DataMod.CARIHAR_AUD(trnMazot,
                              BT_MAZOT,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                              1,
                              qryMazot.FieldbyName('MAZOTCU_CARI_KOD').AsString,
                              CARI_MAZOTCU_YON,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('DOV_BAZ_TAR').AsDate,
                              qryMazot.FieldbyName('TUTAR').AsCurrency,
                              qryMazot.FieldbyName('DOVKOD').AsString,
                              qryMazot.FieldbyName('DOVKUR').AsCurrency,
                              qryMazot.FieldbyName('TUTAR_VPB').AsCurrency,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('ACIKLAMA').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              qryMazot.FieldByName('MASRAF_MERK').AsString,
                              qryMazot.FieldByName('KOD1').AsString,
                              qryMazot.FieldByName('KOD2').AsString,
                              qryMazot.FieldByName('KOD3').AsString,
                              qryMazot.FieldByName('KOD4').AsString,
                              //qryMazot.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //qryMazot.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnMazot,PRV_ISN,0);
      Result := False;
      Exit;
    end;}




    if Qry.FieldbyName('MAZOTCU_CARI_KOD').AsString<>qryMazot.FieldbyName('MAZOTCU_CARI_KOD').AsString then

    if not DataMod.MAZOTCU_CARI_HAR(CARI_SIL,CARI_MAZOTCU_YON,PRV_ISN,BT_MAZOT,Qry,trnSefer) then
    begin
      frmISN_ERRORS.AnyErr(trnSefer,PRV_ISN,0);
      Result := False;
      Exit;
    end;



    //ARAC HAREKETÝ
      ARAC_SIL:=1 ;


    if Qry.FieldbyName('ARAC_KOD').AsString<>qryMazot.FieldbyName('ARAC_KOD').AsString then

    if not DataMod.ARACHAR_AUD(trnSefer,
                               BT_MAZOT,
                               Qry.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               Qry.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               1,
                               Qry.FieldbyName('ARAC_KOD').AsString,
                               ARAC_YON,
                               Qry.FieldbyName('TARIH').AsDate,
                               Qry.FieldbyName('DOV_BAZ_TAR').AsDate,
                               Qry.FieldbyName('TUTAR').AsCurrency,
                               Qry.FieldbyName('DOVKOD').AsString,
                               Qry.FieldbyName('DOVKUR').AsCurrency,
                               Qry.FieldbyName('TUTAR_VPB').AsCurrency,
                               Qry.FieldbyName('ACIKLAMA').AsString,
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





    //PERSONEL HAREKETÝ
      PERSONEL_SIL:=1 ;


    if Qry.FieldbyName('ALAN_PERSONEL_KOD').AsString<>qryMazot.FieldbyName('ALAN_PERSONEL_KOD').AsString then

    if not DataMod.PERSONELHAR_AUD(trnSefer,
                               BT_MAZOT,
                               Qry.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               Qry.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               1,
                               Qry.FieldbyName('ALAN_PERSONEL_KOD').AsString,
                               PERSONEL_YON,
                               Qry.FieldbyName('TARIH').AsDate,
                               Qry.FieldbyName('DOV_BAZ_TAR').AsDate,
                               Qry.FieldbyName('TUTAR').AsCurrency,
                               Qry.FieldbyName('DOVKOD').AsString,
                               Qry.FieldbyName('DOVKUR').AsCurrency,
                               Qry.FieldbyName('TUTAR_VPB').AsCurrency,
                               Qry.FieldbyName('ACIKLAMA').AsString,
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





    //VEREN PERSONEL HAREKETÝ
      PERSONEL_SIL:=1 ;


    if Qry.FieldbyName('VEREN_PERSONEL_KOD').AsString<>qryMazot.FieldbyName('VEREN_PERSONEL_KOD').AsString then

    if not DataMod.PERSONELHAR_AUD(trnSefer,
                               BT_MAZOT,
                               Qry.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               Qry.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               2,
                               Qry.FieldbyName('VEREN_PERSONEL_KOD').AsString,
                               VEREN_PERSONEL_YON,
                               Qry.FieldbyName('TARIH').AsDate,
                               Qry.FieldbyName('DOV_BAZ_TAR').AsDate,
                               Qry.FieldbyName('TUTAR').AsCurrency,
                               Qry.FieldbyName('DOVKOD').AsString,
                               Qry.FieldbyName('DOVKUR').AsCurrency,
                               Qry.FieldbyName('TUTAR_VPB').AsCurrency,
                               Qry.FieldbyName('ACIKLAMA').AsString,
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



procedure TfrmSefer.btnAraClick(Sender: TObject);
var
  Sefer_ID,Sefer_SID:Integer;
begin
  if frmSeferSDLG.Form_Open(False,Sefer_ID,Sefer_SID,False) then
  begin
    Dataset_Open(Sefer_ID,Sefer_SID,1);
  end;
end;

procedure TfrmSefer.IB_Edit8ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qrySefer.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmSefer.IB_Edit10ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qrySefer.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmSefer.IB_Edit11ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qrySefer.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmSefer.IB_Edit12ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qrySefer.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmSefer.IB_Edit13ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qrySefer.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmSefer.IB_Edit8Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit8.Text)) = 0 then
  begin
    IB_Edit8.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit8,nil,0) then
  begin
    IB_Edit8.Color := clWindow;
  end
  else
  begin
    IB_Edit8.SetFocus;
  end;
    IB_Edit8.Color := clWindow;
end;

procedure TfrmSefer.IB_Edit10Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit10.Text)) = 0 then
  begin
    IB_Edit10.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit10,nil,1) then
  begin
    IB_Edit10.Color := clWindow;
  end
  else
  begin
    IB_Edit10.SetFocus;
  end;
    IB_Edit10.Color := clWindow;
end;

procedure TfrmSefer.IB_Edit11Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit11.Text)) = 0 then
  begin
    IB_Edit11.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit11,nil,2) then
  begin
    IB_Edit11.Color := clWindow;
  end
  else
  begin
    IB_Edit11.SetFocus;
  end;
    IB_Edit11.Color := clWindow;
end;

procedure TfrmSefer.IB_Edit12Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit12.Text)) = 0 then
  begin
    IB_Edit12.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit12,nil,3) then
  begin
    IB_Edit12.Color := clWindow;
  end
  else
  begin
    IB_Edit12.SetFocus;
  end;
    IB_Edit12.Color := clWindow;
end;

procedure TfrmSefer.IB_Edit13Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit13.Text)) = 0 then
  begin
    IB_Edit13.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit13,nil,4) then
  begin
    IB_Edit13.Color := clWindow;
  end
  else
  begin
    IB_Edit13.SetFocus;
  end;
    IB_Edit13.Color := clWindow;
end;

procedure TfrmSefer.IB_Edit8KeyUp(Sender: TObject; var Key: Word;   Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure TfrmSefer.IB_Edit10KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure TfrmSefer.IB_Edit11KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure TfrmSefer.IB_Edit12KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure TfrmSefer.IB_Edit13KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;

procedure TfrmSefer.IB_Edit3Exit(Sender: TObject);
var
  PERSONEL_AD:String;
begin
  IB_Edit3.Color := clWindow;
  if Trim(IB_Edit3.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',IB_Edit3.Text,PERSONEL_AD) then
    begin
      qryMazot.FieldByName('VEREN_PERSONEL_ADI').AsString := PERSONEL_AD
    end
    else
    begin
      IB_Edit3.SetFocus;
    end
  end
  else
  begin
    qryMazot.FieldByName('VEREN_PERSONEL_ADI').AsString := '';
  end;


end;

procedure TfrmSefer.txtSaticiKodButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qrySefer.FieldByName('SATICI_KOD').AsString := Cari_KOD;
      qrySefer.FieldByName('SATICI_ADI').AsString := Cari_AD;
  end;
end;

procedure TfrmSefer.txtSaticiKodEnter(Sender: TObject);
begin
  txtSaticiKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.IB_Edit27ButtonClick(Sender: TObject);

var
  OlcuTip:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_OlcuTip (OlcuTip) then
  begin
    qrySefer.FieldByName('OLCU_TIP').AsString := OlcuTip;
  end;
end;

procedure TfrmSefer.IB_Edit27Enter(Sender: TObject);
begin
  IB_Edit27.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.IB_Edit27Exit(Sender: TObject);
begin
  IB_Edit27.Color := clWindow;
  if Trim(IB_Edit27.Text)<>'' then
  begin
    if prv_OlcuTip_Kontrol=True then
    begin
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT * FROM OLCUTIP WHERE OLCU_TIP = ' + SQL_Katar(qrySefer.FieldByName('OLCU_TIP').AsString));
        Active := True;
      end;
      if not ((DataMod.qryGENEL.Bof) and (DataMod.qryGENEL.Eof)) then
      begin
        prv_OlcuTip_Kontrol := False;
      end
      else
      begin
        prv_OlcuTip_Kontrol := True;
        IB_Edit27.SetFocus;
      end;
    end;
  end
  else
  begin
    prv_OlcuTip_Kontrol := True;
  end;
end;

procedure TfrmSefer.IB_Edit27KeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuTip_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSefer.IB_Edit27KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit27ButtonClick(Self);
end;

procedure TfrmSefer.IB_Edit6ButtonClick(Sender: TObject);
var
  Returned:Boolean;
  OlcuBir:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if qrySefer.FieldByName('OLCU_TIP').AsString='' Then
  begin
    Application.MessageBox('Ölçü tipi seçmediniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Returned := DataMod.LS_OlcuBrm(qrySefer.FieldByName('OLCU_TIP').AsString,OlcuBir);
  if not (Returned = False) then
  begin
    if not (qrySefer.State in [dssEdit,dssInsert]) then
    begin
      qrySefer.Edit;
    end;
    qrySefer.FieldByName('OLCU_BIRIM').AsString := OlcuBir;
  end;
end;

procedure TfrmSefer.IB_Edit6Enter(Sender: TObject);
begin
  IB_Edit6.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.IB_Edit6Exit(Sender: TObject);
begin
  IB_Edit6.Color := clWindow;
  if Trim(IB_Edit6.Text)<>'' then
  begin
    if prv_OlcuBirim_Kontrol=True then
    begin
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT * FROM OLCUBIR WHERE OLCU_TIP=' + SQL_Katar(qrySefer.FieldByName('OLCU_TIP').AsString)
              + ' AND OLCUBIRIM=' + SQL_Katar(qrySefer.FieldByName('OLCU_BIRIM').AsString));
        Active := True;
      end;
      if not ((DataMod.qryGENEL.Bof) and (DataMod.qryGENEL.Eof)) then
      begin
        prv_OlcuBirim_Kontrol := False;
      end
      else
      begin
        prv_OlcuBirim_Kontrol := True;
        IB_Edit6.SetFocus;
      end;
    end;
  end
  else
  begin
    prv_OlcuBirim_Kontrol := True;
  end;
end;

procedure TfrmSefer.IB_Edit6KeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuBirim_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSefer.IB_Edit6KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit6ButtonClick(Self);
end;

procedure TfrmSefer.txtArac_KodButtonClick(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      qrySefer.FieldByName('ARAC_PLAKA').AsString := PLAKA;
      qrySefer.FieldByName('ARAC_KOD').AsString := ARAC_KOD;

        qrySefer.FieldByName('DORSE_KOD').AsString := DORSE_KOD;
        txtDorse.Text:= DORSE_KOD;
        txtDorseExit(Self);

      if OZ_MAL=1 then
      begin
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

      end
      else
      begin
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
      end;
  end;
end;

procedure TfrmSefer.txtArac_KodEnter(Sender: TObject);
begin
  txtArac_Kod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.txtArac_KodExit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 SATICI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
begin
  if Trim(txtArac_Kod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PLAKA',txtArac_Kod.Text,PLAKA) then
    begin
      qrySefer.FieldByName('ARAC_PLAKA').AsString := PLAKA;

      if (qrySefer.State in [dssInsert]) then
      if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',txtArac_Kod.Text,OZ_MAL) then
      begin

         if OZ_MAL='1' then
         begin
            txtPERSONEL_KOD.Enabled:=True;
            IB_Text5.Enabled:=True;
            txtSaticiKod.Enabled:=False;
            IB_Text4.Enabled:=False;

            DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PERSONEL_KOD',txtArac_Kod.Text,PERSONEL_KOD);
            qrySefer.FieldByName('PERSONEL_KOD').AsString := PERSONEL_KOD;
            txtPERSONEL_KOD.Text:= PERSONEL_KOD;
            qrySefer.FieldByName('SATICI_KOD').AsString := '';
            qrySefer.FieldByName('SATICI_ADI').AsString := '';
            txtPERSONEL_KODExit(Self);
            GroupBox2.Enabled:=False;
         end
         else
         begin
            txtPERSONEL_KOD.Enabled:=False;
            IB_Text5.Enabled:=False;
            txtSaticiKod.Enabled:=True;
            IB_Text4.Enabled:=True;
            
            DataMod.FN_KOD2AD('ARAC','ARAC_KOD','CARI_KOD',txtArac_Kod.Text,SATICI_KOD);
            qrySefer.FieldByName('SATICI_KOD').AsString := SATICI_KOD;
            txtSaticiKod.Text:= SATICI_KOD;
            qrySefer.FieldByName('PERSONEL_KOD').AsString := '';
            qrySefer.FieldByName('PERSONEL_ADI').AsString := '';
            txtSaticiKodExit(Self);
            GroupBox2.Enabled:=True;
         end;

      end;

      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtArac_Kod.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qrySefer.FieldByName('ARAC_PLAKA').AsString := '';
  end;

end;

procedure TfrmSefer.txtArac_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtArac_KodButtonClick(Self);
end;

procedure TfrmSefer.txtArac_KodKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmSefer.txtSaticiKodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtSaticiKod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtSaticiKod.Text,CARI_AD) then
    begin
      qrySefer.FieldByName('SATICI_ADI').AsString := CARI_AD;
      if (Sender is TIB_Edit) then
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtSaticiKod.SetFocus;
    end;
  end
  else
  begin
     if (Sender is TIB_Edit) then
    (Sender as TIB_Edit).Color := clWindow;
    qrySefer.FieldByName('SATICI_ADI').AsString := '';
  end;

end;

procedure TfrmSefer.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
  cboDOVKOD1.Items.Assign(glb_DOV_LIST);
  cboDOVKOD2.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmSefer.IB_Edit8Enter(Sender: TObject);
begin
  IB_Edit8.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.IB_Edit10Enter(Sender: TObject);
begin
  IB_Edit10.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.IB_Edit11Enter(Sender: TObject);
begin
  IB_Edit11.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.IB_Edit12Enter(Sender: TObject);
begin
  IB_Edit12.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.IB_Edit13Enter(Sender: TObject);
begin
  IB_Edit13.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.txtSaticiKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtSaticiKodButtonClick(Self);
end;

procedure TfrmSefer.txtAliciKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtAliciKodButtonClick(Self);
end;

procedure TfrmSefer.Pg_SeferChange(Sender: TObject);
begin
    if Pg_Sefer.ActivePage = Ts_Mazot then
    begin
      {with qryKont do
      begin
        Active := False;
        ParamByName('PRM_SEFER_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
        Active := True;
      end;
      }

      with qryMazot do
      begin
        Active := False;
        ParamByName('PRM_SEFER_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
        //ParamByName('PRM_MAZOT_FIS_ID').AsInteger := qrySefer.FieldbyName('SEFER_ID').AsInteger;
        Active := True;
        //txtArac_KodExit(txtArac_Kod);
      end;
    end;
end;

procedure TfrmSefer.qryKontAfterInsert(IB_Dataset: TIB_Dataset);
begin
   qryKont.FieldByName('KONT_ID').AsInteger:= qryKont.Gen_ID('GEN_KONT',1);
   qryKont.FieldByName('SEFER_ID').AsInteger:= qrySefer.FieldByName('SEFER_ID').AsInteger;

end;

procedure TfrmSefer.qryMazotAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryMazot do
  begin
    FieldByName('MAZOT_FIS_ID').AsInteger := qryMazot.Gen_ID('GEN_MAZOT',1);
    FieldByName('MAZOT_FIS_SID').AsInteger := glb_SID;
    FieldByName('TARIH').AsDate := DataMod.GET_SERVER_DATE ;
    FieldByName('SAAT').AsDateTime := TIME ;
    FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('TARIH').AsDate;
    FieldByName('KM').AsInteger := 0;
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
    FieldByName('DOVKUR').AsCurrency := 1;

    FieldByName('ARAC_KOD').AsString := qrySefer.FieldByName('ARAC_KOD').AsString;
    FieldByName('ARAC_PLAKA').AsString := qrySefer.FieldByName('ARAC_PLAKA').AsString;
    FieldByName('ALAN_PERSONEL_KOD').AsString := qrySefer.FieldByName('PERSONEL_KOD').AsString;
    FieldByName('ALAN_PERSONEL_ADI').AsString := qrySefer.FieldByName('PERSONEL_ADI').AsString;
    FieldByName('ALAN_CARI_KOD').AsString :=  qrySefer.FieldByName('SATICI_KOD').AsString;;
    FieldByName('ALAN_CARI_ADI').AsString :=  qrySefer.FieldByName('SATICI_ADI').AsString;;

    FieldByName('SEFER_ID').AsInteger:= qrySefer.FieldByName('SEFER_ID').AsInteger;

    FieldByName('ALIS_FATURASI_ALINDI').AsInteger:= 0;
    FieldByName('ALIS_URUN_HAR_ID').AsInteger:= 0;
    
  end;
  {if not (qrySefer.State in [DssEdit,DssInsert]) then
  qrySefer.Edit;}
  IB_Edit15.SetFocus;

end;


function TfrmSefer.MForm_Before_Post:Boolean;
var
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



  if Trim(qryMazot.FieldByName('ARAC_KOD').AsString) = '' then
  begin
    //txtArac_Kod.SetFocus;
    Application.MessageBox('Mutlaka bir Araç belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if Trim(qryMazot.FieldByName('MAZOTCU_CARI_KOD').AsString) = '' then
  begin
    //txtSaticiKod.SetFocus;
    Application.MessageBox('Mutlaka bir Mazotçu belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',qryMazot.FieldByName('ARAC_KOD').AsString,OZ_MAL);
  if OZ_MAL='1' then
  begin
       if Trim(qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString) = '' then
       begin
         //txtAlanPersonel.SetFocus;
         Application.MessageBox('Mutlaka bir Alan Personel belirtmelisiniz.','Dikkat',MB_ICONWARNING);
         Exit;
       end;


       qryMazot.FieldByName('ALAN_CARI_KOD').AsString := '';
       qryMazot.FieldByName('ALAN_CARI_ADI').AsString := '';

  end;
  if OZ_MAL='0' then
  begin
       if Trim(qryMazot.FieldByName('ALAN_CARI_KOD').AsString) = '' then
       begin
         //txtAliciKod.SetFocus;
         Application.MessageBox('Mutlaka bir Alan Cari Kod belirtmelisiniz.','Dikkat',MB_ICONWARNING);
         Exit;
       end;

       qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := '';
       qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';

  end;


  if Trim(qryMazot.FieldByName('FIS_NO').AsString) = '' then
  begin
    //IB_Edit2.SetFocus;
    Application.MessageBox('Mutlaka bir Fiþ No belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  {if Trim(IB_Edit4.Text) = '' then
  begin
    IB_Edit4.SetFocus;
    Application.MessageBox('Mutlaka bir AÇIKLAMA belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  }
  if qryMazot.FieldByName('LITRE').AsCurrency <= 0 then
  begin
    Application.MessageBox('Litre deðeri sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if qryMazot.FieldByName('LITRE_FIYAT').AsCurrency <= 0 then
  begin
    Application.MessageBox('Litre Fiyatý deðeri sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if qryMazot.FieldByName('TUTAR').AsCurrency <= 0 then
  begin
    Application.MessageBox('Tutar deðeri sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if (qryMazot.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if (qryMazot.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryMazot.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryMazot.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryMazot.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;

  Result := True;
end;



procedure TfrmSefer.dtsMazotDataChange(Sender: TIB_StatementLink; Statement: TIB_Statement; Field: TIB_Column);
var
  Kur:Currency;
begin

  if  Assigned( Field ) Then
  begin
    {if Field.FieldName = 'LITRE' then
    begin
         if qryMazot.FieldByName('LITRE_FIYAT').AsCurrency>0 then
         qryMazot.FieldByName('TUTAR').AsCurrency:=
         qryMazot.FieldByName('LITRE_FIYAT').AsCurrency*
         qryMazot.FieldByName('LITRE').AsCurrency

    end;
    }

    if Field.FieldName = 'TUTAR' then
    begin
         //if qryMazot.FieldByName('LITRE_FIYAT').AsCurrency>0 then
         if (qryMazot.FieldByName('LITRE_FIYAT').AsCurrency>0) and (qryMazot.FieldByName('TUTAR').AsCurrency>0) then
         qryMazot.FieldByName('LITRE').AsCurrency:=
         Round(qryMazot.FieldByName('TUTAR').AsCurrency/
         qryMazot.FieldByName('LITRE_FIYAT').AsCurrency);
    end;

    if Field.FieldName = 'LITRE_FIYAT' then
    begin
         //if qryMazot.FieldByName('LITRE_FIYAT').AsCurrency>0 then
         if (qryMazot.FieldByName('LITRE_FIYAT').AsCurrency>0) and (qryMazot.FieldByName('TUTAR').AsCurrency>0) then
         qryMazot.FieldByName('LITRE').AsCurrency:=
         Round(qryMazot.FieldByName('TUTAR').AsCurrency/
         qryMazot.FieldByName('LITRE_FIYAT').AsCurrency);
    end;


    if Field.FieldName = 'DOVKOD' then
    begin
      KUR := DataMod.Get_Doviz_Kur(qryMazot.FieldByName('DOVKOD').AsString,qryMazot.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur <> 0 then qryMazot.FieldByName('DOVKUR').AsCurrency := Kur else qryMazot.FieldByName('DOVKUR').AsCurrency := 1;
    end;

    if (Field.FieldName = 'TUTAR') or (Field.FieldName = 'DOVKUR') then
    begin
      qryMazot.FieldByName('TUTAR_VPB').AsCurrency := qryMazot.FieldByName('TUTAR').AsCurrency * qryMazot.FieldByName('DOVKUR').AsCurrency ;
    end;
  end;

end;

procedure TfrmSefer.dtsMazotStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  case ADataSet.State of
  dssEdit,dssInsert:
    begin
      btnMYeni.Enabled := False;
      if ADataSet.State <> dssEdit then btnMSil.Enabled := False else btnMSil.Enabled := True;
      //btnMSil.Enabled := False
      btnMKaydet.Enabled := True;
      btnMIPTAL.Enabled := True;
    end;
    else
    begin
      btnMYeni.Enabled := True;
      btnMSil.Enabled := True;
      btnMKaydet.Enabled := False;
      btnMIPTAL.Enabled := False;
    end;
  end;

end;

procedure TfrmSefer.qryMazotBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not MForm_Before_Post then
  begin
      Abort;
  end;
end;

procedure TfrmSefer.BtnMIptalClick(Sender: TObject);
begin
     qryMazot.Cancel;
end;

procedure TfrmSefer.BtnMSilClick(Sender: TObject);
begin
  if (qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1)  then
  begin
     Application.MessageBox('Faturasý Kesilen Mazot Fiþini Silemezsiniz','Dikkat',MB_ICONWARNING);
     exit;
  end;
  
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Abort;
  if OM_HAR_KAYDET_MAZOT(True) = False then
  begin
    trnSefer.RollbackRetaining;
    Application.MessageBox('Silme Ýþleminde Hata Ýþlem Ýptal Edildi .','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  qryMazot.Delete;
end;

procedure TfrmSefer.BtnMYeniClick(Sender: TObject);
begin
     qryMazot.Append;
end;

procedure TfrmSefer.BtnMKaydetClick(Sender: TObject);
begin
  if (qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1)  then
  begin
    Application.MessageBox('Alýþ Faturasý Kesilmiþ Mazot Fiþinde Ýþlem Yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  qryMazot.Post;
  
  BtnMYeni.SetFocus;
     
end;

procedure TfrmSefer.txtDorseButtonClick(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String; 
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,' AND ARAC_TIP=2') Then
  begin
      qrySefer.FieldByName('DARAC_PLAKA').AsString := PLAKA;
      qrySefer.FieldByName('DORSE_KOD').AsString := ARAC_KOD;
  end;
end;

procedure TfrmSefer.txtDorseExit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 SATICI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
 Kissas:String;
begin
  Kissas:=' AND ARAC_TIP=2';
  if Trim(txtDorse.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD(Kissas,'ARAC','ARAC_KOD','PLAKA',txtDorse.Text,PLAKA) then
    begin
      qrySefer.FieldByName('DARAC_PLAKA').AsString := PLAKA;
      if (Sender is TIB_Edit) then
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtDorse.SetFocus;
    end;
  end
  else
  begin
     if (Sender is TIB_Edit) then
    (Sender as TIB_Edit).Color := clWindow;
    qrySefer.FieldByName('DARAC_PLAKA').AsString := '';
  end;
end;

procedure TfrmSefer.txtDorseEnter(Sender: TObject);
begin
  txtDorse.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.txtDorseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtDorseButtonClick(Self);
end;

procedure TfrmSefer.txtDorseKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmSefer.Pg_SeferChanging(Sender: TObject; var AllowChange: Boolean);
begin

  //{if not (qrySefer.State in [dssEdit,dssInsert]) Then
  if qrySefer.FieldByName('SEFER_ID').AsInteger<1 then
  begin
    AllowChange := False;
    Exit;
  end;

  if not Form_Before_Post(False) then
  begin
//      Application.MessageBox('Sefer bilgilerini tamamladýktan sonra diðer bölüme geçebilirsiniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
  end;

    if qryMazot.State in [dssEdit,dssInsert] Then
    begin
      Application.MessageBox('Mazot bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end;
    if qryKont.State in [dssEdit,dssInsert] Then
    begin
      Application.MessageBox('Konteynýr bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end;

  if not (qrySefer.State in [DssEdit,DssInsert]) then
  qrySefer.Edit;
end;

procedure TfrmSefer.qryKontBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryKont.FieldByName('KONT_NO').AsString) = '' then
  begin
    Application.MessageBox('Mutlaka konteynýr bilgisi girmelisiniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmSefer.qryKontBeforeDelete(IB_Dataset: TIB_Dataset);
begin
//  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Abort;
end;

procedure TfrmSefer.IB_Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then  IB_Edit3ButtonClick(Self);
end;

procedure TfrmSefer.IB_Edit14ButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,15) Then
  begin
      qryMazot.FieldByName('MAZOTCU_CARI_KOD').AsString := Cari_KOD;
      qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString := Cari_AD;
  end;
end;

procedure TfrmSefer.IB_Edit14Exit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(IB_Edit14.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',IB_Edit14.Text,CARI_AD) then
    begin
      qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString := CARI_AD;
      if (Sender is TIB_Edit) then
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      IB_Edit14.SetFocus;
    end;
  end
  else
  begin
     if (Sender is TIB_Edit) then
    (Sender as TIB_Edit).Color := clWindow;
    qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString := '';
  end;
end;

procedure TfrmSefer.IB_Edit14KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  IB_Edit14ButtonClick(Self);
end;

procedure TfrmSefer.IB_Edit14Enter(Sender: TObject);
begin
  IB_Edit14.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.txtAliciKodButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qrySefer.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qrySefer.FieldByName('ALICI_KOD').AsString := Cari_KOD;
      qrySefer.FieldByName('ALICI_ADI').AsString := Cari_AD;
  end;
end;

procedure TfrmSefer.txtAliciKodEnter(Sender: TObject);
begin
  txtAliciKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmSefer.txtAliciKodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtAliciKod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtAliciKod.Text,CARI_AD) then
    begin
      qrySefer.FieldByName('ALICI_ADI').AsString := CARI_AD;
      if (Sender is TIB_Edit) then
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtAliciKod.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TIB_Edit) then
    (Sender as TIB_Edit).Color := clWindow;
    qrySefer.FieldByName('ALICI_ADI').AsString := '';
  end;
end;

procedure TfrmSefer.qrySeferBeforeEdit(IB_Dataset: TIB_Dataset);
begin

if qrySefer.FieldByName('SEFER_TAMAMLANDI').AsInteger=1 then
Eski_Sefer_Tamamlandi:=True
else
Eski_Sefer_Tamamlandi:=False;
end;

procedure TfrmSefer.BtnKont_SilClick(Sender: TObject);
begin
  if not (qryKont.State in [DssEdit,DssInsert]) then
  if qryKont.FieldByName('KONT_ID').AsInteger>0 then
  qryKont.Delete;

end;

procedure TfrmSefer.qryMazotAfterPost(IB_Dataset: TIB_Dataset);
begin
{  if not (qrySefer.State in [DssEdit,DssInsert]) then
  qrySefer.Edit; }

end;

procedure TfrmSefer.qryKontAfterPost(IB_Dataset: TIB_Dataset);
begin
{  if not (qrySefer.State in [DssEdit,DssInsert]) then
  qrySefer.Edit;  }

end;

procedure TfrmSefer.IB_CheckBox3Click(Sender: TObject);
begin
     if Bekleme_Ilk_Giris then
     begin
          if qrySefer.FieldByName('BEKLEME_FAT_VAR').AsInteger=1 then
          IB_Currency7.TabStop:=False
          else
          IB_Currency7.TabStop:=True;
     end
     else
     Bekleme_Ilk_Giris:=True;
end;

procedure TfrmSefer.BtnKont_IptalClick(Sender: TObject);
begin
     qryKont.Cancel;
end;

procedure TfrmSefer.BtnKont_KaydetClick(Sender: TObject);
begin
     qryKont.Post;
end;

procedure TfrmSefer.BtnKont_EkleClick(Sender: TObject);
begin
     qryKont.Append;
end;

procedure TfrmSefer.dtsKontStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  case ADataSet.State of
  dssEdit,dssInsert:
    begin
      BtnKont_Ekle.Enabled := False;
      if ADataSet.State <> dssEdit then btnKont_Sil.Enabled := False else btnKont_Sil.Enabled := True;
      btnKont_Kaydet.Enabled := True;
      btnKont_IPTAL.Enabled := True;
    end;
    else
    begin
      BtnKont_Ekle.Enabled := True;
      btnKont_Sil.Enabled := False;
      btnKont_Kaydet.Enabled := False;
      btnKont_IPTAL.Enabled := False;
    end;
  end;
  if qrySefer.FieldByName('SEFER_ID').AsInteger<1 then
  begin
      BtnKont_Ekle.Enabled := False;
      btnKont_Sil.Enabled := False;
      btnKont_Kaydet.Enabled := False;
      btnKont_IPTAL.Enabled := False;

  end;


end;

procedure TfrmSefer.IB_Edit5Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
  if qrySefer.State in [DssEdit,DssInsert] then
  begin
    if Trim(qrySefer.FieldByName('SEFER_NOTLARI').AsString)='' then
    qrySefer.FieldByName('SEFER_NOTLARI').AsString:=
    qrySefer.FieldByName('CIK_YER').AsString + ' '+
    qrySefer.FieldByName('BIT_YER').AsString + ' '+
    qrySefer.FieldByName('TASINAN_ESYA').AsString;
  end;
end;

procedure TfrmSefer.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 SEFER_ID,SEFER_SID FROM SEFER WHERE SEFER_ID<:SEFER_ID AND SEFER_SID=:SEFER_SID ORDER BY SEFER_ID DESC';
     qryDeg1.ParamByName('SEFER_ID').AsInteger:=qrySefer.FieldByName('SEFER_ID').AsInteger;
     qryDeg1.ParamByName('SEFER_SID').AsInteger:=qrySefer.FieldByName('SEFER_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('SEFER_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('SEFER_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('SEFER_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;


procedure TfrmSefer.Geri_AL;
begin
     qryKont.CancelUpdates;
     qryMazot.CancelUpdates;
     qrySefer.CancelUpdates;
     qryKont.Close;
     qryMazot.Close;
     qrySefer.Close;

     trnSefer.Rollback;

end;

procedure TfrmSefer.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 SEFER_ID,SEFER_SID FROM SEFER WHERE SEFER_ID>:SEFER_ID AND SEFER_SID=:SEFER_SID ORDER BY SEFER_ID';
     qryDeg1.ParamByName('SEFER_ID').AsInteger:=qrySefer.FieldByName('SEFER_ID').AsInteger;
     qryDeg1.ParamByName('SEFER_SID').AsInteger:=qrySefer.FieldByName('SEFER_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('SEFER_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('SEFER_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('SEFER_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmSefer.Button1Click(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin

     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  SEFER_ID,SEFER_SID FROM SEFER ORDER BY SEFER_ID';
     qryDeg1.Open;
     While Not qryDeg1.Eof Do
     Begin

     if qryDeg1.FieldByName('SEFER_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('SEFER_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('SEFER_SID').AsInteger;
          DataSet_Open(Id,Sid,1);
          //txtArac_KodExit(txtArac_Kod);
          btnKaydetClick(Self);
     end;
         qryDeg1.Next;
     end;

     DataMod.ReleaseQuery(qryDeg1);


end;

procedure TfrmSefer.IB_Edit4Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
  if qryMazot.State in [DssEdit,DssInsert] then
  begin
    {if Trim(qryMazot.FieldByName('ACIKLAMA').AsString)='' then
    qryMazot.FieldByName('ACIKLAMA').AsString:=
    qryMazot.FieldByName('ARAC_PLAKA').AsString + ' nolu Araca  '+
    qryMazot.FieldByName('FIS_NO').AsString + ' nolu fiþ ile  '+
    qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString +' den Mazot Alýmý';
    }

    if Trim(qryMazot.FieldByName('ACIKLAMA').AsString)='' then
    qryMazot.FieldByName('ACIKLAMA').AsString:=
    qryMazot.FieldByName('ARAC_PLAKA').AsString + ' /  '+
    qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString +' / '+
    qryMazot.FieldByName('FIS_NO').AsString + ' ';


  end;
end;

procedure TfrmSefer.IB_Text10DblClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   a:Integer;
begin
     if (Sender as TIb_Text).Field.Value <>0 then
     begin
       try
       DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
       qryDeg1.Active:=False;
       qryDeg1.SQL.Clear;
       qryDeg1.SQL.Text:='SELECT BELGE_ID FROM URUNHAR WHERE URUNHAR_ID='+Inttostr((Sender as TIb_Text).Field.Value);
       qryDeg1.Open;
       a:=qryDeg1.FieldByName('BELGE_ID').AsInteger;
       qryDeg1.Active:=False;
       qryDeg1.SQL.Clear;
       qryDeg1.SQL.Text:='SELECT BELGE_NO FROM FAT_IRS WHERE FAT_IRS_ID='+Inttostr(a);
       qryDeg1.Open;

       Application.MessageBox(Pchar('Fatura No '+qryDeg1.FieldByName('BELGE_NO').AsString),'Dikkat',MB_ICONINFORMATION);
       finally
       DataMod.ReleaseQuery(qryDeg1);
       end;
     end;
end;

end.
