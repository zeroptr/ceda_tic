
{                                                                              }
{  IB_Profiler                                                                 }
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
{  Original Author: Corey Wangler                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the IB_Profiler component.}
unit 
  IB_Profiler;

{$HINTS OFF}
{$WARNINGS OFF}

interface

uses
  Classes, Forms, SysUtils, Windows,

  IB_Header,
  IB_Session,
  IB_Components;

const
  PROFILER_REQUEST_BUFFER_SIZE = 17;
{ NOTE: Database operation counts require 3 bytes for header info (type & size)
  plus 6 bytes (RELATION_ID & count value) per table.  There are 8 types of
  db operation counts, so the number of tables supported (assuming each type
  returns info for every table) by a 30KB buffer would be:
    (30*1024 - 8*3)/(8*6) = 639.5
  Hence 30KB of storage will handle all requested database operation counts
  if the database has 639 tables defined (a lot!) and each count operation
  had occurred on every single table in the database.
  The following value is that passed to the API call isc_database_info() to
  specify (via a smallint parameter) the size of the result buffer (in bytes). }
  PROFILER_RESULT_BUFFER_SIZE = 32760;
  //TODO// move these to IB_Constants.pas
  PROFILE_MARKED_START = 'PROFILE MARKED START';
  PROFILE_DATA_MARKED_AS_START = 'PROFILE DATA MARKED AS START';
  PROFILE_LOADING_RELATIONSBYID_INFO = '(loading RelationsByID)';
  ERROR_PROFILE_MARK_FAILED = 'ERROR -- PROFILE MARK FAILED';
  ERROR_NO_PROFILE_DATA_FOR_REPORT = 'ERROR -- NO PROFILE DATA FOR REPORT';

type
{: These are the different categories of profiling information that can be
tracked in the IB_Profiler component.
<br><br>
Groups correspond to the following isc_database_info() request buffer items...
<br><br>
<br>  pgMemory
<br>    isc_info_current_memory
<br>    isc_info_max_memory
<br>    isc_info_num_buffers
<br>    isc_info_fetches
<br>    isc_info_marks
<br>  pgPages
<br>    isc_info_allocation
<br>    isc_info_reads
<br>    isc_info_writes            
<br>  pgRead
<br>    isc_info_read_seq_count
<br>    isc_info_read_idx_count
<br>  pgRecord
<br>    isc_info_insert_count
<br>    isc_info_update_count
<br>    isc_info_delete_count
<br>  pgVersionRemoval
<br>    isc_info_backout_count
<br>    isc_info_expunge_count
<br>    isc_info_purge_count
<br><br>
The pgMemory and pgPages groups gather information for the entire server, i.e.
for all processes using the server.  The other groups (pgRead, pgRecord, and
pgVersionRemoval) collect database operation counts for just the connected
process, i.e. activity that was requested for this IB_Connection, and report
database operation counts on a per-table basis.
<br><br>
Further information on isc_database_info() and the above request buffer items
can be found in the InterBase documentation (API Guide).}
TIB_ProfilerGroups = ( pgMemory,
                       pgPages,
                       pgRead,
                       pgRecord,
                       pgVersionRemoval );
{: Composite set of groups for tracking profiling information.}
TIB_ProfilerGroupSet = set of TIB_ProfilerGroups;

{: This component provides access to server memory usage and database operation
count information accessible via the InterBase API call isc_database_info().
Database operation counts are on a per-table basis for the session that this
component is associated with.
<br><br>
The information gathered by this component is useful for profiling queries and
other activities (e.g. stored procedures, trigger activity associated with
posting of an insert, etc) to determine what areas of an application need
to be optimized to increase speed and reduce use of server resources.
<br><br>
Information is reported either for the whole session, or as a difference report
with respect to a marked reference point.}
TIB_Profiler = class(TIB_Component)
private
  FIB_ConnectionLink: TIB_ConnectionLink;
  FProfilerGroups: TIB_ProfilerGroupSet;
  FRequestItemsBuffer: array [0..PROFILER_REQUEST_BUFFER_SIZE] of Char;
  FRequestItemsCount: integer;
  FLoadingRelationsByID: Boolean;
  {Storage of entire profile information...}
  FProfileData: array[0..1] of Pointer;
  FProfileDataValid: array [0..1] of Boolean;
  FMarkedBank: integer;
  FLastGrabBank: integer;
  {Memory and buffer usage profiling information...}
  FCurrentMemory: array [0..1] of Longint;
  FMaxMemory: array [0..1] of Longint;
  FNumBuffers: array [0..1] of Longint;
  FBufferReads: array [0..1] of Longint;
  FBufferWrites: array [0..1] of Longint;
  FNumPages: array [0..1] of Longint;
  FPageReads: array [0..1] of Longint;
  FPageWrites: array [0..1] of Longint;
  {Location and number for database operation count profiling data...}
  FOpCountPtr_read_seq: array[0..1] of Pointer;
  FOpCountPtr_read_idx: array[0..1] of Pointer;
  FOpCountPtr_insert: array[0..1] of Pointer;
  FOpCountPtr_update: array[0..1] of Pointer;
  FOpCountPtr_delete: array[0..1] of Pointer;
  FOpCountPtr_backout: array[0..1] of Pointer;
  FOpCountPtr_expunge: array[0..1] of Pointer;
  FOpCountPtr_purge:   array[0..1] of Pointer;
  FOpCountNum_read_seq: array[0..1] of Integer;
  FOpCountNum_read_idx: array[0..1] of Integer;
  FOpCountNum_insert: array[0..1] of Integer;
  FOpCountNum_update: array[0..1] of Integer;
  FOpCountNum_delete: array[0..1] of Integer;
  FOpCountNum_backout: array[0..1] of Integer;
  FOpCountNum_expunge: array[0..1] of Integer;
  FOpCountNum_purge:   array[0..1] of Integer;
  {Reporting options...}
  FIncludeTimeStamp: boolean;
  FOpCountReportThreshold: longint;       //TODO// ADD PROPERTY
  FTotalOpCountReportThreshold: longint;  //TODO// ADD PROPERTY
  {Internal routines...}
  procedure ResetProfileDataStorage;
  procedure UpdateRequestItemsBuffer;
  function TableDescription( RelationID: integer ): string;
  function DbOpCountDetails( HeadingText: string;
                             OpCountNum: integer;
                             OpCountPtr: PChar ): string;
  function DbOpCountDiffDetails( HeadingText: string;
                                 OpCount1Num: integer;
                                 OpCount1Ptr: PChar;
                                 OpCount2Num: integer;
                                 OpCount2Ptr: PChar ): string;
  function GetCurrentMemory: Longint;
  function GetCurrentMemoryDelta: Longint;
  function GetMaxMemory: Longint;
  function GetMaxMemoryDelta: Longint;
  function GetNumBuffers: Longint;
  function GetNumBuffersDelta: Longint;
  function GetBufferReads: Longint;
  function GetBufferReadsDelta: Longint;
  function GetBufferWrites: Longint;
  function GetBufferWritesDelta: Longint;
  function GetNumPages: Longint;
  function GetNumPagesDelta: Longint;
  function GetPageReads: Longint;
  function GetPageReadsDelta: Longint;
  function GetPageWrites: Longint;
  function GetPageWritesDelta: Longint;
protected
  procedure SetConnection( AValue: TIB_Connection ); virtual;
  function GetConnection: TIB_Connection; virtual;
  procedure SetProfilerGroups( AValue: TIB_ProfilerGroupSet );
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{: Grabs current profiling data.}
  procedure Grab;
{: Marks the last grabbed profiling data as the reference point for future
difference reports.}
  procedure MarkLastGrab;
{: Grabs current profiling data and marks it as the reference point for future
difference reports.}
  procedure Mark;
{: Returns true if profiling data exists that is marked as the reference point
for future difference reports.}
  function HaveMark: boolean;
{: Grabs current profiling data and returns a report of activity since the last
marked data grab.  If MarkTheData is specified true, marks the grabbed data as
the reference point for future difference reports.
<br><br>
If there is no current marked data when this method is called, data will be
grabbed and marked as the reference point.  The output from this method in
this case will just state PROFILE_MARKED_START.  This behaviour makes it
easier to support profiling using just this method.
<br><br>
To track a series of events and show cumulative profiling data relative
to a single initial reference point, use:
<br>  Profiler.Mark;  //<=-mark the reference point
<br>  //first stage of process here
<br>  ProfileReportText1 := Profiler.Report( 'end 1st stage', false );
<br>  //second stage of process here
<br>  ProfileReportText2 := Profiler.Report( 'end 2nd stage', false );
<br>  . . .
<br>
To track a series of events and report the database activity
between each event:
<br>  Profiler.Mark;
<br>  //first stage of process here
<br>  ProfileReportText1 := Profiler.Report( '1st stage', true );
<br>  //second stage of process here
<br>  ProfileReportText2 := Profiler.Report( '2nd stage', true );
<br>  . . .}
  function Report( AComment: string;
                   MarkTheData: boolean ): string;
{: Grabs current profiling data and returns a report for the entire session's
activity.  If MarkTheData is specified true, marks the grabbed data as
the reference point for future difference reports.}
  function ReportEntireSession( AComment: string;
                                MarkTheData: boolean ): string;
{: Property access to the stats. See IB docs for help.}
  property CurrentMemory: longint      read GetCurrentMemory;
{: Property access to the stats. See IB docs for help.}
  property CurrentMemoryDelta: longint read GetCurrentMemoryDelta;
{: Property access to the stats. See IB docs for help.}
  property MaxMemory: longint          read GetMaxMemory;
{: Property access to the stats. See IB docs for help.}
  property MaxMemoryDelta: longint     read GetMaxMemoryDelta;
{: Property access to the stats. See IB docs for help.}
  property NumBuffers: longint         read GetNumBuffers;
{: Property access to the stats. See IB docs for help.}
  property NumBuffersDelta: longint    read GetNumBuffersDelta;
{: Property access to the stats. See IB docs for help.}
  property BufferReads: longint        read GetBufferReads;
{: Property access to the stats. See IB docs for help.}
  property BufferReadsDelta: longint   read GetBufferReadsDelta;
{: Property access to the stats. See IB docs for help.}
  property BufferWrites: longint       read GetBufferWrites;
{: Property access to the stats. See IB docs for help.}
  property BufferWritesDelta: longint  read GetBufferWritesDelta;
{: Property access to the stats. See IB docs for help.}
  property NumPages: longint           read GetNumPages;
{: Property access to the stats. See IB docs for help.}
  property NumPagesDelta: longint      read GetNumPagesDelta;
{: Property access to the stats. See IB docs for help.}
  property PageReads: longint          read GetPageReads;
{: Property access to the stats. See IB docs for help.}
  property PageReadsDelta: longint     read GetPageReadsDelta;
{: Property access to the stats. See IB docs for help.}
  property PageWrites: longint         read GetPageWrites;
{: Property access to the stats. See IB docs for help.}
  property PageWritesDelta: longint    read GetPageWritesDelta;
published
{: Connection to be used for grabbing of profile information.}
  property IB_Connection: TIB_Connection read GetConnection
                                         write SetConnection;
{: Determines which groups of profiling information will be tracked.}
  property ProfilerGroups: TIB_ProfilerGroupSet
      read FProfilerGroups
     write SetProfilerGroups
   default [ pgMemory, pgPages, pgRead, pgRecord, pgVersionRemoval ];
{: Include the date and time stamp in the profiler output.}
  property IncludeTimeStamp: boolean read FIncludeTimeStamp
                                     write FIncludeTimeStamp
                                     default false;
end;

implementation

constructor TIB_Profiler.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIB_ConnectionLink := TIB_ConnectionLink.Create( Self );
  FProfileData[0] := nil;
  FProfileData[1] := nil;
  FProfileData[0] := AllocMem(PROFILER_RESULT_BUFFER_SIZE);
  FProfileData[1] := AllocMem(PROFILER_RESULT_BUFFER_SIZE);
  ResetProfileDataStorage;
  FProfilerGroups := [ pgMemory, pgPages, pgRead, pgRecord, pgVersionRemoval ];
  UpdateRequestItemsBuffer;
  FIncludeTimeStamp := false;
  FOpCountReportThreshold := 0;
  FTotalOpCountReportThreshold := 0;
  FLoadingRelationsByID := false;
end;

destructor TIB_Profiler.Destroy;
begin
  FProfileDataValid[0] := false;
  FProfileDataValid[1] := false;
  FreeMem( FProfileData[0] );
  FreeMem( FProfileData[1] );
  FProfileData[0] := nil;
  FProfileData[1] := nil;
  inherited Destroy;
end;

procedure TIB_Profiler.SetConnection( AValue: TIB_Connection );
begin
  if IB_Connection <> AValue then
  begin
    if Assigned( IB_Connection ) then
      ResetProfileDataStorage;
    FIB_ConnectionLink.IB_Connection := AValue;
  end;
end;

function TIB_Profiler.GetConnection: TIB_Connection;
begin
  Result := FIB_ConnectionLink.IB_Connection;
end;

procedure TIB_Profiler.ResetProfileDataStorage;
begin
  FProfileDataValid[0] := false;
  FProfileDataValid[1] := false;
  FMarkedBank := 0;
  FLastGrabBank := 0;
end;

procedure TIB_Profiler.UpdateRequestItemsBuffer;
var
  ItemPtr: integer;
  procedure AddInfoItem( C: byte );
  begin
{$IFNDEF VER90}
    Assert( ItemPtr <= SizeOf(FRequestItemsBuffer),
            'TIB_Profiler.UpdateRequestItemsBuffer():'#13#10 +
            'Request buffer size exceeded');
{$ENDIF}
    FRequestItemsBuffer[ItemPtr] := char(C);
    Inc( ItemPtr );
  end;
begin
  FillChar( FRequestItemsBuffer, SizeOf(FRequestItemsBuffer), #0 );
  ItemPtr := 0;
  if ( pgMemory in ProfilerGroups ) then
  begin
    AddInfoItem( isc_info_current_memory );
    AddInfoItem( isc_info_max_memory );
    AddInfoItem( isc_info_num_buffers );
    AddInfoItem( isc_info_fetches );
    AddInfoItem( isc_info_marks );
  end;
  if ( pgPages in ProfilerGroups ) then
  begin
    AddInfoItem( isc_info_allocation );
    AddInfoItem( isc_info_reads );
    AddInfoItem( isc_info_writes );
  end;
  if ( pgRead in ProfilerGroups ) then
  begin
    AddInfoItem( isc_info_read_seq_count );
    AddInfoItem( isc_info_read_idx_count );
  end;
  if ( pgRecord in ProfilerGroups ) then
  begin
    AddInfoItem( isc_info_insert_count );
    AddInfoItem( isc_info_update_count );
    AddInfoItem( isc_info_delete_count );
  end;
  if ( pgVersionRemoval in ProfilerGroups ) then
  begin
    AddInfoItem( isc_info_backout_count );
    AddInfoItem( isc_info_expunge_count );
    AddInfoItem( isc_info_purge_count );
  end;
  AddInfoItem( isc_info_end );
  FRequestItemsCount := ItemPtr;
  ItemPtr := 0;
  ResetProfileDataStorage;
end;

procedure TIB_Profiler.SetProfilerGroups( AValue: TIB_ProfilerGroupSet );
begin
  if ProfilerGroups <> AValue then
  begin
    FProfilerGroups := AValue;
    UpdateRequestItemsBuffer;
  end;
end;

procedure TIB_Profiler.Grab;
var
  SaveCW: word;
  TmpBank: integer;
  ResultsPtr: PChar;
  ResultsMaxPtr: PChar;
  Item: byte;
  ItemLen: integer;
// Translate value pairs (RelationID, NumOperations) to native
// data types (in place) and return the number of value pairs.
  function TranslateValuePairs: integer;
  var
    TmpPtr: PChar;
    ii: integer;
    RelationIDPtr: ^Smallint;
    NumOperationsPtr: ^Longint;
  begin
{$IFNDEF VER90}
    Assert( (ItemLen mod 6) = 0,
            'TIB_Profiler.Grab.TranslateValuePairs():'#13#10 +
            'ItemLen not an exact value pair multiple');
{$ENDIF}
    Result := ItemLen div 6;
    TmpPtr := ResultsPtr;
    for ii := 1 to Result do
    begin
      RelationIDPtr := Pointer( TmpPtr );
      RelationIDPtr^ := {IB_Session.}isc_vax_integer( TmpPtr, 2 );
      Inc( TmpPtr, 2 );
      NumOperationsPtr := Pointer( TmpPtr );
      NumOperationsPtr^ := {IB_Session.}isc_vax_integer( TmpPtr, 4 );
      Inc( TmpPtr, 4 );
    end;
  end;
begin
  {Have schema cache load RelationsByID info first...}
  // Note: Loading of RelationsByID info can trigger further grabbing/reporting
  //       in SQL Monitor components.  Having it done here before the start of
  //       grab will make such SQL Monitor activity occur in a continuous block
  //       before the actual requested grab.  Having it done before the grab
  //       also means that this extra activity will not be included in a
  //       subsequent difference report made after the actual requested grab.
  if not FLoadingRelationsByID then
  try
    FLoadingRelationsByID := true;
    if not Assigned( FIB_ConnectionLink.IB_Connection ) then
      SetConnection( FIB_ConnectionLink.IB_Session.DefaultConnection );
    if Assigned( FIB_ConnectionLink.IB_Connection ) then
      with FIB_ConnectionLink.IB_Connection.SchemaCache do
        LoadRelationsByIDInfo;
  finally
    FLoadingRelationsByID := false;
  end;
  {Work out which buffer bank to use...}
  TmpBank := Ord(FMarkedBank = 0);
  ResultsPtr := FProfileData[TmpBank];
  ResultsMaxPtr := ResultsPtr + PROFILER_RESULT_BUFFER_SIZE - 1;
  {Reset profiling data for given bank...}
  FProfileDataValid[TmpBank] := false;
  FLastGrabBank := TmpBank;
{$IFDEF DEBUG}
  FillChar( ResultsPtr^, PROFILER_RESULT_BUFFER_SIZE, #0 );
{$ENDIF}
  {Reset all profiling info related to given bank...}
  FCurrentMemory[TmpBank] := 0;
  FMaxMemory[TmpBank] := 0;
  FNumBuffers[TmpBank] := 0;
  FBufferReads[TmpBank] := 0;
  FBufferWrites[TmpBank] := 0;
  FNumPages[TmpBank] := 0;
  FPageReads[TmpBank] := 0;
  FPageWrites[TmpBank] := 0;
  FOpCountNum_read_seq[TmpBank] := 0;
  FOpCountNum_read_idx[TmpBank] := 0;
  FOpCountNum_insert[TmpBank] := 0;
  FOpCountNum_update[TmpBank] := 0;
  FOpCountNum_delete[TmpBank] := 0;
  FOpCountNum_backout[TmpBank] := 0;
  FOpCountNum_expunge[TmpBank] := 0;
  FOpCountNum_purge[TmpBank] := 0;
  {Grab data into buffer...}
  if not FIB_ConnectionLink.Connected then
    raise Exception.Create('Profiler not connected!');
  if FRequestItemsCount <= 0 then
    raise Exception.Create('Profiler has no request items');
  with IB_Session do
  begin
    asm fstcw [SaveCW] end;
    errcode := isc_database_info( @status,
                                  IB_Connection.PdbHandle,
                                  FRequestItemsCount,
                                  FRequestItemsBuffer,
                                  PROFILER_RESULT_BUFFER_SIZE,
                                  ResultsPtr );
    asm fldcw [SaveCW] end;
    if errcode <> 0 then HandleException( Self );  //TODO// ???
  end;
  {Iterate through results...}
  while byte( ResultsPtr^ ) <> isc_info_end do
  begin
    Item := byte( ResultsPtr^ );
    Inc( ResultsPtr, 1 );
    ItemLen := {IB_Session.}isc_vax_integer( ResultsPtr, 2 );
    Inc( ResultsPtr, 2 );
{$IFNDEF VER90}
    Assert( (ResultsPtr + ItemLen) <= ResultsMaxPtr,
            'TIB_Profiler.Grab():'#13#10 +
            'ResultPtr + ItemLen would go outside of Buffer');
{$ENDIF}
    with IB_Session do case Item of
      isc_info_current_memory:
        FCurrentMemory[TmpBank] := isc_vax_integer( ResultsPtr, ItemLen );
      isc_info_max_memory:
        FMaxMemory[TmpBank] := isc_vax_integer( ResultsPtr, ItemLen );
      isc_info_num_buffers:
        FNumBuffers[TmpBank] := isc_vax_integer( ResultsPtr, ItemLen );
      isc_info_fetches:
        FBufferReads[TmpBank] := isc_vax_integer( ResultsPtr, ItemLen );
      isc_info_marks:
        FBufferWrites[TmpBank] := isc_vax_integer( ResultsPtr, ItemLen );
      isc_info_allocation:
        FNumPages[TmpBank] := isc_vax_integer( ResultsPtr, ItemLen );
      isc_info_reads:
        FPageReads[TmpBank] := isc_vax_integer( ResultsPtr, ItemLen );
      isc_info_writes:
        FPageWrites[TmpBank] := isc_vax_integer( ResultsPtr, ItemLen );
      isc_info_read_seq_count:
      begin
        FOpCountPtr_read_seq[TmpBank] := ResultsPtr;
        FOpCountNum_read_seq[TmpBank] := TranslateValuePairs;
      end;
      isc_info_read_idx_count:
      begin
        FOpCountPtr_read_idx[TmpBank] := ResultsPtr;
        FOpCountNum_read_idx[TmpBank] := TranslateValuePairs;
      end;
      isc_info_insert_count:
      begin
        FOpCountPtr_insert[TmpBank] := ResultsPtr;
        FOpCountNum_insert[TmpBank] := TranslateValuePairs;
      end;
      isc_info_update_count:
      begin
        FOpCountPtr_update[TmpBank] := ResultsPtr;
        FOpCountNum_update[TmpBank] := TranslateValuePairs;
      end;
      isc_info_delete_count:
      begin
        FOpCountPtr_delete[TmpBank] := ResultsPtr;
        FOpCountNum_delete[TmpBank] := TranslateValuePairs;
      end;
      isc_info_backout_count:
      begin
        FOpCountPtr_backout[TmpBank] := ResultsPtr;
        FOpCountNum_backout[TmpBank] := TranslateValuePairs;
      end;
      isc_info_expunge_count:
      begin
        FOpCountPtr_expunge[TmpBank] := ResultsPtr;
        FOpCountNum_expunge[TmpBank] := TranslateValuePairs;
      end;
      isc_info_purge_count:
      begin
        FOpCountPtr_purge[TmpBank] := ResultsPtr;
        FOpCountNum_purge[TmpBank] := TranslateValuePairs;
      end;
    end;
    Inc( ResultsPtr, ItemLen );
  end;
  FProfileDataValid[TmpBank] := true;
end;

procedure TIB_Profiler.MarkLastGrab;
begin
  FMarkedBank := FLastGrabBank;
end;

function TIB_Profiler.HaveMark: boolean;
begin
  Result := FProfileDataValid[FMarkedBank];
end;

procedure TIB_Profiler.Mark;
begin
  Grab;
  MarkLastGrab;
end;

function TIB_Profiler.TableDescription( RelationID: integer ): string;
begin
  Result := '';
  if Assigned( FIB_ConnectionLink.IB_Connection ) then
    with FIB_ConnectionLink.IB_Connection.SchemaCache do
      RelationsByID.FindValue( IntToStr(RelationID), Result );
  if Length(Result) <= 0 then
    Result := 'RELATION_ID=' + IntToStr(RelationID);
end;

function TIB_Profiler.DbOpCountDetails( HeadingText: string;
                                        OpCountNum: integer;
                                        OpCountPtr: PChar ): string;
var
  ii: integer;
  RelationIDPtr: ^Smallint;
  NumOperationsPtr: ^Longint;
  TmpOpCount: longint;
  TmpTotalOpCount: longint;
  S: string;
  Range9, Range99, Range999, Range9999, Range99999: string;
begin
  Range9 := '';
  Range99 := '';
  Range999 := '';
  Range9999 := '';
  Range99999 := '';
  Result := '';
  TmpTotalOpCount := 0;
  for ii := 1 to OpCountNum do
  begin
    RelationIDPtr := Pointer( OpCountPtr );
    NumOperationsPtr := Pointer( OpCountPtr + 2 );
    Inc( OpCountPtr, 6 );
    TmpOpCount := NumOperationsPtr^;
    Inc( TmpTotalOpCount, TmpOpCount );
    if ( TmpOpCount > 0 ) and
        ( TmpOpCount >= FOpCountReportThreshold ) then
    begin
      S := '  ' + FormatFloat('#,##0', TmpOpCount ) + '  ' +
           TableDescription( RelationIDPtr^ ) + #13#10;
      if TmpOpCount <= 9 then
        Range9 := Range9 + S
      else if TmpOpCount <= 99 then
        Range99 := Range99 + S
      else if TmpOpCount <= 999 then
        Range999 := Range999 + S
      else if TmpOpCount <= 9999 then
        Range9999 := Range9999 + S
      else if TmpOpCount <= 99999 then
        Range99999 := Range99999 + S
      else
        Result := Result + S;
    end;
  end;
  if ( TmpTotalOpCount > 0 ) and
      ( TmpTotalOpCount >= FTotalOpCountReportThreshold ) then
    Result := '*** ' + HeadingText + ' ***  ' +
              FormatFloat('#,##0', TmpTotalOpCount ) + #13#10 +
              Result + Range99999 + Range9999 + Range999 + Range99 + Range9;
end;

function TIB_Profiler.ReportEntireSession( AComment: string;
                                           MarkTheData: boolean ): string;
var
  TmpBank: integer;
begin
  Grab;
  TmpBank := FLastGrabBank;
  if FProfileDataValid[TmpBank] then
  begin
    Result := '';
    if IncludeTimeStamp then
      Result := '[ ' + FormatDateTime( '', now ) + ' ]'#13#10;
    Result := Result + 'PROFILE REPORT FOR ENTIRE SESSION';
    if FLoadingRelationsByID then
      Result := Result + PROFILE_LOADING_RELATIONSBYID_INFO;
    if Length(AComment) > 0 then
      Result := Result + ' -- ' + AComment;
    Result := Result + #13#10;
    if (FCurrentMemory[TmpBank] > 0) or
        (FMaxMemory[TmpBank] > 0) or
        (FNumBuffers[TmpBank] > 0) or
        (FBufferReads[TmpBank] > 0) or
        (FBufferWrites[TmpBank] > 0) or
        (FNumPages[TmpBank] > 0) or
        (FPageReads[TmpBank] > 0) or
        (FPageWrites[TmpBank] > 0) then
    begin
      Result := Result + '*** OVERALL SERVER PROCESS ***'#13#10;
      if FCurrentMemory[TmpBank] > 0 then
        Result := Result + '  Current Memory = ' +
            FormatFloat('#,##0', FCurrentMemory[TmpBank] ) + #13#10;
      if FMaxMemory[TmpBank] > 0 then
        Result := Result + '  Max Memory = ' +
            FormatFloat('#,##0', FMaxMemory[TmpBank] ) + #13#10;
      if FNumBuffers[TmpBank] > 0 then
        Result := Result + '  Num Memory Buffers = ' +
            FormatFloat('#,##0', FNumBuffers[TmpBank] ) + #13#10;
      if FBufferReads[TmpBank] > 0 then
        Result := Result + '  Num Buffer Reads = ' +
            FormatFloat('#,##0', FBufferReads[TmpBank] ) + #13#10;
      if FBufferWrites[TmpBank] > 0 then
        Result := Result + '  Num Buffer Writes = ' +
            FormatFloat('#,##0', FBufferWrites[TmpBank] ) + #13#10;
      if FNumPages[TmpBank] > 0 then
        Result := Result + '  Num Pages Allocated = ' +
            FormatFloat('#,##0', FNumPages[TmpBank] ) + #13#10;
      if FPageReads[TmpBank] > 0 then
        Result := Result + '  Num Page Reads = ' +
            FormatFloat('#,##0', FPageReads[TmpBank] ) + #13#10;
      if FPageWrites[TmpBank] > 0 then
        Result := Result + '  Num Page Writes = ' +
            FormatFloat('#,##0', FPageWrites[TmpBank] ) + #13#10;
    end;
    if FOpCountNum_read_seq[TmpBank] > 0 then
      Result := Result + DbOpCountDetails( 'SEQUENTIAL (NON-INDEXED) READS',
                                           FOpCountNum_read_seq[TmpBank],
                                           FOpCountPtr_read_seq[TmpBank] );
    if FOpCountNum_read_idx[TmpBank] > 0 then
      Result := Result + DbOpCountDetails( 'INDEXED READS',
                                           FOpCountNum_read_idx[TmpBank],
                                           FOpCountPtr_read_idx[TmpBank] );
    if FOpCountNum_insert[TmpBank] > 0 then
      Result := Result + DbOpCountDetails( 'INSERT COUNT',
                                           FOpCountNum_insert[TmpBank],
                                           FOpCountPtr_insert[TmpBank] );
    if FOpCountNum_update[TmpBank] > 0 then
      Result := Result + DbOpCountDetails( 'UPDATE COUNT',
                                           FOpCountNum_update[TmpBank],
                                           FOpCountPtr_update[TmpBank] );
    if FOpCountNum_delete[TmpBank] > 0 then
      Result := Result + DbOpCountDetails( 'DELETE COUNT',
                                           FOpCountNum_delete[TmpBank],
                                           FOpCountPtr_delete[TmpBank] );
    if FOpCountNum_backout[TmpBank] > 0 then
      Result := Result + DbOpCountDetails( 'VERSION BACKOUT COUNT',
                                           FOpCountNum_backout[TmpBank],
                                           FOpCountPtr_backout[TmpBank] );
    if FOpCountNum_expunge[TmpBank] > 0 then
      Result := Result + DbOpCountDetails( 'VERSION EXPUNGE COUNT',
                                           FOpCountNum_expunge[TmpBank],
                                           FOpCountPtr_expunge[TmpBank] );
    if FOpCountNum_purge[TmpBank] > 0 then
      Result := Result + DbOpCountDetails( 'VERSION PURGE COUNT',
                                           FOpCountNum_purge[TmpBank],
                                           FOpCountPtr_purge[TmpBank] );
  end
  else
    Result := ERROR_NO_PROFILE_DATA_FOR_REPORT + #13#10;
  if MarkTheData then
  begin
    MarkLastGrab;
    if HaveMark then
      Result := Result + PROFILE_DATA_MARKED_AS_START + #13#10;
  end;
end;

function TIB_Profiler.DbOpCountDiffDetails( HeadingText: string;
                                            OpCount1Num: integer;
                                            OpCount1Ptr: PChar;
                                            OpCount2Num: integer;
                                            OpCount2Ptr: PChar ): string;
var
  OpCount1PtrStart: PChar;
  OpCount1PtrLimit: PChar;
  OpCount1PtrLastFind: PChar;
  OpCount1FoundCount: integer;
  TmpOpCount: longint;
  procedure AdjustTmpOpCount( const RelationID: integer );
  var
    jj: integer;
    RelationID1Ptr: ^Smallint;
    NumOperations1Ptr: ^Longint;
  begin
    {Quick exit if already found a match for each entry...}
    if OpCount1FoundCount >= OpCount1Num then Exit;
    {Start from one after the last successful find...}
    if OpCount1PtrLastFind <> nil then OpCount1Ptr := OpCount1PtrLastFind + 6;
    if OpCount1Ptr >= OpCount1PtrLimit then OpCount1Ptr := OpCount1PtrStart;
    {Iterate thru values to find a match...}
    for jj := 1 to OpCount1Num do
    begin
      RelationID1Ptr := Pointer( OpCount1Ptr );
      if RelationID = RelationID1Ptr^ then
      begin
        {Found matching entry, so subtract this count from TmpOpCount...}
        NumOperations1Ptr := Pointer( OpCount1Ptr + 2 );
        Dec( TmpOpCount, NumOperations1Ptr^ );
        {Keep track of successful find info and exit...}
        OpCount1PtrLastFind := OpCount1Ptr;
        Inc( OpCount1FoundCount );
        Exit;
      end;
      Inc( OpCount1Ptr, 6 );
      if OpCount1Ptr >= OpCount1PtrLimit then OpCount1Ptr := OpCount1PtrStart;
    end;
  end;
var
  ii: integer;
  RelationID2Ptr: ^Smallint;
  NumOperations2Ptr: ^Longint;
  TmpTotalOpCount: longint;
  S: string;
  Range9, Range99, Range999, Range9999, Range99999: string;
begin
  OpCount1PtrStart := OpCount1Ptr;
  OpCount1PtrLimit := OpCount1Ptr + (6 * OpCount1Num);
  OpCount1PtrLastFind := nil;
  OpCount1FoundCount := 0;
  Range9 := '';
  Range99 := '';
  Range999 := '';
  Range9999 := '';
  Range99999 := '';
  Result := '';
  TmpTotalOpCount := 0;
  for ii := 1 to OpCount2Num do
  begin
    RelationID2Ptr := Pointer( OpCount2Ptr );
    NumOperations2Ptr := Pointer( OpCount2Ptr + 2 );
    Inc( OpCount2Ptr, 6 );
    TmpOpCount := NumOperations2Ptr^;
    AdjustTmpOpCount( RelationID2Ptr^ );
    Inc( TmpTotalOpCount, TmpOpCount );
    if ( TmpOpCount > 0 ) and
        ( TmpOpCount >= FOpCountReportThreshold ) then
    begin
      S := '  ' + FormatFloat('#,##0', TmpOpCount ) + '  ' +
           TableDescription( RelationID2Ptr^ ) + #13#10;
      if TmpOpCount <= 9 then
        Range9 := Range9 + S
      else if TmpOpCount <= 99 then
        Range99 := Range99 + S
      else if TmpOpCount <= 999 then
        Range999 := Range999 + S
      else if TmpOpCount <= 9999 then
        Range9999 := Range9999 + S
      else if TmpOpCount <= 99999 then
        Range99999 := Range99999 + S
      else
        Result := Result + S;
    end;
  end;
  if ( TmpTotalOpCount > 0 ) and
      ( TmpTotalOpCount >= FTotalOpCountReportThreshold ) then
    Result := '*** ' + HeadingText + ' ***  ' +
              FormatFloat('#,##0', TmpTotalOpCount ) + #13#10 +
              Result + Range99999 + Range9999 + Range999 + Range99 + Range9;
end;

function TIB_Profiler.Report( AComment: string; MarkTheData: boolean ): string;
begin
  Result := '';
  Grab;
  if not HaveMark then
  begin
    MarkLastGrab;
    if IncludeTimeStamp then
      Result := '[ ' + FormatDateTime( '', now ) + ' ]'#13#10;
    if HaveMark then
      Result := Result + PROFILE_MARKED_START
    else
      Result := Result + ERROR_PROFILE_MARK_FAILED;
    if FLoadingRelationsByID then
      Result := Result + PROFILE_LOADING_RELATIONSBYID_INFO;
    if Length(AComment) > 0 then
      Result := Result + ' -- ' + AComment;
    Result := Result + #13#10;
    Exit;  // Finished here.
  end;
{$IFNDEF VER90}
  Assert(FLastGrabBank <> FMarkedBank, 'Banks should be different!');
{$ENDIF}
  if FProfileDataValid[FLastGrabBank] then
  begin
    Result := '';
    if IncludeTimeStamp then
      Result := '[ ' + FormatDateTime( '', now ) + ' ]'#13#10;
    Result := Result + 'PROFILE DIFF REPORT';
    if FLoadingRelationsByID then
      Result := Result + PROFILE_LOADING_RELATIONSBYID_INFO;
    if Length(AComment) > 0 then
      Result := Result + ' -- ' + AComment;
    Result := Result + #13#10;

    if ((FCurrentMemory[FLastGrabBank]-FCurrentMemory[FMarkedBank]) <> 0) or
        ((FMaxMemory[FLastGrabBank]-FMaxMemory[FMarkedBank]) <> 0) or
        ((FNumBuffers[FLastGrabBank]-FNumBuffers[FMarkedBank]) <> 0) or
        ((FBufferReads[FLastGrabBank]-FBufferReads[FMarkedBank]) <> 0) or
        ((FBufferWrites[FLastGrabBank]-FBufferWrites[FMarkedBank]) <> 0) or
        ((FNumPages[FLastGrabBank]-FNumPages[FMarkedBank]) <> 0) or
        ((FPageReads[FLastGrabBank]-FPageReads[FMarkedBank]) <> 0) or
        ((FPageWrites[FLastGrabBank]-FPageWrites[FMarkedBank]) <> 0) then
    begin
      Result := Result + '*** OVERALL SERVER PROCESS ***'#13#10;
      if ((FCurrentMemory[FLastGrabBank]-FCurrentMemory[FMarkedBank]) <> 0) then
        Result := Result + '  Current Memory = ' +
            FormatFloat('#,##0', FCurrentMemory[FLastGrabBank] ) + ' (' +
            FormatFloat('+#,##0;-#,##0',
                FCurrentMemory[FLastGrabBank]-FCurrentMemory[FMarkedBank]) +
            ')'#13#10;
      if ((FMaxMemory[FLastGrabBank]-FMaxMemory[FMarkedBank]) <> 0) then
        Result := Result + '  Max Memory = ' +
            FormatFloat('#,##0', FMaxMemory[FLastGrabBank] ) + ' (' +
            FormatFloat('+#,##0;-#,##0',
                FMaxMemory[FLastGrabBank]-FMaxMemory[FMarkedBank]) +
            ')'#13#10;
      if ((FNumBuffers[FLastGrabBank]-FNumBuffers[FMarkedBank]) <> 0) then
        Result := Result + '  Num Memory Buffers = ' +
            FormatFloat('#,##0', FNumBuffers[FLastGrabBank] ) + ' (' +
            FormatFloat('+#,##0;-#,##0',
                FNumBuffers[FLastGrabBank]-FNumBuffers[FMarkedBank]) +
            ')'#13#10;
      if ((FBufferReads[FLastGrabBank]-FBufferReads[FMarkedBank]) <> 0) then
        Result := Result + '  Num Buffer Reads = ' +
            FormatFloat('#,##0', FBufferReads[FLastGrabBank] ) + ' (' +
            FormatFloat('+#,##0;-#,##0',
                FBufferReads[FLastGrabBank]-FBufferReads[FMarkedBank]) +
            ')'#13#10;
      if ((FBufferWrites[FLastGrabBank]-FBufferWrites[FMarkedBank]) <> 0) then
        Result := Result + '  Num Buffer Writes = ' +
            FormatFloat('#,##0', FBufferWrites[FLastGrabBank] ) + ' (' +
            FormatFloat('+#,##0;-#,##0',
                FBufferWrites[FLastGrabBank]-FBufferWrites[FMarkedBank]) +
            ')'#13#10;
      if ((FNumPages[FLastGrabBank]-FNumPages[FMarkedBank]) <> 0) then
        Result := Result + '  Num Pages Allocated = ' +
            FormatFloat('#,##0', FNumPages[FLastGrabBank] ) + ' (' +
            FormatFloat('+#,##0;-#,##0',
                FNumPages[FLastGrabBank]-FNumPages[FMarkedBank]) +
            ')'#13#10;
      if ((FPageReads[FLastGrabBank]-FPageReads[FMarkedBank]) <> 0) then
        Result := Result + '  Num Page Reads = ' +
            FormatFloat('#,##0', FPageReads[FLastGrabBank] ) + ' (' +
            FormatFloat('+#,##0;-#,##0',
                FPageReads[FLastGrabBank]-FPageReads[FMarkedBank]) +
            ')'#13#10;
      if ((FPageWrites[FLastGrabBank]-FPageWrites[FMarkedBank]) <> 0) then
        Result := Result + '  Num Page Writes = ' +
            FormatFloat('#,##0', FPageWrites[FLastGrabBank] ) + ' (' +
            FormatFloat('+#,##0;-#,##0',
                FPageWrites[FLastGrabBank]-FPageWrites[FMarkedBank]) +
            ')'#13#10;
    end;
{}
    if FOpCountNum_read_seq[FLastGrabBank] > 0 then
      Result := Result + DbOpCountDiffDetails( 'SEQUENTIAL (NON-INDEXED) READS',
                             FOpCountNum_read_seq[FMarkedBank],
                             FOpCountPtr_read_seq[FMarkedBank],
                             FOpCountNum_read_seq[FLastGrabBank],
                             FOpCountPtr_read_seq[FLastGrabBank] );
    if FOpCountNum_read_idx[FLastGrabBank] > 0 then
      Result := Result + DbOpCountDiffDetails( 'INDEXED READS',
                             FOpCountNum_read_idx[FMarkedBank],
                             FOpCountPtr_read_idx[FMarkedBank],
                             FOpCountNum_read_idx[FLastGrabBank],
                             FOpCountPtr_read_idx[FLastGrabBank] );
    if FOpCountNum_insert[FLastGrabBank] > 0 then
      Result := Result + DbOpCountDiffDetails( 'INSERT COUNT',
                             FOpCountNum_insert[FMarkedBank],
                             FOpCountPtr_insert[FMarkedBank],
                             FOpCountNum_insert[FLastGrabBank],
                             FOpCountPtr_insert[FLastGrabBank] );
    if FOpCountNum_update[FLastGrabBank] > 0 then
      Result := Result + DbOpCountDiffDetails( 'UPDATE COUNT',
                             FOpCountNum_update[FMarkedBank],
                             FOpCountPtr_update[FMarkedBank],
                             FOpCountNum_update[FLastGrabBank],
                             FOpCountPtr_update[FLastGrabBank] );
    if FOpCountNum_delete[FLastGrabBank] > 0 then
      Result := Result + DbOpCountDiffDetails( 'DELETE COUNT',
                             FOpCountNum_delete[FMarkedBank],
                             FOpCountPtr_delete[FMarkedBank],
                             FOpCountNum_delete[FLastGrabBank],
                             FOpCountPtr_delete[FLastGrabBank] );
    if FOpCountNum_backout[FLastGrabBank] > 0 then
      Result := Result + DbOpCountDiffDetails( 'VERSION BACKOUT COUNT',
                             FOpCountNum_backout[FMarkedBank],
                             FOpCountPtr_backout[FMarkedBank],
                             FOpCountNum_backout[FLastGrabBank],
                             FOpCountPtr_backout[FLastGrabBank] );
    if FOpCountNum_expunge[FLastGrabBank] > 0 then
      Result := Result + DbOpCountDiffDetails( 'VERSION EXPUNGE COUNT',
                             FOpCountNum_expunge[FMarkedBank],
                             FOpCountPtr_expunge[FMarkedBank],
                             FOpCountNum_expunge[FLastGrabBank],
                             FOpCountPtr_expunge[FLastGrabBank] );
    if FOpCountNum_purge[FLastGrabBank] > 0 then
      Result := Result + DbOpCountDiffDetails( 'VERSION PURGE COUNT',
                             FOpCountNum_purge[FMarkedBank],
                             FOpCountPtr_purge[FMarkedBank],
                             FOpCountNum_purge[FLastGrabBank],
                             FOpCountPtr_purge[FLastGrabBank] );
  end
  else
    Result := ERROR_NO_PROFILE_DATA_FOR_REPORT + #13#10;
  if MarkTheData then
  begin
    MarkLastGrab;
    if HaveMark then
      Result := Result + PROFILE_DATA_MARKED_AS_START + #13#10;
  end;
{}
end;

function TIB_Profiler.GetCurrentMemory: Longint;
begin
  Result := FCurrentMemory[FLastGrabBank];
end;
function TIB_Profiler.GetCurrentMemoryDelta: Longint;
begin
  Result := FCurrentMemory[FLastGrabBank] - FCurrentMemory[FMarkedBank];
end;
function TIB_Profiler.GetMaxMemory: Longint;
begin
  Result := FMaxMemory[FLastGrabBank];
end;
function TIB_Profiler.GetMaxMemoryDelta: Longint;
begin
  Result := FMaxMemory[FLastGrabBank] - FMaxMemory[FMarkedBank];
end;
function TIB_Profiler.GetNumBuffers: Longint;
begin
  Result := FNumBuffers[FLastGrabBank];
end;
function TIB_Profiler.GetNumBuffersDelta: Longint;
begin
  Result := FNumBuffers[FLastGrabBank] - FNumBuffers[FMarkedBank];
end;
function TIB_Profiler.GetBufferReads: Longint;
begin
  Result := FBufferReads[FLastGrabBank]; 
end;
function TIB_Profiler.GetBufferReadsDelta: Longint;
begin
  Result := FBufferReads[FLastGrabBank] - FBufferReads[FMarkedBank]
end;
function TIB_Profiler.GetBufferWrites: Longint;
begin
  Result := FBufferWrites[FLastGrabBank]
end;
function TIB_Profiler.GetBufferWritesDelta: Longint;
begin
  Result := FBufferWrites[FLastGrabBank] - FBufferWrites[FMarkedBank];
end;
function TIB_Profiler.GetNumPages: Longint;
begin
  Result := FNumPages[FLastGrabBank];
end;
function TIB_Profiler.GetNumPagesDelta: Longint;
begin
  Result := FNumPages[FLastGrabBank] - FNumPages[FMarkedBank]
end;
function TIB_Profiler.GetPageReads: Longint;
begin
  Result := FNumPages[FLastGrabBank] - FNumPages[FMarkedBank];
end;
function TIB_Profiler.GetPageReadsDelta: Longint;
begin
  Result := FPageReads[FLastGrabBank] - FPageReads[FMarkedBank];
end;
function TIB_Profiler.GetPageWrites: Longint;
begin
  Result := FPageWrites[FLastGrabBank];
end;
function TIB_Profiler.GetPageWritesDelta: Longint;
begin
  Result := FPageWrites[FLastGrabBank] - FPageWrites[FMarkedBank];
end;

end.

