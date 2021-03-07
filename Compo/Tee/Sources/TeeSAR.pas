{**********************************************}
{   TSARFunction                               }
{   Financial indicator Stop and Reversal      }
{   Copyright (c) 2006-2009 by Steema Software }
{**********************************************}
unit TeeSAR;
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
  TeeProcs, TeEngine, OHLChart, Chart, TeeBaseFuncEdit;

type
  TSARFunction=class(TTeeFunction)
  private
    FAF : Double; // Acceleration Factor
    FMS : Double; // Max Step

    procedure SetAF(const Value: Double);
    procedure SetMS(const Value: Double);
  protected
    class Function GetEditorClass:String; override;
    Function IsValidSource(Value:TChartSeries):Boolean; override;
  public
    Constructor Create(AOwner: TComponent); override;

    procedure AddPoints(Source: TChartSeries); override;
  published
    property AccelerationFactor:Double read FAF write SetAF;
    property MaxStep:Double read FMS write SetMS;
  end;

  TSARFuncEditor = class(TBaseFunctionEditor)
    Label1: TLabel;
    Label2: TLabel;
    EAccel: TEdit;
    EMaxStep: TEdit;
    procedure EAccelChange(Sender: TObject);
    procedure EMaxStepChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ApplyFormChanges; override;
    Procedure SetFunction; override;
  public
    { Public declarations }
  end;

{
+ Info:
http://www.linnsoft.com/tour/techind/sar.htm
http://calderone.eresmas.com/parabolic_sar.htm
http://es.biz.yahoo.com/edu/tech/osciladores1014.html

http://www.trade10.com/parabolic_s&r.htm
http://www.market-analyst.com/kb/article.php/Parabolic_Stop_and_Reverse/
http://www.incrediblecharts.com/technical/parabolic_sar_construction.htm
http://trader.online.pl/

http://www.amibroker.com/library/formula.php?id=242
http://www.amibroker.com/library/formula.php?id=241
}
implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  TeeProCo;

Constructor TSARFunction.Create(AOwner: TComponent);
begin
  inherited;

  CanUsePeriod:=False;
  SingleSource:=True;

  FAF:=0.02;
  FMS:=0.20;
end;

class Function TSARFunction.GetEditorClass:String;
begin
  result:='TSARFuncEditor';
end;

function TSARFunction.IsValidSource(Value: TChartSeries): Boolean;
begin
  result:=Value is TOHLCSeries;
end;

function Min(const x,y,z: Double): Double;
begin
  if x < y then result := x
           else result := y;

  if z < result then result := z;
end;

function Max(const x,y,z: Double): Double;
begin
  if x > y then result := x
           else result := y;

  if z > result then result := z;
end;

// http://www.amibroker.com/library/formula.php?id=241
procedure TSARFunction.AddPoints(Source: TChartSeries);
var
  af, ep,
  hp, lp: Double;
  psar : Array of Double;
  i,
  reverse : Integer;
  LongPos : Boolean;
  tmpSource : TOHLCSeries;
begin
  ParentSeries.Clear;

  if Source.Count<=2 then
     Exit;

  tmpSource:=TOHLCSeries(Source);

  SetLength(psar, tmpSource.Count);
  try
    psar[0] := tmpSource.CloseValues[0];
    psar[1] := tmpSource.HighValues[1];

    LongPos := true;
    af := FAF;
    ep := tmpSource.LowValues[0];
    hp := tmpSource.HighValues[0];
    lp := ep;

    for i:=2 to tmpSource.Count-1 do
    begin
      if LongPos then
         psar[i] := psar[i-1] + af * (hp - psar[i-1])
      else
         psar[i] := psar[i-1] + af * (lp - psar[i-1]);

      Reverse := 0;

      // Check for reversal

      if LongPos then
      begin
        if tmpSource.LowValues[i] < psar[i] then
        begin
          LongPos := False;
          reverse := 1;           // reverse position to short
          psar[i] := hp;          // sar is high point in prev trade
          lp := tmpSource.LowValues[i];
          af := FAF;
        end;
      end
      else
      begin
        if tmpSource.HighValues[i] > psar[i] then
        begin
          LongPos := True;
          reverse := 1;           // reverse position to long
          psar[i] := lp;
          hp := tmpSource.HighValues[i];
          af := FAF;
        end;
      end;

      if Reverse = 0 then
      begin
        if LongPos then
        begin
          if tmpSource.HighValues[i] > hp then
          begin
            hp := tmpSource.HighValues[i];
            af := Min(af+FAF, FMS, FMS);
          end;

          psar[i] := Min(psar[i], tmpSource.LowValues[i-1], tmpSource.LowValues[i-2]);
        end
        else
        begin
          if tmpSource.LowValues[i] < lp then
          begin
            lp:= tmpSource.LowValues[i];
            af:= Min(af+FAF, FMS, FMS);
          end;

          psar[i] := Max(psar[i], tmpSource.HighValues[i-1], tmpSource.HighValues[i-2]);
        end;
      end;
    end;

    for i:= 2 to tmpSource.Count-1 do
        AddFunctionXY(tmpSource.YMandatory, tmpSource.NotMandatoryValueList.Value[i], psar[i]);

  finally
    psar := nil;
  end;
end;

procedure TSARFunction.SetAF(const Value:Double);
begin
  if FAF<>Value then
  begin
    FAF:=Value;
    ReCalculate;
  end;
end;

procedure TSARFunction.SetMS(const Value:Double);
begin
  if FMS<>Value then
  begin
    FMS:=Value;
    ReCalculate;
  end;
end;

{ TSARFuncEditor }
procedure TSARFuncEditor.ApplyFormChanges;
begin
  inherited;

  with TSARFunction(IFunction) do
  begin
    AccelerationFactor:=StrToFloatDef(EAccel.Text,AccelerationFactor);
    MaxStep:=StrToFloatDef(EMaxStep.Text,MaxStep);
  end;
end;

procedure TSARFuncEditor.SetFunction;
begin
  inherited;

  with TSARFunction(IFunction) do
  begin
    EAccel.Text:=FloatToStr(AccelerationFactor);
    EMaxStep.Text:=FloatToStr(MaxStep);
  end;
end;

const
  TeeMsg_SARFunction:String='SAR';

procedure TSARFuncEditor.EAccelChange(Sender: TObject);
begin
  EnableApply;
end;

procedure TSARFuncEditor.EMaxStepChange(Sender: TObject);
begin
  EnableApply;
end;

initialization
  RegisterClass(TSARFuncEditor);
  RegisterTeeFunction(TSARFunction,{$IFNDEF CLR}@{$ENDIF}TeeMsg_SARFunction,
                                   {$IFNDEF CLR}@{$ENDIF}TeeMsg_GalleryFinancial);
finalization
  UnRegisterTeeFunctions([TSARFunction]);
end.
