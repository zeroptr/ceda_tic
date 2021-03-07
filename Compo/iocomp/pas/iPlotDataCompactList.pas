{*******************************************************}
{                                                       }
{       TiPlotDataCompactList                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }                 
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotDataCompactList;{$endif}
{$ifdef iCLX}unit QiPlotDataCompactList;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iPlotDataCustomList;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiPlotDataCustomList;{$ENDIF}

type
  TiPlotDataSingle = record
    X : Single;
    Y : Single;
  end;
type
  TiPlotDataSingleArray = array[0..(Maxint div SizeOf(TiPlotDataSingle)) - 1] of TiPlotDataSingle;
  PiPlotDataSingleArray = ^TiPlotDataSingleArray;

  TiPlotDataCompactList = class(TiPlotDataCustomList)
  private
    FList : PiPlotDataSingleArray;
  protected
    function  GetX(const Index: Integer): Double;              override;
    function  GetY(const Index: Integer): Double;              override;

    procedure SetX(const Index: Integer; const Value: Double); override;
    procedure SetY(const Index: Integer; const Value: Double); override;

    procedure FreeMemory;                                      override;
  public
    constructor Create;                                        override;

    procedure GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean); override;

    function  Add(const X, Y: Double; const Null, Empty: Boolean): Integer; override;
    procedure SetCapacity(const NewCapacity: Integer);         override;
    procedure DeletePoints(const Size : Integer);              override;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPlotDataCompactList.Create;
begin
  inherited Create;
  SetDataPointSize(SizeOf(TiPlotDataSingle));
end;
//****************************************************************************************************************************************************
function TiPlotDataCompactList.Add(const X, Y: Double; const Null, Empty: Boolean): Integer;
var
  ActualIndex : Integer;
  Item        : TiPlotDataSingle;
begin
  Item.X     := X;
  Item.Y     := Y;

  if RingBufferEnabled then
    begin
      if Count < Capacity then
        begin
          FList^[Count] := Item;
          Result := Count;
          Count := Count + 1;
        end
      else
        begin
          Tail := Tail + 1;
          if Tail = Count then Tail := 0;
          if Tail <> 0 then ActualIndex := Tail-1 else ActualIndex := Count-1;
          FList^[ActualIndex] := Item;
          Result := ActualIndex;
        end;
    end
  else
    begin
      Result := Count;
      if Result = Capacity then Grow;
      FList^[Result] := Item;
      Count := Count + 1;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactList.FreeMemory;
begin
  FreeMem(FList);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactList.SetCapacity(const NewCapacity: Integer);
begin
  if (NewCapacity > (Maxint div DataPointSize)) then raise Exception.Create('Exceed Maximum List Size');
  if NewCapacity <> Capacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TiPlotDataSingle));
    Capacity := NewCapacity;
    if Capacity < Count then Count := Capacity;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactList.DeletePoints(const Size: Integer);
begin
  if (Size < 0) or (Size >= Count) then raise Exception.Create('Delete size out of Range');
  Count := Count - Size;
  if Count > 0 then System.Move(FList^[Size], FList^[0], (Count) * SizeOf(TiPlotDataSingle));
end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactList.GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean);
var
  Data : TiPlotDataSingle;
begin
  Data   := FList^[GetActualIndex(Index)];
  X      := Data.X;
  Y      := Data.Y;
  Empty := False;
  Null  := False;
end;
//****************************************************************************************************************************************************
function TiPlotDataCompactList.GetX(const Index: Integer): Double;begin Result := FList^[GetActualIndex(Index)].X;end;
function TiPlotDataCompactList.GetY(const Index: Integer): Double;begin Result := FList^[GetActualIndex(Index)].Y;end;
//****************************************************************************************************************************************************
procedure TiPlotDataCompactList.SetX(const Index: Integer; const Value: Double);begin FList^[GetActualIndex(Index)].X := Value;end;
procedure TiPlotDataCompactList.SetY(const Index: Integer; const Value: Double);begin FList^[GetActualIndex(Index)].Y := Value;end;
//****************************************************************************************************************************************************
end.
