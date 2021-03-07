{**********************************************}
{   TLightTool Component and Editor Dialog     }
{   Copyright (c) 2003-2009 by David Berneda   }
{**********************************************}
unit TeeLighting;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes,
     {$IFDEF CLX}
     QControls, QGraphics, QStdCtrls, QComCtrls, QExtCtrls, QForms,
     {$ELSE}
     Controls, Graphics, StdCtrls, ComCtrls, ExtCtrls, Forms,
     {$ENDIF}
     TeeSurfa, Chart, TeCanvas, TeeProcs, TeEngine, TeeComma, TeeFilters;

type
  TLightStyle=(lsLinear,lsSpotLight);

  TLightFilter=class(TTeeFilter)
  private
    FTop: Integer;
    FLeft: Integer;
    FFactor: Integer;
    FStyle: TLightStyle;

    procedure SetFactor(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetStyle(const Value: TLightStyle);
    procedure SetTop(const Value: Integer);
  public
    Constructor Create(Collection:TCollection); override;

    procedure Apply(Bitmap:TBitmap; const R:TRect); override;
    procedure CreateEditor(Creator:IFormCreator; AChanged:TNotifyEvent); override;
    class function Description: String; override;
  published
    property Factor:Integer read FFactor write SetFactor default 10;
    property Left:Integer read FLeft write SetLeft default -1;
    property Style:TLightStyle read FStyle write SetStyle default lsLinear;
    property Top:Integer read FTop write SetTop default -1;
  end;

  TLightTool=class(TTeeCustomTool)
  private
    FFilter : TLightFilter;
    FMouse  : Boolean;

    Buffer  : TBitmap;
    InsideLighting : Boolean;

    procedure SetFactor(const Value: Integer);
    procedure SetLeft(const Value: Integer);
    procedure SetStyle(const Value: TLightStyle);
    procedure SetTop(const Value: Integer);
    function GetFactor: Integer;
    function GetLeft: Integer;
    function GetStyle: TLightStyle;
    function GetTop: Integer;
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               AButton:TMouseButton;
                               AShift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
    procedure Iluminate;
    class Function LongDescription:String; override;
  published
    property Active;
    property Factor:Integer read GetFactor write SetFactor default 10;
    property FollowMouse:Boolean read FMouse write FMouse default False;
    property Left:Integer read GetLeft write SetLeft default -1;
    property Style:TLightStyle read GetStyle write SetStyle default lsLinear;
    property Top:Integer read GetTop write SetTop default -1;
  end;

  TLightToolEditor=class(TForm)
    CheckBox2: TCheckBox;
    Label1: TLabel;
    TBLeft: TTrackBar;
    TBTop: TTrackBar;
    Label2: TLabel;
    Label3: TLabel;
    CBStyle: TComboFlat;
    TBFactor: TTrackBar;
    Label4: TLabel;
    procedure CheckBox2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TBFactorChange(Sender: TObject);
    procedure TBTopChange(Sender: TObject);
    procedure TBLeftChange(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    Light : TLightTool;
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
  SysUtils, Math, TeeConst, TeeProCo;

{ TLightFilter }

Constructor TLightFilter.Create(Collection: TCollection);
begin
  inherited;
  FFactor:=10;
  FStyle:=lsLinear;
  FLeft:=-1;
  FTop:=-1;
end;

procedure TLightFilter.Apply(Bitmap: TBitmap; const R: TRect);
var
  twoPercent : Integer;

  xx,
  yy,
  x,y,
  h,w  : Integer;
  tmpy : Integer;

  maxDist,
  Dist,
  tmpFactor,
  tmpFactorMaxDist : Double;
begin
  inherited;

  if Length(Lines)=0 then
     Exit;

  h:=Bitmap.Height;
  w:=Bitmap.Width;

  MaxDist:=100.0/Sqrt((w*w)+(h*h));

  tmpFactor:=FFactor*0.01;
  if FStyle=lsLinear then
     tmpFactor:=20*tmpFactor;

  tmpFactorMaxDist:=tmpFactor*MaxDist;

  if FLeft=-1 then xx:=w div 2
              else xx:=FLeft;

  if FTop=-1 then yy:=h div 2
             else yy:=FTop;

  for y:=R.Top to R.Bottom do
  begin
    tmpY:=Sqr(y-yy);

    for x:=R.Left to R.Right do
    begin
      Dist:=Sqrt(Sqr(x-xx)+tmpY);

      if FStyle=lsLinear then
         twoPercent:=Round(tmpFactorMaxDist*Dist)
      else
         twoPercent:=Round(tmpFactor*Sqr(MaxDist*(Dist+1)));

      if twoPercent>0 then

      {$IFOPT R+}
      {$DEFINE WASRANGE}
      {$ENDIF}
      {$R-}

      with Lines[y,x] do

      {$IFDEF WASRANGE}
      {$R+}
      {$ENDIF}

      if twoPercent>=255 then
      begin
        Red:=0;
        Green:=0;
        Blue:=0;
      end
      else
      begin
        if twoPercent>=Red then Red:=0
                           else Dec(Red,twoPercent);

        if twoPercent>=Green then Green:=0
                             else Dec(Green,twoPercent);

        if twoPercent>=Blue then Blue:=0
                            else Dec(Blue,twoPercent);
      end;
    end;
  end;
end;

procedure TLightFilter.CreateEditor(Creator: IFormCreator;
  AChanged: TNotifyEvent);
begin
  inherited;
  Creator.AddInteger('Left','',-1,2000); // Do not localize
  Creator.AddInteger('Top','',-1,2000); // Do not localize
  Creator.AddScroll('Factor',1,100); // Do not localize
  Creator.AddCombo('Style'); // Do not localize
end;

class function TLightFilter.Description: String;
begin
  result:=TeeMsg_LightTool;
end;

procedure TLightFilter.SetFactor(const Value: Integer);
begin
  FFactor:=Value;
end;

procedure TLightFilter.SetLeft(const Value: Integer);
begin
  FLeft:=Value;
end;

procedure TLightFilter.SetStyle(const Value: TLightStyle);
begin
  FStyle:=Value;
end;

procedure TLightFilter.SetTop(const Value: Integer);
begin
  FTop:=Value;
end;

{ TLightTool }

Constructor TLightTool.Create(AOwner: TComponent);
begin
  inherited;
  FFilter:=TLightFilter.Create(nil);
end;

Destructor TLightTool.Destroy;
begin
  FreeAndNil(Buffer);
  FFilter.Free;
  inherited;
end;

procedure TLightTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
begin
  inherited;

  if Active and FMouse and (AEvent=cmeMove) then
  begin
    FFilter.FLeft:=X;
    FFilter.FTop:=Y;
    Repaint;
  end;
end;

procedure TLightTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if Active and (AEvent=cteAfterDraw) then
  begin
    FreeAndNil(Buffer);
    Iluminate;
  end;
end;

class function TLightTool.Description: String;
begin
  result:=TeeMsg_LightTool;
end;

class function TLightTool.GetEditorClass: String;
begin
  result:='TLightToolEditor'; // Do not localize
end;

procedure TLightTool.Iluminate;

  Procedure CheckBuffer;
  begin
    if (not Assigned(Buffer)) or (Buffer.Width<>ParentChart.Width) or
       (Buffer.Height<>ParentChart.Height) then
    begin
      Buffer.Free;

      if TTeeCanvas3D(ParentChart.Canvas).Bitmap<>nil then
      begin
        Buffer:=TBitmap.Create;
        TeeSetBitmapSize(Buffer,ParentChart.Width,ParentChart.Height);
        Buffer.PixelFormat:=TeePixelFormat;
        Buffer.Canvas.Draw(0,0,TTeeCanvas3D(ParentChart.Canvas).Bitmap);
      end
      else
        Buffer:=ParentChart.TeeCreateBitmap(ParentChart.Color,ParentChart.ChartBounds,TeePixelFormat);
    end;
  end;

begin
  if (not ParentChart.Canvas.Metafiling) then
  if not InsideLighting then
  begin
    InsideLighting:=True;  // set flag to avoid re-entrancy
    try
      CheckBuffer;
      FFilter.Apply(Buffer);
      ParentChart.Canvas.Draw(0,0,Buffer);  // draw bitmap onto Chart
    finally
      InsideLighting:=False;  // reset flag
    end;
  end;
end;

procedure TLightTool.SetFactor(const Value: Integer);
begin
  SetIntegerProperty(FFilter.FFactor,Value);
end;

procedure TLightTool.SetLeft(const Value: Integer);
begin
  SetIntegerProperty(FFilter.FLeft,Value);
end;

procedure TLightTool.SetStyle(const Value: TLightStyle);
begin
  if FFilter.FStyle<>Value then
  begin
    FFilter.FStyle:=Value;
    Repaint;
  end;
end;

procedure TLightTool.SetTop(const Value: Integer);
begin
  SetIntegerProperty(FFilter.FTop,Value);
end;

procedure TLightTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;
  if Assigned(ParentChart) then Repaint;
end;

class function TLightTool.LongDescription: String;
begin
  result:=TeeMsg_LightToolDesc;
end;

function TLightTool.GetFactor: Integer;
begin
  result:=FFilter.FFactor;
end;

function TLightTool.GetLeft: Integer;
begin
  result:=FFilter.FLeft;
end;

function TLightTool.GetStyle: TLightStyle;
begin
  result:=FFilter.FStyle;
end;

function TLightTool.GetTop: Integer;
begin
  result:=FFilter.FTop;
end;

{ TLightToolEditor }

procedure TLightToolEditor.CheckBox2Click(Sender: TObject);
begin
  Light.FollowMouse:=CheckBox2.Checked;
end;

procedure TLightToolEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
  CreatingForm:=True;
end;

procedure TLightToolEditor.FormShow(Sender: TObject);
begin
  Light:=TLightTool(Tag);

  if Assigned(Light) then
  with Light do
  begin
    CheckBox2.Checked:=FollowMouse;

    if Assigned(ParentChart) then
    begin
      TBLeft.Max:=ParentChart.Width;
      TBTop.Max:=ParentChart.Height;
    end;

    if (Left=-1) and Assigned(ParentChart) then
       TBLeft.Position:=ParentChart.Left+(ParentChart.Width div 2)
    else
       TBLeft.Position:=Left;

    if (Top=-1) and Assigned(ParentChart) then
       TBTop.Position:=ParentChart.Top+(ParentChart.Height div 2)
    else
       TBTop.Position:=Top;

    TBFactor.Position:=Factor;

    if Style=lsLinear then CBStyle.ItemIndex:=0
                      else CBStyle.ItemIndex:=1;
  end;

  CreatingForm:=False;
end;

procedure TLightToolEditor.TBFactorChange(Sender: TObject);
begin
  Light.Factor:=TBFactor.Position;
end;

procedure TLightToolEditor.TBTopChange(Sender: TObject);
begin
  if not CreatingForm then
     Light.Top:=TBTop.Position;
end;

procedure TLightToolEditor.TBLeftChange(Sender: TObject);
begin
  if not CreatingForm then
     Light.Left:=TBLeft.Position;
end;

procedure TLightToolEditor.CBStyleChange(Sender: TObject);
begin
  if CBStyle.ItemIndex=0 then Light.Style:=lsLinear
                         else Light.Style:=lsSpotLight;
end;

initialization
  RegisterClass(TLightToolEditor);
  RegisterTeeTools([TLightTool]);
  TeeRegisterFilters([TLightFilter]);
finalization
  TeeUnRegisterFilters([TLightFilter]);
  UnRegisterTeeTools([TLightTool]);
end.
