unit UBigFlatFile;
{$I TeeDefs.inc}

interface

// This demo shows how to use the TDataSubSet class and the
// TAxisScrollbar control.

// In this example, a DataSubset is used to navigate a flat file
// composed of records with a "double" value.

// The flat file is very big (one million records), and the demo
// shows dinamically loading 100 points at a time when scrolling the
// chart.
// That is, points are loaded on-demand, when they are needed to display
// instead of loading them all at the beginning.

// The AxisScrollbar control is displayed at the bottom, allowing
// full scroll of the full flat file.


// As an example, this unit shows how to implement the on-demand navigation
// using a simple "File" or a "TFileStream", depending on "USEFILE" compiler
// define.

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  {$IFDEF CLR}
  Variants, System.ComponentModel,
  {$ENDIF}
  TeEngine, Series, TeeProcs, Chart, TeCanvas, TeeComma, TeeDataSubset,
  TeeCreateFlatFile, TeeAxisScroll, TeeLegendScrollBar,
  TeeBrushdlg, TeeThemes, TeeThemeEditor, TeePNG, TeeJPEG, TeeGIF;


// Pending:

// -Better user interface
// -Smooth-scrolling, specially when changing page (optional, with number of steps)
// -Create a TDBSubDataset class to manage large TDataSet or TTable source data.
// -Create a TFlatFileSubData class to do the same as this demo, but being SubData
//  a class that encapsulates "TheFile", etc.

type
  TForm1 = class(TForm)
    Chart1: TChart;
    Series1: TBarSeries;
    TeeCommander1: TTeeCommander;
    Chart2: TChart;
    Panel1: TPanel;
    BScrollLeft: TButton;
    BScrollRight: TButton;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    BPrevious: TButton;
    BNext: TButton;
    Label3: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    CheckBox1: TCheckBox;
    ComboFlat1: TComboFlat;
    CheckBox2: TCheckBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BPreviousClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BScrollRightClick(Sender: TObject);
    procedure BScrollLeftClick(Sender: TObject);
    procedure ComboFlat1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Chart1Scroll(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    CachedSize : Integer;
    IsOpen : Boolean;
    TheFile : TFlatFile;

    SubData : TDataSubset;

    AxisScroll : TAxisScrollBar;

    AnimatedScroll : Boolean;
    AnimScrollMin,
    AnimScrollRange : Double;
    procedure StartAnimatedScroll;
    procedure EndAnimatedScroll;

    procedure AxisChangedPosition(Sender: TTeeScrollBar; Value:Integer);
    procedure AxisScrollResize(Sender: TObject);

    procedure CheckButtons;
    procedure CheckClose;
    procedure CreateAxisScrollBar;
    procedure GuessFileSize;
    function TheFileName:String;
    function TheFileSize:Integer;
    procedure ReopenFile;

    // Methods that provide on-demand loading:
    // procedure LoadFlatItem(Index:Integer; Var Value:Double);

    procedure GetTotalItems(Var TotalItems:Integer);
    procedure LoadFlatMultipleItem(Index,Count:Integer; var Data:TChartValues);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

// Steps used in animated scrolling, when the variable AnimatedScroll = True
const
  ScrollAnimation=8;

// Returns the size in bytes of the big flat file.
// This file size is used to calculate the number of records the file contains.
function TForm1.TheFileSize:Integer;
var f : TFileStream;
begin
  {$IFNDEF USEFILE}
  if Assigned(TheFile) then result:=TheFile.Size
  else
  {$ENDIF}
  if FileExists(TheFileName) then
  begin
    f:=TFileStream.Create(TheFileName,fmOpenRead);
    try
      result:=f.Size;
    finally
      f.Free;
    end;
  end
  else
    result:=-1;
end;

// Sets the Label1 in this form to show the number of records (items)
procedure TForm1.GuessFileSize;
var Size : Integer;
    tmp  : Integer;
begin
  Size:=TheFileSize;
  if Size=-1 then Label1.Caption:='?'
  else
  begin
    GetTotalItems(tmp);
    Label1.Caption:='Total: '+IntToStr(tmp);
  end;
end;

// Event called when the axis scroll "Size" property is changed.
procedure TForm1.AxisScrollResize(Sender: TObject);
begin
  Chart2.Height:=AxisScroll.Size+2;
end;

// Event called when the axis scroll "Position" property is changed.
// (ie: when the user clicks the scrollbar thumb or left-right arrows)
procedure TForm1.AxisChangedPosition(Sender: TTeeScrollBar; Value:Integer);
begin
  SubData.LoadAllPage(Value);
  CheckButtons;
end;

// Initialize form
procedure TForm1.FormCreate(Sender: TObject);
begin
  // If there is no sample flat file, create it !
  if TheFileSize=-1 then
  with TFormCreateFile.Create(Self) do
  try
    if ShowModal=mrCancel then
    begin
      Application.Terminate;
      exit;
    end;
  finally
    Free;
  end;

  ComboFlat1.ItemIndex:=0;

  // Create the "subdata" object
  SubData:=TDataSubset.Create(Self);
  SubData.Series:=Series1;
  SubData.WindowSize:=100;
  SubData.OnTotalItems:=GetTotalItems;

// Example using event:
//  SubData.OnNeedData:=LoadFlatItem;

  SubData.OnNeedManyData:=LoadFlatMultipleItem;

  IsOpen:=False;
  GuessFileSize;
end;

// Creates a TAxisScrollbar and prepares it.
procedure TForm1.CreateAxisScrollBar;
var tmp : TBrushDialog;
begin
  AxisScroll:=TAxisScrollBar.Create(Self);
  with AxisScroll do
  begin
    Axis:=Series1.GetHorizAxis;
    ParentChart:=Chart2;

    Pen.Color:=clDkGray;
    ThumbBrush.Color:=clBlack;
    OnSetPosition:=AxisChangedPosition;
    CustomCount:=SubData.WindowSize;

    Gradient.Visible:=True;
    Gradient.Direction:=gdTopBottom;
    Gradient.EndColor:=clDkGray;
    Gradient.MidColor:=clWhite;
    Gradient.StartColor:=clSilver;

    OnChangeSize:=AxisScrollResize;
    MinThumbSize:=8;

    // Dirty way to set preset images
    tmp:=TBrushDialog.Create(nil);
    ThumbBrush.Image:=tmp.ImageMetal.Picture;
    ArrowBrush.Image:=tmp.ImageStone.Picture;
    Brush.Image:=tmp.ImageSnow.Picture;
    tmp.Free;
  end;
end;

// Event called whenever the subdata needs one record item
(*
procedure TForm1.LoadFlatItem(Index:Integer; Var Value:Double);
var SampleData : TData;
begin
  {$IFDEF USEFILE}
  Seek(TheFile,Index);
  Read(TheFile,SampleData);
  {$ELSE}
  {$IFDEF CLR}
  TheFile.Seek(Index,soBeginning);
  TheFile.Read(SampleData.Value);
  {$ELSE}
  TheFile.Seek(Index,soFromBeginning);
  TheFile.Read(SampleData,SizeOf(SampleData));
  {$ENDIF}
  {$ENDIF}

  Value:=SampleData.Value;
end;
*)

// This event is called whenever the "subdata" needs multiple records
procedure TForm1.LoadFlatMultipleItem(Index,Count:Integer; var Data:TChartValues);
{$IFDEF USEFILE}
var SampleData : TData;
    t          : Integer;
{$ENDIF}
begin
  {$IFDEF USEFILE}

  Seek(TheFile,Index);
  for t:=0 to Count-1 do
  begin
    Read(TheFile,SampleData);
    Data[t]:=SampleData.Value;
  end;

  {$ELSE}

  {$IFDEF D9}
  TheFile.Seek(Index*SizeOf(TChartValue),soBeginning);
  {$ELSE}
  TheFile.Seek(Index*SizeOf(TChartValue),soFromBeginning);
  {$ENDIF}
  TheFile.Read(Data[0],Count*SizeOf(TChartValue));

  {$ENDIF}
end;

// Simply returns the default name of the sample big flat file
function TForm1.TheFileName:String;
begin
  result:='deleteme.dat';
end;

// Close the sample flat file
procedure TForm1.CheckClose;
begin
  if IsOpen then
     {$IFDEF USEFILE}
     CloseFile(TheFile);
     {$ELSE}
     TheFile.Free;
     {$ENDIF}
end;

// Close and re-open the sample flat file
procedure TForm1.ReopenFile;
begin
  CheckClose;

  {$IFDEF USEFILE}
  AssignFile(TheFile,TheFileName);
  Reset(TheFile);
  {$ELSE}
  TheFile:=TFlatFile.Create(TheFileName,fmOpenRead);
  {$ENDIF}

  IsOpen:=True;
end;

// Show or hide the Series !
procedure TForm1.CheckBox1Click(Sender: TObject);
var tmp : Integer;
begin
  Series1.Visible:=CheckBox1.Checked;

  if Series1.Visible then
  begin
    ReopenFile;
    SubData.GotoFirstPage;
    GetTotalItems(tmp);
    AxisScroll.CustomTotal:=tmp;
  end;

  CachedSize:=0;
  CheckButtons;
end;

// Terminate form. Close sample flat file.
procedure TForm1.FormDestroy(Sender: TObject);
begin
  CheckClose;
  IsOpen:=False;
  SubData.Free;
end;

// Go to previous page
procedure TForm1.BPreviousClick(Sender: TObject);
begin
  SubData.PreviousPage;
  CheckButtons;
end;

// Event called when subdata needs to know the total number of
// records in the big sample file.
// In this example, this value is cached to increase speed...
procedure TForm1.GetTotalItems(Var TotalItems:Integer);
begin
  if CachedSize=0 then
     CachedSize:=TheFileSize div SizeOf(TData);
  TotalItems:=CachedSize;
end;

// When scrolling a full page, with AnimatedScroll = True
procedure TForm1.StartAnimatedScroll;
begin
  AnimScrollMin:=AxisScroll.Axis.Minimum;
  AnimScrollRange:=AxisScroll.Axis.Maximum-AnimScrollMin;
end;

// When scrolling a full page, with AnimatedScroll = True
procedure TForm1.EndAnimatedScroll;
var t: Integer;
    ScrollStep : Double;
begin
  ScrollStep:=AnimScrollRange/ScrollAnimation;

  for t:=0 to ScrollAnimation-1 do
  begin
    AxisScroll.Axis.SetMinMax(AnimScrollMin,AnimScrollMin+AnimScrollRange);
    AxisScroll.Axis.ParentChart.Update;
    AnimScrollMin:=AnimScrollMin+ScrollStep;
  end;
  AxisScroll.Axis.Automatic:=True;
end;

// Go to next page
procedure TForm1.BNextClick(Sender: TObject);
begin
  if AnimatedScroll then StartAnimatedScroll;

  SubData.NextPage;
  CheckButtons;

  if AnimatedScroll then EndAnimatedScroll;
end;

// Enable or disable the buttons to go to previous / next page or record
procedure TForm1.CheckButtons;
var tmp : Integer;
begin
  BPrevious.Enabled:=SubData.FirstIndex>0;
  GetTotalItems(tmp);
  BNext.Enabled:=SubData.FirstIndex+SubData.WindowSize<tmp;
  BScrollLeft.Enabled:=BPrevious.Enabled;
  BScrollRight.Enabled:=BNext.Enabled;

  // Reset axis to automatic
  AxisScroll.Axis.Automatic:=True;
end;

// Go to next point (record)
procedure TForm1.BScrollRightClick(Sender: TObject);
begin
  SubData.ScrollPoints(UpDown1.Position);
  CheckButtons;
end;

// Go to previous point (record)
procedure TForm1.BScrollLeftClick(Sender: TObject);
begin
  SubData.ScrollPoints(-UpDown1.Position);
  CheckButtons;
end;

// Change the style of the series...
procedure TForm1.ComboFlat1Change(Sender: TObject);
var tmpSeries : TChartSeries;
begin
  tmpSeries:=TChartSeries(SubData.Series);
  case ComboFlat1.ItemIndex of
    0: ChangeSeriesType(tmpSeries,TBarSeries);
    1: ChangeSeriesType(tmpSeries,TLineSeries);
    2: ChangeSeriesType(tmpSeries,THorizBarSeries);
    3: ChangeSeriesType(tmpSeries,THorizLineSeries);
    4: ChangeSeriesType(tmpSeries,TFastLineSeries);
    5: ChangeSeriesType(tmpSeries,TPointSeries);
    6: ChangeSeriesType(tmpSeries,TAreaSeries);
    7: ChangeSeriesType(tmpSeries,THorizAreaSeries);
  end;

  Series1:=TBarSeries(tmpSeries);
  SubData.Series:=Series1;

  if tmpSeries.YMandatory then
     AxisScroll.Axis:=tmpSeries.GetHorizAxis
  else
     AxisScroll.Axis:=tmpSeries.GetVertAxis;
end;

// Show or hide the Legend
procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  Chart1.Legend.Visible:=CheckBox2.Checked;
end;

// Change the "window size", ie, the number of points that
// are displayed.
procedure TForm1.Button2Click(Sender: TObject);
begin
  AxisScroll.Axis.Automatic:=True;
  AxisScroll.CustomCount:=SubData.WindowSize;
  AxisScroll.Repaint;

  SubData.ReLoadPage;
end;

// Show the scrollbar editor dialog...
procedure TForm1.Button1Click(Sender: TObject);
begin
  with TScrollbarEditor.Create(Self) do
  try
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AxisScroll);
    ShowModal;
  finally
    Free;
  end;
end;

// When the end-user scrolls the chart dragging the right-mouse button,
// re-load points so they cover the new area.
procedure TForm1.Chart1Scroll(Sender: TObject);
begin
  SubData.LoadAllPage(Round(AxisScroll.Axis.Minimum));
  CheckButtons;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  SubData.WindowSize:=StrToInt(Edit1.Text);

  // "ScrollBy" must be equal or less than WindowSize.
  UpDown1.Max:=SubData.WindowSize;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  {$IFDEF BCB}
  exit;
  {$ENDIF}
  
  // Some cosmetic properties...
  Series1.Marks.Hide;
  Chart1.View3DOptions.Perspective:=160;

  // Allow only right-mouse button scrolling on one direction
  if Series1.YMandatory then
     Chart1.AllowPanning:=pmHorizontal
  else
     Chart1.AllowPanning:=pmVertical;

  // Create the bottom axis scrollbar control
  CreateAxisScrollBar;

  CheckBox1.Checked:=True;
end;

end.
