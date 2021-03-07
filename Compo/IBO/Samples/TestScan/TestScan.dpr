program TestScan;

uses
  Forms,
  FRM_TestScan in 'FRM_TestScan.pas' {frmTestScan};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTestScan, frmTestScan);
  Application.Run;
end.
