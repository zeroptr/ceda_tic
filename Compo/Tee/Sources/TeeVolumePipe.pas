{*******************************************************}
{                                                       }
{ Unit Name: TeeVolumePipe                              }
{ Purpose  : The VolumePipe or Trapezoid Series         }
{ Author   : Marc Meumann, marc@steema.com              }
{ History  : v1.0 (Written for TeeChart v7 or later)    }
{                                                       }
{ Copyright (c) 2006-2009 by Marc Meumann               }
{        All Rights Reserved                            }
{*******************************************************}
unit TeeVolumePipe;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$ENDIF}
     Classes, SysUtils, TeEngine, Chart, TeCanvas;

type
  TTrapeziumPoints = type TFourPoints;

  TVolumePipeSeries = class(TChartSeries)
  private
    { internal }
    IPolyList: Array of TTrapeziumPoints;
    IMin    : Integer;
    IMax    : Integer;
    IDiff   : Integer;

    FGradient   : TCustomTeeGradient;
    BoundingPoints: TFourPoints;
    FLinesPen: TChartPen;
    FConePercent: Integer;

    // Internal variables
    totalVals: Double;
    totalPxArea,
    lastX, lastYDisp: Integer;
    leftWall, rightWall,
    overallWidth : Integer;

    procedure GetBoundingRectangle;
    Function GetMaxMarkHeight:Integer;
    procedure SetConePercent(const Value:Integer);
    Procedure SetGradient(const Value:TCustomTeeGradient);
    procedure SetLinesPen(const Value:TChartPen);
  protected
    procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);override;
    function CalcSegment(Counter:Integer; const Val:Double) : Integer;
    procedure DoBeforeDrawChart; override;
    procedure DrawAllValues; override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    procedure DrawValue(ValueIndex: Integer);override;
    class Function GetEditorClass:String; override;
    procedure PaintGradient(const poly: TTrapeziumPoints; PointColor, BrushColor : TColor);
    Function IsPointInChartRect(ValueIndex:Integer):Boolean; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    function Clicked(X,Y:Integer):Integer; override;
    Function NumSampleValues:Integer; override;
    Function UseAxis:Boolean; override;
  published
    property Active;
    property Brush;
    property Color;
    property ColorEachPoint default True;
    property ColorSource;
    property ConePercent:Integer read FConePercent write SetConePercent default 30;
    property Cursor;
    property Depth;
    property Gradient:TCustomTeeGradient read FGradient write SetGradient;
    property LinesPen:TChartPen read FLinesPen write SetLinesPen;
    property Marks;
    property ParentChart;
    property Pen;

    property DataSource;

    property PercentFormat;
    property ShowInLegend;
    property Title;
    property ValueFormat;
    property XLabelsSource;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnGetMarkText;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

implementation

{$IFDEF CLR}
{$R 'TVolumePipeSeries.bmp'}
{$ENDIF}

Uses
  TeeProcs, TeeProCo, TeeConst;

{ TVolumePipeSeries }
Constructor TVolumePipeSeries.Create(AOwner: TComponent);
begin
  inherited;
  ColorEachPoint:=True;
  FLinesPen:=CreateChartPen;

  FGradient:=TTeeGradient.Create(CanvasChanged);
  FGradient.Visible:=True;
  FGradient.MidColor:=clWhite;

  FConePercent:=30;
end;

Destructor TVolumePipeSeries.Destroy;
begin
  FGradient.Free;
  FLinesPen.Free;
  IPolyList:=nil;
  inherited;
end;

Function TVolumePipeSeries.UseAxis:Boolean;
begin
  result:=False;
end;

procedure TVolumePipeSeries.DrawValue(ValueIndex: Integer);
begin
  With ParentChart.Canvas do
  begin
  end
end;

procedure TVolumePipeSeries.GetBoundingRectangle;
var InnerRect: TRect;
begin
  InnerRect:=ParentChart.ChartRect;

  if Marks.Visible then
     InnerRect.Top:=InnerRect.Top+GetMaxMarkHeight;

  With InnerRect do
  Begin
    BoundingPoints[0]:= TeePoint(Left+2,Top+2);  //topleft
    BoundingPoints[1]:= TeePoint(Right-2,Round(Top+(Bottom-Top) * ((FConePercent div 2) *0.01))); //topright
    BoundingPoints[2]:= TeePoint(Right-2,Round(Bottom-((Bottom-Top) * ((FConePercent div 2) *0.01)))); //bottomright
    BoundingPoints[3]:= TeePoint(Left+2,Bottom-2); //bottomleft
  end;
end;

type
  TTCustomAxisPanel=class(TCustomAxisPanel);

function TVolumePipeSeries.GetMaxMarkHeight : Integer;
var i,
    tmpHeight,
    tmpLines,
    tmpFont  : Integer;
begin
  tmpFont:=ParentChart.Canvas.FontHeight;
  tmpHeight:=0;

  for i:=FirstValueIndex to LastValueIndex do
  Begin
    ParentChart.MultiLineTextWidth(GetMarkText(i),tmpLines);

    if tmpHeight<tmpFont*tmpLines then
       tmpHeight:=tmpFont*tmpLines;
  end;

  result:=tmpHeight;
end;

function TVolumePipeSeries.IsPointInChartRect(ValueIndex: Integer): Boolean;
begin
  result:=true;
end;

procedure TVolumePipeSeries.DrawAllValues;
var xVal,
    i,
    yDisp : Integer;
    conePcnt : Double;
    poly  : TTrapeziumPoints;
    boundingRect : TRect;
    segmentStartZ,segmentEndZ : Integer;
    zDiff : Double;
    // overallZDiff : Double;
begin
  inherited;

  segmentStartZ:=StartZ;
  segmentEndZ:=EndZ;

  // overallZDiff:=Abs(EndZ-StartZ);

  ParentChart.Canvas.Brush.Style := bsClear;

  if FConePercent>100 then FConePercent:=100;

  GetBoundingRectangle;

  IMin := BoundingPoints[0].Y; //
  IMax := BoundingPoints[1].Y; //
  IDiff:= IMax-IMin;   //top left to right bottom of slope in Y disp

  //***** basis ******
  // area trapezium (known as trapezoid in US)
  // a=h * ((b1+b2)*0,5)
  // where b1 & b2 are parallel sides, h is height and a is area
  //******************

  //In this case horizontal trapezium
  leftWall:=BoundingPoints[3].Y-BoundingPoints[0].Y; //pixel height at left of bounding trapezium (b1)
  rightWall:=BoundingPoints[2].Y-BoundingPoints[1].Y; //pixel height at right of bounding trapezium (b2)
  overallWidth:=BoundingPoints[1].X-BoundingPoints[0].X; //pixel width of bounding trapezium (h)
  totalPxArea:=Round(overallWidth*((leftWall+rightWall)*0.5)); //area a

  totalVals:=YValues.TotalABS;

  IPolyList:=nil;

  lastX:=BoundingPoints[0].X; //use for avoiding trapezium overwrite (ie. make non-cumulative zones)
  lastYDisp:=0;

  if overallWidth<>0 then
  for i:=0 to Count-1 do
  if not IsNull(i) then
  Begin
    xVal:=CalcSegment(i,YValues[i])+BoundingPoints[0].X; //add left displacement
    yDisp:=Round((((xVal-BoundingPoints[0].X)/overallWidth)*IDiff));

    poly[0]:=TeePoint(xVal,BoundingPoints[3].Y-yDisp); //right bottom
    poly[1]:=TeePoint(xVal,BoundingPoints[0].Y+yDisp); //right top
    poly[2]:=TeePoint(lastX,BoundingPoints[0].Y+lastYDisp); //left top
    poly[3]:=TeePoint(lastX,BoundingPoints[3].Y-lastYDisp); //left bottom

    SetLength(IPolyList,Length(IPolyList)+1);
    IPolyList[Length(IPolyList)-1]:=poly;

    lastYDisp:=yDisp;

    with ParentChart.Canvas do
    Begin
      if Self.LinesPen.Visible then
         AssignVisiblePen(Self.LinesPen);

      if (not ParentChart.View3D)  and (Self.FGradient.Visible) then
         PaintGradient(poly,Self.GetValueColor(i),Self.Brush.Color)
      else
         AssignBrush(Self.Brush,Self.GetValueColor(i),Self.Brush.Color);

      if not ParentChart.View3D then
         Polygon(poly)
      else
      Begin
        boundingRect := Rect(poly[2].X, poly[2].Y,
                             poly[0].X, poly[3].Y);
        conePcnt :=   ((poly[0].Y - poly[1].Y) *1.0) /
                      ((poly[3].Y - poly[2].Y) *1.0) * 100.0;
        Cone(False,boundingRect.Left,boundingRect.Top,
                   boundingRect.Right,boundingRect.Bottom,
                   segmentStartZ,segmentEndZ,True,Round(conePcnt));

        //'slim-down' z depth
        zDiff:=(poly[0].X-poly[2].X) / overallWidth;
        segmentStartZ:=segmentStartZ+Round(zDiff*(EndZ-StartZ)/2);
        segmentEndZ:=segmentEndZ-Round(zDiff*(EndZ-StartZ)/2);
      end;
    end;

    lastX:=xVal;
  end;

  if Pen.Visible then
  with ParentChart.Canvas do
  begin
    Brush.Style:=bsClear;
    AssignVisiblePen(Self.Pen);

    //if ParentChart.View3D then PolygonWithZ(BoundingPoints,StartZ)  //no boundary on 3D
    if not ParentChart.View3D then Polygon(BoundingPoints);
  end;
end;

procedure TVolumePipeSeries.PaintGradient(const poly: TTrapeziumPoints; PointColor, BrushColor : TColor);
var i:Integer;
    BrushPoly: TPointArray;
Begin
  SetLength(BrushPoly,Length(BoundingPoints));

  try
    For i:=0 to Length(poly)-1 do
        BrushPoly[i]:= poly[i];

    FGradient.StartColor:= PointColor;
    FGradient.EndColor:= PointColor;

    FGradient.Draw(ParentChart.Canvas,BrushPoly,0,ParentChart.View3D);
  finally
    BrushPoly:=nil;
  end;
end;

function TVolumePipeSeries.CalcSegment(Counter:Integer; const Val:double) : Integer;
Var tmpVal,
    tmpValPercent,
    tmpValSize, a, b, c, x : Double;
    i : Integer;
Begin
  tmpVal:=0;
  for i:=0 to counter do
      tmpVal:=tmpVal+yValues[i];

  if totalVals<>0 then
  begin
    tmpValPercent:=(tmpVal/totalVals)*100;
    tmpValSize:=tmpValPercent*totalPxArea*0.01;

    //a, b and c here used for quadratic nomenclature not related to trapezium's a nd b
    a:=(leftWall-rightWall); //where overallWidth is total length of trapezium
    b:=-1*((2*tmpValSize)+((leftWall-rightWall)*overallWidth)+(2*(totalPxArea-tmpValSize)));  //leftwall-rightwall
    c:=(2*tmpValSize)*overallWidth;

    if a<>0 then
       x:=((-b)-Sqrt(Sqr(b)-(4*a*c)))/(2*a) //classic quadratic (-ve option on root)
    else
       x:=0;

    result:=Round(x);
  end
  else
    result:=0;
end;

procedure TVolumePipeSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
begin
  APosition.LeftTop:= TeePoint(
                      IPolyList[ValueIndex][2].X
                      -(APosition.Width div 2)
                      +((IPolyList[ValueIndex][0].X-IPolyList[ValueIndex][2].X) div 2),
                      ParentChart.ChartRect.Top);
  inherited;
end;

function TVolumePipeSeries.Clicked(X, Y: Integer): Integer;
var t : Integer;
begin
  Result := inherited Clicked(X,Y);

  if (result=TeeNoPointClicked) and (FirstValueIndex>-1) and (LastValueIndex>-1) then
  for t := FirstValueIndex to LastValueIndex do
  begin
    if PointInPolygon(TeePoint(X,Y),IPolyList[t]) then
    begin
      Result := t;
      break;
    end
  end;
end;

procedure TVolumePipeSeries.AddSampleValues(NumValues: Integer; OnlyMandatory:Boolean=False);
var LabelSampleStr : Array[0..4] of String;
    t : Integer;
Begin
  LabelSampleStr[0]:=TeeMsg_PieSample1;
  LabelSampleStr[1]:=TeeMsg_PieSample2;
  LabelSampleStr[2]:=TeeMsg_PieSample3;
  LabelSampleStr[3]:=TeeMsg_PieSample4;
  LabelSampleStr[4]:=TeeMsg_PieSample5;

  for t:=0 to NumValues-1 do
      Add( 1+RandomValue(ChartSamplesMax), { <-- Value }
           LabelSampleStr[t mod 5]);      { <-- Label }
end;

Function TVolumePipeSeries.NumSampleValues:Integer;
Begin
  result:=5;
End;

procedure TVolumePipeSeries.DoBeforeDrawChart;
begin
  inherited;
  if Visible and Assigned(GetVertAxis) then
     GetVertAxis.Visible:=False;
end;

class function TVolumePipeSeries.GetEditorClass: String;
begin
  result:='TVolumePipeSeriesEditor';
end;

procedure TVolumePipeSeries.SetLinesPen(const Value: TChartPen);
begin
  FLinesPen.Assign(Value);
end;

procedure TVolumePipeSeries.SetConePercent(const Value: Integer);
begin
  SetIntegerProperty(FConePercent,Value);
end;

procedure TVolumePipeSeries.SetGradient(const Value: TCustomTeeGradient);
begin
  FGradient.Assign(Value);
end;

initialization
  RegisterTeeSeries(TVolumePipeSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryVolumePipe,
                                       {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,1);
finalization
  UnRegisterTeeSeries([TVolumePipeSeries]);
end.
