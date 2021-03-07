program Threads;

uses
  Forms,
  FRM_Threads in 'FRM_Threads.pas' {frmThreads},
  DM_Threads in 'DM_Threads.pas' {dmThreads: TDataModule},
  UN_Threads in 'UN_Threads.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmThreads, frmThreads);
  Application.Run;
end.
