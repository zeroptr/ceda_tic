{$INCLUDE directive.inc}

unit ufrmUrunTanA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, IB_Components,
  IB_Controls, IB_Grid, Mask, Grids, Math;

type
  TfrmUrunTanA = class(TForm)
    pgUrun: TPageControl;
    tabUrun: TTabSheet;
    Panel1: TPanel;
    btnYeni: TBitBtn;                                           
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    tabUrunGrup: TTabSheet;
    tabFiyat: TTabSheet;
    qry_Urun: TIB_Query;
    dts_Urun: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit27: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_Edit20: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit16: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit15: TIB_Edit;
    IB_Edit26: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    IB_Memo1: TIB_Memo;
    IB_Edit7: TIB_Edit;
    qryBut_Urun_Grup: TIB_Query;
    qryUrun_Grup_Uye: TIB_Query;
    dtsBut_Urun_Grup: TIB_DataSource;
    dtsUrun_Grup_Uye: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    IB_Grid2: TIB_Grid;
    btnVarSay: TButton;
    btnUrunGroup: TButton;
    btnEkle: TButton;
    btnGSil: TButton;
    GroupBox1: TGroupBox;
    lblFiyCariAciklama: TLabel;
    IB_Grid4: TIB_Grid;
    IB_LookupCombo2: TIB_LookupCombo;
    btnCariFiyEkle: TButton;
    btnCariFiyDeg: TButton;
    btnCariFiySil: TButton;
    btnCariFiyKaydet: TButton;
    btnCariFiyIptal: TButton;
    qry_FiyCari: TIB_Query;
    qry_FiyCariDovKod: TIB_Query;
    dts_FiyCari: TIB_DataSource;
    dts_FiyCariDovKod: TIB_DataSource;
    GroupBox2: TGroupBox;
    lblFiyCGAciklama: TLabel;
    IB_Grid5: TIB_Grid;
    IB_LookupCombo3: TIB_LookupCombo;
    btnCGFiyEkle: TButton;
    btnCGFiyDeg: TButton;
    btnCGFiySil: TButton;
    btnCGFiyKaydet: TButton;
    btnCGFiyIptal: TButton;
    dts_FiyCGroup: TIB_DataSource;
    qry_FiyCGroup: TIB_Query;
    qry_FiyCGroupDovKod: TIB_Query;
    dts_FiyCGroupDovKod: TIB_DataSource;
    IB_Currency3: TIB_Currency;
    IB_Currency4: TIB_Currency;
    IB_Currency5: TIB_Currency;
    IB_Currency6: TIB_Currency;
    IB_Currency7: TIB_Currency;
    IB_Currency8: TIB_Currency;
    IB_CheckBox3: TIB_CheckBox;
    cboDOVKOD: TIB_ComboBox;
    tabTedarik: TTabSheet;
    qry_Urun_Tedarik: TIB_Query;
    dts_Urun_Tedarik: TIB_DataSource;
    IB_Grid3: TIB_Grid;
    Panel2: TPanel;
    IB_Edit24: TIB_Edit;
    IB_Edit25: TIB_Edit;
    IB_Edit28: TIB_Edit;
    txtCarikod: TIB_Edit;
    txtCARI_AD: TIB_Edit;
    btn_Te_Yeni: TButton;
    btn_Te_Kaydet: TButton;
    btn_Te_Iptal: TButton;
    btn_Te_Sil: TButton;
    IB_ComboBox1: TIB_ComboBox;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    IB_Currency9: TIB_Currency;
    IB_Currency10: TIB_Currency;
    StatusBar1: TStatusBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCikisClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qry_UrunAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dts_UrunStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure IB_Edit7ButtonClick(Sender: TObject);
    procedure IB_Edit7KeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit27ButtonClick(Sender: TObject);
    procedure IB_Edit8ButtonClick(Sender: TObject);
    procedure pgUrunChange(Sender: TObject);
    procedure pgUrunChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnEkleClick(Sender: TObject);
    procedure btnGSilClick(Sender: TObject);
    procedure btnVarSayClick(Sender: TObject);
    procedure btnCariFiyEkleClick(Sender: TObject);
    procedure qry_FiyCariAfterInsert(IB_Dataset: TIB_Dataset);
    procedure btnCariFiyDegClick(Sender: TObject);
    procedure btnCariFiySilClick(Sender: TObject);
    procedure btnCariFiyKaydetClick(Sender: TObject);
    procedure btnCariFiyIptalClick(Sender: TObject);
    procedure dts_FiyCariStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qry_FiyCariBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qry_FiyCariBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnCGFiyEkleClick(Sender: TObject);
    procedure qry_FiyCGroupAfterInsert(IB_Dataset: TIB_Dataset);
    procedure btnCGFiyDegClick(Sender: TObject);
    procedure btnCGFiySilClick(Sender: TObject);
    procedure btnCGFiyKaydetClick(Sender: TObject);
    procedure btnCGFiyIptalClick(Sender: TObject);
    procedure dts_FiyCGroupDovKodStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit7Enter(Sender: TObject);
    procedure IB_Edit27Enter(Sender: TObject);
    procedure IB_Edit27Exit(Sender: TObject);
    procedure IB_Edit8Enter(Sender: TObject);
    procedure IB_Edit8Exit(Sender: TObject);
    procedure IB_Memo1Enter(Sender: TObject);
    procedure IB_Memo1Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure qry_UrunBeforePost(IB_Dataset: TIB_Dataset);
    procedure qry_UrunBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure btnAraClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure IB_Edit7Exit(Sender: TObject);
    procedure IB_Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit27KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit27KeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure IB_Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit8KeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnUrunGroupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    function  Form_Before_Post:Boolean;
    function  Form_Before_Delete:Boolean;
    procedure DataSet_Grup_Open;
    function  Form_Open(Menu:Boolean;URUN_KOD:String;ISLEM:Byte):Boolean;
    procedure DataSet_Open(URUN_KOD:String;ISLEM:Byte);

    function  UrunNo(URUN_SAYAC:INTEGER):String;
    procedure txtCarikodButtonClick(Sender: TObject);
    procedure btn_Te_YeniClick(Sender: TObject);
    procedure btn_Te_KaydetClick(Sender: TObject);
    procedure btn_Te_IptalClick(Sender: TObject);
    procedure btn_Te_SilClick(Sender: TObject);
    procedure qry_Urun_TedarikAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dts_Urun_TedarikStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure txtCarikodKeyPress(Sender: TObject; var Key: Char);
    procedure txtCarikodExit(Sender: TObject);
    procedure txtCarikodKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtCarikodEnter(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_Depo_Kontrol,prv_OlcuTip_Kontrol,prv_OlcuBirim_Kontrol:Boolean;
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure DataSet_Tedarik_Open;
    procedure Geri_AL;
    //////////////////////////////
  public
    { Public declarations }
  end;
  
  const cns_urun_tan = 7;

var
  frmUrunTanA: TfrmUrunTanA;

implementation

uses main,unDataMod,unFunc, ufrmCariSDLG,ufrmUrunSDLG,ufrmUrunGroup,unLogger;

{$R *.dfm}

function TfrmUrunTanA.Form_Open(Menu:Boolean;URUN_KOD:String;ISLEM:Byte):Boolean;
var
  local_can_update,local_can_delete : Boolean;
begin
  Result := False;
  if not DataMod.Modul_Hak(cns_urun_tan,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM=0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    if MainForm.FindChildFrm( Application, 'frmUrunTanA') = False  then
    begin
      Application.CreateForm (TfrmUrunTanA,frmUrunTanA);
    end
    else
    begin
      Application.MessageBox('Ürün formu açýk.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    with frmUrunTanA do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      pgUrun.ActivePage := frmUrunTanA.tabUrun;
      DataSet_Open(URUN_KOD,ISLEM);
    end;
  end;
  Result := True;
end;

procedure TfrmUrunTanA.DataSet_Open(URUN_KOD:String;ISLEM:Byte);
begin
  if ((ISLEM=0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmUrunTanA.qry_Urun do
  begin
    Active:=False;
    ParamByName('PRM_URUN_KOD').AsString := URUN_KOD;
    Active := True;
  end;

  case ISLEM of
  0:// Yeni Kayýtta Yapýlacak iþlemler
    begin
      frmUrunTanA.qry_Urun.Insert;
    end;
  1:// Edit iþleminde Yapýlacak iþlemler
    begin

      if frmUrunTanA.qry_Urun.RecordCount <> 0 then
      begin
        frmUrunTanA.StatusBar1.Panels[0].Text := frmUrunTanA.qry_Urun.FieldByName('URUN_KOD').AsString;
        frmUrunTanA.StatusBar1.Panels[1].Text := frmUrunTanA.qry_Urun.FieldByName('URUN_AD').AsString;

        DataSet_Grup_Open;
        frmUrunTanA.StatusBar1.Panels[2].Text := frmUrunTanA.qryUrun_Grup_Uye.FieldByName('UGADI').AsString;

       // case Sign(frmCariKart.qryCari.FieldByName('BORC').AsCurrency - frmCariKart.qryCari.FieldByName('ALACAK').AsCurrency) of
        case Sign((frmUrunTanA.qry_Urun.FieldByName('BORC').AsCurrency+frmUrunTanA.qry_Urun.FieldByName('DEV_BORC').AsCurrency) - (frmUrunTanA.qry_Urun.FieldByName('ALACAK').AsCurrency+frmUrunTanA.qry_Urun.FieldByName('DEV_ALACAK').AsCurrency)) of
        0:
          begin
            with frmUrunTanA.StatusBar1 do
            begin
              Panels[4].Text := '';
              Panels[5].Text := '0';
            end;
          end;
        1:
          begin
            with frmUrunTanA.StatusBar1 do
            begin
              Panels[4].Text := BORC;
              Panels[5].Text := FormatFloat(glb_VPB_FIELD_PF,(frmUrunTanA.qry_Urun.FieldByName('BORC').AsCurrency+frmUrunTanA.qry_Urun.FieldByName('DEV_BORC').AsCurrency) - (frmUrunTanA.qry_Urun.FieldByName('ALACAK').AsCurrency+frmUrunTanA.qry_Urun.FieldByName('DEV_ALACAK').AsCurrency));
            end;
          end;
        -1:
          begin
            with frmUrunTanA.StatusBar1 do
            begin
              Panels[4].Text := ALACAK;
              Panels[5].Text := FormatFloat(glb_VPB_FIELD_PF,(frmUrunTanA.qry_Urun.FieldByName('ALACAK').AsCurrency+frmUrunTanA.qry_Urun.FieldByName('DEV_ALACAK').AsCurrency) - (frmUrunTanA.qry_Urun.FieldByName('BORC').AsCurrency+frmUrunTanA.qry_Urun.FieldByName('DEV_BORC').AsCurrency));
            end;
          end;
        end;//end case
      end;//end if frmCariKart.qryCari.RecordCount <> 0 then

    end;
  end; // case end;
  if DataMod.GetParam(8,'DEPO_UYG',0)= '0'  Then
  begin
//    frmUrunTanA.IB_Edit9.Enabled := False;
    frmUrunTanA.IB_Edit7.Enabled := False;
  end
  else
  begin
//    frmUrunTanA.IB_Edit9.Enabled := True;
    frmUrunTanA.IB_Edit7.Enabled := True;
  end;
end;

procedure TfrmUrunTanA.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmUrunTanA.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUrunTanA.FormCreate(Sender: TObject);
var
  UrunAlisDetayli,UrunSatisDetayli:Boolean;
begin
  DataMod.Form_Comp_Color(frmUrunTanA);
  {$IfDef TAM}
    pgUrun.Pages[3].TabVisible := True;
  {$Else}
    pgUrun.Pages[3].TabVisible := False;
  {$EndIf}
  if not glb_DEPO_UYG then
  begin
    IB_Edit7.visible := false;
    IB_Edit9.visible := false;
  end;

  with frmUrunTanA.qry_Urun do
  begin
    FieldByName('ASGARIMIK').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('AZAMIMIK').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('SIPMIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('BORC_VPB').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALACAK_VPB').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('MIKTAR_BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('MIKTAR_ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('BIRIMFIY').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('SATISFIY').DisplayFormat := glb_DOV_FIELD_PF;
  end;
  with frmUrunTanA.qry_FiyCari do
  begin
    FieldByName('SATISFIY').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmUrunTanA.qry_UrunAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_Urun do
  begin
    FieldByName('URUN_SID').AsInteger := glb_SID;
    FieldByName('KOMPLEX').AsInteger := 0;
    FieldByName('HIZMET').AsInteger := 0;
    FieldByName('KARMARJ').AsInteger := 0;
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
    FieldByName('TIP').AsSmallInt := 0 ;
    FieldByName('URUN_KOD').AsString := UrunNo(Int64(DataMod.GET_SAYAC_NUM('URUN',True,False,0)));
    FieldByName('DEPO_KOD').AsString := '' ;
    FieldByName('DEV_ALACAK').AsCurrency := 0;
    FieldByName('DEV_BORC').AsCurrency := 0;
    FieldByName('ALACAK').AsCurrency := 0;
    FieldByName('BORC').AsCurrency := 0;
    FieldByName('ALACAK_VPB').AsCurrency := 0;
    FieldByName('BORC_VPB').AsCurrency := 0;
    FieldByName('ASGARIMIK').AsCurrency := 0;
    FieldByName('AZAMIMIK').AsCurrency := 0;
    FieldByName('MIKTAR_BORC').AsCurrency := 0;
    FieldByName('MIKTAR_ALACAK').AsCurrency := 0;
    FieldByName('SIPMIKTAR').AsCurrency := 0;
    FieldByName('KDV_DAHIL').AsSmallint := 0 ;
    FieldByName('KDV').AsSmallInt := StrToInt(DataMod.GetParam(7,'KDV_ORAN',0));
    FieldByName('URUN_TIP').AsString := 'M' ;
  end;
  IB_Edit1.SetFocus;  
end;

function TfrmUrunTanA.UrunNo(URUN_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(URUN_SAYAC,TRIM(DataMod.GetParam(cns_urun_tan,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_urun_tan,'KOD_LENGTH',0)));
end;

procedure TfrmUrunTanA.dts_UrunStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if not ((ADataset.Eof) and (ADataset.Bof)) then
    begin
      btnSil.Enabled := True;
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;

    end
    else
    begin
      btnSil.Enabled := False;
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;

    end;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmUrunTanA.btnYeniClick(Sender: TObject);
begin
  DataSet_Open('',0);
end;

procedure TfrmUrunTanA.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Urun.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN,',0,0,0,0,1,'URUN');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmUrunTanA.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Urun.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN,',0,0,0,0,2,'URUN');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmUrunTanA.btnIPTALClick(Sender: TObject);
begin
  case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO) of
  6://yes
    begin
      qry_Urun.Cancel;
      dmLOGGER.dbaMain_CancelMonitoring;
    end;
  end;//end case
end;

procedure TfrmUrunTanA.IB_Edit7KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit7ButtonClick(Self);
end;

procedure TfrmUrunTanA.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmUrunTanA.IB_Edit27ButtonClick(Sender: TObject);
var
  OlcuTip:String;
begin
  if not (qry_Urun.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_OlcuTip (OlcuTip) then
  begin
    qry_Urun.FieldByName('OLCU_TIP').AsString := OlcuTip;
  end;
end;

procedure TfrmUrunTanA.IB_Edit8ButtonClick(Sender: TObject);
var
  Returned:Boolean;
  OlcuBir:String;
begin
  if not (qry_Urun.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if qry_Urun.FieldByName('OLCU_TIP').AsString='' Then
  begin
    Application.MessageBox('Ölçü tipi seçmediniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Returned := DataMod.LS_OlcuBrm(qry_Urun.FieldByName('OLCU_TIP').AsString,OlcuBir);
  if not (Returned = False) then
  begin
    if not (qry_Urun.State in [dssEdit,dssInsert]) then
    begin
      qry_Urun.Edit;
    end;
    qry_Urun.FieldByName('OLCUBIRIM').AsString := OlcuBir;
  end;
end;

procedure TfrmUrunTanA.DataSet_Grup_Open;
begin
  //sadece urun gruplarýnda kullanýlacak procedure
  with qryBut_Urun_Grup do
  begin
    Active := False;
    ParamByName('PRM_URUN_KOD').AsString := qry_Urun.FieldByName('URUN_KOD').AsString;
    Active := True;
  end;

  with qryUrun_Grup_Uye do
  begin
    Active := False;
    ParamByName('PRM_URUN_KOD').AsString := qry_Urun.FieldByName('URUN_KOD').AsString;
    Active := True;
  end;
end;

procedure TfrmUrunTanA.DataSet_Tedarik_Open;
begin
  //sadece urun gruplarýnda kullanýlacak procedure
  with qry_Urun_Tedarik do
  begin
    Active := False;
    ParamByName('PRM_URUN_KOD').AsString := qry_Urun.FieldByName('URUN_KOD').AsString;
    Active := True;
  end;
end;

procedure TfrmUrunTanA.pgUrunChange(Sender: TObject);
begin
  //sayfalara girer kene
  if pgUrun.ActivePage = tabUrunGrup Then
  begin
    DataSet_Grup_Open;
  end
  else
  if pgUrun.ActivePage = tabFiyat Then
  begin
    with qry_FiyCari do
    begin
      Active := False;
      ParamByName('PRM_URUN_KOD').AsString := IB_Edit1.Text;
      Active := True;
    end;
    qry_FiyCariDovKod.Active := True;
    with qry_FiyCGroup do
    begin
      Active := False;
      ParamByName('PRM_URUN_KOD').AsString:= IB_Edit1.Text;
      Active := True;
    end;
    qry_FiyCGroupDovKod.Active := True;
  end
  else
  if pgUrun.ActivePage = tabTedarik Then
  begin
    DataSet_Tedarik_Open;
  end

end;

procedure TfrmUrunTanA.pgUrunChanging(Sender: TObject; var AllowChange: Boolean);
begin
  //sayfalardan cýkarkene
  if pgUrun.ActivePage = tabUrun Then
  begin
    if qry_Urun.RecordCount = 0 then
    begin
      Application.MessageBox('Kayýt üzerinde deðilken diðer bölümlere geçemezsiniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
      exit;
    end;
    if Trim(IB_Edit1.Text) = '' then
    begin
      IB_Edit1.SetFocus;
      Application.MessageBox('Ürün bilgisi yok.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
      exit;
    end;
    if (dts_Urun.State in [dssEdit,dssInsert]) then
    begin
      Application.MessageBox('Yaptýðýnýz deðiþiklikleri kaydetmeden diðer bölümlere geçemezsiniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end;
  end
  else
  if pgUrun.ActivePage = tabUrunGrup Then
  begin
    if (qryUrun_Grup_Uye.RecordCount<>0) Then
    begin
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT COUNT(*) As VARSAYCOUNT FROM URUN_GRUP_UYE WHERE URUN_KOD = ' + SQL_Katar(qry_Urun.FieldByName('URUN_KOD').AsString) + ' AND VARSAY=1');
        Active := True;
      end;
      if (DataMod.qryGENEL.FieldByName('VARSAYCOUNT').AsInteger=0) then
      begin
        Application.MessageBox('Ürün Gruplarýndan En az Birini Varsayýlan Tanýmlamalýzýnýz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
      end
      else
      begin
        qryBut_Urun_Grup.Active := False;
        qryUrun_Grup_Uye.Active := False;
      end;
    end;
  end
  else
  if pgUrun.ActivePage = tabTedarik Then
  begin
    if qry_Urun_Tedarik.State in [dssEdit,dssInsert] Then
    begin
      Application.MessageBox('Tedarik bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end;
  end;
  if pgUrun.ActivePage <> tabTedarik Then
  qry_Urun_Tedarik.Active:=False;
end;

procedure TfrmUrunTanA.btnEkleClick(Sender: TObject);
var qryExecuter,Qry:TIB_Query;
begin
  if qryBut_Urun_Grup.RecordCount <> 0 then
  begin
    DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
    DataMod.CreateQuery(qry,Nil,False,DataMod.dbaMain);

    qry.Close;
    qry.SQL.Text:='Select Count(*) GELEN from URUN_GRUP_UYE where URUN_KOD=:URUN_KOD';
    qry.ParamByName('URUN_KOD').AsString:=qry_Urun.FieldByName('URUN_KOD').AsString;
    qry.Open;
    if qry.FieldByName('GELEN').AsInteger<=0 then
    begin

    qryExecuter.SQL.Add('INSERT INTO URUN_GRUP_UYE(URUN_GRUP_KOD,URUN_KOD,VARSAY) VALUES ('
              + SQL_Katar(qryBut_Urun_Grup.FieldByName('URUN_GRUP_KOD').AsString)
              + ','+ SQL_Katar(qry_Urun.FieldByName('URUN_KOD').AsString)+ ',1)');
    qryExecuter.Execute;

    end
    else
    begin
    qryExecuter.SQL.Add('INSERT INTO URUN_GRUP_UYE(URUN_GRUP_KOD,URUN_KOD,VARSAY) VALUES ('
              + SQL_Katar(qryBut_Urun_Grup.FieldByName('URUN_GRUP_KOD').AsString)
              + ','+ SQL_Katar(qry_Urun.FieldByName('URUN_KOD').AsString)+ ',0)');
    qryExecuter.Execute;
    end;

    dmLOGGER.Write2Log(0,0,0,0,1,qryExecuter.SQL.Text,'URUN_GRUP_UYE');
    DataSet_Grup_Open;
  end;

end;

procedure TfrmUrunTanA.btnGSilClick(Sender: TObject);
var qryExecuter:TIB_Query;
begin
  if qryUrun_Grup_Uye.RecordCount<>0 Then
  begin
    DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
    qryExecuter.SQL.Add('DELETE FROM URUN_GRUP_UYE WHERE URUN_KOD='+ SQL_Katar(qryUrun_Grup_Uye.FieldByName('URUN_KOD').AsString)
                      + ' AND URUN_GRUP_KOD = ' + SQL_Katar(qryUrun_Grup_Uye.FieldByName('URUN_GRUP_KOD').AsString));
    qryExecuter.Execute;
    dmLOGGER.Write2Log(0,0,0,0,2,qryExecuter.SQL.Text,'URUN_GRUP_UYE');
    DataSet_Grup_Open;
  end;
end;

procedure TfrmUrunTanA.btnVarSayClick(Sender: TObject);
var qryExecuter:TIB_Query;
begin
  DataMod.CreateQuery(qryExecuter,Nil,False,DataMod.dbaMain);
  with qryExecuter do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('UPDATE URUN_GRUP_UYE SET VARSAY=0 WHERE URUN_KOD='+ SQL_Katar(qryUrun_Grup_Uye.FieldByName('URUN_KOD').AsString));
    Execute;
    SQL.Clear;
    SQL.Add('UPDATE URUN_GRUP_UYE SET VARSAY=1 WHERE URUN_KOD='+SQL_Katar(qryUrun_Grup_Uye.FieldByName('URUN_KOD').AsString)
         +  ' AND URUN_GRUP_KOD = ' + SQL_Katar(qryUrun_Grup_Uye.FieldByName('URUN_GRUP_KOD').AsString));
    Execute;
  end;
  dmLOGGER.Write2Log(0,0,0,0,1,qryExecuter.SQL.Text,'URUN_GRUP_UYE');
  DataSet_Grup_Open;
end;

procedure TfrmUrunTanA.btnCariFiyEkleClick(Sender: TObject);
var
  Cari_Kod,Cari_Ad:String;
begin
  qry_FiyCari.Append;
  if frmCariSDLG.Form_Open(False,Cari_Kod,Cari_AD,2) Then
  begin
    qry_FiyCari.FieldByName('CARI_KOD').AsString := Cari_KOD;
    qry_FiyCari.FieldByName('CARI_AD').AsString := Cari_Ad;
  end;
end;

procedure TfrmUrunTanA.btnCariFiyKaydetClick(Sender: TObject);
begin
  try
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_FiyCari.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN_CARI_FIY,',0,0,0,0,1,'URUN_CARI_FIY');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmUrunTanA.btnCariFiySilClick(Sender: TObject);
begin
  try
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_FiyCari.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN_CARI_FIY,',0,0,0,0,2,'URUN_CARI_FIY');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmUrunTanA.btnCariFiyIptalClick(Sender: TObject);
begin
  qry_FiyCari.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmUrunTanA.qry_FiyCariAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_FiyCari do
  begin
    FieldByName('URUN_KOD').AsString := qry_Urun.FieldByName('URUN_KOD').AsString;
    FieldByName('SATISDOVKOD').AsString:= qry_Urun.FieldByName('DOVKOD').AsString;
    FieldByName('SATISFIY').AsCurrency := 0;
    FieldByName('BIRIMORAN').AsCurrency := 0;
  end;
end;

procedure TfrmUrunTanA.btnCariFiyDegClick(Sender: TObject);
begin
  qry_FiyCari.Edit;
end;



procedure TfrmUrunTanA.dts_FiyCariStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if dts_FiyCari.State in [dssEdit,dssInsert] Then
  begin
    btnCariFiyEkle.Enabled := False;
    btnCariFiyDeg.Enabled := False;
    btnCariFiySil.Enabled := False;
    btnCariFiyKaydet.Enabled := True;
    btnCariFiyIptal.Enabled := True;
  end
  else
  begin
    btnCariFiyEkle.Enabled := True;
    btnCariFiyDeg.Enabled := True;
    btnCariFiySil.Enabled := True;
    btnCariFiyKaydet.Enabled := False;
    btnCariFiyIptal.Enabled := False;
  end;
end;

procedure TfrmUrunTanA.qry_FiyCariBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
end;

procedure TfrmUrunTanA.qry_FiyCariBeforePost(IB_Dataset: TIB_Dataset);
var
  strSQL:String;
begin
  if qry_FiyCari.State in [dssInsert] then
  begin
    strSQL := 'SELECT * FROM URUN_CARI_FIY WHERE URUN_KOD= ' + SQL_Katar(qry_Urun.FieldByName('URUN_KOD').AsString)
            + ' AND CARI_KOD = ' + SQL_Katar(qry_FiyCari.FieldByName('CARI_KOD').AsString);
    with DataMod.qryGENEL Do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
      if not (EOF and BOF) Then
      begin
        Application.MessageBox('Cari Daha Önceden Eklenmiþ','Dikkat',MB_ICONWARNING);
        Abort;
      end;
    end;
  end
  else
  if qry_FiyCari.State in [dssedit] then
  begin
      /// Edit modunda edit edemiyo oldstring property ile kod yazýlcak
      ///
  end;
end;

procedure TfrmUrunTanA.btnCGFiyEkleClick(Sender: TObject);
var
  CG_KOD,CG_AD:String;
begin
  qry_FiyCGroup.Append;
  if DataMod.LS_CariGroup (CG_KOD,CG_AD) then
  begin
    qry_FiyCGroup.FieldByName('CARI_GRUP_KOD').AsString := CG_KOD;
    qry_FiyCGroup.FieldByName('CG_ADI').AsString := CG_AD;
  end;
end;

procedure TfrmUrunTanA.qry_FiyCGroupAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_FiyCGroup do
  begin
    FieldByName('URUN_KOD').AsString := qry_Urun.FieldByName('URUN_KOD').AsString;
    FieldByName('SATISDOVKOD').AsString:= qry_Urun.FieldByName('DOVKOD').AsString;
    FieldByName('SATISFIY').AsCurrency := 0 ;
    FieldByName('BIRIMORAN').AsCurrency := 0 ;
  end;
end;

procedure TfrmUrunTanA.btnCGFiyDegClick(Sender: TObject);
begin
  qry_FiyCGroup.Edit;
end;

procedure TfrmUrunTanA.btnCGFiySilClick(Sender: TObject);
begin
  qry_FiyCGroup.Delete;
end;

procedure TfrmUrunTanA.btnCGFiyKaydetClick(Sender: TObject);
begin
  qry_FiyCGroup.Post;
end;

procedure TfrmUrunTanA.btnCGFiyIptalClick(Sender: TObject);
begin
  qry_FiyCGroup.Cancel;
end;

procedure TfrmUrunTanA.dts_FiyCGroupDovKodStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if dts_FiyCGroup.State in [dssEdit,dssInsert] Then
  begin
    btnCGFiyEkle.Enabled := False;
    btnCGFiyDeg.Enabled := False;
    btnCGFiySil.Enabled := False;
    btnCGFiyKaydet.Enabled := True;
    btnCGFiyIptal.Enabled := True;
  end
  else
  begin
    btnCGFiyEkle.Enabled := True;
    btnCGFiyDeg.Enabled := True;
    btnCGFiySil.Enabled := True;
    btnCGFiyKaydet.Enabled := False;
    btnCGFiyIptal.Enabled := False;
  end;
end;

procedure TfrmUrunTanA.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmUrunTanA.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmUrunTanA.IB_Edit27Enter(Sender: TObject);
begin
  IB_Edit27.Color := glb_Art_Alan_Renk;
end;


procedure TfrmUrunTanA.IB_Edit8Enter(Sender: TObject);
begin
  IB_Edit8.Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrunTanA.IB_Edit8Exit(Sender: TObject);
begin
  IB_Edit8.Color := clWindow;
  if Trim(IB_Edit8.Text)<>'' then
  begin
    if prv_OlcuBirim_Kontrol=True then
    begin
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT * FROM OLCUBIR WHERE OLCU_TIP=' + SQL_Katar(qry_Urun.FieldByName('OLCU_TIP').AsString)
              + ' AND OLCUBIRIM=' + SQL_Katar(qry_Urun.FieldByName('OLCUBIRIM').AsString));
        Active := True;
      end;
      if not ((DataMod.qryGENEL.Bof) and (DataMod.qryGENEL.Eof)) then
      begin
        prv_OlcuBirim_Kontrol := False;
      end
      else
      begin
        prv_OlcuBirim_Kontrol := True;
        IB_Edit8.SetFocus;
      end;
    end;
  end
  else
  begin
    prv_OlcuBirim_Kontrol := True;
  end;
end;


procedure TfrmUrunTanA.IB_Memo1Enter(Sender: TObject);
begin
  IB_Memo1.Color:= glb_Art_Alan_Renk;
end;

procedure TfrmUrunTanA.IB_Memo1Exit(Sender: TObject);
begin
  IB_Memo1.Color := clWindow;
end;

procedure TfrmUrunTanA.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmUrunTanA.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if pgUrun.ActivePageIndex = 0 Then
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
          if btnYeni.Enabled then btnYeniClick(Self);
        end;
      end;//acase end
    end; ///if Shift = [] then ENd
  end;
  if key = VK_F6 then pgUrun.SelectNextPage(True);
end;

procedure TfrmUrunTanA.qry_UrunBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
  prm_StringList : TStringList;
  New_Value,Old_Value:String;
begin
  if not DataMod.Post_Update('URUN',qry_Urun.FieldByName('URUN_KOD').OldAsString,qry_Urun.FieldByName('URUN_KOD').AsString,Nil) then Abort;
end;

procedure TfrmUrunTanA.qry_UrunBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('URUN',qry_Urun.FieldByName('URUN_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
    {DataSet_Tedarik_Open;
    While Not qry_Urun_Tedarik.Eof Do
    Begin
         qry_Urun_Tedarik.Delete;
         qry_Urun_Tedarik.First;
    end; }

  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmUrunTanA.btnAraClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad:String;
begin
  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_Ad,False) then
  DataSet_Open(Urun_Kod,1);
end;

procedure TfrmUrunTanA.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  with qryUrun_Grup_Uye do
  begin
    Active := False;
    ParamByName('PRM_URUN_KOD').AsString := qry_Urun.FieldByName('URUN_KOD').AsString;
    Active := True;
  end;

  if (qryUrun_Grup_Uye.RecordCount<>0) then
  begin
    with DataMod.qryGENEL do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As VARSAYCOUNT FROM URUN_GRUP_UYE WHERE URUN_KOD=' + SQL_Katar(qry_Urun.FieldByName('URUN_KOD').AsString)
           +  ' AND VARSAY=1');
      Active := True;
    end;
    if (DataMod.qryGENEL.FieldByName('VARSAYCOUNT').AsInteger=0) then
    begin
      Application.MessageBox('Ürün Gruplarýndan En az Birini Varsayýlan Tanýmlamalýsýnýz.','Dikkat',MB_ICONWARNING);
      CanClose := False;
      exit;
    end;
  end;

  if qry_Urun.State in [dssEdit,dssInsert] Then
  begin
    Application.MessageBox('Yaptýðýnýz deðiþiklikleri Temel Ürün Bilgileri tabýnda kaydetmeli yada iptal etmelisiniz!!!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end;
end;


procedure TfrmUrunTanA.IB_Edit7ButtonClick(Sender: TObject);
var
  DEPO_KOD,DEPO_AD:String;
begin
  if not (qry_Urun.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) Then
  begin
    qry_Urun.FieldByName('DEPO_KOD').AsString := DEPO_KOD;
    qry_Urun.FieldByName('DEPO_ADI').AsString := DEPO_AD;
  end
  else
  begin
    qry_Urun.FieldByName('DEPO_KOD').AsString := '' ;
    qry_Urun.FieldByName('DEPO_ADI').AsString := '' ;
  end;
end;

procedure TfrmUrunTanA.IB_Edit7Enter(Sender: TObject);
begin
  IB_Edit7.Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrunTanA.IB_Edit7Exit(Sender: TObject);
var
  Depo_Ad:String;
begin
  ib_edit7.Color := clWindow;
  if Trim(IB_Edit7.Text)<>'' then
  begin
    if prv_Depo_Kontrol=True then
    begin
      if DataMod.FN_KOD2AD('DEPO','DEPO_KOD','ADI',qry_Urun.FieldByName('DEPO_KOD').AsString,Depo_Ad) Then
      begin
        qry_Urun.FieldByName('DEPO_ADI').AsString := Depo_Ad;
        prv_Depo_Kontrol := False;
      end
      else
      begin
        qry_Urun.FieldByName('DEPO_ADI').AsString := '';
        prv_Depo_Kontrol := True;
        IB_Edit7.SetFocus;
      end;
    end;
  end
  else
  begin
    qry_Urun.FieldByName('DEPO_ADI').AsString := '';
    prv_Depo_Kontrol := True;
  end;
end;

procedure TfrmUrunTanA.IB_Edit7KeyPress(Sender: TObject; var Key: Char);
begin
  prv_Depo_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmUrunTanA.IB_Edit27KeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuTip_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmUrunTanA.IB_Edit27Exit(Sender: TObject);
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
        SQL.Add('SELECT * FROM OLCUTIP WHERE OLCU_TIP = ' + SQL_Katar(qry_Urun.FieldByName('OLCU_TIP').AsString));
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

procedure TfrmUrunTanA.IB_Edit27KeyUp(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit27ButtonClick(Self);
end;

procedure TfrmUrunTanA.IB_Edit8KeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuBirim_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmUrunTanA.IB_Edit8KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit8ButtonClick(Self);
end;

procedure TfrmUrunTanA.btnUrunGroupClick(Sender: TObject);
begin
  frmUrunGroup.Form_Open(False);
  DataSet_Grup_Open;
end;


function TfrmUrunTanA.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmUrunTanA.Form_Before_Post: Boolean;
var
  qryKontrol : TIB_Query;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(IB_Edit1.Text) = '' then
  begin
    IB_Edit1.SetFocus;
    Application.MessageBox('Mutlaka bir ürün kodu girmelisiniz...','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

  if qry_Urun.State in [dssInsert] then
  begin
    DataMod.CreateQuery(qryKontrol,nil,False,DataMod.dbaMain);
    with qryKontrol do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT URUN_KOD FROM URUN WHERE URUN_KOD ='+SQL_Katar(qry_Urun.FieldByName('URUN_KOD').AsString));
      Open;
    end;
    if qryKontrol.RecordCount > 0 then
    begin
      Application.MessageBox('Bu ürün daha önceden tanýmlanmýþ lütfen ürün kodunu kontrol ediniz.','Dikkat',MB_ICONWARNING);
      DataMod.ReleaseQuery(qryKontrol);
      exit;
    end
    else
    begin
      DataMod.ReleaseQuery(qryKontrol);
    end;
  end;

  if Trim(qry_Urun.FieldByName('URUN_AD').AsString) = '' then
  begin
    IB_Edit2.SetFocus;
    Application.MessageBox('Mutlaka bir ürün adý girmelisiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(qry_Urun.FieldByName('OLCU_TIP').AsString) = '' then
  begin
    IB_Edit27.SetFocus;
    Application.MessageBox('Mutlaka bir ölçü tipi belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    IB_Edit27ButtonClick(Self);
    exit;
  end;

  if Trim(qry_Urun.FieldByName('OLCUBIRIM').AsString) = '' then
  begin
    IB_Edit8.SetFocus;
    Application.MessageBox('Mutlaka bir ölçü birimi belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    IB_Edit8ButtonClick(Self);
    exit;
  end;

  if Trim(qry_Urun.FieldByName('URUN_TIP').AsString) = '' then
  begin
    IB_Edit8.SetFocus;
    Application.MessageBox('Mutlaka bir ürün tipi belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    IB_Edit8ButtonClick(Self);
    exit;
  end;


   with DataMod.qryGENEL do
   begin
     Active := False;
     SQL.Clear;
     SQL.Add('SELECT * FROM OLCUBIR WHERE OLCU_TIP=' + SQL_Katar(qry_Urun.FieldByName('OLCU_TIP').AsString)
           + ' AND OLCUBIRIM=' + SQL_Katar(qry_Urun.FieldByName('OLCUBIRIM').AsString));
     Active := True;
   end;
   if (DataMod.qryGENEL.Bof) and (DataMod.qryGENEL.Eof) then
   begin
       Application.MessageBox('Ölçü Tipi ve Birimini Seçiniz','Dikkat',MB_ICONWARNING);
       exit;
   end;


  with qryUrun_Grup_Uye do
  begin
    Active := False;
    ParamByName('PRM_URUN_KOD').AsString := qry_Urun.FieldByName('URUN_KOD').AsString;
    Active := True;
  end;

  if (qryUrun_Grup_Uye.RecordCount<>0) then
  begin
    with DataMod.qryGENEL do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) As VARSAYCOUNT FROM URUN_GRUP_UYE WHERE URUN_KOD='
             + SQL_Katar(qry_Urun.FieldByName('URUN_KOD').AsString) + ' And VARSAY=1');
      Active := True;
    end;

    if (DataMod.qryGENEL.FieldByName('VARSAYCOUNT').AsInteger=0) then
    begin
      Application.MessageBox('Ürün Gruplarýndan En az Birini Varsayýlan Tanýmlamalýsýnýz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;

  Result := True;
end;

procedure TfrmUrunTanA.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmUrunTanA.cboDOVKODEnter(Sender: TObject);
begin
  cboDOVKOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrunTanA.cboDOVKODExit(Sender: TObject);
begin
  cboDOVKOD.Color := clWindow;
end;

procedure TfrmUrunTanA.txtCarikodButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qry_Urun_Tedarik.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qry_Urun_Tedarik.FieldByName('CARI_KOD').AsString := Cari_KOD;
      qry_Urun_Tedarik.FieldByName('CARI_ADI').AsString := Cari_AD;
  end;
end;

procedure TfrmUrunTanA.btn_Te_YeniClick(Sender: TObject);
begin
  qry_Urun_Tedarik.Insert;
end;

procedure TfrmUrunTanA.btn_Te_KaydetClick(Sender: TObject);
var
FuncDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_Urun_Tedarik,'URUN_TEDARIK','URUN_KOD,CARI_KOD','');
  if funcDeger<> '' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Exit;
  end;




  with DataMod.qryGENEL do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) As GELEN FROM URUN_TEDARIK WHERE URUN_KOD='
           + SQL_Katar(qry_Urun_Tedarik.FieldByName('URUN_KOD').AsString) + ' And CARI_KOD='
           + SQL_Katar(qry_Urun_Tedarik.FieldByName('CARI_KOD').AsString));
    Active := True;
  end;

  if qry_Urun_Tedarik.State = DssInsert then
  if (DataMod.qryGENEL.FieldByName('GELEN').AsInteger>0) then
  begin
    Application.MessageBox('Bu Cari Koddan Kayýt Yapýlmýþtýr. Farklý Bir Cari Kod Deneyiniz.','Dikkat',MB_ICONWARNING);
    txtCarikod.SetFocus;
    exit;
  end;

  if qry_Urun_Tedarik.State = DssEdit then
  begin
    if qry_Urun_Tedarik.FieldByName('CARI_KOD').OldAsString<>qry_Urun_Tedarik.FieldByName('CARI_KOD').AsString then
    if (DataMod.qryGENEL.FieldByName('GELEN').AsInteger>=1) then
    begin
      Application.MessageBox('Bu Cari Koddan Kayýt Yapýlmýþtýr. Farklý Bir Cari Kod Deneyiniz.','Dikkat',MB_ICONWARNING);
      txtCarikod.SetFocus;
      exit;
    end;
  end;

  try
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Urun_Tedarik.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log ( 'URUN_TEDARIK,',0,0,0,0,1,'URUN_TEDARIK');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmUrunTanA.btn_Te_IptalClick(Sender: TObject);
begin
  qry_Urun_Tedarik.Cancel;
end;

procedure TfrmUrunTanA.btn_Te_SilClick(Sender: TObject);
begin
  try
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
       qry_Urun_Tedarik.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('URUN_TEDARIK,',0,0,0,0,2,'URUN_TEDARIK');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmUrunTanA.qry_Urun_TedarikAfterInsert( IB_Dataset: TIB_Dataset);
begin
  with qry_Urun_Tedarik do
  begin
    FieldByName('URUN_KOD').AsString := qry_Urun.FieldByName('URUN_KOD').AsString;
    FieldByName('FIYAT').AsCurrency := 0;
    FieldByName('TEDARIK_SURESI').AsInteger := 0;
  end;
  txtCarikod.SetFocus;
end;

procedure TfrmUrunTanA.dts_Urun_TedarikStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btn_Te_Yeni.Enabled:=False;
    btn_Te_Sil.Enabled := False;
    btn_Te_Kaydet.Enabled := True;
    btn_Te_IPTAL.Enabled := True;
  end
  else
  begin
    btn_Te_Yeni.Enabled:=True;
    if not ((ADataset.Eof) and (ADataset.Bof)) then
    begin
      btn_Te_Sil.Enabled := True
    end
    else
    begin
      btn_Te_Sil.Enabled := False;
    end;
    btn_Te_Kaydet.Enabled := False;
    btn_Te_IPTAL.Enabled := False;
  end;

end;

procedure TfrmUrunTanA.txtCarikodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmUrunTanA.txtCarikodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCarikod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCarikod.Text,CARI_AD) then
    begin
      qry_Urun_Tedarik.FieldByName('CARI_ADI').AsString := CARI_AD;
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
    qry_Urun_Tedarik.FieldByName('CARI_ADI').AsString := '';
  end;

end;

procedure TfrmUrunTanA.txtCarikodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then txtCarikodButtonClick(Self);
end;

procedure TfrmUrunTanA.txtCarikodEnter(Sender: TObject);
begin
  txtCarikod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrunTanA.Geri_AL;
begin

     if qry_Urun.State in [DssEdit,DssInsert] then qry_Urun.Cancel;
     qryUrun_Grup_Uye.Close;
     qryBut_Urun_Grup.Close;
     qry_Urun_Tedarik.Close;
     qry_FiyCari.Close;
     qry_FiyCGroup.Close;
     qry_Urun.Close;

end;

procedure TfrmUrunTanA.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 URUN_KOD FROM URUN WHERE URUN_KOD<:URUN_KOD ORDER BY URUN_KOD DESC';
     qryDeg1.ParamByName('URUN_KOD').AsString:=qry_Urun.FieldByName('URUN_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('URUN_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('URUN_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmUrunTanA.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 URUN_KOD FROM URUN WHERE URUN_KOD>:URUN_KOD ORDER BY URUN_KOD';
     qryDeg1.ParamByName('URUN_KOD').AsString:=qry_Urun.FieldByName('URUN_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('URUN_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('URUN_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

end.
