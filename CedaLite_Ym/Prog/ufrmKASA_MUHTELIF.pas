{$INCLUDE directive.inc}

unit ufrmKASA_MUHTELIF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ComCtrls, IB_Grid, StdCtrls, IB_Controls, Grids,
  ExtCtrls, Mask, Buttons, IB_StoredProc, IB_TransactionBar, IB_DatasetBar,
  Menus;
type
  TfrmKASA_MUHTELIF = class(TForm)
    pcKASAHAR: TPageControl;
    tabMASTER: TTabSheet;
    tabDETAY: TTabSheet;
    sbDEKONT: TStatusBar;
    qryKASAHAR: TIB_Query;
    dtsKASAHAR: TIB_DataSource;
    Panel1: TPanel;
    grdDekontKontrol: TIB_Grid;
    rdoCM: TIB_RadioGroup;
    txtKARSI_KOD: TIB_Edit;
    edtDOVKUR: TIB_Currency;
    edtTUTAR: TIB_Currency;
    edtTUTARVPB: TIB_Currency;
    btnEKLE: TButton;
    btnKAYDET: TButton;
    btnSIL: TButton;
    Panel2: TPanel;
    btnYENI: TButton;
    btnTRN_KAYDET: TButton;
    btnTRN_IPTAL: TButton;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnIptal: TButton;
    btnHareketSil: TButton;
    IB_Edit5: TIB_Edit;
    trnKASAMUH: TIB_Transaction;
    IB_Edit6: TIB_Edit;
    IB_Currency4: TIB_Currency;
    txtMAS_PROJE_KOD: TIB_Edit;
    txtMAS_PROJE_AD: TIB_Edit;
    txtMAS_PLASIYER_KOD: TIB_Edit;
    txtMAS_PLASIYER_AD: TIB_Edit;
    qryKASAHAR_MAS: TIB_Query;
    dtsKASAHAR_MAS: TIB_DataSource;
    txtFIS_NO: TIB_Edit;
    dtpISLEMTAR: TIB_Date;
    dtpDOVBAZTAR: TIB_Date;
    IB_Edit1: TIB_Edit;
    txtKASA_KOD: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Currency5: TIB_Currency;
    txtMAS_DOVKUR: TIB_Currency;
    IB_Edit3: TIB_Edit;
    IB_Currency6: TIB_Currency;
    IB_Edit7: TIB_Edit;
    IB_Edit14: TIB_Edit;
    rgYAZICI: TRadioGroup;
    cboDOVKOD: TIB_ComboBox;
    rgTIP: TIB_RadioGroup;
    btnCikti: TButton;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    PopupMenu1: TPopupMenu;
    KasaMuhtelifTahsilTediyeKaydnKopyala1: TMenuItem;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    txt_Cari_Kod: TIB_Edit;
    IB_Edit9: TIB_Edit;
    Cb_Aciklama: TIB_ComboBox;
    Cb_Aciklama1: TIB_ComboBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnYENIClick(Sender: TObject);
    procedure pcKASAHARChanging(Sender: TObject; var AllowChange: Boolean);
    procedure txtKARSI_KODButtonClick(Sender: TObject);
    procedure rdoCMClick(Sender: TObject);
    procedure qryKASAHARAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dtsKASAHARDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure btnEKLEClick(Sender: TObject);
    procedure btnKAYDETClick(Sender: TObject);
    procedure dtsKASAHARStateChanged(Sender: TIB_DataSource;       ADataset: TIB_Dataset);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure btnSILClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnHareketSilClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure txtKARSI_KODExit(Sender: TObject);
    procedure txtKARSI_KODKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKARSI_KODKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure qryKASAHARAfterPost(IB_Dataset: TIB_Dataset);
    procedure qryKASAHARAfterDelete(IB_Dataset: TIB_Dataset);
    procedure qryKASAHARAfterOpen(IB_Dataset: TIB_Dataset);
    procedure rbTAHSILClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    Procedure KontolleriKilitle;
    procedure txtOLCUBIRIMButtonClick(Sender: TObject);
    procedure txtOLCUBIRIMExit(Sender: TObject);
    procedure qryKASAHAR_MASAfterInsert(IB_Dataset: TIB_Dataset);
    procedure txtKASA_KODExit(Sender: TObject);
    procedure txtKASA_KODChange(Sender: TObject);
    procedure txtKASA_KODButtonClick(Sender: TObject);
    procedure txtMAS_PROJE_KODButtonClick(Sender: TObject);
    procedure txtMAS_PLASIYER_KODButtonClick(Sender: TObject);
    procedure txtMAS_PLASIYER_KODEnter(Sender: TObject);
    procedure txtMAS_PLASIYER_KODExit(Sender: TObject);
    procedure txtMAS_PLASIYER_KODKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtMAS_PROJE_KODExit(Sender: TObject);
    procedure txtMAS_PROJE_KODKeyUp(Sender: TObject; var Key: Word;         Shift: TShiftState);
    procedure txtMAS_PROJE_KODEnter(Sender: TObject);
    procedure dtsKASAHAR_MASDataChange(Sender: TIB_StatementLink;         Statement: TIB_Statement; Field: TIB_Column);
    procedure btnAraClick(Sender: TObject);
    procedure dtsKASAHAR_MASStateChanged(Sender: TIB_DataSource;          ADataset: TIB_Dataset);
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
    procedure IB_Edit8KeyUp(Sender: TObject; var Key: Word;               Shift: TShiftState);
    procedure IB_Edit10KeyUp(Sender: TObject; var Key: Word;              Shift: TShiftState);
    procedure IB_Edit11KeyUp(Sender: TObject; var Key: Word;              Shift: TShiftState);
    procedure IB_Edit12KeyUp(Sender: TObject; var Key: Word;              Shift: TShiftState);
    procedure IB_Edit13KeyUp(Sender: TObject; var Key: Word;              Shift: TShiftState);
    procedure IB_Edit8Enter(Sender: TObject);
    procedure IB_Edit10Enter(Sender: TObject);
    procedure IB_Edit11Enter(Sender: TObject);
    procedure IB_Edit12Enter(Sender: TObject);
    procedure IB_Edit13Enter(Sender: TObject);
    procedure rgTIPEnter(Sender: TObject);
    procedure rgTIPExit(Sender: TObject);
    procedure rdoCMEnter(Sender: TObject);
    procedure rdoCMExit(Sender: TObject);
    procedure IB_Edit6Exit(Sender: TObject);
    procedure edtDOVKURExit(Sender: TObject);
    procedure edtTUTARExit(Sender: TObject);
    procedure txtMAS_DOVKURExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtKASA_KODEnter(Sender: TObject);
    procedure txtFIS_NOExit(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menu:Boolean;KASAHAR_ID:Integer;KASAHAR_SID:Integer;ISLEM:Byte):Boolean;
    procedure Dataset_Open(KASAHAR_ID:Integer;KASAHAR_SID:Integer;ISLEM:Byte);
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    function ON_MUH(SIL:Byte; ANAHAREKET:Boolean; KASAHAR:TIB_Query):Boolean;
    function ON_MUHASEBE_SIL:Boolean;
    function ON_MUHASEBE_ENT(SIL:BYTE):Boolean;
    procedure BakiyeHesapla;
    procedure qryKASAHARAfterScroll(IB_Dataset: TIB_Dataset);
    procedure rgTIPChange(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
    procedure txtFIS_NOEnter(Sender: TObject);
    procedure KasaMuhtelifTahsilTediyeKaydnKopyala1Click(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure txt_Cari_KodButtonClick(Sender: TObject);
    procedure txt_Cari_KodExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_ISN,prv_SID:Integer;
    prnKASAHARID,prnKASAHARSID:Integer;
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure KontolleriAc;
    procedure Geri_AL;
  public
    { Public declarations }
  end;

  const cns_kasa_muhtelif = 14;

var
  frmKASA_MUHTELIF: TfrmKASA_MUHTELIF;

implementation

uses unDataMod,ufrmCariSDLG, ufrmISN_ERRORS, ufrmDekontSDLG,unFunc, ufrmKasaSDGL, main, unYazici,
  unLogger, unDEKONT_AUT, UDm_Fast_Report;

{$R *.dfm}

function TfrmKASA_MUHTELIF.Form_Open(Menu:Boolean;KASAHAR_ID:Integer;KASAHAR_SID:Integer;ISLEM:Byte):Boolean;
// ISLEM : 0 INSERT ;; 1 EDIT
var
  local_can_update,local_can_delete:Boolean;
  qryDeg:TIB_Query;
begin
  if not DataMod.Modul_Hak(cns_kasa_muhtelif,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((KASAHAR_ID = 0) and (KASAHAR_SID = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    if not MainForm.FindChildFrm( Application, 'frmKASA_MUHTELIF') then
    begin
      Application.CreateForm(TfrmKASA_MUHTELIF, frmKASA_MUHTELIF);
    end
    else
    begin
      Application.MessageBox('Kasa muhtelif modulu açýk.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
  end;

  with frmKASA_MUHTELIF do
  begin
    prv_CanUpdate := local_can_update;
    prv_CanDelete := local_can_delete;
    if not glb_DOVTAKIP then
    begin
      cboDOVKOD.Visible := False;
      edtDOVKUR.Visible := False;
      edtTUTARVPB.Visible := False;
    end;

  {$IfDef TRANSPORT}
        txtMAS_PROJE_KOD.Visible := false;
        txtMAS_PROJE_AD.Visible := false;
        txtMAS_PLASIYER_KOD.Visible := false;
        txtMAS_PLASIYER_AD.Visible := false;
        grpRapKod.Visible := false;
        rgYAZICI.itemindex:=2;        
  {$EndIf}


        DataMod.CreateQuery(qryDeg,trnKASAMUH,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT ACIKLAMA FROM KASAHAR';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            Cb_Aciklama.Items.Add(qryDeg.FieldByName('ACIKLAMA').asString);
            Cb_Aciklama1.Items.Add(qryDeg.FieldByName('ACIKLAMA').asString);
            qryDeg.Next;
        end;

  {      qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT ACIKLAMA FROM KASAHAR';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            Cb_Aciklama.Items.Add(qryDeg.FieldByName('ACIKLAMA').asString);
            qryDeg.Next;
        end;
   }


    pcKASAHAR.ActivePage := tabMASTER;
    Result := True;
    DataSet_Open(KASAHAR_ID,KASAHAR_SID,ISLEM);
  end;

end;

procedure TfrmKASA_MUHTELIF.Dataset_Open(KASAHAR_ID:Integer;KASAHAR_SID:Integer;ISLEM:Byte);
begin
  if ((KASAHAR_ID = 0) and (KASAHAR_SID = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataMod.Rapor_Kod_Visible_Fields_IB('KASA',ib_edit8,ib_edit10,ib_edit11,ib_edit12,ib_edit13);
  if not glb_PROJE_UYG then
  begin
    txtMAS_PROJE_KOD.Visible := false;
    txtMAS_PROJE_AD.Visible := false;
  end;

  if not glb_PLASIYER_UYG then
  begin
    txtMAS_PLASIYER_KOD.Visible := false;
    txtMAS_PLASIYER_AD.Visible := false;
  end;

  prv_ISN := DataMod.Get_Isn_Num;
  KontolleriAc;
  case ISLEM of
  0:
    begin // yeni kayýt
      prv_SID := glb_SID;
      with qryKASAHAR_MAS do
      begin
        Active := False;
        Active := True;
        Append;
      end;
    end;
  1:
    begin
      with qryKASAHAR_MAS do
      begin
        Active := False;
        ParamByName('PRM_BELGE_ID').AsInteger := KASAHAR_ID;
        ParamByName('PRM_BELGE_SID').AsInteger := KASAHAR_SID;
        Active := True;
      end;

      if qryKASAHAR_MAS.RecordCount <> 0 then
      begin
        qryKASAHAR_MAS.Edit;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
        prnKASAHARID := qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsInteger;
        prnKASAHARSID := qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsSmallint;
      end
      else
      begin
        ShowMessage('Kayýt Bulunamadý.');
      end;
    end;
  end;
  with qryKASAHAR do
  begin
    Active := False;
    ParamByName('PRM_BELGE_ID').AsInteger := qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsInteger;
    ParamByName('PRM_BELGE_SID').AsInteger := qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsInteger;
    Active := True;
  end;

end;

procedure TfrmKASA_MUHTELIF.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if pcKASAHAR.ActivePage = tabDETAY then
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
      45: //s kaydet
        begin
          if btnEKLE.Enabled then btnEKLEClick(Self);
        end; //83 end
      end;//acase end
    end; ///if Shift = [] then ENd
  end
  else
  if pcKASAHAR.ActivePage = tabMASTER Then
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
      46:
        begin
          if btnHareketSil.Enabled Then btnHareketSilClick(self);
        end;
      end; //case end;
    end//Shift = [ssCtrl] then end
    else
    if Shift = [] then
    begin
      case Key of
      45: if btnYENI.Enabled Then btnYENIClick(Self);
      end;//case end
    end; ///if Shift = [] then ENd
  end;
  case Key Of
    VK_F6:pcKASAHAR.SelectNextPage(True);
  end;
end;

procedure TfrmKASA_MUHTELIF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmKASA_MUHTELIF.btnTRN_IPTALClick(Sender: TObject);
begin
  if Sender.ClassName <> 'TButton'  then
  begin
    qryKASAHAR.CancelUpdates;
    qryKASAHAR_MAS.CancelUpdates;
    qryKASAHAR.CommitUpdates;
    qryKASAHAR_MAS.CommitUpdates;
    qryKASAHAR.Active := False;
    qryKASAHAR_MAS.Active := False;
//****************************************************************************//
    if trnKASAMUH.InTransaction then
       trnKASAMUH.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
    prnKASAHARID := 0;
    prnKASAHARSID := 0;
  end
  else
  begin
    case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO+MB_ICONQUESTION) of
    ID_YES:
      begin
        qryKASAHAR.CancelUpdates;
        qryKASAHAR_MAS.CancelUpdates;
        qryKASAHAR.CommitUpdates;
        qryKASAHAR_MAS.CommitUpdates;
        qryKASAHAR.Active := False;
        qryKASAHAR_MAS.Active := False;
//****************************************************************************//
        if trnKASAMUH.InTransaction then
           trnKASAMUH.Rollback;
        dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
        prnKASAHARID := 0;
        prnKASAHARSID := 0;
      end;
    end;
  end;
//****************************************************************************//
end;

procedure TfrmKASA_MUHTELIF.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmKASA_MUHTELIF.btnYENIClick(Sender: TObject);
begin

  DataSet_Open(0,0,0);
end;

procedure TfrmKASA_MUHTELIF.pcKASAHARChanging(Sender: TObject;  var AllowChange: Boolean);
begin
  case pcKASAHAR.ActivePageIndex of
  0:
    begin
      qryKASAHAR_MAS.UpdateData;
      if Trim(qryKASAHAR_MAS.FieldByName('KASA_KOD').AsString) = '' then
      begin
         Application.MessageBox('Kasa Seçmeden bu sayfaya geçemezsiniz.','Dikkat',MB_ICONWARNING);
         AllowChange := False;
         Exit;
      end;
      if trim(qryKASAHAR_MAS.FieldByName('ACIKLAMA').AsString) = '' then
      begin
        IB_Edit1.SetFocus;
        Application.MessageBox('Mutlaka bir açýklama belirtmelisiniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
        Exit;
      end
      else
      begin
        IB_Edit1Exit(Self);
//        if trim(qryKASAHAR_MAS.FieldByName('YEVMIYE_ACK').AsString) = '' then
//        begin
//          qryKASAHAR_MAS.FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR_MAS.FieldByName('ACIKLAMA').AsString;
//        end;
      end;

      if trim(qryKASAHAR_MAS.FieldByName('YEVMIYE_ACK').AsString) = '' then
      begin
        ib_edit7.SetFocus;
        Application.MessageBox('Mutlaka bir yevmiye açýklamasý belirtmelisiniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
        Exit;
      end;
      sbDEKONT.Panels[4].Text := qryKASAHAR_MAS.FieldByName('DOVKOD').AsString;
    end;
  1:
    begin
      if  qryKASAHAR.State in [dssInsert,dssEdit] Then
      begin
        Application.MessageBox('Deðiþiklikleri kaydediniz ya da iptal ediniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
        exit;
      end;
      if  qryKASAHAR.State in [dssInsert,dssEdit] Then
      begin
        if trim(qryKASAHAR.FieldByName('ACIKLAMA').AsString) = '' then
        begin
           ib_edit6.SetFocus;
           Application.MessageBox('Mutlaka bir açýklama belirtmelisiniz.','Dikkat',MB_ICONWARNING);
           AllowChange := False;
           Exit;
        end
        else
        begin
          IB_Edit6Exit(Self);
        end;

        if trim(qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString) = '' then
        begin
           ib_edit14.SetFocus;
           Application.MessageBox('Mutlaka bir yevmiye açýklamasý belirtmelisiniz.','Dikkat',MB_ICONWARNING);
           AllowChange := False;
           Exit;
        end;
      end;
    end; //1 end;
  end;//Case End;
end;

procedure TfrmKASA_MUHTELIF.txtKARSI_KODButtonClick(Sender: TObject);
var
  KARSI_AD,KARSI_KOD:String;
  MIK_TAK:SmallInt;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if qryKASAHAR.FieldByName('MC').AsString = 'C' then
  begin
    if frmCariSDLG.Form_Open(False,KARSI_KOD,KARSI_AD,1) Then
    begin
      qryKASAHAR.FieldByName('KARSIKOD').AsString := KARSI_KOD;
      qryKASAHAR.FieldByName('KARSI_AD').AsString := KARSI_AD;
    end
  end
  else
  begin
    if DataMod.LS_MASRAFTAN(KARSI_KOD) then
    begin
      qryKASAHAR.FieldByName('KARSIKOD').AsString := KARSI_KOD;
      DataMod.FN_KOD2AD('MASRAF','MASRAF_KOD','ADI',KARSI_KOD,KARSI_AD);
      qryKASAHAR.FieldByName('KARSI_AD').AsString := KARSI_AD;
    end;
  end;
end;

procedure TfrmKASA_MUHTELIF.rdoCMClick(Sender: TObject);
begin
  qryKASAHAR.FieldByName('KARSIKOD').AsString := '';
  qryKASAHAR.FieldByName('KARSI_AD').AsString := '';
end;

procedure TfrmKASA_MUHTELIF.qryKASAHARAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryKASAHAR do
  begin
    FieldByName('TIP').AsString := qryKASAHAR_MAS.FieldByName('TIP').AsString;
//    FieldByName('MC').AsString := 'M';
    FieldByName('MC').AsString := 'C';
    FieldByName('TARIH').AsDate := qryKASAHAR_MAS.FieldByName('TARIH').AsDate;
    FieldByName('DOV_BAZ_TAR').AsDate := qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate;
    FieldByName('ACIKLAMA').AsString := qryKASAHAR_MAS.FieldByName('ACIKLAMA').AsString;
    FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR_MAS.FieldByName('YEVMIYE_ACK').AsString;
    FieldByName('KASA_KOD').AsString := qryKASAHAR_MAS.FieldByName('KASA_KOD').AsString;
    FieldByName('DOVKOD').AsString := qryKASAHAR_MAS.FieldByName('DOVKOD').AsString;
    FieldByName('KASAHAR_SID').AsInteger := prv_SID;
    FieldByName('ISLEM_TIP').AsInteger := 5;
    FieldByName('BELGE_TUR').AsInteger := BT_KASA;
    FieldByName('BELGE_ID').AsInteger  := qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsInteger;
    FieldByName('BELGE_SID').AsInteger := qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsInteger;
    FieldByName('SIRA_NO').AsInteger := 0;

    if qryKASAHAR_MAS.FieldByName('KARSIKOD').AsString<>'' then
    begin
    FieldByName('KARSIKOD').AsString :=  qryKASAHAR_MAS.FieldByName('KARSIKOD').AsString;
    FieldByName('KARSI_AD').AsString :=  qryKASAHAR_MAS.FieldByName('KARSI_AD').AsString;
    end;

  end;
  KontolleriKilitle;
  rdoCM.SetFocus;
end;

procedure TfrmKASA_MUHTELIF.dtsKASAHARDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
var
  DOV_KUR:Currency;
begin
  if  Assigned( Field ) Then
  begin
    if Field.FieldName = 'DOVKOD' Then
    begin
      DOV_KUR := DataMod.Get_Doviz_Kur(qryKASAHAR.FieldByName('DOVKOD').AsString,qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
      if DOV_KUR=0 Then
      begin
        qryKASAHAR.FieldByName('DOVKUR').AsCurrency := 1;
      end
      else
      begin
        qryKASAHAR.FieldByName('DOVKUR').AsCurrency := DOV_KUR;
        qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency := qryKASAHAR.FieldByName('DOVKUR').AsCurrency * qryKASAHAR.FieldByName('TUTAR').AsCurrency;
        if qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency <> 0 then qryKASAHAR.FieldByName('KASADEGER').AsCurrency := qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency / qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency;
      end;
    end;
    if Field.FieldName = 'TUTAR' Then
    begin
      qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency := qryKASAHAR.FieldByName('DOVKUR').AsCurrency * qryKASAHAR.FieldByName('TUTAR').AsCurrency;
      if qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency <> 0 then qryKASAHAR.FieldByName('KASADEGER').AsCurrency := qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency / qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency;
    end;
    if Field.FieldName = 'DOVKUR' Then
    begin
      qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency := qryKASAHAR.FieldByName('DOVKUR').AsCurrency * qryKASAHAR.FieldByName('TUTAR').AsCurrency;
      if qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency <> 0 then qryKASAHAR.FieldByName('KASADEGER').AsCurrency := qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency / qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency;
    end;


  end;
end;

procedure TfrmKASA_MUHTELIF.btnEKLEClick(Sender: TObject);
begin
  qryKASAHAR.Append;
  rdoCM.SetFocus;
End;

procedure TfrmKASA_MUHTELIF.btnKAYDETClick(Sender: TObject);
var
  FuncDeger,KARSI_AD:String;
begin
  if Length(qryKASAHAR.FieldByName('KARSIKOD').AsString) = 0 then
  begin
    txtKARSI_KOD.SetFocus;
    Application.MessageBox('Lütfen iþlem yapacaðýnýz kodu seçiniz!!','Dikkat',MB_ICONSTOP);
    txtKARSI_KODButtonClick(Self);
    exit;
  end
  else
  begin
    if qryKASAHAR.FieldByName('MC').AsString = 'M' then
    begin
      if not DataMod.FN_KOD2AD('MASRAF','MASRAF_KOD','ADI',qryKASAHAR.FieldByName('KARSIKOD').AsString,KARSI_AD) then
      begin
        Application.MessageBox('Lütfen listeden bir masraf kodu seçiniz.','Dikkat',MB_ICONWARNING);
        txtKARSI_KODButtonClick(Self);
        Exit;
      end;
    end
    else
    begin
      if not (DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',qryKASAHAR.FieldByName('KARSIKOD').AsString,KARSI_AD)) then
      begin
        Application.MessageBox('Lütfen listeden bir cari kod seçiniz.','Dikkat',MB_ICONWARNING) ;
        txtKARSI_KODButtonClick(Self);
        exit;
      end;
    end;
  end;

  if (qryKASAHAR.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    edtDOVKUR.SetFocus;
    exit;
  end;

  if glb_DOVTAKIP then
  begin
    if (qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
    begin
      Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
      edtTUTAR.SetFocus;
      exit;
    end;
  end;

  if trim(qryKASAHAR.FieldByName('ACIKLAMA').AsString) = '' then
  begin
    IB_Edit6.SetFocus;
    Application.MessageBox('Mutlaka bir açýklama belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  {Lite
  if trim(qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString) = '' then
  begin
    IB_Edit14.SetFocus;
    Application.MessageBox('Mutlaka bir yevmiye açýklamasý belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  }

  FuncDeger:=DataMod.Before_Post_Kontrol(qryKASAHAR ,'KASAHAR','KARSIKOD,TUTAR,ACIKLAMA','');
  if  FuncDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Exit;
  end;

  qryKASAHAR.Post;
end;

procedure TfrmKASA_MUHTELIF.dtsKASAHARStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
begin
  if ADataset.State in [dssINSERT,dssEDIT] then
  begin
    btnEKLE.Enabled := False;
    btnSIL.Enabled := False;
    btnKAYDET.Enabled := True;
    btnIPTAL.Enabled := True;
    grdDekontKontrol.Enabled := False;
  end
  else
  begin
    btnEKLE.Enabled := True;
    if not ((qryKASAHAR.Eof) And (qryKASAHAR.Bof)) Then
    begin
      btnSil.Enabled := True
    end
    else
    begin
      btnSil.Enabled := False;
    end;
    btnKAYDET.Enabled := False;
    btnIPTAL.Enabled := False;
    grdDekontKontrol.Enabled := True;
  end;
end;

procedure TfrmKASA_MUHTELIF.btnTRN_KAYDETClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmKASA_MUHTELIF.btnIptalClick(Sender: TObject);
begin
  qryKASAHAR.Cancel;
end;

procedure TfrmKASA_MUHTELIF.btnSILClick(Sender: TObject);
begin
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then Exit;
  qryKASAHAR.Delete;
end;

procedure TfrmKASA_MUHTELIF.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if dtsKASAHAR_MAS.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Kasa bölümünde yaptýðýnýz deðiþiklikleri kaydediniz ya da iptal ediniz.','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end;
  if dtsKASAHAR.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Kalemler bölümünde yaptýðýnýz deðiþiklikleri kaydeniniz ya da iptal ediniz.','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmKASA_MUHTELIF.btnHareketSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmKASA_MUHTELIF.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmKASA_MUHTELIF.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmKASA_MUHTELIF);
  with frmKASA_MUHTELIF.qryKASAHAR do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KASADEGER').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('MIKTAR').DisplayFormat := glb_DOV_FIELD_PF;
  end;
  with frmKASA_MUHTELIF.qryKASAHAR_MAS do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('KASADEGER').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('MIKTAR').DisplayFormat := glb_DOV_FIELD_PF;
  end;


end;

procedure TfrmKASA_MUHTELIF.txtKARSI_KODExit(Sender: TObject);
var
  KARSI_AD:String;
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if qryKASAHAR.FieldByName('KARSIKOD').AsString <> '' then
  begin
    if qryKASAHAR.FieldByName('MC').AsString = 'C' then
    begin
      if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',qryKASAHAR.FieldByName('KARSIKOD').AsString,KARSI_AD) then
      begin
        qryKASAHAR.FieldByName('KARSI_AD').AsString := KARSI_AD;
        my_Active_Comp.Brush.Color := clWindow;
      end
      else
      begin
        qryKASAHAR.FieldByName('KARSIKOD').AsString := '';
        qryKASAHAR.FieldByName('KARSI_AD').AsString :='' ;
        txtKARSI_KOD.SetFocus;
        Application.MessageBox('Lütfen iþlem yapacaðýnýz kodu seçiniz!!','Dikkat',MB_ICONSTOP);
        txtKARSI_KODButtonClick(Self);
      end;
    end
    else
    begin
      if DataMod.FN_KOD2AD('MASRAF','MASRAF_KOD','ADI',qryKASAHAR.FieldByName('KARSIKOD').AsString,KARSI_AD) then
      begin
        qryKASAHAR.FieldByName('KARSI_AD').AsString := KARSI_AD;
        my_Active_Comp.Brush.Color := clWindow;
      end
      else
      begin
        qryKASAHAR.FieldByName('KARSIKOD').AsString := '';
        qryKASAHAR.FieldByName('KARSI_AD').AsString := '';
        txtKARSI_KOD.SetFocus;
        Application.MessageBox('Lütfen iþlem yapacaðýnýz kodu seçiniz!!','Dikkat',MB_ICONSTOP);
        txtKARSI_KODButtonClick(Self);
        Exit;
      end;
    end;
  end
  else
  begin
    qryKASAHAR.FieldByName('KARSIKOD').AsString := '';
    qryKASAHAR.FieldByName('KARSI_AD').AsString :='';
    my_Active_Comp.Brush.Color := clWindow;
  end;
end;


procedure TfrmKASA_MUHTELIF.txtKARSI_KODKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtKARSI_KODButtonClick(Self);
end;

procedure TfrmKASA_MUHTELIF.txtKARSI_KODKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmKASA_MUHTELIF.FormResize(Sender: TObject);
begin
  btnCikis.Left := frmKASA_MUHTELIF.Width  - (btnCikis.Width + 25 );
  btnAra.Left := frmKASA_MUHTELIF.Width  - ( btnCikis.Width + btnAra.Width + 28 );
end;

procedure TfrmKASA_MUHTELIF.BakiyeHesapla;
var
  BookMark:String;
begin
  if qryKASAHAR.Active = False then Exit;
  Bookmark := qryKASAHAR.Bookmark;
  qryKASAHAR.DisableControls;
  qryKASAHAR.First;
  qryKASAHAR_MAS.FieldByName('KASADEGER').AsCurrency := 0;
  while (not qryKASAHAR.Eof) do
  begin
    qryKASAHAR_MAS.FieldByName('KASADEGER').AsCurrency := qryKASAHAR_MAS.FieldByName('KASADEGER').AsCurrency + qryKASAHAR.FieldByName('KASADEGER').AsCurrency;
    qryKASAHAR.Next;
  end;
  qryKASAHAR.Bookmark := BookMark;
  qryKASAHAR.EnableControls;
  sbDEKONT.Panels[5].Text := FormatFloat(glb_DOV_FIELD_PF,qryKASAHAR_MAS.FieldByName('KASADEGER').AsCurrency);
end;

procedure TfrmKASA_MUHTELIF.qryKASAHARAfterPost(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
  KontolleriKilitle;
end;

procedure TfrmKASA_MUHTELIF.qryKASAHARAfterDelete(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
  KontolleriKilitle;
end;

procedure TfrmKASA_MUHTELIF.qryKASAHARAfterOpen(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
  KontolleriKilitle;
end;

procedure TfrmKASA_MUHTELIF.rbTAHSILClick(Sender: TObject);
begin
  sbDEKONT.Panels[2].Text := 'TAHSIL'
end;

procedure TfrmKASA_MUHTELIF.RadioButton1Click(Sender: TObject);
begin
  sbDEKONT.Panels[2].Text := 'TEDIYE'
end;

procedure TfrmKASA_MUHTELIF.KontolleriKilitle;
begin
  if qryKASAHAR.RecordCount > 0 then
  begin
    dtpISLEMTAR.Enabled := False;
    dtpDOVBAZTAR.Enabled := False;
    txtKASA_KOD.Enabled := False;
    rgTIP.Enabled := False;
    txtMAS_DOVKUR.Enabled := False;
  end
  else
  begin
    dtpISLEMTAR.Enabled := True;
    dtpDOVBAZTAR.Enabled :=  True;
    txtKASA_KOD.Enabled :=  True;
    rgTIP.Enabled :=  True;
    txtMAS_DOVKUR.Enabled := True;
  end;
end;
procedure TfrmKASA_MUHTELIF.KontolleriAc;
begin

    dtpISLEMTAR.Enabled := True;
    dtpDOVBAZTAR.Enabled :=  True;
    txtKASA_KOD.Enabled :=  True;
    rgTIP.Enabled :=  True;
    txtMAS_DOVKUR.Enabled := True;
end;


procedure TfrmKASA_MUHTELIF.txtOLCUBIRIMButtonClick(Sender: TObject);
{var
  Returned:Boolean;
  OlcuBir:String;
  OlcuTip:String;
  }
begin
  {//Lite
  with DataMod.qryGENEL Do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('Select OLCU_TIP From MUH_PLAN Where HESAP_KOD=' + SQL_Katar(qryKASAHAR.FieldByName('KARSIKOD').AsString));
    Active := True;
    OlcuTip := FieldByName('OLCU_TIP').AsString;
  end;
  Returned := DataMod.LS_OlcuBrm(OlcuTip,OlcuBir);
  if not (Returned = False) then
  begin
    qryKASAHAR.FieldByName('OLCUBIRIM').AsString := OlcuBir;
  end;
  }
end;

procedure TfrmKASA_MUHTELIF.txtOLCUBIRIMExit(Sender: TObject);
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_MUHTELIF.qryKASAHAR_MASAfterInsert(IB_Dataset: TIB_Dataset);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin
  with qryKASAHAR_MAS do
  begin
    FieldByName('KASAHAR_SID').AsInteger := prv_SID;
    FieldByName('SIRA_NO').AsInteger := 1;
    FieldByName('TARIH').AsDate := DataMod.GET_SERVER_DATE;
    FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('TARIH').AsDate;
    FieldByName('ISLEM_TIP').AsInteger := 5;
    FieldByName('BELGE_TUR').AsInteger := BT_KASA;
    FieldByName('BELGE_ID').AsInteger  := 0;
    FieldByName('BELGE_SID').AsInteger := 0;
    FieldByName('MC').AsString := 'X';
    //FieldByName('KARSIKOD').AsString := 'MUHTELIF';
    FieldByName('TIP').AsString := CIKIS;
    if DataMod.GET_DEFAULT_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) then
    begin
      FieldByName('KASA_KOD').AsString := KASA_KOD;
      FieldByName('KASA_AD').AsString := KASA_AD;
      FieldByName('DOVKOD').AsString := KASA_DOVKOD;
      if FieldByName('DOVKUR').AsCurrency=0 then
      begin
        frmISN_ERRORS.AnyErr(nil,0,0);
        FieldByName('DOVKUR').AsCurrency := 1;
      end;
    end;
  end;//end with qryKASAHAR_MAS do
  dtpISLEMTAR.SetFocus;  
end;

procedure TfrmKASA_MUHTELIF.txtKASA_KODExit(Sender: TObject);
var
  KASA_AD,KASA_DOVKOD : String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;


  if Trim(qryKASAHAR_MAS.FieldByName('KASA_KOD').AsString) <> '' then
  begin

    if glb_KASA_KISIT_UYG then
    begin
      if DataMod.GET_KULLANICI_KASA_KOD(qryKASAHAR_MAS.FieldByName('KASA_KOD').AsString,KASA_AD) then
      begin
        qryKASAHAR_MAS.FieldByName('KASA_AD').AsString  := KASA_AD;
        DataMod.FN_KOD2AD('KASA','KASA_KOD','DOVKOD',txtKASA_KOD.Text,KASA_DOVKOD);
        qryKASAHAR_MAS.FieldByName('DOVKOD').AsString := KASA_DOVKOD;
        qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(qryKASAHAR_MAS.FieldByName('DOVKOD').AsString,qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
        if qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency=0 Then
        begin
          qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := 1;
        end;
      end
      else
      begin
        txtKASA_KOD.SetFocus;
      end;
    end
    else
    begin
     if DataMod.GET_KASA_FROM_KASA_KOD(qryKASAHAR_MAS.FieldByName('KASA_KOD').AsString,KASA_AD,KASA_DOVKOD) then
     begin
        qryKASAHAR_MAS.FieldByName('KASA_AD').AsString  := KASA_AD;
        qryKASAHAR_MAS.FieldByName('DOVKOD').AsString := KASA_DOVKOD;
        qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(qryKASAHAR_MAS.FieldByName('DOVKOD').AsString,qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
        if qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency=0 Then
        begin
          qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := 1;
        end;
     end
     else
     begin
       txtKASA_KOD.SetFocus;
     end;

    end;


  end
  else
  begin
    qryKASAHAR_MAS.FieldByName('KASA_AD').AsString  := '';
    qryKASAHAR_MAS.FieldByName('DOVKOD').AsString := '';
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_MUHTELIF.txtKASA_KODChange(Sender: TObject);
begin
  sbDEKONT.Panels[1].Text := qryKASAHAR_MAS.FieldByName('KASA_KOD').AsString;
end;

procedure TfrmKASA_MUHTELIF.txtKASA_KODButtonClick(Sender: TObject);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin

  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) Then
  begin
    qryKASAHAR_MAS.FieldByName('KASA_KOD').AsString := KASA_KOD;
    qryKASAHAR_MAS.FieldByName('KASA_AD').AsString := KASA_AD;
    qryKASAHAR_MAS.FieldByName('DOVKOD').AsString := KASA_DOVKOD;
    qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(qryKASAHAR_MAS.FieldByName('DOVKOD').AsString,qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
    if qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency=0 Then
    begin
      qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := 1;
    end;
  end;
end;

procedure TfrmKASA_MUHTELIF.txtMAS_PROJE_KODButtonClick(Sender: TObject);
var
  Proje_KOD,Proje_AD:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_Proje(Proje_KOD,Proje_AD,1) then
  begin
    qryKASAHAR_MAS.FieldByName('PROJE_KOD').AsString := Proje_KOD;
    qryKASAHAR_MAS.FieldByName('PROJE_AD').AsString := Proje_AD;
  end;
end;

procedure TfrmKASA_MUHTELIF.txtMAS_PLASIYER_KODButtonClick(Sender: TObject);
var
 PLASIYER_KOD,PLASIYER_AD:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_Plasiyer(PLASIYER_KOD,PLASIYER_AD,1) then
  begin
    qryKASAHAR_MAS.FieldByName('PLASIYER_KOD').AsString := PLASIYER_KOD;
    qryKASAHAR_MAS.FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
  end;
end;

procedure TfrmKASA_MUHTELIF.txtMAS_PLASIYER_KODEnter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmKASA_MUHTELIF.txtMAS_PLASIYER_KODExit(Sender: TObject);
var
  PLASIYER_AD:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  my_Active_Comp.Brush.Color := clWindow;
  if Trim(txtMAS_PLASIYER_KOD.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',qryKASAHAR_MAS.FieldByName('PLASIYER_KOD').AsString,PLASIYER_AD) Then
    begin
      qryKASAHAR_MAS.FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
    end
    else
    begin
      qryKASAHAR_MAS.FieldByName('PLASIYER_AD').AsString :='' ;
      txtMAS_PLASIYER_KOD.SetFocus;
    end;
  end
  else
  begin
    qryKASAHAR_MAS.FieldByName('PLASIYER_AD').AsString :='';
  end;
end;

procedure TfrmKASA_MUHTELIF.txtMAS_PLASIYER_KODKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then txtMAS_PLASIYER_KODButtonClick(self);
end;

procedure TfrmKASA_MUHTELIF.txtMAS_PROJE_KODExit(Sender: TObject);
var
  Proje_Ad:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  my_Active_Comp.Brush.Color := clWindow;
  if Trim(txtMAS_Proje_Kod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',qryKASAHAR_MAS.FieldByName('PROJE_KOD').AsString,Proje_Ad) Then
    begin
      qryKASAHAR_MAS.FieldByName('PROJE_AD').AsString := Proje_AD;
    end
    else
    begin
      qryKASAHAR_MAS.FieldByName('PROJE_AD').AsString :='' ;
      txtMAS_Proje_Kod.SetFocus;
    end;
  end
  else
  begin
    qryKASAHAR_MAS.FieldByName('PROJE_AD').AsString :='';
  end;
end;

procedure TfrmKASA_MUHTELIF.txtMAS_PROJE_KODKeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then txtMAS_PROJE_KODButtonClick(Self);
end;

procedure TfrmKASA_MUHTELIF.txtMAS_PROJE_KODEnter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;



procedure TfrmKASA_MUHTELIF.dtsKASAHAR_MASDataChange(  Sender: TIB_StatementLink; Statement: TIB_Statement; Field: TIB_Column);
var
  DOVKUR:Currency;
begin
  if Assigned( Field ) AND (dtsKASAHAR_MAS.State in [dssEdit,dssInsert]) Then
  begin
    if Field.FieldName = 'DOVKOD' Then
    begin
      DOVKUR := DataMod.Get_Doviz_Kur(qryKASAHAR_MAS.FieldByName('DOVKOD').AsString,qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
      if DOVKUR <> 0 then
      begin
        qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := DOVKUR
      end
      else
      begin
        qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := 1;
      end;
    end;

    if Field.FieldName = 'DOVKUR' Then
    begin
      BakiyeHesapla;
    end;

    if Field.FieldName = 'KASADEGER' Then
    begin
      qryKASAHAR_MAS.FieldByName('TUTAR').AsCurrency := qryKASAHAR_MAS.FieldByName('KASADEGER').AsCurrency
    end;

    if Field.FieldName = 'TUTAR' Then
    begin
      qryKASAHAR_MAS.FieldByName('TUTAR_VPB').AsCurrency := qryKASAHAR_MAS.FieldByName('TUTAR').AsCurrency * qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency;
    end;
  end;
end;

procedure TfrmKASA_MUHTELIF.btnAraClick(Sender: TObject);
var ISLEM_TIP,KASAHAR_ID,KASAHAR_SID:Integer;
    KASA_KOD,KASA_AD,KASA_DOVKOD:string;
begin
  if frmKasaSDGL.Form_Open(False,5, '',ISLEM_TIP,KASAHAR_ID,KASAHAR_SID,KASA_KOD,KASA_AD,KASA_DOVKOD) then
  begin
     Dataset_Open(KASAHAR_ID,KASAHAR_SID,1);
  end;
end;

procedure TfrmKASA_MUHTELIF.dtsKASAHAR_MASStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) Then
  begin
    btnYeni.Enabled:=False;
    if ADataset.State = dssEDIT then
    begin
      btnHareketSil.Enabled := True;
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;

    end
    else
    begin
      btnHareketSil.Enabled := False;
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;
    end;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnTRN_KAYDET.Enabled := True;
    btnTRN_IPTAL.Enabled := True;

  end
  else
  begin
    btnYeni.Enabled:=True;
    if ADataset.Active = False then
    begin
      btnHareketSil.Enabled := False;
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;
    end
    else
    begin
      btnHareketSil.Enabled := True;
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;
    end;
{
    if ADataset.RecordCount > 0 then
    begin

    end
    else
    begin

    end;
}
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit8ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR_MAS.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit10ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR_MAS.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit11ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR_MAS.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit12ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR_MAS.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit13ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR_MAS.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit8Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit8.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    ib_edit8.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit8,nil,0) then
  begin
      ib_edit8.Color := clWindow;
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit8.SetFocus;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit10Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit10.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    IB_Edit10.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit10,nil,1) then
  begin
    IB_Edit10.Color := clWindow;
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit10.SetFocus;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit11Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit11.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    IB_Edit11.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit11,nil,2) then
  begin
    IB_Edit11.Color := clWindow;
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit11.SetFocus;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit12Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit12.Text)) = 0 then
  begin
    IB_Edit12.Color := clWindow;
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit12,nil,3) then
  begin
    IB_Edit12.Color := clWindow;
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit12.SetFocus;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit13Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit13.Text)) = 0 then
  begin
    IB_Edit13.Color := clWindow;
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit13,nil,4) then
  begin
    IB_Edit13.Color := clWindow;
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit13.SetFocus;
  end;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit8KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure TfrmKASA_MUHTELIF.IB_Edit10KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure TfrmKASA_MUHTELIF.IB_Edit11KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure TfrmKASA_MUHTELIF.IB_Edit12KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure TfrmKASA_MUHTELIF.IB_Edit13KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;

procedure TfrmKASA_MUHTELIF.IB_Edit8Enter(Sender: TObject);
begin
  ib_Edit8.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit10Enter(Sender: TObject);
begin
  IB_Edit10.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit11Enter(Sender: TObject);
begin
  IB_Edit11.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit12Enter(Sender: TObject);
begin
  IB_Edit12.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit13Enter(Sender: TObject);
begin
  IB_Edit13.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_MUHTELIF.rgTIPEnter(Sender: TObject);
begin
  rgTIP.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_MUHTELIF.rgTIPExit(Sender: TObject);
begin
  rgTIP.Color := clBtnFace;
end;

procedure TfrmKASA_MUHTELIF.rdoCMEnter(Sender: TObject);
begin
  rdoCM.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_MUHTELIF.rdoCMExit(Sender: TObject);
begin
  rdoCM.Color := clBtnFace;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit6Exit(Sender: TObject);
begin
  if qryKASAHAR.State in [dssEdit,dssInsert] then
  begin
    if Trim(qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString) = '' then
    begin
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR.FieldByName('ACIKLAMA').AsString;
    end;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

function TfrmKASA_MUHTELIF.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryKASAHAR_MAS.FieldByName('TARIH').AsDate,True) then Exit;
  Result := True;
end;

function TfrmKASA_MUHTELIF.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

    if not DataMod.KAY_TAR_KONTROL(qryKASAHAR_MAS.FieldByName('TARIH').AsDate,True) then Exit;

  if qryKASAHAR.RecordCount = 0  Then
  begin
    Application.MessageBox('Kasa hareketi girmediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if trim(qryKASAHAR_MAS.FieldByName('ACIKLAMA').AsString) = '' then
  begin
    Application.MessageBox('Mutlaka bir açýklama belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  {Lite
  if trim(qryKASAHAR_MAS.FieldByName('YEVMIYE_ACK').AsString) = '' then
  begin
    Application.MessageBox('Mutlaka bir yevmiye açýklamasý belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  }
  if (qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    txtMAS_DOVKUR.SetFocus;
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if (qryKASAHAR_MAS.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if qryKASAHAR_MAS.FieldByName('KASADEGER').AsCurrency <= 0 then
  begin
    Application.MessageBox('Kasa deðeri sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryKASAHAR_MAS.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryKASAHAR_MAS.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  Result := True;
end;

procedure TfrmKASA_MUHTELIF.Form_Post;
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;

  try
    try
//****************************************************************************//
      if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
      if trnKASAMUH.inTransaction then
         trnKASAMUH.Rollback;
      trnKASAMUH.StartTransaction;
//****************************************************************************//
      qryKASAHAR.DisableControls;
//****************************************************************************//
      prnKASAHARID := qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsInteger;
      prnKASAHARSID := qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsSmallint;
//****************************************************************************//

//****************************************************************************//
      if not ON_MUHASEBE_SIL then
      begin
        frmISN_ERRORS.AnyErr(trnKASAMUH,PRV_ISN,0);
        trnKASAMUH.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;
//****************************************************************************//
      if not ON_MUHASEBE_ENT(0) then
      begin
        frmISN_ERRORS.AnyErr(trnKASAMUH,PRV_ISN,0);
        trnKASAMUH.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;
//****************************************************************************//
//****************************************************************************//
      qryKASAHAR.ApplyUpdates;
      qryKASAHAR.CommitUpdates;
      qryKASAHAR_MAS.Post;
      qryKASAHAR_MAS.ApplyUpdates;
      qryKASAHAR_MAS.CommitUpdates;
//****************************************************************************//
      dmLOGGER.dbaMain_StopMonitoringWrite2log('KASAHAR,',
                                               BT_KASA,
                                               prnKASAHARID,
                                               prnKASAHARSID,
                                               1,1,'');
//****************************************************************************//
      trnKASAMUH.Commit;
//****************************************************************************//
  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(142)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,142,14,2,rgYAZICI.ItemIndex,prnKASAHARID,prnKASAHARSID,0,'');
  end
  else

      if rgYAZICI.ItemIndex < 2 then Yazici.KASAMUHTELIF(prnKASAHARID,prnKASAHARSID,rgYAZICI.ItemIndex);
      prnKASAHARID := 0;
      prnKASAHARSID := 0;
//****************************************************************************//
    except
      trnKASAMUH.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      raise; {raise the exception to prevent a call to CommitUpdates!}
    end;
    qryKASAHAR.Active := False;
  finally
    qryKASAHAR.EnableControls;
  end;
end;

procedure TfrmKASA_MUHTELIF.Form_Delete;
var
  KASAHAR_ID,KASAHAR_SID : Integer;
begin
  if not Form_Before_Delete then exit;
  try
    try
      if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
//****************************************************************************//
      if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
      if trnKASAMUH.InTransaction then
         trnKASAMUH.Rollback;
      trnKASAMUH.StartTransaction;
//****************************************************************************//
      KASAHAR_ID := qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsInteger;
      KASAHAR_SID := qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsInteger;
//****************************************************************************//

//****************************************************************************//
      if not ON_MUHASEBE_SIL then
      //if not ON_MUHASEBE_SIL then
      begin
        frmISN_ERRORS.AnyErr(trnKASAMUH,PRV_ISN,0);
        trnKASAMUH.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;
//****************************************************************************//
      if not ON_MUHASEBE_ENT(1) then
      begin
        frmISN_ERRORS.AnyErr(trnKASAMUH,PRV_ISN,0);
        trnKASAMUH.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;
//****************************************************************************//

      qryKASAHAR.DisableControls;
      qryKASAHAR.First;
      while not qryKASAHAR.Eof do
      begin
        qryKASAHAR.Delete;
      end;
      qryKASAHAR.ApplyUpdates;
      qryKASAHAR.CommitUpdates;
      qryKASAHAR_MAS.Delete;
      qryKASAHAR_MAS.ApplyUpdates;
      qryKASAHAR_MAS.CommitUpdates;
//****************************************************************************//
      dmLOGGER.dbaMain_StopMonitoringWrite2log('KASAHAR,',
                                               BT_KASA,
                                               KASAHAR_ID,
                                               KASAHAR_SID,
                                               1,2,'');
//****************************************************************************//
      trnKASAMUH.Commit;
    except
      Application.MessageBox('Kasa Hareketi silinirken bir hata oluþtu','Dikkat',MB_ICONERROR);
      trnKASAMUH.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
    end;
  finally
    qryKASAHAR.EnableControls;
  end;
end;


procedure TfrmKASA_MUHTELIF.edtDOVKURExit(Sender: TObject);
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
    edtDOVKUR.SetFocus;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_MUHTELIF.edtTUTARExit(Sender: TObject);
begin
  if not (qryKASAHAR.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_MUHTELIF.txtMAS_DOVKURExit(Sender: TObject);
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;
  if (qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
    qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := 1;
    txtMAS_DOVKUR.SetFocus;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_MUHTELIF.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;


procedure TfrmKASA_MUHTELIF.txtKASA_KODEnter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmKASA_MUHTELIF.txtFIS_NOExit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKASA_MUHTELIF.cboDOVKODEnter(Sender: TObject);
begin
  cboDOVKOD.color := glb_Art_Alan_Renk;
end;

procedure TfrmKASA_MUHTELIF.cboDOVKODExit(Sender: TObject);
begin
  cboDOVKOD.color := clWindow;
end;

procedure TfrmKASA_MUHTELIF.IB_Edit1Exit(Sender: TObject);
begin
  if qryKASAHAR_MAS.State in [dssEdit,dssInsert] then
  begin
    if Trim(qryKASAHAR_MAS.FieldByName('YEVMIYE_ACK').AsString) = '' then
    begin
      qryKASAHAR_MAS.FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR_MAS.FieldByName('ACIKLAMA').AsString;
    end;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;


procedure TfrmKASA_MUHTELIF.txt_Cari_KodButtonClick(Sender: TObject);
var
  KARSI_AD,KARSI_KOD:String;
  MIK_TAK:SmallInt;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
    if frmCariSDLG.Form_Open(False,KARSI_KOD,KARSI_AD,1) Then
    begin
      qryKASAHAR_MAS.FieldByName('KARSIKOD').AsString := KARSI_KOD;
      qryKASAHAR_MAS.FieldByName('KARSI_AD').AsString := KARSI_AD;
    end;
end;

procedure TfrmKASA_MUHTELIF.txt_Cari_KodExit(Sender: TObject);
var
  KARSI_AD:String;
begin
  if not (qryKASAHAR_MAS.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if qryKASAHAR_MAS.FieldByName('KARSIKOD').AsString <> '' then
  begin

      if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',qryKASAHAR_MAS.FieldByName('KARSIKOD').AsString,KARSI_AD) then
      begin
        qryKASAHAR_MAS.FieldByName('KARSI_AD').AsString := KARSI_AD;
        my_Active_Comp.Brush.Color := clWindow;
      end
      else
      begin
        qryKASAHAR_MAS.FieldByName('KARSIKOD').AsString := '';
        qryKASAHAR_MAS.FieldByName('KARSI_AD').AsString :='' ;
        txt_Cari_Kod.SetFocus;
        Application.MessageBox('Lütfen iþlem yapacaðýnýz kodu seçiniz!!','Dikkat',MB_ICONSTOP);
        txt_Cari_KodButtonClick(Self);
      end;
  end;

end;

function TfrmKASA_MUHTELIF.ON_MUHASEBE_ENT(SIL:BYTE):Boolean;
begin
  Result := ON_MUH(SIL,True,qryKASAHAR);
end;

function TfrmKASA_MUHTELIF.ON_MUHASEBE_SIL:Boolean;
var
  qryKASAHAR_N:TIB_Query;
  BELGE_ID,BELGE_SID:Integer;
  HAREKET_BA:Char;
begin
  DataMod.CreateQuery(qryKASAHAR_N,trnKASAMUH,False,DataMod.dbaMain);
  with qryKASAHAR_N do
  begin
    sql.Add('SELECT * FROM KASAHAR WHERE ISLEM_TIP = 5 AND BELGE_ID = '+ qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsString + ' AND BELGE_SID = ' + qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsString);
    Active := True;
    if RecordCount = 0 then
    begin
      Result := True;
      exit;
    end;
  end;
  Result := ON_MUH(1,False,qryKASAHAR_N);
end;


function TfrmKASA_MUHTELIF.ON_MUH(SIL:Byte; ANAHAREKET:Boolean; KASAHAR:TIB_Query):Boolean;
var
  HAREKET_BA:Char;
  BELGE_ID,BELGE_SID:Integer;
  PROJE_SIL : Byte;
begin
  if qryKASAHAR_MAS.FieldByName('TIP').AsString[1] = GIRIS then
  begin
    HAREKET_BA := ALACAK;
  end
  else
  begin
    HAREKET_BA := BORC;
  end;

  KASAHAR.First;
  while not (KASAHAR.Eof) do
  begin
    if KASAHAR.FieldByName('MC').AsString = 'C' then
    begin
      if not DataMod.CARIHAR_AUD(trnKASAMUH,
                                     BT_KASA,
                                     KASAHAR.FieldbyName('KASAHAR_ID').AsInteger,
                                     KASAHAR.FieldbyName('KASAHAR_SID').AsInteger,
                                     1,
                                     Trim(KASAHAR.FieldbyName('KARSIKOD').AsString),
                                     HAREKET_BA,
                                     qryKASAHAR_MAS.FieldbyName('TARIH').AsDate,
                                     qryKASAHAR_MAS.FieldbyName('TARIH').AsDate,
                                     qryKASAHAR_MAS.FieldbyName('DOV_BAZ_TAR').AsDate,
                                     KASAHAR.FieldbyName('TUTAR').AsCurrency,
                                     KASAHAR.FieldbyName('DOVKOD').AsString,
                                     KASAHAR.FieldbyName('DOVKUR').AsCurrency,
                                     KASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                                     qryKASAHAR_MAS.FieldbyName('TARIH').AsDate,
//                                     KASAHAR.FieldbyName('YEVMIYE_ACK').AsString,
                                     KASAHAR.FieldbyName('ACIKLAMA').AsString,
                                     SIL,
                                     PRV_ISN,
                                     qryKASAHAR_MAS.FieldbyName('MASRAF_MERK').AsString,
                                     qryKASAHAR_MAS.FieldbyName('KOD1').AsString,
                                     qryKASAHAR_MAS.FieldbyName('KOD2').AsString,
                                     qryKASAHAR_MAS.FieldbyName('KOD3').AsString,
                                     qryKASAHAR_MAS.FieldbyName('KOD4').AsString,
                                     qryKASAHAR_MAS.FieldbyName('PLASIYER_KOD').AsString,
                                     qryKASAHAR_MAS.FieldbyName('PROJE_KOD').AsString,
                                     BELGE_ID,
                                     BELGE_SID) then
      begin
        Result := False;
        Exit;
      end;
    end
    else
    begin
      if not DataMod.MASRAFHAR_AUD(trnKASAMUH,
                                   BT_KASA,
                                   KASAHAR.FieldbyName('KASAHAR_ID').AsInteger,
                                   KASAHAR.FieldbyName('KASAHAR_SID').AsInteger,
                                   1,
                                   Trim(KASAHAR.FieldbyName('KARSIKOD').AsString),
                                   HAREKET_BA,
                                   qryKASAHAR_MAS.FieldbyName('TARIH').AsDate,
                                   qryKASAHAR_MAS.FieldbyName('DOV_BAZ_TAR').AsDate,
                                   KASAHAR.FieldbyName('TUTAR').AsCurrency,
                                   KASAHAR.FieldbyName('DOVKOD').AsString,
                                   KASAHAR.FieldbyName('DOVKUR').AsCurrency,
                                   KASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
//                                   KASAHAR.FieldbyName('YEVMIYE_ACK').AsString,
                                   KASAHAR.FieldbyName('ACIKLAMA').AsString,
                                   SIL,
                                   qryKASAHAR_MAS.FieldbyName('MASRAF_MERK').AsString,
                                   qryKASAHAR_MAS.FieldbyName('KOD1').AsString,
                                   qryKASAHAR_MAS.FieldbyName('KOD2').AsString,
                                   qryKASAHAR_MAS.FieldbyName('KOD3').AsString,
                                   qryKASAHAR_MAS.FieldbyName('KOD4').AsString,
                                   BELGE_ID,
                                   BELGE_SID) then
      begin
        Result := False;
        Exit;
      end;

    end;


  // KARSILIK KASAHAREKETLERÝNDEN PROJENÝN ÇIKARTILMASI
  //  BURAK 16/07/2004
  {
    if SIL <> 1 then
    begin
      if Trim(qryKASAHAR.FieldByName('PROJE_KOD').AsString) = '' then
      begin
        PROJE_SIL := 1;
      end
      else
      begin
        PROJE_SIL := 0;
      end;
    end;

    if SIL = 1 then
    begin
      PROJE_SIL := SIL;
    end;

    if not DataMod.SPP_PROJEHAR_AUD(trnKASAMUH,
                                    BT_KASA,
                                    KASAHAR.FieldbyName('KASAHAR_ID').AsInteger,
                                    KASAHAR.FieldbyName('KASAHAR_SID').AsInteger,
                                    1,
                                    KASAHAR.FieldbyName('PROJE_KOD').AsString,
                                    qryKASAHAR_MAS.FieldbyName('TARIH').AsDate,
                                    qryKASAHAR_MAS.FieldbyName('TARIH').AsDate,
                                    qryKASAHAR_MAS.FieldbyName('DOV_BAZ_TAR').AsDate,
                                    qryKASAHAR_MAS.FieldbyName('TARIH').AsDate,
                                    HAREKET_BA,
                                    KASAHAR.FieldbyName('DOVKOD').AsString,
                                    KASAHAR.FieldbyName('DOVKUR').AsCurrency,
                                    KASAHAR.FieldbyName('TUTAR').AsCurrency,
                                    KASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                                    PROJE_SIL,
                                    KASAHAR.FieldbyName('YEVMIYE_ACK').AsString,
                                    PRV_ISN,
                                    qryKASAHAR_MAS.FieldbyName('MASRAF_MERK').AsString,
                                    qryKASAHAR_MAS.FieldbyName('KOD1').AsString,
                                    qryKASAHAR_MAS.FieldbyName('KOD2').AsString,
                                    qryKASAHAR_MAS.FieldbyName('KOD3').AsString,
                                    qryKASAHAR_MAS.FieldbyName('KOD4').AsString,
                                    BELGE_ID,
                                    BELGE_SID) then

    begin
      Result := False;
      Exit;
    end;}
    KASAHAR.Next;
  end;

  if ANAHAREKET then
  begin
    if qryKASAHAR_MAS.FieldByName('TIP').AsString[1] = GIRIS then
    begin
      HAREKET_BA := BORC
    end
    else
    begin
      HAREKET_BA := ALACAK;
    end;

    if SIL <> 1 then if Trim(qryKASAHAR_MAS.FieldByName('PROJE_KOD').AsString) = '' then
    begin
      PROJE_SIL:=1
    end
    else
    begin
      PROJE_SIL := 0;
    end;

    if SIL = 1 then
    begin
      PROJE_SIL := SIL;
    end;

    if not DataMod.PROJEHAR_AUD(trnKASAMUH,
                                    BT_KASA,
                                    qryKASAHAR_MAS.FieldbyName('KASAHAR_ID').AsInteger,
                                    qryKASAHAR_MAS.FieldbyName('KASAHAR_SID').AsInteger,
                                    1,
                                    qryKASAHAR_MAS.FieldbyName('PROJE_KOD').AsString,
                                    qryKASAHAR_MAS.FieldByName('TARIH').AsDate,
                                    qryKASAHAR_MAS.FieldByName('TARIH').AsDate,
                                    qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,
                                    qryKASAHAR_MAS.FieldByName('TARIH').AsDate,
                                    HAREKET_BA,
                                    qryKASAHAR_MAS.FieldbyName('DOVKOD').AsString,
                                    qryKASAHAR_MAS.FieldbyName('DOVKUR').AsCurrency,
                                    qryKASAHAR_MAS.FieldbyName('TUTAR').AsCurrency,
                                    qryKASAHAR_MAS.FieldbyName('TUTAR_VPB').AsCurrency,
                                    PROJE_SIL,
                                    qryKASAHAR_MAS.FieldbyName('ACIKLAMA').AsString,
                                    PRV_ISN,
                                    qryKASAHAR_MAS.FieldByName('MASRAF_MERK').AsString,
                                    qryKASAHAR_MAS.FieldByName('KOD1').AsString,
                                    qryKASAHAR_MAS.FieldByName('KOD2').AsString,
                                    qryKASAHAR_MAS.FieldByName('KOD3').AsString,
                                    qryKASAHAR_MAS.FieldByName('KOD4').AsString,
                                    BELGE_ID,
                                    BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

procedure TfrmKASA_MUHTELIF.qryKASAHARAfterScroll(IB_Dataset: TIB_Dataset);
begin
  if IB_Dataset.FieldByName('MC').AsString = 'M' then
  begin
    txtKARSI_KOD.AutoLabel.Caption := 'Masraf';
  end
  else
  begin
    txtKARSI_KOD.AutoLabel.Caption := 'Cari';
  end;
end;

procedure TfrmKASA_MUHTELIF.rgTIPChange(Sender: TObject);
begin
  case rgTIP.ItemIndex of
  0:
    begin
      qryKASAHAR_MAS.FieldByName('TIP').AsString := GIRIS;
    end;
  1:
    begin
      qryKASAHAR_MAS.FieldByName('TIP').AsString := CIKIS;
    end;
  end;
end;

procedure TfrmKASA_MUHTELIF.btnCiktiClick(Sender: TObject);
begin
  if (prnKASAHARID = 0) and (prnKASAHARSID = 0) then exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(142)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,142,14,2,rgYAZICI.ItemIndex,prnKASAHARID,prnKASAHARSID,0,'');
  end
  else
  if rgYAZICI.ItemIndex < 2 then Yazici.KASAMUHTELIF(prnKASAHARID,prnKASAHARSID,rgYAZICI.ItemIndex);
end;

procedure TfrmKASA_MUHTELIF.txtFIS_NOEnter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmKASA_MUHTELIF.KasaMuhtelifTahsilTediyeKaydnKopyala1Click(
  Sender: TObject);
var
  ID,SID:String;
begin
  if not qryKASAHAR_MAS.Active then
  begin
    Application.MessageBox('Olmayan bir kasa hareketi üzerinden kopyalama iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryKASAHAR_MAS.State in [dssInsert] then
  begin
    Application.MessageBox('Yeni kayýt durumunda kopyalama iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  ID := qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsString;
  SID := qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsString;

  rgYAZICI.ItemIndex := 2;

  btnTRN_IPTALClick(Self);

  if not qryKASAHAR_MAS.Active then
  begin
    if not DEKONT_AUT.KasaMuhtelifKopyala(ID,SID) then
    begin
      Application.MessageBox('Kasa - Muhtelif Tahsil / Tediye kaydýný kopyalama iþlemi sýrasýnda hata oluþtu.','Dikkat',MB_ICONWARNING);
    end;
  end;

end;

procedure TfrmKASA_MUHTELIF.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 KASAHAR_ID,KASAHAR_SID FROM KASAHAR  WHERE ISLEM_TIP = 5 AND SIRA_NO=1 AND KASAHAR_ID<:KASAHAR_ID AND KASAHAR_SID=:KASAHAR_SID ORDER BY KASAHAR_ID DESC';
     qryDeg1.ParamByName('KASAHAR_ID').AsInteger:=qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsInteger;
     qryDeg1.ParamByName('KASAHAR_SID').AsInteger:=qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsInteger;
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

procedure TfrmKASA_MUHTELIF.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 KASAHAR_ID,KASAHAR_SID FROM KASAHAR  WHERE ISLEM_TIP = 5 AND SIRA_NO=1 AND KASAHAR_ID>:KASAHAR_ID AND KASAHAR_SID=:KASAHAR_SID ORDER BY KASAHAR_ID';
     qryDeg1.ParamByName('KASAHAR_ID').AsInteger:=qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsInteger;
     qryDeg1.ParamByName('KASAHAR_SID').AsInteger:=qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsInteger;
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

procedure TfrmKASA_MUHTELIF.Geri_AL;
begin
     qryKASAHAR.CancelUpdates;
     qryKASAHAR.Close;

     qryKASAHAR_MAS.CancelUpdates;
     qryKASAHAR_MAS.Close;

     trnKASAMUH.Rollback;
end;

end.
