
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
{  Additions or modifications lised below using format:                        }
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
{ Translated by: Michael Muza <m2m@mail.ru>                                    }
{ edited and added by: Oliph <khabibr@mail.ru>   http://www.oliph.hut.ru       }
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
  IB_ISC_ERR_CODE_MSG = 'КОД ОШИБКИ ISC:';
  IB_ISC_ERR_MSG_MSG  = 'СООБЩЕНИЕ ОШИБКИ ISC:';
  IB_SQL_ERR_CODE_MSG = 'КОД ОШИБКИ SQL:';
  IB_SQL_ERR_MSG_MSG  = 'СООБЩЕНИЕ ОШИБКИ SQL:';

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

  IB_REG_MESSAGE = 'Благодарим за выбор IB Objects.'#10#13#10#13 +
                   'Обращайтесь пожалуйста на http://www.ibobjects.com и регистрируйтесь сегодня.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Соединение уже было установлено';
  E_NOT_CONNECTED     = 'Соединение не было установлено';
  E_Invalid_conn_path = 'Неверный путь для соединения';
  E_Cant_Repl_Int_Tr  = 'Невозможно заменить внутреннюю (по умолчанию) транзакцию';
  E_NO_TRANS_STARTED  = 'Транзакция не стартовала';
  E_TRANS_STARTED     = 'Транзакция уже стартовала';
  E_NO_CONNECTIONS    = 'Транзакция не имеет соединений';
  E_NOT_ENOUGH_CONN   = 'Транзакции недостает одного или более соединений';
  E_CONN_LOADING      = 'Предупреждение: Соединение все еще устанавливается';
  E_TRANS_CONN_SESS   = 'Все соединения должны быть все в одном и том же IB_Session';
  E_TransactionPaused = 'Транзакция приостановлена';
  E_ALLOCATED         = 'SQL-запрос уже назначен';
  E_NOT_ALLOCATED     = 'SQL-запрос не был размещен';
  E_PREPARED          = 'SQL-запрос уже был подготовлен';
  E_NOT_PREPARED      = 'SQL-запрос не был подготовлен';
  E_FAILED_TO_PREPARE = 'SQL-запрос не может быть подготовлен';
  E_OPENED            = 'SQL-запрос уже был открыт';
  E_NOT_OPENED        = 'SQL-запрос не был открыт';
  E_CANT_DELETE       = 'Текущая запись в курсоре не может быть удалена';
  E_NO_CONNECTION     = 'SQL-запрос должен иметь назначенное IB_Connection';
  E_CONNECT_FAILED    = 'Невозможно открыть IB_Connection';
  E_NO_TRANSACTION    = 'SQL-запрос должен иметь назначенную транзакцию';
  E_NO_ACTIVE_TRANS   = 'Нет активных транзакций, чтобы выполнить запрос';
  E_START_FAILED      = 'Невозможно стартовать транзакцию';
  E_SVRAUTOCMT_NOEXP  = 'Явная транзакция недопустима с ServerAutoCommit';
  E_Cannot_Activate     = 'Неверное состояние транзакции. Невозможно активизировать';
  E_Transaction_Is_Active = 'Транзакция рассматривает изменения';
  E_Failed_To_Post_Datasets = 'Невозможно подвердить изменения во всех наборах данных';
  E_Failed_To_Cancel_Datasets = 'Невозможно отменить изменения во всех наборах данных';
  E_UpdateWrongTrn    = 'Невозможно сделать изменения, %s - не принадлежит %s';
  E_NO_BLANK_SQL      = 'Пустое SQL-предложение недопустимо';
  E_AT_END_OF_FILE    = 'Конец файла';
  E_AT_END_OF_CURSOR  = 'Конец "курсора"';
  E_AT_END_OF_BUFFER  = 'Конец буфера';
  E_AT_END_OF_DATASET = 'Конец набора данных';
  E_BAD_SQL_INF_LEN   = 'Непредвиденная длина в isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Неправильные данные возвращенные из isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Невозможно изменить имя курсора, пока активно';
  E_REQUEST_LIVE_ACTIVE = 'Невозможно изменить свойство RequestLive, пока активно';
  E_REQUEST_LIVE_READONLY = 'Невозможно использование RequestLive для набора данных только для чтения';
  E_CURSOR_UNI              = 'IB_CURSOR - однонаправленный';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Неподдерживаемый тип поля: %d';
  E_FIELDNO_NOT_FOUND         = 'Номер поля: %d не найден';
  E_FIELDNAME_NOT_FOUND        = 'Имя поля "%s" не найдено';
  E_INVALID_FOCUS_RELATION_NO   = 'Неправильный номер отношения (Focused Relation): %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Неправильное имя отношения (Focused Relation): %s';
  E_INVALID_QBE_IN              = 'IN( значение [ , значение ... ] ) - синтаксическая ошибка';
  E_INVALID_QBE_BETWEEN         = 'BETWEEN значение AND значение - синтаксическая ошибка';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Невозможно найти импорт DLL "%s"';
  E_INVALID_SQL_KEY_FIELDS  = 'Неправильное свойство SQLKeyFields';
  E_GET_CURSOR_ERROR       = 'Невозможно открыть курсор без ключа';
  E_SCROLL_ERROR           = 'Ключ записи был потерян'#10#13'Невозможно открыть курсор';
  E_INVALID_BUFFER_ROW_NUM = 'Неверный BufferRowNum в начале';
  E_BLANK_STATEMENT      = 'Невозможно подготовить пустой SQL-запрос';
  E_UNKNOWN_STATEMENT   = 'Попытка выполнить неизвестный SQL-оператор';
  E_CIRCULAR_REFERENCE = 'Циклическая ссылка не допускается';
  E_CANT_CHG_WITH_CONN = 'Невозможно сделать изменения, пока установлено соединение';
  E_LOGIN_FAILED      = 'Подключение невозможно';
  E_CANT_GET_CONN_CHR = 'Невозможно получить характеристики соединения';
  E_MAX_EVENTS_BLOCK  = 'Превышение максимального количества событий для одного блока';
  E_PROCESSING_EVENTS = 'Обработка событий '#13#10'Нельзя отменить регистрацию';
  E_CANT_STORE_BLOB  = 'Blob уже был или не мог быть сохранен';
  E_CANT_LOAD_BLOB   = 'Blob уже был или не мог быть загружен';
  E_CANNOT_CANCEL_ROW = 'Невозможно отменить изменения в текущей записи';
  E_CANNOT_POST_ROW  = 'Невозможно подтвердить изменения в текущей записи';
  E_DatasetClosed     = 'Набор данных неактивен';
  E_DatasetOpen        = 'Набор данных в данное время открыт';
  E_DatasetCannotScroll = 'Невозможно перемещаться по набору данных';
  E_DatasetReadOnly     = 'Набор данных только для чтения';
  E_DatasetIsFetching    = 'Набор данных в данное время принимает значения';
  E_Invalid_KeyRelation   = 'Неправильное значение KeyRelation';
  E_RowNum_Not_Implemented = 'Пока невозможно установить RowNum';
  E_RowDeleted            = 'Запись была удалена';
  E_END_OF_DATASET        = 'Конец набора данных';
  E_BEGINNING_OF_DATASET   = 'Начало набора данных';
  E_Cannot_Pessimistic_Lock = 'Невозможно использовать пессимистичную блокировку с LockWait';
  E_Cannot_Edit_Row      = 'Невозможно редактировать текущую запись';
  E_Cannot_Insert_Row  = 'Невозможно вставить новую запись';
  E_Cannot_Delete_Row = 'Невозможно удалить текущую запись';
  E_Cannot_Search    = 'Поиск не позволен';
  E_Cannot_Navigate = 'Невозможно перемещаться';
  E_Record_Locked    = 'Запись заблокирована другим пользователем';
  E_Record_OutOfSynch = 'Запись была изменена другим пользователем';
  E_FLD_READONLY       = 'Поле "%s" - только для чтения';
  E_Required_Field       = 'Не заполнено поле "%s"';
  E_NO_POSTRTN_CACHED_UPDT = 'Невозможно использовать PostRetaining с кэшированными изменениями';
  E_Multiple_Rows_In_Singleton = 'Множественные записи в одиночной выборке';

  E_InvalidRowsAffectedBuf = 'Неправильный буфер RowsAffected';
  E_Invalid_RowNum_Past_Eof = 'Неправильный RowNum - за концом';
  E_Invalid_RowNum_Before_Bof = 'Неправильный RowNum - перед началом';
  E_Invalid_Bookmark = 'Неправильная строка закладки (Bookmark)';

  E_Assign_Column  = 'Невозможно назначить из поля "%s"';
  E_AssignTo_Column = 'Невозможно назначить полю "%s"';
  E_Value_Out_Of_Range = 'Значение вышло за границы диапазона';
  E_SmallintOverflow = 'Переполнение Smallint';
  E_IntegerOverflow = 'Переполнение Integer';
  E_Int64Overflow = 'Переполнение Int64';
  
  E_Unsupported_Column = 'Неподдерживаемый тип поля: %d';
  E_UndefinedMacro = 'Неопределенный макрос';
  E_GeneratorFailed = 'Невозможно получить значение генератора';

  E_MustBe_Buffered_Dataset = '(IB_Query) должен быть наследником TIB_BDataset';

  E_NO_CHANGE_READONLY = 'Невозможно изменить ReadOnly после старта';
  E_NO_CHANGE_ISOLATION = 'Невозможно изменить Isolation после старта';
  E_NO_CHANGE_RECVERSION = 'Невозможно изменить RecVersion после старта';
  E_NO_CHANGE_LOCKWAIT = 'Невозможно изменить LockWait после старта';

  E_Invalid_Reference_To_Delete = 'Неверная ссылка для удаления';
  E_Invalid_Typecast = 'Несоответствие типов';
  E_Invalid_DataPump_Statement = 'Неверный тип оператора для DataPump';
  E_FIELD_NOT_NULLABLE = 'Ненулевое поле (NOT NULL) не может иметь значение null';
  E_DATABASE_BLANK = 'DatabaseName не может быть пустым';
  E_Unsupp_Col_Conversion = 'Неподдерживаемое преобразование поля';
  E_Unable_To_Locate_Record = 'Невозможно найти запись';
  E_Record_Not_Inserted = 'Запись не была добавлена';
  E_Invalid_KeyLinks = 'Неправильное вхождение KeyLinks: %s';
  E_Unable_to_perform_search = 'Невозможно выполнить поиск';
  E_Unassigned_Blob_Node = 'Неназначенный BlobNode';
  E_Unassigned_Transaction = 'Неназначенная Transaction';
  E_Invalid_RowsAffected_Buffer = 'Неправильный буфер RowsAffected';
  E_Unable_Save_Graphic = 'Невозможно сохранить как графику';
  E_Cannot_Activate_Transaction = 'Невозможно активизировать транзакцию';
  E_IB_Client_Not_Installed = 'Не установлен InterBase клиент GDS32.DLL';
  E_Could_Not_Load_Memo = 'Невозможно загрузить memo';
  E_Invalid_DPB_Over_255 = 'Неправильный DPB: содержит более 255 символов';
  E_Inv_Custom_DML = 'Неправильное DML описание поля: %s';
  E_Record_Not_Located_For_Update = 'Запись для изменения не найдена';
  E_Record_Not_Located_For_Delete = 'Запись для удаления не найдена';
  E_Init_Default_SQL_Failed = 'Невозможно инициализировать значение по умолчанию для "%s"';
  E_Stringlist_Not_Sorted = 'Stringlist должен быть отсортирован для этой операции';
  E_Cannot_Change_Events = 'Невозможно изменить события пока идет обработка';
  E_Cannot_Unregister_Events = 'Невозможно отменить регистрацию, пока идет обработка';
  E_Invalid_Internal_Transaction = 'Неправильная внутренняя транзакция IB_Transaction';
  E_InvalidStatementType = 'Неправильный тип оператора';
  E_Multiple_Records_Updated = 'Изменение множественных записей';
  E_Multiple_Records_Deleted = 'Удаление множественных записей';
  E_Multiple_Records_Inserted = 'Добавление множественных записей';
  E_DUP_DB_NAME = 'Дублирование DatabaseName не допускается';
  E_INVALID_DB_NAME = 'Неправильный DatabaseName';
  E_UnableToSearch_NoOrdering = 'Невозможно выполнить поиск, не определен порядок сортировки';
  E_UnableToSearch_DatasetBusy = 'Невозможно выполнить поиск, набор данных занят считыванием записей (fetching)';
  E_NoRecordsFound = 'Не обнаружено никаких записей';
  E_Session_Undefined = 'Session не определена';
  E_NoCircularRef = 'Циклическая ссылка не допускается';
  E_InvalidClassType = 'Неправильный тип класса';
  E_Invalid_RowNum = 'Неправильный RowNum';
  E_Invalid_Syntax = 'Неправильный синтаксис: дополнительные или отсутствующие скобки';
  E_Array_Is_Null = 'Массив - Null';

  E_Cannot_add_blank_account = 'Невозможно добавить пустую учетную запись';
  E_Cannot_add_SYSDBA_account = 'Невозможно добавить учетную запись SYSDBA';
  E_Cannot_delete_blank_account = 'Невозможно удалить пустую учетную запись';
  E_Cannot_delete_SYSDBA_account = 'Невозможно удалить учетную запись SYSDBA';
  E_Cannot_modify_blank_account = 'Невозможно изменить пустую учетную запись';

  E_PLAN_ERROR = 'ОШИБКА PLAN!';
  E_PLAN_EXCEPTION = 'ИСКЛЮЧИТЕЛЬНАЯ СИТУАЦИЯ PLAN!';

  E_INV_CREATE_CONNECT_DROP = 'Неверный синтаксис CREATE, CONNECT или DROP DATABASE';
  E_Unsupported = 'Не поддерживается';
  E_NotImplemented = 'Не осуществляется на этом уровне';
  E_Invalid_ColData = 'Неверный ColData';

  E_Cant_Unprepare_executing_process = 'Невозможно выполнить Unprepare при выполнении процесса';
  E_FileName_Required = 'Требуется имя файла';

{ Labels for various default dialogs used in IBO }

//IBF_Users
  L_USERS_FRM = 'Управление учетными записями пользователей';
  L_USERS_ADD = 'Добавить';
  L_USERS_DELETE = 'Удалить';
  L_USERS_MODIFIY = 'Изменить';
  L_USERS_ACCOUNT = 'Учетная запись';
  L_USERS_PASSWORD = 'Пароль';
  L_USERS_GROUP = 'Группа';
  L_USERS_FIRSTNAME = 'Имя';
  L_USERS_MIDDLENAME = 'Фамилия';
  L_USERS_LASTNAME = 'Отчество';

//IBF_Export
  L_EXPORT_FRM = 'Экспорт';
  L_EXPORT_ASCII = ' Формат файла ';
  L_EXPORT_FIXED = 'С фиксированной длиной';
  L_EXPORT_DELIMITED = 'С разграничителями';
  L_EXPORT_DBF  = 'DBF';
  L_EXPORT_ASCIIOPT  = ' ASCII - параметры ';
  L_EXPORT_DELIMITER  = 'Разграничитель';
  L_EXPORT_SEPARATOR  = 'Разделитель';
  L_EXPORT_DATEFORMAT  = 'Формат даты';
  L_EXPORT_INCLUDEHEADERS  = 'Включая заголовки';
  L_EXPORT_INCLUDECRLF  = 'Включать <CR><LF>';
  L_EXPORT_SDEXPORTTITLE = 'Экспорт';
  L_EXPORT_SDEXPORTFILTERCSV = 'Текстовые файлы с разделителями ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Текстовые файлы ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF файлы ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Вы действительно хотите прервать?';
  M_Fetching_Query_Results = 'Выборка результатов'; // запроса
  M_Row_Num = 'Запись № %d';
  M_Abort_Fetching_Btn = 'Прервать';

  M_Login_Database = 'База';
  M_Login_User = 'Имя';
  M_Login_Password = 'Пароль';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Отмена';
  M_Login_Help_Btn = '&Помощь';
  M_Login_Dialog_Caption = 'Диалог подключения к базе данных';

  M_Loading_Caption = 'Загрузка...';

  M_SB_REC_CNT = 'Количество записей: %d';
  M_Save_Changes = 'Сохранить изменения?';
  M_Abort_Changes = 'Изменения будут потеряны. Продолжить?';  

  M_CancelTransactionPrompt = 'Вы действительно хотите отменить все изменения?';

  M_SCRIPT_ABORT_EXECUTE = 'Отказаться от выполнения этого скрипта?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Продолжить выполнение этого скрипта?';
  M_SCRIPT_IS_EXECUTING = 'Скрипт в данное время выполняется';
  M_SCRIPT_FAILED = 'Скрипт не может завершиться';
  M_SCRIPT_WAS_ABORTED = 'Выполнение скрипта было прервано';
  M_SCRIPT_COMPLETED = 'Скрипт завершен без ошибок';
  M_SCRIPT_CMPL_EXCEPT = 'Скрипт завершен с ошибками';
  M_SCRIPT_MODIFIED = 'Изменён';
  M_SCRIPT_SAVE_CHANGES = 'Сохранить изменения?';

{ Button captions }

  C_BTN_TODAY = 'Сегодня';
  C_BTN_CLEAR = 'Очистить';
  C_BTN_FIND = 'Найти';
  C_BTN_FINDNEXT = 'Найти далее';
  C_BTN_REPLACE = 'Заменить';
  C_BTN_UNDO = 'Отменить';
  C_BTN_CUT = 'Вырезать';
  C_BTN_COPY = 'Копировать';
  C_BTN_PASTE = 'Вставить';
  C_BTN_DELETE = 'Удалить';
  C_BTN_SELECTALL = 'Выделить все';

  C_SG_Parameter = 'Параметр';
  C_SG_Field = 'Поле';
  C_SG_Name = 'Имя';
  C_SG_Type = 'Тип';
  C_SG_Info = 'Комментарий';
  C_SG_Value = 'Значение';
  
  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Отмена';
  C_BF_CANCEL_ACCEL = '&Отмена';
  C_BF_APPLY = 'Применить';
  C_BF_HELP = 'Помощь';
  C_BF_EXECUTE = 'Выполнить';
  C_BF_CLOSE = 'Закрыть';
  C_BF_CLOSE_ACCEL = '&Закрыть';
  C_BF_FINISH = 'Завершить';
  C_BF_FINISH_ACCEL = '&Завершить';

  C_FRM_Ordering = 'Сортировка';
  C_FRM_RESTRUCTURE = 'Определить отображаемые поля';

  C_CB_WordWrap = 'Перенос слов';

// IBF_SQL
  M_SQL_RowsAffected = 'Затронутых строк :';
  M_SQL_RowsCounted = 'Подсчитано строк: ';
  M_SQL_SessionBusy = 'Сессия в данный момент занята';
  M_SQL_CompleteTransaction = 'Завершите пожалуйста транзакцию';
  M_SQL_CannotDeleteDefaultGroup = 'Группа по умолчанию не может быть удалена';
  M_SQL_ReservedName = 'Это имя зарезервировано: ';
  M_SQL_BackSlashNotAllowed = 'Обратный слэш недопустим ';
  M_SQL_BlankNameNotAllowed = 'Пустое имя недопустимо!';
  M_SQL_RowsFetched = 'Принято записей: ';
  M_SQL_ConfirmDBCreation = 'Вы действительно хотите создать базу данных?';
  M_SQL_ConfirmNoOtherDBSameName = 'Удостоверьтесь, что базы данных с таким именем не существует.';
  M_SQL_ConfirmDBDrop = 'База данных будет незамедлительно уничтожена.'+#13#10+#13#10'Продолжить?';
  M_SQL_ReConfirmDBDrop = 'Вы действительно хотите удалить базу данных?';
  M_SQL_AskFormName = 'Введите имя формы запроса: ';
  M_SQL_AskGroupName = 'Введите имя группы: ';
  M_SQL_AskLayoutName = 'Введите имя схемы(layout): ';
  M_SQL_ConfirmGroupDeletion = 'Вы действительно хотите удалить группу "%s" со всеми вложенными элементами?';
  M_SQL_ConfirmLayoutDeletion = 'Вы действительно хотите удалить схему(layout) :  %s?';
  M_SQL_RecursiveCopyNotAllowed = 'Рекурсивное копирование недопустимо!';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Дважды щелкните по элементу или нажмите Enter на выделенном элементе'; // 'Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'Значение параметра'; // 'Parameter value';
  M_GCSQL_TypeAValueFor = 'Введите значение для %s '; // 'Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = 'Эта процедура не имеет параметров ввода'; // 'This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Процесс переноса данных (Data Pump) активен'; // 'Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'Вы уверены?'; // 'Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Укажите базу-источник данных'; // 'Select Source Database';
  M_DP_SELECT_DEST_DB = 'Укажите базу-приемник данных'; // 'Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Очистить';
  M_USERS_COMPLETED_OK = 'Операция завершена успешно';
  M_USERS_NO_CONNECTION = 'Не определено соединение IB_Connection';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Назначить поля сортировки?'; // 'Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Начать экспорт';
  M_EXPORT_STILL_ACTIVE = 'Процесс экспорта активен.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Просмотр базы данных';
  C_wbBrowseBtnCaption  = 'Просмотр';
  C_wbDSQLBtnHint       = 'Выполнить запрос к базе данных';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Монитор событий базы данных';
  C_wbEventsBtnCaption  = 'События';
  C_wbExportBtnHint     = 'Экспорт данных из базы';
  C_wbExportBtnCaption  = 'Экспорт';
  C_wbDumpBtnHint       = 'Дамп базы данных';
  C_wbDumpBtnCaption    = 'Дамп';
  C_wbPumpBtnHint       = 'Закачка данных из другой базы данных';
  C_wbPumpBtnCaption    = 'Закачка';
  C_wbWhoBtnHint        = 'Посмотреть, кто подсоединен к базе данных';
  C_wbWhoBtnCaption     = 'Кто';
  C_wbScriptBtnHint     = 'Выполнить скрипт';
  C_wbScriptBtnCaption  = 'Скрипт';
  C_wbExtractBtnHint    = 'Извлечь DLL'; //'Extract DDL';
  C_wbExtractBtnCaption = 'Извлечь'; //'Extract';
  C_wbMonitorBtnHint    = 'Трассировать SQL и API вызовы';
  C_wbMonitorBtnCaption = 'Монитор';
  C_wbProfilerBtnHint   = 'Профиль активности базы данных';
  C_wbProfilerBtnCaption= 'Профиль';
  C_wbStatusBtnHint     = 'Просмотр статуса IBO Компонентов'; //'View Status of IBO Components';
  C_wbStatusBtnCaption  = 'Статус'; // 'Status';
  C_wbUsersBtnHint      = 'Администрирование пользователей для сервера базы данных';
  C_wbUsersBtnCaption   = 'Пользователи';

  // Array grid
  C_AG_Row             = 'Строка';
  C_AG_Column          = 'Столбец';

  //IBF_Who
  C_WHO_FRM            = 'Кто подсоединен';
  C_WHO_BTNAPPLY       = 'Обновить';

  C_NB_FIRST = 'Первая';
  C_NB_PRIOR = 'Предыдущая';
  C_NB_NEXT = 'Следующая';
  C_NB_LAST = 'Последняя';

  C_ST_Open = 'Открыть';
  C_ST_Close = 'Закрыть';
  C_ST_Prepare = 'Подготовить';
  C_ST_Unprepare = 'Отм. подготовку';
  C_ST_ReadOnly = 'Только чтение';
  C_ST_New = 'Новая';
  C_ST_Post = 'Подтвердить';
  C_ST_Cancel = 'Отменить';
  C_ST_Delete = 'Удалить';
  C_ST_Edit = 'Изменить';
  C_ST_RefreshKeys = 'Обновить ключи';
  C_ST_RefreshRows = 'Обновить записи';
  C_ST_Refresh = 'Обновить';

{ Hints }

  H_UB_EDIT = 'Редактировать запись';
  H_UB_INSERT = 'Добавить запись';
  H_UB_DELETE = 'Удалить запись';
  H_UB_REFRESH = 'Обновить все записи';
  H_UB_REFRESHKEYS = 'Обновить ключи записей';
  H_UB_REFRESHROWS = 'Обновить столбцы записей';
  H_UB_REFRESHFILTROWS = 'Обновить отфильтрованные столбцы';
  H_UB_POSTSEARCH = 'Подтвердить критерий выборки';
  H_UB_CANCELSEARCH = 'Отменить критерий выборки';
  H_UB_POSTEDIT = 'Подтвердить изменения';
  H_UB_CANCELEDIT = 'Отменить изменения';
  H_UB_POSTINSERT = 'Подтвердить добавление';
  H_UB_CANCELINSERT = 'Отменить добавление';
  H_UB_POSTDELETE = 'Подтвердить удаление';
  H_UB_CANCELDELETE = 'Отменить удаление';
  H_UB_POST = 'Подтвердить изменения';
  H_UB_CANCEL = 'Отменить изменения';

  H_NB_FIRST = 'Первая запись';
  H_NB_PRIOR = 'Предыдущая запись';
  H_NB_NEXT = 'Следующая запись';
  H_NB_LAST = 'Последняя запись';
  H_NB_JUMPBCK = 'Назад';
  H_NB_JUMPFWD = 'Вперед';

  H_SB_ORDER = 'Порядок записей в выборке';
  H_SB_LAST_CRITERIA = 'Вызвать последний критерий';
  H_SB_SEARCH = 'Выборка данных';
  H_SB_SAVE_CRITERIA = 'Запомнить критерий';
  H_SB_CLEAR_CRITERIA = 'Очистить критерий';
  H_SB_RECALL_CRITERIA = 'Вызвать критерий';
  H_SB_SEARCHCOUNT = 'Количество записей в выборке по критерию';
  H_SB_COUNT = 'Количество записей в выборке';
  H_SB_RESTRUCTURE = 'Определить отображаемые поля';

  H_TB_StartTransaction = 'Стартовать транзакцию';
  H_TB_PostDatasets = 'Сохранить изменения в наборах данных';
  H_TB_CancelDatasets = 'Отменить изменения в наборах данных';
  H_TB_SavePoint = 'Завершить и продолжать текущую транзакцию';
  H_TB_CommitRetain = 'Сохранить, завершить и продолжать текущую транзакцию';
  H_TB_Commit = 'Завершить и закончить текущую транзакцию';
  H_TB_Rollback = 'Откатить и закончить текущую транзакцию';
  H_TB_RollbackRetain = 'Откатить и держать текущую транзакцию';
  H_TB_Close = 'Закрыть текущую транзакцию';

  H_ST_Prepare_Statement = 'Подготовить запрос';
  H_ST_Unprepare_Statement = 'Отменить подготовку запроса';
  H_ST_Execute_Statement = 'Выполнить запрос';

  H_DS_Open_Dataset = 'Открыть набор данных';
  H_DS_Close_Dataset = 'Закрыть набор данных';
  H_DS_Prepare_Dataset = 'Подготовить набор данных';
  H_DS_Unprepare_Dataset = 'Отменить подготовку набора данных';
  H_DS_ReadOnly_Dataset = 'Набор данных только для чтения';

  H_CB_Create_Database = 'Создать базу данных';
  H_CB_Connect_Database = 'Подключиться к базе данных';
  H_CB_Disconnect_Database = 'Завершить соединение';
  H_CB_Drop_Database = 'Удалить базу данных';
  
  H_RD_actHide = 'Скрыть выделенные поля';
  H_RD_actHideAll = 'Скрыть все поля';
  H_RD_actVisible = 'Сделать выделенные поля видимыми';
  H_RD_actVisibleAll = 'Сделать все поля видимыми';
  H_RD_actUp = 'Переместить выделенные поля выше';
  H_RD_actTop = 'Переместить выделенные поля наверх';
  H_RD_actDown = 'Переместить выделенные поля ниже';
  H_RD_actBottom = 'Переместить выделенные поля вниз';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Экспорт из SQL-запроса';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Отсутствует вхождение для ascii-файла';
  eNoDestTableEntry          = 'Отсутствует вхождение для таблицы-приемника';
  eAsciiFileNotFound         = 'Ascii-файл "%s" не найден';
  eIniFileNotFound           = 'Ini-файл "%s" не найден';
  eNoAsciiFileAccess         = 'Невозможно открыть ascii-файл "%s"';
  eInvalidCharFound          = 'Неправильный символ / ошибка формата ascii-файла';
  eOutOfMemory               = 'Не хватает памяти';
  eFieldDescriptionError     = 'Ошибка в описании поля';
  eWrongAsciiFieldCount      = 'Неправильное количество полей в ascii-файле, строка (%s)';
  eWrongDecimalCount         = 'Неправильное число десятичных знаков в списке полей (%s)';
  eWrongFieldWidth           = 'Неправильная ширина поля в ascii-файле';

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
  STR_DDL_coCreateDatabase = 'Create Database';
  STR_DDL_coSecondaryFiles = 'Define Secondary Files';
  STR_DDL_coDefineShadows = 'Define Shadows';
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
  STD_DDL_plNone       = 'None';
  STD_DDL_plMinor      = 'Minor';
  STD_DDL_plSuspicious = 'Suspicious';
  STD_DDL_plWarning    = 'Warning';
  STD_DDL_plError      = 'Error';
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
  E_DDL_CURSOR_NOT_CREATED = 'Cursor Not Created';
  E_DDL_BLANK_NAME         = 'Blank Name';
  E_DDL_ENTITY_NOT_FOUND   = 'Entity Not Found';
  E_DDL_RESERVED_NAME      = 'Reserved name used for non-system entity.';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Database Character set %s was not found to get its canonic name';
  E_DDL_MODULE_NAME_EMPTY  = 'Module name is empty';
  E_DDL_ENTRY_POINT_EMPTY  = 'Entry point is empty';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'External domain only can be implicit';
  E_DDL_DOMAIN_TYPE_16     = 'Type 16 can be only NUMERIC or DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'Charset Id was NULL, assuming NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Missing name for charset ID %s Assuming NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'BytesPerCharacter was zero in charset %s';
  E_DDL_FIELDLEN_MISMATCH  = 'FieldLength %s should be multiple of %s bytes per character in charset name %s';
  E_DDL_INVALID_COLLATIONID = 'Collation Id cannot be < 0 but is %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Collation Id was NULL, assuming %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Unknown FieldType %s';
  E_DDL_CSTRING_IN_DSQL = 'FieldType CSTRING is not accepted by DSQL';
  E_DDL_QUAD_IN_DSQL = 'FieldType QUAD is not accepted by DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Suspicious check: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Declared but void check constraint';
  E_DDL_EXPLICIT_COMPUTED = 'Explicit domain cannot be COMPUTED';
  E_DDL_VOID_COMPUTED = 'Declared but void COMPUTED BY clause';
  E_DDL_SUSPICIOUS_DEFAULT = 'Suspicious default: %s';
  E_DDL_VOID_DEFAULT = 'Declared but void default';
  E_DDL_DIMENSIONS_MISMATCH = 'Declared with %s dimensions but details for %s dimensions where found.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Implicit Domain has no relation.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Implicit Domain has missing relation or field name.';
  E_DDL_NO_OUTPUT_PARAMETER = 'No Output Parameter';
  E_DDL_NO_GRANTOR = 'Grantor not specified';
  E_DDL_VIEW_NO_BLR = 'Has not view_blr but it appears in rdb$view_relations as a VIEW';
  E_DDL_VIEW_NO_VIEW_RELATION = 'Has view_blr but it doesn''t appear in rdb$view_relations as a VIEW';
  E_DDL_NO_OWNER = 'Owner name is not specified';
  E_DDL_FORMAT_VERSION = 'Format version at %s';
  E_DDL_DBKEY_LEN = 'DbKey_Length should be 8 but is %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'Domain/Field Definition for field %s not found';
  E_DDL_NO_SOURCE_CODE = 'Has no source code available';
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
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Unknown trigger type %s';
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
  E_DDL_MANDATORY_IN_VIEW = 'Cannot be mandatory in a view';
  E_DDL_BASEFIELD_EMPTY = 'BaseField should not be empty for views if ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext cannot be empty for views';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext should be >= 0 for views';
  E_DDL_BAD_PARAM_TYPE = 'Parameter type %s is out of range';
  E_DDL_BAD_PARAM_NUM = 'Parameter number must be >=0 but is %s';

  // Comments output with DDL statements
  C_DDL_CONNECT_USERNAME   = 'Connect using username: %s';
  C_DDL_CONNECT_SERVER_VER = 'and server: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'No Secondary Files';
  C_DDL_SEC_FILES = 'Secondary Files';
  C_DDL_SEC_FILE_DESC = '%s, Start: %s, Length: %s';
  C_DDL_NO_SHADOW_FILES = 'No Shadow Files';
  C_DDL_SHADOW_FILES = 'Shadow Files';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, Start: %s, Length: %s';
  C_DDL_EXCEPTION_DESC = 'Exception: %s, Original Number: %s';
  C_DDL_FIELD_NOT_FOUND = 'Field Not Found: %s';
  C_DDL_INDEX_NOT_FOUND = 'Index Not Found';
  C_DDL_NO_FOREIGN_RELATION = 'No Foreign Relation or Index Defined To Constraint';
  C_DDL_FOREIGN_NOT_FOUND = 'Foreign Relation Not Found: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Foreign Index Not Found: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Trigger Not Found: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Invalid Constraint Type Name: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'No Source For Trigger: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'TriggerType Unknown: %s';
  C_DDL_BAD_PRIVILEGE = 'Unknown Privilege: %s';


implementation

end.
