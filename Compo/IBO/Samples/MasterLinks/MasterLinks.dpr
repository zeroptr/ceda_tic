program MasterLinks;

uses
  Forms,
  FRM_MasterLinks in 'FRM_MasterLinks.pas' {frmMasterLinks};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MasterLinks';
  Application.CreateForm(TfrmMasterLinks, frmMasterLinks);
  Application.Run;
end.
