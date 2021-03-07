program Prjct_Yedekleme;

uses
  Forms,
  UAna in 'UAna.pas' {Form1},
  Un_Kul_Con_Fb in 'Un_Kul_Con_Fb.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
