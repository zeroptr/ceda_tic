unit HAR_FUNCS;

interface
uses unDataMod,unFUNC,unINTEGRATION,IB_Components,Windows, Messages, SysUtils,Controls;
  type
    THAR_FUNCS=Class(TObject);
     Function DELETE_HARS_FROM_A_DATE(THE_DATE:TDate):Boolean;

   end;
implementation

Function THAR_FUNCS.DELETE_HARS_FROM_A_DATE(THE_DATE:TDate):Boolean;
var  trnISLEM:TIB_Transaction;
     qryBELGE,qryBELGE_D:TIB_Query;
begin
  try
    trnISLEM := TIB_Transaction.Create(Self);

  finally
    qryBELGE.Close;
    qryBELGE_D.Close;
    qryBELGE.Free;
    qryBELGE_D.Free;
    trnISLEM.Free;
  end;
end;

end.
