program Tutorial3;

uses
  Forms,
  formTutorial1 in 'formTutorial1.pas' {frmTutorial1},
  formTutorial2 in 'formTutorial2.pas' {frmTutorial2},
  formTutorial3 in 'formTutorial3.pas' {frmTutorial3};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTutorial3, frmTutorial3);
  Application.Run;
end.
