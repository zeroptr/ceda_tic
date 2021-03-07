
{                                                                              }
{ IB_SESSION                                                                   }
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
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  07-Nov-2001                                                                 }
{     Added isc_portable_integer function.  Its like isc_vax_integer but       }
{     also supports int64 types.  Only available in IB6 and Firebird.          }
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit provides an object based interface to the InterBase API.}
unit
  IB_Session;

interface

uses
  SysUtils, Classes, Forms, Windows, Dialogs, Messages,

  IB_Constants,
  IB_Header;
//IB_Components
//IB_Monitor

const
  BlankQuad: isc_quad = ( );
  FakePointer: pointer = pointer(-1);
  InvalidNodePos: longint = -MaxInt;
  StoredNodePos: longint = -MaxInt + 1;

var
{: This global variable serves as a flag to tell if you want to make sure and
check for reserved tokens automatically. Leaving this to false improves
performance. If you use reserved tokens and manually put quotes around them
it should still be fine to leave this set to false.}
  CheckForReservedTokens: boolean = false;

// Hans added global variable
{: This global variable sets the limit for a VarChar to be
   returned as a ftString FieldType, before it becomes a ftMemo FieldType
   in TIBODataSet.}
  MaximumStringSize: Integer = 255;

type

TIB_XSQLVAR = class
private
  FPXSQLDA: PXSQLDA;
  FPXSQLVAR: PXSQLVAR;
  FPXSQLVAR_V2: PXSQLVAR_V2;
  function GetSqlType: smallint;
  function GetSqlScale: smallint;
  function GetSqlSubType: smallint;
  function GetSqlLen: smallint;
  function GetSqlData: Pointer;
  function GetSqlInd: psmallint;
  function GetSqlNameLen: smallint;
  function GetSqlName: string;
  function GetRelNameLen: smallint;
  function GetRelName: string;
  function GetOwnNameLen: smallint;
  function GetOwnName: string;
  function GetAliasNameLen: smallint;
  function GetAliasName: string;
public
  constructor Create( APXSQLDA:     PXSQLDA;
                      APXSQLVAR:    PXSQLVAR;
                      APXSQLVAR_V2: PXSQLVAR_V2 );
  property SqlType: smallint read GetSqlType;
  property SqlScale: smallint read GetSqlScale;
  property SqlSubType: smallint read GetSqlSubType;
  property SqlLen: smallint read GetSqlLen;
  property SqlData: Pointer read GetSqlData;
  property SqlInd: psmallint read GetSqlInd;
  property SqlNameLen: smallint read GetSqlNameLen;
  property SqlName: string read GetSqlName;
  property RelNameLen: smallint read GetRelNameLen;
  property RelName: string read GetRelName;
  property OwnNameLen: smallint read GetOwnNameLen;
  property OwnName: string read GetOwnName;
  property AliasNameLen: smallint read GetAliasNameLen;
  property AliasName: string read GetAliasName;
end;

{: Data structure to provide the number of affected rows after a statement is
executed. }
TIB_RowsAffected = record
  UpdateCount: integer;
  DeleteCount: integer;
  SelectCount: integer;
  InsertCount: integer;
end;

{ Structures used in buffered datasets and for blob handling.}

{: The three different zones that the horizontal dataset refinement system
uses to navigate around in very large datasets.}
TIB_RefineZone = ( rzTop, rzMid, rzBot );

{: CachedUpdates processing flag for internal use only.}
TIB_CachedUpdatesProcess = ( cupApply, cupCancel, cupCommit, cupRollback );

TIB_DataAction = ( dacFail, dacAbort, dacRetry );
TIB_UpdateStatus = ( ustUnmodified, ustModified, ustInserted, ustDeleted );
TIB_UpdateKind = ( ukiModify, ukiInsert, ukiDelete );
TIB_UpdateAction = ( uacFail, uacAbort, uacSkip, uacRetry, uacApplied );
TIB_DataOperation = procedure of object;
TIB_DataFunction = function: boolean of object;

{: This event type is used to notify when a record is selected or
unselected.}
TIB_RowSelectedChanged = procedure ( Sender: TObject;
                                     ARow: longint;
                                     ABookmark: string;
                                     IsSelected: boolean ) of object;
{: Options used when processing filter criteria.}
TIB_FilterOption = ( fopCaseInsensitive, fopNoPartialCompare );

{: Options used when processing filter criteria.}
TIB_FilterOptions = set of TIB_FilterOption;

TIB_BlobStreamMode = ( bsmRead, bsmWrite, bsmReadWrite );

PPIB_BlobNode = ^PIB_BlobNode;
PIB_BlobNode = ^TIB_BlobNode;
TIB_BlobNode = record
  BlobID: isc_quad;
  BlobBuffer: pointer;
  BlobBufLen: longint;
  BlobSize: longint;
  BlobChanged: boolean;
  BlobFieldNo: word;
  Next: PIB_BlobNode;
{$IFDEF DEBUG}
  ticks: DWORD;
{$ENDIF}
end;

TIB_BlobCallbackStatus = ( bcsInitGet, bcsInitPut,
                           bcsRefreshGet, bcsRefreshPut,
                           bcsFinalGet, bcsFinalPut );

TIB_BlobCallbackEvent = procedure (     AVAR: PXSQLVAR;
                                        AStatus: TIB_BlobCallbackStatus;
                                        ABytes: longint;
                                    var MaxSegmentSize: longint ) of object;

{: This type is used in the buffered dataset to give information about each row.
<br><br>
<br>  rfBOF and rfEOF are flags to identify the bounding rows of the dataset.
<br>  rfSelected tells whether the row is selected or not.
<br>  rfInserted tells if a cached update insert is in the buffer.
<br>  rfEdited tells if a cached update edit is in the buffer.
<br>  rfDeleted tells if a cached update delete is in the buffer.
<br>  rfUnsorted tellse if a row might not be in the proper order because it was
inserted or the column it is ordered by was edited.}
TIB_RowFlags = ( rfBof,
                 rfEof,
                 rfPos,
                 rfNeg,
                 rfSelected,
                 rfFiltered,
                 rfInserted,
                 rfEdited,
                 rfDeleted,
                 rfApplied,
                 rfSkipped,
                 rfUnsorted,
                 rfTruncated );
TIB_RowFlagSet = set of TIB_RowFlags;

PIB_Node = ^TIB_Node;
TIB_Node = record
  Prev, Next: PIB_Node;
  RowFlags: TIB_RowFlagSet;
  KeyData: pointer;
  RecordLen: integer;
  RecordData: pointer;
  OldRecLen: integer; // Negative means row has been invalidated.
  OldRecData: pointer;
  OldKeyData: pointer;
  BlobHead: PIB_BlobNode;
end;

PIB_NodeIndexItem = ^TIB_NodeIndexItem;
TIB_NodeIndexItem = record
  Next: PIB_NodeIndexItem;
  Node: PIB_Node;
end;

{: Base exception type for IBO.}
EIB_Error = class(Exception);

{: Exception class that contains all the information gathered about the
exception.}
EIB_ISCError = class(EIB_Error)
private
  FSender: TObject;
  FERRCODE: isc_long;
  FErrorMessage: TStringList;
  FErrorCodes: TStringList;
  FSQLCODE: isc_long;
  FSQLMessage: TStringList;
  FSQL: TStringList;
public
  constructor CreateISC( Sender: TObject;
                         MessageText: string;
                         AERRCODE: isc_long;
                         AErrorMessage: TStringList;
                         AErrorCodes: TStringList;
                         ASQLCODE: isc_long;
                         ASQLMessage: TStringList;
                         ASQL: TStringList ); virtual;
  destructor Destroy; override;
  procedure ShowDialog;
  property Sender: TObject read FSender;
  property ERRCODE: isc_long read FERRCODE;
  property ErrorMessage: TStringList read FErrorMessage;
  property ErrorCodes: TStringList read FErrorCodes;
  property SQLCODE: isc_long read FSQLCODE;
  property SQLMessage: TStringList read FSQLMessage;
  property SQL: TStringList read FSQL;
end;

{: This type defines the protocols used to establish a connection. }
TIB_Protocol = ( cpLocal, cpNetBEUI, cpTCP_IP, cpNovell );
{: Determins which action to take when calling the AlterUser method.}
TIB_AlterUserAction = ( uaAddUser, uaDeleteUser, uaModifyUser );

{: Event type for processing exception codes at the API level.
<br><br>
SQLCODE gives the isc_sqlcode() interpretation of the IB API exception code
if one exists.
<br><br>
ERRCODE gives the native InterBase exception code.
<br><br>
ErrorMessages gives the InterBase isc_interprete() messages for all error
messages in the Status vector.
<br><br>
ErrorCodes gives the InterBase error code for all codes in the Status vector.
<br><br>
RaiseException gives control over whether a Delphi exception should be raised
or not. It is possible to simply call SysUtils.Abort to raise a silent
exception immediatly. In most cases this should not be tampered with. }
TIB_ErrorEvent = procedure(       Sender: TObject;
                            const ERRCODE: longint;
                                  ErrorMessage,
                                  ErrorCodes: TStringList;
                            const SQLCODE: longint;
                                  SQLMessage,
                                  SQL: TStringList;
                              var RaiseException: boolean ) of object;

{: This class encapsulates the GDS32.DLL instance by providing an
object based interface to the InterBase API.
<br><br>
All of the supported InterBase API calls are accessed as public members of
an instance to this class. They have been suppressed from this help file
since they are fully documented in the Interbase API reference manual and
online help files.
<br><br>
Please reference the IB_Header.PAS source file for all of the API declarations.
<br><br>
It also provides the capability to define custom error processing.}
TIB_SessionBase = class( TComponent )
private
{ General storage }
  FSQLCODE: longint;
{ Event Storage }
  FOnError: TIB_ErrorEvent;
{ System Methods }
  function SysGetBlobData( pdbHndl: pisc_db_handle;
                           ptrHndl: pisc_tr_handle;
                           AVAR: PXSQLVAR;
                           BlobNode: PIB_BlobNode;
                           AEv: TIB_BlobCallbackEvent ): longint;
  function SysPutBlobData( pdbHndl: pisc_db_handle;
                           ptrHndl: pisc_tr_handle;
                           AVAR: PXSQLVAR;
                           BlobNode: PIB_BlobNode;
                           AEv: TIB_BlobCallbackEvent ): longint;
  function SysGetArrayData( pdbHndl: pisc_db_handle;
                            ptrHndl: pisc_tr_handle;
                            AVAR: PXSQLVAR;
                            ArrayDesc: PISC_ARRAY_DESC;
                            BlobNode: PIB_BlobNode ): longint;
  function SysPutArrayData( pdbHndl: pisc_db_handle;
                            ptrHndl: pisc_tr_handle;
                            AVAR: PXSQLVAR;
                            ArrayDesc: PISC_ARRAY_DESC;
                            BlobNode: PIB_BlobNode ): longint;
protected
{ Event and Link management }
  procedure DoHandleError(       Sender: TObject;
                           const errcode: longint;
                                 ErrorMessage,
                                 ErrorCodes: TStringList;
                           const SQLCODE: longint;
                                 SQLMessage,
                                 SQL: TStringList;
                             var RaiseException: boolean ); virtual;
public

{: Raw access to the return code that should be used for all API calls.}
  errcode: isc_status;
{: Raw access to the status code vector used in most all API calls.}
  status: status_vector;

{$I IB_Session.PBL }

{: The native OS handle obtained when dynamically binding to GDS32.DLL.}
  class function GDS_Handle: THandle;

{ Methods }

{: This method will add/modify/delete a user to the server specified.}
  procedure AlterUser(       Action: TIB_AlterUserAction;
                             AProtocol: TIB_Protocol;
                       const AServer,
                             ADBAUser,
                             ADBAPass,
                             AUserName,
                             AUserPass,
                             AGroupName,
                             AFirstName,
                             AMiddleName,
                             ALastName: string );
{: Use the procedure to do a low level comparison of BLOB contents without
forcing the entire contents of the Blobs into memory. It will also respect
blobs which have already been loaded into memory in the BlobNode.}
  function BlobsEqual( pdbHndl1, pdbHndl2: pisc_db_handle;
                       ptrHndl1, ptrHndl2: pisc_tr_handle;
                       AVAR1, AVAR2: PXSQLVAR;
                       BlobID1, BlobID2: isc_quad;
                       BlobNode1, BlobNode2: PIB_BlobNode;
                       AEv1: TIB_BlobCallbackEvent;
                       AEv2: TIB_BlobCallbackEvent ): boolean;
{: This method is used to create an empty InterBase database file.
<br><br>
Please see IB documentaion for information on these parameters.}
  procedure CreateDatabase( Database, Username, Password: string;
                            PageSize: word;
                            CharSet: string;
                            SQLDialect: word );
{: This method will return affected rows for a statement handle if executed.}
  class function GetRowsAffected( st_hnd: pisc_stmt_handle ): TIB_RowsAffected;
{: This function is udes to construct the necessary user security structure
for passing information to the server to add, modify and delete users from the
server.}
  function GetUserSec(       Action: TIB_AlterUserAction;
                             AProtocol: TIB_Protocol;
                       const AServer,
                             ADBAUser,
                             ADBAPass,
                             AUserName,
                             AUserPass,
                             AGroupName,
                             AFirstName,
                             AMiddleName,
                             ALastName: string ): USER_SEC_DATA;
{: This method will access the IB6 (only) service routines to discover
the location of the ISC4 database from the given server.}
  function GetISC4Path( const AServer: string;
                              AProtocol: TIB_Protocol;
                        const AUserName,
                              AUserPass: string ): string;
{: This method is used to check the most recent errcode returned from an API
call. If an exception code was returned then it will be interpreted and the
error processing events will be triggered.
<br><br>
In most cases, a call to this method with an errcode of less than zero will
result in a Delphi exception being raised.}
  procedure HandleException( Sender: TObject );
{: This function gets data from a BLOB ID and streams it into a memory buffer.}
  function GetBlobData( pdbHndl: pisc_db_handle;
                        ptrHndl: pisc_tr_handle;
                        AVAR: PXSQLVAR;
                        ArrayDesc: PISC_ARRAY_DESC;
                        BlobNode: PIB_BlobNode;
                        AEv: TIB_BlobCallbackEvent ): longint;
{: This function created a new BLOB ID based on a binary data buffer.}
  function PutBlobData( pdbHndl: pisc_db_handle;
                        ptrHndl: pisc_tr_handle;
                        AVAR: PXSQLVAR;
                        ArrayDesc: PISC_ARRAY_DESC;
                        BlobNode: PIB_BlobNode;
                        AEv: TIB_BlobCallbackEvent ): longint;
{: This method is used to get the dimensions of an open blob.}
  procedure GetBlobSize( var   MaxSegmentSize,
                               TotalSize,
                               NumSegments: longint;
                         const PBlob_Handle: PISC_BLOB_HANDLE;
                         const PSQLVAR: PXSQLVAR );
{: This method sends a string to the IB_Monitor output.  The supplied text will
be inserted into the SQL Monitor output if the monitor is displaying client
trace activity.
<br><br>
By placing calls to this method into program code, the developer can make
it easier to locate SQL monitor output related to given program activity.}
  procedure OutputToMonitor( const AString: string );
{: This function returns true if there are hooks engaged to monitor any
activity created by calls to the OutputToMonitor() method.  This can be
used to reduce the impact of trace code when an IB_Monitor is not in use.
<br>
<br>e.g.
<br>  with TheComponent do begin
<br>    if IB_Session.ClientMonitorHooksIn then begin
<br>      IB_Session.OutputToMonitor( 'Something important happened!' );
<br>    end;
<br>  end;}
  function ClientMonitorHooksIn: boolean;
{: This method triggers profiler difference reports to the IB_Monitor output
if it is monitoring such activity.  In general, the first call to this method
will mark the starting point for the profiler.  Subsequent calls will produce
a difference report with respect to the previous call.
<br><br>
Note that each IB_Monitor component has an internal instance of the IB_Profiler
component, and each IB_Profiler is associated with a specific connection. To
profile the activity of several simultaneaous connections using monitor
components, use multiple IB_Monitor instances with profiler connections set
appropriately on each.
<br><br>
By placing calls to this method into program code, the developer can increase
the frequency that profile reports are generated in the SQL monitor output.
For example, calls to this method could be placed around and throughout an
interesting piece of code such that more detailed investigation of resource
usage can be done.
<br><br>
Difference reports are automatically generated in the SQL Monitor trace for
the following API calls:
<br>  Start transaction (before)
<br>    isc_start_multiple
<br>  Commit, commit retaining, rollback (after)
<br>    isc_commit_retaining
<br>    isc_commit_transaction
<br>    isc_rollback_transaction
<br>  Prepare (before and after)
<br>    isc_dsql_prepare
<br>  Execute (before and after)
<br>    isc_dsql_execute
<br>    isc_dsql_execute2
<br>    isc_dsql_execute_immediate
<br>    isc_dsql_exec_immed2
<br>
Note that fetching of records does not automatically trigger profiler
difference reports in the monitor trace, so calling this method in such areas
of program code may be useful.}
  procedure ProfileToMonitor( const AComment: string );

{ Properties }

{: Most recent SQLCODE interpreted as a result of a call to
HandleException().}
  property SQLCODE: longint read FSQLCODE;

{: Event used to handle and API errcode returned and customize behavior.
<br><br>
Could be an ideal place to feed error data into an errlog of some kind.}
  property OnError: TIB_ErrorEvent read FOnError write FOnError;

end;

{: This method is used by the IB_Monitor to remove its intercepting hooks
so that the API calls are no longer diverted into the functions that feed
the IB_Monitor output. This should not be called in any other cases.}
procedure RevertToOriginalHooks;
  
{: This method will return a PLAN from a statement handle.}
function GetStatementPlanFromHandle( st_hnd: pisc_stmt_handle ): string;
procedure AcquireOriginalHooks;
procedure ClearBlobNodeData( BlobNode: PIB_BlobNode );
procedure FreeBlobNodeData( BlobNode: PIB_BlobNode );
procedure FreeBlobRefList( PBlobHead: PPIB_BlobNode );
function FindBlobNodeInList(     PBlobHead: PPIB_BlobNode;
                                 BlobID: isc_quad;
                                 BlobFieldNo: word;
                                 ByBlobIDOnly: boolean;
                             var ParentBlobRef: PIB_BlobNode ): PIB_BlobNode;
procedure PutBlobNodeIntoList( PBlobHead: PPIB_BlobNode;
                               BlobNode: PIB_BlobNode;
                               ClearSourceNode: boolean );
function GetBlobNodeFromList( PBlobHead: PPIB_BlobNode;
                              ByBlobIDOnly: boolean;
                              BlobNode: PIB_BlobNode ): boolean;
procedure TransferBlobNodeData( Src, Dst: PIB_BlobNode;
                                ClearSourceNode: boolean );
function GetArrayBufferLength( ArrayDesc: PISC_ARRAY_DESC ): longint;
function ConnectionLostErrcode( const AErrCode: integer ): boolean;

{$IFNDEF HELPSCAN}
var
  AttachCS: TRTLCriticalSection;
  GlobalCS: TRTLCriticalSection;
  dll_attach_database:          Tisc_attach_database;
  dll_detach_database:          Tisc_detach_database;
  dll_drop_database:            Tisc_drop_database;
  dll_create_database:          Tisc_create_database;
  dll_array_gen_sdl:            Tisc_array_gen_sdl;
  dll_array_get_slice:          Tisc_array_get_slice;
  dll_array_lookup_bounds:      Tisc_array_lookup_bounds;
  dll_array_lookup_desc:        Tisc_array_lookup_desc;
  dll_array_set_desc:           Tisc_array_set_desc;
  dll_array_put_slice:          Tisc_array_put_slice;
  dll_blob_default_desc:        Tisc_blob_default_desc;
  dll_blob_gen_bpb:             Tisc_blob_gen_bpb;
  dll_blob_info:                Tisc_blob_info;
  dll_blob_lookup_desc:         Tisc_blob_lookup_desc;
  dll_blob_set_desc:            Tisc_blob_set_desc;
  dll_cancel_blob:              Tisc_cancel_blob;
  dll_cancel_events:            Tisc_cancel_events;
  dll_close_blob:               Tisc_close_blob;
  dll_commit_retaining:         Tisc_commit_retaining;
  dll_commit_transaction:       Tisc_commit_transaction;
  dll_create_blob:              Tisc_create_blob;
  dll_create_blob2:             Tisc_create_blob2;
  dll_database_info:            Tisc_database_info;
  dll_decode_date:              Tisc_decode_date;
  dll_encode_date:              Tisc_encode_date;
  dll_event_block:              Tisc_event_block;
  dll_event_counts:             Tisc_event_counts;
  dll_free:                     Tisc_free;
  dll_get_segment:              Tisc_get_segment;
  dll_get_slice:                Tisc_get_slice;
  dll_interprete:               Tisc_interprete;
  dll_sql_interprete:           Tisc_sql_interprete;
  dll_open_blob:                Tisc_open_blob;
  dll_open_blob2:               Tisc_open_blob2;
  dll_put_segment:              Tisc_put_segment;
  dll_put_slice:                Tisc_put_slice;
  dll_que_events:               Tisc_que_events;
  dll_rollback_transaction:     Tisc_rollback_transaction;
  dll_rollback_retaining:       Tisc_rollback_retaining;
  dll_start_multiple:           Tisc_start_multiple;
  dll_sqlcode:                  Tisc_sqlcode;
  dll_transaction_info:         Tisc_transaction_info;
  dll_transact_request:         Tisc_transact_request;
  dll_wait_for_event:           Tisc_wait_for_event;
  dll_vax_integer:              Tisc_vax_integer;
  dll_portable_integer:         Tisc_portable_integer;
  dll_compile_request:          Tisc_compile_request;
  dll_compile_request2:         Tisc_compile_request2;
  dll_send:                     Tisc_send;
  dll_start_and_send:           Tisc_start_and_send;
  dll_start_request:            Tisc_start_request;
  dll_unwind_request:           Tisc_unwind_request;
  dll_receive:                  Tisc_receive;
  dll_release_request:          Tisc_release_request;
  dll_service_attach:           Tisc_service_attach;
  dll_service_detach:           Tisc_service_detach;
  dll_service_query:            Tisc_service_query;
  dll_service_start:            Tisc_service_start;
  dll_add_user:                 Tisc_add_user;
  dll_delete_user:              Tisc_delete_user;
  dll_modify_user:              Tisc_modify_user;
  dll_dsql_execute:             Tisc_dsql_execute;
  dll_dsql_execute2:            Tisc_dsql_execute2;
  dll_dsql_execute_immediate:   Tisc_dsql_execute_immediate;
  dll_dsql_exec_immed2:         Tisc_dsql_exec_immed2;
  dll_dsql_allocate_statement:  Tisc_dsql_allocate_statement;
  dll_dsql_alloc_statement2:    Tisc_dsql_alloc_statement2;
  dll_dsql_free_statement:      Tisc_dsql_free_statement;
  dll_dsql_prepare:             Tisc_dsql_prepare;
//  dll_dsql_insert:              Tisc_dsql_insert;
  dll_dsql_set_cursor_name:     Tisc_dsql_set_cursor_name;
  dll_dsql_describe:            Tisc_dsql_describe;
  dll_dsql_describe_bind:       Tisc_dsql_describe_bind;
  dll_dsql_fetch:               Tisc_dsql_fetch;
  dll_dsql_sql_info:            Tisc_dsql_sql_info;

// Hooks for monitor interrupt to be put in.  
  isc_attach_database:          Tisc_attach_database;
  isc_detach_database:          Tisc_detach_database;
  isc_drop_database:            Tisc_drop_database;
  isc_create_database:          Tisc_create_database;
  isc_array_gen_sdl:            Tisc_array_gen_sdl;
  isc_array_get_slice:          Tisc_array_get_slice;
  isc_array_lookup_bounds:      Tisc_array_lookup_bounds;
  isc_array_lookup_desc:        Tisc_array_lookup_desc;
  isc_array_set_desc:           Tisc_array_set_desc;
  isc_array_put_slice:          Tisc_array_put_slice;
  isc_blob_default_desc:        Tisc_blob_default_desc;
  isc_blob_gen_bpb:             Tisc_blob_gen_bpb;
  isc_blob_info:                Tisc_blob_info;
  isc_blob_lookup_desc:         Tisc_blob_lookup_desc;
  isc_blob_set_desc:            Tisc_blob_set_desc;
  isc_cancel_blob:              Tisc_cancel_blob;
  isc_cancel_events:            Tisc_cancel_events;
  isc_close_blob:               Tisc_close_blob;
  isc_commit_retaining:         Tisc_commit_retaining;
  isc_commit_transaction:       Tisc_commit_transaction;
  isc_create_blob:              Tisc_create_blob;
  isc_create_blob2:             Tisc_create_blob2;
  isc_database_info:            Tisc_database_info;
  isc_decode_date:              Tisc_decode_date;
  isc_encode_date:              Tisc_encode_date;
  isc_event_block:              Tisc_event_block;
  isc_event_counts:             Tisc_event_counts;
  isc_free:                     Tisc_free;
  isc_get_segment:              Tisc_get_segment;
  isc_get_slice:                Tisc_get_slice;
  isc_interprete:               Tisc_interprete;
  isc_sql_interprete:           Tisc_sql_interprete;
  isc_open_blob:                Tisc_open_blob;
  isc_open_blob2:               Tisc_open_blob2;
  isc_put_segment:              Tisc_put_segment;
  isc_put_slice:                Tisc_put_slice;
  isc_que_events:               Tisc_que_events;
  isc_rollback_transaction:     Tisc_rollback_transaction;
  isc_rollback_retaining:       Tisc_rollback_retaining;
  isc_start_multiple:           Tisc_start_multiple;
  isc_sqlcode:                  Tisc_sqlcode;
  isc_transaction_info:         Tisc_transaction_info;
  isc_transact_request:         Tisc_transact_request;
  isc_wait_for_event:           Tisc_wait_for_event;
  isc_vax_integer:              Tisc_vax_integer;
  isc_portable_integer:         Tisc_portable_integer;
  isc_dsql_execute:             Tisc_dsql_execute;
  isc_dsql_execute2:            Tisc_dsql_execute2;
  isc_dsql_execute_immediate:   Tisc_dsql_execute_immediate;
  isc_dsql_exec_immed2:         Tisc_dsql_exec_immed2;
  isc_dsql_allocate_statement:  Tisc_dsql_allocate_statement;
  isc_dsql_alloc_statement2:    Tisc_dsql_alloc_statement2;
  isc_dsql_free_statement:      Tisc_dsql_free_statement;
  isc_dsql_prepare:             Tisc_dsql_prepare;
//  isc_dsql_insert:              Tisc_dsql_insert;
  isc_dsql_set_cursor_name:     Tisc_dsql_set_cursor_name;
  isc_dsql_describe:            Tisc_dsql_describe;
  isc_dsql_describe_bind:       Tisc_dsql_describe_bind;
  isc_dsql_sql_info:            Tisc_dsql_sql_info;
  { Used for fetching rows. Performance intensive for SQL monitor. }
  isc_dsql_fetch:               Tisc_dsql_fetch;
  isc_dsql_row_fetch:           Tisc_dsql_execute;
  isc_dsql_row_fetch2:          Tisc_dsql_execute2;
  isc_dsql_set_row_cursor_name: Tisc_dsql_set_cursor_name;
  isc_dsql_free_row_statement:  Tisc_dsql_free_statement;

  monitor_client_trace_method: procedure( const AString: string );
  monitor_profile_method: procedure( const AComment: string );
  
{$ENDIF}

procedure ReserveSessionHookRef;
procedure ReleaseSessionHookRef;

var
  FGDS_Handle: THandle = 0;
  FGDS_RefCount: integer = -1;
{$IFDEF ALLOW_DEFAULT_SESSION}
  hDefaultSession: THandle = 0;
{$ENDIF}
{$IFDEF ALLOW_ALT_SESSION}
  hAlternateSession: THandle = 0;
{$ENDIF}

implementation

uses
  IB_Utils, IB_Parse, IBD_Error;

procedure BypassMonitorClientTrace( const AString: string ); forward;
procedure BypassMonitorProfile( const AComment: string ); forward;

class function TIB_SessionBase.GDS_Handle: THandle;
begin
  Result := FGDS_Handle;
end;

function stub_add_user( status: pstatus_vector;
                        UserSecData: PUSER_SEC_DATA ): isc_long; stdcall;
begin
  raise EIB_Error.Create( 'isc_add_user() not implemented' );
end;

function stub_delete_user( status: pstatus_vector;
                           UserSecData: PUSER_SEC_DATA ): isc_long; stdcall;
begin
  raise EIB_Error.Create( 'isc_delete_user() not implemented' );
end;

function stub_modify_user( status: pstatus_vector;
                           UserSecData: PUSER_SEC_DATA ): isc_long; stdcall;
begin
  raise EIB_Error.Create( 'isc_modify_user() not implemented' );
end;

function stub_service_attach( status:          pstatus_vector;
                              svc_name_len:    short;
                              svc_name:        pchar;
                              svc_handle:      pisc_svc_handle;
                              parm_buffer_len: short;
                              parm_buffer:     pchar
                              ):               ISC_STATUS; stdcall;
begin
  raise EIB_Error.Create( 'isc_service_attach() not implemented' );
end;

function stub_service_detach( status:     pstatus_vector;
                              svc_handle: pisc_svc_handle
                              ):          ISC_STATUS; stdcall;
begin
  raise EIB_Error.Create( 'isc_service_dettach() not implemented' );
end;

function stub_service_query( status: pstatus_vector;
                             svc_handle: pisc_svc_handle;
                             recv_handle: pisc_svc_handle;
                             isc_arg4: short;
                             isc_arg5: pchar;
                             isc_arg6: short;
                             isc_arg7: pchar;
                             isc_arg8: short;
                             isc_arg9: pchar ): ISC_STATUS; stdcall;
begin
  raise EIB_Error.Create( 'isc_service_query() not implemented' );
end;

function stub_service_start( status: pstatus_vector;
                             svc_handle: pisc_svc_handle;
                             recv_handle: pisc_svc_handle;
                             isc_arg4: short;
                             isc_arg5: pchar ): ISC_STATUS; stdcall;
begin
  raise EIB_Error.Create( 'isc_service_start() not implemented' );
end;

function stub_portable_integer( a: pbyte;
                                b: short): ISC_INT64; stdcall;
begin
  raise EIB_Error.Create( 'isc_portable_integer() not implemented' );
end;

procedure GetProcAddr( var AddrPtr: pointer; const ProcName: string );
begin
  pointer( AddrPtr ) := GetProcAddress( FGDS_Handle, PChar(ProcName));
  if pointer( AddrPtr ) = nil then
    raise EIB_Error.Create( Format(E_UNABLE_TO_LOCATE_DLL_IMPORT, [ProcName]));
end;

procedure AcquireOriginalHooks;
var
  SaveCW: word;
begin
  if FGDS_Handle < 32 then
  begin
    asm fstcw [SaveCW] end;
    FGDS_Handle := LoadLibrary( pchar(IB_GDS32) );
    asm fldcw [SaveCW] end;
  end;
  if FGDS_Handle < 32 then Exit;
  asm fstcw [SaveCW] end;
  GetProcAddr( @dll_array_gen_sdl,            'isc_array_gen_sdl');
  GetProcAddr( @dll_array_get_slice,          'isc_array_get_slice');
  GetProcAddr( @dll_array_lookup_bounds,      'isc_array_lookup_bounds');
  GetProcAddr( @dll_array_lookup_desc,        'isc_array_lookup_desc');
  GetProcAddr( @dll_array_set_desc,           'isc_array_set_desc');
  GetProcAddr( @dll_array_put_slice,          'isc_array_put_slice');
  GetProcAddr( @dll_blob_default_desc,        'isc_blob_default_desc');
  GetProcAddr( @dll_blob_gen_bpb,             'isc_blob_gen_bpb');
  GetProcAddr( @dll_blob_info,                'isc_blob_info');
  GetProcAddr( @dll_blob_lookup_desc,         'isc_blob_lookup_desc');
  GetProcAddr( @dll_blob_set_desc,            'isc_blob_set_desc');
  GetProcAddr( @dll_cancel_blob,              'isc_cancel_blob');
  GetProcAddr( @dll_close_blob,               'isc_close_blob');
  GetProcAddr( @dll_create_blob,              'isc_create_blob');
  GetProcAddr( @dll_create_blob2,             'isc_create_blob2');
  GetProcAddr( @dll_open_blob,                'isc_open_blob');
  GetProcAddr( @dll_open_blob2,               'isc_open_blob2');
  GetProcAddr( @dll_put_segment,              'isc_put_segment');
  GetProcAddr( @dll_put_slice,                'isc_put_slice');
  GetProcAddr( @dll_get_segment,              'isc_get_segment');
  GetProcAddr( @dll_get_slice,                'isc_get_slice');
  GetProcAddr( @dll_attach_database,          'isc_attach_database');
  GetProcAddr( @dll_create_database,          'isc_create_database');
  GetProcAddr( @dll_detach_database,          'isc_detach_database');
  GetProcAddr( @dll_drop_database,            'isc_drop_database');
  GetProcAddr( @dll_database_info,            'isc_database_info');
  GetProcAddr( @dll_start_multiple,           'isc_start_multiple');
  GetProcAddr( @dll_commit_transaction,       'isc_commit_transaction');
  GetProcAddr( @dll_commit_retaining,         'isc_commit_retaining');
  GetProcAddr( @dll_rollback_transaction,     'isc_rollback_transaction');
  GetProcAddr( @dll_transaction_info,         'isc_transaction_info');
  GetProcAddr( @dll_transact_request,         'isc_transact_request');
  GetProcAddr( @dll_dsql_execute_immediate,   'isc_dsql_execute_immediate');
  GetProcAddr( @dll_dsql_exec_immed2,         'isc_dsql_exec_immed2');
  GetProcAddr( @dll_dsql_execute,             'isc_dsql_execute');
  GetProcAddr( @dll_dsql_execute2,            'isc_dsql_execute2');
  GetProcAddr( @dll_dsql_allocate_statement,  'isc_dsql_allocate_statement');
  GetProcAddr( @dll_dsql_alloc_statement2,    'isc_dsql_alloc_statement2');
  GetProcAddr( @dll_dsql_prepare,             'isc_dsql_prepare');
  GetProcAddr( @dll_dsql_set_cursor_name,     'isc_dsql_set_cursor_name');
  GetProcAddr( @dll_dsql_describe,            'isc_dsql_describe');
  GetProcAddr( @dll_dsql_describe_bind,       'isc_dsql_describe_bind');
  GetProcAddr( @dll_dsql_fetch,               'isc_dsql_fetch');
  GetProcAddr( @dll_dsql_free_statement,      'isc_dsql_free_statement');
  GetProcAddr( @dll_dsql_sql_info,            'isc_dsql_sql_info');
  GetProcAddr( @dll_decode_date,              'isc_decode_date');
  GetProcAddr( @dll_encode_date,              'isc_encode_date');
  GetProcAddr( @dll_cancel_events,            'isc_cancel_events');
  GetProcAddr( @dll_event_counts,             'isc_event_counts');
  GetProcAddr( @dll_que_events,               'isc_que_events');
  GetProcAddr( @dll_event_block,              'isc_event_block');
  GetProcAddr( @dll_event_counts,             'isc_event_counts');
  GetProcAddr( @dll_interprete,               'isc_interprete');
  GetProcAddr( @dll_sql_interprete,           'isc_sql_interprete');
  GetProcAddr( @dll_free,                     'isc_free');
  GetProcAddr( @dll_sqlcode,                  'isc_sqlcode');
  GetProcAddr( @dll_vax_integer,              'isc_vax_integer');
  GetProcAddr( @dll_compile_request,          'isc_compile_request');
  GetProcAddr( @dll_compile_request2,         'isc_compile_request2');
  GetProcAddr( @dll_send,                     'isc_send');
  GetProcAddr( @dll_start_and_send,           'isc_start_and_send');
  GetProcAddr( @dll_start_request,            'isc_start_request');
  GetProcAddr( @dll_unwind_request,           'isc_unwind_request');
  GetProcAddr( @dll_receive,                  'isc_receive');
  GetProcAddr( @dll_release_request,          'isc_release_request');
  dll_service_attach := GetProcAddress( FGDS_Handle, 'isc_service_attach');
  dll_service_detach := GetProcAddress( FGDS_Handle, 'isc_service_detach');
  dll_service_query := GetProcAddress( FGDS_Handle, 'isc_service_query');
  dll_service_start := GetProcAddress( FGDS_Handle, 'isc_service_start');
  dll_add_user := GetProcAddress( FGDS_Handle, 'isc_add_user'    );
  dll_delete_user := GetProcAddress( FGDS_Handle, 'isc_delete_user' );
  dll_modify_user := GetProcAddress( FGDS_Handle, 'isc_modify_user' );
  dll_rollback_retaining := GetProcAddress( FGDS_Handle,
                                            'isc_rollback_retaining');
  dll_portable_integer := GetProcAddress( FGDS_Handle, 'isc_portable_integer');
  asm fldcw [SaveCW] end;
  if not Assigned( dll_add_user ) then dll_add_user := stub_add_user;
  if not Assigned( dll_delete_user ) then dll_delete_user := stub_delete_user;
  if not Assigned( dll_modify_user ) then dll_modify_user := stub_modify_user;
  if not Assigned( dll_service_attach ) then
    dll_service_attach := stub_service_attach;
  if not Assigned( dll_service_detach ) then
    dll_service_detach := stub_service_detach;
  if not Assigned( dll_service_query ) then
    dll_service_query := stub_service_query;
  if not Assigned( dll_service_start ) then
    dll_service_start := stub_service_start;
  if not Assigned( dll_portable_integer ) then
    dll_portable_integer := stub_portable_integer;
end;

constructor EIB_ISCError.CreateISC( Sender: TObject;
                                    MessageText: string;
                                    AERRCODE: longint;
                                    AErrorMessage: TStringList;
                                    AErrorCodes: TStringList;
                                    ASQLCODE: longint;
                                    ASQLMessage: TStringList;
                                    ASQL: TStringList );
var
  tmpTxt: string;
begin
  tmpTxt := MessageText;
  if Length( tmpTxt ) > 255 then
    SetLength( tmpTxt, 255 );
  inherited Create( tmpTxt );
  FSender := Sender;
  FERRCODE := AERRCODE;
  FErrorMessage := TStringList.Create;
  FErrorCodes := TStringList.Create;
  FSQLCODE := ASQLCODE;
  FSQLMessage := TStringList.Create;
  FSQL := TStringList.Create;
  FErrorMessage.Assign( AErrorMessage );
  FErrorCodes.Assign( AErrorCodes );
  FSQLMessage.Assign( AsqlMessage );
  FSQL.Assign( ASQL );
end;

destructor EIB_ISCError.Destroy;
begin
  FErrorMessage.Free;
  FErrorMessage := nil;
  FErrorCodes.Free;
  FErrorCodes := nil;
  FSQLMessage.Free;
  FSQLMessage := nil;
  FSQL.Free;
  FSQL := nil;
  inherited Destroy;
end;

procedure EIB_ISCError.ShowDialog;
var
  tmpStr: string;
  tmpPos: integer;
  tmpLine, tmpChar: integer;
begin
  with TdlgError.Create( nil ) do try
    meError.Lines.Text := Trim( AdjustLineBreaks( ErrorMessage.Text ));
    meSQLMsg.Lines.Text := Trim( AdjustLineBreaks( SQLMessage.Text ));
    meSQL.Lines.Text := Trim( AdjustLineBreaks( SQL.Text ));
    if meSQLMsg.Lines.Count = 0 then
      tsSQLMsg.TabVisible := false;
    if meSQL.Lines.Count = 0 then
      tsSQL.TabVisible := false;
    pcError.ActivePage := tsErrorMsg;
    tmpLine := 0;
    tmpChar := 0;
    if meError.Lines.Count > 5 then
    begin
      tmpStr := meError.Lines[ 5 ];
      tmpPos := Pos( 'line', tmpStr );
      if tmpPos > 0 then
      begin
        tmpStr := Copy( tmpStr, tmpPos + 4, MaxInt );
        tmpPos := Pos( ',', tmpStr );
        if tmpPos > 0 then
        begin
          tmpLine := StrToInt( Trim( Copy( tmpStr, 1, tmpPos - 1 )));
          tmpStr := Copy( tmpStr, tmpPos + 6, MaxInt );
          tmpChar := StrToInt( Trim( tmpStr ));
        end;
      end;
    end;
    if ( tmpLine > 0 ) and ( tmpChar > 0 ) then
    begin
      tmpLine := SendMessage( meSQL.Handle, EM_LINEINDEX, tmpLine - 1, 0 );
      if tmpLine >= 0 then
      begin
        meSQL.SelStart := tmpLine + tmpChar;
        SendMessage( meSQL.Handle, EM_SCROLLCARET, 0, 0 );
      end;
    end;
    ShowModal;
  finally
    Free;
  end;
end;

procedure RevertToOriginalHooks;
begin
{ These are used as separate pointers for monitor efficiency. }
  isc_dsql_row_fetch :=           dll_dsql_execute;
  isc_dsql_row_fetch2 :=          dll_dsql_execute2;
  isc_dsql_set_row_cursor_name := dll_dsql_set_cursor_name;
  isc_dsql_free_row_statement :=  dll_dsql_free_statement;
{ These hooks are used as a direct bypass to the DLL }
  isc_array_gen_sdl :=            dll_array_gen_sdl;
  isc_array_get_slice :=          dll_array_get_slice;
  isc_array_lookup_bounds :=      dll_array_lookup_bounds;
  isc_array_lookup_desc :=        dll_array_lookup_desc;
  isc_array_set_desc :=           dll_array_set_desc;
  isc_array_put_slice :=          dll_array_put_slice;
  isc_blob_default_desc :=        dll_blob_default_desc;
  isc_blob_gen_bpb :=             dll_blob_gen_bpb;
  isc_blob_info :=                dll_blob_info;
  isc_blob_lookup_desc :=         dll_blob_lookup_desc;
  isc_blob_set_desc :=            dll_blob_set_desc;
  isc_cancel_blob :=              dll_cancel_blob;
  isc_close_blob :=               dll_close_blob;
  isc_create_blob :=              dll_create_blob;
  isc_create_blob2 :=             dll_create_blob2;
  isc_open_blob :=                dll_open_blob;
  isc_open_blob2 :=               dll_open_blob2;
  isc_put_segment :=              dll_put_segment;
  isc_put_slice :=                dll_put_slice;
  isc_get_segment :=              dll_get_segment;
  isc_get_slice :=                dll_get_slice;
  isc_attach_database :=          dll_attach_database;
  isc_create_database :=          dll_create_database;
  isc_detach_database :=          dll_detach_database;
  isc_drop_database :=            dll_drop_database;
  isc_database_info :=            dll_database_info;
  isc_start_multiple :=           dll_start_multiple;
  isc_commit_transaction :=       dll_commit_transaction;
  isc_commit_retaining :=         dll_commit_retaining;
  isc_rollback_transaction :=     dll_rollback_transaction;
  isc_rollback_retaining :=       dll_rollback_retaining;
  isc_transaction_info :=         dll_transaction_info;
  isc_transact_request :=         dll_transact_request;
  isc_dsql_execute_immediate :=   dll_dsql_execute_immediate;
  isc_dsql_exec_immed2 :=         dll_dsql_exec_immed2;
  isc_dsql_execute :=             dll_dsql_execute;
  isc_dsql_execute2 :=            dll_dsql_execute2;
  isc_dsql_allocate_statement :=  dll_dsql_allocate_statement;
  isc_dsql_alloc_statement2 :=    dll_dsql_alloc_statement2;
  isc_dsql_prepare :=             dll_dsql_prepare;
  isc_dsql_set_cursor_name :=     dll_dsql_set_cursor_name;
  isc_dsql_describe :=            dll_dsql_describe;
  isc_dsql_describe_bind :=       dll_dsql_describe_bind;
  isc_dsql_fetch :=               dll_dsql_fetch;
  isc_dsql_free_statement :=      dll_dsql_free_statement;
  isc_dsql_sql_info :=            dll_dsql_sql_info;
  isc_decode_date :=              dll_decode_date;
  isc_encode_date :=              dll_encode_date;
  isc_cancel_events :=            dll_cancel_events;
  isc_event_counts :=             dll_event_counts;
  isc_que_events :=               dll_que_events;
  isc_event_block :=              dll_event_block;
  isc_event_counts :=             dll_event_counts;
  isc_interprete :=               dll_interprete;
  isc_sql_interprete :=           dll_sql_interprete;
  isc_free :=                     dll_free;
  isc_sqlcode :=                  dll_sqlcode;
  isc_vax_integer :=              dll_vax_integer;
  isc_portable_integer :=         dll_portable_integer;
  isc_wait_for_event :=           dll_wait_for_event;

{ These hooks are used for client trace output to monitor. }
  monitor_client_trace_method :=  BypassMonitorClientTrace;
  monitor_profile_method :=       BypassMonitorProfile;
end;

procedure BypassMonitorClientTrace( const AString: string );
begin
  // dummy method used to bypass output to the IB_Monitor -- nothing here
end;

procedure BypassMonitorProfile( const AComment: string );
begin
  // dummy method used to bypass output to the IB_Monitor -- nothing here
end;

procedure TIB_SessionBase.OutputToMonitor( const AString: string );
begin
  monitor_client_trace_method( AString );
end;

procedure TIB_SessionBase.ProfileToMonitor( const AComment: string );
begin
  monitor_profile_method( AComment );
end;

function TIB_SessionBase.ClientMonitorHooksIn: boolean;
begin
  Result := Addr(monitor_client_trace_method) <>
            Addr(BypassMonitorClientTrace);
end;

procedure TIB_SessionBase.HandleException( Sender: TObject );
var
  Buffer: array[0..4095] of char;
  LastErrorMsg: string;
  RExcept: Boolean;
  pstatus: pstatus_vector;
  error_messages: TStringList;
  error_codes: TStringList;
  error_code: integer;
  sql_messages: TStringList;
  sql_text: TStringList;
  ii: integer;
  tmpText: string;
  MonitorText: string;
var
  SaveCW: word;
begin
  if not Assigned( isc_interprete ) then
    raise EIB_Error.Create( E_IB_Client_Not_Installed );
  RExcept := errcode <> 0;
  pstatus := @status;
  error_messages := TStringList.Create;
  error_codes := TStringList.Create;
  sql_messages := TStringList.Create;
  sql_text := TStringList.Create;
  try
    error_messages.Add( IB_ISC_ERR_CODE_MSG + IntToStr( ERRCODE ));
    error_messages.Add( '' );
    error_messages.Add( IB_ISC_ERR_MSG_MSG );
    ii := 0;
    repeat
      asm fstcw [SaveCW] end;
      error_code := isc_interprete( @Buffer, @pstatus );
      asm fldcw [SaveCW] end;
      Inc( ii );
      if LastErrorMsg <> Trim( strPas( Buffer)) then
      begin
        LastErrorMsg := Trim( strPas( Buffer ));
        error_messages.Add( LastErrorMsg );
      end;
      error_codes.Add( IntToStr( status[ii] ));
    until error_code = 0;
    asm fstcw [SaveCW] end;
    FSQLCODE := isc_sqlcode( @status );
    asm fldcw [SaveCW] end;
    if (FSQLCODE <> -999) and (FSQLCODE <> 0) then
    begin
      isc_sql_interprete( SQLCODE, @Buffer, 4096 );
      if LastErrorMsg <> Trim( strPas( Buffer )) then
      begin
        sql_messages.Add( IB_SQL_ERR_CODE_MSG + IntToStr( SQLCODE ));
        sql_messages.Add( '' );
        sql_messages.Add( IB_SQL_ERR_MSG_MSG );
        sql_messages.Add( Trim( strPas( Buffer )));
      end;
    end;
    if ( SQLCODE = -836 ) and ( error_messages.Count > 2 ) then
      tmpText := error_messages[ 4 ]
    else
      tmpText := error_messages.Text;
    DoHandleError( Sender,
                   errcode,
                   error_messages,
                   error_codes,
                   SQLCODE,
                   sql_messages,
                   sql_text,
                   RExcept );
    if ClientMonitorHooksIn then
    begin
      MonitorText :=
          '//>>> ERROR <<<//' + #13#10 +
          Trim( AdjustLineBreaks( error_messages.Text ));
      if sql_messages.Count > 0 then
        MonitorText := MonitorText + #13#10#13#10 +
          '//>>> SQL MESSAGE <<<//' + #13#10 +
          Trim( AdjustLineBreaks( sql_messages.Text ));
      if sql_text.Count > 0 then
        MonitorText := MonitorText + #13#10#13#10 +
          '//>>> SQL <<<//' + #13#10 +
          Trim( AdjustLineBreaks( sql_text.Text ));
      OutputToMonitor( MonitorText );
    end;
    if RExcept then
       raise EIB_ISCError.CreateISC( Sender,
                                    tmpText,
                                    errcode,
                                    error_messages,
                                    error_codes,
                                    SQLCODE,
                                    sql_messages,
                                    sql_text );
  finally
    error_messages.Free;
    error_codes.Free;
    sql_messages.Free;
    sql_text.Free;
  end;
end;

procedure TIB_SessionBase.DoHandleError(       Sender: TObject;
                                         const errcode: longint;
                                               ErrorMessage,
                                               ErrorCodes: TStringList;
                                         const SQLCODE: longint;
                                               SQLMessage,
                                               SQL: TStringList;
                                           var RaiseException: boolean);
begin
  if Assigned( FOnError ) then
    FOnError( Self,
              errcode,
              ErrorMessage,
              ErrorCodes,
              SQLCODE,
              SQLMessage,
              SQL,
              RaiseException );
end;

function TIB_SessionBase.GetUserSec( Action: TIB_AlterUserAction;
                                     AProtocol: TIB_Protocol;
                                     const
                                     AServer,
                                     ADBAUser,
                                     ADBAPass,
                                     AUserName,
                                     AUserPass,
                                     AGroupName,
                                     AFirstName,
                                     AMiddleName,
                                     ALastName: string ): USER_SEC_DATA;
var
  SysUserName: string;
  SysPassword: string;
begin
  case Action of
    uaAddUser: if Trim( AUserName ) = '' then begin
      raise EIB_Error.Create( E_Cannot_add_blank_account );
    end else if UpperCase( Trim( AUserName )) = 'SYSDBA' then begin
      raise EIB_Error.Create( E_Cannot_add_SYSDBA_account );
    end;
    uaDeleteUser: if Trim( AUserName ) = '' then begin
      raise EIB_Error.Create( E_Cannot_delete_blank_account );
    end else if UpperCase( Trim( AUserName )) = 'SYSDBA' then begin
      raise EIB_Error.Create( E_Cannot_delete_SYSDBA_account );
    end;
    uaModifyUser: if Trim( AUserName ) = '' then begin
      raise EIB_Error.Create( E_Cannot_modify_blank_account );
    end;
  end;
  with Result do begin
    uid := 0;
    gid := 0;
    sec_flags := 0;
    protocol := sec_protocol_local;
    if AServer <> '' then case AProtocol of
      cpNetBEUI: protocol := sec_protocol_netbeui;
      cpTCP_IP:  protocol := sec_protocol_tcpip;
      cpNovell:  protocol := sec_protocol_spx;
    end;
    server := PChar( AServer );
    if protocol <> sec_protocol_local then begin
      sec_flags := sec_flags or sec_server_spec;
    end;
    user_name := pchar( AUserName );
    password := pchar( AUserPass );
    if AUserPass <> '' then begin
      sec_flags := sec_flags or sec_password_spec;
    end;
    group_name := pchar( AGroupName );
    if AGroupName <> '' then begin
      sec_flags := sec_flags or sec_group_name_spec;
    end;
    first_name := pchar( AFirstName );
    if AFirstName <> '' then begin
      sec_flags := sec_flags or sec_first_name_spec;
    end;
    middle_name := pchar( AMiddleName );
    if AMiddleName <> '' then begin
      sec_flags := sec_flags or sec_middle_name_spec;
    end;
    last_name := pchar( ALastName );
    if ALastName <> '' then begin
      sec_flags := sec_flags or sec_last_name_spec;
    end;
    SysUsername := ADBAUser;
    if SysUsername = '' then
      SysUsername := GetEnvVariable( 'ISC_USER' );
    SysPassword := ADBAPass;
    if SysPassword = '' then
      SysPassword := GetEnvVariable( 'ISC_PASSWORD' );
    dba_user_name := pchar( SysUsername );
    if SysUserName <> '' then begin
      sec_flags := sec_flags or sec_dba_user_name_spec;
    end;
    dba_password := pchar( SysPassword );
    if SysPassword <> '' then begin
      sec_flags := sec_flags or sec_dba_password_spec;
    end;
  end;
end;

procedure TIB_SessionBase.AlterUser(       Action: TIB_AlterUserAction;
                                           AProtocol: TIB_Protocol;
                                     const AServer,
                                           ADBAUser,
                                           ADBAPass,
                                           AUserName,
                                           AUserPass,
                                           AGroupName,
                                           AFirstName,
                                           AMiddleName,
                                           ALastName: string );
var
  tmpSec: USER_SEC_DATA;
  SaveCW: word;
begin
  tmpSec := GetUserSec( Action,
                        AProtocol,
                        AServer,
                        ADBAUser,
                        ADBAPass,
                        AUserName,
                        AUserPass,
                        AGroupName,
                        AFirstName,
                        AMiddleName,
                        ALastName );
  asm fstcw [SaveCW] end;
  case Action of
    uaAddUser: errcode := dll_add_user( @status, @tmpSec );
    uaDeleteUser: errcode := dll_delete_user( @status, @tmpSec );
    uaModifyUser: errcode := dll_modify_user( @status, @tmpSec );
  end;
  asm fldcw [SaveCW] end;
  if errcode <> 0 then
    HandleException( Self );
end;


function TIB_SessionBase.GetISC4Path( const AServer: string;
                                            AProtocol: TIB_Protocol;
                                      const AUserName,
                                            AUserPass: string ): string;
var
  SaveCW: word;
  ServiceName, TmpStr: string;
  SvcHandle: isc_svc_handle;
  Buffer: array[0..1023] of char;
  TimeoutBuf: array[0..10] of char;
  BufPtr: PChar;
  BufLen: short;
begin
  // Service name - including servername with protocol distinctions
  ServiceName := '';
  if AServer <> '' then case AProtocol of
    cpNetBEUI: ServiceName := '\\' + AServer + '\';
    cpTCP_IP:  ServiceName := AServer + ':';
    cpNovell:  ServiceName := AServer + '@';
  end;
  ServiceName := ServiceName + 'service_mgr';
  // Initialise the buffer header
  BufPtr := Buffer;
  BufPtr^ := char(isc_spb_version);          Inc( BufPtr );
  BufPtr^ := char(isc_spb_current_version);  Inc( BufPtr );
  // Add in the User name
  TmpStr := AUserName;
  if TmpStr = '' then
    TmpStr := GetEnvVariable( 'ISC_USER' );
  BufPtr^ := char(isc_spb_user_name);        Inc( BufPtr );
  BufPtr^ := char(Length(TmpStr));           Inc( BufPtr );
  StrPCopy( BufPtr, TmpStr );                Inc( BufPtr, Length(TmpStr) );
  // Add in the password
  TmpStr := AUserPass;
  if TmpStr = '' then
    TmpStr := GetEnvVariable( 'ISC_PASSWORD' );
  BufPtr^ := char(isc_spb_password);         Inc( BufPtr );
  BufPtr^ := char(Length(TmpStr));           Inc( BufPtr );
  StrPCopy( BufPtr, TmpStr );                Inc( BufPtr, Length(TmpStr) );
  // Effect/Used length of buffer
  BufLen := BufPtr - Buffer;
  // now try to attach
  SvcHandle := nil;
  asm fstcw [SaveCW] end;
  errcode := dll_service_attach( @status, 0,
    PChar(ServiceName), @SvcHandle,
    BufLen, @Buffer );
  asm fldcw [SaveCW] end;
  if errcode <> 0 then
    HandleException( Self );
  try
    // Fillout the query timeout structure - 60 seconds
    BufPtr := TimeoutBuf;
    BufPtr^ := char(isc_info_svc_timeout);   Inc( BufPtr );
    add_spb_numeric( BufPtr, 60 );           // function increments BufPtr
    BufLen := BufPtr - TimeoutBuf;
    TmpStr := char(isc_info_svc_user_dbpath);
    FillChar( Buffer, SizeOf(Buffer), #0 );
    asm fstcw [SaveCW] end;
    errcode := dll_service_query( @status, @SvcHandle, nil,
      BufLen, @TimeoutBuf,                   // Timeout parameters
      short(Length(TmpStr)), PChar(TmpStr),  // Query request parameters
      short(SizeOf(Buffer)), @Buffer );      // Query Results
    asm fldcw [SaveCW] end;
    if errcode <> 0 then
      HandleException( Self );
    // I only asked for one item, I either got it or I didnt...
    if Buffer[0] = char(isc_info_svc_user_dbpath) then
    begin
      // reusing Buf for the string length of resulting value
      BufLen := isc_vax_integer(Buffer + 1, 2);
      if BufLen = 0 then
        Result := ''
      else
      begin
        Buffer[BufLen + 3] := #0;
        Result := PChar(@Buffer[3]);
      end
    end else Result := '';
  finally
    // errcode :=  ?? should I check for an error ??
    asm fstcw [SaveCW] end;
    dll_service_detach( @status, @SvcHandle );
    asm fldcw [SaveCW] end;
  end;
end;


procedure TIB_SessionBase.CreateDatabase( Database, Username, Password: string;
                                          PageSize: word;
                                          CharSet: string;
                                          SQLDialect: word );
var
  dbHandle: isc_db_handle;
  trHandle: isc_tr_handle;
  CreateString: string;
  SaveCW: word;
begin
  CreateString := Format( 'CREATE DATABASE ''%s''', [ Database ] );
  if Username <> '' then
    CreateString := CreateString +
                    Format( ' USER ''%s''', [ Username ] );
  if Password <> '' then
    CreateString := CreateString +
                    Format( ' PASSWORD ''%s''', [ Password ] );
  if PageSize >= 1024  then
  begin
    PageSize := (( PageSize + 512 ) div 1024 ) * 1024;
    CreateString := CreateString +
                    Format( ' PAGE_SIZE = %d', [ PageSize ] );
  end;
  if CharSet <> '' then
    CreateString := CreateString +
                    Format( ' DEFAULT CHARACTER SET %s', [ CharSet ] );
  dbHandle := nil;
  trHandle := nil;
  asm fstcw [SaveCW] end;
  errcode := isc_dsql_execute_immediate( @Status,
                                         @dbHandle,
                                         @trHandle,
                                         null_terminated,
                                         PChar(CreateString),
                                         SQLDialect,
                                         nil );
  asm fldcw [SaveCW] end;
  if errcode = 0 then
  begin
    asm fstcw [SaveCW] end;
    errCode := isc_detach_database( @Status, @dbHandle );
    asm fldcw [SaveCW] end;
  end;
  if errcode <> 0 then
    HandleException( Self );
end;

function GetStatementPlanFromHandle( st_hnd: pisc_stmt_handle ): string;
var
  Items: array [0..1] of Char;
  PlanBuffer: array [0..32760] of Char;
  PlanLen: integer;
  SaveCW: word;
  errcode: isc_status;
  status: status_vector;
begin
  Result := '';
  if st_Hnd = nil then
    Exit;
  Items[0] := Char( isc_info_sql_get_plan );
  Items[1] := #0;
  asm fstcw [SaveCW] end;
  errcode := dll_dsql_sql_info( @status,
                                st_hnd,
                                SizeOf( Items ),
                                Items,
                                SizeOf( PlanBuffer ),
                                @PlanBuffer );
  asm fldcw [SaveCW] end;
  if errcode = 0 then
    try
      if PlanBuffer[0] = Char(isc_info_sql_get_plan) then
      begin
        PlanLen := 0;
        Inc(PlanLen, byte(PlanBuffer[1])    );
        Inc(PlanLen, byte(PlanBuffer[2])*256);
        if PlanLen > 32757 then
          PlanLen := 32757;
        SetLength( Result, PlanLen );
        StrLCopy( PChar(Result), @PlanBuffer[3], PlanLen );
      end;
    except
      Result := E_PLAN_EXCEPTION + #13#10 + Result;
    end
  else
    Result := E_PLAN_ERROR + #13#10 + Result;
  Result := Trim( AdjustLineBreaks( Result ));
end;

class function TIB_SessionBase.GetRowsAffected( st_hnd: pisc_stmt_handle ):
                                                               TIB_RowsAffected;
var
  errcode: isc_status;
  status: status_vector;
  BufIn: array [0..10] of Char;
  BufOut: array [0..255] of Char;
  BufPtr: integer;
  InfoLen: integer;
  SaveCW: word;
begin
  with Result do
  begin
    UpdateCount := -1;
    DeleteCount := -1;
    SelectCount := -1;
    InsertCount := -1;
    if st_Hnd = nil then
      Exit;
    if Assigned( st_hnd^ ) then
    begin
      FillChar( BufIn, SizeOf(BufIn), #0 );
      FillChar( BufOut, SizeOf(BufOut), #0 );
      BufIn[0] := Char(isc_info_sql_records);
      asm fstcw [SaveCW] end;
      errcode := dll_dsql_sql_info( @status,
                                    st_hnd,
                                    SizeOf( BufIn ),
                                    BufIn,
                                    SizeOf( BufOut ),
                                    @BufOut );
      asm fldcw [SaveCW] end;
      if errcode <> 0 then Exit;
      BufPtr := 0;
      if BufOut[BufPtr] = Char(isc_info_sql_records) then begin
        Inc( BufPtr );
        InfoLen := dll_vax_integer( @BufOut[ BufPtr ], 2 );
        Inc( BufPtr, 2 );
        if InfoLen > 255 then begin
          raise EIB_Error.Create( E_Invalid_RowsAffected_Buffer );
        end;
        while BufOut[ BufPtr ] <> char(isc_info_end) do begin
          case BufOut[ BufPtr ] of
            char(isc_info_req_update_count): begin
              Inc( BufPtr );
              InfoLen := dll_vax_integer( @BufOut[ BufPtr ], 2 );
              Inc( BufPtr, 2 );
              UpdateCount := dll_vax_integer( @BufOut[ BufPtr ], InfoLen );
              Inc( BufPtr, InfoLen );
            end;
            char(isc_info_req_delete_count): begin
              Inc( BufPtr );
              InfoLen := dll_vax_integer( @BufOut[ BufPtr ], 2 );
              Inc( BufPtr, 2 );
              DeleteCount := dll_vax_integer( @BufOut[ BufPtr ], InfoLen );
              Inc( BufPtr, InfoLen );
            end;
            char(isc_info_req_select_count): begin
              Inc( BufPtr );
              InfoLen := dll_vax_integer( @BufOut[ BufPtr ], 2 );
              Inc( BufPtr, 2 );
              SelectCount := dll_vax_integer( @BufOut[ BufPtr ], InfoLen );
              Inc( BufPtr, InfoLen );
            end;
            char(isc_info_req_insert_count): begin
              Inc( BufPtr );
              InfoLen := dll_vax_integer( @BufOut[ BufPtr ], 2 );
              Inc( BufPtr, 2 );
              InsertCount := dll_vax_integer( @BufOut[ BufPtr ], InfoLen );
              Inc( BufPtr, InfoLen );
            end else begin
              raise EIB_Error.Create( E_InvalidRowsAffectedBuf );
            end;
          end;
        end;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TIB_SessionBase.GetBlobSize( var   MaxSegmentSize,
                                             TotalSize,
                                             NumSegments: longint;
                                       const PBlob_Handle: PISC_BLOB_HANDLE;
                                       const PSQLVAR: PXSQLVAR );
var
  ListBuffer: array[0..3] of char;
  ResultBuffer: array[0..31] of char;
  Ptr: integer;
  Item: byte;
  ItemLen: integer;
begin
  Ptr := 0;
  TotalSize := 0;
  MaxSegmentSize := 0;
  NumSegments := 0;
  ListBuffer[0] := char( isc_info_blob_max_segment  );
  ListBuffer[1] := char( isc_info_blob_total_length );
  ListBuffer[2] := char( isc_info_blob_num_segments );
  ListBuffer[3] := char( isc_info_end );
  if isc_blob_info( @status,
                    PBlob_Handle,
                    SizeOf( ListBuffer ),
                    ListBuffer,
                    SizeOf( ResultBuffer ),
                    ResultBuffer ) = 0 then
  begin
    while ResultBuffer[ Ptr ] <> char( isc_info_end ) do
    begin
      Item := byte( ResultBuffer[ Ptr ] );                   Inc( Ptr, 1 );
      ItemLen := isc_vax_integer( @ResultBuffer[ Ptr ], 2 ); Inc( Ptr, 2 );
      case Item of
        isc_info_blob_total_length:
          TotalSize := isc_vax_integer( @ResultBuffer[ Ptr ], ItemLen );
        isc_info_blob_num_segments:
          NumSegments := isc_vax_integer( @ResultBuffer[ Ptr ], ItemLen );
        isc_info_blob_max_segment:
          MaxSegmentSize := isc_vax_integer( @ResultBuffer[ Ptr ], ItemLen );
        else
          Break;
      end;
      Inc( Ptr, ItemLen )
    end;
  end;
  if ( PSQLVAR.sqlsubtype = 2 ) and ( TotalSize > 0 ) then
  begin
    Inc( TotalSize, NumSegments * 2 );
    Inc( MaxSegmentSize, 2 );
  end;
end;

function TIB_SessionBase.SysGetBlobData( pdbHndl: pisc_db_handle;
                                         ptrHndl: pisc_tr_handle;
                                         AVAR: PXSQLVAR;
                                         BlobNode: PIB_BlobNode;
                                         AEv: TIB_BlobCallbackEvent ): longint;
var
  Blob_Handle: isc_blob_handle;
  ActualSegmentSize: word;
  BPB: array[0..6] of byte;
  BPBLen: smallint;
  TotalSize: longint;
  NumSegments: longint;
  MaxSegmentSize: longint;
  UserMaxSeg: longint;
  SegmentBuffer: pointer;
  procedure GetSegment;
  begin
    Result := isc_get_segment( @status,
                               @Blob_Handle,
                               @ActualSegmentSize,
                               MaxSegmentSize,
                               SegmentBuffer );
    Inc( longint(SegmentBuffer), ActualSegmentSize );
// The BLR to text BLOB filter does not include CRLF so I am adding them in.
    if ( AVAR.sqlsubtype = 2 ) and
       (( Result = 0 ) or (( ActualSegmentSize > 0 ) and
                           ( Result = isc_segstr_eof ))) then
    begin
      pchar(SegmentBuffer)[0] := #13;
      pchar(SegmentBuffer)[1] := #10;
      Inc( longint(SegmentBuffer), 2 );
    end;
    if Assigned( AEv ) then
    begin
      UserMaxSeg := MaxSegmentSize;
      AEv( AVar,
               bcsRefreshGet,
               longint(SegmentBuffer) - longint(BlobNode.BlobBuffer),
               UserMaxSeg );
    end;
  end;
var
  BlobDesc: ISC_BLOB_DESC;
  GlobalName: array[ 0..63 ] of char;
begin
// Coerse the BLR column type to send a human readable version of it by
// telling the server to use the BLOB filter that converts BLR to text.
  BPBLen := 0;
  FillChar( BPB, SizeOf( BPB ), 0 );
  if AVAR.sqlsubtype = 2 then
  begin
    BPB[0] := isc_bpb_version1;
    BPB[1] := isc_bpb_target_type;
    BPB[2] := 1;
    BPB[3] := isc_blob_text;
    BPB[4] := isc_bpb_source_type;
    BPB[5] := 1;
    BPB[6] := isc_blob_blr;
    BPBLen := 7;
  end;
  Blob_Handle := nil;
  Result := isc_open_blob2( @Status,
                            pdbHndl,
                            ptrHndl,
                            @Blob_Handle,
                            @BlobNode.BlobID,
                            BPBLen,
                            @BPB );
  if Result <> 0 then Exit;
  GetBlobSize( MaxSegmentSize, TotalSize, NumSegments, @Blob_Handle, AVar );
  try
    BlobNode.BlobSize := TotalSize;
    if TotalSize = 0 then
      Exit
    else
    begin
    // The BLR to text BLOB filter does not include CRLF so I am adding them in.
    // Each line it produces is stored in a single segment.
      ActualSegmentSize := 0;
      if Assigned( AEv ) then
      begin
        UserMaxSeg := MaxSegmentSize;
        AEv( AVar, bcsInitGet, TotalSize, UserMaxSeg );
        if UserMaxSeg <= 0 then
        begin
        // If it is from a stored procedure then this will result in an error.
          if isc_blob_lookup_desc( @status,
                                   pdbHndl,
                                   ptrHndl,
                                   AVar.RelName,
                                   AVar.SQLName,
                                   @BlobDesc,
                                   @GlobalName ) = 0 then
            UserMaxSeg := BlobDesc.blob_desc_segment_size
          else
            UserMaxSeg := 4096;
        end;
        if ( MaxSegmentSize > UserMaxSeg ) and ( UserMaxSeg > 0 ) then
          MaxSegmentSize := UserMaxSeg;
      end;
      try
        if MaxSegmentSize = TotalSize then
        begin
          if BlobNode.BlobBufLen < TotalSize then
          begin
            IB_ReallocMem( BlobNode.BlobBuffer, BlobNode.BlobBufLen, TotalSize);
            BlobNode.BlobBufLen := TotalSize;
          end;
          SegmentBuffer := BlobNode.BlobBuffer;
          GetSegment;
        end
        else
        begin
          if BlobNode.BlobBufLen < TotalSize + MaxSegmentSize then
          begin
            IB_ReallocMem( BlobNode.BlobBuffer,
                           BlobNode.BlobBufLen,
                           TotalSize + MaxSegmentSize );
            BlobNode.BlobBufLen := TotalSize + MaxSegmentSize;
          end;
          SegmentBuffer := BlobNode.BlobBuffer;
          repeat
            GetSegment;
          until ( Result <> 0 ) and ( Result <> isc_segment );
        end;
      finally
        if Assigned( AEv ) then
        begin
          UserMaxSeg := MaxSegmentSize;
          AEv( AVar,
                   bcsFinalGet,
                   longint( SegmentBuffer ) - longint( BlobNode.BlobBuffer ),
                   UserMaxSeg );
        end;
      end;
    end;
    if BlobNode.BlobBufLen > TotalSize then
    begin
      IB_ReallocMem( BlobNode.BlobBuffer, BlobNode.BlobBufLen, TotalSize );
      BlobNode.BlobBufLen := TotalSize;
    end;
{$IFDEF DEBUG}
    BlobNode.ticks := GetTickCount;
{$ENDIF}
  finally
    errcode := isc_close_blob( @status, @Blob_Handle );
    if Result = 0 then
      Result := errcode;
  end;
end;

function TIB_SessionBase.SysPutBlobData(
    pdbHndl: pisc_db_handle;
    ptrHndl: pisc_tr_handle;
    AVAR: PXSQLVAR;
    BlobNode: PIB_BlobNode;
    AEv: TIB_BlobCallbackEvent ): longint;
var
  StoredSize: longint;
  SegmentBuffer: pointer;
  SegmentSize: longint;
  Blob_Handle: isc_blob_handle;
begin
  Blob_Handle := nil;
  Result := isc_create_blob2( @Status,
                              pdbHndl,
                              ptrHndl,
                              @Blob_Handle,
                              @BlobNode.BlobID,
                              0,
                              nil );
  if Result <> 0 then Exit;
  try
    if BlobNode.BlobSize > MaxWord then
      SegmentSize := MaxWord
    else
      SegmentSize := BlobNode.BlobSize;
    if SegmentSize = 0 then
    else
    begin
      if Assigned( AEv ) then
        AEv( AVar, bcsInitPut, BlobNode.BlobSize, SegmentSize );
      StoredSize := 0;
      SegmentBuffer := BlobNode.BlobBuffer;
      try
        while BlobNode.BlobSize - StoredSize >= SegmentSize do
        begin
          Result := isc_put_segment( @status,
                                     @Blob_Handle,
                                     SegmentSize,
                                     SegmentBuffer );
          if Result <> 0 then
            Exit;
          Inc( StoredSize, SegmentSize );
          Inc( longint(SegmentBuffer), SegmentSize );
          if Assigned( AEv ) then
            AEv( AVar, bcsRefreshPut, StoredSize, SegmentSize );
        end;
        if BlobNode.BlobSize > StoredSize then
        begin
          Result := isc_put_segment( @status,
                                     @Blob_Handle,
                                     BlobNode.BlobSize - StoredSize,
                                     SegmentBuffer );
          if Assigned( AEv ) then
            AEv( AVar, bcsRefreshPut, BlobNode.BlobSize, SegmentSize );
          if Result <> 0 then Exit;
        end;
      finally
        if Assigned( AEv ) then
          AEv( AVar, bcsFinalPut, BlobNode.BlobSize, SegmentSize );
      end;
    end;
  finally
    errcode := isc_close_blob( @status, @Blob_Handle );
    if Result = 0 then
      Result := errcode;
  end;
end;

function TIB_SessionBase.BlobsEqual( pdbHndl1, pdbHndl2: pisc_db_handle;
                                     ptrHndl1, ptrHndl2: pisc_tr_handle;
                                     AVAR1, AVAR2: PXSQLVAR;
                                     BlobID1, BlobID2: isc_quad;
                                     BlobNode1, BlobNode2: PIB_BlobNode;
                                     AEv1: TIB_BlobCallbackEvent;
                                     AEv2: TIB_BlobCallbackEvent ): boolean;
var
  Blob_Handle1, Blob_Handle2: isc_blob_handle;
  ActualSegmentSize1, ActualSegmentSize2: word;
  TotalSize1, TotalSize2: longint;
  NumSegments1, NumSegments2: longint;
  MaxSegmentSize1, MaxSegmentSize2: longint;
  UserMaxSeg1, UserMaxSeg2: longint;
  CmpBuffer1, CmpBuffer2: pointer;
  CmpPtr1, CmpPtr2: pointer;
  curCmpSize: longint;
  totCmpSize: longint;
  function GetSegment1: longint;
  begin
    Result := isc_get_segment( @status,
                               @Blob_Handle1,
                               @ActualSegmentSize1,
                               MaxSegmentSize1,
                               CmpBuffer1 );
    CmpPtr1 := CmpBuffer1;
    if Assigned( AEv1 ) then
    begin
      UserMaxSeg1 := MaxSegmentSize1;
      AEv1( AVar1,
            bcsRefreshGet,
            totCmpSize,
            UserMaxSeg1 );
    end;
  end;
  function GetSegment2: longint;
  begin
    Result := isc_get_segment( @status,
                               @Blob_Handle2,
                               @ActualSegmentSize2,
                               MaxSegmentSize2,
                               CmpBuffer2 );
    CmpPtr2 := CmpBuffer2;
    if Assigned( AEv2 ) then
    begin
      UserMaxSeg2 := MaxSegmentSize2;
      AEv2( AVar2,
            bcsRefreshGet,
            totCmpSize,
            UserMaxSeg2 );
    end;
  end;
var
  BlobDesc1: ISC_BLOB_DESC;
  BlobDesc2: ISC_BLOB_DESC;
  GlobalName1: array[ 0..63 ] of char;
  GlobalName2: array[ 0..63 ] of char;
begin
  Result := false;
  CmpBuffer1 := nil;
  CmpBuffer2 := nil;
  if Assigned( BlobNode1 ) then
  begin
    MaxSegmentSize1 := BlobNode1.BlobSize;
    TotalSize1 := BlobNode1.BlobSize;
  end
  else
  begin
    Blob_Handle1 := nil;
    errcode := isc_open_blob( @Status,
                              pdbHndl1,
                              ptrHndl1,
                              @Blob_Handle1,
                              @BlobID1 );
    if errcode <> 0 then
      HandleException( Self );
    GetBlobSize( MaxSegmentSize1,
                 TotalSize1, NumSegments1, @Blob_Handle1, AVar1 );
  end;
  if Assigned( BlobNode2 ) then
  begin
    MaxSegmentSize2 := BlobNode2.BlobSize;
    TotalSize2 := BlobNode2.BlobSize;
  end
  else
  begin
    Blob_Handle2 := nil;
    errcode := isc_open_blob( @Status,
                              pdbHndl2,
                              ptrHndl2,
                              @Blob_Handle2,
                              @BlobID2 );
    if errcode <> 0 then
      HandleException( Self );
    GetBlobSize( MaxSegmentSize2,
                 TotalSize2, NumSegments2, @Blob_Handle2, AVar2 );
  end;
  if TotalSize1 = TotalSize2 then
    try
      if TotalSize1 = 0 then
        Result := true
      else
      begin
        totCmpSize := 0;
        ActualSegmentSize1 := 0;
        ActualSegmentSize2 := 0;
        if Assigned( AEv1 ) then
        begin
          UserMaxSeg1 := MaxSegmentSize1;
          AEv1( AVar1, bcsInitGet, TotalSize1, UserMaxSeg1 );
          if UserMaxSeg1 <= 0 then
          begin
          // If it is from a stored procedure then this will result in an error.
            if isc_blob_lookup_desc( @status,
                                     pdbHndl1,
                                     ptrHndl1,
                                     AVar1.RelName,
                                     AVar1.SQLName,
                                     @BlobDesc1,
                                     @GlobalName1 ) = 0 then
              UserMaxSeg1 := BlobDesc1.blob_desc_segment_size
            else
              UserMaxSeg1 := 4096;
          end;
          if ( MaxSegmentSize1 > UserMaxSeg1 ) and ( UserMaxSeg1 > 0 ) then
            MaxSegmentSize1 := UserMaxSeg1;
          UserMaxSeg2 := MaxSegmentSize2;
          AEv2( AVar2, bcsInitGet, TotalSize2, UserMaxSeg2 );
          if UserMaxSeg2 <= 0 then
          begin
          // If it is from a stored procedure then this will result in an error.
            if isc_blob_lookup_desc( @status,
                                     pdbHndl2,
                                     ptrHndl2,
                                     AVar2.RelName,
                                     AVar2.SQLName,
                                     @BlobDesc2,
                                     @GlobalName2 ) = 0 then
              UserMaxSeg2 := BlobDesc2.blob_desc_segment_size
            else
              UserMaxSeg2 := 4096;
          end;
          if ( MaxSegmentSize2 > UserMaxSeg2 ) and ( UserMaxSeg2 > 0 ) then
            MaxSegmentSize2 := UserMaxSeg2;
        end;
        try
          if Assigned( BlobNode1 ) then
          begin
            CmpBuffer1 := BlobNode1.BlobBuffer;
            ActualSegmentSize1 := TotalSize1;
          end
          else
          begin
            GetMem( CmpBuffer1, MaxSegmentSize1 );
            ActualSegmentSize1 := 0;
          end;
          if Assigned( BlobNode2 ) then
          begin
            CmpBuffer2 := BlobNode2.BlobBuffer;
            ActualSegmentSize2 := TotalSize2;
          end
          else
          begin
            GetMem( CmpBuffer2, MaxSegmentSize2 );
            ActualSegmentSize2 := 0;
          end;
          CmpPtr1 := CmpBuffer1;
          CmpPtr2 := CmpBuffer2;
          Result := true;
          repeat
            if ( ActualSegmentSize1 = 0 ) and not Assigned( BlobNode1 ) then
              GetSegment1;
            if ( ActualSegmentSize2 = 0 ) and not Assigned( BlobNode2 ) then
              GetSegment2;
            curCmpSize := ActualSegmentSize1;
            if curCmpSize > ActualSegmentSize2 then
              curCmpSize := ActualSegmentSize2;
            if ( curCmpSize > 0 ) and
               ( BuffersEqual( cmpPtr1, CmpPtr2, curCmpSize )) then
            begin
              Inc( totCmpSize, curCmpSize );
              Inc( longint(CmpPtr1), curCmpSize );
              Inc( longint(CmpPtr2), curCmpSize );
              Dec( ActualSegmentSize1, curCmpSize );
              Dec( ActualSegmentSize2, curCmpSize );
            end
            else
            begin
              Result := false;
              Break;
            end;
          until totCmpSize >= TotalSize1;
        finally
          if not Assigned( BlobNode1 ) then
            FreeMem( CmpBuffer1, MaxSegmentSize1 );
          if not Assigned( BlobNode2 ) then
            FreeMem( CmpBuffer2, MaxSegmentSize2 );
          if Assigned( AEv1 ) then
          begin
            UserMaxSeg1 := MaxSegmentSize1;
            AEv1( AVar1,
                  bcsFinalGet,
                  totCmpSize,
                  UserMaxSeg1 );
            UserMaxSeg2 := MaxSegmentSize2;
            AEv2( AVar2,
                  bcsFinalGet,
                  totCmpSize,
                  UserMaxSeg2 );
          end;
        end;
    end;
  finally
    if not Assigned( BlobNode1 ) then
      errcode := isc_close_blob( @status, @Blob_Handle1 );
    if not Assigned( BlobNode2 ) then
      errcode := isc_close_blob( @status, @Blob_Handle2 );
  end;
end;

function GetArrayBufferLength( ArrayDesc: PISC_ARRAY_DESC ): longint;
var
  ii: integer;
  Elements: integer;
  ElementSize: integer;
begin
  Elements := 1;
  for ii := 0 to ArrayDesc.array_desc_dimensions - 1 do
    with ArrayDesc.array_desc_bounds[ii] do
      Elements := Elements * ( array_bound_upper - array_bound_lower + 1 );
  ElementSize := ArrayDesc.array_desc_length;
  case byte(ArrayDesc.array_desc_dtype) of
    37, 38: Inc( ElementSize, 2 );
  end;
  Result := Elements * ElementSize;
end;

function TIB_SessionBase.SysGetArrayData(
  pdbHndl: pisc_db_handle;
  ptrHndl: pisc_tr_handle;
  AVAR: PXSQLVAR;
  ArrayDesc: PISC_ARRAY_DESC;
  BlobNode: PIB_BlobNode ): longint;
begin
  BlobNode.BlobSize := GetArrayBufferLength( ArrayDesc );
  if BlobNode.BlobBufLen < BlobNode.BlobSize then
  begin
    IB_ReallocMem( BlobNode.BlobBuffer, BlobNode.BlobBufLen, BlobNode.BlobSize);
    BlobNode.BlobBufLen := BlobNode.BlobSize;
  end;
  Result := isc_array_get_slice( @status,
                                 pdbHndl,
                                 ptrHndl,
                                 @BlobNode.BlobID,
                                 ArrayDesc,
                                 BlobNode.BlobBuffer,
                                 @BlobNode.BlobSize );
end;

function TIB_SessionBase.SysPutArrayData(
  pdbHndl: pisc_db_handle;
  ptrHndl: pisc_tr_handle;
  AVAR: PXSQLVAR;
  ArrayDesc: PISC_ARRAY_DESC;
  BlobNode: PIB_BlobNode ): longint;
begin
  if BlobNode.BlobSize = 0 then
  begin
    FillChar( AVAR.SQLData^, AVAR.SQLLen, #0 );
    AVAR.SQLInd^ := IB_NULL;
    Result := 0;
  end
  else
    Result := isc_array_put_slice( @status,
                                   pdbHndl,
                                   ptrHndl,
                                   @BlobNode.BlobID,
                                   ArrayDesc,
                                   BlobNode.BlobBuffer,
                                   @BlobNode.BlobSize );
end;

function TIB_SessionBase.GetBlobData( pdbHndl: pisc_db_handle;
                                      ptrHndl: pisc_tr_handle;
                                      AVAR: PXSQLVAR;
                                      ArrayDesc: PISC_ARRAY_DESC;
                                      BlobNode: PIB_BlobNode;
                                      AEv: TIB_BlobCallbackEvent ): longint;
begin
  Result := 0;
  case AVAR.SQLType of
    SQL_BLOB,
    SQL_BLOB_: Result := SysGetBlobData( pdbHndl,
                                         ptrHndl,
                                         AVAR,
                                         BlobNode,
                                         AEv );
    SQL_ARRAY,
    SQL_ARRAY_: Result := SysGetArrayData( pdbHndl,
                                           ptrHndl,
                                           AVAR,
                                           ArrayDesc,
                                           BlobNode );
  end;
end;

function TIB_SessionBase.PutBlobData( pdbHndl: pisc_db_handle;
                                      ptrHndl: pisc_tr_handle;
                                      AVAR: PXSQLVAR;
                                      ArrayDesc: PISC_ARRAY_DESC;
                                      BlobNode: PIB_BlobNode;
                                      AEv: TIB_BlobCallbackEvent ): longint;
begin
  Result := 0;
  case AVAR.SQLType of
    SQL_BLOB,
    SQL_BLOB_: Result := SysPutBlobData( pdbHndl,
                                         ptrHndl,
                                         AVAR,
                                         BlobNode,
                                         AEv );
    SQL_ARRAY,
    SQL_ARRAY_: Result := SysPutArrayData( pdbHndl,
                                           ptrHndl,
                                           AVAR,
                                           ArrayDesc,
                                           BlobNode );
  end;
end;

{------------------------------------------------------------------------------}

procedure ClearBlobNodeData( BlobNode: PIB_BlobNode );
begin
  if Assigned( BlobNode ) then
  begin
    BlobNode.BlobSize := 0;
    BlobNode.BlobID.isc_quad_high := 0;
    BlobNode.BlobID.isc_quad_low := 0;
    BlobNode.BlobFieldNo := 0;
    BlobNode.BlobChanged := false;
  end;
end;

procedure FreeBlobNodeData( BlobNode: PIB_BlobNode );
begin
  if Assigned( BlobNode ) then
  begin
    ClearBlobNodeData( BlobNode );
    if Assigned( BlobNode.BlobBuffer ) then
    begin
      FreeMem( BlobNode.BlobBuffer );
      BlobNode.BlobBuffer := nil;
    end;
    BlobNode.BlobBufLen := 0;
  end;
end;

procedure FreeBlobRefList( PBlobHead: PPIB_BlobNode );
var
  tmpNodeRef: PIB_BlobNode;
begin
  try
    if Assigned( PBlobHead ) then
      while Assigned( PBlobHead^ ) do
      begin
        tmpNodeRef := PBlobHead^;
        PBlobHead^ := PBlobHead^.Next;
        FreeBlobNodeData( tmpNodeRef );
        FreeMem( tmpNodeRef );
      end;
  except
  end;
end;

function FindBlobNodeInList(     PBlobHead: PPIB_BlobNode;
                                 BlobID: isc_quad;
                                 BlobFieldNo: word;
                                 ByBlobIDOnly: boolean;
                             var ParentBlobRef: PIB_BlobNode ): PIB_BlobNode;
var
  tmpBlobHead: PIB_BlobNode;
begin
  Result := nil;
  ParentBlobRef := nil;
  if Assigned( PBlobHead ) then
  if Assigned( PBlobHead^ ) then
  begin
    if not isc_quad_is_zero( BlobID ) then
    begin
      tmpBlobHead := PBlobHead^;
      while Assigned( tmpBlobHead ) and not Assigned( Result ) do
      begin
        if isc_quad_equal( BlobID, tmpBlobHead.BlobID ) then
          Result := tmpBlobHead
        else
        begin
          ParentBlobRef := tmpBlobHead;
          tmpBlobHead := tmpBlobHead.Next;
        end;
      end;
    end;
    if not Assigned( Result ) then
    begin
      tmpBlobHead := PBlobHead^;
      while Assigned( tmpBlobHead ) and not Assigned( Result ) do
      begin
        if ( BlobFieldNo = tmpBlobHead.BlobFieldNo ) and
           ( not ByBlobIDOnly or tmpBlobHead.BlobChanged ) then
          Result := tmpBlobHead
        else
        begin
          ParentBlobRef := tmpBlobHead;
          tmpBlobHead := tmpBlobHead.Next;
        end;
      end;
    end;
  end;
end;

procedure PutBlobNodeIntoList( PBlobHead: PPIB_BlobNode;
                               BlobNode: PIB_BlobNode;
                               ClearSourceNode: boolean );
var
  Dst: PIB_BlobNode;
  tmpBlobHead: PIB_BlobNode;
begin
  Dst := FindBlobNodeInList( PBlobHead,
                             BlobNode.BlobID,
                             BlobNode.BlobFieldNo,
                             false,
                             tmpBlobHead );
  if not Assigned( Dst ) then
  begin
    Dst := AllocMem( SizeOf( TIB_BlobNode ));
    Dst.Next := PBlobHead^;
    PBlobHead^ := Dst;
  end;
  TransferBlobNodeData( BlobNode, Dst, ClearSourceNode );
end;

function GetBlobNodeFromList( PBlobHead: PPIB_BlobNode;
                              ByBlobIDOnly: boolean;
                              BlobNode: PIB_BlobNode ): boolean;
var
  Src: PIB_BlobNode;
  ParentBlobRef: PIB_BlobNode;
begin
  Result := false;
  Src := FindBlobNodeInList( PBlobHead,
                             BlobNode.BlobID,
                             BlobNode.BlobFieldNo,
                             ByBlobIDOnly,
                             ParentBlobRef );
  if Assigned( Src ) then
  begin
    TransferBlobNodeData( Src, BlobNode, false );
    Result := true;
  end;
end;

procedure TransferBlobNodeData( Src, Dst: PIB_BlobNode;
                                ClearSourceNode: boolean );
begin
  FreeBlobNodeData( Dst );
  Dst.BlobID := Src.BlobID;
  Dst.BlobFieldNo := Src.BlobFieldNo;
  Dst.BlobSize := Src.BlobSize;
  Dst.BlobChanged := Src.BlobChanged;
  if ClearSourceNode then
  begin
    Dst.BlobBuffer := Src.BlobBuffer;
    Dst.BlobBufLen := Src.BlobBufLen;
    Src.BlobBuffer := nil;
    Src.BlobBufLen := 0;
    ClearBlobNodeData( Src );
  end
  else
  begin
    GetMem( Dst.BlobBuffer, Dst.BlobSize );
    Dst.BlobBufLen := Dst.BlobSize;
    Move( Src.BlobBuffer^, Dst.BlobBuffer^, Dst.BlobSize );
  end;
end;

function ConnectionLostErrcode( const AErrCode: integer ): boolean;
begin
  Result := ( AErrCode = isc_shutdown ) or
            ( AErrCode = isc_lost_db_connection ) or
            ( AErrCode = isc_network_error ) or
            ( AErrCode = isc_net_connect_err ) or
            ( AErrCode = isc_net_connect_listen_err ) or
            ( AErrCode = isc_net_event_connect_err ) or
            ( AErrCode = isc_net_event_listen_err ) or
            ( AErrCode = isc_net_read_err ) or
            ( AErrCode = isc_net_write_err );
end;

procedure ReserveSessionHookRef;
begin
  if InterlockedIncrement( FGDS_RefCount ) = 0 then
  begin
    InitializeCriticalSection( AttachCS );
    InitializeCriticalSection( GlobalCS );
    AcquireOriginalHooks;
    RevertToOriginalHooks;
{$IFDEF ALLOW_DEFAULT_SESSION}
    hDefaultSession := TlsAlloc;
{$ENDIF}
{$IFDEF ALLOW_ALT_SESSION}
    hAlternateSession := TlsAlloc;
{$ENDIF}
  end;
end;

procedure ReleaseSessionHookRef;
begin
  if InterlockedDecrement( FGDS_RefCount ) = 0 then
  begin
    DeleteCriticalSection( AttachCS );
    DeleteCriticalSection( GlobalCS );
    if FGDS_Handle >= 32 then
      FreeLibrary( FGDS_Handle );
    FGDS_Handle := 0;
{$IFDEF ALLOW_DEFAULT_SESSION}
    TlsFree( hDefaultSession );
    hDefaultSession := 0;
{$ENDIF}
{$IFDEF ALLOW_ALT_SESSION}
    TlsFree( hAlternateSession );
    hAlternateSession := 0;
{$ENDIF}
  end;
end;

constructor TIB_XSQLVAR.Create( APXSQLDA: PXSQLDA;
                                APXSQLVAR: PXSQLVAR;
                                APXSQLVAR_V2: PXSQLVAR_V2 );
begin
  inherited Create;
  FPXSQLDA     := APXSQLDA;
  FPXSQLVAR    := APXSQLVAR;
  FPXSQLVAR_V2 := APXSQLVAR_V2;
end;
function TIB_XSQLVAR.GetSqlType: smallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.sqltype
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.sqltype
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetSqlScale: smallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.sqlscale
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.sqlscale
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetSqlSubType: smallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.sqlsubtype
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.sqlsubtype
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetSqlLen: smallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.sqllen
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.sqllen
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetSqlData: Pointer;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.sqldata
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.sqldata
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetSqlInd: psmallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.sqlind
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.sqlind
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetSqlNameLen: smallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.sqlname_length
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.sqlname_length
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetSqlName: string;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.sqlname
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.sqlname
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetRelNameLen: smallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.relname_length
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.relname_length
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetRelName: string;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.relname
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.relname
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetOwnNameLen: smallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.ownname_length
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.ownname_length
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetOwnName: string;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.ownname
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.ownname
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetAliasNameLen: smallint;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.aliasname_length
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.aliasname_length
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;
function TIB_XSQLVAR.GetAliasName: string;
begin
  if Assigned( FPXSQLVAR ) then
    Result := FPXSQLVAR.aliasname
  else
  if Assigned( FPXSQLVAR_V2 ) then
    Result := FPXSQLVAR_V2.aliasname
  else
    raise Exception.Create( 'Need VAR descriptor' );
end;

initialization
  ReserveSessionHookRef; // Starts at -1 to hit zero.
  ReserveSessionHookRef; // Now do a normal one to hold hooks open.

finalization
  ReleaseSessionHookRef; // Make sure hooks are valid at least this far into it.

end.

