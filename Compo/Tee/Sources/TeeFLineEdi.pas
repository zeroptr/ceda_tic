{******************************************}
{    TFastLineSeries Editor Dialog         }
{ Copyright (c) 1996-2009 by David Berneda }
{******************************************}
unit TeeFLineEdi;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QForms, QControls, QStdCtrls, QComCtrls,
  {$ELSE}
  Graphics, Forms, Controls, StdCtrls, ComCtrls,
  {$ENDIF}
  Classes, TeePenDlg, TeCanvas, Series;

type
  TFastLineSeriesEditor = class(TPenDialog)
    CBDrawAll: TCheckBox;
    GBStair: TGroupBox;
    CBStairs: TCheckBox;
    CBInvStairs: TCheckBox;
    CBNulls: TComboFlat;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BColorClick(Sender: TObject);
    procedure CBDrawAllClick(Sender: TObject);
    procedure CBStairsClick(Sender: TObject);
    procedure CBInvStairsClick(Sender: TObject);
    procedure CBNullsChange(Sender: TObject);
  private
    { Private declarations }
    FastLine : TFastLineSeries;
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

procedure TFastLineSeriesEditor.FormShow(Sender: TObject);
begin
  FastLine:=TFastLineSeries(Tag);
  if Assigned(FastLine) then
  begin
    ThePen:=FastLine.Pen;
    CBDrawAll.Checked:=FastLine.DrawAllPoints;
    CBStairs.Checked:=FastLine.Stairs;
    CBInvStairs.Checked:=FastLine.InvertedStairs;
    CBInvStairs.Enabled:=CBStairs.Checked;
    CBNulls.ItemIndex:=Ord(FastLine.TreatNulls);
  end;

  inherited;
end;

procedure TFastLineSeriesEditor.BColorClick(Sender: TObject);
begin
  inherited;
  FastLine.SeriesColor:=ThePen.Color;
  CBStyle.Repaint;
end;

procedure TFastLineSeriesEditor.CBDrawAllClick(Sender: TObject);
begin
  FastLine.DrawAllPoints:=CBDrawAll.Checked;
end;

procedure TFastLineSeriesEditor.CBStairsClick(Sender: TObject);
begin
  FastLine.Stairs:=CBStairs.Checked;
  CBInvStairs.Enabled:=CBStairs.Checked;
end;

procedure TFastLineSeriesEditor.CBInvStairsClick(Sender: TObject);
begin
  FastLine.InvertedStairs:=CBInvStairs.Checked;
end;

procedure TFastLineSeriesEditor.CBNullsChange(Sender: TObject);
begin
  FastLine.IgnoreNulls:=CBNulls.ItemIndex=2;
  FastLine.TreatNulls:=TTreatNullsStyle(CBNulls.ItemIndex);
end;

initialization
  RegisterClass(TFastLineSeriesEditor);
end.
