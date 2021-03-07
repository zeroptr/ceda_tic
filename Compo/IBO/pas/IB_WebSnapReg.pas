unit
  IB_WebSnapReg;

interface

uses
  Classes, WebAdapt, IB_WebSnap;

  procedure Register;

implementation

procedure Register;
begin
  RegisterComponents( 'iboWebSnap', [ TIB_EndUserSessionAdapter ] );
end;

end.
