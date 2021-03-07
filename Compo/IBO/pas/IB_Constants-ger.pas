// GK 25.02.2001
//NEU:  IB_STRING10R   = 'STRING10R';  wird in IB_Parse geprüft und in u_DataFunc zugewiesen
//      IB_NOTCOPY     = 'NOTCOPY';    Feld darf über eigene IB_ActionCopy nicht kopiert werden

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
{ Translated by: Martin Schmid <M.Schmid@EQUITANIA.de>                         }
{ additions by: Andreas Filsinger * andreas@filsinger.de * www.CargoBay.de     }
{ additions by: Jörg Schiemann <joerg@schiemann.nu>                            }
{ additions by: Mario Zimmermann <mail@zisoft.de>
{ additions by: Ralf Zimmerningkat <rz@hlsv.de>                                }
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
  // Gerd Kroll Anfang eingefügt
  IB_STRING10R   = 'STRING10R';  // GK 25.02.2001 wird in IB_Parse geprüft und in u_DataFunc zugewiesen
  IB_NOTCOPY     = 'NOTCOPY';    // GK 10.07.2001 Feld darf über IB_ActionCopy nicht kopiert werden
  // GK Ende eingefügt

// This is a flag that I am using to indicate when a bug in InterBase is fixed
// so that a more optimal set of calls can be used.
  BUG_EXEC2 = true;

// Version information
  IB_VERSION_MAJOR = '4';
  IB_VERSION_MINOR = '2';
  IB_VERSION_BUILD = 'I';
  IB_VERSION_SUB_RELEASE = 'b';

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
  IB_ISC_ERR_CODE_MSG = 'ISC Fehlernummer:';  //'ISC ERROR CODE:';
  IB_ISC_ERR_MSG_MSG  = 'ISC Fehlermeldung:'; //'ISC ERROR MESSAGE:';
  IB_SQL_ERR_CODE_MSG = 'SQL Fehlernummer:';  //'SQL ERROR CODE:';
  IB_SQL_ERR_MSG_MSG  = 'SQL Fehlermeldung:'; //'SQL ERROR MESSAGE:';

// Global Defaults  
  G_DefaultRowHeight  = 17;

  // Original von Jason
  {DTEncode_DateDelimit     = '/';
  DTEncode_TimeDelimit     = ':';
  DTEncode_DateTimeDelimit = ' ';
  DTEncode_DecodeFormat    = '%.4u/%.2u/%.2u %.2u:%.2u:%.2u.%.3u0';
  DTEncode_DateTimeFormat  = 'YYYY"/"MM"/"DD" "HH":"MM":"SS".0000"';
  DT_DateFormat            = 'MM"/"dd"/"yyyy';
  DT_TimeFormat            = 'hh":"nn":"ss'; }

  // Gerd Kroll 30.11.2001
  DTEncode_DateDelimit     = '.';
  DTEncode_TimeDelimit     = ':';
  DTEncode_DateTimeDelimit = ' ';
  DTEncode_DecodeFormat    = '%.2u.%.2u.%.4u %.2u:%.2u:%.2u.%.3u0';
  DTEncode_DateTimeFormat  = 'dd"."mm"."YYYY" "HH":"NN":"SS".0000"';
  DT_DateFormat            = 'dd"."mm"."yyyy';
  DT_TimeFormat            = 'hh":"nn":"ss';



{ These may be localized. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'Danke für Ihr Interesse an IB Objects.'#10#13#10#13 +
                   'Bitte besuchen Sie http://www.ibobjects.com noch Heute und lassen sich registrieren.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED = 'Verbindung besteht bereits'; //'Connection has already been established';
  E_NOT_CONNECTED = 'Es besteht keine Verbindung'; //'Connection has not been established';
  E_Invalid_conn_path = 'Ungültiger Verbindungs Pfad';//'Invalid connection path';
  E_Cant_Repl_Int_Tr  = 'Interne Transaktion kann nicht als Standard eingesetzt werden'; //'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED = 'Es wurde keine Transaktion gestartet'; //'Transaction has not been started';
  E_TRANS_STARTED = 'Transaktion wurde bereits gestartet'; //'Transaction has already been started';
  E_NO_CONNECTIONS = 'Transaktion hat keine Verbindung'; //'Transaction has no connections';
  E_NOT_ENOUGH_CONN = 'Der Transaktion fehlt mindestens eine Verbindung'; //'Transaction is missing one or more connections';
  E_CONN_LOADING = 'Warnung: Verbindung wird noch aufgebaut'; //'Warning: Connection is still loading';
  E_TRANS_CONN_SESS = 'Verbindungen müssen zur selben IB_Session gehören'; //'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Transaktion pausiert';//'Transaction is Paused';
  E_ALLOCATED = 'Statement wurde bereits zugewiesen'; //'Statement has already been allocated';
  E_NOT_ALLOCATED = 'Statement wurde noch nicht zugewiesen'; //'Statement has not been allocated';
  E_PREPARED = 'Statement wurde bereits vorbereitet'; //'Statement has already been prepared';
  E_NOT_PREPARED = 'Statement wurde noch nicht vorbereitet'; //'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Vorbereitung des Statements gescheitert'; //'Statement failed to prepare';
  E_OPENED = 'Statement ist bereits geöffnet'; //'Statement has already been opened';
  E_NOT_OPENED = 'Statement wurde noch nicht geöffnet'; //'Statement has not been opened';
  E_CANT_DELETE = 'Aktueller Datensatz kann nicht gelöscht werden'; //'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION = 'Dem Statement muss eine IB_Connection zugewiesen werden'; //'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED = 'IB_Connection konnte nicht geöffnet werden'; //'Unable to open IB_Connection';
  E_NO_TRANSACTION = 'Dem Statement muss eine IB_Transaction zugewiesen werden'; //'Statement must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS = 'Keine aktive Transaktion zur Ausführung'; //'No active transaction to execute with';
  E_START_FAILED = 'Transaktion konnte nicht gestartet werden'; //'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP = 'Die explizite Transaktion ist nicht in Verbindung mit ServerAutoCommit erlaubt'; //'Explicit transaction not allowed with ServerAutoCommit';
  E_Cannot_Activate   = 'Ungültiger Transaktionsstatus kann nicht aktiviert werden'; //'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transaktion beinhaltet Änderungen'; //'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Fehlgeschlagenes Speichern bei allen Datensätzen'; //'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Fehlgeschlagenes Verwerfen bei allen Datensätzen'; //'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Kann nicht ersetzen, %s wird von %s gesperrt'; //'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL = 'Leeres SQL-Statement nicht erlaubt'; //'Blank SQL statement not allowed';
  E_AT_END_OF_FILE = 'Am Dateiende'; //'At end of file';
  E_AT_END_OF_CURSOR = 'Am Ende des Cursors'; //'At end of cursor';
  E_AT_END_OF_BUFFER = 'Am Ende des Puffers'; //'At end of buffer';
  E_AT_END_OF_DATASET = 'Am Ende der Datenmenge'; //'At end of dataset';
  E_BAD_SQL_INF_LEN = 'Unvorgesehene Länge in isc_dsql_sql_info'; //'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA = 'Ungültige Daten wurden zurückgegeben von isc_dsql_sql_info'; //'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK = 'Der Name eines aktiven Cursors kann nicht geändert werden'; //'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'RequestLive kann im aktiven Zustand nicht geändert werden '; //'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'RequestLive kann nicht in einer Nur-Lesen-Datenmenge benutzt werden '; //'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI = 'IB_Cursor ist unidirektional'; //'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE = 'Nicht unterstützter Spaltentyp: %d'; //'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND = 'Feldnummer: %d nicht gefunden'; //'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND = 'Feldname: %s nicht gefunden'; //'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO = 'Ungültige fokussierte Relations-Nr.: %d'; //'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Ungültiger fokussierter Relations-Name: %s'; //'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN = 'IN( wert [ , wert ... ] ) Syntax-Fehler'; //'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN = 'BETWEEN wert AND wert Syntax-Fehler'; //'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'DLL-Import %s nicht gefunden'; //'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS = 'Ungültige SQLKeyFields-Eigenschaft'; //'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR = 'Cursor kann nicht ohne Schlüssel-Daten geöffnet werden'; //'Cannot open cursor without key data';
  E_SCROLL_ERROR = 'Satzschlüssel verloren'#13#10'Fehler beim Öffnen des Cursors'; //'Record key was lost'#10#13'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Ungültige Puffer-Zeilennummer vor dem Beginn'; //'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT = 'Kann kein leeres Statement vorbereiten'; //'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT = 'Versuch ein unbekanntes Statement auszuführen'; //'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Zirkelbezug nicht erlaubt'; //'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = 'Kann bei bestehender Verbindung nicht verändert werden'; //'Cannot change while connected';
  E_LOGIN_FAILED = 'Login gescheitert'; //'Login failed';
  E_CANT_GET_CONN_CHR = 'Keine Verbindungs-Eigenschaften verfügbar'; //'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK = 'Maximale Ereignisanzahl für einen Block überschritten'; //'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Ereignisse werden verarbeitet'#13#10'Freigabe nicht möglich'; //'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB = 'Blob ist schon gespeichert worden oder konnte nicht gespeichert werden'; //'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB = 'Blob wurde bereits geladen oder konnte nicht geladen werden'; //'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Aktueller Datensatz kann nicht abgebrochen werden'; //'Cannot cancel current Row';
  E_CANNOT_POST_ROW = 'Aktueller Datensatz kann nicht gespeichert werden'; //'Cannot Post current Row';
  E_DatasetClosed = 'Datenmenge ist nicht aktiv'; //'Dataset is inactive';
  E_DatasetOpen = 'Datenmenge ist momentan geöffnet';  //'Dataset is currently open';
  E_DatasetCannotScroll = 'Datenmenge kann nicht gescrollt werden'; //'Dataset cannot scroll';
  E_DatasetReadOnly = 'Datenmenge ist schreibgeschützt'; //'Dataset is readonly';
  E_DatasetIsFetching = 'Datenmenge wird gerade aufgebaut'; //'Dataset is currently fetching';
  E_Invalid_KeyRelation = 'Ungültige Wert der Schlüssel-Verbindung'; //'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'ZeilenNummer (RowNum) ist noch nicht implementiert'; //'RowNum is not implemented yet';
  E_RowDeleted = 'Datensatz wird gerade gelöscht'; //'Row is being deleted';
  E_END_OF_DATASET = 'Am Ende der Datenmenge'; //'At end of Dataset';
  E_BEGINNING_OF_DATASET = 'Am Anfang der Datenmenge'; //'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Pessimistische Sperre kann nicht mit LockWait genutzt werden'; //'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row = 'Aktueller Datensatz kann nicht bearbeitet werden'; //'Cannot Edit current Row';
  E_Cannot_Insert_Row = 'Eine neuer Datensatz kann nicht eingefügt werden'; //'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Aktueller Datensatz kann nicht gelöscht werden'; //'Cannot delete current Row';
  E_Cannot_Search = 'Suche ist nicht erlaubt'; //'Searching is not allowed';
  E_Cannot_Navigate = 'Navigieren nicht möglich'; //'Cannot navigate';
  E_Record_Locked = 'Datensatz ist durch einen anderen Benutzer gesperrt'; //'Record is locked by another user';
  E_Record_OutOfSynch = 'Datensatz wurde durch einen anderen Benutzer verändert'; //'Record was changed by another user';
  E_FLD_READONLY = '%s ist schreibgeschützt'; //'%s is readonly';
  E_Required_Field = '%s ist ein erforderliches Feld'; //'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'PostRetaining kann nicht mit Cached Updates genutzt werden'; //'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Mehrere Zeilen beziehen sich auf eine einzelne Abfrage';//'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Ungültiger Puffer für betroffene Datensätze'; //'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Ungültige Zeilennummer nach Dateiende'; //'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Ungültige Zeilennummer vor Dateianfang'; //'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Ungültiges Lesezeichen'; // 'Invalid Bookmark String';

  E_Assign_Column = 'Kann nicht zugewiesen werden von %s'; //'Cannot assign from %s';
  E_AssignTo_Column = 'Kann nicht zuweisen zu %s'; //'Cannot assign to %s';
  E_Value_Out_Of_Range = 'Wert liegt ausserhalb des gültigen Bereiches'; //'Value out of range';
  E_SmallintOverflow = 'SmallInt Überlauf'; //'Smallint overflow';
  // Gerd Kroll
  E_IntegerOverflow = 'Integer Überlauf'; //'Integer overflow';
  E_Int64Overflow = 'Int64 Überlauf'; //'Int64 overflow';

  E_Unsupported_Column = 'Nicht unterstützer Spaltentyp: %d'; //'Unsupported Column type: %d';
  E_UndefinedMacro = 'Nicht definiertes Makro'; //'Undefined macro';
  E_GeneratorFailed = 'Kein Generator-Wert verfügbar'; //'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'Muss von TIB_Dataset abstammen (IB_Query)'; //'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Schreibschutz kann nach dem Start nicht geändert werden'; //'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Isolation kann nach dem Start nicht geändert werden'; //'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'RecVersion kann nach dem Start nicht geändert werden'; //'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'LockWait kann nach dem Start nicht geändert werden'; //'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Ungültiger Referenzwert, Löschen unmöglich'; // 'Invalid reference to Delete'
  E_53BIT_OVERFLOW = '53bit Integer Überlauf'; //'53bit integer overflow';
  E_Invalid_Typecast = 'Ungültige Typumwandlung'; //'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Ungültiges Statement für DataPump'; //'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL Feld ist mit einem NULL-Wert gesetzt'; //'NOT NULL field set to null value';
  E_DATABASE_BLANK = 'DatabaseName darf nicht leer sein'; //'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Nicht unterstütze Spalten-Konvertierung'; //'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Datensatz nicht gefunden'; //'Unable To Locate Record';
  E_Record_Not_Inserted = 'Datensatz wurde nicht eingefügt'; //'Record was not inserted';
  E_Invalid_KeyLinks = 'Ungültiger KeyLinks-Eintrag: %s'; //'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Suche kann nicht durchgeführt werden'; //'Unable to perform search';
  E_Unassigned_Blob_Node = 'Nicht zugewiesener Blob-Knoten'; //'Unassigned BlobNode';
  E_Unassigned_Transaction = 'Nicht zugewiesene Transaktion'; //'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Ungültiger Puffer für betroffene Datensätze'; //'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Grafik konnte nicht gespeichert werden'; //'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Transaktion konnten nicht aktiviert werden'; //'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'Interbase GDS32.DLL ist nicht installiert'; //'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Konnte Memo nicht laden'; //'Could not load memo';
  E_Invalid_DPB_Over_255 = 'Ungültige DPB: Enthält mehr als 255 Zeichen'; //'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Ungültige DML Spaltenreferenz: %s '; //'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Datensatz wurde zum Aktualisieren nicht gefunden'; //'Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Datensatz wurde zum Löschen nicht gefunden'; //'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'Initialisierung des Vorgabe-Wertes nicht möglich: %s'; //'Unable to initilize default %s';
  E_Stringlist_Not_Sorted = 'Stringliste muss für diese Operation sortiert sein'; //'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Ereignisse können während der Ausführung nicht geändert werden'; //'Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Ereignisse können während der Ausführung nicht freigegeben werden'; //'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Ungültige interne Transaktion'; //'Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Ungültiger Statement-Typ'; //'Invalid statement type';
  E_Multiple_Records_Updated = 'Mehrere Datesätze aktualisiert'; //'Multiple records updated';
  E_Multiple_Records_Deleted = 'Mehrere Datensätze gelöscht'; //'Multiple records deleted';
  E_Multiple_Records_Inserted = 'Mehrere Datensätze eingefügt'; //'Multiple records inserted';
  E_DUP_DB_NAME = 'Doppelter DatabaseName nicht erlaubt'; //'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Ungültiger DatabaseName'; //'Invalid DatabaseName';
  E_UnableToSearch = 'Suche kann nicht durchgeführt werden'; //'Unable to perform search';
  E_UnableToSearch_NoOrdering = 'Suche kann nicht optimiert werden, da keine Sortierung definiert wurde'; //'Unable to perform search, no ordering defined';
  E_UnableToSearch_DatasetBusy = 'Suche kann nicht optimiert werden, da auf den Datensatz zugegriffen wird'; //'Unable to perform search, dataset is busy fetching data';
  E_NoRecordsFound = 'Keine Datensätze gefunden'; //'No records found';
  E_Session_Undefined = 'Session ist nicht definiert'; //'Session is undefined';
  E_NoCircularRef = 'Zirkelbezug nicht erlaubt'; //'Circular reference not allowed';
  E_InvalidClassType = 'Ungültiger Klassentyp'; //'Invalid class type';
  E_Invalid_RowNum = 'Ungültige Zeilennummer'; //'Invalid RowNum';
  E_Invalid_Syntax = 'Ungültige Syntax: Zuviele oder zuwenige Klammern'; //'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Array ist Null'; //'Array is Null';

  E_Cannot_add_blank_account = 'Ein leeres Konto kann nicht hinzugefügt werden'; //'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'Das Konto SYSDBA kann nicht hinzugefügt werden'; //'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Ein leeres Konto kann nicht gelöscht werden'; //'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'Das Konto SYSDBA kann nicht gelöscht werden'; //'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Ein leeres Konto kann nicht verändert werden'; //'Cannot modify blank account';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Ungültige CREATE, CONNECT oder DROP DATABASE Eingabe'; //'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Wird nicht unterstützt'; //'Unsupported';
  E_NotImplemented = 'Ist in dieser Stufe nicht implementiert'; //'Not implemented at this level';
  E_Invalid_ColData = 'Ungültige Zeilendaten'; //'Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Ein ausgeführter Prozess kann zurückgesetzt werden'; //'Cannot Unprepare an executing process';
  E_FileName_Required = 'Dateiname wird benötigt'; //'Filename is required';

  { Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Benutzerverwaltung'; //'User Account Management';
  L_USERS_ADD = 'Hinzufügen'; //'Add';
  L_USERS_DELETE = 'Löschen'; //'Delete';
  L_USERS_MODIFIY = 'Ändern'; //'Modify';
  L_USERS_ACCOUNT = 'ACCOUNT';//'ACCOUNT';
  L_USERS_PASSWORD = 'Passwort'; //'Password';
  L_USERS_GROUP = 'Gruppe'; //'Group';
  L_USERS_FIRSTNAME = 'Vorname'; //'First Name';
  L_USERS_MIDDLENAME = '2. Vorname'; //'Middle Name';
  L_USERS_LASTNAME = 'Nachname'; //'Last Name'

  //IBF_Export
  L_EXPORT_FRM = 'Exportieren'; // 'Export';
  L_EXPORT_ASCII = ' Datei Format '; // ' File Format ';
  L_EXPORT_FIXED = 'Feste Datensatzlänge'; // 'Fixed Record Length';
  L_EXPORT_DELIMITED = 'Mit Trennzeichen'; // 'Delimeted';
  L_EXPORT_DBF  = 'dBase Format'; // 'DBF';
  L_EXPORT_ASCIIOPT  = ' ASCII Optionen '; // ' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Textbegrenzungszeichen'; // 'Delimiter';
  L_EXPORT_SEPARATOR  = 'Feldtrennzeichen'; // 'Separator';
  L_EXPORT_DATEFORMAT  = 'Datumsformat'; // 'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Feldnamen einbeziehen'; // 'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'mit <CR><LF>'; // 'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Exportieren'; // 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Komma separierte Textdateien ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Textdateien ( *.TXT )|*.TXT'; // 'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'dBase Dateien ( *.DBF )|*.DBF'; // 'DBF Files ( *.DBF )|*.DBF';

  { Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Wollen Sie wirklich abbrechen?'; //'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Ermittle Abfrage-Resultate'; //'Fetching Query Results';
  M_Row_Num = 'Zeilennummer: %d'; //'Row# %d';
  M_Abort_Fetching_Btn = 'Abbruch'; //'Abort';

  M_Login_Database = 'Datenbank'; //'Database';
  M_Login_User = 'Benutzer'; //'User';
  M_Login_Password = 'Passwort'; //'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Abbruch'; //'Cancel';
  M_Login_Help_Btn = '&Hilfe';
  M_Login_Dialog_Caption = 'Datenbank Anmeldung'; //'Login Dialog';

  M_Loading_Caption = 'Lade...'; //'Loading...';

  M_SB_REC_CNT = 'Datensätze gezählt: %d'; //'Records counted: %d';
  M_Save_Changes = 'Änderungen speichern?'; //'Save changes?';
  M_Abort_Changes = 'Änderungen verwerfen?'; // 'Changes will be lost. Ok to proceed?'

  M_CancelTransactionPrompt = 'Wollen Sie wirklich alle Änderungen verwerfen?';//'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'Ausführungsabbruch dieses Skriptes?'; //'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Ausführung des Skriptes fortführen?'; //'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Skript wird derzeit ausgeführt'; //'Script is currently executing';
  M_SCRIPT_FAILED = 'Skriptausführung ist fehlgeschlagen'; //'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Skriptausführung wurde abgebrochen'; //'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Skript wurde ohne Probleme ausgeführt'; //'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Skript wurde mit Ausnahmen ausgeführt'; //'Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'Geändert';//'Modified';
  M_SCRIPT_SAVE_CHANGES = 'Änderungen speichern?';//'Save changes?';

{ Button captions }

  C_BTN_TODAY = 'Heute'; //'Today';
  C_BTN_CLEAR = 'Leeren'; //'Clear';
  C_BTN_FIND = 'Finde';//'Find';
  C_BTN_FINDNEXT = 'Finde nächstes';//'Find Next';
  C_BTN_REPLACE = 'Ersetze';//'Replace';
  C_BTN_UNDO = 'Wiederherstellen';//'Undo';
  C_BTN_CUT = 'Ausschneiden';//'Cut';
  C_BTN_COPY = 'Kopieren';//'Copy';
  C_BTN_PASTE = 'Einfügen';//'Paste';
  C_BTN_DELETE = 'Löschen';//'Delete';
  C_BTN_SELECTALL = 'Alles markieren';//'Select All';


  C_SG_Parameter = 'Parameter';
  C_SG_Field = 'Feld'; // 'Field';
  C_SG_Name = 'Name';
  C_SG_Type = 'Typ'; // 'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'Wert'; // 'Value';

  C_BF_OK = 'Ok';
  C_BF_CANCEL = 'Abbrechen'; // 'Cancel';
  C_BF_CANCEL_ACCEL = '&Abbrechen';
  C_BF_APPLY = 'Übernehmen'; //'Apply';
  C_BF_HELP = 'Hilfe'; // 'Help';
  C_BF_EXECUTE = 'Ausführen'; //'Execute';
  C_BF_CLOSE = 'Schließen';
  C_BF_CLOSE_ACCEL = '&Schließen';
  C_BF_FINISH = 'Ende';
  C_BF_FINISH_ACCEL = '&Ende';

  C_FRM_Ordering = 'Sortierung';//'Ordering';
  // Anfang Gerd Kroll GK 05.03.2002
  C_FRM_RESTRUCTURE = 'Einstellung Felddarstellung';
  // Ende Gerd Kroll GK 05.03.2002

  C_CB_WordWrap = 'Zeilenumbruch'; //'Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'Betroffene Zeilen: ';
  M_SQL_RowsCounted = 'Anzahl Zeilen: ';
  M_SQL_SessionBusy = 'Session ist momentan beschäftigt';
  M_SQL_CompleteTransaction = 'Bitte schließen Sie die Transaktion ab';
  M_SQL_CannotDeleteDefaultGroup = 'Die Vorgabegruppe kann nicht gelöscht werden';
  M_SQL_ReservedName = 'Reservierter Name: ';
  M_SQL_BackSlashNotAllowed = 'Ein Backslash ist nicht erlaubt';
  M_SQL_BlankNameNotAllowed = 'Ein leerer Name ist nicht erlaubt';
  M_SQL_RowsFetched = 'Geladene Zeilen: ';
  M_SQL_ConfirmDBCreation = 'Soll die Datenbank angelegt werden?';
  M_SQL_ConfirmNoOtherDBSameName = 'Bitte stellen Sie sicher, dass keine Datenbank mit diesem Namen existiert'; // 'Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = 'Soll diese Datenbank gelöscht werden?'; // 'Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = 'Die Datenbank wird unwiderruflich gelöscht.'+#13#10+'Sind Sie sicher?'; // 'This database will be permanently removed.'+#13#10+#13#10'Continue anyway?';
  M_SQL_AskFormName = 'Name des Abfrageformulars:'; // 'Enter query form name:';
  M_SQL_AskGroupName = 'Gruppenname:'; // 'Enter group name:';
  M_SQL_AskLayoutName = 'Layout-Name:'; // 'Enter layout name:';
  M_SQL_ConfirmGroupDeletion = 'Soll die Gruppe %s einschließlich aller Eigenschaften gelöscht werden?'; // 'Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = 'Soll das Layout %s gelöscht werden?'; // 'Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = 'Rekursive Kopie nicht erlaubt'; // 'Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Doppelklicken Sie auf ein Objekt oder markieren Sie es und drücken Enter'; // 'Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'Parameter Wert'; // 'Parameter value';
  M_GCSQL_TypeAValueFor = 'Geben Sie für %s einen Wert an'; // 'Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = 'Diese Prozedur hat keine Eingabeparameter'; // 'This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Datenübernahme ist noch aktiv'; // 'Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'Sind Sie sicher?'; // 'Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Wählen Sie die Quelldatenbank'; // 'Select Source Database';
  M_DP_SELECT_DEST_DB = 'Wählen Sie die Zieldatenbank'; // 'Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Leeren'; //'Clear';
  M_USERS_COMPLETED_OK = 'Vorgang erfolgreich abgeschlossen'; // 'Operation completed Successfully';
  M_USERS_NO_CONNECTION = 'Keine Verbindung definiert'; // 'No IB_Connection defined.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Sortierobjekte zuweisen?'; // 'Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Export starten'; // 'Begin Export';
  M_EXPORT_STILL_ACTIVE = 'Exportvorgang ist noch aktiv'; // 'Export process is still active.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'In Datenbank blättern'; //'Browse Database';
  C_wbBrowseBtnCaption  = 'Blättern'; //'Browse';
  C_wbDSQLBtnHint       = 'Anweisung in Datenbank ausführen'; //'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Datenbank Ereignisse anzeigen'; //'Monitor Database Events';
  C_wbEventsBtnCaption  = 'Ereignisse'; //'Events';
  C_wbExportBtnHint     = 'Exportiert eine Datenmenge aus der Datenbank'; //'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Exportieren'; //'Export';
  C_wbDumpBtnHint       = 'Daten tabellenweise aus Datenbank exportieren'; //'Dump Database';
  C_wbDumpBtnCaption    = 'Ausspielen'; //'Dump';
  C_wbPumpBtnHint       = 'Daten von einer anderen Datenbank einspielen'; //'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Einspielen'; //'Pump';
  C_wbWhoBtnHint        = 'Anzeigen wer mit der Datenbank verbunden ist'; //'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Wer'; //'Who';
  C_wbScriptBtnHint     = 'Skripte ausführen'; //'Execute Script';
  C_wbScriptBtnCaption  = 'Skripte'; //'Script';
  C_wbExtractBtnHint    = 'DLL extrahieren'; //'Extract DDL';
  C_wbExtractBtnCaption = 'Extrahieren'; //'Extract';
  C_wbMonitorBtnHint    = 'SQL und API Aufrufe verfolgen'; //'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Profiling der Datenbank Aktivitäten';
  C_wbProfilerBtnCaption= 'Profiler';
  C_wbStatusBtnHint     = 'Status der IBO-Komponenten ansehen'; //'View Status of IBO Components';
  C_wbStatusBtnCaption  = 'Status'; // 'Status';
  C_wbUsersBtnHint      = 'Benutzer des Datenbankservers administrieren'; //'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'Benutzer'; //'Users';

  // Array grid
  C_AG_Row             = 'Zeile'; //'Row';
  C_AG_Column          = 'Spalte'; //'Column';

  //IBF_Who
  C_WHO_FRM            = 'Wer ist verbunden'; //'Who is connected';
  C_WHO_BTNAPPLY       = 'Aktualisieren';//'Refresh';

  C_NB_FIRST = 'Erster'; //'First';
  C_NB_PRIOR = 'Vorheriger'; //'Prior';
  C_NB_NEXT = 'Nächster'; //'Next';
  C_NB_LAST = 'Letzter'; //'Last';

  C_ST_Open = 'Öffnen'; //'Open';
  C_ST_Close = 'Schließen'; //'Close';
  C_ST_Prepare = 'Vorbereiten'; //'Prepare';
  C_ST_Unprepare = 'Zurücksetzen'; //'Unprepare';
  C_ST_ReadOnly = 'Nur Lesen'; //'Read Only';
  C_ST_New = 'Neu'; //'New';
  C_ST_Post = 'Speichern'; //'Post';
  C_ST_Cancel = 'Abbrechen'; //'Cancel';
  C_ST_Delete = 'Löschen'; //'Delete';
  C_ST_Edit = 'Bearbeiten'; //'Edit';
  C_ST_RefreshKeys = 'Schlüssel aktualisieren'; //'Refresh Keys';
  C_ST_RefreshRows = 'Zeilen aktualisieren'; //'Refresh Rows';
  C_ST_Refresh = 'Aktualisieren'; //'Refresh';

{ Hints }

  H_UB_EDIT = 'Datensatz bearbeiten'; //'Edit Row';
  H_UB_INSERT = 'Datensatz einfügen'; //'Insert Row';
  H_UB_DELETE = 'Datensatz löschen'; //'Delete Row';
  H_UB_REFRESH = 'Alle Datensätze aktualisieren'; //'Refresh all records';
  H_UB_REFRESHKEYS = 'Datensatz-Schlüssel aktualisieren'; //'Refresh record keys';
  H_UB_REFRESHROWS = 'Datensätze aktualisieren'; //'Refresh record rows';
  H_UB_REFRESHFILTROWS = 'Gefilterte Datensätze aktualisieren'; //'Refresh filtered rows';
  H_UB_POSTSEARCH = 'Such-Kriterien bestätigen'; //'Post search criteria';
  H_UB_CANCELSEARCH = 'Such-Kriterien verwerfen'; //'Cancel search criteria';
  H_UB_POSTEDIT = 'Änderungen bestätigen'; //'Post edits';
  H_UB_CANCELEDIT = 'Änderungen verwerfen'; //'Cancel edits';
  H_UB_POSTINSERT = 'Einfügen bestätigen'; //'Post insert';
  H_UB_CANCELINSERT = 'Einfügen abbrechen'; //'Cancel insert';
  H_UB_POSTDELETE = 'Löschen bestätigen'; //'Post delete';
  H_UB_CANCELDELETE = 'Löschen abbrechen'; //'Cancel delete';
  H_UB_POST = 'Änderungen bestätigen'; //'Post changes';
  H_UB_CANCEL = 'Änderungen verwerfen'; //'Cancel changes';

  H_NB_FIRST = 'Erster Datensatz'; //'First Row';
  H_NB_PRIOR = 'Vorheriger Datensatz'; //'Prior Row';
  H_NB_NEXT = 'Nächster Datensatz'; //'Next Row';
  H_NB_LAST = 'Letzter Datensatz'; //'Last Row';
  H_NB_JUMPBCK = 'Rückwärts'; //'Backwards';
  H_NB_JUMPFWD = 'Vorwärts'; //'Forwards';

  H_SB_ORDER = 'Sortierung der Datensätze in Datenmenge'; //'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Letzte Such-Kriterien wiederherstellen'; //'Recall Last Search Criteria';
  H_SB_SEARCH = 'Suche in Datenmenge'; //'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Such-Kriterien speichern'; //'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Such-Kriterien löschen'; //'Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Such-Kriterien wiederherstellen'; //'Recall Criteria';
  H_SB_SEARCHCOUNT = 'Anzahl der Datensätze in Datenmenge entsprechend den Such-Kriterien'; //'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Anzahl der Datensätze in Datenmenge'; //'Count Rows in Dataset';
  // Anfang Gerd Kroll GK 05.03.2002 momentan nur in englischer Version
  H_SB_RESTRUCTURE = 'Verändern der Felddarstellung';
  // Ende Gerd Kroll GK 05.03.2002 momentan nur in englischer Version

  H_TB_StartTransaction = 'Transaktion starten'; //'Start Transaction';
  H_TB_PostDatasets = 'Datenmengen speichern'; //'Post Datasets';
  H_TB_CancelDatasets = 'Datenmengen zurücksetzen'; //'Cancel Datasets';
  H_TB_SavePoint = 'Aktuelle Transaktion speichern und beibehalten'; //'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Datenmengen und Transaktion speichern, aktuelle Transaktion beibehalten'; //'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Aktuelle Transaktion speichern und beenden'; //'Commit and End Current Transaction';
  H_TB_Rollback = 'Aktuelle Transaktion verwerfen und beenden'; //'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Aktuelle Transaktion verwerfen und beibehalten'; //'Rollback and Retain Current Transaction';
  H_TB_Close = 'Aktuelle Transaktion schliessen'; //'Close Current Transaction';

  H_ST_Prepare_Statement = 'Statement vorbereiten'; //'Prepare Statement';
  H_ST_Unprepare_Statement = 'Statement zurücksetzen'; //'Unprepare Statement';
  H_ST_Execute_Statement = 'Statement ausführen'; //'Execute Statement';

  H_DS_Open_Dataset = 'Datenmenge öffnen';  //'Open Dataset';
  H_DS_Close_Dataset = 'Datenmenge schliessen'; //'Close Dataset';
  H_DS_Prepare_Dataset = 'Datenmenge vorbereiten';  //'Prepare Dataset';
  H_DS_Unprepare_Dataset = 'Datenmenge zurücksetzen'; //'Unprepare Dataset';
  H_DS_ReadOnly_Dataset = 'Nur lesbare Datenmenge'; //'Read Only Dataset';

  H_CB_Create_Database = 'Database erzeugen'; //'Create Database';
  H_CB_Connect_Database = 'Mit Database verbinden'; //'Connect Database';
  H_CB_Disconnect_Database = 'Database Verbindung trennen'; //'Disconnect Database';
  H_CB_Drop_Database = 'Database löschen'; //'Drop Database';

  // Anfang Gerd Kroll GK 05.03.2002 eingefügt, da nur in USA-Version
  H_RD_actHide = 'Markierte Felder unsichtbar machen';
  H_RD_actHideAll = 'Alle Felder unsichtbar machen';
  H_RD_actVisible = 'Markierte Felder sichbar machen';
  H_RD_actVisibleAll = 'Alle Felder sichtbar machen';
  H_RD_actUp = 'Verschiebe markierte Felder um eins nach oben';
  H_RD_actTop = 'Verschiebe markierte Felder an den Anfang';
  H_RD_actDown = 'Verschiebe markierte Felder um eins nach unten';
  H_RD_actBottom = 'Verschiebe markierte Felder an das Ende';
  // Ende Gerd Kroll GK 05.03.2002


  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Exportiere den Inhalt des SELECT Aufrufes'; //'Export from SELECT statement';

	// Error Messages - IB_Import

  eNoAsciiFileEnty           = 'Eintrag für ASCII-Datei fehlt'; // 'Missing entry for Ascii file';
	eNoDestTableEntry          = 'Eintrag für Ausgabe-Tabelle fehlt'; // 'Missing entry for destination table';
	eAsciiFileNotFound         = 'ASCII-Datei %s nicht gefunden'; // 'Ascii file %s not found';
	eIniFileNotFound           = 'INI-Datei %s nicht gefunden'; // 'Ini-file %s not found';
	eNoAsciiFileAccess         = 'Kann ASCII-Datei %s nicht öffnen'; // 'Could not open ascii file %s';
	eInvalidCharFound          = 'Ungültiges Zeichen / Format-Fehler in der ASCII-Datei'; // 'Invalid char / format error in ascii file';
	eOutOfMemory               = 'Speicherüberlauf'; // 'Out of memory';
	eFieldDescriptionError     = 'Fehler in der Feld Beschreibung'; // 'Error in field description';
	eWrongAsciiFieldCount      = 'Falsche Feld-Anzahl in der ASCII-Datei'; // 'Wrong field count in ascii file';
	eWrongDecimalCount         = 'Falsche Dezimalstellen-Anzahl in der Feldliste (%s)'; // 'Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth           = 'Falsche Feld-Länge in der ASCII-Datei'; // 'Wrong field width in ascii file';

  // Dialog Labels - IB_Import

  lblRecsReadedCaption       = 'Insgesamt gelesene Datensätze'; // 'Total Records read';
  lblRecsCommentedCaption    = 'Datensätze kommentiert'; // 'Records commented';
  lblRecsInsertedCaption     = 'Datensätze eingefügt'; // 'Records inserted';
  btnAbortImportCaption      = 'Abbrechen'; // 'Abort';

  // Metadata Extract Stuff
  // ------------------------

  // Entity Type Names
  STR_DDL_UnnamedItem = '<KEIN NAME>';//'<NO NAME>';
  STR_DDL_etDatabase = 'Datenbank';//'Database';
  STR_DDL_etException = 'Exception';
  STR_DDL_etBlobFilter = 'Blob Filter';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Generator';
  STR_DDL_etDomain = 'Domain';
  STR_DDL_etTable = 'Tabelle';//'Table';
  STR_DDL_etView = 'View';
  STR_DDL_etProcedure = 'Prozedur';//'Procedure';
  STR_DDL_etRole = 'Role';
  STR_DDL_etPrimaryKey = 'Primärschlüssel';//'Primary Key';
  STR_DDL_etUniqueKey = 'Eindeutiger Schlüssel';//'Unique Key';
  STR_DDL_etForeignKey = 'Fremdschlüssel';//'Foreign Key';
  STR_DDL_etConstraint = 'Beschränkungen';//'Constraint';
  STR_DDL_etIndex = 'Index';
  STR_DDL_etTrigger = 'Trigger';
  STR_DDL_etPermission = 'Berechtigung';//'Permission';
  STR_DDL_etUDFParam = 'UDF Parameter';
  STR_DDL_etTableField = 'Tabellenfeld';//'Table Field';
  STR_DDL_etViewField = 'View Feld';//'View Field';
  STR_DDL_etProcParam = 'Prozedur Parameter';//'Procedure Parameter';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Erzeuge Datenbank';//'Create Database';
  STR_DDL_coSecondaryFiles = 'Definiere weitere Dateien';//'Define Secondary Files';
  STR_DDL_coDefineShadows = 'Definiere Shadows';//'Define Shadows';
  STR_DDL_coSetGeneratorVal = 'Setze Generatorwert';//'Set Generator Value';
  STR_DDL_coResetExceptionNo = 'Setzte Exceptionnummer zurück';//'Reset Exception Number';
  STR_DDL_coRawFieldDefs = 'Ursprungsfeld-Definitionen';//'Raw Field Definitions';
  STR_DDL_coReportMinor = 'Report Minor';
  STR_DDL_coAlwaysQuoted = 'Immer in Anführungszeichen';//'Always Quoted';
  STR_DDL_coAlwaysCharSet = 'Bevorzugter Zeichensatz';//'Always Define Character Set';
  STR_DDL_coIncludeDebug = 'DEBUG Kommentare einfügen';//'Include Debug Comments';
  STR_DDL_coDescripAsComment = 'Beschreibungen als Kommentar einfügen';//'Descriptions as Comments';
  STR_DDL_coIsolateAllComputed = 'Isoliere alle berechneten Felder'; // 'Isolate All Computed Fields';
  STR_DDL_coIgnoreDependencies = 'Ignoriere Abhängigkeiten';//'Ignore Dependencies';
  STR_DDL_coKeepCustomIndexNames = 'Behalte Abhängigkeiten bei';//'Keep Custom Index Names';


  // CodePass Names
  STR_DDL_cpFull = 'Full';
  STR_DDL_cpInit = 'Initial';
  STR_DDL_cpFinal = 'Final';
  STR_DDL_cpAuto = 'Automatic';

  // Problem level names
  STD_DDL_plNone       = 'Kein';//'None';
  STD_DDL_plMinor      = 'Geringwertig';//'Minor';
  STD_DDL_plSuspicious = 'verdächtig';//'Suspicious';
  STD_DDL_plWarning    = 'Warnung';//'Warning';
  STD_DDL_plError      = 'Fehler';//'Error';
  // abbreviated Problem level names (to 5 characters)
  STD_DDL_plNone_s       = 'Kein';//'NONE ';
  STD_DDL_plMinor_s      = 'Geringwertig';//'MINOR';
  STD_DDL_plSuspicious_s = 'SUSP ';
  STD_DDL_plWarning_s    = 'Warnung';//'WARN ';
  STD_DDL_plError_s      = 'Fehler';//'ERROR';

  // Dialog strings
  STR_DDL_DialogCaption = 'Metadaten Extrahierung';//'Metadata Extract';
  STR_DDL_Configure = 'Konfiguiere';//'Configure';
  STR_DDL_Filters = 'Filter';//'Filters';
  STR_DDL_Script = 'Skript';//'Script';
  STR_DDL_MetadataControls = 'Metadaten Steuerung';//'Metadata Controls';
  STR_DDL_CodeOptions = 'Code Optionen';//'Code Options';
  STR_DDL_Entities = 'Entities';
  STR_DDL_Terminator = 'Terminator';
  STR_DDL_InsertCommits = 'Commits einfügen'; //'Insert Commits';
  STR_DDL_ExecuteControls = 'Ausführungssteuerung';//'Execute Controls';
  STR_DDL_CodePass = 'Code Pass';
  STR_DDL_ExtractToStrings = 'Extrahiere in Strings';//'Extract To Strings';
  STR_DDL_Reset = 'Zurücksetzen';//'Reset';
  STR_DDL_ResetAll = 'Alles zurücksetzen';//'Reset All';
  STR_DDL_ProgressControls = 'Fortschrittssteuerung';//'Progress Controls';
  STR_DDL_Stop = 'Stopp';//'Stop';
  STR_DDL_IncludeSystem = 'Systemobjekte einfügen';//'Include System Objects';
  STR_DDL_NameMasks = 'Namen maskiert';//'Name Masks';
  STR_DDL_SaveToFile = 'Speichere in Datei';//'Save To File';
  STR_DDL_RunScript = 'Skript ausführen';//'Run Script';
  STR_DDL_ScriptCommands = '&Skript Kommandos'; //'&Script Commands';


  // Errors/Problems reported during extract processing
  // Note that all replaceable parameters use %s (string), any necessary
  // conversions will be performed in the code.
  E_DDL_CURSOR_NOT_CREATED = 'Cursor nicht erzeugt';//'Cursor Not Created';
  E_DDL_BLANK_NAME         = 'Leerer Name';//'Blank Name';
  E_DDL_ENTITY_NOT_FOUND   = 'Entität nicht gefunden';//'Entity Not Found';
  E_DDL_RESERVED_NAME      = 'Reservierter Name für Nicht-Systen-Entität';//'Reserved name used for non-system entity.';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Datenbank Zeichensatz %s wurde nicht gefunden oder ist falsch';//'Database Character set %s was not found to get its canonic name';
  E_DDL_MODULE_NAME_EMPTY  = 'Modulname ist leer';//'Module name is empty';
  E_DDL_ENTRY_POINT_EMPTY  = 'Eintrittspunkt ist leer';//'Entry point is empty';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'Externe Domain kann nur indirekt sein';//'External domain only can be implicit';
  E_DDL_DOMAIN_TYPE_16     = 'Typ 16 kann nur NUMERIC oder DELIMAL sein';//'Type 16 can be only NUMERIC or DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'Zeichensatz Id ist NULL, es wird kein Zeichensatz verwendet';//'Charset Id was NULL, assuming NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Zeichensatzname für ID %s nicht gefunden, es wird kein Zeichensatz verwendet';//'Missing name for charset ID %s Assuming NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'BytesPerZeichen in Zeichensatz %s ist 0';//'BytesPerCharacter was zero in charset %s';
  E_DDL_FIELDLEN_MISMATCH  = 'Feldlänge %s sollte bei Multiple %s Bytes per Zeichen in Zeichensatz %s sein';//'FieldLength %s should be multiple of %s bytes per character in charset name %s';
  E_DDL_INVALID_COLLATIONID = 'Collation Id kann nicht < 0 sein, aber ist %s';//'Collation Id cannot be < 0 but is %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Collation Id ist NULL, soll %s sein';//'Collation Id was NULL, assuming %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Unbekannter Feldtyp %s';//'Unknown FieldType %s';
  E_DDL_CSTRING_IN_DSQL = 'Feldtyp CSTRING wird bei DSQL nicht akzeptiert';//'FieldType CSTRING is not accepted by DSQL';
  E_DDL_QUAD_IN_DSQL = 'Feldtyp QUAD wird bei DSQL nicht akzeptiert';//'FieldType QUAD is not accepted by DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Verdächtige Überprüfung: %s';//'Suspicious check: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Dekaration mit leerer Bedingung';//'Declared but void check constraint';
  E_DDL_EXPLICIT_COMPUTED = 'Domain kann nicht COMPUTED sein';//'Explicit domain cannot be COMPUTED';
  E_DDL_VOID_COMPUTED = 'Deklaration mit leerer COMPUTED BY Klausel';//'Declared but void COMPUTED BY clause';
  E_DDL_SUSPICIOUS_DEFAULT = 'Verdächtige Einstellung: %s';//'Suspicious default: %s';
  E_DDL_VOID_DEFAULT = 'Deklaration mit leerer Einstellung';//'Declared but void default';
  E_DDL_DIMENSIONS_MISMATCH = 'Deklaration mit %s aber Details für %s Details gefunden';//'Declared with %s dimensions but details for %s dimensions where found.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Domain hat keine Tabelle';//'Implicit Domain has no relation.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Domain hat keine Tabelle oder Feldnamen';//'Implicit Domain has missing relation or field name.';
  E_DDL_NO_OUTPUT_PARAMETER = 'Kein Ausgabeparameter';//'No Output Parameter';
  E_DDL_NO_GRANTOR = 'Grantor nicht spezifiziert';//'Grantor not specified';
  E_DDL_VIEW_NO_BLR = 'Kein view_blr aber in rdb$view_relations als CIEW';//'Has not view_blr but it appears in rdb$view_relations as a VIEW';
  E_DDL_VIEW_NO_VIEW_RELATION = 'view_blr vorhanden aber erscheint nicht in rdb$view_relations als VIEW';//'Has view_blr but it doesn''t appear in rdb$view_relations as a VIEW';
  E_DDL_NO_OWNER = 'Besitzername ist nicht spezifiziert';//'Owner name is not specified';
  E_DDL_FORMAT_VERSION = 'Formatversion in %s';//'Format version at %s';
  E_DDL_DBKEY_LEN = 'DbKey Länge sollte 8 sein aber ist %s';//'DbKey_Length should be 8 but is %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'Domain/Feld Definition für Feld %s nicht gefunden';//'Domain/Field Definition for field %s not found';
  E_DDL_NO_SOURCE_CODE = 'Es ist kein Sourcecode verfügbar';//'Has no source code available';
  E_DDL_WITH_CHECK_COMPLETION = '"Mit Überprüfung" komplett zu "Mit Überprüfungsoptionen"';//'"With check" completed to "with check option"';
  E_DDL_NO_BLR = 'Kein BLR vorhanden';//'Has no BLR available';
  E_DDL_CORRUPT_SOURCE = 'Source Vorspann nicht zu erkennen, dies kann corrupt sein';//'Source prefix not recognised, this could indicate corruption';
  E_DDL_INDEX_ID_NULL_INACTIVE = 'Id ist NULL und Index ist inaktiv';//'Id is NULL and index is inactive';
  E_DDL_INDEX_ID_NULL_ACTIVE = 'Id ist NULL aber Index ist aktiv';//'Id is NULL but index is active';
  E_DDL_INVALID_INDEX_ID = 'Id sollte beim Start 1 sein, nicht %s';//'Id should start at 1 not at %s';
  E_DDL_FK_INDEX_NO_CONSTRAINT = 'Fremdschlüssel deklariert, aber in Tabellenrestriktion nicht als FK gefunden';//'Declares foreign key but it is not found in relation constraints as FK index';
  E_DDL_CONSTRAINT_NO_FK_INDEX = 'Fremdschlüssel nicht deklariert, aber in Tabellenrestriktion gefunden';//'Does not declare foreign key but it is found in relation constraints as FK index';
  E_DDL_INDEX_MULTI_USE = 'Benutzt in %s Tabellenrestiktionen zur selben Zeit';//'Used in %s relation constraints at the same time';
  E_DDL_INDEX_NO_FIELDS = 'Benutzung von %s Feldern';//'Uses %s fields';
  E_DDL_INDEX_DUPLICATE = 'Erscheint als Duplikat Index zu Tabelle %s';//'Appears to be a duplicate index definition on table: %s';
  E_DDL_INDEX_SEG_MISMATCH = 'Zu Index zu Tabelle: %s wurden %s Segmente deklariert, aber Details für %s Segmente gefunden';//'Index on table: %s declared %s segments, but details for %s segments where found';
  E_DDL_CONSTRAINT_OUT_OF_RANGE = 'Restriktionstyp %s nicht im gültigen Bereich';//'Constraint type %s is out of range';
  E_DDL_CONSTRAINT_USING_INDEX = 'Restriktionstyp %s sollte keinen Index benutzen, aber benutzt Index: %s';//'Constraint type %s should not use an index but is using index: %s';
  E_DDL_CONSTRAINT_NO_INDEX = 'Restriktionstyp %s sollte einen Index benutzen aber benutz keinen';//'Constraint type %s should use an index but is not using one';
  E_DDL_UPDATE_RULE_INVALID = 'Update Regel %s ist nicht im gültigen Bereich';//'Update rule %s is out of range';
  E_DDL_DELETE_RULE_INVALID = 'Delete Regel %s ist nicht im gültigen Bereich';//'Delete rule %s is out of range';
  E_DDL_PARENT_CONSTRAINT_EMPTY = 'Restriktionsname für Elterntabelle ist leer';//'Constraint name for parent relation is empty';
  E_DDL_FOREIGN_NOT_DEFINED = 'Fremdschlüssel oder Index ist nicht definiert';//'Foreign Table or Index is not defined';
  E_DDL_PARENT_SHOULD_BE_EMPTY = 'Restriktionsname für Elterntabelle sollte leer sein, aber ist %s';//'Constraint name for parent relation should be empty but is %s';
  E_DDL_UPDATE_SHOULD_BE_EMPTY = 'Update Regel sollte leer sein, aber ist %s';//'Update rule should be empty but is %s';
  E_DDL_DELETE_SHOULD_BE_EMPTY = 'Delete Regel sollte leer sein, aber ist %s';//'Delete rule should be empty but is %s';
  E_DDL_NO_BLR_WITH_CHECK =  'Kein Sourcecode verfügbar, wird möglicherweise benutzt für %s mit check option';//'Has no source code available, possibly used for view %s with check option';
  E_DDL_TRIGGER_LOST_CHECK = 'Start mit "CHECK" Schlüsselwort. Benutzt nicht vorhandene Restriktion';//'Starts with "CHECK" keyword. It is used by a check constraint that has been lost';
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Unbekannter Triggertyp';//'Unknown trigger type %s';
  E_DDL_NEGATIVE_SEQUENCE = 'Negative Sequenz %s';//'Has negative sequence %s';
  E_DDL_NO_TARGET_RELATION = 'Zieltabelle oder View ist nicht spezifiziert';//'Target table or view is not specified';
  E_DDL_NOT_IN_DEPENDENCIES = 'Deklariert, aber nicht in dependencies gefunden. Es ist kein Fehler in einem besonderen Fall';//'Declared but not found in dependencies. It is not a bug in some special cases';
  E_DDL_SUSPICIOUS_TRIGGER = 'Verdächtiger Trigger ist abhängig von andrer Tabelle, aber nicht von der Verbundenen';//'Suspicious trigger depends on other tables but not on the one it is attached to';
  E_DDL_INVALID_TRIGGER_SEQ = 'Trigger Sequenz ist %s aber sollte weniger als 1 sein';//'Trigger sequence is %s but should be less than 1 for an implicit trigger';
  E_DDL_GRANT_OUT_OF_RANGE = 'Grant/Admin Optionen außerhalb 0..2 Bereich: %s';//'Grant/Admin option out of 0..2 range: %s';
  E_DDL_GRANT_TO_USER_TYPE = 'Grant/Admin gibt Benutzertyp %s an';//'Grant/Admin option given to user type %s';
  E_DDL_GRANT_FIELDS = 'Versuch Feld zu spezifizieren, aber Privilege ist nicht U oder R';//'Trying to set specific fields but the privilege is not U or R';
  E_DDL_EXECUTE_TO_OBJECT = 'Zuweisung EXECUTE an Objekttyp %s';//Assigning EXECUTE on object type %s that should be 5 (proc) instead';
  E_DDL_BAD_PRIV_ON_PROC = 'Zuweisung %s an Procedure %s';// 'Assigning %s on procedure %s';
  E_DDL_MEMBER_TO_OBJECT = 'Zuweisung Mitgliedschaft an Objekttyp %s';//'Assigning membership on object type %s that should be 13 (role) instead';
  E_DDL_BAD_PRIV_ON_ROLE = 'Zuweisung %s an Role %s';//'Assigning %s on role %s';
  E_DDL_BAD_ARG_POS =  'Argumentposition muß >=0 sein, aber ist %s';// 'Argument position must be >=0 but is %s';
  E_DDL_SYSTEM_FLAG_MISMATCH = 'SystemFlag different to parent';
  E_DDL_BAD_FIELD_ID = 'Field Id muß >=0 sein, aber ist %s';//'Field Id must be >=0 but is %s';
  E_DDL_BAD_FIELD_POS = 'Feldposition muß >=0 sein, aber ist %s';//'Field position must be >=0 but is %s';
  E_DDL_BAD_TABLE_BASEFIELD = 'Basisfeld sollte leer sein für Tabellen, aber ist %s';//'BaseField should be empty for tables but is %s';
  E_DDL_BAD_TABLE_VIEWCONTEXT = 'ViewContext sollte leer sein für Tabellen, aber ist %s';//'ViewContext should be empty for tables but is %s';
  E_DDL_MANDATORY_IN_VIEW = 'Cannot be mandatory in a view';
  E_DDL_BASEFIELD_EMPTY = 'Basisfeld sollte nicht leer sein, wenn ViewContext > 0';//'BaseField should not be empty for views if ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext kann nicht leer sein für Views';//ViewContext cannot be empty for views';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext sollte >=0 sein für Views';//'ViewContext should be >= 0 for views';
  E_DDL_BAD_PARAM_TYPE = 'Parametertyp %s außerhalb des gültigen Bereichs';//'Parameter type %s is out of range';
  E_DDL_BAD_PARAM_NUM = 'Parameternummer muß >=0 sein, aber ist %s';//'Parameter number must be >=0 but is %s';

  // Comments output with DDL statements
  C_DDL_CONNECT_USERNAME   = 'Verbinden mit Benutzername: %s';//'Connect using username: %s';
  C_DDL_CONNECT_SERVER_VER = 'und Server: %s';//'and server: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'Standard Zeichensatz = %s';//'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'Keine skundären Dateien';//'No Secondary Files';
  C_DDL_SEC_FILES = 'Sekundäre Dateien';//'Secondary Files';
  C_DDL_SEC_FILE_DESC = '%s, Start: %s, Länge: %s';// '%s, Start: %s, Length: %s';
  C_DDL_NO_SHADOW_FILES = 'Keine Shadow Dateien';//'No Shadow Files';
  C_DDL_SHADOW_FILES = 'Shadow Dateien';//'Shadow Files';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, Start: %s, Länge: %s';//'%s, %s, Start: %s, Length: %s';
  C_DDL_EXCEPTION_DESC = 'Exception: %s, Original Nummer: %s';// 'Exception: %s, Original Number: %s';
  C_DDL_FIELD_NOT_FOUND = 'Feld nicht gefunden: %s';//'Field Not Found: %s';
  C_DDL_INDEX_NOT_FOUND = 'Index nicht gefunden: %s';//'Index Not Found';
  C_DDL_NO_FOREIGN_RELATION = 'Kein Fremdschlüssel oder Index definiert zu Restriktion';//'No Foreign Relation or Index Defined To Constraint';
  C_DDL_FOREIGN_NOT_FOUND = 'Fremdschlüssel nicht gefunden: %s';//'Foreign Relation Not Found: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Fremdschlüssel Index nicht gefunden: %s';//'Foreign Index Not Found: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Trigger nicht gefunden: %s';//'Trigger Not Found: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Ungültiger Restriktionsname: %s';//'Invalid Constraint Type Name: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'Kein Surce für Trigger: %s';//'No Source For Trigger: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'Triggertyp unbekannt: %s';//'TriggerType Unknown: %s';
  C_DDL_BAD_PRIVILEGE = 'Unbekannte Privilege: %s';// 'Unknown Privilege: %s';

implementation

end.
