
{                                                                              }
{ IB_Constants                                                                 }
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
{  27-Apr-2003                                                                 }
{     Added the STR_DDL_coUseBigInt string constant.     .                     }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  01-Oct-2002                                                                 }
{     Lots of string constants moved from IB_Metadata.pas.                     }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  04-May-2002                                                                 }
{     Various new string constants to match changes to IB_Metadata.pas and     }
{     IBF_Metadata.pas.                                                        }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  09-Jan-2002                                                                 }
{     Altered E_UnableToSearch into two separate messages and expanded the     }
{     explanation to make the problems more obvious.                           }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  07-Jan-02                                                                   }
{      Addition of constants for new IB_Metadata and related components.       }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  29-Dec-01                                                                   }
{      Addition of E_IntegerOverflow and E_Int64Overflow messages.             }
{      Removal of E_53BIT_OVERFLOW message (53bit integer no longer supported. }
{                                                                              }
{ Dirk Schiffler <ds@rcs.de>                                                   }
{ 11/11/2001                                                                   }
{    - constant G_DefaultRowHeight for property DefaultRowHeight               }
{      in the class-definitions for grids                                      }
{    - constants for date and time format strings                              }
{      using in IB_Parse and IB_Utils                                          }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Constants;

interface

var
// This is the name of the InterBase Client DLL (API) that is used.
// Use the unit IB_Session511.pas as the first item in the uses clause
// of your project to change this variable to use an alternate GDS32.DLL
// client library.
  IB_GDS32: string = 'gds32.dll';

const
// This is a flag that I am using to indicate when a bug in InterBase is fixed
// so that a more optimal set of calls can be used.
  BUG_EXEC2 = true;

// Version information
  IB_VERSION_MAJOR = '4';
  IB_VERSION_MINOR = '2';
  IB_VERSION_BUILD = 'I';
  IB_VERSION_SUB_RELEASE = 'e';

  IB_BASEKEY = 'Software\CPS\IBO';

// Internal settings
  IB_RDB = 'RDB$';
  IB_DB_KEY = 'DB_KEY';

// Parameter syntax
  IB_BINDLINK = 'BIND_';
  IB_MASTERLINK = 'MLNK_';
  IB_KEYLINK = 'KLNK_';
  IB_ORDLINK = 'OLNK_';
  IB_PARAMETER = 'PRM_';
  IB_QBE_PARAMETER = 'QBE_';
  IB_LOCATE_PARAMETER = 'LOC_';
  IB_RNGBEG = 'RBEG_';
  IB_RNGEND = 'REND_';

// General flags
  IB_TRUE = 'TRUE';
  IB_FALSE = 'FALSE';
  IB_AND = #13#10'  AND ';

// Connection parameter names. ( Don't translate these. )
  IB_USER_NAME          = 'USER NAME';
  IB_PASSWORD           = 'PASSWORD';
  IB_LOCAL_PASSWORD     = 'LOCAL PASSWORD';
  IB_SERVER_NAME        = 'SERVER NAME';
  IB_SERVER             = 'SERVER';
  IB_PATH               = 'PATH';
  IB_LICENSE            = 'LICENSE';
  IB_SYSDBA             = 'SYSDBA';
  IB_ENCRYPT_KEY        = 'ENCRYPT KEY';
  IB_CHARACTER_SET      = 'CHARACTER SET';
  IB_MESSAGE_FILE       = 'MESSAGE FILE';
  IB_FORCED_WRITES      = 'FORCED WRITES';
  IB_BUFFERS            = 'BUFFERS';
  IB_PAGE_SIZE          = 'PAGE SIZE';
  IB_SWEEP_INTERVAL     = 'SWEEP INTERVAL';
  IB_RESERVE_PAGE_SPACE = 'RESERVE PAGE SPACE';
  IB_PROTOCOL           = 'PROTOCOL';
  IB_DB_KEY_SCOPE       = 'DB_KEY SCOPE';
  IB_SQL_DIALECT        = 'SQL DIALECT';
  IB_SQL_ROLE_NAME_     = 'SQL ROLE NAME'; // This setting is being deprecated.
  IB_ROLE_NAME          = 'ROLE NAME';
  IB_ROLE_              = 'ROLE'; // This setting is being deprecated.

// Connection parameter values.
  IB_PROTOCOL_LOCAL    = 'LOCAL';
  IB_PROTOCOL_NETBEUI  = 'NETBEUI';
  IB_PROTOCOL_TCP_IP   = 'TCP/IP';
  IB_PROTOCOL_NOVELL   = 'NOVELL';
  IB_DB_KEY_SCOPE_CONN = 'CONNECTION';
  IB_DB_KEY_SCOPE_TRAN = 'TRANSACTION';

// BDE Alias settings
  BDE_DRIVER_FLAGS               = 'DRIVER FLAGS';
  BDE_TRACE_MODE                 = 'TRACE MODE';
  BDE_SERVER_NAME                = IB_SERVER_NAME;
  BDE_USER_NAME                  = IB_USER_NAME;
  BDE_PASSWORD                   = IB_PASSWORD;
  BDE_OPEN_MODE                  = 'OPEN MODE';
  BDE_SCHEMA_CACHE_SIZE          = 'SCHEMA CACHE SIZE';
  BDE_LANGDRIVER                 = 'LANGDRIVER';
  BDE_SQLQRYMODE                 = 'SQLQRYMODE';
  BDE_SQLPASSTHRU_MODE           = 'SQLPASSTHRU MODE';
  BDE_SCHEMA_CACHE_TIME          = 'SCHEMA CACHE TIME';
  BDE_MAX_ROWS                   = 'MAX ROWS';
  BDE_BATCH_COUNT                = 'BATCH COUNT';
  BDE_ENABLE_SCHEMA_CACHE        = 'ENABLE SCHEMA CACHE';
  BDE_SCHEMA_CACHE_DIR           = 'SCHEMA CACHE DIR';
  BDE_ENABLE_BCD                 = 'ENABLE BCD';
  BDE_BLOBS_TO_CACHE             = 'BLOBS TO CACHE';
  BDE_BLOB_SIZE                  = 'BLOB SIZE';
  BDE_ROLE_NAME                  = IB_ROLE_NAME;
  BDE_WAIT_ON_LOCKS              = 'WAIT ON LOCKS';
  BDE_COMMIT_RETAIN              = 'COMMIT RETAIN';

// BDE Alias settings
  BDE_SHARED_AUTOCOMMIT      = 'SHARED AUTOCOMMIT';
  BDE_SHARED_NOAUTOCOMMIT    = 'SHARED NOAUTOCOMMIT';
  BDE_NOT_SHARED             = 'NOT SHARED';


// These are various settings that can be made in the ColumnAttributes property.
  IB_BINARY      = 'BINARY';     // Flag a CHAR or VARCHAR column as binary.
  IB_BLANKISNULL = 'BLANKISNULL';// Used by TIB_Column class when assigning a
                                 // blank string to a Fields member.
  IB_BOOLEAN     = 'BOOLEAN';    // Used to tell what values are used to make
                                 // this a boolean column.
  IB_COMPUTED    = 'COMPUTED';   // It tells that the column is actually a
                                 // COMPUTED BY derived column.
  IB_CURRENCY    = 'CURRENCY';   // Flag to indicate a column contains currency.
  IB_NOCASE      = 'NOCASE';     // Flag to set a case insensitive search field
  IB_NODATE      = 'NODATE';
  IB_NOSOUNDEX   = 'NOSOUNDEX';  // Disable soundex processing in a dataset
  IB_NOTIME      = 'NOTIME';
  IB_NOTRAILING  = 'NOTRAILING'; // Flag to use STARTING on literal strings
  IB_NOTREQUIRED = 'NOTREQUIRED';
  IB_REQUIRED    = 'REQUIRED';
  IB_SOUNDEX     = 'SOUNDEX';    // Flag to set a SoundEx search field
  IB_BCD         = 'BCD';        // Flag to force a colum to be TIBOBCDField
  IB_NOBCD       = 'NOBCD';      // Flag to force a colum to be TIBOFloatField
  IB_YESCASE     = 'YESCASE';    // Flag to override CN.DefaultNoCase
  IB_YESLIKE     = 'YESLIKE';    // Flag to use LIKE on literal strings
  IB_YESTRAILING = 'YESTRAILING';// Flag to override CN.DefaultNoTrailing

// Used by the SeachPanel from the FieldsReadOnly property.
  IB_NOINSERT = 'NOINSERT';
  IB_NOEDIT   = 'NOEDIT';
  IB_NOSEARCH = 'NOSEARCH';

// Events
  IB_MaxEvents = 15;
  IB_EventLength = 64;

// Session
  IB_ISC_ERR_CODE_MSG = 'ISC ERROR CODE:';
  IB_ISC_ERR_MSG_MSG  = 'ISC ERROR MESSAGE:';
  IB_SQL_ERR_CODE_MSG = 'SQL ERROR CODE:';
  IB_SQL_ERR_MSG_MSG  = 'SQL ERROR MESSAGE:';

// Global Defaults  ( Do NOT localize these )
  G_DefaultRowHeight = 17;

  DTEncode_DateDelimit     = '/';
  DTEncode_TimeDelimit     = ':';
  DTEncode_DateTimeDelimit = ' ';
  DTEncode_DecodeFormat    = '%.4u/%.2u/%.2u %.2u:%.2u:%.2u.%.3u0';
  DTEncode_DateTimeFormat  = 'YYYY"/"MM"/"DD" "HH":"NN":"SS".0000"';
  DT_DateFormat            = 'MM"/"dd"/"yyyy';
  DT_TimeFormat            = 'hh":"nn":"ss';

{ These may be localized. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'Thanks for evaluating IB Objects.'#13#10#13#10'Please go to http://www.ibobjects.com and register today.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Connection has already been established';
  E_NOT_CONNECTED     = 'Connection has not been established';
  E_Invalid_conn_path = 'Invalid connection path';
  E_Cant_Repl_Int_Tr  = 'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Transaction has not been started';
  E_TRANS_STARTED     = 'Transaction has already been started';
  E_NO_CONNECTIONS    = 'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Transaction is Paused';
  E_ALLOCATED         = 'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Statement has not been allocated';
  E_PREPARED          = 'Statement has already been prepared';
  E_NOT_PREPARED      = 'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Statement failed to prepare';
  E_OPENED            = 'Statement has already been opened';
  E_NOT_OPENED        = 'Statement has not been opened';
  E_CANT_DELETE       = 'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'No active transaction to execute with';
  E_START_FAILED      = 'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate     = 'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'At end of file';
  E_AT_END_OF_CURSOR  = 'At end of cursor';
  E_AT_END_OF_BUFFER  = 'At end of buffer';
  E_AT_END_OF_DATASET = 'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI              = 'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND         = 'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = 'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = 'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = 'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = 'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR       = 'Cannot open cursor without key data';
  E_SCROLL_ERROR           = 'Record key was lost'#13#10'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT      = 'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT   = 'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = 'Cannot change while connected';
  E_LOGIN_FAILED      = 'Login failed';
  E_CANT_GET_CONN_CHR = 'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = 'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Cannot cancel current Row';
  E_CANNOT_POST_ROW  = 'Cannot Post current Row';
  E_DatasetClosed     = 'Dataset is inactive';
  E_DatasetOpen        = 'Dataset is currently open';
  E_DatasetCannotScroll = 'Dataset cannot scroll';
  E_DatasetReadOnly     = 'Dataset is readonly';
  E_DatasetIsFetching    = 'Dataset is currently fetching';
  E_Invalid_KeyRelation   = 'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNum is not implemented yet';
  E_RowDeleted            = 'Row is being deleted';
  E_END_OF_DATASET        = 'At end of Dataset';
  E_BEGINNING_OF_DATASET   = 'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row      = 'Cannot Edit current Row';
  E_Cannot_Insert_Row  = 'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Cannot delete current Row';
  E_Cannot_Search    = 'Searching is not allowed';
  E_Cannot_Navigate = 'Cannot navigate';
  E_Record_Locked    = 'Record is locked by another user';
  E_Record_OutOfSynch = 'Record was changed by another user';
  E_FLD_READONLY       = '%s is readonly';
  E_Required_Field       = '%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Invalid Bookmark String';

  E_Assign_Column  = 'Cannot assign from %s';
  E_AssignTo_Column = 'Cannot assign to %s';
  E_Value_Out_Of_Range = 'Value out of range';
  E_SmallintOverflow = 'Smallint overflow';
  E_IntegerOverflow = 'Integer overflow';
  E_Int64Overflow = 'Int64 overflow';

  E_Unsupported_Column = 'Unsupported Column type: %d';
  E_UndefinedMacro = 'Undefined macro';
  E_GeneratorFailed = 'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Invalid reference to Delete';
  E_Invalid_Typecast = 'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL field set to null value';
  E_DATABASE_BLANK = 'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Unable To Locate Record';
  E_Record_Not_Inserted = 'Record was not inserted';
  E_Invalid_KeyLinks = 'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Unable to perform search';
  E_Unassigned_Blob_Node = 'Unassigned BlobNode';
  E_Unassigned_Transaction = 'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Could not load memo';
  E_Invalid_DPB_Over_255 = 'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'Unable to initialize default %s';
  E_Stringlist_Not_Sorted = 'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Invalid statement type';
  E_Multiple_Records_Updated = 'Multiple records updated';
  E_Multiple_Records_Deleted = 'Multiple records deleted';
  E_Multiple_Records_Inserted = 'Multiple records inserted';
  E_DUP_DB_NAME = 'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Invalid DatabaseName';
  E_UnableToSearch_NoOrdering = 'Unable to perform search, no ordering defined';
  E_UnableToSearch_DatasetBusy = 'Unable to perform search, dataset is busy fetching data';
  E_NoRecordsFound = 'No records found';
  E_Session_Undefined = 'Session is undefined';
  E_NoCircularRef = 'Circular reference not allowed';
  E_InvalidClassType = 'Invalid class type';
  E_Invalid_RowNum = 'Invalid RowNum';
  E_Invalid_Syntax = 'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Array is Null';

  E_Cannot_add_blank_account = 'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Cannot modify blank account';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Unsupported';
  E_NotImplemented = 'Not implemented at this level';
  E_Invalid_ColData = 'Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Cannot Unprepare an executing process';
  E_FileName_Required = 'Filename is required';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'User Account Management';
  L_USERS_ADD = 'Add';
  L_USERS_DELETE = 'Delete';
  L_USERS_MODIFIY = 'Modify';
  L_USERS_ACCOUNT = 'ACCOUNT';
  L_USERS_PASSWORD = 'Password';
  L_USERS_GROUP = 'Group';
  L_USERS_FIRSTNAME = 'First Name';
  L_USERS_MIDDLENAME = 'Middle Name';
  L_USERS_LASTNAME = 'Last Name';

  //IBF_Export
  L_EXPORT_FRM = 'Export';
  L_EXPORT_ASCII = ' File Format ';
  L_EXPORT_FIXED = 'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV Delimited';
  L_EXPORT_DBF  = 'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = ' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Delimiter';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Fetching Query Results';
  M_Row_Num = 'Row# %d';
  M_Abort_Fetching_Btn = 'Abort';

  M_Login_Database = 'Database';
  M_Login_User = 'User';
  M_Login_Password = 'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancel';
  M_Login_Help_Btn = '&Help';
  M_Login_Dialog_Caption = 'Login Dialog';

  M_Loading_Caption = 'Loading...';

  M_SB_REC_CNT = 'Records counted: %d';
  M_Save_Changes = 'Save changes?';
  M_Abort_Changes = 'Changes will be lost. Ok to proceed?';

  M_CancelTransactionPrompt = 'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Script is currently executing';
  M_SCRIPT_FAILED = 'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'Modified';
  M_SCRIPT_SAVE_CHANGES = 'Save changes?';

{ Button captions }

  C_BTN_TODAY = 'Today';
  C_BTN_CLEAR = 'Clear';
  C_BTN_FIND = 'Find';
  C_BTN_FINDNEXT = 'Find Next';
  C_BTN_REPLACE = 'Replace';
  C_BTN_UNDO = 'Undo';
  C_BTN_CUT = 'Cut';
  C_BTN_COPY = 'Copy';
  C_BTN_PASTE = 'Paste';
  C_BTN_DELETE = 'Delete';
  C_BTN_SELECTALL = 'Select All';

  C_SG_Parameter = 'Parameter';
  C_SG_Field = 'Field';
  C_SG_Name = 'Name';
  C_SG_Type = 'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'Value';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Cancel';
  C_BF_CANCEL_ACCEL = '&Cancel';
  C_BF_APPLY = 'Apply';
  C_BF_HELP = 'Help';
  C_BF_EXECUTE = 'Execute';
  C_BF_CLOSE = 'Close';
  C_BF_CLOSE_ACCEL = '&Close';
  C_BF_FINISH = 'Finish';
  C_BF_FINISH_ACCEL = '&Finish';

  C_FRM_Ordering = 'Ordering';
  C_FRM_RESTRUCTURE = 'Customize Fields Displayed';

  C_CB_WordWrap = 'Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'RowsAffected: ';
  M_SQL_RowsCounted = 'Rows Counted: ';
  M_SQL_SessionBusy = 'Session is currently busy';
  M_SQL_CompleteTransaction = 'Please complete your transaction';
  M_SQL_CannotDeleteDefaultGroup = 'The default group cannot be deleted';
  M_SQL_ReservedName = 'This name is reserved: ';
  M_SQL_BackSlashNotAllowed = 'A back slash is not allowed';
  M_SQL_BlankNameNotAllowed = 'A blank name is not allowed';
  M_SQL_RowsFetched = 'Rows Fetched: ';
  M_SQL_ConfirmDBCreation = 'Are you sure you want to create this database?';
  M_SQL_ConfirmNoOtherDBSameName = 'Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = 'Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = 'This database will be permanently removed.'+#13#10+#13#10'Continue anyway?';
  M_SQL_AskFormName = 'Enter query form name:';
  M_SQL_AskGroupName = 'Enter group name:';
  M_SQL_AskLayoutName = 'Enter layout name:';
  M_SQL_ConfirmGroupDeletion = 'Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = 'Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = 'Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'Parameter value';
  M_GCSQL_TypeAValueFor = 'Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = 'This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Select Source Database';
  M_DP_SELECT_DEST_DB = 'Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Clear';
  M_USERS_COMPLETED_OK = 'Operation completed Successfully';
  M_USERS_NO_CONNECTION = 'No IB_Connection defined.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Begin Export';
  M_EXPORT_STILL_ACTIVE = 'Export process is still active.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Browse Database';
  C_wbBrowseBtnCaption  = 'Browse';
  C_wbDSQLBtnHint       = 'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitor Database Events';
  C_wbEventsBtnCaption  = 'Events';
  C_wbExportBtnHint     = 'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Export';
  C_wbDumpBtnHint       = 'Dump Database';
  C_wbDumpBtnCaption    = 'Dump';
  C_wbPumpBtnHint       = 'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Pump';
  C_wbWhoBtnHint        = 'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Who';
  C_wbScriptBtnHint     = 'Execute Script';
  C_wbScriptBtnCaption  = 'Script';
  C_wbExtractBtnHint    = 'Extract Metadata DDL';
  C_wbExtractBtnCaption = 'Metadata Extract';
  C_wbMonitorBtnHint    = 'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profiler';
  C_wbStatusBtnHint     = 'View Status of IBO Components';
  C_wbStatusBtnCaption  = 'Status';
  C_wbUsersBtnHint      = 'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'Users';

  // Array grid
  C_AG_Row             = 'Row';
  C_AG_Column          = 'Column';

  //IBF_Who
  C_WHO_FRM            = 'Who is connected';
  C_WHO_BTNAPPLY       = 'Refresh';

  C_NB_FIRST = 'First';
  C_NB_PRIOR = 'Prior';
  C_NB_NEXT = 'Next';
  C_NB_LAST = 'Last';

  C_ST_Open = 'Open';
  C_ST_Close = 'Close';
  C_ST_Prepare = 'Prepare';
  C_ST_Unprepare = 'Unprepare';
  C_ST_ReadOnly = 'Read Only';
  C_ST_New = 'New';
  C_ST_Post = 'Post';
  C_ST_Cancel = 'Cancel';
  C_ST_Delete = 'Delete';
  C_ST_Edit = 'Edit';
  C_ST_RefreshKeys = 'Refresh Keys';
  C_ST_RefreshRows = 'Refresh Rows';
  C_ST_Refresh = 'Refresh';

{ Hints }

  H_UB_EDIT = 'Edit Row';
  H_UB_INSERT = 'Insert Row';
  H_UB_DELETE = 'Delete Row';
  H_UB_REFRESH = 'Refresh all records';
  H_UB_REFRESHKEYS = 'Refresh record keys';
  H_UB_REFRESHROWS = 'Refresh record rows';
  H_UB_REFRESHFILTROWS = 'Refresh filtered rows';
  H_UB_POSTSEARCH = 'Post search criteria';
  H_UB_CANCELSEARCH = 'Cancel search criteria';
  H_UB_POSTEDIT = 'Post edits';
  H_UB_CANCELEDIT = 'Cancel edits';
  H_UB_POSTINSERT = 'Post insert';
  H_UB_CANCELINSERT = 'Cancel insert';
  H_UB_POSTDELETE = 'Post delete';
  H_UB_CANCELDELETE = 'Cancel delete';
  H_UB_POST = 'Post changes';
  H_UB_CANCEL = 'Cancel changes';

  H_NB_FIRST = 'First Row';
  H_NB_PRIOR = 'Prior Row';
  H_NB_NEXT = 'Next Row';
  H_NB_LAST = 'Last Row';
  H_NB_JUMPBCK = 'Backwards';
  H_NB_JUMPFWD = 'Forwards';

  H_SB_ORDER = 'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Recall Last Search Criteria';
  H_SB_SEARCH = 'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Recall Criteria';
  H_SB_SEARCHCOUNT = 'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Count Rows in Dataset';
  H_SB_RESTRUCTURE = 'Customize the Fields Displayed';

  H_TB_StartTransaction = 'Start Transaction';
  H_TB_PostDatasets = 'Post Datasets';
  H_TB_CancelDatasets = 'Cancel Datasets';
  H_TB_SavePoint = 'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Commit and End Current Transaction';
  H_TB_Rollback = 'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Rollback and Retain Current Transaction';
  H_TB_Close = 'Close Current Transaction';

  H_ST_Prepare_Statement = 'Prepare Statement';
  H_ST_Unprepare_Statement = 'Unprepare Statement';
  H_ST_Execute_Statement = 'Execute Statement';

  H_DS_Open_Dataset = 'Open Dataset';
  H_DS_Close_Dataset = 'Close Dataset';
  H_DS_Prepare_Dataset = 'Prepare Dataset';
  H_DS_Unprepare_Dataset = 'Unprepare Dataset';
  H_DS_ReadOnly_Dataset = 'Read Only Dataset';

  H_CB_Create_Database = 'Create Database';
  H_CB_Connect_Database = 'Connect Database';
  H_CB_Disconnect_Database = 'Disconnect Database';
  H_CB_Drop_Database = 'Drop Database';

  H_RD_actHide = 'Hide selected Fields';
  H_RD_actHideAll = 'Hide all Fields';
  H_RD_actVisible = 'Set selected fields visible';
  H_RD_actVisibleAll = 'Set all selected fields visible';
  H_RD_actUp = 'Move selected fields one up';
  H_RD_actTop = 'Move selected fields to the top';
  H_RD_actDown = 'Move selected fields one down';
  H_RD_actBottom = 'Move selected fields to the bottom';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Export from SELECT statement';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Missing entry for Ascii file';
  eNoDestTableEntry          = 'Missing entry for destination table';
  eAsciiFileNotFound         = 'Ascii file %s not found';
  eIniFileNotFound           = 'Ini-file %s not found';
  eNoAsciiFileAccess         = 'Could not open ascii file %s';
  eInvalidCharFound          = 'Invalid char / format error in ascii file';
  eOutOfMemory               = 'Out of memory';
  eFieldDescriptionError     = 'Error in field description';
  eWrongAsciiFieldCount      = 'Wrong field count in ascii file, line (%d)';
  eWrongDecimalCount         = 'Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth           = 'Wrong field width in ascii file';

  // Metadata Extract Stuff
  // ------------------------

  // Entity Type Names
  STR_DDL_UnnamedItem = '<NO NAME>';
  STR_DDL_etDatabase = 'Database';
  STR_DDL_etException = 'Exception';
  STR_DDL_etBlobFilter = 'Blob Filter';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Generator';
  STR_DDL_etDomain = 'Domain';
  STR_DDL_etTable = 'Table';
  STR_DDL_etView = 'View';
  STR_DDL_etProcedure = 'Procedure';
  STR_DDL_etRole = 'Role';
  STR_DDL_etPrimaryKey = 'Primary Key';
  STR_DDL_etUniqueKey = 'Unique Key';
  STR_DDL_etForeignKey = 'Foreign Key';
  STR_DDL_etConstraint = 'Constraint';
  STR_DDL_etIndex = 'Index';
  STR_DDL_etTrigger = 'Trigger';
  STR_DDL_etPermission = 'Permission';
  STR_DDL_etUDFParam = 'UDF Parameter';
  STR_DDL_etTableField = 'Table Field';
  STR_DDL_etViewField = 'View Field';
  STR_DDL_etProcParam = 'Procedure Parameter';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Create Database';
  STR_DDL_coSecondaryFiles = 'Define Secondary Files';
  STR_DDL_coDefineShadows = 'Define Shadows';
  STR_DDL_coSetGeneratorVal = 'Set Generator Value';
  STR_DDL_coResetExceptionNo = 'Reset Exception Number';
  STR_DDL_coRawFieldDefs = 'Raw Field Definitions';
  STR_DDL_coIsolateAllComputed = 'Isolate All Computed Fields';
  STR_DDL_coReportMinor = 'Report Minor';
  STR_DDL_coAlwaysQuoted = 'Always Quoted';
  STR_DDL_coAlwaysCharSet = 'Always Define Character Set';
  STR_DDL_coIncludeDebug = 'Include Debug Comments';
  STR_DDL_coDescripAsComment = 'Descriptions as Comments';
  STR_DDL_coIgnoreDependencies = 'Ignore Dependencies';
  STR_DDL_coKeepCustomIndexNames = 'Keep Custom Index Names';
  STR_DDL_coUseBigInt = 'Use BIGINT';

  // CodePass Names
  STR_DDL_cpFull = 'Full';
  STR_DDL_cpInit = 'Initial';
  STR_DDL_cpFinal = 'Final';
  STR_DDL_cpAuto = 'Automatic';

  // Problem level names
  STD_DDL_plNone       = 'None';
  STD_DDL_plMinor      = 'Minor';
  STD_DDL_plSuspicious = 'Suspicious';
  STD_DDL_plWarning    = 'Warning';
  STD_DDL_plError      = 'Error';
  // abbreviated Problem level names (to 5 characters)
  STD_DDL_plNone_s       = 'NONE ';
  STD_DDL_plMinor_s      = 'MINOR';
  STD_DDL_plSuspicious_s = 'SUSP ';
  STD_DDL_plWarning_s    = 'WARN ';
  STD_DDL_plError_s      = 'ERROR';

  // Dialog strings
  STR_DDL_DialogCaption = 'Metadata Extract';
  STR_DDL_Configure = 'Configure';
  STR_DDL_Filters = 'Filters';
  STR_DDL_Script = 'Script';
  STR_DDL_MetadataControls = 'Metadata Controls';
  STR_DDL_CodeOptions = 'Code Options';
  STR_DDL_Entities = 'Entities';
  STR_DDL_Terminator = 'Terminator';
  STR_DDL_InsertCommits = 'Insert Commits';
  STR_DDL_ExecuteControls = 'Execute Controls';
  STR_DDL_CodePass = 'Code Pass';
  STR_DDL_ExtractToStrings = 'Extract To Strings';
  STR_DDL_Reset = 'Reset';
  STR_DDL_ResetAll = 'Reset All';
  STR_DDL_ProgressControls = 'Progress Controls';
  STR_DDL_Stop = 'Stop';
  STR_DDL_IncludeSystem = 'Include System Objects';
  STR_DDL_NameMasks = 'Name Masks';
  STR_DDL_SaveToFile = 'Save To File';
  STR_DDL_RunScript = 'Run Script';
  STR_DDL_ScriptCommands = '&Script Commands';

  // Errors/Problems reported during extract processing
  // Note that all replaceable parameters use %s (string), any necessary
  // conversions will be performed in the code.
  E_DDL_CURSOR_NOT_CREATED = 'Cursor Not Created';
  E_DDL_BLANK_NAME         = 'Blank Name';
  E_DDL_ENTITY_NOT_FOUND   = 'Entity Not Found';
  E_DDL_RESERVED_NAME      = 'Reserved name used for non-system entity.';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Database Character set %s was not found to get its canonic name';
  E_DDL_MODULE_NAME_EMPTY  = 'Module name is empty';
  E_DDL_ENTRY_POINT_EMPTY  = 'Entry point is empty';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'External domain only can be implicit';
  E_DDL_DOMAIN_TYPE_16     = 'Type 16 can be only NUMERIC or DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'Charset Id was NULL, assuming NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Missing name for charset ID %s Assuming NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'BytesPerCharacter was zero in charset %s';
  E_DDL_FIELDLEN_MISMATCH  = 'FieldLength %s should be multiple of %s bytes per character in charset name %s';
  E_DDL_INVALID_COLLATIONID = 'Collation Id cannot be < 0 but is %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Collation Id was NULL, assuming %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Unknown FieldType %s';
  E_DDL_CSTRING_IN_DSQL = 'FieldType CSTRING is not accepted by DSQL';
  E_DDL_QUAD_IN_DSQL = 'FieldType QUAD is not accepted by DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Suspicious check: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Declared but void check constraint';
  E_DDL_EXPLICIT_COMPUTED = 'Explicit domain cannot be COMPUTED';
  E_DDL_VOID_COMPUTED = 'Declared but void COMPUTED BY clause';
  E_DDL_SUSPICIOUS_DEFAULT = 'Suspicious default: %s';
  E_DDL_VOID_DEFAULT = 'Declared but void default';
  E_DDL_DIMENSIONS_MISMATCH = 'Declared with %s dimensions but details for %s dimensions where found.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Implicit Domain has no relation.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Implicit Domain has missing relation or field name.';
  E_DDL_NO_OUTPUT_PARAMETER = 'No Output Parameter';
  E_DDL_NO_GRANTOR = 'Grantor not specified';
  E_DDL_VIEW_NO_BLR = 'Has not view_blr but it appears in rdb$view_relations as a VIEW';
  E_DDL_VIEW_NO_VIEW_RELATION = 'Has view_blr but it doesn''t appear in rdb$view_relations as a VIEW';
  E_DDL_NO_OWNER = 'Owner name is not specified';
  E_DDL_FORMAT_VERSION = 'Format version at %s';
  E_DDL_DBKEY_LEN = 'DbKey_Length should be 8 but is %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'Domain/Field Definition for field %s not found';
  E_DDL_NO_SOURCE_CODE = 'Has no source code available';
  E_DDL_WITH_CHECK_COMPLETION = '"With check" completed to "with check option"';
  E_DDL_NO_BLR = 'Has no BLR available';
  E_DDL_CORRUPT_SOURCE = 'Source prefix not recognised, this could indicate corruption';
  E_DDL_INDEX_ID_NULL_INACTIVE = 'Id is NULL and index is inactive';
  E_DDL_INDEX_ID_NULL_ACTIVE = 'Id is NULL but index is active';
  E_DDL_INVALID_INDEX_ID = 'Id should start at 1 not at %s';
  E_DDL_FK_INDEX_NO_CONSTRAINT = 'Declares foreign key but it is not found in relation constraints as FK index';
  E_DDL_CONSTRAINT_NO_FK_INDEX = 'Does not declare foreign key but it is found in relation constraints as FK index';
  E_DDL_INDEX_MULTI_USE = 'Used in %s relation constraints at the same time';
  E_DDL_INDEX_NO_FIELDS = 'Uses %s fields';
  E_DDL_INDEX_DUPLICATE = 'Appears to be a duplicate index definition on table: %s';
  E_DDL_INDEX_SEG_MISMATCH = 'Index on table: %s declared %s segments, but details for %s segments where found';
  E_DDL_CONSTRAINT_OUT_OF_RANGE = 'Constraint type %s is out of range';
  E_DDL_CONSTRAINT_USING_INDEX = 'Constraint type %s should not use an index but is using index: %s';
  E_DDL_CONSTRAINT_NO_INDEX = 'Constraint type %s should use an index but is not using one';
  E_DDL_UPDATE_RULE_INVALID = 'Update rule %s is out of range';
  E_DDL_DELETE_RULE_INVALID = 'Delete rule %s is out of range';
  E_DDL_PARENT_CONSTRAINT_EMPTY = 'Constraint name for parent relation is empty';
  E_DDL_FOREIGN_NOT_DEFINED = 'Foreign Table or Index is not defined';
  E_DDL_PARENT_SHOULD_BE_EMPTY = 'Constraint name for parent relation should be empty but is %s';
  E_DDL_UPDATE_SHOULD_BE_EMPTY = 'Update rule should be empty but is %s';
  E_DDL_DELETE_SHOULD_BE_EMPTY = 'Delete rule should be empty but is %s';
  E_DDL_NO_BLR_WITH_CHECK =  'Has no source code available, possibly used for view %s with check option';
  E_DDL_TRIGGER_LOST_CHECK = 'Starts with "CHECK" keyword. It is used by a check constraint that has been lost';
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Unknown trigger type %s';
  E_DDL_NEGATIVE_SEQUENCE = 'Has negative sequence %s';
  E_DDL_NO_TARGET_RELATION = 'Target table or view is not specified';
  E_DDL_NOT_IN_DEPENDENCIES = 'Declared but not found in dependencies. It is not a bug in some special cases';
  E_DDL_SUSPICIOUS_TRIGGER = 'Suspicious trigger depends on other tables but not on the one it is attached to';
  E_DDL_INVALID_TRIGGER_SEQ = 'Trigger sequence is %s but should be less than 1 for an implicit trigger';
  E_DDL_GRANT_OUT_OF_RANGE = 'Grant/Admin option out of 0..2 range: %s';
  E_DDL_GRANT_TO_USER_TYPE = 'Grant/Admin option given to user type %s';
  E_DDL_GRANT_FIELDS = 'Trying to set specific fields but the privilege is not U or R';
  E_DDL_EXECUTE_TO_OBJECT = 'Assigning EXECUTE on object type %s that should be 5 (proc) instead';
  E_DDL_BAD_PRIV_ON_PROC = 'Assigning %s on procedure %s';
  E_DDL_MEMBER_TO_OBJECT = 'Assigning membership on object type %s that should be 13 (role) instead';
  E_DDL_BAD_PRIV_ON_ROLE = 'Assigning %s on role %s';
  E_DDL_BAD_ARG_POS =  'Argument position must be >=0 but is %s';
  E_DDL_SYSTEM_FLAG_MISMATCH = 'SystemFlag different to parent';
  E_DDL_BAD_FIELD_ID = 'Field Id must be >=0 but is %s';
  E_DDL_BAD_FIELD_POS = 'Field position must be >=0 but is %s';
  E_DDL_BAD_TABLE_BASEFIELD = 'BaseField should be empty for tables but is %s';
  E_DDL_BAD_TABLE_VIEWCONTEXT = 'ViewContext should be empty for tables but is %s';
  E_DDL_MANDATORY_IN_VIEW = 'Cannot be mandatory in a view';
  E_DDL_BASEFIELD_EMPTY = 'BaseField should not be empty for views if ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext cannot be empty for views';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext should be >= 0 for views';
  E_DDL_BAD_PARAM_TYPE = 'Parameter type %s is out of range';
  E_DDL_BAD_PARAM_NUM = 'Parameter number must be >=0 but is %s';

  // Comments output with DDL statements
  C_DDL_CONNECT_USERNAME   = 'Connect using username: %s';
  C_DDL_CONNECT_SERVER_VER = 'and server: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'No Secondary Files';
  C_DDL_SEC_FILES = 'Secondary Files';
  C_DDL_SEC_FILE_DESC = '%s, Start: %s, Length: %s';
  C_DDL_NO_SHADOW_FILES = 'No Shadow Files';
  C_DDL_SHADOW_FILES = 'Shadow Files';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, Start: %s, Length: %s';
  C_DDL_EXCEPTION_DESC = 'Exception: %s, Original Number: %s';
  C_DDL_FIELD_NOT_FOUND = 'Field Not Found: %s';
  C_DDL_INDEX_NOT_FOUND = 'Index Not Found';
  C_DDL_NO_FOREIGN_RELATION = 'No Foreign Relation or Index Defined To Constraint';
  C_DDL_FOREIGN_NOT_FOUND = 'Foreign Relation Not Found: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Foreign Index Not Found: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Trigger Not Found: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Invalid Constraint Type Name: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'No Source For Trigger: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'TriggerType Unknown: %s';
  C_DDL_BAD_PRIVILEGE = 'Unknown Privilege: %s';


implementation

end.
