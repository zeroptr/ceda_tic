{******************************************}
{ TSeriesStatsTool and Editor Dialog       }
{ Copyright (c) 2006-2009 by David Berneda }
{******************************************}
unit TeeSeriesStats;
{$I TeeDefs.inc}

// Tool that provides easy access to choosen Series statistics like
// trend, averages, minimum and maximum values, etc.

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons,
  {$ENDIF}
  TeeToolSeriesEdit, TeeProcs, TeEngine, Chart, TeCanvas;

type
  TSeriesStatsTool=class(TTeeCustomToolSeries)
  private
    function GetStatFunction(FuncType:TTeeFunctionClass):TTeeFunction;
  protected
    class Function GetEditorClass:String; override;
  public
    class Function Description:String; override;
    class Function LongDescription:String; override;
    procedure Statistics(Lines:TStrings);
  published
    property Active;
    property Series;
  end;

  TSeriesStatsEditor = class(TSeriesToolEditor)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    CheckBox3: TCheckBox;
    Button3: TButton;
    CheckBox4: TCheckBox;
    Button4: TButton;
    CheckBox5: TCheckBox;
    Button5: TButton;
    CheckBox6: TCheckBox;
    Button6: TButton;
    procedure CBSeriesChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
  private
    { Private declarations }
    procedure CheckFunction(ABox:TCheckBox; AFunctionClass:TTeeFunctionClass);
    procedure EnableControls;
    procedure RefreshInfo;
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
  {$IFDEF CLR}
  Variants,
  {$ENDIF}
  TeeFunci, StatChar, CurvFitt, TeePenDlg, TeeEdiSeri, TeeConst, TeeProCo;

procedure TSeriesStatsEditor.CBSeriesChange(Sender: TObject);
begin
  inherited;

  EnableControls;
  RefreshInfo;
end;

procedure TSeriesStatsEditor.EnableControls;

  procedure EnableCheck(AButton:TButton; AClass:TTeeFunctionClass);
  var tmp : TCheckBox;
  begin
    tmp:=TCheckBox(AButton.Tag);

    tmp.Enabled:=Assigned(Tool) and Assigned(Tool.Series);

    if Assigned(Tool) then
       tmp.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(TSeriesStatsTool(Tool).GetStatFunction(AClass));

    tmp.Checked:=tmp.Tag<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF};
    AButton.Enabled:=tmp.Checked;
  end;

begin
  EnableCheck(Button1,TAverageTeeFunction);
  EnableCheck(Button2,TTrendFunction);
  EnableCheck(Button3,TLowTeeFunction);
  EnableCheck(Button4,THighTeeFunction);
  EnableCheck(Button5,TMedianTeeFunction);
  EnableCheck(Button6,TCurveFittingFunction);
end;

procedure TSeriesStatsEditor.RefreshInfo;
begin
  Memo1.Lines.Clear;

  if Assigned(Tool.Series) then
     (Tool as TSeriesStatsTool).Statistics(Memo1.Lines);
end;

{ TSeriesStatsTool }

class function TSeriesStatsTool.Description: String;
begin
  result:=TeeMsg_Statistics;
end;

function TSeriesStatsTool.GetStatFunction(FuncType:TTeeFunctionClass):TTeeFunction;
var t   : Integer;
    tmp : TTeeFunction;
begin
  result:=nil;

  for t:=0 to ParentChart.SeriesCount-1 do
  begin
    tmp:=ParentChart[t].FunctionType;
    if Assigned(tmp) and (tmp is FuncType) and (tmp.ParentSeries.DataSource=Series) then
    begin
      result:=tmp;
      exit;
    end;
  end;
end;

class function TSeriesStatsTool.GetEditorClass: String;
begin
  result:='TSeriesStatsEditor';
end;

procedure TSeriesStatsEditor.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabSheet2 then
     RefreshInfo;
end;

procedure TSeriesStatsEditor.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=TabSheet1;

  Button1.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(CheckBox1);
  Button2.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(CheckBox2);
  Button3.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(CheckBox3);
  Button4.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(CheckBox4);
  Button5.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(CheckBox5);
  Button6.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(CheckBox6);
end;

procedure TSeriesStatsEditor.CheckFunction(ABox:TCheckBox; AFunctionClass:TTeeFunctionClass);
var tmp : TTeeFunction;
begin
  tmp:=TSeriesStatsTool(Tool).GetStatFunction(AFunctionClass);

  if Assigned(tmp) then
     tmp.ParentSeries.Visible:=ABox.Checked
  else
  if ABox.Checked then
  begin
    tmp:=AFunctionClass.Create(Tool.Owner);
    tmp.ParentSeries:=TChartSeriesClass(Tool.Series.ClassType).Create(Tool.Owner);
    tmp.ParentSeries.ShowInEditor:=False;
    tmp.ParentSeries.ParentChart:=Tool.ParentChart;
    tmp.ParentSeries.DataSource:=Tool.Series;
    tmp.ParentSeries.FunctionType:=tmp;
    ABox.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(tmp);
  end;
end;

procedure TSeriesStatsEditor.CheckBox1Click(Sender: TObject);
begin
  Button1.Enabled:=CheckBox1.Checked;
  CheckFunction(CheckBox1,TAverageTeeFunction);
end;

procedure TSeriesStatsEditor.Button1Click(Sender: TObject);
var tmp : TCheckBox;
begin
  tmp:=TCheckBox((Sender as TButton).Tag);
  EditSeriesDialog(Self,TTeeFunction(tmp.Tag).ParentSeries);
end;

procedure TSeriesStatsEditor.CheckBox2Click(Sender: TObject);
begin
  Button2.Enabled:=CheckBox2.Checked;
  CheckFunction(CheckBox2,TTrendFunction);
end;

procedure TSeriesStatsEditor.FormShow(Sender: TObject);
begin
  inherited;
  EnableControls;
end;

procedure TSeriesStatsEditor.CheckBox3Click(Sender: TObject);
begin
  Button3.Enabled:=CheckBox3.Checked;
  CheckFunction(CheckBox3,TLowTeeFunction);
end;

procedure TSeriesStatsEditor.CheckBox4Click(Sender: TObject);
begin
  Button4.Enabled:=CheckBox4.Checked;
  CheckFunction(CheckBox4,THighTeeFunction);
end;

procedure TSeriesStatsEditor.CheckBox5Click(Sender: TObject);
begin
  Button5.Enabled:=CheckBox5.Checked;
  CheckFunction(CheckBox5,TMedianTeeFunction);
end;

procedure TSeriesStatsEditor.CheckBox6Click(Sender: TObject);
begin
  Button6.Enabled:=CheckBox6.Checked;
  CheckFunction(CheckBox6,TCurveFittingFunction);
end;

procedure TSeriesStatsTool.Statistics(Lines: TStrings);

  function AtPosition(const Value:TChartValue):String;
  var tmpIndex : Integer;
  begin
    tmpIndex:=Series.MandatoryValueList.Locate(Value);
    if tmpIndex<>-1 then
       result:=' at position '+IntToStr(tmpIndex)
    else
       result:='';
  end;

  procedure AddFunction(FunctionClass:TTeeFunctionClass; const Description:String);
  begin
    with FunctionClass.Create(nil) do
    try
      Lines.Add(Description+' '+FormatFloat(Series.ValueFormat,Calculate(Series,-1,-1)));
    finally
      Free;
    end;
  end;

var tmpAvg : TChartValue;
begin
  if Assigned(Series) then
  begin
    Lines.Add('Number of values: '+IntToStr(Series.Count));

    with Series,MandatoryValueList do
    begin
      Lines.Add('Maximum value: '+FormatFloat(ValueFormat,MaxValue)+AtPosition(MaxValue));
      Lines.Add('Minimum value: '+FormatFloat(ValueFormat,MinValue)+AtPosition(MinValue));

      Lines.Add('');
      Lines.Add('Range: '+FormatFloat(ValueFormat,Range));

      Lines.Add('');

      if Count>0 then tmpAvg:=Total/Count
                 else tmpAvg:=0;

      Lines.Add('Average: '+FormatFloat(ValueFormat,tmpAvg));

      AddFunction(TMedianTeeFunction,'Median:');
      AddFunction(TModeTeeFunction,'Mode:');
      AddFunction(TStdDeviationFunction,'Std. Deviation:');
      AddFunction(TVarianceFunction,'Variance:');
      AddFunction(TRMSFunction,'Root Mean Square:');
      AddFunction(TCorrelationFunction,'Correlation:');
    end;
  end;
end;

class function TSeriesStatsTool.LongDescription: String;
begin
  result:=TeeMsg_StatsToolDesc;
end;

initialization
  RegisterClass(TSeriesStatsEditor);
  RegisterTeeTools([TSeriesStatsTool]);
finalization
  UnRegisterTeeTools([TSeriesStatsTool]);
end.
