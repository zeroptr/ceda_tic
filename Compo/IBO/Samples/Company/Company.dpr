program Company;

uses
  Forms,
  FRM_Company in 'FRM_Company.pas' {frmCompany},
  FRM_Employee in 'FRM_Employee.pas' {frmEmployee};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCompany, frmCompany);
  Application.Run;
end.
