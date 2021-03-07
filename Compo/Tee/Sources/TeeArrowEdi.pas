{**********************************************}
{   TArrowSeries Editor Dialog                 }
{   Copyright (c) 1996-2009 by David Berneda   }
{**********************************************}
unit TeeArrowEdi;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QComCtrls,
  {$ELSE}
  Graphics, Controls,  Forms, Dialogs, StdCtrls, ComCtrls, Buttons,
  {$ENDIF}
  ArrowCha, TeCanvas, TeePenDlg, TeeProcs;

type
  TArrowSeriesEditor = class(TForm)
    BPen: TButtonPen;
    BBrush: TButton;
    Label1: TLabel;
    SEArrowWidth: TEdit;
    Label2: TLabel;
    SEArrowHeight: TEdit;
    GroupBox1: TGroupBox;
    CBColorEach: TCheckBox;
    BArrowColor: TButtonColor;
    UDArrowWidth: TUpDown;
    UDArrowHeight: TUpDown;
    Label3: TLabel;
    SBPercent: TScrollBar;
    LPercent: TLabel;
    procedure CBColorEachClick(Sender: TObject);
    procedure BBrushClick(Sender: TObject);
    procedure SEArrowWidthChange(Sender: TObject);
    procedure SEArrowHeightChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SBPercentChange(Sender: TObject);
  private
    { Private declarations }
    Arrow : TArrowSeries;
    procedure SetLPercent;
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
  TeeBrushDlg, TeEngine;

procedure TArrowSeriesEditor.CBColorEachClick(Sender: TObject);
begin
  Arrow.ColorEachPoint:=CBColorEach.Checked;
  BArrowColor.Enabled:=not Arrow.ColorEachPoint;

  if Arrow.ColorEachPoint then
     Arrow.Pointer.Color:=clTeeColor;
end;

procedure TArrowSeriesEditor.BBrushClick(Sender: TObject);
begin
  EditChartBrush(Self,Arrow.Pointer.Brush);
end;

procedure TArrowSeriesEditor.SEArrowWidthChange(Sender: TObject);
begin
  if Showing then
     Arrow.ArrowWidth:=UDArrowWidth.Position;
end;

procedure TArrowSeriesEditor.SEArrowHeightChange(Sender: TObject);
begin
  if Showing then
     Arrow.ArrowHeight:=UDArrowHeight.Position;
end;

procedure TArrowSeriesEditor.SetLPercent;
begin
  LPercent.Caption:=IntToStr(Arrow.ArrowPercent)+'%'; // Do not localize
end;

procedure TArrowSeriesEditor.FormShow(Sender: TObject);
begin
  Arrow:=TArrowSeries(Tag);

  if Assigned(Arrow) then
  begin
    With Arrow do
    begin
      CBColorEach.Checked:=ColorEachPoint;
      UDArrowWidth.Position:=ArrowWidth;
      UDArrowHeight.Position:=ArrowHeight;
      SBPercent.Position:=ArrowPercent;
      SetLPercent;
      BPen.LinkPen(Pointer.Pen);
    end;

    BArrowColor.LinkProperty(Arrow,'SeriesColor'); // Do not localize
  end;
end;

procedure TArrowSeriesEditor.FormCreate(Sender: TObject);
begin
  BorderStyle:=TeeBorderStyle;
end;

procedure TArrowSeriesEditor.SBPercentChange(Sender: TObject);
begin
  if Showing then
  begin
    Arrow.ArrowPercent:=SBPercent.Position;
    SetLPercent;
  end;
end;

initialization
  RegisterClass(TArrowSeriesEditor);
end.
