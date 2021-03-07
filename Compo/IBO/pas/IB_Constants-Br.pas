
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
{     Jo�o Batista Silva .'. <saxum@ig.com.br>                                 }
{     Carlos H Cantu <www.interbase-br.com>                                    }
{     F�bio R Bot Silva <fabiobot@puppi.com.br>                                }
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

  IB_REG_MESSAGE = 'Obrigado por avaliar o IB Objects.'#10#13#10#13'Por favor v� ao site http://www.ibobjects.com e registre-se hoje.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'A conex�o j� foi estabelecida';
  E_NOT_CONNECTED     = 'A conex�o n�o foi estabelecida';
  E_Invalid_conn_path = 'Caminho de conex�o inv�lido';
  E_Cant_Repl_Int_Tr  = 'N�o � poss�vel substituir a transa��o interna como padr�o';
  E_NO_TRANS_STARTED  = 'A transa��o n�o foi iniciada';
  E_TRANS_STARTED     = 'A transa��o j� foi iniciada';
  E_NO_CONNECTIONS    = 'A transa��o n�o possui uma conex�o';
  E_NOT_ENOUGH_CONN   = 'A transa��o n�o encontra uma ou mais conex�es';
  E_CONN_LOADING      = 'Aviso: A conex�o ainda est� sendo carregada';
  E_TRANS_CONN_SESS   = 'Todas as conex�es devem pertencer a uma mesma IB_Session';
  E_TransactionPaused = 'A transa��o est� em pausa';
  E_ALLOCATED         = 'A senten�a j� foi alocada';
  E_NOT_ALLOCATED     = 'A senten�a n�o foi alocada';
  E_PREPARED          = 'A senten�a j� foi preparada';
  E_NOT_PREPARED      = 'A senten�a n�o foi preparada';
  E_FAILED_TO_PREPARE = 'Falha ao preparar a senten�a';
  E_OPENED           = 'A senten�a j� foi aberta';
  E_NOT_OPENED       = 'A senten�a n�o foi aberta';
  E_CANT_DELETE      = 'O registro atual neste cursor n�o pode ser apagado';
  E_NO_CONNECTION    = 'A senten�a deve ter uma IB_Connection designada';
  E_CONNECT_FAILED   = 'Incapaz de abrir a IB_Connection';
  E_NO_TRANSACTION   = 'A senten�a deve ter uma IB_Transaction designada';
  E_NO_ACTIVE_TRANS  = 'N�o h� uma transa��o ativa para a execu��o';
  E_START_FAILED     = 'Incapaz de iniciar uma transa��o';
  E_SVRAUTOCMT_NOEXP = 'N�o � permitida uma transa��o expl�cita com ServerAutoCommit';
  E_Cannot_Activate  = 'Estado inv�lido da transa��o. N�o � poss�vel ativar';
  E_Transaction_Is_Active = 'A transa��o possui altera��es pendentes';
  E_Failed_To_Post_Datasets = 'Falha ao salvar todos os Datasets';
  E_Failed_To_Cancel_Datasets = 'Falha ao cancelar a grava��o de todos os Datasets';
  E_UpdateWrongTrn    = 'N�o � poss�vel atualizar, %s n�o pertence a %s';
  E_NO_BLANK_SQL      = 'N�o � permitida uma senten�a SQL em branco';
  E_AT_END_OF_FILE    = 'No final do arquivo';
  E_AT_END_OF_CURSOR  = 'No final do cursor';
  E_AT_END_OF_BUFFER  = 'No final do buffer';
  E_AT_END_OF_DATASET = 'No final do dataset';
  E_BAD_SQL_INF_LEN   = 'Tamanho inesperado de isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Dados inv�lidos foram retornados por isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'N�o � poss�vel alterar o nome do cursor enquanto este estiver ativo';
  E_REQUEST_LIVE_ACTIVE = 'N�o � poss�vel alterar o RequestLive enquanto ativo';
  E_REQUEST_LIVE_READONLY = 'N�o � poss�vel ajustar o RequestLive para verdadeiro em um dataset somente para leitura';
  E_CURSOR_UNI              = 'O IB_CURSOR � unidirecional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Tipo de coluna n�o suportado: %d';
  E_FIELDNO_NOT_FOUND         = 'Campo N�: %d n�o encontrado';
  E_FIELDNAME_NOT_FOUND        = 'Campo: %s n�o encontrado';
  E_INVALID_FOCUS_RELATION_NO   = 'Rela��o No: %d inv�lida';
  E_INVALID_FOCUS_RELATION_NAME = 'Rela��o: %s inv�lida';
  E_INVALID_QBE_IN              = 'Erro de sintaxe em: IN( valor [ , valor ... ] )';
  E_INVALID_QBE_BETWEEN         = 'Erro de sintaxe em: BETWEEN valor AND valor';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'N�o � poss�vel localizar a DLL de importa��o %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Valor da propriedade SQLKeyFields inv�lido';
  E_GET_CURSOR_ERROR      = 'N�o � poss�vel abrir o cursor sem os dados chaves';
  E_SCROLL_ERROR          = 'Registro chave perdido'#10#13'Falha ao abrir o cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Valor de BufferRowNum inv�lido antes de iniciar';
  E_BLANK_STATEMENT      = 'N�o � poss�vel preparar uma senten�a em branco';
  E_UNKNOWN_STATEMENT  = 'Tentativa de executar uma senten�a desconhecida';
  E_CIRCULAR_REFERENCE = 'N�o � permitida refer�ncia circular';
  E_CANT_CHG_WITH_CONN  = 'N�o � poss�vel alterar enquanto estiver conectado';
  E_LOGIN_FAILED        = 'Falha durante o Login';
  E_CANT_GET_CONN_CHR   = 'N�o foi poss�vel obter as caracter�sticas da conex�o';
  E_MAX_EVENTS_BLOCK   = 'N�mero m�ximo de eventos para um bloco excedido';
  E_PROCESSING_EVENTS = 'Processando eventos'#13#10'N�o � poss�vel finalizar o registro';
  E_CANT_STORE_BLOB = 'Blob j� foi ou n�o pode ser salvo';
  E_CANT_LOAD_BLOB   = 'Blob j� foi ou n�o pode ser carregado';
  E_CANNOT_CANCEL_ROW = 'N�o � poss�vel cancelar o registro atual';
  E_CANNOT_POST_ROW = 'N�o � possivel salvar o registro atual';
  E_DatasetClosed = 'O Dataset est� inativo';
  E_DatasetOpen      = 'O Dataset j� est� aberto';
  E_DatasetCannotScroll = 'O Dataset n�o pode ser movimentado';
  E_DatasetReadOnly   = 'O Dataset � somente para leitura';
  E_DatasetIsFetching = 'O Dataset est� sendo carregado';
  E_Invalid_KeyRelation = 'Valor da propriedade KeyRelation inv�lido';
  E_RowNum_Not_Implemented = 'RowNum ainda n�o foi implementado';
  E_RowDeleted = 'O registro est� sendo eliminado';
  E_END_OF_DATASET = 'No final do Dataset';
  E_BEGINNING_OF_DATASET = 'No in�cio do Dataset';
  E_Cannot_Pessimistic_Lock = 'N�o � poss�vel utilizar bloqueio pessimista com LockWait';
  E_Cannot_Edit_Row = 'N�o � poss�vel alterar o registro atual';
  E_Cannot_Insert_Row = 'N�o � poss�vel inserir um novo registro';
  E_Cannot_Delete_Row = 'N�o � poss�vel apagar o registro atual';
  E_Cannot_Search = 'Pesquisa n�o � permitida';
  E_Cannot_Navigate = 'N�o � poss�vel navegar';
  E_Record_Locked = 'O registro est� bloqueado por outro usu�rio';
  E_Record_OutOfSynch = 'O registro foi alterado por outro usu�rio';
  E_FLD_READONLY = '%s � somente para leitura';
  E_Required_Field = '%s � um campo obrigat�rio';
  E_NO_POSTRTN_CACHED_UPDT = 'N�o � poss�vel utilizar PostRetaining com Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Registros m�ltiplos em um carregamento de registro �nico';

  E_InvalidRowsAffectedBuf = 'O buffer RowsAffected � inv�lido';
  E_Invalid_RowNum_Past_Eof = 'RowNum al�m do final do arquivo inv�lido';
  E_Invalid_RowNum_Before_Bof = 'RowNum antes do in�cio do arquivo inv�lido';
  E_Invalid_Bookmark = 'Texto de Bookmark inv�lido';

  E_Assign_Column   = 'N�o � poss�vel atribuir a partir de %s';
  E_AssignTo_Column = 'N�o � poss�vel atribuir para %s';
  E_Value_Out_Of_Range = 'Valor fora dos limites';
  E_SmallintOverflow = 'Smallint overflow';
  E_IntegerOverflow = 'Integer overflow';
  E_Int64Overflow = 'Int64 overflow';

  E_Unsupported_Column = 'Tipo de coluna n�o suportado: %d';
  E_UndefinedMacro = 'Macro n�o definida';
  E_GeneratorFailed = 'N�o � poss�vel obter o valor do gerador';

  E_MustBe_Buffered_Dataset = 'IB_Query deve ser derivada de TIB_BDataset';

  E_NO_CHANGE_READONLY = 'N�o � poss�vel alterar ReadOnly uma vez iniciado';
  E_NO_CHANGE_ISOLATION = 'N�o � poss�vel alterar Isolation uma vez iniciado';
  E_NO_CHANGE_RECVERSION = 'N�o � poss�vel alterar RecVersion uma vez iniciado';
  E_NO_CHANGE_LOCKWAIT = 'N�o � poss�vel alterar LockWait uma vez iniciado';

  E_Invalid_Reference_To_Delete = 'Refer�ncia inv�lida a Delete';
  E_Invalid_Typecast = 'Convers�o de tipos inv�lida';
  E_Invalid_DataPump_Statement = 'Tipo de senten�a inv�lido para DataPump';
  E_FIELD_NOT_NULLABLE = 'Atribu�do valor NULL para um campo NOT NULL';
  E_DATABASE_BLANK = 'A propriedade DatabaseName n�o pode estar vazia';
  E_Unsupp_Col_Conversion = 'Convers�o de coluna n�o suportada';
  E_Unable_To_Locate_Record = 'N�o � poss�vel localizar o registro';
  E_Record_Not_Inserted = 'O registro n�o foi inserido';
  E_Invalid_KeyLinks = 'Entrada inv�lida na propriedade KeyLinks: %s';
  E_Unable_to_perform_search = 'N�o � poss�vel efetuar a pesquisa';
  E_Unassigned_Blob_Node = 'BlobNode n�o atribu�do';
  E_Unassigned_Transaction = 'Transa��o n�o atribu�da';
  E_Invalid_RowsAffected_Buffer = 'O Buffer para RowsAffected � inv�lido';
  E_Unable_Save_Graphic = 'N�o � poss�vel salvar para Graphic';
  E_Cannot_Activate_Transaction = 'N�o � poss�vel ativar a transa��o';
  E_IB_Client_Not_Installed = 'O cliente InterBase (GDS32.DLL) n�o est� instalado';
  E_Could_Not_Load_Memo = 'N�o foi poss�vel carregar o memo';
  E_Invalid_DPB_Over_255 = 'DPB inv�lido: Cont�m mais que 255 caracteres';
  E_Inv_Custom_DML = 'Refer�ncia personalizada a coluna DML inv�lida: %s';
  E_Record_Not_Located_For_Update = 'O registro n�o foi localizado para atualiza��o';
  E_Record_Not_Located_For_Delete = 'O registro n�o foi localizado para elimina��o';
  E_Init_Default_SQL_Failed = 'N�o foi poss�vel inicializar o valor padr�o em %s';
  E_Stringlist_Not_Sorted = 'A Stringlist deve estar ordenada para esta opera��o';
  E_Cannot_Change_Events = 'N�o � poss�vel alterar eventos enquanto � efetuado o processamento';
  E_Cannot_Unregister_Events = 'N�o � poss�vel finalizar o registro de eventos enquanto � efetuado o processamento';
  E_Invalid_Internal_Transaction = 'IB_Transaction interna inv�lida';
  E_InvalidStatementType = 'Tipo de senten�a inv�lido';
  E_Multiple_Records_Updated = 'Multiplos registros atualizados';
  E_Multiple_Records_Deleted = 'Multiplos registros eliminados';
  E_Multiple_Records_Inserted = 'Multiple records inserted';
  E_DUP_DB_NAME = 'N�o � permitida propriedade DatabaseName duplicada';
  E_INVALID_DB_NAME = 'O valor da propriedade DatabaseName � inv�lido';
  E_UnableToSearch_NoOrdering = 'Impossibilitado de realizar a pesquisa, nenhuma ordem foi definida';
  E_UnableToSearch_DatasetBusy = 'Impossibilitado de realizar a pesquisa, dataset est� ocupado procurando por dados';
  E_NoRecordsFound = 'Nenhum registro encontrado';
  E_Session_Undefined = 'A Session est� indefinida';
  E_NoCircularRef = 'N�o � permitida refer�ncia circular';
  E_InvalidClassType = 'Tipo de classe inv�lido';
  E_Invalid_RowNum = 'RowNum inv�lido';
  E_Invalid_Syntax = 'Sintaxe inv�lida: par�ntese sobrando ou faltando';
  E_Array_Is_Null = 'O Array � nulo';

  E_Cannot_add_blank_account = 'N�o � poss�vel adicionar uma conta em branco';
  E_Cannot_add_SYSDBA_account = 'N�o � poss�vel adicionar uma conta SYSDBA';
  E_Cannot_delete_blank_account = 'N�o � poss�vel apagar uma conta em branco';
  E_Cannot_delete_SYSDBA_account = 'N�o � poss�vel apagar a conta SYSDBA';
  E_Cannot_modify_blank_account = 'N�o � poss�vel alterar uma conta em branco';

  E_PLAN_ERROR = 'PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Sintaxe para CREATE, CONNECT ou DROP DATABASE inv�lida';
  E_Unsupported = 'N�o suportado';
  E_NotImplemented = 'N�o implementado neste n�vel';
  E_Invalid_ColData = 'Inv�lido ColData';

  E_Cant_Unprepare_executing_process = 'N�o � poss�vel cancelar a prepara��o um processo que est� em execu��o';
  E_FileName_Required = 'O preenchimento de FileName � obrigat�rio';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Gerenciamento das Contas dos Usu�rios';
  L_USERS_ADD = 'Adicionar';
  L_USERS_DELETE = 'Excluir';
  L_USERS_MODIFIY = 'Alterar';
  L_USERS_ACCOUNT = 'ACCOUNT';
  L_USERS_PASSWORD = 'Senha';
  L_USERS_GROUP = 'Grupo';
  L_USERS_FIRSTNAME = 'Primeiro Nome';
  L_USERS_MIDDLENAME = 'Nome do Meio';
  L_USERS_LASTNAME = '�ltimo Nome';

  //IBF_Export
  L_EXPORT_FRM = 'Exportar';
  L_EXPORT_ASCII = ' Formato de arquivo ';
  L_EXPORT_FIXED = 'TXT Registro com tamanho fixo';
  L_EXPORT_DELIMITED = 'CSV Delimitado';
  L_EXPORT_DBF  = 'DBF  (Necessita de algum teste)';
  L_EXPORT_ASCIIOPT  = ' Op��es do formato ASCII';
  L_EXPORT_DELIMITER  = 'Delimitador';
  L_EXPORT_SEPARATOR  = 'Separador';
  L_EXPORT_DATEFORMAT  = 'Formato de Data';
  L_EXPORT_INCLUDEHEADERS  = 'Incluir Cabe�alhos';
  L_EXPORT_INCLUDECRLF  = 'Incluir CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Exportar';
  L_EXPORT_SDEXPORTFILTERCSV = 'Arquivos textos separado por v�rgula( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Arquivos textos ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'Arquivos DBF  ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Tem certeza que deseja abortar?';
  M_Fetching_Query_Results = 'Resultado do carregamento';
  M_Row_Num = 'Linha# %d';
  M_Abort_Fetching_Btn = 'Abortar';

  M_Login_Database = 'Banco';
  M_Login_User = 'Usu�rio';
  M_Login_Password = 'Senha';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancelar';
  M_Login_Help_Btn = 'Aj&uda';
  M_Login_Dialog_Caption = 'Login';

  M_Loading_Caption = 'Carregando...';

  M_SB_REC_CNT = 'Total de registros: %d';
  M_Save_Changes = 'Salva as altera��es?';
  M_Abort_Changes = 'Altera��es ser�o perdidas. Continuar?';

  M_CancelTransactionPrompt = 'Tem certeza que deseja cancelar todas as altera��es?';

  M_SCRIPT_ABORT_EXECUTE = 'Aborta a execu��o deste script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Continua executando este script?';
  M_SCRIPT_IS_EXECUTING = 'O Script j� est� sendo executado';
  M_SCRIPT_FAILED = 'O Script n�o foi conclu�do';
  M_SCRIPT_WAS_ABORTED = 'A execu��o do Script foi abortada';
  M_SCRIPT_COMPLETED = 'O Script foi completado com sucesso';
  M_SCRIPT_CMPL_EXCEPT = 'O Script foi completadom com problemas';
  M_SCRIPT_MODIFIED = 'Modificado';
  M_SCRIPT_SAVE_CHANGES = 'Salva altera��es?';

{ Button captions }

  C_BTN_TODAY = 'Hoje';
  C_BTN_CLEAR = 'Limpar';

  C_SG_Parameter = 'Par�metro';
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
  M_SQL_SessionBusy = 'Sess�o ocupada atualmente';
  M_SQL_CompleteTransaction = 'Complete sua transa��o';
  M_SQL_CannotDeleteDefaultGroup = 'Grupo padr�o n�o pode ser excluido';
  M_SQL_ReservedName = 'Este nome � reservado: ';
  M_SQL_BackSlashNotAllowed = 'Slash em branco n�o � permitido';
  M_SQL_BlankNameNotAllowed = 'Nome em branco n�o � permitido';
  M_SQL_RowsFetched = 'Linhas Lidas: ';
  M_SQL_ConfirmDBCreation = 'Deseja realmente criar este banco de dados?';
  M_SQL_ConfirmNoOtherDBSameName = 'Verifique que n�o existe nenhum banco com o mesmo nome.';
  M_SQL_ConfirmDBDrop = 'Tem certeza que deseja apagar este banco de dados?';
  M_SQL_ReConfirmDBDrop = 'Este banco de dados ser� permanetemente apagado.'+#13#10+#13#10'Posso continuar?';
  M_SQL_AskFormName = 'Nome da consulta:';
  M_SQL_AskGroupName = 'Nome do grupo:';
  M_SQL_AskLayoutName = 'Nome do layout:';
  M_SQL_ConfirmGroupDeletion = 'Deseja realmente apagar o grupo %s com todos seus sub-itens?';
  M_SQL_ConfirmLayoutDeletion = 'Confirma exclus�o do layout %s ?';
  M_SQL_RecursiveCopyNotAllowed = 'Copia recursiva n�o permitida';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'D� um click duplo no item ou pressione Enter com um item selecionado.';
  M_GCSQL_ParameterValue = 'Valor do param�tro';
  M_GCSQL_TypeAValueFor = 'Digite um valor para %s';
  M_GCSQL_ProcedureWithoutParams = 'Procedure n�o tem param�tros.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Processo de c�pia continua ativo.';
  M_DP_ARE_YOU_SURE = 'Tem certeza?';
  M_DP_SELECT_SOURCE_DB = 'Selecione banco de origem';
  M_DP_SELECT_DEST_DB = 'Selecione banco de destino';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Limpar';
  M_USERS_COMPLETED_OK = 'Opera��o completada com sucesso';
  M_USERS_NO_CONNECTION = 'Conex�o n�o definida.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Atribui itens de ordena��o?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Iniciar exporta��o';
  M_EXPORT_STILL_ACTIVE = 'Processo de exporta��o continua ativo.';
  
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
  C_wbWhoBtnHint        = 'Visualizar quem est� conectado ao banco';
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
  C_wbUsersBtnHint      = 'Gerenciar os usu�rios do banco';
  C_wbUsersBtnCaption   = 'Usu�rios';

  // Array grid
  C_AG_Row             = 'Linha';
  C_AG_Column          = 'Coluna';

  //IBF_Who
  C_WHO_FRM            = 'Quem est� conectado';
  C_WHO_BTNAPPLY       = 'Atualizar';

  C_NB_FIRST = 'Primeiro';
  C_NB_PRIOR = 'Anterior';
  C_NB_NEXT = 'Pr�ximo';
  C_NB_LAST = '�ltimo';

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
  H_UB_POSTSEARCH = 'Salvar o crit�rio de pesquisa';
  H_UB_CANCELSEARCH = 'Cancelar o crit�rio de pesquisa';
  H_UB_POSTEDIT = 'Salvar as altera��es';
  H_UB_CANCELEDIT = 'Cancelar as altera��es';
  H_UB_POSTINSERT = 'Salvar inser��o';
  H_UB_CANCELINSERT = 'Cancelar inser��o';
  H_UB_POSTDELETE = 'Confirmar exclus�o';
  H_UB_CANCELDELETE = 'Cancelar exclus�o';
  H_UB_POST = 'Salvar as altera��es';
  H_UB_CANCEL = 'Cancelar as altera��es';

  H_NB_FIRST = 'Primeiro Registro';
  H_NB_PRIOR = 'Registro Anterior';
  H_NB_NEXT = 'Pr�ximo Registro';
  H_NB_LAST = '�ltimo Registro';
  H_NB_JUMPBCK = 'Voltar';
  H_NB_JUMPFWD = 'Avan�ar';

  H_SB_ORDER = 'Ordenar Registros no Dataset';
  H_SB_LAST_CRITERIA = 'Recarrega o �ltimo crit�rio de pesquisa';
  H_SB_SEARCH = 'Pesquisar no Dataset';
  H_SB_SAVE_CRITERIA = 'Salvar o crit�rio';
  H_SB_CLEAR_CRITERIA = 'Limpar o crit�rio';
  H_SB_RECALL_CRITERIA = 'Recarregar o crit�rio';
  H_SB_SEARCHCOUNT = 'Contar os registros que est�o em conformidade com o crit�rio';
  H_SB_COUNT = 'Contar os registros no Dataset';
  H_SB_RESTRUCTURE = 'Customize the Fields Displayed';

  H_TB_StartTransaction = 'Iniciar Transa��o';
  H_TB_PostDatasets = 'Salvar os Datasets';
  H_TB_CancelDatasets = 'Cancelar os Datasets';
  H_TB_SavePoint = 'Efetua o Commit e ret�m a transa��o atual';
  H_TB_CommitRetain = 'Salva os Datasets, efetua o Commit e ret�m a transa��o atual';
  H_TB_Commit = 'Efetua o Commit e termina a transa��o atual';
  H_TB_Rollback = 'Efetua o Rollback e termina a transa��o atual';
  H_TB_RollbackRetain = 'Efetua o Rollback e ret�m a transa��o atual';
  H_TB_Close = 'Fecha a transa��o atual';

  H_ST_Prepare_Statement = 'Preparar C�digo';
  H_ST_Unprepare_Statement = 'Cancelar Prepara��o do C�digo';
  H_ST_Execute_Statement = 'Executar o C�digo';

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
  H_RD_actVisible = 'Tornar campos selecionados vis�veis';
  H_RD_actVisibleAll = 'Tornar todos os campo vis�veis';
  H_RD_actUp = 'Mover campos selecionados para cima';
  H_RD_actTop = 'Mover campos selecionados ao topo';
  H_RD_actDown = 'Mover campos selecionados para baixo';
  H_RD_actBottom = 'Mover campos selecionados ao final';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Exportar a partir de um comando SELECT';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'N�o foi informado o arquivo ASCII de origem';
  eNoDestTableEntry          = 'N�o foi informada a tabela de destino';
  eAsciiFileNotFound         = 'Arquivo ASCII %s n�o encontrado';
  eIniFileNotFound           = 'Arquivo Ini %s n�o encontrado';
  eNoAsciiFileAccess         = 'N�o foi poss�vel a abertura do arquivo ASCII  %s';
  eInvalidCharFound          = 'Caracter inv�lido  / erro de formato no arquivo ASCII';
  eOutOfMemory               = 'Falta de mem�ria';
  eFieldDescriptionError     = 'Erro na descri��o do campo';
  eWrongAsciiFieldCount      = 'Contagem errada dos campos no arquivo ASCII';
  eWrongDecimalCount         = 'N�mero de decimais errada na lista de campos (%s)';
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
