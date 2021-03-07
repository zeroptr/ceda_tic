program TeeHouse;
{$I TeeDefs.inc}

uses
  {$IFDEF CLX}
  QForms,
  {$ELSE}
  Forms,
  {$ENDIF}
  UnitTeeHouse in 'UnitTeeHouse.pas' {Form1};

{$R *.RES}

{$IFDEF CLR}
[STAThread]
{$ENDIF}
begin
  Application.Initialize;
  Application.Title := 'TeeHouse';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
