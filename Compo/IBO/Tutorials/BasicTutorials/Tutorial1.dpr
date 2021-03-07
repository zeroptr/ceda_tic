program Tutorial1;

uses
  Forms,
  formTutorial1 in 'formTutorial1.pas' {frmTutorial1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTutorial1, frmTutorial1);
  Application.Run;
end.
