{******************************************}
{   TeeChart Pie Series Tool               }
{ Copyright (c) 2001-2009 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeePieTool;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
     {$ENDIF}
     {$IFDEF CLR}
     System.Threading,
     {$ENDIF}
     TeeTools, TeCanvas, TeEngine, Chart, TeePenDlg;

type
  TPieToolStyle=(ptFocus,ptExplode);

  TPieTool=class(TTeeCustomToolSeries)
  private
    FSpeed : Integer;
    FStyle : TPieToolStyle;

    ISlice : Integer;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    Procedure FocusSlice(ValueIndex:Integer; Focused:Boolean);
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
    property Slice:Integer read ISlice;
  published
    property Active;
    property Pen;
    property Series;
    property Style:TPieToolStyle read FStyle write FStyle default ptFocus;
  end;

  TPieToolEditor = class(TForm)
    Label1: TLabel;
    CBPieSeries: TComboFlat;
    RGStyle: TRadioGroup;
    BPen: TButtonPen;
    procedure FormShow(Sender: TObject);
    procedure CBPieSeriesChange(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
  private
    { Private declarations }
    Tool : TPieTool;
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
  TeeConst, TeeProcs, TeeProCo, Series;

{ TPieTool }
Constructor TPieTool.Create(AOwner: TComponent);
begin
  inherited;
  FStyle:=ptFocus;
  ISlice:=-1;
  FSpeed:=1;

  Pen.Width:=4;
  Pen.Style:=psSolid;
end;

type
  TPieSeriesAccess=class(TPieSeries);

Procedure TPieTool.FocusSlice(ValueIndex:Integer; Focused:Boolean);
const
  NumSteps = 30;

var t        : Integer;
    tmp      : Integer;
    tmpColor : TColor;
begin
  if Style=ptExplode then
  begin
    for t:=1 to NumSteps do
    begin
      if Focused then tmp:=t
                 else tmp:=NumSteps-t+1;

      TPieSeries(Series).ExplodedSlice[ValueIndex]:=Round(tmp*40/NumSteps);

      Sleep(FSpeed);

      ParentChart.Repaint;
    end;

    if not Focused then
    begin
      TPieSeries(Series).ExplodedSlice[ValueIndex]:=0;
      ParentChart.Repaint;
    end;
  end
  else
  begin
    if not Focused then
       ParentChart.Repaint
    else
    begin
      with Series.ParentChart.Canvas do
      begin
        Brush.Style:=bsClear;

        tmpColor:=Self.Pen.Color;
        if Series.ValueColor[ValueIndex]=Self.Pen.Color then
           if Self.Pen.Color=clBlack then tmpColor:=clWhite
                                     else tmpColor:=clBlack;

        AssignVisiblePenColor(Self.Pen,tmpColor);
      end;

      TPieSeriesAccess(Series).DrawPie(ValueIndex);
    end;
  end;
end;

procedure TPieTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp2 : Integer;

  procedure CalcClick;
  begin
    tmp2:=TPieSeries(Series).CalcClickedPie(X,Y);

    if tmp2=TeeNoPointClicked then // 7.07
       tmp2:=TPieSeries(Series).CalcClickedPie(X,Y,False);
  end;

begin
  if (AEvent=cmeMove) and Assigned(Series) and (Series is TPieSeries) then
  begin
    CalcClick;

    if ISlice<>tmp2 then
    begin
      if ISlice<>TeeNoPointClicked then
      begin
        FocusSlice(ISlice,False);
        CalcClick;
      end;

      ISlice:=tmp2;

      if ISlice<>TeeNoPointClicked then
         FocusSlice(ISlice,True);
    end;
  end;
end;

class function TPieTool.Description: String;
begin
  result:=TeeMsg_PieTool;
end;

class function TPieTool.GetEditorClass: String;
begin
  result:='TPieToolEditor';
end;

procedure TPieToolEditor.FormShow(Sender: TObject);

  Procedure FillPieSeries(AItems:TStrings);
  var t : Integer;
  begin
    if Assigned(Tool.ParentChart) then
    With Tool.ParentChart do
    for t:=0 to SeriesCount-1 do
    if Series[t] is TPieSeries then
        AItems.AddObject(SeriesTitleOrName(Series[t]),Series[t]);
  end;

begin
  Tool:=TPieTool({$IFDEF CLR}TObject{$ENDIF}(Tag));

  if Assigned(Tool) then
  begin
    FillPieSeries(CBPieSeries.Items);

    with CBPieSeries do
    begin
      Enabled:=Items.Count>0;
      ItemIndex:=Items.IndexOfObject(Tool.Series);
    end;

    RGStyle.ItemIndex:=Ord(Tool.Style);
    BPen.LinkPen(Tool.Pen);
  end;

  Label1.Caption:=TeeMsg_GalleryPie;
end;

procedure TPieToolEditor.CBPieSeriesChange(Sender: TObject);
begin
  Tool.Series:=TPieSeries(CBPieSeries.SelectedObject);
end;

procedure TPieToolEditor.RGStyleClick(Sender: TObject);
begin
  Tool.Style:=TPieToolStyle(RGStyle.ItemIndex);
end;

class function TPieTool.LongDescription: String;
begin
  result:=TeeMsg_PieToolDesc;
end;

initialization
  RegisterClass(TPieToolEditor);
  RegisterTeeTools([TPieTool]);
finalization
  UnRegisterTeeTools([TPieTool]);
end.
