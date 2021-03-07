{********************************************}
{ TeeChart Pro PDF Canvas and Exporting      }
{ Copyright (c) 2002-2009 by Marjan Slatinek }
{   and David Berneda                        }
{       All Rights Reserved                  }
{                                            }
{       Some features taken from             }
{   Nishita's PDF Creation VCL (TNPDF)       }
{         ( with permission )                }
{********************************************}
unit TeePDFCanvas;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes,
  {$IFDEF CLX}
  QGraphics, QForms, Types,
  {$ELSE}
  Graphics, Forms,
  {$IFNDEF CLR}
  {$IFDEF LCL}
  LazJPEG,
  {$ELSE}
  Jpeg,
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  {$IFDEF D9}
  Types,
  {$ENDIF}
  TeCanvas, TeeProcs, TeeExport, Math;

Type
  // Base pdf object definition (taken from PDF reference )

  PFontData = ^TFontData;
  TFontData = packed record
    FontBBox: TRect;
    FirstChar,
    LastChar: Integer;
    CapHeight: Integer;
    Ascent: Integer;
    Descent: Integer;
    MaxWidth: Integer;
    AvgWidth: Integer;
    ItalicAngle: Integer;
    DigAspX,
    DigAspY: Integer;
    CharWidths: Array [0..255] of Integer;
  end;

  TImageType = (itJPEG, itBitmap, itUnknown);

  TTeePDFImageListEntry = class(TObject)
  private
    FGraphic: TGraphic;
    FHeight: Integer;
    FObjectNumber: Integer;
    FWidth: Integer;

    procedure DefineImageData;
    function GetDataLength: Integer;
    function GetImageType: TImageType;
    procedure SetObjectNumber(const Value: Integer);
  public
    Constructor Create(AGraphic: TGraphic);
    Destructor Destroy; override;

    procedure WriteDataToStream(AStream: TStream);

    property DataLength: Integer read GetDataLength;
    property Height: Integer read FHeight;
    property ImageType: TImageType read GetImageType;
    property ObjectNumber: Integer read FObjectNumber write SetObjectNumber;
    property Width: Integer read FWidth;
  end;

  TTeePDFImageList = class(TObject)
  private
    IImageList: TList;

    function EqualImages(i1,i2: TGraphic): boolean;
    function GetCount: Integer;
    function GetImageEntry(Index: Integer): TTeePDFImageListEntry;
  public
    Constructor Create;
    Destructor Destroy; override;

    function AddItem(AGraphic: TGraphic): Integer;
    function Find(AGraphic: TGraphic): Integer;

    property Items[Index: Integer]: TTeePDFImageListEntry read GetImageEntry;
    property ItemsCount: Integer read GetCount;
  end;

  TTeePDFFontListEntry = class (TObject)
  private
    FFontData: TFontData;
    FPDFName: String;
    FObjectNumber: Integer;

    procedure DefineFontData(AFont: TFont);
    procedure SetObjectNumber(const Value: Integer);
  public
    Constructor Create(AFont: TFont);

    property PDFName: String read FPDFName;
    property ObjectNumber: Integer read FObjectNumber write SetObjectNumber;
    property FontData: TFontData read FFontData;
  end;

  TTeePDFFontList = class (TObject)
  private
    IFontList: TList;

    function GetFontEntry(Index: Integer): TTeePDFFontListEntry;
    function GetCount: Integer;
  public
    Constructor Create;
    Destructor Destroy; override;

    property Items[Index: Integer]: TTeePDFFontListEntry read GetFontEntry;
    property ItemsCount: Integer read GetCount;

    function AddItem(AFont: TFont; AHandle: TTeeCanvasHandle): Integer;
    function Find(AFont: TFont): Integer;
  end;

  TPDFChartObject = class(TObject)
  private
    FContents: TStream;
    FFontArray: TTeePDFFontList;
    FImageArray: TTeePDFImageList;
    function GetLength: Integer;
  public
    Constructor Create;
    Destructor Destroy; override;

    procedure SaveToStream(AStream: TStream);

    property Contents: TStream read FContents;
    property Length: Integer read GetLength;
    property FontArray: TTeePDFFontList read FFontArray;
    property ImageArray: TTeePDFImageList read FImageArray;
  end;

  TTeePDFPage = class(TObject)
  private
    IObjCount,
    CatalogNum,
    ParentNum,
    ResourceNum: Integer;

    tmpSt: String;

    OffsetList: TStringList;
    FChartObject: TPDFChartObject;
    XRefPos: Integer;
    FPageHeight: Integer;
    FPageWidth: Integer;

    procedure AddToOffset(Offset: Integer);
    procedure SetPageHeight(const Value: Integer);
    procedure SetPageWidth(const Value: Integer);
    procedure WriteHeader(AStream: TStream);
    procedure WriteInfo(AStream: TStream);
    procedure WriteTTFonts(AStream: TStream);
    procedure WriteImages(AStream: TStream);
    procedure WriteResources(AStream: TStream);
    procedure WritePages(AStream: TStream);
    procedure WritePage(AStream: TStream);
    procedure WriteCatalog(AStream: TStream);
    procedure WriteXRef(AStream: TStream);
    procedure WriteTrailer(AStream: TStream);
  public
    Constructor Create;
    Destructor Destroy; override;

    procedure SaveToStream(AStream: TStream);

    property PageWidth: Integer read FPageWidth write SetPageWidth;
    property PageHeight: Integer read FPageHeight write SetPageHeight;
    property ChartObject: TPDFChartObject read FChartObject;
  end;

  TPDFCanvas = class(TTeeCanvas3D)
  private
    { Private declarations }
    FBackColor : TColor;
    FBackMode : TCanvasBackMode;
    FTextAlign   : TCanvasTextAlign;
    IWidth,
    IHeight: Integer;
    FX,
    FY: Double;
    tmpSt: String;
    FEmbeddedFonts: boolean;
    FCStream: TStream;
    FContents: TPDFChartObject;

    // 7.05
    IClipStack     : Integer;

    // 7.03
    IPenStyle    : TPenStyle;
    IPenWidth    : Integer;

    Function BrushProperties: String;
    procedure ChangedPen(Sender: TObject); // 7.03
    Function FontProperties(Font: TTeeFont; var FontIndex: Integer): String;
    Function InternalBezCurve(const ax1,ay1,ax2,ay2,ax3,ay3: double): String;
    procedure InternalDrawArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer; MoveTo0: Boolean; DrawPie: Boolean);
    Procedure InternalDrawImage(const sx, sy, tx,ty: double; ImageIndex: Integer);
    Procedure InternalRect(Const Rect:TRect; UsePen,IsRound:Boolean);
    Function PenProperties: String;
    Function PointToStr(X, Y: double):String;
    Function SelectFont(Font: TFont): Integer;
    Function SelectImage(Graphic: TGraphic): integer;
    procedure SetEmbeddedFonts(const Value: boolean);
    Function SetPenStyle(PenStyle: TPenStyle): String;
    function TextToPDFText(const AText: String): String;
    Function TheBounds:String;
    Procedure TranslateVertCoord(var Y: Double);
  protected
    { Protected declarations }

    procedure SetTextAlign(Align:TCanvasTextAlign); override;
    Function GetTextAlign:TCanvasTextAlign; override;
    Function GetBackColor:TColor; override;
    Function GetBackMode:TCanvasBackMode; override;
    Function GetMonochrome:Boolean; override;
    Procedure SetBackColor(Color:TColor); override;
    Procedure SetBackMode(Mode:TCanvasBackMode); override;
    procedure SetPixel(X, Y: Integer; Value: TColor); override;
    procedure SetPixel3D(X,Y,Z:Integer; Value: TColor); override;
    Function GetIsNoBMPGrid:Boolean; override;
  public
    { Public declarations }

    Constructor Create(AChartObject: TPDFChartObject);
    Destructor Destroy; override;

    Function InitWindow( DestCanvas:TCanvas;
                         A3DOptions:TView3DOptions;
                         ABackColor:TColor;
                         Is3D:Boolean;
                         Const UserRect:TRect):TRect; override;

    procedure AssignVisiblePenColor(APen:TPen; AColor:TColor); override;  // 7.0

    Function BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend; override;
    procedure EndBlending(Blend:TTeeBlend); override;

    procedure WriteToStream(AStream: TStream);

    { 2d }
    Function TextWidth(Const St:String):Integer; override;
    Function TextHeight(Const St:String):Integer; override;

    { 3d }
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

    procedure ClipRectangle(Const Rect:TRect); override;
    Procedure ClipRectangle(Const Rect:TRect; RoundSize:Integer); override;
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

    { 3d }
    Procedure ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect); override;
    procedure EllipseWithZ(X1, Y1, X2, Y2, Z:Integer); override;
    Procedure TextOut3D(X,Y,Z:Integer; const Text:String); override;

    property EmbeddedFonts: Boolean read FEmbeddedFonts write SetEmbeddedFonts default False;
  end;

  TPDFExportFormat=class(TTeeExportFormat)
  protected
    Procedure DoCopyToClipboard; override;
  public
    function Description:String; override;
    function FileExtension:String; override;
    function FileFilter:String; override;
    Function PDFPage: TTeePDFPage;
    function ChartObject: TPDFChartObject;
    Function Options(Check:Boolean=True):TForm; override;
    Procedure SaveToStream(Stream:TStream); override;
  end;

  procedure WriteStringToStream(Stream: TStream; const S:AnsiString);

  procedure TeeSaveToPDFFile( APanel:TCustomTeePanel; const FileName: WideString;
                            AWidth:Integer=0;
                            AHeight: Integer=0);

implementation

uses {$IFDEF CLX}
     QClipbrd,
     {$ELSE}
     Clipbrd,
     {$ENDIF}
     TeeConst, SysUtils;

const
  CRLF = #13+#10;

function FormatIntToString(Value: integer; Len: integer): string;
var S : String;
    i,
    j : Integer;
begin
  Result := '';

  if Value < 0 then S := '0'
               else S := IntToStr(Value);

  i := Len - Length(S);

  for j := 0 to i - 1 do
      Result := Result + '0';

  Result := Result + S;
end;

procedure WriteStringToStream(Stream: TStream; const S:AnsiString);
begin
  Stream.Write(S[1],Length(S));
end;

function PDFFontName(AFont: TFont): String;
var tmpSt: String;
begin
  tmpSt := AFont.Name;

  if fsBold in AFont.Style then
     tmpSt := tmpSt+',Bold';
  if fsItalic in AFont.Style then
     tmpSt := tmpSt+',Italic';

  while Pos(' ', tmpSt) > 0  do
        Delete(tmpSt,Pos(' ',tmpSt),1);

  Result := tmpSt;
end;

{ Convert , to . }
procedure FixSeparator(var St: String);
begin
  while Pos(',', St) > 0 do
        St[Pos(',', St)] := '.';
end;

Function PDFColor(AColor:TColor):String;
const tmp=1/255.0;
begin
  AColor:=ColorToRGB(AColor);

  Result:= FormatFloat('0.00',GetRVAlue(AColor)*tmp) + ' ' +
           FormatFloat('0.00',GetGVAlue(AColor)*tmp) + ' ' +
           FormatFloat('0.00',GetBVAlue(AColor)*tmp);

  FixSeparator(Result);
end;

Function TPDFCanvas.InternalBezCurve(const ax1,ay1,ax2,ay2,ax3,ay3: double): String;
begin
  Result := FormatFloat('0.000',ax1)+ ' ' + FormatFloat('0.000',ay1) + ' ' +
            FormatFloat('0.000',ax2)+ ' ' + FormatFloat('0.000',ay2) + ' ' +
            FormatFloat('0.000',ax3)+ ' ' + FormatFloat('0.000',ay3) + ' c'+CRLF;
end;

Procedure TPDFCanvas.ShowImage(DestCanvas,DefaultCanvas:TCanvas; Const UserRect:TRect);
begin
  Pen.OnChange:=nil;
end;

procedure TPDFCanvas.Rectangle(X0,Y0,X1,Y1:Integer);
begin
  InternalRect(TeeRect(X0,Y0,X1,Y1),True,False);
end;

procedure TPDFCanvas.MoveTo(X, Y: Integer);
begin
  FX := X;
  FY := Y;
end;

procedure TPDFCanvas.LineTo(X, Y: Integer);
begin
  tmpSt := PenProperties + ' ' + PointToStr(FX,FY)+' m ' + PointToStr(X,Y)+' l S'+CRLF;
  WriteStringToStream(FCStream,tmpSt);
  FX := X;
  FY := Y;
end;

procedure TPDFCanvas.ClipRectangle(Const Rect:TRect);
var tmpB, tmpT: double;
begin
  Inc(IClipStack);
  WriteStringToStream(FCStream,'q'+CRLF);
  tmpB := Rect.Bottom;
  tmpT := Rect.Top;
  TranslateVertCoord(tmpB);
  TranslateVertCoord(tmpT);
  tmpSt := FormatFloat('0.00',Rect.Left)+' '+ FormatFloat('0.00',tmpB)+ ' ' +
          FormatFloat('0.00',Rect.Right-Rect.Left-1)+' ' + FormatFloat('0.00',tmpT-tmpB-1)+' re W n'+CRLF;
  FixSeparator(tmpSt);
  WriteStringToStream(FCStream,tmpSt);
end;

procedure TPDFCanvas.UnClipRectangle;
begin
  if IClipStack>0 then
  begin
    Dec(IClipStack);
    WriteStringToStream(FCStream,'Q'+CRLF);
  end;
end;

function TPDFCanvas.GetBackColor:TColor;
begin
  result:=FBackColor;
end;

procedure TPDFCanvas.SetBackColor(Color:TColor);
begin
  FBackColor:=Color;
end;

procedure TPDFCanvas.SetBackMode(Mode:TCanvasBackMode);
begin
  FBackMode:=Mode;
end;

Function TPDFCanvas.GetMonochrome:Boolean;
begin
  result:=False;
end;

procedure TPDFCanvas.StretchDraw(const Rect: TRect; Graphic: TGraphic);
begin
  InternalDrawImage( Abs(Rect.Right - Rect.Left),
                     Abs(Rect.Bottom - Rect.Top),
                     Rect.Left,IHeight-Rect.Bottom,SelectImage(Graphic));
end;

procedure TPDFCanvas.Draw(X, Y: Integer; Graphic: TGraphic);
begin
  InternalDrawImage(Graphic.Width,Graphic.Height,X,IHeight-Y-Graphic.Height,
                    SelectImage(Graphic));
end;

Function TPDFCanvas.TheBounds:String;
begin
  IWidth := Bounds.Right - Bounds.Left;
  IHeight := Bounds.Bottom - Bounds.Top;
end;

Function TPDFCanvas.PointToStr(X,Y:double):String;
begin
  TranslateVertCoord(Y);
  tmpSt := FormatFloat('0.000',X)+' '+FormatFloat('0.000',Y);
  FixSeparator(tmpSt);
  Result := tmpSt;
end;

Procedure TPDFCanvas.GradientFill( Const Rect:TRect;
                                   StartColor,EndColor:TColor;
                                   Direction:TGradientDirection;
                                   Balance:Integer=50;
                                   RadialX:Integer=0;
                                   RadialY:Integer=0);
begin
  { Not implemented }
end;

procedure TPDFCanvas.FillRect(const Rect: TRect);
begin
  InternalRect(Rect,False,False);
end;

Procedure TPDFCanvas.InternalRect(Const Rect:TRect; UsePen, IsRound:Boolean);
var tmpB,tmpT: double;
begin
  if (Brush.Style<>bsClear) or (UsePen and (Pen.Style<>psClear)) then
  begin
    tmpSt := PenProperties + ' ' + BrushProperties+ ' ';
    tmpB := Rect.Bottom;
    tmpT := Rect.Top;
    TranslateVertCoord(tmpB);
    TranslateVertCoord(tmpT);
    tmpSt := tmpSt+FormatFloat('0.000',Rect.Left)+' '+ FormatFloat('0.000',tmpB)+ ' ' +
            FormatFloat('0.000',Rect.Right-Rect.Left-Pen.Width)+' ' + FormatFloat('0.000',tmpT-tmpB-Pen.Width)+' re';
    FixSeparator(tmpSt);
    WriteStringToStream(FCStream,tmpSt);

    if (Brush.Style<>bsClear) then
    begin
      if (Pen.Style<>psClear) then WriteStringToStream(FCStream,' B'+CRLF)
      else WriteStringToStream(FCStream,' f'+CRLF);
    end else WriteStringToStream(FCStream,' S'+CRLF);
  end;
end;

procedure TPDFCanvas.Ellipse(X1, Y1, X2, Y2: Integer);
begin
  EllipseWithZ(X1,Y1,X2,Y2,0);
end;

procedure TPDFCanvas.EllipseWithZ(X1, Y1, X2, Y2, Z: Integer);
var ra,rb,xc,yc: double;
const Bez = 0.552;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    WriteStringToStream(FCStream,PenProperties + ' ' + BrushProperties+ ' ');

    Calc3DPos(X1,Y1,Z);
    Calc3DPos(X2,Y2,Z);

    ra := (X2 - X1)*0.5;
    rb := (Y2 - Y1)*0.5;
    xc := (X2 + X1)*0.5;
    yc := (Y2 + Y1)*0.5;

    TranslateVertCoord(yc);
    tmpSt := FormatFloat('0.000',xc+ra)+ ' ' + FormatFloat('0.000',yc)+ ' m ';

    { 4-arc version of drawing circle/ellipse }
    { Q1, Q2, Q3 and Q4 cp}
    tmpSt := tmpSt + InternalBezCurve(xc+ra, yc+Bez*rb, xc+Bez*ra, yc+rb, xc, yc+rb);
    tmpSt := tmpSt + InternalBezCurve(xc-Bez*ra, yc+rb, xc-ra, yc+Bez*rb, xc-ra, yc);
    tmpSt := tmpSt + InternalBezCurve(xc-ra, yc-Bez*rb, xc-Bez*ra, yc-rb, xc, yc-rb);
    tmpSt := tmpSt + InternalBezCurve(xc+Bez*ra, yc-rb, xc+ra, yc-Bez*rb, xc+ra, yc);

    FixSeparator(tmpSt);

    WriteStringToStream(FCStream,tmpSt);

    if Brush.Style<>bsClear then
    begin
      if Pen.Style<>psClear then
         WriteStringToStream(FCStream,' B'+CRLF)
      else
         WriteStringToStream(FCStream,' f'+CRLF);

    end
    else WriteStringToStream(FCStream,' S'+CRLF);
  end;
end;

procedure TPDFCanvas.SetPixel3D(X,Y,Z:Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Calc3DPos(x,y,z);
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TPDFCanvas.SetPixel(X, Y: Integer; Value: TColor);
begin
  if Pen.Style<>psClear then
  begin
    Pen.Color:=Value;
    MoveTo(x,y);
    LineTo(x,y);
  end;
end;

procedure TPDFCanvas.Arc(const Left, Top, Right, Bottom, StartX, StartY, EndX, EndY: Integer);
begin
  InternalDrawArc(Left,Top,Right,Bottom,StartX,StartY,EndX,EndY,True,False);
end;

procedure TPDFCanvas.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);
begin
  InternalDrawArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4, False, True);
end;

procedure TPDFCanvas.RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);
begin
  InternalRect(TeeRect(X1,Y1,X2,Y2),True,True);
end;

Procedure TPDFCanvas.TextOut3D(X,Y,Z:Integer; const Text:String);
begin
  RotateLabel3D(X,Y,Z,Text,0);
end;

Procedure TPDFCanvas.TextOut(X,Y:Integer; const Text:String);
begin
  TextOut3D(X,Y,0,Text);
end;

procedure TPDFCanvas.RotateLabel3D(x,y,z:Integer; Const St:String; RotDegree:Double);
begin
  if Z<>0 then
     Calc3DPos(X,Y,Z); // 7.05

  RotateLabel(X,Y,St,RotDegree);
end;

procedure TPDFCanvas.RotateLabel(x,y:Integer; Const St:String; RotDegree:Double);

  procedure DoText(AX, AY, RotRad: double);
  var tw,th: double;
      vcos, vsin : double;
      xc,yc: double;
      FontIndex: Integer;
  begin
    WriteStringToStream(FCStream,PDFColor(Font.Color)+' rg ');
    WriteStringToStream(FCStream,'BT ');

    if Assigned(IFont) then
       WriteStringToStream(FCStream,FontProperties(IFont,FontIndex)+' ')
    else
       WriteStringToStream(FCStream,FontProperties(TTeeFont(Font),FontIndex)+' ');

    { Get text width and height }
    th := TextHeight(St);

    if (TextAlign and TA_CENTER)=TA_CENTER then
       tw := TextWidth(St)*0.5
    else
    if (TextAlign and TA_RIGHT)=TA_RIGHT then
       tw := TextWidth(St)
    else
       tw := 0 ;

    {$IFNDEF LINUX}
    { FIX :
      the system uses 72 Pixelsperinch as a base line figure, most systems are
      96 DPI or if your in large Font Mode then 120 DPI
      So when using the TextWidth/TextHeight of the currently selected font, you get the wrong answer
    }
    tw := tw*72/FContents.FontArray.Items[FontIndex].FontData.DigAspX;
    th := th*72/FContents.FontArray.Items[FontIndex].FontData.DigAspY;
    {$ENDIF}

    TranslateVertCoord(AY);
    { rotation elements }
    vcos := Cos(RotRad);
    vsin := Sin(RotRad);

    { rotated values }
    xc := AX - (tw*vcos-th*vsin);
    yc := AY - (tw*vsin+th*vcos);
    tmpSt := FormatFloat('0.000',vcos)+ ' ' + FormatFloat('0.000',vsin)+ ' '+
                    FormatFloat('0.000',-vsin)+ ' ' + FormatFloat('0.000',vcos)+ ' '+
                    FormatFloat('0.000',xc)+ ' ' + FormatFloat('0.000',yc)+ ' Tm ';

    FixSeparator(tmpSt);
    WriteStringToStream(FCStream,tmpSt);
    WriteStringToStream(FCStream,'<'+TextToPDFText(St)+'> Tj ');
    WriteStringToStream(FCStream,'ET'+CRLF);
  end;

var tmpX : Integer;
    tmpY : Integer;
begin
  if (TextAlign and TA_BOTTOM)=TA_BOTTOM then // 7.05 (TV52010657)
     Dec(y,Round(Font.Size*Screen.PixelsPerInch/72.0));

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

    DoText(tmpX,tmpY, RotDegree*0.01745329);
  end;

  DoText(X,Y, RotDegree*0.01745329);
end;

Function TPDFCanvas.GetBackMode:TCanvasBackMode;
begin
  result:=FBackMode;
end;

Procedure TPDFCanvas.Polygon(const Points: Array of TPoint);
var t : Integer;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    if Pen.Style<>psClear then
       WriteStringToStream(FCStream,PenProperties+' ');

    WriteStringToStream(FCStream,PointToStr(Points[0].X,Points[0].Y)+' m'+CRLF);

    for t:=1 to High(Points) do
        WriteStringToStream(FCStream,PointToStr(Points[t].X,Points[t].Y)+' l'+CRLF);

    WriteStringToStream(FCStream,'h ');

    if Brush.Style<>bsClear then
    begin
      WriteStringToStream(FCStream,BrushProperties);

      if Pen.Style<>psClear then
         WriteStringToStream(FCStream,' B'+CRLF)
      else
         WriteStringToStream(FCStream,' f'+CRLF);
    end
    else WriteStringToStream(FCStream,' S'+CRLF);
  end;
end;

function TPDFCanvas.InitWindow(DestCanvas: TCanvas;
  A3DOptions: TView3DOptions; ABackColor: TColor; Is3D: Boolean;
  const UserRect: TRect): TRect;
begin
  result:=inherited InitWindow(DestCanvas,A3DOptions,ABackColor,Is3D,UserRect);

  IClipStack := 0;
  Pen.OnChange:=ChangedPen;
  TheBounds;
end;

function TPDFCanvas.SelectFont(Font: TFont): Integer;
begin
  Result := FContents.FontArray.Find(Font);

  if Result = -1 then
     Result := FContents.FontArray.AddItem(Font,Handle);
end;

procedure TPDFCanvas.InternalDrawArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer; MoveTo0: boolean; DrawPie: boolean);
var fccwc: double;

    procedure Rotate(var ax,ay: double; Angle: double);
    var tx,ty: double;
        vcos, vsin: double;
    begin
      vcos := Cos(Angle);
      vsin := Sin(Angle);
      tx := ax;
      ty := ay;
      ax := vcos*tx - vsin*ty;
      ay := vsin*tx + vcos*ty;
    end;

    procedure ArcSegment(ax, ay, ra, rb, midtheta, hangle: double; amt0: Integer);
    var ax1,ay1,ax2,ay2,ax3,ay3: double;
        ax0,ay0: double;
        hTheta: double;
        vcos, vsin: double;
    begin
      if ra < rb then
         SwapDouble(ra,rb);

      htheta := Abs(hangle);
      vcos := Cos(htheta);
      vsin := Sin(htheta);
      ax0 := ra*vcos;
      ay0 := -fccwc*ra*vsin;
      Rotate(ax0,ay0,midtheta);

      if amt0 = 1 then
         tmpSt := FormatFloat('0.000',ax+ax0)+ ' ' + FormatFloat('0.000',ay+ay0) + ' m'+CRLF
      else
      if amt0 = 0 then
         tmpSt := FormatFloat('0.000',ax+ax0)+ ' ' + FormatFloat('0.000',ay+ay0) + ' l'+CRLF
      else
         tmpSt := '';

      ax1 := ra*(4.0 - vcos)/3.0;
      ax2 := ax1;
      ay1 := ra*fccwc *(1.0 - vcos) * (vcos - 3.0) / (3.0*vsin);
      ay2 := -ay1;
      ax3 := ra*vcos;
      ay3 := fccwc*ra*vsin;

      Rotate(ax1, ay1, midtheta);
      Rotate(ax2, ay2, midtheta);
      Rotate(ax3, ay3, midtheta);

      tmpSt := tmpSt+InternalBezCurve(ax+ax1,ay+ay1,ax+ax2,ay+ay2,ax+ax3,ay+ay3);

      FixSeparator(tmpSt);
      WriteStringToStream(FCStream,tmpSt);
  end;

var SegCount,i: Integer;
    CurrAngle, Span : double;
    AngleBump, hBump: double;
    x,y,a,b,
    StartAngle,EndAngle: double;
    rat,tr: double;
begin
  if (Brush.Style<>bsClear) or (Pen.Style<>psClear) then
  begin
    WriteStringToStream(FCStream,PenProperties);

    if (Brush.Style<>bsClear) and (DrawPie) then
       WriteStringToStream(FCStream,' '+ BrushProperties+CRLF)
    else
       WriteStringToStream(FCStream,' ');

    { center pos + radius }
    x := (X1 + X2)*0.5;
    y := (Y1 + Y2)*0.5;
    a := (X2 - X1)*0.5;
    b := (Y2 - Y1)*0.5;

    { this is only approx. algorithm }
    if a <> b then
    begin
      WriteStringToStream(FCStream,'q'+CRLF);

      if a>b then
      begin
        rat := b/a;
        tr := y*(1.0-rat);
        tmpSt := '1 0 0 ' + FormatFloat('0.000',rat) + ' 0 '+ FormatFloat('0.000',tr);
      end
      else
      begin
        rat := a/b;
        tr := x*(1.0-rat);
        tmpSt := FormatFloat('0.000',rat)+ ' 0 0 1 '+ FormatFloat('0.000',tr) +  ' 0';
      end;

      FixSeparator(tmpSt);
      tmpSt := tmpSt + ' cm'+CRLF;
      WriteStringToStream(FCStream,tmpSt);
    end;

    { StartAngle }
    CurrAngle := Math.ArcTan2(Y-Y3, X3 - X);
    if CurrAngle<0 then
       CurrAngle:=2.0*Pi+CurrAngle;

    StartAngle := CurrAngle;

    { EndAngle }
    Currangle := Math.ArcTan2(Y-Y4, X4 - X);

    if CurrAngle<=0 then
       CurrAngle:=2.0*Pi+CurrAngle;

    EndAngle := CurrAngle;

    If DrawPie then
       WriteStringToStream(FCStream,PointToStr(x,y)+' m'+CRLF);

    TranslateVertCoord(y);
    fccwc := 1.0;
    SegCount := 1;
    Span := EndAngle - StartAngle;

    if EndAngle < StartAngle then
       fccwc := -1.0;

    while Abs(Span)/SegCount > Pi*0.5 do
          Inc(SegCount);

    AngleBump := Span/SegCount;
    hBump := 0.5*AngleBump;
    CurrAngle := StartAngle + hBump;

    for i := 0 to SegCount -1 do
    begin
      if i = 0 then
         ArcSegment(x,y,a,b,CurrAngle,hBump,Integer(MoveTo0))
      else
         ArcSegment(x,y,a,b,CurrAngle,hBump,-1);

      CurrAngle := CurrAngle + AngleBump;
    end;

    if (Brush.Style<>bsClear) and DrawPie then
       if Pen.Style<>psClear then
          WriteStringToStream(FCStream,' h B'+CRLF)
       else
          WriteStringToStream(FCStream,' h f'+CRLF)
    else
    if DrawPie then
       WriteStringToStream(FCStream,' s'+CRLF)
    else
    if Not DrawPie then
       WriteStringToStream(FCStream,' S'+CRLF);

    if a<>b then
       WriteStringToStream(FCStream,'Q'+CRLF);
  end;
end;

{ Transform individual chars to double byte hex codes}
function TPDFCanvas.TextToPDFText(const AText: String): String;
var i : Integer;
begin
  Result := '';
  for i := 1 to Length(AText) do
    Result := Result + IntToHex(Ord(AText[i]), 2);
end;

function TPDFCanvas.TextHeight(const St: String): Integer;
begin
  Result := inherited TextHeight(St);
end;

function TPDFCanvas.TextWidth(const St: String): Integer;
begin
  Result := inherited TextWidth(St);
end;

procedure TPDFCanvas.InternalDrawImage(const sx, sy, tx,ty: double;
  ImageIndex: Integer);
begin
  WriteStringToStream(FCStream,'q ');

  tmpSt := FormatFloat('0.000',sx) + ' 0 0 ' +
           FormatFloat('0.000',sy) + ' ' +
           FormatFloat('0.000',tx) + ' ' +
           FormatFloat('0.000',ty);

  FixSeparator(tmpSt);

  tmpSt := tmpSt + ' cm /Im'+ IntToStr(ImageIndex)+' Do Q';
  WriteStringToStream(FCStream, tmpSt+CRLF);
end;

procedure TPDFCanvas.SetEmbeddedFonts(const Value: boolean);
begin
  FEmbeddedFonts := Value;
end;

procedure TPDFCanvas.WriteToStream(AStream: TStream);
begin
end;

Function TPDFCanvas.BeginBlending(const R:TRect; Transparency:TTeeTransparency):TTeeBlend;
begin
  result:=nil;
end;

procedure TPDFCanvas.EndBlending(Blend:TTeeBlend);
begin
//
end;

Constructor TPDFCanvas.Create(AChartObject: TPDFChartObject);
begin
  inherited Create;
  UseBuffer := False;
  FContents := AChartObject;
  FCStream := FContents.Contents;
end;

{ TPDFExportFormat }
function TPDFExportFormat.Description: String;
begin
  result:=TeeMsg_AsPDF;
end;

function TPDFExportFormat.FileExtension: String;
begin
  result:='pdf';
end;

function TPDFExportFormat.FileFilter: String;
begin
  result:=TeeMsg_PDFFilter;
end;

procedure TPDFExportFormat.DoCopyToClipboard;
(*var
  buf: PChar;
  buflen : Integer;
  *)
begin
  (*With PDFPage do
  try
    bufLen := Size;
    Position := 0;
    buf := AllocMem(buflen+1);
    try
      Read(buf^,buflen+1);
      ClipBoard.AsText:=buf; // SetTextBuf(buf);
    finally
      FreeMem(buf);
    end;
  finally
    Free;
  end;
  *)
end;

function TPDFExportFormat.Options(Check:Boolean): TForm;
begin
  result:=nil;
end;

procedure TPDFExportFormat.SaveToStream(Stream: TStream);
begin
  with PDFPage do
  try
    SaveToStream(Stream);
  finally
    Free;
  end;
end;

{$IFNDEF CLR}
type
  TTeePanelAccess=class(TCustomTeePanel);
{$ENDIF}

function TPDFExportFormat.PDFPage: TTeePDFPage;
var tmp : TCanvas3D;
begin { return a panel or chart in PDF format into a StringList }
  CheckSize;
  Result := TTeePDFPage.Create;
  Panel.AutoRepaint := False;
  try
    tmp := Panel.Canvas;
    {$IFNDEF CLR}  // Protected across assemblies
    TTeePanelAccess(Panel).InternalCanvas:=nil;
    {$ENDIF}

    Result.PageWidth := Width;
    Result.PageHeight := Height;
    Panel.Canvas := TPDFCanvas.Create(Result.ChartObject);

    if not Assigned(Panel.Parent) then
      Panel.BufferedDisplay:=True;  // 7.01

    try
      Panel.Draw(Panel.Canvas.ReferenceCanvas,TeeRect(0,0,Width,Height));
    finally
      Panel.Canvas:=tmp;
    end;
  finally
    Panel.AutoRepaint:=True;
  end;
end;

procedure TeeSaveToPDFFile( APanel:TCustomTeePanel; const FileName: WideString;
                            AWidth:Integer=0;
                            AHeight: Integer=0);
begin { save panel or chart to filename in VML (html) format }
  with TPDFExportFormat.Create do
  try
    Panel:=APanel;
    Height:=AHeight;
    Width:=AWidth;
    SaveToFile(FileName);
  finally
    Free;
  end;
end;

procedure TPDFCanvas.TranslateVertCoord(var Y: double);
begin
  { vertical coordinate is reversed in PDF !! }
  Y := IHeight - Y;
end;

function TPDFCanvas.SetPenStyle(PenStyle: TPenStyle): String;
begin
  case PenStyle of
    psSolid   : Result := '[ ] 0 d';
    psDash    : Result := '[3 3] 0 d';
    psDot     : Result := '[2] 1 d';
    psDashDot : Result := '[3 2] 2 d';
  else
                Result := '[ ] 0 d';
  end;
end;

function TPDFCanvas.PenProperties: String;
begin
  Result := PDFColor(Pen.Color)+ ' RG ' +
            IntToStr(IPenWidth)+' w ' +
            SetPenStyle(IPenStyle)+ ' ';
  // v8.01
  if (Pen is TChartPen) then
    with (Pen as TChartPen) do
    begin
      case EndStyle of
        esRound: Result := Result +' 1 J ';
        esSquare: Result := Result +' 2 J ';
        else Result := Result + ' 0 J ';
      end;
    end;
end;

function TPDFCanvas.BrushProperties: String;
begin
  Result := PDFColor(Brush.Color)+' rg';
end;

Destructor TPDFCanvas.Destroy;
begin
  inherited Destroy;
end;

function TPDFCanvas.FontProperties(Font: TTeeFont; var FontIndex: Integer): String;
begin
  FontIndex := SelectFont(Font);
  Result := '/F'+ IntToStr(FontIndex) + ' ' +
            IntToStr(Font.Size)+ ' Tf '+
            IntToStr(Font.InterCharSize) + ' Tc ';
end;

{ TFontListEntry }
Constructor TTeePDFFontListEntry.Create(AFont: TFont);
begin
  inherited Create;
  FPDFName := PDFFontName(AFont);
  DefineFontData(AFont);
end;

procedure TTeePDFFontListEntry.DefineFontData(AFont: TFont);
var FontInfo: {$IFDEF CLR}Array[0..0] of {$ELSE}^{$ENDIF}TOutlineTextMetric;
    fnt: HFont;
    m_hdcFont: HDC;
begin
  {$IFNDEF CLR}
  New(FontInfo);
  {$ENDIF}
  try
    fnt := CreateFont(-1000, 0, 0, 0, FW_DONTCARE, 0, 0, 0,
                      {$IFDEF CLX}
                      1
                      {$ELSE}
                      DEFAULT_CHARSET
                      {$ENDIF},
                      OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                      DEFAULT_QUALITY, DEFAULT_PITCH or FF_DONTCARE,
                      {$IFNDEF CLR}PChar{$ENDIF}(AFont.Name));
    m_hdcFont := GetDC(0);

    SelectObject(m_hdcFont, fnt);
    DeleteObject( fnt );

    GetOutlineTextMetrics(m_hdcFont,SizeOf(TOutlineTextMetric),FontInfo);

    With FFontData do
    begin
      DigAspX := FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmTextMetrics.tmDigitizedAspectX;
      DigAspY := FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmTextMetrics.tmDigitizedAspectY;
      FontBBox := FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmrcFontBox;
      FirstChar := Ord(FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmTextMetrics.tmFirstChar);
      {$IFDEF D12}
      LastChar := 255;  //fix 255 to avoid upper 65532 limit on widestring font
      {$ELSE}
      LastChar := Ord(FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmTextMetrics.tmLastChar);
      {$ENDIF}
      CapHeight := FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmsCapEmHeight;
      Ascent := FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmTextMetrics.tmAscent;
      Descent := -FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmTextMetrics.tmDescent;
      MaxWidth := FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmTextMetrics.tmMaxCharWidth;
      AvgWidth := FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmTextMetrics.tmAveCharWidth;
      ItalicAngle := FontInfo{$IFDEF CLR}[0]{$ENDIF}.otmItalicAngle;

      GetCharWidth(m_hdcFont,0,255,CharWidths);
    end;
  finally
    {$IFNDEF CLR}
    Dispose(FontInfo);
    {$ENDIF}
  end;
end;

{ TFontList }

function TTeePDFFontList.AddItem(AFont: TFont; AHandle: TTeeCanvasHandle): Integer;
begin
  Result := IFontList.Add(TTeePDFFontListEntry.Create(AFont));
end;

constructor TTeePDFFontList.Create;
begin
  inherited;
  IFontList := TList.Create;
end;

destructor TTeePDFFontList.Destroy;
var i: Integer;
begin
  for i := 0 to IFontList.Count - 1 do
      TTeePDFFontListEntry(IFontList.Items[i]).Free;

  IFontList.Free;

  inherited Destroy;
end;

function TTeePDFFontList.Find(AFont: TFont): Integer;
var i: Integer;
    tmpName: String;
begin
  Result := -1;

  tmpName := PDFFontName(AFont);

  for i := 0 to IFontList.Count - 1 do
    if tmpName = TTeePDFFontListEntry(IFontList.Items[i]).PDFName then
    begin
      Result := i;
      Break;
    end;
end;

function TTeePDFFontList.GetCount: Integer;
begin
  Result := IFontList.Count;
end;

function TTeePDFFontList.GetFontEntry(Index: Integer): TTeePDFFontListEntry;
begin
  Result := TTeePDFFontListEntry(IFontList.Items[Index]);
end;

function TPDFExportFormat.ChartObject: TPDFChartObject;
var tmp : TCanvas3D;
begin { return a panel or chart in PDF format into a StringList }
  CheckSize;

  Result := TPDFChartObject.Create;
  Panel.AutoRepaint := False;
  try
    tmp := {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(Panel).InternalCanvas;
    {$IFNDEF CLR}TTeePanelAccess{$ENDIF}(Panel).InternalCanvas := nil;

    Panel.Canvas := TPDFCanvas.Create(Result);

    if not Assigned(Panel.Parent) then
       Panel.BufferedDisplay:=True;  // 7.01

    try
      Panel.Draw(Panel.Canvas.ReferenceCanvas,TeeRect(0,0,Width,Height));
    finally
      Panel.Canvas:=tmp;
    end;
  finally
    Panel.AutoRepaint:=True;
  end;
end;

{ TPDFChartObject }

constructor TPDFChartObject.Create;
begin
  inherited Create;
  FFontArray := TTeePDFFontList.Create;
  FImageArray := TTeePDFImageList.Create;
  FContents := TMemoryStream.Create;
end;

destructor TPDFChartObject.Destroy;
begin
  FFontArray.Free;
  FImageArray.Free;
  FContents.Free;
  inherited;
end;

function TPDFChartObject.GetLength: Integer;
begin
  Result := FContents.Size;
end;

procedure TPDFChartObject.SaveToStream(AStream: TStream);
begin
  WriteStringToStream(AStream,'<< /Length '+IntToStr(GetLength)+ ' >>'+CRLF);
  WriteStringToStream(AStream,'stream'+CRLF);
  AStream.CopyFrom(FContents,0);
  WriteStringToStream(AStream,'endstream'+CRLF);
end;

{ TTeePDFPage }

procedure TTeePDFPage.AddToOffset(Offset: Integer);
begin
  OffsetList.Add(FormatIntToString(OffSet, 10));
end;

constructor TTeePDFPage.Create;
begin
  inherited Create;
  IObjCount := 0;
  FChartObject := TPDFChartObject.Create;
  OffsetList := TStringList.Create;
end;

destructor TTeePDFPage.Destroy;
begin
  FChartObject.Free;
  OffsetList.Free;  // 7.07
  inherited;
end;

procedure TTeePDFPage.SaveToStream(AStream: TStream);
begin
  WriteHeader(AStream);
  WriteInfo(AStream);

  // write chart canvas code
  Inc(IObjCount);
  AddToOffset(AStream.Size);
  WriteStringToStream(AStream,IntToStr(IObjCount)+ ' 0 obj'+CRLF);
  FChartObject.SaveToStream(AStream);
  WriteStringToStream(AStream,'endobj'+CRLF);

  // TT fonts
  WriteTTFonts(AStream);

  // Additional images, if they exist
  WriteImages(AStream);

  // Resources
  WriteResources(AStream);

  // Pages and page
  WritePages(AStream);
  WritePage(AStream);

  WriteCatalog(AStream);
  WriteXRef(AStream);
  WriteStringToStream(AStream,'%%EOF'+CRLF);
end;

procedure TTeePDFPage.SetPageHeight(const Value: Integer);
begin
  FPageHeight := Value;
end;

procedure TTeePDFPage.SetPageWidth(const Value: Integer);
begin
  FPageWidth := Value;
end;

procedure TTeePDFPage.WriteCatalog(AStream: TStream);
begin
  Inc(IObjCount);
  CatalogNum := IObjCount;
  AddToOffset(AStream.Size);
  WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);
  WriteStringToStream(AStream,'<< /Type /Catalog' + CRLF);
  WriteStringToStream(AStream,'/Pages ' + IntToStr(ParentNum) + ' 0 R'+ CRLF);
  WriteStringToStream(AStream,'>>'+CRLF);
  WriteStringToStream(AStream,'endobj'+CRLF);
end;

procedure TTeePDFPage.WriteHeader(AStream: TStream);
begin
  WriteStringToStream(AStream,'%PDF-1.4'+CRLF);
end;

procedure TTeePDFPage.WriteImages(AStream: TStream);
var i: Integer;
begin
  with FChartObject.ImageArray do
  begin
    for i := 0 to ItemsCount -1 do
    begin
      Inc(IObjCount);
      AddToOffset(AStream.Size);

      Items[i].ObjectNumber := IObjCount;

      WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);
      WriteStringToStream(AStream,'<< /Type /XObject'+CRLF);
      WriteStringToStream(AStream,'/Subtype /Image'+CRLF);
      WriteStringToStream(AStream,'/Name /Im'+IntToStr(i)+CRLF);
      WriteStringToStream(AStream,'/Length '+IntToStr(Items[i].DataLength)+CRLF);
      WriteStringToStream(AStream,'/Width '+IntToStr(Items[i].Width)+CRLF);
      WriteStringToStream(AStream,'/Height '+IntToStr(Items[i].Height)+CRLF);
      WriteStringToStream(AStream,'/ColorSpace /DeviceRGB'+CRLF);
      WriteStringToStream(AStream,'/BitsPerComponent 8'+CRLF);

      if Items[i].ImageType = itJPEG then
         WriteStringToStream(AStream,'/Filter [/DCTDecode]'+CRLF);

      WriteStringToStream(AStream,'>>'+CRLF);
      WriteStringToStream(AStream,'stream'+CRLF);

      Items[i].WriteDataToStream(AStream);

      WriteStringToStream(AStream,'endstream'+CRLF);
      WriteStringToStream(AStream,'endobj'+CRLF);
    end;
  end;
end;

procedure TTeePDFPage.WriteInfo(AStream: TStream);
begin
  Inc(IObjCount);
  AddToOffset(AStream.Size);
  WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);

  tmpSt := '<<'+CRLF+'/Creator (' + TeeMsg_Version +')'+CRLF+'/Producer (' + TeeMsg_Version+')'+CRLF+
    '/CreationDate (D:'+FormatDateTime('YYYYMMDDHHmmSS',Now)+')'+CRLF+'/ModDate ()' + CRLF +
    '/Keywords ()'+CRLF+'/Title (TChart Export)' + CRLF+'>>'+CRLF;

  WriteStringToStream(AStream, tmpSt);
  WriteStringToStream(AStream,'endobj'+CRLF);
end;

procedure TTeePDFPage.WritePage(AStream: TStream);
begin
  Inc(IObjCount);

  AddToOffset(AStream.Size);

  WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);
  WriteStringToStream(AStream,'<< /Type /Page' + CRLF + '/Parent '+IntToStr(ParentNum)+ ' 0 R'+CRLF);
  WriteStringToStream(AStream,'/MediaBox [ 0 0 ' + IntToStr(FPageWidth) + ' ' + IntToStr(FPageHeight) + ' ]'+CRLF);
  WriteStringToStream(AStream,'/Contents 2 0 R'+CRLF);
  WriteStringToStream(AStream,'/Resources ' + IntToStr(ResourceNum)+' 0 R'+CRLF);
  WriteStringToStream(AStream,'>>'+CRLF);
  WriteStringToStream(AStream,'endobj'+CRLF);
end;

procedure TTeePDFPage.WritePages(AStream: TStream);
begin
  Inc(IObjCount);
  AddToOffset(AStream.Size);

  ParentNum := IObjCount;
  WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);

  // Must be followed by WritePage call, otherwise object reference will not be correct
  tmpSt := '<< /Type /Pages' + CRLF + '/Kids [' + IntToStr(IObjCount+1)+' 0 R]'+CRLF+
    '/Count 1'+CRLF+'>>'+CRLF;

  WriteStringToStream(AStream,tmpSt);
  WriteStringToStream(AStream,'endobj'+CRLF);
end;

procedure TTeePDFPage.WriteResources(AStream: TStream);
var i: Integer;
begin
  Inc(IObjCount);

  ResourceNum := IObjCount;
  AddToOffset(AStream.Size);

  WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);
  WriteStringToStream(AStream,'<< /ProcSet [/PDF /Text /ImageC]'+CRLF);

  With FChartObject do
  begin
    WriteStringToStream(AStream,'/Font << '+CRLF);

    for i := 0 to FontArray.ItemsCount -1 do
      WriteStringToStream(AStream,'/F'+IntToStr(i) + ' ' + IntToStr(FontArray.Items[i].ObjectNumber)+' 0 R'+CRLF);

    WriteStringToStream(AStream,'>>'+CRLF);
    WriteStringToStream(AStream,'/XObject << '+CRLF);

    for i := 0 to ImageArray.ItemsCount -1 do
      WriteStringToStream(AStream,'/Im'+IntToStr(i) + ' ' + IntToStr(ImageArray.Items[i].ObjectNumber)+' 0 R'+CRLF);

    WriteStringToStream(AStream,'>>'+CRLF);
  end;

  WriteStringToStream(AStream,'>>'+CRLF);
  WriteStringToStream(AStream,'endobj'+CRLF);
end;

procedure TTeePDFFontListEntry.SetObjectNumber(const Value: Integer);
begin
  FObjectNumber := Value;
end;

procedure TTeePDFPage.WriteTrailer(AStream: TStream);
begin
  WriteStringToStream(AStream,'trailer'+CRLF);
  WriteStringToStream(AStream,'<< /Size '+ IntToStr(IObjCount)+CRLF);
  WriteStringToStream(AStream,'/Root '+ IntToStr(CatalogNum)+ ' 0 R'+CRLF);
  WriteStringToStream(AStream,'/Info 1 0 R'+CRLF);
  WriteStringToStream(AStream,'>>'+CRLF);
  WriteStringToStream(AStream,'startxref'+CRLF);
  WriteStringToStream(AStream,IntToStr(XRefPos)+CRLF);
end;

procedure TTeePDFPage.WriteTTFonts(AStream: TStream);
var i,j: Integer;
begin
  With FChartObject.FontArray do
  begin
    for i := 0 to ItemsCount -1 do
    begin
      // font header
      Inc(IObjCount);
      AddToOffset(AStream.Size);

      Items[i].ObjectNumber := IObjCount;

      WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);
      WriteStringToStream(AStream,'<< /Type /Font'+CRLF);
      WriteStringToStream(AStream,'/Subtype /TrueType'+CRLF);
      WriteStringToStream(AStream,'/BaseFont /'+ Items[i].PDFName+CRLF);
      WriteStringToStream(AStream,'/Name /F'+IntToStr(i)+CRLF);
      WriteStringToStream(AStream,'/FirstChar '+ IntToStr(Items[i].FontData.FirstChar)+CRLF);
      WriteStringToStream(AStream,'/LastChar '+ IntToStr(Items[i].FontData.LastChar)+CRLF);
      WriteStringToStream(AStream,'/Encoding /WinAnsiEncoding'+CRLF);
      WriteStringToStream(AStream,'/FontDescriptor '+ IntToStr(IObjCount+1)+ ' 0 R'+CRLF);
      WriteStringToStream(AStream,'/Widths '+ IntToStr(IObjCount+2)+' 0 R'+CRLF);
      WriteStringToStream(AStream,'>>'+CRLF);
      WriteStringToStream(AStream,'endobj'+CRLF);

      // Font descriptor
      Inc(IObjCount);
      AddToOffset(AStream.Size);

      WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);
      WriteStringToStream(AStream,'<< /Type /FontDescriptor'+CRLF);
      WriteStringToStream(AStream,'/FontName /'+ Items[i].PDFName+CRLF);
      WriteStringToStream(AStream,'/Flags 32'+CRLF);

      With Items[i].FontData do
      begin
        WriteStringToStream(AStream,'/FontBBox ['+
          IntToStr(FontBBox.Left)+ ' ' +
          IntToStr(FontBBox.Bottom)+ ' ' +
          IntToStr(FontBBox.Right)+ ' ' +
          IntToStr(FontBBox.Top)+ ']' + CRLF);

        WriteStringToStream(AStream,'/CapHeight ' + IntToStr(CapHeight)+CRLF);
        WriteStringToStream(AStream,'/Ascent ' + IntToStr(Ascent)+CRLF);
        WriteStringToStream(AStream,'/Descent ' + IntToStr(Descent)+CRLF);
        WriteStringToStream(AStream,'/MaxWidth ' + IntToStr(MaxWidth)+CRLF);
        WriteStringToStream(AStream,'/AvgWidth ' + IntToStr(AvgWidth)+CRLF);
        WriteStringToStream(AStream,'/ItalicAngle ' + IntToStr(ItalicAngle)+CRLF);
        WriteStringToStream(AStream,'/StemV 0'+CRLF);
      end;

      WriteStringToStream(AStream,'>>'+CRLF);
      WriteStringToStream(AStream,'endobj'+CRLF);

      // Font widths
      Inc(IObjCount);
      AddToOffset(AStream.Size);

      WriteStringToStream(AStream,IntToStr(IObjCount)+' 0 obj'+CRLF);
      WriteStringToStream(AStream,'['+CRLF);

      tmpSt := '';

      for j := Items[i].FontData.FirstChar to Items[i].FontData.LastChar do
        if j mod 15 = 14 then
           tmpSt := tmpSt + IntToStr(Items[i].FontData.CharWidths[j]) + ' '+CRLF
        else
           tmpSt := tmpSt + IntToStr(Items[i].FontData.CharWidths[j]) + ' ';

      WriteStringToStream(AStream,tmpSt+CRLF);
      WriteStringToStream(AStream,']'+CRLF);
      WriteStringToStream(AStream,'endobj'+CRLF);
    end;
  end;
end;

procedure TTeePDFPage.WriteXRef(AStream: TStream);
var i: Integer;
begin
  Inc(IObjCount);
  // no need to add xref to xref itself.

  XRefPos := AStream.Size;

  WriteStringToStream(AStream,'xref'+CRLF);
  WriteStringToStream(AStream,'0 '+IntToStr(IObjCount)+CRLF);
  WriteStringToStream(AStream,'0000000000 65535 f'+CRLF);

  for i := 0 to OffSetList.Count - 1  do
    WriteStringToStream(AStream,OffsetList.Strings[i]+' ' + FormatIntToString(0,5)+' n'+ CRLF);

  WriteTrailer(AStream);
end;

{ TTeePDFImageList }

function TTeePDFImageList.AddItem(AGraphic: TGraphic): Integer;
begin
  Result := IImageList.Add(TTeePDFImageListEntry.Create(AGraphic));
end;

constructor TTeePDFImageList.Create;
begin
  inherited;
  IImageList := TList.Create;
end;

destructor TTeePDFImageList.Destroy;
var i: Integer;
begin
  for i := 0 to IImageList.Count - 1 do
      TTeePDFImageListEntry(IImageList.Items[i]).Free;

  IImageList.Free;
  inherited Destroy;
end;

function TTeePDFImageList.EqualImages(i1, i2: TGraphic): Boolean;
{$IFNDEF CLR}
var ms: TMemoryStream;
    s1,s2: String;
    b:Boolean;
{$ENDIF}
begin
  {$IFNDEF CLR}
  ms := TMemoryStream.Create;
  try
    i1.SaveToStream(ms);
    ms.Position := 0;
    SetLength(s1,ms.Size);
    ms.Read(S1[1],Length(s1));
    ms.Clear;
    i2.SaveToStream(ms);
    ms.Position := 0;
    SetLength(s2,ms.Size);
    ms.Read(S2[1],Length(s2));
  finally
    ms.Free;
  end;

  b:=s1=s2;
  result:=b;
  {$ELSE}
  result:=False;
  {$ENDIF}
end;


function TTeePDFImageList.Find(AGraphic: TGraphic): Integer;
var i: Integer;
begin
  Result := -1;

  for i := 0 to ItemsCount-1 do
    if EqualImages(AGraphic,Items[i].FGraphic) then
    begin
      Result := i;
      Break;
    end;
end;

function TTeePDFImageList.GetCount: Integer;
begin
  Result := IImageList.Count;
end;

function TTeePDFImageList.GetImageEntry(
  Index: Integer): TTeePDFImageListEntry;
begin
  Result := TTeePDFImageListEntry(IImageList.Items[Index]);
end;

function CloneGraphic(AGraphic: TGraphic):TGraphic;
begin
  result:=TGraphicClass(AGraphic.ClassType).Create;
  result.Assign(AGraphic);
end;

{ TTeePDFImageListEntry }

Constructor TTeePDFImageListEntry.Create(AGraphic: TGraphic);
begin
  inherited Create;
  FGraphic := CloneGraphic(AGraphic);
  DefineImageData;
end;

Destructor TTeePDFImageListEntry.Destroy;
begin
  FGraphic.Free;
  inherited;
end;

procedure TTeePDFImageListEntry.DefineImageData;
begin
  FWidth := FGraphic.Width;
  FHeight := FGraphic.Height;
end;

function TTeePDFImageListEntry.GetDataLength: Integer;
var ms : TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    FGraphic.SaveToStream(ms);
    Result := ms.Size;
  finally
    ms.Free;
  end;
end;

function TTeePDFImageListEntry.GetImageType: TImageType;
begin
  {$IFNDEF CLR}
  {$IFNDEF CLX}
  if (FGraphic is TJPEGImage) then Result := itJPEG
  else
  {$ENDIF}
  {$ENDIF}
  if (FGraphic is TBitmap) then Result := itBitmap
  else Result := itUnknown; 
end;

procedure TTeePDFImageListEntry.SetObjectNumber(const Value: Integer);
begin
  FObjectNumber := Value;
end;

function TPDFCanvas.SelectImage(Graphic: TGraphic): integer;
begin
  result := FContents.ImageArray.Find(Graphic);

  if result = -1 then
     result := FContents.ImageArray.AddItem(Graphic);
end;

procedure TTeePDFImageListEntry.WriteDataToStream(AStream: TStream);

  procedure WriteBitmap(Bitmap:TBitmap);
  var x,y   : Integer;
      Lines : TRGBArray;
  begin
    TeeCalcLines(Lines,Bitmap);
    try
      for y := 0 to Height -1 do
          for x := 0 to Width -1 do
            // Code compatible with both .Net and Win32/CLX
            with Lines[y,x] do
            begin
              AStream.Write(Red,1);
              AStream.Write(Green,1);
              AStream.Write(Blue,1);
            end;
    finally
      Lines:=nil;
    end;
  end;

var tmp : TBitmap;
begin
  {$IFNDEF CLR}
  {$IFNDEF CLX}
  if FGraphic is TJpegImage then
     (FGraphic as TJpegImage).SaveToStream(AStream)
  else
  {$ENDIF}
  {$ENDIF}
  if FGraphic is TBitmap then
     WriteBitmap(FGraphic as TBitmap)
  else
  begin
    tmp:=TBitmap.Create;
    try
      tmp.Assign(FGraphic);
      WriteBitmap(tmp);
    finally
      tmp.Free;
    end;
  end;

  WriteStringToStream(AStream,CRLF);
end;

procedure TPDFCanvas.AssignVisiblePenColor(APen: TPen; AColor: TColor);
begin
  IPenStyle:=APen.Style;
  IPenWidth:=APen.Width;
  Pen.OnChange:=nil;

  inherited AssignVisiblePenColor(APen,AColor);

  Pen.OnChange:=ChangedPen;
end;

procedure TPDFCanvas.ChangedPen(Sender: TObject);
begin
  IPenStyle := Pen.Style;
  IPenWidth := Pen.Width;
end;

procedure TPDFCanvas.SetTextAlign(Align: TCanvasTextAlign);
begin
  FTextAlign:=Align;
end;

function TPDFCanvas.GetTextAlign: TCanvasTextAlign;
begin
  result:=FTextAlign;
end;

procedure TPDFCanvas.ClipRectangle(const Rect: TRect; RoundSize: Integer);
begin
  ClipRectangle(Rect);
end;

function TPDFCanvas.GetIsNoBMPGrid: Boolean;
begin
  result:=True;
end;

initialization
  RegisterTeeExportFormat(TPDFExportFormat);
finalization
  UnRegisterTeeExportFormat(TPDFExportFormat);
end.

