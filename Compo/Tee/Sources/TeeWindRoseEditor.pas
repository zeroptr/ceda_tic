{**********************************************}
{   TWindRoseSeries Editor dialog              }
{   Copyright (c) 2000-2009 by David Berneda   }
{**********************************************}
unit TeeWindRoseEditor;
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
     TeePolarEditor, TeCanvas, TeePenDlg, TeeRose;

type
  TWindRoseEditor = class(TPolarSeriesEditor)
    CBMirror: TCheckBox;
    CBMirrorAngles: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CBMirrorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBMirrorAnglesClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure HideAngleInc; override;
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

procedure TWindRoseEditor.FormCreate(Sender: TObject);
begin
  inherited;
  CBClockWise.Hide; // Visible:=False;
end;

procedure TWindRoseEditor.HideAngleInc;
begin
end;

procedure TWindRoseEditor.CBMirrorClick(Sender: TObject);
begin
  (Polar as TWindRoseSeries).MirrorLabels:=CBMirror.Checked;
end;

procedure TWindRoseEditor.FormShow(Sender: TObject);
begin
  inherited;

  if Assigned(Polar) then
  begin
    CBMirror.Checked:=(Polar as TWindRoseSeries).MirrorLabels;
    CBMirrorAngles.Checked:=(Polar as TWindRoseSeries).MirrorAngles;
  end;
end;

procedure TWindRoseEditor.CBMirrorAnglesClick(Sender: TObject);
begin
  (Polar as TWindRoseSeries).MirrorAngles:=CBMirrorAngles.Checked;
end;

initialization
  RegisterClass(TWindRoseEditor);
end.
