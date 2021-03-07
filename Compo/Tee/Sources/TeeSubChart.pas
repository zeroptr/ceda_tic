{**********************************************}
{   TeeChart - TSubChartTool                   }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeSubChart;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QExtCtrls, 
  QStdCtrls, QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Buttons,
  {$ENDIF}
  {$IFDEF D6}
  Types,
  {$ENDIF}
  TeCanvas, TeEngine, Chart, TeeTools, TeeProcs, TeeEdit;

type
  TSubChart=class(TCollectionItem)
  private
    FChart : TChart;

    ITool  : TTeeCustomTool;

    function GetBounds:TRect;
    function GetChart:TChart;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    function GetWidth: Integer;
    procedure ReadChart(Stream: TStream);
    procedure SetChart(const Value: TChart);
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure WriteChart(Stream: TStream);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    Constructor Create(Collection:TCollection); {$IFDEF D5}overload;{$ENDIF} override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    property Bounds:TRect read GetBounds;
  published
    property Chart:TChart read GetChart write SetChart stored False;
    property Height:Integer read GetHeight write SetHeight;
    property Left:Integer read GetLeft write SetLeft;
    property Top:Integer read GetTop write SetTop;
    property Width:Integer read GetWidth write SetWidth;
  end;

  TChartCollection=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TSubChart;
    Procedure Put(Index:Integer; Const Value:TSubChart);
  public
    function AddChart(const AName:String=''):TChart;

    property Items[Index:Integer]:TSubChart read Get write Put; default;
  end;

  TSubChartTool=class(TTeeCustomTool)
  private
    FCharts : TChartCollection;
    procedure SetCharts(const Value: TChartCollection);
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;

    class Function GetEditorClass:String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Charts:TChartCollection read FCharts write SetCharts;
  end;

  TSubChartEditor = class(TForm)
    Panel1: TPanel;
    LBCharts: TListBox;
    PageControl1: TPageControl;
    TabPosition: TTabSheet;
    TabChart: TTabSheet;
    LLeft: TLabel;
    Edit1: TEdit;
    UDLeft: TUpDown;
    LTop: TLabel;
    Edit2: TEdit;
    UDTop: TUpDown;
    LWidth: TLabel;
    Edit3: TEdit;
    UDWidth: TUpDown;
    LHeight: TLabel;
    Edit4: TEdit;
    UDHeight: TUpDown;
    Panel2: TPanel;
    BUp: TSpeedButton;
    BDown: TSpeedButton;
    Panel3: TPanel;
    BAdd: TButton;
    BDelete: TButton;
    BRename: TButton;
    Panel4: TPanel;
    Panel5: TPanel;
    CBTransp: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure LBChartsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BAddClick(Sender: TObject);
    procedure BDeleteClick(Sender: TObject);
    procedure BUpClick(Sender: TObject);
    procedure BDownClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BRenameClick(Sender: TObject);
    procedure CBTranspClick(Sender: TObject);
  private
    { Private declarations }
    ChartEditor : TChartEditorPanel;
    Tool : TSubChartTool;

    function CurrentChart:TSubChart;
    function CurrentChartName:String;
    procedure EnableButtons;
    procedure SwapChart(A,B:Integer);
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
  TeePenDlg, TeeProCo, TeeConst;
  
type
  TInnerChart=class(TChart)
  private
    IParent : TSubChart;
  protected
    procedure ReadState(Reader: TReader); override;

  {$IFDEF CLR}
  public
  {$ENDIF}
    
    Function GetParentComponent: TComponent; override;
    Function HasParent:Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
  public
    Constructor Create(AOwner:TComponent); override;

    procedure Invalidate; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property BevelOuter default bvNone;
    property Color default clNone;
    property MarginBottom default 0;
    property MarginLeft default 0;
    property MarginRight default 0;
    property MarginTop default 0;
  end;

{ TInnerChart }

Constructor TInnerChart.Create(AOwner:TComponent);
begin
  inherited;

  Legend.Hide;
  Title.Hide;
  Foot.Hide;
  SubTitle.Hide;
  SubFoot.Hide;

  MarginLeft:=0;
  MarginTop:=0;
  MarginRight:=0;
  MarginBottom:=0;

  BevelOuter:=bvNone;
  Color:=clNone;
end;

procedure TInnerChart.Invalidate;
begin
  if Assigned(IParent) then
     IParent.ITool.Repaint;
end;

function TInnerChart.HasParent: Boolean;
begin
  result:=True;
end;

procedure TInnerChart.ReadState(Reader: TReader);
begin
  inherited;

  if Reader.Parent is TSubChartTool then
     SetParentComponent(TSubChartTool(Reader.Parent));
end;

function TInnerChart.GetParentComponent: TComponent;
begin
  result:=IParent.ITool;
end;

procedure TInnerChart.SetParentComponent(AParent: TComponent);
begin
  if Assigned(AParent) and (AParent is TSubChartTool) then
     if (not Assigned(IParent)) or
        (IParent.ITool<>AParent) or
        (Assigned(IParent) and (IParent.FChart<>Self)) then
     begin
       Self.IParent.ITool:=TSubChartTool(AParent);
       FreeAndNil(IParent.FChart);
       IParent.FChart:=Self;
     end;
end;

{ TSubChart }

Constructor TSubChartTool.Create(AOwner: TComponent);
begin
  inherited;
  FCharts:=TChartCollection.Create(Self,TSubChart);
end;

Destructor TSubChartTool.Destroy;
begin
  FCharts.Free;
  inherited;
end;

procedure TSubChartTool.Assign(Source: TPersistent);
begin
  if Source is TSubChartTool then
  with TSubChartTool(Source) do
  begin
    Self.Charts:=Charts;
  end;

  inherited;
end;

procedure TSubChartTool.ChartEvent(AEvent: TChartToolEvent);
var t : Integer;
begin
  inherited;

  if Active and (AEvent=cteAfterDraw) then
     for t:=0 to Charts.Count-1 do
     with Charts[t] do
     begin
       // NOT A GOOD IDEA: Chart.View3D:=Self.ParentChart.View3D;

       Chart.BufferedDisplay:=False;
       Chart.Draw(Self.ParentChart.Canvas.ReferenceCanvas,Bounds);
     end;
end;

type
  TChartAccess=class(TChart);

procedure TSubChartTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var t : Integer;
begin
  if Active then
  begin

    for t:=0 to Charts.Count-1 do
    with Charts[t] do
    begin
      if PtInRect(Bounds,TeePoint(X,Y)) then
      begin
        Chart.Canvas.ReferenceCanvas:=Self.ParentChart.Canvas.ReferenceCanvas;

        case AEvent of
          cmeDown: TChartAccess(FChart).MouseDown(Button,Shift,X,Y);
          cmeMove: TChartAccess(FChart).MouseMove(Shift,X,Y);
            cmeUp: TChartAccess(FChart).MouseUp(Button,Shift,X,Y);
        end;

        Self.ParentChart.CancelMouse:=FChart.CancelMouse or FChart.Zoom.Active
                                      or FChart.IPanning.Active;

        if Self.ParentChart.CancelMouse then
           break;
      end;
    end;

  end
  else inherited;
end;

function TSubChart.GetChart:TChart;
begin
  if not Assigned(FChart) then
  begin
    FChart:=TInnerChart.Create(nil);
    TInnerChart(FChart).IParent:=Self;
    FChart.BoundsRect:=TeeRect(50,50,200,150);
  end;

  result:=FChart;
end;

class function TSubChartTool.Description: String;
begin
  result:=TeeMsg_SubChartTool;
end;

class function TSubChartTool.GetEditorClass: String;
begin
  result:='TSubChartEditor';
end;

class function TSubChartTool.LongDescription: String;
begin
  result:=TeeMsg_SubChartDesc;
end;

procedure TSubChartEditor.FormShow(Sender: TObject);
var t : Integer;
begin
  Tool:=TSubChartTool(Tag);

  LBCharts.Items.Clear;

  if Assigned(Tool) then
  begin
    for t:=0 to Tool.Charts.Count-1 do
    if Tool.Charts[t].Chart.Name='' then
       LBCharts.Items.Add('Chart'+IntToStr(t+1))
    else
       LBCharts.Items.Add(Tool.Charts[t].Chart.Name);
  end;

  if LBCharts.Items.Count>0 then
     LBCharts.ItemIndex:=0;

  LBChartsClick(Self);
end;

procedure TSubChartTool.SetCharts(const Value: TChartCollection);
begin
  FCharts.Assign(Value);
end;

procedure TSubChartTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  Repaint;
end;

function TSubChart.GetBounds: TRect;
begin
  result:=Chart.BoundsRect;
end;

procedure TSubChart.SetChart(const Value: TChart);
begin
  Chart.Assign(Value);
end;

{$IFNDEF CLR}
type
  TOwnedCollectionAccess=class(TOwnedCollection);
{$ENDIF}

{ TSubChart }

Constructor TSubChart.Create(Collection: TCollection);
begin
  inherited;

  if Assigned(Collection) then
     {$IFDEF CLR}
     ITool:=TSubChartTool(Collection.Owner);
     {$ELSE}
     ITool:=TSubChartTool(TOwnedCollectionAccess(Collection).GetOwner);
     {$ENDIF}

  if (not Assigned(ITool)) or
     (not (csLoading in ITool.ComponentState)) then
          GetChart;
end;

Destructor TSubChart.Destroy;
begin
  FreeAndNil(FChart);
  inherited;
end;

procedure TSubChart.Assign(Source: TPersistent);
begin
  if Source is TSubChart then
     Chart.Assign(TSubChart(Source).Chart);

  inherited;
end;

procedure TSubChartEditor.LBChartsClick(Sender: TObject);
begin
  // First thing to do is to enable pagecontrol tabs, etc.
  EnableButtons;

  // Then recreate editor panel
  FreeAndNil(ChartEditor);

  if LBCharts.ItemIndex<>-1 then
  begin
    ChartEditor:=TChartEditorPanel.Create(Self);
    ChartEditor.Editor.Tree.Hide;
    ChartEditor.Align:=alClient;
    ChartEditor.Parent:=TabChart;
    ChartEditor.Chart:=CurrentChart.Chart;

    with CurrentChart.Chart do
    begin
      UDLeft.Position:=Left;
      UDTop.Position:=Top;
      UDWidth.Position:=Width;
      UDHeight.Position:=Height;
      CBTransp.Checked:=Color=clNone;
    end;

    if Showing then
       PageControl1Change(Self);
  end;
end;

function TSubChart.GetHeight: Integer;
begin
  result:=Chart.Height;
end;

function TSubChart.GetLeft: Integer;
begin
  result:=Chart.Left;
end;

function TSubChart.GetTop: Integer;
begin
  result:=Chart.Top;
end;

function TSubChart.GetWidth: Integer;
begin
  result:=Chart.Width;
end;

procedure TSubChart.SetHeight(const Value: Integer);
begin
  Chart.Height:=Value;
end;

procedure TSubChart.SetLeft(const Value: Integer);
begin
  Chart.Left:=Value;
end;

procedure TSubChart.SetTop(const Value: Integer);
begin
  Chart.Top:=Value;
end;

procedure TSubChart.SetWidth(const Value: Integer);
begin
  Chart.Width:=Value;
end;

procedure TSubChart.ReadChart(Stream: TStream);
begin
  FreeAndNil(FChart);
  GetChart;

  FChart:=Stream.ReadComponent(FChart) as TInnerChart;
  TInnerChart(FChart).IParent:=Self;
end;

procedure TSubChart.WriteChart(Stream: TStream);
begin
  Stream.WriteComponent(Chart);
end;

procedure TSubChart.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('InnerChart',ReadChart,WriteChart,True);
end;

{ TChartCollection }

function TChartCollection.AddChart(const AName: String=''): TChart;
begin
  result:=(Add as TSubChart).Chart;
  result.Name:=AName;
end;

function TChartCollection.Get(Index: Integer): TSubChart;
begin
  result:=TSubChart(inherited Items[Index]);
end;

procedure TChartCollection.Put(Index: Integer; const Value: TSubChart);
begin
  inherited Items[Index]:=Value;
end;

procedure TSubChartEditor.FormCreate(Sender: TObject);
begin
  TeeLoadArrowBitmaps(BUp.Glyph,BDown.Glyph);

  {$IFDEF D6}
  {$IFNDEF CLX}
  {$IFNDEF LCL}
  LBCharts.BevelInner:=bvNone;
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
end;

procedure TSubChartEditor.BAddClick(Sender: TObject);
var tmp : String;
begin
  tmp:='Chart'+IntToStr(Tool.Charts.Count+1);

  if InputQuery(TeeMsg_NewChart,TeeMsg_ChartName,tmp) then
  begin
    (Tool.Charts.Add as TSubChart).Chart.Name:=tmp;
    LBCharts.Items.Add(tmp);
    LBCharts.ItemIndex:=LBCharts.Items.Count-1;
    LBChartsClick(Self);
  end;
end;

procedure TSubChartEditor.EnableButtons;
begin
  PageControl1.Enabled:=LBCharts.Items.Count>0;

  TabPosition.TabVisible:=PageControl1.Enabled;
  TabChart.TabVisible:=PageControl1.Enabled;

  EnableControls(PageControl1.Enabled,
                  [UDLeft,UDTop,UDWidth,UDHeight,
                   LLeft,LTop,LWidth,LHeight]);

  BUp.Enabled:=LBCharts.ItemIndex>0;
  BDown.Enabled:=LBCharts.ItemIndex<LBCharts.Items.Count-1;
  BDelete.Enabled:=LBCharts.ItemIndex<>-1;
  BRename.Enabled:=BDelete.Enabled;
end;

function TSubChartEditor.CurrentChart:TSubChart;
begin
  result:=Tool.Charts[LBCharts.ItemIndex];
end;

function TSubChartEditor.CurrentChartName:String;
begin
  result:=CurrentChart.Chart.Name;

  if result='' then
     result:='Chart'+IntToStr(LBCharts.ItemIndex+1);
end;

procedure TSubChartEditor.BDeleteClick(Sender: TObject);
begin
  if TeeYesNoDelete(CurrentChartName) then
  begin
    CurrentChart.Free;
    LBCharts.Items.Delete(LBCharts.ItemIndex);
    LBChartsClick(Self);
  end;
end;

procedure TSubChartEditor.SwapChart(A,B:Integer);
var tmp : TSubChart;
begin
  LBCharts.Items.Exchange(A,B);
  tmp:=Tool.Charts[B];
  Tool.Charts[A].Index:=B;
  tmp.Index:=A;
  EnableButtons;
end;

procedure TSubChartEditor.BUpClick(Sender: TObject);
begin
  with LBCharts do
  if ItemIndex>0 then
     SwapChart(ItemIndex,ItemIndex-1);
end;

procedure TSubChartEditor.BDownClick(Sender: TObject);
begin
  with LBCharts do
  if (ItemIndex<>-1) and (ItemIndex<Items.Count-1) then
     SwapChart(ItemIndex,ItemIndex+1);
end;

procedure TSubChartEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     CurrentChart.Chart.Left:=UDLeft.Position;
end;

procedure TSubChartEditor.Edit2Change(Sender: TObject);
begin
  if Showing then
     CurrentChart.Chart.Top:=UDTop.Position;
end;

procedure TSubChartEditor.Edit3Change(Sender: TObject);
begin
  if Showing then
     CurrentChart.Chart.Width:=UDWidth.Position;
end;

procedure TSubChartEditor.Edit4Change(Sender: TObject);
begin
  if Showing then
     CurrentChart.Chart.Height:=UDHeight.Position;
end;

procedure TInnerChart.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  Invalidate;
end;

procedure TSubChartEditor.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage=TabChart then
     if TabChart.Controls[0] is TChartEditorPanel then
     begin
       TabChart.Controls[0].Show;
       TChartEditorPanel(TabChart.Controls[0]).Editor.Show;
     end;
end;

procedure TSubChartEditor.BRenameClick(Sender: TObject);
var tmp : String;
begin
  tmp:=CurrentChartName;

  if InputQuery(TeeMsg_RenameChart,TeeMsg_NewName,tmp) then
  begin
    CurrentChart.Chart.Name:=tmp;
    LBCharts.Items[LBCharts.ItemIndex]:=tmp;
  end;
end;

procedure TSubChartEditor.CBTranspClick(Sender: TObject);
begin
  if CBTransp.Checked then
  begin
    CurrentChart.Chart.Color:=clNone;
    CurrentChart.Chart.Gradient.Visible:=False;
  end
  else
    CurrentChart.Chart.Color:=clBtnFace;
end;

initialization
  RegisterClass(TInnerChart);
  RegisterClass(TSubChartEditor);
  RegisterTeeTools([TSubChartTool]);
finalization
  UnRegisterTeeTools([TSubChartTool]);
end.

