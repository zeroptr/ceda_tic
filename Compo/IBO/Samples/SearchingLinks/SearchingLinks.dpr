program SearchingLinks;

uses
  Forms,
  MAINFORM in 'MAINFORM.pas' {frmSearchingLinks};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSearchingLinks, frmSearchingLinks);
  Application.Run;
end.
