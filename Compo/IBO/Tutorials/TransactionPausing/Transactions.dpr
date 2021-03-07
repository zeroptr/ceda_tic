program Transactions;

uses
  Forms,
  MainForm in 'MainForm.pas' {TransactionMainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := '';
  Application.Title := 'Transaction Demonstration';
  Application.CreateForm(TTransactionMainForm, TransactionMainForm);
  Application.Run;
end.
