
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

  IB_REG_MESSAGE = 'Tack för att du har utvärderat IB Objects.'#10#13#10#13 +
                   'Var vänlig och gå till http://www.ibobjects.com och registrera i dag.';
  
{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Förbindelsen är redan etablerad';//'Connection has already been established';
  E_NOT_CONNECTED     = 'Förbindelsen är inte etablerad';//'Connection has not been established';
  E_Cant_Repl_Int_Tr  = 'Kan inte ersätta transaktion som standard';//'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Transaktionen är inte startad';//'Transaction has not been started';
  E_TRANS_STARTED     = 'Transaktionen är redan startad';//'Transaction has already been started';
  E_NO_CONNECTIONS    = 'Transaktionen har ingen förbindelse';//'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Transaktionen saknar en eller flera förbindelser';//'Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Varning förbindelsen kopplar upp';//'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Alla förbindelser måste vara i samma "IB_session"';//'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Transaktionen är pausad';//'Transaction is Paused';
  E_ALLOCATED         = 'Uttrycket är redan tilldelat';//'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Uttrycket är inte tilldelat';//'Statement has not been allocated';
  E_PREPARED          = 'Uttrycket är redan förberett';//'Statement has already been prepared';
  E_NOT_PREPARED      = 'Uttrycket är inte förberett';//'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Uttrycket kunde inte förberedas';//'Statement failed to prepare';
  E_OPENED            = 'Uttrycket är redan öppnat';//'Statement has already been opened';
  E_NOT_OPENED        = 'Uttrycket är inte öppnat';//'Statement has not been opened';
  E_CANT_DELETE       = 'Aktuellt post kan inte raderas';//'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Uttrycket måste ha en "IB_Connection" tilldelad';//'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'Kunde inte öppna "IB_Connection"';//'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Uttrycket måste ha en "IB_Transaction" tilldelad';//'Statement must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'Ingen aktiv transaktion att utföra';//'No active transaction to execute with';
  E_START_FAILED      = 'Kunde inte starta transaktionen';//'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'Oförbehållsam transaktion inte tillåten med "ServerAutoCommit"';//'Explicit transaction not allowed with ServerAutoCommit';
  E_Cannot_Activate   = 'Ogiltigt transaktions tillstånd. Kan inte aktivera';//'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transaktionem har oavslutade ändringar';//'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Misslyckades att uppdatera alla dataset';//'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Misslyckades att avbryta alla dataset';//'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Kan inte uppdatera, %s ägs inte av %s';//'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'Blankt SQL uttryck inte tillåtet';//'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Vid slutet av filen';//'At end of file';
  E_AT_END_OF_CURSOR  = 'Vid slutet av cursorn';//'At end of cursor';
  E_AT_END_OF_BUFFER  = 'Vid slutet av bufferten';//'At end of buffer';
  E_AT_END_OF_DATASET = 'Vid slutet av datasetet';//'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'Oväntad längd av isc_dsql_sql_info';//'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Ogiltigt data från isc_dsql_sql_info';//'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Kan inte ändra cursor namn när den är aktiv';// 'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Kan inte ändra "RequestLive" när den är aktiv';// 'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = '"RequestLive" inte tillåtet på skrivskyddade dataset';//'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI   = 'IB_CURSOR går endast att använda i en riktning';//'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE     = 'Kolumn typen stöds inte';//'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND           = 'Hittar inte fält nummer: %d';//'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND         = 'Hittar inte fält namn: %s';//'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = 'Ogiltigt fokuserad relation nummer: %d';// 'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Ogiltigt fokuserad relation namn: %s';//'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = 'Syntax fel IN( värde [ , värde ... ] )';//'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = 'Syntax fel BETWEEN värde AND värde';//'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Kan inte hitta DLL import %s';//'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Ogiltig "SQLKetFields" egenskap';//'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR            = 'Kan inte öppna cursor utan "key" data';//'Cannot open curosr without key data';
  E_SCROLL_ERROR = 'Post "key" förlorad'#10#13'Kan inte öppna cursor';//'Record key was lost'#10#13'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Ogiltigt "BufferRowNum" före början';//'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT = 'Kan inte förbereda ett blankt uttryck';//'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT = 'Försöker att utföra ett okänt uttryck';//'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Cirkel referens inte tillåtet';//'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN  = 'Kan inte ändra när anslutningen är aktiv';//'Cannot change while connected';
  E_LOGIN_FAILED        = 'Inloggningen misslyckades';//'Login failed';
  E_CANT_GET_CONN_CHR   = 'Kan inte få anslutnings karakteristisk';//';'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK = 'Över max antal händelser för ett block';//'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Behandlar händelser'#13#10'Kan inte avregistrera';//'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB = 'Blob har eller kan inte sparas';//'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB = 'Blob har eller kan inte laddas';//'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Kan inte avbryta aktuell rad';//'Cannot cancel current Row';
  E_CANNOT_POST_ROW = 'Kan inte spara aktuell rad';//'Cannot Post current Row';
  E_DatasetClosed = 'Dataset är inaktivt';//'Dataset is inactive';
  E_DatasetOpen = 'Dataset är förnärvarande öppet';//'Dataset is currently open';
  E_DatasetCannotScroll = 'Datasetet kan inte scrolla';// 'Dataset cannot scroll';
  E_DatasetReadOnly = 'Datasetet är skrivskyddat';//'Dataset is readonly';
  E_DatasetIsFetching = 'Datasetet hämtar data förnärvarande';//'Dataset is currently fetching';
  E_Invalid_KeyRelation = 'Ogiltigt "KeyRelation" värde';//'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = '"RowNum" stöds inte ännu';//'RowNum is not implemented yet';
  E_RowDeleted = 'Raden raderas';//'Row is being deleted';
  E_END_OF_DATASET = 'I slutet av datasetet';//'At end of Dataset';
  E_BEGINNING_OF_DATASET = 'I början av datasetet';//'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Kan inte använda "pessimistic locking" med "LockWait"';//'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row = 'Kan inte ändra aktuell rad';//'Cannot Edit current Row';
  E_Cannot_Insert_Row = 'Kan inte lägga till ny rad';//'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Kan inte tabort aktuell rad';//'Cannot delete current Row';
  E_Cannot_Search = 'Sökning är inte tillåten';//'Searching is not allowed';
  E_Cannot_Navigate = 'Kan inte navigera';//'Cannot navigate';
  E_Record_Locked = 'Posten låst av annan användare';//'Record is locked by another user';
  E_Record_OutOfSynch = 'Posten ändrad av annan användare';//'Record was changed by another user';
  E_FLD_READONLY = '%s är skrivskyddad';//'%s is readonly';
  E_Required_Field = '%s är ett obligatoriskt fält';//'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Kan inte använda "PostRetaining" med "Cached" uppdatering';//'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Flera rader i en enrads hämtning';//'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Ogiltig "RowsAffected" buffer';//'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Ogiltigt radnummer efter Eof';//'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Ogiltigt radnummer före Bof';//'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Ogiltig bokmärks sträng';//'Invalid Bookmark String';

  E_Assign_Column   = 'Kan inte tilldela från %s';//'Cannot assign from %s';
  E_AssignTo_Column = 'Kan inte tildella till %s';//'Cannot assign to %s';
  E_Value_Out_Of_Range = 'Värdet utan för tillåtet område';//'Value out of range';
  E_SmallintOverflow = 'Smallint overflow';

  E_Unsupported_Column = 'Kolumn typen: %d stöd inte';//'Unsupported Column type: %d';
  E_UndefinedMacro = 'Odefinierat makro';//'Undefined macro';
  E_GeneratorFailed = 'Kan inte få "generator" värde';//'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'Måste vara av "TIB_BDataset" familjen (IB_Query)';//'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Kan inte ändra "ReadOnly" när startad';//'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Kan inte ändra "Isolation" när startad';//'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Kan inte ändra "RecVersion" när startad';//'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'Kan inte ändra "LockWait" när startad';//'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Otillåten referenc till "Delete"';//'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53bit integer "overflow"';//'53bit integer overflow';
  E_Invalid_Typecast = 'Ogiltig typändring';//'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Ogiltigt uttrycks typ för "DataPump"';//'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL fält satt till null värde';//'NOT NULL field set to null value';
  E_DATABASE_BLANK = '"DatabaseName" kan inte vara blankt';//'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Kolumn converteringen stöds inte';//'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Kan inte lokalisera posten';//'Unable To Locate Record';
  E_Record_Not_Inserted = 'Post inte infogat';//'Record was not inserted';
  E_Invalid_KeyLinks = 'Ogiltig "KeyLinks inmatning: %s';//'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Kan inte utföra sökningen';//'Unable to perform search';
  E_Unassigned_Blob_Node = 'Otilldelad "BlobNode"';//'Unassigned BlobNode';
  E_Unassigned_Transaction = 'Otilldelad "Transaction';//'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Ogiltig "RowAffected" buffer';//'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Kan inte spara som grafik';//'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Kan inte aktivera "Transaction"';//'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'InterBase Client GDS32.DLL är inte installerad';//'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Kan inte ladda memo';//'Could not load memo';
  E_Invalid_DPB_Over_255 = 'Ogiltig DPB: Innehåller över 255 tecken';//'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Ogiltig pesonlig DML kolumn referens: %s';//'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Post var inte lokaliserad för uppdatering';//'Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Post var inte lokaliserad för radering';//'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'Kan inte initiera standard värde %s';//'Unable to initilize default %s';
  E_Stringlist_Not_Sorted = '"Stringlist" måste vara sorterad för denna funktion';//'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Kan inte ändra händelse när behandling pågår';//'Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Kan inte avregistrera händelse när behandling pågår';//'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Ogiltig intern "IB_Transaction"';//'Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Ogiltig uttrycks typ';//'Invalid statement type';
  E_Multiple_Records_Updated = 'Flera poster uppdaterade';//'Multiple records updated';
  E_Multiple_Records_Deleted = 'Flera poster raderade';//'Multiple records deleted';
  E_DUP_DB_NAME = 'Dubbla "DatabaseName" inte tillåtet';//'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Ogiltigt "DatabaseName"';//'Invalid DatabaseName';
  E_UnableToSearch = 'Kan inte utföra sökning';//'Unable to perform search';
  E_NoRecordsFound = 'Inga poster hittade';//'No records found';
  E_Session_Undefined = 'Sessionen är odefinierad';//'Session is undefined';
  E_NoCircularRef = 'Cirkel referens inte tillåten';//'Circular reference not allowed';
  E_InvalidClassType = 'Ogiltig class typ';//'Invalid class type';
  E_Invalid_RowNum = 'Ogiltigt "RowNum"';//'Invalid RowNum';
  E_Invalid_Syntax = 'Syntax fel: förmånga eller för få paranteser';//'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Array is Null';

  E_Cannot_add_blank_account = 'Kan inte läggatill blankt konto';//'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'Kan inte läggatill SYSDBA konto';//'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Kan inte tabort blankt konto';//'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'Kan inte tabort SYSDBA konto';//'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Kan inte modifiera blankt konto';//'Cannot modify blank account';

  E_PLAN_ERROR = '"PLAN" FEL';//PLAN ERROR!';
  E_PLAN_EXCEPTION = '"PLAN" UNDANTAG';//'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Ogiltig CREATE, CONNECT or DROP DATABASE syntax';//'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Stöds inte';//'Unsupported';
  E_NotImplemented = 'Inte med i den här versionen';//'Not implemented at this level';
  E_Invalid_ColData = 'Ogiltigt column data';//'Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Kan inte "Unprepare" en aktiv process';//'Cannot Unprepare an executing process';
  E_FileName_Required = 'Filnamn är obligatoriskt';//'Filename is required';
  
{ Labels for various default dialogs used in IBO }

//IBF_Users
  L_USERS_FRM = 'Användare konto administration';// 'User Account Management';
  L_USERS_ADD = 'Läggtill';//'Add';
  L_USERS_DELETE = 'Tabort';//'Delete';
  L_USERS_MODIFIY = 'Modifiera';//'Modify';
  L_USERS_ACCOUNT = 'KONTO';//'ACCOUNT';
  L_USERS_PASSWORD = 'Lösenord';//'Password';
  L_USERS_GROUP = 'Grupp';//'Group';
  L_USERS_FIRSTNAME = 'Förnamn';//'First Name';
  L_USERS_MIDDLENAME = 'Mellan namn';//'Middle Name';
  L_USERS_LASTNAME = 'Efternamn';//'Last Name';

//IBF_Export
  L_EXPORT_FRM = 'Export';
  L_EXPORT_ASCII = ' File Format ';
  L_EXPORT_FIXED = 'TXT Fast record bredd';//'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV Avgränsad';//'CSV Delimited';
  L_EXPORT_DBF  = 'DBF Behöver mer testning';//'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = ' ASCII val';//' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Avgränsare';//'Delimiter';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Datum Format';//'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Komma Separerad Text Fil ( *.CSV )|*.CSV';//'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Text Fil ( *.TXT )|*.TXT';//'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF Fil ( *.DBF )|*.DBF';//'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }
  
  M_Abort_Fetching = 'Säkert du vill avbryta';//'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Hämtar Fråge Resultat';//'Fetching Query Results';
  M_Row_Num = 'Rad# %d';//'Row# %d';
  M_Abort_Fetching_Btn = 'Avbryt';//'Abort';

  M_Login_Database = 'Databas';//'Database';
  M_Login_User = 'Användare';//'User';
  M_Login_Password = 'Lösenord';//'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancel';
  M_Login_Help_Btn = '&Hjälp';//'&Help';
  M_Login_Dialog_Caption = 'Login Dialog';

  M_Loading_Caption = 'Laddar...';//'Loading...';

  M_SB_REC_CNT = 'Antal Poster: %d';//'Records counted: %d';
  M_Save_Changes = 'Spara ändringar';//'Save changes?';

  M_CancelTransactionPrompt =
    'Är det säkert du vill avbryta alla ändringar';//'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'Avbryta körningen av detta script?';//'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Fortsätta körningen av detta script?';//'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Script körs nu';//'Script is currently executing';
  M_SCRIPT_FAILED = 'Scriptet misslyckades';//'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Scriptet avbröts';//'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Scriptet klart utan undantag';//'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Scriptet klart med undantag';//'Script completed with exceptions';
    
{ Button captions }

  C_BTN_TODAY = 'Idag';//'Today';
  C_BTN_CLEAR = 'Rensa';//'Clear';

  C_SG_Parameter = 'Parameter';
  C_SG_Field = 'Fält';//'Field';
  C_SG_Name = 'Namn';//'Name';
  C_SG_Type = 'Typ';//'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'Värde';//'Value';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Avbryt';//'Cancel';
  C_BF_APPLY = 'Använd';//'Apply';
  C_BF_HELP = 'Hjälp';//'Help';
  C_BF_EXECUTE = 'Kör';//'Execute';

  C_FRM_Ordering = 'Ordnar';//'Ordering';

  C_CB_WordWrap = 'Ord flytt';//'Word Wrap';

  // IBF_USERS
  C_BTN_USRES_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Rensa';//'Clear';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Börja Export';//'Begin Export';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Bläddra Databas';//'Browse Database';
  C_wbBrowseBtnCaption  = 'Bläddra';//'Browse';
  C_wbDSQLBtnHint       = 'Kör uttryck i Databas';//'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitor Databas händelser';//'Monitor Database Events';
  C_wbEventsBtnCaption  = 'Händelser';//'Events';
  C_wbExportBtnHint     = 'Exportera Dataset från Databas';//'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Export';
  C_wbDumpBtnHint       = 'Dumpa Databas';//'Dump Database';
  C_wbDumpBtnCaption    = 'Dumpa';//'Dump';
  C_wbPumpBtnHint       = 'Pumpa data från en annan Databas';//'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Pumpa';//'Pump';
  C_wbWhoBtnHint        = 'Se vem som är ansluten till Databasen';//'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Vem';//'Who';
  C_wbScriptBtnHint     = 'Kör Script';//'Execute Script';
  C_wbScriptBtnCaption  = 'Script';
  C_wbMonitorBtnHint    = 'Spåra SQL och API anrop';//'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profiler';
  C_wbUsersBtnHint      = 'Administrera Användare för en Database Server';//'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'Användare';//'Users';

  // Array grid
  C_AG_Row             = 'Rad';//'Row';
  C_AG_Column          = 'Column';

  //IBF_Who
  C_WHO_FRM            = 'Vem är ansluten';//'Who is connected';
  C_WHO_BTNAPPLY       = 'Uppdatera';//'Refresh';

{ Hints }

  H_UB_EDIT = 'Redigera Rad';//'Edit Row';
  H_UB_INSERT = 'Infoga Rad';//'Insert Row';
  H_UB_DELETE = 'Tabort Rad';//'Delete Row';
  H_UB_REFRESH = 'Förnya all poster';//'Refresh all records';
  H_UB_REFRESHKEYS = 'Förnya "Keys"';//'Refresh record keys';
  H_UB_REFRESHROWS = 'Förnya rader';//'Refresh record rows';
  H_UB_POSTSEARCH = 'Sänd sök kriteria';//'Post search criteria';
  H_UB_CANCELSEARCH = 'Avbryt sök kriteria';//'Cancel search criteria';
  H_UB_POSTEDIT = 'Sänd ändringar';//'Post edits';
  H_UB_CANCELEDIT = 'Avbryt ändringar';//'Cancel edits';
  H_UB_POSTINSERT = 'Sänd infoga';//'Post insert';
  H_UB_CANCELINSERT = 'Avbryt infoga';//'Cancel insert';
  H_UB_POSTDELETE = 'Sänd tabort';//'Post delete';
  H_UB_CANCELDELETE = 'Avbryt tabort';//'Cancel delete';
  H_UB_POST = 'Sänd ändringar';//'Post changes';
  H_UB_CANCEL = 'Avbryt ändringar';//'Cancel changes';

  H_NB_FIRST = 'Första Raden';//'First Row';
  H_NB_PRIOR = 'Föregående Rad';//'Prior Row';
  H_NB_NEXT = 'Nästa Rad';//'Next Row';
  H_NB_LAST = 'Sista Raden';//'Last Row';
  H_NB_JUMPBCK = 'Bakåt';//'Backwards';
  H_NB_JUMPFWD = 'Framåt';//'Forwards';

  H_SB_ORDER = 'Sorterar Rader i Datasetet';//'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Återkalar Senaste Sök Kriteria';//'Recall Last Search Criteria';
  H_SB_SEARCH = 'Söker Dataset';//'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Sparar kriteria';//'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Tömmer kriteria';//'Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Återkalar kriteria';//'Recall Criteria';
  H_SB_SEARCHCOUNT = 'Räknar Rader i Dataset Motsvarande Kriteria';//'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Räknar Rader i Dataset';//'Count Rows in Dataset';

  H_TB_StartTransaction = 'Startar Transaktion';//'Start Transaction';
  H_TB_PostDatasets = 'Sänder Datasets';//'Post Datasets';
  H_TB_CancelDatasets = 'Avbryter Datasets';//'Cancel Datasets';
  H_TB_SavePoint = 'Utför och Bibehåller Aktuell Transaktion';//'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Sändr Datasets och Utför och Bibehåller Aktuell Transaktion';//'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Utför och Avslutar Aktuell Transaktion';//''Commit and End Current Transaction';
  H_TB_Rollback = 'Återställer och Avslutar Aktuell Transaktion';//'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Återställer och Bibehåller Aktuell Transaktion';//'Rollback and Retain Current Transaction';
  H_TB_Close = 'Stänger Aktuell Transaktion';//'Close Current Transaction';

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


