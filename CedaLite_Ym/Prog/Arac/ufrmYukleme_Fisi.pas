unit ufrmYukleme_Fisi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IB_Components, Buttons, StdCtrls, Mask, IB_Controls,Variants,
  ExtDlgs;

type
  TfrmYukleme_Fisi = class(TForm)
    Panel1: TPanel;

    qry_Komisyon: TIB_Query;
    dts_Komisyon: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit10: TIB_Edit;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Edit14: TIB_Edit;
    IB_Edit15: TIB_Edit;
    IB_Memo1: TIB_Memo;
    IB_Date1: TIB_Date;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_CheckBox1: TIB_CheckBox;
    grpRapKod: TGroupBox;
    IB_Edit16: TIB_Edit;
    IB_Edit17: TIB_Edit;
    IB_Edit18: TIB_Edit;
    IB_Edit19: TIB_Edit;
    IB_Edit20: TIB_Edit;
    IB_Edit27: TIB_Edit;
    IB_Edit21: TIB_Edit;
    IB_Currency3: TIB_Currency;
    txtCari_Kod: TIB_Edit;
    txt_Sevk_Adres: TIB_Edit;
    IB_Edit23: TIB_Edit;
    IB_Edit24: TIB_Edit;
    rgYAZICI: TRadioGroup;
    btnCikti: TButton;
    IB_Edit25: TIB_Edit;
    IB_Edit26: TIB_Edit;
    IB_Edit28: TIB_Edit;
    IB_Edit29: TIB_Edit;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    IB_Text1: TIB_Text;
    txtKASA_KOD: TIB_Edit;
    IB_Text2: TIB_Text;
    txtArac_Kod: TIB_Edit;
    IB_Text3: TIB_Text;
    Button1: TButton;
    Button2: TButton;
    txtSofor_Kod: TIB_Edit;
    IB_Text4: TIB_Text;
    OpenPictureDialog1: TOpenPictureDialog;
    IB_Edit22: TIB_Edit;
    IB_Edit30: TIB_Edit;
    IB_Edit31: TIB_Edit;
    trnFAT_IRS: TIB_Transaction;
    Button3: TButton;
    Image1: TImage;
    IB_Edit32: TIB_Edit;
    IB_Edit33: TIB_Edit;
    btn_Arac_ara: TButton;
    btn_Fir_ara: TButton;
    btn_Sof_ara: TButton;
    btnCari_Ekle: TButton;
    btn_Arac_Ekle: TButton;
    btn_Sofer_Ekle: TButton;
    IB_Edit34: TIB_Edit;
    IB_CheckBox2: TIB_CheckBox;
    IB_CheckBox3: TIB_CheckBox;
    IB_Currency4: TIB_Currency;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qry_KomisyonAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qry_KomisyonBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dts_KomisyonStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qry_KomisyonBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;Id:Integer;ISLEM_TIP:Byte);
    procedure DataSet_Open(Id:Integer;ISLEM_TIP:Byte);
    function KomisyonNo(KOMISYON_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure IB_Edit16ButtonClick(Sender: TObject);
    procedure IB_Edit16Exit(Sender: TObject);
    procedure IB_Edit17ButtonClick(Sender: TObject);
    procedure IB_Edit17Exit(Sender: TObject);
    procedure IB_Edit18ButtonClick(Sender: TObject);
    procedure IB_Edit18Exit(Sender: TObject);
    procedure IB_Edit19ButtonClick(Sender: TObject);
    procedure IB_Edit19Exit(Sender: TObject);
    procedure IB_Edit20ButtonClick(Sender: TObject);
    procedure IB_Edit20Exit(Sender: TObject);
    procedure IB_Edit16Enter(Sender: TObject);
    procedure IB_Edit16KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit16KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit27ButtonClick(Sender: TObject);
    procedure IB_Edit27Enter(Sender: TObject);
    procedure IB_Edit27Exit(Sender: TObject);
    procedure IB_Edit27KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit27KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit21ButtonClick(Sender: TObject);
    procedure txtCari_KodButtonClick(Sender: TObject);
    procedure txtCari_KodEnter(Sender: TObject);
    procedure txtCari_KodExit(Sender: TObject);
    procedure txtCari_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtCari_KodKeyPress(Sender: TObject; var Key: Char);
    procedure txt_Sevk_AdresButtonClick(Sender: TObject);
    procedure txt_Sevk_AdresEnter(Sender: TObject);
    procedure txt_Sevk_AdresExit(Sender: TObject);
    procedure txt_Sevk_AdresKeyPress(Sender: TObject; var Key: Char);
    procedure txt_Sevk_AdresKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit17Enter(Sender: TObject);
    procedure IB_Edit17KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit17KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit18Enter(Sender: TObject);
    procedure IB_Edit18KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit18KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit19Enter(Sender: TObject);
    procedure IB_Edit19KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit19KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit20Enter(Sender: TObject);
    procedure IB_Edit20KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit20KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit21Enter(Sender: TObject);
    procedure IB_Edit21KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit21KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit21Exit(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure txtKASA_KODButtonClick(Sender: TObject);
    procedure txtKASA_KODExit(Sender: TObject);
    procedure txtKASA_KODEnter(Sender: TObject);
    procedure txtKASA_KODKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtKASA_KODKeyPress(Sender: TObject; var Key: Char);
    procedure txtArac_KodButtonClick(Sender: TObject);
    procedure txtArac_KodExit(Sender: TObject);
    procedure txtArac_KodEnter(Sender: TObject);
    procedure txtArac_KodKeyPress(Sender: TObject; var Key: Char);
    procedure txtArac_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure txtSofor_KodButtonClick(Sender: TObject);
    procedure txtSofor_KodExit(Sender: TObject);
    procedure txtSofor_KodEnter(Sender: TObject);
    procedure txtSofor_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtSofor_KodKeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure IB_Image1DblClick(Sender: TObject);
    procedure qry_KomisyonAfterScroll(IB_Dataset: TIB_Dataset);
    procedure btn_Arac_araClick(Sender: TObject);
    procedure btn_Sof_araClick(Sender: TObject);
    procedure btn_Fir_araClick(Sender: TObject);
    procedure IB_Edit13KeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure btnCari_EkleClick(Sender: TObject);
    procedure btn_Arac_EkleClick(Sender: TObject);
    procedure btn_Sofer_EkleClick(Sender: TObject);

////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prv_OlcuTip_Kontrol:Boolean;
    prv_OlcuBirim_Kontrol:Boolean;
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure Geri_AL;
    procedure Arac_Bilgileri_Getir(Arac_Kod: String);
    procedure Sofor_Bilgileri_Getir(Sofor_Kod: String);
    function ON_MUH_ENT(SIL: Integer):Boolean;

  public
    Prn_Id:Integer;
    Prn_Sid:Integer;
    prv_BELGE_TUR:Integer;
    { Public declarations }
  end;

  const cns_Yukleme_Fisi = 45;

var
  frmYukleme_Fisi: TfrmYukleme_Fisi;

implementation

uses unDataMod, Main, unFunc, unLogger, ufrmCariSDLG, ufrmYuk_Fis_SDLG, unYazici,
  //ufrmGRABBER_WINDOW,
  //ufrmSETTINGS,
   ufrmResimTamEkran,Jpeg, ufrmCariKart,
  ufrmArac, ufrmSofor, UDm_Fast_Report;

{$R *.DFM}

procedure TfrmYukleme_Fisi.Form_Open(Menu:Boolean;Id:Integer;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Yukleme_Fisi,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni Yükleme Fiþi tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
  if not MainForm.FindChildFrm(Application, 'frmYukleme_Fisi') then
  begin
    Application.CreateForm(TfrmYukleme_Fisi, frmYukleme_Fisi);
    with frmYukleme_Fisi do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(Id,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Yükleme Fiþi formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
end;

procedure TfrmYukleme_Fisi.DataSet_Open(Id:Integer;ISLEM_TIP:Byte);
begin

  DataMod.Rapor_Kod_Visible_Fields_IB('KOMISYON',ib_edit16,ib_edit17,ib_edit18,ib_edit19,ib_edit20);
  Image1.Picture.Graphic:=Nil;
  with qry_Komisyon do
  begin
    Active := False;
    ParamByName('PRM_ID').AsInteger := Id;
    Active := True;
  end;
      with qry_Komisyon do
      begin
        FieldByName('TOPLAM_UCRET').DisplayFormat := glb_VPB_FIELD_PF;
        FieldByName('KOMISYON_UCRET').DisplayFormat := glb_VPB_FIELD_PF;
        FieldByName('MUSTERI_KOM').DisplayFormat := glb_VPB_FIELD_PF;

      end;

  case ISLEM_TIP of
  0://edit
    begin
      qry_Komisyon.Edit;
    end;
  1://insert
    begin
      qry_Komisyon.Insert;
    end;
  end;

    prn_ID := qry_Komisyon.FieldByName('ID').AsInteger;
    prn_SID := qry_Komisyon.FieldByName('SID').AsInteger;

end;


procedure TfrmYukleme_Fisi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmYukleme_Fisi.qry_KomisyonAfterInsert(IB_Dataset: TIB_Dataset);
var
KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin
  with qry_Komisyon do
  begin
    FieldByName('ID').AsInteger := Int64(DataMod.GET_SAYAC_NUM('KOMISYON',True,False,0));
    FieldByName('SID').AsInteger := glb_SID;
    FieldByName('KDV_DAHIL').AsInteger :=0;
    FieldByName('KOMISYON_UCRET').AsFloat :=0;
    FieldByName('TOPLAM_UCRET').AsFloat :=0;

    FieldByName('YUK_OLCU_TIP').AsString :='AÐIRLIK';
    FieldByName('YUK_OLCU_BIR').AsString :='KÝLO';
    FieldByName('YUK_KILO').AsFloat :=0;



    FieldByName('SOFOR_KL').AsInteger :=0;
    FieldByName('ARAC_KL').AsInteger :=0;
    FieldByName('MUSTERI_KOM').AsFloat :=0;

    FieldByName('TARIH').AsDateTime :=Date;

    if DataMod.GET_DEFAULT_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) then
    begin
      FieldByName('KASA_KOD').AsString := KASA_KOD;
      FieldByName('KASA_AD').AsString := KASA_AD;
     // if KASA_DOVKOD<>'YTL' then Abort;
      {FieldByName('DOVKOD').AsString := KASA_DOVKOD;
      if FieldByName('DOVKUR').AsCurrency=0 then
      begin
        frmISN_ERRORS.AnyErr(nil,0,0);
        FieldByName('DOVKUR').AsCurrency := 1;
      end;
      }
    end;


  end;
  txtCari_Kod.SetFocus;
end;

procedure TfrmYukleme_Fisi.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmYukleme_Fisi.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmYukleme_Fisi.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmYukleme_Fisi.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.qry_KomisyonBeforeDelete(IB_Dataset: TIB_Dataset);
var
 StrMesaj:String;
begin
  {if DataMod.Delete_Control('DEPO',qry_Depo.FieldByName('DEPO_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;}

    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
end;

procedure TfrmYukleme_Fisi.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Komisyon.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qry_Komisyon.Active := False;
    qry_Komisyon.Active := False;
  end;
end;

procedure TfrmYukleme_Fisi.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmYukleme_Fisi);
end;

function TfrmYukleme_Fisi.KomisyonNo(KOMISYON_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(KOMISYON_SAYAC,TRIM(DataMod.GetParam(cns_Yukleme_Fisi,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Yukleme_Fisi,'KOD_LENGTH',0)));
end;


procedure TfrmYukleme_Fisi.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmYukleme_Fisi.btnAraClick(Sender: TObject);
var
  Id,Sid:Integer;
begin

{
  if DataMod.LS_Komisyon(ID) then
  begin
    DataSet_Open(Id,0);
  end;
}

  if frmYuk_Fis_SDLG.Form_Open(False,Id,Sid) then
  begin
    DataSet_Open(Id,0);
  end;
end;

procedure TfrmYukleme_Fisi.dts_KomisyonStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    //btnSil.Enabled := False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
    if ADataset.State = dssEDIT then
    begin
      btnSil.Enabled := True;
    end
    else
    begin
      btnSil.Enabled := False;
    end;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if qry_Komisyon.FieldByName('ID').AsInteger<=0 then
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

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmYukleme_Fisi.qry_KomisyonBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
{  FuncDeger:=DataMod.Before_Post_Kontrol(qry_DEPO,'DEPO','DEPO_KOD,ADI','DEPO_KOD');
  if funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('DEPO',qry_Depo.FieldByName('DEPO_KOD').OldAsString,qry_Depo.FieldByName('DEPO_KOD').AsString,Nil) then Abort;
}
end;

procedure TfrmYukleme_Fisi.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni Yükleme Fiþi tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open(0,1);
end;

procedure TfrmYukleme_Fisi.btnKaydetClick(Sender: TObject);
begin
  try
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;


  if qry_Komisyon.State in [DssEdit,DssInsert] then
  qry_Komisyon.Post;

    Prn_Id := qry_Komisyon.FieldByName('ID').AsInteger;
    Prn_Sid := qry_Komisyon.FieldByName('SID').AsSmallint;


    if trnFAT_IRS.InTransaction then
    trnFAT_IRS.Rollback;
    trnFAT_IRS.StartTransaction;
    

    if not dmLOGGER.dbaMain_StartMonitoring then Exit;

    if not ON_MUH_ENT(0) then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;


    qry_Komisyon.ApplyUpdates;
    qry_Komisyon.CommitUpdates;

    dmLOGGER.dbaMain_StopMonitoringWrite2log('KOMISYON,',0,0,0,0,1,'KOMISYON');
    trnFAT_IRS.Commit; 



  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(431)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,431,43,1,rgYAZICI.ItemIndex,Prn_Id,Prn_Sid,0,'');
  end
  else
  if rgYAZICI.ItemIndex < 2 then
   Yazici.YUKLEME_FISI(Prn_Id,Prn_Sid,rgYAZICI.ItemIndex);

    Prn_Id := 0;
    Prn_Sid := 0;

  except
    trnFAT_IRS.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;

  qry_Komisyon.Close;
  Image1.Picture.Graphic:=Nil;
   
end;

procedure TfrmYukleme_Fisi.btnIPTALClick(Sender: TObject);
begin

  qry_Komisyon.Cancel;
  qry_Komisyon.CancelUpdates;
  qry_Komisyon.CommitUpdates;
  qry_Komisyon.Close;
  dmLOGGER.dbaMain_CancelMonitoring;
  prn_ID := 0;
  prn_SID := 0;
  
  Image1.Picture.Graphic:=Nil;
end;

procedure TfrmYukleme_Fisi.btnSilClick(Sender: TObject);
var
   Dosya:String;
begin
  try
      Dosya:='';
    if not Form_Before_Delete then exit;

    if not dmLOGGER.dbaMain_StartMonitoring then Exit;

    if trnFAT_IRS.InTransaction then
    trnFAT_IRS.Rollback;
    
    trnFAT_IRS.StartTransaction;

    if not ON_MUH_ENT(1) then
    begin
      trnFAT_IRS.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;
    {qry_Komisyon.FieldByName('RESIM').AsString :='';
    qry_Komisyon.Post;

    qry_Komisyon.ApplyUpdates;
    qry_Komisyon.CommitUpdates;


    qry_Komisyon.FieldByName('RESIM').Clear;
    qry_Komisyon.FieldByName('RESIM').Value:=Null;

    qry_Komisyon.Post;
    }
    Dosya:= qry_Komisyon.FieldByName('RESIM').AsString;

    if Trim(qry_Komisyon.FieldByName('SOFOR_KOD').AsString)='' then Dosya:='';

    qry_Komisyon.Delete;



    qry_Komisyon.ApplyUpdates;
    qry_Komisyon.CommitUpdates;

    if Dosya<>'' then
    if not DataMod.Resim_Bul(Dosya,'KOM') then
    begin
         DeleteFile(Dosya);
    end;


    
    dmLOGGER.dbaMain_StopMonitoringWrite2log('KOMISYON,',0,0,0,0,2,'KOMISYON');

    trnFAT_IRS.Commit;

  except
    trnFAT_IRS.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  qry_Komisyon.Close;
  Image1.Picture.Graphic:=Nil;
end;

procedure TfrmYukleme_Fisi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
    VK_ESCAPE: if btnCikis.Enabled then Close;
    end;//acase end
  end; ///if Shift = [] then ENd
end;

function TfrmYukleme_Fisi.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmYukleme_Fisi.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qry_Komisyon.FieldByName('KOMISYON_UCRET').AsFloat<=0 then
  begin
    Application.MessageBox('Komisyon Ücretini Giriniz','Dikkat',MB_ICONWARNING);
    exit;
  end;



  Result := True;
end;

procedure TfrmYukleme_Fisi.IB_Edit16ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qry_Komisyon.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmYukleme_Fisi.IB_Edit16Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit16.Text)) = 0 then
  begin
    IB_Edit16.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit16,nil,0) then
  begin
    IB_Edit16.Color := clWindow;
  end
  else
  begin
    IB_Edit16.SetFocus;
  end;
    IB_Edit16.Color := clWindow;
end;

procedure TfrmYukleme_Fisi.IB_Edit17ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qry_Komisyon.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmYukleme_Fisi.IB_Edit17Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit17.Text)) = 0 then
  begin
    IB_Edit17.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit17,nil,1) then
  begin
    IB_Edit17.Color := clWindow;
  end
  else
  begin
    IB_Edit17.SetFocus;
  end;
    IB_Edit17.Color := clWindow;
end;

procedure TfrmYukleme_Fisi.IB_Edit18ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qry_Komisyon.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmYukleme_Fisi.IB_Edit18Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit18.Text)) = 0 then
  begin
    IB_Edit18.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit18,nil,2) then
  begin
    IB_Edit18.Color := clWindow;
  end
  else
  begin
    IB_Edit18.SetFocus;
  end;
    IB_Edit18.Color := clWindow;
end;

procedure TfrmYukleme_Fisi.IB_Edit19ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qry_Komisyon.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmYukleme_Fisi.IB_Edit19Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit19.Text)) = 0 then
  begin
    IB_Edit19.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit19,nil,3) then
  begin
    IB_Edit19.Color := clWindow;
  end
  else
  begin
    IB_Edit19.SetFocus;
  end;
    IB_Edit19.Color := clWindow;
end;

procedure TfrmYukleme_Fisi.IB_Edit20ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qry_Komisyon.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmYukleme_Fisi.IB_Edit20Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit20.Text)) = 0 then
  begin
    IB_Edit20.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit20,nil,4) then
  begin
    IB_Edit20.Color := clWindow;
  end
  else
  begin
    IB_Edit20.SetFocus;
  end;
    IB_Edit20.Color := clWindow;
end;

procedure TfrmYukleme_Fisi.IB_Edit16Enter(Sender: TObject);
begin
  IB_Edit16.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.IB_Edit16KeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.IB_Edit16KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit16ButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.IB_Edit27ButtonClick(Sender: TObject);
var
  OlcuTip:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_OlcuTip (OlcuTip) then
  begin
    qry_Komisyon.FieldByName('YUK_OLCU_TIP').AsString := OlcuTip;
  end;
end;

procedure TfrmYukleme_Fisi.IB_Edit27Enter(Sender: TObject);
begin
  IB_Edit27.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.IB_Edit27Exit(Sender: TObject);
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
        SQL.Add('SELECT * FROM OLCUTIP WHERE OLCU_TIP = ' + SQL_Katar(qry_Komisyon.FieldByName('YUK_OLCU_TIP').AsString));
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

procedure TfrmYukleme_Fisi.IB_Edit27KeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuTip_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.IB_Edit27KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit27ButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.IB_Edit21ButtonClick(Sender: TObject);
var
  Returned:Boolean;
  OlcuBir:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if qry_Komisyon.FieldByName('YUK_OLCU_TIP').AsString='' Then
  begin
    Application.MessageBox('Ölçü tipi seçmediniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Returned := DataMod.LS_OlcuBrm(qry_Komisyon.FieldByName('YUK_OLCU_TIP').AsString,OlcuBir);
  if not (Returned = False) then
  begin
    if not (qry_Komisyon.State in [dssEdit,dssInsert]) then
    begin
      qry_Komisyon.Edit;
    end;
    qry_Komisyon.FieldByName('YUK_OLCU_BIR').AsString := OlcuBir;
  end;
end;

procedure TfrmYukleme_Fisi.txtCari_KodButtonClick(Sender: TObject);
var
  KARSI_AD,KARSI_KOD:String;
  Adres:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then exit;
    if frmCariSDLG.Form_Open(False,KARSI_KOD,KARSI_AD,1) Then
    begin
      qry_Komisyon.FieldByName('CARI_KOD').AsString := KARSI_KOD;
      qry_Komisyon.FieldByName('CARI_ADI').AsString := KARSI_AD;
      qry_Komisyon.FieldByName('GONDEREN_FIRMA').AsString := KARSI_AD;
      Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI','CARI_KOD','ADRES_1',qry_Komisyon.FieldByName('CARI_KOD').AsString,Adres) Then
        qry_Komisyon.FieldByName('GON_FIR_ADRES1').AsString := Adres;
      Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI','CARI_KOD','ADRES_2',qry_Komisyon.FieldByName('CARI_KOD').AsString,Adres) Then
      qry_Komisyon.FieldByName('GON_FIR_ADRES2').AsString := Adres;




      Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI','CARI_KOD','TEL_NO_1',qry_Komisyon.FieldByName('CARI_KOD').AsString,Adres) Then
      qry_Komisyon.FieldByName('GON_FIR_TEL').AsString := Adres;

      Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI','CARI_KOD','TEL_NO_2',qry_Komisyon.FieldByName('CARI_KOD').AsString,Adres) Then
      qry_Komisyon.FieldByName('GON_FIR_TEL1').AsString := Adres;


    end;
end;

procedure TfrmYukleme_Fisi.txtCari_KodEnter(Sender: TObject);
begin
  txtCari_Kod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.txtCari_KodExit(Sender: TObject);
var
  CARI_AD,Adres:String;
begin
  if Trim(txtCari_Kod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCari_Kod.Text,CARI_AD) then
    begin
      if trim(qry_Komisyon.FieldByName('CARI_ADI').AsString)='' then
      qry_Komisyon.FieldByName('CARI_ADI').AsString := CARI_AD;
      if trim(qry_Komisyon.FieldByName('GONDEREN_FIRMA').AsString)='' then
      qry_Komisyon.FieldByName('GONDEREN_FIRMA').AsString := CARI_AD;

      Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI','CARI_KOD','ADRES_1',qry_Komisyon.FieldByName('CARI_KOD').AsString,Adres) Then
      begin
      if trim(qry_Komisyon.FieldByName('GON_FIR_ADRES1').AsString)='' then
      begin
        qry_Komisyon.FieldByName('GON_FIR_ADRES1').AsString := Adres;
      end;

      Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI','CARI_KOD','ADRES_2',qry_Komisyon.FieldByName('CARI_KOD').AsString,Adres) Then
      if trim(qry_Komisyon.FieldByName('GON_FIR_ADRES2').AsString)='' then
      begin
      qry_Komisyon.FieldByName('GON_FIR_ADRES2').AsString := Adres;
      end;


      Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI','CARI_KOD','TEL_NO_1',qry_Komisyon.FieldByName('CARI_KOD').AsString,Adres) Then
      if trim(qry_Komisyon.FieldByName('GON_FIR_TEL').AsString)='' then
      begin
      qry_Komisyon.FieldByName('GON_FIR_TEL').AsString := Adres;
      end;

      Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI','CARI_KOD','TEL_NO_2',qry_Komisyon.FieldByName('CARI_KOD').AsString,Adres) Then
      if trim(qry_Komisyon.FieldByName('GON_FIR_TEL1').AsString)='' then
      begin
      qry_Komisyon.FieldByName('GON_FIR_TEL1').AsString := Adres;
      end;


      end;
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
    qry_Komisyon.FieldByName('CARI_ADI').AsString := '';
  end;
end;

procedure TfrmYukleme_Fisi.txtCari_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtCari_KodButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.txtCari_KodKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.txt_Sevk_AdresButtonClick(Sender: TObject);
var
  SEVK_ADRES_KOD,ADRES1,ADRES2:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_Sevk_Adres(SEVK_ADRES_KOD,ADRES1,ADRES2,
  qry_Komisyon.FieldByName('CARI_KOD').AsString,
  qry_Komisyon.FieldByName('SID').AsInteger) then
  begin
    with qry_Komisyon do
    begin
      FieldByName('SEVK_ADRES_KOD').AsString := SEVK_ADRES_KOD;
      FieldByName('GON_FIR_ADRES1').AsString := ADRES1;
      FieldByName('GON_FIR_ADRES2').AsString := ADRES2;
    end;
  end;
end;

procedure TfrmYukleme_Fisi.txt_Sevk_AdresEnter(Sender: TObject);
begin
  txt_Sevk_Adres.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.txt_Sevk_AdresExit(Sender: TObject);
var
  Sevk_Adres_Kod:String;
  Sevk_Adres:String;
begin

  txt_Sevk_Adres.Color := clWindow;

  Sevk_Adres:='';
  if Trim(txt_Sevk_Adres.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD(
    ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
    ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
    'CARI_SEVKAD','CARI_SEVK_KOD','ADRES_1',qry_Komisyon.FieldByName('SEVK_ADRES_KOD').AsString,Sevk_Adres) Then
   begin

      if Trim(qry_Komisyon.FieldByName('GON_FIR_ADRES1').AsString)='' then
      qry_Komisyon.FieldByName('GON_FIR_ADRES1').AsString := Sevk_Adres;

      Sevk_Adres:='';
      if DataMod.FN_KOD2AD(
      ' and CARI_KOD='+SQL_Katar(qry_Komisyon.FieldByName('CARI_KOD').AsString)+
      ' and CARI_SID='+Inttostr(qry_Komisyon.FieldByName('SID').AsInteger),
      'CARI_SEVKAD','CARI_SEVK_KOD','ADRES_2',qry_Komisyon.FieldByName('SEVK_ADRES_KOD').AsString,Sevk_Adres) Then
      if Trim(qry_Komisyon.FieldByName('GON_FIR_ADRES2').AsString)='' then
      qry_Komisyon.FieldByName('GON_FIR_ADRES2').AsString := Sevk_Adres;

    end
    else
    begin
      txt_Sevk_Adres.SetFocus;
    end;
  end
  else
  begin
    qry_Komisyon.FieldByName('SEVK_ADRES_KOD').AsString := '';
  end;
end;

procedure TfrmYukleme_Fisi.txt_Sevk_AdresKeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.txt_Sevk_AdresKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txt_Sevk_AdresButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.IB_Edit17Enter(Sender: TObject);
begin
  IB_Edit17.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.IB_Edit17KeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.IB_Edit17KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit17ButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.IB_Edit18Enter(Sender: TObject);
begin
  IB_Edit18.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.IB_Edit18KeyPress(Sender: TObject;  var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.IB_Edit18KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit18ButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.IB_Edit19Enter(Sender: TObject);
begin
  IB_Edit19.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.IB_Edit19KeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.IB_Edit19KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit19ButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.IB_Edit20Enter(Sender: TObject);
begin
  IB_Edit20.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.IB_Edit20KeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.IB_Edit20KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit20ButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.IB_Edit21Enter(Sender: TObject);
begin
  IB_Edit21.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.IB_Edit21KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.IB_Edit21KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then IB_Edit21ButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.IB_Edit21Exit(Sender: TObject);
begin
  IB_Edit21.Color := clWindow;
  if Trim(IB_Edit21.Text)<>'' then
  begin
    if prv_OlcuBirim_Kontrol=True then
    begin
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT * FROM OLCUBIR WHERE OLCU_TIP=' + SQL_Katar(qry_Komisyon.FieldByName('YUK_OLCU_TIP').AsString)
              + ' AND OLCUBIRIM=' + SQL_Katar(qry_Komisyon.FieldByName('YUK_OLCU_BIR').AsString));
        Active := True;
      end;
      if not ((DataMod.qryGENEL.Bof) and (DataMod.qryGENEL.Eof)) then
      begin
        prv_OlcuBirim_Kontrol := False;
      end
      else
      begin
        prv_OlcuBirim_Kontrol := True;
        IB_Edit21.SetFocus;
      end;
    end;
  end
  else
  begin
    prv_OlcuBirim_Kontrol := True;
  end;
end;

procedure TfrmYukleme_Fisi.btnCiktiClick(Sender: TObject);
begin
  if qry_Komisyon.FieldByName('ID').AsInteger<=0 then Exit;
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(431)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,431,43,1,rgYAZICI.ItemIndex,qry_Komisyon.FieldByName('ID').AsInteger,qry_Komisyon.FieldByName('SID').AsInteger,0,'');
  end
  else
  if rgYAZICI.ItemIndex < 2 then
  Yazici.YUKLEME_FISI(qry_Komisyon.FieldByName('ID').AsInteger,qry_Komisyon.FieldByName('SID').AsInteger,rgYAZICI.ItemIndex);

end;

procedure TfrmYukleme_Fisi.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT FIRST 1 ID,SID FROM KOMISYON WHERE ID<:ID ORDER BY ID DESC';
     qryDeg1.ParamByName('ID').AsInteger:=qry_Komisyon.FieldByName('ID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('ID').AsInteger;
          Sid:=qryDeg1.FieldByName('SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,0);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure TfrmYukleme_Fisi.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 ID,SID FROM KOMISYON WHERE ID>:ID ORDER BY ID';
     qryDeg1.ParamByName('ID').AsInteger:=qry_Komisyon.FieldByName('ID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('ID').AsInteger;
          Sid:=qryDeg1.FieldByName('SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,0);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;


procedure TfrmYukleme_Fisi.Geri_AL;
begin
     if qry_Komisyon.State in [DssEdit,DssInsert] then qry_Komisyon.Cancel;
     qry_Komisyon.CancelUpdates;
     qry_Komisyon.Close;

      if trnFAT_IRS.InTransaction then
         trnFAT_IRS.Rollback;
end;
procedure TfrmYukleme_Fisi.txtKASA_KODButtonClick(Sender: TObject);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin

  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if DataMod.LS_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) Then
  begin
    qry_Komisyon.FieldByName('KASA_KOD').AsString := KASA_KOD;
    qry_Komisyon.FieldByName('KASA_AD').AsString := KASA_AD;
    {qryKASAHAR_MAS.FieldByName('DOVKOD').AsString := KASA_DOVKOD;
    qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(qryKASAHAR_MAS.FieldByName('DOVKOD').AsString,qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
    if qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency=0 Then
    begin
      qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := 1;
    end;
    }
  end;
end;

procedure TfrmYukleme_Fisi.txtKASA_KODExit(Sender: TObject);
var
  KASA_AD,KASA_DOVKOD : String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;


  if Trim(qry_Komisyon.FieldByName('KASA_KOD').AsString) <> '' then
  begin

    if glb_KASA_KISIT_UYG then
    begin
      if DataMod.GET_KULLANICI_KASA_KOD(qry_Komisyon.FieldByName('KASA_KOD').AsString,KASA_AD) then
      begin
        qry_Komisyon.FieldByName('KASA_AD').AsString  := KASA_AD;
        DataMod.FN_KOD2AD('KASA','KASA_KOD','DOVKOD',txtKASA_KOD.Text,KASA_DOVKOD);
        //qry_Komisyon.FieldByName('DOVKOD').AsString := KASA_DOVKOD;
        {qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(qryKASAHAR_MAS.FieldByName('DOVKOD').AsString,qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
        if qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency=0 Then
        begin
          qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := 1;
        end;
        }
      end
      else
      begin
        txtKASA_KOD.SetFocus;
      end;
    end
    else
    begin
     if DataMod.GET_KASA_FROM_KASA_KOD(qry_Komisyon.FieldByName('KASA_KOD').AsString,KASA_AD,KASA_DOVKOD) then
     begin
        qry_Komisyon.FieldByName('KASA_AD').AsString  := KASA_AD;
        //qry_Komisyon.FieldByName('DOVKOD').AsString := KASA_DOVKOD;
        {qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := DataMod.Get_Doviz_Kur(qry_Komisyon.FieldByName('DOVKOD').AsString,qryKASAHAR_MAS.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,0);
        if qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency=0 Then
        begin
          qryKASAHAR_MAS.FieldByName('DOVKUR').AsCurrency := 1;
        end;
        }
     end
     else
     begin
       txtKASA_KOD.SetFocus;
     end;

    end;


  end
  else
  begin
    qry_Komisyon.FieldByName('KASA_AD').AsString  := '';
    qry_Komisyon.FieldByName('DOVKOD').AsString := '';
  end;
  my_Active_Comp.Brush.Color := clWindow;

end;

procedure TfrmYukleme_Fisi.txtKASA_KODEnter(Sender: TObject);
begin
  txtKASA_KOD.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.txtKASA_KODKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtKASA_KODButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.txtKASA_KODKeyPress(Sender: TObject; var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.txtArac_KodButtonClick(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if not (qry_Komisyon.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      qry_Komisyon.FieldByName('ARAC_PLAKA').AsString := PLAKA;
      qry_Komisyon.FieldByName('ARAC_KOD').AsString := ARAC_KOD;
      Arac_Bilgileri_Getir(ARAC_KOD);
      {
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
      }
  end;


end;

procedure TfrmYukleme_Fisi.txtArac_KodExit(Sender: TObject);
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
      qry_Komisyon.FieldByName('ARAC_PLAKA').AsString := PLAKA;
      Arac_Bilgileri_Getir(txtArac_Kod.Text);
      {if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',txtArac_Kod.Text,OZ_MAL) then
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
      }
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
//    if qry_Komisyon.FieldByName('ARAC_PLAKA').AsString<>'' then
    qry_Komisyon.FieldByName('ARAC_PLAKA_CO').AsString := '';
  end;

end;

procedure TfrmYukleme_Fisi.txtArac_KodEnter(Sender: TObject);
begin
  txtArac_Kod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.txtArac_KodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.txtArac_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtArac_KodButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.Button1Click(Sender: TObject);
var
   Dosya_Adi:String;
begin
  if OpenPictureDialog1.Execute<>False then
  begin
//  qry_Komisyon.FieldByName('RESIM').AsString:=OpenPictureDialog1.FileName;
//  qry_KomisyonAfterScroll(qry_Komisyon);
  Dosya_Adi:=glb_IMAGE_DIR+'\'+ 'Kom'+ExtractFileName(OpenPictureDialog1.FileName);
  FileCopy(OpenPictureDialog1.FileName,Dosya_Adi);
  qry_Komisyon.FieldByName('RESIM').AsString:=Dosya_Adi;
  qry_KomisyonAfterScroll(qry_Komisyon);
  end;
//  qry_Komisyon.FieldByName('RESIM').LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TfrmYukleme_Fisi.Button2Click(Sender: TObject);
begin
  if not DataMod.Resim_Bul(qry_Komisyon.FieldByName('RESIM').AsString,'KOM') then
  begin
  MoveFile(Pchar(qry_Komisyon.FieldByName('RESIM').AsString),Pchar(glb_IMAGE_DIR+'\Silinen\'+ExtractFilename(qry_Komisyon.FieldByName('RESIM').AsString)));
  DeleteFile(qry_Komisyon.FieldByName('RESIM').AsString);
  end;

  qry_Komisyon.FieldByName('RESIM').AsString :='';
  Image1.Picture.Graphic:=Nil;

end;

procedure TfrmYukleme_Fisi.txtSofor_KodButtonClick(Sender: TObject);
var
  SOFOR_KOD, SOFOR_AD :String;
begin
  if DataMod.LS_Sofor(SOFOR_KOD, SOFOR_AD) then
  begin
      qry_Komisyon.FieldByName('SOFOR_KOD').AsString := SOFOR_KOD;
      qry_Komisyon.FieldByName('SOFOR_ADI_CO').AsString := SOFOR_AD;
      Sofor_Bilgileri_Getir(SOFOR_KOD);
  end;
end;

procedure TfrmYukleme_Fisi.txtSofor_KodExit(Sender: TObject);
var
  SOFOR_AD:String;
begin
  if Trim(txtSofor_Kod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('SOFOR','SOFOR_KOD','ADI_SOYADI',txtSofor_Kod.Text,SOFOR_AD) then
    begin
      qry_Komisyon.FieldByName('SOFOR_ADI_CO').AsString := SOFOR_AD;
      Sofor_Bilgileri_Getir(txtSofor_Kod.Text);

      if (Sender is TIB_Edit) then
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtSofor_Kod.SetFocus;
    end;
  end
  else
  begin
      if (Sender is TIB_Edit) then
    (Sender as TIB_Edit).Color := clWindow;
    qry_Komisyon.FieldByName('SOFOR_ADI_CO').AsString := '';
  end;

end;

procedure TfrmYukleme_Fisi.txtSofor_KodEnter(Sender: TObject);
begin
  txtSofor_Kod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmYukleme_Fisi.txtSofor_KodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then  txtSofor_KodButtonClick(Self);
end;

procedure TfrmYukleme_Fisi.txtSofor_KodKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.Arac_Bilgileri_Getir(Arac_Kod:String);
var
  qry_Deg1:TIB_Query;
begin
      DataMod.CreateQuery(qry_Deg1,Nil,False,DataMod.dbaMain);
      qry_Deg1.Active:=False;
      qry_Deg1.Sql.Text:='Select * from ARAC where ARAC_KOD=:ARAC_KOD';
      qry_Deg1.ParamByName('ARAC_KOD').AsString:=Arac_Kod;
      qry_Deg1.Open;

      if Trim(qry_Komisyon.FieldByName('ARAC_PLAKA').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_PLAKA').AsString:=qry_Deg1.FieldByName('PLAKA').AsString;
      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI').AsString:=qry_Deg1.FieldByName('AS_ADISOYADI').AsString;
      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI').AsString:=qry_Deg1.FieldByName('AS_IKA_ADRES').AsString;
      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI1').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI1').AsString:=qry_Deg1.FieldByName('AS_IKA_ADRES1').AsString;
      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString:=qry_Deg1.FieldByName('AS_TEL1').AsString;
      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString:=qry_Deg1.FieldByName('AS_TEL2').AsString;


      if (qry_Komisyon.FieldByName('ARAC_KL').AsInteger=0) and (qry_Deg1.FieldByName('KARA_LISTE').AsInteger=1) then
      qry_Komisyon.FieldByName('ARAC_KL').AsInteger:=qry_Deg1.FieldByName('KARA_LISTE').AsInteger;

      qry_Deg1.Active:=False;
      qry_Deg1.Sql.Text:='Select * from ARAC_RUHSAT where ARAC_KOD=:ARAC_KOD';
      qry_Deg1.ParamByName('ARAC_KOD').AsString:=Arac_Kod;
      qry_Deg1.Open;
      if Trim(qry_Komisyon.FieldByName('ARAC_MARKA').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_MARKA').AsString:=qry_Deg1.FieldByName('MARKASI').AsString;
      if Trim(qry_Komisyon.FieldByName('ARAC_MODEL').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_MODEL').AsString:=qry_Deg1.FieldByName('MODELI').AsString;

      qry_Deg1.Active:=False;
end;

procedure TfrmYukleme_Fisi.Sofor_Bilgileri_Getir(Sofor_Kod:String);
var
  qry_Deg1:TIB_Query;
begin
      DataMod.CreateQuery(qry_Deg1,Nil,False,DataMod.dbaMain);
      qry_Deg1.Active:=False;
      qry_Deg1.Sql.Text:='Select * from SOFOR where SOFOR_KOD=:SOFOR_KOD';
      qry_Deg1.ParamByName('SOFOR_KOD').AsString:=Sofor_Kod;
      qry_Deg1.Open;

      if Trim(qry_Komisyon.FieldByName('SOFOR_ADI_SOY').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_ADI_SOY').AsString:=qry_Deg1.FieldByName('ADI_SOYADI').AsString;
      if Trim(qry_Komisyon.FieldByName('SOFOR_ADRESI').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_ADRESI').AsString:=qry_Deg1.FieldByName('ADRESI1').AsString;
      if Trim(qry_Komisyon.FieldByName('SOFOR_ADRESI1').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_ADRESI1').AsString:=qry_Deg1.FieldByName('ADRESI2').AsString;
      if Trim(qry_Komisyon.FieldByName('SOFOR_TEL').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_TEL').AsString:=qry_Deg1.FieldByName('TEL_NO1').AsString;
      if Trim(qry_Komisyon.FieldByName('SOFOR_TEL1').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_TEL1').AsString:=qry_Deg1.FieldByName('TEL_NO2').AsString;
      if Trim(qry_Komisyon.FieldByName('SOFOR_EHLIYET_NO').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_EHLIYET_NO').AsString:=qry_Deg1.FieldByName('EHLIYET_NO').AsString;
      if Trim(qry_Komisyon.FieldByName('SOFOR_VERGI_DA').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_VERGI_DA').AsString:=qry_Deg1.FieldByName('VERGI_DAIRE').AsString;
      if Trim(qry_Komisyon.FieldByName('SOFOR_VERGI_DA_NO').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_VERGI_DA_NO').AsString:=qry_Deg1.FieldByName('VERGI_NO').AsString;

      if (qry_Komisyon.FieldByName('SOFOR_KL').AsInteger=0) and (qry_Deg1.FieldByName('KARA_LISTE').AsInteger=1) then
      qry_Komisyon.FieldByName('SOFOR_KL').AsInteger:=qry_Deg1.FieldByName('KARA_LISTE').AsInteger;

      //qry_Komisyon.FieldByName('RESIM').Assign(qry_Deg1.FieldByName('RESIM'));
      if Trim(qry_Komisyon.FieldByName('RESIM').AsString)='' then
      qry_Komisyon.FieldByName('RESIM').AsString:=qry_Deg1.FieldByName('RESIM').AsString;
      if Trim(qry_Komisyon.FieldByName('RESIM').AsString)<>'' then
      Image1.Picture.LoadFromFile(qry_Komisyon.FieldByName('RESIM').AsString);

      qry_Deg1.Active:=False;
end;





function TfrmYukleme_Fisi.ON_MUH_ENT(SIL:Integer):Boolean;
var
  qryKASAHAR:TIb_Query;
  KASA_DOVKOD:String;
  KasaDeger:Currency;
  Ent_Message:PChar;
  KASA_SIL,a:Integer;
begin
  Result := False;
  try

    try
        if SIL = 0 then
          if Trim(qry_Komisyon.FieldByName('KASA_KOD').AsString) = '' then KASA_SIL := 1 else KASA_SIL := 0
        else KASA_SIL := 1;

      prv_BELGE_TUR:=BT_KOMISYON_FISI;
      DataMod.CreateQuery(qryKASAHAR,trnFAT_IRS,True,DataMod.dbaMain);

      for a:=1 to 2 do
      begin
          if a=1 then KASA_SIL:=1 ;
          if a=2 then KASA_SIL:=0 ;

      with qryKASAHAR do
      begin
        Active := False;
        sql.Clear;
        sql.add('SELECT * FROM KASAHAR WHERE KASAHAR_ID = 0 AND KASAHAR_SID = 0');
        Active := True;
        if KASA_SIL = 0 then // KASA HAREKETÝ YARATIRILIYOR
        begin
          insert;
          FieldByName('KASAHAR_ID').AsInteger := Gen_ID('GEN_KASAHAR',1);
          FieldByName('KASAHAR_SID').AsInteger := glb_SID;
          FieldByName('KASA_KOD').AsString := Trim(qry_Komisyon.FieldByName('KASA_KOD').AsString);
          FieldByName('TARIH').AsDate := qry_Komisyon.FieldByName('TARIH').AsDate;
          FieldByName('DOV_BAZ_TAR').AsDate := qry_Komisyon.FieldByName('TARIH').AsDate;
          FieldByName('BELGE_TUR').AsInteger := BT_KOMISYON_FISI;
          FieldByName('BELGE_ID').AsInteger := qry_Komisyon.FieldByName('ID').AsInteger;
          FieldByName('BELGE_SID').AsInteger := qry_Komisyon.FieldByName('SID').AsInteger;
          FieldByName('TIP').AsString := GIRIS;
          FieldByName('ACIKLAMA').AsString := qry_Komisyon.FieldByName('ACIKLAMA').AsString;
          FieldByName('ISLEM_TIP').AsInteger := 1;
          FieldByName('PROJE_KOD').AsString := '';
          FieldByName('PLASIYER_KOD').AsString := '';
          FieldByName('MC').AsString := 'C';
          FieldByName('KARSIKOD').AsString := glb_Muhtelif_Kod;
          FieldByName('SIRA_NO').AsInteger := 1;
          FieldByName('DOVKOD').AsString := glb_DEFCUR;
          FieldByName('DOVKUR').AsCurrency := 1;
          FieldByName('TUTAR').AsCurrency := qry_Komisyon.FieldbyName('KOMISYON_UCRET').AsCurrency;
          FieldByName('TUTAR_VPB').AsCurrency := qry_Komisyon.FieldbyName('KOMISYON_UCRET').AsCurrency;
          //KASADEÐER HESAPLA
          DataMod.FN_KOD2AD('KASA','KASA_KOD','DOVKOD',Trim(qry_Komisyon.FieldByName('KASA_KOD').AsString),KASA_DOVKOD);
          if KASA_DOVKOD <> '' then
          begin
            if not DataMod.KurluDonustur(qry_Komisyon.FieldByName('TARIH').AsDate,glb_DEFCUR,1,KASA_DOVKOD,qry_Komisyon.FieldbyName('KOMISYON_UCRET').AsCurrency,glb_SATISKUR,True,KasaDeger) then
            begin
              Application.MessageBox('TfrmKomisyon.ON_MUH_ENT : Kasadeðeri için kur dönüþümü yapýlamadý','Dikkat',MB_ICONERROR);
              Result := False;
              Exit;
            end;
            FieldByName('KASADEGER').AsCurrency := KasaDeger;
          end
          else
          begin
            Ent_Message := Pchar(qry_Komisyon.FieldByName('KASA_KOD').AsString + ' Kodlu kasanýn Para Birimi bilgisine ulaþýlamýyor. Kasa Modulunden ilgili bilgiyi giriniz');
            Application.MessageBox(Ent_Message,'Dikkat', MB_ICONSTOP);
            Result := False;
          end;

          //KASADEÐER HESAPLA SON
          FieldByName('OLCUBIRIM').AsString := qry_Komisyon.FieldByName('YUK_OLCU_BIR').AsString;
          FieldByName('MIKTAR').AsFloat :=  qry_Komisyon.FieldByName('YUK_KILO').AsFloat;
          Post;
        end
        else
        begin
          sql.Clear;
          sql.add('DELETE FROM KASAHAR WHERE BELGE_TUR = '+ IntToStr(prv_BELGE_TUR) + ' AND BELGE_ID = ' + IntToStr(qry_Komisyon.FieldByName('ID').AsInteger) + ' AND BELGE_SID = ' + IntToStr(qry_Komisyon.FieldByName('SID').AsInteger));
          Execute;
        end;
         Active := False;
         Result := True;
      end;    // with

      if SIL = 1 then Break;
      end;
    except
      Result := False;
    end;
  finally
    DataMod.ReleaseQuery(qryKASAHAR);
  end;
end;


procedure TfrmYukleme_Fisi.Button3Click(Sender: TObject);
begin
//  if not MainForm.FindChildFrm(Application,'frmGRABBER_WINDOW') then Application.CreateForm(TfrmGRABBER_WINDOW, frmGRABBER_WINDOW);
{  Application.CreateForm(TfrmGRABBER_WINDOW, frmGRABBER_WINDOW);
  frmGRABBER_WINDOW.Kaynak:='Komisyon';
  frmGRABBER_WINDOW.ShowModal;
  frmGRABBER_WINDOW.Release;
  }
end;

procedure TfrmYukleme_Fisi.Button4Click(Sender: TObject);
begin
  {Application.CreateForm(TfrmSettings, frmSettings);
  frmSETTINGS.ShowModal;
  frmSettings.Release; }
end;

procedure TfrmYukleme_Fisi.IB_Image1DblClick(Sender: TObject);
begin
  Application.CreateForm(TfrmResimTamEkran, frmResimTamEkran);
  frmResimTamEkran.Image1.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  frmResimTamEkran.ShowModal;
  frmResimTamEkran.Release;
end;

procedure TfrmYukleme_Fisi.qry_KomisyonAfterScroll(IB_Dataset: TIB_Dataset);
begin
  if not qry_Komisyon.FieldByName('RESIM').IsNull then
  begin
  //     qry_Komisyon.FieldByName('RESIM').SaveToFile(glb_WINDOWS_DIR+'\Tempx.jpg');
  //     Image1.Picture.LoadFromFile(glb_WINDOWS_DIR+'\tempx.jpg');
try
  Image1.Picture.LoadFromFile(qry_Komisyon.FieldByName('RESIM').AsString);
except
    Application.MessageBox(Pchar(qry_Komisyon.FieldByName('RESIM').AsString +' adlý dosya bulunamadý Resmi Sil butonu ile ya boþaltýn yada Yeni Resim Seçiniz'),'Dikkat',MB_ICONWARNING);
end;

  end;
end;

procedure TfrmYukleme_Fisi.btn_Arac_araClick(Sender: TObject);
var
  qry_Deg1:TIB_Query;
  id,sid:Integer;
begin
  if frmYuk_Fis_SDLG.Form_Open(False,Id,Sid) then
  begin
      DataMod.CreateQuery(qry_Deg1,Nil,False,DataMod.dbaMain);
      qry_Deg1.Active:=False;
      qry_Deg1.Sql.Text:='Select * from KOMISYON where ID=:ID and SID=:SID';
      qry_Deg1.ParamByName('ID').AsInteger:=Id;
      qry_Deg1.ParamByName('SID').AsInteger:=SId;
      qry_Deg1.Open;

//      if Trim(qry_Komisyon.FieldByName('ARAC_PLAKA').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_PLAKA').AsString:=qry_Deg1.FieldByName('ARAC_PLAKA').AsString;
//      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI').AsString:=qry_Deg1.FieldByName('ARAC_SAHIBI').AsString;
//      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI').AsString:=qry_Deg1.FieldByName('ARAC_SAHIBI_ADRESI').AsString;
//      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI1').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI1').AsString:=qry_Deg1.FieldByName('ARAC_SAHIBI_ADRESI1').AsString;
//      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString:=qry_Deg1.FieldByName('ARAC_SAHIBI_TEL').AsString;
//      if Trim(qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString:=qry_Deg1.FieldByName('ARAC_SAHIBI_TEL').AsString;

//      if Trim(qry_Komisyon.FieldByName('ARAC_MARKA').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_MARKA').AsString:=qry_Deg1.FieldByName('ARAC_MARKA').AsString;
//      if Trim(qry_Komisyon.FieldByName('ARAC_MODEL').AsString)='' then
      qry_Komisyon.FieldByName('ARAC_MODEL').AsString:=qry_Deg1.FieldByName('ARAC_MODEL').AsString;

      qry_Komisyon.FieldByName('ARAC_KL').AsInteger:=qry_Deg1.FieldByName('ARAC_KL').AsInteger;      

      qry_Deg1.Active:=False;

  end;

end;

procedure TfrmYukleme_Fisi.btn_Sof_araClick(Sender: TObject);
var
  qry_Deg1:TIB_Query;
  id,sid:Integer;
begin
  if frmYuk_Fis_SDLG.Form_Open(False,Id,Sid) then
  begin
      DataMod.CreateQuery(qry_Deg1,Nil,False,DataMod.dbaMain);
      qry_Deg1.Active:=False;
      qry_Deg1.Sql.Text:='Select * from KOMISYON where ID=:ID and SID=:SID';
      qry_Deg1.ParamByName('ID').AsInteger:=Id;
      qry_Deg1.ParamByName('SID').AsInteger:=SId;
      qry_Deg1.Open;

      //if Trim(qry_Komisyon.FieldByName('SOFOR_ADI_SOY').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_ADI_SOY').AsString:=qry_Deg1.FieldByName('SOFOR_ADI_SOY').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_ADRESI').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_ADRESI').AsString:=qry_Deg1.FieldByName('SOFOR_ADRESI').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_ADRESI1').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_ADRESI1').AsString:=qry_Deg1.FieldByName('SOFOR_ADRESI1').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_TEL').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_TEL').AsString:=qry_Deg1.FieldByName('SOFOR_TEL').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_TEL1').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_TEL1').AsString:=qry_Deg1.FieldByName('SOFOR_TEL1').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_EHLIYET_NO').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_EHLIYET_NO').AsString:=qry_Deg1.FieldByName('SOFOR_EHLIYET_NO').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_VERGI_DA').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_VERGI_DA').AsString:=qry_Deg1.FieldByName('SOFOR_VERGI_DA').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_VERGI_DA_NO').AsString)='' then
      qry_Komisyon.FieldByName('SOFOR_VERGI_DA_NO').AsString:=qry_Deg1.FieldByName('SOFOR_VERGI_DA_NO').AsString;

      qry_Komisyon.FieldByName('SOFOR_KL').AsInteger:=qry_Deg1.FieldByName('SOFOR_KL').AsInteger;

      if Trim(qry_Komisyon.FieldByName('RESIM').AsString)='' then
      qry_Komisyon.FieldByName('RESIM').AsString:=qry_Deg1.FieldByName('RESIM').AsString;
      if Trim(qry_Komisyon.FieldByName('RESIM').AsString)<>'' then
      Image1.Picture.LoadFromFile(qry_Komisyon.FieldByName('RESIM').AsString);



      qry_Deg1.Active:=False;
  end;

end;

procedure TfrmYukleme_Fisi.btn_Fir_araClick(Sender: TObject);
var
  qry_Deg1:TIB_Query;
  id,sid:Integer;
begin
  if frmYuk_Fis_SDLG.Form_Open(False,Id,Sid) then
  begin
      DataMod.CreateQuery(qry_Deg1,Nil,False,DataMod.dbaMain);
      qry_Deg1.Active:=False;
      qry_Deg1.Sql.Text:='Select * from KOMISYON where ID=:ID and SID=:SID';
      qry_Deg1.ParamByName('ID').AsInteger:=Id;
      qry_Deg1.ParamByName('SID').AsInteger:=SId;
      qry_Deg1.Open;

      //if Trim(qry_Komisyon.FieldByName('SOFOR_ADI_SOY').AsString)='' then
      qry_Komisyon.FieldByName('GONDEREN_FIRMA').AsString:=qry_Deg1.FieldByName('GONDEREN_FIRMA').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_ADRESI').AsString)='' then
      qry_Komisyon.FieldByName('GON_FIR_ADRES1').AsString:=qry_Deg1.FieldByName('GON_FIR_ADRES1').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_ADRESI1').AsString)='' then
      qry_Komisyon.FieldByName('GON_FIR_ADRES2').AsString:=qry_Deg1.FieldByName('GON_FIR_ADRES2').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_TEL').AsString)='' then
      qry_Komisyon.FieldByName('GON_FIR_TEL').AsString:=qry_Deg1.FieldByName('GON_FIR_TEL').AsString;
      //if Trim(qry_Komisyon.FieldByName('SOFOR_TEL1').AsString)='' then
      qry_Komisyon.FieldByName('GON_FIR_TEL1').AsString:=qry_Deg1.FieldByName('GON_FIR_TEL1').AsString;


      qry_Deg1.Active:=False;
  end;

end;

procedure TfrmYukleme_Fisi.IB_Edit13KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.IB_Edit8KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmYukleme_Fisi.btnCari_EkleClick(Sender: TObject);
begin
    if Application.MessageBox('Kaydý Cari Kayýtlarýna Ekleme Ýstiyormusunuz','Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDYES then
    begin
         frmCariKart.Form_Open(True,'',0);
         frmCariKart.qryCari.FieldByName('CARI_AD').AsString:=qry_Komisyon.FieldByName('GONDEREN_FIRMA').AsString;
         frmCariKart.qryCari.FieldByName('ADRES_1').AsString:=qry_Komisyon.FieldByName('GON_FIR_ADRES1').AsString;
         frmCariKart.qryCari.FieldByName('ADRES_2').AsString:=qry_Komisyon.FieldByName('GON_FIR_ADRES2').AsString;
         frmCariKart.qryCari.FieldByName('TEL_NO_1').AsString:=qry_Komisyon.FieldByName('GON_FIR_TEL').AsString;
         frmCariKart.qryCari.FieldByName('TEL_NO_2').AsString:=qry_Komisyon.FieldByName('GON_FIR_TEL1').AsString;

    end;

end;

procedure TfrmYukleme_Fisi.btn_Arac_EkleClick(Sender: TObject);
begin
    if Application.MessageBox('Kaydý Araç Kayýtlarýna Ekleme Ýstiyormusunuz','Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDYES then
    begin
         frmArac.Form_Open(True,'',1);
         frmArac.qryArac.FieldByName('PLAKA').AsString:=qry_Komisyon.FieldByName('ARAC_PLAKA').AsString;
         frmArac.qryArac.FieldByName('AS_ADISOYADI').AsString:=qry_Komisyon.FieldByName('ARAC_SAHIBI').AsString;
         frmArac.qryArac.FieldByName('AS_IKA_ADRES').AsString:=qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI').AsString;
         frmArac.qryArac.FieldByName('AS_IKA_ADRES1').AsString:=qry_Komisyon.FieldByName('ARAC_SAHIBI_ADRESI1').AsString;
         frmArac.qryArac.FieldByName('AS_TEL1').AsString:=qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL').AsString;
         frmArac.qryArac.FieldByName('AS_TEL2').AsString:=qry_Komisyon.FieldByName('ARAC_SAHIBI_TEL1').AsString;

         frmArac.QryAracRuhsat.FieldByName('MARKASI').AsString:=qry_Komisyon.FieldByName('ARAC_MARKA').AsString;
         frmArac.QryAracRuhsat.FieldByName('MODELI').AsString:=qry_Komisyon.FieldByName('ARAC_MODEL').AsString;

         frmArac.qryArac.FieldByName('AS_SERI_NO').AsString:=qry_Komisyon.FieldByName('ARAC_RUHSAT_NO').AsString;
    end;
end;

procedure TfrmYukleme_Fisi.btn_Sofer_EkleClick(Sender: TObject);
begin
    if Application.MessageBox('Kaydý Söför Kayýtlarýna Ekleme Ýstiyormusunuz','Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDYES then
    begin
         frmSofor.Form_Open(True,'',1);
         frmSofor.qrySofor.FieldByName('ADI_SOYADI').AsString:=qry_Komisyon.FieldByName('SOFOR_ADI_SOY').AsString;
         frmSofor.qrySofor.FieldByName('EHLIYET_NO').AsString:=qry_Komisyon.FieldByName('SOFOR_EHLIYET_NO').AsString;
         frmSofor.qrySofor.FieldByName('ADRESI1').AsString:=qry_Komisyon.FieldByName('SOFOR_ADRESI').AsString;
         frmSofor.qrySofor.FieldByName('ADRESI2').AsString:=qry_Komisyon.FieldByName('SOFOR_ADRESI1').AsString;
         frmSofor.qrySofor.FieldByName('TEL_NO1').AsString:=qry_Komisyon.FieldByName('SOFOR_TEL').AsString;
         frmSofor.qrySofor.FieldByName('TEL_NO2').AsString:=qry_Komisyon.FieldByName('SOFOR_TEL1').AsString;
         frmSofor.qrySofor.FieldByName('VERGI_DAIRE').AsString:=qry_Komisyon.FieldByName('SOFOR_VERGI_DA').AsString;
         frmSofor.qrySofor.FieldByName('VERGI_NO').AsString:=qry_Komisyon.FieldByName('SOFOR_VERGI_DA_NO').AsString;
    end;
end;

end.

