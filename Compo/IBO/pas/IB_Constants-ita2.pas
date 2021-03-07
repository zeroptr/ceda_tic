(* automagically translated from ITA/IBO40CRT_D5_DRC.rc *)
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
  IB_VERSION_BUILD = 'G';
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

  IB_REG_MESSAGE = 'Grazie per visionare IB Objects.'#13#10#13#10'Vi prego di visitare la pagina http://www.ibobjects.com e registrarvi oggi stesso.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED = 'La connessione è già stata stabilita';
  E_NOT_CONNECTED = 'La connessione non è ancora stata stabilita';
  E_Invalid_conn_path = 'Path di connessione non valido';
  E_Cant_Repl_Int_Tr = 'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED = 'La transazione non è stata attivata';
  E_TRANS_STARTED = 'La transazione è già stata attivata';
  E_NO_CONNECTIONS = 'La transazione non ha una connessione';
  E_NOT_ENOUGH_CONN = 'La transazione necessita di una o più connessioni';
  E_CONN_LOADING = 'Avviso: La connessione sta per essere stabilita';
  E_TRANS_CONN_SESS = 'Le connessioni devono essere nella stessa IB_Session';
  E_TransactionPaused = 'La transazione è Sospesa';
  E_ALLOCATED = 'L''istruzione è già stata allocata';
  E_NOT_ALLOCATED = 'L''istruzione non è ancora stata allocata';
  E_PREPARED = 'L''istruzione è già stata preparata';
  E_NOT_PREPARED = 'L''istruzione non è stata preparata';
  E_FAILED_TO_PREPARE = 'L''istruzione non può essere preparata';
  E_OPENED = 'L''istruzione è già stata aperta';
  E_NOT_OPENED = 'L''istruzione non è stata aperta';
  E_CANT_DELETE = 'Il record corrente nel cursore non può essere cancellato';
  E_NO_CONNECTION = 'L''istruzione deve avere una IB_Connection assegnata';
  E_CONNECT_FAILED = 'Impossibile aprire IB_Connection';
  E_NO_TRANSACTION = 'L''istruzione deve avere una IB_Transaction assegnata';
  E_NO_ACTIVE_TRANS = 'Nessuna transazione attiva con cui eseguire';
  E_START_FAILED = 'Impossibile attivare una transazione';
  E_SVRAUTOCMT_NOEXP = 'Transazioni esplicite non consentite con ServerAutoCommit';
  E_Cannot_Activate = 'Stato della transazione non valido. Attivazione impossibile';
  E_Transaction_Is_Active = 'La transazione ha delle modifiche non confermate';
  E_Failed_To_Post_Datasets = 'Impossibile confermare le modifiche su tutti i dataset';
  E_Failed_To_Cancel_Datasets = 'Impossibile annullare le modifiche su tutti i dataset';
  E_UpdateWrongTrn = 'Impossibile aggiornare, %s non è controllato da %s';
  E_NO_BLANK_SQL = 'Non sono consentite istruzioni SQL vuote';
  E_AT_END_OF_FILE = 'Alla fine del file';
  E_AT_END_OF_CURSOR = 'Alla fine del cursore';
  E_AT_END_OF_BUFFER = 'Alla fine del buffer';
  E_AT_END_OF_DATASET = 'Alla fine del dataset';
  E_BAD_SQL_INF_LEN = 'Lunghezza inaspettata in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA = 'Dati non validi ritornati da isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK = 'Non è possibile cambiare il nome del cursore mentre è attivo';
  E_REQUEST_LIVE_ACTIVE = 'Non è possibile cambiare RequestLive mentre è attivo';
  E_REQUEST_LIVE_READONLY = 'Non è possibile impostare RequestLive un dataset a sola lettura';
  E_CURSOR_UNI = 'IB_CURSOR è unidirezionale';
  E_UNSUPPORTED_COLUMN_TYPE = 'Tipo di Colonna non supportato: %d';
  E_FIELDNO_NOT_FOUND = 'Campo n° %d non trovato';
  E_FIELDNAME_NOT_FOUND = 'Campo "%s" non trovato';
  E_INVALID_FOCUS_RELATION_NO = 'Selezione non valida della relazione n° %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Selezione non valida della relazione "%s"';
  E_INVALID_QBE_IN = 'Errore di sintassi -- IN( valore [ , valore ... ] )';
  E_INVALID_QBE_BETWEEN = 'Errore di sintassi -- BETWEEN valore AND valore';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Impossibile importare la DLL "%s"';
  E_INVALID_SQL_KEY_FIELDS = 'Proprietà SQLKeyFields non valida';
  E_GET_CURSOR_ERROR = 'Non è possibile aprire un cursore senza i dati della chiave';
  E_SCROLL_ERROR = 'La chiave del record è stata persa'#13#10'Errore nell''apertura del cursore';
  E_INVALID_BUFFER_ROW_NUM = 'BufferRowNum non valido prima dell''inizio';
  E_BLANK_STATEMENT = 'Non è possibile preparare un''istruzione vuota';
  E_UNKNOWN_STATEMENT = 'Tentata esecuzione di una istruzione sconosciuta';
  E_CIRCULAR_REFERENCE = 'Non sono consentite referenze circolari';
  E_CANT_CHG_WITH_CONN = 'Modifica impossibile mentre la connessione è attiva';
  E_LOGIN_FAILED = 'Login fallito';
  E_CANT_GET_CONN_CHR = 'Impossibile ottenere le caratteristiche della connessione';
  E_MAX_EVENTS_BLOCK = 'E'' stato superato il numero massimo di eventi per un blocco';
  E_PROCESSING_EVENTS = 'Eventi in elaborazione'#13#10'De-registrazione impossibile';
  E_CANT_STORE_BLOB = 'Il Blob è già memorizzato oppure non è possibile farlo';
  E_CANT_LOAD_BLOB = 'Il Blob è già stato caricato oppure non è possibile farlo';
  E_CANNOT_CANCEL_ROW = 'Non è possibile annullare le modifiche della riga corrente';
  E_CANNOT_POST_ROW = 'Non è possibile eseguire il post della riga corrente';
  E_DatasetClosed = 'Il dataset non è attivato';
  E_DatasetOpen = 'Il dataset è già attivato';
  E_DatasetCannotScroll = 'Non è possibile scorrere ll dataset';
  E_DatasetReadOnly = 'Il dataset è a Sola Lettura';
  E_DatasetIsFetching = 'Il dataset sta caricandosi';
  E_Invalid_KeyRelation = 'Valore di KeyRelation non valido';
  E_RowNum_Not_Implemented = 'RowNum non è ancora implementato';
  E_RowDeleted = 'La riga sta per essere cancellata';
  E_END_OF_DATASET = 'Alla fine del dataset';
  E_BEGINNING_OF_DATASET = 'All''inizio del dataset';
  E_Cannot_Pessimistic_Lock = 'Non è possibile usare il "pessimistic locking" con LockWait';
  E_Cannot_Edit_Row = 'Non è possibile editare la riga corrente';
  E_Cannot_Insert_Row = 'Non è possibile inserire una nuova riga';
  E_Cannot_Delete_Row = 'Non è possibile cancellare la riga corrente';
  E_Cannot_Search = 'La ricerca non è consentita';
  E_Cannot_Navigate = 'Non è possibile scorrere i dati';
  E_Record_Locked = 'Il record è bloccato da un altro utente';
  E_Record_OutOfSynch = 'Il record è stato modificato da un altro utente';
  E_FLD_READONLY = '%s è a Sola Lettura';
  E_Required_Field = '%s è un campo obbligatorio';
  E_NO_POSTRTN_CACHED_UPDT = 'Non è possibile utilizzare PostRetaining con i Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Più di una riga in una selezione univoca';

  E_InvalidRowsAffectedBuf = 'Buffer RowsAffected non valido';
  E_Invalid_RowNum_Past_Eof = 'RowNum non valido, oltre la fine del set';
  E_Invalid_RowNum_Before_Bof = 'RowNum non valido, inferiore all''inizio del set';
  E_Invalid_Bookmark = 'Stringa di Bookmark non valida';

  E_Assign_Column = 'Non è possibile assegnare il valore da %s';
  E_AssignTo_Column = 'Non è possibile assegnare un valore a %s';
  E_Value_Out_Of_Range = 'Valore fuori dai limiti';
  E_SmallintOverflow = 'Smallint overflow';
  E_IntegerOverflow = 'Overflow su Integer';
  E_Int64Overflow = 'Overflow su Int64';

  E_Unsupported_Column = 'Tipo di colonna non supportato: %d';
  E_UndefinedMacro = 'Macro non definita';
  E_GeneratorFailed = 'Impossibile ottenere il valore del generatore';

  E_MustBe_Buffered_Dataset = 'Deve discendere da TIB_BDataset (IB_Query)';

  E_NO_CHANGE_READONLY = 'Non è possibile modificare ReadOnly mentre la transazione è attiva';
  E_NO_CHANGE_ISOLATION = 'Non è possibile modificare Isolation mentre la transazione è attiva';
  E_NO_CHANGE_RECVERSION = 'Non è possibile modificare RecVersion mentre la transazione è attiva';
  E_NO_CHANGE_LOCKWAIT = 'Non è possibile modificare LockWait mentre la transazione è attiva';

  E_Invalid_Reference_To_Delete = 'Cancellazione di un riferimento non valido';
  E_Invalid_Typecast = 'Typecast non valido';
  E_Invalid_DataPump_Statement = 'Tipo di istruzione non valido per DataPump';
  E_FIELD_NOT_NULLABLE = 'Campo NOT NULL con valore nullo';
  E_DATABASE_BLANK = 'DatabaseName non può essere vuoto';
  E_Unsupp_Col_Conversion = 'Conversione di colonna non supportata';
  E_Unable_To_Locate_Record = 'Impossibile trovare il record';
  E_Record_Not_Inserted = 'Il record non è stato inserito';
  E_Invalid_KeyLinks = 'KeyLinks non valido: %s';
  E_Unable_to_perform_search = 'Impossibile effettuare la ricerca';
  E_Unassigned_Blob_Node = 'BlobNode non assegnato';
  E_Unassigned_Transaction = 'Transazione non assegnata';
  E_Invalid_RowsAffected_Buffer = 'Buffer RowsAffected non valido';
  E_Unable_Save_Graphic = 'Impossibile memorizzare il valore in un Graphic';
  E_Cannot_Activate_Transaction = 'Impossibile attivare la transazione';
  E_IB_Client_Not_Installed = 'L''InterBase Client GDS32.DLL non risulta installato';
  E_Could_Not_Load_Memo = 'Impossibile caricare il memo';
  E_Invalid_DPB_Over_255 = 'DPB non valido: il contenuto supera i 255 caratteri';
  E_Inv_Custom_DML = 'Riferimento di colonna non valido nel "custom DML": %s';
  E_Record_Not_Located_For_Update = 'Il record da modificare non è stato trovato';
  E_Record_Not_Located_For_Delete = 'Il record da cancellare non è stato trovato';
  E_Init_Default_SQL_Failed = 'Impossibile inizializzare il default %s';
  E_Stringlist_Not_Sorted = 'La Stringlist deve essere ordinata per questa operazione';
  E_Cannot_Change_Events = 'Non è possibile modificare gli eventi durante il processing';
  E_Cannot_Unregister_Events = 'Non è possibile de-registrare gli eventi durante il processing';
  E_Invalid_Internal_Transaction = 'IB_Transaction interna non valida';
  E_InvalidStatementType = 'Tipo di istruzione non valido';
  E_Multiple_Records_Updated = 'E'' stato aggiornato più di un record';
  E_Multiple_Records_Deleted = 'E'' stato cancellato più di un record';
  E_Multiple_Records_Inserted = 'Inseriti record multipli';
  E_DUP_DB_NAME = 'Non è consentito un DatabaseName duplicato';
  E_INVALID_DB_NAME = 'DatabaseName non valido';
  E_UnableToSearch_NoOrdering = 'Non posso eseguire la ricerca, l''ordinamento non è stato definito';
  E_UnableToSearch_DatasetBusy = 'Non posso eseguire la ricerca in quanto il dataset sta caricando i dati';
  E_NoRecordsFound = 'Nessun record trovato';
  E_Session_Undefined = 'La sessione è indefinita';
  E_NoCircularRef = 'Riferimenti circolari non consentiti';
  E_InvalidClassType = 'Tipo di classe non valido';
  E_Invalid_RowNum = 'RowNum non valido';
  E_Invalid_Syntax = 'Sintassi non valida: le parentesi non sono corrette';
  E_Array_Is_Null = 'L''Array è nullo';

  E_Cannot_add_blank_account = 'Non è possibile aggiungere un account vuoto';
  E_Cannot_add_SYSDBA_account = 'Non è possibile aggiungere un account SYSDBA';
  E_Cannot_delete_blank_account = 'Non è possibile cancellare un account vuoto';
  E_Cannot_delete_SYSDBA_account = 'Non è possibile cancellare l''account SYSDBA';
  E_Cannot_modify_blank_account = 'Non è possibile modificare un account vuoto';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Sintassi non valida per CREATE, CONNECT o DROP DATABASE';
  E_Unsupported = 'Non supportato';
  E_NotImplemented = 'Non ancora implementato a questo livello';
  E_Invalid_ColData = 'ColData non valido';

  E_Cant_Unprepare_executing_process = 'Non è possibile spreparare un''istruzione in esecuzione';
  E_FileName_Required = 'Il nome del file è obbligatorio';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Gestione Utenti';
  L_USERS_ADD = 'Aggiungi';
  L_USERS_DELETE = 'Cancella';
  L_USERS_MODIFIY = 'Modifica';
  L_USERS_ACCOUNT = 'ACCOUNT';
  L_USERS_PASSWORD = 'Password';
  L_USERS_GROUP = 'Gruppo';
  L_USERS_FIRSTNAME = 'Nome';
  L_USERS_MIDDLENAME = 'Secondo nome';
  L_USERS_LASTNAME = 'Cognome';

  //IBF_Export
  L_EXPORT_FRM = 'Esporta';
  L_EXPORT_ASCII = ' Formato del file ';
  L_EXPORT_FIXED = 'TXT Record a tracciato fisso';
  L_EXPORT_DELIMITED = 'CSV Dati delimitati';
  L_EXPORT_DBF = 'DBF  (ancora in test)';
  L_EXPORT_ASCIIOPT = ' Opzioni ASCII ';
  L_EXPORT_DELIMITER = 'Delimitatore';
  L_EXPORT_SEPARATOR = 'Separatore';
  L_EXPORT_DATEFORMAT = 'Formato date';
  L_EXPORT_INCLUDEHEADERS = 'Includi Intestazione';
  L_EXPORT_INCLUDECRLF = 'Includi CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Esporta';
  L_EXPORT_SDEXPORTFILTERCSV = 'File dati separati da virgole ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'File di Testo ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'File DBF ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Sei sicuro di voler annullare?';
  M_Fetching_Query_Results = 'Acquisisco i dati';
  M_Row_Num = 'Record n° %d';
  M_Abort_Fetching_Btn = 'Annulla';

  M_Login_Database = 'Database';
  M_Login_User = 'Utente';
  M_Login_Password = 'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Annulla';
  M_Login_Help_Btn = 'Aiuto';
  M_Login_Dialog_Caption = 'Pannello di Login';

  M_Loading_Caption = 'Sto caricando...';

  M_SB_REC_CNT = 'Record contati: %d';
  M_Save_Changes = 'Salvo le modifiche?';
  M_Abort_Changes = 'Le modifiche verranno perse. Continuo comunque?';

  M_CancelTransactionPrompt = 'Sicuro di voler annullare tutte le modifiche?';

  M_SCRIPT_ABORT_EXECUTE = 'Annullo l''esecuzione dello script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Continuo l''esecuzione dello script?';
  M_SCRIPT_IS_EXECUTING = 'Lo script è in esecuzione';
  M_SCRIPT_FAILED = 'L''esecuzione dello script non è andata a buon fine';
  M_SCRIPT_WAS_ABORTED = 'L''esecuzione dello script è stata annullata';
  M_SCRIPT_COMPLETED = 'Lo script è stato eseguito senza errori';
  M_SCRIPT_CMPL_EXCEPT = 'Lo script è stato eseguito con errori';
  M_SCRIPT_MODIFIED = 'Modificato';
  M_SCRIPT_SAVE_CHANGES = 'Salvare le modifiche?';

{ Button captions }

  C_BTN_TODAY = 'Oggi';
  C_BTN_CLEAR = 'Azzera';

  C_SG_Parameter = 'Parametro';
  C_SG_Field = 'Campo';
  C_SG_Name = 'Nome';
  C_SG_Type = 'Tipo';
  C_SG_Info = 'Info';
  C_SG_Value = 'Valore';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Annulla';
  C_BF_CANCEL_ACCEL = '&Annulla';
  C_BF_APPLY = 'Applica';
  C_BF_HELP = 'Aiuto';
  C_BF_EXECUTE = 'Esegui';
  C_BF_CLOSE = 'Chiudi';
  C_BF_CLOSE_ACCEL = '&Chiudi';
  C_BF_FINISH = 'Finisci';
  C_BF_FINISH_ACCEL = '&Finisci';

  C_FRM_Ordering = 'Ordinamento';
  C_FRM_RESTRUCTURE = 'Customize Fields Displayed';

  C_CB_WordWrap = 'Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'Righe modificate: ';
  M_SQL_RowsCounted = 'Record contati: ';
  M_SQL_SessionBusy = 'La sessione risulta occupata';
  M_SQL_CompleteTransaction = 'Devi completare la transazione';
  M_SQL_CannotDeleteDefaultGroup = 'Il gruppo di default non può essere cancellato';
  M_SQL_ReservedName = 'Questo nome è riservato: ';
  M_SQL_BackSlashNotAllowed = 'Il carattere back-slash (''\'') non è consentito';
  M_SQL_BlankNameNotAllowed = 'Un nome nullo non è consentito';
  M_SQL_RowsFetched = 'Record letti: ';
  M_SQL_ConfirmDBCreation = 'Sei sicuro di voler creare questo database?';
  M_SQL_ConfirmNoOtherDBSameName = 'Assicurati per favore che non esista già un database con questo nome.';
  M_SQL_ConfirmDBDrop = 'Sei sicuro di voler eliminare questo database?';
  M_SQL_ReConfirmDBDrop = 'Questo database verrà eliminato definitivamente.'#13#10#13#10'Continuo comunque?';
  M_SQL_AskFormName = 'Inserisci il nome della query:';
  M_SQL_AskGroupName = 'Inserisci il nome del gruppo:';
  M_SQL_AskLayoutName = 'Inserisci il nome del profilo:';
  M_SQL_ConfirmGroupDeletion = 'Sei sicuro di voler cancellare il gruppo %s e tutti gli elementi che contiene?';
  M_SQL_ConfirmLayoutDeletion = 'Sei sicuro di voler cancellare il profilo %s?';
  M_SQL_RecursiveCopyNotAllowed = 'La copia ricorsiva non è consentita';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Fai un doppio click su uno degli elementi, o premi Invio dopo averne selezionato uno.';
  M_GCSQL_ParameterValue = 'Valore del parametro';
  M_GCSQL_TypeAValueFor = 'Immetti un valore per %s';
  M_GCSQL_ProcedureWithoutParams = 'Questa procedura non ha parametri in ingresso.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Il processo di Data Pump è ancora attivo.';
  M_DP_ARE_YOU_SURE = 'Sei sicuro?';
  M_DP_SELECT_SOURCE_DB = 'Seleziona il Database Sorgente';
  M_DP_SELECT_DEST_DB = 'Selezione il Database di Destinazione';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Azzera';
  M_USERS_COMPLETED_OK = 'Operazione completata con Successo';
  M_USERS_NO_CONNECTION = 'Non è definita nessuna IB_Connection.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Assegno anche gli ''ordering items''?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Inizio esportazione';
  M_EXPORT_STILL_ACTIVE = 'Il processo di esportazione è ancora attivo.';

  // IB_UtilityBar
  C_wbBrowseBtnHint = 'Esamina il Database';
  C_wbBrowseBtnCaption = 'Esamina';
  C_wbDSQLBtnHint = 'Esegui istruzioni DSQL nel Database';
  C_wbDSQLBtnCaption = 'DSQL';
  C_wbEventsBtnHint = 'Monitora gli Eventi del Database';
  C_wbEventsBtnCaption = 'Eventi';
  C_wbExportBtnHint = 'Esporta un Dataset dal Database';
  C_wbExportBtnCaption = 'Esporta';
  C_wbDumpBtnHint = 'Estrai i dati dal Database';
  C_wbDumpBtnCaption = 'Dump';
  C_wbPumpBtnHint = 'Carica dati da un altro Database';
  C_wbPumpBtnCaption = 'Pump';
  C_wbWhoBtnHint = 'Vedi chi è connesso al Database';
  C_wbWhoBtnCaption = 'Chi';
  C_wbScriptBtnHint = 'Esegui uno Script SQL';
  C_wbScriptBtnCaption = 'Script';
  C_wbExtractBtnHint = 'Extract Metadata DDL';
  C_wbExtractBtnCaption = 'Metadata Extract';
  C_wbMonitorBtnHint = 'Traccia le istruzioni SQL e le chiamate alla API';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint = 'Controlla e misura l''attività del Database';
  C_wbProfilerBtnCaption = 'Profiler';
  C_wbStatusBtnHint = 'Visualizza lo stato dei componenti IBO';
  C_wbStatusBtnCaption = 'Status';
  C_wbUsersBtnHint = 'Amministra gli Utenti del Server Database';
  C_wbUsersBtnCaption = 'Utenti';

  // Array grid
  C_AG_Row = 'Riga';
  C_AG_Column = 'Colonna';

  //IBF_Who
  C_WHO_FRM = 'Chi è connesso';
  C_WHO_BTNAPPLY = 'Aggiorna';

  C_NB_FIRST = 'Primo';
  C_NB_PRIOR = 'Precedente';
  C_NB_NEXT = 'Prossimo';
  C_NB_LAST = 'Ultimo';

  C_ST_Open = 'Apri';
  C_ST_Close = 'Chiudi';
  C_ST_Prepare = 'Prepara';
  C_ST_Unprepare = 'Sprepara';
  C_ST_ReadOnly = 'Sola Lettura';
  C_ST_New = 'Nuovo';
  C_ST_Post = 'Conferma';
  C_ST_Cancel = 'Annulla';
  C_ST_Delete = 'Cancella';
  C_ST_Edit = 'Modifica';
  C_ST_RefreshKeys = 'Aggiorna le chiavi';
  C_ST_RefreshRows = 'Aggiorna i record';
  C_ST_Refresh = 'Aggiorna';

{ Hints }

  H_UB_EDIT = 'Edita il record';
  H_UB_INSERT = 'Inserisci un record';
  H_UB_DELETE = 'Cancella il record';
  H_UB_REFRESH = 'Aggiorna tutti i record';
  H_UB_REFRESHKEYS = 'Aggiorna le chiavi dei record';
  H_UB_REFRESHROWS = 'Aggiorna i dati dei record';
  H_UB_REFRESHFILTROWS = 'Aggiorna le righe filtrate';
  H_UB_POSTSEARCH = 'Applica i criteri di ricerca';
  H_UB_CANCELSEARCH = 'Annulla i criteri di ricerca';
  H_UB_POSTEDIT = 'Esegui le modifiche';
  H_UB_CANCELEDIT = 'Annulla le modifiche';
  H_UB_POSTINSERT = 'Esegui l''inserimento';
  H_UB_CANCELINSERT = 'Annulla l''inserimento';
  H_UB_POSTDELETE = 'Esegui la cancellazione';
  H_UB_CANCELDELETE = 'Annulla la cancellazione';
  H_UB_POST = 'Esegui';
  H_UB_CANCEL = 'Annulla';

  H_NB_FIRST = 'Primo record';
  H_NB_PRIOR = 'Record precedente';
  H_NB_NEXT = 'Prossimo record';
  H_NB_LAST = 'Ultimo record';
  H_NB_JUMPBCK = 'Indietro';
  H_NB_JUMPFWD = 'Avanti';

  H_SB_ORDER = 'Ordina i record nel Dataset';
  H_SB_LAST_CRITERIA = 'Richiama gli ultimi Criteri di Ricerca';
  H_SB_SEARCH = 'Cerca nel Dataset';
  H_SB_SAVE_CRITERIA = 'Salva i Criteri di Ricerca';
  H_SB_CLEAR_CRITERIA = 'Azzera i Criteri di Ricerca';
  H_SB_RECALL_CRITERIA = 'Richiama i Criteri di Ricerca';
  H_SB_SEARCHCOUNT = 'Conta i record nel Dataset che soffisfano le condizioni di ricerca';
  H_SB_COUNT = 'Conta i record nel Dataset';
  H_SB_RESTRUCTURE = 'Customize the Fields Displayed';

  H_TB_StartTransaction = 'Inizia una transazione';
  H_TB_PostDatasets = 'Esegui il post sui Dataset';
  H_TB_CancelDatasets = 'Annulla le modifiche sui Dataset';
  H_TB_SavePoint = 'Conferma le modifiche mantenendo attiva la transazione corrente';
  H_TB_CommitRetain = 'Esegui il post sui Dataset e conferma le modifiche mantenendo attiva la transazione corrente';
  H_TB_Commit = 'Conferma le modifiche e chiudi la transazione corrente';
  H_TB_Rollback = 'Annulla le modifiche e chiudi la transazione corrente';
  H_TB_RollbackRetain = 'Annulla le modifiche mantenendo attiva la transazione corrente';
  H_TB_Close = 'Chiudi la transazione corrente';

  H_ST_Prepare_Statement = 'Prepara lo Statement';
  H_ST_Unprepare_Statement = 'Sprepara lo Statement';
  H_ST_Execute_Statement = 'Esegui lo Statement';

  H_DS_Open_Dataset = 'Apri il Dataset';
  H_DS_Close_Dataset = 'Chiudi il Dataset';
  H_DS_Prepare_Dataset = 'Prepara il Dataset';
  H_DS_Unprepare_Dataset = 'Sprepara il Dataset';
  H_DS_ReadOnly_Dataset = 'Dataset a Sola Lettura';

  H_CB_Create_Database = 'Crea il Database';
  H_CB_Connect_Database = 'Connetti il Database';
  H_CB_Disconnect_Database = 'Disconnetti il Database';
  H_CB_Drop_Database = 'Elimina il Database';

  H_RD_actHide = 'Nascondi i campi selezionati';
  H_RD_actHideAll = 'Nascondi tutti i campi';
  H_RD_actVisible = 'Rendi visibili i campi selezionati';
  H_RD_actVisibleAll = 'Rendi visibili tutti i campi selezionati';
  H_RD_actUp = 'Sposta i campi selezionati in su di uno';
  H_RD_actTop = 'Sposta i campi selezionati in cima';
  H_RD_actDown = 'Sposta i campi selezionati in giù di uno';
  H_RD_actBottom = 'Sposta i campi selezionati in fondo';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Esporta il risultato di una istruzione SELECT';

  // Error Messages - IB_Import
  eNoAsciiFileEnty = 'Non è stato specificato il nome del file Ascii';
  eNoDestTableEntry = 'Non è stata specificata la tabella di destinazione';
  eAsciiFileNotFound = 'Il file ascii %s non è stato trovato';
  eIniFileNotFound = 'Il file INI %s non è stato trovato';
  eNoAsciiFileAccess = 'Impossibile aprire il file ascii %s';
  eInvalidCharFound = 'Carattere non valido / errore di formato nel file ascii';
  eOutOfMemory = 'Memoria esaurita';
  eFieldDescriptionError = 'Errore nella descrizione del campo';
  eWrongAsciiFieldCount = 'Numero di campi errato nel file ascii';
  eWrongDecimalCount = 'Numero di decimali errato nella lista dei campi (%s)';
  eWrongFieldWidth = 'Dimensione del campo errata nel file ascii';

  // Dialog Labels - IB_Import
  lblRecsReadedCaption = 'Totale Record letti';
  lblRecsCommentedCaption = 'Record commentato';
  lblRecsInsertedCaption = 'Record inseriti';
  btnAbortImportCaption = 'Annulla';

  // Metadata Extract Stuff
  // ------------------------

  // Entity Type Names
  STR_DDL_UnnamedItem = '<NO NAME>';
  STR_DDL_etDatabase = 'Database';
  STR_DDL_etException = 'Exception';
  STR_DDL_etBlobFilter = 'Blob Filter';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Generatore';
  STR_DDL_etDomain = 'Dominio';
  STR_DDL_etTable = 'Tabella';
  STR_DDL_etView = 'View';
  STR_DDL_etProcedure = 'Procedura';
  STR_DDL_etRole = 'Ruolo';
  STR_DDL_etPrimaryKey = 'Chiave primaria';
  STR_DDL_etUniqueKey = 'Chiave univoca';
  STR_DDL_etForeignKey = 'Chiave esterna';
  STR_DDL_etConstraint = 'Vincolo';
  STR_DDL_etIndex = 'Indice';
  STR_DDL_etTrigger = 'Trigger';
  STR_DDL_etPermission = 'Permesso';
  STR_DDL_etUDFParam = 'Parametro UDF';
  STR_DDL_etTableField = 'Table Field';
  STR_DDL_etViewField = 'View Field';
  STR_DDL_etProcParam = 'Procedure Parameter';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Crea database';
  STR_DDL_coSecondaryFiles = 'Define Secondary Files';
  STR_DDL_coDefineShadows = 'Define Shadows';
  STR_DDL_coSetGeneratorVal = 'Setta il valore del Generatore';
  STR_DDL_coResetExceptionNo = 'Reset Exception Number';
  STR_DDL_coRawFieldDefs = 'Raw Field Definitions';
  STR_DDL_coReportMinor = 'Report Minor';
  STR_DDL_coAlwaysQuoted = 'Always Quoted';
  STR_DDL_coAlwaysCharSet = 'Definisci sempre il Character Set';
  STR_DDL_coIncludeDebug = 'Includi Commenti di Debug';
  STR_DDL_coDescripAsComment = 'Descrizioni come Commenti';

  // CodePass Names
  STR_DDL_cpFull = 'Full';
  STR_DDL_cpInit = 'Initial';
  STR_DDL_cpFinal = 'Final';

  // Dialog strings
  STR_DDL_DialogCaption = 'Estrai i Metadati';
  STR_DDL_Configure = 'Configura';
  STR_DDL_Filters = 'Filtri';
  STR_DDL_Script = 'Script';
  STR_DDL_MetadataControls = 'Metadata Controls';
  STR_DDL_CodeOptions = 'Code Options';
  STR_DDL_Entities = 'Entities';
  STR_DDL_Terminator = 'Terminator';
  STR_DDL_ExecuteControls = 'Execute Controls';
  STR_DDL_CodePass = 'Code Pass';
  STR_DDL_ExtractToStrings = 'Extract To Strings';
  STR_DDL_Reset = 'Reset';
  STR_DDL_ResetAll = 'Reset All';
  STR_DDL_ProgressControls = 'Progress Controls';
  STR_DDL_Stop = 'Stop';
  STR_DDL_IncludeSystem = 'Includi oggetti di Sistema';
  STR_DDL_NameMasks = 'Name Masks';
  STR_DDL_SaveToFile = 'Salva nel File';

implementation

end.
