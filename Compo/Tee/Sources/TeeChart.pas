{ Aquest fitxer l'ha creat autom�ticament el Lazarus. No l'editeu!
Aquesta font nom�s s'utilitza per compilar i instal�lar el paquet.
 }

unit TeeChart; 

interface

uses
  TeeChartReg, TeeChartPro, LazarusPackageIntf; 

implementation

procedure Register; 
begin
  RegisterUnit('TeeChartReg', @TeeChartReg.Register); 
  RegisterUnit('TeeChartPro', @TeeChartPro.Register); 
end; 

initialization
  RegisterPackage('TeeChart', @Register); 
end.
