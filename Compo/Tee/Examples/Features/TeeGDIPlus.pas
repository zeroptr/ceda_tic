{******************************************}
{   Base types and Procedures              }
{ Copyright (c) 1995-2009 by David Berneda }
{        All Rights Reserved               }
{******************************************}
unit TeeGDIPlus;
{$I TeeDefs.inc}

// Runtime GDI+ Plus from Microsoft at:
//
//    http://www.microsoft.com/downloads/release.asp?releaseid=32738

interface

uses
  {$IFNDEF LINUX}
  Windows,
  Classes,
  {$ENDIF}
  {$IFDEF D6}
  Types,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics,
  {$ELSE}
  Graphics,
  {$ENDIF}
  {$IFDEF CLR}
  System.Drawing,
  System.Drawing.Drawing2D,
  System.Drawing.Text,
  {$ELSE}
  GDIPAPI,
  GDIPOBJ,
  {$ENDIF}
  TeCanvas;

type
  TGDIPlusCanvas=class(TTeeCanvas3D)
  private
    FGraphics : {$IFDEF CLR}System.Drawing.Graphics{$ELSE}TGPGraphics{$ENDIF};
    FGPFont   : {$IFDEF CLR}System.Drawing.Font{$ELSE}TGPFont{$ENDIF};
    FGPPen    : {$IFDEF CLR}System.Drawing.Pen{$ELSE}TGPPen{$ENDIF};
    FGPBrush  : {$IFDEF CLR}System.Drawing.Brush{$ELSE}TGPBrush{$ENDIF};

    FX,FY,FZ  : Integer;
    FAnti     : Boolean;
    FAntiText : Boolean;

    IPenCap      : TPenEndStyle;
    IPenColor    : TColor;
    IPenSmallDot : Boolean;
    IPenWidth    : Integer;
    ITextRotation: Double;

    procedure CalcArcAngles(X1,Y1,X2,Y2,X3,Y3,X4,Y4:Integer;
                            out StartAngle:Single; out EndAngle:Single);
    function GDIPColor(AColor:TColor):{$IFDEF CLR}Color{$ELSE}TColor{$ENDIF};
    function GBrush:{$IFDEF CLR}System.Drawing.Brush{$ELSE}TGPBrush{$ENDIF};
    function GPen:{$IFDEF CLR}System.Drawing.Pen{$ELSE}TGPPen{$ENDIF};
    procedure SetAnti(const Value: Boolean);
    procedure SetAntiText(const Value: Boolean);
  protected
    procedure SetPixel(X, Y: Integer; Value: TColor); override;
    procedure SetPixel3D(X, Y, Z: Integer; Value: TColor); override;
  public
    { public }
    Transparency : Byte;

    Constructor Create;
    Destructor Destroy; override;

    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;

    Function ReDrawBitmap:Boolean; override;

    Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; override;
    procedure EndBlending(Blend:TTeeBlend); override;

    procedure Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer); override;
    procedure AssignVisiblePenColor(APen:TPen; AColor:TColor); override;
    Procedure ClipEllipse(Const Rect:TRect; Inverted:Boolean=False); override;
    Procedure ClipPolygon(const Points:Array of TPoint; NumPoints:Integer;
                          DiffRegion:Boolean=False); override;
    procedure ClipRectangle(Const Rect:TRect); override;
    procedure ClipRectangle(Const Rect:TRect; RoundSize:Integer); override;
    procedure DoHorizLine(X0,X1,Y:Integer); override;
    procedure Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                     Const StartAngle,EndAngle,HolePercent:Double); override;
    procedure DoVertLine(X,Y0,Y1:Integer); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    procedure FillRect(const Rect: TRect); override;
    Procedure Line(X0,Y0,X1,Y1:Integer); override;
    procedure LineTo(X,Y:Integer); override;
    procedure LineTo3D(X,Y,Z:Integer); override;
    procedure MoveTo(X,Y:Integer); override;
    procedure MoveTo3D(X,Y,Z:Integer); override;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Polygon(const Points:Array of TPoint); override;
    {$IFDEF D5}
    Procedure Polyline(const Points:Array of TPoint); override;
    {$ENDIF}
    procedure Rectangle(X0,Y0,X1,Y1:Integer); override;
    procedure RotateLabel(x,y:Integer; const St:String; RotDegree:Double); override;
    procedure RoundRect(X1,Y1,X2,Y2,X3,Y3:Integer); override;
    procedure TextOut(X,Y:Integer; const Text:String); override;
    Procedure HorizLine3D(Left,Right,Y,Z:Integer); override;
    Procedure LineWithZ(X0,Y0,X1,Y1,Z:Integer); override;
    procedure UnClipRectangle; override;
    Procedure VertLine3D(X,Top,Bottom,Z:Integer); override;
    Procedure ZLine3D(X,Y,Z0,Z1:Integer); override;

    // published
    property AntiAlias:Boolean read FAnti write SetAnti default False;
    property AntiAliasText:Boolean read FAntiText write SetAntiText default False;
  end;

implementation

uses
  Math,
  SysUtils;

{ TGDIPlusCanvas }
Constructor TGDIPlusCanvas.Create;
begin
  inherited;

  {$IFNDEF CLR}
  TeeGDIPlusStartup;
  {$ENDIF}

  Transparency:=255;
  FGPPen:={$IFDEF CLR}System.Drawing.Pen.Create(System.Drawing.Color.Black){$ELSE}TGPPen.Create(clBlack){$ENDIF};
end;

Destructor TGDIPlusCanvas.Destroy;
begin
  FGPPen.Free;
  FGPBrush.Free;
  FGPFont.Free;
  FGraphics.Free;
  inherited;
end;

procedure TGDIPlusCanvas.SetAnti(const Value: Boolean);
begin
  if FAnti<>Value then
  begin
    FAnti:=Value;

    if Assigned(View3DOptions) then
       View3DOptions.Repaint;
  end;
end;

procedure TGDIPlusCanvas.SetAntiText(const Value: Boolean);
begin
  if FAntiText<>Value then
  begin
    FAntiText:=Value;

    if Assigned(View3DOptions) then
       View3DOptions.Repaint;
  end;
end;

procedure TGDIPlusCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  FGraphics.DrawLine(GPen,X,Y,X,Y);
end;

procedure TGDIPlusCanvas.SetPixel3D(X, Y, Z: Integer; Value: TColor);
begin
  Calc3DPos(x,y,z);
  SetPixel(x,y,Value);
end;

function TGDIPlusCanvas.GDIPColor(AColor:TColor):{$IFDEF CLR}Color{$ELSE}TColor{$ENDIF};
begin
  AColor:=ColorToRGB(AColor);

  {$IFDEF CLR}
  result:=Color.FromArgb(AColor);
  {$ELSE}
  result:= ( Byte(AColor shr 16) or
            (DWORD(Byte(AColor shr 8)) shl GreenShift) or
            (DWORD(Byte(AColor)) shl RedShift) or
            (DWORD(Transparency) shl AlphaShift));
  {$ENDIF}
end;

function TGDIPlusCanvas.GBrush:{$IFDEF CLR}System.Drawing.Brush{$ELSE}TGPBrush{$ENDIF};

  function GetHatchStyle:HatchStyle;
  begin
    case Brush.Style of
      bsHorizontal: result:={$IFDEF CLR}HatchStyle.Horizontal{$ELSE}HatchStyleHorizontal{$ENDIF};
        bsVertical: result:={$IFDEF CLR}HatchStyle.Vertical{$ELSE}HatchStyleVertical{$ENDIF};
       bsFDiagonal: result:={$IFDEF CLR}HatchStyle.ForwardDiagonal{$ELSE}HatchStyleForwardDiagonal{$ENDIF};
       bsBDiagonal: result:={$IFDEF CLR}HatchStyle.BackwardDiagonal{$ELSE}HatchStyleBackwardDiagonal{$ENDIF};
           bsCross: result:={$IFDEF CLR}HatchStyle.Cross{$ELSE}HatchStyleCross{$ENDIF};
    else
     {bsDiagCross:} result:={$IFDEF CLR}HatchStyle.DiagonalCross{$ELSE}HatchStyleDiagonalCross{$ENDIF};
    end;
  end;

begin
  if Brush.Style=bsSolid then
  begin
    if FGPBrush is {$IFDEF CLR}System.Drawing.SolidBrush{$ELSE}TGPSolidBrush{$ENDIF} then
       {$IFDEF CLR}
       System.Drawing.SolidBrush(FGPBrush).Color:=GDIPColor(Brush.Color)
       {$ELSE}
       TGPSolidBrush(FGPBrush).SetColor(GDIPColor(Brush.Color))
       {$ENDIF}
    else
    begin
      FGPBrush.Free;
      FGPBrush:={$IFDEF CLR}System.Drawing.SolidBrush{$ELSE}TGPSolidBrush{$ENDIF}.Create(GDIPColor(Brush.Color));
    end;
  end
  else
  begin
    FGPBrush.Free;
    FGPBrush:={$IFDEF CLR}System.Drawing.Drawing2D.HatchBrush{$ELSE}TGPHatchBrush{$ENDIF}.Create(GetHatchStyle,GDIPColor(Brush.Color),GDIPColor(BackColor));
  end;

  result:=FGPBrush;
end;

function TGDIPlusCanvas.GPen:{$IFDEF CLR}System.Drawing.Pen{$ELSE}TGPPen{$ENDIF};
{$IFDEF CLR}
const
  LineCapRound=LineCap.Round;
  LineCapSquare=LineCap.Square;
  LineCapFlat=LineCap.Flat;

  DashCapRound=DashCap.Round;
  DashCapTriangle=DashCap.Triangle;
  DashCapFlat=DashCap.Flat;
{$ENDIF}
begin
  with FGPPen do
  begin
    {$IFDEF CLR}
    Width:=IPenWidth;
    {$ELSE}
    SetWidth(IPenWidth);
    {$ENDIF}

    if IPenSmallDot then
    begin
      {$IFDEF CLR}
      Color:=GDIPColor(IPenColor);
      DashStyle:=System.Drawing.Drawing2D.DashStyle.Dot;
      {$ELSE}
      SetColor(GDIPColor(IPenColor));
      SetDashStyle(DashStyleDot);
      {$ENDIF}
    end
    else
    begin
      {$IFDEF CLR}
      Color:=GDIPColor(IPenColor);
      {$ELSE}
      SetColor(GDIPColor(IPenColor));
      {$ENDIF}

      case Pen.Style of
            psSolid: {$IFDEF CLR}DashStyle:=System.Drawing.Drawing2D.DashStyle.Solid{$ELSE}SetDashStyle(DashStyleSolid){$ENDIF};
             psDash: {$IFDEF CLR}DashStyle:=System.Drawing.Drawing2D.DashStyle.Dash{$ELSE}SetDashStyle(DashStyleDash){$ENDIF};
              psDot: {$IFDEF CLR}DashStyle:=System.Drawing.Drawing2D.DashStyle.Dot{$ELSE}SetDashStyle(DashStyleDot){$ENDIF};
          psDashDot: {$IFDEF CLR}DashStyle:=System.Drawing.Drawing2D.DashStyle.DashDot{$ELSE}SetDashStyle(DashStyleDashDot){$ENDIF};
       psDashDotDot: {$IFDEF CLR}DashStyle:=System.Drawing.Drawing2D.DashStyle.DashDotDot{$ELSE}SetDashStyle(DashStyleDashDotDot){$ENDIF};
      end;
    end;

    case IPenCap of
        esRound: SetLineCap(LineCapRound, LineCapRound, DashCapRound);
       esSquare: SetLineCap(LineCapSquare, LineCapSquare, DashCapTriangle);
    else
      SetLineCap(LineCapFlat, LineCapFlat, DashCapFlat);
    end;

    {$IFDEF CLR}
    LineJoin:=System.Drawing.Drawing2D.LineJoin.Bevel;
    {$ELSE}
    SetLineJoin(LineJoinBevel);
    {$ENDIF}
  end;

  // GdipSetPenDashArray

  result:=FGPPen;
end;

procedure TGDIPlusCanvas.CalcArcAngles(X1,Y1,X2,Y2,X3,Y3,X4,Y4:Integer;
                                       out StartAngle:Single; out EndAngle:Single);
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
  if EndAngle=0 then EndAngle:=361;
end;

Function TGDIPlusCanvas.BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend;
begin
  Self.Transparency:=Round((100-Transparency)*2.55);
  result:=nil;
end;

procedure TGDIPlusCanvas.EndBlending(Blend:TTeeBlend);
begin
  Transparency:=255;
end;

Function TGDIPlusCanvas.InitWindow( DestCanvas:TCanvas;
                     A3DOptions:TView3DOptions;
                     ABackColor:TColor;
                     Is3D:Boolean;
                     Const UserRect:TRect):TRect;
{$IFNDEF CLR}
var Status : TStatus;
{$ENDIF}
begin
 result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);
 FX:=0;
 FY:=0;
 FZ:=0;

 FreeAndNil(FGraphics);

 if not Assigned(FGraphics) then
 begin
   Bitmap.PixelFormat:=TeePixelFormat;

   FGraphics:={$IFDEF CLR}System.Drawing.Graphics.FromHdc(IntPtr(Integer(Handle))){$ELSE}TGPGraphics.Create(Handle){$ENDIF};

   if FAnti then
      {$IFDEF CLR}
      FGraphics.SmoothingMode:=SmoothingMode.HighQuality;
      {$ELSE}
      FGraphics.SetSmoothingMode(QualityModeHigh);
      {$ENDIF}

   if FAntiText then
      {$IFDEF CLR}
      FGraphics.TextRenderingHint:=System.Drawing.Text.TextRenderingHint.AntiAlias;
      {$ELSE}
      FGraphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
      {$ENDIF}

   {$IFNDEF CLR}
   Status:=FGraphics.GetLastStatus;
   if Status<>Ok then
      Raise Exception.Create(IntToStr(Ord(Status)));
   {$ENDIF}
 end;
end;

Function TGDIPlusCanvas.ReDrawBitmap:Boolean;
begin
  result:=inherited ReDrawBitmap;
end;

procedure TGDIPlusCanvas.Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer);
var StartAngle : Single;
    EndAngle   : Single;
begin
  if Pen.Style<>psClear then
  begin
    CalcArcAngles(Left,Top,Right,Bottom,StartX,StartY,EndX,EndY,StartAngle,EndAngle);
    FGraphics.DrawArc(GPen,Left,Top,Right-Left,Bottom-Top,StartAngle,EndAngle-StartAngle);
  end;
end;

{$IFDEF CLR}
type
  TGPGraphicsPath=System.Drawing.Drawing2D.GraphicsPath;
{$ENDIF}

Procedure TGDIPlusCanvas.ClipEllipse(Const Rect:TRect; Inverted:Boolean=False);
var p : TGPGraphicsPath;
begin
  p:=TGPGraphicsPath.Create;
  try
    {$IFDEF CLR}
    with Rect do
       p.AddEllipse(Left,Top,Right-Left,Bottom-Top);
    {$ELSE}
    p.AddEllipse(MakeRect(Rect));
    {$ENDIF}

    FGraphics.SetClip(p);
  finally
    p.Free;
  end;

  inherited;
end;

Procedure TGDIPlusCanvas.ClipPolygon(const Points:Array of TPoint; NumPoints:Integer;
                                     DiffRegion:Boolean=False);
var Region : HRgn;
    r : {$IFDEF CLR}System.Drawing.Region{$ELSE}TGPRegion{$ENDIF};
begin
  Region:=CreatePolygonRgn(Points,NumPoints,ALTERNATE);

  r:={$IFDEF CLR}System.Drawing.Region.FromHrgn(IntPtr(Integer(Region))){$ELSE}TGPRegion.Create(Region){$ENDIF};
  try
    if DiffRegion then
       FGraphics.SetClip(r,{$IFDEF CLR}CombineMode.Exclude{$ELSE}CombineModeExclude{$ENDIF})
    else
       FGraphics.SetClip(r {$IFDEF CLR},CombineMode.Replace{$ENDIF});

  finally
    DeleteObject(Region);
    r.Free;
  end;

  inherited;
end;

procedure TGDIPlusCanvas.ClipRectangle(Const Rect:TRect);
begin
  {$IFDEF CLR}
  with Rect do
       FGraphics.SetClip(System.Drawing.Rectangle.FromLTRB(Left,Top,Right,Bottom));
  {$ELSE}
  FGraphics.SetClip(MakeRect(Rect));
  {$ENDIF}
end;

Procedure TGDIPlusCanvas.ClipRectangle(Const Rect:TRect; RoundSize:Integer);
begin
  ClipRectangle(Rect); // Pending!
  inherited ClipRectangle(Rect,RoundSize);
end;

procedure TGDIPlusCanvas.AssignVisiblePenColor(APen:TPen; AColor:TColor);
begin
  inherited;
  IPenColor:=AColor;

  if APen is TChartPen then
  begin
    IPenSmallDot:=TChartPen(APen).SmallDots;
    IPenCap:=TChartPen(APen).EndStyle;
  end
  else
  begin
    IPenSmallDot:=False;
    IPenCap:=esRound;
  end;

  IPenWidth:=APen.Width;
end;

Procedure TGDIPlusCanvas.DoHorizLine(X0,X1,Y:Integer);
begin
  FGraphics.DrawLine(GPen,X0,Y,X1,Y);
  FX:=X1;
  FY:=Y;
end;

procedure TGDIPlusCanvas.Donut( XCenter,YCenter,XRadius,YRadius:Integer;
                                Const StartAngle,EndAngle,HolePercent:Double);

var tmpXRadius,
    tmpYRadius  : Double;
    P           : TGPGraphicsPath;

  procedure ArcTo(const X1,Y1,X2,Y2,X3,Y3,X4,Y4:Integer;
                  const ClockWise:Boolean=False);
  var StartAngle : Single;
      EndAngle   : Single;
  begin
//    if ClockWise then
//       SetArcDirection(tmpDC,AD_CLOCKWISE);

    CalcArcAngles(X1,Y1,X2,Y2,X3,Y3,X4,Y4,StartAngle,EndAngle);
    P.AddArc(X1,Y1,X2-X1,Y2-Y1,StartAngle,EndAngle-StartAngle);

//    if ClockWise then
//       SetArcDirection(tmpDC,AD_COUNTERCLOCKWISE);
  end;

  Procedure CalcPoint(const Angle:Double; out x,y:Integer);
  var tmpSin : Extended;
      tmpCos : Extended;
  begin
    SinCos(Angle,tmpSin,tmpCos);
    x:=XCenter+Round(XRadius*tmpCos);
    y:=YCenter-Round(YRadius*tmpSin);
  end;

  Procedure CalcPoint2(const Angle:Double; out x,y:Integer);
  var tmpSin : Extended;
      tmpCos : Extended;
  begin
    SinCos(Angle,tmpSin,tmpCos);
    x:=XCenter+Round(tmpXRadius*tmpCos);
    y:=YCenter-Round(tmpYRadius*tmpSin);
  end;

var x3,y3,
    x4,y4 : Integer;
begin
  tmpXRadius:=HolePercent*XRadius*0.01;
  tmpYRadius:=HolePercent*YRadius*0.01;

  CalcPoint(StartAngle,x3,y3);
  CalcPoint(EndAngle,x4,y4);

  MoveTo(x3,y3);

  P:=TGPGraphicsPath.Create;
  try
    ArcTo(XCenter-XRadius,YCenter-YRadius,XCenter+XRadius,YCenter+YRadius,x3,y3,x4,y4);

    CalcPoint2(StartAngle,x3,y3);
    CalcPoint2(EndAngle,x4,y4);

    if (x4<>x3) or (y4<>y3) then
       ArcTo(XCenter-Round(tmpXRadius),YCenter-Round(tmpYRadius),
             XCenter+Round(tmpXRadius),YCenter+Round(tmpYRadius),
             x4,y4,x3,y3,True);

    if Brush.Style<>bsClear then
       FGraphics.FillPath(GBrush,P);

    if Pen.Style<>psClear then
       FGraphics.DrawPath(GPen,P);

  finally
    P.Free;
  end;
end;

Procedure TGDIPlusCanvas.DoVertLine(X,Y0,Y1:Integer);
begin
  FGraphics.DrawLine(GPen,X,Y0,X,Y1);
  FX:=X;
  FY:=Y1;
end;

procedure TGDIPlusCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  if Brush.Style<>bsClear then
     FGraphics.FillEllipse(GBrush,X1,Y1,X2-X1,Y2-Y1);

  if Pen.Style<>psClear then
     FGraphics.DrawEllipse(GPen,X1,Y1,X2-X1,Y2-Y1);
end;

procedure TGDIPlusCanvas.FillRect(const Rect: TRect);
begin
  if Brush.Style<>bsClear then
     {$IFDEF CLR}
     with Rect do
          FGraphics.FillRectangle(GBrush,System.Drawing.Rectangle.FromLTRB(Left,Top,Right,Bottom));
     {$ELSE}
     FGraphics.FillRectangle(GBrush,MakeRect(Rect));
     {$ENDIF}
end;

Procedure TGDIPlusCanvas.Line(X0,Y0,X1,Y1:Integer);
begin
  FGraphics.DrawLine(GPen,X0,Y0,X1,Y1);
  FX:=X1;
  FY:=Y1;
end;

procedure TGDIPlusCanvas.LineTo(X,Y:Integer);
begin
  FGraphics.DrawLine(GPen,FX,FY,X,Y);
  FX:=X;
  FY:=Y;
end;

procedure TGDIPlusCanvas.LineTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  LineTo(x,y);
end;

procedure TGDIPlusCanvas.MoveTo(X,Y:Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TGDIPlusCanvas.MoveTo3D(X,Y,Z:Integer);
begin
  Calc3DPos(x,y,z);
  FX:=X;
  FY:=Y;
  FZ:=Z;
end;

procedure TGDIPlusCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var StartAngle : Single;
    EndAngle   : Single;
begin
  CalcArcAngles(X1,Y1,X2,Y2,X3,Y3,X4,Y4,StartAngle,EndAngle);

  if Brush.Style<>bsClear then
     FGraphics.FillPie(GBrush,X1,Y1,X2,Y2,StartAngle,EndAngle-StartAngle);

  if Pen.Style<>psClear then
     FGraphics.DrawPie(GPen,X1,Y1,X2,Y2,StartAngle,EndAngle-StartAngle);
end;

{$IFDEF CLR}
type
  PointArray=Array of Point;

function MakePoints(const Points:Array of TPoint):PointArray;
var t : Integer;
begin
  SetLength(result,Length(Points));
  for t:=0 to Length(Points)-1 do
      result[t]:=Point.Create(Points[t].X,Points[t].Y);
end;
{$ELSE}
function MakePoints(const Points:Array of TPoint):PGPPoint;
begin
  result:=@Points[0];
end;
{$ENDIF}

Procedure TGDIPlusCanvas.Polygon(const Points:Array of TPoint);
begin
  if Brush.Style<>bsClear then
     {$IFDEF CLR}
     FGraphics.FillPolygon(GBrush,MakePoints(Points));
     {$ELSE}
     FGraphics.FillPolygon(GBrush,MakePoints(Points),Length(Points));
     {$ENDIF}

  if Pen.Style<>psClear then
     {$IFDEF CLR}
     FGraphics.DrawPolygon(GPen,MakePoints(Points));
     {$ELSE}
     FGraphics.DrawPolygon(GPen,MakePoints(Points),Length(Points));
     {$ENDIF}
end;

{$IFDEF D5}
Procedure TGDIPlusCanvas.Polyline(const Points:Array of TPoint);
begin
  if Pen.Style<>psClear then
     {$IFDEF CLR}
     FGraphics.DrawLines(GPen,MakePoints(Points));
     {$ELSE}
     FGraphics.DrawLines(GPen,MakePoints(Points),Length(Points));
     {$ENDIF}
end;
{$ENDIF}

procedure TGDIPlusCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
var R: TRect;
begin
  Dec(X1);
  Dec(Y1);

  R:=OrientRectangle(TeeRect(X0,Y0,X1,Y1));

  if Brush.Style<>bsClear then
     FGraphics.FillRectangle(GBrush,R.Left,R.Top,R.Right-R.Left,R.Bottom-R.Top);
  if Pen.Style<>psClear then
     FGraphics.DrawRectangle(GPen,R.Left,R.Top,R.Right-R.Left,R.Bottom-R.Top);
end;

procedure TGDIPlusCanvas.RoundRect(X1,Y1,X2,Y2,X3,Y3:Integer);
var dx,dy,
    offX,offY : Integer;
    tmp : TGPGraphicsPath;
begin
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
    tmp:=TGPGraphicsPath.Create;
    try
      tmp.AddLine(x1+offX, y1, x2-offX, y1);
      tmp.AddArc(x2-X3, y1, x3, Y3, 270, 90);
      tmp.AddLine(x2, y1+offY, x2, y2-offY);
      tmp.AddArc(x2-X3, y2-Y3, x3, y3, 0, 90);
      tmp.AddLine(x2-offX, y2, x1+offX, y2);
      tmp.AddArc(x1, y2-Y3, X3, y3, 90, 90);
      tmp.AddLine(x1, y2-offY, x1, y1+offY);
      tmp.AddArc(x1, y1, X3, Y3, 180, 90);

      if Brush.Style<>bsClear then
         FGraphics.FillPath(GBrush,tmp);

      if Pen.Style<>psClear then
         FGraphics.DrawPath(GPen,tmp);
    finally
      tmp.Free;
    end;
  end;
end;

Procedure TGDIPlusCanvas.TextOut(X,Y:Integer; const Text:String);

  function GFont:{$IFDEF CLR}System.Drawing.Font{$ELSE}TGPFont{$ENDIF};
  var tmpFontStyle : {$IFDEF CLR}FontStyle{$ELSE}TFontStyle{$ENDIF};
  begin
    FGPFont.Free;

    tmpFontStyle:={$IFDEF CLR}FontStyle.Regular{$ELSE}0{$ENDIF};

    if fsBold in Font.Style then
       if fsItalic in Font.Style then
          tmpFontStyle:={$IFDEF CLR}FontStyle.Bold or FontStyle.Italic{$ELSE}FontStyleBoldItalic{$ENDIF}
       else
          tmpFontStyle:={$IFDEF CLR}FontStyle.Bold{$ELSE}FontStyleBold{$ENDIF};

    if fsUnderline in Font.Style then
       tmpFontStyle:=tmpFontStyle or {$IFDEF CLR}FontStyle.Underline{$ELSE}FontStyleUnderline{$ENDIF};

    if fsStrikeOut in Font.Style then
       tmpFontStyle:=tmpFontStyle or {$IFDEF CLR}FontStyle.Strikeout{$ELSE}FontStyleStrikeout{$ENDIF};

    FGPFont:={$IFDEF CLR}System.Drawing.Font{$ELSE}TGPFont{$ENDIF}.Create(Font.Name,Font.Size,tmpFontStyle);

    result:=FGPFont;
  end;

  function GFontBrush:{$IFDEF CLR}System.Drawing.Brush{$ELSE}TGPBrush{$ENDIF};
  begin
    result:={$IFDEF CLR}System.Drawing.SolidBrush{$ELSE}TGPSolidBrush{$ENDIF}.Create(GDIPColor(Font.Color));
  end;

var Origin : {$IFDEF CLR}TPoint{$ELSE}TGPPointF{$ENDIF};

    //tmpBounds : TGPRectF;
    tmp    : Integer;
    tmpH,
    tmpW   : Double;
begin
  tmp:=TextAlign;

  if tmp>=TA_BOTTOM then
  begin
    Dec(Y,TextHeight(Text));
    Dec(tmp,TA_BOTTOM);
  end;

  //FGraphics.MeasureString(Text,Length(Text),GFont,Origin,tmpBounds);

  if tmp=TA_RIGHT then
     Dec(X,TextWidth(Text))
  else
  if tmp=TA_CENTER then
     Dec(X,TextWidth(Text) div 2);

  Origin.X:=X-2;
  Origin.Y:=Y;

  if ITextRotation<>0 then
  begin
    tmpW:=TextWidth(Text)*0.5;
    tmpH:=TextHeight(Text)*0.5;

    FGraphics.TranslateTransform(Origin.X+tmpW,Origin.Y+tmpH);
    FGraphics.RotateTransform(ITextRotation);
    FGraphics.TranslateTransform(-tmpW,-tmpH);

    Origin.X:=0;
    Origin.Y:=0;
  end
  else
  begin
    tmpW:=0;
    tmpH:=0;
  end;

  {$IFDEF CLR}
  FGraphics.DrawString(Text,GFont,GFontBrush,Origin.X,Origin.Y);
  {$ELSE}
  FGraphics.DrawString(Text,ByteToCharLen(Text,Length(Text)),GFont,Origin,GFontBrush);
  {$ENDIF}

  if ITextRotation<>0 then
  begin
    FGraphics.TranslateTransform(tmpW,tmpH);
    FGraphics.RotateTransform(-ITextRotation);
    FGraphics.TranslateTransform(-(X-2+tmpW),-(Y+tmpH));
  end;
end;

procedure TGDIPlusCanvas.RotateLabel(x,y:Integer; const St:String; RotDegree:Double);
begin
  ITextRotation:=360-RotDegree;
  inherited;
  ITextRotation:=0;
end;

Procedure TGDIPlusCanvas.HorizLine3D(Left,Right,Y,Z:Integer);
var tmpY : Integer;
begin
  tmpY:=Y;
  Calc3DPos(Left,tmpY,Z);
  Calc3DPos(Right,Y,Z);
  FGraphics.DrawLine(GPen,Left,tmpY,Right,Y);
  FX:=Right;
  FY:=Y;
end;

Procedure TGDIPlusCanvas.LineWithZ(X0,Y0,X1,Y1,Z:Integer);
begin
  Calc3DPos(X0,Y0,Z);
  Calc3DPos(X1,Y1,Z);
  FGraphics.DrawLine(GPen,X0,Y0,X1,Y1);
  FX:=X1;
  FY:=Y1;
end;

procedure TGDIPlusCanvas.UnClipRectangle;
begin
  {$IFDEF CLR}
  with Bounds do
       FGraphics.SetClip(System.Drawing.Rectangle.FromLTRB(Left,Top,Right,Bottom));
  {$ELSE}
  FGraphics.SetClip(MakeRect(Bounds));
  {$ENDIF}

  inherited;
end;

Procedure TGDIPlusCanvas.VertLine3D(X,Top,Bottom,Z:Integer);
var tmpX : Integer;
begin
  tmpX:=X;
  Calc3DPos(tmpX,Top,Z);
  Calc3DPos(X,Bottom,Z);
  FGraphics.DrawLine(GPen,tmpX,Top,X,Bottom);
  FX:=X;
  FY:=Bottom;
end;

Procedure TGDIPlusCanvas.ZLine3D(X,Y,Z0,Z1:Integer);
var tmpX : Integer;
    tmpY : Integer;
begin
  tmpX:=X;
  tmpY:=Y;
  Calc3DPos(tmpX,tmpY,Z0);
  Calc3DPos(X,Y,Z1);
  FGraphics.DrawLine(GPen,tmpX,tmpY,X,Y);
  FX:=X;
  FY:=Y;
end;

end.

