{**********************************************}
{   TCandleSeries (derived from OHLCSeries)    }
{   TVolumeSeries (derived from TCustomSeries) }
{   TRSIFunction  (Resistance Strength Index)  }
{   TADXFunction                               }
{                                              }
{   Copyright (c) 1995-2009 by David Berneda   }
{                                              }
{   TDarvasSeries                              }
{   Copyright (c) 2006-2009 by Narcís Calvet   }
{**********************************************}
unit CandleCh;
{$I TeeDefs.inc}

interface

{
  Financial TCandleSeries derives from TOHLCSeries (Open, High, Low & Close).
  See OHLChart.pas unit for TOHLCSeries source code.

  TCandleSeries overrides the TChartSeries.DrawValue method to paint its
  points in several financial styles (CandleStick, Bars, OpenClose, etc).

  TVolumeSeries overrides the TChartSeries.DrawValue method to paint
  points as thin vertical bars.

  TADXFunction is a commonly used financial indicator. It requires an
  OHLC (financial) series as the datasource.

  TRSIFunction (Resistence Strength Index) is a commonly used financial
  indicator. It requires an OHLC (financial) series as the datasource.
}
Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, Types,
     {$ELSE}
     Graphics,
     {$IFDEF D9}
     Types,
     {$ENDIF}
     {$ENDIF}
     Chart, Series, OHLChart, TeEngine, TeCanvas;

Const
  DefCandleWidth = 4;  { 2 + 1 + 2  Default width for Candle points }

type
  TCandleStyle=(csCandleStick,csCandleBar,csOpenClose,csLine);

  TCandleColorStyle=(cssRelativeToOpen, cssRelativeToClose);

  TCandleItem=packed record
    yOpen  : Integer;
    yClose : Integer;
    yHigh  : Integer;
    yLow   : Integer;
    tmpX   : Integer;
    tmpLeftWidth  : Integer;
    tmpRightWidth : Integer;
  end;

  TCandleSeries=class(TOHLCSeries)
  private
    FCandleStyle    : TCandleStyle;
    FCandleWidth    : Integer;
    FColorStyle     : TCandleColorStyle;
    FDownClose      : TTeeGradient;
    FHighLowPen     : TChartPen;
    FShowCloseTick  : Boolean;
    FShowOpenTick   : Boolean;
    FUpClose        : TTeeGradient;

    OldP            : TPoint;
    procedure CalcItem(ValueIndex:Integer; var AItem:TCandleItem);
    Function GetDark3D:Boolean;
    function GetDownColor:TColor;
    Function GetDraw3D:Boolean;
    Function GetPen:TChartPen;
    function GetUpColor:TColor;
    procedure SetCandlePen(Value:TChartPen);
    Procedure SetCandleStyle(Value:TCandleStyle);
    Procedure SetCandleWidth(Value:Integer);
    procedure SetColorStyle(const Value: TCandleColorStyle);
    procedure SetDark3D(Value:Boolean);
    Procedure SetDownColor(const Value:TColor);
    procedure SetDownGradient(const Value: TTeeGradient);
    procedure SetDraw3D(Value:Boolean);
    procedure SetHighLowPen(const Value: TChartPen);
    Procedure SetShowCloseTick(Value:Boolean);
    Procedure SetShowOpenTick(Value:Boolean);
    Procedure SetUpColor(const Value:TColor);
    procedure SetUpGradient(const Value: TTeeGradient);
  protected
    Function CalculateColor(ValueIndex:Integer):TColor;
    function CalculateGradient(ValueIndex:Integer):TCustomTeeGradient;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    procedure DrawValue(ValueIndex:Integer); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Function IsPointInChartRect(ValueIndex:Integer):Boolean; override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function AddCandle( Const ADate:TDateTime;
                        Const AOpen,AHigh,ALow,AClose:Double):Integer;
    Function Clicked(x,y:Integer):Integer; override;
    function ClickedCandle(ValueIndex:Integer; const P:TPoint):Boolean;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
  published
    property Active;
    property ColorEachPoint;
    property ColorSource;
    property Cursor;
    property Depth;
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

    property CandleStyle:TCandleStyle read FCandleStyle write SetCandleStyle
                                      default csCandleStick;
    property CandleWidth:Integer read FCandleWidth write SetCandleWidth
                                 default DefCandleWidth;
    property ColorStyle:TCandleColorStyle read FColorStyle write SetColorStyle // 7.01
                                          default cssRelativeToOpen;

    property Draw3D:Boolean read GetDraw3D write SetDraw3D default False;
    property Dark3D:Boolean read GetDark3D write SetDark3D default True;
    property DownCloseColor:TColor read GetDownColor write SetDownColor
                                   default clRed;
    property DownCloseGradient:TTeeGradient read FDownClose write SetDownGradient;
    property HighLowPen:TChartPen read FHighLowPen write SetHighLowPen;
    property ShowCloseTick:Boolean read FShowCloseTick write SetShowCloseTick
                                   default True;
    property ShowOpenTick:Boolean read FShowOpenTick write SetShowOpenTick
                                  default True;
    property UpCloseColor:TColor read GetUpColor write SetUpColor
                                 default clWhite;
    property UpCloseGradient:TTeeGradient read FUpClose write SetUpGradient;
    property Pen:TChartPen read GetPen write SetCandlePen;
  end;

  { Used in financial charts for Volume quantities (or OpenInterest) }
  { Overrides FillSampleValues to create random POSITIVE values }
  { Overrides DrawValue to paint a thin vertical bar }
  { Declares VolumeValues (same like YValues) }
  TVolumeSeries=class(TCustomSeries)
  private
    FUseYOrigin: Boolean;

    FOrigin: Double;
    IColor : TColor;
    Function GetVolumeValues:TChartValueList;
    Procedure PrepareCanvas(Forced:Boolean; AColor:TColor);
    procedure SetOrigin(const Value: Double);
    procedure SetUseOrigin(const Value: Boolean);
    Procedure SetVolumeValues(Value:TChartValueList);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure CalcHorizMargins(var LeftMargin,RightMargin:Integer); override;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    procedure DrawValue(ValueIndex:Integer); override;
    class Function GetEditorClass:String; override;
    function OriginPosition:Integer;  // 7.05
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure PrepareLegendCanvas( ValueIndex:Integer; Var BackColor:TColor;
                                   Var BrushStyle:TBrushStyle); override;
    Procedure SetSeriesColor(AColor:TColor); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Procedure Assign(Source:TPersistent); override;
    Function Clicked(x,y:Integer):Integer; override;  // 7.05
    Function NumSampleValues:Integer; override;
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

    property LinePen;
    property UseYOrigin:Boolean read FUseYOrigin write SetUseOrigin default False;
    property VolumeValues:TChartValueList read GetVolumeValues write SetVolumeValues;
    property XValues;
    property YOrigin:Double read FOrigin write SetOrigin;
  end;

  { Financial A.D.X function }
  TADXFunction=class(TTeeFunction)
  private
    IDMDown : TFastLineSeries;
    IDMUp   : TFastLineSeries;
    function GetDownPen: TChartPen;
    function GetUpPen: TChartPen;
    procedure SetDownPen(const Value: TChartPen);
    procedure SetUpPen(const Value: TChartPen);
  protected
    class Function GetEditorClass:String; override;
    Function IsValidSource(Value:TChartSeries):Boolean; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override; { 5.01 }

    procedure AddPoints(Source:TChartSeries); override;
    property DMDown:TFastLineSeries read IDMDown;
    property DMUp:TFastLineSeries read IDMUp;
  published
    property DownLinePen:TChartPen read GetDownPen write SetDownPen;
    property UpLinePen:TChartPen read GetUpPen write SetUpPen;
  end;

  { RSI, Relative Strentgh Index }
  TRSIStyle=(rsiOpenClose,rsiClose);

  TRSIFunction = class(TTeeMovingFunction)
  private
    FStyle  : TRSIStyle;

    ISeries : TChartSeries;
    Opens   : TChartValueList;
    Closes  : TChartValueList;
    procedure SetStyle(Const Value:TRSIStyle);
  protected
    Function IsValidSource(Value:TChartSeries):Boolean; override;
  public
    Constructor Create(AOwner:TComponent); override;

    Function Calculate( Series:TChartSeries;
                        FirstIndex,LastIndex:Integer):Double; override;
  published
    property Style:TRSIStyle read FStyle write SetStyle default rsiOpenClose;
  end;

  TDarvasSeries=class(TCandleSeries)
  private
    FBoxBrush : TChartBrush;
    FBoxPen   : TChartPen;
    FNumBoxes : Integer;
    procedure SetBoxBrush(const Value: TChartBrush);
    procedure SetBoxPen(const Value: TChartPen);
  protected
    procedure CalculateBoxes;
    procedure DrawAllValues; override;
  public
    Boxes     : Array of TRect;
    BoxesRect : Array of TRect;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function ClickedBox(x,y:Integer):Integer;
    property NumBoxes:Integer read FNumBoxes;
  published
    property Active;
    property BoxBrush:TChartBrush read FBoxBrush write SetBoxBrush;
    property BoxPen:TChartPen read FBoxPen write SetBoxPen;
    property Brush;
    property ColorEachPoint;
    property ColorSource;
    property Cursor;
    property Depth;
    property HorizAxis;
    property Marks;
    property ParentChart;
    property DataSource;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend;
    property Title;
    property Transparency default 70;
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
  end;

implementation

uses
  Math, SysUtils,
  TeeProcs, TeeProCo, TeeConst;

{ TCandleSeries }
Constructor TCandleSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FUpClose:=TChartGradient.Create(CanvasChanged);
  SetUpColor(clWhite);

  FDownClose:=TChartGradient.Create(CanvasChanged);
  SetDownColor(clRed);

  FCandleWidth   :=DefCandleWidth;
  FCandleStyle   :=csCandleStick;
  FShowOpenTick  :=True;
  FShowCloseTick :=True;
  Pointer.Draw3D :=False;

  FHighLowPen:=TChartPen.Create(CanvasChanged);  // 7.0
  FHighLowPen.Color:=clTeeColor;
  DrawBetweenPoints:=False;
end;

Destructor TCandleSeries.Destroy;
begin
  FHighLowPen.Free;
  FUpClose.Free;
  FDownClose.Free;
  inherited;
end;

Procedure TCandleSeries.SetShowOpenTick(Value:Boolean);
Begin
  SetBooleanProperty(FShowOpenTick,Value);
End;

Procedure TCandleSeries.SetShowCloseTick(Value:Boolean);
Begin
  SetBooleanProperty(FShowCloseTick,Value);
End;

Function TCandleSeries.CalculateColor(ValueIndex:Integer):TColor;
begin
  if InternalColor(ValueIndex)=clTeeColor then
     result:=CalculateGradient(ValueIndex).StartColor
  else
     result:=ValueColor[ValueIndex];
end;

function TCandleSeries.CalculateGradient(ValueIndex:Integer):TCustomTeeGradient;

  // color algorithm when open is equal to current close
  // (or when previous close is equal to current close)
  function CalculateSameValues:TCustomTeeGradient;
  var Current  : TChartValue;
      Previous : TChartValue;
  begin
    if ValueIndex=0 then
       result:=FUpClose // <-- first point
    else
    begin
      Current:=CloseValues.Value[ValueIndex];
      Previous:=CloseValues.Value[ValueIndex-1];

      if Current>Previous then
         result:=FUpClose
      else
      if Current<Previous then
         result:=FDownClose
      else
         result:=CalculateGradient(ValueIndex-1); // 7.04
    end;
  end;

  function CalculateRelativeToOpen:TCustomTeeGradient;
  begin
    if OpenValues.Value[ValueIndex]>CloseValues.Value[ValueIndex] then { 5.01 }
       result:=FDownClose
    else
    if OpenValues.Value[ValueIndex]<CloseValues.Value[ValueIndex] then
       result:=FUpClose
    else
       result:=CalculateSameValues;
  end;

begin
 if ColorStyle=cssRelativeToOpen then
    result:=CalculateRelativeToOpen // 7.01
 else
 // cssRelativeToClose
 if ValueIndex=0 then result:=CalculateRelativeToOpen
                 else result:=CalculateSameValues;
end;

procedure TCandleSeries.CalcItem(ValueIndex:Integer; var AItem:TCandleItem);
begin
  with AItem do
  begin
    tmpX:=CalcXPosValue(DateValues.Value[ValueIndex]); { The horizontal position }

    { Vertical positions of Open, High, Low & Close values for this point }
    YOpen :=CalcYPosValue(OpenValues.Value[ValueIndex]);
    YHigh :=CalcYPosValue(HighValues.Value[ValueIndex]);
    YLow  :=CalcYPosValue(LowValues.Value[ValueIndex]);
    YClose:=CalcYPosValue(CloseValues.Value[ValueIndex]);

    tmpLeftWidth:=FCandleWidth div 2; { calc half Candle Width }
    tmpRightWidth:=FCandleWidth-tmpLeftWidth;
  end;
end;

Procedure TCandleSeries.DrawLegendShape(ValueIndex:Integer; Const Rect:TRect);
var tmpH : Integer;
    tmpV : Integer;
begin
  with ParentChart.Canvas do
  begin
    tmpH:=((Rect.Right-Rect.Left) div 5)-1;
    tmpV:=(Rect.Bottom-Rect.Top) div 5;

    with Rect do
         Rectangle(Left+tmpH,Top+tmpV,Right-tmpH,Bottom-tmpV);

    tmpH:=((Rect.Left+Rect.Right) div 2);

    if (Rect.Right-Rect.Left) mod 2=0 then
       Dec(tmpH);

    DoVertLine(tmpH,Rect.Top-1,Rect.Top+tmpV);
    DoVertLine(tmpH,Rect.Bottom,Rect.Bottom-tmpV-2);
  end;
end;

procedure TCandleSeries.DrawValue(ValueIndex:Integer);

  Procedure CheckHighLowPen;
  begin
    with ParentChart.Canvas do
    begin
      if HighLowPen.Color=clTeeColor then
         AssignVisiblePenColor(HighLowPen,Self.Pen.Color)
      else
         AssignVisiblePen(HighLowPen);

      BackMode:=cbmTransparent;
    end;
  end;

  procedure TryDrawGradient(tmpR:TRect); // 7.04
  var tmpGrad : TCustomTeeGradient;
  begin
    // if Up or Close gradient visible...
    if FUpClose.Visible or FDownClose.Visible then
    begin
      tmpGrad:=CalculateGradient(ValueIndex);
      if tmpGrad.Visible then
      begin
        if tmpR.Top>tmpR.Bottom then
           SwapInteger(tmpR.Top,tmpR.Bottom);

        if ParentChart.View3D then
           if Pointer.Draw3D then
              tmpR:=ParentChart.Canvas.CalcRect3D(tmpR,StartZ)
           else
              tmpR:=ParentChart.Canvas.CalcRect3D(tmpR,MiddleZ);

        tmpGrad.Draw(ParentChart.Canvas,tmpR);
        ParentChart.Canvas.Brush.Style:=bsClear;
      end;
    end;
  end;

var tmpItem   : TCandleItem;
    P         : TPoint;
    tmpFirst  : Integer;
    tmpColor  : TColor;
    tmpR      : TRect;
begin
  if not IsNull(ValueIndex) then //TF02013524
  begin
  if Assigned(OnGetPointerStyle) then  { 5.02 }
     OnGetPointerStyle(Self,ValueIndex);

  { Prepare Pointer Pen and Brush styles }
  Pointer.PrepareCanvas(ParentChart.Canvas,clTeeColor);

  CalcItem(ValueIndex,tmpItem);

  with tmpItem,ParentChart,Canvas do
  begin
    tmpColor:=CalculateColor(ValueIndex);

    if (FCandleStyle=csCandleStick) or (FCandleStyle=csOpenClose) then
    begin { draw Candle Stick }
      CheckHighLowPen;

      if View3D and Pointer.Draw3D then
      begin
        tmpR.Top:=yClose;
        tmpR.Bottom:=yOpen;
        if tmpR.Top>tmpR.Bottom then
           SwapInteger(tmpR.Top,tmpR.Bottom);

        { Draw Candle Vertical Line from bottom to Low }
        if FCandleStyle=csCandleStick then
           VertLine3D(tmpX,tmpR.Bottom,yLow,MiddleZ);

        { Draw 3D Candle }
        Brush.Color:=tmpColor;

        if Self.Pen.Visible then
           if yOpen=yClose then AssignVisiblePenColor(Self.Pen,tmpColor)
                           else AssignVisiblePen(Self.Pen)
           else
              Pen.Style:=psClear;  // 7.0

        tmpR.Left:=tmpX-tmpLeftWidth;
        tmpR.Right:=tmpX+tmpRightWidth;

        Cube(tmpR,StartZ,EndZ,Pointer.Dark3D);

        TryDrawGradient(tmpR);

        CheckHighLowPen;

        { Draw Candle Vertical Line from Top to High }
        if FCandleStyle=csCandleStick then
           VertLine3D(tmpX,tmpR.Top,yHigh,MiddleZ);
      end
      else
      begin
        { Draw Candle Vertical Line from High to Low }
        if FCandleStyle=csCandleStick then
           if View3D then
              VertLine3D(tmpX,yLow,yHigh,MiddleZ)
           else
              DoVertLine(tmpX,yLow,yHigh);

        { remember that Y coordinates are inverted }

        { prevent zero height rectangles 5.02 }
        { in previous releases, an horizontal line was displayed instead
          of the small candle rectangle }
        if yOpen=yClose then Dec(yClose);

        { draw the candle }
        Brush.Color:=tmpColor;

        if Self.Pen.Visible then
           if yOpen=yClose then AssignVisiblePenColor(Self.Pen,tmpColor)
                           else AssignVisiblePen(Self.Pen)
           else
              Pen.Style:=psClear;  // 7.0

        if View3D then
        begin
          tmpR:=TeeRect(tmpX-tmpLeftWidth,yOpen,tmpX+tmpRightWidth,yClose);
          TryDrawGradient(tmpR);
          RectangleWithZ(tmpR,MiddleZ);
        end
        else
        begin
          if not Self.Pen.Visible then
             if yOpen<yClose then Dec(yOpen) else Dec(yClose);

          tmpR:=TeeRect(tmpX-tmpLeftWidth,yOpen,tmpX+tmpRightWidth+1,yClose);
          TryDrawGradient(tmpR);
          Rectangle(tmpR);
        end;
      end;
    end
    else
    if FCandleStyle=csLine then  // Line
    begin
      P:=TeePoint(tmpX,YClose);

      tmpFirst:=FirstDisplayedIndex;

      if (ValueIndex<>tmpFirst) and (not IsNull(ValueIndex)) then
      begin
        AssignVisiblePenColor(Self.Pen,tmpColor);
        BackMode:=cbmTransparent;
        if View3D then LineWithZ(OldP,P,MiddleZ)
                  else Line(OldP,P);
      end;

      OldP:=P;
    end
    else
    begin // Draw Candle bar
      AssignVisiblePenColor(Self.Pen,tmpColor);
      BackMode:=cbmTransparent;

      // Draw Candle Vertical Line from High to Low
      if View3D then
      begin
        VertLine3D(tmpX,yLow,yHigh,MiddleZ);
        if ShowOpenTick then HorizLine3D(tmpX,tmpX-tmpLeftWidth-1,yOpen,MiddleZ);
        if ShowCloseTick then HorizLine3D(tmpX,tmpX+tmpRightWidth+1,yClose,MiddleZ);
      end
      else
      begin // 5.02
        DoVertLine(tmpX,yLow,yHigh);
        if ShowOpenTick then DoHorizLine(tmpX,tmpX-tmpLeftWidth-1,yOpen);
        if ShowCloseTick then DoHorizLine(tmpX,tmpX+tmpRightWidth+1,yClose);
      end;
    end;
  end;
  end;
end;

Procedure TCandleSeries.SetUpColor(const Value:TColor);
Begin
  FUpClose.StartColor:=Value;
end;

Procedure TCandleSeries.SetDownColor(const Value:TColor);
Begin
  FDownClose.StartColor:=Value;
end;

Procedure TCandleSeries.SetCandleWidth(Value:Integer);
Begin
  SetIntegerProperty(FCandleWidth,Value);
end;

Procedure TCandleSeries.SetCandleStyle(Value:TCandleStyle);
Begin
  if FCandleStyle<>Value then
  begin
    FCandleStyle:=Value;
    Pointer.Visible:=CandleStyle<>csLine;
    Repaint;
  end;
end;

class Function TCandleSeries.GetEditorClass:String;
Begin
  result:='TCandleEditor'; // Do not localize
End;

Procedure TCandleSeries.GalleryChanged3D(Is3D:Boolean);
begin
  inherited;

  if Assigned(ParentChart) then
  begin
    DownCloseColor:=ParentChart.GetDefaultColor(0);
    UpCloseColor:=ParentChart.GetDefaultColor(4);
  end;
end;

Procedure TCandleSeries.PrepareForGallery(IsEnabled:Boolean);
Begin
  inherited;
  FillSampleValues(4);
  ColorEachPoint:=IsEnabled;

  if not IsEnabled then
  begin
    UpCloseColor:=clSilver;
    DownCloseColor:=clDkGray;
    Pointer.Pen.Color:=clGray;
  end;

  Pointer.Pen.Width:=2;
  CandleWidth:=12;
end;

Procedure TCandleSeries.Assign(Source:TPersistent);
begin
  if Source is TCandleSeries then
  With TCandleSeries(Source) do
  begin
    Self.FCandleWidth   :=FCandleWidth;
    Self.FCandleStyle   :=FCandleStyle;
    Self.FColorStyle    :=FColorStyle;
    Self.UpCloseGradient:=FUpClose;
    Self.DownCloseGradient:=FDownClose;
    Self.HighLowPen     :=FHighLowPen;
    Self.FShowOpenTick  :=FShowOpenTick;
    Self.FShowCloseTick :=FShowCloseTick;
  end;

  inherited;
end;

Function TCandleSeries.GetDraw3D:Boolean;
begin
  result:=Pointer.Draw3D;
end;

procedure TCandleSeries.SetDraw3D(Value:Boolean);
begin
  Pointer.Draw3D:=Value;
end;

Function TCandleSeries.GetDark3D:Boolean;
begin
  result:=Pointer.Dark3D;
end;

procedure TCandleSeries.SetDark3D(Value:Boolean);
begin
  Pointer.Dark3D:=Value;
end;

Function TCandleSeries.GetPen:TChartPen;
begin
  result:=Pointer.Pen;
end;

procedure TCandleSeries.SetCandlePen(Value:TChartPen);
begin
  Pointer.Pen.Assign(Value);
end;

Function TCandleSeries.AddCandle( Const ADate:TDateTime;
                                  Const AOpen,AHigh,ALow,AClose:Double):Integer;
begin
  result:=AddOHLC(ADate,AOpen,AHigh,ALow,AClose);
end;

class procedure TCandleSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_CandleBar);
  AddSubChart(TeeMsg_CandleNoOpen);
  AddSubChart(TeeMsg_CandleNoClose);
  AddSubChart(TeeMsg_NoBorder);
  AddSubChart(TeeMsg_Line);
end;

class procedure TCandleSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  with TCandleSeries(ASeries) do
  begin
    GalleryChanged3D(ParentChart.View3D);

    Case Index of
      1: CandleStyle:=csCandleBar;
      2: begin Pen.Show; CandleStyle:=csCandleBar; ShowOpenTick:=False; end;
      3: begin Pen.Show; CandleStyle:=csCandleBar; ShowCloseTick:=False; end;
      4: begin CandleStyle:=csCandleStick; Pen.Hide; end;
      5: begin CandleStyle:=csLine; end;
    else
      inherited;
    end;
  end;
end;

function TCandleSeries.ClickedCandle(ValueIndex:Integer; const P:TPoint):Boolean;
var tmpItem   : TCandleItem;
    tmpTop    : Integer;
    tmpBottom : Integer;
    tmpFirst  : Integer;
    tmpTo     : TPoint;
begin
  result:=False;

  CalcItem(ValueIndex,tmpItem);

  With tmpItem do
  Begin
    if (FCandleStyle=csCandleStick) or (FCandleStyle=csOpenClose) then
    begin
      if ParentChart.View3D and Pointer.Draw3D then
      begin
        tmpTop:=yClose;
        tmpBottom:=yOpen;

        if tmpTop>tmpBottom then SwapInteger(tmpTop,tmpBottom);

        if (FCandleStyle=csCandleStick) and
           (
             PointInLine(P,tmpX,tmpBottom,tmpX,yLow) or
             PointInLine(P,tmpX,tmpTop,tmpX,yHigh)
           )  then
        begin
          result:=True;
          exit;
        end;

        if PointInRect(TeeRect(tmpX-tmpLeftWidth,tmpTop,tmpX+tmpRightWidth,tmpBottom),P) then
           result:=True;
      end
      else
      begin
        if (FCandleStyle=csCandleStick) and
           PointInLine(P,tmpX,yLow,tmpX,yHigh) then
        begin
          result:=True;
          exit;
        end;

        if yOpen=yClose then Dec(yClose);

        if ParentChart.View3D then
        begin
          if PointInRect(TeeRect(tmpX-tmpLeftWidth,yOpen,tmpX+tmpRightWidth,yClose),P) then
             result:=True;
        end
        else
        begin
          if not Self.Pen.Visible then
             if yOpen<yClose then Dec(yOpen) else Dec(yClose);

          if PointInRect(TeeRect(tmpX-tmpLeftWidth,yOpen,tmpX+tmpRightWidth+1,yClose),P) then
             result:=True;
        end;
      end;
    end
    else
    if CandleStyle=csLine then
    begin
      tmpFirst:=FirstDisplayedIndex;
      tmpTo:=TeePoint(tmpX,YClose);
      if ValueIndex<>tmpFirst then result:=PointInLine(P,OldP,tmpTo);
      OldP:=tmpTo;
    end
    else
    if PointInLine(P,tmpX,yLow,tmpX,yHigh) or
       (ShowOpenTick and PointInLine(P,tmpX,yOpen,tmpX-tmpLeftWidth-1,yOpen)) or
       (ShowCloseTick and PointInLine(P,tmpX,yClose,tmpX+tmpRightWidth+1,yClose)) then
       result:=True;
  end;
end;

function TCandleSeries.Clicked(x, y: Integer): Integer;
var t : Integer;
    P : TPoint;
begin
  result:=TeeNoPointClicked;

  if (FirstValueIndex>-1) and (LastValueIndex>-1) then
  begin
    if Assigned(ParentChart) then
       ParentChart.Canvas.Calculate2DPosition(X,Y,StartZ);

    P:=TeePoint(x,y);

    for t:=FirstValueIndex to LastValueIndex do
        if ClickedCandle(t,P) then
        begin
          result:=t;
          break;
        end;
  end;
end;

function TCandleSeries.LegendItemColor(LegendIndex: Integer): TColor;
begin
  result:=CalculateColor(LegendIndex);
end;

function TCandleSeries.MaxYValue: Double;
begin
  if CandleStyle=csLine then result:=CloseValues.MaxValue
                        else result:=inherited MaxYValue;
end;

function TCandleSeries.MinYValue: Double;
begin
  if CandleStyle=csLine then result:=CloseValues.MinValue
                        else result:=inherited MinYValue;
end;

procedure TCandleSeries.SetHighLowPen(const Value: TChartPen);
begin
  FHighLowPen.Assign(Value);
end;

procedure TCandleSeries.SetColorStyle(const Value: TCandleColorStyle);
begin
  if FColorStyle<>Value then
  begin
    FColorStyle:=Value;
    Repaint;
  end;
end;

function TCandleSeries.GetDownColor: TColor;
begin
  result:=FDownClose.StartColor;
end;

function TCandleSeries.GetUpColor:TColor;
begin
  result:=FUpClose.StartColor;
end;

function TCandleSeries.IsPointInChartRect(ValueIndex: Integer): Boolean;
var point, r, tmpR : TRect;
    x, yOpen, yClose, tmpLeftWidth,
    tmpRightWidth, tmpTop, tmpBottom : Integer;
begin
    r:=ParentChart.ChartRect;
    x:=CalcXPosValue(DateValues.Items[ValueIndex]);
    yOpen:=CalcYPosValue(OpenValues.Items[ValueIndex]);;
    yClose:=CalcYPosValue(CloseValues.Items[ValueIndex]);

    tmpLeftWidth:=FCandleWidth div 2;
    tmpRightWidth:=FCandleWidth - tmpLeftWidth;

    if yClose > yOpen then
    begin
      tmpTop:=yOpen;
      tmpBottom:=yClose;
    end
    else
    begin
      tmpTop:=yClose;
      tmpBottom:=yOpen;
    end;

     Case CandleStyle of
        csCandleStick: point:=TeeRect(x - tmpLeftWidth, tmpTop, x + tmpRightWidth, tmpBottom);
        csCandleBar: point:=TeeRect(x - tmpLeftWidth, tmpTop, x + tmpRightWidth, tmpBottom);
        csOpenClose: point:=TeeRect(x - tmpLeftWidth, tmpTop, x + tmpRightWidth, tmpBottom);
        csLine: point:=r;
     end;

    {$IFDEF CLX}
    result:=IntersectRect(tmpR,r,point);
    {$ELSE}
    result:={$IFNDEF CLR}Windows.{$ENDIF}IntersectRect(tmpR,r,point);
    {$ENDIF}
end;

procedure TCandleSeries.SetDownGradient(const Value: TTeeGradient);
begin
  FDownClose.Assign(Value);
end;

procedure TCandleSeries.SetUpGradient(const Value: TTeeGradient);
begin
  FUpClose.Assign(Value);
end;

{ TVolumeSeries }
Constructor TVolumeSeries.Create(AOwner: TComponent);
begin
  inherited;

  DrawArea:=False;
  DrawBetweenPoints:=False;
  IMandatoryPen:=True;
  ClickableLine:=False;
  Pointer.Hide;
  FUseYOrigin:=False;
end;

Function TVolumeSeries.GetVolumeValues:TChartValueList;
Begin
  result:=YValues;
end;

Procedure TVolumeSeries.SetSeriesColor(AColor:TColor);
begin
  inherited;
  LinePen.Color:=AColor;
end;

Procedure TVolumeSeries.SetVolumeValues(Value:TChartValueList);
Begin
  SetYValues(Value);
end;

Procedure TVolumeSeries.PrepareCanvas(Forced:Boolean; AColor:TColor);
begin
  if Forced or (AColor<>IColor) then
  begin
    ParentChart.Canvas.AssignVisiblePenColor(LinePen,AColor);
    ParentChart.Canvas.BackMode:=cbmTransparent;
    IColor:=AColor;
  end;
end;

procedure TVolumeSeries.DrawValue(ValueIndex:Integer);
Begin
  PrepareCanvas(ValueIndex=FirstDisplayedIndex, ValueColor[ValueIndex]);

  { moves to x,y coordinates and draws a vertical bar to top or bottom,
    depending on the vertical Axis.Inverted property }

  with ParentChart do
  if View3D then
     Canvas.VertLine3D(CalcXPos(ValueIndex),CalcYPos(ValueIndex),OriginPosition,MiddleZ)
  else
     Canvas.DoVertLine(CalcXPos(ValueIndex),OriginPosition,CalcYPos(ValueIndex)); { 5.02 }
end;

function TVolumeSeries.OriginPosition:Integer; // 7.05
begin
  if UseYOrigin then
     result:=CalcYPosValue(YOrigin) { 5.02 }
  else
  With GetVertAxis do
       if Inverted then result:=IStartPos
                   else result:=IEndPos;
end;

Function TVolumeSeries.NumSampleValues:Integer;
Begin
  result:=40;
end;

Procedure TVolumeSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
Var t : Integer;
    s : TSeriesRandomBounds;
begin
  s:=RandomBounds(NumValues);
  with s do
  for t:=1 to NumValues do
  Begin
    AddXY(tmpX,RandomValue(Round(DifY) div 15));
    tmpX:=tmpX+StepX;
  end;
end;

Procedure TVolumeSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  FillSampleValues(26);
  Pointer.InflateMargins:=True;
end;

class Function TVolumeSeries.GetEditorClass:String;
Begin
  result:='TVolumeSeriesEditor'; // Do not localize
End;

class procedure TVolumeSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Dotted);
  AddSubChart(TeeMsg_Colors);
  AddSubChart(TeeMsg_Origin); { 5.02 }
end;

class procedure TVolumeSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TVolumeSeries(ASeries) do
  Case Index of
    1: Pen.SmallDots:=True;
    2: ColorEachPoint:=True;
    3: UseYOrigin:=True;
  else inherited
  end;
end;

procedure TVolumeSeries.DrawLegendShape(ValueIndex: Integer; { 5.01 }
  const Rect: TRect);
begin
  with Rect do
       ParentChart.Canvas.DoHorizLine(Left,Right,(Top+Bottom) div 2);
end;

procedure TVolumeSeries.Assign(Source: TPersistent);
begin
  if Source is TVolumeSeries then
  with TVolumeSeries(Source) do
  begin
    Self.FUseYOrigin:= UseYOrigin;
    Self.FOrigin    := YOrigin;
  end;
  inherited;
end;

procedure TVolumeSeries.SetOrigin(const Value: Double);
begin
  SetDoubleProperty(FOrigin,Value);
end;

procedure TVolumeSeries.SetUseOrigin(const Value: Boolean);
begin
  SetBooleanProperty(FUseYOrigin,Value);
end;

procedure TVolumeSeries.PrepareLegendCanvas(ValueIndex: Integer;
  var BackColor: TColor; var BrushStyle: TBrushStyle);
begin
  PrepareCanvas(True,SeriesColor);
end;

function TVolumeSeries.Clicked(x, y: Integer): Integer;  // 7.05
var t    : Integer;
    P    : TPoint;
    tmpX : Integer;
    tmpOrigin : Integer;
begin
  if (FirstValueIndex>-1) and (LastValueIndex>-1) then  // AX 7.06
  begin
    P.X:=x;
    P.Y:=y;

    tmpOrigin:=OriginPosition;

    for t:=FirstValueIndex to LastValueIndex do
    begin
      tmpX:=CalcXPos(t);

      if PointInLine(P,TeePoint(tmpX,tmpOrigin),TeePoint(tmpX,CalcYPos(t)),Pen.Width-1) then
      begin
        result:=t;
        exit;
      end;
    end;
  end;

  result:=TeeNoPointClicked;
end;

procedure TVolumeSeries.CalcHorizMargins(var LeftMargin,
  RightMargin: Integer);
begin
  inherited;
  Inc(LeftMargin,LinePen.Width);
  Inc(RightMargin,LinePen.Width);
end;

{ TADXFunction }
type TChartSeriesAccess=class(TChartSeries);

Constructor TADXFunction.Create(AOwner: TComponent);

  Procedure HideSeries(ASeries:TChartSeries);
  begin
    ASeries.ShowInLegend:=False;
    TChartSeriesAccess(ASeries).DontSerialize:=True;
    ASeries.ShowInEditor:=False;
  end;

begin
  inherited;
  InternalSetPeriod(14);
  SingleSource:=True;
  HideSourceList:=True;

  IDMDown:=TFastLineSeries.Create(Self);
  HideSeries(IDMDown);
  IDMDown.SeriesColor:=clRed;

  IDMUp:=TFastLineSeries.Create(Self);
  HideSeries(IDMUp);
  IDMUp.SeriesColor:=clGreen;
end;

procedure TADXFunction.AddPoints(Source: TChartSeries);

  Procedure PrepareSeries(ASeries:TChartSeries);
  begin
    With ASeries do
    begin
      ParentChart:=ParentSeries.ParentChart;
      CustomVertAxis:=ParentSeries.CustomVertAxis;
      VertAxis:=ParentSeries.VertAxis;
      XValues.DateTime:=ParentSeries.XValues.DateTime;
      AfterDrawValues:=ParentSeries.AfterDrawValues;
      BeforeDrawValues:=ParentSeries.BeforeDrawValues;
    end;
  end;

  Function CalcADX(Index:Integer):Double;
  var tmpUp   : TChartValue;
      tmpDown : TChartValue;
      tmp     : TChartValue;
  begin
    Index:=Index-Round(Period);

    tmpUp:=IDMUp.YValues.Value[Index];
    tmpDown:=IDMDown.YValues.Value[Index];

    tmp:=tmpUp+tmpDown;

    if tmp=0 then  // 7.07
       result:=0
    else
       result:=(100*Abs(tmpUp-tmpDown)/tmp);
  end;

var tmpTR,
    tmpDMUp,
    tmpDMDown : Array of Double;
    t         : Integer;
    tt        : Integer;
    tmpClose  : Double;
    Closes,
    Highs,
    Lows      : TChartValueList;
    tmpTR2,
    tmpUp2,
    tmpDown2  : Double;
    tmpX      : Double;
    tmp       : Integer;
    tmpADX    : Double;
begin
  if Period<2 then Exit; // 5.03

  ParentSeries.Clear;
  IDMUp.Clear;
  IDMDown.Clear;
  PrepareSeries(IDMUp);
  PrepareSeries(IDMDown);

  if Source.Count>=(2*Period) then
  begin
    With TOHLCSeries(Source) do
    begin
      Closes:=CloseValues;
      Highs:=HighValues;
      Lows:=LowValues;
    end;

    SetLength(tmpTR, Source.Count);
    SetLength(tmpDMUp, Source.Count);
    SetLength(tmpDMDown, Source.Count);

    for t:=1 to Source.Count-1 do
    begin
      tmpClose:=Closes.Value[t-1];
      tmpTR[t]:=Highs.Value[t]-Lows.Value[t];
      tmpTR[t]:=Math.Max(tmpTR[t],Abs(Highs.Value[t]-tmpClose));
      tmpTR[t]:=Math.Max(tmpTR[t],Abs(Lows.Value[t]-tmpClose));

      if (Highs.Value[t]-Highs.Value[t-1])>(Lows.Value[t-1]-Lows.Value[t]) then
          tmpDMUp[t]:=Math.Max(0,Highs.Value[t]-Highs.Value[t-1])
      else
          tmpDMUp[t]:=0;

      if (Lows.Value[t-1]-Lows.Value[t])>(Highs.Value[t]-Highs.Value[t-1]) then
          tmpDMDown[t]:=Math.Max(0,Lows.Value[t-1]-Lows.Value[t])
      else
          tmpDMDown[t]:=0;
    end;

    tmpTR2:=0;
    tmpUp2:=0;
    tmpDown2:=0;

    tmp:=Round(Period);

    for t:=tmp to Source.Count-1 do
    begin
      if t=tmp then
      begin
        for tt:=1 to Round(Period) do
        begin
          tmpTR2  :=tmpTR2+tmpTR[tt];
          tmpUp2  :=tmpUp2+tmpDMUp[tt];
          tmpDown2:=tmpDown2+tmpDMDown[tt];
        end;
      end
      else
      begin
        tmpTR2:=tmpTR2-(tmpTR2/Period)+tmpTR[t];
        tmpUp2:=tmpUp2-(tmpUp2/Period)+tmpDMUp[t];
        tmpDown2:=tmpDown2-(tmpDown2/Period)+tmpDMDown[t];
      end;

      tmpX:=Source.XValues[t];
      IDMUp.AddXY( tmpX, 100*(tmpUp2/tmpTR2));
      IDMDown.AddXY( tmpX, 100*(tmpDown2/tmpTR2));
    end;

    tmpTR:=nil;
    tmpDMUp:=nil;
    tmpDMDown:=nil;
    tmpADX:=0;

    tmp:=Round((2*Period)-2);

    for t:=tmp to Source.Count-1 do
    begin
      if t=tmp then
      begin
        tmpADX:=0;

        for tt:=Round(Period) to tmp do
            tmpADX:=tmpADX+CalcADX(tt);

        tmpADX:=tmpADX/(Period-1);
      end
      else
      begin
        tmpADX:=((tmpADX*(Period-1))+(CalcADX(t)))/Period;
      end;

      ParentSeries.AddXY(Source.XValues[t],tmpADX);
    end;
  end;
end;

Destructor TADXFunction.Destroy; { 5.01 }
begin
  DMDown.Free;
  DMUp.Free;
  inherited;
end;

class function TADXFunction.GetEditorClass: String;
begin
  result:='TADXFuncEditor'; // Do not localize
end;

function TADXFunction.IsValidSource(Value: TChartSeries): Boolean;
begin
  result:=Value is TOHLCSeries;
end;

function TADXFunction.GetDownPen: TChartPen;
begin
  result:=DMDown.Pen;
end;

function TADXFunction.GetUpPen: TChartPen;
begin
  result:=DMUp.Pen;
end;

procedure TADXFunction.SetDownPen(const Value: TChartPen);
begin
  DMDown.Pen:=Value;
end;

procedure TADXFunction.SetUpPen(const Value: TChartPen);
begin
  DMUp.Pen:=Value;
end;

{ R.S.I. }
Constructor TRSIFunction.Create(AOwner: TComponent);
begin
  inherited;
  FStyle:=rsiOpenClose;
  SingleSource:=True;
  HideSourceList:=True;
end;

Function TRSIFunction.Calculate( Series:TChartSeries;
                                 FirstIndex,LastIndex:Integer):Double;
var NumPoints : Integer;
    t         : Integer;
    tmpClose  : Double;
    Ups       : Double;
    Downs     : Double;
Begin
  if ISeries<>Series then
  begin // Cache lists during calculation
    Closes:=Series.GetYValueList(TeeMsg_ValuesClose);
    Opens :=Series.GetYValueList(TeeMsg_ValuesOpen);
    ISeries:=Series;
  end;

  Ups:=0;
  Downs:=0;

  With Series do
  Begin
    if Self.Style=rsiOpenClose then
    begin // use today Close and Open prices (do not use "yesterday" close)
      for t:=FirstIndex to LastIndex do
      Begin
        tmpClose:=Closes.Value[t];
        if Opens.Value[t]>tmpClose then Downs:=Downs+tmpClose
                                   else Ups  :=Ups  +tmpClose;
      end;
    end
    else
    begin // Use Close prices (today - yesterday)
      for t:=FirstIndex+1 to LastIndex do
      Begin
        tmpClose:=Closes.Value[t]-Closes.Value[t-1];
        if tmpClose<0 then Downs:=Downs-tmpClose
                      else Ups  :=Ups  +tmpClose;
      end;
    end;
  end;

  { Calculate RSI }
  NumPoints:=(LastIndex-FirstIndex)+1;
  Downs:=Downs/NumPoints;
  Ups  :=Ups  /NumPoints;
  if Downs<>0 then
  Begin
    result:=100.0 - ( 100.0 / ( 1.0+Abs(Ups/Downs) ) );
    if result<0   then result:=0 else
    if result>100 then result:=100;
  end
  else result:=100; // Special case, to avoid divide by zero
end;

// R.S.I. function needs an OHLC series values to calculate.
function TRSIFunction.IsValidSource(Value: TChartSeries): Boolean;
begin
  result:=Value is TOHLCSeries;
end;

procedure TRSIFunction.SetStyle(const Value: TRSIStyle);
begin
  if Style<>Value then
  begin
    FStyle:=Value;
    ReCalculate;
  end;
end;

{ TDarvasSeries }
constructor TDarvasSeries.Create(AOwner: TComponent);
begin
  inherited;
  FBoxBrush:=TChartBrush.Create(CanvasChanged);
  FBoxBrush.BackColor:=clTeeColor;

  FBoxPen:=CreateChartPen;

  Transparency:=70;
end;

Destructor TDarvasSeries.Destroy;
begin
  FBoxBrush.Free;
  FBoxPen.Free;
  Boxes:=nil;
  BoxesRect:=nil;
  inherited;
end;

// Algorithm based on:
// http://www.gerryco.com/tech/darvas.html state diagram.
procedure TDarvasSeries.CalculateBoxes;
var
  BoxTop,
  BoxBottom : TChartValue;
  StartIndex,
  EndIndex,
  TopIndex,
  BottomIndex,
  Today,
  State     : Integer;
begin
  FNumBoxes:=0;
  Boxes:=nil;
  BoxesRect:=nil;

  State:=0;
  Today:=0;
  TopIndex:=-1;
  BottomIndex:=-1;
  BoxTop:=HighValues.MinValue;
  BoxBottom:=LowValues.MaxValue;
  StartIndex:=0;

  repeat
    case State of
      0: begin
           StartIndex:=Today;
           State:=1;
         end;

      1: if Today<Count then
         begin
           BoxTop:=HighValues.Items[Today];
           TopIndex:=Today;
           BottomIndex:=Today;
           Inc(Today);

           if Today<Count then
              if BoxTop>HighValues.Items[Today] then State:=2
                                                else State:=1;
         end
         else State:=5;

      2: if Today<Count then
         begin
           Inc(Today);

           if Today<Count then
              if BoxTop>HighValues.Items[Today] then State:=3
                                                else State:=1;
         end
         else State:=5;

      3: if Today<Count then
         begin
           BoxBottom:=LowValues.Items[Today];
           BottomIndex:=Today;
           Inc(Today);

           if Today<Count then
              if BoxTop>HighValues.Items[Today] then
                 if BoxBottom<LowValues.Items[Today] then State:=4
                                                     else State:=3
              else State:=1;
         end
         else State:=5;

      4: if Today<Count then
         begin
           Inc(Today);

           if Today<Count then
              if BoxTop>HighValues.Items[Today] then
                 if BoxBottom<LowValues.Items[Today] then State:=5
                                                     else State:=3
              else State:=1;
         end
         else State:=5;

      5: if Today<Count then
         begin
           Inc(Today);

           if Today<Count then
              if ((BoxTop<HighValues.Items[Today]) or
                  (BoxBottom>LowValues.Items[Today])) then
                 State:=6
              else
                 State:=5;
         end
         else State:=6;

      6: begin
           if Today<Count then EndIndex:=Today
                          else EndIndex:=Today-1;

           SetLength(Boxes,FNumBoxes+1);
           with Boxes[NumBoxes] do
           begin
             Left:=StartIndex;
             Top:=TopIndex;
             Right:=EndIndex;
             Bottom:=BottomIndex;
           end;

           SetLength(BoxesRect,FNumBoxes+1);
           with BoxesRect[NumBoxes] do
           begin
             Left:=CalcXPos(StartIndex);
             Top:=GetVertAxis.CalcYPosValue(HighValues.Value[TopIndex]);
             Right:=CalcXPos(EndIndex);
             Bottom:=GetVertAxis.CalcYPosValue(LowValues.Value[BottomIndex]);
           end;

           Inc(FNumBoxes);

           if Today<Count then State:=0
                          else State:=7;
        end;
    end;

  until State=7;
end;

procedure TDarvasSeries.DrawAllValues;
var tmpBlend : TTeeBlend;
    t        : Integer;
    tmpColor : TColor;
begin
  inherited;

  CalculateBoxes;

  with ParentChart.Canvas do
  begin
    if Transparency<>0 then
       tmpBlend:=BeginBlending(TeeZeroRect, Transparency)
    else
       tmpBlend:=nil;

    try
      AssignVisiblePen(Self.FBoxPen);

      for t:=0 to NumBoxes-1 do
      begin
        if Assigned(tmpBlend) then
           if ParentChart.View3D then
              tmpBlend.SetRectangle(RectFromRectZ(BoxesRect[t],StartZ))
           else
              tmpBlend.SetRectangle(BoxesRect[t]);

        tmpColor:=Self.FBoxBrush.BackColor;
        if tmpColor=clTeeColor then
           tmpColor:=ParentChart.GetDefaultColor(1);

        AssignBrush(Self.FBoxBrush,tmpColor);

        if ParentChart.View3D then
           RectangleWithZ(BoxesRect[t],StartZ)
        else
           Rectangle(BoxesRect[t]);

        if t<(NumBoxes-1) then
           if Assigned(tmpBlend) then
              tmpBlend.DoBlend(Transparency);
      end;

    finally
      if Assigned(tmpBlend) then
         EndBlending(tmpBlend);
    end;
  end;
end;

function TDarvasSeries.ClickedBox(x, y: Integer): Integer;
var t : Integer;
begin
  result:=TeeNoPointClicked;

  if Assigned(ParentChart) then
     ParentChart.Canvas.Calculate2DPosition(X,Y,StartZ);

  for t:=0 to NumBoxes-1 do
      if PointInRect(BoxesRect[t],x,y) then
      begin
        result:=t;
        break;
      end;
end;

procedure TDarvasSeries.Assign(Source: TPersistent);
begin
  if Source is TDarvasSeries then
  With TDarvasSeries(Source) do
  begin
    Self.BoxBrush:=FBoxBrush;
    Self.BoxPen:=FBoxPen;
  end;

  inherited;
end;

procedure TDarvasSeries.SetBoxBrush(const Value: TChartBrush);
begin
  FBoxBrush.Assign(Value);
end;

procedure TDarvasSeries.SetBoxPen(const Value: TChartPen);
begin
  FBoxPen.Assign(Value);
end;

initialization
  RegisterTeeSeries( TCandleSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryCandle,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial, 1);
  RegisterTeeSeries( TVolumeSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryVolume,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial, 1);
  RegisterTeeSeries( TDarvasSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryDarvas,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial, 1);

  RegisterTeeFunction( TADXFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionADX,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
  RegisterTeeFunction( TRSIFunction, {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionRSI,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
finalization
  UnRegisterTeeSeries([TCandleSeries,TVolumeSeries,TDarvasSeries]);
  UnRegisterTeeFunctions([ TADXFunction,TRSIFunction ]);
end.
