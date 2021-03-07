program MasterDetail;

uses
  Forms,
  FRM_MasterDetail in 'FRM_MasterDetail.pas' {frmMasterDetail};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MasterLinks';
  Application.CreateForm(TfrmMasterDetail, frmMasterDetail);
  Application.Run;
end.
