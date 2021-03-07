
{									       }
{ IB_Constants								       }
{									       }

{***************************************************************}
{								}
{	   IB Objects Components and Resources Library		}
{								}
{	   Copyright (C) 1996-2001 Jason Wharton		}
{	   and Computer Programming Solutions, Mesa, AZ 	}
{								}
{  This source code unit is released under the terms of the	}
{  CPS Trustware License.					}
{  It may be distributed or deployed as source code or in	}
{  compiled form only in compliance with the terms and		}
{  conditions of the CPS Trustware License which may be 	)
{  examined at http://www.ibobjects.com/ibo_trustware.html	)
{								}
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS						       }
{                                                                              }
{  Cagatay Tengiz <cagatay.tengiz@tengiz.net>				       }
{  13-Mar-2002								       }
{    Modification of file to be compatible with version 4.2Ga                  }
{    Added new constant strings.                                               }
{                                                                              }
{  Burak OZLER <zeroptr@yahoo.com>					       }
{  01/12/2001								       }
{    Nothing Special I only make some tiny changes to make it compatible to    }
{    42Fk. And some bugs                                                       }
{                                                                              }
{  Cagatay Tengiz <cagatay.tengiz@tengiz.net>				       }
{  08/08/2001								       }
{    This is the translation IB_Constans to Turkish			       }
{    I've tried to use pure Turkish terms. But any comments or 	               }
{    modifications are all welcome.					       }
{                                                                              }
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
  IB_USER_NAME		= 'USER NAME';
  IB_PASSWORD		= 'PASSWORD';
  IB_LOCAL_PASSWORD	= 'LOCAL PASSWORD';
  IB_SERVER_NAME	= 'SERVER NAME';
  IB_SERVER		= 'SERVER';
  IB_PATH		= 'PATH';
  IB_LICENSE		= 'LICENSE';
  IB_SYSDBA		= 'SYSDBA';
  IB_ENCRYPT_KEY	= 'ENCRYPT KEY';
  IB_CHARACTER_SET	= 'CHARACTER SET';
  IB_MESSAGE_FILE	= 'MESSAGE FILE';
  IB_FORCED_WRITES	= 'FORCED WRITES';
  IB_BUFFERS		= 'BUFFERS';
  IB_PAGE_SIZE		= 'PAGE SIZE';
  IB_SWEEP_INTERVAL	= 'SWEEP INTERVAL';
  IB_RESERVE_PAGE_SPACE = 'RESERVE PAGE SPACE';
  IB_PROTOCOL		= 'PROTOCOL';
  IB_DB_KEY_SCOPE	= 'DB_KEY SCOPE';
  IB_SQL_DIALECT	= 'SQL DIALECT';
  IB_SQL_ROLE_NAME_	= 'SQL ROLE NAME'; // This setting is being deprecated.
  IB_ROLE_NAME		= 'ROLE NAME';
  IB_ROLE_		= 'ROLE'; // This setting is being deprecated.

// Connection parameter values.
  IB_PROTOCOL_LOCAL    = 'LOCAL';
  IB_PROTOCOL_NETBEUI  = 'NETBEUI';
  IB_PROTOCOL_TCP_IP   = 'TCP/IP';
  IB_PROTOCOL_NOVELL   = 'NOVELL';
  IB_DB_KEY_SCOPE_CONN = 'CONNECTION';
  IB_DB_KEY_SCOPE_TRAN = 'TRANSACTION';

// BDE Alias settings
  BDE_DRIVER_FLAGS		 = 'DRIVER FLAGS';
  BDE_TRACE_MODE		 = 'TRACE MODE';
  BDE_SERVER_NAME		 = IB_SERVER_NAME;
  BDE_USER_NAME 		 = IB_USER_NAME;
  BDE_PASSWORD			 = IB_PASSWORD;
  BDE_OPEN_MODE 		 = 'OPEN MODE';
  BDE_SCHEMA_CACHE_SIZE 	 = 'SCHEMA CACHE SIZE';
  BDE_LANGDRIVER		 = 'LANGDRIVER';
  BDE_SQLQRYMODE		 = 'SQLQRYMODE';
  BDE_SQLPASSTHRU_MODE		 = 'SQLPASSTHRU MODE';
  BDE_SCHEMA_CACHE_TIME 	 = 'SCHEMA CACHE TIME';
  BDE_MAX_ROWS			 = 'MAX ROWS';
  BDE_BATCH_COUNT		 = 'BATCH COUNT';
  BDE_ENABLE_SCHEMA_CACHE	 = 'ENABLE SCHEMA CACHE';
  BDE_SCHEMA_CACHE_DIR		 = 'SCHEMA CACHE DIR';
  BDE_ENABLE_BCD		 = 'ENABLE BCD';
  BDE_BLOBS_TO_CACHE		 = 'BLOBS TO CACHE';
  BDE_BLOB_SIZE 		 = 'BLOB SIZE';
  BDE_ROLE_NAME 		 = IB_ROLE_NAME;
  BDE_WAIT_ON_LOCKS		 = 'WAIT ON LOCKS';
  BDE_COMMIT_RETAIN		 = 'COMMIT RETAIN';

// BDE Alias settings
  BDE_SHARED_AUTOCOMMIT      = 'SHARED AUTOCOMMIT';	
  BDE_SHARED_NOAUTOCOMMIT    = 'SHARED NOAUTOCOMMIT';
  BDE_NOT_SHARED	     = 'NOT SHARED';


// These are various settings that can be made in the ColumnAttributes property.
  IB_BINARY	 = 'BINARY';	 // Flag a CHAR or VARCHAR column as binary.
  IB_BLANKISNULL = 'BLANKISNULL';// Used by TIB_Column class when assigning a
				 // blank string to a Fields member.
  IB_BOOLEAN	 = 'BOOLEAN';	 // Used to tell what values are used to make
				 // this a boolean column.
  IB_COMPUTED	 = 'COMPUTED';	 // It tells that the column is actually a
				 // COMPUTED BY derived column.
  IB_CURRENCY	 = 'CURRENCY';	 // Flag to indicate a column contains currency.
  IB_NOCASE	 = 'NOCASE';	 // Flag to set a case insensitive search field
  IB_NODATE	 = 'NODATE';
  IB_NOSOUNDEX	 = 'NOSOUNDEX';  // Disable soundex processing in a dataset
  IB_NOTIME	 = 'NOTIME';
  IB_NOTRAILING  = 'NOTRAILING'; // Flag to use STARTING on literal strings
  IB_NOTREQUIRED = 'NOTREQUIRED';
  IB_REQUIRED	 = 'REQUIRED';
  IB_SOUNDEX	 = 'SOUNDEX';	 // Flag to set a SoundEx search field
  IB_BCD	 = 'BCD';	 // Flag to force a colum to be TIBOBCDField
  IB_NOBCD	 = 'NOBCD';	 // Flag to force a colum to be TIBOFloatField
  IB_YESCASE	 = 'YESCASE';	 // Flag to override CN.DefaultNoCase
  IB_YESLIKE	 = 'YESLIKE';	 // Flag to use LIKE on literal strings
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

// Global Defaults  
  G_DefaultRowHeight  = 17;
  DTEncode_DateDelimit	   = '/';
  DTEncode_TimeDelimit	   = ':';
  DTEncode_DateTimeDelimit = ' ';
  DTEncode_DecodeFormat    = '%.4u/%.2u/%.2u %.2u:%.2u:%.2u.%.3u0';
  DTEncode_DateTimeFormat  = 'YYYY"/"MM"/"DD" "HH":"MM":"SS".0000"';
  DT_DateFormat 	   = 'MM"/"dd"/"yyyy';
  DT_TimeFormat 	   = 'hh":"nn":"ss';

{ These may be localized. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'IB Objects denediðiniz için teþekkürler.'#13#10#13#10'Lütfen http://www.ibobjects.com adresini bugün ziyaret edin ve kayýtlý olun';
  //IB_REG_MESSAGE = 'Thanks for evaluating IB Objects.'#13#10#13#10'Please go to http://www.ibobjects.com and register today.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED	      = 'Baðlantý kurulmuþ durumda'; // Connection has already been established';
  E_NOT_CONNECTED     = 'Baðlantý kurulmamýþ durumda'; // Connection has not been established';
  E_Invalid_conn_path = 'Geçersiz baðlantý yolu';
  E_Cant_Repl_Int_Tr  = 'Ýç aktarým varsayýlan ile yer deðiþtirilemez'; //Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Aktarým baþlamamýþ durumda'; //Transaction has not been started';
  E_TRANS_STARTED     = 'Aktarým zaten baþlamýþ durumda'; //Transaction has already been started';
  E_NO_CONNECTIONS    = 'Aktarýma ait baðlantý yok'; //Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Aktarým bir veya daha fazla baðlantýya ihtiyaç duyuyor'; //Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Uyarý: Baðlantý hala yükleniyor'; //Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'Bütün baðlantýlar ayný IB_Session oturumunda olmalý'; //Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Aktarým Duraklatýldý'; //Transaction is Paused';
  E_ALLOCATED	      = 'Komut zaten tahsis edilmiþ'; //Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Komut tahsis edilmemiþ'; //Statement has not been allocated';
  E_PREPARED	      = 'Komut zaten hazýrlanmýþ'; //Statement has already been prepared';
  E_NOT_PREPARED      = 'Komut hazýrlanmamýþ durumda'; //Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Komut hazýrlýðý baþarýsýz'; //Statement failed to prepare';
  E_OPENED	      = 'Komut zaten açýlmýþ durumda'; //Statement has already been opened';
  E_NOT_OPENED	      = 'Komut açýk deðil'; //Statement has not been opened';
  E_CANT_DELETE       = 'Ýmleçteki mevcut kayýt silinemez'; //Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Komuta IB_Connection atamasý gerekiyor'; //Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'IB_Connection açýlamýyor'; //Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Komuta IB_Transaction atamasý gerekiyor'; //Statement must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = 'Çalýþtýrmak için geçerli aktarým yok'; //No active transaction to execute with';
  E_START_FAILED      = 'Aktarým baþlatýlamýyor'; // Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'ServerAutoCommit (SunucuOtoÝþleme) durumunda Explicit(kesin) aktarým olamaz'; //Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate	= 'Geçersiz aktarým durumu. Aktifleþtirilemiyor'; //Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Aktarýmda sonlandýrýlmamýþ bekleyen deðiþiklikler var'; //Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'Tüm veri kümeleri kaydý baþarýsýz'; //Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'Tüm veri kümeleri iptali baþarýsýz'; //Failed to cancel all datasets';
  E_UpdateWrongTrn    = '%s güncellenemiyor, sahibi %s deðil'; //Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'SQL komutu boþ olamaz'; //Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Dosya sonu'; //At end of file';
  E_AT_END_OF_CURSOR  = 'Ýmleç sonu'; //At end of cursor';
  E_AT_END_OF_BUFFER  = 'Tampon sonu'; //At end of buffer';
  E_AT_END_OF_DATASET = 'Veri kümesi sonu'; //At end of dataset';
  E_BAD_SQL_INF_LEN   = 'isc_dsql_sql_info''da beklenmeyen uzunluk'; //Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'isc_dsql_sql_info''dan geçrisiz veri döndü'; //Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = 'Ýmleç adý imleç aktifken deðiþtirilemez'; //Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Aktif durumda RequestLive(CanlýÝstem) deðiþtirilemez'; //Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'Salt okunur veri kümesinden RequestLive(CanlýÝstem) talep edilemez'; //Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI		    = 'IB_CURSOR tek yönlüdür'; //IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Desteklenmeyen alan tipi: %d'; //Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND	      = '%d no''lu alan bulunamadý'; //FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = '%s ad''lý alan bulunamadý'; //FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO	= 'Geçersiz Odaklanmýþ Ýliþki No: %d'; //Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Geçersiz Odaklanmýþ Ýliþki Adý: %s'; //Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN		= 'IN( value [ , value ... ] ) sözdizimi hatasý'; //IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN 	= 'BETWEEN value AND value sözdizimi hatasý'; //BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = '%s DLL''i kullaným için bulunamadý';  //Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Geçersiz SQLkeyFields özelliði'; //Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR	   = 'Ýmleç, anahtar veri olmadan açýlamaz'; //Cannot open cursor without key data';
  E_SCROLL_ERROR	   = 'Kayýt anahtarý kayýp'#10#13'Ýmleç açýlamadý'; //Record key was lost'#10#13'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Baþlangýçtan önce geçersiz BufferRowNum'; // Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT	 = 'Boþ komut hazýrlanamaz'; //Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT	= 'Bilinmeyen komut çalýþtýrma denemesi'; //Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'Döngüsel baþvuru tanýmlanamaz'; //Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = 'Baðlantý aktifken deðiþtirilemez'; //Cannot change while connected';
  E_LOGIN_FAILED      = 'Giriþ baþarýsýz'; //Login failed';
  E_CANT_GET_CONN_CHR = 'Baðlantý özellikleri belirlenemedi'; //Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = 'Bir blok için fazla olay sayýsý'; //Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Olaylar süreçte'#13#10'Geçersiz hale getirilemez'; //Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'Blob zaten saklý veya saklanamýyor'; //Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'Blob zaten yüklü veya yüklenemiyor'; //Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Mevcut kayýt iptal edilemiyor'; // Cannot cancel current Row';
  E_CANNOT_POST_ROW  = 'Mevcut kayýt kaydedilemiyor'; //Cannot Post current Row';
  E_DatasetClosed     = 'Veri kümesi açýlmamýþ'; //Dataset is inactive';
  E_DatasetOpen        = 'Veri kümesi zaten açýk'; //Dataset is currently open';
  E_DatasetCannotScroll = 'Veri kümesi kaydýrýlamýyor'; //Dataset cannot scroll';
  E_DatasetReadOnly	= 'Veri kümesi salt okunur'; //Dataset is readonly';
  E_DatasetIsFetching	 = 'Veri kümesi þu anda veri toparlýyor'; //Dataset is currently fetching';
  E_Invalid_KeyRelation   = 'Geçersiz KeyRelation deðeri'; //Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNum daha uyarlanmadý'; //RowNum is not implemented yet';
  E_RowDeleted		  = 'Geçerli kayýt siliniyor'; //Row is being deleted';
  E_END_OF_DATASET	  = 'Konum veri kümesinin sonunda'; //At end of Dataset';
  E_BEGINNING_OF_DATASET   = 'Konum veri kümesinin baþýnda'; //At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'Kötümser kilitleme (pessimistic locking) LockWait ile kullanýlamaz'; //Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row	 = 'Mevcut kayýt düzenlenemez'; //Cannot Edit current Row';
  E_Cannot_Insert_Row  = 'Yeni kayýt eklenemez'; //Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Mevcut kayýt silinemez'; //Cannot delete current Row';
  E_Cannot_Search    = 'Arama yapýlamaz'; //Searching is not allowed';
  E_Cannot_Navigate = 'Kayýtlar arasýnda gezilemiyor'; //Cannot navigate';
  E_Record_Locked    = 'Kayýt baþka bir kullanýcý tarafýndan kilitlendi'; //Record is locked by another user';
  E_Record_OutOfSynch = 'Kayýt baþka bir kullanýcý tarafýndan deðiþtirilmiþ'; //Record was changed by another user';
  E_FLD_READONLY       = '%s salt okunur'; //%s is readonly';
  E_Required_Field	 = 'Zorunlu alan: %s'; //%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Beklemeli günceleþtirmeler ile PostRetaining kullanýlamaz'; //Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Tek kayýtlý toparlamada birden fazla kayýt'; //Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Geçersiz RowsAffected tamponu'; //Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Dosya sonunda(Eof) geçersiz RowNum'; //EOF Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Dosya baþlangýcýnda(Bof) geçersiz RowNum'; //Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Geçersiz yerimi (Bookmark) dizgesi'; //Invalid Bookmark String';

  E_Assign_Column  = '%s''den atama yapýlamýyor'; //Cannot assign from %s';
  E_AssignTo_Column = '%s''e atama yapýlamýyor'; //Cannot assign to %s';
  E_Value_Out_Of_Range = 'Aralýk dýþý deðer'; //Value out of range';
  E_SmallintOverflow = 'Smallint taþmasý'; //Smallint overflow';
  E_IntegerOverflow = 'Integer taþmasý'; //Integer overflow';
  E_Int64Overflow = 'Int64 taþmasý'; //Int64 overflow';

  E_Unsupported_Column = 'Desteklenmeyen alan tipi: %d'; // Unsupported Column type: %d';
  E_UndefinedMacro = 'Tanýmsýz makro'; //Undefined macro';
  E_GeneratorFailed = 'Generator deðeri alýnamadý'; //Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'TIB_Dataset (Ib_Query) tipinden devralmýþ olmalý'; //Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Saltokunur (ReadOnly) iþlem baþladýktan sonra deðiþtirilemez'; //Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = 'Ýzolasyon (Isolation) iþlem baþladýktan sonra deðiþtirilemez'; //Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Kayýt sürümü (RecVersion) iþlem baþladýktan sonra deðiþtirilemez'; //Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'KilitiBekle (LockWait) iþlem baþladýktan sonra deðiþtirilemez'; //Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Silme için geçersiz referans'; //Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53Bit integer taþmasý'; //53bit integer overflow';
  E_Invalid_Typecast = 'Geçersiz atama(typecast)'; //Invalid typecast';
  E_Invalid_DataPump_Statement = 'Veri alýmý için geçersiz komut tipi'; //Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'BOÞ OLAMAZ (NOT NULL) alana boþ (null) deðer atandý'; //NOT NULL field set to null value';
  E_DATABASE_BLANK = 'Veri tabaný adý boþ olamaz'; //DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Desteklenmeyan alan tipi çevrimi'; //Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Kayýt konumlanmasý baþarýsýz'; //Unable To Locate Record';
  E_Record_Not_Inserted = 'Yeni kayýt eklenemedi'; //Record was not inserted';
  E_Invalid_KeyLinks = 'Geçersiz KeyLinks giriþi: %s'; //Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Arama gerçekleþtirilemiyor'; //Unable to perform search';
  E_Unassigned_Blob_Node = 'Atanmamýþ BlobNode'; //Unassigned BlobNode';
  E_Unassigned_Transaction = 'Atanmamýþ Aktarým'; //Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Geçersiz RowsAffected tamponu'; //Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Grafik kaydedilemiyor'; //Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Aktarým aktif hale getirilemiyor'; //Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'Firebird/Interbase istemcisi GDS32.DLL yklü deðil'; //InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Memo yüklenemiyr'; //Could not load memo';
  E_Invalid_DPB_Over_255 = 'Geçersiz DPB: Ýçerik 255 karakterden fazla'; //Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Geçersiz özgün DML alaný referansý: %s'; //Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Kayýt güncelleþtirme için konumlanmamýþ'; //Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Kayýt silme için konumlanmamýþ'; //Record was not located to delete';
  E_Init_Default_SQL_Failed = '%s varsayýlan deðeri ile baþlatýlamýyor'; //Unable to initialize default %s';
  E_Stringlist_Not_Sorted = 'Stringlist bu iþlem için sýralanmýþ olmalý'; //Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Olay süreçte iken deðiþtirilemez'; //Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Olay süreçte iken geçersiz hale getirilemez'; //Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Geçersiz içsel IB_Transaction'; //Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Geçersiz komut tipi'; //Invalid statement type';
  E_Multiple_Records_Updated = 'Çoklu kayýt güncelleþtrildi'; //Multiple records updated';
  E_Multiple_Records_Deleted = 'Çoklu kayýt silindi'; //Multiple records deleted';
  E_Multiple_Records_Inserted = 'Çoklu Kayýt Eklendi';
  E_DUP_DB_NAME = 'Ayný veri tabaný adý kullanýlamz'; //Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Geçersiz veri tabaný adý'; //Invalid DatabaseName';
  E_UnableToSearch_NoOrdering = 'Arama yapýlamýyor. Sýralama tanýmlý deðil'; //Unable to perform search, no ordering defined';
  E_UnableToSearch_DatasetBusy = 'Arama yapýlamýyor. Veri kümesi veri toparlýyor'; //Unable to perform search, dataset is busy fetching data';
//  E_UnableToSearch = 'Arama gerçekleþtirilemeiyor'; //Unable to perform search';
  E_NoRecordsFound = 'Hiçbir kayýt bulunamadý'; //No records found';
  E_Session_Undefined = 'Oturum(Session) tanýmsýz'; //Session is undefined';
  E_NoCircularRef = 'Döngüsel baþvuru'; //Circular reference not allowed';
  E_InvalidClassType = 'Geçersiz sýnýf(class) tipi'; //Invalid class type';
  E_Invalid_RowNum = 'Geçersiz Kayýt No'; //Invalid RowNum';
  E_Invalid_Syntax = 'Geçersiz söz dizimi: Fazla veya eksik parantez'; //Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Dizi Boþ(Null)'; //Array is Null';

  E_Cannot_add_blank_account = 'Boþ kullanýcý eklenemez'; //Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'SYSDBA kullanýcýsý eklenemez'; //Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Boþ kullanýcý silinemez'; //Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'SYSDBA kullanýcýsý silinemez'; //Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Boþ kullanýcý düzenlenemez'; //Cannot modify blank account';

  E_PLAN_ERROR = 'PLAN HATASI'; //PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN ÝSTÝSNASI'; //PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Geçersiz CREATE, CONNECT veya DROP DATABASE sözdizimi'; //DROP DATABASE Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Desteklenmiyor'; //Unsupported';
  E_NotImplemented = 'Bu seviyede uyarlanmadý'; //Not implemented at this level';
  E_Invalid_ColData = 'Geçersiz alan verisi'; //Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Yürütülen süreç hazýrlýðý iptal edilemez'; //Cannot Unprepare an executing process';
  E_FileName_Required = 'Dosya adý girilmeli'; //Filename is required';

 { Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Kullanýcý Hesabý Yönetimi'; //User Account Management';
  L_USERS_ADD = 'Ekle'; //Add';
  L_USERS_DELETE = 'Sil'; //Delete';
  L_USERS_MODIFIY = 'Deðiþtir'; //Modify';
  L_USERS_ACCOUNT = 'KULLANICI'; //ACCOUNT';
  L_USERS_PASSWORD = 'Þifre'; //Password';
  L_USERS_GROUP = 'Grup'; //Group';
  L_USERS_FIRSTNAME = 'Adý'; //First Name;
  L_USERS_MIDDLENAME = 'Orta Adý'; //Middle Name;
  L_USERS_LASTNAME = 'Soyadý'; //Last Name';

//IBF_Export
  L_EXPORT_FRM = 'Veri Ver'; //Export';
  L_EXPORT_ASCII = ' Dosya Formatý'; //File Format ';
  L_EXPORT_FIXED = 'TXT Sabit Kayýt Geniþliði'; //TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV Sýnýrlandýrýlmýþ'; //CSV Delimited';
  L_EXPORT_DBF	= 'DBF (Hala test aþamasýnda)'; //DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = ' ASCII Seçenekleri'; //ASCII Options ';
  L_EXPORT_DELIMITER  = 'Sýnýrlayýcý'; //Delimiter';
  L_EXPORT_SEPARATOR  = 'Ayraç'; //Separator';
  L_EXPORT_DATEFORMAT  = 'Tarih Biçimi'; //Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Baþlýklarý Dahil Et'; //Include Headers';
  L_EXPORT_INCLUDECRLF	= 'CRLF''i Dahil Et'; //Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Aktar'; //Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Virgül ile Ayrýlmýþ Tekst dosyalarý ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Text Dosyalarý ( *.TXT )|*.TXT'; //Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF Dosyalarý ( *.DBF )|*.DBF'; //DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Ýptal etmek istediðinizden emin misiniz?'; //Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Sorgu Sonucu Alýnýyor'; //Fetching Query Results';
  M_Row_Num = 'Kayýt No: %d'; //Row# %d';
  M_Abort_Fetching_Btn = 'Ýptal'; //Abort';

  M_Login_Database = 'Veritabaný'; //Database';
  M_Login_User = 'Kullanýcý'; //User';
  M_Login_Password = 'Þifre'; //Password';
  M_Login_OK_Btn = 'Tamam'; //OK';
  M_Login_Cancel_Btn = 'Ýptal'; //Cancel';
  M_Login_Help_Btn = '&Yardým'; //&Help';
  M_Login_Dialog_Caption = 'Giriþ Ekraný'; //Login Dialog';

  M_Loading_Caption = 'Yükleniyor...'; //Loading...';

  M_SB_REC_CNT = 'Kayýt Sayýsý: %d'; //Records counted: %d';
  M_Save_Changes = 'Deðiþiklikler kaydedilsin mi?'; //Save changes?';
  M_Abort_Changes = 'Yapýlan deðiþiklikler geçersiz olacak. Devam edilsin mi?'; //Changes will be lost. Ok to proceed?';

  M_CancelTransactionPrompt =  'Yapýlan tüm deðiþiklikler iptal edilsin mi?'; //'Are you sure you want to cancel all changes?';
    
  M_SCRIPT_ABORT_EXECUTE = 'Bu komutun yürütümü kesilsin mi?'; //Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Komut yürütümüne devam?'; //Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Komut halen yürütülüyor'; //Script is currently executing';
  M_SCRIPT_FAILED = 'Komut yürütümü tamamlanamadý'; //Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Komut yürütümü iptal edildi'; //Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Komut yürütümü istinasýz tamamlandý'; //Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Komut yürütümü istisnalar ile tamamlandý'; //Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'Deðiþiklik'; //Modified';
  M_SCRIPT_SAVE_CHANGES = 'Deðiþiklikler kaydedilsin mi?'; //Save changes?';

{ Button captions }

  C_BTN_TODAY = 'Bugün'; //Today';
  C_BTN_CLEAR = 'Temizle'; //Clear';
  C_BTN_FIND = 'Bul'; //Find';
  C_BTN_FINDNEXT = 'Sonrakini Bul'; //Find Next';
  C_BTN_REPLACE = 'Deðiþtir'; //Replace';
  C_BTN_UNDO = 'Geri Al'; //Undo';
  C_BTN_CUT = 'Kes'; //Cut';
  C_BTN_COPY = 'Kopyala'; //Copy';
  C_BTN_PASTE = 'Yapýþtýr'; //Paste';
  C_BTN_DELETE = 'Sil'; //Delete';
  C_BTN_SELECTALL = 'Tümünü Seç'; //Select All';

  C_SG_Parameter = 'Parametre'; //Parameter';
  C_SG_Field = 'Alan'; //Field';
  C_SG_Name = 'Ýsim'; //Name
  C_SG_Type = 'Tipi'; //Type';
  C_SG_Info = 'Bilgi'; //Info';
  C_SG_Value = 'Deðer'; //Value';

  C_BF_OK = 'Tamam'; //OK';
  C_BF_CANCEL = 'Ýptal'; //Cancel';
  C_BF_CANCEL_ACCEL = 'Ý&ptal'; //'&Cancel';
  C_BF_APPLY = 'Uygula'; //Apply';
  C_BF_HELP = 'Yardým'; //Help';
  C_BF_EXECUTE = 'Yürüt'; //Execute';
  C_BF_CLOSE = 'Kapat'; //Close';
  C_BF_CLOSE_ACCEL = '&Kapat'; //&Close';
  C_BF_FINISH = 'Bitir'; //Finish';
  C_BF_FINISH_ACCEL = '&Bitir'; //&Finish';

  C_FRM_Ordering = 'Sýralama'; //Ordering';
  C_FRM_RESTRUCTURE = 'Görünür Alanlarý Özgünleþtir'; //Customize Fields Displayed';

  C_CB_WordWrap = 'Metni Kaydýr'; //Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'Etkilenen Kayýt'; //'RowsAffected: ';
  M_SQL_RowsCounted = 'Kayýt Sayýsý:'; //Rows Counted: ';
  M_SQL_SessionBusy = 'Oturum þu anda meþgul'; //Session is currently busy';
  M_SQL_CompleteTransaction = 'Lütfen aktarýmýnýzý tamamlayýn'; //Please complete your transaction';
  M_SQL_CannotDeleteDefaultGroup = 'Varsayýlan grup silinemez'; //The default group cannot be deleted';
  M_SQL_ReservedName = 'Bu ad ayrýlmýþ'; //This name is reserved: ';
  M_SQL_BackSlashNotAllowed = 'Ters bölüm iþareti kullanýlamaz'; //A back slash is not allowed';
  M_SQL_BlankNameNotAllowed = 'Ad boþ olamaz'; //A blank name is not allowed';
  M_SQL_RowsFetched = 'Toparlanan Kayýt:'; //Rows Fetched: ';
  M_SQL_ConfirmDBCreation = 'Bu veritabaný yaratýlsýn mý?'; //Are you sure you want to create this database?';
  M_SQL_ConfirmNoOtherDBSameName = 'Lütfen ayný isimli baþka bir veri tabaný olmadýðýndan emin olun'; //Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = 'Bu veritabanýný silmek istediðiniden emin misiniz?'; //Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = 'Bu veri tabaný kalýcý olarak kaldýrýlacaktýr'+#13+#10+#13#10'Devam edilsin mi?'; //This database will be permanently removed.'+#13#10+#13#10'Continue anyway?';
  M_SQL_AskFormName = 'Sorgu Formu Adý:'; //Enter query form name:';
  M_SQL_AskGroupName = 'Grup Adý:'; //Enter group name:';
  M_SQL_AskLayoutName = 'Yerleþim Adý:'; //Enter layout name:';
  M_SQL_ConfirmGroupDeletion = '%s grubu tüm alt elemanlarý ile birlikte silinsin mi?'; //Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = '%s yerleþimi silinsin mi?'; //Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = 'Döngüsel kopyalama yapýlamaz'; //Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Bir elemana çift týklayan veya bir eleman seçili iken enter a basýn'; //Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'Parametre Deðeri'; //Parameter value';
  M_GCSQL_TypeAValueFor = '%s için bir deðer girin'; //Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = 'Bu yönteme ait parametre yok'; //This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Veri alýmý devam ediyor'; //Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'Emin misiniz?'; //Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Kaynak veri tabanýný seçin';//Select Source Database';
  M_DP_SELECT_DEST_DB = 'Hedef veri tabanýný seçin'; //Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Tamam'; //Ok';
  C_BTN_USERS_CLEAR = 'Temizle'; //Clear;
  M_USERS_COMPLETED_OK = 'Ýþlem baþarýyla tamamlandý'; //Operation completed Successfully';
  M_USERS_NO_CONNECTION = 'Tanýmlý IB_Connection yok'; //No IB_Connection defined.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Sýralama alanlarý atansýn mý?'; //Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Veriyi Aktar'; //Begin Export';
  M_EXPORT_STILL_ACTIVE = 'Export process is still active.';

  // IB_UtilityBar
  C_wbBrowseBtnHint	= 'Veritabanýný Tara'; // Browse Database';
  C_wbBrowseBtnCaption	= 'Tarayýcý'; //Browse';
  C_wbDSQLBtnHint	= 'Veritabanýnda bir komut yürüt'; //Execute Statement In Database';
  C_wbDSQLBtnCaption	= 'DSQL';
  C_wbEventsBtnHint	= 'Veriatabýný olaylarýný izle'; //Monitor Database Events';
  C_wbEventsBtnCaption	= 'Olaylar'; //Events';
  C_wbExportBtnHint	= 'Veritabanýndan veri kümesini dýþa aktar'; //Export Dataset From Database';
  C_wbExportBtnCaption	= 'Veri Ver'; //Export';
  C_wbDumpBtnHint	= 'Tüm veritabanýný aktar'; //Dump Database';
  C_wbDumpBtnCaption	= 'Aktar'; //Dump';
  C_wbPumpBtnHint	= 'Baþka bir veritabanýndan veri al'; //Pump Data From Another Database';
  C_wbPumpBtnCaption	= 'Veri Al'; //Pump';
  C_wbWhoBtnHint	= 'Veri tabanýna kimler baðlý'; //See Who is Connected to the Database';
  C_wbWhoBtnCaption	= 'Kim'; //Who';
  C_wbScriptBtnHint	= 'Kýsa komut yürüt'; //Execute Script';
  C_wbScriptBtnCaption	= 'Komut'; //Script';
  C_wbExtractBtnHint	= 'Veri tanýmla dilini (DDL) çýkar'; //Extract DDL';
  C_wbExtractBtnCaption = 'DDL Çýkar'; //Extract';
  C_wbMonitorBtnHint	= 'SQL ve API çaðrýlarýný izle'; //Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monitör'; //Monitor';
  C_wbProfilerBtnHint	= 'Veri tabaný aktivitelerinin profili'; //Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profil'; //Profile';
  C_wbStatusBtnHint	= 'IBO Bileþenlerinin durumu'; //View Status of IBO Components';
  C_wbStatusBtnCaption	= 'Durum'; //Status';
  C_wbUsersBtnHint	= 'Veri tabaný sunucusundaki kullanýcýlarýn yönetimi'; //Administer Users for a Database Server';
  C_wbUsersBtnCaption	= 'Kullanýcý'; //User';

  // Array grid
  C_AG_Row	       = 'Satýr'; //Row';
  C_AG_Column	       = 'Sütun'; //Column';

  //IBF_Who
  C_WHO_FRM	       = 'Baðlý Kullanýcýlar'; //Who is connected';
  C_WHO_BTNAPPLY       = 'Güncelle'; //Refresh';

  C_NB_FIRST = 'Ýlk kayýt'; //First';
  C_NB_PRIOR = 'Önceki kayýt'; //Prior';
  C_NB_NEXT = 'Sonraki kayýt'; //Next';
  C_NB_LAST = 'Son kayýt'; //Last';

  C_ST_Open = 'Aç'; //Open';
  C_ST_Close = 'Kapat'; //Close';
  C_ST_Prepare = 'Hazýrla'; //Prepare';
  C_ST_Unprepare = 'Hazýrlýk iptal'; //Unprepare';
  C_ST_ReadOnly = 'Salt okunur'; //Read Only';
  C_ST_New = 'Yeni kayýt'; //New';
  C_ST_Post = 'Kaydet'; //Post';
  C_ST_Cancel = 'Ýptal'; //Cancel';
  C_ST_Delete = 'Sil'; //Delete';
  C_ST_Edit = 'Düzenle'; //Edit';
  C_ST_RefreshKeys = 'Anahtar güncelle'; //Refresh Keys';
  C_ST_RefreshRows = 'Kayýtlarý gðncelle'; //Refresh Rows';
  C_ST_Refresh = 'Güncelle'; //Refresh';

{ Hints }

  H_UB_EDIT = 'Kaydý düzenle'; //Edit Row';
  H_UB_INSERT = 'Kayýt ekle'; //Insert Row';
  H_UB_DELETE = 'Kaydý sil'; //Delete Row';
  H_UB_REFRESH = 'Tüm kayýtlarý güncelle'; //Refresh all records';
  H_UB_REFRESHKEYS = 'Kayýt anahtarlarýný güncelle'; //Refresh record keys';
  H_UB_REFRESHROWS = 'Kayýt satýrlarýný güncelle'; //Refresh record rows';
  H_UB_REFRESHFILTROWS = 'Süzülmüþ kayýtlarý güncelle'; //Refresh filtered rows';
  H_UB_POSTSEARCH = 'Arama kriterlerini uygula'; //Post search criteria';
  H_UB_CANCELSEARCH = 'Arama kriterlerini iptal et'; //Cancel search criteria';
  H_UB_POSTEDIT = 'Düzenlemeleri kaydet'; //Post edits';
  H_UB_CANCELEDIT = 'Düzenlemeleri iptal et'; //Cancel edits';
  H_UB_POSTINSERT = 'Yeni kaydý kaydet'; //Post insert';
  H_UB_CANCELINSERT = 'Yeni kaydý iptal et'; //Cancel insert';
  H_UB_POSTDELETE = 'Silmeyi onayla'; //Post delete';
  H_UB_CANCELDELETE = 'Silmeyi iptal et'; //Cancel delete';
  H_UB_POST = 'Deðiþiklikleri kaydet'; //Post changes';
  H_UB_CANCEL = 'Deðiþiklikleri iptal et'; //Cancel changes';

  H_NB_FIRST = 'Ýlk kayýt'; //First Row';
  H_NB_PRIOR = 'Önceki kayýt'; //Prior Row';
  H_NB_NEXT = 'Sonraki kayýt'; //Next Row';
  H_NB_LAST = 'Son kayýt'; //Last Row';
  H_NB_JUMPBCK = 'Hýzlý geri'; //Backwards';
  H_NB_JUMPFWD = 'Hýzlý ileri'; //Forwards';

  H_SB_ORDER = 'Veri kümesini sýrala'; //Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Son arama kriterini tekrarla'; //Recall Last Search Criteria';
  H_SB_SEARCH = 'Veri kümesinde ara'; //Search Dataset';
  H_SB_SAVE_CRITERIA = 'Kriteri sakla'; //Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Kriteri temizle'; //Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Kriteri tekrarla'; //Recall Criteria';
  H_SB_SEARCHCOUNT = 'Veri kümesindeki kritere uyan kayýtlarý say'; //Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Veri kümesindeki kayýtlarý say'; //Count Rows in Dataset';
  H_SB_RESTRUCTURE = 'Görünür Alanlarý özgünleþtir'; //Customize the Fields Displayed';

  H_TB_StartTransaction = 'Aktarýma baþla'; //Start Transaction';
  H_TB_PostDatasets = 'Veri kümelerini sakla'; //Post Datasets';
  H_TB_CancelDatasets = 'Veri kümelerini iptal et'; //Cancel Datasets';
  H_TB_SavePoint = 'Mevcut aktarýmý iþle ve alýkoy'; //Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Veri kümelerini kaydet, mevcut aktarýmý iþle ve alýkoy'; //Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Mevcut aktarýmý iþle ve sonlandýr'; //Commit and End Current Transaction';
  H_TB_Rollback = 'Mevcut aktarýmý geri al ve sonlandýr'; //Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Mevcut aktarýmý geri al ve alýkoy'; //Rollback and Retain Current Transaction';
  H_TB_Close = 'Mevcut aktarýmý kapat'; //Close Current Transaction';

  H_ST_Prepare_Statement = 'Komutu hazýrla'; //Prepare Statement';
  H_ST_Unprepare_Statement = 'Komut hazýrlýðý iptal'; //Unprepare Statement';
  H_ST_Execute_Statement = 'Komutu yürüt'; //Execute Statement';

  H_DS_Open_Dataset = 'Veri kümesini aç'; //Open Dataset';
  H_DS_Close_Dataset = 'Veri kümesini kapat'; //Close Dataset';
  H_DS_Prepare_Dataset = 'Veri kümesini hazýrla'; //Prepare Dataset';
  H_DS_Unprepare_Dataset = 'Veri kümesi hazýrlýðý iptal'; //Unprepare Dataset';
  H_DS_ReadOnly_Dataset = 'Salt okunur veri kümesi'; //Read Only Dataset';

  H_CB_Create_Database = 'Veri tabanýný yarat'; //Create Database';
  H_CB_Connect_Database = 'Veri tabanýna baðlan'; //Connect Database';
  H_CB_Disconnect_Database = 'Veri tabaný baðlantýsýný kes'; //Disconnect Database';
  H_CB_Drop_Database = 'Veri tabanýný sil'; //Drop Database';

  H_RD_actHide = 'Seçili alanlarý gizle'; //Hide selected Fields';
  H_RD_actHideAll = 'Tüm alanlarý gizle'; //Hide all Fields';
  H_RD_actVisible = 'Seçili alanlarý göster'; //Set selected fields visible';
  H_RD_actVisibleAll = 'Tüm alanlarý göster'; //Set all selected fields visible';
  H_RD_actUp = 'Seçili alanlarý bir üste taþý'; //Move selected fields one up';
  H_RD_actTop = 'Seçili alanlarý en üste taþý'; //Move selected fields to the top';
  H_RD_actDown = 'Seçili alanlarý bir alta taþý'; //Move selected fields one down';
  H_RD_actBottom = 'Seçili alanlarý en alta taþý'; //Move selected fields to the bottom';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'SELECT komutundan veri ver'; //Export from SELECT statement';

  // Error Messages - IB_Import
  eNoAsciiFileEnty	     = 'Ascii dosyasý için eksik giriþ'; //Missing entry for Ascii file';
  eNoDestTableEntry	     = 'Hedef tablo için eksik giriþ'; //Missing entry for destination table';
  eAsciiFileNotFound	     = '%s Ascii dosyasý bulunamdaý'; //Ascii file %s not found';
  eIniFileNotFound	     = '%s Ini dosyasý bulunamadý'; //Ini-file %s not found';
  eNoAsciiFileAccess	     = '%s Ascii dosyasý açýlamýyor'; //Could not open ascii file %s';
  eInvalidCharFound	     = 'Ascii dosyada geçersiz karakter/biçim hatasý'; //Invalid char / format error in ascii file';
  eOutOfMemory		     = 'Yetersiz hafýza'; //Out of memory';
  eFieldDescriptionError     = 'Alan tanýmlarýnda hata'; //Error in field description';
  eWrongAsciiFieldCount      = 'Ascii dosyada hatalý alan sayýsý'; //Wrong field count in ascii file';
  eWrongDecimalCount	     = 'Alan listesi (%s)''de hatalý ondalýk sayýsý'; //Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth	     = 'Ascii dosyada hatalý alan uzunluðu'; //Wrong field width in ascii file';

  // Dialog Labels - IB_Import

  lblRecsReadedCaption	     = 'Okunan Kayýt'; //Total Records read';
  lblRecsCommentedCaption    = 'Yorumlanan Kayýt'; //Records commented';
  lblRecsInsertedCaption     = 'Eklenen Kayýt'; //Records inserted';
  btnAbortImportCaption      = 'Ýptal'; //Abort';

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

  // CodePass Names
  STR_DDL_cpFull = 'Full';
  STR_DDL_cpInit = 'Initial';
  STR_DDL_cpFinal = 'Final';
  STR_DDL_cpAuto = 'Automatic';

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

implementation

end.
