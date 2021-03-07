{************************************************}
{ TCCIFunction (Commodity Chanel Index)          }
{ Copyright (c) 2002-2009 by David Berneda       }
{ Portions Copyright (c) 2004-2009 Inverline.com }
{************************************************}
unit TeeCCIFunction;
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
  OHLChart, TeEngine, TeCanvas, Chart, TeeBaseFuncEdit, StatChar;

type
  TCCIFunction=class(TTeeFunction)
  private
    FAveSeries : TChartSeries;
    FConstant  : Double;
    FMovAve    : TMovingAverageFunction;
    FTypical   : TChartSeries;
    function IsConstStored: Boolean;
    procedure SetConstant(const Value: Double);
  protected
    class Function GetEditorClass:String; override;
    Function IsValidSource(Value:TChartSeries):Boolean; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;
    procedure AddPoints(Source:TChartSeries); override;
  published
    property Constant:Double read FConstant write SetConstant stored IsConstStored;
  end;

  TCCIFuncEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    EConst: TEdit;
    Label2: TLabel;
    EPeriod: TEdit;
    UDPeriod: TUpDown;
    procedure EConstChange(Sender: TObject);
    procedure EPeriodChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  TeeProCo, TeeProcs, TeeConst;

{ TCCIFunction }
Constructor TCCIFunction.Create(AOwner: TComponent);
begin
  inherited;
  InternalSetPeriod(20);
  CanUsePeriod:=True;
  SingleSource:=True;
  HideSourceList:=True;

  FTypical:=TChartSeries.Create(nil);
  FMovAve:=TMovingAverageFunction.Create(nil);
  FAveSeries:=TChartSeries.Create(nil);
  FAveSeries.SetFunction(FMovAve);
end;

Destructor TCCIFunction.Destroy;
begin
  FAveSeries.Free;
  FTypical.Free;
  inherited;
end;

procedure TCCIFunction.AddPoints(Source: TChartSeries);
var tmpPeriod : Integer;

  Function MeanDeviation(Index:Integer):Double;
  var tmpTotal : Double;
      t        : Integer;
  begin
    tmpTotal:=0;

    for t:=Index-tmpPeriod+1 to Index do
      tmpTotal:=tmpTotal+Abs(FAveSeries.MandatoryValueList.Value[Index-tmpPeriod+1]-
                             FTypical.MandatoryValueList[t]);

    result:=tmpTotal/tmpPeriod;
  end;

  Procedure CalculateMovAve;
  const Third=1/3.0;
  var t : Integer;
  begin
    FTypical.Clear;
    FMovAve.Period:=tmpPeriod;
    FTypical.BeginUpdate;

    for t:=0 to Source.Count-1 do
        with TOHLCSeries(Source) do
           FTypical.Add( (HighValues.Value[t]+
                          LowValues.Value[t]+
                          CloseValues.Value[t]
                          )*Third );
    FTypical.EndUpdate;

    FAveSeries.BeginUpdate;  // 7.01
    try
      FAveSeries.Clear;

      for t:=tmpPeriod-1 to FTypical.Count-1 do
        FAveSeries.Add(FMovAve.Calculate(FTypical,t-tmpPeriod+1,t));
    finally
      FAveSeries.EndUpdate;
    end;
  end;

var t   : Integer;
    tmp : Double;
    tmpConstant : Double;
    tmpMean     : Double;
begin
  ParentSeries.Clear;

  tmpPeriod:=Round(Period);
  if (tmpPeriod>0) and (Source.Count >= tmpPeriod) then
  begin
    CalculateMovAve;

    tmpConstant:=Constant;
    if tmpConstant=0 then tmpConstant:=1;

    for t:=tmpPeriod-1 to Source.Count-1 do
    begin
      tmpMean:=MeanDeviation(t);

      if tmpMean<>0 then // Skip zero mean deviation 7.05
      begin
        tmp:=( FTypical.MandatoryValueList.Value[t]-
               FAveSeries.MandatoryValueList.Value[t-tmpPeriod+1] ) /
                  ( tmpConstant*tmpMean );

        ParentSeries.AddXY(Source.NotMandatoryValueList.Value[t],tmp);
      end;
    end;
  end;
end;

class function TCCIFunction.GetEditorClass: String;
begin
  result:='TCCIFuncEditor'; // Do not localize
end;

function TCCIFunction.IsValidSource(Value: TChartSeries): Boolean;
begin
  result:=Value is TOHLCSeries;
end;

function TCCIFunction.IsConstStored: Boolean;
begin
  result:=FConstant<>0.015;
end;

procedure TCCIFunction.SetConstant(const Value: Double);
begin
  if FConstant<>Value then
  begin
    FConstant := Value;
    Recalculate;
  end;
end;

{ TCCIFuncEditor }
procedure TCCIFuncEditor.ApplyFormChanges;
begin
  inherited;
  with TCCIFunction(IFunction) do
  begin
    Constant:=StrToFloatDef(EConst.Text,Constant);
    Period:=UDPeriod.Position;
  end;
end;

procedure TCCIFuncEditor.SetFunction;
begin
  inherited;
  with TCCIFunction(IFunction) do
  begin
    EConst.Text:=FloatToStr(Constant);
    UDPeriod.Position:=Round(Period);
  end;
end;

procedure TCCIFuncEditor.EConstChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TCCIFuncEditor.EPeriodChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TCCIFuncEditor.FormCreate(Sender: TObject);
begin
  inherited;
  EConst.Text:=FloatToStr(0.015); // due to locale settings...
end;

initialization
  RegisterClass(TCCIFuncEditor);
  RegisterTeeFunction( TCCIFunction,
      {$IFNDEF CLR}@{$ENDIF}TeeMsg_FunctionCCI,
      {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial );
finalization
  UnRegisterTeeFunctions([ TCCIFunction ]);
end.
