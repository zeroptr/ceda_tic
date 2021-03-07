{$INCLUDE directive.inc}

unit ufrmKASA_CARI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Buttons, ExtCtrls, IB_Controls, Mask,
  Menus;

type
  TfrmKASA_CARI = class(TForm)
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    qryKASAHAR: TIB_Query;
    dtsKASAHAR: TIB_DataSource;
    trnKASAHAR: TIB_Transaction;
    IB_Edit1: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_Date2: TIB_Date;
    IB_Edit2: TIB_Edit;
    IB_Text1: TIB_Text;
    IB_RadioGroup1: TIB_RadioGroup;
    IB_Edit3: TIB_Edit;
    IB_Text2: TIB_Text;
    IB_Edit4: TIB_Edit;
    edt_tutar: TIB_Currency;
    edt_Dovkur: TIB_Currency;
    IB_Currency3: TIB_Currency;
    IB_Text3: TIB_Text;
    Label1: TLabel;
    txtPROJE_KOD: TIB_Edit;
    txtPROJE_AD: TIB_Edit;
    txtPLASIYER_KOD: TIB_Edit;
    txtPLASIYER_AD: TIB_Edit;
    IB_Edit5: TIB_Edit;
    rgYAZICI: TRadioGroup;
    btnCikti: TButton;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    Cb_Aciklama: TIB_ComboBox;
    procedure qryKASAHARAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure dtsKASAHARStateChanged(Sender: TIB_DataSource;       ADataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure dtsKASAHARDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure IB_Edit2ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IB_Edit3ButtonClick(Sender: TObject);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure IB_Edit2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit3KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit2Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit2Enter(Sender: TObject);
    procedure IB_Edit3Enter(Sender: TObject);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure txtPROJE_KODEnter(Sender: TObject);
    procedure txtPROJE_KODExit(Sender: TObject);
    procedure txtPLASIYER_KODExit(Sender: TObject);
    procedure txtPLASIYER_KODEnter(Sender: TObject);
    procedure txtPROJE_KODButtonClick(Sender: TObject);
    procedure txtPLASIYER_KODButtonClick(Sender: TObject);
    procedure txtPROJE_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPLASIYER_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPROJE_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txtPLASIYER_KODKeyPress(Sender: TObject; var Key: Char);
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
    procedure IB_Edit4Exit(Sender: TObject);
    procedure edt_DovkurExit(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menuden:Boolean;KASAHAR_ID, KASAHAR_SID: Integer; Islem : Byte): Boolean;
    procedure DataSet_Open(KASAHAR_ID, KASAHAR_SID: Integer; Islem : Byte);
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    function OM_HAR_KAYDET(SIL:Boolean):Boolean;
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    PRV_ISN,prnKASAHARID,prnKASAHARSID:Integer;
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure Geri_AL;
  public
    { Public declarations }
  end;
  const cns_kasa_cari = 14;
var
  frmKASA_CARI: TfrmKASA_CARI;

implementation

uses unDATAMOD, main, ufrmISN_ERRORS, ufrmCariSDLG,unFUNC,  ufrmKasaSDGL, unYazici,
  unLogger, UDm_Fast_Report;

{$R *.dfm}

function  TfrmKASA_CARI.Form_Open(Menuden:Boolean;KASAHAR_ID, KASAHAR_SID: Integer; Islem : Byte): Boolean;
var
  local_can_update,local_can_delete:Boolean;
  qryDeg:TIB_Query;
begin
  if not DataMod.Modul_Hak(cns_kasa_cari,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((KASAHAR_ID=0) and (KASAHAR_SID=0) and (local_can_update=False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt hakkýnýz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;

    if not MainForm.FindChildFrm(Application, 'frmKASA_CARI') then
    begin
      Application.CreateForm(TfrmKASA_CARI,frmKASA_CARI);
      with frmKASA_CARI do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;

  {$IfDef TRANSPORT}
        txtPROJE_KOD.Visible := false;
        txtPROJE_AD.Visible := false;
        txtPLASIYER_KOD.Visible := false;
        txtPLASIYER_AD.Visible := false;
        grpRapKod.Visible := false;
        rgYAZICI.itemindex:=2;        
  {$EndIf}

        DataMod.CreateQuery(qryDeg,trnKASAHAR,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT ACIKLAMA FROM KASAHAR';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            Cb_Aciklama.Items.Add(qryDeg.FieldByName('ACIKLAMA').asString);
            qryDeg.Next;
        end;

        DataSet_Open(KASAHAR_ID,KASAHAR_SID,Islem);
      end;
      Result := True;
    end;
  end;
end;

procedure TfrmKASA_CARI.DataSet_Open(KASAHAR_ID, KASAHAR_SID: Integer; Islem : Byte);
{
  ISLEM
  0 : Yeni Kayýt
  1 : Edit
}
begin
  if ((KASAHAR_ID=0) and (KASAHAR_SID=0) and (prv_CanUpdate=False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt hakkýnýz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmKASA_CARI do
  begin
    PRV_ISN := DataMod.Get_Isn_Num;
    try
      case Islem of
      0:
        begin
          with qryKASAHAR do
          begin
            ParamByName('PRM_KASAHAR_ID').AsInteger := 0;
            ParamByName('PRM_KASAHAR_SID').AsInteger := 0;
            Insert;
          end;
        end;
      1:
        begin
          with qryKASAHAR do
          begin
            Active := False;
            ParamByName('PRM_KASAHAR_ID').AsInteger := KASAHAR_ID;
            ParamByName('PRM_KASAHAR_SID').AsInteger := KASAHAR_SID;
            Active := True;
            Edit;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
          end;
          if qryKASAHAR.RecordCount = 0 then
          begin
            Application.MessageBox('Kayýta ulaþýlamadý.','Dikkat',MB_ICONWARNING);
          end;
          prnKASAHARID := qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger;
          prnKASAHARSID := qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger;
        end;
      end;//end case Islem of
    except
      Application.MessageBox('Veri Tabaný iþlemleri sýrasýnda Hata Oluþtu','Dikkat',MB_ICONWARNING);
      Close;
    end;
    DataMod.Rapor_Kod_Visible_Fields_IB('KASA',frmKASA_CARI.ib_edit8,frmKASA_CARI.ib_edit10,frmKASA_CARI.ib_edit11,frmKASA_CARI.ib_edit12,frmKASA_CARI.ib_edit13);
    if not glb_PROJE_UYG then
    begin
      txtPROJE_KOD.Visible := false;
      txtPROJE_AD.Visible := false;
    end;
    if not glb_PLASIYER_UYG then
    begin
      txtPLASIYER_KOD.Visible := false;
      txtPLASIYER_AD.Visible := false;
    end;
  end;
end;


procedure TfrmKASA_CARI.qryKASAHARAfterInsert(IB_Dataset: TIB_Dataset);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin
  with qryKASAHAR do
  begin
    FieldByName('KASAHAR_SID').AsInteger := glb_SID;
    FieldByName('TARIH').AsDate := DataMod.GET_SERVER_DATE ;
    FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('TARIH').AsDate;
    FieldByName('MIKTAR').AsInteger := 0;
    FieldByName('BELGE_TUR').AsInteger := 0;
    FieldByName('BELGE_ID').AsInteger := 0;
    FieldByName('BELGE_SID').AsInteger := 0;
    FieldByName('MC').AsString := 'C';
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
    FieldByName('DOVKUR').AsCurrency := 1;
    FieldByName('SIRA_NO').AsInteger := 1;
    if DataMod.GET_DEFAULT_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) then
    begin
      FieldByName('KASA_KOD').AsString := KASA_KOD;
      FieldByName('KASA_AD').AsString  := KASA_AD;
      FieldByName('DOVKOD').AsString   := KASA_DOVKOD;
    end;
  end;
  IB_Date1.SetFocus;
end;


procedure TfrmKASA_CARI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmKASA_CARI.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmKASA_CARI.Form_Post;
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if trnKASAHAR.InTransaction then
     trnKASAHAR.Rollback;
  trnKASAHAR.StartTransaction;
//****************************************************************************//
  try
//****************************************************************************//
    prnKASAHARID := qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger;
    prnKASAHARSID := qryKASAHAR.FieldByName('KASAHAR_SID').AsSmallint;
//****************************************************************************//
    if OM_HAR_KAYDET(False) = False then
    begin
      trnKASAHAR.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

//****************************************************************************//
    qryKASAHAR.Post;
    qryKASAHAR.ApplyUpdates;
    qryKASAHAR.CommitUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('KASAHAR,',
                                             BT_KASA,
                                             qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger,
                                             qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger,
                                             1,1,'');
//****************************************************************************//
    trnKASAHAR.Commit;
//****************************************************************************//
  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(141)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,141,14,1,rgYAZICI.ItemIndex,prnKASAHARID,prnKASAHARSID,0,'');
  end
  else

    if rgYAZICI.ItemIndex < 2 then Yazici.KASACARI(prnKASAHARID,prnKASAHARSID,rgYAZICI.ItemIndex);
    prnKASAHARID := 0;
    prnKASAHARSID := 0;
//****************************************************************************//
  except
    trnKASAHAR.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  qryKASAHAR.Close;
end;

procedure TfrmKASA_CARI.Form_Delete;
var
  KASAHAR_ID,KASAHAR_SID : Integer;
begin
  if not Form_Before_Delete then exit;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if trnKASAHAR.InTransaction then
     trnKASAHAR.Rollback;
  trnKASAHAR.StartTransaction;
//****************************************************************************//
  try
    //storedprocs
//****************************************************************************//
    if OM_HAR_KAYDET(True) = False then
    begin
      trnKASAHAR.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;
//****************************************************************************//
    KASAHAR_ID := qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger;
    KASAHAR_SID := qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger;
//****************************************************************************//
    qryKASAHAR.Delete;
    qryKASAHAR.ApplyUpdates;
    qryKASAHAR.CommitUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('KASAHAR,',
                                             BT_KASA,
                                             KASAHAR_ID,
                                             KASAHAR_SID,
                                             1,2,'');
//****************************************************************************//
    trnKASAHAR.Commit;
  except
    trnKASAHAR.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  qryKASAHAR.Close;
end;

procedure TfrmKASA_CARI.btnIPTALClick(Sender: TObject);
begin
  case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO) of
  ID_YES:
    begin
      qryKASAHAR.CancelUpdates;
      qryKASAHAR.CommitUpdates;
//****************************************************************************//
      if trnKASAHAR.InTransaction then
         trnKASAHAR.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
      prnKASAHARID := 0;
      prnKASAHARSID := 0;
    end;
  end;//end case
end;

procedure TfrmKASA_CARI.dtsKASAHARStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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

procedure TfrmKASA_CARI.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmKASA_CARI.dtsKASAHARDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
var Kur:Currency;
begin
  if  Assigned( Field ) Then
  begin
    if Field.FieldName = 'DOVKOD' then
    begin
      KUR := DataMod.Get_Doviz_Kur(qryKASAHAR.FieldByName('DOVKOD').AsString,qryKASAHAR.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur <> 0 then qryKASAHAR.FieldByName('DOVKUR').AsCurrency := Kur else qryKASAHAR.FieldByName('DOVKUR').AsCurrency := 1;
    end;

    if (Field.FieldName = 'TUTAR') or (Field.FieldName = 'DOVKUR') then
    begin
      qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency := qryKASAHAR.FieldByName('TUTAR').AsCurrency * qryKASAHAR.FieldByName('DOVKUR').AsCurrency ;
      qryKASAHAR.FieldByName('KASADEGER').AsCurrency := qryKASAHAR.FieldByName('TUTAR').AsCurrency;
    end;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit2ButtonClick(Sender: TObject);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) Then
  begin
    with qryKASAHAR do
    begin
      FieldByName('KASA_KOD').AsString := KASA_KOD;
      FieldByName('KASA_AD').AsString := KASA_AD;
      FieldByName('DOVKOD').AsString := KASA_DOVKOD;
    end;
  end;
end;

procedure TfrmKASA_CARI.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmKASA_CARI);
  with frmKASA_CARI.qryKASAHAR do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KASADEGER').DisplayFormat := glb_DOV_FIELD_PF;
  end;


end;

procedure TfrmKASA_CARI.IB_Edit3ButtonClick(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if frmCariSDLG.Form_Open(False,CARI_KOD,CARI_AD,1) Then
  begin
    qryKASAHAR.FieldByName('KARSIKOD').AsString := CARI_KOD;
    qryKASAHAR.FieldByName('KARSI_AD').AsString := CARI_AD;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit3Exit(Sender: TObject);
var
  qry_temp : TIB_Query;
  CARI_AD : String;
begin
    IB_Edit3.Color := clWindow;
  if Trim(IB_Edit3.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',IB_Edit3.Text,CARI_AD) then
    begin
      qryKASAHAR.FieldByName('KARSI_AD').AsString := CARI_AD
    end
    else
    begin
      IB_Edit3.SetFocus;
    end;
  end
  else
  begin
    qryKASAHAR.FieldByName('KARSI_AD').AsString := '';
  end;

  if (trim(IB_Edit3.Text)<> '') AND (trim(IB_Edit2.Text)<> '') AND (trim(IB_Edit4.Text)= '') AND (dtsKASAHAR.State in [dssEDIT,dssINSERT])  then
  begin
    if qryKASAHAR.FieldByName('TIP').AsString = GIRIS then
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := qryKASAHAR.FieldByName('KARSIKOD').AsString +' dan ' + qryKASAHAR.FieldByName('KASA_KOD').AsString + ' a Tahsilat';
      ///////////////////////////////////
          {Lite
      if glb_MUH_ENT then
      begin
        DataMod.CreateQuery(qry_temp,nil,False,DataMod.dbaMain);
        with qry_temp do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT KASA.MUHASKOD AS KASA_MUHASKOD, CARI.MUHASKOD AS CARI_MUHASKOD FROM CARI,KASA WHERE KASA.KASA_KOD=:PRM_KASA_KOD AND CARI.CARI_KOD=:PRM_CARI_KOD');
          ParamByName('PRM_KASA_KOD').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString;
          ParamByName('PRM_CARI_KOD').AsString := qryKASAHAR.FieldByName('KARSIKOD').AsString;
          Active := True;
        end;
        ///////////////////////////////////
        qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qry_temp.FieldByName('CARI_MUHASKOD').AsString +' dan ' + qry_temp.FieldByName('KASA_MUHASKOD').AsString + ' a Tahsilat';
        DataMod.ReleaseQuery(qry_temp);
        ///////////////////////////////////
        }
      end
      else
      begin
        qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR.FieldByName('KARSIKOD').AsString +' dan ' + qryKASAHAR.FieldByName('KASA_KOD').AsString + ' a Tahsilat';
      end;
    end
    else
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString +' dan ' + qryKASAHAR.FieldByName('KARSIKOD').AsString + ' a Tediye ';

          {Lite      ///////////////////////////////////
      DataMod.CreateQuery(qry_temp,nil,False,DataMod.dbaMain);
      //qry_temp := TIB_Query.Create(Self);
      with qry_temp do
      begin
        //IB_Connection := DataMod.dbaMain;
        Active := false;
        SQL.Clear;
        SQL.Add('SELECT KASA.MUHASKOD AS KASA_MUHASKOD, CARI.MUHASKOD AS CARI_MUHASKOD FROM CARI,KASA WHERE KASA.KASA_KOD=:PRM_KASA_KOD AND CARI.CARI_KOD=:PRM_CARI_KOD');
        ParamByName('PRM_KASA_KOD').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString;
        ParamByName('PRM_CARI_KOD').AsString := qryKASAHAR.FieldByName('KARSIKOD').AsString;
        Active := True;
      end;
      ///////////////////////////////////
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qry_temp.FieldByName('KASA_MUHASKOD').AsString +' dan ' + qry_temp.FieldByName('CARI_MUHASKOD').AsString + ' a Tediye ';
      DataMod.ReleaseQuery(qry_temp);
      //qry_temp.Close;
      //qry_temp.Free;
      ///////////////////////////////////

    end;}
  end;
end;

procedure TfrmKASA_CARI.IB_Edit2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
begin
  if Key = VK_F4 then  IB_Edit2ButtonClick(Self);
end;

procedure TfrmKASA_CARI.IB_Edit3KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
begin
  if Key = VK_F4 then  IB_Edit3ButtonClick(Self);
end;

procedure TfrmKASA_CARI.IB_Edit2Exit(Sender: TObject);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin
//  IB_Edit2.Color := clWindow;
  if Trim(IB_Edit2.Text) <> '' then
  begin
    if glb_KASA_KISIT_UYG then
    begin
      if DataMod.GET_KULLANICI_KASA_KOD(IB_Edit2.Text,KASA_AD) then
      begin
        qryKASAHAR.FieldByName('KASA_AD').AsString := KASA_AD;
        IB_Edit2.Color := clWindow;
      end
      else
      begin
        IB_Edit2.SetFocus;
      end;
    end
    else
    begin
      if DataMod.GET_KASA_FROM_KASA_KOD(IB_Edit2.Text,KASA_AD,KASA_DOVKOD) then
      begin
        qryKASAHAR.FieldByName('KASA_AD').AsString := KASA_AD;
        IB_Edit2.Color := clWindow;
      end
      else
      begin
        IB_Edit2.SetFocus;
      end;
    end;
  end
  else
  begin
    qryKASAHAR.FieldByName('KASA_AD').AsString := '';
    IB_Edit2.Color := clWindow;
  end;
end;

procedure TfrmKASA_CARI.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmKASA_CARI.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmKASA_CARI.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_CARI.IB_Edit2Enter(Sender: TObject);
begin
  IB_Edit2.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_CARI.IB_Edit3Enter(Sender: TObject);
begin
  IB_Edit3.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_CARI.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmKASA_CARI.txtPROJE_KODEnter(Sender: TObject);
begin
  txtPROJE_KOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_CARI.txtPROJE_KODExit(Sender: TObject);
var
  PROJE_AD:String;
begin
  if Trim(txtPROJE_KOD.Text) <> '' then
  begin
    if  DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',txtPROJE_KOD.Text,PROJE_AD) then
    begin
      qryKASAHAR.FieldByName('PROJE_AD').AsString := PROJE_AD;
      txtPROJE_KOD.Color := clWindow;
    end else
    begin
      txtPROJE_KOD.SetFocus;
    end;
  end
  else
  begin
    qryKASAHAR.FieldByName('PROJE_AD').AsString := '';
    txtPROJE_KOD.Color := clWindow;
  end;
end;

procedure TfrmKASA_CARI.txtPLASIYER_KODExit(Sender: TObject);
var
  PLASIYER_AD:String;
begin
  txtPLASIYER_KOD.Color := clWindow;
  if Trim(txtPLASIYER_KOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',txtPLASIYER_KOD.Text,PLASIYER_AD) then
    begin
      qryKASAHAR.FieldByName('PLASIYER_AD').AsString := PLASIYER_AD
    end
    else
    begin
      txtPLASIYER_KOD.SetFocus;
    end
  end
  else
  begin
    qryKASAHAR.FieldByName('PLASIYER_AD').AsString := '';
  end;
end;

procedure TfrmKASA_CARI.txtPLASIYER_KODEnter(Sender: TObject);
begin
  txtPLASIYER_KOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_CARI.txtPROJE_KODButtonClick(Sender: TObject);
var
  PROJE_KOD,PROJE_AD:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Proje(PROJE_KOD,PROJE_AD,1) Then
  begin
    qryKASAHAR.FieldByName('PROJE_KOD').AsString := PROJE_KOD;
    qryKASAHAR.FieldByName('PROJE_AD').AsString := PROJE_AD;
  end;
end;

procedure TfrmKASA_CARI.txtPLASIYER_KODButtonClick(Sender: TObject);
var
  PLASIYER_KOD, PLASIYER_AD :String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Plasiyer(PLASIYER_KOD, PLASIYER_AD,1) then
  begin
    qryKASAHAR.FieldByName('PLASIYER_KOD').AsString := PLASIYER_KOD;
    qryKASAHAR.FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
  end;
end;

procedure TfrmKASA_CARI.txtPROJE_KODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then  txtPROJE_KODButtonClick(Self);
end;

procedure TfrmKASA_CARI.txtPLASIYER_KODKeyDown(Sender: TObject;   var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtPLASIYER_KODButtonClick(Self);
end;

procedure TfrmKASA_CARI.txtPROJE_KODKeyPress(Sender: TObject;     var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmKASA_CARI.txtPLASIYER_KODKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmKASA_CARI.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmKASA_CARI.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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

procedure TfrmKASA_CARI.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

function TfrmKASA_CARI.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryKASAHAR.FieldByName('TARIH').AsDate,True) then Exit;
  Result := True;
end;


function TfrmKASA_CARI.Form_Before_Post:Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(IB_Edit2.Text) = '' then
  begin
    IB_Edit2.SetFocus;
    Application.MessageBox('Mutlaka bir KASA belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if Trim(IB_Edit3.Text) = '' then
  begin
    IB_Edit3.SetFocus;
    Application.MessageBox('Mutlaka bir CARI belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    IB_Edit3ButtonClick(Self);
    Exit;
  end;

  if Trim(IB_Edit4.Text) = '' then
  begin
    IB_Edit4.SetFocus;
    Application.MessageBox('Mutlaka bir AÇIKLAMA belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if qryKASAHAR.FieldByName('TUTAR').AsCurrency <= 0 then
  begin
    edt_tutar.SetFocus;
    Application.MessageBox('Tutar deðeri sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if (qryKASAHAR.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    edt_Dovkur.SetFocus;
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if (qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    edt_tutar.SetFocus;
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryKASAHAR.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryKASAHAR.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryKASAHAR.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;

  Result := True;
end;

function TfrmKASA_CARI.OM_HAR_KAYDET(SIL:Boolean):Boolean;
var CARI_YON,PROJE_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    PROJE_SIL,CARI_SIL:Byte;
begin
  if qryKASAHAR.FieldByName('TIP').AsString = GIRIS then
  begin
    CARI_YON := ALACAK;
    PROJE_YON := ALACAK;
  end
  else
  begin
    CARI_YON := BORC;
    PROJE_YON := BORC;
  end;
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
    if not DataMod.CARIHAR_AUD(trnKASAHAR,
                              BT_KASA,
                              qryKASAHAR.FieldbyName('KASAHAR_ID').AsInteger,
                              qryKASAHAR.FieldbyName('KASAHAR_SID').AsInteger,
                              1,
                              qryKASAHAR.FieldbyName('KARSIKOD').AsString,
                              CARI_YON,
                              qryKASAHAR.FieldbyName('TARIH').AsDate,
                              qryKASAHAR.FieldbyName('TARIH').AsDate,
                              qryKASAHAR.FieldbyName('DOV_BAZ_TAR').AsDate,
                              qryKASAHAR.FieldbyName('TUTAR').AsCurrency,
                              qryKASAHAR.FieldbyName('DOVKOD').AsString,
                              qryKASAHAR.FieldbyName('DOVKUR').AsCurrency,
                              qryKASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                              qryKASAHAR.FieldbyName('TARIH').AsDate,
//                              qryKASAHAR.FieldbyName('YEVMIYE_ACK').AsString,
                              qryKASAHAR.FieldbyName('ACIKLAMA').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              qryKASAHAR.FieldByName('MASRAF_MERK').AsString,
                              qryKASAHAR.FieldByName('KOD1').AsString,
                              qryKASAHAR.FieldByName('KOD2').AsString,
                              qryKASAHAR.FieldByName('KOD3').AsString,
                              qryKASAHAR.FieldByName('KOD4').AsString,
                              qryKASAHAR.FieldByName('PLASIYER_KOD').AsString,
                              qryKASAHAR.FieldByName('PROJE_KOD').AsString,
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(trnKASAHAR,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    //PROJE HAREKETÝ
    if Trim(qryKASAHAR.FieldByName('PROJE_KOD').AsString) = '' then
    begin
      PROJE_SIL:=1
    end
    else
    begin
      PROJE_SIL:=0;
    end;

    if SIL then
    begin
      PROJE_SIL := 1;
    end;
    if not DataMod.PROJEHAR_AUD(trnKASAHAR,
                               BT_KASA,
                               qryKASAHAR.FieldbyName('KASAHAR_ID').AsInteger,
                               qryKASAHAR.FieldbyName('KASAHAR_SID').AsInteger,
                               1,
                               qryKASAHAR.FieldbyName('PROJE_KOD').AsString,
                               qryKASAHAR.FieldbyName('TARIH').AsDate,
                               qryKASAHAR.FieldbyName('TARIH').AsDate,
                               qryKASAHAR.FieldbyName('DOV_BAZ_TAR').AsDate,
                               qryKASAHAR.FieldbyName('TARIH').AsDate,
                               PROJE_YON,
                               qryKASAHAR.FieldbyName('DOVKOD').AsString,
                               qryKASAHAR.FieldbyName('DOVKUR').AsCurrency,
                               qryKASAHAR.FieldbyName('TUTAR').AsCurrency,
                               qryKASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                               PROJE_SIL,
//                               qryKASAHAR.FieldbyName('YEVMIYE_ACK').AsString,
                               qryKASAHAR.FieldbyName('ACIKLAMA').AsString,
                               PRV_ISN ,
                               qryKASAHAR.FieldByName('MASRAF_MERK').AsString,
                               qryKASAHAR.FieldByName('KOD1').AsString,
                               qryKASAHAR.FieldByName('KOD2').AsString,
                               qryKASAHAR.FieldByName('KOD3').AsString,
                               qryKASAHAR.FieldByName('KOD4').AsString,
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

procedure TfrmKASA_CARI.btnAraClick(Sender: TObject);
var
  ISLEM_TIP,KASAHAR_ID,KASAHAR_SID:Integer;
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;  
begin
  if frmKasaSDGL.Form_Open(False,1, '',ISLEM_TIP,KASAHAR_ID,KASAHAR_SID,KASA_KOD,KASA_AD,KASA_DOVKOD) then
  begin
    Dataset_Open(KASAHAR_ID,KASAHAR_SID,1);
  end;
end;

procedure TfrmKASA_CARI.IB_Edit8ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit10ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit11ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit12ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit13ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit8Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit8.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit8,nil,0) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit8.SetFocus;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit10Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit10.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit10,nil,1) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit10.SetFocus;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit11Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit11.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit11,nil,2) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit11.SetFocus;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit12Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit12.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit12,nil,3) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit12.SetFocus;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit13Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit13.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit13,nil,4) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit13.SetFocus;
  end;
end;

procedure TfrmKASA_CARI.IB_Edit8KeyUp(Sender: TObject; var Key: Word;   Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure TfrmKASA_CARI.IB_Edit10KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure TfrmKASA_CARI.IB_Edit11KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure TfrmKASA_CARI.IB_Edit12KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure TfrmKASA_CARI.IB_Edit13KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;

procedure TfrmKASA_CARI.IB_Edit4Exit(Sender: TObject);
begin
  if qryKASAHAR.State in [dssInsert] then
  begin
    if Trim(qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString) = '' then
    begin
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR.FieldByName('ACIKLAMA').AsString;
    end;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_CARI.edt_DovkurExit(Sender: TObject);
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if (qryKASAHAR.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
    qryKASAHAR.FieldByName('DOVKUR').AsCurrency := 1;
    edt_Dovkur.SetFocus;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_CARI.btnCiktiClick(Sender: TObject);
begin
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.ItemIndex < 2 then  
  if Dm_Fast_Report.Yeni_Rapor_Varmi(141)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,141,14,1,rgYAZICI.ItemIndex,prnKASAHARID,prnKASAHARSID,0,'');
  end
  else
  if rgYAZICI.ItemIndex < 2 then Yazici.KASACARI(prnKASAHARID,prnKASAHARSID,rgYAZICI.ItemIndex);
end;

procedure TfrmKASA_CARI.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 KASAHAR_ID,KASAHAR_SID FROM KASAHAR  WHERE ISLEM_TIP = 1 AND KASAHAR_ID<:KASAHAR_ID AND KASAHAR_SID=:KASAHAR_SID ORDER BY KASAHAR_ID DESC';
     qryDeg1.ParamByName('KASAHAR_ID').AsInteger:=qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger;
     qryDeg1.ParamByName('KASAHAR_SID').AsInteger:=qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('KASAHAR_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('KASAHAR_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('KASAHAR_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);


end;

procedure TfrmKASA_CARI.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 KASAHAR_ID,KASAHAR_SID FROM KASAHAR  WHERE ISLEM_TIP = 1 AND KASAHAR_ID>:KASAHAR_ID AND KASAHAR_SID=:KASAHAR_SID ORDER BY KASAHAR_ID';
     qryDeg1.ParamByName('KASAHAR_ID').AsInteger:=qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger;
     qryDeg1.ParamByName('KASAHAR_SID').AsInteger:=qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('KASAHAR_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('KASAHAR_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('KASAHAR_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);


end;


procedure TfrmKASA_CARI.Geri_AL;
begin
     qryKASAHAR.CancelUpdates;
     qryKASAHAR.Close;
     trnKASAHAR.Rollback;
end;

end.
