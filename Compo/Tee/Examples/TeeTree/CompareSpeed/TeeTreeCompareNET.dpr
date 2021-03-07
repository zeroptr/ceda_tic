program TeeTreeCompare;
{$I TeeDefs.inc}

{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\system.drawing.dll'}

uses
  Forms,
  UTreeCompare in 'UTreeCompare.pas' {Form1};

{$R *.RES}

{$IFDEF CLR}
[STAThread]
{$ENDIF}
begin
  Application.Initialize;
  Application.Title := 'TeeTree speed compared to TreeView';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
