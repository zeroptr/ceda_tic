
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
  IB_VERSION_BUILD = 'D';
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

// 53bit integer based numeric objects.
  IB_NORNDERR = 'NOROUNDERR';
  IB_CURR     = 'CURR';
  IB_COMP     = 'COMP';

// Events
  IB_MaxEvents = 15;
  IB_EventLength = 64;

// Session
  IB_ISC_ERR_CODE_MSG = 'ISC ERROR CODE:';
  IB_ISC_ERR_MSG_MSG  = 'ISC ERROR MESSAGE:';
  IB_SQL_ERR_CODE_MSG = 'SQL ERROR CODE:';
  IB_SQL_ERR_MSG_MSG  = 'SQL ERROR MESSAGE:';

// Global Defaults  
  G_DefaultRowHeight  = 17;

{ These may be localized. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'Tak for at du har evalueret IB Objects'#10#13#10#13 +//'Thanks for evaluating IB Objects.'#10#13#10#13 +
                   'Gå venligst til http://www.ibobjects.com og registrer idag';//'Please go to http://www.ibobjects.com and register today.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Der er allerede etableret en forbindelse'; //'Connection has already been established';
  E_NOT_CONNECTED     = 'Der er ikke etableret en forbindelse'; //'Connection has not been established';
  E_Cant_Repl_Int_Tr  = 'Kan ikke erstatte intern transaktion som standard'; //'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Der er ikke startet en tarnsaktion'; //'Transaction has not been started';
  E_TRANS_STARTED     = 'Der er allerede startet en transaktion'; //'Transaction has already been started';
  E_NO_CONNECTIONS    = 'Transaktionen har ingen forbindelser'; //'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Transaktionen mangler en eller flere forbindelser'; //'Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Advarsel: Forbindelse er ved at blive etableret'; //'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Forbindelser skal alle være i den samme IB_Session'; //'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Transaktionen er midlertidig stoppet'; //'Transaction is Paused';
  E_ALLOCATED         = 'Sætning er allerede tildelt'; //'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Sætning er ikke blevet tildet'; //'Statement has not been allocated';
  E_PREPARED          = 'Sætning er allerede blevet klargjort'; //'Statement has already been prepared';
  E_NOT_PREPARED      = 'Sætning er ikke blevet klargjort'; //'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Sætning kunne ikke klargøres'; //'Statement failed to prepare';
  E_OPENED            = 'Sætning er allerede blevet åbnet'; //'Statement has already been opened';
  E_NOT_OPENED        = 'Sætning er ikke blevet åbnet';  //'Statement has not been opened';
  E_CANT_DELETE       = 'Aktuel rekord i markøren(cursor) kan ikke slettes'; //'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Sætning skal have en IB_Connection tildelt'; //'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'Kunne ikke åbne IB_Connection'; //'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Sætning skal have en IB_Transaction tildelt'; //'Statement must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'Ingen aktive transaktioner at arbejde med'; //'No active transaction to execute with';
  E_START_FAILED      = 'Kunne ikke starten en transaktion'; //'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'Direkte transaktion ikke tilladt med ServerAutoCommit'; //Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate     = 'Forkert transaktions tilstand. Kan ikke aktivere'; //'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transaktion har ventende ændringer'; //'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Opdatering af alle datasæt mislykkedes'; //'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Annullering af alle datasæt mislykkedes'; //'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Kan ikke opdatere, %s er ikke ejet af %s'; //'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'Blank SQL Sætning er ikke tilladt'; //'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Ved filens slutning'; //'At end of file';
  E_AT_END_OF_CURSOR  = 'Ved slutning af markør'; //'At end of cursor';
  E_AT_END_OF_BUFFER  = 'Ved slutning af buffer'; //'At end of buffer';
  E_AT_END_OF_DATASET = 'Ved slutning af datasæt'; //'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'Uventet længde i isc_dsql_sql_info';//'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Forkerte data returneret fra isc_dsql_sql_info';//'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Kan ikke skifte markør navn mens aktiv'; //'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Kan ikke skifte RequestLive mens aktiv';//'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'Kan ikke RequestLive på et ReadOnly datasæt'; //'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI              = 'IB_CURSOR er ensrettet'; //'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Ikke understøttet kolonne type: %d';//'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND         = 'Feltnr.: %d ikke fundet';//'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = 'Feltnavn: %s ikke fundet';//'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = 'Ugyldig fokuseret relations nr.: &d'; //'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Ugyldig fokuseret relations navn: %s';//'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = 'Syntaks fejl: IN( værdi [ , værdi .... ] )';//'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = 'Syntaks fejl: BETWEEN værdi AND værdi'; //'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Ikke i stand til at finde DLL import %s';//'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Ugyldig SQLKeyFields egenskab'; //'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR       = 'Kan ikke åbne markøren uden nøgle data';//'Cannot open cursor without key data';
  E_SCROLL_ERROR           = 'Rekord nøgle er tabt'#10#13'Ikke i stand til at åbne markøren'; //'Record key was lost'#10#13'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Ugyldig BufferRowNum ligger før start'; //'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT      = 'Kan ikke forberede blank Sætning'; //'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT   = 'Forsøg på at udføre en ukendt Sætning'; //'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Cirkulær reference ikke tilladt'; //'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = 'Kan ikke skifte medens tilsluttet'; //'Cannot change while connected';
  E_LOGIN_FAILED      = 'Tilslutning mislykkedes'; //'Login failed';
  E_CANT_GET_CONN_CHR = 'Kan ikke skaffe tilslutnings karekteristika'; //'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = 'Over maksimum hændelser for en blok'; //'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Behandler hændelser'#13#10'Kan ikke afregistrere'; //'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'BLOB er blevet eller kan ikke gemmes'; //'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'BLOB er allerede blevet eller kan ikke hentes'; //'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Kan ikke fortryde aktuel række'; //'Cannot cancel current Row';
  E_CANNOT_POST_ROW  = 'Kan ikke postere aktuel række'; //'Cannot Post current Row';
  E_DatasetClosed     = 'Datasæt er inaktivt'; //'Dataset is inactive';
  E_DatasetOpen        = 'Datasæt er i øjeblikket åbent'; //'Dataset is currently open';
  E_DatasetCannotScroll = 'Datasæt kan ikke rulle'; //'Dataset cannot scroll';
  E_DatasetReadOnly     = 'Datasæt kan kun læses'; //'Dataset is readonly';
  E_DatasetIsFetching    = 'Datasæt henter i øjeblikket'; //'Dataset is currently fetching';
  E_Invalid_KeyRelation   = 'Ugyldig KeyRelation værdi'; //'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNum er ikke implementeret endnu'; //'RowNum is not implemented yet';
  E_RowDeleted            = 'Række bliver slettet'; //'Row is being deleted';
  E_END_OF_DATASET        = 'Ved slutning af datasæt'; //'At end of Dataset';
  E_BEGINNING_OF_DATASET   = 'Ved starten af datasæt'; //'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Kan ikke bruge pessimistisk lås med LockWait'; //'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row      = 'Kan ikke redigere aktuel række'; //'Cannot Edit current Row';
  E_Cannot_Insert_Row  = 'Kan ikke indsætte en ny række'; //'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Kan ikke slette aktuel række'; //'Cannot delete current Row';
  E_Cannot_Search    = 'Søgning er ikke tilladt'; //'Searching is not allowed';
  E_Cannot_Navigate = 'Kan ikke navigere'; //'Cannot navigate';
  E_Record_Locked    = 'Psoten er låst af en anden bruger'; //'Record is locked by another user';
  E_Record_OutOfSynch = 'Rekord er blevet ændret af en anden bruger'; //'Record was changed by another user';
  E_FLD_READONLY       = '%s er kun læsbart'; //'%s is readonly';
  E_Required_Field       = '%s er et nødvendigt felt'; //'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Kan ikke bruge PostRetaining med Samlet opdatering'; //'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Flere rækker i enkelt hentning';//'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Ugyldig RowsAffected mellemlager'; //'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Ugyldig række nummer efter filslut'; //'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Ugyldig række nummer før start af fil'; //'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Ugyldig bogmærke streng'; //'Invalid Bookmark String';

  E_Assign_Column  = 'Kan ikke tildele fra %s'; //'Cannot assign from %s';
  E_AssignTo_Column = 'Kan ikke tildele til &s'; //'Cannot assign to %s';
  E_Value_Out_Of_Range = 'Værdi er ude af tilladt område'; //'Value out of range';
  E_SmallintOverflow = 'Heltals værdi overløb'; //'Smallint overflow';

  E_Unsupported_Column = 'Ikke understøttet kolonne type: %d'; //'Unsupported Column type: %d';
  E_UndefinedMacro = 'Ikke defineret makro'; //'Undefined macro';
  E_GeneratorFailed = 'Ude af stand til at hente genereret værdi'; //'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'Skal vær efterfølger til TIB_BDataset (IB_Query)';//'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Kan ikke ændre ReadOnly efter opstart'; //'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Kan ikke ændre Isolation efter opstart'; //'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Kan ikke ændre RecVersion efter opstart'; //'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'Kan ikke ændre LockWait efter opstart'; //'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Ugyldig reference til sletning'; //'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53bit værdi overløb';  //'53bit integer overflow';
  E_Invalid_Typecast = 'Ugyldig rolle tildeling'; //'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Ugyldig Sætnings type for DataPump'; //'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL felt tildelt en nul værdi'; //'NOT NULL field set to null value';
  E_DATABASE_BLANK = 'DatabaseName kan ikke være blank'; //'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Kolonne konvertering ikke understøttet';//'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Kunne ikke finde rekord'; //'Unable To Locate Record';
  E_Record_Not_Inserted = 'Rekorden blev ikke tilføjet';//'Record was not inserted';
  E_Invalid_KeyLinks = 'Ugyldig KeyLinks indhold: %s'; //'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Ikke i stand til at udføre søgning'; //'Unable to perform search';
  E_Unassigned_Blob_Node = 'Ikke tildelt BlobNode'; //'Unassigned BlobNode';
  E_Unassigned_Transaction = 'Ikke tildelt Transaktion';//'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Ugyldig RowsAffected buffer'; //'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Ikke i stand til at gemme til Graphic';//'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Kan ikke aktivere transaktion'; //'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'Interbase klient GDS32.DLL er ikke installeret'; //'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Kunne ikke hente memo'; //'Could not load memo';
  E_Invalid_DPB_Over_255 = 'Ugyldig DPB: Indeholer mere end 255 tegn'; //'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Ugyldig bruger DML kolonne reference: %s'; //'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Rekord til opdatering ikke fundet'; //'Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Rekord til sletning ikke fundet'; //'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'Ikke i stand til at initialicere standard %s'; //'Unable to initialize default %s';
  E_Stringlist_Not_Sorted = 'Tekststreng liste skal være sorteret til denne behandling'; //'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Kan ikke skifte hændelse under behandling'; //'Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Kan ikke af-registrere under behandling'; //'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Ugyldig intern IB_Transaction'; //'Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Ugyldig Sætnings type'; //'Invalid statement type';
  E_Multiple_Records_Updated = 'Flere rekord opdateret'; //'Multiple records updated';
  E_Multiple_Records_Deleted = 'Flere rekord slettet'; //'Multiple records deleted';
  E_DUP_DB_NAME = 'Dobbelt DatabaseName ikke tilladt'; //'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Ugyldig DatabaseName'; //'Invalid DatabaseName';
  E_UnableToSearch = 'Ude af stand til at udføre søgning'; //'Unable to perform search';
  E_NoRecordsFound = 'Ingen rekord fundet'; //'No records found';
  E_Session_Undefined = 'Session ikke defineret'; //'Session is undefined';
  E_NoCircularRef = 'Cirkulær reference ikke tilladt'; //'Circular reference not allowed';
  E_InvalidClassType = 'Ugyldig klasse type'; //'Invalid class type';
  E_Invalid_RowNum = 'Ugyldig rækkenummer'; //'Invalid RowNum';
  E_Invalid_Syntax = 'Ugyldig syntaks: Ekstra eller manglende parenteser'; //'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Tabel er tom'; //'Array is Null';

  E_Cannot_add_blank_account = 'Kan ikke tilføje blank konto'; //'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'Kan ikke tilføje SYSDBA konto'; //'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account =' Kan ikke slette blank konto'; //'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'Kan ikke slette SYSDBA konto'; //'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Kan ikke ændre blank konto'; //'//Cannot modify blank account';

  E_PLAN_ERROR = 'PLAN fejl'; //'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN undtagelse'; //'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Ugyldig CREATE, CONNECT eller DROP DATABSE syntaks'; //'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Ikke understøttet'; //'Unsupported';
  E_NotImplemented = 'Ikke implementeret på dette niveau'; //'Not implemented at this level';
  E_Invalid_ColData = 'Ugyldig kolonne data';  //'Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Kan ikke uForberede en løbende proces'; //'Cannot Unprepare an executing process';
  E_FileName_Required = 'Filnavn påkrævet'; //'Filename is required';

{ Labels for various default dialogs used in IBO }

//IBF_Users
  L_USERS_FRM = 'Bruger kontostyring'; //'User Account Management';
  L_USERS_ADD = 'Tilføj'; //'Add';
  L_USERS_DELETE = 'Slet'; //'Delete';
  L_USERS_MODIFIY = 'Ændre'; //'Modify';
  L_USERS_ACCOUNT = 'KONTO'; //'ACCOUNT';
  L_USERS_PASSWORD = 'Kodeord'; //'Password';
  L_USERS_GROUP = 'Gruppe'; //'Group';
  L_USERS_FIRSTNAME = 'Fornavn'; //'First Name';
  L_USERS_MIDDLENAME = 'Mellemnavn'; //'Middle Name';
  L_USERS_LASTNAME = 'Efternavn'; //'Last Name';

//IBF_Export
  L_EXPORT_FRM = 'Eksporter'; //'Export';
  L_EXPORT_ASCII = ' Fil format '; //' File Format ';
  L_EXPORT_FIXED = 'TXt fast linie længde'; //'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV adskilt'; //'CSV Delimited';
  L_EXPORT_DBF  = 'DBF (Mangler stadig nogen afprøvning'; //'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = ' ASCII muligheder '; //' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Begrænser'; //'Delimiter';
  L_EXPORT_SEPARATOR  = 'Adskiller'; //'Separator';
  L_EXPORT_DATEFORMAT  = 'Dato format'; //'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Inkluder top'; //'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'Inkluder VRNL(CRLF)'; //'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Eksporter'; //'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Komma adskilte tekst filer ( *.CSV )|*.CSV';//'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Tekst filer ( *.TXT )|*.TXT';//'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF filer ( *.DBF )|*.DBF';//'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Er du sikker på du vil afbryde?'; //'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Henter forespørgsels resultat'; //'Fetching Query Results';
  M_Row_Num = 'Række nr. %d'; //'Row# %d';
  M_Abort_Fetching_Btn = 'Afbryd'; //'Abort';

  M_Login_Database = 'Database';
  M_Login_User = 'Bruger'; //'User';
  M_Login_Password = 'Kodeord'; //'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Fortryd'; //'Cancel';
  M_Login_Help_Btn = '&Hjælp'; //'&Help';
  M_Login_Dialog_Caption = 'Login dialog'; //'Login Dialog';

  M_Loading_Caption = 'Henter....'; //'Loading...';

  M_SB_REC_CNT = 'Rekord optalt: %d'; //'Records counted: %d';
  M_Save_Changes = 'gem ændringer?'; //'Save changes?';

  M_CancelTransactionPrompt =
    'Er du sikker på du vil fortryde alle ændringer?'; //'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'Afbryd udførsel af denne instruktion?'; //'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Fortsætte udførsel af denne instruktion?'; //'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Instruktion bliver udført'; //'Script is currently executing';
  M_SCRIPT_FAILED = 'Instruktion kunne ikke fuldføres'; //'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Udførsel af instruktion blev afbrudt'; //'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Instruktion afsluttede upåklageligt'; //'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Instruktion afsluttede med fejl'; //'Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'Omdannet'; //'Modified';
  M_SCRIPT_SAVE_CHANGES = 'Gem ændringer'; //'Save changes?';

{ Button captions }

  C_BTN_TODAY = 'Idag'; //'Today';
  C_BTN_CLEAR = 'Ryddet'; //'Clear';

  C_SG_Parameter = 'Parametre'; //'Parameter';
  C_SG_Field = 'felt'; //'Field';
  C_SG_Name = 'Felt'; //'Name';
  C_SG_Type = 'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'Værdi'; //'Value';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Afbryd'; //'Cancel';
  C_BF_APPLY = 'Anvend'; //'Apply';
  C_BF_HELP = 'Hjælp'; //'Help';
  C_BF_EXECUTE = 'Udfør'; //'Execute';

  C_FRM_Ordering = 'Rækkefølge'; //'Ordering';

  C_CB_WordWrap = 'Ord ombøjning'; //'Word Wrap';

  // IBF_USERS
  C_BTN_USRES_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Ryd'; //'Clear';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Begynd eksport'; //'Begin Export';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Gennemse database'; //'Browse Database';
  C_wbBrowseBtnCaption  = 'Gennemse'; //'Browse';
  C_wbDSQLBtnHint       = 'Udfør ordre i database'; //'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Overvåg database hændelser'; //'Monitor Database Events';
  C_wbEventsBtnCaption  = 'Hændelser'; //'Events';
  C_wbExportBtnHint     = 'Eksporter datasæt fra database'; //'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Eksport'; //'Export';
  C_wbDumpBtnHint       = 'Dumpe database'; //'Dump Database';
  C_wbDumpBtnCaption    = 'Dumpe'; //'Dump';
  C_wbPumpBtnHint       = 'Flyt data fra anden database'; //'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Flyt'; //'Pump';
  C_wbWhoBtnHint        = 'Se hvem der koblet på databasen'; //'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Hvem'; //'Who';
  C_wbScriptBtnHint     = 'Udfør instruktion'; //'Execute Script';
  C_wbScriptBtnCaption  = 'Instruktion'; //'Script';
  C_wbMonitorBtnHint    = 'Spor SQL og API kald'; //'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Overvåg'; //'Monitor';
  C_wbProfilerBtnHint   = 'Oversigt over database aktivitet'; //'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Oversigt';//'Profiler';
  C_wbUsersBtnHint      = 'Administrer brugere for en databseserver'; //'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'Brugere'; //'Users';

  // Array grid
  C_AG_Row             = 'Række'; //'Row';
  C_AG_Column          = 'Kolonne'; //'Column';

  //IBF_Who
  C_WHO_FRM            = 'Hvem er tilsluttet'; //'Who is connected';
  C_WHO_BTNAPPLY       = 'Opfrisk'; //'Refresh';

  C_NB_FIRST = 'Første'; //'First';
  C_NB_PRIOR = 'Forrige'; //'Prior';
  C_NB_NEXT = 'Næste'; //'Next';
  C_NB_LAST = 'Sidste'; //'Last';

  C_ST_Open = 'Åbne'; //'Open';
  C_ST_Close = 'Lukke'; //'Close';
  C_ST_Prepare = 'Forbered'; //'Prepare';
  C_ST_Unprepare = 'Uforbered';//'Unprepare';
  C_ST_ReadOnly = 'Kun læs'; //'Read Only';
  C_ST_New = 'Ny'; //'New';
  C_ST_Post = 'Poster'; //'Post';
  C_ST_Cancel = 'Fortryd'; //'Cancel';
  C_ST_Delete = 'Slet'; //'Delete';
  C_ST_Edit = 'Rediger'; //'Edit';
  C_ST_RefreshKeys = 'Opfrisk nøgler'; //'Refresh Keys';
  C_ST_RefreshRows = 'Opfrisk rækker'; //'Refresh Rows';
  C_ST_Refresh = 'Opfrisk'; //'Refresh';

{ Hints }

  H_UB_EDIT = 'Rediger række';                  //'Edit Row';
  H_UB_INSERT = 'Indsæt række';                 //'Insert Row';
  H_UB_DELETE = 'Slet række';                   //'Delete Row';
  H_UB_REFRESH = 'Opfrisk alle rekord'; //'Refresh all records';
  H_UB_REFRESHKEYS = 'Opfrisk rekord nøgler'; //'Refresh record keys';
  H_UB_REFRESHROWS = 'Opfrisk rekord rækker'; //'Refresh record rows';
  H_UB_POSTSEARCH = 'Poster søge kriterier'; //'Post search criteria';
  H_UB_CANCELSEARCH = 'Fortryd søge kriterier'; //'Cancel search criteria';
  H_UB_POSTEDIT = 'Poster redigeringer'; //'Post edits';
  H_UB_CANCELEDIT = 'Fortryd redigeringer'; //'Cancel edits';
  H_UB_POSTINSERT = 'Poster indsættelser'; //'Post insert';
  H_UB_CANCELINSERT = 'Fortryd indsættelser'; //'Cancel insert';
  H_UB_POSTDELETE = 'Poster sletninger'; //'Post delete';
  H_UB_CANCELDELETE = 'Fortryd sletninger'; //'Cancel delete';
  H_UB_POST = 'Poster ændringer'; //'Post changes';
  H_UB_CANCEL = 'Fortryd ændringer'; //'Cancel changes';

  H_NB_FIRST = 'Første række'; //'First Row';
  H_NB_PRIOR = 'Forrige række'; //'Prior Row';
  H_NB_NEXT = 'Næste række'; //'Next Row';
  H_NB_LAST = 'Sidste række'; //'Last Row';
  H_NB_JUMPBCK = 'Baglæns'; //'Backwards';
  H_NB_JUMPFWD = 'Forlæns'; //'Forwards';

  H_SB_ORDER = 'Ordne rækker i datasæt'; //'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Genkald sidste søge kriterie'; //'Recall Last Search Criteria';
  H_SB_SEARCH = 'Søg datasæt'; //'Search Dataset';
  H_SB_SAVE_CRITERIA = 'gem kriterie'; //'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Ryd kriterie'; //'Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Genkald kriterie'; //'Recall Criteria';
  H_SB_SEARCHCOUNT = 'Tæl rækker i datasæt svarende til kriterie'; //'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Tæl rækker i datasæt'; //'Count Rows in Dataset';

  H_TB_StartTransaction = 'Start transaktion'; //'Start Transaction';
  H_TB_PostDatasets = 'Poster datasæt'; //'Post Datasets';
  H_TB_CancelDatasets = 'Fortryd datasæt'; //'Cancel Datasets';
  H_TB_SavePoint = 'Forpligt og behold aktuel transaktion'; //'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Poster datasæt og forpligt og behold aktuel transaktion'; //'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Forpligt og afslut aktuel transaktion'; //'Commit and End Current Transaction';
  H_TB_Rollback = 'Tilbagerul og afslut aktuel transaktion'; //'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Tilbagerul og behold aktuel transaktion'; //'Rollback and Retain Current Transaction';
  H_TB_Close = 'Luk aktuel transaktion'; //'Close Current Transaction';

  H_ST_Prepare_Statement = 'Forbered sætning'; //'Prepare Statement';
  H_ST_Unprepare_Statement = 'Uforbered sætning'; //'Unprepare Statement';
  H_ST_Execute_Statement = 'Udfør sætning'; //'Execute Statement';

  H_DS_Open_Dataset = 'Åben datasæt'; //'Open Dataset';
  H_DS_Close_Dataset = 'Luk datasæt'; //'Close Dataset';
  H_DS_Prepare_Dataset = 'Forbered datasæt'; //'Prepare Dataset';
  H_DS_Unprepare_Dataset = 'Uforbered datasæt'; //'Unprepare Dataset';
  H_DS_ReadOnly_Dataset = 'Kun læs datasæt'; //'Read Only Dataset';

  H_CB_Create_Database = 'Skab database'; //'Create Database';
  H_CB_Connect_Database = 'Forbind database'; //'Connect Database';
  H_CB_Disconnect_Database = 'Afbryd database'; //'Disconnect Database';
  H_CB_Drop_Database = 'Drop Database';
  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Eksporter fra database'; //'Export from SELECT statement';

	// Error Messages - IB_Import

  eNoAsciiFileEnty           = 'Manglende indgang for Ascii fil';//'Missing entry for Ascii file';
	eNoDestTableEntry          = 'Manglende indgang for destinations tabel'; //'Missing entry for destination table';
	eAsciiFileNotFound         = 'Ascii fil %s ikke fundet'; //'Ascii file %s not found';
	eIniFileNotFound           = 'Ini-fil %s ikke fundet'; //'Ini-file %s not found';
	eNoAsciiFileAccess         = 'Kunne ikke åbne ascii fil %s'; //'Could not open ascii file %s';
	eInvalidCharFound          = 'Ulovligt tegn / format fejl i ascii fil'; //'Invalid char / format error in ascii file';
	eOutOfMemory               = 'Ikke mere hukommelse'; //'Out of memory';
	eFieldDescriptionError     = 'Fejl i felt beskrivelse'; //'Error in field description';
	eWrongAsciiFieldCount      = 'Forkert felt antal i ascii fil'; //'Wrong field count in ascii file';
	eWrongDecimalCount         = 'Forkert decimal antal i feltliste (%s)'; //'Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth           = 'Forkert felt bredde i ascii fil'; //'Wrong field width in ascii file';

  // Dialog Labels - IB_Import

  lblRecsReadedCaption       = 'Totalt antals rekord læst'; //'Total Records read';
  lblRecsCommentedCaption    = 'Antal rekord kommenteret'; //'Records commented';
  lblRecsInsertedCaption     = 'Antal rekord indsat'; //'Records inserted';
  btnAbortImportCaption      = 'Afbryd'; //'Abort';


implementation

end.
