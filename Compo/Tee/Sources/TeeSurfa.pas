{**********************************************}
{  TeeChart Pro                                }
{                                              }
{   TCustom3DSeries                            }
{    TCustom3DPaletteSeries                    }
{     TVector3DSeries                          }
{     TCustom3DGridSeries                      }
{      TSurfaceSeries                          }
{      TContourSeries                          }
{      TWaterFallSeries                        }
{      TColorGridSeries                        }
{      TTowerSeries                            }
{                                              }
{  Functions:                                  }
{                                              }
{   TSmoothPoints                              }
{                                              }
{  Copyright (c) 1995-2009 by David Berneda    }
{**********************************************}
unit TeeSurfa;
{$I TeeDefs.inc}

interface

{$DEFINE LEVELSEGMENTS} // <--- For TContourSeries only.

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     Qt, QGraphics,
     {$ELSE}
     Graphics,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     TeeProcs, TeEngine, TeCanvas, TeeFilters;

type
  TArrayGrid=Array of TChartValues;

  TCustom3DSeries=class(TChartSeries)
  private
    FTimesZOrder : Integer;
    FZValues     : TChartValueList;
    Function BackFaced:Boolean;
    Function GetZValue(Index:Integer):TChartValue; { 5.02 }
    Procedure SetTimesZOrder(Const Value:Integer);
    Procedure SetZValue(Index:Integer; Const Value:TChartValue); { 5.02 }
    Procedure SetZValues(Const Value:TChartValueList);
  protected
    Procedure CalcZOrder; override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure PrepareLegendCanvas( ValueIndex:Integer; Var BackColor:TColor;
                                   Var BrushStyle:TBrushStyle); override;
    Function ValueListOfAxis(Axis:TChartAxis):TChartValueList; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Procedure Assign(Source:TPersistent); override;

    Procedure AddArray(Const Values:TArrayGrid); overload;
    Function AddXYZ(Const AX,AY,AZ:TChartValue):Integer; overload;
    Function AddXYZ(Const AX,AY,AZ:TChartValue;
                    Const AXLabel:String; AColor:TColor):Integer; overload; virtual;
    Function AssociatedToAxis(Axis:TChartAxis):Boolean; override;

    Function CalcZPos(ValueIndex:Integer):Integer;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxZValue:Double; override;
    Function MinZValue:Double; override;
    property ZValue[Index:Integer]:TChartValue read GetZValue write SetZValue;

    { to be published }
    property TimesZOrder:Integer read FTimesZOrder write SetTimesZOrder default 3;
    property ZValues:TChartValueList read FZValues write SetZValues;
  end;

  TGridPalette=packed record
    UpToValue : TChartValue;
    Color     : TColor;
  end;

  TCustom3DPalette=Array of TGridPalette;

  TTeePaletteStyle=(psPale,psStrong,psGrayScale,psInvGray,psRainbow,psCustom);

  TChartSurfaceGetColor=Procedure( Sender:TChartSeries;
                                   ValueIndex:Integer;
                                   Var Color:TColor) of object;

  TCustom3DPaletteSeries=class(TCustom3DSeries)
  private
    FEndColor     : TColor;
    FMidColor     : TColor;

    FPalette      : TCustom3DPalette;
    FLegendEvery  : Integer;
    FPaletteMin   : Double;    // overrides automatic palette generation
    FPaletteStep  : Double;    // overrides automatic palette generation
    FPaletteSteps : Integer;
    FPaletteStyle : TTeePaletteStyle;

    FStartColor   : TColor;
    FUseColorRange: Boolean;
    FUsePalette   : Boolean;
    FUsePaletteMin: Boolean;   // overrides automatic palette generation

    FOnGetColor   : TChartSurfaceGetColor;

    { internal }
    IRangeRed    : Integer;
    IEndRed      : Integer;
    IMidRed      : Integer;
    IRangeMidRed : Integer;
    IRangeGreen  : Integer;
    IEndGreen    : Integer;
    IMidGreen    : Integer;
    IRangeMidGreen: Integer;
    IRangeBlue   : Integer;
    IEndBlue     : Integer;
    IMidBlue     : Integer;
    IRangeMidBlue: Integer;
    IValueRangeInv: Double;

    Procedure CalcColorRange;
    procedure CalcValueRange;
    Procedure CheckPaletteEmpty;
    Function LegendPaletteIndex(LegendIndex:Integer):Integer;
    Function RangePercent(const Percent:Double):TColor;
    procedure ReadPalette(Stream: TStream);
    Procedure SetEndColor(Const Value:TColor);
    Procedure SetGalleryPalette;
    procedure SetLegendEvery(const Value: Integer);
    Procedure SetMidColor(Const Value:TColor);
    procedure SetPalette(const Value: TCustom3DPalette);
    procedure SetPaletteMin(const Value: Double);
    procedure SetPaletteStep(const Value: Double);
    Procedure SetPaletteSteps(Const Value:Integer);
    procedure SetPaletteStyle(const Value: TTeePaletteStyle);
    Procedure SetStartColor(Const Value:TColor);
    Procedure SetUseColorRange(Const Value:Boolean);
    Procedure SetUsePalette(Const Value:Boolean);
    procedure SetUsePaletteMin(const Value: Boolean);
    procedure WritePalette(Stream: TStream);
  protected
    PaletteRange : Double;

    Procedure AddValues(Source:TChartSeries); override;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DefineProperties(Filer:TFiler); override;
    Procedure DoBeforeDrawChart; override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    procedure GeneratePalette;
    class Function GetEditorClass:String; override;
    Function GetValueColor(ValueIndex:Integer):TColor; override;
    Function GetValueColorValue(Const AValue:TChartValue):TColor;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    RedFactor    : Double;
    GreenFactor  : Double;
    BlueFactor   : Double;

    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Function AddPalette(Const AValue:TChartValue; AColor:TColor):Integer; overload;
    procedure AddPalette(Const APalette:TColorArray); overload;

    {$IFNDEF CLR}
    procedure AddPalette(Const APalette:Array of TColor); overload;
    {$ENDIF}

    Procedure Assign(Source:TPersistent); override;
    Procedure Clear; override;
    Procedure ClearPalette;
    Function CountLegendItems:Integer; override;
    Procedure CreateDefaultPalette(NumSteps:Integer=0);
    Procedure CreateRangePalette;
    Function GetSurfacePaletteColor(Const Y:TChartValue):TColor;
    procedure InvertPalette; // 8.0
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;

    property EndColor:TColor read FEndColor write SetEndColor default clWhite;
    property MidColor:TColor read FMidColor write SetMidColor default clNone;
    property LegendEvery:Integer read FLegendEvery write SetLegendEvery default 1;
    property Palette:TCustom3DPalette read FPalette write SetPalette;
    property PaletteMin:Double read FPaletteMin write SetPaletteMin; // 5.03
    property PaletteStep:Double read FPaletteStep write SetPaletteStep; // 5.03
    property PaletteSteps:Integer read FPaletteSteps write SetPaletteSteps default 32;
    property PaletteStyle:TTeePaletteStyle read FPaletteStyle write SetPaletteStyle default psPale;
    property StartColor:TColor read FStartColor write SetStartColor default clNavy;
    property UseColorRange:Boolean read FUseColorRange write SetUseColorRange default True;
    property UsePalette:Boolean read FUsePalette write SetUsePalette default False;
    property UsePaletteMin:Boolean read FUsePaletteMin write SetUsePaletteMin default False; // 5.03

    { events }
    property OnGetColor:TChartSurfaceGetColor read FOnGetColor write FOnGetColor;
  end;

  { Grid 3D series }
  TChartSurfaceGetY=Function(Sender:TChartSeries; X,Z:Integer):Double of object;

  TCustom3DGridSeries=class(TCustom3DPaletteSeries)
  private
    FIrregularGrid : Boolean;
    FNumXValues    : Integer;
    FNumZValues    : Integer;
    FOnGetYValue   : TChartSurfaceGetY;
    FXStartIndex    : Integer;
    FZStartIndex    : Integer;

    { internal }
    INextXCell : Integer;
    INextZCell : Integer;

    Function ExistFourGridIndex(X,Z:Integer):Boolean;
    Procedure InitGridIndex(XCount,ZCount:Integer);
    Procedure SetIrregularGrid(Const Value:Boolean);
    Procedure SetNumXValues(Value:Integer);
    Procedure SetNumZValues(Value:Integer);
    function GetValue(X, Z: Integer): TChartValue;
    procedure SetValue(X, Z: Integer; const Value: TChartValue);
  protected
    ValueIndex0    : Integer;
    ValueIndex1    : Integer;
    ValueIndex2    : Integer;
    ValueIndex3    : Integer;

    IInGallery : Boolean;
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure AddValues(Source:TChartSeries); override;
    Procedure DoBeforeDrawChart; override;

  {$IFDEF CLR}
  public
  {$ENDIF}
    Function CanCreateValues:Boolean;
  public
    GridIndex      : packed Array of Array of Integer;

    // 7.0  When True, the slow "FillGridIndex" method is not called and it is
    // the programmer's responsability to fill the GridIndex array correctly.
    ReuseGridIndex : Boolean;

    Constructor Create(AOwner: TComponent); override;

    Procedure Assign(Source:TPersistent); override;

    Procedure Clear; override;
    Procedure CreateValues(NumX,NumZ:Integer); virtual;

    Procedure FillGridIndex; overload;
    Procedure FillGridIndex(StartIndex:Integer); overload;

    Function GetXZValue(X,Z:Integer):TChartValue; virtual;
    Function IsValidSeriesSource(Value:TChartSeries):Boolean; override;
    Function NumSampleValues:Integer; override;
    Procedure ReCreateValues;

    property IrregularGrid:Boolean read FIrregularGrid write SetIrregularGrid default False;

    property NumXValues:Integer read FNumXValues write SetNumXValues default 10;
    property NumZValues:Integer read FNumZValues write SetNumZValues default 10;
    property Value[X,Z:Integer]:TChartValue read GetValue write SetValue;

    { events }
    property OnGetYValue:TChartSurfaceGetY read FOnGetYValue write FOnGetYValue;
  end;

  TCellsOrientation=packed record
       InitX,
       EndX,
       IncX,
       InitZ,
       EndZ,
       IncZ : Integer;
  end;

  TSurfaceSeries=class(TCustom3DGridSeries)
  private
    { Private declarations }
    FDotFrame       : Boolean;
    FFastBrush      : Boolean;
    FHideCells      : Boolean;
    FSideBrush      : TChartBrush;
    FSideLines      : TChartHiddenPen;
    FSmoothPalette  : Boolean;
    FTransparency   : TTeeTransparency; // 5.03
    FWaterFall      : Boolean;
    FWaterLines     : TChartPen;
    FWireFrame      : Boolean;

    { internal }
    FSameBrush      : Boolean;

    {$IFNDEF TEEOPTCALCPOS}
    ICalcX          : TAxisCalcPos;
    ICalcY          : TAxisCalcPos;
    IXValue         : TChartValues;
    IYValue         : TChartValues;
    {$ENDIF}

    Procedure PrepareCalcPos;
    Procedure SetDotFrame(Value:Boolean);
    procedure SetFastBrush(const Value: Boolean);
    procedure SetHideCells(const Value: Boolean);
    Procedure SetSideBrush(Value:TChartBrush);
    Procedure SetSideLines(Value:TChartHiddenPen);
    Procedure SetSmoothPalette(Value:Boolean);
    procedure SetTransparency(const Value: TTeeTransparency);
    Procedure SetWaterFall(Value:Boolean);
    Procedure SetWireFrame(Value:Boolean);
    procedure SetWaterLines(const Value: TChartPen);
  protected
    { Protected declarations }
    Points : TFourPoints;

    {$IFNDEF CLX}
    IsFastBrush : Boolean;
    DCBRUSH     : HGDIOBJ;
    CanvasDC    : TTeeCanvasHandle;
    {$ENDIF}

    IBlender    : TTeeBlend;

    Function CalcPointPos(const Index:Integer):TPoint;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawAllValues; override;
    Procedure DrawCell(x,z:Integer); virtual;
    Procedure DrawSidePortion(var P:TFourPoints; z0,z1:Integer); virtual;
    Procedure DrawValue(ValueIndex:Integer); override;
    Function FastCalcPoints( x,z:Integer;
                             Var P0,P1:TPoint3D;
                             Var Color0,Color1:TColor):Boolean;
    Function FourGridIndex(x,z:Integer):Boolean;
    class Function GetEditorClass:String; override;

    Procedure PointsTo2D(Z0,Z1:Integer; var P:TFourPoints);

    {$IFNDEF CLX}
    procedure PrepareFastBrush;
    {$ENDIF}

    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetBrushColor(const AColor:TColor);
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
    function ShouldDrawFast:Boolean; virtual;
    function ShouldDrawSides:Boolean; virtual;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    Function CellsOrientation:TCellsOrientation;
    Function Clicked(x,y:Integer):Integer; override;

    property WaterFall:Boolean read FWaterFall write SetWaterFall default False;
    property WaterLines:TChartPen read FWaterLines write SetWaterLines;
  published
    { Published declarations }
    property Active;
    property ColorSource;
    property Cursor;
    property FastBrush:Boolean read FFastBrush write SetFastBrush default False;  // 7.0
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

    property Brush;
    property DotFrame:Boolean read FDotFrame write SetDotFrame default False;
    property EndColor;
    property HideCells:Boolean read FHideCells write SetHideCells default False;
    property IrregularGrid;
    property MidColor;
    property NumXValues;
    property NumZValues;
    property LegendEvery;
    property Pen;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property SideBrush:TChartBrush read FSideBrush write SetSideBrush;
    property SideLines:TChartHiddenPen read FSideLines write SetSideLines;
    property SmoothPalette:Boolean read FSmoothPalette write SetSmoothPalette default False;
    property StartColor;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property WireFrame:Boolean read FWireFrame write SetWireFrame default False;
    property TimesZOrder;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
    property XValues;
    property YValues;
    property ZValues;
    { events }
    property OnGetYValue;
    property OnGetColor;
  end;

  TContourSeries=class;

  TOnBeforeDrawLevelEvent=procedure( Sender:TContourSeries;
                                     LevelIndex:Integer) of object;

  TOnGetLevelEvent=procedure( Sender:TContourSeries; LevelIndex:Integer;
                            Var Value:Double; Var Color:TColor) of object;

  {$IFDEF LEVELSEGMENTS}
  TLevelPoint=packed record
     X,Y: TChartValue;
  end;

  TLevelSegment=packed record
    Count  : Integer;
    Points : packed Array of TLevelPoint;
  end;

  TLevelSegments=Array of TLevelSegment;
  {$ENDIF}

  TContourLevel=class(TCollectionItem)
  private
    FColor  : TColor;
    FPen    : TChartPen;
    FUpTo   : Double;

    ISeries : TContourSeries;

    {$IFDEF LEVELSEGMENTS}
    FSegmentCount : Integer;
    FSegments     : TLevelSegments;
    {$ENDIF}

    Procedure CheckAuto;
    function GetPen: TChartPen;
    function IsPenStored: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetPen(const Value: TChartPen);
    procedure SetUpTo(const Value: Double);
  protected
    function InternalColor:TColor;
    function InternalPen:TChartPen;
  public
    Constructor Create(Collection:TCollection); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override; { 5.01 }

    {$IFDEF LEVELSEGMENTS}
    Procedure ClearSegments;
    Function Clicked(x,y:Integer; Var SegmentIndex,PointIndex:Integer):Boolean;
    Function ClickedSegment(x,y,SegmentIndex:Integer; Var PointIndex:Integer):Boolean;
    Function GetSegmentPoints(SegmentIndex:Integer):TPointArray;
    {$ENDIF}

    Function DefaultPen:Boolean;

    {$IFDEF LEVELSEGMENTS}
    function SegmentCount:Integer; {$IFDEF 10}inline;{$ENDIF}
    property Segments:TLevelSegments read FSegments;
    {$ENDIF}
  published
    property Color:TColor read FColor write SetColor;
    property Pen:TChartPen read GetPen write SetPen stored IsPenStored; // 5.03
    property UpToValue:Double read FUpTo write SetUpTo;
  end;

  TContourLevels=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TContourLevel;
    Procedure Put(Index:Integer; Const Value:TContourLevel);
  public
    function AddLevel(const Value:Double; Color:TColor):TContourLevel;

    {$IFDEF LEVELSEGMENTS}
    Function Clicked(x,y:Integer; Var SegmentIndex,PointIndex:Integer):Integer;
    {$ENDIF}
    property Items[Index:Integer]:TContourLevel read Get write Put; default;
  end;

  TSmoothPoints=class(TPersistent)
  private
    FActive : Boolean;
    ISeries : TChartSeries;
    FInterpolate: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetInterpolate(const Value: Boolean);
  public
    Factor : Integer;
    Constructor Create(Parent:TChartSeries);
    Procedure Assign(Source:TPersistent); override;
    Function Calculate(Const P:Array of TPoint):TPointArray;
  published
    property Active:Boolean read FActive write SetActive default False;
    property Interpolate:Boolean read FInterpolate write SetInterpolate default False;
  end;

  TContourMarks=class(TPersistent)
  private
    FAntiOverlap : Boolean;
    FAtSegments  : Boolean;
    FColorLevel  : Boolean;
    FDensity     : Integer;
    FMargin      : Integer;

    IContour : TChartSeries;
    function GetVisible: Boolean;
    procedure SetAntiOverlap(const Value: Boolean);
    procedure SetAtSegments(const Value: Boolean);
    procedure SetColorLevel(const Value: Boolean);
    procedure SetDensity(const Value: Integer);
    procedure SetMargin(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
  public
    Constructor Create;
    procedure Assign(Source:TPersistent); override;
  published
    property AntiOverlap:Boolean read FAntiOverlap write SetAntiOverlap default False;
    property AtSegments:Boolean read FAtSegments write SetAtSegments default True;
    property ColorLevel:Boolean read FColorLevel write SetColorLevel default False;
    property Margin:Integer read FMargin write SetMargin default 0;
    property Density:Integer read FDensity write SetDensity default 4;
    property Visible:Boolean read GetVisible write SetVisible stored False;
  end;

  TContourSeries=class(TCustom3DGridSeries)
  private
    FAutomaticLevels: Boolean;
    FContourMarks   : TContourMarks;
    FLegendLines    : Boolean;
    FLevels         : TContourLevels;
    FLinesColor     : TColor;
    FNumLevels      : Integer;
    FPointer        : TSeriesPointer;
    FSmoothing      : TSmoothPoints;
    FTransparency   : TTeeTransparency;
    FYPosition      : TChartValue;
    FYPositionLevel : Boolean;

    FOnBeforeDrawLevel : TOnBeforeDrawLevelEvent;
    FOnGetLevel        : TOnGetLevelEvent;

    IModifyingLevels : Boolean;
    FFrame: TChartHiddenPen;

    procedure ClearAutoLevels;
    function GetNumLevels: Integer;
    function IsLevelsStored: Boolean;
    function LegendLevel(Index:Integer):TContourLevel;
    procedure SetAutomaticLevels(const Value: Boolean);
    procedure SetContourMarks(const Value: TContourMarks);
    procedure SetFrame(const Value: TChartHiddenPen);
    procedure SetLegendLines(const Value: Boolean);
    procedure SetLevels(const Value: TContourLevels);
    procedure SetLinesColor(const Value: TColor);
    Procedure SetNumLevels(Value:Integer);
    Procedure SetPointer(Const Value:TSeriesPointer);
    procedure SetSmoothing(const Value: TSmoothPoints);
    procedure SetTransparency(const Value: TTeeTransparency);
    Procedure SetYPosition(Const Value:TChartValue);
    Procedure SetYPositionLevel(Value:Boolean);
    procedure TryCreateLevels;
  protected
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    Procedure DoBeforeDrawChart; override;
    procedure DrawAllValues; override;
    Procedure DrawLegendShape(ValueIndex:Integer; Const Rect:TRect); override;
    Procedure DrawMark(ValueIndex:Integer; Const St:String;
                       APosition:TSeriesMarkPosition); override;
    procedure DrawMarks; override;
    class Function GetEditorClass:String; override;
    Procedure NotifyValue(ValueEvent:TValueEvent; ValueIndex:Integer); override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    {$IFDEF LEVELSEGMENTS}
    Function Clicked(x,y:Integer):Integer; override;
    {$ENDIF}
    Function CountLegendItems:Integer; override;
    Procedure CreateAutoLevels;
    function GetZAxis:TChartAxis;
    Function LegendItemColor(LegendIndex:Integer):TColor; override;
    Function LegendString( LegendIndex:Integer;
                           LegendTextStyle:TLegendTextStyle ):String; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
  published
    property Active;
    property AutomaticLevels:Boolean read FAutomaticLevels write SetAutomaticLevels default True;
    property ColorEachPoint default True;
    property ColorSource;
    property ContourMarks:TContourMarks read FContourMarks write SetContourMarks;
    property Cursor;
    property Frame:TChartHiddenPen read FFrame write SetFrame;
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

    property EndColor;
    property IrregularGrid;
    property LegendEvery;

    // Draw simple lines at legend when levels aren't filled.
    property LegendLines:Boolean read FLegendLines write SetLegendLines default False;

    property Levels:TContourLevels read FLevels write SetLevels stored IsLevelsStored;

    // Default color to draw level lines when Brush.Style<>bsClear.
    // "clDefault" means color is same as level color. Default is clBlack.
    property LinesColor:TColor read FLinesColor write SetLinesColor default clBlack;

    property MidColor;
    property NumLevels:Integer read GetNumLevels write SetNumLevels default 10;
    property NumXValues;
    property NumZValues;
    property PaletteMin;
    property PaletteStep;
    property PaletteSteps;
    property PaletteStyle;
    property Pen;
    property Pointer:TSeriesPointer read FPointer write SetPointer;
    property Smoothing:TSmoothPoints read FSmoothing write SetSmoothing;
    property StartColor;
    property TimesZOrder;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
    property UseColorRange;
    property UsePalette;
    property UsePaletteMin;
    property XValues;
    property YPosition:TChartValue read FYPosition write SetYPosition;
    property YPositionLevel:Boolean read FYPositionLevel write SetYPositionLevel default False;
    property YValues;
    property ZValues;

    { events }
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

    property OnBeforeDrawLevel:TOnBeforeDrawLevelEvent read FOnBeforeDrawLevel
                                                       write FOnBeforeDrawLevel;
    property OnGetYValue;
    property OnGetLevel:TOnGetLevelEvent read FOnGetLevel write FOnGetLevel;
    property Brush;
  end;

  TWaterFallSeries=class(TSurfaceSeries)
  protected
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Procedure Assign(Source:TPersistent); override;  // 7.01
  published
    property WaterFall default True;
    property WaterLines;
  end;

  TColorGridSeries=class(TCustom3DGridSeries)
  private
    FBitmap       : TBitmap;
    FCentered     : Boolean;
    FPlane3D      : TCanvas3DPlane;
    FFrame        : TChartHiddenPen;
    FPosition     : Integer;
    FSmoothBitmap : Boolean;
    FXGridEvery   : Integer;
    FZGridEvery   : Integer;
    FTransparency : TTeeTransparency;
    FXRegularSteps : Boolean;
    FZRegularSteps : Boolean;
    FXRegularStep : Double;
    FZRegularStep : Double;

    function CalcMaxValue(const Value:Double):Double;
    function CalcMinValue(const Value:Double):Double;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetCentered(const Value: Boolean);
    procedure SetPlane3D(const Value: TCanvas3DPlane);
    procedure SetFrame(const Value: TChartHiddenPen);
    procedure SetPosition(const Value: Integer);
    procedure SetSmoothBitmap(const Value: Boolean);
    procedure SetTransparency(const Value: TTeeTransparency);
    procedure SetXGridEvery(const Value: Integer);
    procedure SetZGridEvery(const Value: Integer);
  protected
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    procedure DrawAllValues; override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    Procedure GalleryChanged3D(Is3D:Boolean); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    function CellBounds(ValueIndex:Integer):TRect; overload;
    function CellBounds(x,z:Integer):TRect; overload;

    Function CalcXPos(ValueIndex:Integer):Integer; override;
    Function CalcYPos(ValueIndex:Integer):Integer; override;

    Function Clicked(X,Y:Integer):Integer; override;
    Function MinXValue:Double; override;
    Function MaxXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
    Function MinZValue:Double; override;
    Function MaxZValue:Double; override;

    property Bitmap:TBitmap read FBitmap write SetBitmap;
  published
    { Published declarations }
    property Active;
    property CenteredPoints:Boolean read FCentered write SetCentered default False;
    property ColorSource;
    property Cursor;
    property DrawPlane3D:TCanvas3DPlane read FPlane3D write SetPlane3D default cpZ;
    property DrawPosition:Integer read FPosition write SetPosition default 0;
    property Frame:TChartHiddenPen read FFrame write SetFrame;
    property HorizAxis;
    property Marks;
    property ParentChart;
    property DataSource;
    property PercentFormat;
    property SeriesColor;
    property ShowInLegend;
    property SmoothBitmap:Boolean read FSmoothBitmap write SetSmoothBitmap default False;  // 7.0
    property Title;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
    property ValueFormat;
    property VertAxis;
    property XGridEvery:Integer read FXGridEvery write SetXGridEvery default 1; // 7.0
    property XLabelsSource;
    property ZGridEvery:Integer read FZGridEvery write SetZGridEvery default 1; // 7.0

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

    property Brush;
    property EndColor;
    property IrregularGrid;
    property MidColor;
    property NumXValues;
    property NumZValues;
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
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;
    { events }
    property OnGetYValue;
    property OnGetColor;
  end;

  TVector3DSeries=class(TCustom3DPaletteSeries)
  private
    FArrowHeight : Integer;
    FArrowWidth  : Integer;
    FStartArrow  : TChartHiddenPen;
    FEndArrow    : TChartPen;
    FEndXValues  : TChartValueList; { <-- Vector end X values }
    FEndYValues  : TChartValueList; { <-- Vector end Y values }
    FEndZValues  : TChartValueList;

    procedure SetArrowHeight(const Value: Integer);
    procedure SetArrowWidth(const Value: Integer);
    Procedure SetEndXValues(Value:TChartValueList);
    Procedure SetEndYValues(Value:TChartValueList);
    Procedure SetEndZValues(Value:TChartValueList);
    procedure SetEndArrow(const Value: TChartPen);
    procedure SetStartArrow(const Value: TChartHiddenPen);
  protected
    Procedure AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False); override;
    procedure DrawValue(ValueIndex:Integer); override; { <-- main draw method }
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;

    Function AddVector(Const X0,Y0,Z0,X1,Y1,Z1:Double; Const ALabel:String='';
                     AColor:TColor=clTeeColor):Integer; overload;
    Function IsValidSourceOf(Value:TChartSeries):Boolean; override;
    Function MaxXValue:Double; override;
    Function MinXValue:Double; override;
    Function MaxYValue:Double; override;
    Function MinYValue:Double; override;
    Function MaxZValue:Double; override;
    Function MinZValue:Double; override;
    Function NumSampleValues:Integer; override;
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
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;
    { events }
    property OnGetColor;

    property ArrowHeight:Integer read FArrowHeight write SetArrowHeight default 4;
    property ArrowWidth:Integer read FArrowWidth write SetArrowWidth default 4;
    property EndArrow:TChartPen read FEndArrow write SetEndArrow;
    property EndXValues:TChartValueList read FEndXValues write SetEndXValues;
    property EndYValues:TChartValueList read FEndYValues write SetEndYValues;
    property EndZValues:TChartValueList read FEndZValues write SetEndZValues;
    property StartArrow:TChartHiddenPen read FStartArrow write SetStartArrow;
  end;

  TTowerStyle=(tsCube,tsRectangle,tsCover,tsCylinder,tsArrow,tsCone,tsPyramid,
               tsSlantCube);

  TTowerSeries=class(TCustom3DGridSeries)
  private
    FDark3D       : Boolean;
    FOrigin       : Double;
    FPercDepth    : Integer;
    FPercWidth    : Integer;
    FTowerStyle   : TTowerStyle;
    FTransparency : TTeeTransparency;
    FUseOrigin    : Boolean;

    IOffW  : Double;
    IOffD  : Double;
    Function CalcCell(var AIndex,ATop,ABottom,Z0,Z1:Integer):TRect;
    procedure SetDark3D(const Value: Boolean);
    Procedure SetOrigin(Const Value:Double);
    procedure SetPercDepth(const Value: Integer);
    procedure SetPercWidth(const Value: Integer);
    procedure SetTransparency(const Value: TTeeTransparency);
    Procedure SetUseOrigin(Value:Boolean);
    procedure SetTowerStyle(const Value: TTowerStyle);
  protected
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    Procedure DrawMark( ValueIndex:Integer; Const St:String;
                        APosition:TSeriesMarkPosition); override;
    procedure DrawAllValues; override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;

    Procedure Assign(Source:TPersistent); override;

    Function Clicked(X,Y:Integer):Integer; override; { 5.01 }
    Function MinXValue:Double; override;
    Function MaxXValue:Double; override;
    Function MinZValue:Double; override;
    Function MaxZValue:Double; override;
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
    property ShowInLegend;
    property Title;
    property ValueFormat;
    property VertAxis;
    property XLabelsSource;

    property Dark3D:Boolean read FDark3D write SetDark3D default True;
    property PercentDepth:Integer read FPercDepth write SetPercDepth default 100;
    property Origin:Double read FOrigin write SetOrigin;
    property TowerStyle:TTowerStyle read FTowerStyle write SetTowerStyle default tsCube;
    property Transparency:TTeeTransparency read FTransparency write SetTransparency default 0;
    property PercentWidth:Integer read FPercWidth write SetPercWidth default 100;
    property UseOrigin:Boolean read FUseOrigin write SetUseOrigin default False;

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

    property Brush;
    property EndColor;
    property IrregularGrid;
    property MidColor;
    property NumXValues;
    property NumZValues;
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
    property TimesZOrder;
    property XValues;
    property YValues;
    property ZValues;

    { events }
    property OnGetYValue;
    property OnGetColor;
  end;

  TSurfaceSides=class(TPersistent)
  private
    FLevels : Boolean;
    FPen    : TChartHiddenPen;

    ISeries : TSurfaceSeries;
    Procedure CanvasChanged(Sender:TObject);
    function GetBrush:TChartBrush;
    Procedure SetBrush(const Value:TChartBrush);
    Procedure SetLevels(const Value:Boolean);
    Procedure SetPen(const Value:TChartHiddenPen);
  public
    Constructor Create(Series:TSurfaceSeries);
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
  published
    property Brush:TChartBrush read GetBrush write SetBrush;
    property Levels:Boolean read FLevels write SetLevels default True;
    property Pen:TChartHiddenPen read FPen write SetPen;
  end;

  TIsoSurfaceSeries=class(TSurfaceSeries)
  private
    FBandPen : TChartPen;
    FSides   : TSurfaceSides;
    FUseY    : Boolean;
    FYPosition : TChartValue;

    xv : TChartValues;
    zv : TChartValues;
    v  : TChartValues;
    HasImage : Boolean;
    ITransp  : Boolean;
    PaletteLength : Integer;
    IPoints2D     : TPointArray;
    ICalcYPos     : Integer;

    procedure SetBandPen(const Value: TChartPen);
    procedure SetSides(const Value: TSurfaceSides);
    procedure SetUseY(const Value: Boolean);
    procedure SetYPosition(const Value: TChartValue);
  protected
    Procedure DrawAllValues; override;
    Procedure DrawCell(x,z:Integer); override;
    Procedure DrawSidePortion(var P:TFourPoints; Z0,Z1:Integer); override;
    class function GetEditorClass: String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    function ShouldDrawFast:Boolean; override;
    function ShouldDrawSides:Boolean; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
  published
    property BandPen:TChartPen read FBandPen write SetBandPen;
    property Sides:TSurfaceSides read FSides write SetSides;
    property UseColorRange default False;
    property UsePalette default True;
    property UseYPosition:Boolean read FUseY write SetUseY default False;
    property YPosition:TChartValue read FYPosition write SetYPosition;
  end;

implementation

uses
  Math, Chart, TeeSpline, TeeProCo, TeeConst;

{$IFNDEF D6}
// From Math.pas
const
  FuzzFactor = 1000;
  DoubleResolution   = 1E-15 * FuzzFactor;

function SameValue(const A, B: Double; Epsilon: Double=0): Boolean;
begin
  if Epsilon = 0 then
    Epsilon := Max(Min(Abs(A), Abs(B)) * DoubleResolution, DoubleResolution);
  if A > B then
    Result := (A - B) <= Epsilon
  else
    Result := (B - A) <= Epsilon;
end;
{$ENDIF}

{ TCustom3DSeries }
Constructor TCustom3DSeries.Create(AOwner: TComponent);
Begin
  inherited;
  HasZValues:=True;
  CalcVisiblePoints:=False;
  FZValues:=TChartValueList.Create(Self,'Z'); { <-- dont translate ! }
  XValues.Order:=loNone;
  FTimesZOrder:=3;
end;

Procedure TCustom3DSeries.SetZValues(Const Value:TChartValueList);
Begin
  SetChartValueList(FZValues,Value); { standard method }
End;

Procedure TCustom3DSeries.CalcZOrder;
Begin
  inherited;
  ParentChart.MaxZOrder:=FTimesZOrder;
end;

Procedure TCustom3DSeries.DrawMark( ValueIndex:Integer; Const St:String;
                                    APosition:TSeriesMarkPosition);
begin
  if ValueIndex<>-1 then
     Marks.ZPosition:=CalcZPos(ValueIndex);
     
  inherited;
end;

Procedure TCustom3DSeries.AddArray(Const Values:TArrayGrid);
var x : Integer;
    z : Integer;
begin
  BeginUpdate;
  try
    for x:=Low(Values) to High(Values) do
        for z:=Low(Values[x]) to High(Values[x]) do
            AddXYZ(x,Values[x,z],z);
  finally
    EndUpdate;
  end;
end;

Function TCustom3DSeries.AddXYZ(Const AX,AY,AZ:TChartValue):Integer;
begin
  ZValues.TempValue:=AZ;
  result:=AddXY(AX,AY);
end;

Function TCustom3DSeries.AddXYZ(Const AX,AY,AZ:TChartValue;
                                Const AXLabel:String; AColor:TColor):Integer;
Begin
  ZValues.TempValue:=AZ;
  result:=AddXY(AX,AY,AXLabel,AColor);
end;

Function TCustom3DSeries.IsValidSourceOf(Value:TChartSeries):Boolean;
begin
  result:=Value is TCustom3DSeries;
end;

Procedure TCustom3DSeries.SetTimesZOrder(Const Value:Integer);
Begin
  SetIntegerProperty(FTimesZOrder,Value);
End;

Function TCustom3DSeries.MaxZValue:Double;
begin
  result:=FZValues.MaxValue;
end;

Function TCustom3DSeries.MinZValue:Double;
begin
  result:=FZValues.MinValue;
end;

Procedure TCustom3DSeries.Assign(Source:TPersistent);
begin
  if Source is TCustom3DSeries then
  With TCustom3DSeries(Source) do
  begin
    Self.FZValues.Assign(FZValues);
    Self.FTimesZOrder  :=FTimesZOrder;
  end;

  inherited;
end;

Procedure TCustom3DSeries.SetZValue(Index:Integer; Const Value:TChartValue);
Begin
  ZValues.Value[Index]:=Value;
End;

Function TCustom3DSeries.GetZValue(Index:Integer):TChartValue;
Begin
  result:=ZValues.Value[Index];
End;

function TCustom3DSeries.CalcZPos(ValueIndex: Integer): Integer;
begin
  result:=ParentChart.DepthAxis.CalcYPosValue(ZValues.Value[ValueIndex]);
end;

procedure TCustom3DSeries.PrepareLegendCanvas(ValueIndex: Integer;
  var BackColor: TColor; var BrushStyle: TBrushStyle);
begin
  inherited;
  
  if TCustomChart(ParentChart).Legend.Symbol.Continuous then
     ParentChart.Canvas.Pen.Style:=psClear;
end;

function TCustom3DSeries.BackFaced: Boolean;
begin
  result:=ParentChart.DepthAxis.Inverted;

  with ParentChart.View3DOptions do
    if (Rotation>90) and (Rotation<270) then
       result:=not result;
end;

function TCustom3DSeries.AssociatedToAxis(Axis: TChartAxis): Boolean;
begin
  result:=Axis.IsDepthAxis or inherited AssociatedToAxis(Axis);
end;

Function TCustom3DSeries.ValueListOfAxis(Axis:TChartAxis):TChartValueList;
begin
  if Axis.IsDepthAxis then result:=ZValues
                      else result:=inherited ValueListOfAxis(Axis);
end;

{ TCustom3DPaletteSeries }
Constructor TCustom3DPaletteSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FUseColorRange:=True;
  FPaletteSteps:=32;
  FLegendEvery:=1;
  FStartColor:=clNavy;
  FEndColor:=clWhite;
  FMidColor:=clNone;

  { Palette Modifiers }
  RedFactor:=2.0;
  GreenFactor:=1;
  BlueFactor:=1;
  CalcColorRange;
End;

Destructor TCustom3DPaletteSeries.Destroy;
begin
  ClearPalette;
  inherited;
end;

Procedure TCustom3DPaletteSeries.CalcColorRange;
Begin
  IEndRed    :=GetRValue(EndColor);
  IEndGreen  :=GetGValue(EndColor);
  IEndBlue   :=GetBValue(EndColor);

  if MidColor<>clNone then
  begin
    IMidRed    :=GetRValue(MidColor);
    IMidGreen  :=GetGValue(MidColor);
    IMidBlue   :=GetBValue(MidColor);
    IRangeMidRed  :=Integer(GetRValue(StartColor))-IMidRed;
    IRangeMidGreen:=Integer(GetGValue(StartColor))-IMidGreen;
    IRangeMidBlue :=Integer(GetBValue(StartColor))-IMidBlue;
    IRangeRed  :=IMidRed-IEndRed;
    IRangeGreen:=IMidGreen-IEndGreen;
    IRangeBlue :=IMidBlue-IEndBlue;
  end
  else
  begin
    IRangeRed  :=Integer(GetRValue(StartColor))-IEndRed;
    IRangeGreen:=Integer(GetGValue(StartColor))-IEndGreen;
    IRangeBlue :=Integer(GetBValue(StartColor))-IEndBlue;
  end;

  CalcValueRange;
end;

Procedure TCustom3DPaletteSeries.SetStartColor(Const Value:TColor);
Begin
  SetColorProperty(FStartColor,Value);
  CalcColorRange;
End;

Procedure TCustom3DPaletteSeries.SetMidColor(Const Value:TColor);
Begin
  SetColorProperty(FMidColor,Value);
  CalcColorRange;
End;

Procedure TCustom3DPaletteSeries.SetEndColor(Const Value:TColor);
Begin
  SetColorProperty(FEndColor,Value);
  CalcColorRange;
End;

// Duplicate AddPalette methods to skip "TColorArray <> Array of TColor"
// compiler limitation.
{$IFNDEF CLR}
procedure TCustom3DPaletteSeries.AddPalette(Const APalette:Array of TColor);
var t : Integer;
    l : Integer;
begin
  CreateDefaultPalette;

  l:=Length(APalette);
  for t:=0 to PaletteSteps-1 do
      Palette[t].Color:=APalette[t mod l];

  Repaint;
end;
{$ENDIF}

procedure TCustom3DPaletteSeries.AddPalette(Const APalette:TColorArray);
var t : Integer;
    l : Integer;
begin
  l:=Length(APalette);

  if l>0 then
  begin
    CreateDefaultPalette;

    for t:=0 to PaletteSteps-1 do
        Palette[t].Color:=APalette[t mod l];

    Repaint;
  end;
end;

Function TCustom3DPaletteSeries.AddPalette(Const AValue:TChartValue; AColor:TColor):Integer;
var t   : Integer;
    tt  : Integer;
Begin
  // Try to search place to fit
  for t:=0 to Length(FPalette)-1 do
  begin
    if AValue<FPalette[t].UpToValue then
    begin
      // Insert
      SetLength(FPalette,Length(FPalette)+1);

      for tt:=Length(FPalette)-1 downto t+1 do
          FPalette[tt]:=FPalette[tt-1];

      With FPalette[t] do
      begin
        UpToValue:=AValue;
        Color:=AColor;
      end;

      result:=t;
      exit;
    end;
  end;

  // Append
  result:=Length(FPalette);
  SetLength(FPalette,result+1);
  With FPalette[result] do
  begin
    UpToValue:=AValue;
    Color:=AColor;
  end;
End;

Procedure TCustom3DPaletteSeries.ClearPalette;
Begin
  FPalette:=nil;
end;

Procedure TCustom3DPaletteSeries.CreateDefaultPalette(NumSteps:Integer=0);
var tmpMin     : Double;
    ScaleValue : Double;

  procedure SetRainbowPalette;
  var t : Integer;
      {$IFDEF CLR}
      tmp : Array of TColor;
      tmpParent : TCustomAxisPanel;
      {$ENDIF}
  begin
    if Assigned(ParentChart) then
    begin

      // Wish: Instead of using "Length(RainbowPalette)" here use: NumSteps.
      //
      // ie: Needs to calculate "middle" colors in between
      // if the NumSteps is bigger than 25.
      {$IFDEF CLR}

      SetLength(tmp,Length(RainbowPalette));
      System.Array.Copy(RainbowPalette,tmp,Length(RainbowPalette));

      tmpParent:=ParentChart;  // ugly CLR trick
      tmpParent.ColorPalette:=tmp;
      tmp:=nil;

      {$ELSE}

      SetLength(ParentChart.ColorPalette,Length(RainbowPalette));
      for t:=0 to Length(RainbowPalette)-1 do
          ParentChart.ColorPalette[t]:=RainbowPalette[t];

      {$ENDIF}

      // Default:
      for t:=0 to NumSteps-1 do
          AddPalette(tmpMin+ScaleValue*t,ParentChart.GetDefaultColor(t));

      {$IFNDEF CLR}
      ParentChart.ColorPalette:=nil; // should be OLD palette !!
      {$ENDIF}
    end;
  end;

Const Delta=127.0;
var t          : Integer;
    tmp        : Double;
    tmpColor   : TColor;
    Scale      : Double;
    tmpL       : Integer;
Begin
  if NumSteps=0 then
     NumSteps:=PaletteSteps;

  if PaletteStep=0 then // 5.03
  begin
    if PaletteRange=0 then
       ScaleValue:=MandatoryValueList.Range/Math.Max(1,NumSteps-1)
    else
       ScaleValue:=PaletteRange/NumSteps;
  end
  else ScaleValue:=PaletteStep;

  // 5.03
  if UsePaletteMin then tmpMin:=PaletteMin
                   else tmpMin:=MandatoryValueList.MinValue;

  if PaletteStyle=psCustom then
  begin
    // Expand or contract current custom palette with new UpToValues
    tmpL:=Length(FPalette);
    SetLength(FPalette,NumSteps);

    for t:=0 to NumSteps-1 do
    with Palette[t] do
    begin
      UpToValue:=tmpMin+ScaleValue*t;

      if (t>=tmpL) and (tmpL>0) then
         Color:=Palette[t mod tmpL].Color;
    end;
  end
  else
  begin
    ClearPalette;

    if PaletteStyle=psRainbow then   // 7.0
       SetRainbowPalette
    else
    begin
      case PaletteStyle of
          psPale: Scale:=Pi/NumSteps;
        psStrong: Scale:=2.0*Pi/NumSteps;
      else
        Scale:=255.0/NumSteps;
      end;

      for t:=0 to NumSteps-1 do
      begin
        tmp:=Scale*t;

        case PaletteStyle of
          psGrayScale: begin
                         tmpColor:=Round(tmp);
                         tmpColor:=RGB(tmpColor,tmpColor,tmpColor);
                       end;
          psInvGray:   begin
                         tmpColor:=255-Round(tmp);
                         tmpColor:=RGB(tmpColor,tmpColor,tmpColor);
                       end;

        else
          tmpColor:=RGB( Trunc(Delta * (Sin(tmp/RedFactor)+1)) ,
                         Trunc(Delta * (Sin(tmp/GreenFactor)+1)),
                         Trunc(Delta * (Cos(tmp/BlueFactor)+1)));
        end;

        AddPalette(tmpMin+ScaleValue*t,tmpColor);
      end;
    end;
  end;

  Repaint;
end;

Procedure TCustom3DPaletteSeries.SetUseColorRange(Const Value:Boolean);
Begin
  SetBooleanProperty(FUseColorRange,Value);
  if Value then ColorEachPoint:=False;
End;

Procedure TCustom3DPaletteSeries.SetUsePalette(Const Value:Boolean);
Begin
  SetBooleanProperty(FUsePalette,Value);

  if Value then
  begin
    ColorEachPoint:=False;
    CheckPaletteEmpty;
  end;
end;

Function TCustom3DPaletteSeries.GetSurfacePaletteColor(Const Y:TChartValue):TColor;
Var t        : Integer;
    tmpCount : Integer;
Begin
  tmpCount:=Length(FPalette)-1;

  for t:=0 to tmpCount do
  With FPalette[t] do
  if UpToValue>Y then
  begin
    result:=Color;
    exit;
  end;

  result:=FPalette[tmpCount].Color; { return max }
end;

// Note: The Round function is very slow.
Function TCustom3DPaletteSeries.RangePercent(const Percent:Double):TColor;
begin
  if MidColor=clNone then
     result:=RGB( IEndRed  +Round(Percent*IRangeRed),
                  IEndGreen+Round(Percent*IRangeGreen),
                  IEndBlue +Round(Percent*IRangeBlue))
  else
  if Percent<0.5 then
     result:=RGB( IEndRed  +Round((2.0*Percent)*IRangeRed),
                  IEndGreen+Round((2.0*Percent)*IRangeGreen),
                  IEndBlue +Round((2.0*Percent)*IRangeBlue))
  else
     result:=RGB( IMidRed  +Round(2.0*(Percent-0.5)*IRangeMidRed),
                  IMidGreen+Round(2.0*(Percent-0.5)*IRangeMidGreen),
                  IMidBlue +Round(2.0*(Percent-0.5)*IRangeMidBlue))
end;

Function TCustom3DPaletteSeries.GetValueColorValue(Const AValue:TChartValue):TColor;
var tmp : Double;
begin
  if UseColorRange then
  begin
    if IValueRangeInv=0 then
       result:=EndColor
    else
    begin
      tmp:=AValue-MandatoryValueList.MinValue;

      if tmp<0 then result:=EndColor
      else
      if AValue>MandatoryValueList.MaxValue then
         result:=StartColor
      else
         result:=RangePercent(Min(1.0,tmp*IValueRangeInv));
    end;
  end
  else
  if UsePalette and (Length(FPalette)>0) then
     result:=GetSurfacePaletteColor(AValue)
  else
     result:=SeriesColor;
end;

Function TCustom3DPaletteSeries.GetValueColor(ValueIndex:Integer):TColor;
Begin
  result:=InternalColor(ValueIndex);

  if result=clTeeColor then
  begin
    if (not ColorEachPoint) and (FUseColorRange or FUsePalette) then
       result:=GetValueColorValue(MandatoryValueList.Value[ValueIndex])
    else
       result:=inherited GetValueColor(ValueIndex);
  end;

  if Assigned(FOnGetColor) then
     FOnGetColor(Self,ValueIndex,result);
End;

Function TCustom3DPaletteSeries.CountLegendItems:Integer;
begin
  if (Count>0) and (UseColorRange or UsePalette) then
  begin
    result:=Length(FPalette);
    if FLegendEvery>1 then result:=(result div FLegendEvery)+1;
  end
  else
     result:=inherited CountLegendItems;
end;

Function TCustom3DPaletteSeries.LegendString( LegendIndex:Integer;
                                              LegendTextStyle:TLegendTextStyle
                                              ):String;
var tmp : TChartValue;
begin
  if UseColorRange or UsePalette then
  begin
    if CountLegendItems>LegendIndex then
    begin
      tmp:=FPalette[LegendPaletteIndex(LegendIndex)].UpToValue;
      result:=FormatFloat(ValueFormat,tmp);
    end
    else
       result:='';
  end
  else
    result:=inherited LegendString(LegendIndex,LegendTextStyle);
end;

Function TCustom3DPaletteSeries.LegendPaletteIndex(LegendIndex:Integer):Integer;
begin
  result:=Length(FPalette)-(FLegendEvery*LegendIndex)-1;
end;

Function TCustom3DPaletteSeries.LegendItemColor(LegendIndex:Integer):TColor;
var tmp : Integer;
begin
  tmp:=LegendPaletteIndex(LegendIndex);  // 7.0

  if UseColorRange then
     result:=GetValueColorValue(FPalette[tmp].UpToValue)
  else
  if UsePalette and (Length(FPalette)>tmp) then
     result:=FPalette[tmp].Color
  else
     result:=inherited LegendItemColor(LegendIndex);
end;

Procedure TCustom3DPaletteSeries.SetPaletteSteps(Const Value:Integer);
Begin
  FPaletteSteps:=Value;
  CreateDefaultPalette;
End;

Procedure TCustom3DPaletteSeries.SetGalleryPalette;
begin
  if Assigned(ParentChart) and
     ((ParentChart as TCustomChart).ColorPaletteIndex<>0) then
  begin
    PaletteStyle:=psCustom;
    AddPalette(ParentChart.ColorPalette);
  end
  else
     PaletteStyle:=psRainbow;
end;

Procedure TCustom3DPaletteSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;

  UseColorRange:=False;

  if IsEnabled then Pen.Color:=clBlack
               else Pen.Color:=clGray;

  UsePalette:=IsEnabled;

  SetGalleryPalette;
end;

Procedure TCustom3DPaletteSeries.Assign(Source:TPersistent);
begin
  if Source is TCustom3DPaletteSeries then
  With TCustom3DPaletteSeries(Source) do
  begin
    Self.FUsePalette   :=FUsePalette;
    Self.FUseColorRange:=FUseColorRange;
    Self.FStartColor   :=FStartColor;
    Self.FEndColor     :=FEndColor;
    Self.FMidColor     :=FMidColor;
    Self.FLegendEvery  :=FLegendEvery;
    Self.FPaletteSteps :=FPaletteSteps;
    Self.FPalette      :=FPalette;
    Self.FUsePaletteMin:=FUsePaletteMin;
    Self.FPaletteStep  :=FPaletteStep;
    Self.FPaletteMin   :=FPaletteMin;
    Self.FPaletteStyle :=FPaletteStyle;  // 6.02
  end;
  inherited;
end;

Procedure TCustom3DPaletteSeries.CheckPaletteEmpty;
begin
  if (Count>0) and (Length(FPalette)=0) then
     CreateDefaultPalette;
end;

{ internal }
procedure TCustom3DPaletteSeries.CalcValueRange;
begin
  IValueRangeInv:=MandatoryValueList.Range;
  if IValueRangeInv<>0 then IValueRangeInv:=1/IValueRangeInv;
end;

procedure TCustom3DPaletteSeries.ReadPalette(Stream: TStream);
var t    : Integer;
    tmpL : Integer;

    {$IFDEF CLR}
    tmp  : Integer;
    {$ENDIF}
begin
  Stream.Read(tmpL,SizeOf(tmpL));
  SetLength(FPalette,tmpL);

  for t:=0 to Length(FPalette)-1 do
  with FPalette[t] do
  begin
    Stream.Read(UpToValue,SizeOf(UpToValue));

    {$IFDEF CLR}
    Stream.Read(tmp,Sizeof(tmp));
    Color:=TColor(tmp);
    {$ELSE}
    Stream.Read(Color,SizeOf(Color));
    {$ENDIF}
  end;
end;

procedure TCustom3DPaletteSeries.WritePalette(Stream: TStream);
var t    : Integer;
    tmpL : Integer;
begin
  tmpL:=Length(FPalette);
  Stream.Write(tmpL,SizeOf(tmpL));

  for t:=0 to tmpL-1 do
  with FPalette[t] do
  begin
    Stream.Write(UpToValue,SizeOf(UpToValue));
    Stream.Write(Color,SizeOf(Color));
  end;
end;

Procedure TCustom3DPaletteSeries.DefineProperties(Filer:TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('CustomPalette',ReadPalette,WritePalette,PaletteStyle=psCustom);
end;

Procedure TCustom3DPaletteSeries.DoBeforeDrawChart;
begin
  inherited;
  CheckPaletteEmpty;
  CalcValueRange;
end;

Procedure TCustom3DPaletteSeries.DrawLegendShape(ValueIndex:Integer;
                                                 Const Rect:TRect);
var R : TRect;
begin
  if (ValueIndex=-1) and UseColorRange then
  begin
    ParentChart.Canvas.Brush.Style:=bsClear;
    ParentChart.Canvas.Rectangle(Rect);  { <-- rectangle }

    with TTeeGradient.Create(nil) do
    try
      // set inverted colors
      StartColor:=Self.EndColor;
      MidColor:=Self.MidColor;
      EndColor:=Self.StartColor;

      // draw
      R:=Rect;
      InflateRect(R,-1,-1);
      Draw(ParentChart.Canvas,R);
    finally
      Free;
    end;
  end
  else inherited;
end;

class Function TCustom3DPaletteSeries.GetEditorClass:String;
Begin
  result:='TGrid3DSeriesEditor'; { <-- dont translate ! }
end;

Procedure TCustom3DPaletteSeries.Clear;
begin
  inherited;

  if FUsePalette then
     if PaletteStyle<>psCustom then
        ClearPalette;
end;

Procedure TCustom3DPaletteSeries.AddValues(Source:TChartSeries);
Begin
  inherited;
  CreateDefaultPalette;
end;

class procedure TCustom3DPaletteSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_ColorRange);
end;

class procedure TCustom3DPaletteSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TCustom3DPaletteSeries(ASeries) do
  Case Index of
    1: begin
         UseColorRange:=True;
         UsePalette:=False;
       end;
  else
    inherited;
  end;
end;

procedure TCustom3DPaletteSeries.CreateRangePalette;
var tmp     : Double;
    Delta   : Double;
    t       : Integer;
begin
  Delta:=MandatoryValueList.Range;

  ClearPalette;

  tmp:=Delta/PaletteSteps;

  for t:=1 to PaletteSteps do
      if Delta>0 then
         AddPalette(MandatoryValueList.MinValue+tmp*t,RangePercent(tmp*t/Delta))
      else
         AddPalette(MandatoryValueList.MinValue,RGB(IEndRed,IEndGreen,IEndBlue));
end;

Procedure TCustom3DPaletteSeries.GalleryChanged3D(Is3D:Boolean);
Const Rots:Array[Boolean] of Integer=(0,335);
      Elev:Array[Boolean] of Integer=(270,340);
      Pers:Array[Boolean] of Integer=(0,160);
begin
  ParentChart.View3D:=True;

  With ParentChart.View3DOptions do
  begin
    Zoom:=60;
    VertOffset:=-2;
    Rotation:=Rots[Is3D];
    Elevation:=Elev[Is3D];
    Perspective:=Pers[Is3D];
  end;

  SetGalleryPalette;
end;

procedure TCustom3DPaletteSeries.SetPaletteStyle(
  const Value: TTeePaletteStyle);
begin
  if FPaletteStyle<>Value then
  begin
    FPaletteStyle:=Value;

    if PaletteStyle<>psCustom then
       ClearPalette;

    Repaint;
  end;
end;

procedure TCustom3DPaletteSeries.SetPaletteMin(const Value: Double);
begin
  FPaletteMin:=Value;
  CreateDefaultPalette;
end;

procedure TCustom3DPaletteSeries.SetPaletteStep(const Value: Double);
begin
  FPaletteStep:=Value;
  CreateDefaultPalette;
end;

procedure TCustom3DPaletteSeries.SetUsePaletteMin(const Value: Boolean);
begin
  FUsePaletteMin:=Value;
  CreateDefaultPalette;
end;

procedure TCustom3DPaletteSeries.SetLegendEvery(const Value: Integer);
begin
  SetIntegerProperty(FLegendEvery,Max(1,Value));
end;

procedure TCustom3DPaletteSeries.GeneratePalette;
var t : Integer;
begin
  for t:=0 to Length(Palette)-1 do
      Palette[t].Color:=GetValueColorValue(Palette[t].UpToValue);
end;

procedure TCustom3DPaletteSeries.InvertPalette;
var t   : Integer;
    tmp : TColor;
begin
  // Invert palette
  for t:=0 to (Length(Palette) div 2)-1 do
  begin
    tmp:=Palette[t].Color;
    Palette[t].Color:=Palette[Length(Palette)-t-1].Color;
    Palette[Length(Palette)-t-1].Color:=tmp;
  end;

  Repaint;
end;

procedure TCustom3DPaletteSeries.SetPalette(const Value: TCustom3DPalette);
var tmp : Integer;
    t   : Integer;
begin
  tmp:=Length(Value);
  SetLength(FPalette,tmp);
  for t:=0 to tmp-1 do
      FPalette[t]:=Value[t];
end;

{ TCustom3DGridSeries }
Constructor TCustom3DGridSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FNumXValues:=10;
  FNumZValues:=10;
  Clear;
End;

Procedure TCustom3DGridSeries.Clear;
begin
  inherited;
  XValues.Order:=loNone;
  InitGridIndex(NumXValues,NumZValues);
end;

Procedure TCustom3DGridSeries.InitGridIndex(XCount,ZCount:Integer);
var x : Integer;
    z : Integer;
begin
  {$IFDEF CLR}  // CLR NET RTL bug
  GridIndex:=nil;
  {$ENDIF}

  SetLength(GridIndex,XCount+1,ZCount+1);

  if not ReuseGridIndex then  // 7.0 speed optimization
     for x:=0 to XCount do
         for z:=0 to ZCount do GridIndex[x,z]:=-1;
end;

Procedure TCustom3DGridSeries.FillGridIndex;
begin
  FillGridIndex(0);
end;

// StartIndex means the first point to start
Procedure TCustom3DGridSeries.FillGridIndex(StartIndex:Integer);
Var XCount : Integer;
    ZCount : Integer;

  Procedure FillIrregularGrid;
  type
    TIrregValues=packed Array of TChartValue;

      // Adds unique values of "AValue" to "Values" array.
      // Repeated values aren't allowed.
      Procedure SearchValue(Var ACount:Integer; Var Values:TIrregValues; Const AValue:TChartValue);
      var t    : Integer;
      begin
        t:=0;

        while t<ACount do

          if Values[t]=AValue then Break
          else
        begin
            Inc(t);

            if t=ACount then
              begin
              Values[t]:=AValue;
              Inc(ACount);
              Break;
              end;
        end;
      end;

      Procedure SortValues(ACount:Integer; Var Values:TIrregValues);
      var t        : Integer;
          tt       : Integer;
          tmpMin   : TChartValue;
          tmpIndex : Integer;
      begin
        for t:=1 to ACount-2 do {min already at 0}
      begin
        tmpMin:=Values[t];
        tmpIndex:=t;

        for tt:=t+1 to ACount-1 do  {get minimum }
        begin
          if Values[tt]<tmpMin then
      begin
            tmpMin:=Values[tt];
            tmpIndex:=tt;

          end;
        end; // 7.0

        if tmpIndex<>t then
        begin
          Values[tmpIndex]:=Values[t];
          Values[t]:=tmpMin;
        end;
      end;
    end;

    function SearchSorted(const Value:TChartValue; const ACount:Integer; Var Values:TIrregValues): Integer;
    var L : Integer;
        H : Integer;
    begin
      L:=0;
      H:=Pred(ACount);

      while L <= H do
      begin
        result:=(L + H) shr 1;

        if Values[result]<Value then
           L:=Succ(result)
        else
        begin
          if Values[result]=Value then
             Exit;

          H:=Pred(result);
        end;
      end;

      result:=-1;
    end;

    var
    XVals : TIrregValues;
    ZVals : TIrregValues;

    // Adds unique values of "AValue" to "Values" array.
    // Repeated values aren't allowed.
    Procedure SearchXValue(const Value:TChartValue);
    begin
      if SearchSorted(Value,XCount,XVals)=-1 then
      begin
        XVals[XCount]:=Value;
        Inc(XCount);
      end;
    end;

    // Adds unique values of "AValue" to "Values" array.
    // Repeated values aren't allowed.
    Procedure SearchZValue(const Value:TChartValue);
    begin
      if SearchSorted(Value,ZCount,ZVals)=-1 then
      begin
        ZVals[ZCount]:=Value;
        Inc(ZCount);
      end;
    end;

    procedure SetGridIndex(const Index:Integer);
    var tmpX : Integer;
        tmpZ : Integer;
    begin
      tmpX:=SearchSorted(XValues.Value[Index],XCount,XVals);

      if tmpX<>-1 then
      begin
        tmpZ:=SearchSorted(ZValues.Value[Index],ZCount,ZVals);

        if tmpZ<>-1 then
           GridIndex[Succ(tmpX),Succ(tmpZ)]:=Index;
      end;
    end;

  const
    MaxAllowedCells = 20000;

  var t : Integer;
  begin
    SetLength(XVals,MaxAllowedCells);
    SetLength(ZVals,MaxAllowedCells);

    try
      XCount:=1;
      XVals[0]:=XValues.MinValue;

      ZCount:=1;
      ZVals[0]:=ZValues.MinValue;

      // Adds all unique X and Z values to XVals and ZVals arrays
      // XCount and ZCount are updated to maximum number of non-repeated values
      for t:=StartIndex to Count-1 do
      begin
      SearchValue(XCount,XVals,XValues.Value[t]);
      SearchValue(ZCount,ZVals,ZValues.Value[t]);
      end;

      // Sort X and Z array values in ascending order
      SortValues(XCount,XVals);
      SortValues(ZCount,ZVals);

      InitGridIndex(XCount,ZCount);

      // Use sorted XVals and ZVals to index Mandatory ValueList in grid
      for t:=StartIndex to Count-1 do
          SetGridIndex(t);

    finally
      XVals:=nil;
      ZVals:=nil;
    end;
  end;

  Procedure FillRegularGrid;
  var t : Integer;
      tmpMinX,
      tmpMinZ : Integer;
  begin

    if XValues.MinValue <> 0 Then
      FXStartIndex:=1
    else
      FXStartIndex:=0;
    if ZValues.MinValue <> 0 Then
      FZStartIndex:=1
    else
      FZStartIndex:=0;  

    tmpMinX:=Round(XValues.MinValue)-1;
    tmpMinZ:=Round(ZValues.MinValue)-1;

    XCount:=Round(XValues.MaxValue)-tmpMinX;
    ZCount:=Round(ZValues.MaxValue)-tmpMinZ;

    InitGridIndex(XCount,ZCount);

    for t:=StartIndex to Count-1 do
        GridIndex[ Round(XValues.Value[t])-tmpMinX,
                   Round(ZValues.Value[t])-tmpMinZ]:=t;
  end;

begin
  if FIrregularGrid then FillIrregularGrid
                    else FillRegularGrid;

  if XCount<>NumXValues then FNumXValues:=XCount;
  if ZCount<>NumZValues then FNumZValues:=ZCount;
end;

Function TCustom3DGridSeries.GetXZValue(X,Z:Integer):TChartValue;
{$IFDEF TEEOCX}
var tmpResult : Double;
{$ENDIF}
Begin
  {$IFNDEF TEEOCX}  //ocx event always assigned
  if Assigned(FOnGetYValue) then
     result:=FOnGetYValue(Self,X,Z)
  else
  {$ENDIF}
  // Default sample random surface value formula
  if (csDesigning in ComponentState) or
     (IInGallery) then
     result:=0.5*Sqr(Cos(x/(NumXValues*0.2)))+
                 Sqr(Cos(z/(NumZValues*0.2)))-
                 Cos(z/(NumZValues*0.5))
  else
     result:=0;

  {$IFDEF TEEOCX}  //ocx event always assigned return NaN when not in use
  if Assigned(FOnGetYValue) then
  Begin
    tmpResult:=FOnGetYValue(Self,X,Z);

    if not IsNan(tmpResult) then
       result := tmpResult;
end;
  {$ENDIF}
end;

Function TCustom3DGridSeries.NumSampleValues:Integer;
begin
  result:=NumXValues;
end;

Procedure TCustom3DGridSeries.ReCreateValues;
Begin
  CreateValues(NumXValues,NumZValues);
end;

Procedure TCustom3DGridSeries.SetNumXValues(Value:Integer);
Begin
  if Value<>NumXValues then
  begin
    FNumXValues:=Value;
    Clear;
    ReCreateValues;
  end;
End;

Procedure TCustom3DGridSeries.SetNumZValues(Value:Integer);
Begin
  if Value<>NumZValues then
  begin
    FNumZValues:=Value;
    Clear;
    ReCreateValues;
  end;
End;

Procedure TCustom3DGridSeries.AddValues(Source:TChartSeries);
Begin
  if Source is TCustom3DGridSeries then
  With TCustom3DGridSeries(Source) do
  begin
    Self.FNumXValues:=NumXValues;
    Self.FNumZValues:=NumZValues;
  end;

  inherited;

  FillGridIndex;
  Repaint;
end;

Procedure TCustom3DGridSeries.Assign(Source:TPersistent);
begin
  if Source is TCustom3DGridSeries then
  With TCustom3DGridSeries(Source) do
  begin
    Self.FNumXValues   :=NumXValues;
    Self.FNumZValues   :=NumZValues;
    Self.FIrregularGrid:=FIrregularGrid;
  end;

  inherited;
end;

Procedure TCustom3DGridSeries.SetIrregularGrid(Const Value:Boolean);
begin
  SetBooleanProperty(FIrregularGrid,Value);
end;

Function TCustom3DGridSeries.CanCreateValues:Boolean;
begin
  result:= Assigned(FOnGetYValue) or (csDesigning in ComponentState)
           or IInGallery;
end;

Procedure TCustom3DGridSeries.CreateValues(NumX,NumZ:Integer);
var x           : Integer;
    z           : Integer;
    OldCapacity : Integer;
Begin
  if CanCreateValues then
  begin
    FNumXValues:=NumX;
    FNumZValues:=NumZ;

    OldCapacity:=TeeDefaultCapacity;
    TeeDefaultCapacity:=NumX*NumZ;
    try
      Clear;
      BeginUpdate;

      for z:=1 to NumZ do
          for x:=1 to NumX do AddXYZ(X,GetXZValue(X,Z),Z);

      EndUpdate;
    finally
      TeeDefaultCapacity:=OldCapacity;
    end;

    CreateDefaultPalette;
  end;
End;

Procedure TCustom3DGridSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var OldGallery : Boolean;
Begin
  if NumValues>0 then
  begin
    OldGallery:=IInGallery;
    IInGallery:=True;
    try
      CreateValues(NumValues,NumValues);
    finally
      IInGallery:=OldGallery;
    end;
  end;
End;

Procedure TCustom3DGridSeries.DoBeforeDrawChart;
begin
  inherited;

  if (not ReuseGridIndex) and (Count>0) then
     FillGridIndex;
end;

Function TCustom3DGridSeries.ExistFourGridIndex(X,Z:Integer):Boolean;
begin
  ValueIndex0:=GridIndex[x,z];
  if ValueIndex0>-1 then
  begin
    ValueIndex1:=GridIndex[x+INextXCell,z];
    if ValueIndex1>-1 then
    begin
      ValueIndex2:=GridIndex[x+INextXCell,z+INextZCell];
      if ValueIndex2>-1 then
      begin
        ValueIndex3:=GridIndex[x,z+INextZCell];
        result:=ValueIndex3>-1;
        exit;
      end;
    end;
  end;

  result:=False;
end;

function TCustom3DGridSeries.IsValidSeriesSource(Value:TChartSeries):Boolean;
begin
  result:=Value is TCustom3DGridSeries;
end;

function TCustom3DGridSeries.GetValue(X, Z: Integer): TChartValue;
var tmp : Integer;
begin
  tmp:=GridIndex[x,z];
  if tmp<>-1 then result:=YValues.Value[tmp]
             else Raise Exception.CreateFmt('No value found at XZ: %d %d',[x,z]);
end;

procedure TCustom3DGridSeries.SetValue(X, Z: Integer;
  const Value: TChartValue);
var tmp : Integer;
begin
  tmp:=GridIndex[x,z];
  if tmp<>-1 then YValues.Value[tmp]:=Value
             else GridIndex[x,z]:=AddXYZ(x,Value,z);
end;

{ TSurfaceSeries }
Constructor TSurfaceSeries.Create(AOwner: TComponent);
Begin
  inherited;
  INextXCell:=-1;
  INextZCell:=-1;
  FSideBrush:=TChartBrush.Create(CanvasChanged);
  FSideBrush.Style:=bsClear;
  FSideLines:=TChartHiddenPen.Create(CanvasChanged);
  FWaterLines:=CreateChartPen;

  // Default True?  FHideCells:=True; 
End;

Destructor TSurfaceSeries.Destroy;
Begin
  FSideLines.Free;
  FSideBrush.Free;
  FWaterLines.Free;
  inherited;
End;

class Function TSurfaceSeries.GetEditorClass:String;
Begin
  result:='TSurfaceSeriesEditor'; { <-- dont translate ! }
end;

Procedure TSurfaceSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  IInGallery:=True;
  CreateValues(10,10);
end;

Function TSurfaceSeries.CalcPointPos(const Index:Integer):TPoint;
begin
  {$IFNDEF TEEOPTCALCPOS}
  result.x:=ICalcX(IXValue[Index]);
  result.y:=ICalcY(IYValue[Index]);
  {$ELSE}
  result.x:=GetHorizAxis.CalcXPosValue(XValues.Value[Index]);
  result.y:=GetVertAxis.CalcYPosValue(YValues.Value[Index]);
  {$ENDIF}
end;

Function TSurfaceSeries.FourGridIndex(x,z:Integer):Boolean;
begin
  result:=ExistFourGridIndex(x,z);
  if result then
  begin
    Points[0]:=CalcPointPos(ValueIndex0);
    Points[1]:=CalcPointPos(ValueIndex1);
    Points[2]:=CalcPointPos(ValueIndex2);
    Points[3]:=CalcPointPos(ValueIndex3);
  end;
end;

Function TSurfaceSeries.CellsOrientation:TCellsOrientation;
var tmp : Integer;
begin
  if FWaterFall then tmp:=0 else tmp:=1;

  with result do
  begin
    if BackFaced then
    begin
      INextZCell:=1;
      InitZ:=1;
      EndZ:=NumZValues-tmp+1;
      IncZ:=1;
    end
    else
    begin
      INextZCell:=-1;
      InitZ:=NumZValues;
      EndZ:=1+tmp-1;
      IncZ:=-1;
    end;

    if DrawValuesForward then
    begin
      INextXCell:=-1;
      InitX:=2;
      EndX:=NumXValues+1;
      IncX:=1;
    end
    else
    begin
      INextXCell:=1;
      InitX:=NumXValues-1;
      EndX:=0;
      IncX:=-1;
    end;
  end;
end;

Function TSurfaceSeries.Clicked(x,y:Integer):Integer;
var tmpX : Integer;
    tmpZ : Integer;
    tmpPoint : TPoint;
    tmpPoints : TFourPoints;
    tmpO      : TCellsOrientation;
begin
  if Count>0 then
  begin
    INextXCell:=-1;
    INextZCell:=-1;
    tmpPoint:=TeePoint(x,y);

    PrepareCalcPos;
    
    tmpO:=CellsOrientation;

    with tmpO do
    begin
      INextZCell:=-INextZCell;
      IncZ:=-IncZ;
      tmpZ:=EndZ;

      while tmpZ<>InitZ do
      begin
        tmpX:=InitX;

        while tmpX<>EndX do
        begin
          if FourGridIndex(tmpX,tmpZ) then
          begin
            PointsTo2D(CalcZPos(ValueIndex0),CalcZPos(ValueIndex2),tmpPoints);

            if PointInPolygon(tmpPoint,tmpPoints) then
            begin
              result:=ValueIndex0;
              Exit;
            end;
          end;

          Inc(tmpX,IncX);
        end;

        Inc(tmpZ,IncZ); // front to back
      end;
    end;
  end;

  result:=TeeNoPointClicked;
end;

procedure TSurfaceSeries.SetSideBrush(Value:TChartBrush);
begin
  FSideBrush.Assign(Value);
end;

procedure TSurfaceSeries.SetSideLines(Value:TChartHiddenPen);
begin
  FSideLines.Assign(Value);
end;

function TSurfaceSeries.ShouldDrawFast:Boolean;
begin
  result:=ParentChart.Canvas.SupportsFullRotation;
end;

Procedure TSurfaceSeries.DrawSidePortion(var P:TFourPoints; z0,z1:Integer);
begin
  ParentChart.Canvas.PlaneFour3D(P,Z0,Z1);
end;

type
  TChartAccess=class(TCustomChart);
  TAxisPanelAccess=class(TCustomAxisPanel);

Procedure TSurfaceSeries.DrawAllValues;

  Procedure DrawAllCells;

    Function PerspectiveCorrection:Boolean;  // 7.0
    const AngleRange=11;
    var tmp:Integer;
    begin
      result:=(not ParentChart.Canvas.SupportsFullRotation) and
              (ParentChart.View3DOptions.Perspective>0);

      if result then
      begin
        tmp:=ParentChart.View3DOptions.Rotation mod 360;
        result:= (tmp=360) or (tmp=180) or (tmp=0);

// Perspective correction:
//        result:=(Abs(360-tmp)<AngleRange) or
//                (Abs(tmp)<AngleRange) or (Abs(180-tmp)<AngleRange);
      end;
    end;

  var tmpZ : Integer;
      tmpO : TCellsOrientation;
      tmpXInit,
      tmpXEnd,
      tmpX     : Integer;
      tmpPosInit : Boolean;
  begin
    tmpO:=CellsOrientation;

    with tmpO do
    if PerspectiveCorrection then
    begin
      tmpXInit:=InitX;
      tmpXEnd:=EndX;
      tmpPosInit:=True;
      tmpX:=tmpXInit;

      repeat
        tmpZ:=InitZ;

        while tmpZ<>EndZ do
        begin
          DrawCell(tmpX,tmpZ);
          Inc(tmpZ,IncZ);
        end;

        if tmpPosInit then
        begin
          Dec(tmpXEnd,IncX);
          tmpX:=tmpXEnd;
        end
        else
        begin
          Inc(tmpXInit,IncX);
          tmpX:=tmpXInit;
        end;

        tmpPosInit:=not tmpPosInit;

      until tmpXInit=tmpXEnd;
    end
    else
      while InitX<>EndX do
      begin
        tmpZ:=InitZ;

        while tmpZ<>EndZ do
        begin
          DrawCell(InitX,tmpZ);
          Inc(tmpZ,IncZ);
        end;

        Inc(InitX,IncX);
      end;
  end;

  Procedure FastDraw;
  var tmpStyle : TTeeCanvasSurfaceStyle;
  begin
    if FWireFrame or (Brush.Style=bsClear) then  // 7.02
       tmpStyle:=tcsWire
    else
    if FDotFrame then
       tmpStyle:=tcsDot
    else
       tmpStyle:=tcsSolid;

    if Transparency>0 then
       IBlender:=ParentChart.Canvas.BeginBlending(TeeRect(0,0,0,0),Transparency);

    ParentChart.Canvas.Surface3D(tmpStyle,FSameBrush,NumXValues,
                                 NumZValues,FastCalcPoints);

    if Transparency>0 then
       ParentChart.Canvas.EndBlending(IBlender);
  end;

  Procedure DrawSides(BeforeCells:Boolean);

    Function DrawFrontSideFirst(ZPos:Integer):Boolean;
    var P : TFourPoints;
        tmpBottom : Integer;
        tmpChart  : TCustomChart;  // CLR needs this
    begin
      tmpChart:=ParentChart as TCustomChart;

      with tmpChart,ChartRect do
      begin
        P[0]:=Canvas.Calculate3DPosition(Right,Top,ZPos);
        tmpBottom:=Bottom+TChartAccess(tmpChart).CalcWallSize(BottomAxis);
        P[1]:=Canvas.Calculate3DPosition(Right,tmpBottom,ZPos);
        P[2]:=Canvas.Calculate3DPosition(Left,tmpBottom,ZPos);
      end;

      result:=not TeeCull(P);
    end;

  var tmpYOrigin : Integer;

    Function CalcOnePoint(Index:Integer; Var P0,P1:TPoint):Integer;
    begin
      if Index<>-1 then
      begin
        P0:=CalcPointPos(Index);
        P1.x:=P0.x;
        P1.y:=tmpYOrigin;
        result:=CalcZPos(Index);
      end
      else result:=0;
    end;

    procedure DrawZSide(tmpRow:Integer);
    var t  : Integer;
        Z0 : Integer;
        Z1 : Integer;
        P  : TFourPoints;
    begin
      for t:=NumZValues downto 2 do
      begin
        Z0:=CalcOnePoint(GridIndex[tmpRow,t],P[0],P[1]);
        Z1:=CalcOnePoint(GridIndex[tmpRow,t-1],P[3],P[2]);
        DrawSidePortion(P,Z0,Z1);
      end;
    end;

    procedure DrawXSide(tmpRow:Integer);
    var t  : Integer;
        Z0 : Integer;
        Z1 : Integer;
        P  : TFourPoints;
    begin
      for t:=2 to NumXValues do
      begin
        Z0:=CalcOnePoint(GridIndex[t,tmpRow],P[0],P[1]);
        Z1:=CalcOnePoint(GridIndex[t-1,tmpRow],P[3],P[2]);
        DrawSidePortion(P,Z0,Z1);
      end;
    end;

  var tmpRow   : Integer;
      tmpZ     : Integer;
      tmpLeft  : Boolean;
      tmpFront : Boolean;
      tmpRight : Boolean;
      tmpChart : TCustomChart;  // CLR needs this
      P        : TFourPoints;
  begin
    With ParentChart.Canvas do
    begin
      AssignBrush(FSideBrush);
      AssignVisiblePen(FSideLines);
    end;

    With GetVertAxis do
    if Inverted then tmpYOrigin:=CalcYPosValue(YValues.MaxValue)
                else tmpYOrigin:=CalcYPosValue(YValues.MinValue);

    tmpChart:=ParentChart as TCustomChart;

    tmpLeft:={$IFNDEF CLR}TChartAccess{$ENDIF}(tmpChart).DrawLeftWallFirst;
    tmpRight:={$IFNDEF CLR}TChartAccess{$ENDIF}(tmpChart).DrawRightWallAfter;

    if (tmpLeft and (not BeforeCells)) or
       ((not tmpLeft) and BeforeCells) then
    begin
      if GetHorizAxis.Inverted then tmpRow:=NumXValues
                               else tmpRow:=1;

      DrawZSide(tmpRow);
    end;

    if (tmpRight and (not BeforeCells)) or
       ((not tmpRight) and BeforeCells) then
    begin
      if GetHorizAxis.Inverted then tmpRow:=1
                               else tmpRow:=NumXValues;

      DrawZSide(tmpRow);
    end;

    tmpFront:=not DrawFrontSideFirst(EndZ);

    if (tmpFront and BeforeCells) or
       ((not tmpFront) and (not BeforeCells)) then
    begin
      if ParentChart.DepthAxis.Inverted then tmpRow:=1
                                        else tmpRow:=NumZValues;

      DrawXSide(tmpRow);
    end;

    tmpFront:=not DrawFrontSideFirst(0);

    if (tmpFront and (not BeforeCells)) or
       ((not tmpFront) and BeforeCells) then
    begin
      if ParentChart.DepthAxis.Inverted then tmpRow:=NumZValues
                                        else tmpRow:=1;

      DrawXSide(tmpRow);

      with ParentChart.Canvas do
      begin
        Pen.Style:=psSolid;

        tmpZ:=CalcOnePoint(GridIndex[NumXValues,tmpRow],P[0],P[1]);
        VertLine3D(P[0].X,P[0].Y,tmpYOrigin,tmpZ);
      end;
    end;
  end;

  procedure PrepareBrush;
  begin
    With ParentChart.Canvas do
    begin
      AssignBrush(Self.Brush,SeriesColor);
      FSameBrush:=((not FUseColorRange) and (not FUsePalette)) or
                  Assigned(Self.Brush.Image.Graphic);

      if FWireFrame or FDotFrame then
         Brush.Style:=bsClear;

      BackMode:=cbmTransparent;
    end;
  end;

  Procedure PrepareCanvas;
  begin
    With ParentChart.Canvas do
    begin
      if (not Self.Pen.Visible) and
         (not WireFrame) and
         (not DotFrame) then
            Pen.Style:=psClear
      else
        AssignVisiblePen(Self.Pen);

      PrepareBrush;
    end;
  end;

var
  tmpBackRange   : Boolean;
  tmpBackCompare : Boolean;

  procedure DrawAllSorted;
  type
    TCellParam = TPoint;
  var
    Cells : Array of TCellParam;

    procedure SortCells(const l,r : Integer);

      function Compare(const a,b:Integer):Integer;
      var z0 : TChartValue;
          z1 : TChartValue;
      begin
        if (Cells[a].X=-1) or (Cells[b].X=-1) then
           result:=0
        else
        begin
          z0:=ZValues.Value[GridIndex[Cells[a].X,Cells[a].Y]]; // CalcZPos
          z1:=ZValues.Value[GridIndex[Cells[b].X,Cells[b].Y]]; // CalcZPos

          if z0<z1 then result:=1 else
          if z0>z1 then result:=-1 else result:=0;

          if tmpBackCompare then
             result:=-result;
        end;
      end;

    var i : Integer;
        j : Integer;
        x : Integer;
        tmp : TCellParam;
    begin
      i:=l;
      j:=r;
      x:=(i+j) shr 1;

      while i<j do
      begin
        while Compare(i,x)<0 do inc(i);
        while Compare(x,j)<0 do dec(j);

        if i<j then
        begin
          tmp:=Cells[i];
          Cells[i]:=Cells[j];
          Cells[j]:=tmp;

          if i=x then x:=j
          else
          if j=x then x:=i;
        end;

        if i<=j then
        begin
          inc(i);
          dec(j)
        end;
      end;

      if l<j then SortCells(l,j);
      if i<r then SortCells(i,r);
    end;

  var tmpZ : Integer;
      tmpO : TCellsOrientation;
      tmp,
      t,
      tmpCount : Integer;
  begin
    tmpCount:=(NumXValues-1)*(NumZValues-1);

    SetLength(Cells,tmpCount);

    try
      tmpO:=CellsOrientation;

      tmp:=0;

      with tmpO do
        while InitX<>EndX do
        begin
          tmpZ:=InitZ;

          while tmpZ<>EndZ do
          begin
            if ExistFourGridIndex(InitX,tmpZ) then
            begin
              Cells[tmp].X:=InitX;
              Cells[tmp].Y:=tmpZ;
            end
            else
            begin
              Cells[tmp].X:=-1;
              Cells[tmp].Y:=-1;
            end;

            Inc(tmpZ,IncZ);

            Inc(tmp);
          end;

          Inc(InitX,IncX);
        end;

      if ParentChart.DepthAxis.Inverted then
         tmpBackCompare:=not tmpBackRange
      else
         tmpBackCompare:=tmpBackRange;

      SortCells(0,tmpCount-1);

      for t:=0 to tmpCount-1 do
          DrawCell(Cells[t].X,Cells[t].Y);

    finally
      Cells:=nil;
    end;
  end;

  // Returns True if 3D rotation is inside the range of degrees that
  // makes a Grid series with Perspective>0 to show cells in wrong Z order 
  function InRangeRotation:Boolean; // 8.0
  begin
    with ParentChart.View3DOptions do
    begin
      tmpBackRange:=(Rotation>150) and (Rotation<210);
      result:=tmpBackRange or ((Rotation<30) or (Rotation>330));
    end;
  end;

var tmpSides : Boolean;
begin
  if Count>0 then
  begin
    PrepareCanvas;
    PrepareCalcPos;

    tmpSides:=ShouldDrawSides;

    if ShouldDrawFast then
       FastDraw
    else
    begin
      if tmpSides then
      begin
        DrawSides(True);
        PrepareCanvas;  // 8.0
      end;

      if Transparency>0 then
         IBlender:=ParentChart.Canvas.BeginBlending(TeeRect(0,0,0,0),Transparency);

      {$IFNDEF CLX}
      IsFastBrush:=FastBrush and (not WireFrame) and (Brush.Style=bsSolid); // 7.0

      if IsFastBrush then
         PrepareFastBrush;
      {$ENDIF}

      if HideCells and InRangeRotation then
         DrawAllSorted
      else
         DrawAllCells;

      if Transparency>0 then
         if ParentChart.Canvas.SupportsFullRotation then
            ParentChart.Canvas.EndBlending(IBlender)
         else
            IBlender.Free;
    end;

    if tmpSides then
       DrawSides(False);
  end;
end;

function TSurfaceSeries.ShouldDrawSides:Boolean;
begin
  result:=(FSideBrush.Style<>bsClear) or FSideLines.Visible;
end;

{$IFNDEF CLX}
procedure TSurfaceSeries.PrepareFastBrush;
begin
  CanvasDC:=ParentChart.Canvas.Handle;
  SelectObject(CanvasDC,DCBRUSH);
end;
{$ENDIF}

Function TSurfaceSeries.FastCalcPoints( x,z:Integer;
                                        Var P0,P1:TPoint3D;
                                        Var Color0,Color1:TColor):Boolean;
var tmp0 : TChartValue;
    tmp1 : TChartValue;
begin
  result:=False;

  ValueIndex0:=GridIndex[x-1,z];
  if ValueIndex0<>-1 then
  begin
    ValueIndex1:=GridIndex[x,z];
    if ValueIndex1<>-1 then
    begin
      With GetHorizAxis do
      begin
        P0.x:=CalcXPosValue(XValues.Value[ValueIndex0]);
        P1.x:=CalcXPosValue(XValues.Value[ValueIndex1]);
      end;

      P0.z:=CalcZPos(ValueIndex0);
      P1.z:=CalcZPos(ValueIndex1);
      tmp0:=YValues.Value[ValueIndex0];
      tmp1:=YValues.Value[ValueIndex1];

      With GetVertAxis do
      begin
        P0.y:=CalcYPosValue(tmp0);
        P1.y:=CalcYPosValue(tmp1);
      end;

      if not FSameBrush then
      begin
        Color0:=ValueColor[ValueIndex0];
        Color1:=ValueColor[ValueIndex1];
      end;

      result:=True;
    end;
  end;
end;

Procedure TSurfaceSeries.PointsTo2D(Z0,Z1:Integer; var P:TFourPoints);
begin
  with ParentChart.Canvas do
  begin
    P[0]:=Calculate3DPosition(Points[0],Z0);
    P[1]:=Calculate3DPosition(Points[1],Z0);
    P[2]:=Calculate3DPosition(Points[2],Z1);
    P[3]:=Calculate3DPosition(Points[3],Z1);
  end;
end;

procedure TSurfaceSeries.SetFastBrush(const Value: Boolean);
begin
  {$IFNDEF CLX}
  if Assigned(@TeeSetDCBrushColor) then
  begin
    FFastBrush:=Value;
    DCBRUSH:=GetStockObject(DC_BRUSH);
  end;
  {$ENDIF}
end;

Procedure TSurfaceSeries.DrawCell(X,Z:Integer);
var tmpColor : TColor;
    Z0       : Integer;

  Procedure DrawTheCell;
  var Z1 : Integer;

    procedure DrawDot;
    begin
      With ParentChart.Canvas do
      begin
        With Points[0] do Pixels3D[X,Y,Z0]:=ValueColor[ValueIndex0];
        With Points[1] do Pixels3D[X,Y,Z0]:=ValueColor[ValueIndex1];

        Z1:=CalcZPos(ValueIndex2);

        With Points[2] do Pixels3D[X,Y,Z1]:=ValueColor[ValueIndex2];
        With Points[3] do Pixels3D[X,Y,Z1]:=ValueColor[ValueIndex3];
      end;
    end;

  var tmp     : Integer;
      IPoints : TFourPoints;
  begin
    With ParentChart.Canvas do
    begin
      if FWaterFall then
      begin
        tmp:=GetVertAxis.IEndPos;

        if not FDotFrame then  // 7.05
        begin
          if not FWireFrame then
          begin
            Pen.Style:=psClear;

            if Transparency>0 then
            begin
              IPoints[0]:=Calculate3DPosition(Points[0],Z0);
              IPoints[1]:=Calculate3DPosition(Points[1],Z0);
              IPoints[2]:=Calculate3DPosition(TeePoint(Points[1].X,tmp),Z0);
              IPoints[3]:=Calculate3DPosition(TeePoint(Points[0].X,tmp),Z0);

              if (not SupportsFullRotation) and Assigned(IBlender) then
                 IBlender.SetRectangle(RectFromPolygon(IPoints,4));

              Polygon(IPoints);

              if (not SupportsFullRotation) and Assigned(IBlender) then
                 IBlender.DoBlend(Transparency); // 5.03
            end
            else
              PlaneWithZ(Points[0],Points[1],
                         TeePoint(Points[1].X,tmp),
                         TeePoint(Points[0].X,tmp),
                         Z0);
          end;

          AssignVisiblePen(Self.Pen);
          LineWithZ(Points[0],Points[1],Z0);
        end;

        if WaterLines.Visible then
        begin
          AssignVisiblePen(WaterLines);
          VertLine3D(Points[0].X,Points[0].Y,tmp,Z0);
          VertLine3D(Points[1].X,Points[1].Y,tmp,Z0);
        end;

        if FDotFrame then  // 7.05
           DrawDot;
      end
      else
      if FDotFrame then
         DrawDot
      else
      begin
        Z1:=CalcZPos(ValueIndex2);

        if Transparency>0 then
        begin
          PointsTo2D(Z0,Z1,IPoints);

          if (not SupportsFullRotation) and Assigned(IBlender) then
             IBlender.SetRectangle(RectFromPolygon(IPoints,4));

          Polygon(IPoints);

          if (not SupportsFullRotation) and Assigned(IBlender) then
             IBlender.DoBlend(Transparency); // 5.03
        end
        else
          PlaneFour3D(Points,Z0,Z1);
      end;
    end;
  end;

var tmp : Boolean;
Begin
  if FWaterFall then
  begin
    tmp:=False;

    ValueIndex0:=GridIndex[x,z];

    if ValueIndex0>-1 then
    begin
      ValueIndex3:=ValueIndex0; // 7.05

      ValueIndex1:=GridIndex[x+INextXCell,z];

      if ValueIndex1>-1 then
      begin
        ValueIndex2:=ValueIndex1; // 7.05

        Points[0]:=CalcPointPos(ValueIndex0);
        Points[1]:=CalcPointPos(ValueIndex1);
        tmp:=True;
      end;
    end;
  end
  else
    tmp:=FourGridIndex(X,Z);

  if tmp then
  begin
    if INextXCell=1 then
       if INextZCell=1 then
          tmpColor:=ValueColor[ValueIndex3]
       else
          tmpColor:=ValueColor[ValueIndex0]
    else
       if INextZCell=1 then
          tmpColor:=ValueColor[ValueIndex2]
       else
          tmpColor:=ValueColor[ValueIndex1];

    if tmpColor<>clNone then
    begin
      Z0:=CalcZPos(ValueIndex0);

      if not FSameBrush then
      begin
        if FSmoothPalette then
           with YValues do
           tmpColor:=GetValueColorValue(( Value[ValueIndex0]+
                                          Value[ValueIndex1]+
                                          Value[ValueIndex2]+
                                          Value[ValueIndex3])*0.25);

        if FWireFrame then
           ParentChart.Canvas.Pen.Color:=tmpColor
        else
           SetBrushColor(tmpColor);
      end;

      DrawTheCell;
    end;
  end;
end;

Procedure TSurfaceSeries.DrawValue(ValueIndex:Integer);
begin
  DrawCell(Round(XValues.Value[ValueIndex]),Round(ZValues.Value[ValueIndex]));
end;

Procedure TSurfaceSeries.SetBrushColor(const AColor:TColor);
begin
  {$IFNDEF CLX}
  if IsFastBrush then // 7.0
     TeeSetDCBrushColor(CanvasDC,AColor)
  else
  {$ENDIF}
  with ParentChart.Canvas.Brush do
       if Style<>bsClear then
          Color:=AColor;
end;

Procedure TSurfaceSeries.SetDotFrame(Value:Boolean);
Begin
  if Value then
  begin
    Pen.Visible:=True;
    FWireFrame:=False;
  end;
  SetBooleanProperty(FDotFrame,Value);
End;

Procedure TSurfaceSeries.SetWaterFall(Value:Boolean);
Begin
  SetBooleanProperty(FWaterFall,Value);
End;

Procedure TSurfaceSeries.SetWireFrame(Value:Boolean);
Begin
  if Value then
  begin
    Pen.Visible:=True;
    FDotFrame:=False;
  end;
  SetBooleanProperty(FWireFrame,Value);
End;

Procedure TSurfaceSeries.SetSmoothPalette(Value:Boolean);
begin
  SetBooleanProperty(FSmoothPalette,Value);
end;

Procedure TSurfaceSeries.Assign(Source:TPersistent);
begin
  if Source is TSurfaceSeries then
  With TSurfaceSeries(Source) do
  begin
    Self.FDotFrame     := FDotFrame;
    Self.FHideCells    := FHideCells;
    Self.SideBrush     := FSideBrush;
    Self.SideLines     := FSideLines;
    Self.FSmoothPalette:= FSmoothPalette;
    Self.FTransparency := FTransparency;
    Self.FWaterFall    := False; // 7.01  Dont use "Source".FWaterFall property
    Self.WaterLines    := WaterLines;
    Self.FWireFrame    := FWireFrame;
  end;
  
  inherited;
end;

class procedure TSurfaceSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_WireFrame);
  AddSubChart(TeeMsg_DotFrame);
  AddSubChart(TeeMsg_Sides);
  AddSubChart(TeeMsg_NoBorder);
end;

class procedure TSurfaceSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  With TSurfaceSeries(ASeries) do
  Case Index of
    2: WireFrame:=True;
    3: DotFrame:=True;
    4: SideBrush.Style:=bsSolid;
    5: Pen.Hide;
  else inherited;
  end;
end;

procedure TSurfaceSeries.SetWaterLines(const Value: TChartPen);
begin
  FWaterLines.Assign(Value);
end;

procedure TSurfaceSeries.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TSurfaceSeries.PrepareCalcPos;
begin
  {$IFNDEF TEEOPTCALCPOS}
  ICalcX:=GetHorizAxis.CalcXPosValue;
  IXValue:=XValues.Value;
  ICalcY:=GetVertAxis.CalcYPosValue;
  IYValue:=YValues.Value;
  {$ENDIF}
end;

procedure TSurfaceSeries.SetHideCells(const Value: Boolean);
begin
  SetBooleanProperty(FHideCells,Value);
end;

{ TContourMarks }

Constructor TContourMarks.Create;
begin
  inherited;
  FAtSegments:=True;
  FDensity:=4;
end;

procedure TContourMarks.Assign(Source: TPersistent);
begin
  if Source is TContourMarks then
  with TContourMarks(Source) do
  begin
    Self.FAntiOverlap:=FAntiOverlap;
    Self.FAtSegments:=FAtSegments;
    Self.FColorLevel:=FColorLevel;
    Self.FDensity:=FDensity;
    Self.FMargin:=FMargin;
  end;

  inherited;
end;

function TContourMarks.GetVisible: Boolean;
begin
  result:=IContour.Marks.Visible;
end;

type
  TSeriesAccess=class(TChartSeries);

procedure TContourMarks.SetAtSegments(const Value: Boolean);
begin
  TSeriesAccess(IContour).SetBooleanProperty(FAtSegments,Value);
end;

procedure TContourMarks.SetColorLevel(const Value: Boolean);
begin
  TSeriesAccess(IContour).SetBooleanProperty(FColorLevel,Value);
end;

procedure TContourSeries.SetContourMarks(const Value: TContourMarks);
begin
  FContourMarks.Assign(Value);
end;

procedure TContourMarks.SetDensity(const Value: Integer);
begin
  TSeriesAccess(IContour).SetIntegerProperty(FDensity,Max(1,Value));
end;

procedure TContourMarks.SetMargin(const Value: Integer);
begin
  TSeriesAccess(IContour).SetIntegerProperty(FMargin,Value);
end;

procedure TContourMarks.SetVisible(const Value: Boolean);
begin
  IContour.Marks.Visible:=Value;
end;

procedure TContourMarks.SetAntiOverlap(const Value: Boolean);
begin
  TSeriesAccess(IContour).SetBooleanProperty(FAntiOverlap,Value);
end;

{ TContourSeries }

Constructor TContourSeries.Create(AOwner: TComponent);
Begin
  inherited;

  IMandatoryPen:=True;
  Brush.Style:=bsClear;

  FLevels:=TContourLevels.Create(Self,TContourLevel);
  FSmoothing:=TSmoothPoints.Create(Self);
  FAutomaticLevels:=True;
  ColorEachPoint:=True;
  FNumLevels:=10;

  FPointer:=TSeriesPointer.Create(Self);
  FPointer.Size:=2;
  FPointer.Pen.Hide;
  FPointer.Hide;

  Marks.Transparent:=True;

  FContourMarks:=TContourMarks.Create;
  FContourMarks.IContour:=Self;

  FFrame:=TChartHiddenPen.Create(CanvasChanged);

  FLinesColor:=clBlack;
end;

Destructor TContourSeries.Destroy;
begin
  FFrame.Free;
  FContourMarks.Free;
  FPointer.Free;
  FSmoothing.Free;
  IModifyingLevels:=True;
  FLevels.Free;
  IModifyingLevels:=False;
  inherited;
end;

Procedure TContourSeries.Assign(Source:TPersistent);
begin
  if Source is TContourSeries then
  With TContourSeries(Source) do
  begin
    Self.FAutomaticLevels:=FAutomaticLevels;
    Self.FLegendLines    :=FLegendLines;
    Self.Levels          :=FLevels;
    Self.FLinesColor     :=FLinesColor;
    Self.Frame           :=Frame;
    Self.FNumLevels      :=FNumLevels;
    Self.FPointer.Assign(FPointer);
    Self.FTransparency   :=FTransparency;
    Self.FYPosition      :=FYPosition;
    Self.FYPositionLevel :=FYPositionLevel;
  end;

  inherited;
end;

procedure TContourSeries.ClearAutoLevels;
begin
  IModifyingLevels:=True;
  try
    Levels.Clear;
  finally
    IModifyingLevels:=False;
  end;
end;

Procedure TContourSeries.SetNumLevels(Value:Integer);
begin
  SetIntegerProperty(FNumLevels,Value);
  if AutomaticLevels then
     ClearAutoLevels;
end;

procedure TContourSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if not (csDestroying in ComponentState) then
     FPointer.ParentChart:=Value;
end;

Procedure TContourSeries.SetPointer(Const Value:TSeriesPointer);
begin
  FPointer.Assign(Value);
end;

Procedure TContourSeries.SetYPosition(Const Value:TChartValue);
begin
  if FYPosition<>Value then
  begin
    FYPosition:=Value;
    Repaint;
  end;
end;

Procedure TContourSeries.SetYPositionLevel(Value:Boolean);
begin
  SetBooleanProperty(FYPositionLevel,Value);
end;

procedure TContourSeries.DrawMarks;
begin
  if not FContourMarks.AtSegments then
     inherited;
end;

Procedure TContourSeries.DrawMark(ValueIndex:Integer; Const St:String;
                                  APosition:TSeriesMarkPosition);
begin
  if not FContourMarks.AtSegments then
  begin
    APosition.LeftTop.X:=CalcXPos(ValueIndex);
    APosition.LeftTop.Y:=CalcYPosValue(ZValues[ValueIndex]);

    inherited;
  end;
end;

type
  TSeriesMarksAccess=class {$IFDEF CLR}sealed{$ENDIF} (TSeriesMarks);

procedure TContourSeries.DrawAllValues;
type
  TLevelLineXY={$IFDEF LEVELSEGMENTS}TChartValue{$ELSE}Integer{$ENDIF};

  TLevelLine=packed record
    x1,z1,x2,z2 : TLevelLineXY;
  end;

  TTempLevel=packed record { temporary cache of level properties }
    Level     : TContourLevel;
    UpToValue : TChartValue;
    Color     : TColor;
    LineColor : TColor;
    Pen       : TChartPen;

    {$IFNDEF LEVELSEGMENTS}
    Count     : Integer;
    Allocated : Integer;
    Line      : Array of TLevelLine;
    {$ENDIF}
  end;

var DifY     : Array[0..4] of TChartValue;
    CellX    : Array[0..4] of TLevelLineXY;
    CellZ    : Array[0..4] of TLevelLineXY;
    ILevels  : Array of TTempLevel;
    tmpZAxis : TChartAxis;

  Procedure CalcLevel(const TheLevel:TContourLevel);
  var m1 : Integer;
      m3 : Integer;

    Procedure CalcLinePoints(Side:Integer);

      Procedure PointSect(p1,p2:Integer; Var Ax,Az:TLevelLineXY);
      var tmp : TChartValue;
      begin
        { calculate crossing XY point, return pixel coordinates }
        tmp:=DifY[p2]-DifY[p1];
        if tmp<>0 then
        begin
          tmp:=1/tmp;
          {$IFDEF LEVELSEGMENTS}
          Ax:=(DifY[p2]*CellX[p1]-DifY[p1]*CellX[p2])*tmp;
          Az:=(DifY[p2]*CellZ[p1]-DifY[p1]*CellZ[p2])*tmp;
          {$ELSE}
          Ax:=Round((DifY[p2]*CellX[p1]-DifY[p1]*CellX[p2])*tmp);
          Az:=Round((DifY[p2]*CellZ[p1]-DifY[p1]*CellZ[p2])*tmp);
          {$ENDIF}
        end
        else
        begin
          {$IFDEF LEVELSEGMENTS}
          Ax:=CellX[p2]-CellX[p1];
          Az:=CellZ[p2]-CellZ[p1];
          {$ELSE}
          Ax:=Round(CellX[p2]-CellX[p1]);
          Az:=Round(CellZ[p2]-CellZ[p1]);
          {$ENDIF}
        end;
      end;

      {$IFDEF LEVELSEGMENTS}
      // (Bottleneck procedure)
      
      // For each calculated line (x1z1->x2z2) in level,
      // try to merge it with other lines to define "segments".
      // For each segment, try to merge it with other segments to
      // construct a longer (and if possible, unique) segment.
      Procedure AddSegmentLine(const x1,z1,x2,z2:TLevelLineXY);

        // Remove "Num" segment
        Procedure DeleteSegment(const Num:Integer);
        var t : Integer;
        begin
          with TheLevel do
          begin
            FSegments[Num].Points:=nil; // deallocate memory

            for t:=Num to FSegmentCount-2 do
                FSegments[t]:=FSegments[t+1];

            Dec(FSegmentCount);
            SetLength(FSegments,FSegmentCount);
          end;
        end;

        Const Tolerance=0.0001;

        // After adding a new point to a segment, check if this segment
        // should be "connected" to another existing segment.
        procedure CheckOtherSegments(NumSegment,AtPos:Integer);
        var t  : Integer;
            tt : Integer;
            P  : TLevelPoint;
            tmpNumPoints : Integer;
            tmpLength    : Integer;
            tmpP         : TLevelPoint;
        begin
          with TheLevel do
          begin
            P:=FSegments[NumSegment].Points[AtPos];
            tmpLength:=FSegments[NumSegment].Count;

            for t:=0 to FSegmentCount-1 do
            if t<>NumSegment then
            with FSegments[t] do
            begin
              tmpNumPoints:=Count;

              tmpP:=Points[0];

              if (Abs(P.X-tmpP.X)<=Tolerance) and (Abs(P.Y-tmpP.y)<=Tolerance) then
              begin
                with FSegments[NumSegment] do
                begin
                  Count:=tmpLength+tmpNumPoints-1;
                  SetLength(Points,Count);
                end;

                if AtPos<>0 then
                begin
                  for tt:=1 to tmpNumPoints-1 do
                      FSegments[NumSegment].Points[tmpLength+tt-1]:=Points[tt];
                end
                else
                begin
                  with FSegments[NumSegment] do
                  for tt:=tmpLength-1 downto 0 do
                      Points[tt+tmpNumPoints-1]:=Points[tt];

                  for tt:=0 to tmpNumPoints-2 do
                      FSegments[NumSegment].Points[tt]:=Points[tmpNumPoints-1-tt];
                end;

                DeleteSegment(t);
                break;
              end
              else
              begin
                tmpP:=Points[tmpNumPoints-1];

                if (Abs(P.X-tmpP.X)<=Tolerance) and (Abs(P.Y-tmpP.y)<=Tolerance) then
                begin
                  with FSegments[NumSegment] do
                  begin
                    Count:=tmpLength+tmpNumPoints-1;
                    SetLength(Points,Count);
                  end;

                  if AtPos<>0 then
                  begin
                    for tt:=0 to tmpNumPoints-2 do
                        FSegments[NumSegment].Points[tmpLength+tt]:=Points[tmpNumPoints-2-tt];
                  end
                  else
                  begin
                    with FSegments[NumSegment] do
                    for tt:=tmpLength-1 downto 0 do
                        Points[tt+tmpNumPoints-1]:=Points[tt];

                    for tt:=0 to tmpNumPoints-2 do
                        FSegments[NumSegment].Points[tt]:=Points[tt];
                  end;

                  DeleteSegment(t);
                  break;
                end;
              end;
            end;
          end;
        end;

      const
          InvTolerance=1.0/Tolerance;

      var t,tt  : Integer;
          Added : Boolean;
          dist  : Integer;
      begin
        Added:=False;

        with TheLevel do
        begin
          // Find appropiate segment for point, if any
          for t:=0 to FSegmentCount-1 do
          with FSegments[t] do
          begin
            dist:=Round(InvTolerance*(Abs(x1-Points[0].x)+Abs(z1-Points[0].y)));

            if dist=0 then
            begin
              Added:=True;
              Inc(Count);
              SetLength(Points,Count);

              for tt:=Count-1 downto 1 do
                  Points[tt]:=Points[tt-1];

              Points[0].x:=x2;
              Points[0].y:=z2;

              if FSegmentCount>1 then
                 CheckOtherSegments(t,0);

              break;
            end
            else
            begin
              dist:=Round(InvTolerance*(Abs(x2-Points[0].x)+Abs(z2-Points[0].y)));

              if dist=0 then
              begin
                Added:=True;
                Inc(Count);
                SetLength(Points,Count);

                for tt:=Count-1 downto 1 do
                    Points[tt]:=Points[tt-1];

                Points[0].x:=x1;
                Points[0].y:=z1;

                if FSegmentCount>1 then
                   CheckOtherSegments(t,0);

                break;
              end
              else
              begin
                dist:=Round(InvTolerance*(Abs(x1-Points[Count-1].x)+Abs(z1-Points[Count-1].y)));

                if dist=0 then
                begin
                  Added:=True;
                  Inc(Count);
                  SetLength(Points,Count);

                  Points[Count-1].x:=x2;
                  Points[Count-1].y:=z2;

                  if FSegmentCount>1 then
                     CheckOtherSegments(t,Count-1);

                  break;
                end
                else
                begin
                  dist:=Round(InvTolerance*(Abs(x2-Points[Count-1].x)+Abs(z2-Points[Count-1].y)));

                  if dist=0 then
                  begin
                    Added:=True;
                    Inc(Count);
                    SetLength(Points,Count);

                    Points[Count-1].x:=x1;
                    Points[Count-1].y:=z1;

                    if FSegmentCount>1 then
                       CheckOtherSegments(t,Count-1);

                    break;
                  end;
                end;
              end;
            end;
          end;

          // Creates a new segment, initializes it with two points (x1z1 and x2z2)
          if not Added then
          begin
            Inc(FSegmentCount);
            SetLength(FSegments,FSegmentCount);

            with FSegments[FSegmentCount-1] do
            begin
              SetLength(Points,2);
              Count:=2;
              Points[0].x:=x1;
              Points[0].y:=z1;
              Points[1].x:=x2;
              Points[1].y:=z2;
            end;
          end;
        end;
      end;
      {$ENDIF}

    {$IFDEF LEVELSEGMENTS}
    var x1,z1,x2,z2 : TChartValue;
    {$ENDIF}
    begin
      {$IFNDEF LEVELSEGMENTS}
      with ILevels[TheLevel.Index] do
      {$ENDIF}
      begin
        {$IFNDEF LEVELSEGMENTS}
        if Count>=Allocated then
        begin
          Inc(Allocated,1000);
          SetLength(Line,Allocated);
        end;

        with Line[Count] do
        {$ENDIF}
        begin
          case Side of
             1: begin
                  x1:=CellX[m1]; z1:=CellZ[m1];
                  x2:=CellX[0];  z2:=CellZ[0];
                end;
             2: begin
                  x1:=CellX[0];  z1:=CellZ[0];
                  x2:=CellX[m3]; z2:=CellZ[m3];
                end;
             3: begin
                  x1:=CellX[m3]; z1:=CellZ[m3];
                  x2:=CellX[m1]; z2:=CellZ[m1];
                end;
             4: begin
                  x1:=CellX[m1]; z1:=CellZ[m1];
                  PointSect(0,m3,x2,z2);
                end;
             5: begin
                  x1:=CellX[0];  z1:=CellZ[0];
                  PointSect(m3,m1,x2,z2);
                end;
             6: begin
                  x1:=CellX[m3]; z1:=CellZ[m3];
                  PointSect(m1,0,x2,z2);
                end;
             7: begin PointSect(m1, 0,x1,z1); PointSect(0, m3,x2,z2); end;
             8: begin PointSect( 0,m3,x1,z1); PointSect(m3,m1,x2,z2); end;
             9: begin PointSect(m3,m1,x1,z1); PointSect(m1, 0,x2,z2); end;
          end;

          {$IFDEF LEVELSEGMENTS}
          AddSegmentLine(x1,z1,x2,z2);
          {$ENDIF}
        end;

        {$IFNDEF LEVELSEGMENTS}
        Inc(Count); { new line }
        {$ENDIF}
      end;
    end;

  const Sides : Array[-1..1,-1..1,-1..1] of Byte=
                   ( ( (0,0,8),(0,2,5),(7,6,9) ),
                     ( (0,3,4),(1,3,1),(4,3,0) ),
                     ( (9,6,7),(5,2,0),(8,0,0) )  );
  var Corner      : Integer;
      SignHeights : Array[0..4] of Integer;
      Side        : Integer;
      SignZero    : Integer;
  Begin
    { calculate signs for each corner Y value and Y average }
    for Corner:=0 to 4 do
    begin
      if DifY[Corner]>0 then SignHeights[Corner]:= 1 else
      if DifY[Corner]<0 then SignHeights[Corner]:=-1 else
                             SignHeights[Corner]:= 0;
    end;

    SignZero:=SignHeights[0]; { average Y sign }

    for Corner:=1 to 4 do
    begin
      { m1 = current corner }
      m1:=Corner;

      { m3 = next corner }
      if Corner=4 then m3:=1 else m3:=Succ(Corner);

      { find "Side" between one corner and next corner }
      Side:=Sides[SignHeights[m1],SignZero,SignHeights[m3]];

      { if valid side, calculate crossing points and add a new level line }
      if Side<>0 then CalcLinePoints(Side);
    end;
  end;

var
  tmpY         : Integer;
  tmpNumLevels : Integer; { speed opt. }

  Procedure DrawLevelLines;

  {$IFDEF LEVELSEGMENTS}
  var P : TeCanvas.TPointArray;

    procedure DrawPointers(const Color,LineColor:TColor);
    var t : Integer;
    begin
      Pointer.PrepareCanvas(ParentChart.Canvas,Color);

      if ParentChart.View3D then
         for t:=0 to Length(P)-1 do
         begin
           StartZ:=P[t].Y;
           EndZ:=StartZ;
           MiddleZ:=EndZ;
           Pointer.Draw(P[t].X,tmpY);
         end
      else
         for t:=0 to Length(P)-1 do
             Pointer.Draw(P[t]);

      ParentChart.Canvas.AssignVisiblePenColor(Pen,LineColor);
    end;
  {$ENDIF}

  var
    Position   : TSeriesMarkPosition;

    procedure DrawLevelMark(X,Y,Angle:Integer; const Text:String; Color,LineColor:TColor);

      function MarkOverlaps:Boolean;
      var tmpBounds : TRect;
          tmpR      : TRect;
          tmpDest   : TRect;
          t         : Integer;
      begin
        tmpBounds:=Position.Bounds;

        with Marks.Positions do
        for t:=0 to Count-1 do
        if Assigned(Position[t]) then
        begin
          tmpR:=Position[t].Bounds;

          if {$IFNDEF CLR}{$IFNDEF CLX}Windows.{$ENDIF}{$ENDIF}IntersectRect(tmpDest,tmpR,tmpBounds) then
          begin
            result:=True;
            Exit;
          end;
        end;

        result:=False;
      end;

    var oldAng   : Integer;
        oldColor : TColor;
        tmpPos   : TSeriesMarkPosition;
    begin
      if ParentChart.View3D then
      begin
        Marks.ZPosition:=Y;
        Y:=tmpY;
      end;

      Marks.Positions.MoveTo(Position,X,Y);

      if (not FContourMarks.AntiOverlap) or (not MarkOverlaps) then
      begin
        oldAng:=Marks.Angle;
        Marks.Angle:=oldAng+Angle;

        oldColor:=Marks.Font.Color;
        if FContourMarks.ColorLevel then
           Marks.Font.Color:=Color;

        Marks.DrawItem(Marks,Color,Text,Position);

        if FContourMarks.AntiOverlap then
        begin
          tmpPos:=TSeriesMarkPosition.Create;
          tmpPos.Assign(Position);
          Marks.Positions.Add(tmpPos);
        end;

        Marks.Angle:=oldAng;
        if FContourMarks.ColorLevel then
           Marks.Font.Color:=oldColor;

        ParentChart.Canvas.AssignVisiblePenColor(Pen,LineColor);
      end;
    end;

    var
      tmpDrawMarks : Boolean;
      tmpSt    : String;

    // Special draw marks at single values (top and bottom levels)
    procedure DrawSingleMark(const Value:TChartValue; Color:TColor);
    var tmpIndex : Integer;
    begin
      for tmpIndex:=0 to Count-1 do
      if SameValue(MandatoryValueList.Value[tmpIndex],Value) then
      begin
        SetLength(P,1);
        P[0].X:=GetHorizAxis.CalcXPosValue(XValues.Value[tmpIndex]);
        P[0].Y:=tmpZAxis.CalcPosValue(ZValues.Value[tmpIndex]);

        if Pointer.Visible then
           DrawPointers(Color,Color)
        else
        if ParentChart.View3D then
           ParentChart.Canvas.Pixels3D[P[0].X,tmpY,P[0].Y]:=Color
        else
           ParentChart.Canvas.Pixels[P[0].X,P[0].Y]:=Color;

        if tmpDrawMarks then
           DrawLevelMark(P[0].X,P[0].Y,0,tmpSt,Color,Color);

        P:=nil;
      end;
    end;

  var TheLevel : Integer;
      t        : Integer;
      {$IFDEF LEVELSEGMENTS}
      tmp,
      tt       : Integer;
      {$ENDIF}
      tmpLen,
      tmpDist  : Double;
      tmpStart,
      ttt,
      tmpXX    : Integer;
      tmpYY    : Integer;
      tmpC     : TPoint;
      tmpSize  : TPoint;
      tmpAngle : Double;
      tmpTotWidth,
      tmpMarks : Integer;
      tmpLength,
      tmpAng       : Integer;
      tmpIso       : TIsoSurfaceSeries;
  begin
    {$IFDEF LEVELSEGMENTS}
    P:=nil;
    {$ENDIF}

    tmpY:=GetVertAxis.CalcYPosValue(FYPosition);

    Position:=TSeriesMarkPosition.Create;

    ParentChart.Canvas.BackMode:=cbmTransparent;

    if Brush.Style<>bsClear then
    begin
      // FillLevels;

      tmpIso:=TIsoSurfaceSeries.Create(self);
      try
        tmpIso.Assign(Self);
        tmpIso.UseColorRange:=False;

        tmpIso.PaletteSteps:=NumLevels;
        SetLength(tmpIso.FPalette,NumLevels);

        for t:=0 to NumLevels-1 do
        begin
          tmpIso.Palette[t].UpToValue:=ILevels[t].UpToValue;
          tmpIso.Palette[t].Color:=ILevels[t].Color;
        end;

        tmpIso.UseYPosition:=not FYPositionLevel;
        tmpIso.YPosition:=FYPosition;
        tmpIso.Pen.Hide;
        tmpIso.BandPen.Hide;
        tmpIso.ParentChart:=ParentChart;

        tmpIso.Transparency:=Transparency;

        tmpIso.CalcColorRange;
        tmpIso.DrawAllValues;
      finally
        tmpIso.Free;
      end;
    end;

    Marks.Positions.Clear;

    { for each level, draw lines }
    for TheLevel:=0 to tmpNumLevels-1 do
    with ILevels[TheLevel] do
    begin
      { calculate Y position of the Level Up value }
      if FYPositionLevel then
         tmpY:=GetVertAxis.CalcYPosValue(UpToValue);

      tmpDrawMarks:=Marks.Visible and FContourMarks.AtSegments and
                    (TheLevel mod Marks.DrawEvery=0);

      if tmpDrawMarks then
      begin
        // Get mark text:
        case Marks.Style of
          smsSeriesTitle: tmpSt:=SeriesTitleOrName(Self); // 8.0
           smsPointIndex: tmpSt:=IntToStr(TheLevel);
        else
          tmpSt:=FormatFloat(ValueFormat,UpToValue);
        end;

        // Get mark size:
        CalculateMarkPosition(Marks,tmpSt,0,0,Position);
        tmpSize.X:=Position.Width;
        tmpSize.Y:=Position.Height;
      end;

      {$IFDEF LEVELSEGMENTS}
      tmp:=Level.FSegmentCount-1;
      {$ENDIF}

      ParentChart.Canvas.AssignVisiblePenColor(Pen,LineColor);

      { call event just before drawing, allow changing pen }
      if Assigned(FOnBeforeDrawLevel) then
         FOnBeforeDrawLevel(Self,TheLevel);

      {$IFDEF LEVELSEGMENTS}
      if ((TheLevel=0) or (TheLevel=tmpNumLevels-1)) and (tmp=-1) and
         (Pointer.Visible or tmpDrawMarks) then
            DrawSingleMark(UpToValue,Color);

      for t:=0 to tmp do
      begin
        P:=Level.GetSegmentPoints(t);

        if Smoothing.Active then
           P:=Smoothing.Calculate(P);

        if tmpDrawMarks then
        begin
          tmpTotWidth:=tmpSize.X+(2*FContourMarks.Margin);

          if ParentChart.View3D then
             ParentChart.Canvas.MoveTo3D(P[0].X,tmpY,P[0].Y)
          else
             ParentChart.Canvas.MoveTo(P[0]);

          tt:=1;
          tmpMarks:=0;
          tmpStart:=0;

          tmpLength:=Length(P);

          while tt<tmpLength do
          begin
            tmpXX:=P[tt].X-P[tmpStart].X;
            tmpYY:=P[tt].Y-P[tmpStart].Y;
            tmpLen:=Sqrt(Sqr(tmpXX)+Sqr(tmpYY));

            if tmpLen>tmpTotWidth then
            begin
              tmpXX:=P[tt].X-P[tt-1].X;
              tmpYY:=P[tt].Y-P[tt-1].Y;
              tmpDist:=Sqrt(Sqr(tmpXX)+Sqr(tmpYY));

              Inc(tmpMarks);

              if tmpMarks mod FContourMarks.Density=0 then
              begin
                if tmpDist>tmpTotWidth then
                begin
                  for ttt:=tmpStart+1 to tt-1 do
                      if ParentChart.View3D then
                         ParentChart.Canvas.LineTo3D(P[ttt].X,tmpY,P[ttt].Y)
                      else
                         ParentChart.Canvas.LineTo(P[ttt]);

                  tmpStart:=tt-1;
                  tmpLen:=tmpDist;
                end;

                if tmpStart=tt-1 then
                begin
                  tmpC:=PointAtDistance(P[tt],P[tt-1],Round((tmpDist-tmpTotWidth)*0.5));

                  if ParentChart.View3D then
                     ParentChart.Canvas.LineTo3D(tmpC.X,tmpY,tmpC.Y)
                  else
                     ParentChart.Canvas.LineTo(tmpC);
                end;

                //TODO: Half tmpLen might not be the right center place if
                // points are too curved
                tmpC:=PointAtDistance(P[tt],P[tmpStart],Round(tmpLen*0.5));

                tmpAngle:=ArcTan2(P[tt].X-P[tmpStart].X,P[tt].Y-P[tmpStart].Y)+Pi*0.5;

                tmpAng:=Round(tmpAngle*180/pi);
                if tmpAng<0 then tmpAng:=360+tmpAng;

                if (tmpAng>90) and (tmpAng<270) then
                begin
                  tmpAng:=tmpAng+180;
                  if tmpAng>360 then Dec(tmpAng,360);
                end;

                DrawLevelMark(tmpC.X,tmpC.Y+tmpSize.Y div 2,tmpAng,tmpSt,Color,LineColor);

                if tmpDist>=tmpTotWidth then
                   tmpC:=PointAtDistance(P[tt],P[tt-1],Round((tmpDist+tmpTotWidth)*0.5))
                else
                   tmpC:=P[tt];

                if ParentChart.View3D then
                   ParentChart.Canvas.MoveTo3D(tmpC.X,tmpY,tmpC.Y)
                else
                   ParentChart.Canvas.MoveTo(tmpC);
              end
              else
              for ttt:=tmpStart to tt do
                  if ParentChart.View3D then
                     ParentChart.Canvas.LineTo3D(P[ttt].X,tmpY,P[ttt].Y)
                  else
                     ParentChart.Canvas.LineTo(P[ttt]);

              tmpStart:=tt;
            end;

            Inc(tt);
          end;

          for ttt:=tmpStart to tmpLength-1 do
              if ParentChart.View3D then
                 ParentChart.Canvas.LineTo3D(P[ttt].X,tmpY,P[ttt].Y)
              else
                 ParentChart.Canvas.LineTo(P[ttt]);
        end
        else
        if ParentChart.View3D then
        begin
          tmpLength:=Length(P);

          ParentChart.Canvas.MoveTo3D(P[0].X,tmpY,P[0].Y);
          for ttt:=1 to tmpLength-1 do
              ParentChart.Canvas.LineTo3D(P[ttt].X,tmpY,P[ttt].Y);
        end
        else
           ParentChart.Canvas.Polyline(P);

        if Pointer.Visible then
           DrawPointers(Color,LineColor);

        P:=nil;
      end;

      {$ELSE}
      if ParentChart.View3D then
        for t:=0 to Count-1 do
        with Line[t] do  { draw the line }
        with ParentChart.Canvas do
        begin
          MoveTo3D(x1,tmpY,z1);
          LineTo3D(x2,tmpY,z2);
        end
      else
      for t:=0 to Count-1 do
      with Line[t] do  { draw the line }
           ParentChart.Canvas.Line(x1,z1,x2,z2);
      {$ENDIF}
    end;

    Position.Free;
  end;

  procedure PrepareLevels;
  var TheLevel : Integer;
  begin
    { store cache of levels }
    for TheLevel:=0 to tmpNumLevels-1 do
    with ILevels[TheLevel] do
    begin
      Level:=Levels[TheLevel];
      UpToValue:=Level.UpToValue;
      Color:=Level.InternalColor;

      {$IFDEF LEVELSEGMENTS}
      Level.ClearSegments;
      {$ELSE}
      Count:=0;
      Allocated:=0;
      {$ENDIF}

      Pen:=Level.InternalPen;

      if Brush.Style=bsClear then
         LineColor:=Color
      else
      begin
        LineColor:=LinesColor;
        if LineColor=clTeeColor then
           LineColor:=Color;
      end;
    end;
  end;

  procedure ReleaseLevelsMemory;
  {$IFNDEF LEVELSEGMENTS}
  var TheLevel : Integer;
  {$ENDIF}
  begin
    {$IFNDEF LEVELSEGMENTS}
    { release array memory }
    for TheLevel:=0 to tmpNumLevels-1 do
        ILevels[TheLevel].Line:=nil;
    {$ENDIF}

    ILevels:=nil;
  end;

  procedure CalculateLevels;
  var x,z      : Integer;
      DiffMin  : TChartValue;
      DiffMax  : TChartValue;
      tmp1     : TChartValue;
      tmp2     : TChartValue;
      tmp3     : TChartValue;
      tmp4     : TChartValue;
      tmpAvg   : TChartValue;
      TheLevel : Integer;
  begin
    { prepare default params }
    INextXCell:=1;
    INextZCell:=1;

    tmpZAxis:=GetZAxis;

    for z:=1 to NumZValues-1 do { for each cell }
      for x:=1 to NumXValues-1 do
      if ExistFourGridIndex(x,z) then  { if xz values exist }
      begin
        { calc cell screen coordinates for Z }
        {$IFDEF LEVELSEGMENTS}
        CellZ[1]:=ZValues.Value[ValueIndex0];
        CellZ[3]:=ZValues.Value[ValueIndex3];
        CellZ[2]:=CellZ[1];
        CellZ[4]:=CellZ[3];
        CellZ[0]:=(CellZ[1]+CellZ[3]) * 0.5;  { mid Z pos }
        {$ELSE}
        CellZ[1]:=tmpZAxis.CalcYPosValue(ZValues.Value[ValueIndex0]);
        CellZ[3]:=tmpZAxis.CalcYPosValue(ZValues.Value[ValueIndex3]);
        CellZ[2]:=CellZ[1];
        CellZ[4]:=CellZ[3];
        CellZ[0]:=(CellZ[1]+CellZ[3]) div 2;  { mid Z pos }
        {$ENDIF}

        { calc cell screen coordinates for X }
        {$IFDEF LEVELSEGMENTS}
        CellX[1]:=XValues.Value[ValueIndex0];
        CellX[2]:=XValues.Value[ValueIndex1];
        CellX[3]:=CellX[2];
        CellX[4]:=CellX[1];
        CellX[0]:=(CellX[1]+CellX[2]) * 0.5;  { mid X pos }
        {$ELSE}

        with GetHorizAxis do
        begin
          CellX[1]:=CalcXPosValue(XValues.Value[ValueIndex0]);
          CellX[2]:=CalcXPosValue(XValues.Value[ValueIndex1]);
        end;

        CellX[3]:=CellX[2];
        CellX[4]:=CellX[1];
        CellX[0]:=(CellX[1]+CellX[2]) div 2;  { mid X pos }
        {$ENDIF}

        { get Y value for each grid cell corner }
        With YValues do
        begin
          tmp1:=Value[ValueIndex0];
          tmp2:=Value[ValueIndex3];
          tmp3:=Value[ValueIndex1];
          tmp4:=Value[ValueIndex2];
        end;

        { calc min and max Y value of the 4 cell corners }
        DiffMin:=tmp1;
        if tmp2<DiffMin then DiffMin:=tmp2;
        if tmp3<DiffMin then DiffMin:=tmp3;
        if tmp4<DiffMin then DiffMin:=tmp4;

        if DiffMin<=ILevels[tmpNumLevels-1].UpToValue then { if Min inside all levels }
        begin
          DiffMax:=tmp1;
          if tmp2>DiffMax then DiffMax:=tmp2;
          if tmp3>DiffMax then DiffMax:=tmp3;
          if tmp4>DiffMax then DiffMax:=tmp4;

          if DiffMax>=ILevels[0].UpToValue then { if Max inside all levels }
          for TheLevel:=0 to tmpNumLevels-1 do { for each level }
          With ILevels[TheLevel] do
          if (UpToValue>=DiffMin) and (UpToValue<=DiffMax) then { if inside one level }
          begin
            { calc corners dif Y to level Up value }
            DifY[1]:=tmp1-UpToValue;
            DifY[2]:=tmp3-UpToValue;
            DifY[3]:=tmp4-UpToValue;
            DifY[4]:=tmp2-UpToValue;

            { set dif[0] to Y average }
            tmpAvg:=0.25*(tmp1+tmp2+tmp3+tmp4); { average Y value }
            DifY[0]:=tmpAvg-UpToValue;

            { calculate all lines for one level in this XZ cell }
            CalcLevel(Level);
          end;
        end;
      end;
  end;

  procedure DrawFrame;
  var R : TRect;
  begin
    with ParentChart.Canvas do
    begin
      Brush.Style:=bsClear;
      BackMode:=cbmTransparent;
      AssignVisiblePen(Self.Frame);

      With GetHorizAxis do
      begin
        R.Left:=CalcPosValue(MinXValue);
        R.Right:=CalcPosValue(MaxXValue);
      end;

      With GetZAxis do
      begin
        R.Top:=CalcPosValue(MinZValue);
        R.Bottom:=CalcPosValue(MaxZValue);
      end;

      if ParentChart.View3D then
         RectangleY(R.Left,tmpY,R.Right,R.Top,R.Bottom)
      else
         Rectangle(R);
    end;
  end;

begin
  if (Count>0) and (NumLevels>0) then
  begin
    tmpNumLevels:=NumLevels;
    SetLength(ILevels,tmpNumLevels);
    try
      PrepareLevels;
      CalculateLevels;
      DrawLevelLines;

      if Frame.Visible then
         DrawFrame;
    finally
      ReleaseLevelsMemory;
    end;
  end;
end;

procedure TContourSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
begin
  inherited;
  FYPosition:=0.5*(YValues.MaxValue+YValues.MinValue); { mid vertical pos }

  if csDesigning in ComponentState then
     TryCreateLevels;
end;

Procedure TContourSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  if not IsEnabled then SeriesColor:=clGray;
end;

class Function TContourSeries.GetEditorClass:String;
Begin
  result:='TContourSeriesEditor'; { <-- dont translate ! }
end;

Function TContourSeries.CountLegendItems:Integer;
begin
  result:=FLevels.Count div FLegendEvery;
end;

Function TContourSeries.LegendItemColor(LegendIndex:Integer):TColor;
begin  // inverted legend
  result:=LegendLevel(LegendIndex).InternalColor;
end;

Function TContourSeries.LegendString( LegendIndex:Integer;
                                      LegendTextStyle:TLegendTextStyle ):String;

  function IndexString:String;
  begin
    result:=IntToStr(LegendLevel(LegendIndex).Index);
  end;

  function ValueString:String;
  begin
    result:=FormatFloat(ValueFormat,LegendLevel(LegendIndex).UpToValue);
  end;

begin
  case LegendTextStyle of
       ltsXValue : result:=IndexString;
   ltsXAndValue,
  ltsXAndPercent : result:=IndexString+TeeColumnSeparator+ValueString;
  else
    result:=ValueString;
  end;
end;

Function TContourSeries.MaxYValue:Double;
begin
  if ParentChart.View3D then result:=inherited MaxYValue
                        else result:=ZValues.MaxValue;
end;

Function TContourSeries.MinYValue:Double;
begin
  if ParentChart.View3D then result:=inherited MinYValue
                        else result:=ZValues.MinValue;
end;

Procedure TContourSeries.CreateAutoLevels; // Calculate all Level values and colors
Var t        : Integer;
    tmp      : Double;
    tmpMin   : Double;
    tmpUpTo  : Double;
    tmpColor : TColor;
    Old      : Boolean;
    tmpLevel : TContourLevel;
begin
  if AutomaticLevels and (NumLevels>0) then
  begin
    IModifyingLevels:=True;
    try
      if Assigned(ParentChart) then
      begin
        Old:=ParentChart.AutoRepaint;
        ParentChart.AutoRepaint:=False;
      end
      else Old:=False;

      if FLevels.Count<>NumLevels then
         FLevels.Clear;

      tmp:=MandatoryValueList.Range/Max(1,NumLevels-1); // v8 changed to include max value

      tmpMin:=MandatoryValueList.MinValue;

      for t:=0 to NumLevels-1 do
      begin
        tmpUpTo:=tmpMin+tmp*t;

        if ColorEachPoint then  // 7.0
           if InternalColor(t)=clTeeColor then
              tmpColor:=clTeeColor
           else
              tmpColor:=ValueColor[t]
        else
           tmpColor:=GetValueColorValue(tmpUpTo);

        if FLevels.Count<>NumLevels then
           tmpLevel:=FLevels.AddLevel(tmpUpTo,tmpColor)
        else
        begin
          tmpLevel:=FLevels.Get(t);

          if Assigned(tmpLevel.FPen) then
             tmpLevel.FColor:=tmpLevel.FPen.Color
          else
             tmpLevel.FColor:=tmpColor;

          tmpLevel.FUpTo:=tmpUpTo;
        end;

        if Assigned(FOnGetLevel) then
           FOnGetLevel(Self,t,tmpLevel.FUpTo,tmpLevel.FColor);

        if Assigned(tmpLevel.FPen) then
           tmpLevel.FPen.Color:=tmpLevel.FColor;
      end;

      if Assigned(ParentChart) then
         ParentChart.AutoRepaint:=Old;
    finally
      IModifyingLevels:=False;
    end;
  end;
end;

Procedure TContourSeries.DoBeforeDrawChart;
begin
  inherited;

  if not (csDesigning in ComponentState) then
     TryCreateLevels;
end;

function TContourSeries.IsLevelsStored: Boolean;
begin
  result:=not AutomaticLevels;
end;

procedure TContourSeries.SetLegendLines(const Value: Boolean);
begin
  SetBooleanProperty(FLegendLines, Value);
end;

procedure TContourSeries.SetLevels(const Value: TContourLevels);
begin
  FLevels.Assign(Value);
end;

procedure TContourSeries.SetLinesColor(const Value: TColor);
begin
  SetColorProperty(FLinesColor,Value);       
end;

procedure TContourSeries.SetAutomaticLevels(const Value: Boolean);
begin
  SetBooleanProperty(FAutomaticLevels,Value);
  if AutomaticLevels then
     ClearAutoLevels;
end;

function TContourSeries.GetNumLevels: Integer;
begin
  if AutomaticLevels then result:=FNumLevels else result:=Levels.Count;
end;

class procedure TContourSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_Colors);
  AddSubChart(TeeMsg_Positions);
  AddSubChart(TeeMsg_Filled);
  AddSubChart(TeeMsg_Marks);
end;

class procedure TContourSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  with TContourSeries(ASeries) do
  Case Index of
    2: ColorEachPoint:=True;
    3: YPositionLevel:=True;
    4: Brush.Style:=bsSolid;
    5: Marks.Visible:=True;
  else inherited;
  end
end;

{$IFDEF LEVELSEGMENTS}
function TContourSeries.Clicked(x, y: Integer): Integer;
var SegmentIndex : Integer;
    PointIndex   : Integer;
begin
  result:=Levels.Clicked(x,y,SegmentIndex,PointIndex);
end;
{$ENDIF}

{ returns "Z" axis, depending on 2D or 3D }
function TContourSeries.GetZAxis: TChartAxis;
begin
  if ParentChart.View3D then result:=ParentChart.DepthAxis
                        else result:=GetVertAxis;
end;

procedure TContourSeries.SetSmoothing(const Value: TSmoothPoints);
begin
  FSmoothing.Assign(Value);
end;

{ TContourLevel }
{$IFNDEF CLR}
type
  TOwnedCollectionAccess=class(TOwnedCollection);
{$ENDIF}

Constructor TContourLevel.Create(Collection: TCollection);
begin
  inherited;
  {$IFDEF CLR}
  ISeries:=TContourSeries(Collection.Owner);
  {$ELSE}
  ISeries:=TContourSeries(TOwnedCollectionAccess(Collection).GetOwner);
  {$ENDIF}
  CheckAuto;
end;

Destructor TContourLevel.Destroy;
begin
  CheckAuto;

  With ISeries do
       if not AutomaticLevels then
          Repaint;

  FPen.Free;
  {$IFDEF LEVELSEGMENTS}
  ClearSegments;
  {$ENDIF}
  inherited;
end;

function TContourLevel.InternalColor:TColor;
begin
  if Color=clTeeColor then
     result:=ISeries.ParentChart.GetDefaultColor(Index)
  else
     result:=Color;
end;

{$IFDEF LEVELSEGMENTS}
Procedure TContourLevel.ClearSegments;
var t : Integer;
begin
  for t:=0 to FSegmentCount-1 do
      FSegments[t].Points:=nil;

  FSegmentCount:=0;
  FSegments:=nil;
end;
{$ENDIF}

Procedure TContourLevel.CheckAuto;
begin
  With ISeries do
  if not IModifyingLevels then
     FAutomaticLevels:=False;
end;

procedure TContourLevel.SetColor(const Value: TColor);
begin
  if FColor<>Value then
  begin
    ISeries.SetColorProperty(FColor,Value);
    if Assigned(FPen) then FPen.Color:=Color;
    CheckAuto;
  end;
end;

procedure TContourLevel.SetUpTo(const Value: Double);
begin
  if FUpTo<>Value then
  begin
    ISeries.SetDoubleProperty(FUpTo,Value);
    CheckAuto;
  end;
end;

procedure TContourLevel.Assign(Source: TPersistent); { 5.01 }
begin
  if Source is TContourLevel then
  With TContourLevel(Source) do
  Begin
    Self.FColor  :=FColor;
    Self.FUpTo   :=FUpTo;
    if Assigned(FPen) then Pen.Assign(FPen)
                      else FreeAndNil(FPen);
  end
  else inherited;
end;

function TContourLevel.GetPen: TChartPen;
begin
  if not Assigned(FPen) then
  begin
    FPen:=ISeries.CreateChartPen;
    FPen.Color:=InternalColor;
  end;

  result:=FPen;
end;

function TContourLevel.IsPenStored: Boolean;
begin
  result:=not DefaultPen;
end;

function TContourLevel.DefaultPen: Boolean;
begin
  result:=not Assigned(FPen);
end;

procedure TContourLevel.SetPen(const Value: TChartPen);
begin
  if Assigned(Value) then Pen.Assign(Value)
  else
  begin
    FreeAndNil(FPen);
    ISeries.Repaint;
  end;
end;

function TContourLevel.InternalPen: TChartPen;
begin
  if Assigned(FPen) then result:=FPen
                    else result:=ISeries.Pen;
end;

{$IFDEF LEVELSEGMENTS}
function TContourLevel.Clicked(x, y: Integer; var SegmentIndex,
  PointIndex: Integer): Boolean;
var t : Integer;
begin
  for t:=0 to FSegmentCount-1 do
  if ClickedSegment(x,y,t,PointIndex) then
  begin
    SegmentIndex:=t;
    result:=True;
    exit;
  end;

  result:=False;
end;

function TContourLevel.ClickedSegment(x, y, SegmentIndex: Integer;
  var PointIndex: Integer): Boolean;
var P        : TeCanvas.TPointArray;
    tmp      : TPoint;
    t        : Integer;
    tmpCount : Integer;
begin
  result:=False;

  if Assigned(ISeries.ParentChart) then
     ISeries.ParentChart.Canvas.Calculate2DPosition(X,Y,ISeries.MiddleZ);

  P:=GetSegmentPoints(SegmentIndex);
  tmp:=TeePoint(x,y);
  tmpCount:=Length(P);

  for t:=0 to tmpCount-2 do
  if PointInLine(tmp,P[t],P[t+1],0) then
  begin
    PointIndex:=t;
    result:=True;
    break;
  end;

  P:=nil;
end;

Function TContourLevel.GetSegmentPoints(SegmentIndex: Integer):TeCanvas.TPointArray;
var tmp : Integer;
    t   : Integer;
    tmpHAxis : TChartAxis;
    tmpZAxis : TChartAxis;
begin
  tmp:=FSegments[SegmentIndex].Count;
  SetLength(result,tmp);
  tmpZAxis:=ISeries.GetZAxis;
  tmpHAxis:=ISeries.GetHorizAxis;

  with FSegments[SegmentIndex] do
  for t:=0 to tmp-1 do
  begin
    result[t].x:=tmpHAxis.CalcXPosValue(Points[t].X);
    result[t].y:=tmpZAxis.CalcPosValue(Points[t].Y);
  end;
end;

function TContourLevel.SegmentCount:Integer; {$IFDEF 10}inline;{$ENDIF}
begin
  result:=FSegmentCount;
end;
{$ENDIF}

procedure TContourSeries.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TContourSeries.SetFrame(const Value: TChartHiddenPen);
begin
  FFrame.Assign(Value);
end;

{ TContourLevels }

function TContourLevels.AddLevel(const Value:Double; Color:TColor):TContourLevel;
begin
  result:=TContourLevel(Add);
  result.FUpTo:=Value;
  result.FColor:=Color;
end;

{$IFDEF LEVELSEGMENTS}
function TContourLevels.Clicked(x, y: Integer; var SegmentIndex,
  PointIndex: Integer): Integer;
var t : Integer;
begin
  for t:=0 to Count-1 do
  if Items[t].Clicked(x,y,SegmentIndex,PointIndex) then
  begin
    result:=t;
    exit;
  end;

  result:=-1;
end;
{$ENDIF}

function TContourLevels.Get(Index: Integer): TContourLevel;
begin
  result:=TContourLevel(inherited Items[Index]);
end;

procedure TContourLevels.Put(Index: Integer; Const Value: TContourLevel);
begin
  Items[Index].Assign(Value);
end;

procedure TContourSeries.TryCreateLevels;
begin
  if not IModifyingLevels then
     if AutomaticLevels and (NumLevels>0) then
        CreateAutoLevels;
end;

procedure TContourSeries.NotifyValue(ValueEvent: TValueEvent;
  ValueIndex: Integer);
begin
  if csDesigning in ComponentState then
     if not (csDestroying in ComponentState) then
        if (ValueEvent=veClear) or (ValueEvent=veRefresh) then
           TryCreateLevels;

  inherited;
end;

function TContourSeries.LegendLevel(Index:Integer):TContourLevel;
begin
  result:=Levels[NumLevels-(FLegendEvery*Index)-1];
end;

Procedure TContourSeries.DrawLegendShape(ValueIndex:Integer; Const Rect:TRect);
var tmp : TChartPen;
begin
  if LegendLines and (Brush.Style=bsClear) then
  begin
    if ValueIndex=-1 then
       ParentChart.Canvas.AssignVisiblePenColor(Pen,Color)
    else
    // legend inverted
    with LegendLevel(ValueIndex) do
    begin
      tmp:=TChartPen.Create(nil);
      try
        tmp.Assign(InternalPen);
        tmp.EndStyle:=esFlat;
        ParentChart.Canvas.AssignVisiblePenColor(tmp,InternalColor);
      finally
        tmp.Free;
      end;
    end;

    with Rect do
         ParentChart.Canvas.DoHorizLine(Left,Right,(Top+Bottom) div 2);
  end
  else
  with ParentChart.Canvas do
  begin
    Brush.Style:=bsSolid;

    if ValueIndex=-1 then
       Brush.Color:=Color
    else
       Brush.Color:=LegendItemColor(ValueIndex);

    inherited;
  end;
end;

{ TWaterFallSeries }
Constructor TWaterFallSeries.Create(AOwner: TComponent);
Begin
  inherited;
  FWaterFall:=True;
end;

procedure TWaterFallSeries.GalleryChanged3D(Is3D: Boolean);
begin
  inherited;
  ParentChart.View3D:=Is3D;
end;

class function TWaterFallSeries.GetEditorClass: String;
begin
  result:='TWaterFallEditor';
end;

class procedure TWaterFallSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  with TWaterFallSeries(ASeries) do
  Case Index of
    6: WaterLines.Hide;
  else inherited;
  end;
end;

class procedure TWaterFallSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoLines);
end;

procedure TWaterFallSeries.Assign(Source: TPersistent);  // 7.01
begin
  inherited;
  FWaterFall:=True;
end;

{ TColorGridSeries }
Constructor TColorGridSeries.Create(AOwner:TComponent);
begin
  inherited;

  FBitmap:=TBitmap.Create;

  {$IFNDEF CLX}
  {$IFNDEF LCL}
  FBitmap.IgnorePalette:=True;
  {$ENDIF}
  FBitmap.PixelFormat:=TeePixelFormat;
  {$ENDIF}

  FBitmap.TransparentColor:=clWhite;

  Marks.Callout.Length:=0;

  FFrame:=TChartHiddenPen.Create(CanvasChanged);

  FXGridEvery:=1;
  FZGridEvery:=1;

  FPlane3D:=cpZ;
end;

Destructor TColorGridSeries.Destroy;
begin
  FFrame.Free;
  FBitmap.Free;
  inherited;
end;

procedure TColorGridSeries.Assign(Source:TPersistent);
begin
  if Source is TColorGridSeries then
  with TColorGridSeries(Source) do
  begin
    Self.FCentered:=FCentered;
    Self.FSmoothBitmap:= FSmoothBitmap;
    Self.Frame:=Frame;
    Self.FPlane3D:=FPlane3D;
    Self.FPosition:=FPosition;
    Self.FTransparency:=FTransparency;
  end;

  inherited;
end;

function TColorGridSeries.CellBounds(ValueIndex:Integer):TRect;
begin
  result:=CellBounds( Round(XValues.Value[ValueIndex]),
                      Round(ZValues.Value[ValueIndex]));
end;

function TColorGridSeries.CellBounds(x,z:Integer):TRect;
var tmpIndex : Integer;
    tmp      : Integer;
begin
  tmpIndex:=GridIndex[x,z];

  With GetHorizAxis do
  begin
    result.Left:=CalcPosValue(CalcMinValue(XValues.Value[tmpIndex]));

    if (x<NumXValues) then
      result.Right:=CalcPosValue(CalcMinValue(XValues.Value[GridIndex[x+1,z]])){$IFDEF CLX}+1{$ENDIF}
    else if (NumXValues=1) then
      result.Right:=CalcPosValue(XValues.MaxValue+1)
    else
    begin
      if x>1 then
         tmp:=result.Left-CalcPosValue(CalcMinValue(XValues.Value[GridIndex[x-1,z]]))
      else
         tmp:=1;

      if CenteredPoints Then
        Inc(tmp);
      result.Right:=result.Left+tmp;
    end;
  end;

  With GetVertAxis do
  begin
    result.Top:=CalcPosValue(CalcMinValue(ZValues.Value[tmpIndex]));

    if z<NumZValues then
       result.Bottom:=CalcPosValue(CalcMinValue(ZValues.Value[GridIndex[x,z+1]])){$IFDEF CLX}+1{$ENDIF}
    else if (NumZValues=1) then
       result.Bottom:=CalcPosValue(ZValues.MaxValue+1)
    else
    begin
      if z>1 then
         tmp:=result.Top-CalcPosValue(CalcMinValue(ZValues.Value[GridIndex[x,z-1]])) //+1
      else
         tmp:=1;

      result.Bottom:=result.Top+tmp;
    end;
  end;
end;

procedure TColorGridSeries.DrawAllValues; { 5.01 - reviewed 12.03.2001 }
var tmpDec : Integer;

  Procedure FillBitmap(const tmpBounds:TRect; var HasNulls:Boolean);
  type
    TColors=packed Array[0..0] of {$IFDEF CLX}TeCanvas.{$ENDIF}TRGB;
    PColors=^TColors;

  {$IFNDEF CLR}
  {$IFNDEF LCL}
  {$DEFINE USE_SCANLINE}
  {$ENDIF}
  {$ENDIF}

  var z        : Integer;
      x        : Integer;
      {$IFDEF USE_SCANLINE}
      P        : PColors;
      Dif      : Integer;
      {$ENDIF}
      tmp      : TColor;
      tmpIndex : Integer;
      startXVal,endXVal,xIdxOffset  : Integer;
      startZVal,endZVal,zIdxOffset  : Integer;
  begin
    HasNulls:=False;

    {$IFDEF USE_SCANLINE}
    P:=FBitmap.ScanLine[0];
    if FBitmap.Height>1 then
       Dif:=Integer(FBitmap.ScanLine[1])-Integer(P)
    else
       Dif:=0;
    {$ENDIF}

    if FXStartIndex=0 then
    Begin
      startXVal:=0;
      xIdxOffset:=1;
      endXVal:=tmpBounds.Right-1-tmpDec;
    end
    else
    Begin
      startXVal:=tmpBounds.Left;
      xIdxOffset:=0;
      endXVal:=tmpBounds.Right-tmpDec;
    end;

    if FZStartIndex=0 then
    Begin
      startZVal:=0;
      zIdxOffset:=1;
      endZVal:=tmpBounds.Bottom-1-tmpDec;
    end
    else
    Begin
      startZVal:=tmpBounds.Top;
      zIdxOffset:=0;
      endZVal:=tmpBounds.Bottom-tmpDec;
    end;

    for z:=startZVal to endZVal do // 6.0
    begin
      for x:=startXVal to endXVal do // 6.0
      begin
        if (x<=-1) or (z<=-1) then
          exit
        else
        begin
          tmpIndex:=GridIndex[x+xIdxOffset,z+zIdxOffset];

          if tmpIndex<>-1 then
          begin
            tmp:=ValueColor[tmpIndex];

            if tmp=clNone then // null?
            begin
              tmp:=clWhite;  // 7.0
              HasNulls:=True;
            end;
          end
          else
          begin
            tmp:=clWhite;  // 7.0
            HasNulls:=True;
          end;

          {$IFNDEF USE_SCANLINE}
          SetPixel(FBitmap.Canvas.Handle, X-tmpBounds.Left, Z-tmpBounds.Top, tmp);
          {$ELSE}

          {$R-}
          With P^[x-startXVal] do
          begin
            {$IFDEF CLX}
            {Alpha:=0;}
            Red  := tmp and $FF;
            Green:=(tmp shr 8) and $FF;
            Blue :=(tmp shr 16) and $FF;
            {$ELSE}
            Red  :=Byte(tmp);
            Green:=Byte(tmp shr 8);
            Blue :=Byte(tmp shr 16);
            {$ENDIF}
          end;
          {$ENDIF}

        end;
      end;

      {$IFDEF USE_SCANLINE}
      // P:=FBitmap.ScanLine[z-tmpBounds.Top];
      P:=PColors(PChar(Integer(P)+Dif));
      {$ENDIF}
    end;
  end;

  Function CalcDestRectangle(const tmpBounds:TRect):TRect;
  var IAxisSizeRange,MaxMin:Double;
  begin
    With GetHorizAxis do
    begin
      If (FXStartIndex=0) Then
      Begin
        if Maximum-Minimum = 0 then MaxMin:=1 else MaxMin := Maximum-Minimum;
        IAxisSizeRange:=IAxisSize/MaxMin;
        Result.Left:=CalcPosValue(MinXValue);
        if Inverted then
          Result.Right:=Round(Result.Left-(IAxisSizeRange*(MaxXValue-MinXValue)))
        else
          Result.Right:=Round(Result.Left+(IAxisSizeRange*(MaxXValue-MinXValue)));
      end
      else
      Begin
        Result.Left:=CalcPosValue(Max(MinXValue,CalcMinValue(tmpBounds.Left)));
        Result.Right:=CalcPosValue(Min(MaxXValue,CalcMaxValue(tmpBounds.Right))){$IFDEF CLX}+1{$ENDIF};
      end;
    end;

    With GetVertAxis do
    begin
      If (FZStartIndex=0) Then
      Begin
        if Maximum-Minimum = 0 then MaxMin:=1 else MaxMin := Maximum-Minimum;
        IAxisSizeRange:=IAxisSize/(MaxMin);
        Result.Top:=CalcPosValue(MinZValue);
        if Inverted then
          Result.Bottom:=Round(Result.Top+(IAxisSizeRange*(MaxZValue-MinZValue)))
        else
          Result.Bottom:=Round(Result.Top-(IAxisSizeRange*(MaxZValue-MinZValue)));
      end
      else
      Begin
        Result.Top:=CalcPosValue(Max(MinZValue,CalcMinValue(tmpBounds.Top)));
        Result.Bottom:=CalcPosValue(Min(MaxZValue,CalcMaxValue(tmpBounds.Bottom))){$IFDEF CLX}+1{$ENDIF};
      end;
    end;
  end;

  function CalcDrawPos:Integer;
  begin
    result:=DrawPosition;

    case FPlane3D of
      cpX: Inc(result,(GetHorizAxis.IStartPos+GetHorizAxis.IEndPos) div 2);
      cpY: Inc(result,(GetVertAxis.IStartPos+GetVertAxis.IEndPos) div 2);
      cpZ: Inc(result,MiddleZ);
    end;
  end;

  Procedure DrawBitmap(const tmpBounds : TRect);
  var R : TRect;

    procedure InternalDraw(ABitmap:TBitmap);
    begin
      if ParentChart.View3D then
      begin
        if (not ParentChart.View3DOptions.Orthogonal) or (FPlane3D<>cpZ) then
        begin
          case FPlane3D of
            cpX: begin
                   R.Left:=ParentChart.DepthAxis.CalcPosValue(MinZValue);
                   R.Right:=ParentChart.DepthAxis.CalcPosValue(MaxZValue);
                 end;
            cpY: begin
                   R.Top:=ParentChart.DepthAxis.CalcPosValue(MinZValue);
                   R.Bottom:=ParentChart.DepthAxis.CalcPosValue(MaxZValue);
                 end;
            cpZ: ;
          end;

          ParentChart.Canvas.StretchDraw(R,ABitmap,CalcDrawPos,FPlane3D);
        end
        else
        with ParentChart.Canvas do
             StretchDraw(CalcRect3D(R,MiddleZ+DrawPosition),ABitmap)
      end
      else
      with ParentChart.Canvas do
           StretchDraw(CalcRect3D(R,MiddleZ+DrawPosition),ABitmap)
    end;

  var tmpDest : TBitmap;
  begin
    R:=CalcDestRectangle(tmpBounds);

    if SmoothBitmap and (FBitmap.Width>1) and (FBitmap.Height>1) then  // 7.0
    begin
      tmpDest:=TBitmap.Create;
      try
        TeeSetBitmapSize(tmpDest,Abs(R.Right-R.Left+1),Abs(R.Bottom-R.Top+1));

        if (tmpDest.Width>1) and (tmpDest.Height>1) then // 7.07
        begin
          SmoothStretch(FBitmap,tmpDest, ssBestPerformance); //NCR TV52013778
          InternalDraw(tmpDest);
        end;
      finally
        tmpDest.Free;
      end;
    end
    else
      InternalDraw(FBitmap);
  end;

  Procedure DrawGrid(const R:TRect);
  var z   : Integer;
      x   : Integer;
      tmp : Integer;
      tmpZMin  : Integer;
      tmpZMax  : Integer;
      tmpIndex : Integer;
      tmpPos   : Integer;
      tmpSub   : TChartValue;
      tmpValue : TChartValue;
      tmpGrid : Integer;
  begin
    With ParentChart.Canvas do
    begin
      BackMode:=cbmTransparent;
      AssignVisiblePen(Self.Pen);

      if CenteredPoints then
        tmpSub:=0.5
      else tmpSub:=0;

      tmpPos:=CalcDrawPos;

      tmpZMin:=ParentChart.DepthAxis.CalcPosValue(MinZValue);
      tmpZMax:=ParentChart.DepthAxis.CalcPosValue(MaxZValue);

      for z:=Round(Self.ZValues.MinValue) to ((NumZValues-tmpDec-1) div FZGridEvery) do // 6.0 & TV52012634
      begin
        tmpIndex:=1+(z*FZGridEvery);  // 7.0
        tmpGrid:=0;

        if tmpIndex>=0 then
        begin
          if (tmpIndex>=0) and (tmpIndex<length(GridIndex)) then //TF02013680
          if tmpGrid < 0 then
          begin
             tmpGrid:=GridIndex[tmpIndex,tmpIndex];
             if tmpGrid < 0 then tmpGrid:=0;
          end;
        end;

        tmpValue:=ZValues.Value[tmpGrid]-tmpSub;
        tmp:=GetVertAxis.CalcPosValue(tmpValue);

        if ParentChart.View3D then
        case FPlane3D of
          cpX: ZLine3D(tmpPos,tmp,tmpZMin,tmpZMax);
          cpY: HorizLine3D(R.Left,R.Right,tmpPos,
                           ParentChart.DepthAxis.CalcPosValue(tmpValue));
          cpZ: HorizLine3D(R.Left,R.Right,tmp,tmpPos);
        end
        else DoHorizLine(R.Left,R.Right,tmp);
      end;

      for x:=Round(Self.XValues.MinValue) to ((NumXValues-tmpDec-1) div FXGridEvery) do // 6.0 & TV52012634
      begin
        tmpIndex:=1+(x*FXGridEvery);  // 7.0
        tmpGrid:=0;

        if tmpIndex>=0 then
        begin
          tmpGrid:=GridIndex[tmpIndex,1]; //TV52013783
          if tmpGrid < 0 then
          begin
             tmpGrid:=GridIndex[tmpIndex,tmpIndex];
             if tmpGrid < 0 then tmpGrid:=0;
          end;
        end;

        tmpValue:=XValues.Value[tmpGrid]-tmpSub;
        tmp:=GetHorizAxis.CalcPosValue(tmpValue);

        if ParentChart.View3D then
        case FPlane3D of
          cpX: VertLine3D(tmpPos,R.Top,R.Bottom,ParentChart.DepthAxis.CalcPosValue(tmpValue));
          cpY: ZLine3D(tmp,tmpPos,tmpZMin,tmpZMax);
          cpZ: VertLine3D(tmp,R.Top,R.Bottom,tmpPos);
        end
        else DoVertLine(tmp,R.Top,R.Bottom);
      end;
    end;
  end;

var
  tmpBounds : TRect;

  procedure DrawUsingBitmap;
  var HasNulls : Boolean;
      tmpW     : Integer;
      tmpH     : Integer;
  begin
    // Reset internal bitmap
    FBitmap.FreeImage;

    tmpW:=Abs(1+tmpBounds.Right-tmpBounds.Left){$IFNDEF CLX}-tmpDec{$ENDIF}; { 5.01 }
    tmpH:=Abs(1+tmpBounds.Bottom-tmpBounds.Top){$IFNDEF CLX}-tmpDec{$ENDIF}; { 5.01 }

    if FXStartIndex=0 Then
      tmpW:=Ceil(MaxXValue);
    if FZStartIndex=0 Then
      tmpH:=Ceil(MaxZValue);

    TeeSetBitmapSize(FBitmap,tmpW,tmpH);

    if (FBitmap.Width * FBitmap.Height)>0 then // 7.05 fix for TV52010597
    begin
      // Fill colors
      HasNulls:=False;  // 7.05

      if Brush.Style<>bsClear then // 7.05  (somebody asked for this "feature")
         FillBitmap(tmpBounds,HasNulls)
      else
         HasNulls:=True;  // 7.05

      // Force VCL TBitmap to re-use new "null" transparent pixels
      if HasNulls then  // 7.0
      begin
        FBitmap.Transparent:=False;
        FBitmap.Transparent:=True;
      end;

      if MinXValue>1 then
      begin
        Inc(tmpBounds.Left,Ceil(MinXValue)-1);
        Inc(tmpBounds.Right,Ceil(MinXValue)-1);
      end;

      if MinZValue>1 then
      begin
        Inc(tmpBounds.Top,Ceil(MinZValue)-1);
        Inc(tmpBounds.Bottom,Ceil(MinZValue)-1);
      end;

      // Draw bitmap
      DrawBitmap(tmpBounds);
    end;
  end;

  procedure DrawCellByCell; // 7.05
  var z : Integer;
      x : Integer;
      tmpIndex : Integer;
      tmp  : TColor;
      tmpR : TRect;

      {$IFNDEF CLX}
      IsFastBrush : Boolean;
      CanvasDC    : TTeeCanvasHandle;
      {$ENDIF}
  begin
    with ParentChart.Canvas do
    begin
      Pen.Style:=psClear;
      Brush.Style:=bsSolid;

      {$IFNDEF CLX}
      IsFastBrush:= (not ParentChart.Canvas.IsNoBMPGrid) and (Assigned(@TeeSetDCBrushColor));

      if IsFastBrush then
      begin
        CanvasDC:=Handle;
        SelectObject(CanvasDC,GetStockObject(DC_BRUSH));
      end
      else CanvasDC:=0;
      {$ENDIF}
    end;

    for z:=1 to NumZValues do
    begin
      for x:=1 to NumXValues do
      begin
        tmpIndex:=GridIndex[x,z];

        if tmpIndex<>-1 then
        begin
          tmp:=ValueColor[tmpIndex];

          if tmp<>clNone then // null?
          begin
            tmpR:=CellBounds(x,z);

            with ParentChart.Canvas do
            begin
              {$IFNDEF CLX}
              if IsFastBrush then
                 TeeSetDCBrushColor(CanvasDC,tmp)
              else
              {$ENDIF}
                 Brush.Color:=tmp;

              RectangleWithZ(tmpR,MiddleZ);
            end;
          end;
        end;
      end;
    end;
  end;

var tmpBlend : TTeeBlend;
    tmpR     : TRect;
    tmpMinZ  : Integer;
    tmpMaxZ  : Integer;
begin
  if Count>0 then
  begin
    { In non-centered mode, size of grid is one less (x-1, z-1) }
//    if CenteredPoints or (not IrregularGrid) then
//       tmpDec:=0
//    else
    tmpDec:=0;  //MM

    FXRegularSteps := False;
    FZRegularSteps := False;
    FXRegularStep :=-1;
    FZRegularStep :=-1;

    // v7 Calculate min and max bitmap bounds when axes are zoomed
    with tmpBounds do
    begin
      with GetHorizAxis do
      begin
        Left:=Trunc(CalcPosPoint(IStartPos));
        Right:=Trunc(CalcPosPoint(IEndPos));
        if Inverted then Inc(Left) else Inc(Right);
      end;
      with GetVertAxis do
      begin
        Top:=Trunc(CalcPosPoint(IStartPos));
        Bottom:=Trunc(CalcPosPoint(IEndPos));
        if Inverted then Inc(Bottom) else Inc(Top);
      end;
    end;

    // Restrict min and max bounds limits to 1..NumValues
    // Warning: tmpBounds is expressed in integers, starting at 1.
    tmpBounds:=OrientRectangle(tmpBounds);

    begin
      Dec(tmpBounds.Left,Round(MinXValue));
      Dec(tmpBounds.Top,Round(MinZValue));
      Dec(tmpBounds.Right,Round(MinXValue));
      Dec(tmpBounds.Bottom,Round(MinZValue));

      if (FXStartIndex<>0) then
        if tmpBounds.Left<1 then tmpBounds.Left:=1;
      if (FZStartIndex<>0) then
        if tmpBounds.Top<1 then tmpBounds.Top:=1;

      if tmpBounds.Right>NumXValues then tmpBounds.Right:=NumXValues;
      if tmpBounds.Bottom>NumZValues then tmpBounds.Bottom:=NumZValues;
    end;

    if FTransparency<>0 then
    begin
      tmpR:=CalcDestRectangle(tmpBounds);

      if ParentChart.View3D then
         if ParentChart.View3DOptions.Orthogonal then
            tmpR:=ParentChart.Canvas.CalcRect3D(tmpR,MiddleZ)
         else
            tmpR:=ParentChart.Canvas.RectFromRectZ(tmpR,MiddleZ);

       tmpBlend:=ParentChart.Canvas.BeginBlending(tmpR,FTransparency);
    end
    else
       tmpBlend:=nil;

    if (ParentChart.Canvas.IsNoBMPGrid) or IrregularGrid then
       DrawCellByCell  // 8.05
    else
       DrawUsingBitmap;

    if Pen.Visible then
       DrawGrid(CalcDestRectangle(tmpBounds));

    if Frame.Visible then
    With ParentChart.Canvas do
    begin
      Brush.Style:=bsClear;
      BackMode:=cbmTransparent;
      AssignVisiblePen(Self.Frame);

      if ParentChart.View3D then
      begin
        tmpMinZ:=ParentChart.DepthAxis.CalcPosValue(MinZValue);
        tmpMaxZ:=ParentChart.DepthAxis.CalcPosValue(MaxZValue);

        case FPlane3D of
          cpX: with CalcDestRectangle(tmpBounds) do
                    RectangleZ(CalcDrawPos,Top,Bottom,tmpMinZ,tmpMaxZ);

          cpY: with CalcDestRectangle(tmpBounds) do
                    RectangleY(Left,CalcDrawPos,Right,tmpMinZ,tmpMaxZ);
        else
          RectangleWithZ(CalcDestRectangle(tmpBounds),CalcDrawPos);
        end
      end
      else
        Rectangle(CalcDestRectangle(tmpBounds));
    end;

    if Assigned(tmpBlend) then
       ParentChart.Canvas.EndBlending(tmpBlend);
  end;
end;

procedure TColorGridSeries.SetXGridEvery(const Value: Integer);
begin
  SetIntegerProperty(FXGridEvery,Value);
end;

procedure TColorGridSeries.SetZGridEvery(const Value: Integer);
begin
  SetIntegerProperty(FZGridEvery,Value);
end;

procedure TColorGridSeries.SetSmoothBitmap(const Value: Boolean);
begin
  SetBooleanProperty(FSmoothBitmap,Value);
end;

procedure TColorGridSeries.SetPlane3D(const Value: TCanvas3DPlane);
begin
  if FPlane3D<>Value then
  begin
    FPlane3D:=Value;
    Repaint;
  end;
end;

procedure TColorGridSeries.SetFrame(const Value: TChartHiddenPen);
begin
  FFrame.Assign(Value);
end;

procedure TColorGridSeries.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

function TColorGridSeries.CalcMinValue(const Value:Double):Double;
begin
  if CenteredPoints then
     result:=Value-0.5 // 6.0
  else
     result:=Value;
end;

function TColorGridSeries.CalcXPos(ValueIndex: Integer): Integer;
begin
    result:=inherited CalcXPos(ValueIndex);
    if not FCentered then
      Inc(result, CalcXSizeValue(0.5));
end;

function TColorGridSeries.CalcYPos(ValueIndex: Integer): Integer;
begin
    result:=CalcYPosValue(ZValues.Value[ValueIndex]);
    if not FCentered then
      Dec(result, CalcYSizeValue(0.5));
end;

function TColorGridSeries.CalcMaxValue(const Value:Double):Double;
begin
  if CenteredPoints then
  begin
    result:=Value+0.5;
    if IrregularGrid then
       result:=result-1;
  end
  else
  if IrregularGrid then
     result:=Value
  else
     result:=Value+1;
end;

Function TColorGridSeries.MaxXValue:Double;

  function CalcVal : Double;
  var //tmp,
      incr : Double;
      i, zCycle : Integer;
  begin
   if IrregularGrid then
   Begin
     zCycle := NumZValues;

     for i:=1 to NumZValues-1  do
     Begin
       if XValues.Value[i] <> XValues.Value[i-1] then
       Begin
         zCycle := 1;
         break;
       end;
     end;

     incr:=0;

     With GetHorizAxis do
     Begin
       if NumXValues > 1 Then
       Begin
        incr:=Abs(XValues.Value[(NumXValues-1)*zCycle]
                  -XValues.Value[(NumXValues-2)*zCycle]);

        FXRegularSteps:=True;

        if (NumXValues > 2) Then
          For i:=2 to NumXValues-1 do
          Begin
            if Abs((Abs(XValues.Value[(NumXValues-i)*zCycle]
                   -XValues.Value[(NumXValues-(i+1))*zCycle]))
                   - incr) > MinAxisIncrement then
            Begin
              FXRegularSteps:=False;
              result:=XValues.MaxValue;
              Exit;
            end
            else
              FXRegularStep:=incr;
          end
       end
       else
       if (NumXValues=1) Then
         incr:=XValues.Value[0];

       if incr < MinAxisIncrement Then
       Begin
        incr := 1;
        FXRegularStep:=incr;
       end;
         result:=XValues.MaxValue+incr
     end;
   end
   else
     result:=XValues.MaxValue;
  end;

begin
  result:=CalcMaxValue(CalcVal);
end;

function TColorGridSeries.MinXValue: Double;
begin
  result:=CalcMinValue(XValues.MinValue);
end;

Function TColorGridSeries.MaxZValue:Double;

  function CalcVal : Double;
  var //tmp,
      incr : Double;
      i : Integer;
  Begin
   if IrregularGrid then
     With GetVertAxis do
     Begin
       incr:=0;

       if (ZValues.Count>0) Then
         if (NumZValues>1) Then
         Begin
          incr:=Abs(ZValues.Value[(NumZValues-1)]
                    -ZValues.Value[(NumZValues-2)]);

          FZRegularSteps:=True;

          if (NumZValues>2) Then
            For i:=2 to NumZValues-1 do
            Begin
              if Abs((Abs(ZValues.Value[(NumZValues-i)]
                     -ZValues.Value[(NumZValues-(i+1))]))
                     - incr) > MinAxisIncrement then
              begin
                FZRegularSteps:=False;
                result:=ZValues.MaxValue;
                Exit;
              end
              else
                FZRegularStep:=incr;
            end;
         end
         else
         if (NumZValues=1) Then
           incr:=ZValues.Value[0];

       if incr < MinAxisIncrement Then
       Begin
         FZRegularStep:=incr;
         incr := 1;
       end;

       result:=ZValues.MaxValue+incr
     end
   else
     result:=ZValues.MaxValue;
  end;

  begin
  result:=CalcMaxValue(CalcVal);
end;

Function TColorGridSeries.MaxYValue:Double;
begin
  result:=MaxZValue;
end;

Function TColorGridSeries.MinZValue:Double;
begin
  result:=CalcMinValue(ZValues.MinValue);
end;

Function TColorGridSeries.MinYValue:Double;
begin
  result:=MinZValue;
end;

Procedure TColorGridSeries.GalleryChanged3D(Is3D:Boolean);
begin
  inherited;
  ParentChart.View3D:=Is3D;
  ParentChart.ClipPoints:=True;
end;

class function TColorGridSeries.GetEditorClass: String;
begin
  result:='TColorGridEditor';
end;

procedure TColorGridSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  IInGallery:=True;
  CreateValues(8,4);
end;

class procedure TColorGridSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoGrid);
  AddSubChart(TeeMsg_BottomAxis);
  AddSubChart(TeeMsg_LeftAxis);
end;

class procedure TColorGridSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  Case Index of
    2: ASeries.Pen.Hide;
    3: TColorGridSeries(ASeries).DrawPlane3D:=cpY;
    4: TColorGridSeries(ASeries).DrawPlane3D:=cpX;
  else inherited
  end;
end;

function TColorGridSeries.Clicked(X, Y: Integer): Integer; { 5.01 - reviewed 12.03.2001 }
var i      : Integer;
    XPos   : Double;
    YPos   : Double;
    ZIndex : Integer;
    YDif   : Double;
    XDif   : Double; { 5.01 }
    tmpDecAmount: Double;
    isIrregular: Boolean;
begin
  result:=TeeNoPointClicked;

  ZIndex:=-1;
  XPos:=GetHorizAxis.CalcPosPoint(X);
  YPos:=GetVertAxis.CalcPosPoint(Y);

  if CenteredPoints then
    tmpDecAmount:=0.5
  else tmpDecAmount:=0;

  isIrregular:=IrregularGrid and not (FXRegularSteps and FZRegularSteps);

  if isIrregular then { irregular grid - slower algorithm }
  begin
    if Count > 0 then   // TA05011011 7.06
    begin
      for i := 0 to NumZValues-1 do
      if ((ZValues.Value[i*NumXValues] - tmpDecAmount) <= YPos) and     //TV52012978
         ((ZValues.Value[(i+1)*NumXValues] - tmpDecAmount) > YPos) or
         ((i=NumZValues-1) and (FZRegularSteps) and
         ((ZValues.Value[i*NumXValues] - tmpDecAmount + FXRegularStep) >= YPos)) then
      begin
        ZIndex := i;
        break;
      end;
      if ZIndex <> -1 then { search further only if it makes sense }
      begin
        for i := 0 to NumXValues-1 do
        if ((XValues.Value[i] - tmpDecAmount) <= XPos) and
           ((XValues.Value[(i+1)]  - tmpDecAmount) > XPos) or
           ((i=NumXValues-1) and (FXRegularSteps) and
           ((XValues.Value[i*NumXValues-1] - tmpDecAmount + FXRegularStep) >= XPos)) then
        begin
          Result := ZIndex*NumXValues+i;
          Exit;
        end;
      end;
    end;
  end
  else { indexed grid - faster algorithm }
  begin
    YDif := (YPos + tmpDecAmount - ZValues.MinValue); { 5.01 }
    if YDif >=0 then i := Trunc(YDif) else i := -1;

    if (i >= 0) and (i < NumZValues) then ZIndex := i;
    if ZIndex <> -1 then { search further only if it makes sense }
    begin
      XDif := (XPos + tmpDecAmount - XValues.MinValue); { 5.01 }
      if XDif >=0 then i := Trunc(XDif) else i := -1;
      if (i >= 0) and (i < NumXValues) then
      begin
        result := GridIndex[i+1,ZIndex+1]; { 5.01 - 13.03 fix }
        Exit;
      end;
    end;
  end;
end;

procedure TColorGridSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
var tmp : Double;
begin
  with APosition do
  begin
    if CenteredPoints or IrregularGrid then
      tmp:=0.5
    else tmp:=0.5;

    LeftTop.Y:=GetVertAxis.CalcPosValue(ZValues.Value[ValueIndex]+tmp)-(Height div 2);
    LeftTop.X:=GetHorizAxis.CalcPosValue(XValues.Value[ValueIndex]+tmp)-(Width div 2);
  end;

  inherited;
end;

procedure TColorGridSeries.SetCentered(const Value: Boolean);
begin
  SetBooleanProperty(FCentered,Value);
end;

procedure TColorGridSeries.SetBitmap(const Value: TBitmap);
var x : Integer;
    z : Integer;
    tmp : TColor;
begin
  FBitmap.Assign(Value);
  FBitmap.PixelFormat:=TeePixelFormat;

  BeginUpdate;
  try
    Clear;
    CenteredPoints:=True;

    NumXValues:=FBitmap.Width;
    NumZValues:=FBitmap.Height;

    for x:=0 to FBitmap.Width-1 do
        for z:=0 to FBitmap.Height-1 do
        begin
          {$IFDEF D7}
          tmp:=FBitmap.Canvas.Pixels[x,z];
          {$ELSE}
          {$IFNDEF CLX}
          tmp:=FBitmap.Canvas.Pixels[x,z];
          {$ELSE}
          {$IFDEF MSWINDOWS}
          tmp:=Windows.GetPixel(QPainter_handle(FBitmap.Canvas.Handle), x, z);
          {$ELSE}
          tmp:=0; // Linux, not implemented
          {$ENDIF}
          {$ENDIF}
          {$ENDIF}

          AddXYZ(x+1,tmp,z+1,'',tmp);
        end;
  finally
    EndUpdate;
  end;
end;

{ TSmoothPoints function }
Constructor TSmoothPoints.Create(Parent: TChartSeries);
begin
  {$IFDEF CLR}
  inherited Create;
  {$ENDIF}
  ISeries:=Parent;
  Factor:=4;
end;

procedure TSmoothPoints.Assign(Source: TPersistent);
begin
  if Source is TSmoothPoints then
  begin
    FActive:=TSmoothPoints(Source).FActive;
  end
  else inherited;
end;

function TSmoothPoints.Calculate(const P: Array of TPoint): TeCanvas.TPointArray;
var Spline   : TBSpline;
    t        : Integer;
    tmpCount : Integer;
    tmp      : TDataType;
begin
  Spline:=TBSpline.Create;
  try
    tmpCount:=Length(P);

    for t:=0 to tmpCount-1 do
    begin
      Spline.AddPoint(P[t].X,P[t].Y);
      Spline.Knuckle[t]:=False;
    end;

    Spline.Interpolated:=Interpolate;
    Spline.Fragments:=tmpCount*Factor;

    SetLength(result,Spline.Fragments+1);

    with Spline do
    begin
      tmp:=1.0/Fragments;

      for t:=0 to Fragments do
      with Value(t*tmp) do
      begin
        result[t].X:=Round(X);
        result[t].Y:=Round(Y);
      end;
    end;

  finally
    Spline.Free;
  end;
end;

procedure TSmoothPoints.SetActive(const Value: Boolean);
begin
  TSeriesAccess(ISeries).SetBooleanProperty(FActive,Value);
end;

procedure TSmoothPoints.SetInterpolate(const Value: Boolean);
begin
  TSeriesAccess(ISeries).SetBooleanProperty(FInterpolate,Value);
end;

procedure TColorGridSeries.SetPosition(const Value: Integer);
begin
  SetIntegerProperty(FPosition,Value);
end;

{ TVector3DSeries }
type
  TValueListAccess=class(TChartValueList);

Constructor TVector3DSeries.Create(AOwner: TComponent);
begin
  inherited;
  CalcVisiblePoints:=False;
  TValueListAccess(XValues).InitDateTime(False);
  FEndXValues:=TChartValueList.Create(Self,TeeMsg_ValuesArrowEndX);
  FEndYValues:=TChartValueList.Create(Self,TeeMsg_ValuesArrowEndY);
  FEndZValues:=TChartValueList.Create(Self,TeeMsg_ValuesVectorEndZ);
  FArrowWidth:=4;
  FArrowHeight:=4;
  FStartArrow:=TChartHiddenPen.Create(CanvasChanged);
  FStartArrow.Color:=clTeeColor;
  FEndArrow:=CreateChartPen;
  FEndArrow.Color:=clTeeColor;
end;

function TVector3DSeries.AddVector(const X0, Y0, Z0, X1, Y1, Z1: Double;
  const ALabel: String; AColor: TColor): Integer;
begin
  EndXValues.TempValue:=X1;
  EndYValues.TempValue:=Y1;
  EndZValues.TempValue:=Z1;
  result:=AddXYZ(X0,Y0,Z0,ALabel,AColor);
end;

function TVector3DSeries.IsValidSourceOf(Value: TChartSeries): Boolean;
begin
  result:=Value is TVector3DSeries;
end;

function TVector3DSeries.MaxZValue: Double;
begin
  result:=Math.Max(inherited MaxZValue,FEndZValues.MaxValue);
end;

function TVector3DSeries.MinZValue: Double;
begin
  result:=Math.Min(inherited MinZValue,FEndZValues.MinValue);
end;

procedure TVector3DSeries.SetEndXValues(Value: TChartValueList);
begin
  SetChartValueList(FEndXValues,Value);
end;

procedure TVector3DSeries.SetEndYValues(Value: TChartValueList);
begin
  SetChartValueList(FEndYValues,Value);
end;

procedure TVector3DSeries.SetEndZValues(Value: TChartValueList);
begin
  SetChartValueList(FEndZValues,Value);
end;

procedure TVector3DSeries.DrawValue(ValueIndex: Integer);
var tmpColor : TColor;
    tmpSin   : Extended;
    tmpCos   : Extended;

  Procedure DrawArrow(APen:TChartPen; P:TPoint; Z:Integer);
  begin
    with ParentChart.Canvas do
    begin
      if APen.Color=clTeeColor then
         AssignVisiblePenColor(APen,tmpColor)
      else
         AssignVisiblePen(APen);

      MoveTo3D(P.X + Round(-FArrowWidth*tmpCos - FArrowHeight*tmpSin),
             P.Y + Round(+FArrowWidth*tmpSin - FArrowHeight*tmpCos),Z);
      LineTo3D(P.X,P.Y,Z);
      LineTo3D(P.X + Round(-FArrowWidth*tmpCos + FArrowHeight*tmpSin),
             P.Y + Round(+FArrowWidth*tmpSin + FArrowHeight*tmpCos),Z);
    end;
  end;

var StartZ     : Integer;
    EndZ       : Integer;
    StartPoint, tmpStart : TPoint;
    EndPoint, tmpEnd : TPoint;
    tmpAngle   : Double;
begin
  with ParentChart.Canvas do
  begin
    BackMode:=cbmTransparent;
    tmpColor:=ValueColor[ValueIndex];
    AssignVisiblePenColor(Self.Pen,tmpColor);

    StartPoint.X:=CalcXPos(ValueIndex);
    StartPoint.Y:=CalcYPos(ValueIndex);
    StartZ:=CalcZPos(ValueIndex);

    MoveTo3D( StartPoint.X,StartPoint.Y,StartZ );

    EndPoint.X:=CalcXPosValue(EndXValues.Value[ValueIndex]);
    EndPoint.Y:=CalcYPosValue(EndYValues.Value[ValueIndex]);
    EndZ:=ParentChart.DepthAxis.CalcYPosValue(EndZValues.Value[ValueIndex]);

    LineTo3D( EndPoint.X,EndPoint.Y,EndZ );

    if StartArrow.Visible or EndArrow.Visible then
    begin
      //tmpStart & tmpEnd discarded after arrow angle calc
      tmpStart:=StartPoint;
      tmpEnd:=EndPoint;
      tmpStart:=Calculate3DPosition(tmpStart,StartZ);
      tmpEnd:=Calculate3DPosition(tmpEnd,EndZ);

      tmpAngle:=ArcTan2(tmpStart.Y-tmpEnd.Y,tmpEnd.X-tmpStart.X);
      SinCos(tmpAngle,tmpSin,tmpCos);

      if StartArrow.Visible then DrawArrow(StartArrow,StartPoint,StartZ);
      if EndArrow.Visible then DrawArrow(EndArrow,EndPoint,EndZ);
    end;
  end;
end;

Procedure TVector3DSeries.AddSampleValues(NumValues:Integer; OnlyMandatory:Boolean=False);
var t:Integer;
    x0,y0,z0,x1,y1,z1:Double;
    tmpPi,tmp,u,v:Double;
begin
  u:=0;
  v:=0;
  tmp:=NumValues*0.6;
  tmpPi:=8*Pi/NumValues;

  for t:=1 to NumValues do
  begin
    x0:=u+sin(v);
    y0:=u;
    z0:=cos(v);

    x1:=x0+sin(v);
    y1:=y0+tmp*cos(v)*sin(v);
    z1:=z0+cos(v)*u;

    AddVector(x0,y0,z0,x1,y1,z1);

    u:=u+1;
    v:=v+tmpPi;
  end;
end;

function TVector3DSeries.MaxXValue: Double;
begin
  result:=Math.Max(inherited MaxXValue,FEndXValues.MaxValue);
end;

function TVector3DSeries.MaxYValue: Double;
begin
  result:=Math.Max(inherited MaxYValue,FEndYValues.MaxValue);
end;

function TVector3DSeries.MinXValue: Double;
begin
  result:=Math.Min(inherited MinXValue,FEndXValues.MinValue);
end;

function TVector3DSeries.MinYValue: Double;
begin
  result:=Math.Min(inherited MinYValue,FEndYValues.MinValue);
end;

function TVector3DSeries.NumSampleValues: Integer;
begin
  result:=250;
end;

procedure TVector3DSeries.Assign(Source: TPersistent);
begin
  if Source is TVector3DSeries then
  with TVector3DSeries(Source) do
  begin
    Self.FArrowHeight :=FArrowHeight;
    Self.FArrowWidth  :=FArrowWidth;
    Self.EndArrow     :=EndArrow;
    Self.StartArrow   :=StartArrow;
  end;
  inherited;
end;

procedure TVector3DSeries.SetArrowHeight(const Value: Integer);
begin
  SetIntegerProperty(FArrowHeight,Value);
end;

procedure TVector3DSeries.SetArrowWidth(const Value: Integer);
begin
  SetIntegerProperty(FArrowWidth,Value);
end;

procedure TVector3DSeries.SetEndArrow(const Value: TChartPen);
begin
  FEndArrow.Assign(Value);
end;

procedure TVector3DSeries.SetStartArrow(const Value: TChartHiddenPen);
begin
  FStartArrow.Assign(Value);
end;

destructor TVector3DSeries.Destroy;
begin
  FStartArrow.Free;
  FEndArrow.Free;
  inherited;
end;

class function TVector3DSeries.GetEditorClass: String;
begin
  result:='TVectorSeriesEditor';
end;

{ TTowerSeries }
constructor TTowerSeries.Create(AOwner: TComponent);
begin
  inherited;
  FPercDepth:=100;
  FPercWidth:=100;
  FDark3D:=True;
end;

function TTowerSeries.Clicked(X, Y: Integer): Integer;
var tmpX : Integer;
    tmpZ : Integer;
    P    : TPoint;

  function ClickedCell(var res:Integer):Boolean; // v8
  var
    tmpR : TRect;
    z0   : Integer;
    z1   : Integer;
    tmpTop    : Integer;
    tmpBottom : Integer;

    function PointInCover:Boolean;
    var tmpP : TFourPoints;
    begin
      with ParentChart.Canvas do
      begin
        tmpP[0]:=Calculate3DPosition(tmpR.Left,tmpTop,z0);
        tmpP[1]:=Calculate3DPosition(tmpR.Right,tmpTop,z0);
        tmpP[2]:=Calculate3DPosition(tmpR.Right,tmpTop,z1);
        tmpP[3]:=Calculate3DPosition(tmpR.Left,tmpTop,z1);
      end;

      result:=PointInPolygon(P,tmpP);
    end;

    function PointInFront:Boolean;
    var tmpP : TFourPoints;
    begin
      with ParentChart.Canvas do
      begin
        tmpP[0]:=Calculate3DPosition(tmpR.Left,tmpTop,z0);
        tmpP[1]:=Calculate3DPosition(tmpR.Right,tmpTop,z0);
        tmpP[2]:=Calculate3DPosition(tmpR.Right,tmpBottom,z0);
        tmpP[3]:=Calculate3DPosition(tmpR.Left,tmpBottom,z0);
      end;

      result:=PointInPolygon(P,tmpP);
    end;

  var tmp : Integer;
  begin
    result:=False;

    tmp:=GridIndex[tmpX,tmpZ];

    if (tmp<>-1) and (InternalColor(tmp)<>clNone) then
    begin
      tmpR:=CalcCell(tmp,tmpTop,tmpBottom,z0,z1);

      case TowerStyle of
        tsCover: result:=PointInCover;
      else
        result:=PointInFront or PointInCover;
      end;

      if result then
      begin
        res:=tmp;
        exit;
      end;
    end;
  end;

begin
  if Count>0 then
  begin
    IOffW:=FPercWidth*0.005;
    IOffD:=FPercDepth*0.005;
    P:=TeePoint(x,y);

    if not BackFaced then // invert logic (compared to DrawAllValues)
      if not DrawValuesForward then
        for tmpX:=NumXValues downto 1 do
            for tmpZ:=1 to NumZValues do
            begin
              if ClickedCell(result) then exit;
            end
      else
        for tmpX:=NumXValues downto 1 do
            for tmpZ:=1 to NumZValues do
            begin
              if ClickedCell(result) then exit;
            end
    else
      if not DrawValuesForward then
        for tmpX:=NumXValues downto 1 do
            for tmpZ:=NumZValues downto 1 do
            begin
              if ClickedCell(result) then exit;
            end
      else
        for tmpX:=1 to NumXValues do
            for tmpZ:=NumZValues downto 1 do
            begin
              if ClickedCell(result) then exit;
            end;
  end;

  result:=TeeNoPointClicked;
end;

class procedure TTowerSeries.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_NoBorder);
  AddSubChart(TeeMsg_SingleColor);
  AddSubChart(TeeMsg_Marks);
  AddSubChart(TeeMsg_Hollow);
  AddSubChart(TeeMsg_Rectangle);
  AddSubChart(TeeMsg_Cover);
  AddSubChart(TeeMsg_Circle);
  AddSubChart(TeeMsg_GalleryArrow);
  AddSubChart(TeeMsg_Cone);
  AddSubChart(TeeMsg_Pyramid);
end;

procedure TTowerSeries.DrawMark(ValueIndex: Integer; const St: String;
  APosition: TSeriesMarkPosition);
begin
  Marks.ApplyArrowLength(APosition);
  inherited;
end;

class function TTowerSeries.GetEditorClass: String;
begin
  result:='TTowerSeriesEditor';
end;

function TTowerSeries.MaxXValue: Double;
begin
  result:=XValues.MaxValue+0.5;
end;

function TTowerSeries.MaxZValue: Double;
begin
  result:=ZValues.MaxValue+0.5;
end;

function TTowerSeries.MinXValue: Double;
begin
  result:=XValues.MinValue-0.5;
end;

function TTowerSeries.MinZValue: Double;
begin
  result:=ZValues.MinValue-0.5;
end;

procedure TTowerSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  IInGallery:=True;
  CreateValues(5,5);
end;

class procedure TTowerSeries.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  case Index of
    2: ASeries.Pen.Hide;
    3: TTowerSeries(ASeries).UsePalette:=False;
    4: ASeries.Marks.Visible:=True;
    5: ASeries.Brush.Style:=bsClear;
    6: TTowerSeries(ASeries).TowerStyle:=tsRectangle;
    7: TTowerSeries(ASeries).TowerStyle:=tsCover;
    8: TTowerSeries(ASeries).TowerStyle:=tsCylinder;
    9: TTowerSeries(ASeries).TowerStyle:=tsArrow;
   10: TTowerSeries(ASeries).TowerStyle:=tsCone;
   11: TTowerSeries(ASeries).TowerStyle:=tsPyramid;
  else inherited;
  end;
end;

Function TTowerSeries.CalcCell(var AIndex,ATop,ABottom,Z0,Z1:Integer):TRect;
var tmpValue : TChartValue;
begin
  tmpValue:=XValues.Value[AIndex];
  result.Left:=CalcXPosValue(tmpValue-IOffW);
  result.Right:=CalcXPosValue(tmpValue+IOffW);

  ATop:=CalcYPos(AIndex);
  result.Top:=ATop;

  if UseOrigin then
     ABottom:=CalcYPosValue(Origin)
  else
     ABottom:=CalcYPosValue(YValues.MinValue);

  result.Bottom:=ABottom;

  if result.Top>result.Bottom then
     SwapInteger(result.Top,result.Bottom);

  tmpValue:=ZValues.Value[AIndex];
  z0:=ParentChart.DepthAxis.CalcYPosValue(tmpValue-IOffD);
  z1:=ParentChart.DepthAxis.CalcYPosValue(tmpValue+IOffD);
end;

procedure TTowerSeries.DrawAllValues;
var tmpBlend : TTeeBlend;
    tmpChangeBrush : Boolean;

  Procedure DrawCell(x,z:Integer);
  var R : TRect;
      tmpR1,
      tmpR2,
      tmpR3 : TRect;
      tmp : Integer;
      z0  : Integer;
      z1  : Integer;
      tmpBottom: Integer;
      tmpTop   : Integer;
      tmpColor : TColor;
      tmpMidX  : Integer;
      tmpFour  : TFourPoints;
      Old      : Integer;
  begin
    tmp:=GridIndex[x,z];
    if tmp<>-1 then
    begin
      tmpColor:=ValueColor[tmp];

      if tmpColor<>clNone then
      begin
        if tmpChangeBrush then
           ParentChart.Canvas.AssignBrush(Self.Brush,tmpColor);

        R:=CalcCell(tmp,tmpTop,tmpBottom,z0,z1);

        if Transparency>0 then
        begin
          if TowerStyle=tsCover then
          begin
            tmpFour[0]:=ParentChart.Canvas.Calculate3DPosition(R.Left,tmpTop,z0);
            tmpFour[1]:=ParentChart.Canvas.Calculate3DPosition(R.Right,tmpTop,z0);
            tmpFour[2]:=ParentChart.Canvas.Calculate3DPosition(R.Right,tmpTop,z1);
            tmpFour[3]:=ParentChart.Canvas.Calculate3DPosition(R.Left,tmpTop,z1);
            tmpR3:=RectFromPolygon(tmpFour,4);
          end
          else
          begin
            tmpR1:=ParentChart.Canvas.RectFromRectZ(R,Z0);
            tmpR2:=ParentChart.Canvas.RectFromRectZ(R,Z1);
            UnionRect(tmpR3,tmpR1,tmpR2);
          end;

          if not ParentChart.Canvas.SupportsFullRotation then
             tmpBlend.SetRectangle(tmpR3);
        end;

        with R,ParentChart.Canvas do
        case TowerStyle of
          tsCube     : Cube(R,z0,z1,Dark3D);
          tsRectangle: RectangleWithZ(R,(z0+z1) div 2);
          tsCover    : RectangleY(Left,tmpTop,Right,z0,z1);
          tsCylinder : Cylinder(True,Left,Top,Right,Bottom,z0,z1,Dark3D);
          tsArrow    : begin
                         tmpMidX:=(Left+Right) div 2;
                         Arrow(True, TeePoint(tmpMidX,tmpBottom),
                                     TeePoint(tmpMidX,tmpTop),
                                     Right-Left,(Right-Left) div 2,(z0+z1) div 2);
                       end;
          tsCone     : Cone(True,Left,tmpTop,Right,tmpBottom,z0,z1,Dark3D,0);
          tsPyramid  : Pyramid(True,Left,tmpTop,Right,tmpBottom,z0,z1,Dark3D);
          tsSlantCube:
              begin
               Old:=TeeNumCylinderSides;
               TeeNumCylinderSides:=4;
               Cylinder(True,Left,Top,Right,Bottom,z0,z1,Dark3D);
               TeeNumCylinderSides:=Old;
              end;
        end;

        if not ParentChart.Canvas.SupportsFullRotation then
           if Transparency>0 then
              tmpBlend.DoBlend(Transparency);
      end;
    end;
  end;

  Procedure DrawCells;
  var x : Integer;
      z : Integer;
  begin
    IOffW:=FPercWidth*0.005;
    IOffD:=FPercDepth*0.005;

    if Transparency>0 then
       tmpBlend:=ParentChart.Canvas.BeginBlending(TeeRect(0,0,0,0),Transparency);

    if BackFaced then
      if not DrawValuesForward then
        for x:=NumXValues downto 1 do
            for z:=1 to NumZValues do DrawCell(x,z)
      else
        for x:=1 to NumXValues do
            for z:=1 to NumZValues do DrawCell(x,z)
    else
      if not DrawValuesForward then
        for x:=NumXValues downto 1 do
            for z:=NumZValues downto 1 do DrawCell(x,z)
      else
        for x:=1 to NumXValues do
            for z:=NumZValues downto 1 do DrawCell(x,z);

    if Transparency>0 then
       if ParentChart.Canvas.SupportsFullRotation then
          ParentChart.Canvas.EndBlending(tmpBlend)
       else
          tmpBlend.Free;
  end;

begin
  tmpChangeBrush:=Brush.Style<>bsClear;

  with ParentChart.Canvas do
  begin
    AssignVisiblePen(Self.Pen);
    AssignBrush(Self.Brush,SeriesColor);
    DrawCells;
  end;
end;

procedure TTowerSeries.SetPercDepth(const Value: Integer);
begin
  SetIntegerProperty(FPercDepth,Value);
end;

procedure TTowerSeries.SetPercWidth(const Value: Integer);
begin
  SetIntegerProperty(FPercWidth,Value);
end;

procedure TTowerSeries.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TTowerSeries.SetOrigin(const Value: Double);
begin
  SetDoubleProperty(FOrigin,Value);
end;

procedure TTowerSeries.SetUseOrigin(Value: Boolean);
begin
  SetBooleanProperty(FUseOrigin,Value);
end;

procedure TTowerSeries.SetTowerStyle(const Value: TTowerStyle);
begin
  if FTowerStyle<>Value then
  begin
    FTowerStyle:=Value;
    Repaint;
  end;
end;

procedure TTowerSeries.SetDark3D(const Value: Boolean);
begin
  SetBooleanProperty(FDark3D,Value);
end;

procedure TTowerSeries.Assign(Source: TPersistent);  // 6.02
begin
  if Source is TTowerSeries then
  With TTowerSeries(Source) do
  begin
    Self.FDark3D       :=FDark3D;
    Self.FOrigin       :=FOrigin;
    Self.FPercDepth    :=FPercDepth;
    Self.FPercWidth    :=FPercWidth;
    Self.FTowerStyle   :=FTowerStyle;
    Self.FTransparency :=FTransparency;
    Self.FUseOrigin    :=FUseOrigin;
  end;
  inherited;
end;

{ TMySurface }
Constructor TIsoSurfaceSeries.Create(AOwner: TComponent);
begin
  inherited;
  FBandPen:=CreateChartPen;
  FSides:=TSurfaceSides.Create(Self);

  UseColorRange:=False;
  UsePalette:=True;

  if not (csLoading in ComponentState) then
     Pen.Hide;
end;

Destructor TIsoSurfaceSeries.Destroy;
begin
  FSides.Free;
  FBandPen.Free;
  inherited;
end;

Procedure TIsoSurfaceSeries.DrawAllValues;
var OldFast : Boolean;
begin
  OldFast:=ParentChart.Canvas.SupportsFullRotation and FastBrush;
  if OldFast then
     FastBrush:=False;

  xv:=XValues.Value;
  zv:=ZValues.Value;
  v:=MandatoryValueList.Value;

  HasImage:=Assigned(Brush.Image.Graphic);

  // Set palette colors calculated from "range" colors
  // (StartColor, MidColor and EndColor)
  if UseColorRange then
     GeneratePalette;

  ITransp:=(Transparency>0) and
           (not ParentChart.Canvas.SupportsFullRotation);

  PaletteLength:=Length(Palette);

  ICalcYPos:=CalcYPosValue(YPosition);

  inherited;

  IPoints2D:=nil;

  if OldFast then
     FastBrush:=True;
end;

procedure TIsoSurfaceSeries.DrawCell(x, z: Integer);
var tmpValue : TChartValue;

  {.$DEFINE TEEUSEFLOAT}  // Slower, but more precise?

  procedure CalcXZ(const A,B:Integer; var P:TPoint3D);
  var tmp  : TChartValue;
      {$IFDEF TEEUSEFLOAT}
      tmpX : TChartValue;
      tmpZ : TChartValue;
      {$ENDIF}
  begin
    {$IFDEF TEEUSEFLOAT}
    tmpX:=xv[A];
    tmpZ:=zv[A];

    tmp:=v[B]-v[A];
    if tmp=0 then tmp:=1;

    tmp:=(tmpValue-v[A])/tmp;

    if tmpX<>xv[B] then
       tmpX:=tmpX-(tmpX-xv[B])*tmp;

    if tmpZ<>zv[B] then
       tmpZ:=tmpZ-(tmpZ-zv[B])*tmp;

    P.x:=CalcXPosValue(tmpX);

    if ParentChart.View3D then
       P.z:=ParentChart.DepthAxis.CalcPosValue(tmpZ)
    else
       P.y:=GetVertAxis.CalcYPosValue(tmpZ);

    {$ELSE}

    P.x:=CalcXPos(A);

    if ParentChart.View3D then
       P.z:=CalcZPos(A)
    else
       P.y:=GetVertAxis.CalcYPosValue(ZValues.Value[A]);

    tmp:=v[B]-v[A];
    if tmp=0 then tmp:=1;

    tmp:=(tmpValue-v[A])/tmp;

    if xv[A]<>xv[B] then
       Dec(P.x,Round((P.x-CalcXPos(B))*tmp));

    if zv[A]<>zv[B] then
       if ParentChart.View3D then
          Dec(P.z,Round((P.z-CalcZPos(B))*tmp))
       else
          Dec(P.y,Round((P.y-GetVertAxis.CalcYPosValue(ZValues.Value[B]))*tmp));

    {$ENDIF}
  end;

  procedure CalcLR(const Index:Integer; var L,R:Integer);
  begin
    if Index=ValueIndex0 then
    begin
      l:=ValueIndex3;
      r:=ValueIndex1;
    end
    else
    if Index=ValueIndex1 then
    begin
      l:=ValueIndex0;
      r:=ValueIndex2;
    end
    else
    if Index=ValueIndex2 then
    begin
      l:=ValueIndex1;
      r:=ValueIndex3;
    end
    else
    begin
      l:=ValueIndex2;
      r:=ValueIndex0;
    end;
  end;

var
  tmpMin : Integer;
  tmpMax : Integer;

  function CalcFirstLevel:Integer;
  var i: Array[0..3] of Integer;
      t: Integer;
      tmpM,
      tmpV : TChartValue;
  begin
    // Search first palette level
    i[0]:=ValueIndex0;
    i[1]:=ValueIndex1;
    i[2]:=ValueIndex2;
    i[3]:=ValueIndex3;

    tmpMin:=i[0];
    tmpV:=v[tmpMin];
    tmpM:=tmpV;
    tmpMax:=tmpMin;

    for t:=1 to 3 do
    begin
      if v[i[t]]<tmpV then
      begin
        tmpV:=v[i[t]];
        tmpMin:=i[t];
      end
      else
      if v[i[t]]>tmpM then
      begin
        tmpM:=v[i[t]];
        tmpMax:=i[t];
      end;
    end;

    result:=-1;

    for t:=0 to PaletteLength-1 do
    With Palette[t] do
    if UpToValue>tmpV then
    begin
      result:=t;
      break;
    end;
  end;

  procedure PrepareBrush(const AColor:TColor);
  begin
    with ParentChart.Canvas.Brush do
    if Style=bsClear then
    begin
      Style:=Self.Brush.Style;

      {$IFNDEF CLX}
      PrepareFastBrush;
      {$ENDIF}
    end;

    SetBrushColor(AColor);
  end;

  procedure LoopLevels(Level:Integer);

    function CalcOposite(const Index:Integer):Integer;
    begin
      if Index=ValueIndex3 then
         result:=ValueIndex1
      else
      if Index=ValueIndex1 then
         result:=ValueIndex3
      else
      if Index=ValueIndex0 then
         result:=ValueIndex2
      else
         result:=ValueIndex0;
    end;

    function CalcPoint(const Index:Integer):TPoint3D;
    begin
      result.x:=CalcXPos(Index);

      if ParentChart.View3D then
      begin
        if UseYPosition then
           result.y:=ICalcYPos
         else
           result.y:=CalcYPos(Index);

        result.z:=CalcZPos(Index);
      end
      else
        result.y:=GetVertAxis.CalcYPosValue(ZValues.Value[Index]);
    end;

    Procedure FillPolygon(const Points: Array of TPoint3D);
    var tmp : Integer;
        t   : Integer;
    begin
      if ParentChart.View3D then
         ParentChart.Canvas.Polygon3D(Points)
      else
      begin
        tmp:=Length(Points);

        SetLength(IPoints2D,tmp);

        for t:=0 to tmp-1 do
        begin
          IPoints2D[t].X:=Points[t].x;
          IPoints2D[t].Y:=Points[t].y;
        end;

        ParentChart.Canvas.Polygon(IPoints2D);
      end;
    end;

  var PL,PR    : TPoint3D;
      POp,
      Old0,
      Old1     : TPoint3D;
      New0,
      New1     : TPoint3D;
      New02,
      New12    : TPoint3D;
      Flag0,
      FlagOp,
      Flag2,
      FlagL,
      FlagR    : Boolean;
      tmpOp    : Integer;
      tmpL,
      tmpR     : Integer;
      l,r      : Integer;
      PP       : TFourPoints;
  begin
    tmpOp:=CalcOposite(tmpMin);

    Old0:=CalcPoint(tmpMin);
    Old1:=Old0;

    FlagL:=False;
    FlagR:=False;
    Flag0:=False;
    FlagOp:=False;
    Flag2:=False;

    tmpL:=tmpMin;
    tmpR:=tmpL;

    CalcLR(tmpMin,L,R);

    PL:=CalcPoint(L);
    PR:=CalcPoint(R);
    POp:=CalcPoint(tmpOp);

    while Level<PaletteLength do
    begin
      tmpValue:=Palette[Level].UpToValue;

      if Palette[Level].Color=clNone then
         ParentChart.Canvas.Brush.Style:=bsClear
      else
      begin
        if HasImage then
        begin
          // ParentChart.Canvas.BackColor:=Palette[tmpPal].Color;
          ParentChart.Canvas.Brush.Bitmap:=Self.Brush.Image.Bitmap;
        end
        else
          PrepareBrush(Palette[Level].Color);
      end;

      // Full cell is inside a palette level. Draw it and stop.
      if (not Flag0) and (tmpValue>=v[tmpMax]) then
      begin
        with ParentChart.Canvas do
        begin
          if ParentChart.View3D then
          begin
            PP[0]:=Calculate3DPosition(Old0.x,Old0.y,Old0.z);
            PP[1]:=Calculate3DPosition(PL.x,PL.y,PL.z);
            PP[2]:=Calculate3DPosition(POp.x,POp.y,POp.z);
            PP[3]:=Calculate3DPosition(PR.x,PR.y,PR.z);

            ParentChart.Canvas.Polygon(PP);
          end
          else
            FillPolygon([Old0,PL,POp,PR]);
        end;

        Break;
      end;

      (*
      if tmpMax<>tmpOp then
      begin
        tmpMax:=tmpMax; // <-- pending bug to fix and remove this line

        if (tmpMax=L) and (v[tmpOp]<v[R]) then
        if (tmpMax=R) and (v[tmpOp]<v[L]) then
           Exit;
      end;
      *)

      if ParentChart.View3D then
      begin
        if UseYPosition then
           New0.y:=ICalcYPos
        else
           New0.y:=CalcYPosValue(Math.Min(v[tmpMax],tmpValue));

        New1.y:=New0.y;
      end;

      if (not FlagL) and (tmpValue>=v[L]) then
      begin
        FlagL:=True;
        tmpL:=tmpOp;

        if FlagR and (tmpValue>=v[tmpR]) then
           FillPolygon([Old0,Old1,CalcPoint(tmpR),PL])
        else
        if (not FlagR) and (tmpValue>=v[R]) then
        begin
          FlagR:=True;
          tmpR:=tmpOp;

          if tmpValue>=v[tmpOp] then
          begin
            FlagOp:=True;
            FillPolygon([Old0,Old1,PR,POp,PL]);
          end
          else
          begin
            CalcXZ(tmpL,L,New0);
            CalcXZ(tmpR,R,New1);
            FillPolygon([Old1,Old0,PL,New0,New1,PR]);
          end;
        end
        else
        if tmpValue>=v[tmpOp] then
        begin
          if FlagOp then
          begin
            FillPolygon([Old0,PL,New02]);
          end
          else
          begin
            FlagOp:=True;
            tmpL:=tmpOp;

            CalcXZ(tmpL,R,New0);
            CalcXZ(tmpR,R,New1);
            FillPolygon([Old0,PL,POp,New0,New1]);
          end;
        end
        else
        begin
          CalcXZ(L,tmpL,New0);
          CalcXZ(tmpR,R,New1);
          FillPolygon([PL,Old0,Old1,New1,New0]);
        end;
      end
      else
      if (not FlagR) and (tmpValue>=v[R]) then
      begin
        FlagR:=True;

        if FlagOp then
           if Flag2 then
           begin
             // Limitation here, not yet fully covers all situations
             Old0:=New12;
             FillPolygon([Old1,PR,New12]);
           end
           else
              FillPolygon([Old0,Old1,PR])
        else
        begin
          tmpR:=tmpOp;

          if FlagL and (tmpValue>=v[tmpL]) then
             FillPolygon([Old0,Old1,PR,CalcPoint(tmpL)])
          else
          if (not FlagL) and (tmpValue>=v[L]) then
          begin
            FlagL:=True;
            tmpL:=tmpOp;

            CalcXZ(tmpL,L,New0);
            CalcXZ(tmpR,R,New1);
            FillPolygon([Old0,Old1,PL,New0,New1,PR]);
          end
          else
          if tmpValue>=v[tmpOp] then
          begin
            FlagOp:=True;

            CalcXZ(L,tmpL,New0);
            CalcXZ(tmpR,L,New1);
            FillPolygon([Old0,Old1,PR,POp,New1,New0]);
          end
          else
          begin
            CalcXZ(L,tmpL,New0);
            CalcXZ(tmpR,R,New1);
            FillPolygon([Old0,Old1,PR,New1,New0]);
          end;
        end;
      end
      else
      if tmpValue>=v[tmpOp] then
      begin
        FlagOp:=True;

        if FlagL and FlagR then
           FillPolygon([Old0,Old1,POp])
        else
        if FlagR then
        begin
          tmpR:=tmpOp;

          CalcXZ(L,tmpL,New0);
          CalcXZ(L,tmpR,New1);
          FillPolygon([Old0,Old1,POp,New1,New0]);
        end
        else
        if FlagL then
        begin
          tmpL:=tmpOp;

          CalcXZ(R,tmpL,New0);
          CalcXZ(R,tmpR,New1);
          FillPolygon([Old0,Old1,New1,New0,POp]);
        end
        else
        begin
          // Special case
          Flag2:=True;

          CalcXZ(L,tmpL,New0);
          CalcXZ(R,tmpR,New1);

          New02.y:=New0.y;
          New12.y:=New1.y;

          CalcXZ(L,tmpOp,New02);
          CalcXZ(R,tmpOp,New12);

          FillPolygon([Old0,New0,New02,POp,New12,New1]);

          Old1:=New02;
        end;
      end
      else
      begin
        CalcXZ(L,tmpL,New0);
        CalcXZ(tmpR,R,New1);
        FillPolygon([Old0,Old1,New1,New0]);
      end;

      if BandPen.Visible then
      with ParentChart.Canvas do
      begin
        AssignVisiblePen(Self.BandPen);
        MoveTo3D(Old0);
        LineTo3D(Old1);

        Pen.Style:=psClear;
      end;

      if tmpValue>=v[tmpMax] then
         break;

      Old0:=New0;
      Old1:=New1;

      Flag0:=True;

      Inc(Level);
    end;
  end;

var OldStyle : TPenStyle;
    IPoints  : TFourPoints;
    tmpColor : TColor;
    tmpPal   : Integer;
    tmpCall  : Boolean;
    tmpR     : TRect;
begin
// if (x<>17)  or (z<>20)  then  // (debug)
// exit;

  if FourGridIndex(X,Z) then
  begin
    tmpColor:=InternalColor(ValueIndex0);

    if tmpColor=clTeeColor then
    begin
      tmpCall:=False;

      tmpPal:=CalcFirstLevel;

      // If first is found, draw levels !
      if tmpPal<>-1 then
      begin
        with ParentChart.Canvas.Pen do
        begin
          OldStyle:=Style;

          if Style<>psClear then
          begin
            tmpCall:=True;
            Style:=psClear;
          end;
        end;

        if tmpCall then
        begin
          // Important speed optimization:
          with ParentChart.Canvas.Brush do
          if Style<>Self.Brush.Style then
             Style:=Self.Brush.Style;

          {$IFNDEF CLX}
          PrepareFastBrush;
          {$ENDIF}
        end;

        if ITransp then
        begin
          if ParentChart.View3D then
          begin
            if UseYPosition then
            begin
              Points[0].Y:=ICalcYPos;
              Points[1].Y:=ICalcYPos;
              Points[2].Y:=ICalcYPos;
              Points[3].Y:=ICalcYPos;
            end;

            PointsTo2D(CalcZPos(ValueIndex0),CalcZPos(ValueIndex2),IPoints);

            IBlender.SetRectangle(RectFromPolygon(IPoints,4));
          end
          else
          begin
            tmpR.Left:=CalcXPos(ValueIndex0);
            tmpR.Top:=GetVertAxis.CalcYPosValue(ZValues.Value[ValueIndex0]);
            tmpR.Right:=CalcXPos(ValueIndex2);
            tmpR.Bottom:=GetVertAxis.CalcYPosValue(ZValues.Value[ValueIndex2]);

            IBlender.SetRectangle(tmpR);
          end;
        end;

        LoopLevels(tmpPal);

        if ITransp then
           IBlender.DoBlend(Transparency);

        // Restore canvas
        if tmpCall then
        with ParentChart.Canvas do
        begin
          Brush.Style:=bsClear;

          if Pen.Style<>OldStyle then
             AssignVisiblePen(Self.Pen);
        end;
      end;
    end
    else
    begin
      PrepareBrush(tmpColor);
      tmpCall:=True;
    end;

    if tmpCall then  // Important speed opt.
       inherited;
  end;
end;

Procedure TIsoSurfaceSeries.PrepareForGallery(IsEnabled:Boolean);
begin
  inherited;
  ParentChart.Axes.FastCalc:=True;
  FastBrush:=True;
  BandPen.Hide;
end;

Procedure TIsoSurfaceSeries.DrawSidePortion(var P:TFourPoints; Z0,Z1:Integer);
var t   : Integer;
    IsZ : Boolean;
    P3D : Array[0..3] of TPoint3D;

  procedure Fill(Outline:Boolean);
  var Old : TPenStyle;
  begin
    if Sides.Levels then
    with ParentChart.Canvas.Brush do
         if Style<>bsClear then
         begin
           Color:=Palette[t].Color;

           if Color=clNone then
              Exit;
         end;

    if not Outline then
    begin
      Old:=ParentChart.Canvas.Pen.Style;
      ParentChart.Canvas.Pen.Style:=psClear;
    end
    else Old:=psSolid;

    if IsZ then
    begin
      P3D[0].y:=P[0].y;
      P3D[1].y:=P[1].y;
      P3D[2].y:=P[2].y;
      P3D[3].y:=P[3].y;

      ParentChart.Canvas.Polygon3D(P3D);
    end
    else
      ParentChart.Canvas.PlaneFour3D(P,Z0,Z1);

    if not Outline then
       ParentChart.Canvas.Pen.Style:=Old;
  end;

  procedure DrawLine;
  begin
    if Sides.Pen.Visible then
    with ParentChart.Canvas do
    begin
      AssignVisiblePen(Sides.Pen);
      MoveTo3D(P[1].X,P[1].Y-1,Z0);
      LineTo3D(P[2].X,P[2].Y-1,Z1);
      Pen.Style:=psClear;
    end;
  end;

var tmp     : Integer;
    tmp0,
    tmp3,
    tmpMin,
    tmpMin2,
    tmpPrev : Integer;
    tmpDif  : Integer;
    Dif     : Double;
begin
//  if z0=z1 then exit;

  tmp0:=P[0].Y;
  tmp3:=P[3].Y;

  IsZ:=z0<>z1;

  if tmp3=tmp0 then
     Dif:=0
  else
  if IsZ then
  begin
    Dif:=Abs((z1-z0)/(tmp3-tmp0));

    P3D[0].x:=P[0].x;
    P3D[1].x:=P[1].x;
    P3D[2].x:=P[2].x;
    P3D[3].x:=P[3].x;

    P3D[0].z:=z0;
    P3D[1].z:=z0;
    P3D[2].z:=z1;
    P3D[3].z:=z1;
  end
  else
    Dif:=Abs((P[0].X-P[3].X)/(tmp3-tmp0));

  tmpMin:=tmp0;
  tmpMin2:=tmp3;

  if tmp0>tmp3 then
     SwapInteger(tmpMin,tmpMin2);

  tmpPrev:=P[1].Y;

  ParentChart.Canvas.AssignBrush(Sides.Brush);

  for t:=0 to PaletteLength-1 do
  begin
    tmp:=GetVertAxis.CalcYPosValue(Palette[t].UpToValue);

    if tmp<tmpPrev then
    begin
      P[1].Y:=tmpPrev;
      P[2].Y:=tmpPrev;

      if tmp<tmpMin2 then
      begin
        if tmp<tmpMin then
           tmp:=tmpMin;

        if tmpPrev>tmpMin2 then
        begin
          P[0].Y:=tmpMin2;
          P[3].Y:=tmpMin2;

          Fill(False);
          DrawLine;

          P[1].Y:=tmpMin2;
          P[2].Y:=tmpMin2;
        end;

        P[0].Y:=tmp;
        P[3].Y:=tmp;

        tmpDif:=Round(Dif*(tmp-tmpMin));

        if tmp3=tmpMin2 then
        begin
          if IsZ then
             P3D[3].z:=P3D[0].z-tmpDif
          else
             P[3].X:=P[0].X-tmpDif;

          Fill(False);

          if IsZ then
             P3D[2].z:=P3D[3].z
          else
             P[2].X:=P[3].X;
        end
        else
        begin
          if IsZ then
             P3D[0].z:=P3D[3].z+tmpDif
          else
             P[0].X:=P[3].X+tmpDif;

          Fill(False);

          if IsZ then
             P3D[1].z:=P3D[0].z
          else
             P[1].X:=P[0].X;
        end;
      end
      else
      begin
        P[0].Y:=tmp;
        P[3].Y:=tmp;
        Fill(True);
      end;

      if tmp<=tmpMin then
         Break;

      tmpPrev:=tmp;

      DrawLine;
    end;
  end;
end;

function TIsoSurfaceSeries.ShouldDrawSides:Boolean;
begin
  result:=(inherited ShouldDrawSides) or Sides.Pen.Visible;
end;

function TIsoSurfaceSeries.ShouldDrawFast:Boolean;
begin
  result:=False;
end;

procedure TIsoSurfaceSeries.SetBandPen(const Value: TChartPen);
begin
  FBandPen.Assign(Value);
end;

procedure TIsoSurfaceSeries.SetSides(const Value: TSurfaceSides);
begin
  FSides.Assign(Value);
end;

procedure TIsoSurfaceSeries.SetUseY(const Value: Boolean);
begin
  SetBooleanProperty(FUseY,Value);
end;

procedure TIsoSurfaceSeries.SetYPosition(const Value: TChartValue);
begin
  if FYPosition<>Value then
  begin
    FYPosition:=Value;
    Repaint;
  end;
end;

class function TIsoSurfaceSeries.GetEditorClass: String;
begin
  result:='TIsoSurfaceEditor';
end;

procedure TIsoSurfaceSeries.Assign(Source: TPersistent);
begin
  if Source is TIsoSurfaceSeries then
  with TIsoSurfaceSeries(Source) do
  begin
    Self.BandPen:=BandPen;
    Self.Sides:=Sides;
    Self.FUseY:=FUseY;
    Self.FYPosition:=FYPosition;
  end;

  inherited;
end;

{ TSurfaceSides }

Constructor TSurfaceSides.Create(Series:TSurfaceSeries);
begin
  inherited Create;
  ISeries:=Series;
  FLevels:=True;
  FPen:=TChartHiddenPen.Create(CanvasChanged);
end;

Destructor TSurfaceSides.Destroy;
begin
  FPen.Free;
  inherited;
end;

procedure TSurfaceSides.Assign(Source: TPersistent);
begin
  if Source is TSurfaceSides then
  with TSurfaceSides(Source) do
  begin
    // Self.Brush:=Brush; already done at Surface series
    Self.FLevels:=FLevels;
    Self.Pen:=Pen;
  end
  else
    inherited;
end;

procedure TSurfaceSides.CanvasChanged(Sender: TObject);
begin
  ISeries.Repaint;
end;

function TSurfaceSides.GetBrush:TChartBrush;
begin
  result:=ISeries.SideBrush;
end;

procedure TSurfaceSides.SetBrush(const Value: TChartBrush);
begin
  ISeries.SideBrush:=Value;
end;

procedure TSurfaceSides.SetLevels(const Value: Boolean);
begin
  if FLevels<>Value then
  begin
    FLevels:=Value;
    ISeries.Repaint;
  end;
end;

procedure TSurfaceSides.SetPen(const Value: TChartHiddenPen);
begin
  FPen.Assign(Value);
end;

initialization
  RegisterTeeSeries( TSurfaceSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GallerySurface,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TContourSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryContour,
                                     {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TWaterFallSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryWaterFall,
                                       {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TColorGridSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryColorGrid,
                                       {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TVector3DSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryVector3D,
                                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TTowerSeries,    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryTower,
                                      {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
  RegisterTeeSeries( TIsoSurfaceSeries,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_IsoSurfaceSeries,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_Gallery3D,1);
finalization
  UnRegisterTeeSeries([TSurfaceSeries,TContourSeries,TWaterFallSeries,
                       TColorGridSeries,TVector3DSeries,TTowerSeries,
                       TIsoSurfaceSeries]);
end.

