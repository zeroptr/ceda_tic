
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
{  Additions or modifications lised below using format:                        }
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
{ Translated by: Michael Muza <m2m@mail.ru>                                    }
{ edited and added by: Oliph <khabibr@mail.ru>   http://www.oliph.hut.ru       }
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
  IB_VERSION_SUB_RELEASE = '';

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
  IB_ISC_ERR_CODE_MSG = '��� ������ ISC:';
  IB_ISC_ERR_MSG_MSG  = '��������� ������ ISC:';
  IB_SQL_ERR_CODE_MSG = '��� ������ SQL:';
  IB_SQL_ERR_MSG_MSG  = '��������� ������ SQL:';

// Global Defaults  ( Do NOT localize these )
  G_DefaultRowHeight = 17;

  DTEncode_DateDelimit     = '/';
  DTEncode_TimeDelimit     = ':';
  DTEncode_DateTimeDelimit = ' ';
  DTEncode_DecodeFormat    = '%.4u/%.2u/%.2u %.2u:%.2u:%.2u.%.3u0';
  DTEncode_DateTimeFormat  = 'YYYY"/"MM"/"DD" "HH":"MM":"SS".0000"';
  DT_DateFormat            = 'MM"/"dd"/"yyyy';
  DT_TimeFormat            = 'hh":"nn":"ss';

{ These may be localized. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = '���������� �� ����� IB Objects.'#10#13#10#13 +
                   '����������� ���������� �� http://www.ibobjects.com � ��������������� �������.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = '���������� ��� ���� �����������';
  E_NOT_CONNECTED     = '���������� �� ���� �����������';
  E_Invalid_conn_path = '�������� ���� ��� ����������';
  E_Cant_Repl_Int_Tr  = '���������� �������� ���������� (�� ���������) ����������';
  E_NO_TRANS_STARTED  = '���������� �� ����������';
  E_TRANS_STARTED     = '���������� ��� ����������';
  E_NO_CONNECTIONS    = '���������� �� ����� ����������';
  E_NOT_ENOUGH_CONN   = '���������� ��������� ������ ��� ����� ����������';
  E_CONN_LOADING      = '��������������: ���������� ��� ��� ���������������';
  E_TRANS_CONN_SESS   = '��� ���������� ������ ���� ��� � ����� � ��� �� IB_Session';
  E_TransactionPaused = '���������� ��������������';
  E_ALLOCATED         = 'SQL-������ ��� ��������';
  E_NOT_ALLOCATED     = 'SQL-������ �� ��� ��������';
  E_PREPARED          = 'SQL-������ ��� ��� �����������';
  E_NOT_PREPARED      = 'SQL-������ �� ��� �����������';
  E_FAILED_TO_PREPARE = 'SQL-������ �� ����� ���� �����������';
  E_OPENED            = 'SQL-������ ��� ��� ������';
  E_NOT_OPENED        = 'SQL-������ �� ��� ������';
  E_CANT_DELETE       = '������� ������ � ������� �� ����� ���� �������';
  E_NO_CONNECTION     = 'SQL-������ ������ ����� ����������� IB_Connection';
  E_CONNECT_FAILED    = '���������� ������� IB_Connection';
  E_NO_TRANSACTION    = 'SQL-������ ������ ����� ����������� ����������';
  E_NO_ACTIVE_TRANS   = '��� �������� ����������, ����� ��������� ������';
  E_START_FAILED      = '���������� ���������� ����������';
  E_SVRAUTOCMT_NOEXP  = '����� ���������� ����������� � ServerAutoCommit';
  E_Cannot_Activate     = '�������� ��������� ����������. ���������� ��������������';
  E_Transaction_Is_Active = '���������� ������������� ���������';
  E_Failed_To_Post_Datasets = '���������� ���������� ��������� �� ���� ������� ������';
  E_Failed_To_Cancel_Datasets = '���������� �������� ��������� �� ���� ������� ������';
  E_UpdateWrongTrn    = '���������� ������� ���������, %s - �� ����������� %s';
  E_NO_BLANK_SQL      = '������ SQL-����������� �����������';
  E_AT_END_OF_FILE    = '����� �����';
  E_AT_END_OF_CURSOR  = '����� "�������"';
  E_AT_END_OF_BUFFER  = '����� ������';
  E_AT_END_OF_DATASET = '����� ������ ������';
  E_BAD_SQL_INF_LEN   = '�������������� ����� � isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = '������������ ������ ������������ �� isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = '���������� �������� ��� �������, ���� �������';
  E_REQUEST_LIVE_ACTIVE = '���������� �������� �������� RequestLive, ���� �������';
  E_REQUEST_LIVE_READONLY = '���������� ������������� RequestLive ��� ������ ������ ������ ��� ������';
  E_CURSOR_UNI              = 'IB_CURSOR - ����������������';
  E_UNSUPPORTED_COLUMN_TYPE  = '���������������� ��� ����: %d';
  E_FIELDNO_NOT_FOUND         = '����� ����: %d �� ������';
  E_FIELDNAME_NOT_FOUND        = '��� ���� "%s" �� �������';
  E_INVALID_FOCUS_RELATION_NO   = '������������ ����� ��������� (Focused Relation): %d';
  E_INVALID_FOCUS_RELATION_NAME = '������������ ��� ��������� (Focused Relation): %s';
  E_INVALID_QBE_IN              = 'IN( �������� [ , �������� ... ] ) - �������������� ������';
  E_INVALID_QBE_BETWEEN         = 'BETWEEN �������� AND �������� - �������������� ������';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = '���������� ����� ������ DLL "%s"';
  E_INVALID_SQL_KEY_FIELDS  = '������������ �������� SQLKeyFields';
  E_GET_CURSOR_ERROR       = '���������� ������� ������ ��� �����';
  E_SCROLL_ERROR           = '���� ������ ��� �������'#10#13'���������� ������� ������';
  E_INVALID_BUFFER_ROW_NUM = '�������� BufferRowNum � ������';
  E_BLANK_STATEMENT      = '���������� ����������� ������ SQL-������';
  E_UNKNOWN_STATEMENT   = '������� ��������� ����������� SQL-��������';
  E_CIRCULAR_REFERENCE = '����������� ������ �� �����������';
  E_CANT_CHG_WITH_CONN = '���������� ������� ���������, ���� ����������� ����������';
  E_LOGIN_FAILED      = '����������� ����������';
  E_CANT_GET_CONN_CHR = '���������� �������� �������������� ����������';
  E_MAX_EVENTS_BLOCK  = '���������� ������������� ���������� ������� ��� ������ �����';
  E_PROCESSING_EVENTS = '��������� ������� '#13#10'������ �������� �����������';
  E_CANT_STORE_BLOB  = 'Blob ��� ��� ��� �� ��� ���� ��������';
  E_CANT_LOAD_BLOB   = 'Blob ��� ��� ��� �� ��� ���� ��������';
  E_CANNOT_CANCEL_ROW = '���������� �������� ��������� � ������� ������';
  E_CANNOT_POST_ROW  = '���������� ����������� ��������� � ������� ������';
  E_DatasetClosed     = '����� ������ ���������';
  E_DatasetOpen        = '����� ������ � ������ ����� ������';
  E_DatasetCannotScroll = '���������� ������������ �� ������ ������';
  E_DatasetReadOnly     = '����� ������ ������ ��� ������';
  E_DatasetIsFetching    = '����� ������ � ������ ����� ��������� ��������';
  E_Invalid_KeyRelation   = '������������ �������� KeyRelation';
  E_RowNum_Not_Implemented = '���� ���������� ���������� RowNum';
  E_RowDeleted            = '������ ���� �������';
  E_END_OF_DATASET        = '����� ������ ������';
  E_BEGINNING_OF_DATASET   = '������ ������ ������';
  E_Cannot_Pessimistic_Lock = '���������� ������������ �������������� ���������� � LockWait';
  E_Cannot_Edit_Row      = '���������� ������������� ������� ������';
  E_Cannot_Insert_Row  = '���������� �������� ����� ������';
  E_Cannot_Delete_Row = '���������� ������� ������� ������';
  E_Cannot_Search    = '����� �� ��������';
  E_Cannot_Navigate = '���������� ������������';
  E_Record_Locked    = '������ ������������� ������ �������������';
  E_Record_OutOfSynch = '������ ���� �������� ������ �������������';
  E_FLD_READONLY       = '���� "%s" - ������ ��� ������';
  E_Required_Field       = '�� ��������� ���� "%s"';
  E_NO_POSTRTN_CACHED_UPDT = '���������� ������������ PostRetaining � ������������� �����������';
  E_Multiple_Rows_In_Singleton = '������������� ������ � ��������� �������';

  E_InvalidRowsAffectedBuf = '������������ ����� RowsAffected';
  E_Invalid_RowNum_Past_Eof = '������������ RowNum - �� ������';
  E_Invalid_RowNum_Before_Bof = '������������ RowNum - ����� �������';
  E_Invalid_Bookmark = '������������ ������ �������� (Bookmark)';

  E_Assign_Column  = '���������� ��������� �� ���� "%s"';
  E_AssignTo_Column = '���������� ��������� ���� "%s"';
  E_Value_Out_Of_Range = '�������� ����� �� ������� ���������';
  E_SmallintOverflow = '������������ Smallint';
  E_IntegerOverflow = '������������ Integer';
  E_Int64Overflow = '������������ Int64';
  
  E_Unsupported_Column = '���������������� ��� ����: %d';
  E_UndefinedMacro = '�������������� ������';
  E_GeneratorFailed = '���������� �������� �������� ����������';

  E_MustBe_Buffered_Dataset = '(IB_Query) ������ ���� ����������� TIB_BDataset';

  E_NO_CHANGE_READONLY = '���������� �������� ReadOnly ����� ������';
  E_NO_CHANGE_ISOLATION = '���������� �������� Isolation ����� ������';
  E_NO_CHANGE_RECVERSION = '���������� �������� RecVersion ����� ������';
  E_NO_CHANGE_LOCKWAIT = '���������� �������� LockWait ����� ������';

  E_Invalid_Reference_To_Delete = '�������� ������ ��� ��������';
  E_Invalid_Typecast = '�������������� �����';
  E_Invalid_DataPump_Statement = '�������� ��� ��������� ��� DataPump';
  E_FIELD_NOT_NULLABLE = '��������� ���� (NOT NULL) �� ����� ����� �������� null';
  E_DATABASE_BLANK = 'DatabaseName �� ����� ���� ������';
  E_Unsupp_Col_Conversion = '���������������� �������������� ����';
  E_Unable_To_Locate_Record = '���������� ����� ������';
  E_Record_Not_Inserted = '������ �� ���� ���������';
  E_Invalid_KeyLinks = '������������ ��������� KeyLinks: %s';
  E_Unable_to_perform_search = '���������� ��������� �����';
  E_Unassigned_Blob_Node = '������������� BlobNode';
  E_Unassigned_Transaction = '������������� Transaction';
  E_Invalid_RowsAffected_Buffer = '������������ ����� RowsAffected';
  E_Unable_Save_Graphic = '���������� ��������� ��� �������';
  E_Cannot_Activate_Transaction = '���������� �������������� ����������';
  E_IB_Client_Not_Installed = '�� ���������� InterBase ������ GDS32.DLL';
  E_Could_Not_Load_Memo = '���������� ��������� memo';
  E_Invalid_DPB_Over_255 = '������������ DPB: �������� ����� 255 ��������';
  E_Inv_Custom_DML = '������������ DML �������� ����: %s';
  E_Record_Not_Located_For_Update = '������ ��� ��������� �� �������';
  E_Record_Not_Located_For_Delete = '������ ��� �������� �� �������';
  E_Init_Default_SQL_Failed = '���������� ���������������� �������� �� ��������� ��� "%s"';
  E_Stringlist_Not_Sorted = 'Stringlist ������ ���� ������������ ��� ���� ��������';
  E_Cannot_Change_Events = '���������� �������� ������� ���� ���� ���������';
  E_Cannot_Unregister_Events = '���������� �������� �����������, ���� ���� ���������';
  E_Invalid_Internal_Transaction = '������������ ���������� ���������� IB_Transaction';
  E_InvalidStatementType = '������������ ��� ���������';
  E_Multiple_Records_Updated = '��������� ������������� �������';
  E_Multiple_Records_Deleted = '�������� ������������� �������';
  E_Multiple_Records_Inserted = '���������� ������������� �������';
  E_DUP_DB_NAME = '������������ DatabaseName �� �����������';
  E_INVALID_DB_NAME = '������������ DatabaseName';
  E_UnableToSearch_NoOrdering = '���������� ��������� �����, �� ��������� ������� ����������';
  E_UnableToSearch_DatasetBusy = '���������� ��������� �����, ����� ������ ����� ����������� ������� (fetching)';
  E_NoRecordsFound = '�� ���������� ������� �������';
  E_Session_Undefined = 'Session �� ����������';
  E_NoCircularRef = '����������� ������ �� �����������';
  E_InvalidClassType = '������������ ��� ������';
  E_Invalid_RowNum = '������������ RowNum';
  E_Invalid_Syntax = '������������ ���������: �������������� ��� ������������� ������';
  E_Array_Is_Null = '������ - Null';

  E_Cannot_add_blank_account = '���������� �������� ������ ������� ������';
  E_Cannot_add_SYSDBA_account = '���������� �������� ������� ������ SYSDBA';
  E_Cannot_delete_blank_account = '���������� ������� ������ ������� ������';
  E_Cannot_delete_SYSDBA_account = '���������� ������� ������� ������ SYSDBA';
  E_Cannot_modify_blank_account = '���������� �������� ������ ������� ������';

  E_PLAN_ERROR = '������ PLAN!';
  E_PLAN_EXCEPTION = '�������������� �������� PLAN!';

  E_INV_CREATE_CONNECT_DROP = '�������� ��������� CREATE, CONNECT ��� DROP DATABASE';
  E_Unsupported = '�� ��������������';
  E_NotImplemented = '�� �������������� �� ���� ������';
  E_Invalid_ColData = '�������� ColData';

  E_Cant_Unprepare_executing_process = '���������� ��������� Unprepare ��� ���������� ��������';
  E_FileName_Required = '��������� ��� �����';

{ Labels for various default dialogs used in IBO }

//IBF_Users
  L_USERS_FRM = '���������� �������� �������� �������������';
  L_USERS_ADD = '��������';
  L_USERS_DELETE = '�������';
  L_USERS_MODIFIY = '��������';
  L_USERS_ACCOUNT = '������� ������';
  L_USERS_PASSWORD = '������';
  L_USERS_GROUP = '������';
  L_USERS_FIRSTNAME = '���';
  L_USERS_MIDDLENAME = '�������';
  L_USERS_LASTNAME = '��������';

//IBF_Export
  L_EXPORT_FRM = '�������';
  L_EXPORT_ASCII = ' ������ ����� ';
  L_EXPORT_FIXED = '� ������������� ������';
  L_EXPORT_DELIMITED = '� ����������������';
  L_EXPORT_DBF  = 'DBF';
  L_EXPORT_ASCIIOPT  = ' ASCII - ��������� ';
  L_EXPORT_DELIMITER  = '��������������';
  L_EXPORT_SEPARATOR  = '�����������';
  L_EXPORT_DATEFORMAT  = '������ ����';
  L_EXPORT_INCLUDEHEADERS  = '������� ���������';
  L_EXPORT_INCLUDECRLF  = '�������� <CR><LF>';
  L_EXPORT_SDEXPORTTITLE = '�������';
  L_EXPORT_SDEXPORTFILTERCSV = '��������� ����� � ������������� ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = '��������� ����� ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF ����� ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = '�� ������������� ������ ��������?';
  M_Fetching_Query_Results = '������� �����������'; // �������
  M_Row_Num = '������ � %d';
  M_Abort_Fetching_Btn = '��������';

  M_Login_Database = '����';
  M_Login_User = '���';
  M_Login_Password = '������';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = '������';
  M_Login_Help_Btn = '&������';
  M_Login_Dialog_Caption = '������ ����������� � ���� ������';

  M_Loading_Caption = '��������...';

  M_SB_REC_CNT = '���������� �������: %d';
  M_Save_Changes = '��������� ���������?';
  M_Abort_Changes = '��������� ����� ��������. ����������?';  

  M_CancelTransactionPrompt = '�� ������������� ������ �������� ��� ���������?';

  M_SCRIPT_ABORT_EXECUTE = '���������� �� ���������� ����� �������?';
  M_SCRIPT_CONTINUE_EXECUTING = '���������� ���������� ����� �������?';
  M_SCRIPT_IS_EXECUTING = '������ � ������ ����� �����������';
  M_SCRIPT_FAILED = '������ �� ����� �����������';
  M_SCRIPT_WAS_ABORTED = '���������� ������� ���� ��������';
  M_SCRIPT_COMPLETED = '������ �������� ��� ������';
  M_SCRIPT_CMPL_EXCEPT = '������ �������� � ��������';
  M_SCRIPT_MODIFIED = '������';
  M_SCRIPT_SAVE_CHANGES = '��������� ���������?';

{ Button captions }

  C_BTN_TODAY = '�������';
  C_BTN_CLEAR = '��������';
  C_BTN_FIND = '�����';
  C_BTN_FINDNEXT = '����� �����';
  C_BTN_REPLACE = '��������';
  C_BTN_UNDO = '��������';
  C_BTN_CUT = '��������';
  C_BTN_COPY = '����������';
  C_BTN_PASTE = '��������';
  C_BTN_DELETE = '�������';
  C_BTN_SELECTALL = '�������� ���';

  C_SG_Parameter = '��������';
  C_SG_Field = '����';
  C_SG_Name = '���';
  C_SG_Type = '���';
  C_SG_Info = '�����������';
  C_SG_Value = '��������';
  
  C_BF_OK = 'OK';
  C_BF_CANCEL = '������';
  C_BF_CANCEL_ACCEL = '&������';
  C_BF_APPLY = '���������';
  C_BF_HELP = '������';
  C_BF_EXECUTE = '���������';
  C_BF_CLOSE = '�������';
  C_BF_CLOSE_ACCEL = '&�������';
  C_BF_FINISH = '���������';
  C_BF_FINISH_ACCEL = '&���������';

  C_FRM_Ordering = '����������';
  C_FRM_RESTRUCTURE = '���������� ������������ ����';

  C_CB_WordWrap = '������� ����';

// IBF_SQL
  M_SQL_RowsAffected = '���������� ����� :';
  M_SQL_RowsCounted = '���������� �����: ';
  M_SQL_SessionBusy = '������ � ������ ������ ������';
  M_SQL_CompleteTransaction = '��������� ���������� ����������';
  M_SQL_CannotDeleteDefaultGroup = '������ �� ��������� �� ����� ���� �������';
  M_SQL_ReservedName = '��� ��� ���������������: ';
  M_SQL_BackSlashNotAllowed = '�������� ���� ���������� ';
  M_SQL_BlankNameNotAllowed = '������ ��� �����������!';
  M_SQL_RowsFetched = '������� �������: ';
  M_SQL_ConfirmDBCreation = '�� ������������� ������ ������� ���� ������?';
  M_SQL_ConfirmNoOtherDBSameName = '��������������, ��� ���� ������ � ����� ������ �� ����������.';
  M_SQL_ConfirmDBDrop = '���� ������ ����� ��������������� ����������.'+#13#10+#13#10'����������?';
  M_SQL_ReConfirmDBDrop = '�� ������������� ������ ������� ���� ������?';
  M_SQL_AskFormName = '������� ��� ����� �������: ';
  M_SQL_AskGroupName = '������� ��� ������: ';
  M_SQL_AskLayoutName = '������� ��� �����(layout): ';
  M_SQL_ConfirmGroupDeletion = '�� ������������� ������ ������� ������ "%s" �� ����� ���������� ����������?';
  M_SQL_ConfirmLayoutDeletion = '�� ������������� ������ ������� �����(layout) :  %s?';
  M_SQL_RecursiveCopyNotAllowed = '����������� ����������� �����������!';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = '������ �������� �� �������� ��� ������� Enter �� ���������� ��������'; // 'Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = '�������� ���������'; // 'Parameter value';
  M_GCSQL_TypeAValueFor = '������� �������� ��� %s '; // 'Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = '��� ��������� �� ����� ���������� �����'; // 'This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = '������� �������� ������ (Data Pump) �������'; // 'Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = '�� �������?'; // 'Are you sure?';
  M_DP_SELECT_SOURCE_DB = '������� ����-�������� ������'; // 'Select Source Database';
  M_DP_SELECT_DEST_DB = '������� ����-�������� ������'; // 'Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = '��������';
  M_USERS_COMPLETED_OK = '�������� ��������� �������';
  M_USERS_NO_CONNECTION = '�� ���������� ���������� IB_Connection';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = '��������� ���� ����������?'; // 'Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = '������ �������';
  M_EXPORT_STILL_ACTIVE = '������� �������� �������.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = '�������� ���� ������';
  C_wbBrowseBtnCaption  = '��������';
  C_wbDSQLBtnHint       = '��������� ������ � ���� ������';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = '������� ������� ���� ������';
  C_wbEventsBtnCaption  = '�������';
  C_wbExportBtnHint     = '������� ������ �� ����';
  C_wbExportBtnCaption  = '�������';
  C_wbDumpBtnHint       = '���� ���� ������';
  C_wbDumpBtnCaption    = '����';
  C_wbPumpBtnHint       = '������� ������ �� ������ ���� ������';
  C_wbPumpBtnCaption    = '�������';
  C_wbWhoBtnHint        = '����������, ��� ����������� � ���� ������';
  C_wbWhoBtnCaption     = '���';
  C_wbScriptBtnHint     = '��������� ������';
  C_wbScriptBtnCaption  = '������';
  C_wbExtractBtnHint    = '������� DLL'; //'Extract DDL';
  C_wbExtractBtnCaption = '�������'; //'Extract';
  C_wbMonitorBtnHint    = '������������ SQL � API ������';
  C_wbMonitorBtnCaption = '�������';
  C_wbProfilerBtnHint   = '������� ���������� ���� ������';
  C_wbProfilerBtnCaption= '�������';
  C_wbStatusBtnHint     = '�������� ������� IBO �����������'; //'View Status of IBO Components';
  C_wbStatusBtnCaption  = '������'; // 'Status';
  C_wbUsersBtnHint      = '����������������� ������������� ��� ������� ���� ������';
  C_wbUsersBtnCaption   = '������������';

  // Array grid
  C_AG_Row             = '������';
  C_AG_Column          = '�������';

  //IBF_Who
  C_WHO_FRM            = '��� �����������';
  C_WHO_BTNAPPLY       = '��������';

  C_NB_FIRST = '������';
  C_NB_PRIOR = '����������';
  C_NB_NEXT = '���������';
  C_NB_LAST = '���������';

  C_ST_Open = '�������';
  C_ST_Close = '�������';
  C_ST_Prepare = '�����������';
  C_ST_Unprepare = '���. ����������';
  C_ST_ReadOnly = '������ ������';
  C_ST_New = '�����';
  C_ST_Post = '�����������';
  C_ST_Cancel = '��������';
  C_ST_Delete = '�������';
  C_ST_Edit = '��������';
  C_ST_RefreshKeys = '�������� �����';
  C_ST_RefreshRows = '�������� ������';
  C_ST_Refresh = '��������';

{ Hints }

  H_UB_EDIT = '������������� ������';
  H_UB_INSERT = '�������� ������';
  H_UB_DELETE = '������� ������';
  H_UB_REFRESH = '�������� ��� ������';
  H_UB_REFRESHKEYS = '�������� ����� �������';
  H_UB_REFRESHROWS = '�������� ������� �������';
  H_UB_REFRESHFILTROWS = '�������� ��������������� �������';
  H_UB_POSTSEARCH = '����������� �������� �������';
  H_UB_CANCELSEARCH = '�������� �������� �������';
  H_UB_POSTEDIT = '����������� ���������';
  H_UB_CANCELEDIT = '�������� ���������';
  H_UB_POSTINSERT = '����������� ����������';
  H_UB_CANCELINSERT = '�������� ����������';
  H_UB_POSTDELETE = '����������� ��������';
  H_UB_CANCELDELETE = '�������� ��������';
  H_UB_POST = '����������� ���������';
  H_UB_CANCEL = '�������� ���������';

  H_NB_FIRST = '������ ������';
  H_NB_PRIOR = '���������� ������';
  H_NB_NEXT = '��������� ������';
  H_NB_LAST = '��������� ������';
  H_NB_JUMPBCK = '�����';
  H_NB_JUMPFWD = '������';

  H_SB_ORDER = '������� ������� � �������';
  H_SB_LAST_CRITERIA = '������� ��������� ��������';
  H_SB_SEARCH = '������� ������';
  H_SB_SAVE_CRITERIA = '��������� ��������';
  H_SB_CLEAR_CRITERIA = '�������� ��������';
  H_SB_RECALL_CRITERIA = '������� ��������';
  H_SB_SEARCHCOUNT = '���������� ������� � ������� �� ��������';
  H_SB_COUNT = '���������� ������� � �������';
  H_SB_RESTRUCTURE = '���������� ������������ ����';

  H_TB_StartTransaction = '���������� ����������';
  H_TB_PostDatasets = '��������� ��������� � ������� ������';
  H_TB_CancelDatasets = '�������� ��������� � ������� ������';
  H_TB_SavePoint = '��������� � ���������� ������� ����������';
  H_TB_CommitRetain = '���������, ��������� � ���������� ������� ����������';
  H_TB_Commit = '��������� � ��������� ������� ����������';
  H_TB_Rollback = '�������� � ��������� ������� ����������';
  H_TB_RollbackRetain = '�������� � ������� ������� ����������';
  H_TB_Close = '������� ������� ����������';

  H_ST_Prepare_Statement = '����������� ������';
  H_ST_Unprepare_Statement = '�������� ���������� �������';
  H_ST_Execute_Statement = '��������� ������';

  H_DS_Open_Dataset = '������� ����� ������';
  H_DS_Close_Dataset = '������� ����� ������';
  H_DS_Prepare_Dataset = '����������� ����� ������';
  H_DS_Unprepare_Dataset = '�������� ���������� ������ ������';
  H_DS_ReadOnly_Dataset = '����� ������ ������ ��� ������';

  H_CB_Create_Database = '������� ���� ������';
  H_CB_Connect_Database = '������������ � ���� ������';
  H_CB_Disconnect_Database = '��������� ����������';
  H_CB_Drop_Database = '������� ���� ������';
  
  H_RD_actHide = '������ ���������� ����';
  H_RD_actHideAll = '������ ��� ����';
  H_RD_actVisible = '������� ���������� ���� ��������';
  H_RD_actVisibleAll = '������� ��� ���� ��������';
  H_RD_actUp = '����������� ���������� ���� ����';
  H_RD_actTop = '����������� ���������� ���� ������';
  H_RD_actDown = '����������� ���������� ���� ����';
  H_RD_actBottom = '����������� ���������� ���� ����';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = '������� �� SQL-�������';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = '����������� ��������� ��� ascii-�����';
  eNoDestTableEntry          = '����������� ��������� ��� �������-���������';
  eAsciiFileNotFound         = 'Ascii-���� "%s" �� ������';
  eIniFileNotFound           = 'Ini-���� "%s" �� ������';
  eNoAsciiFileAccess         = '���������� ������� ascii-���� "%s"';
  eInvalidCharFound          = '������������ ������ / ������ ������� ascii-�����';
  eOutOfMemory               = '�� ������� ������';
  eFieldDescriptionError     = '������ � �������� ����';
  eWrongAsciiFieldCount      = '������������ ���������� ����� � ascii-�����, ������ (%s)';
  eWrongDecimalCount         = '������������ ����� ���������� ������ � ������ ����� (%s)';
  eWrongFieldWidth           = '������������ ������ ���� � ascii-�����';

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
