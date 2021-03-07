{=================================================================================================

NewLook Common Constants

Copyright (c) 1998 NewLook Through Old Windows Limited - see www.newlook.co.nz

Author: Paul Heinz

Version History
23/01/98	1.00	PMH		Created from revision of uRounding.pas into uMathUtils.pas
											Maximum decimal places extended to 18 for Str2Real support

=================================================================================================}

unit uConsts;

interface

const
	MAX_DECIMAL_PLACES = 18;

	Half: Double = 0.5;
	Epsilon: Double = 0.001;

	TenPower: array [0..MAX_DECIMAL_PLACES] of Double = (
  	1E+0, 1E+1, 1E+2, 1E+3, 1E+4,
    1E+5, 1E+6, 1E+7, 1E+8, 1E+9,
    1E+10,1E+11,1E+12,1E+13,1E+14,
    1E+15,1E+16,1E+17,1E+18
   );

	Accuracy: array [0..MAX_DECIMAL_PLACES] of Double = (
  	5E-1, 5E-2, 5E-3, 5E-4, 5E-5,
    5E-6, 5E-7, 5E-8, 5E-9, 5E-10,
    5E-11,5E-12,5E-13,5E-14,5E-15,
    5E-16,5E-17,5E-18,5E-19
   );

implementation

end.
