{*******************************************************}
{                                                       }
{       iMath                                           }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iMath;{$endif}
{$ifdef iCLX}unit QiMath;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Printers, Math;{$ENDIF}
  {$IFDEF iCLX}QPrinters, Math;{$ENDIF}

type
  DoubleDynamicArray = array of Double;
  PointDynamicArray  = array of TPoint;
  TRoundToRange = -37..37;

function Tan(x : extended) : extended;
function Cot(x : extended) : extended;
function Sec(x : extended) : extended;
function Csc(x : extended) : extended;

function arctan2(y,x : extended) : extended;

function ArcSin(x : extended) : extended;
function ArcCos(x : extended) : extended;
function ArcCot(x : extended) : extended;
function ArcSec(x : extended) : extended;
function ArcCsc(x : extended) : extended;

function Log10(x : extended) : extended;
function Log(a,x : extended) : extended;

function Pow(x : extended; n : integer) : extended;
function Power(x,y : extended) : extended;
function IntPower(const Base: Extended; const Exponent: Integer): Extended;
function RoundTo(const AValue: Double; const ADigit: TRoundToRange): Double;

function Sinh(x : extended) : extended;
function Cosh(x : extended) : extended;
function Tanh(x : extended) : extended;
function Coth(x : extended) : extended;
function Sech(x : extended) : extended;
function Csch(x : extended) : extended;

function ASinh(x : extended) : extended;
function ACosh(x : extended) : extended;
function ATanh(x : extended) : extended;
function ACoth(x : extended) : extended;
function ASech(x : extended) : extended;
function ACsch(x : extended) : extended;

function DegToRad(Degrees: Extended): Extended;  { Radians := Degrees * PI / 180}
function RadToDeg(Radians: Extended): Extended;  { Degrees := Radians * 180 / PI }
procedure SinCos(Theta: Extended; var Sin, Cos: Extended) register;

procedure Spline             (x,  y      : DoubleDynamicArray; n: Integer; yp1, ypn: Double; var y2: DoubleDynamicArray);
procedure SplineInterpolation(xa, ya, y2a: DoubleDynamicArray; n: Integer; x       : Double; var y : Double);

procedure PolynomialInterpolation(xa, ya: DoubleDynamicArray; n: Integer; x: Double; var y, dy: Double);
procedure RationalInterpolation  (xa, ya: DoubleDynamicArray; n: Integer; x: Double; var y, dy: Double);

function  LineIntersectsRect(Point1, Point2: TPoint; Rect: TRect): Boolean;

implementation

//****************************************************************************************************************************************************
function Cot(x : extended) : extended; begin Result := Tan(pi/2 - x); end;
function Sec(x : extended) : extended; begin Result := 1/Cos(x);      end;
function Csc(x : extended) : extended; begin Result := Sec(pi/2 - x); end;
//****************************************************************************************************************************************************
function ArcSin(x : extended) : extended; begin Result := ArcTan2(Sqrt(1-Sqr(x)),x); end;
function ArcCos(x : extended) : extended; begin Result := pi/2 - arcsin(x);          end;
function ArcCot(x : extended) : extended; begin Result := pi/2 - ArcTan(x);          end;
//****************************************************************************************************************************************************
function ArcSec(x : extended) : extended; begin Result := ArcCos(1/Abs(x)); if x < 0 then Result := Result + pi; end;
function ArcCsc(x : extended) : extended; begin Result := ArcSin(1/Abs(x)); if x < 0 then Result := Result + pi; end;
//****************************************************************************************************************************************************
function Sinh(x : extended) : extended; begin Result := (Exp(x) - Exp(-x))/2; end;
function Cosh(x : extended) : extended; begin Result := (Exp(x) + Exp(-x))/2; end;
function Tanh(x : extended) : extended; begin Result := Sinh(x)/Cosh(x);      end;
function Coth(x : extended) : extended; begin Result := 1/Tanh(x);            end;
function Sech(x : extended) : extended; begin Result := 1/cosh(x);            end;
function Csch(x : extended) : extended; begin Result := 1/Sinh(x);            end;
//****************************************************************************************************************************************************
function ASinh(x : extended) : extended; begin Result := Ln(x + Sqrt(Sqr(x) + 1));     end;
function ACosh(x : extended) : extended; begin Result := Ln(x + Sqrt(Sqr(x) - 1));     end;
function ATanh(x : extended) : extended; begin Result := Ln((1 + x)/(1 - x))/2;        end;
function ACoth(x : extended) : extended; begin Result := Ln((1 + x)/(x - 1))/2;        end;
function ASech(x : extended) : extended; begin Result := Ln(1/x + Sqrt(Sqr(1/x) - 1)); end;
function ACsch(x : extended) : extended; begin Result := Ln(1/x + Sqrt(Sqr(1/x) + 1)); end;
//****************************************************************************************************************************************************
function RadToDeg(Radians: Extended): Extended; begin Result := Radians * (180 / PI); end;
function DegToRad(Degrees: Extended): Extended; begin Result := Degrees * (PI / 180); end;
//****************************************************************************************************************************************************
function Tan(x : extended) : extended; assembler;
asm
  FLD x
  FPTAN
  FSTP ST(0)
  FWAIT
end;
//****************************************************************************************************************************************************
function  ArcTan2(y,x : extended) : extended; assembler;
asm
  FLD y
  FLD x
  FPATAN
  FWAIT
end;
//****************************************************************************************************************************************************
function Log(a,x : extended) : extended;
begin
  Result := Ln(x)/Ln(a);
end;
//****************************************************************************************************************************************************
function Log10(x : extended) : extended; assembler;
asm
  FLDLG2
  FLD X
  FYL2X
  FWAIT
end;
//****************************************************************************************************************************************************
function Pow(x : extended; n : integer) : extended;
var
  m : cardinal;
begin
  Result := 1;
  if (x = 0) and (n = 0) then exit
  else if n = 0 then Result := 1
  else if x = 0 then Result := 0
  else begin
    m := Abs(n);
    while m > 0 do begin
      while not Odd(m) do
        begin
          m := m shr 1;
          x := x*x
        end;
      Dec(m);
      Result := Result*x
    end;
  end;
  if n < 0 then Result := 1/Result
end;
//****************************************************************************************************************************************************
function Power(x,y : extended) : extended;
begin
  Result := Exp(y*ln(x));
end;
//****************************************************************************************************************************************************
function IntPower(const Base: Extended; const Exponent: Integer): Extended;
asm
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;
//****************************************************************************************************************************************************
function RoundTo(const AValue: Double; const ADigit: TRoundToRange): Double;
var
  LFactor: Double;
begin
  if AValue <> 0 then
    begin
      LFactor := IntPower(10, ADigit);
      Result := Round(AValue / LFactor) * LFactor;
    end
  else
    Result := 0;
end;
//****************************************************************************************************************************************************
procedure SinCos(Theta: Extended; var Sin, Cos: Extended);
asm
  FLD     Theta
  FSINCOS
  FSTP    tbyte ptr [edx]    // Cos
  FSTP    tbyte ptr [eax]    // Sin
  FWAIT
end;
//****************************************************************************************************************************************************
procedure Spline(x, y: DoubleDynamicArray; n: integer; yp1,ypn: Double; var y2: DoubleDynamicArray);
var
   i,k            : integer;
   p, qn, sig, un : real;
   u              : array of Double;
begin
  yp1 := (y[2] - y[1]  ) / (x[2] - x[1]  );
  ypn := (y[n] - y[n-1]) / (x[n] - x[n-1]);

   SetLength(u, n+1);
   if (yp1 > 0.99e30) then
     begin
       y2[1] := 0.0;
        u[1] := 0.0;
     end
   else
     begin
       y2[1] := -0.5;
        u[1] := (3.0/(x[2]-x[1]))*((y[2]-y[1])/(x[2]-x[1])-yp1);
     end;

   for i := 2 to n-1 do
     begin
       sig   := (x[i]-x[i-1])/(x[i+1]-x[i-1]);
       p     := sig*y2[i-1]+2.0;
       y2[i] := (sig-1.0)/p;
        u[i] := (y[i+1]-y[i])/(x[i+1]-x[i]) -(y[i]-y[i-1])/(x[i]-x[i-1]);
        u[i] := (6.0*u[i]/(x[i+1]-x[i-1])-sig*u[i-1])/p;
   end;

   if (ypn > 0.99e30) then
     begin
       qn := 0.0;
       un := 0.0;
     end
   else
     begin
       qn := 0.5;
       un := (3.0/(x[n]-x[n-1]))*(ypn-(y[n]-y[n-1])/(x[n]-x[n-1]));
     end;

   y2[n] := (un-qn*u[n-1])/(qn*y2[n-1]+1.0);

   for k := n-1 downto 1 do
     y2[k] := y2[k]*y2[k+1]+u[k]
end;
//****************************************************************************************************************************************************
procedure SplineInterpolation(xa, ya, y2a: DoubleDynamicArray; n: integer; x: Double; var y: Double);
var
   klo, khi, k : integer;
   h, b, a     : real;
begin
  klo := 1;
  khi := n;

  while (khi-klo > 1) do
    begin
     k := (khi+klo) div 2;
     if (xa[k] > x) then khi := k else klo := k;
    end;

  h := xa[khi]-xa[klo];

  if (h = 0.0) then raise Exception.Create('Splint Error - xa''s must be distinct');

  a := (xa[khi]-x)/h;
  b := (x-xa[klo])/h;
  y := a*ya[klo]+b*ya[khi]+((a*a*a-a)*y2a[klo]+(b*b*b-b)*y2a[khi])*(h*h)/6.0;
end;
//****************************************************************************************************************************************************
procedure PolynomialInterpolation(xa, ya: DoubleDynamicArray; n: Integer; x: Double; var y, dy: Double);
var
   ns, m, i                  : Integer;
   w, hp, ho, dift, dif, den : Double;
   c, d                      : DoubleDynamicArray;
begin
  SetLength(c, n+1);
  SetLength(d, n+1);

  ns := 1;
  dif := abs(x-xa[1]);

  for i := 1 to n do
    begin
      dift := abs(x-xa[i]);
      if (dift < dif) then
        begin
          ns  := i;
          dif := dift;
        end;
     c[i] := ya[i];
     d[i] := ya[i]
    end;

  y := ya[ns];
  ns := ns-1;

  for m := 1 to n-1 do
    begin
     for i := 1 to n-m do
       begin
         ho  := xa[i]-x;
         hp  := xa[i+m]-x;
         w   := c[i+1]-d[i];
         den := ho-hp;
         if (den = 0.0) then raise Exception.Create('Polynomial Interpolation Error - Pause in Routine Data');

         den  := w/den;
         d[i] := hp*den;
         c[i] := ho*den
       end;

      if ((2*ns) < (n-m)) then
        begin
          dy := c[ns+1]
        end
      else
        begin
          dy := d[ns];
          ns := ns-1
        end;
      y := y+dy
    end
end;
//****************************************************************************************************************************************************
procedure RationalInterpolation(xa, ya: DoubleDynamicArray; n: Integer; x: Double; var y, dy: Double);
const
   tiny=1.0e-25;
var
   ns, m, i        : integer;
   w, t, hh, h, dd : real;
   c,d             : DoubleDynamicArray;
begin
  SetLength(c, n+1);
  SetLength(d, n+1);

  ns := 1;
  hh := abs(x-xa[1]);

  for i := 1 to n do
    begin
      h := abs(x-xa[i]);
      if  (h = 0.0) then
        begin
          y := ya[i];
          dy := 0.0;
          exit;
        end
      else if (h < hh) then
        begin
          ns := i;
          hh := h
        end;
      c[i] := ya[i];
      d[i] := ya[i]+tiny
  end;
  y := ya[ns];
  ns := ns-1;
  for m := 1 to n-1 do
    begin
      for i := 1 to n-m do
        begin
          w := c[i+1]-d[i];
          h := xa[i+m]-x;
          t := (xa[i]-x)*d[i]/h;
          dd := t-c[i+1];

          if (dd = 0.0) then raise Exception.Create('Rational Interpolation Error - Pause in Routine Data');

          dd := w/dd;
          d[i] := c[i+1]*dd;
          c[i] := t*dd
        end;

      if (2*ns < n-m) then
        begin
          dy := c[ns+1]
        end
      else
        begin
          dy := d[ns];
          ns := ns-1
        end;
      y := y+dy
  end;
end;
//****************************************************************************************************************************************************
procedure GetEquation(Point1, Point2 : TPoint; var Slope, Intercept: Double);
begin
  if Point1.X <> Point2.X then Slope := (Point2.Y - Point1.Y)/(Point2.X - Point1.X)
  else                         Slope := 1E30;

  Intercept := Point1.Y - Slope*Point1.X;
end;
//****************************************************************************************************************************************************
function LinesIntersect(L1P1, L1P2, L2P1, L2P2 : TPoint): Boolean;
var
  M1, M2, B1, B2 : Double;
  X              : Integer;
begin
  Result := False;

  GetEquation(L1P1, L1P2, M1, B1);
  GetEquation(L2P1, L2P2, M2, B2);

  if M1 <> M2 then                                
  begin
    X := Round((B2-B1)/(M1-M2));
    if      (X >= Min(L1P1.x,L1P2.x))
        and (X <= Max(L1P1.x,L1P2.x))
        and (X >= Min(L2P1.x,L2P2.x))
        and (X <= Max(L2P1.x,L2P2.x)) then Result := True;
  end;
end;
//****************************************************************************************************************************************************
function  LineIntersectsRect(Point1, Point2: TPoint; Rect: TRect): Boolean;
begin
  Result := True;

  if LinesIntersect(Point1, Point2, Point(Rect.Left,  Rect.Top),    Point(Rect.Left,  Rect.Bottom))                then Exit;
  if LinesIntersect(Point1, Point2, Point(Rect.Left,  Rect.Top),    Point(Rect.Right, Rect.Top))                   then Exit;
  if LinesIntersect(Point1, Point2, Point(Rect.Right, Rect.Top),    Point(Rect.Right, Rect.Bottom))                then Exit;
  if LinesIntersect(Point1, Point2, Point(Rect.Right, Rect.Bottom), Point(Rect.Left,  Rect.Bottom))                then Exit;

  if (Point1.X >= Rect.Left) and (Point1.X <= Rect.Right) and (Point1.Y >= Rect.Top) and (Point1.Y <= Rect.Bottom) then Exit;
  if (Point2.X >= Rect.Left) and (Point2.X <= Rect.Right) and (Point2.Y >= Rect.Top) and (Point2.Y <= Rect.Bottom) then Exit;

  Result := False;
end;
//****************************************************************************************************************************************************
end.
