{**********************************************}
{   TeeChart DataTable Tool                    }
{   Copyright (c) 2006-2009 by David Berneda   }
{   All Rights Reserved                        }
{**********************************************}
unit TeeDataTableTool;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}

  Classes, SysUtils,

  {$IFNDEF CLX}
  {$IFDEF D9}
  Types,
  {$ENDIF}
  {$ENDIF}

  TeCanvas, TeeProcs, TeEngine, Chart;

type
  TTableLegend=class(TTeeCustomShape)
  private
    FFontColor : Boolean;
    FOtherSide : Boolean;
    FSymbol    : TLegendSymbol;

    function CalcSymbolHeight:Integer;
    procedure SetFontColor(const Value: Boolean);
    procedure SetSymbol(const Value: TLegendSymbol);
    procedure SetOtherSide(const Value: Boolean);
  protected
    Procedure SetParent(Value:TCustomTeePanel); override;
  public
    Constructor Create(AOwner: TCustomTeePanel); overload; override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
  published
    property Brush;
    property Color;
    property Font;
    property FontSeriesColor:Boolean read FFontColor write SetFontColor default False;
    property Gradient;
    property OtherSide:Boolean read FOtherSide write SetOtherSide default False;
    property Pen;
    property Symbol:TLegendSymbol read FSymbol write SetSymbol;
    property Transparency;
    property Transparent default True;
    property Visible;
  end;

  TDataTableTool=class;

  TDataTableFilterSeries=procedure(Sender:TDataTableTool; Series:TChartSeries;
                                   var Accept:Boolean) of object;

  TDataTableTool=class(TTeeCustomTool)
  private
    FAutoPos     : Boolean;
    FClipText    : Boolean;
    FColumnPen   : TChartPen;
    FFont        : TTeeFont;
    FInverted    : Boolean;
    FLeft        : Integer;
    FLegend      : TTableLegend;
    FOnFilterSeries : TDataTableFilterSeries; 
    FTop         : Integer;

    function CalcMaxSeriesCount:Integer;
    function CalcPosLabels(Axis:TChartAxis; Value:Integer):Integer;
    function CalcTableSize(Axis:TChartAxis):Integer;
    function Chart:TCustomChart;
    procedure Draw;
    function GetRowPen: TChartPen;
    function GuessAxis:TChartAxis;
    function ItemText(Series:TChartSeries; ValueIndex:Integer):String;
    function LegendWidth(var SymbolWidth:Integer):Integer;
    procedure SetAutoPos(const Value: Boolean);
    procedure SetClipText(const Value: Boolean);
    procedure SetColumnPen(const Value: TChartPen);
    procedure SetFont(const Value: TTeeFont);
    procedure SetInverted(const Value: Boolean);
    procedure SetLeft(const Value: Integer);
    procedure SetLegend(const Value: TTableLegend);
    procedure SetRowPen(const Value: TChartPen);
    procedure SetTop(const Value: Integer);
    function TableSize:Integer;
    function ValidSeries(Index:Integer):Boolean;
    function VisibleSeriesCount:Integer;
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    class function GetEditorClass: String; override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property AutoPosition:Boolean read FAutoPos write SetAutoPos default True;
    property Brush;
    property ClipText:Boolean read FClipText write SetClipText default True;
    property ColumnPen:TChartPen read FColumnPen write SetColumnPen;
    property Font:TTeeFont read FFont write SetFont;
    property Inverted:Boolean read FInverted write SetInverted default False;
    property Left:Integer read FLeft write SetLeft default 0;
    property Legend:TTableLegend read FLegend write SetLegend;
    property RowPen:TChartPen read GetRowPen write SetRowPen;
    property Top:Integer read FTop write SetTop default 0;

    // events
    property OnFilterSeries:TDataTableFilterSeries read FOnFilterSeries
                                                   write FOnFilterSeries; // 8.01
  end;

implementation

uses
  Math, TeeProCo;

Constructor TDataTableTool.Create(AOwner: TComponent);
begin
  inherited;
  FAutoPos:=True;
  FClipText:=True;
  FLegend:=TTableLegend.Create(nil);
  FFont:=TTeeFont.Create(CanvasChanged);
  FColumnPen:=TChartPen.Create(CanvasChanged);
end;

Destructor TDataTableTool.Destroy;
begin
  FColumnPen.Free;
  FFont.Free;
  FLegend.Free;
  inherited;
end;

function TDataTableTool.ValidSeries(Index:Integer):Boolean;
begin
  with Chart[Index] do
       result:=(not HasZValues) and Visible;

  if Assigned(FOnFilterSeries) then
     FOnFilterSeries(Self,Chart[Index],result);
end;

function TDataTableTool.GuessAxis:TChartAxis;
var t : Integer;
begin
  // Guess Axis
  for t:=0 to Chart.SeriesCount-1 do
  if ValidSeries(t) then
      with Chart[t] do
      begin
        if YMandatory then
           result:=GetHorizAxis
        else
           result:=GetVertAxis;

        Exit;
      end;

  result:=nil;
end;

function TDataTableTool.CalcMaxSeriesCount:Integer;
var t : Integer;
begin
  result:=0;

  for t:=0 to Chart.SeriesCount-1 do
  if ValidSeries(t) then
     result:=Math.Max(result,Chart[t].Count);

  if Chart.Pages.MaxPointsPerPage<>0 then // 8.01 TV52012279
     result:=Min(result,Chart.Pages.MaxPointsPerPage);
end;

function TDataTableTool.VisibleSeriesCount:Integer;
var t : Integer;
begin
  result:=0;

  for t:=0 to Chart.SeriesCount-1 do
  if ValidSeries(t) then
     Inc(result);
end;

function TDataTableTool.ItemText(Series:TChartSeries; ValueIndex:Integer):String;
var tmpValue : TChartValue;
begin
  tmpValue:=Series.GetMarkValue(ValueIndex);

  if Series.MandatoryValueList.DateTime then
     DateTimeToString(result,DateTimeDefaultFormat(tmpValue),tmpValue)
  else
     result:=FormatFloat(Series.ValueFormat,tmpValue);
end;

function TDataTableTool.CalcTableSize(Axis:TChartAxis):Integer;
var t  : Integer;
    tt : Integer;
begin
  if Legend.Visible then
  begin
    Chart.Canvas.AssignFont(Legend.Font);
    result:=Chart.Canvas.FontHeight;
  end
  else
    result:=0;

  // Prepare Font
  Chart.Canvas.AssignFont(Font);

  if Axis.Horizontal then
     result:=Max(result,Chart.Canvas.FontHeight)
  else
  begin
    for t:=0 to Chart.SeriesCount-1 do
    if ValidSeries(t) then
    with Chart[t] do
         for tt:=0 to Count-1 do
             result:=Max(result, Chart.Canvas.TextWidth(ItemText(Chart[t],tt)));

    // Margins
    Inc(result,Chart.Canvas.FontHeight div 2);
  end;
end;

type
  TSymbolAccess=class(TLegendSymbol);

function TDataTableTool.LegendWidth(var SymbolWidth:Integer):Integer;
var t : Integer;
begin
  result:=0;

  Chart.Canvas.AssignFont(FLegend.Font);

  for t:=0 to Chart.SeriesCount-1 do
  if ValidSeries(t) then
     result:=Math.Max(result,Chart.Canvas.TextWidth(SeriesTitleOrName(Chart[t])));

  Inc(result,Chart.Canvas.FontHeight);

  if Legend.Symbol.Visible then
     SymbolWidth:=TSymbolAccess(Legend.Symbol).CalcWidth(result)
  else
     SymbolWidth:=0;

  Inc(result,SymbolWidth);
end;

type
  TAxisAccess=class(TChartAxis);

procedure TDataTableTool.Draw;
var tmpItemSize,
    ISizeLabels,
    MaxSeriesCount : Integer;
    Axis : TChartAxis;
    TableHorizontal : Boolean;
    tmpOffset : Integer;
    tmpPos : Integer;

  function ColRowPos(SeriesIndex:Integer):Integer;
  var tmp,t : Integer;
  begin
    tmp:=0;

    if Inverted then
    begin
      for t:=Chart.SeriesCount-1 downto SeriesIndex+1 do
      if ValidSeries(t) then
         Inc(tmp);
    end
    else
    for t:=0 to SeriesIndex-1 do
    if ValidSeries(t) then
       Inc(tmp);

    if TableHorizontal then
       tmp:=ISizeLabels+(tmpItemSize*(tmp+1))
    else
       tmp:=ISizeLabels+(tmpItemSize*(tmp));

    if Axis.OtherSide then
       tmp:=-tmp;

    if TableHorizontal then
       result:=tmpPos+tmp
    else
       result:=tmpPos-tmp;
  end;

  procedure ColDivider(Pos:Integer);
  var tmpMax : Integer;
      tmp    : Integer;
  begin
    if Inverted then
       tmpMax:=ColRowPos(-1)
    else
       tmpMax:=ColRowPos(Chart.SeriesCount);

    if AutoPosition then
       tmp:=tmpPos
    else
    begin
      if Inverted then
         tmp:=ColRowPos(Chart.SeriesCount)
      else
         tmp:=ColRowPos(-1);
    end;

    with {$IFNDEF CLR}TAxisAccess{$ENDIF}(Axis) do
    if TableHorizontal then
       if OtherSide then
          Chart.Canvas.DoVertLine(tmpOffset+Pos, tmp, tmpMax-1)
       else
          Chart.Canvas.DoVertLine(tmpOffset+Pos, tmp, tmpMax+1)
    else
       Chart.Canvas.DoHorizLine(tmp, tmpMax, tmpOffset+Pos)
  end;

  function SeriesToPos(SeriesIndex:Integer):Integer;
  begin
    if TableHorizontal then
    begin
      if Axis.OtherSide then
         if Inverted then
            result:=SeriesIndex-1
         else
            result:=SeriesIndex+1
      else
         result:=SeriesIndex;
    end
    else
    begin
      if Inverted then
         result:=SeriesIndex-1
      else
         result:=SeriesIndex+1;

      if Axis.OtherSide then
         if Inverted then
            Inc(result)
         else
            Dec(result);
    end;
  end;

  procedure DoText(Pos,TextIndex,SeriesIndex:Integer);
  var s        : String;
      tmp      : Integer;
  begin
    with Chart[SeriesIndex] do
    begin
      with Chart.Pages do
      if MaxPointsPerPage>0 then
         tmp:=LastValueIndex-TextIndex+1
      else
         tmp:=MaxSeriesCount-TextIndex;

      if (tmp>=0) and (Count>tmp) and (not IsNull(tmp)) then
      begin
        s:=ItemText(Chart[SeriesIndex],tmp);

        tmp:=ColRowPos(SeriesToPos(SeriesIndex));

        if TableHorizontal then
           Chart.Canvas.TextOut(tmpOffset+Pos, tmp, s)
        else
           Chart.Canvas.TextOut(tmp+1+(Chart.Canvas.FontHeight div 4),
                             tmpOffset+Pos-(Chart.Canvas.FontHeight div 2), s);
      end;
    end;
  end;

  procedure DrawLegend(x0,x1:Integer);
  var w              : Integer;
      tmpSymbolWidth : Integer;

    procedure DrawLegendItem(Index:Integer);
    var s   : String;
        tmp : Integer;
        p   : Integer;
        r   : TRect;
    begin
      if ValidSeries(Index) then
      begin
        s:=SeriesTitleOrName(Chart[Index]);

        tmp:=ColRowPos(SeriesToPos(Index));

        Chart.Canvas.BackMode:=cbmTransparent;

        p:=x0+4;

        if Legend.Symbol.Visible then
           if Legend.Symbol.Position=spLeft then
              Inc(p,tmpSymbolWidth+4);

        if Legend.FFontColor then
           Chart.Canvas.Font.Color:=Chart[Index].Color;

        if TableHorizontal then
           Chart.Canvas.TextOut(p,tmp,s)
        else
        if Legend.Symbol.Visible and (Legend.Symbol.Position=spRight) then
           Chart.Canvas.RotateLabel(tmp+4,x1+w-4,s,90)
        else
           Chart.Canvas.RotateLabel(tmp+4,x1+w-4-tmpSymbolWidth-4,s,90);

        if Legend.Symbol.Visible then
        begin
          if TableHorizontal then
             if Legend.Symbol.Position=spLeft then
                r:=TeeRect(x0+4,tmp+4,x0+4+tmpSymbolWidth,tmp+12)
             else
                r:=TeeRect(x0+w-4-tmpSymbolWidth,tmp+4,x0+w-4,tmp+12)
          else
          if Legend.Symbol.Position=spLeft then
             r:=TeeRect(tmp+6,x1+w-4,tmp+6+12,x1+w-4-tmpSymbolWidth)
          else
             r:=TeeRect(tmp+6,x1+4,tmp+6+tmpSymbolWidth,x1+4+tmpSymbolWidth);

          r:=OrientRectangle(r);

          if Legend.Symbol.Gradient.Visible then
             TSymbolAccess(Legend.Symbol).Draw(Chart[Index].Color,r)
          else
             Chart[Index].DrawLegend(-1,r);
        end;
      end;
    end;

  var t : Integer;
      tmp : Integer;
  begin
    Chart.Canvas.AssignFont(FLegend.Font);
    Chart.Canvas.TextAlign:=TA_LEFT;

    w:=LegendWidth(tmpSymbolWidth);

    if TableHorizontal then
    begin
      if Legend.OtherSide then tmp:=x1
                          else tmp:=x0;

      Chart.Canvas.DoVertLine(tmp,ColRowPos(-1),ColRowPos(Chart.SeriesCount));
    end
    else
    begin
      tmp:=x1;
      if Legend.OtherSide then Inc(tmp,w);

      Chart.Canvas.DoHorizLine(ColRowPos(-1),ColRowPos(Chart.SeriesCount),tmp);
    end;

    if Inverted then
       for t:=Chart.SeriesCount-1 downto 0 do
           DrawLegendItem(t)
    else
       for t:=0 to Chart.SeriesCount-1 do
           DrawLegendItem(t);
  end;

  procedure CalcPositions;
  begin
    if AutoPosition then
    begin
      tmpPos:=Axis.PosAxis;
      tmpOffset:=0;

      if TableHorizontal then
      begin
        if Axis.OtherSide and Chart.View3D then
        begin
          tmpPos:=tmpPos-Chart.SeriesWidth3D;
          tmpOffset:=Chart.SeriesWidth3D;
        end;

        Top:=tmpPos;
        Left:=0;
      end
      else
      begin
        if Axis.OtherSide and Chart.View3D then
        begin
          tmpPos:=tmpPos+Chart.SeriesWidth3D;
          tmpOffset:=-Chart.SeriesWidth3D;
        end;

        Left:=tmpPos;
        Top:=0;
      end;
    end
    else
    begin
      if TableHorizontal then
      begin
        tmpPos:=Top;
        tmpOffset:=Left;
      end
      else
      begin
        tmpPos:=Left;
        tmpOffset:=Top;
      end;
    end;
  end;

  procedure AssignPen;
  begin
    if TableHorizontal then
       Chart.Canvas.AssignVisiblePen(ColumnPen)
    else
       Chart.Canvas.AssignVisiblePen(RowPen);
  end;

var t,
    tt,
    l,
    tmpW,
    Old,
    x0,
    x1        :Integer;
    TicksDown : Boolean;
begin
  if VisibleSeriesCount>0 then
  with Chart.Canvas do
  begin
    Axis:=GuessAxis;
    ISizeLabels:=TAxisAccess(Axis).SizeLabels+Axis.PosAxis-Axis.PosLabels;

    TableHorizontal:=Axis.Horizontal;

    tmpItemSize:=CalcTableSize(Axis);

    if TableHorizontal then
       TextAlign:=TA_CENTER
    else
       TextAlign:=TA_LEFT;

    BackMode:=cbmTransparent;

    // Find Series with maximum number of points
    MaxSeriesCount:=CalcMaxSeriesCount;

    CalcPositions;

    with {$IFNDEF CLR}TAxisAccess{$ENDIF}(Axis) do
    begin
      l:=Length(Tick);

      if l>=2 then
      begin
        TicksDown:=Tick[0]<Tick[1];
        if not TableHorizontal then TicksDown:=not TicksDown;
        if Inverted then TicksDown:=not TicksDown;
      end
      else TicksDown:=False;

      AssignPen;
      AssignFont(Self.FFont);

      // Draw 1 row-col to last
      for t:=0 to l-2 do
      begin
        ColDivider((Tick[t+1]+Tick[t]) div 2);

        for tt:=0 to Chart.SeriesCount-1 do
        if ValidSeries(tt) then
            if TicksDown then
               DoText(Tick[t],MaxSeriesCount-t,tt)
            else
               DoText(Tick[t],t+1,tt);
      end;

      // Draw 0 row-col
      if l>0 then
      begin
        for tt:=0 to Chart.SeriesCount-1 do
        if ValidSeries(tt) then
            if TicksDown then
               DoText(Tick[l-1],1,tt)
            else
               DoText(Tick[l-1],l,tt);

        if l=1 then
           if Horizontal then x0:=IStartPos
                         else x0:=IEndPos
        else
        begin
          x0:=Tick[l-1]-((Tick[l-2]-Tick[l-1]) div 2);

          if Horizontal then x0:=Max(x0,IStartPos)
                        else x0:=Min(x0,IEndPos);
        end;

        if Self.Font.Gradient.Visible then
           AssignPen;

        ColDivider(x0);

        if l=1 then
           if Horizontal then x1:=IEndPos
                         else x1:=IStartPos
        else
        begin
          x1:=Tick[0]+((Tick[0]-Tick[1]) div 2);
          if Horizontal then x1:=Min(x1,IEndPos)
                        else x1:=Max(x1,IStartPos);
        end;

        ColDivider(x1);
      end
      else
      begin
        x0:=IStartPos;
        x1:=IEndPos;
      end;
    end;

    Inc(x0,tmpOffset);
    Inc(x1,tmpOffset);

    if FLegend.Visible then
    begin
      if TicksDown and TableHorizontal then SwapInteger(x0,x1);
      if TicksDown and (not TableHorizontal) then SwapInteger(x0,x1);
      if Axis.Inverted then SwapInteger(x0,x1);

      tmpW:=LegendWidth(tmpW);

      if TableHorizontal then
         Dec(x0,tmpW)
      else
         Dec(x1,tmpW);

      if Legend.OtherSide then
      begin
        if TableHorizontal then
        begin
          Old:=x0;
          x0:=x1;
          Inc(x1,tmpW);
        end
        else
        begin
          Old:=x1;
          x1:=x0;
          Dec(x0,tmpW);
        end;
      end
      else
        Old:=0;

      DrawLegend(x0,x1);

      if Legend.OtherSide then
      begin
        if not TableHorizontal then
        begin
          x0:=x1+tmpW;
          x1:=Old+tmpW;
        end
        else
          x0:=Old+tmpW;
      end;
    end;

    // Draw other divider lines
    if TableHorizontal then
       AssignVisiblePen(Self.RowPen)
    else
       AssignVisiblePen(Self.ColumnPen);

    for t:=-1 to Chart.SeriesCount do
    if (t<0) or (t=Chart.SeriesCount) or ValidSeries(t) then
       if TableHorizontal then
          DoHorizLine(x0,x1,ColRowPos(t))
       else
          DoVertLine(ColRowPos(t),x0,x1);
  end;
end;

{ TDataTableTool }

procedure TDataTableTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if AEvent=cteAfterDraw then
     Draw;
end;

class function TDataTableTool.Description: String;
begin
  result:=TeeMsg_DataTableTool;
end;

function TDataTableTool.Chart: TCustomChart;
begin
  result:=ParentChart as TCustomChart;
end;

procedure TDataTableTool.SetAutoPos(const Value: Boolean);
begin
  SetBooleanProperty(FAutoPos,Value);
end;

procedure TDataTableTool.SetLegend(const Value: TTableLegend);
begin
  FLegend := Value;
end;

{$IFNDEF CLR}
type
  TAxesAccess=class(TChartAxes);
{$ENDIF}

procedure TDataTableTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  if Assigned(ParentChart) and
     (not (csDestroying in ParentChart.ComponentState)) then
          {$IFNDEF CLR}TAxesAccess{$ENDIF}(ParentChart.Axes).CalcPosLabels:=nil;

  inherited;

  if not (csDestroying in ComponentState) then
  begin
    Legend.ParentChart:=ParentChart;

    if Assigned(ParentChart) then
       {$IFNDEF CLR}TAxesAccess{$ENDIF}(ParentChart.Axes).CalcPosLabels:=CalcPosLabels;

    Repaint;
  end;
end;

function TDataTableTool.TableSize:Integer;
begin
  if GuessAxis.Horizontal then result:=10
                          else result:=16;

  Inc(result,VisibleSeriesCount*CalcTableSize(GuessAxis));
end;

// Intercept axis labels position calculation, at TeEngine Axis.CalcRect
function TDataTableTool.CalcPosLabels(Axis:TChartAxis; Value:Integer):Integer;
var tmp  : TChartAxis;
    tmpL : Integer;
    tmpW : Integer;
    tmpR : TRect;
begin
  result:=Value;

  if Active and (not Axis.IsDepthAxis) and AutoPosition then
  begin
    tmp:=GuessAxis;

    if Assigned(tmp) then
    begin
      if Axis=tmp then
         Inc(result,TableSize)
      else
      if Legend.Visible then
      begin
        tmpL:=LegendWidth(tmpW);

        if tmp.Horizontal then
        begin
          if not Axis.Horizontal then
             if (not Legend.OtherSide) and (not Axis.OtherSide) then
                 result:=Max(Value,tmpL)
             else
             if Legend.OtherSide and Axis.OtherSide then
             begin
               tmpR:=Chart.ChartBounds;
               result:=Max(Value,tmpL-(tmpR.Right-Chart.ChartRect.Right));
             end;
        end
        else
          if Axis.Horizontal then
             if (not Legend.OtherSide) and Axis.OtherSide then
                result:=Max(Value,tmpL)
             else
             if Legend.OtherSide and (not Axis.OtherSide) then
             begin
               tmpR:=Chart.ChartBounds;
               result:=Max(Value,tmpL-(tmpR.Bottom-Chart.ChartRect.Bottom));
             end;
      end;
    end;
  end;
end;

procedure TDataTableTool.SetFont(const Value: TTeeFont);
begin
  FFont.Assign(Value);
end;

function TDataTableTool.GetRowPen: TChartPen;
begin
  result:=Pen;
end;

procedure TDataTableTool.SetColumnPen(const Value: TChartPen);
begin
  FColumnPen.Assign(Value);
end;

procedure TDataTableTool.SetRowPen(const Value: TChartPen);
begin
  Pen:=Value;
end;

procedure TDataTableTool.SetInverted(const Value: Boolean);
begin
  SetBooleanProperty(FInverted,Value);
end;

class function TDataTableTool.GetEditorClass: String;
begin
  result:='TDataTableEditor'; // Do not localize
end;

procedure TDataTableTool.SetLeft(const Value: Integer);
begin
  SetIntegerProperty(FLeft,Value);
end;

procedure TDataTableTool.SetTop(const Value: Integer);
begin
  SetIntegerProperty(FTop,Value);
end;

procedure TDataTableTool.SetClipText(const Value: Boolean);
begin
  SetBooleanProperty(FClipText,Value);
end;

class function TDataTableTool.LongDescription: String;
begin
  result:=TeeMsg_DataTableDesc;
end;

{ TTableLegend }
Constructor TTableLegend.Create(AOwner: TCustomTeePanel);
begin
  inherited;

  FSymbol:=TLegendSymbol.Create(AOwner);
  TSymbolAccess(FSymbol).CalcItemHeight:=CalcSymbolHeight;
  DefaultTransparent:=True;
  Transparent:=True;
end;

Destructor TTableLegend.Destroy;
begin
  FSymbol.Free;
  inherited;
end;

procedure TTableLegend.SetFontColor(const Value: Boolean);
begin
  if FFontColor<>Value then
  begin
    FFontColor:=Value;
    Repaint;
  end;
end;

function TTableLegend.CalcSymbolHeight:Integer;
begin
  result:=FSymbol.Width;
end;

procedure TTableLegend.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TTableLegend then
  begin
    FFontColor:=TTableLegend(Source).FFontColor;
    Symbol:=TTableLegend(Source).Symbol;
  end;
end;

procedure TTableLegend.SetParent(Value: TCustomTeePanel);
begin
  inherited;

  if Assigned(Symbol) then
     Symbol.Parent:=Value;
end;

procedure TTableLegend.SetSymbol(const Value: TLegendSymbol);
begin
  FSymbol.Assign(Value);
end;

procedure TTableLegend.SetOtherSide(const Value: Boolean);
begin
  if FOtherSide<>Value then
  begin
    FOtherSide:=Value;
    Repaint;
  end;
end;

initialization
  RegisterTeeTools([TDataTableTool]);
finalization
  UnRegisterTeeTools([TDataTableTool]);
end.
