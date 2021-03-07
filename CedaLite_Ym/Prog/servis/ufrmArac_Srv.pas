unit ufrmArac_Srv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, Mask, IB_Controls, IB_UpdateBar, ExtCtrls,
  IB_NavigationBar, Buttons,Variants, IB_Grid, ComCtrls, ExtDlgs;

type
  TfrmArac_Srv = class(TForm)
    qryArac: TIB_Query;
    dtsArac: TIB_DataSource;
    pgArac: TPageControl;
    TabAracKarti: TTabSheet;
    TabRuhsat: TTabSheet;
    IB_Edit1: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Currency1: TIB_Currency;
    IB_Currency3: TIB_Currency;
    IB_Date1: TIB_Date;
    IB_Date2: TIB_Date;
    txtCariKod: TIB_Edit;
    IB_CheckBox2: TIB_CheckBox;
    Panel1: TPanel;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    IB_Text1: TIB_Text;
    ScrollBox1: TScrollBox;
    IB_CheckBox3: TIB_CheckBox;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Date4: TIB_Date;
    IB_Edit13: TIB_Edit;
    IB_Edit14: TIB_Edit;
    IB_Edit15: TIB_Edit;
    IB_Edit16: TIB_Edit;
    IB_Edit17: TIB_Edit;
    IB_Edit18: TIB_Edit;
    IB_Edit19: TIB_Edit;
    IB_Edit20: TIB_Edit;
    IB_Edit21: TIB_Edit;
    IB_Memo2: TIB_Memo;
    IB_Currency2: TIB_Currency;
    IB_Currency4: TIB_Currency;
    IB_Currency6: TIB_Currency;
    IB_Currency7: TIB_Currency;
    IB_CheckBox4: TIB_CheckBox;
    IB_RadioGroup1: TIB_RadioGroup;
    IB_RadioGroup2: TIB_RadioGroup;
    IB_CheckBox5: TIB_CheckBox;
    IB_CheckBox6: TIB_CheckBox;
    IB_CheckBox7: TIB_CheckBox;
    IB_CheckBox8: TIB_CheckBox;
    IB_Currency8: TIB_Currency;
    IB_Currency9: TIB_Currency;
    IB_Currency10: TIB_Currency;
    IB_Date5: TIB_Date;
    IB_Edit22: TIB_Edit;
    IB_Edit23: TIB_Edit;
    GroupBox2: TGroupBox;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox3: TGroupBox;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Date3: TIB_Date;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Date6: TIB_Date;
    IB_Edit2: TIB_Edit;
    Label1: TLabel;
    Image1: TImage;
    txt_Marka: TIB_Edit;
    txtMarka_Tip: TIB_Edit;
    txtSigorta: TIB_Edit;
    txtBayi: TIB_Edit;
    IB_Text2: TIB_Text;
    IB_Text3: TIB_Text;
    OpenPictureDialog1: TOpenPictureDialog;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;Arac_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(Arac_KOD:String;ISLEM_TIP:Byte);
    function AracNo(Arac_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryAracAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qryAracBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure qryAracBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dtsAracStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure txtCariKodButtonClick(Sender: TObject);
    procedure txtCariKodEnter(Sender: TObject);
    procedure txtCariKodExit(Sender: TObject);
    procedure txtCariKodKeyPress(Sender: TObject; var Key: Char);
    procedure txtCariKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtPersonelKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure pgAracChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pgAracChange(Sender: TObject);
    procedure IB_Memo2Enter(Sender: TObject);
    procedure IB_Memo2Exit(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure IB_Image1DblClick(Sender: TObject);
    procedure qryAracAfterScroll(IB_Dataset: TIB_Dataset);
    procedure txt_MarkaButtonClick(Sender: TObject);
    procedure txtMarka_TipButtonClick(Sender: TObject);
    procedure txt_MarkaEnter(Sender: TObject);
    procedure txtMarka_TipEnter(Sender: TObject);
    procedure txt_MarkaExit(Sender: TObject);
    procedure txtMarka_TipExit(Sender: TObject);
    procedure txt_MarkaKeyPress(Sender: TObject; var Key: Char);
    procedure txt_MarkaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtMarka_TipKeyPress(Sender: TObject; var Key: Char);
    procedure txtMarka_TipKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtSigortaButtonClick(Sender: TObject);
    procedure txtSigortaEnter(Sender: TObject);
    procedure txtSigortaExit(Sender: TObject);
    procedure txtSigortaKeyPress(Sender: TObject; var Key: Char);
    procedure txtSigortaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtBayiButtonClick(Sender: TObject);
    procedure txtBayiEnter(Sender: TObject);
    procedure txtBayiExit(Sender: TObject);
    procedure txtBayiKeyPress(Sender: TObject; var Key: Char);
    procedure txtBayiKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    function Form_RBefore_Delete: Boolean;
    function Arac_Ayni_Kontrol: Boolean;
    procedure Geri_AL;

  public
    { Public declarations }
  end;

  const cns_Arac = 64;

var
  frmArac_Srv: TfrmArac_Srv;

implementation

uses unDataMod, main, unFunc, unLogger, ufrmCariSDLG,// ufrmGRABBER_WINDOW,
  ufrmResimTamEkran,Jpeg;

{$R *.DFM}

procedure TfrmArac_Srv.Form_Open(Menu:Boolean;Arac_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Arac,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni Araç tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
  if not MainForm.FindChildFrm(Application,'frmArac_Srv') then
  begin
    Application.CreateForm(TfrmArac_Srv, frmArac_Srv);
    with frmArac_Srv do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      frmArac_Srv.pgArac.ActivePage:=TabAracKarti;
      DataSet_Open(Arac_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Araç formu açýk.','Dikkat',MB_ICONINFORMATION);
    Exit;
  end;
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmArac_Srv.DataSet_Open(Arac_KOD:String;ISLEM_TIP:Byte);
begin
  Image1.Picture.Graphic:=Nil;
  with qryArac do
  begin
    Active := False;
    ParamByName('PRM_ARAC_KOD').AsString := ARAC_KOD;
    Active := True;
    IB_Edit1.SetFocus;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qryArac.Edit;
    end;
  1://insert
    begin
      qryArac.Insert;
    end;
  end;
end;

procedure TfrmArac_Srv.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmArac_Srv.qryAracAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryArac do
  begin
    FieldByName('ARAC_SID').AsInteger := glb_SID;
    FieldByName('ARAC_KOD').AsString := AracNo(Int64(DataMod.GET_SAYAC_NUM('SRV_ARAC',True,False,0)));
    //FieldByName('YAKIT_LITRE').AsCurrency := 0;
    //FieldByName('BORC').AsCurrency := 0;
    //FieldByName('ALACAK').AsCurrency := 0;
    FieldByName('AKTIF_DEGIL').AsInteger := 0;
    FieldByName('KASKO_SIG_GEC_TAR').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('TRF_SIG_GEC_TAR').AsDATE:= DataMod.GET_SERVER_DATE;
    //FieldByName('DORSE_KOD').AsString :='';

    FieldByName('AS_MUYANE_GECERLILIK_SUR').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('AS_DOGUM_TARIHI').AsDATE:= DataMod.GET_SERVER_DATE;
    FieldByName('DEVREDEN_BORC').AsFloat:= 0;
    FieldByName('DEVREDEN_ALACAK').AsFloat:= 0;
    //FieldByName('KARA_LISTE').AsInteger:= 0;



    FieldByName('SILINDIR_HACMI').AsFloat:=0;
    FieldByName('ISTIAP_HADDI').AsFloat:=0;
    FieldByName('MOTOR_GUCU').AsFloat:=0;
    FieldByName('KISI').AsFloat:=0;
    FieldByName('NET_AGIRLIK').AsFloat:=0;
    FieldByName('KATAR_AGIRLIGI').AsFloat:=0;
    FieldByName('ROMORK_ISTIAPHAD').AsFloat:=0;

    FieldByName('IMALATCI_YERLI').AsInteger:=0;
    FieldByName('ARAZI').AsInteger:=0;
    FieldByName('YUK_TASIMA').AsInteger:=0;
    FieldByName('ROMORK_TAKMA').AsInteger:=0;
    FieldByName('TAKSIMETRE').AsInteger:=0;
    FieldByName('TAKOMETRE').AsInteger:=0;

    FieldByName('KULLANIM_TIPI').AsInteger:=1;
    FieldByName('YAKIT_TIPI').AsInteger:=1;

    FieldByName('SON_ONARIM_KM').AsInteger:=0;


    FieldByName('TESCIL_TARIHI').AsDATE:= DataMod.GET_SERVER_DATE;
    {
    FieldByName('MUYANE_GECERLILIK_SUR').AsDATE:=
    qryArac.FieldByName('AS_MUYANE_GECERLILIK_SUR').AsDATE;
    //IB_Edit11.SetFocus;
    }
  end;
  IB_Edit1.SetFocus;
end;

function TfrmArac_Srv.AracNo(Arac_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(Arac_SAYAC,TRIM(DataMod.GetParam(cns_Arac ,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Arac,'KOD_LENGTH',0)));
end;

procedure TfrmArac_Srv.qryAracBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not DataMod.Post_Update('SRV_ARAC',qryArac.FieldByName('ARAC_KOD').OldAsString,qryArac.FieldByName('ARAC_KOD').AsString,Nil) then Abort;
end;

procedure TfrmArac_Srv.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryArac.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qryArac.Active := False;
  end;
end;

procedure TfrmArac_Srv.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmArac_Srv.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmArac_Srv.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmArac_Srv.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmArac_Srv.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmArac_Srv);
  with frmArac_Srv.qryArac do
  begin
    FieldByName('BORC').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('ALACAK').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmArac_Srv.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmArac_Srv.qryAracBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('SRV_ARAC',qryArac.FieldByName('ARAC_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmArac_Srv.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmArac_Srv.btnAraClick(Sender: TObject);
var
 Arac_AD:String;
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 SASI_NO:String;
 MARKA_TIP:String;
begin
  if DataMod.LS_Arac_Srv(ARAC_KOD,PLAKA,CARI_KOD,SASI_NO,MARKA_TIP,'') then
  DataSet_Open(Arac_KOD,0);
end;

procedure TfrmArac_Srv.dtsAracStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
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

procedure TfrmArac_Srv.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni Araç tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmArac_Srv.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if not Arac_Ayni_Kontrol then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryArac.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC,',0,0,0,0,1,'SRV_ARAC');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;


function TfrmArac_Srv.Arac_Ayni_Kontrol:Boolean;
var
   qry_Temp:TIb_Query;
begin
     Result:=True;
     DataMod.CreateQuery(qry_Temp,nil,False,DataMod.dbaMain);

     qry_Temp.Active:=False;
     qry_Temp.sql.Clear;
     qry_Temp.sql.Text:='Select Count(*) Gelen from SRV_ARAC Where PLAKA=:PLAKA and CARI_KOD=:CARI_KOD';
     qry_Temp.ParamByName('PLAKA').AsString:=qryArac.FieldByName('PLAKA').AsString;
     qry_Temp.ParamByName('CARI_KOD').AsString:=qryArac.FieldByName('CARI_KOD').AsString;
     qry_Temp.Active:=True;

     if qryArac.State=DssInsert then
     if qry_Temp.FieldByName('GELEN').AsInteger>0 then
     begin
          Application.MessageBox('Bu plaka tanýmlýdýr','Dikkat',MB_ICONWARNING);
          Result:=False;
     end;

     if qryArac.State=DssEdit then
     if (qryArac.FieldByName('PLAKA').AsString<>qryArac.FieldByName('PLAKA').OldAsString)
     or (qryArac.FieldByName('CARI_KOD').AsString<>qryArac.FieldByName('CARI_KOD').OldAsString) then
     if qry_Temp.FieldByName('GELEN').AsInteger>=1 then
     begin
          Application.MessageBox('Bu plaka tanýmlýdýr','Dikkat',MB_ICONWARNING);
          Result:=False;
     end;
end;

procedure TfrmArac_Srv.btnIPTALClick(Sender: TObject);
begin
  qryArac.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmArac_Srv.btnSilClick(Sender: TObject);
var
   Dosya:String;
begin
  try
      Dosya:='';
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      Dosya:= qryArac.FieldByName('RESIM').AsString;
      qryArac.Delete;
      if Dosya<>'' then
      {if not DataMod.Resim_Bul(Dosya,'ARC') then
      begin }
          DeleteFile(Dosya);
      //end;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC,',0,0,0,0,2,'SRV_ARAC');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
  Image1.Picture.Graphic:=Nil;
end;

procedure TfrmArac_Srv.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case pgArac.ActivePageIndex of
  0: begin
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
    VK_ESCAPE: if btnCikis.Enabled then Close;
    end;//acase end
  end; ///if Shift = [] then ENd
  end;

  end;

end;

function TfrmArac_Srv.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  Result := True;
end;

function TfrmArac_Srv.Form_RBefore_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then
  Exit;
  Result := True;
end;


function TfrmArac_Srv.Form_Before_Post: Boolean;
var
  FuncDeger:String;
begin
  Result := False;
  FuncDeger:=DataMod.Before_Post_Kontrol(qryArac,'SRV_ARAC','ARAC_KOD,PLAKA,CARI_KOD','ARAC_KOD');
  if  funcDeger<> '' Then
  begin
    ShowMessage(funcDeger);
    Exit;
  end;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if (qryArac.FieldByName('ARAC_MARKA_TIP').AsString<>'') or
  (qryArac.FieldByName('ARAC_MARKA').AsString<>'') then
  begin
   with DataMod.qryGENEL do
   begin
     Active := False;
     SQL.Clear;
     SQL.Add('SELECT * FROM SRV_ARAC_MARKA_TIP WHERE MARKA_TIP_KOD=' + SQL_Katar(qryArac.FieldByName('ARAC_MARKA_TIP').AsString)
           + ' AND MARKA_KOD=' + SQL_Katar(qryArac.FieldByName('ARAC_MARKA').AsString));
     Active := True;
   end;
   if (DataMod.qryGENEL.Bof) and (DataMod.qryGENEL.Eof) then
   begin
       Application.MessageBox('Araç Marka ve Tipini Seçiniz','Dikkat',MB_ICONWARNING);
       exit;
   end;
  end;

  Result := True;
end;

procedure TfrmArac_Srv.txtCariKodButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qryArac.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qryArac.FieldByName('CARI_KOD').AsString := Cari_KOD;
      qryArac.FieldByName('CARI_ADI').AsString := Cari_AD;
  end;
end;

procedure TfrmArac_Srv.txtCariKodEnter(Sender: TObject);
begin
  txtCariKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmArac_Srv.txtCariKodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCarikod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCarikod.Text,CARI_AD) then
    begin
      qryArac.FieldByName('CARI_ADI').AsString := CARI_AD;
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
    qryArac.FieldByName('CARI_ADI').AsString := '';
  end;
end;

procedure TfrmArac_Srv.txtCariKodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmArac_Srv.txtCariKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then txtCarikodButtonClick(Self);
end;

procedure TfrmArac_Srv.txtPersonelKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmArac_Srv.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmArac_Srv.pgAracChanging(Sender: TObject; var AllowChange: Boolean);
begin
    if pgArac.ActivePage = TabAracKarti then
    if qryArac.State in [dssEdit,dssInsert] Then
    if not Form_Before_Post then
    begin
      //Application.MessageBox('Araç bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end;
end;

procedure TfrmArac_Srv.pgAracChange(Sender: TObject);
begin
    if pgArac.ActivePage = TabRuhsat then
    begin


      IB_Edit11.SetFocus;
    end;
end;

procedure TfrmArac_Srv.IB_Memo2Enter(Sender: TObject);
begin
  (Sender as TIB_Memo).Color := glb_Art_Alan_Renk;
end;

procedure TfrmArac_Srv.IB_Memo2Exit(Sender: TObject);
begin
   (Sender as TIB_Memo).Color := clWindow;
end;

procedure TfrmArac_Srv.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 ARAC_KOD FROM SRV_ARAC WHERE ARAC_KOD<:ARAC_KOD ORDER BY ARAC_KOD DESC';
     qryDeg1.ParamByName('ARAC_KOD').AsString:=qryArac.FieldByName('ARAC_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ARAC_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('ARAC_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,0);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;


procedure TfrmArac_Srv.Geri_AL;
begin
     if qryArac.State in [DssEdit,DssInsert] then
     qryArac.Cancel;
     //qryArac.Close;
end;


procedure TfrmArac_Srv.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 ARAC_KOD FROM SRV_ARAC WHERE ARAC_KOD>:ARAC_KOD ORDER BY ARAC_KOD';
     qryDeg1.ParamByName('ARAC_KOD').AsString:=qryArac.FieldByName('ARAC_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ARAC_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('ARAC_KOD').AsString;
          Geri_AL;
          DataSet_Open(Id,0);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmArac_Srv.Button1Click(Sender: TObject);
var
   Dosya_Adi:String;
begin
  if OpenPictureDialog1.Execute<>False then
  begin
     //  qryArac.FieldByName('RESIM').AsString:=OpenPictureDialog1.FileName;
     //  qryAracAfterScroll(qryArac);
     Dosya_Adi:=glb_IMAGE_DIR+'\'+ 'Arc'+ExtractFileName(OpenPictureDialog1.FileName);
     FileCopy(OpenPictureDialog1.FileName,Dosya_Adi);
     qryArac.FieldByName('RESIM').AsString:=Dosya_Adi;
     qryAracAfterScroll(qryArac);
  end;
  //qryArac.FieldByName('RESIM').LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TfrmArac_Srv.Button2Click(Sender: TObject);
begin
  {if not DataMod.Resim_Bul(qryArac.FieldByName('RESIM').AsString,'ARC') then
  begin }
  MoveFile(Pchar(qryArac.FieldByName('RESIM').AsString),Pchar(glb_IMAGE_DIR+'\Silinen\'+ExtractFilename(qryArac.FieldByName('RESIM').AsString)));
  DeleteFile(qryArac.FieldByName('RESIM').AsString);
  //end;
  qryArac.FieldByName('RESIM').AsString :='';
  Image1.Picture.Graphic:=Nil;
end;

procedure TfrmArac_Srv.Button3Click(Sender: TObject);
begin
{  Application.CreateForm(TfrmGRABBER_WINDOW, frmGRABBER_WINDOW);
  frmGRABBER_WINDOW.Kaynak:='Arac';
  frmGRABBER_WINDOW.ShowModal;
  frmGRABBER_WINDOW.Release;}
end;

procedure TfrmArac_Srv.IB_Image1DblClick(Sender: TObject);
begin
  Application.CreateForm(TfrmResimTamEkran, frmResimTamEkran);
  frmResimTamEkran.Image1.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  frmResimTamEkran.ShowModal;
  frmResimTamEkran.Release;
end;

procedure TfrmArac_Srv.qryAracAfterScroll(IB_Dataset: TIB_Dataset);
begin
   if not qryArac.FieldByName('RESIM').IsNull then
   begin
      //     qryArac.FieldByName('RESIM').SaveToFile(glb_WINDOWS_DIR+'\Tempx.jpg');
      //     Image1.Picture.LoadFromFile(glb_WINDOWS_DIR+'\tempx.jpg');
      try
      Image1.Picture.LoadFromFile(qryArac.FieldByName('RESIM').AsString);
      except
          Application.MessageBox(Pchar(qryArac.FieldByName('RESIM').AsString +' adlý dosya bulunamadý Resmi Sil butonu ile ya boþaltýn yada Yeni Resim Seçiniz'),'Dikkat',MB_ICONWARNING);
      end;

   end;
end;

procedure TfrmArac_Srv.txt_MarkaButtonClick(Sender: TObject);
var
  Marka_Kod:String;
begin
   if not (qryArac.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MARKA(Marka_Kod) then
  begin
    qryArac.FieldByName('ARAC_MARKA').AsString := Marka_Kod;
  end;
end;

procedure TfrmArac_Srv.txtMarka_TipButtonClick(Sender: TObject);
var
  Marka_Tip:String;
begin
   if not (qryArac.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MARKA_TIP(qryArac.FieldByName('ARAC_MARKA').AsString,Marka_Tip) then
  begin
    qryArac.FieldByName('ARAC_MARKA_TIP').AsString := Marka_Tip;
  end;

end;

procedure TfrmArac_Srv.txt_MarkaEnter(Sender: TObject);
begin
  txt_Marka.Color := glb_Art_Alan_Renk;
end;

procedure TfrmArac_Srv.txtMarka_TipEnter(Sender: TObject);
begin
  txtMarka_Tip.Color := glb_Art_Alan_Renk;
end;

procedure TfrmArac_Srv.txt_MarkaExit(Sender: TObject);
var
  MARKA:String;
begin
  if Trim(txt_Marka.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('SRV_ARAC_MARKA','MARKA_KOD','MARKA_KOD',txt_Marka.Text,MARKA) then
    begin
      qryArac.FieldByName('ARAC_MARKA').AsString := MARKA;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txt_Marka.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qryArac.FieldByName('ARAC_MARKA').AsString := '';
  end;
end;

procedure TfrmArac_Srv.txtMarka_TipExit(Sender: TObject);
var
  MARKA_TIP:String;
begin
  if Trim(txtMarka_Tip.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD(' and MARKA_KOD='+Sql_Katar(txt_Marka.Text),'SRV_ARAC_MARKA_TIP','MARKA_TIP_KOD','MARKA_TIP_KOD',txtMarka_Tip.Text,MARKA_TIP) then
    begin
      qryArac.FieldByName('ARAC_MARKA_TIP').AsString := MARKA_TIP;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txt_Marka.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qryArac.FieldByName('ARAC_MARKA_TIP').AsString := '';
  end;
end;

procedure TfrmArac_Srv.txt_MarkaKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmArac_Srv.txt_MarkaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then txt_MarkaButtonClick(Self);
end;

procedure TfrmArac_Srv.txtMarka_TipKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmArac_Srv.txtMarka_TipKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then txtMarka_TipButtonClick(Self);
end;

procedure TfrmArac_Srv.txtSigortaButtonClick(Sender: TObject);
var
  Sigorta_Kod,SIGORTA_AD:String;
begin
  if not (qryArac.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Sigorta(Sigorta_Kod,SIGORTA_AD) then
  begin
    qryArac.FieldByName('SIGORTA_ADI').AsString := SIGORTA_AD;
    qryArac.FieldByName('SIGORTA_KOD').AsString := Sigorta_Kod;
  end;
end;

procedure TfrmArac_Srv.txtSigortaEnter(Sender: TObject);
begin
  txtSigorta.Color := glb_Art_Alan_Renk;
end;

procedure TfrmArac_Srv.txtSigortaExit(Sender: TObject);
var
  Sigorta_Kod,SIGORTA_AD:String;
begin
  if Trim(txtSigorta.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('SRV_ARAC_SIGORTA','SIGORTA_KOD','ADI',txtSigorta.Text,SIGORTA_AD) then
    begin
      qryArac.FieldByName('SIGORTA_ADI').AsString := SIGORTA_AD;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtSigorta.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qryArac.FieldByName('SIGORTA_ADI').AsString := '';
  end;
end;

procedure TfrmArac_Srv.txtSigortaKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmArac_Srv.txtSigortaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then txtSigortaButtonClick(Self);
end;

procedure TfrmArac_Srv.txtBayiButtonClick(Sender: TObject);
var
  Bayi_Kod,BAYI_ADI:String;
begin
   if not (qryArac.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_Bayi(Bayi_Kod,BAYI_ADI) then
  begin
    qryArac.FieldByName('BAYI_ADI').AsString := BAYI_ADI;
    qryArac.FieldByName('BAYI_KOD').AsString := Bayi_Kod;
  end;
end;

procedure TfrmArac_Srv.txtBayiEnter(Sender: TObject);
begin
  txtBayi.Color := glb_Art_Alan_Renk;
end;

procedure TfrmArac_Srv.txtBayiExit(Sender: TObject);
var
  Bayi_Kod,BAYI_ADI:String;
begin
  if Trim(txtBayi.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('SRV_ARAC_BAYI','BAYI_KOD','BAYI_ADI',txtBayi.Text,BAYI_ADI) then
    begin
      qryArac.FieldByName('BAYI_ADI').AsString := BAYI_ADI;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtBayi.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qryArac.FieldByName('BAYI_ADI').AsString := '';
  end;
end;

procedure TfrmArac_Srv.txtBayiKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmArac_Srv.txtBayiKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then txtBayiButtonClick(Self);
end;

end.
