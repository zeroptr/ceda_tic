
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
  IB_ISC_ERR_CODE_MSG = 'ISC FEILKODE:';
  IB_ISC_ERR_MSG_MSG  = 'ISC FEILMELDING:';
  IB_SQL_ERR_CODE_MSG = 'SQL FEILKODE:';
  IB_SQL_ERR_MSG_MSG  = 'SQL FEILMELDING:';

// Global Defaults
  G_DefaultRowHeight  = 17;

{ These may be localized. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'Takk for at du har vurdert IB Objects.'#10#13#10#13 +
                   'Vær vennlig å gå til http://www.ibobjects.com og registrere deg i dag.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Forbindelsen er allerede etablert';//'Connection has already been established';
  E_NOT_CONNECTED     = 'Forbindelsen er ikke etablert';//'Connection has not been established';
  E_Cant_Repl_Int_Tr  = 'Kan ikke erstatte intern transaksjon som default';//'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Transaksjonen har ikke startet';//'Transaction has not been started';
  E_TRANS_STARTED     = 'Transaksjonen er allerede startet';//'Transaction has already been started';
  E_NO_CONNECTIONS    = 'Transaksjonen har ingen forbindelse';//'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Transaksjonen savner en eller flere forbindelser';//'Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Advarsel: Forbindelsen er fortsatt under opplasting';//'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Alle forbindelser må være i samme "IB_session"';//'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Transaktionen er pauset';//'Transaction is Paused';
  E_ALLOCATED         = 'Uttrykket er allerede lokalisert';//'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Uttrykket er ikke lokalisert';//'Statement has not been allocated';
  E_PREPARED          = 'Uttrykket er allerede forberedt';//'Statement has already been prepared';
  E_NOT_PREPARED      = 'Uttrykket er ikke forberedt';//'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Uttrykket kunne ikke forberedes';//'Statement failed to prepare';
  E_OPENED            = 'Uttrykket er allerede åpnet';//'Statement has already been opened';
  E_NOT_OPENED        = 'Uttrykket er ikke åpnet';//'Statement has not been opened';
  E_CANT_DELETE       = 'Aktiv record i cursor kan ikke slettes';//'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Uttrykket må ha tilknytning til en "IB_Connection"';//'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'Kunne ikke åpne "IB_Connection"';//'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Uttrykket må ha tilknytning til en "IB_Transaction"';//'Statement must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'Ingen aktiv transaksjon å utføre';//'No active transaction to execute with';
  E_START_FAILED      = 'Kunne ikke starte transaksjonen';//'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'Uforbeholdt transaksjon ikke tillatt med "ServerAutoCommit"';//'Explicit transaction not allowed with ServerAutoCommit';
  E_Cannot_Activate   = 'Ulovlig transaksjonsstatus. Kan ikke aktivere';//'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transaksjonen har uavsluttede endringer';//'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Misslykket forsøk på oppdatering av alla datasett';//'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Misslykket forsøk på å avbryte alle datasett';//'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Kan ikke oppdatere, %s eies ikke av %s';//'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'Blankt SQL kall ikke tillatt';//'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Ved slutten av filen';//'At end of file';
  E_AT_END_OF_CURSOR  = 'Ved slutten av cursor';//'At end of cursor';
  E_AT_END_OF_BUFFER  = 'Ved slutten av buffer';//'At end of buffer';
  E_AT_END_OF_DATASET = 'Vid slutten av datasettet';//'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'Uforutsett lengde i isc_dsql_sql_info';//'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Uguldige data returnert fra isc_dsql_sql_info';//'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Kan ikke endre cursor navn mens datasettet er aktivt';// 'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Kan ikke endre "RequestLive" når datasettet er aktivt';// 'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = '"RequestLive" ikke tillat på skrivebeskyttede datasett';//'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI   = 'IB_CURSOR kan kun brukes i en retning';//'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE     = 'Ingen støtte for kolonnetype: %d';//'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND           = 'Finner ikke feltnummer: %d';//'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND         = 'Finner ikke feltnavn: %s';//'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = 'Ugyldig fokusert relasjonsnummer: %d';// 'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Ugyldig fokusert relasjonsnavn: %s';//'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = 'Syntax feil IN( verdi [ , verdi ... ] )';//'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = 'Syntax feil BETWEEN verdi AND verdi';//'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Kan ikke finne DLL import %s';//'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Ugyldig "SQLKeyFields" egenskap';//'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR            = 'Kan ikke åpne cursor uten (key) nøkkeldata';//'Cannot open curosr without key data';
  E_SCROLL_ERROR = 'Post "key" ble tapt'#10#13'Kan ikke åpne cursor';//'Record key was lost'#10#13'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Ugyldig "BufferRowNum" før start';//'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT = 'Kan ikke forberede blankt uttrykk';//'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT = 'Forsøk på å utføre ukjent uttrykk';//'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Sirkulær referanse ikke tillatt';//'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN  = 'Kan ikke endres ved aktiv forbindelse';//'Cannot change while connected';
  E_LOGIN_FAILED        = 'Innloggingen misslykkes';//'Login failed';
  E_CANT_GET_CONN_CHR   = 'Kan ikke få tilkoblingskarakteristikk';//';'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK = 'Maksimum antall hendelser for en blokk er overskredet';//'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Behandler hendelser'#13#10'Kan ikke avregistrere';//'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB = 'Blob har blitt eller kan ikke lagres';//'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB = 'Blob har eller kan inte laddas';//'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Kan ikke avbryte aktiv rad';//'Cannot cancel current Row';
  E_CANNOT_POST_ROW = 'Kan ikke lagre aktiv rad';//'Cannot Post current Row';
  E_DatasetClosed = 'Datasettet er ikke aktivt';//'Dataset is inactive';
  E_DatasetOpen = 'Datasettet er for øyeblikket åpent';//'Dataset is currently open';
  E_DatasetCannotScroll = 'Datasettet kan ikke skrolles';// 'Dataset cannot scroll';
  E_DatasetReadOnly = 'Datasettet er skrivebeskyttet';//'Dataset is readonly';
  E_DatasetIsFetching = 'Datasettet er i gang med å hente data';//'Dataset is currently fetching';
  E_Invalid_KeyRelation = 'Ugyldig "KeyRelation" verdi';//'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = '"RowNum" støttes ikke enda';//'RowNum is not implemented yet';
  E_RowDeleted = 'Raden slettes';//'Row is being deleted';
  E_END_OF_DATASET = 'Ved slutten av datasettet';//'At end of Dataset';
  E_BEGINNING_OF_DATASET = 'Ved begynnelsen av datasettet';//'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Kan ikke bruke "pessimistic locking" med "LockWait"';//'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row = 'Kan ikke endre aktiv rad';//'Cannot Edit current Row';
  E_Cannot_Insert_Row = 'Kan ikke legge til ny rad';//'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Kan ikke slette aktiv rad';//'Cannot delete current Row';
  E_Cannot_Search = 'Søking ikke tillatt';//'Searching is not allowed';
  E_Cannot_Navigate = 'Kan ikke navigere';//'Cannot navigate';
  E_Record_Locked = 'Posten låst av annen bruker';//'Record is locked by another user';
  E_Record_OutOfSynch = 'Posten endret av annen bruker';//'Record was changed by another user';
  E_FLD_READONLY = '%s er skrivebeskyttet';//'%s is readonly';
  E_Required_Field = '%s er et nødvendig felt';//'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Kan ikke bruke "PostRetaining" med "Cached" oppdatering';//'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Flere rader i en enrads henting';//'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Ugyldig "RowsAffected" buffer';//'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Ugyldig radnummer etter Eof';//'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Ugyldig radnummer foran Bof';//'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Ugyldig Bokmärks String';//'Invalid Bookmark String';

  E_Assign_Column   = 'Kan ikke tildele fra %s';//'Cannot assign from %s';
  E_AssignTo_Column = 'Kan ikke tildele til %s';//'Cannot assign to %s';
  E_Value_Out_Of_Range = 'Verdi utenfor gyldig område';//'Value out of range';
  E_SmallintOverflow = 'Smallint overflow';

  E_Unsupported_Column = 'Kolonnetype: %d støttes ikke';//'Unsupported Column type: %d';
  E_UndefinedMacro = 'Uidentifisert makro';//'Undefined macro';
  E_GeneratorFailed = 'Kan ikke finne "generator" verdi';//'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'Må være av familien "TIB_BDataset" (IB_Query)';//'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Kan ikke endre "ReadOnly" når startet';//'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Kan ikke endre "Isolation" når startet';//'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Kan ikke endre "RecVersion" når startet';//'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'Kan ikke endre "LockWait" når startet';//'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Ugyldig referanse til "Delete"';//'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53bit integer "overflow"';//'53bit integer overflow';
  E_Invalid_Typecast = 'Ugyldig typeendring';//'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Ugyldig uttrykkstype for "DataPump"';//'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL felt satt til null verdi';//'NOT NULL field set to null value';
  E_DATABASE_BLANK = '"DatabaseName" kan ikke være blankt';//'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Usupportert kolonnekonvertering';//'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Kan ikke lokalisere posten';//'Unable To Locate Record';
  E_Record_Not_Inserted = 'Post ble ikke innsatt';//'Record was not inserted';
  E_Invalid_KeyLinks = 'Ugyldig "KeyLinks" innlagt: %s';//'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Kan ikke utføre søk';//'Unable to perform search';
  E_Unassigned_Blob_Node = 'Utildelt "BlobNode"';//'Unassigned BlobNode';
  E_Unassigned_Transaction = 'Utildelt "Transaction';//'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Ugyldig "RowAffected" buffer';//'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Kan ikke lagre som grafikk';//'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Kan ikke aktivere "Transaction"';//'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'InterBase Client GDS32.DLL er ikkeinstallert';//'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Kan ikke laste memo';//'Could not load memo';
  E_Invalid_DPB_Over_255 = 'Ugyldig DPB: Inneholder over 255 tegn';//'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Ugyldig brukerdefinert DML kolonnereferanse: %s';//'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Post ble ikke lokalisert for ppdatering';//'Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Post ble ikke lokalisert for sletting';//'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'Kan ikke initiere standard %s';//'Unable to initilize default %s';
  E_Stringlist_Not_Sorted = '"Stringlist" må vøre sortert for denne operasjonen';//'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Kan ikke endre hendelser mens behandling pågår';//'Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Kan ikke avregistrere hendelser mens behandling pågår';//'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Ugyldig intern "IB_Transaction"';//'Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Ugyldig uttrykkstype';//'Invalid statement type';
  E_Multiple_Records_Updated = 'Flere poster oppdatert';//'Multiple records updated';
  E_Multiple_Records_Deleted = 'Flere poster slettet';//'Multiple records deleted';
  E_DUP_DB_NAME = 'Duplikat av "DatabaseName" ikke tillatt';//'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Ugyldig "DatabaseName"';//'Invalid DatabaseName';
  E_UnableToSearch = 'kan ikke utføre søk';//'Unable to perform search';
  E_NoRecordsFound = 'Ingen poster funnet';//'No records found';
  E_Session_Undefined = 'Sessjonen er udefinert';//'Session is undefined';
  E_NoCircularRef = 'Sirkulær referanse ikke tillatt';//'Circular reference not allowed';
  E_InvalidClassType = 'Ugyldig klassetype';//'Invalid class type';
  E_Invalid_RowNum = 'Ugyldig "RowNum"';//'Invalid RowNum';
  E_Invalid_Syntax = 'Syntax feil: for mange eller for få paranteser';//'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Array is Null';

  E_Cannot_add_blank_account = 'Kan ikke legge til blank konto';//'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'Kan ikke legge til SYSDBA konto';//'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Kan ikke slette blank konto';//'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'Kan ikke slette SYSDBA konto';//'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Kan ikke endre blank konto';//'Cannot modify blank account';

  E_PLAN_ERROR = '"PLAN" FEIL';//PLAN ERROR!';
  E_PLAN_EXCEPTION = '"PLAN" UNNTAK';//'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Ugyldig CREATE, CONNECT eller DROP DATABASE syntax';//'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Støttes ikke';//'Unsupported';
  E_NotImplemented = 'Ikke med på dette nivået';//'Not implemented at this level';
  E_Invalid_ColData = 'Ugyldig ColData';//'Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Kan ikke "Unprepare" en aktiv prosess';//'Cannot Unprepare an executing process';
  E_FileName_Required = 'Filnavn er nødvendig';//'Filename is required';

{ Labels for various default dialogs used in IBO }

//IBF_Users
  L_USERS_FRM = 'Brukerkonto administrasjon';// 'User Account Management';
  L_USERS_ADD = 'Legg til';//'Add';
  L_USERS_DELETE = 'Slett';//'Delete';
  L_USERS_MODIFIY = 'Endre';//'Modify';
  L_USERS_ACCOUNT = 'KONTO';//'ACCOUNT';
  L_USERS_PASSWORD = 'Passord';//'Password';
  L_USERS_GROUP = 'Gruppe';//'Group';
  L_USERS_FIRSTNAME = 'Fornavn';//'First Name';
  L_USERS_MIDDLENAME = 'Mellomnavn';//'Middle Name';
  L_USERS_LASTNAME = 'Etternavn';//'Last Name';

//IBF_Export
  L_EXPORT_FRM = 'Eksport';
  L_EXPORT_ASCII = ' Fil Format ';
  L_EXPORT_FIXED = 'TXT Fast record bredde';//'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV Avgrenset';//'CSV Delimited';
  L_EXPORT_DBF  = 'DBF (Trenger fortsatt mer testing)';//'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = ' ASCII opsjoner';//' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Avgrenser';//'Delimiter';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Dato Format';//'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Inkludèr Headere';//'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'Inkludèr CRLF';//'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Eksport';
  L_EXPORT_SDEXPORTFILTERCSV = 'Komma Separert Tekst Fil ( *.CSV )|*.CSV';//'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Tekst Fil ( *.TXT )|*.TXT';//'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF Fil ( *.DBF )|*.DBF';//'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Er du sikker på at du vil avbryte?';//'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Henter "Query" resultat';//'Fetching Query Results';
  M_Row_Num = 'Rad# %d';//'Row# %d';
  M_Abort_Fetching_Btn = 'Avbryt';//'Abort';

  M_Login_Database = 'Database';//'Database';
  M_Login_User = 'Bruker';//'User';
  M_Login_Password = 'Passord';//'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Annuller';//'Cancel';
  M_Login_Help_Btn = '&Hjelp';//'&Help';
  M_Login_Dialog_Caption = 'Login Dialog';

  M_Loading_Caption = 'Laster...';//'Loading...';

  M_SB_REC_CNT = 'Antall Poster: %d';//'Records counted: %d';
  M_Save_Changes = 'Lagre endringer?';//'Save changes?';

  M_CancelTransactionPrompt =
    'Er det sikkert at du vil avbryte alle endringer?';//'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'Avbryte utførelsen av dette scriptet?';//'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Fortsette utførelsen av dette scriptet?';//'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Script under utføring';//'Script is currently executing';
  M_SCRIPT_FAILED = 'Scriptet misslykkes';//'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Scriptet avbrytes';//'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Scriptet utført uten unntak';//'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Scriptet utført med unntak';//'Script completed with exceptions';

{ Button captions }

  C_BTN_TODAY = 'I dag';//'Today';
  C_BTN_CLEAR = 'Blank';//'Clear';

  C_SG_Parameter = 'Parameter';
  C_SG_Field = 'Felt';//'Field';
  C_SG_Name = 'Navn';//'Name';
  C_SG_Type = 'Type';//'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'Verdi';//'Value';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Avbryt';//'Cancel';
  C_BF_APPLY = 'Bruk';//'Apply';
  C_BF_HELP = 'Hjelp';//'Help';
  C_BF_EXECUTE = 'Utfør';//'Execute';

  C_FRM_Ordering = 'Ordner';//'Ordering';

  C_CB_WordWrap = 'Ord brudd';//'Word Wrap';

  // IBF_USERS
  C_BTN_USRES_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Blank';//'Clear';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Begynn Eksport';//'Begin Export';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Bla i Database';//'Browse Database';
  C_wbBrowseBtnCaption  = 'Bla';//'Browse';
  C_wbDSQLBtnHint       = 'Utfør uttrykk i Database';//'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitor Database hendelser';//'Monitor Database Events';
  C_wbEventsBtnCaption  = 'Hendelser';//'Events';
  C_wbExportBtnHint     = 'Eksporter Datasett fra Database';//'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Eksport';
  C_wbDumpBtnHint       = 'Dump Database';//'Dump Database';
  C_wbDumpBtnCaption    = 'Dump';//'Dump';
  C_wbPumpBtnHint       = 'Pump data fra en annen Database';//'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Pumpe';//'Pump';
  C_wbWhoBtnHint        = 'Se hvem som er tilkoblet til Databasen';//'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Hvem';//'Who';
  C_wbScriptBtnHint     = 'Utfør Script';//'Execute Script';
  C_wbScriptBtnCaption  = 'Script';
  C_wbMonitorBtnHint    = 'Lagre SQL og API kall';//'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Profilèr Databaseaktivitet';//'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profilèr';
  C_wbUsersBtnHint      = 'Administrer brukere for en Database Server';//'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'Brukere';//'Users';

  // Array grid
  C_AG_Row             = 'Rad';//'Row';
  C_AG_Column          = 'Kolonne';//'Column';

  //IBF_Who
  C_WHO_FRM            = 'Hvem er tilkoblet';//'Who is connected';
  C_WHO_BTNAPPLY       = 'Oppfrisk';//'Refresh';

{ Hints }

  H_UB_EDIT = 'Rediger Rad';//'Edit Row';
  H_UB_INSERT = 'Sett inn Rad';//'Insert Row';
  H_UB_DELETE = 'Slett Rad';//'Delete Row';
  H_UB_REFRESH = 'Oppfrisk alle poster';//'Refresh all records';
  H_UB_REFRESHKEYS = 'Oppfrisk "Keys"';//'Refresh record keys';
  H_UB_REFRESHROWS = 'Oppfrisk rader';//'Refresh record rows';
  H_UB_POSTSEARCH = 'Lagre søkekriterium';//'Post search criteria';
  H_UB_CANCELSEARCH = 'Avbryt søkekriterium';//'Cancel search criteria';
  H_UB_POSTEDIT = 'Lagre editeringer';//'Post edits';
  H_UB_CANCELEDIT = 'Avbryt editeringer';//'Cancel edits';
  H_UB_POSTINSERT = 'Utfør innsett';//'Post insert';
  H_UB_CANCELINSERT = 'Avbryt innsett';//'Cancel insert';
  H_UB_POSTDELETE = 'Utfør slett';//'Post delete';
  H_UB_CANCELDELETE = 'Avbryt slett';//'Cancel delete';
  H_UB_POST = 'Utfør endringar';//'Post changes';
  H_UB_CANCEL = 'Avbryt endringer';//'Cancel changes';

  H_NB_FIRST = 'Förste raden';//'First Row';
  H_NB_PRIOR = 'Forrige rad';//'Prior Row';
  H_NB_NEXT = 'Nesta rad';//'Next Row';
  H_NB_LAST = 'Siste raden';//'Last Row';
  H_NB_JUMPBCK = 'Bakover';//'Backwards';
  H_NB_JUMPFWD = 'Framover';//'Forwards';

  H_SB_ORDER = 'Sorterer rader i datasettet';//'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Tilbakekaller forrige søkekriterium';//'Recall Last Search Criteria';
  H_SB_SEARCH = 'Sök i datasett';//'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Lagre kriterium';//'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Tömmer kriterium';//'Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Tilbakekaller kriterium';//'Recall Criteria';
  H_SB_SEARCHCOUNT = 'Teller rader i datasett tilsvarer kriterium';//'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Teller rader i datasett';//'Count Rows in Dataset';

  H_TB_StartTransaction = 'Starter transaksjon';//'Start Transaction';
  H_TB_PostDatasets = 'Lagre Datasett';//'Post Datasets';
  H_TB_CancelDatasets = 'Avbryter Datasett';//'Cancel Datasets';
  H_TB_SavePoint = 'Utfører og beholder aktuell transaksjon';//'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Lagre datasett, committer og beholder aktiv transaksjon';//'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Commit og avslutt aktiv transaksjon';//''Commit and End Current Transaction';
  H_TB_Rollback = 'Rollback og avslutt aktiv transaksjon';//'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Rollback og behold aktiv transaksjon';//'Rollback and Retain Current Transaction';
  H_TB_Close = 'Lukker aktiv transaksjon';//'Close Current Transaction';

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


