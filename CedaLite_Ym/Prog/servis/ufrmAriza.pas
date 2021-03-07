unit ufrmAriza;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IB_Components, Buttons, StdCtrls, Mask, IB_Controls,Variants;

type
  TfrmAriza = class(TForm)
    Panel1: TPanel;
    qry_Ariza: TIB_Query;
    dts_Ariza: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qry_ArizaAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qry_ArizaBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dts_ArizaStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qry_ArizaBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;ARIZA_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(ARIZA_KOD:String;ISLEM_TIP:Byte);
    function ArizaNo(ARIZA_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;

  public
    { Public declarations }
  end;

  const cns_Ariza = 62;

var
  frmAriza: TfrmAriza;

implementation

uses unDataMod,Main,unFunc, unLogger;

{$R *.DFM}

procedure TfrmAriza.Form_Open(Menu:Boolean;ARIZA_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Ariza,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni Arýza tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
  if not MainForm.FindChildFrm(Application, 'frmAriza') then
  begin
    Application.CreateForm(TfrmAriza, frmAriza);
    with frmAriza do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(ARIZA_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Arýza formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
end;

procedure TfrmAriza.DataSet_Open(ARIZA_KOD:String;ISLEM_TIP:Byte);
begin
  with qry_Ariza do
  begin
    Active := False;
    ParamByName('PRM_ARIZA_KOD').AsString := ARIZA_KOD;
    Active := True;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qry_Ariza.Edit;
    end;
  1://insert
    begin
      qry_Ariza.Insert;
    end;
  end;
end;


procedure TfrmAriza.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmAriza.qry_ArizaAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_Ariza do
  begin
    FieldByName('ARIZA_SID').AsInteger := glb_SID;
    FieldByName('ARIZA_KOD').AsString := ArizaNo(Int64(DataMod.GET_SAYAC_NUM('ARIZA',True,False,0)));
  end;
  IB_Edit1.SetFocus;
end;

procedure TfrmAriza.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmAriza.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmAriza.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmAriza.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmAriza.qry_ArizaBeforeDelete(IB_Dataset: TIB_Dataset);
var
 StrMesaj:String;
begin
  if DataMod.Delete_Control('SRV_ARIZA_TIP',qry_Ariza.FieldByName('ARIZA_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmAriza.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Ariza.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qry_Ariza.Active := False;
    qry_Ariza.Active := False;
  end;
end;

procedure TfrmAriza.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmAriza);
end;

function TfrmAriza.ArizaNo(ARIZA_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(ARIZA_SAYAC,TRIM(DataMod.GetParam(cns_Ariza,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Ariza,'KOD_LENGTH',0)));
end;

procedure TfrmAriza.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAriza.btnAraClick(Sender: TObject);
var
  ARIZA_KOD,ARIZA_AD:String;
begin
  if DataMod.LS_Ariza(ARIZA_KOD,ARIZA_AD) then
  begin
    DataSet_Open(ARIZA_KOD,0);
  end;
end;

procedure TfrmAriza.dts_ArizaStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
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
    if not ((ADataset.Eof) and (ADataset.Bof)) then btnSil.Enabled := True
    else btnSil.Enabled := False;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmAriza.qry_ArizaBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_Ariza,'SRV_ARIZA_TIP','ARIZA_KOD,ACIKLAMA','ARIZA_KOD');
  if funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('SRV_ARIZA_TIP',qry_Ariza.FieldByName('ARIZA_KOD').OldAsString,qry_Ariza.FieldByName('ARIZA_KOD').AsString,Nil) then Abort;
end;

procedure TfrmAriza.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni Arýza tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmAriza.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Ariza.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARIZA_TIP,',0,0,0,0,1,'SRV_ARIZA_TIP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmAriza.btnIPTALClick(Sender: TObject);
begin
  qry_Ariza.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmAriza.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Ariza.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARIZA_TIP,',0,0,0,0,2,'SRV_ARIZA_TIP');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmAriza.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

function TfrmAriza.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmAriza.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

end.
