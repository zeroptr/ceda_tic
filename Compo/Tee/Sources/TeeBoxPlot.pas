{**********************************************}
{   TCustomBoxSeries                           }
{     TBoxSeries                               }
{     THorizBoxSeries                          }
{                                              }
{   Copyright (c) 2000-2009 by                 }
{   Marjan Slatinek and David Berneda          }
{**********************************************}
unit TeeBoxPlot;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes, SysUtils,
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     Chart, Series, TeEngine, TeCanvas;

type
   TCustomBoxSeries=class(TPointSeries)
   private
     FExtrOut       : TSeriesPointer;
     FMedianPen     : TChartPen;
     FMildOut       : TSeriesPointer;
     FPosition      : Double;
     FWhiskerLength : Double;
     FWhiskerPen    : TChartPen;
     IVertical      : Boolean;

     FUseCustomValues : Boolean;
     FMedian          : Double;
     FQuartile1       : Double;
     FQuartile3       : Double;
     FInnerFence1     : Double;
     FInnerFence3     : Double;
     FOuterFence1     : Double;
     FOuterFence3     : Double;
     FAdjacentPoint1  : Double;
     FAdjacentPoint3  : Double;

     procedure CalcValues(var R:TRect; var x,y,horiz,vert,tmp:Integer);
     Function GetBox:TSeriesPointer;
     procedure SetAdjacentPoint1(const Value: Double);
     procedure SetAdjacentPoint3(const Value: Double);
     procedure SetExtrOut(Value: TSeriesPointer);
     procedure SetInnerFence1(const Value: Double);
     procedure SetInnerFence3(const Value: Double);
     procedure SetMedian(const Value: Double);
     procedure SetMedianPen(Value: TChartPen);
     procedure SetMildOut(Value: TSeriesPointer);
     procedure SetOuterFence1(const Value: Double);
     procedure SetOuterFence3(const Value: Double);
     procedure SetPosition(Const Value: Double);
     procedure SetQuartile1(const Value: Double);
     procedure SetQuartile3(const Value: Double);
     procedure SetUseCustomValues(const Value: Boolean);
     procedure SetWhiskerLength(Const Value: Double);
     procedure SetWhiskerPen(Value: TChartPen);
     function SaveCustomValues: boolean;
   protected
     procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
     procedure DoBeforeDrawValues; override;
     procedure DrawAllValues; override;
     procedure DrawMark( ValueIndex:Integer; Const St:String;
                                    APosition:TSeriesMarkPosition); override;
     procedure DrawValue(ValueIndex: Integer); override;
     class Function GetEditorClass:String; override;
     function  GetSampleValues: TChartValueList; virtual;
     procedure PrepareForGallery(IsEnabled:Boolean); override;
     procedure SetParentChart(Const Value: TCustomAxisPanel); override;
     procedure SetSampleValues(Value: TChartValueList); virtual;
   public
     Constructor Create(AOwner: TComponent); override;
     Destructor Destroy; override;

     Procedure Assign(Source:TPersistent); override;
     function Clicked(x,y:Integer):Integer; override;
     procedure RecalcStats;

     property Box:TSeriesPointer read GetBox;
   published
     property ExtrOut: TSeriesPointer read FExtrOut write SetExtrOut;
     property MedianPen: TChartPen read FMedianPen write SetMedianPen;
     property MildOut: TSeriesPointer read FMildOut write SetMildOut;
     property Position: Double read FPosition write SetPosition;
     property SampleValues: TChartValueList read GetSampleValues write SetSampleValues;
     property UseCustomValues: Boolean read FUseCustomValues write SetUseCustomValues default false;
     property WhiskerLength: Double read FWhiskerLength write SetWhiskerLength;
     property WhiskerPen: TChartPen read FWhiskerPen write SetWhiskerPen;

     property AdjacentPoint1: Double read FAdjacentPoint1 write SetAdjacentPoint1 stored SaveCustomValues; // 7.01 - changed to Double
     property AdjacentPoint3: Double read FAdjacentPoint3 write SetAdjacentPoint3 stored SaveCustomValues; // 7.01 - changed to Double
     property InnerFence1: Double read FInnerFence1 write SetInnerFence1 stored SaveCustomValues;
     property InnerFence3: Double read FInnerFence3 write SetInnerFence3 stored SaveCustomValues;
     property Median: Double read FMedian write SetMedian stored SaveCustomValues;
     property OuterFence1: Double read FOuterFence1 write SetOuterFence1 stored SaveCustomValues;
     property OuterFence3: Double read FOuterFence3 write SetOuterFence3 stored SaveCustomValues;
     property Quartile1: Double read FQuartile1 write SetQuartile1 stored SaveCustomValues;
     property Quartile3: Double read FQuartile3 write SetQuartile3 stored SaveCustomValues;
   end;

   { Vertical Box Series }
   TBoxSeries=class(TCustomBoxSeries)
   public
     Function MinXValue:Double; override;
     Function MaxXValue:Double; override;
     Function MinYValue:Double; override;
     Function MaxYValue:Double; override;
   end;

   { Horizontal Box Series }
   THorizBoxSeries=class(TCustomBoxSeries)
   public
     Constructor Create(AOwner:TComponent); override;
     Function MinYValue:Double; override;
     Function MaxYValue:Double; override;
     Function MinXValue:Double; override;
     Function MaxXValue:Double; override;
   end;

implementation

Uses
  TeeProCo, Math;

{ TCustomBoxSeries }
Constructor TCustomBoxSeries.Create(AOwner: TComponent);
begin
  inherited;
  AllowSinglePoint:=False;
  CalcVisiblePoints:=False;

  XValues.Name:='';
  YValues.Name:='Samples'; // Do not localize

  Marks.Visible:=False;
  Marks.Callout.Length:=0;
  FUseCustomValues := False; { MS : added to support custom values }

  FWhiskerLength:=1.5;
  FMildOut:=TSeriesPointer.Create(Self);
  FMildOut.Style:=psCircle;
  FExtrOut:=TSeriesPointer.Create(Self);
  FExtrOut.Style:=psStar;

  With Pointer do
  begin
    Draw3D:=False;
    Pen.Width:=1;
    VertSize:=15;
    HorizSize:=15;
    Brush.Color:=clWhite;
  end;

  FWhiskerPen:=CreateChartPen;

  FMedianPen:=CreateChartPen;
  FMedianPen.Width:=1;
  FMedianPen.Style:=psDot;

  IVertical:=True;
end;

Destructor TCustomBoxSeries.Destroy;
begin
  FMedianPen.Free;
  FWhiskerPen.Free;
  FreeAndNil(FExtrOut);
  FreeAndNil(FMildOut);
  inherited;
end;

procedure TCustomBoxSeries.SetWhiskerLength(Const Value: Double);
begin
  SetDoubleProperty(FWhiskerLength,Value);
end;

function TCustomBoxSeries.GetSampleValues;
begin
  result:=MandatoryValueList;
end;

procedure TCustomBoxSeries.SetSampleValues(Value: TChartValueList);
begin
  if IVertical then YValues:=Value else XValues:=Value;
end;

procedure TCustomBoxSeries.SetPosition(Const Value: Double);
begin
  SetDoubleProperty(FPosition,Value);
end;

procedure TCustomBoxSeries.SetWhiskerPen(Value: TChartPen);
begin
  FWhiskerPen.Assign(Value);
end;

procedure TCustomBoxSeries.SetMedianPen(Value: TChartPen);
begin
  FMedianPen.Assign(Value);
end;

procedure TCustomBoxSeries.SetMildOut(Value: TSeriesPointer);
begin
  FMildOut.Assign(Value);
end;

procedure TCustomBoxSeries.SetExtrOut(Value: TSeriesPointer);
begin
  FExtrOut.Assign(Value);
end;

procedure TCustomBoxSeries.DoBeforeDrawValues; { 5.02 - new calculation algorithm }
begin
  inherited;

  { if custom values are used, or there are no points, skip the recalculation }
  if (not FUseCustomValues) and (SampleValues.Count>0) then
     RecalcStats;
end;

procedure TCustomBoxSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
begin
  with APosition do
  if IVertical then
  begin
    ArrowTo.X:=CalcXPosValue(FPosition);
    ArrowFrom.X:=ArrowTo.X;
    LeftTop.X:=ArrowTo.X - (Width div 2);
  end
  else
  begin
    ArrowTo.Y:=CalcYPosValue(FPosition);
    ArrowFrom.Y:=ArrowTo.Y;
    LeftTop.Y:=ArrowTo.Y - (Height div 2);
  end;

  inherited;
end;

procedure TCustomBoxSeries.DrawValue(ValueIndex:Integer);
var tmpColor : TColor;
    tmpVal   : Double;
    tmp      : TSeriesPointer;
begin
  tmpVal:=SampleValues.Value[ValueIndex];

  { inside inner fences - no point }
  if (tmpVal>=FInnerFence1) and (tmpVal<=FInnerFence3) then tmp:=nil
  { mild outlined points }
  else
  if ((tmpVal>=FInnerFence3) and (tmpVal<=FOuterFence3)) or
     ((tmpVal<=FInnerFence1) and (tmpVal>=FOuterFence1)) then
     tmp:=FMildOut
  else
    { extreme outlined points }
    tmp:=FExtrOut;

  if Assigned(tmp) then
    with tmp do
    if Visible then
    begin
      tmpColor:=ValueColor[ValueIndex];
      PrepareCanvas(ParentChart.Canvas,tmpColor);

      if IVertical then Draw(CalcXPosValue(FPosition),CalcYPos(ValueIndex),tmpColor,Style)
                   else Draw(CalcXPos(ValueIndex),CalcYPosValue(FPosition),tmpColor,Style)
    end;
end;

procedure TCustomBoxSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var t : Integer;
    n : Integer;
    tmpSeries : Integer;
begin
  if Assigned(ParentChart) then
     tmpSeries:=ParentChart.SeriesCount+1
  else
     tmpSeries:=1;

  n:=tmpSeries*(3+RandomValue(10));

  Add(-n);

  for t:=2 to NumValues-2 do
      Add(n*t/NumValues);

  Add(2*n);
end;

procedure TCustomBoxSeries.PrepareForGallery(IsEnabled:Boolean);
var t : Integer;
begin
  inherited;

  { by default display 2 series}
  for t:=0 to ParentChart.SeriesCount-1 do
  if ParentChart.Series[t] is TCustomBoxSeries then
  with TCustomBoxSeries(ParentChart.Series[t]) do
  begin
    FPosition:=t+1;
    Pointer.HorizSize:=12;
    MildOut.HorizSize:=3;
    ExtrOut.VertSize:=3;
    FillSampleValues(10*(t+1));
  end;
end;

procedure TCustomBoxSeries.CalcValues(var R:TRect; var x,y,Horiz,Vert,tmp:Integer);
var tmpH,
    tmpV   : Integer;
    tmpPos : Integer;
begin
  if IVertical then
  begin
    tmp:=Pointer.HorizSize;

    R.Left:=CalcXPosValue(FPosition)-tmp;
    R.Right:=CalcXPosValue(FPosition)+tmp;
    R.Top:=CalcYPosValue(FQuartile3);
    R.Bottom:=CalcYPosValue(FQuartile1);
  end
  else
  begin
    tmp:=Pointer.VertSize;

    R.Top:=CalcYPosValue(FPosition)-tmp;
    R.Bottom:=CalcYPosValue(FPosition)+tmp;
    R.Right:=CalcXPosValue(FQuartile3);
    R.Left:=CalcXPosValue(FQuartile1);
  end;

  if GetHorizAxis.Inverted then
     SwapInteger(R.Left,R.Right);

  if GetVertAxis.Inverted then
     SwapInteger(R.Top,R.Bottom);

  if IVertical then
  begin
    tmpV:=(R.Bottom-R.Top) div 2;

    if GetHorizAxis.Inverted then tmpPos:=R.Left-tmp
                             else tmpPos:=R.Left+tmp;

    x:=tmpPos;
    y:=R.Top+tmpV;
    Horiz:=Pointer.HorizSize-1;
    Vert:=tmpV-1;
  end
  else
  begin
    tmpH:=(R.Right-R.Left) div 2;

    if GetVertAxis.Inverted then tmpPos:=R.Top-tmp
                            else tmpPos:=R.Top+tmp;

    x:=R.Left+tmpH;
    y:=tmpPos;
    Horiz:=tmpH-1;
    Vert:=Pointer.VertSize-1;
  end;
end;

function TCustomBoxSeries.Clicked(x,y:Integer):Integer; // 8.01
var tmpX, tmpY, tmpHoriz, tmpVert, tmp : Integer;
    R : TRect;
begin
  result:=inherited Clicked(x,y);

  if (result=TeeNoPointClicked) and Pointer.Visible then
  begin
    CalcValues(R, tmpX,tmpY,tmpHoriz,tmpVert,tmp);

    if PointInRect(TeeRect(tmpX-tmpHoriz,tmpY-tmpVert,tmpX+tmpHoriz,tmpY+tmpVert),x,y) then
       result:=0;
  end;
end;

procedure TCustomBoxSeries.DrawAllValues;

  Function CalcPos(Const Value:Double):Integer;
  begin
    if IVertical then result:=CalcYPosValue(Value)
                 else result:=CalcXPosValue(Value);
  end;

var
  tmp : Integer;
  tmp1 : Integer;
  tmpZ : Integer;

  Procedure DrawWhisker(const AdjPos: Double; Pos:Integer);
  var tmp2 : Integer;
  begin
    tmp2:=CalcPos(AdjPos);

    With ParentChart,Canvas do
    if View3D then
    begin
      if IVertical then
      begin
        VertLine3D(tmp1,Pos,tmp2,tmpZ);
        HorizLine3D(tmp1-tmp,tmp1+tmp,tmp2,tmpZ);
      end
      else
      begin
        HorizLine3D(Pos,tmp2,tmp1,tmpZ);
        VertLine3D(tmp2,tmp1-tmp,tmp1+tmp,tmpZ);
      end;
    end
    else
    if IVertical then
    begin
      DoVertLine(tmp1,Pos,tmp2);
      DoHorizLine(tmp1-tmp,tmp1+tmp,tmp2);
    end
    else
    begin
      DoHorizLine(Pos,tmp2,tmp1);
      DoVertLine(tmp2,tmp1-tmp,tmp1+tmp);
    end;
  end;

var tmpX,
    tmpY,
    tmpV,
    tmpHoriz,
    tmpVert : Integer;
    R       : TRect;
begin
  inherited;

  CalcValues(R,tmpX,tmpY,tmpHoriz,tmpVert,tmp);

  with Pointer do (* box *)
  if Visible then
  begin
    PrepareCanvas(ParentChart.Canvas,Color);;
    DrawPointer(ParentChart.Canvas,
                ParentChart.View3D,tmpX,tmpY,tmpHoriz,tmpVert,
                Brush.Color,Style);
  end;

  (* median *)
  if FMedianPen.Visible then
  begin
    ParentChart.Canvas.AssignVisiblePen(FMedianPen);
    ParentChart.Canvas.Brush.Style:=bsClear;

    tmpV:=CalcPos(FMedian);

    with ParentChart.Canvas do
    if IVertical then
       if ParentChart.View3D then HorizLine3D(R.Left,R.Right,tmpV,StartZ)
                             else DoHorizLine(R.Left,R.Right,tmpV)
    else
       if ParentChart.View3D then VertLine3D(tmpV,R.Top,R.Bottom,StartZ)
                             else DoVertLine(tmpV,R.Top,R.Bottom);
  end;

  (* whiskers *)
  if FWhiskerPen.Visible then
  begin
    if Pointer.Visible and Pointer.Draw3D then tmpZ:=MiddleZ
                                          else tmpZ:=StartZ;

    ParentChart.Canvas.AssignVisiblePen(FWhiskerPen);

    if IVertical then
    begin
      tmp1:=(R.Left+R.Right) div 2;
      DrawWhisker(FAdjacentPoint1,R.Bottom);
      DrawWhisker(FAdjacentPoint3,R.Top);
    end
    else
    begin
      tmp1:=(R.Top+R.Bottom) div 2;
      DrawWhisker(FAdjacentPoint1,R.Left);
      DrawWhisker(FAdjacentPoint3,R.Right);
    end;
  end;
end;

procedure TCustomBoxSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if not (csDestroying in ComponentState) then
  begin
    if Assigned(FExtrOut) then FExtrOut.ParentChart:=Value;
    if Assigned(FMildOut) then FMildOut.ParentChart:=Value;
  end;
end;

class function TCustomBoxSeries.GetEditorClass: String;
begin
  result:='TBoxSeriesEditor'; // Do not localize
end;

function TCustomBoxSeries.GetBox: TSeriesPointer;
begin
  result:=Pointer;
end;

procedure TCustomBoxSeries.Assign(Source: TPersistent);
begin
  if Source is TCustomBoxSeries then
  With TCustomBoxSeries(Source) do
  begin
     Self.ExtrOut        :=ExtrOut;
     Self.MedianPen      :=MedianPen;
     Self.MildOut        :=MildOut;
     Self.FPosition      :=Position;
     Self.FWhiskerLength :=FWhiskerLength;
     Self.WhiskerPen     :=WhiskerPen;
     Self.FUseCustomValues := FUseCustomValues;

     Self.FMedian        :=FMedian;
     Self.FQuartile1     :=FQuartile1;
     Self.FQuartile3     :=FQuartile3;
     Self.FInnerFence1   :=FInnerFence1;
     Self.FInnerFence3   :=FInnerFence3;
     Self.FOuterFence1   :=FOuterFence1;
     Self.FOuterFence3   :=FOuterFence3;
     Self.FAdjacentPoint1:=FAdjacentPoint1;
     Self.FAdjacentPoint3:=FAdjacentPoint3;
  end;

  inherited;
end;

procedure TCustomBoxSeries.SetUseCustomValues(const Value: Boolean);
begin
  SetBooleanProperty(FUseCustomValues,Value);
end;

procedure TCustomBoxSeries.SetMedian(const Value: Double);
begin
  SetDoubleProperty(FMedian,Value);
end;

procedure TCustomBoxSeries.SetQuartile1(const Value: Double);
begin
  SetDoubleProperty(FQuartile1,Value);
end;

procedure TCustomBoxSeries.SetQuartile3(const Value: Double);
begin
  SetDoubleProperty(FQuartile3,Value);
end;

procedure TCustomBoxSeries.SetInnerFence1(const Value: Double);
begin
  SetDoubleProperty(FInnerFence1,Value);
end;

procedure TCustomBoxSeries.SetInnerFence3(const Value: Double);
begin
  SetDoubleProperty(FInnerFence3,Value);
end;

procedure TCustomBoxSeries.SetOuterFence1(const Value: Double);
begin
  SetDoubleProperty(FOuterFence1,Value);
end;

procedure TCustomBoxSeries.SetOuterFence3(const Value: Double);
begin
  SetDoubleProperty(FOuterFence3,Value);
end;

function TCustomBoxSeries.SaveCustomValues: boolean;
begin
  Result := FUseCustomValues;
end;

procedure TCustomBoxSeries.SetAdjacentPoint1(const Value: Double);
begin
  SetDoubleProperty(FAdjacentPoint1,Value);
end;

procedure TCustomBoxSeries.SetAdjacentPoint3(const Value: Double);
begin
  SetDoubleProperty(FAdjacentPoint3,Value);
end;

procedure TCustomBoxSeries.RecalcStats;
var N    : Integer;
    i    : Integer;
    FIqr : Double;
    FMed : Integer;

  function CalcPctile(sortedvalues: TChartValueList; n: Integer; k: Integer;
                          d: Double): Double;
  begin
    if (k < 1) then Result := sortedvalues[0]
    else if (k > n - 1) then Result := sortedvalues[n - 1]
    else Result := (1 - d) * sortedvalues[k - 1] + d * sortedvalues[k];
  end;

  { Calculate 1st and 3rd quartile }
  function Percentile(values: TChartValueList; Const P: Double): Double;
  var n,
      k : Integer;
      v,
      d : Double;
  begin
    n := values.Count;
    v := P * (n + 1);

    if v<>0 then
    begin
      d := v - Trunc(v);
      k := Trunc(v);
    end
    else
    begin
      d:=0;
      k:=0;
    end;

    Result := CalcPctile(values, n, k, d);
  end;

begin
  N:=SampleValues.Count;

  if N>0 then
  begin
    { calculate median }
    FMed := N div 2;
    if Odd(N) then FMedian := SampleValues[FMed]
    else FMedian := 0.5* (SampleValues[FMed-1] + SampleValues[FMed]);

    { calculate Q1 and Q3 }
    if N>1 then
    begin
      FQuartile1 := Percentile(SampleValues, 0.25);
      FQuartile3 := Percentile(SampleValues, 0.75);
    end
    else
    begin
      FQuartile1 := SampleValues[0];
      FQuartile3 := SampleValues[0];
    end;

    { calculate IQR }
    FIqr:=FQuartile3-FQuartile1;
    FInnerFence1:=FQuartile1-FWhiskerLength*FIqr;
    FInnerFence3:=FQuartile3+FWhiskerLength*FIqr;

    { find adjacent points }
    for i := 0 to FMed do
        if SampleValues.Value[i]>FInnerFence1 then Break;

    FAdjacentPoint1:=SampleValues[i];

    for i := FMed to N-1 do
        if SampleValues.Value[i]>FInnerFence3 then Break;

    FAdjacentPoint3 := SampleValues[i-1];

    { calculate outer fences }
    FOuterFence1:=FQuartile1-2*FWhiskerLength*FIqr;
    FOuterFence3:=FQuartile3+2*FWhiskerLength*FIqr;
  end;
end;

{ TBoxSeries }
function TBoxSeries.MaxXValue: Double;
begin
  result:=FPosition;
end;

function TBoxSeries.MinXValue: Double;
begin
  result:=FPosition;
end;

function TBoxSeries.MaxYValue: Double;
begin
  Result := Max(inherited MaxYValue,Max(FAdjacentPoint1,FAdjacentPoint3));
  if FUseCustomValues then
     Result := Max(Result,Max(FOuterFence1,FOuterFence3));
end;

function TBoxSeries.MinYValue: Double;
begin
  Result := Min(inherited MinYValue,Min(FAdjacentPoint1,FAdjacentPoint3));
  if FUseCustomValues then
     Result := Min(Result,Min(FOuterFence1,FOuterFence3));
end;

{ THorizBoxSeries}
Constructor THorizBoxSeries.Create(AOwner:TComponent);
begin
  inherited;
  SetHorizontal;
  IVertical:=False;
end;

function THorizBoxSeries.MaxXValue: Double;
begin
  Result := Max(inherited MaxXValue,Max(FAdjacentPoint1,FAdjacentPoint3));
  if FUseCustomValues then
     Result := Max(Result,Max(FOuterFence1,FOuterFence3));
end;

function THorizBoxSeries.MinXValue: Double;
begin
  Result := Min(inherited MinXValue,Min(FAdjacentPoint1,FAdjacentPoint3));
  if FUseCustomValues then
     Result := Min(Result,Min(FOuterFence1,FOuterFence3));
end;

function THorizBoxSeries.MaxYValue: Double;
begin
  result:=FPosition;
end;

function THorizBoxSeries.MinYValue: Double;
begin
  result:=FPosition;
end;

initialization
  RegisterTeeSeries(TBoxSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryBoxPlot,
                                {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,2);
  RegisterTeeSeries(THorizBoxSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryHorizBoxPlot,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,2);
finalization
  UnRegisterTeeSeries([TBoxSeries,THorizBoxSeries]);
end.
