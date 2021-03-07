program Tutorial6;

uses
  Forms,
  formTutorial1 in 'formTutorial1.pas' {frmTutorial1},
  formTutorial2 in 'formTutorial2.pas' {frmTutorial2},
  formTutorial3 in 'formTutorial3.pas' {frmTutorial3},
  formTutorial4 in 'formTutorial4.pas' {frmTutorial4},
  formTutorial5 in 'formTutorial5.pas' {frmTutorial5},
  formTutorial6 in 'formTutorial6.pas' {frmTutorial6};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTutorial6, frmTutorial6);
  Application.Run;
end.
