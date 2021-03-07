{********************************************}
{   TSeriesBandTool and Editor Dialog        }
{   Copyright (c) 2003-2009 by David Berneda }
{   and Martin Kaul (mkaul@leuze.de)         }
{********************************************}
unit TeeSeriesBandTool;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     {$ENDIF}
     {$IFDEF LINUX}
     Types,
     {$ENDIF}
     TeeToolSeriesEdit, TeCanvas, TeePenDlg, TeeTools, TeEngine,
     TeeProcs, Chart, TeeConst, TeeProCo, TeeEdiGrad;

type
  // Series-Band tool, use it to display a band between two (line) series
  // created 2003-12-14 by mkaul@leuze.de
  TSeriesBandTool=class(TTeeCustomToolSeries)
  private
    FDrawBehind   : Boolean;
    FGradient     : TTeeGradient;
    FSeries2      : TChartSeries;
    FTransparency : TTeeTransparency;

    ISerie1Drawed : Boolean;
    ISerie2Drawed : Boolean;
    FBoundValue: double;

    procedure AfterSeriesDraw(Sender: TObject);
    procedure BeforeSeriesDraw(Sender: TObject);
    procedure RemoveEvents(ASeries:TChartSeries);
    procedure SetDrawBehind(const Value: Boolean);
    procedure SetEvents(ASeries:TChartSeries);
    procedure SetGradient(const Value: TTeeGradient);
    procedure SetTransparency(const Value: TTeeTransparency);
    procedure SetBoundValue(const Value: double);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetSeries(const Value: TChartSeries); override;
    procedure SetSeries2(const Value: TChartSeries); virtual;
    procedure DrawBandTool; virtual;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property BoundValue: double read FBoundValue write SetBoundValue;
    property Active;
    property Brush;
    property DrawBehindSeries:Boolean read FDrawBehind
                                      write SetDrawBehind default True;
    property Gradient:TTeeGradient read FGradient write SetGradient;
    property Pen;
    property Series;
    property Series2:TChartSeries read FSeries2 write SetSeries2;
    property Transparency:TTeeTransparency read FTransparency
                                           write SetTransparency default 0;
  end;

  TSeriesBandToolEdit = class(TSeriesToolEditor)
    Button1: TButton;
    CBDrawBehindSeries: TCheckBox;
    BPen: TButtonPen;
    Label2: TLabel;
    CBSeries2: TComboFlat;
    BGradient: TButtonGradient;
    Label4: TLabel;
    ETransp: TEdit;
    UDTransp: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBDrawBehindSeriesClick(Sender: TObject);
    procedure CBSeries2Change(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
  private
    { Private declarations }
    SeriesBand : TSeriesBandTool;
  protected
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

Uses
  Math, TeeBrushDlg;

procedure TSeriesBandToolEdit.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,SeriesBand.Brush);
end;

procedure TSeriesBandToolEdit.FormShow(Sender: TObject);
begin
  inherited;

  SeriesBand:=TSeriesBandTool(Tag);

  if Assigned(SeriesBand) then
  With SeriesBand do
  begin
    FillSeriesCombo(CBSeries2,Series2,ParentChart);
    BPen.LinkPen(Pen);
    CBDrawBehindSeries.Checked:=DrawBehindSeries;
    UDTransp.Position:=Transparency;
    BGradient.Gradient:=Gradient;
  end;
end;

procedure TSeriesBandToolEdit.CBDrawBehindSeriesClick(Sender: TObject);
begin
  SeriesBand.DrawBehindSeries:=CBDrawBehindSeries.Checked;
end;

procedure TSeriesBandToolEdit.CBSeries2Change(Sender: TObject);
begin
  SeriesBand.Series2:=TChartSeries(CBSeries2.SelectedObject);
end;

// Created 2003-12-14 by mkaul@leuze.de.
// Improved by Steema.

{ TSeriesBandTool }
Constructor TSeriesBandTool.Create(AOwner: TComponent);
begin
  inherited;
  FDrawBehind:=True;
  Brush.Color:=clWhite;
  Pen.Visible:=False;
  FGradient:=TTeeGradient.Create(CanvasChanged);
end;

procedure TSeriesBandTool.AfterSeriesDraw(Sender: TObject);
begin
  if not FDrawBehind then
  begin
    if Assigned(Series)  and (Sender=Series)  then ISerie1Drawed:=True;
    if Assigned(Series2) and (Sender=Series2) then ISerie2Drawed:=True;

    if ISerie1Drawed and (ISerie2Drawed or Not Assigned(Series2)) then
       DrawBandTool;
  end;
end;

procedure TSeriesBandTool.BeforeSeriesDraw(Sender: TObject);
begin
  if FDrawBehind then
  begin
    if Assigned(Series)  and (Sender=Series)  then ISerie1Drawed:=True;
    if Assigned(Series2) and (Sender=Series2) then ISerie2Drawed:=True;

    if Assigned(Series2) then
    begin
      if not (ISerie1Drawed and ISerie2Drawed) then DrawBandTool;
    end
    else DrawBandTool;
  end;
end;

procedure TSeriesBandTool.SetDrawBehind(const Value: Boolean);
begin
  SetBooleanProperty(FDrawBehind,Value);
end;

procedure TSeriesBandTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if AEvent=cteBeforeDrawSeries then
  begin
    ISerie1Drawed:=False;
    ISerie2Drawed:=False;
  end;
end;

class Function TSeriesBandTool.Description:String;
begin
  result:=TeeMsg_SeriesBandTool;
end;

procedure TSeriesBandTool.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if Operation=opRemove then
  begin
    if AComponent=Series then
       RemoveEvents(Series)
    else
    if AComponent=Series2 then
    begin
      RemoveEvents(Series2);
      Series2:=nil; // 8.02
    end;
  end;

  inherited;
end;

procedure TSeriesBandTool.RemoveEvents(ASeries:TChartSeries);
begin
  if Assigned(ASeries) then
  begin
    ASeries.AfterDrawValues:=nil;
    ASeries.BeforeDrawValues:=nil;
  end;
end;

procedure TSeriesBandTool.SetEvents(ASeries:TChartSeries);
begin
  if Assigned(ASeries) then
  begin
    ASeries.AfterDrawValues:=AfterSeriesDraw;
    ASeries.BeforeDrawValues:=BeforeSeriesDraw;
  end;
end;

procedure TSeriesBandTool.SetSeries(const Value: TChartSeries);
begin
  RemoveEvents(Series);
  inherited;
  SetEvents(Series);
  Repaint;
end;

procedure TSeriesBandTool.SetSeries2(const Value: TChartSeries);
begin
  if FSeries2<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FSeries2) then
       FSeries2.RemoveFreeNotification(Self);
    {$ENDIF}

    RemoveEvents(Series2);

    FSeries2:=Value;

    if Assigned(FSeries2) then
       FSeries2.FreeNotification(Self);

    SetEvents(Series2);

    Repaint;
  end;
end;

type
  TSeriesAccess=class(TChartSeries);

procedure TSeriesBandTool.DrawBandTool;
var
  tmpPoints : TPointArray;
  tmpZ      : Integer;

  procedure DrawPolygon;
  begin
    with ParentChart.Canvas do
    begin
      ClipRectangle( RectFromRectZ(ParentChart.ChartRect, tmpZ));
      AssignVisiblePen(Self.Pen);
      if ParentChart.View3D then PolygonWithZ(tmpPoints,tmpZ)
                            else Polygon(tmpPoints);
      UnClipRectangle;
    end;
  end;

var t      : Integer;
    i      : Integer;
    l1     : Integer;
    l2     : Integer;
    tmpR   : TRect;
    tmpBlend : TTeeBlend;
    tmpMax : Integer;
begin
  if Active and Assigned(ParentChart) and Assigned(Series) then
  begin
    TSeriesAccess(Series).CalcFirstLastVisibleIndex;
    if Assigned(Series2) then
       TSeriesAccess(Series2).CalcFirstLastVisibleIndex;

    if (Assigned(Series2) and
       (Series.FirstValueIndex<>-1) and (Series2.FirstValueIndex<>-1))
        or (Series.FirstValueIndex<>-1) then
    begin
      l1:=Series.LastValueIndex-Series.FirstValueIndex+1;

      // First point outside chart
      if Series.DrawBetweenPoints and (Series.FirstValueIndex>0) then
         Inc(l1);

      if Assigned(Series2) then
      begin
        l2:=Series2.LastValueIndex-Series2.FirstValueIndex+1;

        // First point outside chart
        if Series2.DrawBetweenPoints and (Series2.FirstValueIndex>0) then
           Inc(l2);
      end
      else
         l2:=2;

      SetLength(tmpPoints,l1+l2);

      if Assigned(tmpPoints) then
      try
        i:=0;

        if Series.FirstValueIndex<>-1 then
        begin
          tmpMax:=Math.Max(0,Series.FirstValueIndex-1);

          for t:=tmpMax to Series.LastValueIndex do
          begin
            tmpPoints[i].X:=Series.CalcXPos(t);
            tmpPoints[i].Y:=Series.CalcYPos(t);
            Inc(i);
          end;
        end;

        if Assigned(Series2) then
        begin
          if Series2.FirstValueIndex<>-1 then
          begin
            tmpMax:=Math.Max(0,Series2.FirstValueIndex-1);

            for t:=Series2.LastValueIndex downto tmpMax do
            begin
              tmpPoints[i].X:=Series2.CalcXPos(t);
              tmpPoints[i].Y:=Series2.CalcYPos(t);
              Inc(i);
            end;
          end
        end
        else
        begin // need only two points for bound right and left coordinate
          tmpPoints[i].X:=tmpPoints[i-1].X;
          tmpPoints[i].Y:=Series.CalcYPosValue(FBoundValue);
          tmpPoints[i+1].X:=tmpPoints[0].X;
          tmpPoints[i+1].Y:=tmpPoints[i].Y;
        end;

        if Assigned(Series2) then tmpZ:=Math.Max(Series.StartZ,Series2.StartZ)
                             else tmpZ:=Series.StartZ;

        if Transparency>0 then
        begin
          tmpR:=PolygonBounds(tmpPoints);
          tmpBlend:=ParentChart.Canvas.BeginBlending(
              ParentChart.Canvas.RectFromRectZ(tmpR,tmpZ),Transparency)
        end
        else
          tmpBlend:=nil;

        if Gradient.Visible and ParentChart.CanClip then
        begin
          if ParentChart.ClipPoints then
             ParentChart.Canvas.ClipCube(ParentChart.ChartRect,0,ParentChart.Width3D);

          Gradient.Draw(ParentChart.Canvas,tmpPoints,tmpZ,ParentChart.View3D);
          ParentChart.Canvas.Brush.Style:=bsClear;

          if Pen.Visible then
             DrawPolygon;
        end
        else
        begin
          ParentChart.Canvas.AssignBrush(Brush);
          DrawPolygon;
        end;

        if Transparency>0 then
           ParentChart.Canvas.EndBlending(tmpBlend);

      finally
        tmpPoints:=nil;
      end;
    end;
  end;
end;

class function TSeriesBandTool.GetEditorClass: String;
begin
  result:='TSeriesBandToolEdit';
end;

procedure TSeriesBandTool.SetGradient(const Value: TTeeGradient);
begin
  FGradient.Assign(Value);
end;

Destructor TSeriesBandTool.Destroy;
begin
  RemoveEvents(Series2);
  RemoveEvents(Series);
  FGradient.Free;
  inherited;
end;

procedure TSeriesBandTool.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TSeriesBandTool.SetBoundValue(const Value: double);
begin
  SetDoubleProperty(FBoundValue,Value);
end;

procedure TSeriesBandToolEdit.ETranspChange(Sender: TObject);
begin
  if Showing then
     SeriesBand.Transparency:=UDTransp.Position;
end;

class function TSeriesBandTool.LongDescription: String;
begin
  result:=TeeMsg_SeriesBandDesc;
end;

initialization
  RegisterTeeTools([TSeriesBandTool]);
  RegisterClass(TSeriesBandToolEdit);
finalization
  UnRegisterTeeTools([TSeriesBandTool]);
end.
