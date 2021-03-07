{******************************************}
{ TeeChart Pro SVG Canvas and Exporting    }
{ SVG : Scalable Vector Graphics           }
{ www.w3.org/Graphics/SVG                  }
{                                          }
{ Copyright (c) 2001-2009 by David Berneda }
{       All Rights Reserved                }
{******************************************}
unit TeeSVGCanvas;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QForms, Types, QControls, QStdCtrls,
     {$ELSE}
     Graphics, Forms, Controls, StdCtrls,
     {$IFDEF D9}
     Types,
     {$ENDIF}
     {$ENDIF}
     {$IFDEF CLR}
     System.IO,
     {$ENDIF}
     TeCanvas, TeeProcs, TeeExport;

type
  TSVGCanvas = class(TTeeCanvas3D)
  private
    { Private declarations }
    FBackColor   : TColor;
    FBackMode    : TCanvasBackMode;
    FTextAlign   : TCanvasTextAlign;
    FX           : Integer;
    FY           : Integer;
    FStrings     : TStrings;

    IClipCount     : Integer;
    IClipStack     : Integer;
    IGradientCount : Integer;

    // IPenEndStyle : TPenEndStyle;
    IPenStyle    : TPenStyle;
    IPenWidth    : Integer;
    ITransp      : TTeeTransparency;

    Procedure Add(Const S:String);
    procedure AddEnd(const s:String);
    procedure ChangedPen(Sender: TObject);
    Procedure InternalRect(Const Rect:TRect; UsePen:Boolean;
                           RoundX:Integer=0; RoundY:Integer=0);
    Function PointToStr(X,Y:Integer):String;
    Procedure PrepareShape;
    Function SVGBrushPen(UsePen:Boolean=True):String;
    procedure SVGClip;
    Function SVGEllipse(X1,Y1,X2,Y2:Integer):String;
    procedure SVGEndClip;
    Function SVGPen:String;
    Function SVGPoints(const Points: Array of TPoint):String;
    Function SVGRect(Const Rect:TRect):String;
    Function TotalBounds:String;
  protected
    { Protected declarations }

    { 2d }
    procedure SetPixel(X, Y: Integer; Value: TColor); override;
    Function GetTextAlign:TCanvasTextAlign; override;

    { 3d }
    procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;
    Procedure SetBackMode(Mode:TCanvasBackMode); override;
    Procedure SetBackColor(Color:TColor); override;
    Function GetBackMode:TCanvasBackMode; override;
    Function GetBackColor:TColor; override;
    procedure SetTextAlign(Align:TCanvasTextAlign); override;

    function HeaderContents:String; virtual;
  public
    { Public declarations }
    Antialias : Boolean;
    DocType : String;

    Constructor Create(AStrings:TStrings);

    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;

    procedure AssignVisiblePenColor(APen:TPen; AColor:TColor); override;  // 7.0

    procedure Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
    procedure FillRect(const Rect: TRect); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    procedure LineTo(X,Y:Integer); override;
    procedure MoveTo(X,Y:Integer); override;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Rectangle(X0,Y0,X1,Y1:Integer); override;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); override;
    Procedure TextOut(X,Y:Integer; const Text:String); override;

    procedure ClipEllipse(Const Rect:TRect; Inverted:Boolean=False); override;
    procedure ClipRectangle(Const Rect:TRect); override;
    Procedure ClipRectangle(Const Rect:TRect; RoundSize:Integer); override;
    Procedure ClipPolygon(const Points:Array of TPoint; NumPoints:Integer;
                          DiffRegion:Boolean=False); override;

    procedure UnClipRectangle; override;

    Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; override;
    procedure EndBlending(Blend:TTeeBlend); override;

    Procedure GradientFill( Const Rect:TRect;
                            StartColor,EndColor:TColor;
                            Direction:TGradientDirection;
                            Balance:Integer=50;
                            RadialX:Integer=0;
                            RadialY:Integer=0); override;

    procedure RotateLabel(x,y:Integer; Const St:String; RotDegree:Double); override;
    procedure RotateLabel3D(x,y,z:Integer;
                            Const St:String; RotDegree:Double); override;
    Procedure Polygon(const Points: array of TPoint); override;
    {$IFDEF D5}
    Procedure Polyline(const Points:Array of TPoint); override;
    {$ELSE}
    Procedure Polyline(const Points:TPointArray); override;
    {$ENDIF}

    { 3d }
    Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;
    Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
  end;

  TSVGOptions = class(TForm)
    CBAntiAlias: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TSVGExportFormat=class(TTeeExportFormat)
  private
    Procedure CheckProperties;
  protected
    FProperties : TSVGOptions;
    Procedure DoCopyToClipboard; override;
  public
    Destructor Destroy; override;

    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function SVG:TStringList;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

procedure TeeSaveToSVGFile( APanel:TCustomTeePanel; FileName: String;
                            AWidth:Integer=0; AHeight: Integer=0);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     SysUtils, TeeConst;

{ TSVGCanvas }
Constructor TSVGCanvas.Create(AStrings:TStrings);
begin
  inherited Create;
  FStrings:=AStrings;
  UseBuffer:=False;

  Antialias:=True;

  { start }
  Add('<?xml version="1.0" standalone="no"?>');

  DocType:='<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">';
end;

Procedure TSVGCanvas.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin { finish }
  Add('</svg>');
  Pen.OnChange:=nil;
end;

Procedure TSVGCanvas.Add(Const S:String);
begin
  FStrings.Add(S);
end;

Function SVGColor(AColor:TColor):String;
begin
  AColor:=ColorToRGB(AColor);
  case AColor of
    clBlack: result:='"black"';
    clWhite: result:='"white"';
    clRed: result:='"red"';
    clGreen: result:='"green"';
    clBlue: result:='"blue"';
    clYellow: result:='"yellow"';
    clGray: result:='"gray"';
    clNavy: result:='"navy"';
    clOlive: result:='"olive"';
    clLime: result:='"lime"';
    clTeal:  result:='"teal"';
    clSilver:  result:='"silver"';
    clPurple:  result:='"purple"';
    clFuchsia:  result:='"fuchsia"';
    clMaroon:  result:='"maroon"';
  else
     result:='"rgb('+TeeStr(GetRValue(AColor))+','+
                     TeeStr(GetGValue(AColor))+','+
                     TeeStr(GetBValue(AColor))+')"';
  end;
end;

procedure TSVGCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  InternalRect(TeeRect(X0,Y0,X1,Y1),True);
end;

procedure TSVGCanvas.MoveTo(X, Y: Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TSVGCanvas.AddEnd(const s:String);
begin
  Add(s+'/>');
end;

procedure TSVGCanvas.LineTo(X, Y: Integer);
var tmpSt : String;
begin
  tmpSt:='<line x1="'+IntToStr(FX)+'" y1="'+IntToStr(FY)+'" '+
               'x2="'+IntToStr(X)+ '" y2="'+IntToStr(Y)+'" fill="none" '+SVGPen;
  AddEnd(tmpSt);
  FX:=X;
  FY:=Y;
end;

Function TSVGCanvas.SVGRect(Const Rect:TRect):String;
var tmp : TRect;
begin
  tmp:=OrientRectangle(Rect);

  with tmp do
  result:=' x="'+TeeStr(Left)+'" y="'+TeeStr(Top)+'" '+
          ' width="'+TeeStr(Right-Left-1)+'"'+
          ' height="'+TeeStr(Bottom-Top-1)+'"';
end;

procedure TSVGCanvas.SVGClip;
var ClipName : String;
begin
  Inc(IClipStack);
  Inc(IClipCount);
  ClipName:='Clip'+IntToStr(IClipCount);
  Add('<g clip-path="url(#'+ClipName+')">');
  Add('<defs>');
  Add('<clipPath id="'+ClipName+'" style="clip-rule:nonzero">');
end;

procedure TSVGCanvas.ClipRectangle(Const Rect:TRect);
begin
  SVGClip;
  AddEnd('<rect '+SVGRect(Rect));
  SVGEndClip;
end;

Function TSVGCanvas.SVGEllipse(X1,Y1,X2,Y2:Integer):String;
begin
  result:='cx="'+IntToStr((X1+X2) div 2)+'" cy="'+IntToStr((Y1+Y2) div 2)+
        '" rx="'+IntToStr((X2-X1) div 2)+'" ry="'+IntToStr((Y2-Y1) div 2)+'"';
end;

procedure TSVGCanvas.ClipEllipse(Const Rect:TRect; Inverted:Boolean=False);
begin
  SVGClip;
  with Rect do
    AddEnd('<ellipse '+SVGEllipse(Left,Top,Right,Bottom));
  SVGEndClip;
end;

Procedure TSVGCanvas.ClipPolygon(const Points:Array of TPoint; NumPoints:Integer;
                                 DiffRegion:Boolean=False);
begin
  SVGClip;

  //@TODO: When DiffRegion is True, 
  //clipping the difference between existing clipping region and Points polygon.

  AddEnd('<polygon '+SVGPoints(Points));
  SVGEndClip;
end;

procedure TSVGCanvas.UnClipRectangle;
begin
  if IClipStack=0 then
     raise exception.create('oops');
  Dec(IClipStack);
  Add('</g>');
end;

function TSVGCanvas.GetBackColor:TColor;
begin
  result:=FBackColor;
end;

procedure TSVGCanvas.SetBackColor(Color:TColor);
begin
  FBackColor:=Color;
end;

procedure TSVGCanvas.SetBackMode(Mode:TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

procedure TSVGCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
end;

procedure TSVGCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
end;

Function TSVGCanvas.TotalBounds:String;
begin
  result:='width="'+IntToStr(Bounds.Right-Bounds.Left)+'px" '+
          'height="'+IntToStr(Bounds.Bottom-Bounds.Top)+'px"';

//          'viewbox="'+IntToStr(Bounds.Left)+' '+IntToStr(Bounds.Top)+' '+
//                      IntToStr(Bounds.Right)+' '+IntToStr(Bounds.Bottom);
end;

Function TSVGCanvas.PointToStr(X,Y:Integer):String;
begin
  result:=IntToStr(X)+','+IntToStr(Y);
end;

Procedure TSVGCanvas.GradientFill( Const Rect:TRect;
                                  StartColor,EndColor:TColor;
                                  Direction:TGradientDirection;
                                  Balance:Integer=50;
                                  RadialX:Integer=0;
                                  RadialY:Integer=0);

  Function GradientTransform:String;
  begin
    case Direction of
       gdTopBottom : result:=' x1="0%" y1="100%" x2="0%" y2="0%" ';
       gdBottomTop : result:=' x1="0%" y1="0%" x2="0%" y2="100%" ';
       gdRightLeft : result:=' x1="0%" y1="0%" x2="100%" y2="0%" ';
       gdLeftRight : result:=' x1="100%" y1="0%" x2="0%" y2="0%" ';

       //gdFromCenter
       //gdFromTopLeft
       //gdFromBottomLeft
       //gdDiagonalUp
       //gdDiagonalDown
    end;
  end;

  procedure AddColors;
  begin
    AddEnd('<stop offset="0%" stop-color='+SVGColor(StartColor));
    AddEnd('<stop offset="100%" stop-color='+SVGColor(EndColor));
  end;

var tmp : String;
begin
  Inc(IGradientCount);
  Add('<defs>');

  if Direction=gdRadial then
  begin
    Add('<radialGradient id="Gradient'+TeeStr(IGradientCount)+'" cx="50%" cy="50%" r="50%" fx="50%" fy="50%">');
    AddColors;
    Add('</radialGradient>');
  end
  else
  begin
    Add('<linearGradient id="Gradient'+TeeStr(IGradientCount)+'" '+GradientTransform+'>');
    AddColors;
    Add('</linearGradient>');
  end;

  Add('</defs>');

  tmp:='<rect fill="url(#Gradient'+TeeStr(IGradientCount)+')" stroke="none" ';
  tmp:=tmp+SVGRect(Rect);
  AddEnd(tmp);
end;

procedure TSVGCanvas.FillRect(const Rect: TRect);
begin
  InternalRect(Rect,False);
end;

Procedure TSVGCanvas.InternalRect(Const Rect:TRect; UsePen:Boolean; RoundX,RoundY:Integer);
var tmp : String;
begin
  if (Brush.Style<>bsClear) or (UsePen and (Pen.Style<>psClear)) then
  begin
    tmp:='<rect '+SVGRect(Rect)+SVGBrushPen(UsePen);

    if (RoundX<>0) or (RoundY<>0) then
       tmp:=tmp+' rx="'+IntToStr(RoundX)+'" ry="'+IntToStr(RoundY)+'"';

    AddEnd(tmp);
  end;
end;

procedure TSVGCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
var tmpSt : String;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    tmpSt:='<ellipse '+SVGEllipse(X1,Y1,X2,Y2);
    AddEnd(tmpSt+SVGBrushPen);
  end;
end;

procedure TSVGCanvas.SetPixel3D(X,Y,Z:Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Calc3DPos(x,y,z);
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TSVGCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TSVGCanvas.AssignVisiblePenColor(APen:TPen; AColor:TColor);
begin
  IPenStyle:=APen.Style;
  IPenWidth:=APen.Width;
  Pen.OnChange:=nil;
  inherited;
  Pen.OnChange:=ChangedPen;
end;

procedure TSVGCanvas.Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer);
var tmpSt : String;
begin
  if Pen.Style<>psClear then
  begin
    PrepareShape;
    tmpSt:='points="'+PointToStr(Left,Top)+' '+PointToStr(Right,Bottom)+' '+
                      PointToStr(StartX,StartY)+' '+PointToStr(EndX,EndY)+'"';
    AddEnd(tmpSt);
  end;
end;

procedure TSVGCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var tmpSt : String;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    PrepareShape;
    tmpSt:=' points="'+PointToStr((X2+X1) div 2,(Y2+Y1) div 2)+' ';
    tmpSt:=tmpSt+PointToStr(X1,Y1)+' '+PointToStr(X2,Y2)+' '+
                 PointToStr(X3,Y3)+' '+PointToStr(X4,Y4)+'"';

    AddEnd(tmpSt);
  end;
end;

procedure TSVGCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  InternalRect(TeeRect(X1,Y1,X2,Y2),True,X3,Y3);
end;

Procedure TSVGCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);
begin
  Calc3DPos(x,y,z);
  TextOut(x,y,Text);
end;

Procedure TSVGCanvas.TextOut(X,Y:Integer; const Text:String);

  Procedure DoText(AX,AY:Integer; AColor:TColor);

    Function VerifySpecial(S:String):String;
    const AllowedSVGChars=['!'..'z'] - ['&', '<', '>', '"', ''''];
    var t : Integer;
    begin
      result:='';

      for t:=1 to Length(S) do
      if {$IFDEF CLR}AnsiChar{$ENDIF}(S[t]) in AllowedSVGChars then
         result:=result+S[t]
      else
         case {$IFDEF CLR}AnsiChar{$ENDIF}(S[t]) of
          '&' : result:=result + '&amp;';
          '<' : result:=result + '&lt;';
          '>' : result:=result + '&gt;';
          '"' : result:=result + '&quot;';
         '''' : result:=result + '&apos;';
         else
                result:=result + '&#'+IntToStr(Ord(S[t]))+';';
         end;
    end;

  var tmpSt : String;
  begin
    if (TextAlign and TA_CENTER)=TA_CENTER then
       Dec(AX,TextWidth(Text) div 2)
    else
    if (TextAlign and TA_RIGHT)=TA_RIGHT then
       Dec(AX,TextWidth(Text));

    tmpSt:='<text x="'+IntToStr(AX)+'" y="'+IntToStr(AY)+'"'+
        ' font-family="'+Font.Name+'" font-size="'+IntToStr(Font.Size)+'pt" ';

//    tmpSt:=tmpSt+' transform="translate(0,100) rotate(90)"';

    if fsItalic in Font.Style then
       tmpSt:=tmpSt+' font-style="italic"';

    if fsBold in Font.Style then
       tmpSt:=tmpSt+' font-weight="bold"';

    if fsUnderline in Font.Style then
       tmpSt:=tmpSt+' text-decoration="underline"'
    else
    if fsStrikeOut in Font.Style then
       tmpSt:=tmpSt+' text-decoration="line-through"';

    tmpSt:=tmpSt+' fill='+SVGColor(AColor)+'>';

    Add(tmpSt);
    Add(VerifySpecial(Text));
    Add('</text>');
  end;

Var tmpX : Integer;
    tmpY : Integer;
begin
  if TextAlign<TA_BOTTOM then
     Inc(y,Round(Font.Size*Screen.PixelsPerInch/72.0));  // align top

  if Assigned(IFont) then
  begin
    With IFont.Shadow do
    begin
      if (HorizSize<>0) or (VertSize<>0) then
      begin
        if HorizSize<0 then
        begin
          tmpX:=X;
          X:=X-HorizSize;
        end else tmpX:=X+HorizSize;
        if VertSize<0 then
        begin
          tmpY:=Y;
          Y:=Y-VertSize;
        end else tmpY:=Y+VertSize;
        DoText(tmpX,tmpY,IFont.Shadow.Color);
      end;
    end;
    DoText(X,Y,IFont.Color);
  end else DoText(X,Y,Font.Color);
end;

Function TSVGCanvas.GetTextAlign:TCanvasTextAlign;
begin
  result:=FTextAlign;
end;

procedure TSVGCanvas.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Double);
begin
  Calc3DPos(x,y,z);
  RotateLabel(x,y,St,RotDegree);
end;

procedure TSVGCanvas.RotateLabel(x,y:Integer; Const St:String; RotDegree:Double);
begin
//TODO: RotDegree text rotation
  TextOut(X,Y,St);
end;

Function TSVGCanvas.GetBackMode:TCanvasBackMode;
begin
  result:=FBackMode;
end;

Function TSVGCanvas.SVGBrushPen(UsePen:Boolean=True):String;
begin
  if Brush.Style<>bsClear then
  begin
    result:=' fill='+SVGColor(Brush.Color);
    if ITransp>0 then
       result:=result+' fill-opacity="'+FloatToStr(ITransp*0.01)+'"';
  end
  else
    result:=' fill="none"';

  if UsePen then result:=result+SVGPen;
end;

Function TSVGCanvas.SVGPen:String;

  Function PenStyle:String;
  begin
    if Pen is TChartPen and TChartPen(Pen).SmallDots then
       result:='2, 2'
    else
    case IPenStyle of
      psDash: result:='4, 2';
      psDot: result:='2, 2';
      psDashDot: result:='4, 2, 2, 2';
      psDashDotDot: result:='4, 2, 2, 2, 2, 2';
    else
      result:='';
    end;
  end;

begin
  if Pen.Style=psClear then
     result:=' stroke="none"'
  else
  begin
    result:=' stroke='+SVGColor(Pen.Color);

    if IPenWidth>1 then
       result:=result+' stroke-width="'+TeeStr(IPenWidth)+'"';

    if IPenStyle<>psSolid then
       result:=result+' stroke-dasharray="'+PenStyle+'" ';  //  fill="none" breaks brush ??

    if Pen is TChartPen then
    case TChartPen(Pen).EndStyle of
      esSquare: result:=result+' stroke-linecap="square"';
      esFlat: result:=result+' stroke-linecap="flat"';
    end;
  end;
end;

Procedure TSVGCanvas.PrepareShape;
begin
  Add('<polygon'+SVGBrushPen);
end;

Function TSVGCanvas.SVGPoints(const Points: Array of TPoint):String;
var t : Integer;
begin
  result:='points="';
  for t:=Low(Points) to High(Points) do
      result:=result+PointToStr(Points[t].X,Points[t].Y)+' ';
  result:=result+'"';
end;

Procedure TSVGCanvas.Polygon(const Points: Array of TPoint);
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    PrepareShape;
    AddEnd(SVGPoints(Points));
  end;
end;

{$IFDEF D5}
Procedure TSVGCanvas.Polyline(const Points:Array of TPoint);
{$ELSE}
Procedure TSVGCanvas.Polyline(const Points:TPointArray);
{$ENDIF}
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    Add('<polyline fill="none" '+SVGPen);
    AddEnd(SVGPoints(Points));
  end;
end;

// If you need a diferent set of headers, override this method
// in a descendant class (ie: TMySVGCanvas.HeaderContents)
function TSVGCanvas.HeaderContents:String;
begin
  result:='version="1.1" baseProfile="full"'+#13+
          'xmlns:cc="http://web.resource.org/cc/"'+#13+
          'xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"'+#13+
          'xmlns:ev="http://www.w3.org/2001/xml-events"'+#13+
          'xmlns:svg="http://www.w3.org/2000/svg"'+#13+
          'xmlns="http://www.w3.org/2000/svg"'+#13+
          'xmlns:xlink="http://www.w3.org/1999/xlink"'+#13;
end;

function TSVGCanvas.InitWindow(DestCanvas: TCanvas;
  A3DOptions: TView3DOptions; ABackColor: TColor; Is3D: Boolean;
  const UserRect: TRect): TRect;

var tmp : String;
begin
  result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);

  Add(DocType);
  tmp:='<svg '+HeaderContents+TotalBounds;
  if Antialias then tmp:=tmp+' style="text-antialiasing:true"';

  Add(tmp+'>');

  Pen.OnChange:=ChangedPen;
end;

procedure TSVGCanvas.ChangedPen(Sender: TObject);
begin
  IPenStyle:=Pen.Style;
  IPenWidth:=Pen.Width;
end;

procedure TSVGCanvas.SetTextAlign(Align: TCanvasTextAlign);
begin
  FTextAlign:=Align;
end;

function TSVGCanvas.BeginBlending(const R: TRect;
 Transparency: TTeeTransparency): TTeeBlend;
begin
  ITransp:=Transparency;
  result:=nil;
end;

procedure TSVGCanvas.EndBlending(Blend: TTeeBlend);
begin
  ITransp:=0;
end;

procedure TSVGCanvas.SVGEndClip;
begin
  Add('</clipPath>');
  Add('</defs>');
end;

procedure TSVGCanvas.ClipRectangle(const Rect: TRect; RoundSize: Integer);
begin
  SVGClip;
  AddEnd('<rect '+SVGRect(Rect)+' rx="'+IntToStr(RoundSize)+'"');
  SVGEndClip;
end;

{ TSVGExportFormat }
function TSVGExportFormat.Description: String;
begin
  result:=TeeMsg_AsSVG;
end;

procedure TSVGExportFormat.DoCopyToClipboard;
begin
  with SVG do
  try
    Clipboard.AsText:=Text;
  finally
    Free;
  end;
end;

function TSVGExportFormat.FileExtension: String;
begin
  result:='SVG';
end;

function TSVGExportFormat.FileFilter: String;
begin
  result:=TeeMsg_SVGFilter;
end;

Procedure TSVGExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then
     FProperties:=TSVGOptions.Create(nil);
end;

function TSVGExportFormat.Options(Check:Boolean=True):TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

procedure TSVGExportFormat.SaveToStream(Stream: TStream);
begin
  with SVG do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

type TTeePanelAccess=class(TCustomTeePanel);

function TSVGExportFormat.SVG: TStringList;
var tmp : TCanvas3D;
begin { return a panel or chart in SVG format into a StringList }
  CheckSize;

  result:=TStringList.Create;
  Panel.AutoRepaint:=False;
  try

    tmp:=Panel.Canvas;

    {$IFNDEF CLR}  // Protected across assemblies
    TTeePanelAccess(Panel).InternalCanvas:=nil;
    {$ENDIF}

    CheckProperties; // 7.01
    
    Panel.Canvas:=TSVGCanvas.Create(result);
    try
      Panel.Canvas.Assign(tmp);

      if not Assigned(Panel.Parent) then
         Panel.BufferedDisplay:=True;  // 7.01

      TSVGCanvas(Panel.Canvas).Antialias:=FProperties.CBAntiAlias.Checked;

      Panel.Draw(Panel.Canvas.ReferenceCanvas,TeeRect(0,0,Width,Height));
    finally
      Panel.Canvas:=tmp;
    end;

  finally
    Panel.AutoRepaint:=True;
  end;
end;

procedure TeeSaveToSVGFile( APanel:TCustomTeePanel; FileName: String;
                            AWidth:Integer=0; AHeight: Integer=0);
begin { save panel or chart to filename in SVG format }
  with TSVGExportFormat.Create do
  try
    Panel:=APanel;
    Height:=AHeight;
    Width:=AWidth;

    if ExtractFileExt(FileName)='' then
       FileName:=FileName+'.'+FileExtension;

    SaveToFile(FileName);
  finally
    Free;
  end;
end;

Destructor TSVGExportFormat.Destroy;
begin
//  FreeAndNil(FProperties);  ?? 6.02
  inherited;
end;

initialization
  RegisterTeeExportFormat(TSVGExportFormat);
finalization
  UnRegisterTeeExportFormat(TSVGExportFormat);
end.
