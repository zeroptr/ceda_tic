program Blr;

uses
  Forms,
  FRM_BLR in 'FRM_BLR.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
