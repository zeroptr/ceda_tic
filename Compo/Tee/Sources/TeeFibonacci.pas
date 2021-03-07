{******************************************}
{ TSeriesTool Editor Dialog                }
{ Copyright (c) 2009 by Steema Software    }
{******************************************}
unit TeeFibonacci;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF D6}
  Types,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  TeeProcs, TeeToolSeriesEdit, TeCanvas, TeEngine, Chart, TeePenDlg;

type
  TFibonacciStyle=(fsArc, fsFan);

  TFibonacciTool=class;

  TFibonacciItem=class(TCollectionItem)
  private
    FPen   : TChartPen;
    FValue : TChartValue;
    procedure SetPen(const Value: TChartPen);
    procedure SetValue(const Value: TChartValue);
  public
    Constructor Create(Collection:TCollection); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
  published
    property Pen:TChartPen read FPen write SetPen;
    property Value:TChartValue read FValue write SetValue;
  end;

  TFibonacciLevels=class(TOwnedCollection)
  private
    ITool : TFibonacciTool;

    function Get(Index: Integer): TFibonacciItem;
    procedure Put(Index: Integer; const Value: TFibonacciItem);
  public
    property Level[Index:Integer]:TFibonacciItem read Get write Put; default;
  end;

  // Fibonacci fans and arcs financial tool. Tool supports Fibonacci arcs and
  // fans.
  //
  // Fibonacci arcs are charting technique consisting of three curved lines that
  // are drawn for the purpose of anticipating key support, resistance levels
  // and areas of ranging.
  // Fibonacci arcs are created by first drawing an invisible trendline between
  // two points  (usually the high and low in a given period), and then by
  // drawing three curves that intersect this trendline at the key Fibonacci
  // levels of 38.2%, 50% and 61.8%.
  //
  // Fibonacci fans are charting technique consisting of three diagonal lines
  // that use Fibonacci ratios to help identify key levels of support and
  // resistance.
  // Fibonacci fans are created by first drawing a trendline through two points
  // (usually the high and low in a given period), and then by dividing the
  // vertical distance between the two points by the key Fibonacci ratios of
  // 38.2%, 50% and 61.8%. The result of these divisions each represent a point
  // within the vertical distance. The three 'fan' lines are then created by
  // drawing a line from the leftmost point to each of the three representing
  // a Fibonacci ratio.

  TFibonacciTool=class(TTeeCustomToolSeries)
  private
    FDrawStyle  : TFibonacciStyle;
    FEndX       : Double;
    FEndY       : Double;
    FLabelsAngle: Integer;
    FLabelFont  : TTeeFont;
    FLevels     : TFibonacciLevels;
    FShowLabels : Boolean;
    FStartX     : Double;
    FStartY     : Double;
    FTrendPen   : TChartPen;

    IDefaultFab : Array of Double;
    ISp         : TPoint;

    procedure ClipDrawingRegion;
    procedure SetDrawStyle(const Value: TFibonacciStyle);
    procedure SetEndX(const Value: Double);
    procedure SetEndY(const Value: Double);
    procedure SetLabelsAngle(const Value: Integer);
    procedure SetLabelsFont(const Value: TTeeFont);
    procedure SetShowLabels(const Value: Boolean);
    procedure SetStartX(const Value: Double);
    procedure SetStartY(const Value: Double);
    procedure SetTrendPen(const Value: TChartPen);
    procedure SetLevels(const Value: TFibonacciLevels);
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    procedure DrawLevel(Index:Integer);
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;

    function AxisPoint(const X,Y:Double):TPoint;
    procedure CreateDefaultLevels;
    class Function Description:String; override;
    class Function LongDescription:String; override;
    function Radius:Double;
  published
    property Active;
    property DrawStyle:TFibonacciStyle read FDrawStyle write SetDrawStyle default fsArc;
    property EndX:Double read FEndX write SetEndX;
    property EndY:Double read FEndY write SetEndY;
    property LabelsAngle:Integer read FLabelsAngle write SetLabelsAngle default 90;
    property LabelsFont:TTeeFont read FLabelFont write SetLabelsFont;
    property Levels:TFibonacciLevels read FLevels write SetLevels;
    property Pen;
    property Series;
    property ShowLabels:Boolean read FShowLabels write SetShowLabels default True;
    property StartX:Double read FStartX write SetStartX;
    property StartY:Double read FStartY write SetStartY;
    property TrendPen:TChartPen read FTrendPen write SetTrendPen;
  end;

  TFibonacciEditor = class(TSeriesToolEditor)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    RGStyle: TRadioGroup;
    BTrendPen: TButtonPen;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EXStart: TEdit;
    EYStart: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    EXEnd: TEdit;
    EYEnd: TEdit;
    Button1: TButton;
    BRemoveLevel: TButton;
    Button3: TButton;
    GBLevels: TGroupBox;
    ELevel: TEdit;
    UDLevel: TUpDown;
    ELevelValue: TEdit;
    BLevelPen: TButtonPen;
    TabSheet3: TTabSheet;
    CBLabels: TCheckBox;
    Button2: TButton;
    Label6: TLabel;
    EAngle: TEdit;
    UDAngle: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
    procedure CBLabelsClick(Sender: TObject);
    procedure EXStartChange(Sender: TObject);
    procedure EYStartChange(Sender: TObject);
    procedure EXEndChange(Sender: TObject);
    procedure EYEndChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ELevelChange(Sender: TObject);
    procedure BRemoveLevelClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EAngleChange(Sender: TObject);
  private
    { Private declarations }
    Fibonacci : TFibonacciTool;
    procedure SetLevel(Index:Integer);
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeProCo, TeeEdiFont;

{ TFibonacciTool }

Constructor TFibonacciTool.Create(AOwner: TComponent);
begin
  inherited;

  SetLength(IDefaultFab,3);
  IDefaultFab[0]:=38.2;
  IDefaultFab[1]:=50.0;
  IDefaultFab[2]:=61.8;

  FLevels:=TFibonacciLevels.Create(Self,TFibonacciItem);
  FLevels.ITool:=Self;

  FTrendPen:=CreateChartPen;
  FTrendPen.Color:=clRed;
  
  FDrawStyle:=fsArc;

  ISp:=TeePoint(-1,-1);

  FShowLabels:=True;
  FLabelsAngle:=90;

  FLabelFont:=TTeeFont.Create(CanvasChanged);

  CreateDefaultLevels;
end;

Destructor TFibonacciTool.Destroy;
begin
  IDefaultFab:=nil;
  FTrendPen.Free;
  FLabelFont.Free;
  FLevels.Free;
  inherited;
end;

procedure TFibonacciTool.Assign(Source: TPersistent);
begin
  if Source is TFibonacciTool then
  with TFibonacciTool(Source) do
  begin
    Self.FDrawStyle:=FDrawStyle;
    Self.FEndX:=FEndX;
    Self.FEndY:=FEndY;
    Self.FLabelsAngle:=FLabelsAngle;
    Self.LabelsFont:=LabelsFont;
    Self.Levels:=Levels;
    Self.FShowLabels:=FShowLabels;
    Self.FStartX:=FStartX;
    Self.FStartY:=FStartY;
    Self.TrendPen:=TrendPen;
  end;

  inherited;
end;

class function TFibonacciTool.Description: String;
begin
  result:=TeeMsg_Fibonacci;
end;

class function TFibonacciTool.GetEditorClass: String;
begin
  result:='TFibonacciEditor';
end;

class function TFibonacciTool.LongDescription: String;
begin
  result:=TeeMsg_FibonacciDesc;
end;

procedure TFibonacciTool.SetDrawStyle(const Value: TFibonacciStyle);
begin
  if FDrawStyle<>Value then
  begin
    FDrawStyle:=Value;
    Repaint;
  end;
end;

procedure TFibonacciTool.SetEndX(const Value: Double);
begin
  SetDoubleProperty(FEndX,Value);
end;

procedure TFibonacciTool.SetEndY(const Value: Double);
begin
  SetDoubleProperty(FEndY,Value);
end;

procedure TFibonacciTool.SetLabelsAngle(const Value: Integer);
begin
  SetIntegerProperty(FLabelsAngle,Value);
end;

procedure TFibonacciTool.SetLabelsFont(const Value: TTeeFont);
begin
  FLabelFont.Assign(Value);
end;

procedure TFibonacciTool.SetShowLabels(const Value: Boolean);
begin
  SetBooleanProperty(FShowLabels,Value);
end;

procedure TFibonacciTool.SetStartX(const Value: Double);
begin
  SetDoubleProperty(FStartX,Value);
end;

procedure TFibonacciTool.SetStartY(const Value: Double);
begin
  SetDoubleProperty(FStartY,Value);
end;

procedure TFibonacciTool.SetTrendPen(const Value: TChartPen);
begin
  FTrendPen.Assign(Value);
end;

procedure TFibonacciTool.SetLevels(const Value: TFibonacciLevels);
begin
  FLevels.Assign(Value);
end;

function TFibonacciTool.Radius:Double;
var rx : Integer;
    ry : Integer;
begin
  rx:=GetHorizAxis.CalcSizeValue(Abs(FEndX - FStartX));
  ry:=GetVertAxis.CalcSizeValue(Abs(FEndY - FStartY));
  result:=TeeDistance(rx,ry)
end;

procedure TFibonacciTool.ClipDrawingRegion;
var tmpR : TRect;
begin
  if Assigned(Series) then
  begin
    tmpR.Left:=GetHorizAxis.IStartPos;
    tmpR.Top:=GetVertAxis.IStartPos;
    tmpR.Right:=GetHorizAxis.IEndPos;
    tmpR.Bottom:=GetVertAxis.IEndPos;
  end
  else
    tmpR:=ParentChart.ChartRect;

  if ParentChart.CanClip then
     ParentChart.Canvas.ClipCube(tmpR,0,ParentChart.Width3D);
end;

function TFibonacciTool.AxisPoint(const X,Y:Double):TPoint;
begin
  result:=TeePoint(GetHorizAxis.CalcPosValue(X),GetVertAxis.CalcPosValue(Y));
end;

procedure TFibonacciTool.ChartEvent(AEvent:TChartToolEvent);

  function SamePoint(const A,B:TPoint):Boolean;
  begin
    result:=(A.X=B.X) and (A.Y=B.Y);
  end;

var t : Integer;
begin
  inherited;

  if AEvent=cteAfterDraw then
  begin
    ClipDrawingRegion;

    ParentChart.Canvas.BackMode:=cbmTransparent;
    
    // Draw trendline
    if TrendPen.Visible then
    begin
      ParentChart.Canvas.AssignVisiblePen(TrendPen);
      ParentChart.Canvas.Line(AxisPoint(FStartX,FStartY),AxisPoint(FEndX,FEndY));
    end;

    // Draw levels, but only if there is a trendline
    if (FLevels.Count > 0) and
       (not SamePoint(AxisPoint(FStartX,FStartY),AxisPoint(FEndX,FEndY))) then
    begin
      case FDrawStyle of
        fsArc: ISp:=AxisPoint(endx,endy);
        fsFan: ISp:=AxisPoint(startx,starty);
      end;

      for t:=0 to FLevels.Count-1 do
          DrawLevel(t);
    end;

    ParentChart.Canvas.UnClipRectangle;
  end;
end;

procedure TFibonacciTool.DrawLevel(Index:Integer);

  procedure Arc(const Center:TPoint; Rad:Integer; Upper:Boolean);
  var l,r,t,b : Integer;
  begin
    l := Center.X - rad;
    r := Center.X + rad;
    t := Center.Y - rad;
    b := Center.Y + rad;

    if Upper then
       ParentChart.Canvas.Arc(l, t, r, b, 0, 180)
    else
       ParentChart.Canvas.Arc(l, t, r, b, 180, 180);
  end;

  procedure Fan(const startp, endp:TPoint);
  begin
    ParentChart.Canvas.MoveTo(startp);
    ParentChart.Canvas.LineTo(endp);
  end;

var tmpRadius : Integer;
    xend,
    yend,
    k    : Double;
    endP : TPoint;
begin
  ParentChart.Canvas.AssignVisiblePen(Levels[Index].Pen);

  case FDrawStyle of
   fsArc: begin
            tmpRadius:=Round(Radius* Levels[Index].Value * 0.01);
            Arc(ISp,tmpRadius,FEndY>FStartY);

            if ShowLabels then
            begin
              ParentChart.Canvas.AssignFont(LabelsFont);
              ParentChart.Canvas.RotateLabel(ISp.X-tmpRadius, ISp.Y,
                     FloatToStr(Levels[Index].Value), LabelsAngle);
            end;
          end;

   fsFan: begin
            if Assigned(Series) then xend:=Series.XValues.Last
                                else xend:=endx;

            k:=(endy - starty) / (endx - startx) * (100.0-Levels[Index].Value) * 0.01;
            yend:=Starty + k * (xend - startx);
            endp:=AxisPoint(xend,yend);

            Fan(ISp,endp);

            if ShowLabels then
            begin
              ParentChart.Canvas.AssignFont(LabelsFont);
              ParentChart.Canvas.RotateLabel(endp.X, endp.Y,
                      FloatToStr(Levels[Index].Value), LabelsAngle);
            end;
          end;
  end;
end;

procedure TFibonacciTool.CreateDefaultLevels;
var t : Integer;
begin
  FLevels.Clear;

  for t:=Low(IDefaultFab) to High(IDefaultFab) do
      TFibonacciItem(FLevels.Add).FValue:=IDefaultFab[t];
end;

{ TFibonacciItem }

procedure TFibonacciItem.Assign(Source: TPersistent);
begin
  if Source is TFibonacciItem then
  with TFibonacciItem(Source) do
  begin
    Self.Pen:=Pen;
    Self.FValue:=FValue;
  end;

  inherited;
end;

Constructor TFibonacciItem.Create(Collection:TCollection);
begin
  inherited;
  FPen:=TFibonacciLevels(Collection).ITool.CreateChartPen;
end;

Destructor TFibonacciItem.Destroy;
begin
  FPen.Free;
  inherited;
end;

procedure TFibonacciItem.SetPen(const Value: TChartPen);
begin
  FPen := Value;
end;

procedure TFibonacciItem.SetValue(const Value: TChartValue);
begin
  FValue := Value;
end;

{ TFibonacciLevels }

function TFibonacciLevels.Get(Index: Integer): TFibonacciItem;
begin
  result:=TFibonacciItem(inherited Items[Index]);
end;

procedure TFibonacciLevels.Put(Index: Integer;
  const Value: TFibonacciItem);
begin
  inherited Items[Index]:=Value;
end;

{ TFibonacciEditor }

procedure TFibonacciEditor.RGStyleClick(Sender: TObject);
begin
  Fibonacci.DrawStyle:=TFibonacciStyle(RGStyle.ItemIndex);
end;

procedure TFibonacciEditor.FormShow(Sender: TObject);
begin
  inherited;

  Fibonacci:=TFibonacciTool(Tool);

  if Assigned(Fibonacci) then
  begin
    with Fibonacci do
    begin
      RGStyle.ItemIndex:=Ord(DrawStyle);
      CBLabels.Checked:=ShowLabels;
      BTrendPen.LinkPen(TrendPen);

      EXStart.Text:=FloatToStr(StartX);
      EYStart.Text:=FloatToStr(StartY);

      EXEnd.Text:=FloatToStr(EndX);
      EYEnd.Text:=FloatToStr(EndY);

      UDAngle.Position:=LabelsAngle;
    end;

    SetLevel(0);
  end;
end;

procedure TFibonacciEditor.CBLabelsClick(Sender: TObject);
begin
  Fibonacci.ShowLabels:=CBLabels.Checked;
end;

procedure TFibonacciEditor.EXStartChange(Sender: TObject);
var tmp : Double;
begin
  if Showing then
     with Fibonacci do
          if TryStrToFloat(EXStart.Text,tmp) then
             StartX:=tmp;
end;

procedure TFibonacciEditor.EYStartChange(Sender: TObject);
var tmp : Double;
begin
  if Showing then
     with Fibonacci do
          if TryStrToFloat(EYStart.Text,tmp) then
             StartY:=tmp;
end;

procedure TFibonacciEditor.EXEndChange(Sender: TObject);
var tmp : Double;
begin
  if Showing then
     with Fibonacci do
          if TryStrToFloat(EXEnd.Text,tmp) then
             EndX:=tmp;
end;

procedure TFibonacciEditor.EYEndChange(Sender: TObject);
var tmp : Double;
begin
  if Showing then
     with Fibonacci do
          if TryStrToFloat(EYEnd.Text,tmp) then
             EndY:=tmp;
end;

procedure TFibonacciEditor.Button1Click(Sender: TObject);
begin
  SetLevel(Fibonacci.Levels.Add.Index);
end;

procedure TFibonacciEditor.ELevelChange(Sender: TObject);
begin
  if GBLevels.Enabled then
  with Fibonacci.Levels[UDLevel.Position] do
  begin
    ELevelValue.Text:=FloatToStr(Value);
    BLevelPen.LinkPen(Pen);
  end;
end;

procedure TFibonacciEditor.SetLevel(Index:Integer);
begin
  GBLevels.Enabled:=(Fibonacci.Levels.Count>0);
  BRemoveLevel.Enabled:=GBLevels.Enabled;

  if GBLevels.Enabled then
  begin
    UDLevel.Max:=Fibonacci.Levels.Count-1;

    if Index>UDLevel.Max then
       Index:=UDLevel.Max;

    UDLevel.Position:=Index;
  end;
end;

procedure TFibonacciEditor.BRemoveLevelClick(Sender: TObject);
begin
  {$IFDEF D5}
  Fibonacci.Levels.Delete(UDLevel.Position);
  {$ELSE}
  Fibonacci.Levels[UDLevel.Position].Free;
  {$ENDIF}
  
  SetLevel(UDLevel.Position);
end;

procedure TFibonacciEditor.Button3Click(Sender: TObject);
begin
  Fibonacci.CreateDefaultLevels;
  SetLevel(0);
end;

procedure TFibonacciEditor.Button2Click(Sender: TObject);
begin
  EditTeeFontEx(Self,Fibonacci.LabelsFont);
end;

procedure TFibonacciEditor.EAngleChange(Sender: TObject);
begin
  if Showing then
     Fibonacci.LabelsAngle:=UDAngle.Position;
end;

initialization
  RegisterClass(TFibonacciEditor);
  RegisterTeeTools([TFibonacciTool]);
finalization
  UnRegisterTeeTools([TFibonacciTool]);
end.
