{**********************************************}
{   TeeChart and TeeTree for Adobe Flex/Flash  }
{                                              }
{   Copyright (c) 2009 by Steema Software      }
{   All Rights Reserved                        }
{**********************************************}
unit TeeFlexCanvas;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes, SysUtils,
     {$IFDEF CLX}
     QGraphics, QForms, QButtons, QControls, QStdCtrls, QExtCtrls,
     QClipbrd, QDialogs,
     {$ELSE}
     Graphics, Forms, Buttons, Controls, StdCtrls, ExtCtrls,
     Clipbrd, FileCtrl,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     {$IFDEF CLR}
     System.IO,
     {$ENDIF}
     TeeConst, TeCanvas, TeeProcs, TeEngine, TeeExport;

type
  TFlexCanvas=class(TTeeCanvas3D, ICanvasHyperlinks, ICanvasToolTips)
  private
    FBackColor   : TColor;
    FBackMode    : TCanvasBackMode;
    FTextAlign   : TCanvasTextAlign;
    FX           : Integer;
    FY           : Integer;
    FStrings     : TStrings;

    IAddedInitApp : Boolean;
    IApplication : Integer;
    IChartPen    : TChartPen;
    IIdent       : String;
    IItems       : TStrings;
    IImageID     : Integer;
    IPanel       : TCustomTeePanel;
    IPath        : TStrings;
    IScript      : Integer;
    ISmallDots   : Boolean;
    ITransp      : TTeeTransparency;

    procedure AddItem(const S:String); {$IFDEF D10}inline;{$ENDIF}
    procedure AddTag(const ATag,AText:String);

    function BrushColor:String;
    procedure CalcArcAngles(XC,YC,StartX,StartY,EndX,EndY:Integer;
                            out StartAngle:Single; out EndAngle:Single);
    function FlexAlpha:String;
    function FlexFloatToStr(const Value:Double):String;

    function FlexFont(AFont:TFont):String;
    function FlexGradient(Gradient:TCustomTeeGradient):String; overload;
    function FlexGradient(StartColor,EndColor:TColor; Direction:TGradientDirection;
                          Balance: Integer):String; overload;

    function FlexPoints(const Points: Array of TPoint):String;
    function FlexPosition(x,y:Integer):String;
    function FlexSize(w,h:Integer):String; overload;
    function FlexSize(const R:TRect):String; overload;
    function ImageFileName(Graphic:TGraphic):String;
    function PenColor:String;
    function PenWidth:String;
  protected
    { Protected declarations }

    // ICanvasHyperlinks
    procedure AddLink(x,y:Integer; const Text,URL,Hint:String);

    // ICanvasToolTips
    procedure AddToolTip(const Entity,ToolTip:String);

    procedure BeginEntity(const Entity:String); override;
    procedure EndEntity; override;

    { 2d }
    procedure SetPixel(X, Y: Integer; Value: TColor); override;
    Function GetTextAlign:TCanvasTextAlign; override;

    { 3d }
    Function GetBackColor:TColor; override;
    Function GetBackMode:TCanvasBackMode; override;
    Function GetMonochrome:Boolean; override;
    Procedure SetBackColor(Color:TColor); override;
    Procedure SetBackMode(Mode:TCanvasBackMode); override;
    Procedure SetMonochrome(Value:Boolean); override;
    procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;
    procedure SetTextAlign(Align:TCanvasTextAlign); override;
  public
    { Public declarations }
    EmbeddImages : Boolean;
    ImagePath    : String;

    Constructor Create(Panel:TCustomTeePanel; AStrings:TStrings);
    Destructor Destroy; override;

    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;

    procedure Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer); override;
    procedure AssignVisiblePenColor(APen:TPen; AColor:TColor); override;
    procedure Draw(X, Y: Integer; Graphic: TGraphic); override;
    procedure FillRect(const Rect: TRect); override;
    procedure Ellipse(X1, Y1, X2, Y2: Integer); override;
    procedure LineTo(X,Y:Integer); override;
    procedure MoveTo(X,Y:Integer); override;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer); override;
    procedure Rectangle(X0,Y0,X1,Y1:Integer); reintroduce; override;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer); override;
    procedure StretchDraw(const Rect: TRect; Graphic: TGraphic); override;
    Procedure TextOut(X,Y:Integer; const Text:String); override;

    procedure ClipRectangle(Const Rect:TRect); override;
    procedure ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer); override;
    procedure UnClipRectangle; override;

    Procedure GradientFill( Const Rect:TRect;
                            StartColor,EndColor:TColor;
                            Direction:TGradientDirection;
                            Balance:Integer=50;
                            RadialX:Integer=0;
                            RadialY:Integer=0); override;

    procedure RotateLabel(x,y:Integer; Const St:String; RotDegree:Double); override;
    Procedure Polygon(const Points: array of TPoint); override;
    Procedure PolygonGradient(const Points: Array of TPoint; Gradient:TCustomTeeGradient); override;
    Procedure Polyline(const Points:{$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF}); override;

    Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; override;
    procedure EndBlending(Blend:TTeeBlend); override;

    { 3d }
    Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;
    Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
  end;

  TFlexOptions = class(TForm)
    BCompile: TButton;
    ETemp: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    EFlex: TEdit;
    SpeedButton2: TSpeedButton;
    CBPreview: TCheckBox;
    AC_OETags_js: TMemo;
    Chart1_html: TMemo;
    CBDelete: TCheckBox;
    CBEmbedd: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BCompileClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ETempChange(Sender: TObject);
    procedure EFlexChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure CheckCompile;
    function Compile(const TargetFile:String):Boolean;
    procedure ReadOptions;
  public
    { Public declarations }
    Panel : TCustomTeePanel;
  end;

  TFlexExportFormat=class(TTeeExportFormat)
  private
    Procedure CheckProperties;
  protected
    FProperties : TFlexOptions;
    Procedure DoCopyToClipboard; override;
  public
    EmbeddImages : Boolean;
    ImagePath    : String;

    function Compile(const TargetFile:String):Boolean;
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function FlexMXML:TStringList;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

procedure TeeSaveToFlexFile( APanel:TCustomTeePanel; const FileName: WideString;
                             AWidth:Integer=0; AHeight:Integer=0;
                             EmbededImages:Boolean=True);

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$R TeeFlexCanvas.res}

uses
  {$IFNDEF CLX}
  {$IFNDEF CLR}
  jpeg,
  {$ENDIF}
  {$ENDIF}

  Math,

  {$IFDEF CLR}
  TeeJPEG,
  System.Text,  // <-- StringBuilder
  WinUtils,
  {$ELSE}
  TeeDosCommand,
  {$ENDIF}

  TeeStringsEditor, TeePenDlg;

Function ColorInternal(AColor:TColor):String;
begin
  AColor:=ColorToRGB(AColor);

  case AColor of
    clBlack: result:='black';
    clWhite: result:='white';
    clRed:   result:='red';
    clGreen: result:='green';
    clBlue:  result:='blue';
   clYellow: result:='yellow';
    clGray:  result:='gray';
    clNavy:  result:='navy';
    clOlive: result:='olive';
    clLime:  result:='lime';
    clTeal:  result:='teal';
  clSilver:  result:='silver';
  clPurple:  result:='purple';
 clFuchsia:  result:='fuchsia';
  clMaroon:  result:='maroon';
  else
  begin
    result:='0x'+IntToHex(GetRValue(AColor),2)+
                IntToHex(GetGValue(AColor),2)+
                IntToHex(GetBValue(AColor),2);

//    if result='#000000' then result:='#0';
  end;
  end;
end;

Function FlexColor(AColor:TColor):String;
begin
  result:='"'+ColorInternal(AColor)+'"';
end;

{ TFlexCanvas }
Constructor TFlexCanvas.Create(Panel:TCustomTeePanel; AStrings:TStrings);
begin
  inherited Create;

  IPanel:=Panel;
  EmbeddImages:=True;
  FStrings:=AStrings;
  UseBuffer:=False;
  SupportsID:=True;

  IPath:=TStringList.Create;
  IItems:=TStringList.Create;
  IImageID:=0;
end;

Destructor TFlexCanvas.Destroy;
begin
  IItems.Free;
  IPath.Free;
  inherited;
end;

procedure TFlexCanvas.CalcArcAngles(XC,YC,StartX,StartY,EndX,EndY:Integer; out StartAngle:Single; out EndAngle:Single);
const
  HalfDivPi=180.0/Pi;
begin
  StartAngle:=ArcTan2(YC-StartY,StartX-XC);
  if StartAngle<0 then
     StartAngle:=StartAngle+2.0*Pi;

  StartAngle:=StartAngle*HalfDivPi;

  EndAngle:=ArcTan2(YC-EndY,EndX-XC);
  if EndAngle<0 then
     EndAngle:=EndAngle+2.0*Pi;

  EndAngle:=EndAngle*HalfDivPi;
end;

procedure TFlexCanvas.Arc(const Left, Top, Right, Bottom, StartX, StartY,
  EndX, EndY: Integer);
var StartAngle : Single;
    EndAngle   : Single;
begin
  if Pen.Style<>psClear then
  begin
    CalcArcAngles((Left+Right) div 2,(Top+Bottom) div 2,
                  StartX,StartY,EndX,EndY,StartAngle,EndAngle);

    AddTag('tee:Arc',
      'x0="'+IntToStr(Left)+'" y0="'+IntToStr(Top)+'" '+
      'x1="'+IntToStr(Right)+'" y1="'+IntToStr(Bottom)+'" '+
      'startAngle="'+FlexFloatToStr(StartAngle)+
      '" endAngle="'+FlexFloatToStr(EndAngle)+'" '+
      FlexAlpha+
      PenColor+
      PenWidth);
  end;
end;

procedure TFlexCanvas.AssignVisiblePenColor(APen:TPen; AColor:TColor);
begin
  if APen is TChartPen then
  begin
    IChartPen:=TChartPen(APen);
    Pen.Width:=APen.Width;
    Pen.Color:=APen.Color;
    Pen.Style:=APen.Style;
  end
  else
     IChartPen:=nil;

  ISmallDots:=Assigned(IChartPen) and IChartPen.SmallDots;

  inherited;
end;

function TFlexCanvas.BeginBlending(const R: TRect;
  Transparency: TTeeTransparency): TTeeBlend;
begin
  ITransp:=Transparency;
  result:=nil;
end;

procedure TFlexCanvas.ClipCube(const Rect: TRect; MinZ, MaxZ: Integer);
begin
// TODO
  inherited;
end;

procedure TFlexCanvas.ClipRectangle(const Rect: TRect);
begin
// TODO
  inherited;
end;

function TFlexCanvas.ImageFileName(Graphic:TGraphic):String;

  procedure CalcResult(tmp:TGraphic);
  var tmpExt : String;
  begin
    {$IFDEF CLX}
    tmpExt:='jpg';
    {$ELSE}
    tmpExt:=GraphicExtension(TGraphicClass(tmp.ClassType));
    {$ENDIF}

    result:='TeeChart_Flex_Temp_'+IntToStr(IImageID)+'.'+tmpExt;
    Inc(IImageID);

    tmp.SaveToFile(ImagePath+'\'+result);
  end;

{$IFNDEF CLX}
var tmp : TGraphic;
{$ENDIF}
begin
  {$IFNDEF CLX}
  if TGraphicClass(Graphic.ClassType)=TBitmap then
  begin
    // Bitmap (*.bmp) not supported by Flash.
    // Save it to jpeg / png...

    tmp:=TJPEGImage.Create;
    try
      tmp.Assign(Graphic);

      CalcResult(tmp);
    finally
      tmp.Free;
    end;
  end
  else
  {$ENDIF}
    CalcResult(Graphic);
end;

function TFlexCanvas.FlexPosition(x,y:Integer):String;
begin
//  result:='x="'+FloatToStr(x*100/IPanel.Width)+'%" y="'+FloatToStr(y*100/IPanel.Height)+'%"';

  result:='x="'+IntToStr(x)+'" y="'+IntToStr(y)+'"';
end;

procedure TFlexCanvas.Draw(X, Y: Integer; Graphic: TGraphic);

  function ImageSource:String;
  begin
    if EmbeddImages then
       result:='@Embed('''+ImageFileName(Graphic)+''')'
    else
       result:=ImageFileName(Graphic);
  end;

begin
  if Assigned(Graphic) then
     AddTag('mx:Image',FlexPosition(x,y)+' source="'+ImageSource+'"');
end;

function TFlexCanvas.PenColor:String;
begin
  if Pen.Style=psClear then
     result:=' strokeColor=""'
  else
     result:=' strokeColor='+FlexColor(Pen.Color);
end;

function TFlexCanvas.FlexSize(w,h:Integer):String;
begin
  result:='width="'+IntToStr(w)+'" height="'+IntToStr(h)+'"';
end;

function TFlexCanvas.FlexSize(const R:TRect):String;
begin
  result:=FlexSize(R.Right-R.Left, R.Bottom-R.Top);
end;

procedure TFlexCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  AddTag('tee:Ellipse',FlexPosition(X1,Y1)+' '+FlexSize(X2-X1,Y2-Y1)+
         FlexAlpha+BrushColor+PenColor+PenWidth);
end;

procedure TFlexCanvas.EndBlending(Blend: TTeeBlend);
begin  // reset to zero
  ITransp:=0;
end;

procedure TFlexCanvas.FillRect(const Rect: TRect);
begin
  AddTag('tee:Rectangle',FlexPosition(Rect.Left,Rect.Top)+' '+
      FlexSize(Rect)+' '+
      FlexAlpha+'strokeColor="" '+BrushColor);
end;

function TFlexCanvas.GetBackColor: TColor;
begin
  result:=FBackColor;
end;

function TFlexCanvas.GetBackMode: TCanvasBackMode;
begin
  result:=FBackMode;
end;

function TFlexCanvas.GetMonochrome: Boolean;
begin
  result:=False;
end;

function TFlexCanvas.GetTextAlign: TCanvasTextAlign;
begin
  result:=FTextAlign;
end;

function TFlexCanvas.FlexGradient(Gradient:TCustomTeeGradient):String;
begin
  with Gradient do
  if Visible then
     result:=FlexGradient(StartColor,EndColor,Direction,Balance)
  else
     result:='';
end;

function TFlexCanvas.FlexGradient(StartColor,EndColor: TColor;
                      Direction: TGradientDirection; Balance: Integer):String;

  function GradientDirection:String;
  begin
    case Direction of
      gdLeftRight: result:='LeftRight';
      gdTopBottom: result:='TopBottom';
      gdBottomTop: result:='BottomTop';
      gdRightLeft: result:='RightLeft';
    end;
  end;

var tmpType : String;
begin
  if Direction=gdRadial then
     tmpType:='Radial'
  else
     tmpType:='Linear';

  result:='gradientType="'+tmpType+'" '+
          'gradientDir="'+GradientDirection+'" '+
          'startColor='+FlexColor(StartColor)+' '+
          'endColor='+FlexColor(EndColor)+' ';
end;

procedure TFlexCanvas.GradientFill(Const Rect: TRect; StartColor,
                                   EndColor: TColor; 
                                   Direction: TGradientDirection; 
                                   Balance: Integer=50;
                                   RadialX:Integer=0;
                                   RadialY:Integer=0);
begin
  AddTag('tee:Rectangle',FlexPosition(Rect.Left,Rect.Top)+' '+
      FlexSize(Rect)+' '+
      FlexGradient(StartColor,EndColor,Direction,Balance)+FlexAlpha);
end;

function TFlexCanvas.InitWindow(DestCanvas: TCanvas;
  A3DOptions: TView3DOptions; ABackColor: TColor; Is3D: Boolean;
  const UserRect: TRect): TRect;
begin
  result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);

  IAddedInitApp:=False;

  AddItem('<?xml version="1.0"?>');
  AddItem('<!-- Generated by TeeChart Pro Version '+TeeChartVersion+' -->');
  AddItem('<mx:Application xmlns:mx="http://www.adobe.com/2006/mxml"');
  AddItem('                xmlns:tee="com.steema.graphics.*"');

//  Add('               '+FlexSize(UserRect));

  AddItem('>');

  IApplication:=FStrings.Count;

  AddItem('');
  AddItem('    <mx:Script>');
  AddItem('        <![CDATA[');
  AddItem('       ]]>');
  IScript:=FStrings.Count;

  AddItem('    </mx:Script>');
  AddItem('    <mx:Canvas '+FlexSize(UserRect)+'>'); // FlexSprite ??
end;

procedure TFlexCanvas.LineTo(X, Y: Integer);

  function Pos0:String;
  begin
    result:='x0="'+IntToStr(FX)+'" y0="'+IntToStr(FY)+'"';
  end;

  function Pos1:String;
  begin
    result:='x1="'+IntToStr(x)+'" y1="'+IntToStr(y)+'"';
  end;

  function DashLenGap:String;
  var len, gap : Integer;
  begin
    len:=4;
    gap:=4;

    if ISmallDots then
    begin
      len:=1;
      gap:=1;
    end
    else
    case Pen.Style of
        psDash: begin end;
         psDot: begin len:=2; gap:=2; end;
     psDashDot: begin len:=4; gap:=2; end;
  psDashDotDot: begin len:=4; gap:=3; end;
    end;

    result:=' len="'+IntToStr(len)+'" gap="'+IntToStr(gap)+'"';
  end;

begin
  if (not ISmallDots) and (Pen.Style=psSolid) then
     AddTag('tee:Line',Pos0+' '+Pos1+FlexAlpha+PenColor+PenWidth)
  else
     AddTag('tee:DashLine',Pos0+' '+Pos1+FlexAlpha+PenColor+PenWidth+DashLenGap);
end;

procedure TFlexCanvas.MoveTo(X, Y: Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TFlexCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var StartAngle : Single;
    EndAngle   : Single;
    XC         : Integer;
    YC         : Integer;
begin
  //TODO: Replace with a single call to a custom <tee:Pie...> class
  
  XC:=(X1+X2) div 2;
  YC:=(Y1+Y2) div 2;

  CalcArcAngles(XC,YC,
                X3,Y3,X4,Y4,StartAngle,EndAngle);

  Line(XC,YC,X3,Y3);

  AddTag('tee:Arc',
    'x0="'+IntToStr(X1)+'" y0="'+IntToStr(Y1)+'" '+
    'x1="'+IntToStr(X2)+'" y1="'+IntToStr(Y2)+'" '+
    'startAngle="'+FlexFloatToStr(StartAngle)+
    '" endAngle="'+FlexFloatToStr(EndAngle)+'" '+
    FlexAlpha+PenColor+PenWidth);

  Line(X4,Y4,XC,YC);
end;

function TFlexCanvas.FlexPoints(const Points: Array of TPoint):String;

  function PointToString(const P:TPoint):String;
  begin
    result:=IntToStr(P.X)+','+IntToStr(P.Y);
  end;

var t : Integer;
begin
  result:='points="[';

  if Length(Points)>0 then
  begin
    result:=result+PointToString(Points[0]);

    for t:=1 to Length(Points)-1 do
        result:=result+','+PointToString(Points[t]);
  end;

  result:=result+']"';
end;

procedure TFlexCanvas.BeginEntity(const Entity:String);
begin
  IPath.Add(Entity);
  IIdent:=IIdent+' ';
end;

procedure TFlexCanvas.EndEntity;
begin
  IPath.Delete(IPath.Count-1);
  Delete(IIdent,1,1);
end;

procedure TFlexCanvas.AddTag(const ATag,AText:String);

  function CurrentID:String;
  var t : Integer;
  begin
    if IPath.Count=0 then
       result:=View3DOptions.Parent.Name+'_'
    else
       result:=IPath[0];

    for t:=1 to IPath.Count-1 do
        result:=result+'_'+IPath[t];
  end;

  function TheID:String;
  var tmp   : Integer;
      tmpID : String;
  begin
    tmpID:=CurrentID;

    tmp:=0;
    result:=tmpID;

    while IItems.IndexOf(result)<>-1 do
    begin
      Inc(tmp);
      result:=tmpID+'_'+IntToStr(tmp);
    end;

    IItems.Add(result);

    result:=' id="'+result+'"';
  end;

begin
  AddItem(IIdent+'<'+ATag+TheID+' '+AText+'/>');
end;

procedure TFlexCanvas.Polygon(const Points: array of TPoint);
begin
  AddTag('tee:Polygon',FlexPoints(Points)+' '+
         FlexAlpha+BrushColor+PenColor+PenWidth);
end;

Procedure TFlexCanvas.PolygonGradient(const Points: Array of TPoint;
                                      Gradient:TCustomTeeGradient);
begin
  AddTag('tee:Polygon',FlexPoints(Points)+' '+
         FlexAlpha+PenColor+PenWidth+' '+FlexGradient(Gradient));
end;

procedure TFlexCanvas.Polyline(const Points:{$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF});
begin
  AddTag('tee:Polyline',FlexPoints(Points)+' '+
         FlexAlpha+PenColor+PenWidth);
end;

function TFlexCanvas.FlexFloatToStr(const Value:Double):String;
var Old : {$IFDEF CLR}String{$ELSE}Char{$ENDIF};
begin
  Old:=DecimalSeparator;
  DecimalSeparator:='.';
  try
    result:=FloatToStr(Value);
  finally
    DecimalSeparator:=Old;
  end;
end;

function TFlexCanvas.FlexAlpha:String;
begin
  if ITransp=0 then
     result:=''
  else
     result:=' alpha="'+FlexFloatToStr(1-(ITransp/100))+'" ';
end;

function TFlexCanvas.PenWidth:String;
begin
  if Pen.Width=1 then
     result:=''
  else
     result:=' strokeWidth="'+IntToStr(Pen.Width)+'"';
end;

function TFlexCanvas.BrushColor:String;
begin
  if Brush.Style=bsClear then
     result:=' brushColor=""'
  else
     result:=' brushColor='+FlexColor(Brush.Color);
end;

procedure TFlexCanvas.Rectangle(X0, Y0, X1, Y1: Integer);
begin
  AddTag('tee:Rectangle',FlexPosition(X0,Y0)+' '+
         FlexSize(X1-X0,Y1-Y0)+FlexAlpha+PenColor+BrushColor+PenWidth);
end;

function TFlexCanvas.FlexFont(AFont:TFont):String;

  function FontStyle:String;
  begin
    if fsItalic in Font.Style then
       result:=' fontStyle="italic" '
    else
       result:=''; // normal
  end;

  function FontWeight:String;
  begin
    if fsBold in Font.Style then
       result:=' fontWeight="bold" '
    else
       result:=''; // normal
  end;

  function TextDecoration:String;
  begin
    if fsUnderline in Font.Style then
       result:=' textDecoration="underline" '
    else
       result:=''; // none
  end;

begin
  result:=FontStyle+
          FontWeight+
          ' fontSize="'+FlexFloatToStr(Font.Size*1.2)+'" '+
          TextDecoration+
          ' fontFamily="'+Font.Name+'" '+
          ' color='+FlexColor(Font.Color)+' ';
end;

procedure TFlexCanvas.RotateLabel(x, y: Integer; const St: String;
  RotDegree: Double);

  function TextRotation:String;
  begin
    if RotDegree=0 then
       result:=''
    else
       result:=FlexFloatToStr(RotDegree);  // embedded fonts only?
  end;

begin
  if TextAlign=TA_RIGHT then
     Dec(x,TextWidth(St))
  else
  if TextAlign=TA_CENTER then
     Dec(x,TextWidth(St) div 2);

  AddTag('mx:Label','text="'+St+'" '+FlexPosition(x,y)+
         FlexFont(Font)+' textAlign="left"');
end;

procedure TFlexCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);

  function RXY:String;
  begin
    result:='rx="'+IntToStr(x3)+'" ry="'+IntToStr(y3)+'"';
  end;

begin
  AddTag('tee:RoundRect',FlexPosition(X1,Y1)+' '+FlexSize(X2-X1,Y2-Y1)+' '+RXY+
         FlexAlpha+PenColor+BrushColor+PenWidth);
end;

procedure TFlexCanvas.SetBackColor(Color: TColor);
begin
  FBackColor:=Color;
end;

procedure TFlexCanvas.SetBackMode(Mode: TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

procedure TFlexCanvas.SetMonochrome(Value: Boolean);
begin  // empty
end;

procedure TFlexCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
//TODO
end;

procedure TFlexCanvas.SetPixel3D(X, Y, Z: Integer; Value: TColor);
begin
  Calc3DPos(x,y,z);
  SetPixel(x,y,Value);
end;

procedure TFlexCanvas.SetTextAlign(Align: TCanvasTextAlign);
begin
  FTextAlign:=Align;
end;

procedure TFlexCanvas.ShowImage(DestCanvas, DefaultCanvas: TCanvas;
  const UserRect: TRect);
begin
  AddItem('    </mx:Canvas>');
  AddItem('</mx:Application>');

  Pen.OnChange:=nil;
end;

procedure TFlexCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);

  function ImageSource:String;
  begin
    if EmbeddImages then
       result:='@Embed('''+ImageFileName(Graphic)+''')'
    else
       result:=ImageFileName(Graphic);
  end;

begin
  if Assigned(Graphic) then
  begin
    AddTag('mx:Image',FlexPosition(Rect.Left,Rect.Top)+' '+
      ' scaleX="'+FloatToStr((Rect.Right-Rect.Left)/Graphic.Width)+'" '+
      ' scaleY="'+FloatToStr((Rect.Bottom-Rect.Top)/Graphic.Height)+'" '+
      ' source="'+ImageSource+'"');
  end;
end;

procedure TFlexCanvas.TextOut(X, Y: Integer; const Text: String);
begin
  RotateLabel(x,y,Text,0);
end;

procedure TFlexCanvas.TextOut3D(X, Y, Z: Integer; const Text: String);
begin
  Calc3DPos(X,Y,Z);
  TextOut(X,Y,Text);
end;

procedure TFlexCanvas.UnClipRectangle;
begin
//TODO
  inherited;
end;

procedure TFlexCanvas.AddItem(const S: String);
begin
  FStrings.Add(S);
end;

procedure TFlexCanvas.AddLink(x,y:Integer; const Text, URL, Hint: String);
begin
  AddTag('mx:LinkButton','label="'+Text+'" '+FlexPosition(x,y)+
      ' toolTip="'+Hint+'" '+
      FlexFont(Font)+
      'click="navigateToURL(new URLRequest('''+URL+'''), '''+Hint+''')"');
end;

procedure TFlexCanvas.AddToolTip(const Entity,ToolTip:String);
begin
  if not IAddedInitApp then
  begin
    FStrings.Insert(IApplication-1,' creationComplete = "initApp()"');
    FStrings.Insert(IScript,' }');
    FStrings.Insert(IScript,' public function initApp():void {');

    IAddedInitApp:=True;
  end;

  FStrings.Insert(IScript+1,' '+Entity+'.toolTip = "'+ToolTip+'";');
  Inc(IScript);
end;

{ TFlexExportFormat }

function TFlexExportFormat.Compile(const TargetFile:String):Boolean;
begin
  CheckProperties;
  result:=FProperties.Compile(TargetFile);
end;

function TFlexExportFormat.Description: String;
begin
  result:=TeeMsg_AsFlex;
end;

procedure TFlexExportFormat.DoCopyToClipboard;
begin
  with FlexMXML do
  try
    Clipboard.AsText:=Text;
  finally
    Free;
  end;
end;

function TFlexExportFormat.FileExtension: String;
begin
  result:='mxml'; // Do not localize
end;

function TFlexExportFormat.FileFilter: String;
begin
  result:=TeeMsg_FlexFilter;
end;

type
  TTeePanelAccess=class(TCustomTeePanel);

function TFlexExportFormat.FlexMXML: TStringList;
{$IFNDEF CLR}
var tmp : TCanvas3D;
{$ENDIF}
begin
  CheckSize;
  result:=TStringList.Create;
  Panel.AutoRepaint:=False;

  try
    {$IFNDEF CLR} // Protected across assemblies
    tmp:=TTeePanelAccess(Panel).InternalCanvas;
    TTeePanelAccess(Panel).InternalCanvas:=nil;
    {$ENDIF}

    Panel.Canvas:=TFlexCanvas.Create(Panel, result);

    TFlexCanvas(Panel.Canvas).ImagePath:=ImagePath;
    TFlexCanvas(Panel.Canvas).EmbeddImages:=EmbeddImages;

    if not Assigned(Panel.Parent) then
      Panel.BufferedDisplay:=True;  // 7.01

    try
      Panel.Draw(Panel.Canvas.ReferenceCanvas,TeeRect(0,0,Width,Height));
    finally
      {$IFNDEF CLR} // Protected across assemblies
      Panel.Canvas:=tmp;
      {$ENDIF}
    end;
  finally
    Panel.AutoRepaint:=True;
    Panel.Invalidate;
  end;
end;

Procedure TFlexExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then
  begin
    FProperties:=TFlexOptions.Create(nil);
    FProperties.Panel:=Panel;
  end;
end;

function TFlexExportFormat.Options(Check: Boolean): TForm;
begin
  if Check then
     CheckProperties;

  result:=FProperties;
end;

procedure TFlexExportFormat.SaveToStream(Stream: TStream);
begin
  with FlexMXML do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

procedure TFlexOptions.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  ReadOptions;
end;

{$IFNDEF CLR}
function WindowsMajorVersion:Integer;
var
  OSVI: TOSVersionInfo;
begin
  FillChar(OSVI, SizeOf(OSVI), 0);
  OSVI.dwOSVersionInfoSize := SizeOf(OSVI);
  if not GetVersionEx(OSVI) then
     raise Exception.Create('Error calling Windows GetVersionEx to obtain version number.');

  result:=OSVI.dwMajorVersion;
end;

var
  GetLongPathName:function(lpszShortPath: PChar; lpszLongPath: PChar;
                           cchBuffer: DWORD): DWORD; stdcall;

  TeeKernel32:THandle=0;


function LongPathName(const FileName:String):String;
var
  BufferSize: DWord;
begin
  // "GetLongPathNameA" available only for Win2000, WinXP or Win2003, or newer !
  if (Win32Platform=VER_PLATFORM_WIN32_NT) and (WindowsMajorVersion>=5) then
  begin
    if TeeKernel32=0 then
    begin
      TeeKernel32:=TeeLoadLibrary(kernel32);

      if TeeKernel32<>0 then
         @GetLongPathName:=GetProcAddress(TeeKernel32,'GetLongPathNameA');
    end;

    BufferSize := GetLongPathName(PChar(FileName), nil, 0);
    SetLength(Result, BufferSize - 1);
    GetLongPathName(PChar(FileName), PChar(Result), BufferSize);
  end
  else
    result:=FileName;
end;

{$ELSE}
function LongPathName(const FileName:String):String;
begin
  result:=FileName;
end;
{$ENDIF}

type
  TPathName={$IFDEF CLR}String{$ELSE}Array[0..MAX_PATH] of Char{$ENDIF};

procedure TFlexOptions.ReadOptions;
var tmpPath : {$IFDEF CLR}StringBuilder{$ELSE}TPathName{$ENDIF};
    tmpName : TPathName;
begin
  ETemp.Text:=TeeReadStringOption('FlexCanvas_Temp','');

  if ETemp.Text='' then
  begin
    {$IFDEF CLR}
    tmpPath:=StringBuilder.Create;
    {$ENDIF}

    if GetTempPath(MAX_PATH,tmpPath)=0 then
       Raise Exception.Create(TeeMsg_CanNotFindTempPath);

    {$IFDEF CLR}
    tmpName:=tmpPath.ToString;
    {$ELSE}
    StrPCopy(tmpName,StrPas(tmpPath));
    {$ENDIF}

    ETemp.Text:=LongPathName(tmpName);
  end;

  EFlex.Text:=TeeReadStringOption('FlexCanvas_Compiler','');
end;

procedure TeeSaveToFlexFile( APanel:TCustomTeePanel; const FileName: WideString;
                             AWidth:Integer=0; AHeight:Integer=0;
                             EmbededImages:Boolean=True);
begin
  with TFlexExportFormat.Create do
  try
    Panel:=APanel;
    Height:=AHeight;
    Width:=AWidth;

    ImagePath:=ExtractFilePath(FileName);
    EmbeddImages:=EmbededImages;

    SaveToFile(FileName);
  finally
    Free;
  end;
end;

function TFlexOptions.Compile(const TargetFile:String):Boolean;
{$IFDEF CLR}
begin
  result:=False;
  ShowMessageUser('Compiling Flex from .NET platform not available.');
{$ELSE}
var d : TDosCommand;
    tmpPath : String;
begin
  d:=TDosCommand.Create(Self);
  try
    tmpPath:=ExtractFilePath(TargetFile);
    d.CommandLine:='"'+EFlex.Text+'\mxmlc.exe" -use-network=false -library-path+="'+tmpPath+'\tee.swc" "'+TargetFile+'"';

    Screen.Cursor:=crHourGlass;
    try
      d.Execute;

      while not d.Terminated do
            Sleep(1);

    finally
      Screen.Cursor:=crDefault;
    end;

    result:=d.DosExitCode=0;

    if not result then
    begin
      d.Lines.Insert(0,'');
      d.Lines.Insert(0,d.CommandLine);
      d.Lines.Insert(0,'Compiling:');

      TeeEditStrings(Self, d.Lines);
    end;
  finally
    d.Free;
  end;
{$ENDIF}
end;

Function GetFilesFromDir(const PathAndWildcards:String):TStringList;
var f:TSearchRec;
begin
  result:=TStringList.Create;

  if FindFirst(PathAndWildcards,faAnyFile,f)=0 then
  begin
    Repeat
      if (f.Attr and faDirectory)=faDirectory then
      else
        result.Add(f.Name);

    Until FindNext(f)<>0;

    FindClose(f);
  end;
end;

procedure DeleteFiles(const Path,Wildcards:String);
var tmp : TStrings;
    t   : Integer;
begin
  tmp:=GetFilesFromDir(Path+'\'+Wildcards);
  try
    for t:=0 to tmp.Count-1 do
        DeleteFile(Path+'\'+tmp[t]);
  finally
    tmp.Free;
  end;
end;

procedure TFlexOptions.BCompileClick(Sender: TObject);

  function ResourceHandle(const AName:String):THandle;
  begin
    if FindResource(MainInstance, {$IFNDEF CLR}PChar{$ENDIF}(AName),
                    RT_RCDATA) <> 0 then
       result:=MainInstance
    else
       result:=HInstance;
  end;

  procedure GenerateHTML(const Path,Movie:String);
  var tmp : TStrings;
      t   : Integer;
  begin
    // Create FileName.html with Flash movie: FileName.swf
    // Also AC_OETags.js Flash ActiveX detector script.

    if not FileExists(Path+'\AC_OETags.js') then
       AC_OETags_js.Lines.SaveToFile(Path+'\AC_OETags.js');

    tmp:=TStringList.Create;
    try
      {$IFDEF D6}
      tmp.AddStrings(Chart1_html.Lines);
      {$ELSE}
      tmp.Text:=Chart1_html.Lines.Text;
      {$ENDIF}

      for t:=0 to tmp.Count-1 do
      if Pos('%MOVIE%',tmp[t])>0 then
         tmp[t]:=StringReplace(tmp[t],'%MOVIE%',Movie,[rfReplaceAll,rfIgnoreCase]);

      tmp.SaveToFile(Path+'\'+Movie+'.html');
    finally
      tmp.Free;
    end;
  end;

  procedure Preview(const Target:String);
  begin
    TeeGotoURL(Handle, Target);
  end;

  procedure Check_TeeSWC_Library(const TeeSWC:String);
  var swc : TResourceStream;
  begin
    if not FileExists(TeeSWC) then
    begin
      swc:=TResourceStream.Create(ResourceHandle('TEEFLEXSWC'),'TEEFLEXSWC',RT_RCDATA);
      try
        swc.SaveToFile(TeeSWC);
      finally
        swc.Free;
      end;
    end;
  end;

var tmpName : String;
    tmpDest : String;
    tmpRes  : Boolean;
    tmpWidth  : Integer;
    tmpHeight : Integer;
begin
  tmpDest:=ETemp.Text;

  if not DirectoryExists(tmpDest) then
     if TeeYesNo('Folder "'+tmpDest+'" does not exist.'#13+
                 'Do you want to create it?') then
        ForceDirectories(tmpDest);

  tmpName:=Panel.Name;
  if tmpName='' then tmpName:='Chart1';

  if Copy(tmpDest,Length(tmpDest),1)='\' then
     tmpDest:=tmpDest+tmpName+'.mxml'
  else
     tmpDest:=tmpDest+'\'+tmpName+'.mxml';

  if Assigned(Parent) and (Parent.Owner is TTeeExportFormBase) then
  begin
    tmpWidth:=TTeeExportFormBase(Parent.Owner).UDWidth.Position;
    tmpHeight:=TTeeExportFormBase(Parent.Owner).UDHeight.Position;
  end
  else
  begin
    tmpWidth:=Panel.Width;
    tmpHeight:=Panel.Height;
  end;

  TeeSaveToFlexFile(Panel,tmpDest,tmpWidth,tmpHeight,CBEmbedd.Checked);

  Check_TeeSWC_Library(ETemp.Text+'\tee.swc');

  tmpRes:=Compile(tmpDest);

  if CBDelete.Checked then
  begin
    if FileExists(ETemp.Text+'\tee.swc') then
       DeleteFile(ETemp.Text+'\tee.swc');

    if FileExists(tmpDest) then
       DeleteFile(tmpDest);

    // Delete images only if they have been embedd inside the *.swf movie:
    if CBEmbedd.Checked then
       DeleteFiles(ETemp.Text,'TeeChart_Flex_Temp_*');
  end;

  if tmpRes and CBPreview.Checked then
  begin
    GenerateHTML(ETemp.Text,tmpName);
    Preview(ETemp.Text+'\'+tmpName+'.html');
  end;
end;

procedure TFlexOptions.SpeedButton1Click(Sender: TObject);
Var tmpDir : {$IFDEF K3}WideString
             {$ELSE}
             {$IFDEF D7}
               {$IFDEF CLX}WideString
               {$ELSE}String
               {$ENDIF}
             {$ELSE}String
             {$ENDIF}
             {$ENDIF};
begin
  tmpDir:=ETemp.Text;

  if SelectDirectory(TeeMsg_SelectTmpFolder,'',tmpDir) then
     ETemp.Text:=tmpDir;
end;

procedure TFlexOptions.SpeedButton2Click(Sender: TObject);
Var tmpDir : {$IFDEF K3}WideString
             {$ELSE}
             {$IFDEF D7}
               {$IFDEF CLX}WideString
               {$ELSE}String
               {$ENDIF}
             {$ELSE}String
             {$ENDIF}
             {$ENDIF};
begin
  tmpDir:=EFlex.Text;

  if SelectDirectory(TeeMsg_PathAdobeFlexCompiler,'',tmpDir) then
     EFlex.Text:=tmpDir;
end;

procedure TFlexOptions.ETempChange(Sender: TObject);
begin
  CheckCompile;
  TeeSaveStringOption('FlexCanvas_Temp',ETemp.Text);
end;

procedure TFlexOptions.CheckCompile;
begin
  BCompile.Enabled:=Assigned(Panel) and (ETemp.Text<>'') and (EFlex.Text<>'');
end;

procedure TFlexOptions.EFlexChange(Sender: TObject);
begin
  if FileExists(EFlex.Text+'\mxmlc.exe') then
  begin
    CheckCompile;
    TeeSaveStringOption('FlexCanvas_Compiler',EFlex.Text);
  end
  else
    ShowMessageUser('Cannot find Flex compiler mxmlc.exe in folder: '#13+EFlex.Text);
end;

procedure TFlexOptions.FormShow(Sender: TObject);
begin
  CheckCompile;
end;

initialization
  RegisterTeeExportFormat(TFlexExportFormat);
  RegisterClass(TFlexOptions);
finalization
  UnRegisterTeeExportFormat(TFlexExportFormat);
end.
