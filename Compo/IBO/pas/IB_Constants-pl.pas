
{                                                                               }
{ IB_Constants-pl                                                               }
{                                                                               }

{****************************************************************}
{                                                                }
{          IB Objects - Biblioteka komponent�w                   }
{                                                                }
{          Copyright (C) 1996-2001 Jason Wharton                 }
{          and Computer Programming Solutions, Mesa, AZ          }
{                                                                }
{  Ten plik �r�d�owy jest rozpowszechniany na licencji zaufania  }
{  CPS Trustware.                                                }
{  Plik ten mo�e by� ropzowszechniany w postaci �r�d�owej lub    }
{  skompilowanej tylko zgodnie z warunkami przedstawionymi w     }
{  licencji zaufania CPS Trustware License. Tre�� licencji       }
{  jest dost�pna pod adresem:                                    }
{               http://www.ibobjects.com/ibo_trustware.html      }
{                                                                }
{****************************************************************}

{******************************************************************************}
{  LISTA MODYFIKACJI                                                           }
{  Modyfikacje w stosunku do orygina�u prosimy wymienia� poni�ej w formacie:   }
{                                                                              }
{  Jan Kowalski <jan@jankowalski.com>                                          }
{  mm/dd/rrrr                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Jan Kowalski                                   }
{                                                                              }
{------------------------------------------------------------------------------}
{  Prosimy umieszcza� wszelkie informacje na temat modyfikacji                 }
{  w sekcji poni�ej tego nag��wka                                              }
{------------------------------------------------------------------------------}
{  Miroslaw Snietura <snietura@alpha.pl>                                       }
{  03/15/2002								       }
{     Polskie t�umaczenie zasob�w IB Objects                                   }
{     Wszelkie sugestie i informacje o b��dach s� mile widziane 	       }
{  04/23/2003							               }
{     Kolejne t�umaczenie na j�zyk polski nowych sta�ych dodanych 	       }
{     w wersji 4.2.Id    						       }
{									       }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Constants;

interface

var
// To jest nazwa u�ywanego InterBase Client DLL (API).
// U�yj IB_Session511.pas jako pierwszy wpis w klauzuli uses twojego projektu
// aby zmieni� warto�� zmiennej tak aby u�ywana by�a alternatywna biblioteka kliencka GDS32.DLL
  IB_GDS32: string = 'gds32.dll';

const
// To jest znacznik u�ywany do okre�lania czy b��d w InterBase zosta� poprawiony
// tak, �e mo�na u�ywa� zoptymalizowanej sk�adni wywo�a�.
  BUG_EXEC2 = true;

// Informacje o wersji
  IB_VERSION_MAJOR = '4';
  IB_VERSION_MINOR = '2';
  IB_VERSION_BUILD = 'I';
  IB_VERSION_SUB_RELEASE = 'd';
  
  IB_BASEKEY = 'Software\CPS\IBO';

// Ustawienia wewn�trzne
  IB_RDB = 'RDB$';
  IB_DB_KEY = 'DB_KEY';

// Sk�adnia parametr�w
  IB_BINDLINK = 'BIND_';
  IB_MASTERLINK = 'MLNK_';
  IB_KEYLINK = 'KLNK_';
  IB_ORDLINK = 'OLNK_';
  IB_PARAMETER = 'PRM_';
  IB_QBE_PARAMETER = 'QBE_';
  IB_LOCATE_PARAMETER = 'LOC_';
  IB_RNGBEG = 'RBEG_';
  IB_RNGEND = 'REND_';

// Zanczniki og�lne
  IB_TRUE = 'TRUE';
  IB_FALSE = 'FALSE';
  IB_AND = #13#10'  AND ';

// Nazwy parametr�w po��czenia ( Prosimy nie t�umaczy� )
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
  IB_SQL_ROLE_NAME_     = 'SQL ROLE NAME'; // Ustawienie wychodzi z u�ytku
  IB_ROLE_NAME          = 'ROLE NAME';
  IB_ROLE_              = 'ROLE';          // Ustawienie wychodzi z u�ytku

// Warto�ci parametr�w po��czenia
  IB_PROTOCOL_LOCAL    = 'LOCAL';
  IB_PROTOCOL_NETBEUI  = 'NETBEUI';
  IB_PROTOCOL_TCP_IP   = 'TCP/IP';
  IB_PROTOCOL_NOVELL   = 'NOVELL';
  IB_DB_KEY_SCOPE_CONN = 'CONNECTION';
  IB_DB_KEY_SCOPE_TRAN = 'TRANSACTION';

// Ustawienia alias�w BDE
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

// Ustawienia alias�w BDE
  BDE_SHARED_AUTOCOMMIT      = 'SHARED AUTOCOMMIT';	
  BDE_SHARED_NOAUTOCOMMIT    = 'SHARED NOAUTOCOMMIT';
  BDE_NOT_SHARED             = 'NOT SHARED';


// R�ne ustawienia dla w�asno�ci ColumnAttributes.
  IB_BINARY      = 'BINARY';     // Traktuj kolumn� CHAR lub VARCHAR jako binarn�.
  IB_BLANKISNULL = 'BLANKISNULL';// U�ywane przez klas� TIB_Column podczas przypisywania
                                 // pustego ci�gu do zmiennej Fields.
  IB_BOOLEAN     = 'BOOLEAN';    // Warto�� u�ywana do okre�lania kolumny
                                 // jako boolean.
  IB_COMPUTED    = 'COMPUTED';   // Wskazuje czy kolumna jest wyliczana jako
                                 // COMPUTED BY.
  IB_CURRENCY    = 'CURRENCY';   // Czy kolumna zawiera kwot� pieni�n�.
  IB_NOCASE      = 'NOCASE';     // Wyszukiwanie bez brania pod uwag� wielko�ci liter
  IB_NODATE      = 'NODATE';
  IB_NOSOUNDEX   = 'NOSOUNDEX';  // Wy��cza przetwarzanie soundex w zbiorze danych
  IB_NOTIME      = 'NOTIME';
  IB_NOTRAILING  = 'NOTRAILING'; // Flaga u�ywania STARTING w odniesieniu do �a�cuch�w znakowych
  IB_NOTREQUIRED = 'NOTREQUIRED';
  IB_REQUIRED    = 'REQUIRED';
  IB_SOUNDEX     = 'SOUNDEX';    // Flaga ustawiaj�ca przeszukiwanie pola SoundEx
  IB_BCD         = 'BCD';        // Ustawienie kolumny jako TIBOBCDField
  IB_NOBCD       = 'NOBCD';      // Ustawienie kolumny jako TIBOFloatField
  IB_YESCASE     = 'YESCASE';    // Flaga nadpisywania CN.DefaultNoCase
  IB_YESLIKE     = 'YESLIKE';    // Flaga u�ywania LIKE na �a�cuchach znak�w
  IB_YESTRAILING = 'YESTRAILING';// Flaga nadpisywania CN.DefaultNoTrailing

// U�ywane przez SearchPanel w�a�ciwo�� FieldsReadOnly.
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

// Globalne ustawienia domy�lne  ( NIE t�umaczy� )
  G_DefaultRowHeight = 17;

  DTEncode_DateDelimit     = '/';
  DTEncode_TimeDelimit     = ':';
  DTEncode_DateTimeDelimit = ' ';
  DTEncode_DecodeFormat    = '%.4u/%.2u/%.2u %.2u:%.2u:%.2u.%.3u0';
  DTEncode_DateTimeFormat  = 'YYYY"/"MM"/"DD" "HH":"NN":"SS".0000"';
  DT_DateFormat            = 'MM"/"dd"/"yyyy';
  DT_TimeFormat            = 'hh":"nn":"ss';

{ Od tego miejsca mo�na t�umaczy�. }

{$IFDEF IBO_VCL30_OR_GREATER}
resourcestring
{$ENDIF}

  IB_REG_MESSAGE = 'Dzi�kuj� za przetestowanie IB Objects.'#13#10#13#10'Prosz� odwiedzi� witryn� http://www.ibobjects.com i dokona� rejestracji.';

{ Sta�e b��d�w dla IB_Connection, IB_Trannsaction, IB_Statement }

  E_CONNECTED         = 'Po��czenie zosta�o utworzone';
  E_NOT_CONNECTED     = 'Po��czenie nie zosta�o utworzone';
  E_Invalid_conn_path = 'Nieprawid�owa �cie�ka po��czenia';
  E_Cant_Repl_Int_Tr  = 'Domy�lnie nie mo�na zamieni� wewn�trznej transakcji';
  E_NO_TRANS_STARTED  = 'Transakcja nie zosta�a rozpocz�ta';
  E_TRANS_STARTED     = 'Transakcja zosta�a rozpocz�ta';
  E_NO_CONNECTIONS    = 'Brak po��czenia podczas realizacji transakcji';
  E_NOT_ENOUGH_CONN   = 'Utrata jednego lub kilku po��cze� podczas realizacji transakcji';
  E_CONN_LOADING      = 'Uwaga: realizacja po��czenia nadal trwa';
  E_TRANS_CONN_SESS   = 'Wszystkie po��czenia musz� nale�e� do tej samej IB_Session';
  E_TransactionPaused = 'Transakcja zosta�a wstrzymana';
  E_ALLOCATED         = 'Wyra�enie zosta�o alokowane';
  E_NOT_ALLOCATED     = 'Wyra�enia nie zosta�o alokowane';
  E_PREPARED          = 'Wyra�enie zosta�o przygotowane';
  E_NOT_PREPARED      = 'Wyra�enie nie zosta�o przygotowane';
  E_FAILED_TO_PREPARE = 'Pr�ba przygotowania wyra�enia nie powiod�a si�';
  E_OPENED            = 'Wyra�enie zosta�o otwarte';
  E_NOT_OPENED        = 'Wyra�enie nie zosta�o otwarte';
  E_CANT_DELETE       = 'Aktualnego rekordu kursora nie mo�na usun��';
  E_NO_CONNECTION     = 'Wyra�enie musi mie� przypisane IB_Connection';
  E_CONNECT_FAILED    = 'Nie mo�na otworzy� IB_Connection';
  E_NO_TRANSACTION    = 'Wyra�enie musi mie� przypisan� IB_Transaction';
  E_NO_ACTIVE_TRANS   = 'Brak aktywnej transakcji do wykonania';
  E_START_FAILED      = 'Nie mo�na rozpocz�� transakcji';
  E_SVRAUTOCMT_NOEXP  = 'Transakcja typu explicit nie jest dozwolona w po��czeniu  z ServerAutoCommit';
  E_Cannot_Activate     = 'Nieprawid�owy stan transakcji. Nie mo�na wprowadzi� zmian';  
  E_Transaction_Is_Active = 'Transakcja zawiera niewykonane zmiany';
  E_Failed_To_Post_Datasets = 'Pr�ba uaktualnienia wszystkich zbior�w danych nie powiod�a si�';
  E_Failed_To_Cancel_Datasets = 'Pr�ba cofni�cia zmian dla wszystkich zbior�w danych nie powiod�a si�';
  E_UpdateWrongTrn    = 'Nie mo�na uaktualni� - %s nie nale�y do %s';
  E_NO_BLANK_SQL      = 'Puste wyra�enia SQL nie s� dozwolone';
  E_AT_END_OF_FILE    = 'Koniec pliku';
  E_AT_END_OF_CURSOR  = 'Koniec kursora';
  E_AT_END_OF_BUFFER  = 'Koniec bufora';
  E_AT_END_OF_DATASET = 'Koniec zbioru danych';
  E_BAD_SQL_INF_LEN   = 'Niew�a�ciwa d�ugo�� isc_dsql_sql_info';
  E_BAD_SQL_INF_DATA  = 'Isc_dsql_sql_info zwr�ci� nieprawid�owe dane';
  E_CURSOR_NAME_LOCK  = 'Nie mo�na zmieni� nazwy aktywnego kursora';
  E_REQUEST_LIVE_ACTIVE = 'Nie mo�na zmieni� w�asno�ci RequestLive w stanie aktywnym';
  E_REQUEST_LIVE_READONLY = 'Zbi�r danych nie mo�e mie� jednocze�nie w�asno�ci RequestLive i ReadOnly';
  E_CURSOR_UNI              = 'IB_CURSOR jest jednokierunkowy';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Nieobs�ugiwany typ kolumny: %d';
  E_FIELDNO_NOT_FOUND         = 'Nie znaleziono pola o numerze FieldNo: %d';
  E_FIELDNAME_NOT_FOUND        = 'Nie znaleziono pola o nazwie FieldName: %s';
  E_INVALID_FOCUS_RELATION_NO   = 'Nieprawid�owa aktywna relacja o numerze No: %d';
  E_INVALID_FOCUS_RELATION_NAME = 'Nieprawid�owa aktywna relacja o nazwie Name: %s';
  E_INVALID_QBE_IN              = 'B��d syntaktyczny wyra�enia IN( warto�� [ , warto�� ... ] )';
  E_INVALID_QBE_BETWEEN         = 'B��d syntaktyczny wyra�enia BETWEEN warto�� AND warto��';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Nie mo�na znale�� importu DLL o nazwie: %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Nieprawid�owa warto�� SQLKeyFields';
  E_GET_CURSOR_ERROR       = 'Nie mo�na otworzy� kursora bez danych kluczowych';
  E_SCROLL_ERROR           = 'Klucz rekordu zosta� zgubiony'#10#13'Otwarcie kursora nie uda�o si�';
  E_INVALID_BUFFER_ROW_NUM = 'Nieprawid�owa warto�� pocz�tkowa BufferRowNum';
  E_BLANK_STATEMENT      = 'Nie mo�na przygotowa� wyra�enia pustego';
  E_UNKNOWN_STATEMENT   = 'Pr�ba wykonania nieznanego wyra�enia';
  E_CIRCULAR_REFERENCE = 'Odwo�ania pier�cieniowe nie s� dozwolone';
  E_CANT_CHG_WITH_CONN = 'Nie mo�na dokona� zmian podczas aktywnego po��czenia';
  E_LOGIN_FAILED      = 'B��d autoryzacji';
  E_CANT_GET_CONN_CHR = 'Nie mo�na uzyska� charakterystyki po��czenia';
  E_MAX_EVENTS_BLOCK  = 'Przekroczona liczba zdarze� dla jednego bloku';
  E_PROCESSING_EVENTS = 'Przetwarzanie zdarze�'#13#10'Nie mo�na cofn�� rejestracji';
  E_CANT_STORE_BLOB  = 'Nie mo�na zapisa� zmiennej typu Blob lub ju� zosta�a zapisana';
  E_CANT_LOAD_BLOB   = 'Nie mo�na za�adowa� zmiennej typu Blob lub ju� zosta�a za�adowana';
  E_CANNOT_CANCEL_ROW = 'Nie mo�na cofn�� zmian w aktualnym wierszu';
  E_CANNOT_POST_ROW  = 'Nie mo�na zapisa� aktualnego wiersza';
  E_DatasetClosed     = 'Zbi�r danych jest nieaktywny';
  E_DatasetOpen        = 'Zbi�r danych jest otwarty';
  E_DatasetCannotScroll = 'Nie mo�na przegl�da� zbioru danych';
  E_DatasetReadOnly     = 'Zbi�r danych jest otwarty tylko do odczytu';
  E_DatasetIsFetching    = 'Trwa pobieranie zbioru danych';
  E_Invalid_KeyRelation   = 'Nieprawid�owa warto�� KeyRelation';
  E_RowNum_Not_Implemented = 'Jeszcze nie zaimplementowano RowNum';
  E_RowDeleted            = 'Wiersz jest usuwany';
  E_END_OF_DATASET        = 'Koniec zbioru danych';
  E_BEGINNING_OF_DATASET   = 'Pocz�tek zbioru danych';
  E_Cannot_Pessimistic_Lock = 'Nie mo�na stosowa� "pesymistycznego blokowania" z parametrem LockWait';
  E_Cannot_Edit_Row      = 'B��d przy pr�bie edycji aktualnego wiersza';
  E_Cannot_Insert_Row  = 'B��d przy pr�bie wstawienia nowego wiersza';
  E_Cannot_Delete_Row = 'B��d przy pr�bie usuni�cia aktualnego wiersza';
  E_Cannot_Search    = 'Przeszukiwanie nie jest dozwolone';
  E_Cannot_Navigate = 'B��d przy pr�bie nawigacji w obr�bie zbioru';
  E_Record_Locked    = 'Rekord zosta� zablokowany przez innego u�ytkownika';
  E_Record_OutOfSynch = 'Rekord zosta� zmieniony przez innego u�ytkownika';
  E_FLD_READONLY       = '%s jest tylko do odczytu';
  E_Required_Field       = '%s jest polem wymaganym';
  E_NO_POSTRTN_CACHED_UPDT = 'Nie mo�na u�ywa� opcji PostRetaining z Cached Updates';
  E_Multiple_Rows_In_Singleton = 'Wiele rekord�w w zapytaniu typu singleton';
  
  E_InvalidRowsAffectedBuf = 'Nieprawid�owy bufor RowsAffected';
  E_Invalid_RowNum_Past_Eof = 'Nieprawid�owa warto�� RowNum za znacznikiem Eof';
  E_Invalid_RowNum_Before_Bof = 'Nieprawid�owa warto�� RowNum przed znacznikiem Bof';
  E_Invalid_Bookmark = 'Nieprawid�owy identyfikator zak�adki';
  
  E_Assign_Column  = 'Nie mo�na przypisa� z %s';
  E_AssignTo_Column = 'Nie mo�na przypisa� do %s';
  E_Value_Out_Of_Range = 'Warto�� spoza zakresu';
  E_SmallintOverflow = 'Przekroczenie zakresu liczby typu Smallint';
  E_IntegerOverflow = 'Przekroczenie zakresu liczby typu Integer';
  E_Int64Overflow = 'Przekroczenie zakresu liczby typu Int64';
  
  E_Unsupported_Column = 'Nieobs�ugiwany typ kolumny: %d';
  E_UndefinedMacro = 'Niezdefiniowane makro';
  E_GeneratorFailed = 'Nie mo�na odczyta� warto�ci generatora';
  
  E_MustBe_Buffered_Dataset = 'Wymagane jest dziedziczenie po TIB_BDataset (IB_Query)';
  
  E_NO_CHANGE_READONLY = 'Nie mo�na zmieni� w�a�ciwo�ci ReadOnly po uruchomieniu';
  E_NO_CHANGE_ISOLATION = 'Nie mo�na zmieni� w�a�ciwo�ci Isolation po uruchomieniu';
  E_NO_CHANGE_RECVERSION = 'Nie mo�na zmieni� w�a�ciwo�ci RecVersion po uruchomieniu';
  E_NO_CHANGE_LOCKWAIT = 'Nie mo�na zmieni� w�a�ciwo�ci LockWait po uruchomieniu';
  
  E_Invalid_Reference_To_Delete = 'Nieprawid�owe wskazanie dla funkcji Usu�';
  E_Invalid_Typecast = 'Niew�a�ciwe rzutowanie typu';
  E_Invalid_DataPump_Statement = 'Niew�a�ciwy rodzaj wyra�enia dla DataPump';
  E_FIELD_NOT_NULLABLE = 'Pole typu NOT NULL ustawione na warto�� NULL';
  E_DATABASE_BLANK = 'Parametr DatabaseName nie mo�e by� pusty';
  E_Unsupp_Col_Conversion = 'Nieobs�ugiwana konwersja typ�w mi�dzy kolumnami';
  E_Unable_To_Locate_Record = 'Nie mo�na znale�� rekordu';
  E_Record_Not_Inserted = 'Nie wstawiono nowego rekordu';
  E_Invalid_KeyLinks = 'Niew�a�ciwa warto�� KeyLinks: %s';
  E_Unable_to_perform_search = 'Nie mo�na wykona� przeszukiwania';
  E_Unassigned_Blob_Node = 'Nieprzypisany BlobNode';
  E_Unassigned_Transaction = 'Nieprzypisana transakcja';
  E_Invalid_RowsAffected_Buffer = 'Nieprawid�owy bufor RowsAffected';
  E_Unable_Save_Graphic = 'Nie mo�na zapisa� obiektu Graphic';
  E_Cannot_Activate_Transaction = 'Nie mo�na uaktywni� transakcji';
  E_IB_Client_Not_Installed = 'Biblioteka InterBase Client GDS32.DLL nie zosta�a zainstalowana';
  E_Could_Not_Load_Memo = 'Nie mo�na za�adowa� zawarto�ci pola Memo';
  E_Invalid_DPB_Over_255 = 'Nieprawid�owy DPB: Zawiera ponad 255 znak�w';
  E_Inv_Custom_DML = 'Nieprawid�owa referencja do kolumny DML: %s';
  E_Record_Not_Located_For_Update = 'Nie znaleziono rekordu do uaktualnienia';
  E_Record_Not_Located_For_Delete = 'Nie znaleziono rekordu do usuni�cia';
  E_Init_Default_SQL_Failed = 'Nie mo�na zainicjowa� domy�lnego %s';
  E_Stringlist_Not_Sorted = 'Ta operacja wymaga posortowanej listy Stringlist';
  E_Cannot_Change_Events = 'Nie mo�na zmienia� zdarze� podczas ich obs�ugi';
  E_Cannot_Unregister_Events = 'Nie mo�na odrejestrowywa� zdarze� podczas ich obs�ugi';
  E_Invalid_Internal_Transaction = 'Nieprawid�owa wewn�trzna IB_Transaction';
  E_InvalidStatementType = 'Nieprawid�owy typ wyra�enia';
  E_Multiple_Records_Updated = 'Zaktualizowano rekordy';
  E_Multiple_Records_Deleted = 'Usuni�to rekordy';
  E_Multiple_Records_Inserted = 'Wstawiono rekordy';
  E_DUP_DB_NAME = 'Identyczne warto�ci DatabaseName nie s� dozwolone';
  E_INVALID_DB_NAME = 'Nieprawid�owa warto�� w�a�ciwo�ci DatabaseName';
  E_UnableToSearch_NoOrdering = 'Nie mo�na wykona� przeszukiwania, nie zdefiniowano sposobu porz�dkowania danych';
  E_UnableToSearch_DatasetBusy = 'Nie mo�na wykona� przeszukiwania, trwa pobieranie danych';
  E_NoRecordsFound = 'Nie znaleziono �adnego rekordu';
  E_Session_Undefined = 'Nie zdefiniowano sesji';
  E_NoCircularRef = 'Nie dopuszcza si� wzajemnych odwo�a�';
  E_InvalidClassType = 'Nieprawid�owy typ klasy';
  E_Invalid_RowNum = 'Nieprawid�owa warto�� RowNum';
  E_Invalid_Syntax = 'B��d sk�adni: dodatkowe lub brak nawias�w';
  E_Array_Is_Null = 'Wska�nik do tablicy ma warto�� Null';
  
  E_Cannot_add_blank_account = 'Nie mo�na doda� pustego konta';
  E_Cannot_add_SYSDBA_account = 'Nie mo�na doda� konta administratora SYSDBA';
  E_Cannot_delete_blank_account = 'Nie mo�na usun�� pustego konta';
  E_Cannot_delete_SYSDBA_account = 'Nie mo�na usun�� konta administratora SYSDBA';
  E_Cannot_modify_blank_account = 'Nie mo�na zmodyfikowa� pustego konta';

  E_PLAN_ERROR = 'B��D PLANU!';
  E_PLAN_EXCEPTION = 'WYJ�TEK PLANU!';

  E_INV_CREATE_CONNECT_DROP = 'Nieprawid�owa sk�adnia polecenia CREATE, CONNECT lub DROP DATABASE';
  E_Unsupported = 'Brak obs�ugi';
  E_NotImplemented = 'Brak implementacji na tym poziomie';
  E_Invalid_ColData = 'Nieprawid�owa warto�� ColData';

  E_Cant_Unprepare_executing_process = 'Nie mo�na cofn�� przygotowania wykonywanego procesu';
  E_FileName_Required = 'Nale�y poda� nazw� pliku';
  
{ Etykiety dla r�nych okien dialogowych w IBO }

//IBF_Users
  L_USERS_FRM = 'Obs�uga kont u�ytkownik�w';
  L_USERS_ADD = 'Dodaj';
  L_USERS_DELETE = 'Usu�';
  L_USERS_MODIFIY = 'Zmie�';
  L_USERS_ACCOUNT = 'KONTO';
  L_USERS_PASSWORD = 'Has�o';
  L_USERS_GROUP = 'Grupa';
  L_USERS_FIRSTNAME = 'Pierwsze imi�';
  L_USERS_MIDDLENAME = 'Drugie imi�';
  L_USERS_LASTNAME = 'Nazwisko';

//IBF_Export
  L_EXPORT_FRM = 'Eksportuj';
  L_EXPORT_ASCII = ' Format pliku ';
  L_EXPORT_FIXED = 'Sta�a d�ugo�� rekordu';
  L_EXPORT_DELIMITED = 'Ograniczony znakiem';
  L_EXPORT_DBF  = 'DBF (Wymaga testowania)';
  L_EXPORT_ASCIIOPT  = ' Opcje ASCII ';
  L_EXPORT_DELIMITER  = 'Ogranicznik';
  L_EXPORT_SEPARATOR  = 'Separator';
  L_EXPORT_DATEFORMAT  = 'Format daty';
  L_EXPORT_INCLUDEHEADERS  = 'Do��cz nag��wki';
  L_EXPORT_INCLUDECRLF  = 'Do��cz znaki CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Eksportuj';
  L_EXPORT_SDEXPORTFILTERCSV = 'Pliki tekstowe ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Pliki tekstowe ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'Pliki DBF ( *.DBF )|*.DBF';

{ Sta�e komunikat�w dla r�nych dialog�w w IBO }

  M_Abort_Fetching = 'Czy na pewno chcesz przerwa�?';
  M_Fetching_Query_Results = 'Pobieranie wyniku zapytania';
  M_Row_Num = 'Linia# %d';
  M_Abort_Fetching_Btn = 'Porzu�';

  M_Login_Database = 'Baza';
  M_Login_User = 'U�ytkownik';
  M_Login_Password = 'Has�o';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Anuluj';
  M_Login_Help_Btn = '&Pomoc';
  M_Login_Dialog_Caption = 'Logowanie';

  M_Loading_Caption = '�adowanie...';

  M_SB_REC_CNT = 'Liczba rekord�w: %d';
  M_Save_Changes = 'Zapisa� zmiany?';
  M_Abort_Changes = 'Zmiany zostan� utracone. Czy kontynuowa�?';

  M_CancelTransactionPrompt = 'Czy na pewno chcesz pomin�� wprowadzone zmiany?';

  M_SCRIPT_ABORT_EXECUTE = 'Wstrzyma� wykonywanie tego skryptu?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Kontynuowa� wykonywanie skryptu?';
  M_SCRIPT_IS_EXECUTING = 'Wykonywanie skryptu';
  M_SCRIPT_FAILED = 'B��d wykonania skryptu';
  M_SCRIPT_WAS_ABORTED = 'Przerwano wykonywanie skryptu';
  M_SCRIPT_COMPLETED = 'Skrypt wykonano bez b��d�w';
  M_SCRIPT_CMPL_EXCEPT = 'Wykonanie skryptu zako�czone wyj�tkiem';
  M_SCRIPT_MODIFIED = 'Zmodyfikowano';
  M_SCRIPT_SAVE_CHANGES = 'Zapisa� zmiany?';
  
{ Zawarto�� przycisk�w }

  C_BTN_TODAY = 'Dzi�';
  C_BTN_CLEAR = 'Czy��';
  C_BTN_FIND = 'Znajd�';
  C_BTN_FINDNEXT = 'Znajd� nast�pny';
  C_BTN_REPLACE = 'Zamie�';
  C_BTN_UNDO = 'Cofnij';
  C_BTN_CUT = 'Wytnij';
  C_BTN_COPY = 'Kopiuj';
  C_BTN_PASTE = 'Wklej';
  C_BTN_DELETE = 'Usu�';
  C_BTN_SELECTALL = 'Zaznacz wszystko';

  C_SG_Parameter = 'Parametr';
  C_SG_Field = 'Pole';
  C_SG_Name = 'Nazwa';
  C_SG_Type = 'Typ';
  C_SG_Info = 'Info';
  C_SG_Value = 'Warto��';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Anuluj';
  C_BF_CANCEL_ACCEL = '&Cancel';
  C_BF_APPLY = 'Zastosuj';
  C_BF_HELP = 'Pomoc';
  C_BF_EXECUTE = 'Wykonaj';
  C_BF_CLOSE = 'Zamknij';
  C_BF_CLOSE_ACCEL = '&Zamknij';
  C_BF_FINISH = 'Zako�cz';
  C_BF_FINISH_ACCEL = 'Zako�cz';

  C_FRM_Ordering = 'Sortowanie';
  C_FRM_RESTRUCTURE = 'Dostasuj wy�wietlanie p�l';

  C_CB_WordWrap = 'Zawijanie';
  
  // IBF_SQL
  M_SQL_RowsAffected = 'Ilo�� wierszy zaanga�owanych: ';
  M_SQL_RowsCounted = 'Ilo�� wierszy: ';
  M_SQL_SessionBusy = 'Sesja w trakcie wykonywania';
  M_SQL_CompleteTransaction = 'Prosz� zako�czy� transakcj�';
  M_SQL_CannotDeleteDefaultGroup = 'Nie mo�na usun�� grupy domy�lnej';
  M_SQL_ReservedName = 'Nazwa zarezerwowana: ';
  M_SQL_BackSlashNotAllowed = 'Odwrotny uko�nik jest niedozwolony';
  M_SQL_BlankNameNotAllowed = 'Pusta nazwa jest niedozwolona';
  M_SQL_RowsFetched = 'Ilo�� pobranych wierszy: ';
  M_SQL_ConfirmDBCreation = 'Jeste� pewien, �e chcesz utworzy� t� baz�?';
  M_SQL_ConfirmNoOtherDBSameName = 'Prosz� sprawdzi� czy baza o takiej nazwie ju� nie istnieje';
  M_SQL_ConfirmDBDrop = 'Czu rzeczywi�cie chcesz usun�� t� baz�?';
  M_SQL_ReConfirmDBDrop = 'Baza zostanie trwale usuni�ta.'+#13#10+#13#10'Czy kontynuowa�?';
  M_SQL_AskFormName = 'Podaj nazw� formatki zapytania:';
  M_SQL_AskGroupName = 'Podaj nazw� grupy:';
  M_SQL_AskLayoutName = 'Podaj nazw� uk�adu:';
  M_SQL_ConfirmGroupDeletion = 'Czy rzeczywi�cie chcesz usun�� grup� %s z wszystkimi elementami podrz�dnymi?';
  M_SQL_ConfirmLayoutDeletion = 'Czy rzeczywi�cie chcesz usun�� uk�ad %s?';
  M_SQL_RecursiveCopyNotAllowed = 'Kopiowanie rekursywne nie jest dozwolone';

  // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Kliknij dwukrotnie lub naci�nij Enter gdy opcja jest pod�wietlona.';
  M_GCSQL_ParameterValue = 'Warto�� parametru';
  M_GCSQL_TypeAValueFor = 'Podaj warto�� dla %s';
  M_GCSQL_ProcedureWithoutParams = 'Procedura nie wymaga podania parametr�w wej�ciowych.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Proces Data Pump jest ci�gle aktywny.';
  M_DP_ARE_YOU_SURE = 'Jeste� pewien?';
  M_DP_SELECT_SOURCE_DB = 'Podaj �r�d�ow� baz�';
  M_DP_SELECT_DEST_DB = 'Podaj docelow� baz�';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Czy��';
  M_USERS_COMPLETED_OK = 'Operacja zako�czona pomy�lnie';
  M_USERS_NO_CONNECTION = 'Nie zdefiniowano IB_Connection.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'Przypisa� elementy porz�dkowe?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Rozpocznij eksport';
  M_EXPORT_STILL_ACTIVE = 'Proces eksportu jest ci�gle aktywny.';
  
  // IB_UtilityBar
  C_wbBrowseBtnHint    = 'Przegl�daj baz�';
  C_wbBrowseBtnCaption = 'Przegl�daj';
  C_wbDSQLBtnHint      = 'Wykonaj wyra�enie w bazie';
  C_wbDSQLBtnCaption   = 'DSQL';
  C_wbEventsBtnHint    = 'Monitoruj zdarzenia bazy';
  C_wbEventsBtnCaption = 'Zdarzenia';
  C_wbExportBtnHint    = 'Eksportuj zbi�r z bazy';
  C_wbExportBtnCaption = 'Eksportuj';
  C_wbDumpBtnHint      = 'Kopiuj baz�';
  C_wbDumpBtnCaption   = 'Kopiuj';
  C_wbPumpBtnHint      = 'Pompuj dane z innej bazy';
  C_wbPumpBtnCaption   = 'Pompuj';
  C_wbWhoBtnHint       = 'Poka� u�ytkownik�w przy��czonych';
  C_wbWhoBtnCaption    = 'Kto';
  C_wbScriptBtnHint    = 'Wykonaj skrypt';
  C_wbScriptBtnCaption = 'Skrypt';
  C_wbExtractBtnHint    = 'Wyodr�bnij DDL';
  C_wbExtractBtnCaption = 'Wyodr�bnij';
  C_wbMonitorBtnHint   = '�led� wywo�ania SQL i API';
  C_wbMonitorBtnCaption= '�led�';
  C_wbProfilerBtnHint   = 'Profil aktywno�ci bazy';
  C_wbProfilerBtnCaption= 'Profiler';
  C_wbStatusBtnHint     = 'Zobacz stan komponent�w IBO';
  C_wbStatusBtnCaption  = 'Status';
  C_wbUsersBtnHint     = 'Zarz�dzanie u�ytkownikami bazy';
  C_wbUsersBtnCaption  = 'U�ytkownicy';

  // Array grid
  C_AG_Row             = 'Wiersz';
  C_AG_Column          = 'Kolumna';

  //IBF_Who
  C_WHO_FRM            = 'Przy��czeni';
  C_WHO_BTNAPPLY       = 'Od�wie�';

  C_NB_FIRST = 'Pierwszy';
  C_NB_PRIOR = 'Poprzedni';
  C_NB_NEXT = 'Nast�pny';
  C_NB_LAST = 'Ostatni';

  C_ST_Open = 'Otw�rz';
  C_ST_Close = 'Zamknij';
  C_ST_Prepare = 'Przygotuj';
  C_ST_Unprepare = 'Cofnij przygotuj';
  C_ST_ReadOnly = 'Tylko do odczytu';
  C_ST_New = 'Nowy';
  C_ST_Post = 'Wy�lij';
  C_ST_Cancel = 'Anuluj';
  C_ST_Delete = 'Usu�';
  C_ST_Edit = 'Edytuj';
  C_ST_RefreshKeys = 'Od�wie� klucze';
  C_ST_RefreshRows = 'Od�wie� wiersze';
  C_ST_Refresh = 'Od�wie�';

{ Podpowiedzi }

  H_UB_EDIT = 'Zmie� wiersz';
  H_UB_INSERT = 'Wstaw wiersz';
  H_UB_DELETE = 'Usu� wiersz';
  H_UB_REFRESH = 'Od�wie� rekordy';
  H_UB_REFRESHKEYS = 'Od�wie� klucze';
  H_UB_REFRESHROWS = 'Od�wie� wiersze';
  H_UB_REFRESHFILTROWS = 'Od�wie� filtrowane wiersze';
  H_UB_POSTSEARCH = 'Wy�lij kryteria poszukiwa�';
  H_UB_CANCELSEARCH = 'Pomi� kryteria poszukiwa�';
  H_UB_POSTEDIT = 'Wy�lij zmiany';
  H_UB_CANCELEDIT = 'Pomi� zmiany';
  H_UB_POSTINSERT = 'Wy�lij nowy wiersz';
  H_UB_CANCELINSERT = 'Pomi� nowy wiersz';
  H_UB_POSTDELETE = 'Usu� rekord';
  H_UB_CANCELDELETE = 'Anuluj usuni�cie';
  H_UB_POST = 'Wy�lij zmiany';
  H_UB_CANCEL = 'Pomi� zmiany';

  H_NB_FIRST = 'Pierwszy wiersz';
  H_NB_PRIOR = 'Poprzedni wiersz';
  H_NB_NEXT = 'Nast�pny wiersz';
  H_NB_LAST = 'Ostatni wiersz';
  H_NB_JUMPBCK = 'Wstecz';
  H_NB_JUMPFWD = 'Do przodu';

  H_SB_ORDER = 'Porz�dkuj wiersze';
  H_SB_LAST_CRITERIA = 'Przywo�aj kryteria ostatniego przeszukiwania';
  H_SB_SEARCH = 'Przeszukaj zbi�r';
  H_SB_SAVE_CRITERIA = 'Zapisz kryteria';
  H_SB_CLEAR_CRITERIA = 'Usu� kryteria';
  H_SB_RECALL_CRITERIA = 'Przywo�aj kryteria';
  H_SB_SEARCHCOUNT = 'Policz wiersze spe�niaj�ce kryteria';
  H_SB_COUNT = 'Policz wiersze';
  H_SB_RESTRUCTURE = 'Dostosuj wy�wietlanie p�l';

  H_TB_StartTransaction = 'Rozpocznij transakcj�';
  H_TB_PostDatasets = 'Zapisz zmiany';
  H_TB_CancelDatasets = 'Pomi� zmiany';
  H_TB_SavePoint = 'Zatwierd� i utrzymaj aktualn� transakcj�';
  H_TB_CommitRetain = 'Zapisz zmiany, zatwierd� i utrzymaj aktualn� transakcj�';
  H_TB_Commit = 'Zatwierd� i zamknij aktualn� transakcj�';
  H_TB_Rollback = 'Wycofaj i zamknij aktualn� transakcj�';
  H_TB_RollbackRetain = 'Wycofaj i utrzymaj aktualn� transakcj�';
  H_TB_Close = 'Zamknij aktualn� transakcj�';

  H_ST_Prepare_Statement = 'Przygotuj zapytanie';
  H_ST_Unprepare_Statement = 'Cofnij przygotuj zapytanie';
  H_ST_Execute_Statement = 'Wykonaj zapytanie';

  H_DS_Open_Dataset = 'Otw�rz baz�';
  H_DS_Close_Dataset = 'Zamknij baz�';
  H_DS_Prepare_Dataset = 'Przygotuj baz�';
  H_DS_Unprepare_Dataset = 'Cofnij przygotuj baz�';
  H_DS_ReadOnly_Dataset = 'Baza tylko do odczytu';

  H_CB_Create_Database = 'Stw�rz baz�';
  H_CB_Connect_Database = 'Pod��cz baz�';
  H_CB_Disconnect_Database = 'Od��cz baz�';
  H_CB_Drop_Database = 'Usu� baz�';

  H_RD_actHide = 'Ukryj wybrane pola';
  H_RD_actHideAll = 'Ukryj wszystkie pola';
  H_RD_actVisible = 'Odkryj wybrane pola';
  H_RD_actVisibleAll = 'Odkryj wszystkie pola';
  H_RD_actUp = 'Przesu� wybrane pola o pozycj� w g�r�';
  H_RD_actTop = 'Przesu� wybrane pola na pocz�tek';
  H_RD_actDown = 'Przesu� wybrane pola o pozycj� w d�';
  H_RD_actBottom = 'Przesu� wybrane pola na koniec';
  
  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Eksportuj z wyra�enia SELECT';

  // Komunikaty b��d�w - IB_Import
  eNoAsciiFileEnty           = 'Brak odwo�ania do pliku ascii';
  eNoDestTableEntry          = 'Brak odwo�ania do tabeli docelowej';
  eAsciiFileNotFound         = 'Plik Ascii %s nie zosta� znaleziony';
  eIniFileNotFound           = 'Plik Ini %s nie zosta� znaleziony';
  eNoAsciiFileAccess         = 'Nie mo�na otworzy� pliku %s';
  eInvalidCharFound          = 'Nieprawid�owy znak / format pliku tekstowego';
  eOutOfMemory               = 'Brak pami�ci';
  eFieldDescriptionError     = 'B��d w opisie pola';
  eWrongAsciiFieldCount      = 'Nieprawid�owa liczba p�l w pliku ascii';
  eWrongDecimalCount         = 'Nieprawid�owa liczba miejsc dziesi�tnych w (%s)';
  eWrongFieldWidth           = 'Nieprawid�owe pole w pliku ascii';

  // Obs�uga ekstrakcji metadanych
  // ------------------------

  // Nazwy typ�w encji
  STR_DDL_UnnamedItem = '<BEZ NAZWY>';
  STR_DDL_etDatabase = 'Baza danych';
  STR_DDL_etException = 'Wyj�tek';
  STR_DDL_etBlobFilter = 'Filtr BLOB';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'Generator';
  STR_DDL_etDomain = 'Domena';
  STR_DDL_etTable = 'Tabela';
  STR_DDL_etView = 'Widok';
  STR_DDL_etProcedure = 'Procedura';
  STR_DDL_etRole = 'Rola';
  STR_DDL_etPrimaryKey = 'Klucz g��wny';
  STR_DDL_etUniqueKey = 'Klucz unikatowy';
  STR_DDL_etForeignKey = 'Klucz obcy';
  STR_DDL_etConstraint = 'Regu�a';
  STR_DDL_etIndex = 'Indeks';
  STR_DDL_etTrigger = 'Wyzwalacz';
  STR_DDL_etPermission = 'Prawo';
  STR_DDL_etUDFParam = 'Parametr UDF';
  STR_DDL_etTableField = 'Pole tabeli';
  STR_DDL_etViewField = 'Pole widoku';
  STR_DDL_etProcParam = 'Parametr procedury';

  // Nazwy CodeOption
  STR_DDL_coCreateDatabase = 'Utw�rz baz�';
  STR_DDL_coSecondaryFiles = 'Tw�rz wt�rne pliki';
  STR_DDL_coDefineShadows = 'Tw�rz cie� bazy';
  STR_DDL_coSetGeneratorVal = 'Ustaw generator';
  STR_DDL_coResetExceptionNo = 'Resetuj numeracj� wyj�tku';
  STR_DDL_coRawFieldDefs = 'Definicje p�l typu Raw';
  STR_DDL_coIsolateAllComputed = 'Izoluj wszystkie pola wyliczane';
  STR_DDL_coReportMinor = 'Report Minor';
  STR_DDL_coAlwaysQuoted = 'Zawsze cytuj';
  STR_DDL_coAlwaysCharSet = 'Zawsze definiuj zestaw znak�w';
  STR_DDL_coIncludeDebug = 'Do��cz informacje debuggera';
  STR_DDL_coDescripAsComment = 'Opisy jako kometa�e';
  STR_DDL_coIgnoreDependencies = 'Ignoruj zale�no�ci';
  STR_DDL_coKeepCustomIndexNames = 'Zachowaj dostosowane nazwy indeks�w';
  
  // Nazwy CodePass
  STR_DDL_cpFull = 'Pe�ny';
  STR_DDL_cpInit = 'Wst�pny';
  STR_DDL_cpFinal = 'Ko�cowy';
  STR_DDL_cpAuto = 'Automatyczny';

  // Nazwy poziomu raportowania b��d�w
  STD_DDL_plNone       = 'Brak';
  STD_DDL_plMinor      = 'Niski';
  STD_DDL_plSuspicious = 'Podejrzane';
  STD_DDL_plWarning    = 'Uwagi';
  STD_DDL_plError      = 'B��dy';
  // Skr�cone nazwy poziomu raportowania b��d�w (do 5 znak�w)
  STD_DDL_plNone_s       = 'BRAK ';
  STD_DDL_plMinor_s      = 'NISKI';
  STD_DDL_plSuspicious_s = 'POD  ';
  STD_DDL_plWarning_s    = 'UWAGA';
  STD_DDL_plError_s      = 'B��D ';
  
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
  STR_DDL_CodePass = 'Przej�cie kodu';
  STR_DDL_ExtractToStrings = 'Przekszta�� w �ancuchy znak�w';
  STR_DDL_Reset = 'Resetuj';
  STR_DDL_ResetAll = 'Resetuj wszystko';
  STR_DDL_ProgressControls = 'Kontrolki post�pu';
  STR_DDL_Stop = 'Stop';
  STR_DDL_IncludeSystem = 'Do��cz obiekty systemowe';
  STR_DDL_NameMasks = 'Maski nazw';
  STR_DDL_SaveToFile = 'Zapisz do pliku';
  STR_DDL_RunScript = 'Run Script';
  STR_DDL_ScriptCommands = '&Script Commands';
  
  // B��dy/Problemy generowane podczas ekstrakcji danych
  // Wszystkie zast�powane elementy sygnalizowane s� wyst�pieniem %s (string), niezb�dne
  // konwersje typ�w s� wykonywane w kodzie
  E_DDL_CURSOR_NOT_CREATED = 'Nie utworzono kursora';
  E_DDL_BLANK_NAME         = 'Nazwa pusta';
  E_DDL_ENTITY_NOT_FOUND   = 'Nie znaleziono encji';
  E_DDL_RESERVED_NAME      = 'Nazwa zarezerwowana u�yta dla oznaczenia niesystemowej encji';
  E_DDL_DB_CHARSET_NOT_FOUND = 'Nie znaleziono nazwy kanonicznej dla zestawu znak�w %s';
  E_DDL_MODULE_NAME_EMPTY  = 'Pusta nazwa modu�u';
  E_DDL_ENTRY_POINT_EMPTY  = 'Nie podano punktu wej�cia';
  E_DDL_DOMAIN_MUST_BE_EXPLICIT = 'Zewn�trzna domena mo�e by� tylko typu implicit';
  E_DDL_DOMAIN_TYPE_16     = 'Typu 16 mo�e by� tylko NUMERIC lub DECIMAL';
  E_DDL_CHARSET_NULL_ASSUME_NONE = 'Podano pusty identyfikator zestawu znak�w, przyjmuj� NONE';
  E_DDL_CHARSET_BLANK_ASSUME_NONE = 'Nie podano nazwy zestawu znak�w %s Przyjmuj� NONE';
  E_DDL_BPC_ZERO_IN_CHARSET = 'BytesPerCharacter ma warto�� 0 dla zestawu znak�w %s';
  E_DDL_FIELDLEN_MISMATCH  = 'D�ugo�� pola %s powinna by� wielokrotno�ci� %s bajt�w/znak w zestawie %s';
  E_DDL_INVALID_COLLATIONID = 'Identyfikator porz�dku sortowania nie mo�e by� < 0 a wynosi %s';
  E_DDL_COLLATION_NULL_ASSUME = 'Identyfikator porz�dku sortowania ma warto�� NULL, przyjmuj� %s';
  E_DDL_UNKNOWN_FIELD_TYPE = 'Nieznany typ pola (FieldType) %s';
  E_DDL_CSTRING_IN_DSQL = 'FieldType CSTRING nie jest akceptowany przez DSQL';
  E_DDL_QUAD_IN_DSQL = 'FieldType QUAD nie jest akceptowany przez DSQL';
  E_DDL_SUSPICIOUS_CHECK = 'Suspicious check: %s';
  E_DDL_VOID_CHECK_CONSTRAINT = 'Zadeklarowano ograniczenie check ale go brak';
  E_DDL_EXPLICIT_COMPUTED = 'Domena Explicit nie mo�e by� typu COMPUTED';
  E_DDL_VOID_COMPUTED = 'Zadeklarowano klauzul� COMPUTED BY ale jej brak';
  E_DDL_SUSPICIOUS_DEFAULT = 'Suspicious default: %s';
  E_DDL_VOID_DEFAULT = 'Zadeklarowano klauzul� default ale jej brak';
  E_DDL_DIMENSIONS_MISMATCH = 'Zadeklarowano %s wymiar�w a znaleziono opis dla %s.';
  E_DDL_IMPLICIT_DOMAIN_NO_RELATION = 'Domena typu implicit nie posiada relacji.';
  E_DDL_IMPLICIT_DOMAIN_NO_FIELD = 'Domena typu implicit nie posiada nazwy pola lub relacji.';
  E_DDL_NO_OUTPUT_PARAMETER = 'Brak parametru wyj�ciowego';
  E_DDL_NO_GRANTOR = 'Nie wyspecyfikowano nadaj�cego uprawnienie';
  E_DDL_VIEW_NO_BLR = 'Brakuje view_blr ale znaleziono go w rdb$view_relations jako WIDOK';
  E_DDL_VIEW_NO_VIEW_RELATION = 'Jest view_blr ale nie ma go w rdb$view_relations jako WIDOK';
  E_DDL_NO_OWNER = 'Nie podano nazwy w�a�ciciela';
  E_DDL_FORMAT_VERSION = 'Format version at %s';
  E_DDL_DBKEY_LEN = 'DbKey_Length powinna by� 8 a jest %s';
  E_DDL_NO_DOMAIN_FOR_FIELD = 'NIe znaleziono definicji Domeny/Pola dla %s';
  E_DDL_NO_SOURCE_CODE = 'Brak kodu �r�d�owego';
  E_DDL_WITH_CHECK_COMPLETION = '"With check" uzupe�niono do "with check option"';
  E_DDL_NO_BLR = 'Brakuje BLR';
  E_DDL_CORRUPT_SOURCE = 'Nierozpoznawalny prefiks �r�d�owy, mo�e to by� oznak� uszkodzenia';
  E_DDL_INDEX_ID_NULL_INACTIVE = 'Id ma warto�� NULL a indeks jest nieaktywny';
  E_DDL_INDEX_ID_NULL_ACTIVE = 'Id ma warto�� NULL ale indeks jest aktywny';
  E_DDL_INVALID_INDEX_ID = 'Id powinien si� zaczyna� od 1 a nie od %s';
  E_DDL_FK_INDEX_NO_CONSTRAINT = 'Zadeklarowano klucz obcy ale nie znaleziono go w ograniczeniach integralno�ci jako indeks FK';
  E_DDL_CONSTRAINT_NO_FK_INDEX = 'Nie zadeklarowano klucza obcego a znaleziono go w ograniczeniach integralno�ci jako indeks FK';
  E_DDL_INDEX_MULTI_USE = 'U�yto ju� w ograniczeniu integralno�ci %s';
  E_DDL_INDEX_NO_FIELDS = 'U�ywa p�l %s';
  E_DDL_INDEX_DUPLICATE = 'Wydaje si�, �e istnieje podw�jna definicja indeksu w tabeli: %s';
  E_DDL_INDEX_SEG_MISMATCH = 'Indeks w tabeli: %s deklaruje %s segment�w, ale znaleziono ich %s';
  E_DDL_CONSTRAINT_OUT_OF_RANGE = 'Typ ograniczenia %s jest poza zakresem';
  E_DDL_CONSTRAINT_USING_INDEX = 'Typ ograniczenia %s nie powinien u�ywa� indeksu a u�ywa: %s';
  E_DDL_CONSTRAINT_NO_INDEX = 'Typ ograniczenia %s powinien u�ywa� indeksu a nie robi tego';
  E_DDL_UPDATE_RULE_INVALID = 'Zasada Update %s jest poza zakresem';
  E_DDL_DELETE_RULE_INVALID = 'Zasada Delete %s jest poza zakresem';
  E_DDL_PARENT_CONSTRAINT_EMPTY = 'Brak nazwy ograniczenia dla relacji rodzicielskiej';
  E_DDL_FOREIGN_NOT_DEFINED = 'Obca tabela lub indeks nie zosta�a zdefiniowana';
  E_DDL_PARENT_SHOULD_BE_EMPTY = 'Nazwa ograniczenia dla relacji rodzicielskiej powinna by� pusta a jest %s';
  E_DDL_UPDATE_SHOULD_BE_EMPTY = 'Zasada Update powinna by� pusta a jest %s';
  E_DDL_DELETE_SHOULD_BE_EMPTY = 'Zasada Delete powinna by� pusta a jest %s';
  E_DDL_NO_BLR_WITH_CHECK =  'Nie ma kodu �r�d�owego, prawdopodobnie u�yto dla widoku %s z opcj� check';
  E_DDL_TRIGGER_LOST_CHECK = 'Rozpoczyna si� klauzul� "CHECK" i jest wykorzystywane przez ograniczenie typu check kt�re zosta�o utracone.';
  E_DDL_UNKNOWN_TRIGGER_TYPE = 'Nieznany typ wyzwalacza %s';
  E_DDL_NEGATIVE_SEQUENCE = 'Ma ujemn� kolejno�� %s';
  E_DDL_NO_TARGET_RELATION = 'Nie podano docelowej tabeli lub widoku';
  E_DDL_NOT_IN_DEPENDENCIES = 'Zadeklarowano ale nie znaleziono w zale�no�ciach. W pewnych okoliczno�ciach nie jest to b��d';
  E_DDL_SUSPICIOUS_TRIGGER = 'Podejrzany wyzwalacz zale�y od innych tabel a nie od tej do kt�rej jest pod��czony.';
  E_DDL_INVALID_TRIGGER_SEQ = 'Sekwencja dla wyzwalacza wynosi %s a powinna by� mniejsza od 1 dla wyzwalacza typu implicit';
  E_DDL_GRANT_OUT_OF_RANGE = 'Opcja Grant/Admin poza zakresem 0..2: %s';
  E_DDL_GRANT_TO_USER_TYPE = 'Opcj� Grant/Admin przypisano do u�ytkownika typu %s';
  E_DDL_GRANT_FIELDS = 'Pr�buj� ustawi� podane p�la ale uprawnienia nie s� U lub R';
  E_DDL_EXECUTE_TO_OBJECT = 'Przypisanie EXECUTE do obiektu typu %s kt�ry powinien mie� warto�� 5 (proc)';
  E_DDL_BAD_PRIV_ON_PROC = 'Przypisanie %s procedurze %s';
  E_DDL_MEMBER_TO_OBJECT = 'Przypisanie cz�onkowstwa obiektowi typu %s kt�ry powinien mie� warto�� 13 (rola)';
  E_DDL_BAD_PRIV_ON_ROLE = 'Przypisanie %s do roli %s';
  E_DDL_BAD_ARG_POS =  'Pozycja argumentu powinna by� >=0 a jest %s';
  E_DDL_SYSTEM_FLAG_MISMATCH = 'Warto�� SystemFlag r�na od rodzica';
  E_DDL_BAD_FIELD_ID = 'Pole Id powinno by� >=0 a jest %s';
  E_DDL_BAD_FIELD_POS = 'Pozycja pola powinna by� >=0 a jest %s';
  E_DDL_BAD_TABLE_BASEFIELD = 'BaseField powinien by� dla tabel pusty a ma warto�� %s';
  E_DDL_BAD_TABLE_VIEWCONTEXT = 'ViewContext powinien by� dla tabel pusty a ma warto�� %s';
  E_DDL_MANDATORY_IN_VIEW = 'Nie mo�e by� obowi�zkowy dla widok�w';
  E_DDL_BASEFIELD_EMPTY = 'BaseField nie powinien by� pusty dla widok�w je�li ViewContext > 0';
  E_DDL_VIEWCONTEXT_EMPTY = 'ViewContext nie powinien by� pusty dla widok�w';
  E_DDL_VIEWCONTEXT_NEGATIVE = 'ViewContext powinien by� >= 0 dla widok�w';
  E_DDL_BAD_PARAM_TYPE = 'Typ parametru %s jest poza zakresem';
  E_DDL_BAD_PARAM_NUM = 'Numer parametru powinien by� >=0 a jest %s';

  // Komenta�e zwracane przez polecenia DDL
  C_DDL_CONNECT_USERNAME   = 'Pod��cz jako (u�ytkownik): %s';
  C_DDL_CONNECT_SERVER_VER = 'do serwera: %s';
  C_DDL_SQL_DIALECT = 'SQL DIALECT = %s';
  C_DDL_CHARACTER_SET = 'DEFAULT CHARACTER SET = %s';
  C_DDL_NO_SEC_FILES = 'Brak plik�w wt�rnych';
  C_DDL_SEC_FILES = 'Pliki wt�rne';
  C_DDL_SEC_FILE_DESC = '%s, Start: %s, D�ugo��: %s';
  C_DDL_NO_SHADOW_FILES = 'Brak plik�w-cieni';
  C_DDL_SHADOW_FILES = 'Pliki-cienie';
  C_DDL_SHADOW_FILE_DESC = '%s, %s, Start: %s, D�ugo��: %s';
  C_DDL_EXCEPTION_DESC = 'Wyj�tek: %s, Numer oryginalny: %s';
  C_DDL_FIELD_NOT_FOUND = 'Nie znaleziono pola: %s';
  C_DDL_INDEX_NOT_FOUND = 'Nie znaleziono indeksu';
  C_DDL_NO_FOREIGN_RELATION = 'Nie zdefiniowano obcej relacji lub indeksu dla podanego ograniczenia';
  C_DDL_FOREIGN_NOT_FOUND = 'Nie znaleziono obcej relacji: %s';
  C_DDL_FOREIGN_IDX_NOT_FOUND = 'Nie znaleziono klucza obcego: %s';
  C_DDL_TRIGGER_NOT_FOUND = 'Nie znaleziono wyzwalacza: %s';
  C_DDL_INVALID_CONSTRAINT_TYPE = 'Nieprawid�owa nazwa typu ograniczenia: %s';
  C_DDL_NO_TRIGGER_SOURCE = 'Brak �r�d�a dla wyzwalacza: %s';
  C_DDL_BAD_TRIGGER_TYPE = 'Nieznany TriggerType: %s';
  C_DDL_BAD_PRIVILEGE = 'Nieznane uprawnienie: %s';


implementation

end.
