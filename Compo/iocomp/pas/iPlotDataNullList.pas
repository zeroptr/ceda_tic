{*******************************************************}
{                                                       }
{       TiPlotDataNullList                              }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }         
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotDataNullList;{$endif}
{$ifdef iCLX}unit QiPlotDataNullList;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iPlotDataCustomList;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiPlotDataCustomList;{$ENDIF}

type
  TiPlotDataNull = record
    X     : Double;
    Y     : Double;
    Extra : Word;    // Bit 0 = Null  Bit 1 = Empty  Bit 2 Show Marker  Bit 3-6 = MarkerStyle
  end;
type
  TiPlotDataNullArray = array[0..(Maxint div SizeOf(TiPlotDataNull)) - 1] of TiPlotDataNull;
  PiPlotDataNullArray = ^TiPlotDataNullArray;

  TiPlotDataNullList = class(TiPlotDataCustomList)
  private
    FList : PiPlotDataNullArray;
  protected
    function  GetX            (const Index: Integer): Double;                         override;
    function  GetY            (const Index: Integer): Double;                         override;
    function  GetNull         (const Index: Integer): Boolean;                        override;
    function  GetEmpty        (const Index: Integer): Boolean;                        override;

    procedure SetX            (const Index: Integer; const Value: Double);            override;
    procedure SetY            (const Index: Integer; const Value: Double);            override;
    procedure SetNull         (const Index: Integer; const Value: Boolean);           override;
    procedure SetEmpty        (const Index: Integer; const Value: Boolean);           override;

    function  GetMarkerVisible(const Index: Integer): Boolean;                        override;
    function  GetMarkerStyle  (const Index: Integer): TiPlotMarkerStyle;              override;

    procedure SetMarkerVisible(const Index: Integer; const Value: Boolean);           override;
    procedure SetMarkerStyle  (const Index: Integer; const Value: TiPlotMarkerStyle); override;

    procedure FreeMemory;                                                             override;
  public
    constructor Create;                                                               override;

    function  Add(const X, Y: Double; const Null, Empty: Boolean): Integer;           override;
    procedure SetCapacity(const NewCapacity: Integer);                                override;
    procedure DeletePoints(const Size : Integer);                                     override;

    procedure GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean); override;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiPlotDataNullList.Create;
begin
  inherited Create;
  SetDataPointSize(SizeOf(TiPlotDataNull));
end;
//****************************************************************************************************************************************************
function TiPlotDataNullList.Add(const X, Y: Double; const Null, Empty: Boolean): Integer;
var
  ActualIndex : Integer;
  Item        : TiPlotDataNull;
begin
  Item.X     := X;
  Item.Y     := Y;

  if StoredMarkerVisible then
    Item.Extra := 4 or ((ord(StoredMarkerStyle) and $000F) shl 3)
  else
    Item.Extra :=      ((ord(StoredMarkerStyle) and $000F) shl 3);

  if Null then
    Item.Extra := Item.Extra or  $0001
  else
    Item.Extra := Item.Extra and $FFFE;

  if Empty then
    Item.Extra := Item.Extra or  $0002
  else
    Item.Extra := Item.Extra and $FFFD;

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
procedure TiPlotDataNullList.FreeMemory;
begin
  FreeMem(FList);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.SetCapacity(const NewCapacity: Integer);
begin
  if (NewCapacity > (Maxint div DataPointSize)) then raise Exception.Create('Exceed Maximum List Size');
  if NewCapacity <> Capacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TiPlotDataNull));
    Capacity := NewCapacity;
    if Capacity < Count then Count := Capacity;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.DeletePoints(const Size: Integer);
begin
  if (Size < 0) or (Size >= Count) then raise Exception.Create('Delete size out of Range');
  Count := Count - Size;
  if Count > 0 then System.Move(FList^[Size], FList^[0], (Count) * SizeOf(TiPlotDataNull));
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean);
var
  Data : TiPlotDataNull;
begin
  Data  := FList^[GetActualIndex(Index)];
  X     := Data.X;
  Y     := Data.Y;
  Empty := (Data.Extra and $0002) = 2;
  Null  := (Data.Extra and $0001) = 1;
end;
//****************************************************************************************************************************************************
function TiPlotDataNullList.GetX(const Index: Integer): Double;    
begin
  Result := FList^[GetActualIndex(Index)].X;
end;
//****************************************************************************************************************************************************
function TiPlotDataNullList.GetY(const Index: Integer): Double;
begin
  Result := FList^[GetActualIndex(Index)].Y;
end;
//****************************************************************************************************************************************************
function TiPlotDataNullList.GetNull(const Index: Integer): Boolean;
begin
  Result := (FList^[GetActualIndex(Index)].Extra and $0001) = 1;
end;
//****************************************************************************************************************************************************
function TiPlotDataNullList.GetEmpty(const Index: Integer): Boolean;
begin
  Result := (FList^[GetActualIndex(Index)].Extra and $0002) = 2;
end;
//****************************************************************************************************************************************************
function TiPlotDataNullList.GetMarkerVisible(const Index: Integer): Boolean;
begin
  Result := (FList^[GetActualIndex(Index)].Extra and $0004) = 4;
end;
//****************************************************************************************************************************************************
function TiPlotDataNullList.GetMarkerStyle(const Index: Integer): TiPlotMarkerStyle;
begin
  Result := TiPlotMarkerStyle((FList^[GetActualIndex(Index)].Extra and $0078) shr 3);
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.SetX(const Index: Integer; const Value: Double);
begin
  FList^[GetActualIndex(Index)].X := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.SetY(const Index: Integer; const Value: Double);
begin
  FList^[GetActualIndex(Index)].Y := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.SetNull(const Index: Integer; const Value: Boolean);
var
  iPlotDataNull : TiPlotDataNull;
begin
  iPlotDataNull := FList^[GetActualIndex(Index)];

  if Value then
    iPlotDataNull.Extra := iPlotDataNull.Extra or  $0001
  else
    iPlotDataNull.Extra := iPlotDataNull.Extra and $FFFE;

  FList^[GetActualIndex(Index)] := iPlotDataNull;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.SetEmpty(const Index: Integer; const Value: Boolean);
var
  iPlotDataNull : TiPlotDataNull;
begin
  iPlotDataNull := FList^[GetActualIndex(Index)];

  if Value then
    iPlotDataNull.Extra := iPlotDataNull.Extra or  $0002
  else
    iPlotDataNull.Extra := iPlotDataNull.Extra and $FFFD;

  FList^[GetActualIndex(Index)] := iPlotDataNull;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.SetMarkerVisible(const Index: Integer; const Value: Boolean);
var
  iPlotDataNull : TiPlotDataNull;
begin
  iPlotDataNull := FList^[GetActualIndex(Index)];

  if Value then
    iPlotDataNull.Extra := iPlotDataNull.Extra or  $0004
  else
    iPlotDataNull.Extra := iPlotDataNull.Extra and $FFFB;

  FList^[GetActualIndex(Index)] := iPlotDataNull;
end;
//****************************************************************************************************************************************************
procedure TiPlotDataNullList.SetMarkerStyle(const Index: Integer; const Value: TiPlotMarkerStyle);
var
  iPlotDataNull : TiPlotDataNull;
begin
  iPlotDataNull := FList^[GetActualIndex(Index)];

  iPlotDataNull.Extra := iPlotDataNull.Extra and $FF87;
  iPlotDataNull.Extra := iPlotDataNull.Extra or ((ord(Value) and $000F) Shl 3);

  FList^[GetActualIndex(Index)] := iPlotDataNull;
end;
//****************************************************************************************************************************************************
end.
