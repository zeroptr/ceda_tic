{**********************************************}
{   TeeChart Linear Gauge style                }
{   Copyright (c) 2009 by Steema Software      }
{**********************************************}
unit TeeLinearGauge;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  {$ENDIF}
  TeeNumericGauge, TeCanvas, TeeCustomShapeEditor, Chart, TeeProCo,
  TeeProcs, TeEngine, TeePenDlg, TeeEdiGrad;

type
  TGaugePointerStyles=(gpHand, gpCenter, gpTick, gpMinorTick, gpColorLine);

  TGaugeSeriesPointer=class(TSeriesPointer)
  private
    FGaugeStyle : TGaugePointerStyles;
    procedure SetGaugeStyle(const Value: TGaugePointerStyles);
  protected
    PXMinus,
    PXPlus,
    PYMinus,
    PYPlus      : Integer;

    PXMinusSmall,
    PXPlusSmall,
    PYMinusSmall,
    PYPlusSmall : Integer;

		IStartAngle : Double;

    procedure SetValues(x, y, horiz, vert:Integer);
  public
    procedure Draw(const Inner,InnerPlus,InnerMinus,
                   Outer,OuterPlus,OuterMinus:TPoint); overload;
  published
    property GaugeStyle:TGaugePointerStyles read FGaugeStyle write SetGaugeStyle;
  end;

  TGaugePointerRange=class(TGaugeSeriesPointer)
  private
    FEndValue   : Double;
    FStartValue : Double;

    procedure SetEndValue(const Value: Double);
    procedure SetStartValue(const Value: Double);
  public
    procedure Draw(const StartAngle,EndAngle:Double; const Rectangle:TRect);
  published
    property EndValue:Double read FEndValue write SetEndValue;
    property StartValue:Double read FStartValue write SetStartValue;
  end;

  TCustomGaugeMinMax=class(TCustomGauge)
  private
    FGreenLine  : TGaugePointerRange;
    FHand       : TGaugeSeriesPointer;
    FHorizontal : Boolean;
    FMaximum    : TChartValue;
    FMinimum    : TChartValue;
    FMinorDist  : Integer;
    FMinorTicks : TGaugeSeriesPointer;
    FRedLine    : TGaugePointerRange;
    FTicks      : TGaugeSeriesPointer;

    IAxisDone   : Boolean;
    procedure SetAxisOnce;
    procedure SetGreenLine(const Value: TGaugePointerRange);
    procedure SetHand(const Value: TGaugeSeriesPointer);
    procedure SetHorizontal(const Value: Boolean);
    procedure SetMaximum(const Value: TChartValue);
    procedure SetMinimum(const Value: TChartValue);
    procedure SetMinorDist(const Value: Integer);
    procedure SetMinorTicks(const Value: TGaugeSeriesPointer);
    procedure SetRedLine(const Value: TGaugePointerRange);
    procedure SetTicks(const Value: TGaugeSeriesPointer);
  protected
    IRange : Double;

    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    function Axis:TChartAxis; virtual; abstract;
    procedure DrawAllValues; override;
    procedure DrawAxis; virtual; abstract;
    procedure DrawAxisMinorTick(const Inner,Outer:TPoint);
    procedure DrawAxisTick(const Inner,InnerPlus,InnerMinus,Outer,OuterPlus,OuterMinus:TPoint);
    procedure DrawHand; virtual;
    Procedure SetParentChart(const Value:TCustomAxisPanel); override;
    procedure SetValues; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    property GreenLine:TGaugePointerRange read FGreenLine write SetGreenLine;
    property Hand:TGaugeSeriesPointer read FHand write SetHand;
    property Horizontal:Boolean read FHorizontal write SetHorizontal default True;
    property Maximum:TChartValue read FMaximum write SetMaximum;
    property Minimum:TChartValue read FMinimum write SetMinimum;
    property MinorTickDistance:Integer read FMinorDist write SetMinorDist default 0;
    property MinorTicks:TGaugeSeriesPointer read FMinorTicks write SetMinorTicks;
    property RedLine:TGaugePointerRange read FRedLine write SetRedLine;
    property Ticks:TGaugeSeriesPointer read FTicks write SetTicks;
  published
    property ShowInLegend default False;
  end;

  TLinearGauge=class(TCustomGaugeMinMax)
  private
    FMaxIndicator    : TGaugeSeriesPointer;
    FUseValuePalette : Boolean;
    FValueArea       : TTeeShape;

    IAxisRect        : TRect;
    IMaxValue        : TChartValue;

    procedure DrawColorLines;
    procedure SetMaxIndicator(const Value: TGaugeSeriesPointer);
    procedure SetUseValuePalette(const Value: Boolean);
    procedure SetValueArea(const Value: TTeeShape);
  protected
    function Axis:TChartAxis; override;
    class procedure CreateSubGallery(AddSubChart: TChartSubGalleryProc); override;
    class Function GetEditorClass:String; override;
    procedure DrawAllValues; override;
    procedure DrawAxis; override;
    procedure DrawHand; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetParentChart(const Value:TCustomAxisPanel); override;
    procedure SetValue(const AValue: TChartValue); override;
    procedure SetValues; override;
    class procedure SetSubGallery(ASeries: TChartSeries; Index: Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    function UseAxis:Boolean; override;
  published
    property Active;
    property Cursor;
    property ParentChart;
    property DataSource;  { after parentchart }
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

    property Face;
    property Frame;
    property GreenLine;
    property Hand;
    property Horizontal;
    property Maximum;
    property MaxValueIndicator:TGaugeSeriesPointer read FMaxIndicator write SetMaxIndicator;
    property Minimum;
    property MinorTickDistance;
    property MinorTicks;
    property RedLine;
    property Ticks;
    property UseValueColorPalette:Boolean read FUseValuePalette
                                         write SetUseValuePalette default False;
    property Value;
    property ValueArea:TTeeShape read FValueArea write SetValueArea;
  end;

  TLinearGaugeEditor = class(TNumericGaugeEditor)
    TabAxis: TTabSheet;
    TabGreen: TTabSheet;
    TabRed: TTabSheet;
    EStartGreen: TEdit;
    EEndGreen: TEdit;
    UDStartGreen: TUpDown;
    UDEndGreen: TUpDown;
    BValueArea: TButton;
    BMaxIndicator: TButton;
    PageControl3: TPageControl;
    TabSheet7: TTabSheet;
    TabSheet9: TTabSheet;
    TabTitle: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    ETicks: TEdit;
    UDTicks: TUpDown;
    UDTicksDist: TUpDown;
    ETicksDist: TEdit;
    Button2: TButton;
    EMinor: TEdit;
    UDMinorCount: TUpDown;
    UDMinorSize: TUpDown;
    Edit2: TEdit;
    EMax: TEdit;
    EMin: TEdit;
    Label6: TLabel;
    EFormat: TEdit;
    Button6: TButton;
    CBLabels: TCheckBox;
    Label7: TLabel;
    Label10: TLabel;
    BRed: TButton;
    EStartRed: TEdit;
    EEndRed: TEdit;
    UDStartRed: TUpDown;
    UDEndRed: TUpDown;
    BGreen:TButton;
    BLinearHand: TButton;
    CBGreenVisible: TCheckBox;
    CBRedVisible: TCheckBox;
    BAxis: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CBLabelsClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EFormatChange(Sender: TObject);
    procedure BGreenClick(Sender: TObject);
    procedure EStartGreenChange(Sender: TObject);
    procedure EEndGreenChange(Sender: TObject);
    procedure EMinChange(Sender: TObject);
    procedure EMaxChange(Sender: TObject);
    procedure BValueAreaClick(Sender: TObject);
    procedure BMaxIndicatorClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure EMinorChange(Sender: TObject);
    procedure ETicksChange(Sender: TObject);
    procedure ETicksDistChange(Sender: TObject);
    procedure BLinearHandClick(Sender: TObject);
    procedure CBGreenVisibleClick(Sender: TObject);
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
  Math, TeePoEdi, TeeEdiFont, TeeEdiAxis, TeeConst;

const
  BlackPalette : Array[0..23] of TColor = (
      $282828,
      $323232,
      $646464,
      $0F0F0F,
      $484848,
      $0F0F0F,

      $282864, // 6
      clNone,
      $646464,

      $646464,
      clNone,
      $1EC81E,

      $3C73C8, // 12
      clRed, //$3C73C8,
      $3C73C8,
      $0A3296,

      $828282, // 16
      $828282,
      clNone,

      $1E1E1E,
      $646464,
      $646464,
      $646464,
      $646464
    );

{ TLinearGauge }

Constructor TLinearGauge.Create(AOwner: TComponent);
begin
  inherited;

  FValueArea:=TTeeShape.Create(nil);
  FValueArea.Transparent:=True;

  Value:=Round(Random(100));

  IMaxValue:=100;

  FRedLine.FStartValue:=80;
  FRedLine.FEndValue:=100;

  FGreenLine.FStartValue:=0;
  FGreenLine.FEndValue:=40;

  FMaxIndicator:=TGaugeSeriesPointer.Create(Self);

  FMaxIndicator.Style:=psTriangle;

  FMaxIndicator.Brush.Color:=clRed;
  FMaxIndicator.VertSize:=5;
  FMaxIndicator.Draw3D:=False;
end;

Destructor TLinearGauge.Destroy;
begin
  FMaxIndicator.Free;
  FValueArea.Free;
  inherited;
end;

procedure TLinearGauge.Assign(Source: TPersistent);
begin
  if Source is TLinearGauge then
  with TLinearGauge(Source) do
  begin
    Self.FHorizontal:=FHorizontal;
    Self.MaxValueIndicator:=MaxValueIndicator;
    Self.FUseValuePalette:=FUseValuePalette;
    Self.ValueArea:=ValueArea;
  end;

  inherited;
end;

function TLinearGauge.UseAxis:Boolean;
begin
  result:=False;
end;

procedure TLinearGauge.DrawAllValues;

  function GetPixelValue(const Value:Double):Integer;
  begin
    if IRange=0 then
       result:=0
    else
    begin
      if FHorizontal then result:=(IAxisRect.Right-IAxisRect.Left)
                     else result:=(IAxisRect.Bottom-IAxisRect.Top);

      result:=Round((Value - Minimum) * ( result / IRange));
    end;
  end;

begin
  if not FHorizontal then
  begin
    FMaxIndicator.Style:=psLeftTriangle;
    Face.Gradient.Direction:=gdRightLeft;
  end;

  inherited;

  if FMaxIndicator.Visible then
  begin
    FMaxIndicator.PrepareCanvas(ParentChart.Canvas,FMaxIndicator.Color);

    if FHorizontal then
       FMaxIndicator.Draw(IAxisRect.Left + GetPixelValue(IMaxValue),IAxisRect.Bottom)
    else
       FMaxIndicator.Draw(IAxisRect.Right,IAxisRect.Bottom - GetPixelValue(IMaxValue));
  end;
end;

procedure TLinearGauge.DrawHand;
var pixelStep : Double;
    tmp       : Integer;
begin
  if Hand.Visible then
  begin
    if UseValueColorPalette then
    with Hand.Gradient do
    begin
			Visible:=True;

      if FHorizontal then
         Direction:=gdLeftRight
      else
         Direction:=gdBottomTop;
    end
    else
      Hand.Gradient.Visible:=False;

    Hand.PrepareCanvas(ParentChart.Canvas,Hand.Color);

    if FHorizontal then pixelStep:=(IAxisRect.Right-IAxisRect.Left)
                   else pixelStep:=(IAxisRect.Bottom-IAxisRect.Top);

    pixelStep:=(pixelStep / IRange) * (Value-Minimum);

    Hand.Draw3D:=False;

    tmp:=Round(pixelStep*0.5);

    if tmp<>0 then
    begin
      if FHorizontal then
         Hand.HorizSize:=tmp
      else
         Hand.VertSize:=tmp;

      if FHorizontal then
         tmp:=(IAxisRect.Bottom-IAxisRect.Top) div 2
      else
         tmp:=(IAxisRect.Right-IAxisRect.Left) div 2;

      if tmp<>0 then
      begin
        if FHorizontal then
        begin
          Hand.VertSize:=tmp;
          Hand.Draw(IAxisRect.Left+Hand.HorizSize, IAxisRect.Top+Hand.VertSize,
                    Hand.Color,psRectangle);
        end
        else
        begin
          Hand.HorizSize:=tmp;
          Hand.Draw(IAxisRect.Left + Hand.HorizSize, IAxisRect.Bottom-Hand.VertSize,
                    Hand.Color,psRectangle);
        end;
      end;
    end;
  end;
end;

class function TLinearGauge.GetEditorClass: String;
begin
  result:='TLinearGaugeEditor';
end;

procedure TLinearGauge.SetMaxIndicator(const Value: TGaugeSeriesPointer);
begin
  FMaxIndicator.Assign(Value);
end;

procedure TLinearGauge.SetUseValuePalette(const Value: Boolean);
begin
  SetBooleanProperty(FUseValuePalette,Value);
end;

procedure TLinearGauge.SetValue(const AValue: TChartValue);
begin
  if AValue>IMaxValue then
     IMaxValue:=AValue;

  inherited;
end;

procedure TLinearGauge.SetValueArea(const Value: TTeeShape);
begin
  FValueArea.Assign(Value);
end;

type
  TAxisAccess=class(TChartAxis);

procedure TLinearGauge.DrawAxis;

  procedure CalcAxisRectangle;
  var tmp : Integer;
  begin
    with IAxisRect do
    begin
      if FHorizontal then
      begin
        tmp:=Round((INewRect.Right-INewRect.Left) * 0.8);
        Left := (INewRect.Left + ((INewRect.Right-INewRect.Left) div 2)) - (tmp div 2);
        Right:=Left+tmp;

        tmp:=Ticks.VertSize;
        Top := INewRect.Top + (((INewRect.Bottom-INewRect.Top) - tmp) div 2);
        Bottom:=Top+tmp;
      end
      else
      begin
        tmp:=Round((INewRect.Bottom-INewRect.Top) * 0.8);
        Top := (INewRect.Top + ((INewRect.Bottom-INewRect.Top) div 2)) - (tmp div 2);
        Bottom:=Top+tmp;

        tmp:=Ticks.VertSize;
        Left := INewRect.Left + (((INewRect.Right-INewRect.Left) - tmp) div 2);
        Right:=Left+tmp;
      end;
    end;
  end;

var tmpS : String;
    tmpValue, tmpStep, tmpStep2,
    tmpWidth,
    pixelStep,
    pixelStepMin : Double;
    tmp,
    count,
    tmpW,
    tmpFontH, t:Integer;

    P3Minus,
    P3Plus,
    P4Minus,
    P4Plus,
    P3, P4 : TPoint;
    tmpAxis : Boolean;
begin
  if (Axis<>nil) and Axis.Visible then
  begin
    Axis.Increment := IRange * 0.1;
    tmpStep := Axis.Increment;
    CalcAxisRectangle;

    ParentChart.Canvas.AssignVisiblePen(Axis.Axis);

    tmpAxis:=Axis.Axis.Visible and (Axis.Axis.Width > 0);

    tmp:=Axis.Axis.Width div 2;

    if tmpAxis then
    begin
      InflateRect(IAxisRect,Axis.Axis.Width,Axis.Axis.Width);
      OffsetRect(IAxisRect,tmp,tmp);
    end;

    ValueArea.DrawRectRotated(ParentChart,IAxisRect);

    if tmpAxis then
    begin
      InflateRect(IAxisRect,-Axis.Axis.Width,-Axis.Axis.Width);
      OffsetRect(IAxisRect,-tmp,-tmp);
    end;

    if FHorizontal then
       tmpW:=(IAxisRect.Right-IAxisRect.Left)
    else
       tmpW:=(IAxisRect.bottom-IAxisRect.top);

    if Axis.Title.Visible and (Axis.Title.Caption<>'') then
      if FHorizontal then
         TAxisAccess(Axis).DrawTitle(IAxisRect.Left+(tmpW div 2),
                                     IAxisRect.Bottom +
                                     (ParentChart.Canvas.FontHeight div 2))
       else
         TAxisAccess(Axis).DrawTitle(IAxisRect.Right +
                                     (ParentChart.Canvas.FontHeight + 10),
                                     IAxisRect.Top+(tmpW div 2));

    if Axis.Ticks.Visible or Axis.Labels then
    begin
      Axis.TickLength:=Ticks.VertSize;
      Axis.Ticks.Assign(Ticks.Pen);

      ParentChart.Canvas.AssignFont(Axis.LabelsFont);
      ParentChart.Canvas.AssignVisiblePen(Ticks.Pen);

      tmpFontH:=ParentChart.Canvas.FontHeight;

      if (IRange<>0) and (tmpStep<>0) then
      begin
        if FHorizontal then
           tmpValue := Minimum
        else
           tmpValue := Maximum;

        pixelStep := tmpW / IRange;
        pixelStep :=pixelStep*tmpStep;

        count:=0;

        if FHorizontal then
        begin
          repeat
            P3 := TeePoint(IAxisRect.Left + Round(pixelStep * count), IAxisRect.Top);
            P4 := TeePoint(P3.X, P3.Y + (IAxisRect.Bottom-IAxisRect.Top));  //(IAxisRectangle.Height - Axis.AxisPen.Width));
            P3Minus := TeePoint(P3.X - Round(Ticks.HorizSize * 0.5), P3.Y);
            P3Plus := TeePoint(P3.X + Round(Ticks.HorizSize * 0.5), P3.Y);
            P4Minus := TeePoint(P4.X - Round(Ticks.HorizSize * 0.5), P4.Y);
            P4Plus := TeePoint(P4.X + Round(Ticks.HorizSize * 0.5), P4.Y);

            DrawAxisTick(P3, P3Plus, P3Minus, P4, P4Plus, P4Minus);

            if Axis.Labels then
            begin
              tmpS := FormatFloat(ValueFormat, tmpValue);
              tmpWidth := ParentChart.Canvas.TextWidth(tmpS);

              ParentChart.Canvas.BackMode:=cbmTransparent;
              ParentChart.Canvas.TextOut(P3.X - Round(tmpWidth * 0.6), P3.Y - tmpFontH, tmpS);
            end;

            tmpValue :=tmpValue+tmpStep;

            Inc(count);

          until tmpValue>Maximum
        end
        else
        begin
          repeat
            P3 := TeePoint(IAxisRect.Left, IAxisRect.Top+ Round(pixelStep * count));
            P4 := TeePoint(P3.x+ (IAxisRect.right-IAxisRect.left), P3.y );  //(IAxisRectangle.Height - Axis.AxisPen.Width));
            P3Minus := TeePoint(P3.x, P3.y - Round(Ticks.HorizSize * 0.5));
            P3Plus := TeePoint(P3.x, P3.y + Round(Ticks.HorizSize * 0.5));
            P4Minus := TeePoint(P4.x, P4.y - Round(Ticks.HorizSize * 0.5));
            P4Plus := TeePoint(P4.x, P4.y  + Round(Ticks.HorizSize * 0.5));

            DrawAxisTick(P3, P3Plus, P3Minus, P4, P4Plus, P4Minus);

            if Axis.Labels then
            begin
              tmpS := FormatFloat(ValueFormat, tmpValue);
              tmpWidth := ParentChart.Canvas.TextWidth(tmpS);

              ParentChart.Canvas.BackMode:=cbmTransparent;
              ParentChart.Canvas.TextOut(P3.X - Round(tmpWidth)-8,
                                         P3.Y - (Round(tmpFontH div 2)), tmpS);
            end;

            tmpValue :=tmpValue-tmpStep;

            Inc(count);

          until tmpValue<Minimum;
        end;
      end;

      if (IRange<>0) and Axis.MinorTicks.Visible and (Axis.MinorTickCount>0) then
      begin
        if FHorizontal then
           Axis.MinorTickLength := MinorTicks.VertSize
        else
           Axis.MinorTickLength := MinorTicks.HorizSize;

        Axis.MinorTicks.Assign(MinorTicks.Pen);
        ParentChart.Canvas.AssignVisiblePen(MinorTicks.Pen);

        if tmpStep<>0 then
        begin
          tmpStep2 := tmpStep / (Axis.MinorTickCount + 1);
          tmpValue := Minimum;

          count := 0;
          pixelStep := tmpW / IRange;
          pixelStepMin := pixelStep * tmpStep2;
          pixelStep :=pixelStep * tmpStep;

          repeat
            for t:=1 to Axis.MinorTickCount do
            begin
              if FHorizontal then
              begin
                P3 := TeePoint(IAxisRect.Left + Round(pixelStep * count) +
                      Round(pixelStepMin * t), IAxisRect.Top + MinorTickDistance);
                P4 := TeePoint(P3.X, P3.Y + (((IAxisRect.Bottom-IAxisRect.Top) - Axis.Axis.Width) div 2 ));
              end
              else
              begin
                P3 := TeePoint(IAxisRect.Left + MinorTickDistance ,
                       IAxisRect.Top + Round(pixelStep * count) +
                       Round(pixelStepMin * t) );
                P4 := TeePoint(P3.X+ (((IAxisRect.Right-IAxisRect.Left) - Axis.Axis.Width) div 2 ), P3.Y );
              end;

              DrawAxisMinorTick(P3, P4);
            end;

            Inc(count);
            tmpValue:=tmpValue+tmpStep;

          until not (tmpValue <= (Maximum - tmpStep));
        end;
      end;
    end;
  end;

  DrawColorLines;
end;

procedure TLinearGauge.DrawColorLines;

  procedure DrawColorLine(Line:TGaugePointerRange);
  var	pixelStep,
      tmpStart,
      tmpEnd : Double;
      tmpR   : TRect;
  begin
    if Line.Visible then
    begin
      if FHorizontal then
         pixelStep := (IAxisRect.Right-IAxisRect.Left) / IRange
      else
         pixelStep := (IAxisRect.Bottom-IAxisRect.Top) / IRange;

      tmpStart := pixelStep * (Line.StartValue - Minimum);
      tmpEnd := pixelStep * (Line.EndValue - Minimum);

      ParentChart.Canvas.AssignVisiblePen(Line.Pen);
      ParentChart.Canvas.AssignBrush(Line.Brush);

      if FHorizontal then
         tmpR:=TeeRect(IAxisRect.Left + Round(tmpStart),
                       IAxisRect.Bottom + Axis.Axis.Width,
                       IAxisRect.Left + Round(tmpEnd),
                       IAxisRect.Bottom + Axis.Axis.Width + Line.VertSize)
      else
         tmpR:=TeeRect(IAxisRect.Right + Axis.Axis.Width,
                       IAxisRect.Bottom - Round(tmpEnd),
                       IAxisRect.Right + Axis.Axis.Width + Line.VertSize,
                       IAxisRect.Bottom -  Round(tmpStart));

      if Line.Gradient.Visible then
      begin
        if FHorizontal then
           Line.Gradient.Direction := gdLeftRight
        else
           Line.Gradient.Direction := gdBottomTop;

        Line.Gradient.Draw(ParentChart.Canvas,tmpR);
        ParentChart.Canvas.Brush.Style:=bsClear;
      end;

      ParentChart.Canvas.Rectangle(tmpR);
    end;
  end;

begin
    DrawColorLine(RedLine);
    DrawColorLine(GreenLine);
end;

function TLinearGauge.Axis:TChartAxis;
begin
  if FHorizontal then
     result:=GetHorizAxis
  else
     result:=GetVertAxis;
end;

procedure TLinearGauge.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if not (csDestroying in ComponentState) then
  begin
    MaxValueIndicator.ParentChart:=ParentChart;
    ValueArea.ParentChart:=ParentChart;
  end;
end;

procedure TLinearGauge.SetValues;
begin
  CalcOrigRect;
  INewRect:=IOrigRect;
  inherited;
end;

procedure TLinearGauge.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  Axis.Labels:=False;
  Axis.Title.Hide;
  Value:=Random(100);
end;

class procedure TLinearGauge.CreateSubGallery(AddSubChart: TChartSubGalleryProc);
begin
  inherited;
end;

class procedure TLinearGauge.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  inherited;
  TLinearGauge(ASeries).Horizontal:=Index=0;
end;

{ TCustomGaugeMinMax }

Constructor TCustomGaugeMinMax.Create(AOwner: TComponent);

  procedure SetLineProperties(Line:TGaugePointerRange; Color1,Color2,Color3:Integer);
  begin
    with Line do
    begin
      GaugeStyle:=gpColorLine;
      VertSize:=5;

      Brush.Style:=bsSolid;
      Brush.Color:=GetPaletteColor(Color3);

      with Gradient do
      begin
        Visible:=True;

        if FHorizontal then
           Direction:=gdLeftRight
        else
           Direction:=gdBottomTop;

        StartColor:=GetPaletteColor(Color1);
        MidColor:=GetPaletteColor(Color2);
        EndColor:=GetPaletteColor(Color3);
      end;
    end;
  end;

begin
  inherited;

  SetGaugePalette(BlackPalette);

  FGreenLine:=TGaugePointerRange.Create(Self);
  SetLineProperties(FGreenLine,9,10,11);

  FRedLine:=TGaugePointerRange.Create(Self);
  SetLineProperties(FRedLine,6,7,8);

  FMinorTicks:=TGaugeSeriesPointer.Create(Self);
  with FMinorTicks do
  begin
    GaugeStyle:=gpMinorTick;
    Color:=clNone;
    VertSize:=1;
    HorizSize:=1;
    Pen.Color:=GetPaletteColor(23);
  end;

  FTicks:=TGaugeSeriesPointer.Create(Self);
  with FTicks do
  begin
    GaugeStyle:=gpTick;
  	Brush.Style:=bsClear;
	  VertSize:=10;
    Pen.Color:=GetPaletteColor(22);
  end;

  FHand:=TGaugeSeriesPointer.Create(Self);
  FHand.FGaugeStyle:=gpHand;
  FHand.Brush.Color:=clRed;
  FHand.Transparency:=70;
  FHand.Pen.Color:=GetPaletteColor(12);

  CalcVisiblePoints:=False;
  ShowInLegend:=False;
  FHorizontal:=True;

  FMaximum:=100;
end;

Destructor TCustomGaugeMinMax.Destroy;
begin
  FHand.Free;
  FGreenLine.Free;
  FMinorTicks.Free;
  FRedLine.Free;
  FTicks.Free;

  if (Axis<>nil) then
  with Axis do
  begin
    Title.Visible:=false;
    Title.Caption:='';
  end;

  inherited;
end;

procedure TCustomGaugeMinMax.Assign(Source: TPersistent);
begin
  if Source is TCustomGaugeMinMax then
  with TCustomGaugeMinMax(Source) do
  begin
    Self.GreenLine  :=GreenLine;
    Self.Hand       :=Hand;
    Self.FMaximum   :=FMaximum;
    Self.FMinimum   :=FMinimum;
    Self.FMinorDist :=FMinorDist;
    Self.MinorTicks :=MinorTicks;
    Self.RedLine    :=RedLine;
    Self.Ticks      :=Ticks;
  end;

  inherited;
end;

procedure TCustomGaugeMinMax.DrawHand;
begin
end;

Procedure TCustomGaugeMinMax.SetParentChart(const Value:TCustomAxisPanel);
begin
  inherited;

  if not (csDestroying in ComponentState) then
  begin
    GreenLine.ParentChart:=ParentChart;
    Hand.ParentChart:=ParentChart;
    RedLine.ParentChart:=ParentChart;
    MinorTicks.ParentChart:=ParentChart;
    Ticks.ParentChart:=ParentChart;

    if (not IAxisDone) then // TV52012914
       SetAxisOnce;
  end;
end;

procedure TCustomGaugeMinMax.SetAxisOnce;
begin
  if (Axis<>nil) then
  with Axis do
  begin
    Axis.Visible:=True;
    Title.Visible:=True;
    Title.Caption:='Axis Title %';
    Title.Font.Color:=GetPaletteColor(21);

    Labels:=True;
    LabelsFont.Color:=GetPaletteColor(20);
    LabelsFont.Name:=TeeMsg_DefaultFontName;
    LabelsFont.Size:=10;
    LabelsFont.Style:=[fsBold];

    IAxisDone:=True;
  end;
end;

procedure TCustomGaugeMinMax.SetGreenLine(const Value: TGaugePointerRange);
begin
  FGreenLine.Assign(Value);
end;

procedure TCustomGaugeMinMax.SetHand(const Value: TGaugeSeriesPointer);
begin
  FHand.Assign(Value);
end;

procedure TCustomGaugeMinMax.SetMaximum(const Value: TChartValue);
begin
  if FMaximum<>Value then
  begin
    FMaximum:=Value;
    Repaint;
  end;
end;

procedure TCustomGaugeMinMax.SetMinimum(const Value: TChartValue);
begin
  if FMinimum<>Value then
  begin
    FMinimum:=Value;
    Repaint;
  end;
end;

procedure TCustomGaugeMinMax.SetMinorDist(const Value: Integer);
begin
  SetIntegerProperty(FMinorDist,Value);
end;

procedure TCustomGaugeMinMax.SetMinorTicks(const Value: TGaugeSeriesPointer);
begin
  FMinorTicks.Assign(Value);
end;

procedure TCustomGaugeMinMax.SetRedLine(const Value: TGaugePointerRange);
begin
  FRedLine.Assign(Value);
end;

procedure TCustomGaugeMinMax.SetTicks(const Value: TGaugeSeriesPointer);
begin
  FTicks.Assign(Value);
end;

procedure TCustomGaugeMinMax.DrawAllValues;
begin
  inherited;
  DrawAxis;
  DrawHand;
end;

procedure TCustomGaugeMinMax.DrawAxisTick(const Inner,InnerPlus,InnerMinus,Outer,OuterPlus,OuterMinus:TPoint);
begin
  Ticks.Draw(Inner, InnerPlus, InnerMinus, Outer, OuterPlus, OuterMinus);
end;

procedure TCustomGaugeMinMax.DrawAxisMinorTick(const Inner,Outer:TPoint);
var tmp : Integer;
begin
  tmp:=MinorTicks.HorizSize div 2;

  MinorTicks.Draw(Inner, TeePoint(Inner.X + tmp, Inner.Y),
                  TeePoint(Inner.X - tmp, Inner.Y), Outer,
                  TeePoint(Inner.X + tmp, Inner.Y + MinorTicks.VertSize),
                  TeePoint(Inner.X - tmp, Inner.Y + MinorTicks.VertSize));
end;

procedure TCustomGaugeMinMax.SetValues;
begin
  inherited;
  IRange:=(Maximum - Minimum);
end;

procedure TCustomGaugeMinMax.AddSampleValues(NumValues: Integer;
  OnlyMandatory: Boolean);
begin
  Value:=Minimum+Random(Round(Maximum-Minimum));
end;

procedure TCustomGaugeMinMax.SetHorizontal(const Value: Boolean);
begin
  if FHorizontal<>Value then
  begin
    Axis.Title.Caption := '';
    SetBooleanProperty(FHorizontal,Value);
    SetAxisOnce; // force reset axis colors, fonts, etc.
  end;
end;

{ TGaugePointerRange }

procedure TGaugePointerRange.Draw(const StartAngle,EndAngle:Double;
                                  const Rectangle:TRect);

var
  tmpSin : Extended;
  tmpCos : Extended;
  count  : Integer;
  circle : TPointArray;
  tmpX   : Integer;
  tmpY   : Integer;

  procedure AddPoint(const radius:Double);
  begin
    circle[count].X:=tmpX+Round(radius * tmpCos);
    circle[count].Y:=tmpY+Round(radius * tmpSin);
    Inc(count);
  end;

var tmp,
    sweepAngle    : Integer;
    tmpStartAngle : Double;
    tmpEndAngle   : Double;
    i             : Integer;
    containerMin  : Integer;
    a,b,
    theta         : Double;
begin
  if Visible then
  begin
    PrepareCanvas(ParentChart.Canvas, Color);

    sweepAngle:=Abs(Round(EndAngle-StartAngle));

    tmpStartAngle:=StartAngle+90;
    tmpEndAngle:=tmpStartAngle+sweepAngle;

    tmp:=Round(tmpEndAngle)-Round(tmpStartAngle);

    if tmp<2 then
       Exit;

    SetLength(circle,2*tmp);

    containerMin:=Min((Rectangle.Right-Rectangle.Left),(Rectangle.Bottom-Rectangle.Top));

    RectCenter(Rectangle,tmpX,tmpY);

    count:=0;

    //CDI this is a circle
    for i:=Round(tmpStartAngle) to Round(tmpEndAngle)-1 do
    begin
      SinCos(i*TeePiStep,tmpSin,tmpCos);
      AddPoint(containerMin*0.5);
    end;

    a:= containerMin*0.5;
    b:= -VertSize*0.01;

    //CDI and this is a logarithmic spiral drawn backwards so last/first
    //points of graphicspath draw ok.
    for i:=Round(tmpEndAngle)-1 downto Round(tmpStartAngle) do
    begin
      theta:= i * TeePiStep;
      SinCos(theta,tmpSin,tmpCos);
      AddPoint(a * Exp(theta * b));
    end;

    if Gradient.Visible then
    begin
      Gradient.Angle:= Round(StartAngle - 90);
      ParentChart.Canvas.PolygonGradient(circle,Gradient);
    end
    else
       ParentChart.Canvas.Polygon(circle);

    // Release memory
    circle:=nil;
  end;
end;

procedure TGaugePointerRange.SetEndValue(const Value: Double);
begin
  if FEndValue<>Value then
  begin
    FEndValue:=Value;
    Repaint;
  end;
end;

procedure TGaugePointerRange.SetStartValue(const Value: Double);
begin
  if FStartValue<>Value then
  begin
    FStartValue:=Value;
    Repaint;
  end;
end;

{ TGaugeSeriesPointer }
procedure TGaugeSeriesPointer.SetValues(x, y, horiz, vert:Integer);
begin
  IStartAngle := 90 + (ArcTan2(Shadow.VertSize,Shadow.HorizSize) * (180/Pi));
  PXMinus := x - horiz;
  PXPlus := x + horiz;
  PYMinus := y - vert;
  PYPlus := y + vert;

  PXMinusSmall := PXMinus + 2;
  PXPlusSmall := PXPlus - 2;

  PYMinusSmall := PYMinus + (horiz * 2);
  PYPlusSmall := PYPlus - (horiz * 2);
end;

procedure TGaugeSeriesPointer.Draw(const Inner, InnerPlus, InnerMinus, Outer, OuterPlus, OuterMinus:TPoint);
begin
  if Visible then
  begin
    if GaugeStyle=gpTick then
    begin
      PrepareCanvas(ParentChart.Canvas,Color);
      ParentChart.Canvas.Polygon([OuterPlus, OuterMinus, InnerMinus, InnerPlus]);
    end
    else
    begin
      PrepareCanvas(ParentChart.Canvas,Color);

      if GaugeStyle=gpMinorTick then
         Draw(Outer.X, Outer.Y, Color, psCircle)
      else
         Draw(Outer.X, Outer.Y, Color, Style);
    end;
  end;
end;

procedure TGaugeSeriesPointer.SetGaugeStyle(const Value: TGaugePointerStyles);
begin
  if FGaugeStyle<>Value then
  begin
    FGaugeStyle:=Value;
    Repaint;
  end;
end;

procedure TLinearGaugeEditor.FormShow(Sender: TObject);
var tmp : TFormTeeAxis;
begin
  inherited;

  if Assigned(Gauge) then
  with Gauge as TCustomGaugeMinMax do
  begin
    BAxis.LinkPen(Axis.Axis);

    UDStartGreen.Position:=Round(GreenLine.StartValue);
    UDEndGreen.Position:=Round(GreenLine.EndValue);

    UDStartRed.Position:=Round(RedLine.StartValue);
    UDEndRed.Position:=Round(RedLine.EndValue);

    EMax.Text:=FloatToStr(Maximum);
    EMin.Text:=FloatToStr(Minimum);
    EFormat.Text:=ValueFormat;

    CBLabels.Checked:=Axis.Labels;

    tmp:=TFormTeeAxis.CreateAxis(Self,Axis);
    tmp.PageTitle.Parent:=TabTitle;
    tmp.PageAxis.ActivePage:=tmp.TabTitle;
    tmp.PageAxisChange(tmp);
    TeeTranslateControl(tmp);

    UDMinorSize.Position:=MinorTicks.Size;
    UDMinorCount.Position:=Axis.MinorTickCount;
    UDTicks.Position:=Ticks.VertSize;
    UDTicksDist.Position:=MinorTickDistance;

    CBGreenVisible.Checked:=GreenLine.Visible;
    CBRedVisible.Checked:=RedLine.Visible;
  end;
end;

procedure TLinearGaugeEditor.Button1Click(Sender: TObject);
begin
  EditSeriesPointer(Self,(Gauge as TCustomGaugeMinMax).Ticks);
end;

procedure TLinearGaugeEditor.Button2Click(Sender: TObject);
begin
  EditSeriesPointer(Self,(Gauge as TCustomGaugeMinMax).MinorTicks);
end;

procedure TLinearGaugeEditor.CBLabelsClick(Sender: TObject);
begin
  (Gauge as TCustomGaugeMinMax).Axis.Labels:=CBLabels.Checked;
end;

procedure TLinearGaugeEditor.Button3Click(Sender: TObject);
begin
  EditTeeFontEx(Self,(Gauge as TCustomGaugeMinMax).Axis.LabelsFont);
end;

procedure TLinearGaugeEditor.EFormatChange(Sender: TObject);
begin
  if Showing then
     (Gauge as TCustomGaugeMinMax).ValueFormat:=EFormat.Text;
end;

procedure TLinearGaugeEditor.BGreenClick(Sender: TObject);
begin
  if Sender=BGreen then
     EditSeriesPointer(Self,(Gauge as TCustomGaugeMinMax).GreenLine)
  else
     EditSeriesPointer(Self,(Gauge as TCustomGaugeMinMax).RedLine);
end;

procedure TLinearGaugeEditor.EStartGreenChange(Sender: TObject);

  procedure SetStartValue(AText:TEdit; ALine:TGaugePointerRange);
  var tmp : Double;
  begin
    if TryStrToFloat(AText.Text,tmp) then
       ALine.StartValue:=tmp;
  end;

begin
  if Showing then
     if Sender=EStartGreen then
        SetStartValue(EStartGreen,(Gauge as TCustomGaugeMinMax).GreenLine)
     else
        SetStartValue(EStartRed,(Gauge as TCustomGaugeMinMax).RedLine);
end;

procedure TLinearGaugeEditor.EEndGreenChange(Sender: TObject);

  procedure SetStartValue(AText:TEdit; ALine:TGaugePointerRange);
  var tmp : Double;
  begin
    if TryStrToFloat(AText.Text,tmp) then
       ALine.EndValue:=tmp;
  end;

begin
  if Showing then
     if Sender=EEndGreen then
        SetStartValue(EEndGreen,(Gauge as TCustomGaugeMinMax).GreenLine)
     else
        SetStartValue(EEndRed,(Gauge as TCustomGaugeMinMax).RedLine);
end;

procedure TLinearGaugeEditor.EMinChange(Sender: TObject);
var tmp : Double;
begin
  if Showing then
     if TryStrToFloat(EMin.Text,tmp) then
        (Gauge as TCustomGaugeMinMax).Minimum:=tmp;
end;

procedure TLinearGaugeEditor.EMaxChange(Sender: TObject);
var tmp : Double;
begin
  if Showing then
     if TryStrToFloat(EMax.Text,tmp) then
        (Gauge as TCustomGaugeMinMax).Maximum:=tmp;
end;

procedure TLinearGaugeEditor.BValueAreaClick(Sender: TObject);
begin
  EditTeeCustomShape(Self,(Gauge as TLinearGauge).ValueArea,True)
end;

procedure TLinearGaugeEditor.BMaxIndicatorClick(Sender: TObject);
begin
  EditSeriesPointer(Self,(Gauge as TLinearGauge).MaxValueIndicator);
end;

procedure TLinearGaugeEditor.Button6Click(Sender: TObject);
begin
  EditTeeFontEx(Self,(Gauge as TCustomGaugeMinMax).Axis.LabelsFont);
end;

procedure TLinearGaugeEditor.Edit2Change(Sender: TObject);
begin
  if Showing then
     (Gauge as TCustomGaugeMinMax).MinorTicks.Size:=UDMinorSize.Position;
end;

procedure TLinearGaugeEditor.EMinorChange(Sender: TObject);
begin
  if Showing then
     (Gauge as TCustomGaugeMinMax).Axis.MinorTickCount:=UDMinorCount.Position;
end;

procedure TLinearGaugeEditor.ETicksChange(Sender: TObject);
begin
  if Showing then
     (Gauge as TCustomGaugeMinMax).Ticks.VertSize:=UDTicks.Position;
end;

procedure TLinearGaugeEditor.ETicksDistChange(Sender: TObject);
begin
  if Showing then
     (Gauge as TCustomGaugeMinMax).MinorTickDistance:=UDTicksDist.Position;
end;

procedure TLinearGaugeEditor.BLinearHandClick(Sender: TObject);
begin
  EditSeriesPointer(Self,(Gauge as TLinearGauge).Hand);
end;

procedure TLinearGaugeEditor.CBGreenVisibleClick(Sender: TObject);
begin
  if Sender=CBGreenVisible then
     (Gauge as TCustomGaugeMinMax).GreenLine.Visible:=CBGreenVisible.Checked
  else
     (Gauge as TCustomGaugeMinMax).RedLine.Visible:=CBRedVisible.Checked
end;

initialization
  RegisterTeeSeries(TLinearGauge, {$IFNDEF CLR}@{$ENDIF}TeeMsg_LinearGauge,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryGauges,1);

  RegisterTeeSeriesFunction(TLinearGauge,nil, {$IFNDEF CLR}@{$ENDIF}TeeMsg_LinearGaugeVertical,
                                 {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryGauges,1,1);

  RegisterClass(TLinearGaugeEditor);
finalization
  UnRegisterTeeSeries([TLinearGauge]);
end.

