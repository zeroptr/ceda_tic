program Prjct_Update;

uses
  Forms,
  ufrm_update in 'ufrm_update.pas' {frm_update};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_update, frm_update);
  Application.Run;
end.
