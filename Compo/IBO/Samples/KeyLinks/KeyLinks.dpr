program KeyLinks;

uses
  Forms,
  FRM_KeyLinks in 'FRM_KeyLinks.pas' {frmKeyLinks};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmKeyLinks, frmKeyLinks);
  Application.Run;
end.

