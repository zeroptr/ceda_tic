unit ufrmISN_ERRORS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, IB_Grid, IB_Components;

type
  TfrmISN_ERRORS = class(TForm)
    qryISN_ERRORS: TIB_Query;
    dtsISN_ERRORS: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    Function AnyErr(Transaction:TIB_Transaction;ISN:Integer;Silent:Byte):Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmISN_ERRORS: TfrmISN_ERRORS;

implementation

{$R *.DFM}
USES UNDATAMOD;
procedure TfrmISN_ERRORS.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

Function TfrmISN_ERRORS.AnyErr(Transaction:TIB_Transaction;ISN:Integer;Silent:Byte):Boolean;
//Transaction Nil gelirse default transactionu kullanýr.
//silent 0 gelirse hata mesajý gösterir
//silent 1 gelirse hata mesajý göstermez
begin
  with qryISN_ERRORS do
  begin
    Active := False;
    if Transaction <> nil then
    begin
      IB_Transaction := Transaction;
    end;
    ParamByName('PRM_ISN').AsInteger := ISN;
    Active := True;
    if qryISN_ERRORS.RecordCount = 0 then
       Result:= False  // Hata yok
    else begin
       Result:= True; // Hata var
       if silent = 0 then frmISN_ERRORS.ShowModal;
       Active := False;
       qryISN_ERRORS.ExecuteImmediate('UPDATE ISN_ERRORS SET OKUNDU = 1 WHERE ISN = '+ IntToStr(ISN),Nil);
    end; // if end
  end; //with end
end;
end.
