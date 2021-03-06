unit SeriesType_Area;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  {$ENDIF}
  Base, TeEngine, Series, TeeProcs, Chart, TeeTools;

type
  TAreaSeriesForm = class(TBaseForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    ChartTool1: TMarksTipTool;
    Series1: TAreaSeries;
    Series3: TAreaSeries;
    Series2: TAreaSeries;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses EditChar;

procedure TAreaSeriesForm.ComboBox1Change(Sender: TObject);
begin
  Case ComboBox1.ItemIndex of
    0: Series1.MultiArea:=maNone;
    1: Series1.MultiArea:=maStacked;
    2: Series1.MultiArea:=maStacked100;
  end;

  { remove "Marks" when stacking... }
  Series1.Marks.Visible:=Series1.MultiArea=maNone;
  Series2.Marks.Visible:=Series2.MultiArea=maNone;
  Series3.Marks.Visible:=Series3.MultiArea=maNone;
end;

procedure TAreaSeriesForm.Button1Click(Sender: TObject);
begin
  EditSeries(Self,Series1);
end;

procedure TAreaSeriesForm.FormCreate(Sender: TObject);
begin
  inherited;
  Chart1.SeriesList.FillSampleValues(6);
end;

procedure TAreaSeriesForm.CheckBox2Click(Sender: TObject);
begin
  Chart1.View3D:=CheckBox2.Checked;
end;

procedure TAreaSeriesForm.CheckBox1Click(Sender: TObject);
begin
  Series1.Stairs:=CheckBox1.Checked;
  Series2.Stairs:=CheckBox1.Checked;
  Series3.Stairs:=CheckBox1.Checked;
end;

procedure TAreaSeriesForm.FormShow(Sender: TObject);
begin
  inherited;
  ComboBox1.ItemIndex:=0;
end;

initialization
  RegisterClass(TAreaSeriesForm);
end.
