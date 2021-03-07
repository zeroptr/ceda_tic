{=================================================================================================

NewLook Mathematical Utilities

Copyright (c) 1997, 1998 NewLook Through Old Windows Limited - www.newlook.co.nz

Authors: Paul Heinz & Ian Farquharson

Version History
01/10/96	1.00	PMH		Converted from TopSpeed ASM and first released to the team
03/10/97	1.01	PMH		Improved by further conversion of Delphi to inline ASM
01/01/98	1.02	PMH		Fixed issue with non-DWORD aligned stack abd Delphi exceptions
23/01/98	1.03	PMH		Grand revision and renaming to uMathUtils.pas and uConsts.pas
11/02/98	1.04	IRF		Added Min and Max functions
	
=================================================================================================}

unit uMathUtils;

interface

{ Returns the appropriate value }
function Min(Value1, Value2: Integer): Integer;
function Max(Value1, Value2: Integer): Integer;

{ Compares two numbers for less than with specified number of decimal places }
function LessReal(Value1, Value2: Extended; Places: Cardinal): Boolean;

{ Compares two numbers for equality with specified number of decimal places }
function EqualReal(Value1, Value2: Extended; Places: Cardinal): Boolean;

{ Compares two numbers for greater than with specified number of decimal places }
function GreatReal(Value1, Value2: Extended; Places: Cardinal): Boolean;

{  Note: Financial rounding i.e. Round( x ) = -Round( -x ) }

{ Rounds up to largest whole number e.g. 1.1 => 2.0 }
function RoundUp(Value: Extended; Places: Cardinal): Extended;

{ Rounds downs to smallest whole number i.e. 1.9 => 1.0 }
function RoundDown(Value: Extended; Places: Cardinal): Extended;

{ Rounds to nearest whole number with exact .5 up i.e. 1.5 => 2.0 }
function RoundNear(Value: Extended; Places: Cardinal): Extended;

{ Rounds to nearest whole number with exact .5 down i.e. 1.5 => 1.0 }
function RoundHalf(Value: Extended; Places: Cardinal): Extended;
{ Largely for NZ counter-intuitive GST rounding }

{ Rounds to nearest whole number with exact .5 either up or down  }
function RoundBool(Value: Extended; Places: Cardinal; HalfDown: Boolean): Extended;

{ Scales up floating point Value into whole integer Value  }
function ScaleUp(Value: Extended; Places: Cardinal): Integer;

{ Scales down whole integer Value into floating point Value }
function ScaleDown(Value: Integer; Places: Cardinal): Extended;

{ Checks double for valid values for 52-bit integer }
function ValidInt52(Value: Double): Boolean;

implementation

uses SysUtils, uConsts;

const
	NearCW: Word = $133F;
	FloorCW: Word = $173F;
	CeilCW: Word = $1B3F;
  TruncCW: Word = $1F3F;

function Min(Value1, Value2: Integer): Integer;
begin
	if Value1 < Value2 then
		Result := Value1
	else
		Result := Value2
end;

function Max(Value1, Value2: Integer): Integer;
begin
	if Value1 > Value2 then
		Result := Value1
	else
		Result := Value2
end;

procedure CheckPlaces(Places: Cardinal);
begin
	if Places > MAX_DECIMAL_PLACES then
		raise Exception.Create('Decimal precision too large')
end;

function LessReal(Value1, Value2: Extended; Places: Cardinal): Boolean;
begin
	CheckPlaces(Places);
	Result := Value1 < Value2 - Accuracy[Places];
end;

function EqualReal(Value1, Value2: Extended; Places: Cardinal): Boolean;
begin
	CheckPlaces(Places);
	Result := Abs(Value1 - Value2) < Accuracy[Places];
end;

function GreatReal(Value1, Value2: Extended; Places: Cardinal): Boolean;
begin
	CheckPlaces(Places);
	Result := Value1 > Value2 + Accuracy[Places];
end;

function ValidInt52(Value: Double): Boolean; assembler;
asm
  FLD   QWORD [EBP+8]		{ Value }
  FXAM
  FSTSW AX
  TEST  AH,$40          { Zero/Denormal? }
  JNZ   @@Good
  TEST  AH,$01          { Inf/NaN? }
  JNZ   @@Bad
  MOV   AX,[EBP+8+6]    { Scale }
  AND   AX,$7FF0        { Mask Sign/Mantissa }
  SHR   AX,4
  SUB   AX,$3FF         { Subtract Bias }
  JB    @@Bad
  CMP   AX,52
  JA    @@Bad
  FLD   ST(0)           { No Fractions? }
  FRNDINT
  FCOMP
  FSTSW AX
  SAHF
  JE    @@Good
@@Bad:
  XOR   AL,AL
  JMP   @@Fini
@@Good:
  MOV   AL,1
@@Fini:
  FSTP  ST(0)           { Pop FPU Stack }
end;

function _RoundBool(Value: Extended; Scale: Double; HalfDown: Boolean): Extended; assembler;
asm
  SUB   ESP,4
  FLD   Value
  FXAM
  FSTSW [ESP]
  MOV   AH,[ESP+1]
  TEST  AH,$41 { Zero/Den/Nan/Inf? }
  JNZ   @@Fini
  TEST  AH,$02 { Sign? }
  JZ    @@Skip
  XOR   AL, 1
@@Skip:
  FMUL  Scale
  FSTCW [ESP]
  TEST  AL,AL
  JNZ   @@SubCeil
@@AddFloor:
  FADD  QWORD [Half]
  FADD  QWORD [Epsilon]
  FLDCW FloorCW
  JMP   @@Round
@@SubCeil:
  FSUB  QWORD [Half]
  FSUB  QWORD [Epsilon]
  FLDCW CeilCW
@@Round:
  FRNDINT
  FDIV  Scale
  FLDCW [ESP]
@@Fini:
  ADD   ESP,4
end;

function _RoundUp(Value: Extended; Scale: Double): Extended; assembler;
asm
  SUB   ESP,4
  FLD   Value
  FXAM
  FSTSW AX
  TEST  AH,$41 { Zero/Den/Nan/Inf? }
  JNZ   @@Fini
  FMUL  Scale
  FSTCW [ESP]
  TEST  AH,$02 { Sign? }
  JZ    @@SubCeil
@@AddFloor:
  FADD  QWORD [Epsilon]
  FLDCW FloorCW
  JMP   @@Round
@@SubCeil:
  FSUB  QWORD [Epsilon]
  FLDCW CeilCW
@@Round:
  FRNDINT
  FDIV  Scale
  FLDCW [ESP]
@@Fini:
  ADD   ESP,4
end;

function _RoundDown(Value: Extended; Scale: Double): Extended; assembler;
asm
  SUB   ESP,4
  FLD   Value
  FXAM
  FSTSW AX
  TEST  AH,$41 { Zero/Den/Nan/Inf? }
  JNZ   @@Fini
  FMUL  Scale
  FSTCW [ESP]
  TEST  AH,$02 { Sign? }
  JNZ    @@SubCeil
@@AddFloor:
  FADD  QWORD [Epsilon]
  FLDCW FloorCW
  JMP   @@Round
@@SubCeil:
  FSUB  QWORD [Epsilon]
  FLDCW CeilCW
@@Round:
  FRNDINT
  FDIV  Scale
  FLDCW [ESP]
@@Fini:
  ADD   ESP,4
end;

function _ScaleUp(Value: Extended; Scale: Double): Integer; assembler;
asm
  SUB   ESP,4
  FLD   Value
  FXAM
  FSTSW AX
  TEST  AH,$41 { Zero/Den/Nan/Inf? }
  JNZ   @@Fini
  FMUL  Scale
  FSTCW [ESP]
  TEST  AH,$02 { Sign? }
  JNZ   @@SubCeil
@@AddFloor:
  FADD  QWORD [Half]
  FADD  QWORD [Epsilon]
  FLDCW FloorCW
  JMP   @@Round
@@SubCeil:
  FSUB  QWORD [Half]
  FSUB  QWORD [Epsilon]
  FLDCW CeilCW
@@Round:
  FRNDINT
  FLDCW [ESP]
@@Fini:
  FISTP DWORD [ESP]
  POP   EAX
end;

function RoundNear(Value: Extended; Places: Cardinal): Extended;
begin
  CheckPlaces(Places);
	Result := _RoundBool(Value, TenPower[Places], False);
end;

function RoundHalf(Value: Extended; Places: Cardinal): Extended;
begin
  CheckPlaces(Places);
	Result := _RoundBool(Value, TenPower[Places], True);
end;

function RoundUp(Value: Extended; Places: Cardinal): Extended;
begin
	CheckPlaces(Places);

  Result := _RoundUp(Value, TenPower[Places]);
end;

function RoundDown(Value: Extended; Places: Cardinal): Extended;
begin
	CheckPlaces(Places);
	Result := _RoundDown(Value, TenPower[Places]);
end;

function RoundBool(Value: Extended; Places: Cardinal; HalfDown: Boolean): Extended;
begin
	CheckPlaces(Places);
  Result := _RoundBool(Value, TenPower[Places], HalfDown);
end;

function ScaleUp(Value: Extended; Places: Cardinal): Integer;
begin
	CheckPlaces(Places);
  Result := _ScaleUp(Value, TenPower[Places]);
end;

function ScaleDown(Value: Integer; Places: Cardinal): Extended;
begin
	CheckPlaces(Places);
	Result := Value / TenPower[Places];
end;

end.

