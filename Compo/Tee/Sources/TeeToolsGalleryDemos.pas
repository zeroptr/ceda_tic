{**********************************************}
{   TeeChart Tools Gallery Demos               }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeToolsGalleryDemos;
{$I TeeDefs.inc}

interface

implementation

uses
  Classes,
  {$IFDEF D6}
  Variants,
  {$ENDIF}
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QDialogs, QButtons,
  {$ELSE}
  Controls, Graphics, StdCtrls, Buttons, Dialogs,
  {$ENDIF}
  Math,
  TeCanvas,
  TeeProcs, TeeConst, TeeProCo, TeEngine, Chart, Series,

  // EditChar,

  TeeToolsGallery, TeeTools, TeeThemes, TeeGanttTool, GanttCh, TeePieTool,
  TeeBrushDlg, TeeExtraLegendTool, TeeSurfaceTool, TeeSurfa, TeeDragPoint,
  TeeAntiAlias, TeeSeriesStats, TeeSeriesBandTool, TeeSelectorTool,
  TeeLighting, TeeIsoSurface, TeePageNumTool, TeeDataTableTool,
  TeeTransposeTool, TeeTransposeSeries, TeeLegendScrollBar, TeeFrameTool,
  TeeLegendPalette, TeeSeriesRegion, TeeBannerTool, TeeText3D,

  {$IFDEF CLR}
  System.Reflection,
  {$ELSE}
  TeeVideo, TeeVideoPlayer,
  {$ENDIF}

  TeeMagnifyTool, TeeFaderTool, TeeSubChart, TeeLinkTool, TeeFibonacci,
  CandleCh;

type
  TToolDemos=class
  private
    procedure ChartDblClick(Sender: TObject);
    procedure CreateGallery(Gallery:TTeeToolsGallery);
    procedure Animation(Sender:TObject);
    procedure FadeChart(Sender:TObject);
    procedure FullScreen(Sender:TObject);
    procedure OutlineChecked(Sender:TObject);

    {$IFNDEF CLR}
    procedure PlayChartVideo(Sender:TObject);
    procedure RecordChartVideo(Sender:TObject);
    procedure StepAnimation(Sender:TSeriesAnimationTool; Step:Integer);
    procedure StopRecordVideo(Sender:TObject);
    {$ENDIF}

    procedure Transpose3DSeries(Sender:TObject);
    procedure TransposeSeries(Sender:TObject);
  end;

  TControlAccess=class(TControl)
  {$IFDEF CLR}
  public
    property Caption;
    property OnClick;
  end
  {$ENDIF}
  ;

procedure TToolDemos.ChartDblClick(Sender: TObject);
begin
  // EditChartTool(nil,(Sender as TCustomChart).Tools[0]);
  // (Sender as TCustomChart).CancelMouse:=True;
end;

{$IFDEF CLX}
type
  TControlClass=class of TControl;
{$ENDIF}

procedure TToolDemos.CreateGallery(Gallery:TTeeToolsGallery);

  function CreateChart(ATool:TTeeCustomToolClass;
                       const ATitle:String='';
                       const ASeries:TChartSeriesClass=nil):TChart;
  var c : TChart;
  begin
    c:=TChart.Create(Gallery);
    c.Align:=alClient;
    c.Parent:=Gallery.PanelDemos;

    if ASeries=nil then
       c.AddSeries(TLineSeries).FillSampleValues
    else
       c.AddSeries(ASeries).FillSampleValues;

    c.Legend.Hide;
    c.Zoom.Allow:=False;
    c.AllowPanning:=pmNone;
    c.Title.Text.Text:=ATitle;

    with c.Title.Font.Shadow do
    begin
      Visible:=True;
      Size:=3;
      Color:=clDkGray;
      SmoothBlur:=2;
    end;

    ApplyChartTheme(TWebTheme,c);

    if ATool<>nil then
       c.Tools.Add(ATool);

    c.OnDblClick:=ChartDblClick;

    c.Shadow.Visible:=True;
    c.Shadow.Color:=clDkGray;
    c.Shadow.Size:=8;

    result:=c;
  end;

var
  tmpY : Double;
  tmpRange : Integer;

  procedure RandomColorLine(ATool:TTeeCustomTool);
  begin
    with (ATool as TColorLineTool) do
    begin
      Axis:=ParentChart.Axes.Left;
      Value:=tmpY+Random(tmpRange);
      Pen.Color:=TRandomTheme.RandomColor;
      Pen.Width:=2;
    end;
  end;

  procedure RandomColorBand(ATool:TTeeCustomTool);
  begin
    with (ATool as TColorBandTool) do
    begin
      Axis:=ParentChart.Axes.Left;
      StartValue:=tmpY+Random(tmpRange);
      EndValue:=StartValue+Random(tmpRange);
      tmpY:=EndValue;
      Color:=TRandomTheme.RandomColor;
      ResizeEnd:=True;
      ResizeStart:=True;
    end;
  end;

  function AddControl(AClass:TControlClass; Chart:TCustomChart;
                      const AText:String):TControl;
  begin
    result:=AClass.Create(Gallery.PanelDemos);
    result.Left:=20;
    result.Top:=Chart.Height-50;
    result.Parent:=Chart;

    {$IFDEF CLR}
    result.SetText(AText);
    {$ELSE}
    TControlAccess(result).Caption:=AText;
    {$ENDIF}

    result.Width:=Max(result.Width,6*Length(AText));

    result.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(Chart.Tools[0]);
  end;

  function AddButton(Chart:TCustomChart;
                     const AText:String; AEvent:TNotifyEvent):TButton;
  begin
    result:=AddControl(TButton,Chart,AText) as TButton;
    result.OnClick:=AEvent;
  end;

  function AddBitButton(Chart:TCustomChart; Element:TCustomChartElement;
                        const AText:String; AEvent:TNotifyEvent):TBitBtn;
  var tmpBitmap : TBitmap;
  begin
    result:=AddControl(TBitBtn,Chart,AText) as TBitBtn;
    result.OnClick:=AEvent;

    tmpBitmap:=TBitmap.Create;
    try
      TeeGetBitmapEditor(Element,tmpBitmap);

      result.Width:=result.Width+tmpBitmap.Width+2;

      result.NumGlyphs:=1;
      result.Glyph:=tmpBitmap;
    finally
      tmpBitmap.Free;
    end;
  end;

  function AddCheck(Chart:TCustomChart;
                    const AText:String; AEvent:TNotifyEvent):TCheckBox;
  begin
    result:=AddControl(TCheckBox,Chart,'') as TCheckBox;
    result.OnClick:=AEvent;
    result.Width:=16;

    with TLabel.Create(Gallery.PanelDemos) do
    begin
      Transparent:=True;
      Caption:=AText;
      FocusControl:=result;
      Font.Style:=[fsBold];
      Left:=result.Left+2;
      Top:=result.Top+2;
      Parent:=result.Parent;
      AutoSize:=True;
    end;
  end;

var tmp  : TTeeCustomToolClass;
    tmpS : TStringList;
    c    : TChart;
    b    : TBannerTool;
begin
  tmp:=Gallery.SelectedTool;

  if tmp=TClipSeriesTool then
  with CreateChart(tmp,'Drag chart to scroll Series'+TeeLineSeparator+'that does not display outside axes') do
  begin
    View3D:=False;
    AllowPanning:=pmBoth;

    Axes.Left.StartPosition:=20;
    Axes.Left.EndPosition:=80;
    Axes.Bottom.StartPosition:=25;
    Axes.Bottom.EndPosition:=70;

    (Tools[0] as TClipSeriesTool).Series:=Series[0];
  end
  else
  if tmp=TCursorTool then
  with CreateChart(tmp,'Click and drag cursor lines') do
  begin
    with (Tools[0] as TCursorTool) do
    begin
      ScopeStyle:=scsCamera;
      ScopeSize:=20;
      Style:=cssScope;
    end;
  end
  else
  if tmp=TAnnotationTool then
  with CreateChart(tmp) do
  begin
    (Tools[0] as TAnnotationTool).Text:='This is an Annotation tool';

    Tools.Add(tmp);

    with (Tools[1] as TAnnotationTool) do
    begin
      Text:='Another Annotation';
      Left:=150;
      Top:=80;
      Shape.Font.Size:=18;
      Shape.Gradient.Visible:=True;
    end;
  end
  else
  if tmp=TRotateTool then
  begin
    c:=CreateChart(tmp,'Click and drag to rotate');

    with c do
    begin
      (Tools[0] as TRotateTool).Inertia:=75;

      View3DOptions.Orthogonal:=False;
      View3DOptions.Perspective:=100;
      Chart3DPercent:=75;
    end;

    AddCheck(c,TeeMsg_Outline,OutlineChecked).Left:=4;

  end
  else
  if tmp=TDragMarksTool then
  with CreateChart(tmp,'Click Series Marks to drag') do
  begin
    Series[0].FillSampleValues(5);
    Series[0].Marks.Show;
    Series[0].Marks.Font.Size:=14;
    Series[0].Marks.Callout.Arrow.Color:=clBlack;
    (Tools[0] as TDragMarksTool).Series:=Series[0];

    Axes.Left.MinimumOffset:=20;
    Axes.Left.MaximumOffset:=20;
    Axes.Bottom.MinimumOffset:=20;
    Axes.Bottom.MaximumOffset:=20;
  end
  else
  if tmp=TDrawLineTool then
  with CreateChart(tmp,'Click and drag to draw lines') do
  begin
    with Series[0].MandatoryValueList do
         tmpY:=(MinValue+MaxValue)*0.5;

    with (Tools[0] as TDrawLineTool) do
         Selected:=Lines.AddLine(1.5,tmpY,2.8,tmpY-tmpY*0.5);
  end
  else
  if tmp=TChartImageTool then
  with CreateChart(tmp,'Drag chart to scroll axes and image') do
  begin
    View3D:=False;
    Series[0].Color:=clGreen;
    Series[0].Pen.Width:=4;
    AllowPanning:=pmBoth;
    Zoom.Allow:=True;
    Zoom.Brush.Style:=bsSolid; // ??

    (Tools[0] as TChartImageTool).Series:=Series[0];

    Tools[0].Pen.Show;

    with TBrushDialog.Create(nil) do
    try
      (Tools[0] as TChartImageTool).Picture.Graphic:=ImageFire.Picture.Graphic;
    finally
      Free;
    end;
  end
  else
  if tmp=TNearestTool then
  with CreateChart(tmp,'Move the mouse over Series points') do
  begin
    Series[0].FillSampleValues(8);
    (Series[0] as TLineSeries).Pointer.Show;
    (Tools[0] as TNearestTool).Series:=Series[0];

    with (Series[0] as TLineSeries).Pointer.Shadow do
    begin
      Visible:=True;
      Color:=clDkGray;
      HorizSize:=8;
      VertSize:=4;
    end;

    with (Tools[0] as TNearestTool).Pen do
    begin
      Color:=clBlue;
      Width:=2;
    end;
  end
  else
  if tmp=TSeriesAnimationTool then
  begin
    c:=CreateChart(tmp,'Series points display animated',TBarSeries);

    with c do
    begin
      Series[0].ColorEachPoint:=True;

      (Series[0] as TBarSeries).Shadow.Visible:=True;
      (Series[0] as TBarSeries).Shadow.Size:=5;

      (Tools[0] as TSeriesAnimationTool).Series:=Series[0];

      with (Tools[0] as TSeriesAnimationTool) do
      begin
        //Loop:=salCircular;
        StartValue:=0;
        StartAtMin:=False;
        Steps:=100;
        DrawEvery:=1;
      end;
    end;

    AddButton(c,'&Animate !',Animation);
  end
  else
  if tmp=TMarksTipTool then
  with CreateChart(tmp,'Move mouse over Series points to display hints') do
  begin
    Series[0].FillSampleValues(5);
    (Series[0] as TLineSeries).Pointer.Show;
    (Tools[0] as TMarksTipTool).Series:=Series[0];
    (Tools[0] as TMarksTipTool).MouseAction:=mtmMove;
    Series[0].Cursor:=crHandPoint;
    Axes.Bottom.MinimumOffset:=20;
    Axes.Bottom.MaximumOffset:=20;
  end
  else
  if tmp=TColorLineTool then
  with CreateChart(tmp,'Several Color lines displayed'+TeeLineSeparator+'at random positions') do
  begin
    tmpY:=Series[0].MandatoryValueList.MinValue;
    tmpRange:=Round(Series[0].MandatoryValueList.Range);

    RandomColorLine(Tools[0]);
    RandomColorLine(Tools.Add(tmp));
    RandomColorLine(Tools.Add(tmp));
  end
  else
  if tmp=TColorBandTool then
  with CreateChart(tmp,'Color bands to fill axes background') do
  begin
    View3D:=False;

    tmpY:=Series[0].MandatoryValueList.MinValue;
    tmpRange:=Round(Series[0].MandatoryValueList.Range*0.2);

    RandomColorBand(Tools[0]);
    RandomColorBand(Tools.Add(tmp));
    RandomColorBand(Tools.Add(tmp));
  end
  else
  if tmp=TGridBandTool then
  with CreateChart(tmp,'Two bands fill axes grid lines space') do
  begin
    (Tools[0] as TGridBandTool).Axis:=Axes.Left;
    (Tools[0] as TGridBandTool).Band1.Color:=TRandomTheme.RandomColor;
    (Tools[0] as TGridBandTool).Band2.Color:=TRandomTheme.RandomColor;
  end
  else
  if tmp=TAxisArrowTool then
  with CreateChart(tmp,'Click axes arrow to scroll') do
  begin
    View3D:=False;
    (Tools[0] as TAxisArrowTool).HeadWidth:=30;
    (Tools[0] as TAxisArrowTool).Length:=60;
    (Tools[0] as TAxisArrowTool).Axis:=Axes.Bottom;
  end
  else
  if tmp=TAxisScrollTool then
  with CreateChart(tmp,'Drag axes to scroll') do
  begin
    View3D:=False;
    (Tools[0] as TAxisScrollTool).Axis:=Axes.Left;
    (Tools.Add(tmp) as TAxisScrollTool).Axis:=Axes.Bottom;
  end
  else
  if tmp=TRectangleTool then
  with CreateChart(tmp,'Annotations that can be'+TeeLineSeparator+'dragged and resized') do
  begin
    with (Tools[0] as TRectangleTool) do
    begin
      AutoSize:=True;
      Text:='Drag and'+TeeLineSeparator+'resize me ';
      Shape.Color:=clRed;
      Shape.Font.Size:=16;
      Shape.Transparency:=30;
      Left:=80;
      Top:=90;
    end;
  end
  else
  if tmp=TSurfaceNearestTool then
  with CreateChart(tmp,'Move mouse over Surface to highlight cells',TSurfaceSeries) do
  begin
    View3DOptions.Orthogonal:=False;
    View3DOptions.Perspective:=100;
    Chart3DPercent:=75;
    View3DOptions.Zoom:=75;

    (Series[0] as TSurfaceSeries).HideCells:=True;

//    (Series[0] as TSurfaceSeries).Palette. ??

    Series[0].FillSampleValues(20);
    (Tools[0] as TSurfaceNearestTool).Series:=Series[0];

    tmp:=TRotateTool;
    Tools.Add(tmp);

    Walls.Left.Hide;
    Walls.Back.Hide;
  end
  else
  if tmp=TDragPointTool then
  with CreateChart(tmp,'Click and drag Series points',TPointSeries) do
  begin
    Series[0].FillSampleValues(10);
    Series[0].ColorEachPoint:=True;
    Series[0].Cursor:=crHandPoint;
    (Tools[0] as TDragPointTool).Series:=Series[0];

    with (Series[0] as TPointSeries).Pointer.Shadow do
    begin
      Visible:=True;
      Size:=6;
    end;

  end
  else
  if tmp=TExtraLegendTool then
  with CreateChart(tmp,'Show additional Legend panels',TBarSeries) do
  begin
    AddSeries(TBarSeries).FillSampleValues;
    Legend.Show;
    Legend.Title.Caption:=TeeMsg_Legend;

    (Tools[0] as TExtraLegendTool).Series:=Series[1];
    (Tools[0] as TExtraLegendTool).Legend.Title.Caption:='Extra Legend';
    (Tools[0] as TExtraLegendTool).Legend.Left:=Width-100;
    (Tools[0] as TExtraLegendTool).Legend.Top:=100;
  end
  else
  if tmp=TGanttTool then
  with CreateChart(tmp,'Click Gantt bars to drag and resize',TGanttSeries) do
  begin
    View3D:=False;
    Series[0].FillSampleValues(10);

    with (Series[0] as TGanttSeries).Pointer do
    begin
     VertSize:=10;
     Shadow.Visible:=True;
    end;

    (Tools[0] as TGanttTool).Series:=Series[0];
  end
  else
  if tmp=TPieTool then
  with CreateChart(tmp,'Move mouse over Pie slices',TPieSeries) do
  begin
    Chart3DPercent:=70;

    (Tools[0] as TPieTool).Series:=Series[0];

    Series[0].Pen.Color:=clDkGray;
    Series[0].Pen.Width:=3;

    with (Series[0] as TPieSeries).Shadow do
    begin
      Size:=20;
      Visible:=True;
    end;

    //tmp:=TAntiAliasTool;
    //Tools.Add(tmp);
  end
  else
  if tmp=TSeriesStatsTool then
  with CreateChart(tmp,'Statistics of Series data') do
  begin
    (Tools[0] as TSeriesStatsTool).Series:=Series[0];

    tmp:=TAnnotationTool;
    Tools.Add(tmp);
    (Tools[1] as TAnnotationTool).Shape.Transparency:=10;
    (Tools[1] as TAnnotationTool).Left:=80;
    (Tools[1] as TAnnotationTool).Top:=50;

    tmpS:=TStringList.Create;
    try
      (Tools[0] as TSeriesStatsTool).Statistics(tmpS);
      (Tools[1] as TAnnotationTool).Text:=tmpS.Text;
    finally
      tmpS.Free;
    end;
  end
  else
  if tmp=TSeriesBandTool then
  with CreateChart(tmp,'Fill the region between two Series') do
  begin
    View3D:=False;
    Series[0].FillSampleValues(10);
    AddSeries(TLineSeries).FillSampleValues(10);
    (Tools[0] as TSeriesBandTool).Series:=Series[0];

    Series[0].Pen.Width:=3;
    Series[1].Pen.Width:=3;

    with Series[0].MandatoryValueList do
         tmpY:=(MaxValue+MinValue)*0.5;

    (Tools[0] as TSeriesBandTool).BoundValue:=tmpY;

    (Tools[0] as TSeriesBandTool).Series2:=Series[1];
    (Tools[0] as TSeriesBandTool).Gradient.Visible:=True;
    (Tools[0] as TSeriesBandTool).Gradient.StartColor:=clSilver;
    (Tools[0] as TSeriesBandTool).Pen.Show;
  end
  else
  if tmp=TAntiAliasTool then
  with CreateChart(tmp,'Smooth line edges', TAreaSeries) do
  begin
    Series[0].Color:=clFuchsia;
    (Series[0] as TAreaSeries).AreaLinesPen.Hide;
  end
  else
  if tmp=TSelectorTool then
  with CreateChart(tmp,'Click to select Chart items', TBarSeries) do
  begin
    Legend.Show;
    Series[0].FillSampleValues(4);
    AddSeries(TBarSeries).FillSampleValues(4);

    tmp:=TAnnotationTool;
    Tools.Add(tmp);
    with (Tools[1] as TAnnotationTool) do
    begin
      Text:='Click me';
      Position:=ppLeftBottom;
    end;
    
    Title.Transparent:=False;
    Foot.Caption:='Footer text';
    Foot.Transparent:=False;

    {$IFNDEF CLR}
    (Tools[0] as TSelectorTool).Part.Part:=cpLegend;
    {$ENDIF}
  end
  else
  if tmp=TLightTool then
  with CreateChart(tmp,'2D Lighting', TIsoSurfaceSeries) do
  begin
    View3DOptions.Orthogonal:=False;
    View3DOptions.Perspective:=100;
    Chart3DPercent:=75;
    View3DOptions.Zoom:=75;

    (Tools[0] as TLightTool).FollowMouse:=True;
    (Tools[0] as TLightTool).Style:=lsSpotLight;

    tmp:=TRotateTool;
    Tools.Add(tmp);
  end
  else
  if tmp=TPageNumTool then
  with CreateChart(tmp,'Shows Page numbering', TBarSeries) do
  begin
    Series[0].FillSampleValues(25);
    Pages.MaxPointsPerPage:=5;
    (Tools[0] as TPageNumTool).ShowButtons:=True;
  end
  else
  if tmp=TDataTableTool then
  with CreateChart(tmp,'Displays a grid with Series data', TBarSeries) do
  begin
    Series[0].FillSampleValues(4);
    AddSeries(TBarSeries).FillSampleValues(4);

    Series[0].ValueFormat:='#.00';
    Series[1].ValueFormat:=Series[0].ValueFormat;

    (Tools[0] as TDataTableTool).Brush.Color:=clCream;  // Brush not used
  end
  else
  if tmp=TGridTransposeTool then
  begin
    c:=CreateChart(tmp,'Swaps 3D Series data, rows by columns', TSurfaceSeries);

    with c do
    begin
      (Series[0] as TSurfaceSeries).HideCells:=True;

      (Tools[0] as TGridTransposeTool).Series:=(Series[0] as TCustom3DGridSeries);

      View3DOptions.Orthogonal:=False;
      View3DOptions.Perspective:=100;
      Chart3DPercent:=75;
      View3DOptions.Zoom:=75;

      Axes.Depth.Visible:=True;

      tmp:=TRotateTool;
      Tools.Add(tmp);
    end;

    AddButton(c,'&Transpose !',Transpose3DSeries);
  end
  else
  if tmp=TLegendScrollBar then
  with CreateChart(tmp,'Displays scrollbar at Legend') do
  begin
    Series[0].FillSampleValues(50);
    Legend.Show;
    (Tools[0] as TLegendScrollBar).Gradient.Visible:=True;

    with (Tools[0] as TLegendScrollBar).Thumb.Gradient do
    begin
      Visible:=True;
      StartColor:=clRed;
      EndColor:=clGreen;
    end;
  end
  else
  if tmp=TFrameTool then
  with CreateChart(tmp,'Displays a frame around Chart') do
  begin
    (Tools[0] as TFrameTool).ResizeChart:=True;
    (Tools[0] as TFrameTool).Size:=30;
  end
  else
  if tmp=TLegendPaletteTool then
  with CreateChart(tmp,'Displays legend of Series color palettes',TIsoSurfaceSeries) do
  begin
    View3DOptions.Orthogonal:=False;
    View3DOptions.Perspective:=100;
    Chart3DPercent:=75;
    View3DOptions.Zoom:=75;
    MarginLeft:=20;

    with (Series[0] as TIsoSurfaceSeries) do
    begin
      HideCells:=True;
      PaletteStyle:=psRainbow;
    end;

    Series[0].FillSampleValues(20);

    (Tools[0] as TLegendPaletteTool).Chart.Color:=Color;

    with (Tools[0] as TLegendPaletteTool) do
    begin
      Series:=SeriesList[0];
      Top:=100;
      Smooth:=True;
      Chart.Gradient.Visible:=True;

      Chart.Shadow.Size:=5;
      Chart.Shadow.Visible:=True;

      with Chart.Axes do
      begin
        Left.PositionPercent:=-2;
        Left.PositionUnits:=muPixels;
        Right.PositionPercent:=-2;
        Right.PositionUnits:=muPixels;
      end;
    end;
  end
  else
  if tmp=TSeriesRegionTool then
  with CreateChart(tmp,'Fills region between Series and value') do
  begin
    with (Tools[0] as TSeriesRegionTool) do
    begin
      Series:=SeriesList[0];

      with Series.MandatoryValueList do
           tmpY:=(MinValue+MaxValue)*0.5;

      Origin:=tmpY;
      LowerBound:=Series.NotMandatoryValueList.MinValue;
      UpperBound:=Series.NotMandatoryValueList.MaxValue;
      Gradient.Visible:=True;
      Pen.Color:=clNavy;
      Pen.Show;
    end;
  end
  else
  if tmp=TTransposeSeriesTool then
  begin
    c:=CreateChart(tmp,'Swaps rows by columns',TBarSeries);

    c.Chart3DPercent:=75;

    c.AddSeries(TBarSeries).FillSampleValues;

    (c[0] as TBarSeries).MultiBar:=mbNone;

    AddButton(c,'&Transpose !',TransposeSeries);
  end
  else
  if tmp=TBannerTool then
  begin
    c:=CreateChart(tmp,'Text scrolling and blinking');

    with c do
    begin
      Series[0].Color:=clSilver;

      (Tools[0] as TBannerTool).Text:='Scrolling text';

      b:=TBannerTool.Create(Owner);
      b.Text:='Blinking Text';
      b.Blink:=True;
      b.Scroll:=False;
      b.BlinkDelayOff:=300;
      b.Position:=ppLeftBottom;
      b.ParentChart:=c;
    end;
  end
  else
  if tmp=TFullScreenTool then
  begin
    c:=CreateChart(tmp,'Maximizes a Chart to full desktop size');
    AddButton(c,'&Full Screen !',FullScreen);
  end
  else
  if tmp=TText3DTool then
  with CreateChart(tmp,'Adds 3D text annotations') do
  begin
    with (Tools[0] as TText3DTool) do
    begin
      Text:='Text with 3D Font';
      Font.OutLine.Color:=clLime;
      Font.Style:=[fsBold];
      Font.Size:=36;
    end;

    tmp:=TRotateTool;
    Tools.Add(tmp);
    (Tools[1] as TRotateTool).Inertia:=75;

    View3DOptions.Orthogonal:=False;
    View3DOptions.Perspective:=100;
    Chart3DPercent:=75;
    View3DOptions.Zoom:=75;
  end
  else
  if tmp=TMagnifyTool then
  with CreateChart(tmp,'Magnify a Chart portion under the mouse') do
  begin
    (Tools[0] as TMagnifyTool).Width:=100;
    (Tools[0] as TMagnifyTool).Height:=100;
    //(Tools[0] as TMagnifyTool).FollowMouse:=True;
  end
  else
  if tmp=TFaderTool then
  begin
    c:=CreateChart(tmp,'Fade in/out a Chart');

    with (c.Tools[0] as TFaderTool) do
    begin
      if c.Shadow.Visible and Assigned(c.Parent) then
         Color:={$IFNDEF CLR}TControlAccess{$ENDIF}(c.Parent).Color
      else
         Color:=c.Color;

      Speed:=2;
      InitialDelay:=750;
    end;

    AddButton(c,'&Fade !',FadeChart);
  end
  else
  if tmp=TSubChartTool then
  with CreateChart(tmp,'Multiple Charts inside a Chart') do
  begin
    Series[0].Clear;
    Axes.Left.Grid.Hide;
    Walls.Visible:=False;

    with Tools[0] as TSubChartTool do
    begin
      with Charts.AddChart do
      begin
        AddSeries(TLineSeries).FillSampleValues;
      end;

      with Charts.AddChart do
      begin
        Left:=200;
        AddSeries(TBarSeries).FillSampleValues;
        Series[0].Color:=clGreen;
      end;

      with Charts.AddChart do
      begin
        Top:=150;
        AddSeries(TPieSeries).FillSampleValues;
        Series[0].Marks.Hide;
      end;

      with Charts.AddChart do
      begin
        Left:=200;
        Top:=150;
        AddSeries(TAreaSeries).FillSampleValues;
        Series[0].Color:=clBlue;
      end;
    end;
  end
  else

  {$IFNDEF CLR}

  if tmp=TVideoTool then
  begin
    c:=CreateChart(tmp,'Create AVI Video with Chart images',TPieSeries);
    (c[0] as TPieSeries).Circled:=True;
    c.Chart3DPercent:=60;

    ColorPalettes.ApplyPalette(c,MacOSPalette);

    tmp:=TSeriesAnimationTool; // <-- Workaround of a D11 dcc32 bug

    with (c.Tools.Add(tmp) as TSeriesAnimationTool) do
    begin
      Series:=c[0];
    end;

    AddBitButton(c,c.Tools[0],TeeMsg_RecordVideo,RecordChartVideo);
  end
  else
  if tmp=TVideoPlayerTool then
  begin
    c:=CreateChart(tmp,'Play AVI videos inside Chart regions');

    tmp:=TAnnotationTool;  // <-- Workaround of a D11 dcc32 bug
    c.Tools.Add(tmp);

    with c.Tools[1] as TAnnotationTool do
    begin
      Shape.Transparency:=10;
      Left:=80;
      Top:=50;
      Width:=120;
      Height:=120;

     (c.Tools[0] as TVideoPlayerTool).Picture:=Shape.Picture;
     (c.Tools[0] as TVideoPlayerTool).Loop:=True;
    end;

    AddBitButton(c,c.Tools[0],TeeMsg_Play,PlayChartVideo);

    tmp:=TRotateTool;
    c.Tools.Add(tmp);
  end
  else
  if tmp=TLinkTool then
  begin
    with CreateChart(tmp,'Clickable links to navigate to'+TeeLineSeparator+
                         'Internet URLs or local files') do
    begin
      with TLinkTool(Tools[0]) do
      begin
        Position:=ppCenter;
        URL:='http://www.steema.com';
        Hint:='Visit our web site !';
        Text:='www.Steema.com';
        Shape.Font.Style:=[fsBold,fsUnderline];
      end;
    end;
  end
  else
  if tmp=TFibonacciTool then
  with CreateChart(tmp,'Fibonnaci financial arcs or fans',TCandleSeries) do
  begin
    with TFibonacciTool(Tools[0]) do
    begin
      Series:=ParentChart.Series[0];
      StartX:=(Series.XValues.Last+Series.XValues.First)*0.5;
      EndX:=StartX+((Series.XValues.Last-Series.XValues.First)*0.3);

      StartY:=(Series.YValues.Last+Series.YValues.First)*0.5;
      EndY:=StartY+((Series.YValues.Last-Series.YValues.First)*0.3);

      Levels[Levels.Count-1].Pen.Color:=clLime;

      LabelsFont.Style:=[fsBold];
      LabelsFont.Name:='Verdana';
    end;
  end
  {$ENDIF}
  ;
end;

procedure TToolDemos.Animation(Sender:TObject);
begin
  TSeriesAnimationTool((Sender as TButton).Tag).Execute;
end;

procedure TToolDemos.FullScreen(Sender:TObject);
var tmp : TFullScreenTool;
begin
  tmp:=TFullScreenTool((Sender as TButton).Tag);
  tmp.Active:=True;
  (tmp.ParentChart as TCustomChart).Title.Caption:='Press ESC key or Alt + F4 to reset';
  tmp.ParentChart.Controls[0].Hide;
end;

procedure TToolDemos.OutlineChecked(Sender:TObject);
begin
  TRotateTool((Sender as TCheckBox).Tag).Pen.Visible:=(Sender as TCheckBox).Checked;
end;

procedure TToolDemos.FadeChart(Sender:TObject);
begin
  TFaderTool((Sender as TButton).Tag).Start;
end;

{$IFNDEF CLR}

procedure TToolDemos.StepAnimation(Sender:TSeriesAnimationTool; Step:Integer);
begin
  with Sender.Series as TPieSeries do
       RotationAngle:=RotationAngle+5;
end;

procedure TToolDemos.StopRecordVideo(Sender:TObject);
var a : TSeriesAnimationTool;
begin
  a:=TSeriesAnimationTool(Sender);
  a.Stop;
  TVideoTool(a.Tag).StopRecording;
  TButton(TVideoTool(a.Tag).Tag).Caption:=TeeMsg_RecordVideo;
end;

procedure TToolDemos.RecordChartVideo(Sender:TObject);
var b       : TButton;
    tmpName : String;
    v       : TVideoTool;
    a       : TSeriesAnimationTool;
begin
  b:=Sender as TButton;
  v:=TVideoTool(b.Tag);
  a:=TSeriesAnimationTool(v.ParentChart.Tools[1]);
  a.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(v);
  v.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(b);

  if b.Caption=TeeMsg_Stop then
  begin
    StopRecordVideo(a);
  end
  else
  begin
    tmpName:='';

    with TSaveDialog.Create(nil) do
    try
      Filter:='Avi Video files (*.avi)|*.avi';
      DefaultExt:='avi';

      if Execute then
         tmpName:=FileName;
    finally
      Free;
    end;

    if tmpName<>'' then
    begin
      b.Caption:=TeeMsg_Stop;
      v.StartRecording(tmpName);
      a.OnStep:=StepAnimation;
      a.OnStop:=StopRecordVideo;
      a.Execute;
    end;
  end;
end;

procedure TToolDemos.PlayChartVideo(Sender:TObject);
var tmpName : String;
begin
  tmpName:='';

  with TOpenDialog.Create(nil) do
  try
    Filter:='Avi Video files (*.avi)|*.avi';
    DefaultExt:='avi';

    if Execute then
       tmpName:=FileName;
  finally
    Free;
  end;

  if tmpName<>'' then
  begin
    (Sender as TButton).Enabled:=False;

    with TVideoPlayerTool((Sender as TButton).Tag) do
    begin
      FileName:=tmpName;
      Play;
    end;
  end;
end;
{$ENDIF}

procedure TToolDemos.Transpose3DSeries(Sender:TObject);
begin
  TGridTransposeTool((Sender as TButton).Tag).Transpose;
end;

procedure TToolDemos.TransposeSeries(Sender:TObject);
begin
  TTransposeSeriesTool((Sender as TButton).Tag).Transpose;
end;

procedure GalleryHook(Gallery:TTeeToolsGallery);
begin
  with TToolDemos.Create do
  try
    CreateGallery(Gallery);
  finally
    Free;
  end;
end;

initialization
  ToolsGalleryHook:=GalleryHook;
finalization
  ToolsGalleryHook:=nil;
end.
