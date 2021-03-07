{********************************************}
{ TeeChart Pro Charting Library              }
{ Custom TeeFunction Editor                  }
{ Copyright (c) 2002-2009 by David Berneda   }
{ All Rights Reserved                        }
{********************************************}
unit TeeCustomFuncEditor;
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
  TeEngine, TeeFunci, TeeBaseFuncEdit;

type
  TCustomFunctionEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    EStart: TEdit;
    Label2: TLabel;
    EStep: TEdit;
    ENum: TEdit;
    Label3: TLabel;
    procedure EStartChange(Sender: TObject);
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
{$R *.dfm}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

procedure TCustomFunctionEditor.EStartChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TCustomFunctionEditor.ApplyFormChanges;
begin
  inherited;

  with TCustomTeeFunction(IFunction) do
  begin
    StartX:=StrToFloat(EStart.Text);
    Period:=StrToFloat(EStep.Text);
    NumPoints:=StrToInt(ENum.Text);
  end;
end;

procedure TCustomFunctionEditor.SetFunction;
begin
  inherited;

  with TCustomTeeFunction(IFunction) do
  begin
    EStart.Text:=FloatToStr(StartX);
    EStep.Text:=FloatToStr(Period);
    ENum.Text:=IntToStr(NumPoints);
  end;
end;

initialization
  RegisterClass(TCustomFunctionEditor);
end.

