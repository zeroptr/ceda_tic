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
{  Rita Lavoie <rita.lavoie@sympatico.ca>                                      }
{  March 8th 2002                                                              }
{                                                                              }
{ IB_Constants Usage : Renommer ce fichier IB_Constants.pas                    }
{ En conservant l'original IB_Constants.pas sous IB_Constants-Ori.pas          }
{ Version traduite par Rita Lavoie                                             }
{                                                                              }
{ Contribution de                                                              }
{ Fernand Veilleux <fernveilleux@videotron.ca>                                 }
{ 8 mars 2002                                                                  }
{ Correction et ajout                                                          }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Constants;

interface

var
// C'est le nom de la DLL (API) InterBase Client utilis�e.
// Inscrivez l'unit� IB_Session511.pas en premier dans la clause USES
// de votre projet pour modifier cette variable et employer la version
// modifi� de la librairie client.
  IB_GDS32: string = 'gds32.dll';

const
// C'est la constante que j'utilise pour indiquer qu'un bug d'Interbase est
// r�solue afin qu'un jeu d'appels optimum soit employ�.
  BUG_EXEC2 = true;

// Information de Version
  IB_VERSION_MAJOR = '4';
  IB_VERSION_MINOR = '2';
  IB_VERSION_BUILD = 'G';
  IB_VERSION_SUB_RELEASE = 'a';
  
  IB_BASEKEY = 'Software\CPS\IBO';

// Initialisations internes
  IB_RDB = 'RDB$';
  IB_DB_KEY = 'DB_KEY';

// Syntaxe de Param�tres
  IB_BINDLINK = 'BIND_';
  IB_MASTERLINK = 'MLNK_';
  IB_KEYLINK = 'KLNK_';
  IB_ORDLINK = 'OLNK_';
  IB_PARAMETER = 'PRM_';
  IB_QBE_PARAMETER = 'QBE_';
  IB_LOCATE_PARAMETER = 'LOC_';
  IB_RNGBEG = 'RBEG_';
  IB_RNGEND = 'REND_';

// Indices g�n�raux
  IB_TRUE = 'TRUE';
  IB_FALSE = 'FALSE';
  IB_AND = #13#10'  AND ';

// Noms des param�tres de Connections. ( Ne pas traduire S.V.P.! )
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


// Diverses initialisations � utiliser dans la propri�t�e ColumnAttributes.
  IB_BINARY      = 'BINARY';     // Indice de CHAR ou VARCHAR d'une colonne binaire.
  IB_BLANKISNULL = 'BLANKISNULL';// Utilis� par TIB_Column class losqu'on affecte
                                 // une cha�ne vierge � un Champ.
  IB_BOOLEAN     = 'BOOLEAN';    // Utilis� pour pr�ciser la valeur � utiliser
                                 // dans un Champ BOOLEAN.
  IB_COMPUTED    = 'COMPUTED';   // Pr�cise que ce champs est actuellement
                                 // un champs COMPUTED BY d'autres champs.
  IB_CURRENCY    = 'CURRENCY';   // Pr�cise que cette collonne est un Champ [CURRENCY]
  IB_NOCASE      = 'NOCASE';     // Indice d'une recherche sans respect de la casse
  IB_NODATE      = 'NODATE';     // Un champs TDateTime sans la date
  IB_NOSOUNDEX   = 'NOSOUNDEX';  // Annule proc�dure soundex dans une Table
  IB_NOTIME      = 'NOTIME';     // Un champs TDateTime sans l'heure
  IB_NOTRAILING  = 'NOTRAILING'; // Indice d'emploi de STARTING  dans une cha�ne de caract�res
  IB_NOTREQUIRED = 'NOTREQUIRED';
  IB_REQUIRED    = 'REQUIRED';
  IB_SOUNDEX     = 'SOUNDEX';    // Indice d'emploi de SoundEx dans un champ recherche
  IB_BCD         = 'BCD';        // Indice pour forcer une colonne � �tre du type TIBOBCDField
  IB_NOBCD       = 'NOBCD';      // Indice pour forcer une colonne � �tre du type TIBOFloatField
  IB_YESCASE     = 'YESCASE';    // Indice d'annulation de CN.DefaultNoCase
  IB_YESLIKE     = 'YESLIKE';    // Indice d'emploi de LIKE  dans une cha�ne de caract�res
  IB_YESTRAILING = 'YESTRAILING';// Flag to override CN.DefaultNoTrailing

// Employ�s dans la Barre de Recherche pour la propri�t� des champs en lecture seule
  IB_NOINSERT = 'NOINSERT';
  IB_NOEDIT   = 'NOEDIT';
  IB_NOSEARCH = 'NOSEARCH';

// Events
  IB_MaxEvents = 15;
  IB_EventLength = 64;

// Session
  IB_ISC_ERR_CODE_MSG = 'CODE D''ERREUR ISC:';
  IB_ISC_ERR_MSG_MSG  = 'MESSAGE D''ERREUR ISC:';
  IB_SQL_ERR_CODE_MSG = 'CODE D''ERREUR SQL:';
  IB_SQL_ERR_MSG_MSG  = 'MESSAGE D''ERREUR SQL:';

// Global Defaults  ( Ne pas modifier )
  G_DefaultRowHeight  = 17;
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

  IB_REG_MESSAGE = 'Merci d''�valuer IB Objects.'#10#13#10#13+
                   'S.V.P. joindre http://www.ibobjects.com'#10#13+
                   'et enregistrez-vous maintenant.';

{ Messages d'erreurs de IB_Connection, IB_Transaction, IB_Statement }

  E_CONNECTED         = 'La Connexion a d�j� �t� �tablie';
  E_NOT_CONNECTED     = 'Connexion n''a pas �t� �tablie';
  E_Invalid_conn_path = 'Chemin de connexion invalide';
  E_Cant_Repl_Int_Tr  = 'Remplacement de Transaction interne par d�faut refus�';
  E_NO_TRANS_STARTED  = 'Aucune Transaction n''a �t� amorc�e';
  E_TRANS_STARTED     = 'Une Transaction est d�j� amorc�e';
  E_NO_CONNECTIONS    = 'La Transaction est sans connexions';
  E_NOT_ENOUGH_CONN   = 'La Transaction manque d''une ou plusieurs connexions';
  E_CONN_LOADING      = 'Avertissement: Connexion en cours de chargement';
  E_TRANS_CONN_SESS   = 'Les Connexions doivent toutes �tre dans la m�me [IB_Session]';
  E_TransactionPaused = 'La Transaction est en mode [Paused]'; // 'Transaction is Paused'
  E_ALLOCATED         = 'La Requ�te a d�j� �t� prescrite';
  E_NOT_ALLOCATED     = 'La Requ�te n''a pas �t� prescrite';
  E_PREPARED          = 'La Requ�te a d�j� �t� Pr�par�e';
  E_NOT_PREPARED      = 'La Requ�te n''a pas �t� Pr�par�e';
  E_FAILED_TO_PREPARE = 'Pr�paration de la Requ�te rat�e';
  E_OPENED            = 'La Requ�te a d�j� �t� ouverte';
  E_NOT_OPENED        = 'La Requ�te n''a pas �t� ouverte';
  E_CANT_DELETE       = 'Le dossier courant du curseur ne peut �tre supprim�';
  E_NO_CONNECTION     = 'La Requ�te doit �tre associ�e � une IB_Connection';
  E_CONNECT_FAILED    = 'Impossible d''ouvrir l''IB_Connection';
  E_NO_TRANSACTION    = 'La Requ�te doit �tre associ�e � une IB_Transaction';
  E_NO_ACTIVE_TRANS   = 'Aucune Transaction active � ex�cuter...';
  E_START_FAILED      = 'Impossible d''amorcer une Transaction';
  E_SVRAUTOCMT_NOEXP  = 'Transaction explicite refus�e avec ServerAutoCommit';
  E_Cannot_Activate     = '�tat de Transaction invalide.  Ex�cution impossible';
  E_Transaction_Is_Active = 'La Transaction n''a pas �t� compl�t�e';
  E_Failed_To_Post_Datasets = 'Sauvegarde de toutes les Tables rat�e';
  E_Failed_To_Cancel_Datasets = 'Annulation de toutes les Tables rat�e';
  E_UpdateWrongTrn    = 'Mise � jour refus�e, %s n''est pas contr�l� par %s';
  E_NO_BLANK_SQL      = 'Requ�te SQL vierge refus�e';
  E_AT_END_OF_FILE    = '� la fin du fichier';
  E_AT_END_OF_CURSOR  = '� la fin du curseur';
  E_AT_END_OF_BUFFER  = '� la fin du tampon';
  E_AT_END_OF_DATASET = '� la fin de la Table ';
  E_BAD_SQL_INF_LEN = 'Taille impr�vue dans [isc_dsql_sql_info]';
  E_BAD_SQL_INF_DATA = 'Donn�es invalides renvoy�es par [isc_dsql_sql_info]';
  E_CURSOR_NAME_LOCK = 'Le nom d''un Curseur actif ne peut �tre modifi�';
  E_REQUEST_LIVE_ACTIVE = '[RequestLive] ne peut �tre modifi� en mode actif';
  E_REQUEST_LIVE_READONLY = '[RequestLive] impossible sur une Table en lecture seule';
  E_CURSOR_UNI = 'IB_CURSOR est unidirectionnel';
  E_UNSUPPORTED_COLUMN_TYPE  = 'Type de colonne [%d] non support�';
  E_FIELDNO_NOT_FOUND = 'FieldNo: %d inexistant';
  E_FIELDNAME_NOT_FOUND = 'FieldName: %s inexistant';
  E_INVALID_FOCUS_RELATION_NO = 'La Relation s�lectionn�e No: %d est invalide';
  E_INVALID_FOCUS_RELATION_NAME = 'La Relation s�lectionn�e [%s] est invalide';
  E_INVALID_QBE_IN = 'Erreur de syntaxe dans IN( valeur [ , valeur ... ] )';
  E_INVALID_QBE_BETWEEN = 'Erreur de syntaxe dans valeur [BETWEEN] et valeur [AND]';
  E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Impossible de trouver la DLL d''import %s';
  E_INVALID_SQL_KEY_FIELDS  = 'Propri�t� [SQLKeyFields] invalide';
  E_GET_CURSOR_ERROR = 'Ouverture du Curseur impossible sans cl�-ma�tresse';
  E_SCROLL_ERROR = 'Cl�-ma�tresse perdue...!'#10#13'Ouverture Curseur rat�e.';
  E_INVALID_BUFFER_ROW_NUM = '[BufferRowNum] invalide avant le lancement';
  E_BLANK_STATEMENT = 'Impossible de Pr�parer une Requ�te vierge';
  E_UNKNOWN_STATEMENT = 'Tentative d''ex�cution d''une Requ�te invalide';
  E_CIRCULAR_REFERENCE = 'R�f�rence circulaire refus�e';
  E_CANT_CHG_WITH_CONN = 'Modification refus�e lorsque connect�';
  E_LOGIN_FAILED      = 'Acc�s refus�';
  E_CANT_GET_CONN_CHR = 'Impossible de d''obtenir les Caract�ristiques de Connexion';
  E_MAX_EVENTS_BLOCK  = 'Nombre d''�v�nements surcharg� pour un bloc';
  E_PROCESSING_EVENTS = '�v�nements en cours d''ex�cution!'#13#10'Suppression au registre impossible.';
  E_CANT_STORE_BLOB = 'Champ [Blob] ne peut �tre ou a d�j� �t� sauv�';
  E_CANT_LOAD_BLOB = 'Champ [Blob] ne peut �tre ou a d�j� �t� charg�';
  E_CANNOT_CANCEL_ROW = 'Annulation du Rang s�lectionn� refus�e';
  E_CANNOT_POST_ROW = 'Sauvegarde du Rang s�lectionn� refus�e';
  E_DatasetClosed = 'Table est inactive';
  E_DatasetOpen = 'Table est pr�sentement active';
  E_DatasetCannotScroll = 'D�filement de la Table refus�';
  E_DatasetReadOnly = 'La Table est en lecture seule';
  E_DatasetIsFetching = 'R�sultat en cours d''ex�cution';
  E_Invalid_KeyRelation = 'Valeur de [KeyRelation] invalide';
  E_RowNum_Not_Implemented = '[RowNum] non encore impl�ment�';
  E_RowDeleted = 'Le Rang est en cours de suppression';
  E_END_OF_DATASET  = '� la fin de la Table';
  E_BEGINNING_OF_DATASET   = 'Au d�but de la Table';
  E_Cannot_Pessimistic_Lock = 'Verrouillage [pessimistique] impossible avec [LockWait]';
  E_Cannot_Edit_Row = '�dition du Rang s�lectionn� refus�';
  E_Cannot_Insert_Row = 'Ajout d''un Rang refus�';
  E_Cannot_Delete_Row = 'Suppression du Rang s�lectionn� refus�e';
  E_Cannot_Search = 'Recherche non permise';
  E_Cannot_Navigate = 'Fureter refus�';
  E_Record_Locked = 'Le dossier est verrouill� par un autre usager';
  E_Record_OutOfSynch = 'Le dossier a �t� modifi� par un autre usager';
  E_FLD_READONLY = '%s est en lecture seule';
  E_Required_Field = '%s est un Champ requis';
  E_NO_POSTRTN_CACHED_UPDT = '[PostRetaining] inutilisable avec [Cached Updates]';
  E_Multiple_Rows_In_Singleton = 'Plusieurs dossiers en une seule transaction';

  E_InvalidRowsAffectedBuf = 'Tampon [RowsAffected] invalide';
  E_Invalid_RowNum_Past_Eof = '[RowNum] d�passe [Eof] Fin du fichier';
  E_Invalid_RowNum_Before_Bof = '[RowNum] pr�c�de [Bof] D�but du fichier';
  E_Invalid_Bookmark = 'Cha�ne Signet(Bookmark) invalide';

  E_Assign_Column  = 'Ne peut copier depuis %s';
  E_AssignTo_Column = 'Ne peut copier vers %s';
  E_Value_Out_Of_Range = 'Valeur hors-champ';
  E_SmallintOverflow = '[Smallint] surcharg�';
  E_IntegerOverflow = '[Integer] surcharg�';
  E_Int64Overflow = '[Int64] surcharg�';

  E_Unsupported_Column = 'Type de colonne [%d] non support�';
  E_UndefinedMacro = 'Macro non d�finie';
  E_GeneratorFailed = 'Impossible d''obtenir la valeur du G�n�rateur';

  E_MustBe_Buffered_Dataset = '[IB_Query] doit d�coul� de [TIB_BDataset]';

  E_NO_CHANGE_READONLY = 'Modifier [ReadOnly] impossible lorqu''amorc�';
  E_NO_CHANGE_ISOLATION = 'Modifier [Isolation] impossible lorqu''amorc�';
  E_NO_CHANGE_RECVERSION = 'Modifier [RecVersion] impossible lorqu''amorc�';
  E_NO_CHANGE_LOCKWAIT = 'Modifier [LockWait] impossible lorqu''amorc�';

  E_Invalid_Reference_To_Delete = 'R�f�rence de Suppression invalide';
  E_53BIT_OVERFLOW = 'Nombre entier 53bit surcharg�';
  E_Invalid_Typecast = 'Transtypage invalide';
  E_Invalid_DataPump_Statement = 'Type Requ�te invalide pour [DataPump]';
  E_FIELD_NOT_NULLABLE = 'Champ [NOT NULL] report� � valeur [NULL]';
  E_DATABASE_BLANK = 'Le nom de la Base de donn�es ne peut �tre vierge';
  E_Unsupp_Col_Conversion = 'Conversion de colonne non support�e';
  E_Unable_To_Locate_Record = 'Impossible de trouver le dossier';
  E_Record_Not_Inserted = 'Le dossier n''a pas �t� ajout�';
  E_Invalid_KeyLinks = 'Entr�e [KeyLinks] invalide: %s';
  E_Unable_to_perform_search = 'Impossible d''effectuer la Recherche';
  E_Unassigned_Blob_Node = '[BlobNode] non prescrit';
  E_Unassigned_Transaction = 'Transaction non prescrite';
  E_Invalid_RowsAffected_Buffer = 'Tampon [RowsAffected] invalice';
  E_Unable_Save_Graphic = 'Sauvegarde de l''Image impossible';
  E_Cannot_Activate_Transaction = 'Impossible d''activer la Transaction';
  E_IB_Client_Not_Installed = 'Le Client InterBase GDS32.DLL n''est pas install�';
  E_Could_Not_Load_Memo = 'Chargement du [memo] impossible';
  E_Invalid_DPB_Over_255 = 'DBP invalide: contient plus de 255 caract�res';
  E_Inv_Custom_DML = 'R�f�rence de colonne DML personnalis�e invalide : %s';
  E_Record_Not_Located_For_Update = 'Dossier de mise � jour non trouv�';
  E_Record_Not_Located_For_Delete = 'Dossier de suppression non trouv�';
  E_Init_Default_SQL_Failed = 'Impossible d''initialiser %s par d�faut';
  E_Stringlist_Not_Sorted = 'La [StringList] doit �tre index�e pour cette op�ration';
  E_Cannot_Change_Events = 'Traitement en cours d''ex�cution.  Modification refus�e';
  E_Cannot_Unregister_Events = 'Traitement en cours d''ex�cution.'#13#10'Suppression d''entr�e au registre impossible';
  E_Invalid_Internal_Transaction = '[IB_Transaction] interne invalide';
  E_InvalidStatementType = 'Type de Requ�te invalide';
  E_Multiple_Records_Updated = 'Plusieurs dossiers mis � jour';
  E_Multiple_Records_Deleted = 'Plusieurs dossiers supprim�s';
  E_Multiple_Records_Inserted = 'Plusieurs dossiers ins�r�s';
  E_DUP_DB_NAME = 'Le nom de la Base de donn�es doit �tre unique';
  E_INVALID_DB_NAME = 'Nom de la Base de donn�es invalide';
  E_UnableToSearch_NoOrdering = 'Ne peut ex�cuter la recherche, aucun index d�fini';
  E_UnableToSearch_DatasetBusy = 'Ne peut ex�cuter la recherche, en cours d''ex�cution';
  E_NoRecordsFound = 'Dossiers inexistants';
  E_Session_Undefined = 'La Session n''est pas d�finie';
  E_NoCircularRef = 'R�f�rence circulaire refus�e';
  E_InvalidClassType = 'Type de Classe invalide';
  E_Invalid_RowNum = '[RowNum] invalide';
  E_Invalid_Syntax = 'Syntaxe invalide: parenth�ses en trop ou en moins';
  E_Array_Is_Null = 'L''[Array] est Null';

  E_Cannot_add_blank_account = 'Ajout d''un USAGER vierge refus�';
  E_Cannot_add_SYSDBA_account = 'Ajout d''un USAGER SYSDBA refus�';
  E_Cannot_delete_blank_account = 'Ne peut supprimer un USAGER vierge';
  E_Cannot_delete_SYSDBA_account = 'Suppression de l''USAGER SYSDBA refus�';
  E_Cannot_modify_blank_account = 'Ne peut modifier un USAGER vierge';

  E_PLAN_ERROR = 'ERREUR PLAN!';
  E_PLAN_EXCEPTION = 'EXCEPTION PLAN!';

  E_INV_CREATE_CONNECT_DROP = 'Syntaxe de CREATE, CONNECT ou DROP DATABASE invalide';
  E_Unsupported = 'Non support�';
  E_NotImplemented = 'Non impl�ment� � ce jour';
  E_Invalid_ColData = '[ColData] invalide';

  E_Cant_Unprepare_executing_process = 'Lib�rer [Unprepare] impossible. Traitement en cours';
  E_FileName_Required = 'Nom de fichier requis';

{ Labels for various default dialogs used in IBO }

//IBF_Users
  L_USERS_FRM = 'Gestionnaire d''acc�s des USAGERS';
  L_USERS_ADD = 'Ajouter';
  L_USERS_DELETE = 'Supprimer';
  L_USERS_MODIFIY = 'Modifier';
  L_USERS_ACCOUNT = 'USAGER';
  L_USERS_PASSWORD = 'Mot de P.';
  L_USERS_GROUP = 'Groupe';
  L_USERS_FIRSTNAME = 'Pr�nom';
  L_USERS_MIDDLENAME = 'Initiale';
  L_USERS_LASTNAME = 'Nom';

//IBF_Export
  L_EXPORT_FRM = 'Exporter';
  L_EXPORT_ASCII = ' Format Fichier';
  L_EXPORT_FIXED = 'Taille dossier TXT fixe';
  L_EXPORT_DELIMITED = 'CSV D�limit�';
  L_EXPORT_DBF  = 'DBF (Doit �tre encore test�)';
  L_EXPORT_ASCIIOPT  = ' Options ASCII ';
  L_EXPORT_DELIMITER  = 'D�limiteur';
  L_EXPORT_SEPARATOR  = 'S�parateur';
  L_EXPORT_DATEFORMAT  = 'Format Date';
  L_EXPORT_INCLUDEHEADERS  = 'Inclure Ent�tes';
  L_EXPORT_INCLUDECRLF  = 'Inclure CRLF';
  L_EXPORT_SDEXPORTTITLE = 'Exporter';
  L_EXPORT_SDEXPORTFILTERCSV = 'Fichiers texte s�par� par virgule ( *.CSV )|*.CSV';
  L_EXPORT_SDEXPORTFILTERTXT = 'Fichiers Texte ( *.TXT )|*.TXT';
  L_EXPORT_SDEXPORTFILTERDBF = 'Fichiers DBF ( *.DBF )|*.DBF';

{ Message constants for various default dialogs used in IBO }

  M_Abort_Fetching = 'Vraiment annuler la proc�dure?';
  M_Fetching_Query_Results = 'R�sultats de la Requ�te';
  M_Row_Num = 'Rang# %d';
  M_Abort_Fetching_Btn = 'Stopper';

  M_Login_Database = 'Base de D.';
  M_Login_User = 'Usager';
  M_Login_Password = 'Mot de P.';
  M_Login_OK_Btn = 'OK';
  M_Login_Cancel_Btn = 'Annuler';
  M_Login_Help_Btn = '&Aide';
  M_Login_Dialog_Caption = 'Autorisation d''acc�s';

  M_Loading_Caption = 'Chargement...';

  M_SB_REC_CNT = 'Dossiers compt�s: %d';
  M_Save_Changes = 'Enregistrer les changements?';
  M_Abort_Changes = 'Les changements seront annul�s. Continuer?';  

  M_CancelTransactionPrompt = 'Vraiment annuler tous les changements?';

  M_SCRIPT_ABORT_EXECUTE = 'Stopper l''ex�cution du sc�nario?';
  M_SCRIPT_CONTINUE_EXECUTING = 'Continuer l''ex�cution du sc�nario?';
  M_SCRIPT_IS_EXECUTING = 'Sc�nario en cours d''ex�cution';
  M_SCRIPT_FAILED = 'Ex�cution du sc�nario rat�e avant terme';
  M_SCRIPT_WAS_ABORTED = 'L''ex�cution du sc�nario a �t� stopp�e';
  M_SCRIPT_COMPLETED = 'Sc�nario ex�cut� avec succ�s';
  M_SCRIPT_CMPL_EXCEPT = 'Sc�nario compl�t� avec Exceptions';
  M_SCRIPT_MODIFIED = 'Modifi�';
  M_SCRIPT_SAVE_CHANGES = 'Enregistrer les changements?';

{ Button captions }

  C_BTN_TODAY = 'Aujourd''hui';
  C_BTN_CLEAR = 'Vider';

  C_SG_Parameter = 'Param�tre';
  C_SG_Field = 'Champ';
  C_SG_Name = 'Nom';
  C_SG_Type = 'Type';
  C_SG_Info = 'Info';
  C_SG_Value = 'Valeur';

  C_BF_OK = 'OK';
  C_BF_CANCEL = 'Annuler';
  C_BF_CANCEL_ACCEL = '&Annuler';
  C_BF_APPLY = 'Appliquer';
  C_BF_HELP = 'Aide';
  C_BF_EXECUTE = 'Ex�cuter';
  C_BF_CLOSE = 'Fermer';
  C_BF_CLOSE_ACCEL = '&Fermer';
  C_BF_FINISH = 'Terminer';
  C_BF_FINISH_ACCEL = '&Terminer';

  C_FRM_Ordering = 'Index';
  C_FRM_RESTRUCTURE = 'Personnaliser les champs affich�s';

  C_CB_WordWrap = '� la ligne';

// IBF_SQL
  M_SQL_RowsAffected = 'Rangs trait�s';
  M_SQL_RowsCounted = 'Rangs d�nombr�s: ';
  M_SQL_SessionBusy = 'Session pr�sentement occup�e';
  M_SQL_CompleteTransaction = 'Compl�ter votre transaction S.V.P.';
  M_SQL_CannotDeleteDefaultGroup = 'Le Groupe par D�faut ne peut �tre supprim�';
  M_SQL_ReservedName = 'Ce nom est r�serv�: ';
  M_SQL_BackSlashNotAllowed = 'Barre oblique gauche refus� ';
  M_SQL_BlankNameNotAllowed = 'Un nom vierge n''est pas possible!';
  M_SQL_RowsFetched = 'Rangs affich�s: ';
  M_SQL_ConfirmDBCreation = 'Vraiment cr�er cette Base de donn�es?';
  M_SQL_ConfirmNoOtherDBSameName = 'Assurez-vous qu''aucune Base de donn�es du m�me nom n''existe.';
  M_SQL_ConfirmDBDrop = 'Vraiment supprimer cette Base de donn�es?';
  M_SQL_ReConfirmDBDrop = 'Cette Base de donn�es sera d�finitivement supprim�e.'+#13#10+#13#10'Continuer?';
  M_SQL_AskFormName = 'Entrer le nom d''�cran de la requ�te : ';
  M_SQL_AskGroupName = 'Entrer le nom du groupe : ';
  M_SQL_AskLayoutName = 'Entrer le nom de l''alias : ';
  M_SQL_ConfirmGroupDeletion = 'Vraiment supprimer le groupe %s et tous les alias reli�s?';
  M_SQL_ConfirmLayoutDeletion = 'Vraiment supprimer cet alias :  %s?';
  M_SQL_RecursiveCopyNotAllowed = 'Cette appellation existe d�j�!';

 // IBF_GenCustomSQL
  M_GCSQL_DoubleClickOrEnterItem = 'Double cliquez un article ou tapez Enter sur l''article s�lectionn�.';
  M_GCSQL_ParameterValue = 'Valeur du param�tre';
  M_GCSQL_TypeAValueFor = 'Type de valeur pour %s';
  M_GCSQL_ProcedureWithoutParams = 'Cette proc�dure n''a pas de param�tres intrants.';

  // IBF_DataPump
  M_DP_STILL_ACTIVE = 'Transfert de donn�es toujours actif.';
  M_DP_ARE_YOU_SURE = 'S.V.P confirmer?';
  M_DP_SELECT_SOURCE_DB = 'Base source';
  M_DP_SELECT_DEST_DB = 'Base destination';

  // IBF_USERS
  C_BTN_USERS_OK = 'Ok';
  C_BTN_USERS_CLEAR = 'Vider';
  M_USERS_COMPLETED_OK = 'Op�ration compl�t�e avec succ�s';
  M_USERS_NO_CONNECTION = 'Aucune IB_Connection d�finie.';

  // IBF_Query
  M_QRY_ASSIGN_ORDERING_ITEMS = 'G�n�rer les index?';

  // IBF_Export
  C_BTN_EXPORT_BEGIN = 'Lancer Export';
  M_EXPORT_STILL_ACTIVE = 'Je suis toujours en instance d''exportation.';

  // IB_UtilityBar
  C_wbBrowseBtnHint     = 'Parcourir la Base de donn�es';
  C_wbBrowseBtnCaption  = 'Fureter';
  C_wbDSQLBtnHint       = 'Ex�cuter la Requ�te';
  C_wbDSQLBtnCaption    = 'DSQL';
  C_wbEventsBtnHint     = 'Afficher les �v�nements de la Base';
  C_wbEventsBtnCaption  = '�v�nem.';
  C_wbExportBtnHint     = 'Exporter une Table depuis la Base';
  C_wbExportBtnCaption  = 'Exporter';
  C_wbDumpBtnHint       = 'Dump Database';
  C_wbDumpBtnCaption    = 'Dump';
  C_wbPumpBtnHint       = 'Importer les Donn�es d''une autre Base';
  C_wbPumpBtnCaption    = 'Importer';
  C_wbWhoBtnHint        = 'Voir Qui est pr�sentement connect�';
  C_wbWhoBtnCaption     = 'Qui';
  C_wbScriptBtnHint     = 'Ex�cuter Sc�nario';
  C_wbScriptBtnCaption  = 'Sc�nario';
  C_wbExtractBtnHint    = 'Extraire DDL';
  C_wbExtractBtnCaption = 'Extraire';
  C_wbMonitorBtnHint    = 'Retracer appels SQL et API';
  C_wbMonitorBtnCaption = 'Moniteur';
  C_wbProfilerBtnHint   = 'Profil des activit�s de la Base';
  C_wbProfilerBtnCaption= 'Profil';
  C_wbStatusBtnHint     = 'Statut des Composants IBO';
  C_wbStatusBtnCaption  = 'Statut';
  C_wbUsersBtnHint      = 'Administration des Usagers pour une Base de donn�es';
  C_wbUsersBtnCaption   = 'Usagers';

  // Array grid
  C_AG_Row             = 'Rang';
  C_AG_Column          = 'Colonne';

  //IBF_Who
  C_WHO_FRM            = 'Usager enregistr�';
  C_WHO_BTNAPPLY       = 'Rafra�chir';

  C_NB_FIRST = 'Premier';
  C_NB_PRIOR = 'Pr�c�dent';
  C_NB_NEXT = 'Suivant';
  C_NB_LAST = 'Dernier';

  C_ST_Open = 'Ouvrir';
  C_ST_Close = 'Fermer';
  C_ST_Prepare = 'Pr�parer';
  C_ST_Unprepare = 'Lib�rer';
  C_ST_ReadOnly = 'Lecture seule';
  C_ST_New = 'Nouveau';
  C_ST_Post = 'Sauver';
  C_ST_Cancel = 'Annuler';
  C_ST_Delete = 'Supprimer';
  C_ST_Edit = '�diter';
  C_ST_RefreshKeys = 'Rafra�chir Cl�s';
  C_ST_RefreshRows = 'Rafra�chir Rangs';
  C_ST_Refresh = 'Rafra�chir';

{ Hints }

  H_UB_EDIT = 'Modifier le Rang';
  H_UB_INSERT = 'Ins�rer un Rang';
  H_UB_DELETE = 'Supprimer le Rang';
  H_UB_REFRESH = 'Rafra�chir tous les dossiers';
  H_UB_REFRESHKEYS = 'Rafra�chir les cl�s du dossier';
  H_UB_REFRESHROWS = 'Rafra�chir les Rangs du dossier';
  H_UB_REFRESHFILTROWS = 'Rafra�chir les Rangs filtr�s';
  H_UB_POSTSEARCH = 'Sauvegarder les crit�res de recherche';
  H_UB_CANCELSEARCH = 'Annuler les crit�res de recherche';
  H_UB_POSTEDIT = 'Sauvegarder les modifications';
  H_UB_CANCELEDIT = 'Annuler les modifications';
  H_UB_POSTINSERT = 'Sauvegarder les insertions';
  H_UB_CANCELINSERT = 'Annuler les insertions';
  H_UB_POSTDELETE = 'Valider la suppression';
  H_UB_CANCELDELETE = 'Annuler la suppression';
  H_UB_POST = 'Sauvegarder les modifications';
  H_UB_CANCEL = 'Annuler les modifications';

  H_NB_FIRST = 'Premier Rang';
  H_NB_PRIOR = 'Rang pr�c�dent';
  H_NB_NEXT = 'Rang suivant';
  H_NB_LAST = 'Dernier Rang';
  H_NB_JUMPBCK = 'Page pr�c�dente';
  H_NB_JUMPFWD = 'Page suivante';

  H_SB_ORDER = 'Indexer les Rangs de la Table';
  H_SB_LAST_CRITERIA = 'Rappeler le dernier crit�re de recherche';
  H_SB_SEARCH = 'Recherche dans la Table';
  H_SB_SAVE_CRITERIA = 'Sauvegarder le Crit�re';
  H_SB_CLEAR_CRITERIA = 'Annuler le crit�re';
  H_SB_RECALL_CRITERIA = 'Rappeler le crit�re';
  H_SB_SEARCHCOUNT = 'D�compte des Rangs r�pondant au Crit�re Recherche';
  H_SB_COUNT = 'Nombre de Rangs dans la Table';
  H_SB_RESTRUCTURE = 'Personnaliser les Champs affich�s';

  H_TB_StartTransaction = 'Amorcer la Transaction';
  H_TB_PostDatasets = 'Valider les modifications dans les Tables';
  H_TB_CancelDatasets = 'Annuler les modifications dans les Tables';
  H_TB_SavePoint = 'Valider et Conserver la Transaction courante';
  H_TB_CommitRetain = 'Valider les modifications'#13#10'Enregistrer et Conserver la Transaction courante';
  H_TB_Commit = 'Enregistrer et Fermer la Transaction courante';
  H_TB_Rollback = 'Annuler et Fermer la Transaction courante';
  H_TB_RollbackRetain =  'Annuler et Conserver la Transaction courante';
  H_TB_Close = 'Fermer la Transaction courante';

  H_ST_Prepare_Statement = 'Pr�parer Requ�te';
  H_ST_Unprepare_Statement = 'Lib�rer Requ�te';
  H_ST_Execute_Statement = 'Ex�cuter Requ�te';

  H_DS_Open_Dataset = 'Ouvrir [Dataset]';
  H_DS_Close_Dataset = 'Fermer [Dataset]';
  H_DS_Prepare_Dataset = 'Pr�parer [Dataset]';
  H_DS_Unprepare_Dataset = 'Lib�rer [Dataset]';
  H_DS_ReadOnly_Dataset = '[Dataset] en lecture seulement';

  H_CB_Create_Database = 'Cr�er Base de donn�es';
  H_CB_Connect_Database = 'Connecter Base de donn�es';
  H_CB_Disconnect_Database = 'D�connecter Base de donn�es';
  H_CB_Drop_Database = 'Supprimer Base de donn�es';

  H_RD_actHide = 'Cacher les champs s�lectionn�s';
  H_RD_actHideAll = 'Cacher tous les champs';
  H_RD_actVisible = 'Rendre visibles les champs s�lectionn�s';
  H_RD_actVisibleAll = 'Rendre visibles tous les champs s�lectionn�s';
  H_RD_actUp = 'D�placer les champs s�lectionn�s vers le haut';
  H_RD_actTop = 'D�placer les champs s�lectionn�s au d�but';
  H_RD_actDown = 'D�placer les champs s�lectionn�s vers le bas';
  H_RD_actBottom = 'D�placer les champs s�lectionn�s � la fin';
  // IBF_Export
  H_BTN_EXPORT_BEGIN = 'Exporter selon la requ�te SELECT';

  //  Messages d'erreurs - IB_Import

  eNoAsciiFileEnty           = 'Donn�e manquante pour Fichier ASCII?';
  eNoDestTableEntry          = 'Donn�e manquante pour Table de destination';
  eAsciiFileNotFound         = 'Fichier ASCII [%s] inexistant';
  eIniFileNotFound           = 'Fichier .ini  [%s] inexistant';
  eNoAsciiFileAccess         = 'Ouverture du fichier ASCII %s impossible';
  eInvalidCharFound          = 'Caract�re invalide / erreur format du fichier ascii';
  eOutOfMemory               = 'M�moire insuffisante';
  eFieldDescriptionError     = 'Erreur de description des Champs';
  eWrongAsciiFieldCount      = 'D�compte des champs erron� dans le fichier ASCII';
  eWrongDecimalCount         = 'Calcul de d�cimal erron� dans la Liste des champs (%s)';
  eWrongFieldWidth           = 'Taille de Champ erron� dans le fichier ASCII';

  // Dialog Labels - IB_Import

  lblRecsReadedCaption       = 'Total dossiers lus';
  lblRecsCommentedCaption    = 'Dossiers comment�s';
  lblRecsInsertedCaption     = 'Dossiers ins�r�s';
  btnAbortImportCaption      = 'Stopper';

  // Metadata Extract Stuff
  // ------------------------
  // Entity Type Names
  STR_DDL_UnnamedItem = '<SANS NOM>';
  STR_DDL_etDatabase = 'Database';
  STR_DDL_etException = 'Exception';
  STR_DDL_etBlobFilter = 'Filtre de [Blob]';
  STR_DDL_etUDF = 'UDF';
  STR_DDL_etGenerator = 'G�n�rateur';
  STR_DDL_etDomain = 'Domaine';
  STR_DDL_etTable = 'Table';
  STR_DDL_etView = 'Vue';
  STR_DDL_etProcedure = 'Proc�dure';
  STR_DDL_etRole = 'R�le';
  STR_DDL_etPrimaryKey = 'Cl� Primaire';
  STR_DDL_etUniqueKey = 'Cl� Unique';
  STR_DDL_etForeignKey = 'Cl� �trang�re';
  STR_DDL_etConstraint = 'Contrainte';
  STR_DDL_etIndex = 'Index';
  STR_DDL_etTrigger = 'D�clencheur';
  STR_DDL_etPermission = 'Permission';
  STR_DDL_etUDFParam = 'Param�tre pour UDF';
  STR_DDL_etTableField = 'Champ Table';
  STR_DDL_etViewField = 'Vue Champ';
  STR_DDL_etProcParam = 'Param�tre de Proc�dure';

  // CodeOption Names
  STR_DDL_coCreateDatabase = 'Cr�er Database';
  STR_DDL_coSecondaryFiles = 'D�finir Fichiers Secondaires';
  STR_DDL_coDefineShadows = 'D�finir [Shadows]';
  STR_DDL_coSetGeneratorVal = '�tablir valeur de g�n�rateur';
  STR_DDL_coResetExceptionNo = 'R�tablir Num�ro d''Exception';
  STR_DDL_coRawFieldDefs = 'D�finitions de champs Raw';
  STR_DDL_coReportMinor = 'Signaler Mineur';
  STR_DDL_coAlwaysQuoted = 'Toujours d�limit�';
  STR_DDL_coAlwaysCharSet = 'Toujours d�finir jeux de caract�res';
  STR_DDL_coIncludeDebug = 'Inclure commentaires de d�bogage';
  STR_DDL_coDescripAsComment = 'Descriptions en tant que Commentaires';

  // CodePass Names
  STR_DDL_cpFull = 'Tout';
  STR_DDL_cpInit = 'Initial';
  STR_DDL_cpFinal = 'Final';

  // Dialog strings
  STR_DDL_DialogCaption = 'Extraction des m�tadonn�es';
  STR_DDL_Configure = 'Configuration';
  STR_DDL_Filters = 'Filtres';
  STR_DDL_Script = 'Sc�nario';
  STR_DDL_MetadataControls = 'Contr�ls des m�tadonn�es';
  STR_DDL_CodeOptions = 'Options de code';
  STR_DDL_Entities = 'Entit�s';
  STR_DDL_Terminator = 'Terminator';
  STR_DDL_ExecuteControls = 'Execute Controls';
  STR_DDL_CodePass = 'Code Pass';
  STR_DDL_ExtractToStrings = 'Convertir en cha�nes';
  STR_DDL_Reset = 'R�-initialiser';
  STR_DDL_ResetAll = 'Tout R�-initialiser';
  STR_DDL_ProgressControls = 'Contr�le de la progression';
  STR_DDL_Stop = 'Arr�t';
  STR_DDL_IncludeSystem = 'Inclure les Objets Syst�mes';
  STR_DDL_NameMasks = 'Masques de noms';
  STR_DDL_SaveToFile = 'Sauvegarder';

implementation

end.
