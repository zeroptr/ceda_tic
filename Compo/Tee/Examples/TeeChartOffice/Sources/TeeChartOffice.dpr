program TeeChartOffice;
{$I TeeDefs.inc}

{$DEFINE TEEENTERPRISE}

{%DotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Windows.Forms.dll'}

uses
  {$IFDEF CLX}
  QForms,
  {$ELSE}
  Forms,
  {$ENDIF}
  SysUtils,
  UnitChartOffice in 'UnitChartOffice.pas',
  TeeChartOfficeConstants in 'TeeChartOfficeConstants.pas',
  TeeCommanderEditor in 'TeeCommanderEditor.pas',
  TeeConfig in 'TeeConfig.pas',
  TeeHighLight in 'TeeHighLight.pas',
  TeeOfficeConstants in 'TeeOfficeConstants.pas',
  TeeRecentFiles in 'TeeRecentFiles.pas',
  TeeUpdateVersion in 'TeeUpdateVersion.pas',
  TeeWebGallery in 'TeeWebGallery.pas';

{$IFDEF D10}
{$R TeeChartOffice_D10.res}
{$ELSE}
{$R *.res}
{$ENDIF}

{$IFDEF CLR}
[StaThread]
{$ENDIF}
begin
  Application.Initialize;
  Application.Title := 'TeeChart Office';

  {$IFDEF D105}
  Application.MainFormOnTaskbar := True;
  {$ENDIF}

  Application.CreateForm(TMainForm, MainForm);
  TrimWorkingSet;
  Application.Run;
end.
