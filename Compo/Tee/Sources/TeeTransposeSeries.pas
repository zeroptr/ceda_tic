{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2009 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeTransposeSeries;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
     {$ENDIF}
     TeEngine, TeCanvas;

type
  TTransposeSeriesTool=class(TTeeCustomTool)
  protected
    class Function GetEditorClass:String; override;
  public
    class Function Description:String; override;
    class Function LongDescription:String; override;

    procedure Transpose;
  end;

  TTransposeSeriesToolEdit = class(TForm)
    BTranspose: TButton;
    procedure BTransposeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Tool : TTransposeSeriesTool;
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
  Chart, TeeProCo;

{ TTransposeSeriesTool }

class function TTransposeSeriesTool.Description: String;
begin
  result:=TeeMsg_TransposeSeries;
end;

class function TTransposeSeriesTool.LongDescription: String;
begin
  result:=TeeMsg_TransposeSeriesDesc;
end;

class function TTransposeSeriesTool.GetEditorClass: String;
begin
  result:='TTransposeSeriesToolEdit';  { the editor dialog class name }
end;

procedure TTransposeSeriesTool.Transpose;
var tmp : Integer;
    t   : Integer;
    tt  : Integer;
    OldCount : Integer;
    tmpSeries : TChartSeries;
    Series : TChartSeriesList;
begin
  Series:=ParentChart.SeriesList;
  OldCount:=Series.Count;

  if OldCount>0 then
  begin
    tmp:=Series[0].Count;

    // Set all series colors to "none"
    // and get maximum number of points in all series
    for t:=1 to OldCount-1 do
    begin
      if Series[t].Count>tmp then
         tmp:=Series[t].Count;
    end;

    for t:=0 to tmp-1 do
    begin
      tmpSeries:=Series.Owner.AddSeries(TChartSeriesClass(Series[0].ClassType));

      for tt:=0 to OldCount-1 do
          with Series[tt].MandatoryValueList do
          if Count>t then
             if Series[tt].IsNull(t) then
                tmpSeries.AddNull(Value[t])
             else
                tmpSeries.Add(Value[t])
          else
             tmpSeries.AddNull;
    end;

    for t:=1 to OldCount do
        Series[0].Free;
  end;
end;

{ TTransposeSeriesToolEdit }

procedure TTransposeSeriesToolEdit.BTransposeClick(Sender: TObject);
begin
  Tool.Transpose;
end;

procedure TTransposeSeriesToolEdit.FormShow(Sender: TObject);
begin
  {$IFNDEF CLR}
  Tool:=TTransposeSeriesTool(Tag);
  {$ENDIF}
end;

initialization
  { register both the tool and the tool editor dialog form }

  RegisterClass(TTransposeSeriesToolEdit);
  RegisterTeeTools([TTransposeSeriesTool]);
finalization
  { un-register the tool }
  UnRegisterTeeTools([TTransposeSeriesTool]);
end.

