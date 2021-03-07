{*****************************************}
{  TeeChart Pro - TTagCloudSeries         }
{  Copyright (c) 2009 by Steema Software  }
{*****************************************}
unit TeeTagCloud;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes, SysUtils,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  QMenus, QGrids,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Menus, Grids,
  {$ENDIF}
  TeCanvas, TeeProcs, TeEngine, Chart, TeeGriEd, TeeSurfa, TeeChartGrid, TeePenDlg,
  TeeBrushDlg, TeeEdiGrad;

type
  TTagCloudSeries=class; // forward

  TDrawTagEvent=procedure(Sender:TTagCloudSeries; ValueIndex:Integer) of object;

  TTagCloudOrder=(toText, toValue, toNone);

  TTagCloudSeries=class(TCustom3DPaletteSeries)
  private
    FFilter     : String;
    FFont       : TTeeFont;
    FGradient   : TTeeGradient;
    FSeparation : Integer;

    FOnDrawTag  : TDrawTagEvent;

    procedure SetFilter(const Value: String);
    procedure SetFont(const Value: TTeeFont);
    procedure SetGradient(const Value: TTeeGradient);
    procedure SetSeparation(const Value: Integer);
    function ShouldDraw(ValueIndex:Integer):Boolean;
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    procedure DrawAllValues; override;
    procedure GalleryChanged3D(Is3D: Boolean); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareLegendCanvas( ValueIndex:Integer; var BackColor:TColor;
                                   var BrushStyle:TBrushStyle); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
  public
    Positions : Array of TRect;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    function AddTag(const Text:String; const Value:Double):Integer;
    procedure Assign(Source:TPersistent); override;
    Function CalcXPos(ValueIndex:Integer):Integer; override;
    Function CalcYPos(ValueIndex:Integer):Integer; override;
    function Clicked(X,Y:Integer):Integer; override;
    function GetTagFontSize(ValueIndex:Integer):Integer;
    procedure Sort(SortBy: TTagCloudOrder; Order:TChartListOrder=loAscending);
    function UseAxis:Boolean; override;
  published
    // wish: BaseTextAlign:Boolean property (ie: TextAlign:=TA_BASELINE)
    
    property Filter:String read FFilter write SetFilter;
    property Font:TTeeFont read FFont write SetFont;
    property Gradient:TTeeGradient read FGradient write SetGradient;
    property TagSeparation:Integer read FSeparation write SetSeparation default 5;

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
    property ShowInLegend;
    property Title;
    property ValueFormat;
    property VertAxis;
    property XLabelsSource;

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

    // inherited
    property Brush;
    property EndColor;
    property MidColor;
    property LegendEvery;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property XValues;
    property YValues;

    // Events
    property OnDrawTag:TDrawTagEvent read FOnDrawTag write FOnDrawTag;
    property OnGetColor;
  end;

  TTagCloudEditor = class(TForm)
    PageControl1: TPageControl;
    TabFont: TTabSheet;
    TabOptions: TTabSheet;
    Label1: TLabel;
    EFilter: TEdit;
    CBClip: TCheckBox;
    ButtonPen1: TButtonPen;
    TabGradient: TTabSheet;
    Button1: TButton;
    Label2: TLabel;
    ESep: TEdit;
    UDSep: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure EFilterChange(Sender: TObject);
    procedure CBClipClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ESepChange(Sender: TObject);
  private
    { Private declarations }
    TagCloud : TTagCloudSeries;
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
  Math, TeeEdiFont, TeeProCo;

var
  TagCloudEndColor:TColor=0;

{ TTagCloudSeries }

function TTagCloudSeries.AddTag(const Text: String;
  const Value: Double): Integer;
begin
  result:=AddXYZ(0,Value,0,Text,clTeeColor);
end;

procedure TTagCloudSeries.Assign(Source: TPersistent);
begin
  if Source is TTagCloudSeries then
  with TTagCloudSeries(Source) do
  begin
    Self.Font:=FFont;
    Self.FFilter:=FFilter;
    Self.Gradient:=Gradient;
    Self.FSeparation:=FSeparation;
  end;

  inherited;
end;

function TTagCloudSeries.CalcXPos(ValueIndex: Integer): Integer;
begin
  if Length(Positions)<=ValueIndex then
     result:=0
  else
  with Positions[ValueIndex] do
       result:=(Left+Right) div 2;
end;

function TTagCloudSeries.CalcYPos(ValueIndex: Integer): Integer;
begin
  if Length(Positions)<=ValueIndex then
     result:=0
  else
  with Positions[ValueIndex] do
       result:=(Top+Bottom) div 2;
end;

function TTagCloudSeries.Clicked(X, Y: Integer): Integer;
var t : Integer;
    P : TPoint;
begin
  result:=TeeNoPointClicked;

  P:=TeePoint(X,Y);

  for t:=0 to Length(Positions)-1 do
  if PtInRect(Positions[t],P) then
  begin
    result:=t;
    break;
  end;
end;

{$IFNDEF CLR}
type
  TPenAccess=class(TChartPen);
{$ENDIF}

Constructor TTagCloudSeries.Create(AOwner: TComponent);
begin
  inherited;
  FFont:=TTeeFont.Create(CanvasChanged);
  FFont.Size:=32;

  FSeparation:=5;
  
  FGradient:=TTeeGradient.Create(CanvasChanged);

  Brush.Style:=bsClear;

  Pen.Visible:=False;
  {$IFNDEF CLR}TPenAccess{$ENDIF}(Pen).DefaultVisible:=False;

  EndColor:=TagCloudEndColor;
end;

Destructor TTagCloudSeries.Destroy;
begin
  FGradient.Free;
  FFont.Free;
  Positions:=nil;
  inherited;
end;

function TTagCloudSeries.ShouldDraw(ValueIndex:Integer):Boolean;
begin
  result:=(FFilter='') or
          (Pos(UpperCase(FFilter),UpperCase(XLabel[ValueIndex]))>0);
end;

procedure TTagCloudSeries.DrawAllValues;

  function TagSpacing:Integer;
  begin
    result:=Round(FSeparation*5*ParentChart.Canvas.TextWidth(TeeCharForHeight)*0.01);
  end;

var t : Integer;
    tt: Integer;
    tmpX : Integer;
    tmpY : Integer;
    tmpH : Integer;
    tmpW : Integer;
    tmpFirst : Integer;
    tmpW2 : Integer;
    tmpSt : String;
begin
  inherited;

  if ParentChart.ClipPoints then
     ParentChart.Canvas.ClipRectangle(ParentChart.ChartRect);

  if Gradient.Visible then
     Gradient.Draw(ParentChart.Canvas,ParentChart.ChartRect);

  ParentChart.Canvas.AssignVisiblePen(Pen);

  if Pen.Visible or (Brush.Style<>bsClear) then
  begin
    if (Brush.Style=bsClear) or Gradient.Visible then
       ParentChart.Canvas.Brush.Style:=bsClear
    else
       ParentChart.Canvas.AssignBrush(Brush);

    ParentChart.Canvas.Rectangle(ParentChart.ChartRect);
  end;

  ParentChart.Canvas.Brush.Style:=bsClear;
  ParentChart.Canvas.BackMode:=cbmTransparent;

  // Initialize Positions array
  SetLength(Positions,Count);
  for t:=0 to Count-1 do
      Positions[t]:=TeeZeroRect;

  ParentChart.Canvas.AssignFont(Font);

  tmpY:=ParentChart.ChartRect.Top;
  tmpFirst:=0;
  t:=0;

  repeat
    tmpH:=0;
    tmpW:=0;

    while t<Count do
    begin
      if ShouldDraw(t) then
      begin
        if Assigned(FOnDrawTag) then
           ParentChart.Canvas.AssignFont(Font);  // reset font

        ParentChart.Canvas.Font.Size:=GetTagFontSize(t);

        if Assigned(FOnDrawTag) then
           FOnDrawTag(Self,t);

        tmpW2:=ParentChart.Canvas.TextWidth(XLabel[t]);

        if tmpW>0 then
           Inc(tmpW2,TagSpacing);

        if tmpW+tmpW2 > (ParentChart.ChartRect.Right-ParentChart.ChartRect.Left) then
        begin
          // special case, just one tag, longer than total width
          if tmpW=0 then
          begin
            tmpH:=Math.Max(tmpH,ParentChart.Canvas.TextHeight(XLabel[t]));
            Inc(t);
          end;

          break;
        end
        else
        begin
          Inc(tmpW,tmpW2);
          tmpH:=Math.Max(tmpH,ParentChart.Canvas.TextHeight(XLabel[t]));
          Inc(t);
        end;
      end
      else Inc(t);
    end;

    tmpX:=ParentChart.ChartRect.Left;

    with ParentChart.Canvas do
    for tt:=tmpFirst to t-1 do
    if ShouldDraw(tt) then
    begin
      if Assigned(FOnDrawTag) then
         ParentChart.Canvas.AssignFont(Self.Font);  // reset font

      Font.Size:=GetTagFontSize(tt);
      Font.Color:=GetValueColor(tt);

      if Assigned(FOnDrawTag) then
         FOnDrawTag(Self,tt);

      tmpSt:=XLabel[tt];

      with Positions[tt] do
      begin
        Left:=tmpX;
        Bottom:=tmpY+tmpH;
        Top:=Bottom;

        // Allow TextAlign TA_BASELINE or TA_TOP
        if TextAlign<TA_BOTTOM then
           Dec(Top,TextHeight(tmpSt));

        Right:=Left+TextWidth(tmpSt);
      end;

      if ParentChart.View3D then
         TextOut3D(Positions[tt].Left,Positions[tt].Top,0,tmpSt)
      else
         TextOut(Positions[tt].Left,Positions[tt].Top,tmpSt);

      Inc(tmpX, TagSpacing + Positions[tt].Right-Positions[tt].Left);
    end;

    tmpFirst:=t;
    Inc(tmpY,tmpH);

    if tmpY > ParentChart.ChartRect.Bottom then
       break;

  until tmpFirst>=Count;

  FFirstVisibleIndex:=0;
  FLastVisibleIndex:=t;

  if ParentChart.ClipPoints then
     ParentChart.Canvas.UnClipRectangle;
end;

// TODO: Improve calculation using only the items that are
// valid when Filter is not empty. (See ShoulDraw function)
function TTagCloudSeries.GetTagFontSize(ValueIndex: Integer): Integer;
var tmp : Double;
begin
  result:=FFont.Size;

  tmp:=MandatoryValueList.MaxValue-MandatoryValueList.Value[ValueIndex];
  if tmp>0 then
    Dec(result, Round(0.75*tmp*FFont.Size/MandatoryValueList.Range));

  if result<1 then result:=1;
end;

procedure TTagCloudSeries.SetFilter(const Value: String);
begin
  SetStringProperty(FFilter,Value);
end;

procedure TTagCloudSeries.SetFont(const Value: TTeeFont);
begin
  FFont.Assign(Value);
end;

function TTagCloudSeries.UseAxis: Boolean;
begin
  result:=False;
end;

// Sort tags alphabetically or by value
procedure TTagCloudSeries.Sort(SortBy: TTagCloudOrder;
                               Order:TChartListOrder=loAscending);
begin
  case SortBy of
     toText: SortByLabels(Order);

    toValue: begin
               YValues.Order:=Order;
               YValues.Sort;
             end;
  else
    Exit;
  end;

  Repaint;
end;

// Just an example, adds random names of series styles
// with random values.
procedure TTagCloudSeries.AddSampleValues(NumValues: Integer;
  OnlyMandatory: Boolean);
var t   : Integer;
    tmp : String;
    s   : TSeriesRandomBounds;
begin
  s:=RandomBounds(NumValues);

  for t:=1 to NumValues do
  begin
    tmp:=TeeSeriesTypes[RandomValue(TeeSeriesTypes.Count)].Description{$IFNDEF CLR}^{$ENDIF};

    AddTag(ReplaceChar(tmp,TeeLineSeparator,' '),s.tmpY+s.DifY*RandomValue(1000));
  end;

  Sort(toText);
end;

class function TTagCloudSeries.GetEditorClass: String;
begin
  result:='TTagCloudEditor';
end;

procedure TTagCloudSeries.SetGradient(const Value: TTeeGradient);
begin
  FGradient.Assign(Value);
end;

procedure TTagCloudSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  // Switch chart to 2D mode, first time this series is dropped
  // at design-time into a Form.

  if Assigned(Value) and
     (csDesigning in ComponentState) and
     (not (csLoading in Owner.ComponentState)) then
          ParentChart.View3D:=False;
end;

procedure TTagCloudSeries.SetSeparation(const Value: Integer);
begin
  SetIntegerProperty(FSeparation,Value);
end;

procedure TTagCloudSeries.GalleryChanged3D(Is3D: Boolean);
begin
  inherited;
  ParentChart.View3D:=False;
end;

procedure TTagCloudSeries.PrepareLegendCanvas(ValueIndex: Integer;
  var BackColor: TColor; var BrushStyle: TBrushStyle);
begin
  inherited;
  BrushStyle:=bsSolid;
end;

// TTagCloudEditor

procedure TTagCloudEditor.FormShow(Sender: TObject);
var tmp : TGrid3DSeriesEditor;
begin
  inherited;

  TagCloud:=TTagCloudSeries(Tag);

  if Assigned(TagCloud) then
  begin
    InsertTeeFontEditor(TabFont).RefreshControls(TagCloud.Font);
    tmp:=TeeInsertGrid3DForm(Self,TagCloud) as TGrid3DSeriesEditor;
    tmp.Panel1.Hide;

    AddFormTo(TTeeGradientEditor.CreateCustom(nil,TagCloud.Gradient),TabGradient);

    EFilter.Text:=TagCloud.Filter;
    CBClip.Checked:=TagCloud.ParentChart.ClipPoints;
    ButtonPen1.LinkPen(TagCloud.Pen);
    UDSep.Position:=TagCloud.TagSeparation;
  end;
end;

procedure TTagCloudEditor.EFilterChange(Sender: TObject);
begin
  TagCloud.Filter:=EFilter.Text;
end;

procedure TTagCloudEditor.CBClipClick(Sender: TObject);
begin
  TagCloud.ParentChart.ClipPoints:=CBClip.Checked;
end;

procedure TTagCloudEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self, TagCloud.Brush);
end;

procedure TTagCloudEditor.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage:=TabOptions;
end;

procedure TTagCloudEditor.ESepChange(Sender: TObject);
begin
  if Showing then
     TagCloud.TagSeparation:=UDSep.Position;
end;

initialization
  TagCloudEndColor:=OperaPalette[2];
  RegisterClass(TTagCloudEditor);

  RegisterTeeSeries(TTagCloudSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryTagCloud,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySamples,1);
finalization
  UnRegisterTeeSeries([TTagCloudSeries]);
end.
