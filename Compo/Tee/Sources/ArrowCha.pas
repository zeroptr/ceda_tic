{***********************************************}
{   TArrowSeries (derived from TPointSeries)    }
{   Copyright (c) 1995-2009 by David Berneda    }
{***********************************************}
unit ArrowCha;
{$I TeeDefs.inc}

interface

{
  TArrowSeries derives from standard TPointSeries.
  Each point in the series is drawn like an Arrow.

  Each arrow has initial and end X,Y values that are used to draw the
  Arrow with its corresponding screen size.

  Arrow head size is controlled with ArrowWidth and ArrowHeight properties.
  Arrow body size is determined by ArrowPercent property (from 0 to 100% of
  ArrowWidth value).

  Inherits all functionality from TPointSeries and its ancestor TCustomSeries.
}
Uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$ENDIF}
     {$IFDEF D8}
     Types,
     {$ENDIF}
     Classes, Chart, Series, TeEngine;

Type
  //!<summary>Series to display arrows.</summary>
  TArrowSeries=class(TPointSeries)
  private
    FEndXValues : TChartValueList;
    FEndYValues : TChartValueList; { <-- Arrows end X,Y values }
    FPercent    : Integer;

    Function GetArrowHeight:Integer;
    Function GetArrowWidth:Integer;
    procedure GetArrowPoints(ValueIndex:Integer; var P0,P1:TPoint);
    Function GetStartXValues:TChartValueList;
    Function GetStartYValues:TChartValueList;
    procedure SetArrowHeight(Value:Integer);
    procedure SetArrowWidth(Value:Integer);
    Procedure SetEndXValues(Value:TChartValueList);
    Procedure SetEndYValues(Value:TChartValueList);
    procedure SetPercent(const Value:Integer);
    Procedure SetStartXValues(Value:TChartValueList);
    Procedure SetStartYValues(Value:TChartValueList);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override; { <-- to add random arrow values }
    class Function CanDoExtra:Boolean; override; { <-- for sub-gallery }
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    procedure DrawValue(ValueIndex:Integer); override; { <-- main draw method }
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
  public
    Constructor Create(AOwner: TComponent); override;

    Function AddArrow(Const X0,Y0,X1,Y1:Double; Const ALabel:String='';
                     AColor:TColor=clTeeColor):Integer;
    Function Clicked(x,y:Integer):Integer; override;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxXValue:Double; override;
    Function MinXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
  published
    property Active;
    property ColorEachPoint;
    property ColorSource;
    property Cursor;
    property HorizAxis;
    property Marks;
    property ParentChart;
    property DataSource;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend;
    property Title;
    property ValueFormat;
    property VertAxis;
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

    property ArrowHeight:Integer read GetArrowHeight write SetArrowHeight stored False;
    property ArrowPercent:Integer read FPercent write SetPercent default 50;  // % of ArrowWidth
    property ArrowWidth:Integer read GetArrowWidth write SetArrowWidth stored False;
    property EndXValues:TChartValueList read FEndXValues write SetEndXValues;
    property EndYValues:TChartValueList read FEndYValues write SetEndYValues;
    property StartXValues:TChartValueList read GetStartXValues write SetStartXValues;
    property StartYValues:TChartValueList read GetStartYValues write SetStartYValues;
  end;

implementation

uses
  Math, SysUtils, TeeProcs, TeeConst, TeCanvas;

type TValueListAccess=class(TChartValueList);

{ TArrowSeries }
Constructor TArrowSeries.Create(AOwner: TComponent);
Begin
  inherited;
  CalcVisiblePoints:=False;

  TValueListAccess(XValues).InitDateTime(True);

  FEndXValues :=TChartValueList.Create(Self,TeeMsg_ValuesArrowEndX);
  TValueListAccess(FEndXValues).InitDateTime(True);

  FEndYValues :=TChartValueList.Create(Self,TeeMsg_ValuesArrowEndY);

  Pointer.InflateMargins:=False;
  Marks.Frame.Hide;
  Marks.Transparent:=True;

  FPercent:=50;
end;

Procedure TArrowSeries.SetEndXValues(Value:TChartValueList);
Begin
  SetChartValueList(FEndXValues,Value); { standard method }
end;

Procedure TArrowSeries.SetEndYValues(Value:TChartValueList);
Begin
  SetChartValueList(FEndYValues,Value); { standard method }
end;

{ Helper method, special to Arrow series }
Function TArrowSeries.AddArrow( Const X0,Y0,X1,Y1:Double;
                                Const ALabel:String; AColor:TColor):Integer;
Begin
  FEndXValues.TempValue:=X1;
  FEndYValues.TempValue:=Y1;
  result:=AddXY(X0,Y0,ALabel,AColor);
end;

Procedure TArrowSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Var tmpDifX : Integer;
    tmpDifY : Integer;
    t       : Integer;
    tmpX0   : Double;
    tmpY0   : Double;
Begin
  With RandomBounds(NumValues) do
  begin
    tmpDifY:=Round(DifY);
    tmpDifX:=Round(StepX*NumValues);
    for t:=1 to NumValues do { some sample values to see something in design mode }
    Begin
      tmpX0:=tmpX+RandomValue(tmpDifX);
      tmpY0:=MinY+RandomValue(tmpDifY);
      AddArrow( tmpX0,tmpY0,
                tmpX0+RandomValue(tmpDifX),  { X1 }
                tmpY0+RandomValue(tmpDifY)   { Y1 }
                );
    end;
  end;
end;

Function TArrowSeries.GetArrowWidth:Integer;
Begin
  result:=Pointer.HorizSize;
end;

Function TArrowSeries.GetArrowHeight:Integer;
Begin
  result:=Pointer.VertSize;
end;

procedure TArrowSeries.SetArrowWidth(Value:Integer);
Begin
  Pointer.HorizSize:=Value;
End;

procedure TArrowSeries.SetArrowHeight(Value:Integer);
Begin
  Pointer.VertSize:=Value;
End;

procedure TArrowSeries.GetArrowPoints(ValueIndex:Integer; var P0,P1:TPoint);
begin
  P0.x:=CalcXPos(ValueIndex);
  P0.y:=CalcYPos(ValueIndex);
  P1.x:=CalcXPosValue(EndXValues.Value[ValueIndex]);
  P1.y:=CalcYPosValue(EndYValues.Value[ValueIndex]);
end;

{ This overrided method is the main paint for Arrow points. }
procedure TArrowSeries.DrawValue(ValueIndex:Integer);
Var p0       : TPoint;
    p1       : TPoint;
    tmpColor : TColor;
Begin
  tmpColor:=ValueColor[ValueIndex];

  With ParentChart do
  begin
    if View3D then Pointer.PrepareCanvas(Canvas,tmpColor)
              else Canvas.AssignVisiblePenColor(Pointer.Pen,tmpColor);

    GetArrowPoints(ValueIndex,P0,P1);
    Canvas.Arrow(View3D,P0,P1,Pointer.HorizSize,Pointer.VertSize,MiddleZ,FPercent);
  end;
end;

Function TArrowSeries.MaxXValue:Double;
Begin
  result:=Math.Max(inherited MaxXValue,FEndXValues.MaxValue);
end;

Function TArrowSeries.MinXValue:Double;
Begin
  result:=Math.Min(inherited MinXValue,FEndXValues.MinValue);
end;

Function TArrowSeries.MaxYValue:Double;
Begin
  result:=Math.Max(inherited MaxYValue,FEndYValues.MaxValue);
end;

Function TArrowSeries.MinYValue:Double;
Begin
  result:=Math.Min(inherited MinYValue,FEndYValues.MinValue);
end;

class Function TArrowSeries.GetEditorClass:String;
Begin
  result:='TArrowSeriesEditor'; { <-- dont translate ! }
end;

Function TArrowSeries.GetStartXValues:TChartValueList;
Begin
  result:=XValues;
End;

procedure TArrowSeries.SetPercent(const Value:Integer);
begin
  SetIntegerProperty(FPercent,Value);
end;

Procedure TArrowSeries.SetStartXValues(Value:TChartValueList);
Begin
  SetXValues(Value);
End;

Function TArrowSeries.GetStartYValues:TChartValueList;
Begin
  result:=YValues;
End;

Procedure TArrowSeries.SetStartYValues(Value:TChartValueList);
Begin
  SetYValues(Value);
End;

Procedure TArrowSeries.PrepareForGallery(IsEnabled:Boolean);
Begin
  inherited;

  FillSampleValues(3);
  ArrowWidth :=12;
  ArrowHeight:=12;

  if not IsEnabled then
     SeriesColor:=clSilver;
end;

Function TArrowSeries.IsValidSourceOf(Value:TChartSeries):Boolean;
begin
  result:=Value is TArrowSeries;
end;

class procedure TArrowSeries.CreateSubGallery(AddSubChart: TChartSubGalleryProc);
begin
  inherited;
end;

// For sub-gallery only. Arrow series do not allow sub-styles.
class function TArrowSeries.CanDoExtra: Boolean;
begin
  result:=False;
end;

function TArrowSeries.Clicked(x, y: Integer): Integer;
var t  : Integer;
    P  : TPoint;
    P0 : TPoint;
    P1 : TPoint;
begin
  result:=TeeNoPointClicked;

  P:=TeePoint(x,y);

  for t:=0 to Count-1 do
  begin
    GetArrowPoints(t,P0,P1);

    if PointInLine(P,P0,P1,Pen.Width) then
    begin
      result:=t;
      break;
    end;
  end;
end;

initialization
  RegisterTeeSeries(TArrowSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryArrow,
                                  {$IFNDEF CLR}@{$ENDIF}
          {$IFDEF TEELITE}TeeMsg_GalleryStandard{$ELSE}TeeMsg_GalleryExtended{$ENDIF},2);
end.
