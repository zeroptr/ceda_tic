program Mdiapp;

uses
  Forms,
  Main in 'MAIN.PAS' {MainForm},
  Form_Order in 'Form_Order.pas' {frmOrder},
  Form_Employee in 'Form_Employee.pas' {frmEmployee},
  Form_Customer in 'Form_Customer.pas' {frmCustomer};

{$R *.RES}

begin
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfrmEmployee, frmEmployee);
  Application.CreateForm(TfrmOrder, frmOrder);
  Application.CreateForm(TfrmCustomer, frmCustomer);
  Application.Run;
end.
