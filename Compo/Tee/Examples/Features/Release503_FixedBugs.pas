unit Release503_FixedBugs;
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
  TRelease503Fixed = class(TForm)
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

procedure TRelease503Fixed.FormCreate(Sender: TObject);
begin
  With StringGrid1 do
  begin
    RowCount:=10;

    Cells[0,0]:='Fixed bugs';
    Cells[1,0]:='TeeChart Pro Release 5.03';

    Cells[0,1] :='Pie Series';
    Cells[0,2] :='All 3D Series';
    Cells[0,3] :='Legend';
    Cells[0,4] :='Logarithmic Axes';
    Cells[0,5] :='Bar Series';
    Cells[0,6] :='Transparency';
    Cells[0,7] :='Polar / WindRose';
    Cells[0,8] :='Right Axis';
    Cells[0,9] :='ColorBand tool';

    Cells[1,1] :='Fixed Pie Clicked function when Pie is shown in 3D.';
    Cells[1,2] :='Fixed Color Palette generation (Surface,Contour,Map,etc).';
    Cells[1,3] :='Large Horizontal Legend with CheckBoxes does not override bounds.';
    Cells[1,4] :='Fixed exception when calculating logarithmic axis positions before the chart was first time displayed.';
    Cells[1,5] :='Fixed bug in Bar series with CustomBarWidth > 0 and BarWidthPercent = 100.';
    Cells[1,6] :='All Transparency properties are now published into DFM and *.tee streams.';
    Cells[1,7] :='New Color button in Polar and WindRose editor dialogs.';
    Cells[1,8] :='Fixed OnClickAxis event for Right Axis in 3D mode.';
    Cells[1,9] :='Fixed drawing problem in 3D with Gradient and Transparency.';
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

procedure TRelease503Fixed.StringGrid1DblClick(Sender: TObject);
begin
  CopyClipboard(StringGrid1);
end;

initialization
  RegisterClass(TRelease503Fixed);
end.
