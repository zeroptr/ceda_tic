unit Release501_FixedBugs;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
  QGrids,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  Grids,
  {$ENDIF}
  SysUtils, Classes;

type
  TRelease501Fixed = class(TForm)
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
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

procedure TRelease501Fixed.FormCreate(Sender: TObject);
begin
  With StringGrid1 do
  begin
    RowCount:=32;

    Cells[0,0]:='Fixed bugs';
    Cells[1,0]:='TeeChart Pro Release 5.01';


    Cells[0,1] :='ADX Function';
    Cells[0,2] :='Candle Series';
    Cells[0,3] :='Chart Legend';
    Cells[0,4] :='Bar and Horiz';
    Cells[0,5] :='BarSeries';
    Cells[0,6] :='Bollinger';
    Cells[0,7] :='BarJoin series';
    Cells[0,8] :='ChartGrid';
    Cells[0,9] :='ChartGrid';
    Cells[0,10]:='TeeCommander';
    Cells[0,11]:='SeriesDataSet';
    Cells[0,12]:='Chart Editor';
    Cells[0,13]:='TeeStore';
    Cells[0,14]:='ColorGrid';
    Cells[0,15]:='HighLow series';
    Cells[0,16]:='Chart Editor';
    Cells[0,17]:='Contour series';
    Cells[0,18]:='FunctionType';
    Cells[0,19]:='MarkTipsTool';
    Cells[0,20]:='ChartListBox';
    Cells[0,21]:='SeriesDataSet';
    Cells[0,22]:='ErrorSeries';
    Cells[0,23]:='BackColor';
    Cells[0,24]:='Title and Foot';
    Cells[0,25]:='DrawLine Tool';
    Cells[0,26]:='Contour Series';
    Cells[0,27]:='Zoom Pen';
    Cells[0,28]:='DBChart Horiz';
    Cells[0,29]:='Gallery';
    Cells[0,30]:='Pie Series';
    Cells[0,31]:='Candle Series';

    Cells[1,1] :='Fixed access violation when destroying the series.';
    Cells[1,2] :='Fixed reversing of colors (UpClose and DownClose).';
    Cells[1,3] :='The OnGetLegendText event was not being called.';
    Cells[1,4] :='(C++ Builder only) CustomBarSize was not possible to use at runtime.';
    Cells[1,5] :='Several Bar series Stacked with first point 0 now works.';
    Cells[1,6] :='Fixed division by zero in special circumstances.';
    Cells[1,7] :='Editor was giving access violation.';
    Cells[1,8] :='Setting label text to a series with less number of points than other series was not working.';
    Cells[1,9] :='Changing or setting the Chart property now correctly repaints the grid.';
    Cells[1,10]:='Buttons can now be set invisible.';
    Cells[1,11]:='Null values supported when using the SeriesDataSet in a DBChart.';
    Cells[1,12]:='DBChart DataSources now show datasets in datamodules.';
    Cells[1,13]:='(Delphi 5 and up) Saving charts with functions now correctly reconnect when loading.';
    Cells[1,14]:='Creating grids of size less than 10x10 now works fine.';
    Cells[1,15]:='XValues property is now published.';
    Cells[1,16]:='Selecting Foot / SubFoot property was showing the opposite.';
    Cells[1,17]:='Assign method now supported. (ie: Contour1.Assign(Surface1) )';
    Cells[1,18]:='Now calling Series1.FunctionType.Free works correctly.';
    Cells[1,19]:='Multiple on the same chart now work correctly.';
    Cells[1,20]:='Setting MultiSelect=False now works correctly.';
    Cells[1,21]:='Fixed some errors when used with empty Series.';
    Cells[1,22]:='Horizontal display now works correctly.';
    Cells[1,23]:='Reading a Chart form or tee file created with version 4.03 failed when BackColor was -1.';
    Cells[1,24]:='Chart Title and Foot now save the CustomPosition at design-time.';
    Cells[1,25]:='Accesing the Line[].Pen property no longer fails.';
    Cells[1,26]:='Modifying Level properties of an empty Contour works fine now.';
    Cells[1,27]:='A Chart Zoom Pen (not solid) with Width > 1 displays fine now.';
    Cells[1,28]:='Horiz Series in a DBChart with XY values now plots values fine.';
    Cells[1,29]:='Changing the Series type now preserves axis settings.';
    Cells[1,30]:='The Legend now display correctly when Pie Patterns are used.';
    Cells[1,31]:='Setting DateValues.DateTime to False at design-time works fine now.';
  end;
end;

initialization
  RegisterClass(TRelease501Fixed);
end.
