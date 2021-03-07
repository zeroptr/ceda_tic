{******************************************}
{ TSeriesTool Editor Dialog                }
{ Copyright (c) 1999-2009 by David Berneda }
{******************************************}
unit TeeToolSeriesEdit;
{$I TeeDefs.inc}

interface

uses SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     TeeProcs, TeEngine, TeCanvas;

type
  TSeriesToolEditor = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    CBSeries: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure CBSeriesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    Tool : TTeeCustomToolSeries;

    Procedure FillSeries(const ACombo:TComboBox; AClass:TChartSeriesClass;
                         ASeries:TChartSeries; ClearCombo:Boolean=True);
    procedure FillSeriesCombo(ACombo:TComboBox; ASeries:TChartSeries; AChart:TCustomAxisPanel);
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
  TeeConst, TeeProCo;

Procedure TSeriesToolEditor.FillSeries(const ACombo:TComboBox;
                                       AClass:TChartSeriesClass;
                                       ASeries:TChartSeries;
                                       ClearCombo:Boolean=True);
var t : Integer;
begin
  if ClearCombo then
     ACombo.Clear;

  if Assigned(Tool.ParentChart) then
  With Tool.ParentChart do
  for t:=0 to SeriesCount-1 do
  if Series[t] is AClass then
      ACombo.Items.AddObject(SeriesTitleOrName(Series[t]),Series[t]);

  with ACombo do
  begin
    Enabled:=Items.Count>0;
    ItemIndex:=Items.IndexOfObject(Tool.Series);
  end;
end;

procedure TSeriesToolEditor.FillSeriesCombo(ACombo:TComboBox; ASeries:TChartSeries; AChart:TCustomAxisPanel);
begin
  with ACombo do
  begin
    if Assigned(AChart) then
    begin
      FillSeriesItems(Items,AChart.SeriesList);
      Enabled:=AChart.SeriesCount>0;
    end;

    Items.InsertObject(0,TeeMsg_None,nil);

    ItemIndex:=Items.IndexOfObject(ASeries);
  end;
end;

procedure TSeriesToolEditor.FormShow(Sender: TObject);
begin
  Tool:=TTeeCustomToolSeries({$IFDEF CLR}TObject{$ENDIF}(Tag));

  if Assigned(Tool) then
     FillSeriesCombo(CBSeries,Tool.Series,Tool.ParentChart)
end;

procedure TSeriesToolEditor.CBSeriesChange(Sender: TObject);
begin
  Tool.Series:=TChartSeries(CBSeries.SelectedObject);
end;

procedure TSeriesToolEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

initialization
  RegisterClass(TSeriesToolEditor);
end.
