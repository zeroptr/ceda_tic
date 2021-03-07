{*******************************************}
{ TeeChart Pro visual Themes                }
{ Copyright (c) 2003-2009 by David Berneda  }
{ All Rights Reserved                       }
{*******************************************}
unit TeeThemes;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes, SysUtils,
     {$IFDEF CLX}
     QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     TeEngine, Chart, TeCanvas, TeeTools;

type
  TDefaultTheme=class(TChartTheme)
  protected
    procedure ChangeAxis(Axis:TChartAxis); override;
    procedure ChangeSeries(Series:TChartSeries);
    procedure ChangeWall(Wall:TChartWall; AColor:TColor);
    procedure ResetGradient(Gradient:TTeeGradient);
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TExcelTheme=class(TDefaultTheme)
  protected
    procedure ChangeAxis(Axis:TChartAxis); override;
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TClassicTheme=class(TDefaultTheme)
  protected
    procedure ChangeAxis(Axis:TChartAxis); override;
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TBusinessTheme=class(TDefaultTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TWebTheme=class(TDefaultTheme)
  protected
    procedure ChangeAxis(Axis:TChartAxis); override;
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TWindowsXPTheme=class(TBusinessTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TBlueSkyTheme=class(TDefaultTheme)
  protected
    procedure ChangeAxis(Axis:TChartAxis); override;
  public
    procedure Apply; override;
    function Description:string; override;
  end;

  TFactsTheme=class(TDefaultTheme)
  private
    FBands : TGridBandTool;
    function GetBands: TGridBandTool;
  public
    procedure Apply; override;
    function Description:string; override;
    property Bands:TGridBandTool read GetBands;
  end;

  TRandomTheme=class(TDefaultTheme)
  protected
    procedure ChangeAxis(Axis:TChartAxis); override;
    function RandomBoolean:Boolean;
  public
    procedure Apply; override;
    function Description:string; override;
    class function RandomColor:TColor;
  end;

  TOperaTheme=class(TDefaultTheme)
  public
    procedure Apply; override;
    function Description:string; override;
  end;

procedure ApplyChartTheme(Theme:TChartThemeClass; Chart:TCustomChart; PaletteIndex:Integer); overload;
procedure ApplyChartTheme(Theme:TChartThemeClass; Chart:TCustomChart); overload;

type
  TThemesList=class(TList)
  private
    function GetTheme(Index:Integer):TChartThemeClass;
  public
    property Theme[Index:Integer]:TChartThemeClass read GetTheme; default;
  end;

var 
  ChartThemes : TThemesList=nil;

procedure RegisterChartThemes(const Themes:Array of TChartThemeClass);

implementation

uses {$IFDEF CLX}
     QControls,
     {$ELSE}
     Controls,
     {$ENDIF}
     {$IFDEF LCL}
     GraphType,
     {$ENDIF}
     TeeConst, TeeProCo, TeeProcs;

{ TDefaultTheme }
function TDefaultTheme.Description: string;
begin
  result:='TeeChart default';
end;

procedure TDefaultTheme.ResetGradient(Gradient:TTeeGradient);
begin
  with Gradient do
  begin
    Visible:=False;
    StartColor:=clWhite;
    Direction:=gdTopBottom;
    EndColor:=clYellow;
    MidColor:=clNone;
    Balance:=50;
  end;
end;

procedure TDefaultTheme.ChangeWall(Wall:TChartWall; AColor:TColor);
begin
  with Wall do
  begin
    Pen.Visible:=True;
    Pen.Color:=clBlack;
    Pen.Width:=1;
    Pen.Style:=psSolid;
    Gradient.Visible:=False;

    Color:=AColor;
    Dark3D:=True;
    Size:=0;
  end;
end;

procedure TDefaultTheme.ChangeAxis(Axis:TChartAxis);
begin
  inherited;
  
  with Axis do
  begin
    Axis.Width:=2;
    Axis.Color:=clBlack;

    Grid.Visible:=True;
    Grid.Color:=clGray;
    Grid.Style:=psDot;
    Grid.SmallDots:=False;
    Grid.Centered:=False;

    Ticks.Color:=clDkGray;
    TicksInner.Visible:=True;
    MinorTicks.Visible:=True;

    MinorGrid.Hide;
    MinorTickCount:=3;

    MinorTickLength:=2;
    TickLength:=4;
    TickInnerLength:=0;

    with LabelsFont do
    begin
      Name:=GetDefaultFontName;
      Size:=GetDefaultFontSize;
      Style:=[];
      Color:=clBlack;
    end;

    Title.Font.Name:=GetDefaultFontName;
  end;
end;

procedure TDefaultTheme.ChangeSeries(Series:TChartSeries);
begin
  with Series.Marks do
  begin
    Transparent:=False;
    Gradient.Visible:=False;
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Arrow.Color:=clWhite;
  end;
end;

procedure TDefaultTheme.Apply;
var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvRaised;
  Chart.BevelWidth:=1;
  Chart.Border.Hide;
  Chart.BorderRound:=0;
  Chart.Border.Hide;

  Chart.Shadow.Size:=0;

  Chart.Color:=clBtnFace;

  ResetGradient(Chart.Gradient);

  with Chart.Legend do
  begin
    Shadow.VertSize:=3;
    Shadow.HorizSize:=3;
    Shadow.Transparency:=0;
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Symbol.DefaultPen:=True;
    Transparent:=False;
    Pen.Visible:=True;
    DividingLines.Hide;
    Gradient.Visible:=False;
  end;

  ChangeWall(Chart.Walls.Left,$0080FFFF);
  ChangeWall(Chart.Walls.Right,clSilver);
  ChangeWall(Chart.Walls.Back,clSilver);
  ChangeWall(Chart.Walls.Bottom,clWhite);

  Chart.Walls.Back.Transparent:=True;

  for t:=0 to Chart.SeriesCount-1 do
    ChangeSeries(Chart[t]);

  with Chart.Title do
  begin
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Font.Color:=clBlue;

    Transparent:=True;
    Alignment:=taCenter;

    ResetGradient(Gradient);
  end;

  ColorPalettes.ApplyPalette(Chart,0);
end;

function ThemeFontName(const AFontName:String):String;
begin
  {$IFDEF TEEJAPANESE}
  result:=GetDefaultFontName;
  {$ELSE}
  result:=AFontName;
  {$ENDIF}
end;

{ TClassicTheme }

const
  ClassicFont = 'Times New Roman';

procedure TClassicTheme.ChangeAxis(Axis:TChartAxis);
begin
  inherited;

  with Axis do
  begin
    Axis.Width:=1;

    Grid.Color:=clBlack;
    Grid.Style:=psSolid;
    Grid.Visible:=True;

    Ticks.Color:=clBlack;

    MinorTicks.Hide;
    TicksInner.Hide;

    with LabelsFont do
    begin
      Name:=ThemeFontName(ClassicFont);
      Size:=10;
    end;

    Title.Font.Name:=ThemeFontName(ClassicFont);
  end;
end;

procedure TClassicTheme.Apply;

  procedure ChangeWall(Wall:TChartWall);
  begin
    with Wall do
    begin
      Pen.Visible:=True;
      Pen.Color:=clBlack;
      Pen.Width:=1;
      Pen.Style:=psSolid;
      Gradient.Visible:=False;

      Color:=clWhite;
      Dark3D:=False;
      Size:=8;
    end;
  end;

  procedure ChangeSeries(Series:TChartSeries);
  begin
    with Series.Marks do
    begin
      Gradient.Visible:=False;
      Transparent:=True;
      Font.Name:=ThemeFontName(ClassicFont);
      Font.Size:=10;
      Arrow.Color:=clBlack;
    end;
  end;

var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvNone;
  Chart.BorderRound:=0;

  with Chart.Border do
  begin
    Visible:=True;
    Width:=1;
    Style:=psSolid;
    Color:=clBlack;
  end;

  Chart.Color:=clWhite;
  Chart.Gradient.Visible:=False;

  with Chart.Legend do
  begin
    Shadow.VertSize:=0;
    Shadow.HorizSize:=0;
    Font.Name:=ThemeFontName(ClassicFont);
    Font.Size:=10;
    Transparent:=True;
    Pen.Hide;
    Symbol.DefaultPen:=False;
    Symbol.Pen.Hide;
  end;

  ChangeWall(Chart.Walls.Left);
  ChangeWall(Chart.Walls.Right);
  ChangeWall(Chart.Walls.Back);
  ChangeWall(Chart.Walls.Bottom);

  Chart.Walls.Back.Transparent:=False;

  Chart.Axes.Bottom.Grid.Centered:=True;

  for t:=0 to Chart.SeriesCount-1 do
    ChangeSeries(Chart[t]);

  with Chart.Title do
  begin
    Font.Name:=ThemeFontName(ClassicFont);
    Font.Size:=12;
    Font.Color:=clBlack;
  end;

  ColorPalettes.ApplyPalette(Chart,5);
end;

function TClassicTheme.Description: string;
begin
  result:='Classic';
end;

{ TBusinessTheme }

procedure TBusinessTheme.Apply;
var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvNone;

  Chart.Border.Visible:=True;
  Chart.BorderRound:=10;
  Chart.Border.Width:=6;
  Chart.Border.Color:=clNavy;

  ResetGradient(Chart.Gradient);

  Chart.Gradient.Visible:=True;
  Chart.Gradient.EndColor:=clDkGray;

  Chart.Color:=clBtnFace;

  with Chart.Legend do
  begin
    Shadow.VertSize:=3;
    Shadow.HorizSize:=3;
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Symbol.DefaultPen:=True;
    Transparent:=False;
    Pen.Visible:=True;

    ResetGradient(Gradient);

    Gradient.Visible:=True;
  end;

  ChangeWall(Chart.Walls.Left,$0080FFFF);
  ChangeWall(Chart.Walls.Right,clSilver);
  ChangeWall(Chart.Walls.Back,clSilver);
  ChangeWall(Chart.Walls.Bottom,clWhite);

  Chart.Walls.Back.Transparent:=True;

  for t:=0 to Chart.SeriesCount-1 do
  begin
    ChangeSeries(Chart[t]);

    with Chart[t].Marks.Gradient do
    begin
      Visible:=True;
      StartColor:=clSilver;
    end;
  end;

  with Chart.Title do
  begin
    Font.Name:=GetDefaultFontName;
    Font.Size:=GetDefaultFontSize;
    Font.Color:=clBlue;
  end;

  ColorPalettes.ApplyPalette(Chart,2);
end;

function TBusinessTheme.Description: string;
begin
  result:=TeeMsg_WizardTab;  // Business
end;

{ TExcelTheme }

Const
  ExcelFontName='Arial';

function TExcelTheme.Description: string;
begin
  result:='Microsoft® Excel';
end;

procedure TExcelTheme.ChangeAxis(Axis:TChartAxis);
begin
  inherited;

  with Axis do
  begin
    Axis.Width:=1;
    Grid.Visible:=True;
    Grid.Color:=clBlack;
    Grid.Style:=psSolid;
    Grid.Centered:=False;

    Ticks.Color:=clBlack;

    MinorTicks.Hide;
    TicksInner.Hide;

    with LabelsFont do
    begin
      Name:=ThemeFontName(ExcelFontName);
      Size:=10;
    end;
  end;
end;

procedure TExcelTheme.Apply;

  procedure DoChangeWall(Wall:TChartWall; AColor:TColor);
  begin
    with Wall do
    begin
      Pen.Visible:=True;
      Pen.Color:=clDkGray;
      Pen.Width:=1;
      Pen.Style:=psSolid;
      Gradient.Visible:=False;

      Color:=AColor;
      Dark3D:=False;
    end;
  end;

  procedure DoChangeSeries(Series:TChartSeries);
  begin
    with Series.Marks do
    begin
      Gradient.Visible:=False;
      Transparent:=True;
      Font.Name:=ThemeFontName(ExcelFontName);
      Font.Size:=10;
      Arrow.Color:=clWhite;
    end;
  end;

var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvNone;
  Chart.BorderRound:=0;

  with Chart.Border do
  begin
    Visible:=True;
    Width:=1;
    Style:=psSolid;
    Color:=clBlack;
  end;

  Chart.Color:=clWhite;
  Chart.Gradient.Visible:=False;

  with Chart.Legend do
  begin
    Shadow.VertSize:=0;
    Shadow.HorizSize:=0;
    DividingLines.Hide;
    Font.Name:=ThemeFontName(ExcelFontName);
    Font.Size:=10;
    Pen.Color:=clBlack;
    Pen.Width:=1;
    Pen.Style:=psSolid;
    Pen.Visible:=True;
    Transparent:=False;
    Gradient.Visible:=False;
  end;

  DoChangeWall(Chart.Walls.Left,clSilver);
  DoChangeWall(Chart.Walls.Right,clSilver);
  DoChangeWall(Chart.Walls.Back,clSilver);
  DoChangeWall(Chart.Walls.Bottom,clDkGray);

  Chart.Walls.Back.Transparent:=False;

  Chart.Axes.Top.Grid.Hide;
  Chart.Axes.Bottom.Grid.Hide;

  Chart.Axes.Bottom.Grid.Centered:=True;

  for t:=0 to Chart.SeriesCount-1 do
    DoChangeSeries(Chart[t]);

  with Chart.Title.Font do
  begin
    Name:=ThemeFontName(ExcelFontName);
    Size:=10;
    Color:=clBlack;
  end;

  ColorPalettes.ApplyPalette(Chart,1);
end;

{ TWebTheme }

const
  clDarkSilver=$C4C4C4;
  WebFont='Lucida Console';

procedure TWebTheme.ChangeAxis(Axis:TChartAxis);
begin
  inherited;

  with Axis do
  begin
    Grid.Color:=clDarkSilver;
    Grid.Style:=psSolid;

    if Horizontal then
       Grid.Hide;

    MinorTickCount:=3;
    MinorTickLength:=-3;

    TickLength:=0;
    TickInnerLength:=6;
    TicksInner.Visible:=True;
    TicksInner.Color:=clBlack;

    LabelsFont.Name:=ThemeFontName(WebFont);

    MinorTicks.Visible:=True;
    MinorTicks.Color:=clBlack;
  end;
end;

procedure TWebTheme.Apply;
var t : Integer;
begin
  inherited;

  Chart.BevelInner:=bvNone;
  Chart.BevelOuter:=bvNone;

  Chart.Border.Visible:=True;
  Chart.BorderRound:=0;
  Chart.Border.Width:=1;
  Chart.Border.Color:=clBlack;

  Chart.Gradient.Visible:=False;

  Chart.Color:=clDarkSilver;  // dark clSilver

  with Chart.Legend do
  begin
    Shadow.VertSize:=3;
    Shadow.HorizSize:=3;
    Shadow.Color:=clDkGray;
    Font.Name:=ThemeFontName(WebFont);
    Font.Size:=9;
    Symbol.DefaultPen:=True;
    Transparent:=False;
    Pen.Visible:=True;
    Gradient.Visible:=False;
  end;

  ChangeWall(Chart.Walls.Left,clWhite);
  ChangeWall(Chart.Walls.Right,clWhite);
  ChangeWall(Chart.Walls.Back,clWhite);
  ChangeWall(Chart.Walls.Bottom,clWhite);

  Chart.Walls.Back.Transparent:=False;

  for t:=0 to Chart.SeriesCount-1 do
  begin
    ChangeSeries(Chart[t]);
    Chart[t].Marks.Font.Name:=ThemeFontName(WebFont);

    with Chart[t].Marks.Gradient do
    begin
      Visible:=True;
      StartColor:=clSilver;
    end;
  end;

  with Chart.Title.Font do
  begin
    Name:=ThemeFontName(WebFont);
    Size:=10;
    Color:=clBlack;
    Style:=[fsBold];
  end;

  ColorPalettes.ApplyPalette(Chart,6);
end;

function TWebTheme.Description: string;
begin
  result:='Web';
end;

{ TWindowsXPTheme }

procedure TWindowsXPTheme.Apply;
begin
  inherited;

  with Chart do
  begin
    BorderRound:=0;
    Border.Color:=$DF7A29;
    Border.Width:=7;
    Shadow.HorizSize:=10;
    Shadow.VertSize:=10;
    Shadow.Color:=clBlack;

    Gradient.MidColor:=clNone;
    Gradient.Direction:=gdDiagonalDown;
    Gradient.EndColor:=11645361;

    with Walls.Left.Gradient do
    begin
      Visible:=True;
      StartColor:=WindowsXPPalette[2];
      EndColor:=WindowsXPPalette[1];
    end;

    with Walls.Bottom.Gradient do
    begin
      Visible:=True;
      StartColor:=WindowsXPPalette[3];
      EndColor:=WindowsXPPalette[4];
    end;

    Walls.Back.Transparent:=False;

    ResetGradient(Walls.Back.Gradient);
    Walls.Back.Gradient.EndColor:=11118482;
    Walls.Back.Gradient.Visible:=True;

    Legend.Shadow.Transparency:=50;
  end;

  ColorPalettes.ApplyPalette(Chart,9);
end;

function TWindowsXPTheme.Description: string;
begin
  result:='Windows XP';
end;

{ TBlueSkyTheme }

procedure TBlueSkyTheme.ChangeAxis(Axis:TChartAxis);
begin
  inherited;

  with Axis do
  if Horizontal then
  begin
    Axis.Width := 1;
    Grid.Color := 16759225;
    Grid.SmallDots := True;
    LabelsFont.Color := clNavy;
    LabelsFont.Name:=ThemeFontName('Tahoma');
    LabelsFont.Style := [fsBold];
    MinorGrid.Color := 15066597;
    MinorGrid.Visible := True;
    MinorTickCount := 7;
    TickLength := 5;
  end
  else
  begin
    Axis.Color := clNavy;
    Axis.Width := 1;
    Grid.Color := clBlue;
    Grid.SmallDots := True;
    LabelsFont.Color := clNavy;
    LabelsFont.Name:=ThemeFontName('Tahoma');
    LabelsFont.Style := [fsBold];
  end;
end;

procedure TBlueSkyTheme.Apply;
begin
  inherited;

  with Chart do
  begin
    BackWall.Color := 13626620;
    BackWall.Pen.Visible := False;
    BackWall.Size := 5;
    BackWall.Transparent := False;

    Border.Color := 9423874;
    Border.Width := 7;
    Border.Visible := True;

    BottomWall.Color := 16550915;
    BottomWall.Pen.Visible := False;
    BottomWall.Size := 5;

    ResetGradient(Gradient);

    Gradient.Direction := gdFromCenter;
    Gradient.EndColor := clWhite;
    Gradient.MidColor := 16777088;
    Gradient.StartColor := 10814240;
    Gradient.Visible := True;
    
    LeftWall.Color := 16744576;
    LeftWall.Pen.Visible := False;
    LeftWall.Size := 5;
    
    Legend.DividingLines.Color := clSilver;
    Legend.DividingLines.Visible := True;
    Legend.Font.Color := 6553600;
    Legend.Frame.Visible := False;

    ResetGradient(Legend.Gradient);

    Legend.Gradient.Direction := gdTopBottom;
    Legend.Gradient.EndColor := 13556735;
    Legend.Gradient.MidColor := 14739177;
    Legend.Gradient.StartColor := 16774122;
    Legend.Gradient.Visible := True;

    Legend.Shadow.HorizSize := 4;
    Legend.Shadow.Transparency := 50;
    Legend.Shadow.VertSize := 5;
    Legend.Symbol.Squared := True;

    RightWall.Size := 5;

    Title.Color := clBlack;
    Title.Font.Color := clNavy;
    Title.Font.Height := -16;
    Title.Frame.Color := 10083835;
    Title.Frame.Width := 2;

    ResetGradient(Title.Gradient);

    with Title.Gradient do
    begin
      Balance := 40;
      Direction := gdRightLeft;
      EndColor := clBlack;
      MidColor := 8388672;
      StartColor := clGray;
      Visible := True;
    end;

    Title.Shadow.HorizSize := 4;
    Title.Shadow.Transparency := 70;
    Title.Shadow.VertSize := 4;

    Frame.Visible := False;

    Shadow.Color := clBlack;
    Shadow.HorizSize := 7;
    Shadow.VertSize := 7;

    BevelInner := bvLowered;
    BevelOuter := bvNone;
    BevelWidth := 2;
  end;

  ColorPalettes.ApplyPalette(Chart,3);
end;

function TBlueSkyTheme.Description: string;
begin
  result:='Blues';
end;

procedure ApplyChartTheme(Theme:TChartThemeClass; Chart:TCustomChart);
begin
  ApplyChartTheme(Theme,Chart,-1);
end;

procedure ApplyChartTheme(Theme:TChartThemeClass; Chart:TCustomChart; PaletteIndex:Integer);
begin
  with Theme.Create(Chart) do
  try
    Apply;
  finally
    Free;
  end;

  if PaletteIndex<>-1 then
     Chart.ColorPaletteIndex:=PaletteIndex;
end;

procedure RegisterChartThemes(const Themes:Array of TChartThemeClass);
var t : Integer;
begin
  for t:=0 to Length(Themes)-1 do
      ChartThemes.Add(TObject(Themes[t]));
end;

function TThemesList.GetTheme(Index:Integer):TChartThemeClass;
begin
  result:=TChartThemeClass(Items[Index]);
end;

{ TFactsTheme }

type
  TSeriesAccess=class(TChartSeries);
  
procedure TFactsTheme.Apply;
const
  Color1 : TColor =128*256*256 + 128*256 + 128;
  Color2 : TColor =204*256*256 + 204*256 + 204;
  Color3 : TColor = 64*256*256 +  64*256 +  64;

var t         : Integer;
    tmpAxis   : TChartAxis;
    tmpSeries : TSeriesAccess;
begin
  inherited;

  ColorPalettes.ApplyPalette(Chart,9);

  with Chart do
  begin
    Color:=clWhite;
    Gradient.Visible:=False;

    for t:=0 to SeriesCount-1 do
    begin
      tmpSeries:=TSeriesAccess(Series[t]);

      with tmpSeries do
      begin
        Pen.Visible:=IMandatoryPen or ((not View3D) and IMandatoryPen2D);

        with Marks do
        begin
          Frame.Color:=Color1;
          Shadow.HorizSize:=2;
          Shadow.VertSize:=2;
          Shadow.Color:=Color2;
        end;
      end;
    end;

    with Legend do
    begin
      Pen.Color:=Color1;
      Pen.Visible:=False;
      Color:=clInfoBk;
      Shadow.Color:=Color2;
    end;

    with Title do
    begin
      Frame.Color:=Color1;
      Frame.Width:=1;
      Color:=clInfoBk;
      Transparent:=False;
      Gradient.Visible:=False;
      Alignment:=taLeftJustify;
      Font.Color:=clBlack;
      Font.Size:=10;
      Shadow.HorizSize:=0;
      Shadow.VertSize:=0;
    end;

    with Walls.Left do
    begin
      Visible:=True;
      Size:=4;
      Pen.Visible:=False;
    end;

    with Walls.Bottom do
    begin
      Visible:=True;
      Size:=4;
      Pen.Visible:=False;
    end;

    with Walls.Back do
    begin
      Visible:=True;
      Pen.Visible:=False;
    end;

    with Axes.Left do
    Begin
      Axis.Color:=Color3;
      Grid.Visible:=False;
    end;

    with Bands do
    begin
      if SeriesCount=0 then Axis:=Axes.Left
                       else Axis:=Series[0].GetVertAxis;

      Band1.Color := RGB(233,233,233); //7.05 TV52010198,TV52010527
      Band2.Color := clWhite;
    end;

    if SeriesCount=0 then tmpAxis:=Axes.Bottom
                     else tmpAxis:=Series[0].GetHorizAxis;

    with tmpAxis do
    begin
      Axis.Color:=Color3;
      Grid.Color:=Color2;
      Grid.Visible:=False;
    end;
  end;
end;

function TFactsTheme.Description: string;
begin
  result:=TeeMsg_ThemeFacts;
end;

function TFactsTheme.GetBands: TGridBandTool;
var tmp : String;
begin
  if not Assigned(FBands) then
  begin
    FBands:=TGridBandTool.Create(Chart.Owner);
    tmp:=FBands.ClassName;
    FBands.Name:=TeeGetUniqueName(Chart.Owner,Copy(tmp,2,Length(tmp)));
  end;

  result:=FBands;
end;

{ TRandomTheme }

type
  TShapeAccess=class(TTeeCustomShape);

procedure TRandomTheme.Apply;

  procedure RandomGradient(Gradient:TCustomTeeGradient);
  begin
    with Gradient do
    begin
       Balance:=Random(100);
//       Direction:=TGradientDirection(Random(High(TGradientDirection)));
       EndColor:=RandomColor;
       MidColor:=RandomColor;
       RadialX:=Random(200)-100;
       RadialY:=Random(200)-100;
       StartColor:=RandomColor;
       Visible:=RandomBoolean;
    end;
  end;

  procedure RandomShape(Shape:TTeeCustomShape);
  begin
    with Shape do
    begin
      Frame.Color:=RandomColor;
      Frame.Width:=Random(2);
      Color:=RandomColor;
      Transparent:=RandomBoolean;
      RandomGradient(Gradient);
      Font.Color:=RandomColor;
      Font.Size:=8+Random(10);
      Shadow.Size:=Random(5);
    end;

    TShapeAccess(Shape).Transparency:=Random(100);
  end;

  procedure RandomTitle(Title:TChartTitle);
  begin
    RandomShape(Title);

    case Random(3) of
      0: Title.Alignment:=taLeftJustify;
      1: Title.Alignment:=taRightJustify;
      2: Title.Alignment:=taCenter;
    end;
  end;

var t : Integer;
    tmpSeries : TChartSeries;
begin
  inherited;

  ColorPalettes.ApplyPalette(Chart,Random(ColorPalettes.Count));

  with Chart do
  begin
    Color:=RandomColor;
    RandomGradient(Gradient);

    for t:=0 to SeriesCount-1 do
    begin
      tmpSeries:=Series[t];

      with tmpSeries do
      begin
        Pen.Visible:=RandomBoolean;

        RandomShape(Marks);
        with Marks do
        begin
//          Style:=TSeriesMarksStyle(Random(High(TSeriesMarksStyle)));
        end;
      end;
    end;

    RandomShape(Legend);
    RandomTitle(Title);
    RandomTitle(SubTitle);
    RandomTitle(Foot);
    RandomTitle(SubFoot);

    RandomShape(Walls.Back);
    RandomShape(Walls.Bottom);
    RandomShape(Walls.Left);
    RandomShape(Walls.Right);

    Walls.Back.Transparent:=RandomBoolean;

    Walls.Size:=Random(10);
  end;
end;

procedure TRandomTheme.ChangeAxis(Axis: TChartAxis);
begin
  inherited;

  with Axis do
  begin
    Axis.Color:=RandomColor;
    Grid.Visible:=RandomBoolean;
    Grid.Color:=RandomColor;
  end;
end;

function TRandomTheme.Description: string;
begin
  result:=TeeMsg_ThemeRandom;
end;

function TRandomTheme.RandomBoolean: Boolean;
begin
  result:=Random(2)=1;
end;

class function TRandomTheme.RandomColor: TColor;
begin
  result:=RGB(Random(255),Random(255),Random(255));
end;

{ TOperaTheme }

procedure TOperaTheme.Apply;
const
  OperaFont='Verdana';

var t : Integer;
begin
  inherited;

  ColorPalettes.ApplyPalette(Chart,13);

  Chart.Title.Font.Name:=ThemeFontName(OperaFont);
  Chart.SubTitle.Font.Name:=ThemeFontName(OperaFont);
  Chart.Foot.Font.Name:=ThemeFontName(OperaFont);
  Chart.SubFoot.Font.Name:=ThemeFontName(OperaFont);

  Chart.Legend.Font.Name:=ThemeFontName(OperaFont);

  for t:=0 to Chart.Axes.Count-1 do
  with Chart.Axes[t] do
  begin
    LabelsFont.Name:=ThemeFontName(OperaFont);
    Axis.Color:=RGB(64,64,64);
    Title.Font.Name:=ThemeFontName(OperaFont);
    Grid.Color:=RGB(169,169,169);
    TicksInner.Color:=Grid.Color;
  end;

  with Chart.Gradient do
  begin
    Visible:=True;
    Direction:=gdTopBottom;
    StartColor:=RGB(234,234,234);
    MidColor:=StartColor;
    EndColor:=clWhite;
  end;

  Chart.Walls.Left.Color:=RGB(255,255,224);
  Chart.Walls.Right.Color:=RGB(255,255,224);

  Chart.Walls.Back.Transparent:=False;
  Chart.Walls.Back.Gradient:=Chart.Gradient;
  Chart.Walls.Back.Gradient.MidColor:=clNone;

  for t:=0 to Chart.SeriesCount-1 do
      Chart[t].Marks.Font.Name:=ThemeFontName(OperaFont);
end;

function TOperaTheme.Description: string;
begin
  result:='Opera';
end;

initialization
  ChartThemes:=TThemesList.Create;

  RegisterChartThemes([ TDefaultTheme,
                        TExcelTheme,
                        TClassicTheme,
                        TBusinessTheme,
                        TWebTheme,
                        TWindowsXPTheme,
                        TBlueSkyTheme,
                        TFactsTheme,
                        TRandomTheme,
                        TOperaTheme]);
finalization
  ChartThemes.Free;
end.
