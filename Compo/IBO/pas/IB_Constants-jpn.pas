
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
{ Yukio Makino <makino@freejpn.com>                                            }
{ 12/20/2001                                                                   }
{ Japanese version                                                             }
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

  IB_REG_MESSAGE = 'Thanks for evaluating IB Objects.'#13#10#13#10'Please go to http://www.ibobjects.com and register today.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Connection�͊��ɏo���Ă��܂�'; //'Connection has already been established';
  E_NOT_CONNECTED     = 'Connection�͂܂��o���Ă��܂���'; //'Connection has not been established';
  E_Invalid_conn_path =  '���̃p�X�͖����ł�'; //'Invalid connection path';
  E_Cant_Repl_Int_Tr  = '��̫�Ăł́A������ݻ޸��݂ɒu�����邱�Ƃ��o���܂���'; //'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = '��ݻ޸��݂͎n�܂��Ă��܂���'; //'Transaction has not been started';
  E_TRANS_STARTED     = '��ݻ޸��݂͊��Ɏn�܂��Ă��܂�'; //'Transaction has already been started';
  E_NO_CONNECTIONS    = '��ݻ޸��݂�connection����Ă܂���'; //'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = '��ݻ޸��݂͂ЂƂ������͂���ȏ��connection���������܂���';  //'Transaction is missing one or more connections';
  E_CONN_LOADING      = '�x���Fconnection�͂܂�load���Ă��܂�';  //'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Connection�͂��ׂē���IB_Session�ɂȂ��Ă͂����܂���'; //'Connections must all be in the same IB_Session';
  E_TransactionPaused = '��ݻ޸��݂͒��f����܂�'; //'Transaction is Paused';
  E_ALLOCATED         = 'Statement�͊��Ɋ����Ă��܂���'; //'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Statement�͊����āA�Ă��܂���'; //'Statement has not been allocated';
  E_PREPARED          = 'Statement�͊��ɏ�������Ă܂�'; //'Statement has already been prepared';
  E_NOT_PREPARED      = 'Statement�͏�������Ă��܂���'; //'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Statement�̏����Ɏ��s���܂���'; //'Statement failed to prepare';
  E_OPENED            = 'Statement�͊��ɊJ���Ă��܂�';  //'Statement has already been opened';
  E_NOT_OPENED        = 'Statement�͊J���Ă��܂���';  //'Statement has not been opened';
  E_CANT_DELETE       = '���̃��R�[�h�ł͍폜�ł��܂���'; //'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Statement��IB_Connection�Ɋ����Ă�������'; //'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'IB_Connection���J���邱�Ƃ��o���܂���'; //'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'IB_Transaction�������Ă�������'; //'Must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = '���s���ׂ���ݻ޸��݂�����܂���'; //'No active transaction to execute with';
  E_START_FAILED      = '��ݻ޸��݂��n�߂邱�Ƃ��ł��܂���'; // 'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = '�����I����ݻ޸��݂�ServerAutoCommit���g�p�o���܂���'; //'Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate     = '��������ݻ޸��݂ł��A�g�p�ł��܂���'; //'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transaction�͕ύX������҂��Ă��܂�';  //'Transaction has pending changes';
  E_Failed_To_Post_Datasets = '�S�Ă�datasets�̏����݂Ɏ��s���܂���'; //'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = '�S�Ă�datasets�̃L�����Z���Ɏ��s���܂���'; //'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = '�󔒂�SQL���͒u�������܂���'; //'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'At end of file';
  E_AT_END_OF_CURSOR  = 'At end of cursor';
  E_AT_END_OF_BUFFER  = 'At end of buffer';
  E_AT_END_OF_DATASET = 'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'isc_dsql_sql_info �ł̗\���ł��Ȃ�����'; //'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = '�����ȃf�[�^�ł��iisc_dsql_sql_info����̒l���j'; //'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = '��è�ނȶ��ٖ���ς��邱�Ƃ��o���܂���'; //'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = '��è�ނ�RequestLive��ύX�ł��܂���'; //'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'ذ�޵�ذ��dataset��RequestLive��ύX�ł��܂���'; //'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI              = 'IB_CURSOR�͈�����ł�'; //'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = '��߰Ă��ĂȂ�Column type�ł�: %d'; //'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND         = 'FieldNo: %d �݂͂���܂���'; //'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = 'FieldName: %s �݂͂���܂���'; //'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = '�������ڰ��݇�: %d'; //'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = '�������ڰ��ݖ�: %s'; //'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = '�\���װ IN( value [ , value ... ] )';  //'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = '�\���װ�@BETWEEN value AND value'; //'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'DLL %s �������邱�Ƃ��o���܂���';  //'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = '������SQLKeyFields property�ł�'; //'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR       = '�L�[�f�[�^�Ȃ��ŃJ�[�\�����J�����Ƃ��ł��܂���'; //'Cannot open cursor without key data';
  E_SCROLL_ERROR           = 'ں��ނ͌�����܂���'#10#13'���ق��J����̂Ɏ��s���܂���'; //'Record key was lost'#13#10'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM =  '������ BufferRowNum �ł�'; //'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT      = '�󔒂�statement�͏����ł��܂���'; //'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT   = '�Ӗ��s����statement�����s���悤�Ƃ��܂���'; //'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = '�����ȏz�Q�Ƃł�'; //'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = '�ڑ����Ă��鎞�͕ύX�ł��܂���'; //'Cannot change while connected';
  E_LOGIN_FAILED      = '۸޲݂Ɏ��s���܂���'; //'Login failed';
  E_CANT_GET_CONN_CHR = 'characteristic�̐ڑ����o���܂���'; //'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = '�u���b�N�̃C�x���g�������E���z���܂���'; //'Over maximum events for one block';
  E_PROCESSING_EVENTS = '�C�x���g��'#13#10'�֘A��������Ă܂���'; //'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'Blob�ł��Z�[�u�o���܂���'; //'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'Blob�͂��łɂ���܂����[�h�ł��܂���'; //'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = '���̗�̓L�����Z���o���܂���'; //'Cannot cancel current Row';
  E_CANNOT_POST_ROW  = '���̗�͏����ݏo���܂���'; //'Cannot Post current Row';
  E_DatasetClosed     = 'Dataset�͍쓮���Ă܂���'; //'Dataset is inactive';
  E_DatasetOpen        = 'Dataset�͊J���Ă��܂�'; //'Dataset is currently open';
  E_DatasetCannotScroll = 'Dataset�̓X�N���[���o���܂���'; //'Dataset cannot scroll';
  E_DatasetReadOnly     = 'Dataset�͓Ǎ��ݐ�p�ł�'; //'Dataset is readonly';
  E_DatasetIsFetching    = 'Dataset��Ǎ���ł��܂�'; //'Dataset is currently fetching';
  E_Invalid_KeyRelation   = '������KeyRelation�̒l�ł�'; //'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNum�͎��s����Ă܂���'; //'RowNum is not implemented yet';
  E_RowDeleted            = '���̗�͍폜����Ă��܂�'; //'Row is being deleted';
  E_END_OF_DATASET        = 'Dataset�̏I�[�ł�'; //'At end of Dataset';
  E_BEGINNING_OF_DATASET   =  'Dataset�̐擪�ł�'; //'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'LockWait�͔ߊϓI���b�N�Ɏg�p�ł��܂���'; //'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row      = '���̗�͕ҏW�ł��܂���'; //'Cannot Edit current Row';
  E_Cannot_Insert_Row  = '�V�������}���ł��܂���'; //'Cannot Insert a new Row';
  E_Cannot_Delete_Row = '���̗�͍폜�o���܂���'; //'Cannot delete current Row';
  E_Cannot_Search    = '�����͏o���܂���'; //'Searching is not allowed';
  E_Cannot_Navigate = '����o���܂���'; //'Cannot navigate';
  E_Record_Locked    = '����ں��ނ͑���հ�ނ�ۯ����Ă܂�'; //'Record is locked by another user';
  E_Record_OutOfSynch = '����ں��ނ͑���հ�ނɂ���ĕύX����Ă��܂�'; //'Record was changed by another user';
  E_FLD_READONLY       = '%s �͓Ǎ��ݐ�p�ł�'; //'%s is readonly';
  E_Required_Field       = '%s �͕K�v��field�ł�'; //'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Cached Updates�ł́APostRetaining���g�p�ł��܂���'; //'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = '�����̗���Ăэ���ł��܂�'; //'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = '������ RowsAffected buffer �ł�'; //'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = '�ŏI�s���z���Ă��܂�'; //'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = '�����Ȑ擪�s�ԍ��ł�'; //'Invalid RowNum before Bof';
  E_Invalid_Bookmark = '������ Bookmark �ł�'; //'Invalid Bookmark String';

  E_Assign_Column  = '%s ���珑���ݏo���܂���'; //'Cannot assign from %s';
  E_AssignTo_Column = '%s�@�������ݏo���܂���'; //'Cannot assign to %s';
  E_Value_Out_Of_Range = '�͈͂��z�����l�ł�'; //'Value out of range';
  E_SmallintOverflow = 'Smallint�̵��ް�۰�ł�'; //'Smallint overflow';

  E_Unsupported_Column = '%d �ͻ�߰Ă��Ă��Ȃ�Column type�ł�'; //'Unsupported Column type: %d';
  E_UndefinedMacro = '����`�ȃ}�N���ł�'; //'Undefined macro';
  E_GeneratorFailed = '�l���琬�ł��܂���'; //'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'TIB_BDataset ��c�i IB_Query ) �łȂ���΂����܂���'; //'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'started�̎���ReadOnly�ɕύX�o���܂���'; //'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'started�̎���Isolation��ύX�ł��܂���'; //'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'started�̎���RecVersion��ύX�ł��܂���'; //'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'started�̎���LockWait��ύX�ł��܂���'; //C'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = '�폜�̂��ߎQ�Əo���܂���'; //'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '�^�ϊ��������ł�'; //'53Bit integer�̵��ް�۰�ł�'; //'53bit integer overflow';
  E_Invalid_Typecast = '�^�ϊ��������ł�'; //'Invalid typecast';
  E_Invalid_DataPump_Statement = 'DataPump�̌^�������ł�'; //'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL field�� null ���Z�b�g�o���܂���'; //'NOT NULL field set to null value';
  E_DATABASE_BLANK = 'DatabaseName���󔒂ɂ��Ȃ��ł�������'; //'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = '��߰Ă��ĂȂ�column�͕ϊ��ł��܂���'; //'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'ں��ނ������o���܂���'; //'Unable To Locate Record';
  E_Record_Not_Inserted = '����ں��ނ͑}���o���܂���'; //'Record was not inserted';
  E_Invalid_KeyLinks = '������keyLink��: %s'; //'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search ='�������s�����Ƃ��o���܂���'; //'Unable to perform search';
  E_Unassigned_Blob_Node = '�����݂��o���Ȃ�BlobNOde'; //'Unassigned BlobNode';
  E_Unassigned_Transaction = '��ݻ޸��݂̏����݂��o���܂���'; //'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = '������RowsAffected buffer�ł�'; //'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Graphic���Z�[�u�o���܂���'; //'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = '��ݻ޸��݂��J�n�o���܂���'; //'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'InterBase Client GDS32.DLL���C���X�g�[���o���Ă܂���'; //'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Memo��Ǎ��ݏo���܂���'; //'Could not load memo';
  E_Invalid_DPB_Over_255 = '������ DPB �F�Q�T�T�̕������z���Ă��܂�'; //'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = '�����ȶ���DML���Q�Ƃ��Ă��܂�: %s'; //'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = '�X�V����ں��ނ�������܂���'; //'Record was not located to update';
  E_Record_Not_Located_For_Delete = '�폜����ں��ނ�������܂���'; //'Record was not located to delete';
  E_Init_Default_SQL_Failed = '��̫�� %s �����������邱�Ƃ��o���܂��� '; //'Unable to initialize default %s';
  E_Stringlist_Not_Sorted =  'Stringlist�͂��̃I�y���[�V�����ׂ̈ɕ��ޕ��������Ă�������'; //'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = '�������ɲ���ď����͏o���܂���'; //'Cannot change events while processing';
  E_Cannot_Unregister_Events = '�������ɲ���Ă̊֘A�Â����ł��܂���'; //'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction =  '�����ȓ��� IB_Transaction �ł�'; //'Invalid Internal IB_Transaction';
  E_InvalidStatementType = '������Statement type �ł�'; //'Invalid statement type';
  E_Multiple_Records_Updated = '������ں��ނ��X�V����܂���'; //'Multiple records updated';
  E_Multiple_Records_Deleted =  '�����̂�ں��ނ��폜����܂���'; //'Multiple records deleted';
  E_Multiple_Records_Inserted = '������ں��ނ��}������܂���'; //'Multiple records inserted';
  E_DUP_DB_NAME = 'DatabaseName���d�����Ă��܂�'; //'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = '������DatabaseName�ł�'; //'Invalid DatabaseName';
  E_UnableToSearch = '�������s�����Ƃ��o���܂���'; //'Unable to perform search';
  E_NoRecordsFound = 'ں��ނ�������܂���'; //'No records found';
  E_Session_Undefined = '����݂�����`�ł�'; //'Session is undefined';
  E_NoCircularRef = '�z�Q�Ƃ͋��o���܂���'; //'Circular reference not allowed';
  E_InvalidClassType = '�����ȃN���X�ł�'; //'Invalid class type';
  E_Invalid_RowNum = '�����ȗ�ł�'; //'Invalid RowNum';
  E_Invalid_Syntax = '�����ȕ��@�ł����ʂ��]���������Ă��܂�'; //'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = '�z�� Null �ł�'; //'Array is Null';

  E_Cannot_add_blank_account = '�󔒂̃A�J�E���g�������邱�Ƃ��ł��܂���'; //'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'SYSDBA�̃A�J�E���g�������邱�Ƃ��ł��܂���'; //'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = '�󔒂̃A�J�E���g����邱�Ƃ͂ł��܂���'; //'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'SYSDBA�̃A�J�E���g����邱�Ƃ��ł��܂���'; //'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = '�󔒂̃A�J�E���g��ύX���邱�Ƃ��ł��܂���'; //'Cannot modify blank account';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Unsupported';
  E_NotImplemented = '�������ق͏����𖞂����ĂȂ����ߎ��s�o���܂���'; //'Not implemented at this level';
  E_Invalid_ColData = '������ColData�ł�'; //'Invalid ColData';

  E_Cant_Unprepare_executing_process = '���s���Ă��鏈���������ł��܂���'; //'Cannot Unprepare an executing process';
  E_FileName_Required = '̧�ٖ����K�v�ł�'; //'Filename is required';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'User Account Management';
  L_USERS_ADD = 'Add';
  L_USERS_DELETE = 'Delete';
  L_USERS_MODIFIY = 'Modify';
  L_USERS_ACCOUNT = 'ACCOUNT';
  L_USERS_PASSWORD = 'Password';
  L_USERS_GROUP = 'Group';
  L_USERS_FIRSTNAME = 'First Name';
  L_USERS_MIDDLENAME = 'Middle Name';
  L_USERS_LASTNAME = 'Last Name';

  //IBF_Export
  L_EXPORT_FRM = 'Export';
  L_EXPORT_ASCII = ' File Format ';
  L_EXPORT_FIXED = 'TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV Delimited';
  L_EXPORT_DBF  = 'DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = ' ASCII Options ';
  L_EXPORT_DELIMITER  = 'Delimiter';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Include Headers';
  L_EXPORT_INCLUDECRLF  = 'Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Comma Separated Text Files ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = '��Ƃ𒆎~���܂���낵���ł����H'; //'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Query�̌��ʂ���o���܂�'; //'Fetching Query Results';
  M_Row_Num = 'Row# %d';
  M_Abort_Fetching_Btn = 'Abort';

  M_Login_Database = 'Database';
  M_Login_User = 'User';
  M_Login_Password = 'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancel';
  M_Login_Help_Btn = '&Help';
  M_Login_Dialog_Caption = 'Login Dialog';

  M_Loading_Caption = '�Ǎ��ݒ�...'; //'Loading...';

  M_SB_REC_CNT = 'Records counted: %d';
  M_Save_Changes = '�ύX���ނ��܂���?'; //'Save changes?';
  M_Abort_Changes = '�ύX�͎����܂��@���s���Ă�낵���ł����H'; //'Changes will be lost. Ok to proceed?';

  M_CancelTransactionPrompt = '�S�Ă̕ύX�𒆎~���܂���낵���ł����H'; //'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = '���̽���߯Ă̎��s�𒆎~���܂����H'; //'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = '���̽���߯Ă̎��s�𑱂��܂���?'; //'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = '����߯Ă͎��s���ł�'; //'Script is currently executing';
  M_SCRIPT_FAILED = '���̽���߯Ă͎��s���܂���'; //'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = '����߯Ă̎��s�͒��~���܂���'; //'Script execution was aborted';
  M_SCRIPT_COMPLETED = '���Ȃ�����߯Ă͊������܂���'; //'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = '����߯Ă͊������܂������A��O������܂�'; //'Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'Modified';
  M_SCRIPT_SAVE_CHANGES = '�ύX���ނ��܂���?'; //'Save changes?';

{ Button captions }

  C_BTN_TODAY = 'Today';
  C_BTN_CLEAR = 'Clear';

  C_SG_Parameter = 'Parameter';
  C_SG_Field = 'Field';
  C_SG_Name = 'Name';
  C_SG_Type = 'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'Value';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Cancel';
  C_BF_CANCEL_ACCEL = '&Cancel';
  C_BF_APPLY = 'Apply';
  C_BF_HELP = 'Help';
  C_BF_EXECUTE = 'Execute';
  C_BF_CLOSE = 'Close';
  C_BF_CLOSE_ACCEL = '&Close';
  C_BF_FINISH = 'Finish';
  C_BF_FINISH_ACCEL = '&Finish';

  C_FRM_Ordering = 'Ordering';

  C_CB_WordWrap = 'Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'RowsAffected: ';
  M_SQL_RowsCounted = 'Rows Counted: ';
  M_SQL_SessionBusy = 'Session is currently busy';
  M_SQL_CompleteTransaction = '��ݻ޸��݂��I�����Ă�������'; //'Please complete your transaction';
  M_SQL_CannotDeleteDefaultGroup = '��̫�ĸ�ٰ�߂͍폜�ł��܂���'; //'The default group cannot be deleted';
  M_SQL_ReservedName = '���̖��O�͗\�񂳂�Ă܂�'; //'This name is reserved: ';
  M_SQL_BackSlashNotAllowed = '�ޯ��ׯ���͔F�߂��܂���'; //'A back slash is not allowed';
  M_SQL_BlankNameNotAllowed = '�󔒖��͔F�߂��܂���'; //'A blank name is not allowed';
  M_SQL_RowsFetched = '�����̗���ް���Ǎ��݂܂���'; //'Rows Fetched: ';
  M_SQL_ConfirmDBCreation = '����database���쐬���Ă�낵���ł����H'; //'Are you sure you want to create this database?';
  M_SQL_ConfirmNoOtherDBSameName = '�������O��database������܂��m�F���Ă�������'; //'Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = '����database���폜���Ă�낵���ł���'; //'Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = '����database�͊��S�ɍ폜���܂�'+#13#10+#13#10'�����Ă�낵���ł���'; //'This database will be permanently removed.'+#13#10+#13#10'Continue anyway?';
  M_SQL_AskFormName = 'query�`���̖��O����͂��Ă�������'; //'Enter query form name:';
  M_SQL_AskGroupName = '��ٰ�ߖ�����͂��Ă�������'; //'Enter group name:';
  M_SQL_AskLayoutName = 'ڲ��Ė�����͂��Ă�������'; //'Enter layout name:';
  M_SQL_ConfirmGroupDeletion = '���� %s ��ٰ�߂��ׂĂ��폜���Ă�낵���ł����H'; //'Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = '%s ڲ��Ă��폜���Ă�낵���ł����H'; //'Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = '�ċA�I�Ⱥ�߰�͔F�߂��܂���'; //'Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = '���ڂ�����ٸد����邩���ڂ�I��Ŵ������������ĉ�����'; //'Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = '���Ұ���̒l�ł�'; //'Parameter value';
  M_GCSQL_TypeAValueFor = 'Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = '%s �̒l����͂��Ă�������'; //'This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Data Pump�͂܂������Ă��܂�'; //'Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = '��낵���ł���'; //'Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Database��I��ł�������';//'Select Source Database';
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
  C_wbExtractBtnHint    = 'Extract DDL';
  C_wbExtractBtnCaption = 'Extract';
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

  H_UB_EDIT = 'Edit Row';
  H_UB_INSERT = 'Insert Row';
  H_UB_DELETE = 'Delete Row';
  H_UB_REFRESH = 'Refresh all records';
  H_UB_REFRESHKEYS = 'Refresh record keys';
  H_UB_REFRESHROWS = 'Refresh record rows';
  H_UB_REFRESHFILTROWS = 'Refresh filtered rows';
  H_UB_POSTSEARCH = 'Post search criteria';
  H_UB_CANCELSEARCH = 'Cancel search criteria';
  H_UB_POSTEDIT = 'Post edits';
  H_UB_CANCELEDIT = 'Cancel edits';
  H_UB_POSTINSERT = 'Post insert';
  H_UB_CANCELINSERT = 'Cancel insert';
  H_UB_POSTDELETE = 'Post delete';
  H_UB_CANCELDELETE = 'Cancel delete';
  H_UB_POST = 'Post changes';
  H_UB_CANCEL = 'Cancel changes';

  H_NB_FIRST = 'First Row';
  H_NB_PRIOR = 'Prior Row';
  H_NB_NEXT = 'Next Row';
  H_NB_LAST = 'Last Row';
  H_NB_JUMPBCK = 'Backwards';
  H_NB_JUMPFWD = 'Forwards';

  H_SB_ORDER = 'Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Recall Last Search Criteria';
  H_SB_SEARCH = 'Search Dataset';
  H_SB_SAVE_CRITERIA = 'Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Recall Criteria';
  H_SB_SEARCHCOUNT = 'Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Count Rows in Dataset';

  H_TB_StartTransaction = 'Start Transaction';
  H_TB_PostDatasets = 'Post Datasets';
  H_TB_CancelDatasets = 'Cancel Datasets';
  H_TB_SavePoint = 'Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Commit and End Current Transaction';
  H_TB_Rollback = 'Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Rollback and Retain Current Transaction';
  H_TB_Close = 'Close Current Transaction';

  H_ST_Prepare_Statement = 'Prepare Statement';
  H_ST_Unprepare_Statement = 'Unprepare Statement';
  H_ST_Execute_Statement = 'Execute Statement';

  H_DS_Open_Dataset = 'Open Dataset';
  H_DS_Close_Dataset = 'Close Dataset';
  H_DS_Prepare_Dataset = 'Prepare Dataset';
  H_DS_Unprepare_Dataset = 'Unprepare Dataset';
  H_DS_ReadOnly_Dataset = 'Read Only Dataset';

  H_CB_Create_Database = 'Create Database';
  H_CB_Connect_Database = 'Connect Database';
  H_CB_Disconnect_Database = 'Disconnect Database';
  H_CB_Drop_Database = 'Drop Database';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Export from SELECT statement';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Missing entry for Ascii file';
  eNoDestTableEntry          = 'Missing entry for destination table';
  eAsciiFileNotFound         = 'Ascii file %s not found';
  eIniFileNotFound           = 'Ini-file %s not found';
  eNoAsciiFileAccess         = 'Could not open ascii file %s';
  eInvalidCharFound          = 'Invalid char / format error in ascii file';
  eOutOfMemory               = 'Out of memory';
  eFieldDescriptionError     = 'Error in field description';
  eWrongAsciiFieldCount      = 'Wrong field count in ascii file';
  eWrongDecimalCount         = 'Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth           = 'Wrong field width in ascii file';

  // Dialog Labels - IB_Import
  lblRecsReadedCaption       = 'Total Records read';
  lblRecsCommentedCaption    = 'Records commented';
  lblRecsInsertedCaption     = 'Records inserted';
  btnAbortImportCaption      = 'Abort';

implementation

end.