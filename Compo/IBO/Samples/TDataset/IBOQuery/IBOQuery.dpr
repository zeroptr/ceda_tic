program
  IBOQuery;

uses
  Forms,
  FRM_IBOQuery in 'FRM_IBOQuery.pas' {frmIBOQuery},
  IBF_Base in '..\..\..\IBF_Base.pas' {frmBase};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmIBOQuery, frmIBOQuery);
  frmIBOQuery.BaseKey := 'Software\Apps\Proj_DBGrid';
  Application.Run;
end.
