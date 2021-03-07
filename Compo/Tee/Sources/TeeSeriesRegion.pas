{**********************************************}
{   TSeriesRegionTool                          }
{   Copyright (c) 2006-2009 by Marjan Slatinek }
{**********************************************}
unit TeeSeriesRegion;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  TeeProcs, TeEngine, TeeToolSeriesEdit, TeCanvas, Chart, TeeEdiGrad, TeePenDlg;

type
  (*:Series region tool - it colors bounded area under the (series) curve.*)
  TSeriesRegionTool=class(TTeeCustomToolSeries)
  private
    FAutoBounds: Boolean;
    FDrawBehindSeries: Boolean;
    FGradient: TTeeGradient;
    FLowerBound: Double;
    FOrigin: Double;
    FTransparency: TTeeTransparency;
    FUpperBound: Double;
    FUseOrigin: Boolean;

    ISeriesDrawn : Boolean;

    function GetColor:TColor;
    function IntersectionPoint(const Value: double; out y: double): Integer;
    procedure SetAutoBounds(const Value: Boolean);
    procedure SetColor(const Value: TColor);
    procedure SetDrawBehindSeries(const Value: Boolean);
    procedure SetGradient(const Value: TTeeGradient);
    procedure SetLowerBound(const Value: double);
    procedure SetOrigin(const Value: double);
    procedure SetTransparency(const Value: TTeeTransparency);
    procedure SetUpperBound(const Value: double);
    procedure SetUseOrigin(const Value: boolean);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    procedure DrawRegion; virtual;
    class Function GetEditorClass:String; override;
    Procedure SeriesEvent(AEvent:TChartToolEvent); override;
    procedure SetSeries(const Value: TChartSeries); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property AutoBounds:Boolean read FAutoBounds write SetAutoBounds default True;

    (*:If true, draw region behind series. If false, draw region over series.*)
    property DrawBehindSeries:Boolean read FDrawBehindSeries write
                                              SetDrawBehindSeries default True;

    property Gradient:TTeeGradient read FGradient write SetGradient;

    (*:Region left (series not mandatory values lower) bound.*)
    property LowerBound: double read FLowerBound write SetLowerBound;

    (*:Region bottom or upper limit. Used only if UseOrigin is true*)
    property Origin: double read FOrigin write SetOrigin;

    (*:Region right (series not mandatory values upper) bound.*)
    property UpperBound: double read FUpperBound write SetUpperBound;

    (*:If true, region bottom or upper limit is defined by Origin*)
    property UseOrigin: boolean read FUseOrigin write SetUseOrigin default True;

    property Active;
    property Brush;
    property Color:TColor read GetColor write SetColor default clWhite;
    property Pen;
    property Series;
    property Transparency:TTeeTransparency read FTransparency
                                           write SetTransparency default 0;
  end;

  TSeriesRegionEditor = class(TSeriesToolEditor)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ButtonPen1: TButtonPen;
    TabGradient: TTabSheet;
    ButtonColor1: TButtonColor;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    ELower: TEdit;
    EUpper: TEdit;
    GroupBox2: TGroupBox;
    CBUseOrigin: TCheckBox;
    Label2: TLabel;
    EOrigin: TEdit;
    CBAutoBounds: TCheckBox;
    CBBehind: TCheckBox;
    Label5: TLabel;
    ETransp: TEdit;
    UDTransp: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure CBBehindClick(Sender: TObject);
    procedure CBUseOriginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ELowerChange(Sender: TObject);
    procedure EUpperChange(Sender: TObject);
    procedure EOriginChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBAutoBoundsClick(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Pulic declarations }
    CreatingForm: Boolean;
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
  Math, TeeBrushDlg, TeeProCo;

{ TSeriesRegionTool }

Constructor TSeriesRegionTool.Create(AOwner: TComponent);
begin
  inherited;
  FAutoBounds:=True;
  FDrawBehindSeries:=True;
  FUseOrigin:=True;
  Brush.BackColor:=clWhite;
  FGradient:=TTeeGradient.Create(CanvasChanged);
end;

Destructor TSeriesRegionTool.Destroy;
begin
  FGradient.Free;
  inherited;
end;

procedure TSeriesRegionTool.Assign(Source: TPersistent);
begin
  if Source is TSeriesRegionTool then
  with TSeriesRegionTool(Source) do
  begin
    Self.FAutoBounds:=FAutoBounds;
    Self.FDrawBehindSeries := DrawBehindSeries;
    Self.Gradient := Gradient;
    Self.FLowerBound := LowerBound;
    Self.FOrigin := Origin;
    Self.FUseOrigin := UseOrigin;
    Self.FTransparency := Transparency;
    Self.FUpperBound := UpperBound;
  end;

  inherited;
end;

procedure TSeriesRegionTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if AEvent=cteBeforeDrawSeries then
     iSeriesDrawn := False;
end;

class function TSeriesRegionTool.Description: String;
begin
  Result := TeeMsg_SeriesRegion;
end;

class Function TSeriesRegionTool.LongDescription:String;
begin
  Result := TeeMsg_SeriesRegionDesc;
end;

procedure TSeriesRegionTool.DrawRegion;
var lb,ub    : double;
    yl,yu    : double;
    pts      : TPointArray;
    plen,
    i,
    first,
    last     : Integer;
    tmpR     : TRect;
    tmpBlend : TTeeBlend;
begin
  if Active and Visible and Assigned(ParentChart) and Assigned(Series) then
  begin
    lb:=Series.NotMandatoryValueList.MinValue;
    ub:=Series.NotMandatoryValueList.MaxValue;

    if not FAutoBounds then
    begin
      lb:=Max(lb,FLowerBound);
      ub:=Min(ub,FUpperBound);
    end;

    // plot only if it makes sense
    if (ub>Series.NotMandatoryValueList.MinValue) and
       (lb<Series.NotMandatoryValueList.MaxValue) then
    begin
      first:=IntersectionPoint(lb,yl);
      last:=IntersectionPoint(ub,yu);

      if last<first then
         SwapInteger(last,first);

      plen:= last - first + 1;

      SetLength(pts,plen+4); // 4 extra points
      try
        for i := 0 to plen-1 do
        begin
          pts[i].X := Series.CalcXPos(i+first);
          pts[i].Y := Series.CalcYPos(i+first);
        end;

        // upper bound intersect point
        pts[plen].X := Series.CalcXPosValue(ub);
        pts[plen].Y := Series.CalcYPosValue(yu);

        // upper bound origin point
        pts[plen+1].X := pts[plen].X;

        if FUseOrigin then
           pts[plen+1].Y := Series.CalcYPosValue(FOrigin)
        else
           pts[plen+1].Y := Series.GetVertAxis.IEndPos;

        // lower bound origin point
        pts[plen+2].X := Series.CalcXPosValue(lb);
        pts[plen+2].Y := pts[plen+1].Y;

        // lower bound intersect point
        pts[plen+3].X := pts[plen+2].X;
        pts[plen+3].Y := Series.CalcYPosValue(yl);

        With ParentChart,Canvas do
        begin
          AssignBrush(Self.Brush);
          AssignVisiblePen(Self.Pen);

          ClipRectangle(RectFromRectZ(ChartRect, Self.Series.StartZ));

          if Transparency<>0 then
          begin
            if View3D then
               tmpR:=RectFromRectZ(PolygonBounds(pts),Self.Series.StartZ)
            else
               tmpR:=PolygonBounds(pts);

            tmpBlend:=ParentChart.Canvas.BeginBlending(tmpR,Transparency);
          end
          else
            tmpBlend:=nil;

          if Self.Gradient.Visible and CanClip and View3DOptions.Orthogonal then
          begin
            Self.Gradient.Draw(Canvas,pts,Self.Series.StartZ,View3D);
            Brush.Style:=bsClear;
          end;

          if View3D then
             PolygonWithZ(pts,Self.Series.StartZ)
          else
             Polygon(pts);

          if Assigned(tmpBlend) then
             ParentChart.Canvas.EndBlending(tmpBlend);

          UnClipRectangle;
        end;
      finally
        pts := nil;
      end;
    end;
  end;
end;

class function TSeriesRegionTool.GetEditorClass: String;
begin
  result:='TSeriesRegionEditor';
end;

function TSeriesRegionTool.GetColor:TColor;
begin
  result:=Brush.BackColor;
end;

Function TSeriesRegionTool.IntersectionPoint(const Value: double; out y: double): Integer;
var i: Integer;
    k: double;
begin
  i := 0;
  y := Series.MandatoryValueList[i];

  while (Value>Series.NotMandatoryValueList[i]) and (i<Series.Count) do
        Inc(i);

  // We have two choices:
  // #1: value is exactly at point coordinate
  // #2: value is between two points - use linear interpolation to calculate y

  with Series do
  if Value=NotMandatoryValueList[i] then
     y := MandatoryValueList[i]
  else
  if (i>0) and (i<Series.Count) then
  begin
    k := (MandatoryValueList[i]-MandatoryValueList[i-1]) /
         (NotMandatoryValueList[i]-NotMandatoryValueList[i-1]);

    y := MandatoryValueList[i-1] + k*(Value-NotMandatoryValueList[i-1]);
  end;

  Result := i; // return point index
end;

procedure TSeriesRegionTool.SetColor(const Value: TColor);
begin
  Brush.BackColor:=Value;
end;

procedure TSeriesRegionTool.SetDrawBehindSeries(const Value: Boolean);
begin
  SetBooleanProperty(FDrawBehindSeries,Value);
end;

procedure TSeriesRegionTool.SetGradient(const Value: TTeeGradient);
begin
  FGradient.Assign(Value);
end;

procedure TSeriesRegionTool.SetLowerBound(const Value: double);
begin
  SetDoubleProperty(FLowerBound,Value);
end;

procedure TSeriesRegionTool.SetOrigin(const Value: double);
begin
  SetDoubleProperty(FOrigin,Value);
end;

procedure TSeriesRegionTool.SetSeries(const Value: TChartSeries);
begin
  inherited;
  Repaint;
end;

procedure TSeriesRegionTool.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TSeriesRegionTool.SetUpperBound(const Value: double);
begin
  SetDoubleProperty(FUpperBound,Value);
end;

procedure TSeriesRegionTool.SetUseOrigin(const Value: boolean);
begin
  SetBooleanProperty(FUseOrigin,Value);
end;

procedure TSeriesRegionEditor.CBUseOriginClick(Sender: TObject);
begin
  if not CreatingForm then
     TSeriesRegionTool(Tool).UseOrigin := CBUseOrigin.Checked;
end;

procedure TSeriesRegionEditor.ELowerChange(Sender: TObject);
begin
  if not CreatingForm then
  with TSeriesRegionTool(Tool) do
       LowerBound:=StrToFloatDef(ELower.Text,LowerBound);
end;

procedure TSeriesRegionEditor.EUpperChange(Sender: TObject);
begin
  if not CreatingForm then
  with TSeriesRegionTool(Tool) do
       UpperBound:=StrToFloatDef(EUpper.Text,UpperBound);
end;

procedure TSeriesRegionEditor.FormCreate(Sender: TObject);
begin
  CreatingForm := True;
  inherited;
end;

procedure TSeriesRegionEditor.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Tool) then
  with TSeriesRegionTool(Tool) do
  begin
    EOrigin.Text := FloatToStr(Origin);
    ButtonPen1.LinkPen(Pen);
    CBUseOrigin.Checked := UseOrigin;
    CBBehind.Checked := DrawBehindSeries;
    CBAutoBounds.Checked:=AutoBounds;
    UDTransp.Position:=Transparency;

    ELower.Text := FloatToStr(LowerBound);
    EUpper.Text := FloatToStr(UpperBound);
    
    ELower.Enabled:=not CBAutoBounds.Checked;
    EUpper.Enabled:=not CBAutoBounds.Checked;

    AddFormTo(TTeeGradientEditor.CreateCustom(Self,Gradient),TabGradient);
    ButtonColor1.LinkProperty(Tool,'Color');
  end;

  CreatingForm := False;
end;

procedure TSeriesRegionEditor.CBBehindClick(Sender: TObject);
begin
  TSeriesRegionTool(Tool).DrawBehindSeries := CBBehind.Checked;
end;

procedure TSeriesRegionEditor.EOriginChange(Sender: TObject);
begin
  if not CreatingForm then
  with TSeriesRegionTool(Tool) do
       Origin:=StrToFloatDef(EOrigin.Text,Origin);
end;

procedure TSeriesRegionEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Tool.Brush);
end;

procedure TSeriesRegionEditor.CBAutoBoundsClick(Sender: TObject);
begin
  if not CreatingForm then
  begin
    TSeriesRegionTool(Tool).AutoBounds:=CBAutoBounds.Checked;

    ELower.Enabled:=not CBAutoBounds.Checked;
    EUpper.Enabled:=not CBAutoBounds.Checked;
  end;
end;

procedure TSeriesRegionTool.SetAutoBounds(const Value: Boolean);
begin
  SetBooleanProperty(FAutoBounds,Value);
end;

procedure TSeriesRegionEditor.ETranspChange(Sender: TObject);
begin
  if not CreatingForm then
     TSeriesRegionTool(Tool).Transparency:=UDTransp.Position;
end;

procedure TSeriesRegionTool.SeriesEvent(AEvent: TChartToolEvent);
begin
  if Assigned(Series) then
     if ((AEvent=cteBeforeDrawSeries) and DrawBehindSeries) or
        ((AEvent=cteAfterDrawSeries) and (not DrawBehindSeries)) then
            DrawRegion;
end;

initialization
  RegisterTeeTools([TSeriesRegionTool]);
  RegisterClass(TSeriesRegionEditor);
finalization
  UnRegisterTeeTools([TSeriesRegionTool]);
end.
