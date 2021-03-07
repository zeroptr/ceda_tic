{**********************************************}
{   THighLowLineSeries                         }
{                                              }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeHighLowLine;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls,
  {$ENDIF}
  {$IFDEF D6}
  Types,
  {$ENDIF}
  TeeProcs, TeEngine, ErrorBar, TeCanvas, TeePenDlg;

type
  THighLowLineSeries=class(TBaseHighLowSeries)
  private
    FHighPointer : TSeriesPointer;
    FLowPointer  : TSeriesPointer;

    procedure SetHighPointer(const Value: TSeriesPointer);
    procedure SetLowPointer(const Value: TSeriesPointer);
  protected
    Procedure CalcHorizMargins(Var LeftMargin,RightMargin:Integer); override;
    Procedure CalcVerticalMargins(Var TopMargin,BottomMargin:Integer); override;
    Procedure DrawValue(ValueIndex:Integer); override;
    class Function GetEditorClass:String; override;
    Procedure PrepareForGallery(IsEnabled:Boolean); override;
    Procedure SetParentChart(Const Value:TCustomAxisPanel); override;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    Procedure Assign(Source:TPersistent); override;
    function Clicked(x, y: Integer): Integer; override;
  published
    property HighPointer:TSeriesPointer read FHighPointer write SetHighPointer;
    property LowPointer:TSeriesPointer read FLowPointer write SetLowPointer;
  end;

  THighLowLineEditor = class(TForm)
    BPen: TButtonPen;
    CBColorEach: TCheckBox;
    BColor: TButtonColor;
    procedure FormShow(Sender: TObject);
    procedure CBColorEachClick(Sender: TObject);
  private
    { Private declarations }
    HighLow : THighLowLineSeries;
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
  Math,
  TeeConst, TeeProCo, Chart, TeePoEdi;

{ THighLowLineSeries }

Constructor THighLowLineSeries.Create(AOwner: TComponent);
begin
  inherited;
  FHighPointer:=TSeriesPointer.Create(Self);
  FLowPointer:=TSeriesPointer.Create(Self);
end;

Destructor THighLowLineSeries.Destroy;
begin
  FreeAndNil(FLowPointer);
  FreeAndNil(FHighPointer);
  inherited;
end;

procedure THighLowLineSeries.Assign(Source: TPersistent);
begin
  if Source is THighLowLineSeries then
  with THighLowLineSeries(Source) do
  begin
    Self.HighPointer:=FHighPointer;
    Self.LowPointer:=FLowPointer;
  end;

  inherited;
end;

function THighLowLineSeries.Clicked(x, y: Integer): Integer;

  function ClickedPointer(P:TSeriesPointer; tmpX,tmpY:Integer):Boolean;
  begin
    result:=(P.Visible) and (P.Style<>psNothing) and
            (Abs(tmpX-X)<P.HorizSize) and
            (Abs(tmpY-Y)<P.VertSize);
  end;

var t  : Integer;
    xx : Integer;
    y0 : Integer;
    y1 : Integer;
begin
  result:=inherited Clicked(x,y);

  if (result=TeeNoPointClicked) and
     (FirstValueIndex>-1) and (LastValueIndex>-1) then
  begin
    for t:=FirstValueIndex to LastValueIndex do
    begin
      if t>=Count then exit;  // prevent re-entrancy if series is cleared.

      if not IsNull(t) then
      begin
        // Calculate coordinates
        xx:=CalcXPos(t);
        y0:=CalcYPos(t);
        y1:=CalcYPosValue(LowValues.Value[t]);

        if ClickedPointer(HighPointer,xx,y0) or
           ClickedPointer(LowPointer,xx,y0) or
           PointInLine(TeePoint(x,y),xx,y0,xx,y1) then
        begin
          result:=t;
          break;
        end;
      end;
    end;
  end;
end;

procedure THighLowLineSeries.DrawValue(ValueIndex: Integer);
var x,
    y0,
    y1 : Integer;
begin
  if not IsNull(ValueIndex) then
  begin
    // Calculate coordinates
    x:=CalcXPos(ValueIndex);
    y0:=CalcYPos(ValueIndex);
    y1:=CalcYPosValue(LowValues.Value[ValueIndex]);

    with ParentChart.Canvas do
    begin
      // Draw line
      AssignVisiblePenColor(Self.Pen,Self.ValueColor[ValueIndex]);

      if ParentChart.View3D then
         VertLine3D(x,y0,y1,StartZ)
      else
         DoVertLine(x,y0,y1);

      // Draw High
      if HighPointer.Visible then
      begin
        HighPointer.PrepareCanvas(ParentChart.Canvas,Color);
        HighPointer.Draw(x,y0);
      end;

      // Draw Low
      if LowPointer.Visible then
      begin
        LowPointer.PrepareCanvas(ParentChart.Canvas,Color);
        LowPointer.Draw(x,y1);
      end;
    end;
  end;
end;

Procedure THighLowLineSeries.CalcHorizMargins(Var LeftMargin,RightMargin:Integer);
var tmp : Integer;
begin
  inherited;

  if Pen.Visible then
     tmp:=Pen.Width
  else
     tmp:=0;

  if HighPointer.Visible and HighPointer.InflateMargins then
     tmp:=Max(tmp,HighPointer.HorizSize);

  if LowPointer.Visible and LowPointer.InflateMargins then
     tmp:=Max(tmp,LowPointer.HorizSize);

  LeftMargin:=Max(LeftMargin,tmp);
  RightMargin:=Max(RightMargin,tmp);
end;

Procedure THighLowLineSeries.CalcVerticalMargins(Var TopMargin,BottomMargin:Integer);
begin
  inherited;

  if HighPointer.Visible and HighPointer.InflateMargins then
     TopMargin:=Max(TopMargin,HighPointer.VertSize);

  if LowPointer.Visible and LowPointer.InflateMargins then
     BottomMargin:=Max(BottomMargin,LowPointer.VertSize);
end;

procedure THighLowLineSeries.SetHighPointer(const Value: TSeriesPointer);
begin
  FHighPointer.Assign(Value);
end;

procedure THighLowLineSeries.SetLowPointer(const Value: TSeriesPointer);
begin
  FLowPointer.Assign(Value);
end;

class function THighLowLineSeries.GetEditorClass: String;
begin
  result:='THighLowLineEditor'; // Do not localize
end;

procedure THighLowLineSeries.SetParentChart(const Value: TCustomAxisPanel);
begin
  inherited;

  if Assigned(FHighPointer) then
     FHighPointer.ParentChart:=Value;

  if Assigned(FLowPointer) then
     FLowPointer.ParentChart:=Value;
end;

procedure THighLowLineEditor.FormShow(Sender: TObject);
begin
  HighLow:=THighLowLineSeries(Tag);

  if Assigned(HighLow) then
  begin
    BPen.LinkPen(HighLow.Pen);
    BColor.LinkProperty(HighLow,'SeriesColor'); // Do not localize
    CBColorEach.Checked:=HighLow.ColorEachPoint;

    if Assigned(Parent) then
    begin
      TeeInsertPointerForm(Parent,HighLow.HighPointer,TeeMsg_ValuesHigh);
      TeeInsertPointerForm(Parent,HighLow.LowPointer,TeeMsg_ValuesLow);
    end;
  end;
end;

procedure THighLowLineEditor.CBColorEachClick(Sender: TObject);
begin
  HighLow.ColorEachPoint:=CBColorEach.Checked;
end;

procedure THighLowLineSeries.PrepareForGallery(IsEnabled: Boolean);
begin
  inherited;
  HighPointer.Size:=2;
  LowPointer.Size:=2;
end;

initialization
  RegisterTeeSeries(THighLowLineSeries, {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryHighLowLine,
                                    {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryStats,1);
  RegisterClass(THighLowLineEditor);
finalization
  UnRegisterTeeSeries( [THighLowLineSeries]);
end.
