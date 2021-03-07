{**********************************************}
{  TChartGradient Editor Dialog                }
{  Copyright (c) 1999-2009 by David Berneda    }
{**********************************************}
unit TeeEdiGrad;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls,
     {$ENDIF}
     {$IFDEF LINUX}
     Types,
     {$ENDIF} 
     {$IFDEF D10}
     Types,
     {$ENDIF}
     {$IFDEF LCL}
     Buttons,
     {$ENDIF}
     {$IFDEF TEEDONOTDEFINE}
     TeeEdiGrad,
     {$ENDIF}
     TeeProcs, TeePenDlg, TeCanvas, TeeGalleryPanel;

type
  TPreviewGradient=class(TCustomTeePanelExtended)
  protected
    Procedure InternalDraw(Const UserRectangle:TRect); override;
  end;

  TTeeGradientEditor=class; // forward

  TButtonGradient=class(TTeeButton) // 7.05
  private
    FEditor     : TTeeGradientEditor;
    FOldDestroy : TNotifyEvent;

    procedure EditorDestroy(Sender:TObject);
    Function GetEditor:TTeeGradientEditor;
    Function GetGradient:TCustomTeeGradient;
  protected
    procedure DrawSymbol(ACanvas:TTeeCanvas); override;
  public
    OnlyStart : Boolean;

    procedure Click; override;
    procedure LinkGradient(const Value:TCustomTeeGradient);

    property Editor:TTeeGradientEditor read GetEditor;
    property Gradient:TCustomTeeGradient read GetGradient write LinkGradient;
  end;

  TTeeGradientEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label4: TLabel;
    SBBalance: TScrollBar;
    LabelBalance: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    LRadialX: TLabel;
    LRadialY: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    BSwap: TButton;
    BStart: TButtonColor;
    BEnd: TButtonColor;
    BMid: TButtonColor;
    CBMid: TCheckBox;
    Panel1: TPanel;
    BOk: TButton;
    BCancel: TButton;
    Panel2: TPanel;
    CBVisible: TCheckBox;
    Label1: TLabel;
    CBDirection: TComboFlat;
    TabSheet3: TTabSheet;
    Gallery: TListBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    TabSheet4: TTabSheet;
    Directions: TChartGalleryPanel;
    TabSheet5: TTabSheet;
    Label5: TLabel;
    SBTransp: TScrollBar;
    BSubEdit: TButtonGradient;
    CBSubVisible: TCheckBox;
    Label6: TLabel;
    EAngle: TEdit;
    UDAngle: TUpDown;
    procedure CBVisibleClick(Sender: TObject);
    procedure CBDirectionChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure BSwapClick(Sender: TObject);
    procedure CBMidClick(Sender: TObject);
    procedure BMidClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure SBBalanceChange(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure BEndClick(Sender: TObject);
    procedure GalleryClick(Sender: TObject);
    procedure DirectionsChangeChart(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBTranspChange(Sender: TObject);
    procedure CBSubVisibleClick(Sender: TObject);
    procedure EAngleChange(Sender: TObject);
  private
    { Private declarations }
    Backup : TCustomTeeGradient;
    IModified  : Boolean;
    IOnlyStart : Boolean;
    SettingProps : Boolean;
    Preview : TPreviewGradient;

    procedure CheckDirection;
    procedure CheckVisible;
    Function IsRectGradient:Boolean;
    procedure SetDirectionGradients;
  protected
    procedure RefreshControls; virtual;
    procedure SetPreview; virtual;
  public
    { Public declarations }
    TheGradient : TCustomTeeGradient;

    Constructor CreateCustom(AOwner:TComponent; AGradient:TCustomTeeGradient);
    class procedure DefaultGradient(Gradient:TCustomTeeGradient;
                                    IsRectGradient:Boolean; Index:Integer);
    Procedure RefreshGradient(AGradient:TCustomTeeGradient); virtual;
  end;

Function EditTeeGradient(AOwner:TComponent; AGradient:TCustomTeeGradient):Boolean; overload;
Function EditTeeGradient(AOwner:TComponent; AGradient:TCustomTeeGradient;
                         OnlyStart:Boolean; HideVisible:Boolean=False):Boolean; overload;

Const TeeMaxSampleGradient=16;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses {$IFDEF CLR}
     Variants,
     {$ENDIF}
     TeeConst, Math;

Function EditTeeGradient( AOwner:TComponent;
                          AGradient:TCustomTeeGradient):Boolean;
begin
  result:=EditTeeGradient(AOwner,AGradient,False,False);
end;

function CreateGradientEditor( AOwner:TComponent;
                               AGradient:TCustomTeeGradient;
                               OnlyStart:Boolean;
                               HideVisible:Boolean=False):TTeeGradientEditor;
begin
  result:=TeeCreateForm(TTeeGradientEditor,AOwner) as TTeeGradientEditor;

  with result do
  begin
    Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AGradient);
    IOnlyStart:=OnlyStart;

    if IOnlyStart then
    begin
      BEnd.Visible:=False;
      BSwap.Visible:=False;
    end;

    CBVisible.Visible:=not HideVisible;
  end;
end;

Function EditTeeGradient( AOwner:TComponent;
                          AGradient:TCustomTeeGradient;
                          OnlyStart:Boolean;
                          HideVisible:Boolean=False):Boolean;
begin
  With CreateGradientEditor(AOwner,AGradient,OnlyStart,HideVisible) do
  try
    result:=ShowModal=mrOk;
  finally
    Free;
  end;
end;

Constructor TTeeGradientEditor.CreateCustom(AOwner:TComponent; AGradient:TCustomTeeGradient);
Begin
  inherited Create(AOwner);
  TheGradient:=AGradient;
  Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(TheGradient);
  Panel1.Visible:=False;
  BOk.Visible:=False;
  BCancel.Visible:=False;
  Height:=Height-BOk.Height;
end;

procedure TTeeGradientEditor.CheckVisible;
Begin
  EnableControls(IOnlyStart or TheGradient.Visible,
                 [CBDirection,BStart,CBMid,BMid,BEnd,BSwap,Gallery]);
end;

procedure TTeeGradientEditor.CheckDirection;
var tmp : Boolean;
begin
  With TheGradient do
  begin
    tmp:=(Direction=gdFromCenter) or
         (Direction=gdRadial) or
         (Direction=gdFromTopLeft) or
         (Direction=gdFromBottomLeft);
    EnableControls(IOnlyStart or Visible and (not tmp),[CBMid,BMid]);
    EnableControls(Direction=gdRadial,[Label2,Label3,TrackBar1,TrackBar2]);
  end;
end;

procedure TTeeGradientEditor.CBVisibleClick(Sender: TObject);
begin
  IModified:=True;
  TheGradient.Visible:=CBVisible.Checked;
  CheckVisible;
end;

procedure TTeeGradientEditor.CBDirectionChange(Sender: TObject);
begin
  IModified:=True;
  TheGradient.Direction:=TGradientDirection(CBDirection.ItemIndex);
  CheckDirection;

  if not IsRectGradient then Gallery.ItemIndex:=-1;

  SetPreview;

  Directions.SelectChart(Directions[CBDirection.ItemIndex]);
end;

Procedure TTeeGradientEditor.RefreshGradient(AGradient:TCustomTeeGradient);
begin
  SettingProps:=True;
  Tag:={$IFDEF CLR}Variant{$ELSE}Integer{$ENDIF}(AGradient);

  TheGradient:=AGradient;

  if Assigned(TheGradient) then
  begin
    FreeAndNil(Backup);

    Backup:=TChartGradient.Create(nil);
    Backup.Assign(TheGradient);

    BStart.LinkProperty(TheGradient,'StartColor');
    BMid.LinkProperty(TheGradient,'MidColor');
    BEnd.LinkProperty(TheGradient,'EndColor');

    RefreshControls;

    CheckVisible;
    CheckDirection;
    SetPreview;

    Directions.SelectChart(Directions[Ord(TheGradient.Direction)]);
  end;

  SettingProps:=False;
end;

procedure TTeeGradientEditor.RefreshControls;
begin
  With TheGradient do
  begin
    SBBalance.Position:=Balance;
    CBVisible.Checked:=Visible;
    CBDirection.ItemIndex:=Ord(Direction);
    CBMid.Checked:=MidColor=clNone;
    TrackBar1.Position:=RadialX;
    LRadialX.Caption:=IntToStr(RadialX);
    TrackBar2.Position:=RadialY;
    LRadialY.Caption:=IntToStr(RadialY);
    UDAngle.Position:=Angle;

    // SubGradient
    BSubEdit.LinkGradient(SubGradient);
    SBTransp.Position:=SubGradient.Transparency;
    CBSubVisible.Checked:=SubGradient.Visible;
  end;

  BStart.Invalidate;
  BMid.Invalidate;
  BEnd.Invalidate;

  SetDirectionGradients;
end;

procedure TTeeGradientEditor.SetDirectionGradients;
var t : Integer;
begin
  for t:=0 to Directions.Charts.Count-1 do
  with Directions[t].BackWall.Gradient do
  begin
    StartColor:=TheGradient.StartColor;
    MidColor:=TheGradient.MidColor;
    EndColor:=TheGradient.EndColor;
  end;
end;

procedure TTeeGradientEditor.FormShow(Sender: TObject);
begin
  if Assigned(TheGradient) then
     RefreshGradient(TheGradient)
  else
     RefreshGradient(TCustomTeeGradient({$IFDEF CLR}TObject{$ENDIF}(Tag)));

  IModified:=False;
  TeeTranslateControl(Self);
end;

procedure TTeeGradientEditor.BCancelClick(Sender: TObject);
begin
  if IModified then
  begin
    TheGradient.Assign(Backup);
    TheGradient.Changed(Self);
  end;
end;

procedure TTeeGradientEditor.BSwapClick(Sender: TObject);
var tmp : TColor;
begin
  IModified:=True;

  With TheGradient do
  begin
    tmp:=StartColor;
    StartColor:=EndColor;
    EndColor:=tmp;
  end;

  BStart.Repaint;
  BEnd.Repaint;
  SetPreview;
end;

procedure TTeeGradientEditor.CBMidClick(Sender: TObject);
begin
  if not SettingProps then
  begin
    IModified:=True;

    if CBMid.Checked then
       TheGradient.MidColor:=clNone
    else
    begin
      TheGradient.UseMiddleColor;

      if TheGradient.MidColor=clNone then
         TheGradient.MidColor:=clWhite;
    end;

    BMid.Repaint;
    SetPreview;
  end;
end;

procedure TTeeGradientEditor.BMidClick(Sender: TObject);
begin
  IModified:=True;
  CBMid.Checked:=TheGradient.MidColor=clNone;
  SetPreview;
end;

type
  TGalleryPanelAccess=class(TChartGalleryPanel);

procedure TTeeGradientEditor.FormCreate(Sender: TObject);

  Procedure AddGallery(const S:Array of String);
  var t : Integer;
  begin
    for t:=Low(S) to High(S) do
        Gallery.Items.AddObject(S[t],TObject(t));
  end;

  procedure AddDirectionGallery;

    procedure Apply(Index:TGradientDirection);
    begin
      with Directions[Ord(Index)] do
      begin
        Title.Text.Clear;
        View3D:=False;
        Axes.Visible:=False;
        BackWall.Gradient.Visible:=True;
        BackWall.Transparent:=False;
        MarginLeft:=16;
        MarginTop:=22;
        MarginRight:=16;
        MarginBottom:=22;
        BackWall.Gradient.Direction:=TGradientDirection(Index);
      end;
    end;

  var t : TGradientDirection;
      tmp : TGalleryChart;
  begin
    Directions.DisplaySub:=False;
    Directions.NumRows:=2;
    Directions.NumCols:=5;

    for t:=Low(TGradientDirection) to High(TGradientDirection) do
    begin
      tmp:=TGalleryChart.Create(Directions);
      Directions.Charts.Add(tmp);
      tmp.Parent:=Directions;
      tmp.OnClick:=TGalleryPanelAccess(Directions).ChartEvent;
      tmp.OnDblClick:=TGalleryPanelAccess(Directions).ChartOnDblClick;
      tmp.OnEnter:=TGalleryPanelAccess(Directions).ChartEvent;
      tmp.Hint:=CBDirection.Items[Ord(t)]; // -Ord(Low(TGradientDirection))];
      tmp.ShowHint:=True;
      Apply(t);
    end;

    Directions.ResizeCharts;

    TeeTranslateControl(Directions);
  end;

begin
  Align:=alClient;
  BorderStyle:=TeeBorderStyle;

  Preview:=TPreviewGradient.Create(Self);
  Preview.Parent:=TabSheet3;
  Preview.Align:=alClient; // SetBounds(144,16,81,73);

  AddGallery(['Caribe Sun','Business','Hot','Ace','Farm','Sea',
              'Night','Space','Golf','Funky','Sunset','Rainbow',
              'Pastel','Tropical','Sea 2','Desert','Clear day']);

  AddDirectionGallery;

  PageControl1.ActivePage:=TabSheet1;
end;

procedure TTeeGradientEditor.TrackBar1Change(Sender: TObject);
begin
  IModified:=True;
  TheGradient.RadialX:=TrackBar1.Position;
  LRadialX.Caption:=IntToStr(TheGradient.RadialX);
end;

procedure TTeeGradientEditor.TrackBar2Change(Sender: TObject);
begin
  IModified:=True;
  TheGradient.RadialY:=TrackBar2.Position;
  LRadialY.Caption:=IntToStr(TheGradient.RadialY);
end;

procedure TTeeGradientEditor.SBBalanceChange(Sender: TObject);
begin
  if not SettingProps then
  begin
    IModified:=True;
    TheGradient.Balance:=SBBalance.Position;
  end;
  LabelBalance.Caption:=FormatFloat(TeeMsg_DefPercentFormat,TheGradient.Balance);
end;

procedure TTeeGradientEditor.BStartClick(Sender: TObject);
begin
  IModified:=True;
  SetPreview;
end;

procedure TTeeGradientEditor.BEndClick(Sender: TObject);
begin
  IModified:=True;
  SetPreview;
end;

procedure TTeeGradientEditor.SetPreview;
begin
  Preview.Gradient.Visible:=TheGradient.Visible;
  Preview.Gradient.Direction:=TheGradient.Direction;

  Preview.Gradient.StartColor:=TheGradient.StartColor;
  Preview.Gradient.MidColor:=TheGradient.MidColor;
  Preview.Gradient.EndColor:=TheGradient.EndColor;

  SetDirectionGradients;
end;

Function TTeeGradientEditor.IsRectGradient:Boolean;
begin
  result:= (TheGradient.Direction=gdTopBottom) or
           (TheGradient.Direction=gdBottomTop) or
           (TheGradient.Direction=gdLeftRight) or
           (TheGradient.Direction=gdRightLeft);
end;

class procedure TTeeGradientEditor.DefaultGradient(Gradient:TCustomTeeGradient;
                                         IsRectGradient:Boolean; Index:Integer);

  Procedure DefaultGradient(AStart,AMid,AEnd:TColor;
                            ADirection:TGradientDirection=gdTopBottom;
                            ABalance:Integer=50);
  begin
    Gradient.StartColor:=AStart;
    Gradient.MidColor:=AMid;
    Gradient.EndColor:=AEnd;

    if (AMid<>clNone) and (not IsRectGradient) then
       Gradient.Direction:=gdTopBottom;

    Gradient.Direction:=ADirection;
    Gradient.Balance:=ABalance;
  end;

begin
  case Index of
    0: DefaultGradient($00DDDFD2,$00F50A97,$000B80F4);
    1: DefaultGradient(clSilver,clWhite,clDkGray);
    2: DefaultGradient(clRed,clNone,clYellow);
    3: DefaultGradient(clBlack,$00FF8080,clBlack,gdBottomTop,74);
    4: DefaultGradient($00006AD5,clWhite,$000062C4,gdBottomTop,4);
    5: DefaultGradient($00FFFF80,$00FF8080,clNavy,gdBottomTop,55);
    6: DefaultGradient(clWhite,$00800040,clBlack,gdTopBottom,40);
    7: DefaultGradient($00A50320,$00800040,clWhite,gdFromTopLeft);
    8: DefaultGradient($00159902,clSilver,$00D9F986,gdTopBottom);
    9: DefaultGradient($00BD3881,$0087607A,$0052EB85,gdTopBottom);
   10: DefaultGradient($00B85A06,$00A7D8AF,$00001042,gdTopBottom);
   11: DefaultGradient($00A11EE8,$000F8355,$00DD011A,gdTopBottom);
   12: DefaultGradient($00247489,$009491F6,$00FD8B9D);
   13: DefaultGradient($009A414B,$00732FF3,$0020D761);
   14: DefaultGradient($004C031C,$00BACBE1,$00291EF9);
   15: DefaultGradient($00265FB7,$00CE7185,$00604457);
   TeeMaxSampleGradient: DefaultGradient($00FFF3EA,$00E0E6E9,$00CEDBFF);
  end;
end;

procedure TTeeGradientEditor.GalleryClick(Sender: TObject);
begin
  if Gallery.ItemIndex<>-1 then
  begin
    DefaultGradient(TheGradient, IsRectGradient,
                    Integer(Gallery.Items.Objects[Gallery.ItemIndex]));
    RefreshControls;
    SetPreview;
  end;
end;

procedure TTeeGradientEditor.DirectionsChangeChart(Sender: TObject);
var tmp : Integer;
begin
  tmp:=Directions.Charts.IndexOf(Directions.SelectedChart);
  TheGradient.Direction:=TGradientDirection(tmp);
  CBDirection.ItemIndex:=tmp;

  IModified:=True;
  CheckDirection;
  SetPreview;
end;

{ TPreviewGradient }

procedure TPreviewGradient.InternalDraw(const UserRectangle: TRect);
begin
  PanelPaint(UserRectangle);
end;

{ TButtonGradient }

procedure TButtonGradient.Click;
var tmp : Boolean;
begin
  if Assigned(Instance) then
  begin
    tmp:=Editor.ShowModal=mrOk;
    try
      if tmp then
      begin
        Repaint;
        inherited;
      end;
    finally
      FreeAndNil(FEditor);
    end;
  end
  else inherited;
end;

procedure TButtonGradient.DrawSymbol(ACanvas: TTeeCanvas);
var R : TRect;
begin
  if Enabled and Assigned(Instance) then
  begin
    R:=SymbolRectangle;
    Gradient.Draw(ACanvas,R);

    with ACanvas do
    begin
      Pen.Style:=psSolid;

      if Gradient.Visible then
         Pen.Color:=clBlack
      else
         Pen.Color:=clDkGray;

      Brush.Style:=bsClear;
      Rectangle(R);
    end;
  end;
end;

procedure TButtonGradient.EditorDestroy(Sender:TObject);
begin
  if Assigned(FOldDestroy) then
     FOldDestroy(FEditor);

  FEditor:=nil;
end;

Function TButtonGradient.GetEditor:TTeeGradientEditor;
begin
  if not Assigned(FEditor) then
  begin
    FEditor:=CreateGradientEditor(Self,Gradient,OnlyStart);
    FOldDestroy:=FEditor.OnDestroy;
    FEditor.OnDestroy:=EditorDestroy;
  end;

  result:=FEditor;
end;

function TButtonGradient.GetGradient: TCustomTeeGradient;
begin
  result:=TCustomTeeGradient(Instance);
end;

procedure TButtonGradient.LinkGradient(const Value: TCustomTeeGradient);
begin
  LinkProperty(Value,'');
  Invalidate;
end;

procedure TTeeGradientEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Preview);
  Backup.Free;
end;

procedure TTeeGradientEditor.SBTranspChange(Sender: TObject);
begin
  TheGradient.SubGradient.Transparency:=SBTransp.Position;
end;

procedure TTeeGradientEditor.CBSubVisibleClick(Sender: TObject);
begin
  TheGradient.SubGradient.Visible:=CBSubVisible.Checked;
end;

procedure TTeeGradientEditor.EAngleChange(Sender: TObject);
begin
  if Showing then
     TheGradient.Angle:=UDAngle.Position;
end;

end.
