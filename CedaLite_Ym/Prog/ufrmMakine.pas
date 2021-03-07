unit ufrmMakine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IB_Components, Mask, IB_Controls;

type
  TfrmMakine = class(TForm)
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    Panel2: TPanel;
    dstMakine: TIB_DataSource;
    qryMakine: TIB_Query;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    procedure btnCikisClick(Sender: TObject);
    procedure Form_Open(Menu: Boolean; MAKINE_ID: String; ISLEM: Byte);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnYeniClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dstMakineStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure btnKaydetClick(Sender: TObject);
    procedure qryMakineBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryMakineBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qryMakineAfterInsert(IB_Dataset: TIB_Dataset);


  private

    prv_CanUpdate,prv_CanDelete:Boolean;
    prn_MAKINE_ID:String;
    prn_MAKINE_ADI:String;
    prv_BELGE_TUR:Integer;
    my_Active_Comp:TWinControl;
    procedure DataSet_Open(MAKINE_ID: String; ISLEM: Byte);
    function Form_Before_Post: Boolean;
    procedure Form_Post;
    function Form_Before_Delete: Boolean;
    function MakineNo(Makine_SAYAC: INTEGER): String;


    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_makine=25;

var
  frmMakine: TfrmMakine;

implementation

uses unDataMod, main,  unLogger, unFunc;

{$R *.dfm}


procedure TfrmMakine.Form_Open(Menu:Boolean;MAKINE_ID:String;ISLEM:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin

  if not DataMod.Modul_Hak(cns_makine,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni makine yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;


//****************************************************************************//
  if not MainForm.FindChildFrm( Application, 'frmMakine') then
  begin
    Application.CreateForm (TfrmMakine,frmMakine);
    frmMakine.prv_CanUpdate := local_can_update;
    frmMakine.prv_CanDelete := local_can_delete;
  end
  else
  begin
    Application.MessageBox('makine formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
//****************************************************************************//



  frmMakine.DataSet_Open(MAKINE_ID,Islem);
end;


procedure TfrmMakine.DataSet_Open(MAKINE_ID:String;ISLEM:Byte);
begin
  if ((ISLEM = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmMakine do
  begin
    with qryMakine do
    begin
      Active := False;
      ParambyName('PRM_MAKINE_ID').AsString := MAKINE_ID;
      Active := True;
    end;
//****************************************************************************//
    prn_MAKINE_ID := MAKINE_ID;
//****************************************************************************//
    case Islem of
    0:
      begin
        qryMakine.Insert;
      end;
    1:
      begin
        qryMakine.Edit;
      end;
    end;
  end;//with
end;


procedure TfrmMakine.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMakine.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmMakine.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if qryMakine.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Makine bilgileri bölümünde yaptýðýnýz deðiþiklikleri kaydediniz veya iptal ediniz.','DÝKKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmMakine.btnYeniClick(Sender: TObject);
begin
  qryMakine.Append;
end;

procedure TfrmMakine.btnIPTALClick(Sender: TObject);
begin
  qryMakine.Cancel;
end;

procedure TfrmMakine.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qryMakine.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('MAKINE',0,0,0,0,2,'MAKINE');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

function TfrmMakine.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;


procedure TfrmMakine.btnAraClick(Sender: TObject);
var
  MAKINE_KOD,MAKINE_ADI:String;
begin
  if datamod.LS_MAkine(prn_MAKINE_ID,MAKINE_ADI) then
  begin
    DataSet_Open(prn_MAKINE_ID,1);
  end;
end;

procedure TfrmMakine.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmMakine.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.color :=clWindow;
end;

procedure TfrmMakine.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmMakine);
end;

procedure TfrmMakine.dstMakineStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
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
    end; }

    if Length(Trim(ADataset.FieldByName('MAK_KOD').AsString))<=0 then
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

procedure TfrmMakine.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;


function TfrmMakine.Form_Before_Post: Boolean;
begin
  Result := False;

  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu Modülde Deðiþiklik Yapma Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;


  if Trim(qryMakine.FieldByName('MAK_KOD').AsString) = ''  then
  begin
    IB_Edit1.SetFocus;
    Application.MessageBox('Makine Kodu Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    exit;
  end;

    if Trim(qryMakine.FieldByName('MAK_ADI').AsString)='' then
  begin
    IB_Edit2.SetFocus;
    Application.MessageBox('Makine Adýný boþ býrakamazsýnýz.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;


  with DataMod.qryGENEL do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) As GELEN FROM MAKINE WHERE MAK_KOD='
           + SQL_Katar(qryMakine.FieldByName('MAK_KOD').AsString));
    Active := True;
  end;

  if qryMakine.State = DssInsert then
  if (DataMod.qryGENEL.FieldByName('GELEN').AsInteger>0) then
  begin
    Application.MessageBox('Bu Makine Koddan Kayýt Yapýlmýþtýr. Farklý Bir Makine Kod Deneyiniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;

  if qryMakine.State = DssEdit then
  begin
    if qryMakine.FieldByName('MAK_KOD').OldAsString<>qryMakine.FieldByName('MAK_KOD').AsString then
    if (DataMod.qryGENEL.FieldByName('GELEN').AsInteger>=1) then
    begin
      Application.MessageBox('Bu Makine Koddan Kayýt Yapýlmýþtýr. Farklý Bir Makine Kod Deneyiniz.','Dikkat',MB_ICONWARNING);
      Abort;
    end;
  end;


  Result := True;
end;

procedure TfrmMakine.Form_Post;
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
    prn_MAKINE_ID := qryMakine.FieldByName('MAK_KOD').AsString;
//    prn_RECETE_SID := qrySiparis.FieldByName('RECETE_SID').AsSmallint;
//****************************************************************************//
    qryMakine.Post;
    //qryMakine.ApplyUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('MAKINE',0,0,0,0,1,'MAKINE');

//****************************************************************************//
//    if rgYAZICI.ItemIndex < 2 then Yazici.FATURA(prn_FATURA_ID,prn_FATURA_SID,rgYAZICI.ItemIndex);
    prn_MAKINE_ID := '';
    //prn_MAKINE_ID := 0;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
  //qryMakine.CommitUpdates;
end;


procedure TfrmMakine.qryMakineBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not DataMod.Post_Update('MAKINE',qryMakine.FieldByName('MAK_KOD').OldAsString,qryMakine.FieldByName('MAK_KOD').AsString,Nil) then Abort;
end;

procedure TfrmMakine.qryMakineBeforeDelete(IB_Dataset: TIB_Dataset);
var
  StrMesaj:String;
begin
  if DataMod.Delete_Control('MAKINE',qryMakine.FieldByName('MAK_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;

end;

procedure TfrmMakine.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmMakine.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmMakine.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmMakine.qryMakineAfterInsert(IB_Dataset: TIB_Dataset);
begin
     qryMakine.FieldByName('MAK_KOD').AsString := MakineNo(qryMakine.Gen_ID('GEN_MAKINE',1));
     qryMakine.FieldByName('MAK_SID').AsInteger:= Glb_SID;
end;


function TfrmMakine.MakineNo(Makine_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(Makine_SAYAC,TRIM(DataMod.GetParam(cns_Makine,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Makine,'KOD_LENGTH',0)));
end;

end.
