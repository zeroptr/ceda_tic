
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
{ Dirk Schiffler <ds@rcs.de>                                                   }
{ 11/11/2001                                                                   }
{    - constant G_DefaultRowHeight for property DefaultRowHeight               }
{      in the class-definitions for grids                                      }
{    - constants for date and time format strings                              }
{      using in IB_Parse and IB_Utils                                          }
{                                                                              }
{ Translated by: Ales Kahanek  <akahanek@alikiwi.com>                          }
{ NOTE to Czechs: 'nektere preklady jsou opravdu surove, zmeny vitany...'      }
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
  IB_VERSION_BUILD = 'F';
  IB_VERSION_SUB_RELEASE = 'n';

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
  DTEncode_DateTimeFormat  = 'YYYY"/"MM"/"DD" "HH":"MM":"SS".0000"';
  DT_DateFormat            = 'MM"/"dd"/"yyyy';
  DT_TimeFormat            = 'hh":"nn":"ss';

{ These may be localized. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'Dìkuji za testování IB Objects.'#13#10#13#10'Navštivte, prosím, http""//www.ibobjects.com a ihned se zaregistrujte.';  //'Thanks for evaluating IB Objects.'#13#10#13#10'Please go to http://www.ibobjects.com and register today.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Spojení již bylo navázáno';  //'Connection has already been established';
  E_NOT_CONNECTED     = 'Spojení nebylo navázáno';  //'Connection has not been established';
  E_Invalid_conn_path = 'Neplatná cesta k databázi';  //'Invalid connection path';
  E_Cant_Repl_Int_Tr  = 'Nelze standardnì nahradit interní transakci';  //'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Transakce nebyla spuštìna';  //'Transaction has not been started';
  E_TRANS_STARTED     = 'Transakce již byla spuštìna';  //'Transaction has already been started';
  E_NO_CONNECTIONS    = 'Transakce nemá žádné spojení';  //'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Transakce nemá jedno nebo více spojení';  //'Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Varování: Spojení se stále pøipravuje';  //'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Všechna spojení musí být ve stejné IB_Session';  //'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Transakce je pøerušena';  //'Transaction is Paused';
  E_ALLOCATED         = 'Pøíkaz již byl alokován';  //'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Pøíkaz nebyl alokován';  //'Statement has not been allocated';
  E_PREPARED          = 'Pøíkaz již byl pøipraven';  //'Statement has already been prepared';
  E_NOT_PREPARED      = 'Pøíkaz nebyl pøipraven';  //'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Pøíprava pøíkazu selhala';  //'Statement failed to prepare';
  E_OPENED            = 'Pøíkaz již byl proveden';  //'Statement has already been opened';
  E_NOT_OPENED        = 'Pøíkaz nebyl proveden';  //'Statement has not been opened';
  E_CANT_DELETE       = 'Aktuální záznam kurzoru nelze smazat';  //'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Pøíkaz musí mít pøiøazeno spojení';  //'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'Nepodaøilo se otevøít IB_Connection';  //'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Musí byt pøiøazena IB_Transaction';  //'Must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'K provedení není žádná aktivní transakce';  //'No active transaction to execute with';
  E_START_FAILED      = 'Nepodaøilo se spustit transakci';  //'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'Není povolena Explicitní transakce s ServerAutoCommit';  //'Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate     = 'Neplatný stav transakce. Nelze aktivovat';  //'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transakce má nepotvrzené zmìny';  //'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Potvrzení všech datasetù selhalo';  //'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Storno všech datasetù selhalo';  //'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Nelze aktualizovat, %s není vlastnìno vlastníkem %s';  //'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'Prázndý SQL pøíkaz není povolen';  //'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Konec souboru';  //'At end of file';
  E_AT_END_OF_CURSOR  = 'Konec kurzoru';  //'At end of cursor';
  E_AT_END_OF_BUFFER  = 'Konec bufferu';  //'At end of buffer';
  E_AT_END_OF_DATASET = 'Konec datasetu';  //'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'Neoèekávaná délka v in isc_dsql_sql_info';  //'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Data vrácená z isc_dsql_sql_info jsou neplatná';  //'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Nelze mìnit jméno aktivního kurzoru';  //'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Nelze mìnit RequestLive, pokud je aktivní';  //'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'Nelze nastavit RequesLive pro ReadOnly dataset';  //'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI              = 'IB_CURSOR je jednosmìrný';  //'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Nepodporovaný typ sloupce: %d';  //'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND         = 'Pole è.: %d nenalezeno';  //'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = 'Pole: %s nenalezeno';  //'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = 'Neplatná zamìøená relace è.: %d';  //'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Neplatné jméno zamìøené relace: %s';  //'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = 'Syntaktická chyba IN( value [ , value ... ] )';  //'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = 'Syntaktická chyba BETWEEN value AND value';  //'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Nepodaøilo se nalézt DLL import %s';  //'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Neplatná vlastnost SQLKeyFields';  //'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR       = 'Nelze otevøít kurzor bez dat klíèe';  //'Cannot open cursor without key data';
  E_SCROLL_ERROR           = 'Klíèe záznamu byly ztraceny'#13#10'Kurzor nelze otevøít';  //'Record key was lost'#13#10'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Neplatný BufferRowNum pøed zaèátkem';  //'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT      = 'Nelze pøipravit prázdný pøíkaz';  //'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT   = 'Pokus o provedení neznámého pøíkazu';  //'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Vzájemná reference není povolena';  //'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = 'Nelze zmìnit, pokud je spojení aktivní';  //'Cannot change while connected';
  E_LOGIN_FAILED      = 'Pøihlášení selhalo';  //'Login failed';
  E_CANT_GET_CONN_CHR = 'Nelze zjistit vlastnosti pøipojení';  //'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = 'Maximum událostí na jeden blok pøekroèeno';  //'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Provádìjí se události'#13#10'Nelze provést odhlášení';  //'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'Blob již byl uložen a nebo nelze uložit';  //'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'Blob již byl otevøen a nebo nelze otevøít';  //'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW ='Nelze stornovat aktuálnní záznam';  // 'Cannot cancel current Row';
  E_CANNOT_POST_ROW  = 'Nelze potvrdit aktuální záznam';  //'Cannot Post current Row';
  E_DatasetClosed     = 'Dataset není aktivní';  //'Dataset is inactive';
  E_DatasetOpen        = 'Dataset je právì otevøen';  //'Dataset is currently open';
  E_DatasetCannotScroll = 'Dataset nemùže rolovat';  //'Dataset cannot scroll';
  E_DatasetReadOnly     = 'Dataset je pro ètení';  //'Dataset is readonly';
  E_DatasetIsFetching    = 'Dataset právì natahuje záznamy';  //'Dataset is currently fetching';
  E_Invalid_KeyRelation   = 'Neplatná hodnota KeyRelation';  //'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNum není zatím implementováno';  //'RowNum is not implemented yet';
  E_RowDeleted            = 'Øádek se právì maže';  //'Row is being deleted';
  E_END_OF_DATASET        = 'Konec datasetu';  //'At end of Dataset';
  E_BEGINNING_OF_DATASET   = 'Zaèátek datasetu';  //'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Nelze používat pessimistické zamykání souèasnì s LockWait';  //'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row      = 'Nelze editovat aktuální záznam';  //'Cannot Edit current Row';
  E_Cannot_Insert_Row  = 'Nelze vložit nový záznam';  //'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Nelze smazat aktuální záznam';  //'Cannot delete current Row';
  E_Cannot_Search    = 'Hledání není povoleno';  //'Searching is not allowed';
  E_Cannot_Navigate = 'Nelze se posunout';  //'Cannot navigate';
  E_Record_Locked    = 'Záznam je uzamèen jiným uživatelem';  //'Record is locked by another user';
  E_Record_OutOfSynch = 'Záznam byl zmìnìn jiným uživatelem';  //'Record was changed by another user';
  E_FLD_READONLY       = '%s je jen pro ètení';  //'%s is readonly';
  E_Required_Field       = '%s je požadované pole';  //'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Nelze použít PostRetaining souèasnì s Cached Updates';  //'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Více øádkù v jediném záznamu';  //'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Neplatný buffer RowsAffected';  //'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Neplatná hodnota RowNum za Eof';  //'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Neplatná hodnota RowNum pøed Bof';  //'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Neplatný øetìzec Bookmark';  //'Invalid Bookmark String';

  E_Assign_Column  = 'Nelze pøiøadit z %s';  //'Cannot assign from %s';
  E_AssignTo_Column = 'Nelze pøiøadit k %s';  //'Cannot assign to %s';
  E_Value_Out_Of_Range = 'Hodnota mimo rozsah';  //'Value out of range';
  E_SmallintOverflow = 'Pøeteèení hodnoty typu smallint';  //'Smallint overflow';

  E_Unsupported_Column = 'Nepodporovaný typ sloupce" %d';  //'Unsupported Column type: %d';
  E_UndefinedMacro = 'Nedefinované makro';  //'Undefined macro';
  E_GeneratorFailed = 'Nepodaøilo se získat hodnotu generátoru';  //'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'Je nutný TIB_BDataset rodiè (IB_Query)';  //'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Nelze mìnit ReadOnly po startu';  //'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Nelze mìnit Isolation po startu';  //'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Nelze mìnit RecVersion po startu';  //'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'Nelze mìnit LockWait po startu';  //'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Neplatná reference na Delete';  //'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53bit integer overflow';
  E_Invalid_Typecast = 'Neplatné pøetypování';  //'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Neplatný typ pøíkazu pro DataPump';  //'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'Pole NOT NULL nastaveno na hodnotu NULL';  //'NOT NULL field set to null value';
  E_DATABASE_BLANK = 'Jméno databáze nesmí být prázdné';  //'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Nepodporovaná konverze sloupce';  //'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Nepodaøilo se nalézt záznam';  //'Unable To Locate Record';
  E_Record_Not_Inserted = 'Záznam nebyl vložen';  //'Record was not inserted';
  E_Invalid_KeyLinks = 'Neplatná hodnota KeyLinks" %s';  //'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Nepodaøilo se provést vyhledávání';  //'Unable to perform search';
  E_Unassigned_Blob_Node = 'Nepøiøazený BlobNode';  //'Unassigned BlobNode';
  E_Unassigned_Transaction = 'Nepøiøazená Transakce';  //'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Neplatný buffer RowsAffected';  //'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Nepodaøilo se uložit grafiku';  //'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Nelze aktivovat transakci';  //'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'Knihovna Interbase klient GDS32.DLL není nainstalována';  //'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Nelze otevøít memo položku';  //'Could not load memo';
  E_Invalid_DPB_Over_255 = 'Neplatný DPB: Obsahuje více než 255 znakù';  //'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Neplatná custom DML column reference: %s';  //'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Záznam nebyl nalezen a aktualizován';  //'Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Záznam nebyl nalezen a smazán';  //'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'Nepodaøilo se inicializovat default %s';  //'Unable to initialize default %s';
  E_Stringlist_Not_Sorted = 'Pro tuto operaci musí být Stringlist seøazen';  //'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Nelze mìnit události za bìhu';  //'Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Nelze zrušit registraci událostí za bìhu';  //'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Neplatná interní IB_Transakce';  //'Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Neplatný typ pøíkazu';  //'Invalid statement type';
  E_Multiple_Records_Updated = 'Záznamy hromadnì aktualizovány';  //'Multiple records updated';
  E_Multiple_Records_Deleted = 'Záznamy hromadnì smazány';  //'Multiple records deleted';
  E_Multiple_Records_Inserted = 'Záznamy hromadnì vloženy';  //'Multiple records inserted';
  E_DUP_DB_NAME = 'Duplicitní DatabaseName není povoleno';  //'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Neplatné DatabaseName';  //'Invalid DatabaseName';
  E_UnableToSearch = 'Nepodaøilo se provést vyhledávání';  //'Unable to perform search';
  E_NoRecordsFound = 'Nenalezy žádné záznamy';  //'No records found';
  E_Session_Undefined = 'Session je nedefinováno';  //'Session is undefined';
  E_NoCircularRef = 'Vzájemná reference není povolena';  //'Circular reference not allowed';
  E_InvalidClassType = 'Neplatný typ tøídy';  //'Invalid class type';
  E_Invalid_RowNum = 'Neplatné èíslo øádku';  //'Invalid RowNum';
  E_Invalid_Syntax = 'Neplatná syntaxe: pøebyteèné nebo chybìjící závorky';  //'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Pole je Null';  //'Array is Null';

  E_Cannot_add_blank_account = 'Nelze pøidat prázdný úèet';  //'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'Nelze pøidat úèet SYSDBA';  //'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Nelze smazat prázdný úèet';  //'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'Nelze smazat úèet SYSDBA';  //'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Nelze mìnit prázdný úèet';  //'Cannot modify blank account';

  E_PLAN_ERROR = 'Chyba Plánu';  //'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'Výjimka Plánu';  //'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Neplatná syntaxe CREATE, CONNECT nebo DROP DATABASE';  //'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Nepodporováno';  //'Unsupported';
  E_NotImplemented = 'V této úrovná neimplementováno';  //'Not implemented at this level';
  E_Invalid_ColData = 'Neplatná ColData';  //'Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Nelze zrušit pøípravu probíhajícího procesu';  //'Cannot Unprepare an executing process';
  E_FileName_Required = 'Je vyžadováno jméno souboru';  //'Filename is required';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Správa uživatelských úètù';  //'User Account Management';
  L_USERS_ADD = 'Pøidat';  //'Add';
  L_USERS_DELETE = 'Smazat';  //'Delete';
  L_USERS_MODIFIY = 'Opravit';  //'Modify';
  L_USERS_ACCOUNT = 'Úèet';  //'ACCOUNT';
  L_USERS_PASSWORD = 'Heslo';  //'Password';
  L_USERS_GROUP = 'Skupina';  //'Group';
  L_USERS_FIRSTNAME = 'Jméno';  //'First Name';
  L_USERS_MIDDLENAME = 'Alias';  //'Middle Name';
  L_USERS_LASTNAME = 'Pøíjmení';  //'Last Name';

  //IBF_Export
  L_EXPORT_FRM = 'Export';
  L_EXPORT_ASCII = 'Formát souboru';  //' File Format ';
  L_EXPORT_FIXED = 'TXT s pevnou délkou záznamu';  //'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV oddìlovaè';  //'CSV Delimited';
  L_EXPORT_DBF  = 'DBF (nutno ještì testovat)';  //'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = 'ASCII nastavení';  //' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Delimiter';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Formát datumu';  //'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Vèetnì hlavièek';  //'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'Vèetnì CRLF';  //'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Èárkou oddìlený textový soubor ( *.CSV )|*.CSV';  //'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Textové soubory ( *.TXT )|*.TXT';  //'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF soubory';  //'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Chcete opravdu skonèit';  //'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Natahuji záznamy z databáze';  //'Fetching Query Results';
  M_Row_Num = 'Øádek è.%d';  //'Row# %d';
  M_Abort_Fetching_Btn = 'Pøerušit';  //'Abort';

  M_Login_Database = 'Databáze';  //'Database';
  M_Login_User = 'Uživatel';  //'User';
  M_Login_Password = 'Heslo';  //'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Storno';  //'Cancel';
  M_Login_Help_Btn = 'Nápovìda';  //'&Help';
  M_Login_Dialog_Caption = 'Pøihlášení';  //'Login Dialog';

  M_Loading_Caption = 'Otevírám...';  //'Loading...';

  M_SB_REC_CNT = 'Poèet záznamù: %s';  //'Records counted: %d';
  M_Save_Changes = 'Uložit zmìny?';  //'Save changes?';
  M_Abort_Changes = 'Zmìny nebudou uloženy. Chtete-li pokraèovat, kliknìte na Ok';  //'Changes will be lost. Ok to proceed?';

  M_CancelTransactionPrompt = 'Opravdu chcete stornovat všechny zmìny?';  //'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'Pøerušit vykonávání tohoto skriptu?';  //'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Pokraèovat ve vykonávání tohoto skriptu?';  //'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Skript je právì vykonáván';  //'Script is currently executing';
  M_SCRIPT_FAILED = 'Skript nebyl dokonèen';  //'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Vykonávání skriptu bylo pøerušeno';  //'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Skript byl dokonèen bez vyjímek';  //'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Skript byl dokonèen s vyjímkami';  //'Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'Zmìnìno';  //'Modified';
  M_SCRIPT_SAVE_CHANGES = 'Uložit zmìny?';  //'Save changes?';

{ Button captions }

  C_BTN_TODAY = 'Dnes';  //'Today';
  C_BTN_CLEAR = 'Vymazat';  //'Clear';

  C_SG_Parameter = 'Parametr';  //'Parameter';
  C_SG_Field = 'Pole';  //'Field';
  C_SG_Name = 'Jméno';  //'Name';
  C_SG_Type = 'Typ';  //'Type';
  C_SG_Info = 'Info';  //';  //'Info';
  C_SG_Value = 'Hodnota';  //'Value';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Storno';  //'Cancel';
  C_BF_CANCEL_ACCEL = '&Storno';  //'&Cancel';
  C_BF_APPLY = 'Použít';  //'Apply';
  C_BF_HELP = 'Nápovìda';  //'Help';
  C_BF_EXECUTE = 'Spustit';  //'Execute';
  C_BF_CLOSE = 'Zavøít';  //'Close';
  C_BF_CLOSE_ACCEL = '&Zavøít';  //'&Close';
  C_BF_FINISH = 'Ukonèit';  //'Finish';
  C_BF_FINISH_ACCEL = '&Ukonèit';  //'&Finish';

  C_FRM_Ordering = 'Øazení';  //'Ordering';

  C_CB_WordWrap = 'Zalamování';  //'Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'Ovlivnìné øádky: ';  //'RowsAffected: ';
  M_SQL_RowsCounted = 'Poèet øádkù: ';  //'Rows Counted: ';
  M_SQL_SessionBusy = 'Session je zaneprázdnìna';  //'Session is currently busy';
  M_SQL_CompleteTransaction = 'Dokonèete, prosím, vaši transakci';  //'Please complete your transaction';
  M_SQL_CannotDeleteDefaultGroup = 'Nelze smazat pøednastavenou skupinu';  //'The default group cannot be deleted';
  M_SQL_ReservedName = 'Jméno je rezervováno: ';  //'This name is reserved: ';
  M_SQL_BackSlashNotAllowed = 'Zpìtné lomítko není povoleno';  //'A back slash is not allowed';
  M_SQL_BlankNameNotAllowed = 'Prázdné jméno není povoleno';  //'A blank name is not allowed';
  M_SQL_RowsFetched = 'Natažených záznamù: ';  //'Rows Fetched: ';
  M_SQL_ConfirmDBCreation = 'Opravdu chcete vytvoøit tuto databázi?';  //'Are you sure you want to create this database?';
  M_SQL_ConfirmNoOtherDBSameName = 'Ujistìte se, prosím, neexistuje databáze se stejným jménem';  //'Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = 'Opravdu chcete tuto databázi smazat?';  //'Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = 'Tato databáze bude definitivnì smazána.'+#13#10+#13#10'Pøesto pokraèovat?';  //'This database will be permanently removed.'+#13#10+#13#10'Continue anyway?';
  M_SQL_AskFormName = 'Vložte jméno formuláøe:';  //'Enter query form name:';
  M_SQL_AskGroupName = 'Vložte jméno skupiny';  //'Enter group name:';
  M_SQL_AskLayoutName = 'Vložte jméno rozvržení';  //'Enter layout name:';
  M_SQL_ConfirmGroupDeletion = 'Opravdu chcete smazat skupinu %s vèetnì všech podøízených položek?';  //'Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = 'Opravdu chcete smazat rozvržení %s?';  //'Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = 'Rekurzivní kopírování není povoleno';  //'Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Poklepejte na položku nebo vyberte položku a zmáèknìte Enter';  //'Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'Hodnota parametru';  //'Parameter value';
  M_GCSQL_TypeAValueFor = 'Napište hodnotu pro %s';  //'Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = 'Tato procedura nemá vstupní parametry.';  //'This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Data Pump proces je stále aktivní';  //'Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'Opravdu?';  //'Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Vybrat zdrojovou databázi';  //'Select Source Database';
  M_DP_SELECT_DEST_DB = 'Vybrat cílovou databázi';  //'Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Smazat';  //'Clear';
  M_USERS_COMPLETED_OK = 'Operace byla úspìšnì dokonèena';  //'Operation completed Successfully';
  M_USERS_NO_CONNECTION = 'Není definováno IB_Connection';  //'No IB_Connection defined.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Nastavit položky øazení?';  //'Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Spustit Export';  //'Begin Export';
  M_EXPORT_STILL_ACTIVE = 'Export stále probíhá.';  //'Export process is still active.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Prohlížet databázi';  //'Browse Database';
  C_wbBrowseBtnCaption  = 'Prohlížet';  //'Browse';
  C_wbDSQLBtnHint       = 'Provést pøíkaz v databázi';  //'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitorovat události databáze';  //'Monitor Database Events';
  C_wbEventsBtnCaption  = 'Události';  //'Events';
  C_wbExportBtnHint     = 'Exportovat dataset z databáze';  //'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Export';  //'Export';
  C_wbDumpBtnHint       = 'Uložit databázi';  //'Dump Database';
  C_wbDumpBtnCaption    = 'Uložit';  //'Dump';
  C_wbPumpBtnHint       = 'Importovat data z jiné databáze';  //'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Importovat';  //'Pump';
  C_wbWhoBtnHint        = 'Seznam pøipojených uživatelù';  //'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Kdo';  //'Who';
  C_wbScriptBtnHint     = 'Provést skript';  //'Execute Script';
  C_wbScriptBtnCaption  = 'Skript';  //'Script';
  C_wbExtractBtnHint    = 'Extrahovat DDL';  //'Extract DDL';
  C_wbExtractBtnCaption = 'Extrahovat';  //'Extract';
  C_wbMonitorBtnHint    = 'Sledovat SQL a API volání';  //'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monitor';  //'Monitor';
  C_wbProfilerBtnHint   = 'Profilovat aktivitu databáze';  //'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profiler';  //'Profiler';
  C_wbStatusBtnHint     = 'Status IBO komponent';  //'View Status of IBO Components';
  C_wbStatusBtnCaption  = 'Status';  //'Status';
  C_wbUsersBtnHint      = 'Správa uživatelù databázového serveru';  //'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'Uživatelé';  //'Users';

  // Array grid
  C_AG_Row             = 'Øádek';  //'Row';
  C_AG_Column          = 'Sloupec';  //'Column';

  //IBF_Who
  C_WHO_FRM            = 'Kdo je pøipojen';  //'Who is connected';
  C_WHO_BTNAPPLY       = 'Aktualizovat';  //'Refresh';

  C_NB_FIRST = 'První';  //'First';
  C_NB_PRIOR = 'Pøedchozí';  //'Prior';
  C_NB_NEXT = 'Následující';  //'Next';
  C_NB_LAST = 'Poslední';  //'Last';

  C_ST_Open = 'Otevøít';  //'Open';
  C_ST_Close = 'Zavøít';  //'Close';
  C_ST_Prepare = 'Pøipravit';  //'Prepare';
  C_ST_Unprepare = 'Zrušit pøípravu';  //'Unprepare';
  C_ST_ReadOnly = 'Pro ètení';  //'Read Only';
  C_ST_New = 'Nový';  //'New';
  C_ST_Post = 'Uložit';  //'Post';
  C_ST_Cancel = 'Storno';  //'Cancel';
  C_ST_Delete = 'Smazat';  //'Delete';
  C_ST_Edit = 'Opravit';  //'Edit';
  C_ST_RefreshKeys = 'Aktualizovat klíèe';  //'Refresh Keys';
  C_ST_RefreshRows = 'Aktualizovat záznamy';  //'Refresh Rows';
  C_ST_Refresh = 'Aktualizovat';  //'Refresh';

{ Hints }

  H_UB_EDIT = 'Opravit záznam';  //'Edit Row';
  H_UB_INSERT = 'Nový záznam';  //'Insert Row';
  H_UB_DELETE = 'Smazat záznam';  //'Delete Row';
  H_UB_REFRESH = 'Aktualizovat všechny záznamy';  //'Refresh all records';
  H_UB_REFRESHKEYS = 'Aktualizovat klíèe záznamù';  //'Refresh record keys';
  H_UB_REFRESHROWS = 'Aktualizovat øádky záznamù';  //'Refresh record rows';
  H_UB_REFRESHFILTROWS = 'Aktualizovat filtrované záznamy';  //'Refresh filtered rows';
  H_UB_POSTSEARCH = 'Potvrdit vyhledávací kritéria';  //'Post search criteria';
  H_UB_CANCELSEARCH = 'Stornovat vyhledávací kritéria';  //'Cancel search criteria';
  H_UB_POSTEDIT = 'Uložit opravený záznam';  //'Post edits';
  H_UB_CANCELEDIT = 'Stornovat opravený záznam';  //'Cancel edits';
  H_UB_POSTINSERT = 'Uložit nový záznam';  //'Post insert';
  H_UB_CANCELINSERT = 'Stornovat nový záznam';  //'Cancel insert';
  H_UB_POSTDELETE = 'Potvrdit smazání záznamu';  //'Post delete';
  H_UB_CANCELDELETE = 'Stornovat smazání záznamu';  //Cancel delete';
  H_UB_POST = 'Uložit zmìny';  //'Post changes';
  H_UB_CANCEL = 'Stornovat zmìny';  //Cancel changes';

  H_NB_FIRST = 'První záznam';  //'First Row';
  H_NB_PRIOR = 'Poslední záznam';  //'Prior Row';
  H_NB_NEXT = 'Následující záznam';  //'Next Row';
  H_NB_LAST = 'Pøedchozí';  //'Last Row';
  H_NB_JUMPBCK = 'Dopøedu';  //'Backwards';
  H_NB_JUMPFWD = 'Dozadu';  //'Forwards';

  H_SB_ORDER = 'Seøadit záznamy';  //'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Obnovit poslední kritéria';  //'Recall Last Search Criteria';
  H_SB_SEARCH = 'Hledat';  //'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Uložit kritéria';  //'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Smazat kritéria';  //'Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Obnovit kritéria';  //'Recall Criteria';
  H_SB_SEARCHCOUNT = 'Poèet záznamù vyhovujících kritériím';  //'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Spoèítat øádky';  //'Count Rows in Dataset';

  H_TB_StartTransaction = 'Spustit transakci';  //'Start Transaction';
  H_TB_PostDatasets = 'Potvrdit datasety';  //'Post Datasets';
  H_TB_CancelDatasets = 'Stornovat datasety';  //'Cancel Datasets';
  H_TB_SavePoint = 'Potvrdit a podržet aktuální transakci';  //'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Potvrdit datasety a Potvrdit a podržet aktuální transakci';  //'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = '';  //'Commit and End Current Transaction';
  H_TB_Rollback = 'Vrátit zpìt a ukonèit aktuální transakci';  //'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Vrátit zpìt a podržet aktuální transakci';  //'Rollback and Retain Current Transaction';
  H_TB_Close = 'Ukonèit aktuální transakci';  //'Close Current Transaction';

  H_ST_Prepare_Statement = 'Pøipravit pøíkaz';  //'Prepare Statement';
  H_ST_Unprepare_Statement = 'Zrušit pøipravenost pøíkazu';  //'Unprepare Statement';
  H_ST_Execute_Statement = 'Provést pøíkaz';  //'Execute Statement';

  H_DS_Open_Dataset = 'Otevøít dataset';  //'Open Dataset';
  H_DS_Close_Dataset = 'Zavøít dataset';  //'Close Dataset';
  H_DS_Prepare_Dataset = 'Pøipravit dataset';  //'Prepare Dataset';
  H_DS_Unprepare_Dataset = 'Zrušit pøipravenost datasetu';  //'Unprepare Dataset';
  H_DS_ReadOnly_Dataset = 'Dataset jen pro ètení';  //'Read Only Dataset';

  H_CB_Create_Database = 'Vytvoøit databázi';  //'Create Database';
  H_CB_Connect_Database = 'Pøipojit databázi';  //'Connect Database';
  H_CB_Disconnect_Database = 'Odpojit databázi';  //'Disconnect Database';
  H_CB_Drop_Database = 'Vymazat databázi';  //'Drop Database';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Export z pøíkazu SELECT';  //'Export from SELECT statement';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Chybí informace o Ascii souboru';  //'Missing entry for Ascii file';
  eNoDestTableEntry          = 'Chybí informace o cílové tabulce';  //'Missing entry for destination table';
  eAsciiFileNotFound         = 'Ascii soubor %s nenalezen';  //'Ascii file %s not found';
  eIniFileNotFound           = 'Ini soubor %s nenalezen';  //'Ini-file %s not found';
  eNoAsciiFileAccess         = 'Nelze otevøít ascii soubor %s';  //'Could not open ascii file %s';
  eInvalidCharFound          = 'Neplatný znak / chyba formátu ascii souboru';  //'Invalid char / format error in ascii file';
  eOutOfMemory               = 'Málo pamìti';  //'Out of memory';
  eFieldDescriptionError     = 'Chyba v popisu pole';  //'Error in field description';
  eWrongAsciiFieldCount      = 'Špatný poèet polí v ascci souboru';  //'Wrong field count in ascii file';
  eWrongDecimalCount         = 'Špatný poèet desetinných míst v seznamu polí (%s)';  //'Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth           = 'Špatná šíøka pole v ascii souboru';  //'Wrong field width in ascii file';

  // Dialog Labels - IB_Import
  lblRecsReadedCaption       = 'Celkem pøeètených záznamù';  //'Total Records read';
  lblRecsCommentedCaption    = 'Zapoznámkovaných záznamù';  //'Records commented';
  lblRecsInsertedCaption     = 'Vložených záznamù';  //'Records inserted';
  btnAbortImportCaption      = 'Ukonèit';  //'Abort';

