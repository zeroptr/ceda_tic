unit ufrmMazot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Buttons, ExtCtrls, IB_Controls, Mask,
  Menus;

type
  TfrmMazot = class(TForm)
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    qryMazot: TIB_Query;
    dtsMazot: TIB_DataSource;
    trnMazot: TIB_Transaction;
    IB_Edit1: TIB_Edit;
    IB_Date1: TIB_Date;
    txtPERSONEL_KOD: TIB_Edit;
    IB_Edit5: TIB_Edit;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Text5: TIB_Text;
    IB_Currency7: TIB_Currency;
    IB_Currency8: TIB_Currency;
    txtArac_Kod: TIB_Edit;
    IB_Text1: TIB_Text;
    cboDOVKOD: TIB_ComboBox;
    IB_Date2: TIB_Date;
    txtAliciKod: TIB_Edit;
    IB_Text2: TIB_Text;
    txtSaticiKod: TIB_Edit;
    IB_Text4: TIB_Text;
    txtAlanPersonel: TIB_Edit;
    IB_Text3: TIB_Text;
    IB_Date4: TIB_Date;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_Currency3: TIB_Currency;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    IB_Text6: TIB_Text;
    Button1: TButton;
    procedure qryMazotAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure dtsMazotStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure dtsMazotDataChange(Sender: TIB_StatementLink; Statement: TIB_Statement; Field: TIB_Column);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure txtPERSONEL_KODExit(Sender: TObject);
    procedure txtPERSONEL_KODEnter(Sender: TObject);
    procedure txtPERSONEL_KODButtonClick(Sender: TObject);
    procedure txtPERSONEL_KODKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtPERSONEL_KODKeyPress(Sender: TObject; var Key: Char);
    procedure btnYeniClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    function Form_Open(Menuden:Boolean;Mazot_ID, Mazot_SID: Integer; Islem : Byte): Boolean;
    procedure DataSet_Open(Mazot_ID, Mazot_SID: Integer; Islem : Byte);
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    function OM_HAR_KAYDET(SIL:Boolean):Boolean;
    procedure txtSaticiKodButtonClick(Sender: TObject);
    procedure txtSaticiKodEnter(Sender: TObject);
    procedure txtArac_KodButtonClick(Sender: TObject);
    procedure txtArac_KodEnter(Sender: TObject);
    procedure txtArac_KodExit(Sender: TObject);
    procedure txtArac_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtArac_KodKeyPress(Sender: TObject; var Key: Char);
    procedure txtSaticiKodExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtAlanPersonelButtonClick(Sender: TObject);
    procedure txtAlanPersonelExit(Sender: TObject);
    procedure txtAlanPersonelEnter(Sender: TObject);
    procedure txtAlanPersonelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAlanPersonelKeyPress(Sender: TObject; var Key: Char);
    procedure txtAliciKodButtonClick(Sender: TObject);
    procedure txtAliciKodEnter(Sender: TObject);
    procedure txtAliciKodExit(Sender: TObject);
    procedure txtAliciKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtSaticiKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtAliciKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtSaticiKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit8Enter(Sender: TObject);
    procedure IB_Edit10Enter(Sender: TObject);
    procedure IB_Edit11Enter(Sender: TObject);
    procedure IB_Edit12Enter(Sender: TObject);
    procedure IB_Edit13Enter(Sender: TObject);
    procedure IB_Edit5Enter(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure IB_Text6DblClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    PRV_ISN,prnMAZOTID,prnMAZOTSID:Integer;
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    prv_OlcuTip_Kontrol:Boolean;
    prv_OlcuBirim_Kontrol:Boolean;
    procedure Geri_AL;
    function OM_HAR_KAYDET_SIL(Id:Integer;Sid:Integer):Boolean;
  public
    { Public declarations }
  end;

  const cns_Mazot = 37;

var
  frmMazot: TfrmMazot;

implementation

uses unDATAMOD, main, ufrmISN_ERRORS, ufrmCariSDLG,unFUNC,  ufrmKasaSDGL, unYazici, unLogger,
  ufrmMazotSDLG;

{$R *.dfm}

function  TfrmMazot.Form_Open(Menuden:Boolean; MAZOT_ID,MAZOT_SID: Integer; Islem : Byte): Boolean;
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Mazot,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((MAZOT_ID=0) and (MAZOT_SID=0) and (local_can_update=False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt hakkýnýz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;

    if not MainForm.FindChildFrm( Application, 'frmMazot') then
    begin
      Application.CreateForm(TfrmMazot,frmMazot);

      with frmMazot do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
        DataSet_Open(MAZOT_ID,MAZOT_SID,Islem);
        Result := True;
      end;
      
    end
    else
    begin
      Application.MessageBox('Mazot Fiþi formu açýk.','Dikkat',MB_ICONWARNING);
      Exit;
    end;

  end;
end;

procedure TfrmMazot.DataSet_Open(MAZOT_ID, MAZOT_SID: Integer; Islem : Byte);
{
  ISLEM
  0 : Yeni Kayýt
  1 : Edit
}
begin
  if ((MAZOT_ID=0) and (MAZOT_SID=0) and (prv_CanUpdate=False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt hakkýnýz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmMazot do
  begin
       { txtAlanPersonel.Enabled:=False;
        IB_Text3.Enabled:=False;
        txtAliciKod.Enabled:=False;
        IB_Text2.Enabled:=False;
        }
    PRV_ISN := DataMod.Get_Isn_Num;
    try
      case Islem of
      0:
        begin
          with qryMazot do
          begin
            ParamByName('PRM_MAZOT_FIS_ID').AsInteger := 0;
            ParamByName('PRM_MAZOT_FIS_SID').AsInteger := 0;
            Insert;
          end;
        end;
      1:
        begin
          with qryMazot do
          begin
            Active := False;
            ParamByName('PRM_MAZOT_FIS_ID').AsInteger := MAZOT_ID;
            ParamByName('PRM_MAZOT_FIS_SID').AsInteger := MAZOT_SID;
            Active := True;
            txtArac_KodExit(txtArac_Kod);
            Edit;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
          end;
          if qryMazot.RecordCount = 0 then
          begin
            Application.MessageBox('Kayýta ulaþýlamadý.','Dikkat',MB_ICONWARNING);
          end;
          prnMazotID := qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger;
          prnMazotSID := qryMazot.FieldByName('MAZOT_FIS_SID').AsInteger;
        end;
      end;//end case Islem of
    except
      Application.MessageBox('Veri Tabaný iþlemleri sýrasýnda Hata Oluþtu','Dikkat',MB_ICONWARNING);
      Close;
    end;
    DataMod.Rapor_Kod_Visible_Fields_IB('MAZOT',frmMazot.ib_edit8,frmMazot.ib_edit10,frmMazot.ib_edit11,frmMazot.ib_edit12,frmMazot.ib_edit13);
    txtArac_Kod.SetFocus;
  end;
end;


procedure TfrmMazot.qryMazotAfterInsert(IB_Dataset: TIB_Dataset);
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

    FieldByName('SEFER_ID').AsInteger:= 0;

    FieldByName('ALIS_FATURASI_ALINDI').AsInteger:= 0;
    FieldByName('ALIS_URUN_HAR_ID').AsInteger:= 0;
    FieldByName('SECIM').AsString := '0';

  end;
  txtArac_Kod.SetFocus;
end;


procedure TfrmMazot.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmMazot.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmMazot.Form_Post;
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if trnMazot.InTransaction then
     trnMazot.Rollback;
  trnMazot.StartTransaction;
//****************************************************************************//
  try
//****************************************************************************//
    prnMazotID := qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger;
    prnMazotSID := qryMazot.FieldByName('MAZOT_FIS_SID').AsSmallint;
//****************************************************************************//


/////////silme eklemeleri
    if (qryMazot.State in [dssEdit]) then 
       if OM_HAR_KAYDET_SIL(prnMazotID,prnMazotSID) = False then
       begin
         trnMazot.RollbackRetaining;
         dmLOGGER.dbaMain_CancelMonitoring;
         exit;
       end;
/////////silme eklemeleri son

    if OM_HAR_KAYDET(False) = False then
    begin
      trnMazot.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

//****************************************************************************//
    qryMazot.Post;
    qryMazot.ApplyUpdates;
    qryMazot.CommitUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('MAZOT_FISI,ARAC,ARACHAR,PERSONEL,PERSONEL_HAR,CARI,CARIHAR,',
                                             BT_MAZOT,
                                             qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger,
                                             qryMazot.FieldByName('MAZOT_FIS_SID').AsInteger,
                                             1,1,'MAZOT_FISI');
//****************************************************************************//
    trnMazot.Commit;
//****************************************************************************//

    prnMazotID := 0;
    prnMazotSID := 0;
//****************************************************************************//
  except
    trnMazot.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  qryMazot.Close;
  btnYeni.SetFocus;
end;

procedure TfrmMazot.Form_Delete;
var
  Mazot_ID,Mazot_SID : Integer;
begin
  if not Form_Before_Delete then exit;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if trnMazot.InTransaction then
     trnMazot.Rollback;
  trnMazot.StartTransaction;
//****************************************************************************//
  try
    //storedprocs
//****************************************************************************//
    if OM_HAR_KAYDET(True) = False then
    begin
      trnMazot.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;
//****************************************************************************//
    MAZOT_ID := qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger;
    MAZOT_SID := qryMazot.FieldByName('MAZOT_FIS_SID').AsInteger;
//****************************************************************************//
    qryMazot.Delete;
    qryMazot.ApplyUpdates;
    qryMazot.CommitUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('MAZOT_FISI,ARAC,ARACHAR,PERSONEL,PERSONEL_HAR,CARI,CARIHAR,',
                                             BT_MAZOT,
                                             MAZOT_ID,
                                             MAZOT_SID,
                                             1,2,'MAZOT_FISI');
//****************************************************************************//
    trnMazot.Commit;
  except
    trnMazot.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  qryMazot.Close;
end;

procedure TfrmMazot.btnIPTALClick(Sender: TObject);
begin
  case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO) of
  ID_YES:
    begin
      qryMazot.CancelUpdates;
      qryMazot.CommitUpdates;
//****************************************************************************//
      if trnMazot.InTransaction then
         trnMazot.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
      prnMazotID := 0;
      prnMazotSID := 0;
    end;
  end;//end case
end;

procedure TfrmMazot.dtsMazotStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;

      btnYeni.Enabled := True;
      btnCikis.Enabled := true;
      btnAra.Enabled := True;
      btnSil.Enabled := False;
      btnKaydet.Enabled := False;
      btnIPTAL.Enabled := False;
    end;
  end;
end;

procedure TfrmMazot.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMazot.dtsMazotDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
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


    {
    if Field.FieldName = 'LITRE_FIYAT' then
    begin
         if qryMazot.FieldByName('TUTAR').AsCurrency>0 then
         qryMazot.FieldByName('LITRE').AsCurrency:=
         Round(qryMazot.FieldByName('TUTAR').AsCurrency*
         qryMazot.FieldByName('LITRE_FIYAT').AsCurrency)
    end;
    }

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

procedure TfrmMazot.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmMazot);
  with frmMazot.qryMazot do
  begin
    FieldByName('LITRE_FIYAT').DisplayFormat := glb_DOV_KUR_PF;//glb_VPB_FIELD_PF;
    FieldByName('DOVKUR ').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR').DisplayFormat := glb_DOV_KUR_PF;//glb_DOV_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_DOV_KUR_PF;//glb_VPB_FIELD_PF;
    {
    //glb_DOV_FIELD_PF
    FieldByName('LITRE_FIYAT').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('DOVKUR ').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    }
  end;
end;

procedure TfrmMazot.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmMazot.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmMazot.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmMazot.txtPERSONEL_KODExit(Sender: TObject);
var
  PERSONEL_AD:String;
begin
  txtPERSONEL_KOD.Color := clWindow;
  if Trim(txtPERSONEL_KOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',txtPERSONEL_KOD.Text,PERSONEL_AD) then
    begin
      qryMazot.FieldByName('VEREN_PERSONEL_ADI').AsString := PERSONEL_AD
    end
    else
    begin
      txtPERSONEL_KOD.SetFocus;
    end
  end
  else
  begin
    qryMazot.FieldByName('VEREN_PERSONEL_ADI').AsString := '';
  end;
end;

procedure TfrmMazot.txtPERSONEL_KODEnter(Sender: TObject);
begin
  txtPERSONEL_KOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.txtPERSONEL_KODButtonClick(Sender: TObject);
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

procedure TfrmMazot.txtPERSONEL_KODKeyDown(Sender: TObject;   var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtPERSONEL_KODButtonClick(Self);
end;

procedure TfrmMazot.txtPERSONEL_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmMazot.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmMazot.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Shift = [ssCtrl,ssShift,ssAlt] then
       if key=65 then Button1.Visible:=True;

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

procedure TfrmMazot.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

function TfrmMazot.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryMazot.FieldByName('TARIH').AsDate,True) then Exit;

  if (qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1)  then
  begin
     Application.MessageBox('Faturasý Kesilen Mazot Fiþini Silemezsiniz','Dikkat',MB_ICONWARNING);
     exit;
  end;

  if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Exit;  


  if qryMazot.State =DssEdit then
  qryMazot.Cancel;

  qryMazot.CancelUpdates;
  qryMazot.ApplyUpdates;

  Result := True;
end;


function TfrmMazot.Form_Before_Post:Boolean;
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
 DORSE_KOD:String;
 FuncDeger:String;

begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if not DataMod.KAY_TAR_KONTROL(qryMazot.FieldByName('TARIH').AsDate,True) then Exit;


 { FuncDeger:=DataMod.Before_Post_Kontrol(qryMazot,'MAZOT_FISI','MAZOT_FIS_ID','FIS_NO');
  if funcDeger<> '' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Exit;
  end;
 }
 { if (qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1)  then
  begin
     Application.MessageBox('Faturasý Kesilen Mazot Fiþinin Üzerinde Deðiþiklik Yapamazsýnýz','Dikkat',MB_ICONWARNING);
     exit;
  end;
   }




  if Trim(qryMazot.FieldByName('ARAC_KOD').AsString) = '' then
  begin
    txtArac_Kod.SetFocus;
    Application.MessageBox('Mutlaka bir Araç belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if Trim(qryMazot.FieldByName('MAZOTCU_CARI_KOD').AsString) = '' then
  begin
    txtSaticiKod.SetFocus;
    Application.MessageBox('Mutlaka bir Mazotçu belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;


  DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',qryMazot.FieldByName('ARAC_KOD').AsString,OZ_MAL);
  if OZ_MAL='1' then
  begin
       if Trim(qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString) = '' then
       begin
         txtAlanPersonel.SetFocus;
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
         txtAliciKod.SetFocus;
         Application.MessageBox('Mutlaka bir Alan Cari Kod belirtmelisiniz.','Dikkat',MB_ICONWARNING);
         Exit;
       end;

       qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := '';
       qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';
  end;




  if Trim(qryMazot.FieldByName('FIS_NO').AsString) = '' then
  begin
    IB_Edit2.SetFocus;
    Application.MessageBox('Mutlaka bir Fiþ No belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;


  with DataMod.qryGENEL do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(MAZOTCU_CARI_KOD) AS MY_VALUE FROM MAZOT_FISI WHERE FIS_NO=:FIS_NO and MAZOTCU_CARI_KOD=:MAZOTCU_CARI_KOD');
    ParamByName('MAZOTCU_CARI_KOD').AsString:=qryMazot.FieldByName('MAZOTCU_CARI_KOD').AsString;
    ParamByName('FIS_NO').AsString:=qryMazot.FieldByName('FIS_NO').AsString;
    Active := True;
  end;

  if qryMazot.State =DssEdit then
  if qryMazot.FieldByName('FIS_NO').OldAsString<>qryMazot.FieldByName('FIS_NO').AsString then
  if DataMod.qryGENEL.FieldByName('MY_VALUE').AsInteger>=1  then
  begin
    Application.MessageBox('Daha önceden bu mazotçunun bu fiþ nosu girilmiþtir','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if qryMazot.State =DssInsert then
  if DataMod.qryGENEL.FieldByName('MY_VALUE').AsInteger>0  then
  begin
    Application.MessageBox('Daha önceden bu mazotçunun bu fiþ nosu girilmiþtir','Dikkat',MB_ICONWARNING);
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





  if qryMazot.State =DssEdit then
  if (qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsInteger=1) AND
  (qryMazot.FieldByName('MAZOTCU_CARI_KOD').AsString<>qryMazot.FieldByName('MAZOTCU_CARI_KOD').oldAsString)
  then
  begin
      Application.MessageBox('Faturasý Alýnýn Mazot Fiþini Mazotçu Kodunu Deðiþtiremezsiniz ','Dikkat',MB_ICONWARNING);
      exit;
  end;



  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryMazot.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryMazot.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryMazot.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;

  Result := True;
end;

function TfrmMazot.OM_HAR_KAYDET(SIL:Boolean):Boolean;
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


    if not DataMod.CARIHAR_AUD(trnMazot,
                              BT_MAZOT_CARI,
                              //BT_MAZOT,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('ALAN_CARI_KOD').AsString,
                              CARI_YON,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('TARIH').AsDate,
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
    end;

//ESKÝ CARÝ HAREKETLERÝ SÝLÝNMESÝ ÝÇÝN
    if not DataMod.CARIHAR_AUD(trnMazot,
                              BT_MAZOT,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                              qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              qryMazot.FieldbyName('ALAN_CARI_KOD').AsString,
                              CARI_YON,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('TARIH').AsDate,
                              qryMazot.FieldbyName('TARIH').AsDate,
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
      frmISN_ERRORS.AnyErr(trnMazot,PRV_ISN,0);
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


    if not DataMod.MAZOTCU_CARI_HAR(CARI_SIL,CARI_MAZOTCU_YON,PRV_ISN,BT_MAZOT,qryMazot,trnMazot) then
    begin
      frmISN_ERRORS.AnyErr(trnMazot,PRV_ISN,0);
      Result := False;
      Exit;
    end;



    //ARAC HAREKETÝ
    //  ARAC_SIL:=1;
    //  ARAC_SIL:=0;

    if SIL then
    begin
      ARAC_SIL := 1;
    end
    else
    begin
      ARAC_SIL := 0;
    end;

    if not DataMod.ARACHAR_AUD(trnMazot,
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
//      PERSONEL_SIL:=1 ;
      PERSONEL_SIL:=0;

    if SIL then
    begin
      PERSONEL_SIL := 1;
    end;

    if Trim(qryMazot.FieldbyName('ALAN_PERSONEL_KOD').AsString)='' then
    PERSONEL_SIL := 1;

    if not DataMod.PERSONELHAR_AUD(trnMazot,
                               BT_MAZOT,
                               qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               1,
                               qryMazot.FieldbyName('ALAN_PERSONEL_KOD').AsString,
                               BORC,
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
//      PERSONEL_SIL:=1 ;
      PERSONEL_SIL:=0;

    if SIL then
    begin
      PERSONEL_SIL := 1;
    end;


    if Trim(qryMazot.FieldbyName('VEREN_PERSONEL_KOD').AsString)='' then
    PERSONEL_SIL := 1;

    if not DataMod.PERSONELHAR_AUD(trnMazot,
                               BT_MAZOT,
                               qryMazot.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               qryMazot.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               2,
                               qryMazot.FieldbyName('VEREN_PERSONEL_KOD').AsString,
                               ALACAK,
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




function TfrmMazot.OM_HAR_KAYDET_SIL(Id:Integer;Sid:Integer):Boolean;
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


      CARI_SIL := 1;

    if Qry.FieldbyName('ALAN_CARI_KOD').AsString<>qryMazot.FieldbyName('ALAN_CARI_KOD').AsString then
    
    if not DataMod.CARIHAR_AUD(trnMazot,
                              BT_MAZOT,
                              Qry.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              Qry.FieldbyName('MAZOT_FIS_SID').AsInteger,
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
      frmISN_ERRORS.AnyErr(trnMazot,PRV_ISN,0);
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


    CARI_SIL := 1;

    if Qry.FieldbyName('MAZOTCU_CARI_KOD').AsString<>qryMazot.FieldbyName('MAZOTCU_CARI_KOD').AsString then

    if not DataMod.MAZOTCU_CARI_HAR(CARI_SIL,CARI_MAZOTCU_YON,PRV_ISN,BT_MAZOT,Qry,trnMazot) then
    begin
      frmISN_ERRORS.AnyErr(trnMazot,PRV_ISN,0);
      Result := False;
      Exit;
    end;



    //ARAC HAREKETÝ
    //  ARAC_SIL:=1;
    //  ARAC_SIL:=0;

      ARAC_SIL := 1;


    if Qry.FieldbyName('ARAC_KOD').AsString<>qryMazot.FieldbyName('ARAC_KOD').AsString then

    if not DataMod.ARACHAR_AUD(trnMazot,
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
//      PERSONEL_SIL:=1 ;
    PERSONEL_SIL := 1;

    if Qry.FieldbyName('ALAN_PERSONEL_KOD').AsString<>qryMazot.FieldbyName('ALAN_PERSONEL_KOD').AsString then

    if not DataMod.PERSONELHAR_AUD(trnMazot,
                               BT_MAZOT,
                               Qry.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               Qry.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               1,
                               Qry.FieldbyName('ALAN_PERSONEL_KOD').AsString,
                               BORC,
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
//      PERSONEL_SIL:=1 ;
    PERSONEL_SIL := 1;

    if Qry.FieldbyName('VEREN_PERSONEL_KOD').AsString<>qryMazot.FieldbyName('VEREN_PERSONEL_KOD').AsString then

    if not DataMod.PERSONELHAR_AUD(trnMazot,
                               BT_MAZOT,
                               Qry.FieldbyName('MAZOT_FIS_ID').AsInteger,
                               Qry.FieldbyName('MAZOT_FIS_SID').AsInteger,
                               2,
                               Qry.FieldbyName('VEREN_PERSONEL_KOD').AsString,
                               ALACAK,
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


procedure TfrmMazot.btnAraClick(Sender: TObject);
var
  Mazot_ID,Mazot_SID:Integer;
begin
  if frmMazotSDLG.Form_Open(False,Mazot_ID,Mazot_SID,False) then
  begin
    Dataset_Open(Mazot_ID,Mazot_SID,1);
  end;
end;

procedure TfrmMazot.IB_Edit8ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qryMazot.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmMazot.IB_Edit10ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qryMazot.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmMazot.IB_Edit11ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qryMazot.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmMazot.IB_Edit12ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qryMazot.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmMazot.IB_Edit13ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qryMazot.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmMazot.IB_Edit8Exit(Sender: TObject);
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

procedure TfrmMazot.IB_Edit10Exit(Sender: TObject);
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

procedure TfrmMazot.IB_Edit11Exit(Sender: TObject);
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

procedure TfrmMazot.IB_Edit12Exit(Sender: TObject);
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

procedure TfrmMazot.IB_Edit13Exit(Sender: TObject);
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

procedure TfrmMazot.IB_Edit8KeyUp(Sender: TObject; var Key: Word;   Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure TfrmMazot.IB_Edit10KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure TfrmMazot.IB_Edit11KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure TfrmMazot.IB_Edit12KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure TfrmMazot.IB_Edit13KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;

procedure TfrmMazot.txtSaticiKodButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qryMazot.FieldByName('MAZOTCU_CARI_KOD').AsString := Cari_KOD;
      qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString := Cari_AD;
  end;
end;

procedure TfrmMazot.txtSaticiKodEnter(Sender: TObject);
begin
  txtSaticiKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.txtArac_KodButtonClick(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      qryMazot.FieldByName('ARAC_PLAKA').AsString := PLAKA;
      qryMazot.FieldByName('ARAC_KOD').AsString := ARAC_KOD;
      if OZ_MAL=1 then
      begin
        txtAlanPersonel.Enabled:=True;
        IB_Text3.Enabled:=True;
        txtAliciKod.Enabled:=False;
        IB_Text2.Enabled:=False;

        qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := PERSONEL_KOD;
        txtAlanPersonel.Text:= PERSONEL_KOD;
        qryMazot.FieldByName('ALAN_CARI_KOD').AsString := '';
        qryMazot.FieldByName('ALAN_CARI_ADI').AsString := '';
        txtAlanPersonelExit(Self);
      end
      else
      begin
        txtAlanPersonel.Enabled:=False;
        IB_Text3.Enabled:=False;
        txtAliciKod.Enabled:=True;
        IB_Text2.Enabled:=True;

        qryMazot.FieldByName('ALAN_CARI_KOD').AsString := CARI_KOD;
        txtAliciKod.Text:= CARI_KOD;        
        qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := '';
        qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';
        txtAliciKodExit(Self);
      end;
  end;
end;

procedure TfrmMazot.txtArac_KodEnter(Sender: TObject);
begin
  txtArac_Kod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.txtArac_KodExit(Sender: TObject);
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
      qryMazot.FieldByName('ARAC_PLAKA').AsString := PLAKA;

      if (qryMazot.State in [dssInsert]) then
      if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',txtArac_Kod.Text,OZ_MAL) then
      begin

         if OZ_MAL='1' then
         begin
            txtAlanPersonel.Enabled:=True;
            IB_Text3.Enabled:=True;
            txtAliciKod.Enabled:=False;
            IB_Text2.Enabled:=False;

            DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PERSONEL_KOD',txtArac_Kod.Text,PERSONEL_KOD);
            qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := PERSONEL_KOD;
            txtAlanPersonel.Text:= PERSONEL_KOD;
            qryMazot.FieldByName('ALAN_CARI_KOD').AsString := '';
            qryMazot.FieldByName('ALAN_CARI_ADI').AsString := '';
            txtAlanPersonelExit(Self);

         end
         else
         begin
            txtAlanPersonel.Enabled:=False;
            IB_Text3.Enabled:=False;
            txtAliciKod.Enabled:=True;
            IB_Text2.Enabled:=True;
            
            DataMod.FN_KOD2AD('ARAC','ARAC_KOD','CARI_KOD',txtArac_Kod.Text,SATICI_KOD);
            qryMazot.FieldByName('ALAN_CARI_KOD').AsString := SATICI_KOD;
            txtAliciKod.Text:= SATICI_KOD;
            qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := '';
            qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';
            txtAliciKodExit(Self);
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
    qryMazot.FieldByName('ARAC_PLAKA').AsString := '';
  end;
end;

procedure TfrmMazot.txtArac_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtArac_KodButtonClick(Self);
end;

procedure TfrmMazot.txtArac_KodKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmMazot.txtSaticiKodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtSaticiKod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtSaticiKod.Text,CARI_AD) then
    begin
      qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString := CARI_AD;
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
    qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString := '';
  end;
end;

procedure TfrmMazot.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmMazot.txtAlanPersonelButtonClick(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString := PERSONEL_KOD;
    qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := PERSONEL_AD;
  end;
end;

procedure TfrmMazot.txtAlanPersonelExit(Sender: TObject);
var
  PERSONEL_AD:String;
begin
  txtAlanPersonel.Color := clWindow;
  if Trim(txtAlanPersonel.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',txtAlanPersonel.Text,PERSONEL_AD) then
    begin
      qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := PERSONEL_AD
    end
    else
    begin
      txtAlanPersonel.SetFocus;
    end
  end
  else
  begin
    qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString := '';
  end;
end;

procedure TfrmMazot.txtAlanPersonelEnter(Sender: TObject);
begin
  txtAlanPersonel.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.txtAlanPersonelKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtAlanPersonelButtonClick(Self);
end;

procedure TfrmMazot.txtAlanPersonelKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmMazot.txtAliciKodButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qryMazot.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qryMazot.FieldByName('ALAN_CARI_KOD').AsString := Cari_KOD;
      qryMazot.FieldByName('ALAN_CARI_ADI').AsString := Cari_AD;
  end;
end;

procedure TfrmMazot.txtAliciKodEnter(Sender: TObject);
begin
  txtAliciKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.txtAliciKodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtAliciKod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtAliciKod.Text,CARI_AD) then
    begin
      qryMazot.FieldByName('ALAN_CARI_ADI').AsString := CARI_AD;
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
    qryMazot.FieldByName('ALAN_CARI_ADI').AsString := '';
  end;
end;

procedure TfrmMazot.txtAliciKodKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmMazot.txtSaticiKodKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmMazot.txtAliciKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtAliciKodButtonClick(Self);
end;

procedure TfrmMazot.txtSaticiKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtSaticiKodButtonClick(Self);
end;

procedure TfrmMazot.IB_Edit8Enter(Sender: TObject);
begin
  IB_Edit8.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.IB_Edit10Enter(Sender: TObject);
begin
  IB_Edit10.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.IB_Edit11Enter(Sender: TObject);
begin
  IB_Edit11.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.IB_Edit12Enter(Sender: TObject);
begin
  IB_Edit12.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.IB_Edit13Enter(Sender: TObject);
begin
  IB_Edit13.Color := glb_Art_Alan_Renk;
end;

procedure TfrmMazot.IB_Edit5Enter(Sender: TObject);
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

procedure TfrmMazot.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 MAZOT_FIS_ID,MAZOT_FIS_SID FROM MAZOT_FISI WHERE MAZOT_FIS_ID<:MAZOT_FIS_ID AND MAZOT_FIS_SID=:MAZOT_FIS_SID ORDER BY MAZOT_FIS_ID DESC';
     qryDeg1.ParamByName('MAZOT_FIS_ID').AsInteger:=qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger;
     qryDeg1.ParamByName('MAZOT_FIS_SID').AsInteger:=qryMazot.FieldByName('MAZOT_FIS_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('MAZOT_FIS_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('MAZOT_FIS_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('MAZOT_FIS_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmMazot.Geri_AL;
begin
     qryMazot.CancelUpdates;
     qryMazot.Close;
     trnMazot.Rollback;
end;

procedure TfrmMazot.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 MAZOT_FIS_ID,MAZOT_FIS_SID FROM MAZOT_FISI WHERE MAZOT_FIS_ID>:MAZOT_FIS_ID AND MAZOT_FIS_SID=:MAZOT_FIS_SID ORDER BY MAZOT_FIS_ID';
     qryDeg1.ParamByName('MAZOT_FIS_ID').AsInteger:=qryMazot.FieldByName('MAZOT_FIS_ID').AsInteger;
     qryDeg1.ParamByName('MAZOT_FIS_SID').AsInteger:=qryMazot.FieldByName('MAZOT_FIS_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('MAZOT_FIS_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('MAZOT_FIS_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('MAZOT_FIS_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmMazot.Button1Click(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin


     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT MAZOT_FIS_ID,MAZOT_FIS_SID FROM MAZOT_FISI ORDER BY MAZOT_FIS_ID';
     qryDeg1.Open;
     While Not qryDeg1.Eof Do
     Begin

     if qryDeg1.FieldByName('MAZOT_FIS_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('MAZOT_FIS_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('MAZOT_FIS_SID').AsInteger;
          DataSet_Open(Id,Sid,1);
          //txtArac_KodExit(txtArac_Kod);
          btnKaydetClick(Self);
     end;
         qryDeg1.Next;
     end;



end;

procedure TfrmMazot.IB_Text6DblClick(Sender: TObject);
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
