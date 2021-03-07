{**********************************************}
{   TeeChart - Fade-in fade-out tool           }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeFaderTool;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QStdCtrls,
  QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  {$ENDIF}
  {$IFDEF D6}
  Types,
  {$ENDIF}
  TeCanvas, TeEngine;

type
  TFaderStyle=(fsFadeIn,fsFadeOut);

  TFaderTool=class(TTeeCustomTool)
  private
    FColor  : TColor;
    FDelay  : Integer;
    FOnStop : TNotifyEvent;
    FSpeed  : Double;
    FStyle  : TFaderStyle;

    IDest   : TBitmap;
    ITimer  : TTimer;
    ITransp : Double;
    IInitial : Boolean;
    procedure DoTimer(Sender:TObject);
  protected
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class function Description:String; override;
    class Function LongDescription:String; override;

    procedure Start;
    procedure Stop;
  published
    property Color:TColor read FColor write FColor default clBlack;
    property InitialDelay:Integer read FDelay write FDelay default 100;
    property Speed:Double read FSpeed write FSpeed;
    property Style:TFaderStyle read FStyle write FStyle default fsFadeIn;

    property OnStop:TNotifyEvent read FOnStop write FOnStop;
  end;

  TFaderEditor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BStart: TButton;
    BReset: TButton;
    SBSpeed: TScrollBar;
    ButtonColor1: TButtonColor;
    RGStyle: TRadioGroup;
    Edit1: TEdit;
    UDDelay: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure SBSpeedChange(Sender: TObject);
    procedure RGStyleClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BResetClick(Sender: TObject);
  private
    { Private declarations }

    Tool : TFaderTool;

    OldOnStop : TNotifyEvent;
    procedure FaderStop(Sender: TObject);
    procedure SetLabelSpeed;
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
  Math, Chart, TeeProCo;

{ TFaderTool }

Constructor TFaderTool.Create(AOwner:TComponent);
begin
  inherited;
  FColor:=clBlack;
  FStyle:=fsFadeIn;
  FDelay:=100;
  FSpeed:=3;
end;

class function TFaderTool.Description: String;
begin
  result:=TeeMsg_Fader;
end;

Destructor TFaderTool.Destroy;
begin
  ITimer.Free;
  IDest.Free;
  inherited;
end;

procedure TFaderTool.DoTimer(Sender: TObject);
var tmpSource : TBitmap;
    tmpTransp : Double;
begin
  ITimer.Enabled:=False;

  tmpSource:=TTeeCanvas3D(ParentChart.Canvas).Bitmap;

  if (not Assigned(IDest)) or (IDest.Width<>tmpSource.Width) or
     (IDest.Height<>tmpSource.Height) then
  begin
    IDest.Free;
    IDest:=TBitmap.Create;
    IDest.PixelFormat:=TeePixelFormat;

    TeeSetBitmapSize(IDest,tmpSource.Width,tmpSource.Height);
  end;

  IDest.Canvas.Brush.Color:=Color;
  IDest.Canvas.FillRect(TeeRect(0,0,IDest.Width,IDest.Height));

  if Style=fsFadeIn then
     tmpTransp:=100-ITransp
  else
     tmpTransp:=ITransp;

  TeeBlendBitmaps(tmpTransp,tmpSource,IDest,TeePoint(0,0));
  ParentChart.Canvas.Draw(0,0,IDest);

  if ITransp<100 then
  begin
    if (ITransp+Speed)<100 then
       ITransp:=ITransp+Speed
    else
       ITransp:=100;

    if IInitial then
    begin
      if ITimer.Interval=1 then
         ITimer.Interval:=Max(1,InitialDelay)
      else
      begin
        IInitial:=False;
        ITimer.Interval:=1;
      end;
    end;

    ITimer.Enabled:=True;
  end
  else Stop;
end;

procedure TFaderTool.Stop;
begin
  ITimer.Enabled:=False;

  if Assigned(FOnStop) then
     FOnStop(Self);
end;

procedure TFaderTool.Start;
begin
  if not Assigned(ITimer) then
  begin
    ITimer:=TTimer.Create(Self);
    ITimer.Enabled:=False;
    ITimer.OnTimer:=DoTimer;
  end;

  ITransp:=0;
  IInitial:=True;
  ITimer.Interval:=1;
  ITimer.Enabled:=True;
end;

class function TFaderTool.GetEditorClass: String;
begin
  result:='TFaderEditor'; // Do not localize
end;

class function TFaderTool.LongDescription: String;
begin
  result:=TeeMsg_FaderDesc;
end;

{ TFaderEditor }

procedure TFaderEditor.FaderStop(Sender: TObject);
begin
  BStart.Enabled:=True;
  BReset.Enabled:=True;
end;

procedure TFaderEditor.FormShow(Sender: TObject);
begin
  Tool:=TFaderTool(Tag);

  if Assigned(Tool) then
  with Tool do
  begin
    OldOnStop:=OnStop;
    OnStop:=FaderStop;

    SBSpeed.Position:=Round(Speed*10);
    ButtonColor1.LinkProperty(Tool,'Color'); // Do not localize
    RGStyle.ItemIndex:=Ord(Style);
    UDDelay.Position:=InitialDelay;

    SetLabelSpeed;
  end;
end;

procedure TFaderEditor.SetLabelSpeed;
begin
  Label2.Caption:=FormatFloat('#.0',Tool.Speed); // Do not localize
end;

procedure TFaderEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(Tool) then
     Tool.OnStop:=OldOnStop;
end;

procedure TFaderEditor.BStartClick(Sender: TObject);
begin
  BStart.Enabled:=False;
  BReset.Enabled:=False;
  Tool.Start;
end;

procedure TFaderEditor.SBSpeedChange(Sender: TObject);
begin
  Tool.Speed:=SBSpeed.Position*0.1;
  SetLabelSpeed;
end;

procedure TFaderEditor.RGStyleClick(Sender: TObject);
begin
  Tool.Style:=TFaderStyle(RGStyle.ItemIndex);
end;

procedure TFaderEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     Tool.InitialDelay:=UDDelay.Position;
end;

procedure TFaderEditor.BResetClick(Sender: TObject);
begin
  Tool.Repaint;
end;

initialization
  RegisterClass(TFaderEditor);
  RegisterTeeTools([TFaderTool]);
finalization
  UnRegisterTeeTools([TFaderTool]);
end.
