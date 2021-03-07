{******************************************}
{ TeeChart Exp.Average Function Editor     }
{ Copyright (c) 2002-2009 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit TeeExpAveFuncEdit;
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
  StatChar, TeeBaseFuncEdit, TeCanvas, TeEngine;

type
  TExpAveFuncEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    CBAlign: TComboFlat;
    procedure Edit1Change(Sender: TObject);
    procedure CBAlignChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ApplyFormChanges; override;
    procedure SetFunction; override;
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

procedure TExpAveFuncEditor.Edit1Change(Sender: TObject);
begin
  EnableApply;
end;

procedure TExpAveFuncEditor.SetFunction;
begin
  inherited;

  Edit1.Text:=FloatToStr(TExpAverageFunction(IFunction).Weight);
  CBAlign.ItemIndex:=Ord(IFunction.PeriodAlign);
end;

procedure TExpAveFuncEditor.ApplyFormChanges;
begin
  inherited;
  TExpAverageFunction(IFunction).Weight:=StrToFloat(Edit1.Text);
  IFunction.PeriodAlign:=TFunctionPeriodAlign(CBAlign.ItemIndex);
end;

procedure TExpAveFuncEditor.CBAlignChange(Sender: TObject);
begin
  EnableApply;
end;

initialization
  RegisterClass(TExpAveFuncEditor);
end.
