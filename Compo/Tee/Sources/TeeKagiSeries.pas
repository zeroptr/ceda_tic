{********************************************}
{  TeeChart Pro Charting Library             }
{  Kagi Financial Series                     }
{  Copyright (c) 2009 by Marjan Slatinek     }
{  All Rights Reserved                       }
{********************************************}
unit TeeKagiSeries;
{$I TeeDefs.inc}

// The Kagi financial chart.
//
// Kagi charts, at first glance, look like swing charts. Like swing charts, they have no time axis
// and are made up of a series of vertical lines, however in the case of kagi charts, the vertical
// lines are based solely on the action of closing prices, not a bar's high and low prices. Another
// difference is that the thickness of a kagi chart line changes when closing prices penetrate the
// previous column top or bottom.
//
// Construction of Kagi Chart:
//
// Choose a reversal amount - absolute or relative value.
// Note the first closing price in your data. This is called the BasePrice.
// If the closing price of Day 2 is greater than the closing price of Day 1
//    (the base price), use UpSwing stype to draw vertical line upwards from
//    the closing price of Day 1 to the closing price of Day 2.
// If the closing price of Day 2 is less than the closing price of Day 1,
//    use DownPen style to draw vertical line downwards from the closing price
//    of Day 1 to the closing price of Day 2.
// If the closing price of Day 2 is equal to the closing price of Day 1,
//    do nothing. Instead, wait until the end of Day 3, and compare this price
//    with the base price.
// If the closing price continues to rise (or fall), we keep moving the kagi
//    chart up (or down) to the close of each day, regardless of how much or
//    how little it moves.
// If the closing price moves in the opposite direction by less than a
//    predetermined number of cents, the reversal amount, we ignore the small
//    move and do nothing to our chart.
// If the kagi line has been moving upwards, and the closing price has fallen
//    by more than the reversal amount, we draw a short horizontal line,
//    called the 'inflection line', then a new line downwards, to the lower
//    close of that day.
// If the kagi line has been moving downwards, and the closing price has risen
//    by more than the reversal amount, we draw an inflection line, then a new
//    line upwards, to the higher close of that day.
//
// Vertical drawing pen style is defined by the following rules:
//
// If a DownSwing line is extended beyond the previous swing high,
//    pen style is change to UpSwing penbeyond that point.
//
// An UpSwing pen changes to DownSwing pen when the UpSwing line moves below
//    the previous swing low.

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  {$ENDIF}
  TeCanvas, TeEngine, TeePenDlg;

type
  TKagiSeries=class(TChartSeries)
  private
    FAbsReversal    : Boolean;
    FBuySymbol      : TSeriesPointer;
    FDownSwing      : TChartPen;
    FReversalAmount : Double;
    FSellSymbol     : TSeriesPointer;
    FUpSwing        : TChartPen;

    function BasePrice:Double;
    function CalcSegments(Draw:Boolean):Integer;
    procedure DrawHorizLine(const y,FromValue,ToValue:Double);
    procedure DrawVertLine(const x,FromValue,ToValue:Double);
    function GetCloseValues:TChartValueList;
    function Reversal(const Value:Double; const History:Array of Double):Boolean;
    procedure SetAbsoluteReversal(const Value:Boolean);
    procedure SetBuySymbol(const Value:TSeriesPointer);
    procedure SetDownSwing(const Value:TChartPen);
    procedure SetReversalAmount(const Value:Double);
    procedure SetSellSymbol(const Value:TSeriesPointer);
    procedure SetUpSwing(const Value:TChartPen);
  protected
    Procedure DrawAllValues; override;
    class function GetEditorClass: String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    procedure SetParentChart(const Value:TCustomAxisPanel); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    Function CountLegendItems:Integer; override;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;
    Function MaxXValue:Double; override;
    Function NumSampleValues:Integer; override;

    property CloseValues:TChartValueList read GetCloseValues;
  published
    property AbsoluteReversal:Boolean read FAbsReversal
                                      write SetAbsoluteReversal default False;
    property BuySymbol:TSeriesPointer read FBuySymbol write SetBuySymbol;
    property DownSwing:TChartPen read FDownSwing write SetDownSwing;
    property ReversalAmount:Double read FReversalAmount write SetReversalAmount;
    property SellSymbol:TSeriesPointer read FSellSymbol write SetSellSymbol;
    property UpSwing:TChartPen read FUpSwing write SetUpSwing;

    { Published declarations }
    property Active;
    property Brush;
    property ColorSource;
    property Cursor;
    property Depth;
    property HorizAxis;
    property Marks;
    property ParentChart;
    property Pen;
    property DataSource;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend;
    property Title;
    property ValueFormat;
    property VertAxis;
    property XLabelsSource;
    property XValues;
    property YValues;

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

  TKagiSeriesEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    BUp: TButtonPen;
    BDown: TButtonPen;
    TabBuy: TTabSheet;
    TabSell: TTabSheet;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Kagi : TKagiSeries;
  public
    { Public declarations }
  end;

implementation

uses
  Math, TeeProCo, Chart, TeePoEdi, TeeProcs;

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{ TKagiSeries }
Constructor TKagiSeries.Create(AOwner: TComponent);
begin
  inherited;

  AllowSinglePoint:=False;
  XValues.DateTime:=False;

  FReversalAmount:=0.03;

  // upswing and downswing
  FUpSwing := CreateChartPen;
  FUpSwing.Color:=clGreen;
  FUpSwing.Width := 3;

  FDownSwing := CreateChartPen;
  FDownSwing.Color:=clRed;
  FDownSwing.Width := 1;

  // buy symbol
  FBuySymbol := TSeriesPointer.Create(Self);
  FBuySymbol.Style := psTriangle;
  FBuySymbol.Color := clGreen;

  // sell symbol
  FSellSymbol := TSeriesPointer.Create(Self);
  FSellSymbol.Style := psDownTriangle;
  FSellSymbol.Color := clRed;
end;

Destructor TKagiSeries.Destroy;
begin
  FDownSwing.Free;
  FUpSwing.Free;

  FreeAndNil(FBuySymbol);
  FreeAndNil(FSellSymbol);

  inherited;
end;

procedure TKagiSeries.Assign(Source:TPersistent);
begin
  if Source is TKagiSeries then
  with TKagiSeries(Source) do
  begin
    Self.FAbsReversal:=FAbsReversal;
    Self.BuySymbol:=FBuySymbol;
    Self.DownSwing:=FDownSwing;
    Self.FReversalAmount:=FReversalAmount;
    Self.SellSymbol:=FSellSymbol;
    Self.UpSwing:=FUpSwing;
  end;

  inherited;
end;

// Calculate if it is a Reversal point.
// Value = Current point.
// History = Stores last two previous points in Kagi chart.
// Returns True, if current point is 'reversal point'.
function TKagiSeries.Reversal(const Value:Double; const History:Array of Double):Boolean;
var offset : Double;
begin
  if FAbsReversal then
     offset:=FReversalAmount
  else
     offset:=History[0] * FReversalAmount;

  result:= (Abs(Value - History[0]) > offset) and
           ((Value-History[0]) * (History[0] - History[1]) < 0);
end;

function TKagiSeries.CalcSegments(Draw:Boolean):Integer;
var HistPoints : Array[0..1] of Double;
    sStart : Double;
    i,j : Integer;
    Up : Boolean;
    tmpUpPen : Boolean;
begin
  result:=0;

  if Count > 1 then
  begin
    tmpUpPen:=False;

    // First find first closing value different from base price
    i:=1;
    while (CloseValues.Value[i] = BasePrice) and (i < Count) do
        Inc(i);

    if i < Count then
    begin
      if Draw then
      begin
        // define pen style
        tmpUpPen:=CloseValues.Value[i] > BasePrice;
        if tmpUpPen then
           ParentChart.Canvas.AssignVisiblePen(FUpSwing)
        else
           ParentChart.Canvas.AssignVisiblePen(FDownSwing);

        // initial vertical line
        DrawVertLine(result,BasePrice,CloseValues[i]);
      end;

      Inc(result);

      Histpoints[0]:=CloseValues[i];
      Histpoints[1]:=BasePrice;
      sStart:=BasePrice;

      // Process the rest of the points
      for j:= i + 1 to Count-1 do
      begin
        if Reversal(CloseValues[j],histpoints) then // Reversal ?
        begin
          if Draw then
          begin
            // Draw horizontal inflection line using the same pen style
            DrawHorizLine(histpoints[0], result - 1, result);

            // check if value exceeds previous segment
            up:= CloseValues.Value[j]>histpoints[0];

            if up and (CloseValues.Value[j] > sstart) then
            begin
              DrawVertLine(result, histpoints[0], sstart);

              // if required, draw buy symbol
              if FBuySymbol.Visible and (not tmpUpPen) then
              begin
                FBuySymbol.PrepareCanvas(ParentChart.Canvas,FBuySymbol.Color);
                FBuySymbol.Draw(CalcXPosValue(result),
                                CalcYPosValue(sstart),
                                Fbuysymbol.Color, Fbuysymbol.Style);
              end;

              // Change pen style
              ParentChart.Canvas.AssignVisiblePen(FUpSwing);
              tmpUpPen:=True;
              DrawVertLine(result, sstart, CloseValues[j]);
            end
            else
            if (not Up) and (CloseValues.Value[j] < sStart) then
            begin
              DrawVertLine(result, Histpoints[0], sStart);

              // if required, draw sell symbol
              if sellsymbol.Visible and tmpUpPen then
              begin
                FSellSymbol.PrepareCanvas(ParentChart.Canvas, FSellSymbol.Color);
                FSellSymbol.Draw(CalcXPosValue(result),
                                 CalcYPosValue(sStart),
                                 FSellSymbol.Color, FSellSymbol.Style);
              end;

              // Change pen style
              ParentChart.Canvas.AssignVisiblePen(FDownSwing);
              tmpUpPen:=False;
              DrawVertLine(result, sStart, CloseValues[j]);
            end
            else
              DrawVertLine(result, Histpoints[0], CloseValues[j]);
          end;

          // increase segment number
          Inc(result);

          // update last two values
          Histpoints[1] := Histpoints[0];
          Histpoints[0] := CloseValues[j];

          // update segment start point (min or max)
          sStart := CloseValues[j];
        end
        else
        if (CloseValues[j]-Histpoints[0])*(Histpoints[0]-Histpoints[1])>0 then
        // add vertical line only if trend continues in the same direction
        begin
          if Draw then
             DrawVertLine(result-1, histpoints[0], CloseValues[j]);

          // update last two values
          Histpoints[1] := Histpoints[0];
          Histpoints[0] := CloseValues[j];
        end;
      end;
    end;
  end;
end;

procedure TKagiSeries.DrawVertLine(const x,FromValue,ToValue:Double);
begin
  ParentChart.Canvas.VertLine3D(CalcXPosValue(x),CalcYPosValue(FromValue),
                                CalcYPosValue(ToValue), MiddleZ);
end;

procedure TKagiSeries.DrawHorizLine(const y,FromValue,ToValue:Double);
begin
  ParentChart.Canvas.HorizLine3D(CalcXPosValue(FromValue),CalcXPosValue(ToValue),
                                 CalcYPosValue(y),MiddleZ);
end;

procedure TKagiSeries.DrawAllValues;
begin
  inherited;
  CalcSegments(True);
end;

function TKagiSeries.MaxXValue:Double;
begin
  result:=CalcSegments(False)-1;
end;

procedure TKagiSeries.SetParentChart(const Value:TCustomAxisPanel);
begin
  inherited;

  if Assigned(FSellSymbol) then
     FSellSymbol.ParentChart:=Value;

  if Assigned(FBuySymbol) then
     FBuySymbol.ParentChart:=Value;
end;

function TKagiSeries.NumSampleValues:Integer;
begin
  result:=10;
end;

procedure TKagiSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;

  FillSampleValues(16);
  
  if not IsEnabled then
  begin
    BuySymbol.Color := clSilver;
    BuySymbol.Pen.Color := clGray;
    SellSymbol.Color := clSilver;
    SellSymbol.Pen.Color := clGray;
  end;
end;

// Reversal ammount (percentage or absolute value)
// Defines the reversal amount.
procedure TKagiSeries.SetReversalAmount(const Value:Double);
begin
  SetDoubleProperty(FReversalAmount, Value);
end;

// If false, reversal amount is treated as percentage, otherwise as absolute value.
// Defines if reversal amount is treated as absolute or relative value.
procedure TKagiSeries.SetAbsoluteReversal(const Value:Boolean);
begin
  SetBooleanProperty(FAbsReversal, Value);
end;

// Controls the appearance of upswing lines.
// Pen used to draw "upswing" lines.
procedure TKagiSeries.SetUpSwing(const Value:TChartPen);
begin
  FUpSwing.Assign(Value);
end;

// Controls the appearance of downswing lines.
// Pen used to draw "downswing" lines.
procedure TKagiSeries.SetDownSwing(const Value:TChartPen);
begin
  FDownSwing.Assign(Value);
end;

// Trading close values.
// Gets and sets all Stock market closing values.
function TKagiSeries.GetCloseValues:TChartValueList;
begin
  result:=YValues;
end;

// The base price i.e. first closing value.
function TKagiSeries.BasePrice:Double;
begin
  if Count>0 then result:=CloseValues[0]
             else result:=0;
end;

function TKagiSeries.CountLegendItems:Integer;
begin
  result:=2;
end;

function TKagiSeries.LegendItemColor(LegendIndex:Integer):TColor;
begin
  if LegendIndex=0 then result:=UpSwing.Color
                   else result:=DownSwing.Color;
end;

function TKagiSeries.LegendString( LegendIndex:Integer;
                                    LegendTextStyle:TLegendTextStyle ):String;
begin
  if LegendIndex=0 then result:=TeeMsg_Up
                   else result:=TeeMsg_Down;
end;

procedure TKagiSeries.SetBuySymbol(const Value: TSeriesPointer);
begin
  FBuySymbol.Assign(Value);
end;

procedure TKagiSeries.SetSellSymbol(const Value: TSeriesPointer);
begin
  FSellSymbol.Assign(Value);
end;

class function TKagiSeries.GetEditorClass: String;
begin
  result:='TKagiSeriesEditor';
end;

{ TKagiSeriesEditor }
procedure TKagiSeriesEditor.FormShow(Sender: TObject);

  procedure AddEditor(ATab:TTabSheet; ASymbol:TSeriesPointer);
  var tmp : TSeriesPointerEditor;
  begin
    tmp:=TSeriesPointerEditor.Create(Self);
    tmp.Align:=alClient;
    TeeTranslateControl(tmp);
    AddFormTo(tmp,ATab,ASymbol);
  end;

begin
  Kagi:=TKagiSeries(Tag);

  if Assigned(Kagi) then
  with Kagi do
  begin
    BUp.LinkPen(UpSwing);
    BDown.LinkPen(DownSwing);

    AddEditor(TabBuy,BuySymbol);
    AddEditor(TabSell,SellSymbol);
  end;
end;

initialization
  RegisterTeeSeries( TKagiSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryKagi,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial, 1 );

  RegisterClass(TKagiSeriesEditor);
finalization
  UnRegisterTeeSeries([TKagiSeries]);
end.

