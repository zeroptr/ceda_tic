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
C_BF_EXECUTE = 'Exécuter';
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
C_SG_Parameter = 'Paramètre';
C_SG_Type = 'Type';
C_SG_Value = 'Valeur';
C_wbBrowseBtnCaption = 'Fureter';
C_wbBrowseBtnHint = 'Parcourir la Base de données';
C_wbDSQLBtnCaption = 'DSQL';
C_wbDSQLBtnHint = 'Appliquer Requête à à la Base de données';
C_wbDumpBtnCaption = 'Exporter';
C_wbDumpBtnHint = 'Exporterla Base de données';
C_wbEventsBtnCaption = 'Évènements';
C_wbEventsBtnHint = 'Gestion d''évènement sur le Serveur associé';
C_wbExportBtnCaption = 'Exporter';
C_wbExportBtnHint = 'Exporter les données de la Base';
C_wbMonitorBtnCaption = 'Moniteur';
C_wbMonitorBtnHint = 'Surveiller opérations SQL et API';
C_wbPumpBtnCaption = 'Importer';
C_wbPumpBtnHint = 'Importer les données d''une autre Base';
C_wbScriptBtnCaption = 'Scénario';
C_wbScriptBtnHint = 'Exécuter Scénario';
C_wbUsersBtnCaption = 'Usagers';
C_wbUsersBtnHint = 'Administrateur d''Usagers pour le Serveur associé';
C_wbWhoBtnCaption = 'Usager?';
C_wbWhoBtnHint = 'Coordonnées de l''usager connecté';
C_WHO_BTNAPPLY = 'Rafraîchir';
C_WHO_FRM = 'Usager connecté';
E_53BIT_OVERFLOW = 'Nombre entier 53bit surchargé';
E_ALLOCATED = 'Allocation de la Requête déjà exécuté';
E_Array_Is_Null = '[Array] est Vide';
E_Assign_Column = 'Ne peut copier depuis %s';
E_AssignTo_Column = 'Ne peut copier vers %s';
E_AT_END_OF_BUFFER = 'Fin du tampon';
E_AT_END_OF_CURSOR = 'Fin du curseur';
E_AT_END_OF_DATASET = 'Fin de la Table';
E_AT_END_OF_FILE = 'Fin du fichier';
E_BAD_SQL_INF_DATA = 'Données invalides renvoyées par [isc_dsql_sql_info]';
E_BAD_SQL_INF_LEN = 'Taille imprévue dans [isc_dsql_sql_info]';
E_BEGINNING_OF_DATASET = 'Début de la Table';
E_BLANK_STATEMENT = 'Ne peut activer [Prepare] avec une Requête vierge';
E_Cannot_Activate = 'État de Transaction invalide. Ne peut Activer.';
E_Cannot_Activate_Transaction = 'Activation de Transaction impossible';
E_Cannot_add_blank_account = 'Ajout d''un COMPTE vierge refusé';
E_Cannot_add_SYSDBA_account = 'Ajout d''un COMPTE SYSDBA refusé';
E_CANNOT_CANCEL_ROW = 'Annulation du Rang actif refusée';
E_Cannot_Change_Events = 'Traitement en cours.  Modification refusée';
E_Cannot_delete_blank_account = 'Suppression d''un COMPTE vierge refusé';
E_Cannot_Delete_Row = 'Suppression du Rang actif refusée';
E_Cannot_delete_SYSDBA_account = 'Suppression du compte SYSDBA refusé';
E_Cannot_Edit_Row = 'Édition du Rang actif refusé';
E_Cannot_Insert_Row = 'Insertion d''un nouveau Rang refusé';
E_Cannot_modify_blank_account = 'Modification d''un COMPTE vierge refusé';
E_Cannot_Navigate = 'Ne peut fureter';
E_Cannot_Pessimistic_Lock = 'Verrouillage pessimistique impossible avec [LockWait]';
E_CANNOT_POST_ROW = 'Enregistrement du Rang actif refusé';
E_Cannot_Search = 'Recherche non permise';
E_Cannot_Unregister_Events = 'Suppression d''entrée au registre impossible'#13#10+
                             'pendant l''exécution de la procédure';
E_CANT_CHG_WITH_CONN = 'Modification impossible lorsque connecté';
E_CANT_DELETE = 'Suppression du dossier actif dans le curseur refusé';
E_CANT_GET_CONN_CHR = 'Charactéristiques de Connection inexistants';
E_CANT_LOAD_BLOB = 'Champ [Blob] ne peut être ou a déjà été chargé';
E_Cant_Repl_Int_Tr = 'Remplacement de Transaction interne par défaut refusé';
E_CANT_STORE_BLOB = 'Champ [Blob] ne peut être ou a déjà été sauvé';
E_Cant_Unprepare_executing_process = '[Unprepare] invalidé. Traitement en cours';
E_CIRCULAR_REFERENCE = 'Référence circulaire refusée';
E_CONN_LOADING = 'Avertissement: Connection en cours de chargement';
E_CONNECT_FAILED = 'Ouverture IB_Connection refusée';
E_CONNECTED = 'La Connection a déjà été établie';
E_Could_Not_Load_Memo = 'Chargement [memo] impossible';
E_CURSOR_NAME_LOCK = 'Le nom d''un Curseur actif ne peut être modifié';
E_CURSOR_UNI = 'IB_CURSOR est unidirectionel';
E_DATABASE_BLANK = '[DatabaseName] ne peut être vierge';
E_DatasetCannotScroll = 'Défilement de la Table refusé';
E_DatasetClosed = 'Table inactive';
E_DatasetIsFetching = 'Résultat en cours d''exécution';
E_DatasetOpen = 'Table déjà ouverte';
E_DatasetReadOnly = 'Table en lecture seule';
E_DUP_DB_NAME = '[DatabaseName} dupliqué refusé';
E_END_OF_DATASET = 'Fin de la Table';
E_Failed_To_Cancel_Datasets = 'Annulation de toutes les Tables ratée';
E_Failed_To_Post_Datasets = 'Sauvegarde de toutes les Tables ratée';
E_FAILED_TO_PREPARE = '[Prepare] sur Requête raté';
E_FIELD_NOT_NULLABLE = 'Champ [NOT NULL] reporté à valeur [NULL]';
E_FIELDNAME_NOT_FOUND = '[FieldName]: %s inexistant';
E_FIELDNO_NOT_FOUND = '[FieldNo]: %d inexistant';
E_FileName_Required = '[FileName] obligatoire';
E_FLD_READONLY = '%s en lecture seule';
E_GeneratorFailed = 'Retour du générateur impossible';
E_GET_CURSOR_ERROR = 'Ouverture du Curseur impossible sans clé-maîtresse';
E_IB_Client_Not_Installed = 'Client InterBase GDS32.DLL non installé';
E_Init_Default_SQL_Failed = 'Initialisation par défaut de %s impossible';
E_INV_CREATE_CONNECT_DROP = 'Syntaxe de CREATE, CONNECT ou DROP DATABASE invalide';
E_Inv_Custom_DML = 'Invalid custom DML column reference: %s';
E_Invalid_Bookmark = 'Chaîne Signet invalide';
E_INVALID_BUFFER_ROW_NUM = '[BufferRowNum] invalide avant le lancement';
E_Invalid_ColData = '[ColData] Invalide';
E_Invalid_DataPump_Statement = 'Type Requête invalide pour pour Importation';
E_INVALID_DB_NAME = '[DatabaseName] invalide';
E_Invalid_DPB_Over_255 = '[DPB] invalide: Maximum de 255 caractères';
E_INVALID_FOCUS_RELATION_NAME = 'Invalid Focused Relation Name: %s';
E_INVALID_FOCUS_RELATION_NO = 'Invalid Focused Relation No: %d';
E_Invalid_Internal_Transaction = '[IB_]Transaction Interne Invalide';
E_Invalid_KeyLinks = 'Entrée [KeyLinks] invalide: %s';
E_Invalid_KeyRelation = 'Valeur [KeyRelation] invalide';
E_INVALID_QBE_BETWEEN = 'Erreur de syntaxe dans valeur [BETWEEN] et valeur [AND]';
E_INVALID_QBE_IN = 'Erreur de syntaxe dans IN( valeur [ , valeur ... ] )';
E_Invalid_RowNum = '[RowNum] invalide';
E_Invalid_RowNum_Before_Bof = '[RowNum] précède [Bof] Début du fichier';
E_Invalid_RowNum_Past_Eof = '[RowNum] dépasse [Eof] Fin du fichier';
E_Invalid_RowsAffected_Buffer = 'Tampon [RowsAffected] invalide';
E_INVALID_SQL_KEY_FIELDS = 'Propriétés [SQLKeyFields] invalide';
E_Invalid_Syntax = 'Syntaxe invalide: parenthèses en trop ou en moins';
E_Invalid_Typecast = 'Transtypage invalide';
E_InvalidClassType = 'Type [class] Invalide';
E_InvalidRowsAffectedBuf = 'Tampon [RowsAffected] invalide';
E_InvalidStatementType = 'Type de Requête invalide';
E_LOGIN_FAILED = 'Accès refusé';
E_MAX_EVENTS_BLOCK = 'Nombre d''évènements surchargé pour un bloc';
E_Multiple_Records_Deleted = 'Plusieurs dossiers supprimés';
E_Multiple_Records_Updated = 'Plusieurs dossiers mis à jour';
E_Multiple_Rows_In_Singleton = 'Plusieurs dossiers en une seule transaction';
E_MustBe_Buffered_Dataset = 'Doit découler de TIB_BDataset (IB_Query)';
E_NO_ACTIVE_TRANS = 'Aucune Transaction active à éxécuter...';
E_NO_BLANK_SQL = 'Requête SQL vierge refusée';
E_NO_CHANGE_ISOLATION = 'Ne peut modifier [Isolation] lorqu''Amorcé';
E_NO_CHANGE_LOCKWAIT = 'Ne peut modifier [LockWait] lorqu''Amorcé';
E_NO_CHANGE_READONLY = 'Ne peut modifier [ReadOnly] lorqu''Amorcé';
E_NO_CHANGE_RECVERSION = 'Ne peut modifier [RecVersion] lorqu''Amorcé';
E_NO_CONNECTION = 'Requête doit avoir une [IB_]Connection assignée';
E_NO_CONNECTIONS = 'Transaction est sans connections';
E_NO_POSTRTN_CACHED_UPDT = '[PostRetaining] inutilisable avec [Cached Updates]';
E_NO_TRANS_STARTED = 'Transaction n''a pas été amorcée';
E_NO_TRANSACTION = 'Requête doit avoir une [IB_]Transaction assignée';
E_NoCircularRef = 'Référence circulaire refusée';
E_NoRecordsFound = 'Aucun dossier trouvé';
E_NOT_ALLOCATED = 'Requête n''a pas été précisée';
E_NOT_CONNECTED = 'Connection n''a pas été établie';
E_NOT_ENOUGH_CONN = 'Transaction manque d''une ou plusieurs connections';
E_NOT_OPENED = 'Requête n''a pas été ouverte';
E_NOT_PREPARED = 'Requête n''a pas été Préparée';
E_NotImplemented = 'Non implementé à ce niveau';
E_OPENED = 'Requête à déjà été ouverte';
E_PLAN_ERROR = ' ERREUR PLAN!';
E_PLAN_EXCEPTION = 'EXCEPTION PLAN!';
E_PREPARED = 'La Requête à déjà été Préparée';
E_PROCESSING_EVENTS = 'Évènements en cours d''exécution!'#13#10+
                      'Suppression au registre impossible.';
E_Record_Locked = 'Dossier verrouillé par un autre usager';
E_Record_Not_Inserted = 'Le dossier n''a pas été ajouté';
E_Record_Not_Located_For_Delete = 'Dossier de suppression non trouvé';
E_Record_Not_Located_For_Update = 'Dossier de mise à jour non trouvé';
E_Record_OutOfSynch = 'Le dossier a été modifié par un autre usager';
E_REQUEST_LIVE_ACTIVE = '[RequestLive] ne peut être modifié en mode actif';
E_REQUEST_LIVE_READONLY = '[RequestLive] impossible sur une base en lecture seule';
E_Required_Field = '%s est un champ requis';
E_RowDeleted = 'Rang en cours de suppression';
E_RowNum_Not_Implemented = '[RowNum] non encore implémenté';
E_SCROLL_ERROR = 'Clé-maîtresse perdue...!'#10#13'Ouverture Curseur ratée.';
E_Session_Undefined = Session non définie';
E_SmallintOverflow = '[Smallint] surchargé';
E_START_FAILED = 'Incapable d''amorcer une transaction';
E_Stringlist_Not_Sorted = '[Stringlist] doit être indexé pour cette opération';
E_SVRAUTOCMT_NOEXP = 'Trans. [Explicit] non permise avec [ServerAutoCommit]';
E_TRANS_CONN_SESS = 'Connections doivent toutes être dans la même [IB_Session]';
E_TRANS_STARTED = 'Transaction déjà amorcée';
E_Transaction_Is_Active = 'Transaction à des changements en attente';
E_TransactionPaused = 'Transaction est en mode [Paused]';
E_Unable_Save_Graphic = 'Sauvegarde à [Graphic] impossible';
E_UNABLE_TO_LOCATE_DLL_IMPORT = 'Location de la DLL d''import impossible %s';
E_Unable_To_Locate_Record = 'Location du dossier impossible';
E_Unable_to_perform_search = 'Procédure Recherche impossible';
E_UnableToSearch = 'Procédure Recherche impossible';
E_Unassigned_Blob_Node = '[BlobNode] non assigné';
E_Unassigned_Transaction = 'Transaction non assignée';
E_UndefinedMacro = 'Macro non définie';
E_UNKNOWN_STATEMENT = 'Tentative d''exécution d''une Requête inconnue';
E_Unsupp_Col_Conversion = 'Conversion de colonne non supportée';
E_Unsupported = 'Non supporté';
E_Unsupported_Column = 'Type de colonne [%d] non supporté';
E_UNSUPPORTED_COLUMN_TYPE = 'Type de colonne [%d] non supporté';
E_UpdateWrongTrn = 'Mise à jour refusée, %s ne découle pas de %s';
E_Value_Out_Of_Range = 'Valeur hors-champ';
H_BTN_EXPORT_BEGIN = 'Exporter selon la Requête [SELECT}';
H_NB_FIRST = 'Premier Rang';
H_NB_JUMPBCK = 'Page précédente';
H_NB_JUMPFWD = 'Page suivante';
H_NB_LAST = 'Dernier Rang';
H_NB_NEXT = 'Rang suivant';
H_NB_PRIOR = 'Rang précédent';
H_SB_CLEAR_CRITERIA = 'Vider Critère';
H_SB_COUNT = 'Décompte des Rangs dans la Table';
H_SB_LAST_CRITERIA = 'Rappeler le Critère précédent';
H_SB_ORDER = 'Indexer les Rangs dans la Table';
H_SB_RECALL_CRITERIA = 'Rappeler les Critères';
H_SB_SAVE_CRITERIA = 'Sauvegarder les Critères';
H_SB_SEARCH = 'Rechercher dans la Table';
H_SB_SEARCHCOUNT = 'Décompte des Rangs assortis aux Critères Recherche';
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
H_UB_CANCELEDIT = 'Annuler édition';
H_UB_CANCELINSERT = 'Annuler insertion';
H_UB_CANCELSEARCH = 'Annuler critères recherche';
H_UB_DELETE = 'Supprimer Rang';
H_UB_EDIT = 'Editer Rang';
H_UB_INSERT = 'Insérer Rang';
H_UB_POST = 'Poster changements';
H_UB_POSTDELETE = 'Poster suppression'
H_UB_POSTEDIT = 'Poster édition';
H_UB_POSTINSERT = 'Poster insertion';
H_UB_POSTSEARCH = 'Poster critères recherche';
H_UB_REFRESH = 'Rafraîchir tous les dossiers';
H_UB_REFRESHKEYS = 'Rafraîchir les clés du dossier';
H_UB_REFRESHROWS = 'Rafraîchir les rangs du dossier';
IB_REG_MESSAGE = 'Merci d''évaluer IB Objects.'#10#13#10#13+
                 'S.V.P. joindre http://www.ibobjects.com'#10#13+
                 'et enregistrez-vous maintenant.';
L_EXPORT_ASCII = ' Format Fichier ';
L_EXPORT_ASCIIOPT = ' Options ASCII ';
L_EXPORT_DATEFORMAT = 'Format Date';
L_EXPORT_DBF = 'DBF';
L_EXPORT_DELIMETED = 'Délimité';
L_EXPORT_DELIMITER = 'Délimiteur';
L_EXPORT_FIXED = 'Taille dossier fixe';
L_EXPORT_FRM = 'Exporter';
L_EXPORT_INCLUDEHEADERS = 'Inclure Entêtes';
L_EXPORT_SDEXPORTFILTERDBF = 'Fichiers DBF ( *.DBF )|*.DBF';
L_EXPORT_SDEXPORTFILTERTXT = 'Fichiers Texte ( *.TXT )|*.TXT';
L_EXPORT_SDEXPORTTITLE = 'Exporter';
L_EXPORT_SEPARATOR = 'Séparateur';
L_USERS_ACCOUNT = 'COMPTE';
L_USERS_ADD = 'Ajouter';
L_USERS_DELETE = 'Supprimer';
L_USERS_FIRSTNAME = 'Prénom';
L_USERS_FRM = 'Gestionnaire des COMPTES d''accès';
L_USERS_GROUP = 'Groupe';
L_USERS_LASTNAME = 'Nom';
L_USERS_MIDDLENAME = 'Initiale';
L_USERS_MODIFIY = 'Modifier';
L_USERS_PASSWORD = 'Mot de P.';
M_Abort_Fetching = 'Vraiment stopper la procédure?';
M_Abort_Fetching_Btn = 'Stopper';
M_CancelTransactionPrompt = 'Vraiment supprimer tous les changements?';
M_Fetching_Query_Results = 'Résultats de la Requête';
M_Loading_Caption = 'Chargement...';
M_Login_Cancel_Btn = 'Annuler';
M_Login_Database = 'Base de D.';
M_Login_Dialog_Caption = 'Autorisation d''accès';
M_Login_Help_Btn = 'Aide';
M_Login_OK_Btn = 'OK';
M_Login_Password = 'Mot de P.';
M_Login_User = 'Usager';
M_Row_Num = 'Rang# %d';
M_Save_Changes = 'Enregistrer les changements?';
M_SB_REC_CNT = 'Dossiers comptés : %d';
M_SCRIPT_ABORT_EXECUTE = 'Stopper l''exécution de ce scénario?';
M_SCRIPT_COMPLETED = 'Scénario complété sans exceptions';
M_SCRIPT_CONTINUE_EXECUTING = 'Continuer l''exécution du scénario?';
M_SCRIPT_FAILED = 'Exécution du scénario ratée avant terme';
M_SCRIPT_IS_EXECUTING = 'Scénario en cours d''exécution';
M_SCRIPT_WAS_ABORTED = 'L''exécution du scénario a été stoppée';

{ This ends resources I found in the help file.
  Here are a few translations which might be utils.}

{IBD_About.pas}
  AboutCaption 	= 'À propos de...';
  AboutMemo1 = 
	'Ces composants donnent accès directement à l''API d''INTERBASE.'#13#10#13#10+
	'De ce fait, la BDE et l'ODBC sont exclus de cette application DEMO.'#13#10#13#10+
	'InterBase Objects est la seule propriété de CPS et est maintenant'#13#10+
	'disponible pour revente.  Veuillez vous brancher sur le site Web en'#13#10+
	'rubrique pour plus d''informations.'#13#10#13#10+
	'Pour développer et écrire une application client/server avec'#13#10+
	'IB Objects, veuillez contacter CPS pour rencontrer vos besoins'#13#10+
	'spécifiques.'#13#10#13#10+
	'Vous pouvez également vous informer des possibilités de devenir un'#13#10+
	'utilisateur autorisé de CPS. Vous obtiendrez alors les droits de'#13#10+
	'développer vos propres applications ou celles de vos clients en'#13#10+
	'utilisant IB Objects.'#13#10#13#10+
	'RENONCIATION : Ce produit est offert TEL-QUEL.  Aucun dommage, de quelque'#13#10+
	'nature que ce soit, ne peut être imputé  à CPS pour quelque genre de'#13#10+
	'perte pouvant résulter de l''utilisation de ce produit.';

  AboutCommentsCaption 	= 'Auteur: Jason Wharton';

{IBD_Error.pas}
  ErrorCaption = 'Dialogue d''erreurs...';
  ErrorMsgCaption = 'Message d''erreur';


{IBD_StingList.pas}
  StringListCaption = 'Éditeur de chaînes';

{IBF_Base.pas}
  BaseCaption = 'Procédure de Base';

{IBF_Browse.pas}
//  C_wbBrowseBtnCaption = 'Fureter';
//  C_wbBrowseBtnHint = 'Parcourir les données de la base';

  BrowsebtEditTriggerMsg = 'Source Déclancheur [Trigger] invalide.';
  BrowsebtEditProcMsg = 'Source [Procédure] invalide.';
  BrowsetsRelationsCaption  = 'Relations';
  BrowsecbTablesCaption  = 'Tables';
  BrowsecbViewsCaption  = 'Vues';
  BrowsecbSystemCaption  = 'Système Inf.';
  BrowsecbDomainInfoCaption  = 'Domaines Inf.';
  BrowsetsRelFieldsCaption  = 'Champs';
  BrowsetsDataCaption  = 'Données';
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
  BrowsebtEditTriggerCaption  = 'Éditer';
  BrowsetsSourceCaption  = 'Source';
  BrowsetsRelDescCaption  = 'Dest.';
  BrowsetsRelDependCaption  = 'Dépend.';
  BrowsetsFieldListCaption  = 'Liste des Champs';
  BrowseTabSheet10Caption  = 'Procédures';
  BrowsebtEditProcCaption  = 'Éditer';
  BrowsetsProcSourceCaption  = 'Source';
  BrowsetsProcedureInputsCaption  = 'Param.';
  BrowsetsProcedureOutputsCaption  = 'Champs';
  BrowsetsProcDescCaption  = 'Description';
  BrowsetsProcDependCaption  = 'Dépend.';
  BrowsetsDomainsCaption  = 'Domaines';
  BrowsetsGeneratorsCaption  = 'Générateurs';
  BrowseConfirmDeletePromptStrings  = 'Êtes-vous certain?';

{IBF_DataDump.pas}
  DataDumpCaption = 'Exporter des données';
  DataDumptsDataCaption = 'Données';
  DataDumptsDumpCaption = 'Exporter';
  DataDumplbFieldsHint = 'CTRL+Click pour Exclure';
  DataDumplbTablesHint = 'CTRL+Click pour Exclure';
  DataDumpsbDataDumpHint = 'Exporter selon la requête';
  DataDumpsbDataDumpCaption = 'Lancer Exporter...';
  DataDumpgbASCIICaption = ' Format fichier';
  DataDumplbDelimiterCaption = 'Délimiteur';
  DataDumplbSeparatorCaption = 'Séparateur';
  DataDumprbDelimetedCaption = 'Délimité';
  DataDumprbFixedCaption = 'Taille dossier fixe';
  DataDumpcbHeadersCaption = 'Inclure Entêtes';
  DataDumpsdExportDefaultExt = 'TXT';
  DataDumpsdExportFileName = '*.TXT';
  DataDumpsdExportFilter = 'Fichiers texte ( *.TXT )|*.TXT';
  DataDumpsdExportTitle = 'Exporter';
  DataDumpCloseQueryMsg = 'Exporter en cours d''exécution.';

{IBF_DataPump.pas}
  DataPumpCaption = 'Importer des données';
  DataPumprbSeparateSrcDatabaseCaption = 'Separate Database';
  DataPumpbtSrcDatabaseCaption = 'Choix Base données...';
  DataPumptsDestinationCaption = 'RequêteDst.SQL';
  DataPumprbSeparateDstDatabaseCaption = 'Separate Database';
  DataPumprbSeparateDstDatabaseHint = 'Destination particulière';//*
  DataPumpbtDstDatabaseCaption = 'Choisir Base de d.';
  DataPumptsDstLinksCaption = 'DstLinks';
  DataPumptsItemAttributesCaption = 'ItemAttributes';
  DataPumpbtClassesCaption = 'Classes';
  DataPumptsItemActionsCaption = 'ItemActions';
  DataPumpbtPrepareCaption = 'Préparer';
  DataPumptsExecuteCaption = 'Exécuter';
  DataPumpLabel1Caption = 'Destination:';
  DataPumpLabel2Caption = 'Source:';
  DataPumpLabel3Caption = 'Rangs Traités:';
  DataPumpLabel4Caption = 'Rangs/Seconde:';
  DataPumpLabel6Caption = 'Erreurs:';
  DataPumpbtExecuteCaption = 'Exécuter';
  DataPumpcbIgnoreErrorCaption = 'Ignorer Erreurs';
  DataPumpcbIgnoreCountCaption = 'Ignorer Décompte';
  DataPumpConfirmClosePromptStrings = 'Sauver les changemens d''importation?';
  DataPumpCloseQueryMsg = 'Importer en cours d''exécution.';

{IBF_DSQL.pas}
  C_wbDSQLBtnCaption = 'DSQL';
  C_wbDSQLBtnHint = 'Exécuter Requête sur la Base de données';

  DSQLCaption = 'DSQL';
  DSQLbtSQLPreviousCaption = '&Précédent';
  DSQLbtSQLNextCaption = '&Suivant';
  DSQLbtNewSQLCaption = '&Nouveau';
  DSQLcbParamsCaption = 'Param.?';
  DSQLtsSQLCaption = 'SQL';
  DSQLtsDSQLInputCaption = 'Param.';
  DSQLtsDSQLOutputCaption = 'Champs';

{IBF_Events}
  EventsCaption = 'Évènements';
  EventsbtRegEventsRegCaption = '(+)Registre';
  EventsbtRegEventsRegHint = 'Porter au registre';
  EventsbtRegEventsUnRegCaption = '(-)Registre';
  EventsbtRegEventsUnRegHint = 'Retirer du registre';
  EventsbtClearResultsCaption = 'Vider';

{IBF_Export.pas}
  ExportCaption = 'Exporter';
  ExportlbDateFormatCaption = 'Format Date';
  ExportgbASCIICaption = ' Format Fichier';
  ExportlbDelimiterCaption = 'Délimiteur';
  ExportlbSeparatorCaption = 'Séparateur';
  ExportrbDelimetedCaption = 'Délimeté';
  ExportrbFixedCaption = 'Taille dossier fixe';
  ExportcbHeadersCaption = 'Inclure Entêtes';
  ExportsbExportHint = 'Exporter selon la requête';
  ExportsbExportCaption = 'Lancer Exporter';
  ExportsbImportHint = 'Importer selon la requête';
  ExportsbImportCaption = 'Lancer Importer';
  ExportsdExportDefaultExt = 'TXT';
  ExportsdExportFileName = '*.TXT';
  ExportsdExportFilter = 'Fichiers texte ( *.TXT )|*.TXT';
  ExportsdExportTitle = 'Exporter';
  ExportFormCloseQueryMsg = 'Procédure d''exportation déjà activée.';

{IBF_Lookup.pas}
  LookupCaption = 'Grille de consultation';

{IBF_Monitor.pas}
  MonitorCaption = 'Moniteur';
  MonitorcbEnabledChecked = '/*--------  ACTIVÉE  --------*/';
  MonitorcbEnabledNotChecked = '/*-------  DÉSACTIVÉE -------*/';
  MonitorcbConnectionCaption = 'C&onnection';
  MonitorcbTransactionCaption = '&Transaction';
  MonitorcbStatementCaption = 'Req&uête';
  MonitorcbRowCaption = '&Rang';
  MonitorbtSaveCaption = '&Sauver...';
  MonitorcbSQLCaption = 'S&QL';
  MonitorcbEnabledCaption = '&Activé';
  MonitorcbBlobCaption = '&Blob';
  MonitorsdMonitorDefaultExt = 'TXT';
  MonitorsdMonitorFilter = 'Fichiers texte (*.TXT)|*.TXT';
  MonitorsdMonitorTitle = 'Nom du fichier de sauvegarde de la requête';

{IBF_Parameters.pas}
  ParametersCaption = 'Éditeur Paramètres';


{IBF_Script.pas}
  ScriptCaption = 'Scénario';
  ScriptbtClearCaption = '&Vider';
  ScriptbtLoadCaption = '&Charger...';
  ScriptbtSaveCaption = '&Sauver...';
  ScriptbtExecuteCaption = '&Exécuter';
  ScriptcbStoreCaption = 'C&onserver?';
  ScriptcbYieldCaption = '&Yield';
  ScriptcbYieldHint = 'Activer Application.ProcessMessages durant la procédure.';
  ScriptodScriptTitle = 'Ouvrir Scénario SQL';
  ScriptsdScriptTitle = 'Sauver Scénario';
  ScriptbtExecuteClickMsg = 'Abandonner l''exécution de ce Scénario?';
  ScriptAfterExecuteFailed = 'Le Scénario a échoué avant terme';
  ScriptAfterExecuteAborted = 'L''exécution du Scénario à été abandonné';
  ScriptAfterExecute = 'Le Scénario s''est terminé sans exception';
  ScriptCloseQueryMsg = 'Le Scénario est en cours d''exécution.';
  ScriptScriptErrorMsg = 'Poursuivre l''exécution du Scénario?';

{IBF_Users.pas}

  UsersCaption = 'Gestion des Comptes d''usager';
  UsersbtDeleteUserCaption = 'Supprimer';
  UsersbtModifyUserCaption = 'Modifier';
  UsersbtClearCaption = 'Vider';
  UserslbAccountCaption = 'COMPTE';
  UserslbPasswordCaption = 'Mot de P.';
  UserslbGroupCaption = 'Groupe';
  UserslbFirstNameCaption = 'Prénom';
  UserslbMiddleNameCaption = 'Initiale';
  UserslbLastNameCaption = 'Nom';

{IBF_Who.pas}
  WhoCaption = 'Qui est inscrit?';
  WhobtApplyCaption = ' Rafraîchir';

{IB_ConnectionBar.pas}
  IBConnectionBarHints: array [0..3] of String = ('Créer une Base de données',
                                                  'Connecter une Base de données',
                                                  'Déconnecter une Base de données',
                                                  'Supprimer une Base de données');

{IB_DatasetBar.pas}
  DatasetBarHints: array [0..3] of String = ('[Prepare] Table',
                                             '[Unprepare] Table',
                                             'Ouvrir Table',
                                             'Fermer Table');

{IB_JPEGImage.pas}

  EJPEGExceptionCreate = 'Il y a des avertissements';

{IB_Editor.pas}

  StatementhasnoParams = 'La Requête n''a pas de Paramètres';
  UnassignedEditmethod = 'Méthode Édition non assignée';
  GetVerbResult0 = 'É&diter';

{IB_StatementBar.pas}
  StatementBarButtonsHints: array [0..4] of String =
                                           ('Alloué Requête',
                                            'Désalloué Requête',
                                            '[Prepare] Requête',
                                            '[Unprepare] Requête');

{IB_StatementGrid.pas}
  C_SG_Field = 'Champ';
  C_SG_Info = 'Info';
  C_SG_Name = 'Nom';
  C_SG_Parameter = 'Paramètre';
  C_SG_Type = 'Type';
  C_SG_Value = 'Valeur';

{IB_TransactionBar.pas}
  TransactionBarInitHints: array [0..7] of String =
                                             ('Lancer Transaction',
                                              'Écrire changements',
                                              'Annuler changements',  
                                              'Enregistrer et Conserver Transaction courante',  
                                              'Écrire changements et Enregistrer et Conserver Transaction courante',  
                                              'Enregistrer et Fermer Transaction courante',  
                                              'Défaire et Fermer Transaction courante',
                                              'Fermer Transaction courante');



{IB_NavigationBar.pas}
  NavigationBarInitHints: array [0..5] of String =
                                             ('Premier rang',
                                              'Rang précédent',  
                                              'Rang suivant',  
                                              'Dernier rang'
                                              'Page précédente',
                                              'Page suivante');  


implementation

end.


