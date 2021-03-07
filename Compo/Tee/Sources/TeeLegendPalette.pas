{********************************************}
{   TeeChart Legend Palette tool             }
{   Copyright (c) 2006-2009 by David Berneda }
{********************************************}
unit TeeLegendPalette;
{$I TeeDefs.inc}

interface

// This tool displays a legend made with colors from a 3D series palette.

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes, SysUtils,
  {$IFDEF CLX}
  QControls, QForms, QExtCtrls, QStdCtrls, QComCtrls, QGraphics,
  {$ELSE}
  Controls, Forms, ExtCtrls, StdCtrls, ComCtrls, Graphics,
  {$ENDIF}
  {$IFDEF D6}
  Types,
  {$ENDIF}
  TeCanvas, TeeProcs, TeEngine, Chart, TeeTools, TeeSurfa, TeePenDlg,
  TeeToolSeriesEdit, TeeEdiPane, TeeEdiAxis;

const
  DefaultPanelColor=clWhite;

type
  TLegendPaletteAxis=(laDefault,laOther,laBoth);

  TLegendPaletteTool=class(TTeeCustomToolSeries)
  private
    FChart    : TCustomChart;
    FHeight   : Integer;
    FLeft     : Integer;
    FPositionUnits: TTeeUnits;
    FSmooth   : Boolean;
    FTop      : Integer;
    FVertical : Boolean;
    FWidth    : Integer;

    function GetAxis: TLegendPaletteAxis;
    function GetBorder: TChartHiddenPen;
    function GetColor: TColor;
    function GetGradient: TChartGradient;
    function GetInverted: Boolean;
    function GetShadow: TTeeShadow;
    function GetTransp: Boolean;
    procedure SetAxis(const Value: TLegendPaletteAxis);
    procedure SetBorder(const Value: TChartHiddenPen);
    procedure SetColor(const Value: TColor);
    procedure SetGradient(const Value: TChartGradient);
    procedure SetHeight(const Value: Integer);
    procedure SetInverted(const Value: Boolean);
    procedure SetLeft(const Value: Integer);
    procedure SetPositionUnits(const Value: TTeeUnits);
    procedure SetShadow(const Value: TTeeShadow);
    procedure SetSmooth(const Value: Boolean);
    procedure SetTop(const Value: Integer);
    procedure SetTransp(const Value: Boolean);
    procedure SetVertical(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
  protected
    procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    procedure SetSeries(const Value: TChartSeries); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    class Function Description:String; override;
    class Function LongDescription:String; override; // 8.0

    property Chart:TCustomChart read FChart;
  published
    property Active;
    property Axis:TLegendPaletteAxis read GetAxis write SetAxis default laBoth;
    property Border:TChartHiddenPen read GetBorder write SetBorder;
    property Color:TColor read GetColor write SetColor default DefaultPanelColor;
    property Gradient:TChartGradient read GetGradient write SetGradient;
    property Height:Integer read FHeight write SetHeight default 200;
    property Inverted:Boolean read GetInverted write SetInverted default False;
    property Left:Integer read FLeft write SetLeft default 10;
    property Pen;
    property PositionUnits:TTeeUnits read FPositionUnits write SetPositionUnits
                                                         default muPixels;
    property Series;
    property Shadow:TTeeShadow read GetShadow write SetShadow;
    property Smooth:Boolean read FSmooth write SetSmooth default False;
    property Top:Integer read FTop write SetTop default 10;
    property Transparent:Boolean read GetTransp write SetTransp default False;
    property Vertical:Boolean read FVertical write SetVertical default True;
    property Width:Integer read FWidth write SetWidth default 100;
  end;

  TLegendPaletteEditor = class(TSeriesToolEditor)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabPanel: TTabSheet;
    ButtonPen1: TButtonPen;
    RGAxis: TRadioGroup;
    CBTransp: TCheckBox;
    CBSmooth: TCheckBox;
    CBVertical: TCheckBox;
    TabAxes: TTabSheet;
    CBInverted: TCheckBox;
    TabSheet4: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label13: TLabel;
    ECustLeft: TEdit;
    UDLeft: TUpDown;
    ECustTop: TEdit;
    UDTop: TUpDown;
    CBUnits: TComboFlat;
    TabSheet5: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    ECustWidth: TEdit;
    ECustHeight: TEdit;
    UDWidth: TUpDown;
    UDHeight: TUpDown;
    BBorder: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure RGAxisClick(Sender: TObject);
    procedure CBTranspClick(Sender: TObject);
    procedure CBSmoothClick(Sender: TObject);
    procedure CBVerticalClick(Sender: TObject);
    procedure CBInvertedClick(Sender: TObject);
    procedure ECustLeftChange(Sender: TObject);
    procedure ECustTopChange(Sender: TObject);
    procedure CBUnitsChange(Sender: TObject);
    procedure ECustWidthChange(Sender: TObject);
    procedure ECustHeightChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    IAxes  : TFormTeeAxis;
    IPanel : TFormTeePanel;

    CreatingForm : Boolean;

    function LegendTool:TLegendPaletteTool;
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
  // Referencing TeePolarGrid here is not ideal.
  // This usage should be removed, adding an interface ISupportsPalette or similar
  // to TPolarGridSeries.
  // Then discovering this interface at TLegendPaletteTool.ChartEvent.
  TeePolarGrid, TeeProCo, TypInfo;

type
  TPaletteSeries=class(TChartSeries)
  private
    IGradient : TTeeGradient;
    ITool     : TLegendPaletteTool;
  protected
    procedure DrawValue(ValueIndex:Integer); override;
  end;

  TPaletteChart=class(TChart)
  private
    IParent : TCustomAxisPanel;
  public
    procedure Invalidate; override;
  end;

{ TPaletteChart }

procedure TPaletteChart.Invalidate;
begin
  if Assigned(IParent) then
     IParent.Invalidate;
end;

{ TLegendPaletteTool }

Constructor TLegendPaletteTool.Create(AOwner: TComponent);

  procedure PrepareAxis(Axis:TChartAxis);
  begin
    Axis.Axis.Width:=1;
    Axis.Axis.EndStyle:=esSquare;
    Axis.Grid.Hide;
  end;

const
  DefaultMargin=8;

var tmp : TPaletteSeries;
begin
  inherited;

  FChart:=TPaletteChart.Create(nil);
  with FChart do
  begin
    BufferedDisplay:=False;
    Zoom.Allow:=False;
    AllowPanning:=pmNone;
    View3D:=False;
    ClipPoints:=False;
    Color:=DefaultPanelColor;
    BevelOuter:=bvNone;
//    Border.Visible:=True;

    MarginLeft:=DefaultMargin;
    MarginRight:=DefaultMargin;
    MarginTop:=DefaultMargin;
    MarginBottom:=DefaultMargin;

    PrepareAxis(Axes.Left);
    PrepareAxis(Axes.Top);
    PrepareAxis(Axes.Right);
    PrepareAxis(Axes.Bottom);

    with Axes do
    begin
      Bottom.Visible:=False;
      Top.Visible:=False;
    end;

    Legend.Hide;
    //Walls.Visible:=False;

    tmp:=TPaletteSeries.Create(Self);
    tmp.CalcVisiblePoints:=False;
    tmp.ITool:=Self;
    tmp.VertAxis:=aBothVertAxis;
    tmp.HorizAxis:=aBothHorizAxis;
    AddSeries(tmp);
  end;

  FPositionUnits:=muPixels;
  FTop:=10;
  FLeft:=10;
  FWidth:=100;
  FHeight:=200;

  FVertical:=True;
end;

Destructor TLegendPaletteTool.Destroy;
begin
  FreeAndNil(FChart);
  inherited;
end;

procedure TLegendPaletteTool.Assign(Source: TPersistent);
begin
  if Source is TLegendPaletteTool then
  with TLegendPaletteTool(Source) do
  begin
    Self.FLeft:=FLeft;
    Self.FTop:=FTop;
    Self.FWidth:=FWidth;
    Self.FHeight:=FHeight;
    Self.FChart.Assign(FChart);
    Self.FSmooth:=FSmooth;
    Self.Inverted:=Inverted;
    Self.Vertical:=FVertical;
  end;

  inherited;
end;

type
  TCustom3DAccess=class(TCustom3DPaletteSeries);
  TLevelAccess=class(TContourLevel);

procedure TLegendPaletteTool.ChartEvent(AEvent: TChartToolEvent);
var tmp      : TCustom3DPaletteSeries;
    t        : Integer;
    tmpValue : TChartValue;
    tmpColor : TColor;
    tmpR     : TRect;
begin
  inherited;

  if AEvent=cteAfterDraw then
  begin
    FChart[0].BeginUpdate;

    FChart[0].Clear;

    if Assigned(Series) then
    begin
      if Series is TCustom3DPaletteSeries then
      begin
        tmp:=TCustom3DPaletteSeries(Series);

        // Special case. Pending to avoid checking for TContourSeries.
        if Series is TContourSeries then
          for t:=0 to TContourSeries(tmp).Levels.Count-1 do
          begin
            tmpValue:=TContourSeries(tmp).Levels[t].UpToValue;
            tmpColor:=TLevelAccess(TContourSeries(tmp).Levels[t]).InternalColor;

            with FChart[0] do
            if Self.Vertical then
               AddXY(t,tmpValue,'',tmpColor)
            else
               AddXY(tmpValue,t,'',tmpColor);
          end
        else
        for t:=0 to Length(tmp.Palette)-1 do
        begin
          tmpValue:=tmp.Palette[t].UpToValue;

          if tmp.UsePalette then
            tmpColor:=tmp.Palette[t].Color
          else
            tmpColor:=TCustom3DAccess(tmp).GetValueColorValue(tmpValue);

          with FChart[0] do
          if Self.Vertical then
             AddXY(t,tmpValue,'',tmpColor)
          else
             AddXY(tmpValue,t,'',tmpColor);
        end;
      end
      else
      if Series is TPolarGridSeries then
         for t:=0 to Length(TPolarGridSeries(Series).Palette.Palette)-1 do
         begin
           tmpValue:=TPolarGridSeries(Series).Palette.Palette[t].UpToValue;
           tmpColor:=TPolarGridSeries(Series).GetCellColor(tmpValue);

           with FChart[0] do
           if Self.Vertical then
              AddXY(t,tmpValue,'',tmpColor)
           else
              AddXY(tmpValue,t,'',tmpColor);
         end;
    end;

    ParentChart.Canvas.UnClipRectangle;
    FChart[0].Pen.Assign(Pen);

    if FPositionUnits=muPercent then
    begin
      tmpR.Left:=Round(FLeft*ParentChart.Width*0.01);
      tmpR.Top:=Round(FTop*ParentChart.Width*0.01);
    end
    else
    begin
      tmpR.Left:=FLeft;
      tmpR.Top:=FTop;
    end;

    tmpR.Right:=tmpR.Left+FWidth;
    tmpR.Bottom:=tmpR.Top+FHeight;

    FChart[0].EndUpdate;

    FChart.Draw(ParentChart.Canvas.ReferenceCanvas,tmpR);
  end;
end;

class function TLegendPaletteTool.Description: String;
begin
  result:=TeeMsg_LegendPalette;
end;

class function TLegendPaletteTool.LongDescription: String;
begin
  result:=TeeMsg_LegendPaletteDesc;
end;

class function TLegendPaletteTool.GetEditorClass: String;
begin
  result:='TLegendPaletteEditor'; // Do not localize
end;

type
  TChartAccess=class(TCustomChart);
  TCanvasAccess=class(TTeeCanvas3D);

procedure TLegendPaletteTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmpR : TRect;
begin
  inherited;

  case AEvent of
    cmeMove: TChartAccess(FChart).MouseMove(Shift,X,Y);
    cmeDown: TChartAccess(FChart).MouseDown(Button,Shift,X,Y);
    cmeUp  : TChartAccess(FChart).MouseUp(Button,Shift,X,Y);
  end;

  tmpR:=TeeRect(Left,Top,Left+Width,Top+Height);

  if PtInRect(tmpR,TeePoint(X,Y)) then
     ParentChart.CancelMouse:=True;
end;

procedure TLegendPaletteTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if Assigned(FChart) then
     TPaletteChart(FChart).IParent:=ParentChart;
end;

procedure TLegendPaletteTool.SetSmooth(const Value: Boolean);
begin
  SetBooleanProperty(FSmooth,Value);
end;

procedure TLegendPaletteTool.SetVertical(const Value: Boolean);
var tmp : Integer;
begin
  if FVertical<>Value then
  begin
    FVertical:=Value;

    tmp:=Width;
    Width:=Height;
    Height:=tmp;

    with FChart.Axes do
    begin
      Bottom.Visible:=not Vertical;
      Top.Visible:=not Vertical;
      Left.Visible:=Vertical;
      Right.Visible:=Vertical;
    end;
  end;
end;

function TLegendPaletteTool.GetInverted: Boolean;
begin
  result:=FChart.Axes.Left.Inverted;
end;

procedure TLegendPaletteTool.SetInverted(const Value: Boolean);
begin
  with FChart.Axes do
  begin
    Left.Inverted:=Value;
    Right.Inverted:=Value;
    Top.Inverted:=Value;
    Bottom.Inverted:=Value;
  end;
end;

procedure TLegendPaletteTool.SetPositionUnits(const Value: TTeeUnits);
begin
  if FPositionUnits<>Value then
  begin
    FPositionUnits:=Value;
    Repaint;
  end;
end;

procedure TLegendPaletteTool.SetHeight(const Value: Integer);
begin
  SetIntegerProperty(FHeight,Value);
end;

procedure TLegendPaletteTool.SetLeft(const Value: Integer);
begin
  SetIntegerProperty(FLeft,Value);
end;

procedure TLegendPaletteTool.SetTop(const Value: Integer);
begin
  SetIntegerProperty(FTop,Value);
end;

procedure TLegendPaletteTool.SetWidth(const Value: Integer);
begin
  SetIntegerProperty(FWidth,Value);
end;

procedure TLegendPaletteTool.SetSeries(const Value: TChartSeries);
begin
  inherited;
  Repaint;
end;

function TLegendPaletteTool.GetTransp: Boolean;
begin
  result:=Chart.Color=clNone
end;

procedure TLegendPaletteTool.SetTransp(const Value: Boolean);
begin
  if GetTransp<>Value then
     if Value then
        Chart.Color:=clNone
     else
        Chart.Color:=DefaultPanelColor;
end;

function TLegendPaletteTool.GetBorder: TChartHiddenPen;
begin
  result:=Chart.Border;
end;

procedure TLegendPaletteTool.SetBorder(const Value: TChartHiddenPen);
begin
  Chart.Border:=Value;
end;

function TLegendPaletteTool.GetAxis: TLegendPaletteAxis;
begin
  case Chart[0].VertAxis of
    aLeftAxis  : result:=laDefault;
    aRightAxis : result:=laOther;
  else
    result:=laBoth;
  end;
end;

procedure TLegendPaletteTool.SetAxis(const Value: TLegendPaletteAxis);
begin
  with Chart[0] do
  case Value of
    laDefault : begin
                  VertAxis:=aLeftAxis;
                  HorizAxis:=aBottomAxis;
                end;
      laOther : begin
                  VertAxis:=aRightAxis;
                  HorizAxis:=aTopAxis;
                end;
  else
    begin
      VertAxis:=aBothVertAxis;
      HorizAxis:=aBothHorizAxis;
    end;
  end;

  Repaint;
end;

function TLegendPaletteTool.GetColor: TColor;
begin
  result:=FChart.Color;
end;

procedure TLegendPaletteTool.SetColor(const Value: TColor);
begin
  FChart.Color:=Value;
end;

function TLegendPaletteTool.GetGradient: TChartGradient;
begin
  result:=FChart.Gradient;
end;

procedure TLegendPaletteTool.SetGradient(const Value: TChartGradient);
begin
  FChart.Gradient:=Value;
end;

function TLegendPaletteTool.GetShadow: TTeeShadow;
begin
  result:=FChart.Shadow;
end;

procedure TLegendPaletteTool.SetShadow(const Value: TTeeShadow);
begin
  FChart.Shadow:=Value;
end;

{ TPaletteSeries }

procedure TPaletteSeries.DrawValue(ValueIndex: Integer);
var R : TRect;
begin

  if ITool.Vertical then
  begin
    R.Left:=GetHorizAxis.IStartPos;

    if VertAxis<>aRightAxis then
       Inc(R.Left,ParentChart.Axes.Left.Axis.Width);

    R.Right:=GetHorizAxis.IEndPos;
    R.Top:=CalcYPos(ValueIndex);

    if ValueIndex=Count-1 then
       if GetVertAxis.Inverted then Dec(R.Bottom)
                               else Inc(R.Top);

    if ValueIndex>0 then
      R.Bottom:=CalcYPos(ValueIndex-1)
    else
    if GetVertAxis.Inverted then
      R.Bottom:=GetVertAxis.IStartPos
    else
      R.Bottom:=GetVertAxis.IEndPos;

    if ValueIndex=1 then
       if GetVertAxis.Inverted then
          Inc(R.Bottom);
  end
  else
  begin
    R.Top:=GetVertAxis.IStartPos;

    if HorizAxis<>aBottomAxis then
       Inc(R.Top,ParentChart.Axes.Bottom.Axis.Width);

    R.Bottom:=GetVertAxis.IEndPos;
    R.Left:=CalcXPos(ValueIndex);

    if ValueIndex>0 then
      R.Right:=CalcXPos(ValueIndex-1)
    else
    if GetHorizAxis.Inverted then
      R.Right:=GetHorizAxis.IEndPos
    else
      R.Right:=GetHorizAxis.IStartPos;
  end;

  with ParentChart.Canvas do
  begin
    Pen.Style:=psClear;
    Brush.Color:=ValueColor[ValueIndex];

    if ITool.Smooth then
    begin
      IGradient:=TTeeGradient.Create(nil);
      try
        if not ITool.Vertical then
           IGradient.Direction:=gdRightLeft;

        IGradient.EndColor:=ValueColor[ValueIndex];

        if ValueIndex>0 then
           IGradient.StartColor:=ValueColor[ValueIndex-1]
        else
           IGradient.StartColor:=IGradient.EndColor;

        IGradient.Draw(ParentChart.Canvas,R);
      finally
        IGradient.Free;
      end;
    end
    else
       FillRect(R);

    if Self.Pen.Visible then
    begin
      AssignVisiblePen(Self.Pen);

      if ITool.Vertical then
      begin
        DoHorizLine(R.Left,R.Right,R.Top);

        if ValueIndex=1 then
           DoHorizLine(R.Left,R.Right,R.Bottom);

        if VertAxis=aLeftAxis then
           DoVertLine(R.Right,R.Top,R.Bottom)
        else
        if VertAxis=aRightAxis then
           DoVertLine(R.Left,R.Top,R.Bottom);
      end
      else
      begin
        DoVertLine(R.Right,R.Top,R.Bottom);

        if ValueIndex=1 then
           DoVertLine(R.Left,R.Top,R.Bottom);

        if HorizAxis=aTopAxis then
           DoHorizLine(R.Left,R.Right,R.Top)
        else
        if HorizAxis=aBottomAxis then
           DoHorizLine(R.Left,R.Right,R.Bottom);
      end;
    end;
  end;
end;

procedure TLegendPaletteEditor.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Tool) then
  with LegendTool do
  begin
    FillSeries(CBSeries,TCustom3DPaletteSeries,Series);
    FillSeries(CBSeries,TPolarGridSeries,Series,False);

    ButtonPen1.LinkPen(Pen);
    RGAxis.ItemIndex:=Ord(Axis);
    CBSmooth.Checked:=Smooth;

    CBVertical.Checked:=Vertical;
    CBTransp.Checked:=Chart.Color=clNone;
    CBInverted.Checked:=Inverted;

    if PositionUnits=muPercent then CBUnits.ItemIndex:=0
                               else CBUnits.ItemIndex:=1;

    UDLeft.Position:=Left;
    ECustLeft.Text:=IntToStr(Left);
    UDTop.Position:=Top;
    ECustTop.Text:=IntToStr(Top);

    UDWidth.Position:=Width;
    ECustWidth.Text:=IntToStr(Width);
    UDHeight.Position:=Height;
    ECustHeight.Text:=IntToStr(Height);

    BBorder.LinkPen(Border);
  end;

  CreatingForm:=False;
end;

procedure TLegendPaletteEditor.RGAxisClick(Sender: TObject);
begin
  if not CreatingForm then
     LegendTool.Axis:=TLegendPaletteAxis(RGAxis.ItemIndex);
end;

procedure TLegendPaletteEditor.CBTranspClick(Sender: TObject);
begin
  LegendTool.Transparent:=CBTransp.Checked;
end;

procedure TLegendPaletteEditor.CBSmoothClick(Sender: TObject);
begin
  LegendTool.Smooth:=CBSmooth.Checked;
end;

procedure TLegendPaletteEditor.CBVerticalClick(Sender: TObject);
begin
  LegendTool.Vertical:=CBVertical.Checked;
end;

procedure TLegendPaletteEditor.CBInvertedClick(Sender: TObject);
begin
  LegendTool.Inverted:=CBInverted.Checked;
end;

procedure TLegendPaletteEditor.ECustLeftChange(Sender: TObject);
begin
  if Showing then
     LegendTool.Left:=UDLeft.Position;
end;

procedure TLegendPaletteEditor.ECustTopChange(Sender: TObject);
begin
  if Showing then
     LegendTool.Top:=UDTop.Position
end;

procedure TLegendPaletteEditor.CBUnitsChange(Sender: TObject);
begin
  if CBUnits.ItemIndex=0 then
  begin
    LegendTool.PositionUnits:=muPercent;

    if UDLeft.Position>100 then UDLeft.Position:=100;
    if UDTop.Position>100 then UDTop.Position:=100;
  end
  else
    LegendTool.PositionUnits:=muPixels;
end;

procedure TLegendPaletteEditor.ECustWidthChange(Sender: TObject);
begin
  if Showing then
     LegendTool.Width:=UDWidth.Position
end;

procedure TLegendPaletteEditor.ECustHeightChange(Sender: TObject);
begin
  if Showing then
     LegendTool.Height:=UDHeight.Position
end;

function TLegendPaletteEditor.LegendTool:TLegendPaletteTool;
begin
  result:=TLegendPaletteTool(Tool);
end;

procedure TLegendPaletteEditor.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabAxes then
  begin
    if TabAxes.ControlCount=0 then
    begin
      IAxes:=TFormTeeAxis.CreateAxis(nil,LegendTool.Chart.LeftAxis);
      AddFormTo(IAxes,TabAxes);
      TeeTranslateControl(IAxes);
    end;
  end
  else
  if PageControl1.ActivePage=TabPanel then
  begin
    if TabPanel.ControlCount=0 then
       IPanel:=TFormTeePanel.InsertAt(nil,TabPanel,LegendTool.Chart);
  end;
end;

procedure TLegendPaletteEditor.FormCreate(Sender: TObject);
begin
  inherited;
  CreatingForm:=True;
end;

initialization
  RegisterClass(TLegendPaletteEditor);
  RegisterTeeTools([TLegendPaletteTool]);
finalization
  UnRegisterTeeTools([TLegendPaletteTool]);
end.
