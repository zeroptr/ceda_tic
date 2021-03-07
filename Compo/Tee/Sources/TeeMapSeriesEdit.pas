{********************************************}
{ TeeChart Pro - Map Series Editor           }
{ Copyright (c) 1995-2009 by David Berneda   }
{ All Rights Reserved                        }
{********************************************}
unit TeeMapSeriesEdit;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     QGrids, QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     Grids, Buttons,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeMapSeries, TeEngine, TeePenDlg, TeeChartGrid, TeeLisB,
     TeeNavigator, TeeEdiGrad;

type
  TMapSeriesEditor = class(TForm)
    PageControl2: TPageControl;
    TabGlobal: TTabSheet;
    BMapBrush: TButton;
    TabShapes: TTabSheet;
    PageControl1: TPageControl;
    TabFormat: TTabSheet;
    CBGlobalPen: TCheckBox;
    BBrush: TButton;
    CBGlobalBrush: TCheckBox;
    BGradient: TButtonGradient;
    TabData: TTabSheet;
    Splitter1: TSplitter;
    ButtonPen1: TButtonPen;
    ButtonPen2: TButtonPen;
    Panel1: TPanel;
    ButtonColor1: TButtonColor;
    ChartGrid1: TChartGrid;
    ChartGridNavigator1: TChartGridNavigator;
    ChartListBox1: TChartListBox;
    Panel2: TPanel;
    SBDelete: TSpeedButton;
    SBAdd: TSpeedButton;
    CBDefaultColor: TCheckBox;
    CBClosed: TCheckBox;
    TabValues: TTabSheet;
    Label2: TLabel;
    EText: TEdit;
    Label1: TLabel;
    EditZ: TEdit;
    Label3: TLabel;
    ShapeIndex: TLabel;
    CBVisible: TCheckBox;
    Label4: TLabel;
    ETransp: TEdit;
    UDTransp: TUpDown;
    Label5: TLabel;
    Edit1: TEdit;
    UDMapTransp: TUpDown;
    CBTransp: TCheckBox;
    Label6: TLabel;
    EPointSize: TEdit;
    UDPointSize: TUpDown;
    TabShadow: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure BMapBrushClick(Sender: TObject);
    procedure ETextChange(Sender: TObject);
    procedure ChartListBox1Click(Sender: TObject);
    procedure CBGlobalPenClick(Sender: TObject);
    procedure CBGlobalBrushClick(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure EditZChange(Sender: TObject);
    procedure ButtonPen2Click(Sender: TObject);
    procedure ButtonColor1Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure SBDeleteClick(Sender: TObject);
    procedure SBAddClick(Sender: TObject);
    procedure ChartGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure ChartListBox1ChangeColor(Sender: TChartListBox;
      Series: TCustomChartSeries);
    procedure CBDefaultColorClick(Sender: TObject);
    procedure CBClosedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBVisibleClick(Sender: TObject);
    procedure ETranspChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ChartListBox1ChangeActive(Sender: TChartListBox;
      Series: TCustomChartSeries);
    procedure CBTranspClick(Sender: TObject);
    procedure EPointSizeChange(Sender: TObject);
  private
    { Private declarations }
    ChangingText : Boolean;
    Grid3DForm : TCustomForm;

    procedure CheckDefaultColor;
    procedure EnableTabs;
    Procedure FillShapes;
    Function SelectedShape:TTeePolygon;
  protected
    Map : TMapSeries;
  public
    { Public declarations }
    InitialShape : TObject;
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses
  TeeBrushDlg, TeeGriEd, TeeShadowEditor;

procedure TMapSeriesEditor.FormShow(Sender: TObject);
begin
  ChangingText:=False;

  if Assigned(Parent) then
     Align:=alClient;

  Map:=TMapSeries(Tag);

  if Assigned(Map) then
  begin
    ButtonPen1.LinkPen(Map.Pen);

    UDMapTransp.Position:=Map.Transparency;
    CBTransp.Checked:=Map.Transparent;
    UDPointSize.Position:=Map.PointSize;

    if not Assigned(Grid3DForm) then
       Grid3DForm:=TeeInsertGrid3DForm(Parent,Map);

    InsertTeeShadowEditor(TabShadow).RefreshControls(Map.Shadow);
  end;

  PageControl2.ActivePage:=TabGlobal;
  ChartGrid1.ShowFields:=False;
  EnableTabs;

  ChartGridNavigator1.Buttons[nbInsert].Visible:=True;
  ChartGridNavigator1.Buttons[nbDelete].Visible:=True;

  PageControl1.ActivePage:=TabFormat;

  if Assigned(Map) and (Map.Shapes.Count>0) then
  begin
    FillShapes; // 7.07

    if Assigned(InitialShape) then
    begin
      PageControl2.ActivePage:=TabShapes;
      PageControl2Change(Self);
      ChartListBox1.ItemIndex:=ChartListBox1.Items.IndexOfObject(InitialShape);
    end
    else
       ChartListBox1.ItemIndex:=0;

    ChartListBox1Click(Self);
  end;

  PageControl2.ActivePage:=TabGlobal;
  PageControl1.ActivePage:=TabValues;

  ButtonPen1.Enabled:=True;
end;

procedure TMapSeriesEditor.EnableTabs;

  procedure EnableControls(Tab:TTabSheet; Value:Boolean);
  var t   : Integer;
  begin
    for t:=0 to Tab.ControlCount-1 do
        Tab.Controls[t].Enabled:=Value;
  end;

var tmp : Boolean;
begin
  tmp:=Assigned(Map) and (Map.Shapes.Count>0); { 5.02 }

  EnableControls(TabValues,tmp);
  EnableControls(TabFormat,tmp);
  EnableControls(TabData,tmp);
end;

procedure TMapSeriesEditor.BMapBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Map.Brush);
end;

procedure TMapSeriesEditor.ETextChange(Sender: TObject);
var tmp : String;
begin
  if not ChangingText then
  begin
    tmp:=SelectedShape.Text;
    if tmp<>EText.Text then
    begin
      SelectedShape.Text:=EText.Text;
      With ChartListBox1 do Items[ItemIndex]:=SelectedShape.Text;
    end;
  end;
end;

procedure TMapSeriesEditor.ChartListBox1Click(Sender: TObject);
begin
  EnableTabs;

  if SelectedShape<>nil then
  begin

    With SelectedShape do
    begin
      ShapeIndex.Caption:=IntToStr(Index);

      ButtonPen2.LinkPen(Pen);
      ButtonColor1.LinkProperty(SelectedShape,'Color');
      ButtonColor1.Repaint;
      CBGlobalPen.Checked:=ParentPen;
      CheckDefaultColor;
      CBGlobalBrush.Checked:=ParentBrush;

      ChangingText:=True;
      try
        EText.Text:=Text;
        EditZ.Text:=FloatToStr(Z);
      finally
        ChangingText:=False;
      end;

      CBClosed.Checked:=Closed;
      CBVisible.Checked:=Points.Visible;
      UDTransp.Position:=Transparency;

      ChartGrid1.Series:=Points;

      BGradient.Gradient:=Gradient;
    end;

    SBDelete.Enabled:=True;

  end
  else
  begin
    ShapeIndex.Caption:='';
    ButtonPen2.LinkPen(nil);
    ButtonColor1.LinkProperty(nil,'');
    ChangingText:=True;
    EText.Text:='';
    EditZ.Text:='0';
    ChangingText:=False;
  end;
end;

procedure TMapSeriesEditor.CBGlobalPenClick(Sender: TObject);
begin
  SelectedShape.ParentPen:=CBGlobalPen.Checked;
end;

procedure TMapSeriesEditor.CBGlobalBrushClick(Sender: TObject);
begin
  SelectedShape.ParentBrush:=CBGlobalBrush.Checked;
end;

procedure TMapSeriesEditor.BGradientClick(Sender: TObject);
begin
  ChartListBox1.Repaint;
end;

procedure TMapSeriesEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,SelectedShape.Brush);
  CBGlobalBrush.Checked:=False;
  Map.Repaint;
end;

function TMapSeriesEditor.SelectedShape: TTeePolygon;
begin
  if ChartListBox1.ItemIndex>=0 then
     result:=Map.Shapes[ChartListBox1.ItemIndex]
  else
     result:=nil;
end;

procedure TMapSeriesEditor.EditZChange(Sender: TObject);
var tmp : Double;
begin
  if not ChangingText then
  begin
    tmp:=StrToFloat(EditZ.Text);
    if SelectedShape.Z<>tmp then
    begin
      SelectedShape.Z:=tmp;
      Map.Repaint;
    end;
  end;
end;

procedure TMapSeriesEditor.ButtonPen2Click(Sender: TObject);
begin
  CBGlobalPen.Checked:=False;
  Map.Repaint;
end;

procedure TMapSeriesEditor.CheckDefaultColor;
begin
  CBDefaultColor.Checked:=SelectedShape.Color=clTeeColor;
  CBDefaultColor.Enabled:=not CBDefaultColor.Checked;
end;

procedure TMapSeriesEditor.ButtonColor1Click(Sender: TObject);
begin
  CheckDefaultColor;
  ChartListBox1.Repaint;
end;

procedure TMapSeriesEditor.PageControl2Change(Sender: TObject);
begin
  if ChartListBox1.Items.Count<>Map.Shapes.Count then
  begin
    FillShapes;
    ChartListBox1Click(Self);
  end;
end;

Procedure TMapSeriesEditor.FillShapes;
var t : Integer;
    tmp : String;
begin
  With ChartListBox1 do
  begin
    ClearItems;
    Items.BeginUpdate;

    try
      for t:=0 to Map.Shapes.Count-1 do
      begin
        tmp:=Map.Labels[t];
        if tmp='' then tmp:=IntToStr(t);
        Items.AddObject(tmp,Map.Shapes[t].Points);
      end;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TMapSeriesEditor.SBDeleteClick(Sender: TObject);
var tmpLast : Boolean;
    tmp     : Integer;
begin
  tmp:=ChartListBox1.ItemIndex;
  tmpLast:=ChartListBox1.ItemIndex=ChartListBox1.Items.Count-1;
  Map.Delete(ChartListBox1.ItemIndex);
  SBDelete.Enabled:=Map.Shapes.Count>0;

  FillShapes;

  if Map.Shapes.Count>0 then
  begin
    if tmpLast then tmp:=ChartListBox1.Items.Count-1;
  end
  else tmp:=-1;

  with ChartListBox1 do
  begin
    ItemIndex:=tmp;
    if tmp>=0 then
       Selected[tmp]:=True;
  end;

  ChartListBox1Click(Self);
  EnableTabs;
end;

procedure TMapSeriesEditor.SBAddClick(Sender: TObject);
begin
  with Map.Shapes.Add do { 5.02 }
       Text:=IntToStr(Map.Count);

  FillShapes;

  with ChartListBox1 do
  begin
    ItemIndex:=Items.Count-1;
    Selected[ItemIndex]:=True;
    SetFocus;
  end;

  ChartListBox1Click(Self);
  EnableTabs;
end;

procedure TMapSeriesEditor.ChartGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  Map.Repaint;
end;

procedure TMapSeriesEditor.ChartListBox1ChangeColor(Sender: TChartListBox;
  Series: TCustomChartSeries);
begin
  ButtonColor1.Invalidate;
  ChartListBox1.Invalidate;
end;

procedure TMapSeriesEditor.CBDefaultColorClick(Sender: TObject);
begin
  SelectedShape.Color:=clTeeColor;
  ButtonColor1.Invalidate;
  ChartListBox1.Invalidate;
end;

procedure TMapSeriesEditor.CBClosedClick(Sender: TObject);
begin
  SelectedShape.Closed:=CBClosed.Checked;
end;

procedure TMapSeriesEditor.FormCreate(Sender: TObject);
begin
  InitialShape:=nil;
end;

procedure TMapSeriesEditor.CBVisibleClick(Sender: TObject);
begin
  SelectedShape.Points.Visible:=CBVisible.Checked;
  ChartListBox1.SelectedSeries.Visible:=CBVisible.Checked;
  ChartListBox1.Invalidate;
end;

procedure TMapSeriesEditor.ETranspChange(Sender: TObject);
begin
  if Showing and (SelectedShape<>nil) then
     SelectedShape.Transparency:=UDTransp.Position;
end;

procedure TMapSeriesEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Grid3DForm);
end;

procedure TMapSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     Map.Transparency:=UDMapTransp.Position;
end;

procedure TMapSeriesEditor.ChartListBox1ChangeActive(Sender: TChartListBox;
  Series: TCustomChartSeries);
begin
  CBVisible.Checked:=SelectedShape.Points.Visible;
end;

procedure TMapSeriesEditor.CBTranspClick(Sender: TObject);
begin
  Map.Transparent:=CBTransp.Checked;
end;

procedure TMapSeriesEditor.EPointSizeChange(Sender: TObject);
begin
  if Showing then
     Map.PointSize:=UDPointSize.Position;
end;

initialization
  RegisterClass(TMapSeriesEditor);
end.
