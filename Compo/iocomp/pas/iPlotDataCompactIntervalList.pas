{*******************************************************}
{                                                       }
{       TiPlotDataCompactIntervalList                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotDataCompactIntervalList;{$endif}                             
{$ifdef iCLX}unit QiPlotDataCompactIntervalList;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iPlotDataCustomList;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiPlotDataCustomList;{$ENDIF}

type                                                               
  TiPlotDataCompactInterval = record
    Y : Single;
  end;
type
  TiPlotDataCompactIntervalArray = array[0..(Maxint div SizeOf(TiPlotDataCompactInterval)) - 1] of TiPlotDataCompactInterval;
  PiPlotDataCompactIntervalArray = ^TiPlotDataCompactIntervalArray;

  TiPlotDataCompactIntervalList = class(TiPlotDataCustomList)
  private
    FList     : PiPlotDataCompactIntervalArray;
    FInterval : Double;
    FFirstX   : Double;
  protected
    function  GetX(const Index: Integer): Double;             override;
    function  GetY(const Index: Integer): Double;             override;

    procedure SetX(const Index: Integer; const Value: Double);override;
    procedure SetY(const Index: Integer; const Value: Double);override;

    procedure FreeMemory;                                     override;
  public
    constructor Create;                                       override;

    procedure Clear;                                          override;

    procedure GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean); override;

    function  Add(const X, Y: Double; const Null, Empty: Boolean): Integer; override;
    procedure SetCapacity(const NewCapacity: Integer);        override;
    procedure DeletePoints(const Size : Integer);             override;

    property Interval : Double read FInterval write FInterval;
  end;
                                      
implementation
//****************************************************************************************************************************************************
constructor TiPlotDataCompactIntervalList.Create;
begin
  inherited Create;
  SetDataPointSize(SizeOf(TiPlotDataCompactInterval));
  FInterval := -1;
  FFirstX   := 0;
end;
//****************************************************************************************************************************************************
function TiPlotDataCompactIntervalList.Add(const X, Y: Double; const Null, Empty: Boolean): Integer;
var
  ActualIndex : Integer;
begin
  if Count < 2 then
    begin
      if (Count = 0)                      then FFirstX   := X;
      if (Count = 1) and (FInterval = -1) then FInterval := X - FFirstX;
    end;

  if RingBufferEnabled then
    begin
      if Count < Capacity then
        begin
          FList^[Count].Y := Y;
          Result := Count;
          Count := Count + 1;
        end
      else
        begin
          Tail := Tail + 1;
          if Tail = Count then Tail := 0;
          if Tail <> 0 then ActualIndex := Tail-1 else ActualIndex := Count-1;
          FList^[ActualIndex].Y := Y;
          Result := ActualIndex;
          if Count > 1 then FFirstX := GetX(1);
        end;
    end
  else
    begin
      Result := Count;
      if Result = Capacity then Grow;
      FList^[Result].Y := Y;
      Count := Count + 1;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactIntervalList.FreeMemory;
begin
  FreeMem(FList);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactIntervalList.SetCapacity(const NewCapacity: Integer);
begin
  if (NewCapacity > (Maxint div DataPointSize)) then raise Exception.Create('Exceed Maximum List Size');
  if NewCapacity <> Capacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TiPlotDataCompactInterval));
    Capacity := NewCapacity;
    if Capacity < Count then Count := Capacity;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactIntervalList.DeletePoints(const Size: Integer);
begin
  if (Size < 0) or (Size > Count) then raise Exception.Create('Delete size out of Range');
  Count := Count - Size;
  if Count > 0 then System.Move(FList^[Size], FList^[0], (Count) * SizeOf(TiPlotDataCompactInterval));
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactIntervalList.GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean);
var
  Data : TiPlotDataCompactInterval;
begin
  Data   := FList^[GetActualIndex(Index)];
  X      := FFirstX + Index * FInterval;
  Y      := Data.Y;
  Empty := False;
  Null  := False;
end;
//****************************************************************************************************************************************************
function TiPlotDataCompactIntervalList.GetX(const Index: Integer): Double;
begin
  Result := FFirstX + Index * FInterval;
end;
//****************************************************************************************************************************************************
function TiPlotDataCompactIntervalList.GetY(const Index: Integer): Double;
begin
  Result := FList^[GetActualIndex(Index)].Y;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactIntervalList.SetX(const Index: Integer; const Value: Double);
begin
  if (Count <> 0) and (Index = 0) then
    begin
      FFirstX := Value;
    end
  else raise Exception.Create('Data Style does not support setting individual X-Value with the exception of the first X-Value');
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactIntervalList.SetY(const Index: Integer; const Value: Double);
begin
  FList^[GetActualIndex(Index)].Y := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactIntervalList.Clear;
begin
  inherited;
  FInterval := -1;
end;
//****************************************************************************************************************************************************
end.
