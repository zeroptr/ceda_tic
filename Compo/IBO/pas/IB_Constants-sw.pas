
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
  IB_VERSION_MAJOR = '3';
  IB_VERSION_MINOR = '6';
  IB_VERSION_BUILD = 'C';
  IB_VERSION_SUB_RELEASE = 'a';
  
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
  IB_YESCASE     = 'YESCASE';    // Flag to override CN.DefaultNoCase
  IB_YESLIKE     = 'YESLIKE';    // Flag to use LIKE on literal strings
  IB_YESTRAILING = 'YESTRAILING';// Flag to override CN.DefaultNoTrailing

// Used by the SeachPanel from the FieldsReadOnly property.
  IB_NOINSERT = 'NOINSERT';
  IB_NOEDIT   = 'NOEDIT';
  IB_NOSEARCH = 'NOSEARCH';
  
// 53bit integer based numeric objects.
  IB_NORNDERR = 'NOROUNDERR';
  IB_CURR     = 'CURR';
  IB_COMP     = 'COMP';

// Events
  IB_MaxEvents = 15;
  IB_EventLength = 64;

// Session
  IB_ISC_ERR_CODE_MSG = 'ISC FEL KOD:';
  IB_ISC_ERR_MSG_MSG  = 'ISC FEL MEDDELANDE:';
  IB_SQL_ERR_CODE_MSG = 'SQL FEL KOD:';
  IB_SQL_ERR_MSG_MSG  = 'SQL FEL MEDDELANDE:';

// Global Defaults  
  G_DefaultRowHeight  = 17;

{ These may be localized. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'Tack f�r att du har utv�rderat IB Objects.'#10#13#10#13 +
                   'Var v�nlig och g� till http://www.ibobjects.com och registrera i dag.';
  
{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'F�rbindelsen �r redan etablerad';//'Connection has already been established';
  E_NOT_CONNECTED     = 'F�rbindelsen �r inte etablerad';//'Connection has not been established';
  E_Cant_Repl_Int_Tr  = 'Kan inte ers�tta transaktion som standard';//'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Transaktionen �r inte startad';//'Transaction has not been started';
  E_TRANS_STARTED     = 'Transaktionen �r redan startad';//'Transaction has already been started';
  E_NO_CONNECTIONS    = 'Transaktionen har ingen f�rbindelse';//'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Transaktionen saknar en eller flera f�rbindelser';//'Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Varning f�rbindelsen kopplar upp';//'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Alla f�rbindelser m�ste vara i samma "IB_session"';//'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Transaktionen �r pausad';//'Transaction is Paused';
  E_ALLOCATED         = 'Uttrycket �r redan tilldelat';//'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Uttrycket �r inte tilldelat';//'Statement has not been allocated';
  E_PREPARED          = 'Uttrycket �r redan f�rberett';//'Statement has already been prepared';
  E_NOT_PREPARED      = 'Uttrycket �r inte f�rberett';//'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Uttrycket kunde inte f�rberedas';//'Statement failed to prepare';
  E_OPENED            = 'Uttrycket �r redan �ppnat';//'Statement has already been opened';
  E_NOT_OPENED        = 'Uttrycket �r inte �ppnat';//'Statement has not been opened';
  E_CANT_DELETE       = 'Aktuellt post kan inte raderas';//'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Uttrycket m�ste ha en "IB_Connection" tilldelad';//'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'Kunde inte �ppna "IB_Connection"';//'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Uttrycket m�ste ha en "IB_Transaction" tilldelad';//'Statement must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'Ingen aktiv transaktion att utf�ra';//'No active transaction to execute with';
  E_START_FAILED      = 'Kunde inte starta transaktionen';//'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'Of�rbeh�llsam transaktion inte till�ten med "ServerAutoCommit"';//'Explicit transaction not allowed with ServerAutoCommit';
  E_Cannot_Activate   = 'Ogiltigt transaktions tillst�nd. Kan inte aktivera';//'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transaktionem har oavslutade �ndringar';//'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Misslyckades att uppdatera alla dataset';//'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Misslyckades att avbryta alla dataset';//'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Kan inte uppdatera, %s �gs inte av %s';//'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'Blankt SQL uttryck inte till�tet';//'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Vid slutet av filen';//'At end of file';
  E_AT_END_OF_CURSOR  = 'Vid slutet av cursorn';//'At end of cursor';
  E_AT_END_OF_BUFFER  = 'Vid slutet av bufferten';//'At end of buffer';
  E_AT_END_OF_DATASET = 'Vid slutet av datasetet';//'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'Ov�ntad l�ngd av isc_dsql_sql_info';//'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Ogiltigt data fr�n isc_dsql_sql_info';//'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Kan inte �ndra cursor namn n�r den �r aktiv';// 'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Kan inte �ndra "RequestLive" n�r den �r aktiv';// 'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = '"RequestLive" inte till�tet p� skrivskyddade dataset';//'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI   = 'IB_CURSOR g�r endast att anv�nda i en riktning';//'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE     = 'Kolumn typen st�ds inte';//'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND           = 'Hittar inte f�lt nummer: %d';//'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND         = 'Hittar inte f�lt namn: %s';//'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = 'Ogiltigt fokuserad relation nummer: %d';// 'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Ogiltigt fokuserad relation namn: %s';//'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = 'Syntax fel IN( v�rde [ , v�rde ... ] )';//'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = 'Syntax fel BETWEEN v�rde AND v�rde';//'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Kan inte hitta DLL import %s';//'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Ogiltig "SQLKetFields" egenskap';//'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR            = 'Kan inte �ppna cursor utan "key" data';//'Cannot open curosr without key data';
  E_SCROLL_ERROR = 'Post "key" f�rlorad'#10#13'Kan inte �ppna cursor';//'Record key was lost'#10#13'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Ogiltigt "BufferRowNum" f�re b�rjan';//'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT = 'Kan inte f�rbereda ett blankt uttryck';//'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT = 'F�rs�ker att utf�ra ett ok�nt uttryck';//'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Cirkel referens inte till�tet';//'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN  = 'Kan inte �ndra n�r anslutningen �r aktiv';//'Cannot change while connected';
  E_LOGIN_FAILED        = 'Inloggningen misslyckades';//'Login failed';
  E_CANT_GET_CONN_CHR   = 'Kan inte f� anslutnings karakteristisk';//';'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK = '�ver max antal h�ndelser f�r ett block';//'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Behandlar h�ndelser'#13#10'Kan inte avregistrera';//'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB = 'Blob har eller kan inte sparas';//'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB = 'Blob har eller kan inte laddas';//'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Kan inte avbryta aktuell rad';//'Cannot cancel current Row';
  E_CANNOT_POST_ROW = 'Kan inte spara aktuell rad';//'Cannot Post current Row';
  E_DatasetClosed = 'Dataset �r inaktivt';//'Dataset is inactive';
  E_DatasetOpen = 'Dataset �r f�rn�rvarande �ppet';//'Dataset is currently open';
  E_DatasetCannotScroll = 'Datasetet kan inte scrolla';// 'Dataset cannot scroll';
  E_DatasetReadOnly = 'Datasetet �r skrivskyddat';//'Dataset is readonly';
  E_DatasetIsFetching = 'Datasetet h�mtar data f�rn�rvarande';//'Dataset is currently fetching';
  E_Invalid_KeyRelation = 'Ogiltigt "KeyRelation" v�rde';//'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = '"RowNum" st�ds inte �nnu';//'RowNum is not implemented yet';
  E_RowDeleted = 'Raden raderas';//'Row is being deleted';
  E_END_OF_DATASET = 'I slutet av datasetet';//'At end of Dataset';
  E_BEGINNING_OF_DATASET = 'I b�rjan av datasetet';//'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Kan inte anv�nda "pessimistic locking" med "LockWait"';//'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row = 'Kan inte �ndra aktuell rad';//'Cannot Edit current Row';
  E_Cannot_Insert_Row = 'Kan inte l�gga till ny rad';//'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Kan inte tabort aktuell rad';//'Cannot delete current Row';
  E_Cannot_Search = 'S�kning �r inte till�ten';//'Searching is not allowed';
  E_Cannot_Navigate = 'Kan inte navigera';//'Cannot navigate';
  E_Record_Locked = 'Posten l�st av annan anv�ndare';//'Record is locked by another user';
  E_Record_OutOfSynch = 'Posten �ndrad av annan anv�ndare';//'Record was changed by another user';
  E_FLD_READONLY = '%s �r skrivskyddad';//'%s is readonly';
  E_Required_Field = '%s �r ett obligatoriskt f�lt';//'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Kan inte anv�nda "PostRetaining" med "Cached" uppdatering';//'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Flera rader i en enrads h�mtning';//'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Ogiltig "RowsAffected" buffer';//'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Ogiltigt radnummer efter Eof';//'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Ogiltigt radnummer f�re Bof';//'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Ogiltig bokm�rks str�ng';//'Invalid Bookmark String';

  E_Assign_Column   = 'Kan inte tilldela fr�n %s';//'Cannot assign from %s';
  E_AssignTo_Column = 'Kan inte tildella till %s';//'Cannot assign to %s';
  E_Value_Out_Of_Range = 'V�rdet utan f�r till�tet omr�de';//'Value out of range';
  E_SmallintOverflow = 'Smallint overflow';

  E_Unsupported_Column = 'Kolumn typen: %d st�d inte';//'Unsupported Column type: %d';
  E_UndefinedMacro = 'Odefinierat makro';//'Undefined macro';
  E_GeneratorFailed = 'Kan inte f� "generator" v�rde';//'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'M�ste vara av "TIB_BDataset" familjen (IB_Query)';//'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Kan inte �ndra "ReadOnly" n�r startad';//'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Kan inte �ndra "Isolation" n�r startad';//'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Kan inte �ndra "RecVersion" n�r startad';//'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'Kan inte �ndra "LockWait" n�r startad';//'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Otill�ten referenc till "Delete"';//'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53bit integer "overflow"';//'53bit integer overflow';
  E_Invalid_Typecast = 'Ogiltig typ�ndring';//'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Ogiltigt uttrycks typ f�r "DataPump"';//'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL f�lt satt till null v�rde';//'NOT NULL field set to null value';
  E_DATABASE_BLANK = '"DatabaseName" kan inte vara blankt';//'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Kolumn converteringen st�ds inte';//'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Kan inte lokalisera posten';//'Unable To Locate Record';
  E_Record_Not_Inserted = 'Post inte infogat';//'Record was not inserted';
  E_Invalid_KeyLinks = 'Ogiltig "KeyLinks inmatning: %s';//'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Kan inte utf�ra s�kningen';//'Unable to perform search';
  E_Unassigned_Blob_Node = 'Otilldelad "BlobNode"';//'Unassigned BlobNode';
  E_Unassigned_Transaction = 'Otilldelad "Transaction';//'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Ogiltig "RowAffected" buffer';//'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Kan inte spara som grafik';//'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Kan inte aktivera "Transaction"';//'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'InterBase Client GDS32.DLL �r inte installerad';//'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Kan inte ladda memo';//'Could not load memo';
  E_Invalid_DPB_Over_255 = 'Ogiltig DPB: Inneh�ller �ver 255 tecken';//'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Ogiltig pesonlig DML kolumn referens: %s';//'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Post var inte lokaliserad f�r uppdatering';//'Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Post var inte lokaliserad f�r radering';//'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'Kan inte initiera standard v�rde %s';//'Unable to initilize default %s';
  E_Stringlist_Not_Sorted = '"Stringlist" m�ste vara sorterad f�r denna funktion';//'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Kan inte �ndra h�ndelse n�r behandling p�g�r';//'Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Kan inte avregistrera h�ndelse n�r behandling p�g�r';//'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Ogiltig intern "IB_Transaction"';//'Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Ogiltig uttrycks typ';//'Invalid statement type';
  E_Multiple_Records_Updated = 'Flera poster uppdaterade';//'Multiple records updated';
  E_Multiple_Records_Deleted = 'Flera poster raderade';//'Multiple records deleted';
  E_DUP_DB_NAME = 'Dubbla "DatabaseName" inte till�tet';//'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Ogiltigt "DatabaseName"';//'Invalid DatabaseName';
  E_UnableToSearch = 'Kan inte utf�ra s�kning';//'Unable to perform search';
  E_NoRecordsFound = 'Inga poster hittade';//'No records found';
  E_Session_Undefined = 'Sessionen �r odefinierad';//'Session is undefined';
  E_NoCircularRef = 'Cirkel referens inte till�ten';//'Circular reference not allowed';
  E_InvalidClassType = 'Ogiltig class typ';//'Invalid class type';
  E_Invalid_RowNum = 'Ogiltigt "RowNum"';//'Invalid RowNum';
  E_Invalid_Syntax = 'Syntax fel: f�rm�nga eller f�r f� paranteser';//'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Array is Null';

  E_Cannot_add_blank_account = 'Kan inte l�ggatill blankt konto';//'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'Kan inte l�ggatill SYSDBA konto';//'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Kan inte tabort blankt konto';//'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'Kan inte tabort SYSDBA konto';//'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Kan inte modifiera blankt konto';//'Cannot modify blank account';

  E_PLAN_ERROR = '"PLAN" FEL';//PLAN ERROR!';
  E_PLAN_EXCEPTION = '"PLAN" UNDANTAG';//'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Ogiltig CREATE, CONNECT or DROP DATABASE syntax';//'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'St�ds inte';//'Unsupported';
  E_NotImplemented = 'Inte med i den h�r versionen';//'Not implemented at this level';
  E_Invalid_ColData = 'Ogiltigt column data';//'Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Kan inte "Unprepare" en aktiv process';//'Cannot Unprepare an executing process';
  E_FileName_Required = 'Filnamn �r obligatoriskt';//'Filename is required';
  
{ Labels for various default dialogs used in IBO }

//IBF_Users
  L_USERS_FRM = 'Anv�ndare konto administration';// 'User Account Management';
  L_USERS_ADD = 'L�ggtill';//'Add';
  L_USERS_DELETE = 'Tabort';//'Delete';
  L_USERS_MODIFIY = 'Modifiera';//'Modify';
  L_USERS_ACCOUNT = 'KONTO';//'ACCOUNT';
  L_USERS_PASSWORD = 'L�senord';//'Password';
  L_USERS_GROUP = 'Grupp';//'Group';
  L_USERS_FIRSTNAME = 'F�rnamn';//'First Name';
  L_USERS_MIDDLENAME = 'Mellan namn';//'Middle Name';
  L_USERS_LASTNAME = 'Efternamn';//'Last Name';

//IBF_Export
  L_EXPORT_FRM = 'Export';
  L_EXPORT_ASCII = ' File Format ';
  L_EXPORT_FIXED = 'TXT Fast record bredd';//'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV Avgr�nsad';//'CSV Delimited';
  L_EXPORT_DBF  = 'DBF Beh�ver mer testning';//'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = ' ASCII val';//' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Avgr�nsare';//'Delimiter';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Datum Format';//'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Komma Separerad Text Fil ( *.CSV )|*.CSV';//'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Text Fil ( *.TXT )|*.TXT';//'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF Fil ( *.DBF )|*.DBF';//'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }
  
  M_Abort_Fetching = 'S�kert du vill avbryta';//'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'H�mtar Fr�ge Resultat';//'Fetching Query Results';
  M_Row_Num = 'Rad# %d';//'Row# %d';
  M_Abort_Fetching_Btn = 'Avbryt';//'Abort';

  M_Login_Database = 'Databas';//'Database';
  M_Login_User = 'Anv�ndare';//'User';
  M_Login_Password = 'L�senord';//'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancel';
  M_Login_Help_Btn = '&Hj�lp';//'&Help';
  M_Login_Dialog_Caption = 'Login Dialog';

  M_Loading_Caption = 'Laddar...';//'Loading...';

  M_SB_REC_CNT = 'Antal Poster: %d';//'Records counted: %d';
  M_Save_Changes = 'Spara �ndringar';//'Save changes?';

  M_CancelTransactionPrompt =
    '�r det s�kert du vill avbryta alla �ndringar';//'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'Avbryta k�rningen av detta script?';//'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Forts�tta k�rningen av detta script?';//'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Script k�rs nu';//'Script is currently executing';
  M_SCRIPT_FAILED = 'Scriptet misslyckades';//'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Scriptet avbr�ts';//'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Scriptet klart utan undantag';//'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Scriptet klart med undantag';//'Script completed with exceptions';
    
{ Button captions }

  C_BTN_TODAY = 'Idag';//'Today';
  C_BTN_CLEAR = 'Rensa';//'Clear';

  C_SG_Parameter = 'Parameter';
  C_SG_Field = 'F�lt';//'Field';
  C_SG_Name = 'Namn';//'Name';
  C_SG_Type = 'Typ';//'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'V�rde';//'Value';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Avbryt';//'Cancel';
  C_BF_APPLY = 'Anv�nd';//'Apply';
  C_BF_HELP = 'Hj�lp';//'Help';
  C_BF_EXECUTE = 'K�r';//'Execute';

  C_FRM_Ordering = 'Ordnar';//'Ordering';

  C_CB_WordWrap = 'Ord flytt';//'Word Wrap';

  // IBF_USERS
  C_BTN_USRES_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Rensa';//'Clear';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'B�rja Export';//'Begin Export';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Bl�ddra Databas';//'Browse Database';
  C_wbBrowseBtnCaption  = 'Bl�ddra';//'Browse';
  C_wbDSQLBtnHint       = 'K�r uttryck i Databas';//'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitor Databas h�ndelser';//'Monitor Database Events';
  C_wbEventsBtnCaption  = 'H�ndelser';//'Events';
  C_wbExportBtnHint     = 'Exportera Dataset fr�n Databas';//'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Export';
  C_wbDumpBtnHint       = 'Dumpa Databas';//'Dump Database';
  C_wbDumpBtnCaption    = 'Dumpa';//'Dump';
  C_wbPumpBtnHint       = 'Pumpa data fr�n en annan Databas';//'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Pumpa';//'Pump';
  C_wbWhoBtnHint        = 'Se vem som �r ansluten till Databasen';//'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Vem';//'Who';
  C_wbScriptBtnHint     = 'K�r Script';//'Execute Script';
  C_wbScriptBtnCaption  = 'Script';
  C_wbMonitorBtnHint    = 'Sp�ra SQL och API anrop';//'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profiler';
  C_wbUsersBtnHint      = 'Administrera Anv�ndare f�r en Database Server';//'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'Anv�ndare';//'Users';

  // Array grid
  C_AG_Row             = 'Rad';//'Row';
  C_AG_Column          = 'Column';

  //IBF_Who
  C_WHO_FRM            = 'Vem �r ansluten';//'Who is connected';
  C_WHO_BTNAPPLY       = 'Uppdatera';//'Refresh';

{ Hints }

  H_UB_EDIT = 'Redigera Rad';//'Edit Row';
  H_UB_INSERT = 'Infoga Rad';//'Insert Row';
  H_UB_DELETE = 'Tabort Rad';//'Delete Row';
  H_UB_REFRESH = 'F�rnya all poster';//'Refresh all records';
  H_UB_REFRESHKEYS = 'F�rnya "Keys"';//'Refresh record keys';
  H_UB_REFRESHROWS = 'F�rnya rader';//'Refresh record rows';
  H_UB_POSTSEARCH = 'S�nd s�k kriteria';//'Post search criteria';
  H_UB_CANCELSEARCH = 'Avbryt s�k kriteria';//'Cancel search criteria';
  H_UB_POSTEDIT = 'S�nd �ndringar';//'Post edits';
  H_UB_CANCELEDIT = 'Avbryt �ndringar';//'Cancel edits';
  H_UB_POSTINSERT = 'S�nd infoga';//'Post insert';
  H_UB_CANCELINSERT = 'Avbryt infoga';//'Cancel insert';
  H_UB_POSTDELETE = 'S�nd tabort';//'Post delete';
  H_UB_CANCELDELETE = 'Avbryt tabort';//'Cancel delete';
  H_UB_POST = 'S�nd �ndringar';//'Post changes';
  H_UB_CANCEL = 'Avbryt �ndringar';//'Cancel changes';

  H_NB_FIRST = 'F�rsta Raden';//'First Row';
  H_NB_PRIOR = 'F�reg�ende Rad';//'Prior Row';
  H_NB_NEXT = 'N�sta Rad';//'Next Row';
  H_NB_LAST = 'Sista Raden';//'Last Row';
  H_NB_JUMPBCK = 'Bak�t';//'Backwards';
  H_NB_JUMPFWD = 'Fram�t';//'Forwards';

  H_SB_ORDER = 'Sorterar Rader i Datasetet';//'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = '�terkalar Senaste S�k Kriteria';//'Recall Last Search Criteria';
  H_SB_SEARCH = 'S�ker Dataset';//'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Sparar kriteria';//'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'T�mmer kriteria';//'Clear Criteria';
  H_SB_RECALL_CRITERIA = '�terkalar kriteria';//'Recall Criteria';
  H_SB_SEARCHCOUNT = 'R�knar Rader i Dataset Motsvarande Kriteria';//'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'R�knar Rader i Dataset';//'Count Rows in Dataset';

  H_TB_StartTransaction = 'Startar Transaktion';//'Start Transaction';
  H_TB_PostDatasets = 'S�nder Datasets';//'Post Datasets';
  H_TB_CancelDatasets = 'Avbryter Datasets';//'Cancel Datasets';
  H_TB_SavePoint = 'Utf�r och Bibeh�ller Aktuell Transaktion';//'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'S�ndr Datasets och Utf�r och Bibeh�ller Aktuell Transaktion';//'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Utf�r och Avslutar Aktuell Transaktion';//''Commit and End Current Transaction';
  H_TB_Rollback = '�terst�ller och Avslutar Aktuell Transaktion';//'Rollback and End Current Transaction';
  H_TB_RollbackRetain = '�terst�ller och Bibeh�ller Aktuell Transaktion';//'Rollback and Retain Current Transaction';
  H_TB_Close = 'St�nger Aktuell Transaktion';//'Close Current Transaction';

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
	eWrongAsciiFieldCount      = 'Wrong field count in ascii file';
	eWrongDecimalCount         = 'Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth           = 'Wrong field width in ascii file';

  // Dialog Labels - IB_Import

  lblRecsReadedCaption       = 'Total Records read';
  lblRecsCommentedCaption    = 'Records commented';
  lblRecsInsertedCaption     = 'Records inserted';
  btnAbortImportCaption      = 'Abort';
implementation
end.


