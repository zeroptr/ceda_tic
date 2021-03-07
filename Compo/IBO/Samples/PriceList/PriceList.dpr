program PriceList;

uses
  Forms,
  FRM_PriceList in 'FRM_PriceList.pas' {frmPriceList};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPriceList, frmPriceList);
  Application.Run;
end.
