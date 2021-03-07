unit ufrmPlaka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IB_Components, Mask, IB_Controls;

type
  TfrmPlaka = class(TForm)
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    Panel2: TPanel;
    dstPlaka: TIB_DataSource;
    qryPlaka: TIB_Query;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    txtCari_Kod: TIB_Edit;
    procedure btnCikisClick(Sender: TObject);
    procedure Form_Open(Menu: Boolean; Plaka_ID: String; ISLEM: Byte);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnYeniClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dstPlakaStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure btnKaydetClick(Sender: TObject);
    procedure qryPlakaBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryPlakaBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qryPlakaAfterInsert(IB_Dataset: TIB_Dataset);
    procedure txtCari_KodButtonClick(Sender: TObject);
    procedure txtCari_KodEnter(Sender: TObject);
    procedure txtCari_KodExit(Sender: TObject);
    procedure txtCari_KodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);


  private

    prv_CanUpdate,prv_CanDelete:Boolean;
    prn_Plaka_ID:String;
    prn_Plaka_ADI:String;
    prv_BELGE_TUR:Integer;
    my_Active_Comp:TWinControl;
    procedure DataSet_Open(Plaka_ID: String; ISLEM: Byte);
    function Form_Before_Post: Boolean;
    procedure Form_Post;
    function Form_Before_Delete: Boolean;
    function PlakaNo(Plaka_SAYAC: INTEGER): String;


    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_Plaka=32;

var
  frmPlaka: TfrmPlaka;

implementation

uses unDataMod, main,  unLogger, unFunc, ufrmCariSDLG;

{$R *.dfm}

procedure TfrmPlaka.Form_Open(Menu:Boolean;Plaka_ID:String;ISLEM:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin

  if not DataMod.Modul_Hak(cns_Plaka,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni Plaka yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;


//****************************************************************************//
  if not MainForm.FindChildFrm( Application, 'frmPlaka') then
  begin
    Application.CreateForm (TfrmPlaka,frmPlaka);
    frmPlaka.prv_CanUpdate := local_can_update;
    frmPlaka.prv_CanDelete := local_can_delete;
  end
  else
  begin
    Application.MessageBox('Plaka formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
//****************************************************************************//



  frmPlaka.DataSet_Open(Plaka_ID,Islem);
end;


procedure TfrmPlaka.DataSet_Open(Plaka_ID:String;ISLEM:Byte);
begin
  if ((ISLEM = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmPlaka do
  begin
    with qryPlaka do
    begin
      Active := False;
      ParambyName('PRM_PLAKA_NO').AsString := Plaka_ID;
      Active := True;
    end;
//****************************************************************************//
    prn_Plaka_ID := Plaka_ID;
//****************************************************************************//
    case Islem of
    0:
      begin
        qryPlaka.Insert;
      end;
    1:
      begin
        qryPlaka.Edit;
      end;
    end;
  end;//with
end;


procedure TfrmPlaka.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPlaka.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPlaka.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qryPlaka.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Plaka bilgileri bölümünde yaptýðýnýz deðiþiklikleri kaydediniz veya iptal ediniz.','DÝKKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmPlaka.btnYeniClick(Sender: TObject);
begin
  qryPlaka.Append;
end;

procedure TfrmPlaka.btnIPTALClick(Sender: TObject);
begin
  qryPlaka.Cancel;
end;

procedure TfrmPlaka.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryPlaka.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('PLAKA',0,0,0,0,2,'PLAKA');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

function TfrmPlaka.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

procedure TfrmPlaka.btnAraClick(Sender: TObject);
var
  Plaka_KOD,  ACIKLAMA,Cari_Kod,Cari_Ad:String;
begin
  if datamod.LS_Plaka(prn_Plaka_ID,ACIKLAMA,Cari_Kod,Cari_Ad) then
  begin
    DataSet_Open(prn_Plaka_ID,1);
  end;
end;

procedure TfrmPlaka.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmPlaka.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.color :=clWindow;
end;

procedure TfrmPlaka.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmPlaka);
end;

procedure TfrmPlaka.dstPlakaStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKAYDET.Enabled := True;
    btnIPTAL.Enabled := True;
    btnSil.Enabled := False;
  end
  else
  begin
    {if not ((ADataset.Eof) And (ADataset.Bof)) then
    begin
      btnSil.Enabled := True
    end
    else
    begin
      btnSil.Enabled := False;
    end;}
    if Length(Trim(ADataset.FieldByName('PLAKA_NO').AsString))<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;


    btnYeni.Enabled:=True;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKAYDET.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmPlaka.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

function TfrmPlaka.Form_Before_Post: Boolean;
begin
  Result := False;

  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu Modülde Deðiþiklik Yapma Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;


  if Trim(qryPlaka.FieldByName('PLAKA_NO').AsString) = ''  then
  begin
    IB_Edit1.SetFocus;
    Application.MessageBox('Plaka Kodu Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

    if Trim(qryPlaka.FieldByName('CARI_KOD').AsString)='' then
  begin
    IB_Edit2.SetFocus;
    Application.MessageBox('Cari Kodu boþ býrakamazsýnýz.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  with DataMod.qryGENEL do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) As GELEN FROM Plaka WHERE PLAKA_NO='
           + SQL_Katar(qryPlaka.FieldByName('PLAKA_NO').AsString));
    Active := True;
  end;

  if qryPlaka.State = DssInsert then
  if (DataMod.qryGENEL.FieldByName('GELEN').AsInteger>0) then
  begin
    Application.MessageBox('Bu Plaka No Kayýt Yapýlmýþtýr. Farklý Bir Plaka Kod Deneyiniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;

  if qryPlaka.State = DssEdit then
  begin
    if qryPlaka.FieldByName('PLAKA_NO').OldAsString<>qryPlaka.FieldByName('PLAKA_NO').AsString then
    if (DataMod.qryGENEL.FieldByName('GELEN').AsInteger>=1) then
    begin
      Application.MessageBox('Bu Plaka No Kayýt Yapýlmýþtýr. Farklý Bir Plaka Kod Deneyiniz.','Dikkat',MB_ICONWARNING);
      Abort;
    end;
  end;


  Result := True;
end;

procedure TfrmPlaka.Form_Post;
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
//****************************************************************************//
    prn_Plaka_ID := qryPlaka.FieldByName('PLAKA_NO').AsString;
//    prn_RECETE_SID := qrySiparis.FieldByName('RECETE_SID').AsSmallint;
//****************************************************************************//
    qryPlaka.Post;
    //qryPlaka.ApplyUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('PLAKA',0,0,0,0,1,'PLAKA');

//****************************************************************************//
//    if rgYAZICI.ItemIndex < 2 then Yazici.FATURA(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex);
    prn_Plaka_ID := '';
    //prn_Plaka_ID := 0;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  //qryPlaka.CommitUpdates;
end;


procedure TfrmPlaka.qryPlakaBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not DataMod.Post_Update('PLAKA',qryPlaka.FieldByName('PLAKA_NO').OldAsString,qryPlaka.FieldByName('PLAKA_NO').AsString,Nil) then Abort;
end;

procedure TfrmPlaka.qryPlakaBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('PLAKA',qryPlaka.FieldByName('PLAKA_NO').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmPlaka.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmPlaka.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmPlaka.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmPlaka.qryPlakaAfterInsert(IB_Dataset: TIB_Dataset);
begin
//     qryPlaka.FieldByName('PLAKA_NO').AsString := PlakaNo(qryPlaka.Gen_ID('GEN_PLAKA',1));
     qryPlaka.FieldByName('PLAKA_SID').AsInteger := glb_SID;
     IB_Edit1.SetFocus;     
end;


function TfrmPlaka.PlakaNo(Plaka_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(Plaka_SAYAC,TRIM(DataMod.GetParam(cns_Plaka,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Plaka,'KOD_LENGTH',0)));
end;

procedure TfrmPlaka.txtCari_KodButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qryPlaka.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qryPlaka.FieldByName('CARI_KOD').AsString := Cari_KOD;
      qryPlaka.FieldByName('CARI_AD').AsString := Cari_AD;
  end;
end;

procedure TfrmPlaka.txtCari_KodEnter(Sender: TObject);
begin
  txtCari_Kod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmPlaka.txtCari_KodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCari_Kod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCari_Kod.Text,CARI_AD) then
    begin
      qryPlaka.FieldByName('CARI_AD').AsString := CARI_AD;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtCari_Kod.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qryPlaka.FieldByName('CARI_AD').AsString := '';
  end;

end;

procedure TfrmPlaka.txtCari_KodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txtCari_KodButtonClick(Self);
end;

end.


{CREATE TABLE PLAKA (
    PLAKA_NO  D_KOD NOT NULL,
    CARI_KOD  D_KOD NOT NULL,
    ACIKLAMA  D_ACK30
);
ALTER TABLE PLAKA ADD CONSTRAINT PK_PLAKA PRIMARY KEY (PLAKA_NO, CARI_KOD);
}
