{**********************************************}
{   TeeChart - CurveFitting function editor    }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeCurveFittingEditor;
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
  TeCanvas, CurvFitt, TeeBaseFuncEdit;

type
  TCurveFittingEditor = class(TBaseFunctionEditor)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    UDDegree: TUpDown;
    Edit2: TEdit;
    UDFactor: TUpDown;
    Label3: TLabel;
    Label4: TLabel;
    Edit3: TEdit;
    UDFirstCalc: TUpDown;
    Edit4: TEdit;
    UDLastCalc: TUpDown;
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    UDFirst: TUpDown;
    Edit6: TEdit;
    UDLast: TUpDown;
    CBAllCalc: TCheckBox;
    CBAllDisp: TCheckBox;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure CBAllCalcClick(Sender: TObject);
    procedure CBAllDispClick(Sender: TObject);
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
  TeEngine;

procedure TCurveFittingEditor.Edit1Change(Sender: TObject);
begin
  if Showing then
     EnableApply;
end;

procedure TCurveFittingEditor.Edit2Change(Sender: TObject);
begin
  if Showing then
     EnableApply;
end;

procedure TCurveFittingEditor.Edit3Change(Sender: TObject);
begin
  if Showing then
     EnableApply;
end;

procedure TCurveFittingEditor.Edit4Change(Sender: TObject);
begin
  if Showing then
     EnableApply;
end;

procedure TCurveFittingEditor.Edit5Change(Sender: TObject);
begin
  if Showing then
     EnableApply;
end;

procedure TCurveFittingEditor.Edit6Change(Sender: TObject);
begin
  if Showing then
     EnableApply;
end;

procedure TCurveFittingEditor.CBAllCalcClick(Sender: TObject);
begin
  UDFirstCalc.Position:=-1;
  UDLastCalc.Position:=-1;
  EnableApply;
end;

procedure TCurveFittingEditor.CBAllDispClick(Sender: TObject);
begin
  UDFirst.Position:=-1;
  UDLast.Position:=-1;
  EnableApply;
end;

procedure TCurveFittingEditor.ApplyFormChanges;
begin
  inherited;

  with TCurveFittingFunction(IFunction) do
  begin
    PolyDegree:=UDDegree.Position;
    Factor:=UDFactor.Position;
    FirstCalcPoint:=UDFirstCalc.Position;
    LastCalcPoint:=UDLastCalc.Position;
    FirstPoint:=UDFirst.Position;
    LastPoint:=UDLast.Position;
  end;
end;

procedure TCurveFittingEditor.SetFunction;
begin
  inherited;

  with TCurveFittingFunction(IFunction) do
  begin
    UDDegree.Position:=PolyDegree;
    UDFactor.Position:=Factor;

    UDFirstCalc.Position:=FirstCalcPoint;
    UDLastCalc.Position:=LastCalcPoint;
    CBAllCalc.Checked:=(FirstCalcPoint=TeeAllValues) and
                       (LastCalcPoint=TeeAllValues);

    UDFirst.Position:=FirstPoint;
    UDLast.Position:=LastPoint;
    CBAllDisp.Checked:=(FirstPoint=TeeAllValues) and
                       (LastPoint=TeeAllValues);
  end;
end;

initialization
  RegisterClass(TCurveFittingEditor);
end.
