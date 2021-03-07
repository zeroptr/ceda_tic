{********************************************}
{  TeeChart Pro Charting Library             }
{  Renko Financial Series                    }
{  Copyright (c) 2009 by Marjan Slatinek     }
{  All Rights Reserved                       }
{********************************************}
unit TeeRenkoSeries;

// The Renko chart financial indicator.
//
// The Renko chart is a trend following technique.
// It got its name from a Japanese word "renga" meaning bricks.
// In Renko chart line brick is drawn in the direction of the prior move
// only if prices move by a minimum amount
// which is equivalent to the box size that are always equal in size.
//
// Renko charts are always based on the closing prices.
// Renko bricks are drawn after comparing, that day’s close
// with the previous brick (high or low). A "box size" which determines
// the minimum price change to show is specified.

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  {$ENDIF}
  TeCanvas, TeEngine, TeePenDlg, TeeProcs;

type
  TRenkoSeries=class(TChartSeries)
  private
    FBoxSize   : Double;
    FDownSwing : TColor;
    FDraw3D    : Boolean;
    FTransp    : TTeeTransparency;
    FUpSwing   : TColor;

    IMin   : Double;
    IMax   : Double;
    IBlend : TTeeBlend;

    function CalcBricks(Draw:Boolean):Integer;
    procedure CompareMinMax(const Value:Double);
    function GetCloseValues:TChartValueList;
    procedure SetBoxSize(const Value:Double);
    procedure SetDownSwing(const Value:TColor);
    procedure SetDraw3D(const Value:Boolean);
    procedure SetTransp(const Value:TTeeTransparency);
    procedure SetUpSwing(const Value:TColor);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    function CalcNumBricks(const Current,Previous:Double):Integer;
    Procedure DrawAllValues; override;
    procedure DrawBrick(const low, high: Double; Index:Integer);
    procedure DrawBricks(const Start:Double; StartIndex,NumBricks:Integer; UpTrend:Boolean);
    class function GetEditorClass: String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
  public
    Constructor Create(AOwner: TComponent); override;

    procedure Assign(Source:TPersistent); override;
    Function CountLegendItems:Integer; override;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;
    Function MaxXValue:Double; override;
    Function MinXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
    Function NumSampleValues:Integer; override;
    Procedure CalcFirstLastVisibleIndex; override;

    property CloseValues:TChartValueList read GetCloseValues;
  published
    property BoxSize:Double read FBoxSize write SetBoxSize;
    property DownSwingColor:TColor read FDownSwing write SetDownSwing default clBlack;
    property Draw3D:Boolean read FDraw3D write SetDraw3D default True;
    property Transparency:TTeeTransparency read FTransp write SetTransp default 0;
    property UpSwingColor:TColor read FUpSwing write SetUpSwing default clWhite;

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

  TRenkoSeriesEditor = class(TForm)
    CBDraw3D: TCheckBox;
    BUp: TButtonColor;
    BDown: TButtonColor;
    BPen: TButtonPen;
    BBrush: TButton;
    Label1: TLabel;
    EBoxSize: TEdit;
    Label2: TLabel;
    ETransp: TEdit;
    UDTransp: TUpDown;
    procedure CBDraw3DClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
    procedure EBoxSizeChange(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
  private
    { Private declarations }
    Renko : TRenkoSeries;
  public
    { Public declarations }
  end;

implementation

uses
  Math, TeeProCo, Chart, TeeBrushDlg;

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{ TRenkoSeries }
Constructor TRenkoSeries.Create(AOwner: TComponent);
begin
  inherited;
  FBoxSize:=1.0;
  FUpSwing:=clWhite;
  FDownSwing:=clBlack;
  FDraw3D:=True;

  XValues.DateTime:=False;
  AllowSinglePoint:=False;
end;

procedure TRenkoSeries.Assign(Source:TPersistent);
begin
  if Source is TRenkoSeries then
  with TRenkoSeries(Source) do
  begin
    Self.FBoxSize:=FBoxSize;
    Self.FDownSwing:=FDownSwing;
    Self.FDraw3D:=FDraw3D;
    Self.FTransp:=FTransp;
    Self.FUpSwing:=FUpSwing;
  end;

  inherited;
end;

procedure TRenkoSeries.DrawBrick(const low, high: Double; Index:Integer);
var tmp : TRect;
begin
  tmp.Left:=CalcXPosValue(index - 0.5);
  tmp.Right:=CalcXPosValue(index + 0.5);
  tmp.Top:=CalcYPosValue(high);
  tmp.Bottom:=CalcYPosValue(low);

  if Assigned(IBlend) then
     IBlend.SetRectangle(tmp);

  if ParentChart.View3D and FDraw3D then
     ParentChart.Canvas.Cube(tmp, StartZ, endZ, False)
  else
     ParentChart.Canvas.Rectangle(tmp, MiddleZ);

  if Assigned(IBlend) then
     IBlend.DoBlend(Transparency);
end;

procedure TRenkoSeries.SetDraw3D(const Value:Boolean);
begin
  SetBooleanProperty(FDraw3D, Value);
end;

procedure TRenkoSeries.DrawBricks(const Start:Double; StartIndex,NumBricks:Integer;
                                  UpTrend:Boolean);
var t : Integer;
begin
  with ParentChart.Canvas do
  begin
    if UpTrend then
       AssignBrush(Self.Brush,UpSwingColor)
    else
       AssignBrush(Self.Brush,DownSwingColor);

    AssignVisiblePen(Self.Pen);
  end;

  for t:=0 to NumBricks-1 do
      if UpTrend then
         DrawBrick(start + t * boxsize, start + (t + 1) * boxsize, t + startindex)
      else
         DrawBrick(start - (t + 1) * boxsize, start - t * boxsize, t + startindex);
end;

/// <summary>
/// Number of bricks
/// </summary>
/// <param name="cur">Current value</param>
/// <param name="pre">Previous value</param>
/// <returns>Number of bricks</returns>
function TRenkoSeries.CalcNumBricks(const current, previous : Double):Integer;
begin
  result:=Round(Abs(current - previous) / FBoxSize);
end;

procedure TRenkoSeries.CompareMinMax(const Value:Double);
begin
  IMin:=Math.Min(IMin, Value);
  IMax:=Math.Max(IMax, Value);
end;

function TRenkoSeries.CalcBricks(Draw:Boolean):Integer;
var i,j : Integer;
    UpTrend   : Boolean;
    Reversal  : Boolean;
    BrickEdge : Double;
    NumBricks : Integer;
begin
  result:=0;

  IMin:=CloseValues.MinValue;
  IMax:=CloseValues.MaxValue;

  if Count > 1 then
  begin
    // First, we must construct initial brick
    i:=1;
    while (CalcNumBricks(CloseValues[i],CloseValues[0]) = 0) and (i < Count) do
      Inc(i);

    // At least one brick to draw
    if i < Count then
    begin
      IMin:=CloseValues[0];
      IMax:=IMin;

      UpTrend:= (CloseValues[i] - CloseValues[0]) > 0;

      //Reversal:=False;

      BrickEdge := CloseValues[0];
      NumBricks := CalcNumBricks(BrickEdge, CloseValues[i]);

      if Draw then
         DrawBricks(BrickEdge, result, NumBricks, UpTrend);

      if UpTrend then
         BrickEdge:=Brickedge + numbricks * boxsize
      else
         BrickEdge:=Brickedge - numbricks * boxsize;

      CompareMinMax(brickedge);
      Inc(result, NumBricks);

      // Process the rest of the points
      for j:= i + 1 to Count-1 do
      begin
        Reversal := (CloseValues.Value[j] > BrickEdge) <> UpTrend;
        UpTrend := CloseValues.Value[j] > BrickEdge;

        if Reversal then
           if UpTrend then
              BrickEdge:=BrickEdge + FBoxSize
           else
              BrickEdge:=BrickEdge - FBoxSize;

        NumBricks := CalcNumBricks(BrickEdge, CloseValues[j]);

        if NumBricks > 0 then
        begin
          if Draw then
             DrawBricks(brickedge, result, NumBricks, UpTrend);

          if UpTrend then
             BrickEdge := BrickEdge + NumBricks * BoxSize
          else
             BrickEdge := BrickEdge - NumBricks * BoxSize;

          CompareMinMax(BrickEdge);
          Inc(result, NumBricks);
        end;
      end;
    end;
  end;
end;

procedure TRenkoSeries.DrawAllValues;
begin
  inherited;

 if Transparency>0 then
    IBlend:=ParentChart.Canvas.BeginBlending(TeeZeroRect,Transparency)
 else
    IBlend:=nil;

  CalcBricks(True);

  if Assigned(IBlend) then
     IBlend.Free;
end;

/// <summary>
/// Seems to work fine ... but better check it so it doesn't break something else.
/// </summary>
procedure TRenkoSeries.CalcFirstLastVisibleIndex;
begin
  inherited;
  FFirstVisibleIndex:=0;
  FLastVisibleIndex:=CalcBricks(False)-1;
end;

function TRenkoSeries.CountLegendItems:Integer;
begin
  result:=2;
end;

function TRenkoSeries.LegendItemColor(LegendIndex:Integer):TColor;
begin
  if LegendIndex=0 then result:=UpSwingColor
                   else result:=DownSwingcolor;
end;

function TRenkoSeries.NumSampleValues:Integer;
begin
  result:=8;
end;

procedure TRenkoSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  FillSampleValues(5);
end;

procedure TRenkoSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var r : TSeriesRandomBounds;
    t : Integer;
begin
  r:=RandomBounds(numValues);

  // some sample values to see something in design mode...
  for t:=1 to NumValues do
  begin
    AddXY(r.tmpX, (Random + 1) * (NumValues + 2));

    r.tmpX:=r.tmpX + r.StepX;
  end;
end;

function TRenkoSeries.MaxXValue:Double;
begin
  result:=CalcBricks(False) -0.5;
end;

function TRenkoSeries.MinXValue:Double;
begin
  result:= -0.5;
end;

function TRenkoSeries.MaxYValue:Double;
begin
  CalcBricks(False);
  result:=IMax;
end;

function TRenkoSeries.MinYValue:Double;
begin
  CalcBricks(False);
  result:=IMin;
end;

function TRenkoSeries.LegendString( LegendIndex:Integer;
                                    LegendTextStyle:TLegendTextStyle ):String;
begin
  if LegendIndex=0 then result:=TeeMsg_Up
                   else result:=TeeMsg_Down;
end;

// Renko chart box size.
procedure TRenkoSeries.SetBoxSize(const Value:Double);
begin
  SetDoubleProperty(FBoxSize, Value);
end;

// Color for upward trend bricks.
// Color for upward trend (current close higher than previous close) bricks.
procedure TRenkoSeries.SetUpSwing(const Value:TColor);
begin
  SetColorProperty(FUpSwing, Value);
end;

procedure TRenkoSeries.SetTransp(const Value:TTeeTransparency);
begin
  if FTransp<>Value then
  begin
    FTransp:=Value;
    Repaint;
  end;
end;

// Color for downward trend bricks.
// Color for downward trend (current close lower than previous close) bricks.
procedure TRenkoSeries.SetDownSwing(const Value:TColor);
begin
  SetColorProperty(FDownSwing, Value);
end;

// Trading close values.
// Gets and sets all Stock market closing values.
function TRenkoSeries.GetCloseValues:TChartValueList;
begin
  result:=YValues;
end;

class function TRenkoSeries.GetEditorClass: String;
begin
  result:='TRenkoSeriesEditor';
end;

{ TRenkoSeriesEditor }
procedure TRenkoSeriesEditor.CBDraw3DClick(Sender: TObject);
begin
  Renko.Draw3D:=CBDraw3D.Checked;
end;

procedure TRenkoSeriesEditor.FormShow(Sender: TObject);
begin
  Renko:=TRenkoSeries(Tag);

  if Assigned(Renko) then
  with Renko do
  begin
    CBDraw3D.Checked:=Draw3D;
    BUp.LinkProperty(Renko,'UpSwingColor');
    BDown.LinkProperty(Renko,'DownSwingColor');
    BPen.LinkPen(Pen);

    EBoxSize.Text:=FloatToStr(BoxSize);
    UDTransp.Position:=Transparency;
  end;
end;

procedure TRenkoSeriesEditor.ETranspChange(Sender: TObject);
begin
  if Showing then
     Renko.Transparency:=UDTransp.Position;
end;

procedure TRenkoSeriesEditor.EBoxSizeChange(Sender: TObject);
begin
  Renko.BoxSize:=StrToFloatDef(EBoxSize.Text,Renko.BoxSize);
end;

procedure TRenkoSeriesEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Renko.Brush);
end;

initialization
  RegisterTeeSeries( TRenkoSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryRenko,
                                   {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial, 1 );
  RegisterClass(TRenkoSeriesEditor);
finalization
  UnRegisterTeeSeries([TRenkoSeries]);
end.

