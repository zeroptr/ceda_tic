unit ufrmSENET;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, IB_Controls, IB_Grid, Mask, ExtCtrls, Buttons;
type
    TfrmSENET = class(TForm)
    qry_SENET: TIB_Query;
    dts_SENET: TIB_DataSource;
    trn_SENET: TIB_Transaction;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    pnlSENET: TPanel;
    rd_ASIL: TIB_RadioGroup;
    IB_Date1: TIB_Date;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    txt_SENETSahibi: TIB_Edit;
    IB_Date2: TIB_Date;
    IB_Date3: TIB_Date;
    IB_Edit7: TIB_Edit;
    edt_tutar: TIB_Currency;
    IB_Date7: TIB_Date;
    IB_Date8: TIB_Date;
    edt_Dovkur: TIB_Currency;
    IB_Currency3: TIB_Currency;
    cmb_Durum: TIB_ComboBox;
    cmb_YerKod: TIB_ComboBox;
    txtCARI_KOD: TIB_Edit;
    txtCARI_AD: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    txtPROJE_KOD: TIB_Edit;
    txtPROJE_AD: TIB_Edit;
    txtPLASIYER_KOD: TIB_Edit;
    txtPLASIYER_AD: TIB_Edit;
    IB_Edit3: TIB_Edit;
    cboDOVKOD: TIB_ComboBox;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    procedure DataSet_Open(Menu:Boolean; SENET_ID:Integer;SENET_SID:Integer;Islem:Byte; Goruntule:Boolean);
    function  Form_Open(Menu:Boolean; SENET_ID, SENET_SID: Integer; Islem, Tip : Byte; BelgeTuru: Byte; Goruntule:Boolean): Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSILClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnCIKISClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edt_DovkurExit(Sender: TObject);
    procedure IB_Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure baslik_ayarla(tip:byte);
    procedure dts_SENETDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure txtCARI_KODButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtCARI_KODExit(Sender: TObject);
    procedure txtCARI_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPROJE_KODButtonClick(Sender: TObject);
    procedure txtPROJE_KODExit(Sender: TObject);
    procedure txtPROJE_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPLASIYER_KODExit(Sender: TObject);
    procedure txtPLASIYER_KODButtonClick(Sender: TObject);
    procedure txtPLASIYER_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure dts_SENETStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
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
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure IB_Date1Enter(Sender: TObject);
    procedure IB_Date1Exit(Sender: TObject);
    procedure txtCARI_KODEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtCARI_ADExit(Sender: TObject);
    procedure txtCARI_ADEnter(Sender: TObject);
    procedure rd_ASILEnter(Sender: TObject);
    procedure rd_ASILExit(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
    procedure edt_DovkurEnter(Sender: TObject);
    procedure edt_tutarExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prv_Belge_Turu,prv_SENETTip:Integer;
    PRV_ISN:Integer;
    Muh_Kod,Aciklama:String;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;
  const cns_senet = 6;
  var
  frmSENET: TfrmSENET;
implementation

{$R *.DFM}
uses unFunc,unDataMod, ufrmCariSDLG, ufrmISN_ERRORS, main, ufrmCekSenSDLG,
   unCEKSENHAR, unLogger;

function TfrmSENET.Form_Open(Menu: Boolean; SENET_ID, SENET_SID: Integer; Islem, Tip : Byte; BelgeTuru: Byte; Goruntule:Boolean): Boolean;
var
  local_can_update,local_can_delete : Boolean;
begin
  Result := False;
  if not DataMod.Modul_Hak(cns_senet,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((SENET_ID = 0) and (SENET_SID = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    if not MainForm.FindChildFrm( Application, 'frm_SENET') then
    begin
      Application.CreateForm(TfrmSENET,frmSENET);
      baslik_ayarla(Tip);
      with frmSENET do
      begin
        prv_Belge_Turu := BelgeTuru;
        prv_SENETTip := Tip;
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
        with qry_SENET do
        begin
          FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
          FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
          FieldByName('TUTAR_VPB').DisplayFormat := glb_DOV_FIELD_PF;
        end;
        DataSet_Open(False,SENET_ID,SENET_SID,Islem,Goruntule);
        Result := True;
      end;
    end;
  end;
end;


procedure TfrmSENET.DataSet_Open(Menu:Boolean; SENET_ID:Integer;SENET_SID:Integer;Islem:Byte; Goruntule:Boolean);
var res_CARI:TStringList;
//Parametreler
//SENETID : SENETin ID numarasý
//SENET_SID : SENETin SID numarasý
//Islem 0 ise insert 1 ise edit'tir.
// 1 MÜÞTERÝ ÇEKÝ
// 2 BORÇ ÇEKÝ
begin
// Islem = 0 Yeni Kayýt
// Islem = 1 Edit
  if ((SENET_ID = 0) and (SENET_SID = 0) and (prv_CanUpdate=False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.Rapor_Kod_Visible_Fields_IB('CEKSEN',ib_edit8,ib_edit10,ib_edit11,ib_edit12,ib_edit13);

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

  if not Goruntule then
  begin
    PRV_ISN := DataMod.Get_Isn_Num;
  end;

  if Goruntule then
  begin
    qry_SENET.ReadOnly := True;
    qry_SENET.RequestLive := False;
  end;

  with qry_SENET do
  begin
    Active := False;
    ParamByName('PRM_SENET_ID').AsInteger := SENET_ID;
    ParamByName('PRM_SENET_SID').AsInteger := SENET_SID;
    try
      Active := True;
    except
      Application.MessageBox('ÇEK sql cümleciðinde Hata...','Dikkat',MB_ICONHAND);
      ShowMessage(qry_SENET.SQL.Text);
    end;
  end;

  cmb_durum.ReadOnly := True;
  cmb_YerKod.ReadOnly := True;

  if Goruntule then
  begin
    btnYeni.Enabled := False;
    btnAra.Enabled := False;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
    btnSil.Enabled := False;
    pnlSENET.Enabled := False;
    Exit;
  end;

  case Islem Of
  0: // Yeni Kayýtta Yapýlacak iþlemler
    begin
      with qry_SENET do
      begin
        Insert;
        FieldByName('SENET_SID').AsInteger := glb_SID;
        FieldByName('DOVKOD').AsString := glb_DEFCUR;
        FieldByName('DOVKUR').AsCurrency := 1;
        FieldByName('ISLEMTAR').AsDate := DataMod.GET_SERVER_DATE;
        FieldByName('ODEME_TAR').AsDate := FieldByName('ISLEMTAR').AsDate;
        FieldByName('TANZIMTAR').AsDate := FieldByName('ISLEMTAR').AsDate;
        FieldByName('VADETAR').AsDate := FieldByName('ISLEMTAR').AsDate;
        FieldByName('FIILI_TAR').AsDate := FieldByName('ISLEMTAR').AsDate;
        FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('ISLEMTAR').AsDate;
        FieldByName('ASIL').AsInteger := 1;
      end;

      case prv_SENETTip of
      1:
        begin // 1 MÜÞTERÝ SENEDI
          with qry_SENET do
          begin
            FieldByName('TIP').AsInteger := prv_SENETTip;
            FieldByName('DURUM').asInteger := 1;
            FieldByName('YER_KOD').AsInteger := 1;
          end;
        end;
      2:
        begin // 2 BORÇ SENEDI
          with qry_SENET do
          begin
            FieldByName('TIP').AsInteger := prv_SENETTip;
            FieldByName('DURUM').AsInteger := 1;
            FieldByName('YER_KOD').AsInteger := 2;
          end;
          res_Cari := TStringList.Create;
          if DataMod.FN_Sirket(res_Cari) then qry_SENET.FieldByName('SENET_SAHIBI').AsString := res_Cari[1];
          res_Cari.Free;
          rd_ASIL.ReadOnly := True;
          rd_ASIL.TabStop := False;
          txt_SENETSahibi.Enabled := False;
          txt_SENETSahibi.TabStop := False;
        end;
      end;//end case prv_SENETTip of
    end;
  1: // Edit iþleminde Yapýlacak iþlemler
    begin
      qry_SENET.Edit;
//****************************************************************************//
//****************************************************************************//
      case prv_SENETTip of
      2:
        begin
          rd_ASIL.ReadOnly := True;
          rd_ASIL.TabStop := False;
          txt_SENETSahibi.Enabled := False;
          txt_SENETSahibi.TabStop := False;
        end;
      end;
    end;
  end;//end case
end;

procedure TfrmSENET.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TfrmSENET.btnSILClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmSENET.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmSENET.btnIPTALClick(Sender: TObject);
begin
  case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO) of
  6://yes
    begin
      qry_SENET.CancelUpdates;
      qry_SENET.CommitUpdates;
      if trn_SENET.InTransaction then trn_SENET.Rollback;
      qry_SENET.Close;
    end;
  end;
end;

procedure TfrmSENET.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(false,0,glb_SID,0,False);
  txtCARI_KOD.SetFocus;
end;

procedure TfrmSENET.btnAraClick(Sender: TObject);
var
  SENET_ID,SENET_SID:Integer;
begin
  if frmCekSenSDLG.Form_Open(False,2,SENET_ID,SENET_SID,frmSENET.prv_SENETTip,False,0,0) Then
  begin
    frmSENET.DataSet_Open(false,SENET_ID,SENET_SID,1,False);
  end;
end;

procedure TfrmSENET.btnCIKISClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSENET.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_SENET.State in [dssInsert,dssEdit] then
  begin
    Application.MessageBox('Deðiþiklikleri kaydetmeli ya da iptal etmelisiniz.','Dikkat',MB_ICONHAND);
    CanClose := False;
  end;
end;

procedure TfrmSENET.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SelectNext(ActiveControl as tWinControl,True,True);
  end;
  if Key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

procedure TfrmSENET.edt_DovkurExit(Sender: TObject);
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if (qry_SENET.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada küçük olamaz.Lütfen kontrol ediniz.');
    qry_SENET.FieldByName('DOVKUR').AsCurrency := 1;
    edt_Dovkur.SetFocus;
    exit;
  end;
  (Sender as TIB_Currency).Color := clWindow;
end;


procedure TfrmSENET.IB_Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmSENET.baslik_ayarla(tip: byte);
begin
  case tip of
  1:
    begin
      frmSENET.Caption := 'Senet Ýþlemleri - Müþteri Senet Alýndý Kaydý';
    end;
  2:
    begin
      frmSENET.Caption := 'Senet Ýþlemleri - Borç Senedi';
    end;
  end;
end;

procedure TfrmSENET.dts_SENETDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
var
  Kur:Currency;
begin
  if  Assigned( Field ) Then
  begin
    if Field.FieldName = 'DOVKOD' then
    begin
      Kur := DataMod.Get_Doviz_Kur(qry_SENET.FieldByName('DOVKOD').AsString,qry_SENET.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur <> 0 then qry_SENET.FieldByName('DOVKUR').AsCurrency := Kur else qry_SENET.FieldByName('DOVKUR').AsCurrency := 1;
    end;
    if (Field.FieldName = 'TUTAR') or (Field.FieldName = 'DOVKUR') then
    begin
      qry_SENET.FieldByName('TUTAR_VPB').AsCurrency := qry_SENET.FieldByName('TUTAR').AsCurrency * qry_SENET.FieldByName('DOVKUR').AsCurrency;
    end;
  end;
end;

procedure TfrmSENET.txtCARI_KODButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) then
  begin
    with qry_SENET do
    begin
      FieldByName('CARI_KOD').AsString := Cari_KOD;
      FieldByName('CARI_ADD').AsString := Cari_AD;
    end;
    if Trim(qry_SENET.FieldByName('ACIKLAMA').AsString)='' then
    begin
      if Trim(qry_SENET.FieldByName('SENET_ID').AsString)<>'' then
      begin
        case prv_SENETTip of
        1:qry_SENET.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' dan '+ qry_SENET.FieldByName('SENET_ID').AsString+' nolu senet alýmý.';
        2:qry_SENET.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' a '+ qry_SENET.FieldByName('SENET_ID').AsString+' nolu senet verimi.';
        end;
      end;
    end;
  end;
end;

procedure TfrmSENET.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure TfrmSENET.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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

procedure TfrmSENET.txtCARI_KODExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCARI_KOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCARI_KOD.Text,CARI_AD) then
    begin
      qry_SENET.FieldByName('CARI_ADD').AsString := CARI_AD;
      if Trim(qry_SENET.FieldByName('ACIKLAMA').AsString)='' then
      begin
        if Trim(qry_SENET.FieldByName('SENET_ID').AsString)<>'' then
        begin
          case prv_SENETTip of
          1:qry_SENET.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' dan '+ qry_SENET.FieldByName('SENET_ID').AsString+' nolu senet alýmý.';
          2:qry_SENET.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' a '+ qry_SENET.FieldByName('SENET_ID').AsString+' nolu senet verimi.';
          end;
        end;
      end;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtCARI_KOD.SetFocus
    end;
    (Sender as TIB_Edit).Color := clWindow;
  end
  else
  begin
    qry_SENET.FieldByName('CARI_ADD').AsString := '';
    (Sender as TIB_Edit).Color := clWindow;
  end;
  if (prv_SENETTip = 1) and (rd_ASIL.ItemIndex = 1)  then  qry_SENET.FieldByName('SENET_SAHIBI').AsString := txtCARI_AD.Text;
end;

procedure TfrmSENET.txtCARI_KODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txtCARI_KODButtonClick(self);
end;

procedure TfrmSENET.txtPROJE_KODButtonClick(Sender: TObject);
var
  PROJE_KOD,PROJE_AD:String;
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Proje(PROJE_KOD,PROJE_AD,1) Then
  begin
    qry_SENET.FieldByName('PROJE_KOD').AsString := PROJE_KOD;
    qry_SENET.FieldByName('PROJE_AD').AsString := PROJE_AD;
  end;
end;

procedure TfrmSENET.txtPROJE_KODExit(Sender: TObject);
var
  PROJE_AD:String;
begin
  if Trim(txtPROJE_KOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',txtPROJE_KOD.Text,PROJE_AD) then
    begin
      qry_SENET.FieldByName('PROJE_AD').AsString := PROJE_AD;
     (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtPROJE_KOD.SetFocus;
    end;
  end
  else
  begin
    qry_SENET.FieldByName('PROJE_AD').AsString := '';
    (Sender as TIB_Edit).Color := clWindow;
  end;
end;

procedure TfrmSENET.txtPROJE_KODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txtPROJE_KODButtonClick(self);
end;

procedure TfrmSENET.txtPLASIYER_KODExit(Sender: TObject);
var
  PLASIYER_AD:String;
begin
  if Trim(txtPLASIYER_KOD.Text) <> '' then
  begin
    if  DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',txtPLASIYER_KOD.Text,PLASIYER_AD) then
    begin
      qry_SENET.FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtPLASIYER_KOD.SetFocus;
    end;
  end
  else
  begin
    qry_SENET.FieldByName('PLASIYER_AD').AsString := '';
    (Sender as TIB_Edit).Color := clWindow;
  end;
end;

procedure TfrmSENET.txtPLASIYER_KODButtonClick(Sender: TObject);
var
  PLASIYER_KOD, PLASIYER_AD :String;
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Plasiyer(PLASIYER_KOD, PLASIYER_AD,1) then
  begin
    qry_SENET.FieldByName('PLASIYER_KOD').AsString := PLASIYER_KOD;
    qry_SENET.FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
  end;
end;

procedure TfrmSENET.txtPLASIYER_KODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txtPLASIYER_KODButtonClick(self);
end;

procedure TfrmSENET.dts_SENETStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) Then
  begin
    btnYeni.Enabled:=False;
    if ADataset.State in [dssEdit] then btnSil.Enabled := True else btnSil.Enabled := False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    {if not ((ADataset.Eof) And (ADataset.Bof)) then btnSil.Enabled := True
    else btnSil.Enabled := False;
    }
    if ADataset.FieldByName('SENET_ID').AsInteger<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmSENET.IB_Edit8ButtonClick(Sender: TObject);
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qry_SENET.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmSENET.IB_Edit10ButtonClick(Sender: TObject);
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qry_SENET.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmSENET.IB_Edit11ButtonClick(Sender: TObject);
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qry_SENET.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmSENET.IB_Edit12ButtonClick(Sender: TObject);
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qry_SENET.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmSENET.IB_Edit13ButtonClick(Sender: TObject);
begin
  if not (qry_SENET.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qry_SENET.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmSENET.IB_Edit8Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit8.Text)) = 0 then
  begin
    (Sender as TIB_Edit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit8,nil,0) then
  begin
    (Sender as TIB_Edit).Color := clWindow;
  end
  else
  begin
    IB_Edit8.SetFocus;
  end;
end;

procedure TfrmSENET.IB_Edit10Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit10.Text)) = 0 then
  begin
    (Sender as TIB_Edit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit10,nil,1) then
  begin
    (Sender as TIB_Edit).Color := clWindow;
  end
  else
  begin
    IB_Edit10.SetFocus;
  end;
end;

procedure TfrmSENET.IB_Edit11Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit11.Text)) = 0 then
  begin
    (Sender as TIB_Edit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit11,nil,2) then
  begin
    (Sender as TIB_Edit).Color := clWindow;
  end
  else
  begin
    IB_Edit11.SetFocus;
  end;
end;

procedure TfrmSENET.IB_Edit12Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit12.Text)) = 0 then
  begin
    (Sender as TIB_Edit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit12,nil,3) then
  begin
    (Sender as TIB_Edit).Color := clWindow;
  end
  else
  begin
    IB_Edit12.SetFocus;
  end;
end;

procedure TfrmSENET.IB_Edit13Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit13.Text)) = 0 then
  begin
    (Sender as TIB_Edit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit13,nil,4) then
  begin
    (Sender as TIB_Edit).Color := clWindow;
  end
  else
  begin
    IB_Edit13.SetFocus;
  end;
end;

procedure TfrmSENET.IB_Edit8KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure TfrmSENET.IB_Edit10KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure TfrmSENET.IB_Edit11KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure TfrmSENET.IB_Edit12KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure TfrmSENET.IB_Edit13KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;


function TfrmSENET.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if Trim(txtCARI_KOD.Text) = '' then
  begin
    Application.MessageBox('Lütfen iþlem yapýlan cariyi belirtiniz..','Dikkat',MB_ICONSTOP);
    txtCARI_KOD.SetFocus;
    exit;
  end;
  if Trim(qry_SENET.FieldByName('ACIKLAMA').AsString) = '' then
  begin
    Application.MessageBox('Lütfen iþlem açýklamasý belirtiniz..','Dikkat',MB_ICONSTOP);
    IB_Edit7.SetFocus;
    exit;
  end;
  if qry_SENET.FieldByName('TUTAR').AsCurrency <= 0 then
  begin
    Application.MessageBox('Tutar bilgisi sýfýra eþit yada küçük olamaz..','Dikkat',MB_ICONSTOP);
    edt_Tutar.SetFocus;
    exit;
  end;
  if (qry_SENET.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    edt_Dovkur.SetFocus;
    exit;
  end;
  if (qry_SENET.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    edt_tutar.SetFocus;
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qry_SENET.FieldByName('ISLEMTAR').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qry_SENET.FieldByName('ISLEMTAR').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qry_SENET.FieldByName('TANZIMTAR').AsDate, 'Tanzim Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qry_SENET.FieldByName('FIILI_TAR').AsDate, 'Fiili Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qry_SENET.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qry_SENET.FieldByName('VADETAR').AsDate, 'Vade Tarihi') then Exit;
  Result := True;
end;


procedure TfrmSENET.Form_Post;
var
  SENETID,SENETSID : Integer;
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
    if trn_SENET.InTransaction then
    trn_SENET.RollbackRetaining;
//****************************************************************************//
    trn_SENET.StartTransaction;
//****************************************************************************//
    SENETID := qry_SENET.FieldByName('SENET_ID').AsInteger;
    SENETSID := qry_SENET.FieldByName('SENET_SID').AsInteger;
//****************************************************************************//
    if not dmCEKSENHAR.CEKSEN_AUD(trn_SENET,SENET,qry_SENET,0) then
    begin
      trn_SENET.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Application.MessageBox('Hareket Kayýtlarý yaratýlýrken hata oluþtu, Lütfen girdiðiniz deðerleri kontrol ediniz ','Dikkat',MB_ICONHAND);
      Exit;
    end;
//****************************************************************************//
    with qry_SENET do
    begin
      Post;
      ApplyUpdates;
      CommitUpdates;
    end;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SENET,CEKSENHAR,',
                                             prv_Belge_Turu,
                                             SENETID,
                                             SENETSID,
                                             1,1,'');
//****************************************************************************//
    trn_SENET.Commit;
  except
    trn_SENET.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  qry_SENET.Close;
end;


function TfrmSENET.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qry_SENET.FieldByName('ISLEMTAR').AsDate,True) then Exit;
  Result := True;
end;

procedure TfrmSENET.Form_Delete;
var
  SENET_ID,SENET_SID : Integer;
begin
  if not Form_Before_Delete then exit;
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then exit;
  qry_SENET.Cancel;//edit konumunda girmiþ olacaðý için
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trn_SENET.InTransaction then
    trn_SENET.RollbackRetaining;
//****************************************************************************//
    trn_SENET.StartTransaction;
//****************************************************************************//
    if not dmCEKSENHAR.CEKSEN_AUD(trn_SENET,SENET,qry_SENET,1) then
    begin
      trn_SENET.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Application.MessageBox('Hareket Kayýtlarý Silinirken hata oluþtu','Dikkat',MB_ICONHAND);
      exit;
    end;
//****************************************************************************//
    SENET_ID := qry_SENET.FieldByName('SENET_ID').AsInteger;
    SENET_SID := qry_SENET.FieldByName('SENET_SID').AsInteger;
//****************************************************************************//
    qry_SENET.Delete;
    qry_SENET.ApplyUpdates;
    qry_SENET.CommitUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('SENET,CEKSENHAR,',
                                             prv_Belge_Turu,
                                             SENET_ID,
                                             SENET_SID,
                                             1,2,'');
//****************************************************************************//
    trn_SENET.Commit;
  except;
    Application.MessageBox('SENET silinirken bir hata oluþtu.','Dikkat',MB_ICONERROR);
    trn_SENET.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmSENET.IB_Date1Enter(Sender: TObject);
begin
  (Sender as TIB_Date).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSENET.IB_Date1Exit(Sender: TObject);
begin
  (Sender as TIB_Date).Color := clWindow;
end;

procedure TfrmSENET.txtCARI_KODEnter(Sender: TObject);
begin
  (Sender as TIB_Edit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSENET.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmSENET);
end;

procedure TfrmSENET.txtCARI_ADExit(Sender: TObject);
begin
  (Sender as TIB_Edit).Color := clWindow;
end;

procedure TfrmSENET.txtCARI_ADEnter(Sender: TObject);
begin
  (Sender as TIB_Edit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSENET.rd_ASILEnter(Sender: TObject);
begin
  (Sender as TIB_RadioGroup).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSENET.rd_ASILExit(Sender: TObject);
begin
  (Sender as TIB_RadioGroup).Color := clBtnFace;
end;

procedure TfrmSENET.cboDOVKODEnter(Sender: TObject);
begin
  (Sender as TIB_ComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSENET.cboDOVKODExit(Sender: TObject);
begin
  (Sender as TIB_ComboBox).Color := clWindow;
end;

procedure TfrmSENET.edt_DovkurEnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmSENET.edt_tutarExit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

end.
