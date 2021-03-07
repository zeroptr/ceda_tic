
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
{                                                                              }
{ Romanian version translated by Dorin Pacurar                                 }
{ e-mail address:            dorinpacurar@hotmail.com                          }
{ Redenumiti acest fisier ca si IB_Constants.pas.                              }
{ Fisierul original se poate salva (de ex. IB_Constants-eng.pas)               }
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

// Events
  IB_MaxEvents = 15;
  IB_EventLength = 64;

// Session
  IB_ISC_ERR_CODE_MSG = 'Eroare ISC cu numarul';//'ISC ERROR CODE:';
  IB_ISC_ERR_MSG_MSG  = 'Mesajul de eroare ISC';//'ISC ERROR MESSAGE:';
  IB_SQL_ERR_CODE_MSG = 'Eroare SQL cu numarul';//'SQL ERROR CODE:';
  IB_SQL_ERR_MSG_MSG  = 'Mesajul de eroare SQL';//'SQL ERROR MESSAGE:';

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

  IB_REG_MESSAGE = 'Multumesc pentru evaluarea packetului  IB Objects.'#10#13#10#13 + 'Poti inregistra componentele la http://www.ibobjects.com ';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Conexiunea este deja stabilita';//'Connection has already been established';
  E_NOT_CONNECTED     = 'Conexiunea nu a fost stabilita';//'Connection has not been established';
  E_Invalid_conn_path = 'Cale de conectare incorecta';//Invalid connection path';
  E_Cant_Repl_Int_Tr  = 'Nu se poate inlocui tranzactia interna ca implicita';//'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Tranzactia nu a fost stabilita';//'Transaction has not been started';
  E_TRANS_STARTED     = 'Tranzactia a fost pornita'; //'Transaction has already been started';
  E_NO_CONNECTIONS    = 'Tranzactia nu are nici o conexiune;';//'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Tranzactiei ii lipsesc una sau mai multe conexiuni';//'Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Conexiunea inca se incarca';//'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Conexiunile trebuie sa fie intr-o singura sessiune IB_Session ';//Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Tranzactia e oprita';// 'Transaction is Paused';
  E_ALLOCATED         = 'Statmentul a fost deja alocat'; //'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Statmentul nu a fost alocat ';//'Statement has not been allocated';
  E_PREPARED          = 'Statmentul a fost deja pregatit'; //'Statement has already been prepared';
  E_NOT_PREPARED      = 'Statmentul nu a fost pregatit';//'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Statmentul nu este pregatit';//'Statement failed to prepare';
  E_OPENED            = 'Statmentul a fost deja deschis';//'Statement has already been opened';
  E_NOT_OPENED        = 'Statmentul nu a fost deschis';//'Statement has not been opened';
  E_CANT_DELETE       = 'Articolul curent din cursor nu poate fi sters';//'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Statmentul trebuie sa aiba o conexiune'; //'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'IB_Connection nu se poate deschide';//'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Statmentul trebuie sa aiba o tranzactie';//'Statement must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'Nu exita o tranzactie activa pe care sa o folosim';//'No active transaction to execute with';
  E_START_FAILED      = 'Nu pot porni o tranzactie';//'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'Tranzactia explicita nu este permisa cu ServerAutoComit';//'Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate     = 'Starea tranzactiei este invalida.Nu se poate activa';//'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Tranzactia are schimbari in curs';//'Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Nu s-au salvat toate dataseturile';//'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Nu s-a dat renuntare la toate dataseturile';//'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Nu se poate face actualizare ,%s nu apartine de %s';//'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'Text SQL gol nu este permis';//'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Sfarsit de fisier';//'At end of file';
  E_AT_END_OF_CURSOR  = 'Sfarsit de cusor';//'At end of cursor';
  E_AT_END_OF_BUFFER  = 'Sfarsit de buffer';//'At end of buffer';
  E_AT_END_OF_DATASET = 'Sfarsit de buffer';//'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'Lungime prea mare in isc_dsql_sql_info';//'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Date invalide returnate din isc_dsql_sql_info';//'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Nu se poate schimba numele cursorului cat timp este activ';//'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Nu se poate schimba RequestLife cat timp este activ';//'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'Nu se poate schimba RequestLife la un dataset ReadOnly';//'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI              = 'IB_CURSOR este unidirectional';//'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Tip de Coloana nesuportat';//'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND         = 'FieldNo: %d nu a fost gasit';//'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = 'FieldName: %s nu a fost gasit';//FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = 'Invalid Focused Relatia Nr: %d';//'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Invalid Focused Relatia cu Numele %s';//'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = 'IN( valoarea [ , valoarea ... ] )  erroare de sintaxa';//'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = 'BETWEEN valoare AND valoare erroare de sintaxa';//'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Nu se poate localiza DLL-ul importat %s';//'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'SQLKeyFields,proprietate incorecta';//Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR       = 'Nu se poate deschide cusorul fara key data';//'Cannot open cursor without key data';
  E_SCROLL_ERROR           = 'Inregistrarea cheie s-a pierdut '#10#13'Nu se poate deschide cusorul';//'Record key was lost'#10#13'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'BufferRowNum este incorect inainte de a incepe';//'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT      = 'Nu se poate da prepare la un statement gol';//'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT   = 'Incercare de executare a unui statement gol';//'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Referinta circulara nu este permisa';//'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = 'Nu se poate schimba cat timp este connectat ';//'Cannot change while connected';
  E_LOGIN_FAILED      = 'Logare Nereusita';//'Login failed';
  E_CANT_GET_CONN_CHR = 'Nu se pot aduce caracteristicile conxiunii';//'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = 'Peste numarul maxim de evenimente pentru un singur block';//'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Evenimentele se proceseaza ';//'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'Blobul nu se poate pastra in db';//'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'Blobul nu se poate incarca';//'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Nu se poate cancela Recordul(ROW) current';//'Cannot cancel current Row';
  E_CANNOT_POST_ROW  = 'Nu se poate da Post la Recordul(ROW) current' ;//'Cannot Post current Row';
  E_DatasetClosed     = 'Datasetul este inactiv';//'Dataset is inactive';
  E_DatasetOpen        = 'Datasetul este deschis';//'Dataset is currently open';
  E_DatasetCannotScroll = 'Datasetul nu poate fi scrollat(parcurs)';//'Dataset cannot scroll';
  E_DatasetReadOnly     = 'Datasetul este doar citibil (readonly)';//'Dataset is readonly';
  E_DatasetIsFetching    = 'Datasetul se incarca in acest moment';//'Dataset is currently fetching';
  E_Invalid_KeyRelation   = 'Valoarea la KeyRelation este invalida';//'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNum nu este implementata inca';//'RowNum is not implemented yet';
  E_RowDeleted            = 'Randul(Recordul) se sterge';//'Row is being deleted';
  E_END_OF_DATASET        = 'La sfarsitul Datasetului ';//'At end of Dataset';
  E_BEGINNING_OF_DATASET   = 'La inceputul Datasetului ';//'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Nu se poate folosi blocaj pesimistic LockWait ';//'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row      = 'Randul curent nu se poate edita';//'Cannot Edit current Row';
  E_Cannot_Insert_Row  = 'Nu se poate insera un nou rand';//'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Nu se poate sterge Randul curent';//'Cannot delete current Row';
  E_Cannot_Search    = 'Cautarea nu este permisa ';//'Searching is not allowed';
  E_Cannot_Navigate = 'Nu se poate browseri';//'Cannot navigate';
  E_Record_Locked    = 'Recordul este blocat de un alt utilizator';//'Record is locked by another user';
  E_Record_OutOfSynch = 'Recordul a fost schimbat de un alt utilizator';//'Record was changed by another user';
  E_FLD_READONLY       = '%s este doar citibil';//'%s is readonly';
  E_Required_Field       = '%s este un camp necesar';//'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Nu se poate folosi PostRetaining cu Cached Updates';//'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Randuri multiple unde trebuiau sa fie doar unul(Multiple rows in singleton fetch)';//'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'RowsAffected buffer este eronat';//'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'RowNum mai mare ca Eof(gresit)';//'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'RowNum mai mic ca Bof(gresit)';//'Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Bookmark String(gresit)';//'Invalid Bookmark String';

  E_Assign_Column  = 'Nu se poate aloca din $s ';//'Cannot assign from %s';
  E_AssignTo_Column = 'Nu se poate aloca pentru $s ';//'Cannot assign to %s';
  E_Value_Out_Of_Range = 'Valoarea este prea mare(out of range)';//'Value out of range';
  E_SmallintOverflow = 'Depasirea valorii maxime pentru un intreg Smallint';//'Smallint overflow';
  E_IntegerOverflow = 'Depasirea valorii maxime pentru un intreg Integer';//'Integer overflow';
  E_Int64Overflow = 'Depasirea valorii maxime pentru un intreg Int64';//'Int64 overflow';

  E_Unsupported_Column = 'Tip de Coloana nesuportata %d';//'Unsupported Column type: %d';
  E_UndefinedMacro = 'Macro Nedfinit';//'Undefined macro';
  E_GeneratorFailed = 'Nu se poate citi valoarea generatorului';//'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'Trebuie sa fie derivat din TIB_BDataset ca (IB_Query)';//'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Nu se poate pune pe ReadOnly cand s-a pornit';//'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Nu se schimba Isolation cand s-a pornit';//'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Nu se poate RecVersion cand s-a pornit';//'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'Nu se poate LockWait cand s-a pornit';//'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Referinta invalida la Stergere';//'Invalid reference to Delete';
  E_Invalid_Typecast = 'conversie eronata';//'Invalid typecast';
  E_Invalid_DataPump_Statement = 'Statment eronat pentru DataPump';//'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'camp de tip NOT NULL este pus pe NULL';//'NOT NULL field set to null value';
  E_DATABASE_BLANK = 'DatabaseName nu poate fi goala';//'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'conversie de coloane nesuportat';//'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Nu se poate gasi inregistrarea';//'Unable To Locate Record';
  E_Record_Not_Inserted = 'Inregistrarea nu a fost inserata';//'Record was not inserted';
  E_Invalid_KeyLinks = 'Valoare a KeyLinks-ului gresita %s';//'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search ='Nu se poate face cautarea';// 'Unable to perform search';
  E_Unassigned_Blob_Node = 'BlobNode-ul nu se poate atribui';//'Unassigned BlobNode';
  E_Unassigned_Transaction ='Tranzactia nu se poate atribui';// 'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer ='RowsAffected buffer eronat';// 'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic ='Nu se poate salva Graficul';// 'Unable to save to Graphic';
  E_Cannot_Activate_Transaction ='Nu se poate activa Tranzactia';// 'Cannot Activate Transaction';
  E_IB_Client_Not_Installed ='Clientul Interbase GDS32.dll nu este instalat';// 'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo ='Nu se poate incarca memo';// 'Could not load memo';
  E_Invalid_DPB_Over_255  ='Database Parameter Buffer mai mare de 255 de caractere ';// 'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML  ='DML gresit referinta la coloana  ';// 'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update  ='Recordul nu a fost gasit pt. actualizare ';// 'Record was not located to update';
  E_Record_Not_Located_For_Delete  ='Recordul nu a fost gasit pt. stergere ';// 'Record was not located to delete';
  E_Init_Default_SQL_Failed  =' Initializarea nu s-a facut implicit la %s';// 'Unable to initialize default %s';
  E_Stringlist_Not_Sorted  ='Stringlist trebuie sa fie sortata pentru aceasta operatie ';// 'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events  ='Nu se pot schimba evenimentele cat timp se proceseaza ';// 'Cannot change events while processing';
  E_Cannot_Unregister_Events  ='Nu se pot sterge evenimentele cat timp se proceseaza  ';// 'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction  ='Internal IB_Transaction Gresita';// 'Invalid Internal IB_Transaction';
  E_InvalidStatementType  ='Tipul de Statement este invalid ';// 'Invalid statement type';
  E_Multiple_Records_Updated  ='Mai multe articole au fost Schimbate(updated)';// 'Multiple records updated';
  E_Multiple_Records_Deleted  ='Mai multe articole au fost Sterse ';// 'Multiple records deleted';
  E_Multiple_Records_Inserted = 'Mai multe articole au fost inserate';//Multiple records inserted';
  E_DUP_DB_NAME  ='DatabaseName de doua ori nu este permis';// 'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME  ='DatabaseName gresit';// 'Invalid DatabaseName';
  E_UnableToSearch_NoOrdering = 'Nu pot efectua cautarea, ordonare nedefinita';//'Unable to perform search, no ordering defined';
  E_UnableToSearch_DatasetBusy = 'Nu pot efectua cautarea. Setul de date este in curs de incarcare';//'Unable to perform search, dataset is busy fetching data';
  E_NoRecordsFound  ='Nu s-a gasit nici o inregistrare ';// 'No records found';
  E_Session_Undefined  ='Sesiune nedefinita ';// 'Session is undefined';
  E_NoCircularRef  ='Referinta circulara nepermisa';// 'Circular reference not allowed';
  E_InvalidClassType  ='Tip de clasa invalida  ';// 'Invalid class type';
  E_Invalid_RowNum  ='RowNum gresit';// 'Invalid RowNum';
  E_Invalid_Syntax  ='Sintaxa gresita: prea multe sau lipsesc paranteze';// 'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null  ='Vectorul este NULL ';// 'Array is Null';

  E_Cannot_add_blank_account  ='Nu se poate adauga un cont nul';// 'Cannot add blank account';
  E_Cannot_add_SYSDBA_account  ='Nu se poate adauga un cont SYSDBA';// 'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account  ='Nu se poate sterge un cont null';// 'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account  ='Nu se poate sterge un cont SYSDBA ';// 'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account  ='Nu se poate modifica un cont nul ';// 'Cannot modify blank account';

  E_PLAN_ERROR  ='Eroare in Plan !!';// 'PLAN ERROR!';
  E_PLAN_EXCEPTION  ='Exceptie in Plan ! ';// 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP  ='Sintaxa pentru CREATE, CONNECT sau DROP DATABASE este gresita';// 'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported  ='Nesuportat ';// 'Unsupported';
  E_NotImplemented  ='Nu este implementat la acest nivel ';// 'Not implemented at this level';
  E_Invalid_ColData  ='ColData gresit ';// 'Invalid ColData';

  E_Cant_Unprepare_executing_process  ='Nu se poate Unprepare ';// 'Cannot Unprepare an executing process';
  E_FileName_Required  ='Numele fisierului este necesar ';// 'Filename is required';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM  ='Managementul de Utilizatori ';// 'User Account Management';
  L_USERS_ADD  ='Aduga ';// 'Add';
  L_USERS_DELETE  ='Sterge ';// 'Delete';
  L_USERS_MODIFIY  ='Modifica ';// 'Modify';
  L_USERS_ACCOUNT  ='Conturi ';// 'ACCOUNT';
  L_USERS_PASSWORD  ='Parola ';// 'Password';
  L_USERS_GROUP  ='Grupuri ';// 'Group';
  L_USERS_FIRSTNAME  ='Prenume';// 'First Name';
  L_USERS_MIDDLENAME  ='Alt nume';// 'Middle Name';
  L_USERS_LASTNAME  ='Nume';// 'Last Name';

  //IBF_Export
  L_EXPORT_FRM  ='Export ';// 'Export';
  L_EXPORT_ASCII  ='Formatul de Fisire ';// ' File Format ';
  L_EXPORT_FIXED  ='Lungimea fixata a inregistrarii in fisierul TXT ';// 'TXT Fixed Record Width';
  L_EXPORT_DELIMITED  ='CSV delimitat ';// 'CSV Delimited';
  L_EXPORT_DBF   =' DBF beta';// 'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT   ='Optiuni ASCII ';// ' ASCII Options ';
  L_EXPORT_DELIMITER   ='Delimitator ';// 'Delimiter';
  L_EXPORT_SEPARATOR   ='Seperator ';// 'Separator';
  L_EXPORT_DATEFORMAT   ='Format de date ';// 'Date Format';
  L_EXPORT_INCLUDEHEADERS   ='Headerele Incluse   ';// 'Include Headers';
  L_EXPORT_INCLUDECRLF   ='Include CRLF ';// 'Include CRLF';
  L_EXPORT_SDEXPORTTITLE  ='Exporta';// 'Export';
  L_EXPORT_SDEXPORTFILTERCSV  ='Fisire TXT separate de virgula ( *.CSV )|*.CSV ';// 'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT  ='Fisiere TXT ( *.TXT )|*.TXT ';// 'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF  ='Fisire TXT ( *.DBF )|*.DBF ';// 'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching  ='Esti sigur ca vrei sa renunti';// 'Are you sure you want to abort?';
  M_Fetching_Query_Results  ='Se Incarca rezultatele ';// 'Fetching Query Results';
  M_Row_Num  ='Randul# %d';// 'Row# %d';
  M_Abort_Fetching_Btn  ='Renunt ';// 'Abort';

  M_Login_Database  ='Baza date';// 'Database';
  M_Login_User  ='Utilizator';// 'User';
  M_Login_Password  ='Parola';// 'Password';
  M_Login_OK_Btn  ='Da';// 'OK';
  M_Login_Cancel_Btn  ='Nu';// 'Cancel';
  M_Login_Help_Btn  ='&Ajutor ';// '&Help';
  M_Login_Dialog_Caption  ='Logare ';// 'Login Dialog';

  M_Loading_Caption  ='Se incarca .... ';// 'Loading...';

  M_SB_REC_CNT = 'Numarul de inregistrari %d';//'Records counted: %d';
  M_Save_Changes = 'Salvezi schimbarile?';//'Save changes?';
  M_Abort_Changes = 'Modificarile facute se vor pierde. Ok ?';//Changes will be lost. Ok to proceed?';

  M_CancelTransactionPrompt = 'Esti sigur ca vrei sa renunti la toate schimbarile? ';// 'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'Renunti la excutia acestui script?';//'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING ='Se continua executarea acestui script';// 'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING ='Scriptul se executa ..';// 'Script is currently executing';
  M_SCRIPT_FAILED = 'Scriptul nu s-a putut executa';//'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Scriptul a fost oprit';//'Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Scriptul a fost executat corect ';//'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Scriptul a fost executat cu erori';
  M_SCRIPT_MODIFIED = 'Modificat';
  M_SCRIPT_SAVE_CHANGES = 'Salvez schimbarile ?';

{ Button captions }

  C_BTN_TODAY = 'Astazi';//'Today';
  C_BTN_CLEAR = 'Sterge';//'Clear';

  C_SG_Parameter = 'Parametri';//'Parameter';
  C_SG_Field = 'Campuri';//'Field';
  C_SG_Name = 'Numele';//'Name';
  C_SG_Type = 'Tipuri';//'Type';
  C_SG_Info = 'Informatii';//'Info';
  C_SG_Value = 'Valori';//'Value';

  C_BF_OK = 'Okey';//'OK';
  C_BF_CANCEL = 'Nu';//'Cancel';
  C_BF_CANCEL_ACCEL = '&Renunt';
  C_BF_APPLY = 'Aplica';//'Apply';
  C_BF_HELP = 'Ajutor';//'Help';
  C_BF_EXECUTE = 'Executa';//'Execute';
  C_BF_CLOSE = 'Inchide';
  C_BF_CLOSE_ACCEL = '&Inchide';
  C_BF_FINISH = 'Termina';
  C_BF_FINISH_ACCEL = '&Termina';

  C_FRM_Ordering = 'Ordonare';//'Ordering';
  C_FRM_RESTRUCTURE = 'Personalizeaza campurile afisate';//'Customize Fields Displyed';

  C_CB_WordWrap = 'Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'Articole afectate';//'RowsAffected: ';
  M_SQL_RowsCounted = 'Articole numarate';//'Rows Counted: ';
  M_SQL_SessionBusy = 'Sesiunea este in prezent ocupata';//'Session is currently busy';
  M_SQL_CompleteTransaction = 'Va rog sa incheiati tranzactia';//'Please complete your transaction';
  M_SQL_CannotDeleteDefaultGroup = 'Grupul implicit nu poate fi sters';//'The default group cannot be deleted';
  M_SQL_ReservedName = 'Acest nume este rezervat';//'This name is reserved: ';
  M_SQL_BackSlashNotAllowed = 'Caracterul back slash (\) nu este permis';//'A back slash is not allowed';
  M_SQL_BlankNameNotAllowed = 'Nu este permis un nume gol';//'A blank name is not allowed';
  M_SQL_RowsFetched = 'Rinduri aduse';//'Rows Fetched: ';
  M_SQL_ConfirmDBCreation = 'Sinteti sigur ca doriti sa creati aceasta baza de date ?';//'Are you sure you want to create this database?';
  M_SQL_ConfirmNoOtherDBSameName = 'Va rog sa verificati daca nu mai exista o baza de date cu acelasi nume';//'Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = 'Sinteti sigur ca doriti stergerea bazei de date ?';//'Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = 'Aceasta baza de date va fi stearsa definitiv.'+#10#13+#10#13'Continuati ?';//'This database will be permanently removed.'+#10#13+#10#13'Continue anyway?';
  M_SQL_AskFormName = 'Introduceti numele formului';//'Enter query form name:';
  M_SQL_AskGroupName = 'Introduceti numele grupului';//'Enter group name:';
  M_SQL_AskLayoutName = 'Introduceti numele layout-ului';//'Enter layout name:';
  M_SQL_ConfirmGroupDeletion = 'Sinteti sigur ca doriti stergerea grupului %s inclusiv toate dependintele ?';//'Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = 'Sinteti sigur ca doriti stergerea layout-ului %s ?';//'Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = 'Copie recursiva nu este admisa';//'Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Dublu click sau tasta Enter pentru selectie';//Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'Parametru valoare';//Parameter value';
  M_GCSQL_TypeAValueFor = 'Tastati o valoare pentru %s';//Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = 'Aceasta procedura nu are parametri de intrare';//This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Procesul de migrare este activ ';//Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'Sunteti sigur ?';//Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Selectati baza de date sursa';//Select Source Database';
  M_DP_SELECT_DEST_DB = 'Selectati baza de date destinatie';//Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Da';
  C_BTN_USERS_CLEAR = 'Sterge';//'Clear';
  M_USERS_COMPLETED_OK = 'Operatiune executata cu succes';//Operation completed Successfully';
  M_USERS_NO_CONNECTION = 'Nu este definita conexiune IB';//No IB_Connection defined.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Atasati elemente de ordonare ?';//Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Incepe Exportul';//'Begin Export';
  M_EXPORT_STILL_ACTIVE = 'Operatiunea de export este activa.';//Export process is still active.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Cauta baza de date';//'Browse Database';
  C_wbBrowseBtnCaption  = 'Cauta';//'Browse';
  C_wbDSQLBtnHint       = 'Executa script';//'Execute Statement In Database';
  C_wbDSQLBtnCaption    = 'DSQL';//'DSQL';
  C_wbEventsBtnHint     = 'Monitorizeaza';//'Monitor Database Events';
  C_wbEventsBtnCaption  = 'Evenimente';//'Events';
  C_wbExportBtnHint     = 'Exporta Datasetul din DataBase';//'Export Dataset From Database';
  C_wbExportBtnCaption  = 'Exporta';//'Export';
  C_wbDumpBtnHint       = 'Sterge Database';//'Dump Database';
  C_wbDumpBtnCaption    = 'Sterge';//'Dump';
  C_wbPumpBtnHint       = 'Pompeaza datele ';//'Pump Data From Another Database';
  C_wbPumpBtnCaption    = 'Pompeaza';//'Pump';
  C_wbWhoBtnHint        = 'Vezi cine e conectat la Baza de date';//'See Who is Connected to the Database';
  C_wbWhoBtnCaption     = 'Utilizatori';//'Who';
  C_wbScriptBtnHint     = 'Executa scriptul';//'Execute Script';
  C_wbScriptBtnCaption  = 'Scriptul';//'Script';
  C_wbExtractBtnHint    = 'Extarge DDL';//'Extract DDL';
  C_wbExtractBtnCaption = 'Extrage';//'Extract';
  C_wbMonitorBtnHint    = 'Spioneaza SQL-ul si apelurile API';//'Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Spioneaza';//'Monitor';
  C_wbProfilerBtnHint   = 'Ce se intampla in Baza de Date(Profile Database Activity)';//'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profilerul';//'Profiler';
  C_wbStatusBtnHint     = 'Vizualizare stare componente IBO';//'View Status of IBO Components';
  C_wbStatusBtnCaption  = 'Stare';//'Status';
  C_wbUsersBtnHint      = 'Administreaza utilizatorii din Baza de Date ';//'Administer Users for a Database Server';
  C_wbUsersBtnCaption   = 'Utilizatori';//'Users';

  // Array grid
  C_AG_Row             = 'Randul';//'Row';
  C_AG_Column          = 'Coloana';//'Column';

  //IBF_Who
  C_WHO_FRM            = 'Cine-i conectat';//'Who is connected';
  C_WHO_BTNAPPLY       = 'Reincarca';//'Refresh';

  C_NB_FIRST = 'Primul';
  C_NB_PRIOR = 'Precedentul';
  C_NB_NEXT = 'Urmatorul';
  C_NB_LAST = 'Ultimul';

  C_ST_Open = 'Deschis';
  C_ST_Close = 'Inchis';
  C_ST_Prepare = 'Prepare';
  C_ST_Unprepare = 'Unprepare';
  C_ST_ReadOnly = 'Numai citire';
  C_ST_New = 'Nou';
  C_ST_Post = 'Aplica';
  C_ST_Cancel = 'Renunt';
  C_ST_Delete = 'Sterge';
  C_ST_Edit = 'Editeaza';
  C_ST_RefreshKeys = 'Reincarca cheile';
  C_ST_RefreshRows = 'Reincarca articolele';
  C_ST_Refresh = 'Reincarca datele';

{ Hints }

  H_UB_EDIT = 'Editeaza randul';//'Edit Row';
  H_UB_INSERT = 'Insereaza randul';//'Insert Row';
  H_UB_DELETE = 'Sterge randul';//'Delete Row';
  H_UB_REFRESH = 'Reincarca toate inregistrarile';//'Refresh all records';
  H_UB_REFRESHKEYS = 'Reincarca cheile(keys) inregistrarilor ';//'Refresh record keys';
  H_UB_REFRESHROWS = 'Reincarca datele din inregistrari';//'Refresh record rows';
  H_UB_REFRESHFILTROWS = 'Reincarca datele filtrate';//'Refresh filtered rows';
  H_UB_POSTSEARCH = 'Aplica criteriul de cautare';//'Post search criteria';
  H_UB_CANCELSEARCH = 'Renunta la criteriul de cautare';//'Cancel search criteria';
  H_UB_POSTEDIT = 'Aplica editarile';//'Post edits';
  H_UB_CANCELEDIT = 'Renunta la editari';//'Cancel edits';
  H_UB_POSTINSERT = 'Aplica inserarile';//'Post insert';
  H_UB_CANCELINSERT = 'Renunta la inserari';//'Cancel insert';
  H_UB_POSTDELETE = 'Aplica stergerile';//'Post delete';
  H_UB_CANCELDELETE = 'Renunta la stergeri';//'Cancel delete';
  H_UB_POST = 'Aplica modificarile';//'Post changes';
  H_UB_CANCEL = 'Renunta la modificari';//'Cancel changes';

  H_NB_FIRST = 'Primul rand';//'First Row';
  H_NB_PRIOR = 'Randul anterior';//'Prior Row';
  H_NB_NEXT = 'Randul urmator';//'Next Row';
  H_NB_LAST = 'Ultimul rand';//'Last Row';
  H_NB_JUMPBCK = 'Inapoi';//'Backwards';
  H_NB_JUMPFWD = 'Inainte';//'Forwards';

  H_SB_ORDER = 'Ordoneaza randurile in Dataset';//'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Recheama ultimul criteriu de cautare ';//'Recall Last Search Criteria';
  H_SB_SEARCH = 'Cauta in Dataset';//'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Salveaza criteriu  (Save Criteria)';
  H_SB_CLEAR_CRITERIA = 'Sterge criteriu (Clear Criteria)';//
  H_SB_RECALL_CRITERIA = 'Reapeleaza criteriu (Recall Criteria)';
  H_SB_SEARCHCOUNT = 'Numara randurile care respecta criteriul ';//'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Numara randurile de DataSet';//'Count Rows in Dataset';
  H_SB_RESTRUCTURE = 'Personalizeaza campurile afisate';//'Customize the Fields Displayed';

  H_TB_StartTransaction = 'Porneste tranzactia';//'Start Transaction';
  H_TB_PostDatasets = 'Aplica Dataseturile';//'Post Datasets';
  H_TB_CancelDatasets = 'Renunta la Dataseturi';//'Cancel Datasets';
  H_TB_SavePoint = 'Aplica si retine(Retain) tranzactia curenta ';//'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Aplica modificarile si retine(Retain) tranzactia curenta';//'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Aplica si termina tranzactia curenta';//'Commit and End Current Transaction';
  H_TB_Rollback = 'Da inapoi si termina tranzactia curenta';//'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Da inapoi si retine tranzactia curenta';//'Rollback and Retain Current Transaction';
  H_TB_Close = 'Inchide tranzactia curenta';//'Close Current Transaction';

  H_ST_Prepare_Statement = 'Pregateste scriptul';
  H_ST_Unprepare_Statement = 'Elibereaza scriptul';
  H_ST_Execute_Statement = 'Executa scriptul';

  H_DS_Open_Dataset = 'Deschide Dataset';
  H_DS_Close_Dataset = 'Inchide Dataset';
  H_DS_Prepare_Dataset = 'Pregateste Dataset';
  H_DS_Unprepare_Dataset = 'Elibereaza Dataset';
  H_DS_ReadOnly_Dataset = 'Dataset numai pt.citire';

  H_CB_Create_Database = 'Creaza Baze de date';
  H_CB_Connect_Database = 'Conectare la Baza de date';
  H_CB_Disconnect_Database = 'Deconectare Baza de date';
  H_CB_Drop_Database = 'Sterge Baza de date';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Exporta din rezulatele SELECT';//'Export from SELECT statement';

	// Error Messages - IB_Import
        eNoAsciiFileEnty           = 'Lipseste campul in Fisierul ASCII';//'Missing entry for Ascii file';
	eNoDestTableEntry          = 'Lipste campul pt tabelul destinatie';  //'Missing entry for destination table';
	eAsciiFileNotFound         = 'Fisierul ASCII %s nu exista';//'Ascii file %s not found';
	eIniFileNotFound           = 'Fisierul INI %s nu exista';//'Ini-file %s not found';
	eNoAsciiFileAccess         = 'Nu se poate deschide fisierul %s';//'Could not open ascii file %s';
	eInvalidCharFound          = 'Caracter nepotrivit sau eroare de format in fisierul de intrare ';//'Invalid char / format error in ascii file';
	eOutOfMemory               = 'Memorie insuficienta';//'Out of memory';
	eFieldDescriptionError     = 'Eroare in descrirea campului';//'Error in field description';
	eWrongAsciiFieldCount      = 'Numarul de Campuri este gresit ';//'Wrong field count in ascii file';
	eWrongDecimalCount         = 'Numarul de campuri este gresit';//'Wrong decimal count in fieldlist (%s)';
        eWrongFieldWidth           =  'Largimea campului este gresita in fisierul ascii';//'Wrong field width in ascii file';

  // Dialog Labels - IB_Import
  lblRecsReadedCaption       = 'Numarul total de inregistrari citite';//'Total Records read';
  lblRecsCommentedCaption    = 'Inregistrari comentate';//'Records commented';
  lblRecsInsertedCaption     = 'Inregistrari inserate';//'Records inserted';
  btnAbortImportCaption      = 'Renunta';//'Abort';

  // Metadata Extract Stuff
  // ------------------------

  // Entity Type Names
  STR_DDL_UnnamedItem = '<FARA NUME>';//'<NO NAME>';
  STR_DDL_etDatabase = 'Baza de date';//'Database';
  STR_DDL_etException = 'Exceptii';//'Exception';
  STR_DDL_etBlobFilter = 'Filtre Blob';//'Blob Filter';
  STR_DDL_etUDF = 'Functii utilizator';//'UDF';
  STR_DDL_etGenerator = 'Generatoare';//'Generator';
  STR_DDL_etDomain = 'Domenii';//'Domain';
  STR_DDL_etTable = 'Tabele';//'Table';
  STR_DDL_etView = 'Vederi';//'View';
  STR_DDL_etProcedure = 'Proceduri';//'Procedure';
  STR_DDL_etRole = 'Role';
  STR_DDL_etPrimaryKey = 'Indecsi primari';//'Primary Key';
  STR_DDL_etUniqueKey = 'Chei unice';//'Unique Key';
  STR_DDL_etForeignKey = 'Chei straine';//'Foreign Key';
  STR_DDL_etConstraint = 'Constrangeri';//'Constraint';
  STR_DDL_etIndex = 'Indecsi';//'Index';
  STR_DDL_etTrigger = 'Trigger-e';//'Trigger';
  STR_DDL_etPermission = 'Drepturi de acces';//'Permission';
  STR_DDL_etUDFParam = 'Parametri UDF';//'UDF Parameter';
  STR_DDL_etTableField = 'Campuri din tabele';//'Table Field';
  STR_DDL_etViewField = 'Campuri don vederi';//'View Field';
  STR_DDL_etProcParam = 'Parametri de proceduri';//'Procedure Parameter';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Creaza baza de date';//'Create Database';
  STR_DDL_coSecondaryFiles = 'Defineste fiser secundar';//'Define Secondary Files';
  STR_DDL_coDefineShadows = 'Defineste oglinda (umbra)';//'Define Shadows';
  STR_DDL_coSetGeneratorVal = 'Fixeaza valoarea generatorului';//'Set Generator Value';
  STR_DDL_coResetExceptionNo = 'Reseteaza numarul exceptiei';//'Reset Exception Number';
  STR_DDL_coRawFieldDefs = 'Definitiile campului';//'Raw Field Definitions';
  STR_DDL_coReportMinor = 'Raport minor';//'Report Minor';
  STR_DDL_coAlwaysQuoted = 'Intotdeauna intre ghilimele';//'Always Quoted';
  STR_DDL_coAlwaysCharSet = 'Intotdeauna defineste set de caractere';//'Always Define Character Set';
  STR_DDL_coIncludeDebug = 'Include comentarii de depanare';//'Include Debug Comments';
  STR_DDL_coDescripAsComment = 'Descrieri ca si comentarii';//'Descriptions as Comments';

  // CodePass Names
  STR_DDL_cpFull = 'Intreg';//'Full';
  STR_DDL_cpInit = 'Initial';//'Initial';
  STR_DDL_cpFinal = 'Final';//'Final';

  // Dialog strings
  STR_DDL_DialogCaption = 'Extrage metadata';//'Metadata Extract';
  STR_DDL_Configure = 'Configurare';//'Configure';
  STR_DDL_Filters = 'Filtre';//'Filters';
  STR_DDL_Script = 'Script (fraze SQL)';//'Script';
  STR_DDL_MetadataControls = 'Controale metadata';//'Metadata Controls';
  STR_DDL_CodeOptions = 'Optiuni de cod';//'Code Options';
  STR_DDL_Entities = 'Entitati';//'Entities';
  STR_DDL_Terminator = 'Terminator';//'Terminator';
  STR_DDL_ExecuteControls = 'Executa controale';//'Execute Controls';
  STR_DDL_CodePass = 'Cod de acces';//'Code Pass';
  STR_DDL_ExtractToStrings = 'Extrage in sir de caractere';//'Extract To Strings';
  STR_DDL_Reset = 'Resetare';//'Reset';
  STR_DDL_ResetAll = 'Resetez tot';//'Reset All';
  STR_DDL_ProgressControls = 'Controale de progres';//'Progress Controls';
  STR_DDL_Stop = 'Stop';//'Stop';
  STR_DDL_IncludeSystem = 'Include obiecte sistem';//'Include System Objects';
  STR_DDL_NameMasks = 'Masca de nume';//'Name Masks';
  STR_DDL_SaveToFile = 'Salveaza in fisier';//'Save To File';

implementation

end.
