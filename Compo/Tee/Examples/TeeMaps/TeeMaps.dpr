program TeeMaps;
{$I TeeDefs.inc}

{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Drawing.dll'}
{%DelphiDotNetAssemblyCompiler 'c:\program files\common files\borland shared\bds\shared assemblies\2.0\Borland.Vcl.dll'}
{%DelphiDotNetAssemblyCompiler 'c:\program files\common files\borland shared\bds\shared assemblies\2.0\Borland.VclRtl.dll'}
{%DelphiDotNetAssemblyCompiler 'c:\program files\common files\borland shared\bds\shared assemblies\2.0\Borland.VclX.dll'}
{%DelphiDotNetAssemblyCompiler 'c:\program files\common files\borland shared\bds\shared assemblies\2.0\Borland.Delphi.dll'}

uses
  Forms,
  UnitTestSHP in 'UnitTestSHP.pas' {Form1};

{$R *.res}

{$IFDEF CLR}
[STAThread]
{$ENDIF}
begin
  Application.Initialize;
  Application.Title := 'TeeChart GIS / Mapping Example';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
