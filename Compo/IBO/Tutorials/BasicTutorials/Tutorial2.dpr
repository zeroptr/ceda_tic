program Tutorial2;

uses
  Forms,
  formTutorial1 in 'formTutorial1.pas' {frmTutorial1},
  formTutorial2 in 'formTutorial2.pas' {frmTutorial2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTutorial2, frmTutorial2);
  Application.Run;
end.
