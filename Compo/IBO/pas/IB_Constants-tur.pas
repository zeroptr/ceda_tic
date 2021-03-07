
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

  IB_REG_MESSAGE = 'IB Objects denedi�iniz i�in te�ekk�rler.'#13#10#13#10'L�tfen http://www.ibobjects.com adresini bug�n ziyaret edin ve kay�tl� olun';
  //IB_REG_MESSAGE = 'Thanks for evaluating IB Objects.'#13#10#13#10'Please go to http://www.ibobjects.com and register today.';

{ Error constants for IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED	      = 'Ba�lant� kurulmu� durumda'; // Connection has already been established';
  E_NOT_CONNECTED     = 'Ba�lant� kurulmam�� durumda'; // Connection has not been established';
  E_Invalid_conn_path = 'Ge�ersiz ba�lant� yolu';
  E_Cant_Repl_Int_Tr  = '�� aktar�m varsay�lan ile yer de�i�tirilemez'; //Cannot replace internal transaction as default';
  E_NO_TRANS_STARTED  = 'Aktar�m ba�lamam�� durumda'; //Transaction has not been started';
  E_TRANS_STARTED     = 'Aktar�m zaten ba�lam�� durumda'; //Transaction has already been started';
  E_NO_CONNECTIONS    = 'Aktar�ma ait ba�lant� yok'; //Transaction has no connections';
  E_NOT_ENOUGH_CONN   = 'Aktar�m bir veya daha fazla ba�lant�ya ihtiya� duyuyor'; //Transaction is missing one or more connections';
  E_CONN_LOADING      = 'Uyar�: Ba�lant� hala y�kleniyor'; //Warning: Connection is still loading';
  E_TRANS_CONN_SESS   = 'B�t�n ba�lant�lar ayn� IB_Session oturumunda olmal�'; //Connections must all be in the same IB_Session';
  E_TransactionPaused = 'Aktar�m Duraklat�ld�'; //Transaction is Paused';
  E_ALLOCATED	      = 'Komut zaten tahsis edilmi�'; //Statement has already been allocated';
  E_NOT_ALLOCATED     = 'Komut tahsis edilmemi�'; //Statement has not been allocated';
  E_PREPARED	      = 'Komut zaten haz�rlanm��'; //Statement has already been prepared';
  E_NOT_PREPARED      = 'Komut haz�rlanmam�� durumda'; //Statement has not been prepared';
  E_FAILED_TO_PREPARE = 'Komut haz�rl��� ba�ar�s�z'; //Statement failed to prepare';
  E_OPENED	      = 'Komut zaten a��lm�� durumda'; //Statement has already been opened';
  E_NOT_OPENED	      = 'Komut a��k de�il'; //Statement has not been opened';
  E_CANT_DELETE       = '�mle�teki mevcut kay�t silinemez'; //Current record in the cursor cannot be deleted';
  E_NO_CONNECTION     = 'Komuta IB_Connection atamas� gerekiyor'; //Statement must have an IB_Connection assigned';
  E_CONNECT_FAILED    = 'IB_Connection a��lam�yor'; //Unable to open IB_Connection';
  E_NO_TRANSACTION    = 'Komuta IB_Transaction atamas� gerekiyor'; //Statement must have an IB_Transaction assigned';
  E_NO_ACTIVE_TRANS   = '�al��t�rmak i�in ge�erli aktar�m yok'; //No active transaction to execute with';
  E_START_FAILED      = 'Aktar�m ba�lat�lam�yor'; // Unable to start a transaction';
  E_SVRAUTOCMT_NOEXP  = 'ServerAutoCommit (SunucuOto��leme) durumunda Explicit(kesin) aktar�m olamaz'; //Explicit trans. not allowed with ServerAutoCommit';
  E_Cannot_Activate	= 'Ge�ersiz aktar�m durumu. Aktifle�tirilemiyor'; //Invalid transaction state. Cannot activate';
  E_Transaction_Is_Active = 'Aktar�mda sonland�r�lmam�� bekleyen de�i�iklikler var'; //Transaction has pending changes';
  E_Failed_To_Post_Datasets = 'T�m veri k�meleri kayd� ba�ar�s�z'; //Failed to post all datasets';
  E_Failed_To_Cancel_Datasets = 'T�m veri k�meleri iptali ba�ar�s�z'; //Failed to cancel all datasets';
  E_UpdateWrongTrn    = '%s g�ncellenemiyor, sahibi %s de�il'; //Cannot update, %s is not owned by %s';
  E_NO_BLANK_SQL      = 'SQL komutu bo� olamaz'; //Blank SQL statement not allowed';
  E_AT_END_OF_FILE    = 'Dosya sonu'; //At end of file';
  E_AT_END_OF_CURSOR  = '�mle� sonu'; //At end of cursor';
  E_AT_END_OF_BUFFER  = 'Tampon sonu'; //At end of buffer';
  E_AT_END_OF_DATASET = 'Veri k�mesi sonu'; //At end of dataset';
  E_BAD_SQL_INF_LEN   = 'isc_dsql_sql_info''da beklenmeyen uzunluk'; //Unanticipated length in isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'isc_dsql_sql_info''dan ge�risiz veri d�nd�'; //Invalid data returned from isc_dsql_sql_info';
  E_CURSOR_NAME_LOCK  = '�mle� ad� imle� aktifken de�i�tirilemez'; //Cannot change cursor name while active';
  E_REQUEST_LIVE_ACTIVE = 'Aktif durumda RequestLive(Canl��stem) de�i�tirilemez'; //Cannot change RequestLive while active';
  E_REQUEST_LIVE_READONLY = 'Salt okunur veri k�mesinden RequestLive(Canl��stem) talep edilemez'; //Cannot RequestLive a ReadOnly dataset';
  E_CURSOR_UNI		    = 'IB_CURSOR tek y�nl�d�r'; //IB_CURSOR is unidirectional';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Desteklenmeyen alan tipi: %d'; //Unsupported Column type: %d';
  E_FIELDNO_NOT_FOUND	      = '%d no''lu alan bulunamad�'; //FieldNo: %d not found';
  E_FIELDNAME_NOT_FOUND        = '%s ad''l� alan bulunamad�'; //FieldName: %s not found';
  E_INVALID_FOCUS_RELATION_NO	= 'Ge�ersiz Odaklanm�� �li�ki No: %d'; //Invalid Focused Relation No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Ge�ersiz Odaklanm�� �li�ki Ad�: %s'; //Invalid Focused Relation Name: %s';
  E_INVALID_QBE_IN		= 'IN( value [ , value ... ] ) s�zdizimi hatas�'; //IN( value [ , value ... ] ) syntax error';
  E_INVALID_QBE_BETWEEN 	= 'BETWEEN value AND value s�zdizimi hatas�'; //BETWEEN value AND value syntax error';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = '%s DLL''i kullan�m i�in bulunamad�';  //Unable to locate DLL import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Ge�ersiz SQLkeyFields �zelli�i'; //Invalid SQLKeyFields property';
  E_GET_CURSOR_ERROR	   = '�mle�, anahtar veri olmadan a��lamaz'; //Cannot open cursor without key data';
  E_SCROLL_ERROR	   = 'Kay�t anahtar� kay�p'#10#13'�mle� a��lamad�'; //Record key was lost'#10#13'Failed to open cursor';
  E_INVALID_BUFFER_ROW_NUM = 'Ba�lang��tan �nce ge�ersiz BufferRowNum'; // Invalid BufferRowNum before beginning';
  E_BLANK_STATEMENT	 = 'Bo� komut haz�rlanamaz'; //Cannot Prepare a blank statement';
  E_UNKNOWN_STATEMENT	= 'Bilinmeyen komut �al��t�rma denemesi'; //Attempt to execute an unknown statement';
  E_CIRCULAR_REFERENCE = 'D�ng�sel ba�vuru tan�mlanamaz'; //Circular reference not allowed';
  E_CANT_CHG_WITH_CONN = 'Ba�lant� aktifken de�i�tirilemez'; //Cannot change while connected';
  E_LOGIN_FAILED      = 'Giri� ba�ar�s�z'; //Login failed';
  E_CANT_GET_CONN_CHR = 'Ba�lant� �zellikleri belirlenemedi'; //Cannot get connection characteristics';
  E_MAX_EVENTS_BLOCK  = 'Bir blok i�in fazla olay say�s�'; //Over maximum events for one block';
  E_PROCESSING_EVENTS = 'Olaylar s�re�te'#13#10'Ge�ersiz hale getirilemez'; //Processing events'#13#10'Cannot unregister';
  E_CANT_STORE_BLOB  = 'Blob zaten sakl� veya saklanam�yor'; //Blob has been or cannot be stored';
  E_CANT_LOAD_BLOB   = 'Blob zaten y�kl� veya y�klenemiyor'; //Blob has already been or cannot be loaded';
  E_CANNOT_CANCEL_ROW = 'Mevcut kay�t iptal edilemiyor'; // Cannot cancel current Row';
  E_CANNOT_POST_ROW  = 'Mevcut kay�t kaydedilemiyor'; //Cannot Post current Row';
  E_DatasetClosed     = 'Veri k�mesi a��lmam��'; //Dataset is inactive';
  E_DatasetOpen        = 'Veri k�mesi zaten a��k'; //Dataset is currently open';
  E_DatasetCannotScroll = 'Veri k�mesi kayd�r�lam�yor'; //Dataset cannot scroll';
  E_DatasetReadOnly	= 'Veri k�mesi salt okunur'; //Dataset is readonly';
  E_DatasetIsFetching	 = 'Veri k�mesi �u anda veri toparl�yor'; //Dataset is currently fetching';
  E_Invalid_KeyRelation   = 'Ge�ersiz KeyRelation de�eri'; //Invalid KeyRelation value';
  E_RowNum_Not_Implemented = 'RowNum daha uyarlanmad�'; //RowNum is not implemented yet';
  E_RowDeleted		  = 'Ge�erli kay�t siliniyor'; //Row is being deleted';
  E_END_OF_DATASET	  = 'Konum veri k�mesinin sonunda'; //At end of Dataset';
  E_BEGINNING_OF_DATASET   = 'Konum veri k�mesinin ba��nda'; //At beginning of Dataset';
  E_Cannot_Pessimistic_Lock = 'K�t�mser kilitleme (pessimistic locking) LockWait ile kullan�lamaz'; //Cannot use pessimistic locking with LockWait';
  E_Cannot_Edit_Row	 = 'Mevcut kay�t d�zenlenemez'; //Cannot Edit current Row';
  E_Cannot_Insert_Row  = 'Yeni kay�t eklenemez'; //Cannot Insert a new Row';
  E_Cannot_Delete_Row = 'Mevcut kay�t silinemez'; //Cannot delete current Row';
  E_Cannot_Search    = 'Arama yap�lamaz'; //Searching is not allowed';
  E_Cannot_Navigate = 'Kay�tlar aras�nda gezilemiyor'; //Cannot navigate';
  E_Record_Locked    = 'Kay�t ba�ka bir kullan�c� taraf�ndan kilitlendi'; //Record is locked by another user';
  E_Record_OutOfSynch = 'Kay�t ba�ka bir kullan�c� taraf�ndan de�i�tirilmi�'; //Record was changed by another user';
  E_FLD_READONLY       = '%s salt okunur'; //%s is readonly';
  E_Required_Field	 = 'Zorunlu alan: %s'; //%s is a required field';
  E_NO_POSTRTN_CACHED_UPDT = 'Beklemeli g�ncele�tirmeler ile PostRetaining kullan�lamaz'; //Cannot Use PostRetaining with Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Tek kay�tl� toparlamada birden fazla kay�t'; //Multiple rows in singleton fetch';

  E_InvalidRowsAffectedBuf = 'Ge�ersiz RowsAffected tamponu'; //Invalid RowsAffected buffer';
  E_Invalid_RowNum_Past_Eof = 'Dosya sonunda(Eof) ge�ersiz RowNum'; //EOF Invalid RowNum beyond Eof';
  E_Invalid_RowNum_Before_Bof = 'Dosya ba�lang�c�nda(Bof) ge�ersiz RowNum'; //Invalid RowNum before Bof';
  E_Invalid_Bookmark = 'Ge�ersiz yerimi (Bookmark) dizgesi'; //Invalid Bookmark String';

  E_Assign_Column  = '%s''den atama yap�lam�yor'; //Cannot assign from %s';
  E_AssignTo_Column = '%s''e atama yap�lam�yor'; //Cannot assign to %s';
  E_Value_Out_Of_Range = 'Aral�k d��� de�er'; //Value out of range';
  E_SmallintOverflow = 'Smallint ta�mas�'; //Smallint overflow';
  E_IntegerOverflow = 'Integer ta�mas�'; //Integer overflow';
  E_Int64Overflow = 'Int64 ta�mas�'; //Int64 overflow';

  E_Unsupported_Column = 'Desteklenmeyen alan tipi: %d'; // Unsupported Column type: %d';
  E_UndefinedMacro = 'Tan�ms�z makro'; //Undefined macro';
  E_GeneratorFailed = 'Generator de�eri al�namad�'; //Unable to get generator value';

  E_MustBe_Buffered_Dataset = 'TIB_Dataset (Ib_Query) tipinden devralm�� olmal�'; //Must be of TIB_BDataset ancestry (IB_Query)';

  E_NO_CHANGE_READONLY = 'Saltokunur (ReadOnly) i�lem ba�lad�ktan sonra de�i�tirilemez'; //Cannot change ReadOnly when started';
  E_NO_CHANGE_ISOLATION = '�zolasyon (Isolation) i�lem ba�lad�ktan sonra de�i�tirilemez'; //Cannot change Isolation when started';
  E_NO_CHANGE_RECVERSION = 'Kay�t s�r�m� (RecVersion) i�lem ba�lad�ktan sonra de�i�tirilemez'; //Cannot change RecVersion when started';
  E_NO_CHANGE_LOCKWAIT = 'KilitiBekle (LockWait) i�lem ba�lad�ktan sonra de�i�tirilemez'; //Cannot change LockWait when started';

  E_Invalid_Reference_To_Delete = 'Silme i�in ge�ersiz referans'; //Invalid reference to Delete';
  E_53BIT_OVERFLOW = '53Bit integer ta�mas�'; //53bit integer overflow';
  E_Invalid_Typecast = 'Ge�ersiz atama(typecast)'; //Invalid typecast';
  E_Invalid_DataPump_Statement = 'Veri al�m� i�in ge�ersiz komut tipi'; //Invalid statement type for DataPump';
  E_FIELD_NOT_NULLABLE = 'BO� OLAMAZ (NOT NULL) alana bo� (null) de�er atand�'; //NOT NULL field set to null value';
  E_DATABASE_BLANK = 'Veri taban� ad� bo� olamaz'; //DatabaseName cannot be blank';
  E_Unsupp_Col_Conversion = 'Desteklenmeyan alan tipi �evrimi'; //Unsupported column conversion';
  E_Unable_To_Locate_Record = 'Kay�t konumlanmas� ba�ar�s�z'; //Unable To Locate Record';
  E_Record_Not_Inserted = 'Yeni kay�t eklenemedi'; //Record was not inserted';
  E_Invalid_KeyLinks = 'Ge�ersiz KeyLinks giri�i: %s'; //Invalid KeyLinks entry: %s';
  E_Unable_to_perform_search = 'Arama ger�ekle�tirilemiyor'; //Unable to perform search';
  E_Unassigned_Blob_Node = 'Atanmam�� BlobNode'; //Unassigned BlobNode';
  E_Unassigned_Transaction = 'Atanmam�� Aktar�m'; //Unassigned Transaction';
  E_Invalid_RowsAffected_Buffer = 'Ge�ersiz RowsAffected tamponu'; //Invalid RowsAffected buffer';
  E_Unable_Save_Graphic = 'Grafik kaydedilemiyor'; //Unable to save to Graphic';
  E_Cannot_Activate_Transaction = 'Aktar�m aktif hale getirilemiyor'; //Cannot Activate Transaction';
  E_IB_Client_Not_Installed = 'Firebird/Interbase istemcisi GDS32.DLL ykl� de�il'; //InterBase Client GDS32.DLL is not installed';
  E_Could_Not_Load_Memo = 'Memo y�klenemiyr'; //Could not load memo';
  E_Invalid_DPB_Over_255 = 'Ge�ersiz DPB: ��erik 255 karakterden fazla'; //Invalid DPB: Contents over 255 characters';
  E_Inv_Custom_DML = 'Ge�ersiz �zg�n DML alan� referans�: %s'; //Invalid custom DML column reference: %s';
  E_Record_Not_Located_For_Update = 'Kay�t g�ncelle�tirme i�in konumlanmam��'; //Record was not located to update';
  E_Record_Not_Located_For_Delete = 'Kay�t silme i�in konumlanmam��'; //Record was not located to delete';
  E_Init_Default_SQL_Failed = '%s varsay�lan de�eri ile ba�lat�lam�yor'; //Unable to initialize default %s';
  E_Stringlist_Not_Sorted = 'Stringlist bu i�lem i�in s�ralanm�� olmal�'; //Stringlist must be sorted for this operation';
  E_Cannot_Change_Events = 'Olay s�re�te iken de�i�tirilemez'; //Cannot change events while processing';
  E_Cannot_Unregister_Events = 'Olay s�re�te iken ge�ersiz hale getirilemez'; //Cannot unregister events while processing';
  E_Invalid_Internal_Transaction = 'Ge�ersiz i�sel IB_Transaction'; //Invalid Internal IB_Transaction';
  E_InvalidStatementType = 'Ge�ersiz komut tipi'; //Invalid statement type';
  E_Multiple_Records_Updated = '�oklu kay�t g�ncelle�trildi'; //Multiple records updated';
  E_Multiple_Records_Deleted = '�oklu kay�t silindi'; //Multiple records deleted';
  E_Multiple_Records_Inserted = '�oklu Kay�t Eklendi';
  E_DUP_DB_NAME = 'Ayn� veri taban� ad� kullan�lamz'; //Duplicate DatabaseName not allowed';
  E_INVALID_DB_NAME = 'Ge�ersiz veri taban� ad�'; //Invalid DatabaseName';
  E_UnableToSearch_NoOrdering = 'Arama yap�lam�yor. S�ralama tan�ml� de�il'; //Unable to perform search, no ordering defined';
  E_UnableToSearch_DatasetBusy = 'Arama yap�lam�yor. Veri k�mesi veri toparl�yor'; //Unable to perform search, dataset is busy fetching data';
//  E_UnableToSearch = 'Arama ger�ekle�tirilemeiyor'; //Unable to perform search';
  E_NoRecordsFound = 'Hi�bir kay�t bulunamad�'; //No records found';
  E_Session_Undefined = 'Oturum(Session) tan�ms�z'; //Session is undefined';
  E_NoCircularRef = 'D�ng�sel ba�vuru'; //Circular reference not allowed';
  E_InvalidClassType = 'Ge�ersiz s�n�f(class) tipi'; //Invalid class type';
  E_Invalid_RowNum = 'Ge�ersiz Kay�t No'; //Invalid RowNum';
  E_Invalid_Syntax = 'Ge�ersiz s�z dizimi: Fazla veya eksik parantez'; //Invalid syntax: extra or missing parenthesis';
  E_Array_Is_Null = 'Dizi Bo�(Null)'; //Array is Null';

  E_Cannot_add_blank_account = 'Bo� kullan�c� eklenemez'; //Cannot add blank account';
  E_Cannot_add_SYSDBA_account = 'SYSDBA kullan�c�s� eklenemez'; //Cannot add SYSDBA account';
  E_Cannot_delete_blank_account = 'Bo� kullan�c� silinemez'; //Cannot delete blank account';
  E_Cannot_delete_SYSDBA_account = 'SYSDBA kullan�c�s� silinemez'; //Cannot delete SYSDBA account';
  E_Cannot_modify_blank_account = 'Bo� kullan�c� d�zenlenemez'; //Cannot modify blank account';

  E_PLAN_ERROR = 'PLAN HATASI'; //PLAN ERROR!';
  E_PLAN_EXCEPTION = 'PLAN �ST�SNASI'; //PLAN EXCEPTION!';

  E_INV_CREATE_CONNECT_DROP = 'Ge�ersiz CREATE, CONNECT veya DROP DATABASE s�zdizimi'; //DROP DATABASE Invalid CREATE, CONNECT or DROP DATABASE syntax';
  E_Unsupported = 'Desteklenmiyor'; //Unsupported';
  E_NotImplemented = 'Bu seviyede uyarlanmad�'; //Not implemented at this level';
  E_Invalid_ColData = 'Ge�ersiz alan verisi'; //Invalid ColData';

  E_Cant_Unprepare_executing_process = 'Y�r�t�len s�re� haz�rl��� iptal edilemez'; //Cannot Unprepare an executing process';
  E_FileName_Required = 'Dosya ad� girilmeli'; //Filename is required';

 { Labels for various default dialogs used in IBO }

  //IBF_Users
  L_USERS_FRM = 'Kullan�c� Hesab� Y�netimi'; //User Account Management';
  L_USERS_ADD = 'Ekle'; //Add';
  L_USERS_DELETE = 'Sil'; //Delete';
  L_USERS_MODIFIY = 'De�i�tir'; //Modify';
  L_USERS_ACCOUNT = 'KULLANICI'; //ACCOUNT';
  L_USERS_PASSWORD = '�ifre'; //Password';
  L_USERS_GROUP = 'Grup'; //Group';
  L_USERS_FIRSTNAME = 'Ad�'; //First Name;
  L_USERS_MIDDLENAME = 'Orta Ad�'; //Middle Name;
  L_USERS_LASTNAME = 'Soyad�'; //Last Name';

//IBF_Export
  L_EXPORT_FRM = 'Veri Ver'; //Export';
  L_EXPORT_ASCII = ' Dosya Format�'; //File Format ';
  L_EXPORT_FIXED = 'TXT Sabit Kay�t Geni�li�i'; //TXT Fixed Record Width';
  L_EXPORT_DELIMITED = 'CSV S�n�rland�r�lm��'; //CSV Delimited';
  L_EXPORT_DBF	= 'DBF (Hala test a�amas�nda)'; //DBF  (Still needs some testing)';
  L_EXPORT_ASCIIOPT  = ' ASCII Se�enekleri'; //ASCII Options ';
  L_EXPORT_DELIMITER  = 'S�n�rlay�c�'; //Delimiter';
  L_EXPORT_SEPARATOR  = 'Ayra�'; //Separator';
  L_EXPORT_DATEFORMAT  = 'Tarih Bi�imi'; //Date Format';
  L_EXPORT_INCLUDEHEADERS  = 'Ba�l�klar� Dahil Et'; //Include Headers';
  L_EXPORT_INCLUDECRLF	= 'CRLF''i Dahil Et'; //Include CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Aktar'; //Export';
  L_EXPORT_SDEXPORTFILTERCSV = 'Virg�l ile Ayr�lm�� Tekst dosyalar� ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Text Dosyalar� ( *.TXT )|*.TXT'; //Text Files ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'DBF Dosyalar� ( *.DBF )|*.DBF'; //DBF Files ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = '�ptal etmek istedi�inizden emin misiniz?'; //Are you sure you want to abort?';
  M_Fetching_Query_Results = 'Sorgu Sonucu Al�n�yor'; //Fetching Query Results';
  M_Row_Num = 'Kay�t No: %d'; //Row# %d';
  M_Abort_Fetching_Btn = '�ptal'; //Abort';

  M_Login_Database = 'Veritaban�'; //Database';
  M_Login_User = 'Kullan�c�'; //User';
  M_Login_Password = '�ifre'; //Password';
  M_Login_OK_Btn = 'Tamam'; //OK';
  M_Login_Cancel_Btn = '�ptal'; //Cancel';
  M_Login_Help_Btn = '&Yard�m'; //&Help';
  M_Login_Dialog_Caption = 'Giri� Ekran�'; //Login Dialog';

  M_Loading_Caption = 'Y�kleniyor...'; //Loading...';

  M_SB_REC_CNT = 'Kay�t Say�s�: %d'; //Records counted: %d';
  M_Save_Changes = 'De�i�iklikler kaydedilsin mi?'; //Save changes?';
  M_Abort_Changes = 'Yap�lan de�i�iklikler ge�ersiz olacak. Devam edilsin mi?'; //Changes will be lost. Ok to proceed?';

  M_CancelTransactionPrompt =  'Yap�lan t�m de�i�iklikler iptal edilsin mi?'; //'Are you sure you want to cancel all changes?';
    
  M_SCRIPT_ABORT_EXECUTE = 'Bu komutun y�r�t�m� kesilsin mi?'; //Abort execution of this script?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Komut y�r�t�m�ne devam?'; //Continue executing this script?';
  M_SCRIPT_IS_EXECUTING = 'Komut halen y�r�t�l�yor'; //Script is currently executing';
  M_SCRIPT_FAILED = 'Komut y�r�t�m� tamamlanamad�'; //Script failed to complete';
  M_SCRIPT_WAS_ABORTED = 'Komut y�r�t�m� iptal edildi'; //Script execution was aborted';
  M_SCRIPT_COMPLETED = 'Komut y�r�t�m� istinas�z tamamland�'; //Script completed without exceptions';
  M_SCRIPT_CMPL_EXCEPT = 'Komut y�r�t�m� istisnalar ile tamamland�'; //Script completed with exceptions';
  M_SCRIPT_MODIFIED = 'De�i�iklik'; //Modified';
  M_SCRIPT_SAVE_CHANGES = 'De�i�iklikler kaydedilsin mi?'; //Save changes?';

{ Button captions }

  C_BTN_TODAY = 'Bug�n'; //Today';
  C_BTN_CLEAR = 'Temizle'; //Clear';
  C_BTN_FIND = 'Bul'; //Find';
  C_BTN_FINDNEXT = 'Sonrakini Bul'; //Find Next';
  C_BTN_REPLACE = 'De�i�tir'; //Replace';
  C_BTN_UNDO = 'Geri Al'; //Undo';
  C_BTN_CUT = 'Kes'; //Cut';
  C_BTN_COPY = 'Kopyala'; //Copy';
  C_BTN_PASTE = 'Yap��t�r'; //Paste';
  C_BTN_DELETE = 'Sil'; //Delete';
  C_BTN_SELECTALL = 'T�m�n� Se�'; //Select All';

  C_SG_Parameter = 'Parametre'; //Parameter';
  C_SG_Field = 'Alan'; //Field';
  C_SG_Name = '�sim'; //Name
  C_SG_Type = 'Tipi'; //Type';
  C_SG_Info = 'Bilgi'; //Info';
  C_SG_Value = 'De�er'; //Value';

  C_BF_OK = 'Tamam'; //OK';
  C_BF_CANCEL = '�ptal'; //Cancel';
  C_BF_CANCEL_ACCEL = '�&ptal'; //'&Cancel';
  C_BF_APPLY = 'Uygula'; //Apply';
  C_BF_HELP = 'Yard�m'; //Help';
  C_BF_EXECUTE = 'Y�r�t'; //Execute';
  C_BF_CLOSE = 'Kapat'; //Close';
  C_BF_CLOSE_ACCEL = '&Kapat'; //&Close';
  C_BF_FINISH = 'Bitir'; //Finish';
  C_BF_FINISH_ACCEL = '&Bitir'; //&Finish';

  C_FRM_Ordering = 'S�ralama'; //Ordering';
  C_FRM_RESTRUCTURE = 'G�r�n�r Alanlar� �zg�nle�tir'; //Customize Fields Displayed';

  C_CB_WordWrap = 'Metni Kayd�r'; //Word Wrap';

  // IBF_SQL
  M_SQL_RowsAffected = 'Etkilenen Kay�t'; //'RowsAffected: ';
  M_SQL_RowsCounted = 'Kay�t Say�s�:'; //Rows Counted: ';
  M_SQL_SessionBusy = 'Oturum �u anda me�gul'; //Session is currently busy';
  M_SQL_CompleteTransaction = 'L�tfen aktar�m�n�z� tamamlay�n'; //Please complete your transaction';
  M_SQL_CannotDeleteDefaultGroup = 'Varsay�lan grup silinemez'; //The default group cannot be deleted';
  M_SQL_ReservedName = 'Bu ad ayr�lm��'; //This name is reserved: ';
  M_SQL_BackSlashNotAllowed = 'Ters b�l�m i�areti kullan�lamaz'; //A back slash is not allowed';
  M_SQL_BlankNameNotAllowed = 'Ad bo� olamaz'; //A blank name is not allowed';
  M_SQL_RowsFetched = 'Toparlanan Kay�t:'; //Rows Fetched: ';
  M_SQL_ConfirmDBCreation = 'Bu veritaban� yarat�ls�n m�?'; //Are you sure you want to create this database?';
  M_SQL_ConfirmNoOtherDBSameName = 'L�tfen ayn� isimli ba�ka bir veri taban� olmad���ndan emin olun'; //Please make sure that no database exists with the same name.';
  M_SQL_ConfirmDBDrop = 'Bu veritaban�n� silmek istedi�iniden emin misiniz?'; //Are you sure you want to drop this database?';
  M_SQL_ReConfirmDBDrop = 'Bu veri taban� kal�c� olarak kald�r�lacakt�r'+#13+#10+#13#10'Devam edilsin mi?'; //This database will be permanently removed.'+#13#10+#13#10'Continue anyway?';
  M_SQL_AskFormName = 'Sorgu Formu Ad�:'; //Enter query form name:';
  M_SQL_AskGroupName = 'Grup Ad�:'; //Enter group name:';
  M_SQL_AskLayoutName = 'Yerle�im Ad�:'; //Enter layout name:';
  M_SQL_ConfirmGroupDeletion = '%s grubu t�m alt elemanlar� ile birlikte silinsin mi?'; //Are you sure you want to delete the %s group including all child items?';
  M_SQL_ConfirmLayoutDeletion = '%s yerle�imi silinsin mi?'; //Are you sure you want to delete the %s layout?';
  M_SQL_RecursiveCopyNotAllowed = 'D�ng�sel kopyalama yap�lamaz'; //Recursive copy not allowed';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Bir elemana �ift t�klayan veya bir eleman se�ili iken enter a bas�n'; //Double click an item or press enter with an item selected.';
  M_GCSQL_ParameterValue = 'Parametre De�eri'; //Parameter value';
  M_GCSQL_TypeAValueFor = '%s i�in bir de�er girin'; //Type a value for %s';
  M_GCSQL_ProcedureWithoutParams = 'Bu y�nteme ait parametre yok'; //This procedure does not have input parameters.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Veri al�m� devam ediyor'; //Data Pump process is still active.';
  M_DP_ARE_YOU_SURE = 'Emin misiniz?'; //Are you sure?';
  M_DP_SELECT_SOURCE_DB = 'Kaynak veri taban�n� se�in';//Select Source Database';
  M_DP_SELECT_DEST_DB = 'Hedef veri taban�n� se�in'; //Select Destination Database';

  // IBF_USERS
  C_BTN_USERS_OK = 'Tamam'; //Ok';
  C_BTN_USERS_CLEAR = 'Temizle'; //Clear;
  M_USERS_COMPLETED_OK = '��lem ba�ar�yla tamamland�'; //Operation completed Successfully';
  M_USERS_NO_CONNECTION = 'Tan�ml� IB_Connection yok'; //No IB_Connection defined.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'S�ralama alanlar� atans�n m�?'; //Assign ordering items?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Veriyi Aktar'; //Begin Export';
  M_EXPORT_STILL_ACTIVE = 'Export process is still active.';

  // IB_UtilityBar
  C_wbBrowseBtnHint	= 'Veritaban�n� Tara'; // Browse Database';
  C_wbBrowseBtnCaption	= 'Taray�c�'; //Browse';
  C_wbDSQLBtnHint	= 'Veritaban�nda bir komut y�r�t'; //Execute Statement In Database';
  C_wbDSQLBtnCaption	= 'DSQL';
  C_wbEventsBtnHint	= 'Veriatab�n� olaylar�n� izle'; //Monitor Database Events';
  C_wbEventsBtnCaption	= 'Olaylar'; //Events';
  C_wbExportBtnHint	= 'Veritaban�ndan veri k�mesini d��a aktar'; //Export Dataset From Database';
  C_wbExportBtnCaption	= 'Veri Ver'; //Export';
  C_wbDumpBtnHint	= 'T�m veritaban�n� aktar'; //Dump Database';
  C_wbDumpBtnCaption	= 'Aktar'; //Dump';
  C_wbPumpBtnHint	= 'Ba�ka bir veritaban�ndan veri al'; //Pump Data From Another Database';
  C_wbPumpBtnCaption	= 'Veri Al'; //Pump';
  C_wbWhoBtnHint	= 'Veri taban�na kimler ba�l�'; //See Who is Connected to the Database';
  C_wbWhoBtnCaption	= 'Kim'; //Who';
  C_wbScriptBtnHint	= 'K�sa komut y�r�t'; //Execute Script';
  C_wbScriptBtnCaption	= 'Komut'; //Script';
  C_wbExtractBtnHint	= 'Veri tan�mla dilini (DDL) ��kar'; //Extract DDL';
  C_wbExtractBtnCaption = 'DDL ��kar'; //Extract';
  C_wbMonitorBtnHint	= 'SQL ve API �a�r�lar�n� izle'; //Trace SQL and API Calls';
  C_wbMonitorBtnCaption = 'Monit�r'; //Monitor';
  C_wbProfilerBtnHint	= 'Veri taban� aktivitelerinin profili'; //Profile Database Activity';
  C_wbProfilerBtnCaption= 'Profil'; //Profile';
  C_wbStatusBtnHint	= 'IBO Bile�enlerinin durumu'; //View Status of IBO Components';
  C_wbStatusBtnCaption	= 'Durum'; //Status';
  C_wbUsersBtnHint	= 'Veri taban� sunucusundaki kullan�c�lar�n y�netimi'; //Administer Users for a Database Server';
  C_wbUsersBtnCaption	= 'Kullan�c�'; //User';

  // Array grid
  C_AG_Row	       = 'Sat�r'; //Row';
  C_AG_Column	       = 'S�tun'; //Column';

  //IBF_Who
  C_WHO_FRM	       = 'Ba�l� Kullan�c�lar'; //Who is connected';
  C_WHO_BTNAPPLY       = 'G�ncelle'; //Refresh';

  C_NB_FIRST = '�lk kay�t'; //First';
  C_NB_PRIOR = '�nceki kay�t'; //Prior';
  C_NB_NEXT = 'Sonraki kay�t'; //Next';
  C_NB_LAST = 'Son kay�t'; //Last';

  C_ST_Open = 'A�'; //Open';
  C_ST_Close = 'Kapat'; //Close';
  C_ST_Prepare = 'Haz�rla'; //Prepare';
  C_ST_Unprepare = 'Haz�rl�k iptal'; //Unprepare';
  C_ST_ReadOnly = 'Salt okunur'; //Read Only';
  C_ST_New = 'Yeni kay�t'; //New';
  C_ST_Post = 'Kaydet'; //Post';
  C_ST_Cancel = '�ptal'; //Cancel';
  C_ST_Delete = 'Sil'; //Delete';
  C_ST_Edit = 'D�zenle'; //Edit';
  C_ST_RefreshKeys = 'Anahtar g�ncelle'; //Refresh Keys';
  C_ST_RefreshRows = 'Kay�tlar� g�ncelle'; //Refresh Rows';
  C_ST_Refresh = 'G�ncelle'; //Refresh';

{ Hints }

  H_UB_EDIT = 'Kayd� d�zenle'; //Edit Row';
  H_UB_INSERT = 'Kay�t ekle'; //Insert Row';
  H_UB_DELETE = 'Kayd� sil'; //Delete Row';
  H_UB_REFRESH = 'T�m kay�tlar� g�ncelle'; //Refresh all records';
  H_UB_REFRESHKEYS = 'Kay�t anahtarlar�n� g�ncelle'; //Refresh record keys';
  H_UB_REFRESHROWS = 'Kay�t sat�rlar�n� g�ncelle'; //Refresh record rows';
  H_UB_REFRESHFILTROWS = 'S�z�lm�� kay�tlar� g�ncelle'; //Refresh filtered rows';
  H_UB_POSTSEARCH = 'Arama kriterlerini uygula'; //Post search criteria';
  H_UB_CANCELSEARCH = 'Arama kriterlerini iptal et'; //Cancel search criteria';
  H_UB_POSTEDIT = 'D�zenlemeleri kaydet'; //Post edits';
  H_UB_CANCELEDIT = 'D�zenlemeleri iptal et'; //Cancel edits';
  H_UB_POSTINSERT = 'Yeni kayd� kaydet'; //Post insert';
  H_UB_CANCELINSERT = 'Yeni kayd� iptal et'; //Cancel insert';
  H_UB_POSTDELETE = 'Silmeyi onayla'; //Post delete';
  H_UB_CANCELDELETE = 'Silmeyi iptal et'; //Cancel delete';
  H_UB_POST = 'De�i�iklikleri kaydet'; //Post changes';
  H_UB_CANCEL = 'De�i�iklikleri iptal et'; //Cancel changes';

  H_NB_FIRST = '�lk kay�t'; //First Row';
  H_NB_PRIOR = '�nceki kay�t'; //Prior Row';
  H_NB_NEXT = 'Sonraki kay�t'; //Next Row';
  H_NB_LAST = 'Son kay�t'; //Last Row';
  H_NB_JUMPBCK = 'H�zl� geri'; //Backwards';
  H_NB_JUMPFWD = 'H�zl� ileri'; //Forwards';

  H_SB_ORDER = 'Veri k�mesini s�rala'; //Order Rows in Dataset';
  H_SB_LAST_CRITERIA = 'Son arama kriterini tekrarla'; //Recall Last Search Criteria';
  H_SB_SEARCH = 'Veri k�mesinde ara'; //Search Dataset';
  H_SB_SAVE_CRITERIA = 'Kriteri sakla'; //Save Criteria';
  H_SB_CLEAR_CRITERIA = 'Kriteri temizle'; //Clear Criteria';
  H_SB_RECALL_CRITERIA = 'Kriteri tekrarla'; //Recall Criteria';
  H_SB_SEARCHCOUNT = 'Veri k�mesindeki kritere uyan kay�tlar� say'; //Count Rows in Dataset Matching Criteria';
  H_SB_COUNT = 'Veri k�mesindeki kay�tlar� say'; //Count Rows in Dataset';
  H_SB_RESTRUCTURE = 'G�r�n�r Alanlar� �zg�nle�tir'; //Customize the Fields Displayed';

  H_TB_StartTransaction = 'Aktar�ma ba�la'; //Start Transaction';
  H_TB_PostDatasets = 'Veri k�melerini sakla'; //Post Datasets';
  H_TB_CancelDatasets = 'Veri k�melerini iptal et'; //Cancel Datasets';
  H_TB_SavePoint = 'Mevcut aktar�m� i�le ve al�koy'; //Commit and Retain Current Transaction';
  H_TB_CommitRetain = 'Veri k�melerini kaydet, mevcut aktar�m� i�le ve al�koy'; //Post Datasets and Commit and Retain Current Transaction';
  H_TB_Commit = 'Mevcut aktar�m� i�le ve sonland�r'; //Commit and End Current Transaction';
  H_TB_Rollback = 'Mevcut aktar�m� geri al ve sonland�r'; //Rollback and End Current Transaction';
  H_TB_RollbackRetain = 'Mevcut aktar�m� geri al ve al�koy'; //Rollback and Retain Current Transaction';
  H_TB_Close = 'Mevcut aktar�m� kapat'; //Close Current Transaction';

  H_ST_Prepare_Statement = 'Komutu haz�rla'; //Prepare Statement';
  H_ST_Unprepare_Statement = 'Komut haz�rl��� iptal'; //Unprepare Statement';
  H_ST_Execute_Statement = 'Komutu y�r�t'; //Execute Statement';

  H_DS_Open_Dataset = 'Veri k�mesini a�'; //Open Dataset';
  H_DS_Close_Dataset = 'Veri k�mesini kapat'; //Close Dataset';
  H_DS_Prepare_Dataset = 'Veri k�mesini haz�rla'; //Prepare Dataset';
  H_DS_Unprepare_Dataset = 'Veri k�mesi haz�rl��� iptal'; //Unprepare Dataset';
  H_DS_ReadOnly_Dataset = 'Salt okunur veri k�mesi'; //Read Only Dataset';

  H_CB_Create_Database = 'Veri taban�n� yarat'; //Create Database';
  H_CB_Connect_Database = 'Veri taban�na ba�lan'; //Connect Database';
  H_CB_Disconnect_Database = 'Veri taban� ba�lant�s�n� kes'; //Disconnect Database';
  H_CB_Drop_Database = 'Veri taban�n� sil'; //Drop Database';

  H_RD_actHide = 'Se�ili alanlar� gizle'; //Hide selected Fields';
  H_RD_actHideAll = 'T�m alanlar� gizle'; //Hide all Fields';
  H_RD_actVisible = 'Se�ili alanlar� g�ster'; //Set selected fields visible';
  H_RD_actVisibleAll = 'T�m alanlar� g�ster'; //Set all selected fields visible';
  H_RD_actUp = 'Se�ili alanlar� bir �ste ta��'; //Move selected fields one up';
  H_RD_actTop = 'Se�ili alanlar� en �ste ta��'; //Move selected fields to the top';
  H_RD_actDown = 'Se�ili alanlar� bir alta ta��'; //Move selected fields one down';
  H_RD_actBottom = 'Se�ili alanlar� en alta ta��'; //Move selected fields to the bottom';

  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'SELECT komutundan veri ver'; //Export from SELECT statement';

  // Error Messages - IB_Import
  eNoAsciiFileEnty	     = 'Ascii dosyas� i�in eksik giri�'; //Missing entry for Ascii file';
  eNoDestTableEntry	     = 'Hedef tablo i�in eksik giri�'; //Missing entry for destination table';
  eAsciiFileNotFound	     = '%s Ascii dosyas� bulunamda�'; //Ascii file %s not found';
  eIniFileNotFound	     = '%s Ini dosyas� bulunamad�'; //Ini-file %s not found';
  eNoAsciiFileAccess	     = '%s Ascii dosyas� a��lam�yor'; //Could not open ascii file %s';
  eInvalidCharFound	     = 'Ascii dosyada ge�ersiz karakter/bi�im hatas�'; //Invalid char / format error in ascii file';
  eOutOfMemory		     = 'Yetersiz haf�za'; //Out of memory';
  eFieldDescriptionError     = 'Alan tan�mlar�nda hata'; //Error in field description';
  eWrongAsciiFieldCount      = 'Ascii dosyada hatal� alan say�s�'; //Wrong field count in ascii file';
  eWrongDecimalCount	     = 'Alan listesi (%s)''de hatal� ondal�k say�s�'; //Wrong decimal count in fieldlist (%s)';
  eWrongFieldWidth	     = 'Ascii dosyada hatal� alan uzunlu�u'; //Wrong field width in ascii file';

  // Dialog Labels - IB_Import

  lblRecsReadedCaption	     = 'Okunan Kay�t'; //Total Records read';
  lblRecsCommentedCaption    = 'Yorumlanan Kay�t'; //Records commented';
  lblRecsInsertedCaption     = 'Eklenen Kay�t'; //Records inserted';
  btnAbortImportCaption      = '�ptal'; //Abort';

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
