
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
{  Leos Urban <Leos.Urban@seznam.cz>                                           }
{  September 13, 2002                                                          }
{  Copyright (C) 2001,2002 Leos Urban                                          }
{  Usage:                                                                      }
{  Rename this file to IB_Constants.pas and rebuild IBO4                       }
{  Translation errors and/or notes please send to my email                     }
{  When error "IB_Components ... different ... IB_Constants.IB_VERSION_MAJOR"  }
{  then change Version information in this file (see ver. in IB_Constants.INT) }
{  Pouití:                                                                    }
{  Pøejmenujte tento soubor na IB_Constants.pas a pøekompilujte IBO4           }
{  Pøekladatelské chyby a poznámky posílejte na uvedenou email adresu          }
{  Pøi chybì "IB_Components ... different ... IB_Constants.IB_VERSION_MAJOR"   }
{  zmìòte Version information v tomto souboru (viz verze IB_Constants.INT)     }
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

  IB_REG_MESSAGE = 'Dìkujeme za vyzkoušení IB Objects.'#13#10#13#10'Prosíme, jdìte na http://www.ibobjects.com a zaregistrujte se ještì dnes.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Spojení ji bylo navázáno';
  E_NOT_CONNECTED     = 'Spojení nebylo navázáno';
  E_Invalid_conn_path = 'Chybná cesta ke spojení';
  E_Cant_Repl_Int_Tr  = 'Nemohu nahradit interní transakci jako defaultní';
  E_NO_TRANS_STARTED  = 'Transakce nebyla nastartována';
  E_TRANS_STARTED     = 'Transakce ji byla nastartována';
  E_NO_CONNECTIONS    = 'Transakce nemá spojení';
  E_NOT_ENOUGH_CONN   = 'Transakce ztratila jedno èi více spojení';
  E_CONN_LOADING      = 'Varování: spojení se stále navazuje';
  E_TRANS_CONN_SESS   = 'Všechny spojení musí bıt ve stejné IB_Session';
  E_TransactionPaused = 'Transakce je pozastavena';
  E_ALLOCATED         = 'Pøíkaz ji byl alokován';
  E_NOT_ALLOCATED     = 'Pøíkaz nebyl alokován';
  E_PREPARED          = 'Pøíkaz ji byl prepared';
  E_NOT_PREPARED      = 'Pøíkaz nebyl prepared';
  E_FAILED_TO_PREPARE = 'Nemohu prepare pøíkaz';
  E_OPENED            = 'Pøíkaz ji je otevøen';
  E_NOT_OPENED        = 'Pøíkaz nebyl otevøen';
  E_CANT_DELETE       = 'Souèasnı záznam v kurzoru nemùe bıt smazán';
  E_NO_CONNECTION     = 'Pøíkaz musí mít pøiøazenu IB_Connection';
  E_CONNECT_FAILED    = 'Nemohu otevøít IB_Connection';
  E_NO_TRANSACTION    = 'Musí bıt pøiøazena IB_Transaction';
  E_NO_ACTIVE_TRANS   = 'ádná aktivní transakce pro spuštìní s';
  E_START_FAILED      = 'Nemohu nastartovat transakci';
  E_SVRAUTOCMT_NOEXP  = 'Explicitní transakce není povolena pøi ServerAutoCommit';
  E_Cannot_Activate     = 'Chybnı stav transakce. Nemohu aktivovat';
  E_Transaction_Is_Active = 'Transakce má nevyøízené zmìny';
  E_Failed_To_Post_Datasets = 'Chyba pøi ukládání všech datasetù';
  E_Failed_To_Cancel_Datasets = 'Chyba pøi stornování všech datasetù';
  E_UpdateWrongTrn    = 'Nemohu mìnit, %s není vlastnìno %s';
  E_NO_BLANK_SQL      = 'Nevyplnìnı SQL pøíkaz není povolen';
  E_AT_END_OF_FILE    = 'Na konci souboru';
  E_AT_END_OF_CURSOR  = 'Na konci kursoru';
  E_AT_END_OF_BUFFER  = 'Na konci bufferu';
  E_AT_END_OF_DATASET = 'Na konci datasetu';
  E_BAD_SQL_INF_LEN   = 'Nepøedvídaná délka isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Vrácena chybná data z isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Nemohu zmìnit jméno kurzoru bìhem aktivního stavu';
  E_REQUEST_LIVE_ACTIVE = 'Nemohu zmìnit hodnotu RequestLive bìhem aktivního stavu';
  E_REQUEST_LIVE_READONLY = 'Nemohu nastavit RequestLive na ReadOnly datasetu';
  E_CURSOR_UNI              = 'IB_CURSOR je jednosmìrnı';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Nepodporovanı typ sloupce: %d';
  E_FIELDNO_NOT_FOUND         = 'Poloka èíslo: %d nenalezena';
  E_FIELDNAME_NOT_FOUND        = 'Poloka jméno: %s nenalezena';
  E_INVALID_FOCUS_RELATION_NO   = 'Chybné èíslo vazby: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Cbybné jméno vazby: %s';
  E_INVALID_QBE_IN              = 'Chyba syntaxe IN( hodnota [ , hodnota ... ] )';
  E_INVALID_QBE_BETWEEN         = 'Chyba syntaxe BETWEEN hodnota AND hodnota';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Nemohu nalézt DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Chybná vlastnost SQLKeyFields';
  E_GET_CURSOR_ERROR       = 'Nemohu otevøít kurzor bez klíèe';
  E_SCROLL_ERROR           = 'Klí záznamu byl ztracen'#13#10'Chyba pøi otevøení kurzoru';
  E_INVALID_BUFFER_ROW_NUM = 'Chybnı BufferRowNum pøed zaèátkem';
  E_BLANK_STATEMENT      = 'Nemohu Prepare nevyplnìnı pøíkaz';
  E_UNKNOWN_STATEMENT   = 'Pokus o provedení neznámého pøíkazu';
  E_CIRCULAR_REFERENCE = 'Kruhové odkazy nejsou povoleny';
  E_CANT_CHG_WITH_CONN = 'Nemohu zmìnit bìhem pøipojení';
  E_LOGIN_FAILED      = 'Pøihlašování skonèilo chybou';
  E_CANT_GET_CONN_CHR = 'Nemohu získat charakteristiku spojení';
  E_MAX_EVENTS_BLOCK  = 'Pøíliš mnoho událostí na jeden blok';
  E_PROCESSING_EVENTS = 'Zpracovávám událost'#13#10'Nemohu odregistrovat';
  E_CANT_STORE_BLOB  = 'Blob ji byl nebo nemùe bıt uloen';
  E_CANT_LOAD_BLOB   = 'Blob ji byl nebo nemùe bıt nahrán';
  E_CANNOT_CANCEL_ROW = 'Nemohu stornovat souèasnı záznam';
  E_CANNOT_POST_ROW  = 'Nemohu uloit souèasnı záznam';
  E_DatasetClosed     = 'Dataset je neaktivní';
  E_DatasetOpen        = 'Dataset je nyní otevøen';
  E_DatasetCannotScroll = 'Dataset nemùe listovat (scroll)';
  E_DatasetReadOnly     = 'Dataset je jen pro ètení';
  E_DatasetIsFetching    = 'Dataset naèítá data';
  E_Invalid_KeyRelation   = 'Chybná KeyRelation hodnota';
  E_RowNum_Not_Implemented = 'Èíslo øádku RowNum není dosud implementováno';
  E_RowDeleted            = 'Záznam byl smazán';
  E_END_OF_DATASET        = 'Na konci datasetu';
  E_BEGINNING_OF_DATASET   = 'Na zaèátku datasetu';
  E_Cannot_Pessimistic_Lock = 'Nemohu pouít pesimistické zamykání s hodnotou LockWait';
  E_Cannot_Edit_Row      = 'Nemohu opravit souèasnı øádek';
  E_Cannot_Insert_Row  = 'Nemohu vloit novı øádek';
  E_Cannot_Delete_Row = 'Nemohu smazat souèasnı øádek';
  E_Cannot_Search    = 'Prohledávání není povoleno';
  E_Cannot_Navigate = 'Nemohu provázet';
  E_Record_Locked    = 'Záznam je uzamèen jinım uivatelem';
  E_Record_OutOfSynch = 'Záznam byl zmìnìn jinım uivatelem';
  E_FLD_READONLY       = '%s je jen na ètení';
  E_Required_Field       = '%s je povinná poloka';
  E_NO_POSTRTN_CACHED_UPDT = 'Nemohu pouít PostRetaining s Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Vráceno více záznamù v jednom ètení';

  E_InvalidRowsAffectedBuf = 'Chybnı buffer pro RowsAffected';
  E_Invalid_RowNum_Past_Eof = 'Chybné èíslo øádku RowNum za EOF';
  E_Invalid_RowNum_Before_Bof = 'Chybné èíslo øádku RowNum pøed BOF';
  E_Invalid_Bookmark = 'Chybná záloka (Bookmark)';

  E_Assign_Column  = 'Nemohu pøevést (assign) z %s';
  E_AssignTo_Column =  'Nemohu pøevést (assign) na %s';
  E_Value_Out_Of_Range = 'Hodnota mimo rozsah';
  E_SmallintOverflow = 'Pøeteèení Smallint';
  E_IntegerOverflow = 'Pøeteèení Integer';
  E_Int64Overflow = 'Pøeteèení Int64';

  E_Unsupported_Column = 'Nepodporovanı typ sloupce: %d';
  E_UndefinedMacro = 'Nedefinované makro';
  E_GeneratorFailed = 'Nemohu získat hodnotu generátoru';

  E_MustBe_Buffered_Dataset = 'Musí bıt potomek TIB_BDataset (IB_Query)';

  E_NO_CHANGE_READONLY = 'Nemohu zmìnit hodnotu ReadOnly po nastartování';
  E_NO_CHANGE_ISOLATION = 'Nemohu zmìnit hodnotu Isolation po nastartování';
  E_NO_CHANGE_RECVERSION = 'Nemohu zmìnit hodnotu RecVersion po nastartování';
  E_NO_CHANGE_LOCKWAIT = 'Nemohu zmìnit hodnotu LockWait po nastartování';

  E_Invalid_Reference_To_Delete = 'Chybnı odkaz na Delete';
  E_Invalid_Typecast = 'Chybné pøetypování';
  E_Invalid_DataPump_Statement = 'Chybnı typ pøíkazu pro DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL poloka nemúe získat NULL hodnotu';
  E_DATABASE_BLANK = 'DatabaseName nemùe bıt nevyplnìná';
  E_Unsupp_Col_Conversion = 'Nepodporovaná konverze sloupce';
  E_Unable_To_Locate_Record = 'Nemohu nalézt záznam';
  E_Record_Not_Inserted = 'Záznam nebyl vloen';
  E_Invalid_KeyLinks = 'Chybnı údaj KeyLinks: %s';
  E_Unable_to_perform_search = 'Nemohu úrpvést vyhledávání';
  E_Unassigned_Blob_Node = 'Nepøiøazenı BlobNode';
  E_Unassigned_Transaction = 'Nepøiøazená transakce';
  E_Invalid_RowsAffected_Buffer = 'Chybnı buffer pro RowsAffected';
  E_Unable_Save_Graphic = 'Nemohu uloit do Graphic';
  E_Cannot_Activate_Transaction = 'Nemohu aktivovat transakci';
  E_IB_Client_Not_Installed = 'InterBase klient GDS32.DLL není nainstalován';
  E_Could_Not_Load_Memo = 'Nemohu nahrát MEMO';
  E_Invalid_DPB_Over_255 = 'Chybné DPB: Více nì 255 znakù';
  E_Inv_Custom_DML = 'Chybnı uivatelskı DML odkaz na sloupec: %s';
  E_Record_Not_Located_For_Update = 'Záznam nebyl nalezen, aby mohl bıt zmìnìn';
  E_Record_Not_Located_For_Delete = 'Záznam nebyl nalezen, aby mohl bıt smazán';
  E_Init_Default_SQL_Failed = 'Nemohu inicializovat defaultní %s';
  E_Stringlist_Not_Sorted = 'Pro tuto operaci musí bıt StringList setøídìn';
  E_Cannot_Change_Events = 'Nemohu zmìnit událost bìhem zpracování';
  E_Cannot_Unregister_Events = 'Nemohu odregistrovat událost bìhem zpracování';
  E_Invalid_Internal_Transaction = 'Chybná interní transakce IB_Transaction';
  E_InvalidStatementType = 'Chybnı typ pøíkazu';
  E_Multiple_Records_Updated = 'Nìkolik záznamù opraveno';
  E_Multiple_Records_Deleted = 'Nìkolik záznamù smazáno';
  E_Multiple_Records_Inserted = 'Nìkolik záznamù vloeno';
  E_DUP_DB_NAME = 'Duplicitní jméno databáze není povoleno';
  E_INVALID_DB_NAME = 'Chybné jméno databáze';
  E_UnableToSearch_NoOrdering = 'Nemohu vyhledávat, není definované tøídìní';
  E_UnableToSearch_DatasetBusy = 'Nemohu vyhledávat, dataset je zaneprázdnìn naèítáním dat';
  E_NoRecordsFound = 'Nenalezen ádnı záznam';
  E_Session_Undefined = 'Nedefinované sezení';
  E_NoCircularRef = 'Kruhové odkazy nejsou povoleny';
  E_InvalidClassType = 'Chybnı typ tøídy';
  E_Invalid_RowNum = 'Chybné èíslo øádku RowNum';
  E_Invalid_Syntax = 'Chybná syntaxe: nesprávnı poèet závorek';
  E_Array_Is_Null = 'Pole je NULL';

  E_Cannot_add_blank_account = 'Nemùete pøidat nevyplnìnı úèet';
  E_Cannot_add_SYSDBA_account = 'Nemùete pøidat SYSDBA úèet';
  E_Cannot_delete_blank_account = 'Nemùete smazat nevyplnìnı úèet';
  E_Cannot_delete_SYSDBA_account = 'Nemùete smazat SYSDBA úèet';
  E_Cannot_modify_blank_account = 'Nemùete opravovat nevyplnìnı úèet';

  E_PLAN_ERROR = 'Chyba SQL plánu!';
  E_PLAN_EXCEPTION = 'Vıjimka SQL plánu!';

  E_INV_CREATE_CONNECT_DROP = 'Chybná syntaxe pøíkazu CREATE, CONNECT nebo DROP DATABASE';
  E_Unsupported = 'Nepodporováno';
  E_NotImplemented = 'Není implementováno na této úrovni';
  E_Invalid_ColData = 'Chybná ColData';

  E_Cant_Unprepare_executing_process = 'Nemohu Unprepare pro provádìnı proces';
  E_FileName_Required = 'Je nutné vyplnìní jména souboru';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Správa uivatelskıch kont';
  L_USERS_ADD = 'Pøidat';
  L_USERS_DELETE = 'Smazat';
  L_USERS_MODIFIY = 'Opravit';
  L_USERS_ACCOUNT = 'Úèet';
  L_USERS_PASSWORD = 'Heslo';
  L_USERS_GROUP = 'Skupina';
  L_USERS_FIRSTNAME = 'Køestní jméno';
  L_USERS_MIDDLENAME = 'Støední jméno';
  L_USERS_LASTNAME = 'Pøíjmení';

  //IBF_Export
  L_EXPORT_FRM = 'Exportování';
  L_EXPORT_ASCII = ' Formát souboru ';
  L_EXPORT_FIXED = 'TXT záznam pevné délky';
  L_EXPORT_DELIMITED = 'CSV s oddìlovaèem';
  L_EXPORT_DBF  = 'DBF  (jen pro testy)';
  L_EXPORT_ASCIIOPT  = ' ASCII volby ';
  L_EXPORT_DELIMITER  = 'Oddìlovaè øetìzcù';
  L_EXPORT_SEPARATOR  = 'Separátor poloek';
  L_EXPORT_DATEFORMAT  = 'Tvar datumu';
  L_EXPORT_INCLUDEHEADERS  = 'Vèetnì hlavièek';
  L_EXPORT_INCLUDECRLF  = 'Vèetnì CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Textové soubory CSV ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Textové soubory ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF soubory ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Skuteènì chcete skonèit?';
  M_Fetching_Query_Results = 'Naèítání vısledkù dotazu';
  M_Row_Num = 'Øádek# %d';
  M_Abort_Fetching_Btn = 'Pøerušení';

  M_Login_Database = 'Databáze';
  M_Login_User = 'Uivatel';
  M_Login_Password = 'Heslo';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Storno';
  M_Login_Help_Btn = '&Nápovìda';
  M_Login_Dialog_Caption = 'Pøihlašovací dialog';

  M_Loading_Caption = 'Nahrávání...';

  M_SB_REC_CNT = 'Poèet záznamù: %d';
  M_Save_Changes = 'Uloit zmìny?';
  M_Abort_Changes = 'Zmìny budou ztraceny. Opravdu zrušit zmìny?';

  M_CancelTransactionPrompt = 'Opravdu chcete zrušit všechny provedené zmìny?';

  M_SCRIPT_ABORT_EXECUTE = 'Skonèit zpracování tohoto skriptu?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Pokraèovat v zpracování tohoto skriptu?';
  M_SCRIPT_IS_EXECUTING = 'Skript je zpracováván';
  M_SCRIPT_FAILED = 'Skript skonèil neúspìšnì';
  M_SCRIPT_WAS_ABORTED = 'Zpracování skriptu bylo pøerušeno';
  M_SCRIPT_COMPLETED = 'Skript byl zpracován bez vıjimeènıch událostí';
  M_SCRIPT_CMPL_EXCEPT = 'Skript byl zpracován, nastaly vıjimeèné události';
  M_SCRIPT_MODIFIED = 'Upraveno';
  M_SCRIPT_SAVE_CHANGES = 'Uloit zmìny?';

{ Button captions }

  C_BTN_TODAY = 'Dnes';
  C_BTN_CLEAR = 'Vyèistit';
  C_BTN_FIND = 'Najít';
  C_BTN_FINDNEXT = 'Najít další';
  C_BTN_REPLACE = 'Nahradit';
  C_BTN_UNDO = 'Zpìt';
  C_BTN_CUT = 'Vyjmout';
  C_BTN_COPY = 'Kopírovat';
  C_BTN_PASTE = 'Vloit';
  C_BTN_DELETE = 'Smazat';
  C_BTN_SELECTALL = 'Vybrat vše';

  C_SG_Parameter = 'Parametr';
  C_SG_Field = 'Poloka';
  C_SG_Name = 'Jméno';
  C_SG_Type = 'Typ';
  C_SG_Info = 'Informace';
  C_SG_Value = 'Hodnota';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Storno';
  C_BF_CANCEL_ACCEL = '&Storno';
  C_BF_APPLY = 'Pouít';
  C_BF_HELP = 'Nápovìda';
  C_BF_EXECUTE = 'Provést';
  C_BF_CLOSE = 'Zavøít';
  C_BF_CLOSE_ACCEL = '&Zavøít';
  C_BF_FINISH = 'Konec';
  C_BF_FINISH_ACCEL = '&Konec';

  C_FRM_Ordering = 'Tøídìní';
  C_FRM_RESTRUCTURE = 'Pøizpùsobení zobrazenıch poloek';

  C_CB_WordWrap = 'Zarovnání slov';

  // IBF_SQL
  M_SQL_RowsAffected = 'Zmìnìnıch záznamù: ';
  M_SQL_RowsCounted = 'Poèet záznamù: ';
  M_SQL_SessionBusy = 'Sezení je zaneprázdnìno';
  M_SQL_CompleteTransaction = 'Prosím dokonèete transakci';
  M_SQL_CannotDeleteDefaultGroup = 'Nemùete smazat defaultní skupinu';
  M_SQL_ReservedName = 'Toto jméno je rezervováno: ';
  M_SQL_BackSlashNotAllowed = 'Zpìtné lomítko není povoleno';
  M_SQL_BlankNameNotAllowed = 'Prázdné jméno není povoleno';
  M_SQL_RowsFetched = 'Naèteno záznamù: ';
  M_SQL_ConfirmDBCreation = 'Skuteènì chcete vytvoøit tuto databázi?';
  M_SQL_ConfirmNoOtherDBSameName = 'Prosím ujistìte se, e neexitsuje databáze se stejnım jménem.';
  M_SQL_ConfirmDBDrop = 'Jste si jist(á) e chcete smazat tuto databázi?';
  M_SQL_ReConfirmDBDrop = 'Databáze bude nenávratnì smazána.'+#13#10+#13#10'Skuteènì smazat?';
  M_SQL_AskFormName = 'Vlote jméno dotazovacího formuláøe:';
  M_SQL_AskGroupName = 'Vlote jméno skupiny:';
  M_SQL_AskLayoutName = 'Vlote jméno uspoøádání:';
  M_SQL_ConfirmGroupDeletion = 'Opravdu chcete smazat %s skupinu vèetnì všech podøízenıch poloek?';
  M_SQL_ConfirmLayoutDeletion = 'Opravdu chcete smazat toto %s uspoøádání?';
  M_SQL_RecursiveCopyNotAllowed = 'Není povolena rekurzivní kopie';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Dvakrát kliknìte na poloce nebo ji vyberte a stisknìte Enter.';
  M_GCSQL_ParameterValue = 'Hodnota parametru';
  M_GCSQL_TypeAValueFor = 'Vlote hodnotu pro %s';
  M_GCSQL_ProcedureWithoutParams = 'Tato procedura nemá vstupní parametry.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'DataPump proces stále bìí.';
  M_DP_ARE_YOU_SURE = 'Jste si jist(á)?';
  M_DP_SELECT_SOURCE_DB = 'Vıbìr zdrojové databáze';
  M_DP_SELECT_DEST_DB = 'Vıbìr cílové databáze';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Vyèistit';
  M_USERS_COMPLETED_OK = 'Operarace skonèila úspìšnì.';
  M_USERS_NO_CONNECTION = 'Není definováno IB_Connection.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Pøiøadit tøídící poloky?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Zaèátek exportu';
  M_EXPORT_STILL_ACTIVE = 'Export proces stále bìí.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Prohlíení databáze';
  C_wbBrowseBtnCaption  = 'Prohlíení';
  C_wbDSQLBtnHint       = 'Provádí pøíkaz v databázi';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitoruje databázové události';
  C_wbEventsBtnCaption  = 'Události';
  C_wbExportBtnHint     = 'Exportuje dataset z databáze';
  C_wbExportBtnCaption  = 'Export';
  C_wbDumpBtnHint       = 'Exportuje data z databáze';
  C_wbDumpBtnCaption    = 'DbExport';
  C_wbPumpBtnHint       = 'Naimportuje data z jiné databáze';
  C_wbPumpBtnCaption    = 'DbImport';
  C_wbWhoBtnHint        = 'Zjištìní pøipojenıch uivatelù';
  C_wbWhoBtnCaption     = 'Kdo';
  C_wbScriptBtnHint     = 'Provedení skriptu';
  C_wbScriptBtnCaption  = 'Skript';
  C_wbExtractBtnHint    = 'Vytvoøení DDL struktury';
  C_wbExtractBtnCaption = 'DDL-SQL';
  C_wbMonitorBtnHint    = 'Sledování SQL a API volání';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Ladìní databázové aktivity (profiler)';
  C_wbProfilerBtnCaption= 'Ladìní';
  C_wbStatusBtnHint     = 'Prohlíení stavu IB komponent';
  C_wbStatusBtnCaption  = 'Stav';
  C_wbUsersBtnHint      = 'Administrování uivatelù DB serveru';
  C_wbUsersBtnCaption   = 'Uivatelé';

  // Array grid
  C_AG_Row             = 'Øádek';
  C_AG_Column          = 'Sloupec';

  //IBF_Who
  C_WHO_FRM            = 'Kdo je pøipojen';
  C_WHO_BTNAPPLY       = 'Aktualizace';

  C_NB_FIRST = 'První';
  C_NB_PRIOR = 'Pøedchozí';
  C_NB_NEXT = 'Další';
  C_NB_LAST = 'Poslední';

  C_ST_Open = 'Otevøít';
  C_ST_Close = 'Uzavøít';
  C_ST_Prepare = 'Prepare';
  C_ST_Unprepare = 'Unprepare';
  C_ST_ReadOnly = 'Jen ètení';
  C_ST_New = 'Novı';
  C_ST_Post = 'Potvrzení';
  C_ST_Cancel = 'Storno';
  C_ST_Delete = 'Smazání';
  C_ST_Edit = 'Oprava';
  C_ST_RefreshKeys = 'Obnova klíèù';
  C_ST_RefreshRows = 'Obnova záznamù';
  C_ST_Refresh = 'Obnova';

{ Hints }

  H_UB_EDIT = 'Opravit záznam';
  H_UB_INSERT = 'Vloit záznam';
  H_UB_DELETE = 'Smazat záznam';
  H_UB_REFRESH = 'Obnovit všechny záznamy (refresh)';
  H_UB_REFRESHKEYS = 'Obnovit klíèe záznamù (refresh)';
  H_UB_REFRESHROWS = 'Obnovit záznamy (refresh)';
  H_UB_REFRESHFILTROWS = 'Obnovit filtrované záznamy (refresh)';
  H_UB_POSTSEARCH = 'Potvrdit podmínku';
  H_UB_CANCELSEARCH = 'Stornovat podmínku';
  H_UB_POSTEDIT = 'Potvrdit opravu';
  H_UB_CANCELEDIT = 'Stornovat opravu';
  H_UB_POSTINSERT = 'Potvrdit vloení';
  H_UB_CANCELINSERT = 'Stornovat vloení';
  H_UB_POSTDELETE = 'Potvrdit smazání';
  H_UB_CANCELDELETE = 'Stornovat smazání';
  H_UB_POST = 'Uloit zmìny';
  H_UB_CANCEL = 'Stornovat zmìny';

  H_NB_FIRST = 'První záznam';
  H_NB_PRIOR = 'Pøedchozí záznam';
  H_NB_NEXT = 'Další záznam';
  H_NB_LAST = 'Poslední záznam';
  H_NB_JUMPBCK = 'Zpìt';
  H_NB_JUMPFWD = 'Vpøed';

  H_SB_ORDER = 'Tøídìní záznamù v datasetu';
  H_SB_LAST_CRITERIA = 'Obnovit poslední podmínku';
  H_SB_SEARCH = 'Hledat v datasetu';
  H_SB_SAVE_CRITERIA = 'Uloit podmínku';
  H_SB_CLEAR_CRITERIA = 'Smazat podmínku';
  H_SB_RECALL_CRITERIA = 'Obnovit uloenou podmínku';
  H_SB_SEARCHCOUNT = 'Poèet záznamù v datasetu odpovídajících podmínce';
  H_SB_COUNT = 'Poèet záznamù v datasetu';
  H_SB_RESTRUCTURE = 'Pøizpùsobení zobrazenıch poloek';

  H_TB_StartTransaction = 'Nastartovat transakci (Start)';
  H_TB_PostDatasets = 'Uloit dataset (Post)';
  H_TB_CancelDatasets = 'Storno datasetu (Cancel)';
  H_TB_SavePoint = 'Potvrdit zmìny a pokraèovat v aktivní transakci (Commit, Retain)';
  H_TB_CommitRetain = 'Uloit dataset, potvrdit zmìny a pokraèovat v aktivní transakci (Post, Commit, Retain)';
  H_TB_Commit = 'Potvrdit zmìny a ukonèit aktivní transakci (Commit, End)';
  H_TB_Rollback = 'Vrátit zmìny a ukonèit aktivní transakci (Rollback, End)';
  H_TB_RollbackRetain = 'Vrátit zmìny a pokraèovat v aktivní transakci (Rollback, Retain)';
  H_TB_Close = 'Uzavøít aktivní transakci (End)';

  H_ST_Prepare_Statement = 'Provést Prepare pøíkazu';
  H_ST_Unprepare_Statement = 'Provést Unprepare pøíkazu';
  H_ST_Execute_Statement = 'Spustit pøíkaz';

  H_DS_Open_Dataset = 'Otevøít dataset';
  H_DS_Close_Dataset = 'Uzavøít dataset';
  H_DS_Prepare_Dataset = 'Provést Prepare datasetu';
  H_DS_Unprepare_Dataset = 'Provést Unprepare datasetu';
  H_DS_ReadOnly_Dataset = 'Dataset jen na ètení';

  H_CB_Create_Database = 'Vytvoøení databáze';
  H_CB_Connect_Database = 'Pøipojení databáze';
  H_CB_Disconnect_Database = 'Odpojení databáze';
  H_CB_Drop_Database = 'Smazání databáze';

  H_RD_actHide = 'Skrıt vybrané poloky';
  H_RD_actHideAll = 'Skrıt všechny poloky';
  H_RD_actVisible = 'Zobrazit vybrané poloky';
  H_RD_actVisibleAll = 'Zobrazit všechny poloky';
  H_RD_actUp = 'Pøesunout vybrané poloky vıše';
  H_RD_actTop = 'Pøesunout vybrané poloky úplnì nahoru';
  H_RD_actDown = 'Pøesunout vybrané poloky níe';
  H_RD_actBottom = 'Pøesunout vybrané poloky úplnì dolù';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Export prostøednictvím SELECT pøíkazu';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Není zadáno jméno ascii souboru';
  eNoDestTableEntry          = 'Není zadána vıstupní tabulka';
  eAsciiFileNotFound         = 'Ascii soubor %s nebyl nalezen';
  eIniFileNotFound           = 'Ini-soubor %s nebyl nalezen';
  eNoAsciiFileAccess         = 'Nemohu otevøít ascii soubor %s';
  eInvalidCharFound          = 'Chybnı znak / formát v ascii souboru';
  eOutOfMemory               = 'Nedostatek pamìti';
  eFieldDescriptionError     = 'Chyba v popisu poloky';
  eWrongAsciiFieldCount      = 'Chybnı poèet poloek v ascii souboru';
  eWrongDecimalCount         = 'Chybnı poèet desetinnıch míst v seznamu poloek (%s)';
  eWrongFieldWidth           = 'Chybná délka poloky v ascii souboru';

  // Metadata Extract Stuff
  // ------------------------

  // Entity Type Names
  STR_DDL_UnnamedItem = '<NEPOJM.>';
  STR_DDL_etDatabase = 'Databáze';
  STR_DDL_etException = 'Vıjimka';
  STR_DDL_etBlobFilter = 'Blob Filtr';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Generátor';
  STR_DDL_etDomain = 'Doména';
  STR_DDL_etTable = 'Tabulka';
  STR_DDL_etView = 'Pohled (View)';
  STR_DDL_etProcedure = 'Procedura';
  STR_DDL_etRole = 'Role';
  STR_DDL_etPrimaryKey = 'Primarní klíè';
  STR_DDL_etUniqueKey = 'Unikátní klíè';
  STR_DDL_etForeignKey = 'Cizí klíè';
  STR_DDL_etConstraint = 'Omezení (Constraint)';
  STR_DDL_etIndex = 'Index';
  STR_DDL_etTrigger = 'Trigger';
  STR_DDL_etPermission = 'Právo';
  STR_DDL_etUDFParam = 'UDF Parametr';
  STR_DDL_etTableField = 'Poloka tabulky';
  STR_DDL_etViewField = 'Poloka pohledu (view)';
  STR_DDL_etProcParam = 'Parametr procedury';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Vytvoøení databáze';
  STR_DDL_coSecondaryFiles = 'Definice sekundárních souborù';
  STR_DDL_coDefineShadows = 'Definice Shadow souborù';
  STR_DDL_coSetGeneratorVal = 'Nastavení hodnoty generátoru';
  STR_DDL_coResetExceptionNo = 'Nastavení èísla vıjimky';
  STR_DDL_coRawFieldDefs = 'Definice poloky';
  STR_DDL_coIsolateAllComputed = 'Izoluj všechny vypoètené poloky';
  STR_DDL_coReportMinor = 'Sestava Minor';
  STR_DDL_coAlwaysQuoted = 'Vdy uvozovky';
  STR_DDL_coAlwaysCharSet = 'Vdy definice znakové sady';
  STR_DDL_coIncludeDebug = 'Vèetnì komentáøù ladìní';
  STR_DDL_coDescripAsComment = 'Popisy jako komentáøe';
  STR_DDL_coIgnoreDependencies = 'Ignoruj vazby';
  STR_DDL_coKeepCustomIndexNames = 'Zachovej uivatelská jména indexù';

  // CodePass Names
  STR_DDL_cpFull = 'Plnı';
  STR_DDL_cpInit = 'Poèáteèní';
  STR_DDL_cpFinal = 'Koneènı';
  STR_DDL_cpAuto = 'Automatickı';

  // Problem level names
  STD_DDL_plNone       = 'Nic';
  STD_DDL_plMinor      = 'Malo';
  STD_DDL_plSuspicious = 'Podezøení';
  STD_DDL_plWarning    = 'Varování';
  STD_DDL_plError      = 'Chyba';
  // abbreviated Problem level names (to 5 characters)
  STD_DDL_plNone_s       = 'NIC ';
  STD_DDL_plMinor_s      = 'MALO ';
  STD_DDL_plSuspicious_s = 'PDZRN';
  STD_DDL_plWarning_s    = 'VAROV';
  STD_DDL_plError_s      = 'CHYBA';

  // Dialog strings
  STR_DDL_DialogCaption = 'Získání metadat';
  STR_DDL_Configure = 'Konfigurace';
  STR_DDL_Filters = 'Filtry';
  STR_DDL_Script = 'Skripty';
  STR_DDL_MetadataControls = 'Metadata ovládání';
  STR_DDL_CodeOptions = 'Volby kódù';
  STR_DDL_Entities = 'Entity';
  STR_DDL_Terminator = 'Terminátor';
  STR_DDL_InsertCommits = 'Vkládej COMMIT';
  STR_DDL_ExecuteControls = 'Provádìní ovládání';
  STR_DDL_CodePass = 'Prùbìh kódu';
  STR_DDL_ExtractToStrings = 'Získání do øetìzcù';
  STR_DDL_Reset = 'Reset';
  STR_DDL_ResetAll = 'Reset všeho';
  STR_DDL_ProgressControls = 'Prùbìh ovládání';
  STR_DDL_Stop = 'Zastav';
  STR_DDL_IncludeSystem = 'Vèetnì systémovıch objektù';
  STR_DDL_NameMasks = 'Maskování jmen';
  STR_DDL_SaveToFile = 'Uloit do souboru';
  STR_DDL_RunScript = 'Spus skript';
  STR_DDL_ScriptCommands = '&Skript pøíkazy';


  // Errors/Problems reported during extract processing
  // Note that all replaceable parameters use %s (string), any necessary
  // conversions will be performed in the code.
  E_DDL_CURSOR_NOT_CREATED = 'Kurzor nevytvoøen';
  E_DDL_BLANK_NAME         = 'Prázdné jméno';
  E_DDL_ENTITY_NOT_FOUND   = 'Entita nenalezena';
  E_DDL_RESERVED_NAME      = 'Rezervované jméno v nesystém. entitì';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Databázová znak.sada %s nebyla nalezena';
  E_DDL_MODULE_NAME_EMPTY  = 'Prázdné jméno modulu';
  E_DDL_ENTRY_POINT_EMPTY  = 'Prázdné jméno vstupního bodu';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'Jen externí doména smí bıt implicitní';
  E_DDL_DOMAIN_TYPE_16     = 'Typ 16 mùe bıt jen NUMERIC èi DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'ID znakové sady je NULL, bude NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Chybné jméno pro ID znakové sady %s, bude NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'Poèet bajtù na znak je pro znakovou sadu %s nulovı';
  E_DDL_FIELDLEN_MISMATCH  = 'Délka poloky %s musí bıt dìlitelná %s bajty na znak ve znakové sadì %s';
  E_DDL_INVALID_COLLATIONID = 'Id tøídìní nesmí bıt < 0 ale je %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Id tøídìní je NULL, bude %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Neznámı typ poloky %s';
  E_DDL_CSTRING_IN_DSQL = 'Typ CSTRING není akceptován v DSQL';
  E_DDL_QUAD_IN_DSQL = 'Typ QUAD není akceptován v DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Podezøelá kontrola: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Deklarovaná ale prázdná kontrola omezení';
  E_DDL_EXPLICIT_COMPUTED = 'Explicitní doména nemùe bıt COMPUTED';
  E_DDL_VOID_COMPUTED = 'Declarovaná ale prázdná COMPUTED BY klauzule';
  E_DDL_SUSPICIOUS_DEFAULT = 'Podezøelá defaultní hodnota: %s';
  E_DDL_VOID_DEFAULT = 'Deklarovaná ale prázdná defaultní hodnota';
  E_DDL_DIMENSIONS_MISMATCH = 'Deklarován %s rozmìr ale nalezen detail pro %s rozmìr.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Implicitní doména nemá vazbu.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Implicitní doménì chybí vazba nebo jméno poloky.';
  E_DDL_NO_OUTPUT_PARAMETER = 'Není vıstupní parametr';
  E_DDL_NO_GRANTOR = 'Není specifikován postupovatel (Grantor)';
  E_DDL_VIEW_NO_BLR = 'Není view_blr ale objevuje se v rdb$view_relations jako VIEW';
  E_DDL_VIEW_NO_VIEW_RELATION = 'Je view_blr ale neobjevuje se v rdb$view_relations jako VIEW';
  E_DDL_NO_OWNER = 'Není specifikováno jméno vlastníka';
  E_DDL_FORMAT_VERSION = 'Verze formátu v %s';
  E_DDL_DBKEY_LEN = 'DbKey_Length musí bıt 8 ale je %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'Definice domény/poloky pro poloku %s nenalezena';
  E_DDL_NO_SOURCE_CODE = 'Není dostupnı zdrojovı kód';
  E_DDL_WITH_CHECK_COMPLETION = '"With check" doplnìn do "with check option"';
  E_DDL_NO_BLR = 'Není dostupné BLR';
  E_DDL_CORRUPT_SOURCE = 'Zdrojovı prefix nebyl rozpoznán, mùe to indikovat poškození';
  E_DDL_INDEX_ID_NULL_INACTIVE = 'Id je NULL a index je neaktivní';
  E_DDL_INDEX_ID_NULL_ACTIVE = 'Id je NULL ale index je aktivní';
  E_DDL_INVALID_INDEX_ID = 'Id musí zaèínat na 1, ne na %s';
  E_DDL_FK_INDEX_NO_CONSTRAINT = 'Deklarován cizí klíè ale není nalezen v relaèních omezeních jako FK index';
  E_DDL_CONSTRAINT_NO_FK_INDEX = 'Není deklarován cizí klíè ale v relaèních omezeních existuje jako FK index';
  E_DDL_INDEX_MULTI_USE = 'Vícenásobné souèasné pouití v %s relaèním omezení';
  E_DDL_INDEX_NO_FIELDS = 'Pouívá %s poloky';
  E_DDL_INDEX_DUPLICATE = 'Zjištìna duplicitní definice indexu pro tabulku: %s';
  E_DDL_INDEX_SEG_MISMATCH = 'Index na tabulku: %s deklarováno %s segmentù, ale detaily pro %s segmentù bylo nalezeno';
  E_DDL_CONSTRAINT_OUT_OF_RANGE = 'Omezení typu %s je mimo rozsah';
  E_DDL_CONSTRAINT_USING_INDEX = 'Omezení typu %s nesmí pouívat index ale pouívá index: %s';
  E_DDL_CONSTRAINT_NO_INDEX = 'Omezení typu %s musí pouít index ale nepouívá jej';
  E_DDL_UPDATE_RULE_INVALID = 'Opravné pravidlo %s je mimo rozsah';
  E_DDL_DELETE_RULE_INVALID = 'Mazací pravidlo %s je mimo rozsah';
  E_DDL_PARENT_CONSTRAINT_EMPTY = 'Jméno omezení pro rodièovskou vazbu je prázdné';
  E_DDL_FOREIGN_NOT_DEFINED = 'Cizí tabulka nebo index nejsou definovány';
  E_DDL_PARENT_SHOULD_BE_EMPTY = 'Jméno omezení pro rodièovskou vazbu musí bıt prázdné ale je %s';
  E_DDL_UPDATE_SHOULD_BE_EMPTY = 'Opravné pravidlo musí bıt prázdné ale je %s';
  E_DDL_DELETE_SHOULD_BE_EMPTY = 'Mazací pravidlo musí bıt prázdné ale je %s';
  E_DDL_NO_BLR_WITH_CHECK =  'Není dostupnı zdrojovı kód,pravdìpodobnì uit pro view %s with check option';
  E_DDL_TRIGGER_LOST_CHECK = 'Nalozeno "CHECK" klíèové slovo. Pouito kontrolní omezení které bylo ztraceno';
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Neznámı typ triggeru %s';
  E_DDL_NEGATIVE_SEQUENCE = 'Nalezena záporná sekvence %s';
  E_DDL_NO_TARGET_RELATION = 'Cílová tabulka nebo view není urèena';
  E_DDL_NOT_IN_DEPENDENCIES = 'Deklarováno ale nenalezeno ve vazbách. V nìkterıch pøípadech to není chyba';
  E_DDL_SUSPICIOUS_TRIGGER = 'Podezøelı trigger závisí na jinıch tabulkách ale není k nim pøipojen';
  E_DDL_INVALID_TRIGGER_SEQ = 'Trigger sekvence je %s ale musí bıt menší ne 1 pro implicitní trigger';
  E_DDL_GRANT_OUT_OF_RANGE = 'Grant/Admin volba mimo 0..2 rozsah: %s';
  E_DDL_GRANT_TO_USER_TYPE = 'Grant/Admin volba dává pro uivatele typ %s';
  E_DDL_GRANT_FIELDS = 'Zkouším nastavit poloky ale právo není U nebo R';
  E_DDL_EXECUTE_TO_OBJECT = 'Pøiøazuji EXECUTE na objekt typu %s kterı musí bıt 5 (proc)';
  E_DDL_BAD_PRIV_ON_PROC = 'Pøiøazuji %s pro proceduru %s';
  E_DDL_MEMBER_TO_OBJECT = 'Pøiøazuji vlastnictví pro objekt typu %s kterı musí bıt 13 (role)';
  E_DDL_BAD_PRIV_ON_ROLE = 'Pøiøazuji %s pro roli %s';
  E_DDL_BAD_ARG_POS =  'Pozice argumentu musí bıt >=0 ale je %s';
  E_DDL_SYSTEM_FLAG_MISMATCH = 'SystemFlag se odlišuje od rodièe';
  E_DDL_BAD_FIELD_ID = 'Id poloky musí bıt >=0 ale je %s';
  E_DDL_BAD_FIELD_POS = 'Pozice poloky musí bıt >=0 ale je %s';
  E_DDL_BAD_TABLE_BASEFIELD = 'BaseField musí bıt prázdná pro tabulky ale je %s';
  E_DDL_BAD_TABLE_VIEWCONTEXT = 'ViewContext musí bıt prázdná pro tabulky ale je %s';
  E_DDL_MANDATORY_IN_VIEW = 'Nemùe bıt povinné ve view';
  E_DDL_BASEFIELD_EMPTY = 'BaseField nesmí bıt prázdné pro views pøi ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext nemùe bıt prázdnı pro views';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext musí bıt >= 0 pro views';
  E_DDL_BAD_PARAM_TYPE = 'Typ parametru %s mimo rozsah';
  E_DDL_BAD_PARAM_NUM = 'Èíslo parametru musí bıt >=0 ale je %s';

  // Comments output with DDL statements
  C_DDL_CONNECT_USERNAME   = 'Pøipojení jako: %s';
  C_DDL_CONNECT_SERVER_VER = 'a server: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'Bez sekundárních souborù';
  C_DDL_SEC_FILES = 'Sekundární soubory';
  C_DDL_SEC_FILE_DESC = '%s, Start: %s, Délka: %s';
  C_DDL_NO_SHADOW_FILES = 'Bez stínovıch souborù';
  C_DDL_SHADOW_FILES = 'Stínové soubory';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, Start: %s, Délka: %s';
  C_DDL_EXCEPTION_DESC = 'Vıjimka: %s, Pùvodní èíslo: %s';
  C_DDL_FIELD_NOT_FOUND = 'Poloka nenalezena: %s';
  C_DDL_INDEX_NOT_FOUND = 'Index nenalezen';
  C_DDL_NO_FOREIGN_RELATION = 'Není cizí vazba nebo index pro omezení';
  C_DDL_FOREIGN_NOT_FOUND = 'Cizí vazba nenalezena: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Cizí klíè nenalezen: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Trigger nenalezen: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Chybné jméno omezení: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'Bez zdroje pro trigger: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'Typ Trigger neznámı: %s';
  C_DDL_BAD_PRIVILEGE = 'Neznámé právo: %s';


implementation

end.
