{**********************************************}
{   TeeChart Numeric Gauge style               }
{   Copyright (c) 2009 by Steema Software      }
{**********************************************}
unit TeeNumericGauge;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes, Math,
  {$IFDEF D6}
  Types,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  {$ENDIF}
  {$IFDEF CLR}
  Variants,
  {$ENDIF}
  TeeProcs, TeEngine, TeeEdiFont, Chart, TeCanvas, TeeEditTools, TeePenDlg,
  TeeTools, TeeEdiGrad;

type
  TNumericGauge=class; // forward

  TNumericMarker=class(TAnnotationTool)
  private
    FGauge : TNumericGauge;

    //INotUsePalette : Boolean;
  public
    Destructor Destroy; override;

    property Gauge:TNumericGauge read FGauge;
  end;

  TNumericMarkers=class(TChartTools)
  private
    FGauge : TNumericGauge;

    function Get(Index: Integer): TNumericMarker;
    procedure Put(Index: Integer; const Value: TNumericMarker);
    procedure SetParentChart(const Value:TCustomTeePanel);
  public
    function Add(const AText:String):TNumericMarker; overload;
    function Add(const AText:String; FontSize:Integer; APosition:TAnnotationPosition;
                 FontColor,ShapeColor:Integer):TNumericMarker; overload;
    procedure Assign(Source:TNumericMarkers); overload;

    property Items[Index:Integer]:TNumericMarker read Get write Put; default;
  end;

  TFrameBrush=class(TChartBrush)
  private
    FGradient : TTeeGradient;
    procedure SetGradient(const Value:TTeeGradient);
  public
    Constructor Create(OnChangeEvent:TNotifyEvent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
  published
    property Gradient:TTeeGradient read FGradient write SetGradient;
  end;

  TFramedBorder=class(TPersistent)
  private
    FBrush          : TFrameBrush;
    FCircled        : Boolean;
    FInner          : TFrameBrush;
    FMiddle         : TFrameBrush;
    FOuter          : TFrameBrush;
    FShadow         : TTeeShadow;
    FVisible        : Boolean;
    FWidth          : Integer;

    IOwner          : TChartSeries;

    procedure GetPalette;
    function IsCircledStored:Boolean;
    procedure SetBrush(const Value: TFrameBrush);
    procedure SetCircled(const Value: Boolean);
    procedure SetInner(const Value: TFrameBrush);
    procedure SetMiddle(const Value: TFrameBrush);
    procedure SetOuter(const Value: TFrameBrush);
    procedure SetShadow(const Value: TTeeShadow);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
  protected
    DefaultCircled : Boolean;

    function CalcWidth(const R:TRect):Integer;
    procedure Draw(R:TRect);
    procedure SetDefaultCircled(const Value:Boolean);
  public
    Constructor Create(AOwner:TChartSeries);
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
  published
    property Brush:TFrameBrush read FBrush write SetBrush;
    property Circled:Boolean read FCircled write SetCircled
                             stored IsCircledStored;
    property InnerBrush:TFrameBrush read FInner write SetInner;
    property MiddleBrush:TFrameBrush read FMiddle write SetMiddle;
    property OuterBrush:TFrameBrush read FOuter write SetOuter;
    property Shadow:TTeeShadow read FShadow write SetShadow;
    property Visible:Boolean read FVisible write SetVisible default True;
    property Width:Integer read FWidth write SetWidth default 10;
  end;

  TCustomGauge=class(TChartSeries)
  private
    FFace     : TTeeShape;
    FFrame    : TFramedBorder;
    FOnChange : TNotifyEvent;

    function GetValue: TChartValue;
    procedure SetFace(const Value: TTeeShape);
    procedure SetFrame(const Value: TFramedBorder);
  protected
    ICircled  : Boolean;
    INewRect  : TRect;
    IOrigRect : TRect;

    procedure CalcOrigRect; virtual;
    procedure DrawAllValues; override;
    procedure DrawFace; virtual;
    procedure SetGaugePalette(const Palette:Array of TColor); virtual;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
    procedure SetValue(const AValue: TChartValue); virtual;
    procedure SetValues; virtual;
  public
    GaugeColorPalette : TColorArray;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    function Clicked(x,y:Integer):Integer; override;
    function GetPaletteColor(Index:Integer):TColor;

    // To be published:
    property Face:TTeeShape read FFace write SetFace;
    property Frame:TFramedBorder read FFrame write SetFrame;
    property Value:TChartValue read GetValue write SetValue;

    // Event to be published:
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

  TDigitalFont=(dfBar, dfDot, dfCustom);

  TNumericGauge=class(TCustomGauge)
  private
    FFont    : TDigitalFont;
    FMarkers : TNumericMarkers;

    procedure ChangeValueMarker;
    function GetTextMarker: TNumericMarker;
    function GetUnitsMarker: TNumericMarker;
    function GetValueMarker: TNumericMarker;
    procedure SetFont(const Value: TDigitalFont);
    procedure SetMarkers(const Value: TNumericMarkers);
  protected
    Procedure AddSampleValues(NumValues:Integer; Sequential:Boolean=False); override;
    class Procedure CreateSubGallery(AddSubChart:TChartSubGalleryProc); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DrawAllValues; override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    procedure ReadMarkers(Stream: TStream);
    procedure SetGaugePalette(const Palette:Array of TColor); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
    class Procedure SetSubGallery(ASeries:TChartSeries; Index:Integer); override;
    procedure SetValue(const Value:TChartValue); override;
    Procedure SetValueFormat(Const Value:String); override;
    procedure WriteMarkers(Stream: TStream);
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    function Clicked(x,y:Integer):Integer; override;
    Function NumSampleValues:Integer; override;
    function UseAxis:Boolean; override;

    property Markers:TNumericMarkers read FMarkers write SetMarkers;
    property TextMarker:TNumericMarker read GetTextMarker;
    property UnitsMarker:TNumericMarker read GetUnitsMarker;
    property ValueMarker:TNumericMarker read GetValueMarker;
  published
    property Active;
    property Cursor;
    property ParentChart;
    property DataSource;  { after parentchart }
    property PercentFormat;
    property ShowInLegend;
    property Title;
    property ValueFormat;

    { events }
    property AfterDrawValues;
    property BeforeDrawValues;
    property OnAfterAdd;
    property OnBeforeAdd;
    property OnChange;
    property OnClearValues;
    property OnClick;
    property OnDblClick;
    property OnMouseEnter;
    property OnMouseLeave;

    property XValues;
    property YValues;

    property DigitalFont:TDigitalFont read FFont write SetFont default dfBar;
    property Face;
    property Frame;
    property Value;
  end;

  TMarkersEditor=class(TFormTeeTools)
  protected
    function CloneTool(Tool:TTeeCustomTool):TTeeCustomTool; override;
    function GetNewTool:TTeeCustomTool; override;
  end;

  TNumericGaugeEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    EValue: TEdit;
    Label2: TLabel;
    CBPalette: TComboFlat;
    RGFont: TRadioGroup;
    TabSheet3: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabFace: TTabSheet;
    TabSheet8: TTabSheet;
    Label3: TLabel;
    CBFrameVisible: TCheckBox;
    EWidth: TEdit;
    UDWidth: TUpDown;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    TabShadow: TTabSheet;
    BBrush: TButton;
    BGradient: TButtonGradient;
    procedure FormShow(Sender: TObject);
    procedure RGFontClick(Sender: TObject);
    procedure CBPaletteChange(Sender: TObject);
    procedure CBFrameVisibleClick(Sender: TObject);
    procedure EWidthChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EValueChange(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
  private
    { Private declarations }
    Tools : TMarkersEditor;
    procedure IncValue(Delta:Integer);
  protected
    Gauge : TCustomGauge;
  public
    { Public declarations }
    class procedure AddBrushDialog(ABrush:TFrameBrush; AParent:TWinControl);
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

{$R TeeFonts.res}

uses
  {$IFDEF CLR}
  System.Runtime.InteropServices,
  WinUtils,
  {$ENDIF}
  TeeConst, TeeProCo, TeeBrushDlg, TeeCustomShapeEditor, TeeShadowEditor;

const
  TeeFontElektra='Elektra';  // Do not localize
  TeeFontDigital='DS-Digital';  // Do not localize

  {$IFNDEF CLR}
  GDI32='gdi32.dll';  // Do not localize
  {$ENDIF}

{$IFNDEF CLR}
var
  TeeGDI32:THandle=0;
{$ENDIF}

procedure TeeGaugeAddFontNames(Items:TStrings);
begin
  Items.Add(TeeFontElektra);
  Items.Add(TeeFontDigital);
end;

var
  TeeFontLCD : Integer=0;
  TeeFontLED : Integer=0;

procedure AddCustomFonts;

{$IFNDEF CLR}
var
  TeeAddFont : function(p1: Pointer; p2: DWORD; p3: PDesignVector; p4: LPDWORD): THandle; stdcall;
{$ENDIF}

  {$IFDEF CLR}
  {$UNSAFECODE ON}
  {$ENDIF}

  function AddFontFromResource(const ResName:String):Integer; {$IFDEF CLR}unsafe;{$ENDIF}

    function ResourceHandle(const AName:String):THandle;
    begin
      if FindResource(MainInstance, {$IFNDEF CLR}PChar{$ENDIF}(AName),
                      RT_RCDATA) <> 0 then
         result:=MainInstance
      else
         result:=HInstance;
    end;

  var
    tmp     : TResourceStream;
    MemSize : Int64;
    Buffer  : {$IFDEF CLR}TBytes{$ELSE}Pointer{$ENDIF};

    {$IFDEF CLR}
    tmpPtr  : IntPtr;
    {$ENDIF}

    tmpC    : DWORD;
  begin
    tmp:=TResourceStream.Create(ResourceHandle(resName), resName, RT_RCDATA);
    try
      MemSize:=tmp.Size;  // Windows 2003 "+1" ??

      {$IFDEF CLR}
      SetLength(Buffer, MemSize);
      {$ELSE}
      GetMem(Buffer, MemSize);
      {$ENDIF}

      try
        {$IFDEF CLR}
        tmp.ReadBuffer(Buffer,MemSize);
        {$ELSE}
        tmp.Read(Buffer^,MemSize);
        {$ENDIF}

        tmpC:=1;

        {$IFDEF CLR}
        Marshal.StructureToPtr(TObject(Buffer),tmpPtr,False);
        result:=AddFontMemResourceEx(tmpPtr,MemSize,nil,tmpC);
        {$ELSE}
        result:=TeeAddFont(Buffer,MemSize,nil,@tmpC);
        {$ENDIF}

        //SendMessage(Application.Handle,WM_FONTCHANGE,0,0);
      finally
        {$IFDEF CLR}
        SetLength(Buffer, 0);
        {$ELSE}
        FreeMem(Buffer);
        {$ENDIF}
      end;
    finally
      tmp.Free;
    end;
  end;

  {$IFDEF CLR}
  {$UNSAFECODE OFF}
  {$ENDIF}

  procedure DoAddFonts; 
  const
    resFile1='TEELCDFONT';
    resFile2='TEELEDFONT';

  begin
    TeeFontLCD:=AddFontFromResource(resFile1);
    TeeFontLED:=AddFontFromResource(resFile2);

    // Screen.ResetFonts;  <-- EnumFonts does not recognize newly added fonts,
    // so we use here a "hook" TeeAddFontNames pseudo-event called from TeeEdiFont
    TeeAddFontNames:=TeeGaugeAddFontNames;
  end;

begin
  TeeAddFontNames:=nil;

  {$IFDEF CLR}

  DoAddFonts;

  {$ELSE}

  TeeGDI32:=TeeLoadLibrary(GDI32);

  if TeeGDI32<>0 then
  begin
    @TeeAddFont:=GetProcAddress(TeeGDI32,'AddFontMemResourceEx'); // Do not localize

    if Assigned(@TeeAddFont) then
       DoAddFonts;

    TeeFreeLibrary(TeeGDI32);
  end;
  {$ENDIF}
end;

procedure RemoveCustomFonts;
{$IFNDEF CLR}
var
  TeeRemoveFont:function(p1: THandle): BOOL; stdcall;
{$ENDIF}

  procedure DoRemoveFonts;
  begin
    if TeeFontLCD<>0 then
       {$IFDEF CLR}
       RemoveFontMemResourceEx(TeeFontLCD);
       {$ELSE}
       TeeRemoveFont(TeeFontLCD);
       {$ENDIF}

    if TeeFontLED<>0 then
       {$IFDEF CLR}
       RemoveFontMemResourceEx(TeeFontLED);
       {$ELSE}
       TeeRemoveFont(TeeFontLED);
       {$ENDIF}
  end;

begin
  TeeAddFontNames:=nil;

  {$IFDEF CLR}
   
  DoRemoveFonts;

  {$ELSE}
  TeeGDI32:=TeeLoadLibrary(GDI32);

  if TeeGDI32<>0 then
  begin
    @TeeRemoveFont:=GetProcAddress(TeeGDI32,'RemoveFontMemResourceEx'); // Do not localize

    if Assigned(@TeeRemoveFont) then
       DoRemoveFonts;

    TeeFreeLibrary(TeeGDI32);
  end;
  {$ENDIF}
end;

const
  LCDPalette : Array[0..23] of TColor=
  (
    $282828,
    $323232,
    $646464,
    $82AAAA,
    $C8DBDB,
    $82AAAA,
    $282864,
    $000000,
    $646464,
    $646464,
    $000000,
    $1EC81E,
    $3C73C8,
    $3C73C8,
    $3C73C8,
    $0A3296,
    $828282,
    $828282,
    $000000,
    $1E1E1E,
    $282828,
    $646464,
    $646464,
    $646464
    );


  LEDPalette : Array[0..23] of TColor=
  (
    $7D3705,
    $C8780A,
    $A05A05,
    $0A0A0A,
    $0A0A0A,
    $0A0A0A,
    $282864,
    $000000,
    $646464,
    $646464,
    $000000,
    $1EC81E,
    $3C73C8,
    $3C73C8,
    $3C73C8,
    $0A3296,
    $828282,
    $828282,
    $000000,
    $1E1E1E,
    $1E1EFF,
    $646464,
    $646464,
    $646464
    );

{ TNumericGauge }
Constructor TNumericGauge.Create(AOwner: TComponent);
begin
  inherited;

  FMarkers:=TNumericMarkers.Create;
  FMarkers.FGauge:=Self;

  SetGaugePalette(LCDPalette);

  if (not Assigned(Owner)) or (not (csLoading in Owner.ComponentState)) then
  begin
    FMarkers.Add(FormatFloat(ValueFormat,Value),36,ppCenter,20,4);
    FMarkers.Add('MHz',18,ppLeftBottom,20,4);
    FMarkers.Add('FREQ',11,ppLeftTop,4,20).Shape.Transparent:=False;
  end;
end;

Destructor TNumericGauge.Destroy;
begin
  FMarkers.Free;
  inherited;
end;

class function TNumericGauge.GetEditorClass: String;
begin
  result:='TNumericGaugeEditor';
end;

class procedure TNumericGaugeEditor.AddBrushDialog(ABrush:TFrameBrush; AParent:TWinControl);
var tmp  : TBrushDialog;
    tmpG : TButtonGradient;
begin
  tmp:=TBrushDialog.Create(AParent.Owner);
  tmp.Align:=alClient;
  tmp.TheBrush:=ABrush;
  tmp.PanelOk.Visible:=False;

  tmpG:=TButtonGradient.Create(tmp);
  tmpG.Width := 105;
  tmpG.LinkGradient(ABrush.Gradient);
  tmpG.Left:=tmp.CBTransp.Left+4;
  tmpG.Top:=100;
  tmpG.Caption:=TeeMsg_Gradient;
  tmpG.Parent:=tmp.Panel1;

  AddFormTo(tmp,AParent);
  TeeTranslateControl(tmp);
end;

procedure TNumericGaugeEditor.FormShow(Sender: TObject);
begin
  Gauge:=TCustomGauge(Tag);

  if Assigned(Gauge) then
  begin

    if Gauge is TNumericGauge then
    begin
      Tools:=TMarkersEditor.Create(Self);
      Tools.Tools:=(Gauge as TNumericGauge).Markers;
      Tools.Align:=alClient;
      AddFormTo(Tools,TabSheet2);

      RGFont.ItemIndex:=Ord((Gauge as TNumericGauge).DigitalFont);
    end
    else
    begin
      TabSheet2.TabVisible:=False;
      RGFont.Visible:=False;
    end;

    EValue.Text:=FloatToStr(Gauge.Value);

    AddBrushDialog(Gauge.Frame.OuterBrush,TabSheet4);
    AddBrushDialog(Gauge.Frame.MiddleBrush,TabSheet5);
    AddBrushDialog(Gauge.Frame.InnerBrush,TabSheet6);

    BGradient.LinkGradient(Gauge.Frame.Brush.Gradient);

    TFormTeeShape.CreateForm(Self,Gauge.Face,TabFace);

    InsertTeeShadowEditor(TabShadow).RefreshControls(Gauge.Frame.Shadow);

    CBFrameVisible.Checked:=Gauge.Frame.Visible;
    UDWidth.Position:=Gauge.Frame.Width;
  end;

  ColorPalettes.AddTo(CBPalette.Items);
  TeeTranslateControl(self);
end;

function TNumericGauge.UseAxis: Boolean;
begin
  result:=False;
end;

procedure TNumericGauge.SetFont(const Value: TDigitalFont);
begin
  if FFont<>Value then
  begin
    FFont:=Value;
    Repaint;
  end;
end;

class procedure TNumericGauge.CreateSubGallery(
  AddSubChart: TChartSubGalleryProc);
begin
  inherited;
  AddSubChart(TeeMsg_LEDGauge);
end;

procedure TNumericGauge.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('InternalMarkers',ReadMarkers,WriteMarkers,Markers.Count>0);
end;

procedure TNumericGauge.SetGaugePalette(const Palette:Array of TColor);

  procedure GetPalette(Marker:TNumericMarker; FontColor,ShapeColor:Integer);
  begin
    if Assigned(Marker) then
    with Marker.Shape do
    begin
      Font.Color:=GetPaletteColor(FontColor);
      Color:=GetPaletteColor(ShapeColor);
    end;
  end;

begin
  inherited;

  if Markers.Count>0 then
     GetPalette(ValueMarker,20,4);

  if Markers.Count>1 then
     GetPalette(UnitsMarker,20,4);

  if Markers.Count>2 then
     GetPalette(TextMarker,4,20);

  (*
  for t:=0 to Markers.Count-1 do
  with Markers[t] do
  if not INotUsePalette then
  begin
    ??
  end;
  *)
end;

class procedure TNumericGauge.SetSubGallery(ASeries: TChartSeries;
  Index: Integer);
begin
  inherited;

  if Index=1 then
  with ASeries as TNumericGauge do
  begin
    DigitalFont:=dfDot;
    SetGaugePalette(LEDPalette);
  end;
end;

procedure TNumericGauge.DrawAllValues;

  procedure DrawMarkers;
  var t    : Integer;
      tmpR : TRect;
      tmpN,
      tmpX,
      tmpY : Integer;
  begin
    for t:=0 to Markers.Count-1 do
    with Markers[t] do
    if Active then
    begin
      case DigitalFont of
        dfBar: Shape.Font.Name:=TeeFontDigital;
        dfDot: Shape.Font.Name:=TeeFontElektra;
      end;

    {  if valueMarker.Text='' then
          valueMarker.Text:='NaN'; } // ??

      tmpR:=GetTextBounds(Self.ParentChart,INewRect,tmpN,tmpX,tmpY);
      Shape.DrawText(Self.ParentChart,tmpR,0,tmpN);
    end;
  end;

begin
  inherited;
  DrawMarkers;
end;

procedure TCustomGauge.CalcOrigRect;
var maxHeight,
    height, width, x, y,
    tmpCount,
    seriesIndex,
    t,
    step : Integer;
begin
  IOrigRect:=ParentChart.ChartRect;

  with Frame.Shadow do
  if Visible then
  begin
    if HorizSize>0 then
       Dec(IOrigRect.Right,HorizSize)
    else
       Inc(IOrigRect.Left,HorizSize);

    if VertSize>0 then
       Dec(IOrigRect.Bottom,VertSize)
    else
       Inc(IOrigRect.Top,VertSize);
  end;

  maxHeight:= (IOrigRect.Bottom-IOrigRect.Top);

  tmpCount:=0;
  seriesIndex:=0;

  with ParentChart do
  for t:=0 to SeriesCount-1 do
    if (Series[t] is TCustomGauge) and Series[t].Visible then
    begin
      Inc(tmpCount);

      if Series[t]=Self then
         seriesIndex:=tmpCount-1;
    end;

  if tmpCount=0 then
     Exit;

  step:= (IOrigRect.Bottom-IOrigRect.Top) div tmpCount;

  height := Math.Min(maxHeight, step) -3;
  width := (IOrigRect.Right-IOrigRect.Left);

  x := IOrigRect.Left;
  y := IOrigRect.Top;

  if tmpCount = 1 then
     Inc(y, 0)
  else
     Inc(y, step * seriesIndex);

  IOrigRect:=TeeRect(x,y, x+width,y+height);
end;

function TCustomGauge.GetPaletteColor(Index: Integer): TColor;
var tmp : Integer;
begin
  tmp:=Length(GaugeColorPalette);

  if tmp=0 then
     if Assigned(ParentChart) then
        result:=ParentChart.GetDefaultColor(Index)
     else
        result:=clBlack
  else
  begin
    if Index>=tmp then
       Index:=tmp-1;

    result:=GaugeColorPalette[Index];
  end;
end;

procedure TNumericGauge.Assign(Source: TPersistent);
begin
  if Source is TNumericGauge then
  with TNumericGauge(Source) do
  begin
    Self.FFont:=FFont;
    Self.Markers:=FMarkers;
  end;

  inherited;
end;

procedure TNumericGauge.SetMarkers(const Value: TNumericMarkers);
begin
  FMarkers.Assign(Value);
end;

procedure TNumericGauge.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if not (csDestroying in ComponentState) then
     FMarkers.SetParentChart(ParentChart);
end;

procedure TNumericGauge.AddSampleValues(NumValues: Integer;
  Sequential: Boolean);
begin
  inherited;
  Value:=Value; // force reset text of ValueMarker annotation
end;

procedure TNumericGauge.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;

  Value:=Random(30);
  ValueMarker.Position:=ppRightBottom;

  ValueMarker.Shape.Font.Size:=18;
  UnitsMarker.Shape.Font.Size:=16;
  TextMarker.Shape.Font.Size:=12;
end;

procedure TNumericGauge.ReadMarkers(Stream: TStream);
var t   : Integer;
    Num : Integer;
    tmp : TNumericMarker;
begin
  Markers.Clear;

  Stream.Read(Num,SizeOf(Num));

  for t:=0 to Num-1 do
  begin
    tmp:=Stream.ReadComponent(nil) as TNumericMarker;
    tmp.FGauge:=Self;
    Markers.Add(tmp);
  end;

  FMarkers.SetParentChart(ParentChart);
end;

procedure TNumericGauge.WriteMarkers(Stream: TStream);
var t : Integer;
begin
  Stream.WriteBuffer(Markers.Count,SizeOf(Markers.Count));

  for t:=0 to Markers.Count-1 do
      Stream.WriteComponent(Markers[t]);
end;

function TNumericGauge.GetTextMarker: TNumericMarker;
begin
  while Markers.Count<3 do
        Markers.Add('');
        
  result:=Markers[2];
end;

function TNumericGauge.GetUnitsMarker: TNumericMarker;
begin
  while Markers.Count<2 do
        Markers.Add('');

  result:=Markers[1];
end;

function TNumericGauge.GetValueMarker: TNumericMarker;
begin
  if Markers.Count=0 then
     Markers.Add('');

  result:=Markers[0];
end;

function TNumericGauge.Clicked(x, y: Integer): Integer;
begin
  result:=inherited Clicked(x,y);

  // Improve: Loop all Markers and return index under mouse,
  // what about back area?
end;

procedure TNumericGauge.ChangeValueMarker;
begin
  if Markers.Count>0 then
     ValueMarker.Text:=FormatFloat(ValueFormat,Value);
end;

procedure TNumericGauge.SetValue(const Value: TChartValue);
begin
  inherited;
  ChangeValueMarker;
end;

function TNumericGauge.NumSampleValues: Integer;
begin
  result:=1;
end;

procedure TNumericGauge.SetValueFormat(const Value: String);
begin
  inherited;
  ChangeValueMarker;
end;

{ TMarkersEditor }

function TMarkersEditor.CloneTool(Tool: TTeeCustomTool): TTeeCustomTool;
begin
  result:=CloneChartTool(Tool,Tool.Owner);
  Tools.Add(result);
  (result as TNumericMarker).FGauge:=(Tools as TNumericMarkers).FGauge;
end;

function TMarkersEditor.GetNewTool: TTeeCustomTool;
begin
  result:=(Tools as TNumericMarkers).Add('Marker');
end;

{ TNumericMarker }
Destructor TNumericMarker.Destroy;
begin
  if Assigned(FGauge) then
  with FGauge.Markers do
       Delete(IndexOf(Self));

  inherited;
end;

{ TNumericMarkers }

function TNumericMarkers.Add(const AText: String): TNumericMarker;
begin
  result:=inherited Add(TNumericMarker) as TNumericMarker;

  with result.Shape do
  begin
    Transparent:=True;
    Font.Name:=TeeFontDigital;
    Pen.Visible:=False;
    Shadow.Visible:=False;
    ParentChart:=Self.FGauge.ParentChart;
  end;

  result.FGauge:=FGauge;
  result.Text:=AText;
end;

function TNumericMarkers.Add(const AText:String; FontSize:Integer; APosition:TAnnotationPosition;
                 FontColor,ShapeColor:Integer):TNumericMarker;
begin
  result:=Add(AText);

  result.Position:=APosition;

  with result.Shape do
  begin
    Font.Size:=FontSize;
    Font.Color:=FGauge.GetPaletteColor(FontColor);
    Color:=FGauge.GetPaletteColor(ShapeColor);
    // TextAlignment:=?
  end;
end;

procedure TNumericMarkers.Assign(Source: TNumericMarkers);
var t : Integer;
begin
  Clear;

  for t:=0 to Source.Count-1 do
      Add('').Assign(Source[t]);
end;

function TNumericMarkers.Get(Index: Integer): TNumericMarker;
begin
  result:=TNumericMarker(inherited Get(Index));
end;

procedure TNumericMarkers.Put(Index: Integer; const Value: TNumericMarker);
begin
  Items[Index]:=Value;
end;

type
  TChartSeriesAccess=class(TChartSeries);

procedure TNumericMarkers.SetParentChart(const Value: TCustomTeePanel);
var t : Integer;
begin
  for t:=0 to Count-1 do
      Items[t].Shape.ParentChart:=Value;
end;

{ TFrameBrush }
Constructor TFrameBrush.Create(OnChangeEvent:TNotifyEvent);
begin
  inherited Create(OnChangeEvent);
  FGradient:=TTeeGradient.Create(OnChangeEvent);
end;

Destructor TFrameBrush.Destroy;
begin
  FGradient.Free;
  inherited;
end;

procedure TFrameBrush.Assign(Source: TPersistent);
begin
  if Source is TFrameBrush then
  with TFrameBrush(Source) do
       Self.Gradient:=Gradient;

  inherited;
end;

procedure TFrameBrush.SetGradient(const Value:TTeeGradient);
begin
  FGradient.Assign(Value);
end;

{ TFramedBorder }
Constructor TFramedBorder.Create(AOwner:TChartSeries);
begin
  inherited Create;
  FVisible:=True;
  FWidth:=10;

  IOwner:=AOwner;

  FShadow:=TTeeShadow.Create(TChartSeriesAccess(IOwner).CanvasChanged);

  FBrush:=TFrameBrush.Create(TChartSeriesAccess(IOwner).CanvasChanged);
  FInner:=TFrameBrush.Create(TChartSeriesAccess(IOwner).CanvasChanged);
  FMiddle:=TFrameBrush.Create(TChartSeriesAccess(IOwner).CanvasChanged);
  FOuter:=TFrameBrush.Create(TChartSeriesAccess(IOwner).CanvasChanged);

  GetPalette;
end;

Destructor TFramedBorder.Destroy;
begin
  FOuter.Free;
  FMiddle.Free;
  FInner.Free;
  FBrush.Free;

  FShadow.Free;
  inherited;
end;

procedure TFramedBorder.Assign(Source: TPersistent);
begin
  if Source is TFramedBorder then
  with TFramedBorder(Source) do
  begin
    Self.FCircled:=FCircled;
    Self.Brush:=Brush;
    Self.InnerBrush:=FInner;
    Self.MiddleBrush:=FMiddle;
    Self.OuterBrush:=FOuter;
    Self.Shadow:=Shadow;
    Self.FVisible:=FVisible;
    Self.FWidth:=FWidth;
  end
  else
    inherited;
end;

procedure TFramedBorder.GetPalette;
begin
  FInner.BackColor:=TCustomGauge(IOwner).GetPaletteColor(2);
  FInner.Gradient.EndColor:=FInner.BackColor;

  FMiddle.BackColor:=TCustomGauge(IOwner).GetPaletteColor(1);
  FMiddle.Gradient.EndColor:=FMiddle.BackColor;

  FOuter.BackColor:=TCustomGauge(IOwner).GetPaletteColor(0);
  FOuter.Gradient.EndColor:=FOuter.BackColor;
end;

function TFramedBorder.CalcWidth(const R:TRect):Integer;
begin
  result:=Round(Width*Math.Min(R.Right-R.Left, R.Bottom-R.Top)*0.01);
end;

procedure TFramedBorder.Draw(R: TRect);
var
  tmp : TCanvas3D;

  procedure DrawBand(ABrush:TFrameBrush);
  begin
    if ABrush.Gradient.Visible then
       if Circled then
       begin
         tmp.ClipEllipse(R);
         ABrush.Gradient.Draw(tmp,R);
         tmp.UnClipRectangle;
       end
       else
          ABrush.Gradient.Draw(tmp,R)
    else
    if ABrush.Style<>bsClear then
    begin
      tmp.AssignBrush(ABrush);

      if Circled then
         tmp.Ellipse(R)
      else
         tmp.Rectangle(R);
    end;
  end;

var tmpWidth : Double;
begin
  tmp:=IOwner.ParentChart.Canvas;

  if Shadow.Visible and (Shadow.Size<>0) then
     if Circled then
        Shadow.DrawEllipse(tmp,R)
     else
        Shadow.Draw(tmp,R);

  tmp.Pen.Style:=psClear;

  DrawBand(FOuter);

  tmpWidth:=CalcWidth(R)*0.1;

  InflateRect(R, -Round(tmpWidth), -Round(tmpWidth));
  DrawBand(FMiddle);

  InflateRect(R, -Round(7*tmpWidth), -Round(7*tmpWidth));
  DrawBand(FInner);

  InflateRect(R, -Round(2*tmpWidth), -Round(2*tmpWidth));
  DrawBand(FBrush);
end;

function TFramedBorder.IsCircledStored:Boolean;
begin
  result:=Circled<>DefaultCircled;
end;

procedure TFramedBorder.SetBrush(const Value: TFrameBrush);
begin
  FBrush.Assign(Value);
end;

procedure TFramedBorder.SetCircled(const Value: Boolean);
begin
  if FCircled<>Value then
  begin
    FCircled:=Value;
    IOwner.Repaint;
  end;
end;

procedure TFramedBorder.SetInner(const Value: TFrameBrush);
begin
  FInner.Assign(Value);
end;

procedure TFramedBorder.SetMiddle(const Value: TFrameBrush);
begin
  FMiddle.Assign(Value);
end;

procedure TFramedBorder.SetOuter(const Value: TFrameBrush);
begin
  FOuter.Assign(Value);
end;

procedure TFramedBorder.SetShadow(const Value: TTeeShadow);
begin
  FShadow.Assign(Value);
end;

procedure TFramedBorder.SetVisible(const Value: Boolean);
begin
  if FVisible<>Value then
  begin
    FVisible:=Value;
    IOwner.Repaint;
  end;
end;

procedure TFramedBorder.SetWidth(const Value: Integer);
begin
  if FWidth<>Value then
  begin
    FWidth:=Value;
    IOwner.Repaint;
  end;
end;

procedure TNumericGaugeEditor.CBPaletteChange(Sender: TObject);
var tmp : TChart;
begin
  case CBPalette.ItemIndex of
    1: Gauge.SetGaugePalette(LCDPalette);
    2: Gauge.SetGaugePalette(LEDPalette);
  else
    begin
      // TODO: Refactor to avoid tmp
      tmp:=TChart.Create(nil);
      try
        ColorPalettes.ApplyPalette(tmp,CBPalette.ItemIndex-3);
        Gauge.SetGaugePalette(tmp.ColorPalette);
      finally
        tmp.Free;
      end;
    end;
  end;

  Gauge.Repaint;
end;

procedure TNumericGaugeEditor.IncValue(Delta:Integer);
begin
  Gauge.Value:=Gauge.Value+Delta;
  EValue.Text:=FloatToStr(Gauge.Value);
  Gauge.Repaint;
end;

procedure TNumericGaugeEditor.RGFontClick(Sender: TObject);
begin
  (Gauge as TNumericGauge).DigitalFont:=TDigitalFont(RGFont.ItemIndex);
end;

procedure TNumericGaugeEditor.CBFrameVisibleClick(Sender: TObject);
begin
  Gauge.Frame.Visible:=CBFrameVisible.Checked;
end;

procedure TNumericGaugeEditor.EWidthChange(Sender: TObject);
begin
  if Showing then
     Gauge.Frame.Width:=UDWidth.Position;
end;

procedure TNumericGaugeEditor.SpeedButton1Click(Sender: TObject);
begin
  IncValue(1);
end;

procedure TNumericGaugeEditor.SpeedButton2Click(Sender: TObject);
begin
  IncValue(-1);
end;

procedure TNumericGaugeEditor.EValueChange(Sender: TObject);
begin
  Gauge.Value:=StrToFloatDef(EValue.Text,Gauge.Value);
end;

{$IFNDEF CLR}
type
  TShadowAccess=class(TTeeShadow);
{$ENDIF}

procedure TFramedBorder.SetDefaultCircled(const Value: Boolean);
begin
  FCircled:=Value;
  DefaultCircled:=FCircled;
end;

{ TCustomGauge }

Constructor TCustomGauge.Create(AOwner: TComponent);
begin
  inherited;

  ShowInLegend:=False;
  CalcVisiblePoints:=False;

  FFrame:=TFramedBorder.Create(Self);

  FFace:=TTeeShape.Create(nil);

  with FFace.Gradient do
  begin
    Visible:=True;
    Direction:=gdBottomTop;
//    CenterXOffset := Round(INewRectangle.Width * 0.2);
//    CenterYOffset := Round(INewRectangle.Height * -0.2);
  end;

  FFace.Brush.Color:=clWhite;

  FFace.Shadow.Visible:=False;
  {$IFNDEF CLR}TShadowAccess{$ENDIF}(FFace.Shadow).DefaultVisible:=False;

  Add(100*Random);
end;

Destructor TCustomGauge.Destroy;
begin
  FreeAndNil(FFace);
  FreeAndNil(FFrame);
  inherited;
end;

procedure TCustomGauge.Assign(Source: TPersistent);
begin
  if Source is TCustomGauge then
  with TCustomGauge(Source) do
  begin
    Self.Face:=Face;
    Self.Frame:=Frame;
    Self.Value:=Value;
  end;

  inherited;

  FFrame.SetDefaultCircled(False); // TV52012495
end;

procedure TCustomGauge.SetFrame(const Value: TFramedBorder);
begin
  FFrame.Assign(Value);
end;

procedure TCustomGauge.SetGaugePalette(const Palette:Array of TColor);
var t : Integer;
begin
  GaugeColorPalette:=nil;

  SetLength(GaugeColorPalette,High(Palette)+1);
  for t:=Low(Palette) to High(Palette) do
      GaugeColorPalette[t]:=Palette[t];

  FFace.Gradient.StartColor:=GetPaletteColor(3);
  FFace.Gradient.MidColor:=GetPaletteColor(4);
  FFace.Gradient.EndColor:=GetPaletteColor(5);

  if Assigned(FFrame) then
     Frame.GetPalette;
end;

function TCustomGauge.Clicked(x, y: Integer): Integer;
begin
  if PtInRect(IOrigRect,TeePoint(x,y)) then
     result:=0
  else
     result:=TeeNoPointClicked;
end;

Procedure TCustomGauge.SetParentChart(Const Value:TCustomAxisPanel);
begin
  inherited;

  if not (csDestroying in ComponentState) then
     Face.ParentChart:=ParentChart;
end;

procedure TCustomGauge.SetValue(const AValue: TChartValue);
begin
  if Count=0 then
  begin
    Add(AValue);

    if Assigned(FOnChange) then
       FOnChange(Self);
  end
  else
  if MandatoryValueList[0]<>AValue then
  begin
    MandatoryValueList[0]:=AValue;

    Repaint;

    if Assigned(FOnChange) then
       FOnChange(Self);
  end;
end;

function TCustomGauge.GetValue:TChartValue;
begin
  result:=MandatoryValueList[0];
end;

procedure TCustomGauge.SetFace(const Value: TTeeShape);
begin
  Face.Assign(Value);
end;

procedure TCustomGauge.DrawFace;
begin
  if Face.Pen.Visible then
  begin
    Dec(INewRect.Right,Face.Pen.Width);
    Dec(INewRect.Bottom,Face.Pen.Width);
  end;

  // Follow Frame "Circled" style:
  if Frame.Circled then
     ParentChart.Canvas.ClipEllipse(INewRect);

  Face.DrawRectRotated(ParentChart,INewRect);

  if Frame.Circled then
     ParentChart.Canvas.UnClipRectangle;
end;

procedure TCustomGauge.DrawAllValues;
var tmpR : TRect;

  procedure DrawFrame;
  begin
    if Frame.Visible then
       Frame.Draw(tmpR);
  end;

begin
  CalcOrigRect;

  tmpR:=IOrigRect;
  INewRect:=IOrigRect;

  SetValues;

//  tmpR:=IOrigRect;

  DrawFrame;
  DrawFace;
end;

procedure TCustomGauge.SetValues;
var tmp : Integer;
begin
  if Frame.Visible then
  begin
    tmp:=Frame.CalcWidth(INewRect);
    InflateRect(INewRect,-tmp,-tmp);
  end;
end;

procedure TNumericGaugeEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Gauge.Frame.Brush);
end;

initialization
  {$IFNDEF CLR}
  AddCustomFonts;
  {$ENDIF}

  RegisterTeeSeries(TNumericGauge, {$IFNDEF CLR}@{$ENDIF}TeeMsg_NumericGauge,
                                  {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryGauges,1);
  RegisterClasses([TNumericMarker,TNumericGaugeEditor]);
finalization
  RemoveCustomFonts;
  UnRegisterTeeSeries([TNumericGauge]);
end.
