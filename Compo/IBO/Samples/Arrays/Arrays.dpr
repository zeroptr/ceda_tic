program Arrays;

uses
  Forms,
  FRM_Arrays in 'FRM_Arrays.pas' {frmArrays};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmArrays, frmArrays);
  Application.Run;
end.
