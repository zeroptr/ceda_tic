{*******************************************}
{  TeeExtraLegend Tool                      }
{  Copyright (c) 2002-2009 by David Berneda }
{  All Rights Reserved                      }
{*******************************************}
unit TeeExtraLegendTool;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, Buttons,
     {$ENDIF}
     Chart, TeEngine, TeeTools, TeeToolSeriesEdit, TeCanvas, TeeEdiLege;

type
  TExtraLegendTool=class(TTeeCustomToolSeries)
  private
    FLegend: TChartLegend;
    function GetLegend:TChartLegend;
    procedure SetLegend(const Value: TChartLegend);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    class Function GetEditorClass:String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    procedure SetSeries(const Value: TChartSeries); override;
  public
    Destructor Destroy; override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Legend:TChartLegend read GetLegend write SetLegend;
    property Series;
  end;

  TExtraLegendEditor = class(TSeriesToolEditor)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    LegendEditor : TFormTeeLegend;
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
  TeeProCo, TeePenDlg;

{$IFNDEF CLR}
type
  TLegendAccess=class(TChartLegend);
{$ENDIF}

function TExtraLegendTool.GetLegend:TChartLegend;
begin
  if not Assigned(FLegend) then
  begin
    FLegend:=TChartLegend.Create(ParentChart);
    {$IFNDEF CLR}TLegendAccess{$ENDIF}(FLegend).DefaultCustom:=True;  // 7.02
    FLegend.CustomPosition:=True;
    FLegend.LegendStyle:=lsValues;
  end;

  result:=FLegend;
end;

Destructor TExtraLegendTool.Destroy;
begin
  FreeAndNil(FLegend);
  inherited;
end;

procedure TExtraLegendTool.SetLegend(const Value: TChartLegend);
begin
  FLegend.Assign(Value);
end;

procedure TExtraLegendTool.SetParentChart(const Value: TCustomAxisPanel);
var tmp : TNotifyEvent;
begin
  inherited;
  if Assigned(FLegend) then
  begin
    if Assigned(Value) then tmp:=Value.CanvasChanged
                       else tmp:=nil;
    FLegend.DividingLines.OnChange:=tmp;
    FLegend.ParentChart:=Value;
  end;
end;

procedure TExtraLegendTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;
  if (AEvent=cteAfterDraw) then
  begin
    if Assigned(ParentChart) and Assigned(Series) then
    begin
      Legend.Series:=Series; // call getter
      if Legend.Visible then Legend.DrawLegend;
    end;
  end;
end;

class function TExtraLegendTool.GetEditorClass: String;
begin
  result:='TExtraLegendEditor'; // Do not localize
end;

class function TExtraLegendTool.Description: String;
begin
  result:=TeeMsg_ExtraLegendTool;
end;

procedure TExtraLegendTool.SetSeries(const Value: TChartSeries);
begin
  inherited;
  Repaint;
end;

class function TExtraLegendTool.LongDescription: String;
begin
  result:=TeeMsg_ExtraLegendDesc;
end;

procedure TExtraLegendEditor.FormShow(Sender: TObject);
var tmp : TExtraLegendTool;
begin
  inherited;

  LegendEditor:=TFormTeeLegend.Create(Self);

  tmp:=TExtraLegendTool({$IFDEF CLR}TObject{$ENDIF}(Self.Tag));

  if Assigned(tmp) then
     LegendEditor.Legend:=tmp.Legend;

  LegendEditor.Align:=alClient;
  
  AddFormTo(LegendEditor, Self);
end;

initialization
  RegisterClass(TExtraLegendEditor);
  RegisterTeeTools([TExtraLegendTool]);
finalization
  UnRegisterTeeTools([TExtraLegendTool]);
end.
