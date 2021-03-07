{**************************************************************}
{                                                              }
{ Purpose  : The Editor dialog for the Volume Pipeline Series  }
{ Author   : Marc Meumann, marc@steema.com                     }
{                                                              }
{ Copyright (c) 2006-2009 by Marc Meumann                      }
{        All Rights Reserved                                   }
{**************************************************************}
unit TeeVolumePipeEditor;
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
     TeeVolumePipe, TeCanvas, TeePenDlg, TeeProcs;

type
  TVolumePipeSeriesEditor = class(TForm)
    ButtonPen1: TButtonPen;
    Button1: TButton;
    ButtonPen2: TButtonPen;
    CheckBox1: TCheckBox;
    UpDown1: TUpDown;
    Edit2: TEdit;
    Label1: TLabel;
    CheckGradient: TCheckBox;
    CBDirection: TComboFlat;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure BGradientClick(Sender: TObject);
    procedure CheckGradientClick(Sender: TObject);
    procedure CBDirectionChange(Sender: TObject);
  private
    { Private declarations }
    VolumePipe : TVolumePipeSeries;
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

Uses TeeBrushDlg, TeeEdiGrad;

procedure TVolumePipeSeriesEditor.FormShow(Sender: TObject);
begin
  VolumePipe:=TVolumePipeSeries(Tag);

  if Assigned(VolumePipe) then
  begin
    Edit2.Text:=IntToStr(VolumePipe.ConePercent);

    ButtonPen1.LinkPen(VolumePipe.Pen);
    ButtonPen2.LinkPen(VolumePipe.LinesPen);

    CheckGradient.Checked:=VolumePipe.Gradient.Visible;

    if VolumePipe.Gradient.Direction=gdTopBottom then
       CBDirection.ItemIndex:=0
    else
       CBDirection.ItemIndex:=1;
  end;
end;

procedure TVolumePipeSeriesEditor.Button1Click(Sender: TObject);
begin
  EditChartBrush(Self,VolumePipe.Brush);

  if CheckBox1.Checked then
     VolumePipe.Brush.Color:=clNone;
end;

procedure TVolumePipeSeriesEditor.FormCreate(Sender: TObject);
begin
  Align:=alClient;
end;

procedure TVolumePipeSeriesEditor.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
     VolumePipe.Brush.Color:=clNone;
end;

procedure TVolumePipeSeriesEditor.Edit2Change(Sender: TObject);
begin
  if Assigned(VolumePipe) then
     VolumePipe.ConePercent:=StrToInt(Edit2.Text);
end;

procedure TVolumePipeSeriesEditor.BGradientClick(Sender: TObject);
begin
  EditTeeGradient(Self,VolumePipe.Gradient,True,True);
end;

procedure TVolumePipeSeriesEditor.CheckGradientClick(Sender: TObject);
begin
  VolumePipe.Gradient.Visible:=CheckGradient.Checked;
end;

procedure TVolumePipeSeriesEditor.CBDirectionChange(Sender: TObject);
begin
  case CBDirection.ItemIndex of
    0: VolumePipe.Gradient.Direction:=TGradientDirection(0);
    1: VolumePipe.Gradient.Direction:=TGradientDirection(3);
  else
    VolumePipe.Gradient.Direction:=TGradientDirection(0);
  end;
end;

initialization
  RegisterClass(TVolumePipeSeriesEditor);
end.
