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
{ Italian version translated by Marco Lauria                                   }
{ e-mail address:            mslauria@tin.it                                   }
{ Correction of bugs about version 4.2 Fa by Massimo Murazzano max@logosoft.it }
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
  IB_VERSION_MINOR = '0';
  IB_VERSION_BUILD = '1';
  IB_VERSION_SUB_RELEASE = '232';
  
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

  IB_REG_MESSAGE = 'Grazie per visionare IBObjects.'#10#13#10#13 +
                   'Vi prego di visitare la pagina http://www.ibobjects.com e registrarvi oggi stesso.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'La connessione è stata già stabilita';
  E_NOT_CONNECTED     = 'La connessione non è stata ancora stabilita';
  E_Invalid_conn_path = 'Path di connessione invalido';
  E_Cant_Repl_Int_Tr  = 'Non posso rimpiazzare la transazione interna con la predefinita';
  E_NO_TRANS_STARTED  = 'La Transazione non è cominciata';
  E_TRANS_STARTED     = 'La Transazione è già cominciata';
  E_NO_CONNECTIONS    = 'La Transazione non ha connessioni';
  E_NOT_ENOUGH_CONN   = 'La Transazione manca di una o più connessioni';
  E_CONN_LOADING      = 'Attenzione: La connessione sta caricando';
  E_TRANS_CONN_SESS   = 'Tutte le connessioni devono essere nella stessa IB_Session';
  E_TransactionPaused = 'La Transazione è in pausa';
  E_ALLOCATED         = 'L''Istruzione è già stata allocata';
  E_NOT_ALLOCATED     = 'L''Istruzione non è ancora stata allocata';
  E_PREPARED          = 'L''Istruzione è già stata preparata';
  E_NOT_PREPARED      = 'L''Istruzione non è ancora stata preparata';
  E_FAILED_TO_PREPARE = 'L''Istruzione ha fallito nel preparare';
  E_OPENED            = 'L''Istruzione è già stata aperta';
  E_NOT_OPENED        = 'L''Istruzione non è ancora stata aperta';
  E_CANT_DELETE       = 'Il record corrente non è cancellabile';
  E_NO_CONNECTION     = 'L''Istruzione non deve avere associata una connessione';
  E_CONNECT_FAILED    = 'Impossibile aprire l''IB_Connection';
  E_NO_TRANSACTION    = 'L''Istruzione non deve avere associata una transazione';
  E_NO_ACTIVE_TRANS   = 'Non vi sono transazioni con cui eseguire';
  E_START_FAILED      = 'Impossibile far partire la transazione';
  E_SVRAUTOCMT_NOEXP = 'Le transazioni esplicite non sono consentite con ServerAutoCommit';
  E_Cannot_Activate   = 'Stato di transazione non valido. Impossibile attivarla';
  E_Transaction_Is_Active = 'La transazione ha cambiamenti non completati';
  E_Failed_To_Post_Datasets = 'Ho fallito nel salvare tutti i dataset';
  E_Failed_To_Cancel_Datasets = 'Ho fallito nell''annullare tutti i dataset';
  E_UpdateWrongTrn    = 'Non posso aggiuornare, %s non è controllata da %s';
  E_NO_BLANK_SQL      = 'Istruzioni SQL nulle non sono consentite';
  E_AT_END_OF_FILE    = 'Alla fine del file';
  E_AT_END_OF_CURSOR  = 'Alla fine del cursore';
  E_AT_END_OF_BUFFER  = 'Alla fine del buffer';
  E_AT_END_OF_DATASET = 'Alla fine del dataset';
  E_BAD_SQL_INF_LEN   = 'Inaspettata lunghezza in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Dati non validi ritornati da isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Non posso cambiare il nome del cursore mentre è attivo';
  E_REQUEST_LIVE_ACTIVE = 'Non posso cambiare RequestLive mentre è attivo';
  E_REQUEST_LIVE_READONLY = 'Non posso rendere RequestLive un Dataset sola lettura';
  E_CURSOR_UNI              = 'IB_CURSOR è unidirezionale';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Tipo di Colonna non supportata: %d';
  E_FIELDNO_NOT_FOUND         = 'FieldNo: %d non trovato';
  E_FIELDNAME_NOT_FOUND        = 'FieldName: %s non trovato';
  E_INVALID_FOCUS_RELATION_NO   = 'Relazione selezionata numero %d non valida';
  E_INVALID_FOCUS_RELATION_NAME = 'La Relazione selezionata %s non è valida';
  E_INVALID_QBE_IN              = 'IN( valore [ , valore ... ] ) errore di sintassi';
  E_INVALID_QBE_BETWEEN         = 'BETWEEN valore AND valore errore di sintassi';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Impossibile trovare la DLL da importare %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Proprietà SQLKeyFields non valida';
  E_GET_CURSOR_ERROR      = 'Non posso aprire un cursore senza dati sulla chiave';
  E_SCROLL_ERROR          = 'La chiave del record è stata persa'#10#13'L''apertura del cursore è fallita';
  E_INVALID_BUFFER_ROW_NUM = 'BufferRowNum non valido prima dell''inizio';
  E_BLANK_STATEMENT      = 'Non posso preparare un''istruzione vuota';
  E_UNKNOWN_STATEMENT  = 'Si è tentata di eseguire una istruzione non valida';
  E_CIRCULAR_REFERENCE = 'I riferimenti circolari non sono ammessi';
  E_CANT_CHG_WITH_CONN  = 'Non posso cambiare mentre sono connesso';
  E_LOGIN_FAILED        = 'Ho fallito effettuando il login';
  E_CANT_GET_CONN_CHR   = 'Non posso ricevere le caratteristiche della connessione';
  E_MAX_EVENTS_BLOCK   = 'Si è superato il massimo degli eventi per un blocco';
  E_PROCESSING_EVENTS = 'Sto processando l''evento'#13#10'non posso deregistrare';
  E_CANT_STORE_BLOB = 'Blob è già stato o non può essere memorizzato';
  E_CANT_LOAD_BLOB   = 'Blob è già stato o non può essere caricato';
  E_CANNOT_CANCEL_ROW = 'Non posso annullare la Colonna corrente';
  E_CANNOT_POST_ROW = 'Non posso salvare la Colonna corrente';
  E_DatasetClosed = 'Il dataset non è attivo';
  E_DatasetOpen      = 'Il dataset è aperto';
  E_DatasetCannotScroll = 'Il dataset non può essere navigato';
  E_DatasetReadOnly   = 'Il dataset è a sola lettura';
  E_DatasetIsFetching = 'Il Dataset sta caricando i record';
  E_Invalid_KeyRelation = 'Valore di KeyRelation non valido';
  E_RowNum_Not_Implemented = 'RowNum non è ancora implementata';
  E_RowDeleted = 'La colonna sta per essere cancellata';
  E_END_OF_DATASET = 'Alla fine del dataset';
  E_BEGINNING_OF_DATASET = 'All''inizio del Dataset';
  E_Cannot_Pessimistic_Lock = 'Non posso usare il "pessimistic locking" con LockWait';
  E_Cannot_Edit_Row = 'Non posso modificare la colonna corrente';
  E_Cannot_Insert_Row = 'Non posso inserire una nuova colonna';
  E_Cannot_Delete_Row = 'Non posso cancellare la colonna corrente';
  E_Cannot_Search = 'La ricerca non è consentita';
  E_Cannot_Navigate = 'Non posso navigaer';
  E_Record_Locked = 'Il Record è bloccato da un altro utente';
  E_Record_OutOfSynch = 'Il Record è stato cambiato da un altro utente';
  E_FLD_READONLY = '%s è a sola lettura';
  E_Required_Field = '%s è un campo richiesto';
  E_NO_POSTRTN_CACHED_UPDT = 'Non posso usare PostRetaining con i Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Più di una colonna in una selezione univoca';

  E_InvalidRowsAffectedBuf = 'buffer RowsAffected non valido';
  E_Invalid_RowNum_Past_Eof = 'RowNum non valido dopo la fine del set';
  E_Invalid_Bookmark = 'Stringa di Bookmark non valida';

  E_Assign_Column   = 'Non posso assegnare partendo da%s';
  E_AssignTo_Column = 'Non posso assegnare %s';
  E_Value_Out_Of_Range = 'Il valore è fuori scala';
  E_SmallintOverflow = 'Overflow di intero piccolo';

  E_Unsupported_Column = 'Tipo di colonna non supportata: %d';
  E_UndefinedMacro = 'Macro non definita';
  E_GeneratorFailed = 'Impossibile ottenere il valore del generatore';

  E_MustBe_Buffered_Dataset = 'Deve essere un discendente di TIB_BDataset (IB_Query)';

  E_NO_CHANGE_READONLY = 'Non posso cambiare ReadOnly quando è già partita';
  E_NO_CHANGE_ISOLATION = 'Non posso cambiare Isolation quando è già partita';
  E_NO_CHANGE_RECVERSION = 'Non posso cambiare RecVersion quando è già partita';
  E_NO_CHANGE_LOCKWAIT = 'Non posso cambiare LockWait quando è già partita';

  E_Invalid_Reference_To_Delete = 'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53bit integer overflow';
  E_Invalid_Typecast = 'CAST di tipo non valido';
  E_Invalid_DataPump_Statement = 'Tipo di istruzione non valida per il DataPump';
  E_FIELD_NOT_NULLABLE = 'campo NOT NULL impostato ad un valore nullo';
  E_DATABASE_BLANK = 'Il campo DatabaseName non può essere nullo';
  E_Unsupp_Col_Conversion = 'Conversione di colonna non supportata';
  E_Unable_To_Locate_Record = 'Impossibile trovare il record';
  E_Record_Not_Inserted = 'Il record non è stato inserito';
  E_Invalid_KeyLinks = 'Voce di KeyLinks non valido: %s';
  E_Unable_to_perform_search = 'Impossibile effettuare la ricerca';
  E_Unassigned_Blob_Node = 'BlobNode non assegnato ';
  E_Unassigned_Transaction = 'Transazione non assegnata';
  E_Invalid_RowsAffected_Buffer = 'buffer di RowsAffected non valido';
  E_Unable_Save_Graphic = 'Impossibile salvare la grafica';
  E_Cannot_Activate_Transaction = 'Non posso attivare la transazione';
  E_IB_Client_Not_Installed = 'Il Client Interbase GDS32.DLL non è installato';
  E_Could_Not_Load_Memo = 'Non ho potuto caricare il memo';
  E_Invalid_DPB_Over_255 = 'DPB Non valido: contiene più di 255 caratteri';
  E_Inv_Custom_DML = 'DML contiene un riferimento proprietario ad una colonna non valido: %s';
  E_Record_Not_Located_For_Update = 'Record non è stato trovato per la modifica';
  E_Record_Not_Located_For_Delete = 'Record non è stato trovato per la cancellazione';
  E_Init_Default_SQL_Failed = 'Non posso inizializzare il default %s';
  E_Stringlist_Not_Sorted = 'Le Stringlist devono essere ordinate per questa operazione';
  E_Cannot_Change_Events = 'Non posso cambiare gli eventi mentre processo';
  E_Cannot_Unregister_Events = 'Non posso deregistrare gli eventi mentre processo';
  E_Invalid_Internal_Transaction = 'IB_Transaction interna non valida';
  E_InvalidStatementType = 'Tipo di istruzione non valida';
  E_Multiple_Records_Updated = 'E'' stato modificato più di un Record ';
  E_Multiple_Records_Deleted = 'E'' stato cancellato più di un Record ';
  E_Multiple_Records_Inserted = 'E'' stato inserito più di un Record ';
  E_DUP_DB_NAME = 'Un DatabaseName duplicato non è consentito';
  E_INVALID_DB_NAME = 'DatabaseName non valido';
  E_UnableToSearch = 'Impossibile eseguire la ricerca';
  E_NoRecordsFound = 'Nessun record trovato';
  E_Session_Undefined = 'La sessione non è definita';
  E_NoCircularRef = 'Riferimenti circolari non ammessi';
  E_InvalidClassType = 'Tipo di classe non valdia';
  E_Invalid_RowNum = 'RowNum non valido';
  E_Invalid_Syntax = 'Sintassi non valida: manca o è in più una parentesi';
  E_Array_Is_Null = 'L''array è nullo';

  E_Cannot_add_blank_account = 'Non posso aggiungere un account nullo';
  E_Cannot_add_SYSDBA_account = 'Non posso aggiungere un account SYSDBA';
  E_Cannot_delete_blank_account = 'Non posso cancellare un account nullo';
  E_Cannot_delete_SYSDBA_account = 'Non posso cancellare un account SYSDBA';
  E_Cannot_modify_blank_account = 'Non posso modificare un account nullo';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';
  E_INV_CREATE_CONNECT_DROP = 'Sintassi non valida per CREATE, CONNECT o DROP DATABASE';
  E_Unsupported = 'Non supportato';
  E_NotImplemented = 'Non implementato in questo livello';
  E_Invalid_ColData = 'Dati Colonna non validi';
  E_Cant_Unprepare_executing_process = 'Non posso de-preparare un''istruzione in esecuzione';
  E_FileName_Required = 'Il nome dell''archivio è obbligatorio';

{ Labels for various default dialogs used in IBO }

//IBF_Users
  L_USERS_FRM = 'Gestione Dati Utenti';
  L_USERS_ADD = 'Aggiungi';
  L_USERS_DELETE = 'Elimina';
  L_USERS_MODIFIY = 'Modifica';
  L_USERS_ACCOUNT = 'Account';
  L_USERS_PASSWORD = 'Password';
  L_USERS_GROUP = 'Gruppo';
  L_USERS_FIRSTNAME = 'Nome';
  L_USERS_MIDDLENAME = 'Nome intermedio';
  L_USERS_LASTNAME = 'Cognome';

//IBF_Export
  L_EXPORT_FRM = 'Esporta';
  L_EXPORT_ASCII = ' Formato File ';
  L_EXPORT_FIXED = 'Record a lunghezza fissa';
  L_EXPORT_DELIMITED = 'Delimitato';
  L_EXPORT_DBF  = 'DBF';
  L_EXPORT_ASCIIOPT  = ' Opzioni ASCII ';
  L_EXPORT_DELIMITER  = 'Delimitatore';
  L_EXPORT_SEPARATOR  = 'Separatore';
  L_EXPORT_DATEFORMAT  = 'Formato Data';
  L_EXPORT_INCLUDECRLF  = 'Includi CRLF';
  L_EXPORT_INCLUDEHEADERS  = 'Includi le intestazioni';
  L_EXPORT_SDEXPORTTITLE = 'Esporta';
  L_EXPORT_SDEXPORTFILTERCSV = 'File Delimitati da Virgola ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'File di Testo ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'File DBF ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Sei sicuro che vuoi annullare il caricamento??';
  M_Fetching_Query_Results = 'Risultato del caricamento';
  M_Row_Num = 'Colonna# %d';
  M_Abort_Fetching_Btn = 'Annulla';

  M_Login_Database = 'Database';
  M_Login_User = 'Utente';
  M_Login_Password = 'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Annulla';
  M_Login_Help_Btn = '&Aiuto';
  M_Login_Dialog_Caption = 'Box di Dialogo di Accesso';

  M_Loading_Caption = 'Sto caricando...';

  M_SB_REC_CNT = 'Record contati : %d';
  M_Save_Changes = 'Salva i cambiamenti?';
  M_Abort_Changes = 'Le modifiche verranno perse. Continuo comunque?';

  M_CancelTransactionPrompt =
    'Sei sicuro di voler annullare tutti i cambiamenti?';

  M_SCRIPT_ABORT_EXECUTE = 'Interrompi l''esecuzione di questo script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Continui l''esecuzione di questo script?';
  M_SCRIPT_IS_EXECUTING = 'Lo script è in esecuzione';
  M_SCRIPT_FAILED = 'Lo script non è stato completato';
  M_SCRIPT_WAS_ABORTED = 'L''esecuzione dello script è stata annullata';
  M_SCRIPT_COMPLETED = 'Lo script è stato eseguito senza eccezioni';
  M_SCRIPT_CMPL_EXCEPT = 'Lo script è stato eseguito e si sono verificate eccezioni';
  M_SCRIPT_MODIFIED = 'Modificato';
  M_SCRIPT_SAVE_CHANGES = 'Vuoi salvare le modifiche?';

{ Button captions }

  C_BTN_TODAY = 'Oggi';
  C_BTN_CLEAR = 'Ripulisci';

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
  M_SQL_ReConfirmDBDrop = 'Questo database verrà eliminato definitivamente.\n'#13#10'\rContinuo comunque?';
  M_SQL_AskFormName = 'Inserisci il nome della query:';
  M_SQL_AskGroupName = 'Inserisci il nome del gruppo:';
  M_SQL_AskLayoutName = 'Inserisci il nome del layout:';
  M_SQL_ConfirmGroupDeletion = 'Sei sicuro di voler cancellare il gruppo %s e tutti gli elementi che contiene?';
  M_SQL_ConfirmLayoutDeletion = 'Sei sicuro di voler cancellare il layout %s?';
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
  C_BTN_USERS_CLEAR = 'Clear';
  M_USERS_COMPLETED_OK = 'Operazione completata con Successo';
  M_USERS_NO_CONNECTION = 'Non è definita nessuna IB_Connection.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Assegno anche gli ''ordering items''?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Inizia Export';
  M_EXPORT_STILL_ACTIVE = 'Il processo di esportazione è ancora attivo.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Esplora il Database';
  C_wbBrowseBtnCaption  = 'Esplora';
  C_wbDSQLBtnHint       = 'Esegue un''istruzione nel database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitora gli eventi del database';
  C_wbEventsBtnCaption  = 'Eventi';
  C_wbExportBtnHint     = 'Esporta un set di dati dal database';
  C_wbExportBtnCaption  = 'Esporta';
  C_wbDumpBtnHint       = 'Lista il database';
  C_wbDumpBtnCaption    = 'Lista';
  C_wbPumpBtnHint       = 'Pompa i dati da un altro database';
  C_wbPumpBtnCaption    = 'Pompa';
  C_wbWhoBtnHint        = 'Guarda chi è connesso al database';
  C_wbWhoBtnCaption     = 'Chi';
  C_wbScriptBtnHint     = 'Esegue lo script';
  C_wbScriptBtnCaption  = 'Script';
  C_wbExtractBtnHint    = 'Estrazione DDL';
  C_wbExtractBtnCaption = 'Estrai';
  C_wbMonitorBtnHint    = 'Traccia le chiamate SQL ed alle API';
  C_wbMonitorBtnCaption = 'Traccia';
  C_wbProfilerBtnHint   = 'Esamina l''attività del database';
  C_wbProfilerBtnCaption= 'Profiler';
  C_wbStatusBtnHint     = 'Mostra stato dei componenti IBO';
  C_wbStatusBtnCaption  = 'Stato';
  C_wbUsersBtnHint      = 'Amministra gli utenti per un server di database';
  C_wbUsersBtnCaption   = 'Utenti';

  // Array grid
  C_AG_Row             = 'Riga';
  C_AG_Column          = 'Colonna';

  //IBF_Who
  C_WHO_FRM            = 'Chi è connesso';
  C_WHO_BTNAPPLY       = 'Aggiorna';

  C_NB_FIRST = 'Primo record';
  C_NB_PRIOR = 'record precedente';
  C_NB_NEXT = 'Prossimo record';
  C_NB_LAST = 'Ultimo record';

  C_ST_Open = 'Apri';
  C_ST_Close = 'Chiudi';
  C_ST_Prepare = 'Prepara';
  C_ST_Unprepare = 'De-prepara';
  C_ST_ReadOnly = 'Sola Lettura';
  C_ST_New = 'Nuovo';
  C_ST_Post = 'Conferma';
  C_ST_Cancel = 'Annulla';
  C_ST_Delete = 'Elimina';
  C_ST_Edit = 'Modifica';
  C_ST_RefreshKeys = 'Rinfresca chiavi';
  C_ST_RefreshRows = 'Rinfresca righe';
  C_ST_Refresh = 'Rinfresca';

{ Hints }

  H_UB_EDIT = 'Modifica il record';
  H_UB_INSERT = 'Inserisce un record';
  H_UB_DELETE = 'Cancella il record';
  H_UB_REFRESH = 'Rinfresca tutti i record';
  H_UB_REFRESHKEYS = 'Rinfresca tutte le chiavi';
  H_UB_REFRESHROWS = 'Rinfresca tutte le colonne dei record';
  H_UB_REFRESHFILTROWS = 'Rinfresca i record filtrati';
  H_UB_POSTSEARCH = 'Salva il criterio di ricerca';
  H_UB_CANCELSEARCH = 'Annulla il criterio di ricerca';
  H_UB_POSTEDIT = 'Salva le modifiche';
  H_UB_CANCELEDIT = 'Annulla le modifiche';
  H_UB_POSTINSERT = 'Salva gli inserimenti';
  H_UB_CANCELINSERT = 'Annulla gli inserimenti';
  H_UB_POSTDELETE = 'Salva la cancellazione';
  H_UB_CANCELDELETE = 'Annulla la cancellazione';
  H_UB_POST = 'Salva le modifiche';
  H_UB_CANCEL = 'Annulla le modifiche';

  H_NB_FIRST = 'Primo Record';
  H_NB_PRIOR = 'Record Precedente';
  H_NB_NEXT = 'Record Successivo';
  H_NB_LAST = 'Ultimo Record';
  H_NB_JUMPBCK = 'Indietro';
  H_NB_JUMPFWD = 'Avanti';

  H_SB_ORDER = 'Ordina le colonne';
  H_SB_LAST_CRITERIA = 'Richiama l''ultimo criterio di ricerca';
  H_SB_SEARCH = 'Ricerca nell''archivio';
  H_SB_SAVE_CRITERIA = 'Salva il criterio di ricerca';
  H_SB_CLEAR_CRITERIA = 'Pulisci i campi';
  H_SB_RECALL_CRITERIA = 'Richiama il criterio di ricerca';
  H_SB_SEARCHCOUNT = 'Conta il numero di record che corrispondono al criterio di ricerca';
  H_SB_COUNT = 'Conta i record nell''archivio';

  H_TB_StartTransaction = 'Inizia una transazione';
  H_TB_PostDatasets = 'Memorizza le modifiche agli archivi';
  H_TB_CancelDatasets = 'Annulla le modifiche agli archivi';
  H_TB_SavePoint = 'Scarica le modifiche mantenendo la transazione corrente';
  H_TB_CommitRetain = 'Memorizza e Scarica le modifiche mantenedo la transazione corrente';
  H_TB_Commit = 'Scarica le modifiche chiudendo la transazione corrente';
  H_TB_Rollback = 'Annulla le modifiche chiudendo la transazione corrente';
  H_TB_RollbackRetain = 'Annulla le modifiche mantenedo la transazione corrente';
  H_TB_Close = 'Chiude la transazione corrente';

  H_ST_Prepare_Statement = 'Prepara l''istruzione';
  H_ST_Unprepare_Statement = 'De-prepara l''istruzione';
  H_ST_Execute_Statement = 'Esegue l''istruzione';

  H_DS_Open_Dataset = 'Apre il dataset';
  H_DS_Close_Dataset = 'Chiude il dataset';
  H_DS_Prepare_Dataset = 'Prepara il dataset';
  H_DS_Unprepare_Dataset = 'De-prepara il dataset';
  H_DS_ReadOnly_Dataset = 'Dataset a sola lettura';

  H_CB_Create_Database = 'Crea nuovo database';
  H_CB_Connect_Database = 'Connessione al database';
  H_CB_Disconnect_Database = 'Disconnessione dal database';
  H_CB_Drop_Database = 'Elimina il database';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Esporta dall''istruzione SQL';

	// Error Messages - IB_Import

  eNoAsciiFileEnty           = 'Manca la voce per il file Ascii';
	eNoDestTableEntry          = 'manca la voce per la tabella di destinazione';
	eAsciiFileNotFound         = 'Il file ASCII %s non è stato trovato';
	eIniFileNotFound           = 'Il File Ini %s non è stato trovato';
	eNoAsciiFileAccess         = 'Non posso aprire il file ascii %s';
	eInvalidCharFound          = 'Carattere non valido / Errore di formato nel file ascii';
	eOutOfMemory               = 'Memoria esaurita';
	eFieldDescriptionError     = 'Errore nella descrizione del campo';
	eWrongAsciiFieldCount      = 'Numero di campi errato nel file ascii';
	eWrongDecimalCount         = 'Numero di decimali errato nella lista dei campi (%s)';
  eWrongFieldWidth           = 'Larghezza del campo errata nel file ascii';

  // Dialog Labels - IB_Import

  lblRecsReadedCaption       = 'Totale Record Letti';
  lblRecsCommentedCaption    = 'Record Commentati';
  lblRecsInsertedCaption     = 'Record inseriti';
  btnAbortImportCaption      = 'Interrompi';

implementation

end.
