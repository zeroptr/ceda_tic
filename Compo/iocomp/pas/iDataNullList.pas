{*******************************************************}
{                                                       }
{       TiDoubleList                                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iDataNullList;{$endif}
{$ifdef iCLX}unit QiDataNullList;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes;{$ENDIF}
  {$IFDEF iCLX}QiTypes;{$ENDIF}

type

  TDataNull = record
    Data   : Double;
    Status : TiChannelDataSatus;
  end;

  PDataNullList = ^TDataNullList;
  TDataNullList = array[0..MaxListSize - 1] of TDataNull;

  TiDataNullList = class(TObject)
  private
    FList          : PDataNullList;
    FCount         : Integer;
    FCapacity      : Integer;
    FUseRingBuffer : Boolean;
    FTail          : Integer;
  protected
    procedure Grow;
    function  GetItem(Index: Integer): TDataNull;
    procedure SetItem(Index: Integer; const Value: TDataNull);
  public
    destructor Destroy; override;
    function  Add(Item: TDataNull): Boolean;
    procedure SetCapacity(NewCapacity: Integer);
    procedure DeleteRange(Size : Integer);
    procedure Clear;
    property  Count: Integer read FCount;
    property  Item[Index: Integer]: TDataNull read GetItem        write SetItem;
    property  UseRingBuffer       : Boolean   read FUseRingBuffer write FUseRingBuffer;
  end;
implementation

//****************************************************************************************************************************************************
destructor TiDataNullList.Destroy;
begin
  FreeMem(FList);
  inherited;
end;
//****************************************************************************************************************************************************
function TiDataNullList.Add(Item: TDataNull): Boolean;
var
  ActualIndex : Integer;
begin
  if FUseRingBuffer then
    begin
      if FCount < FCapacity then
        begin
          ActualIndex         := FCount;
          FList^[ActualIndex] := Item;
          Inc(FCount);
          Result := False;
        end
      else
        begin
          Inc(FTail);
          if FTail = FCount then FTail := 0;

          if FTail <> 0 then ActualIndex := FTail-1 else ActualIndex := FCount-1;
          FList^[ActualIndex] := Item;
          Result := True;
        end;
    end
  else
    begin
      ActualIndex := FCount;
      if ActualIndex = FCapacity then Grow;
      FList^[ActualIndex] := Item;
      Inc(FCount);
      Result := False;
    end;
end;
//****************************************************************************************************************************************************
procedure TiDataNullList.Clear;
begin
  FCount        := 0;
  FTail         := 0;
  if not FUseRingBuffer then SetCapacity(4);
end;
//****************************************************************************************************************************************************
procedure TiDataNullList.Grow;
var
  Delta: Integer;
begin
  if      FCapacity > 64 then Delta := FCapacity div 4
  else if FCapacity >  8 then Delta := 16
    else                      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;
//****************************************************************************************************************************************************
function TiDataNullList.GetItem(Index: Integer): TDataNull;
var
  ActualIndex : Integer;
begin
  if (Index < 0) or (Index >= FCount) then raise Exception.Create('Index out of Bounds');

  if FTail <> 0 then
    begin
      ActualIndex := Index + FTail;
      if ActualIndex > (FCount-1) then ActualIndex := ActualIndex - FCount;
    end
  else ActualIndex := Index;

  Result := FList^[ActualIndex];
end;
//****************************************************************************************************************************************************
procedure TiDataNullList.SetItem(Index: Integer; const Value: TDataNull);
var
  ActualIndex : Integer;
begin
  if (Index < 0) or (Index >= FCount) then raise Exception.Create('Index out of Bounds');

  if FTail <> 0 then
    begin
      ActualIndex := Index + FTail;
      if ActualIndex > (FCount-1) then ActualIndex := ActualIndex - FCount;
    end
  else ActualIndex := Index;

  FList^[ActualIndex] := Value;
end;
//****************************************************************************************************************************************************
procedure TiDataNullList.SetCapacity(NewCapacity: Integer);
begin
  if (NewCapacity > MaxListSize) then Exception.Create('Exceed Maximum List Size');
  if NewCapacity <> FCapacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TDataNull));
    try
      if NewCapacity <> 0 then FList^[NewCapacity-1].Data := 0;
    except
      on Exception do raise Exception.Create('Memory could not be allocated');
    end;
    FCapacity := NewCapacity;
  end;
end;
//****************************************************************************************************************************************************
procedure TiDataNullList.DeleteRange(Size: Integer);
begin
  if (Size < 0) or (Size >= FCount) then raise Exception.Create('Delete size out of Range');
  FCount := FCount - Size;
  if FCount > 0 then System.Move(FList^[Size], FList^[0], (FCount) * SizeOf(TDataNull));
end;
//****************************************************************************************************************************************************
end.
