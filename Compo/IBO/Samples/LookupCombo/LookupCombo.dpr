program LookupCombo;

uses
  Forms,
  FRM_LookupCombo in 'FRM_LookupCombo.pas' {frmLkCmb};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLkCmb, frmLkCmb);
  Application.Run;
end.
