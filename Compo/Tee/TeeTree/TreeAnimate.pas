{**********************************************}
{   TTreeAnimate Component                     }
{   Copyright (c) 2001-2009 by David Berneda   }
{**********************************************}
{$I TeeDefs.inc}
unit TreeAnimate;

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  {$IFDEF CLX}
  QExtCtrls, QGraphics,
  {$ELSE}
  ExtCtrls, Graphics,
  {$ENDIF}
  {$IFDEF CLR}
  System.ComponentModel,
  {$ENDIF}
  Classes, SysUtils, TeeProcs, TeeTree;

type
  TAnimationState=(asStopped, asPlaying, asPaused);

  TTreeAnimate=class; { forward }

  {$IFDEF CLR}
  [ToolBoxItem(False)]
  {$ENDIF}
  TAnimation=class(TComponent)
  private
    FDuration   : Integer;
    FEnabled    : Boolean;
    FLoop       : Boolean;
    FOnFrame    : TNotifyEvent;
    FStartFrame : Integer;

    ICurrentFrame : Integer;
  protected
    IAnimate    : TTreeAnimate;
    IPlaying    : TAnimationState;

    Procedure EndAnimation; virtual;
    Procedure NewNode; dynamic;
    Procedure NextFrame; virtual;
    Procedure StoreValue; virtual;

    Function GetOwner:TPersistent; override;
    procedure ReadState(Reader: TReader); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; virtual;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    Function Index:Integer;
    Function IsEnabled:Boolean; dynamic;

    property Animate:TTreeAnimate read IAnimate;
    procedure Continue; virtual;
    Function EndFrame:Integer;
    Procedure Pause; virtual;
    Procedure Play; virtual;
    Procedure Preview; dynamic;
    Procedure Stop; virtual;
  published
    property Duration:Integer read FDuration write FDuration default 10;
    property Enabled:Boolean read FEnabled write FEnabled default True;
    property Loop:Boolean read FLoop write FLoop default False;
    property StartFrame:Integer read FStartFrame write FStartFrame;

    property OnFrame:TNotifyEvent read FOnFrame write FOnFrame;
  end;

  TAnimationClass=class of TAnimation;

  TAnimations=class(TList)
  private
    IAnimate : TTreeAnimate;
    Function Get(Index:Integer):TAnimation;
    Procedure Put(Index:Integer; Const Value:TAnimation);
  public
    Destructor Destroy; override;

    Procedure Add(Animation:TAnimation);
    Procedure Clear; override;

    property Animate:TTreeAnimate read IAnimate;
    property Animation[Index:Integer]:TAnimation read Get write Put; default;
  end;

  TTreeAnimateEvents=packed record
    Continue : TNotifyEvent;
    Frame    : TNotifyEvent;
    Stop     : TNotifyEvent;
    Pause    : TNotifyEvent;
    Play     : TNotifyEvent;
  end;

  TTreeAnimate = class(TCustomTreeLink)
  private
    FAnimations : TAnimations;
    FLoop       : Boolean;
    FSpeed      : Integer;
    FState      : TAnimationState;

    FOnClear    : TNotifyEvent;
    FOnContinue : TNotifyEvent;
    FOnDeleted  : TNotifyEvent;
    FOnFrame    : TNotifyEvent;
    FOnPause    : TNotifyEvent;
    FOnPlay     : TNotifyEvent;
    FOnStop     : TNotifyEvent;

    IEndFrame   : Integer;
    ITimer      : TTimer;

    { Private declarations }
    function GetEndFrame: Integer;
    procedure InternalStop;
    procedure SetSpeed(const Value: Integer);
    Procedure SetTimerInterval;
    Procedure OnTimer(Sender: TObject);
  protected
    { Protected declarations }
    Procedure GetChildren(Proc:TGetChildProc; Root:TComponent); override;
    function GetChildOwner: TComponent; override;
    property OnDeleteShapes:TNotifyEvent read FOnDeleted write FOnDeleted;

  {$IFDEF CLR}
  public
  {$ENDIF}
    Procedure RestoreEvents(Const AnimateEvents:TTreeAnimateEvents);
    Procedure SaveEvents(Var AnimateEvents:TTreeAnimateEvents);
  public
    { Public declarations }
    CurrentFrame: Integer;

    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    Procedure Continue;
    Procedure NextFrame;
    Procedure Pause;
    Procedure Play;
    Procedure Stop;

    property EndFrame:Integer read GetEndFrame;
  published
    { Published declarations }
    property Animations:TAnimations read FAnimations;
    property Loop:Boolean read FLoop write FLoop default False;
    property Speed:Integer read FSpeed write SetSpeed default 50;
    property State:TAnimationState read FState;

    property OnClear:TNotifyEvent read FOnClear write FOnClear;
    property OnContinue:TNotifyEvent read FOnContinue write FOnContinue;
    property OnFrame:TNotifyEvent read FOnFrame write FOnFrame;
    property OnPause:TNotifyEvent read FOnPause write FOnPause;
    property OnPlay:TNotifyEvent read FOnPlay write FOnPlay;
    property OnStop:TNotifyEvent read FOnStop write FOnStop;
  end;

  TNodeAnimation=class(TAnimation)
  private
    FNode : TTreeNodeShape;
    procedure SetNode(const ANode:TTreeNodeShape);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    Function IsEnabled:Boolean; override;
    Procedure Preview; override;

    property Node:TTreeNodeShape read FNode write SetNode;
  end;

  TIntegerAnimation=class(TNodeAnimation)
  private
    FEndValue   : Integer;
    FStartValue : Integer;

    OldValue    : Integer;
    Procedure SetEndValue(const Value:Integer);
  protected
    Procedure EndAnimation; override;
    Function GetValue:Integer; virtual; abstract;
    Procedure NewNode; override;
    Procedure NextFrame; override;
    Procedure SetValue(AValue:Integer); virtual; abstract;
    Procedure StoreValue; override;
  public
    Procedure Play; override;
    property Value:Integer read GetValue write SetValue;
  published
    property EndValue:Integer read FEndValue write SetEndValue default 0;
    property Node;
    property StartValue:Integer read FStartValue write FStartValue default 0;
  end;

  TFontSizeAnimation=class(TIntegerAnimation)
  protected
    Function GetValue:Integer; override;
    Procedure SetValue(AValue:Integer); override;
  public
    Procedure Preview; override;
  end;

  TMoveSizeDirection=(mdHorizontal, mdVertical);

  TMovementAnimation=class(TIntegerAnimation)
  private
    FDirection : TMoveSizeDirection;
  protected
    Function GetValue:Integer; override;
    Procedure SetValue(AValue:Integer); override;
  public
    Procedure Preview; override;
  published
    property Direction:TMoveSizeDirection read FDirection write FDirection;
  end;

  TTransparencyAnimation=class(TIntegerAnimation)
  protected
    Function GetValue:Integer; override;
    Procedure SetValue(AValue:Integer); override;
  public
    Procedure Preview; override;
  end;

  TTextTranspAnimation=class(TIntegerAnimation)
  protected
    Function GetValue:Integer; override;
    Procedure SetValue(AValue:Integer); override;
  public
    Procedure Preview; override;
  end;

  TSizeAnimation=class(TIntegerAnimation)
  private
    FDirection : TMoveSizeDirection;
  protected
    Function GetValue:Integer; override;
    Procedure SetValue(AValue:Integer); override;
  published
    property Direction:TMoveSizeDirection read FDirection write FDirection;
  end;

  TBooleanAnimation=class(TNodeAnimation)
  private
    FNewValue : Boolean;
    OldValue  : Boolean;
  protected
    Procedure EndAnimation; override;
    Function GetValue:Boolean; virtual; abstract;
    Procedure NewNode; override;
    Procedure NextFrame; override;
    Procedure SetValue(AValue:Boolean); virtual; abstract;
    Procedure StoreValue; override;
  public
    property Value:Boolean read GetValue write SetValue;
  published
    property NewValue:Boolean read FNewValue write FNewValue;
    property Node;
  end;

  TVisibleAnimation=class(TBooleanAnimation)
  protected
    Function GetValue:Boolean; override;
    Procedure SetValue(AValue:Boolean); override;
  public
    Procedure Stop; override;
  end;

  TColorAnimation=class(TNodeAnimation)
  private
    FEndColor   : TColor;
    FStartColor : TColor;

    OldColor    : TColor;
  protected
    Procedure EndAnimation; override;
    Function GetColor:TColor; virtual; abstract;
    Procedure NewNode; override;
    Procedure NextFrame; override;
    Procedure SetColor(AColor:TColor); virtual; abstract;
    Procedure StoreValue; override;
  public
    Constructor Create(AOwner: TComponent); override;

    Procedure Play; override;
    property Value:TColor read GetColor write SetColor;
  published
    property EndColor:TColor read FEndColor write FEndColor default clNone;
    property StartColor:TColor read FStartColor write FStartColor default clNone;
  end;

  TNodeColor=(ncColor,ncBorder,ncFont,ncGradientStart,ncGradientEnd,ncGradientMiddle);

  TNodeColorAnimation=class(TColorAnimation)
  private
    FColor : TNodeColor;
  protected
    Function GetColor:TColor; override;
    Procedure SetColor(AColor:TColor); override;
  public
    Procedure Preview; override;
  published
    property Node;
    property NodeColor:TNodeColor read FColor write FColor default ncColor;
  end;

  TTreeColor=(tcColor,tcGrid,tcGradientStart,tcGradientEnd,tcGradientMiddle);

  TTreeColorAnimation=class(TColorAnimation)
  private
    FColor : TTreeColor;
  protected
    Function GetColor:TColor; override;
    Procedure SetColor(AColor:TColor); override;
  public
    Function IsEnabled:Boolean; override;
    Procedure Preview; override;
  published
    property TreeColor:TTreeColor read FColor write FColor;
  end;

  TCustomAnimation=class(TAnimation);

  TAddTextAnimation=class(TNodeAnimation)
  private
    OldText : String;
  protected
    Procedure EndAnimation; override;
    Procedure NextFrame; override;
    Procedure StoreValue; override;
  public
    Procedure Play; override;
    Procedure Preview; override;
  published
    property Node;
  end;

  TMoveTextAnimation=class(TNodeAnimation)
  private
    OldOffset : Integer;
  protected
    Procedure EndAnimation; override;
    Procedure NextFrame; override;
    Procedure StoreValue; override;
  public
    Procedure Play; override;
  published
    property Node;
  end;

  TTextAngleAnimation=class(TIntegerAnimation)
  protected
    Function GetValue:Integer; override;
    Procedure SetValue(AValue:Integer); override;
  public
    Procedure Preview; override;
  end;

  TTextFlashAnimation=class(TNodeAnimation)
  private
    OldSize      : Integer;
    StartSize    : Integer;
    FSizePercent : Integer;
  protected
    Procedure EndAnimation; override;
    Procedure NextFrame; override;
    Procedure StoreValue; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Procedure Play; override;
  published
    property Node;
    property SizePercent:Integer read FSizePercent write FSizePercent default 100;
  end;

  TTextColorAnimation=class(TColorAnimation)
  protected
    Function GetColor:TColor; override;
    Procedure SetColor(AColor:TColor); override;
  public
    Procedure Preview; override;
  published
    property Node;
  end;

  TNodeZoomAnimation=class(TNodeAnimation)
  private
    FZoomPercent : Integer;
    OldBounds    : TRect;
    Procedure SetNodeBounds(Const R:TRect);
  protected
    Procedure EndAnimation; override;
    Procedure NextFrame; override;
    Procedure StoreValue; override;
  public
    Constructor Create(AOwner: TComponent); override;
    Procedure Preview; override;
  published
    property Node;
    property ZoomPercent:Integer read FZoomPercent write FZoomPercent default 100;
  end;

const //tom:13/09/2002
  MoveSizeDirection: Array[TMoveSizeDirection] of String =('Horizontal','Vertical');
  NodeColor: Array[TNodeColor] of String = ('Color', 'Border', 'Font',
                                            'GradientStart', 'GradientEnd',
                                            'GradientMiddle');
  TreeColor: Array[TTreeColor] of String = ('Color', 'Grid',
                                            'GradientStart', 'GradientEnd',
                                            'GradientMiddle');


Procedure RegisterAnimation(Animation:TAnimationClass);

var AnimationClasses : TList;

implementation

Uses TeCanvas;

{ TTreeAnimate }

Constructor TTreeAnimate.Create(AOwner: TComponent);
begin
  inherited;
  FAnimations:=TAnimations.Create;
  FAnimations.IAnimate:=Self;
  FSpeed:=50;
end;

Destructor TTreeAnimate.Destroy;
begin
  Stop;
  FAnimations.Free;
  inherited;
end;

// Returns the biggest frame number
// (The longest StartFrame + Duration of all Enabled actions)
function TTreeAnimate.GetEndFrame: Integer;
var t : Integer;
begin
  result:=0;
  for t:=0 to Animations.Count-1 do
  with Animations[t] do
       if EndFrame>result then result:=EndFrame;
end;

procedure TTreeAnimate.Pause;  // pause playing
var t: Integer;
begin
  if Assigned(ITimer) then ITimer.Enabled:=False;
  for t:=0 to Animations.Count-1 do Animations[t].Pause;
  FState:=asPaused;

  if Assigned(FOnPause) then FOnPause(Self);
end;

procedure TTreeAnimate.Continue; // resumes playing
var t: Integer;
begin
  for t:=0 to Animations.Count-1 do Animations[t].Continue;
  FState:=asPlaying;

  if Assigned(FOnContinue) then FOnContinue(Self);

  if Assigned(ITimer) then ITimer.Enabled:=True;
end;

procedure TTreeAnimate.Play;  // start playing
var t : Integer;
begin
  if FState<>asPlaying then
  begin
    CurrentFrame:=-1;

    if not Assigned(ITimer) then
    begin
      ITimer:=TTimer.Create(nil);
      ITimer.Enabled:=False;
      ITimer.OnTimer:=OnTimer;
    end;

    SetTimerInterval;

    if Animations.Count>0 then
    begin
      for t:=0 to Animations.Count-1 do
      with Animations[t] do
           if IsEnabled then StoreValue;

      IEndFrame:=GetEndFrame;

      FState:=asPlaying;

      if Assigned(FOnPlay) then FOnPlay(Self);

      ITimer.Enabled:=True;
    end;
  end;
end;

Procedure TTreeAnimate.SetTimerInterval; // set internal timer interval
begin
  ITimer.Interval:=10000 div (FSpeed*FSpeed); // speed
end;

Procedure TTreeAnimate.NextFrame;  // process one single frame
begin
  if FState<>asStopped then
  begin
    // process next frame
    OnTimer(ITimer);

    // just in case it was the last frame and the Loop = True, do pause
    if FState<>asPaused then Pause;
  end;
end;

// Every frame is processed here, when the Timer triggers
Procedure TTreeAnimate.OnTimer(Sender: TObject);
var t : Integer;
begin
  Inc(CurrentFrame);

  for t:=0 to Animations.Count-1 do
  with Animations[t] do
  if IsEnabled then
  begin
    ICurrentFrame:=CurrentFrame;

    if StartFrame=ICurrentFrame then Play
    else
    if (ICurrentFrame>StartFrame) and (ICurrentFrame<=(EndFrame+1)) then
    begin
      NextFrame;
      if ICurrentFrame>EndFrame then
      begin
        Stop;
        if Loop then Play;
      end;
    end;
  end;

  if Assigned(FOnFrame) then FOnFrame(Self);

  // Last Frame ?
  if CurrentFrame>IEndFrame then
  begin
    // Stop animation
    InternalStop;

    // if loop, re-start again
    if FLoop then Play;
  end;
end;

procedure TTreeAnimate.InternalStop;
var t : Integer;
begin
  FreeAndNil(ITimer);
  CurrentFrame:=-1;

  if FState<>asStopped then
     for t:=0 to Animations.Count-1 do
     with Animations[t] do
     if IsEnabled then
     begin
       Stop;
       EndAnimation;
     end;

  FState:=asStopped;

  if (not (csDestroying in ComponentState)) then
     if Assigned(FOnStop) then FOnStop(Self);
end;

procedure TTreeAnimate.Stop; // stop playing
begin
  InternalStop;
end;

// Change animation speed
procedure TTreeAnimate.SetSpeed(const Value: Integer);
begin
  if FSpeed<>Value then
  begin
    FSpeed:=Value;

    // if playing, change timer interval
    if Assigned(ITimer) then SetTimerInterval;
  end;
end;

function TTreeAnimate.GetChildOwner: TComponent;
begin
  result:=Owner;
end;

procedure TTreeAnimate.GetChildren(Proc: TGetChildProc; Root: TComponent);
var t : Integer;
begin
  inherited;
  for t:=0 to Animations.Count-1 do Proc(Animations[t]);
end;

procedure TTreeAnimate.SaveEvents(var AnimateEvents: TTreeAnimateEvents);
begin
  with AnimateEvents do
  begin
    Continue :=Self.FOnContinue;
    Frame    :=Self.FOnFrame;
    Stop     :=Self.FOnStop;
    Pause    :=Self.FOnPause;
    Play     :=Self.FOnPlay;
  end;
end;

procedure TTreeAnimate.RestoreEvents(
  const AnimateEvents: TTreeAnimateEvents);
begin
  with AnimateEvents do
  begin
    Self.FOnContinue :=Continue;
    Self.FOnFrame    :=Frame;
    Self.FOnStop     :=Stop;
    Self.FOnPause    :=Pause;
    Self.FOnPlay     :=Play;
  end;
end;

{ TAnimations }

procedure TAnimations.Add(Animation: TAnimation);
begin
  Animation.IAnimate:=IAnimate;
  inherited Add(Animation);
end;

procedure TAnimations.Clear;
begin
  inherited;
  if Assigned(Animate.OnClear) then
     if (not (csDestroying in Animate.ComponentState)) then
        Animate.OnClear(Animate);
end;

destructor TAnimations.Destroy;
begin
//  While Count>0 do Animation[0].Free;
  inherited;
end;

function TAnimations.Get(Index: Integer): TAnimation;
begin
  result:=TAnimation(Items[Index]);
end;

procedure TAnimations.Put(Index: Integer; const Value: TAnimation);
begin
  TAnimation(Items[Index]).Assign(Value);
end;

{ TAnimation }

Constructor TAnimation.Create(AOwner:TComponent);
begin
  inherited {$IFDEF CLR}Create(AOwner){$ENDIF};
  FDuration:=10;
  FEnabled:=True;
end;

// Execute next frame
procedure TAnimation.NextFrame;
begin
  if Assigned(FOnFrame) then FOnFrame(Self);
end;

procedure TAnimation.Pause; // pause individual action
begin
  if IPlaying=asPlaying then IPlaying:=asPaused;
end;

procedure TAnimation.Play; // initialize action
begin
  IPlaying:=asPlaying;
end;

procedure TAnimation.Stop; // stop individual action
begin
  IPlaying:=asStopped;
end;

procedure TAnimation.Continue; // resume playing individual action
begin
  if IPlaying=asPaused then IPlaying:=asPlaying;
end;

function TAnimation.GetOwner: TPersistent;
begin
  if csWriting in ComponentState then
     result:=Self
  else
     result:=inherited GetOwner;
end;

procedure TAnimation.ReadState(Reader: TReader);
begin
  inherited;
  if Reader.Parent is TTreeAnimate then
  begin
    IAnimate:=TTreeAnimate(Reader.Parent);
    IAnimate.Animations.Add(Self);
  end;
end;

function TAnimation.GetParentComponent: TComponent;
begin
  result:=IAnimate;
end;

function TAnimation.HasParent: Boolean;
begin
  result:=True;
end;

procedure TAnimation.StoreValue;
begin
end;

procedure TAnimation.NewNode;
begin
end;

function TAnimation.Index: Integer;
begin
  result:=IAnimate.Animations.IndexOf(Self);
end;

procedure TAnimation.EndAnimation;
begin
end;

class function TAnimation.Description: String;
var s : String;
    t : Integer;
begin
  result:=ClassName;
  if Length(result)>0 then
  begin
    if result[1]='T' then Delete(result,1,1);
    if UpperCase(Copy(result,Length(result)-8,9))='ANIMATION' then
       Delete(result,Length(result)-8,9);
    s:=result[1];
    for t:=2 to Length(result) do
    begin
      if UpCase(result[t])=result[t] then
         s:=s+' ';
      s:=s+result[t];
    end;
    result:=s;
  end;
end;

function TAnimation.IsEnabled: Boolean;
begin
  result:=FEnabled;
end;

Destructor TAnimation.Destroy;
begin
  if Assigned(IAnimate) then
     IAnimate.Animations.Remove(Self);
  inherited;
end;

function TAnimation.EndFrame: Integer;
begin
  result:=StartFrame+Duration-1;
end;

procedure TAnimation.Preview;
begin
  // nothing
end;

{ TNodeAnimation }

procedure TNodeAnimation.SetNode(const ANode: TTreeNodeShape);
begin
  if FNode<>ANode then
  begin
    {$IFDEF D5}
    if Assigned(FNode) then
       FNode.RemoveFreeNotification(Self);
    {$ENDIF}

    FNode:=ANode;

    if Assigned(FNode) then FNode.FreeNotification(Self);
  end;
end;

procedure TNodeAnimation.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if not (csDestroying in ComponentState) then 
  if Operation=opRemove then
  begin
    if Assigned(FNode) and (AComponent=FNode) then
    begin
      // Node has been destroyed. Set Action Node to nil.
      FNode:=nil;

      // Call event
      if Assigned(IAnimate.FOnDeleted) then IAnimate.FOnDeleted(AComponent);
    end;
  end;
end;

function TNodeAnimation.IsEnabled: Boolean;
begin
  result:=inherited IsEnabled and Assigned(FNode);
end;

procedure TNodeAnimation.Preview;
begin
  // Do not call abstract "inherited" here
  Node:=Animate.Tree[0];
end;

{ TFontSizeAnimation }

procedure TFontSizeAnimation.SetValue(AValue: Integer);
begin
  Node.Font.Size:=AValue;
end;

function TFontSizeAnimation.GetValue: Integer;
begin
  result:=Node.Font.Size;
end;

procedure TFontSizeAnimation.Preview;
begin
  inherited;
  FStartValue:=Node.Font.Size;
  FEndValue:=Node.Font.Size*2;
end;

{ TMovementAnimation }

procedure TMovementAnimation.SetValue(AValue: Integer);
begin
  Case FDirection of
    mdHorizontal : Node.Left:=AValue;
    mdVertical   : Node.Top:=AValue;
  end;
end;

function TMovementAnimation.GetValue: Integer;
begin
  if FDirection=mdHorizontal then result:=Node.Left
                             else result:=Node.Top;
end;

procedure TMovementAnimation.Preview;
begin
  inherited;
  Node.Tree.HorzScrollBar.Automatic:=False;

  with Node.Border do
  begin
    Visible:=True;
    Width:=2;
    EndStyle:=esFlat;
  end;

  FStartValue:=Node.Tree.Width;
  FEndValue:=-Node.Width-Node.Border.Width;

  Animate.Speed:=10;
end;

{ TIntegerAnimation }

procedure TIntegerAnimation.NextFrame;
var tmp : Integer;
begin
  tmp:=StartValue+Round((ICurrentFrame-StartFrame)*(EndValue-StartValue)/Duration);

  Value:=tmp;

  if EndValue>=StartValue then
  begin
    if tmp>=FEndValue then Stop;
  end
  else
    if tmp<=FEndValue then Stop;

  inherited;
end;

procedure TIntegerAnimation.Play;
begin
  if IPlaying=asStopped then Value:=FStartValue;
  inherited;
end;

procedure TIntegerAnimation.EndAnimation;
begin
  if not (csDestroying in ComponentState) then
     Value:=OldValue;
  inherited;
end;

Procedure TIntegerAnimation.NewNode;
begin
  if Assigned(IAnimate) and (not (csLoading in IAnimate.ComponentState)) then
  if Assigned(Node) then 
  begin
    if FStartValue=0 then FStartValue:=Value;
    if FEndValue=0 then FEndValue:=Value;
  end;
end;

procedure TIntegerAnimation.StoreValue;
begin
  inherited;
  OldValue:=Value;
end;

Procedure RegisterAnimation(Animation:TAnimationClass);
begin
  RegisterClass(Animation);
  AnimationClasses.Add(TObject(Animation));
end;

procedure TIntegerAnimation.SetEndValue(const Value: Integer);
begin
  FEndValue:=Value;
end;

{ TTransparencyAnimation }

procedure TTransparencyAnimation.SetValue(AValue: Integer);
begin
  Node.Transparency:=AValue;
end;

function TTransparencyAnimation.GetValue: Integer;
begin
  result:=Node.Transparency;
end;

procedure TTransparencyAnimation.Preview;
begin
  inherited;
  Node.Transparent:=False;
  Node.Color:=clYellow;
  FStartValue:=0;
  FEndValue:=100;
end;

{ TSizeAnimation }

procedure TSizeAnimation.SetValue(AValue: Integer);
begin
  Case FDirection of
    mdHorizontal : Node.Width:=AValue;
    mdVertical   : Node.Height:=AValue;
  end;
end;

function TSizeAnimation.GetValue: Integer;
begin
  if FDirection=mdHorizontal then result:=Node.Width
                             else result:=Node.Height;
end;

{ TBoolAnimation }

procedure TBooleanAnimation.NewNode;
begin
  if Assigned(IAnimate) and (not (csLoading in IAnimate.ComponentState)) then
     FNewValue:=not Value;
end;

procedure TBooleanAnimation.NextFrame;
begin
  Value:=NewValue;
  inherited;
end;

procedure TBooleanAnimation.EndAnimation;
begin
  if not (csDestroying in ComponentState) then
     Value:=OldValue;
  inherited;
end;

procedure TBooleanAnimation.StoreValue;
begin
  inherited;
  OldValue:=Value;
end;

{ TVisibleAnimation }

function TVisibleAnimation.GetValue: Boolean;
begin
  result:=Node.Visible;
end;

procedure TVisibleAnimation.SetValue(AValue: Boolean);
begin
  Node.Visible:=AValue;
end;

procedure TVisibleAnimation.Stop;
begin
  Value:=OldValue;
  inherited;
end;

{ TColorAnimation }

constructor TColorAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FStartColor:=clNone;
  FEndColor:=clNone;
end;

procedure TColorAnimation.EndAnimation;
begin
  if not (csDestroying in ComponentState) then
     Value:=OldColor;
  inherited;
end;

procedure TColorAnimation.NewNode;
begin
  if Assigned(IAnimate) and (not (csLoading in IAnimate.ComponentState)) then
  if Assigned(Node) then 
  begin
    if FStartColor=clNone then FStartColor:=Value;
    if FEndColor=clNone then FEndColor:=Value;
  end;
end;

procedure TColorAnimation.NextFrame;
var tmp0      : TRGB;
    tmp1      : TRGB;
    tmp       : TColor;
    tmpFactor : Double;
begin
  tmp0:=RGBValue(StartColor);
  tmp1:=RGBValue(EndColor);

  tmpFactor:=(ICurrentFrame-StartFrame)/Duration;
  tmp0.Red:=tmp0.Red+Round(tmpFactor*(tmp1.Red-tmp0.Red));
  tmp0.Green:=tmp0.Green+Round(tmpFactor*(tmp1.Green-tmp0.Green));
  tmp0.Blue:=tmp0.Blue+Round(tmpFactor*(tmp1.Blue-tmp0.Blue));

  tmp:=RGB(tmp0.Red,tmp0.Green,tmp0.Blue);
  Value:=tmp;

  if EndColor>=StartColor then
  begin
    if tmp>=FEndColor then Stop;
  end
  else
    if tmp<=FEndColor then Stop;

  inherited;
end;

procedure TColorAnimation.Play;
begin
  if IPlaying=asStopped then Value:=FStartColor;
  inherited;
end;

procedure TColorAnimation.StoreValue;
begin
  inherited;
  OldColor:=Value;
end;

{ TNodeColorAnimation }

function TNodeColorAnimation.GetColor: TColor;
begin
  if Assigned(Node) then
  Case FColor of
    ncColor          : result:=Node.Color;
    ncBorder         : result:=Node.Border.Color;
    ncFont           : result:=Node.Font.Color;
    ncGradientStart  : result:=Node.Gradient.StartColor;
    ncGradientEnd    : result:=Node.Gradient.EndColor;
  else
    {ncGradientMiddle :} result:=Node.Gradient.MidColor;
  end
  else result:=clWhite;
end;

procedure TNodeColorAnimation.Preview;
begin
  inherited;
  Node.Transparent:=False;
  FStartColor:=Node.Color;
  FEndColor:=clRed;
end;

procedure TNodeColorAnimation.SetColor(AColor: TColor);
begin
  Case FColor of
    ncColor          : Node.Color:=AColor;
    ncBorder         : Node.Border.Color:=AColor;
    ncFont           : Node.Font.Color:=AColor;
    ncGradientStart  : Node.Gradient.StartColor:=AColor;
    ncGradientEnd    : Node.Gradient.EndColor:=AColor;
    ncGradientMiddle : Node.Gradient.MidColor:=AColor;
  end;
end;

{ TTreeColorAnimation }

function TTreeColorAnimation.GetColor: TColor;
begin
  Case FColor of
    tcColor          : result:=IAnimate.Tree.Color;
    tcGrid           : result:=IAnimate.Tree.Grid.Color;
    tcGradientStart  : result:=IAnimate.Tree.Gradient.StartColor;
    tcGradientEnd    : result:=IAnimate.Tree.Gradient.EndColor;
  else
    {tcGradientMiddle :} result:=IAnimate.Tree.Gradient.MidColor;
  end;
end;

function TTreeColorAnimation.IsEnabled: Boolean;
begin
  result:=FEnabled;
end;

procedure TTreeColorAnimation.Preview;
begin
  inherited;
  FStartColor:=IAnimate.Tree.Color;
  FEndColor:=clWhite;
end;

procedure TTreeColorAnimation.SetColor(AColor: TColor);
begin
  Case FColor of
    tcColor          : IAnimate.Tree.Color:=AColor;
    tcGrid           : IAnimate.Tree.Grid.Color:=AColor;
    tcGradientStart  : IAnimate.Tree.Gradient.StartColor:=AColor;
    tcGradientEnd    : IAnimate.Tree.Gradient.EndColor:=AColor;
    tcGradientMiddle : IAnimate.Tree.Gradient.MidColor:=AColor;
  end;
end;

{ TAddTextAnimation }

procedure TAddTextAnimation.EndAnimation;
begin
  Node.SimpleText:=OldText;
  inherited;
end;

procedure TAddTextAnimation.NextFrame;
var tmp0 : Integer;
    tmp1 : Integer;
begin
  tmp1:=Length(OldText);
  tmp0:=Round((ICurrentFrame-StartFrame)*tmp1/Duration);

  Node.SimpleText:=Copy(OldText,1,tmp0);
  if Node.SimpleText=OldText then Stop;
  inherited;
end;

procedure TAddTextAnimation.Play;
begin
  if IPlaying=asStopped then Node.SimpleText:='';
  inherited;
end;

procedure TAddTextAnimation.Preview;
begin
  inherited;
  Node.Text.HorizAlign:=htaLeft;
end;

procedure TAddTextAnimation.StoreValue;
begin
  inherited;
  OldText:=Node.SimpleText;
  Node.SimpleText:='';
end;

{ TMoveTextAnimation }

procedure TMoveTextAnimation.EndAnimation;
begin
  Node.Text.HorizOffset:=OldOffset;
  inherited;
end;

procedure TMoveTextAnimation.NextFrame;
var tmp0 : Integer;
begin
  tmp0:=Round((ICurrentFrame-StartFrame)*(2*Node.Width)/Duration);

  Node.Text.HorizOffset:=Node.Width-tmp0;

  if tmp0>100 then Stop;
  inherited;
end;

procedure TMoveTextAnimation.Play;
begin
  if IPlaying=asStopped then Node.Text.HorizOffset:=Node.Width;
  inherited;
end;

procedure TMoveTextAnimation.StoreValue;
begin
  OldOffset:=Node.Text.HorizOffset;
  Node.Text.ClipText:=True;
  inherited;
end;

{ TTextAngleAnimation }

function TTextAngleAnimation.GetValue: Integer;
begin
  result:=Node.Text.Angle;
end;

procedure TTextAngleAnimation.Preview;
begin
  inherited;
  FStartValue:=0;
  FEndValue:=360;
end;

procedure TTextAngleAnimation.SetValue(AValue: Integer);
begin
  Node.Text.Angle:=AValue;
end;

{ TTextTranspAnimation }

function TTextTranspAnimation.GetValue: Integer;
begin
  result:=Node.Text.Transparency;
end;

procedure TTextTranspAnimation.Preview;
begin
  inherited;
  FStartValue:=0;
  FEndValue:=100;
end;

procedure TTextTranspAnimation.SetValue(AValue: Integer);
begin
  Node.Text.Transparency:=AValue;
end;

{ TTextFlashAnimation }

constructor TTextFlashAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FSizePercent:=100;
end;

procedure TTextFlashAnimation.EndAnimation;
begin
  Node.Font.Size:=OldSize;
  inherited;
end;

procedure TTextFlashAnimation.NextFrame;
var tmp : Integer;
    MaxSize : Integer;
begin
  MaxSize:=StartSize+Round(StartSize*SizePercent/50.0);

  if (ICurrentFrame-StartFrame)>Duration div 2 then
     tmp:=MaxSize-Round((ICurrentFrame-StartFrame)*(MaxSize-StartSize)/Duration)
  else
     tmp:=StartSize+Round((ICurrentFrame-StartFrame)*(MaxSize-StartSize)/Duration);

  Node.Font.Size:=tmp;

  if ICurrentFrame>=EndFrame then Stop;
  inherited;
end;

procedure TTextFlashAnimation.Play;
begin
  if IPlaying=asStopped then StartSize:=Node.Font.Size;
  inherited;
end;

procedure TTextFlashAnimation.StoreValue;
begin
  OldSize:=Node.Font.Size;
  inherited;
end;

{ TTextColorAnimation }

function TTextColorAnimation.GetColor: TColor;
begin
  result:=Node.Font.Color;
end;

procedure TTextColorAnimation.Preview;
begin
  inherited;
  Node.Font.Size:=18;
  Node.Font.Style:=[fsBold];
  FStartColor:=Node.Font.Color;
  FEndColor:=clRed;
end;

procedure TTextColorAnimation.SetColor(AColor: TColor);
begin
  Node.Font.Color:=AColor;
end;

{ TNodeZoomAnimation }

constructor TNodeZoomAnimation.Create(AOwner: TComponent);
begin
  inherited;
  FZoomPercent:=100;
end;

procedure TNodeZoomAnimation.EndAnimation;
begin
  if not (csDestroying in ComponentState) then
     SetNodeBounds(OldBounds);
  inherited;
end;

procedure TNodeZoomAnimation.NextFrame;
var tmpZoom : Double;
    tmpW    : Double;
    tmpH    : Double;
begin
  tmpZoom:=(ICurrentFrame-StartFrame)*ZoomPercent/Duration;

  tmpW:=OldBounds.Right-OldBounds.Left;
  tmpW:=tmpW+(tmpW*tmpZoom*0.01);

  tmpH:=OldBounds.Bottom-OldBounds.Top;
  tmpH:=tmpH+(tmpH*tmpZoom*0.01);

  with Node do
  begin
    Left:=Round((OldBounds.Right+OldBounds.Left-tmpW)*0.5);
    Width:=Round(tmpW);
    Top:=Round((OldBounds.Bottom+OldBounds.Top-tmpH)*0.5);
    Height:=Round(tmpH);
  end;

  if tmpZoom>=ZoomPercent then Stop;
  inherited;
end;

procedure TNodeZoomAnimation.Preview;
begin
  inherited;
  Node.Transparent:=False;
  Node.Border.Visible:=True;
end;

Procedure TNodeZoomAnimation.SetNodeBounds(Const R:TRect);
begin
  Node.Left:=R.Left;
  Node.Top:=R.Top;
  Node.Width:=R.Right-R.Left;
  Node.Height:=R.Bottom-R.Top;
end;

procedure TNodeZoomAnimation.StoreValue;
begin
  inherited;
  with OldBounds do
  begin
    Left:=Node.Left;
    Top:=Node.Top;
    Right:=Left+Node.Width;
    Bottom:=Top+Node.Height;
  end;
end;

initialization
  AnimationClasses:=TList.Create;
  RegisterAnimation(TFontSizeAnimation);
  RegisterAnimation(TMovementAnimation);
  RegisterAnimation(TTransparencyAnimation);
  RegisterAnimation(TTextTranspAnimation);
  RegisterAnimation(TVisibleAnimation);
  RegisterAnimation(TNodeColorAnimation);
  RegisterAnimation(TTreeColorAnimation);
  RegisterAnimation(TCustomAnimation);
  RegisterAnimation(TAddTextAnimation);
  RegisterAnimation(TMoveTextAnimation);
  RegisterAnimation(TTextAngleAnimation);
  RegisterAnimation(TTextFlashAnimation);
  RegisterAnimation(TTextColorAnimation);
  RegisterAnimation(TNodeZoomAnimation);

finalization
  AnimationClasses.Free;
end.
