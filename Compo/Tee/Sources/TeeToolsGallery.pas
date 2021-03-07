{******************************************}
{ TeeChart Tools Gallery                   }
{ Copyright (c) 2000-2009 by David Berneda }
{******************************************}
unit TeeToolsGallery;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, Types,
     QComCtrls, QButtons,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeEngine, Chart, TeCanvas, TeePenDlg;

type
  TTeeToolsGallery = class(TForm)
    P1: TPanel;
    Panel1: TPanel;
    BOk: TButton;
    BCan: TButton;
    TabControl1: TTabControl;
    LBTool: TListBox;
    Panel2: TPanel;
    MemoDesc: TMemo;
    Splitter1: TSplitter;
    PanelDemos: TPanel;
    Splitter2: TSplitter;
    CBView3D: TCheckBox;
    LabelClass: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure FormShow(Sender: TObject);
    procedure LBToolDblClick(Sender: TObject);
    {$IFNDEF CLX}
    procedure LBToolDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    {$ELSE}
    procedure LBToolDrawItem(Sender: TObject; Index: Integer; Rect: TRect;
      State: TOwnerDrawState; var Handled: Boolean);
    {$ENDIF}
    procedure TabControl1Change(Sender: TObject);
    procedure LBToolClick(Sender: TObject);
  private
    { Private declarations }
    procedure FillTools;
    Function ToolAtIndex(AIndex:Integer):TTeeCustomToolClass;
    procedure View3DClick(Sender: TObject);
  public
    { Public declarations }
    Function SelectedTool:TTeeCustomToolClass;
  end;

procedure TeeDrawTool(AList:TListBox;
                      Index: Integer; Rect: TRect; State: TOwnerDrawState;
                      ATool:TTeeCustomTool);

type
  TToolsGalleryHook=procedure(Gallery:TTeeToolsGallery);

var
  ToolsGalleryHook : TToolsGalleryHook=nil;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF CLR}
{$R 'TAxisArrowTool.bmp'}
{$R 'TColorBandTool.bmp'}
{$R 'TColorLineTool.bmp'}
{$R 'TCursorTool.bmp'}
{$R 'TDragMarksTool.bmp'}
{$R 'TDrawLineTool.bmp'}
{$R 'TNearestTool.bmp'}
{$R 'TRotateTool.bmp'}
{$R 'TChartImageTool.bmp'}
{$R 'TMarksTipTool.bmp'}
{$R 'TDragPointTool.bmp'}
{$R 'TAnnotationTool.bmp'}
{$R 'TPageNumTool.bmp'}
{$R 'TAxisDividerTool.bmp'}
{$R 'TSelectorTool.bmp'}
{$R 'TExtraLegendTool.bmp'}
{$R 'TGridTransposeTool.bmp'}
{$R 'TGanttTool.bmp'}
{$R 'TSeriesAnimationTool.bmp'}
{$R 'TGridBandTool.bmp'}
{$R 'TPieTool.bmp'}
{$R 'TLightTool.bmp'}
{$R 'TLegendScrollBar.bmp'}
{$R 'TSurfaceNearestTool.bmp'}
{$R 'TAxisScrollTool.bmp'}
{$R 'TSeriesBandTool.bmp'}
{$R 'TClipSeriesTool.bmp'}
{$R 'TLegendPaletteTool.bmp'}
{$R 'TSeriesRegionTool.bmp'}
{$R 'TSeriesStatsTool.bmp'}
{$R 'TDataTableTool.bmp'}
{$R 'TFrameTool.bmp'}
{$R 'TMagnifyTool.bmp'}
{$R 'TText3DTool.bmp'}
{$R 'TFaderTool.bmp'}
{$R 'TFullScreenTool.bmp'}
{$R 'TSubChartTool.bmp'}
{$R 'TTransposeSeriesTool.bmp'}
{$R 'TVideoTool.bmp'}
{$R 'TVideoPlayerTool.bmp'}
{$R 'TAntiAliasTool.bmp'}
{$ELSE}
{$R TeeTools.res}
{$ENDIF}

Uses
  {$IFDEF LCL}
  LCLType, // Pending to move "odSelected" to StdCtrls unit.
  {$ENDIF}
  TeeProcs,
  TeeConst;

type TToolSeriesClass=class of TTeeCustomToolSeries;

procedure TTeeToolsGallery.FillTools;

  Function FilterTool(Index:Integer):Boolean;
  var tmp : TTeeCustomTool;
  begin
    tmp:=TeeToolTypes[Index].Create(nil);
    try
      case TabControl1.TabIndex of
        0: result:=tmp is TTeeCustomToolSeries;
        1: result:=tmp is TTeeCustomToolAxis;
        2: result:=(not (tmp is TTeeCustomToolSeries)) and
                   (not (tmp is TTeeCustomToolAxis));
      else
        result:=True;
      end;
    finally
      tmp.Free;
    end;
  end;

var t : Integer;
begin
  LBTool.Clear;

  for t:=0 to TeeToolTypes.Count-1 do
      if FilterTool(t) then
         LBTool.Items.AddObject(TeeToolTypes[t].Description,TObject(TeeToolTypes[t]));

  MemoDesc.Lines.Clear;
  BOk.Enabled:=False;
end;

procedure TTeeToolsGallery.FormShow(Sender: TObject);
begin
  {$IFNDEF CLX}
  {$IFDEF D6}
  MemoDesc.BevelKind:= bkFlat;
  MemoDesc.BevelOuter:= bvRaised;
  {$ENDIF}
  {$ENDIF}

  TabControl1.Tabs.Clear;
  TabControl1.Tabs.Add(TeeMsg_Series);
  TabControl1.Tabs.Add('Axis');  // <--- do not translate
  TabControl1.Tabs.Add(TeeMsg_PieOther);

  FillTools;

  LabelClass.Visible:=csDesigning in ComponentState;
  LabelClass.Caption:='';

  PanelDemos.Visible:=Assigned(ToolsGalleryHook);
  CBView3D.Visible:=PanelDemos.Visible;

  if not PanelDemos.Visible then
  begin
    TabControl1.Align:=alClient;
    Width:=300;
  end;

  TeeTranslateControl(Self);
end;

Function TTeeToolsGallery.SelectedTool:TTeeCustomToolClass;
begin
  result:=ToolAtIndex(LBTool.ItemIndex);
end;

procedure TTeeToolsGallery.LBToolDblClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

Function TTeeToolsGallery.ToolAtIndex(AIndex:Integer):TTeeCustomToolClass;
begin
  result:=TTeeCustomToolClass(LBTool.Items.Objects[AIndex]);
end;

procedure TeeDrawTool(AList:TListBox;
  Index: Integer; Rect: TRect; State: TOwnerDrawState; ATool:TTeeCustomTool);
begin
  with AList.Canvas do
  begin
    {$IFDEF CLX}
    Brush.Style:=bsSolid;
    {$ENDIF}
    if odSelected in State then Brush.Color:=clHighLight
                           else Brush.Color:=AList.Color;
    {$IFDEF CLX}
    Inc(Rect.Top);
    {$ENDIF}
    FillRect(Rect);
    {$IFDEF CLX}
    Dec(Rect.Top);
    {$ENDIF}

    TeeDrawBitmapEditor(AList.Canvas,ATool,Rect.Left+2,Rect.Top+1);

    if odSelected in State then Font.Color:=clHighlightText
                           else Font.Color:=AList.Font.Color;
    Brush.Style:=bsClear;
    TextOut(Rect.Left+22,Rect.Top+2,AList.Items[Index]);
  end;
end;

{$IFNDEF CLX}
procedure TTeeToolsGallery.LBToolDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ELSE}
procedure TTeeToolsGallery.LBToolDrawItem(Sender: TObject; Index: Integer;
  Rect: TRect; State: TOwnerDrawState; var Handled: Boolean);
{$ENDIF}
var tmpTool : TTeeCustomTool;
    tmpClass : TTeeCustomToolClass;
begin
  tmpClass:=ToolAtIndex(Index);

  if Assigned(tmpClass) then
  begin
    tmpTool:=tmpClass.Create(nil);
    try
      TeeDrawTool(LBTool,Index,Rect,State,tmpTool);
    finally
      tmpTool.Free;
    end;
  end;
end;

procedure TTeeToolsGallery.TabControl1Change(Sender: TObject);
begin
  FillTools;
end;

procedure TTeeToolsGallery.View3DClick(Sender: TObject);
begin
  TCustomChart(TCheckBox(Sender).Tag).View3D:=TCheckBox(Sender).Checked;
end;

procedure TTeeToolsGallery.LBToolClick(Sender: TObject);
var tmp : TCustomChart;
    t   : Integer;
begin
  BOk.Enabled:=LBTool.ItemIndex<>-1;

  // Remove demo controls
  while PanelDemos.ControlCount>2 do
        PanelDemos.Controls[2].Free;

  if LBTool.ItemIndex=-1 then
  begin
    LabelClass.Caption:='';
    MemoDesc.Lines.Clear;
    CBView3D.Hide;
  end
  else
  begin
    if Assigned(Application) and (csDesigning in Application.ComponentState) then
       LabelClass.Caption:=ToolAtIndex(LBTool.ItemIndex).ClassName;

    MemoDesc.Lines.Text:=ToolAtIndex(LBTool.ItemIndex).LongDescription;

    TeeTranslateControl(MemoDesc);

    if Assigned(ToolsGalleryHook) then
    begin
      ToolsGalleryHook(Self);

      tmp:=nil;
      for t:=0 to PanelDemos.ControlCount-1 do
          if PanelDemos.Controls[t] is TCustomChart then
             tmp:=TCustomChart(PanelDemos.Controls[t]);

      TeeTranslateControl(PanelDemos);

      CBView3D.OnClick:=nil;

      if Assigned(tmp) then
      begin
        CBView3D.Show;
        CBView3D.Checked:=tmp.View3D;
        CBView3D.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(tmp);
        CBView3D.OnClick:=View3DClick;
      end
      else
        CBView3D.Hide;
    end;
  end;
end;

initialization
  ToolsGalleryHook:=nil;
end.
