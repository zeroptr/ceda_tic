{********************************************}
{ TeeChart Pro Charting Library              }
{ TSubsetTeeFunction editor dialog.          }
{                                            }
{ Copyright (c) 1995-2009 by David Berneda   }
{ All Rights Reserved                        }
{********************************************}
unit TeeSubsetEditor;
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
  TeEngine, TeCanvas, TeeBaseFuncEdit;

type
  TSubsetTeeFunction=class(TTeeFunction)
  private
    FEnd   : TChartValue;
    FStart : TChartValue;

    procedure SetEnd(Const Value:TChartValue);
    procedure SetStart(Const Value:TChartValue);
  protected
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;

    procedure AddPoints(Source:TChartSeries); override;
  published
    property EndValue:TChartValue read FEnd write SetEnd;
    property StartValue:TChartValue read FStart write SetStart;
  end;

  TSubsetFuncEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    EStart: TEdit;
    Label2: TLabel;
    EEnd: TEdit;
    Label3: TLabel;
    CBValues: TComboFlat;
    procedure EStartChange(Sender: TObject);
    procedure EEndChange(Sender: TObject);
    procedure CBValuesChange(Sender: TObject);
  private
    { Private declarations }
    Function Series:TChartSeries;
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
  TeeConst, Chart, TeeFuncEdit;

{ TSubsetFunction }

Constructor TSubsetTeeFunction.Create(AOwner:TComponent);
begin
  inherited;
  CanUsePeriod:=False;
end;

procedure TSubsetTeeFunction.AddPoints(Source:TChartSeries);
var t         : Integer;
    tmp       : TChartValueList;
    tmpValue  : TChartValue;
    tmpSource : String;
begin
  ParentSeries.Clear;

  tmp:=Source.MandatoryValueList;
  tmpSource:=ParentSeries.MandatoryValueList.ValueSource;

  if tmpSource<>'' then
     for t:=0 to Source.ValuesList.Count-1 do
         if Source.ValuesList.ValueList[t].Name=tmpSource then
         begin
           tmp:=Source.ValuesList[t];
           break;
         end;

  if Assigned(tmp) then
     for t:=0 to Source.Count-1 do
     begin
       tmpValue:=Source.NotMandatoryValueList.Value[t];

       if (tmpValue>=FStart) and (tmpValue<=FEnd) then
          if ParentSeries.YMandatory then
             ParentSeries.AddXY(tmpValue,tmp.Value[t])
          else
             ParentSeries.AddXY(tmp.Value[t],tmpValue);
     end;
end;

class function TSubsetTeeFunction.GetEditorClass: String;
begin
  result:='TSubsetFuncEditor';
end;

Procedure TSubsetFuncEditor.SetFunction;
var t : Integer;
begin
  inherited;

  with TSubsetTeeFunction(IFunction) do
  begin
    EStart.Text:=FloatToStr(StartValue);
    EEnd.Text:=FloatToStr(EndValue);

    TTeeFuncEditor.SetValueListCombo(Series,CBValues);
  end;

  if Series<>nil then
  with Series do
  for t:=0 to ValuesList.Count-1 do
      CBValues.Items.AddObject(ValuesList[t].Name,ValuesList[t]);

  CBValues.ItemIndex:=0;
  CBValuesChange(Self);
end;

Function TSubsetFuncEditor.Series:TChartSeries;
begin
  if Owner is TTeeFuncEditor then
     result:=TTeeFuncEditor(Owner).TheSeries
  else
     result:=nil;
end;

procedure TSubsetFuncEditor.ApplyFormChanges;
begin
  inherited;

  with TSubsetTeeFunction(IFunction) do
  begin
    StartValue:=StrToFloat(EStart.Text);
    EndValue:=StrToFloat(EEnd.Text);
    Series.MandatoryValueList.ValueSource:=CBValues.Text;
  end;
end;

procedure TSubsetFuncEditor.EStartChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TSubsetFuncEditor.EEndChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TSubsetFuncEditor.CBValuesChange(Sender: TObject);
var tmpList : TChartValueList;
begin
  if Series.MandatoryValueList.ValueSource='' then
  begin
    tmpList:=TChartValueList(CBValues.SelectedObject);

    EStart.Text:=FloatToStr(tmpList.MinValue);
    EEnd.Text:=FloatToStr(tmpList.MaxValue);
  end;

  EnableApply;
end;

procedure TSubsetTeeFunction.SetEnd(const Value: TChartValue);
begin
  if FEnd<>Value then
  begin
    FEnd:=Value;
    ReCalculate;
  end;
end;

procedure TSubsetTeeFunction.SetStart(const Value: TChartValue);
begin
  if FStart<>Value then
  begin
    FStart:=Value;
    ReCalculate;
  end;
end;

initialization
  RegisterTeeBasicFunction( TSubsetTeeFunction,
                            {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionSubset); // 8.0
  RegisterClass(TSubsetFuncEditor);
finalization
  UnRegisterTeeFunctions([TSubsetTeeFunction]);
end.
