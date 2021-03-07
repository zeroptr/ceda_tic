unit ufrmGelis_Neden;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IB_Components, Buttons, StdCtrls, Mask, IB_Controls,Variants;

type
  TfrmGelis_Neden = class(TForm)
    Panel1: TPanel;
    qry_Gelis_Nedeni: TIB_Query;
    dts_Gelis_Nedeni: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qry_Gelis_NedeniAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qry_Gelis_NedeniBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dts_Gelis_NedeniStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qry_Gelis_NedeniBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;NEDEN_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(NEDEN_KOD:String;ISLEM_TIP:Byte);
    function GelNedenNo(NEDEN_SAYAC:INTEGER):String;
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

  const cns_Gelis_Nedeni = 66;

var
  frmGelis_Neden: TfrmGelis_Neden;

implementation

uses unDataMod,Main,unFunc, unLogger;

{$R *.DFM}

procedure TfrmGelis_Neden.Form_Open(Menu:Boolean;NEDEN_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Gelis_Nedeni,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu modülde yeni Geliþ Nedeni tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
  if not MainForm.FindChildFrm(Application, 'frmGelis_Neden') then
  begin
    Application.CreateForm(TfrmGelis_Neden, frmGelis_Neden);
    with frmGelis_Neden do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(NEDEN_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Geliþ Nedeni formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
end;

procedure TfrmGelis_Neden.DataSet_Open(NEDEN_KOD:String;ISLEM_TIP:Byte);
begin
  with qry_Gelis_Nedeni do
  begin
    Active := False;
    ParamByName('PRM_NEDEN_KOD').AsString := NEDEN_KOD;
    Active := True;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qry_Gelis_Nedeni.Edit;
    end;
  1://insert
    begin
      qry_Gelis_Nedeni.Insert;
    end;
  end;
end;

procedure TfrmGelis_Neden.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmGelis_Neden.qry_Gelis_NedeniAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_Gelis_Nedeni do
  begin
    FieldByName('NEDEN_SID').AsInteger := glb_SID;
    FieldByName('NEDEN_KOD').AsString := GelNedenNo(Int64(DataMod.GET_SAYAC_NUM('GEL_NEDEN',True,False,0)));
  end;
  IB_Edit1.SetFocus;
end;

procedure TfrmGelis_Neden.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmGelis_Neden.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmGelis_Neden.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmGelis_Neden.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmGelis_Neden.qry_Gelis_NedeniBeforeDelete(IB_Dataset: TIB_Dataset);
var
 StrMesaj:String;
begin
  if DataMod.Delete_Control('SRV_GELIS_NEDENI',qry_Gelis_Nedeni.FieldByName('NEDEN_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmGelis_Neden.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Gelis_Nedeni.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qry_Gelis_Nedeni.Active := False;
    qry_Gelis_Nedeni.Active := False;
  end;
end;

procedure TfrmGelis_Neden.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmGelis_Neden);
end;

function TfrmGelis_Neden.GelNedenNo(NEDEN_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(NEDEN_SAYAC,TRIM(DataMod.GetParam(cns_Gelis_Nedeni,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Gelis_Nedeni,'KOD_LENGTH',0)));
end;

procedure TfrmGelis_Neden.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGelis_Neden.btnAraClick(Sender: TObject);
var
  NEDEN_KOD,NEDEN_AD:String;
begin
  if DataMod.LS_Gelis_Nedeni(NEDEN_KOD,NEDEN_AD) then
  begin
    DataSet_Open(NEDEN_KOD,0);
  end;
end;

procedure TfrmGelis_Neden.dts_Gelis_NedeniStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
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

procedure TfrmGelis_Neden.qry_Gelis_NedeniBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_Gelis_Nedeni,'SRV_GELIS_NEDENI','NEDEN_KOD,ACIKLAMA','NEDEN_KOD');
  if funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('SRV_GELIS_NEDENI',qry_Gelis_Nedeni.FieldByName('NEDEN_KOD').OldAsString,qry_Gelis_Nedeni.FieldByName('NEDEN_KOD').AsString,Nil) then Abort;
end;

procedure TfrmGelis_Neden.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni Gelis Nedeni tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmGelis_Neden.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Gelis_Nedeni.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_GELIS_NEDENI,',0,0,0,0,1,'SRV_GELIS_NEDENI');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmGelis_Neden.btnIPTALClick(Sender: TObject);
begin
  qry_Gelis_Nedeni.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmGelis_Neden.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Gelis_Nedeni.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_GELIS_NEDENI,',0,0,0,0,2,'SRV_GELIS_NEDENI');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmGelis_Neden.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

function TfrmGelis_Neden.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmGelis_Neden.Form_Before_Post: Boolean;
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
