{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvMemDS.PAS, released on 2002-07-04.

The Initial Developers of the Original Code are: Fedor Koshevnikov, Igor Pavluk and Serge Korolev
Copyright (c) 1997, 1998 Fedor Koshevnikov, Igor Pavluk and Serge Korolev
Copyright (c) 2001,2002 SGB Software
All Rights Reserved.

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

Known Issues:

//********************** Added by Claudio F. Zwitkovits (CFZ) **************************
 Property DataSet <== Attach any bi-directional DataSet (TTable,TQuery,etc)
 Property DataSetClosed <== True/False If After Load Structure and/or Records, Close the attached DataSet
 Property KeyFieldNames <== String with the names of the fields from the primary key / Index key
 Property ApplyMode <== The mode do Apply the changes in original DataSet
          amNone = Not Apply
          amAppend = Allow ONLY insert records, and edit/delete this records inserted
          amMerge = Allow ALL (Insert,Edit,Delete) records
 Property ExactApply <== If True, the RowsAffected (Applied) EQUAL FRowsChanged
          If False, Apply Tolerance
 Property LoadStructure <== If True, is NOT needed define the fields in design time
          the JvMemoryData load the fields from the original dataset
 Property LoadRecords <== TRUE/FALSE  Auto-load records from the original dataset.
 Property SaveLoadState <== Return if loading or saving from/to other dataset.
 Events   BeforeApply, AfterApply <== in the calling to the ApplyChanges and SaveToDataset methods.
          BeforeApplyRecord, AfterApplyRecord <== in the calling to the ApplyChanges and SaveToDataset methods.
 Methods  (Public) ApplyChanges and CancelChanges <== Save / Discard the changes into
          the original DataSet.
 Methods  (Public) IsLoading <== True/False. If the JvMemData is loading data from external dataset
          (LoadFromDataSet or CopyFromDataSet)
 Methods  (Public) IsSaving <== True/False If the JvMemData is saving data to external dataset
          (SaveToDataSet or ApplyChanges)
 Methods  (Public) IsInserted, IsUpdated, IsOriginal, IsDeleted
          return the status from the current record
 Methods  (Public) GetValues() <== Obtain the values from list of Fields or Key Fields
 IMPORTANT : This component, add a hidden field, in the last position ( in FieldDefs
             And Fields Lists ) and save the STATUS of the current record
             (rsOriginal, rsInserted, rsUpdated), in the hidden field.
             Likewise, have a private List (FDeletedValues) with the primary key values
             from the Deleted records (rsDeleted).

Implementation : 2004/03/03
Revisions : 1st = 2004/09/19
            2nd = 2004/10/19
            3th = 2004/10/25
            4th = 2005/01/05
            5th = 2005/12/20
            6th = 2006/03/24
            7th = 2007/03/25
            8th = 2007/06/20

Comments and Bugs : cfzwit att yahoo dott com dott ar
-----------------------------------------------------------------------------}
// $Id: JvMemoryDataset.pas 12152 2009-01-21 08:43:18Z obones $

unit JvMemoryDataset;

{$I jvcl.inc}

interface

uses
  Windows,  // to avoid warning under BDS2006, and in the interface section to allow compilation in RS2008
  {$IFDEF UNITVERSIONING}
  JclUnitVersioning,
  {$ENDIF UNITVERSIONING}
  SysUtils, Classes, DB,
  {$IFDEF HAS_UNIT_VARIANTS}
  Variants,
  {$ENDIF HAS_UNIT_VARIANTS}
  JvDBUtils;

type
  TPVariant = ^Variant;
  TApplyMode = (amNone, amAppend, amMerge);
  TApplyEvent = procedure(Dataset: TDataset; Rows: Integer) of object;
  TRecordStatus = (rsOriginal, rsUpdated, rsInserted, rsDeleted);
  TApplyRecordEvent = procedure(Dataset: TDataset; RecStatus: TRecordStatus;
    FoundApply: Boolean) of object;
  TMemBlobData = string;
  TMemBlobArray = array[0..0] of TMemBlobData;
  PMemBlobArray = ^TMemBlobArray;
  TJvMemoryRecord = class;
  TLoadMode = (lmCopy, lmAppend);
  TSaveLoadState = (slsNone, slsLoading, slsSaving);
  TCompareRecords = function(Item1, Item2: TJvMemoryRecord): Integer of object;
  TWordArray = array of Word;

  TJvMemoryData = class(TDataSet)
  private
    FSaveLoadState: TSaveLoadState;
    FRecordPos: Integer;
    FRecordSize: Integer;
    FBookmarkOfs: Integer;
    FBlobOfs: Integer;
    FRecBufSize: Integer;
    FOffsets: TWordArray;
    FLastID: Integer;
    FAutoInc: Longint;
    FActive: Boolean;
    FRecords: TList;
    FIndexList: TList;
    FCaseInsensitiveSort: Boolean;
    FDescendingSort: Boolean;
    FAutoIncField: TField;
    FSrcAutoIncField: TField;
    FDataSet: TDataSet;
    FDataSetClosed: Boolean;
    FLoadStructure: Boolean;
    FLoadRecords: Boolean;
    FKeyFieldNames: string;
    FApplyMode: TApplyMode;
    FExactApply: Boolean;
    FAutoIncAsInteger: Boolean;
    FOneValueInArray: Boolean;
    FRowsOriginal: Integer;
    FRowsChanged: Integer;
    FRowsAffected: Integer;
    FDeletedValues: TList;
    FStatusName: string;
    FBeforeApply: TApplyEvent;
    FAfterApply: TApplyEvent;
    FBeforeApplyRecord: TApplyRecordEvent;
    FAfterApplyRecord: TApplyRecordEvent;
    function AddRecord: TJvMemoryRecord;
    function InsertRecord(Index: Integer): TJvMemoryRecord;
    function FindRecordID(ID: Integer): TJvMemoryRecord;
    procedure CreateIndexList(const FieldNames: WideString);
    procedure FreeIndexList;
    procedure QuickSort(L, R: Integer; Compare: TCompareRecords);
    procedure Sort;
    function CalcRecordSize: Integer;
    function GetMemoryRecord(Index: Integer): TJvMemoryRecord;
    function GetCapacity: Integer;
    function RecordFilter: Boolean;
    procedure SetCapacity(Value: Integer);
    procedure ClearRecords;
    procedure InitBufferPointers(GetProps: Boolean);
    procedure FixReadOnlyFields(MakeReadOnly: Boolean);
    procedure SetDataSet(ADataSet: TDataSet);
    procedure CheckStructure(UseAutoIncAsInteger: Boolean = False);
    procedure AddStatusField;
    procedure HideStatusField;
    function CopyFromDataSet: Integer;
    procedure ClearChanges;
    procedure DoBeforeApply(ADataset: TDataset; RowsPending: Integer);
    procedure DoAfterApply(ADataset: TDataset; RowsApplied: Integer);
    procedure DoBeforeApplyRecord(ADataset: TDataset; RS: TRecordStatus; Found: Boolean);
    procedure DoAfterApplyRecord(ADataset: TDataset; RS: TRecordStatus; Apply: Boolean);
  protected
    function FindFieldData(Buffer: Pointer; Field: TField): Pointer;
    function CompareFields(Data1, Data2: Pointer; FieldType: TFieldType;
      CaseInsensitive: Boolean): Integer; virtual;
    {$IFNDEF COMPILER10_UP} // Delphi 2006+ has support for WideString
    procedure DataConvert(Field: TField; Source, Dest: Pointer; ToNative: Boolean); override;
    {$ENDIF ~COMPILER10_UP}
    procedure AssignMemoryRecord(Rec: TJvMemoryRecord; Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
    function GetActiveRecBuf(var RecBuf: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): Boolean; virtual;
    procedure InitFieldDefsFromFields;
    procedure RecordToBuffer(Rec: TJvMemoryRecord; Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
    procedure SetMemoryRecordData(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Pos: Integer); virtual;
    procedure SetAutoIncFields(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}); virtual;
    function CompareRecords(Item1, Item2: TJvMemoryRecord): Integer; virtual;
    function GetBlobData(Field: TField; Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): TMemBlobData;
    procedure SetBlobData(Field: TField; Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Value: TMemBlobData);
    function AllocRecordBuffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; override;
    procedure FreeRecordBuffer(var Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}); override;
    procedure InternalInitRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}); override;
    procedure ClearCalcFields(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}); override;
    function GetRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; GetMode: TGetMode;
      DoCheck: Boolean): TGetResult; override;
    function GetRecordSize: Word; override;
    procedure SetFiltered(Value: Boolean); override;
    procedure SetOnFilterRecord(const Value: TFilterRecordEvent); override;
    procedure SetFieldData(Field: TField; Buffer: Pointer); override;
    procedure CloseBlob(Field: TField); override;
    procedure GetBookmarkData(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Data: Pointer); override;
    function GetBookmarkFlag(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): TBookmarkFlag; override;
    procedure InternalGotoBookmark(Bookmark: Pointer); override;
    procedure InternalSetToRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}); override;
    procedure SetBookmarkFlag(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Value: TBookmarkFlag); override;
    procedure SetBookmarkData(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Data: Pointer); override;
    function GetIsIndexField(Field: TField): Boolean; override;
    procedure InternalFirst; override;
    procedure InternalLast; override;
    procedure InitRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}); override;
    procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
    procedure InternalDelete; override;
    procedure InternalPost; override;
    procedure InternalClose; override;
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalOpen; override;
    procedure OpenCursor(InfoQuery: Boolean); override;
    function IsCursorOpen: Boolean; override;
    function GetRecordCount: Integer; override;
    function GetRecNo: Integer; override;
    procedure SetRecNo(Value: Integer); override;
    procedure DoAfterOpen; override;
    property Records[Index: Integer]: TJvMemoryRecord read GetMemoryRecord;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function BookmarkValid(Bookmark: TBookmark): Boolean; override;
    function CompareBookmarks(Bookmark1, Bookmark2: TBookmark): Integer; override;
    function CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream; override;
    function GetFieldData(Field: TField; Buffer: Pointer): Boolean; override;
    function GetCurrentRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): Boolean; override;
    function IsSequenced: Boolean; override;
    function Locate(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions): Boolean; override;
    function Lookup(const KeyFields: string; const KeyValues: Variant;
      const ResultFields: string): Variant; override;
    procedure SortOnFields(const FieldNames: string = '';
      CaseInsensitive: Boolean = True; Descending: Boolean = False);
    procedure EmptyTable;
    procedure CopyStructure(Source: TDataSet; UseAutoIncAsInteger: Boolean = False);
    function LoadFromDataSet(Source: TDataSet; RecordCount: Integer;
      Mode: TLoadMode; DisableAllControls: Boolean = True): Integer;
    function SaveToDataSet(Dest: TDataSet; RecordCount: Integer; DisableAllControls: Boolean = True): Integer;
    property SaveLoadState: TSaveLoadState read FSaveLoadState;
    function GetValues(FldNames: string = ''): Variant;
    function FindDeleted(KeyValues: Variant): Integer;
    function IsDeleted(out Index: Integer): Boolean;
    function IsInserted: Boolean;
    function IsUpdated: Boolean;
    function IsOriginal: Boolean;
    procedure CancelChanges;
    function ApplyChanges: Boolean;
    function IsLoading: Boolean;
    function IsSaving: Boolean;
    property RowsOriginal: Integer read FRowsOriginal;
    property RowsChanged: Integer read FRowsChanged;
    property RowsAffected: Integer read FRowsAffected;
  published
    property Capacity: Integer read GetCapacity write SetCapacity default 0;
    property Active;
    property AutoCalcFields;
    property Filtered;
    property FieldDefs;
    property ObjectView default False;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property DatasetClosed: Boolean read FDatasetClosed write FDatasetClosed default False;
    property KeyFieldNames: string read FKeyFieldNames write FKeyFieldNames;
    property LoadStructure: Boolean read FLoadStructure write FLoadStructure default False;
    property LoadRecords: Boolean read FLoadRecords write FLoadRecords default False;
    property ApplyMode: TApplyMode read FApplyMode write FApplyMode default amNone;
    property ExactApply: Boolean read FExactApply write FExactApply default False;
    property AutoIncAsInteger: Boolean read FAutoIncAsInteger write FAutoIncAsInteger default False;
    property OneValueInArray: Boolean read FOneValueInArray write FOneValueInArray default True;
    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnFilterRecord;
    property OnNewRecord;
    property OnPostError;
    property BeforeApply: TApplyEvent read FBeforeApply write FBeforeApply;
    property AfterApply: TApplyEvent read FAfterApply write FAfterApply;
    property BeforeApplyRecord: TApplyRecordEvent read FBeforeApplyRecord write FBeforeApplyRecord;
    property AfterApplyRecord: TApplyRecordEvent read FAfterApplyRecord write FAfterApplyRecord;
  end;

  TJvMemBlobStream = class(TStream)
  private
    FField: TBlobField;
    FDataSet: TJvMemoryData;
    FBuffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP};
    FMode: TBlobStreamMode;
    FOpened: Boolean;
    FModified: Boolean;
    FPosition: Longint;
    FCached: Boolean;
    function GetBlobSize: Longint;
    function GetBlobFromRecord(Field: TField): TMemBlobData;
  public
    constructor Create(Field: TBlobField; Mode: TBlobStreamMode);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    procedure Truncate;
  end;

  TJvMemoryRecord = class(TPersistent)
  private
    FMemoryData: TJvMemoryData;
    FID: Integer;
    FData: Pointer;
    FBlobs: Pointer;
    function GetIndex: Integer;
    procedure SetMemoryData(Value: TJvMemoryData; UpdateParent: Boolean);
  protected
    procedure SetIndex(Value: Integer); virtual;
  public
    constructor Create(MemoryData: TJvMemoryData); virtual;
    constructor CreateEx(MemoryData: TJvMemoryData; UpdateParent: Boolean); virtual;
    destructor Destroy; override;
    property MemoryData: TJvMemoryData read FMemoryData;
    property ID: Integer read FID write FID;
    property Index: Integer read GetIndex write SetIndex;
    property Data: Pointer read FData;
  end;

{$IFDEF UNITVERSIONING}
const
  UnitVersioning: TUnitVersionInfo = (
    RCSfile: '$URL: https://jvcl.svn.sourceforge.net/svnroot/jvcl/branches/JVCL3_36_PREPARATION/run/JvMemoryDataset.pas $';
    Revision: '$Revision: 12152 $';
    Date: '$Date: 2009-01-21 09:43:18 +0100 (mer., 21 janv. 2009) $';
    LogPath: 'JVCL\run'
  );
{$ENDIF UNITVERSIONING}

implementation

uses
  Forms, Dialogs, DBConsts, Math,
  {$IFDEF COMPILER6_UP}
  FMTBcd,
  {$ENDIF COMPILER6_UP}
  JvResources;

const
  ftBlobTypes = [ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle,
    ftDBaseOle, ftTypedBinary, ftOraBlob, ftOraClob];

  ftSupported = [ftString, ftSmallint, ftInteger, ftWord, ftBoolean,
    ftFloat, ftCurrency, ftDate, ftTime, ftDateTime, ftAutoInc, ftBCD,
    {$IFDEF COMPILER6_UP}
    ftFMTBCD,
    {$ENDIF COMPILER6_UP}
    ftBytes, ftVarBytes, ftADT, ftFixedChar, ftWideString, ftLargeint,
    ftVariant, ftGuid] + ftBlobTypes;

  fkStoredFields = [fkData];

  GuidSize = 38;

  STATUSNAME = 'C67F70Z90'; (* Magic *)

{$IFDEF COMPILER5} // Added 2005/01/05

type
  TVariantRelationship = (vrEqual, vrLessThan, vrGreaterThan, vrNotEqual);

//=== { Utility routines } ===================================================

function FindVarData(const V: Variant): PVarData;
begin
  Result := @TVarData(V);
  while Result.VType = varByRef or varVariant do
    Result := PVarData(Result.VPointer);
end;

function VarCompareValue(const A, B: Variant): TVariantRelationship;
const
  CTruth: array [Boolean] of TVariantRelationship = (vrNotEqual, vrEqual);
var
  LA, LB: TVarData;
begin
  LA := FindVarData(A)^;
  LB := FindVarData(B)^;
  if LA.VType = varEmpty then
    Result := CTruth[LB.VType = varEmpty]
  else
  if LA.VType = varNull then
    Result := CTruth[LB.VType = varNull]
  else
  if LB.VType in [varEmpty, varNull] then
    Result := vrNotEqual
  else
  if A = B then
    Result := vrEqual
  else
  if A < B then
    Result := vrLessThan
  else
    Result := vrGreaterThan;
end;

function BcdCompare(const Bcd1, Bcd2: TBcd): Integer;
var
  Curr1, Curr2: Currency;
begin
  Result := 0;
  if BCDToCurr(Bcd1, Curr1) and BCDToCurr(Bcd2, Curr2) then
  begin
    if Curr1 < Curr2 then
      Result := -1
    else
    if Curr1 > Curr2 then
      Result := 1;
  end;
end;

{$ENDIF COMPILER5}

function CalcFieldLen(FieldType: TFieldType; Size: Word): Word;
begin
  if not (FieldType in ftSupported) then
    Result := 0
  else
  if FieldType in ftBlobTypes then
    Result := SizeOf(Longint)
  else
  begin
    Result := Size;
    case FieldType of
      ftString:
        Inc(Result);
      ftSmallint:
        Result := SizeOf(Smallint);
      ftInteger:
        Result := SizeOf(Longint);
      ftWord:
        Result := SizeOf(Word);
      ftBoolean:
        Result := SizeOf(Wordbool);
      ftFloat:
        Result := SizeOf(Double);
      ftCurrency:
        Result := SizeOf(Double);
      {$IFDEF COMPILER6_UP}
      ftFMTBCD,
      {$ENDIF COMPILER6_UP}
      ftBCD:
        Result := SizeOf(TBcd);
      ftDate, ftTime:
        Result := SizeOf(Longint);
      ftDateTime:
        Result := SizeOf(TDateTime);
      ftBytes:
        Result := Size;
      ftVarBytes:
        Result := Size + 2;
      ftAutoInc:
        Result := SizeOf(Longint);
      ftADT:
        Result := 0;
      ftFixedChar:
        Inc(Result);
      ftWideString:
        Result := (Result + 1) * 2;
      ftLargeint:
        Result := SizeOf(Int64);
      ftVariant:
        Result := SizeOf(Variant);
      ftGuid:
        Result := GuidSize + 1;
    end;
  end;
end;

procedure CalcDataSize(FieldDef: TFieldDef; var DataSize: Integer);
var
  I: Integer;
begin
  with FieldDef do
  begin
    if DataType in ftSupported - ftBlobTypes then
      Inc(DataSize, CalcFieldLen(DataType, Size) + 1);
    for I := 0 to ChildDefs.Count - 1 do
      CalcDataSize(ChildDefs[I], DataSize);
  end;
end;

procedure Error(const Msg: string);
begin
  DatabaseError(Msg);
end;

procedure ErrorFmt(const Msg: string; const Args: array of const);
begin
  DatabaseErrorFmt(Msg, Args);
end;

type
  TBookmarkData = Integer;
  PMemBookmarkInfo = ^TMemBookmarkInfo;

  TMemBookmarkInfo = record
    BookmarkData: TBookmarkData;
    BookmarkFlag: TBookmarkFlag;
  end;

//=== { TJvMemoryRecord } ====================================================

constructor TJvMemoryRecord.Create(MemoryData: TJvMemoryData);
begin
  CreateEx(MemoryData, True);
end;

constructor TJvMemoryRecord.CreateEx(MemoryData: TJvMemoryData; UpdateParent: Boolean);
begin
  inherited Create;
  SetMemoryData(MemoryData, UpdateParent);
end;

destructor TJvMemoryRecord.Destroy;
begin
  SetMemoryData(nil, True);
  inherited Destroy;
end;

function TJvMemoryRecord.GetIndex: Integer;
begin
  if FMemoryData <> nil then
    Result := FMemoryData.FRecords.IndexOf(Self)
  else
    Result := -1;
end;

procedure TJvMemoryRecord.SetMemoryData(Value: TJvMemoryData; UpdateParent: Boolean);
var
  I: Integer;
  DataSize: Integer;
begin
  if FMemoryData <> Value then
  begin
    if FMemoryData <> nil then
    begin
      FMemoryData.FRecords.Remove(Self);
      if FMemoryData.BlobFieldCount > 0 then
        Finalize(PMemBlobArray(FBlobs)[0], FMemoryData.BlobFieldCount);
      ReallocMem(FBlobs, 0);
      ReallocMem(FData, 0);
      FMemoryData := nil;
    end;
    if Value <> nil then
    begin
      if UpdateParent then
      begin
        Value.FRecords.Add(Self);
        Inc(Value.FLastID);
        FID := Value.FLastID;
      end;
      FMemoryData := Value;
      if Value.BlobFieldCount > 0 then
      begin
        ReallocMem(FBlobs, Value.BlobFieldCount * SizeOf(Pointer));
        Initialize(PMemBlobArray(FBlobs)[0], Value.BlobFieldCount);
      end;
      DataSize := 0;
      for I := 0 to Value.FieldDefs.Count - 1 do
        CalcDataSize(Value.FieldDefs[I], DataSize);
      ReallocMem(FData, DataSize);
    end;
  end;
end;

procedure TJvMemoryRecord.SetIndex(Value: Integer);
var
  CurIndex: Integer;
begin
  CurIndex := GetIndex;
  if (CurIndex >= 0) and (CurIndex <> Value) then
    FMemoryData.FRecords.Move(CurIndex, Value);
end;

//=== { TJvMemoryData } ======================================================

constructor TJvMemoryData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRecordPos := -1;
  FLastID := Low(Integer);
  FAutoInc := 1;
  FRecords := TList.Create;
  FStatusName := STATUSNAME;
  FDeletedValues := TList.Create;
  FRowsOriginal := 0;
  FRowsChanged := 0;
  FRowsAffected := 0;
  FSaveLoadState := slsNone;
  FOneValueInArray := True;
end;

destructor TJvMemoryData.Destroy;
var
  I: Integer;
  PFValues: TPVariant;
begin
  if Active then
    Close;
  if Assigned(FDeletedValues) then
  begin
    if FDeletedValues.Count > 0 then
      for I := 0 to (FDeletedValues.Count - 1) do
      begin
        PFValues := FDeletedValues[I];
        if PFValues <> nil then
          Dispose(PFValues);
        FDeletedValues[I] := nil;
      end;
    FreeAndNil(FDeletedValues);
  end;
  FreeIndexList;
  ClearRecords;
  FRecords.Free;
  FOffsets := nil;
  inherited Destroy;
end;

function TJvMemoryData.CompareFields(Data1, Data2: Pointer;
  FieldType: TFieldType; CaseInsensitive: Boolean): Integer;
begin
  Result := 0;
  case FieldType of
    ftString:
      if CaseInsensitive then
        Result := AnsiCompareText(PChar(Data1), PChar(Data2))
      else
        Result := AnsiCompareStr(PChar(Data1), PChar(Data2));
    ftSmallint:
      if Smallint(Data1^) > Smallint(Data2^) then
        Result := 1
      else
      if Smallint(Data1^) < Smallint(Data2^) then
        Result := -1;
    ftInteger, ftDate, ftTime, ftAutoInc:
      if Longint(Data1^) > Longint(Data2^) then
        Result := 1
      else
      if Longint(Data1^) < Longint(Data2^) then
        Result := -1;
    ftWord:
      if Word(Data1^) > Word(Data2^) then
        Result := 1
      else
      if Word(Data1^) < Word(Data2^) then
        Result := -1;
    ftBoolean:
      if Wordbool(Data1^) and not Wordbool(Data2^) then
        Result := 1
      else
      if not Wordbool(Data1^) and Wordbool(Data2^) then
        Result := -1;
    ftFloat, ftCurrency:
      if Double(Data1^) > Double(Data2^) then
        Result := 1
      else
      if Double(Data1^) < Double(Data2^) then
        Result := -1;
    {$IFDEF COMPILER6_UP} ftFMTBcd, {$ENDIF}
    ftBcd:
      Result := BcdCompare(TBcd(Data1^), TBcd(Data2^));
    ftDateTime:
      if TDateTime(Data1^) > TDateTime(Data2^) then
        Result := 1
      else
      if TDateTime(Data1^) < TDateTime(Data2^) then
        Result := -1;
    ftFixedChar:
      if CaseInsensitive then
        Result := AnsiCompareText(PChar(Data1), PChar(Data2))
      else
        Result := AnsiCompareStr(PChar(Data1), PChar(Data2));
    ftWideString:
      if CaseInsensitive then
        Result := AnsiCompareText(WideCharToString(PWideChar(Data1)),
          WideCharToString(PWideChar(Data2)))
      else
        Result := AnsiCompareStr(WideCharToString(PWideChar(Data1)),
          WideCharToString(PWideChar(Data2)));
    ftLargeint:
      if Int64(Data1^) > Int64(Data2^) then
        Result := 1
      else
      if Int64(Data1^) < Int64(Data2^) then
        Result := -1;
    ftVariant:
      Result := 0;
    ftGuid:
      Result := CompareText(PChar(Data1), PChar(Data2));
  end;
end;

function TJvMemoryData.GetCapacity: Integer;
begin
  if FRecords <> nil then
    Result := FRecords.Capacity
  else
    Result := 0;
end;

procedure TJvMemoryData.SetCapacity(Value: Integer);
begin
  if FRecords <> nil then
    FRecords.Capacity := Value;
end;

function TJvMemoryData.AddRecord: TJvMemoryRecord;
begin
  Result := TJvMemoryRecord.Create(Self);
end;

function TJvMemoryData.FindRecordID(ID: Integer): TJvMemoryRecord;
var
  I: Integer;
begin
  for I := 0 to FRecords.Count - 1 do
  begin
    Result := TJvMemoryRecord(FRecords[I]);
    if Result.ID = ID then
      Exit;
  end;
  Result := nil;
end;

function TJvMemoryData.InsertRecord(Index: Integer): TJvMemoryRecord;
begin
  Result := AddRecord;
  Result.Index := Index;
end;

function TJvMemoryData.GetMemoryRecord(Index: Integer): TJvMemoryRecord;
begin
  Result := TJvMemoryRecord(FRecords[Index]);
end;

procedure TJvMemoryData.InitFieldDefsFromFields;
var
  I: Integer;
  Offset: Word;
begin
  if FieldDefs.Count = 0 then
  begin
    for I := 0 to FieldCount - 1 do
    begin
      with Fields[I] do
        if (FieldKind in fkStoredFields) and not (DataType in ftSupported) then
          ErrorFmt(SUnknownFieldType, [DisplayName]);
    end;
    FreeIndexList;
  end;
  Offset := 0;
  inherited InitFieldDefsFromFields;
  { Calculate fields offsets }
  SetLength(FOffsets, FieldDefList.Count);
  for I := 0 to FieldDefList.Count - 1 do
  begin
    FOffsets[I] := Offset;
    with FieldDefList[I] do
      if DataType in ftSupported - ftBlobTypes then
        Inc(Offset, CalcFieldLen(DataType, Size) + 1);
  end;
end;

function TJvMemoryData.FindFieldData(Buffer: Pointer; Field: TField): Pointer;
var
  Index: Integer;
  DataType: TFieldType;
begin
  Result := nil;
  Index := FieldDefList.IndexOf(Field.FullName);
  if (Index >= 0) and (Buffer <> nil) then
  begin
    DataType := FieldDefList[Index].DataType;
    if DataType in ftSupported then
      if DataType in ftBlobTypes then
        Result := Pointer(GetBlobData(Field, Buffer))
      else
        Result := ({$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}(Buffer) + FOffsets[Index]);
  end;
end;

function TJvMemoryData.CalcRecordSize: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FieldDefs.Count - 1 do
    CalcDataSize(FieldDefs[I], Result);
end;

procedure TJvMemoryData.InitBufferPointers(GetProps: Boolean);
begin
  if GetProps then
    FRecordSize := CalcRecordSize;
  FBookmarkOfs := FRecordSize + CalcFieldsSize;
  FBlobOfs := FBookmarkOfs + SizeOf(TMemBookmarkInfo);
  FRecBufSize := FBlobOfs + BlobFieldCount * SizeOf(Pointer);
end;

procedure TJvMemoryData.ClearRecords;
begin
  while FRecords.Count > 0 do
    TObject(FRecords.Last).Free;
  FLastID := Low(Integer);
  FRecordPos := -1;
end;

function TJvMemoryData.AllocRecordBuffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP};
begin
  {$IFDEF COMPILER12_UP}
  GetMem(Result, FRecBufSize);
  {$ELSE}
  Result := StrAlloc(FRecBufSize);
  {$ENDIF COMPILER12_UP}
  if BlobFieldCount > 0 then
    Initialize(PMemBlobArray(Result + FBlobOfs)[0], BlobFieldCount);
end;

procedure TJvMemoryData.FreeRecordBuffer(var Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
begin
  if BlobFieldCount > 0 then
    Finalize(PMemBlobArray(Buffer + FBlobOfs)[0], BlobFieldCount);
  {$IFDEF COMPILER12_UP}
  FreeMem(Buffer);
  {$ELSE}
  StrDispose(Buffer);
  {$ENDIF COMPILER12_UP}
  Buffer := nil;
end;

procedure TJvMemoryData.ClearCalcFields(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
begin
  FillChar(Buffer[FRecordSize], CalcFieldsSize, 0);
end;

procedure TJvMemoryData.InternalInitRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
var
  I: Integer;
begin
  FillChar(Buffer^, FBlobOfs, 0);
  for I := 0 to BlobFieldCount - 1 do
    PMemBlobArray(Buffer + FBlobOfs)[I] := '';
end;

procedure TJvMemoryData.InitRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
begin
  inherited InitRecord(Buffer);
  with PMemBookmarkInfo(Buffer + FBookmarkOfs)^ do
  begin
    BookmarkData := Low(Integer);
    BookmarkFlag := bfInserted;
  end;
end;

function TJvMemoryData.GetCurrentRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): Boolean;
begin
  Result := False;
  if not IsEmpty and (GetBookmarkFlag(ActiveBuffer) = bfCurrent) then
  begin
    UpdateCursorPos;
    if (FRecordPos >= 0) and (FRecordPos < RecordCount) then
    begin
      Move(Records[FRecordPos].Data^, Buffer^, FRecordSize);
      Result := True;
    end;
  end;
end;

procedure TJvMemoryData.RecordToBuffer(Rec: TJvMemoryRecord; Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
var
  I: Integer;
begin
  Move(Rec.Data^, Buffer^, FRecordSize);
  with PMemBookmarkInfo(Buffer + FBookmarkOfs)^ do
  begin
    BookmarkData := Rec.ID;
    BookmarkFlag := bfCurrent;
  end;
  for I := 0 to BlobFieldCount - 1 do
    PMemBlobArray(Buffer + FBlobOfs)[I] := PMemBlobArray(Rec.FBlobs)[I];
  GetCalcFields(Buffer);
end;

function TJvMemoryData.GetRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; GetMode: TGetMode;
  DoCheck: Boolean): TGetResult;
var
  Accept: Boolean;
begin
  Result := grOk;
  Accept := True;
  case GetMode of
    gmPrior:
      if FRecordPos <= 0 then
      begin
        Result := grBOF;
        FRecordPos := -1;
      end
      else
      begin
        repeat
          Dec(FRecordPos);
          if Filtered then
            Accept := RecordFilter;
        until Accept or (FRecordPos < 0);
        if not Accept then
        begin
          Result := grBOF;
          FRecordPos := -1;
        end;
      end;
    gmCurrent:
      if (FRecordPos < 0) or (FRecordPos >= RecordCount) then
        Result := grError
      else
      if Filtered then
        if not RecordFilter then
          Result := grError;
    gmNext:
      if FRecordPos >= RecordCount - 1 then
        Result := grEOF
      else
      begin
        repeat
          Inc(FRecordPos);
          if Filtered then
            Accept := RecordFilter;
        until Accept or (FRecordPos > RecordCount - 1);
        if not Accept then
        begin
          Result := grEOF;
          FRecordPos := RecordCount - 1;
        end;
      end;
  end;
  if Result = grOk then
    RecordToBuffer(Records[FRecordPos], Buffer)
  else
  if (Result = grError) and DoCheck then
    Error(RsEMemNoRecords);
end;

function TJvMemoryData.GetRecordSize: Word;
begin
  Result := FRecordSize;
end;

function TJvMemoryData.GetActiveRecBuf(var RecBuf: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): Boolean;
begin
  case State of
    dsBrowse:
      if IsEmpty then
        RecBuf := nil
      else
        RecBuf := ActiveBuffer;
    dsEdit, dsInsert:
      RecBuf := ActiveBuffer;
    dsCalcFields:
      RecBuf := CalcBuffer;
    dsFilter:
      RecBuf := TempBuffer;
    else
      RecBuf := nil;
  end;
  Result := RecBuf <> nil;
end;

function TJvMemoryData.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
  RecBuf, Data: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP};
  VarData: Variant;

  function BufferLen(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): Integer;
  begin
    {$IFDEF COMPILER12_UP}
    Result := 0;
    if Buffer <> nil then
    begin
      while Buffer[Result] <> 0 do
        Inc(Result);
    end;
    {$ELSE}
    Result := StrLen(Buffer);
    {$ENDIF COMPILER12_UP}
  end;
begin
  Result := False;
  if not GetActiveRecBuf(RecBuf) then
    Exit;
  if Field.FieldNo > 0 then
  begin
    Data := FindFieldData(RecBuf, Field);
    if Data <> nil then
    begin
      if Field is TBlobField then
        Result := Data <> nil
      else
        Result := Data[0] <> {$IFDEF COMPILER12_UP}0{$ELSE}#0{$ENDIF COMPILER12_UP};
      Inc(Data);
      if Field.DataType in [ftString, ftFixedChar, ftWideString, ftGuid] then
        Result := Result and (BufferLen(Data) > 0);
      if Result and (Buffer <> nil) then
        if Field.DataType = ftVariant then
        begin
          VarData := PVariant(Data)^;
          PVariant(Buffer)^ := VarData;
        end
        else
          Move(Data^, Buffer^, CalcFieldLen(Field.DataType, Field.Size));
    end;
  end
  else
  if State in [dsBrowse, dsEdit, dsInsert, dsCalcFields] then
  begin
    Inc(RecBuf, FRecordSize + Field.Offset);
    Result := RecBuf[0] <> {$IFDEF COMPILER12_UP}0{$ELSE}#0{$ENDIF COMPILER12_UP};
    if Result and (Buffer <> nil) then
      Move(RecBuf[1], Buffer^, Field.DataSize);
  end;
end;

procedure TJvMemoryData.SetFieldData(Field: TField; Buffer: Pointer);
var
  RecBuf, Data: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP};
  VarData: Variant;
begin
  if not (State in dsWriteModes) then
    Error(SNotEditing);
  GetActiveRecBuf(RecBuf);
  with Field do
  begin
    if FieldNo > 0 then
    begin
      if State in [dsCalcFields, dsFilter] then
        Error(SNotEditing);
      if ReadOnly and not (State in [dsSetKey, dsFilter]) then
        ErrorFmt(SFieldReadOnly, [DisplayName]);
      Validate(Buffer);
      if FieldKind <> fkInternalCalc then
      begin
        Data := FindFieldData(RecBuf, Field);
        if Data <> nil then
        begin
          if DataType = ftVariant then
          begin
            if Buffer <> nil then
              VarData := PVariant(Buffer)^
            else
              VarData := EmptyParam;
            Data[0] := {$IFDEF COMPILER12_UP}Byte{$ELSE}AnsiChar{$ENDIF COMPILER12_UP}(Ord((Buffer <> nil) and not
              (VarIsNull(VarData) or VarIsEmpty(VarData))));
            if Data[0] <> {$IFDEF COMPILER12_UP}0{$ELSE}#0{$ENDIF COMPILER12_UP} then
            begin
              Inc(Data);
              PVariant(Data)^ := VarData;
            end
            else
              FillChar(Data^, CalcFieldLen(DataType, Size), 0);
          end
          else
          begin
            Data[0] := {$IFDEF COMPILER12_UP}Byte{$ELSE}AnsiChar{$ENDIF COMPILER12_UP}(Ord(Buffer <> nil));
            Inc(Data);
            if Buffer <> nil then
              Move(Buffer^, Data^, CalcFieldLen(DataType, Size))
            else
              FillChar(Data^, CalcFieldLen(DataType, Size), 0);
          end;
        end;
      end;
    end
    else {fkCalculated, fkLookup}
    begin
      Inc(RecBuf, FRecordSize + Offset);
      RecBuf[0] := {$IFDEF COMPILER12_UP}Byte{$ELSE}AnsiChar{$ENDIF COMPILER12_UP}(Ord(Buffer <> nil));
      if RecBuf[0] <> {$IFDEF COMPILER12_UP}0{$ELSE}#0{$ENDIF COMPILER12_UP} then
        Move(Buffer^, RecBuf[1], DataSize);
    end;
    if not (State in [dsCalcFields, dsFilter, dsNewValue]) then
      DataEvent(deFieldChange, Longint(Field));
  end;
end;

procedure TJvMemoryData.SetFiltered(Value: Boolean);
begin
  if Active then
  begin
    CheckBrowseMode;
    if Filtered <> Value then
      inherited SetFiltered(Value);
    First;
  end
  else
    inherited SetFiltered(Value);
end;

procedure TJvMemoryData.SetOnFilterRecord(const Value: TFilterRecordEvent);
begin
  if Active then
  begin
    CheckBrowseMode;
    inherited SetOnFilterRecord(Value);
    if Filtered then
      First;
  end
  else
    inherited SetOnFilterRecord(Value);
end;

function TJvMemoryData.RecordFilter: Boolean;
var
  SaveState: TDataSetState;
begin
  Result := True;
  if Assigned(OnFilterRecord) then
  begin
    if (FRecordPos >= 0) and (FRecordPos < RecordCount) then
    begin
      SaveState := SetTempState(dsFilter);
      try
        RecordToBuffer(Records[FRecordPos], TempBuffer);
        OnFilterRecord(Self, Result);
      except
        Application.HandleException(Self);
      end;
      RestoreState(SaveState);
    end
    else
      Result := False;
  end;
end;

function TJvMemoryData.GetBlobData(Field: TField; Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): TMemBlobData;
begin
  Result := PMemBlobArray(Buffer + FBlobOfs)[Field.Offset];
end;

procedure TJvMemoryData.SetBlobData(Field: TField; Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Value: TMemBlobData);
begin
  if Buffer = ActiveBuffer then
  begin
    if State = dsFilter then
      Error(SNotEditing);
    PMemBlobArray(Buffer + FBlobOfs)[Field.Offset] := Value;
  end;
end;

procedure TJvMemoryData.CloseBlob(Field: TField);
begin
  if (FRecordPos >= 0) and (FRecordPos < FRecords.Count) and (State = dsEdit) then
    PMemBlobArray(ActiveBuffer + FBlobOfs)[Field.Offset] :=
      PMemBlobArray(Records[FRecordPos].FBlobs)[Field.Offset]
  else
    PMemBlobArray(ActiveBuffer + FBlobOfs)[Field.Offset] := '';
end;

function TJvMemoryData.CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream;
begin
  Result := TJvMemBlobStream.Create(Field as TBlobField, Mode);
end;

function TJvMemoryData.BookmarkValid(Bookmark: TBookmark): Boolean;
begin
  Result := (Bookmark <> nil) and FActive and
   (TBookmarkData({$IFDEF RTL200_UP}PByte(@Bookmark[0]){$ELSE}Bookmark{$ENDIF RTL200_UP}^) > Low(Integer)) and
   (TBookmarkData({$IFDEF RTL200_UP}PByte(@Bookmark[0]){$ELSE}Bookmark{$ENDIF RTL200_UP}^) <= FLastID);
end;

function TJvMemoryData.CompareBookmarks(Bookmark1, Bookmark2: TBookmark): Integer;
begin
  if (Bookmark1 = nil) and (Bookmark2 = nil) then
    Result := 0
  else
  if (Bookmark1 <> nil) and (Bookmark2 = nil) then
    Result := 1
  else
  if (Bookmark1 = nil) and (Bookmark2 <> nil) then
    Result := -1
  else
  if TBookmarkData({$IFDEF RTL200_UP}PByte(@Bookmark1[0]){$ELSE}Bookmark1{$ENDIF RTL200_UP}^) > TBookmarkData({$IFDEF RTL200_UP}PByte(@Bookmark2[0]){$ELSE}Bookmark2{$ENDIF RTL200_UP}^) then
    Result := 1
  else
  if TBookmarkData({$IFDEF RTL200_UP}PByte(@Bookmark1[0]){$ELSE}Bookmark1{$ENDIF RTL200_UP}^) < TBookmarkData({$IFDEF RTL200_UP}PByte(@Bookmark2[0]){$ELSE}Bookmark2{$ENDIF RTL200_UP}^) then
    Result := -1
  else
    Result := 0;
end;

procedure TJvMemoryData.GetBookmarkData(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Data: Pointer);
begin
  Move(PMemBookmarkInfo(Buffer + FBookmarkOfs)^.BookmarkData, Data^,
    SizeOf(TBookmarkData));
end;

procedure TJvMemoryData.SetBookmarkData(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Data: Pointer);
begin
  Move(Data^, PMemBookmarkInfo(Buffer + FBookmarkOfs)^.BookmarkData,
    SizeOf(TBookmarkData));
end;

function TJvMemoryData.GetBookmarkFlag(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}): TBookmarkFlag;
begin
  Result := PMemBookmarkInfo(Buffer + FBookmarkOfs)^.BookmarkFlag;
end;

procedure TJvMemoryData.SetBookmarkFlag(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Value: TBookmarkFlag);
begin
  PMemBookmarkInfo(Buffer + FBookmarkOfs)^.BookmarkFlag := Value;
end;

procedure TJvMemoryData.InternalGotoBookmark(Bookmark: Pointer);
var
  Rec: TJvMemoryRecord;
  SavePos: Integer;
  Accept: Boolean;
begin
  Rec := FindRecordID(TBookmarkData(Bookmark^));
  if Rec <> nil then
  begin
    Accept := True;
    SavePos := FRecordPos;
    try
      FRecordPos := Rec.Index;
      if Filtered then
        Accept := RecordFilter;
    finally
      if not Accept then
        FRecordPos := SavePos;
    end;
  end;
end;

procedure TJvMemoryData.InternalSetToRecord(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
begin
  InternalGotoBookmark(@PMemBookmarkInfo(Buffer + FBookmarkOfs)^.BookmarkData);
end;

procedure TJvMemoryData.InternalFirst;
begin
  FRecordPos := -1;
end;

procedure TJvMemoryData.InternalLast;
begin
  FRecordPos := FRecords.Count;
end;

{$IFNDEF COMPILER10_UP} // Delphi 2006+ has support for WideString
procedure TJvMemoryData.DataConvert(Field: TField; Source, Dest: Pointer; ToNative: Boolean);
begin
  if Field.DataType = ftWideString then
  begin
    if ToNative then
    begin
      Word(Dest^) := Length(PWideString(Source)^) * 2;
      Move(PWideChar(Source^)^, (PWideChar(Dest) + 1)^, Word(Dest^));
    end
    else
      SetString(WideString(Dest^), PWideChar({$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}(Source) + 2), Word(Source^) div 2);
  end
  else
    inherited DataConvert(Field, Source, Dest, ToNative);
end;
{$ENDIF ~COMPILER10_UP}

procedure TJvMemoryData.AssignMemoryRecord(Rec: TJvMemoryRecord; Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
var
  I: Integer;
begin
  Move(Buffer^, Rec.Data^, FRecordSize);
  for I := 0 to BlobFieldCount - 1 do
    PMemBlobArray(Rec.FBlobs)[I] := PMemBlobArray(Buffer + FBlobOfs)[I];
end;

procedure TJvMemoryData.SetMemoryRecordData(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}; Pos: Integer);
var
  Rec: TJvMemoryRecord;
begin
  if State = dsFilter then
    Error(SNotEditing);
  Rec := Records[Pos];
  AssignMemoryRecord(Rec, Buffer);
end;

procedure TJvMemoryData.SetAutoIncFields(Buffer: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP});
var
  I, Count: Integer;
  Data: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP};
begin
  Count := 0;
  for I := 0 to FieldCount - 1 do
    if (Fields[I].FieldKind in fkStoredFields) and
      (Fields[I].DataType = ftAutoInc) then
    begin
      Data := FindFieldData(Buffer, Fields[I]);
      if Data <> nil then
      begin
        Data[0] := {$IFDEF COMPILER12_UP}Byte{$ELSE}AnsiChar{$ENDIF COMPILER12_UP}(Ord(True));
        Inc(Data);
        Move(FAutoInc, Data^, SizeOf(Longint));
        Inc(Count);
      end;
    end;
  if Count > 0 then
    Inc(FAutoInc);
end;

procedure TJvMemoryData.InternalAddRecord(Buffer: Pointer; Append: Boolean);
var
  RecPos: Integer;
  Rec: TJvMemoryRecord;
begin
  if Append then
  begin
    Rec := AddRecord;
    FRecordPos := FRecords.Count - 1;
  end
  else
  begin
    if FRecordPos = -1 then
      RecPos := 0
    else
      RecPos := FRecordPos;
    Rec := InsertRecord(RecPos);
    FRecordPos := RecPos;
  end;
  SetAutoIncFields(Buffer);
  SetMemoryRecordData(Buffer, Rec.Index);
end;

procedure TJvMemoryData.InternalDelete;
var
  Accept: Boolean;
  Status: TRecordStatus;
  PFValues: TPVariant;
begin
  Status := rsOriginal; // Disable warnings
  PFValues := nil;
  if FApplyMode <> amNone then
  begin
    Status := TRecordStatus(FieldByName(FStatusName).AsInteger);
    if Status <> rsInserted then
    begin
      if FApplyMode = amAppend then
      begin
        Cancel;
        Exit;
      end
      else
      begin
        New(PFValues);
        PFValues^ := GetValues;
      end;
    end;
  end;

  Records[FRecordPos].Free;
  if FRecordPos >= FRecords.Count then
    Dec(FRecordPos);
  Accept := True;
  repeat
    if Filtered then
      Accept := RecordFilter;
    if not Accept then
      Dec(FRecordPos);
  until Accept or (FRecordPos < 0);
  if FRecords.Count = 0 then
    FLastID := Low(Integer);

  if FApplyMode <> amNone then
  begin
    if Status = rsInserted then
      Dec(FRowsChanged)
    else
      FDeletedValues.Add(PFValues);
    if Status = rsOriginal then
      Inc(FRowsChanged);
  end;
end;

procedure TJvMemoryData.InternalPost;
var
  RecPos: Integer;
  Index: Integer;
  Status: TRecordStatus;
  NewChange: Boolean;
begin
  {$IFDEF COMPILER6_UP}
  inherited InternalPost;
  {$ENDIF COMPILER6_UP}

  NewChange := False;
  if (FApplyMode <> amNone) and not IsLoading then
  begin
    Status := TRecordStatus(FieldByName(FStatusName).AsInteger);
    (* if (State = dsEdit) and (Status In [rsInserted,rsUpdated]) then NewChange := False; *)
    if (State = dsEdit) and (Status = rsOriginal) then
    begin
      if FApplyMode = amAppend then
      begin
        Cancel;
        Exit;
      end
      else
      begin
        NewChange := True;
        FieldByName(FStatusName).AsInteger := Integer(rsUpdated);
      end;
    end;
    if State = dsInsert then
    begin
      if IsDeleted(Index) then
      begin
        FDeletedValues[Index] := nil;
        FDeletedValues.Delete(Index);
        if FApplyMode = amAppend then
          FieldByName(FStatusName).AsInteger := Integer(rsInserted)
        else
          FieldByName(FStatusName).AsInteger := Integer(rsUpdated);
      end
      else
      begin
        NewChange := True;
        FieldByName(FStatusName).AsInteger := Integer(rsInserted);
      end;
    end;
  end;

  if State = dsEdit then
    SetMemoryRecordData(ActiveBuffer, FRecordPos)
  else
  begin
    if State in [dsInsert] then
      SetAutoIncFields(ActiveBuffer);
    if FRecordPos >= FRecords.Count then
    begin
      SetMemoryRecordData(ActiveBuffer, AddRecord.Index);
      FRecordPos := FRecords.Count - 1;
    end
    else
    begin
      if FRecordPos = -1 then
        RecPos := 0
      else
        RecPos := FRecordPos;
      SetMemoryRecordData(ActiveBuffer, InsertRecord(RecPos).Index);
      FRecordPos := RecPos;
    end;
  end;

  if NewChange then
    Inc(FRowsChanged);
end;

procedure TJvMemoryData.OpenCursor(InfoQuery: Boolean);
begin
  try
    if FDataSet <> nil then
    begin
      if FLoadStructure then
        CopyStructure(FDataSet, FAutoIncAsInteger)
      else
      if FApplyMode <> amNone then
      begin
        AddStatusField;
        HideStatusField;
      end;
    end;
  except
    SysUtils.Abort;
    Exit;
  end;

  if not InfoQuery then
  begin
    if FieldCount > 0 then
      FieldDefs.Clear;
    InitFieldDefsFromFields;
  end;
  FActive := True;
  inherited OpenCursor(InfoQuery);
end;

procedure TJvMemoryData.InternalOpen;
begin
  BookmarkSize := SizeOf(TBookmarkData);
  if DefaultFields then
    CreateFields;
  BindFields(True);
  InitBufferPointers(True);
  InternalFirst;
end;

procedure TJvMemoryData.DoAfterOpen;
begin
  if (FDataSet <> nil) and FLoadRecords then
  begin
    if not FDataSet.Active then
      FDataSet.Open;
    FRowsOriginal := CopyFromDataset;
    if FRowsOriginal > 0 then
    begin
      SortOnFields();
      if FApplyMode = amAppend then
        Last
      else
        First;
    end;
    if FDataset.Active and FDatasetClosed then
      FDataset.Close;
  end
  else
  if not IsEmpty then
    SortOnFields();
  inherited DoAfterOpen;
end;

procedure TJvMemoryData.InternalClose;
begin
  ClearRecords;
  FAutoInc := 1;
  BindFields(False);
  if DefaultFields then
    DestroyFields;
  FreeIndexList;
  FActive := False;
end;

procedure TJvMemoryData.InternalHandleException;
begin
  Application.HandleException(Self);
end;

procedure TJvMemoryData.InternalInitFieldDefs;
begin
  // InitFieldDefsFromFields
end;

function TJvMemoryData.IsCursorOpen: Boolean;
begin
  Result := FActive;
end;

function TJvMemoryData.GetRecordCount: Integer;
begin
  Result := FRecords.Count;
end;

function TJvMemoryData.GetRecNo: Integer;
begin
  CheckActive;
  UpdateCursorPos;
  if (FRecordPos = -1) and (RecordCount > 0) then
    Result := 1
  else
    Result := FRecordPos + 1;
end;

procedure TJvMemoryData.SetRecNo(Value: Integer);
begin
  if (Value > 0) and (Value <= FRecords.Count) then
  begin
    DoBeforeScroll;
    FRecordPos := Value - 1;
    Resync([]);
    DoAfterScroll;
  end;
end;

function TJvMemoryData.IsSequenced: Boolean;
begin
  Result := not Filtered;
end;

function TJvMemoryData.Locate(const KeyFields: string; const KeyValues: Variant;
  Options: TLocateOptions): Boolean;
begin
  DoBeforeScroll;
  Result := DataSetLocateThrough(Self, KeyFields, KeyValues, Options);
  if Result then
  begin
    DataEvent(deDataSetChange, 0);
    DoAfterScroll;
  end;
end;

function TJvMemoryData.Lookup(const KeyFields: string; const KeyValues: Variant;
  const ResultFields: string): Variant;
var
  FieldCount: Integer;
  Fields: TList;
  Fld: TField; //else BAD mem leak on 'Field.asString'
  // Bookmark: TBookmarkStr;
  SaveState: TDataSetState;
  I: Integer;
  Matched: Boolean;

  function CompareField(var Field: TField; Value: Variant): Boolean; {BG}
  var
    S: string;
  begin
    if Field.DataType = ftString then
    begin
      if Value = Null then
        Result := Field.IsNull
      else
      begin
        S := Field.AsString;
        Result := AnsiSameStr(S, Value);
      end;
    end
    else
      Result := (Field.Value = Value);
  end;

  function CompareRecord: Boolean;
  var
    I: Integer;
  begin
    if FieldCount = 1 then
    begin
      Fld := TField(Fields.First);
      Result := CompareField(Fld, KeyValues);
    end
    else
    begin
      Result := True;
      for I := 0 to FieldCount - 1 do
      begin
        Fld := TField(Fields[I]);
        Result := Result and CompareField(Fld, KeyValues[I]);
      end;
    end;
  end;

begin
  Result := Null;
  CheckBrowseMode;
  if IsEmpty then
    Exit;

  Fields := TList.Create;
  try
    GetFieldList(Fields, KeyFields);
    FieldCount := Fields.Count;
    Matched := CompareRecord;
    if Matched then
      Result := FieldValues[ResultFields]
    else
    begin
      SaveState := SetTempState(dsCalcFields);
      try
        try
          for I := 0 to RecordCount - 1 do
          begin
            RecordToBuffer(Records[I], TempBuffer);
            CalculateFields(TempBuffer);
            Matched := CompareRecord;
            if Matched then
              Break;
          end;
        finally
          if Matched then
            Result := FieldValues[ResultFields];
        end;
      finally
        RestoreState(SaveState);
      end;
    end;
  finally
    Fields.Free;
  end;
end;

procedure TJvMemoryData.EmptyTable;
begin
  if Active then
  begin
    CheckBrowseMode;
    ClearRecords;
    ClearBuffers;
    DataEvent(deDataSetChange, 0);
  end;
end;

procedure TJvMemoryData.AddStatusField;
begin
  // Check if FieldStatus not exists in FieldDefs
  if (FieldDefs.Count > 0) and not (FieldDefs[FieldDefs.Count - 1].Name =
    FStatusName) then
    FieldDefs.Add(FStatusName, ftSmallint);
end;

procedure TJvMemoryData.HideStatusField;
begin
  // Check if FieldStatus already exists in FieldDefs
  if (FieldDefs.Count > 0) and (FieldDefs[FieldDefs.Count - 1].Name = FStatusName) then
  begin
    FieldDefs[FieldDefs.Count - 1].Attributes := [faHiddenCol]; // Hide in FieldDefs
    // Check if FieldStatus not exists in Fields
    if not (Fields[Fields.Count - 1].FieldName = FStatusName) then
      FieldDefs[FieldDefs.Count - 1].CreateField(Self);
    Fields[Fields.Count - 1].Visible := False; // Hide in Fields
  end;
end;

procedure TJvMemoryData.CheckStructure(UseAutoIncAsInteger: Boolean);
var
  I: Integer;

  procedure CheckDataTypes(FieldDefs: TFieldDefs);
  var
    J: Integer;
  begin
    for J := FieldDefs.Count - 1 downto 0 do
    begin
      if (FieldDefs.Items[J].DataType = ftAutoInc) and UseAutoIncAsInteger then
        FieldDefs.Items[J].DataType := ftInteger;
      if not (FieldDefs.Items[J].DataType in ftSupported) then
        FieldDefs.Items[J].Free;
    end;
  end;

begin
  CheckDataTypes(FieldDefs);
  for I := 0 to FieldDefs.Count - 1 do
    if (csDesigning in ComponentState) and (Owner <> nil) then
      FieldDefs.Items[I].CreateField(Owner)
    else
      FieldDefs.Items[I].CreateField(Self);
end;

procedure TJvMemoryData.SetDataSet(ADataSet: TDataSet);
begin
  FDataSet := ADataSet;
end;

procedure TJvMemoryData.FixReadOnlyFields(MakeReadOnly: Boolean);
var
  I: Integer;
begin
  if MakeReadOnly then
    for I := 0 to FieldCount - 1 do
      Fields[I].ReadOnly := (Fields[I].Tag = 1)
  else
    for I := 0 to FieldCount - 1 do
    begin
      Fields[I].Tag := Ord(Fields[I].ReadOnly);
      Fields[I].ReadOnly := False;
      if Fields[I].DataType = ftAutoInc then
        FAutoIncField := Fields[I];
    end;
end;

procedure TJvMemoryData.CopyStructure(Source: TDataSet; UseAutoIncAsInteger: Boolean);
var
  I: Integer;
begin
  if Source = nil then
    Exit;
  CheckInactive;
  for I := FieldCount - 1 downto 0 do
    Fields[I].Free;

  Source.FieldDefs.Update;
  FieldDefs := Source.FieldDefs;
  if FApplyMode <> amNone then
    AddStatusField;
  CheckStructure(UseAutoIncAsInteger);
  if FApplyMode <> amNone then
    HideStatusField;
end;

function TJvMemoryData.LoadFromDataSet(Source: TDataSet; RecordCount: Integer;
  Mode: TLoadMode; DisableAllControls: Boolean = True): Integer;
var
  MovedCount, I: Integer;
  SB, DB: TBookmark;
begin
  Result := 0;
  if Source = Self then
    Exit;
  FSaveLoadState := slsLoading;
  //********** Source *********
  if DisableAllControls then
    Source.DisableControls;
  if not Source.Active then
    Source.Open
  else
    Source.CheckBrowseMode;
  Source.UpdateCursorPos;
  SB := Source.GetBookmark;
  //***************************  
  try
    //********** Dest (self) ***********
    if DisableAllControls then
      DisableControls;
    Filtered := False;
    if Mode = lmCopy then
    begin
      Close;
      CopyStructure(Source, FAutoIncAsInteger);
    end;
    FreeIndexList;
    if not Active then
      Open
    else
      CheckBrowseMode;
    DB := GetBookmark;
    //**********************************
    try
      if RecordCount > 0 then
      begin
        MovedCount := RecordCount;
      end
      else
      begin
        Source.First;
        MovedCount := MaxInt;
      end;
      FAutoIncField := nil;
      // FixReadOnlyFields also sets FAutoIncField if there is any
      FixReadOnlyFields(False);
      // find first source autoinc field
      FSrcAutoIncField := nil;
      if Mode = lmCopy then
        for I := 0 to Source.FieldCount - 1 do
          if Source.Fields[I].DataType = ftAutoInc then
          begin
            FSrcAutoIncField := Source.Fields[I];
            Break;
          end;
      try
        while not Source.EOF do
        begin
          Append;
          AssignRecord(Source, Self, True);
          // assign AutoInc value manually (make user keep largest if source isn't sorted by autoinc field)
          if (FAutoIncField <> nil) and (FSrcAutoIncField <> nil) then
            FAutoInc := Max(FAutoInc, FSrcAutoIncField.AsInteger);
          if (Mode = lmCopy) and (FApplyMode <> amNone) then
            FieldByName(FStatusName).AsInteger := Integer(rsOriginal);
          Post;
          Inc(Result);
          if Result >= MovedCount then
            Break;
          Source.Next;
        end;
      finally
        if (Mode = lmCopy) and (FApplyMode <> amNone) then
        begin
          FRowsOriginal := Result;
          FRowsChanged := 0;
          FRowsAffected := 0;
        end;
        FixReadOnlyFields(True);
        FAutoIncField := nil;
        FSrcAutoIncField := nil;
        First;
      end;
    finally
      //********** Dest (self) ***********
      // move back to where we started from
      if (DB <> nil) and BookmarkValid(DB) then
      begin
        GotoBookmark(DB);
        FreeBookmark(DB);
      end;
      if DisableAllControls then
        EnableControls;
      //**********************************
    end;
  finally
    //************** Source **************
    // move back to where we started from
    if (SB <> nil) and Source.BookmarkValid(SB) and not Source.IsEmpty then
    begin
      Source.GotoBookmark(SB);
      Source.FreeBookmark(SB);
    end;
    if Source.Active and FDatasetClosed then
      Source.Close;
    if DisableAllControls then
      Source.EnableControls;
    //************************************
    FSaveLoadState := slsNone;
  end;
end;

function TJvMemoryData.SaveToDataSet(Dest: TDataSet; RecordCount: Integer;
  DisableAllControls: Boolean = True): Integer;
var
  MovedCount: Integer;
  SB, DB: TBookmark;
  Status: TRecordStatus;
begin
  Result := 0;
  FRowsAffected := Result;
  if Dest = Self then
    Exit;
  FSaveLoadState := slsSaving;
  //*********** Dest ************
  if DisableAllControls then
    Dest.DisableControls;
  if not Dest.Active then
    Dest.Open
  else
    Dest.CheckBrowseMode;
  Dest.UpdateCursorPos;
  DB := Dest.GetBookmark;
  SB := nil;
  //*****************************
  try
    //*********** Source (self) ************
    if DisableAllControls then
      DisableControls;
    CheckBrowseMode;
    if FApplyMode <> amNone then
    begin
      FRowsChanged := Self.RecordCount;
      DoBeforeApply(Dest, FRowsChanged);
    end
    else
    begin
      SB := GetBookmark;
    end;
    //**************************************
    try
      if RecordCount > 0 then
        MovedCount := RecordCount
      else
      begin
        First;
        MovedCount := MaxInt;
      end;
      Status := rsOriginal; // Disable warnings
      try
        while not EOF do
        begin
          if FApplyMode <> amNone then
          begin
            Status := TRecordStatus(FieldByName(FStatusName).AsInteger);
            DoBeforeApplyRecord(Dest, Status, True);
          end;
          Dest.Append;
          AssignRecord(Self, Dest, True);
          Dest.Post;
          Inc(Result);
          if FApplyMode <> amNone then
            DoAfterApplyRecord(Dest, Status, True);
          if Result >= MovedCount then
            Break;
          Next;
        end;
      finally
        if FApplyMode <> amNone then
        begin
          FRowsAffected := Result;
          DoAfterApply(Dest, FRowsAffected);
          if Result > 0 then
            ClearChanges;
          FRowsAffected := 0;
          FRowsChanged := 0;
        end
      end;
    finally
      //*********** Source (self) ************
      if (FApplyMode = amNone) and (SB <> nil) and BookmarkValid(SB) then
      begin
        GotoBookmark(SB);
        FreeBookmark(SB);
      end;
      if DisableAllControls then
        EnableControls;
      //**************************************
    end;
  finally
    //******************* Dest *******************
    // move back to where we started from
    if (DB <> nil) and Dest.BookmarkValid(DB) and not Dest.IsEmpty then
    begin
      Dest.GotoBookmark(DB);
      Dest.FreeBookmark(DB);
    end;
    if Dest.Active and FDatasetClosed then
      Dest.Close;
    if DisableAllControls then
      Dest.EnableControls;
    //********************************************
    FSaveLoadState := slsNone;
  end;
end;

procedure TJvMemoryData.SortOnFields(const FieldNames: string = '';
  CaseInsensitive: Boolean = True; Descending: Boolean = False);
begin
  // Post the table before sorting
  if State in dsEditModes then
    Post;

  if FieldNames <> '' then
    CreateIndexList(FieldNames)
  else
  if FKeyFieldNames <> '' then
    CreateIndexList(FKeyFieldNames)
  else
    Exit;
  FCaseInsensitiveSort := CaseInsensitive;
  FDescendingSort := Descending;
  try
    Sort;
  except
    FreeIndexList;
    raise;
  end;
end;

procedure TJvMemoryData.Sort;
var
  Pos: {$IFDEF COMPILER12_UP}DB.TBookmark{$ELSE}TBookmarkStr{$ENDIF COMPILER12_UP};
begin
  if Active and (FRecords <> nil) and (FRecords.Count > 0) then
  begin
    Pos := Bookmark;
    try
      QuickSort(0, FRecords.Count - 1, CompareRecords);
      SetBufListSize(0);
      InitBufferPointers(False);
      try
        SetBufListSize(BufferCount + 1);
      except
        SetState(dsInactive);
        CloseCursor;
        raise;
      end;
    finally
      Bookmark := Pos;
    end;
    Resync([]);
  end;
end;

procedure TJvMemoryData.QuickSort(L, R: Integer; Compare: TCompareRecords);
var
  I, J: Integer;
  P: TJvMemoryRecord;
begin
  repeat
    I := L;
    J := R;
    P := Records[(L + R) shr 1];
    repeat
      while Compare(Records[I], P) < 0 do
        Inc(I);
      while Compare(Records[J], P) > 0 do
        Dec(J);
      if I <= J then
      begin
        FRecords.Exchange(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J, Compare);
    L := I;
  until I >= R;
end;

function TJvMemoryData.CompareRecords(Item1, Item2: TJvMemoryRecord): Integer;
var
  Data1, Data2: {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP};
  CData1, CData2, Buffer1, Buffer2: array[0..dsMaxStringSize] of {$IFDEF COMPILER12_UP}Byte{$ELSE}AnsiChar{$ENDIF COMPILER12_UP};
  F: TField;
  I: Integer;
begin
  Result := 0;
  if FIndexList <> nil then
  begin
    for I := 0 to FIndexList.Count - 1 do
    begin
      F := TField(FIndexList[I]);
      if F.FieldKind = fkData then
      begin
        Data1 := FindFieldData(Item1.Data, F);
        if Data1 <> nil then
        begin
          Data2 := FindFieldData(Item2.Data, F);
          if Data2 <> nil then
          begin
            if Boolean(Data1[0]) and Boolean(Data2[0]) then
            begin
              Inc(Data1);
              Inc(Data2);
              Result := CompareFields(Data1, Data2, F.DataType,
                FCaseInsensitiveSort);
            end
            else if Boolean(Data1[0]) then
              Result := 1
            else if Boolean(Data2[0]) then
              Result := -1;
            if FDescendingSort then
              Result := -Result;
          end;
        end;
        if Result <> 0 then
          Exit;
      end
      else
      begin
        FillChar(Buffer1, dsMaxStringSize, #0);
        FillChar(Buffer2, dsMaxStringSize, #0);
        RecordToBuffer(Item1, @Buffer1[0]);
        RecordToBuffer(Item2, @Buffer2[0]);
        Move(Buffer1[1 + FRecordSize + F.Offset], CData1, F.DataSize);
        if CData1[0] <> {$IFDEF COMPILER12_UP}0{$ELSE}#0{$ENDIF COMPILER12_UP} then
        begin
          Move(Buffer2[1 + FRecordSize + F.Offset], CData2, F.DataSize);
          if CData2[0] <> {$IFDEF COMPILER12_UP}0{$ELSE}#0{$ENDIF COMPILER12_UP} then
          begin
            if Boolean(CData1[0]) and Boolean(CData2[0]) then
              Result := CompareFields(@CData1, @CData2, F.DataType,
                FCaseInsensitiveSort)
            else if Boolean(CData1[0]) then
              Result := 1
            else if Boolean(CData2[0]) then
              Result := -1;
            if FDescendingSort then
              Result := -Result;
          end;
        end;
        if Result <> 0 then
          Exit;
      end;
    end;
  end;
  if Result = 0 then
  begin
    if Item1.ID > Item2.ID then
      Result := 1
    else
    if Item1.ID < Item2.ID then
      Result := -1;
    if FDescendingSort then
      Result := -Result;
  end;
end;

function TJvMemoryData.GetIsIndexField(Field: TField): Boolean;
begin
  if FIndexList <> nil then
    Result := FIndexList.IndexOf(Field) >= 0
  else
    Result := False;
end;

procedure TJvMemoryData.CreateIndexList(const FieldNames: WideString);
var
  Pos: Integer;
  F: TField;
begin
  if FIndexList = nil then
    FIndexList := TList.Create
  else
    FIndexList.Clear;
  Pos := 1;
  while Pos <= Length(FieldNames) do
  begin
    F := FieldByName(ExtractFieldNameEx(FieldNames, Pos));
    if {(F.FieldKind = fkData) and }(F.DataType in ftSupported - ftBlobTypes) then
      FIndexList.Add(F)
    else
      ErrorFmt(SFieldTypeMismatch, [F.DisplayName]);
  end;
end;

procedure TJvMemoryData.FreeIndexList;
begin
  if FIndexList <> nil then
  begin
    FIndexList.Free;
    FIndexList := nil;
  end;
end;

function TJvMemoryData.GetValues(FldNames: string = ''): Variant;
var
  I: Integer;
  List: TList;
begin
  Result := Null;
  if FldNames = '' then
    FldNames := FKeyFieldNames;
  if FldNames = '' then
    Exit;

  // Mantis 3610: If there is only one field in the dataset, return a
  // variant array with only one element. This seems to be required for
  // ADO, DBIsam, DBX and others to work.
  if Pos(';', FldNames) > 0 then
  begin
    List := TList.Create;
    GetFieldList(List, FldNames);
    Result := VarArrayCreate([0, List.Count - 1], varVariant);
    for I := 0 to List.Count - 1 do
      Result[I] := TField(List[I]).Value;
    FreeAndNil(List);
  end
  else
  if FOneValueInArray then
  begin
    Result := VarArrayCreate([0, 0], VarVariant);
    Result[0] := FieldByName(FldNames).Value;
  end
  else
    Result := FieldByName(FldNames).Value;
end;

function TJvMemoryData.CopyFromDataSet: Integer;
var
  I, Len: Integer;
  FOriginal, FClient: TField;
begin
  Result := 0;
  if FDataSet = nil then
    Exit;
  if FApplyMode <> amNone then
    Len := FieldDefs.Count - 2
  else
    Len := FieldDefs.Count - 1;
  if Len < 1 then
    Exit;
  try
    if not FDataSet.Active then
      FDataSet.Open;
  except
    Exit;
  end;
  if FDataSet.IsEmpty then
  begin
    if FDataSet.Active and FDatasetClosed then
      FDataSet.Close;
    Exit;
  end;

  FDataSet.DisableControls;
  DisableControls;
  FSaveLoadState := slsLoading;
  try
    FDataSet.First;
    while not FDataSet.EOF do
    begin
      Append;
      for I := 0 to Len do
      begin
        FClient := Fields[I];
        FOriginal := FDataSet.FindField(FClient.FieldName);
        if (FClient <> nil) and (FOriginal <> nil) then
        begin
          if FOriginal.IsNull then
            Fields[I].Clear
          else
            Fields[I].Value := FOriginal.Value;
        end;
      end;
      if FApplyMode <> amNone then
        FieldByName(FStatusName).AsInteger := Integer(rsOriginal);
      Post;
      Inc(Result);
      FDataSet.Next;
    end;
    FRowsChanged := 0;
    FRowsAffected := 0;
  finally
    FSaveLoadState := slsNone;
    EnableControls;
    FDataSet.EnableControls;
    if FDataSet.Active and FDatasetClosed then
      FDataSet.Close;
  end;
end;

procedure TJvMemoryData.DoBeforeApply(ADataSet: TDataset; RowsPending: Integer);
begin
  if Assigned(FBeforeApply) then
    FBeforeApply(ADataset, RowsPending);
end;

procedure TJvMemoryData.DoAfterApply(ADataSet: TDataset; RowsApplied: Integer);
begin
  if Assigned(FAfterApply) then
    FAfterApply(ADataset, RowsApplied);
end;

procedure TJvMemoryData.DoBeforeApplyRecord(ADataset: TDataset;
  RS: TRecordStatus; Found: Boolean);
begin
  if Assigned(FBeforeApplyRecord) then
    FBeforeApplyRecord(ADataset, RS, Found);
end;

procedure TJvMemoryData.DoAfterApplyRecord(ADataset: TDataset;
  RS: TRecordStatus; Apply: Boolean);
begin
  if Assigned(FAfterApplyRecord) then
    FAfterApplyRecord(ADataset, RS, Apply);
end;

procedure TJvMemoryData.ClearChanges;
var
  I: Integer;
  PFValues: TPVariant;
begin
  if FDeletedValues.Count > 0 then
  begin
    for I := 0 to (FDeletedValues.Count - 1) do
    begin
      PFValues := FDeletedValues[I];
      if PFValues <> nil then
        Dispose(PFValues);
      FDeletedValues[I] := nil;
    end;
    FDeletedValues.Clear;
  end;

  EmptyTable;

  if FLoadRecords then
  begin
    FRowsOriginal := CopyFromDataSet;
    if FRowsOriginal > 0 then
    begin
      if FKeyFieldNames <> '' then
        SortOnFields();
      if FApplyMode = amAppend then
        Last
      else
        First;
    end;
  end;
end;

procedure TJvMemoryData.CancelChanges;
begin
  CheckBrowseMode;
  ClearChanges;
  FRowsChanged := 0;
  FRowsAffected := 0;
end;

function TJvMemoryData.ApplyChanges: Boolean;
var
  xKey: Variant;
  PxKey: TPVariant;
  Len, Row: Integer;
  Status: TRecordStatus;
  bFound, bApply: Boolean;
  FOriginal, FClient: TField;

  function WriteFields: Boolean;
  var
    J: Integer;
  begin
    try
      for J := 0 to Len do
      begin
        if (Fields[J].FieldKind = fkData) then
        begin
          FClient := Fields[J];
          FOriginal := FDataSet.FindField(FClient.FieldName);
          if (FOriginal <> nil) and (FClient <> nil) then
          begin
            if FClient.IsNull then
              FOriginal.Clear
            else
              FDataSet.FieldByName(FOriginal.FieldName).Value := FClient.Value;
          end;
        end;
      end;
      Result := True;
    except
      Result := False;
    end;
  end;

  function InsertRec: Boolean;
  begin
    try
      FDataSet.Append;
      WriteFields;
      FDataSet.Post;
      Result := True;
    except
      Result := False;
    end;
  end;

  function UpdateRec: Boolean;
  begin
    try
      FDataSet.Edit;
      WriteFields;
      FDataSet.Post;
      Result := True;
    except
      Result := False;
    end;
  end;

  function DeleteRec: Boolean;
  begin
    try
      FDataSet.Delete;
      Result := True;
    except
      Result := False;
    end;
  end;

  function SaveChanges: Integer;
  var
    I: Integer;
  begin
    Result := 0;
    FDataSet.DisableControls;
    DisableControls;
    Row := RecNo;
    FSaveLoadState := slsSaving;
    try
      if not IsEmpty then
        First;
      while not EOF do
      begin
        Status := TRecordStatus(FieldByName(FStatusName).AsInteger);
        if (Status <> rsOriginal) then
        begin
          xKey := GetValues;
          bFound := FDataSet.Locate(FKeyFieldNames, xKey, []);
          DoBeforeApplyRecord(FDataSet, Status, bFound);
          bApply := False;
          (********************* New Record ***********************)
          if IsInserted then
          begin
            if not bFound then // Not Exists in Original
            begin
              if InsertRec then
              begin
                Inc(Result);
                bApply := True;
              end
              else
              if FExactApply then
              begin
                Error(RsEInsertError);
                Break;
              end
              else
              if (FDataSet.State in dsEditModes) then
                FDataSet.Cancel;
            end
            else
            if FApplyMode = amMerge then // Exists in Original
            begin
              if UpdateRec then
              begin
                Inc(Result);
                bApply := True;
              end
              else
              if FExactApply then
              begin
                Error(RsEUpdateError);
                Break;
              end
              else
              if (FDataset.State in dsEditModes) then
                FDataset.Cancel;
            end
            else
            if FExactApply then
            begin
              Error(RsERecordDuplicate);
              Break;
            end;
          end;
          (*********************** Modified Record ************************)
          if IsUpdated then
          begin
            if bFound then // Exists in Original
            begin
              if UpdateRec then
              begin
                Inc(Result);
                bApply := True;
              end
              else
              if FExactApply then
              begin
                Error(RsEUpdateError);
                Break;
              end
              else
              if (FDataset.State in dsEditModes) then
                FDataset.Cancel;
            end
            else
            if FApplyMode = amMerge then // Not exists in Original
            begin
              if InsertRec then
              begin
                Inc(Result);
                bApply := True;
              end
              else
              if FExactApply then
              begin
                Error(RsEInsertError);
                Break;
              end
              else
              if FDataset.State in dsEditModes then
                FDataset.Cancel;
            end
            else
            if FExactApply then
            begin
              Error(RsERecordInexistent);
              Break;
            end;
          end;
          DoAfterApplyRecord(FDataset, Status, bApply);
        end;
        Next;
      end;
      (*********************** Deleted Records **************************)
      if (FApplyMode = amMerge) then
      begin
        for I := 0 to FDeletedValues.Count - 1 do
        begin
          Status := rsDeleted;
          PxKey := FDeletedValues[I];
          // Mantis #3974 : "FDeletedValues" is a List of Pointers, and each item have two
          // possible values... PxKey (a Variant) or NIL. The list counter is incremented
          // with the ADD() method and decremented with the DELETE() method
          if not (PxKey = nil) then // ONLY if FDeletedValues[I] have a value <> NIL
          begin
            xKey := PxKey^;
            bFound := FDataSet.Locate(FKeyFieldNames, xKey, []);
            DoBeforeApplyRecord(FDataSet, Status, bFound);
            bApply := False;
            if bFound then // Exists in Original
            begin
              if DeleteRec then
              begin
                Inc(Result);
                bApply := True;
              end
              else
              if FExactApply then
              begin
                Error(RsEDeleteError);
                Break;
              end;
            end
            else
            if FExactApply then // Not exists in Original
            begin
              Error(RsERecordInexistent);
              Break;
            end
            else
            begin
              Inc(Result);
              bApply := True;
            end;
            DoAfterApplyRecord(FDataSet, Status, bApply);
          end;
        end;
      end;
    finally
      FSaveLoadState := slsNone;
      RecNo := Row;
      EnableControls;
      FDataSet.EnableControls;
    end;
  end;

begin
  Result := False;

  if (FDataSet = nil) or (FApplyMode = amNone) then
    Exit;
  if (FApplyMode <> amNone) and (FKeyFieldNames = '') then
    Exit;
  Len := FieldDefs.Count - 2;
  if (Len < 1) then
    Exit;

  try
    if not FDataSet.Active then
      FDataSet.Open;
  except
    Exit;
  end;

  CheckBrowseMode;
  DoBeforeApply(FDataset, FRowsChanged);

  FSaveLoadState := slsSaving;
  if (FRowsChanged < 1) or (IsEmpty and (FDeletedValues.Count < 1)) then
  begin
    FRowsAffected := 0;
    Result := (FRowsAffected = FRowsChanged);
  end
  else
  begin
    FRowsAffected := SaveChanges;
    Result := (FRowsAffected = FRowsChanged) or
      ((FRowsAffected > 0) and (FRowsAffected < FRowsChanged) and not FExactApply);
  end;
  FSaveLoadState := slsNone;

  DoAfterApply(FDataset, FRowsAffected);
  if Result then
    ClearChanges;

  FRowsAffected := 0;
  FRowsChanged := 0;

  if FDataSet.Active and FDatasetClosed then
    FDataset.Close;
end;

function TJvMemoryData.FindDeleted(KeyValues: Variant): Integer;
var
  I, J, Len, Equals: Integer;
  PxKey: TPVariant;
  xKey, ValRow, ValDel: Variant;
begin
  Result := -1;
  if VarIsNull(KeyValues) then
    Exit;
  PxKey := nil;
  Len := VarArrayHighBound(KeyValues, 1);
  try
    for I := 0 to FDeletedValues.Count - 1 do
    begin
      PxKey := FDeletedValues[I];
      // Mantis #3974 : "FDeletedValues" is a List of Pointers, and each item have two
      // possible value... PxKey (a Variant) or NIL. The list counter is incremented
      // with the ADD() method and decremented with the DELETE() method
      if PxKey <> nil then // ONLY if FDeletedValues[I] have a value <> NIL
      begin
        xKey := PxKey^;
        Equals := -1;
        for J := 0 to Len - 1 do
        begin
          ValRow := KeyValues[J];
          ValDel := xKey[J];
          if VarCompareValue(ValRow, ValDel) = vrEqual then
          begin
            Inc(Equals);
            if Equals = (Len - 1) then
              Break;
          end;
        end;
        if Equals = (Len - 1) then
        begin
          Result := I;
          Break;
        end;
      end;
    end;
  finally
    if PxKey <> nil then
      Dispose(PxKey);
  end;
end;

function TJvMemoryData.IsDeleted(out Index: Integer): Boolean;
begin
  Index := FindDeleted(GetValues());
  Result := Index > -1;
end;

function TJvMemoryData.IsInserted: Boolean;
begin
  Result := TRecordStatus(FieldByName(FStatusName).AsInteger) = rsInserted;
end;

function TJvMemoryData.IsUpdated: Boolean;
begin
  Result := TRecordStatus(FieldByName(FStatusName).AsInteger) = rsUpdated;
end;

function TJvMemoryData.IsOriginal: Boolean;
begin
  Result := TRecordStatus(FieldByName(FStatusName).AsInteger) = rsOriginal;
end;

function TJvMemoryData.IsLoading: Boolean;
begin
  Result := FSaveLoadState = slsLoading;
end;

function TJvMemoryData.IsSaving: Boolean;
begin
  Result := FSaveLoadState = slsSaving;
end;

//=== { TJvMemBlobStream } ===================================================

constructor TJvMemBlobStream.Create(Field: TBlobField; Mode: TBlobStreamMode);
begin
  // (rom) added inherited Create;
  inherited Create;
  FMode := Mode;
  FField := Field;
  FDataSet := FField.DataSet as TJvMemoryData;
  if not FDataSet.GetActiveRecBuf(FBuffer) then
    Exit;
  if not FField.Modified and (Mode <> bmRead) then
  begin
    if FField.ReadOnly then
      ErrorFmt(SFieldReadOnly, [FField.DisplayName]);
    if not (FDataSet.State in [dsEdit, dsInsert]) then
      Error(SNotEditing);
    FCached := True;
  end
  else
    FCached := (FBuffer = FDataSet.ActiveBuffer);
  FOpened := True;
  if Mode = bmWrite then
    Truncate;
end;

destructor TJvMemBlobStream.Destroy;
begin
  if FOpened and FModified then
    FField.Modified := True;
  if FModified then
    try
      FDataSet.DataEvent(deFieldChange, Longint(FField));
    except
      Application.HandleException(Self);
    end;
  // (rom) added inherited Destroy;
  inherited Destroy;
end;

function TJvMemBlobStream.GetBlobFromRecord(Field: TField): TMemBlobData;
var
  Rec: TJvMemoryRecord;
  Pos: Integer;
begin
  Result := '';
  Pos := FDataSet.FRecordPos;
  if (Pos < 0) and (FDataSet.RecordCount > 0) then
    Pos := 0
  else
  if Pos >= FDataSet.RecordCount then
    Pos := FDataSet.RecordCount - 1;
  if (Pos >= 0) and (Pos < FDataSet.RecordCount) then
  begin
    Rec := FDataSet.Records[Pos];
    if Rec <> nil then
      Result := PMemBlobArray(Rec.FBlobs)[FField.Offset];
  end;
end;

function TJvMemBlobStream.Read(var Buffer; Count: Longint): Longint;
begin
  Result := 0;
  if FOpened then
  begin
    if Count > Size - FPosition then
      Result := Size - FPosition
    else
      Result := Count;
    if Result > 0 then
    begin
      if FCached then
      begin
        Move({$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}(FDataSet.GetBlobData(FField, FBuffer))[FPosition], Buffer,
          Result);
        Inc(FPosition, Result);
      end
      else
      begin
        Move({$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}(GetBlobFromRecord(FField))[FPosition], Buffer, Result);
        Inc(FPosition, Result);
      end;
    end;
  end;
end;

function TJvMemBlobStream.Write(const Buffer; Count: Longint): Longint;
var
  Temp: TMemBlobData;
begin
  Result := 0;
  if FOpened and FCached and (FMode <> bmRead) then
  begin
    Temp := FDataSet.GetBlobData(FField, FBuffer);
    if Length(Temp) < FPosition + Count then
      SetLength(Temp, FPosition + Count);
    Move(Buffer, {$IFDEF COMPILER12_UP}PByte{$ELSE}PChar{$ENDIF COMPILER12_UP}(Temp)[FPosition], Count);
    FDataSet.SetBlobData(FField, FBuffer, Temp);
    Inc(FPosition, Count);
    Result := Count;
    FModified := True;
  end;
end;

function TJvMemBlobStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning:
      FPosition := Offset;
    soFromCurrent:
      Inc(FPosition, Offset);
    soFromEnd:
      FPosition := GetBlobSize + Offset;
  end;
  Result := FPosition;
end;

procedure TJvMemBlobStream.Truncate;
begin
  if FOpened and FCached and (FMode <> bmRead) then
  begin
    FDataSet.SetBlobData(FField, FBuffer, '');
    FModified := True;
  end;
end;

function TJvMemBlobStream.GetBlobSize: Longint;
begin
  Result := 0;
  if FOpened then
    if FCached then
      Result := Length(FDataSet.GetBlobData(FField, FBuffer))
    else
      Result := Length(GetBlobFromRecord(FField));
end;

{$IFDEF UNITVERSIONING}
initialization
  RegisterUnitVersion(HInstance, UnitVersioning);

finalization
  UnregisterUnitVersion(HInstance);
{$ENDIF UNITVERSIONING}

end.
