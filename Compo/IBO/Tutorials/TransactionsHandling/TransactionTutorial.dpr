program TransactionTutorial;

uses
  Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  UdmMain in 'UdmMain.pas' {dmMain: TDataModule},
  UdmLesson1 in 'UdmLesson1.pas' {dmLesson1: TDataModule},
  UdmLesson2 in 'UdmLesson2.pas' {dmLesson2: TDataModule},
  UdmLesson3 in 'UdmLesson3.pas' {dmLesson3: TDataModule},
  UdmLesson4 in 'UdmLesson4.pas' {dmLesson4: TDataModule},
  UdmLesson5 in 'UdmLesson5.pas' {dmLesson5: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TdmLesson1, dmLesson1);
  Application.CreateForm(TdmLesson2, dmLesson2);
  Application.CreateForm(TdmLesson3, dmLesson3);
  Application.CreateForm(TdmLesson4, dmLesson4);
  Application.CreateForm(TdmLesson5, dmLesson5);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
