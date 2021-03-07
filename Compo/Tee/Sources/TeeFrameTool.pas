{******************************************}
{   TeeChart Pro Charting Library          }
{   Frame Tool (Decorating Frames)         }
{                                          }
{ Copyright (c) 2006-2009 by David Berneda }
{ All Rights Reserved                      }
{******************************************}
unit TeeFrameTool;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  QComCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
  ComCtrls,
  {$ENDIF}
  {$IFDEF D6}
  Types,
  {$ENDIF}
  TeeProcs, TeeFilters, TeEngine, Chart, TeCanvas, TeePenDlg;

type
  TFrameTool=class(TTeeCustomTool)
  private
    FFrame     : TTeePicture;
    FPaspartou : Integer;
    FResize    : Boolean;
    FSize      : Integer;
    FStyle     : Integer;

    IResized : Boolean;
    IRotate  : TRotateFilter;

    procedure DoResizeChart;
    procedure DrawFrame;
    function IsFrameStored: Boolean;
    procedure PaspartouChanged(Sender:TObject);
    procedure SetFrame(const Value: TTeePicture);
    procedure SetResize(const Value: Boolean);
    procedure SetSize(const Value: Integer);
    procedure SetStyle(const Value: Integer);
    procedure SetPaspartou(const Value: Integer);
  protected
    procedure ChartEvent(AEvent: TChartToolEvent); override;
    class function GetEditorClass: String; override;
    procedure SetParentChart(const Value: TCustomAxisPanel); override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    procedure Assign(Source:TPersistent); override;

    class Function Description:String; override;
    class Function LongDescription:String; override;
  published
    property Active;
    property Brush;
    property Frame:TTeePicture read FFrame write SetFrame stored IsFrameStored;
    property Paspartou:Integer read FPaspartou write SetPaspartou;
    property Pen;
    property ResizeChart:Boolean read FResize write SetResize default True;
    property Size:Integer read FSize write SetSize default 16;
    property Style:Integer read FStyle write SetStyle default 1;
  end;

  TFrameToolEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    SBSize: TScrollBar;
    Button1: TButton;
    BBrowse: TButton;
    CBResize: TCheckBox;
    TabSheet2: TTabSheet;
    Button2: TButton;
    Label2: TLabel;
    SBPasSize: TScrollBar;
    LSize: TLabel;
    LPasSize: TLabel;
    CBStyle: TComboFlat;
    Label3: TLabel;
    BBorder: TButtonPen;
    TabSheet3: TTabSheet;
    CBChangeColor: TCheckBox;
    GroupColors: TGroupBox;
    SBRed: TScrollBar;
    SBGreen: TScrollBar;
    SBBlue: TScrollBar;
    LRed: TLabel;
    LGreen: TLabel;
    LBlue: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SBSizeChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BBrowseClick(Sender: TObject);
    procedure CBResizeClick(Sender: TObject);
    procedure SBPasSizeChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CBStyleChange(Sender: TObject);
    procedure SBRedChange(Sender: TObject);
    procedure CBChangeColorClick(Sender: TObject);
    procedure SBGreenChange(Sender: TObject);
    procedure SBBlueChange(Sender: TObject);
  private
    { Private declarations }
    Tool : TFrameTool;

    procedure CheckColorFilter;
    function ColorFilter:TColorFilter;
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

{$IFDEF CLR}
{$R 'TeeFrame1.bmp'} // Do not localize
{$R 'TeeFrame2.bmp'} // Do not localize
{$R 'TeeFrame3.bmp'} // Do not localize
{$R 'TeeFrame4.bmp'} // Do not localize
{$R 'TeeFrame5.bmp'} // Do not localize
{$R 'TeeFrame6.bmp'} // Do not localize
{$R 'TeeFrame7.bmp'} // Do not localize
{$ELSE}
{$R TeeFrameTool.res}
{$ENDIF}

uses
  ImageBar, TeeFiltersEditor, TeeBrushDlg, TeeProCo;

{ TFrameTool }

Constructor TFrameTool.Create(AOwner: TComponent);
begin
  inherited;
  FSize:=16;
  FResize:=True;
  FFrame:=TTeePicture.Create;
  IRotate:=TRotateFilter.Create(nil);
  FPaspartou:=16;

  Brush.BackColor:=clWhite;
  Brush.Style:=bsClear;
  Brush.OnChange:=PaspartouChanged;

  Style:=1;
end;

Destructor TFrameTool.Destroy;
begin
  IRotate.Free;
  FFrame.Free;
  inherited;
end;

procedure TFrameTool.PaspartouChanged(Sender:TObject);
begin
  DoResizeChart;
  Repaint;
end;

procedure TFrameTool.Assign(Source: TPersistent);
begin
  if Source is TFrameTool then
  with TFrameTool(Source) do
  begin
    Self.FFrame.Assign(FFrame);
    Self.FPaspartou:=FPaspartou;
    Self.FResize:=FResize;
    Self.FSize:=FSize;
    Self.FStyle:=FStyle;
  end;

  inherited;
end;

procedure TFrameTool.DrawFrame;
var P       : TFourPoints;
    tmp     : TBitmap;
    h       : Integer;
    w       : Integer;
    tmpSize : Integer;
begin
  w:=ParentChart.Width;
  h:=ParentChart.Height;

  if ParentChart.Shadow.Visible then
  begin
    Dec(w,2*ParentChart.Shadow.HorizSize);
    Dec(h,2*ParentChart.Shadow.VertSize);
  end;

  if Brush.Style<>bsClear then
  begin
    with ParentChart.Canvas do
    begin
      tmpSize:=Size+Paspartou;

      AssignBrush(Self.Brush);
      Pen.Style:=psClear;
      Rectangle(Size,Size,w-Size,tmpSize);
      Rectangle(Size,h-Size,w-Size,h-tmpSize);
      Rectangle(Size,Size,tmpSize,h-Size);
      Rectangle(w-Size,Size,w-tmpSize,h-Size);

      AssignVisiblePen(Self.Pen);
      Brush.Style:=bsClear;
      Rectangle(tmpSize-1,tmpSize-1,w-tmpSize,h-tmpSize);
    end;
  end;

  tmp:=TBitmap.Create;
  try
    TeeSetBitmapSize(tmp,Size,h);

    SmoothStretch(FFrame.Filtered as TBitmap,tmp);

    with ParentChart.Canvas do
    begin
      // Left
      P[0].X:=0;
      P[0].Y:=0;
      P[1].X:=Size;
      P[1].Y:=Size;
      P[2].X:=Size;
      P[2].Y:=h-Size;
      P[3].X:=0;
      P[3].Y:=h;

      ClipPolygon(P,4);
      StretchDraw(TeeRect(0,0,Size,h),tmp);
      UnClipRectangle;

      // Right
      TReverseFilter.ApplyTo(tmp);

      P[0].X:=w;
      P[1].X:=P[0].X-Size;
      P[2].X:=P[1].X;
      P[3].X:=P[0].X;
      P[3].Y:=h;

      ClipPolygon(P,4);
      StretchDraw(TeeRect(P[1].X,0,P[0].X,h),tmp);
      UnClipRectangle;

      {$IFNDEF D7}
      tmp.Dormant;
      {$ENDIF}
      
      // Top
      IRotate.Angle:=270;
      IRotate.Apply(tmp);

      P[0].X:=0;
      P[0].Y:=0;
      P[1].X:=w;
      P[1].Y:=0;
      P[2].X:=w-Size;
      P[2].Y:=Size;
      P[3].X:=Size;
      P[3].Y:=Size;

      ClipPolygon(P,4);
      StretchDraw(TeeRect(0,0,w,Size),tmp);
      UnClipRectangle;

      // Bottom
      IRotate.Angle:=180;
      IRotate.Apply(tmp);

      P[0].Y:=h;
      P[1].X:=w;
      P[1].Y:=h;
      P[2].X:=w-Size;
      P[2].Y:=h-Size;
      P[3].X:=Size;
      P[3].Y:=h-Size;

      ClipPolygon(P,4);
      StretchDraw(TeeRect(0,h-Size,w,h),tmp);
      UnClipRectangle;
    end;

  finally
    tmp.Free;
  end;
end;

procedure TFrameTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if AEvent=cteAfterDraw then
     DrawFrame;
end;

class function TFrameTool.Description: String;
begin
  result:=TeeMsg_FrameTool;
end;

class function TFrameTool.GetEditorClass: String;
begin
  result:='TFrameToolEditor'; // Do not localize
end;

class function TFrameTool.LongDescription: String;
begin
  result:=TeeMsg_FrameToolDesc;
end;

procedure TFrameTool.SetSize(const Value: Integer);
begin
  SetIntegerProperty(FSize,Value);
  DoResizeChart;
end;

procedure TFrameTool.SetStyle(const Value: Integer);
begin
  SetIntegerProperty(FStyle,Value);

  if Style<>0 then
     LoadBitmapFromResourceName(FFrame.Bitmap,'TeeFrame'+IntToStr(Style)); // Do not localize
end;

procedure TFrameTool.SetFrame(const Value: TTeePicture);
begin
  if Assigned(Value) then Frame.Assign(Value)
                     else FreeAndNil(FFrame);
end;

procedure TFrameToolEditor.FormShow(Sender: TObject);
begin
  Tool:=TFrameTool(Tag);

  if Assigned(Tool) then
  with Tool do
  begin
    CBStyle.ItemIndex:=Style;
    BBrowse.Enabled:=Style=0;

    SBSize.Position:=Size;
    LSize.Caption:=IntToStr(Size);

    SBPasSize.Position:=Paspartou;
    LPasSize.Caption:=IntToStr(Paspartou);

    BBorder.LinkPen(Pen);

    CheckColorFilter;
  end;
end;

procedure TFrameToolEditor.SBSizeChange(Sender: TObject);
begin
  Tool.Size:=SBSize.Position;
  LSize.Caption:=IntToStr(Tool.Size);
end;

procedure TFrameToolEditor.Button1Click(Sender: TObject);
begin
  if ShowFiltersEditor(Self,Tool.Frame) then
  begin
    Tool.Repaint;
    CheckColorFilter;
  end;
end;

procedure TFrameToolEditor.BBrowseClick(Sender: TObject);
var tmp : String;
begin
  tmp:=TeeGetPictureFileName(Self);

  if tmp<>'' then
  begin
    Tool.Frame.LoadFromFile(tmp);
    Tool.Style:=0;
    Tool.Repaint;
  end;
end;

function TFrameTool.IsFrameStored: Boolean;
begin
  result:=Style=0;
end;

procedure TFrameTool.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if Assigned(Value) then
  begin
    DoResizeChart;
    Repaint;
  end;
end;

procedure TFrameTool.DoResizeChart;
var tmp : Integer;
begin
  tmp:=Size;

  if Brush.Style<>bsClear then
     Inc(tmp,Paspartou);

  if Assigned(ParentChart) then
  with ParentChart as TCustomChart do
  if FResize then
  begin
    MarginUnits:=muPixels;
    MarginBottom:=tmp;
    MarginTop:=tmp;
    MarginRight:=tmp;
    MarginLeft:=tmp;

    IResized:=True;
  end
  else
  if IResized then
  begin
    MarginUnits:=muPercent;
    MarginBottom:=TeeDefVerticalMargin;
    MarginTop:=TeeDefVerticalMargin;
    MarginRight:=TeeDefHorizMargin;
    MarginLeft:=TeeDefHorizMargin;

    IResized:=False;
  end;
end;

procedure TFrameToolEditor.CBResizeClick(Sender: TObject);
begin
  Tool.ResizeChart:=CBResize.Checked;
end;

procedure TFrameTool.SetResize(const Value: Boolean);
begin
  SetBooleanProperty(FResize,Value);
  DoResizeChart;
end;

procedure TFrameTool.SetPaspartou(const Value: Integer);
begin
  SetIntegerProperty(FPaspartou,Value);
  DoResizeChart;
end;

procedure TFrameToolEditor.SBPasSizeChange(Sender: TObject);
begin
  Tool.Paspartou:=SBPasSize.Position;
  LPasSize.Caption:=IntToStr(Tool.Paspartou);
end;

procedure TFrameToolEditor.Button2Click(Sender: TObject);
begin
  EditChartBrush(Self,Tool.Brush);
end;

procedure TFrameToolEditor.CBStyleChange(Sender: TObject);
begin
  BBrowse.Enabled:=CBStyle.ItemIndex=0;
  Tool.Style:=CBStyle.ItemIndex;
end;

procedure TFrameToolEditor.SBRedChange(Sender: TObject);
begin
  ColorFilter.Red:=SBRed.Position;
  LRed.Caption:=IntToStr(SBRed.Position);
  Tool.Repaint;
end;

procedure TFrameToolEditor.CBChangeColorClick(Sender: TObject);
begin
  SBRed.Enabled:=CBChangeColor.Checked;
  SBGreen.Enabled:=CBChangeColor.Checked;
  SBBlue.Enabled:=CBChangeColor.Checked;

  if CBChangeColor.Checked and (ColorFilter=nil) then
  begin
    Tool.Frame.Filters.Add(TColorFilter);
    CheckColorFilter;
  end;

  if ColorFilter<>nil then
  begin
    ColorFilter.Enabled:=CBChangeColor.Checked;
    Tool.Repaint;
  end;
end;

procedure TFrameToolEditor.SBGreenChange(Sender: TObject);
begin
  ColorFilter.Green:=SBGreen.Position;
  LGreen.Caption:=IntToStr(SBGreen.Position);
  Tool.Repaint;
end;

procedure TFrameToolEditor.SBBlueChange(Sender: TObject);
begin
  ColorFilter.Blue:=SBBlue.Position;
  LBlue.Caption:=IntToStr(SBBlue.Position);
  Tool.Repaint;
end;

function TFrameToolEditor.ColorFilter: TColorFilter;
var t : Integer;
begin
  result:=nil;

  with Tool.Frame.Filters do
  for t:=0 to Count-1 do
      if Items[t] is TColorFilter then
      begin
        result:=Items[t] as TColorFilter;
        break;
      end;
end;

procedure TFrameToolEditor.CheckColorFilter;

  procedure SetColors(R,G,B:Integer);
  begin
    SBRed.Position:=R;
    LRed.Caption:=IntToStr(R);

    SBGreen.Position:=G;
    LGreen.Caption:=IntToStr(G);

    SBBlue.Position:=B;
    LBlue.Caption:=IntToStr(B);
  end;

var tmp : TColorFilter;
begin
  tmp:=ColorFilter;

  CBChangeColor.Checked:=Assigned(tmp) and tmp.Enabled;

  SBRed.Enabled:=CBChangeColor.Checked;
  SBGreen.Enabled:=CBChangeColor.Checked;
  SBBlue.Enabled:=CBChangeColor.Checked;

  if CBChangeColor.Checked then
     SetColors(tmp.Red,tmp.Green,tmp.Blue)
  else
     SetColors(0,0,0);
end;

initialization
  RegisterClass(TFrameToolEditor);
  RegisterTeeTools([TFrameTool]);
finalization
  UnRegisterTeeTools([TFrameTool]);
end.
