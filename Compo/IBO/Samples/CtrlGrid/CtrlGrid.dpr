program CtrlGrid;

uses
  Forms,
  FRM_CGrid in 'FRM_CGrid.pas' {frmCGrid};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCGrid, frmCGrid);
  Application.Run;
end.
