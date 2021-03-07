program BlobInserts;

uses
  Forms,
  FRM_BlobInserts in 'FRM_BlobInserts.pas' {frmBlobInserts};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBlobInserts, frmBlobInserts);
  Application.Run;
end.
