unit ufrmCek;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, IB_Controls, Buttons, IB_Grid, Mask, ExtCtrls;

type
    Tfrm_Cek = class(TForm)
    qry_Cek: TIB_Query;
    dts_Cek: TIB_DataSource;
    trn_Cek: TIB_Transaction;
    pnlCEK: TPanel;
    rd_ASIL: TIB_RadioGroup;
    IB_Date1: TIB_Date;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    txt_CekSahibi: TIB_Edit;
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
    IB_Edit6: TIB_Edit;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    rgYAZICI: TRadioGroup;
    cboDOVKOD: TIB_ComboBox;
    btnCikti: TButton;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
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
    procedure dts_CekDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure txtCARI_KODButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure txtCARI_KODExit(Sender: TObject);
    procedure txtCARI_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPROJE_KODButtonClick(Sender: TObject);
    procedure txtPROJE_KODExit(Sender: TObject);
    procedure txtPROJE_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtPLASIYER_KODExit(Sender: TObject);
    procedure txtPLASIYER_KODButtonClick(Sender: TObject);
    procedure txtPLASIYER_KODKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure dts_CekStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
    procedure IB_Edit6ButtonClick(Sender: TObject);
    procedure IB_Edit6Exit(Sender: TObject);
    procedure IB_Edit6KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit8Exit(Sender: TObject);
    procedure IB_Edit10Exit(Sender: TObject);
    procedure IB_Edit11Exit(Sender: TObject);
    procedure IB_Edit12Exit(Sender: TObject);
    procedure IB_Edit13Exit(Sender: TObject);
    procedure IB_Edit10ButtonClick(Sender: TObject);
    procedure IB_Edit8ButtonClick(Sender: TObject);
    procedure IB_Edit11ButtonClick(Sender: TObject);
    procedure IB_Edit12ButtonClick(Sender: TObject);
    procedure IB_Edit13ButtonClick(Sender: TObject);
    procedure IB_Edit8KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit10KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit11KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit12KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit13KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    procedure DataSet_Open(Menuden:Boolean; CEK_ID:Integer;CEK_SID:Integer;Islem:Byte; Goruntule:Boolean);
    function  Form_Open(Menu: Boolean; CekID, CekSID: Integer; Islem, Tip : Byte; BelgeTuru: Byte; Goruntule:Boolean): Boolean;
    function  ON_MUH_ENT(SIL:Byte):Boolean;
    procedure Form_Post;
    procedure Form_Delete;
    function  Form_Before_Post:Boolean;
    function  Form_Before_Delete:Boolean;
    procedure baslik_ayarla(tip:byte);
    procedure IB_Date1Enter(Sender: TObject);
    procedure IB_Date1Exit(Sender: TObject);
    procedure txtCARI_ADEnter(Sender: TObject);
    procedure txtCARI_ADExit(Sender: TObject);
    procedure edt_DovkurEnter(Sender: TObject);
    procedure rd_ASILEnter(Sender: TObject);
    procedure rd_ASILExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_tutarExit(Sender: TObject);
    procedure cboDOVKODEnter(Sender: TObject);
    procedure cboDOVKODExit(Sender: TObject);
    procedure rgYAZICIEnter(Sender: TObject);
    procedure rgYAZICIExit(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prv_Belge_Turu:Integer;
    prnCEKID,prnCEKSID,PRV_ISN:Integer;
    Muh_Kod,Aciklama:String;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
    prv_CekTip:Integer;
  end;
  const cns_cek = 5;
  var
  frm_Cek: Tfrm_Cek;
implementation

{$R *.DFM}
uses unFunc,unDataMod, ufrmCariSDLG, ufrmISN_ERRORS, main, ufrmCekSenSDLG, unCEKSENHAR, unYazici,
  unLogger, DateUtils, UDm_Fast_Report;


function Tfrm_Cek.Form_Open(Menu: Boolean; CekID, CekSID: Integer; Islem, Tip : Byte; BelgeTuru: Byte; Goruntule:Boolean): Boolean;
var
  local_can_update,local_can_delete : Boolean;
begin
  Result := False;
  if not DataMod.Modul_Hak(cns_cek,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((CekID = 0) and (CekSID = 0) and (local_can_update = False) ) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    if not MainForm.FindChildFrm(Application,'frm_Cek') then
    begin
      Application.CreateForm(Tfrm_Cek,frm_Cek);
      with frm_Cek do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
        with qry_Cek do
        begin
          FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
          FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
          FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
        end;
      end;
    end;
  end;

  baslik_ayarla(Tip);
  with frm_Cek do
  begin
    prv_Belge_Turu := BelgeTuru;
    prv_CekTip := Tip;
    if Tip = 1 then
    begin
      IB_Edit6.Visible := False;
      IB_Edit1.Visible := False;
    end;
  end;
  frm_Cek.DataSet_Open(False,CekID,CekSID,Islem,Goruntule);
  Result := True;
end;


procedure Tfrm_Cek.DataSet_Open(Menuden:Boolean; CEK_ID:Integer;CEK_SID:Integer;Islem:Byte; Goruntule:Boolean);
var
  res_CARI:TStringList;
  //Parametreler
  //CekID : Cekin ID numarasý
  //Cek_SID : Cekin SID numarasý
  //Islem 0 ise insert 1 ise edit'tir.
  // 1 MÜÞTERÝ ÇEKÝ
  // 2 BORÇ ÇEKÝ
begin
  // Islem = 0 Yeni Kayýt
  // Islem = 1 Edit
  if ((CEK_ID = 0) and (CEK_SID = 0) and (prv_CanUpdate = False)) then
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
    qry_Cek.ReadOnly := True;
    qry_Cek.RequestLive := False;
  end;

  with qry_Cek do
  begin
    Active := False;
    qry_Cek.ParamByName('PRM_CEK_ID').AsInteger := CEK_ID;
    qry_Cek.ParamByName('PRM_CEK_SID').AsInteger := CEK_SID;
    try
      Active := True;
    except
      Application.MessageBox('ÇEK sql cümleciðinde Hata...','Dikkat',MB_ICONHAND);
      ShowMessage(qry_Cek.SQL.Text);
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
    pnlCEK.Enabled := False;
    Exit;
  end;

  case Islem Of
  0: // Yeni Kayýtta Yapýlacak iþlemler
    begin
      qry_Cek.Insert;
      with qry_Cek do
      begin
        FieldByName('CEK_SID').AsInteger := glb_SID;
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
      case prv_CekTip of
      1:
        begin // 1 MÜÞTERÝ ÇEKÝ
          qry_Cek.FieldByName('TIP').AsInteger := prv_CekTip;
          qry_Cek.FieldByName('DURUM').asInteger := 1;
          qry_Cek.FieldByName('YER_KOD').AsInteger := 1;
        end;
      2:
        begin // 2 BORÇ ÇEKÝ
          qry_Cek.FieldByName('TIP').AsInteger := prv_CekTip;
          qry_Cek.FieldByName('DURUM').AsInteger := 1;
          qry_Cek.FieldByName('YER_KOD').AsInteger := 2;
          res_Cari := TStringList.Create;
          if DataMod.FN_Sirket(res_Cari) then qry_Cek.FieldByName('CEK_SAHIBI').AsString := res_Cari[1];
          res_Cari.Free;
          rd_ASIL.ReadOnly := True;
          rd_ASIL.TabStop := False;
          txt_CekSahibi.Enabled := False;
          txt_CekSahibi.TabStop := False;
        end;
      end;
    end;
  1: // Edit iþleminde Yapýlacak iþlemler
    begin
      qry_Cek.Edit;
      prnCEKID := qry_Cek.FieldByName('CEK_ID').AsInteger;
      prnCEKSID := qry_Cek.FieldByName('CEK_SID').AsInteger;
      case prv_CekTip of
      2:
        begin
          rd_ASIL.ReadOnly := True;
          rd_ASIL.TabStop := False;
          txt_CekSahibi.Enabled := False;
          txt_CekSahibi.TabStop := False;
        end;
      end;
    end;
  end;
end;

procedure Tfrm_Cek.btnSILClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure Tfrm_Cek.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

procedure Tfrm_Cek.btnIPTALClick(Sender: TObject);
begin
  case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO) of
  6://yes
    begin
      qry_Cek.CancelUpdates;
      qry_Cek.CommitUpdates;
      if trn_Cek.InTransaction then trn_CEK.Rollback;
      qry_Cek.Close;
      prnCEKID := 0;
      prnCEKSID := 0;
    end;
  end;
end;

procedure Tfrm_Cek.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(False,0,glb_SID,0,False);
  txtCARI_KOD.SetFocus;
end;

procedure Tfrm_Cek.btnAraClick(Sender: TObject);
var
  Cek_ID,Cek_SID:Integer;
begin
  case prv_CekTip of
  1:
    begin
      if frmCekSenSDLG.Form_Open(False,1,Cek_ID,Cek_SID,frm_Cek.prv_CekTip,False,1,1) then
      begin
        frm_Cek.DataSet_Open(False,Cek_ID,Cek_SID,1,False);
      end;
    end;
  2:
    begin
      if frmCekSenSDLG.Form_Open(False,1,Cek_ID,Cek_SID,frm_Cek.prv_CekTip,False,1,2) then
      begin
        frm_Cek.DataSet_Open(False,Cek_ID,Cek_SID,1,False);
      end;
    end;
  end;

end;

procedure Tfrm_Cek.btnCIKISClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_Cek.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Cek.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli ya da Ýptal etmelisiniz','Dikkat',MB_ICONHAND);
    CanClose := False;
  end;
end;

procedure Tfrm_Cek.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure Tfrm_Cek.edt_DovkurExit(Sender: TObject);
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if (qry_Cek.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz..');
    qry_Cek.FieldByName('DOVKUR').AsCurrency := 1;
    edt_Dovkur.SetFocus;
    exit;
  end;
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure Tfrm_Cek.IB_Edit4KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure Tfrm_Cek.baslik_ayarla(tip: byte);
begin
  case tip of
  1:
    begin
      frm_Cek.Caption := 'Çek Ýþlemleri - Müþteri Çek Alýndý Kaydý';
    end;
  2:
    begin
      frm_Cek.Caption := 'Çek Ýþlemleri - Borç Çeki';
    end;
  end;
end;

procedure Tfrm_Cek.dts_CekDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
var
  Kur:Currency;
begin
  if  Assigned( Field ) Then
  begin
    if Field.FieldName = 'DOVKOD' then
    begin
      KUR := DataMod.Get_Doviz_Kur(qry_Cek.FieldByName('DOVKOD').AsString,qry_Cek.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
      if Kur <> 0 then qry_Cek.FieldByName('DOVKUR').AsCurrency := Kur else qry_Cek.FieldByName('DOVKUR').AsCurrency := 1;
    end;
    if (Field.FieldName = 'TUTAR') or (Field.FieldName = 'DOVKUR') then
    qry_Cek.FieldByName('TUTAR_VPB').AsCurrency := qry_Cek.FieldByName('TUTAR').AsCurrency * qry_Cek.FieldByName('DOVKUR').AsCurrency ;
  end;
end;

procedure Tfrm_Cek.txtCARI_KODButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
    qry_Cek.FieldByName('CARI_KOD').AsString := Cari_KOD;
    qry_Cek.FieldByName('CARI_ADD').AsString := Cari_AD;
    if Trim(qry_Cek.FieldByName('ACIKLAMA').AsString)='' then
    begin
      if Trim(qry_Cek.FieldByName('CEK_NUM').AsString)<>'' then
      begin
        case prv_CekTip of
        1:qry_Cek.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' dan '+ qry_Cek.FieldByName('CEK_NUM').AsString+' nolu çek alýmý.';
        2:qry_Cek.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' a '+ qry_Cek.FieldByName('CEK_NUM').AsString+' nolu çek verimi.';
        end;
      end;
    end;
  end;
end;

procedure Tfrm_Cek.FormShow(Sender: TObject);
begin
  cboDOVKOD.Items.Assign(glb_DOV_LIST);
end;

procedure Tfrm_Cek.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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

procedure Tfrm_Cek.txtCARI_KODExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCARI_KOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCARI_KOD.Text,CARI_AD) then
    begin
      qry_Cek.FieldByName('CARI_ADD').AsString := CARI_AD;
      if Trim(qry_Cek.FieldByName('ACIKLAMA').AsString)='' then
      begin
        if Trim(qry_Cek.FieldByName('CEK_NUM').AsString)<>'' then
        begin
          case prv_CekTip of
          1:qry_Cek.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' dan '+ qry_Cek.FieldByName('CEK_NUM').AsString+' nolu çek alýmý.';
          2:qry_Cek.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' a '+ qry_Cek.FieldByName('CEK_NUM').AsString+' nolu çek verimi.';
          end;
        end;
      end;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtCARI_KOD.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qry_Cek.FieldByName('CARI_ADD').AsString := '';
  end;
  if (prv_CekTip = 1) and (rd_ASIL.ItemIndex = 1)  then
  begin
    qry_Cek.FieldByName('CEK_SAHIBI').AsString := txtCARI_AD.Text;
  end;
end;

procedure Tfrm_Cek.txtCARI_KODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txtCARI_KODButtonClick(Self);
end;

procedure Tfrm_Cek.txtPROJE_KODButtonClick(Sender: TObject);
var
  PROJE_KOD,PROJE_AD:String;
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Proje(PROJE_KOD,PROJE_AD,1) Then
  begin
    qry_Cek.FieldByName('PROJE_KOD').AsString := PROJE_KOD;
    qry_Cek.FieldByName('PROJE_AD').AsString := PROJE_AD;
  end;
end;

procedure Tfrm_Cek.txtPROJE_KODExit(Sender: TObject);
var
  PROJE_AD:String;
begin
  if Trim(txtPROJE_KOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',txtPROJE_KOD.Text,PROJE_AD) then
    begin
      qry_Cek.FieldByName('PROJE_AD').AsString := PROJE_AD;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtPROJE_KOD.SetFocus;
    end;
  end
  else
  begin
    qry_Cek.FieldByName('PROJE_AD').AsString := '';
    (Sender as TIB_Edit).Color := clWindow;
  end;
end;

procedure Tfrm_Cek.txtPROJE_KODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txtPROJE_KODButtonClick(self);
end;

procedure Tfrm_Cek.txtPLASIYER_KODExit(Sender: TObject);
var
  PLASIYER_AD:String;
begin
  if Trim(txtPLASIYER_KOD.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PLASIYER','PLASIYER_KOD','ADISOY',txtPLASIYER_KOD.Text,PLASIYER_AD) then
    begin
      qry_Cek.FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtPLASIYER_KOD.SetFocus;
    end;
  end
  else
  begin
    qry_Cek.FieldByName('PLASIYER_AD').AsString := '';
    (Sender as TIB_Edit).Color := clWindow;    
  end;  
end;

procedure Tfrm_Cek.txtPLASIYER_KODButtonClick(Sender: TObject);
var
  PLASIYER_KOD, PLASIYER_AD :String;
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Plasiyer(PLASIYER_KOD, PLASIYER_AD,1) then
  begin
    qry_Cek.FieldByName('PLASIYER_KOD').AsString := PLASIYER_KOD;
    qry_Cek.FieldByName('PLASIYER_AD').AsString := PLASIYER_AD;
  end;
end;

procedure Tfrm_Cek.txtPLASIYER_KODKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then txtPLASIYER_KODButtonClick(self);
end;

procedure Tfrm_Cek.dts_CekStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) Then
  begin
    btnYeni.Enabled:=False;
    if ADataset.State in [dssEdit] then btnSil.Enabled := True else btnSil.Enabled := False;
    btnSil.Enabled := False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    {if not ((ADataset.Eof) And (ADataset.Bof)) Then
      btnSil.Enabled := True
    else
       btnSil.Enabled := False;
    }
    if ADataset.FieldByName('CEK_ID').AsInteger<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure Tfrm_Cek.IB_Edit6ButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,0) Then
  begin
    qry_Cek.FieldByName('BANKA_KOD').AsString := Cari_KOD;
    qry_Cek.FieldByName('BANKA_AD').AsString := Cari_AD;
  end;
end;

procedure Tfrm_Cek.IB_Edit6Exit(Sender: TObject);
var
  BANKA_AD:String;
begin
  if Trim(IB_Edit6.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',IB_Edit6.Text,BANKA_AD) then
    begin
      qry_Cek.FieldByName('BANKA_AD').AsString := BANKA_AD;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      IB_Edit6.SetFocus;
      Exit;
    end;
  end
  else
  begin
    qry_Cek.FieldByName('BANKA_AD').AsString := '';
    (Sender as TIB_Edit).Color := clWindow;
    Exit;
  end;

  if DataMod.FN_KOD2AD('CARI','CARI_KOD','TIP',IB_Edit6.Text,BANKA_AD) then
  begin
    if BANKA_AD <> '3' then
    begin
      Application.MessageBox('Mutlaka bir banka seçmelisiniz.','Dikkat',MB_ICONWARNING);
      IB_Edit6.Text := '';
      qry_Cek.FieldByName('BANKA_AD').AsString := '';
      IB_Edit6.SetFocus;
      Exit;
    end;
    (Sender as TIB_Edit).Color := clWindow;
  end;
end;

procedure Tfrm_Cek.IB_Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_F4 then IB_Edit6ButtonClick(Self);
end;

function Tfrm_Cek.ON_MUH_ENT(SIL:Byte):Boolean;
var CARI_YON,PROJE_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    PROJE_SIL:Byte;
begin
  case prv_CekTip of
  1:begin //Müþteri çeki
     CARI_YON := ALACAK;
     PROJE_YON := ALACAK;
    end;
  2:begin //Borc çeki
     CARI_YON := BORC;
     PROJE_YON := BORC;
    end;
  end; //case end
  Result := True;
  if not DataMod.CARIHAR_AUD(trn_Cek,
                          prv_Belge_Turu,
                          qry_Cek.FieldbyName('CEK_ID').AsInteger,
                          qry_Cek.FieldbyName('CEK_SID').AsInteger,
                          1,
                          qry_Cek.FieldbyName('CARI_KOD').AsString,
                          CARI_YON,
                          qry_Cek.FieldbyName('ISLEMTAR').AsDate,
                          qry_Cek.FieldbyName('FIILI_TAR').AsDate,
                          qry_Cek.FieldbyName('DOV_BAZ_TAR').AsDate,
                          qry_Cek.FieldbyName('TUTAR').AsCurrency,
                          qry_Cek.FieldbyName('DOVKOD').AsString,
                          qry_Cek.FieldbyName('DOVKUR').AsCurrency,
                          qry_Cek.FieldbyName('TUTAR_VPB').AsCurrency,
                          qry_Cek.FieldbyName('VADETAR').AsDate,
                          qry_Cek.FieldbyName('ACIKLAMA').AsString,
                          SIL,
                          PRV_ISN,
                          qry_Cek.FieldbyName('MASRAF_MERK').AsString,
                          qry_Cek.FieldbyName('KOD1').AsString,
                          qry_Cek.FieldbyName('KOD2').AsString,
                          qry_Cek.FieldbyName('KOD3').AsString,
                          qry_Cek.FieldbyName('KOD4').AsString,
                          qry_Cek.FieldbyName('PLASIYER_KOD').AsString,
                          qry_Cek.FieldbyName('PROJE_KOD').AsString,
                          BELGE_ID,
                          BELGE_SID) then
  begin
    Result := False;
    Exit;
  end;

  if SIL = 0 then
    if Trim(qry_Cek.FieldByName('PROJE_KOD').AsString) = '' then PROJE_SIL:=1 Else PROJE_SIL:=0
  else
    PROJE_SIL:=1;

  if not DataMod.PROJEHAR_AUD(trn_Cek,
                           prv_Belge_Turu,
                           qry_Cek.FieldbyName('CEK_ID').AsInteger,
                           qry_Cek.FieldbyName('CEK_SID').AsInteger,
                           1,
                           qry_Cek.FieldbyName('PROJE_KOD').AsString,
                           qry_Cek.FieldbyName('ISLEMTAR').AsDate,
                           qry_Cek.FieldbyName('FIILI_TAR').AsDate,
                           qry_Cek.FieldbyName('DOV_BAZ_TAR').AsDate,
                           qry_Cek.FieldbyName('VADETAR').AsDate,
                           PROJE_YON,
                           qry_Cek.FieldbyName('DOVKOD').AsString,
                           qry_Cek.FieldbyName('DOVKUR').AsCurrency,
                           qry_Cek.FieldbyName('TUTAR').AsCurrency,
                           qry_Cek.FieldbyName('TUTAR_VPB').AsCurrency,
                           Proje_Sil,
                           qry_Cek.FieldbyName('ACIKLAMA').AsString,
                           PRV_ISN ,
                           qry_Cek.FieldbyName('MASRAF_MERK').AsString,
                           qry_Cek.FieldbyName('KOD1').AsString,
                           qry_Cek.FieldbyName('KOD2').AsString,
                           qry_Cek.FieldbyName('KOD3').AsString,
                           qry_Cek.FieldbyName('KOD4').AsString,
                           BELGE_ID,
                           BELGE_SID) then
  begin
    Result := False;
    Exit;
  end;

{   DataMod.SPP_CEKSENHAR_AUD(trn_Cek,
                             CEK,
                             qry_Cek.FieldbyName('CEK_ID').AsInteger,
                             qry_Cek.FieldbyName('CEK_SID').AsInteger,
                             qry_Cek.FieldbyName('ISLEMTAR').AsDate,
                             qry_Cek.FieldbyName('DOV_BAZ_TAR').AsDate,
                             0,
                             qry_Cek.FieldbyName('DOVKUR').AsCurrency,
                             qry_Cek.FieldbyName('TUTAR_VPB').AsCurrency,
                             0,
                             qry_Cek.FieldbyName('CARI_KOD').AsString,
                             qry_Cek.FieldbyName('PLASIYER_KOD').AsString,
                             qry_Cek.FieldbyName('PROJE_KOD').AsString,
                             qry_Cek.FieldbyName('ACIKLAMA').AsString,
                             qry_Cek.FieldbyName('ACIKLAMA').AsString,
                             0,
                             0,
                             '',
                             '',
                             0,
                             0,
                             254, //ÇEK SENEDÝ UPDATE ETMESÝN
                             1,
                             BELGE_ID,
                             BELGE_SID);
   if BELGE_ID=0 then
   begin
     Application.MessageBox('SP_CEKSENHAR_AUD da hata oluþtu','Dikkat',MB_ICONWARNING);
     Result := False;
     Exit;
   end;}
end;

procedure Tfrm_Cek.IB_Edit8Exit(Sender: TObject);
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

procedure Tfrm_Cek.IB_Edit10Exit(Sender: TObject);
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

procedure Tfrm_Cek.IB_Edit11Exit(Sender: TObject);
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

procedure Tfrm_Cek.IB_Edit12Exit(Sender: TObject);
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

procedure Tfrm_Cek.IB_Edit13Exit(Sender: TObject);
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

procedure Tfrm_Cek.IB_Edit10ButtonClick(Sender: TObject);
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qry_Cek.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;


procedure Tfrm_Cek.IB_Edit8ButtonClick(Sender: TObject);
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qry_Cek.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Cek.IB_Edit11ButtonClick(Sender: TObject);
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qry_Cek.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Cek.IB_Edit12ButtonClick(Sender: TObject);
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qry_Cek.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Cek.IB_Edit13ButtonClick(Sender: TObject);
begin
  if not (qry_Cek.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qry_Cek.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Cek.IB_Edit8KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure Tfrm_Cek.IB_Edit10KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure Tfrm_Cek.IB_Edit11KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure Tfrm_Cek.IB_Edit12KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure Tfrm_Cek.IB_Edit13KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;


function Tfrm_Cek.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if not DataMod.KAY_TAR_KONTROL(qry_Cek.FieldByName('ISLEMTAR').AsDate,True) then Exit;
  if not DataMod.KAY_TAR_KONTROL(qry_Cek.FieldByName('TANZIMTAR').AsDate,True) then Exit;
  if not DataMod.KAY_TAR_KONTROL(qry_Cek.FieldByName('FIILI_TAR').AsDate,True) then Exit;

  if Trim(txtCARI_KOD.Text) = '' then
  begin
    Application.MessageBox('Lütfen iþlem yapýlan cariyi belirtiniz..','Dikkat',MB_ICONWARNING);
    txtCARI_KODButtonClick(Self);
    Exit;
  end;
  if Trim(qry_Cek.FieldByName('ACIKLAMA').AsString) = '' then
  begin
    Application.MessageBox('Lütfen iþlem açýklamasý belirtiniz..','Dikkat',MB_ICONWARNING);
    IB_Edit7.SetFocus;
    Exit;
  end;
  if qry_Cek.FieldByName('TUTAR').AsCurrency = 0 then
  begin
    Application.MessageBox('Tutar bilgisi girilmemiþ','Dikkat',MB_ICONWARNING);
    edt_Tutar.SetFocus;
    Exit;
  end;
  if (qry_Cek.FieldByName('TIP').AsInteger = 2) and (Trim(qry_Cek.FieldByName('BANKA_KOD').AsString) = '') then
  begin
    Application.MessageBox('Borç Çeklerinde Mutlaka bir Banka belirtmelisiniz !','Dikkat',MB_ICONWARNING);
    IB_Edit6.SetFocus;
    exit;
  end;
  if Trim(qry_Cek.FieldByName('CEK_NUM').AsString) = '' then
  begin
    Application.MessageBox('Mutlaka bir çek numarasý belirtmelisiniz !','Dikkat',MB_ICONWARNING);
    IB_Edit3.SetFocus;
    exit;
  end;
  if (qry_Cek.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONWARNING);
    edt_Dovkur.SetFocus;
    exit;
  end;
  if (qry_Cek.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONWARNING);
    edt_tutar.SetFocus;
    exit;
  end;
  if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = -1 then
  begin
    if not DataMod.EN_GER_KAY_TAR_KONTROL(qry_Cek.FieldByName('ISLEMTAR').AsDate,True) then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('ISLEMTAR').AsDate, 'Ýþlem Tarihi') then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('TANZIMTAR').AsDate, 'Tanzim Tarihi') then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('FIILI_TAR').AsDate, 'Fiili Tarihi') then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('VADETAR').AsDate, 'Vade Tarihi') then Exit;
  end
  else
  begin
    if not DataMod.EN_GER_KAY_TAR_KONTROL(qry_Cek.FieldByName('ISLEMTAR').AsDate,True) then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('ISLEMTAR').AsDate, 'Ýþlem Tarihi') then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('TANZIMTAR').AsDate, 'Tanzim Tarihi') then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('FIILI_TAR').AsDate, 'Fiili Tarihi') then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
    if not DataMod.IsDateInTerm(qry_Cek.FieldByName('VADETAR').AsDate, 'Vade Tarihi') then Exit;
  end;
  Result := True;
end;

procedure Tfrm_Cek.Form_Post;
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trn_Cek.InTransaction then
    trn_Cek.RollbackRetaining;
//****************************************************************************//
    trn_Cek.StartTransaction;
//****************************************************************************//
    prnCEKID := qry_Cek.FieldByName('CEK_ID').AsInteger;
    prnCEKSID := qry_Cek.FieldByName('CEK_SID').AsInteger;
//****************************************************************************//
    if not dmCEKSENHAR.CEKSEN_AUD(trn_Cek,CEK,qry_Cek,0) then
    begin
      trn_Cek.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Application.MessageBox('Hareket Kayýtlarý yaratýlýrken hata oluþtu, Lütfen girdiðiniz deðerleri kontrol ediniz ','Dikkat',MB_ICONHAND);
      Exit;
    end;
//****************************************************************************//
    with qry_Cek do
    begin
      Post;
      ApplyUpdates;
      CommitUpdates;
    end;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEK,CEKSENHAR,',
                                             prv_Belge_Turu,
                                             prnCEKID,
                                             prnCEKSID,
                                             1,1,'');
//****************************************************************************//
    trn_Cek.Commit;
    if rgYAZICI.Visible = True then
    begin
      case prv_CekTip of
      1:if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(61)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,61,6,1,rgYAZICI.ItemIndex,prnCEKID,prnCEKSID,0,'');
  end
  else

      Yazici.MUSTERICEKI(prnCEKID,prnCEKSID,rgYAZICI.ItemIndex);
      2:if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(41)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,41,4,1,rgYAZICI.ItemIndex,prnCEKID,prnCEKSID,0,'');
  end
  else

      Yazici.BORCCEKI(prnCEKID,prnCEKSID,rgYAZICI.ItemIndex);
      end;
    end;
    prnCEKID := 0;
    prnCEKSID := 0;
  except
    trn_Cek.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  qry_Cek.Close;
end;

function Tfrm_Cek.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qry_Cek.FieldByName('ISLEMTAR').AsDate,True) then Exit;
  Result := True;
end;

procedure Tfrm_Cek.Form_Delete;
var
  CEK_ID,CEK_SID:Integer;
begin
  if not Form_Before_Delete then exit;
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz?','Dikkat',MB_YESNO) = IDNO then Exit;
  qry_Cek.Cancel;//edit konumunda girmiþ olacaðý için
  try
//****************************************************************************//
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
    if trn_Cek.InTransaction then
    trn_Cek.RollbackRetaining;
//****************************************************************************//
    trn_Cek.StartTransaction;
//****************************************************************************//

    if not ON_MUH_ENT(1) then
    begin
      trn_Cek.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;


//****************************************************************************//
    CEK_ID  := qry_Cek.FieldbyName('CEK_ID').AsInteger;
    CEK_SID := qry_Cek.FieldbyName('CEK_SID').AsInteger;
//****************************************************************************//
    with qry_Cek do
    begin
      Delete;
      ApplyUpdates;
      CommitUpdates;
    end;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('CEK,CEKSENHAR,',
                                             prv_Belge_Turu,
                                             CEK_ID,
                                             CEK_SID,
                                             1,2,'');
//****************************************************************************//
    trn_Cek.Commit;
  except;
    Application.MessageBox('ÇEK silinirken bir hata oluþtu.','Dikkat',MB_ICONERROR);
    trn_Cek.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
end;

procedure Tfrm_Cek.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure Tfrm_Cek.IB_Edit3Exit(Sender: TObject);
begin
  if Trim(qry_Cek.FieldByName('CEK_NUM').AsString)='' then
  begin
    (Sender as TIB_Edit).Color := clWindow;
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
  if Trim(qry_Cek.FieldByName('ACIKLAMA').AsString)='' then
  begin
    if Trim(qry_Cek.FieldByName('CARI_KOD').AsString)<>'' then
    begin
      case prv_CekTip of
      1:qry_Cek.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' dan '+ qry_Cek.FieldByName('CEK_NUM').AsString+' nolu çek alýmý.';
      2:qry_Cek.FieldByName('ACIKLAMA').AsString := txtCARI_KOD.Text + ' a '+ qry_Cek.FieldByName('CEK_NUM').AsString+' nolu çek verimi.';
      end;
    end;
  end;
  (Sender as TIB_Edit).Color := clWindow;
end;

procedure Tfrm_Cek.btnCiktiClick(Sender: TObject);
begin
  if prnCEKID<=0 then Exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.Visible = True then
  begin
    case prv_CekTip of
    1:if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(61)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,61,6,1,rgYAZICI.ItemIndex,prnCEKID,prnCEKSID,0,'');
  end
  else

    Yazici.MUSTERICEKI(prnCEKID,prnCEKSID,rgYAZICI.ItemIndex);
    2:if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(41)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,41,4,1,rgYAZICI.ItemIndex,prnCEKID,prnCEKSID,0,'');
  end
  else

    Yazici.BORCCEKI(prnCEKID,prnCEKSID,rgYAZICI.ItemIndex);
    end;
  end;
end;

procedure Tfrm_Cek.IB_Date1Enter(Sender: TObject);
begin
  (Sender as TIB_Date).Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Cek.IB_Date1Exit(Sender: TObject);
begin
  (Sender as TIB_Date).Color := clWindow;
end;

procedure Tfrm_Cek.txtCARI_ADEnter(Sender: TObject);
begin
  (Sender as TIB_Edit).Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Cek.txtCARI_ADExit(Sender: TObject);
begin
  (Sender as TIB_Edit).Color := clWindow;
end;

procedure Tfrm_Cek.edt_DovkurEnter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Cek.rd_ASILEnter(Sender: TObject);
begin
  (Sender as TIB_RadioGroup).Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Cek.rd_ASILExit(Sender: TObject);
begin
  (Sender as TIB_RadioGroup).Color := clBtnFace;
end;

procedure Tfrm_Cek.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frm_Cek);
end;

procedure Tfrm_Cek.edt_tutarExit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure Tfrm_Cek.cboDOVKODEnter(Sender: TObject);
begin
  (Sender as TIB_ComboBox).Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Cek.cboDOVKODExit(Sender: TObject);
begin
  (Sender as TIB_ComboBox).Color := clWindow;
end;

procedure Tfrm_Cek.rgYAZICIEnter(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Cek.rgYAZICIExit(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := clBtnFace;
end;

end.
