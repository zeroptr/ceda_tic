unit ufrmDekontUrun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, StdCtrls, IB_Controls, ComCtrls,
  ExtCtrls, Buttons, Mask;

type
  TfrmDekontUrun = class(TForm)
    qryDEKONT: TIB_Query;
    qryDEKONT_D: TIB_Query;
    dtsDEKONT_D: TIB_DataSource;
    dtsDEKONT: TIB_DataSource;
    trnDEKONT: TIB_Transaction;
    pcDEKONT: TPageControl;
    tabMASTER: TTabSheet;
    edtACIKLAMA: TIB_Edit;
    IB_Date1: TIB_Date;
    Panel2: TPanel;
    btnYENI: TButton;
    btnTRN_KAYDET: TButton;
    btnTRN_IPTAL: TButton;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnDekontSil: TButton;
    btnCikti: TButton;
    rgYAZICI: TRadioGroup;
    IB_Edit1: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit7: TIB_Edit;
    tabDETAY: TTabSheet;
    sbDEKONT: TStatusBar;
    Panel1: TPanel;
    rdoCM: TIB_RadioGroup;
    IB_RadioGroup2: TIB_RadioGroup;
    txtKARSI_KOD: TIB_Edit;
    edtTUTAR: TIB_Currency;
    edtTUTAR_VPB: TIB_Currency;
    btnEKLE: TButton;
    btnKAYDET: TButton;
    btnSIL: TButton;
    btnIptal: TButton;
    IB_Edit5: TIB_Edit;
    txtProjeKod: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit6: TIB_Edit;
    Button1: TButton;
    grdDekontKontrol: TIB_Grid;
    edtMiktar: TIB_Currency;
    edtBirimFiy: TIB_Currency;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
//****************************************************************************//
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
    procedure KalemHesapla;
//****************************************************************************//
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure btnEKLEClick(Sender: TObject);
    procedure btnKAYDETClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnSILClick(Sender: TObject);
    procedure btnYENIClick(Sender: TObject);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure btnDekontSilClick(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit2Enter(Sender: TObject);
    procedure IB_Edit2Exit(Sender: TObject);
    procedure IB_Edit2ButtonClick(Sender: TObject);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    procedure rdoCMClick(Sender: TObject);
    procedure txtKARSI_KODButtonClick(Sender: TObject);
    procedure txtKARSI_KODEnter(Sender: TObject);
    procedure txtKARSI_KODExit(Sender: TObject);
    procedure txtKARSI_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txtKARSI_KODKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtProjeKodButtonClick(Sender: TObject);
    procedure txtProjeKodEnter(Sender: TObject);
    procedure txtProjeKodExit(Sender: TObject);
    procedure txtProjeKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtProjeKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dtsDEKONTStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure qryDEKONT_DAfterDelete(IB_Dataset: TIB_Dataset);
    procedure qryDEKONT_DAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qryDEKONT_DAfterOpen(IB_Dataset: TIB_Dataset);
    procedure qryDEKONT_DAfterPost(IB_Dataset: TIB_Dataset);
    procedure qryDEKONT_DAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qryDEKONT_DBeforePost(IB_Dataset: TIB_Dataset);
    procedure dtsDEKONT_DStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure pcDEKONTChanging(Sender: TObject; var AllowChange: Boolean);
    procedure dtsDEKONT_DDataChange(Sender: TIB_StatementLink; Statement: TIB_Statement; Field: TIB_Column);
  private
    { Private declarations }
    prv_BORC,prv_ALACAK,prv_BAKIYE:Currency;
    prv_TIP,prv_MUH_FIS_FARK : SmallInt; /// formdan cýkýlsýnmý
    my_Active_Comp:TWinControl;
    Muh_Kod,Aciklama:String;
    prv_ISN,prn_DEKONT_ID,prn_DEKONT_SID:Integer;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;
  const cns_dekont = 15;
var
  frmDekontUrun: TfrmDekontUrun;

implementation

uses unDataMod, unLogger,  ufrmISN_ERRORS, main, unYazici, ufrmDekontSDLG,ufrmUrunSDLG,unFunc;

{$R *.dfm}

function TfrmDekontUrun.Form_Open(Menu: Boolean; DEKONT_ID,
  DEKONT_SID: Integer; ISLEM: Byte; TIP: SmallInt;
  Visible: Boolean): Boolean;
// ISLEM : 0 INSERT ;; 1 EDIT
var
  local_can_update,local_can_delete:Boolean;
begin
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

    if MainForm.FindChildFrm(Application, 'frmDekontUrun') then
    begin
      Application.MessageBox ('Ürün Dekontu modülü açýk.','Dikkat',MB_ICONWARNING);
      Exit;
    end
    else
    begin
      Application.CreateForm (TfrmDekontUrun,frmDekontUrun);
    end;

    with frmDekontUrun do
    begin
      prv_TIP := TIP;
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
    end;

    if not glb_PROJE_UYG then
    begin
      frmDekontUrun.txtProjeKod.Visible := false;
      frmDekontUrun.IB_Edit9.Visible := false;
      frmDekontUrun.IB_Edit7.Visible := false;
      frmDekontUrun.IB_Edit2.Visible := false;
    end;

    if not glb_DOVTAKIP then
    begin
      with frmDekontUrun do
      begin
        edtTUTAR_VPB.Visible := False;
      end;
    end;
    frmDekontUrun.pcDEKONT.ActivePage := frmDekontUrun.tabMASTER;
    frmDekontUrun.DataSet_Open(DEKONT_ID,DEKONT_SID,ISLEM,TIP);
    Result := True;
  end;
end;


procedure TfrmDekontUrun.DataSet_Open(DEKONT_ID, DEKONT_SID: Integer; ISLEM: Byte; TIP: SmallInt);
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
    ParamByName('PRM_TIP').AsInteger := TIP;
    Active := True;
  end;
//****************************************************************************//
  prn_DEKONT_ID := DEKONT_ID;
  prn_DEKONT_SID := DEKONT_SID;
//****************************************************************************//
  //bakiye veren dekonttan çýkýlmasýn.
  prv_MUH_FIS_FARK := StrToInt(DataMod.GetParam(15,'SDK_BAKIYE',0));
  case ISLEM of
  0:
    begin // yeni kayýt
      with qryDEKONT do
      begin
        Insert;
        FieldByName('TIP').AsSmallint := TIP;
        FieldByName('ISLEM_TAR').AsDate := DataMod.GET_SERVER_DATE;
        FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('ISLEM_TAR').AsDate;
        FieldByName('DEKONT_SID').AsSmallint := glb_SID;
      end;
    end;
  1:
    begin
      qryDEKONT.Edit;
//****************************************************************************//
//****************************************************************************//
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
//****************************************************************************//
  btnYENI.Enabled := False;
  btnTRN_KAYDET.Enabled  := True;
  btnTRN_IPTAL.Enabled := True;
  btnCikis.Enabled := False;
  btnAra.Enabled := False;
end;

procedure TfrmDekontUrun.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDekontUrun.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if dtsDEKONT.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Formdan çýkmak için yaptýðýnýz iþlemi dekont tabýnda kaydedin ya da iptal edin!!!','DÝKKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmDekontUrun.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmDekontUrun );
  with frmDekontUrun.qryDEKONT_D do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('MIKTAR').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('BIRIMFIY').DisplayFormat := glb_DOV_FIELD_PF;    
  end;
end;

procedure TfrmDekontUrun.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TfrmDekontUrun.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmDekontUrun.FormResize(Sender: TObject);
begin
  btnCikis.Left := frmDekontUrun.Width  - (btnCikis.Width + 25 );
  btnAra.Left := frmDekontUrun.Width  - ( btnCikis.Width + btnAra.Width + 28 );
end;

procedure TfrmDekontUrun.btnEKLEClick(Sender: TObject);
begin
  qryDEKONT_D.Append;
  rdoCMClick(Self);
//  rdoCM.SetFocus;
end;

procedure TfrmDekontUrun.btnKAYDETClick(Sender: TObject);
var
  FuncDeger,KARSI_AD:String;
  i:Integer;
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
      if not (DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',qryDEKONT_D.FieldByName('KARSI_KOD').AsString,KARSI_AD)) then
      begin
        Application.MessageBox('Lütfen listeden bir ürün kodu seçiniz.','Dikkat',MB_ICONWARNING) ;
        txtKARSI_KODButtonClick(Self);
        exit;
      end;
    end;
  end;
  //burada glb_dov_takip ile döviz kontrolu yapýlmasý gerekiyor mu
  //þu anda kontrol edilmiyor.

  if (qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    edtTUTAR.SetFocus;
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
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

procedure TfrmDekontUrun.btnIptalClick(Sender: TObject);
begin
  qryDEKONT_D.Cancel;
end;

procedure TfrmDekontUrun.Button1Click(Sender: TObject);
begin
  if (qryDEKONT_D.RecordCount <> 0) and not (dtsDEKONT_D.State = dssINSERT) then qryDEKONT_D.Edit;
end;

procedure TfrmDekontUrun.btnSILClick(Sender: TObject);
begin
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz.','Dikkat',MB_YESNO) = IDNO then Exit;
  qryDEKONT_D.Delete;
end;

procedure TfrmDekontUrun.btnYENIClick(Sender: TObject);
begin
  DataSet_Open(0,0,0,2);
end;

procedure TfrmDekontUrun.btnTRN_KAYDETClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmDekontUrun.btnTRN_IPTALClick(Sender: TObject);
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

procedure TfrmDekontUrun.btnDekontSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmDekontUrun.BakiyeHesapla;
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


function TfrmDekontUrun.Form_Before_Delete: Boolean;
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

function TfrmDekontUrun.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if qryDEKONT_D.RecordCount = 0  Then
  begin
    Application.MessageBox('Dekont kalemi girmeden kayýt yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  qryDEKONT.FieldByName('DOV_BAZ_TAR').AsDate := qryDEKONT.FieldByName('ISLEM_TAR').AsDate;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryDEKONT.FieldByName('ISLEM_TAR').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryDEKONT.FieldByName('ISLEM_TAR').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryDEKONT.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  Result := True;
end;

procedure TfrmDekontUrun.Form_Delete;
var
  DEKONT_ID,DEKONT_SID:Integer;
begin
  try
    try
      if not Form_Before_Delete then exit;
      if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then exit;
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


procedure TfrmDekontUrun.Form_Post;
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
//****************************************************************************//
      if not ON_MUHASEBE_ENT(0) then
      begin
        frmISN_ERRORS.AnyErr(trnDEKONT,PRV_ISN,0);
        trnDEKONT.RollbackRetaining;
        dmLOGGER.dbaMain_CancelMonitoring;
        Exit;
      end;


//****************************************************************************//
      qryDEKONT_D.ApplyUpdates;
      qryDEKONT_D.CommitUpdates;
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
      if rgYAZICI.ItemIndex < 2 then Yazici.DEKONT(prn_DEKONT_ID,prn_DEKONT_SID,rgYAZICI.ItemIndex);
      prn_DEKONT_ID := 0;
      prn_DEKONT_SID := 0;
//****************************************************************************//
    except
      trnDEKONT.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Application.MessageBox('Exception olusan yer TfrmDekontUrun.Form_Post','Dikkat',MB_ICONHAND);
      raise; {raise the exception to prevent a call to CommitUpdates!}
    end;
    qryDEKONT.Active := False;
    qryDEKONT_D.Active := False;
  finally
    qryDEKONT_D.EnableControls;
  end;
end;

function TfrmDekontUrun.ON_MUH(SIL: Byte; KASAHAR: TIB_Query): Boolean;
var
  BELGE_ID,BELGE_SID:Integer;
  PROJE_SIL:Byte;
begin
  Result := False;
  KASAHAR.First;
  while not (KASAHAR.Eof) Do
  begin
    if KASAHAR.FieldByName('MC').AsString = 'U' then
    begin
      if SIL = 1 then
      begin
        if not DataMod.URUN_HAR_AUD(trnDEKONT,
                                    Trim(KASAHAR.FieldByName('KARSI_KOD').AsString),
                                    '',
                                    KASAHAR.FieldByName('BA').AsString[1],
                                    (0-KASAHAR.FieldbyName('TUTAR').AsCurrency),
                                    (0-KASAHAR.FieldbyName('TUTAR_VPB').AsCurrency),
                                    (0-KASAHAR.FieldbyName('MIKTAR').AsCurrency)
                                   ) then
        begin
          Result := False;
          Exit;
        end;
      end
      else
      begin
        if not DataMod.URUN_HAR_AUD(trnDEKONT,
                                    Trim(KASAHAR.FieldByName('KARSI_KOD').AsString),
                                    '',
                                    KASAHAR.FieldByName('BA').AsString[1],
                                    KASAHAR.FieldbyName('TUTAR').AsCurrency,
                                    KASAHAR.FieldbyName('TUTAR_VPB').AsCurrency,
                                    KASAHAR.FieldbyName('MIKTAR').AsCurrency
                                   ) then

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
end;

function TfrmDekontUrun.ON_MUHASEBE_ENT(SIL: BYTE): Boolean;
begin
  Result := ON_MUH(SIL,qryDEKONT_D);
end;

function TfrmDekontUrun.ON_MUHASEBE_SIL: Boolean;
var
  qryDEKONT_D_N:TIB_Query;
  BELGE_ID,BELGE_SID:Integer;
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

procedure TfrmDekontUrun.btnCiktiClick(Sender: TObject);
begin
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.ItemIndex < 2 then Yazici.DEKONT(prn_DEKONT_ID,prn_DEKONT_SID,rgYAZICI.ItemIndex);
end;

procedure TfrmDekontUrun.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDekontUrun.btnAraClick(Sender: TObject);
var
  Dekont_ID,Dekont_SID:Integer;
begin
  if frmDekontSDLG.form_Open (True,Dekont_ID,Dekont_SID,2) Then
  begin
    DataSet_Open(Dekont_ID,Dekont_SID,1,2);
  end;
end;

procedure TfrmDekontUrun.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmDekontUrun.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmDekontUrun.IB_Edit2Enter(Sender: TObject);
begin
  IB_Edit2.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontUrun.IB_Edit2Exit(Sender: TObject);
var
  Proje_Ad:String;
begin
  IB_Edit2.Color := clWindow;
  if Trim(IB_Edit2.Text)<>'' then
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

procedure TfrmDekontUrun.IB_Edit2ButtonClick(Sender: TObject);
var
  Proje_KOD:String;
  Proje_AD:String;
begin
  if DataMod.LS_Proje(Proje_KOD,Proje_AD,1) then
  begin
    qryDEKONT.FieldByName('PROJE_KOD').AsString := Proje_KOD;
    qryDEKONT.FieldByName('PROJE_AD').AsString := Proje_AD;
  end;
end;

procedure TfrmDekontUrun.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDekontUrun.IB_Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit2ButtonClick(Self);
end;

procedure TfrmDekontUrun.IB_Edit8ButtonClick(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmDekontUrun.IB_Edit10ButtonClick(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmDekontUrun.IB_Edit11ButtonClick(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmDekontUrun.IB_Edit12ButtonClick(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmDekontUrun.IB_Edit13ButtonClick(Sender: TObject);
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qryDEKONT.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmDekontUrun.IB_Edit8Exit(Sender: TObject);
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

procedure TfrmDekontUrun.IB_Edit10Exit(Sender: TObject);
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

procedure TfrmDekontUrun.IB_Edit11Exit(Sender: TObject);
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

procedure TfrmDekontUrun.IB_Edit12Exit(Sender: TObject);
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

procedure TfrmDekontUrun.IB_Edit13Exit(Sender: TObject);
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

procedure TfrmDekontUrun.rdoCMClick(Sender: TObject);
begin
  if rdoCM.ItemIndex = 0 then
  begin
    txtKARSI_KOD.AutoLabel.Caption := 'Ürün';
    qryDEKONT_D.FieldByName('MIKTAR').AsCurrency := 1;
    qryDEKONT_D.FieldByName('BIRIMFIY').AsCurrency := 1;
    edtMiktar.enabled := True;
    edtBirimFiy.enabled := True;
  end
  else
  begin
    txtKARSI_KOD.AutoLabel.Caption := 'Masraf';
    qryDEKONT_D.FieldByName('MIKTAR').AsCurrency := 0;
    qryDEKONT_D.FieldByName('BIRIMFIY').AsCurrency := 0;
    edtMiktar.enabled := False;
    edtBirimFiy.enabled := False;
  end;
  qryDEKONT_D.FieldByName('KARSI_KOD').AsString := '';
  qryDEKONT_D.FieldByName('KARSI_AD').AsString := '';
end;

procedure TfrmDekontUrun.txtKARSI_KODButtonClick(Sender: TObject);
var
  KARSI_AD,KARSI_KOD:String;
  MIK_TAK:SmallInt;
  qryBirimFiyat : TIB_Cursor;
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then exit;
  if qryDEKONT_D.FieldByName('MC').AsString = 'U' then
  begin
    if frmUrunSDLG.Form_Open(False,KARSI_KOD,KARSI_AD,False) then
    begin
      qryDEKONT_D.FieldByName('KARSI_KOD').AsString := KARSI_KOD;
      qryDEKONT_D.FieldByName('KARSI_AD').AsString := KARSI_AD;
//****************************************************************************//
      DataMod.CreateCursor(qryBirimFiyat,nil,False,datamod.dbaMain);
      with qryBirimFiyat do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT BIRIMFIY FROM URUN WHERE URUN_KOD = '+SQL_Katar(qryDEKONT_D.FieldByName('KARSI_KOD').AsString));
        Open;
      end;
      qryDEKONT_D.FieldByName('BIRIMFIY').AsCurrency := qryBirimFiyat.FieldByName('BIRIMFIY').AsCurrency;
      DataMod.ReleaseCursor(qryBirimFiyat);
//****************************************************************************//
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

procedure TfrmDekontUrun.txtKARSI_KODEnter(Sender: TObject);
begin
  txtKARSI_KOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontUrun.txtKARSI_KODExit(Sender: TObject);
var
  KARSI_AD:String;
  qryBirimFiyat : TIB_Cursor;
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then
  begin
    txtKARSI_KOD.Color := clWindow;
    exit;
  end;

  if Length(qryDEKONT_D.FieldByName('KARSI_KOD').AsString) <> 0 then
  begin
    if qryDEKONT_D.FieldByName('MC').AsString = 'U' then
    begin
      if DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',qryDEKONT_D.FieldByName('KARSI_KOD').AsString,KARSI_AD) then
      begin
        qryDEKONT_D.FieldByName('KARSI_AD').AsString := KARSI_AD;
        txtKARSI_KOD.Color := clWindow;
//****************************************************************************//
        DataMod.CreateCursor(qryBirimFiyat,nil,False,datamod.dbaMain);
        with qryBirimFiyat do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT BIRIMFIY FROM URUN WHERE URUN_KOD = '+SQL_Katar(qryDEKONT_D.FieldByName('KARSI_KOD').AsString));
          Open;
        end;
        qryDEKONT_D.FieldByName('BIRIMFIY').AsCurrency := qryBirimFiyat.FieldByName('BIRIMFIY').AsCurrency;
        DataMod.ReleaseCursor(qryBirimFiyat);
//****************************************************************************//
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

procedure TfrmDekontUrun.txtKARSI_KODKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDekontUrun.txtKARSI_KODKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtKARSI_KODButtonClick(Self);
end;

procedure TfrmDekontUrun.txtProjeKodButtonClick(Sender: TObject);
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


procedure TfrmDekontUrun.txtProjeKodEnter(Sender: TObject);
begin
  txtProjeKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmDekontUrun.txtProjeKodExit(Sender: TObject);
var
  Proje_Ad:String;
begin
  if not (qryDEKONT_D.State in [dssInsert,dssEdit]) then
  begin
    txtProjeKod.Color := clWindow;
    exit;
  end;
  txtProjeKod.Color := clWindow;
  if Trim(txtProjeKod.Text)<>'' then
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

procedure TfrmDekontUrun.txtProjeKodKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDekontUrun.txtProjeKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 Then txtProjeKodButtonClick(Self);
end;

procedure TfrmDekontUrun.dtsDEKONTStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if ADataset.State in [dssINSERT,dssEDIT] then
  begin
    if ADataset.State = dssEDIT then
    begin
      btnDekontSil.Enabled := True
    end
    else
    begin
      btnDekontSil.Enabled := False;
    end;
    btnYENI.Enabled := False;
    btnAra.Enabled := False;
    btnTRN_KAYDET.Enabled := True;
    btnTRN_IPTAL.Enabled := True;
    btnCikis.Enabled := False;
  end
  else
  begin
    btnDekontSil.Enabled := False;
    btnYENI.Enabled := True;
    btnAra.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
    btnCikis.Enabled := True;
  end;
end;

procedure TfrmDekontUrun.qryDEKONT_DAfterDelete(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
end;

procedure TfrmDekontUrun.qryDEKONT_DAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with IB_Dataset do
  begin
    FieldByName('DEKONT_D_SID').AsInteger := glb_SID;
    FieldByName('DEKONT_ID').AsInteger := qryDEKONT.FieldByName('DEKONT_ID').AsInteger;
    FieldByName('DEKONT_SID').AsInteger := qryDEKONT.FieldByName('DEKONT_SID').AsInteger;
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
    FieldByName('MIKTAR').AsCurrency := 1;
    FieldByName('BIRIMFIY').AsCurrency := 1;
    FieldByName('ACIKLAMA1').AsString :=  qryDEKONT.FieldByName('ACIKLAMA').AsString;
    FieldByName('PROJE_KOD').AsString :=  qryDEKONT.FieldByName('PROJE_KOD').AsString;
    FieldByName('PROJE_AD').AsString :=  qryDEKONT.FieldByName('PROJE_AD').AsString;
    FieldByName('MC').AsString := 'U';
    FieldByName('BA').AsString := BORC;
  end;
  if not glb_DOVTAKIP then
  begin
    qryDEKONT_D.FieldByName('DOVKOD').AsString := glb_DEFCUR ;
    qryDEKONT_D.FieldByName('DOVKUR').AsCurrency := 1;
  end;
end;

procedure TfrmDekontUrun.qryDEKONT_DAfterOpen(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
end;

procedure TfrmDekontUrun.qryDEKONT_DAfterPost(IB_Dataset: TIB_Dataset);
begin
  BakiyeHesapla;
end;

procedure TfrmDekontUrun.qryDEKONT_DAfterScroll(IB_Dataset: TIB_Dataset);
begin
  if IB_Dataset.FieldByName('MC').AsString = 'M' then
  begin
    txtKARSI_KOD.AutoLabel.Caption := 'Masraf';
    edtMiktar.enabled := False;
    edtBirimFiy.enabled := False;
  end
  else
  begin
    txtKARSI_KOD.AutoLabel.Caption := 'Ürün';
    edtMiktar.enabled := True;
    edtBirimFiy.enabled := True;
  end;
end;

procedure TfrmDekontUrun.qryDEKONT_DBeforePost(IB_Dataset: TIB_Dataset);
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

procedure TfrmDekontUrun.dtsDEKONT_DStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
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

procedure TfrmDekontUrun.pcDEKONTChanging(Sender: TObject; var AllowChange: Boolean);
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
        if prv_MUH_FIS_FARK=0 Then
        begin
          if not (prv_BAKIYE < 0.1) Then
          begin
            Application.MessageBox('Bakiye veren dekonttan çýkamazsýnýz.','Dikkat',MB_ICONWARNING);
            AllowChange := False;
          end;
        end;
      end;
    end; //1 end;
  end;//Case End;
end;

procedure TfrmDekontUrun.dtsDEKONT_DDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  if Assigned( Field ) then
  begin
    if  (Field.FieldName='MIKTAR') then
    begin
      KalemHesapla;
    end;
//****************************************************************************//
    if  (Field.FieldName='BIRIMFIY') then
    begin
      KalemHesapla;
    end;
//****************************************************************************//
    if  (Field.FieldName='TUTAR') then
    begin
      qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency := qryDEKONT_D.FieldByName('TUTAR').AsCurrency;
    end;
  end;
end;


procedure TfrmDekontUrun.KalemHesapla;
begin
/// ürün secilmediði zaman miktar hesaplamalara 1 olarak katýlacak
// yada hesaplamalardan cýkarýlacak
  qryDEKONT_D.FieldByName('TUTAR').AsCurrency := qryDEKONT_D.FieldByNAme('MIKTAR').AsCurrency * qryDEKONT_D.FieldByName('BIRIMFIY').AsCurrency;
  qryDEKONT_D.FieldByName('TUTAR_VPB').AsCurrency := qryDEKONT_D.FieldByName('TUTAR').AsCurrency;
end;
end.
