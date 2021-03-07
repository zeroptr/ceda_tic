program IB_RPL;

uses
  Forms,
  IBF_RPL in 'IBF_RPL.pas' {frmRPL},
  IB_RPL_Scripts in 'IB_RPL_Scripts.pas' {dmFTS_Scripts: TDataModule},
  IB_RPL_Meta in 'IB_RPL_Meta.pas',
  IB_RPL_Base in 'IB_RPL_Base.pas',
  IB_RPL_Sync in 'IB_RPL_Sync.pas',
  IBF_Base in 'IBF_Base.pas' {frmBase};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Simple Replication';
  Application.HelpFile := 'IB_RPL.hlp';
  Application.CreateForm(TfrmRPL, frmRPL);
  frmRPL.BaseKey := 'Software\CPS\Apps\RPL';
  Application.Run;
end.
