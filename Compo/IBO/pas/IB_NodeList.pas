
{                                                                              }
{ IB_NodeList                                                                  }
{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_NodeList;

interface

uses
  Classes, SysUtils,

  IB_Header,
  IB_Session;

type
TIB_NodeRef = record
  Node: PIB_Node;
  Pos: longint;
  DelCnt: longint;
  FilCnt: longint;
  DblCnt: longint;
end;

const
  InvalidNodeRef: TIB_NodeRef = ( Node: nil;
                                  Pos: -MaxInt; // InvalidNodePos
                                  DelCnt: 0;
                                  FilCnt: 0;
                                  DblCnt: 0; );

type
TIB_NodeEvent = procedure ( Sender: TObject; ANode: PIB_Node ) of object;
TIB_NodeBooleanEvent = procedure (     Sender: TObject;
                                       ANode: PIB_Node;
                                   var ABoolean: boolean ) of object;
TIB_ApplyUpdateEvent = procedure (   Sender: TObject;
                                     ANode: PIB_Node;
                                     UpdateKind: TIB_UpdateKind;
                                 var UpdateAction: TIB_UpdateAction ) of object;
TIB_NeedRecordEvent = function ( Sender: TObject;
                                 AAscending: boolean;
                                 ANumOfRecs: longint ): longint of object;
TIB_NodeList = class
private
  FKeyDataLength: word;
  FFreeCount: longint;
  FBofNode: TIB_Node;
  FEofNode: TIB_Node;
  FCachedUpdateNode: TIB_Node;
  FBofRef: TIB_NodeRef;
  FEofRef: TIB_NodeRef;
  FMidRef: TIB_NodeRef;
  FCurRef: TIB_NodeRef;
  FBufRef: TIB_NodeRef;
  FCachedUpdateRef: TIB_NodeRef;
  FFreeList: PIB_Node;
  FTempList: PIB_Node;
  FPIList: PIB_NodeIndexItem;
  FBufferHasBof: boolean;
  FBufferHasEof: boolean;
  FDefaultSelectedState: boolean;
  FFilterDel: boolean;
  FFiltered: boolean;
  FFilterOptions: TIB_FilterOptions;
  FKeepBofRowNumZero: boolean;
  FRowNumAdjust: longint;
  FUniRowAdjust: longint;
  FUnidirectional: boolean;
  FProcessingUpdates: boolean;
  cuList: PIB_NodeIndexItem;
  cuEdtCnt: longint;
  cuInsCnt: longint;
  cuDelCnt: longint;
  FCheckSelected: boolean;
  FOnApplyUpdate: TIB_ApplyUpdateEvent;
  FOnCancelUpdate: TIB_NodeEvent;
  FOnGetRestoreInsertedRecord: TIB_NodeBooleanEvent;
  FOnGetRecordIsFiltered: TIB_NodeBooleanEvent;
  FOnBeginBusy: TNotifyEvent;
  FOnEndBusy: TNotifyEvent;
  FOnNeedRecord: TIB_NeedRecordEvent;
  function GetItemCount: longint;
  function GetCurBof: boolean;
  function GetCurEof: boolean;
  function GetBufBof: boolean;
  function GetBufEof: boolean;
  function GetIsEmpty: boolean;
  function GetBofRowNum: longint;
  function GetEofRowNum: longint;
  function GetBufRowNum: longint;
  function GetCurRowNum: longint;
  function GetRowCount: longint;
  procedure SetCurrentPos( AValue: longint );
  procedure SetBufferPos( AValue: longint );
  procedure SetFiltered( AValue: boolean );
  procedure SetFilterOptions( AValue: TIB_FilterOptions );
  procedure SetFilterDel( AValue: boolean );
protected
  procedure AdjRowNum( Adj: integer );
  procedure AdjStoredFlags( ANode: PIB_Node );
  procedure Initialize( ResetNodeFlags: boolean );
  function CreateNode: PIB_Node;
  procedure DestroyNode( var AValue: PIB_Node );
  procedure SetRefToPos(   var ARef: TIB_NodeRef;
                         const APos: longint;
                               AllowFetches: boolean );
  procedure DestroyNodeIndexList( var ListHead: PIB_NodeIndexItem );
  procedure DestroyItems;
  procedure DestroyList( var ABofNode: PIB_Node );
  procedure StoreAllNodes( FetchWholeRows, KeyLinksExist: boolean );
  procedure FreeNodeKeyBuffers( ANode: PIB_Node );
  procedure FreeNodeDataBuffers( ANode: PIB_Node;
                                 FreeBlobs,
                                 ClearFlags: boolean );
  procedure ToggleDeletedFlag( ANode: PIB_Node );
  procedure ToggleFilteredFlag( ANode: PIB_Node );
  
public{!!!}
  procedure AfterExecute( RefineZone: TIB_RefineZone );
  function AdjCurrentFilFlag( NewFiltered: boolean ): boolean;
  procedure RefMoveBy( var ARef: TIB_NodeRef;
                       AValue: longint;
                       AllowFetches: boolean );
  procedure BufferMoveBy( AValue: longint );
  procedure CurrentMoveBy( AValue: longint );
  function GetRowNum( const ARef: TIB_NodeRef ): longint;
  function GetNewNode: PIB_Node;
  procedure DeleteNode( const ANode: PIB_Node );
  procedure IterateNodeRef( var ARef: TIB_NodeRef;
                                Direction: longint;
                                AllowDeleted,
                                AllowFiltered,
                                AllowFetches,
                                AllowNilNode: boolean );
  function GetRowsBetween( const StartRef, EndRef: TIB_NodeRef ): longint;
  procedure PostUpdate( ANode: PIB_Node; ARowFlag: TIB_RowFlags );
  procedure ProcessUpdates( AProcess: TIB_CachedUpdatesProcess );
  function RevertNode( ANode: PIB_Node; RemoveFromCUList: boolean ): boolean;
  procedure SelectAll( State: boolean );
  procedure SelectRange( StartRow, EndRow: longint; State, Exclusive: boolean );
  function SetNodeSelected( ANode: PIB_Node; AValue: boolean ): boolean;
  procedure ToggleSelected;
  procedure TraceNode( ANode: PIB_Node; AStrings: TStrings );
  procedure TraceNodeRef( const ARef: TIB_NodeRef; AStrings: TStrings );
  procedure TraceBufferNodes(       Ascending,
                                    AllowDeleted,
                                    AllowFiltered: boolean;
                              const AStrings: TStrings );
  procedure DeleteNodeIndex(     ANode: PIB_Node;
                             var curNodeIndex,
                                 oldNodeIndex: PIB_NodeIndexItem );
  procedure AdjCuCounts( ANode: PIB_Node; AIncrement: integer );
  procedure RestoreCachedRecords;
  procedure RefreshFilteredRows;
public
  constructor Create; virtual;
  destructor Destroy; override;
  procedure AddToNodeIndexList( var ListHead: PIB_NodeIndexItem;
                                    ANode: PIB_Node );
  function RemoveFromNodeIndexList( var ListHead: PIB_NodeIndexItem;
                                        ANode: PIB_Node ): boolean;
  function AfterFetchCursorRow( RowBuffer: pointer;
                                NoDups,
                                WasFiltered,
                                AscZone: boolean ): PIB_Node;
  procedure AfterFetchCursorEof( AscZone: boolean );
  procedure RemoveRecords( StoreRecords,
                           IsFetchWholeRows,
                           KeyLinksExist: boolean );
  function PosOfNode( ANode: PIB_Node ): longint;
  function PositionOfNode(     ANode: PIB_Node;
                           var ADelCnt,
                               AFilCnt,
                               ADblCnt: longint ): longint;
  procedure UpdateDescriptors( NewKeyDataLength: integer );
  procedure InvalidateNodes;
  function InvalidateBookmark( const ABookmark: string;
                                 var ARef: TIB_NodeRef ): boolean;
  procedure InvalidateNode( ANode: PIB_Node );
  procedure HackBufferPos( NewPos,
                           NewDelCnt,
                           NewFilCnt,
                           NewDblCnt: longint;
                           NewNode: PIB_Node );
  procedure CurrentInsert;
  procedure CurrentDelete;
  procedure BufferDelete;
  function LookupNode(     KeyData: pointer;
                           LookAtStored: boolean;
                       var ARef: TIB_NodeRef ): boolean;
  function LookupBufferNode( KeyData: pointer ): boolean;
  function LookupCurrentNode( KeyData: pointer ): boolean;
  procedure StoreNode( ANode: PIB_Node );
{ Properties }
  property BufferPos: longint write SetBufferPos;
  property CurrentPos: longint write SetCurrentPos;
  property BofRowNum: longint read GetBofRowNum;
  property EofRowNum: longint read GetEofRowNum;
  property BufRowNum: longint read GetBufRowNum;
  property CurRowNum: longint read GetCurRowNum;
  property RowCount: longint read GetRowCount;
  property CurRef: TIB_NodeRef read FCurRef;
  property BufRef: TIB_NodeRef read FBufRef;
  property BofRef: TIB_NodeRef read FBofRef;
  property EofRef: TIB_NodeRef read FEofRef;
  property MidRef: TIB_NodeRef read FMidRef;
  property CachedUpdateRef: TIB_NodeRef read FCachedUpdateRef;
  property ProcessingUpdates: boolean read FProcessingUpdates;
  property CurBof: boolean read GetCurBof;
  property CurEof: boolean read GetCurEof;
  property BufBof: boolean read GetBufBof;
  property BufEof: boolean read GetBufEof;
  property BufferHasBof: boolean read FBufferHasBof;
  property BufferHasEof: boolean read FBufferHasEof;
  property IsEmpty: boolean read GetIsEmpty;
  property FreeCount: longint read FFreeCount;
  property ItemCount: longint read GetItemCount;
  property KeyDataLength: word read FKeyDataLength;
  property KeepBofRowNumZero: boolean read FKeepBofRowNumZero
                                      write FKeepBofRowNumZero;
  property FilterDel: boolean read FFilterDel write SetFilterDel;
  property Filtered: boolean read FFiltered write SetFiltered;
  property FilterOptions: TIB_FilterOptions read FFilterOptions
                                            write SetFilterOptions;
  property CachedEditCount: longint read cuEdtCnt;
  property CachedInsertCount: longint read cuInsCnt;
  property CachedDeleteCount: longint read cuDelCnt;
  property DefaultSelectedState: boolean read FDefaultSelectedState;
  property TempList: PIB_Node read FTempList; 
  property FreeList: PIB_Node read FFreeList;
  property Unidirectional: boolean read FUnidirectional write FUnidirectional; 
  property OnApplyUpdate: TIB_ApplyUpdateEvent read FOnApplyUpdate
                                               write FOnApplyUpdate;
  property OnCancelUpdate: TIB_NodeEvent read FOnCancelUpdate
                                         write FOnCancelUpdate;
  property OnGetRestoreInsertedRecord: TIB_NodeBooleanEvent
      read FOnGetRestoreInsertedRecord
     write FOnGetRestoreInsertedRecord;
  property OnGetRecordIsFiltered: TIB_NodeBooleanEvent
      read FOnGetRecordIsFiltered
     write FOnGetRecordIsFiltered;
  property OnBeginBusy: TNotifyEvent read FOnBeginBusy write FOnBeginBusy;
  property OnEndBusy: TNotifyEvent read FOnEndBusy write FOnEndBusy;
  property OnNeedRecord: TIB_NeedRecordEvent read FOnNeedRecord
                                             write FOnNeedRecord;
end;

implementation

uses
  IB_Constants, IB_Utils;

const
  SeekCnt = 100;

constructor TIB_NodeList.Create;
begin
  inherited Create;
  FUnidirectional := false;
  FFilterDel := true;
  Initialize( true );
end;

destructor TIB_NodeList.Destroy;
begin
  DestroyItems;
  FreeNodeKeyBuffers( @FBofNode );
  FreeNodeDataBuffers( @FBofNode, true, true );
  FreeNodeKeyBuffers( @FEofNode );
  FreeNodeDataBuffers( @FEofNode, true, true );
  FreeNodeKeyBuffers( @FCachedUpdateNode );
  FreeNodeDataBuffers( @FCachedUpdateNode, true, true );
  inherited Destroy;
end;

procedure TIB_NodeList.Initialize( ResetNodeFlags: boolean );
begin
  with FBofNode do
  begin
    Next := @FEofNode;
    Prev := nil;
    RowFlags := [ rfBof, rfEof ];
  end;
  with FEofNode do
  begin
    Next := nil;
    Prev := @FBofNode;
    RowFlags := [ rfBof, rfEof ];
  end;
  FEofRef.Node := @FEofNode;
  FBofRef.Node := @FBofNode;
  FCachedUpdateRef.Node := @FCachedUpdateNode;
  FBofRef.Pos := 0;
  FEofRef.Pos := 1;
  FCachedUpdateRef.Pos := 0;
  FBofRef.DelCnt := 0;
  FBofRef.FilCnt := 0;
  FBofRef.DblCnt := 0;
  FEofRef.DelCnt := 0;
  FEofRef.FilCnt := 0;
  FEofRef.DblCnt := 0;
  FCachedUpdateRef.DelCnt := 0;
  FCachedUpdateRef.FilCnt := 0;
  FCachedUpdateRef.DblCnt := 0;
  FMidRef := BofRef;
  FCurRef := BofRef;
  FBufRef := BofRef;
  DestroyNodeIndexList( FPIList );
  FRowNumAdjust := 0;
  if ResetNodeFlags then
  begin
    FUniRowAdjust := -1;
    FBufferHasBof := true;
    FBufferHasEof := true;
    FCheckSelected := false;
    if Assigned( cuList ) then
      DestroyNodeIndexList( cuList );
    cuEdtCnt := 0;
    cuInsCnt := 0;
    if cuDelCnt <> 0 then
      cuDelCnt := 0;
  end;
end;

procedure TIB_NodeList.DestroyNodeIndexList( var ListHead: PIB_NodeIndexItem );
var
  tmpIns: PIB_NodeIndexItem;
begin
  while Assigned( ListHead ) do
  begin
    tmpIns := ListHead.Next;
    FreeMem( ListHead );
    ListHead := tmpIns;
  end;
end;

procedure TIB_NodeList.DestroyItems;
var
  tmpNode1: PIB_Node;
  tmpNode2: PIB_Node;
begin
  tmpNode1 := FBofNode.Next;
  while Assigned( tmpNode1.Next ) do
  begin
    tmpNode2 := tmpNode1.Next;
    DestroyNode( tmpNode1 );
    tmpNode1 := tmpNode2;
  end;
  DestroyList( FTempList );
  DestroyList( FFreeList );
  Initialize( true );
end;

procedure TIB_NodeList.DestroyList( var ABofNode: PIB_Node );
var
  tmpNode: PIB_Node;
begin
  while Assigned( ABofNode ) do
  begin
    tmpNode := ABofNode.Next;
    DestroyNode( ABofNode );
    ABofNode := tmpNode;
  end;
end;

{------------------------------------------------------------------------------}

function TIB_NodeList.CreateNode: PIB_Node;
begin
  Result := AllocMem( SizeOf( TIB_Node ));
  Result.KeyData := AllocMem( KeyDataLength );
end;

procedure TIB_NodeList.FreeNodeKeyBuffers( ANode: PIB_Node );
begin
  if Assigned( ANode ) then
    with ANode^ do
    begin
      FreeMem( KeyData );
      KeyData := nil;
      FreeMem( OldKeyData );
      OldKeyData := nil;
    end;
end;

procedure TIB_NodeList.FreeNodeDataBuffers( ANode: PIB_Node;
                                            FreeBlobs,
                                            ClearFlags: boolean );
begin
  if Assigned( ANode ) then
    with ANode^ do
    begin
      RecordLen := 0;
      OldRecLen := 0;
      FreeMem( RecordData );
      FreeMem( OldRecData );
      FreeMem( OldKeyData );
      RecordData := nil;
      OldRecData := nil;
      OldKeyData := nil;
      if FreeBlobs then
        FreeBlobRefList( @BlobHead );
      if ClearFlags then
        RowFlags := [];
    end;
end;

procedure TIB_NodeList.DestroyNode( var AValue: PIB_Node );
begin
  FreeNodeKeyBuffers( AValue );
  FreeNodeDataBuffers( AValue, true, true );
  FreeMem( AValue );
end;

function TIB_NodeList.GetNewNode: PIB_Node;
begin
  if Assigned( FFreeList ) then
  begin
    Result := FFreeList;
    FFreeList := FFreeList.Next;
    Dec( FFreeCount );
  end
  else
    Result := CreateNode;
  with Result^ do
  begin
    Next := nil;
    Prev := nil;
    if FDefaultSelectedState then
    begin
      FCheckSelected := true;
      RowFlags := [ rfSelected ];
    end
    else
      RowFlags := [ ];
  end;
end;

{------------------------------------------------------------------------------}

function TIB_NodeList.GetCurBof: boolean;
begin
  Result := ( rfBof in CurRef.Node.RowFlags ) or
            (( rfEof in CurRef.Node.RowFlags ) and IsEmpty );
end;
function TIB_NodeList.GetCurEof: boolean;
begin
  Result := ( rfEof in CurRef.Node.RowFlags ) or
            (( rfBof in CurRef.Node.RowFlags ) and IsEmpty );
end;
function TIB_NodeList.GetBufBof: boolean;
begin
  Result := ( rfBof in BufRef.Node.RowFlags ) or
            (( rfEof in BufRef.Node.RowFlags ) and IsEmpty );
end;
function TIB_NodeList.GetBufEof: boolean;
begin
  Result := ( rfEof in BufRef.Node.RowFlags ) or
            (( rfBof in BufRef.Node.RowFlags ) and IsEmpty );
end;
function TIB_NodeList.GetIsEmpty: boolean;
begin
  Result :=
    ( FEofRef.Pos - FEofRef.FilCnt - FEofRef.DelCnt + FEofRef.DblCnt ) -
    ( FBofRef.Pos - FBofRef.FilCnt - FBofRef.DelCnt + FBofRef.DblCnt ) = 1;
end;

procedure TIB_NodeList.BufferMoveBy( AValue: longint );
begin
// If the buffer node is not in the list put it at the Bof position.
  if BufRef.Pos < BofRef.Pos then FBufRef := BofRef;
  if AValue = 0 then
    IterateNodeRef( FBufRef, 0, not FFilterDel, not FFiltered, true, false )
  else
    RefMoveBy( FBufRef, AValue, false );
end;

procedure TIB_NodeList.CurrentMoveBy( AValue: longint );
begin
  if AValue = 0 then
    IterateNodeRef( FCurRef, 0, not FFilterDel, not FFiltered, true, false )
  else
    RefMoveBy( FCurRef, AValue, false );
end;

function TIB_NodeList.GetRowsBetween( const StartRef,
                                            EndRef: TIB_NodeRef ): longint;
var
  StartPos: boolean;
  EndPos: boolean;
begin
  if ( EndRef.Pos = StartRef.Pos ) then
  begin
    Result := 0;
    Exit;
  end;
  Result := EndRef.Pos - StartRef.Pos;
  StartPos := ( rfPos in StartRef.Node.RowFlags ) or
              (( rfEof in StartRef.Node.RowFlags ) and ( EofRef.Pos > 0 ));
  EndPos := ( rfPos in EndRef.Node.RowFlags ) or
            (( rfEof in EndRef.Node.RowFlags ) and ( EofRef.Pos > 0 ));
  if FFilterDel then
  begin
    if StartPos and EndPos then
      Dec( Result, EndRef.DelCnt - StartRef.DelCnt )
    else
    if not StartPos and not EndPos then
      Inc( Result, EndRef.DelCnt - StartRef.DelCnt )
    else
    if StartPos then
      Inc( Result, EndRef.DelCnt + StartRef.DelCnt )
    else
      Dec( Result, EndRef.DelCnt + StartRef.DelCnt );
  end;
  if FFiltered then
  begin
    if StartPos and EndPos then
      Dec( Result, EndRef.FilCnt - StartRef.FilCnt )
    else
    if not StartPos and not EndPos then
      Inc( Result, EndRef.FilCnt - StartRef.FilCnt )
    else
    if StartPos then
      Inc( Result, EndRef.FilCnt + StartRef.FilCnt )
    else
      Dec( Result, EndRef.FilCnt + StartRef.FilCnt );
    if FFilterDel then
    begin
      if StartPos and EndPos then
        Inc( Result, EndRef.DblCnt - StartRef.DblCnt )
      else
      if not StartPos and not EndPos then
        Dec( Result, EndRef.DblCnt - StartRef.DblCnt )
      else
      if StartPos then
        Dec( Result, EndRef.DblCnt + StartRef.DblCnt )
      else
        Inc( Result, EndRef.DblCnt + StartRef.DblCnt );
    end;
  end;
end;
  
procedure TIB_NodeList.RefMoveBy( var ARef: TIB_NodeRef;
                                      AValue: longint;
                                      AllowFetches: boolean );
var
  oldRef: TIB_NodeRef;
  oldRefPos: longint;
  tmpRows: longint;
  CanOpt: boolean;
begin
  CanOpt := BofRef.DelCnt + EofRef.DelCnt + BofRef.FilCnt + EofRef.FilCnt = 0;
  if CanOpt and ( AValue = 0 ) then
  else
  if CanOpt and ( AValue = 1 ) and
     Assigned( ARef.Node ) and
     Assigned( ARef.Node.Next ) then
  begin
    ARef.Node := ARef.Node.Next;
    Inc( ARef.Pos );
  end
  else
  if CanOpt and ( AValue = -1 ) and
     Assigned( ARef.Node ) and
     Assigned( ARef.Node.Prev ) then
  begin
    ARef.Node := ARef.Node.Prev;
    Dec( ARef.Pos );
  end
  else
  if CanOpt then
    SetRefToPos( ARef, ARef.Pos + AValue, AllowFetches )
  else
  begin
    oldRef := ARef;
  // Respond to the case where we are starting from a node that doesn't match
  // under the current circumstances.
    oldRefPos := oldRef.Pos;
    IterateNodeRef( ARef, 0, not FFilterDel, not FFiltered, true, true );
    if ARef.Pos > oldRefPos then
      tmpRows := -1
    else
    if ARef.Pos < oldRefPos then
      tmpRows := 1
    else
      tmpRows := 0;
    Inc( AValue, tmpRows );
    SetRefToPos( ARef, ARef.Pos + AValue, AllowFetches );
    IterateNodeRef( ARef, 0, not FFilterDel, not FFiltered, true, false );
{$IFDEF DEBUG}
    if not Assigned( OldRef.Node ) then
      raise Exception.Create( 'Unassigned node in RefMoveBy' );
{$ENDIF}
    tmpRows := tmpRows + GetRowsBetween( oldRef, ARef );
    IterateNodeRef( ARef, AValue - tmpRows, not FFilterDel,
                                            not FFiltered, AllowFetches,
                                            false );
  end;
end;

procedure TIB_NodeList.SetCurrentPos( AValue: longint );
begin
  SetRefToPos( FCurRef, AValue, false );
end;

procedure TIB_NodeList.SetBufferPos( AValue: longint );
begin
  SetRefToPos( FBufRef, AValue, false );
end;

procedure TIB_NodeList.SetRefToPos(   var ARef: TIB_NodeRef;
                                    const APos: longint;
                                          AllowFetches: boolean );
  function GetDif( const A, B: integer ): integer;
  begin
    try
      Result := A - B;
      if Result <= -high( integer ) then
        Result := high( integer )
      else
      if Result < 0 then
        Result := -Result;
    except
      on E: EIntOverflow do
        Result := high( integer );
    end;
  end;
var
  tmpRef: TIB_NodeRef;
  BofDif, EofDif, MidDif, CurDif, BufDif: longint;
begin
  if ( ItemCount = 0 ) or
     ( APos >= EofRef.Pos ) then tmpRef := EofRef else
  if ( APos <= BofRef.Pos ) then tmpRef := BofRef else
  if ( APos  = BufRef.Pos ) then tmpRef := BufRef else
  if ( APos  = CurRef.Pos ) then tmpRef := CurRef else
  if ( APos  = MidRef.Pos ) then tmpRef := MidRef else
  begin
    BofDif := GetDif( BofRef.Pos, APos );
    EofDif := GetDif( EofRef.Pos, APos );
    CurDif := GetDif( CurRef.Pos, APos );
    BufDif := GetDif( BufRef.Pos, APos );
    MidDif := GetDif( MidRef.Pos, APos );
    if BofDif < EofDif then
    begin
      if CurDif < BufDif then
      begin
        if CurDif < BofDif then
        begin
          if CurDif < MidDif then tmpRef := CurRef
                             else tmpRef := MidRef;
        end
        else
        begin
          if BofDif < MidDif then tmpRef := BofRef
                             else tmpRef := MidRef;
        end;
      end
      else
      begin
        if BufDif < BofDif then
        begin
          if BufDif < MidDif then tmpRef := BufRef
                             else tmpRef := MidRef;
        end
        else
        begin
          if BofDif < MidDif then tmpRef := BofRef
                             else tmpRef := MidRef;
        end;
      end;
    end
    else
    begin
      if CurDif < BufDif then
      begin
        if CurDif < EofDif then
        begin
          if CurDif < MidDif then tmpRef := CurRef
                             else tmpRef := MidRef;
        end
        else
        begin
          if EofDif < MidDif then tmpRef := EofRef
                             else tmpRef := MidRef;
        end;
      end
      else
      begin
        if BufDif < EofDif then
        begin
          if BufDif < MidDif then tmpRef := BufRef
                             else tmpRef := MidRef;
        end
        else
        begin
          if EofDif < MidDif then tmpRef := EofRef
                             else tmpRef := MidRef;
        end;
      end;
    end;
    IterateNodeRef( tmpRef, APos - tmpRef.Pos, true, true, AllowFetches,
                    false );
  end;
  ARef := tmpRef;
end;

procedure TIB_NodeList.AdjStoredFlags( ANode: PIB_Node );
var
  tmpNeg: boolean;
  tmpPos: boolean;
  tmpDel: boolean;
  tmpFil: boolean;
begin
  tmpPos := rfPos in ANode.RowFlags;
  tmpNeg := rfNeg in ANode.RowFlags;
  tmpDel := rfDeleted in ANode.RowFlags;
  tmpFil := rfFiltered in ANode.RowFlags;

  if tmpPos then
    Dec( FEofRef.Pos )
  else
  if tmpNeg then
    Inc( FBofRef.Pos );

//!!! MidRef Can be ignored in here.

  if tmpDel then
  begin
    if tmpPos then
      Dec( FEofRef.DelCnt )
    else
    if tmpNeg then
      Dec( FBofRef.DelCnt );
  end;

  if tmpFil then
  begin
    if tmpPos then
      Dec( FEofRef.FilCnt )
    else
    if tmpNeg then
      Dec( FBofRef.FilCnt );
    if tmpDel then
    begin
      if tmpPos then
        Dec( FEofRef.DblCnt )
      else
      if tmpNeg then
        Dec( FBofRef.DblCnt );
    end;
  end;
  ANode.RowFlags := ANode.RowFlags - [ rfPos, rfNeg, rfFiltered, rfUnsorted ];
end;

procedure TIB_NodeList.StoreNode( ANode: PIB_Node );
begin
  if Assigned( ANode ) then
  begin
    if Assigned( FTempList ) then
      FTempList.Prev := ANode;
    ANode.Next := FTempList;
    ANode.Prev := nil;
    FTempList := ANode;
    AdjStoredFlags( ANode );
  end;
end;

procedure TIB_NodeList.StoreAllNodes( FetchWholeRows, KeyLinksExist: boolean );
var
  tmpNode: PIB_Node;
  delNode: PIB_Node;
  delCount: integer;
  procedure RemoveSection;
  begin
    if Assigned( tmpNode ) then
    begin
      tmpNode.Prev.Next := FFreeList;
      tmpNode.Prev := delNode.Prev;
      delNode.Prev.Next := tmpNode;
    end
    else
    if Assigned( delNode ) then
    begin
      FEofNode.Prev.Next := FFreeList;
      delNode.Prev.Next := @FEofNode;
    end;
    FFreeList := delNode;
    Inc( FFreeCount, delCount );
    delNode := nil;
  end;
begin
  if ItemCount > 0 then
  begin
    tmpNode := FBofNode.Next;
    delNode := nil;
    while Assigned( tmpNode.Next ) do
    begin
      AdjStoredFlags( tmpNode );
      if (( tmpNode.RecordLen = 0 ) or ( FetchWholeRows and KeyLinksExist )) and
         ( tmpNode.RowFlags = [] ) and
         ( not Assigned( tmpNode.BlobHead ) or
           not KeyLinksExist or
           Unidirectional ) then
      begin
        if delNode = nil then
        begin
          delNode := tmpNode;
          delCount := 0;
        end;
        Inc( delCount );
        FreeNodeDataBuffers( tmpNode, false, false );
      end
      else
      if Assigned( delNode ) then
        RemoveSection;
      tmpNode := tmpNode.Next;
    end;
    if Assigned( delNode ) then
      RemoveSection;
  end;
  if FEofNode.Prev <> @FBofNode then
  begin
    FEofNode.Prev.Next := FTempList;
    if Assigned( FTempList ) then
      FTempList.Prev := FEofNode.Prev;
    FTempList := FBofNode.Next;
    if Assigned( FTempList ) then
      FTempList.Prev := nil;
  end;
  Initialize( false );
end;

procedure TIB_NodeList.AddToNodeIndexList( var ListHead: PIB_NodeIndexItem;
                                               ANode: PIB_Node );
var
  tmpIns: PIB_NodeIndexItem;
begin
  if Assigned( ANode ) then
  begin
    tmpIns := AllocMem( SizeOf( TIB_NodeIndexItem ));
    tmpIns.Next := ListHead;
    tmpIns.Node := ANode;
    ListHead := tmpIns;
  end;
end;

function TIB_NodeList.RemoveFromNodeIndexList( var ListHead: PIB_NodeIndexItem;
                                                   ANode: PIB_Node ): boolean;
var
  tmpIns1,
  tmpIns2: PIB_NodeIndexItem;
begin
  Result := false;
  if Assigned( ListHead ) then
  begin
    if ListHead.Node = ANode then
    begin
      tmpIns1 := ListHead.Next;
      FreeMem( ListHead );
      ListHead := tmpIns1;
      Result := true;
    end
    else
    begin
      tmpIns1 := ListHead;
      while Assigned( tmpIns1.Next ) do
      begin
        if tmpIns1.Next.Node = ANode then
        begin
          tmpIns2 := tmpIns1.Next;
          tmpIns1.Next := tmpIns1.Next.Next;
          FreeMem( tmpIns2 );
          Result := true;
          Break;
        end;
        tmpIns1 := tmpIns1.Next;
      end;
    end;
  end;
end;

procedure TIB_NodeList.AdjRowNum( Adj: integer );
begin
  if FKeepBofRowNumZero then
    Inc( FRowNumAdjust, - BofRowNum )
  else
    Inc( FRowNumAdjust, Adj );
end;

procedure TIB_NodeList.CurrentInsert;
var
  tmpNode: PIB_Node;
  tmpRef: TIB_NodeRef;
  tmpDel: boolean;
  tmpFil: boolean;
  tmpPos: boolean;

  procedure AdjustFlagCounts( var ARef: TIB_NodeRef; AInc: integer );
  begin
    if tmpDel then Inc( ARef.DelCnt, AInc );
    if tmpFil then
    begin
      Inc( ARef.FilCnt, AInc );
      if tmpDel then Inc( ARef.DblCnt, AInc );
    end;
  end;
  procedure AdjustBoundryCounts( var ARef: TIB_NodeRef );
  var
    tmpInc: integer;
  begin
    if ARef.Pos < 1 then tmpInc := -1 else tmpInc := 1;
    AdjustFlagCounts( ARef, tmpInc );
  end;

var
  oldRowNum: longint;
begin
  oldRowNum := BofRowNum;

  if not Assigned( CurRef.Node ) then
    raise EIB_Error.Create( 'Invalid ANode' );

  with FBofNode do RowFlags := RowFlags - [ rfEof ];
  with FEofNode do RowFlags := RowFlags - [ rfBof ];

// Position tmpRef to the node to be inserted in place of.
  tmpRef := CurRef;
  if tmpRef.Node = BofRef.Node then
  begin
    if IsEmpty then
      tmpRef := EofRef
    else
    // Do not allow it to insert prior to the Bof node.
      IterateNodeRef( tmpRef, 1, true, true, false, false );
  end;

// Freeze flags for later use.
  tmpPos := tmpRef.Pos > 0;
  tmpDel := rfDeleted in tmpRef.Node.RowFlags;
  tmpFil := rfFiltered in tmpRef.Node.RowFlags;

// Place new node in the list.
  tmpNode := GetNewNode;
  tmpNode.Next := tmpRef.Node;
  tmpNode.Prev := tmpRef.Node.Prev;
  tmpNode.Next.Prev.Next := tmpNode;
  tmpNode.Next.Prev := tmpNode;
  if tmpPos then tmpNode.RowFlags := tmpNode.RowFlags + [ rfPos ]
            else tmpNode.RowFlags := tmpNode.RowFlags + [ rfNeg ];
  tmpRef.Node := tmpNode;
  if tmpPos then
    AdjustFlagCounts( tmpRef, -1 );

// Fixup all the references now that the node is gone.
  if BofRef.Pos >= tmpRef.Pos then Inc( FBofRef.Pos );
  if EofRef.Pos >= tmpRef.Pos then Inc( FEofRef.Pos );
  if MidRef.Pos >= tmpRef.Pos then Inc( FMidRef.Pos );
  if CurRef.Pos >= tmpRef.Pos then Inc( FCurRef.Pos );
  if BufRef.Pos >= tmpRef.Pos then Inc( FBufRef.Pos );

  if ( MidRef.Pos < EofRef.Pos ) and
     ( MidRef.Pos > BofRef.Pos ) then
  begin
    if MidRef.Pos = 1 then
    begin
      MidRef.Node.RowFlags := MidRef.Node.RowFlags + [ rfPos ];
      MidRef.Node.RowFlags := MidRef.Node.RowFlags - [ rfNeg ];
      tmpDel := rfDeleted in MidRef.Node.RowFlags;
      tmpFil := rfFiltered in MidRef.Node.RowFlags;
      FMidRef.Node := MidRef.Node.Prev;
      FMidRef.Pos := MidRef.Pos - 1;
      AdjustFlagCounts( FMidRef, -1 );
      tmpDel := rfDeleted in MidRef.Node.RowFlags;
      tmpFil := rfFiltered in MidRef.Node.RowFlags;
      AdjustFlagCounts( FMidRef, 1 );
      tmpDel := rfDeleted in MidRef.Node.Next.RowFlags;
      tmpFil := rfFiltered in MidRef.Node.Next.RowFlags;
      AdjustBoundryCounts( tmpRef );
      AdjustBoundryCounts( FBofRef );
      AdjustBoundryCounts( FEofRef );
      AdjustBoundryCounts( FBufRef );
      AdjustBoundryCounts( FCurRef );
    end;
  end;

// Make the change final.
  FCurRef := tmpRef;
  AddToNodeIndexList( FPIList, tmpNode );
  AdjRowNum( oldRowNum - BofRowNum );
end;

procedure TIB_NodeList.DeleteNode( const ANode: PIB_Node );
var
  tmpPos: boolean;
  tmpNeg: boolean;
  tmpDel: boolean;
  tmpFil: boolean;
  APos: longint;
  BufMoved: integer;
  CurMoved: integer;
  procedure AdjustFlagCounts( var ARef: TIB_NodeRef; AInc: integer );
  begin
    if tmpDel then Inc( ARef.DelCnt, AInc );
    if tmpFil then
    begin
      Inc( ARef.FilCnt, AInc );
      if tmpDel then Inc( ARef.DblCnt, AInc );
    end;
  end;
  procedure AdjustCounts( var ARef: TIB_NodeRef );
  begin
    if ( tmpPos and ( ARef.Pos > APos )) or
       ( tmpNeg and ( ARef.Pos < APos )) then
      AdjustFlagCounts( ARef, -1 );
    if ARef.Pos >= APos then Dec( ARef.Pos );
  end;
  procedure AdjustBoundryCounts( var ARef: TIB_NodeRef );
  var
    tmpInc: integer;
  begin
    if ARef.Pos < 1 then tmpInc := 1 else tmpInc := -1;
    AdjustFlagCounts( ARef, tmpInc );
  end;
var
  tmpCU: boolean;
  BufWasEof: boolean;
  CurWasEof: boolean;
  oldRowNum: longint;
begin
  oldRowNum := BofRowNum;

// Set flags for node about to be deleted.
  tmpPos := rfPos in ANode.RowFlags;
  tmpNeg := rfNeg in ANode.RowFlags;
  tmpDel := rfDeleted in ANode.RowFlags;
  tmpFil := rfFiltered in ANode.RowFlags;
  tmpCU := [ rfApplied, rfSkipped ] * ANode.RowFlags = [];
  BufWasEof := Assigned( BufRef.Node ) and ( rfEof in BufRef.Node.RowFlags );
  CurWasEof := Assigned( CurRef.Node ) and ( rfEof in CurRef.Node.RowFlags );

// Clean up cached updates flags.
  if rfEdited in ANode.RowFlags then
  begin
    RemoveFromNodeIndexList( cuList, ANode );
    if tmpCU then Dec( cuEdtCnt );
  end;
  if rfInserted in ANode.RowFlags then
  begin
    RemoveFromNodeIndexList( cuList, ANode );
    if tmpCU then Dec( cuInsCnt );
  end;
  if tmpDel then
  begin
    RemoveFromNodeIndexList( cuList, ANode );
    if tmpCU then
      Dec( cuDelCnt );
  end;

// Move the Mid, Buf and Cur refs so that they are not corrupted.
  BufMoved := 0;
  CurMoved := 0;
  APos := InvalidNodePos;
  if tmpPos or tmpNeg then
  begin
    APos := PosOfNode( ANode );
    if BufRef.Node = ANode then
      BufMoved := -1;
    if BufMoved <> 0 then
      IterateNodeRef( FBufRef, BufMoved, true, true, false, true );
    if CurRef.Node = ANode then
      CurMoved := -1;
    if CurMoved <> 0 then
      IterateNodeRef( FCurRef, CurMoved, true, true, false, true );
    if MidRef.Node = ANode then
      IterateNodeRef( FMidRef, -1, true, true, false, true );
  end;

// Actually remove the node from the list now.  
  with ANode^ do
  begin
    if Assigned( Next ) then Next.Prev := Prev;
    if Assigned( Prev ) then Prev.Next := Next;
    Next := FFreeList;
    Prev := nil;
  end;
  FreeNodeDataBuffers( ANode, true, true );
  FFreeList := ANode;
  Inc( FFreeCount );

// Fixup all the references now that the node is gone.  
  if tmpPos or tmpNeg then
  begin
    AdjustCounts( FBofRef ); 
    AdjustCounts( FEofRef );
    AdjustCounts( FBufRef );
    AdjustCounts( FCurRef );
    AdjustCounts( FMidRef );
    if tmpNeg then
      if ( MidRef.Pos < EofRef.Pos ) and
         ( MidRef.Pos > BofRef.Pos ) then
      begin
        tmpDel := rfDeleted in MidRef.Node.RowFlags;
        tmpFil := rfFiltered in MidRef.Node.RowFlags;
        FMidRef.Node := MidRef.Node.Next;
        FMidRef.Pos := MidRef.Pos + 1;
        AdjustFlagCounts( FMidRef, -1 );
        MidRef.Node.RowFlags := MidRef.Node.RowFlags - [ rfPos ];
        MidRef.Node.RowFlags := MidRef.Node.RowFlags + [ rfNeg ];
        tmpDel := rfDeleted in MidRef.Node.RowFlags;
        tmpFil := rfFiltered in MidRef.Node.RowFlags;
        AdjustBoundryCounts( FBofRef );
        AdjustBoundryCounts( FEofRef );
        AdjustBoundryCounts( FBufRef );
        AdjustBoundryCounts( FCurRef );
        AdjustBoundryCounts( FMidRef );
      end;
  end;

// Move the pointers back  
  if BufMoved <> 0 then
    IterateNodeRef( FBufRef, -BufMoved, true, true, false, true );
  if CurMoved <> 0 then
    IterateNodeRef( FCurRef, -CurMoved, true, true, false, true );

// Be sure not to corrupt the TempList.
  if FTempList = ANode then
    FTempList := FTempList.Next;

// Be sure not to corrupt the posted inserts list.
  RemoveFromNodeIndexList( FPIList, ANode );

// Touch up the structures if necessary.
  if ItemCount = 0 then
  begin
    FBofNode.RowFlags := FBofNode.RowFlags + [ rfBof, rfEof ];
    FEofNode.RowFlags := FEofNode.RowFlags + [ rfBof, rfEof ];
  end
  else
  begin
    FBofNode.RowFlags := FBofNode.RowFlags + [ rfBof ];
    FBofNode.RowFlags := FBofNode.RowFlags - [ rfEof ];
    FEofNode.RowFlags := FEofNode.RowFlags + [ rfEof ];
    FEofNode.RowFlags := FEofNode.RowFlags - [ rfBof ];
    if tmpPos or tmpNeg then
    begin
      if not BufWasEof and BufEof then SetBufferPos( BufRef.Pos - 1 );
      if not CurWasEof and CurEof then SetCurrentPos( CurRef.Pos - 1 );
    end;
  end;
  AdjRowNum( oldRowNum - BofRowNum );
end;

procedure TIB_NodeList.BufferDelete;
begin
  if IsEmpty or BufEof or BufBof or ( BufRef.Pos < BofRef.Pos ) then
    raise Exception.Create( E_Invalid_Reference_To_Delete );
  DeleteNode( BufRef.Node );
end;

procedure TIB_NodeList.CurrentDelete;
begin
  if IsEmpty or CurEof or CurBof then
    raise Exception.Create( E_Invalid_Reference_To_Delete );
  DeleteNode( CurRef.Node );
end;

{------------------------------------------------------------------------------}

function TIB_NodeList.PosOfNode( ANode: PIB_Node ): longint;
  procedure GetAnswer( const ARef: TIB_NodeRef );
  begin
    if ( ARef.Pos <> InvalidNodePos ) and
       ( ARef.Pos <> StoredNodePos ) then
    begin
      if ANode = ARef.Node then Result := ARef.Pos else
      if ANode = ARef.Node.Next then Result := ARef.Pos + 1 else
      if ANode = ARef.Node.Prev then Result := ARef.Pos - 1;
    end;
  end;
var
  tmpNode: PIB_Node;
  tmpPos: longint;
begin
  Result := InvalidNodePos;
  if Assigned( ANode ) then
  begin
    if [ rfPos, rfNeg ] * ANode.RowFlags = [] then
      Result := StoredNodePos
    else
    begin
                                      GetAnswer( CurRef );
      if Result = InvalidNodePos then GetAnswer( BufRef );
      if Result = InvalidNodePos then GetAnswer( MidRef );
      if Result = InvalidNodePos then GetAnswer( BofRef );
      if Result = InvalidNodePos then GetAnswer( EofRef );
      if Result = InvalidNodePos then
      begin
        tmpNode := BofRef.Node;
        tmpPos := BofRef.Pos;
        while ( Result = InvalidNodePos ) and ( tmpPos < EofRef.Pos ) do
        begin
          tmpNode := tmpNode.Next;
          Inc( tmpPos );
          if tmpNode = ANode then
          begin
            Result := tmpPos;
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function TIB_NodeList.PositionOfNode(     ANode: PIB_Node;
                                      var ADelCnt,
                                          AFilCnt,
                                          ADblCnt: longint ): longint;
var
  tmpRef: TIB_NodeRef;
  procedure AssignAnswer( const ARef: TIB_NodeRef );
  begin
    Result := ARef.Pos;
    ADelCnt := ARef.DelCnt;
    AFilCnt := ARef.FilCnt;
    ADblCnt := ARef.DblCnt;
  end;
begin
  Result := InvalidNodePos;
  if ( ANode = CurRef.Node ) and ( CurRef.Pos <> InvalidNodePos ) then
    AssignAnswer( CurRef )
  else
  if ( ANode = BufRef.Node ) and ( BufRef.Pos <> InvalidNodePos ) then
    AssignAnswer( BufRef )
  else
  if ( ANode = MidRef.Node ) and ( MidRef.Pos <> InvalidNodePos ) then
    AssignAnswer( MidRef )
  else
  begin
    tmpRef := FBofRef;
    Result := InvalidNodePos;
    while ( Result = InvalidNodePos ) and
          ( tmpRef.Pos < EofRef.Pos ) do
    begin
      IterateNodeRef( tmpRef, 1, true, true, false, true );
      if tmpRef.Node = ANode then
      begin
        AssignAnswer( tmpRef );
        Break;
      end;            
    end;
  end;
end;

function TIB_NodeList.LookupNode(     KeyData: pointer;
                                      LookAtStored: boolean;
                                  var ARef: TIB_NodeRef ): boolean;
  procedure FindNode(       KeyData: pointer;
                        var ARef: TIB_NodeRef;
                      const MaxIterations: longint;
                            LookForward: boolean );
  var
    tmpCnt: longint;
  begin
    tmpCnt := 0;
    while Assigned( ARef.Node ) do
    begin
      if Assigned( ARef.Node.KeyData ) and
         ( BuffersEqual( ARef.Node.KeyData, KeyData, KeyDataLength )) and
         ( [ rfBof, rfEof ] * ARef.Node.RowFlags = [] ) then
        Break;
      if LookForward then
        IterateNodeRef( ARef, 1, true, true, false, true )
      else
        IterateNodeRef( ARef, - 1, true, true, false, true );
      Inc( tmpCnt );
      if MaxIterations <> 0 then
        if tmpCnt > MaxIterations then
        begin
          ARef.Node := nil;
          ARef.Pos := InvalidNodePos;
          Break;
        end;
    end;
  end;
var
  tmpRef: TIB_NodeRef; // Must use a local variable here.
begin
  // Initialize the temporary storage node to nil.
  tmpRef := InvalidNodeRef;
  // Look for direct match to the buffer node.
  if not BufBof and not BufEof and
     (( BufRef.Pos > BofRef.Pos ) or LookAtStored ) and
     ( BuffersEqual( BufRef.Node.KeyData,
                     KeyData,
                     KeyDataLength )) then
    tmpRef := BufRef;
  // Look for direct match to the current node.
  if not Assigned( tmpRef.Node ) and
     not CurBof and not CurEof and
     BuffersEqual( CurRef.Node.KeyData, KeyData, KeyDataLength ) then
    tmpRef := CurRef;
  // Use algorithm to look at adjacent records first.
  if ItemCount > SeekCnt * 5 then
  begin
  // Look for direct match to records prior to the current node.
    if not Assigned( tmpRef.Node ) and
       (( CurRef.Pos + FBofRef.Pos ) > ( SeekCnt * 2 )) then
    begin
      tmpRef := CurRef;
      IterateNodeRef( tmpRef, -1, true, true, false, true );
      FindNode( KeyData, tmpRef, SeekCnt, false );
    end;
  // Look for direct match to records after the current node.
    if not Assigned( tmpRef.Node ) and
       (( CurRef.Pos + FBofRef.Pos ) < ( ItemCount - ( SeekCnt * 2 ))) then
    begin
      tmpRef := CurRef;
      IterateNodeRef( tmpRef, 1, true, true, false, true );
      FindNode( KeyData, tmpRef, SeekCnt, true );
    end;
    // Look for direct match to records before the buffer node.
    if not Assigned( tmpRef.Node ) and
       ( BufRef.Pos > BofRef.Pos ) and
       ( Abs( BufRef.Pos - CurRef.Pos ) > ( SeekCnt div 2 )) then
    begin
      if ( not Assigned( tmpRef.Node )) and
         (( BufRef.Pos + FBofRef.Pos ) > ( SeekCnt * 2 )) then
      begin
        tmpRef := BufRef;
        IterateNodeRef( tmpRef, -1, true, true, false, true );
        FindNode( KeyData, tmpRef, SeekCnt, false );
      end;
    // Look for direct match to records after the buffer node.
      if not Assigned( tmpRef.Node ) and
         (( BufRef.Pos + FBofRef.Pos ) < ( ItemCount - ( SeekCnt * 2 ))) then
      begin
        tmpRef := BufRef;
        IterateNodeRef( tmpRef, 1, true, true, false, true );
        FindNode( KeyData, tmpRef, SeekCnt, true );
      end;
    end;
    // Look for direct match to records at the end of the whole buffer.
    if not Assigned( tmpRef.Node ) then
    begin
      tmpRef := EofRef;
      IterateNodeRef( tmpRef, -1, true, true, false, true );
      FindNode( KeyData, tmpRef, SeekCnt, false );
    end;
  end;
  // Look for direct match by scanning the whole buffer.
  if not Assigned( tmpRef.Node ) and ( ItemCount > 0 ) then
  begin
    tmpRef := BofRef;
    IterateNodeRef( tmpRef, 1, true, true, false, true );
    FindNode( KeyData, tmpRef, 0, true );
  end;
  // Look for direct match by scanning the whole stored buffer.
  if not Assigned( tmpRef.Node ) and LookAtStored then
  begin
    tmpRef := InvalidNodeRef;
    tmpRef.Node := FTempList;
    FindNode( KeyData, tmpRef, 0, true );
    if Assigned( tmpRef.Node ) then
      tmpRef.Pos := StoredNodePos
    else
      tmpRef.Pos := InvalidNodePos;
  end;
  Result := Assigned( tmpRef.Node ) and ( tmpRef.Node <> @FEofNode ) and
                                        ( tmpRef.Node <> @FBofNode );
  if not Result then tmpRef := InvalidNodeRef;
  ARef := tmpRef;
end;

function TIB_NodeList.LookupBufferNode( KeyData: pointer ): boolean;
begin
  Result := LookupNode( KeyData, true, FBufRef );
  if not Result then
    FBufRef := FBofRef;
end;

function TIB_NodeList.LookupCurrentNode( KeyData: pointer ): boolean;
begin
  Result := LookupNode( KeyData, true, FCurRef );
  if not Result then
    FCurRef := FBofRef;
end;

procedure TIB_NodeList.IterateNodeRef( var ARef: TIB_NodeRef;
                                           Direction: longint;
                                           AllowDeleted,
                                           AllowFiltered,
                                           AllowFetches,
                                           AllowNilNode: boolean ); 
  procedure getVars(     ANode: PIB_Node;
                         Offset: integer;
                     var APos, ANeg, ADel, AFil: boolean );
  var
    OrigOffset: integer;
  begin
    OrigOffset := Offset;
    while ( Offset <> 0 ) and Assigned( ANode ) do
      if Offset > 0 then
      begin
        if AllowFetches and
           Assigned( FOnNeedRecord ) and
           Assigned( ANode.Next ) and
           ( rfEof in ANode.Next.RowFlags ) and
           not BufferHasEof then // Check for a truncated dataset as well.
          FOnNeedRecord( Self, true, 1 );
        ANode := ANode.Next;
        Dec( Offset );
      end
      else
      begin
        if AllowFetches and
           Assigned( FOnNeedRecord ) and
           Assigned( ANode.Prev ) and
           ( rfBof in ANode.Prev.RowFlags ) and
           not BufferHasBof then // Check for a truncated dataset as well.
          FOnNeedRecord( Self, false, 1 );
        ANode := ANode.Prev;
        Inc( Offset );
      end;
    if Assigned( ANode ) then
    begin
      APos := ( rfPos in ARef.Node.RowFlags ) or
              (( rfEof in ARef.Node.RowFlags ) and ( EofRef.Pos > 0 ));
      ANeg := ( rfNeg in ARef.Node.RowFlags ) or
              (( rfBof in ARef.Node.RowFlags ) and ( BofRef.Pos < 1 ));
      ADel := rfDeleted in ARef.Node.RowFlags;
      AFil := rfFiltered in ARef.Node.RowFlags;
    end
    else
    begin
      APos := ( OrigOffset > 0 ) and ( EofRef.Pos > 0 );
      ANeg := ( OrigOffset < 0 ) and ( BofRef.Pos < 1 );
      ADel := false;
      AFil := false;
    end;
  end;
var
  curPos, nxtPos: boolean;
  curNeg, nxtNeg: boolean;
  curDel, nxtDel: boolean;
  curFil, nxtFil: boolean;
  OrigDirection: longint;
  BackPeddling: boolean;
  nxtOfs: integer;
  lstOfs: integer;
  tmpBound: boolean;
  Done: boolean;
  curEof: boolean;
  curBof: boolean;
  CanOpt: boolean;
begin
  CanOpt := BofRef.DelCnt + EofRef.DelCnt + BofRef.FilCnt + EofRef.FilCnt = 0;
  if CanOpt and ( Direction = 0 ) then
  else
  if CanOpt and ( Direction = 1 ) and
     Assigned( ARef.Node ) and
     Assigned( ARef.Node.Next ) then
  begin
    ARef.Node := ARef.Node.Next;
    Inc( ARef.Pos );
  end
  else
  if CanOpt and ( Direction = -1 ) and
     Assigned( ARef.Node ) and
     Assigned( ARef.Node.Prev ) then
  begin
    ARef.Node := ARef.Node.Prev;
    Dec( ARef.Pos );
  end
  else
  begin
    OrigDirection := Direction;
    BackPeddling := false;
    Done := false;
    while not Done do
    begin
      if (( OrigDirection > 0 )) or
         (( OrigDirection = 0 ) and not BackPeddling ) then lstOfs := 1
                                                       else lstOfs := -1;
      getVars( ARef.Node, 0, nxtPos, nxtNeg, nxtDel, nxtFil );
      while Assigned( ARef.Node ) do
      begin
        curPos := nxtPos;
        curNeg := nxtNeg;
        curDel := nxtDel;
        curFil := nxtFil;
        curEof := rfEof in ARef.Node.RowFlags;
        curBof := rfBof in ARef.Node.RowFlags;
        if ( AllowDeleted or not curDel ) and
           ( AllowFiltered or not curFil ) then
        begin
          if Direction = 0 then
          begin
            if not( BackPeddling and curEof ) then Break;
          end
          else
            Dec( Direction, lstOfs );
        end
        else
        if curEof or curBof then
        begin
          Inc( Direction, 0 );
          Break;
        end;
        if (( OrigDirection > 0 )) or
           (( OrigDirection = 0 ) and not BackPeddling ) then nxtOfs := 1
                                                         else nxtOfs := -1;
        if nxtOfs = 1 then
          ARef.Node := ARef.Node.Next
        else
          ARef.Node := ARef.Node.Prev;
        Inc( ARef.Pos, nxtOfs );
        lstOfs := nxtOfs;
        getVars( ARef.Node, nxtOfs, nxtPos, nxtNeg, nxtDel, nxtFil );
        tmpBound := ( curNeg and nxtPos ) or ( curPos and nxtNeg );
        if tmpBound or
           (( curPos and nxtPos ) and ( lstOfs < 0 )) or
           (( curNeg and nxtNeg ) and ( lstOfs > 0 )) then
        begin
          if curDel then Dec( ARef.DelCnt );
          if curFil then
          begin
            Dec( ARef.FilCnt );
            if curDel then Dec( ARef.DblCnt );
          end;
        end;
        if tmpBound or
           (( curPos and nxtPos ) and ( lstOfs > 0 )) or
           (( curNeg and nxtNeg ) and ( lstOfs < 0 )) then
        begin
          if nxtDel then Inc( ARef.DelCnt );
          if nxtFil then
          begin
            Inc( ARef.FilCnt );
            if nxtDel then Inc( ARef.DblCnt );
          end;
        end;
      end; { while Assigned( ARef.Node ) do }
      if ( OrigDirection = 0 ) and
         ( ARef.Pos = EofRef.Pos ) and
         ( not BackPeddling ) and
         ( ItemCount > 0 ) then
        BackPeddling := true
      else
        Done := true;
    end;
  end;
  if not AllowNilNode then
  begin
    if not Assigned( ARef.Node ) then
    begin
      if ARef.Pos >= EofRef.Pos then
        ARef := EofRef
      else
      if ARef.Pos <= BofRef.Pos then
        ARef := BofRef;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_NodeList.UpdateDescriptors( NewKeyDataLength: integer );
begin
  DestroyItems;
  FreeNodeDataBuffers( @FBofNode, true, true );
  FreeNodeDataBuffers( @FEofNode, true, true );
  FreeNodeDataBuffers( @FCachedUpdateNode, true, true );
  IB_ReallocMem( FBofNode.KeyData, FKeyDataLength, NewKeyDataLength );
  IB_ReallocMem( FEofNode.KeyData, FKeyDataLength, NewKeyDataLength );
  IB_ReallocMem( FCachedUpdateNode.KeyData, FKeyDataLength, NewKeyDataLength );
  FBOFNode.RowFlags := [ rfBof, rfEof ];
  FEOFNode.RowFlags := [ rfBof, rfEof ];
  FKeyDataLength := NewKeyDataLength;
end;

procedure TIB_NodeList.AfterExecute( RefineZone: TIB_RefineZone );
begin
  FBufferHasBof := RefineZone = rzTop;
  FBufferHasEof := RefineZone = rzBot;
  if CachedInsertCount > 0 then RestoreCachedRecords;
end;

procedure TIB_NodeList.AfterFetchCursorEof( AscZone: boolean );
begin
  if AscZone then
    FBufferHasEof := true
  else
    FBufferHasBof := true;
  if FBufferHasBof and FBufferHasEof then
    DestroyNodeIndexList( FPIList );
end;

function TIB_NodeList.AfterFetchCursorRow( RowBuffer: pointer;
                                           NoDups,
                                           WasFiltered,
                                           AscZone: boolean ): PIB_Node;
var
  tmpIns: PIB_NodeIndexItem;
  WasChanged: boolean;
begin
  WasChanged := false;
  Result := nil;
  if Unidirectional then StoreAllNodes( true, true );
// If a record has been inserted it is still possible for it to show up in the
// cursor later on. Thus, this avoids having the record pop up again and be
// duplicated in the dataset.
  tmpIns := FPIList;
  while Assigned( tmpIns ) do
  begin
    if Assigned( tmpIns.Node.OldKeyData ) then
    begin
      if BuffersEqual( RowBuffer,
                       tmpIns.Node.OldKeyData,
                       KeyDataLength ) then
        Break;
    end
    else
      if BuffersEqual( RowBuffer,
                       tmpIns.Node.KeyData,
                       KeyDataLength ) then
        Break;
    tmpIns := tmpIns.Next;
  end;
  if not Assigned( tmpIns ) then
  begin
  // See if the ANode exists in the buffer and needs to be suppressed.
    if NoDups and ( ItemCount > 0 ) then
    begin
      Result := FBofNode.Next;
      while Assigned( Result.Next ) do
      begin
        if Assigned( Result.OldKeyData ) then
        begin
          if BuffersEqual( RowBuffer, Result.OldKeyData, KeyDataLength ) then
            Break;
        end
        else
          if BuffersEqual( RowBuffer, Result.KeyData, KeyDataLength ) then
            Break;
        Result := Result.Next;
      end;
      if Assigned( Result ) and ( Result <> @FEofNode ) then
      begin
        Result := nil;
        Exit;
      end;
    end;
    Result := nil;
  // See if the ANode exists already in the secondary cache.
    if Assigned( FTempList ) then
    begin
      Result := FTempList;
      while Assigned( Result ) do
      begin
        if Assigned( Result.OldKeyData ) then
        begin
          if BuffersEqual( RowBuffer, Result.OldKeyData, KeyDataLength ) then
            Break;
        end
        else
          if BuffersEqual( RowBuffer, Result.KeyData, KeyDataLength ) then
            Break;
        Result := Result.Next;
      end;
    // MAKE SURE THE TEMPLIST POINTER STAYS INTACT IF THE FIRST ANode IS SWIPED.
      if Result = FTempList then
        FTempList := FTempList.Next;
    // MAKE SURE NOT TO CORRUPT THE BUFFER POINTER!
      if Assigned( Result ) and ( BufRef.Node = Result ) then
        WasChanged := true;
    end;
    if Assigned( Result ) then
    begin
    // Clean up pointers since it was in the Temp list.
      with Result^ do
      begin
        if Prev <> nil then
          Prev.Next := Next;
        if Next <> nil then
          Next.Prev := Prev;
        if rfSelected in RowFlags then
          FCheckSelected := true;
      end;
    end
    else
    begin
      Result := GetNewNode;
      with Result^ do
        Move( RowBuffer^, KeyData^, KeyDataLength );
    end;
    if AscZone then
    begin
      Result.Prev := FEofNode.Prev;
      Result.Next := @FEofNode;
      FEofNode.Prev.Next := Result;
      FEofNode.Prev := Result;
      Result.RowFlags := Result.RowFlags + [ rfPos ];
      Inc( FEofRef.Pos );
      if WasFiltered then
      begin
        Inc( FEofRef.FilCnt );
        Result.RowFlags := Result.RowFlags + [ rfFiltered ];
      end;
      if rfDeleted in Result.RowFlags then
      begin
        Inc( FEofRef.DelCnt );
        if WasFiltered then
          Inc( FEofRef.DblCnt );
      end;
      if EofRef.Pos = 1 then
      begin
        FMidRef := EofRef;
        FMidRef.Pos := 0;
        FMidRef.Node := Result;
      end
      else
      if EofRef.Node = MidRef.Node then
        FMidRef.Pos := EofRef.Pos;

      if CurRef.Node = EofRef.Node then
      begin
        FCurRef := EofRef;
        IterateNodeRef( FCurRef, -1, true, true, false, true );
      end;
      if BufRef.Node = EofRef.Node then
      begin
        FBufRef := EofRef;
        IterateNodeRef( FBufRef, -1, true, true, false, true );
      end;
    end
    else
    begin
      Result.Prev := @FBofNode;
      Result.Next := FBofNode.Next;
      FBofNode.Next.Prev := Result;
      FBofNode.Next := Result;
      Result.RowFlags := Result.RowFlags + [ rfNeg ];
      Dec( FBofRef.Pos );
      if WasFiltered then
      begin
        Inc( FBofRef.FilCnt );
        Result.RowFlags := Result.RowFlags + [ rfFiltered ];
      end;
      if rfDeleted in Result.RowFlags then
      begin
        Inc( FBofRef.DelCnt );
        if WasFiltered then
          Inc( FBofRef.DblCnt );
      end;
      // Initialize the middle reference pointer to the zero node.
      // Pick up the counts from the BofRef.
      // This is used to allow inserts and deletes to operate normally when
      // in the negative series of row numbers. This is because nodes from
      // the negative side are pushed into and out of the positive side.
      // I keep this here so that it will monitor the counts and adjust all
      // the other references accordingly.
      if BofRef.Pos = -1 then
      begin
        FMidRef := BofRef;
        FMidRef.Pos := 0;
        FMidRef.Node := MidRef.Node.Next;
      end
      else
      if BofRef.Node = MidRef.Node then
        FMidRef.Pos := BofRef.Pos;
      if CurRef.Node = BofRef.Node then
      begin
        FCurRef := BofRef;
        IterateNodeRef( FCurRef, 1, true, true, false, true );
      end;
      if BufRef.Node = BofRef.Node then
      begin
        FBufRef := BofRef;
        IterateNodeRef( FBufRef, 1, true, true, false, true );
      end;
    end;
    with FBofNode do RowFlags := RowFlags - [ rfEof ];
    with FEofNode do RowFlags := RowFlags - [ rfBof ];
    if AscZone then
    begin
      if WasChanged then
      begin
        FBufRef := EofRef;
        IterateNodeRef( FBufRef, -1, true, true, false, true );
      end;
    end
    else
    begin
      if WasChanged then
      begin
        FBufRef := BofRef;
        IterateNodeRef( FBufRef, 1, true, true, false, true );
      end;
    end;
  end
  else
  begin
  // Move this ANode into it's correct order?
{
 Seems a little dangerous. I'd have to somehow resync the TIB_BDataset buffers.
    with tmpIns^ do begin
      ANode.Prev.Next := ANode.Next;
      ANode.Next.Prev := ANode.Prev;
      ANode.Prev := FEofNode.Prev;
      ANode.Next := @FEofNode;
      FEofNode.Prev.Next := ANode;
      FEofNode.Prev := ANode;
    end;
}    
  end;
  if Assigned( Result ) and Unidirectional then
    Inc( FUniRowAdjust );
end;

procedure TIB_NodeList.RemoveRecords( StoreRecords,
                                      IsFetchWholeRows,
                                      KeyLinksExist: boolean );
var
  tmpNode: PIB_Node;
begin
  DestroyNodeIndexList( FPIList );
  if StoreRecords or Assigned( cuList ) or FCheckSelected then
    StoreAllNodes( IsFetchWholeRows, KeyLinksExist )
  else
  begin
    DestroyList( FTempList );
    if ItemCount > 0 then
    begin
      tmpNode := FBofNode.Next;
      while Assigned( tmpNode.Next ) do
      begin
        FreeNodeDataBuffers( tmpNode, true, true );
        tmpNode := tmpNode.Next;
      end;
      if Assigned( FFreeList ) then
        FFreeList.Prev := FEofNode.Prev;
      FEofNode.Prev.Next := FFreeList;
      FFreeList := FBofNode.Next;
      if Assigned( FFreeList ) then
        FFreeList.Prev := nil;
      Inc( FFreeCount, ItemCount );
    end;
    Initialize( true );
  end;
end;

procedure TIB_NodeList.HackBufferPos( NewPos,
                                      NewDelCnt,
                                      NewFilCnt,
                                      NewDblCnt: longint;
                                      NewNode: PIB_Node );
begin
  FBufRef.Node := NewNode;
  FBufRef.Pos := NewPos;
  FBufRef.DelCnt := NewDelCnt;
  FBufRef.FilCnt := NewFilCnt;
  FBufRef.DblCnt := NewDblCnt;
end;

procedure TIB_NodeList.InvalidateNodes;
var
  AValue: PIB_Node;
begin
  AValue := FTempList;
  while Assigned( AValue ) do
  begin
    InvalidateNode( AValue );
    AValue := AValue.Next;
  end;
  AValue := FBofNode.Next;
  while Assigned( AValue.Next ) do
  begin
    InvalidateNode( AValue );
    AValue := AValue.Next;
  end;
end;

function TIB_NodeList.InvalidateBookmark( const ABookmark: string;
                                          var ARef: TIB_NodeRef ): boolean;
begin
  Result := false;
  if ABookmark <> '' then
  begin
    HexTextToBinary( ABookmark, BofRef.Node.KeyData, KeyDataLength );
    if LookupNode( BofRef.Node.KeyData, true, ARef ) then
    begin
      InvalidateNode( ARef.Node );
      Result := true;
    end;
  end;
end;

procedure TIB_NodeList.InvalidateNode( ANode: PIB_Node );
begin
  if Assigned( ANode ) then
    if rfInserted in ANode.RowFlags then
    // Nothing came from server so nothing to invalidate.
    else
    if rfEdited in ANode.RowFlags then
    begin
      with ANode^ do
      // Don't double invalidate.
        if RecordLen > 0 then
        begin
        // Don't swap key buffers here.
        // Preserve new values.
          FreeMem( OldRecData );
          OldRecData := RecordData;
          OldRecLen := - Abs( RecordLen );
          RecordLen := 0;
          RecordData := nil;
        end;
    end
    else
      FreeNodeDataBuffers( ANode, false, false );
end;

function TIB_NodeList.SetNodeSelected( ANode: PIB_Node;
                                       AValue: boolean ): boolean;
begin
  Result := false;
  with ANode^ do
  begin
    if AValue then
    begin
      if not ( rfSelected in RowFlags ) then
      begin
        FCheckSelected := true;
        Result := true;
        RowFlags := RowFlags + [ rfSelected ];
      end;
    end
    else
    begin
      if ( rfSelected in RowFlags ) then
      begin
        Result := true;
        RowFlags := RowFlags - [ rfSelected ];
      end;
    end;
  end;
end;

procedure TIB_NodeList.ToggleSelected;
var
  AValue: PIB_Node;
begin
  FCheckSelected := true;
  AValue := FBofNode.Next;
  while Assigned( AValue.Next ) do
  begin
    with AValue^ do
    begin
      if rfSelected in RowFlags then
        RowFlags := RowFlags - [ rfSelected ]
      else
        RowFlags := RowFlags + [ rfSelected ];
    end;
    AValue := AValue.Next;
  end;
  FDefaultSelectedState := not FDefaultSelectedState;
end;

procedure TIB_NodeList.SelectAll( State: boolean );
var
  AValue: PIB_Node;
begin
  FCheckSelected := true;
  AValue := FBofNode.Next;
  while Assigned( AValue.Next ) do
  begin
    with AValue^ do
    begin
      if State then
        RowFlags := RowFlags + [ rfSelected ]
      else
        RowFlags := RowFlags - [ rfSelected ];
    end;
    AValue := AValue.Next;
  end;
  FDefaultSelectedState := State;
end;

procedure TIB_NodeList.SelectRange( StartRow, EndRow: longint;
                                    State, Exclusive: boolean );
var
  AValue: PIB_Node;
  tmpPos: longint;
begin
  FCheckSelected := true;
{!!! Consider deleted and filtered nodes.}
  if StartRow > EndRow then
  begin
    tmpPos := EndRow;
    EndRow := StartRow;
    StartRow := tmpPos;
  end;
  tmpPos := 1;
  AValue := FBofNode.Next;
  while Assigned( AValue.Next ) do
  begin
    if ( tmpPos < StartRow ) or ( tmpPos > EndRow ) then
    begin
      if Exclusive then
      begin
        with AValue^ do
          if State then
            RowFlags := RowFlags - [ rfSelected ]
          else
            RowFlags := RowFlags + [ rfSelected ];
      end;
    end
    else
      with AValue^ do
        if State then
          RowFlags := RowFlags + [ rfSelected ]
        else
          RowFlags := RowFlags - [ rfSelected ];
    AValue := AValue.Next;
    Inc( tmpPos );    
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_NodeList.PostUpdate( ANode: PIB_Node; ARowFlag: TIB_RowFlags );
  procedure ShiftBuffers;
  begin
    if not Assigned( ANode.OldRecData ) then
    begin
      ANode.OldRecLen := ANode.RecordLen;
      ANode.OldRecData := ANode.RecordData;
      ANode.RecordLen := 0;
      ANode.RecordData := nil;
    end;
  end;
begin
  case ARowFlag of
    rfEdited:
    begin
      if rfInserted in ANode.RowFlags then
      begin

      end
      else
      begin
        if not ( rfEdited in ANode.RowFlags ) then
        begin
          AddToNodeIndexList( cuList, ANode );
          ANode.RowFlags := ANode.RowFlags + [ rfEdited ];
          Inc( cuEdtCnt );
        end;
        ShiftBuffers;
      end;
    end;
    rfInserted:
    begin
      if not ( rfInserted in ANode.RowFlags ) then
      begin
        AddToNodeIndexList( cuList, ANode );
        ANode.RowFlags := ANode.RowFlags + [ rfInserted ];
        Inc( cuInsCnt );
      end;
      ShiftBuffers;
    end;
    rfDeleted:
    begin
      if ( rfInserted in ANode.RowFlags ) then
        raise Exception.Create( 'This cannot be handled here' )
      else
      if not ( rfDeleted in ANode.RowFlags ) then
      begin
        if ( rfEdited in ANode.RowFlags ) then
        begin
          ANode.RowFlags := ANode.RowFlags - [ rfEdited ];
          if ( [ rfApplied, rfSkipped ] * ANode.RowFlags = [] ) then
            Dec( cuEdtCnt );
        end
        else
          AddToNodeIndexList( cuList, ANode );
        ANode.RowFlags := ANode.RowFlags - [ rfApplied, rfSkipped ];
        ToggleDeletedFlag( ANode );
      end;
    end;
  end;
end;

procedure TIB_NodeList.ProcessUpdates( AProcess: TIB_CachedUpdatesProcess );
var
  ANode: PIB_Node;
  oldNodeIndex: PIB_NodeIndexItem;
  tmpNodeIndex: PIB_NodeIndexItem;
  curNodeIndex: PIB_NodeIndexItem;

  procedure SysApplyUpdate;
  var
    UpdateKind: TIB_UpdateKind;
    UpdateAction: TIB_UpdateAction;
    procedure AdjCounts;
    begin
      if rfEdited in ANode.RowFlags then
        Dec( cuEdtCnt )
      else
      if rfInserted in ANode.RowFlags then
        Dec( cuInsCnt )
      else
      if rfDeleted in ANode.RowFlags then
        Dec( cuDelCnt )
      else
        raise Exception.Create( 'This shouldn''t happen 4' );
    end;
  begin
    UpdateAction := uacApplied;
    if rfEdited in ANode.RowFlags then UpdateKind := ukiModify else
    if rfInserted in ANode.RowFlags then UpdateKind := ukiInsert else
    if rfDeleted in ANode.RowFlags then UpdateKind := ukiDelete else
      raise Exception.Create( 'This shouldn''t happen 4' );
    if Assigned( OnApplyUpdate ) then
      OnApplyUpdate( Self, ANode, UpdateKind, UpdateAction )
    else
      raise Exception.Create( 'Unable to process updates' );
    if UpdateAction = uacApplied then
    begin
      ANode.RowFlags := ANode.RowFlags + [ rfApplied ];
      AdjCounts;
      if Assigned( CurRef.Node.OldKeyData ) then
      begin
        FreeMem( CurRef.Node.OldKeyData );
        CurRef.Node.OldKeyData := nil;
      end;
    end
    else
    if UpdateAction = uacSkip then
    begin
      ANode.RowFlags := ANode.RowFlags + [ rfSkipped ];
      AdjCounts;
    end;
  end;

var
  oldRowNum: longint;
begin
  if FProcessingUpdates then Exit;
  FProcessingUpdates := true;
  try
    oldRowNum := CurRowNum;
    FCachedUpdateRef.Pos := StoredNodePos;
    FCachedUpdateRef.Node := nil;
    curNodeIndex := cuList;
    oldNodeIndex := nil;
    while Assigned( curNodeIndex ) do
    begin
      if cuList = curNodeIndex then
        oldNodeIndex := nil
      else
      if not Assigned( oldNodeIndex ) then
        oldNodeIndex := cuList
      else
      if oldNodeIndex.Next <> curNodeIndex then
        oldNodeIndex := oldNodeIndex.Next;
      tmpNodeIndex := curNodeIndex.Next;

      ANode := curNodeIndex.Node;
      Inc( FCachedUpdateRef.Pos );
      FCachedUpdateRef.Node := ANode;
      
      case AProcess of
      cupApply:
        if ANode.RowFlags * [ rfApplied, rfSkipped ] = [] then
          SysApplyUpdate;
      cupCancel:
        if ( [ rfApplied, rfSkipped ] * ANode.RowFlags = [] ) then
          if rfInserted in ANode.RowFlags then
            DeleteNode( ANode )
          else
          if RevertNode( ANode, false ) then
          begin
            if Assigned( OnCancelUpdate ) then
              OnCancelUpdate( Self, ANode );
            DeleteNodeIndex( ANode, curNodeIndex, oldNodeIndex );
          end;
      cupCommit:
        begin
          if ( rfApplied in ANode.RowFlags ) then
          begin
            if rfDeleted in ANode.RowFlags then
              DeleteNode( ANode )
            else
              DeleteNodeIndex( ANode, curNodeIndex, oldNodeIndex );
          end
          else
          if ( rfSkipped in ANode.RowFlags ) then
          begin
            ANode.RowFlags := ANode.RowFlags - [ rfSkipped ];
            AdjCuCounts( ANode, 1 );
          end;
        end;
      cupRollback:
        begin
          if ( [ rfApplied, rfSkipped ] * ANode.RowFlags <> [] ) then
          begin
            ANode.RowFlags := ANode.RowFlags - [ rfApplied, rfSkipped ];
            AdjCuCounts( ANode, 1 );
          end;
        end;
      end;
      curNodeIndex := tmpNodeIndex;
    end;
  finally
    FProcessingUpdates := false;
  end;
  IterateNodeRef( FCurRef, 0, not FFilterDel, not FFiltered, true, false );
  AdjRowNum( oldRowNum - CurRowNum );
end;

function TIB_NodeList.RevertNode( ANode: PIB_Node;
                                  RemoveFromCUList: boolean ): boolean;
begin
  Result := false;
  if ( rfInserted in ANode.RowFlags ) then
    raise Exception.Create( 'Unsupported here' );
  if ( rfEdited in ANode.RowFlags ) then
  begin
    if RemoveFromCUList then
      RemoveFromNodeIndexList( cuList, ANode )
    else
      Result := true;
    ANode.RowFlags := ANode.RowFlags - [ rfEdited ];
    Dec( cuEdtCnt );
    if Assigned( ANode.OldRecData ) then
    begin
      FreeMem( ANode.RecordData );
      ANode.RecordLen := Abs( ANode.OldRecLen );
      ANode.RecordData := ANode.OldRecData;
      ANode.OldRecLen := 0;
      ANode.OldRecData := nil;
      if Assigned( ANode.OldKeyData ) then
      begin
        FreeMem( ANode.OldKeyData );
        ANode.OldKeyData := nil;
      end;
    end;
  end;
  if ( rfDeleted in ANode.RowFlags ) then
  begin
    if Assigned( ANode.OldRecData ) then
    begin
      ANode.RowFlags := ANode.RowFlags + [ rfEdited ];
      Inc( cuEdtCnt );
    end
    else
    begin
      if RemoveFromCUList then
        RemoveFromNodeIndexList( cuList, ANode )
      else
        Result := true;
    end;
    ToggleDeletedFlag( ANode );
  end;
end;

procedure TIB_NodeList.SetFiltered( AValue: boolean );
var
  oldRowNum: longint;
begin
  oldRowNum := CurRowNum;
  FFiltered := AValue;
  IterateNodeRef( FCurRef, 0, not FFilterDel, not FFiltered, true, false );
  AdjRowNum( oldRowNum - CurRowNum );
end;

procedure TIB_NodeList.SetFilterOptions( AValue: TIB_FilterOptions );
begin
  if FFilterOptions <> AValue then
  begin
    FFilterOptions := AValue;
    RefreshFilteredRows;
  end;
end;

procedure TIB_NodeList.SetFilterDel( AValue: boolean );
var
  oldRowNum: longint;
begin
  oldRowNum := CurRowNum;
  FFilterDel := AValue;
  IterateNodeRef( FCurRef, 0, not FFilterDel, not FFiltered, true, false );
  AdjRowNum( oldRowNum - CurRowNum );
end;

procedure TIB_NodeList.ToggleDeletedFlag( ANode: PIB_Node );
var
  tmpInc: integer;
  tmpFil: boolean;
  tmpPos: boolean;
  tmpNeg: boolean;
  APos: longint;
  procedure AdjustRef( var ARef: TIB_NodeRef );
  begin
    if ( tmpPos and ( ARef.Pos >= APos )) or
       ( tmpNeg and ( ARef.Pos <= APos )) then
    begin
                     Inc( ARef.DelCnt, tmpInc );
      if tmpFil then Inc( ARef.DblCnt, tmpInc );
    end;
  end;
var
  oldRowNum: longint;
begin
  oldRowNum := BofRowNum;
  if rfDeleted in ANode.RowFlags then
  begin
    tmpInc := -1;
    ANode.RowFlags := ANode.RowFlags - [ rfDeleted ];
  end
  else
  begin
    tmpInc := 1;
    ANode.RowFlags := ANode.RowFlags + [ rfDeleted ];
  end;
  Inc( cuDelCnt, tmpInc );
  tmpFil := rfFiltered in ANode.RowFlags;
  tmpPos := rfPos in ANode.RowFlags;
  tmpNeg := rfNeg in ANode.RowFlags;
  if tmpPos or tmpNeg then
  begin
    APos := PosOfNode( ANode );
    AdjustRef( FBofRef );
    AdjustRef( FEofRef );
    AdjustRef( FBufRef );
    AdjustRef( FCurRef );
    AdjustRef( FMidRef );
  end;
  AdjRowNum( oldRowNum - BofRowNum );
end;

procedure TIB_NodeList.ToggleFilteredFlag( ANode: PIB_Node );
var
  tmpInc: integer;
  tmpDel: boolean;
  tmpPos: boolean;
  tmpNeg: boolean;
  APos: longint;
  procedure AdjustRef( var ARef: TIB_NodeRef );
  begin
    if ( tmpPos and ( ARef.Pos >= APos )) or
       ( tmpNeg and ( ARef.Pos <= APos )) then
    begin
                     Inc( ARef.FilCnt, tmpInc );
      if tmpDel then Inc( ARef.DblCnt, tmpInc );
    end;
  end;
var
  oldRowNum: longint;
begin
  oldRowNum := BofRowNum;
  if rfFiltered in ANode.RowFlags then
  begin
    tmpInc := -1;
    ANode.RowFlags := ANode.RowFlags - [ rfFiltered ];
  end
  else
  begin
    tmpInc := 1;
    ANode.RowFlags := ANode.RowFlags + [ rfFiltered ];
  end;
  tmpDel := rfDeleted in ANode.RowFlags;
  tmpPos := rfPos in ANode.RowFlags;
  tmpNeg := rfNeg in ANode.RowFlags;
  if tmpPos or tmpNeg then
  begin
    APos := PosOfNode( ANode );
    AdjustRef( FBofRef );
    AdjustRef( FEofRef );
    AdjustRef( FBufRef );
    AdjustRef( FCurRef );
    AdjustRef( FMidRef );
  end;
  AdjRowNum( oldRowNum - BofRowNum );
end;

function TIB_NodeList.AdjCurrentFilFlag( NewFiltered: boolean ): boolean;
begin
  Result := false;
  if rfFiltered in FCurRef.Node.RowFlags <> NewFiltered then
  begin
    ToggleFilteredFlag( CurRef.Node );
    Result := Filtered and NewFiltered;
  end;
end;

function TIB_NodeList.GetRowNum( const ARef: TIB_NodeRef ): longint;
begin
  if ( not FilterDel or ( BofRef.DelCnt + EofRef.DelCnt = 0 )) and
     ( not Filtered  or ( BofRef.FilCnt + EofRef.FilCnt = 0 )) then
    Result := ARef.Pos
  else
  if not Assigned( ARef.Node ) then
    Result := BofRef.Pos
  else
  if ARef.Pos = InvalidNodePos then
    Result := InvalidNodePos
  else
  if ARef.Pos = StoredNodePos then
    Result := StoredNodePos
  else
  if ARef.Pos < BofRef.Pos then
    Result := InvalidNodePos
  else
  if ARef.Pos > EofRef.Pos then
    Result := InvalidNodePos
  else
  begin
  // Start with the BofRowNum
    Result := BofRef.Pos;
    if FilterDel then
      Inc( Result, FBofRef.DelCnt );
    if Filtered then
    begin
      Inc( Result, FBofRef.FilCnt );
      if FilterDel then
        Dec( Result, FBofRef.DblCnt );
    end;
    if ( FilterDel and ( rfDeleted in ARef.Node.RowFlags )) then
    else
    if ( Filtered and ( rfFiltered in ARef.Node.RowFlags )) then
    else
      Result := Result + GetRowsBetween( BofRef, ARef );
    Inc( Result, FRowNumAdjust );
  end;
  if FUniRowAdjust >= 0 then
    Inc( Result, FUniRowAdjust );
end;

function TIB_NodeList.GetRowCount: longint;
begin
  Result := ItemCount;
  if FilterDel then
    Dec( Result, FEofRef.DelCnt + FBofRef.DelCnt );
  if Filtered then
  begin
    Dec( Result, FEofRef.FilCnt + FBofRef.FilCnt );
    if FilterDel then
      Inc( Result, FEofRef.DblCnt + FBofRef.DblCnt );
  end;
end;

function TIB_NodeList.GetBofRowNum: longint;
begin Result := GetRowNum( BofRef ); end;
function TIB_NodeList.GetEofRowNum;
begin Result := GetRowNum( EofRef ); end;
function TIB_NodeList.GetBufRowNum: longint;
begin Result := GetRowNum( BufRef ); end;
function TIB_NodeList.GetCurRowNum: longint;
begin Result := GetRowNum( CurRef ); end;
function TIB_NodeList.GetItemCount: longint;
begin
  Result := FEofRef.Pos - FBofRef.Pos - 1;
end;

const
  TraceSepStr = '-------------------------------------------------';
  
procedure TIB_NodeList.TraceNodeRef( const ARef: TIB_NodeRef;
                                           AStrings: TStrings );
  procedure CompareNodeRef( const CompRef: TIB_NodeRef; const AName: string );
  begin
    with AStrings do
    begin
      if CompRef.Node = ARef.Node then
      begin
        if CompRef.Pos <> ARef.Pos then
        begin
          Add( '>>>[ ' + AName +' ]<<<: Pos: ' + IntToStr( CompRef.Pos ));
          Beep;
        end;
        if CompRef.DelCnt <> ARef.DelCnt then
        begin
          Add( '>>>[ ' + AName +' ]<<<: DelCnt: ' + IntToStr( CompRef.DelCnt ));
          Beep;
        end;
        if CompRef.FilCnt <> ARef.FilCnt then
        begin
          Add( '>>>[ ' + AName +' ]<<<: FilCnt: ' + IntToStr( CompRef.FilCnt ));
          Beep;
        end;
        if CompRef.DblCnt <> ARef.DblCnt then
        begin
          Add( '>>>[ ' + AName +' ]<<<: DblCnt: ' + IntToStr( CompRef.DblCnt ));
          Beep;
        end;
      end;
    end;
  end;
begin
  AStrings.Add( 'Pos: ' + IntToStr( ARef.Pos ) +
                ' Del: ' + IntToStr( ARef.DelCnt ) +
                ' Fil: ' + IntToStr( ARef.FilCnt ) +
                ' Dbl: ' + IntToStr( ARef.DblCnt ) +
                ' Row: ' + IntToStr( GetRowNum( ARef )));
  CompareNodeRef( BofRef, 'Bof' );
  CompareNodeRef( EofRef, 'Eof' );
  CompareNodeRef( CurRef, 'Cur' );
  CompareNodeRef( BufRef, 'Buf' );
  CompareNodeRef( MidRef, 'Mid' );
  TraceNode( ARef.Node, AStrings );
end;

procedure TIB_NodeList.TraceNode( ANode: PIB_Node; AStrings: TStrings );
var
//  tmpInt: integer;
//  tmpQuad: isc_quad;
  tmpBlobNode: PIB_BlobNode;
  str: string;
begin
  if not Assigned( ANode ) then
    AStrings.Add( 'Node is unassigned' )
  else
  with ANode^ do
  begin
{
    if Assigned( ANode.Prev ) then
      AStrings.Add( 'Prev Node: ' + IntToHex( Integer( ANode.Prev ), 8 ) )
    else
      AStrings.Add( 'Prev Node: NIL' );
}
    AStrings.Add( 'Node Address: ' + IntToHex( Integer( ANode ), 8 ) );
{}
    if Assigned( KeyData ) then
      AStrings.Add( 'Key Data ' + BinaryToHexText( KeyData,
                                                   KeyDataLength ));
{}
{}
    if Assigned( RecordData ) then
      AStrings.Add( 'Record Data ' + BinaryToHexText( RecordData,
                                                      RecordLen ));
{}

{
    if Assigned( ANode.Next ) then
      AStrings.Add( 'Next Node: ' +
                    IntToHex( Integer( ANode.Next ), 8 ) )
    else
      AStrings.Add( 'Next Node: NIL' );
}

    str := '';

    if rfBof in RowFlags then str := str + '---[ Bof ]---';
    if rfEof in RowFlags then str := str + '---[ Eof ]---';
    if rfPos in RowFlags then str := str + '---[ Pos ]---';
    if rfNeg in RowFlags then str := str + '---[ Neg ]---';
    if ANode = CurRef.Node then str := str + '---[ Cur ]---';
    if ANode = BufRef.Node then str := str + '---[ Buf ]---';
    if ANode = MidRef.Node then str := str + '---[ Mid ]---';
    if rfEdited in RowFlags then str := str + '---[ Edited ]---';
    if rfInserted in RowFlags then str := str + '---[ Inserted ]---';
    if rfDeleted in RowFlags then str := str + '---[ Deleted ]---';
    if rfApplied in RowFlags then str := str + '---[ Applied ]---';
    if rfSkipped in RowFlags then str := str + '---[ Skipped ]---';
    if rfSelected in RowFlags then str := str + '---[ Selected ]---';
    if rfFiltered in RowFlags then str := str + '---[ Filtered ]---';
    if str <> '' then
      AStrings.Add( str );
    if Assigned( BlobHead ) then
    begin
      tmpBlobNode := BlobHead;
      while Assigned( tmpBlobNode ) do
      begin
        AStrings.Add( '  Blob Node: ' +
                      isc_quad_string( tmpBlobNode.BlobID ) +
                      '  FieldNo: ' + intToStr( tmpBlobNode.BlobFieldNo ));// +
//                      '  ticks: ' + IntToStr( tmpBlobNode.ticks ));
        tmpBlobNode := tmpBlobNode.Next;
      end;
    end;
//    else
//      AStrings.Add( '  No Blob Nodes' );//
    AStrings.Add( TraceSepStr );
  end;
end;

procedure TIB_NodeList.TraceBufferNodes(       Ascending,
                                               AllowDeleted,
                                               AllowFiltered: boolean;
                                         const AStrings: TStrings );
var
  tmpRef: TIB_NodeRef;
  tmpNode: PIB_Node;
//  tmpIndexItem: PIB_NodeIndexItem;
begin
  if not Assigned( AStrings ) then Exit;
  with AStrings do
  try
    BeginUpdate;
    Clear;

    Add( 'Starting trace of nodes:' );
    AStrings.Add( TraceSepStr );
    if Ascending then
    begin
      tmpRef := BofRef;
      while Assigned( tmpRef.Node ) do
      begin
        TraceNodeRef( tmpRef, AStrings );
        IterateNodeRef( tmpRef, 1, AllowDeleted, AllowFiltered, false, true );
      end;
    end
    else
    begin
      tmpRef := EofRef;
      while Assigned( tmpRef.Node ) do
      begin
        TraceNodeRef( tmpRef, AStrings );
        IterateNodeRef( tmpRef, -1, AllowDeleted, AllowFiltered, false, true );
      end;
    end;
    Add( 'Ending trace of nodes:' );
    AStrings.Add( TraceSepStr );

    Add( 'Current node:' );
    TraceNodeRef( CurRef, AStrings );
    AStrings.Add( TraceSepStr );
    Add( 'Buffer node:' );
    TraceNodeRef( BufRef, AStrings );
    AStrings.Add( TraceSepStr );
    Add( 'Middle node:' );
    TraceNodeRef( MidRef, AStrings );
    AStrings.Add( TraceSepStr );
    if Ascending then
    begin
      Add( 'Eof node:' );
      TraceNodeRef( EofRef, AStrings );
    end
    else
    begin
      Add( 'Bof node:' );
      TraceNodeRef( BofRef, AStrings );
    end;
    AStrings.Add( TraceSepStr );
    Add( 'Starting trace of nodelist properties:' );
    Add( 'cuEdtCnt = ' + IntToStr( cuEdtCnt ));
    Add( 'cuInsCnt = ' + IntToStr( cuInsCnt ));
    Add( 'cuDelCnt = ' + IntToStr( cuDelCnt ));
    Add( 'FreeCount = ' + IntToStr( FreeCount ));
    AStrings.Add( TraceSepStr );
    if Assigned( FTempList ) then
    begin
      Add( 'Starting trace of stored nodes:' );
      AStrings.Add( TraceSepStr );
      tmpNode := FTempList;
      while Assigned( tmpNode ) do
      begin
        TraceNode( tmpNode, AStrings );
        tmpNode := tmpNode.Next;
      end;
      Add( 'Ending trace of stored nodes:' );
      AStrings.Add( TraceSepStr );
    end;
{
    if Assigned( cuList ) then
    begin
      Add( 'Starting trace of cached update nodes:' );
      AStrings.Add( TraceSepStr );
      tmpIndexItem := cuList;
      while Assigned( tmpIndexItem ) do
      begin
        TraceNode( tmpIndexItem.Node, AStrings );
        tmpIndexItem := tmpIndexItem.Next;
      end;
      Add( 'Ending trace of cached update nodes:' );
      AStrings.Add( TraceSepStr );
    end;
}
{}
    Add( 'Starting trace of freed nodes:' );
    AStrings.Add( TraceSepStr );
    tmpNode := FFreeList;
    while Assigned( tmpNode ) do
    begin
      TraceNode( tmpNode, AStrings );
      tmpNode := tmpNode.Next;
    end;
    Add( 'Ending trace of freed nodes:' );
    AStrings.Add( TraceSepStr );
{}
  finally
    EndUpdate;
  end;
end;

procedure TIB_NodeList.DeleteNodeIndex(     ANode: PIB_Node;
                                        var curNodeIndex,
                                            oldNodeIndex: PIB_NodeIndexItem );
begin
  if rfDeleted in ANode.RowFlags then
    raise Exception.Create( 'This shouldn''t happen 1' );

  if ( [ rfApplied, rfSkipped ] * ANode.RowFlags = [] ) then
    AdjCuCounts( ANode, -1 );

  ANode.RowFlags := ANode.RowFlags - [ rfInserted,
                                       rfEdited,
                                       rfDeleted,
                                       rfApplied,
                                       rfSkipped ];
  if Assigned( ANode.OldRecData ) then
  begin
    FreeMem( ANode.OldRecData );
    ANode.OldRecData := nil;
    ANode.OldRecLen := 0;
  end;
  if cuList = curNodeIndex then
    cuList := curNodeIndex.Next
  else
  if Assigned( oldNodeIndex ) and Assigned( oldNodeIndex.Next ) then
    if oldNodeIndex.Next = curNodeIndex then
      oldNodeIndex.Next := curNodeIndex.Next
    else
      raise Exception.Create( 'This shouldn''t happen 2' )
  else
    raise Exception.Create( 'This shouldn''t happen 3' );
  FreeMem( curNodeIndex );
  curNodeIndex := nil;
end;

procedure TIB_NodeList.AdjCuCounts( ANode: PIB_Node; AIncrement: integer );
begin
  if rfEdited in ANode.RowFlags then
    Inc( cuEdtCnt, AIncrement )
  else
  if rfInserted in ANode.RowFlags then
    Dec( cuInsCnt, AIncrement )
  else
  if rfDeleted in ANode.RowFlags then
    Dec( cuDelCnt, AIncrement );
end;

procedure TIB_NodeList.RestoreCachedRecords;
var
  tmpNode: PIB_Node;
  NextNode: PIB_Node;
  WasChanged: boolean;
  RecBelongs: boolean;
begin
  WasChanged := false;
  if Assigned( OnGetRestoreInsertedRecord ) and Assigned( FTempList ) then
  begin
    tmpNode := FTempList;
    while Assigned( tmpNode ) do
    begin
      NextNode := tmpNode.Next;
      if rfSelected in tmpNode.RowFlags then
        FCheckSelected := true;
      // Move the node into the Items list.
      if rfInserted in tmpNode.RowFlags then
      begin
        WasChanged := true;
        RecBelongs := false;
        // Check to see if it matches the master if master-detail. !!
        OnGetRestoreInsertedRecord( Self, tmpNode, RecBelongs );
        if RecBelongs then
        begin
         // Keep TempList pointer intact if the first Node is swiped.
          if tmpNode = FTempList then
            FTempList := FTempList.Next;
          with tmpNode^ do
          begin
            if Prev <> nil then Prev.Next := Next;
            if Next <> nil then Next.Prev := Prev;
          end;
          tmpNode.RowFlags := tmpNode.RowFlags + [ rfPos ];
          Inc( FEofRef.Pos );
          tmpNode.Prev := FEofNode.Prev;
          tmpNode.Next := @FEofNode;
          FEofNode.Prev.Next := tmpNode;
          FEofNode.Prev := tmpNode;
          tmpNode.RowFlags := tmpNode.RowFlags + [ rfUnsorted ];
          with FBofNode do RowFlags := RowFlags - [ rfEof ];
          with FEofNode do RowFlags := RowFlags - [ rfBof ];
         end;
      end;
      tmpNode := NextNode;
    end;
    if WasChanged then
    begin
      tmpNode := BufRef.Node;
      FBufRef.Node := @FBofNode;
      FBufRef.Pos := InvalidNodePos;
      FBufRef.DelCnt := 0;
      FBufRef.FilCnt := 0;
      FBufRef.DblCnt := 0;
      FBufRef.Pos := PositionOfNode( tmpNode,
                                     FBufRef.DelCnt,
                                     FBufRef.FilCnt,
                                     FBufRef.DblCnt );
    end;
  end;
end;

procedure TIB_NodeList.RefreshFilteredRows;
var
  ii: integer;
  tmpPos: longint;
  oldFiltered: boolean;
  oldFilt, newFilt: boolean;
  oldRowNum: longint;
begin
  oldRowNum := CurRowNum;
  tmpPos := BufRef.Pos;
  oldFiltered := Filtered;
  FFiltered := false;
  try
    OnBeginBusy( Self );
    try
      ii := BofRef.Pos + 1;
      while ii < EofRef.Pos do
      begin
        BufferPos := ii;
        oldFilt := rfFiltered in BufRef.Node.RowFlags;
        newFilt := false;
        FOnGetRecordIsFiltered( Self, BufRef.Node, newFilt );
        if oldFilt <> newFilt then
          ToggleFilteredFlag( BufRef.Node );
        Inc( ii );
      end;
    finally
      FFiltered := oldFiltered;
    end;
    BufferPos := tmpPos;
    CurrentMoveBy( 0 );
  finally
    OnEndBusy( Self );
  end;
  RestoreCachedRecords;
  IterateNodeRef( FCurRef, 0, not FFilterDel, not FFiltered, true, false );
  AdjRowNum( oldRowNum - CurRowNum );
end;

end.

