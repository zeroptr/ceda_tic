program BrowseItems;

uses
  Forms,
  BrItems in 'BrItems.pas' {frmBrItems};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBrItems, frmBrItems);
  Application.Run;
end.
