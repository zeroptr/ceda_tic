{********************************************}
{     TeeChart Pro Charting Library          }
{ Copyright (c) 1995-2009 by David Berneda   }
{         All Rights Reserved                }
{********************************************}
unit TeeADXFuncEditor;
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
  Graphics, Controls, Forms, Dialogs, StdCtrls, ComCtrls,
  {$ENDIF}
  CandleCh, TeCanvas, TeePenDlg, TeeBaseFuncEdit;

type
  TADXFuncEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    EPeriod: TEdit;
    UDPeriod: TUpDown;
    BUp: TButtonPen;
    BDown: TButtonPen;
    procedure EPeriodChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ApplyFormChanges; override;
    Procedure SetFunction; override;
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
  TeEngine, TeeFuncEdit;

procedure TADXFuncEditor.EPeriodChange(Sender: TObject);
begin
  if Showing then
     EnableApply;
end;

procedure TADXFuncEditor.ApplyFormChanges;
begin
  inherited;

  IFunction.Period:=UDPeriod.Position;
end;

procedure TADXFuncEditor.SetFunction;
begin
  inherited;

  with TADXFunction(IFunction) do
  begin
    UDPeriod.Position:=Round(Period);
    BUp.LinkPen(UpLinePen);
    BDown.LinkPen(DownLinePen);
  end;
end;

initialization
  RegisterClass(TADXFuncEditor);
end.

