program IB_FTS;

uses
  Forms,
  IBF_FTS in 'IBF_FTS.pas' {frmFTS},
  IB_FTS_Search in 'IB_FTS_Search.pas',
  IBF_Base in 'IBF_Base.pas' {frmBase},
  IB_FTS_Scripts in 'IB_FTS_Scripts.pas' {dmFTS_Scripts: TDataModule},
  IB_FTS_Meta in 'IB_FTS_Meta.pas',
  IB_FTS_Base in 'IB_FTS_Base.pas',
  IB_FTS_Sync in 'IB_FTS_Sync.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Full Text Search';
  Application.CreateForm(TfrmFTS, frmFTS);
  frmFTS.BaseKey := 'Software\CPS\Apps\FTS';
  Application.Run;
end.
