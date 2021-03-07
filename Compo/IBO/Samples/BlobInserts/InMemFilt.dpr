program InMemFilt;

uses
  Forms,
  Test in 'Test.pas' {frmBlobInserts};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBlobInserts, frmBlobInserts);
  Application.Run;
end.
