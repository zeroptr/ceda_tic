
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
{ Portuguese version translated by Carlos Macao                                }
{ e-mail address:       carlos.macao@netcabo.pt                                }
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

  IB_REG_MESSAGE = 'Obrigado por avaliar IB Objects.'#10#13#10#13 +
                   'Por favor aceda a http://www.ibobjects.com e registe-se.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'A liga��o j� foi estabelecida';
  E_NOT_CONNECTED     = 'A liga��o ainda n�o foi estabelecida';
  E_Invalid_conn_path = 'Caminho para liga��o inv�lido';
  E_Cant_Repl_Int_Tr  = 'N�o se pode substituir a transac��o interna por defeito';
  E_NO_TRANS_STARTED  = 'A transa��o n�o foi iniciada';
  E_TRANS_STARTED     = 'A transa��o j� foi iniciada';
  E_NO_CONNECTIONS    = 'A transa��o n�o tem liga��es';
  E_NOT_ENOUGH_CONN   = 'A transa��o n�o encontra uma ou mais liga��es';
  E_CONN_LOADING      = 'Aten��o: a liga��o ainda est� sendo activada';
  E_TRANS_CONN_SESS   = 'As conex�es devem estar todas na mesma IB_Session';
  E_TransactionPaused = 'Transa��o em pausa';
  E_ALLOCATED         = 'A declara��o j� foi assignada';
  E_NOT_ALLOCATED     = 'A declara��o n�o foi assignada';
  E_PREPARED          = 'A declara��o j� foi preparada';
  E_NOT_PREPARED      = 'A Declara��o n�o foi preparada';
  E_FAILED_TO_PREPARE = 'Falha na prepara��o da declara��o';
  E_OPENED            = 'A declara��o j� foi aberta';
  E_NOT_OPENED        = 'A declara��o n�o foi aberta';
  E_CANT_DELETE       = 'O registo actual do cursor n�o pode ser apagado';
  E_NO_CONNECTION     = 'A declara��o deve ter uma IB_Connection assignada';
  E_CONNECT_FAILED    = 'N�o se pode abrir IB_Connection';
  E_NO_TRANSACTION    = 'A declara��o deve ter uma IB_Transaction assignada';
  E_NO_ACTIVE_TRANS   = 'Nenhuma transa��o activa para executar com';
  E_START_FAILED      = 'N�o se pode iniciar a transa��o';
  E_SVRAUTOCMT_NOEXP  = 'N�o s�o permitidas transa��es expl�citas com ServerAutoCommit';
  E_Cannot_Activate   = 'Estado de transa��o inv�lido. N�o se pode ativar';
  E_Transaction_Is_Active = 'A Transa��o tem altera��es pendentes';
  E_Failed_To_Post_Datasets = 'Erro ao escrever em todos os Dataset';
  E_Failed_To_Cancel_Datasets = 'Erro ao cancelar todos os Datasets';
  E_UpdateWrongTrn    = 'Imposs�vel actualizar, %s n�o � possu�do por %s';
  E_NO_BLANK_SQL      = 'N�o � permitido texto SQL vazio';
  E_AT_END_OF_FILE    = 'No final do arquivo';
  E_AT_END_OF_CURSOR  = 'No final do cursor';
  E_AT_END_OF_BUFFER  = 'No final do buffer';
  E_AT_END_OF_DATASET = 'No final do dataset';
  E_BAD_SQL_INF_LEN   = 'Comprimento n�o anticipado em isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Dados inv�lidos retornados por isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'N�o se pode mudar o nome do cursor enquanto est� ativo';
  E_REQUEST_LIVE_ACTIVE = 'N�o se pode mudar RequestLive quando est� ativo';
  E_REQUEST_LIVE_READONLY = 'N�o se pode realizar RequestLive a um dataset somente de leitura';
  E_CURSOR_UNI                  = 'O IB_CURSOR � unidireccional';
  E_UNSUPPORTED_COLUMN_TYPE     = 'Tipo de coluna: %d n�o suportado';
  E_FIELDNO_NOT_FOUND           = 'Campo N�: %d n�o encontrado';
  E_FIELDNAME_NOT_FOUND         = 'Nome de campo: %s n�o encontrado';
  E_INVALID_FOCUS_RELATION_NO   = 'Rela��o N�: %d n�o v�lida';
  E_INVALID_FOCUS_RELATION_NAME = 'Nome de rela��o: %s n�o v�lido';
  E_INVALID_QBE_IN              = 'Erro de sintaxe: IN( valor [ , valor ... ] )';
  E_INVALID_QBE_BETWEEN         = 'Erro de sintaxe: BETWEEN valor AND valor';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'N�o � poss�vel localizar DLL de importa��o %s';
  E_INVALID_SQL_KEY_FIELDS      = 'Propriedade SQLKeyFields n�o v�lida';
  E_GET_CURSOR_ERROR            = 'N�o se pode abrir o cursor sem dados da chave';
  E_SCROLL_ERROR = 'Chave de Registo '#10#13' perdeu-se. Falhou a abertura do cursor';
  E_INVALID_BUFFER_ROW_NUM = 'BufferRowNum inv�lido, antes do inicio';
  E_BLANK_STATEMENT = 'N�o se pode preparar uma declara��o em branco';
  E_UNKNOWN_STATEMENT = 'Tentativa de execu��o de uma declara��o desconhecida';
  E_CIRCULAR_REFERENCE = 'Refer�ncia circular n�o permitida';
  E_CANT_CHG_WITH_CONN  = 'N�o se pode mudar enquanto est� ligado';
  E_LOGIN_FAILED        = 'Problemas com o Login';
  E_CANT_GET_CONN_CHR = 'N�o � poss�vel obter caracter�sticas da liga��o';
  E_MAX_EVENTS_BLOCK  = 'Demasiados eventos para um s� Bloco';
  E_PROCESSING_EVENTS = 'Processando eventos'#13#10'N�o � poss�vel Desregistar';
  E_CANT_STORE_BLOB  = 'Blob j� foi ou n�o pode ser gravado';
  E_CANT_LOAD_BLOB   = 'Blob j� foi ou n�o pode ser lido';
  E_CANNOT_CANCEL_ROW = 'N�o � poss�vel cancelar a linha corrente';
  E_CANNOT_POST_ROW  = 'N�o � poss�vel gravar a linha corrente';
  E_DatasetClosed     = 'Dataset est� inactivo';
  E_DatasetOpen        = 'Dataset encontra-se aberto';
  E_DatasetCannotScroll = 'Dataset n�o pode ser navegado';
  E_DatasetReadOnly     = 'Dataset � apenas de leitura';
  E_DatasetIsFetching    = 'Dataset encontra-se a obter dados';
  E_Invalid_KeyRelation   = 'Valor de ChaveRela��o inv�lido';
  E_RowNum_Not_Implemented = 'Numero de Linha ainda n�o est� implementado';
  E_RowDeleted            = 'A Linha est� sendo apagada';
  E_END_OF_DATASET        = 'Fim do Dataset';
  E_BEGINNING_OF_DATASET   = 'Princ�pio do Dataset';
  E_Cannot_Pessimistic_Lock = 'N�o � poss�vel usar bloqueio pessimista com LockWait';
  E_Cannot_Edit_Row      = 'N�o � poss�vel editar a linha corrente';
  E_Cannot_Insert_Row  = 'N�o � poss�vel inserir uma nova Linha';
  E_Cannot_Delete_Row = 'N�o � poss�vel apagar a linha corrente';
  E_Cannot_Search    = 'N�o � permitida a Procura';
  E_Cannot_Navigate = 'N�o � poss�vel Navegar';
  E_Record_Locked    = 'O Registo encontra-se bloqueado por outro utilizador';
  E_Record_OutOfSynch = 'O Registo foi alterado por outro utilizador';
  E_FLD_READONLY       = '%s n�o � modific�vel';
  E_Required_Field       = '%s � um campo obrigat�rio';
  E_NO_POSTRTN_CACHED_UPDT = 'N�o � poss�vel usar PostRetaining com Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Multiplas linhas numa leitura Singular';

  E_InvalidRowsAffectedBuf = 'Buffer RowsAffected Inv�lido';
  E_Invalid_RowNum_Past_Eof = 'RowNum antes de Eof Inv�lido';
  E_Invalid_RowNum_Before_Bof = 'RowNum antes de Bof Inv�lido';
  E_Invalid_Bookmark = 'Texto de Marca Inv�lido';

  E_Assign_Column  = 'N�o � poss�vel assignar de %s';
  E_AssignTo_Column = 'N�o � poss�vel assignar a %s';
  E_Value_Out_Of_Range = 'Valor fora dos limites';
  E_SmallintOverflow = 'Overflow de Smallint';
  E_IntegerOverflow = 'Overflow de Inteiro';
  E_Int64Overflow = 'Overflow de Int64';

  E_Unsupported_Column = 'Tipo de Coluna n�o suportado: %d';
  E_UndefinedMacro = 'Macro indefinida';
  E_GeneratorFailed = 'N�o � poss�vel obter o valor do Gerador';

  E_MustBe_Buffered_Dataset = 'Deve ser descendente de TIB_BDataset (IB_Query)';

  E_NO_CHANGE_READONLY = 'N�o � poss�vel alterar ReadOnly ao iniciar';
  E_NO_CHANGE_ISOLATION = 'N�o � poss�vel alterar Isolation ao iniciar';
  E_NO_CHANGE_RECVERSION = 'N�o � poss�vel alterar RecVersion ao iniciar';
  E_NO_CHANGE_LOCKWAIT = 'N�o � poss�vel alterar LockWait ao iniciar';

  E_Invalid_Reference_To_Delete = 'Refer�ncia inv�lida para suprimir';
  E_Invalid_Typecast = 'Convers�o Inv�lida';
  E_Invalid_DataPump_Statement = 'Tipo de Instru��o inv�lida para DataPump';
  E_FIELD_NOT_NULLABLE = 'Campo NOT NULL alterado para valor nulo';
  E_DATABASE_BLANK = 'Nome de Base de Dados n�o pode ser vazio';
  E_Unsupp_Col_Conversion = 'Convers�o de coluna inv�lida';
  E_Unable_To_Locate_Record = 'N�o � poss�vel Localizar o Registo';
  E_Record_Not_Inserted = 'O Registo n�o foi inserido';
  E_Invalid_KeyLinks = 'Entrada de KeyLinks inv�lida: %s';
  E_Unable_to_perform_search = 'N�o � poss�vel executar a procura';
  E_Unassigned_Blob_Node = 'BlobNode n�o Assignado';
  E_Unassigned_Transaction = 'Transac��o n�o assignada';
  E_Invalid_RowsAffected_Buffer = 'Buffer de RowsAffected Inv�lido';
  E_Unable_Save_Graphic = 'N�o � poss�vel guardar a Imagem';
  E_Cannot_Activate_Transaction = 'N�o � poss�vel activar a transa��o';
  E_IB_Client_Not_Installed = 'Biblioteca InterBase Cliente GDS32.DLL n�o instalada';
  E_Could_Not_Load_Memo = 'N�o � poss�vel ler memo';
  E_Invalid_DPB_Over_255 = 'DPB Inv�lido: Conte�do excede 255 caracteres';
  E_Inv_Custom_DML = 'DML inv�lido refer�ncia coluna: %s';
  E_Record_Not_Located_For_Update = 'Registo n�o encontrado para alterar';
  E_Record_Not_Located_For_Delete = 'Registo n�o encontrado para suprimir';
  E_Init_Default_SQL_Failed = 'N�o � poss�vel inicializar por defeito %s';
  E_Stringlist_Not_Sorted = 'A Lista deve ser ordenada para esta opera��o';
  E_Cannot_Change_Events = 'N�o � poss�vel alterar eventos em execu��o';
  E_Cannot_Unregister_Events = 'N�o � poss�vel Desregistar eventos em execu��o';
  E_Invalid_Internal_Transaction = 'Transac��o Interna Inv�lida';
  E_InvalidStatementType = 'Tipo de instru��o Inv�lido';
  E_Multiple_Records_Updated = 'M�ltiplos registos alterados';
  E_Multiple_Records_Deleted = 'M�ltiplos registos suprimidos';
  E_Multiple_Records_Inserted = 'Multiple records inserted';
  E_DUP_DB_NAME = 'N�o � poss�vel duplicar Nome de Base de Dados';
  E_INVALID_DB_NAME = 'Base de Dados Inv�lida';
  E_UnableToSearch_NoOrdering = 'Procura inv�lida, n�o foi definida a ordena��o';
  E_UnableToSearch_DatasetBusy = 'Procura inv�lida, o dataset encontra-se ocupado, recebendo dados';
  E_NoRecordsFound = 'Nenhum registo encontrado';
  E_Session_Undefined = 'Sess�o n�o Definida';
  E_NoCircularRef = 'Refer�ncia Circular n�o permitida';
  E_InvalidClassType = 'Tipo de Classe Inv�lido';
  E_Invalid_RowNum = 'Numero de Linha Inv�lido';
  E_Invalid_Syntax = 'Sintaxe Inv�lida: parentesis extra ou em falta';
  E_Array_Is_Null = 'O Array � Nulo';

  E_Cannot_add_blank_account = 'N�o � poss�vel adicionar utilizador vazio';
  E_Cannot_add_SYSDBA_account = 'N�o � poss�vel adicionar utilizador SYSDBA';
  E_Cannot_delete_blank_account = 'N�o � poss�vel suprimir utilizador vazio';
  E_Cannot_delete_SYSDBA_account = 'N�o � poss�vel suprimir utilizador SYSDBA';
  E_Cannot_modify_blank_account = 'N�o � poss�vel modificar utilizador vazio';

  E_PLAN_ERROR = 'ERRO DE PLANO!';
  E_PLAN_EXCEPTION = 'EXCEP��O DE PLANO!';

  E_INV_CREATE_CONNECT_DROP = 'Sintaxe de CREATE, CONNECT ou DROP DATABASE Inv�lida';
  E_Unsupported = 'N�o suportado';
  E_NotImplemented = 'N�o implementado neste n�vel';
  E_Invalid_ColData = 'ColData Inv�lido';

  E_Cant_Unprepare_executing_process = 'N�o � poss�vel DesPreparar um processo em execu��o';
  E_FileName_Required = 'Nome de Ficheiro requerido';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Gest�o de Conta de Utilizador';
  L_USERS_ADD = 'Adiciona';
  L_USERS_DELETE = 'Suprime';
  L_USERS_MODIFIY = 'Modifica';
  L_USERS_ACCOUNT = 'CONTA';
  L_USERS_PASSWORD = 'Senha';
  L_USERS_GROUP = 'Grupo';
  L_USERS_FIRSTNAME = 'Primeiro Nome';
  L_USERS_MIDDLENAME = 'Nome do Meio';
  L_USERS_LASTNAME = '�ltimo Nome';

  //IBF_Export
  L_EXPORT_FRM = 'Exporta';
  L_EXPORT_ASCII = ' Formato de Ficheiro ';
  L_EXPORT_FIXED = 'TXT-Largura de Registo Fixa';
  L_EXPORT_DELIMITED = 'Delimitado por CSV';
  L_EXPORT_DBF  = 'DBF  (Ainda precisa de ser Testado)';
  L_EXPORT_ASCIIOPT  = ' Op��es ASCII ';
  L_EXPORT_DELIMITER  = 'Delimitador';
  L_EXPORT_SEPARATOR  = 'Separador';
  L_EXPORT_DATEFORMAT  = 'Formato de Data';
  L_EXPORT_INCLUDEHEADERS  = 'Inclui Cabe�alhos';
  L_EXPORT_INCLUDECRLF  = 'Inclui CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Exporta';
  L_EXPORT_SDEXPORTFILTERCSV = 'Ficheiros com Texto entre Virgulas ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Ficheiros Texto ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'Ficheiros DBF ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Pretende mesmo abortar?';
  M_Fetching_Query_Results = 'Lendo Resultado de Procura';
  M_Row_Num = 'Linha# %d';
  M_Abort_Fetching_Btn = 'Aborta';

  M_Login_Database = 'Base de Dados';
  M_Login_User = 'Utilizador';
  M_Login_Password = 'Senha';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancela';
  M_Login_Help_Btn = '&Ajuda';
  M_Login_Dialog_Caption = 'Di�logo Entrada';

  M_Loading_Caption = 'Lendo...';

  M_SB_REC_CNT = 'Numero Registos: %d';
  M_Save_Changes = 'Guarda Altera��es?';
  M_Abort_Changes = 'As altera��es ser�o perdidas. Pretende continuar?';

  M_CancelTransactionPrompt =
    'Tem a certeza que pretende cancelar as altera��es?';

  M_SCRIPT_ABORT_EXECUTE = 'Pretende abortar a execu��o do Script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Pretende continuar a execu��o do Script?';
  M_SCRIPT_IS_EXECUTING = 'O Script encontra-se em execu��o';
  M_SCRIPT_FAILED = 'Problemas com a execu��o do Script';
  M_SCRIPT_WAS_ABORTED = 'A Execu��o do Script foi abortada';
  M_SCRIPT_COMPLETED = 'O Script foi executado com Sucesso';
  M_SCRIPT_CMPL_EXCEPT = 'O Script foi executado com excep��es';
  M_SCRIPT_MODIFIED = 'Modificado';
  M_SCRIPT_SAVE_CHANGES = 'Guarda altera��es?';

{ Button captions }

  C_BTN_TODAY = 'Hoje';
  C_BTN_CLEAR = 'Limpar';
  C_BTN_FIND = 'Procura';
  C_BTN_FINDNEXT = 'Procura Seguinte';
  C_BTN_REPLACE = 'Substitui';
  C_BTN_UNDO = 'Anula';
  C_BTN_CUT = 'Corta';
  C_BTN_COPY = 'Copia';
  C_BTN_PASTE = 'Cola';
  C_BTN_DELETE = 'Elimina';
  C_BTN_SELECTALL = 'Seleciona Tudo';

  C_SG_Parameter = 'Parametro';
  C_SG_Field = 'Campo';
  C_SG_Name = 'Nome';
  C_SG_Type = 'Tipo';
  C_SG_Info = 'Info';
  C_SG_Value = 'Valor';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Cancela';
  C_BF_CANCEL_ACCEL = '&Cancela';
  C_BF_APPLY = 'Aplica';
  C_BF_HELP = 'Ajuda';
  C_BF_EXECUTE = 'Executa';
  C_BF_CLOSE = 'Fecha';
  C_BF_CLOSE_ACCEL = '&Fecha';
  C_BF_FINISH = 'Termina';
  C_BF_FINISH_ACCEL = '&Termina';

  C_FRM_Ordering = 'Ordenando';
  C_FRM_RESTRUCTURE = 'Mostra Campos Configurados';

  C_CB_WordWrap = 'Formata Texto';

  // IBF_SQL
  M_SQL_RowsAffected = 'LinhasAfectadas: ';
  M_SQL_RowsCounted = 'Numero de Linhas: ';
  M_SQL_SessionBusy = 'A Sess�o encontra-se ocupada';
  M_SQL_CompleteTransaction = 'Por favor complete a transa��o';
  M_SQL_CannotDeleteDefaultGroup = 'O Grupo Padr�o n�o pode ser suprimido';
  M_SQL_ReservedName = 'Este nome � reservado: ';
  M_SQL_BackSlashNotAllowed = 'Barra de direct�rio n�o permitida';
  M_SQL_BlankNameNotAllowed = 'Nome em branco n�o � permitido';
  M_SQL_RowsFetched = 'Linhas Lidas: ';
  M_SQL_ConfirmDBCreation = 'Tem a certeza que pretende criar a Base de Dados?';
  M_SQL_ConfirmNoOtherDBSameName = 'Por favor assegure-se que n�o existe ourta base de dados com o mesmo nome.';
  M_SQL_ConfirmDBDrop = 'Tem a certeza que que pretende suprimir esta Base de Dados?';
  M_SQL_ReConfirmDBDrop = 'Esta Base de Dados ser� removida permanentemente.'+#13#10+#13#10'Pretende continuar?';
  M_SQL_AskFormName = 'Insira o nome do �cran de Query:';
  M_SQL_AskGroupName = 'Insira o nome do grupo:';
  M_SQL_AskLayoutName = 'Insira o nome do Esquema:';
  M_SQL_ConfirmGroupDeletion = 'Pretende mesmo suprimir o %s grupo incluindo todos os items filhos?';
  M_SQL_ConfirmLayoutDeletion = 'Pretende mesmo suprimir o esquema %s?';
  M_SQL_RecursiveCopyNotAllowed = 'Copia recursiva n�o � perrmitida';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Duplo clique num item ou pressione enter com um item seleccionado.';
  M_GCSQL_ParameterValue = 'Valor Parametro';
  M_GCSQL_TypeAValueFor = 'Digite um valor para %s';
  M_GCSQL_ProcedureWithoutParams = 'Este procedimento n�o possui parametros de entrada.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Exporta��o de Dados encontra-se ainda activa.';
  M_DP_ARE_YOU_SURE = 'Tem a certeza?';
  M_DP_SELECT_SOURCE_DB = 'Seleccione a Base de Dados Origem';
  M_DP_SELECT_DEST_DB = 'Selecione a Base de Dados Destino';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Limpa';
  M_USERS_COMPLETED_OK = 'Opera��o concluida com sucesso';
  M_USERS_NO_CONNECTION = 'Nenhuma IB_Connection definida.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Assigar items de ordena��o?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'In�cia Exporta��o';
  M_EXPORT_STILL_ACTIVE = 'O processo de exporta��o ainda est� activo.'; 

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Consulta BD';
  C_wbBrowseBtnCaption  = 'Consulta';
  C_wbDSQLBtnHint       = 'Executa instru��o na BD';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitoriza os Eventos da BD';
  C_wbEventsBtnCaption  = 'Eventos';
  C_wbExportBtnHint     = 'Exporta Dataset da BD';
  C_wbExportBtnCaption  = 'Exporta';
  C_wbDumpBtnHint       = 'Extrai BD';
  C_wbDumpBtnCaption    = 'Extrai';
  C_wbPumpBtnHint       = 'Preenche dados com origem noutra BD';
  C_wbPumpBtnCaption    = 'Preenche';
  C_wbWhoBtnHint        = 'Mostra quem est� Ligado a esta BD';
  C_wbWhoBtnCaption     = 'Quem';
  C_wbScriptBtnHint     = 'Executa Script';
  C_wbScriptBtnCaption  = 'Script';
  C_wbExtractBtnHint    = 'Extrai Metadados DDL';
  C_wbExtractBtnCaption = 'Extrai Metadados';
  C_wbMonitorBtnHint    = 'Analiza SQL e Chamadas API';
  C_wbMonitorBtnCaption = 'Monitoriza';
  C_wbProfilerBtnHint   = 'Perfil da Actividade da BD';
  C_wbProfilerBtnCaption= 'Perfilar';
  C_wbStatusBtnHint     = 'Mostra o Estado dos Componentes IBO';
  C_wbStatusBtnCaption  = 'Estado';
  C_wbUsersBtnHint      = 'Administra Utilizadores do Servidor de Base de Dados';
  C_wbUsersBtnCaption   = 'Utilizadores';
  
  // Array grid
  C_AG_Row             = 'Linha';
  C_AG_Column          = 'Coluna';

  //IBF_Who
  C_WHO_FRM            = 'Quem est� ligado';
  C_WHO_BTNAPPLY       = 'Refresca';

  C_NB_FIRST = 'Primeiro';
  C_NB_PRIOR = 'Anterior';
  C_NB_NEXT = 'Pr�ximo';
  C_NB_LAST = '�ltimo';

  C_ST_Open = 'Abre';
  C_ST_Close = 'Fecha';
  C_ST_Prepare = 'Prepara';
  C_ST_Unprepare = 'DesPrepara';
  C_ST_ReadOnly = 'S� Leitura';
  C_ST_New = 'Novo';
  C_ST_Post = 'Grava';
  C_ST_Cancel = 'Cancela';
  C_ST_Delete = 'Suprime';
  C_ST_Edit = 'Edita';
  C_ST_RefreshKeys = 'Refresca Chaves';
  C_ST_RefreshRows = 'Refresca Linhas';
  C_ST_Refresh = 'Refresca';

{ Hints }

  H_UB_EDIT = 'Edita Linha';
  H_UB_INSERT = 'Insere Linha';
  H_UB_DELETE = 'Suprime Linha';
  H_UB_REFRESH = 'Refresca todos os Registos';
  H_UB_REFRESHKEYS = 'Refresca Chaves do Registo';
  H_UB_REFRESHROWS = 'Refresca Linha do Registo';
  H_UB_REFRESHFILTROWS = 'Refresca Linha filtradas';
  H_UB_POSTSEARCH = 'Grava Crit�rio de procura';
  H_UB_CANCELSEARCH = 'Cancela crit�rio de procura';
  H_UB_POSTEDIT = 'Grava altera��es';
  H_UB_CANCELEDIT = 'Cancela altera��es';
  H_UB_POSTINSERT = 'Grava inser��o';
  H_UB_CANCELINSERT = 'Cancela inser��o';
  H_UB_POSTDELETE = 'Suprime grava��o';
  H_UB_CANCELDELETE = 'Cancela supress�o';
  H_UB_POST = 'Grava altera��es';
  H_UB_CANCEL = 'Cancela altera��es';

  H_NB_FIRST = 'Primeira Linha';
  H_NB_PRIOR = 'Linha Anterior';
  H_NB_NEXT = 'Pr�xima Linha';
  H_NB_LAST = '�ltima Linha';
  H_NB_JUMPBCK = 'Para Tr�s';
  H_NB_JUMPFWD = 'Para Frente';

  H_SB_ORDER = 'Ordena Linhas no Dataset';
  H_SB_LAST_CRITERIA = 'Chama o �ltimo �crit�rio de novo';
  H_SB_SEARCH = 'Procura no Dataset';
  H_SB_SAVE_CRITERIA = 'Guarda o Crit�rio';
  H_SB_CLEAR_CRITERIA = 'Limpa o Crit�rio';
  H_SB_RECALL_CRITERIA = 'Chama o Crit�rio de novo';
  H_SB_SEARCHCOUNT = 'Conta o numero de Linhas no Dataset que respeitam o Crit�rio';
  H_SB_COUNT = 'Conta o numero de Linhas no Dataset';
  H_SB_RESTRUCTURE = 'Configura os Campos Vis�veis';

  H_TB_StartTransaction = 'Inicia a Transa��o';
  H_TB_PostDatasets = 'Grava Datasets';
  H_TB_CancelDatasets = 'Cancela Datasets';
  H_TB_SavePoint = 'Grava e Ret�m a Transa��o Corrente';
  H_TB_CommitRetain = 'Grava Datasets e Grava e Ret�m a Transa��o Corrente';
  H_TB_Commit = 'Grava e Finaliza a Transa��o Corrente';
  H_TB_Rollback = 'Anula e Finaliza a Transa��o Corrente';
  H_TB_RollbackRetain = 'Anula e Ret�m a Transa��o Corrente';
  H_TB_Close = 'Fecha a Transa��o Corrente';

  H_ST_Prepare_Statement = 'Prepara Instru��o';
  H_ST_Unprepare_Statement = 'Desprepara Instru��o';
  H_ST_Execute_Statement = 'Executa Instru��o';

  H_DS_Open_Dataset = 'Abre Dataset';
  H_DS_Close_Dataset = 'Fecha Dataset';
  H_DS_Prepare_Dataset = 'Prepara Dataset';
  H_DS_Unprepare_Dataset = 'DesPrepara Dataset';
  H_DS_ReadOnly_Dataset = 'Dataset apenas de leitura';

  H_CB_Create_Database = 'Cria Base de Dados';
  H_CB_Connect_Database = 'Liga Base de Dados';
  H_CB_Disconnect_Database = 'Desliga Base de Dados';
  H_CB_Drop_Database = 'Suprime Base de Dados';
  
  H_RD_actHide = 'Esconde Campos seleccionados';
  H_RD_actHideAll = 'Esconde todos os Campos';
  H_RD_actVisible = 'Coloca os campos seleccionados vis�veis';
  H_RD_actVisibleAll = 'Coloca todos os campos seleccionados vis�veis';
  H_RD_actUp = 'Move os campos seleccionados para cima, uma vez';
  H_RD_actTop = 'Move os campos seleccionados para o �nicio';
  H_RD_actDown = 'Move os campos seleccionados para baixo, uma vez';
  H_RD_actBottom = 'Move os campos seleccionados para o fim';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Exporta da instru��o SELECT';

 // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Falta entrada para o ficheiro Ascii';
  eNoDestTableEntry          = 'Falta entrada para a tabela destino';
  eAsciiFileNotFound         = 'Ficheiro Ascii %s n�o encontrado';
  eIniFileNotFound           = 'Ficheiro Ini %s n�o encontrado';
  eNoAsciiFileAccess         = 'N�o foi poss�vel abrir o ficheiro ascii %s'; 
  eInvalidCharFound          = 'Caracter inv�lido / erro de formata��o no ficheiro ascii';
  eOutOfMemory               = 'Sem mem�ria dispon�vel';
  eFieldDescriptionError     = 'Erro na descri��o do campo';
  eWrongAsciiFieldCount      = 'N�mero errado de campos no ficheiro ascii, linha (%d)';
  eWrongDecimalCount         = 'Numero de contagem decimal errada na lista de campos (%s)';
  eWrongFieldWidth           = 'Tamanho do campo errado no ficheiro ascii';

  // Metadata Extract Stuff
  // ------------------------

  // Entity Type Names
  STR_DDL_UnnamedItem = '<SEM NOME>';
  STR_DDL_etDatabase = 'Base de Dados';
  STR_DDL_etException = 'Excep��o';
  STR_DDL_etBlobFilter = 'Filtro de Blob';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Gerador';
  STR_DDL_etDomain = 'Dom�nio';
  STR_DDL_etTable = 'Tabela';
  STR_DDL_etView = 'Vista';
  STR_DDL_etProcedure = 'Procedimento';
  STR_DDL_etRole = 'N�vel de Acesso';
  STR_DDL_etPrimaryKey = 'Chave Prim�ria';
  STR_DDL_etUniqueKey = 'Chave �nica';
  STR_DDL_etForeignKey = 'Chave Estrangeira';
  STR_DDL_etConstraint = 'Restri��o';
  STR_DDL_etIndex = '�ndice';
  STR_DDL_etTrigger = 'Automatismo';
  STR_DDL_etPermission = 'Permiss�o';
  STR_DDL_etUDFParam = 'Par�metro de UDF';
  STR_DDL_etTableField = 'Campo da Tabela';
  STR_DDL_etViewField = 'Campo da Vista';
  STR_DDL_etProcParam = 'Par�metro do Procedimento';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Cria Base de Dados';
  STR_DDL_coSecondaryFiles = 'Define Ficheiros Secund�rios';
  STR_DDL_coDefineShadows = 'Define Espelhos';
  STR_DDL_coSetGeneratorVal = 'Muda Valor de Gerador';
  STR_DDL_coResetExceptionNo = 'Reinicia Numero de Excep��o';
  STR_DDL_coRawFieldDefs = 'Defini��es de Campos';
  STR_DDL_coIsolateAllComputed = 'Isola Todos os Campos Calculados';
  STR_DDL_coReportMinor = 'Relat�rio Simples';
  STR_DDL_coAlwaysQuoted = 'Sempre com Aspas';
  STR_DDL_coAlwaysCharSet = 'Definir sempre a P�gina de Caracteres';
  STR_DDL_coIncludeDebug = 'Incluir Coment�rios de An�lise';
  STR_DDL_coDescripAsComment = 'Descri��es como Coment�rio';
  STR_DDL_coIgnoreDependencies = 'Ignora Dependencias';
  STR_DDL_coKeepCustomIndexNames = 'Manter Nomes de Ind�ces';

  // CodePass Names
  STR_DDL_cpFull = 'Completo';
  STR_DDL_cpInit = 'Inicial';
  STR_DDL_cpFinal = 'Final';
  STR_DDL_cpAuto = 'Autom�tico';

  // Problem level names
  STD_DDL_plNone       = 'Nenhum';
  STD_DDL_plMinor      = 'Menor';
  STD_DDL_plSuspicious = 'Suspeito';
  STD_DDL_plWarning    = 'Aviso';
  STD_DDL_plError      = 'Erro';
  // abbreviated Problem level names (to 5 characters)
  STD_DDL_plNone_s       = 'NADA ';
  STD_DDL_plMinor_s      = 'MENOR';
  STD_DDL_plSuspicious_s = 'SUSP ';
  STD_DDL_plWarning_s    = 'AVISO';
  STD_DDL_plError_s      = 'ERRO ';

  // Dialog strings
  STR_DDL_DialogCaption = 'Extrai Metadados';
  STR_DDL_Configure = 'Configura';
  STR_DDL_Filters = 'Filtros';
  STR_DDL_Script = 'Script';
  STR_DDL_MetadataControls = 'Controlos de Metadados';
  STR_DDL_CodeOptions = 'Op��es de C�digo';
  STR_DDL_Entities = 'Entidades';
  STR_DDL_Terminator = 'Terminador';
  STR_DDL_InsertCommits = 'Insere Commits';
  STR_DDL_ExecuteControls = 'Executa Controlos';
  STR_DDL_CodePass = 'Pass. de C�digo';
  STR_DDL_ExtractToStrings = 'Extrai para Texto';
  STR_DDL_Reset = 'Reinicia';
  STR_DDL_ResetAll = 'Reinicia Tudo';
  STR_DDL_ProgressControls = 'Controlos de Progresso';
  STR_DDL_Stop = 'P�ra';
  STR_DDL_IncludeSystem = 'Inclui Objectos de Sistema';
  STR_DDL_NameMasks = 'M�scaras de Nome';
  STR_DDL_SaveToFile = 'Guarda para Ficheiro';
  STR_DDL_RunScript = 'Executa Script';
  STR_DDL_ScriptCommands = 'Comandos &Script';

  // Errors/Problems reported during extract processing
  // Note that all replaceable parameters use %s (string), any necessary
  // conversions will be performed in the code.
  E_DDL_CURSOR_NOT_CREATED = 'Cursor N�o Criado';
  E_DDL_BLANK_NAME         = 'Nome em Branco';
  E_DDL_ENTITY_NOT_FOUND   = 'Entidade N�o Encontrada';
  E_DDL_RESERVED_NAME      = 'Nome Reservado para entidades n�o pertencentes ao Sistema.';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Tabela de Caracteres %s n�o foi encontrada para obter o seu nome can�nico';
  E_DDL_MODULE_NAME_EMPTY  = 'O Nome do M�dulo est� vazio';
  E_DDL_ENTRY_POINT_EMPTY  = 'O Ponto de Entrada est� vazio';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'Dom�nio Externo s� pode ser impl�cito';
  E_DDL_DOMAIN_TYPE_16     = 'Tipo 16 s� pode ser NUMERICO ou DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'Identificador de Caracter NULL, assumindo NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Falta o nome para o identificador de caracter %s Assumindo NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'BytesPerCharacter era zero no caracter %s';
  E_DDL_FIELDLEN_MISMATCH  = 'FieldLength %s deve ser m�ltiplo de %s bytes por character na tabela de caracteres de nome %s';
  E_DDL_INVALID_COLLATIONID = 'Collation Id n�o pode ser < 0 mas � %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Collation Id era NULL, assumindo %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Tupi de Campo %s desconhecido';
  E_DDL_CSTRING_IN_DSQL = 'Tipo de Campo CSTRING n�o � aceite por DSQL';
  E_DDL_QUAD_IN_DSQL = 'Tipo de Campo QUAD n�o � aceite por DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Valida��o suspeita: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Declareda mas restri��o de valida��o vazia';
  E_DDL_EXPLICIT_COMPUTED = 'Dom�nio Explicito n�o pode ser COMPUTED';
  E_DDL_VOID_COMPUTED = 'Declarado mas defini��o COMPUTED BY vazia';
  E_DDL_SUSPICIOUS_DEFAULT = 'Valor por omiss�o suspeito: %s';
  E_DDL_VOID_DEFAULT = 'Declarado mas valor por defeito vazio';
  E_DDL_DIMENSIONS_MISMATCH = 'Declarado com %s dimens�es mas foram encontrados detalhes para %s dimens�es.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Dom�nio Impl�cito n�o possui rela��o.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Dom�nio Impl�cito possui rela��o ou nome de campo ausente.';
  E_DDL_NO_OUTPUT_PARAMETER = 'Sem Par�metros de Sa�da';
  E_DDL_NO_GRANTOR = 'Grantor n�o especificado';
  E_DDL_VIEW_NO_BLR = 'N�o possui view_blr mas surge em rdb$view_relations como VISTA';
  E_DDL_VIEW_NO_VIEW_RELATION = 'Possui view_blr mas n�o aparece em rdb$view_relations como VISTA';
  E_DDL_NO_OWNER = 'Nome do Dono n�o especificado';
  E_DDL_FORMAT_VERSION = 'Vers�o de Formata��o em %s';
  E_DDL_DBKEY_LEN = 'DbKey_Length deveria ser 8 mas � %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'Defini��o Domain/Field para o campo %s n�o encontrada';
  E_DDL_NO_SOURCE_CODE = 'N�o possui c�digo acess�vel';
  E_DDL_WITH_CHECK_COMPLETION = '"With check" alterado para "with check option"';
  E_DDL_NO_BLR = 'N�o possui BLR acess�vel';
  E_DDL_CORRUPT_SOURCE = 'Prefixo de Fonte n�o reconhecido, isto pode indicar corrup��o';
  E_DDL_INDEX_ID_NULL_INACTIVE = 'Id � NULL e chave est� inactiva';
  E_DDL_INDEX_ID_NULL_ACTIVE = 'Id � NULL mas chave est� activa';
  E_DDL_INVALID_INDEX_ID = 'Id deveria iniciar em 1 n�o em %s';
  E_DDL_FK_INDEX_NO_CONSTRAINT = 'Decalarada chave estrangeira mas n�o foi encontrada nas restri��es de rela��o como chave FK';
  E_DDL_CONSTRAINT_NO_FK_INDEX = 'N�o declara chave estrangeira mas foi encontrada nas restri��es de rela��o como chave FK';
  E_DDL_INDEX_MULTI_USE = 'Usado em %s restri��o de rela��o ao mesmo tempo';
  E_DDL_INDEX_NO_FIELDS = 'Usa %s campos';
  E_DDL_INDEX_DUPLICATE = 'Aparenta ser uma chave duplicada nas defini��es da tabela: %s';
  E_DDL_INDEX_SEG_MISMATCH = 'Chave na tabela: %s declara %s segmentos, mas foram encontrados detalhes para %s segmentos';
  E_DDL_CONSTRAINT_OUT_OF_RANGE = 'Tipo de Restri��o %s fora dos limites';
  E_DDL_CONSTRAINT_USING_INDEX = 'Tipo de Restri��o %s n�o deveria usar chave mas usa a chave: %s';
  E_DDL_CONSTRAINT_NO_INDEX = 'Tipo de Restri��o %s deveria usar uma chave e tal n�o � o caso';
  E_DDL_UPDATE_RULE_INVALID = 'Regra de Modifica��o %s est� fora dos limites';
  E_DDL_DELETE_RULE_INVALID = 'Regra de Elimina��o %s est� fora dos limites';
  E_DDL_PARENT_CONSTRAINT_EMPTY = 'Nome de restri��o para a rela��o pai est� vazia';
  E_DDL_FOREIGN_NOT_DEFINED = 'Tabela Estrangeira ou Chave n�o est� definida';
  E_DDL_PARENT_SHOULD_BE_EMPTY = 'Nome de restri��o para rela��o pai deveria estar vazia, mas possui %s';
  E_DDL_UPDATE_SHOULD_BE_EMPTY = 'Regra de Altera��o deveria estar vazia mas possui %s';
  E_DDL_DELETE_SHOULD_BE_EMPTY = 'Regra de Elimina��o deveria estar vazia mas possui %s';
  E_DDL_NO_BLR_WITH_CHECK =  'N�o existe c�digo acess�vel, poss�velmente usado pela vista %s com op��o de valida��o';
  E_DDL_TRIGGER_LOST_CHECK = 'Come�a com a palavra "CHECK" . � usada por uma restri��o de valida��o que foi perdida';
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Tipo de Trigger desconhecido: %s';
  E_DDL_NEGATIVE_SEQUENCE = 'Possui sequ�ncia negativa %s';
  E_DDL_NO_TARGET_RELATION = 'Tabela ou Vista n�o especificada';
  E_DDL_NOT_IN_DEPENDENCIES = 'Declarada mas n�o encontr but not found in dependencies. It is not a bug in some special cases';
  E_DDL_SUSPICIOUS_TRIGGER = 'Trigger suspeito depende de outras tabelas mas n�o daquela � qual est� ligado';
  E_DDL_INVALID_TRIGGER_SEQ = 'Sequ�ncia de Trigger � %s mas deveria ser menos do que 1 para um triger impl�cito';
  E_DDL_GRANT_OUT_OF_RANGE = 'Op��o Grant/Admin fora do limite 0..2 : %s';
  E_DDL_GRANT_TO_USER_TYPE = 'Op��o Grant/Admin atribu�da ao tipo de utilizador %s';
  E_DDL_GRANT_FIELDS = 'Tentando alterar campos espec�ficos mas o previl�gio n�o � U ou R';
  E_DDL_EXECUTE_TO_OBJECT = 'Atribuindo EXECUTE ao tipo de objecto %s que deveria ser antes 5 (proc)';
  E_DDL_BAD_PRIV_ON_PROC = 'Atribuindo %s ao procedimento %s';
  E_DDL_MEMBER_TO_OBJECT = 'Atribuindo menro ao tipo de objecto %s que deveria ser antes 13 (role)';
  E_DDL_BAD_PRIV_ON_ROLE = 'Atribuindo %s na role %s';
  E_DDL_BAD_ARG_POS =  'Posi��o do Argumento deveria ser >=0 mas � %s';
  E_DDL_SYSTEM_FLAG_MISMATCH = 'SystemFlag diferente da do pai';
  E_DDL_BAD_FIELD_ID = 'Id do Campo deveria ser >=0 mas � %s';
  E_DDL_BAD_FIELD_POS = 'Posi��o do Campo deveria ser >=0 mas � %s';
  E_DDL_BAD_TABLE_BASEFIELD = 'BaseField deveria estar vazio para tabelas mas � %s';
  E_DDL_BAD_TABLE_VIEWCONTEXT = 'ViewContext devera estar vazio para tabelas mas � %s';
  E_DDL_MANDATORY_IN_VIEW = 'N�o � poss�vel ser mandat�rio numa Vista';
  E_DDL_BASEFIELD_EMPTY = 'BaseField n�o deveria estar vazio para vistas se ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext n�o pode estar vazio para vistas';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext deveria ser >= 0 para vistas';
  E_DDL_BAD_PARAM_TYPE = 'Tipo de par�metro %s est� fora dos limites';
  E_DDL_BAD_PARAM_NUM = 'N�mero do Par�metro deveria ser >=0 mas � %s';

  // Comments output with DDL statements
  C_DDL_CONNECT_USERNAME   = 'Liga��o usando o utilizador: %s';
  C_DDL_CONNECT_SERVER_VER = 'e servidor: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'Sem Ficheiros Secund�rios';
  C_DDL_SEC_FILES = 'Ficheiros Secund�rios';
  C_DDL_SEC_FILE_DESC = '%s, Inicio: %s, Tamanho: %s';
  C_DDL_NO_SHADOW_FILES = 'Sem Ficheiros Sombra';
  C_DDL_SHADOW_FILES = 'Ficheiros Sombra';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, In�cio: %s, Tamanho: %s';
  C_DDL_EXCEPTION_DESC = 'Excep��o: %s, N�mero Original: %s';
  C_DDL_FIELD_NOT_FOUND = 'Campo n�o Encontrado: %s';
  C_DDL_INDEX_NOT_FOUND = 'Chave n�o encontrada';
  C_DDL_NO_FOREIGN_RELATION = 'Nenhuma Rela��o Estrangeira ou chave definida para a Restri��o';
  C_DDL_FOREIGN_NOT_FOUND = 'Rela��o Estrangeira n�o encontrada: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Chave Estrangeira n�o encontrada: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Trigger N�o Encontrado: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Nome de Tipo de Restri��o Inv�lido: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'Sem c�digo para Trigger: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'Tipo de Trigger Desconhecido: %s';
  C_DDL_BAD_PRIVILEGE = 'Previl�gio Desconhecido: %s';

implementation

end.
