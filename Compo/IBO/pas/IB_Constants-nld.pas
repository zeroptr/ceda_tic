
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

IB_REG_MESSAGE = 'Dank u voor het evalueren van IB Objects.'#10#13#10#13 +
                   'Registreer u vandaag nog op http://www.ibobjects.com.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'De verbinding is reeds gemaakt';
  E_NOT_CONNECTED     = 'De verbinding is niet gelukt';
  E_Invalid_conn_path ='Ongeldige database map';
  E_Cant_Repl_Int_Tr='Kan niet standaard een impliciete transactie vervangen';
  E_NO_TRANS_STARTED  = 'De transactie is niet gestart';
  E_TRANS_STARTED     = 'De transactie is reeds gestart';
  E_NO_CONNECTIONS    = 'De transactie heeft geen verbindingen';
  E_NOT_ENOUGH_CONN   = 'De transactie mist één of meer verbindingen';
  E_CONN_LOADING      = 'Waarschuwing: nog steeds bezig met het maken van de verbinding';
  E_TRANS_CONN_SESS   = 'De verbindingen moeten in dezelfde IB_Sessie bestaan';
  E_TransactionPaused = 'De transactie is gepauseerd';
  E_ALLOCATED         = 'De opdracht is reeds gereserveerd';
  E_NOT_ALLOCATED     = 'De opdracht is nog niet gereserveerd';
  E_PREPARED          = 'De opdracht is reeds gebruiksklaar';
  E_NOT_PREPARED      = 'De opdracht is nog niet gebruiksklaar';
  E_FAILED_TO_PREPARE = 'De opdracht kon niet gebruiksklaar gemaakt worden';
  E_OPENED            = 'De opdracht is reeds geopend';
  E_NOT_OPENED        = 'De opdracht is not niet geopend';
  E_CANT_DELETE       = 'Het huidige record kan in deze cursor niet verwijderd worden';
  E_NO_CONNECTION     = 'De opdracht moet een IB_Connection toegewezen krijgen';
  E_CONNECT_FAILED    = 'De IB_Connection kon niet geopend worden';
  E_NO_TRANSACTION    = 'De opdracht moet een IB_Transaction toegewezen krijgen';
  E_NO_ACTIVE_TRANS   = 'Geen enkele transactie is actief';
  E_START_FAILED      = 'De transactie kon niet gestart worden';
  E_SVRAUTOCMT_NOEXP = 'Een expliciete transactie is niet toegelaten met ServerAutoCommit';
  E_Cannot_Activate  = 'De status van de transactie is ongeldig.  Kan niet geactiveerd worden';
  E_Transaction_Is_Active = 'De transactie heeft wijzigingen die nog moeten doorgevoerd worden';
  E_Failed_To_Post_Datasets = 'Het opslaan van alle datasets is mislukt';
  E_Failed_To_Cancel_Datasets = 'Het annuleren van alle datasets is mislukt';
  E_UpdateWrongTrn    = 'Update onmogelijk, %s is geen eigendom van %s';
  E_NO_BLANK_SQL      = 'Een lege SQL opdracht is niet toegelaten';
  E_AT_END_OF_FILE    = 'Aan het einde van het bestand';
  E_AT_END_OF_CURSOR  = 'Aan het einde van de cursor';
  E_AT_END_OF_BUFFER  = 'Aan het einde van de buffer';
  E_AT_END_OF_DATASET = 'Aan het einde van de dataset';
  E_BAD_SQL_INF_LEN   = 'Onverwachte lengte in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Ongeldige data ontvangen van isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'De naam van de cursor kan niet gewijzigd worden zolang die actief is';
  E_REQUEST_LIVE_ACTIVE = 'RequestLive kan niet gewijzigd worden zolang actief';
  E_REQUEST_LIVE_READONLY = 'RequestLive is niet geldig in een ReadOnly dataset';
  E_CURSOR_UNI              = 'IB_CURSOR is unidirectioneel';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Kolom type is ongeldig: %d';
  E_FIELDNO_NOT_FOUND         = 'Veldnummer niet gevonden: %d';
  E_FIELDNAME_NOT_FOUND        = 'Veldnaam niet gevonden: %s';
  E_INVALID_FOCUS_RELATION_NO   = 'Huidig relatienummer is ongeldig: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Huidige relatienaam is ongeldig: %s';
  E_INVALID_QBE_IN              = 'IN( value [ , value ... ] ) syntax fout';
  E_INVALID_QBE_BETWEEN         = 'BETWEEN waarde AND waarde syntax fout';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Kon DLL import %s niet vinden';
  E_SESSION_ALREADY_ATTACHED    = 'De verbinding met de sessie is reeds gemaakt';
  E_SESSION_ALREADY_DETACHED    = 'De verbinding met de sessie is reeds verbroken';
  E_UNABLE_TO_LOAD_SESSION    = '%s kon niet geladen worden';
  E_INVALID_SQL_KEY_FIELDS  = 'SQLKeyFields is ongeldig';
  E_GET_CURSOR_ERROR      = 'De cursor kan niet geopend worden zonder de sleutel gegevens';
  E_SCROLL_ERROR          = 'De sleutel was verloren'#10#13'Cursor kon niet geopend worden';
  E_INVALID_BUFFER_ROW_NUM = 'BufferRowNum was ongeldig voor het begin';
  E_BLANK_STATEMENT      = 'Een lege opdracht kan niet voorbereid worden';
  E_UNKNOWN_STATEMENT  = 'De opdracht is niet bekend';
  E_CIRCULAR_REFERENCE = 'Circulaire referenties zijn niet toegelaten';
  E_CANT_CHG_WITH_CONN  = 'Kan niet gewijzigd worden zolang er verbinding is';
  E_LOGIN_FAILED        = 'Login mislukt';
  E_CANT_GET_CONN_CHR   = 'De eigenschappen van de verbinding konden niet gevonden worden';
  E_MAX_EVENTS_BLOCK   = 'Het aantal events per block is overschreden';
  E_PROCESSING_EVENTS = 'Verwerken van events'#13#10'De registratie kon niet ongedaan gemaakt worden';
  E_CANT_STORE_BLOB = 'Blob is of kon niet opgeslagen worden';
  E_CANT_LOAD_BLOB   = 'Blob is reeds of kon niet geladen worden';
  E_CANNOT_CANCEL_ROW = 'De huidige rij kan niet geannuleerd worden';
  E_CANNOT_POST_ROW = 'De huidige rij kan niet opgeslagen worden';
  E_DatasetClosed = 'Het dataset is niet actief';
  E_DatasetOpen      = 'Het dataset is reeds open';
  E_DatasetCannotScroll = 'Het dataset kan niet scrollen';
  E_DatasetReadOnly   = 'Het dataset is alleen-lezen';
  E_DatasetIsFetching = 'Het dataset is bezig met zoeken';
  E_Invalid_KeyRelation = 'Ongeldige waarde in KeyRelation';
  E_RowNum_Not_Implemented = 'RowNum is nog niet ondersteund';
  E_RowDeleted = 'De rij wordt verwijderd';
  E_END_OF_DATASET = 'Aan het einde van het dataset';
  E_BEGINNING_OF_DATASET = 'Aan het begin van het dataset';
  E_Cannot_Pessimistic_Lock = 'Pessimistic locking en LockWait kunnen niet samen gebruikt worden';
  E_Cannot_Edit_Row = 'De huidige rij kan niet aangepast worden';
  E_Cannot_Insert_Row = 'Er kan geen nieuwe rij toegevoegd worden';
  E_Cannot_Delete_Row = 'De huidige rij kan niet verwijderd worden';
  E_Cannot_Search = 'Zoeken is niet toegelaten';
  E_Cannot_Navigate = 'Kan niet navigeren';
  E_Record_Locked = 'Het record is geblokkeerd door een andere gebruiker';
  E_Record_OutOfSynch = 'Het record is gewijzigd door een andere gebruiker';
  E_FLD_READONLY = '%s is alleen-lezen';
  E_Required_Field = '%s is een verplicht veld';
  E_NO_POSTRTN_CACHED_UPDT = 'PostRetaining en Cached Updates kunnen niet samen gebruikt worden';
  E_Multiple_Rows_In_Singleton = 'Meerdere records in een enkelvoudige zoekopdracht';

  E_InvalidRowsAffectedBuf = 'De buffer RowsAffected is ongeldig';
  E_Invalid_RowNum_Past_Eof = 'RowNumber is ongeldig, voorbij Eof';
  E_Invalid_RowNum_Before_Bof = 'RowNumber is ongeldig, voor Bof';
  E_Invalid_Bookmark = 'Bookmark string is ongeldig';

  E_Assign_Column   = 'Kan niet toegewezen worden van %s';
  E_AssignTo_Column = 'Kan niet toegewezen worden aan %s';
  E_Value_Out_Of_Range = 'Waarde buiten bereik';
  E_SmallintOverflow = 'Smallint overflow';
  E_IntegerOverflow = 'Integer overflow';
  E_Int64Overflow = 'Int64 overflow';

  E_Unsupported_Column = 'Kolom type is niet ondersteund: %d';
  E_UndefinedMacro = 'Onbekende macro';
  E_GeneratorFailed = 'Generator waarde kon niet opgehaald worden';

  E_MustBe_Buffered_Dataset = 'Moet een afstammeling zijn van TIB_BDataset (IB_Query)';

  E_NO_CHANGE_READONLY = 'ReadOnly kan niet gewijzigd worden indien gestart';
  E_NO_CHANGE_ISOLATION = 'Isolation kan niet gewijzigd worden indien gestart';
  E_NO_CHANGE_RECVERSION = 'RecVersion kan niet gewijzigd worden indien gestart';
  E_NO_CHANGE_LOCKWAIT = 'LockWait kan niet gewijzigd worden indien gestart';

  E_Invalid_Reference_To_Delete = 'Invalid reference to Delete';
  E_Invalid_Typecast = 'Typeconversie is ongeldig';
  E_Invalid_DataPump_Statement = 'Het type van de opdracht voor DataPump is ongeldig';
  E_FIELD_NOT_NULLABLE = 'NOT NULL veld heeft null waarde';
  E_DATABASE_BLANK = 'DatabaseName mag niet leeg zijn';
  E_Unsupp_Col_Conversion = 'Kolom conversie is niet ondersteund';
  E_Unable_To_Locate_Record = 'Record kon niet gevonden worden';
  E_Record_Not_Inserted = 'Record kon niet toegevoegd worden';
  E_Invalid_KeyLinks = 'KeyLinks is ongeldig: %s';
  E_Unable_to_perform_search = 'Het zoeken kon niet uitgevoerd worden';
  E_Unassigned_Blob_Node = 'BlobNode is niet toegewezen';
  E_Unassigned_Transaction = 'Transactie is niet toegewezen';
  E_Invalid_RowsAffected_Buffer = 'De RowsAffected buffer is ongeldig';
  E_Unable_Save_Graphic = 'Graphic kon niet bewaard worden';
  E_Cannot_Activate_Transaction = 'Kon de transactie niet actief maken';
  E_IB_Client_Not_Installed = 'InterBase Client GDS32.DLL is niet geïnstalleerd';
  E_Could_Not_Load_Memo = 'Memo kon niet geladen worden';
  E_Invalid_DPB_Over_255 = 'DPB is ongeldig: inhoud bevat meer dan 255 karakters';
  E_Inv_Custom_DML = 'Aangepaste DML kolom referentie is ongeldig: %s';
  E_Record_Not_Located_For_Update = 'Het record kon niet gevonden worden voor update';
  E_Record_Not_Located_For_Delete = 'Het record kon niet gevonden worden voor verwijdering';
  E_Init_Default_SQL_Failed = 'Kon standaard %s niet initialiseren';
  E_Stringlist_Not_Sorted = 'StringList moet gesorteerd zijn voor deze bewerking';
  E_Cannot_Change_Events = 'De events kunnen niet gewijzigd worden tijdens de verwerking ervan';
  E_Cannot_Unregister_Events = 'De registratie van de events kan niet ongedaan gemaakt worden tijdens de verwerking ervan';
  E_Invalid_Internal_Transaction = 'Interne IB_Transaction is ongeldig';
  E_InvalidStatementType = 'Het type van de opdracht is ongeldig';
  E_Multiple_Records_Updated = 'Meerdere records zijn geüpdated';
  E_Multiple_Records_Deleted = 'Meerdere records zijn verwijderd';
  E_Multiple_Records_Inserted = 'Meerder records zijn toegevoegd';
  E_DUP_DB_NAME = 'Dubbele DatabaseName is niet toegelaten';
  E_INVALID_DB_NAME = 'DatabaseName is ongeldig';
  E_UnableToSearch_NoOrdering = 'Kan geen zoekactie starten, geen sortering opgegeven';
  E_UnableToSearch_DatasetBusy = 'Kan geen zoekactie starten, dataset is records aan het ophalen';
  E_NoRecordsFound = 'Geen records gevonden';
  E_Session_Undefined = 'De sessie is niet gedefinieerd';
  E_NoCircularRef = 'Circulaire referenties zijn niet toegelaten';
  E_InvalidClassType = 'Het type van de class is ongeldig';
  E_Invalid_RowNum = 'RowNum is ongeldig';
  E_Invalid_Syntax = 'De syntax is ongeldig: te veel of te weinig aanhalingstekens';
  E_Array_Is_Null = 'Array is Null';

  E_Cannot_add_blank_account = 'Een lege account kan niet toegevoegd worden';
  E_Cannot_add_SYSDBA_account = 'SYSDBA account kan niet toegevoegd worden';
  E_Cannot_delete_blank_account = 'Een lege account kan niet verwijderd worden';
  E_Cannot_delete_SYSDBA_account = 'SYSDBA account kan niet verwijderd worden';
  E_Cannot_modify_blank_account = 'Een lege account kan niet gewijzigd worden';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Ongeldig CREATE, CONNECT of DROP DATABASE syntax';
  E_Unsupported = 'Wordt niet ondersteund';
  E_NotImplemented = 'Is niet geimplementeerd op dit niveau';
  E_Invalid_ColData = 'Ongeldige kolomdata';

  E_Cant_Unprepare_executing_process = 'Kan geen process in uitvoering voorbereiden';
  E_FileName_Required = 'Bestandsnaam is verplicht';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Gebruikers beheer';
  L_USERS_ADD = 'Toevoegen';
  L_USERS_DELETE = 'Verwijderen';
  L_USERS_MODIFIY = 'Wijzigen';
  L_USERS_ACCOUNT = 'ACCOUNT';
  L_USERS_PASSWORD = 'Password';
  L_USERS_GROUP = 'Groep';
  L_USERS_FIRSTNAME = 'Voornaam';
  L_USERS_MIDDLENAME = 'Tussen naam';
  L_USERS_LASTNAME = 'Achternaam';

  //IBF_Export
  L_EXPORT_FRM = 'Export';
  L_EXPORT_ASCII = ' Bestands formaat ';
  L_EXPORT_FIXED = 'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV Delimited';
  L_EXPORT_DBF  = 'DBF  (Moet nog getest worden)';
  L_EXPORT_ASCIIOPT  = ' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Delimiter';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Datum formaat';
  L_EXPORT_INCLUDEHEADERS  = 'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Bent u er zeker van dat u deze bewerking wenst af te breken?';
  M_Fetching_Query_Results = 'Resultaten van de Query';
  M_Row_Num = 'Record# %d';
  M_Abort_Fetching_Btn = 'Afbreken';

  M_Login_Database = 'Databank';
  M_Login_User = 'Gebruiker';
  M_Login_Password = 'Paswoord';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Annuleren';
  M_Login_Help_Btn = '&Help';
  M_Login_Dialog_Caption = 'Login Dialog';

  M_Loading_Caption = 'Laden...';

  M_SB_REC_CNT = 'Aantal records: %d';
  M_Save_Changes = 'Wijzigingen opslaan?';
  M_Abort_Changes = 'Wijzigingen niet opgeslagen. Doorgaan?';

  M_CancelTransactionPrompt =
    'Bent u er zeker van dat u alle wijzigingen wenst te annuleren?';

  M_SCRIPT_ABORT_EXECUTE = 'Uitvoering van deze script afbreken?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Doorgaan met uitvoeren van deze script?';
  M_SCRIPT_IS_EXECUTING = 'Script is momenteel bezig met uitvoeren';
  M_SCRIPT_FAILED = 'Script niet geheel uitgevoerd';
  M_SCRIPT_WAS_ABORTED = 'Uitvoering van de script is afgebroken';
  M_SCRIPT_COMPLETED = 'Script is uitgevoerd zonder fouten';
  M_SCRIPT_CMPL_EXCEPT = 'Script is uitgevoerd met fouten';
  M_SCRIPT_MODIFIED = 'Gewijzigd';
  M_SCRIPT_SAVE_CHANGES = 'Wijzigingen opslaan?';

{ Button captions }

  C_BTN_TODAY = 'Vandaag';
  C_BTN_CLEAR = 'Leegmaken';
  C_BTN_FIND = 'Zoeken';
  C_BTN_FINDNEXT = 'Volgende zoeken';
  C_BTN_REPLACE = 'Vervangen';
  C_BTN_UNDO = 'Ongedaan maken';
  C_BTN_CUT = 'Knippen';
  C_BTN_COPY = 'Kopieren';
  C_BTN_PASTE = 'Plakken';
  C_BTN_DELETE = 'Verwijderen';
  C_BTN_SELECTALL = 'Alles selecteren';

  C_SG_Parameter = 'Parameter';
  C_SG_Field = 'Veld';
  C_SG_Name = 'Naam';
  C_SG_Type = 'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'Waarde';

  C_BF_OK = 'Ok';
  C_BF_CANCEL = 'Annuleren';
  C_BF_CANCEL_ACCEL = '&Annuleren';
  C_BF_APPLY = 'Toepassen';
  C_BF_HELP = 'Help';
  C_BF_EXECUTE = 'Uitvoeren';
  C_BF_CLOSE = 'Sluiten';
  C_BF_CLOSE_ACCEL = '&Sluiten';
  C_BF_FINISH = 'Einde';
  C_BF_FINISH_ACCEL = '&Einde';


  C_FRM_Ordering = 'Sortering';
  C_FRM_RESTRUCTURE = 'Aangepaste velden getoond';

  C_CB_WordWrap = 'Automatische terugloop';

  // IBF_SQL
  M_SQL_RowsAffected = 'Aangedane records: ';
  M_SQL_RowsCounted = 'Getelde records: ';
  M_SQL_SessionBusy = 'Session is momenteel bezet';
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

  H_UB_EDIT = 'Record wijzigen';
  H_UB_INSERT = 'Record toevoegen';
  H_UB_DELETE = 'Record verwijderen';
  H_UB_REFRESH = 'Alle records vernieuwen';
  H_UB_REFRESHKEYS = 'Ververs de sleutels van de records';
  H_UB_REFRESHROWS = 'Ververs records';
  H_UB_REFRESHFILTROWS = 'Gefilterde rijen vernieuwen';
  H_UB_POSTSEARCH = 'De criteria van de zoekopdracht doorvoeren';
  H_UB_CANCELSEARCH = 'De criteria van de zoekopdracht annuleren';
  H_UB_POSTEDIT = 'Wijzigingen doorvoeren';
  H_UB_CANCELEDIT = 'Wijzigingen annuleren';
  H_UB_POSTINSERT = 'Toevoeging doorvoeren';
  H_UB_CANCELINSERT = 'Toevoeging annuleren';
  H_UB_POSTDELETE = 'Verwijdering doorvoeren';
  H_UB_CANCELDELETE = 'Verwijdering annuleren';
  H_UB_POST = 'Wijzigingen doorvoeren';
  H_UB_CANCEL = 'Wijzigingen annuleren';

  H_NB_FIRST = 'Eerste record';
  H_NB_PRIOR = 'Vorige record';
  H_NB_NEXT = 'Volgende record';
  H_NB_LAST = 'Laatste record';
  H_NB_JUMPBCK = 'Achteruit';
  H_NB_JUMPFWD = 'Vooruit';

  H_SB_ORDER = 'De records in de dataset sorteren';
  H_SB_LAST_CRITERIA = 'De criteria van de laatste zoekopdracht ophalen';
  H_SB_SEARCH = 'Dataset doorzoeken';
  H_SB_SAVE_CRITERIA = 'Criteria bewaren';
  H_SB_CLEAR_CRITERIA = 'Criteria leegmaken';
  H_SB_RECALL_CRITERIA = 'Criteria ophalen';
  H_SB_SEARCHCOUNT = 'Tel het aantal records in de dataset die voldoen aan de criteria';
  H_SB_COUNT = 'Tel het aantal records in de dataset';
  H_SB_RESTRUCTURE = 'Wijzig de getoonde velden';

  H_TB_StartTransaction = 'Start de transactie';
  H_TB_PostDatasets = 'Datasets opslaan';
  H_TB_CancelDatasets = 'Datasets annuleren';
  H_TB_SavePoint = 'Doorvoeren en behouden van de huidige transactie';
  H_TB_CommitRetain = 'Datasets opslaan en doorvoeren en behouden van de huidige transactie';
  H_TB_Commit = 'Doorvoeren en de huidige transactie beëindigen';
  H_TB_Rollback = 'Annuleren en de huidige transactie beëindigen';
  H_TB_RollbackRetain = 'Annuleren en de huidige transactie behouden';
  H_TB_Close = 'De huidige transactie sluiten';

  H_ST_Prepare_Statement = 'Script voorbereiden';
  H_ST_Unprepare_Statement = 'Annuleer voorbereide script';
  H_ST_Execute_Statement = 'Script uitvoeren';

  H_DS_Open_Dataset = 'Dataset openen';
  H_DS_Close_Dataset = 'Dataset sluiten';
  H_DS_Prepare_Dataset = 'Dataset voorbereiden';
  H_DS_Unprepare_Dataset = 'Annuleer voorbereide Dataset';
  H_DS_ReadOnly_Dataset = 'Dataset alleen lezen';

  H_CB_Create_Database = 'Database aanmaken';
  H_CB_Connect_Database = 'Connect Database';
  H_CB_Disconnect_Database = 'Disconnect Database';
  H_CB_Drop_Database = ' Database verwijderen';

  H_RD_actHide = 'Geselecteerde velden verbergen';
  H_RD_actHideAll = 'Alle velden verbergen';
  H_RD_actVisible = 'Maak geselecteerde velden zichtbaar';
  H_RD_actVisibleAll = 'Maak alle geselecteerde velden zichtbaar';
  H_RD_actUp = 'Verplaats geselecteerde velden 1 naar boven';
  H_RD_actTop = 'Verplaats geselecteerde velden naar boven';  //'Move selected fields to the top';
  H_RD_actDown = 'Verplaats geselecteerde velden 1 naar beneden'; //'Move selected fields one down';
  H_RD_actBottom = 'Verplaats geselecteerde velden naar beneden'; //'Move selected fields to the bottom';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Bezig met het exporteren van de SQL script'; //'Export from SELECT statement';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Kan tekstbestand niet lezen'; //'Missing entry for Ascii file';
  eNoDestTableEntry          = 'Kan doel tabel niet lezen'; // 'Missing entry for destination table';
  eAsciiFileNotFound         = 'Tekstbestand niet gevonden'; //'Ascii file %s not found';
  eIniFileNotFound           = 'Ini-file niet gevonden'; //'Ini-file %s not found';
  eNoAsciiFileAccess         = 'Kan tekstbestand niet openen'; //'Could not open ascii file %s';
  eInvalidCharFound          = 'Ongeldige karakter / bestandsindeling in tekstbestand'; //'Invalid char / format error in ascii file';
  eOutOfMemory               = 'Geheugen fout'; //'Out of memory';
  eFieldDescriptionError     = 'Fout in veld beschrijving'; //'Error in field description';
  eWrongAsciiFieldCount      = 'Ongeldig aantal velden in tekstbestand, line (%d)'; //'Wrong field count in ascii file, line (%d)';
  eWrongDecimalCount         = 'Ongeldig aantal decimalen in veldlijst (%s)'; //'Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth           = 'Ongeldige veld breedte in tekstbestand'; //'Wrong field width in ascii file';

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
  STR_DDL_coCreateDatabase = 'Database aanmaken'; //'Create database';
  STR_DDL_coSecondaryFiles = 'Definieer tweede bestand'; // 'Define Secondary Files';
  STR_DDL_coDefineShadows = 'Definieer shadow bestanden'; //'Define Shadows';
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
  STD_DDL_plNone       = 'Geen'; //'None';
  STD_DDL_plMinor      = 'Minor';
  STD_DDL_plSuspicious = 'Verdacht'; //'Suspicious';
  STD_DDL_plWarning    = 'Waarschuwing'; //'Warning';
  STD_DDL_plError      = 'Fout'; //'Error';
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
  E_DDL_CURSOR_NOT_CREATED = 'Cursor niet gecreeerd'; //'Cursor Not Created';
  E_DDL_BLANK_NAME         = 'Geen naam'; //'Blank Name';
  E_DDL_ENTITY_NOT_FOUND   = 'Entiteit niet gevonden'; //'Entity Not Found';
  E_DDL_RESERVED_NAME      = 'Gereserveerde naam gebruikt voor een non-system entiteit'; //'Reserved name used for non-system entity.';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Database Character set %s is niet gevonden voor het verkrijgen van zijn canonic naam'; //'Database Character set %s was not found to get its canonic name';
  E_DDL_MODULE_NAME_EMPTY  = 'Module naam is leeg'; //'Module name is empty';
  E_DDL_ENTRY_POINT_EMPTY  = 'Entry point is empty';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'Externe domein kan alleen impliciet zijn'; //'External domain only can be implicit';
  E_DDL_DOMAIN_TYPE_16     = 'Type 16 kan allen NUMERIEK of DECIMAAL zijn'; //'Type 16 can be only NUMERIC or DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'Charset Id was NULL, assuming NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Naam ontbreekt voor karakterset %s Aangenomen wordt NONE'; //'Missing name for charset ID %s Assuming NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'BytesPerCharacter was zero in charset %s';
  E_DDL_FIELDLEN_MISMATCH  = 'FieldLength %s should be multiple of %s bytes per character in charset name %s';
  E_DDL_INVALID_COLLATIONID = 'Collation Id cannot be < 0 but is %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Collation Id was NULL, assuming %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Onbekende veldtype &s'; //'Unknown FieldType %s';
  E_DDL_CSTRING_IN_DSQL = 'Veldtype CSTRING word niet geaccepteerd door DSQL'; //'FieldType CSTRING is not accepted by DSQL';
  E_DDL_QUAD_IN_DSQL = 'Veldtype QUAD wordt niet geaccepteerd door DSQL'; //'FieldType QUAD is not accepted by DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Suspicious check: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Beperking is gedeclareerd maar leeg'; //'Declared but void check constraint';
  E_DDL_EXPLICIT_COMPUTED = 'Expliciete domein kan niet worden COMPUTED'; //'Explicit domain cannot be COMPUTED';
  E_DDL_VOID_COMPUTED = 'Gedeclareerde maar lege COMPUTED BY voorwaarde'; //'Declared but void COMPUTED BY clause';
  E_DDL_SUSPICIOUS_DEFAULT = 'Verdacht standaard voorwaarde %s'; //'Suspicious default: %s';
  E_DDL_VOID_DEFAULT = 'Gedeclareerde maar lege standaard voorwaarde'; //'Declared but void default';
  E_DDL_DIMENSIONS_MISMATCH = 'Gedeclareerd met %s dimensies maar de details voor %s dimensies zijn niet gevonden'; //'Declared with %s dimensions but details for %s dimensions where found.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Impliciete domein heeft geen relatie'; //'Implicit Domain has no relation.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Impliciete domain heeft geen relatie of veldnaam' ; //'Implicit Domain has missing relation or field name.';
  E_DDL_NO_OUTPUT_PARAMETER = 'Geen output parameter'; //'No Output Parameter';
  E_DDL_NO_GRANTOR = 'Grantor not specified';
  E_DDL_VIEW_NO_BLR = 'Has not view_blr but it appears in rdb$view_relations as a VIEW';
  E_DDL_VIEW_NO_VIEW_RELATION = 'Has view_blr but it doesn''t appear in rdb$view_relations as a VIEW';
  E_DDL_NO_OWNER = 'Owner name is not specified';
  E_DDL_FORMAT_VERSION = 'Format version at %s';
  E_DDL_DBKEY_LEN = 'DbKey_Length should be 8 but is %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'Domain/Field Definition for field %s not found';
  E_DDL_NO_SOURCE_CODE = 'Geen source code beschikbaar'; //'Has no source code available';
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
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Onbekende trigger type %s'; //'Unknown trigger type %s';
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
  E_DDL_MANDATORY_IN_VIEW = 'Kan niet verplicht zijn in een view'; //'Cannot be mandatory in a view';
  E_DDL_BASEFIELD_EMPTY = 'BaseField should not be empty for views if ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext cannot be empty for views';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext should be >= 0 for views';
  E_DDL_BAD_PARAM_TYPE = 'Parameter type %s is out of range';
  E_DDL_BAD_PARAM_NUM = 'Parameter number must be >=0 but is %s';

  // Comments output with DDL statements
  C_DDL_CONNECT_USERNAME   = 'Verbonden met gebruikersnaam: %s'; //'Connect using username: %s';
  C_DDL_CONNECT_SERVER_VER = 'en server: %s'; // ;'and server: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'No Secondary Files';
  C_DDL_SEC_FILES = 'Secondary Files';
  C_DDL_SEC_FILE_DESC = '%s, Start: %s, Lengte: %s';
  C_DDL_NO_SHADOW_FILES = 'Geen schaduw bestanden';
  C_DDL_SHADOW_FILES = 'Schaduw bestanden';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, Start: %s, Length: %s';
  C_DDL_EXCEPTION_DESC = 'Exception: %s, Original Number: %s';
  C_DDL_FIELD_NOT_FOUND = 'Bestand niet gevonden: %s';
  C_DDL_INDEX_NOT_FOUND = 'Index niet gevonden';
  C_DDL_NO_FOREIGN_RELATION = 'No Foreign Relation or Index Defined To Constraint';
  C_DDL_FOREIGN_NOT_FOUND = 'Foreign Relation Not Found: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Foreign Index Not Found: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Trigger Not Found: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Invalid Constraint Type Name: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'No Source For Trigger: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'TriggerType Unknown: %s';
  C_DDL_BAD_PRIVILEGE = 'Unknown Privilege: %s';

{$IFDEF IBO_VCL50_OR_GREATER}
  IDE_DataAccess = 'InterBase';
{$ELSE}
  IDE_DataAccess = 'Data Access';
{$ENDIF}
  IDE_Samples = 'Samples';

implementation

end.

