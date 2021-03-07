{**********************************************}
{   Bubble Series editor (derived from Point)  }
{   Copyright (c) 2002-2009 by David Berneda   }
{**********************************************}
unit TeeBubbleEdit;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QComCtrls, QStdCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls, ExtCtrls,
  {$ENDIF}
  TeePoEdi, TeCanvas, TeePenDlg;

type
  TBubbleSeriesEditor = class(TSeriesPointerEditor)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.dfm}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TBubbleSeriesEditor.FormShow(Sender: TObject);
begin
  inherited;
  CBDrawPoint.Visible:=False;
end;

initialization
  RegisterClass(TBubbleSeriesEditor);
end.
