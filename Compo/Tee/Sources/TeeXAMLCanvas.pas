{*************************************************}
{ TeeChart Pro XAML (XAML) Canvas and Exporting   }
{ Windows Presentation Foundation Graphics / 3D   }
{ Copyright (c) 2004-2009 by David Berneda        }
{ All Rights Reserved                             }
{*************************************************}
unit TeeXAMLCanvas;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QGraphics, QForms, QControls, QStdCtrls,
     {$ELSE}
     Graphics, Forms, Controls, StdCtrls,
     {$ENDIF}
     {$IFDEF D6}
     Types,
     {$ENDIF}
     TeCanvas, TeeProcs, TeEngine, TeeExport;

type
  TXAMLCanvas = class(TTeeCanvas3D)
  private
    { Private declarations }
    FBackColor   : TColor;
    FBackMode    : TCanvasBackMode;
    FTextAlign   : TCanvasTextAlign;
    FX           : Integer;
    FY           : Integer;
    FStrings     : TStrings;

    IPenStyle    : TPenStyle;
    IPenWidth    : Integer;
    ITransp      : TTeeTransparency;
    IPanel       : TCustomTeePanel;

    Procedure Add(Const S:String); {$IFDEF D10}inline;{$ENDIF}
    Procedure AddStrings(const Strings:String);
    procedure ChangedPen(Sender: TObject);
    Function PointToStr(X,Y:Integer):String;
    Function PrepareShape(const Prefix:String; UsePen:Boolean=True; UseBrush:Boolean=True):String;
    Function XAMLColor(AColor:TColor):String;
  protected
    { Protected declarations }

    function BeginCanvasTag(ABackColor:TColor):String; virtual;
    function EndCanvasTag:String; virtual;

    { 2d }
    Function GetTextAlign:TCanvasTextAlign; override;
    Procedure InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean); virtual;
    procedure SetPixel(X, Y: Integer; Value: TColor); override;

    { 3d }
    procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;
    Procedure SetBackMode(Mode:TCanvasBackMode); override;
    Function GetMonochrome:Boolean; override;
    Procedure SetMonochrome(Value:Boolean); override;
    Procedure SetBackColor(Color:TColor); override;
    Function GetBackMode:TCanvasBackMode; override;
    Function GetBackColor:TColor; override;
    procedure SetTextAlign(Align:TCanvasTextAlign); override;

    Function XAMLPen:String;
  public
    { Public declarations }
    Constructor Create(Panel:TCustomTeePanel; AStrings:TStrings); virtual;

    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;

    procedure AssignVisiblePenColor(APen:TPen; AColor:TColor); override;

    procedure Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer); override;
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
    procedure RotateLabel3D(x,y,z:Integer;
                            Const St:String; RotDegree:Double); override;
    Procedure Polygon(const Points: array of TPoint); override;
    Procedure Polyline(const Points: {$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF}); override;

    Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; override;
    procedure EndBlending(Blend:TTeeBlend); override;

    { 3d }
    Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;
    procedure EllipseWithZ(X1, Y1, X2, Y2, Z:Integer); override;
    Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
  end;

  TTextOutItem=packed record
                 XPos,
                 YPos,
                 ZPos     : Integer;
                 FontFamily,
                 ItemText : String;
                 FontColor,
                 ItemBack : TColor;
               end;

  TXAML3DCanvas=class(TXAMLCanvas)
  private
    FZ     : Integer;

    IItems : TStrings;
    ITexts : Array of TTextOutItem;

    function GetOpacity:String;
    function IDTag(const Prefix:String):String;
    function TextOutList:String;
  protected
    function BeginCanvasTag(ABackColor:TColor):String; override;
    procedure BeginEntity(const Entity:String); override;
    function EndCanvasTag:String; override;
    procedure EndEntity; override;
    Function GetSupportsFullRotation:Boolean; override;
    Procedure InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean); override;
  public
    ScrollBars : Boolean;

    Constructor Create(Panel:TCustomTeePanel; AStrings:TStrings); override;
    Destructor Destroy; override;

    procedure Cone( Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer;
                    Dark3D:Boolean; ConePercent:Integer); override;
    Procedure Cube(Left,Right,Top,Bottom,Z0,Z1:Integer; DarkSides:Boolean); override;
    procedure EraseBackground(const Rect: TRect); override;
    procedure LineTo(X, Y: Integer); override;
    procedure LineTo3D(X,Y,Z:Integer); override;
    procedure MoveTo3D(X,Y,Z:Integer); override;
    Procedure Polygon(const Points: Array of TPoint); override;
    Procedure Polyline(const Points: {$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF}); override;
    Procedure RectangleWithZ(Const Rect:TRect; Z:Integer); override;
    Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;
  end;

  TXAMLOptions=class(TForm)
    CB3D: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TXAMLExportFormat=class(TTeeExportFormat)
  private
    FProperties: TXAMLOptions;
    Procedure CheckProperties;
  protected
    Procedure DoCopyToClipboard; override;
  public
    Is3D       : Boolean;
    ScrollBars : Boolean;

    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function XAML:TStringList;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

procedure TeeSaveToXAMLFile( APanel:TCustomTeePanel; const FileName: WideString;
                             AWidth:Integer=0; AHeight: Integer=0;
                             XAML3D:Boolean=False);

implementation


{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     TeeConst, SysUtils;

Const
  CRLF=#13#10;

{ TXAMLCanvas }
Constructor TXAMLCanvas.Create(Panel:TCustomTeePanel; AStrings:TStrings);
begin
  inherited Create;
  IPanel:=Panel;
  FStrings:=AStrings;
  UseBuffer:=False;
end;

Procedure TXAMLCanvas.AddStrings(const Strings:String);
var tmp : String;
    i   : Integer;
begin
  tmp:=Strings;

  repeat
    i:=Pos(CRLF,tmp);

    if i=0 then
    begin
      Add(tmp);
      tmp:='';
    end
    else
    begin
      Add(Copy(tmp,1,i-1));
      Delete(tmp,1,i+1);
    end;
  until tmp='';
end;

Procedure TXAMLCanvas.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin
  AddStrings(EndCanvasTag);
  Pen.OnChange:=nil;
end;

function TXAMLCanvas.EndCanvasTag:String;
begin
  result:='</Canvas>';
end;

Procedure TXAMLCanvas.Add(Const S:String);
begin
  FStrings.Add(S);
end;

Function ColorInternal(AColor:TColor):String;
begin
  AColor:=ColorToRGB(AColor);

  case AColor of
    clBlack: result:='Black';
    clWhite: result:='White';
    clRed:   result:='Red';
    clGreen: result:='Green';
    clBlue:  result:='Blue';
   clYellow: result:='Yellow';
    clGray:  result:='Gray';
    clNavy:  result:='Navy';
    clOlive: result:='Olive';
    clLime:  result:='Lime';
    clTeal:  result:='Teal';
  clSilver:  result:='Silver';
  clPurple:  result:='Purple';
 clFuchsia:  result:='Fuchsia';
  clMaroon:  result:='Maroon';
  else
  begin
    result:='#'+IntToHex(GetRValue(AColor),2)+
                IntToHex(GetGValue(AColor),2)+
                IntToHex(GetBValue(AColor),2);

//    if result='#000000' then result:='#0';
  end;
  end;
end;

Function TXAMLCanvas.XAMLColor(AColor:TColor):String;
begin
  if ITransp<>0 then
  begin
    AColor:=ColorToRGB(AColor);
    
    result:='"#'+IntToHex(255-Round(2.55*ITransp),2)+
                IntToHex(GetRValue(AColor),2)+
                IntToHex(GetGValue(AColor),2)+
                IntToHex(GetBValue(AColor),2)+'"';
  end
  else
     result:='"'+ColorInternal(AColor)+'"';
end;

procedure TXAMLCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  InternalRect(TeeRect(X0,Y0,X1,Y1),True,False);
end;

procedure TXAMLCanvas.MoveTo(X, Y: Integer);
begin
  FX:=X;
  FY:=Y;
end;

procedure TXAMLCanvas.AssignVisiblePenColor(APen:TPen; AColor:TColor);
begin
  IPenStyle:=APen.Style;
  IPenWidth:=APen.Width;
  Pen.OnChange:=nil;

  inherited;

  Pen.OnChange:=ChangedPen;
end;

Function TXAMLCanvas.XAMLPen:String;

  Function IsSmallDots:Boolean;
  begin
    result:=(Pen is TChartPen) and TChartPen(Pen).SmallDots;
  end;

  Function PenStyle:String;
  begin
    if IsSmallDots then
       result:='Dot'
    else
    Case IPenStyle of
      psSolid: ;
      psDash: result:='Dash';
      psDot: result:='Dot';
      psDashDot: result:='DashDot';
      psDashDotDot: result:='DashDotDot';
    end;
  end;

  function PenWidth:String;
  begin
    if (IPenStyle<>psSolid) and (IPenWidth=1) then
       result:=' StrokeThickness="2" '
    else
    if IPenWidth>1 then
       result:=' StrokeThickness="'+TeeStr(IPenWidth)+'" '
    else
       result:='';
  end;

begin
  result:=PenWidth+'Stroke='+XAMLColor(Pen.Color);  // Pen.Style

  if IPenStyle<>psSolid then
     result:=result+' StrokeDashArray="{Binding Source={x:Static DashStyles.'+PenStyle+'}, Path=Dashes}" StrokeDashCap="Round"';
end;

procedure TXAMLCanvas.LineTo(X, Y: Integer);
begin
  Add('<Line X1="'+TeeStr(FX)+'" X2="'+TeeStr(X)+
          '" Y1="'+TeeStr(FY)+'" Y2="'+TeeStr(Y)+'" '+XAMLPen+'/>');

  FX:=X;
  FY:=Y;
end;

procedure TXAMLCanvas.ClipRectangle(Const Rect:TRect);
begin
end;

procedure TXAMLCanvas.ClipCube(Const Rect:TRect; MinZ,MaxZ:Integer);
begin
end;

procedure TXAMLCanvas.UnClipRectangle;
begin
end;

function TXAMLCanvas.GetBackColor:TColor;
begin
  result:=FBackColor;
end;

procedure TXAMLCanvas.SetBackColor(Color:TColor);
begin
  FBackColor:=Color;
end;

procedure TXAMLCanvas.SetBackMode(Mode:TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

Function TXAMLCanvas.GetMonochrome:Boolean;
begin
  result:=False;
end;

Procedure TXAMLCanvas.SetMonochrome(Value:Boolean);
begin
end;

function AddRectangle(Rect:TRect):String;
begin
  Rect:=OrientRectangle(Rect);

  result:=' Canvas.Left="'+TeeStr(Rect.Left)+
          '" Canvas.Top="'+TeeStr(Rect.Top)+
          '" Width="'+TeeStr(Rect.Right-Rect.Left+1)+
          '" Height="'+TeeStr(Rect.Bottom-Rect.Top+1)+'"';
end;

procedure TXAMLCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
  Add('<Rectangle');
  Add(AddRectangle(Rect)+'>');
  Add(' <Rectangle.Fill>');
//  Add('  <ImageBrush ImageSource="sample.jpg"/>');
  Add(' </Rectangle.Fill>');
  Add('</Rectangle>');
end;

procedure TXAMLCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  Add('<Rectangle');
  Add(AddRectangle(TeeRect(X,Y,X+Graphic.Width,Y+Graphic.Height))+'>');
  Add(' <Rectangle.Fill>');
//  Add('  <ImageBrush ImageSource="sample.jpg"/>');
  Add(' </Rectangle.Fill>');
  Add('</Rectangle>');
end;

(*
Function TXAMLCanvas.TheBounds:String;
begin
  result:='width:'+IntToStr(Bounds.Right-Bounds.Left)+
          ';height:'+IntToStr(Bounds.Bottom-Bounds.Top);
end;
*)

Function TXAMLCanvas.PointToStr(X,Y:Integer):String;
begin
  result:=TeeStr(X)+','+TeeStr(Y);
end;

Procedure TXAMLCanvas.GradientFill( Const Rect:TRect;
                                    StartColor,EndColor:TColor;
                                    Direction:TGradientDirection;
                                    Balance:Integer=50;
                                    RadialX:Integer=0;
                                    RadialY:Integer=0);

  function StartEndPoints:String;
  begin
    Case Direction of
       gdTopBottom  : result:=' StartPoint="0.5,1" EndPoint="0.5,0"';
       gdBottomTop  : result:=' StartPoint="0.5,0" EndPoint="0.5,1"';
       gdLeftRight  : result:='';
       gdRightLeft  : result:='';
       gdFromCenter : result:='';
       gdFromTopLeft: result:='';
    else
       result:='';
    end;
  end;

var tmp : String;
begin
  Add('<Rectangle'+AddRectangle(Rect)+'>');
  Add(' <Rectangle.Fill>');

  if Direction=gdRadial then
     tmp:='RadialGradientBrush'
  else
     tmp:='LinearGradientBrush';

  Add('   <'+tmp+StartEndPoints+'>');
  Add('    <GradientStop Offset="0" Color='+XAMLColor(StartColor)+'/>');
  Add('    <GradientStop Offset="1" Color='+XAMLColor(EndColor)+'/>');
  Add('  </'+tmp+'>');

  Add(' </Rectangle.Fill>');

//  if ITransp<>0 then
//       Add(' opacity="'+FloatToStr((100-ITransp)*0.01)+'"');

  Add('</Rectangle>');
end;

procedure TXAMLCanvas.FillRect(const Rect: TRect);
begin
  InternalRect(Rect,False,False);
end;

Procedure TXAMLCanvas.InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean);
var tmp  : String;
begin
  if (Brush.Style<>bsClear) or (UsePen and (Pen.Style<>psClear)) then
  begin
    PrepareShape('Rectangle',UsePen);

    tmp:='';

    if IsRound then
       tmp:=tmp+' RadiusX="30" RadiusY="30"';

    tmp:=tmp+AddRectangle(Rect);

    (*
    if ITransp<>0 then
       tmp:=tmp+' opacity="'+FloatToStr((100-ITransp)*0.01)+'"';
    *)

    Add(tmp+'/>');
  end;
end;

procedure TXAMLCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  EllipseWithZ(X1,Y1,X2,Y2,0);
end;

procedure TXAMLCanvas.EllipseWithZ(X1, Y1, X2, Y2, Z: Integer);
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    Calc3DPos(X1,Y1,Z);
    Calc3DPos(X2,Y2,Z);

    PrepareShape('Ellipse');

    Add(' Canvas.Left="'+IntToStr(X1)+
        '" Canvas.Top="'+IntToStr(Y1)+
        '" Height="'+IntToStr(Y2-Y1+1)+
        '" Width="'+IntToStr(X2-X1+1)+'"');

    Add('/>');
  end;
end;

procedure TXAMLCanvas.SetPixel3D(X,Y,Z:Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Calc3DPos(x,y,z);
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TXAMLCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TXAMLCanvas.Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer);
var tmpSt : String;
begin
  if Pen.Style<>psClear then
  begin
    PrepareShape('Arc');
    tmpSt:=' <v:path v="ar ';
    tmpSt:=tmpSt+PointToStr(Left,Top)+' '+PointToStr(Right,Bottom)+' '+
      PointToStr(StartX,StartY)+' '+PointToStr(EndX,EndY);

    Add(tmpSt+' e"/>');
    Add('</v:shape>');
  end;
end;

procedure TXAMLCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
var tmpSt : String;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    PrepareShape('Pie');
    tmpSt:=' <v:path v="m '+PointToStr((X2+X1) div 2,(Y2+Y1) div 2)+' at ';
    tmpSt:=tmpSt+PointToStr(X1,Y1)+' '+PointToStr(X2,Y2)+' '+
      PointToStr(X3,Y3)+' '+PointToStr(X4,Y4);

    Add(tmpSt+' x e"/>');
    Add('</v:shape>');
  end;
end;

procedure TXAMLCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  InternalRect(TeeRect(X1,Y1,X2,Y2),True,True);
end;

Procedure TXAMLCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);

  Function FontStyle:String;
  begin
    result:='';

    // Style

    if Font.Style<>[] then
    begin
      if fsBold in Font.Style then
         result:=result+' FontWeight="Bold"';

      if fsItalic in Font.Style then
         result:=result+' FontStyle="Italic"';

      // Not existent in our TeeFont class:
      (*
      if fsOblique in Font.Style then
         result:=result+' FontStyle="Oblique"';
      *)

      // Not existent in XAML
      (*
      if fsUnderline in Font.Style then
         result:=result+' FontStyle="Underline"';

      if fsStrikeOut in Font.Style then
         result:=result+' FontStyle="LineThrough"';
      *)
    end;

    // InterCharSize

    if Assigned(IFont) and (IFont.InterCharSize<>0) then
    if IFont.InterCharSize>3 then
       result:=result+' FontStretch="UltraExpanded"'
    else
    if IFont.InterCharSize>2 then
       result:=result+' FontStretch="ExtraExpanded"'
    else
    if IFont.InterCharSize>1 then
       result:=result+' FontStretch="Expanded"'
    else
    if IFont.InterCharSize>0 then
       result:=result+' FontStretch="SemiExpanded"'
    else
    if IFont.InterCharSize<-3 then
       result:=result+' FontStretch="UltraCondensed"'
    else
    if IFont.InterCharSize<-2 then
       result:=result+' FontStretch="ExtraCondensed"'
    else
    if IFont.InterCharSize<-1 then
       result:=result+' FontStretch="Condensed"'
    else
    if IFont.InterCharSize<0 then
       result:=result+' FontStretch="SemiCondensed"'
  end;

  Procedure DoText(AX,AY:Integer; AColor:TColor);
  var tmp : String;
  begin
    if (TextAlign and TA_CENTER)=TA_CENTER then
       Dec(AX,TextWidth(Text) div 2)
    else
    if (TextAlign and TA_RIGHT)=TA_RIGHT then
       Dec(AX,TextWidth(Text));

    Inc(AX);
    Inc(AY);

    tmp:='<TextBlock Canvas.Left="'+TeeStr(AX)+
        '" Canvas.Top="'+TeeStr(AY)+
        '" Foreground='+XAMLColor(AColor)+' FontFamily="'+Font.Name+
        '" FontSize="'+TeeStr(Round(Font.Size*1.4))+'" '+FontStyle;

    if (BackMode=cbmOpaque) and (BackColor<>clTeeColor) then
       tmp:=tmp+' Background='+XAMLColor(BackColor);

    Add(tmp+'>');

    Add(Text);

    if fsUnderline in Font.Style then
    begin
      Add('<TextBlock.TextDecorations>');
      Add('    <TextDecorationCollection>');
      Add('      <TextDecoration');
      Add('        PenThicknessUnit="FontRecommended">');
      Add('        <TextDecoration.Pen>');
      Add('          <Pen Brush='+XAMLColor(Font.Color)+' Thickness="1" />');
      Add('        </TextDecoration.Pen>');
      Add('      </TextDecoration>');
      Add('    </TextDecorationCollection>');
      Add('  </TextBlock.TextDecorations>');
    end;

    Add('</TextBlock>');
  end;

Var tmpX : Integer;
    tmpY : Integer;
begin
  Calc3DPos(x,y,z);

  if Assigned(IFont) then
  With IFont.Shadow do
  if (HorizSize<>0) or (VertSize<>0) then
  begin
    if HorizSize<0 then
    begin
      tmpX:=X;
      X:=X-HorizSize;
    end
    else tmpX:=X+HorizSize;

    if VertSize<0 then
    begin
      tmpY:=Y;
      Y:=Y-VertSize;
    end
    else tmpY:=Y+VertSize;

    DoText(tmpX,tmpY,IFont.Shadow.Color)
  end;

  DoText(X,Y,IFont.Color);
end;

Procedure TXAMLCanvas.TextOut(X,Y:Integer; const Text:String);
begin
  TextOut3D(x,y,0,Text);
end;

Function TXAMLCanvas.GetTextAlign:TCanvasTextAlign;
begin
  result:=FTextAlign;
end;

procedure TXAMLCanvas.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Double);
begin
//TODO: RotDegree rotation
  Calc3DPos(x,y,z);
  TextOut(X,Y,St);
end;

procedure TXAMLCanvas.RotateLabel(x,y:Integer; Const St:String; RotDegree:Double);
begin
  RotateLabel3D(x,y,0,St,RotDegree);
end;

Function TXAMLCanvas.GetBackMode:TCanvasBackMode;
begin
  result:=FBackMode;
end;

Function TXAMLCanvas.PrepareShape(const Prefix:String; UsePen:Boolean=True; UseBrush:Boolean=True):String;
begin
  result:='<'+Prefix;

  if UseBrush and (Brush.Style<>bsClear) then
     result:=result+' Fill='+XAMLColor(Brush.Color);

  if UsePen and (Pen.Style<>psClear) then
     result:=result+' '+XAMLPen;

  Add(result);
end;

Procedure TXAMLCanvas.Polygon(const Points: Array of TPoint);
var tmpSt : String;
    t     : Integer;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    PrepareShape('Polygon');

    tmpSt:=' Points="';

    for t:=Low(Points) to High(Points) do
        tmpSt:=tmpSt+PointToStr(Points[t].X,Points[t].Y)+' ';

    Add(tmpSt+'"/>');
  end;
end;

Procedure TXAMLCanvas.Polyline(const Points: {$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF});
var tmpSt : String;
    t     : Integer;
begin
  if Pen.Style<>psClear then
  begin
    PrepareShape('Polyline',True,False);

    tmpSt:=' Points="';

    for t:=Low(Points) to High(Points) do
        tmpSt:=tmpSt+PointToStr(Points[t].X,Points[t].Y)+' ';

    Add(tmpSt+'"/>');
  end;
end;

function TXAMLCanvas.InitWindow(DestCanvas: TCanvas;
  A3DOptions: TView3DOptions; ABackColor: TColor; Is3D: Boolean;
  const UserRect: TRect): TRect;
begin
  result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);

  AddStrings(BeginCanvasTag(ABackColor));

  Pen.OnChange:=ChangedPen;
end;

function TXAMLCanvas.BeginCanvasTag(ABackColor:TColor):String;
begin
  result:='<Canvas Name="'+
            {$IFNDEF TEEOCX}
            IPanel.Name+
            {$ELSE}
            'Chart'+
            {$ENDIF}
            '" Width="'+IntToStr(Bounds.Right-Bounds.Left)+
            '" Height="'+IntToStr(Bounds.Bottom-Bounds.Top)+
            '" Background='+XAMLColor(ABackColor)+
            ' ClipToBounds="True"'+
            ' xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"'+
            ' xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"'+
            '>';
end;

procedure TXAMLCanvas.ChangedPen(Sender: TObject);
begin
  IPenStyle:=Pen.Style;
  IPenWidth:=Pen.Width;
end;

procedure TXAMLCanvas.SetTextAlign(Align: TCanvasTextAlign);
begin
  FTextAlign:=Align;
end;

function TXAMLCanvas.BeginBlending(const R: TRect;
  Transparency: TTeeTransparency): TTeeBlend;
begin
  ITransp:=Transparency;
  result:=nil;
end;

procedure TXAMLCanvas.EndBlending(Blend: TTeeBlend);
begin  // reset to zero
  ITransp:=0;
end;

{ TXAMLExportFormat }
function TXAMLExportFormat.Description: String;
begin
  result:=TeeMsg_AsXAML;
end;

procedure TXAMLExportFormat.DoCopyToClipboard;
begin
  with XAML do
  try
    Clipboard.AsText:=Text;
  finally
    Free;
  end;
end;

function TXAMLExportFormat.FileExtension: String;
begin
  result:='XAML';
end;

function TXAMLExportFormat.FileFilter: String;
begin
  result:=TeeMsg_XAMLFilter;
end;

Procedure TXAMLExportFormat.CheckProperties;
begin
  if not Assigned(FProperties) then
  begin
    FProperties:=TXAMLOptions.Create(nil);
    FProperties.CB3D.Checked:=Is3D;
  end;
end;

function TXAMLExportFormat.Options(Check:Boolean=True): TForm;
begin
  if Check then CheckProperties;
  result:=FProperties;
end;

procedure TXAMLExportFormat.SaveToStream(Stream: TStream);
begin
  with XAML do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

type
  TTeePanelAccess=class(TCustomTeePanel);

// Returns a panel or chart in VML format into a StringList
function TXAMLExportFormat.XAML: TStringList;
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

    CheckProperties;
    Is3D:=FProperties.CB3D.Checked;

    if Is3D then
    begin
      Panel.Canvas:=TXAML3DCanvas.Create(Panel, result);
      TXAML3DCanvas(Panel.Canvas).ScrollBars:=ScrollBars;
    end
    else
       Panel.Canvas:=TXAMLCanvas.Create(Panel, result);

    if not Assigned(Panel.Parent) then
      Panel.BufferedDisplay:=True;  // 7.01

    try
      Panel.Draw(Panel.Canvas.ReferenceCanvas,TeeRect(0,0,Width,Height));

      result.Insert(0,'<!-- Generated by TeeChart Pro Version '+TeeChartVersion+' -->');
    finally
      {$IFNDEF CLR} // Protected across assemblies
      Panel.Canvas:=tmp;
      {$ENDIF}
    end;
  finally
    Panel.AutoRepaint:=True;
  end;
end;

procedure TeeSaveToXAMLFile( APanel:TCustomTeePanel; const FileName: WideString;
                             AWidth:Integer=0;
                             AHeight:Integer=0;
                             XAML3D:Boolean=False);
begin { save panel or chart to filename in VML (html) format }
  with TXAMLExportFormat.Create do
  try
    Panel:=APanel;
    Height:=AHeight;
    Width:=AWidth;
    Is3D:=XAML3D;
    SaveToFile(FileName);
  finally
    Free;
  end;
end;

{ TXAML3DCanvas }
Constructor TXAML3DCanvas.Create(Panel:TCustomTeePanel; AStrings:TStrings);
begin
  inherited;
  SupportsID:=True;
  IItems:=TStringList.Create;
end;

Destructor TXAML3DCanvas.Destroy;
begin
  ITexts:=nil;
  IItems.Free;

  inherited;
end;

function TXAML3DCanvas.BeginCanvasTag(ABackColor:TColor):String;

  function CameraRotation:String;
  begin
    if ScrollBars then
       result:='  <PerspectiveCamera.Transform>'+CRLF+
               '     <Transform3DGroup>'+CRLF+
               '       <Transform3DGroup.Children>'+CRLF+
               '         <RotateTransform3D CenterX="0" CenterY="0" CenterZ="-0.5" >'+CRLF+
               '          <RotateTransform3D.Rotation>'+CRLF+
               '            <AxisAngleRotation3D Axis="1 0 0" Angle="{Binding ElementName=scrollV, Path=Value}" />'+CRLF+
               '          </RotateTransform3D.Rotation>'+CRLF+
               '         </RotateTransform3D>'+CRLF+
               '         <RotateTransform3D CenterX="0" CenterY="0" CenterZ="-0.5" >'+CRLF+
               '          <RotateTransform3D.Rotation>'+CRLF+
               '            <AxisAngleRotation3D Axis="0 1 0" Angle="{Binding ElementName=scrollH, Path=Value}" />'+CRLF+
               '          </RotateTransform3D.Rotation>'+CRLF+
               '         </RotateTransform3D>'+CRLF+
               '       </Transform3DGroup.Children>'+CRLF+
               '     </Transform3DGroup>'+CRLF+
               '  </PerspectiveCamera.Transform>'+CRLF
    else
       result:='';
  end;

begin
  if ScrollBars then
     result:='<Page xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"'+CRLF+
             '  xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">'+CRLF+
             '  <DockPanel>'+CRLF+
             '          <ScrollBar Name="scrollV" DockPanel.Dock="Right"'+CRLF+
             '                     Minimum="0" Maximum="360"  Value="'+FloatToStr(360-View3DOptions.ElevationFloat)+'"'+CRLF+
             '                     SmallChange="10" LargeChange="10" />'+CRLF+
             ''+CRLF+
             '          <ScrollBar Name="scrollH" DockPanel.Dock="Bottom" Orientation="Horizontal"'+CRLF+
             '                     Minimum="0" Maximum="360"  Value="'+FloatToStr(View3DOptions.RotationFloat)+'"'+CRLF+
             '                     SmallChange="10" LargeChange="10" />'+CRLF
  else
     result:='';

  result:=result+'<Viewport3D Name="'+
            {$IFNDEF TEEOCX}
            IPanel.Name+
            {$ELSE}
            'Chart'+
            {$ENDIF}
          '" ClipToBounds="True"'+CRLF+

//          ' Width="'+IntToStr(IPanel.Width)+'" Height="'+IntToStr(IPanel.Height)+'"'+
//          ' Canvas.Left="0" Canvas.Top="0"'+CRLF+


//            '" Background='+XAMLColor(ABackColor)+

          'xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"'+CRLF+
          'xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"'+CRLF+
          '>';

  result:=result+
   '   <Viewport3D.Resources>'+CRLF+
   '     <MeshGeometry3D x:Key="box"'+CRLF+
   '       Positions="-50,-50,-50 50,-50,-50 -50,50,-50 50,50,-50 -50,-50,50 50, '+
   '-50,50 -50,50,50 50,50,50 -50,-50,-50 50,-50,-50 50,-50,50 50,-50,50 -50,-50,50 '+
   '-50,-50,-50 50,50,-50 50,-50,50 50,50,-50 -50,50,-50 -50,50,50 '+
   '-50,50,50 50,50,50 50,50,-50 -50,50,-50 -50,-50,50 -50,-50,50 -50,50,-50 "'+CRLF+
   '       TriangleIndices="0 2 3  3 1 0  4 5 7  7 6 4  8 9 10  11 12 13  1 14 7  7 15 1  16 17 18  19 20 21  22 0 23  24 6 25  "'+CRLF+
   '       TextureCoordinates="1,0 0,0 1,1 0,1 0,0 1,0 0,1 1,1 0,0 1,0 1,1 1,1 0,1 0,0 1,0 0,1 0,0 1,0 1,1 1,1 0,1 0,0 0,0 1,1 1,1 0,0 "'+CRLF+
   '       Normals="0,0,-1 0,0,-1 0,0,-1 0,0,-1 0,0,1 0,0,1 0,0,1 0,0,1 0,-1,0 0,-1,0 0,-1,0 0,-1,0 1,0,0 1,0,0 1,0,0 1,0,0 0,1,0 0,1,0 0,1,0 0,1,0 -1,0,0 -1,0,0 -1,0,0 -1,0,0 "'+CRLF+
   '     />'+CRLF+
   '     <MeshGeometry3D x:Key="plane"'+CRLF+
   '       TriangleIndices="0,1,2 3,4,5 "'+CRLF+
   '       Normals="0,0,1 0,0,1 0,0,1 0,0,1 0,0,1 0,0,1 "'+CRLF+
   '       TextureCoordinates="0,0 1,0 1,1 1,1 0,1 0,0 "'+CRLF+
   '       Positions="-50,-50,50 50,-50,50 50,50,50 50,50,50 -50,50,50 -50,-50,50 " />'+CRLF+
   '   </Viewport3D.Resources>'+CRLF+
   ''+CRLF+
   '   <Viewport3D.Camera>'+CRLF+
   '     <PerspectiveCamera Position="'+FloatToStr(IPanel.Width*0.5)+
                    ',0'+{FloatToStr(IPanel.Height*0.5)+}
                    ',-550"'+CRLF+
   '                LookDirection="0, 90, 1000"'+CRLF+
   '                UpDirection="0, 0, 1"'+CRLF+
   '                NearPlaneDistance="0.1"'+CRLF+
   '                FarPlaneDistance="1000"'+CRLF+
   '                FieldOfView="'+FloatToStr(0.5*View3DOptions.Perspective)+'" >'+CRLF+
           CameraRotation+
   '     </PerspectiveCamera>'+CRLF+
   '   </Viewport3D.Camera>'+CRLF+
   '   <ModelVisual3D>'+CRLF+
   '     <ModelVisual3D.Content>'+CRLF+
   '       <Model3DGroup>'+CRLF+
   '        <Model3DGroup x:Name="ViewportLights">'+CRLF+
   '          <AmbientLight Color="#FF202020" />'+CRLF+
   '          <DirectionalLight Color="#FFFFFFFF" Direction="0, 0.6, 0.9" />'+CRLF+
   '        </Model3DGroup>'+CRLF;

end;

function TXAML3DCanvas.TextOutList:String;

  function TextOutItem(Index:Integer):String;

    function Background:String;
    begin
      if ITexts[Index].ItemBack=clNone then
         result:=''
      else
         result:=' Background='+XAMLColor(ITexts[Index].ItemBack);
    end;

  begin
    with ITexts[Index] do
      result:='<Viewport2DVisual3D Geometry="{StaticResource plane}">'+CRLF+
         '<Viewport2DVisual3D.Material>'+CRLF+
         '     <DiffuseMaterial  Viewport2DVisual3D.IsVisualHostMaterial="true" />'+CRLF+
         '        </Viewport2DVisual3D.Material>'+CRLF+
         '        <TextBlock FontFamily="'+FontFamily+'"'+
                  Background+' Foreground='+XAMLColor(FontColor)+

                  //TextAlignment="Center"  <Bold><Italic>...

                  '>'+ItemText+'</TextBlock>'+CRLF+
         ' <Viewport2DVisual3D.Transform>'+CRLF+
         '   <Transform3DGroup>'+CRLF+
         '     <Transform3DGroup.Children>'+CRLF+
         '       <ScaleTransform3D ScaleX="0.1" ScaleY="0.1" ScaleZ="-1" />'+CRLF+
         '       <TranslateTransform3D OffsetX="'+IntToStr(XPos-100)+
               '" OffsetY="'+IntToStr(YPos-100)+'" OffsetZ="'+IntToStr(ZPos-50+1)+'" />'+CRLF+
         '     </Transform3DGroup.Children>'+CRLF+
         '   </Transform3DGroup>'+CRLF+
         ' </Viewport2DVisual3D.Transform>'+CRLF+
         '</Viewport2DVisual3D>'+CRLF;
  end;

var t : Integer;
begin
  result:='';

  for t:=0 to Length(ITexts)-1 do
      result:=result+TextOutItem(t);
end;

function TXAML3DCanvas.EndCanvasTag:String;
begin
  result:='        </Model3DGroup>'+CRLF+
          '     </ModelVisual3D.Content>'+CRLF+
          '   </ModelVisual3D>'+CRLF+

          TextOutList+

          '</Viewport3D>'+CRLF;

  if ScrollBars then
     result:=result+'</DockPanel>'+CRLF+'</Page>'+CRLF;
end;

procedure TXAML3DCanvas.EraseBackground(const Rect: TRect);
begin // empty
end;

Function TXAML3DCanvas.GetSupportsFullRotation:Boolean;
begin
  result:=True;
end;

function TXAML3DCanvas.GetOpacity:String;
begin
  if ITransp=0 then
     result:=''
  else
     result:=' Opacity="'+FloatToStr((100-ITransp)*0.01)+'"';
end;

Procedure TXAML3DCanvas.RectangleWithZ(Const Rect:TRect; Z:Integer);
begin
  Cube(Rect,Z,Z+1);
end;

Procedure TXAML3DCanvas.InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean);
begin
  Cube(Rect,0,1);

  (*
  Add('<Model3DGroup x:Name="'+IDTag('plane')+'">');
  Add(' <Model3DGroup.Transform>');
  Add('   <Transform3DGroup>');
  Add('     <Transform3DGroup.Children>');
  Add('       <ScaleTransform3D ScaleX="'+FloatToStr((Rect.Right-Rect.Left)*0.01)+
                             '" ScaleY="'+FloatToStr((Rect.Bottom-Rect.Top)*0.01)+
                             '" ScaleZ="0.01" '+
                             '/>');
  Add('       <TranslateTransform3D OffsetX="'+
                      IntToStr(Rect.Left-(100-(Rect.Right-Rect.Left) div 2))+
                      '" OffsetY="'+IntToStr(Rect.Top-(100-(Rect.Bottom-Rect.Top) div 2))+
                      '" OffsetZ="-50"/>');
  Add('     </Transform3DGroup.Children>');
  Add('   </Transform3DGroup>');
  Add(' </Model3DGroup.Transform>');
  Add(' <GeometryModel3D Geometry="{StaticResource box}">');
  Add('   <GeometryModel3D.Material>');
  Add('     <DiffuseMaterial>');
  Add('        <DiffuseMaterial.Brush>');
  Add('          <SolidColorBrush Color='+XAMLColor(Brush.Color)+GetOpacity+'/>');
  Add('        </DiffuseMaterial.Brush>');
  Add('     </DiffuseMaterial>');
  Add('   </GeometryModel3D.Material>');
  Add(' </GeometryModel3D>');
  Add('</Model3DGroup>');
  *)
end;

// Generates unique ID starting with Prefix and optionally "_xxx" (number)
function TXAML3DCanvas.IDTag(const Prefix:String):String;
var tmp : Integer;
    tmpValue : Integer;
begin
  if Trim(Prefix)='' then
     result:='id'
  else
     result:=Trim(Prefix);

  if TryStrToInt(result,tmpValue) then
     result:='id_'+result;

  tmp:=0;

  while IITems.IndexOf(result)<>-1 do
  begin
    result:=Prefix+'_'+IntToStr(tmp);
    Inc(tmp);
  end;

  IITems.Add(result);
end;

procedure TXAML3DCanvas.BeginEntity(const Entity:String);
begin
  Add('<Model3DGroup x:Name="'+IDTag(Entity)+'">');
end;

procedure TXAML3DCanvas.EndEntity;
begin
  Add('</Model3DGroup>');
end;

Procedure TXAML3DCanvas.Cube(Left,Right,Top,Bottom,Z0,Z1:Integer; DarkSides:Boolean);
begin
  Add('<Model3DGroup x:Name="'+IDTag('cube')+'">');
  Add(' <Model3DGroup.Transform>');
  Add('   <Transform3DGroup>');
  Add('     <Transform3DGroup.Children>');
  Add('       <ScaleTransform3D ScaleX="'+FloatToStr((Right-Left)*0.01)+
                             '" ScaleY="'+FloatToStr((Bottom-Top)*0.01)+
                             '" ScaleZ="'+FloatToStr((Z1-Z0)*0.01)+'" '+

                             '/>');
  Add('       <TranslateTransform3D OffsetX="'+
                      IntToStr(Left-(100-(Right-Left) div 2))+
                      '" OffsetY="'+IntToStr(Top-(100-(Bottom-Top) div 2))+
                      '" OffsetZ="'+IntToStr(Z0-(100-(Z1-Z0) div 2))+'" />');
  Add('     </Transform3DGroup.Children>');
  Add('   </Transform3DGroup>');
  Add(' </Model3DGroup.Transform>');
  Add(' <GeometryModel3D Geometry="{StaticResource box}">');
  Add('   <GeometryModel3D.Material>');
  Add('     <DiffuseMaterial>');
  Add('        <DiffuseMaterial.Brush>');
  Add('          <SolidColorBrush Color='+XAMLColor(Brush.Color)+GetOpacity+'/>');
  Add('        </DiffuseMaterial.Brush>');
  Add('     </DiffuseMaterial>');
  Add('   </GeometryModel3D.Material>');
  Add(' </GeometryModel3D>');
  Add('</Model3DGroup>');
end;

procedure TXAML3DCanvas.Cone( Vertical:Boolean; Left,Top,Right,Bottom,Z0,Z1:Integer;
                    Dark3D:Boolean; ConePercent:Integer);
begin
  // Pending
end;

Procedure TXAML3DCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);
begin
  // Pending
  // ModelGroup3D + VisualBrush TextBlock... ?  Or Viewport2DVisual3D... ?

  SetLength(ITexts,Length(ITexts)+1);

  with ITexts[Length(ITexts)-1] do
  begin
    XPos:=X;
    YPos:=Y;
    ZPos:=Z;
    ItemText:=Text;
    FontFamily:=Font.Name;
    FontColor:=Font.Color;

    if BackMode=cbmOpaque then
       ItemBack:=BackColor
    else
       ItemBack:=clNone;
  end;
end;

Procedure TXAML3DCanvas.Polyline(const Points: {$IFDEF D5}Array of TPoint{$ELSE}TPointArray{$ENDIF});
begin
  // Pending
end;

procedure TXAML3DCanvas.LineTo(X, Y: Integer);
begin
  LineTo3D(X,Y,0);
end;

procedure TXAML3DCanvas.LineTo3D(X,Y,Z:Integer);
begin
  if FX=X then Inc(X);
  if FY=Y then Inc(Y);
  if FZ=Z then Inc(Z);

  Cube(TeeRect(FX,FY,X,Y),FZ,Z);
end;

procedure TXAML3DCanvas.MoveTo3D(X,Y,Z:Integer);
begin
  FX:=X;
  FY:=Y;
  FZ:=Z;
end;

Procedure TXAML3DCanvas.Polygon(const Points: Array of TPoint);
begin
  // Pending
end;

initialization
  RegisterTeeExportFormat(TXAMLExportFormat);
finalization
  UnRegisterTeeExportFormat(TXAMLExportFormat);
end.

