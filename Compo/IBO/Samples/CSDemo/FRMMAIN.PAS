 unit
  Frmmain;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  TFrmLauncher = class(TForm)
    BtnTrigg: TButton;
    BtnViews: TButton;
    BtnQrySP: TButton;
    BtnExecSP: TButton;
    BtnClose: TButton;
    BtnTrans: TButton;
    BtnMonitor: TButton;
    procedure BtnViewsClick(Sender: TObject);
    procedure BtnTriggClick(Sender: TObject);
    procedure BtnQrySPClick(Sender: TObject);
    procedure BtnExecSPClick(Sender: TObject);
    procedure BtnTransClick(Sender: TObject);
    procedure BtnMonitorClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLauncher: TFrmLauncher;

implementation

{$R *.DFM}

uses
  IBF_Monitor,

  DmCSDemo,

  FrmExeSP, { The Executable Stored Procedure Demo }
  FrmQrySP, { The Query Stored Procedure demo }
  FrmTrans, { The Transaction Editing demo }
  FrmTrigg, { The Trigger Demo }
  FrmViews; { The View Demo }

procedure TFrmLauncher.BtnViewsClick(Sender: TObject);
begin
  if FrmViewDemo = nil then
    FrmViewDemo := TFrmViewDemo.Create( Application );
  FrmViewDemo.ShowModal;
end;

procedure TFrmLauncher.BtnTriggClick(Sender: TObject);
begin
  if FrmTriggerDemo = nil then
    FrmTriggerDemo := TFrmTriggerDemo.Create( Application );
  FrmTriggerDemo.ShowModal;
end;

procedure TFrmLauncher.BtnQrySPClick(Sender: TObject);
begin
  if FrmQueryProc = nil then
    FrmQueryProc := TFrmQueryProc.Create( Application );
  FrmQueryProc.ShowModal;
end;

procedure TFrmLauncher.BtnExecSPClick(Sender: TObject);
begin
  if FrmExecProc = nil then
    FrmExecProc := TFrmExecProc.Create( Application );
  FrmExecProc.ShowModal;
end;

procedure TFrmLauncher.BtnTransClick(Sender: TObject);
begin
  if FrmTransDemo = nil then
    FrmTransDemo := TFrmTransDemo.Create( Application );
  FrmTransDemo.ShowModal;
end;

procedure TFrmLauncher.BtnMonitorClick(Sender: TObject);
begin
// Launch an instance of the IB Objects trace monitor.
  with TfrmMonitor.Create( Application ) do
  begin
    BaseKey := 'Software\Apps\CSDemo\Monitor';
    Show;
  end;
end;

procedure TFrmLauncher.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmLauncher.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
// Make sure that the transaction is resolved.
  CanClose := DmEmployee.cnEmployee.CloseWithConfirm = mrOk;
end;

end.
