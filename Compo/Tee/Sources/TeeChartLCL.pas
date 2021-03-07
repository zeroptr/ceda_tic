{ This file was automatically created by Lazarus. Do not edit!
This source is only used to compile and install the package.
 }

unit TeeChartLCL; 

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
