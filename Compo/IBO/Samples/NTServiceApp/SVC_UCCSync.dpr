program
  SVC_UCCSync;

uses
  IB_Session511,
  SvcMgr,
  DM_UCCSync in 'DM_UCCSync.pas' {svcUCCSync: TService},
  IBS_Base in '..\..\Comps\IBO4\IBS_Base.pas' {svcBase: TService},
  IB_LogFiles in '..\..\Comps\IBO4\IB_LogFiles.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TsvcUCCSync, svcUCCSync);
  Application.Run;
end.
