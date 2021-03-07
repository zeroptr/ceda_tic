program Tutorial5;

uses
  Forms,
  formTutorial1 in 'formTutorial1.pas' {frmTutorial1},
  formTutorial2 in 'formTutorial2.pas' {frmTutorial2},
  formTutorial3 in 'formTutorial3.pas' {frmTutorial3},
  formTutorial4 in 'formTutorial4.pas' {frmTutorial4},
  formTutorial5 in 'formTutorial5.pas' {frmTutorial5};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTutorial5, frmTutorial5);
  Application.Run;
end.
