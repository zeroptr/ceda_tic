unit ufrmDovTan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_UpdateBar, ExtCtrls, StdCtrls, Buttons, Grids, IB_Grid, IB_Components;

type
  TfrmDovTan = class(TForm)
    Panel1: TPanel;
    IB_UpdateBar1: TIB_UpdateBar;
    qry_DovTan: TIB_Query;
    dts_DovTan: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    btnExit: TBitBtn;
    procedure btnExitClick(Sender: TObject);
    procedure qry_DovTanAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qry_DovTanBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qry_DovTanBeforePost(IB_Dataset: TIB_Dataset);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menu:Boolean):Integer;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure qry_DovTanAfterPost(IB_Dataset: TIB_Dataset);
    procedure qry_DovTanAfterCancel(IB_Dataset: TIB_Dataset);
    procedure qry_DovTanAfterDelete(IB_Dataset: TIB_Dataset);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    prv_CanUpdate,prv_CanDelete:Boolean;
    prv_ISLEM : Boolean;
  public
    { Public declarations }
  end;
  const cns_dovtan = 1;
var
  frmDovTan: TfrmDovTan;

implementation
uses unFunc,Main,unDataMod, unLogger;
{$R *.DFM}
function TfrmDovTan.Form_Open(Menu:Boolean):Integer;
var
  local_can_update,local_can_delete : Boolean;
begin
  Result := 1;
  if not DataMod.Modul_Hak(cns_dovtan,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not Mainform.FindChildFrm( Application, 'frmDovTan') then
    begin
      Application.CreateForm(TfrmDovTan, frmDovTan);
    end
    else
    begin
      Application.MessageBox('Döviz tanýmlama formu açýk.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    with frmDovTan do
    begin
      qry_DovTan.Active := True;
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
    end;
  end;
end;

procedure TfrmDovTan.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDovTan.qry_DovTanAfterInsert(IB_Dataset: TIB_Dataset);
begin
  qry_DovTan.FieldByName('TAKIP').AsInteger := 0;
end;

procedure TfrmDovTan.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmDovTan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataMod.LoadDovizLists;
  Action := caFree;
end;

function TfrmDovTan.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmDovTan.Form_Before_Post: Boolean;
begin
  Result := False;
//****************************************************************************//
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  //****************************************************************************//



  if Trim(qry_DovTan.FieldByName('DOVKOD').AsString) = '' then
  begin
    Application.MessageBox('Döviz kodu sahasý boþ olamaz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(qry_DovTan.FieldByName('DOVKOD').OldAsString) = 'YTL' then
  begin
    Application.MessageBox('Bu Döviz Kodunu Deðiþtiremezsiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;


  if Trim(qry_DovTan.FieldByName('DOVKOD').OldAsString) = 'TRL' then
  begin
    Application.MessageBox('Bu Döviz Kodunu Deðiþtiremezsiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

//****************************************************************************//
  Result := True;
end;

procedure TfrmDovTan.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
  if key = #27 then
  begin
    if btnExit.Enabled then btnExitClick(Self);
  end;
end;

procedure TfrmDovTan.qry_DovTanBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    Abort;
  end;
  if not DataMod.Post_Update('DOVKART',qry_DovTan.FieldByName('DOVKOD').OldAsString,qry_DovTan.FieldByName('DOVKOD').AsString,Nil) then Abort;
  if prv_ISLEM then
     dmLOGGER.dbaMain_StartMonitoring;
end;

procedure TfrmDovTan.qry_DovTanAfterPost(IB_Dataset: TIB_Dataset);
var qryExecuter:TIB_Query;
begin
  qry_DovTan.UpdateData;
  if IB_Dataset.FieldByName('VPB').AsInteger = 1 then
  begin
    DataMod.CreateQuery(qryExecuter,nil,False,DataMod.dbaMain);
    qryExecuter.SQL.Add('UPDATE DOVKART SET VPB = 0 WHERE DOVKOD <> ' + SQL_Katar(IB_Dataset.FieldByName('DOVKOD').AsString));
    qryExecuter.Execute;
    qry_DovTan.RefreshAll;
  end;
  if prv_ISLEM then
     dmLOGGER.dbaMain_StopMonitoringWrite2log('DOVKART,',0,0,0,0,1,'DOVKART');
end;

procedure TfrmDovTan.qry_DovTanAfterCancel(IB_Dataset: TIB_Dataset);
begin
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmDovTan.qry_DovTanBeforeDelete(IB_Dataset: TIB_Dataset);
var
  strMesaj:String;
begin
  if not Form_Before_Delete then Abort;
  if DataMod.Delete_Control('DOVKART',qry_DovTan.FieldByName('DOVKOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  dmLOGGER.dbaMain_StartMonitoring;
  prv_ISLEM := False;
end;


procedure TfrmDovTan.qry_DovTanAfterDelete(IB_Dataset: TIB_Dataset);
begin
  dmLOGGER.dbaMain_StopMonitoringWrite2log('DOVKART,',0,0,0,0,2,'DOVKART');
  prv_ISLEM := True;
end;

end.
