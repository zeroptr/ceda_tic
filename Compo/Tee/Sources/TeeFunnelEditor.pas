{************************************************************}
{                                                            }
{ Purpose  : The Editor dialog for Funnel or Pipeline Series }
{ Author   : Marjan Slatinek, marjan@steema.com              }
{                                                            }
{ Copyright (c) 2003-2009 by Marjan Slatinek                 }
{ All Rights Reserved                                        }
{************************************************************}
unit TeeFunnelEditor;
{$I TeeDefs.inc}

interface

uses {$IFNDEF LINUX}
     Windows, Messages,
     {$ENDIF}
     SysUtils, Classes,
     {$IFDEF CLX}
     QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
     {$ELSE}
     Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
     {$ENDIF}
     TeeFunnel, TeCanvas, TeePenDlg, TeeProcs;

type
  TFunnelSeriesEditor = class(TForm)
    ButtonPen1: TButtonPen;
    ButtonPen2: TButtonPen;
    Button1: TButton;
    AboveColor: TButtonColor;
    WithinColor: TButtonColor;
    BelowColor: TButtonColor;
    Label1: TLabel;
    Edit1: TEdit;
    DifLimit: TUpDown;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Funnel : TFunnelSeries;
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

Uses TeeBrushDlg;

procedure TFunnelSeriesEditor.FormShow(Sender: TObject);
begin
  Funnel:=TFunnelSeries(Tag);
  if Assigned(Funnel) then
  begin
    ButtonPen1.LinkPen(Funnel.LinesPen);
    ButtonPen2.LinkPen(Funnel.Pen);

    AboveColor.LinkProperty(Funnel,'AboveColor'); // Do not localize
    WithinColor.LinkProperty(Funnel,'WithinColor'); // Do not localize
    BelowColor.LinkProperty(Funnel,'BelowColor'); // Do not localize

    DifLimit.Position:=Round(Funnel.DifferenceLimit);
  end;
end;

procedure TFunnelSeriesEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,Funnel.Brush);
end;

procedure TFunnelSeriesEditor.Edit1Change(Sender: TObject);
begin
  if Showing then Funnel.DifferenceLimit:=DifLimit.Position;
end;

procedure TFunnelSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

initialization
  RegisterClass(TFunnelSeriesEditor);
end.
