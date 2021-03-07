
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
{  José Martí <josemarti@espurna.com>                                          }
{  27-Mar-2002                                                                 }
{     He alterado la traducción de Juan M. Gandia <jmgandia@poboxes.com>       }
{     eliminando, en la medida de lo posible, el uso de los infinitivos a la   }
{     hora de describir acciones. También he corregido algunas pequeñas erratas}
{     (seguro que yo he añadido otras), y he actualizado la traducción a la    }
{     versión IBO 4.2Gc.                                                       }
{     ===> NOTA <===                                                           }
{     En la traducción he priorizado la claridad de los mensajes sobre la      }
{     corrección, ya que serán los usuarios finales los lectores de los mismos,}
{     también he intentado ser lo mas conciso posible. Si alguién desea cola-  }
{     borar en la traducción al castellano de estas librerias que me escriba un}
{     correo, sería interesante crear un grupo mas o menos estable que se      }
{     dedique a mantener dichas traducciones. Además, falta la documentación,  }
{     la ayuda, los '¿Cómo ...?', etc, etc.                                    }
{                                                                              }
{   Juan M. Gandía <jmgandia@poboxes.com>                                      }
{   22-Nov-2001                                                                }
{     Traducción actualizada a versión IBO 4.2 Fn.                             }
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
  IB_VERSION_BUILD = 'G';
  IB_VERSION_SUB_RELEASE = 'c';
  
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

  IB_REG_MESSAGE = 'Gracias por evaluar IB Objects.'#13#10#13#10'Por favor, visite http://www.ibobjects.com y regístrese hoy.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Se ha establecido la conexión';
  E_NOT_CONNECTED     = 'No se ha establecido la conexión';
  E_Invalid_conn_path = 'La ruta de conexión es incorrecta';
  E_Cant_Repl_Int_Tr  = 'No se puede redefinir una transacción interna como implícita';
  E_NO_TRANS_STARTED  = 'No ha comenzado la transacción';
  E_TRANS_STARTED     = 'Ya ha comenzado la transacción';
  E_NO_CONNECTIONS    = 'La transacción no tiene conexiones';
  E_NOT_ENOUGH_CONN   = 'La transacción ha perdido una o mas conexiones';
  E_CONN_LOADING      = 'Aviso: La conexión está cargándose todavía';
  E_TRANS_CONN_SESS   = 'Todas las conexiones deben pertenecer a la misma sesión (IB_Session)';
  E_TransactionPaused = 'La transacción está pausada';
  E_ALLOCATED         = 'La consulta ya está asignada';
  E_NOT_ALLOCATED     = 'La consulta no está asignada';
  E_PREPARED          = 'La consulta ya está preparada';
  E_NOT_PREPARED      = 'La consulta no está preparada';
  E_FAILED_TO_PREPARE = 'Ha fallado la preparación de la consulta';
  E_OPENED            = 'La consulta ya está abierta';
  E_NOT_OPENED        = 'La consulta no está abierta';
  E_CANT_DELETE       = 'No se puede borrar el registro actual en el cursor';
  E_NO_CONNECTION     = 'La consulta debe tener asignada una conexión (IB_Connection)';
  E_CONNECT_FAILED    = 'No se puede abrir una conexión (IB_Connection)';
  E_NO_TRANSACTION    = 'Debe haber asignada una transacción (IB_Transaction)';
  E_NO_ACTIVE_TRANS   = 'No hay ninguna transacción activa para ejecutar';
  E_START_FAILED      = 'No se puede comenzar la transacción';
  E_SVRAUTOCMT_NOEXP  = 'No se permite una transacción explícita con ServerAutoCommit';
  E_Cannot_Activate     = 'Estado de la transacción incorrecto. No puede activarse';
  E_Transaction_Is_Active = 'La transacción tiene cambios pendientes';
  E_Failed_To_Post_Datasets = 'Fallo al enviar todos los datasets';
  E_Failed_To_Cancel_Datasets = 'Fallo al cancelar todos los datasets';
  E_UpdateWrongTrn    = 'No se puede actualizar, %s no es propiedad de %s';
  E_NO_BLANK_SQL      = 'No se permite una consulta en blanco';
  E_AT_END_OF_FILE    = 'Final del archivo';
  E_AT_END_OF_CURSOR  = 'Final del cursor';
  E_AT_END_OF_BUFFER  = 'Final del buffer';
  E_AT_END_OF_DATASET = 'Final del dataset';
  E_BAD_SQL_INF_LEN   = 'Isc_dsql_sql_info no ha devuelto la longitud o esta es incorrecta';
  E_BAD_SQL_INF_DATA  = 'Los datos devueltos por isc_dsql_sql_info son incorrectos ';
  E_CURSOR_NAME_LOCK  = 'No se puede cambiar el nombre del cursor mientras esté activo';
  E_REQUEST_LIVE_ACTIVE = 'No se puede cambiar RequestLive mientras esté activa';
  E_REQUEST_LIVE_READONLY = 'No se puede activar una RequestLive sobre un dataset solo de lectura';
  E_CURSOR_UNI              = 'El cursor (IB_CURSOR) es unidireccional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'El tipo de campo: %d es incorrecto';
  E_FIELDNO_NOT_FOUND         = 'No se ha encontrado el campo con número: %d';
  E_FIELDNAME_NOT_FOUND        = 'No se ha encontrado el campo con nombre: %s';
  E_INVALID_FOCUS_RELATION_NO   = 'La relación seleccionada con número: %d es incorrecta';
  E_INVALID_FOCUS_RELATION_NAME = 'La relación seleccionada con nombre: %s es incorrecta';
  E_INVALID_QBE_IN              = 'Error de sintaxis: IN( valor [ , valor ... ] )';
  E_INVALID_QBE_BETWEEN         = 'Error de sintaxis: BETWEEN valor AND valor';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'No es posible encontrar la DLL %s';
  E_INVALID_SQL_KEY_FIELDS  = 'La propiedad SQLKeyFields es incorrecta';
  E_GET_CURSOR_ERROR       = 'No se puede abrir un cursor sin datos en la clave';
  E_SCROLL_ERROR           = 'La clave del registro se ha perdido'#13#10'La apertura del cursor ha fallado';
  E_INVALID_BUFFER_ROW_NUM = 'El BufferRowNum es incorrecto antes del principio';
  E_BLANK_STATEMENT      = 'No se puede preparar una consulta en blanco';
  E_UNKNOWN_STATEMENT   = 'Se ha intentado ejecutar una consulta desconocida';
  E_CIRCULAR_REFERENCE = 'No se permite una referencia circular';
  E_CANT_CHG_WITH_CONN = 'No se puede cambiar estando conectado';
  E_LOGIN_FAILED      = 'Ha fallado el Login';
  E_CANT_GET_CONN_CHR = 'No se pueden obtener las características de la conexión';
  E_MAX_EVENTS_BLOCK  = 'Se ha sobrepasado el número máximo de eventos para un bloque';
  E_PROCESSING_EVENTS = 'Procesando los eventos'#13#10'No se puede quitar del registro de eventos';
  E_CANT_STORE_BLOB  = 'El blob ha sido o no se ha podido grabar';
  E_CANT_LOAD_BLOB   = 'El blob ha sido o no se ha podido leer';
  E_CANNOT_CANCEL_ROW = 'No se puede cancelar el registro actual';
  E_CANNOT_POST_ROW  = 'No se puede grabar el registro actual';
  E_DatasetClosed     = 'El dataset está inactivo';
  E_DatasetOpen        = 'El dataset ya está abierto';
  E_DatasetCannotScroll = 'No se puede desplazar el dataset';
  E_DatasetReadOnly     = 'El dataset solo es de lectura';
  E_DatasetIsFetching    = 'El dataset está recuperandose en este momento';
  E_Invalid_KeyRelation   = 'El valor de KeyRelation es incorrecto';
  E_RowNum_Not_Implemented = 'RowNum aún no está implementado';
  E_RowDeleted            = 'Se está eliminando el registro';
  E_END_OF_DATASET        = 'Fin del Dataset';
  E_BEGINNING_OF_DATASET   = 'Principio del Dataset';
  E_Cannot_Pessimistic_Lock = 'No se pueden usar bloqueos pesimistas con LockWait activado';
  E_Cannot_Edit_Row      = 'No se puede editar el registro actual';
  E_Cannot_Insert_Row  = 'No se puede agregar un registro nuevo';
  E_Cannot_Delete_Row = 'No se puede borrar el registro actual';
  E_Cannot_Search    = 'No se permiten busquedas';
  E_Cannot_Navigate = 'No se puede examinar';
  E_Record_Locked    = 'El registro está bloqueado por otro usuario';
  E_Record_OutOfSynch = 'El registro fue modificado por otro usuario';
  E_FLD_READONLY       = '%s solo es de lectura';
  E_Required_Field       = '%s es un campo obligatorio';
  E_NO_POSTRTN_CACHED_UPDT = 'No se puede usar PostRetaining con actualizaciones diferidas (cached)';
  E_Multiple_Rows_In_Singleton = 'Se han obtenido multiples registros en una recuperación semifallida';

  E_InvalidRowsAffectedBuf = 'El buffer para RowsAffected es incorrecto';
  E_Invalid_RowNum_Past_Eof = 'Número de registro incorrecto, es posterior al EOF';
  E_Invalid_RowNum_Before_Bof = 'Número de registro incorrecto, es anterior al BOF';
  E_Invalid_Bookmark = 'El marcador es incorrecto';

  E_Assign_Column  = 'No se puede asignar desde %s';
  E_AssignTo_Column = 'No se puede asignar a %s';
  E_Value_Out_Of_Range = 'Valor fuera de rango';
  E_SmallintOverflow = 'Desbordamiento de Smallint';
  E_IntegerOverflow = 'Desbordamiento de Integer';
  E_Int64Overflow = 'Desbordamiento de Int64';

  E_Unsupported_Column = 'Tipo de campo incorrecto: %d';
  E_UndefinedMacro = 'La macro no está definida';
  E_GeneratorFailed = 'No es posible obtener el valor del generador';

  E_MustBe_Buffered_Dataset = 'Debe ser descendiente de TIB_BDataset (IB_Query)';

  E_NO_CHANGE_READONLY = 'No se puede cambiar la propiedad ReadOnly una vez iniciado el proceso';
  E_NO_CHANGE_ISOLATION = 'No se puede cambiar la propiedad Isolation una vez iniciado el proceso';
  E_NO_CHANGE_RECVERSION = 'No se puede cambiar la propiedad RecVersion una vez iniciado el proceso';
  E_NO_CHANGE_LOCKWAIT = 'No se puede cambiar la propiedad LockWait una vez iniciado el proceso';

  E_Invalid_Reference_To_Delete = 'Referencia incorrecta para borrar';
  E_Invalid_Typecast = 'Moldeado de tipo incorrecto';
  E_Invalid_DataPump_Statement = 'Tipo de consulta incorrecto para una carga de datos';
  E_FIELD_NOT_NULLABLE = 'Se ha intentado dar un valor nulo a un campo con restricción a valores no nulos';
  E_DATABASE_BLANK = 'No puede omitirse el nombre de la base de datos';
  E_Unsupp_Col_Conversion = 'Conversión de campo incorrecta';
  E_Unable_To_Locate_Record = 'Es imposible encontrar el registro';
  E_Record_Not_Inserted = 'No se agregó el registro';
  E_Invalid_KeyLinks = 'Entrada incorrecta en KeyLinks: %s';
  E_Unable_to_perform_search = 'Es imposible efectuar la búsqueda';
  E_Unassigned_Blob_Node = 'BlobNode desasignado';
  E_Unassigned_Transaction = 'Transacción desasignada';
  E_Invalid_RowsAffected_Buffer = 'El buffer de RowsAffected es incorrecto';
  E_Unable_Save_Graphic = 'Es imposible grabar el objeto gráfico';
  E_Cannot_Activate_Transaction = 'No se puede activar la transacción';
  E_IB_Client_Not_Installed = 'El cliente de InterBase (GDS32.DLL) no está instalado';
  E_Could_Not_Load_Memo = 'No se puede cargar el campo de tipo memo';
  E_Invalid_DPB_Over_255 = 'El DPB es incorrecto: Contiene mas de 255 carácteres';
  E_Inv_Custom_DML = 'La referencia: %s de un campo DML personalizado es incorrecta';
  E_Record_Not_Located_For_Update = 'No se encontró el registro para actualizar';
  E_Record_Not_Located_For_Delete = 'No se encontro el registro para borrar';
  E_Init_Default_SQL_Failed = 'Es imposible incializar el %s por defecto';
  E_Stringlist_Not_Sorted = 'La lista de cadenas debe estar ordenada para esta operación';
  E_Cannot_Change_Events = 'No se pueden cambiar los eventos mientras se procesan';
  E_Cannot_Unregister_Events = 'No se pueden eliminar eventos del registro mientras se procesan';
  E_Invalid_Internal_Transaction = 'Transacción interna (IB_Transaction) incorrecta';
  E_InvalidStatementType = 'Tipo de consulta incorrecta';
  E_Multiple_Records_Updated = 'Multiples registros actualizados';
  E_Multiple_Records_Deleted = 'Multiples registros borrados';
  E_Multiple_Records_Inserted = 'Multiples registros agregados';
  E_DUP_DB_NAME = 'No se permiten nombres de bases de datos duplicados';
  E_INVALID_DB_NAME = 'Nombre de la base de datos incorrecto';
  E_UnableToSearch_NoOrdering = 'Es imposible efectuar la búsqueda, no se ha definido un orden';
  E_UnableToSearch_DatasetBusy = 'Es imposible efectuar la búsqueda, el dataset está ocupado recuperando datos';
  E_NoRecordsFound = 'No se han encontrado registros';
  E_Session_Undefined = 'No se ha definido una sesión';
  E_NoCircularRef = 'No se permiten referencias circulares';
  E_InvalidClassType = 'Tipo de clase incorrecta';
  E_Invalid_RowNum = 'Número de registro incorrecto';
  E_Invalid_Syntax = 'Error de sintaxis: demasiados paréntesis o falta alguno';
  E_Array_Is_Null = 'La matriz es nula';

  E_Cannot_add_blank_account = 'No se puede agregar una cuenta en blanco';
  E_Cannot_add_SYSDBA_account = 'No se puede agregar una cuenta SYSDBA';
  E_Cannot_delete_blank_account = 'No se puede borrar una cuenta en blanco';
  E_Cannot_delete_SYSDBA_account = 'No se puede borrar una cuenta SYSDBA';
  E_Cannot_modify_blank_account = 'No se puede modificar una cuenta en blanco';

  E_PLAN_ERROR = '¡ERROR EN EL PLAN!';
  E_PLAN_EXCEPTION = '¡EXCEPCIÓN EN EL PLAN!';

  E_INV_CREATE_CONNECT_DROP = 'La sintaxis de CREATE, CONNECT o DROP DATABASE es incorrecta';
  E_Unsupported = 'No se permite';
  E_NotImplemented = 'No se ha implementado a este nivel';
  E_Invalid_ColData = 'El valor binario de la columna (ColData) es incorrecto';

  E_Cant_Unprepare_executing_process = 'No se puede se puede deshacer la preparación de un proceso en ejecución';
  E_FileName_Required = 'Es imprescindible el nombre del archivo';

{ Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Gestión de cuentas de usuario';
  L_USERS_ADD = 'Agrega';
  L_USERS_DELETE = 'Borra';
  L_USERS_MODIFIY = 'Modifica';
  L_USERS_ACCOUNT = 'CUENTA';
  L_USERS_PASSWORD = 'Contraseña';
  L_USERS_GROUP = 'Grupo';
  L_USERS_FIRSTNAME = 'Nombre de pila';
  L_USERS_MIDDLENAME = 'Segundo nombre';
  L_USERS_LASTNAME = 'Apellidos';

  //IBF_Export
  L_EXPORT_FRM = 'Exporta';
  L_EXPORT_ASCII = 'Formato del archivo ';
  L_EXPORT_FIXED = 'Registro TXT de ancho fijo';
  L_EXPORT_DELIMITED = 'CSV Delimitado';
  L_EXPORT_DBF  = 'DBF  (Todavía necesita de algunas pruebas)';
  L_EXPORT_ASCIIOPT  = ' Opciones ASCII ';
  L_EXPORT_DELIMITER  = 'Delimitador';
  L_EXPORT_SEPARATOR  = 'Separador';
  L_EXPORT_DATEFORMAT  = 'Formato de la fecha';
  L_EXPORT_INCLUDEHEADERS  = 'Incluye cabeceras';
  L_EXPORT_INCLUDECRLF  = 'Incluye CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Exporta';
  L_EXPORT_SDEXPORTFILTERCSV = 'Archivos de texto separados por coma ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Ficheros de texto ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'Archivos DBF ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = '¿Seguro que desea cancelar?';
  M_Fetching_Query_Results = 'Recuperando los resultados de la consulta';
  M_Row_Num = 'Registro# %d';
  M_Abort_Fetching_Btn = 'Cancela';

  M_Login_Database = 'Base de datos';
  M_Login_User = 'Usuario';
  M_Login_Password = 'Contraseña';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Cancela';
  M_Login_Help_Btn = '&Ayuda';
  M_Login_Dialog_Caption = 'Diálogo de login';

  M_Loading_Caption = 'Cargando...';

  M_SB_REC_CNT = 'Registros contados: %d';
  M_Save_Changes = '¿Desea grabar las modificaciones?';
  M_Abort_Changes = 'Se perderán las modificaciones. ¿Desea continuar?';

  M_CancelTransactionPrompt = '¿Está seguro que desea perder todas las modificaciones?';

  M_SCRIPT_ABORT_EXECUTE = '¿Desea cancelar la ejecución de este script?';
  M_SCRIPT_CONTINUE_EXECUTING = '¿Desea continuar la ejecución de este script?';
  M_SCRIPT_IS_EXECUTING = 'El script está en ejecución';
  M_SCRIPT_FAILED = 'No se ha podido finalizar el script';
  M_SCRIPT_WAS_ABORTED = 'Se ha cancelado la ejecución del script';
  M_SCRIPT_COMPLETED = 'El script ha finalizado sin excepciones';
  M_SCRIPT_CMPL_EXCEPT = 'El script ha finalizado con excepciones';
  M_SCRIPT_MODIFIED = 'Modificado';
  M_SCRIPT_SAVE_CHANGES = '¿Desea grabar las modificaciones?';

{ Button captions }

  C_BTN_TODAY = 'Hoy';
  C_BTN_CLEAR = 'Limpia';

  C_SG_Parameter = 'Parámetro';
  C_SG_Field = 'Campo';
  C_SG_Name = 'Nombre';
  C_SG_Type = 'Tipo';
  C_SG_Info = 'Info';
  C_SG_Value = 'Valor';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Cancela';
  C_BF_CANCEL_ACCEL = '&Cancela';
  C_BF_APPLY = 'Aplica';
  C_BF_HELP = 'Ayuda';
  C_BF_EXECUTE = 'Ejecuta';
  C_BF_CLOSE = 'Cierra';
  C_BF_CLOSE_ACCEL = '&Cierra';
  C_BF_FINISH = 'Finaliza';
  C_BF_FINISH_ACCEL = '&Finaliza';

  C_FRM_Ordering = 'Ordenando';
  C_FRM_RESTRUCTURE = 'Personaliza los campos mostrados';

  C_CB_WordWrap = 'Ajusta el texto';

  // IBF_SQL
  M_SQL_RowsAffected = 'Registros afectados: ';
  M_SQL_RowsCounted = 'Registros contados: ';
  M_SQL_SessionBusy = 'La sesión está ocupada';
  M_SQL_CompleteTransaction = 'Por favor, finalice su transacción';
  M_SQL_CannotDeleteDefaultGroup = 'No se puede borrar el grupo por defecto';
  M_SQL_ReservedName = 'Este nombre está reservado: ';
  M_SQL_BackSlashNotAllowed = 'No se permite una barra inversa';
  M_SQL_BlankNameNotAllowed = 'No se permite un nombre en blanco';
  M_SQL_RowsFetched = 'Registros leídos: ';
  M_SQL_ConfirmDBCreation = '¿Está seguro que desea crear esta base de datos?';
  M_SQL_ConfirmNoOtherDBSameName = 'Por favor, asegúrese que no existe otra base de datos con el mismo nombre.';
  M_SQL_ConfirmDBDrop = '¿Está seguro que desea eliminar esta base de datos?';
  M_SQL_ReConfirmDBDrop = 'Esta base de datos será eliminada completamente.'+#13#10+#13#10'¿Desea continuar de todos modos?';
  M_SQL_AskFormName = 'Introduzca el nombre del formulario de consulta:';
  M_SQL_AskGroupName = 'Introduzca el nombre del grupo:';
  M_SQL_AskLayoutName = 'Introduzca el nombre del diseño:';
  M_SQL_ConfirmGroupDeletion = '¿Está seguro que desea eliminar el grupo %s, incluyendo sus elementos descendientes?';
  M_SQL_ConfirmLayoutDeletion = '¿Está seguro que desea eliminar el diseño %s?';
  M_SQL_RecursiveCopyNotAllowed = 'No se permiten copias recursivas';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Haga doble clic sobre un elemento o presione intro con un elemento seleccionado.';
  M_GCSQL_ParameterValue = 'Valor del parámetro';
  M_GCSQL_TypeAValueFor = 'Dé un valor para %s';
  M_GCSQL_ProcedureWithoutParams = 'Este procedimiento no tiene parámetros de entrada.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'El proceso de carga de datos aún está activo.';
  M_DP_ARE_YOU_SURE = '¿Está seguro?';
  M_DP_SELECT_SOURCE_DB = 'Seleccione una base de datos de origen';
  M_DP_SELECT_DEST_DB = 'Selecccione una base de datos de destino';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Limpia';
  M_USERS_COMPLETED_OK = 'La operación ha finalizado satisfactoriamente';
  M_USERS_NO_CONNECTION = 'No se ha definido ninguna conexión (IB_Connection).';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = '¿Asigna elementos de ordenación?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Comienza la exportación';
  M_EXPORT_STILL_ACTIVE = 'El proceso de exportación permanece activo.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Hojea la base de datos';
  C_wbBrowseBtnCaption  = 'Hojea';
  C_wbDSQLBtnHint       = 'Ejecuta la consulta en la base de datos';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Monitor de eventos de la base de datos';
  C_wbEventsBtnCaption  = 'Eventos';
  C_wbExportBtnHint     = 'Exporta el Dataset desde la base de datos';
  C_wbExportBtnCaption  = 'Exporta';
  C_wbDumpBtnHint       = 'Vuelca la base de datos';
  C_wbDumpBtnCaption    = 'Vuelca';
  C_wbPumpBtnHint       = 'Carga datos desde otra base de datos';
  C_wbPumpBtnCaption    = 'Carga';
  C_wbWhoBtnHint        = 'Mira quien está conectado a la base de datos';
  C_wbWhoBtnCaption     = 'Quién';
  C_wbScriptBtnHint     = 'Ejecuta un script';
  C_wbScriptBtnCaption  = 'Script';
  C_wbExtractBtnHint    = 'Extrae metadatos de DDL';
  C_wbExtractBtnCaption = 'Extrae metadatos';
  C_wbMonitorBtnHint    = 'Rastrea el SQL y las llamadas a la API';
  C_wbMonitorBtnCaption = 'Monitor';
  C_wbProfilerBtnHint   = 'Afina el funcionamiento de la base de datos';
  C_wbProfilerBtnCaption= 'Afinador';
  C_wbStatusBtnHint     = 'Muestra el estado de los componentes de IBO';
  C_wbStatusBtnCaption  = 'Estado';
  C_wbUsersBtnHint      = 'Administra los usuarios de un servidor de bases de datos';
  C_wbUsersBtnCaption   = 'Usuarios';

  // Array grid
  C_AG_Row             = 'Fila';
  C_AG_Column          = 'Columna';

  //IBF_Who
  C_WHO_FRM            = 'Quién está conectado';
  C_WHO_BTNAPPLY       = 'Actualiza';

  C_NB_FIRST = 'Primero';
  C_NB_PRIOR = 'Anterior';
  C_NB_NEXT = 'Siguiente';
  C_NB_LAST = 'Último';

  C_ST_Open = 'Abre';
  C_ST_Close = 'Cierra';
  C_ST_Prepare = 'Prepara';
  C_ST_Unprepare = 'Deshaz preparación';
  C_ST_ReadOnly = 'Solo lectura';
  C_ST_New = 'Nuevo';
  C_ST_Post = 'Envía';
  C_ST_Cancel = 'Cancela';
  C_ST_Delete = 'Borra';
  C_ST_Edit = 'Edita';
  C_ST_RefreshKeys = 'Actualiza claves';
  C_ST_RefreshRows = 'Actualiza registros';
  C_ST_Refresh = 'Actualiza';

{ Hints }

  H_UB_EDIT = 'Edita registro';
  H_UB_INSERT = 'Agrega registro';
  H_UB_DELETE = 'Borra registro';
  H_UB_REFRESH = 'Actualiza todos los registros';
  H_UB_REFRESHKEYS = 'Actualiza las claves de los registros';
  H_UB_REFRESHROWS = 'Actualiza los registros mostrados';
  H_UB_REFRESHFILTROWS = 'Actualiza los registros filtrados';
  H_UB_POSTSEARCH = 'Envía el criterio de búsqueda';
  H_UB_CANCELSEARCH = 'Cancela el criterio de búsqueda';
  H_UB_POSTEDIT = 'Envía lo editado';
  H_UB_CANCELEDIT = 'Cancela lo editado';
  H_UB_POSTINSERT = 'Envía lo agregado';
  H_UB_CANCELINSERT = 'Cancela lo agregado';
  H_UB_POSTDELETE = 'Envía la orden de borrado';
  H_UB_CANCELDELETE = 'Cancela la orden de borrado';
  H_UB_POST = 'Envía las modificaciones';
  H_UB_CANCEL = 'Cancela las modificaciones';

  H_NB_FIRST = 'Primer registro';
  H_NB_PRIOR = 'Registro anterior';
  H_NB_NEXT = 'Registro siguiente';
  H_NB_LAST = 'Último registro';
  H_NB_JUMPBCK = 'Atrás';
  H_NB_JUMPFWD = 'Adelante';

  H_SB_ORDER = 'Ordena los registros en el dataset';
  H_SB_LAST_CRITERIA = 'Repite el último criterio de búsqueda';
  H_SB_SEARCH = 'Busca en el dataset';
  H_SB_SAVE_CRITERIA = 'Graba el criterio';
  H_SB_CLEAR_CRITERIA = 'Borra el criterio';
  H_SB_RECALL_CRITERIA = 'Repite el criterio';
  H_SB_SEARCHCOUNT = 'Cuenta los registros del dataset que coincidan con el criterio';
  H_SB_COUNT = 'Cuenta los registros del dataset';
  H_SB_RESTRUCTURE = 'Personaliza los campos mostrados';

  H_TB_StartTransaction = 'Comienza la transacción';
  H_TB_PostDatasets = 'Envía los datasets';
  H_TB_CancelDatasets = 'Cancela los datasets';
  H_TB_SavePoint = 'Acomete y conserva la transacción actual';
  H_TB_CommitRetain = 'Envía los datasets y acomete y conserva la transacción actual';
  H_TB_Commit = 'Acomete y finaliza la transacción actual';
  H_TB_Rollback = 'Deshaz y finaliza la transacción actual';
  H_TB_RollbackRetain = 'Deshaz y conserva la transacción actual';
  H_TB_Close = 'Cierra la transacción actual';

  H_ST_Prepare_Statement = 'Prepara la consulta';
  H_ST_Unprepare_Statement = 'Deshaz la preparación de la consulta';
  H_ST_Execute_Statement = 'Ejecuta la consulta';

  H_DS_Open_Dataset = 'Abre el dataset';
  H_DS_Close_Dataset = 'Cierra el dataset';
  H_DS_Prepare_Dataset = 'Prepara el dataset';
  H_DS_Unprepare_Dataset = 'Deshaz la preparación del dataset';
  H_DS_ReadOnly_Dataset = 'El dataset solo es de lectura';

  H_CB_Create_Database = 'Crea una base de datos';
  H_CB_Connect_Database = 'Conecta a una base de datos';
  H_CB_Disconnect_Database = 'Desconecta de la base de datos';
  H_CB_Drop_Database = 'Elimina la base de datos';

  H_RD_actHide = 'Oculta los campos seleccionados';
  H_RD_actHideAll = 'Oculta todos los campos';
  H_RD_actVisible = 'Haz visibles los campos seleccionados';
  H_RD_actVisibleAll = 'Haz visibles todos los campos';
  H_RD_actUp = 'Mueve una línea arriba los campos seleccionados';
  H_RD_actTop = 'Mueve al principio los campos seleccionados';
  H_RD_actDown = 'Mueve una línea abajo los campos seleccionados';
  H_RD_actBottom = 'Mueve al final los campos seleccionados';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Exporta desde la consulta SELECT';

  // Error Messages - IB_Import
  eNoAsciiFileEnty           = 'Entrada perdida para el archivo Ascii';
  eNoDestTableEntry          = 'Entrada perdida para la tabla de destino';
  eAsciiFileNotFound         = 'No se encuentra el archivo Ascii %s';
  eIniFileNotFound           = 'No se encuentra el archivo INI %s';
  eNoAsciiFileAccess         = 'No se puede abrir el archivo Ascii %s';
  eInvalidCharFound          = 'Carácter incorrecto o error de formato en el archivo Ascii';
  eOutOfMemory               = 'Memoria insuficiente';
  eFieldDescriptionError     = 'Error en la descripción del campo';
  eWrongAsciiFieldCount      = 'Cuenta de campos incorrecta en el archivo Ascii';
  eWrongDecimalCount         = 'Cuenta de decimales incorrecta en lista de campos (%s)';
  eWrongFieldWidth           = 'Ancho de campo incorrecto en el archivo Ascii';

  // Dialog Labels - IB_Import
  lblRecsReadedCaption       = 'Registros leídos en total';
  lblRecsCommentedCaption    = 'Registros comentados';
  lblRecsInsertedCaption     = 'Registros agregados';
  btnAbortImportCaption      = 'Cancela';

  // Metadata Extract Stuff
  // ------------------------

  // Entity Type Names
  STR_DDL_UnnamedItem = '<SIN NOMBRE>';
  STR_DDL_etDatabase = 'Base de datos';
  STR_DDL_etException = 'Excepción';
  STR_DDL_etBlobFilter = 'Filtro de Blob';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Generador';
  STR_DDL_etDomain = 'Dominio';
  STR_DDL_etTable = 'Tabla';
  STR_DDL_etView = 'Vista';
  STR_DDL_etProcedure = 'Procedimiento';
  STR_DDL_etRole = 'Privilegio';
  STR_DDL_etPrimaryKey = 'Clave primaria';
  STR_DDL_etUniqueKey = 'Clave única';
  STR_DDL_etForeignKey = 'Clave ajena';
  STR_DDL_etConstraint = 'Restricción';
  STR_DDL_etIndex = 'Índice';
  STR_DDL_etTrigger = 'Disparador';
  STR_DDL_etPermission = 'Permiso';
  STR_DDL_etUDFParam = 'Parámetro UDF';
  STR_DDL_etTableField = 'Campo de tabla';
  STR_DDL_etViewField = 'Campo de vista';
  STR_DDL_etProcParam = 'Parámetro de procedimiento';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Crea base de datos';
  STR_DDL_coSecondaryFiles = 'Define los ficheros secundarios';
  STR_DDL_coDefineShadows = 'Define Shadows';
  STR_DDL_coSetGeneratorVal = 'Establece el valor del generador';
  STR_DDL_coResetExceptionNo = 'Restablece el número de excepción';
  STR_DDL_coRawFieldDefs = 'Definiciones completas del campo';
  STR_DDL_coReportMinor = 'Informa del menor';
  STR_DDL_coAlwaysQuoted = 'Acotado siempre';
  STR_DDL_coAlwaysCharSet = 'Define siempre el conjunto de carácteres';
  STR_DDL_coIncludeDebug = 'Incluye comentarios de depuración';
  STR_DDL_coDescripAsComment = 'Descripciones como comentarios';

  // CodePass Names
  STR_DDL_cpFull = 'Completo';
  STR_DDL_cpInit = 'Inicial';
  STR_DDL_cpFinal = 'Final';

  // Dialog strings
  STR_DDL_DialogCaption = 'Extrae metadatos';
  STR_DDL_Configure = 'Configura';
  STR_DDL_Filters = 'Filtros';
  STR_DDL_Script = 'Script';
  STR_DDL_MetadataControls = 'Controles de metadatos';
  STR_DDL_CodeOptions = 'Opciones de código';
  STR_DDL_Entities = 'Entidades';
  STR_DDL_Terminator = 'Terminador';
  STR_DDL_ExecuteControls = 'Controles de ejecución';
  STR_DDL_CodePass = 'Paso de código';
  STR_DDL_ExtractToStrings = 'Extrae a cadenas';
  STR_DDL_Reset = 'Restablece';
  STR_DDL_ResetAll = 'Restablece todo';
  STR_DDL_ProgressControls = 'Controles de progreso';
  STR_DDL_Stop = 'Para';
  STR_DDL_IncludeSystem = 'Incluye los objetos del sistema';
  STR_DDL_NameMasks = 'Enmascara el nombre';
  STR_DDL_SaveToFile = 'Graba a un archivo';

implementation

end.
