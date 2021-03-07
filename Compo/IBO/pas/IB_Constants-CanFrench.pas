{***************************************************************}
{  Copyright 1997 CPS - Computer Programming Solutions          }
{  Author: Jason Wharton                                        }
{  www.ibobjects.com                                            }
{  Mailto: jwharton@ibobjects.com                               }
{  Tranlation to French by Rita Lavoie rita.lavoie@cgocable.ca  }
{***************************************************************}

unit IB_Constants-CanFrench.pas;

interface


RESOURCESTRING

C_BF_APPLY = 'Appliquer';
C_BF_CANCEL = 'Annuler';
C_BF_EXECUTE = 'Ex�cuter';
C_BF_HELP = 'Aide';
C_BF_OK = 'OK';
C_BTN_CLEAR = 'Vider';
C_BTN_EXPORT_BEGIN = 'Lancer Export';
C_BTN_TODAY = 'Aujourd''hui';
C_BTN_USERS_CLEAR = 'Vider';
C_BTN_USRES_OK = 'Ok';
C_CB_WordWrap = 'Auto Retour';
C_FRM_Ordering = 'Indexer';
C_SG_Field = 'Champ';
C_SG_Info = 'Info';
C_SG_Name = 'Nom';
C_SG_Parameter = 'Param�tre';
C_SG_Type = 'Type';
C_SG_Value = 'Valeur';
C_wbBrowseBtnCaption = 'Fureter';
C_wbBrowseBtnHint = 'Parcourir la Base de donn�es';
C_wbDSQLBtnCaption = 'DSQL';
C_wbDSQLBtnHint = 'Appliquer Requ�te � � la Base de donn�es';
C_wbDumpBtnCaption = 'Exporter';
C_wbDumpBtnHint = 'Exporterla Base de donn�es';
C_wbEventsBtnCaption = '�v�nements';
C_wbEventsBtnHint = 'Gestion d''�v�nement sur le Serveur associ�';
C_wbExportBtnCaption = 'Exporter';
C_wbExportBtnHint = 'Exporter les donn�es de la Base';
C_wbMonitorBtnCaption = 'Moniteur';
C_wbMonitorBtnHint = 'Surveiller op�rations SQL et API';
C_wbPumpBtnCaption = 'Importer';
C_wbPumpBtnHint = 'Importer les donn�es d''une autre Base';
C_wbScriptBtnCaption = 'Sc�nario';
C_wbScriptBtnHint = 'Ex�cuter Sc�nario';
C_wbUsersBtnCaption = 'Usagers';
C_wbUsersBtnHint = 'Administrateur d''Usagers pour le Serveur associ�';
C_wbWhoBtnCaption = 'Usager?';
C_wbWhoBtnHint = 'Coordonn�es de l''usager connect�';
C_WHO_BTNAPPLY = 'Rafra�chir';
C_WHO_FRM = 'Usager connect�';
E_53BIT_OVERFLOW = 'Nombre entier 53bit surcharg�';
E_ALLOCATED = 'Allocation de la Requ�te d�j� ex�cut�';
E_Array_Is_Null = '[Array] est Vide';
E_Assign_Column = 'Ne peut copier depuis %s';
E_AssignTo_Column = 'Ne peut copier vers %s';
E_AT_END_OF_BUFFER = 'Fin du tampon';
E_AT_END_OF_CURSOR = 'Fin du curseur';
E_AT_END_OF_DATASET = 'Fin de la Table';
E_AT_END_OF_FILE = 'Fin du fichier';
E_BAD_SQL_INF_DATA = 'Donn�es invalides renvoy�es par [isc_dsql_sql_info]';
E_BAD_SQL_INF_LEN = 'Taille impr�vue dans [isc_dsql_sql_info]';
E_BEGINNING_OF_DATASET = 'D�but de la Table';
E_BLANK_STATEMENT = 'Ne peut activer [Prepare] avec une Requ�te vierge';
E_Cannot_Activate = '�tat de Transaction invalide. Ne peut Activer.';
E_Cannot_Activate_Transaction = 'Activation de Transaction impossible';
E_Cannot_add_blank_account = 'Ajout d''un COMPTE vierge refus�';
E_Cannot_add_SYSDBA_account = 'Ajout d''un COMPTE SYSDBA refus�';
E_CANNOT_CANCEL_ROW = 'Annulation du Rang actif refus�e';
E_Cannot_Change_Events = 'Traitement en cours.  Modification refus�e';
E_Cannot_delete_blank_account = 'Suppression d''un COMPTE vierge refus�';
E_Cannot_Delete_Row = 'Suppression du Rang actif refus�e';
E_Cannot_delete_SYSDBA_account = 'Suppression du compte SYSDBA refus�';
E_Cannot_Edit_Row = '�dition du Rang actif refus�';
E_Cannot_Insert_Row = 'Insertion d''un nouveau Rang refus�';
E_Cannot_modify_blank_account = 'Modification d''un COMPTE vierge refus�';
E_Cannot_Navigate = 'Ne peut fureter';
E_Cannot_Pessimistic_Lock = 'Verrouillage pessimistique impossible avec [LockWait]';
E_CANNOT_POST_ROW = 'Enregistrement du Rang actif refus�';
E_Cannot_Search = 'Recherche non permise';
E_Cannot_Unregister_Events = 'Suppression d''entr�e au registre impossible'#13#10+
                             'pendant l''ex�cution de la proc�dure';
E_CANT_CHG_WITH_CONN = 'Modification impossible lorsque connect�';
E_CANT_DELETE = 'Suppression du dossier actif dans le curseur refus�';
E_CANT_GET_CONN_CHR = 'Charact�ristiques de Connection inexistants';
E_CANT_LOAD_BLOB = 'Champ [Blob] ne peut �tre ou a d�j� �t� charg�';
E_Cant_Repl_Int_Tr = 'Remplacement de Transaction interne par d�faut refus�';
E_CANT_STORE_BLOB = 'Champ [Blob] ne peut �tre ou a d�j� �t� sauv�';
E_Cant_Unprepare_executing_process = '[Unprepare] invalid�. Traitement en cours';
E_CIRCULAR_REFERENCE = 'R�f�rence circulaire refus�e';
E_CONN_LOADING = 'Avertissement: Connection en cours de chargement';
E_CONNECT_FAILED = 'Ouverture IB_Connection refus�e';
E_CONNECTED = 'La Connection a d�j� �t� �tablie';
E_Could_Not_Load_Memo = 'Chargement [memo] impossible';
E_CURSOR_NAME_LOCK = 'Le nom d''un Curseur actif ne peut �tre modifi�';
E_CURSOR_UNI = 'IB_CURSOR est unidirectionel';
E_DATABASE_BLANK = '[DatabaseName] ne peut �tre vierge';
E_DatasetCannotScroll = 'D�filement de la Table refus�';
E_DatasetClosed = 'Table inactive';
E_DatasetIsFetching = 'R�sultat en cours d''ex�cution';
E_DatasetOpen = 'Table d�j� ouverte';
E_DatasetReadOnly = 'Table en lecture seule';
E_DUP_DB_NAME = '[DatabaseName} dupliqu� refus�';
E_END_OF_DATASET = 'Fin de la Table';
E_Failed_To_Cancel_Datasets = 'Annulation de toutes les Tables rat�e';
E_Failed_To_Post_Datasets = 'Sauvegarde de toutes les Tables rat�e';
E_FAILED_TO_PREPARE = '[Prepare] sur Requ�te rat�';
E_FIELD_NOT_NULLABLE = 'Champ [NOT NULL] report� � valeur [NULL]';
E_FIELDNAME_NOT_FOUND = '[FieldName]: %s inexistant';
E_FIELDNO_NOT_FOUND = '[FieldNo]: %d inexistant';
E_FileName_Required = '[FileName] obligatoire';
E_FLD_READONLY = '%s en lecture seule';
E_GeneratorFailed = 'Retour du g�n�rateur impossible';
E_GET_CURSOR_ERROR = 'Ouverture du Curseur impossible sans cl�-ma�tresse';
E_IB_Client_Not_Installed = 'Client InterBase GDS32.DLL non install�';
E_Init_Default_SQL_Failed = 'Initialisation par d�faut de %s impossible';
E_INV_CREATE_CONNECT_DROP = 'Syntaxe de CREATE, CONNECT ou DROP DATABASE invalide';
E_Inv_Custom_DML = 'Invalid custom DML column reference: %s';
E_Invalid_Bookmark = 'Cha�ne Signet invalide';
E_INVALID_BUFFER_ROW_NUM = '[BufferRowNum] invalide avant le lancement';
E_Invalid_ColData = '[ColData] Invalide';
E_Invalid_DataPump_Statement = 'Type Requ�te invalide pour pour Importation';
E_INVALID_DB_NAME = '[DatabaseName] invalide';
E_Invalid_DPB_Over_255 = '[DPB] invalide: Maximum de 255 caract�res';
E_INVALID_FOCUS_RELATION_NAME = 'Invalid Focused Relation Name: %s';
E_INVALID_FOCUS_RELATION_NO = 'Invalid Focused Relation No: %d';
E_Invalid_Internal_Transaction = '[IB_]Transaction Interne Invalide';
E_Invalid_KeyLinks = 'Entr�e [KeyLinks] invalide: %s';
E_Invalid_KeyRelation = 'Valeur [KeyRelation] invalide';
E_INVALID_QBE_BETWEEN = 'Erreur de syntaxe dans valeur [BETWEEN] et valeur [AND]';
E_INVALID_QBE_IN = 'Erreur de syntaxe dans IN( valeur [ , valeur ... ] )';
E_Invalid_RowNum = '[RowNum] invalide';
E_Invalid_RowNum_Before_Bof = '[RowNum] pr�c�de [Bof] D�but du fichier';
E_Invalid_RowNum_Past_Eof = '[RowNum] d�passe [Eof] Fin du fichier';
E_Invalid_RowsAffected_Buffer = 'Tampon [RowsAffected] invalide';
E_INVALID_SQL_KEY_FIELDS = 'Propri�t�s [SQLKeyFields] invalide';
E_Invalid_Syntax = 'Syntaxe invalide: parenth�ses en trop ou en moins';
E_Invalid_Typecast = 'Transtypage invalide';
E_InvalidClassType = 'Type [class] Invalide';
E_InvalidRowsAffectedBuf = 'Tampon [RowsAffected] invalide';
E_InvalidStatementType = 'Type de Requ�te invalide';
E_LOGIN_FAILED = 'Acc�s refus�';
E_MAX_EVENTS_BLOCK = 'Nombre d''�v�nements surcharg� pour un bloc';
E_Multiple_Records_Deleted = 'Plusieurs dossiers supprim�s';
E_Multiple_Records_Updated = 'Plusieurs dossiers mis � jour';
E_Multiple_Rows_In_Singleton = 'Plusieurs dossiers en une seule transaction';
E_MustBe_Buffered_Dataset = 'Doit d�couler de TIB_BDataset (IB_Query)';
E_NO_ACTIVE_TRANS = 'Aucune Transaction active � �x�cuter...';
E_NO_BLANK_SQL = 'Requ�te SQL vierge refus�e';
E_NO_CHANGE_ISOLATION = 'Ne peut modifier [Isolation] lorqu''Amorc�';
E_NO_CHANGE_LOCKWAIT = 'Ne peut modifier [LockWait] lorqu''Amorc�';
E_NO_CHANGE_READONLY = 'Ne peut modifier [ReadOnly] lorqu''Amorc�';
E_NO_CHANGE_RECVERSION = 'Ne peut modifier [RecVersion] lorqu''Amorc�';
E_NO_CONNECTION = 'Requ�te doit avoir une [IB_]Connection assign�e';
E_NO_CONNECTIONS = 'Transaction est sans connections';
E_NO_POSTRTN_CACHED_UPDT = '[PostRetaining] inutilisable avec [Cached Updates]';
E_NO_TRANS_STARTED = 'Transaction n''a pas �t� amorc�e';
E_NO_TRANSACTION = 'Requ�te doit avoir une [IB_]Transaction assign�e';
E_NoCircularRef = 'R�f�rence circulaire refus�e';
E_NoRecordsFound = 'Aucun dossier trouv�';
E_NOT_ALLOCATED = 'Requ�te n''a pas �t� pr�cis�e';
E_NOT_CONNECTED = 'Connection n''a pas �t� �tablie';
E_NOT_ENOUGH_CONN = 'Transaction manque d''une ou plusieurs connections';
E_NOT_OPENED = 'Requ�te n''a pas �t� ouverte';
E_NOT_PREPARED = 'Requ�te n''a pas �t� Pr�par�e';
E_NotImplemented = 'Non implement� � ce niveau';
E_OPENED = 'Requ�te � d�j� �t� ouverte';
E_PLAN_ERROR = ' ERREUR PLAN!';
E_PLAN_EXCEPTION = 'EXCEPTION PLAN!';
E_PREPARED = 'La Requ�te � d�j� �t� Pr�par�e';
E_PROCESSING_EVENTS = '�v�nements en cours d''ex�cution!'#13#10+
                      'Suppression au registre impossible.';
E_Record_Locked = 'Dossier verrouill� par un autre usager';
E_Record_Not_Inserted = 'Le dossier n''a pas �t� ajout�';
E_Record_Not_Located_For_Delete = 'Dossier de suppression non trouv�';
E_Record_Not_Located_For_Update = 'Dossier de mise � jour non trouv�';
E_Record_OutOfSynch = 'Le dossier a �t� modifi� par un autre usager';
E_REQUEST_LIVE_ACTIVE = '[RequestLive] ne peut �tre modifi� en mode actif';
E_REQUEST_LIVE_READONLY = '[RequestLive] impossible sur une base en lecture seule';
E_Required_Field = '%s est un champ requis';
E_RowDeleted = 'Rang en cours de suppression';
E_RowNum_Not_Implemented = '[RowNum] non encore impl�ment�';
E_SCROLL_ERROR = 'Cl�-ma�tresse perdue...!'#10#13'Ouverture Curseur rat�e.';
E_Session_Undefined = Session non d�finie';
E_SmallintOverflow = '[Smallint] surcharg�';
E_START_FAILED = 'Incapable d''amorcer une transaction';
E_Stringlist_Not_Sorted = '[Stringlist] doit �tre index� pour cette op�ration';
E_SVRAUTOCMT_NOEXP = 'Trans. [Explicit] non permise avec [ServerAutoCommit]';
E_TRANS_CONN_SESS = 'Connections doivent toutes �tre dans la m�me [IB_Session]';
E_TRANS_STARTED = 'Transaction d�j� amorc�e';
E_Transaction_Is_Active = 'Transaction � des changements en attente';
E_TransactionPaused = 'Transaction est en mode [Paused]';
E_Unable_Save_Graphic = 'Sauvegarde � [Graphic] impossible';
E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Location de la DLL d''import impossible %s';
E_Unable_To_Locate_Record = 'Location du dossier impossible';
E_Unable_to_perform_search = 'Proc�dure Recherche impossible';
E_UnableToSearch = 'Proc�dure Recherche impossible';
E_Unassigned_Blob_Node = '[BlobNode] non assign�';
E_Unassigned_Transaction = 'Transaction non assign�e';
E_UndefinedMacro = 'Macro non d�finie';
E_UNKNOWN_STATEMENT = 'Tentative d''ex�cution d''une Requ�te inconnue';
E_Unsupp_Col_Conversion = 'Conversion de colonne non support�e';
E_Unsupported = 'Non support�';
E_Unsupported_Column = 'Type de colonne [%d] non support�';
E_UNSUPPORTED_COLUMN_TYPE = 'Type de colonne [%d] non support�';
E_UpdateWrongTrn = 'Mise � jour refus�e, %s ne d�coule pas de %s';
E_Value_Out_Of_Range = 'Valeur hors-champ';
H_BTN_EXPORT_BEGIN = 'Exporter selon la Requ�te [SELECT}';
H_NB_FIRST = 'Premier Rang';
H_NB_JUMPBCK = 'Page pr�c�dente';
H_NB_JUMPFWD = 'Page suivante';
H_NB_LAST = 'Dernier Rang';
H_NB_NEXT = 'Rang suivant';
H_NB_PRIOR = 'Rang pr�c�dent';
H_SB_CLEAR_CRITERIA = 'Vider Crit�re';
H_SB_COUNT = 'D�compte des Rangs dans la Table';
H_SB_LAST_CRITERIA = 'Rappeler le Crit�re pr�c�dent';
H_SB_ORDER = 'Indexer les Rangs dans la Table';
H_SB_RECALL_CRITERIA = 'Rappeler les Crit�res';
H_SB_SAVE_CRITERIA = 'Sauvegarder les Crit�res';
H_SB_SEARCH = 'Rechercher dans la Table';
H_SB_SEARCHCOUNT = 'D�compte des Rangs assortis aux Crit�res Recherche';
H_TB_CancelDatasets = 'Annuler Table';
H_TB_Close = 'Fermer la Transaction courante';
H_TB_Commit = 'Enregistrer et Fermer la Transaction courante';
H_TB_CommitRetain = 'Post Datasets and Commit and Retain Current Transaction';
H_TB_PostDatasets = 'Post Datasets';
H_TB_Rollback = 'Annuler et Fermer la Transaction courante';
H_TB_RollbackRetain = 'Annuler et Conserver la Transaction courante';
H_TB_SavePoint = 'Enregistrer et Consever la Transaction courante';
H_TB_StartTransaction = 'Lancer Transaction';
H_UB_CANCEL = 'Annuler changements';
H_UB_CANCELDELETE = 'Annuler suppression';
H_UB_CANCELEDIT = 'Annuler �dition';
H_UB_CANCELINSERT = 'Annuler insertion';
H_UB_CANCELSEARCH = 'Annuler crit�res recherche';
H_UB_DELETE = 'Supprimer Rang';
H_UB_EDIT = 'Editer Rang';
H_UB_INSERT = 'Ins�rer Rang';
H_UB_POST = 'Poster changements';
H_UB_POSTDELETE = 'Poster suppression'
H_UB_POSTEDIT = 'Poster �dition';
H_UB_POSTINSERT = 'Poster insertion';
H_UB_POSTSEARCH = 'Poster crit�res recherche';
H_UB_REFRESH = 'Rafra�chir tous les dossiers';
H_UB_REFRESHKEYS = 'Rafra�chir les cl�s du dossier';
H_UB_REFRESHROWS = 'Rafra�chir les rangs du dossier';
IB_REG_MESSAGE = 'Merci d''�valuer IB Objects.'#10#13#10#13+
                 'S.V.P. joindre http://www.ibobjects.com'#10#13+
                 'et enregistrez-vous maintenant.';
L_EXPORT_ASCII = ' Format Fichier ';
L_EXPORT_ASCIIOPT = ' Options ASCII ';
L_EXPORT_DATEFORMAT = 'Format Date';
L_EXPORT_DBF = 'DBF';
L_EXPORT_DELIMETED = 'D�limit�';
L_EXPORT_DELIMITER = 'D�limiteur';
L_EXPORT_FIXED = 'Taille dossier fixe';
L_EXPORT_FRM = 'Exporter';
L_EXPORT_INCLUDEHEADERS = 'Inclure Ent�tes';
L_EXPORT_SDEXPORTFILTERDBF = 'Fichiers DBF ( *.DBF )|*.DBF';
L_EXPORT_SDEXPORTFILTERTXT = 'Fichiers Texte ( *.TXT )|*.TXT';
L_EXPORT_SDEXPORTTITLE = 'Exporter';
L_EXPORT_SEPARATOR = 'S�parateur';
L_USERS_ACCOUNT = 'COMPTE';
L_USERS_ADD = 'Ajouter';
L_USERS_DELETE = 'Supprimer';
L_USERS_FIRSTNAME = 'Pr�nom';
L_USERS_FRM = 'Gestionnaire des COMPTES d''acc�s';
L_USERS_GROUP = 'Groupe';
L_USERS_LASTNAME = 'Nom';
L_USERS_MIDDLENAME = 'Initiale';
L_USERS_MODIFIY = 'Modifier';
L_USERS_PASSWORD = 'Mot de P.';
M_Abort_Fetching = 'Vraiment stopper la proc�dure?';
M_Abort_Fetching_Btn = 'Stopper';
M_CancelTransactionPrompt = 'Vraiment supprimer tous les changements?';
M_Fetching_Query_Results = 'R�sultats de la Requ�te';
M_Loading_Caption = 'Chargement...';
M_Login_Cancel_Btn = 'Annuler';
M_Login_Database = 'Base de D.';
M_Login_Dialog_Caption = 'Autorisation d''acc�s';
M_Login_Help_Btn = 'Aide';
M_Login_OK_Btn = 'OK';
M_Login_Password = 'Mot de P.';
M_Login_User = 'Usager';
M_Row_Num = 'Rang# %d';
M_Save_Changes = 'Enregistrer les changements?';
M_SB_REC_CNT = 'Dossiers compt�s : %d';
M_SCRIPT_ABORT_EXECUTE = 'Stopper l''ex�cution de ce sc�nario?';
M_SCRIPT_COMPLETED = 'Sc�nario compl�t� sans exceptions';
M_SCRIPT_CONTINUE_EXECUTING = 'Continuer l''ex�cution du sc�nario?';
M_SCRIPT_FAILED = 'Ex�cution du sc�nario rat�e avant terme';
M_SCRIPT_IS_EXECUTING = 'Sc�nario en cours d''ex�cution';
M_SCRIPT_WAS_ABORTED = 'L''ex�cution du sc�nario a �t� stopp�e';

{ This ends resources I found in the help file.
  Here are a few translations which might be utils.}

{IBD_About.pas}
  AboutCaption 	= '� propos de...';
  AboutMemo1 = 
	'Ces composants donnent acc�s directement � l''API d''INTERBASE.'#13#10#13#10+
	'De ce fait, la BDE et l'ODBC sont exclus de cette application DEMO.'#13#10#13#10+
	'InterBase Objects est la seule propri�t� de CPS et est maintenant'#13#10+
	'disponible pour revente.  Veuillez vous brancher sur le site Web en'#13#10+
	'rubrique pour plus d''informations.'#13#10#13#10+
	'Pour d�velopper et �crire une application client/server avec'#13#10+
	'IB Objects, veuillez contacter CPS pour rencontrer vos besoins'#13#10+
	'sp�cifiques.'#13#10#13#10+
	'Vous pouvez �galement vous informer des possibilit�s de devenir un'#13#10+
	'utilisateur autoris� de CPS. Vous obtiendrez alors les droits de'#13#10+
	'd�velopper vos propres applications ou celles de vos clients en'#13#10+
	'utilisant IB Objects.'#13#10#13#10+
	'RENONCIATION : Ce produit est offert TEL-QUEL.  Aucun dommage, de quelque'#13#10+
	'nature que ce soit, ne peut �tre imput�  � CPS pour quelque genre de'#13#10+
	'perte pouvant r�sulter de l''utilisation de ce produit.';

  AboutCommentsCaption 	= 'Auteur: Jason Wharton';

{IBD_Error.pas}
  ErrorCaption = 'Dialogue d''erreurs...';
  ErrorMsgCaption = 'Message d''erreur';


{IBD_StingList.pas}
  StringListCaption = '�diteur de cha�nes';

{IBF_Base.pas}
  BaseCaption = 'Proc�dure de Base';

{IBF_Browse.pas}
//  C_wbBrowseBtnCaption = 'Fureter';
//  C_wbBrowseBtnHint = 'Parcourir les donn�es de la base';

  BrowsebtEditTriggerMsg = 'Source D�clancheur [Trigger] invalide.';
  BrowsebtEditProcMsg = 'Source [Proc�dure] invalide.';
  BrowsetsRelationsCaption  = 'Relations';
  BrowsecbTablesCaption  = 'Tables';
  BrowsecbViewsCaption  = 'Vues';
  BrowsecbSystemCaption  = 'Syst�me Inf.';
  BrowsecbDomainInfoCaption  = 'Domaines Inf.';
  BrowsetsRelFieldsCaption  = 'Champs';
  BrowsetsDataCaption  = 'Donn�es';
  BrowsetsIndicesCaption  = 'Indices';
  BrowsemeIndexFieldsHint  = 'Champs Index';
  BrowsePanel2Label1Caption  = 'UNIQUE';
  BrowsePanel2Label2Caption  = 'TYPE';
  BrowsePanel2Label3Caption  = 'INACTIF';
  BrowsetsConstraintsCaption  = 'Contraintes';
  BrowsetsTriggersCaption  = 'Triggers';
  BrowsePanel35Label10Caption  = 'SEQ';
  BrowsePanel35Label11Caption  = 'TYPE';
  BrowsePanel35Label13Caption  = 'INACTIF';
  BrowsebtEditTriggerCaption  = '�diter';
  BrowsetsSourceCaption  = 'Source';
  BrowsetsRelDescCaption  = 'Dest.';
  BrowsetsRelDependCaption  = 'D�pend.';
  BrowsetsFieldListCaption  = 'Liste des Champs';
  BrowseTabSheet10Caption  = 'Proc�dures';
  BrowsebtEditProcCaption  = '�diter';
  BrowsetsProcSourceCaption  = 'Source';
  BrowsetsProcedureInputsCaption  = 'Param.';
  BrowsetsProcedureOutputsCaption  = 'Champs';
  BrowsetsProcDescCaption  = 'Description';
  BrowsetsProcDependCaption  = 'D�pend.';
  BrowsetsDomainsCaption  = 'Domaines';
  BrowsetsGeneratorsCaption  = 'G�n�rateurs';
  BrowseConfirmDeletePromptStrings  = '�tes-vous certain?';

{IBF_DataDump.pas}
  DataDumpCaption = 'Exporter des donn�es';
  DataDumptsDataCaption = 'Donn�es';
  DataDumptsDumpCaption = 'Exporter';
  DataDumplbFieldsHint = 'CTRL+Click pour Exclure';
  DataDumplbTablesHint = 'CTRL+Click pour Exclure';
  DataDumpsbDataDumpHint = 'Exporter selon la requ�te';
  DataDumpsbDataDumpCaption = 'Lancer Exporter...';
  DataDumpgbASCIICaption = ' Format fichier';
  DataDumplbDelimiterCaption = 'D�limiteur';
  DataDumplbSeparatorCaption = 'S�parateur';
  DataDumprbDelimetedCaption = 'D�limit�';
  DataDumprbFixedCaption = 'Taille dossier fixe';
  DataDumpcbHeadersCaption = 'Inclure Ent�tes';
  DataDumpsdExportDefaultExt = 'TXT';
  DataDumpsdExportFileName = '*.TXT';
  DataDumpsdExportFilter = 'Fichiers texte ( *.TXT )|*.TXT';
  DataDumpsdExportTitle = 'Exporter';
  DataDumpCloseQueryMsg = 'Exporter en cours d''ex�cution.';

{IBF_DataPump.pas}
  DataPumpCaption = 'Importer des donn�es';
  DataPumprbSeparateSrcDatabaseCaption = 'Separate Database';
  DataPumpbtSrcDatabaseCaption = 'Choix Base donn�es...';
  DataPumptsDestinationCaption = 'Requ�teDst.SQL';
  DataPumprbSeparateDstDatabaseCaption = 'Separate Database';
  DataPumprbSeparateDstDatabaseHint = 'Destination particuli�re';//*
  DataPumpbtDstDatabaseCaption = 'Choisir Base de d.';
  DataPumptsDstLinksCaption = 'DstLinks';
  DataPumptsItemAttributesCaption = 'ItemAttributes';
  DataPumpbtClassesCaption = 'Classes';
  DataPumptsItemActionsCaption = 'ItemActions';
  DataPumpbtPrepareCaption = 'Pr�parer';
  DataPumptsExecuteCaption = 'Ex�cuter';
  DataPumpLabel1Caption = 'Destination:';
  DataPumpLabel2Caption = 'Source:';
  DataPumpLabel3Caption = 'Rangs Trait�s:';
  DataPumpLabel4Caption = 'Rangs/Seconde:';
  DataPumpLabel6Caption = 'Erreurs:';
  DataPumpbtExecuteCaption = 'Ex�cuter';
  DataPumpcbIgnoreErrorCaption = 'Ignorer Erreurs';
  DataPumpcbIgnoreCountCaption = 'Ignorer D�compte';
  DataPumpConfirmClosePromptStrings = 'Sauver les changemens d''importation?';
  DataPumpCloseQueryMsg = 'Importer en cours d''ex�cution.';

{IBF_DSQL.pas}
  C_wbDSQLBtnCaption = 'DSQL';
  C_wbDSQLBtnHint = 'Ex�cuter Requ�te sur la Base de donn�es';

  DSQLCaption = 'DSQL';
  DSQLbtSQLPreviousCaption = '&Pr�c�dent';
  DSQLbtSQLNextCaption = '&Suivant';
  DSQLbtNewSQLCaption = '&Nouveau';
  DSQLcbParamsCaption = 'Param.?';
  DSQLtsSQLCaption = 'SQL';
  DSQLtsDSQLInputCaption = 'Param.';
  DSQLtsDSQLOutputCaption = 'Champs';

{IBF_Events}
  EventsCaption = '�v�nements';
  EventsbtRegEventsRegCaption = '(+)Registre';
  EventsbtRegEventsRegHint = 'Porter au registre';
  EventsbtRegEventsUnRegCaption = '(-)Registre';
  EventsbtRegEventsUnRegHint = 'Retirer du registre';
  EventsbtClearResultsCaption = 'Vider';

{IBF_Export.pas}
  ExportCaption = 'Exporter';
  ExportlbDateFormatCaption = 'Format Date';
  ExportgbASCIICaption = ' Format Fichier';
  ExportlbDelimiterCaption = 'D�limiteur';
  ExportlbSeparatorCaption = 'S�parateur';
  ExportrbDelimetedCaption = 'D�limet�';
  ExportrbFixedCaption = 'Taille dossier fixe';
  ExportcbHeadersCaption = 'Inclure Ent�tes';
  ExportsbExportHint = 'Exporter selon la requ�te';
  ExportsbExportCaption = 'Lancer Exporter';
  ExportsbImportHint = 'Importer selon la requ�te';
  ExportsbImportCaption = 'Lancer Importer';
  ExportsdExportDefaultExt = 'TXT';
  ExportsdExportFileName = '*.TXT';
  ExportsdExportFilter = 'Fichiers texte ( *.TXT )|*.TXT';
  ExportsdExportTitle = 'Exporter';
  ExportFormCloseQueryMsg = 'Proc�dure d''exportation d�j� activ�e.';

{IBF_Lookup.pas}
  LookupCaption = 'Grille de consultation';

{IBF_Monitor.pas}
  MonitorCaption = 'Moniteur';
  MonitorcbEnabledChecked = '/*--------  ACTIV�E  --------*/';
  MonitorcbEnabledNotChecked = '/*-------  D�SACTIV�E -------*/';
  MonitorcbConnectionCaption = 'C&onnection';
  MonitorcbTransactionCaption = '&Transaction';
  MonitorcbStatementCaption = 'Req&u�te';
  MonitorcbRowCaption = '&Rang';
  MonitorbtSaveCaption = '&Sauver...';
  MonitorcbSQLCaption = 'S&QL';
  MonitorcbEnabledCaption = '&Activ�';
  MonitorcbBlobCaption = '&Blob';
  MonitorsdMonitorDefaultExt = 'TXT';
  MonitorsdMonitorFilter = 'Fichiers texte (*.TXT)|*.TXT';
  MonitorsdMonitorTitle = 'Nom du fichier de sauvegarde de la requ�te';

{IBF_Parameters.pas}
  ParametersCaption = '�diteur Param�tres';


{IBF_Script.pas}
  ScriptCaption = 'Sc�nario';
  ScriptbtClearCaption = '&Vider';
  ScriptbtLoadCaption = '&Charger...';
  ScriptbtSaveCaption = '&Sauver...';
  ScriptbtExecuteCaption = '&Ex�cuter';
  ScriptcbStoreCaption = 'C&onserver?';
  ScriptcbYieldCaption = '&Yield';
  ScriptcbYieldHint = 'Activer Application.ProcessMessages durant la proc�dure.';
  ScriptodScriptTitle = 'Ouvrir Sc�nario SQL';
  ScriptsdScriptTitle = 'Sauver Sc�nario';
  ScriptbtExecuteClickMsg = 'Abandonner l''ex�cution de ce Sc�nario?';
  ScriptAfterExecuteFailed = 'Le Sc�nario a �chou� avant terme';
  ScriptAfterExecuteAborted = 'L''ex�cution du Sc�nario � �t� abandonn�';
  ScriptAfterExecute = 'Le Sc�nario s''est termin� sans exception';
  ScriptCloseQueryMsg = 'Le Sc�nario est en cours d''ex�cution.';
  ScriptScriptErrorMsg = 'Poursuivre l''ex�cution du Sc�nario?';

{IBF_Users.pas}

  UsersCaption = 'Gestion des Comptes d''usager';
  UsersbtDeleteUserCaption = 'Supprimer';
  UsersbtModifyUserCaption = 'Modifier';
  UsersbtClearCaption = 'Vider';
  UserslbAccountCaption = 'COMPTE';
  UserslbPasswordCaption = 'Mot de P.';
  UserslbGroupCaption = 'Groupe';
  UserslbFirstNameCaption = 'Pr�nom';
  UserslbMiddleNameCaption = 'Initiale';
  UserslbLastNameCaption = 'Nom';

{IBF_Who.pas}
  WhoCaption = 'Qui est inscrit?';
  WhobtApplyCaption = ' Rafra�chir';

{IB_ConnectionBar.pas}
  IBConnectionBarHints: array [0..3] of String = ('Cr�er une Base de donn�es',
                                                  'Connecter une Base de donn�es',
                                                  'D�connecter une Base de donn�es',
                                                  'Supprimer une Base de donn�es');

{IB_DatasetBar.pas}
  DatasetBarHints: array [0..3] of String = ('[Prepare] Table',
                                             '[Unprepare] Table',
                                             'Ouvrir Table',
                                             'Fermer Table');

{IB_JPEGImage.pas}

  EJPEGExceptionCreate = 'Il y a des avertissements';

{IB_Editor.pas}

  StatementhasnoParams = 'La Requ�te n''a pas de Param�tres';
  UnassignedEditmethod = 'M�thode �dition non assign�e';
  GetVerbResult0 = '�&diter';

{IB_StatementBar.pas}
  StatementBarButtonsHints: array [0..4] of String =
                                           ('Allou� Requ�te',
                                            'D�sallou� Requ�te',
                                            '[Prepare] Requ�te',
                                            '[Unprepare] Requ�te');

{IB_StatementGrid.pas}
  C_SG_Field = 'Champ';
  C_SG_Info = 'Info';
  C_SG_Name = 'Nom';
  C_SG_Parameter = 'Param�tre';
  C_SG_Type = 'Type';
  C_SG_Value = 'Valeur';

{IB_TransactionBar.pas}
  TransactionBarInitHints: array [0..7] of String =
                                             ('Lancer Transaction',
                                              '�crire changements',
                                              'Annuler changements',  
                                              'Enregistrer et Conserver Transaction courante',  
                                              '�crire changements et Enregistrer et Conserver Transaction courante',  
                                              'Enregistrer et Fermer Transaction courante',  
                                              'D�faire et Fermer Transaction courante',
                                              'Fermer Transaction courante');



{IB_NavigationBar.pas}
  NavigationBarInitHints: array [0..5] of String =
                                             ('Premier rang',
                                              'Rang pr�c�dent',  
                                              'Rang suivant',  
                                              'Dernier rang'
                                              'Page pr�c�dente',
                                              'Page suivante');  


implementation

end.


