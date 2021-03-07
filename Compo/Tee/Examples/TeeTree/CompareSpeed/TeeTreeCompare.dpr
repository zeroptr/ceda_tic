program TeeTreeCompare;
{$I TeeDefs.inc}

uses
  {$IFNDEF CLX}
  Forms,
  {$ELSE}
  QForms,
  {$ENDIF}
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
