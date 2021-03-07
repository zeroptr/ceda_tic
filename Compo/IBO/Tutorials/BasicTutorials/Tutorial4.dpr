program Tutorial4;

uses
  Forms,
  formTutorial1 in 'formTutorial1.pas' {frmTutorial1},
  formTutorial2 in 'formTutorial2.pas' {frmTutorial2},
  formTutorial3 in 'formTutorial3.pas' {frmTutorial3},
  formTutorial4 in 'formTutorial4.pas' {frmTutorial4};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTutorial4, frmTutorial4);
  Application.Run;
end.
