{*********************************************}
{  THistogramFunction                         }
{  Copyright (c) 2004-2009 by Steema Software }
{  Creates a histogram from series            }
{  mandatory values.                          }
{*********************************************}
unit TeeHistogram;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes, TeEngine;

type
  (*::Adds histogram calculation.*)
  THistogramFunction=class(TTeeFunction)
  private
    FCumulative: boolean;
    FNumBins: Integer;
    FIncludeNulls: boolean;

    procedure SetCumulative(const Value: boolean);
    procedure SetNumBins(Value: Integer);
    procedure SetIncludeNulls(const Value: boolean);
  public
    Constructor Create(AOwner: TComponent); override;
    procedure AddPoints(Source:TChartSeries); override;
  published
    (*::If true, calculate cumulative histogram.*)
    property Cumulative: boolean read FCumulative write SetCumulative default False;

    (*::Number of histogram bins.*)
    property NumBins: Integer read FNumBins write SetNumBins default 20;

    (*::If true, calculate histogram using null values of source series.*)
    property IncludeNulls: boolean read FIncludeNulls write SetIncludeNulls default True;
  end;

// Do an equidistant histogram.
procedure Histogram(Data: TChartValues; var Bins,Counts: TChartValues;
                    Min,Max: Double; nbins: Integer);

implementation

uses
  Math, Chart, TeeConst, TeeProCo;

procedure Histogram(Data: TChartValues; var bins,counts: TChartValues;
                    Min,Max: Double; nbins: Integer);
var range,binwidth,invbinwidth: double;
  i,j,righttail: Integer;
begin
  // Check this special case
  if (min=max) then
  begin
    min := min - Floor(0.5*nbins) - 0.5;
    max := max + Ceil(0.5*nbins)+0.5;
  end;

  range := max - min;
  binwidth := range/nbins;
  invbinwidth := nbins/range;

  // Setup bins centerpoints and count for each bin
  for I := 0 to nbins - 1 do
  begin
    bins[i] := min + (0.5+i)*binwidth;
    counts[i] := 0;
  end;

  // pretty fast, but can be a bit inaccurate if values are in range of SQRT(EPS)
  righttail := 0;
  for i := Low(data) to High(data) do
  begin
    j := Round((data[i]-min)*invbinwidth);

    if (j>=0) and (j<nbins) then counts[j] := counts[j]+1
    else
    if (j>=nbins) then Inc(righttail);
  end;
  counts[nbins-1] := counts[nbins-1] + righttail;
end;

{ THistogramFunction }

procedure THistogramFunction.AddPoints(Source: TChartSeries);
var bins,counts,tmp : TChartValues;
  i: Integer;
begin
  if Source.Count>0 then
  begin
    ParentSeries.Clear;

    // Step 1 : setup result arrays
    SetLength(bins,FNumBins);
    SetLength(counts,FNumBins);
    try
    
      SetLength(tmp,0);
      for i:=0 to Source.MandatoryValueList.Count-1 do
        if (not Source.IsNull(i)) or FIncludeNulls then
        begin
          SetLength(tmp,Length(tmp)+1);
          tmp[High(tmp)]:=Source.MandatoryValueList[i];
        end;

      // Step 2 : do histogram
      Histogram(tmp,bins,counts, Source.MandatoryValueList.MinValue,
        Source.MandatoryValueList.MaxValue, FNumBins);

      // If cumulative, sum...
      if (FCumulative) then
        for i := 1 to FNumBins - 1 do counts[i] := counts[i] + counts[i-1];

      // Step 3 : fill parent series (normally histogram series,
      // but it can be any "2d" series type.
      with ParentSeries.NotMandatoryValueList do
      begin
        Count := FNumBins;
        Value := bins;
        Modified := True;
      end;
      With ParentSeries.MandatoryValueList do
      begin
        Count := FNumBins;
        Value := counts;
        Modified := True;
      end;
    finally
      // cleanup memory
      bins:=nil;
      counts:=nil;
    end;
  end;
end;

{ THistogramFunction }

Constructor THistogramFunction.Create(AOwner: TComponent);
begin
  inherited;

  CanUsePeriod:=False;
  SingleSource:=True;
  InternalSetPeriod(1);
  FCumulative := False;
  FNumBins := 20;
  FIncludeNulls := True;
end;

procedure THistogramFunction.SetCumulative(const Value: boolean);
begin
  if Value<>FCumulative then
  begin
    FCumulative := Value;
    Recalculate;
  end;
end;

procedure THistogramFunction.SetIncludeNulls(const Value: boolean);
begin
  if Value<>FIncludeNulls then
  begin
    FIncludeNulls := Value;
    Recalculate;
  end;
end;

procedure THistogramFunction.SetNumBins(Value: Integer);
begin
  Value:=Max(1,Value);

  if Value<>FNumBins then
  begin
    FNumBins := Value;
    Recalculate;
  end;
end;

initialization
  RegisterTeeFunction(THistogramFunction,
                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_HistogramFunction,
                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended);
finalization
  UnRegisterTeeFunctions([THistogramFunction]);
end.
