program IBOQuery;

uses
  Forms,
  FRM_IBOQuery in 'FRM_IBOQuery.pas' {frmBlobInserts};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBlobInserts, frmBlobInserts);
  Application.Run;
end.
