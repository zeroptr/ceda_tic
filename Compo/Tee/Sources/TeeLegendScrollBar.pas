{**********************************************}
{   TeeChart Legend Scrollbar Tool             }
{   Copyright (c) 2003-2009 by David Berneda   }
{**********************************************}
unit TeeLegendScrollBar;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  {$IFDEF CLX}
  QForms, QControls, QGraphics, QExtCtrls, QStdCtrls, QComCtrls,
  {$ELSE}
  Forms, Controls, Graphics, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  {$IFDEF D9}
  Types,
  {$ENDIF}
  {$ENDIF}
  Classes, SysUtils,
  {$IFDEF LINUX}
  Types,
  {$ENDIF}

  {$IFDEF LCL}
  GraphType,
  {$ENDIF}

  TeEngine, Chart, TeeTools, Series, TeeProcs, TeCanvas, TeePenDlg, TeeEdiGrad;

const
  DefaultScrollBarSize=18;

type
  TScrollThumbStyle=(stsCustom, stsThumb1, stsThumb2, stsThumb3, stsThumb4);

  TScrollBarThumb=class(TPersistent)
  private
    FBrush   : TChartBrush;
    FGradient: TTeeGradient;
    FImage   : TTeePicture;
    FSize    : Integer;
    FStyle   : TScrollThumbStyle;

    IScroll  : TTeeCustomTool;
    procedure SetBrush(const Value: TChartBrush);
    procedure SetGradient(const Value: TTeeGradient);
    procedure SetImage(const Value: TTeePicture);
    procedure SetSize(const Value: Integer);
    procedure SetStyle(const Value: TScrollThumbStyle);
  public
    Constructor Create(AOwner:TTeeCustomTool);
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
  published
    property Brush:TChartBrush read FBrush write SetBrush;
    property Gradient:TTeeGradient read FGradient write SetGradient;
    property Image:TTeePicture read FImage write SetImage;
    property Size:Integer read FSize write SetSize default 0;
    property Style:TScrollThumbStyle read FStyle write SetStyle default stsCustom;
  end;

  TTeeScrollBarDrawStyle=(dsAlways,dsWhenNeeded);

  TTeeScrollBar=class;

  TSetPositionEvent=procedure(Sender:TTeeScrollBar; Value:Integer) of object;

  TTeeScrollBar=class(TTeeCustomTool)
  private
    P1,P2,P3      : TPoint;
    P4,P5,P6      : TPoint;

    FDrawStyle    : TTeeScrollBarDrawStyle;
    FInitial      : Integer;

    ThumbBegin    : Integer;
    ThumbEnd      : Integer;

    FThumb        : TScrollBarThumb;
    FTimer        : TTimer;
    FOnScrolled   : TNotifyEvent;

    FInThumb,
    FInDec,
    FInInc,
    FirstTime     : Boolean;
    OldPoint      : TPoint;
    FHorizontal   : Boolean;

    FBevel        : TPanelBevel;
    R             : TRect;
    FAutoRepeat   : Boolean;
    FSize         : Integer;
    FArrowBrush   : TChartBrush;
    FPosition     : Integer;
    FOnSetPosition: TSetPositionEvent;
    FGradient     : TTeeGradient;
    FOnChangeSize : TNotifyEvent;
    FMinSize      : Integer;

    FDecOutline   : Boolean;
    FIncOutline   : Boolean;

    Procedure ApplyScroll(Delta:Double; ActivateTimer:Boolean);
    Function ClickedDec(const P:TPoint):Boolean;
    Function ClickedInc(const P:TPoint):Boolean;
    function ClickedThumb(const P:TPoint): Boolean;
    Function DecRectangle:TRect;
    Procedure DoScroll;
    Procedure DoTimer(Sender:TObject);
    procedure DrawDecArrow;
    procedure DrawDecOutline;
    procedure DrawIncArrow;
    procedure DrawIncOutline;
    function GetBackColor:TColor;
    function GetThumbBrush:TChartBrush;
    function GetThumbSize:Integer;
    Procedure HideDecOutline;
    Procedure HideIncOutline;
    Function IncRectangle:TRect;
    Procedure MouseMove(X,Y:Integer);
    Procedure MouseUp;
    procedure PrepareOutline;
    Procedure ProcessClick(const P:TPoint);
    procedure SetArrowBrush(const Value: TChartBrush);
    procedure SetBackColor(const Value: TColor);
    procedure SetBevel(const Value: TPanelBevel);
    procedure SetGradient(const Value: TTeeGradient);
    procedure SetHorizontal(const Value: Boolean);
    procedure SetMinSize(const Value: Integer);
    procedure SetSize(const Value: Integer);
    procedure SetThumb(const Value: TScrollBarThumb);
    procedure SetThumbBrush(const Value: TChartBrush);
    procedure SetThumbSize(const Value: Integer);
    Function ThumbRectangle:TRect;
  protected
    Max         : Integer;
    ThumbLength : Integer;

    Function CalcDelta(A,B:Integer):Double; virtual;
    procedure ChartEvent(AEvent:TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               Button:TMouseButton;
                               Shift: TShiftState; X, Y: Integer); override;
    function CurrentCount:Integer; virtual;
    function DeltaMain:Integer; virtual;
    function GetPosition:Integer; virtual;
    procedure Draw;
    class Function GetEditorClass:String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    procedure SetPosition(Value:Integer); virtual;
    function ShouldDraw(var R:TRect):Boolean; virtual;
    function TotalCount:Integer; virtual;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    class Function Description:String; override;

    Function MainRectangle:TRect;
    Function ScrollRectangle:TRect;

    property Horizontal:Boolean read FHorizontal write SetHorizontal default False;
    property Position:Integer read GetPosition write SetPosition;
  published
    property Active;
    property ArrowBrush:TChartBrush read FArrowBrush write SetArrowBrush;
    property AutoRepeat:Boolean read FAutoRepeat write FAutoRepeat default True;
    property BackColor:TColor read GetBackColor write SetBackColor default clScrollBar;
    property Bevel:TPanelBevel read FBevel write SetBevel default bvRaised;
    property Brush;
    property DrawStyle:TTeeScrollBarDrawStyle read FDrawStyle
                                              write FDrawStyle;
    property Gradient:TTeeGradient read FGradient write SetGradient;
    property InitialDelay:Integer read FInitial write FInitial default 250;
    property MinThumbSize:Integer read FMinSize write SetMinSize default 4;
    property Pen;
    property Size:Integer read FSize write SetSize default DefaultScrollbarSize;
    property Thumb:TScrollBarThumb read FThumb write SetThumb;
    property ThumbBrush:TChartBrush read GetThumbBrush write SetThumbBrush;
    property ThumbSize:Integer read GetThumbSize write SetThumbSize default 0;

    property OnChangeSize:TNotifyEvent read FOnChangeSize write FOnChangeSize;
    property OnScrolled:TNotifyEvent read FOnScrolled write FOnScrolled;
    property OnSetPosition:TSetPositionEvent read FOnSetPosition write FOnSetPosition;
  end;

  TLegendScrollBar=class(TTeeScrollBar)
  private
    L : TCustomChartLegend;

    function HasPaging:Boolean;
    procedure LegendCalcSize(Sender:TCustomChartLegend; var ASize:Integer);
    procedure SetLegendEvent(Value:TLegendCalcSize);
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

  TScrollbarEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    BThumbGrad: TButtonGradient;
    TabSheet3: TTabSheet;
    Label2: TLabel;
    Label3: TLabel;
    CBAuto: TCheckBox;
    Edit1: TEdit;
    UDSize: TUpDown;
    Edit2: TEdit;
    UDDelay: TUpDown;
    ButtonPen1: TButtonPen;
    Button2: TButton;
    Button3: TButton;
    ButtonColor1: TButtonColor;
    BGradient: TButtonGradient;
    Label4: TLabel;
    Edit3: TEdit;
    UDThumbSize: TUpDown;
    GroupBox1: TGroupBox;
    BBrowse: TButton;
    BFilters: TButton;
    Label1: TLabel;
    ComboBox1: TComboFlat;
    CBStyle: TComboFlat;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CBAutoClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure BFiltersClick(Sender: TObject);
    procedure BBrowseClick(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
  private
    { Private declarations }
    TeeScroll : TTeeScrollBar;
    procedure EnableFilters;
  public
    { Public declarations }
  end;

implementation

uses
  Math, TeeBrushDlg, TeeProCo, TeeFiltersEditor;

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$IFDEF CLR}
{$R 'TeeThumb1.bmp'} // Do not localize
{$R 'TeeThumb2.bmp'} // Do not localize
{$R 'TeeThumb3.bmp'} // Do not localize
{$R 'TeeThumb4.bmp'} // Do not localize
{$ELSE}
{$R TeeLegendScrollBar.res}
{$ENDIF}

type
  TToolAccess=class(TTeeCustomTool);

{ TScrollBarThumb }

Constructor TScrollBarThumb.Create(AOwner:TTeeCustomTool);
begin
  inherited Create;
  IScroll:=AOwner;

  FBrush:=TChartBrush.Create(TToolAccess(IScroll).CanvasChanged);
  FBrush.Color:=clSilver;
  FBrush.BackColor:=clSilver;

  FImage:=TTeePicture.Create;
  FImage.OnChange:=TToolAccess(IScroll).CanvasChanged;
  FGradient:=TTeeGradient.Create(TToolAccess(IScroll).CanvasChanged);
end;

Destructor TScrollBarThumb.Destroy;
begin
  FGradient.Free;
  FImage.Free;
  FBrush.Free;
  inherited;
end;

procedure TScrollBarThumb.Assign(Source:TPersistent);
begin
  if Source is TScrollBarThumb then
  with TScrollBarThumb(Source) do
  begin
    Self.Brush:=Brush;
    Self.Gradient:=Gradient;
    Self.Image:=Image;
    Self.FSize:=FSize;
    Self.FStyle:=FStyle;
  end;

  inherited;
end;

procedure TScrollBarThumb.SetBrush(const Value: TChartBrush);
begin
  FBrush.Assign(Value);
end;

procedure TScrollBarThumb.SetGradient(const Value: TTeeGradient);
begin
  FGradient.Assign(Value);
end;

procedure TScrollBarThumb.SetImage(const Value: TTeePicture);
begin
  FImage.Assign(Value);
end;

procedure TScrollBarThumb.SetSize(const Value: Integer);
begin
  TToolAccess(IScroll).SetIntegerProperty(FSize,Value);
end;

{ This function loads a bitmap from a resource linked to the executable }
Procedure LoadBitmapFromResourceName(ABitmap:TBitmap; const ResName: string);
begin
  {$IFDEF CLR}
  TeeLoadBitmap(ABitmap,ResName,'');
  {$ELSE}
  ABitmap.LoadFromResourceName(HInstance,ResName);
  {$ENDIF}
end;

procedure TScrollBarThumb.SetStyle(const Value: TScrollThumbStyle);
begin
  if FStyle<>Value then
  begin
    FStyle:=Value;

    case FStyle of
      stsThumb1: LoadBitmapFromResourceName(FImage.Bitmap,'TeeThumb1'); // Do not localize
      stsThumb2: LoadBitmapFromResourceName(FImage.Bitmap,'TeeThumb2'); // Do not localize
      stsThumb3: LoadBitmapFromResourceName(FImage.Bitmap,'TeeThumb3'); // Do not localize
      stsThumb4: LoadBitmapFromResourceName(FImage.Bitmap,'TeeThumb4'); // Do not localize
    else
      // stsCustom:
      FImage.Graphic:=nil;
    end;

    if Assigned(FImage.Graphic) then
    begin
      FSize:=FImage.Graphic.Width;
      TTeeScrollBar(IScroll).FSize:=FImage.Graphic.Height;
    end;

    TToolAccess(IScroll).CanvasChanged(Self);
  end;
end;

{ TTeeScrollBar }

Constructor TTeeScrollBar.Create(AOwner: TComponent);
begin
  inherited;
  FAutoRepeat:=True;
  FirstTime:=True;
  FMinSize:=4;
  FSize:=DefaultScrollBarSize;
  FInitial:=250;

  BackColor:=clScrollBar;
  Brush.Color:=clWhite;
  Pen.Color:=clWindowFrame;
  FArrowBrush:=TChartBrush.Create(CanvasChanged);

  FThumb:=TScrollBarThumb.Create(Self);
  FBevel:=bvRaised;
  FGradient:=TTeeGradient.Create(CanvasChanged);
end;

Destructor TTeeScrollBar.Destroy;
begin
  FGradient.Free;
  FThumb.Free;
  FArrowBrush.Free;
  FTimer.Free;
  inherited;
end;

function TTeeScrollBar.ClickedThumb(const P:TPoint): Boolean;
begin
  result:=PointInRect(ThumbRectangle,P);
end;

function TTeeScrollBar.ClickedInc(const P:TPoint): Boolean;
begin
  result:=PointInRect(IncRectangle,P);
end;

function TTeeScrollBar.ClickedDec(const P:TPoint): Boolean;
begin
  result:=PointInRect(DecRectangle,P);
end;

Function TTeeScrollBar.MainRectangle:TRect;
begin
  if Horizontal then
     result:=TeeRect(R.Left,R.Bottom,R.Right,R.Bottom+FSize)
  else
     result:=TeeRect(R.Right-FSize-1,R.Top,R.Right,R.Bottom);
end;

Function TTeeScrollBar.ScrollRectangle:TRect;
begin
  result:=MainRectangle;

  if Horizontal then
  begin
    Inc(result.Left,FSize);
    Dec(result.Right,FSize);
  end
  else
  begin
    Inc(result.Top,FSize);
    Dec(result.Bottom,FSize);
  end;
end;

Function TTeeScrollBar.ThumbRectangle:TRect;
begin
  if Horizontal then
  begin
     result:=TeeRect(ThumbBegin,R.Bottom+1,ThumbEnd,R.Bottom+FSize-1);
     if result.Right-result.Left<2 then
        Inc(result.Right);
  end
  else
     result:=TeeRect(R.Right-FSize,ThumbBegin,R.Right,ThumbEnd);
end;

Function TTeeScrollBar.DecRectangle:TRect;
begin
  if Horizontal then
     result:=TeeRect(R.Left,R.Bottom,R.Left+FSize,R.Bottom+FSize)
  else
     result:=TeeRect(R.Right-FSize-1,R.Top,R.Right,R.Top+FSize);
end;

Function TTeeScrollBar.IncRectangle:TRect;
begin
  if Horizontal then
     result:=TeeRect(R.Right-FSize,R.Bottom,R.Right,R.Bottom+FSize)
  else
     result:=TeeRect(R.Right-FSize-1,R.Bottom-FSize,R.Right,R.Bottom);
end;

procedure TTeeScrollBar.DrawDecArrow;
var tmpMargin : Integer;
begin
  tmpMargin:=FSize div 6;

  // Top Arrow
  with DecRectangle do
  begin
    if Horizontal then
    begin
      P1:=TeePoint(Left+tmpMargin,Top+(FSize div 2));
      P2:=TeePoint(Left+FSize-tmpMargin,Top+tmpMargin);
      P3:=TeePoint(Left+FSize-tmpMargin,Bottom-tmpMargin);
    end
    else
    begin
      P1:=TeePoint(Left+tmpMargin,Top+FSize-2*tmpMargin);
      P2:=TeePoint(Left+(FSize div 2),Top+tmpMargin);
      P3:=TeePoint(Left+FSize-tmpMargin,Top+FSize-2*tmpMargin);
    end;
  end;

  ParentChart.Canvas.Polygon([P1,P2,P3]);
end;

procedure TTeeScrollBar.DrawIncArrow;
var tmpMargin : Integer;
begin
  tmpMargin:=FSize div 6;

  // Bottom Arrow
  if Horizontal then
  begin
    with IncRectangle do
    begin
      P4:=TeePoint(Right-tmpMargin,Top+(FSize div 2));
      P5:=TeePoint(Right-FSize+tmpMargin,Top+tmpMargin);
      P6:=TeePoint(Right-FSize+tmpMargin,Bottom-tmpMargin);
    end;
  end
  else
  begin
    P4:=P1;
    P5:=P2;
    P6:=P3;

    P4.Y:=R.Bottom-FSize+2*tmpMargin;
    P6.Y:=P4.Y;
    P5.Y:=R.Bottom-tmpMargin;
  end;

  ParentChart.Canvas.Polygon([P4,P5,P6]);
end;

procedure TTeeScrollBar.Draw;

  procedure DrawArrows;
  begin
    // Arrows
    with ParentChart.Canvas do
    begin
      Pen.Style:=psClear;

      if FInDec or (Position=0) then
         AssignBrush(FArrowBrush,clDkGray)
      else
         AssignBrush(FArrowBrush);

      DrawDecArrow;
      FDecOutline:=False;

      if FInInc or (Position=TotalCount-CurrentCount) then
      begin
        AssignBrush(FArrowBrush,clDkGray);
        Brush.Bitmap:=nil;
        Brush.Color:=clDkGray;
      end
      else
         AssignBrush(FArrowBrush);

      DrawIncArrow;
      FIncOutline:=False;
    end;
  end;

var Num,
    tmpSize     : Integer;
    tmpItemSize : Double;
    tmpR        : TRect;
    IThumbSize  : Integer;
    tmp         : TGraphic;
begin
  if not Assigned(ParentChart) then
     exit;

  if ShouldDraw(R) then
  begin
    with ParentChart.Canvas do
    begin
      AssignBrush(Self.Brush);
      AssignVisiblePen(Self.Pen);

      if Self.Gradient.Visible then
      begin
        Self.Gradient.Draw(ParentChart.Canvas,MainRectangle);
        Brush.Style:=bsClear;
      end;

      Rectangle(MainRectangle);

      if Assigned(Self.Gradient) then
         AssignBrush(Self.Brush);

      Rectangle(DecRectangle);
      Rectangle(IncRectangle);

      DrawArrows;

      // Thumb
      Num:=TotalCount;

      if Num<>0 then
      begin
        if Self.FHorizontal then
           tmpSize:=R.Right-R.Left-2*FSize
        else
           tmpSize:=R.Bottom-R.Top-2*FSize;

        if FThumb.Size=0 then
        begin
          tmpItemSize:=tmpSize/Num;
          IThumbSize:=Math.Max(FMinSize,Round(CurrentCount*tmpItemSize));
        end
        else
        begin
          IThumbSize:=FThumb.Size;
          tmpItemSize:=tmpSize/Math.Max(1,(Num-CurrentCount+1));
        end;

        if Self.FHorizontal then
           ThumbBegin:=R.Left
        else
           ThumbBegin:=R.Top;

        Inc(ThumbBegin,FSize+Round(Position*tmpItemSize));

        ThumbEnd:=ThumbBegin+IThumbSize+1;

        // Thumb

        tmpR:=ThumbRectangle;

        tmp:=FThumb.Image.Filtered;

        if Assigned(tmp) then
        begin
          Dec(tmpR.Right);
          StretchDraw(tmpR,tmp);
          Inc(tmpR.Right);
        end
        else
        if FThumb.Gradient.Visible then
        begin
          Dec(tmpR.Right);
          FThumb.Gradient.Draw(ParentChart.Canvas,tmpR);
          Inc(tmpR.Right);
        end
        else
        begin
          AssignBrush(Self.ThumbBrush);
          Rectangle(tmpR);
        end;

        if Self.FBevel<>bvNone then
        begin
          Dec(tmpR.Right);
          DrawBevel(ParentChart.Canvas,Self.FBevel,tmpR,1);
        end;
      end;
    end;
  end;
end;

Procedure TTeeScrollBar.ApplyScroll(Delta:Double; ActivateTimer:Boolean);

  Procedure DoChange(const NewValue:Double);
  begin
    Position:=Round(NewValue);
    DoScroll;

    if ActivateTimer and FirstTime and FAutoRepeat then
    begin
      if not Assigned(FTimer) then
      begin
        FTimer:=TTimer.Create(Self);
        FTimer.OnTimer:=DoTimer;
      end;

      FTimer.Interval:=FInitial;
      FTimer.Enabled:=True;
    end;
  end;

begin
  if Delta<0 then
  begin
    Delta:=Math.Max(-Position,Delta);

    if Position>(Delta+1) then
       DoChange(Position+Delta);
  end
  else
  begin
    if (Position+Delta-1)<(TotalCount-CurrentCount) then
       DoChange(Position+Delta)
    else
       DoChange(TotalCount-CurrentCount); // <-- 7.04 scroll to bottom end
  end;
end;

function TTeeScrollBar.GetBackColor:TColor;
begin
  result:=Brush.BackColor;
end;

function TTeeScrollBar.GetThumbBrush:TChartBrush; // obsolete
begin
  result:=FThumb.Brush;
end;

function TTeeScrollBar.GetThumbSize:Integer; // obsolete
begin
  result:=FThumb.Size;
end;

Procedure TTeeScrollBar.HideDecOutline;
begin
  if FDecOutline then
  begin
    DrawDecOutline;
    FDecOutline:=False;
  end;
end;

Procedure TTeeScrollBar.HideIncOutline;
begin
  if FIncOutline then
  begin
    DrawIncOutline;
    FIncOutline:=False;
  end;
end;

Procedure TTeeScrollBar.ProcessClick(const P:TPoint);
var tmp : Integer;
begin
  OldPoint:=P;

  FInThumb:=False;
  FInDec:=False;
  FInInc:=False;

  if ClickedDec(P) then
  begin
    FInDec:=True;
    ApplyScroll(-1,True)
  end
  else
  if ClickedInc(P) then
  begin
    FInInc:=True;
    ApplyScroll(1,True)
  end
  else
  if ClickedThumb(P) then
     FInThumb:=True
  else
  if PointInRect(MainRectangle,P) then
  begin
    if Horizontal then tmp:=P.X
                  else tmp:=P.Y;

    if tmp<ThumbBegin then
       ApplyScroll(-DeltaMain,True)
    else
    if tmp>ThumbEnd then
       ApplyScroll(DeltaMain,True)
  end;
end;

Function TTeeScrollBar.CalcDelta(A,B:Integer):Double;
var tmpR : TRect;
begin
  if A=B then result:=0
  else
  begin
    tmpR:=ScrollRectangle;

    if Horizontal then
       result:=(TotalCount)/((tmpR.Right-tmpR.Left)/Abs(A-B))
    else
       result:=(TotalCount)/((tmpR.Bottom-tmpR.Top)/Abs(A-B));

    if A<B then result:=-result;
  end;
end;

procedure TTeeScrollBar.PrepareOutline;
begin
  with ParentChart.Canvas do
  begin
    Brush.Style:=bsClear;
    Pen.Style:=psSolid;
    Pen.Color:=clWhite;
    Pen.Width:=2;
    Pen.Mode:=pmXor;
  end;
end;

procedure TTeeScrollBar.DrawDecOutline;
begin
  PrepareOutline;
  DrawDecArrow;
end;

procedure TTeeScrollBar.DrawIncOutline;
begin
  PrepareOutline;
  DrawIncArrow;
end;

Procedure TTeeScrollBar.MouseMove(X,Y:Integer);
var tmp : Double;
begin
  if FInThumb then
  begin
    if Horizontal then tmp:=CalcDelta(X,OldPoint.X)
                  else tmp:=CalcDelta(Y,OldPoint.Y);

    if Abs(tmp)>=1 then
    begin
      ApplyScroll(tmp,False);
      OldPoint.X:=X;
      OldPoint.Y:=Y;
    end;
  end
  else
  if ClickedDec(TeePoint(X,Y)) then
  begin
    if (Position>0) and (not FDecOutline) then
    begin
      DrawDecOutline;
      FDecOutline:=True;
    end;
  end
  else
  begin
    HideDecOutline;

    if ClickedInc(TeePoint(X,Y)) then
    begin
      if (Position<(TotalCount-CurrentCount)) and (not FIncOutline) then
      begin
        DrawIncOutline;
        FIncOutline:=True;
      end;
    end
    else
      HideIncOutline;
  end;
end;

Procedure TTeeScrollBar.MouseUp;
begin
  FInThumb:=False;
  FInDec:=False;
  FInInc:=False;

  FirstTime:=True;
  if Assigned(FTimer) then
     FTimer.Enabled:=False;

  Repaint;
end;

Procedure TTeeScrollBar.DoScroll;
begin
  if Assigned(FOnScrolled) then FOnScrolled(Self);
end;

procedure TTeeScrollBar.SetThumb(const Value: TScrollBarThumb);
begin
  FThumb.Assign(Value);
end;

procedure TTeeScrollBar.SetThumbBrush(const Value: TChartBrush);
begin
  FThumb.Brush:=Value; // obsolete
end;

procedure TTeeScrollBar.SetThumbSize(const Value: Integer);
begin
  FThumb.Size:=Value; // obsolete
end;

procedure TTeeScrollBar.SetBevel(const Value: TPanelBevel);
begin
  if FBevel<>Value then
  begin
    FBevel:=Value;
    Repaint;
  end;
end;

procedure TTeeScrollBar.ChartEvent(AEvent:TChartToolEvent);
begin
  if AEvent=cteAfterDraw then
     Draw;
end;

procedure TTeeScrollBar.DoTimer(Sender: TObject);
begin
  ProcessClick(OldPoint);

  if FTimer.Interval>50 then
     FTimer.Interval:=50;
end;

procedure TTeeScrollBar.SetHorizontal(const Value: Boolean);
begin
  SetBooleanProperty(FHorizontal,Value);
end;

procedure TTeeScrollBar.ChartMouseEvent(AEvent: TChartMouseEvent;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  case AEvent of
    cmeDown: ProcessClick(TeePoint(X,Y));
    cmeMove: MouseMove(X,Y);
      cmeUp: MouseUp;
  end;
end;

function TTeeScrollBar.CurrentCount: Integer;
begin
  result:=ThumbLength;
end;

function TTeeScrollBar.GetPosition: Integer;
begin
  result:=FPosition;
end;

procedure TTeeScrollBar.Assign(Source:TPersistent);
begin
  if Source is TTeeScrollBar then
  with TTeeScrollBar(Source) do
  begin
    Self.ArrowBrush:=ArrowBrush;
    Self.AutoRepeat:=AutoRepeat;
    Self.BackColor:=BackColor;
    Self.Bevel:=Bevel;
    Self.DrawStyle:=DrawStyle;
    Self.Gradient:=Gradient;
    Self.InitialDelay:=InitialDelay;
    Self.MinThumbSize:=MinThumbSize;
    Self.Size:=Size;
    Self.Thumb:=Thumb;
  end;

  inherited;
end;

class function TTeeScrollBar.Description: String;
begin
  result:=TeeMsg_TeeScrollBar;
end;

procedure TTeeScrollBar.SetBackColor(const Value: TColor);
begin
  Brush.BackColor:=Value;
end;

class function TTeeScrollBar.GetEditorClass: String;
begin
  result:='TScrollBarEditor'; // Do not localize
end;

procedure TTeeScrollBar.SetPosition(Value: Integer);
begin
  SetIntegerProperty(FPosition,Value);
  if Assigned(FOnSetPosition) then
     FOnSetPosition(Self,Value);
end;

procedure TTeeScrollBar.SetArrowBrush(const Value: TChartBrush);
begin
  FArrowBrush.Assign(Value);
end;

function TTeeScrollBar.DeltaMain: Integer;
begin
  result:=CurrentCount div 4;
end;

function TTeeScrollBar.ShouldDraw(var R: TRect): Boolean;
begin
  result:=TotalCount>0;
end;

function TTeeScrollBar.TotalCount: Integer;
begin
  result:=Max;
end;

procedure TTeeScrollBar.SetSize(const Value: Integer);
begin
  if FSize<>Value then
  begin
    SetIntegerProperty(FSize,Value);
    if Assigned(FOnChangeSize) then
       FOnChangeSize(Self);
  end;
end;

procedure TTeeScrollBar.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  Repaint;
end;

procedure TTeeScrollBar.SetGradient(const Value: TTeeGradient);
begin
  FGradient.Assign(Value);
end;

procedure TTeeScrollBar.SetMinSize(const Value: Integer);
begin
  SetIntegerProperty(FMinSize,Value);
end;

{ TLegendScrollBar }

function TLegendScrollBar.ShouldDraw(var R:TRect):Boolean;
begin
  if Assigned(ParentChart) then
  begin
    L:=TCustomChart(ParentChart).Legend;

    // 8.0 This takes priority. TV52011438
    result:=L.ShouldDraw and (L.TotalLegendItems>0);

    if result then
       result:=(L.LastValue>-1) and
              ((DrawStyle=dsAlways) or (L.LastValue+1<L.TotalLegendItems)
                or (L.FirstValue>0));

    if result then
    begin
      FHorizontal:=not L.Vertical;
      R:=L.ShapeBounds;
    end;
  end
  else
    result:=False;
end;

function TLegendScrollBar.HasPaging:Boolean;
begin
  result:=ParentChart.MaxPointsPerPage>0;
end;

function TLegendScrollBar.TotalCount:Integer;
begin
  if HasPaging then
     result:=ParentChart.Pages.Count
  else
     result:=L.TotalLegendItems+L.FirstValue;
end;

function TLegendScrollBar.CurrentCount:Integer;
begin
  if HasPaging then
     result:=1
  else
     result:=L.LastValue-L.FirstValue+1;
end;

function TLegendScrollBar.GetPosition:Integer;
begin
  if HasPaging then
     result:=ParentChart.Pages.Current-1
  else
     result:=L.FirstValue;
end;

procedure TLegendScrollBar.SetPosition(Value:Integer);
begin
  if HasPaging then
     ParentChart.Pages.Current:=Value+1
  else
     L.FirstValue:=Value;
end;

procedure TLegendScrollBar.LegendCalcSize(Sender:TCustomChartLegend; var ASize:Integer);
begin
  if Active and ShouldDraw(R) then
     Inc(ASize,Size+1);
end;

procedure TLegendScrollBar.SetParentChart(const Value: TCustomAxisPanel);
begin
  SetLegendEvent(nil);
  inherited;
  SetLegendEvent(LegendCalcSize);
end;

class function TLegendScrollBar.Description: String;
begin
  result:=TeeMsg_LegendScrollbar;
end;

function TLegendScrollBar.DeltaMain: Integer;
begin
  if ParentChart.MaxPointsPerPage>0 then
     result:=1
  else
     result:=inherited DeltaMain;
end;

Destructor TLegendScrollBar.Destroy;
begin
  SetLegendEvent(nil);
  inherited;
end;

type
  TLegendAccess=class(TChartLegend);

procedure TLegendScrollBar.SetLegendEvent(Value:TLegendCalcSize);
begin
  if Assigned(ParentChart) and Assigned(TCustomChart(ParentChart).Legend) then
     TLegendAccess(TCustomChart(ParentChart).Legend).FOnCalcSize:=Value;
end;

class function TLegendScrollBar.LongDescription: String;
begin
  result:=TeeMsg_LegendScrollDesc;
end;

{ TScrollbarEditor }

procedure TScrollbarEditor.FormShow(Sender: TObject);
begin
  TeeScroll:=TTeeScrollBar(Tag);

  if Assigned(TeeScroll) then
  with TeeScroll do
  begin
    ButtonPen1.LinkPen(Pen);
    ComboBox1.ItemIndex:=Ord(Bevel);
    CBAuto.Checked:=AutoRepeat;
    UDSize.Position:=Size;
    UDDelay.Position:=InitialDelay;
    UDThumbSize.Position:=Thumb.Size;

    ButtonColor1.LinkProperty(TeeScroll,'BackColor'); // Do not localize

    BGradient.Gradient:=Gradient;
    BThumbGrad.Gradient:=Thumb.Gradient;
    CBStyle.ItemIndex:=Ord(Thumb.Style);

    EnableFilters;
  end;
end;

procedure TScrollbarEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,TeeScroll.ThumbBrush)
end;

procedure TScrollbarEditor.Button2Click(Sender: TObject);
begin
  EditChartBrush(Self,TeeScroll.Brush)
end;

procedure TScrollbarEditor.ComboBox1Change(Sender: TObject);
begin
  TeeScroll.Bevel:=TPanelBevel(ComboBox1.ItemIndex);
end;

procedure TScrollbarEditor.CBAutoClick(Sender: TObject);
begin
  TeeScroll.AutoRepeat:=CBAuto.Checked;
end;

procedure TScrollbarEditor.Edit1Change(Sender: TObject);
begin
  if Showing and Assigned(TeeScroll) then
     TeeScroll.Size:=UDSize.Position;
end;

procedure TScrollbarEditor.Button3Click(Sender: TObject);
begin
  EditChartBrush(Self,TeeScroll.ArrowBrush)
end;

procedure TScrollbarEditor.Edit2Change(Sender: TObject);
begin
  if Showing and Assigned(TeeScroll) then
     TeeScroll.InitialDelay:=UDDelay.Position;
end;

procedure TScrollbarEditor.Edit3Change(Sender: TObject);
begin
  if Showing and Assigned(TeeScroll) then
     TeeScroll.ThumbSize:=UDThumbSize.Position;
end;

procedure TScrollbarEditor.BFiltersClick(Sender: TObject);
begin
  ShowFiltersEditor(Self, TeeScroll.Thumb.Image);
end;

procedure TScrollbarEditor.BBrowseClick(Sender: TObject);
begin
  TeeScroll.Thumb.Image.Assign(nil);
  TeeLoadClearImage(Self,TeeScroll.Thumb.Image);
  EnableFilters;
end;

procedure TScrollbarEditor.EnableFilters;
begin
  BFilters.Enabled:=TeeScroll.Thumb.Image.Graphic<>nil;
end;

procedure TScrollbarEditor.CBStyleChange(Sender: TObject);
begin
  TeeScroll.Thumb.Style:=TScrollThumbStyle(CBStyle.ItemIndex);
  EnableFilters;
end;

initialization
  RegisterClass(TScrollbarEditor);
  RegisterTeeTools([TLegendScrollBar]);
finalization
  UnRegisterTeeTools([TLegendScrollBar]);
end.
