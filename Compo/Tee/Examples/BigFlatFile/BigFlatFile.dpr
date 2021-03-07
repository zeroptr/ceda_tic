program BigFlatFile;

{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Drawing.dll'}
{%DelphiDotNetAssemblyCompiler 'Steema.TeeChart.VCL.dll'}

uses
  Forms,
  UBigFlatFile in 'UBigFlatFile.pas' {Form1},
  TeeDataSubset in 'TeeDataSubset.pas',
  TeeCreateFlatFile in 'TeeCreateFlatFile.pas' {FormCreateFile},
  TeeAxisScroll in 'TeeAxisScroll.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
