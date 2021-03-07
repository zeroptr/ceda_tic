{********************************************}
{  TAxisScrollTool Editor                    }
{  Copyright (c) 2006-2009 by David Berneda  }
{        All Rights Reserved                 }
{********************************************}
unit TeeAxisScrollEdit;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  {$ENDIF}
  TeeAxisToolEdit, TeCanvas, TeePenDlg;

type
  TAxisScrollEditor = class(TAxisToolEditor)
    CBInverted: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CBInvertedClick(Sender: TObject);
  private
    { Private declarations }
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
  TeeTools;

procedure TAxisScrollEditor.FormShow(Sender: TObject);
begin
  inherited;
  BPen.Hide;

  if Assigned(AxisTool) then
     CBInverted.Checked:=TAxisScrollTool(AxisTool).ScrollInverted;
end;

procedure TAxisScrollEditor.CBInvertedClick(Sender: TObject);
begin
  TAxisScrollTool(AxisTool).ScrollInverted:=CBInverted.Checked;
end;

initialization
  RegisterClass(TAxisScrollEditor);
end.
