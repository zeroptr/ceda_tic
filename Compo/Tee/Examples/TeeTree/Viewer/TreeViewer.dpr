program TreeViewer;
{$I TeeDefs.inc}

uses
  {$IFNDEF CLX}
  Forms,
  {$ELSE}
  QForms,
  {$ENDIF}
  UTreeViewer in 'UTreeViewer.pas' {Viewer},
  TreeNavigator in '..\TreeNavigator.pas';

{$IFNDEF CLR}
{$R *.RES}
{$ENDIF}

{$IFDEF CLR}
[STAThread]
{$ENDIF}
begin
  Application.Title := 'TeeTree v2 Viewer';
  Application.CreateForm(TViewer, Viewer);
  Application.Run;
end.
