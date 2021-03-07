{*******************************************************}
{                                                       }
{       TiPlotDataScopeList                             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotDataScopeList;{$endif}
{$ifdef iCLX}unit QiPlotDataScopeList;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iPlotDataCustomList;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiPlotDataCustomList;{$ENDIF}

type
  TiPlotDataScope = record
    Y     : Single;
    Level : Single;
  end;
type
  TiPlotDataScopeArray = array[0..(Maxint div SizeOf(TiPlotDataScope)) - 1] of TiPlotDataScope;
  PiPlotDataScopeArray = ^TiPlotDataScopeArray;

  TiPlotDataScopeList = class(TiPlotDataCustomList)
  private
    FList     : PiPlotDataScopeArray;
    FMin      : Double;
    FMax      : Double;
  protected
    function  GetX    (const Index: Integer): Double;             override;
    function  GetY    (const Index: Integer): Double;             override;
    function  GetLevel(const Index: Integer): Double;

    procedure SetX    (const Index: Integer; const Value: Double);override;         
    procedure SetY    (const Index: Integer; const Value: Double);override;
    procedure SetLevel(const Index: Integer; const Value: Double);

    procedure FreeMemory;                                     override;
  public
    constructor Create;                                       override;

    procedure Clear;                                          override;

    procedure UpdateLevel(StartIndex, StopIndex: Integer);

    procedure GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean); override;

    function  Add(const X, Y: Double; const Null, Empty: Boolean): Integer; override;
    procedure SetCapacity(const NewCapacity: Integer);                      override;
    procedure DeletePoints(const Size : Integer);                           override;

    property Level[const Index: Integer]: Double read GetLevel write SetLevel;

    property Max      : Double read FMax;
    property Min      : Double read FMin;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPlotDataScopeList.Create;
begin
  inherited Create;
  SetDataPointSize(SizeOf(TiPlotDataScope));
end;
//****************************************************************************************************************************************************
function TiPlotDataScopeList.Add(const X, Y: Double; const Null, Empty: Boolean): Integer;
begin
  Result := Count;
  if Result = Capacity then Grow;
  FList^[Result].Y := Y;
  Count := Count + 1;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.FreeMemory;
begin
  FreeMem(FList);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.SetCapacity(const NewCapacity: Integer);
begin
  if (NewCapacity > (Maxint div DataPointSize)) then raise Exception.Create('Exceed Maximum List Size');
  if NewCapacity <> Capacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TiPlotDataScope));
    Capacity := NewCapacity;
    if Capacity < Count then Count := Capacity;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.DeletePoints(const Size: Integer);
begin
  if (Size < 0) or (Size > Count) then raise Exception.Create('Delete size out of Range');
  Count := Count - Size;
  if Count > 0 then System.Move(FList^[Size], FList^[0], (Count) * SizeOf(TiPlotDataScope));
end;
//****************************************************************************************************************************************************
function TiPlotDataScopeList.GetX(const Index: Integer): Double;
begin
  Result := 0;
end;
//****************************************************************************************************************************************************
function TiPlotDataScopeList.GetY(const Index: Integer): Double;
begin
  Result := FList^[(Index)].Y;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.SetX(const Index: Integer; const Value: Double);
begin
  raise Exception.Create('Data Style does not support setting X-Value');
end;
//****************************************************************************************************************************************************
function TiPlotDataScopeList.GetLevel(const Index: Integer): Double;
begin
  Result := FList^[(Index)].Level;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.SetY(const Index: Integer; const Value: Double);
begin
  FList^[(Index)].Y := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.SetLevel(const Index: Integer; const Value: Double);
begin
  FList^[(Index)].Level := Value;       
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.Clear;
begin
  inherited Clear;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.UpdateLevel(StartIndex, StopIndex: Integer);
var
  DataIndex         : Integer;
  PeakToPeakPercent : Double;
  YData             : Double;
  NeedNoise         : Boolean;
begin
  FMax      := -1E300;
  FMin      := +1E300;
  NeedNoise := False;

  for DataIndex := 0 to Count-1 do
    begin
      YData := Y[DataIndex];
      if YData > FMax then FMax := YData;
      if YData < FMin then FMin := YData;
    end;

  if FMax = FMin then
    begin
      FMax      := FMax + 1E-5;
      NeedNoise := True;
    end;

  PeakToPeakPercent := (FMax - FMin)/100;

  for DataIndex := StartIndex to StopIndex do
    if NeedNoise then
      Level[DataIndex] := (Y[DataIndex] + Random(2)/1E5 - FMin)/PeakToPeakPercent
    else
      Level[DataIndex] := (Y[DataIndex]                 - FMin)/PeakToPeakPercent
end;
//****************************************************************************************************************************************************
procedure TiPlotDataScopeList.GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean);
begin
end;
//****************************************************************************************************************************************************
end.
