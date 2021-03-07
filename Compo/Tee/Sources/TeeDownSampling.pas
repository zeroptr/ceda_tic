{*********************************************}
{  TDownSamplingFunction                      }
{  Copyright (c) 2004-2009 by Steema Software }
{  With permission from Mr. Nils Haeck        }
{*********************************************}
unit TeeDownSampling;
{$I TeeDefs.inc}

{ Implementation of the famous Douglas-Peucker simplification
  algorithm.

  This file contains a 3D floating point implementation, for spatial
  polylines, as well as a 2D integer implementation for use with
  Windows GDI.

  Loosely based on C code from SoftSurfer (www.softsurfer.com)
  http://geometryalgorithms.com/Archive/algorithm_0205/algorithm_0205.htm

  References:
  David Douglas & Thomas Peucker, "Algorithms for the reduction of the number of
  points required to represent a digitized line or its caricature", The Canadian
  Cartographer 10(2), 112-122  (1973)

  Delphi code by Nils Haeck (c) 2003 Simdesign (www.simdesign.nl)
  http://www.simdesign.nl/components/douglaspeucker.html

  ****************************************************************
  The contents of this file are subject to the Mozilla Public
  License Version 1.1 (the "License"); you may not use this file
  except in compliance with the License. You may obtain a copy of
  the License at:
  http://www.mozilla.org/MPL/

  Software distributed under the License is distributed on an
  "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  implied. See the License for the specific language governing
  rights and limitations under the License.
}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes, Graphics, TeEngine;

type
  // Float point 3D
  TPointFloat2D = packed record
    X: TChartValue;
    Y: TChartValue;
  end;

  TDownSampleMethod=(dsDouglas, dsMax, dsMin, dsMinMax, dsAverage,
                      dsMinMaxFirstLast, dsMinMaxFirstLastNull);

  TDownSamplingFunction=class(TTeeFunction)
  private
    FDownSampleMethod: TDownSampleMethod;
    FTolerance: TChartValue;
    FDisplayedPointCount: Integer;
    procedure SetDownSampleMethod(const Value: TDownSampleMethod);
    procedure SetTolerance(Value:TChartValue);
    procedure SetDisplayedPointCount(const Value:Integer);
    function Reduce(Method: TDownSampleMethod; const Tol: TChartValue;
                const lbound, ubound: Integer; s: TChartSeries;
                var RX, RY: TChartValues; var colors: array of TColor;
                color: TColor): Integer;
  public
    { Reduced size. Reduction factor is then Source.Count/ReducedSize}
    ReducedSize : Integer;
    Constructor Create(AOwner: TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
  published
    { Different downsample methods}
    property DownSampleMethod : TDownSampleMethod read FDownSampleMethod write SetDownSampleMethod default dsDouglas;
    { Tolerance, expressed in real chart values}
    property Tolerance:TChartValue read FTolerance write SetTolerance;
    property DisplayedPointCount:Integer read FDisplayedPointCount write SetDisplayedPointCount default 0;
  end;

implementation

uses Math, Chart, TeeProCo, TeeConst{$IFDEF D6}, DateUtils{$ENDIF};

function VecMin2D(const x1,y1,x2,y2: TChartValue): TPointFloat2D;
// Result = (x1,y1) - (x2,y2)
begin
  Result.X := x1 - x2;
  Result.Y := y1 - y2;
end;

function DotProd2D(const x1,y1,x2,y2:TChartValue): TChartValue;
// Dotproduct = (x1,y1)*(x2,y2)
begin
  Result := x1*x2 + y1*y2;
end;

function DistSquared2D(const x1,y1,x2,y2: TChartValue): TChartValue;
// Square of the distance from (x1,y1) to (x2,y2)
var v : TPointFloat2D;
begin
  v  := VecMin2D(x1,y1,x2,y2);
  result := Sqr(v.x)+Sqr(v.y);
end;

procedure Simplify2D(const Tol2: TChartValue; const X,Y: TChartValues;
  var Marker: array of boolean; j, k: integer);
// Simplify polyline in X,Y between j and k. Marker[] will be set to True
// for each point that must be included
var
  i, MaxI: integer; // Index at maximum value
  MaxD2: TChartValue;    // Maximum value squared
  CU, CW, B: TChartValue;
  DV2: TChartValue;
  P0, P1, PB, U, W: TPointFloat2D;
begin
  // Is there anything to simplify?
  if k <= j + 1 then exit;

  P0.X := X[j];
  P0.Y := Y[j];

  P1.X := X[k];
  P1.Y := Y[k];
  U  := VecMin2D(P1.X,p1.Y, P0.X, P0.Y); // Segment vector
  CU := DotProd2D(U.X, U.Y, U.X, U.Y); // Segment length squared
  MaxD2 := 0;
  MaxI  := 0;

  // Loop through points and detect the one furthest away
  for i := j + 1 to k - 1 do
  begin
    W  := VecMin2D(X[i],Y[i], P0.X, P0.Y);
    CW := DotProd2D(W.X,W.Y, U.X, U.Y);

    // Distance of point Orig[i] from segment
    if CW <= 0 then
    begin
      // Before segment
      DV2 := DistSquared2D(X[i], Y[i], P0.X, P0.X)
    end
    else
    begin
      if CW > CU then
      begin
        // Past segment
        DV2 := DistSquared2D(X[i], Y[i], P1.X, P1.Y);
      end
      else
      begin
        // Fraction of the segment
        try
          B := CW / CU;
        except
          B := 0; // in case CU = 0
        end;

        PB.X := P0.X + B * U.X;
        PB.Y := P0.Y + B * U.Y;
        DV2 := DistSquared2D(X[i], Y[i], PB.X, PB.Y);
      end;
    end;

    // test with current max distance squared
    if DV2 > MaxD2 then
    begin
      // Orig[i] is a new max vertex
      MaxI  := i;
      MaxD2 := DV2;
    end;
  end;

  // If the furthest point is outside tolerance we must split
  if MaxD2 > Tol2 then
  begin // error is worse than the tolerance

    // split the polyline at the farthest vertex from S
    Marker[MaxI] := True;  // mark Orig[maxi] for the simplified polyline

    // recursively simplify the two subpolylines at Orig[maxi]
    Simplify2D(Tol2, X,Y, Marker, j, MaxI); // polyline Orig[j] to Orig[maxi]
    Simplify2D(Tol2, X,Y, Marker, MaxI, k); // polyline Orig[maxi] to Orig[k]
  end;
end;

{ PolySimplify2D:
  Approximates the polyline with 2D integer vertices in Orig, with a simplified
  version that will be returned in Simple. The maximum deviation from the
  original line is given in Tol.
  Input:  Tol      = approximation tolerance
          X,Y   = polyline array of vertex points
  Output: rX,rY = simplified polyline vertices. This array must initially
                     have the same length as X,Y
  Return: the number of points in rX or rY
}
function PolySimplify2D(const Tol: TChartValue; const X,Y: TChartValues; N: Integer;
                        var RX,RY: Array of TChartValue): integer;
var
  i      : Integer;
  Marker : Array of Boolean;
  Tol2   : TChartValue;
begin
  result := 0;

  if Length(X) < 2 then
     Exit;

  Tol2 := Sqr(Tol);

  // Create a marker array
  SetLength(Marker, N);

  // Include first and last point
  Marker[0]     := True;
  Marker[N - 1] := True;

  // Exclude intermediate for now
  for i := 1 to N - 2 do
      Marker[i] := False;

  // Simplify
  Simplify2D(Tol2, X,Y, Marker, 0, N - 1);

  // Copy to resulting list
  for i := 0 to N - 1 do
  if Marker[i] then
  begin
    RX[result] := X[i];
    RY[result] := Y[i];
    Inc(result);
  end;
end;

function TDownSamplingFunction.Reduce(Method: TDownSampleMethod; const Tol: TChartValue;
                const lbound, ubound: Integer; s: TChartSeries;
                var RX, RY: TChartValues; var colors: array of TColor;
                color: TColor): Integer;
var tmpSum,tmpMax,tmpMin,tmpFirst,tmpLast,
    tmpXfirst,tmpXmax,tmpXmin,tmpXlast : TChartValue;
    i,j,k,rSize,nullCount,iTol,count: Integer;
    X,Y: TChartValues;
    one, two, three, oneX, twoX, threeX: Double;
begin
  rSize:=0;
  i:=lbound;
  nullCount:=0;
  iTol:=Round(Tol);

  X:=s.XValues.Value;
  Y:=s.YValues.Value;
  for k:=0 to High(colors)-1 do colors[k]:=color;

  if Method = dsDouglas then
    result := PolySimplify2D(Tol,X,Y,ubound-lbound,rX,rY)
  else
  begin
    while i<ubound do
    begin
      j:=i;

      if Method=dsMinMaxFirstLastNull then
      begin
        nullCount:=0;

        if s.IsNull(i) then inc(nullCount);
      end;

      tmpSum:=Y[i];
      tmpMax:=Y[i];
      tmpMin:=Y[i];
      tmpFirst:=Y[i];
      tmpXfirst:=X[i];
      tmpXmax:=X[i];
      tmpXmin:=X[i];
      tmpLast:=tmpFirst;
      tmpXlast:=tmpXfirst;

      if DisplayedPointCount>0 then
      begin
        count:=1;

        while (((j+1)<ubound) and (count<iTol)) do
        begin
          inc(j);

          if Method=dsMinMaxFirstLastNull then
          begin
            if(s.IsNull(j)) then inc(nullCount);

            if nullCount<=1 then
            begin
              if not s.IsNull(j) then
              begin
                if tmpSum <> s.DefaultNullValue then tmpSum:=tmpSum + Y[j]
                                                else tmpSum:=Y[j];

                if Y[j]>tmpMax then
                begin
                  tmpMax:=Y[j];
                  tmpXMax:=X[j];
                end;

                if Y[j]<tmpMin then
                begin
                  tmpMin:=Y[j];
                  tmpXMin:=X[j];
                end;

                tmpLast:=Y[j];
								tmpXLast:=X[j];
              end
              else
              begin
                if Y[j]>tmpMax then
                begin
                  tmpMax:=Y[j];
                  tmpXMax:=X[j];
                end;

                if Y[j]<tmpMin then
                begin
                  tmpMin:=Y[j];
                  tmpXMin:=X[j];
                end;

                tmpLast:=Y[j];
								tmpXLast:=X[j];
              end;
            end;
          end
          else
          begin
            tmpSum:=tmpSum+Y[j];

            if Y[j]>tmpMax then
            begin
              tmpMax:=Y[j];
              tmpXMax:=X[j];
            end;

            if Y[j]<tmpMin then
            begin
              tmpMin:=Y[j];
              tmpXMin:=X[j];
            end;

            tmpLast:=Y[j];
            tmpXLast:=X[j];
          end;

          inc(count);
        end;
      end
      else
      begin
        while (((j+1)<ubound) and (Abs(X[j+1]-X[i])<Tol)) do
        begin
          inc(j);
          tmpSum:=tmpSum+Y[j];

          if Y[j]>tmpMax then
          begin
            tmpMax:=Y[j];
            tmpXMax:=X[j];
          end;

          if Y[j]<tmpMin then
          begin
            tmpMin:=Y[j];
            tmpXMin:=X[j];
          end;

          tmpLast:=Y[j];
          tmpXLast:=X[j];
        end;
      end;

      if ((Method<>dsMinMax) and (Method<>dsMinMaxFirstLast) and
          (Method<>dsMinMaxFirstLastNull)) then
      begin
        rX[rSize]:=(X[j] + X[i])*0.5; // x is average of group

        if Method=dsAverage then rY[rSize]:=tmpSum/(j-i+1)
        else if Method=dsMax then rY[rSize]:=tmpMax
        else if Method=dsMin then rY[rSize]:=tmpMin;

        inc(rsize);
      end
      else if (rSize<=High(rX)) then // safeguard in case somebody tries to do this on very short array
      begin
        if (j-i)=0 then  //CDI only drawing half the plot when tolerance = 0
        begin
          rX[rSize]:=X[i];
          rY[rSize]:=tmpMin;

          if Method=dsMinMaxFirstLastNull then
            if tmpMin=s.DefaultNullValue  then colors[rSize]:=clNone
                                          else colors[rSize]:=color;

          inc(rSize);
        end
        else
          if Method=dsMinMax then
          begin
            rX[rSize]:= X[i];
						rX[rSize+1]:= X[j];
						rY[rSize]:= tmpMin;
						rY[rSize+1]:= tmpMax;
						rSize:=rSize+2;
          end
          else
            if (j-1)>2 then
            begin
              rX[rSize]:=tmpXFirst;
              rY[rSize]:=tmpFirst;

              if Method=dsMinMaxFirstLastNull then
              begin
                if tmpFirst=s.DefaultNullValue  then colors[rSize]:=clNone
                                                else colors[rSize]:=Color;

                inc(rSize);

                if tmpXMax<tmpXMin then
                begin
                  if tmpXFirst<>tmpXMax then
                  begin
                    rX[rSize]:=tmpXMax;
                    rY[rSize]:=tmpMax;

                    if tmpMax=s.DefaultNullValue  then colors[rSize]:=clNone
                                                  else colors[rSize]:=color;

                    inc(rSize);
                  end;

                  if ((tmpXFirst<>tmpXMin) and (tmpXMin<tmpXMax)) then
                  begin
                    rX[rSize]:=tmpXMin;
                    rY[rSize]:=tmpMin;

                    if tmpMin=s.DefaultNullValue  then colors[rSize]:=clNone
                                                  else colors[rSize]:=color;

                    inc(rSize);
                  end;

                end
                else
                begin
                  if tmpXFirst<>tmpXMin then
                  begin
                    rX[rSize]:=tmpXMin;
                    rY[rSize]:=tmpMin;

                    if tmpMin=s.DefaultNullValue  then colors[rSize]:=clNone
                                                  else colors[rSize]:=color;

                    inc(rSize);
                  end;

                  if ((tmpXFirst <> tmpXMax) and (tmpXMin<>tmpXMax)) then
                  begin
                    rX[rSize]:=tmpXMax;
                    rY[rSize]:=tmpMax;

                    if tmpMax=s.DefaultNullValue  then colors[rSize]:=clNone
                                                  else colors[rSize]:=color;

                    inc(rSize);
                  end;
                end;

                if ((tmpXLast<>tmpXFirst) and (tmpXLast<>tmpXMin) and
                    (tmpXLast<>tmpXMax)) then
                begin
                  rX[rSize]:=tmpXLast;
                  rY[rSize]:=tmpLast;

                  if tmpLast=s.DefaultNullValue then colors[rSize]:=clNone
                                                else colors[rSize]:=color;

                  inc(rSize);
                end;
              end
              else
              begin
                if tmpXMax<=tmpXMin then
                begin
                  rX[rSize+1]:=tmpXMax;
                  rX[rSize+2]:=tmpXMin;
                  rY[rSize+1]:=tmpMax;
                  rY[rSize+2]:=tmpMin;
                end
                else
                begin
                  rX[rSize+2]:=tmpXmax;
                  rX[rSize+1]:=tmpXmin;
                  rY[rSize+2]:=tmpMax;
                  rY[rSize+1]:=tmpMin;
                end;

                rX[rSize+3]:=tmpXLast;
                rY[rSize+3]:=tmpLast;
                rSize:=rSize+4;
              end;
            end
            else
              if (j-1)<2 then
              begin
                rX[rSize]:=X[i];
                rX[rSize+1]:=X[j];
                rX[rSize]:=Y[i];
                rX[rSize+1]:=Y[i];
                rSize:=rSize+2;
              end
              else
              begin
                one:=0;
                two:=0;
                three:=0;
                oneX:=0;
                twoX:=0;
                threeX:=0;

                if ((tmpFirst=tmpMin) or (tmpLast=tmpMin)) then
                begin
                  one:=tmpFirst;
                  oneX:=tmpXFirst;
                  two:=tmpMax;
                  twoX:=tmpXMax;
                  three:=tmpLast;
                  threeX:=tmpXLast;
                end
                else
                  if ((tmpFirst=tmpMax)or (tmpLast=tmpMax)) then
                  begin
                    one:=tmpFirst;
                    oneX:=tmpXFirst;
                    two:=tmpMin;
                    twoX:=tmpXMin;
                    three:=tmpLast;
                    threeX:=tmpXLast;
                  end;

                rX[rSize]:=oneX;
                rX[rSize+1]:=twoX;
                rX[rSize+2]:=threeX;
                rY[rSize]:=one;
                rY[rSize+1]:=two;
                rY[rSize+2]:=three;
                inc(rSize,3);
              end;
          end;

        i:=j+1;
      end;

    result:=rSize;
  end;
end;

{ TDownSamplingFunction }

procedure TDownSamplingFunction.AddPoints(Source: TChartSeries);
var
  rX,rY : TChartValues;
  colors: array of TColor;
  t     : Integer;
  N     : Integer;
  lbound: Integer;
  tmpTol: Double;
begin
  if not IUpdating then
    if Assigned(Source) then
      if Source.Count>0 then
      begin
        With ParentSeries do
        begin
          Clear;
          N:=Source.Count;
          lbound:=0;

          if (Assigned(ParentChart) and (not IsRectEmpty(ParentChart.ChartRect))) then
          begin
            ParentChart.TeeCreateBitmap;
            Source.CalcFirstLastVisibleIndex;
            N:=Source.LastValueIndex - Source.FirstValueIndex;
            lbound:=Source.FirstValueIndex;
          end;
        end;

        if N>0 then
        begin
          With ParentSeries do
          begin
            if Source.YMandatory=YMandatory then  // 7.0
            begin
              NotMandatoryValueList.Order:=loAscending;
              MandatoryValueList.Order:=loNone;
            end
            else
            begin
              NotMandatoryValueList.Order:=loNone;
              MandatoryValueList.Order:=loAscending;
            end;
          end;

          // step 1 : setup result arrays
          SetLength(rX,N);
          SetLength(rY,N);
          SetLength(colors,N);

          tmpTol:=FTolerance;

          if DisplayedPointCount>0 then
          begin
            tmpTol:=DisplayedPointCount/4.0;
            tmpTol:=N/tmpTol;
          end;

          try
            // step 2 : do downsample
            with Source do
              ReducedSize := Reduce(FDownSampleMethod,tmpTol,lbound,
                                    lbound+N,Source,rX,rY,colors,
                                    ParentSeries.Color);

            // step 3 : populate target series with results
            for t:=0 to ReducedSize-1 do
              if Source.YMandatory then
                ParentSeries.AddXY(rX[t],rY[t],'',colors[t])
              else
                ParentSeries.AddXY(rY[t],rX[t],'',colors[t]);
          finally
            // cleanup memory
            rX:=nil;
            rY:=nil;
            colors:=nil;
          end;
        end;
  end;
end;

Constructor TDownSamplingFunction.Create(AOwner: TComponent);
begin
  inherited;
  CanUsePeriod:=False;
  SingleSource:=True;
  FTolerance := 1.0;
  InternalSetPeriod(1);
end;

procedure TDownSamplingFunction.SetDownSampleMethod(const Value: TDownSampleMethod);
begin
  if FDownSampleMethod<>Value then
  begin
    FDownSampleMethod := Value;
    Recalculate;
  end;
end;

procedure TDownSamplingFunction.SetTolerance(Value:TChartValue);
begin
  Value:=Max(0.0,Value);

  if FTolerance<>Value then
  begin
    FTolerance := Value;
    Recalculate;
  end;
end;

procedure TDownSamplingFunction.SetDisplayedPointCount(const Value:Integer);
begin
  FDisplayedPointCount := Value;
end;

initialization
  RegisterTeeFunction( TDownSamplingFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionDownSampling,
                                              {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended );
finalization
  UnRegisterTeeFunctions([TDownSamplingFunction]);
end.
