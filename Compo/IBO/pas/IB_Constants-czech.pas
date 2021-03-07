
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
{  Pou�it�:                                                                    }
{  P�ejmenujte tento soubor na IB_Constants.pas a p�ekompilujte IBO4           }
{  P�ekladatelsk� chyby a pozn�mky pos�lejte na uvedenou email adresu          }
{  P�i chyb� "IB_Components ... different ... IB_Constants.IB_VERSION_MAJOR"   }
{  zm��te Version information v tomto souboru (viz verze IB_Constants.INT)     }
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

  IB_REG_MESSAGE = 'D�kujeme za vyzkou�en� IB Objects.'#13#10#13#10'Pros�me, jd�te na http://www.ibobjects.com a zaregistrujte se je�t� dnes.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Spojen� ji� bylo nav�z�no';
  E_NOT_CONNECTED     = 'Spojen� nebylo nav�z�no';
  E_Invalid_conn_path = 'Chybn� cesta ke spojen�';
  E_Cant_Repl_Int_Tr  = 'Nemohu nahradit intern� transakci jako defaultn�';
  E_NO_TRANS_STARTED  = 'Transakce nebyla nastartov�na';
  E_TRANS_STARTED     = 'Transakce ji� byla nastartov�na';
  E_NO_CONNECTIONS    = 'Transakce nem� spojen�';
  E_NOT_ENOUGH_CONN   = 'Transakce ztratila jedno �i v�ce spojen�';
  E_CONN_LOADING      = 'Varov�n�: spojen� se st�le navazuje';
  E_TRANS_CONN_SESS   = 'V�echny spojen� mus� b�t ve stejn� IB_Session';
  E_TransactionPaused = 'Transakce je pozastavena';
  E_ALLOCATED         = 'P��kaz ji� byl alokov�n';
  E_NOT_ALLOCATED     = 'P��kaz nebyl alokov�n';
  E_PREPARED          = 'P��kaz ji� byl prepared';
  E_NOT_PREPARED      = 'P��kaz nebyl prepared';
  E_FAILED_TO_PREPARE = 'Nemohu prepare p��kaz';
  E_OPENED            = 'P��kaz ji� je otev�en';
  E_NOT_OPENED        = 'P��kaz nebyl otev�en';
  E_CANT_DELETE       = 'Sou�asn� z�znam v kurzoru nem��e b�t smaz�n';
  E_NO_CONNECTION     = 'P��kaz mus� m�t p�i�azenu IB_Connection';
  E_CONNECT_FAILED    = 'Nemohu otev��t IB_Connection';
  E_NO_TRANSACTION    = 'Mus� b�t p�i�azena IB_Transaction';
  E_NO_ACTIVE_TRANS   = '��dn� aktivn� transakce pro spu�t�n� s';
  E_START_FAILED      = 'Nemohu nastartovat transakci';
  E_SVRAUTOCMT_NOEXP  = 'Explicitn� transakce nen� povolena p�i ServerAutoCommit';
  E_Cannot_Activate     = 'Chybn� stav transakce. Nemohu aktivovat';
  E_Transaction_Is_Active = 'Transakce m� nevy��zen� zm�ny';
  E_Failed_To_Post_Datasets = 'Chyba p�i ukl�d�n� v�ech dataset�';
  E_Failed_To_Cancel_Datasets = 'Chyba p�i stornov�n� v�ech dataset�';
  E_UpdateWrongTrn    = 'Nemohu m�nit, %s nen� vlastn�no %s';
  E_NO_BLANK_SQL      = 'Nevypln�n� SQL p��kaz nen� povolen';
  E_AT_END_OF_FILE    = 'Na konci souboru';
  E_AT_END_OF_CURSOR  = 'Na konci kursoru';
  E_AT_END_OF_BUFFER  = 'Na konci bufferu';
  E_AT_END_OF_DATASET = 'Na konci datasetu';
  E_BAD_SQL_INF_LEN   = 'Nep�edv�dan� d�lka isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Vr�cena chybn� data z isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Nemohu zm�nit jm�no kurzoru b�hem aktivn�ho stavu';
  E_REQUEST_LIVE_ACTIVE = 'Nemohu zm�nit hodnotu RequestLive b�hem aktivn�ho stavu';
  E_REQUEST_LIVE_READONLY = 'Nemohu nastavit RequestLive na ReadOnly datasetu';
  E_CURSOR_UNI              = 'IB_CURSOR je jednosm�rn�';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Nepodporovan� typ sloupce: %d';
  E_FIELDNO_NOT_FOUND         = 'Polo�ka ��slo: %d nenalezena';
  E_FIELDNAME_NOT_FOUND        = 'Polo�ka jm�no: %s nenalezena';
  E_INVALID_FOCUS_RELATION_NO   = 'Chybn� ��slo vazby: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Cbybn� jm�no vazby: %s';
  E_INVALID_QBE_IN              = 'Chyba syntaxe IN( hodnota [ , hodnota ... ] )';
  E_INVALID_QBE_BETWEEN         = 'Chyba syntaxe BETWEEN hodnota AND hodnota';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Nemohu nal�zt DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Chybn� vlastnost SQLKeyFields';
  E_GET_CURSOR_ERROR       = 'Nemohu otev��t kurzor bez kl��e';
  E_SCROLL_ERROR           = 'Kl� z�znamu byl ztracen'#13#10'Chyba p�i otev�en� kurzoru';
  E_INVALID_BUFFER_ROW_NUM = 'Chybn� BufferRowNum p�ed za��tkem';
  E_BLANK_STATEMENT      = 'Nemohu Prepare nevypln�n� p��kaz';
  E_UNKNOWN_STATEMENT   = 'Pokus o proveden� nezn�m�ho p��kazu';
  E_CIRCULAR_REFERENCE = 'Kruhov� odkazy nejsou povoleny';
  E_CANT_CHG_WITH_CONN = 'Nemohu zm�nit b�hem p�ipojen�';
  E_LOGIN_FAILED      = 'P�ihla�ov�n� skon�ilo chybou';
  E_CANT_GET_CONN_CHR = 'Nemohu z�skat charakteristiku spojen�';
  E_MAX_EVENTS_BLOCK  = 'P��li� mnoho ud�lost� na jeden blok';
  E_PROCESSING_EVENTS = 'Zpracov�v�m ud�lost'#13#10'Nemohu odregistrovat';
  E_CANT_STORE_BLOB  = 'Blob ji� byl nebo nem��e b�t ulo�en';
  E_CANT_LOAD_BLOB   = 'Blob ji� byl nebo nem��e b�t nahr�n';
  E_CANNOT_CANCEL_ROW = 'Nemohu stornovat sou�asn� z�znam';
  E_CANNOT_POST_ROW  = 'Nemohu ulo�it sou�asn� z�znam';
  E_DatasetClosed     = 'Dataset je neaktivn�';
  E_DatasetOpen        = 'Dataset je nyn� otev�en';
  E_DatasetCannotScroll = 'Dataset nem��e listovat (scroll)';
  E_DatasetReadOnly     = 'Dataset je jen pro �ten�';
  E_DatasetIsFetching    = 'Dataset na��t� data';
  E_Invalid_KeyRelation   = 'Chybn� KeyRelation hodnota';
  E_RowNum_Not_Implemented = '��slo ��dku RowNum nen� dosud implementov�no';
  E_RowDeleted            = 'Z�znam byl smaz�n';
  E_END_OF_DATASET        = 'Na konci datasetu';
  E_BEGINNING_OF_DATASET   = 'Na za��tku datasetu';
  E_Cannot_Pessimistic_Lock = 'Nemohu pou��t pesimistick� zamyk�n� s hodnotou LockWait';
  E_Cannot_Edit_Row      = 'Nemohu opravit sou�asn� ��dek';
  E_Cannot_Insert_Row  = 'Nemohu vlo�it nov� ��dek';
  E_Cannot_Delete_Row = 'Nemohu smazat sou�asn� ��dek';
  E_Cannot_Search    = 'Prohled�v�n� nen� povoleno';
  E_Cannot_Navigate = 'Nemohu prov�zet';
  E_Record_Locked    = 'Z�znam je uzam�en jin�m u�ivatelem';
  E_Record_OutOfSynch = 'Z�znam byl zm�n�n jin�m u�ivatelem';
  E_FLD_READONLY       = '%s je jen na �ten�';
  E_Required_Field       = '%s je povinn� polo�ka';
  E_NO_POSTRTN_CACHED_UPDT = 'Nemohu pou��t PostRetaining s Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Vr�ceno v�ce z�znam� v jednom �ten�';

  E_InvalidRowsAffectedBuf = 'Chybn� buffer pro RowsAffected';
  E_Invalid_RowNum_Past_Eof = 'Chybn� ��slo ��dku RowNum za EOF';
  E_Invalid_RowNum_Before_Bof = 'Chybn� ��slo ��dku RowNum p�ed BOF';
  E_Invalid_Bookmark = 'Chybn� z�lo�ka (Bookmark)';

  E_Assign_Column  = 'Nemohu p�ev�st (assign) z %s';
  E_AssignTo_Column =  'Nemohu p�ev�st (assign) na %s';
  E_Value_Out_Of_Range = 'Hodnota mimo rozsah';
  E_SmallintOverflow = 'P�ete�en� Smallint';
  E_IntegerOverflow = 'P�ete�en� Integer';
  E_Int64Overflow = 'P�ete�en� Int64';

  E_Unsupported_Column = 'Nepodporovan� typ sloupce: %d';
  E_UndefinedMacro = 'Nedefinovan� makro';
  E_GeneratorFailed = 'Nemohu z�skat hodnotu gener�toru';

  E_MustBe_Buffered_Dataset = 'Mus� b�t potomek TIB_BDataset (IB_Query)';

  E_NO_CHANGE_READONLY = 'Nemohu zm�nit hodnotu ReadOnly po nastartov�n�';
  E_NO_CHANGE_ISOLATION = 'Nemohu zm�nit hodnotu Isolation po nastartov�n�';
  E_NO_CHANGE_RECVERSION = 'Nemohu zm�nit hodnotu RecVersion po nastartov�n�';
  E_NO_CHANGE_LOCKWAIT = 'Nemohu zm�nit hodnotu LockWait po nastartov�n�';

  E_Invalid_Reference_To_Delete = 'Chybn� odkaz na Delete';
  E_Invalid_Typecast = 'Chybn� p�etypov�n�';
  E_Invalid_DataPump_Statement = 'Chybn� typ p��kazu pro DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL polo�ka nem��e z�skat NULL hodnotu';
  E_DATABASE_BLANK = 'DatabaseName nem��e b�t nevypln�n�';
  E_Unsupp_Col_Conversion = 'Nepodporovan� konverze sloupce';
  E_Unable_To_Locate_Record = 'Nemohu nal�zt z�znam';
  E_Record_Not_Inserted = 'Z�znam nebyl vlo�en';
  E_Invalid_KeyLinks = 'Chybn� �daj KeyLinks: %s';
  E_Unable_to_perform_search = 'Nemohu �rpv�st vyhled�v�n�';
  E_Unassigned_Blob_Node = 'Nep�i�azen� BlobNode';
  E_Unassigned_Transaction = 'Nep�i�azen� transakce';
  E_Invalid_RowsAffected_Buffer = 'Chybn� buffer pro RowsAffected';
  E_Unable_Save_Graphic = 'Nemohu ulo�it do Graphic';
  E_Cannot_Activate_Transaction = 'Nemohu aktivovat transakci';
  E_IB_Client_Not_Installed = 'InterBase klient GDS32.DLL nen� nainstalov�n';
  E_Could_Not_Load_Memo = 'Nemohu nahr�t MEMO';
  E_Invalid_DPB_Over_255 = 'Chybn� DPB: V�ce n� 255 znak�';
  E_Inv_Custom_DML = 'Chybn� u�ivatelsk� DML odkaz na sloupec: %s';
  E_Record_Not_Located_For_Update = 'Z�znam nebyl nalezen, aby mohl b�t zm�n�n';
  E_Record_Not_Located_For_Delete = 'Z�znam nebyl nalezen, aby mohl b�t smaz�n';
  E_Init_Default_SQL_Failed = 'Nemohu inicializovat defaultn� %s';
  E_Stringlist_Not_Sorted = 'Pro tuto operaci mus� b�t StringList set��d�n';
  E_Cannot_Change_Events = 'Nemohu zm�nit ud�lost b�hem zpracov�n�';
  E_Cannot_Unregister_Events = 'Nemohu odregistrovat ud�lost b�hem zpracov�n�';
  E_Invalid_Internal_Transaction = 'Chybn� intern� transakce IB_Transaction';
  E_InvalidStatementType = 'Chybn� typ p��kazu';
  E_Multiple_Records_Updated = 'N�kolik z�znam� opraveno';
  E_Multiple_Records_Deleted = 'N�kolik z�znam� smaz�no';
  E_Multiple_Records_Inserted = 'N�kolik z�znam� vlo�eno';
  E_DUP_DB_NAME = 'Duplicitn� jm�no datab�ze nen� povoleno';
  E_INVALID_DB_NAME = 'Chybn� jm�no datab�ze';
  E_UnableToSearch_NoOrdering = 'Nemohu vyhled�vat, nen� definovan� t��d�n�';
  E_UnableToSearch_DatasetBusy = 'Nemohu vyhled�vat, dataset je zanepr�zdn�n na��t�n�m dat';
  E_NoRecordsFound = 'Nenalezen ��dn� z�znam';
  E_Session_Undefined = 'Nedefinovan� sezen�';
  E_NoCircularRef = 'Kruhov� odkazy nejsou povoleny';
  E_InvalidClassType = 'Chybn� typ t��dy';
  E_Invalid_RowNum = 'Chybn� ��slo ��dku RowNum';
  E_Invalid_Syntax = 'Chybn� syntaxe: nespr�vn� po�et z�vorek';
  E_Array_Is_Null = 'Pole je NULL';

  E_Cannot_add_blank_account = 'Nem��ete p�idat nevypln�n� ��et';
  E_Cannot_add_SYSDBA_account = 'Nem��ete p�idat SYSDBA ��et';
  E_Cannot_delete_blank_account = 'Nem��ete smazat nevypln�n� ��et';
  E_Cannot_delete_SYSDBA_account = 'Nem��ete smazat SYSDBA ��et';
  E_Cannot_modify_blank_account = 'Nem��ete opravovat nevypln�n� ��et';

  E_PLAN_ERROR = 'Chyba SQL pl�nu!';
  E_PLAN_EXCEPTION = 'V�jimka SQL pl�nu!';

  E_INV_CREATE_CONNECT_DROP = 'Chybn� syntaxe p��kazu CREATE, CONNECT nebo DROP DATABASE';
  E_Unsupported = 'Nepodporov�no';
  E_NotImplemented = 'Nen� implementov�no na t�to �rovni';
  E_Invalid_ColData = 'Chybn� ColData';

  E_Cant_Unprepare_executing_process = 'Nemohu Unprepare pro prov�d�n� proces';
  E_FileName_Required = 'Je nutn� vypln�n� jm�na souboru';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Spr�va u�ivatelsk�ch kont';
  L_USERS_ADD = 'P�idat';
  L_USERS_DELETE = 'Smazat';
  L_USERS_MODIFIY = 'Opravit';
  L_USERS_ACCOUNT = '��et';
  L_USERS_PASSWORD = 'Heslo';
  L_USERS_GROUP = 'Skupina';
  L_USERS_FIRSTNAME = 'K�estn� jm�no';
  L_USERS_MIDDLENAME = 'St�edn� jm�no';
  L_USERS_LASTNAME = 'P��jmen�';

  //IBF_Export
  L_EXPORT_FRM = 'Exportov�n�';
  L_EXPORT_ASCII = ' Form�t souboru ';
  L_EXPORT_FIXED = 'TXT z�znam pevn� d�lky';
  L_EXPORT_DELIMITED = 'CSV s odd�lova�em';
  L_EXPORT_DBF  = 'DBF  (jen pro testy)';
  L_EXPORT_ASCIIOPT  = ' ASCII volby ';
  L_EXPORT_DELIMITER  = 'Odd�lova� �et�zc�';
  L_EXPORT_SEPARATOR  = 'Separ�tor polo�ek';
  L_EXPORT_DATEFORMAT  = 'Tvar datumu';
  L_EXPORT_INCLUDEHEADERS  = 'V�etn� hlavi�ek';
  L_EXPORT_INCLUDECRLF  = 'V�etn� CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Textov� soubory CSV ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Textov� soubory ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF soubory ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Skute�n� chcete skon�it?';
  M_Fetching_Query_Results = 'Na��t�n� v�sledk� dotazu';
  M_Row_Num = '��dek# %d';
  M_Abort_Fetching_Btn = 'P�eru�en�';

  M_Login_Database = 'Datab�ze';
  M_Login_User = 'U�ivatel';
  M_Login_Password = 'Heslo';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Storno';
  M_Login_Help_Btn = '&N�pov�da';
  M_Login_Dialog_Caption = 'P�ihla�ovac� dialog';

  M_Loading_Caption = 'Nahr�v�n�...';

  M_SB_REC_CNT = 'Po�et z�znam�: %d';
  M_Save_Changes = 'Ulo�it zm�ny?';
  M_Abort_Changes = 'Zm�ny budou ztraceny. Opravdu zru�it zm�ny?';

  M_CancelTransactionPrompt = 'Opravdu chcete zru�it v�echny proveden� zm�ny?';

  M_SCRIPT_ABORT_EXECUTE = 'Skon�it zpracov�n� tohoto skriptu?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Pokra�ovat v zpracov�n� tohoto skriptu?';
  M_SCRIPT_IS_EXECUTING = 'Skript je zpracov�v�n';
  M_SCRIPT_FAILED = 'Skript skon�il ne�sp�n�';
  M_SCRIPT_WAS_ABORTED = 'Zpracov�n� skriptu bylo p�eru�eno';
  M_SCRIPT_COMPLETED = 'Skript byl zpracov�n bez v�jime�n�ch ud�lost�';
  M_SCRIPT_CMPL_EXCEPT = 'Skript byl zpracov�n, nastaly v�jime�n� ud�losti';
  M_SCRIPT_MODIFIED = 'Upraveno';
  M_SCRIPT_SAVE_CHANGES = 'Ulo�it zm�ny?';

{ Button captions }

  C_BTN_TODAY = 'Dnes';
  C_BTN_CLEAR = 'Vy�istit';
  C_BTN_FIND = 'Naj�t';
  C_BTN_FINDNEXT = 'Naj�t dal��';
  C_BTN_REPLACE = 'Nahradit';
  C_BTN_UNDO = 'Zp�t';
  C_BTN_CUT = 'Vyjmout';
  C_BTN_COPY = 'Kop�rovat';
  C_BTN_PASTE = 'Vlo�it';
  C_BTN_DELETE = 'Smazat';
  C_BTN_SELECTALL = 'Vybrat v�e';

  C_SG_Parameter = 'Parametr';
  C_SG_Field = 'Polo�ka';
  C_SG_Name = 'Jm�no';
  C_SG_Type = 'Typ';
  C_SG_Info = 'Informace';
  C_SG_Value = 'Hodnota';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Storno';
  C_BF_CANCEL_ACCEL = '&Storno';
  C_BF_APPLY = 'Pou��t';
  C_BF_HELP = 'N�pov�da';
  C_BF_EXECUTE = 'Prov�st';
  C_BF_CLOSE = 'Zav��t';
  C_BF_CLOSE_ACCEL = '&Zav��t';
  C_BF_FINISH = 'Konec';
  C_BF_FINISH_ACCEL = '&Konec';

  C_FRM_Ordering = 'T��d�n�';
  C_FRM_RESTRUCTURE = 'P�izp�soben� zobrazen�ch polo�ek';

  C_CB_WordWrap = 'Zarovn�n� slov';

  // IBF_SQL
  M_SQL_RowsAffected = 'Zm�n�n�ch z�znam�: ';
  M_SQL_RowsCounted = 'Po�et z�znam�: ';
  M_SQL_SessionBusy = 'Sezen� je zanepr�zdn�no';
  M_SQL_CompleteTransaction = 'Pros�m dokon�ete transakci';
  M_SQL_CannotDeleteDefaultGroup = 'Nem��ete smazat defaultn� skupinu';
  M_SQL_ReservedName = 'Toto jm�no je rezervov�no: ';
  M_SQL_BackSlashNotAllowed = 'Zp�tn� lom�tko nen� povoleno';
  M_SQL_BlankNameNotAllowed = 'Pr�zdn� jm�no nen� povoleno';
  M_SQL_RowsFetched = 'Na�teno z�znam�: ';
  M_SQL_ConfirmDBCreation = 'Skute�n� chcete vytvo�it tuto datab�zi?';
  M_SQL_ConfirmNoOtherDBSameName = 'Pros�m ujist�te se, �e neexitsuje datab�ze se stejn�m jm�nem.';
  M_SQL_ConfirmDBDrop = 'Jste si jist(�) �e chcete smazat tuto datab�zi?';
  M_SQL_ReConfirmDBDrop = 'Datab�ze bude nen�vratn� smaz�na.'+#13#10+#13#10'Skute�n� smazat?';
  M_SQL_AskFormName = 'Vlo�te jm�no dotazovac�ho formul��e:';
  M_SQL_AskGroupName = 'Vlo�te jm�no skupiny:';
  M_SQL_AskLayoutName = 'Vlo�te jm�no uspo��d�n�:';
  M_SQL_ConfirmGroupDeletion = 'Opravdu chcete smazat %s skupinu v�etn� v�ech pod��zen�ch polo�ek?';
  M_SQL_ConfirmLayoutDeletion = 'Opravdu chcete smazat toto %s uspo��d�n�?';
  M_SQL_RecursiveCopyNotAllowed = 'Nen� povolena rekurzivn� kopie';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Dvakr�t klikn�te na polo�ce nebo ji vyberte a stiskn�te Enter.';
  M_GCSQL_ParameterValue = 'Hodnota parametru';
  M_GCSQL_TypeAValueFor = 'Vlo�te hodnotu pro %s';
  M_GCSQL_ProcedureWithoutParams = 'Tato procedura nem� vstupn� parametry.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'DataPump proces st�le b��.';
  M_DP_ARE_YOU_SURE = 'Jste si jist(�)?';
  M_DP_SELECT_SOURCE_DB = 'V�b�r zdrojov� datab�ze';
  M_DP_SELECT_DEST_DB = 'V�b�r c�lov� datab�ze';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Vy�istit';
  M_USERS_COMPLETED_OK = 'Operarace skon�ila �sp�n�.';
  M_USERS_NO_CONNECTION = 'Nen� definov�no IB_Connection.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'P�i�adit t��d�c� polo�ky?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Za��tek exportu';
  M_EXPORT_STILL_ACTIVE = 'Export proces st�le b��.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Prohl�en� datab�ze';
  C_wbBrowseBtnCaption  = 'Prohl�en�';
  C_wbDSQLBtnHint       = 'Prov�d� p��kaz v datab�zi';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitoruje datab�zov� ud�losti';
  C_wbEventsBtnCaption  = 'Ud�losti';
  C_wbExportBtnHint     = 'Exportuje dataset z datab�ze';
  C_wbExportBtnCaption  = 'Export';
  C_wbDumpBtnHint       = 'Exportuje data z datab�ze';
  C_wbDumpBtnCaption    = 'DbExport';
  C_wbPumpBtnHint       = 'Naimportuje data z jin� datab�ze';
  C_wbPumpBtnCaption    = 'DbImport';
  C_wbWhoBtnHint        = 'Zji�t�n� p�ipojen�ch u�ivatel�';
  C_wbWhoBtnCaption     = 'Kdo';
  C_wbScriptBtnHint     = 'Proveden� skriptu';
  C_wbScriptBtnCaption  = 'Skript';
  C_wbExtractBtnHint    = 'Vytvo�en� DDL struktury';
  C_wbExtractBtnCaption = 'DDL-SQL';
  C_wbMonitorBtnHint    = 'Sledov�n� SQL a API vol�n�';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Lad�n� datab�zov� aktivity (profiler)';
  C_wbProfilerBtnCaption= 'Lad�n�';
  C_wbStatusBtnHint     = 'Prohl�en� stavu IB komponent';
  C_wbStatusBtnCaption  = 'Stav';
  C_wbUsersBtnHint      = 'Administrov�n� u�ivatel� DB serveru';
  C_wbUsersBtnCaption   = 'U�ivatel�';

  // Array grid
  C_AG_Row             = '��dek';
  C_AG_Column          = 'Sloupec';

  //IBF_Who
  C_WHO_FRM            = 'Kdo je p�ipojen';
  C_WHO_BTNAPPLY       = 'Aktualizace';

  C_NB_FIRST = 'Prvn�';
  C_NB_PRIOR = 'P�edchoz�';
  C_NB_NEXT = 'Dal��';
  C_NB_LAST = 'Posledn�';

  C_ST_Open = 'Otev��t';
  C_ST_Close = 'Uzav��t';
  C_ST_Prepare = 'Prepare';
  C_ST_Unprepare = 'Unprepare';
  C_ST_ReadOnly = 'Jen �ten�';
  C_ST_New = 'Nov�';
  C_ST_Post = 'Potvrzen�';
  C_ST_Cancel = 'Storno';
  C_ST_Delete = 'Smaz�n�';
  C_ST_Edit = 'Oprava';
  C_ST_RefreshKeys = 'Obnova kl���';
  C_ST_RefreshRows = 'Obnova z�znam�';
  C_ST_Refresh = 'Obnova';

{ Hints }

  H_UB_EDIT = 'Opravit z�znam';
  H_UB_INSERT = 'Vlo�it z�znam';
  H_UB_DELETE = 'Smazat z�znam';
  H_UB_REFRESH = 'Obnovit v�echny z�znamy (refresh)';
  H_UB_REFRESHKEYS = 'Obnovit kl��e z�znam� (refresh)';
  H_UB_REFRESHROWS = 'Obnovit z�znamy (refresh)';
  H_UB_REFRESHFILTROWS = 'Obnovit filtrovan� z�znamy (refresh)';
  H_UB_POSTSEARCH = 'Potvrdit podm�nku';
  H_UB_CANCELSEARCH = 'Stornovat podm�nku';
  H_UB_POSTEDIT = 'Potvrdit opravu';
  H_UB_CANCELEDIT = 'Stornovat opravu';
  H_UB_POSTINSERT = 'Potvrdit vlo�en�';
  H_UB_CANCELINSERT = 'Stornovat vlo�en�';
  H_UB_POSTDELETE = 'Potvrdit smaz�n�';
  H_UB_CANCELDELETE = 'Stornovat smaz�n�';
  H_UB_POST = 'Ulo�it zm�ny';
  H_UB_CANCEL = 'Stornovat zm�ny';

  H_NB_FIRST = 'Prvn� z�znam';
  H_NB_PRIOR = 'P�edchoz� z�znam';
  H_NB_NEXT = 'Dal�� z�znam';
  H_NB_LAST = 'Posledn� z�znam';
  H_NB_JUMPBCK = 'Zp�t';
  H_NB_JUMPFWD = 'Vp�ed';

  H_SB_ORDER = 'T��d�n� z�znam� v datasetu';
  H_SB_LAST_CRITERIA = 'Obnovit posledn� podm�nku';
  H_SB_SEARCH = 'Hledat v datasetu';
  H_SB_SAVE_CRITERIA = 'Ulo�it podm�nku';
  H_SB_CLEAR_CRITERIA = 'Smazat podm�nku';
  H_SB_RECALL_CRITERIA = 'Obnovit ulo�enou podm�nku';
  H_SB_SEARCHCOUNT = 'Po�et z�znam� v datasetu odpov�daj�c�ch podm�nce';
  H_SB_COUNT = 'Po�et z�znam� v datasetu';
  H_SB_RESTRUCTURE = 'P�izp�soben� zobrazen�ch polo�ek';

  H_TB_StartTransaction = 'Nastartovat transakci (Start)';
  H_TB_PostDatasets = 'Ulo�it dataset (Post)';
  H_TB_CancelDatasets = 'Storno datasetu (Cancel)';
  H_TB_SavePoint = 'Potvrdit zm�ny a pokra�ovat v aktivn� transakci (Commit, Retain)';
  H_TB_CommitRetain = 'Ulo�it dataset, potvrdit zm�ny a pokra�ovat v aktivn� transakci (Post, Commit, Retain)';
  H_TB_Commit = 'Potvrdit zm�ny a ukon�it aktivn� transakci (Commit, End)';
  H_TB_Rollback = 'Vr�tit zm�ny a ukon�it aktivn� transakci (Rollback, End)';
  H_TB_RollbackRetain = 'Vr�tit zm�ny a pokra�ovat v aktivn� transakci (Rollback, Retain)';
  H_TB_Close = 'Uzav��t aktivn� transakci (End)';

  H_ST_Prepare_Statement = 'Prov�st Prepare p��kazu';
  H_ST_Unprepare_Statement = 'Prov�st Unprepare p��kazu';
  H_ST_Execute_Statement = 'Spustit p��kaz';

  H_DS_Open_Dataset = 'Otev��t dataset';
  H_DS_Close_Dataset = 'Uzav��t dataset';
  H_DS_Prepare_Dataset = 'Prov�st Prepare datasetu';
  H_DS_Unprepare_Dataset = 'Prov�st Unprepare datasetu';
  H_DS_ReadOnly_Dataset = 'Dataset jen na �ten�';

  H_CB_Create_Database = 'Vytvo�en� datab�ze';
  H_CB_Connect_Database = 'P�ipojen� datab�ze';
  H_CB_Disconnect_Database = 'Odpojen� datab�ze';
  H_CB_Drop_Database = 'Smaz�n� datab�ze';

  H_RD_actHide = 'Skr�t vybran� polo�ky';
  H_RD_actHideAll = 'Skr�t v�echny polo�ky';
  H_RD_actVisible = 'Zobrazit vybran� polo�ky';
  H_RD_actVisibleAll = 'Zobrazit v�echny polo�ky';
  H_RD_actUp = 'P�esunout vybran� polo�ky v��e';
  H_RD_actTop = 'P�esunout vybran� polo�ky �pln� nahoru';
  H_RD_actDown = 'P�esunout vybran� polo�ky n�e';
  H_RD_actBottom = 'P�esunout vybran� polo�ky �pln� dol�';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Export prost�ednictv�m SELECT p��kazu';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Nen� zad�no jm�no ascii souboru';
  eNoDestTableEntry          = 'Nen� zad�na v�stupn� tabulka';
  eAsciiFileNotFound         = 'Ascii soubor %s nebyl nalezen';
  eIniFileNotFound           = 'Ini-soubor %s nebyl nalezen';
  eNoAsciiFileAccess         = 'Nemohu otev��t ascii soubor %s';
  eInvalidCharFound          = 'Chybn� znak / form�t v ascii souboru';
  eOutOfMemory               = 'Nedostatek pam�ti';
  eFieldDescriptionError     = 'Chyba v popisu polo�ky';
  eWrongAsciiFieldCount      = 'Chybn� po�et polo�ek v ascii souboru';
  eWrongDecimalCount         = 'Chybn� po�et desetinn�ch m�st v seznamu polo�ek (%s)';
  eWrongFieldWidth           = 'Chybn� d�lka polo�ky v ascii souboru';

  // Metadata Extract Stuff
  // ------------------------

  // Entity Type Names
  STR_DDL_UnnamedItem = '<NEPOJM.>';
  STR_DDL_etDatabase = 'Datab�ze';
  STR_DDL_etException = 'V�jimka';
  STR_DDL_etBlobFilter = 'Blob Filtr';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Gener�tor';
  STR_DDL_etDomain = 'Dom�na';
  STR_DDL_etTable = 'Tabulka';
  STR_DDL_etView = 'Pohled (View)';
  STR_DDL_etProcedure = 'Procedura';
  STR_DDL_etRole = 'Role';
  STR_DDL_etPrimaryKey = 'Primarn� kl��';
  STR_DDL_etUniqueKey = 'Unik�tn� kl��';
  STR_DDL_etForeignKey = 'Ciz� kl��';
  STR_DDL_etConstraint = 'Omezen� (Constraint)';
  STR_DDL_etIndex = 'Index';
  STR_DDL_etTrigger = 'Trigger';
  STR_DDL_etPermission = 'Pr�vo';
  STR_DDL_etUDFParam = 'UDF Parametr';
  STR_DDL_etTableField = 'Polo�ka tabulky';
  STR_DDL_etViewField = 'Polo�ka pohledu (view)';
  STR_DDL_etProcParam = 'Parametr procedury';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Vytvo�en� datab�ze';
  STR_DDL_coSecondaryFiles = 'Definice sekund�rn�ch soubor�';
  STR_DDL_coDefineShadows = 'Definice Shadow soubor�';
  STR_DDL_coSetGeneratorVal = 'Nastaven� hodnoty gener�toru';
  STR_DDL_coResetExceptionNo = 'Nastaven� ��sla v�jimky';
  STR_DDL_coRawFieldDefs = 'Definice polo�ky';
  STR_DDL_coIsolateAllComputed = 'Izoluj v�echny vypo�ten� polo�ky';
  STR_DDL_coReportMinor = 'Sestava Minor';
  STR_DDL_coAlwaysQuoted = 'V�dy uvozovky';
  STR_DDL_coAlwaysCharSet = 'V�dy definice znakov� sady';
  STR_DDL_coIncludeDebug = 'V�etn� koment��� lad�n�';
  STR_DDL_coDescripAsComment = 'Popisy jako koment��e';
  STR_DDL_coIgnoreDependencies = 'Ignoruj vazby';
  STR_DDL_coKeepCustomIndexNames = 'Zachovej u�ivatelsk� jm�na index�';

  // CodePass Names
  STR_DDL_cpFull = 'Pln�';
  STR_DDL_cpInit = 'Po��te�n�';
  STR_DDL_cpFinal = 'Kone�n�';
  STR_DDL_cpAuto = 'Automatick�';

  // Problem level names
  STD_DDL_plNone       = 'Nic';
  STD_DDL_plMinor      = 'Malo';
  STD_DDL_plSuspicious = 'Podez�en�';
  STD_DDL_plWarning    = 'Varov�n�';
  STD_DDL_plError      = 'Chyba';
  // abbreviated Problem level names (to 5 characters)
  STD_DDL_plNone_s       = 'NIC ';
  STD_DDL_plMinor_s      = 'MALO ';
  STD_DDL_plSuspicious_s = 'PDZRN';
  STD_DDL_plWarning_s    = 'VAROV';
  STD_DDL_plError_s      = 'CHYBA';

  // Dialog strings
  STR_DDL_DialogCaption = 'Z�sk�n� metadat';
  STR_DDL_Configure = 'Konfigurace';
  STR_DDL_Filters = 'Filtry';
  STR_DDL_Script = 'Skripty';
  STR_DDL_MetadataControls = 'Metadata ovl�d�n�';
  STR_DDL_CodeOptions = 'Volby k�d�';
  STR_DDL_Entities = 'Entity';
  STR_DDL_Terminator = 'Termin�tor';
  STR_DDL_InsertCommits = 'Vkl�dej COMMIT';
  STR_DDL_ExecuteControls = 'Prov�d�n� ovl�d�n�';
  STR_DDL_CodePass = 'Pr�b�h k�du';
  STR_DDL_ExtractToStrings = 'Z�sk�n� do �et�zc�';
  STR_DDL_Reset = 'Reset';
  STR_DDL_ResetAll = 'Reset v�eho';
  STR_DDL_ProgressControls = 'Pr�b�h ovl�d�n�';
  STR_DDL_Stop = 'Zastav';
  STR_DDL_IncludeSystem = 'V�etn� syst�mov�ch objekt�';
  STR_DDL_NameMasks = 'Maskov�n� jmen';
  STR_DDL_SaveToFile = 'Ulo�it do souboru';
  STR_DDL_RunScript = 'Spus� skript';
  STR_DDL_ScriptCommands = '&Skript p��kazy';


  // Errors/Problems reported during extract processing
  // Note that all replaceable parameters use %s (string), any necessary
  // conversions will be performed in the code.
  E_DDL_CURSOR_NOT_CREATED = 'Kurzor nevytvo�en';
  E_DDL_BLANK_NAME         = 'Pr�zdn� jm�no';
  E_DDL_ENTITY_NOT_FOUND   = 'Entita nenalezena';
  E_DDL_RESERVED_NAME      = 'Rezervovan� jm�no v nesyst�m. entit�';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Datab�zov� znak.sada %s nebyla nalezena';
  E_DDL_MODULE_NAME_EMPTY  = 'Pr�zdn� jm�no modulu';
  E_DDL_ENTRY_POINT_EMPTY  = 'Pr�zdn� jm�no vstupn�ho bodu';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'Jen extern� dom�na sm� b�t implicitn�';
  E_DDL_DOMAIN_TYPE_16     = 'Typ 16 m��e b�t jen NUMERIC �i DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'ID znakov� sady je NULL, bude NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Chybn� jm�no pro ID znakov� sady %s, bude NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'Po�et bajt� na znak je pro znakovou sadu %s nulov�';
  E_DDL_FIELDLEN_MISMATCH  = 'D�lka polo�ky %s mus� b�t d�liteln� %s bajty na znak ve znakov� sad� %s';
  E_DDL_INVALID_COLLATIONID = 'Id t��d�n� nesm� b�t < 0 ale je %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Id t��d�n� je NULL, bude %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Nezn�m� typ polo�ky %s';
  E_DDL_CSTRING_IN_DSQL = 'Typ CSTRING nen� akceptov�n v DSQL';
  E_DDL_QUAD_IN_DSQL = 'Typ QUAD nen� akceptov�n v DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Podez�el� kontrola: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Deklarovan� ale pr�zdn� kontrola omezen�';
  E_DDL_EXPLICIT_COMPUTED = 'Explicitn� dom�na nem��e b�t COMPUTED';
  E_DDL_VOID_COMPUTED = 'Declarovan� ale pr�zdn� COMPUTED BY klauzule';
  E_DDL_SUSPICIOUS_DEFAULT = 'Podez�el� defaultn� hodnota: %s';
  E_DDL_VOID_DEFAULT = 'Deklarovan� ale pr�zdn� defaultn� hodnota';
  E_DDL_DIMENSIONS_MISMATCH = 'Deklarov�n %s rozm�r ale nalezen detail pro %s rozm�r.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Implicitn� dom�na nem� vazbu.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Implicitn� dom�n� chyb� vazba nebo jm�no polo�ky.';
  E_DDL_NO_OUTPUT_PARAMETER = 'Nen� v�stupn� parametr';
  E_DDL_NO_GRANTOR = 'Nen� specifikov�n postupovatel (Grantor)';
  E_DDL_VIEW_NO_BLR = 'Nen� view_blr ale objevuje se v rdb$view_relations jako VIEW';
  E_DDL_VIEW_NO_VIEW_RELATION = 'Je view_blr ale neobjevuje se v rdb$view_relations jako VIEW';
  E_DDL_NO_OWNER = 'Nen� specifikov�no jm�no vlastn�ka';
  E_DDL_FORMAT_VERSION = 'Verze form�tu v %s';
  E_DDL_DBKEY_LEN = 'DbKey_Length mus� b�t 8 ale je %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'Definice dom�ny/polo�ky pro polo�ku %s nenalezena';
  E_DDL_NO_SOURCE_CODE = 'Nen� dostupn� zdrojov� k�d';
  E_DDL_WITH_CHECK_COMPLETION = '"With check" dopln�n do "with check option"';
  E_DDL_NO_BLR = 'Nen� dostupn� BLR';
  E_DDL_CORRUPT_SOURCE = 'Zdrojov� prefix nebyl rozpozn�n, m��e to indikovat po�kozen�';
  E_DDL_INDEX_ID_NULL_INACTIVE = 'Id je NULL a index je neaktivn�';
  E_DDL_INDEX_ID_NULL_ACTIVE = 'Id je NULL ale index je aktivn�';
  E_DDL_INVALID_INDEX_ID = 'Id mus� za��nat na 1, ne na %s';
  E_DDL_FK_INDEX_NO_CONSTRAINT = 'Deklarov�n ciz� kl�� ale nen� nalezen v rela�n�ch omezen�ch jako FK index';
  E_DDL_CONSTRAINT_NO_FK_INDEX = 'Nen� deklarov�n ciz� kl�� ale v rela�n�ch omezen�ch existuje jako FK index';
  E_DDL_INDEX_MULTI_USE = 'V�cen�sobn� sou�asn� pou�it� v %s rela�n�m omezen�';
  E_DDL_INDEX_NO_FIELDS = 'Pou��v� %s polo�ky';
  E_DDL_INDEX_DUPLICATE = 'Zji�t�na duplicitn� definice indexu pro tabulku: %s';
  E_DDL_INDEX_SEG_MISMATCH = 'Index na tabulku: %s deklarov�no %s segment�, ale detaily pro %s segment� bylo nalezeno';
  E_DDL_CONSTRAINT_OUT_OF_RANGE = 'Omezen� typu %s je mimo rozsah';
  E_DDL_CONSTRAINT_USING_INDEX = 'Omezen� typu %s nesm� pou��vat index ale pou��v� index: %s';
  E_DDL_CONSTRAINT_NO_INDEX = 'Omezen� typu %s mus� pou��t index ale nepou��v� jej';
  E_DDL_UPDATE_RULE_INVALID = 'Opravn� pravidlo %s je mimo rozsah';
  E_DDL_DELETE_RULE_INVALID = 'Mazac� pravidlo %s je mimo rozsah';
  E_DDL_PARENT_CONSTRAINT_EMPTY = 'Jm�no omezen� pro rodi�ovskou vazbu je pr�zdn�';
  E_DDL_FOREIGN_NOT_DEFINED = 'Ciz� tabulka nebo index nejsou definov�ny';
  E_DDL_PARENT_SHOULD_BE_EMPTY = 'Jm�no omezen� pro rodi�ovskou vazbu mus� b�t pr�zdn� ale je %s';
  E_DDL_UPDATE_SHOULD_BE_EMPTY = 'Opravn� pravidlo mus� b�t pr�zdn� ale je %s';
  E_DDL_DELETE_SHOULD_BE_EMPTY = 'Mazac� pravidlo mus� b�t pr�zdn� ale je %s';
  E_DDL_NO_BLR_WITH_CHECK =  'Nen� dostupn� zdrojov� k�d,pravd�podobn� u�it pro view %s with check option';
  E_DDL_TRIGGER_LOST_CHECK = 'Nalozeno "CHECK" kl��ov� slovo. Pou�ito kontroln� omezen� kter� bylo ztraceno';
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Nezn�m� typ triggeru %s';
  E_DDL_NEGATIVE_SEQUENCE = 'Nalezena z�porn� sekvence %s';
  E_DDL_NO_TARGET_RELATION = 'C�lov� tabulka nebo view nen� ur�ena';
  E_DDL_NOT_IN_DEPENDENCIES = 'Deklarov�no ale nenalezeno ve vazb�ch. V n�kter�ch p��padech to nen� chyba';
  E_DDL_SUSPICIOUS_TRIGGER = 'Podez�el� trigger z�vis� na jin�ch tabulk�ch ale nen� k nim p�ipojen';
  E_DDL_INVALID_TRIGGER_SEQ = 'Trigger sekvence je %s ale mus� b�t men�� ne� 1 pro implicitn� trigger';
  E_DDL_GRANT_OUT_OF_RANGE = 'Grant/Admin volba mimo 0..2 rozsah: %s';
  E_DDL_GRANT_TO_USER_TYPE = 'Grant/Admin volba d�v� pro u�ivatele typ %s';
  E_DDL_GRANT_FIELDS = 'Zkou��m nastavit polo�ky ale pr�vo nen� U nebo R';
  E_DDL_EXECUTE_TO_OBJECT = 'P�i�azuji EXECUTE na objekt typu %s kter� mus� b�t 5 (proc)';
  E_DDL_BAD_PRIV_ON_PROC = 'P�i�azuji %s pro proceduru %s';
  E_DDL_MEMBER_TO_OBJECT = 'P�i�azuji vlastnictv� pro objekt typu %s kter� mus� b�t 13 (role)';
  E_DDL_BAD_PRIV_ON_ROLE = 'P�i�azuji %s pro roli %s';
  E_DDL_BAD_ARG_POS =  'Pozice argumentu mus� b�t >=0 ale je %s';
  E_DDL_SYSTEM_FLAG_MISMATCH = 'SystemFlag se odli�uje od rodi�e';
  E_DDL_BAD_FIELD_ID = 'Id polo�ky mus� b�t >=0 ale je %s';
  E_DDL_BAD_FIELD_POS = 'Pozice polo�ky mus� b�t >=0 ale je %s';
  E_DDL_BAD_TABLE_BASEFIELD = 'BaseField mus� b�t pr�zdn� pro tabulky ale je %s';
  E_DDL_BAD_TABLE_VIEWCONTEXT = 'ViewContext mus� b�t pr�zdn� pro tabulky ale je %s';
  E_DDL_MANDATORY_IN_VIEW = 'Nem��e b�t povinn� ve view';
  E_DDL_BASEFIELD_EMPTY = 'BaseField nesm� b�t pr�zdn� pro views p�i ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext nem��e b�t pr�zdn� pro views';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext mus� b�t >= 0 pro views';
  E_DDL_BAD_PARAM_TYPE = 'Typ parametru %s mimo rozsah';
  E_DDL_BAD_PARAM_NUM = '��slo parametru mus� b�t >=0 ale je %s';

  // Comments output with DDL statements
  C_DDL_CONNECT_USERNAME   = 'P�ipojen� jako: %s';
  C_DDL_CONNECT_SERVER_VER = 'a server: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'Bez sekund�rn�ch soubor�';
  C_DDL_SEC_FILES = 'Sekund�rn� soubory';
  C_DDL_SEC_FILE_DESC = '%s, Start: %s, D�lka: %s';
  C_DDL_NO_SHADOW_FILES = 'Bez st�nov�ch soubor�';
  C_DDL_SHADOW_FILES = 'St�nov� soubory';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, Start: %s, D�lka: %s';
  C_DDL_EXCEPTION_DESC = 'V�jimka: %s, P�vodn� ��slo: %s';
  C_DDL_FIELD_NOT_FOUND = 'Polo�ka nenalezena: %s';
  C_DDL_INDEX_NOT_FOUND = 'Index nenalezen';
  C_DDL_NO_FOREIGN_RELATION = 'Nen� ciz� vazba nebo index pro omezen�';
  C_DDL_FOREIGN_NOT_FOUND = 'Ciz� vazba nenalezena: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Ciz� kl�� nenalezen: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Trigger nenalezen: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Chybn� jm�no omezen�: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'Bez zdroje pro trigger: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'Typ Trigger nezn�m�: %s';
  C_DDL_BAD_PRIVILEGE = 'Nezn�m� pr�vo: %s';


implementation

end.
