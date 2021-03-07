{**********************************************}
{   TAntiAliasTool and Editor                  }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeAntiAlias;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
  {$ENDIF}
  TeeFilters, TeEngine, Chart, TeCanvas;

type
  TAntiAliasTool=class;

  TAntiAlias=(aaYes, aaNo);

  TPenDots=Array[0..7] of Boolean;

  TAntiAliasCanvas=class(TTeeCanvas3D)
  private
    FAlias   : TAntiAlias;
    FCurrent : TPoint;

    IAlias   : Boolean;
    r,g,b    : Byte;
    dist     : Single;
    oneDist  : Single;
    IFilter  : TTeeFilter;
    IDC      : TTeeCanvasHandle;
    ITool    : TAntiAliasTool;

    IPenColor    : TColor;
    IPenSmallDot : Boolean;
    IPenStyle    : TPenStyle;
    IPenWidth    : Integer;

    procedure BlendColor1(const AX,AY:Integer);
    procedure BlendColor2(const AX,AY:Integer);
    procedure CalcArcAngles(X1,Y1,X2,Y2,X3,Y3,X4,Y4:Integer;
                            out StartAngle:Double; out EndAngle:Double);
    procedure CheckBufferLines;
    procedure GetPenDots(out Dots:TPenDots; out Solid:Boolean);
    procedure SetAntiAlias(const Value:TAntiAlias);
  protected
    Procedure PolygonFour; override;
    Procedure SetBitmap(ABitmap:TBitmap); override;
    Procedure SetUseBuffer(Value:Boolean); override;
  public
    Destructor Destroy; override;

    procedure Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer); override;
    procedure Arc(const Left, Top, Right, Bottom:Integer; StartAngle,EndAngle:Double); override;
    procedure AssignVisiblePenColor(APen:TPen; AColor:TColor); override;
    procedure Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                     Const StartAngle,EndAngle,HolePercent:Double); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    Procedure GradientFill( Const Rect : TRect; StartColor : TColor;
                            EndColor   : TColor; Direction  : TGradientDirection;
                            Balance    : Integer=50;
                            RadialX    : Integer=0;
                            RadialY    : Integer=0); override;

    Function InitWindow( DestCanvas:TCanvas; A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;
    procedure LineTo(X,Y:Integer); override;
    procedure MoveTo(X,Y:Integer); override;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    Procedure Polygon(const Points:Array of TPoint); override;
    Procedure Polyline(const Points:{$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF}); override;
    procedure RoundRect(X1,Y1,X2,Y2,X3,Y3:Integer); override;

    property AntiAlias:TAntiAlias read FAlias write SetAntiAlias default aaYes;
    property Current:TPoint read FCurrent write FCurrent;
  end;

  TAntiAliasTool=class(TTeeCustomTool)
  private
    FCanvas  : TAntiAliasCanvas;
    FFilters : TFilterItems;

    procedure CheckParentCanvas;
    function FiltersStored:Boolean;
    function GetAntiAlias:Boolean;
    procedure ReadFilters(Reader: TReader);
    procedure SetFilters(Const Value:TFilterItems);
    procedure SetAntiAlias(Const Value:Boolean);
    procedure WriteFilters(Writer: TWriter);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    procedure DefineProperties(Filer:TFiler); override;
    class function GetEditorClass: String; override;
    procedure SetActive(Value:Boolean); override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    function Bitmap:TBitmap;
    class Function Description:String; override;
    class Function LongDescription:String; override;

    property Canvas:TAntiAliasCanvas read FCanvas;
  published
    property Active;
    property AntiAlias:Boolean read GetAntiAlias write SetAntiAlias default True;
    property Filters:TFilterItems read FFilters write SetFilters stored False;
  end;

  TAntiAliasEditor = class(TForm)
    Button1: TButton;
    CBAnti: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBAntiClick(Sender: TObject);
  private
    { Private declarations }
    Tool : TAntiAliasTool;
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
  Math, TeeFiltersEditor, TeeProcs, TeeProCo;

const
  Small      : TPenDots=(True,False,True,False,True,False,True,False);
  Dot        : TPenDots=(True,True,False,False,True,True,False,False);
  Dash       : TPenDots=(True,True,True,False,True,True,True,False);
  DashDot    : TPenDots=(True,True,True,False,True,False,True,False);
  DashDotDot : TPenDots=(True,True,True,False,True,False,True,False);

procedure TAntiAliasEditor.Button1Click(Sender: TObject);
var tmp : TBitmap;

  procedure CreateBitmap;
  var Old : Boolean;
  begin
    Old:=Tool.Active;
    Tool.Active:=False;
    try
      tmp:=Tool.ParentChart.TeeCreateBitmap;
    finally
      Tool.Active:=Old;

      if Old then
         Tool.ParentChart.Draw;
    end;
  end;

var OldAuto : Boolean;
    tmpOk   : Boolean;
begin
  tmpOk:=False;
  
  OldAuto:=Tool.ParentChart.AutoRepaint;
  Tool.ParentChart.AutoRepaint:=False;
  try
    CreateBitmap;
    try
      tmpOk:=ShowFiltersEditor(Self,tmp,Tool.Filters);
    finally
      tmp.Free;
    end;
  finally
    Tool.ParentChart.AutoRepaint:=OldAuto;

    if tmpOk then
       Tool.Repaint;
  end;
end;

procedure TAntiAliasEditor.FormShow(Sender: TObject);
begin
  Tool:=TAntiAliasTool(Tag);

  if Assigned(Tool) then
     CBAnti.Checked:=Tool.AntiAlias;
end;

procedure TAntiAliasEditor.CBAntiClick(Sender: TObject);
begin
  if Assigned(Tool) then
     Tool.AntiAlias:=CBAnti.Checked;
end;

{ TAntiAliasTool }

Constructor TAntiAliasTool.Create(AOwner: TComponent);
begin
  inherited;
  FFilters:=TFilterItems.Create(Self,TTeeFilter);
  AntiAlias:=True;
end;

Destructor TAntiAliasTool.Destroy;
begin
  if Assigned(FCanvas) then
  begin
    if Assigned(ParentChart) and (ParentChart.Canvas=FCanvas) then
    begin
      FCanvas.ITool:=nil;
      FCanvas:=nil;
    end
    else
       FreeAndNil(FCanvas);
  end;

  FFilters.Free;
  inherited;
end;

procedure TAntiAliasTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if (AEvent=cteAfterDraw) and (Filters.Count>0) and (Bitmap<>nil) then
     Filters.ApplyTo(Bitmap);
end;

function TAntiAliasTool.Bitmap:TBitmap;
begin
  if Assigned(ParentChart) and (ParentChart.Canvas is TTeeCanvas3D) then
     result:=TTeeCanvas3D(ParentChart.Canvas).Bitmap
  else
     result:=nil;
end;

procedure TAntiAliasTool.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('FilterItems',ReadFilters,WriteFilters,FiltersStored); // Do not localize
end;

function TAntiAliasTool.FiltersStored:Boolean;
begin
  result:=Assigned(FFilters) and (FFilters.Count>0);
end;

function TAntiAliasTool.GetAntiAlias:Boolean;
begin
  result:=Assigned(FCanvas) and (FCanvas.AntiAlias=aaYes);
end;

procedure TAntiAliasTool.ReadFilters(Reader: TReader);
begin
  TTeePicture.ReadFilters(Reader,Filters);
end;

procedure TAntiAliasTool.SetAntiAlias(Const Value:Boolean);
begin
  if not Assigned(FCanvas) then
  begin
    FCanvas:=TAntiAliasCanvas.Create;
    FCanvas.ITool:=Self;
  end;

  if Value then
     FCanvas.AntiAlias:=aaYes
  else
     FCanvas.AntiAlias:=aaNo;

  CheckParentCanvas;
end;

procedure TAntiAliasTool.SetFilters(const Value: TFilterItems);
begin
  FFilters.Assign(Value);
end;

procedure TAntiAliasTool.WriteFilters(Writer: TWriter);
begin
  TTeePicture.WriteFilters(Writer,Filters);
end;

class function TAntiAliasTool.Description: String;
begin
  result:=TeeMsg_AntiAlias;
end;

class function TAntiAliasTool.LongDescription: String;
begin
  result:=TeeMsg_AntiAliasDesc;
end;

class function TAntiAliasTool.GetEditorClass: String;
begin
  result:='TAntiAliasEditor'; // Do not localize
end;

procedure TAntiAliasTool.SetActive(Value:Boolean);
begin
  inherited;
  SetAntiAlias(Active);
end;

procedure TAntiAliasTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  CheckParentCanvas;
end;

procedure TAntiAliasTool.CheckParentCanvas;
begin
  if Active and AntiAlias and Assigned(ParentChart) and
     (ParentChart.Canvas<>FCanvas) then
        ParentChart.Canvas:=FCanvas;
end;

{ TAntiAliasCanvas }

Destructor TAntiAliasCanvas.Destroy;
begin
  if Assigned(ITool) and (ITool.FCanvas=Self) then
     ITool.FCanvas:=nil;

  IFilter.Free;
  inherited;
end;

procedure TAntiAliasCanvas.GetPenDots(out Dots:TPenDots; out Solid:Boolean);
begin
    if IPenSmallDot then
       Dots:=Small
    else
    case Pen.Style of
      psSolid: Solid:=True;
        psDot: Dots:=Dot;
       psDash: Dots:=Dash;
    psDashDot: Dots:=DashDot;
 psDashDotDot: Dots:=DashDotDot;
    end;
end;

procedure TAntiAliasCanvas.CalcArcAngles(X1,Y1,X2,Y2,X3,Y3,X4,Y4:Integer;
                                out StartAngle:Double; out EndAngle:Double);
const
  HalfDivPi=180.0/Pi;
var
  XC,YC : Integer;
begin
  XC := (X2+X1) div 2;
  YC := (Y2+Y1) div 2;

  StartAngle:=ArcTan2(YC-Y3,X3-XC);
  if StartAngle<0 then
     StartAngle:=StartAngle+2.0*Pi;

  StartAngle:=StartAngle*HalfDivPi;

  EndAngle:=ArcTan2(YC-Y4,X4-XC);
  if EndAngle<0 then
     EndAngle:=EndAngle+2.0*Pi;

  EndAngle:=EndAngle*HalfDivPi;
end;

procedure TAntiAliasCanvas.Arc(const Left,Top,Right,Bottom:Integer; StartAngle,EndAngle:Double);
var midX,midY,
    oldX,oldY,
    xs,ys,
    dx,dy : Integer;
    deltaX,
    deltaY,
    startX,
    endX,
    startY,
    endY,
    tmpXt,
    tmpYt,
    radiusX,
    radiusY : Integer;
    sx,sy,
    xt,yt,
    angle,
    eAngle : Double;
    bgColor : TRGB;
    tmpDots : TPenDots;
    ISolid  : Boolean;
    tmpDir  : Boolean;
begin
  if not IAlias then
     inherited Arc(Left,Top,Right,Bottom,StartAngle,EndAngle)
  else
  begin
    {$IFDEF CLX}
    tmpDir:=True;
    {$ELSE}
    tmpDir:=GetArcDirection(Handle)=AD_CLOCKWISE;
    {$ENDIF}

    if not tmpDir then
    begin
//      SwapDouble(StartAngle,EndAngle);
    end;

    midX := (Left + Right) div 2;
    midY := (Top + Bottom) div 2;
    dx := (Right-Left);
    dy := (Bottom-Top);
    radiusX := Abs(dx) div 2;
    radiusY := Abs(dy) div 2;

    IPenColor:=ColorToRGB(Pen.Color);

    r:=GetRValue(IPenColor);
    g:=GetGValue(IPenColor);
    b:=GetBValue(IPenColor);

    ISolid:=False;
    GetPenDots(tmpDots,ISolid);

    Angle:=0;

    while (Angle+90) < StartAngle do
          Angle:=Angle+90;

    while angle < endAngle do
    begin
      if startAngle >= angle then
      begin
        if endAngle <= angle+90 then
           eAngle := endAngle
        else
           eAngle := angle+90;

        sx:=radiusX*Cos(startAngle*TeePiStep);

        if sx > 0 then
           sx :=sx+ 0.5
        else
           sx :=sx- 0.5;

        startX:=Trunc(sx);
        endX:=Trunc(radiusX*Cos(eAngle*TeePiStep));

        if (endX - startX <> 0) then
           deltaX := Trunc((endX-startX) / Abs(endX-startX))
        else
           deltaX := 0;

        sy := radiusY*Sin(startAngle*TeePiStep);
        if sy > 0 then
           sy :=sy+ 0.5
        else
           sy :=sy- 0.5;

        startY:=Trunc(sy);
        endY:=Trunc(radiusY*Sin(eAngle*TeePiStep));

        if (endY - startY <> 0) then
           deltaY := Trunc((endY-startY) / Abs(endY-startY))
        else
           deltaY := 0;

        if deltaX <> 0 then
        begin
          oldY:=startY;
          xs:=startX;

          while xs <> endX do
          begin
            yt:= radiusY * Sqrt(1-(xs*xs)/(radiusX*radiusX));
            tmpYt:=Floor(yt);

            if Abs(oldY - tmpYt) < 2 then
            begin
              dist:=yt - tmpYt;
              oneDist:=1-dist;

              if deltaX < 0 then
                 BlendColor1(midX+xs,midY+tmpYt)
              else
                 BlendColor1(midX+xs,midY-tmpYt);

              if deltaX < 0 then
                 BlendColor2(midX+xs,midY+tmpYt+1)
              else
                 BlendColor2(midX+xs,midY-tmpYt-1);
            end;

            oldY:=tmpYt;
            Inc(xs,deltaX);
          end;
        end;

        if deltaY <> 0 then
        begin
          oldX := startX;
          ys := startY;

          while ys <> endY do
          begin
            xt:= radiusX * Sqrt(1-(ys*ys)/(radiusY*radiusY));
            tmpXt:=Floor(xt);

            if Abs(oldX - tmpXt) < 2 then
            begin
              dist:=xt - tmpXt;
              oneDist:=1-dist;

              if deltaX < 0 then
                 if deltaY > 0 then
                    BlendColor1(midX+tmpXt,midY+ys)
                 else
                    BlendColor1(midX-tmpXt,midY+ys)
              else
                 if deltaY < 0 then
                    BlendColor1(midX-tmpXt,midY+ys)
                 else
                    BlendColor1(midX+tmpXt,midY+ys);

              if deltaX < 0 then
                 if deltaY > 0 then
                    BlendColor2(midX+tmpXt+1,midY+ys)
                 else
                    BlendColor2(midX-tmpXt-1,midY+ys)
              else
                 if deltaY < 0 then
                    BlendColor2(midX-tmpXt-1,midY+ys)
                 else
                    BlendColor2(midX+tmpXt+1,midY+ys);
            end;

            oldX:=tmpXt;
            Inc(ys,deltaY);
          end;
        end;
      end;

      angle:=angle+90;
      StartAngle:=Angle;
    end;
  end;
end;

procedure TAntiAliasCanvas.Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer);
var StartAngle : Double;
    EndAngle   : Double;
begin
  if not IAlias then
     inherited
  else
  begin
    CalcArcAngles(Left,Top,Right,Bottom,StartX,StartY,EndX,EndY,StartAngle,EndAngle);
    Arc(Left,Top,Right,Bottom,StartAngle,EndAngle);
  end;
end;

procedure TAntiAliasCanvas.AssignVisiblePenColor(APen:TPen; AColor:TColor);
begin
  inherited;
  IPenColor:=AColor;
  IPenSmallDot:=(APen is TChartPen) and TChartPen(APen).SmallDots;
  IPenStyle:=APen.Style;
  IPenWidth:=APen.Width;
end;

procedure TAntiAliasCanvas.Donut(XCenter, YCenter, XRadius, YRadius: Integer;
  const StartAngle, EndAngle, HolePercent: Double);

var tmpXRadius,
    tmpYRadius  : Integer;
    Old : TBrushStyle;
begin
  inherited;

  if IAlias then
  begin
    Old:=Brush.Style;
    Brush.Style:=bsClear;

    Arc(XCenter-XRadius,YCenter-YRadius,XCenter+XRadius,YCenter+YRadius,
        StartAngle*180/Pi,EndAngle*180/Pi);

    tmpXRadius:=Round(HolePercent*XRadius*0.01);
    tmpYRadius:=Round(HolePercent*YRadius*0.01);

    Arc(XCenter-tmpXRadius,YCenter-tmpYRadius,XCenter+tmpXRadius,YCenter+tmpYRadius,
        EndAngle*180/Pi,StartAngle*180/Pi);

    Brush.Style:=Old;
  end;
end;

procedure TAntiAliasCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
var
  a : Boolean;

  // Bresenham ellipse algorithm
  procedure DrawEllipse(CX, CY, XRadius, YRadius, DecX, DecY : Integer);

    procedure PutPixel(x,y,OffX,OffY:Integer);
    begin
      SetPixel(x,y,IPenColor);

      dist:=0.4;
      oneDist:=1-dist;

      if not a then
      begin
        BlendColor1(x,y+OffY);
        BlendColor2(x+OffX,y);
      end
      else
      begin
        BlendColor1(x+OffX,y);
        BlendColor2(x,y+OffY);
      end;
    end;

    procedure DrawPoints(X,Y:Integer);
    begin
      PutPixel(CX+X-DecX, CY+Y-DecY, 1, 1);  // Right-bottom
      PutPixel(CX-X, CY+Y-DecY, -1, 1);  // Left-bottom
      PutPixel(CX-X, CY-Y, -1, -1);  // Left-top
      PutPixel(CX+X-DecX, CY-Y, 1, -1); // Right-top
    end;

  var X, Y : Integer;
      XChange,
      YChange : Integer;
      EllipseError : Integer;
      tmpX, tmpY: Integer;
      StoppingX,
      StoppingY : Integer;
  begin
    tmpX:= 2*XRadius*XRadius;
    tmpY:= 2*YRadius*YRadius;

    X:=XRadius;
    Y:=0;
    XChange:=YRadius*YRadius*(1-2*XRadius);
    YChange:=XRadius*XRadius;
    EllipseError:=0;
    StoppingX:=tmpY*XRadius;
    StoppingY:=0;

    while StoppingX >= StoppingY do
    begin
      DrawPoints(X,Y);
      Inc(Y);
      Inc(StoppingY, tmpX);
      Inc(EllipseError, YChange);
      Inc(YChange,tmpX);

      if ((2*EllipseError + XChange) > 0 ) then
      begin
        Dec(X);
        Dec(StoppingX, tmpY);
        Inc(EllipseError, XChange);
        Inc(XChange,tmpY);
        a:=True
      end
      else a:=False;
    end;

    X:=0;
    Y:=YRadius;
    XChange:=YRadius*YRadius;
    YChange:=XRadius*XRadius*(1-2*YRadius);
    EllipseError:=0;
    StoppingX:=0;
    StoppingY:=tmpX*YRadius;

    while StoppingX <= StoppingY do
    begin
      DrawPoints(X,Y);
      Inc(X);
      Inc(StoppingX, tmpY);
      Inc(EllipseError, XChange);
      Inc(XChange,tmpY);

      if ((2*EllipseError + YChange) > 0 ) then
      begin
        Dec(Y);
        Dec(StoppingY, tmpX);
        Inc(EllipseError, YChange);
        Inc(YChange,tmpX);
        a:=True;
      end
      else a:=False;
    end
  end;

var OldColor : TColor;
    OldStyle : TPenStyle;
    tmp      : Boolean;
    ISolid   : Boolean;
    tmpDots  : TPenDots;
    DecX     : Integer;
    DecY     : Integer;
begin
  if not IAlias then
     inherited
  else
  begin
    IPenColor:=ColorToRGB(Pen.Color);

    OldColor:=IPenColor;
    OldStyle:=IPenStyle;

    tmp:=Pen.Style=psSolid;

    if tmp then
       Pen.Style:=psClear
    else
    begin
      OldColor:=Brush.Color;
      tmp:=Brush.Style<>bsClear;
    end;

    inherited;

    if tmp then
    begin
      Pen.Style:=psSolid;
      IPenColor:=OldColor;

      r:=GetRValue(IPenColor);
      g:=GetGValue(IPenColor);
      b:=GetBValue(IPenColor);

      ISolid:=False;
      GetPenDots(tmpDots,ISolid);

      DecX:=(x2-x1) mod 2;
      if DecX=0 then DecX:=2;

      DecY:=(y2-y1) mod 2;
      if DecY=0 then DecY:=2;

      DrawEllipse( (x1+x2) div 2,(y1+y2) div 2,(x2-x1) div 2,(y2-y1) div 2,
                   DecX,  DecY);
    end;

    IPenColor:=OldColor;
    Pen.Style:=OldStyle;
  end;
end;

Procedure TAntiAliasCanvas.GradientFill( Const Rect : TRect; StartColor : TColor;
                            EndColor   : TColor; Direction  : TGradientDirection;
                            Balance    : Integer=50;
                            RadialX    : Integer=0;
                            RadialY    : Integer=0);
var Old : Boolean;
begin
  Old:=IAlias;
  IAlias:=False;

  inherited;

  IAlias:=Old;
end;

function TAntiAliasCanvas.InitWindow(DestCanvas: TCanvas; A3DOptions: TView3DOptions;
  ABackColor: TColor; Is3D: Boolean; const UserRect: TRect): TRect;
begin
  result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);

  CheckBufferLines;

  IDC:=Handle;
end;

procedure TAntiAliasCanvas.CheckBufferLines;
begin
  IAlias:=(not Metafiling) and (AntiAlias=aaYes) and UseBuffer;

  if IAlias and Assigned(Bitmap) then
  begin
    if not Assigned(IFilter) then
       IFilter:=TTeeFilter.Create(nil);

    IFilter.Apply(Bitmap,TeeZeroRect);
  end
  else
    FreeAndNil(IFilter);
end;

Procedure TAntiAliasCanvas.SetUseBuffer(Value:Boolean);
begin
  inherited;
  CheckBufferLines;
end;

Procedure TAntiAliasCanvas.SetBitmap(ABitmap:TBitmap);
begin
  inherited;
  CheckBufferLines;
end;

{$IFOPT R+}
{$DEFINE WASRANGE}
{$ENDIF}

procedure TAntiAliasCanvas.BlendColor1(const AX,AY:Integer);
var AColor : TRGB;
    rr,gg,bb : Byte;
begin
  {$IFNDEF CLX}
  if PtVisible(IDC,AX,AY) then
     if Assigned(IFilter) then
     {$R-}
     with IFilter.Lines[AY,AX] do
     {$IFDEF WASRANGE}
     {$R+}
     {$ENDIF}
     begin
      if ((AX>0) and (AX<Bitmap.Width) and
          (AY>0) and (AY<Bitmap.Height)) then
      begin
       Red:=Round(dist*(Red-r))     + r;
       Green:=Round(dist*(Green-g)) + g;
       Blue:=Round(dist*(Blue-b))   + b;
      end;
     end
     else
  {$ENDIF}
     begin
       AColor:=RGBValue(GetPixel(AX,AY));

       rr:=Round(dist*(AColor.Red-r))   + r;
       gg:=Round(dist*(AColor.Green-g)) + g;
       bb:=Round(dist*(AColor.Blue-b))  + b;

       SetPixel(AX,AY,(rr or (gg shl 8) or (bb shl 16)));
     end;
end;

procedure TAntiAliasCanvas.BlendColor2(const AX,AY:Integer);
var AColor   : TRGB;
    rr,gg,bb : Byte;
begin
  {$IFNDEF CLX}
  if PtVisible(IDC,AX,AY) then
     if Assigned(IFilter) then
     {$R-}
     with IFilter.Lines[AY,AX] do
     {$IFDEF WASRANGE}
     {$R+}
     {$ENDIF}
     begin
      if ((AX>0) and (AX<Bitmap.Width) and
          (AY>0) and (AY<Bitmap.Height)) then
      begin
       Red:=Round(oneDist*(Red-r))     + r;
       Green:=Round(oneDist*(Green-g)) + g;
       Blue:=Round(oneDist*(Blue-b))   + b;
      end;
     end
     else
  {$ENDIF}
     begin
       AColor:=RGBValue(GetPixel(AX,AY));

       rr:=Round(oneDist*(AColor.Red-r))   + r;
       gg:=Round(oneDist*(AColor.Green-g)) + g;
       bb:=Round(oneDist*(AColor.Blue-b))  + b;

       SetPixel(AX,AY, (rr or (gg shl 8) or (bb shl 16)));
     end;
end;

procedure TAntiAliasCanvas.SetAntiAlias(const Value:TAntiAlias);
begin
  if FAlias<>Value then
  begin
    FAlias:=Value;

    if Assigned(View3DOptions) then
       View3DOptions.Repaint;
  end;
end;

procedure TAntiAliasCanvas.LineTo(X, Y: Integer);
var tmpX,tmpY,
    tmpXt,tmpYt,
    Old,
    tmp,
    t,
    dx,dy,xs,ys : Integer;
    xt,yt,k: Single;
    tmpDots : TPenDots;
    OldP    : TPoint;
    ISolid  : Boolean;
begin
  tmpX:=X;
  tmpY:=Y;

  dx:=x-Current.x;
  dy:=y-Current.y;

  if (not IAlias) or
     (Pen.Style=psClear) or
     ((Pen.Style<>psClear) and ((dx=0) or (dy=0))) then
  begin
    inherited;

    FCurrent.X:=tmpX;
    FCurrent.Y:=tmpY;
    exit;
  end;

  if (not IPenSmallDot) and (IPenWidth=1) then
     IPenColor:=ColorToRGB(Pen.Color);

  if IPenWidth>1 then
  begin
    Old:=IPenWidth;
    IPenWidth:=1;
    Pen.Width:=1;
    IPenColor:=ColorToRGB(Pen.Color);

    OldP:=Current;

    for t:=0 to Old-1 do
    begin
      IAlias:=(t=0) or (t=Old-1);

      tmp:=(Old div 2)-t;

      if Abs(dy)>Abs(dx) then
      begin
        MoveTo(OldP.X-tmp,OldP.Y);
        LineTo(X-tmp,Y);
      end
      else
      begin
        MoveTo(OldP.X,OldP.Y-tmp);
        LineTo(X,Y-tmp);
      end;
    end;

    IPenWidth:=Old;
    Pen.Width:=IPenWidth;
    IAlias:=True;
  end
  else
  begin
    SetPixel(Current.x, Current.y, IPenColor);

    if (dx<>0) or (dy<>0) then
    begin
      ISolid:=False;
      GetPenDots(tmpDots,ISolid);

      r:=GetRValue(IPenColor);
      g:=GetGValue(IPenColor);
      b:=GetBValue(IPenColor);

      if Abs(dx)>Abs(dy) then
      begin
        if dx < 0 then
        begin
          SwapInteger(FCurrent.x,x);
          SwapInteger(FCurrent.y,y);
        end;

        k:=dy/dx;
        yt:=Current.y;
        xs:=Current.x+1;

        if ISolid then
        begin
          while (xs<x) and (xs<Bitmap.Width) do
          begin
            yt:=yt+k;
            tmpYt:=Floor(yt);

            if tmpYt < 0 then tmpYt:=0;
            if tmpYt > Bitmap.Height then tmpYt:=Bitmap.Height-2;

            dist:=yt-tmpYt;
            oneDist:=1-dist;

            BlendColor1(xs, tmpYt);
            BlendColor2(xs, tmpYt+1);

            Inc(xs);
          end;
        end
        else
        begin
          while xs<x do
          begin
            yt:=yt+k;

            if tmpDots[xs mod 8] then
            begin
              tmpYt:=Floor(yt);

              dist:=yt-tmpYt;
              oneDist:=1-dist;

              BlendColor1(xs, tmpYt);
              BlendColor2(xs, tmpYt+1);
            end;

            Inc(xs);
          end;
        end;
      end
      else
      begin
        if dy < 0 then
        begin
          SwapInteger(FCurrent.x,x);
          SwapInteger(FCurrent.y,y);
        end;

        k:=dx/dy;
        xt:=Current.x;
        ys:=Current.y+1;

        if ISolid then
        begin
          while (ys<y) and (ys<Bitmap.Height) do
          begin
            xt:=xt+k;
            tmpXt:=Floor(xt);

            if tmpXt < 0 then tmpXt:=0;
            if tmpXt > Bitmap.Width then tmpXt:=Bitmap.Width-1;

            dist:=xt-tmpXt;
            oneDist:=1-dist;

            BlendColor1(tmpXt,ys);
            BlendColor2(tmpXt+1, ys);

            Inc(ys);
          end;
        end
        else
        begin
          while ys<y do
          begin
            xt:=xt+k;

            if tmpDots[ys mod 8] then
            begin
              tmpXt:=Floor(xt);

              dist:=xt-tmpXt;
              oneDist:=1-dist;

              BlendColor1(tmpXt,ys);
              BlendColor2(tmpXt+1, ys);
            end;

            Inc(ys);
          end;
        end;
      end;

      SetPixel(x,y,IPenColor);
    end;

    MoveTo(tmpX,tmpY);
  end;
end;

procedure TAntiAliasCanvas.MoveTo(X,Y:Integer);
begin
  FCurrent.X:=X;
  FCurrent.Y:=Y;
  inherited;
end;

procedure TAntiAliasCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var midX,
    midY : Integer;
    OldColor : TColor;
    OldStyle : TPenStyle;
    tmp : Boolean;
begin
  if not IAlias then
     inherited
  else
  begin
    midX:=(x1+x2) div 2;
    midY:=(y1+y2) div 2;

    IPenColor:=ColorToRGB(Pen.Color);
    
    OldColor:=IPenColor;
    OldStyle:=IPenStyle;

    tmp:=Pen.Style=psSolid;

    if tmp then
       Pen.Style:=psClear
    else
    begin
      IPenColor:=Brush.Color;
      tmp:=Brush.Style<>bsClear;
    end;

    inherited;

    if tmp then
    begin
      Pen.Style:=psSolid;

      Arc(x1,y1,x2,y2,x3,y3,x4,y4);
      Line(midX,midY,X3,Y3);
      Line(midX,midY,X4,Y4);
    end;

    IPenColor:=OldColor;
    Pen.Style:=OldStyle;
  end;
end;

procedure TAntiAliasCanvas.Polygon(const Points: array of TPoint);
var tmp : Boolean;
    l,t : Integer;
    OldColor : TColor;
    OldStyle : TPenStyle;
begin
  if not IAlias then
     inherited
  else
  begin
    if IPenWidth=1 then
       IPenColor:=ColorToRGB(Pen.Color);

    OldColor:=IPenColor;
    OldStyle:=IPenStyle;

    tmp:=Pen.Style<>psClear;

    if tmp then
       Pen.Style:=psClear
    else
    begin
      IPenColor:=Brush.Color;
      tmp:=Brush.Style<>bsClear;
    end;

    inherited;

    if tmp then
    begin
      Pen.Style:=OldStyle;
      Pen.Color:=IPenColor;

      l:=Length(Points);

      if l>0 then
      begin
        MoveTo(Points[0]);

        if l>1 then
        begin
          for t:=1 to l-1 do
              LineTo(Points[t]);

          LineTo(Points[0]);
        end;
      end;

      Pen.Color:=OldColor;
    end;

    IPenColor:=OldColor;
    Pen.Style:=OldStyle;
  end;
end;

procedure TAntiAliasCanvas.PolygonFour;
begin
  Polygon(IPoints);
end;

Procedure TAntiAliasCanvas.Polyline(const Points:{$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF});
var l,t : Integer;
begin
  if not IAlias then
     inherited
  else
  begin
    l:=Length(Points);

    if l>0 then
    begin
      MoveTo(Points[0]);

      if l>1 then
      for t:=1 to l-1 do
          LineTo(Points[t]);
    end;
  end;
end;

procedure TAntiAliasCanvas.RoundRect(X1,Y1,X2,Y2,X3,Y3:Integer);
var dx,dy,
    offX,offY : Integer;
    OldColor : TColor;
    OldStyle : TPenStyle;
    tmp : Boolean;
begin
  if not IAlias then
     inherited
  else
  begin
    IPenColor:=ColorToRGB(Pen.Color);

    OldColor:=IPenColor;
    OldStyle:=IPenStyle;

    tmp:=IPenStyle<>psClear;

    if tmp then
       Pen.Style:=psClear
    else
    begin
      IPenColor:=Brush.Color;
      tmp:=Brush.Style<>bsClear;
    end;

    inherited;

    if tmp then
    begin
      Pen.Style:=OldStyle;
      //Pen.Width:=IPenWidth;

      Dec(x2);
      Dec(y2);

      dx := (x2 - x1);
      dy := (y2 - y1);
      offX := X3 div 2;
      X3 := offX * 2;
      offY := Y3 div 2;
      Y3 := offY * 2;

      if (X3> Abs(dx)) or (Y3 > Abs(dy)) then
          Ellipse(x1, y1, x2, y2)
      else
      begin
        Line(x1+offX, y1, x2-offX, y1);
        Arc(x2-X3, y1, x2, y1+Y3, 270, 360);
        Line(x2, y1+offY, x2, y2-offY);
        Arc(x2-X3, y2-Y3, x2, y2, 0, 90);
        Line(x2-offX, y2, x1+offX, y2);
        Arc(x1, y2-Y3, x1+X3, y2, 90, 180);
        Line(x1, y2-offY, x1, y1+offY);
        Arc(x1, y1, x1+X3, y1+Y3, 180, 270);
      end;
    end;

    IPenColor:=OldColor;
    Pen.Style:=OldStyle;
  end;
end;

initialization
  TeeAntiAliasCanvas:=TAntiAliasCanvas;

  RegisterTeeTools([TAntiAliasTool]);
  RegisterClass(TAntiAliasEditor);
finalization
  TeeAntiAliasCanvas:=nil;

  UnRegisterTeeTools([TAntiAliasTool]);
end.
