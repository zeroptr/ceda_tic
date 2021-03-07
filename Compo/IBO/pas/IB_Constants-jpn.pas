
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

  E_CONNECTED         = 'Connectionは既に出来ています'; //'Connection has already been established';
  E_NOT_CONNECTED     = 'Connectionはまだ出来ていません'; //'Connection has not been established';
  E_Invalid_conn_path =  'このパスは無効です'; //'Invalid connection path';
  E_Cant_Repl_Int_Tr  = 'ﾃﾞﾌｫﾙﾄでは、内部ﾄﾗﾝｻﾞｸｼｮﾝに置換えることが出来ません'; //'Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'ﾄﾗﾝｻﾞｸｼｮﾝは始まっていません'; //'Transaction has not been started';
  E_TRANS_STARTED     = 'ﾄﾗﾝｻﾞｸｼｮﾝは既に始まっています'; //'Transaction has already been started';
  E_NO_CONNECTIONS    = 'ﾄﾗﾝｻﾞｸｼｮﾝはconnectionされてません'; //'Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'ﾄﾗﾝｻﾞｸｼｮﾝはひとつもしくはそれ以上のconnectionを見失いました';  //'Transaction is missing one or more connections';
  E_CONN_LOADING      = '警告：connectionはまだloadしています';  //'Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Connectionはすべて同じIB_Sessionになくてはいけません'; //'Connections must all be in the same IB_Session';
  E_TransactionPaused = 'ﾄﾗﾝｻﾞｸｼｮﾝは中断されます'; //'Transaction is Paused';
  E_ALLOCATED         = 'Statementは既に割当てられました'; //'Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Statementは割当て、ていません'; //'Statement has not been allocated';
  E_PREPARED          = 'Statementは既に準備されてます'; //'Statement has already been prepared';
  E_NOT_PREPARED      = 'Statementは準備されていません'; //'Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Statementの準備に失敗しました'; //'Statement failed to prepare';
  E_OPENED            = 'Statementは既に開いています';  //'Statement has already been opened';
  E_NOT_OPENED        = 'Statementは開いていません';  //'Statement has not been opened';
  E_CANT_DELETE       = 'このレコードでは削除できません'; //'Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'StatementをIB_Connectionに割当てください'; //'Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'IB_Connectionを開けることが出来ません'; //'Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'IB_Transactionを割当てください'; //'Must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = '実行すべきﾄﾗﾝｻﾞｸｼｮﾝがありません'; //'No active transaction to execute with';
  E_START_FAILED      = 'ﾄﾗﾝｻﾞｸｼｮﾝを始めることができません'; // 'Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = '明示的なﾄﾗﾝｻﾞｸｼｮﾝはServerAutoCommitを使用出来ません'; //'Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate     = '無効なﾄﾗﾝｻﾞｸｼｮﾝです、使用できません'; //'Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Transactionは変更処理を待っています';  //'Transaction has pending changes';
  E_Failed_To_Post_Datasets = '全てのdatasetsの書込みに失敗しました'; //'Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = '全てのdatasetsのキャンセルに失敗しました'; //'Failed to cancel all datasets';
  E_UpdateWrongTrn    = 'Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = '空白のSQL文は置換えられません'; //'Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'At end of file';
  E_AT_END_OF_CURSOR  = 'At end of cursor';
  E_AT_END_OF_BUFFER  = 'At end of buffer';
  E_AT_END_OF_DATASET = 'At end of dataset';
  E_BAD_SQL_INF_LEN   = 'isc_dsql_sql_info での予測できない長さ'; //'Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = '無効なデータです（isc_dsql_sql_infoからの値が）'; //'Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'ｱｸﾃｨﾌﾞなｶｰｿﾙ名を変えることが出来ません'; //'Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'ｱｸﾃｨﾌﾞなRequestLiveを変更できません'; //'Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'ﾘｰﾄﾞｵﾝﾘｰのdatasetはRequestLiveを変更できません'; //'Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI              = 'IB_CURSORは一方向です'; //'IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'ｻﾎﾟｰﾄしてないColumn typeです: %d'; //'Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND         = 'FieldNo: %d はみつかりません'; //'FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = 'FieldName: %s はみつかりません'; //'FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO   = '無効なﾘﾚｰｼｮﾝ№: %d'; //'Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = '無効なﾘﾚｰｼｮﾝ名: %s'; //'Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN              = '構文ｴﾗｰ IN( value [ , value ... ] )';  //'IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN         = '構文ｴﾗｰ　BETWEEN value AND value'; //'BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'DLL %s を見つけることが出来ません';  //'Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = '無効のSQLKeyFields propertyです'; //'Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR       = 'キーデータなしでカーソルを開くことができません'; //'Cannot open cursor without key data';
  E_SCROLL_ERROR           = 'ﾚｺｰﾄﾞは見つかりません'#10#13'ｶｰｿﾙを開けるのに失敗しました'; //'Record key was lost'#13#10'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM =  '無効な BufferRowNum です'; //'Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT      = '空白のstatementは準備できません'; //'Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT   = '意味不明のstatementを実行しようとしました'; //'Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = '無効な循環参照です'; //'Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = '接続している時は変更できません'; //'Cannot change while connected';
  E_LOGIN_FAILED      = 'ﾛｸﾞｲﾝに失敗しました'; //'Login failed';
  E_CANT_GET_CONN_CHR = 'characteristicの接続が出来ません'; //'Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = 'ブロックのイベント数が限界を越えました'; //'Over maximum events for one block';
  E_PROCESSING_EVENTS = 'イベントが'#13#10'関連ずけされてません'; //'Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'Blobですセーブ出来ません'; //'Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'Blobはすでにありますロードできません'; //'Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'この列はキャンセル出来ません'; //'Cannot cancel current Row';
  E_CANNOT_POST_ROW  = 'この列は書込み出来ません'; //'Cannot Post current Row';
  E_DatasetClosed     = 'Datasetは作動してません'; //'Dataset is inactive';
  E_DatasetOpen        = 'Datasetは開いています'; //'Dataset is currently open';
  E_DatasetCannotScroll = 'Datasetはスクロール出来ません'; //'Dataset cannot scroll';
  E_DatasetReadOnly     = 'Datasetは読込み専用です'; //'Dataset is readonly';
  E_DatasetIsFetching    = 'Datasetを読込んでいます'; //'Dataset is currently fetching';
  E_Invalid_KeyRelation   = '無効なKeyRelationの値です'; //'Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNumは実行されてません'; //'RowNum is not implemented yet';
  E_RowDeleted            = 'この列は削除されています'; //'Row is being deleted';
  E_END_OF_DATASET        = 'Datasetの終端です'; //'At end of Dataset';
  E_BEGINNING_OF_DATASET   =  'Datasetの先頭です'; //'At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'LockWaitは悲観的ロックに使用できません'; //'Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row      = 'この列は編集できません'; //'Cannot Edit current Row';
  E_Cannot_Insert_Row  = '新しい列を挿入できません'; //'Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'この列は削除出来ません'; //'Cannot delete current Row';
  E_Cannot_Search    = '検索は出来ません'; //'Searching is not allowed';
  E_Cannot_Navigate = '操作出来ません'; //'Cannot navigate';
  E_Record_Locked    = 'このﾚｺｰﾄﾞは他のﾕｰｻﾞがﾛｯｸしてます'; //'Record is locked by another user';
  E_Record_OutOfSynch = 'このﾚｺｰﾄﾞは他のﾕｰｻﾞによって変更されています'; //'Record was changed by another user';
  E_FLD_READONLY       = '%s は読込み専用です'; //'%s is readonly';
  E_Required_Field       = '%s は必要なfieldです'; //'%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Cached Updatesでは、PostRetainingを使用できません'; //'Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = '多数の列を呼び込んでいます'; //'Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = '無効な RowsAffected buffer です'; //'Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = '最終行を越えています'; //'Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = '無効な先頭行番号です'; //'Invalid RowNum before Bof';
  E_Invalid_Bookmark = '無効な Bookmark です'; //'Invalid Bookmark String';

  E_Assign_Column  = '%s から書込み出来ません'; //'Cannot assign from %s';
  E_AssignTo_Column = '%s　を書込み出来ません'; //'Cannot assign to %s';
  E_Value_Out_Of_Range = '範囲を越えた値です'; //'Value out of range';
  E_SmallintOverflow = 'Smallintのｵｰﾊﾞｰﾌﾛｰです'; //'Smallint overflow';

  E_Unsupported_Column = '%d はｻﾎﾟｰﾄしていないColumn typeです'; //'Unsupported Column type: %d';
  E_UndefinedMacro = '未定義なマクロです'; //'Undefined macro';
  E_GeneratorFailed = '値を育成できません'; //'Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'TIB_BDataset 先祖（ IB_Query ) でなければいけません'; //'Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'startedの時はReadOnlyに変更出来ません'; //'Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'startedの時はIsolationを変更できません'; //'Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'startedの時はRecVersionを変更できません'; //'Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'startedの時はLockWaitを変更できません'; //C'Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = '削除のため参照出来ません'; //'Invalid reference to Delete';
  E_53BIT_OVERFLOW = '型変換が無効です'; //'53Bit integerのｵｰﾊﾞｰﾌﾛｰです'; //'53bit integer overflow';
  E_Invalid_Typecast = '型変換が無効です'; //'Invalid typecast';
  E_Invalid_DataPump_Statement = 'DataPumpの型が無効です'; //'Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'NOT NULL fieldに null をセット出来ません'; //'NOT NULL field set to null value';
  E_DATABASE_BLANK = 'DatabaseNameを空白にしないでください'; //'DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'ｻﾎﾟｰﾄしてないcolumnは変換できません'; //'Unsupported column conversion';
  E_Unable_To_Locate_Record = 'ﾚｺｰﾄﾞを検索出来ません'; //'Unable To Locate Record';
  E_Record_Not_Inserted = 'このﾚｺｰﾄﾞは挿入出来ません'; //'Record was not inserted';
  E_Invalid_KeyLinks = '無効なkeyLink名: %s'; //'Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search ='検索を行うことが出来ません'; //'Unable to perform search';
  E_Unassigned_Blob_Node = '書込みが出来ないBlobNOde'; //'Unassigned BlobNode';
  E_Unassigned_Transaction = 'ﾄﾗﾝｻﾞｸｼｮﾝの書込みが出来ません'; //'Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = '無効なRowsAffected bufferです'; //'Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Graphicをセーブ出来ません'; //'Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'ﾄﾗﾝｻﾞｸｼｮﾝを開始出来ません'; //'Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'InterBase Client GDS32.DLLがインストール出来てません'; //'InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Memoを読込み出来ません'; //'Could not load memo';
  E_Invalid_DPB_Over_255 = '無効な DPB ：２５５の文字を越えています'; //'Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = '無効なｶｽﾀﾑDMLを参照しています: %s'; //'Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = '更新するﾚｺｰﾄﾞが見つかりません'; //'Record was not located to update';
  E_Record_Not_Located_For_Delete = '削除するﾚｺｰﾄﾞが見つかりません'; //'Record was not located to delete';
  E_Init_Default_SQL_Failed = 'ﾃﾞﾌｫﾙﾄ %s を初期化することが出来ません '; //'Unable to initialize default %s';
  E_Stringlist_Not_Sorted =  'Stringlistはこのオペレーションの為に分類分けをしてください'; //'Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = '処理中にｲﾍﾞﾝﾄ処理は出来ません'; //'Cannot change events while processing';
  E_Cannot_Unregister_Events = '処理中にｲﾍﾞﾝﾄの関連づけができません'; //'Cannot unregister events while processing';
  E_Invalid_Internal_Transaction =  '無効な内部 IB_Transaction です'; //'Invalid Internal IB_Transaction';
  E_InvalidStatementType = '無効なStatement type です'; //'Invalid statement type';
  E_Multiple_Records_Updated = '複数のﾚｺｰﾄﾞが更新されました'; //'Multiple records updated';
  E_Multiple_Records_Deleted =  '複数ののﾚｺｰﾄﾞが削除されました'; //'Multiple records deleted';
  E_Multiple_Records_Inserted = '複数のﾚｺｰﾄﾞが挿入されました'; //'Multiple records inserted';
  E_DUP_DB_NAME = 'DatabaseNameが重複しています'; //'Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = '無効なDatabaseNameです'; //'Invalid DatabaseName';
  E_UnableToSearch = '検索を行うことが出来ません'; //'Unable to perform search';
  E_NoRecordsFound = 'ﾚｺｰﾄﾞが見つかりません'; //'No records found';
  E_Session_Undefined = 'ｾｯｼｮﾝが未定義です'; //'Session is undefined';
  E_NoCircularRef = '循環参照は許可出来ません'; //'Circular reference not allowed';
  E_InvalidClassType = '無効なクラスです'; //'Invalid class type';
  E_Invalid_RowNum = '無効な列です'; //'Invalid RowNum';
  E_Invalid_Syntax = '無効な文法です括弧が余分か抜けています'; //'Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = '配列が Null です'; //'Array is Null';

  E_Cannot_add_blank_account = '空白のアカウントを加えることができません'; //'Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'SYSDBAのアカウントを加えることができません'; //'Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = '空白のアカウントを削ることはできません'; //'Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'SYSDBAのアカウントを削ることができません'; //'Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = '空白のアカウントを変更することができません'; //'Cannot modify blank account';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Unsupported';
  E_NotImplemented = 'このﾚﾍﾞﾙは条件を満たしてないため実行出来ません'; //'Not implemented at this level';
  E_Invalid_ColData = '無効なColDataです'; //'Invalid ColData';

  E_Cant_Unprepare_executing_process = '実行している処理を解除できません'; //'Cannot Unprepare an executing process';
  E_FileName_Required = 'ﾌｧｲﾙ名が必要です'; //'Filename is required';

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

  M_Abort_Fetching = '作業を中止しますよろしいですか？'; //'Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Queryの結果を取出します'; //'Fetching Query Results';
  M_Row_Num = 'Row# %d';
  M_Abort_Fetching_Btn = 'Abort';

  M_Login_Database = 'Database';
  M_Login_User = 'User';
  M_Login_Password = 'Password';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancel';
  M_Login_Help_Btn = '&Help';
  M_Login_Dialog_Caption = 'Login Dialog';

  M_Loading_Caption = '読込み中...'; //'Loading...';

  M_SB_REC_CNT = 'Records counted: %d';
  M_Save_Changes = '変更をｾｰﾌﾞしますか?'; //'Save changes?';
  M_Abort_Changes = '変更は失われます　実行してよろしいですか？'; //'Changes will be lost. Ok to proceed?';

  M_CancelTransactionPrompt = '全ての変更を中止しますよろしいですか？'; //'Are you sure you want to cancel all changes?';

  M_SCRIPT_ABORT_EXECUTE = 'このｽｸﾘﾌﾟｯﾄの実行を中止しますか？'; //'Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'このｽｸﾘﾌﾟｯﾄの実行を続けますか?'; //'Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'ｽｸﾘﾌﾟｯﾄは実行中です'; //'Script is currently executing';
  M_SCRIPT_FAILED = 'このｽｸﾘﾌﾟｯﾄは失敗しました'; //'Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'ｽｸﾘﾌﾟｯﾄの実行は中止しました'; //'Script execution was aborted';
  M_SCRIPT_COMPLETED = '問題なくｽｸﾘﾌﾟｯﾄは完了しました'; //'Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'ｽｸﾘﾌﾟｯﾄは完了しましたが、例外があります'; //'Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'Modified';
  M_SCRIPT_SAVE_CHANGES = '変更をｾｰﾌﾞしますか?'; //'Save changes?';

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
  M_SQL_CompleteTransaction = 'ﾄﾗﾝｻﾞｸｼｮﾝを終了してください'; //'Please complete your transaction';
  M_SQL_CannotDeleteDefaultGroup = 'ﾃﾞﾌｫﾙﾄｸﾞﾙｰﾌﾟは削除できません'; //'The default group cannot be deleted';
  M_SQL_ReservedName = 'この名前は予約されてます'; //'This name is reserved: ';
  M_SQL_BackSlashNotAllowed = 'ﾊﾞｯｸｽﾗｯｼｭは認められません'; //'A back slash is not allowed';
  M_SQL_BlankNameNotAllowed = '空白名は認められません'; //'A blank name is not allowed';
  M_SQL_RowsFetched = 'これらの列のﾃﾞｰﾀを読込みました'; //'Rows Fetched: ';
  M_SQL_ConfirmDBCreation = 'このdatabaseを作成してよろしいですか？'; //'Are you sure you want to create this database?';
  M_SQL_ConfirmNoOtherDBSameName = '同じ名前のdatabaseがあります確認してください'; //'Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = 'このdatabaseを削除してよろしいですか'; //'Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = 'このdatabaseは完全に削除します'+#13#10+#13#10'続けてよろしいですか'; //'This database will be permanently removed.'+#13#10+#13#10'Continue anyway?';
  M_SQL_AskFormName = 'query形式の名前を入力してください'; //'Enter query form name:';
  M_SQL_AskGroupName = 'ｸﾞﾙｰﾌﾟ名を入力してください'; //'Enter group name:';
  M_SQL_AskLayoutName = 'ﾚｲｱｳﾄ名を入力してください'; //'Enter layout name:';
  M_SQL_ConfirmGroupDeletion = 'この %s ｸﾞﾙｰﾌﾟすべてを削除してよろしいですか？'; //'Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = '%s ﾚｲｱｳﾄを削除してよろしいですか？'; //'Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = '再帰的なｺﾋﾟｰは認められません'; //'Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = '項目をﾀﾞﾌﾞﾙｸﾘｯｸするか項目を選んでｴﾝﾀｰｷｰを押して下さい'; //'Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'ﾊﾟﾗﾒｰﾀｰの値です'; //'Parameter value';
  M_GCSQL_TypeAValueFor = 'Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = '%s の値を入力してください'; //'This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Data Pumpはまだ動いています'; //'Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'よろしいですか'; //'Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Databaseを選んでください';//'Select Source Database';
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