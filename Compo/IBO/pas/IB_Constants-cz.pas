
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

  IB_REG_MESSAGE = 'D�kuji za testov�n� IB Objects.'#13#10#13#10'Nav�tivte, pros�m, http""//www.ibobjects.com a ihned se zaregistrujte.';  //'Thanks for evaluating IB Objects.'#13#10#13#10'Please go to http://www.ibobjects.com and register today.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Spojen� ji� bylo nav�z�no';  //'Connection has already been established';
  E_NOT_CONNECTED     = 'Spojen� nebylo nav�z�no';  //'Connection has not been established';
  E_Invalid_conn_path = 'Neplatn� cesta k datab�zi';  //'Invalid connection path';
  E_Cant_Repl_Int_Tr  = 'Nelze standardn� nahradit intern� transakci';  //'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Transakce nebyla spu�t�na';  //'Transaction has not been started';
  E_TRANS_STARTED     = 'Transakce ji� byla spu�t�na';  //'Transaction has already been started';
  E_NO_CONNECTIONS    = 'Transakce nem� ��dn� spojen�';  //'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Transakce nem� jedno nebo v�ce spojen�';  //'Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Varov�n�: Spojen� se st�le p�ipravuje';  //'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'V�echna spojen� mus� b�t ve stejn� IB_Session';  //'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Transakce je p�eru�ena';  //'Transaction is Paused';
  E_ALLOCATED         = 'P��kaz ji� byl alokov�n';  //'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'P��kaz nebyl alokov�n';  //'Statement has not been allocated';
  E_PREPARED          = 'P��kaz ji� byl p�ipraven';  //'Statement has already been prepared';
  E_NOT_PREPARED      = 'P��kaz nebyl p�ipraven';  //'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'P��prava p��kazu selhala';  //'Statement failed to prepare';
  E_OPENED            = 'P��kaz ji� byl proveden';  //'Statement has already been opened';
  E_NOT_OPENED        = 'P��kaz nebyl proveden';  //'Statement has not been opened';
  E_CANT_DELETE       = 'Aktu�ln� z�znam kurzoru nelze smazat';  //'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'P��kaz mus� m�t p�i�azeno spojen�';  //'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'Nepoda�ilo se otev��t IB_Connection';  //'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Mus� byt p�i�azena IB_Transaction';  //'Must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'K proveden� nen� ��dn� aktivn� transakce';  //'No active transaction to execute with';
  E_START_FAILED      = 'Nepoda�ilo se spustit transakci';  //'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'Nen� povolena Explicitn� transakce s ServerAutoCommit';  //'Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate     = 'Neplatn� stav transakce. Nelze aktivovat';  //'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transakce m� nepotvrzen� zm�ny';  //'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Potvrzen� v�ech dataset� selhalo';  //'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Storno v�ech dataset� selhalo';  //'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Nelze aktualizovat, %s nen� vlastn�no vlastn�kem %s';  //'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'Pr�znd� SQL p��kaz nen� povolen';  //'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Konec souboru';  //'At end of file';
  E_AT_END_OF_CURSOR  = 'Konec kurzoru';  //'At end of cursor';
  E_AT_END_OF_BUFFER  = 'Konec bufferu';  //'At end of buffer';
  E_AT_END_OF_DATASET = 'Konec datasetu';  //'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'Neo�ek�van� d�lka v in isc_dsql_sql_info';  //'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Data vr�cen� z isc_dsql_sql_info jsou neplatn�';  //'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Nelze m�nit jm�no aktivn�ho kurzoru';  //'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Nelze m�nit RequestLive, pokud je aktivn�';  //'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'Nelze nastavit RequesLive pro ReadOnly dataset';  //'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI              = 'IB_CURSOR je jednosm�rn�';  //'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Nepodporovan� typ sloupce: %d';  //'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND         = 'Pole �.: %d nenalezeno';  //'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = 'Pole: %s nenalezeno';  //'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = 'Neplatn� zam��en� relace �.: %d';  //'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Neplatn� jm�no zam��en� relace: %s';  //'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = 'Syntaktick� chyba IN( value [ , value ... ] )';  //'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = 'Syntaktick� chyba BETWEEN value AND value';  //'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Nepoda�ilo se nal�zt DLL import %s';  //'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Neplatn� vlastnost SQLKeyFields';  //'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR       = 'Nelze otev��t kurzor bez dat kl��e';  //'Cannot open cursor without key data';
  E_SCROLL_ERROR           = 'Kl��e z�znamu byly ztraceny'#13#10'Kurzor nelze otev��t';  //'Record key was lost'#13#10'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Neplatn� BufferRowNum p�ed za��tkem';  //'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT      = 'Nelze p�ipravit pr�zdn� p��kaz';  //'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT   = 'Pokus o proveden� nezn�m�ho p��kazu';  //'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Vz�jemn� reference nen� povolena';  //'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = 'Nelze zm�nit, pokud je spojen� aktivn�';  //'Cannot change while connected';
  E_LOGIN_FAILED      = 'P�ihl�en� selhalo';  //'Login failed';
  E_CANT_GET_CONN_CHR = 'Nelze zjistit vlastnosti p�ipojen�';  //'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = 'Maximum ud�lost� na jeden blok p�ekro�eno';  //'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Prov�d�j� se ud�losti'#13#10'Nelze prov�st odhl�en�';  //'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'Blob ji� byl ulo�en a nebo nelze ulo�it';  //'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'Blob ji� byl otev�en a nebo nelze otev��t';  //'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW ='Nelze stornovat aktu�lnn� z�znam';  // 'Cannot cancel current Row';
  E_CANNOT_POST_ROW  = 'Nelze potvrdit aktu�ln� z�znam';  //'Cannot Post current Row';
  E_DatasetClosed     = 'Dataset nen� aktivn�';  //'Dataset is inactive';
  E_DatasetOpen        = 'Dataset je pr�v� otev�en';  //'Dataset is currently open';
  E_DatasetCannotScroll = 'Dataset nem��e rolovat';  //'Dataset cannot scroll';
  E_DatasetReadOnly     = 'Dataset je pro �ten�';  //'Dataset is readonly';
  E_DatasetIsFetching    = 'Dataset pr�v� natahuje z�znamy';  //'Dataset is currently fetching';
  E_Invalid_KeyRelation   = 'Neplatn� hodnota KeyRelation';  //'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNum nen� zat�m implementov�no';  //'RowNum is not implemented yet';
  E_RowDeleted            = '��dek se pr�v� ma�e';  //'Row is being deleted';
  E_END_OF_DATASET        = 'Konec datasetu';  //'At end of Dataset';
  E_BEGINNING_OF_DATASET   = 'Za��tek datasetu';  //'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Nelze pou��vat pessimistick� zamyk�n� sou�asn� s LockWait';  //'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row      = 'Nelze editovat aktu�ln� z�znam';  //'Cannot Edit current Row';
  E_Cannot_Insert_Row  = 'Nelze vlo�it nov� z�znam';  //'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Nelze smazat aktu�ln� z�znam';  //'Cannot delete current Row';
  E_Cannot_Search    = 'Hled�n� nen� povoleno';  //'Searching is not allowed';
  E_Cannot_Navigate = 'Nelze se posunout';  //'Cannot navigate';
  E_Record_Locked    = 'Z�znam je uzam�en jin�m u�ivatelem';  //'Record is locked by another user';
  E_Record_OutOfSynch = 'Z�znam byl zm�n�n jin�m u�ivatelem';  //'Record was changed by another user';
  E_FLD_READONLY       = '%s je jen pro �ten�';  //'%s is readonly';
  E_Required_Field       = '%s je po�adovan� pole';  //'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Nelze pou��t PostRetaining sou�asn� s Cached Updates';  //'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'V�ce ��dk� v jedin�m z�znamu';  //'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Neplatn� buffer RowsAffected';  //'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Neplatn� hodnota RowNum za Eof';  //'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Neplatn� hodnota RowNum p�ed Bof';  //'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Neplatn� �et�zec Bookmark';  //'Invalid Bookmark String';

  E_Assign_Column  = 'Nelze p�i�adit z %s';  //'Cannot assign from %s';
  E_AssignTo_Column = 'Nelze p�i�adit k %s';  //'Cannot assign to %s';
  E_Value_Out_Of_Range = 'Hodnota mimo rozsah';  //'Value out of range';
  E_SmallintOverflow = 'P�ete�en� hodnoty typu smallint';  //'Smallint overflow';

  E_Unsupported_Column = 'Nepodporovan� typ sloupce" %d';  //'Unsupported Column type: %d';
  E_UndefinedMacro = 'Nedefinovan� makro';  //'Undefined macro';
  E_GeneratorFailed = 'Nepoda�ilo se z�skat hodnotu gener�toru';  //'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'Je nutn� TIB_BDataset rodi� (IB_Query)';  //'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Nelze m�nit ReadOnly po startu';  //'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Nelze m�nit Isolation po startu';  //'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Nelze m�nit RecVersion po startu';  //'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'Nelze m�nit LockWait po startu';  //'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Neplatn� reference na Delete';  //'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53bit integer overflow';
  E_Invalid_Typecast = 'Neplatn� p�etypov�n�';  //'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Neplatn� typ p��kazu pro DataPump';  //'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'Pole NOT NULL nastaveno na hodnotu NULL';  //'NOT NULL field set to null value';
  E_DATABASE_BLANK = 'Jm�no datab�ze nesm� b�t pr�zdn�';  //'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Nepodporovan� konverze sloupce';  //'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Nepoda�ilo se nal�zt z�znam';  //'Unable To Locate Record';
  E_Record_Not_Inserted = 'Z�znam nebyl vlo�en';  //'Record was not inserted';
  E_Invalid_KeyLinks = 'Neplatn� hodnota KeyLinks" %s';  //'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Nepoda�ilo se prov�st vyhled�v�n�';  //'Unable to perform search';
  E_Unassigned_Blob_Node = 'Nep�i�azen� BlobNode';  //'Unassigned BlobNode';
  E_Unassigned_Transaction = 'Nep�i�azen� Transakce';  //'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Neplatn� buffer RowsAffected';  //'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Nepoda�ilo se ulo�it grafiku';  //'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Nelze aktivovat transakci';  //'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'Knihovna Interbase klient GDS32.DLL nen� nainstalov�na';  //'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Nelze otev��t memo polo�ku';  //'Could not load memo';
  E_Invalid_DPB_Over_255 = 'Neplatn� DPB: Obsahuje v�ce ne� 255 znak�';  //'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Neplatn� custom DML column reference: %s';  //'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Z�znam nebyl nalezen a aktualizov�n';  //'Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Z�znam nebyl nalezen a smaz�n';  //'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'Nepoda�ilo se inicializovat default %s';  //'Unable to initialize default %s';
  E_Stringlist_Not_Sorted = 'Pro tuto operaci mus� b�t Stringlist se�azen';  //'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Nelze m�nit ud�losti za b�hu';  //'Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Nelze zru�it registraci ud�lost� za b�hu';  //'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Neplatn� intern� IB_Transakce';  //'Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Neplatn� typ p��kazu';  //'Invalid statement type';
  E_Multiple_Records_Updated = 'Z�znamy hromadn� aktualizov�ny';  //'Multiple records updated';
  E_Multiple_Records_Deleted = 'Z�znamy hromadn� smaz�ny';  //'Multiple records deleted';
  E_Multiple_Records_Inserted = 'Z�znamy hromadn� vlo�eny';  //'Multiple records inserted';
  E_DUP_DB_NAME = 'Duplicitn� DatabaseName nen� povoleno';  //'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Neplatn� DatabaseName';  //'Invalid DatabaseName';
  E_UnableToSearch = 'Nepoda�ilo se prov�st vyhled�v�n�';  //'Unable to perform search';
  E_NoRecordsFound = 'Nenalezy ��dn� z�znamy';  //'No records found';
  E_Session_Undefined = 'Session je nedefinov�no';  //'Session is undefined';
  E_NoCircularRef = 'Vz�jemn� reference nen� povolena';  //'Circular reference not allowed';
  E_InvalidClassType = 'Neplatn� typ t��dy';  //'Invalid class type';
  E_Invalid_RowNum = 'Neplatn� ��slo ��dku';  //'Invalid RowNum';
  E_Invalid_Syntax = 'Neplatn� syntaxe: p�ebyte�n� nebo chyb�j�c� z�vorky';  //'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Pole je Null';  //'Array is Null';

  E_Cannot_add_blank_account = 'Nelze p�idat pr�zdn� ��et';  //'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'Nelze p�idat ��et SYSDBA';  //'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Nelze smazat pr�zdn� ��et';  //'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'Nelze smazat ��et SYSDBA';  //'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Nelze m�nit pr�zdn� ��et';  //'Cannot modify blank account';

  E_PLAN_ERROR = 'Chyba Pl�nu';  //'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'V�jimka Pl�nu';  //'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Neplatn� syntaxe CREATE, CONNECT nebo DROP DATABASE';  //'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Nepodporov�no';  //'Unsupported';
  E_NotImplemented = 'V t�to �rovn� neimplementov�no';  //'Not implemented at this level';
  E_Invalid_ColData = 'Neplatn� ColData';  //'Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Nelze zru�it p��pravu prob�haj�c�ho procesu';  //'Cannot Unprepare an executing process';
  E_FileName_Required = 'Je vy�adov�no jm�no souboru';  //'Filename is required';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Spr�va u�ivatelsk�ch ��t�';  //'User Account Management';
  L_USERS_ADD = 'P�idat';  //'Add';
  L_USERS_DELETE = 'Smazat';  //'Delete';
  L_USERS_MODIFIY = 'Opravit';  //'Modify';
  L_USERS_ACCOUNT = '��et';  //'ACCOUNT';
  L_USERS_PASSWORD = 'Heslo';  //'Password';
  L_USERS_GROUP = 'Skupina';  //'Group';
  L_USERS_FIRSTNAME = 'Jm�no';  //'First Name';
  L_USERS_MIDDLENAME = 'Alias';  //'Middle Name';
  L_USERS_LASTNAME = 'P��jmen�';  //'Last Name';

  //IBF_Export
  L_EXPORT_FRM = 'Export';
  L_EXPORT_ASCII = 'Form�t souboru';  //' File Format ';
  L_EXPORT_FIXED = 'TXT s pevnou d�lkou z�znamu';  //'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV odd�lova�';  //'CSV Delimited';
  L_EXPORT_DBF  = 'DBF (nutno je�t� testovat)';  //'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = 'ASCII nastaven�';  //' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Delimiter';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Form�t datumu';  //'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'V�etn� hlavi�ek';  //'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'V�etn� CRLF';  //'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = '��rkou odd�len� textov� soubor ( *.CSV )|*.CSV';  //'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Textov� soubory ( *.TXT )|*.TXT';  //'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF soubory';  //'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Chcete opravdu skon�it';  //'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Natahuji z�znamy z datab�ze';  //'Fetching Query Results';
  M_Row_Num = '��dek �.%d';  //'Row# %d';
  M_Abort_Fetching_Btn = 'P�eru�it';  //'Abort';

  M_Login_Database = 'Datab�ze';  //'Database';
  M_Login_User = 'U�ivatel';  //'User';
  M_Login_Password = 'Heslo';  //'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Storno';  //'Cancel';
  M_Login_Help_Btn = 'N�pov�da';  //'&Help';
  M_Login_Dialog_Caption = 'P�ihl�en�';  //'Login Dialog';

  M_Loading_Caption = 'Otev�r�m...';  //'Loading...';

  M_SB_REC_CNT = 'Po�et z�znam�: %s';  //'Records counted: %d';
  M_Save_Changes = 'Ulo�it zm�ny?';  //'Save changes?';
  M_Abort_Changes = 'Zm�ny nebudou ulo�eny. Chtete-li pokra�ovat, klikn�te na Ok';  //'Changes will be lost. Ok to proceed?';

  M_CancelTransactionPrompt = 'Opravdu chcete stornovat v�echny zm�ny?';  //'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'P�eru�it vykon�v�n� tohoto skriptu?';  //'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Pokra�ovat ve vykon�v�n� tohoto skriptu?';  //'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Skript je pr�v� vykon�v�n';  //'Script is currently executing';
  M_SCRIPT_FAILED = 'Skript nebyl dokon�en';  //'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Vykon�v�n� skriptu bylo p�eru�eno';  //'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Skript byl dokon�en bez vyj�mek';  //'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Skript byl dokon�en s vyj�mkami';  //'Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'Zm�n�no';  //'Modified';
  M_SCRIPT_SAVE_CHANGES = 'Ulo�it zm�ny?';  //'Save changes?';

{ Button captions }

  C_BTN_TODAY = 'Dnes';  //'Today';
  C_BTN_CLEAR = 'Vymazat';  //'Clear';

  C_SG_Parameter = 'Parametr';  //'Parameter';
  C_SG_Field = 'Pole';  //'Field';
  C_SG_Name = 'Jm�no';  //'Name';
  C_SG_Type = 'Typ';  //'Type';
  C_SG_Info = 'Info';  //';  //'Info';
  C_SG_Value = 'Hodnota';  //'Value';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Storno';  //'Cancel';
  C_BF_CANCEL_ACCEL = '&Storno';  //'&Cancel';
  C_BF_APPLY = 'Pou��t';  //'Apply';
  C_BF_HELP = 'N�pov�da';  //'Help';
  C_BF_EXECUTE = 'Spustit';  //'Execute';
  C_BF_CLOSE = 'Zav��t';  //'Close';
  C_BF_CLOSE_ACCEL = '&Zav��t';  //'&Close';
  C_BF_FINISH = 'Ukon�it';  //'Finish';
  C_BF_FINISH_ACCEL = '&Ukon�it';  //'&Finish';

  C_FRM_Ordering = '�azen�';  //'Ordering';

  C_CB_WordWrap = 'Zalamov�n�';  //'Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'Ovlivn�n� ��dky: ';  //'RowsAffected: ';
  M_SQL_RowsCounted = 'Po�et ��dk�: ';  //'Rows Counted: ';
  M_SQL_SessionBusy = 'Session je zanepr�zdn�na';  //'Session is currently busy';
  M_SQL_CompleteTransaction = 'Dokon�ete, pros�m, va�i transakci';  //'Please complete your transaction';
  M_SQL_CannotDeleteDefaultGroup = 'Nelze smazat p�ednastavenou skupinu';  //'The default group cannot be deleted';
  M_SQL_ReservedName = 'Jm�no je rezervov�no: ';  //'This name is reserved: ';
  M_SQL_BackSlashNotAllowed = 'Zp�tn� lom�tko nen� povoleno';  //'A back slash is not allowed';
  M_SQL_BlankNameNotAllowed = 'Pr�zdn� jm�no nen� povoleno';  //'A blank name is not allowed';
  M_SQL_RowsFetched = 'Nata�en�ch z�znam�: ';  //'Rows Fetched: ';
  M_SQL_ConfirmDBCreation = 'Opravdu chcete vytvo�it tuto datab�zi?';  //'Are you sure you want to create this database?';
  M_SQL_ConfirmNoOtherDBSameName = 'Ujist�te se, pros�m, neexistuje datab�ze se stejn�m jm�nem';  //'Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = 'Opravdu chcete tuto datab�zi smazat?';  //'Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = 'Tato datab�ze bude definitivn� smaz�na.'+#13#10+#13#10'P�esto pokra�ovat?';  //'This database will be permanently removed.'+#13#10+#13#10'Continue anyway?';
  M_SQL_AskFormName = 'Vlo�te jm�no formul��e:';  //'Enter query form name:';
  M_SQL_AskGroupName = 'Vlo�te jm�no skupiny';  //'Enter group name:';
  M_SQL_AskLayoutName = 'Vlo�te jm�no rozvr�en�';  //'Enter layout name:';
  M_SQL_ConfirmGroupDeletion = 'Opravdu chcete smazat skupinu %s v�etn� v�ech pod��zen�ch polo�ek?';  //'Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = 'Opravdu chcete smazat rozvr�en� %s?';  //'Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = 'Rekurzivn� kop�rov�n� nen� povoleno';  //'Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Poklepejte na polo�ku nebo vyberte polo�ku a zm��kn�te Enter';  //'Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'Hodnota parametru';  //'Parameter value';
  M_GCSQL_TypeAValueFor = 'Napi�te hodnotu pro %s';  //'Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = 'Tato procedura nem� vstupn� parametry.';  //'This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Data Pump proces je st�le aktivn�';  //'Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'Opravdu?';  //'Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Vybrat zdrojovou datab�zi';  //'Select Source Database';
  M_DP_SELECT_DEST_DB = 'Vybrat c�lovou datab�zi';  //'Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Smazat';  //'Clear';
  M_USERS_COMPLETED_OK = 'Operace byla �sp�n� dokon�ena';  //'Operation completed Successfully';
  M_USERS_NO_CONNECTION = 'Nen� definov�no IB_Connection';  //'No IB_Connection defined.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Nastavit polo�ky �azen�?';  //'Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Spustit Export';  //'Begin Export';
  M_EXPORT_STILL_ACTIVE = 'Export st�le prob�h�.';  //'Export process is still active.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Prohl�et datab�zi';  //'Browse Database';
  C_wbBrowseBtnCaption  = 'Prohl�et';  //'Browse';
  C_wbDSQLBtnHint       = 'Prov�st p��kaz v datab�zi';  //'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitorovat ud�losti datab�ze';  //'Monitor Database Events';
  C_wbEventsBtnCaption  = 'Ud�losti';  //'Events';
  C_wbExportBtnHint     = 'Exportovat dataset z datab�ze';  //'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Export';  //'Export';
  C_wbDumpBtnHint       = 'Ulo�it datab�zi';  //'Dump Database';
  C_wbDumpBtnCaption    = 'Ulo�it';  //'Dump';
  C_wbPumpBtnHint       = 'Importovat data z jin� datab�ze';  //'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Importovat';  //'Pump';
  C_wbWhoBtnHint        = 'Seznam p�ipojen�ch u�ivatel�';  //'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Kdo';  //'Who';
  C_wbScriptBtnHint     = 'Prov�st skript';  //'Execute Script';
  C_wbScriptBtnCaption  = 'Skript';  //'Script';
  C_wbExtractBtnHint    = 'Extrahovat DDL';  //'Extract DDL';
  C_wbExtractBtnCaption = 'Extrahovat';  //'Extract';
  C_wbMonitorBtnHint    = 'Sledovat SQL a API vol�n�';  //'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monitor';  //'Monitor';
  C_wbProfilerBtnHint   = 'Profilovat aktivitu datab�ze';  //'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profiler';  //'Profiler';
  C_wbStatusBtnHint     = 'Status IBO komponent';  //'View Status of IBO Components';
  C_wbStatusBtnCaption  = 'Status';  //'Status';
  C_wbUsersBtnHint      = 'Spr�va u�ivatel� datab�zov�ho serveru';  //'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'U�ivatel�';  //'Users';

  // Array grid
  C_AG_Row             = '��dek';  //'Row';
  C_AG_Column          = 'Sloupec';  //'Column';

  //IBF_Who
  C_WHO_FRM            = 'Kdo je p�ipojen';  //'Who is connected';
  C_WHO_BTNAPPLY       = 'Aktualizovat';  //'Refresh';

  C_NB_FIRST = 'Prvn�';  //'First';
  C_NB_PRIOR = 'P�edchoz�';  //'Prior';
  C_NB_NEXT = 'N�sleduj�c�';  //'Next';
  C_NB_LAST = 'Posledn�';  //'Last';

  C_ST_Open = 'Otev��t';  //'Open';
  C_ST_Close = 'Zav��t';  //'Close';
  C_ST_Prepare = 'P�ipravit';  //'Prepare';
  C_ST_Unprepare = 'Zru�it p��pravu';  //'Unprepare';
  C_ST_ReadOnly = 'Pro �ten�';  //'Read Only';
  C_ST_New = 'Nov�';  //'New';
  C_ST_Post = 'Ulo�it';  //'Post';
  C_ST_Cancel = 'Storno';  //'Cancel';
  C_ST_Delete = 'Smazat';  //'Delete';
  C_ST_Edit = 'Opravit';  //'Edit';
  C_ST_RefreshKeys = 'Aktualizovat kl��e';  //'Refresh Keys';
  C_ST_RefreshRows = 'Aktualizovat z�znamy';  //'Refresh Rows';
  C_ST_Refresh = 'Aktualizovat';  //'Refresh';

{ Hints }

  H_UB_EDIT = 'Opravit z�znam';  //'Edit Row';
  H_UB_INSERT = 'Nov� z�znam';  //'Insert Row';
  H_UB_DELETE = 'Smazat z�znam';  //'Delete Row';
  H_UB_REFRESH = 'Aktualizovat v�echny z�znamy';  //'Refresh all records';
  H_UB_REFRESHKEYS = 'Aktualizovat kl��e z�znam�';  //'Refresh record keys';
  H_UB_REFRESHROWS = 'Aktualizovat ��dky z�znam�';  //'Refresh record rows';
  H_UB_REFRESHFILTROWS = 'Aktualizovat filtrovan� z�znamy';  //'Refresh filtered rows';
  H_UB_POSTSEARCH = 'Potvrdit vyhled�vac� krit�ria';  //'Post search criteria';
  H_UB_CANCELSEARCH = 'Stornovat vyhled�vac� krit�ria';  //'Cancel search criteria';
  H_UB_POSTEDIT = 'Ulo�it opraven� z�znam';  //'Post edits';
  H_UB_CANCELEDIT = 'Stornovat opraven� z�znam';  //'Cancel edits';
  H_UB_POSTINSERT = 'Ulo�it nov� z�znam';  //'Post insert';
  H_UB_CANCELINSERT = 'Stornovat nov� z�znam';  //'Cancel insert';
  H_UB_POSTDELETE = 'Potvrdit smaz�n� z�znamu';  //'Post delete';
  H_UB_CANCELDELETE = 'Stornovat smaz�n� z�znamu';  //Cancel delete';
  H_UB_POST = 'Ulo�it zm�ny';  //'Post changes';
  H_UB_CANCEL = 'Stornovat zm�ny';  //Cancel changes';

  H_NB_FIRST = 'Prvn� z�znam';  //'First Row';
  H_NB_PRIOR = 'Posledn� z�znam';  //'Prior Row';
  H_NB_NEXT = 'N�sleduj�c� z�znam';  //'Next Row';
  H_NB_LAST = 'P�edchoz�';  //'Last Row';
  H_NB_JUMPBCK = 'Dop�edu';  //'Backwards';
  H_NB_JUMPFWD = 'Dozadu';  //'Forwards';

  H_SB_ORDER = 'Se�adit z�znamy';  //'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Obnovit posledn� krit�ria';  //'Recall Last Search Criteria';
  H_SB_SEARCH = 'Hledat';  //'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Ulo�it krit�ria';  //'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Smazat krit�ria';  //'Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Obnovit krit�ria';  //'Recall Criteria';
  H_SB_SEARCHCOUNT = 'Po�et z�znam� vyhovuj�c�ch krit�ri�m';  //'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Spo��tat ��dky';  //'Count Rows in Dataset';

  H_TB_StartTransaction = 'Spustit transakci';  //'Start Transaction';
  H_TB_PostDatasets = 'Potvrdit datasety';  //'Post Datasets';
  H_TB_CancelDatasets = 'Stornovat datasety';  //'Cancel Datasets';
  H_TB_SavePoint = 'Potvrdit a podr�et aktu�ln� transakci';  //'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Potvrdit datasety a Potvrdit a podr�et aktu�ln� transakci';  //'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = '';  //'Commit and End Current Transaction';
  H_TB_Rollback = 'Vr�tit zp�t a ukon�it aktu�ln� transakci';  //'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Vr�tit zp�t a podr�et aktu�ln� transakci';  //'Rollback and Retain Current Transaction';
  H_TB_Close = 'Ukon�it aktu�ln� transakci';  //'Close Current Transaction';

  H_ST_Prepare_Statement = 'P�ipravit p��kaz';  //'Prepare Statement';
  H_ST_Unprepare_Statement = 'Zru�it p�ipravenost p��kazu';  //'Unprepare Statement';
  H_ST_Execute_Statement = 'Prov�st p��kaz';  //'Execute Statement';

  H_DS_Open_Dataset = 'Otev��t dataset';  //'Open Dataset';
  H_DS_Close_Dataset = 'Zav��t dataset';  //'Close Dataset';
  H_DS_Prepare_Dataset = 'P�ipravit dataset';  //'Prepare Dataset';
  H_DS_Unprepare_Dataset = 'Zru�it p�ipravenost datasetu';  //'Unprepare Dataset';
  H_DS_ReadOnly_Dataset = 'Dataset jen pro �ten�';  //'Read Only Dataset';

  H_CB_Create_Database = 'Vytvo�it datab�zi';  //'Create Database';
  H_CB_Connect_Database = 'P�ipojit datab�zi';  //'Connect Database';
  H_CB_Disconnect_Database = 'Odpojit datab�zi';  //'Disconnect Database';
  H_CB_Drop_Database = 'Vymazat datab�zi';  //'Drop Database';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Export z p��kazu SELECT';  //'Export from SELECT statement';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Chyb� informace o Ascii souboru';  //'Missing entry for Ascii file';
  eNoDestTableEntry          = 'Chyb� informace o c�lov� tabulce';  //'Missing entry for destination table';
  eAsciiFileNotFound         = 'Ascii soubor %s nenalezen';  //'Ascii file %s not found';
  eIniFileNotFound           = 'Ini soubor %s nenalezen';  //'Ini-file %s not found';
  eNoAsciiFileAccess         = 'Nelze otev��t ascii soubor %s';  //'Could not open ascii file %s';
  eInvalidCharFound          = 'Neplatn� znak / chyba form�tu ascii souboru';  //'Invalid char / format error in ascii file';
  eOutOfMemory               = 'M�lo pam�ti';  //'Out of memory';
  eFieldDescriptionError     = 'Chyba v popisu pole';  //'Error in field description';
  eWrongAsciiFieldCount      = '�patn� po�et pol� v ascci souboru';  //'Wrong field count in ascii file';
  eWrongDecimalCount         = '�patn� po�et desetinn�ch m�st v seznamu pol� (%s)';  //'Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth           = '�patn� ���ka pole v ascii souboru';  //'Wrong field width in ascii file';

  // Dialog Labels - IB_Import
  lblRecsReadedCaption       = 'Celkem p�e�ten�ch z�znam�';  //'Total Records read';
  lblRecsCommentedCaption    = 'Zapozn�mkovan�ch z�znam�';  //'Records commented';
  lblRecsInsertedCaption     = 'Vlo�en�ch z�znam�';  //'Records inserted';
  btnAbortImportCaption      = 'Ukon�it';  //'Abort';

