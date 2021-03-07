{**********************************************}
{   TeeChart Circular Gauge style              }
{   Copyright (c) 2009 by Steema Software      }
{**********************************************}
unit TeeCircularGauge;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Math,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  {$ENDIF}
  TeeLinearGauge, TeEngine, TeCanvas, TeeEdiGrad;

type
  TCircularGauge=class;

  TGaugeHand=class(TGaugeSeriesPointer)
  private
    FOffset: Integer;
    FDistance: Integer;

    procedure SetDistance(const Value: Integer);
    procedure SetOffset(const Value: Integer);
  public
    Constructor Create(AOwner:TChartSeries);

    procedure Draw(const Angle:Double; Center:TPoint; Off:Integer);
  published
    property Distance:Integer read FDistance write SetDistance default 80;
    property Offset:Integer read FOffset write SetOffset default 30;
  end;

  TCircularGauge=class(TCustomGaugeMinMax)
  private
    FCenter       : TGaugeSeriesPointer;
    FEndPoint     : TSeriesPointer;
    FHand         : TGaugeHand;
    FLabelsInside : Boolean;
    FRotateLabels : Boolean;
    FTotalAngle   : Double;

    IAngleInc   : Double;
    ICenter     : TPoint;
    IStartAngle : Double;

    FCircled    : Boolean;
    FRotAngle   : Double;
    FXRadius    : Integer;
    FYRadius    : Integer;

    function CalcAngleFromLength(const Point:TPoint; const Length:Double):Double;
    function CalcDistance(Distance:Integer):Integer;
    function CalcPoint(const Angle:Double; const Center:TPoint;
                       const RadiusX, RadiusY:Double):TPoint;
    Procedure CalcRadius;
    function CalcStartAngle:Double;
    function CalcSweepAngle:Double;
    function CalcValue(const AValue:Double):Double;
    procedure DrawAxisMinorTick(const Inner, Outer:TPoint);
    procedure DrawAxisTick(const Inner, InnerPlus, InnerMinus,
                           Outer, OuterPlus, OuterMinus:TPoint);
    procedure DrawCenter;
    procedure DrawColorLines;
    procedure DrawEnd(Angle:Double);
    procedure SetCenter(const Value: TGaugeSeriesPointer);
    procedure SetCircled(const Value:Boolean);
    procedure SetEndPoint(const Value: TSeriesPointer);
    procedure SetHand(const Value: TGaugeHand);
    procedure SetLabelsInside(const Value: Boolean);
    procedure SetRotateLabels(const Value: Boolean);
    procedure SetRotAngle(const Value: Double);
    procedure SetTotalAngle(const Value: Double);
  protected
    function Axis:TChartAxis; override;
    procedure CalcOrigRect; override;
    Procedure DoBeforeDrawValues; override;
    procedure DrawAxis; override;
    procedure DrawFace; override;
    procedure DrawHand; override;
    class Function GetEditorClass:String; override;
    procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetParentChart(const Value:TCustomAxisPanel); override;
    procedure SetValues; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    function UseAxis:Boolean; override;

    // From TCircledSeries
    function CircleXCenter:Integer;
    function CircleYCenter:Integer;
    property XRadius:Integer read FXRadius;
    property YRadius:Integer read FYRadius;
  published
    property Active;
    property Cursor;
    property ParentChart;
    property DataSource;  { after ParentChart }
    property PercentFormat;
    property ShowInLegend;
    property Title;
    property ValueFormat;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnChange;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnMouseEnter;
    property OnMouseLeave;

    property XValues;
    property YValues;

    property Center:TGaugeSeriesPointer read FCenter write SetCenter;
    property Circled:Boolean read FCircled write SetCircled default True;
    property EndPoint:TSeriesPointer read FEndPoint write SetEndPoint;
    property Face;
    property Frame;
    property GreenLine;
    property Hand:TGaugeHand read FHand write SetHand;
    property LabelsInside:Boolean read FLabelsInside write SetLabelsInside
                                  default True;
    property Maximum;
    property Minimum;
    property MinorTickDistance default 3;
    property MinorTicks;
    property RedLine;
    property RotateLabels:Boolean read FRotateLabels write SetRotateLabels
                                  default True;
    property RotationAngle:Double read FRotAngle write SetRotAngle;
    property Ticks;
    property TotalAngle:Double read FTotalAngle write SetTotalAngle; //default 300;
    property Value;
  end;

  TCircularGaugeEditor = class(TLinearGaugeEditor)
    BHand: TButton;
    CBLabelsInside: TCheckBox;
    CBRotateLabels: TCheckBox;
    Label11: TLabel;
    BCenter: TButton;
    Button3: TButton;
    ETotalAngle: TEdit;
    UDTotalAngle: TUpDown;
    Label12: TLabel;
    Edit1: TEdit;
    UDHandDist: TUpDown;
    Label13: TLabel;
    Edit3: TEdit;
    UDHandOff: TUpDown;
    Timer1: TTimer;
    CBCircled: TCheckBox;
    Label14: TLabel;
    Edit4: TEdit;
    UDRotAngle: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure BHandClick(Sender: TObject);
    procedure BCenterClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CBLabelsInsideClick(Sender: TObject);
    procedure CBRotateLabelsClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure ETotalAngleChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CBCircledClick(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
  private
    { Private declarations }
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
  Chart, TeeProCo, TeeProcs, TeeNumericGauge, TeePoEdi, Series;

{ TCircularGauge }

type
  TFramedAccess=class(TFramedBorder);

Constructor TCircularGauge.Create(AOwner: TComponent);
begin
  inherited;

  Face.ShapeStyle:=fosEllipse;

  FHand:=TGaugeHand.Create(Self);

  FTotalAngle:=300;

  RedLine.StartValue:=80;
  RedLine.EndValue:=100;

  GreenLine.StartValue:=0;
  GreenLine.EndValue:=70;

  FLabelsInside:=True;
  FRotateLabels:=True;
  MinorTickDistance:=3;

  FCircled:=True;

  TFramedAccess(Frame).SetDefaultCircled(True);

  FCenter:=TGaugeSeriesPointer.Create(Self);
  FCenter.GaugeStyle:=gpCenter;
  FCenter.Size:=16;
  FCenter.Gradient.Visible:=True;
  FCenter.Pen.Hide;
  FCenter.Style:=psCircle;
  FCenter.Shadow.Visible:=True;
  FCenter.Shadow.Size:=2;

  FEndPoint:=TSeriesPointer.Create(Self);
  FEndPoint.Style:=psCircle;
  FEndPoint.Color:=clWhite;
end;

Destructor TCircularGauge.Destroy;
begin
  FEndPoint.Free;
  FCenter.Free;
  FHand.Free;
  inherited;
end;

procedure TCircularGauge.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  Axis.Visible:=False;
  Center.VertSize:=3;
  Center.HorizSize:=3;
  Hand.HorizSize:=2;
  Hand.Distance:=100;
  RedLine.VertSize:=5;
  Value:=70;
end;

procedure TCircularGauge.DrawFace;
begin
  inherited;
  DrawColorLines;
end;

procedure TCircularGauge.DrawColorLines;

  procedure DrawLine(Line:TGaugePointerRange);
  var tmpR : TRect;
      minRadius : Double;
      tmp : Integer;
  begin
    if Line.Visible then
    begin
      tmpR:=INewRect;
      minRadius:=Min(XRadius,YRadius)*0.25;
      tmp:= -Round(minRadius);

      if Axis.Labels then
      begin
        ParentChart.Canvas.AssignFont(Axis.LabelsFont);

        if RotateLabels then
           Dec(tmp, ParentChart.Canvas.FontHeight)
        else
           Dec(tmp, ParentChart.Canvas.TextWidth(FormatFloat(Axis.AxisValuesFormat,Maximum)));
      end;

      InflateRect(tmpR,tmp,tmp);

      Line.Draw(CalcValue(Line.StartValue),CalcValue(Line.EndValue),tmpR);
    end;
  end;

begin
  DrawLine(RedLine);
  DrawLine(GreenLine);
end;

function TCircularGauge.CircleXCenter:Integer;
begin
  with ParentChart.ChartRect do
       result:=(Left+Right) div 2;
end;

function TCircularGauge.CircleYCenter:Integer;
begin
  with ParentChart.ChartRect do
       result:=(Bottom+Top) div 2;
end;

procedure TCircularGauge.CalcOrigRect;
begin
  inherited;

  if Circled then
  begin
    INewRect:=IOrigRect;
    CalcRadius;

    TCircledSeries.AdjustScreenRatio(ParentChart.Canvas,
      FXRadius,FYRadius,IOrigRect);

    INewRect:=IOrigRect;
    CalcRadius;
  end;
end;

procedure TCircularGauge.SetValues;
begin
  inherited;

  IStartAngle := CalcStartAngle;
  IAngleInc := TotalAngle / IRange;

  CalcRadius;
end;

//returns the angle needed to draw the length on the circumference of the circle from a point
function TCircularGauge.CalcAngleFromLength(const Point:TPoint;
                                            const Length:Double):Double;
var radius, tmp : Double;
begin
  if Circled then
     radius:=XRadius
  else
     radius:=TeeDistance(Abs(ICenter.X-Point.X),Abs(ICenter.Y-Point.Y));

  // law of cosines
  tmp:=Sqr(radius)*2;

  if tmp=0 then
     result:=0
  else
     result:=ArcCos((tmp - Sqr(Length)) / tmp);
end;

const
  TeeZeroPoint:TPoint=(X:0; Y:0);

function TCircularGauge.CalcPoint(const Angle:Double; const Center:TPoint;
                                  const RadiusX, RadiusY:Double):TPoint;
var tmpSin,
    tmpCos : Extended;
begin
  SinCos(Angle, tmpSin, tmpCos);
  result.X := Center.X - Round(RadiusX * tmpCos);
  result.Y := Center.Y - Round(RadiusY * tmpSin);
end;

procedure TCircularGauge.DrawAxisTick(const Inner, InnerPlus, InnerMinus,
                                      Outer, OuterPlus, OuterMinus:TPoint);
begin
  Ticks.Draw(Inner, InnerPlus, InnerMinus, Outer, OuterPlus, OuterMinus);
end;

procedure TCircularGauge.DrawAxisMinorTick(const Inner, Outer:TPoint);
begin
  MinorTicks.Draw(Inner, TeeZeroPoint, TeeZeroPoint, Outer, TeeZeroPoint, TeeZeroPoint);
end;

procedure TCircularGauge.DrawAxis;
var tmp  : Double;
    tmpS : String;
    tmpValue,
    tmpStep,
    tmpStep2,
    tmpAngle,
    tmpAngle2,
    tmpXRad,
    tmpYRad,
    tmp2,
    tmpWidth : Double;
    x,y,
    width,
    height,
    tmpFontH,
    tmpXRadius,
    tmpYRadius,
    tmpW,
    t : Integer;
    P3Plus, P3Minus,
    P4Plus, P4Minus,
    P3, P4 : TPoint;
    tmpIndex : Integer;
begin
  if (Axis<>nil) and Axis.Visible then
  begin
    tmpXRadius:=XRadius;
    tmpYRadius:=YRadius;

    if Axis.Axis.Visible then
    begin
      ParentChart.Canvas.AssignVisiblePen(Axis.Axis);
      ParentChart.Canvas.Arc(INewRect.Left, INewRect.Top, INewRect.Right,
                             INewRect.Bottom, IStartAngle - 90,
                             IStartAngle-90+CalcSweepAngle);

      tmpW:=1+(Axis.Axis.Width div 2);
      Dec(tmpXRadius,tmpW);
      Dec(tmpYRadius,tmpW);
    end;

    tmpStep:=Axis.Increment;

    if Axis.Title.Visible and (Axis.Title.Caption<>'') then
    begin
      ParentChart.Canvas.AssignFont(Axis.Title.Font);

      width := ParentChart.Canvas.TextWidth(Axis.Title.Caption);
      height := ParentChart.Canvas.FontHeight;

      x := CircleXCenter - Round((tmpXRadius / 2.5) + (width * 0.5));
      y := CircleYCenter - Round(height * 0.5);

      ParentChart.Canvas.BackMode:=cbmTransparent;
      ParentChart.Canvas.TextOut(x, y, Axis.Title.Caption);
    end;

    if Axis.Ticks.Visible or Axis.Labels then
    begin
      Axis.TickLength := Ticks.VertSize;
      Axis.Ticks.Assign(Ticks.Pen);
      ParentChart.Canvas.AssignFont(Axis.LabelsFont);
      ParentChart.Canvas.AssignVisiblePen(Ticks.Pen);

      tmpXRad := (tmpXRadius - Axis.TickLength);
      tmpYRad := (tmpYRadius - Axis.TickLength);

      tmpFontH := ParentChart.Canvas.FontHeight;

      if (IRange<>0) and (tmpStep<>0) then
      begin
        tmpValue := Minimum;

        tmpIndex:=0;

        repeat
          tmpAngle :=(IStartAngle - 90) + (tmpValue * TotalAngle / IRange);
          tmp:=TeePiStep * tmpAngle;

          P3:= CalcPoint(tmp, ICenter, tmpXRad, tmpYRad);
          P4:= CalcPoint(tmp, ICenter, tmpXRadius, tmpYRadius);

          tmp2:= TeePiStep * (tmpAngle + (Ticks.HorizSize * 0.1));

          P3Plus := CalcPoint(tmp2, ICenter, tmpXRad, tmpYRad);
          tmp2 := TeePiStep * (tmpAngle - (Ticks.HorizSize * 0.1));
          P3Minus := CalcPoint(tmp2, ICenter, tmpXRad, tmpYRad);

          tmp2 := TeePiStep * (tmpAngle + (Ticks.HorizSize * 0.2));
          P4Plus := CalcPoint(tmp2, ICenter, tmpXRadius, tmpYRadius);
          tmp2 := TeePiStep * (tmpAngle - (Ticks.HorizSize * 0.2));
          P4Minus := CalcPoint(tmp2, ICenter, tmpXRadius, tmpYRadius);

          DrawAxisTick(P3, P3Plus, P3Minus, P4, P4Plus, P4Minus);

          if Axis.Labels then
          begin
            tmpS:=FormatFloat(ValueFormat, tmpValue);

            if Assigned(ParentChart.OnGetAxisLabel) then
               ParentChart.OnGetAxisLabel(Axis,nil,tmpIndex,tmpS); // 8.05

            if tmpS<>'' then
            begin
              tmpWidth := ParentChart.Canvas.TextWidth(tmpS);

              ParentChart.Canvas.BackMode:=cbmTransparent;

              if RotateLabels then
              begin
                tmpAngle2 := CalcAngleFromLength(P4, tmpWidth) * 0.5;

                if LabelsInside then
                   P3 := CalcPoint(tmp - tmpAngle2, ICenter,
                          tmpXRad - (tmpFontH * 0.25), tmpYRad - (tmpFontH * 0.25))
                else
                   P3 := CalcPoint(tmp - tmpAngle2, ICenter,
                          tmpXRadius + tmpFontH, tmpYRadius + tmpFontH);

                ParentChart.Canvas.RotateLabel(P3.X, P3.Y, tmpS, 90 - tmpAngle);
              end
              else
              begin
                if LabelsInside then
                begin
                  P3 := CalcPoint(tmp, ICenter, tmpXRad - (tmpFontH * 0.5),
                                  tmpYRad - (tmpFontH * 0.5));

                  tmpAngle2 := tmpAngle - 90;

                  if tmpAngle2 < 0 then
                     tmpAngle2 := tmpAngle2 * -1;

                  Dec(P3.Y, Round(tmpFontH * ((1.0 / 180.0) * tmpAngle2)));
                end
                else
                  P3 := CalcPoint(tmp, ICenter, tmpXRadius + tmpFontH, tmpYRadius + tmpFontH);

                tmpAngle2 := tmpAngle;

                if (tmpAngle2 > 180) then
                   tmpAngle2 := 180 - (tmpAngle2 - 180);

                if (tmpAngle2 < 0) then
                   tmpAngle2 := -tmpAngle2;

                Dec(P3.X, Round(tmpWidth * ((1.0 / 180.0) * tmpAngle2)));

                ParentChart.Canvas.TextOut(P3.X, P3.Y, tmpS);
              end;

            end;

            Inc(tmpIndex);
          end;

          tmpValue:=tmpValue + tmpStep;

        until tmpValue>Maximum;
      end;
    end;

    if (IRange<>0) and Axis.MinorTicks.Visible and (Axis.MinorTickCount>0) then
    begin
      Axis.MinorTickLength:=MinorTicks.VertSize;
      Axis.MinorTicks.Assign(MinorTicks.Pen);
      ParentChart.Canvas.AssignVisiblePen(MinorTicks.Pen);

      tmpXRad:= tmpXRadius - Axis.MinorTickLength - MinorTickDistance;
      tmpYRad:= tmpYRadius - Axis.MinorTickLength - MinorTickDistance;

      if tmpStep<>0 then
      begin
        tmpStep2 := tmpStep / (Axis.MinorTickCount + 1);
        tmpValue := Minimum;

        repeat
          for t:=1 to Axis.MinorTickCount do
          begin
            tmpAngle := (IStartAngle - 90) + ((tmpValue + t * tmpStep2) * TotalAngle / IRange);
            tmp := TeePiStep * tmpAngle;

            DrawAxisMinorTick(CalcPoint(tmp, ICenter, tmpXRad, tmpYRad),
                 CalcPoint(tmp, ICenter, tmpXRadius - MinorTickDistance, tmpYRadius - MinorTickDistance));
          end;

          tmpValue := tmpValue + tmpStep;

        until tmpValue > (Maximum - tmpStep);
      end;
    end;
  end;
end;

function TCircularGauge.CalcSweepAngle:Double;
begin
  result:=TotalAngle;
end;

function TCircularGauge.CalcStartAngle:Double;
begin
  result:=((360-TotalAngle)*0.5)+RotationAngle;
end;

function TCircularGauge.CalcValue(const AValue:Double):Double;
begin
  result:=((AValue*IAngleInc)+IStartAngle);
end;

function TCircularGauge.CalcDistance(Distance:Integer):Integer;
var tmp : Integer;
begin
  if Distance > 0 then
  begin
    tmp:=Min(XRadius, YRadius);

    if Axis.Visible then
       Dec(tmp,Axis.TickLength);

    result:=Round(Distance * tmp* 0.01 );
  end
  else
     result:=0;
end;

procedure TCircularGauge.DrawHand;
var tmpAngle : Double;
begin
  tmpAngle:=CalcValue(Value);

  if Hand.Visible then
  begin
    Hand.VertSize:=Max(1,CalcDistance(100-Hand.Distance));
    Hand.Draw(tmpAngle,ICenter,CalcDistance(Hand.Offset));
  end;

  DrawEnd(tmpAngle);
  DrawCenter;
end;

procedure TCircularGauge.DrawCenter;
begin
  if Center.Visible then
  begin
    Center.PrepareCanvas(ParentChart.Canvas,Center.Color);

    Center.Gradient.Angle:=90+Round(CalcValue(Value));
    Center.Draw(CircleXCenter,CircleYCenter);
  end;
end;

procedure TCircularGauge.DrawEnd(Angle:Double);

    Function RotatePoint(const AX,AY:Integer):TPoint;
    var tmpSin : Extended;
        tmpCos : Extended;
    begin
      SinCos(angle*TeePiStep,tmpSin,tmpCos);
      result.X:=ICenter.X-Round( AX*tmpCos + AY*tmpSin);
      result.Y:=ICenter.Y+Round(-AX*tmpSin + AY*tmpCos);
    end;

var tmp : TPoint;
begin
  if EndPoint.Visible then
  begin
    tmp:=RotatePoint(0,CalcDistance(95));
    EndPoint.PrepareCanvas(ParentChart.Canvas,EndPoint.Color);
    EndPoint.Draw(tmp.X,tmp.Y,EndPoint.Color, EndPoint.Style);
  end;
end;

procedure TCircularGauge.Assign(Source: TPersistent);
begin
  if Source is TCircularGauge then
  with TCircularGauge(Source) do
  begin
    Self.Center:=Center;
    Self.FCircled:=FCircled;
    Self.EndPoint:=EndPoint;
    Self.Hand:=Hand;
    Self.FLabelsInside:=FLabelsInside;
    Self.FRotateLabels:=FRotateLabels;
    Self.FRotAngle:=FRotAngle;
    Self.FTotalAngle:=FTotalAngle;
  end;

  inherited;

  TFramedAccess(Frame).SetDefaultCircled(True);
end;

class function TCircularGauge.GetEditorClass: String;
begin
  result:='TCircularGaugeEditor';
end;

Procedure TCircularGauge.DoBeforeDrawValues;
begin
  inherited;
  CalcRadius;
end;

Procedure TCircularGauge.CalcRadius;
begin
  with INewRect do
  begin
    FXRadius:=(Right-Left) div 2;
    FYRadius:=(Bottom-Top) div 2;

    ICenter.X := (Right+Left) div 2;
    ICenter.Y := (Top+Bottom) div 2;
  end;
end;

procedure TCircularGauge.SetCenter(const Value: TGaugeSeriesPointer);
begin
  FCenter.Assign(Value);
end;

procedure TCircularGauge.SetCircled(const Value:Boolean);
begin
  SetBooleanProperty(FCircled,Value);
end;

procedure TCircularGauge.SetEndPoint(const Value: TSeriesPointer);
begin
  FEndPoint.Assign(Value);
end;

function TCircularGauge.Axis:TChartAxis;
begin
  result:=GetHorizAxis;
end;

procedure TCircularGauge.SetHand(const Value: TGaugeHand);
begin
  FHand.Assign(Value);
end;

procedure TCircularGauge.SetLabelsInside(const Value: Boolean);
begin
  SetBooleanProperty(FLabelsInside,Value);
end;

procedure TCircularGauge.SetRotateLabels(const Value: Boolean);
begin
  SetBooleanProperty(FRotateLabels,Value);
end;

procedure TCircularGauge.SetRotAngle(const Value: Double);
begin
  SetDoubleProperty(FRotAngle,Value);
end;

procedure TCircularGauge.SetTotalAngle(const Value: Double);
begin
  SetDoubleProperty(FTotalAngle,Value);
end;

procedure TCircularGauge.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if not (csDestroying in ComponentState) then
  begin
    Hand.ParentChart:=ParentChart;
    Center.ParentChart:=ParentChart;
    EndPoint.ParentChart:=ParentChart;

    if Assigned(ParentChart) then
    begin
      Axis.Title.Caption:='';
      Axis.Increment:=10;
    end;
  end;
end;

function TCircularGauge.UseAxis: Boolean;
begin
  result:=False;
end;

{ TGaugeHand }

Constructor TGaugeHand.Create(AOwner: TChartSeries);
begin
  inherited;

  FDistance:=30;
  FOffset:=80;

  GaugeStyle:=gpHand;
  HorizSize:=5;
  VertSize:=FDistance;
  Brush.Style:=bsSolid;
  Brush.Color := clBlack;
  Pen.Color:=TCustomGauge(AOwner).GetPaletteColor(12);
  Pen.Visible := False;
  Pen.Width:= 1;

  Gradient.Visible:=True;
  Gradient.EndColor:=TCustomGauge(AOwner).GetPaletteColor(13);
  Gradient.MidColor:=TCustomGauge(AOwner).GetPaletteColor(14);
  Gradient.StartColor:=TCustomGauge(AOwner).GetPaletteColor(15);
  Gradient.Direction:=gdLeftRight;

  Shadow.Color:=clBlack;
  Shadow.Size:=5;
  Shadow.Visible:=True;
end;

procedure TGaugeHand.Draw(const Angle:Double; Center:TPoint; Off:Integer);
var
  tmpSin : Extended;
  tmpCos : Extended;

  Function CalcPoint(const AX,AY:Integer):TPoint;
  begin
    result.X:=Center.X-Round( AX*tmpCos + AY*tmpSin);
    result.Y:=Center.Y+Round(-AX*tmpSin + AY*tmpCos);
  end;

var
  tmpP : TPointArray;

  procedure CalcPoints(xOff,yOff:Integer);
  begin
    tmpP[0]:=CalcPoint(xOff-HorizSize,  yOff-Off);
    tmpP[1]:=CalcPoint(xOff+HorizSize,  yOff-Off);
    tmpP[2]:=CalcPoint(xOff+HorizSize-2,yOff+VertSize-2);
    tmpP[3]:=CalcPoint(xOff,            yOff+VertSize);
    tmpP[4]:=CalcPoint(xOff-HorizSize+2,yOff+VertSize-2);
  end;

begin
  SinCos(angle*TeePiStep,tmpSin,tmpCos);

  SetLength(tmpP,5);

  if Shadow.Visible then
  begin
    CalcPoints(Shadow.HorizSize,Shadow.VertSize);
    Shadow.Draw(ParentChart.Canvas,tmpP);
  end;

  PrepareCanvas(ParentChart.Canvas,Color);
  CalcPoints(0,0);

  if Gradient.Visible then
  begin
    Gradient.Draw(ParentChart.Canvas,tmpP,0,False);
    ParentChart.Canvas.Brush.Style:=bsClear;
  end;

  ParentChart.Canvas.Polygon(tmpP);

  tmpP:=nil;
end;

procedure TGaugeHand.SetDistance(const Value: Integer);
begin
  if FDistance<>Value then
  begin
    FDistance:=Value;
    Repaint;
  end;
end;

procedure TGaugeHand.SetOffset(const Value: Integer);
begin
  if FOffset<>Value then
  begin
    FOffset:=Value;
    Repaint;
  end;
end;

procedure TCircularGaugeEditor.FormShow(Sender: TObject);
begin
  inherited;

  if Gauge is TCircularGauge then
  with TCircularGauge(Gauge) do
  begin
    UDTotalAngle.Position:=Round(TotalAngle);
    UDRotAngle.Position:=Round(RotationAngle);
    UDHandDist.Position:=Hand.Distance;
    UDHandOff.Position:=Hand.Offset;
    CBLabelsInside.Checked:=LabelsInside;
    CBRotateLabels.Checked:=RotateLabels;
    CBCircled.Checked:=Circled;
  end;

  Timer1.Enabled:=True;
end;

procedure TCircularGaugeEditor.BHandClick(Sender: TObject);
begin
  EditSeriesPointer(Self,(Gauge as TCircularGauge).Hand);
end;

procedure TCircularGaugeEditor.BCenterClick(Sender: TObject);
begin
  EditSeriesPointer(Self,(Gauge as TCircularGauge).Center);
end;

procedure TCircularGaugeEditor.Button3Click(Sender: TObject);
begin
  EditSeriesPointer(Self,(Gauge as TCircularGauge).EndPoint);
end;

procedure TCircularGaugeEditor.CBLabelsInsideClick(Sender: TObject);
begin
  (Gauge as TCircularGauge).LabelsInside:=CBLabelsInside.Checked;
end;

procedure TCircularGaugeEditor.CBRotateLabelsClick(Sender: TObject);
begin
  (Gauge as TCircularGauge).RotateLabels:=CBRotateLabels.Checked;
end;

procedure TCircularGaugeEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     (Gauge as TCircularGauge).Hand.Distance:=UDHandDist.Position;
end;

procedure TCircularGaugeEditor.Edit3Change(Sender: TObject);
begin
  if Showing then
     (Gauge as TCircularGauge).Hand.Offset:=UDHandOff.Position;
end;

procedure TCircularGaugeEditor.ETotalAngleChange(Sender: TObject);
begin
  if Showing then
     (Gauge as TCircularGauge).TotalAngle:=UDTotalAngle.Position;
end;

procedure TCircularGaugeEditor.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;

  BLinearHand.Visible:=False;
  BValueArea.Visible:=False;
  BMaxIndicator.Visible:=False;
end;

procedure TCircularGaugeEditor.CBCircledClick(Sender: TObject);
begin
  (Gauge as TCircularGauge).Circled:=CBCircled.Checked;
end;

procedure TCircularGaugeEditor.Edit4Change(Sender: TObject);
begin
  if Showing then
     (Gauge as TCircularGauge).RotationAngle:=UDRotAngle.Position;
end;

initialization
  RegisterClass(TCircularGaugeEditor);
  RegisterTeeSeries(TCircularGauge, {$IFNDEF CLR}@{$ENDIF}TeeMsg_CircularGauge,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryGauges,1);
finalization
  UnRegisterTeeSeries([TCircularGauge]);
end.
