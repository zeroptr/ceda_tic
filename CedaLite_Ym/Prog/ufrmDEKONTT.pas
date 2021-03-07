{$INCLUDE directive.inc}

unit ufrmDEKONTT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ComCtrls, IB_Grid, StdCtrls, IB_Controls, Grids,
  ExtCtrls, Mask, Buttons, IB_StoredProc, IB_TransactionBar, IB_DatasetBar,
  Menus;
type
  TfrmDEKONTT = class(TForm)
    pcDEKONT: TPageControl;
    tabMASTER: TTabSheet;
    tabDETAY: TTabSheet;
    qryDEKONT: TIB_Query;
    dtsDEKONT: TIB_DataSource;
    edtACIKLAMA: TIB_Edit;
    IB_Date1: TIB_Date;
    dtpDOVBAZTAR: TIB_Date;
    sbDEKONT: TStatusBar;
    qryDEKONT_D: TIB_Query;
    dtsDEKONT_D: TIB_DataSource;
    Panel1: TPanel;
    grdDekontKontrol: TIB_Grid;
    rdoCM: TIB_RadioGroup;
    IB_RadioGroup2: TIB_RadioGroup;
    txtKARSI_KOD: TIB_Edit;
    edtDOVKUR: TIB_Currency;
    edtTUTAR: TIB_Currency;
    edtTUTAR_VPB: TIB_Currency;
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
    btnDekontSil: TButton;
    IB_Edit1: TIB_Edit;
    IB_Edit5: TIB_Edit;
    txtProjeKod: TIB_Edit;
    IB_Edit9: TIB_Edit;
    trnDEKONT: TIB_Transaction;
    IB_Edit6: TIB_Edit;
    Button1: TButton;
    IB_Edit2: TIB_Edit;
    IB_Edit7: TIB_Edit;
    cboDOVKOD: TIB_ComboBox;
    btnCikti: TButton;
    rgYAZICI: TRadioGroup;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    PopupMenu1: TPopupMenu;
    DekontuablonOlarakKopyala1: TMenuItem;
    DekontKopyala1: TMenuItem;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    txtUrunKodu: TIB_Edit;
    IB_Edit23: TIB_Edit;
    txtOlcuBirim: TIB_Edit;
    IB_Currency7: TIB_Currency;
    IB_Currency5: TIB_Currency;
    IB_ComboBox1: TIB_ComboBox;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_Currency3: TIB_Currency;
    txtDepoKod: TIB_Edit;
    txtDepoAd: TIB_Edit;
    IB_Edit22: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Currency4: TIB_Currency;
    IB_Currency6: TIB_Currency;
    rg_Giris_Cikis: TIB_RadioGroup;
    txtCari_Kod: TIB_Edit;
    IB_Edit4: TIB_Edit;
    Cb_Aciklama: TIB_ComboBox;
    Cb_Aciklama1: TIB_ComboBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure trnDEKONTAfterCommit(Sender: TIB_Transaction);
    procedure btnCikisClick(Sender: TObject);
    procedure btnYENIClick(Sender: TObject);
    procedure pcDEKONTChanging(Sender: TObject; var AllowChange: Boolean);
    procedure txtKARSI_KODButtonClick(Sender: TObject);
    procedure rdoCMClick(Sender: TObject);
    procedure qryDEKONT_DAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dtsDEKONT_DDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure btnEKLEClick(Sender: TObject);
    procedure btnKAYDETClick(Sender: TObject);
    procedure dtsDEKONT_DStateChanged(Sender: TIB_DataSource;       ADataset: TIB_Dataset);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure btnSILClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnAraClick(Sender: TObject);
    procedure txtOLCUBIRIMButtonClick(Sender: TObject);
    procedure dtsDEKONTStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
    procedure btnDekontSilClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtKARSI_KODEnter(Sender: TObject);
    procedure txtKARSI_KODExit(Sender: TObject);
    procedure txtKARSI_KODKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKARSI_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txtProjeKodButtonClick(Sender: TObject);
    procedure txtProjeKodEnter(Sender: TObject);
    procedure txtProjeKodExit(Sender: TObject);
    procedure txtProjeKodKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtProjeKodKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure qryDEKONT_DAfterPost(IB_Dataset: TIB_Dataset);
    procedure qryDEKONT_DAfterDelete(IB_Dataset: TIB_Dataset);
    procedure qryDEKONT_DAfterOpen(IB_Dataset: TIB_Dataset);
    procedure IB_Edit8Exit(Sender: TObject);
    procedure IB_Edit10Exit(Sender: TObject);
    procedure IB_Edit11Exit(Sender: TObject);
    procedure IB_Edit12Exit(Sender: TObject);
    procedure IB_Edit13Exit(Sender: TObject);
    procedure IB_Edit8ButtonClick(Sender: TObject);
    procedure IB_Edit10ButtonClick(Sender: TObject);
    procedure IB_Edit11ButtonClick(Sender: TObject);
    procedure IB_Edit12ButtonClick(Sender: TObject);
    procedure IB_Edit13ButtonClick(Sender: TObject);
    procedure IB_Edit8KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit10KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit11KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit12KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit13KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure IB_Edit2ButtonClick(Sender: TObject);
    procedure IB_Edit2Enter(Sender: TObject);
    procedure IB_Edit2Exit(Sender: TObject);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit2KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure edtDOVKURExit(Sender: TObject);
    procedure edtTUTARExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure qryDEKONT_DAfterScroll(IB_Dataset: TIB_Dataset);
    procedure btnCiktiClick(Sender: TObject);
    procedure qryDEKONT_DBeforePost(IB_Dataset: TIB_Dataset);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Post;
    procedure Form_Delete;
    procedure BakiyeHesapla;
    procedure DataSet_Open(DEKONT_ID:Integer;DEKONT_SID:Integer;ISLEM:Byte;TIP:SmallInt);
    function Form_Open(Menu:Boolean;DEKONT_ID:Integer;DEKONT_SID:Integer;ISLEM:Byte;TIP:SmallInt;Visible:Boolean):Boolean;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;

    function ON_MUHASEBE_ENT(SIL:BYTE):Boolean;
    function ON_MUHASEBE_SIL:Boolean;
    function ON_MUH(SIL:Byte; KASAHAR:TIB_Query):Boolean;
    procedure DekontuablonOlarakKopyala1Click(Sender: TObject);
    procedure DekontKopyala1Click(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure txtUrunKoduButtonClick(Sender: TObject);
    procedure txtUrunKoduEnter(Sender: TObject);
    procedure txtUrunKoduExit(Sender: TObject);
    procedure txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
    procedure txtUrunKoduKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure txtOlcuBirimEnter(Sender: TObject);
    procedure txtOlcuBirimExit(Sender: TObject);
    procedure txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
    procedure txtOlcuBirimKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtDepoKodButtonClick(Sender: TObject);
    procedure txtDepoKodEnter(Sender: TObject);
    procedure txtDepoKodExit(Sender: TObject);
    procedure txtDepoKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtDepoKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryDEKONTAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FR(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure txtCari_KodButtonClick(Sender: TObject);
    procedure txtCari_KodEnter(Sender: TObject);
    procedure txtCari_KodExit(Sender: TObject);
    procedure txtCari_KodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtCari_KodKeyPress(Sender: TObject; var Key: Char);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prv_BORC,prv_ALACAK,prv_BAKIYE:Currency;
    prv_MUH_FIS_FARK : SmallInt; /// formdan cýkýlsýnmý
    my_Active_Comp:TWinControl;
    Muh_Kod,Aciklama:String;
    prv_ISN,prn_DEKONT_ID,prn_DEKONT_SID:Integer;
    prv_CanUpdate,prv_CanDelete:Boolean;
    prv_OlcuBirim_Kontrol:Boolean;
    Prv_URUNHAR_ID:Integer;
    Prv_URUNHAR_SID:Integer;
    prv_KDV_HESAPLA:Boolean;
    procedure Geri_AL;
    function URUN_HAR_SIL: Boolean;

  public
    { Public declarations }
  end;

  const cns_dekont = 15;

var
  frmDEKONTT: TfrmDEKONTT;

implementation

uses unDataMod,ufrmCariSDLG, ufrmISN_ERRORS, ufrmDekontSDLG, unFunc,
      main, unYAZICI, unLogger, DateUtils, unDEKONT_AUT, ufrmUrunSDLG,
  UDm_Fast_Report;

{$R *.dfm}

{ Dikkat TIP deðiþkeninde 1 ise Serbest Dekont }
function TfrmDEKONTT.Form_Open(Menu:Boolean;DEKONT_ID:Integer;DEKONT_SID:Integer;ISLEM:Byte;TIP:SmallInt;Visible:Boolean):Boolean;
// ISLEM : 0 INSERT ;; 1 EDIT
var
  local_can_update,local_can_delete:Boolean;
  qryDeg:TIB_Query;
begin
  Result := False;
  if not DataMod.Modul_Hak(cns_dekont,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((DEKONT_ID = 0) and (DEKONT_SID = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;

    if MainForm.FindChildFrm( Application, 'frmDEKONTT') then
    begin
      Application.MessageBox ('Dekont Ýþlemleri modülü açýk.','Dikkat',MB_ICONWARNING);
      Exit;
    end
    else
    begin
      Application.CreateForm (TfrmDEKONTT,frmDEKONTT);
    end;



    with frmDEKONTT do
    begin
        DataMod.CreateQuery(qryDeg,trnDEKONT,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT ACIKLAMA FROM DEKONT';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            Cb_Aciklama.Items.Add(qryDeg.FieldByName('ACIKLAMA').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT ACIKLAMA1 FROM DEKONT_D';
        qryDeg.Open;
        While not qryDeg.Eof do
        begin
            Cb_Aciklama1.Items.Add(qryDeg.FieldByName('ACIKLAMA1').asString);
            qryDeg.Next;
        end;

//****************************************************************************//
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
  {$IfnDef TRANSPORT}
//****************************************************************************//
      if not glb_PROJE_UYG then
      begin
        txtProjeKod.Visible := false;
        IB_Edit9.Visible := false;
        IB_Edit7.Visible := false;
        IB_Edit2.Visible := false;
      end;
  {$EndIf}

  {$IfDef TRANSPORT}
        txtProjeKod.Visible := false;
        IB_Edit9.Visible := false;
        IB_Edit7.Visible := false;
        IB_Edit2.Visible := false;
  {$EndIf}


  {$IfDef TRANSPORT}
    rgYAZICI.itemindex:=2;
    grpRapKod.Visible := false;
  {$EndIf}

  {$IfDef EGEM}
        txtProjeKod.Visible := false;
        IB_Edit9.Visible := false;
        IB_Edit7.Visible := false;
        IB_Edit2.Visible := false;
  {$EndIf}



  //****************************************************************************//
      if not glb_DOVTAKIP then
      begin
        cboDOVKOD.Visible := False;
        edtDOVKUR.Visible := False;
        edtTUTAR_VPB.Visible := False;
        dtpDOVBAZTAR.Visible := False;
      end;
      pcDEKONT.ActivePage := frmDEKONTT.tabMASTER;
      frmDEKONTT.DataSet_Open(DEKONT_ID,DEKONT_SID,ISLEM,TIP);
    end;
    Result := True;
  end;
end;

procedure TfrmDEKONTT.Dataset_Open(DEKONT_ID:Integer;DEKONT_SID:Integer;ISLEM:Byte;TIP:SmallInt);
begin
  if ((DEKONT_ID = 0) and (DEKONT_SID = 0) and ( prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataMod.Rapor_Kod_Visible_Fields_IB('DEKONT',ib_edit8,ib_edit10,ib_edit11,ib_edit12,ib_edit13);
  prv_ISN := DataMod.Get_Isn_Num;
  with qryDEKONT do
  begin
    Active := False;
    ParamByName('PRM_DEKONT_ID').AsInteger := DEKONT_ID;
    ParamByName('PRM_DEKONT_SID').AsInteger := DEKONT_SID;
    Active := True;
  end;
//****************************************************************************//
  prn_DEKONT_ID := DEKONT_ID;
  prn_DEKONT_SID := DEKONT_SID;
//****************************************************************************//
  prv_MUH_FIS_FARK:=StrToInt(DataMod.GetParam(15,'SDK_BAKIYE',0));
  case ISLEM of
  0:
    begin // yeni kayýt
      with qryDEKONT do
      begin
        Insert;
        FieldByName('TIP').AsSmallint := TIP;
        FieldByName('ISLEM_TAR').AsDate := DataMod.GET_SERVER_DATE;;
        FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('ISLEM_TAR').AsDate;
        FieldByName('DEKONT_SID').AsSmallint := glb_SID;
      end;
    end;
  1:
    begin
      qryDEKONT.Edit;
    end;
  end;
//****************************************************************************//
  with qryDEKONT_D do
  begin
    Active := False;
    ParamByName('PRM_DEKONT_ID').AsInteger := qryDEKONT.FieldByName('DEKONT_ID').AsInteger;
    ParamByName('PRM_DEKONT_SID').AsInteger := qryDEKONT.FieldByName('DEKONT_SID').AsInteger;
    Active := True;
  end;
  prv_KDV_HESAPLA:=False;
//****************************************************************************//
  btnYENI.Enabled := False;
  btnTRN_KAYDET.Enabled  := True;
  btnTRN_IPTAL.Enabled := True;
  btnCikis.Enabled := False;
  btnAra.Enabled := False;
end;

procedure TfrmDEKONTT.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if pcDEKONT.ActivePage = tabDETAY then
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
  if pcDEKONT.ActivePage = tabMASTER Then
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
      46: if btnDekontSil.Enabled Then btnDekontSilClick(self);
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
    VK_F6:pcDEKONT.SelectNextPage(True);
  end;
end;

procedure TfrmDEKONTT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDEKONTT.btnTRN_IPTALClick(Sender: TObject);
begin
  if Sender.ClassName <> 'TButton'  then
  begin
    qryDEKONT_D.CancelUpdates;
    qryDEKONT.CancelUpdates;
    qryDEKONT_D.CommitUpdates;
    qryDEKONT.CommitUpdates;
    qryDEKONT.Active := False;
    qryDEKONT_D.Active := False;
//****************************************************************************//
    if trnDEKONT.InTransaction then
       trnDEKONT.Rollback;
    dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
    btnYENI.Enabled := True;
    btnTRN_KAYDET.Enabled  := False;
    btnTRN_IPTAL.Enabled := False;
    btnCikis.Enabled := True;
    btnAra.Enabled := True;
    btnSIL.Enabled := False;
    prn_DEKONT_ID := 0;
    prn_DEKONT_SID := 0;
  end
  else
  begin
    case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO) of
    ID_YES:
      begin
        qryDEKONT_D.CancelUpdates;
        qryDEKONT.CancelUpdates;
        qryDEKONT_D.CommitUpdates;
        qryDEKONT.CommitUpdates;
        qryDEKONT.Active := False;
        qryDEKONT_D.Active := False;
//****************************************************************************//
        if trnDEKONT.InTransaction then
           trnDEKONT.Rollback;
        dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
        btnYENI.Enabled := True;
        btnTRN_KAYDET.Enabled  := False;
        btnTRN_IPTAL.Enabled := False;
        btnCikis.Enabled := True;
        btnAra.Enabled := True;
        btnSIL.Enabled := False;
        prn_DEKONT_ID := 0;
        prn_DEKONT_SID := 0;
      end;
    end;
  end;
end;

procedure TfrmDEKONTT.trnDEKONTAfterCommit(Sender: TIB_Transaction);
begin
  btnYENI.Enabled := True;
  btnTRN_KAYDET.Enabled := False;
  btnTRN_IPTAL.Enabled := False;
  btnCikis.Enabled := True;
  btnAra.Enabled := True;
end;

procedure TfrmDEKONTT.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDEKONTT.btnYENIClick(Sender: TObject);
begin
  DataSet_Open(0,0,0,1);
end;

procedure TfrmDEKONTT.pcDEKONTChanging(Sender: TObject;  var AllowChange: Boolean);
begin
  case pcDEKONT.ActivePageIndex of
  0:
    begin
      qryDEKONT.UpdateData;
      if qryDEKONT.FieldByName('DEKONT_ID').AsInteger = 0 then
      begin
        Application.MessageBox('Dekont No olmadan bu sayfaya geçemezsiniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
        Exit;
      end;
      if trim(qryDEKONT.FieldByName('ACIKLAMA').AsString) = '' then
      begin
        edtACIKLAMA.SetFocus;
        Application.MessageBox('Mutlaka bir açýklama belirtmelisiniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
        Exit;
      end;
    end;
  1:
    begin
      if  qryDekont_D.State in [dssInsert,dssEdit] Then
      begin
        Application.MessageBox('Deðiþiklikleri kaydediniz ya da iptal ediniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
      end
      else
      begin
        if prv_MUH_FIS_FARK = 1 then
        begin
          if (prv_BAKIYE >= 0.01) Then
          begin
            Application.MessageBox('Bakiye veren dekonttan çýkamazsýnýz.','Dikkat',MB_ICONWARNING);
            AllowChange := False;
          end;
        end;
      end;
    end; //1 end;
  end;//Case End;
end;

procedure TfrmDEKONTT.txtKARSI_KODButtonClick(Sender: TObject);
var
  KARSI_AD,KARSI_KOD:String;
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then exit;
  if qryDEKONT_D.FieldByName('MC').AsString = 'C' then
  begin
    if frmCariSDLG.Form_Open(False,KARSI_KOD,KARSI_AD,1) Then
    begin
      qryDEKONT_D.FieldByName('KARSI_KOD').AsString := KARSI_KOD;
      qryDEKONT_D.FieldByName('KARSI_AD').AsString := KARSI_AD;
    end;
  end
  else
  begin
    if DataMod.LS_MASRAFTAN(KARSI_KOD) then
    begin
      qryDEKONT_D.FieldByName('KARSI_KOD').AsString := KARSI_KOD;
      DataMod.FN_KOD2AD('MASRAF','MASRAF_KOD','ADI',KARSI_KOD,KARSI_AD);
      qryDEKONT_D.FieldByName('KARSI_AD').AsString := KARSI_AD;
    end;
  end;
end;

procedure TfrmDEKONTT.rdoCMClick(Sender: TObject);
begin
  if rdoCM.ItemIndex = 0 then
  begin
    txtKARSI_KOD.AutoLabel.Caption := 'Cari';
  end
  else
  begin
    txtKARSI_KOD.AutoLabel.Caption := 'Masraf';
  end;
  qryDEKONT_D.FieldByName('KARSI_KOD').AsString := '';
  qryDEKONT_D.FieldByName('KARSI_AD').AsString := '';
end;

procedure TfrmDEKONTT.qryDEKONT_DAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with IB_Dataset do
  begin
    FieldByName('DEKONT_D_SID').AsInteger := glb_SID;
    FieldByName('DEKONT_ID').AsInteger := qryDEKONT.FieldByName('DEKONT_ID').AsInteger;
    FieldByName('DEKONT_SID').AsInteger := qryDEKONT.FieldByName('DEKONT_SID').AsInteger;
    FieldByName('DOVKOD').AsString := glb_DEFCUR ;
    FieldByName('MIKTAR').AsCurrency := 0;
    FieldByName('ACIKLAMA1').AsString :=  qryDEKONT.FieldByName('ACIKLAMA').AsString;
    FieldByName('PROJE_KOD').AsString :=  qryDEKONT.FieldByName('PROJE_KOD').AsString;
    FieldByName('PROJE_AD').AsString :=  qryDEKONT.FieldByName('PROJE_AD').AsString;


    if qryDEKONT.FieldByName('CARI_KOD').AsString<>'' then
    begin
    FieldByName('KARSI_KOD').AsString :=  qryDEKONT.FieldByName('CARI_KOD').AsString;
    FieldByName('KARSI_AD').AsString :=  qryDEKONT.FieldByName('CARI_ADI').AsString;
    end;

    FieldByName('MC').AsString := 'C';
    FieldByName('BA').AsString := BORC;
  end;
  if not glb_DOVTAKIP then
  begin
    qryDEKONT_D.FieldByName('DOVKOD').AsString := glb_DEFCUR ;
    qryDEKONT_D.FieldByName('DOVKUR').AsCurrency := 1;
  end;


  if Trim(qryDEKONT.FieldByName('URUN_KOD').AsString)<>'' then
  begin
    qryDEKONT_D.FieldByName('TUTAR').AsFloat :=
    qryDEKONT.FieldByName('TUTAR').AsFloat;
    qryDEKONT_D.FieldByName('DOVKOD').AsString := qryDEKONT.FieldByName('DOVKOD').AsString

  end;

end;

procedure TfrmDEKONTT.dtsDEKONT_DDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
var
  DOV_KUR:Currency;
begin
  if Assigned( Field ) Then
  begin
    if (Field.FieldName='DOVKOD') Then
    begin
      DOV_KUR := DataMod.Get_Doviz_Kur(qryDekont_D.FieldByName('DOVKOD').AsString,qryDEKONT.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
      if DOV_KUR=0 Then
      begin
        qryDEKONT_D.FieldByName('DOVKUR').AsCurrency := 1;
      end
      else
      begin
        qryDEKONT_D.FieldByName('DOVKUR').AsExtended := DOV_KUR;
        qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency := qryDEKONT_D.FieldByName('DOVKUR').AsCurrency * qryDEKONT_D.FieldByName('TUTAR').AsCurrency;
      end;
    end
    else
    if Field.FieldName = 'TUTAR' Then
    begin
      qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency := qryDEKONT_D.FieldByName('DOVKUR').AsCurrency * qryDEKONT_D.FieldByName('TUTAR').AsCurrency;
    end
    else
    if Field.FieldName = 'DOVKUR' Then
    begin
      qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency := qryDEKONT_D.FieldByName('DOVKUR').AsCurrency * qryDEKONT_D.FieldByName('TUTAR').AsCurrency;
    end;
  end;
end;

procedure TfrmDEKONTT.btnEKLEClick(Sender: TObject);
begin
  qryDEKONT_D.Append;
  rdoCM.SetFocus;
End;

procedure TfrmDEKONTT.btnKAYDETClick(Sender: TObject);
var
  FuncDeger,KARSI_AD:String;
begin
  if Length(qryDEKONT_D.FieldByName('KARSI_KOD').AsString) = 0 then
  begin
    txtKARSI_KOD.SetFocus;
    Application.MessageBox('Lütfen iþlem yapacaðýnýz kodu seçiniz!!','Dikkat',MB_ICONSTOP);
    txtKARSI_KODButtonClick(Self);
    exit;
  end
  else
  begin
    if qryDEKONT_D.FieldByName('MC').AsString = 'M' then
    begin
      if not DataMod.FN_KOD2AD('MASRAF','MASRAF_KOD','ADI',qryDEKONT_D.FieldByName('KARSI_KOD').AsString,KARSI_AD) then
      begin
        Application.MessageBox('Lütfen listeden bir masraf kodu seçiniz.','Dikkat',MB_ICONWARNING);
        txtKARSI_KODButtonClick(Self);
        Exit;
      end;
    end
    else
    begin
      if not (DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',qryDEKONT_D.FieldByName('KARSI_KOD').AsString,KARSI_AD)) then
      begin
        Application.MessageBox('Lütfen listeden bir cari kod seçiniz.','Dikkat',MB_ICONWARNING) ;
        txtKARSI_KODButtonClick(Self);
        exit;
      end;
    end;
  end;

  //burada glb_dov_takip ile döviz kontrolu yapýlmasý gerekiyor mu
  //þu anda kontrol edilmiyor.

  if (qryDEKONT_D.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    edtDOVKUR.SetFocus;
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if glb_DOVTAKIP then
  begin
    if (qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
    begin
      edtTUTAR.SetFocus;
      Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
      exit;
    end;
  end;

  if Trim(qryDEKONT_D.FieldByName('ACIKLAMA1').AsString)='' then
  begin
    IB_Edit6.SetFocus;
    Application.MessageBox('Lütfen açýklama alanýna gerekli açýklamayý yazýnýz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  FuncDeger:=DataMod.Before_Post_Kontrol(qryDEKONT_D ,'DEKONT_D','KARSI_KOD,TUTAR','');

  if FuncDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Exit;
  end;
  qryDEKONT_D.Post;
end;

procedure TfrmDEKONTT.dtsDEKONT_DStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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
    if not ((qryDEKONT_D.Eof) and (qryDEKONT_D.Bof)) then
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

procedure TfrmDEKONTT.btnTRN_KAYDETClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmDEKONTT.btnIptalClick(Sender: TObject);
begin
  qryDEKONT_D.Cancel;
end;

procedure TfrmDEKONTT.btnSILClick(Sender: TObject);
begin
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz.','Dikkat',MB_YESNO) = IDNO then Exit;
  qryDEKONT_D.Delete;
end;

procedure TfrmDEKONTT.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  if dtsDEKONT.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Formdan çýkmak için yaptýðýnýz iþlemi dekont tabýnda kaydetmeli ya da iptal etmelisiniz.','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmDEKONTT.btnAraClick(Sender: TObject);
var
  Dekont_ID,Dekont_SID:Integer;
begin
  if frmDekontSDLG.form_Open (True,Dekont_ID,Dekont_SID,1) Then
  begin
    DataSet_Open(Dekont_ID,Dekont_SID,1,1);
  end;
end;

procedure TfrmDEKONTT.txtOLCUBIRIMButtonClick(Sender: TObject);
var
  OlcuBir,strSQL:String;
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if qryDEKONT.FieldByName('URUN_KOD').AsString <> '' Then
  begin
    strSQL:='SELECT OLCU_TIP FROM URUN WHERE URUN_KOD='+ SQL_Katar(qryDEKONT.FieldByName('URUN_KOD').AsString);
    with DataMod.qryGENEL do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True ;
    end;

    if DataMod.LS_OlcuBrm(DataMod.qryGenel.FieldByname('OLCU_TIP').AsString  ,OlcuBir) then
    begin
      if not (qryDEKONT.State in [dssEdit,dssInsert])then qryDEKONT.Edit;
      qryDEKONT.FieldByName('OLCUBIRIM').AsString := OlcuBir;
    end;
  end
  else
  begin
     Application.MessageBox('Ürün Seçmeden Ölçü Birimi Seçemezsiniz','DÝKKAT',MB_ICONINFORMATION);
  end;
end;

procedure TfrmDEKONTT.dtsDEKONTStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
begin
  if ADataset.State in [dssINSERT,dssEDIT] then
  begin
    if ADataset.State = dssEDIT then
    begin
      btnDekontSil.Enabled := True;
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;
    end
    else
    begin
      btnDekontSil.Enabled := False;
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;      
    end;
    btnYENI.Enabled := False;
    btnAra.Enabled := False;
    btnTRN_KAYDET.Enabled := True;
    btnTRN_IPTAL.Enabled := True;
    btnCikis.Enabled := False;

  end
  else
  begin
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;
    btnDekontSil.Enabled := False;
    btnYENI.Enabled := True;
    btnAra.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
    btnCikis.Enabled := True;
  end;
end;

procedure TfrmDEKONTT.btnDekontSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmDEKONTT.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmDEKONTT.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmDEKONTT.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmDEKONTT.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmDEKONTT);
  with frmDEKONTT.qryDEKONT_D do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('MIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
  end;

  with frmDEKONTT.qryDEKONT do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('MIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('NET_MIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('FIRE').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('BIRIM_FIY').DisplayFormat := glb_DOV_FIELD_PF;
  end;

  {$IfDef EGEM}
  IB_Edit2.Visible:=True;
  IB_Edit7.Visible:=True;
  txtProjeKod.Visible:=True;
  IB_Edit9.Visible:=True;
  grpRapKod.Visible:=True;

  txtUrunKodu.Visible:=True;
  IB_Edit23.Visible:=True;
  IB_Currency7.Visible:=True;
  txtOlcuBirim.Visible:=True;
  IB_Currency5.Visible:=True;
  IB_ComboBox1.Visible:=True;
  IB_Currency1.Visible:=True;
  IB_Edit22.Visible:=True;
  IB_Edit3.Visible:=True;
  IB_Currency2.Visible:=True;
  IB_Currency3.Visible:=True;
  txtDepoKod.Visible:=True;
  txtDepoAd.Visible:=True;
  IB_Currency6.Visible:=True;
  IB_Currency4.Visible:=True;
  rg_Giris_Cikis.Visible:=True;
  
  {$EndIf}
end;

procedure TfrmDEKONTT.txtKARSI_KODEnter(Sender: TObject);
begin
  txtKARSI_KOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDEKONTT.txtKARSI_KODExit(Sender: TObject);
var
  KARSI_AD:String;
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then
  begin
    txtKARSI_KOD.Color := clWindow;
    exit;
  end;

  if Length(qryDEKONT_D.FieldByName('KARSI_KOD').AsString) <> 0 then
  begin
    if qryDEKONT_D.FieldByName('MC').AsString = 'C' then
    begin
      if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',qryDEKONT_D.FieldByName('KARSI_KOD').AsString,KARSI_AD) then
      begin
        qryDEKONT_D.FieldByName('KARSI_AD').AsString := KARSI_AD;
        txtKARSI_KOD.Color := clWindow;
      end
      else
      begin
        qryDEKONT_D.FieldByName('KARSI_KOD').AsString := '';
        qryDEKONT_D.FieldByName('KARSI_AD').AsString := '' ;
        txtKARSI_KOD.SetFocus;
        Application.MessageBox('Lütfen iþlem yapacaðýnýz kodu seçiniz!!','Dikkat',MB_ICONSTOP);
        txtKARSI_KODButtonClick(Self);
      end;
    end
    else
    begin
      if DataMod.FN_KOD2AD('MASRAF','MASRAF_KOD','ADI',qryDEKONT_D.FieldByName('KARSI_KOD').AsString,KARSI_AD) then
      begin
        qryDEKONT_D.FieldByName('KARSI_AD').AsString := KARSI_AD;
        txtKARSI_KOD.Color := clWindow;
      end
      else
      begin
        qryDEKONT_D.FieldByName('KARSI_KOD').AsString := '';
        qryDEKONT_D.FieldByName('KARSI_AD').AsString :='' ;
        txtKARSI_KOD.SetFocus;
        Application.MessageBox('Lütfen iþlem yapacaðýnýz kodu seçiniz!!','Dikkat',MB_ICONSTOP);
        txtKARSI_KODButtonClick(Self);
        Exit;
      end;
    end;
  end
  else
  begin
    qryDEKONT_D.FieldByName('KARSI_KOD').AsString := '';
    qryDEKONT_D.FieldByName('KARSI_AD').AsString :='';
    txtKARSI_KOD.Color := clWindow;
  end;
end;

procedure TfrmDEKONTT.txtKARSI_KODKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtKARSI_KODButtonClick(Self);
end;

procedure TfrmDEKONTT.txtKARSI_KODKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDEKONTT.txtProjeKodButtonClick(Sender: TObject);
var
  Proje_KOD:String;
  Proje_AD:String;
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Proje(Proje_KOD,Proje_AD,1) then
  begin
    qryDEKONT_D.FieldByName('PROJE_KOD').AsString := Proje_KOD;
    qryDEKONT_D.FieldByName('PROJE_AD').AsString := Proje_AD;
  end;
end;

procedure TfrmDEKONTT.txtProjeKodEnter(Sender: TObject);
begin
  txtProjeKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDEKONTT.txtProjeKodExit(Sender: TObject);
var
  Proje_Ad:String;
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then
  begin
    txtProjeKod.Color := clWindow;
    exit;
  end;
  txtProjeKod.Color := clWindow;
  if qryDEKONT_D.FieldByName('PROJE_KOD').AsString <> '' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',qryDEKONT_D.FieldByName('PROJE_KOD').AsString,Proje_Ad) Then
    begin
      qryDEKONT_D.FieldByName('PROJE_AD').AsString := Proje_AD;
    end
    else
    begin
      qryDEKONT_D.FieldByName('PROJE_AD').AsString :='' ;
      txtPROJEKod.SetFocus;
    end;
  end
  else
  begin
    qryDEKONT_D.FieldByName('PROJE_AD').AsString :='';
  end;
end;

procedure TfrmDEKONTT.txtProjeKodKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtProjeKodButtonClick(Self);
end;

procedure TfrmDEKONTT.txtProjeKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDEKONTT.FormResize(Sender: TObject);
begin
  btnCikis.Left := frmDEKONTT.Width  - (btnCikis.Width + 25 );
  btnAra.Left := frmDEKONTT.Width  - ( btnCikis.Width + btnAra.Width + 28 );
end;


function TfrmDEKONTT.ON_MUHASEBE_ENT(SIL:BYTE):Boolean;
begin
  Result := ON_MUH(SIL,qryDEKONT_D);
end;

procedure TfrmDEKONTT.BakiyeHesapla;
var
  BookMark:String;
begin
  try
    prv_BORC := 0;
    prv_ALACAK := 0;
    Bookmark := qryDEKONT_D.Bookmark;
    qryDEKONT_D.DisableControls;
    qryDEKONT_D.First;
    while (not qryDEKONT_D.Eof) do
    begin
      if qryDEKONT_D.FieldByName('BA').AsString = BORC then
      begin
        prv_BORC := prv_BORC + qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency
      end
      else
      begin
        prv_ALACAK := prv_ALACAK + qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency;
      end;
      qryDEKONT_D.Next;
    end;

    qryDEKONT_D.Bookmark := BookMark;
    sbDEKONT.Panels[1].Text := FormatFloat(glb_VPB_FIELD_PF,prv_BORC);
    sbDEKONT.Panels[3].Text := FormatFloat(glb_VPB_FIELD_PF,prv_ALACAK);
    if prv_BORC = prv_ALACAK then
    begin
       sbDEKONT.Panels[5].Text := '';
       sbDEKONT.Panels[6].Text := '0';
       prv_BAKIYE := 0;
    end
    else
    if prv_BORC > prv_ALACAK then
    begin
      sbDEKONT.Panels[5].Text := BORC;
      prv_BAKIYE := prv_BORC-prv_ALACAK;
    end
    else
    begin
      sbDEKONT.Panels[5].Text := ALACAK;
      prv_BAKIYE := prv_ALACAK-prv_BORC;
    end;
    sbDEKONT.Panels[6].Text := FormatFloat(glb_VPB_FIELD_PF,prv_BAKIYE);
  finally
    qryDEKONT_D.EnableControls;
  end;
end;

procedure TfrmDEKONTT.qryDEKONT_DAfterPost(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
end;

procedure TfrmDEKONTT.qryDEKONT_DAfterDelete(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
end;

procedure TfrmDEKONTT.qryDEKONT_DAfterOpen(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
end;

procedure TfrmDEKONTT.IB_Edit8Exit(Sender: TObject);
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

procedure TfrmDEKONTT.IB_Edit10Exit(Sender: TObject);
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

procedure TfrmDEKONTT.IB_Edit11Exit(Sender: TObject);
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

procedure TfrmDEKONTT.IB_Edit12Exit(Sender: TObject);
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

procedure TfrmDEKONTT.IB_Edit13Exit(Sender: TObject);
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

procedure TfrmDEKONTT.IB_Edit8ButtonClick(Sender: TObject);
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmDEKONTT.IB_Edit10ButtonClick(Sender: TObject);
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmDEKONTT.IB_Edit11ButtonClick(Sender: TObject);
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmDEKONTT.IB_Edit12ButtonClick(Sender: TObject);
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmDEKONTT.IB_Edit13ButtonClick(Sender: TObject);
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmDEKONTT.IB_Edit8KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure TfrmDEKONTT.IB_Edit10KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure TfrmDEKONTT.IB_Edit11KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure TfrmDEKONTT.IB_Edit12KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure TfrmDEKONTT.IB_Edit13KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;

Function TfrmDEKONTT.ON_MUHASEBE_SIL:Boolean;
var
  qryDEKONT_D_N:TIB_Query;
begin
  DataMod.CreateQuery(qryDEKONT_D_N,trnDEKONT,False,DataMod.dbaMain);
  with qryDEKONT_D_N do
  begin
    sql.Add('SELECT * FROM DEKONT_D WHERE DEKONT_ID = '+ qryDEKONT.FieldByName('DEKONT_ID').AsString + ' AND DEKONT_SID = ' + qryDEKONT.FieldByName('DEKONT_SID').AsString);
    Active := True;
    if RecordCount = 0 then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := ON_MUH(1,qryDEKONT_D_N);
end;

procedure TfrmDEKONTT.Button1Click(Sender: TObject);
begin
  if (qryDEKONT_D.RecordCount <> 0) and not (dtsDEKONT_D.State = dssINSERT) then qryDEKONT_D.Edit;
end;

procedure TfrmDEKONTT.IB_Edit2ButtonClick(Sender: TObject);
var
  Proje_KOD:String;
  Proje_AD:String;
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Proje(Proje_KOD,Proje_AD,1) then
  begin
    qryDEKONT.FieldByName('PROJE_KOD').AsString := Proje_KOD;
    qryDEKONT.FieldByName('PROJE_AD').AsString := Proje_AD;
  end;
end;

procedure TfrmDEKONTT.IB_Edit2Enter(Sender: TObject);
begin
  IB_Edit2.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDEKONTT.IB_Edit2Exit(Sender: TObject);
var
  Proje_Ad:String;
begin
  IB_Edit2.Color := clWindow;
  if qryDEKONT.FieldByName('PROJE_KOD').AsString <> '' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',qryDEKONT.FieldByName('PROJE_KOD').AsString,Proje_Ad) Then
    begin
      qryDEKONT.FieldByName('PROJE_AD').AsString := Proje_AD;
    end
    else
    begin
      qryDEKONT.FieldByName('PROJE_AD').AsString :='' ;
      IB_Edit2.SetFocus;
    end;
  end
  else
  begin
    qryDEKONT.FieldByName('PROJE_AD').AsString :='';
  end;
end;

procedure TfrmDEKONTT.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDEKONTT.IB_Edit2KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit2ButtonClick(Self);
end;

function TfrmDEKONTT.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryDEKONT.FieldByName('ISLEM_TAR').AsDate,True) then Exit;
  Result := True;
end;

function TfrmDEKONTT.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if not DataMod.KAY_TAR_KONTROL(qryDEKONT.FieldByName('ISLEM_TAR').AsDate,True) then Exit;

  if qryDEKONT_D.RecordCount = 0  Then
  begin
    Application.MessageBox('Dekont kalemi girmeden kayýt yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryDEKONT.FieldByName('ISLEM_TAR').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryDEKONT.FieldByName('ISLEM_TAR').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryDEKONT.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  Result := True;
end;

procedure TfrmDEKONTT.Form_Delete;
var
  DEKONT_ID,DEKONT_SID:Integer;
begin
  try
    try
      if not Form_Before_Delete then exit;
      if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then exit;
//****************************************************************************//
      if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
      if trnDEKONT.InTransaction then
         trnDEKONT.Rollback;
      trnDEKONT.StartTransaction;
//****************************************************************************//

      if not ON_MUHASEBE_SIL then
      begin
        frmISN_ERRORS.AnyErr(trnDEKONT,PRV_ISN,0);
        trnDEKONT.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;

      Prv_URUNHAR_ID:=qryDEKONT.FieldByName('URUNHAR_ID').AsInteger;
      Prv_URUNHAR_SID:=qryDEKONT.FieldByName('URUNHAR_SID').AsInteger;

      if not DataMod.Urun_Har_Ekle(trnDEKONT,
      qryDEKONT,
      qryDEKONT.FieldByName('URUN_KOD').AsString,
      qryDEKONT.FieldByName('OLCUBIRIM').AsString,
      qryDEKONT.FieldByName('DEPO_KOD').AsString,
      BORC,
      True,
      BT_S_DEKONT,
      qryDEKONT.FieldByName('DEKONT_ID').AsInteger,
      qryDEKONT.FieldByName('DEKONT_SID').AsInteger,
      1,
      qryDEKONT.FieldByName('PROJE_KOD').AsString,
      qryDEKONT.FieldByName('ISLEM_TAR').AsDateTime,
      qryDEKONT.FieldByName('ISLEM_TAR').AsDateTime,
      qryDEKONT.FieldByName('DOV_BAZ_TAR').AsDateTime,
      qryDEKONT.FieldByName('MIKTAR').AsFloat,
      qryDEKONT.FieldByName('DOVKOD').AsString,
      qryDEKONT.FieldByName('URUN_DOVKOD').AsString,
      qryDEKONT.FieldByName('TUTAR_URUN_DOVKOD').AsString,
      qryDEKONT.FieldByName('DOVKUR').AsFloat,
      qryDEKONT.FieldByName('BIRIM_FIY').AsFloat,
      qryDEKONT.FieldByName('BIRIM_FIY_VPB').AsFloat,
      qryDEKONT.FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat,
      qryDEKONT.FieldByName('TUTAR').AsFloat,
      qryDEKONT.FieldByName('TUTAR_VPB').AsFloat,
      qryDEKONT.FieldByName('KDV').AsFloat,
      qryDEKONT.FieldByName('KDV_TUTAR').AsFloat,
      1,
      qryDEKONT.FieldByName('ACIKLAMA').AsString,
      prv_ISN,
      qryDEKONT.FieldByName('MASRAF_MERK').AsString,
      qryDEKONT.FieldByName('KOD1').AsString,
      qryDEKONT.FieldByName('KOD2').AsString,
      qryDEKONT.FieldByName('KOD3').AsString,
      qryDEKONT.FieldByName('KOD4').AsString,
      Prv_URUNHAR_ID,
      Prv_URUNHAR_SID) then
      begin
        frmISN_ERRORS.AnyErr(trnDEKONT,PRV_ISN,0);
        trnDEKONT.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;


//****************************************************************************//

      qryDEKONT_D.DisableControls;
      qryDEKONT_D.First;
      while not qryDEKONT_D.Eof do
      begin
        qryDEKONT_D.Delete;
      end;
//****************************************************************************//
      DEKONT_ID := qryDEKONT.FieldByName('DEKONT_ID').AsInteger;
      DEKONT_SID := qryDEKONT.FieldByName('DEKONT_SID').AsInteger;
//****************************************************************************//
      qryDEKONT.Delete;
//****************************************************************************//
      qryDEKONT_D.ApplyUpdates;
      qryDEKONT_D.CommitUpdates;
      qryDEKONT.ApplyUpdates;
      qryDEKONT.CommitUpdates;
//****************************************************************************//
      dmLOGGER.dbaMain_StopMonitoringWrite2log('DEKONT,DEKONT_D,',
                                                BT_S_DEKONT,
                                                DEKONT_ID,
                                                DEKONT_SID,
                                                1,2,'');
//****************************************************************************//
      trnDEKONT.Commit;
    except
      Application.MessageBox('DEKONT silinirken bir hata oluþtu','Dikkat',MB_ICONERROR);
      trnDEKONT.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
    end;
  finally
    qryDEKONT_D.EnableControls;
  end;
end;

procedure TfrmDEKONTT.Form_Post;
begin
  try
    try
      if not Form_Before_Post then
      begin
        dmLOGGER.dbaMain_CancelMonitoring;
        exit;
      end;
//****************************************************************************//
      if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
      if trnDEKONT.inTransaction then
         trnDEKONT.Rollback;
      trnDEKONT.StartTransaction;
//****************************************************************************//
      qryDEKONT_D.DisableControls;
      prn_DEKONT_ID := qryDEKONT.FieldByName('DEKONT_ID').AsInteger;
      prn_DEKONT_SID := qryDEKONT.FieldByName('DEKONT_SID').AsInteger;
//****************************************************************************//

      if not ON_MUHASEBE_SIL then
      begin
        frmISN_ERRORS.AnyErr(trnDEKONT,PRV_ISN,0);
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;

      Prv_URUNHAR_ID:=qryDEKONT.FieldByName('URUNHAR_ID').AsInteger;
      Prv_URUNHAR_SID:=qryDEKONT.FieldByName('URUNHAR_SID').AsInteger;

      
      if not DataMod.Urun_Har_Ekle(trnDEKONT,
      qryDEKONT,
      qryDEKONT.FieldByName('URUN_KOD').AsString,
      qryDEKONT.FieldByName('OLCUBIRIM').AsString,
      qryDEKONT.FieldByName('DEPO_KOD').AsString,
      qryDEKONT.FieldByName('TIPI').AsString[1],
      True,
      BT_S_DEKONT,
      qryDEKONT.FieldByName('DEKONT_ID').AsInteger,
      qryDEKONT.FieldByName('DEKONT_SID').AsInteger,
      1,
      qryDEKONT.FieldByName('PROJE_KOD').AsString,
      qryDEKONT.FieldByName('ISLEM_TAR').AsDateTime,
      qryDEKONT.FieldByName('ISLEM_TAR').AsDateTime,
      qryDEKONT.FieldByName('DOV_BAZ_TAR').AsDateTime,
      qryDEKONT.FieldByName('MIKTAR').AsFloat,
      qryDEKONT.FieldByName('DOVKOD').AsString,
      qryDEKONT.FieldByName('URUN_DOVKOD').AsString,
      qryDEKONT.FieldByName('TUTAR_URUN_DOVKOD').AsString,
      qryDEKONT.FieldByName('DOVKUR').AsFloat,
      qryDEKONT.FieldByName('BIRIM_FIY').AsFloat,
      qryDEKONT.FieldByName('BIRIM_FIY_VPB').AsFloat,
      qryDEKONT.FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat,
      qryDEKONT.FieldByName('TUTAR').AsFloat,
      qryDEKONT.FieldByName('TUTAR_VPB').AsFloat,
      qryDEKONT.FieldByName('KDV').AsFloat,
      qryDEKONT.FieldByName('KDV_TUTAR').AsFloat,
      0,
      qryDEKONT.FieldByName('ACIKLAMA').AsString,
      prv_ISN,
      qryDEKONT.FieldByName('MASRAF_MERK').AsString,
      qryDEKONT.FieldByName('KOD1').AsString,
      qryDEKONT.FieldByName('KOD2').AsString,
      qryDEKONT.FieldByName('KOD3').AsString,
      qryDEKONT.FieldByName('KOD4').AsString,
      Prv_URUNHAR_ID,
      Prv_URUNHAR_SID) then
      begin
        frmISN_ERRORS.AnyErr(trnDEKONT,PRV_ISN,0);
        trnDEKONT.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;


//****************************************************************************//
      if not ON_MUHASEBE_ENT(0) then
      begin
        frmISN_ERRORS.AnyErr(trnDEKONT,PRV_ISN,0);
        trnDEKONT.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;
//****************************************************************************//

//****************************************************************************//
      qryDEKONT_D.ApplyUpdates;
      qryDEKONT_D.CommitUpdates;

      qryDEKONT.FieldByName('URUNHAR_ID').AsInteger:=Prv_URUNHAR_ID;
      qryDEKONT.FieldByName('URUNHAR_SID').AsInteger:=Prv_URUNHAR_SID;


      qryDEKONT.Post;
      qryDEKONT.ApplyUpdates;
      qryDEKONT.CommitUpdates;
//****************************************************************************//
      dmLOGGER.dbaMain_StopMonitoringWrite2log('DEKONT,DEKONT_D,',
                                                BT_S_DEKONT,
                                                qryDEKONT.FieldByName('DEKONT_ID').AsInteger,
                                                qryDEKONT.FieldByName('DEKONT_SID').AsInteger,
                                                1,1,'');
//****************************************************************************//
      trnDEKONT.Commit;
//****************************************************************************//
  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(171)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,171,17,1,rgYAZICI.ItemIndex,prn_DEKONT_ID,prn_DEKONT_SID,0,'');
  end
  else
      if rgYAZICI.ItemIndex < 2 then Yazici.DEKONT(prn_DEKONT_ID,prn_DEKONT_SID,rgYAZICI.ItemIndex);
      prn_DEKONT_ID := 0;
      prn_DEKONT_SID := 0;
//****************************************************************************//
    except
      trnDEKONT.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Application.MessageBox('Exception olusan yer TfrmDEKONTT.Form_Post','Dikkat',MB_ICONHAND);
      raise; {raise the exception to prevent a call to CommitUpdates!}
    end;
    qryDEKONT.Active := False;
    qryDEKONT_D.Active := False;
  finally
    qryDEKONT_D.EnableControls;
  end;
end;

procedure TfrmDEKONTT.edtDOVKURExit(Sender: TObject);
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then
  begin
    edtDOVKUR.Color := clWindow;
    exit;
  end;
//****************************************************************************//
  if (qryDEKONT_D.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
    qryDEKONT_D.FieldByName('DOVKUR').AsCurrency := 1;
    edtDOVKUR.SetFocus;
    exit;
  end;
//****************************************************************************//
  edtDOVKUR.Color := clWindow;
//****************************************************************************//
end;

procedure TfrmDEKONTT.edtTUTARExit(Sender: TObject);
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmDEKONTT.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
  IB_ComboBox1.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmDEKONTT.cboDOVKODExit(Sender: TObject);
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then
  begin
    cboDOVKOD.Color := clWindow;
    exit;
  end;
  cboDOVKOD.Color := clWindow;
end;

procedure TfrmDEKONTT.cboDOVKODEnter(Sender: TObject);
begin
  cboDOVKOD.COLOR := glb_Art_Alan_Renk;
end;

procedure TfrmDEKONTT.qryDEKONT_DAfterScroll(IB_Dataset: TIB_Dataset);
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





function TfrmDEKONTT.URUN_HAR_SIL:Boolean;
var
  qryS_URUNHAR:TIB_Query;
begin
  DataMod.CreateQuery(qryS_URUNHAR,trnDEKONT,False,DataMod.dbaMain);
  with qryS_URUNHAR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM URUNHAR WHERE URUNHAR_ID = '+ qryDEKONT.FieldByName('URUNHAR_ID').AsString) ;
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
    if (Trim(qryS_URUNHAR.FieldByName('URUN_KOD').AsString) <> '') then
    begin
      if not DataMod.URUN_HAR_AUD(trnDEKONT,
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


function TfrmDEKONTT.ON_MUH(SIL: Byte; KASAHAR: TIB_Query): Boolean;
var
  BELGE_ID,BELGE_SID:Integer;
  PROJE_SIL:Byte;
  TIPI:String;
begin
  try

      if SIL = 0 then
      begin
        //silme iþleminde urun hareketleri URUN_HAR_SIL tarafýndan zaten silinmiþ olacaðýndan bu URUNHAR_AUD prosedurü tekrar calýþtýrýlmaz
        //uruna ekleme yap gelen id yi dekonta kaydet

         TIPI:=qryDEKONT.FieldByName('TIPI').AsString;

         if (qryDEKONT.FieldByName('URUN_KOD').AsString <> '')  then
          begin
            if not DataMod.URUN_HAR_AUD(trnDEKONT,
                                        qryDEKONT.FieldByName('URUN_KOD').AsString,
                                        qryDEKONT.FieldByName('DEPO_KOD').AsString,
                                        TIPI[1],
                                        qryDEKONT.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency,
                                        qryDEKONT.FieldByName('TUTAR_VPB').AsCurrency,
                                        qryDEKONT.FieldByName('MIKTAR_URN_OB').AsCurrency) then
            begin
              Result := False;
              Exit;
            end;
          end
      end;

      if Sil=1 then
      URUN_HAR_SIL;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    KASAHAR.First;
    while not (KASAHAR.Eof) Do
    begin
      if KASAHAR.FieldByName('MC').AsString = 'C' then
      begin
        if not DataMod.CARIHAR_AUD(trnDEKONT,
                                       BT_S_DEKONT,
                                       KASAHAR.FieldbyName('DEKONT_D_ID').AsInteger,
                                       KASAHAR.FieldbyName('DEKONT_D_SID').AsInteger,
                                       1,
                                       Trim(KASAHAR.FieldbyName('KARSI_KOD').AsString),
                                       KASAHAR.FieldByName('BA').AsString[1],
                                       qryDEKONT.FieldbyName('ISLEM_TAR').AsDate,
                                       qryDEKONT.FieldbyName('ISLEM_TAR').AsDate,
                                       qryDEKONT.FieldbyName('DOV_BAZ_TAR').AsDate,
                                       KASAHAR.FieldbyName('TUTAR').AsCurrency,
                                       KASAHAR.FieldbyName('DOVKOD').AsString,
                                       KASAHAR.FieldbyName('DOVKUR').AsCurrency,
                                       KASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                                       qryDEKONT.FieldbyName('ISLEM_TAR').AsDate,
                                       KASAHAR.FieldbyName('ACIKLAMA1').AsString,
                                       SIL,
                                       PRV_ISN,
                                       qryDEKONT.FieldbyName('MASRAF_MERK').AsString,
                                       qryDEKONT.FieldbyName('KOD1').AsString,
                                       qryDEKONT.FieldbyName('KOD2').AsString,
                                       qryDEKONT.FieldbyName('KOD3').AsString,
                                       qryDEKONT.FieldbyName('KOD4').AsString,
                                       '',
                                       KASAHAR.FieldbyName('PROJE_KOD').AsString,
                                       BELGE_ID,
                                       BELGE_SID) then
        begin
          Result := False;
          Exit;
        end;
      end
      else
      begin
        if not DataMod.MASRAFHAR_AUD(trnDEKONT,
                                     BT_S_DEKONT,
                                     KASAHAR.FieldbyName('DEKONT_D_ID').AsInteger,
                                     KASAHAR.FieldbyName('DEKONT_D_SID').AsInteger,
                                     1,
                                     Trim(KASAHAR.FieldbyName('KARSI_KOD').AsString),
                                     KASAHAR.FieldByName('BA').AsString[1],
                                     qryDEKONT.FieldbyName('ISLEM_TAR').AsDate,
                                     qryDEKONT.FieldbyName('DOV_BAZ_TAR').AsDate,
                                     KASAHAR.FieldbyName('TUTAR').AsCurrency,
                                     KASAHAR.FieldbyName('DOVKOD').AsString,
                                     KASAHAR.FieldbyName('DOVKUR').AsCurrency,
                                     KASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                                     KASAHAR.FieldbyName('ACIKLAMA1').AsString,
                                     SIL,
                                     qryDEKONT.FieldbyName('MASRAF_MERK').AsString,
                                     qryDEKONT.FieldbyName('KOD1').AsString,
                                     qryDEKONT.FieldbyName('KOD2').AsString,
                                     qryDEKONT.FieldbyName('KOD3').AsString,
                                     qryDEKONT.FieldbyName('KOD4').AsString,
                                     BELGE_ID,
                                     BELGE_SID) then
        begin
          Result := False;
          Exit;
        end;
      end;

      if SIL <> 1 then
      begin
        if Trim(KASAHAR.FieldByName('PROJE_KOD').AsString) = '' then
        begin
          PROJE_SIL:=1
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

      if not DataMod.PROJEHAR_AUD(trnDEKONT,
                                      BT_S_DEKONT,
                                      KASAHAR.FieldbyName('DEKONT_D_ID').AsInteger,
                                      KASAHAR.FieldbyName('DEKONT_D_SID').AsInteger,
                                      1,
                                      KASAHAR.FieldbyName('PROJE_KOD').AsString,
                                      qryDEKONT.FieldbyName('ISLEM_TAR').AsDate,
                                      qryDEKONT.FieldbyName('ISLEM_TAR').AsDate,
                                      qryDEKONT.FieldbyName('DOV_BAZ_TAR').AsDate,
                                      qryDEKONT.FieldbyName('ISLEM_TAR').AsDate,
                                      KASAHAR.FieldByName('BA').AsString[1],
                                      KASAHAR.FieldbyName('DOVKOD').AsString,
                                      KASAHAR.FieldbyName('DOVKUR').AsCurrency,
                                      KASAHAR.FieldbyName('TUTAR').AsCurrency,
                                      KASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                                      PROJE_SIL,
                                      KASAHAR.FieldbyName('ACIKLAMA1').AsString,
                                      PRV_ISN,
                                      qryDEKONT.FieldbyName('MASRAF_MERK').AsString,
                                      qryDEKONT.FieldbyName('KOD1').AsString,
                                      qryDEKONT.FieldbyName('KOD2').AsString,
                                      qryDEKONT.FieldbyName('KOD3').AsString,
                                      qryDEKONT.FieldbyName('KOD4').AsString,
                                      BELGE_ID,
                                      BELGE_SID) then
      begin
        Result := False;
        Exit;
      end;
      KASAHAR.Next;
    end;
    Result := True;
  except
    Result := False;
  end;
end;

procedure TfrmDEKONTT.btnCiktiClick(Sender: TObject);
begin
  if qryDEKONT.FieldByName('DEKONT_ID').AsInteger<=0 then Exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;

  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(171)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,171,17,1,rgYAZICI.ItemIndex,prn_DEKONT_ID,prn_DEKONT_SID,0,'');
  end
  else

  if rgYAZICI.ItemIndex < 2 then Yazici.DEKONT(prn_DEKONT_ID,prn_DEKONT_SID,rgYAZICI.ItemIndex);
end;

procedure TfrmDEKONTT.qryDEKONT_DBeforePost(IB_Dataset: TIB_Dataset);
begin
  if qryDEKONT_D.FieldByName('BA').IsNull then
  begin
    Application.MessageBox('Lütfen Borç yada Alacak seçeneklerinden birini seçiniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end
  else
  if Trim(qryDEKONT_D.FieldByName('BA').AsString) = '' then
  begin
    Application.MessageBox('Lütfen Borç yada Alacak seçeneklerinden birini seçiniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmDEKONTT.DekontuablonOlarakKopyala1Click(Sender: TObject);
begin
  if MainForm.FindChildFrm(Application,'frmDEKONT_AUT') then
  begin
    Application.MessageBox ('Dekont þablonu tanýmlama formu açýk iken listeyi kullanamazsýnýz.','Dikkat', MB_ICONWARNING);
    exit;
  end;

  if not qryDEKONT.Active then
  begin
    Application.MessageBox('Olmayan bir dekont üzerinden þablon oluþturamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryDEKONT.State in [dssInsert] then
  begin
    Application.MessageBox('Yeni kayýt durumunda dekont üzerinden þablon oluþturamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  rgYAZICI.ItemIndex := 2;
  
  if not DEKONT_AUT.DekontuSablonOlarakKopyala then
  begin
    Application.MessageBox('Þablon üzerinden dekont oluþturma iþleminde hata oluþtu.','Dikkat',MB_ICONWARNING);
  end;
end;

procedure TfrmDEKONTT.DekontKopyala1Click(Sender: TObject);
var
  ID,SID:String;
begin
  if not qryDEKONT.Active then
  begin
    Application.MessageBox('Olmayan bir dekont üzerinden kopyalama iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryDEKONT.State in [dssInsert] then
  begin
    Application.MessageBox('Yeni kayýt durumunda dekont üzerinden kopyalama iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  ID := qryDEKONT.FieldByName('DEKONT_ID').AsString;
  SID := qryDEKONT.FieldByName('DEKONT_SID').AsString;

  rgYAZICI.ItemIndex := 2;

  btnTRN_IPTALClick(Self);

  if not qryDEKONT.Active then
  begin
    if not DEKONT_AUT.DekontKopyala(ID,SID) then
    begin
      Application.MessageBox('Dekont kopyalama iþlemi sýrasýnda hata oluþtu.','Dikkat',MB_ICONWARNING);
    end;
  end;

end;

procedure TfrmDEKONTT.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 DEKONT_ID,DEKONT_SID FROM DEKONT  WHERE DEKONT_ID<:DEKONT_ID AND DEKONT_SID=:DEKONT_SID ORDER BY DEKONT_ID DESC';
     qryDeg1.ParamByName('DEKONT_ID').AsInteger:=qryDEKONT.FieldByName('DEKONT_ID').AsInteger;
     qryDeg1.ParamByName('DEKONT_SID').AsInteger:=qryDEKONT.FieldByName('DEKONT_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('DEKONT_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('DEKONT_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('DEKONT_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1,0);
     end;
     DataMod.ReleaseQuery(qryDeg1);


end;


procedure TfrmDEKONTT.Geri_AL;
begin
     qryDEKONT_D.CancelUpdates;
     qryDEKONT.CancelUpdates;
     qryDEKONT_D.Close;
     qryDEKONT.Close;
     trnDEKONT.Rollback;
end;

procedure TfrmDEKONTT.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 DEKONT_ID,DEKONT_SID FROM DEKONT  WHERE DEKONT_ID>:DEKONT_ID AND DEKONT_SID=:DEKONT_SID ORDER BY DEKONT_ID';
     qryDeg1.ParamByName('DEKONT_ID').AsInteger:=qryDEKONT.FieldByName('DEKONT_ID').AsInteger;
     qryDeg1.ParamByName('DEKONT_SID').AsInteger:=qryDEKONT.FieldByName('DEKONT_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('DEKONT_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('DEKONT_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('DEKONT_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1,0);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmDEKONTT.txtUrunKoduButtonClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad,DOVKOD,OlcuBirim, Depo_Kod, Depo_Ad:String;
  KDV_TUTAR,Fiyat:Currency;
  KDV,KDV_DAHIL:Byte;
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_AD,True) then
  begin
    qryDEKONT.FieldByName('URUN_KOD').AsString := Urun_Kod;
    if DataMod.GET_URUN_FAT_BILGI(trnDEKONT,
                                  qryDEKONT.FieldByName('URUN_KOD').AsString,
                                  '',
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
      with qryDEKONT do
      begin
        FieldByName('URUN_AD').AsString := Urun_Ad;
        //FieldByName('ACIKLAMA').AsString := Urun_Ad;
        FieldByName('BIRIM_FIY').AsCurrency := Fiyat;
        FieldByName('DOVKOD').AsString := DOVKOD;
        FieldByName('OLCUBIRIM').AsString := OlcuBirim;
        if KDV_DAHIL=1 then prv_KDV_HESAPLA:=True
        else prv_KDV_HESAPLA:=False;
      end;
      //qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency  := KDV_TUTAR;
      if (Trim(qryDEKONT.FieldByName('DEPO_KOD').AsString) = '') and glb_DEPO_UYG then
      begin
        qryDEKONT.FieldByName('DEPO_KOD').AsString := Depo_Kod;
        qryDEKONT.FieldByName('DEPO_AD').AsString := Depo_Ad;
      end;
    end;
  end;


end;

procedure TfrmDEKONTT.txtUrunKoduEnter(Sender: TObject);
begin
  txtUrunKodu.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDEKONTT.txtUrunKoduExit(Sender: TObject);
var
 KDV_TUTAR,Fiyat:Currency;
 DOVKOD,Urun_Ad,OlcuBirim,Depo_Kod,Depo_Ad:String;
 KDV,KDV_DAHIL:Byte;
begin
  txtUrunKodu.Color := clWindow;
  if not (qryDEKONT.State in [dssEdit,dssInsert]) then exit;
//****************************************************************************//
  if Trim(txtUrunKodu.Text) <> '' then
  begin
    if DataMod.GET_URUN_FAT_BILGI(trnDEKONT,
                                  txtUrunKodu.Text,
                                  '',
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
      if Trim(qryDEKONT.FieldByName('URUN_AD').AsString) <> Urun_Ad then
      // Ayný ise bilgiler le oynama
      begin

        with qryDEKONT do
        begin
          FieldByName('URUN_AD').AsString := Urun_Ad;
          //FieldByName('ACIKLAMA').AsString := Urun_Ad;
          FieldByName('BIRIM_FIY').AsCurrency := Fiyat;
          FieldByName('DOVKOD').AsString := DOVKOD;
          FieldByName('OLCUBIRIM').AsString := OlcuBirim;

          if KDV_DAHIL=1 then prv_KDV_HESAPLA:=True
          else prv_KDV_HESAPLA:=False;

        end;

        if (Trim(qryDEKONT.FieldByName('DEPO_KOD').AsString) = '') AND glb_DEPO_UYG Then
        begin
          with qryDEKONT do
          begin
            FieldByName('DEPO_KOD').AsString := Depo_Kod;
            FieldByName('DEPO_AD').AsString := Depo_Ad;
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

  end;


end;

procedure TfrmDEKONTT.txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDEKONTT.txtUrunKoduKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key= VK_F4 Then txtUrunKoduButtonClick(Sender);
end;

procedure TfrmDEKONTT.txtOlcuBirimEnter(Sender: TObject);
begin
  txtOlcuBirim.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDEKONTT.txtOlcuBirimExit(Sender: TObject);
var
  strSQL:string;
  OLCU_TIP:String;
begin
  txtOlcuBirim.Color := clWindow;
  if Trim(txtOlcuBirim.Text)<>'' then
  begin
    if prv_OlcuBirim_Kontrol=True then
    begin
      strSQL:='SELECT OLCU_TIP FROM URUN WHERE URUN_KOD='+SQL_Katar(qryDEKONT.FieldByName('URUN_KOD').AsString);
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
              + ' AND OLCUBIRIM = '+ SQL_Katar(qryDEKONT.FieldByName('OLCUBIRIM').AsString));
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

procedure TfrmDEKONTT.txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuBirim_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDEKONTT.txtOlcuBirimKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key= VK_F4 then  txtOlcuBirimButtonClick(Self);
end;

procedure TfrmDEKONTT.txtDepoKodButtonClick(Sender: TObject);
var
  Depo_Kod,Depo_Ad:String;
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Depo(Depo_Kod,Depo_Ad) then
  begin
    with qryDEKONT do
    begin
      FieldByName('DEPO_KOD').AsString := Depo_Kod;
      FieldByName('DEPO_AD').AsString := Depo_Ad;
    end;
  end;

end;

procedure TfrmDEKONTT.txtDepoKodEnter(Sender: TObject);
begin
  txtDepoKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDEKONTT.txtDepoKodExit(Sender: TObject);
var
  Depo_Ad:String;
begin
  txtDepoKod.Color := clWindow;
  if Trim(txtDepoKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('DEPO','DEPO_KOD','ADI',qryDEKONT.FieldByName('DEPO_KOD').AsString,Depo_Ad) Then
    begin
      qryDEKONT.FieldByName('DEPO_AD').AsString := Depo_Ad;
    end
    else
    begin
      qryDEKONT.FieldByName('DEPO_AD').AsString := '';
      txtDepoKod.SetFocus;
    end;
  end
  else
  begin
    qryDEKONT.FieldByName('DEPO_AD').AsString := '';
  end;

end;

procedure TfrmDEKONTT.txtDepoKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDEKONTT.txtDepoKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key= VK_F4 Then txtDepoKodButtonClick(self);
end;

procedure TfrmDEKONTT.qryDEKONTAfterInsert(IB_Dataset: TIB_Dataset);
var
  DOV_KUR:Currency;
begin
     qryDEKONT.FieldByName('URUNHAR_ID').AsInteger:=0;
     qryDEKONT.FieldByName('URUNHAR_SID').AsInteger:=0;
     qryDEKONT.FieldByName('MIKTAR').AsFloat:=0;
     
     qryDEKONT.FieldByName('NET_MIKTAR').AsFloat:=0;
     qryDEKONT.FieldByName('FIRE').AsFloat:=0;

     qryDEKONT.FieldByName('KDV').AsFloat:=0;
     qryDEKONT.FieldByName('BIRIM_FIY').AsFloat:=0;
     qryDEKONT.FieldByName('DOVKOD').AsString:=glb_DEFCUR;
     
     qryDEKONT.FieldByName('TIPI').AsString:=BORC;     

     DOV_KUR := DataMod.Get_Doviz_Kur(qryDEKONT.FieldByName('DOVKOD').AsString,qryDEKONT.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
     if DOV_KUR<>0 then
     begin
       qryDEKONT.FieldByName('DOVKUR').AsCurrency := DOV_KUR ;
     end
     else
     begin
       qryDEKONT.FieldByName('DOVKUR').AsCurrency := 1 ;
     end;

     Prv_URUNHAR_ID:=0;
     Prv_URUNHAR_SID:=0;

end;

procedure TfrmDEKONTT.FR(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  if Assigned( Field ) then
  begin

    if (Field.FieldName='NET_MIKTAR') or (Field.FieldName='FIRE') then
    begin

         qryDEKONT.FieldByName('MIKTAR').AsCurrency :=
         qryDEKONT.FieldByName('NET_MIKTAR').AsCurrency - qryDEKONT.FieldByName('FIRE').AsCurrency;

    end;

    if (Field.FieldName='MIKTAR') or (Field.FieldName='DOVKOD') or (Field.FieldName='BIRIM_FIY') then
    begin
      qryDEKONT.FieldByName('TUTAR').AsCurrency := qryDEKONT.FieldByNAme('MIKTAR').AsCurrency * qryDEKONT.FieldByName('BIRIM_FIY').AsCurrency;
      qryDEKONT.FieldByName('TUTAR_VPB').AsCurrency := qryDEKONT.FieldByNAme('MIKTAR').AsCurrency * qryDEKONT.FieldByName('BIRIM_FIY').AsCurrency*qryDEKONT.FieldByName('DOVKUR').AsCurrency;


      if prv_KDV_HESAPLA then
      begin
        if qryDEKONT.FieldByName('KDV').AsInteger <> 0 then  qryDEKONT.FieldByName('KDV_TUTAR').AsCurrency := qryDEKONT.FieldByName('TUTAR_VPB').AsCurrency * (qryDEKONT.FieldByName('KDV').AsInteger / 100);
      end
      else
      begin
        qryDEKONT.FieldByName('KDV_TUTAR').AsCurrency := 0;
      end;

    end;



  end;
end;

procedure TfrmDEKONTT.txtCari_KodButtonClick(Sender: TObject);
var
  KARSI_AD,KARSI_KOD:String;
begin
  if not (qryDEKONT.State in [dssInsert,dssEdit]) then exit;
    if frmCariSDLG.Form_Open(False,KARSI_KOD,KARSI_AD,1) Then
    begin
      qryDEKONT.FieldByName('CARI_KOD').AsString := KARSI_KOD;
      qryDEKONT.FieldByName('CARI_ADI').AsString := KARSI_AD;
    end;

end;

procedure TfrmDEKONTT.txtCari_KodEnter(Sender: TObject);
begin
  txtCari_Kod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDEKONTT.txtCari_KodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCari_Kod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCari_Kod.Text,CARI_AD) then
    begin
      qryDEKONT.FieldByName('CARI_ADI').AsString := CARI_AD;
      if (Sender is TIB_Edit) then
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtCari_Kod.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TIB_Edit) then
    (Sender as TIB_Edit).Color := clWindow;
    qryDEKONT.FieldByName('CARI_ADI').AsString := '';
  end;
end;

procedure TfrmDEKONTT.txtCari_KodKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then  txtCari_KodButtonClick(Self);
end;

procedure TfrmDEKONTT.txtCari_KodKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

end.
