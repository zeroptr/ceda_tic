{**********************************************}
{   TTreeAnimate Gallery Dialog                }
{   Copyright (c) 2001-2009 by David Berneda   }
{**********************************************}
{$I TeeDefs.inc}
unit TreeAnimationGallery;

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  {$ENDIF}
  TreeAnimate, TeeTree, TeeProcs;

type
  TAnimationGallery = class(TForm)
    ListBox1: TListBox;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Tree1: TTree;
    TreeAnimate1: TTreeAnimate;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Procedure PreviewAnimation;
  public
    { Public declarations }
    class Function Select:TAnimationClass;
    Function SelectedClass:TAnimationClass;
  end;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeeTranslate;

procedure TAnimationGallery.FormCreate(Sender: TObject);
var t : Integer;
begin
  // Add available animation classes:
  for t:=0 to AnimationClasses.Count-1 do
  if (csDesigning in ComponentState) or
     (not (TAnimationClass(AnimationClasses[t])=TCustomAnimation)) then
      ListBox1.Items.AddObject(TAnimationClass(AnimationClasses[t]).Description,TObject(t));
end;

// Show the Gallery modally, returns nil or a selected animation class.
class function TAnimationGallery.Select: TAnimationClass;
begin
  result:=nil;
  with TAnimationGallery.Create(Application) do
  try
    if ShowModal=mrOk then result:=SelectedClass;
  finally
    Free;
  end;
end;

Function TAnimationGallery.SelectedClass:TAnimationClass;
begin
  result:={$IFDEF CLR}TAnimationClass{$ENDIF}(AnimationClasses[Integer(ListBox1.Items.Objects[ListBox1.ItemIndex])])
end;

procedure TAnimationGallery.ListBox1Click(Sender: TObject);
begin
  Button1.Enabled:=ListBox1.ItemIndex<>-1;
  PreviewAnimation;
end;

procedure TAnimationGallery.ListBox1DblClick(Sender: TObject);
begin
  if ListBox1.ItemIndex<>-1 then
     ModalResult:=mrOk;
end;

// Show the animation in the preview Tree:
Procedure TAnimationGallery.PreviewAnimation;
var tmp : TAnimation;
    tmpPause : TCustomAnimation;
begin
  TreeAnimate1.Stop;
  Tree1.Clear;
  TreeAnimate1.Animations.Clear;

  with Tree1.Add('Hello World !') do
  begin
    ImageIndex:=tiNone;
    X0:=Tree1.ChartXCenter-(Width div 2);
    Y0:=Tree1.ChartYCenter-(Height div 2);
    Border.Visible:=False;
    Transparent:=True;
    AutoSize:=False;
  end;

  TreeAnimate1.Speed:=15;
  TreeAnimate1.Loop:=True;

  tmp:=SelectedClass.Create(Self);
  TreeAnimate1.Animations.Add(tmp);
  tmp.Preview;

  tmpPause:=TCustomAnimation.Create(Self);
  tmpPause.StartFrame:=tmp.EndFrame;
  tmpPause.Duration:=10;
  TreeAnimate1.Animations.Add(tmpPause);

  TreeAnimate1.Play;
end;

procedure TAnimationGallery.FormShow(Sender: TObject);
begin
  TeeTranslateControl(Self);
end;

end.
