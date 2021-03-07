{**********************************************}
{   TeeChart - Scrolling and blinking Banner   }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeBannerTool;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  {$ENDIF}
  TeEngine, TeeTools, TeeAnnToolEdit, TeCanvas, TeePenDlg, Chart;

type
  TScrollDirection=(sdRightLeft,sdLeftRight);

  TBannerTool=class(TAnnotationTool)
  private
    FBlinkOff  : Integer;
    FBlinkOn   : Integer;
    FScrollDir : TScrollDirection;

    IBlink  : TTimer;
    IDraw   : Boolean;
    IScroll : TTimer;
    IXPos   : Integer;

    procedure DoBlink(Sender:TObject);
    procedure DoScroll(Sender:TObject);
    function GetBlink: Boolean;
    function GetScroll: Boolean;
    function GetScrollDelay: Integer;
    procedure SetBlink(const Value: Boolean);
    procedure SetBlinkOff(const Value: Integer);
    procedure SetBlinkOn(const Value: Integer);
    procedure SetScroll(const Value: Boolean);
    procedure SetScrollDelay(const Value: Integer);
    procedure SetScrollDir(const Value: TScrollDirection);
  protected
    function GetXOffset:Integer; override;
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Blink:Boolean read GetBlink write SetBlink default False;
    property BlinkDelayOff:Integer read FBlinkOff write SetBlinkOff default 1000;
    property BlinkDelayOn:Integer read FBlinkOn write SetBlinkOn default 1000;
    property ScrollDelay:Integer read GetScrollDelay write SetScrollDelay default 50;
    property ScrollDirection:TScrollDirection read FScrollDir write SetScrollDir default sdRightLeft;
    property Scroll:Boolean read GetScroll write SetScroll default True;
  end;

  TBannerEditor = class(TAnnotationToolEdit)
    TabBanner: TTabSheet;
    CBScroll: TCheckBox;
    Label16: TLabel;
    Edit2: TEdit;
    UDDelay: TUpDown;
    CBBlink: TCheckBox;
    Label17: TLabel;
    Edit3: TEdit;
    UDBlinkOn: TUpDown;
    Label18: TLabel;
    Edit4: TEdit;
    UDBlinkOff: TUpDown;
    Label19: TLabel;
    CBDirection: TComboFlat;
    procedure CBScrollClick(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBBlinkClick(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure CBDirectionChange(Sender: TObject);
  private
    { Private declarations }
    Banner : TBannerTool;
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

Uses
  TeeProCo;

{ TBannerTool }
Constructor TBannerTool.Create(AOwner: TComponent);
begin
  inherited;
  FBlinkOn:=1000;
  FBlinkOff:=1000;

  IScroll:=TTimer.Create(nil);
  IScroll.Interval:=50;
  IScroll.OnTimer:=DoScroll;

  IBlink:=TTimer.Create(nil);
  IBlink.Enabled:=False;
  IBlink.Interval:=FBlinkOn;
  IBlink.OnTimer:=DoBlink;

  IDraw:=True;
end;

Destructor TBannerTool.Destroy;
begin
  IBlink.Free;
  IScroll.Free;
  inherited;
end;

procedure TBannerTool.DoBlink(Sender:TObject);
begin
  IBlink.Enabled:=False;
  IDraw:=not IDraw;

  if IDraw then
     IBlink.Interval:=FBlinkOn
  else
     IBlink.Interval:=FBlinkOff;

  Repaint;
  IBlink.Enabled:=True;
end;

procedure TBannerTool.DoScroll(Sender:TObject);
begin
  IScroll.Enabled:=False;

  if FScrollDir=sdRightLeft then
  begin
    Dec(IXPos,5);

    if IXPos<-2*Width then
       IXPos:=0;
  end
  else
  begin
    Inc(IXPos,5);

    if IXPos>2*Width then
       IXPos:=0;
  end;

  Repaint;

  IScroll.Enabled:=True;
end;

function TBannerTool.GetScrollDelay: Integer;
begin
  result:=IScroll.Interval;
end;

function TBannerTool.GetScroll: Boolean;
begin
  result:=IScroll.Enabled;
end;

procedure TBannerTool.SetScrollDelay(const Value: Integer);
begin
  IScroll.Interval:=Value;
end;

procedure TBannerTool.SetScroll(const Value: Boolean);
begin
  IScroll.Enabled:=Value;
  Repaint;
end;

function TBannerTool.GetXOffset:Integer;
begin
  if IScroll.Enabled then
     if FScrollDir=sdRightLeft then
        result:=Width+IXPos
     else
        result:=-(Width-IXPos)
  else
     result:=0;
end;

procedure TBannerEditor.CBScrollClick(Sender: TObject);
begin
  Banner.Scroll:=CBScroll.Checked;
end;

procedure TBannerEditor.Edit2Change(Sender: TObject);
begin
  if Showing and Assigned(Banner) then
     Banner.ScrollDelay:=UDDelay.Position;
end;

procedure TBannerEditor.FormShow(Sender: TObject);
begin
  inherited;

  Banner:=TBannerTool(Tag);

  if Assigned(Banner) then
  with Banner do
  begin
    CBScroll.Checked:=Scroll;
    UDDelay.Position:=ScrollDelay;
    CBBlink.Checked:=Blink;
    UDBlinkOn.Position:=BlinkDelayOn;
    UDBlinkOff.Position:=BlinkDelayOff;
    CBDirection.ItemIndex:=Ord(ScrollDirection);
  end;

  TabBanner.PageIndex:=0;
  PageControl1.ActivePage:=TabBanner;
end;

class function TBannerTool.GetEditorClass: String;
begin
  result:='TBannerEditor'; // Do not localize
end;

procedure TBannerEditor.CBBlinkClick(Sender: TObject);
begin
  Banner.Blink:=CBBlink.Checked;
end;

function TBannerTool.GetBlink: Boolean;
begin
  result:=IBlink.Enabled;
end;

procedure TBannerTool.SetBlink(const Value: Boolean);
begin
  IBlink.Enabled:=Value;
  Repaint;
end;

procedure TBannerTool.SetBlinkOn(const Value: Integer);
begin
  SetIntegerProperty(FBlinkOn,Value);
end;

procedure TBannerTool.ChartEvent(AEvent: TChartToolEvent);
begin
  if IDraw then
     inherited;
end;

procedure TBannerEditor.Edit3Change(Sender: TObject);
begin
  if Showing and Assigned(Banner) then
     Banner.BlinkDelayOn:=UDBlinkOn.Position;
end;

procedure TBannerEditor.Edit4Change(Sender: TObject);
begin
  if Showing and Assigned(Banner) then 
     Banner.BlinkDelayOff:=UDBlinkOff.Position;
end;

procedure TBannerTool.Assign(Source: TPersistent);
begin
  if Source is TBannerTool then
  with TBannerTool(Source) do
  begin
    Self.FBlinkOff:=FBlinkOff;
    Self.FBlinkOn:=FBlinkOn;
    Self.FScrollDir:=FScrollDir;

    Self.IBlink.Enabled:=IBlink.Enabled;
    Self.IScroll.Enabled:=IScroll.Enabled;
    Self.IScroll.Interval:=IScroll.Interval;
  end;

  inherited;
end;

class function TBannerTool.Description: String;
begin
  result:=TeeMsg_BannerTool;
end;

class function TBannerTool.LongDescription: String;
begin
  result:=TeeMsg_BannerToolDesc;
end;

procedure TBannerTool.SetBlinkOff(const Value: Integer);
begin
  SetIntegerProperty(FBlinkOff,Value);
end;

procedure TBannerEditor.CBDirectionChange(Sender: TObject);
begin
  if CBDirection.ItemIndex=0 then
     Banner.ScrollDirection:=sdRightLeft
  else
     Banner.ScrollDirection:=sdLeftRight;
end;

procedure TBannerTool.SetScrollDir(const Value: TScrollDirection);
begin
  if FScrollDir<>Value then
  begin
    FScrollDir:=Value;
    IXPos:=0;
    Repaint;
  end;
end;

initialization
  RegisterClass(TBannerEditor);
  RegisterTeeTools([TBannerTool]);
finalization
  UnRegisterTeeTools([TBannerTool]);
end.
