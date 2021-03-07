program OADemo;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  CstmBln in 'CstmBln.pas' {CustomBalloon};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Office 97 Assistant Package for Delphi - Demo';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TCustomBalloon, CustomBalloon);
  Application.Run;
end.
