unit Release502_FixedBugs;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls, QComCtrls,
  QGrids, QClipbrd,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  Grids, Clipbrd,
  {$ENDIF}
  SysUtils, Classes;

type
  TRelease502Fixed = class(TForm)
    StringGrid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
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

procedure TRelease502Fixed.FormCreate(Sender: TObject);
begin
  With StringGrid1 do
  begin
    RowCount:=25;

    Cells[0,0]:='Fixed bugs';
    Cells[1,0]:='TeeChart Pro Release 5.02';

    Cells[0,1] :='Chart Wall';
    Cells[0,2] :='CloneChartSeries';
    Cells[0,3] :='Chart Title Editor';
    Cells[0,4] :='Gallery';
    Cells[0,5] :='Series Assign';
    Cells[0,6] :='Brush Style';
    Cells[0,7] :='Shape Series';
    Cells[0,8] :='Pie Series';
    Cells[0,9] :='Pie Series (CLX)';
    Cells[0,10] :='XML Data Export';
    Cells[0,11] :='Polar Series';
    Cells[0,12] :='Tools and Chart Cursor';
    Cells[0,13] :='Box-Plot and Median';
    Cells[0,14] :='Titles and Footers';
    Cells[0,15] :='Pie Shadow';
    Cells[0,16] :='Donut Series Assign';
    Cells[0,17] :='Polar and Radar';
    Cells[0,18] :='Legend Clicked';
    Cells[0,19] :='DrawLine Tool';
    Cells[0,20] :='Axis Title';
    Cells[0,21] :='TeeFunctions';
    Cells[0,22] :='Bezier Series';
    Cells[0,23] :='Radar/Polar Series';
    Cells[0,24] :='Smith Series';

    Cells[1,1] :='Fixed storing to DFM the LeftWall Color when is White.';
    Cells[1,2] :='Fixed Access Violation when Series.ParentChart was nil.';
    Cells[1,3] :='Selection from Foot and SubFoot was inverted.';
    Cells[1,4] :='If the dropped sub-gallery is outside the right side, it is moved.';
    Cells[1,5] :='Fixed bug when assigning a Bar Series to HorizBar series.';
    Cells[1,6] :='Version 5.01 introduced a bug in Brush Style when using extended styles.';
    Cells[1,7] :='Fixed bug when using a Brush Style non solid.';
    Cells[1,8] :='Pie Series restores original 3D settings when removing or changing it.';
    Cells[1,9] :='Pie Series in 2D under Kylix (CLX) painting bug.';
    Cells[1,10] :='XML exporting now works with X values.';
    Cells[1,11] :='Polar and Radar transparent with Brush.Color:=clNone';
    Cells[1,12] :='Some tools (like CursorTool) wrongly reset the Chart Cursor to default.';
    Cells[1,13] :='Box-Plot series Median was incorrectly calculated.';
    Cells[1,14] :='Titles with Custom Position are now displayed on top of chart';
    Cells[1,15] :='Pie Series Shadow property is now published, (it was public)';
    Cells[1,16] :='Donut Series now uses Assign to copy HolePercent from other Donut Series';
    Cells[1,17] :='Setting CircleBackColor to clNone now uses it as transparent.';
    Cells[1,18] :='Clicked function was not working fine with Inverted and Horizontal Legend.';
    Cells[1,19] :='Calling DeleteSelected while drawing a line was causing an AV.';
    Cells[1,20] :='When Axis LabelsExponent is True, Title did not display "e" characters.';
    Cells[1,21] :='Fixed problem using multiple Series as datasources, when the first series is empty.';
    Cells[1,22] :='Bezier series was not calling OnGetPointerStyle event.';
    Cells[1,23] :='Radar and Polar series display now better rotated labels.';
    Cells[1,24] :='Smith series uses now ShowLabels property.';
  end;
end;

Procedure CopyClipboard(Grid:TStringGrid);
var tmp : TStringList;
    t   : Integer;
begin
  tmp:=TStringList.Create;
  try
    for t:=0 to Grid.RowCount-1 do
      tmp.Add('-'+Grid.Cells[0,t]+#9+Grid.Cells[1,t]);
    Clipboard.AsText:=tmp.Text;
  finally
    tmp.Free;
  end;
end;

procedure TRelease502Fixed.StringGrid1DblClick(Sender: TObject);
begin
  CopyClipboard(StringGrid1);
end;

initialization
  RegisterClass(TRelease502Fixed);
end.
