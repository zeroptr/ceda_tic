{**********************************************}
{   TOrgSeries Organizational Charts           }
{   Copyright (c) 2009 by Steema Software      }
{**********************************************}
unit TeeOrgSeries;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes, SysUtils, Math,
  {$IFDEF CLX}
  QStdCtrls, QControls, QButtons, QExtCtrls, QComCtrls, QForms, QGraphics,
  {$ELSE}
  StdCtrls, Controls, Buttons, ExtCtrls, ComCtrls, Forms, Graphics,
  {$ENDIF}
  TeCanvas, TeEngine, Chart, TeeTools, TeeConst, TeePenDlg, TeeComma, TeeProcs,
  TeeCustomShapeEditor, TeeStringsEditor, TeeMargins;

type
  TOrgSeries=class;  // forward

  TOrgShape=class(TTextShape)
  published
    property CustomPosition default True;
    property Left stored False;
    property Top stored False;
    property TextAlignment default taCenter;
  end;

  TOrgItem=class(TCollectionItem)
  private
    FFormat : TOrgShape;

    function GetSuperior: Integer;
    function GetText: String;
    procedure SetFormat(const Value: TOrgShape);
    procedure SetSuperior(const Value: Integer);
    procedure SetText(const Value: String);
  public
    Constructor Create(Collection: TCollection); override;
    Destructor Destroy; override;

    function AddChild(const Text:String):TOrgItem;
    function AddBrother(const Text:String):TOrgItem;
    procedure Assign(Source:TPersistent); override;
    function Series:TOrgSeries;

    property Superior:Integer read GetSuperior write SetSuperior stored False;
    property Text:String read GetText write SetText stored False;
  published
    property Format:TOrgShape read FFormat write SetFormat;
  end;

  TOrgItemCollection=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TOrgItem;
    Procedure Put(Index:Integer; Const Value:TOrgItem);
  public
    property Items[Index:Integer]:TOrgItem read Get write Put; default;
  end;

  TSpacing=class(TPersistent)
  private
    FVert: Integer;
    FHoriz: Integer;

    ISeries : TChartSeries;

    procedure SetHoriz(const Value: Integer);
    procedure SetVert(const Value: Integer);
  public
    Constructor Create;
    procedure Assign(Source:TPersistent); override;
  published
    property Horizontal:Integer read FHoriz write SetHoriz default 8;
    property Vertical:Integer read FVert write SetVert default 16;
  end;

  TOrgLineStyle=(lsSquared,lsDiagonal);

  TOrgSeries=class(TChartSeries)
  private
    FDefault   : TOrgShape;
    FLineStyle : TOrgLineStyle;
    FNodes     : TOrgItemCollection;
    FSpacing   : TSpacing;

    IBounds    : TRect;
    procedure AddNode(const AText:String);
    procedure GetChilds(List:TList; Superior:Integer; VisibleOnly:Boolean);
    function GetItem(Index: Integer): TOrgItem;
    procedure SetDefault(const Value: TOrgShape);
    procedure SetItem(Index: Integer; const Value: TOrgItem);
    procedure SetLineStyle(const Value: TOrgLineStyle);
    procedure SetNodes(const Value: TOrgItemCollection);
    procedure SetSpacing(const Value: TSpacing);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    procedure ClearLists; override;
    procedure DrawAllValues; override;
    class Function GetEditorClass:String; override;
    procedure Loaded; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    function Add(const Text:String; Superior:Integer=-1):Integer; overload;
    Function AddXY(Const AXValue,AYValue:Double; Const ALabel:String='';
                         AColor:TColor=clTeeColor):Integer; override;
    procedure Assign(Source:TPersistent); override;
    Function CalcXPos(ValueIndex:Integer):Integer; override;
    Function CalcYPos(ValueIndex:Integer):Integer; override;
    Function Clicked(x,y:Integer):Integer; override;
    procedure Delete(ValueIndex:Integer); override;
    function FirstChild(ValueIndex:Integer):Integer;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    procedure SwapValueIndex(a,b:Integer); override;
    Function UseAxis:Boolean; override;

    property Bounds:TRect read IBounds;
    property Item[Index:Integer]:TOrgItem read GetItem write SetItem; default;
  published
    { Published declarations }
    property Active;
    property ColorSource;
    property Cursor;
    property HorizAxis;
    property Marks;
    property ParentChart;
    property DataSource;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend default False;
    property Title;
    property ValueFormat;
    property VertAxis;
    property XLabelsSource;

    property Brush;
    property Pen;

    property Format:TOrgShape read FDefault write SetDefault;
    property Items:TOrgItemCollection read FNodes write SetNodes;
    property LineStyle:TOrgLineStyle read FLineStyle write SetLineStyle default lsSquared;
    property Spacing:TSpacing read FSpacing write SetSpacing;

    property XValues;
    property YValues;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnGetMarkText;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

  TOrgSeriesEditor = class(TForm)
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ButtonPen1: TButtonPen;
    Panel3: TPanel;
    LBNodes: TListBox;
    PageControl1: TPageControl;
    TabText: TTabSheet;
    Label3: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    ComboFlat1: TComboFlat;
    CBCursor: TComboFlat;
    Button1: TButton;
    Splitter1: TSplitter;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    TabSheet3: TTabSheet;
    CBAutoSize: TCheckBox;
    Label14: TLabel;
    Label15: TLabel;
    ECustWidth: TEdit;
    ECustHeight: TEdit;
    UDWidth: TUpDown;
    UDHeight: TUpDown;
    CBClip: TCheckBox;
    CBVisible: TCheckBox;
    Label2: TLabel;
    CBLineStyle: TComboFlat;
    Label4: TLabel;
    Label5: TLabel;
    TabMargins: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure ComboFlat1Change(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LBNodesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ECustWidthChange(Sender: TObject);
    procedure ECustHeightChange(Sender: TObject);
    procedure CBAutoSizeClick(Sender: TObject);
    procedure CBClipClick(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure CBLineStyleChange(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
  private
    { Private declarations }
    Series      : TOrgSeries;
    NodeEditor  : TFormTeeShape;
    MarginsForm : TMarginsEditor;
    IChanging   : Boolean;

    procedure AddListNodes(Series:TOrgSeries; Current:Integer);
    function CurrentIndex:Integer;
    function CurrentItem:TOrgItem;
    procedure SetupEditor(ASeries:TOrgSeries);
  public
    { Public declarations }
    procedure RefreshNode(Index:Integer);
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
  TeeLegendScrollBar, TeeProCo;

type
  TPanelScrollBar=class(TTeeScrollBar)
  private
  protected
    function CurrentCount:Integer; override;
    function DeltaMain: Integer; override;
    function GetPosition:Integer; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    procedure SetPosition(Value:Integer); override;
    function ShouldDraw(var R:TRect):Boolean; override;
    function TotalCount:Integer; override;
  public
    Destructor Destroy; override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  end;

{
var h, v : TPanelScrollBar;

  v:=TPanelScrollBar.Create(Self);
  v.ParentChart:=Chart1;
  v.Horizontal:=False;

  h:=TPanelScrollBar.Create(Self);
  h.ParentChart:=Chart1;
  h.Horizontal:=True;
}

{ TPanelScrollBar }
function TPanelScrollBar.CurrentCount: Integer;
begin
  if Horizontal then
     result:=ParentChart.ChartWidth
  else
     result:=ParentChart.ChartHeight;
end;

function TPanelScrollBar.DeltaMain: Integer;
begin
  result:=0;
end;

class function TPanelScrollBar.Description: String;
begin
  result:='ScrollBar';
end;

Destructor TPanelScrollBar.Destroy;
begin
  inherited;
end;

function TPanelScrollBar.GetPosition: Integer;
begin
  if Horizontal then
     result:=ParentChart.View3DOptions.HorizOffset
  else
     result:=ParentChart.View3DOptions.VertOffset;
end;

class function TPanelScrollBar.LongDescription: String;
begin
  result:='ScrollBar';
end;

procedure TPanelScrollBar.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
end;

procedure TPanelScrollBar.SetPosition(Value: Integer);
begin
  if Horizontal then
     ParentChart.View3DOptions.HorizOffset:=Value
  else
     ParentChart.View3DOptions.VertOffset:=Value;

  inherited;
end;

function TPanelScrollBar.ShouldDraw(var R: TRect): Boolean;
begin
  R:=ParentChart.ChartBounds;

  if Horizontal then
  begin
    Dec(R.Bottom, Size);
    Dec(R.Right, Size);
  end
  else
  begin
    Dec(R.Bottom, Size-1);
  end;

  result:=True;
end;

function TPanelScrollBar.TotalCount: Integer;
begin
  result:=CurrentCount+10;
end;

{ TOrgSeries }
Constructor TOrgSeries.Create(AOwner: TComponent);
begin
  inherited;

  CalcVisiblePoints:=False;

  FNodes:=TOrgItemCollection.Create(Self,TOrgItem);

  FDefault:=TOrgShape.Create(nil);
  FDefault.TextAlignment:=taCenter;

  FSpacing:=TSpacing.Create;
  FSpacing.ISeries:=Self;

  Pen.EndStyle:=esSquare;
  ShowInLegend:=False;

  if (csDesigning in ComponentState) and
     (not (csLoading in ComponentState)) then
          FillSampleValues;

  ManualData:=True;
end;

Destructor TOrgSeries.Destroy;
begin
  FreeAndNil(FDefault);
  FreeAndNil(FNodes);
  FSpacing.Free;
  inherited;
end;

procedure TOrgSeries.AddNode(const AText:String);
var tmp : TOrgShape;
begin
  tmp:=TOrgItem(FNodes.Add).FFormat;
  tmp.Assign(FDefault);
  tmp.Text:=AText;
end;

function TOrgSeries.Add(const Text:String; Superior:Integer=-1):Integer;
begin
  result:=inherited Add(Superior,Text);
end;

Function TOrgSeries.AddXY(Const AXValue,AYValue:Double; Const ALabel:String='';
                          AColor:TColor=clTeeColor):Integer;
begin
  result:=inherited AddXY(AXValue,AYValue,ALabel,AColor);

  while Items.Count<Count-1 do
        AddNode('');

  if Items.Count=Count-1 then
     AddNode(ALabel);
end;

procedure TOrgSeries.Assign(Source: TPersistent);
begin
  // Important: Call inherited before anything else, to avoid losing the nodes.
  inherited;

  if Source is TOrgSeries then
  with TOrgSeries(Source) do
  begin
    Self.FNodes.Assign(FNodes);
    Self.FLineStyle:=FLineStyle;
    Self.FSpacing.FVert:=FSpacing.FVert;
    Self.FSpacing.FHoriz:=FSpacing.FHoriz;
  end;
end;

procedure TOrgSeries.GetChilds(List:TList; Superior:Integer; VisibleOnly:Boolean);
var t : Integer;
begin
  List.Clear;

  for t:=0 to Min(FNodes.Count,Count)-1 do
  if (MandatoryValueList.Value[t]=Superior) and
     ((not VisibleOnly) or FNodes[t].FFormat.Visible) then
           List.Add({$IFDEF CLR}TObject{$ELSE}Pointer{$ENDIF}(t));
end;

{$IFNDEF CLR}
type
  TFormatAccess=class(TTextShape);
{$ENDIF}

procedure TOrgSeries.DrawAllValues;

  procedure DrawNodes(Parent,XPos,YPos:Integer);

    procedure DrawChilds(List:TList; XPos,YPos:Integer);

      function GetTreeWidth(List:TList):Integer;
      var t : Integer;
          tmp : Integer;
          IFormat : TTextShape;
          //List2 : TList;
      begin
        result:=Spacing.Horizontal*(List.Count-1);

        tmp:=0;

        for t:=0 to List.Count-1 do
        begin
          IFormat:=TOrgItem(FNodes.Items[Integer(List[t])]).FFormat;

          {
          GetChilds(List2,Integer(List[t]));
          tmp:=Max(tmp,GetTreeWidth(List2));
          }
          with IFormat.ShapeBounds do
               Inc(result,Max(Right-Left+1,tmp));
        end;
      end;

      function ChildCount(Index:Integer):Integer;
      var t : Integer;
      begin
        result:=0;

        for t:=0 to Count-1 do
            if MandatoryValueList.Value[t]=Index then
               Inc(result);
      end;

    var tmpR : TRect;
        maxH,
        maxW,
        tmpLeft,
        tmp,
        tmpX0,
        tmpX1,
        tmpY,
        tmpSup,
        tmpX,
        t : Integer;
        IFormat : TTextShape;
        tmpRoots : TList;
    begin
      // Calc total width
      maxW:=GetTreeWidth(List);

      IBounds.Top:=Min(IBounds.Top,YPos);

      for t:=0 to List.Count-1 do
      begin
        IFormat:=TOrgItem(FNodes.Items[Integer(List[t])]).FFormat;
        tmp:=IFormat.Height;
        IFormat.Top:=YPos+ParentChart.View3DOptions.VertOffset;
        IFormat.Height:=tmp;
      end;

      tmpLeft:=XPos-(maxW div 2)+ParentChart.View3DOptions.HorizOffset;

      IBounds.Left:=Min(IBounds.Left,tmpLeft);

      maxH:=0;

      tmpX0:=0;
      tmpX1:=0;

      tmpY:=0;

      for t:=0 to List.Count-1 do
      begin
        IFormat:=TOrgItem(FNodes.Items[Integer(List[t])]).FFormat;

        tmp:=IFormat.Width;
        IFormat.Left:=tmpLeft;
        IFormat.Width:=tmp;

        tmpR:=IFormat.ShapeBounds;

        if t=0 then
           tmpX0:=tmpLeft+((tmpR.Right-tmpR.Left) div 2)
        else
        if t=List.Count-1 then
           tmpX1:=tmpLeft+((tmpR.Right-tmpR.Left) div 2);

        tmpSup:=Round(MandatoryValueList.Value[Integer(List[t])]);

        if tmpSup<>-1 then
        begin
          ParentChart.Canvas.AssignVisiblePen(Pen);

          if LineStyle=lsSquared then
          begin
            if ChildCount(tmpSup)=1 then
               tmpY:=CalcYPos(tmpSup)
            else
               tmpY:=IFormat.Top-(Spacing.Vertical div 2);

            ParentChart.Canvas.DoVertLine(tmpLeft+((tmpR.Right-tmpR.Left) div 2),
                                           tmpY,IFormat.Top)
          end
          else
          begin
            if ChildCount(tmpSup)=1 then
               tmpX:=CalcXPos(tmpSup)
            else
               tmpX:=tmpLeft+((tmpR.Right-tmpR.Left) div 2);

            ParentChart.Canvas.Line(tmpX,IFormat.Top,CalcXPos(tmpSup),CalcYPos(tmpSup));
          end;
        end;

        {$IFNDEF CLR}TFormatAccess{$ENDIF}(IFormat).DrawText(ParentChart,IFormat.ShapeBounds,0,
                      {$IFNDEF CLR}TFormatAccess{$ENDIF}(IFormat).INumLines);

        maxH:=Math.Max(maxH,tmpR.Bottom-tmpR.Top+1);

        Inc(tmpLeft,tmpR.Right-tmpR.Left+1);

        if t<List.Count-1 then
           Inc(tmpLeft,Spacing.Horizontal)
        else
        with IFormat.Shadow do
        if Visible and (HorizSize>0) then
           Inc(tmpLeft,HorizSize);

        with IFormat.Shadow do
        if Visible and (VertSize>0) then
           IBounds.Bottom:=Max(IBounds.Bottom,tmpR.Bottom+VertSize)
        else
           IBounds.Bottom:=Max(IBounds.Bottom,tmpR.Bottom);
      end;

      IBounds.Right:=Max(IBounds.Right,tmpLeft);

      if LineStyle=lsSquared then
        if List.Count>1 then
        begin
          ParentChart.Canvas.AssignVisiblePen(Pen);
          ParentChart.Canvas.DoHorizLine(tmpX0,tmpX1,tmpY);
        end;

      for t:=0 to List.Count-1 do
      begin
        IFormat:=TOrgItem(FNodes.Items[Integer(List[t])]).FFormat;

        with IFormat.ShapeBounds do
             XPos:=(Left+Right) div 2;

        tmpRoots:=TList.Create;
        try
          GetChilds(tmpRoots,Integer(List[t]),True);

          if tmpRoots.Count>0 then
          begin
            if tmpRoots.Count>1 then
            if LineStyle=lsSquared then
            begin
              ParentChart.Canvas.AssignVisiblePen(Pen);
              tmpY:=IFormat.ShapeBounds.Bottom;
              ParentChart.Canvas.DoVertLine(XPos,tmpY,YPos+maxH+(Spacing.Vertical div 2));
            end;

            DrawChilds(tmpRoots,XPos,YPos+maxH+Spacing.Vertical);
          end;
        finally
          tmpRoots.Free;
        end;
      end;
    end;

  var tmpRoots : TList;
  begin
    tmpRoots:=TList.Create;
    try
      GetChilds(tmpRoots,Parent,True);
      DrawChilds(tmpRoots, XPos, YPos);
    finally
      tmpRoots.Free;
    end;
  end;

  procedure AutoSizeNodes;
  var t : Integer;
      tmp : TTextShape;
  begin
    for t:=0 to Min(FNodes.Count,Count)-1 do
    begin
      tmp:=FNodes[t].FFormat;
      tmp.Text:=XLabel[t];

      if tmp.AutoSize then
         {$IFNDEF CLR}TFormatAccess{$ENDIF}(tmp).CalcBounds(ParentChart);
    end;
  end;

begin
  with IBounds do
  begin
    Top:=MaxLongint;
    Left:=MaxLongint;
    Right:=-MaxLongint;
    Bottom:=-MaxLongint;
  end;

  AutoSizeNodes;
  DrawNodes(-1, ParentChart.ChartXCenter, ParentChart.ChartRect.Top);
end;

Function TOrgSeries.Clicked(x,y:Integer):Integer;
var t : Integer;
begin
  result:=TeeNoPointClicked;

  for t:=0 to Min(FNodes.Count,Count)-1 do
  if PointInRect(FNodes[t].FFormat.ShapeBounds,x,y) then
  begin
    result:=t;
    break;
  end;
end;

function TOrgSeries.UseAxis: Boolean;
begin
  result:=False;
end;

function TOrgSeries.IsValidSourceOf(Value: TChartSeries): Boolean;
begin
  result:=Value is TOrgSeries;
end;

procedure TOrgSeries.AddSampleValues(NumValues: Integer;
  OnlyMandatory: Boolean);

const
  MaxNames=8;

  Names:Array[0..MaxNames] of String=
    ('John','Anne','Mary','Paul','Bob','Mike','Lisa','Brad','Peter');

  SurNames:Array[0..MaxNames] of String=
    ('Smith','Shane','Wizard','Smart','Best','Patson','Hood','Dale','Scarlet');

  function RandomName:String;
  begin
    result:=Names[Random(MaxNames+1)]+' '+SurNames[Random(MaxNames+1)]+TeeLineSeparator;
  end;

var tmp,
    tmp1 : Integer;
begin
  tmp:=Add(RandomName+'President');
         Add(RandomName+'Sales Director',tmp);
   tmp1:=Add(RandomName+'Product Manager'#13'USA',tmp);
          Add(RandomName+'Asian Sales',tmp1);
   tmp1:=Add(RandomName+'Human Relations',tmp);
          Add(RandomName+'Assistant',tmp1);
end;

procedure TOrgSeries.SetSpacing(const Value: TSpacing);
begin
  FSpacing.Assign(Value);
end;

procedure TOrgSeries.ClearLists;
begin
  inherited;

  if not (csLoading in ComponentState) then
     if Assigned(FNodes) then
        FNodes.Clear;
end;

procedure TOrgSeries.SwapValueIndex(a,b:Integer);
var tmp : TCollectionItem;
begin
  inherited;
  tmp:=FNodes.Items[b];
  FNodes.Items[a].Index:=b;
  tmp.Index:=a;
end;

procedure TOrgSeries.Loaded;
var tmp : TOrgItem;
begin
  inherited;

  while FNodes.Count<Count do
  begin
    tmp:=TOrgItem(FNodes.Add);
    tmp.FFormat.Assign(FDefault);
    tmp.FFormat.Text:=XLabel[FNodes.Count-1];
  end;
end;

function TOrgSeries.FirstChild(ValueIndex:Integer):Integer;
begin
  for result:=0 to Count-1 do
  if MandatoryValueList.Value[result]=ValueIndex then
     Exit;

  result:=-1;
end;

procedure TOrgSeries.Delete(ValueIndex:Integer);
var tmp : Integer;
begin
  // Cascade deleting of child nodes, recursive
  repeat
    tmp:=FirstChild(ValueIndex);
    if tmp<>-1 then
       Delete(tmp);
  until tmp=-1;

  inherited;

  if FNodes.Count>ValueIndex then
     FNodes[ValueIndex].Free;

  with MandatoryValueList do
  for tmp:=0 to Count-1 do
  if Value[tmp]>ValueIndex then
     Value[tmp]:=Value[tmp]-1;
end;

class function TOrgSeries.GetEditorClass: String;
begin
  result:='TOrgSeriesEditor';
end;

procedure TOrgSeries.SetNodes(const Value: TOrgItemCollection);
begin
  FNodes.Assign(Value);
end;

function TOrgSeries.GetItem(Index: Integer): TOrgItem;
begin
  result:=FNodes.Items[Index];
end;

procedure TOrgSeries.SetDefault(const Value: TOrgShape);
begin
  FDefault.Assign(Value);
end;

procedure TOrgSeries.SetItem(Index: Integer; const Value: TOrgItem);
begin
  FNodes.Items[Index]:=Value;
end;

procedure TOrgSeries.SetParentChart(const Value: TCustomAxisPanel);
var t : Integer;
begin
  inherited;

  if Assigned(FNodes) then
  for t:=0 to Items.Count-1 do
      Items[t].FFormat.ParentChart:=Value;
end;

function TOrgSeries.CalcXPos(ValueIndex: Integer): Integer;
begin
  with FNodes[ValueIndex].FFormat.ShapeBounds do
       result:=(Left+Right) div 2;
end;

function TOrgSeries.CalcYPos(ValueIndex: Integer): Integer;
begin
  result:=FNodes[ValueIndex].FFormat.ShapeBounds.Bottom;
end;

procedure TOrgSeries.SetLineStyle(const Value: TOrgLineStyle);
begin
  if FLineStyle<>Value then
  begin
    FLineStyle:=Value;
    Repaint;
  end;
end;

{ TSpacing }
Constructor TSpacing.Create;
begin
  inherited;
  FHoriz:=8;
  FVert:=16;
end;

procedure TSpacing.Assign(Source: TPersistent);
begin
  if Source is TSpacing then
  with TSpacing(Source) do
  begin
    Self.FHoriz:=FHoriz;
    Self.FVert:=FVert;
  end
  else
    inherited;
end;

procedure TSpacing.SetHoriz(const Value: Integer);
begin
  if FHoriz<>Value then
  begin
    FHoriz:=Value;
    ISeries.Repaint;
  end;
end;

procedure TSpacing.SetVert(const Value: Integer);
begin
  if FVert<>Value then
  begin
    FVert:=Value;
    ISeries.Repaint;
  end;
end;

{ TOrgItem }
Constructor TOrgItem.Create(Collection: TCollection);
begin
  inherited;
  FFormat:=TOrgShape.Create(nil);
  FFormat.TextAlignment:=taCenter;
  FFormat.ParentChart:=Series.ParentChart;
end;

Destructor TOrgItem.Destroy;
begin
  FreeAndNil(FFormat);
  inherited;
end;

procedure TOrgItem.Assign(Source: TPersistent);
begin
  if Source is TOrgItem then
     Format:=TOrgItem(Source).Format
  else
     inherited;
end;

{$IFNDEF CLR}
type
  TOwnedCollectionAccess=class(TOwnedCollection);
{$ENDIF}

function TOrgItem.Series:TOrgSeries;
begin
  {$IFDEF CLR}
  result:=TOrgSeries(Collection.Owner);
  {$ELSE}
  result:=TOrgSeries(TOwnedCollectionAccess(Collection).GetOwner);
  {$ENDIF}
end;

procedure TOrgItem.SetFormat(const Value: TOrgShape);
begin
  FFormat.Assign(Value);
end;

function TOrgItem.GetText: String;
begin
  result:=Series.XLabel[Index];
end;

procedure TOrgItem.SetText(const Value: String);
begin
  Series.XLabel[Index]:=Value;
end;

function TOrgItem.AddChild(const Text: String): TOrgItem;
begin
  result:=Series[Series.Add(Text,Index)];
end;

function TOrgItem.AddBrother(const Text: String): TOrgItem;
begin
  result:=Series[Series.Add(Text,Superior)];
end;

function TOrgItem.GetSuperior: Integer;
begin
  result:=Round(Series.MandatoryValueList[Index]);
end;

procedure TOrgItem.SetSuperior(const Value: Integer);
begin
  Series.MandatoryValueList[Index]:=Value;
end;

{ TOrgItemCollection }
function TOrgItemCollection.Get(Index: Integer): TOrgItem;
begin
  result:=TOrgItem(inherited Items[Index]);
end;

procedure TOrgItemCollection.Put(Index: Integer; const Value: TOrgItem);
begin
  inherited Items[Index]:=Value;
end;

procedure TOrgSeriesEditor.FormCreate(Sender: TObject);
begin
  NodeEditor:=InsertTeeObjectForm(PageControl1,nil);

  MarginsForm:=TMarginsEditor.Create(Self);
  AddFormTo(MarginsForm,TabMargins);

  PageControl1.ActivePage:=TabText;
end;

procedure TOrgSeriesEditor.ScrollBar1Change(Sender: TObject);
begin
  Series.Spacing.Horizontal:=ScrollBar1.Position;
end;

procedure TOrgSeriesEditor.ScrollBar2Change(Sender: TObject);
begin
  Series.Spacing.Vertical:=ScrollBar2.Position;
end;

procedure TOrgSeriesEditor.Memo1Change(Sender: TObject);
begin
  if not IChanging then
  begin
    CurrentItem.Format.Text:=Memo1.Lines.Text;
    Series.XLabel[CurrentIndex]:=Memo1.Lines.Text;
    Series.Repaint;
  end;
end;

procedure TOrgSeriesEditor.ComboFlat1Change(Sender: TObject);
begin
  case ComboFlat1.ItemIndex of
    0: CurrentItem.Format.TextAlignment:=taLeftJustify;
    1: CurrentItem.Format.TextAlignment:=taCenter;
  else
    CurrentItem.Format.TextAlignment:=taRightJustify;
  end;

  Series.Repaint;
end;

procedure TOrgSeriesEditor.CBCursorChange(Sender: TObject);
begin
  with CurrentItem.Format do
       Cursor:=TeeSetCursor(Cursor,CBCursor.CurrentItem);
end;

procedure TOrgSeriesEditor.PageControl1Change(Sender: TObject);
begin
  if Assigned(NodeEditor) then
     NodeEditor.PC1Change(PageControl1);
end;

procedure TOrgSeriesEditor.SpeedButton1Click(Sender: TObject);
begin
  with Series do
  if Count=0 then
     AddListNodes(Series,Add('#'+IntToStr(Count),-1))
  else
     AddListNodes(Series,Add('#'+IntToStr(Count),CurrentItem.Index));
end;

procedure TOrgSeriesEditor.LBNodesClick(Sender: TObject);
//var t : Integer;
begin
  { Highlight selected node:
  with Series do
  for t:=0 to Count-1 do
      Items[t].Format.Gradient.Visible:= t = CurrentIndex;
  }

  with CurrentItem.Format do
  begin
    IChanging:=True;
    try
      Memo1.Lines.Text:=Text;
      UDWidth.Position:=Width;
      UDHeight.Position:=Height;
    finally
      IChanging:=False;
    end;

    CBVisible.Checked:=Visible;
    CBAutoSize.Checked:=AutoSize;
    CBClip.Checked:=ClipText;

    case TextAlignment of
      taLeftJustify: ComboFlat1.ItemIndex:=0;
      taCenter: ComboFlat1.ItemIndex:=1;
    else
      ComboFlat1.ItemIndex:=2;
    end;

    NodeEditor.RefreshControls(CurrentItem.Format);
    MarginsForm.RefreshControls(Margins);

    TeeFillCursors(CBCursor,Cursor);
  end;

  SpeedButton1.Enabled:=True;
  SpeedButton2.Enabled:=True;

  if not PageControl1.Visible then
     PageControl1.Show;
end;

procedure TOrgSeriesEditor.Button1Click(Sender: TObject);
begin
  TeeEditStrings(Self,Memo1.Lines)
end;

procedure TOrgSeriesEditor.SpeedButton2Click(Sender: TObject);
var tmp : Integer;
begin
  tmp:=CurrentIndex;
  Series.Delete(tmp);
  AddListNodes(Series,tmp-1);

  SpeedButton2.Enabled:=Series.Items.Count>0;
end;

function TOrgSeriesEditor.CurrentIndex:Integer;
begin
  result:=Integer(LBNodes.Items.Objects[LBNodes.ItemIndex]);
end;

function TOrgSeriesEditor.CurrentItem:TOrgItem;
begin
  result:=Series.Items[CurrentIndex];
end;

procedure TOrgSeriesEditor.RefreshNode(Index:Integer);
begin
  LBNodes.ItemIndex:=LBNodes.Items.IndexOfObject(TObject(Index));
  LBNodesClick(Self);
end;

procedure TOrgSeriesEditor.SetupEditor(ASeries:TOrgSeries);
begin
  Series:=ASeries;

  if Assigned(Series) then
  begin
    ScrollBar1.Position:=Series.Spacing.Horizontal;
    ScrollBar2.Position:=Series.Spacing.Vertical;
    ButtonPen1.LinkPen(Series.Pen);
    CBLineStyle.ItemIndex:=Ord(Series.LineStyle);

    AddListNodes(Series,0);
  end;
end;

procedure TOrgSeriesEditor.AddListNodes(Series:TOrgSeries; Current:Integer);

  procedure AddNodes(const Prefix:String; Parent:Integer);

    function FirstLine(const s:String):String;
    var i : Integer;
    begin
      i:=Pos(TeeLineSeparator,s);
      if i=0 then
         result:=s
      else
         result:=Copy(s,1,i-1);
    end;

  var t : Integer;
  begin
    with Series do
    for t:=0 to Items.Count-1 do
    if MandatoryValueList.Value[t]=Parent then
    begin
      LBNodes.Items.AddObject(Prefix+FirstLine(XLabel[t]),TObject(t));
      AddNodes(Prefix+' ',t);
    end;
  end;

begin
  LBNodes.Clear;
  AddNodes('',-1);

  if (Current<>-1) and (Series.Items.Count>Current) then
     RefreshNode(Current)
  else
     PageControl1.Hide;
end;

procedure TOrgSeriesEditor.FormShow(Sender: TObject);
begin
  Series:=TOrgSeries(Tag);
  SetupEditor(Series);
end;

procedure TOrgSeriesEditor.ECustWidthChange(Sender: TObject);
begin
  if (not IChanging) and (CurrentItem.Format.Width<>UDWidth.Position) then
  begin
    CurrentItem.Format.Width:=UDWidth.Position;
    CBAutoSize.Checked:=False;
    Series.Repaint;
  end;
end;

procedure TOrgSeriesEditor.ECustHeightChange(Sender: TObject);
begin
  if (not IChanging) and (CurrentItem.Format.Height<>UDHeight.Position) then
  begin
    CurrentItem.Format.Height:=UDHeight.Position;
    CBAutoSize.Checked:=False;
    Series.Repaint;
  end;
end;

procedure TOrgSeriesEditor.CBAutoSizeClick(Sender: TObject);
begin
  if not IChanging then
  begin
    CurrentItem.Format.AutoSize:=CBAutoSize.Checked;

    
    Series.Repaint;
  end;
end;

procedure TOrgSeriesEditor.CBClipClick(Sender: TObject);
begin
  CurrentItem.Format.ClipText:=CBClip.Checked;
end;

procedure TOrgSeriesEditor.CBVisibleClick(Sender: TObject);
begin
  CurrentItem.Format.Visible:=CBVisible.Checked;
  Series.Repaint;
end;

procedure TOrgSeriesEditor.CBLineStyleChange(Sender: TObject);
begin
  Series.LineStyle:=TOrgLineStyle(CBLineStyle.ItemIndex);
end;

procedure TOrgSeriesEditor.PageControl2Change(Sender: TObject);
begin
  if Assigned(Series) and (Series.Items.Count<>LBNodes.Items.Count) then
     AddListNodes(Series,0);
end;

initialization
  RegisterClass(TOrgSeriesEditor);
  RegisterTeeSeries( TOrgSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryOrgSeries,
                                 {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryExtended, 1);
finalization
  UnRegisterTeeSeries([TOrgSeries]);
end.
