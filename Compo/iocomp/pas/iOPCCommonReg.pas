{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCCommonReg;{$endif}
{$ifdef iCLX}unit QiOPCCommonReg;{$endif}

interface

uses
{$I iIncludeUses.inc}

{$IFDEF iVCL}{$ENDIF}
{$IFDEF iCLX}{$ENDIF}

{$ifdef iVCL}
  iOPCManager;
{$endif}

{$ifdef iCLX}
  QiOPCManager;
{$endif}

procedure Register;

implementation
//****************************************************************************************************************************************************
procedure Register;
begin
  RegisterComponents('Iocomp OPC', [TiOPCManager]);
end;
//****************************************************************************************************************************************************
end.
