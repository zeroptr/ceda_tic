program Events;

uses
  Forms,
  FRM_Events in 'FRM_Events.pas' {frmEvents};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmEvents, frmEvents);
  Application.Run;
end.
