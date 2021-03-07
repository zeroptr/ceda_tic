{**********************************************}
{   TPolarGridSeries                           }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeePolarGrid;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes, SysUtils,
  {$IFDEF CLX}
  QGraphics, QStdCtrls, QComCtrls, QControls, QExtCtrls,
  {$ELSE}
  Graphics, StdCtrls, ComCtrls, Controls, ExtCtrls,
  {$ENDIF}
  TeCanvas, TeeProcs, TeEngine, Chart, Series, TeePolar, TeeSurfa,
  TeePolarEditor, TeePenDlg;

type
  // Wrapper class around Custom3DPalette series properties.
  // This is just to publish the "Palette" property of TPolarGridSeries
  TGridColorPalette=class(TPersistent)
  private
    IPalette : TCustom3DPaletteSeries;
    function GetEndColor: TColor;
    function GetLegendEvery: Integer;
    function GetMidColor: TColor;
    function GetPalette: TCustom3DPalette;
    function GetPaletteMin: Double;
    function GetPaletteStep: Double;
    function GetPaletteSteps: Integer;
    function GetPaletteStyle: TTeePaletteStyle;
    function GetStartColor: TColor;
    function GetUseColorRange: Boolean;
    function GetUsePalette: Boolean;
    function GetUsePaletteMin: Boolean;
    procedure SetEndColor(const Value: TColor);
    procedure SetLegendEvery(const Value: Integer);
    procedure SetMidColor(const Value: TColor);
    procedure SetPalette(const Value: TCustom3DPalette);
    procedure SetPaletteMin(const Value: Double);
    procedure SetPaletteStep(const Value: Double);
    procedure SetPaletteSteps(const Value: Integer);
    procedure SetPaletteStyle(const Value: TTeePaletteStyle);
    procedure SetStartColor(const Value: TColor);
    procedure SetUseColorRange(const Value: Boolean);
    procedure SetUsePalette(const Value: Boolean);
    procedure SetUsePaletteMin(const Value: Boolean);
  public
    // Palette should not be published.
    property Palette:TCustom3DPalette read GetPalette write SetPalette;
  published
    property EndColor:TColor read GetEndColor write SetEndColor default clWhite;
    property MidColor:TColor read GetMidColor write SetMidColor default clNone;
    property LegendEvery:Integer read GetLegendEvery write SetLegendEvery default 1;
    property PaletteMin:Double read GetPaletteMin write SetPaletteMin;
    property PaletteStep:Double read GetPaletteStep write SetPaletteStep;
    property PaletteSteps:Integer read GetPaletteSteps write SetPaletteSteps default 32;
    property PaletteStyle:TTeePaletteStyle read GetPaletteStyle write SetPaletteStyle default psPale;
    property StartColor:TColor read GetStartColor write SetStartColor default clNavy;
    property UseColorRange:Boolean read GetUseColorRange write SetUseColorRange default True;
    property UsePalette:Boolean read GetUsePalette write SetUsePalette default False;
    property UsePaletteMin:Boolean read GetUsePaletteMin write SetUsePaletteMin default False;
  end;

  TPolarGridSeries=class(TCustomPolarSeries)
  private
    FCentered   : Boolean;
    FNumSectors : Integer;
    FNumTracks  : Integer;
    FPalette    : TGridColorPalette;
    FValues     : TChartValueList;

    IChart    : TCustomChart;
    I3D       : TCustom3DPaletteSeries;

    function InternalX(ValueIndex:Integer):TChartValue;
    procedure SetCentered(const Value: Boolean);
    procedure SetPalette(const Value: TGridColorPalette);
    procedure SetValues(const Value: TChartValueList);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    procedure CellPolygon(ValueIndex:Integer; var P:TFourPoints);
    Procedure DoAfterDrawValues; override;
    Procedure DoBeforeDrawChart; override;
    Procedure DrawPolarCircle(HalfWidth,HalfHeight,Z:Integer); override;
    procedure DrawValue(ValueIndex:Integer); override;
    Function GetCircleLabel(Const Angle:Double; Index:Integer):String; override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;

    Function AddCell(const Sector,Track:Integer; const Value:TChartValue):Integer;
    Function CalcXPos(ValueIndex:Integer):Integer; override;
    Function CalcYPos(ValueIndex:Integer):Integer; override;
    Function Clicked(x,y:Integer):Integer; override;
    Function CountLegendItems:Integer; override;
    function GetCellColor(const Value:TChartValue):TColor;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;

    // Palette should not be published.
    property Palette:TGridColorPalette read FPalette write SetPalette;
  published
    property CellValues:TChartValueList read FValues write SetValues;
    property Centered:Boolean read FCentered write SetCentered default True;
    property NumSectors:Integer read FNumSectors write FNumSectors default 10;
    property NumTracks:Integer read FNumTracks write FNumTracks default 10;

    { Published declarations }
    property Active;
    property ColorEachPoint;
    property HorizAxis;
    property SeriesColor;
    property VertAxis;

    property AngleIncrement;
    property AngleValues;
    property Brush;
    property CircleBackColor;
    property CircleGradient;
    property CircleLabels;
    property CircleLabelsFont;
    property CircleLabelsInside;
    property CircleLabelsRotated;
    property CirclePen;
    property ClockWiseLabels;
    property LabelsMargin;
    property Pen;
    property RadiusIncrement;
    property RadiusValues;
    property RotationAngle default 90;
    property Transparency;
    property TreatNulls;

    { events }
    property OnGetCircleLabel;
  end;

  TPolarGridEditor = class(TPolarSeriesEditor)
    TabPalette: TTabSheet;
    CBCentered: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBCenteredClick(Sender: TObject);
  private
    { Private declarations }
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
  Math, TeeProCo, TeeGriEd;

type
  // Links the internal Palette series with an external Chart, to enable
  // "invalidate".
  TSpecialChart=class(TCustomChart)
  private
    ILink : TChartSeries;
  public
    procedure Invalidate; override;
  end;

  // Internal class with published properties so the TGrid3DSeriesEditor
  // can find them via reflection (RTTI).
  TPaletteSeries=class(TCustom3DPaletteSeries)
  published
    property EndColor;
    property MidColor;
    property LegendEvery;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
  end;

{ TPolarGridSeries }

Constructor TPolarGridSeries.Create(AOwner: TComponent);
begin
  inherited;
  FValues:=TChartValueList.Create(Self,'Values'); { <-- dont translate ! }

  RotationAngle:=90;

  FCentered:=True;
  FNumSectors:=10;
  FNumTracks:=10;

  CalcVisiblePoints:=False;
  XValues.Name:='Sectors';
  XValues.Order:=loNone;
  YValues.Name:='Tracks';

  I3D:=TPaletteSeries.Create(nil);
  IChart:=TSpecialChart.Create(nil);
  TSpecialChart(IChart).ILink:=Self;
  I3D.ParentChart:=IChart;

  FPalette:=TGridColorPalette.Create;
  FPalette.IPalette:=I3D;

  Pen.Color:=clBlack;
  Brush.Style:=bsSolid;

  Pointer.Hide;
end;

function TPolarGridSeries.AddCell(const Sector, Track: Integer;
  const Value: TChartValue): Integer;
begin
  FValues.TempValue:=Value;
  result:=AddXY(Sector,Track);
end;

procedure TPolarGridSeries.Assign(Source: TPersistent);
begin
  if Source is TPolarGridSeries then
  with TPolarGridSeries(Source) do
  begin
    Self.CellValues:=CellValues;
    Self.FCentered:=FCentered;
    Self.FNumSectors:=FNumSectors;
    Self.FNumTracks:=FNumTracks;
    Self.Palette:=Palette;
  end;

  inherited;
end;

function TPolarGridSeries.IsValidSourceOf(Value: TChartSeries): Boolean;
begin
  result:=Value is TPolarGridSeries;
end;

Destructor TPolarGridSeries.Destroy;
begin
  FPalette.Free;
  I3D.Free;
  IChart.Free;
  inherited;
end;

procedure TPolarGridSeries.AddSampleValues(NumValues: Integer;
  OnlyMandatory: Boolean);
var Sector : Integer;
    Track  : Integer;
    tmp    : TChartValue;
begin
  NumSectors:=NumValues;
  NumTracks:=NumValues;

  BeginUpdate;

  for Sector:=0 to NumSectors-1 do
      for Track:=0 to NumTracks-1 do
      begin
        tmp:=0.5*Sqr(Cos(Sector/(NumSectors*0.2)))+
                 Sqr(Cos(Track/(NumTracks*0.2)))-
                 Cos(Track/(NumTracks*0.5));

        AddCell(Sector,Track,tmp);
      end;

  EndUpdate;
end;

Procedure TPolarGridSeries.PrepareForGallery(IsEnabled:Boolean);
Begin
  inherited;
  FillSampleValues(8);
end;

function TPolarGridSeries.InternalX(ValueIndex:Integer):TChartValue;
begin
  if Centered then result:=XValue[ValueIndex]-0.5
              else result:=XValue[ValueIndex];

  result:=result*360.0/NumSectors;

  if ClockWiseLabels then
     result:=360-result;
end;

Function TPolarGridSeries.CalcXPos(ValueIndex:Integer):Integer;
var tmp : Integer;
begin
  CalcXYPosition(InternalX(ValueIndex),YValues[ValueIndex],XRadius,result,tmp);
end;

Function TPolarGridSeries.CalcYPos(ValueIndex:Integer):Integer;
var tmp : Integer;
begin
  CalcXYPosition(InternalX(ValueIndex),YValues[ValueIndex],YRadius,tmp,result);
end;

procedure TPolarGridSeries.CellPolygon(ValueIndex:Integer; var P:TFourPoints);
var xx,yy : Integer;
    tmpInc,
    tmpX : TChartValue;
    tmpY : TChartValue;
    tmpOff : TChartValue;
begin
  P[0].x:=CalcXPos(ValueIndex);
  P[0].y:=CalcYPos(ValueIndex);

  tmpInc:=360.0/NumSectors;
  tmpY:=YValues[ValueIndex];

  if Centered then
     tmpOff:=0.5
  else
     tmpOff:=0;

  tmpX:=(XValues[ValueIndex]-tmpOff+1)*tmpInc;
  if ClockWiseLabels then
     tmpX:=360-tmpX;

  CalcXYPosition(tmpX,tmpY,XRadius,P[1].x,yy);
  CalcXYPosition(tmpX,tmpY,YRadius,xx,P[1].y);

  if tmpY>0 then
  begin
    tmpY:=tmpY-1;
    tmpX:=(XValues[ValueIndex]-tmpOff)*tmpInc;

    if ClockWiseLabels then
       tmpX:=360-tmpX;

    CalcXYPosition(tmpX,tmpY,XRadius,P[3].x,yy);
    CalcXYPosition(tmpX,tmpY,YRadius,xx,P[3].y);

    tmpX:=(XValues[ValueIndex]-tmpOff+1)*tmpInc;

    if ClockWiseLabels then
       tmpX:=360-tmpX;

    CalcXYPosition(tmpX,tmpY,XRadius,P[2].x,yy);
    CalcXYPosition(tmpX,tmpY,YRadius,xx,P[2].y);
  end
  else
  begin
    P[3].X:=CircleXCenter;
    P[3].Y:=CircleYCenter;
    P[2]:=P[3];
  end;
end;

type
  TPaletteAccess=class(TCustom3DPaletteSeries);

function TPolarGridSeries.GetCellColor(const Value:TChartValue):TColor;
begin
  result:=TPaletteAccess(I3D).GetValueColorValue(Value);
end;

procedure TPolarGridSeries.DrawValue(ValueIndex: Integer);
var tmpColor : TColor;
    tmpBlend : TTeeBlend;
    P        : TFourPoints;
begin
  tmpColor:=InternalColor(ValueIndex);

  if (tmpColor<>clNone) or (TreatNulls=tnIgnore) then
  begin
    if tmpColor=clTeeColor then
       if (not ColorEachPoint) and (I3D.UseColorRange or I3D.UsePalette) then
           tmpColor:=GetCellColor(CellValues[ValueIndex])
       else
           tmpColor:=GetValueColor(ValueIndex);

    CellPolygon(ValueIndex,P);

    with ParentChart.Canvas do
    begin
      AssignVisiblePen(Self.Pen);
      Brush.Color:=tmpColor;

      if Transparency<>0 then
         tmpBlend:=BeginBlending(RectFromPolygon(P,Length(P)),Transparency)
      else
         tmpBlend:=nil;

      if ParentChart.View3D then
         PolygonWithZ(P,MiddleZ)
      else
         Polygon(P);

      if Assigned(tmpBlend) then
         EndBlending(tmpBlend);
    end;
  end;
end;

class function TPolarGridSeries.GetEditorClass: String;
begin
  result:='TPolarGridEditor';
end;

procedure TPolarGridSeries.DoBeforeDrawChart;
begin
  I3D.BeginUpdate;
  I3D.Clear;
  I3D.AddXYZ(0,CellValues.MinValue,0);
  I3D.AddXYZ(0,CellValues.MaxValue,0);
  I3D.Color:=Color;
  TPaletteAccess(I3D).DoBeforeDrawChart;
  I3D.EndUpdate;

  AngleIncrement:=360.0/NumSectors;

  inherited;
end;

function TPolarGridSeries.CountLegendItems: Integer;
begin
  result:=I3D.CountLegendItems;
end;

function TPolarGridSeries.LegendItemColor(LegendIndex: Integer): TColor;
begin
  result:=I3D.LegendItemColor(LegendIndex);
end;

function TPolarGridSeries.LegendString(LegendIndex: Integer;
  LegendTextStyle: TLegendTextStyle): String;
begin
  result:=I3D.LegendString(LegendIndex,LegendTextStyle);
end;

procedure TPolarGridSeries.SetPalette(const Value: TGridColorPalette);
begin
  FPalette.Assign(Value);
end;

procedure TPolarGridSeries.SetValues(const Value: TChartValueList);
begin
  FValues.Assign(Value);
end;

function TPolarGridSeries.GetCircleLabel(const Angle: Double;
  Index: Integer): String;
begin
  if (Index>0) and ClockWiseLabels then
     Index:=NumSectors-Index;

  result:=IntToStr(Index);
end;

Procedure TPolarGridSeries.DrawPolarCircle(HalfWidth,HalfHeight,Z:Integer);
var P    : TPoint;
    tmp  : Double;
    t    : Integer;
    tmpOff : TChartValue;
begin
  if Centered then tmpOff:=0.5
              else tmpOff:=0;

  tmp:=PiDegree*AngleIncrement;

  AngleToPos(tmpOff*tmp,HalfWidth,HalfHeight,P.X,P.Y);

  With ParentChart.Canvas do
  begin
    MoveTo3D(P.X,P.Y,Z);

    for t:=0 to NumSectors do
    begin
      AngleToPos((t+tmpOff)*tmp,HalfWidth,HalfHeight,P.X,P.Y);
      LineTo3D(P.X,P.Y,Z);
    end;
  end;
end;

procedure TPolarGridSeries.DoAfterDrawValues;
begin
  ParentChart.Canvas.AssignVisiblePen(CirclePen);
  DrawPolarCircle(CircleWidth div 2,CircleHeight div 2,EndZ);
  inherited;
end;

procedure TPolarGridSeries.SetCentered(const Value: Boolean);
begin
  SetBooleanProperty(FCentered,Value);
end;

function TPolarGridSeries.Clicked(x, y: Integer): Integer;
var t   : Integer;
    P   : TFourPoints;
    tmp : TPoint;
begin
  result:=TeeNoPointClicked;

  if Count>0 then
  begin
    if Assigned(ParentChart) then
       ParentChart.Canvas.Calculate2DPosition(X,Y,StartZ);

    tmp.X:=X;
    tmp.Y:=Y;

    for t:=0 to Count-1 do
    if not IsNull(t) then
    begin
      CellPolygon(t,P);

      if PointInPolygon(tmp,P) then
      begin
        result:=t;
        break;
      end;
    end;
  end;
end;

{ TSpecialChart }

procedure TSpecialChart.Invalidate;
begin
  if Assigned(ILink) then
     ILink.Repaint;
end;

{ TGridColorPalette }

function TGridColorPalette.GetEndColor: TColor;
begin
  result:=IPalette.EndColor;
end;

function TGridColorPalette.GetLegendEvery: Integer;
begin
  result:=IPalette.LegendEvery;
end;

function TGridColorPalette.GetMidColor: TColor;
begin
  result:=IPalette.MidColor;
end;

function TGridColorPalette.GetPalette: TCustom3DPalette;
begin
  result:=IPalette.Palette;
end;

function TGridColorPalette.GetPaletteMin: Double;
begin
  result:=IPalette.PaletteMin;
end;

function TGridColorPalette.GetPaletteStep: Double;
begin
  result:=IPalette.PaletteStep;
end;

function TGridColorPalette.GetPaletteSteps: Integer;
begin
  result:=IPalette.PaletteSteps;
end;

function TGridColorPalette.GetPaletteStyle: TTeePaletteStyle;
begin
  result:=IPalette.PaletteStyle;
end;

function TGridColorPalette.GetStartColor: TColor;
begin
  result:=IPalette.StartColor;
end;

function TGridColorPalette.GetUseColorRange: Boolean;
begin
  result:=IPalette.UseColorRange;
end;

function TGridColorPalette.GetUsePalette: Boolean;
begin
  result:=IPalette.UsePalette;
end;

function TGridColorPalette.GetUsePaletteMin: Boolean;
begin
  result:=IPalette.UsePaletteMin;
end;

procedure TGridColorPalette.SetEndColor(const Value: TColor);
begin
  IPalette.EndColor:=Value;
end;

procedure TGridColorPalette.SetLegendEvery(const Value: Integer);
begin
  IPalette.LegendEvery:=Value;
end;

procedure TGridColorPalette.SetMidColor(const Value: TColor);
begin
  IPalette.MidColor:=Value;
end;

procedure TGridColorPalette.SetPalette(const Value: TCustom3DPalette);
begin
  IPalette.Palette:=Value;
end;

procedure TGridColorPalette.SetPaletteMin(const Value: Double);
begin
  IPalette.PaletteMin:=Value;
end;

procedure TGridColorPalette.SetPaletteStep(const Value: Double);
begin
  IPalette.PaletteStep:=Value;
end;

procedure TGridColorPalette.SetPaletteSteps(const Value: Integer);
begin
  IPalette.PaletteSteps:=Value;
end;

procedure TGridColorPalette.SetPaletteStyle(const Value: TTeePaletteStyle);
begin
  IPalette.PaletteStyle:=Value;
end;

procedure TGridColorPalette.SetStartColor(const Value: TColor);
begin
  IPalette.StartColor:=Value;
end;

procedure TGridColorPalette.SetUseColorRange(const Value: Boolean);
begin
  IPalette.UseColorRange:=Value;
end;

procedure TGridColorPalette.SetUsePalette(const Value: Boolean);
begin
  IPalette.UsePalette:=Value;
end;

procedure TGridColorPalette.SetUsePaletteMin(const Value: Boolean);
begin
  IPalette.UsePaletteMin:=Value;
end;

procedure TPolarGridEditor.FormShow(Sender: TObject);
var I3DEditor : TGrid3DSeriesEditor;
begin
  inherited;

  CBCentered.Top:=CBClose.Top;
  CBClose.Hide;
//  CBClockWise.Hide;

  I3DEditor:=TGrid3DSeriesEditor.Create(nil);
  I3DEditor.Panel1.Hide;

  if Assigned(Polar) then
  begin
    AddFormTo(I3DEditor,TabPalette,TPolarGridSeries(Polar).I3D);
    TeeTranslateControl(I3DEditor);
    CBCentered.Checked:=TPolarGridSeries(Polar).Centered;
  end;
end;

procedure TPolarGridEditor.CBCenteredClick(Sender: TObject);
begin
  TPolarGridSeries(Polar).Centered:=CBCentered.Checked;
end;

initialization
  RegisterTeeSeries(TPolarGridSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_PolarGridSeries,
                                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
  RegisterClass(TPolarGridEditor);
finalization
  UnRegisterTeeSeries([TPolarGridSeries]);
end.
