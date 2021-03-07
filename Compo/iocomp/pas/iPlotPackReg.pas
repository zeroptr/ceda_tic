{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotPackReg;{$endif}
{$ifdef iCLX}unit QiPlotPackReg;{$endif}

interface

uses
{$I iIncludeUses.inc}

{$IFDEF iVCL}{$ENDIF}
{$IFDEF iCLX}{$ENDIF}

{$ifdef iVCL}
  iPlot,
  iScope,
  iXYPlot;
{$endif}

{$ifdef iCLX}
  QiPlot,
  QiScope,
  QiXYPlot;
{$endif}

procedure Register;

implementation
//****************************************************************************************************************************************************
procedure Register;
begin
  RegisterComponents('Iocomp Plot', [TiPlot]);
  RegisterComponents('Iocomp Plot', [TiScope]);
  RegisterComponents('Iocomp Plot', [TiXYPlot]);
end;
//****************************************************************************************************************************************************
end.
