
{                                                                               }
{ IB_Constants-pl                                                               }
{                                                                               }

{****************************************************************}
{                                                                }
{          IB Objects - Biblioteka komponentów                   }
{                                                                }
{          Copyright (C) 1996-2001 Jason Wharton                 }
{          and Computer Programming Solutions, Mesa, AZ          }
{                                                                }
{  Ten plik Ÿród³owy jest rozpowszechniany na licencji zaufania  }
{  CPS Trustware.                                                }
{  Plik ten mo¿e byæ ropzowszechniany w postaci Ÿród³owej lub    }
{  skompilowanej tylko zgodnie z warunkami przedstawionymi w     }
{  licencji zaufania CPS Trustware License. Treœæ licencji       }
{  jest dostêpna pod adresem:                                    }
{               http://www.ibobjects.com/ibo_trustware.html      }
{                                                                }
{****************************************************************}

{******************************************************************************}
{  LISTA MODYFIKACJI                                                           }
{  Modyfikacje w stosunku do orygina³u prosimy wymieniaæ poni¿ej w formacie:   }
{                                                                              }
{  Jan Kowalski <jan@jankowalski.com>                                          }
{  mm/dd/rrrr                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Jan Kowalski                                   }
{                                                                              }
{------------------------------------------------------------------------------}
{  Prosimy umieszczaæ wszelkie informacje na temat modyfikacji                 }
{  w sekcji poni¿ej tego nag³ówka                                              }
{------------------------------------------------------------------------------}
{  Miroslaw Snietura <snietura@alpha.pl>                                       }
{  03/15/2002								       }
{     Polskie t³umaczenie zasobów IB Objects                                   }
{     Wszelkie sugestie i informacje o b³êdach s¹ mile widziane 	       }
{  04/23/2003							               }
{     Kolejne t³umaczenie na jêzyk polski nowych sta³ych dodanych 	       }
{     w wersji 4.2.Id    						       }
{									       }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Constants;

interface

var
// To jest nazwa u¿ywanego InterBase Client DLL (API).
// U¿yj IB_Session511.pas jako pierwszy wpis w klauzuli uses twojego projektu
// aby zmieniæ wartoœæ zmiennej tak aby u¿ywana by³a alternatywna biblioteka kliencka GDS32.DLL
  IB_GDS32: string = 'gds32.dll';

const
// To jest znacznik u¿ywany do okreœlania czy b³¹d w InterBase zosta³ poprawiony
// tak, ¿e mo¿na u¿ywaæ zoptymalizowanej sk³adni wywo³añ.
  BUG_EXEC2 = true;

// Informacje o wersji
  IB_VERSION_MAJOR = '4';
  IB_VERSION_MINOR = '2';
  IB_VERSION_BUILD = 'I';
  IB_VERSION_SUB_RELEASE = 'd';
  
  IB_BASEKEY = 'Software\CPS\IBO';

// Ustawienia wewnêtrzne
  IB_RDB = 'RDB$';
  IB_DB_KEY = 'DB_KEY';

// Sk³adnia parametrów
  IB_BINDLINK = 'BIND_';
  IB_MASTERLINK = 'MLNK_';
  IB_KEYLINK = 'KLNK_';
  IB_ORDLINK = 'OLNK_';
  IB_PARAMETER = 'PRM_';
  IB_QBE_PARAMETER = 'QBE_';
  IB_LOCATE_PARAMETER = 'LOC_';
  IB_RNGBEG = 'RBEG_';
  IB_RNGEND = 'REND_';

// Zanczniki ogólne
  IB_TRUE = 'TRUE';
  IB_FALSE = 'FALSE';
  IB_AND = #13#10'  AND ';

// Nazwy parametrów po³¹czenia ( Prosimy nie t³umaczyæ )
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
  IB_SQL_ROLE_NAME_     = 'SQL ROLE NAME'; // Ustawienie wychodzi z u¿ytku
  IB_ROLE_NAME          = 'ROLE NAME';
  IB_ROLE_              = 'ROLE';          // Ustawienie wychodzi z u¿ytku

// Wartoœci parametrów po³¹czenia
  IB_PROTOCOL_LOCAL    = 'LOCAL';
  IB_PROTOCOL_NETBEUI  = 'NETBEUI';
  IB_PROTOCOL_TCP_IP   = 'TCP/IP';
  IB_PROTOCOL_NOVELL   = 'NOVELL';
  IB_DB_KEY_SCOPE_CONN = 'CONNECTION';
  IB_DB_KEY_SCOPE_TRAN = 'TRANSACTION';

// Ustawienia aliasów BDE
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

// Ustawienia aliasów BDE
  BDE_SHARED_AUTOCOMMIT      = 'SHARED AUTOCOMMIT';	
  BDE_SHARED_NOAUTOCOMMIT    = 'SHARED NOAUTOCOMMIT';
  BDE_NOT_SHARED             = 'NOT SHARED';


// Ró¿ne ustawienia dla w³asnoœci ColumnAttributes.
  IB_BINARY      = 'BINARY';     // Traktuj kolumnê CHAR lub VARCHAR jako binarn¹.
  IB_BLANKISNULL = 'BLANKISNULL';// U¿ywane przez klasê TIB_Column podczas przypisywania
                                 // pustego ci¹gu do zmiennej Fields.
  IB_BOOLEAN     = 'BOOLEAN';    // Wartoœæ u¿ywana do okreœlania kolumny
                                 // jako boolean.
  IB_COMPUTED    = 'COMPUTED';   // Wskazuje czy kolumna jest wyliczana jako
                                 // COMPUTED BY.
  IB_CURRENCY    = 'CURRENCY';   // Czy kolumna zawiera kwotê pieniê¿n¹.
  IB_NOCASE      = 'NOCASE';     // Wyszukiwanie bez brania pod uwagê wielkoœci liter
  IB_NODATE      = 'NODATE';
  IB_NOSOUNDEX   = 'NOSOUNDEX';  // Wy³¹cza przetwarzanie soundex w zbiorze danych
  IB_NOTIME      = 'NOTIME';
  IB_NOTRAILING  = 'NOTRAILING'; // Flaga u¿ywania STARTING w odniesieniu do ³añcuchów znakowych
  IB_NOTREQUIRED = 'NOTREQUIRED';
  IB_REQUIRED    = 'REQUIRED';
  IB_SOUNDEX     = 'SOUNDEX';    // Flaga ustawiaj¹ca przeszukiwanie pola SoundEx
  IB_BCD         = 'BCD';        // Ustawienie kolumny jako TIBOBCDField
  IB_NOBCD       = 'NOBCD';      // Ustawienie kolumny jako TIBOFloatField
  IB_YESCASE     = 'YESCASE';    // Flaga nadpisywania CN.DefaultNoCase
  IB_YESLIKE     = 'YESLIKE';    // Flaga u¿ywania LIKE na ³añcuchach znaków
  IB_YESTRAILING = 'YESTRAILING';// Flaga nadpisywania CN.DefaultNoTrailing

// U¿ywane przez SearchPanel w³aœciwoœæ FieldsReadOnly.
  IB_NOINSERT = 'NOINSERT';
  IB_NOEDIT   = 'NOEDIT';
  IB_NOSEARCH = 'NOSEARCH';

// Zdarzenia
  IB_MaxEvents = 15;
  IB_EventLength = 64;

// Sesje
  IB_ISC_ERR_CODE_MSG = 'ISC ERROR CODE:';
  IB_ISC_ERR_MSG_MSG  = 'ISC ERROR MESSAGE:';
  IB_SQL_ERR_CODE_MSG = 'SQL ERROR CODE:';
  IB_SQL_ERR_MSG_MSG  = 'SQL ERROR MESSAGE:';

// Globalne ustawienia domyœlne  ( NIE t³umaczyæ )
  G_DefaultRowHeight = 17;

  DTEncode_DateDelimit     = '/';
  DTEncode_TimeDelimit     = ':';
  DTEncode_DateTimeDelimit = ' ';
  DTEncode_DecodeFormat    = '%.4u/%.2u/%.2u %.2u:%.2u:%.2u.%.3u0';
  DTEncode_DateTimeFormat  = 'YYYY"/"MM"/"DD" "HH":"NN":"SS".0000"';
  DT_DateFormat            = 'MM"/"dd"/"yyyy';
  DT_TimeFormat            = 'hh":"nn":"ss';

{ Od tego miejsca mo¿na t³umaczyæ. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'Dziêkujê za przetestowanie IB Objects.'#13#10#13#10'Proszê odwiedziæ witrynê http://www.ibobjects.com i dokonaæ rejestracji.';

{ Sta³e b³êdów dla IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Po³¹czenie zosta³o utworzone';
  E_NOT_CONNECTED     = 'Po³¹czenie nie zosta³o utworzone';
  E_Invalid_conn_path = 'Nieprawid³owa œcie¿ka po³¹czenia';
  E_Cant_Repl_Int_Tr  = 'Domyœlnie nie mo¿na zamieniæ wewnêtrznej transakcji';
  E_NO_TRANS_STARTED  = 'Transakcja nie zosta³a rozpoczêta';
  E_TRANS_STARTED     = 'Transakcja zosta³a rozpoczêta';
  E_NO_CONNECTIONS    = 'Brak po³¹czenia podczas realizacji transakcji';
  E_NOT_ENOUGH_CONN   = 'Utrata jednego lub kilku po³¹czeñ podczas realizacji transakcji';
  E_CONN_LOADING      = 'Uwaga: realizacja po³¹czenia nadal trwa';
  E_TRANS_CONN_SESS   = 'Wszystkie po³¹czenia musz¹ nale¿eæ do tej samej IB_Session';
  E_TransactionPaused = 'Transakcja zosta³a wstrzymana';
  E_ALLOCATED         = 'Wyra¿enie zosta³o alokowane';
  E_NOT_ALLOCATED     = 'Wyra¿enia nie zosta³o alokowane';
  E_PREPARED          = 'Wyra¿enie zosta³o przygotowane';
  E_NOT_PREPARED      = 'Wyra¿enie nie zosta³o przygotowane';
  E_FAILED_TO_PREPARE = 'Próba przygotowania wyra¿enia nie powiod³a siê';
  E_OPENED            = 'Wyra¿enie zosta³o otwarte';
  E_NOT_OPENED        = 'Wyra¿enie nie zosta³o otwarte';
  E_CANT_DELETE       = 'Aktualnego rekordu kursora nie mo¿na usun¹æ';
  E_NO_CONNECTION     = 'Wyra¿enie musi mieæ przypisane IB_Connection';
  E_CONNECT_FAILED    = 'Nie mo¿na otworzyæ IB_Connection';
  E_NO_TRANSACTION    = 'Wyra¿enie musi mieæ przypisan¹ IB_Transaction';
  E_NO_ACTIVE_TRANS   = 'Brak aktywnej transakcji do wykonania';
  E_START_FAILED      = 'Nie mo¿na rozpocz¹æ transakcji';
  E_SVRAUTOCMT_NOEXP  = 'Transakcja typu explicit nie jest dozwolona w po³¹czeniu  z ServerAutoCommit';
  E_Cannot_Activate     = 'Nieprawid³owy stan transakcji. Nie mo¿na wprowadziæ zmian';  
  E_Transaction_Is_Active = 'Transakcja zawiera niewykonane zmiany';
  E_Failed_To_Post_Datasets = 'Próba uaktualnienia wszystkich zbiorów danych nie powiod³a siê';
  E_Failed_To_Cancel_Datasets = 'Próba cofniêcia zmian dla wszystkich zbiorów danych nie powiod³a siê';
  E_UpdateWrongTrn    = 'Nie mo¿na uaktualniæ - %s nie nale¿y do %s';
  E_NO_BLANK_SQL      = 'Puste wyra¿enia SQL nie s¹ dozwolone';
  E_AT_END_OF_FILE    = 'Koniec pliku';
  E_AT_END_OF_CURSOR  = 'Koniec kursora';
  E_AT_END_OF_BUFFER  = 'Koniec bufora';
  E_AT_END_OF_DATASET = 'Koniec zbioru danych';
  E_BAD_SQL_INF_LEN   = 'Niew³aœciwa d³ugoœæ isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Isc_dsql_sql_info zwróci³ nieprawid³owe dane';
  E_CURSOR_NAME_LOCK  = 'Nie mo¿na zmieniæ nazwy aktywnego kursora';
  E_REQUEST_LIVE_ACTIVE = 'Nie mo¿na zmieniæ w³asnoœci RequestLive w stanie aktywnym';
  E_REQUEST_LIVE_READONLY = 'Zbiór danych nie mo¿e mieæ jednoczeœnie w³asnoœci RequestLive i ReadOnly';
  E_CURSOR_UNI              = 'IB_CURSOR jest jednokierunkowy';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Nieobs³ugiwany typ kolumny: %d';
  E_FIELDNO_NOT_FOUND         = 'Nie znaleziono pola o numerze FieldNo: %d';
  E_FIELDNAME_NOT_FOUND        = 'Nie znaleziono pola o nazwie FieldName: %s';
  E_INVALID_FOCUS_RELATION_NO   = 'Nieprawid³owa aktywna relacja o numerze No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Nieprawid³owa aktywna relacja o nazwie Name: %s';
  E_INVALID_QBE_IN              = 'B³¹d syntaktyczny wyra¿enia IN( wartoœæ [ , wartoœæ ... ] )';
  E_INVALID_QBE_BETWEEN         = 'B³¹d syntaktyczny wyra¿enia BETWEEN wartoœæ AND wartoœæ';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Nie mo¿na znaleŸæ importu DLL o nazwie: %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Nieprawid³owa wartoœæ SQLKeyFields';
  E_GET_CURSOR_ERROR       = 'Nie mo¿na otworzyæ kursora bez danych kluczowych';
  E_SCROLL_ERROR           = 'Klucz rekordu zosta³ zgubiony'#10#13'Otwarcie kursora nie uda³o siê';
  E_INVALID_BUFFER_ROW_NUM = 'Nieprawid³owa wartoœæ pocz¹tkowa BufferRowNum';
  E_BLANK_STATEMENT      = 'Nie mo¿na przygotowaæ wyra¿enia pustego';
  E_UNKNOWN_STATEMENT   = 'Próba wykonania nieznanego wyra¿enia';
  E_CIRCULAR_REFERENCE = 'Odwo³ania pierœcieniowe nie s¹ dozwolone';
  E_CANT_CHG_WITH_CONN = 'Nie mo¿na dokonaæ zmian podczas aktywnego po³¹czenia';
  E_LOGIN_FAILED      = 'B³¹d autoryzacji';
  E_CANT_GET_CONN_CHR = 'Nie mo¿na uzyskaæ charakterystyki po³¹czenia';
  E_MAX_EVENTS_BLOCK  = 'Przekroczona liczba zdarzeñ dla jednego bloku';
  E_PROCESSING_EVENTS = 'Przetwarzanie zdarzeñ'#13#10'Nie mo¿na cofn¹æ rejestracji';
  E_CANT_STORE_BLOB  = 'Nie mo¿na zapisaæ zmiennej typu Blob lub ju¿ zosta³a zapisana';
  E_CANT_LOAD_BLOB   = 'Nie mo¿na za³adowaæ zmiennej typu Blob lub ju¿ zosta³a za³adowana';
  E_CANNOT_CANCEL_ROW = 'Nie mo¿na cofn¹æ zmian w aktualnym wierszu';
  E_CANNOT_POST_ROW  = 'Nie mo¿na zapisaæ aktualnego wiersza';
  E_DatasetClosed     = 'Zbiór danych jest nieaktywny';
  E_DatasetOpen        = 'Zbiór danych jest otwarty';
  E_DatasetCannotScroll = 'Nie mo¿na przegl¹daæ zbioru danych';
  E_DatasetReadOnly     = 'Zbiór danych jest otwarty tylko do odczytu';
  E_DatasetIsFetching    = 'Trwa pobieranie zbioru danych';
  E_Invalid_KeyRelation   = 'Nieprawid³owa wartoœæ KeyRelation';
  E_RowNum_Not_Implemented = 'Jeszcze nie zaimplementowano RowNum';
  E_RowDeleted            = 'Wiersz jest usuwany';
  E_END_OF_DATASET        = 'Koniec zbioru danych';
  E_BEGINNING_OF_DATASET   = 'Pocz¹tek zbioru danych';
  E_Cannot_Pessimistic_Lock = 'Nie mo¿na stosowaæ "pesymistycznego blokowania" z parametrem LockWait';
  E_Cannot_Edit_Row      = 'B³¹d przy próbie edycji aktualnego wiersza';
  E_Cannot_Insert_Row  = 'B³¹d przy próbie wstawienia nowego wiersza';
  E_Cannot_Delete_Row = 'B³¹d przy próbie usuniêcia aktualnego wiersza';
  E_Cannot_Search    = 'Przeszukiwanie nie jest dozwolone';
  E_Cannot_Navigate = 'B³¹d przy próbie nawigacji w obrêbie zbioru';
  E_Record_Locked    = 'Rekord zosta³ zablokowany przez innego u¿ytkownika';
  E_Record_OutOfSynch = 'Rekord zosta³ zmieniony przez innego u¿ytkownika';
  E_FLD_READONLY       = '%s jest tylko do odczytu';
  E_Required_Field       = '%s jest polem wymaganym';
  E_NO_POSTRTN_CACHED_UPDT = 'Nie mo¿na u¿ywaæ opcji PostRetaining z Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Wiele rekordów w zapytaniu typu singleton';
  
  E_InvalidRowsAffectedBuf = 'Nieprawid³owy bufor RowsAffected';
  E_Invalid_RowNum_Past_Eof = 'Nieprawid³owa wartoœæ RowNum za znacznikiem Eof';
  E_Invalid_RowNum_Before_Bof = 'Nieprawid³owa wartoœæ RowNum przed znacznikiem Bof';
  E_Invalid_Bookmark = 'Nieprawid³owy identyfikator zak³adki';
  
  E_Assign_Column  = 'Nie mo¿na przypisaæ z %s';
  E_AssignTo_Column = 'Nie mo¿na przypisaæ do %s';
  E_Value_Out_Of_Range = 'Wartoœæ spoza zakresu';
  E_SmallintOverflow = 'Przekroczenie zakresu liczby typu Smallint';
  E_IntegerOverflow = 'Przekroczenie zakresu liczby typu Integer';
  E_Int64Overflow = 'Przekroczenie zakresu liczby typu Int64';
  
  E_Unsupported_Column = 'Nieobs³ugiwany typ kolumny: %d';
  E_UndefinedMacro = 'Niezdefiniowane makro';
  E_GeneratorFailed = 'Nie mo¿na odczytaæ wartoœci generatora';
  
  E_MustBe_Buffered_Dataset = 'Wymagane jest dziedziczenie po TIB_BDataset (IB_Query)';
  
  E_NO_CHANGE_READONLY = 'Nie mo¿na zmieniæ w³aœciwoœci ReadOnly po uruchomieniu';
  E_NO_CHANGE_ISOLATION = 'Nie mo¿na zmieniæ w³aœciwoœci Isolation po uruchomieniu';
  E_NO_CHANGE_RECVERSION = 'Nie mo¿na zmieniæ w³aœciwoœci RecVersion po uruchomieniu';
  E_NO_CHANGE_LOCKWAIT = 'Nie mo¿na zmieniæ w³aœciwoœci LockWait po uruchomieniu';
  
  E_Invalid_Reference_To_Delete = 'Nieprawid³owe wskazanie dla funkcji Usuñ';
  E_Invalid_Typecast = 'Niew³aœciwe rzutowanie typu';
  E_Invalid_DataPump_Statement = 'Niew³aœciwy rodzaj wyra¿enia dla DataPump';
  E_FIELD_NOT_NULLABLE = 'Pole typu NOT NULL ustawione na wartoœæ NULL';
  E_DATABASE_BLANK = 'Parametr DatabaseName nie mo¿e byæ pusty';
  E_Unsupp_Col_Conversion = 'Nieobs³ugiwana konwersja typów miêdzy kolumnami';
  E_Unable_To_Locate_Record = 'Nie mo¿na znaleŸæ rekordu';
  E_Record_Not_Inserted = 'Nie wstawiono nowego rekordu';
  E_Invalid_KeyLinks = 'Niew³aœciwa wartoœæ KeyLinks: %s';
  E_Unable_to_perform_search = 'Nie mo¿na wykonaæ przeszukiwania';
  E_Unassigned_Blob_Node = 'Nieprzypisany BlobNode';
  E_Unassigned_Transaction = 'Nieprzypisana transakcja';
  E_Invalid_RowsAffected_Buffer = 'Nieprawid³owy bufor RowsAffected';
  E_Unable_Save_Graphic = 'Nie mo¿na zapisaæ obiektu Graphic';
  E_Cannot_Activate_Transaction = 'Nie mo¿na uaktywniæ transakcji';
  E_IB_Client_Not_Installed = 'Biblioteka InterBase Client GDS32.DLL nie zosta³a zainstalowana';
  E_Could_Not_Load_Memo = 'Nie mo¿na za³adowaæ zawartoœci pola Memo';
  E_Invalid_DPB_Over_255 = 'Nieprawid³owy DPB: Zawiera ponad 255 znaków';
  E_Inv_Custom_DML = 'Nieprawid³owa referencja do kolumny DML: %s';
  E_Record_Not_Located_For_Update = 'Nie znaleziono rekordu do uaktualnienia';
  E_Record_Not_Located_For_Delete = 'Nie znaleziono rekordu do usuniêcia';
  E_Init_Default_SQL_Failed = 'Nie mo¿na zainicjowaæ domyœlnego %s';
  E_Stringlist_Not_Sorted = 'Ta operacja wymaga posortowanej listy Stringlist';
  E_Cannot_Change_Events = 'Nie mo¿na zmieniaæ zdarzeñ podczas ich obs³ugi';
  E_Cannot_Unregister_Events = 'Nie mo¿na odrejestrowywaæ zdarzeñ podczas ich obs³ugi';
  E_Invalid_Internal_Transaction = 'Nieprawid³owa wewnêtrzna IB_Transaction';
  E_InvalidStatementType = 'Nieprawid³owy typ wyra¿enia';
  E_Multiple_Records_Updated = 'Zaktualizowano rekordy';
  E_Multiple_Records_Deleted = 'Usuniêto rekordy';
  E_Multiple_Records_Inserted = 'Wstawiono rekordy';
  E_DUP_DB_NAME = 'Identyczne wartoœci DatabaseName nie s¹ dozwolone';
  E_INVALID_DB_NAME = 'Nieprawid³owa wartoœæ w³aœciwoœci DatabaseName';
  E_UnableToSearch_NoOrdering = 'Nie mo¿na wykonaæ przeszukiwania, nie zdefiniowano sposobu porz¹dkowania danych';
  E_UnableToSearch_DatasetBusy = 'Nie mo¿na wykonaæ przeszukiwania, trwa pobieranie danych';
  E_NoRecordsFound = 'Nie znaleziono ¿adnego rekordu';
  E_Session_Undefined = 'Nie zdefiniowano sesji';
  E_NoCircularRef = 'Nie dopuszcza siê wzajemnych odwo³añ';
  E_InvalidClassType = 'Nieprawid³owy typ klasy';
  E_Invalid_RowNum = 'Nieprawid³owa wartoœæ RowNum';
  E_Invalid_Syntax = 'B³¹d sk³adni: dodatkowe lub brak nawiasów';
  E_Array_Is_Null = 'WskaŸnik do tablicy ma wartoœæ Null';
  
  E_Cannot_add_blank_account = 'Nie mo¿na dodaæ pustego konta';
  E_Cannot_add_SYSDBA_account = 'Nie mo¿na dodaæ konta administratora SYSDBA';
  E_Cannot_delete_blank_account = 'Nie mo¿na usun¹æ pustego konta';
  E_Cannot_delete_SYSDBA_account = 'Nie mo¿na usun¹æ konta administratora SYSDBA';
  E_Cannot_modify_blank_account = 'Nie mo¿na zmodyfikowaæ pustego konta';

  E_PLAN_ERROR = 'B£¥D PLANU!';
  E_PLAN_EXCEPTION = 'WYJ¥TEK PLANU!';

  E_INV_CREATE_CONNECT_DROP = 'Nieprawid³owa sk³adnia polecenia CREATE, CONNECT lub DROP DATABASE';
  E_Unsupported = 'Brak obs³ugi';
  E_NotImplemented = 'Brak implementacji na tym poziomie';
  E_Invalid_ColData = 'Nieprawid³owa wartoœæ ColData';

  E_Cant_Unprepare_executing_process = 'Nie mo¿na cofn¹æ przygotowania wykonywanego procesu';
  E_FileName_Required = 'Nale¿y podaæ nazwê pliku';
  
{ Etykiety dla ró¿nych okien dialogowych w IBO }

//IBF_Users
  L_USERS_FRM = 'Obs³uga kont u¿ytkowników';
  L_USERS_ADD = 'Dodaj';
  L_USERS_DELETE = 'Usuñ';
  L_USERS_MODIFIY = 'Zmieñ';
  L_USERS_ACCOUNT = 'KONTO';
  L_USERS_PASSWORD = 'Has³o';
  L_USERS_GROUP = 'Grupa';
  L_USERS_FIRSTNAME = 'Pierwsze imiê';
  L_USERS_MIDDLENAME = 'Drugie imiê';
  L_USERS_LASTNAME = 'Nazwisko';

//IBF_Export
  L_EXPORT_FRM = 'Eksportuj';
  L_EXPORT_ASCII = ' Format pliku ';
  L_EXPORT_FIXED = 'Sta³a d³ugoœæ rekordu';
  L_EXPORT_DELIMITED = 'Ograniczony znakiem';
  L_EXPORT_DBF  = 'DBF (Wymaga testowania)';
  L_EXPORT_ASCIIOPT  = ' Opcje ASCII ';
  L_EXPORT_DELIMITER  = 'Ogranicznik';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Format daty';
  L_EXPORT_INCLUDEHEADERS  = 'Do³¹cz nag³ówki';
  L_EXPORT_INCLUDECRLF  = 'Do³¹cz znaki CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Eksportuj';
  L_EXPORT_SDEXPORTFILTERCSV = 'Pliki tekstowe ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Pliki tekstowe ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'Pliki DBF ( *.DBF )|*.DBF';

{ Sta³e komunikatów dla ró¿nych dialogów w IBO }

  M_Abort_Fetching = 'Czy na pewno chcesz przerwaæ?';
  M_Fetching_Query_Results = 'Pobieranie wyniku zapytania';
  M_Row_Num = 'Linia# %d';
  M_Abort_Fetching_Btn = 'Porzuæ';

  M_Login_Database = 'Baza';
  M_Login_User = 'U¿ytkownik';
  M_Login_Password = 'Has³o';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Anuluj';
  M_Login_Help_Btn = '&Pomoc';
  M_Login_Dialog_Caption = 'Logowanie';

  M_Loading_Caption = '£adowanie...';

  M_SB_REC_CNT = 'Liczba rekordów: %d';
  M_Save_Changes = 'Zapisaæ zmiany?';
  M_Abort_Changes = 'Zmiany zostan¹ utracone. Czy kontynuowaæ?';

  M_CancelTransactionPrompt = 'Czy na pewno chcesz pomin¹æ wprowadzone zmiany?';

  M_SCRIPT_ABORT_EXECUTE = 'Wstrzymaæ wykonywanie tego skryptu?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Kontynuowaæ wykonywanie skryptu?';
  M_SCRIPT_IS_EXECUTING = 'Wykonywanie skryptu';
  M_SCRIPT_FAILED = 'B³¹d wykonania skryptu';
  M_SCRIPT_WAS_ABORTED = 'Przerwano wykonywanie skryptu';
  M_SCRIPT_COMPLETED = 'Skrypt wykonano bez b³êdów';
  M_SCRIPT_CMPL_EXCEPT = 'Wykonanie skryptu zakoñczone wyj¹tkiem';
  M_SCRIPT_MODIFIED = 'Zmodyfikowano';
  M_SCRIPT_SAVE_CHANGES = 'Zapisaæ zmiany?';
  
{ Zawartoœæ przycisków }

  C_BTN_TODAY = 'Dziœ';
  C_BTN_CLEAR = 'Czyœæ';
  C_BTN_FIND = 'ZnajdŸ';
  C_BTN_FINDNEXT = 'ZnajdŸ nastêpny';
  C_BTN_REPLACE = 'Zamieñ';
  C_BTN_UNDO = 'Cofnij';
  C_BTN_CUT = 'Wytnij';
  C_BTN_COPY = 'Kopiuj';
  C_BTN_PASTE = 'Wklej';
  C_BTN_DELETE = 'Usuñ';
  C_BTN_SELECTALL = 'Zaznacz wszystko';

  C_SG_Parameter = 'Parametr';
  C_SG_Field = 'Pole';
  C_SG_Name = 'Nazwa';
  C_SG_Type = 'Typ';
  C_SG_Info = 'Info';
  C_SG_Value = 'Wartoœæ';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Anuluj';
  C_BF_CANCEL_ACCEL = '&Cancel';
  C_BF_APPLY = 'Zastosuj';
  C_BF_HELP = 'Pomoc';
  C_BF_EXECUTE = 'Wykonaj';
  C_BF_CLOSE = 'Zamknij';
  C_BF_CLOSE_ACCEL = '&Zamknij';
  C_BF_FINISH = 'Zakoñcz';
  C_BF_FINISH_ACCEL = 'Zakoñcz';

  C_FRM_Ordering = 'Sortowanie';
  C_FRM_RESTRUCTURE = 'Dostasuj wyœwietlanie pól';

  C_CB_WordWrap = 'Zawijanie';
  
  // IBF_SQL
  M_SQL_RowsAffected = 'Iloœæ wierszy zaanga¿owanych: ';
  M_SQL_RowsCounted = 'Iloœæ wierszy: ';
  M_SQL_SessionBusy = 'Sesja w trakcie wykonywania';
  M_SQL_CompleteTransaction = 'Proszê zakoñczyæ transakcjê';
  M_SQL_CannotDeleteDefaultGroup = 'Nie mo¿na usun¹æ grupy domyœlnej';
  M_SQL_ReservedName = 'Nazwa zarezerwowana: ';
  M_SQL_BackSlashNotAllowed = 'Odwrotny ukoœnik jest niedozwolony';
  M_SQL_BlankNameNotAllowed = 'Pusta nazwa jest niedozwolona';
  M_SQL_RowsFetched = 'Iloœæ pobranych wierszy: ';
  M_SQL_ConfirmDBCreation = 'Jesteœ pewien, ¿e chcesz utworzyæ t¹ bazê?';
  M_SQL_ConfirmNoOtherDBSameName = 'Proszê sprawdziæ czy baza o takiej nazwie ju¿ nie istnieje';
  M_SQL_ConfirmDBDrop = 'Czu rzeczywiœcie chcesz usun¹æ t¹ bazê?';
  M_SQL_ReConfirmDBDrop = 'Baza zostanie trwale usuniêta.'+#13#10+#13#10'Czy kontynuowaæ?';
  M_SQL_AskFormName = 'Podaj nazwê formatki zapytania:';
  M_SQL_AskGroupName = 'Podaj nazwê grupy:';
  M_SQL_AskLayoutName = 'Podaj nazwê uk³adu:';
  M_SQL_ConfirmGroupDeletion = 'Czy rzeczywiœcie chcesz usun¹æ grupê %s z wszystkimi elementami podrzêdnymi?';
  M_SQL_ConfirmLayoutDeletion = 'Czy rzeczywiœcie chcesz usun¹æ uk³ad %s?';
  M_SQL_RecursiveCopyNotAllowed = 'Kopiowanie rekursywne nie jest dozwolone';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Kliknij dwukrotnie lub naciœnij Enter gdy opcja jest podœwietlona.';
  M_GCSQL_ParameterValue = 'Wartoœæ parametru';
  M_GCSQL_TypeAValueFor = 'Podaj wartoœæ dla %s';
  M_GCSQL_ProcedureWithoutParams = 'Procedura nie wymaga podania parametrów wejœciowych.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Proces Data Pump jest ci¹gle aktywny.';
  M_DP_ARE_YOU_SURE = 'Jesteœ pewien?';
  M_DP_SELECT_SOURCE_DB = 'Podaj Ÿród³ow¹ bazê';
  M_DP_SELECT_DEST_DB = 'Podaj docelow¹ bazê';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Czyœæ';
  M_USERS_COMPLETED_OK = 'Operacja zakoñczona pomyœlnie';
  M_USERS_NO_CONNECTION = 'Nie zdefiniowano IB_Connection.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Przypisaæ elementy porz¹dkowe?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Rozpocznij eksport';
  M_EXPORT_STILL_ACTIVE = 'Proces eksportu jest ci¹gle aktywny.';
  
  // IB_UtilityBar
  C_wbBrowseBtnHint    = 'Przegl¹daj bazê';
  C_wbBrowseBtnCaption = 'Przegl¹daj';
  C_wbDSQLBtnHint      = 'Wykonaj wyra¿enie w bazie';
  C_wbDSQLBtnCaption   = 'DSQL';
  C_wbEventsBtnHint    = 'Monitoruj zdarzenia bazy';
  C_wbEventsBtnCaption = 'Zdarzenia';
  C_wbExportBtnHint    = 'Eksportuj zbiór z bazy';
  C_wbExportBtnCaption = 'Eksportuj';
  C_wbDumpBtnHint      = 'Kopiuj bazê';
  C_wbDumpBtnCaption   = 'Kopiuj';
  C_wbPumpBtnHint      = 'Pompuj dane z innej bazy';
  C_wbPumpBtnCaption   = 'Pompuj';
  C_wbWhoBtnHint       = 'Poka¿ u¿ytkowników przy³¹czonych';
  C_wbWhoBtnCaption    = 'Kto';
  C_wbScriptBtnHint    = 'Wykonaj skrypt';
  C_wbScriptBtnCaption = 'Skrypt';
  C_wbExtractBtnHint    = 'Wyodrêbnij DDL';
  C_wbExtractBtnCaption = 'Wyodrêbnij';
  C_wbMonitorBtnHint   = 'ŒledŸ wywo³ania SQL i API';
  C_wbMonitorBtnCaption= 'ŒledŸ';
  C_wbProfilerBtnHint   = 'Profil aktywnoœci bazy';
  C_wbProfilerBtnCaption= 'Profiler';
  C_wbStatusBtnHint     = 'Zobacz stan komponentów IBO';
  C_wbStatusBtnCaption  = 'Status';
  C_wbUsersBtnHint     = 'Zarz¹dzanie u¿ytkownikami bazy';
  C_wbUsersBtnCaption  = 'U¿ytkownicy';

  // Array grid
  C_AG_Row             = 'Wiersz';
  C_AG_Column          = 'Kolumna';

  //IBF_Who
  C_WHO_FRM            = 'Przy³¹czeni';
  C_WHO_BTNAPPLY       = 'Odœwie¿';

  C_NB_FIRST = 'Pierwszy';
  C_NB_PRIOR = 'Poprzedni';
  C_NB_NEXT = 'Nastêpny';
  C_NB_LAST = 'Ostatni';

  C_ST_Open = 'Otwórz';
  C_ST_Close = 'Zamknij';
  C_ST_Prepare = 'Przygotuj';
  C_ST_Unprepare = 'Cofnij przygotuj';
  C_ST_ReadOnly = 'Tylko do odczytu';
  C_ST_New = 'Nowy';
  C_ST_Post = 'Wyœlij';
  C_ST_Cancel = 'Anuluj';
  C_ST_Delete = 'Usuñ';
  C_ST_Edit = 'Edytuj';
  C_ST_RefreshKeys = 'Odœwie¿ klucze';
  C_ST_RefreshRows = 'Odœwie¿ wiersze';
  C_ST_Refresh = 'Odœwie¿';

{ Podpowiedzi }

  H_UB_EDIT = 'Zmieñ wiersz';
  H_UB_INSERT = 'Wstaw wiersz';
  H_UB_DELETE = 'Usuñ wiersz';
  H_UB_REFRESH = 'Odœwie¿ rekordy';
  H_UB_REFRESHKEYS = 'Odœwie¿ klucze';
  H_UB_REFRESHROWS = 'Odœwie¿ wiersze';
  H_UB_REFRESHFILTROWS = 'Odœwie¿ filtrowane wiersze';
  H_UB_POSTSEARCH = 'Wyœlij kryteria poszukiwañ';
  H_UB_CANCELSEARCH = 'Pomiñ kryteria poszukiwañ';
  H_UB_POSTEDIT = 'Wyœlij zmiany';
  H_UB_CANCELEDIT = 'Pomiñ zmiany';
  H_UB_POSTINSERT = 'Wyœlij nowy wiersz';
  H_UB_CANCELINSERT = 'Pomiñ nowy wiersz';
  H_UB_POSTDELETE = 'Usuñ rekord';
  H_UB_CANCELDELETE = 'Anuluj usuniêcie';
  H_UB_POST = 'Wyœlij zmiany';
  H_UB_CANCEL = 'Pomiñ zmiany';

  H_NB_FIRST = 'Pierwszy wiersz';
  H_NB_PRIOR = 'Poprzedni wiersz';
  H_NB_NEXT = 'Nastêpny wiersz';
  H_NB_LAST = 'Ostatni wiersz';
  H_NB_JUMPBCK = 'Wstecz';
  H_NB_JUMPFWD = 'Do przodu';

  H_SB_ORDER = 'Porz¹dkuj wiersze';
  H_SB_LAST_CRITERIA = 'Przywo³aj kryteria ostatniego przeszukiwania';
  H_SB_SEARCH = 'Przeszukaj zbiór';
  H_SB_SAVE_CRITERIA = 'Zapisz kryteria';
  H_SB_CLEAR_CRITERIA = 'Usuñ kryteria';
  H_SB_RECALL_CRITERIA = 'Przywo³aj kryteria';
  H_SB_SEARCHCOUNT = 'Policz wiersze spe³niaj¹ce kryteria';
  H_SB_COUNT = 'Policz wiersze';
  H_SB_RESTRUCTURE = 'Dostosuj wyœwietlanie pól';

  H_TB_StartTransaction = 'Rozpocznij transakcjê';
  H_TB_PostDatasets = 'Zapisz zmiany';
  H_TB_CancelDatasets = 'Pomiñ zmiany';
  H_TB_SavePoint = 'ZatwierdŸ i utrzymaj aktualn¹ transakcjê';
  H_TB_CommitRetain = 'Zapisz zmiany, zatwierdŸ i utrzymaj aktualn¹ transakcjê';
  H_TB_Commit = 'ZatwierdŸ i zamknij aktualn¹ transakcjê';
  H_TB_Rollback = 'Wycofaj i zamknij aktualn¹ transakcjê';
  H_TB_RollbackRetain = 'Wycofaj i utrzymaj aktualn¹ transakcjê';
  H_TB_Close = 'Zamknij aktualn¹ transakcjê';

  H_ST_Prepare_Statement = 'Przygotuj zapytanie';
  H_ST_Unprepare_Statement = 'Cofnij przygotuj zapytanie';
  H_ST_Execute_Statement = 'Wykonaj zapytanie';

  H_DS_Open_Dataset = 'Otwórz bazê';
  H_DS_Close_Dataset = 'Zamknij bazê';
  H_DS_Prepare_Dataset = 'Przygotuj bazê';
  H_DS_Unprepare_Dataset = 'Cofnij przygotuj bazê';
  H_DS_ReadOnly_Dataset = 'Baza tylko do odczytu';

  H_CB_Create_Database = 'Stwórz bazê';
  H_CB_Connect_Database = 'Pod³¹cz bazê';
  H_CB_Disconnect_Database = 'Od³¹cz bazê';
  H_CB_Drop_Database = 'Usuñ bazê';

  H_RD_actHide = 'Ukryj wybrane pola';
  H_RD_actHideAll = 'Ukryj wszystkie pola';
  H_RD_actVisible = 'Odkryj wybrane pola';
  H_RD_actVisibleAll = 'Odkryj wszystkie pola';
  H_RD_actUp = 'Przesuñ wybrane pola o pozycjê w górê';
  H_RD_actTop = 'Przesuñ wybrane pola na pocz¹tek';
  H_RD_actDown = 'Przesuñ wybrane pola o pozycjê w dó³';
  H_RD_actBottom = 'Przesuñ wybrane pola na koniec';
  
  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Eksportuj z wyra¿enia SELECT';

  // Komunikaty b³êdów - IB_Import
  eNoAsciiFileEnty           = 'Brak odwo³ania do pliku ascii';
  eNoDestTableEntry          = 'Brak odwo³ania do tabeli docelowej';
  eAsciiFileNotFound         = 'Plik Ascii %s nie zosta³ znaleziony';
  eIniFileNotFound           = 'Plik Ini %s nie zosta³ znaleziony';
  eNoAsciiFileAccess         = 'Nie mo¿na otworzyæ pliku %s';
  eInvalidCharFound          = 'Nieprawid³owy znak / format pliku tekstowego';
  eOutOfMemory               = 'Brak pamiêci';
  eFieldDescriptionError     = 'B³¹d w opisie pola';
  eWrongAsciiFieldCount      = 'Nieprawid³owa liczba pól w pliku ascii';
  eWrongDecimalCount         = 'Nieprawid³owa liczba miejsc dziesiêtnych w (%s)';
  eWrongFieldWidth           = 'Nieprawid³owe pole w pliku ascii';

  // Obs³uga ekstrakcji metadanych
  // ------------------------

  // Nazwy typów encji
  STR_DDL_UnnamedItem = '<BEZ NAZWY>';
  STR_DDL_etDatabase = 'Baza danych';
  STR_DDL_etException = 'Wyj¹tek';
  STR_DDL_etBlobFilter = 'Filtr BLOB';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Generator';
  STR_DDL_etDomain = 'Domena';
  STR_DDL_etTable = 'Tabela';
  STR_DDL_etView = 'Widok';
  STR_DDL_etProcedure = 'Procedura';
  STR_DDL_etRole = 'Rola';
  STR_DDL_etPrimaryKey = 'Klucz g³ówny';
  STR_DDL_etUniqueKey = 'Klucz unikatowy';
  STR_DDL_etForeignKey = 'Klucz obcy';
  STR_DDL_etConstraint = 'Regu³a';
  STR_DDL_etIndex = 'Indeks';
  STR_DDL_etTrigger = 'Wyzwalacz';
  STR_DDL_etPermission = 'Prawo';
  STR_DDL_etUDFParam = 'Parametr UDF';
  STR_DDL_etTableField = 'Pole tabeli';
  STR_DDL_etViewField = 'Pole widoku';
  STR_DDL_etProcParam = 'Parametr procedury';

  // Nazwy CodeOption
  STR_DDL_coCreateDatabase = 'Utwórz bazê';
  STR_DDL_coSecondaryFiles = 'Twórz wtórne pliki';
  STR_DDL_coDefineShadows = 'Twórz cieñ bazy';
  STR_DDL_coSetGeneratorVal = 'Ustaw generator';
  STR_DDL_coResetExceptionNo = 'Resetuj numeracjê wyj¹tku';
  STR_DDL_coRawFieldDefs = 'Definicje pól typu Raw';
  STR_DDL_coIsolateAllComputed = 'Izoluj wszystkie pola wyliczane';
  STR_DDL_coReportMinor = 'Report Minor';
  STR_DDL_coAlwaysQuoted = 'Zawsze cytuj';
  STR_DDL_coAlwaysCharSet = 'Zawsze definiuj zestaw znaków';
  STR_DDL_coIncludeDebug = 'Do³¹cz informacje debuggera';
  STR_DDL_coDescripAsComment = 'Opisy jako kometa¿e';
  STR_DDL_coIgnoreDependencies = 'Ignoruj zale¿noœci';
  STR_DDL_coKeepCustomIndexNames = 'Zachowaj dostosowane nazwy indeksów';
  
  // Nazwy CodePass
  STR_DDL_cpFull = 'Pe³ny';
  STR_DDL_cpInit = 'Wstêpny';
  STR_DDL_cpFinal = 'Koñcowy';
  STR_DDL_cpAuto = 'Automatyczny';

  // Nazwy poziomu raportowania b³êdów
  STD_DDL_plNone       = 'Brak';
  STD_DDL_plMinor      = 'Niski';
  STD_DDL_plSuspicious = 'Podejrzane';
  STD_DDL_plWarning    = 'Uwagi';
  STD_DDL_plError      = 'B³êdy';
  // Skrócone nazwy poziomu raportowania b³êdów (do 5 znaków)
  STD_DDL_plNone_s       = 'BRAK ';
  STD_DDL_plMinor_s      = 'NISKI';
  STD_DDL_plSuspicious_s = 'POD  ';
  STD_DDL_plWarning_s    = 'UWAGA';
  STD_DDL_plError_s      = 'B£¥D ';
  
  // informacje w dialogach
  STR_DDL_DialogCaption = 'Ekstrakcja Metadanych';
  STR_DDL_Configure = 'Konfiguruj';
  STR_DDL_Filters = 'Filtry';
  STR_DDL_Script = 'Skrypt';
  STR_DDL_MetadataControls = 'Kontrolki metadanych';
  STR_DDL_CodeOptions = 'Opcje kodu';
  STR_DDL_Entities = 'Encje';
  STR_DDL_Terminator = 'Terminator';
  STR_DDL_InsertCommits = 'Insert Commits';
  STR_DDL_ExecuteControls = 'Kontrolki wykonawcze';
  STR_DDL_CodePass = 'Przejœcie kodu';
  STR_DDL_ExtractToStrings = 'Przekszta³æ w ³ancuchy znaków';
  STR_DDL_Reset = 'Resetuj';
  STR_DDL_ResetAll = 'Resetuj wszystko';
  STR_DDL_ProgressControls = 'Kontrolki postêpu';
  STR_DDL_Stop = 'Stop';
  STR_DDL_IncludeSystem = 'Do³¹cz obiekty systemowe';
  STR_DDL_NameMasks = 'Maski nazw';
  STR_DDL_SaveToFile = 'Zapisz do pliku';
  STR_DDL_RunScript = 'Run Script';
  STR_DDL_ScriptCommands = '&Script Commands';
  
  // B³êdy/Problemy generowane podczas ekstrakcji danych
  // Wszystkie zastêpowane elementy sygnalizowane s¹ wyst¹pieniem %s (string), niezbêdne
  // konwersje typów s¹ wykonywane w kodzie
  E_DDL_CURSOR_NOT_CREATED = 'Nie utworzono kursora';
  E_DDL_BLANK_NAME         = 'Nazwa pusta';
  E_DDL_ENTITY_NOT_FOUND   = 'Nie znaleziono encji';
  E_DDL_RESERVED_NAME      = 'Nazwa zarezerwowana u¿yta dla oznaczenia niesystemowej encji';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Nie znaleziono nazwy kanonicznej dla zestawu znaków %s';
  E_DDL_MODULE_NAME_EMPTY  = 'Pusta nazwa modu³u';
  E_DDL_ENTRY_POINT_EMPTY  = 'Nie podano punktu wejœcia';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'Zewnêtrzna domena mo¿e byæ tylko typu implicit';
  E_DDL_DOMAIN_TYPE_16     = 'Typu 16 mo¿e byæ tylko NUMERIC lub DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'Podano pusty identyfikator zestawu znaków, przyjmujê NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Nie podano nazwy zestawu znaków %s Przyjmujê NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'BytesPerCharacter ma wartoœæ 0 dla zestawu znaków %s';
  E_DDL_FIELDLEN_MISMATCH  = 'D³ugoœæ pola %s powinna byæ wielokrotnoœci¹ %s bajtów/znak w zestawie %s';
  E_DDL_INVALID_COLLATIONID = 'Identyfikator porz¹dku sortowania nie mo¿e byæ < 0 a wynosi %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Identyfikator porz¹dku sortowania ma wartoœæ NULL, przyjmujê %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Nieznany typ pola (FieldType) %s';
  E_DDL_CSTRING_IN_DSQL = 'FieldType CSTRING nie jest akceptowany przez DSQL';
  E_DDL_QUAD_IN_DSQL = 'FieldType QUAD nie jest akceptowany przez DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Suspicious check: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Zadeklarowano ograniczenie check ale go brak';
  E_DDL_EXPLICIT_COMPUTED = 'Domena Explicit nie mo¿e byæ typu COMPUTED';
  E_DDL_VOID_COMPUTED = 'Zadeklarowano klauzulê COMPUTED BY ale jej brak';
  E_DDL_SUSPICIOUS_DEFAULT = 'Suspicious default: %s';
  E_DDL_VOID_DEFAULT = 'Zadeklarowano klauzulê default ale jej brak';
  E_DDL_DIMENSIONS_MISMATCH = 'Zadeklarowano %s wymiarów a znaleziono opis dla %s.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Domena typu implicit nie posiada relacji.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Domena typu implicit nie posiada nazwy pola lub relacji.';
  E_DDL_NO_OUTPUT_PARAMETER = 'Brak parametru wyjœciowego';
  E_DDL_NO_GRANTOR = 'Nie wyspecyfikowano nadaj¹cego uprawnienie';
  E_DDL_VIEW_NO_BLR = 'Brakuje view_blr ale znaleziono go w rdb$view_relations jako WIDOK';
  E_DDL_VIEW_NO_VIEW_RELATION = 'Jest view_blr ale nie ma go w rdb$view_relations jako WIDOK';
  E_DDL_NO_OWNER = 'Nie podano nazwy w³aœciciela';
  E_DDL_FORMAT_VERSION = 'Format version at %s';
  E_DDL_DBKEY_LEN = 'DbKey_Length powinna byæ 8 a jest %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'NIe znaleziono definicji Domeny/Pola dla %s';
  E_DDL_NO_SOURCE_CODE = 'Brak kodu Ÿród³owego';
  E_DDL_WITH_CHECK_COMPLETION = '"With check" uzupe³niono do "with check option"';
  E_DDL_NO_BLR = 'Brakuje BLR';
  E_DDL_CORRUPT_SOURCE = 'Nierozpoznawalny prefiks Ÿród³owy, mo¿e to byæ oznak¹ uszkodzenia';
  E_DDL_INDEX_ID_NULL_INACTIVE = 'Id ma wartoœæ NULL a indeks jest nieaktywny';
  E_DDL_INDEX_ID_NULL_ACTIVE = 'Id ma wartoœæ NULL ale indeks jest aktywny';
  E_DDL_INVALID_INDEX_ID = 'Id powinien siê zaczynaæ od 1 a nie od %s';
  E_DDL_FK_INDEX_NO_CONSTRAINT = 'Zadeklarowano klucz obcy ale nie znaleziono go w ograniczeniach integralnoœci jako indeks FK';
  E_DDL_CONSTRAINT_NO_FK_INDEX = 'Nie zadeklarowano klucza obcego a znaleziono go w ograniczeniach integralnoœci jako indeks FK';
  E_DDL_INDEX_MULTI_USE = 'U¿yto ju¿ w ograniczeniu integralnoœci %s';
  E_DDL_INDEX_NO_FIELDS = 'U¿ywa pól %s';
  E_DDL_INDEX_DUPLICATE = 'Wydaje siê, ¿e istnieje podwójna definicja indeksu w tabeli: %s';
  E_DDL_INDEX_SEG_MISMATCH = 'Indeks w tabeli: %s deklaruje %s segmentów, ale znaleziono ich %s';
  E_DDL_CONSTRAINT_OUT_OF_RANGE = 'Typ ograniczenia %s jest poza zakresem';
  E_DDL_CONSTRAINT_USING_INDEX = 'Typ ograniczenia %s nie powinien u¿ywaæ indeksu a u¿ywa: %s';
  E_DDL_CONSTRAINT_NO_INDEX = 'Typ ograniczenia %s powinien u¿ywaæ indeksu a nie robi tego';
  E_DDL_UPDATE_RULE_INVALID = 'Zasada Update %s jest poza zakresem';
  E_DDL_DELETE_RULE_INVALID = 'Zasada Delete %s jest poza zakresem';
  E_DDL_PARENT_CONSTRAINT_EMPTY = 'Brak nazwy ograniczenia dla relacji rodzicielskiej';
  E_DDL_FOREIGN_NOT_DEFINED = 'Obca tabela lub indeks nie zosta³a zdefiniowana';
  E_DDL_PARENT_SHOULD_BE_EMPTY = 'Nazwa ograniczenia dla relacji rodzicielskiej powinna byæ pusta a jest %s';
  E_DDL_UPDATE_SHOULD_BE_EMPTY = 'Zasada Update powinna byæ pusta a jest %s';
  E_DDL_DELETE_SHOULD_BE_EMPTY = 'Zasada Delete powinna byæ pusta a jest %s';
  E_DDL_NO_BLR_WITH_CHECK =  'Nie ma kodu Ÿród³owego, prawdopodobnie u¿yto dla widoku %s z opcj¹ check';
  E_DDL_TRIGGER_LOST_CHECK = 'Rozpoczyna siê klauzul¹ "CHECK" i jest wykorzystywane przez ograniczenie typu check które zosta³o utracone.';
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Nieznany typ wyzwalacza %s';
  E_DDL_NEGATIVE_SEQUENCE = 'Ma ujemn¹ kolejnoœæ %s';
  E_DDL_NO_TARGET_RELATION = 'Nie podano docelowej tabeli lub widoku';
  E_DDL_NOT_IN_DEPENDENCIES = 'Zadeklarowano ale nie znaleziono w zale¿noœciach. W pewnych okolicznoœciach nie jest to b³¹d';
  E_DDL_SUSPICIOUS_TRIGGER = 'Podejrzany wyzwalacz zale¿y od innych tabel a nie od tej do której jest pod³¹czony.';
  E_DDL_INVALID_TRIGGER_SEQ = 'Sekwencja dla wyzwalacza wynosi %s a powinna byæ mniejsza od 1 dla wyzwalacza typu implicit';
  E_DDL_GRANT_OUT_OF_RANGE = 'Opcja Grant/Admin poza zakresem 0..2: %s';
  E_DDL_GRANT_TO_USER_TYPE = 'Opcjê Grant/Admin przypisano do u¿ytkownika typu %s';
  E_DDL_GRANT_FIELDS = 'Próbujê ustawiæ podane póla ale uprawnienia nie s¹ U lub R';
  E_DDL_EXECUTE_TO_OBJECT = 'Przypisanie EXECUTE do obiektu typu %s który powinien mieæ wartoœæ 5 (proc)';
  E_DDL_BAD_PRIV_ON_PROC = 'Przypisanie %s procedurze %s';
  E_DDL_MEMBER_TO_OBJECT = 'Przypisanie cz³onkowstwa obiektowi typu %s który powinien mieæ wartoœæ 13 (rola)';
  E_DDL_BAD_PRIV_ON_ROLE = 'Przypisanie %s do roli %s';
  E_DDL_BAD_ARG_POS =  'Pozycja argumentu powinna byæ >=0 a jest %s';
  E_DDL_SYSTEM_FLAG_MISMATCH = 'Wartoœæ SystemFlag ró¿na od rodzica';
  E_DDL_BAD_FIELD_ID = 'Pole Id powinno byæ >=0 a jest %s';
  E_DDL_BAD_FIELD_POS = 'Pozycja pola powinna byæ >=0 a jest %s';
  E_DDL_BAD_TABLE_BASEFIELD = 'BaseField powinien byæ dla tabel pusty a ma wartoœæ %s';
  E_DDL_BAD_TABLE_VIEWCONTEXT = 'ViewContext powinien byæ dla tabel pusty a ma wartoœæ %s';
  E_DDL_MANDATORY_IN_VIEW = 'Nie mo¿e byæ obowi¹zkowy dla widoków';
  E_DDL_BASEFIELD_EMPTY = 'BaseField nie powinien byæ pusty dla widoków jeœli ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext nie powinien byæ pusty dla widoków';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext powinien byæ >= 0 dla widoków';
  E_DDL_BAD_PARAM_TYPE = 'Typ parametru %s jest poza zakresem';
  E_DDL_BAD_PARAM_NUM = 'Numer parametru powinien byæ >=0 a jest %s';

  // Komenta¿e zwracane przez polecenia DDL
  C_DDL_CONNECT_USERNAME   = 'Pod³¹cz jako (u¿ytkownik): %s';
  C_DDL_CONNECT_SERVER_VER = 'do serwera: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'Brak plików wtórnych';
  C_DDL_SEC_FILES = 'Pliki wtórne';
  C_DDL_SEC_FILE_DESC = '%s, Start: %s, D³ugoœæ: %s';
  C_DDL_NO_SHADOW_FILES = 'Brak plików-cieni';
  C_DDL_SHADOW_FILES = 'Pliki-cienie';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, Start: %s, D³ugoœæ: %s';
  C_DDL_EXCEPTION_DESC = 'Wyj¹tek: %s, Numer oryginalny: %s';
  C_DDL_FIELD_NOT_FOUND = 'Nie znaleziono pola: %s';
  C_DDL_INDEX_NOT_FOUND = 'Nie znaleziono indeksu';
  C_DDL_NO_FOREIGN_RELATION = 'Nie zdefiniowano obcej relacji lub indeksu dla podanego ograniczenia';
  C_DDL_FOREIGN_NOT_FOUND = 'Nie znaleziono obcej relacji: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Nie znaleziono klucza obcego: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Nie znaleziono wyzwalacza: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Nieprawid³owa nazwa typu ograniczenia: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'Brak Ÿród³a dla wyzwalacza: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'Nieznany TriggerType: %s';
  C_DDL_BAD_PRIVILEGE = 'Nieznane uprawnienie: %s';


implementation

end.
