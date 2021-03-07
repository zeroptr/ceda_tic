program TransOAT;

uses
  Forms,
  FRM_TransOAT in 'FRM_TransOAT.pas' {frmOAT},
  FRM_Dataset in 'FRM_Dataset.pas' {frmDataset};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmOAT, frmOAT);
  Application.Run;
end.
