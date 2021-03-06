unit ChartListBox_FontSeriesColor;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls,
  {$ENDIF}
  Base, TeeProcs, TeEngine, Chart, Series, TeCanvas, TeeLisB;

type
  TChartListBoxFontSeriesColor = class(TBaseForm)
    ChartListBox1: TChartListBox;
    Series1: TLineSeries;
    Series2: TPointSeries;
    Series3: TLineSeries;
    Series4: TPointSeries;
    cbFont: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure cbFontClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$R *.dfm}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TChartListBoxFontSeriesColor.FormCreate(Sender: TObject);
begin
  inherited;

  with ChartListBox1 do
  begin
    Chart:=Chart1;
    FontSeriesColor:=true;
  end;
end;

procedure TChartListBoxFontSeriesColor.cbFontClick(Sender: TObject);
begin
  ChartListBox1.FontSeriesColor:=cbFont.Checked;
end;

initialization
  RegisterClass(TChartListBoxFontSeriesColor);
end.
