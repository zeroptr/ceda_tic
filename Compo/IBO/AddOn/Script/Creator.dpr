program Creator;

uses
  Forms,
  cr_main in 'cr_main.pas' {frmCreatorMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCreatorMain, frmCreatorMain);
  Application.Run;
end.
