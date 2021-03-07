{************************************************}
{   TMagnifyTool Component and Editor Dialog     }
{   Copyright (c) 2003-2009 by Josep Lluis Jorge }
{************************************************}
unit TeeMagnifyTool;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  Classes,
  {$IFDEF CLX}
  QControls, QGraphics, QStdCtrls, QComCtrls, QExtCtrls, QForms, QMenus,
  {$ELSE}
  Controls, Graphics, StdCtrls, ComCtrls, ExtCtrls, Forms, Menus,
  {$ENDIF}
  {$IFDEF D6}
  Types,
  {$ENDIF}
  TeCanvas, TeeProcs, TeEngine, Chart, TeeTools, TeePenDlg, TeeAnnToolEdit;

type
  TMagnifyTool=class(TRectangleTool)
  private
    FCircled     : Boolean;
    FFollowMouse : Boolean;
    FPercent     : Double;
    FSmooth      : Boolean;
    FWheelZoom   : Integer;

    procedure DrawLoupe;
    procedure SetCircled(const Value: Boolean);
    procedure SetPercent(const Value: Double);
    procedure SetSmooth(const Value: Boolean);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    Procedure ChartMouseEvent( AEvent: TChartMouseEvent;
                               AButton:TMouseButton;
                               AShift: TShiftState; X, Y: Integer); override;
    class function GetEditorClass: String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
    Procedure WheelMouseEvent( AEvent: TWheelMouseEvent;
                               WheelDelta:Integer; X, Y: Integer); override;
  public
    Constructor Create(AOwner:TComponent); override;

    procedure Assign(Source:TPersistent); override;
    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Circled:Boolean read FCircled write SetCircled default False;
    property FollowMouse:Boolean read FFollowMouse write FFollowMouse default False;
    property Pen;
    property Percent:Double read FPercent write SetPercent;
    property Smooth:Boolean read FSmooth write SetSmooth default False;
    property WheelZoom:Integer read FWheelZoom write FWheelZoom default 5;
  end;

  TMagnifyToolEditor=class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    CBFollow: TCheckBox;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    TBFactor: TTrackBar;
    BBorder: TButtonPen;
    CBCircled: TCheckBox;
    Label9: TLabel;
    CBCursor: TComboFlat;
    CBDrag: TCheckBox;
    CBResize: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    UDWheel: TUpDown;
    Label2: TLabel;
    procedure CBFollowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TBFactorChange(Sender: TObject);
    procedure CBCircledClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBCursorChange(Sender: TObject);
    procedure CBDragClick(Sender: TObject);
    procedure CBResizeClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
    CreatingForm : Boolean;
    IAnnEditor   : TAnnotationToolEdit;
  public
    { Public declarations }
    Zoom : TMagnifyTool;
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
  SysUtils, Math,
  TeeConst, TeeProCo, TeeFilters;

{ TMagnifyTool }

Constructor TMagnifyTool.Create(AOwner: TComponent);
begin
  inherited;
  FPercent:=50;
  Shape.Transparency:=0;
  Shape.Brush.Style:=bsClear;
  FWheelZoom:=5;
end;

procedure TMagnifyTool.ChartMouseEvent(AEvent: TChartMouseEvent;
  AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
begin
  if Active and FFollowMouse and (AEvent=cmeMove) then
  begin
    Left:=X-(Width div 2);
    Top:=Y-(Height div 2);
  end
  else
    inherited;
end;

Procedure TMagnifyTool.WheelMouseEvent( AEvent: TWheelMouseEvent;
                                        WheelDelta:Integer;
                                        X, Y: Integer);
begin
  if (WheelZoom<>0) and PointInRect(Shape.ShapeBounds,X,Y) then
  begin
    if (not ParentChart.Focused) and ParentChart.CanFocus then
       ParentChart.SetFocus;

    if AEvent=wmeMove then
       if WheelDelta>0 then
          Percent:=Math.Min(100,Percent+Abs(WheelZoom))
       else
          Percent:=Math.Max(0.001,Percent-Abs(WheelZoom));
  end;
end;

procedure TMagnifyTool.ChartEvent(AEvent: TChartToolEvent);
begin
  if Active and (AEvent=cteAfterDraw) and
     (not ParentChart.Canvas.Metafiling) then
          DrawLoupe;

// Do not call  inherited;
end;

class function TMagnifyTool.Description: String;
begin
  result:=TeeMsg_MagnifyTool;
end;

class Function TMagnifyTool.LongDescription:String;
begin
  result:=TeeMsg_MagnifyToolDesc;
end;

class function TMagnifyTool.GetEditorClass: String;
begin
  result:='TMagnifyToolEditor'; // Do not localize
end;

procedure TMagnifyTool.DrawLoupe;
var Buffer : TBitmap;
    tmp    : Boolean;
    tmpBlend : TTeeBlend;
    tmpBounds : TRect;
begin
  tmpBounds:=Bounds;

  tmp:=(ParentChart.Canvas is TTeeCanvas3D) and
       Assigned(TTeeCanvas3D(ParentChart.Canvas).Bitmap);

  if tmp then
  begin
    Buffer:=TBitmap.Create;
    TeeSetBitmapSize(Buffer,Width,Height);

    {
    // Creating a bigger Chart to obtain more detail when zooming:
    OldActive:=Active;
    Active:=False;
    try
      tmpB:=ParentChart.TeeCreateBitmap(ParentChart.Color,
              TeeRect(0,0,4*ParentChart.Width,4*ParentChart.Height));
      try
        Buffer.Canvas.CopyRect( TeeRect(0,0,Width,Height),
                                tmpB.Canvas,Bounds);
      finally
        tmpB.Free;
      end;
    finally
      Active:=OldActive;
    end;
    }

    Buffer.Canvas.CopyRect(TeeRect(0,0,Width,Height),
                     TTeeCanvas3D(ParentChart.Canvas).Bitmap.Canvas,tmpBounds);
  end
  else
     Buffer:=Bitmap(True);

  try
    with TZoomFilter.Create(nil) do
    try
      Smooth:=Self.Smooth;
      Percent:=Self.Percent;
      Apply(Buffer);
    finally
      Free;
    end;

    if FCircled then
       ParentChart.Canvas.ClipEllipse(tmpBounds);

    if Shape.Transparency<>0 then
       tmpBlend:=ParentChart.Canvas.BeginBlending(tmpBounds,Shape.Transparency)
    else
       tmpBlend:=nil;

    ParentChart.Canvas.Draw(tmpBounds.Left,tmpBounds.Top,Buffer);

    if Assigned(tmpBlend) then
       ParentChart.Canvas.EndBlending(tmpBlend);

    if FCircled then
       ParentChart.Canvas.UnClipRectangle;

    if Pen.Visible then
    begin
      ParentChart.Canvas.AssignVisiblePen(Pen);
      ParentChart.Canvas.Brush.Style:=bsClear;

      if FCircled then
         ParentChart.Canvas.Ellipse(tmpBounds)
      else
         ParentChart.Canvas.Rectangle(tmpBounds);
    end;

  finally
    Buffer.Free;
  end;
end;

procedure TMagnifyTool.SetPercent(const Value: Double);
begin
  SetDoubleProperty(FPercent,Value);
end;

procedure TMagnifyTool.SetSmooth(const Value: Boolean);
begin
  SetBooleanProperty(FSmooth,Value);
end;

procedure TMagnifyTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if Assigned(ParentChart) then
     Repaint;
end;

procedure TMagnifyTool.Assign(Source: TPersistent);
begin
  if Source is TMagnifyTool then
  with TMagnifyTool(Source) do
  begin
    Self.FCircled:=FCircled;
    Self.FFollowMouse:=FFollowMouse;
    Self.FPercent:=FPercent;
    Self.FSmooth:=FSmooth;
    Self.FWheelZoom:=FWheelZoom;
  end;

  inherited;
end;

procedure TMagnifyTool.SetCircled(const Value: Boolean);
begin
  SetBooleanProperty(FCircled,Value);
end;

{ TMagnifyToolEditor }

procedure TMagnifyToolEditor.CBFollowClick(Sender: TObject);
begin
  Zoom.FollowMouse:=CBFollow.Checked;
end;

procedure TMagnifyToolEditor.FormCreate(Sender: TObject);
begin
  CreatingForm:=True;
end;

procedure TMagnifyToolEditor.FormShow(Sender: TObject);
begin
  Zoom:=TMagnifyTool(Tag);

  if Assigned(Zoom) then
  with Zoom do
  begin
    CBFollow.Checked:=FollowMouse;

    TBFactor.Position:=Round(Percent);
    BBorder.LinkPen(Pen);

    CBCircled.Checked:=Circled;
    CBDrag.Checked:=AllowDrag;
    CBResize.Checked:=AllowResize;
    UDWheel.Position:=WheelZoom;

    TeeFillCursors(CBCursor,Cursor);

    IAnnEditor:=TAnnotationToolEdit.Create(nil);
    IAnnEditor.RefreshControls(Zoom);
    IAnnEditor.CBAutoSize.Hide;

    IAnnEditor.TabPosition.PageControl:=PageControl1;
    IAnnEditor.TabSize.PageControl:=PageControl1;
    TeeTranslateControl(IAnnEditor);
  end;

  CreatingForm:=False;
end;

procedure TMagnifyToolEditor.TBFactorChange(Sender: TObject);
begin
  Zoom.Percent:=TBFactor.Position;
end;

procedure TMagnifyToolEditor.CBCircledClick(Sender: TObject);
begin
  Zoom.Circled:=CBCircled.Checked;
end;

procedure TMagnifyToolEditor.FormDestroy(Sender: TObject);
begin
  FreeAndNil(IAnnEditor);
end;

procedure TMagnifyToolEditor.CBCursorChange(Sender: TObject);
begin
  with Zoom do
       Cursor:=TeeSetCursor(Cursor,CBCursor.CurrentItem);
end;

procedure TMagnifyToolEditor.CBDragClick(Sender: TObject);
begin
  Zoom.AllowDrag:=CBDrag.Checked;
end;

procedure TMagnifyToolEditor.CBResizeClick(Sender: TObject);
begin
  Zoom.AllowResize:=CBResize.Checked;
end;

procedure TMagnifyToolEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     Zoom.WheelZoom:=UDWheel.Position;
end;

initialization
  RegisterClass(TMagnifyToolEditor);
  RegisterTeeTools([TMagnifyTool]);
finalization
  UnRegisterTeeTools([TMagnifyTool]);
end.
