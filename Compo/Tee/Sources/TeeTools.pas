{**********************************************}
{   TeeChart Tools                             }
{   Copyright (c) 1999-2009 by David Berneda   }
{**********************************************}
unit TeeTools;
{$I TeeDefs.inc}

interface

// This unit defines and implements several "Chart Tools".
// Tools appear at the Chart editor "Tools" tab and can be added
// both at design-time and run-time.

// The purpose of a "tool" is to perform some generic functionality
// outside the Chart or Series code. Chart Tools are notified of
// chart drawing (repaints) and chart mouse events (move, up, down).

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QExtCtrls, QForms,
     {$ELSE}
     Graphics, Controls, ExtCtrls, Forms,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeCanvas, TeeProcs, TeEngine, Chart, TeeFilters, TeeExport, TeeAntiAlias
     {$IFNDEF BCB}
     , TeeGDIPlus
     {$ENDIF}
     ;

// Default number of pixels to consider a line is "clicked"
// (ie: when the mouse is more or less 3 pixels from a line)
Const
  // Used at TColorLineTool, TAxisArrowTool and TCursorTool
  TeeClickTolerance = 3;

type
  // Style of cursor tool
  TCursorToolStyle=( cssHorizontal,
                     cssVertical,
                     cssBoth,
                     cssScope,     // 8.0
                     cssScopeOnly  // 8.01
                     );

  TCursorTool=class;

  TCursorClicked=(ccNone,ccHorizontal,ccVertical,ccBoth);

  TCursorToolChangeEvent=procedure( Sender:TCursorTool;
                                    x,y:Integer;
                                    Const XValue,YValue:Double;
                                    Series:TChartSeries;
                                    ValueIndex:Integer) of object;

  TCursorToolGetAxisRect=procedure(Sender:TCursorTool; var Rect:TRect) of object;

  TSnapStyle=(ssDefault, ssHorizontal, ssVertical);

  TScopeCursorStyle=(scsRectangle, scsCircle, scsDiamond, scsEmpty, scsCamera);

  // Cursor tool, use it to draw a draggable line (cursor)
  TCursorTool=class(TTeeCustomToolSeries)
  private
    FClick         : Integer;
    FFollowMouse   : Boolean;
    FHorizSize     : Integer;

    FOnChange      : TCursorToolChangeEvent;
    FOnGetAxisRect : TCursorToolGetAxisRect;
    FOnSnapChange  : TCursorToolChangeEvent;

    FScopeSize     : Integer;
    FScopeStyle    : TScopeCursorStyle;
    FSnap          : Boolean;
    FSnapStyle     : TSnapStyle;
    FStyle         : TCursorToolStyle;
    FUseChartRect  : Boolean;
    FUseSeriesZ    : Boolean;  // 7.0
    FVertSize      : Integer;

    IDragging      : TCursorClicked;
    IOldSnap       : Integer;

    Procedure CalcValuePositions(X,Y:Integer);
    procedure DoChange;
    Function GetAxisRect:TRect;
    Function InMouseRectangle(x,y:Integer; UseSize:Boolean=False):Boolean;
    function MouseRectangle(X,Y:Integer; UseSize:Boolean):TRect;
    Procedure SetHorizSize(const Value:Integer);
    Procedure SetScopeSize(const Value:Integer);
    Procedure SetScopeStyle(const Value:TScopeCursorStyle);
    Procedure SetStyle(Value:TCursorToolStyle);
    procedure SetUseChartRect(const Value: Boolean);
    procedure SetUseSeriesZ(const Value: Boolean);
    Procedure SetVertSize(const Value:Integer);
    procedure SetXValue(const Value: Double);
    procedure SetYValue(const Value: Double);
    Function Z:Integer;
  protected
    IXValue     : Double;  { 5.01 }
    IYValue     : Double;
    IPoint      : TPoint;

    Procedure CalcScreenPositions; { 5.01 }
    Procedure Changed(SnapPoint:Integer); virtual;
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
    procedure SetSeries(const Value: TChartSeries); override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;

    procedure Assign(Source:TPersistent); override;

    Function Clicked(x,y:Integer):TCursorClicked;
    class Function Description:String; override;
    class Function LongDescription:String; override; // 8.0
    Function NearestPoint(AStyle:TCursorToolStyle; out Difference:Double):Integer;
    Function SnapToPoint:Integer;
    procedure RedrawCursor;

    property UseChartRect:Boolean read FUseChartRect write SetUseChartRect default False;
    property XValue:Double read IXValue write SetXValue;
    property YValue:Double read IYValue write SetYValue;
    property OnGetAxisRect:TCursorToolGetAxisRect read FOnGetAxisRect write FOnGetAxisRect;
  published
    property Active;
    property ClickTolerance:Integer read FClick write FClick default TeeClickTolerance; // 7.05
    property FollowMouse:Boolean read FFollowMouse write FFollowMouse default False;
    property HorizSize:Integer read FHorizSize write SetHorizSize default 0; // 8.0
    property Pen;
    property Series;
    property ScopeSize:Integer read FScopeSize write SetScopeSize default 4; // 8.0
    property ScopeStyle:TScopeCursorStyle read FScopeStyle write SetScopeStyle default scsRectangle; // 8.0
    property Snap:Boolean read FSnap write FSnap default False;
    property SnapStyle:TSnapStyle read FSnapStyle write FSnapStyle default ssDefault;
    property Style:TCursorToolStyle read FStyle write SetStyle default cssBoth;
    property UseSeriesZ:Boolean read FUseSeriesZ write SetUseSeriesZ default False;
    property VertSize:Integer read FVertSize write SetVertSize default 0; // 8.0

    { events }
    property OnChange:TCursorToolChangeEvent read FOnChange write FOnChange;
    property OnSnapChange:TCursorToolChangeEvent read FOnSnapChange write FOnSnapChange;  // 7.0
  end;

  TDragMarksTool=class;

  TDragMarkEvent=procedure(Sender:TDragMarksTool; Index:Integer;
                           Button:TMouseButton; Shift: TShiftState;
                           X,Y: Integer) of object;

  // Drag Marks tool, use it to allow the end-user to drag series Marks
  TDragMarksTool=class(TTeeCustomToolSeries)
  private
    FOnDragged  : TDragMarkEvent;
    FOnDragging : TDragMarkEvent;

    IOldX   : Integer;
    IOldY   : Integer;
    Index   : Integer;
    ISeries : TChartSeries;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Series;

    property OnDraggedMark:TDragMarkEvent read FOnDragged write FOnDragged; // 8.0
    property OnDraggingMark:TDragMarkEvent read FOnDragging write FOnDragging; // 8.0
  end;

  TAxisArrowTool=class;

  TAxisArrowClickEvent=procedure(Sender:TAxisArrowTool; AtStart:Boolean) of object;

  TAxisArrowToolPosition=(aaStart,aaEnd,aaBoth);

  // Axis Arrow tool, use it to display small "arrows" at start and end
  // positions of an axis. These arrows can be clicked to scroll the axis.
  TAxisArrowTool=class(TTeeCustomToolAxis)
  private
    FHeadWidth     : Integer;
    FLength        : Integer;
    FPosition      : TAxisArrowToolPosition;
    FScrollPercent : Integer;
    FScrollInverted: Boolean;
    FSizePercent   : Integer;

    FOnClick       : TAxisArrowClickEvent;

    Function ClickedArrow(x,y:Integer):Integer;
    procedure SetHeadWidth(const Value: Integer);
    procedure SetLength(const Value: Integer);
    procedure SetPosition(const Value: TAxisArrowToolPosition);
    procedure SetSizePercent(const Value: Integer);
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner:TComponent); override;

    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Position:TAxisArrowToolPosition read FPosition write SetPosition default aaBoth;
    property Axis;
    property Brush;
    property HeadWidth:Integer read FHeadWidth write SetHeadWidth default 8;  // 7.05
    property Length:Integer read FLength write SetLength default 16;
    property Pen;
    property ScrollInverted:Boolean read FScrollInverted write FScrollInverted default False;
    property ScrollPercent:Integer read FScrollPercent write FScrollPercent default 10;
    property SizePercent:Integer read FSizePercent write SetSizePercent default 50;   // 7.05

    { events }
    property OnClick:TAxisArrowClickEvent read FOnClick write FOnClick;
  end;

  TAxisScrollTool=class(TTeeCustomToolAxis)
  private
    FScrollInverted : Boolean;

    OldX,
    OldY   : Integer;
    InAxis : TChartAxis;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class Function GetEditorClass:String; override;
  public
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Axis;
    property ScrollInverted:Boolean read FScrollInverted write FScrollInverted default False;
  end;

  TDrawLineHandle=(chNone,chStart,chEnd,chSeries);

  TDrawLineStyle=(dlLine,
                  dlHorizParallel,
                  dlVertParallel,
                  dlRectangle,
                  dlEllipse);

  TDrawLineTool=class;

  // Element of Lines collection in TDrawLineTool class
  TDrawLine=class(TCollectionItem)
  private
    FPen   : TChartPen;
    FStyle : TDrawLineStyle;

    Function GetParent:TDrawLineTool;
    function GetPen:TChartPen;
    function GetX0: Double;
    function GetX1: Double;
    function GetY0: Double;
    function GetY1: Double;
    function IsPenStored: Boolean;
    procedure SetPen(const Value: TChartPen);
    Procedure SetStyle(Value:TDrawLineStyle);
    procedure SetX0(const Value: Double);
    procedure SetX1(const Value: Double);
    procedure SetY0(const Value: Double);
    procedure SetY1(const Value: Double);
  public
    EndPos   : TFloatPoint;
    StartPos : TFloatPoint;

    {$IFNDEF CLR} // Delphi .Net does not allow constructors to call virtual constructors
    Constructor CreateXY(Collection:TCollection; Const X0,Y0,X1,Y1:Double);
    {$ENDIF}

    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override; { 5.01 }
    function Clicked(X,Y:Integer; AHandle:TDrawLineHandle; PixelsTolerance:Integer=0):Boolean; // 7.04
    Procedure DrawHandles;
    Function EndHandle:TRect;
    Function StartHandle:TRect;

    property Parent:TDrawLineTool read GetParent;
  published
    property Pen:TChartPen read GetPen write SetPen stored IsPenStored;  // 7.01
    property Style:TDrawLineStyle read FStyle write SetStyle default dlLine;
    property X0:Double read GetX0 write SetX0;
    property Y0:Double read GetY0 write SetY0;
    property X1:Double read GetX1 write SetX1;
    property Y1:Double read GetY1 write SetY1;
  end;

  // Collection of lines (TDrawLine) used in TDrawLineTool
  TDrawLines=class(TOwnedCollection)
  private
    Function Get(Index:Integer):TDrawLine;
    Procedure Put(Index:Integer; Const Value:TDrawLine);
  public
    function AddLine(const X0,Y0,X1,Y1:Double):TDrawLine;
    Function Last:TDrawLine;
    property Line[Index:Integer]:TDrawLine read Get write Put; default;
  end;

  TDrawLineSelecting=procedure( Sender:TDrawLineTool; Line:TDrawLine;
                                var AllowSelect:Boolean) of object;

  // Draw Line tool, use it to allow the end-user to draw, drag, select
  // and move lines.
  TDrawLineTool=class(TTeeCustomToolSeries)
  private
    FButton       : TMouseButton;
    FClick        : Integer;
    FEnableDraw   : Boolean;
    FEnableSelect : Boolean;
    FLines        : TDrawLines;
    FSelectNew    : Boolean;
    FStyle        : TDrawLineStyle;

    FOnDraggedLine: TNotifyEvent;
    FOnDragLine   : TNotifyEvent;
    FOnNewLine    : TNotifyEvent;
    FOnSelect     : TNotifyEvent;
    FOnSelecting  : TDrawLineSelecting;

    IDrawing  : Boolean;
    IMoved    : Boolean;
    IPoint    : TPoint;
    ISelected : TDrawLine;
    Procedure DrawLine(Const StartPos,EndPos:TPoint; AStyle:TDrawLineStyle);
    Function InternalClicked(X,Y:Integer; AHandle:TDrawLineHandle; ClickTolerance:Integer):TDrawLine; overload;
    Function InternalClicked(X,Y:Integer; AHandle:TDrawLineHandle):TDrawLine; overload;
    Procedure RedrawLine(ALine:TDrawLine);
    Procedure SetEnableSelect(Value:Boolean);
    Procedure SetLines(Const Value:TDrawLines);
    Procedure SetSelected(Value:TDrawLine);
  protected
    IHandle   : TDrawLineHandle;

    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               AButton:TMouseButton;
                               AShift: TShiftState; X, Y: Integer); override;
    Procedure ClipDrawingRegion; virtual;
    class function GetEditorClass: String; override;
  public
    FromPoint : TPoint;
    ToPoint   : TPoint;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;

    Function AxisPoint(Const P:TFloatPoint):TPoint;
    Function Clicked(X,Y:Integer):TDrawLine; overload;
    Function Clicked(X,Y:Integer; ClickTolerance:Integer):TDrawLine; overload; //
    Procedure DeleteSelected;
    Function ScreenPoint(const P:TPoint):TFloatPoint;

    class Function Description:String; override;
    class Function LongDescription:String; override;

    property Selected:TDrawLine read ISelected write SetSelected;
  published
    property Active;
    property Button:TMouseButton read FButton write FButton default mbLeft;
    property ClickTolerance:Integer read FClick write FClick default 0;
    property EnableDraw:Boolean read FEnableDraw write FEnableDraw default True;
    property EnableSelect:Boolean read FEnableSelect write SetEnableSelect default True;
    property Lines:TDrawLines read FLines write SetLines;
    property SelectNewLines:Boolean read FSelectNew write FSelectNew default True; // 7.05
    property Pen;
    property Series;
    property Style:TDrawLineStyle read FStyle write FStyle default dlLine; // 8.0

    { events }
    property OnDraggedLine:TNotifyEvent read FOnDraggedLine write FOnDraggedLine; { 5.01 }
    property OnDragLine:TNotifyEvent read FOnDragLine write FOnDragLine;
    property OnNewLine:TNotifyEvent read FOnNewLine write FOnNewLine;
    property OnSelect:TNotifyEvent read FOnSelect write FOnSelect;
    property OnSelecting:TDrawLineSelecting read FOnSelecting write FOnSelecting;  { 5.03 }
  end;

{ This variable can be used to set the default "DrawLine" class used by
  TDrawLineTool when creating new lines }
  TDrawLineClass=class of TDrawLine;

var
  TeeDrawLineClass:TDrawLineClass=TDrawLine; { 5.02 }

type
  TMarkToolMouseAction = (mtmMove, mtmClick);

  TMarksTipTool=class;

  TMarksTipGetText=procedure(Sender:TMarksTipTool; var Text:String) of object;

  // Marks tip tool, use it to display "tips" or "hints" when the end-user
  // moves or clicks the mouse over a series point.
  TMarksTipTool=class(TTeeCustomToolSeries)
  private
    FMouseAction : TMarkToolMouseAction;
    FOnCancel    : TNotifyEvent;
    FOnGetText   : TMarksTipGetText;
    FStyle       : TSeriesMarksStyle;

    procedure DoCancelHint;
    function GetHideDelay: Integer;
    function GetMouseDelay: Integer;
    procedure SetHideDelay(const Value: Integer);
    Procedure SetMouseAction(Value:TMarkToolMouseAction);
    procedure SetMouseDelay(const Value: Integer);
  protected
    Function Chart:TCustomChart;
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
    Procedure SetActive(Value:Boolean); override;
  public
    Constructor Create(AOwner:TComponent); override;

    procedure Assign(Source:TPersistent); override; // 7.07

    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;

    property HideDelay:Integer read GetHideDelay
                               write SetHideDelay default 2500; // 8.0

    property MouseAction:TMarkToolMouseAction read FMouseAction
                                               write SetMouseAction default mtmMove;
    property MouseDelay:Integer read GetMouseDelay
                                write SetMouseDelay default 500; { 5.02 }

    property Series;
    property Style:TSeriesMarksStyle read FStyle write FStyle default smsLabel;

    property OnCancelHint:TNotifyEvent read FOnCancel write FOnCancel; // 7.07
    property OnGetText:TMarksTipGetText read FOnGetText write FOnGetText;
  end;

  TNearestToolStyle=(hsNone,hsCircle,hsRectangle,hsDiamond,hsSeries);

  // Nearest tool, use it to display a graphical signal when the mouse is
  // moving near a series point.
  TNearestTool=class(TTeeCustomToolSeries)
  private
    FFullRepaint: Boolean;
    FLinePen    : TChartPen;
    FSize       : Integer;
    FStyle      : TNearestToolStyle;
    FOnChange   : TNotifyEvent;

    IMouse      : TPoint;

    Function GetDrawLine:Boolean;
    procedure PaintHint;
    procedure SetDrawLine(const Value: Boolean);
    procedure SetLinePen(const Value: TChartPen);
    procedure SetSize(const Value: Integer);
    procedure SetStyle(const Value: TNearestToolStyle);
    function ZAxisCalc(const Value:Double):Integer;
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
  public
    Point : Integer;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override; // 7.07

    class Function GetNearestPoint(Series:TChartSeries; X,Y:Integer):Integer; overload;
    class Function GetNearestPoint(Series:TChartSeries; X,Y:Integer; IncludeNulls:Boolean):Integer; overload;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Brush;
    property DrawLine:Boolean read GetDrawLine write SetDrawLine default True;
    property FullRepaint:Boolean read FFullRepaint write FFullRepaint default True;
    property LinePen:TChartPen read FLinePen write SetLinePen;  // 7.0
    property Pen;
    property Series;
    property Size:Integer read FSize write SetSize default 20;
    property Style:TNearestToolStyle read FStyle write SetStyle default hsCircle;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

  TColorLineTool=class;

  // Color band tool, use it to display a coloured rectangle (band)
  // at the specified axis and position.
  TColorBandTool=class(TTeeCustomToolAxis)
  private
    FColor        : TColor;
    FCursor       : TCursor;
    FDrawBehind   : Boolean;
    FDrawBehindAxes: Boolean;
    FEnd          : Double;
    FGradient     : TChartGradient;
    FOnClick      : TMouseEvent;
    FOnResized    : TNotifyEvent;
    FPicture      : TTeePicture;
    FStart        : Double;
    FTransparency : TTeeTransparency;

    FLineEnd      : TColorLineTool;
    FLineStart    : TColorLineTool;

    procedure PictureChanged(Sender:TObject);
    procedure DragLine(Sender:TColorLineTool);
    procedure EndDragLine(Sender:TColorLineTool);
    function GetEndLinePen: TChartPen;
    function GetPicture: TTeePicture;
    function GetResizeEnd: Boolean;
    function GetResizeStart: Boolean;
    function GetStartLinePen: TChartPen;
    Function NewColorLine:TColorLineTool;
    procedure PaintBand;
    Procedure SetColor(Value:TColor);
    procedure SetDrawBehind(const Value: Boolean);
    procedure SetDrawBehindAxes(const Value: Boolean);
    procedure SetEnd(const Value: Double);
    procedure SetEndLinePen(const Value: TChartPen);
    procedure SetGradient(const Value: TChartGradient);
    procedure SetLines;
    procedure SetPicture(const Value: TTeePicture);
    procedure SetResizeEnd(const Value: Boolean);
    procedure SetResizeStart(const Value: Boolean);
    procedure SetStart(const Value: Double);
    procedure SetStartLinePen(const Value: TChartPen);
    procedure SetTransparency(const Value: TTeeTransparency);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
    procedure Loaded; override;
    procedure SetAxis(const Value: TChartAxis); override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    Function ZPosition:Integer;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    Function BoundsRect:TRect;
    Function Clicked(X,Y:Integer):Boolean;
    class Function Description:String; override;
    class Function LongDescription:String; override;

    property StartLine:TColorLineTool read FLineStart;
    property EndLine:TColorLineTool read FLineEnd;
  published
    property Active;
    property Axis;
    property Brush;
    property Color:TColor read FColor write SetColor default clWhite;
    property Cursor:TCursor read FCursor write FCursor default crDefault;
    property DrawBehind:Boolean read FDrawBehind write SetDrawBehind default True;
    property DrawBehindAxes:Boolean read FDrawBehindAxes write SetDrawBehindAxes default False;
    property EndLinePen:TChartPen read GetEndLinePen write SetEndLinePen;
    property EndValue:Double read FEnd write SetEnd;
    property Gradient:TChartGradient read FGradient write SetGradient;
    property Pen;
    property Picture:TTeePicture read GetPicture write SetPicture;
    property ResizeEnd:Boolean read GetResizeEnd write SetResizeEnd default False;
    property ResizeStart:Boolean read GetResizeStart write SetResizeStart default False;
    property StartLinePen:TChartPen read GetStartLinePen write SetStartLinePen;
    property StartValue:Double read FStart write SetStart;
    property Transparency:TTeeTransparency read FTransparency
                                           write SetTransparency default 0;

    // Events
    property OnClick:TMouseEvent read FOnClick write FOnClick;
    property OnResized:TNotifyEvent read FOnResized write FOnResized;
  end;

  TGridBandBrush=class(TChartBrush)
  private
    FGradient  : TTeeGradient;
    FTransp    : TTeeTransparency;

    procedure SetGradient(const Value: TTeeGradient);
    procedure SetTransp(const Value: TTeeTransparency);
  public
    Constructor Create(OnChangeEvent:TNotifyEvent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
  published
    property BackColor default clNone;
    property Gradient:TTeeGradient read FGradient write SetGradient;
    property Transparency:TTeeTransparency read FTransp write SetTransp default 0;
  end;

  // TGridBandTool
  // Draws alternate color bands on axis grid space.
  TGridBandTool=class(TTeeCustomToolAxis)
  private
    FBand1 : TGridBandBrush;
    FBand2 : TGridBandBrush;

    Procedure DrawGrids(Sender:TChartAxis);
    Procedure SetBand1(Value:TGridBandBrush);
    Procedure SetBand2(Value:TGridBandBrush);
  protected
    StartPos : Integer;
    EndPos   : Integer;

    class function GetEditorClass: String; override;
    procedure SetAxis(const Value: TChartAxis); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    Function BandBackColor(ABand:TGridBandBrush):TColor;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Axis;
    property Band1:TGridBandBrush read FBand1 write SetBand1;
    property Band2:TGridBandBrush read FBand2 write SetBand2;
  end;

  TColorLineStyle=(clCustom,clMaximum,clCenter,clMinimum);

  TColorLineToolOnDrag=procedure(Sender:TColorLineTool) of object;

  // Color line tool, use it to display a vertical or horizontal line
  // at the specified axis and position.
  // The line can be optionally dragged at runtime.
  TColorLineTool=class(TTeeCustomToolAxis)
  private
    FAllowDrag     : Boolean;
    FDragRepaint   : Boolean;
    FDraw3D        : Boolean;
    FDrawBehind    : Boolean;
    FNoLimitDrag   : Boolean;
    FOnBeginDragLine: TColorLineToolOnDrag;
    FOnDragLine    : TColorLineToolOnDrag;
    FOnEndDragLine : TColorLineToolOnDrag;
    FStyle         : TColorLineStyle;
    FValue         : Double;

    IDragging      : Boolean;
    IParent        : TCustomAxisPanel;
    InternalOnEndDragLine : TColorLineToolOnDrag;

    Function Chart:TCustomAxisPanel;
    Procedure DrawColorLine(Back:Boolean);
    procedure SetDraw3D(const Value: Boolean);
    procedure SetDrawBehind(const Value: Boolean);
    procedure SetStyle(const Value: TColorLineStyle);
    procedure SetValue(const AValue: Double);
  protected
    Function CalcValue:Double;
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    procedure DoEndDragLine; virtual;
    class function GetEditorClass: String; override;
    procedure InternalDrawLine(Back:Boolean);
    procedure SetParent(Value:TCustomAxisPanel); virtual;
  public
    Constructor Create(AOwner:TComponent); override;

    Procedure Assign(Source:TPersistent); override;

    Function Clicked(x,y:Integer):Boolean;
    class Function Description:String; override;
    class Function LongDescription:String; override;

    Function LimitValue(const AValue:Double):Double;  // 7.0 moved from private
  published
    property Active;
    property Axis;
    property AllowDrag:Boolean read FAllowDrag write FAllowDrag default True;
    property DragRepaint:Boolean read FDragRepaint write FDragRepaint default False;
    property Draw3D:Boolean read FDraw3D write SetDraw3D default True;
    property DrawBehind:Boolean read FDrawBehind write SetDrawBehind default False;
    property NoLimitDrag:Boolean read FNoLimitDrag write FNoLimitDrag default False;
    property Pen;
    property Style:TColorLineStyle read FStyle write SetStyle default clCustom;
    property Value:Double read FValue write SetValue;

    property OnBeginDragLine:TColorLineToolOnDrag read FOnBeginDragLine write FOnBeginDragLine;
    property OnDragLine:TColorLineToolOnDrag read FOnDragLine write FOnDragLine;
    property OnEndDragLine:TColorLineToolOnDrag read FOnEndDragLine write FOnEndDragLine;
  end;

  // Rotate tool, use it to allow the end-user to do 3D rotation of the chart
  // at runtime by dragging the chart using the specified mouse button.

  TRotateToolStyles = ( rsAll, rsRotation, rsElevation );

  TRotateTool=class(TTeeCustomTool)
  private
    FButton    : TMouseButton;
    FCursor    : TCursor;
    FInertia   : Integer;
    FInverted  : Boolean;
    FOnRotate  : TNotifyEvent;
    FSpeed     : Integer;
    FStyle     : TRotateToolStyles;

    IDragging  : Boolean;
    IFirstTime : Boolean;
    IOldRepaint: Boolean;
    IOldX      : Integer;
    IOldY      : Integer;
    ITimer     : TTimer;
    IDifX      : Double;
    IDifY      : Double;
    IOldCursor : TCursor;

    procedure DoTimer(Sender: TObject);
    procedure DoRotation(const IDifX,IDifY:Double);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               AButton:TMouseButton;
                               AShift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    class Function Description:String; override;
    class Function LongDescription:String; override;

    class function ElevationChange(FullRotation:Boolean; const AAngle,AChange:Double):Double;
    procedure Rotate(const RotationDegrees,ElevationDegrees:Double);
    class function RotationChange(FullRotation:Boolean; const AAngle,AChange:Double):Double;
  published
    property Active;
    property Button:TMouseButton read FButton write FButton default mbLeft;
    property Cursor:TCursor read FCursor write FCursor default crTeeHand;
    property Inertia:Integer read FInertia write FInertia default 0;
    property Inverted:Boolean read FInverted write FInverted default False;
    property Pen;
    property Speed:Integer read FSpeed write FSpeed default 50; { % }
    property Style:TRotateToolStyles read FStyle write FStyle default rsAll;

    property OnRotate:TNotifyEvent read FOnRotate write FOnRotate;
  end;

  // Chart Image tool, use it to display a picture using the specified
  // Series axes as boundaries. When the axis are zoomed or scrolled,
  // the picture will follow the new boundaries.
  TChartImageTool=class(TTeeCustomToolSeries)
  private
    FPicture : TTeePicture;
    procedure SetPicture(const Value: TTeePicture);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    class function GetEditorClass: String; override;
    procedure SetSeries(const Value: TChartSeries); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Pen;
    property Picture:TTeePicture read FPicture write SetPicture;
    property Series;
  end;

  // A Shape object (with Left and Top), publishing all properties.
  TTeeShapePosition=class(TTeeCustomShapePosition)
  published
    property Bevel;
    property BevelWidth;
    property Brush;
    property Color;
    property CustomPosition;
    property Font;
    property Frame;
    property Gradient;
    property Left;
    property Picture;
    property Shadow;
    property ShapeStyle;
    property Top;
    property Transparency;
    property Transparent;
    property Visible default True;
  end;

  TAnnotationTool=class;

  TAnnotationPosition=(ppLeftTop,ppLeftBottom,ppRightTop,ppRightBottom,ppCenter);

  TAnnotationClick=procedure( Sender:TAnnotationTool;
			 Button:TMouseButton;
			 Shift: TShiftState;
			 X, Y: Integer) of object;

  TAnnotationCallout=class(TCallout)
  private
    FX : Integer;
    FY : Integer;
    FZ : Integer;

    Function CloserPoint(const R:TRect; const P:TPoint):TPoint;
    procedure SetX(const Value:Integer);
    procedure SetY(const Value:Integer);
    procedure SetZ(const Value:Integer);
  public
    constructor Create(AOwner: TChartSeries);
    Procedure Assign(Source:TPersistent); override;
  published
    property Visible default False;
    property XPosition:Integer read FX write SetX default 0;
    property YPosition:Integer read FY write SetY default 0;
    property ZPosition:Integer read FZ write SetZ default 0;
  end;

  TTextShape=class(TTeeShapePosition)
  private
    FAutoSize  : Boolean;
    FClipText  : Boolean;
    FCursor    : TCursor;
    FMargins   : TMargins;
    FTextAlign : TAlignment;

    procedure SetAutoSize(const Value: Boolean);
    procedure SetClipText(const Value: Boolean);
    procedure SetMargins(const Value: TMargins);
    procedure SetText(const Value: String);
    procedure SetTextAlign(const Value: TAlignment);
  protected
    FText      : String;

  {$IFDEF CLR}
  public
  {$ENDIF}

    INumLines  : Integer;

    procedure CalcBounds(Panel:TCustomAxisPanel);
  public
    Constructor Create(AOwner: TCustomTeePanel); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    procedure DrawText(Panel:TCustomAxisPanel; R:TRect; XOffset, NumLines:Integer);
  published
    property AutoSize:Boolean read FAutoSize write SetAutoSize default True;
    property ClipText:Boolean read FClipText write SetClipText default True;
    property Cursor:TCursor read FCursor write FCursor default crDefault;
    property Margins:TMargins read FMargins write SetMargins;
    property Text:String read FText write SetText;
    property TextAlignment:TAlignment read FTextAlign
                                      write SetTextAlign default taLeftJustify;
  end;

  // Annotation tool, use it to display text anywhere on the chart.
  TAnnotationTool=class(TTeeCustomTool)
  private
    FCallout   : TAnnotationCallout;
    FOnAfterDraw  : TNotifyEvent;
    FOnBeforeDraw : TNotifyEvent;
    FOnClick   : TAnnotationClick;
    FOnDblClick: TAnnotationClick;
    FPosition  : TAnnotationPosition;
    FPositionUnits: TTeeUnits;
    FShape     : TTextShape;

    function GetAutoSize:Boolean;
    function GetBounds:TRect;
    function GetClipText:Boolean;
    function GetCursor:TCursor;
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetTextAlign: TAlignment;
    function GetTop: Integer;
    function GetWidth: Integer;
    function IsNotAutoSize: Boolean;
    procedure Repaint;
    procedure SetAutoSize(const Value: Boolean);
    procedure SetBounds(const Value: TRect);
    procedure SetCallout(const Value: TAnnotationCallout);
    procedure SetClipText(const Value: Boolean);
    procedure SetCursor(const Value:TCursor);
    procedure SetHeight(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetPosition(const Value: TAnnotationPosition);
    procedure SetPositionUnits(const Value: TTeeUnits);
    procedure SetShape(const Value: TTextShape);
    procedure SetTextAlign(const Value: TAlignment);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    function GetXOffset:Integer; virtual;
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    Procedure DrawText; overload; virtual;
    class Function GetEditorClass:String; override;
    Function GetText:String; virtual;
    Function GetTextBounds(out NumLines,x,y:Integer):TRect; overload; virtual;
    Function GetTextBounds(Panel:TCustomAxisPanel; out NumLines,x,y:Integer):TRect; overload;
    Function GetTextBounds(Panel:TCustomAxisPanel; const ABounds:TRect;
                           out NumLines,x,y:Integer):TRect; overload;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    Procedure SetText(Const Value:String);
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    Function Clicked(x,y:Integer):Boolean;
    class Function Description:String; override;
    class Function LongDescription:String; override;

    property Bounds:TRect read GetBounds write SetBounds;
  published
    property Active;
    property AutoSize:Boolean read GetAutoSize write SetAutoSize default True;
    property Callout:TAnnotationCallout read FCallout write SetCallout;
    property ClipText:Boolean read GetClipText write SetClipText default True;
    property Cursor:TCursor read GetCursor write SetCursor default crDefault;
    property Position:TAnnotationPosition read FPosition write SetPosition
              default ppLeftTop;
    property PositionUnits:TTeeUnits read FPositionUnits write SetPositionUnits
                                                         default muPixels;
    property Shape:TTextShape read FShape write SetShape;
    property Text:String read GetText write SetText;
    property TextAlignment:TAlignment read GetTextAlign
                                      write SetTextAlign default taLeftJustify;

    property Height: Integer read GetHeight write SetHeight stored IsNotAutoSize;
    property Left: Integer read GetLeft write SetLeft stored False;
    property Top: Integer read GetTop write SetTop stored False;
    property Width: Integer read GetWidth write SetWidth stored IsNotAutoSize;

    property OnAfterDraw:TNotifyEvent read FOnAfterDraw write FOnAfterDraw;
    property OnBeforeDraw:TNotifyEvent read FOnBeforeDraw write FOnBeforeDraw;
    property OnClick:TAnnotationClick read FOnClick write FOnClick;
    property OnDblClick:TAnnotationClick read FOnDblClick write FOnDblClick;
  end;

  TSeriesAnimationTool=class;

  TSeriesAnimationStep=procedure(Sender:TSeriesAnimationTool; Step:Integer) of object;

  TSeriesAnimationLoop=(salNo, salOneWay, salCircular);

  TSeriesAnimationTool=class(TTeeCustomToolSeries)
  private
    FBackup     : TChartSeries;
    FDelay      : Integer;
    FDrawEvery  : Integer;
    FLoop       : TSeriesAnimationLoop;
    FStartValue : Double;
    FSteps      : Integer;
    FStartAtMin : Boolean;

    { events }
    FOnStart    : TNotifyEvent;
    FOnStep     : TSeriesAnimationStep;
    FOnStop     : TNotifyEvent;

    { internal }
    IStopped    : Boolean;
  protected
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;

    class Function Description:String; override;
    class Function LongDescription:String; override;
    procedure Execute; overload; virtual;
    procedure Execute(Sender:TObject); overload;
    function Running:Boolean;
    procedure Stop;
  published
    property Active;
    property Delay:Integer read FDelay write FDelay default 0;
    property DrawEvery:Integer read FDrawEvery write FDrawEvery default 0;
    property Loop:TSeriesAnimationLoop read FLoop write FLoop default salNo;
    property Series;
    property StartAtMin:Boolean read FStartAtMin write FStartAtMin default True;
    property StartValue:Double read FStartValue write FStartValue;
    property Steps:Integer read FSteps write FSteps default 100;

    { events }
    property OnStart:TNotifyEvent read FOnStart write FOnStart;
    property OnStep:TSeriesAnimationStep read FOnStep write FOnStep;
    property OnStop:TNotifyEvent read FOnStop write FOnStop;
  end;

  TRectangleTool=class(TAnnotationTool)
  private
    FAllowDrag   : Boolean;
    FAllowResize : Boolean;
    FOnDragged   : TNotifyEvent;
    FOnDragging  : TNotifyEvent;
    FOnResized   : TNotifyEvent;
    FOnResizing  : TNotifyEvent;

    P            : TPoint;
    IDrag        : Boolean;
    IEdge        : Integer;

    function GetResizing:Boolean;
  protected
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;

    procedure Assign(Source:TPersistent); override;

    Function Bitmap(ChartOnly:Boolean=False):TBitmap;
    Function ClickedEdge(x,y:Integer):Integer;
    class Function Description:String; override;
    class Function LongDescription:String; override;

    property Dragging:Boolean read IDrag;
    property Resizing:Boolean read GetResizing;
  published
    property AllowDrag:Boolean read FAllowDrag write FAllowDrag default True;
    property AllowResize:Boolean read FAllowResize write FAllowResize default True;
    property AutoSize default False;
    property Cursor default crHandPoint;
    property PositionUnits default muPixels;

    property OnDragged:TNotifyEvent read FOnDragged write FOnDragged;
    property OnDragging:TNotifyEvent read FOnDragging write FOnDragging;
    property OnResized:TNotifyEvent read FOnResized write FOnResized;
    property OnResizing:TNotifyEvent read FOnResizing write FOnResizing;
  end;

  TClipSeriesTool=class(TTeeCustomToolSeries)
  protected
    Procedure SeriesEvent(AEvent:TChartToolEvent); override;
  public
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Series;
  end;

  TFullScreenTool=class(TTeeCustomTool)
  private
    FKey      : Word;

    OldAlign  : TAlign;
    OldParent : TWinControl;
    OldRChart : TRect;
    IFreeForm : Boolean;

    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RemoveFullScreen;
  protected
    Procedure SetActive(Value:Boolean); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active default False;
    property ReleaseKey:Word read FKey write FKey default TeeKey_ESCAPE;
  end;

  {$IFDEF TEEOCX}
  var
  tmpChart : TCustomChart;
  tmpForm : TForm;
  isFullScreenRunning : Boolean;
  {$ENDIF}

implementation

Uses Math, TeeConst, TeeProCo {$IFDEF TEEOCX} , teestore {$ENDIF};

{ TCursorTool }
Constructor TCursorTool.Create(AOwner:TComponent);
begin
  inherited;
  FClick:=TeeClickTolerance;
  FStyle:=cssBoth;
  IPoint.X:=-1;
  IPoint.Y:=-1;
  IOldSnap:=-1;
  FScopeSize:=4;
end;

procedure TCursorTool.Assign(Source:TPersistent);
begin
  if Source is TCursorTool then
  with TCursorTool(Source) do
  begin
    Self.FUseChartRect:=FUseChartRect;
    Self.IXValue:=IXValue;
    Self.IYValue:=IYValue;
    Self.FClick:=FClick;
    Self.FFollowMouse:=FFollowMouse;
    Self.FHorizSize:=FHorizSize;
    Self.FScopeSize:=FScopeSize;
    Self.FScopeStyle:=FScopeStyle;
    Self.FSnap:=FSnap;
    Self.FSnapStyle:=FSnapStyle;
    Self.FStyle:=FStyle;
    Self.FUseSeriesZ:=FUseSeriesZ;
    Self.FVertSize:=FVertSize;
  end;

  inherited;
end;

Procedure TCursorTool.CalcValuePositions(X,Y:Integer);
begin
  if UseSeriesZ then
     ParentChart.Canvas.Calculate2DPosition(x,y,Z);

  Case IDragging of
    ccVertical  : IXValue:=GetHorizAxis.CalcPosPoint(X);
    ccHorizontal: IYValue:=GetVertAxis.CalcPosPoint(Y);
  else
  begin
    IXValue:=GetHorizAxis.CalcPosPoint(X);
    IYValue:=GetVertAxis.CalcPosPoint(Y);
  end;
  end;
end;

Procedure TCursorTool.CalcScreenPositions;
var tmpSnap : Integer;
begin
  if (IPoint.X=-1) or (IPoint.Y=-1) then
  begin
    With GetHorizAxis do IPoint.X:=(IStartPos+IEndPos) div 2;
    With GetVertAxis do IPoint.Y:=(IStartPos+IEndPos) div 2;

    CalcValuePositions(IPoint.X,IPoint.Y);
    tmpSnap:=SnapToPoint;
    CalcScreenPositions;
    Changed(tmpSnap);
  end
  else
  begin
    IPoint.X:=GetHorizAxis.CalcPosValue(IXValue);
    IPoint.Y:=GetVertAxis.CalcPosValue(IYValue);
  end;
end;

Procedure TCursorTool.Changed(SnapPoint:Integer);
begin
  if Assigned(FOnChange) then
     FOnChange(Self,IPoint.X,IPoint.Y,IXValue,IYValue,Series,SnapPoint);
end;

class Function TCursorTool.GetEditorClass:String;
begin
  result:='TCursorToolEditor';
end;

class Function TCursorTool.Description:String;
begin
  result:=TeeMsg_CursorTool;
end;

class Function TCursorTool.LongDescription:String;
begin
  result:=TeeMsg_CursorToolDesc;
end;

Function TeeGetFirstLastSeries(Series:TChartSeries;
                               out AMin,AMax:Integer):Boolean; { 5.01 }
begin
  AMin:=Series.FirstValueIndex;
  if AMin<0 then AMin:=0;

  AMax:=Series.LastValueIndex;
  if AMax<0 then AMax:=Series.Count-1
  else
  if AMax>=Series.Count then AMax:=Series.Count-1; { 5.03 }

  result:=(Series.Count>0) and (AMin<=Series.Count) and (AMax<=Series.Count);
end;

Function TCursorTool.NearestPoint(AStyle:TCursorToolStyle;
                                  out Difference:Double):Integer;
var t      : Integer;
    tmpDif : Double;
    tmpMin : Integer;
    tmpMax : Integer;
begin
  result:=-1;
  Difference:=-1;

  if TeeGetFirstLastSeries(Series,tmpMin,tmpMax) then
  for t:=tmpMin to tmpMax do
  begin

    if FSnapStyle=ssDefault then
    begin
      With Series do
      Case AStyle of
        cssHorizontal: tmpDif:=Abs(IYValue-YValues.Value[t]);
        cssVertical  : tmpDif:=Abs(IXValue-XValues.Value[t]);
      else
        tmpDif:=Sqrt(Sqr(IXValue-XValues.Value[t])+Sqr(IYValue-YValues.Value[t]));
      end;
    end
    else
    if FSnapStyle=ssHorizontal then
       tmpDif:=Abs(IYValue-Series.YValues.Value[t])
    else
       tmpDif:=Abs(IXValue-Series.XValues.Value[t]);

    if (Difference=-1) or (tmpDif<Difference) then
    begin
      Difference:=tmpDif;
      result:=t;
    end;
  end;
end;

Function TCursorTool.SnapToPoint:Integer;
var Difference : Double;
begin
  if Assigned(Series) and FSnap then result:=NearestPoint(FStyle,Difference)
                                else result:=-1;

  if result<>-1 then
  Case FStyle of
    cssHorizontal: IYValue:=Series.YValues.Value[result];
    cssVertical  : IXValue:=Series.XValues.Value[result];
  else
    begin
      IXValue:=Series.XValues.Value[result];
      IYValue:=Series.YValues.Value[result]
    end;
  end;
end;

Function TCursorTool.GetAxisRect:TRect;
begin
  if UseChartRect then result:=ParentChart.ChartRect
  else
  begin
    With GetHorizAxis do
    begin
      result.Left:=IStartPos;
      result.Right:=IEndPos;
    end;

    With GetVertAxis do
    begin
      result.Top:=IStartPos;
      result.Bottom:=IEndPos;
    end;

    if Assigned(FOnGetAxisRect) then
       FOnGetAxisRect(Self,result);
  end;
end;

Function TCursorTool.Z:Integer;
begin
  if UseSeriesZ and Assigned(Series) then
     result:=Series.StartZ
  else
     result:=0;
end;

procedure TCursorTool.RedrawCursor;

  Procedure DrawCursorLines(Draw3D:Boolean; Const R:TRect; X,Y:Integer);

    Procedure DrawHorizontal;
    begin
      With ParentChart.Canvas do
      if Draw3D then HorizLine3D(R.Left,R.Right,Y,Z)
                else DoHorizLine(R.Left,R.Right,Y);
    end;

    Procedure DrawVertical;
    begin
      With ParentChart.Canvas do
      if Draw3D then VertLine3D(X,R.Top,R.Bottom,Z)
                else DoVertLine(X,R.Top,R.Bottom);
    end;

    procedure DrawScope;
    var tmp : TRect;
    begin
      tmp.Left:=X-ScopeSize;
      tmp.Top:=Y-ScopeSize;
      tmp.Right:=X+ScopeSize;
      tmp.Bottom:=Y+ScopeSize;

      With ParentChart.Canvas do
      if Draw3D then
      begin
        if ScopeStyle=scsCamera then
        begin
          Rectangle(X-HorizSize-ScopeSize,Y-VertSize-ScopeSize,
                    X+HorizSize+ScopeSize,Y+VertSize+ScopeSize,Z);

          HorizLine3D(X-ScopeSize,X+ScopeSize,Y,Z);
          VertLine3D(X,Y-ScopeSize,Y+ScopeSize,Z);
        end
        else
        begin
          HorizLine3D(X-HorizSize-ScopeSize,X-ScopeSize,Y,Z);
          HorizLine3D(X+ScopeSize,X+HorizSize+ScopeSize,Y,Z);

          VertLine3D(X,Y-VertSize-ScopeSize,Y-ScopeSize,Z);
          VertLine3D(X,Y+ScopeSize,Y+VertSize+ScopeSize,Z);

          case ScopeStyle of
            scsRectangle: Rectangle(tmp,Z);
            scsCircle   : EllipseWithZ(tmp.Left,tmp.Top,tmp.Right,tmp.Bottom,Z);
            scsDiamond  : PolygonWithZ( [TeePoint(X-ScopeSize,Y),
                                        TeePoint(X,Y-ScopeSize),
                                        TeePoint(X+ScopeSize,Y),
                                        TeePoint(X,Y+ScopeSize)],
                                        Z);
          end;
        end;
      end
      else
      begin
        if ScopeStyle=scsCamera then
        begin
          Rectangle(X-HorizSize-ScopeSize,Y-VertSize-ScopeSize,
                    X+HorizSize+ScopeSize,Y+VertSize+ScopeSize);

          DoHorizLine(X-ScopeSize,X+ScopeSize,Y);
          DoVertLine(X,Y-ScopeSize,Y+ScopeSize);
        end
        else
        begin
          DoHorizLine(X-HorizSize-ScopeSize,X-ScopeSize,Y);
          DoHorizLine(X+ScopeSize,X+HorizSize+ScopeSize,Y);

          DoVertLine(X,Y-VertSize-ScopeSize,Y-ScopeSize);
          DoVertLine(X,Y+ScopeSize,Y+VertSize+ScopeSize);

          case ScopeStyle of
            scsRectangle: Rectangle(tmp);
            scsCircle   : Ellipse(tmp);
            scsDiamond  : Polygon( [TeePoint(X-ScopeSize,Y),
                                   TeePoint(X,Y-ScopeSize),
                                   TeePoint(X+ScopeSize,Y),
                                   TeePoint(X,Y+ScopeSize)]);
          end;
        end;
      end;
    end;

  begin
    Case FStyle of
      cssHorizontal: DrawHorizontal;
      cssVertical  : DrawVertical;
      cssScope     : begin
                       DrawScope;
                       DrawHorizontal;
                       DrawVertical;
                     end;
      cssScopeOnly : DrawScope;
    else
    begin
      DrawHorizontal;
      DrawVertical;
    end;
    end;
  end;

var tmpColor : TColor;
begin
  if Assigned(ParentChart) then
  begin
    tmpColor:=ParentChart.Color;
    if tmpColor=clTeeColor then tmpColor:=clBtnFace;

    With ParentChart.Canvas do
    begin
      AssignVisiblePenColor(Self.Pen,Self.Pen.Color xor ColorToRGB(tmpColor));
      Brush.Style:=bsClear;
      Pen.Mode:=pmXor;

      DrawCursorLines(ParentChart.View3D,MouseRectangle(IPoint.X,IPoint.Y,True),IPoint.X,IPoint.Y);

      Pen.Mode:=pmCopy;
      ParentChart.Canvas.Invalidate;
    end;
  end;
end;

function TCursorTool.MouseRectangle(X,Y:Integer; UseSize:Boolean):TRect;
begin
  result:=GetAxisRect;

  if UseSize then
  begin
    if HorizSize<>0 then
    begin
      result.Left:=X-HorizSize;
      result.Right:=X+HorizSize;
    end;

    if VertSize<>0 then
    begin
      result.Top:=Y-VertSize;
      result.Bottom:=Y+VertSize;
    end;
  end;
end;

Function TCursorTool.InMouseRectangle(x,y:Integer; UseSize:Boolean=False):Boolean;
begin
  if UseSeriesZ then
     ParentChart.Canvas.Calculate2DPosition(x,y,Z);

  result:=PointInRect(MouseRectangle(x,y,UseSize),x,y);
end;

Procedure TCursorTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                                       Button:TMouseButton;
                                       Shift: TShiftState; X, Y: Integer);

  Procedure MouseMove;
  var tmpSnap : Integer;
      tmp     : TCursorClicked;
  begin
    { if mouse button is pressed and dragging then... }
    if ((IDragging<>ccNone) or FollowMouse) and InMouseRectangle(X,Y) then
    begin
      RedrawCursor;      { hide the cursor }
      CalcValuePositions(X,Y);

      tmpSnap:=SnapToPoint;  { snap to the nearest point of SnapSeries }

      { draw again the cursor at the new position }
      CalcScreenPositions;
      RedrawCursor;
      Changed(tmpSnap);

      if Assigned(FOnSnapChange) and (IOldSnap<>tmpSnap) then  // 7.0
         FOnSnapChange(Self,IPoint.X,IPoint.Y,IXValue,IYValue,Series,tmpSnap);

      IOldSnap:=tmpSnap;
    end
    else
    begin  { mouse button is not pressed, user is not dragging the cursor }
           { change the mouse cursor when passing over the Cursor }
      tmp:=Clicked(x,y);

      case tmp of
         ccHorizontal : ParentChart.Cursor:=crVSplit;
         ccVertical   : ParentChart.Cursor:=crHSplit;
         ccBoth       : ParentChart.Cursor:=crSizeAll;
      end;

      ParentChart.CancelMouse:=tmp<>ccNone;
    end;
  end;

begin
  Case AEvent of
      cmeUp: IDragging:=ccNone;

    cmeMove: MouseMove;

    cmeDown: if not FFollowMouse then
             begin
               IDragging:=Clicked(x,y);

               if IDragging<>ccNone then
                  ParentChart.CancelMouse:=True;
             end;
  end;
end;

Function TCursorTool.Clicked(x,y:Integer):TCursorClicked;
var tmp : TPoint;
begin
  result:=ccNone;

  if InMouseRectangle(x,y,True) then
  begin
    tmp:=IPoint;

    if UseSeriesZ then
       ParentChart.Canvas.Calculate2DPosition(x,y,Z);

    if ((FStyle=cssBoth) or (FStyle=cssScope) or (FStyle=cssScopeOnly)) and
        (Abs(Y-tmp.Y)<=ClickTolerance) and
        (Abs(X-tmp.X)<=ClickTolerance) then
       result:=ccBoth
    else
    if (FStyle<>cssVertical) and (Abs(Y-tmp.Y)<=ClickTolerance) then
       result:=ccHorizontal
    else
    if (FStyle<>cssHorizontal) and (Abs(X-tmp.X)<=ClickTolerance) then
       result:=ccVertical
  end;
end;

Procedure TCursorTool.SetHorizSize(const Value:Integer);
begin
  SetIntegerProperty(FHorizSize,Value);
end;

Procedure TCursorTool.SetScopeSize(const Value:Integer);
begin
  SetIntegerProperty(FScopeSize,Value);
end;

Procedure TCursorTool.SetScopeStyle(const Value:TScopeCursorStyle);
begin
  if FScopeStyle<>Value then
  begin
    FScopeStyle:=Value;
    Repaint;
  end;
end;

Procedure TCursorTool.SetVertSize(const Value:Integer);
begin
  SetIntegerProperty(FVertSize,Value);
end;

Procedure TCursorTool.SetStyle(Value:TCursorToolStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    SnapToPoint;
    Repaint;
  end;
end;

procedure TCursorTool.SetSeries(const Value: TChartSeries);
begin
  inherited;

  IOldSnap:=-1;

  if Assigned(Series) and (not (csLoading in ComponentState)) then
  begin
    SnapToPoint;
    Repaint;
  end;
end;

procedure TCursorTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  Repaint;
end;

procedure TCursorTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if AEvent=cteAfterDraw then
  begin
    CalcScreenPositions;
    RedrawCursor;
  end;
end;

procedure TCursorTool.SetXValue(const Value: Double);
begin
  if IXValue<>Value then
  begin
    IXValue:=Value;
    IOldSnap:=-1;
    DoChange;
  end;
end;

procedure TCursorTool.DoChange;
begin
  CalcScreenPositions;
  Changed(-1);
  Repaint;
end;

procedure TCursorTool.SetYValue(const Value: Double);
begin
  if IYValue<>Value then
  begin
    IYValue:=Value;
    IOldSnap:=-1;
    DoChange;
  end;
end;

procedure TCursorTool.SetUseChartRect(const Value: Boolean);
begin
  SetBooleanProperty(FUseChartRect,Value);
end;

procedure TCursorTool.SetUseSeriesZ(const Value: Boolean);
begin
  SetBooleanProperty(FUseSeriesZ,Value);
end;

{ TDragMarksTool }
Constructor TDragMarksTool.Create(AOwner:TComponent);
begin
  inherited;
  Index:=TeeNoPointClicked;
end;

class function TDragMarksTool.Description: String;
begin
  result:=TeeMsg_DragMarksTool;
end;

class function TDragMarksTool.LongDescription: String;
begin
  result:=TeeMsg_DragMarksDesc;
end;

Procedure TDragMarksTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                                       Button:TMouseButton;
                                       Shift: TShiftState; X, Y: Integer);

  Procedure MouseMove;

    Procedure CheckCursor;

      Function CheckCursorSeries(ASeries:TChartSeries):Boolean;
      begin
        result:=ASeries.Active and ASeries.Marks.Visible and
                (ASeries.Marks.Clicked(x,y)<>-1);
      end;

    var tmp : Boolean;
        t   : Integer;
    begin
      tmp:=False;

      if Assigned(Series) then
         tmp:=CheckCursorSeries(Series)
      else
      With ParentChart do
      for t:=SeriesCount-1 downto 0 do
      begin
        tmp:=CheckCursorSeries(Series[t]);
        if tmp then
           Break;
      end;

      if tmp then
      begin
        ParentChart.Cursor:=crHandPoint;
        ParentChart.CancelMouse:=True;
      end;
    end;

  var DifX : Integer;
      DifY : Integer;
      tmp  : TSeriesMarkPosition;
  begin
    if Index=TeeNoPointClicked then
       CheckCursor
    else
    begin
      tmp:=ISeries.Marks.Positions.Position[Index];  // 7.07

      if Assigned(tmp) then
      with tmp do
      begin
        DifX:=X-IOldX;
        DifY:=Y-IOldY;
        Custom:=True;
        Inc(LeftTop.X,DifX);
        Inc(LeftTop.Y,DifY);
        Inc(ArrowTo.X,DifX);
        Inc(ArrowTo.Y,DifY);
        IOldX:=X;
        IOldY:=Y;
        ParentChart.CancelMouse:=True;
        Repaint;
      end;
    end;
  end;

  Procedure MouseDown;

    Function CheckSeries(ASeries:TChartSeries):Integer;
    begin
      result:=-1;

      if ASeries.Active then
      begin
        result:=ASeries.Marks.Clicked(x,y);

        if result<>-1 then
        begin
          ISeries:=ASeries;
          Index:=result;
          Exit;
        end;
      end;
    end;

  var t : Integer;
  begin
    if Assigned(Series) then
       CheckSeries(Series)
    else
    With ParentChart do
    for t:=SeriesCount-1 downto 0 do
        if CheckSeries(Series[t])<>-1 then
           Break;

    if Index<>TeeNoPointClicked then
    begin
      IOldX:=X;
      IOldY:=Y;
    end;
  end;

begin
  Case AEvent of
    cmeUp  : begin
               if Assigned(FOnDragged) and (Index<>TeeNoPointClicked) then
                  FOnDragged(Self, Index, Button, Shift, X, Y);

               Index:=TeeNoPointClicked;
             end;

    cmeDown: begin
               MouseDown;

               if Index<>TeeNoPointClicked then
                  ParentChart.CancelMouse:=True;
             end;

    cmeMove: begin
               MouseMove;

               if Assigned(FOnDragging) and (Index<>TeeNoPointClicked) then
                  FOnDragging(Self, Index, Button, Shift, X, Y);
             end;
  end;
end;

class function TDragMarksTool.GetEditorClass: String;
begin
  result:='TDragMarksToolEditor';
end;

{ TAxisArrowTool }
Constructor TAxisArrowTool.Create(AOwner: TComponent);
begin
  inherited;
  FLength:=16;
  FHeadWidth:=8;
  FPosition:=aaBoth;
  FScrollPercent:=10;
  FSizePercent:=50;
end;

procedure TAxisArrowTool.ChartEvent(AEvent: TChartToolEvent);
var tmpZ : Integer;

  Procedure DrawArrow(APos,ALength:Integer);
  var P0 : TPoint;
      P1 : TPoint;
  begin
    With Axis do
    if Horizontal then
    begin
      P0:=TeePoint(APos+ALength,PosAxis);
      P1:=TeePoint(APos,PosAxis)
    end
    else
    begin
      P0:=TeePoint(PosAxis,APos+ALength);
      P1:=TeePoint(PosAxis,APos);
    end;

    ParentChart.Canvas.Arrow(True,P0,P1,HeadWidth,HeadWidth,tmpZ,SizePercent);
  end;

begin
  inherited;

  if (AEvent=cteAfterDraw) and Assigned(Axis) then
  begin
    ParentChart.Canvas.AssignBrush(Self.Brush);
    ParentChart.Canvas.AssignVisiblePen(Self.Pen);

    if ParentChart.View3D and Axis.OtherSide then
       tmpZ:=ParentChart.Width3D
    else
       tmpZ:=0;

    if (FPosition=aaStart) or (FPosition=aaBoth) then
       DrawArrow(Axis.IStartPos,Length);

    if (FPosition=aaEnd) or (FPosition=aaBoth) then
       DrawArrow(Axis.IEndPos,-Length);
  end;
end;

class function TAxisArrowTool.Description: String;
begin
  result:=TeeMsg_AxisArrowTool;
end;

class function TAxisArrowTool.LongDescription: String;
begin
  result:=TeeMsg_AxisArrowDesc;
end;

procedure TAxisArrowTool.SetHeadWidth(const Value: Integer);
begin
  SetIntegerProperty(FHeadWidth,Value);
end;

procedure TAxisArrowTool.SetLength(const Value: Integer);
begin
  SetIntegerProperty(FLength,Value);
end;

Function TAxisArrowTool.ClickedArrow(x,y:Integer):Integer;

  Procedure Check(Pos1,Pos2:Integer);
  begin
    { to-do: right/top axis Z ! }
    With Axis do
    if (Abs(Pos1-PosAxis)<TeeClickTolerance) then
    begin
      if (FPosition=aaStart) or (FPosition=aaBoth) then
        if (Pos2>IStartPos) and (Pos2<IStartPos+Length) then
        begin
          result:=0;
          exit;
        end;
      if (FPosition=aaEnd) or (FPosition=aaBoth) then
        if (Pos2<IEndPos) and (Pos2>IEndPos-Length) then
        begin
          result:=1;
          exit;
        end;
    end;
  end;

begin
  result:=-1;
  if Axis.Horizontal then Check(y,x) else Check(x,y);
end;

Procedure TAxisArrowTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                                       Button:TMouseButton;
                                       Shift: TShiftState; X, Y: Integer);

  Procedure DoScroll(const ADelta:Double);

    // Returns True when there is at least on series in the chart,
    // that has "both" axis associated (left and right, or top and bottom).
    // The OtherAxis parameter returns the "other" axis (right axis if
    // series axis is left, left axis if series axis is right, and so on).
    Function AnySeriesBothAxis(Axis:TChartAxis; var OtherAxis:TChartAxis):Boolean;
    var t : Integer;
    begin
      result:=False;

      for t:=0 to ParentChart.SeriesCount-1 do
      if ParentChart[t].AssociatedToAxis(Axis) then
      begin
        if Axis.Horizontal then
        begin
          if ParentChart[t].HorizAxis=aBothHorizAxis then
          begin
            if Axis=ParentChart.TopAxis then OtherAxis:=ParentChart.BottomAxis
                                        else OtherAxis:=ParentChart.TopAxis;
            result:=True;
          end;
        end
        else
        begin
          if ParentChart[t].VertAxis=aBothVertAxis then
          begin
            if Axis=ParentChart.LeftAxis then OtherAxis:=ParentChart.RightAxis
                                         else OtherAxis:=ParentChart.LeftAxis;
            result:=True;
          end;
        end;
      end;
    end;

  var tmp      : Boolean;
      tmpMin   : Double;
      tmpMax   : Double;
      tmpAxis2 : TChartAxis;
  begin
    tmp:=True;

    if Assigned(TCustomChart(ParentChart).OnAllowScroll) then
    begin
      tmpMin:=Axis.Minimum+ADelta;
      tmpMax:=Axis.Maximum+ADelta;
      TCustomChart(ParentChart).OnAllowScroll(Axis,tmpMin,tmpMax,tmp);
    end;

    if tmp then
    begin
      Axis.Scroll(ADelta,False);

      if AnySeriesBothAxis(Axis,tmpAxis2) then
         tmpAxis2.Scroll(ADelta,False);

      With TCustomChart(Axis.ParentChart) do
        if Assigned(OnScroll) then OnScroll(Axis.ParentChart); { 5.01 }
    end;
  end;

var tmp   : Integer;
    Delta : Double;
begin
  if Assigned(Axis) and Axis.Visible then
  Case AEvent of
    cmeDown: if ScrollPercent<>0 then
             With Axis do
             begin
               tmp:=ClickedArrow(x,y);
               Delta:=(Maximum-Minimum)*ScrollPercent/100.0;  // 5.02
               if ScrollInverted then Delta:=-Delta; // 5.02
               if tmp=0 then DoScroll(Delta)
               else
               if tmp=1 then DoScroll(-Delta);
               if (tmp=0) or (tmp=1) then ParentChart.CancelMouse:=True;

               if Assigned(FOnClick) and (tmp<>-1) then
                  FOnClick(Self,tmp=0); // 6.0
             end;
    cmeMove: begin
               if ClickedArrow(x,y)<>-1 then
               begin
                 ParentChart.Cursor:=crHandPoint;
                 ParentChart.CancelMouse:=True;
               end;
             end;
  end;
end;

class function TAxisArrowTool.GetEditorClass: String;
begin
  result:='TAxisArrowToolEditor';
end;

procedure TAxisArrowTool.SetPosition(const Value: TAxisArrowToolPosition);
begin
  if FPosition<>Value then
  begin
    FPosition:=Value;
    Repaint;
  end;
end;

procedure TAxisArrowTool.SetSizePercent(const Value: Integer);
begin
  SetIntegerProperty(FSizePercent,Value);
end;

{ TDrawLine }
Function TDrawLine.StartHandle:TRect;
begin
  With Parent.AxisPoint(StartPos) do result:=TeeRect(X-3,Y-3,X+3,Y+3);
end;

Function TDrawLine.EndHandle:TRect;
begin
  With Parent.AxisPoint(EndPos) do result:=TeeRect(X-3,Y-3,X+3,Y+3);
end;

Procedure TDrawLine.DrawHandles;
begin
  With Parent.ParentChart.Canvas do
  begin
    Brush.Style:=bsSolid;
    if Parent.ParentChart.Color=clBlack then Brush.Color:=clSilver
                                        else Brush.Color:=clBlack;
    Pen.Style:=psClear;
    RectangleWithZ(StartHandle,0);
    RectangleWithZ(EndHandle,0);
  end;
end;

{ TDrawLines }
function TDrawLines.Get(Index: Integer): TDrawLine;
begin
  result:=TDrawLine(inherited Items[Index]);
end;

function TDrawLines.AddLine(const X0,Y0,X1,Y1:Double):TDrawLine;
begin
  result:=Add as TDrawLine;
  result.X0:=X0;
  result.Y0:=Y0;
  result.X1:=X1;
  result.Y1:=Y1;
end;

function TDrawLines.Last: TDrawLine;
begin
  if Count=0 then result:=nil else result:=Get(Count-1);
end;

procedure TDrawLines.Put(Index: Integer; const Value: TDrawLine);
begin
  Items[Index].Assign(Value);
end;

{ TDrawLine }
{$IFNDEF CLR}
Constructor TDrawLine.CreateXY(Collection:TCollection; const X0, Y0, X1, Y1: Double);
begin
  Create(Collection);
  StartPos.X:=X0;
  StartPos.Y:=Y0;
  EndPos.X:=X1;
  EndPos.Y:=Y1;

  if Assigned(Parent.FOnNewLine) then   // v8 TV52010392 
       Parent.FOnNewLine(Self);

  if Assigned(Parent) then  // 7.04
     Parent.Repaint;
end;
{$ENDIF}

Destructor TDrawLine.Destroy;  { 5.02 }
begin
  if Self=Parent.ISelected then
     Parent.ISelected:=nil;

  FPen.Free;
  inherited;
end;

procedure TDrawLine.Assign(Source: TPersistent);
begin
  if Source is TDrawLine then
  With TDrawLine(Source) do
  Begin
    Self.StartPos :=StartPos;
    Self.EndPos   :=EndPos;
    Self.FStyle   :=FStyle;

    if Assigned(FPen) then
       SetPen(FPen)
    else
    if Assigned(Self.FPen) then
       FreeAndNil(Self.FPen);

  end
  else inherited;
end;

function TDrawLine.Clicked(X,Y:Integer; AHandle:TDrawLineHandle; PixelsTolerance:Integer=0):Boolean; // 7.04
var tmpStart : TPoint;
    tmpEnd   : TPoint;
    P        : TPoint;
begin
  P:=TeePoint(X,Y);

  tmpStart:=Parent.AxisPoint(StartPos);
  tmpEnd:=Parent.AxisPoint(EndPos);

  Case AHandle of
    chStart: result:=PointInRect(StartHandle,P);
    chEnd  : result:=PointInRect(EndHandle,P);
  else
    Case Style of
        dlLine  : result:=PointInLine(P,tmpStart,tmpEnd,PixelsTolerance);
dlHorizParallel : begin
                    result:=PointInLine(P,tmpStart.X,tmpStart.Y,
                                          tmpEnd.X,tmpStart.Y,PixelsTolerance);
                    if not result then
                       result:=PointInLine( P,tmpStart.X,tmpEnd.Y,
                                              tmpEnd.X,tmpEnd.Y,PixelsTolerance);
                  end;
    dlRectangle,
    dlEllipse   : result:=PointInRect(TeeRect(tmpStart.X,tmpStart.Y,
                                              tmpEnd.X,tmpEnd.Y),P);
    else
    begin
      result:=PointInLine( P,tmpStart.X,tmpStart.Y,
                             tmpStart.X,tmpEnd.Y,PixelsTolerance);
      if not result then
         result:=PointInLine( P,tmpEnd.X,tmpStart.Y,
                                tmpEnd.X,tmpEnd.Y,PixelsTolerance);
    end;
    end;
  end;
end;

{$IFNDEF CLR}
type
  TOwnedCollectionAccess=class(TOwnedCollection);
{$ENDIF}

function TDrawLine.GetParent: TDrawLineTool;
begin
  {$IFDEF CLR}
  result:=TDrawLineTool(Collection.Owner);
  {$ELSE}
  result:=TDrawLineTool(TOwnedCollectionAccess(Collection).GetOwner);
  {$ENDIF}
end;

function TDrawLine.GetX0: Double;
begin
  result:=StartPos.X;
end;

function TDrawLine.GetX1: Double;
begin
  result:=EndPos.X;
end;

function TDrawLine.GetY0: Double;
begin
  result:=StartPos.Y;
end;

function TDrawLine.GetY1: Double;
begin
  result:=EndPos.Y;
end;

Procedure TDrawLine.SetStyle(Value:TDrawLineStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Parent.Repaint;
  end;
end;

procedure TDrawLine.SetX0(const Value: Double);
begin
  Parent.SetDoubleProperty(StartPos.X,Value);
end;

procedure TDrawLine.SetX1(const Value: Double);
begin
  Parent.SetDoubleProperty(EndPos.X,Value);
end;

procedure TDrawLine.SetY0(const Value: Double);
begin
  Parent.SetDoubleProperty(StartPos.Y,Value);
end;

procedure TDrawLine.SetY1(const Value: Double);
begin
  Parent.SetDoubleProperty(EndPos.Y,Value);
end;

function TDrawLine.IsPenStored: Boolean;
begin
  result:=Assigned(FPen);
end;

function TDrawLine.GetPen:TChartPen;
begin
  if not Assigned(FPen) then
  begin
    // LCL / FPC bug, workaround

    FPen:=TChartPen.Create({$IFDEF LCL}nil{$ELSE}Parent.CanvasChanged{$ENDIF});
    
    FPen.Assign(Parent.Pen);
  end;

  result:=FPen;
end;

procedure TDrawLine.SetPen(const Value: TChartPen);
begin
  if Assigned(Value) then Pen.Assign(Value)
  else
  begin
    FreeAndNil(FPen);
    Parent.Repaint;
  end;
end;

{ TDrawLineTool }
Constructor TDrawLineTool.Create(AOwner: TComponent);
begin
  inherited;
  FButton:=mbLeft;
  FLines:=TDrawLines.Create(Self,TDrawLine);
  FEnableDraw:=True;
  FEnableSelect:=True;
  FSelectNew:=True;
  ISelected:=nil;
  IHandle:=chNone;
end;

Destructor TDrawLineTool.Destroy;
begin
  ISelected:=nil;
  FLines.Free;
  inherited;
end;

procedure TDrawLineTool.Assign(Source:TPersistent);
begin
  if Source is TDrawLineTool then
  with TDrawLineTool(Source) do
  begin
    Self.FButton:=FButton;
    Self.FClick:=FClick;
    Self.FEnableDraw:=FEnableDraw;
    Self.FEnableSelect:=FEnableSelect;
    Self.Lines:=Lines;
    Self.FSelectNew:=FSelectNew;
    Self.FStyle:=FStyle;
  end;

  inherited;
end;

Procedure TDrawLineTool.DrawLine( Const StartPos,EndPos:TPoint;
                                  AStyle:TDrawLineStyle);
begin
  With ParentChart.Canvas do
  if ParentChart.View3D then
  begin
    Case AStyle of
          dlLine: begin
                    MoveTo3D(StartPos.X,StartPos.Y,0);
                    LineTo3D(EndPos.X,EndPos.Y,0);
                  end;
 dlHorizParallel: begin
                    HorizLine3D(StartPos.X,EndPos.X,StartPos.Y,0);
                    HorizLine3D(StartPos.X,EndPos.X,EndPos.Y,0);
                  end;
     dlRectangle: RectangleWithZ(TeeRect(StartPos.X,StartPos.Y,EndPos.X,EndPos.Y),0);
       dlEllipse: EllipseWithZ(StartPos.X,StartPos.Y,EndPos.X,EndPos.Y,0);
    else
      begin
        VertLine3D(StartPos.X,StartPos.Y,EndPos.Y,0);
        VertLine3D(EndPos.X,StartPos.Y,EndPos.Y,0);
      end
    end;
  end
  else
  Case AStyle of
          dlLine: Line(StartPos.X,StartPos.Y,EndPos.X,EndPos.Y);
 dlHorizParallel: begin
                    DoHorizLine(StartPos.X,EndPos.X,StartPos.Y);
                    DoHorizLine(StartPos.X,EndPos.X,EndPos.Y);
                  end;
     dlRectangle: Rectangle(StartPos.X,StartPos.Y,EndPos.X,EndPos.Y);
       dlEllipse: Ellipse(StartPos.X,StartPos.Y,EndPos.X,EndPos.Y);
  else
    begin
      DoVertLine(StartPos.X,StartPos.Y,EndPos.Y);
      DoVertLine(EndPos.X,StartPos.Y,EndPos.Y);
    end
  end;
end;

procedure TDrawLineTool.ChartEvent(AEvent: TChartToolEvent);
var t : Integer;
begin
  inherited;

  if (AEvent=cteAfterDraw) then
  begin
    with ParentChart do
    begin
      Canvas.BackMode:=cbmTransparent;
      ClipDrawingRegion;
    end;

    if Lines.Count > 0 then
      for t:=0 to Lines.Count-1 do RedrawLine(Lines[t]);

    if Assigned(ISelected) then
       ISelected.DrawHandles;

    if IDrawing then
      RedrawLine(ISelected);

    ParentChart.Canvas.UnClipRectangle;
  end;
end;

Procedure TDrawLineTool.ClipDrawingRegion;
var R : TRect;
begin
  if Assigned(Series) then
  with Series do
     R:=TeeRect(GetHorizAxis.IStartPos,GetVertAxis.IStartPos,
                GetHorizAxis.IEndPos,GetVertAxis.IEndPos)
  else
     R:=ParentChart.ChartRect;

  with ParentChart do
  if CanClip then
     Canvas.ClipCube(R,0,Width3D);
end;

Function TDrawLineTool.InternalClicked(X,Y:Integer; AHandle:TDrawLineHandle):TDrawLine;
begin
  result:=InternalClicked(X,Y,AHandle,ClickTolerance);
end;

Function TDrawLineTool.InternalClicked(X,Y:Integer; AHandle:TDrawLineHandle; ClickTolerance:Integer):TDrawLine;
var t : Integer;
begin
  result:=nil;

  // convert from 3D to 2D...
  ParentChart.Canvas.Calculate2DPosition(X,Y,0);

  // first, find if clicked the selected line...
  if Assigned(ISelected) and ISelected.Clicked(X,Y,AHandle,ClickTolerance) then
  begin
    result:=ISelected;
    exit;
  end;

  // find which clicked line...
  for t:=0 to Lines.Count-1 do
      if Lines[t].Clicked(X,Y,AHandle,ClickTolerance) then
      begin
        result:=Lines[t];
        break;
      end;
end;

Function TDrawLineTool.Clicked(X,Y:Integer):TDrawLine;
begin
  result:=Clicked(X,Y,ClickTolerance);
end;

Function TDrawLineTool.Clicked(X,Y:Integer; ClickTolerance:Integer):TDrawLine;
begin
  // try first with whole line...
  result:=InternalClicked(X,Y,chNone,ClickTolerance);

  // try then at start and end line points...
  if not Assigned(result) then
  begin
     result:=InternalClicked(X,Y,chStart,ClickTolerance);

    if not Assigned(result) then
       result:=InternalClicked(X,Y,chEnd,ClickTolerance);
  end;
end;

Procedure TDrawLineTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                                       AButton:TMouseButton;
                                       AShift: TShiftState; X, Y: Integer);

  { returns True if the mouse is over selected line ending points or over
    any non-selected line.
    If True, the Chart cursor is changed.
  }
  Function CheckCursor:Boolean;
  begin
    if Assigned(ISelected) and
       ((InternalClicked(X,Y,chStart)=ISelected) or
        (InternalClicked(X,Y,chEnd)=ISelected)) then { ending points }
    begin
      ParentChart.Cursor:=crCross;
      result:=True;
    end
    else
    if Assigned(Clicked(X,Y)) then { over a line }
    begin
      ParentChart.Cursor:=crHandPoint;  // set cursor
      result:=True;
    end
    else
      result:=False;
  end;

  procedure SetSelection(const ALine:TDrawLine); // 7.05
  begin
    FromPoint:=AxisPoint(ALine.StartPos);
    ToPoint:=AxisPoint(ALine.EndPos);
    IPoint:=TeePoint(X,Y);
  end;

var tmpLine  : TDrawLine;
    tmpAllow : Boolean;
begin
  Case AEvent of
    cmeDown: if AButton=FButton then
             begin
               if FEnableSelect then tmpLine:=Clicked(X,Y)
                                else tmpLine:=nil;

               if Assigned(tmpLine) then { clicked line, do select }
               begin
                 SetSelection(tmpLine);
                 IHandle:=chSeries;

                 if tmpLine<>ISelected then
                 begin
                   tmpAllow:=True;
                   if Assigned(FOnSelecting) then
                      FOnSelecting(Self,tmpLine,tmpAllow); { 5.03 }

                   if tmpAllow then
                   begin
                     { change selected line }
                     if Assigned(ISelected) then
                     begin
                       ISelected:=tmpLine;
                       Repaint;
                     end
                     else
                     begin
                       ISelected:=tmpLine;
                       ISelected.DrawHandles;
                     end;

                     { call event }
                     if Assigned(FOnSelect) then FOnSelect(Self);
                   end;
                 end
                 else
                 begin
                   { check if clicked on ending points }
                   if Assigned(InternalClicked(X,Y,chStart)) then
                      IHandle:=chStart
                   else
                   if Assigned(InternalClicked(X,Y,chEnd)) then
                      IHandle:=chEnd;
                 end;

                 ParentChart.CancelMouse:=True;
               end
               else
               begin
                 { un-select }
                 ISelected:=nil;

                 if EnableDraw then
                 begin
                   IDrawing:=True;
                   FromPoint:=TeePoint(X,Y);
                   ToPoint:=FromPoint;
                   if not ((ParentChart.Canvas is TAntiAliasCanvas)
                   {$IFNDEF BCB}
                   or (ParentChart.Canvas is TGDIPlusCanvas)
                   {$ENDIF}) then
                      RedrawLine(ISelected);
                   ParentChart.CancelMouse:=True;
                 end;
               end;
             end;
    cmeMove: if IDrawing or (IHandle<>chNone) then // drawing or dragging
             begin
               if (ParentChart.Canvas is TAntiAliasCanvas)
               {$IFNDEF BCB}
               or (ParentChart.Canvas is TGDIPlusCanvas)
               {$ENDIF} then
                Repaint
               else
                RedrawLine(ISelected); // hide previous line

               if IDrawing then ToPoint:=TeePoint(X,Y)
               else
               begin
                 if IHandle=chStart then FromPoint:=TeePoint(X,Y)
                 else
                 if IHandle=chEnd then ToPoint:=TeePoint(X,Y)
                 else
                 if IHandle=chSeries then
                 begin
                   Inc(FromPoint.X,X-IPoint.X);
                   Inc(FromPoint.Y,Y-IPoint.Y);
                   Inc(ToPoint.X,X-IPoint.X);
                   Inc(ToPoint.Y,Y-IPoint.Y);
                   IPoint:=TeePoint(X,Y);
                 end;
               end;

               if Assigned(ISelected) then
               begin
                ISelected.StartPos:=ScreenPoint(FromPoint);
                ISelected.EndPos:=ScreenPoint(ToPoint);
               end;

               if not ((ParentChart.Canvas is TAntiAliasCanvas)
               {$IFNDEF BCB}
               or (ParentChart.Canvas is TGDIPlusCanvas)
               {$ENDIF}) then
                RedrawLine(ISelected);  // show line at new position

               ParentChart.CancelMouse:=True;

               IMoved:=True;

               // call event
               if Assigned(FOnDragLine) then FOnDragLine(Self);
             end
             else
             if FEnableSelect then { change the cursor if mouse is over lines }
                ParentChart.CancelMouse:=CheckCursor;

      cmeUp: if AButton=FButton then
             begin
               // if dragging...
               if (IHandle<>chNone) and Assigned(ISelected) then // 7.02
               begin
                 if (IHandle=chStart) or (IHandle=chSeries) then
                    ISelected.StartPos:=ScreenPoint(FromPoint);

                 if (IHandle=chEnd) or (IHandle=chSeries) then
                    ISelected.EndPos:=ScreenPoint(ToPoint);

                 IHandle:=chNone;

                 // stop dragging, repaint
                 Repaint;

                 // call event
                 if IMoved then // TVC52010342
                 begin
                   IMoved:=False;

                   if Assigned(FOnDraggedLine) then
                      FOnDraggedLine(Self); { 5.01 }
                 end;
               end
               else
               if IDrawing then  // if drawing a new line...
               begin
                 if (FromPoint.X<>ToPoint.X) or (FromPoint.Y<>ToPoint.Y) then
                 begin
                   // create the new drawn line...
                   tmpLine:=TeeDrawLineClass.Create(Lines);
                   with tmpLine do // 5.02
                   begin
                     StartPos:=ScreenPoint(FromPoint);
                     EndPos  :=ScreenPoint(ToPoint);
                     Style:=Self.Style;
                   end;

                   if SelectNewLines then  // 7.05
                   begin
                     SetSelection(tmpLine);
                     ISelected:=tmpLine;
                   end;

                   // repaint chart
                   Repaint;

                   // call event
                   if Assigned(FOnNewLine) then FOnNewLine(Self);
                 end;

                 IDrawing:=False;
               end;
             end;
  end;
end;

class function TDrawLineTool.Description: String;
begin
  result:=TeeMsg_DrawLineTool;
end;

class function TDrawLineTool.LongDescription: String;
begin
  result:=TeeMsg_DrawLineDesc;
end;

{$IFNDEF CLR}
type
  TCustomTeePanelAccess=class(TCustomAxisPanel);
{$ENDIF}

procedure TDrawLineTool.RedrawLine(ALine:TDrawLine);
var tmp    : TColor;
    tmpPen : TChartPen;
begin
  // draw current selected or dragged line with "not xor" pen mode
  With ParentChart.Canvas do
  begin
    tmp:=ColorToRGB({$IFNDEF CLR}TCustomTeePanelAccess{$ENDIF}(ParentChart).GetBackColor);

    if Assigned(ALine) and Assigned(ALine.FPen) then
       tmpPen:=ALine.Pen
    else
       tmpPen:=Self.Pen;

    Brush.Style:=bsClear;
    BackMode:=cbmTransparent;

    if (ParentChart.Canvas is TAntiAliasCanvas)
    {$IFNDEF BCB}
    or (ParentChart.Canvas is TGDIPlusCanvas)
    {$ENDIF} then
      AssignVisiblePenColor(tmpPen, tmpPen.Color)
    else
    begin
      AssignVisiblePenColor(tmpPen,(clWhite-tmp) xor tmpPen.Color);
      Pen.Mode:=pmNotXor;
    end;

    try
      if Assigned(ALine) then
         DrawLine(AxisPoint(ALine.StartPos),AxisPoint(ALine.EndPos),ALine.Style)
      else
         DrawLine(FromPoint,ToPoint,Self.Style);

    finally
      Pen.Mode:=pmCopy;
    end;
  end;
end;

class function TDrawLineTool.GetEditorClass: String;
begin
  result:='TDrawLineEdit';
end;

function TDrawLineTool.AxisPoint(const P: TFloatPoint): TPoint;
begin
  // convert from axis double XY to screen pixels XY
  result.X:=GetHorizAxis.CalcPosValue(P.X);
  result.Y:=GetVertAxis.CalcPosValue(P.Y);
end;

function TDrawLineTool.ScreenPoint(const P: TPoint): TFloatPoint;
begin
  // convert from screen pixels XY position to axis double XY
  result.X:=GetHorizAxis.CalcPosPoint(P.X);
  result.Y:=GetVertAxis.CalcPosPoint(P.Y);
end;

procedure TDrawLineTool.SetEnableSelect(Value: Boolean);
begin
  if FEnableSelect<>Value then
  begin
    FEnableSelect:=Value;
    if not FEnableSelect then
    begin
      if Assigned(ISelected) then
      begin
        ISelected:=nil;
        Repaint;
      end;
    end;
  end;
end;

procedure TDrawLineTool.DeleteSelected;
begin
  if Assigned(ISelected) then
  begin
    IDrawing:=False; // 5.02
    IHandle:=chNone; // 5.02
    FreeAndNil(ISelected);
    Repaint;
  end;
end;

procedure TDrawLineTool.SetSelected(Value: TDrawLine);
begin
  ISelected:=Value;
  Repaint;
end;

procedure TDrawLineTool.SetLines(const Value: TDrawLines);
begin
  FLines.Assign(Value);
end;

{ TNearestTool }
Constructor TNearestTool.Create(AOwner: TComponent);
begin
  inherited;
  FLinePen:=CreateChartPen;
  Point:=-1;
  FullRepaint:=True;
  Brush.Style:=bsClear;
  Pen.Style:=psDot;
  Pen.Color:=clWhite;
  FSize:=20;
  FStyle:=hsCircle;
end;

Destructor TNearestTool.Destroy;
begin
  FLinePen.Free;
  inherited;
end;

procedure TNearestTool.Assign(Source:TPersistent);
begin
  if Source is TNearestTool then
  with TNearestTool(Source) do
  begin
    Self.FFullRepaint:=FFullRepaint;
    Self.LinePen.Assign(LinePen);
    Self.FSize:=FSize;
    Self.FStyle:=FStyle;
  end;

  inherited;
end;

function TNearestTool.ZAxisCalc(const Value:Double):Integer;
begin
  result:=Series.ParentChart.Axes.Depth.CalcPosValue(Value);
end;

Function TNearestTool.GetDrawLine:Boolean;
begin
  result:=LinePen.Visible;
end;

procedure TNearestTool.SetDrawLine(const Value: Boolean);
begin
  LinePen.Visible:=Value;
end;

procedure TNearestTool.SetLinePen(const Value: TChartPen);
begin
  FLinePen.Assign(Value);
end;

type
  TSeriesAccess=class(TChartSeries);

procedure TNearestTool.PaintHint;
var x : Integer;
    y : Integer;
    R : TRect;
    P : TFourPoints;
    tmpZ : Integer;
    tmpPen : TChartPen;
begin
  if Assigned(Series) and Series.Active and (Point<>-1) and (Series.Count>Point) then
  With ParentChart.Canvas do
  begin
    if not FullRepaint then
       AssignVisiblePenColor(Self.Pen,
               (clWhite-ColorToRGB(ParentChart.Color)) xor Self.Pen.Color)
    else
       AssignVisiblePen(Self.Pen);

    if not FullRepaint then
       Pen.Mode:=pmNotXor;

    TSeriesAccess(Series).CalcSelectionPos(Point,X,Y);

    if Series.HasZValues then
       tmpZ:=ZAxisCalc(Series.GetYValueList('Z').Value[Point])
    else
       tmpZ:=Series.StartZ;

    if Self.Style<>hsNone then
    begin
      AssignBrush(Self.Brush,clBlack);

      // This should be done here, after setting the Brush
      BackMode:=cbmTransparent;

      Case Self.Style of
        hsCircle: if ParentChart.View3D then
                     EllipseWithZ(x-FSize,y-FSize,x+FSize,y+FSize,tmpZ)
                  else
                     Ellipse(x-FSize,y-FSize,x+FSize,y+FSize);

     hsRectangle: begin
                    R:=TeeRect(x-FSize,y-FSize,x+FSize,y+FSize);
                    if ParentChart.View3D then RectangleWithZ(R,tmpZ)
                                          else Rectangle(R);
                  end;
       hsDiamond: begin
                    P[0]:=TeePoint(x,y-FSize);
                    P[1]:=TeePoint(x+FSize,y);
                    P[2]:=TeePoint(x,y+FSize);
                    P[3]:=TeePoint(x-FSize,y);
                    PolygonWithZ(P,tmpZ);
                  end;
        hsSeries: begin
                    tmpPen:=TChartPen.Create(nil);
                    tmpPen.Assign(Series.Pen);
                    Series.Pen:=Self.Pen;
                    TSeriesAccess(Series).DrawValue(Point);
                    Series.Pen:=tmpPen;
                    tmpPen.Free;
                  end;
      end;

    end;

    if DrawLine then
    begin
      AssignVisiblePen(Self.LinePen);

      if not FullRepaint then
         Pen.Mode:=pmNotXor;

      MoveTo(IMouse.X,IMouse.Y);

      if ParentChart.View3D then
         LineTo3D(x,y,tmpZ)
      else
         LineTo(x,y);
    end;

    if not FullRepaint then
       Pen.Mode:=pmCopy;
  end;
end;

class Function TNearestTool.GetNearestPoint(Series:TChartSeries; X,Y:Integer):Integer;
begin
  result:=GetNearestPoint(Series,X,Y,False);
end;

class Function TNearestTool.GetNearestPoint(Series:TChartSeries; X,Y:Integer; IncludeNulls:Boolean):Integer;
var t      : Integer;
    Dif    : Integer;
    Dist   : Integer;
    tmpMin : Integer;
    tmpMax : Integer;
    tmpX   : Integer;
    tmpY   : Integer;
    tmpZList : TChartValueList;
    tmpZ   : Integer;
    tmpHit : Boolean;
begin
  result:=Series.Clicked(X,Y);

  if result=TeeNoPointClicked then
  begin
    Dif:=10000;

    if TeeGetFirstLastSeries(Series,tmpMin,tmpMax) then
    begin
      tmpZList:=Series.GetYValueList('Z'); // 7.0

      for t:=tmpMin to tmpMax do { <-- traverse all points in a Series... }
      if IncludeNulls or (not Series.IsNull(t)) then // 7.0
      begin
        { calculate point Selection Position in pixels }

        TSeriesAccess(Series).CalcSelectionPos(t,tmpX,tmpY);

        if Series.HasZValues then
        begin
          tmpZ:=Series.ParentChart.Axes.Depth.CalcPosValue(tmpZList.Value[t]);

          with Series.ParentChart.Canvas.Calculate3DPosition(tmpX,tmpY,tmpZ) do
          begin
            tmpX:=X;
            tmpY:=Y;
          end;

          tmpHit:=True;
        end
        else
          tmpHit:=PointInRect(Series.ParentChart.ChartRect,tmpX,tmpY);

        if tmpHit then
        begin
          // Calculate distance in pixels...
          Dist:=Round(TeeDistance(X-tmpX,Y-tmpY));

          if Dist<Dif then { store if distance is lower... }
          begin
            Dif:=Dist;
            result:=t;  { <-- set this point to be the nearest... }
          end;
        end;
      end;
    end;
  end;
end;

procedure TNearestTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if (AEvent=cmeMove) and Assigned(Series) then
  begin
    if not FullRepaint then
       PaintHint;

    Point:=GetNearestPoint(Series,X,Y);
    IMouse:=TeePoint(x,y);

    if not FullRepaint then
       PaintHint;

    if Assigned(FOnChange) then
       FOnChange(Self);

    if FullRepaint then
       Repaint;
  end;
end;

procedure TNearestTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if AEvent=cteAfterDraw then
     PaintHint
  else
  if AEvent=cteMouseLeave then
  begin
    if not FullRepaint then
       PaintHint;

    Point:=-1;

    if FullRepaint then
       Repaint;
  end;
end;

class Function TNearestTool.Description:String;
begin
  result:=TeeMsg_NearestTool;
end;

class Function TNearestTool.LongDescription:String;
begin
  result:=TeeMsg_NearestToolDesc;
end;

procedure TNearestTool.SetSize(const Value: Integer);
begin
  SetIntegerProperty(FSize,Value);
end;

class function TNearestTool.GetEditorClass: String;
begin
  result:='TNearestToolEdit';
end;

procedure TNearestTool.SetStyle(const Value: TNearestToolStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Repaint;
  end;
end;

{ TColorBandTool }
Constructor TColorBandTool.Create(AOwner: TComponent);
begin
  inherited;
  FGradient:=TChartGradient.Create(CanvasChanged);
  FColor:=clWhite;
  FCursor:=crDefault;
  FDrawBehind:=True;
  FLineStart:=NewColorLine;
  FLineStart.Active:=False;
  FLineEnd:=NewColorLine;
  FLineEnd.Active:=False;
end;

Destructor TColorBandTool.Destroy;
begin
  FPicture.Free;
  FreeAndNil(FLineStart);
  FreeAndNil(FLineEnd);
  FGradient.Free;
  inherited;
end;

procedure TColorBandTool.Assign(Source:TPersistent);
begin
  if Source is TColorBandTool then
  with TColorBandTool(Source) do
  begin
    Self.FColor:=FColor;
    Self.FCursor:=FCursor;
    Self.FDrawBehind:=FDrawBehind;
    Self.FDrawBehindAxes:=FDrawBehindAxes;
    Self.FEnd:=FEnd;
    Self.Gradient.Assign(Gradient);
    Self.FStart:=FStart;
    Self.FTransparency:=FTransparency;
    Self.EndLine.Assign(EndLine);
    Self.Picture:=FPicture;
    Self.StartLine.Assign(StartLine);
  end;

  inherited;
end;

Function TColorBandTool.NewColorLine:TColorLineTool;
begin
  result:=TColorLineTool.Create(nil);
  result.Active:=False;
  result.DragRepaint:=True;
  result.OnDragLine:=Self.DragLine;
  result.InternalOnEndDragLine:=Self.EndDragLine;
  result.Pen.OnChange:=CanvasChanged;
end;

procedure TColorBandTool.DragLine(Sender:TColorLineTool);
begin
  if Sender.DragRepaint then
     if Sender=FLineStart then StartValue:=Sender.Value
                          else EndValue:=Sender.Value
end;

procedure TColorBandTool.EndDragLine(Sender:TColorLineTool);
begin
  if not Sender.DragRepaint then
     if Sender=FLineStart then StartValue:=Sender.Value
                          else EndValue:=Sender.Value;

  if Assigned(FOnResized) then
     FOnResized(Self);
end;

Function TColorBandTool.BoundsRect:TRect;
var tmp0 : Double;
    tmp1 : Double;
    tmpDraw : Boolean;
begin
  if Assigned(Axis) then
  begin
    result:=ParentChart.ChartRect;

    tmp0:=FStart;
    tmp1:=FEnd;

    With Axis do
    begin
      if Inverted then
      begin
        if tmp0<tmp1 then SwapDouble(tmp0,tmp1);
        tmpDraw:=(tmp1<=Maximum) and (tmp0>=Minimum);
      end
      else
      begin
        if tmp0>tmp1 then SwapDouble(tmp0,tmp1);
        tmpDraw:=(tmp0<=Maximum) and (tmp1>=Minimum);
      end;

      if tmpDraw then
      begin
        if Horizontal then
        begin
          result.Left:=Math.Max(IStartPos,CalcPosValue(tmp0));
          result.Right:=Math.Min(IEndPos,CalcPosValue(tmp1));

          if Self.Pen.Visible then Inc(result.Right);
        end
        else
        begin
          result.Top:=Math.Max(IStartPos,CalcPosValue(tmp1));
          result.Bottom:=Math.Min(IEndPos,CalcPosValue(tmp0));

          Inc(result.Left);
          Inc(result.Bottom);

          if not Self.Pen.Visible then
          begin
            Inc(result.Bottom);
            Inc(result.Right);
          end;
        end;
      end
      else result:=TeeRect(0,0,0,0);
    end;
  end
  else result:=TeeRect(0,0,0,0);
end;

Function TColorBandTool.ZPosition:Integer;
begin
  if DrawBehind then result:=ParentChart.Width3D
                else result:=0; // 5.03
end;

procedure TColorBandTool.PaintBand;
var R    : TRect;
    tmpZ : Integer;

  procedure DrawRectangle;
  begin
    with ParentChart.Canvas do
    if Assigned(FPicture) and Assigned(FPicture.Graphic) then
       if ParentChart.View3D and (not ParentChart.View3DOptions.Orthogonal) then
          StretchDraw(R,FPicture.Filtered,tmpZ)
       else
          StretchDraw(CalcRect3D(R,tmpZ),FPicture.Filtered)
    else
    if ParentChart.View3D then
       RectangleWithZ(R,tmpZ)
    else
       Rectangle(R);
  end;

var tmpR : TRect;
    tmpRectBlend : TRect;
    tmpBlend     : TTeeBlend;
begin
  if Assigned(Axis) then
  begin
    R:=BoundsRect;

    if ((R.Right-R.Left)>0) and ((R.Bottom-R.Top)>0) then
    begin
      With ParentChart.Canvas do
      begin
        AssignBrush(Self.Brush,Self.Color);
        AssignVisiblePen(Self.Pen);

        tmpZ:=ZPosition;

        if Transparency<>0 then // 8.01
        begin
          if ParentChart.View3D then
             tmpRectBlend:=RectFromRectZ(R,tmpZ)
          else
             tmpRectBlend:=R;

          tmpBlend:=ParentChart.Canvas.BeginBlending(tmpRectBlend,Transparency);
        end
        else
          tmpBlend:=nil;

        if Self.Gradient.Visible and View3DOptions.Orthogonal then
        begin
          tmpR:=R;
          Dec(tmpR.Right);
          Dec(tmpR.Bottom);
          Self.Gradient.Draw(ParentChart.Canvas,CalcRect3D(tmpR,tmpZ));
          Brush.Style:=bsClear;
        end;

        DrawRectangle;

        if Assigned(tmpBlend) then
           ParentChart.Canvas.EndBlending(tmpBlend);
      end;

      if FLineEnd.Active then
      begin
        FLineEnd.Value:=EndValue;
        FLineEnd.InternalDrawLine(DrawBehind);
      end;

      if FLineStart.Active then
      begin
        FLineStart.Value:=StartValue;
        FLineStart.InternalDrawLine(DrawBehind);
      end;
    end;
  end;
end;

procedure TColorBandTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  case AEvent of
   cteBeforeDrawAxes: if DrawBehindAxes then PaintBand;
   cteBeforeDrawSeries: if DrawBehind and (not DrawBehindAxes) then PaintBand;
   cteAfterDraw: if (not DrawBehind) and (not DrawBehindAxes) then PaintBand;
  end;
end;

class function TColorBandTool.Description: String;
begin
  result:=TeeMsg_ColorBandTool;
end;

class function TColorBandTool.LongDescription: String;
begin
  result:=TeeMsg_ColorBandDesc;
end;

class function TColorBandTool.GetEditorClass: String;
begin
  result:='TColorBandToolEditor';
end;

procedure TColorBandTool.SetEnd(const Value: Double);
begin
  SetDoubleProperty(FEnd,Value);
  SetLines;
end;

procedure TColorBandTool.SetStart(const Value: Double);
begin
  SetDoubleProperty(FStart,Value);
  SetLines;
end;

procedure TColorBandTool.SetGradient(const Value: TChartGradient);
begin
  FGradient.Assign(Value);
end;

procedure TColorBandTool.SetColor(Value: TColor);
begin
  SetColorProperty(FColor,Value);
end;

procedure TColorBandTool.SetTransparency(const Value: TTeeTransparency);
begin
  if FTransparency<>Value then
  begin
    FTransparency:=Value;
    Repaint;
  end;
end;

procedure TColorBandTool.SetDrawBehind(const Value: Boolean);
begin
  SetBooleanProperty(FDrawBehind,Value);
end;

procedure TColorBandTool.SetDrawBehindAxes(const Value: Boolean);
begin
  SetBooleanProperty(FDrawBehindAxes,Value);
end;

Function TColorBandTool.Clicked(X,Y:Integer):Boolean;
var P : TFourPoints;
begin
  ParentChart.Canvas.FourPointsFromRect(BoundsRect,ZPosition,P);
  result:=PointInPolygon(TeePoint(X,Y),P);
end;

procedure TColorBandTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FLineStart.Active then
     FLineStart.ChartMouseEvent(AEvent,Button,Shift,X,Y);

  if FLineEnd.Active and (not ParentChart.CancelMouse) then
     FLineEnd.ChartMouseEvent(AEvent,Button,Shift,X,Y);

  Case AEvent of
    cmeDown:
        if Assigned(FOnClick) and Clicked(X,Y) then
           FOnClick(Self,Button,Shift,X,Y);
    cmeMove:
      if (Cursor<>crDefault) and (not ParentChart.CancelMouse) then
         if Clicked(x,y) then
         begin
           ParentChart.Cursor:=FCursor;
           ParentChart.CancelMouse:=(not ParentChart.IPanning.Active) and
                                    (not ParentChart.Zoom.Active);
         end;
  end;
end;

function TColorBandTool.GetResizeEnd: Boolean;
begin
  result:=EndLine.Active;
end;

function TColorBandTool.GetResizeStart: Boolean;
begin
  result:=StartLine.Active;
end;

procedure TColorBandTool.SetResizeEnd(const Value: Boolean);
begin
  EndLine.Active:=Value;
  Repaint;
end;

procedure TColorBandTool.SetResizeStart(const Value: Boolean);
begin
  StartLine.Active:=Value;
  Repaint;
end;

procedure TColorBandTool.SetAxis(const Value: TChartAxis);
begin
  inherited;
  FLineEnd.Axis:=Value;
  FLineEnd.ParentChart:=nil;
  FLineStart.Axis:=Value;
  FLineStart.ParentChart:=nil;
end;

procedure TColorBandTool.SetLines;
begin
  FLineEnd.Value:=FEnd;
  FLineStart.Value:=FStart;
end;

procedure TColorBandTool.Loaded;
begin
  inherited;
  SetLines;
end;

procedure TColorBandTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if Assigned(FLineStart) then
     FLineStart.SetParent(ParentChart);

  if Assigned(FLineEnd) then
     FLineEnd.SetParent(ParentChart);
end;

function TColorBandTool.GetEndLinePen: TChartPen;
begin
  result:=EndLine.Pen;
end;

function TColorBandTool.GetStartLinePen: TChartPen;
begin
  result:=StartLine.Pen;
end;

procedure TColorBandTool.SetEndLinePen(const Value: TChartPen);
begin
  EndLine.Pen:=Value;
end;

procedure TColorBandTool.SetStartLinePen(const Value: TChartPen);
begin
  StartLine.Pen:=Value;
end;

Procedure TColorBandTool.PictureChanged(Sender:TObject);
begin
  Repaint;
end;

function TColorBandTool.GetPicture: TTeePicture;
begin
  if not Assigned(FPicture) then
  begin
     FPicture:=TTeePicture.Create;
     FPicture.OnChange:=PictureChanged;
  end;

  result:=FPicture;
end;

procedure TColorBandTool.SetPicture(const Value: TTeePicture);
begin
  if Assigned(Value) then Picture.Assign(Value)
                     else FreeAndNil(FPicture);
end;

{ TColorLineTool }
Constructor TColorLineTool.Create(AOwner: TComponent);
begin
  inherited;
  FAllowDrag:=True;
  FDraw3D:=True;
end;

Procedure TColorLineTool.Assign(Source:TPersistent);
begin
  if Source is TColorLineTool then
  with TColorLineTool(Source) do
  begin
    Self.FAllowDrag:=AllowDrag;
    Self.FDragRepaint:=DragRepaint;
    Self.FDraw3D:=Draw3D;
    Self.FDrawBehind:=DrawBehind;
    Self.FNoLimitDrag:=NoLimitDrag;
    Self.FStyle:=Style;
    Self.FValue:=Value;
  end;

  inherited;
end;

Function TColorLineTool.CalcValue:Double;
begin
  Case Self.FStyle of
    clMaximum: result:=Axis.Maximum;
    clCenter: result:=(Axis.Maximum+Axis.Minimum)*0.5;
    clMinimum: result:=Axis.Minimum;
  else
    result:=FValue;  // clCustom
  end;
end;

// Returns the same AValue parameter if it points to
// inside the axes limits.
// If AValue is outside the limits, it will return the closest
// point value of the ultrapassed edge.
Function TColorLineTool.LimitValue(const AValue:Double):Double;
var tmpLimit : Double;
    tmpStart : Integer;
    tmpEnd   : Integer;
begin
  result:=AValue;

  tmpStart:=Axis.IEndPos; // 6.01 Fix for Inverted axes
  tmpEnd:=Axis.IStartPos;
  if Axis.Horizontal then SwapInteger(tmpStart,tmpEnd);
  if Axis.Inverted then SwapInteger(tmpStart,tmpEnd);

  // do not use Axis Minimum & Maximum, we need the "real" min and max
  tmpLimit:=Axis.CalcPosPoint(tmpStart);
  if result<tmpLimit then result:=tmpLimit
  else
  begin
    tmpLimit:=Axis.CalcPosPoint(tmpEnd);
    if result>tmpLimit then result:=tmpLimit;
  end;
end;

procedure TColorLineTool.SetParent(Value:TCustomAxisPanel);
begin
  IParent:=Value;
end;

Function TColorLineTool.Chart:TCustomAxisPanel;
begin
  result:=IParent;
  if not Assigned(result) then
     result:=ParentChart;
end;

Procedure TColorLineTool.DrawColorLine(Back:Boolean);
var tmp : Integer;
begin
  { check inside axis limits, only when dragging }
  if AllowDrag and (not NoLimitDrag) then  // 7.0 fix
     FValue:=LimitValue(FValue);

  tmp:=Axis.CalcPosValue(CalcValue);

  With Chart,Canvas do
  begin
    if Back then
    begin
      if Axis.Horizontal then
      begin
        if Draw3D then ZLine3D(tmp,ChartRect.Bottom,0,Width3D);
        if DrawBehind or Draw3D then
           VertLine3D(tmp,ChartRect.Top,ChartRect.Bottom,Width3D);
      end
      else
      begin
        if Draw3D then ZLine3D(ChartRect.Left,tmp,0,Width3D);
        if DrawBehind or Draw3D then
           HorizLine3D(ChartRect.Left,ChartRect.Right,tmp,Width3D);
      end;
    end
    else
    if View3D or ((not IDragging) or FDragRepaint) then
      if Axis.Horizontal then
      begin
        if Draw3D then ZLine3D(tmp,ChartRect.Top,0,Width3D);
        if not DrawBehind then
           VertLine3D(tmp,ChartRect.Top,ChartRect.Bottom,0);
      end
      else
      begin
        if Draw3D then ZLine3D(ChartRect.Right,tmp,0,Width3D);
        if not DrawBehind then
           HorizLine3D(ChartRect.Left,ChartRect.Right,tmp,0);
      end;
  end;
end;

procedure TColorLineTool.InternalDrawLine(Back:Boolean);
begin
  Chart.Canvas.AssignVisiblePen(Pen);
  Chart.Canvas.BackMode:=cbmTransparent;  // 5.03
  DrawColorLine(Back);
end;

procedure TColorLineTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if Assigned(Axis) and
     ((AEvent=cteBeforeDrawSeries) or (AEvent=cteAfterDraw)) then
       InternalDrawLine(AEvent=cteBeforeDrawSeries);
end;

procedure TColorLineTool.DoEndDragLine;
begin
  if Assigned(InternalOnEndDragLine) then InternalOnEndDragLine(Self);
  if Assigned(FOnEndDragLine) then FOnEndDragLine(Self);
end;

procedure TColorLineTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp       : Integer;
    tmpNew    : Double;
    tmpDoDraw : Boolean;
begin
  tmpDoDraw:=False;

  if AllowDrag and Assigned(Axis) then
  Case AEvent of
      cmeUp: if IDragging then  // 7.0
             begin
               { force repaint }
               if not FDragRepaint then Repaint;

               { call event }
               DoEndDragLine;

               IDragging:=False;
             end;
    cmeMove: if IDragging then
             begin
               if Axis.Horizontal then tmp:=x else tmp:=y;

               { calculate new position }
               tmpNew:=Axis.CalcPosPoint(tmp);

               { check inside axis limits }
               if not NoLimitDrag then  // (already implicit AllowDrag=True)
                  tmpNew:=LimitValue(tmpNew);

               if FDragRepaint then { 5.02 }
                  Value:=tmpNew { force repaint whole chart }
               else
               begin

                 tmpDoDraw:=CalcValue<>tmpNew;

                 if tmpDoDraw then
                 begin
                   { draw line in xor mode, to avoid repaint the whole chart }
                   with Chart.Canvas do
                   begin
                     AssignVisiblePen(Self.Pen);
                     Pen.Mode:=pmNotXor;
                   end;

                   { hide previous line }
                   DrawColorLine(True);
                   DrawColorLine(False);

                   { set new value }
                   FStyle:=clCustom;
                   FValue:=tmpNew;
                 end;
               end;

               Chart.CancelMouse:=True;

               { call event, allow event to change Value }
               if Assigned(FOnDragLine) then FOnDragLine(Self);

               if tmpDoDraw then { 5.02 }
               begin
                 { draw at new position }
                 DrawColorLine(True);
                 DrawColorLine(False);

                 { reset pen mode }
                 Chart.Canvas.Pen.Mode:=pmCopy;
               end;
             end
             else
             begin
               { is mouse on line? }
               if Clicked(x,y) then { 5.02 }
               begin
                 { show appropiate cursor }
                 if Axis.Horizontal then
                    Chart.Cursor:=crHSplit
                 else
                    Chart.Cursor:=crVSplit;
                 Chart.CancelMouse:=True;
               end
               else
                  Chart.Cursor:=crDefault;  // TA05013030
             end;
    cmeDown: if Button=mbLeft then
             begin
               { is mouse over line ? }
               IDragging:=Clicked(x,y);
               Chart.CancelMouse:=IDragging;

               if IDragging and Assigned(FOnBeginDragLine) then // 7.0
                  FOnBeginDragLine(Self);
             end;
  end;
end;

function TColorLineTool.Clicked(x, y: Integer): Boolean;
var tmp : Integer;
begin
  if Axis.Horizontal then tmp:=x else tmp:=y;

  result:=Abs(tmp-Axis.CalcPosValue(CalcValue))<TeeClickTolerance;

  if result then { 5.02 }
  with Chart do
     if Axis.Horizontal then
        result:=(y>=ChartRect.Top) and (y<=ChartRect.Bottom)
     else
        result:=(x>=ChartRect.Left) and (x<=ChartRect.Right)
end;

class function TColorLineTool.Description: String;
begin
  result:=TeeMsg_ColorLineTool;
end;

class function TColorLineTool.LongDescription: String;
begin
  result:=TeeMsg_ColorLineDesc;
end;

class function TColorLineTool.GetEditorClass: String;
begin
  result:='TColorLineToolEditor';
end;

procedure TColorLineTool.SetValue(const AValue: Double);
begin
  if not (csReading in ComponentState) then
     FStyle:=clCustom;

  if (not IDragging) or FDragRepaint then { 5.02 }
     SetDoubleProperty(FValue,AValue)
  else
     FValue:=AValue;
end;

procedure TColorLineTool.SetDraw3D(const Value: Boolean);
begin
  SetBooleanProperty(FDraw3D,Value);
end;

procedure TColorLineTool.SetDrawBehind(const Value: Boolean);
begin
  SetBooleanProperty(FDrawBehind,Value);
end;

procedure TColorLineTool.SetStyle(const Value: TColorLineStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;
    Repaint;
  end;
end;

{$IFNDEF CLR}
type
  TChartPenAccess=class(TChartPen);
{$ENDIF}

{ TRotateTool }

Constructor TRotateTool.Create(AOwner: TComponent);
begin
  inherited;
  FButton:=mbLeft;
  IDragging:=False;
  FInverted:=False;
  FStyle:=rsAll;
  FSpeed:=50;
  FCursor:=crTeeHand;

  Pen.Hide;

  {$IFNDEF CLR}TChartPenAccess{$ENDIF}(Pen).DefaultVisible:=False;

  Pen.Mode:=pmXor;
  Pen.Color:=clWhite;
end;

Destructor TRotateTool.Destroy;
begin
  FreeAndNil(ITimer);
  inherited;
end;

procedure TRotateTool.Assign(Source:TPersistent);
begin
  if Source is TRotateTool then
  with TRotateTool(Source) do
  begin
    Self.FButton   :=Button;
    Self.FInertia  :=FInertia;
    Self.FInverted :=Inverted;
    Self.FSpeed    :=Speed;
    Self.FStyle    :=Style;
  end;

  inherited;
end;

class Function TRotateTool.RotationChange(FullRotation:Boolean; const AAngle,AChange:Double):Double;
begin
  result:=AAngle;
  if AChange=0 then exit;

  if AChange>0 then
  begin
    result:=result+AChange;

    if result>360 then
       result:=result-360
  end
  else
  begin
    if FullRotation then
       result:=Math.Max(0,AAngle+AChange)
    else
    begin
      result:=AAngle+AChange;

      if result<0 then
         result:=360+result
    end;
  end;
end;

class Function TRotateTool.ElevationChange(FullRotation:Boolean; const AAngle,AChange:Double):Double;
var tmpMinAngle : Integer;
begin
  result:=AAngle;
  if AChange=0 then exit;

  if AChange>0 then
     result:=Math.Min(360,AAngle+AChange)
  else
  begin
    if FullRotation then tmpMinAngle:=0
                    else tmpMinAngle:=TeeMinAngle;
    result:=Math.Max(tmpMinAngle,AAngle+AChange);
  end;
end;

procedure TRotateTool.Rotate(const RotationDegrees,ElevationDegrees:Double);
begin
  if Assigned(ParentChart) then
  with ParentChart.View3DOptions do
  begin
    RotationFloat:=RotationFloat+RotationDegrees;
    ElevationFloat:=ElevationFloat+ElevationDegrees;
  end;
end;

procedure TRotateTool.DoRotation(const IDifX,IDifY:Double);

  Function CorrectAngle(Const AAngle:Double):Double;
  begin
    result:=AAngle;
    if result>360 then result:=result-360 else
    if result<0 then result:=360+result;
  end;

begin
  With ParentChart.View3DOptions do
  begin
    Orthogonal:=False;

    if ParentChart.Canvas.SupportsFullRotation then
    begin
      if (FStyle=rsRotation) or (FStyle=rsAll) then
         RotationFloat:=CorrectAngle(RotationFloat+IDifX);

      if (FStyle=rsElevation) or (FStyle=rsAll) then
         ElevationFloat:=CorrectAngle(ElevationFloat+IDifY);
    end
    else
    begin
      if (FStyle=rsRotation) or (FStyle=rsAll) then
      begin
        // FirstSeriesPie
        RotationFloat:=RotationChange(ParentChart.Canvas.SupportsFullRotation,RotationFloat,IDifX);
      end;

      if (FStyle=rsElevation) or (FStyle=rsAll) then
         ElevationFloat:=ElevationChange(ParentChart.Canvas.SupportsFullRotation,ElevationFloat,IDifY);
    end;
  end;
end;

type
  TCanvas3DAccess=class(TCanvas3D);
  TTeeCanvas3DAccess=class(TTeeCanvas3D);

procedure TRotateTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);

  Procedure MouseMove(X,Y:Integer);

    Procedure DrawCubeOutline;
    var w : Integer;
    begin
      with ParentChart.Canvas do
      begin
        Brush.Style:=bsClear;
        AssignVisiblePen(Self.Pen);

        w:=ParentChart.Width3D;

        RectangleWithZ(ParentChart.ChartRect,0);
        RectangleWithZ(ParentChart.ChartRect,w);

        with ParentChart.ChartRect do
        begin
          MoveTo3D(Left,Top,0);
          LineTo3D(Left,Top,W);
          MoveTo3D(Right,Top,0);
          LineTo3D(Right,Top,W);
          MoveTo3D(Left,Bottom,0);
          LineTo3D(Left,Bottom,W);
          MoveTo3D(Right,Bottom,0);
          LineTo3D(Right,Bottom,W);
        end;
      end;
    end;

  var tmpSpeed : Double;
  begin
    tmpSpeed:=(1.0+(Speed-50)*0.01);

    IDifX:=tmpSpeed*(90.0*(X-IOldX)/ParentChart.Width);
    if FInverted then IDifX:=-IDifX;

    IDifY:=tmpSpeed*(90.0*(IOldY-Y)/ParentChart.Height);
    if FInverted then IDifY:=-IDifY;

    if Pen.Visible then
    begin
      if IFirstTime then
      begin
        IOldRepaint:=ParentChart.AutoRepaint;
        ParentChart.AutoRepaint:=False;
        IFirstTime:=False;
      end
      else DrawCubeOutline;
    end;

    ParentChart.View3D:=True;

    DoRotation(IDifX,IDifY);

    IOldX:=X;
    IOldY:=Y;

    ParentChart.CancelMouse:=True;

    if Pen.Visible then
    begin
      TCanvas3DAccess(ParentChart.Canvas).FIsOrthogonal:=False;  // 6.01

      if ParentChart.Canvas is TTeeCanvas3D then
      begin
        TTeeCanvas3DAccess(ParentChart.Canvas).CalcTrigValues;
        TTeeCanvas3DAccess(ParentChart.Canvas).CalcPerspective(ParentChart.ChartRect);
      end;

      DrawCubeOutline;
    end;

    if Assigned(FOnRotate) then
       FOnRotate(Self);
  end;

begin
  inherited;

  Case AEvent of
      cmeUp: if IDragging then
             begin
               IDragging:=False;

               if Pen.Visible then
               begin
                 ParentChart.AutoRepaint:=IOldRepaint;
                 Repaint;
               end;

               if Inertia>0 then
               begin
                 if not Assigned(ITimer) then
                 begin
                   ITimer:=TTimer.Create(nil);
                   ITimer.OnTimer:=DoTimer;
                 end;

                 ITimer.Interval:=1;
                 ITimer.Enabled:=True;
               end;

               if FCursor<>crDefault then
                  Screen.Cursor:=IOldCursor;
             end;

    cmeMove: if IDragging then
                MouseMove(X,Y);

    cmeDown: if AButton=Self.Button then
             begin
               if Assigned(ITimer) then
                  ITimer.Enabled:=False;

               IDragging:=True;
               IOldX:=X;
               IOldY:=Y;
               IFirstTime:=True;

               if FCursor<>crDefault then
               begin
                 IOldCursor:=Screen.Cursor;
                 Screen.Cursor:=FCursor;
               end;

               ParentChart.CancelMouse:=True;
             end;
  end;
end;

class function TRotateTool.Description: String;
begin
  result:=TeeMsg_RotateTool;
end;

class function TRotateTool.LongDescription: String;
begin
  result:=TeeMsg_RotateDesc;
end;

class function TRotateTool.GetEditorClass: String;
begin
  result:='TRotateToolEditor';
end;

procedure TRotateTool.DoTimer(Sender: TObject);
begin
  ITimer.Enabled:=False;

  if not IDragging then
  begin
    DoRotation(IDifX,IDifY);
    ITimer.Enabled:=True;
  end;
end;

procedure TRotateTool.ChartEvent(AEvent: TChartToolEvent);
const
  Level = 0.01;
  MinInc = 0.02;
var tmp : Double;
begin
  inherited;

  if Inertia>0 then
  begin
    if (Abs(IDifX)>Level) or (Abs(IDifY)>Level) then
    begin
      tmp:=(100-Inertia)*0.001;

      if Abs(IDifX)>Level then
         IDifX:=IDifX-(IDifX*tmp)
      else
         IDifX:=0;

      if Abs(IDifY)>Level then
         IDifY:=IDifY-(IDifY*tmp)
      else
         IDifY:=0;
    end
    else
    if Assigned(ITimer) then
       ITimer.Enabled:=False;
  end;
end;

{ TChartImageTool }

Constructor TChartImageTool.Create(AOwner: TComponent);
begin
  inherited;
  FPicture:=TTeePicture.Create;
  FPicture.OnChange:=CanvasChanged;
  Pen.Hide;
end;

Destructor TChartImageTool.Destroy;
begin
  FPicture.Free;
  inherited;
end;

procedure TChartImageTool.Assign(Source:TPersistent);
begin
  if Source is TChartImageTool then
     FPicture.Assign(TChartImageTool(Source).FPicture);

  inherited;
end;

procedure TChartImageTool.ChartEvent(AEvent: TChartToolEvent);
var R   : TRect;
    tmp : TGraphic;
begin
  inherited;

  if (AEvent=cteBeforeDrawSeries) and Assigned(FPicture) and
     Assigned(FPicture.Graphic)  then
  begin
    if Assigned(Series) then
    With Series do
    begin
      R.Left:=CalcXPosValue(MinXValue);
      R.Right:=CalcXPosValue(MaxXValue);
      R.Top:=CalcYPosValue(MaxYValue);
      R.Bottom:=CalcYPosValue(MinYValue);
    end
    else
    begin
      With GetHorizAxis do
      begin
        R.Left:=CalcPosValue(Minimum);
        R.Right:=CalcPosValue(Maximum);
      end;
      With GetVertAxis do
      begin
        R.Top:=CalcYPosValue(Maximum);
        R.Bottom:=CalcYPosValue(Minimum);
      end;
    end;

    With ParentChart,Canvas do
    begin
      if CanClip then
         ClipCube(ChartRect,0,Width3D);

      tmp:=FPicture.Filtered;

      if View3D and (not View3DOptions.Orthogonal) then
         StretchDraw(R,tmp,Width3D)
      else
         StretchDraw(CalcRect3D(R,Width3D),tmp);

      if Self.Pen.Visible then
      begin
        AssignVisiblePen(Self.Pen);

        if View3D then
           RectangleWithZ(R,Width3D)
        else
           Rectangle(R);
      end;

      UnClipRectangle;
    end;
  end;
end;

class function TChartImageTool.Description: String;
begin
  result:=TeeMsg_ImageTool;
end;

class function TChartImageTool.LongDescription: String;
begin
  result:=TeeMsg_ImageToolDesc;
end;

class function TChartImageTool.GetEditorClass: String;
begin
  result:='TChartImageToolEditor';
end;

procedure TChartImageTool.SetPicture(const Value: TTeePicture);
begin
  FPicture.Assign(Value);
end;

procedure TChartImageTool.SetSeries(const Value: TChartSeries);
begin
  inherited;
  Repaint;
end;

{ TMarksToolTip }
constructor TMarksTipTool.Create(AOwner: TComponent);
begin
  inherited;
  FStyle:=smsLabel;
end;

procedure TMarksTipTool.Assign(Source:TPersistent);
begin
  if Source is TMarksTipTool then
  begin
    FMouseAction:=TMarksTipTool(Source).MouseAction;
    FStyle      :=TMarksTipTool(Source).Style;
  end;

  inherited;
end;

procedure TMarksTipTool.DoCancelHint;
var tmp : Boolean;
begin
  if Chart<>nil then
  begin
    if Assigned(FOnCancel) then
       FOnCancel(Self);

    tmp:=Chart.Hint<>'';
    Chart.Hint:='';

    if tmp then
       Application.CancelHint;
  end;
end;

Procedure TMarksTipTool.ChartEvent(AEvent:TChartToolEvent);
var
  tmpCanvas : ICanvasToolTips;

  procedure AddTips(ASeries:TChartSeries);
  var t : Integer;
      oldStyle  : TSeriesMarksStyle;
      tmpName   : String;
      tmpText   : String;
  begin
    oldStyle:=ASeries.Marks.Style;
    ASeries.Marks.Style:=FStyle;
    try
      tmpName:=SeriesNameOrIndex(ASeries);

      for t:=ASeries.FirstValueIndex to ASeries.LastValueIndex do
      begin
        tmpText:=ASeries.ValueMarkText[t];

        if Assigned(FOnGetText) then
           FOnGetText(Self,tmpText);

        tmpCanvas.AddToolTip(tmpName+'_'+TeeStr(t),tmpText);
      end;
    finally
      ASeries.Marks.Style:=oldStyle;
    end;
  end;

var t : Integer;
begin
  inherited;

  if AEvent=cteAfterDraw then
     if Supports(ParentChart.Canvas,ICanvasToolTips) then
     begin
       tmpCanvas:=(ParentChart.Canvas as ICanvasToolTips);

       if Assigned(Series) then
          AddTips(Series)
       else
       for t:=0 to ParentChart.SeriesCount-1 do
          AddTips(ParentChart[t]);
     end;
end;

procedure TMarksTipTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tmp       : Integer;
    tmpSeries : TChartSeries;

  Procedure FindClickedSeries;
  var t : Integer;
      tmpClickedSeries : TChartSeries;
  begin
    for t:=ParentChart.SeriesCount-1 downto 0 do // 6.01
    begin
      tmpClickedSeries:=ParentChart[t];

      if tmpClickedSeries.Active then
      begin
        tmp:=tmpClickedSeries.Clicked(x,y);

        if tmp<>-1 then
        begin
          tmpSeries:=tmpClickedSeries;
          break;
        end;
      end;
    end;
  end;

var tmpStyle  : TSeriesMarksStyle;
    tmpOld    : Boolean;
    tmpText   : String;
    t         : Integer;
    tmpCancel : Boolean;
begin
  inherited;

  // The canvas does the tooltips, so we exit here.
  if Supports(ParentChart.Canvas,ICanvasToolTips) then
     Exit;

  if ((MouseAction=mtmMove) and (AEvent=cmeMove)) or
     ((MouseAction=mtmClick) and (AEvent=cmeDown)) then
  begin
    tmpSeries:=nil;
    tmp:=-1;
    
    { find which series is under XY }
    if Assigned(Series) then
    begin
      tmpSeries:=Series;
      tmp:=tmpSeries.Clicked(x,y);
    end
    else FindClickedSeries; { 5.02 }

    { if not ok then cancel hint... }
    if tmp=-1 then
    begin
      tmpCancel:=True;

      { do not cancel if other MarkTipTools exist... }
      for t:=0 to Chart.Tools.Count-1 do
      if (Chart.Tools[t]<>Self) and
         (Chart.Tools[t] is TMarksTipTool) then { 5.01 }
      begin
        tmpCancel:=False;
        break;
      end;

      if tmpCancel then
         DoCancelHint;
    end
    else
    begin
      { show hint ! }
      tmpStyle:=tmpSeries.Marks.Style;
      tmpOld:=Chart.AutoRepaint;
      Chart.AutoRepaint:=False;

      tmpSeries.Marks.Style:=FStyle;
      try
        tmpText:=tmpSeries.ValueMarkText[tmp];

        if Assigned(FOnGetText) then
           FOnGetText(Self,tmpText);

        if Chart.Hint<>tmpText then
        begin
          Application.CancelHint;  {7.07   TV52010024}
          Chart.ShowHint:=True; { 5.02 }
          Chart.Hint:=tmpText;
          {$IFDEF D5}
          Application.ActivateHint(Chart.ClientToScreen(TeePoint(X,Y)));
          {$ENDIF}
        end;
      finally
        tmpSeries.Marks.Style:=tmpStyle;
        Chart.AutoRepaint:=tmpOld;
      end;
    end;
  end;
end;

class function TMarksTipTool.Description: String;
begin
  result:=TeeMsg_MarksTipTool;
end;

class function TMarksTipTool.LongDescription: String;
begin
  result:=TeeMsg_MarksTipDesc;
end;

class function TMarksTipTool.GetEditorClass: String;
begin
  result:='TMarksTipToolEdit';
end;

Function TMarksTipTool.Chart:TCustomChart;
begin
  if Assigned(Series) then result:=TCustomChart(Series.ParentChart)
                      else result:=TCustomChart(ParentChart);
end;

procedure TMarksTipTool.SetActive(Value: Boolean);
begin
  inherited;

  if not Active then
     DoCancelHint;
end;

procedure TMarksTipTool.SetMouseAction(Value: TMarkToolMouseAction);
begin
  FMouseAction:=Value;
  DoCancelHint;
end;

function TMarksTipTool.GetMouseDelay: Integer;
begin
  result:=Application.HintPause;
end;

procedure TMarksTipTool.SetMouseDelay(const Value: Integer);
begin
  Application.HintPause:=Value;
end;

function TMarksTipTool.GetHideDelay: Integer;
begin
  result:=Application.HintHidePause;
end;

procedure TMarksTipTool.SetHideDelay(const Value: Integer);
begin
  Application.HintHidePause:=Value;
end;

{ TAnnotationCallout }
Constructor TAnnotationCallout.Create(AOwner: TChartSeries);
begin
  inherited;
  Arrow.Hide;
  Visible:=False;
end;

procedure TAnnotationCallout.Assign(Source: TPersistent);
begin
  if Source is TAnnotationCallout then
  With TAnnotationCallout(Source) do
  begin
    Self.FX:=XPosition;
    Self.FY:=YPosition;
    Self.FZ:=ZPosition;
  end;
  inherited;
end;

procedure TAnnotationCallout.SetX(const Value: Integer);
begin
  if FX<>Value then
  begin
    FX:=Value;
    Repaint;
  end;
end;

procedure TAnnotationCallout.SetY(const Value: Integer);
begin
  if FY<>Value then
  begin
    FY:=Value;
    Repaint;
  end;
end;

procedure TAnnotationCallout.SetZ(const Value: Integer);
begin
  if FZ<>Value then
  begin
    FZ:=Value;
    Repaint;
  end;
end;

function TAnnotationCallout.CloserPoint(const R: TRect;
  const P: TPoint): TPoint;
var tmpX : Integer;
    tmpY : Integer;
begin
  if P.X>R.Right then tmpX:=R.Right
  else
  if P.X<R.Left then tmpX:=R.Left
  else
     tmpX:=(R.Left+R.Right) div 2;

  if P.Y>R.Bottom then tmpY:=R.Bottom
  else
  if P.Y<R.Top then tmpY:=R.Top
  else
     tmpY:=(R.Top+R.Bottom) div 2;

  result:=TeePoint(tmpX,tmpY);
end;

{ TAnnotationTool }
Constructor TAnnotationTool.Create(AOwner: TComponent);
begin
  inherited;
  FShape:=TTextShape.Create(nil);
  FCallout:=TAnnotationCallout.Create(nil);
  FPosition:=ppLeftTop;
  FPositionUnits:=muPixels;
end;

Destructor TAnnotationTool.Destroy;
begin
  FreeAndNil(FCallout);
  FreeAndNil(FShape);
  inherited;
end;

procedure TAnnotationTool.Assign(Source:TPersistent); // 7.07
begin
  if Source is TAnnotationTool then
  with TAnnotationTool(Source) do
  begin
    Self.FCallout.Assign(FCallout);
    Self.FPosition :=FPosition;
    Self.FPositionUnits:=FPositionUnits;
    Self.FShape.Assign(FShape);
  end;

  inherited;
end;

procedure TAnnotationTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if AEvent=cteAfterDraw then
  begin
    if Assigned(FOnBeforeDraw) then
       FOnBeforeDraw(Self);

    DrawText;

    if Assigned(FOnAfterDraw) then
       FOnAfterDraw(Self);
  end;
end;

Function TAnnotationTool.GetText:String;
begin
  result:=Shape.Text;
end;

procedure TAnnotationTool.SetText(const Value: String);
begin
  Shape.Text:=Value;
end;

function TAnnotationTool.GetXOffset:Integer;
begin // nothing here. See TBannerTool.
  result:=0;
end;

procedure TAnnotationTool.DrawText;
var tmpTo     : TPoint;
    tmpMid    : TPoint;
    tmpFrom   : TPoint;
    tmpR      : TRect;
    tmpN,
    tmpX,
    tmpY      : Integer;
begin
  Shape.Text:=GetText;
  tmpR:=GetTextBounds(tmpN,tmpX,tmpY);
  Shape.DrawText(ParentChart,tmpR,GetXOffset,tmpN);

  with Callout do
  if Visible or Arrow.Visible then
  begin
    tmpTo:=TeePoint(XPosition,YPosition);
    tmpFrom:=CloserPoint(tmpR,tmpTo);

    if Distance<>0 then
       tmpTo:=PointAtDistance(tmpFrom,tmpTo,Distance);

    tmpMid.X:=0;
    tmpMid.Y:=0;

    {$IFDEF LCL}Self.Callout.{$ENDIF}Draw(clNone,tmpTo,tmpMid,tmpFrom,ZPosition);
  end;
end;

// 7.05 Renamed from GetBounds to GetTextBounds
Function TAnnotationTool.GetTextBounds(out NumLines,x,y:Integer):TRect;
begin
  result:=GetTextBounds(ParentChart,NumLines,x,y);
end;

type
  TChartAccess=class(TCustomAxisPanel);

Function TAnnotationTool.GetTextBounds(Panel:TCustomAxisPanel; out NumLines,x,y:Integer):TRect;
begin
  if Assigned(Panel) then
     result:=GetTextBounds(Panel,Panel.ChartBounds,NumLines,x,y)
  else
     result:=TeeZeroRect;
end;

Function TAnnotationTool.GetTextBounds(Panel:TCustomAxisPanel;
                            const ABounds:TRect; out NumLines,x,y:Integer):TRect;

  procedure CalcTextSize(AText:String; out AWidth,AHeight:Integer);
  begin
    AWidth:=Panel.MultiLineTextWidth(AText,NumLines);
    AHeight:=NumLines*Panel.Canvas.FontHeight;
  end;

var tmpW   : Integer;
    tmpH   : Integer;
    tmpPen : Integer;
    tmp    : String;
    tmpX   : Integer;
    tmpY   : Integer;
    tmpWOk : Integer;
    tmpHOk : Integer;
    tmpPanelW : Integer;
    tmpPanelH : Integer;
    tmpTextW  : Integer;
    tmpTextH  : Integer;
begin
  Panel.Canvas.AssignFont(Shape.Font);

  tmp:=GetText;
  if tmp='' then
     tmp:=' ';  { at least one space character... }

  if (not Shape.CustomPosition) or AutoSize then
  begin
    CalcTextSize(tmp,tmpW,tmpH);

    if Shape.Pen.Visible then tmpPen:=(1+Shape.Pen.Width) div 2
                         else tmpPen:=0;

//    if Shape.ShapeStyle=fosRoundRectangle then
//       Inc(tmpPen,Round(0.01*Shape.RoundSize*Panel.Canvas.FontHeight));

    Inc(tmpW,tmpPen);
    Inc(tmpH,tmpPen);
  end
  else
  begin
    tmpPen:=0;
    tmpW:=0;
    tmpH:=0;
    Panel.MultiLineTextWidth(tmp,NumLines);
  end;

  if not AutoSize then
  begin
    tmpW:=Shape.Width;
    tmpH:=Shape.Height;
  end;

  tmpPanelW:=ABounds.Right-ABounds.Left+1;
  tmpPanelH:=ABounds.Bottom-ABounds.Top+1;

  Shape.Margins.Calculate(tmpW,tmpH,Panel.Canvas.FontHeight);

  if Shape.CustomPosition then
  begin
    if PositionUnits=muPixels then
    begin
      x:=Shape.Left;
      y:=Shape.Top;
    end
    else
    begin
      x:=Round(Shape.Left*tmpPanelW*0.01);
      y:=Round(Shape.Top*tmpPanelH*0.01);
    end;
  end
  else
  begin
    tmpX:=ABounds.Left+tmpPanelW-tmpW-Shape.Margins.HorizSize;
    tmpY:=ABounds.Top+tmpPanelH-tmpH-Shape.Margins.VertSize;

    Case Position of
      ppLeftTop     : begin x:=ABounds.Left+10; y:=ABounds.Top+10; end;
      ppLeftBottom  : begin x:=ABounds.Left+10; y:=tmpY; end;
      ppRightTop    : begin x:=tmpX; y:=ABounds.Top+10; end;
      ppRightBottom : begin x:=tmpX; y:=tmpY; end;
    else
      // ppCenter:
      begin
        CalcTextSize(tmp,tmpTextW,tmpTextH);
        x:=(ABounds.Left+ABounds.Right-tmpTextW) div 2;
        y:=(ABounds.Top+ABounds.Bottom-tmpTextH) div 2;
      end
    end;
  end;

  if AutoSize then
  begin
    tmpWOk:=tmpW+Shape.Margins.HorizSize;
    tmpHOk:=tmpH+Shape.Margins.VertSize;
  end
  else
  begin
    tmpWOk:=Shape.Width;
    tmpHOk:=Shape.Height;
  end;

  {$IFDEF CLR}
  result:=TRect.Create(x,y,x+tmpWOk-1,y+tmpHOk-1);
  {$ELSE}
  with result do
  begin
    Left:=x;
    Top:=y;
    Right:=Left+tmpWOk-1;
    Bottom:=Top+tmpHOk-1;
  end;
  {$ENDIF}

  Inc(x,tmpPen div 2);
  Inc(y,tmpPen div 2);

  if AutoSize then
  with Shape do
  begin
    ShapeBounds.Right:=ShapeBounds.Left+(result.Right-result.Left);
    ShapeBounds.Bottom:=ShapeBounds.Top+(result.Bottom-result.Top);
  end;
end;

procedure TAnnotationTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if not (csDestroying in ComponentState) then
  begin
    if Assigned(Shape) then
       Shape.ParentChart:=Value;

    if Assigned(Callout) then
       Callout.ParentChart:=Value;

    if Assigned(ParentChart) then
       Repaint;
  end;
end;

procedure TAnnotationTool.SetShape(const Value: TTextShape);
begin
  FShape.Assign(Value);
end;

class function TAnnotationTool.Description: String;
begin
  result:=TeeMsg_AnnotationTool;
end;

class function TAnnotationTool.LongDescription: String;
begin
  result:=TeeMsg_AnnotationDesc;
end;

class function TAnnotationTool.GetEditorClass: String;
begin
  result:='TAnnotationToolEdit';
end;

procedure TAnnotationTool.SetPosition(const Value: TAnnotationPosition);
begin
  if FPosition<>Value then
  begin
    FPosition:=Value;
    Shape.CustomPosition:=False;
    Repaint;
  end;
end;

Function TAnnotationTool.Clicked(x,y:Integer):Boolean; // 5.03
var tmpDummy,
    tmpX,
    tmpY : Integer;
begin
  result:=PointInRect(GetTextBounds(tmpDummy,tmpX,tmpY),x,y);
end;

procedure TAnnotationTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if AEvent=cmeDown then
  begin
    if Assigned(FOnClick) and Clicked(x,y) then
       FOnClick(Self,Button,Shift,X,Y);

    if (ssDouble in Shift) and Assigned(FOnDblClick) and Clicked(x,y) then
       FOnDblClick(Self,Button,Shift,X,Y);
  end
  else
  if (AEvent=cmeMove) and (Shape.Cursor<>crDefault) then
  begin
    if Clicked(x,y) then
    begin
      ParentChart.Cursor:=Shape.FCursor;
      ParentChart.CancelMouse:=True;
    end;
  end;
end;

procedure TAnnotationTool.SetTextAlign(const Value: TAlignment);
begin
  Shape.TextAlignment:=Value;
end;

procedure TAnnotationTool.Repaint;
begin
  if Assigned(ParentChart) then
     inherited
  else
     Shape.Repaint; // Needed by NumericGauge Markers
end;

procedure TAnnotationTool.SetAutoSize(const Value: Boolean);
begin
  Shape.AutoSize:=Value;
end;

procedure TAnnotationTool.SetCallout(const Value: TAnnotationCallout);
begin
  FCallout.Assign(Value);
end;

procedure TAnnotationTool.SetClipText(const Value: Boolean);
begin
  Shape.ClipText:=Value;
end;

procedure TAnnotationTool.SetPositionUnits(const Value: TTeeUnits);
begin
  if FPositionUnits<>Value then
  begin
    FPositionUnits:=Value;
    Repaint;
  end;
end;

function TAnnotationTool.GetHeight: Integer;
begin
  result:=Shape.Height;
end;

function TAnnotationTool.GetWidth: Integer;
begin
  result:=Shape.Width;
end;

function TAnnotationTool.IsNotAutoSize: Boolean;
begin
  result:=not AutoSize;
end;

procedure TAnnotationTool.SetCursor(const Value:TCursor);
begin
  Shape.Cursor:=Value;
end;

procedure TAnnotationTool.SetHeight(const Value: Integer);
begin
  if Height<>Value then
  begin
    AutoSize:=False;
    Shape.Height:=Value;
    Repaint;
  end;
end;

procedure TAnnotationTool.SetWidth(const Value: Integer);
begin
  if Width<>Value then
  begin
    AutoSize:=False;
    Shape.Width:=Value;
    Repaint;
  end;
end;

function TAnnotationTool.GetLeft: Integer;
begin
  result:=Shape.Left;
end;

function TAnnotationTool.GetTop: Integer;
begin
  result:=Shape.Top;
end;

procedure TAnnotationTool.SetLeft(const Value: Integer);
var Old : Integer;
begin
  Old:=Shape.Width;
  Shape.Left:=Value;
  Shape.Width:=Old;
end;

procedure TAnnotationTool.SetTop(const Value: Integer);
var Old : Integer;
begin
  Old:=Shape.Height;
  Shape.Top:=Value;
  Shape.Height:=Old;
end;

function TAnnotationTool.GetBounds:TRect;
var tmpN : Integer;
    x    : Integer;
    y    : Integer;
begin
  result:=GetTextBounds(tmpN,x,y);
end;

function TAnnotationTool.GetAutoSize:Boolean;
begin
  result:=Shape.AutoSize;
end;

function TAnnotationTool.GetClipText:Boolean;
begin
  result:=Shape.ClipText;
end;

function TAnnotationTool.GetCursor:TCursor;
begin
  result:=Shape.Cursor
end;

function TAnnotationTool.GetTextAlign: TAlignment;
begin
  result:=Shape.TextAlignment;
end;

procedure TAnnotationTool.SetBounds(const Value: TRect);
begin
  Shape.ShapeBounds:=Value;
  Repaint;
end;

{ TSeriesAnimationTool }
constructor TSeriesAnimationTool.Create(AOwner: TComponent);
begin
  inherited;
  IStopped:=True;
  FStartAtMin:=True;
  FSteps:=100;
end;

class function TSeriesAnimationTool.Description: String;
begin
  result:=TeeMsg_SeriesAnimTool;
end;

class function TSeriesAnimationTool.LongDescription: String;
begin
  result:=TeeMsg_SeriesAnimationDesc;
end;

procedure TSeriesAnimationTool.Execute(Sender:TObject);
begin
  Execute;
end;

procedure TSeriesAnimationTool.Execute;

  Procedure UpdateChart;
  var t1 : Cardinal;
  begin
    Series.ParentChart.Invalidate;

    if FDelay=0 then
       Application.ProcessMessages
    else
    begin
      t1:=GetTickCount;

      while (GetTickCount-t1)<Cardinal(FDelay) do
            Application.ProcessMessages;
    end;
  end;

var tmpList : TChartValueList;
    tmpBack : TChartValueList;

  procedure SetInitialValues;
  var t : Integer;
  begin
    for t:=0 to Series.Count-1 do
        tmpList.Value[t]:=tmpBack.Value[t];
    UpdateChart;
  end;

var tmpDirection : Boolean;

  Procedure DoAnimation;
  var t,tt     : Integer;
      tmpStart : Double;
      tmpSpeed : Double;
      tmpSpeed2 : Double;
      tmpSpeed3 : Double;
      tmpPoints : Integer;
      tmpPointStep : Integer;
      tmpFrom      : Integer;
      tmpTo        : Integer;
      tmpSteps     : Integer;
  begin
    tmpList:=Series.MandatoryValueList;

    if StartAtMin then
       tmpStart:=tmpList.MinValue
    else
       tmpStart:=StartValue;

    // Clear values
    for t:=0 to Series.Count-1 do
        tmpList.Value[t]:=tmpStart;

    UpdateChart;

    tmpBack:=FBackup.MandatoryValueList;

    if DrawEvery=0 then tmpPoints:=0
    else
    begin
      tmpPoints:=Series.Count div DrawEvery;

      if (Series.Count mod DrawEvery)=0 then
         Dec(tmpPoints);
    end;

    for tmpPointStep:=0 to tmpPoints do
    begin
      tmpFrom:=tmpPointStep*DrawEvery;
      if DrawEvery=0 then tmpTo:=Series.Count-1
                     else tmpTo:=Math.Min(Series.Count-1,tmpFrom+DrawEvery-1);

      tmpSpeed:=1/Steps;
      tmpSteps:=Steps;

      for t:=0 to tmpSteps do
      begin
        tmpSpeed2:=t*tmpSpeed;
        tmpSpeed3:=tmpStart-(tmpStart*tmpSpeed2);

        if Loop=salCircular then
           if not tmpDirection then
           begin
             tmpSpeed3:=0; //-tmpSpeed3;
             tmpSpeed2:=(tmpSteps-t)*tmpSpeed;
           end;

        for tt:=tmpFrom to tmpTo do
            tmpList.Value[tt]:=tmpSpeed3+(tmpSpeed2*tmpBack.Value[tt]);

        if Assigned(FOnStep) then
           FOnStep(Self,t);

        UpdateChart;

        if IStopped then
        begin
          SetInitialValues;
          Exit;
        end;
      end;
    end;

    SetInitialValues;
  end;

begin
  if Assigned(Series) and IStopped then
  begin

    FBackup:=TChartSeriesClass(Series.ClassType).Create(nil);
    try

      FBackup.AssignValues(Series);
      Series.BeginUpdate;
      IStopped:=False;

      if Assigned(FOnStart) then
         FOnStart(Self);
         
      try
        if Loop<>salNo then
        begin
          tmpDirection:=True;

          while not IStopped do
          begin
            DoAnimation;
            tmpDirection:=not tmpDirection;
          end;
        end
        else DoAnimation;

      finally
        Stop;

        // Series.AssignValues(FBackup);  <-- not necessary
        
        Series.EndUpdate;
      end;

    finally
      FBackup.Free;
    end;
  end;
end;

class function TSeriesAnimationTool.GetEditorClass: String;
begin
  result:='TSeriesAnimToolEditor';
end;

function TSeriesAnimationTool.Running: Boolean;
begin
  result:=not IStopped;
end;

procedure TSeriesAnimationTool.Stop;
begin
  if not IStopped then
  begin
    IStopped:=True;

    if Assigned(FOnStop) then
       FOnStop(Self);
  end;
end;

{ TGridBandBrush }
Constructor TGridBandBrush.Create(OnChangeEvent:TNotifyEvent);
begin
  inherited;
  BackColor:=clNone;
  FGradient:=TTeeGradient.Create(OnChangeEvent);
end;

Destructor TGridBandBrush.Destroy;
begin
  FGradient.Free;
  inherited;
end;

Procedure TGridBandBrush.Assign(Source:TPersistent);
begin
  if Source is TGridBandBrush then
  with TGridBandBrush(Source) do
  begin
    Self.Gradient:=Gradient;
    Self.FTransp:=FTransp;
  end;

  inherited;
end;

procedure TGridBandBrush.SetGradient(const Value: TTeeGradient);
begin
  FGradient.Assign(Value);
end;

procedure TGridBandBrush.SetTransp(const Value: TTeeTransparency);
begin
  if FTransp<>Value then
  begin
    FTransp:=Value;
    Changed;
  end;
end;

{ TGridBandTool }
constructor TGridBandTool.Create(AOwner: TComponent);
begin
  inherited;
  FBand1:=TGridBandBrush.Create(CanvasChanged);
  FBand2:=TGridBandBrush.Create(CanvasChanged);
  FBand2.Color:=clWhite;
end;

procedure TGridBandTool.Assign(Source:TPersistent);
begin
  if Source is TGridBandTool then
  begin
    Band1.Assign(TGridBandTool(Source).Band1);
    Band2.Assign(TGridBandTool(Source).Band2);
  end;

  inherited;
end;

class function TGridBandTool.Description: String;
begin
  result:=TeeMsg_GridBandTool;
end;

class function TGridBandTool.LongDescription: String;
begin
  result:=TeeMsg_GridBandDesc;
end;

type
  TAxisAccess=class(TChartAxis);

Destructor TGridBandTool.Destroy;
begin
  if Assigned(Axis) then
     TAxisAccess(Axis).OnDrawGrids:=nil;

  FBand2.Free;
  FBand1.Free;
  inherited;
end;

Function TGridBandTool.BandBackColor(ABand:TGridBandBrush):TColor;
begin
  result:=ABand.BackColor;

  if (result=clNone) and Assigned(ParentChart) then
     result:=TCustomChart(ParentChart).Walls.Back.Color;
end;

Procedure TGridBandTool.DrawGrids(Sender:TChartAxis);
var tmpBand  : TGridBandBrush;
    tmpBlend : TTeeBlend;
    tmpStart : Integer;
    tmpEnd   : Integer;

  Procedure DrawBand(tmpPos1,tmpPos2:Integer);
  var tmpR : TRect;
  begin
    if tmpBand.Style<>bsClear then
    with ParentChart,Canvas do
    begin
      if tmpPos1>tmpPos2 then
         SwapInteger(tmpPos1,tmpPos2);

      if Axis.Horizontal then
         tmpR:=TeeRect(tmpPos1,tmpStart,tmpPos2,tmpEnd)
      else
         tmpR:=TeeRect(tmpStart,tmpPos1,tmpEnd,tmpPos2+1);

      if Assigned(tmpBlend) and (tmpBand.Transparency>0) then
         if View3D then tmpBlend.SetRectangle(CalcRect3D(tmpR,Width3D))
                   else tmpBlend.SetRectangle(tmpR);

      if tmpBand.Gradient.Visible then
      begin
        if View3D then
           tmpBand.Gradient.Draw(Canvas, CalcRect3D(tmpR,Width3D))
        else
        begin
          Dec(tmpR.Bottom);
          tmpBand.Gradient.Draw(Canvas, tmpR);
        end;
      end
      else
      begin
        AssignBrush(tmpBand,tmpBand.Color,BandBackColor(tmpBand));
        Pen.Style:=psClear;

        if View3D then
           RectangleWithZ(tmpR,Width3D)
        else
        begin
          Inc(tmpR.Right);
          Rectangle(tmpR);
        end;
      end;

      if Assigned(tmpBlend) and (tmpBand.Transparency>0) then
         tmpBlend.DoBlend(tmpBand.Transparency);
    end;
  end;

  procedure SwitchBands;
  begin
    if tmpBand=Band1 then tmpBand:=Band2
                     else tmpBand:=Band1;
  end;

var t   : Integer;
    tmp : Integer;
begin
  if (not Active) or (Length(Sender.Tick)=0) then
     Exit;

  tmp:=High(Sender.Tick);

  if (tmp>0) and ((Band1.Style<>bsClear) or (Band2.Style<>bsClear)) then
  begin
    tmpBlend:=ParentChart.Canvas.BeginBlending(TeeRect(0,0,0,0),0);
    try
      ParentChart.Canvas.Pen.Style:=psClear;

      tmpBand:=Band1;

      if (StartPos=0) and (EndPos=0) then
      begin
        with ParentChart do
        if Sender.Horizontal then
        begin
          tmpStart:=ChartRect.Top+1;
          tmpEnd:=ChartRect.Bottom;
        end
        else
        begin
          tmpStart:=ChartRect.Left+1;
          tmpEnd:=ChartRect.Right;
        end;
      end
      else
      begin
        tmpStart:=StartPos;
        tmpEnd:=EndPos;
      end;

      with Sender do
      begin
        // first remainder band...
        if Horizontal then
        begin
          if Tick[0]<IEndPos then
          begin
            DrawBand(IEndPos-1,Tick[0]);
            SwitchBands;
          end;
        end
        else
          if Tick[0]>IStartPos then
          begin
            DrawBand(IStartPos+1,Tick[0]);
            SwitchBands;
          end;

        if tmp>1 then // 7.01
        begin
          // all bands...
          for t:=1 to tmp do
          begin
            DrawBand(Tick[Pred(t)],Tick[t]);
            SwitchBands;
          end;

          // last remainder band...
          if Horizontal then
          begin
            if Tick[tmp]>IStartPos then DrawBand(Tick[tmp],IStartPos);
          end
          else
            if Tick[tmp]<IEndPos then DrawBand(Tick[tmp],IEndPos);
        end;
      end;
    finally
      tmpBlend.Free;
    end;
  end;
end;

class function TGridBandTool.GetEditorClass: String;
begin
  result:='TGridBandToolEdit';
end;

procedure TGridBandTool.SetAxis(const Value: TChartAxis);
begin
  if Assigned(Axis) then TAxisAccess(Axis).OnDrawGrids:=nil;
  inherited;
  if Assigned(Axis) then TAxisAccess(Axis).OnDrawGrids:=DrawGrids;
end;

procedure TGridBandTool.SetBand1(Value: TGridBandBrush);
begin
  FBand1.Assign(Value);
end;

procedure TGridBandTool.SetBand2(Value: TGridBandBrush);
begin
  FBand2.Assign(Value);
end;


{ TAxisScrollTool }
procedure TAxisScrollTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  Function AxisClicked:TChartAxis;
  var t : Integer;
  begin
    result:=nil;

    if Assigned(Axis) then
    begin
      if Axis.Visible and Axis.Clicked(x,y) then
         result:=Axis;
    end
    else
    with ParentChart do
    for t:=0 to Axes.Count-1 do
        if Axes[t].Visible and Axes[t].Clicked(x,y) then
        begin
          result:=Axes[t];
          break;
        end;
  end;

var Delta : Integer;

  procedure DoAxisScroll(AAxis:TChartAxis);
  begin
    if AAxis.IAxisSize<>0 then
       AAxis.Scroll(Delta*(AAxis.Maximum-AAxis.Minimum)/AAxis.IAxisSize,False);
  end;

  procedure CheckOtherAxes;
  var t  : Integer;
      tt : Integer;
  begin
    with ParentChart do
    for t:=0 to Axes.Count-1 do
    if (Axes[t]<>InAxis) and (Axes[t].Horizontal=InAxis.Horizontal) then
       for tt:=0 to SeriesCount-1 do
           if Series[tt].AssociatedToAxis(InAxis) and
              Series[tt].AssociatedToAxis(Axes[t]) then
           begin
             DoAxisScroll(Axes[t]);
             break;
           end;
  end;

begin
  inherited;

  if Active then
  Case AEvent of
    cmeDown: begin
               InAxis:=AxisClicked;
               OldX:=X;
               OldY:=Y;
             end;
    cmeMove: begin
               if Assigned(InAxis) then
               begin
                 if InAxis.Horizontal then Delta:=OldX-X
                                      else Delta:=OldY-Y;

                 if InAxis.Inverted then Delta:=-Delta;

                 if InAxis.Horizontal then
                 begin
                   if ScrollInverted then Delta:=-Delta;
                 end
                 else
                   if not ScrollInverted then Delta:=-Delta;

                 DoAxisScroll(InAxis);

                 CheckOtherAxes;

                 OldX:=X;
                 OldY:=Y;
                 ParentChart.CancelMouse:=True;
               end
               else
               if AxisClicked<>nil then
               begin
                 ParentChart.Cursor:=crHandPoint;
                 ParentChart.CancelMouse:=True;
               end;
             end;

    cmeUp: InAxis:=nil;
  end;
end;

class Function TAxisScrollTool.GetEditorClass:String;
begin
  result:='TAxisScrollEditor';
end;

class function TAxisScrollTool.Description: String;
begin
  result:=TeeMsg_AxisScrollTool;
end;

class function TAxisScrollTool.LongDescription: String;
begin
  result:=TeeMsg_AxisScrollDesc;
end;

{ TRectangleTool }
Constructor TRectangleTool.Create(AOwner:TComponent);
begin
  inherited;

  AutoSize:=False;
  IEdge:=-1;

  with Shape do
  begin
    FCustomPosition:=True;
    DefaultCustom:=True;
    Shadow.Size:=0;
    Transparency:=75;
    ShapeBounds.Left:=10;
    ShapeBounds.Top:=10;
    Width:=50;
    Height:=50;
  end;

  FAllowDrag:=True;
  FAllowResize:=True;

  PositionUnits:=muPixels;
  Cursor:=crHandPoint;
end;

procedure TRectangleTool.Assign(Source:TPersistent);
begin
  if Source is TRectangleTool then
  with TRectangleTool(Source) do
  begin
    Self.FAllowDrag   :=FAllowDrag;
    Self.FAllowResize :=FAllowResize;
  end;

  inherited;
end;

Function TRectangleTool.ClickedEdge(x,y:Integer):Integer;
const
  Tolerance=4;

var R : TRect;
begin
  result:=-1;

  if Clicked(x,y) then
  begin
    R:=Bounds;

    if Abs(x-R.Left)<Tolerance then
       if Abs(y-R.Top)<Tolerance then
          result:=4
       else
       if Abs(y-R.Bottom)<Tolerance then
          result:=5
       else
          result:=0
    else
    if Abs(y-R.Top)<4 then
       if Abs(x-R.Right)<Tolerance then
          result:=6
       else
          result:=1
    else
    if Abs(x-R.Right)<4 then
       if Abs(y-R.Bottom)<Tolerance then
          result:=7
       else
          result:=2
    else
    if Abs(y-R.Bottom)<4 then
       result:=3;
  end;
end;

function TRectangleTool.GetResizing: Boolean;
begin
  result:=IEdge=-1;
end;

class Function TRectangleTool.Description:String;
begin
  result:=TeeMsg_RectangleTool;
end;

class Function TRectangleTool.LongDescription:String;
begin
  result:=TeeMsg_RectangleToolDesc;
end;

Procedure TRectangleTool.ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer);

  Function GuessEdgeCursor:Boolean;

    procedure TrySet(ACursor:TCursor);
    begin
      if AllowResize then
      begin
        ParentChart.Cursor:=ACursor;
        result:=True;
      end;
    end;

  begin
    result:=False;

    case ClickedEdge(x,y) of
      0,2: TrySet(crSizeWE);
      1,3: TrySet(crSizeNS);
      5,6: TrySet(crSizeNESW);
      4,7: TrySet(crSizeNWSE);
    else
      if Clicked(x,y) and (Cursor<>crDefault) then
      begin
        ParentChart.Cursor:=Cursor;
        result:=True;
      end;
    end;
  end;

  procedure StartResizing;
  begin
    if (IEdge=2) or (IEdge=6) or (IEdge=7) then
       P.X:=X-Bounds.Right
    else
       P.X:=X-Bounds.Left;

    if (IEdge=3) or (IEdge=5) or (IEdge=7) then
       P.Y:=Y-Bounds.Bottom
    else
       P.Y:=Y-Bounds.Top;

    ParentChart.CancelMouse:=True;
  end;

  procedure StartDragging;
  begin
    P.X:=X-Bounds.Left;
    P.Y:=Y-Bounds.Top;

    IDrag:=True;
    ParentChart.CancelMouse:=True;
  end;

  procedure ChangeLeftTop(ALeft,ATop:Integer);
  var tmpW : Integer;
      tmpH : Integer;
  begin
    tmpW:=Shape.Width;
    tmpH:=Shape.Height;

    if PositionUnits=muPixels then
    begin
      Shape.Left:=ALeft;
      Shape.Top:=ATop;
    end
    else
    begin
      Shape.Left:=Round(ALeft*100/ParentChart.Width);
      Shape.Top:=Round(ATop*100/ParentChart.Height);
    end;

    Shape.Width:=tmpW;
    Shape.Height:=tmpH;
  end;

  procedure TryDrag;
  begin
    if (X<>P.X) or (Y<>P.Y) then
    begin
      Shape.CustomPosition:=True;
      ChangeLeftTop(X-P.X,Y-P.Y);

      if Assigned(FOnDragging) then
         FOnDragging(Self);
    end;
  end;

  procedure DoResize;
  var
    tmpR : TRect;

    procedure ChangeLeft;
    begin
      tmpR.Left:=Min(tmpR.Right-3,X-P.X);
    end;

    procedure ChangeTop;
    begin
      tmpR.Top:=Min(tmpR.Bottom-3,Y-P.Y);
    end;

    procedure ChangeRight;
    begin
      tmpR.Right:=Max(tmpR.Left+3,X-P.X);
    end;

    procedure ChangeBottom;
    begin
      tmpR.Bottom:=Max(tmpR.Top+3,Y-P.Y);
    end;

  begin
    tmpR:=Bounds;

    case IEdge of
      0: ChangeLeft;
      1: ChangeTop;
      2: ChangeRight;
      3: ChangeBottom;
      4: begin
           ChangeLeft;
           ChangeTop;
         end;
      5: begin
           ChangeLeft;
           ChangeBottom;
         end;
      6: begin
           ChangeRight;
           ChangeTop;
         end;
      7: begin
           ChangeRight;
           ChangeBottom;
         end;
    end;

    if PositionUnits=muPixels then
       Shape.ShapeBounds:=tmpR
    else
       ChangeLeftTop(tmpR.Left,tmpR.Top);

    Repaint;

    if Assigned(FOnResizing) then
       FOnResizing(Self);
  end;

  procedure StopDrag;
  begin
    if Assigned(FOnDragged) then
       FOnDragged(Self);

    IDrag:=False;
  end;

  procedure StopResize;
  begin
    if Assigned(FOnResized) then
       FOnResized(Self);

    IEdge:=-1;
  end;

begin
  inherited;

  if Active then
  case AEvent of
    cmeDown: if Button=mbLeft then
             begin
               if AllowResize then
                  IEdge:=ClickedEdge(x,y)
               else
                  IEdge:=-1;

               if IEdge<>-1 then
                  StartResizing
               else
               if AllowDrag and Clicked(x,y) then
                  StartDragging;
             end;

      cmeUp: if IDrag then
                 StopDrag
             else
             if IEdge<>-1 then
                StopResize;

    cmeMove: if IDrag then
                TryDrag
             else
             if IEdge<>-1 then
             begin
               AutoSize:=False;
               DoResize;
             end
             else
             if Assigned(ParentChart) then
                ParentChart.CancelMouse:=GuessEdgeCursor;
  end;
end;

// Returns chart bitmap under rectangle shape
Function TRectangleTool.Bitmap(ChartOnly:Boolean=False):TBitmap;

  Procedure CopyResult(ACanvas:TCanvas);
  begin
    result.Canvas.CopyRect( TeeRect(0,0,result.Width,result.Height),
                            ACanvas,Bounds);
  end;

var tmp       : TTeeCanvas3D;
    OldActive : Boolean;
    tmpB      : TBitmap;
begin
  result:=TBitmap.Create;

  TeeSetBitmapSize(result,Shape.Width,Shape.Height);

  if ChartOnly then
  begin
    OldActive:=Active;
    Active:=False;
    try
      tmpB:=ParentChart.TeeCreateBitmap(ParentChart.Color,ParentChart.ChartBounds);
      try
        CopyResult(tmpB.Canvas);
      finally
        tmpB.Free;
      end;
    finally
      Active:=OldActive;
    end;
  end
  else
  if ParentChart.Canvas is TTeeCanvas3D then
  begin
    tmp:=TTeeCanvas3D(ParentChart.Canvas);

    if not Assigned(tmp.Bitmap) then
       ParentChart.Draw;

    CopyResult(tmp.Bitmap.Canvas);
  end;
end;

{ TClipTool }

Procedure TClipSeriesTool.SeriesEvent(AEvent:TChartToolEvent);
var tmpR : TRect;
begin
  if Assigned(ParentChart) and ParentChart.CanClip then
     if AEvent=cteBeforeDrawSeries then
     begin
       tmpR.Left:=Series.GetHorizAxis.IStartPos;
       tmpR.Right:=Series.GetHorizAxis.IEndPos;
       tmpR.Top:=Series.GetVertAxis.IStartPos;
       tmpR.Bottom:=Series.GetVertAxis.IEndPos;

       ParentChart.Canvas.ClipRectangle(tmpR);
     end
     else
     if AEvent=cteAfterDrawSeries then
        ParentChart.Canvas.UnClipRectangle;
end;

class Function TClipSeriesTool.Description:String;
begin
  result:=TeeMsg_ClipSeries;
end;

class Function TClipSeriesTool.LongDescription:String;
begin
  result:=TeeMsg_ClipSeriesDesc;
end;

{ TFullScreenTool }

Constructor TFullScreenTool.Create(AOwner: TComponent);
begin
  inherited;
  FKey:=TeeKey_Escape;
  IFreeForm:=True;
  Active:=False;
end;

Destructor TFullScreenTool.Destroy;
begin
  if Active then
     RemoveFullScreen;

  inherited;
end;

procedure TFullScreenTool.RemoveFullScreen;
var tmp : TWinControl;
begin
  {$IFNDEF TEEOCX}
  tmp:=ParentChart.Parent;

  if Assigned(tmp) and (tmp is TCustomForm) and
     (tmp.Tag={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(Self)) then
  begin
    tmp.Tag:={$IFDEF CLR}nil{$ELSE}0{$ENDIF};

    if (not Assigned(OldParent)) or
       (not (csDestroying in OldParent.ComponentState)) then
         ParentChart.Parent:=OldParent
    else
        ParentChart.Parent:=nil;

    ParentChart.BoundsRect:=OldRChart;
    ParentChart.Align:=OldAlign;

    if IFreeForm then
       tmp.Free;
  end;
  {$ELSE}
  if (Assigned(tmpForm)) and IFreeForm then
  Begin
     tmpChart.Free;
     tmpForm.Free;
     isFullScreenRunning := False;
  end;
  {$ENDIF}
end;

{$IFDEF D6}
{$IFNDEF CLX}
{$DEFINE USEDESKTOPRECT}
{$ENDIF}
{$ENDIF}

procedure TFullScreenTool.SetActive(Value: Boolean);

  function ScreenDesktopRect:TRect;
  begin
    {$IFDEF USEDESKTOPRECT}
    result:=Screen.DesktopRect;
    {$ELSE}

    {$IFDEF CLX}
    with Screen do
         result:=Bounds(0,0,Width,Height);
    {$ELSE}
    {$IFDEF LCL}
    with Screen do
         result:=Bounds(0,0,Width,Height);
    {$ELSE}
    with Screen do
         result:=Bounds(DesktopLeft, DesktopTop, DesktopWidth, DesktopHeight);
    {$ENDIF}
    {$ENDIF}

    {$ENDIF}
  end;

  procedure ActivateFullScreen;
  var
    {$IFNDEF TEEOCX}
    tmpForm : TForm;
    {$ELSE}
    tmpStream : TStream;
    tmpChart2  : TCustomChart;
    i : Integer;
    {$ENDIF}
  begin
    OldParent:=ParentChart.Parent;

    tmpForm:=TForm.CreateNew(nil {$IFDEF LCL},0{$ENDIF});

    tmpForm.Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(Self);

    tmpForm.KeyPreview:=True;
    tmpForm.BorderStyle:={$IFDEF CLX}fbsNone{$ELSE}bsNone{$ENDIF};
    tmpForm.BoundsRect:=ScreenDesktopRect;

    {$IFNDEF TEEOCX}
    OldAlign:=ParentChart.Align;
    ParentChart.Align:=alNone;

    ParentChart.Parent:=tmpForm;

    OldRChart:=ParentChart.BoundsRect;
    ParentChart.BoundsRect:=ScreenDesktopRect;

    {$ELSE}

    if not isFullScreenRunning then
    Begin
      isFullScreenRunning := True;
      tmpChart:=TChart.Create(nil);
      tmpChart2:=TChart.Create(nil);
      tmpStream:=TMemoryStream.Create;
      SaveChartToStream(TCustomChart(ParentChart),tmpStream,True,False);
      tmpStream.Position :=0;

      LoadChartFromStream(TCustomChart(tmpChart2),tmpStream);

      for i:=0 to tmpChart2.Tools.Count-1 do
      Begin
        if tmpChart2.Tools[i] is TFullScreenTool then
          tmpChart2.Tools.Remove(tmpChart2.Tools[i]);
      end;

      tmpStream:=TMemoryStream.Create;
      SaveChartToStream(TCustomChart(tmpChart2),tmpStream,True,False);
      tmpStream.Position :=0;

      LoadChartFromStream(TCustomChart(tmpChart),tmpStream);
      tmpChart.Parent:=tmpForm;

      tmpChart.BoundsRect:=ScreenDesktopRect;
    end;
    {$ENDIF}

    tmpForm.OnKeyUp:=FormKeyUp;
    tmpForm.OnCloseQuery:=FormCloseQuery;

    tmpForm.Show;

    // tmpForm.FormStyle:=fsStayOnTop;  (workaround when Active=True at FormCreate)
  end;

begin
  inherited;

  if (not (csDesigning in ComponentState)) and Assigned(ParentChart) then
     if Value then
        ActivateFullScreen
     else
        RemoveFullScreen;
end;

procedure TFullScreenTool.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Active and (Key=FKey) then
  begin
    Active:=False;
    Key:=0;
  end;
end;

procedure TFullScreenTool.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var tmp : {$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF};
begin
  tmp:=(Sender as TForm).Tag;

  if tmp<>{$IFDEF CLR}nil{$ELSE}0{$ENDIF} then
  with TFullScreenTool(tmp) do
  begin
    IFreeForm:=False;
    try
      Active:=False;
    finally
      IFreeForm:=True;
    end;
  end;

  CanClose:=True;
end;

class function TFullScreenTool.Description: String;
begin
  result:=TeeMsg_FullScreen;
end;

class function TFullScreenTool.LongDescription: String;
begin
  result:=TeeMsg_FullScreenDesc;
end;

{ TTextShape }
Constructor TTextShape.Create(AOwner: TCustomTeePanel);
begin
  inherited;
  FAutoSize:=True;
  FClipText:=True;
  FCursor:=crDefault;
  FTextAlign:=taLeftJustify;

  FMargins:=TMargins.Create(Self);
end;

Destructor TTextShape.Destroy;
begin
  FreeAndNil(FMargins);
  inherited;
end;

procedure TTextShape.Assign(Source:TPersistent);
begin
  if Source is TTextShape then
  with TTextShape(Source) do
  begin
    Self.FAutoSize :=FAutoSize;
    Self.FClipText :=FClipText;
    Self.FCursor   :=FCursor;
    Self.Margins   :=Margins;
    Self.FText     :=FText;
    Self.FTextAlign:=FTextAlign;
  end;

  inherited;
end;

procedure TTextShape.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize<>Value then
  begin
    FAutoSize:=Value;
    Repaint;
  end;
end;

procedure TTextShape.SetClipText(const Value: Boolean);
begin
  if FClipText<>Value then
  begin
    FClipText:=Value;
    Repaint;
  end;
end;

procedure TTextShape.SetText(const Value: String);
begin
  if FText<>Value then
  begin
    FText:=Value;
    Repaint;
  end;
end;

procedure TTextShape.SetTextAlign(const Value: TAlignment);
begin
  if FTextAlign<>Value then
  begin
    FTextAlign:=Value;
    Repaint;
  end;
end;

procedure TTextShape.DrawText(Panel:TCustomAxisPanel; R:TRect; XOffset, NumLines:Integer);
var x     : Integer;
    t     : Integer;
    tmp   : String;
    tmpTop    : Integer;
    tmpHeight : Integer;
begin
  OffsetRect(R,Panel.ChartBounds.Left,Panel.ChartBounds.Top);

  if Visible then
     DrawRectRotated(Panel, R);

  With Panel.Canvas do
  begin
    if Self.ClipText then
       ClipRectangle(R);

    try
      BackMode:=cbmTransparent;

      case TextAlignment of
        taLeftJustify:
          begin
            TextAlign:=TA_LEFT;
            x:=R.Left+Margins.Size.Left;

            if Self.Pen.Visible then
               Inc(x,Self.Pen.Width);
          end;
        taCenter:
          begin
            TextAlign:=ta_Center;

            with R do
                 x:=1+((Left+Margins.Size.Left+Right-Margins.Size.Right) div 2);
          end;
      else
        begin
          TextAlign:=ta_Right;
          x:=R.Right-Margins.Size.Right;
        end;
      end;

      AssignFont(Self.Font);
      tmpHeight:=FontHeight;

      tmp:=FText;
      tmp:=ReplaceChar(tmp,#$A);
      if tmp='' then tmp:=' ';  { at least one space character... }

      tmpTop:=R.Top+Margins.Size.Top;

      for t:=1 to NumLines do
          TextOut( x+XOffset,
                   tmpTop+(t-1)*tmpHeight,
                   TeeExtractField(tmp,t,TeeLineSeparator),
                   TextFormat=ttfHtml);

    finally
      if Self.ClipText then
         UnClipRectangle;
    end;
  end;
end;

procedure TTextShape.CalcBounds(Panel:TCustomAxisPanel);
var tmpHeight : Integer;
    tmpW   : Integer;
    tmpH   : Integer;
    tmpPen : Integer;
    tmp    : String;
    tmpWOk : Integer;
    tmpHOk : Integer;
begin
  if not Assigned(Panel) then
     Exit;

  tmp:=FText;
  if tmp='' then
     tmp:=' ';  { at least one space character... }

  Panel.Canvas.AssignFont(Font);

  tmpHeight:=Panel.Canvas.FontHeight;

  tmpW:=Panel.MultiLineTextWidth(tmp,INumLines);
  tmpH:=INumLines*tmpHeight;

  if Pen.Visible then tmpPen:=(1+Pen.Width) div 2
                 else tmpPen:=0;

  if ShapeStyle=fosRoundRectangle then
     Inc(tmpPen,RoundSize*Panel.Canvas.FontHeight div 100);

  Inc(tmpW,tmpPen);
  Inc(tmpH,tmpPen);

  Margins.Calculate(tmpW,tmpH,tmpHeight);

  tmpWOk:=tmpW+Margins.HorizSize;
  tmpHOk:=tmpH+Margins.VertSize;

  {$IFDEF CLR}
  ShapeBounds:=TRect.Create(0,0,tmpWOk-1,tmpHOk-1);
  {$ELSE}
  With ShapeBounds do
  begin
    Left:=0;
    Top:=0;
    Right:=tmpWOk-1;
    Bottom:=tmpHOk-1;
  end;
  {$ENDIF}
end;

procedure TTextShape.SetMargins(const Value: TMargins);
begin
  FMargins.Assign(Value);
end;

Const T:Array[0..16] of TTeeCustomToolClass=(
                     TCursorTool,     TDragMarksTool,
                     TAxisArrowTool,  TDrawLineTool,
                     TNearestTool,    TColorBandTool,
                     TColorLineTool,  TRotateTool,
                     TChartImageTool, TMarksTipTool,
                     TAnnotationTool, TSeriesAnimationTool,
                     TGridBandTool,   TAxisScrollTool,
                     TRectangleTool,  TClipSeriesTool,
                     TFullScreenTool
                     );

initialization
  RegisterTeeTools(T);
finalization
  UnRegisterTeeTools(T);
end.
