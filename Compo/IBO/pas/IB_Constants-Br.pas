
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
{   Contributing Authors:                                                      }
{                                                                              }
{     Walter Campelo <walter@weasistemas.com.br>                               }
{     João Batista Silva .'. <saxum@ig.com.br>                                 }
{     Carlos H Cantu <www.interbase-br.com>                                    }
{     Fábio R Bot Silva <fabiobot@puppi.com.br>                                }
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
  IB_VERSION_BUILD = 'H';
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

  IB_REG_MESSAGE = 'Obrigado por avaliar o IB Objects.'#10#13#10#13'Por favor vá ao site http://www.ibobjects.com e registre-se hoje.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'A conexão já foi estabelecida';
  E_NOT_CONNECTED     = 'A conexão não foi estabelecida';
  E_Invalid_conn_path = 'Caminho de conexão inválido';
  E_Cant_Repl_Int_Tr  = 'Não é possível substituir a transação interna como padrão';
  E_NO_TRANS_STARTED  = 'A transação não foi iniciada';
  E_TRANS_STARTED     = 'A transação já foi iniciada';
  E_NO_CONNECTIONS    = 'A transação não possui uma conexão';
  E_NOT_ENOUGH_CONN   = 'A transação não encontra uma ou mais conexões';
  E_CONN_LOADING      = 'Aviso: A conexão ainda está sendo carregada';
  E_TRANS_CONN_SESS   = 'Todas as conexões devem pertencer a uma mesma IB_Session';
  E_TransactionPaused = 'A transação está em pausa';
  E_ALLOCATED         = 'A sentença já foi alocada';
  E_NOT_ALLOCATED     = 'A sentença não foi alocada';
  E_PREPARED          = 'A sentença já foi preparada';
  E_NOT_PREPARED      = 'A sentença não foi preparada';
  E_FAILED_TO_PREPARE = 'Falha ao preparar a sentença';
  E_OPENED           = 'A sentença já foi aberta';
  E_NOT_OPENED       = 'A sentença não foi aberta';
  E_CANT_DELETE      = 'O registro atual neste cursor não pode ser apagado';
  E_NO_CONNECTION    = 'A sentença deve ter uma IB_Connection designada';
  E_CONNECT_FAILED   = 'Incapaz de abrir a IB_Connection';
  E_NO_TRANSACTION   = 'A sentença deve ter uma IB_Transaction designada';
  E_NO_ACTIVE_TRANS  = 'Não há uma transação ativa para a execução';
  E_START_FAILED     = 'Incapaz de iniciar uma transação';
  E_SVRAUTOCMT_NOEXP = 'Não é permitida uma transação explícita com ServerAutoCommit';
  E_Cannot_Activate  = 'Estado inválido da transação. Não é possível ativar';
  E_Transaction_Is_Active = 'A transação possui alterações pendentes';
  E_Failed_To_Post_Datasets = 'Falha ao salvar todos os Datasets';
  E_Failed_To_Cancel_Datasets = 'Falha ao cancelar a gravação de todos os Datasets';
  E_UpdateWrongTrn    = 'Não é possível atualizar, %s não pertence a %s';
  E_NO_BLANK_SQL      = 'Não é permitida uma sentença SQL em branco';
  E_AT_END_OF_FILE    = 'No final do arquivo';
  E_AT_END_OF_CURSOR  = 'No final do cursor';
  E_AT_END_OF_BUFFER  = 'No final do buffer';
  E_AT_END_OF_DATASET = 'No final do dataset';
  E_BAD_SQL_INF_LEN   = 'Tamanho inesperado de isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Dados inválidos foram retornados por isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Não é possível alterar o nome do cursor enquanto este estiver ativo';
  E_REQUEST_LIVE_ACTIVE = 'Não é possível alterar o RequestLive enquanto ativo';
  E_REQUEST_LIVE_READONLY = 'Não é possível ajustar o RequestLive para verdadeiro em um dataset somente para leitura';
  E_CURSOR_UNI              = 'O IB_CURSOR é unidirecional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Tipo de coluna não suportado: %d';
  E_FIELDNO_NOT_FOUND         = 'Campo Nº: %d não encontrado';
  E_FIELDNAME_NOT_FOUND        = 'Campo: %s não encontrado';
  E_INVALID_FOCUS_RELATION_NO   = 'Relação No: %d inválida';
  E_INVALID_FOCUS_RELATION_NAME = 'Relação: %s inválida';
  E_INVALID_QBE_IN              = 'Erro de sintaxe em: IN( valor [ , valor ... ] )';
  E_INVALID_QBE_BETWEEN         = 'Erro de sintaxe em: BETWEEN valor AND valor';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Não é possível localizar a DLL de importação %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Valor da propriedade SQLKeyFields inválido';
  E_GET_CURSOR_ERROR      = 'Não é possível abrir o cursor sem os dados chaves';
  E_SCROLL_ERROR          = 'Registro chave perdido'#10#13'Falha ao abrir o cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Valor de BufferRowNum inválido antes de iniciar';
  E_BLANK_STATEMENT      = 'Não é possível preparar uma sentença em branco';
  E_UNKNOWN_STATEMENT  = 'Tentativa de executar uma sentença desconhecida';
  E_CIRCULAR_REFERENCE = 'Não é permitida referência circular';
  E_CANT_CHG_WITH_CONN  = 'Não é possível alterar enquanto estiver conectado';
  E_LOGIN_FAILED        = 'Falha durante o Login';
  E_CANT_GET_CONN_CHR   = 'Não foi possível obter as características da conexão';
  E_MAX_EVENTS_BLOCK   = 'Número máximo de eventos para um bloco excedido';
  E_PROCESSING_EVENTS = 'Processando eventos'#13#10'Não é possível finalizar o registro';
  E_CANT_STORE_BLOB = 'Blob já foi ou não pode ser salvo';
  E_CANT_LOAD_BLOB   = 'Blob já foi ou não pode ser carregado';
  E_CANNOT_CANCEL_ROW = 'Não é possível cancelar o registro atual';
  E_CANNOT_POST_ROW = 'Não é possivel salvar o registro atual';
  E_DatasetClosed = 'O Dataset está inativo';
  E_DatasetOpen      = 'O Dataset já está aberto';
  E_DatasetCannotScroll = 'O Dataset não pode ser movimentado';
  E_DatasetReadOnly   = 'O Dataset é somente para leitura';
  E_DatasetIsFetching = 'O Dataset está sendo carregado';
  E_Invalid_KeyRelation = 'Valor da propriedade KeyRelation inválido';
  E_RowNum_Not_Implemented = 'RowNum ainda não foi implementado';
  E_RowDeleted = 'O registro está sendo eliminado';
  E_END_OF_DATASET = 'No final do Dataset';
  E_BEGINNING_OF_DATASET = 'No início do Dataset';
  E_Cannot_Pessimistic_Lock = 'Não é possível utilizar bloqueio pessimista com LockWait';
  E_Cannot_Edit_Row = 'Não é possível alterar o registro atual';
  E_Cannot_Insert_Row = 'Não é possível inserir um novo registro';
  E_Cannot_Delete_Row = 'Não é possível apagar o registro atual';
  E_Cannot_Search = 'Pesquisa não é permitida';
  E_Cannot_Navigate = 'Não é possível navegar';
  E_Record_Locked = 'O registro está bloqueado por outro usuário';
  E_Record_OutOfSynch = 'O registro foi alterado por outro usuário';
  E_FLD_READONLY = '%s é somente para leitura';
  E_Required_Field = '%s é um campo obrigatório';
  E_NO_POSTRTN_CACHED_UPDT = 'Não é possível utilizar PostRetaining com Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Registros múltiplos em um carregamento de registro único';

  E_InvalidRowsAffectedBuf = 'O buffer RowsAffected é inválido';
  E_Invalid_RowNum_Past_Eof = 'RowNum além do final do arquivo inválido';
  E_Invalid_RowNum_Before_Bof = 'RowNum antes do início do arquivo inválido';
  E_Invalid_Bookmark = 'Texto de Bookmark inválido';

  E_Assign_Column   = 'Não é possível atribuir a partir de %s';
  E_AssignTo_Column = 'Não é possível atribuir para %s';
  E_Value_Out_Of_Range = 'Valor fora dos limites';
  E_SmallintOverflow = 'Smallint overflow';
  E_IntegerOverflow = 'Integer overflow';
  E_Int64Overflow = 'Int64 overflow';

  E_Unsupported_Column = 'Tipo de coluna não suportado: %d';
  E_UndefinedMacro = 'Macro não definida';
  E_GeneratorFailed = 'Não é possível obter o valor do gerador';

  E_MustBe_Buffered_Dataset = 'IB_Query deve ser derivada de TIB_BDataset';

  E_NO_CHANGE_READONLY = 'Não é possível alterar ReadOnly uma vez iniciado';
  E_NO_CHANGE_ISOLATION = 'Não é possível alterar Isolation uma vez iniciado';
  E_NO_CHANGE_RECVERSION = 'Não é possível alterar RecVersion uma vez iniciado';
  E_NO_CHANGE_LOCKWAIT = 'Não é possível alterar LockWait uma vez iniciado';

  E_Invalid_Reference_To_Delete = 'Referência inválida a Delete';
  E_Invalid_Typecast = 'Conversão de tipos inválida';
  E_Invalid_DataPump_Statement = 'Tipo de sentença inválido para DataPump';
  E_FIELD_NOT_NULLABLE = 'Atribuído valor NULL para um campo NOT NULL';
  E_DATABASE_BLANK = 'A propriedade DatabaseName não pode estar vazia';
  E_Unsupp_Col_Conversion = 'Conversão de coluna não suportada';
  E_Unable_To_Locate_Record = 'Não é possível localizar o registro';
  E_Record_Not_Inserted = 'O registro não foi inserido';
  E_Invalid_KeyLinks = 'Entrada inválida na propriedade KeyLinks: %s';
  E_Unable_to_perform_search = 'Não é possível efetuar a pesquisa';
  E_Unassigned_Blob_Node = 'BlobNode não atribuído';
  E_Unassigned_Transaction = 'Transação não atribuída';
  E_Invalid_RowsAffected_Buffer = 'O Buffer para RowsAffected é inválido';
  E_Unable_Save_Graphic = 'Não é possível salvar para Graphic';
  E_Cannot_Activate_Transaction = 'Não é possível ativar a transação';
  E_IB_Client_Not_Installed = 'O cliente InterBase (GDS32.DLL) não está instalado';
  E_Could_Not_Load_Memo = 'Não foi possível carregar o memo';
  E_Invalid_DPB_Over_255 = 'DPB inválido: Contém mais que 255 caracteres';
  E_Inv_Custom_DML = 'Referência personalizada a coluna DML inválida: %s';
  E_Record_Not_Located_For_Update = 'O registro não foi localizado para atualização';
  E_Record_Not_Located_For_Delete = 'O registro não foi localizado para eliminação';
  E_Init_Default_SQL_Failed = 'Não foi possível inicializar o valor padrão em %s';
  E_Stringlist_Not_Sorted = 'A Stringlist deve estar ordenada para esta operação';
  E_Cannot_Change_Events = 'Não é possível alterar eventos enquanto é efetuado o processamento';
  E_Cannot_Unregister_Events = 'Não é possível finalizar o registro de eventos enquanto é efetuado o processamento';
  E_Invalid_Internal_Transaction = 'IB_Transaction interna inválida';
  E_InvalidStatementType = 'Tipo de sentença inválido';
  E_Multiple_Records_Updated = 'Multiplos registros atualizados';
  E_Multiple_Records_Deleted = 'Multiplos registros eliminados';
  E_Multiple_Records_Inserted = 'Multiple records inserted';
  E_DUP_DB_NAME = 'Não é permitida propriedade DatabaseName duplicada';
  E_INVALID_DB_NAME = 'O valor da propriedade DatabaseName é inválido';
  E_UnableToSearch_NoOrdering = 'Impossibilitado de realizar a pesquisa, nenhuma ordem foi definida';
  E_UnableToSearch_DatasetBusy = 'Impossibilitado de realizar a pesquisa, dataset está ocupado procurando por dados';
  E_NoRecordsFound = 'Nenhum registro encontrado';
  E_Session_Undefined = 'A Session está indefinida';
  E_NoCircularRef = 'Não é permitida referência circular';
  E_InvalidClassType = 'Tipo de classe inválido';
  E_Invalid_RowNum = 'RowNum inválido';
  E_Invalid_Syntax = 'Sintaxe inválida: parêntese sobrando ou faltando';
  E_Array_Is_Null = 'O Array é nulo';

  E_Cannot_add_blank_account = 'Não é possível adicionar uma conta em branco';
  E_Cannot_add_SYSDBA_account = 'Não é possível adicionar uma conta SYSDBA';
  E_Cannot_delete_blank_account = 'Não é possível apagar uma conta em branco';
  E_Cannot_delete_SYSDBA_account = 'Não é possível apagar a conta SYSDBA';
  E_Cannot_modify_blank_account = 'Não é possível alterar uma conta em branco';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Sintaxe para CREATE, CONNECT ou DROP DATABASE inválida';
  E_Unsupported = 'Não suportado';
  E_NotImplemented = 'Não implementado neste nível';
  E_Invalid_ColData = 'Inválido ColData';

  E_Cant_Unprepare_executing_process = 'Não é possível cancelar a preparação um processo que está em execução';
  E_FileName_Required = 'O preenchimento de FileName é obrigatório';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Gerenciamento das Contas dos Usuários';
  L_USERS_ADD = 'Adicionar';
  L_USERS_DELETE = 'Excluir';
  L_USERS_MODIFIY = 'Alterar';
  L_USERS_ACCOUNT = 'ACCOUNT';
  L_USERS_PASSWORD = 'Senha';
  L_USERS_GROUP = 'Grupo';
  L_USERS_FIRSTNAME = 'Primeiro Nome';
  L_USERS_MIDDLENAME = 'Nome do Meio';
  L_USERS_LASTNAME = 'Último Nome';

  //IBF_Export
  L_EXPORT_FRM = 'Exportar';
  L_EXPORT_ASCII = ' Formato de arquivo ';
  L_EXPORT_FIXED = 'TXT Registro com tamanho fixo';
  L_EXPORT_DELIMITED = 'CSV Delimitado';
  L_EXPORT_DBF  = 'DBF  (Necessita de algum teste)';
  L_EXPORT_ASCIIOPT  = ' Opções do formato ASCII';
  L_EXPORT_DELIMITER  = 'Delimitador';
  L_EXPORT_SEPARATOR  = 'Separador';
  L_EXPORT_DATEFORMAT  = 'Formato de Data';
  L_EXPORT_INCLUDEHEADERS  = 'Incluir Cabeçalhos';
  L_EXPORT_INCLUDECRLF  = 'Incluir CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Exportar';
  L_EXPORT_SDEXPORTFILTERCSV = 'Arquivos textos separado por vírgula( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Arquivos textos ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'Arquivos DBF  ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Tem certeza que deseja abortar?';
  M_Fetching_Query_Results = 'Resultado do carregamento';
  M_Row_Num = 'Linha# %d';
  M_Abort_Fetching_Btn = 'Abortar';

  M_Login_Database = 'Banco';
  M_Login_User = 'Usuário';
  M_Login_Password = 'Senha';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancelar';
  M_Login_Help_Btn = 'Aj&uda';
  M_Login_Dialog_Caption = 'Login';

  M_Loading_Caption = 'Carregando...';

  M_SB_REC_CNT = 'Total de registros: %d';
  M_Save_Changes = 'Salva as alterações?';
  M_Abort_Changes = 'Alterações serão perdidas. Continuar?';

  M_CancelTransactionPrompt = 'Tem certeza que deseja cancelar todas as alterações?';

  M_SCRIPT_ABORT_EXECUTE = 'Aborta a execução deste script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Continua executando este script?';
  M_SCRIPT_IS_EXECUTING = 'O Script já está sendo executado';
  M_SCRIPT_FAILED = 'O Script não foi concluído';
  M_SCRIPT_WAS_ABORTED = 'A execução do Script foi abortada';
  M_SCRIPT_COMPLETED = 'O Script foi completado com sucesso';
  M_SCRIPT_CMPL_EXCEPT = 'O Script foi completadom com problemas';
  M_SCRIPT_MODIFIED = 'Modificado';
  M_SCRIPT_SAVE_CHANGES = 'Salva alterações?';

{ Button captions }

  C_BTN_TODAY = 'Hoje';
  C_BTN_CLEAR = 'Limpar';

  C_SG_Parameter = 'Parâmetro';
  C_SG_Field = 'Campo';
  C_SG_Name = 'Nome';
  C_SG_Type = 'Tipo';
  C_SG_Info = 'Info';
  C_SG_Value = 'Valor';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Cancelar';
  C_BF_CANCEL_ACCEL = '&Cancelar';
  C_BF_APPLY = 'Aplicar';
  C_BF_HELP = 'Ajuda';
  C_BF_EXECUTE = 'Executar';
  C_BF_CLOSE = 'Close';
  C_BF_CLOSE_ACCEL = '&Close';
  C_BF_FINISH = 'Terminar';
  C_BF_FINISH_ACCEL = '&Terminar';

  C_FRM_Ordering = 'Ordem';
  C_FRM_RESTRUCTURE = 'Customize Fields Displyed';

  C_CB_WordWrap = 'Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'Linhas Afetadas: ';
  M_SQL_RowsCounted = 'Linhas Contadas: ';
  M_SQL_SessionBusy = 'Sessão ocupada atualmente';
  M_SQL_CompleteTransaction = 'Complete sua transação';
  M_SQL_CannotDeleteDefaultGroup = 'Grupo padrão não pode ser excluido';
  M_SQL_ReservedName = 'Este nome é reservado: ';
  M_SQL_BackSlashNotAllowed = 'Slash em branco não é permitido';
  M_SQL_BlankNameNotAllowed = 'Nome em branco não é permitido';
  M_SQL_RowsFetched = 'Linhas Lidas: ';
  M_SQL_ConfirmDBCreation = 'Deseja realmente criar este banco de dados?';
  M_SQL_ConfirmNoOtherDBSameName = 'Verifique que não existe nenhum banco com o mesmo nome.';
  M_SQL_ConfirmDBDrop = 'Tem certeza que deseja apagar este banco de dados?';
  M_SQL_ReConfirmDBDrop = 'Este banco de dados será permanetemente apagado.'+#13#10+#13#10'Posso continuar?';
  M_SQL_AskFormName = 'Nome da consulta:';
  M_SQL_AskGroupName = 'Nome do grupo:';
  M_SQL_AskLayoutName = 'Nome do layout:';
  M_SQL_ConfirmGroupDeletion = 'Deseja realmente apagar o grupo %s com todos seus sub-itens?';
  M_SQL_ConfirmLayoutDeletion = 'Confirma exclusão do layout %s ?';
  M_SQL_RecursiveCopyNotAllowed = 'Copia recursiva não permitida';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Dê um click duplo no item ou pressione Enter com um item selecionado.';
  M_GCSQL_ParameterValue = 'Valor do paramêtro';
  M_GCSQL_TypeAValueFor = 'Digite um valor para %s';
  M_GCSQL_ProcedureWithoutParams = 'Procedure não tem paramêtros.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Processo de cópia continua ativo.';
  M_DP_ARE_YOU_SURE = 'Tem certeza?';
  M_DP_SELECT_SOURCE_DB = 'Selecione banco de origem';
  M_DP_SELECT_DEST_DB = 'Selecione banco de destino';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Limpar';
  M_USERS_COMPLETED_OK = 'Operação completada com sucesso';
  M_USERS_NO_CONNECTION = 'Conexão não definida.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Atribui itens de ordenação?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Iniciar exportação';
  M_EXPORT_STILL_ACTIVE = 'Processo de exportação continua ativo.';
  
  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Consultar banco';
  C_wbBrowseBtnCaption  = 'Consultar';
  C_wbDSQLBtnHint       = 'Executar comando no banco';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitorar eventos do banco';
  C_wbEventsBtnCaption  = 'Eventos';
  C_wbExportBtnHint     = 'Exportar Dataset do banco';
  C_wbExportBtnCaption  = 'Exportar';
  C_wbDumpBtnHint       = 'Dump Database';
  C_wbDumpBtnCaption    = 'Dump';
  C_wbPumpBtnHint       = 'Copiar dados de outro banco';
  C_wbPumpBtnCaption    = 'Pump';
  C_wbWhoBtnHint        = 'Visualizar quem está conectado ao banco';
  C_wbWhoBtnCaption     = 'Quem';
  C_wbScriptBtnHint     = 'Executar Script';
  C_wbScriptBtnCaption  = 'Script';
  C_wbExtractBtnHint    = 'Extrair DDL';
  C_wbExtractBtnCaption = 'Extrair';
  C_wbMonitorBtnHint    = 'Monitar SQL e chamadas da API';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profiler';
  C_wbStatusBtnHint     = 'Ver status dos componentes IBO';
  C_wbStatusBtnCaption  = 'Status';
  C_wbUsersBtnHint      = 'Gerenciar os usuários do banco';
  C_wbUsersBtnCaption   = 'Usuários';

  // Array grid
  C_AG_Row             = 'Linha';
  C_AG_Column          = 'Coluna';

  //IBF_Who
  C_WHO_FRM            = 'Quem está conectado';
  C_WHO_BTNAPPLY       = 'Atualizar';

  C_NB_FIRST = 'Primeiro';
  C_NB_PRIOR = 'Anterior';
  C_NB_NEXT = 'Próximo';
  C_NB_LAST = 'Último';

  C_ST_Open = 'Abrir';
  C_ST_Close = 'Fechar';
  C_ST_Prepare = 'Preparar';
  C_ST_Unprepare = 'Despreparar';
  C_ST_ReadOnly = 'Somente Leitura';
  C_ST_New = 'Novo';
  C_ST_Post = 'Confirmar';
  C_ST_Cancel = 'Cancelar';
  C_ST_Delete = 'Apagar';
  C_ST_Edit = 'Editar';
  C_ST_RefreshKeys = 'Atualizar Chaves';
  C_ST_RefreshRows = 'Atualizar Linhas';
  C_ST_Refresh = 'Atualizar';

{ Hints }

  H_UB_EDIT = 'Alterar Registro';
  H_UB_INSERT = 'Inserir Registro';
  H_UB_DELETE = 'Apagar Registro';
  H_UB_REFRESH = 'Atualizar todos os registros';
  H_UB_REFRESHKEYS = 'Atualizar as chaves dos registros';
  H_UB_REFRESHROWS = 'Atualizar as linhas do registro';
  H_UB_REFRESHFILTROWS = 'Atualizar as linhas filtradas';  
  H_UB_POSTSEARCH = 'Salvar o critério de pesquisa';
  H_UB_CANCELSEARCH = 'Cancelar o critério de pesquisa';
  H_UB_POSTEDIT = 'Salvar as alterações';
  H_UB_CANCELEDIT = 'Cancelar as alterações';
  H_UB_POSTINSERT = 'Salvar inserção';
  H_UB_CANCELINSERT = 'Cancelar inserção';
  H_UB_POSTDELETE = 'Confirmar exclusão';
  H_UB_CANCELDELETE = 'Cancelar exclusão';
  H_UB_POST = 'Salvar as alterações';
  H_UB_CANCEL = 'Cancelar as alterações';

  H_NB_FIRST = 'Primeiro Registro';
  H_NB_PRIOR = 'Registro Anterior';
  H_NB_NEXT = 'Próximo Registro';
  H_NB_LAST = 'Último Registro';
  H_NB_JUMPBCK = 'Voltar';
  H_NB_JUMPFWD = 'Avançar';

  H_SB_ORDER = 'Ordenar Registros no Dataset';
  H_SB_LAST_CRITERIA = 'Recarrega o último critério de pesquisa';
  H_SB_SEARCH = 'Pesquisar no Dataset';
  H_SB_SAVE_CRITERIA = 'Salvar o critério';
  H_SB_CLEAR_CRITERIA = 'Limpar o critério';
  H_SB_RECALL_CRITERIA = 'Recarregar o critério';
  H_SB_SEARCHCOUNT = 'Contar os registros que estão em conformidade com o critério';
  H_SB_COUNT = 'Contar os registros no Dataset';
  H_SB_RESTRUCTURE = 'Customize the Fields Displayed';

  H_TB_StartTransaction = 'Iniciar Transação';
  H_TB_PostDatasets = 'Salvar os Datasets';
  H_TB_CancelDatasets = 'Cancelar os Datasets';
  H_TB_SavePoint = 'Efetua o Commit e retém a transação atual';
  H_TB_CommitRetain = 'Salva os Datasets, efetua o Commit e retém a transação atual';
  H_TB_Commit = 'Efetua o Commit e termina a transação atual';
  H_TB_Rollback = 'Efetua o Rollback e termina a transação atual';
  H_TB_RollbackRetain = 'Efetua o Rollback e retém a transação atual';
  H_TB_Close = 'Fecha a transação atual';

  H_ST_Prepare_Statement = 'Preparar Código';
  H_ST_Unprepare_Statement = 'Cancelar Preparação do Código';
  H_ST_Execute_Statement = 'Executar o Código';

  H_DS_Open_Dataset = 'Abrir Dataset';
  H_DS_Close_Dataset = 'Fechar Dataset';
  H_DS_Prepare_Dataset = 'Preparar Dataset';
  H_DS_Unprepare_Dataset = 'Despreparar Dataset';
  H_DS_ReadOnly_Dataset = 'Dataset Somente de Leitura';

  H_CB_Create_Database = 'Criar Banco';
  H_CB_Connect_Database = 'Conectar ao Banco';
  H_CB_Disconnect_Database = 'Desconectar Banco';
  H_CB_Drop_Database = 'Apagar Banco';

  H_RD_actHide = 'Ocultar campos selecionados';
  H_RD_actHideAll = 'Ocultar todos os campos';
  H_RD_actVisible = 'Tornar campos selecionados visíveis';
  H_RD_actVisibleAll = 'Tornar todos os campo visíveis';
  H_RD_actUp = 'Mover campos selecionados para cima';
  H_RD_actTop = 'Mover campos selecionados ao topo';
  H_RD_actDown = 'Mover campos selecionados para baixo';
  H_RD_actBottom = 'Mover campos selecionados ao final';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Exportar a partir de um comando SELECT';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Não foi informado o arquivo ASCII de origem';
  eNoDestTableEntry          = 'Não foi informada a tabela de destino';
  eAsciiFileNotFound         = 'Arquivo ASCII %s não encontrado';
  eIniFileNotFound           = 'Arquivo Ini %s não encontrado';
  eNoAsciiFileAccess         = 'Não foi possível a abertura do arquivo ASCII  %s';
  eInvalidCharFound          = 'Caracter inválido  / erro de formato no arquivo ASCII';
  eOutOfMemory               = 'Falta de memória';
  eFieldDescriptionError     = 'Erro na descrição do campo';
  eWrongAsciiFieldCount      = 'Contagem errada dos campos no arquivo ASCII';
  eWrongDecimalCount         = 'Número de decimais errada na lista de campos (%s)';
  eWrongFieldWidth           = 'Largura do campo errada no arquivo ASCII';

  // Dialog Labels - IB_Import
  lblRecsReadedCaption       = 'Total de registros lidos';
  lblRecsCommentedCaption    = 'Registros comentados';
  lblRecsInsertedCaption     = 'Registros inseridos';
  btnAbortImportCaption      = 'Abortar';

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
  STR_DDL_coReportMinor = 'Report Minor';
  STR_DDL_coAlwaysQuoted = 'Always Quoted';
  STR_DDL_coAlwaysCharSet = 'Always Define Character Set';
  STR_DDL_coIncludeDebug = 'Include Debug Comments';
  STR_DDL_coDescripAsComment = 'Descriptions as Comments';

  // CodePass Names
  STR_DDL_cpFull = 'Full';
  STR_DDL_cpInit = 'Initial';
  STR_DDL_cpFinal = 'Final';

  // Dialog strings
  STR_DDL_DialogCaption = 'Metadata Extract';
  STR_DDL_Configure = 'Configure';
  STR_DDL_Filters = 'Filters';
  STR_DDL_Script = 'Script';
  STR_DDL_MetadataControls = 'Metadata Controls';
  STR_DDL_CodeOptions = 'Code Options';
  STR_DDL_Entities = 'Entities';
  STR_DDL_Terminator = 'Terminator';
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

implementation

end.
