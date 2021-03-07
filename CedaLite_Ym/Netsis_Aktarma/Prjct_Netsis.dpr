program Prjct_Netsis;

uses
  Forms,
  UMain in 'UMain.pas' {FrmMain},
  NetOpenX_TLB in 'NetOpenX_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
