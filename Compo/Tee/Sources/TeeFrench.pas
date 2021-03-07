unit TeeFrench;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeFrenchLanguage:TStringList=nil;

Procedure TeeSetFrench;
Procedure TeeCreateFrench;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeFrenchConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 par David Berneda';
  TeeMsg_LegendFirstValue   :='La premi�re valeur de la l�gende doit �tre > 0';
  TeeMsg_LegendColorWidth   :='La derni�re largeur de la couleur de la l�gende doit �tre > 0%';
  TeeMsg_SeriesSetDataSource:='Pas de graphique pour valider la source de donn�es';
  TeeMsg_SeriesInvDataSource:='Source de donn�es invalide: %s';
  TeeMsg_FillSample         :='Valeurs de remplissage doivent �tre > 0';
  TeeMsg_AxisLogDateTime    :='Axe Date/Heure ne peut pas �tre logarithmique';
  TeeMsg_AxisLogNotPositive :='Les valeurs Min et Max de l''axe logarithmique doivent �tre >= 0';
  TeeMsg_AxisLabelSep       :='La s�paration d''�tiquettes % doit �tre plus grand que 0';
  TeeMsg_AxisIncrementNeg   :='L''incr�mentation de la graduation de l''axe doit �tre >= 0';
  TeeMsg_AxisMinMax         :='La valeur Minimum de l''axe doit �tre <= Maximum';
  TeeMsg_AxisMaxMin         :='La valeur Maximum de l''axe doit �tre >= Minimum';
  TeeMsg_AxisLogBase        :='La base Logarithmique de l''axe doit �tre >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage doit �tre >= 0';
  TeeMsg_3dPercent          :='Le pourcentage de l''effet 3D doit �tre entre %d et %d';
  TeeMsg_CircularSeries     :='Les S�ries � r�f�rences ciruclaires ne sont pas autoris�es';
  TeeMsg_WarningHiColor     :='16k couleur ou plus sont n�cessaires pour avoir un meilleur rendu';

  TeeMsg_DefaultPercentOf   :='%s de %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'de %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Titre de l''axe';
  TeeMsg_AxisLabels         :='Etiquettes de l''axe';
  TeeMsg_RefreshInterval    :='L''intervalle de rafra�chissement doit �tre entre 0 et 60';
  TeeMsg_SeriesParentNoSelf :='S�rie actuelle ne peut �tre moi-m�me!';
  TeeMsg_GalleryLine        :='Ligne';
  TeeMsg_GalleryPoint       :='Point';
  TeeMsg_GalleryArea        :='Aire';
  TeeMsg_GalleryBar         :='Barre';
  TeeMsg_GalleryHorizBar    :='Barre Horiz.';
  TeeMsg_Stack              :='Pile';
  TeeMsg_GalleryPie         :='Camembert';
  TeeMsg_GalleryCircled     :='Encercl�';
  TeeMsg_GalleryFastLine    :='Ligne rapide';
  TeeMsg_GalleryHorizLine   :='Ligne Horiz.';

  TeeMsg_PieSample1         :='Voitures';
  TeeMsg_PieSample2         :='T�l�phones';
  TeeMsg_PieSample3         :='Tableaux';
  TeeMsg_PieSample4         :='Ecrans';
  TeeMsg_PieSample5         :='Lampes';
  TeeMsg_PieSample6         :='Claviers';
  TeeMsg_PieSample7         :='V�los';
  TeeMsg_PieSample8         :='Chaises';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editer %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Etendues';
  TeeMsg_GalleryFunctions   :='Fonctions';

  TeeMsg_EditChart          :='E&diter Graphique...';
  TeeMsg_PrintPreview       :='&Pr�visualiser...';
  TeeMsg_ExportChart        :='E&xporter Graphique...';
  TeeMsg_CustomAxes         :='Axes personnalis�s...';

  TeeMsg_InvalidEditorClass :='%s: Editeur de classes invalide: %s';
  TeeMsg_MissingEditorClass :='%s: n''a pas d''�diteur';

  TeeMsg_GalleryArrow       :='Fl�che';

  TeeMsg_ExpFinish          :='&Fin';
  TeeMsg_ExpNext            :='&Suivant >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototypage';
  TeeMsg_GanttSample3       :='D�veloppement';
  TeeMsg_GanttSample4       :='Ventes';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Test';
  TeeMsg_GanttSample7       :='Manufac.';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='Nouvelle Version';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='Changer le titre de la S�rie';
  TeeMsg_NewSeriesTitle     :='Nouveau titre de S�rie:';
  TeeMsg_DateTime           :='Date/Heure';
  TeeMsg_TopAxis            :='Axe du haut';
  TeeMsg_BottomAxis         :='Axe du bas';
  TeeMsg_LeftAxis           :='Axe de gauche';
  TeeMsg_RightAxis          :='Axe de droite';

  TeeMsg_SureToDelete       :='Effacer %s ?';
  TeeMsg_DateTimeFormat     :='For&mat Date/Heure:';
  TeeMsg_Default            :='D�faut';
  TeeMsg_ValuesFormat       :='For&mat des valeurs:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Incr�mentation %s d�sir�e';

  TeeMsg_IncorrectMaxMinValue:='Valeur incorrecte. Raison: %s';
  TeeMsg_EnterDateTime      :='Entrer [Numbre de jours] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Appliquer les modifications ?';
  TeeMsg_SelectedSeries     :='(S�ries S�lectionn�es)';
  TeeMsg_RefreshData        :='&Rafra�chir les donn�es';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='464';
  TeeMsg_FunctionAdd        :='Additionner';
  TeeMsg_FunctionSubtract   :='Soustraire';
  TeeMsg_FunctionMultiply   :='Multiplier';
  TeeMsg_FunctionDivide     :='Diviser';
  TeeMsg_FunctionHigh       :='Haut';
  TeeMsg_FunctionLow        :='Bas';
  TeeMsg_FunctionAverage    :='Moyenne';

  TeeMsg_GalleryShape       :='Forme';
  TeeMsg_GalleryBubble      :='Bulle';
  TeeMsg_FunctionNone       :='Copier';

  TeeMsg_None               :='(aucun)';

  TeeMsg_PrivateDeclarations:='{ D�clarations Priv�es }';
  TeeMsg_PublicDeclarations :='{ D�clarations Publiques}';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='La taille du pointeur doit �tre sup�rieure � z�ro';
  TeeMsg_About              :='A pro&pos de l''Editeur Graphique...';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Enregistrement unique';
  TeeMsg_AskDataSource      :='&DataSource:';

  TeeMsg_Summary            :='R�sum�';

  TeeMsg_FunctionPeriod     :='La Fonction P�riode doit �tre >= 0';

  TeeMsg_TeeChartWizard     :='Assistant Editeur Graphique';

  TeeMsg_ClearImage         :='Efface&r';
  TeeMsg_BrowseImage        :='Pa&rcourir...';

  TeeMsg_WizardSureToClose  :='Etes-vous s�r de vouloir fermer l''Assistant Editeur Graphique ?';
  TeeMsg_FieldNotFound      :='Le champ %s n''existe pas';

  TeeMsg_DepthAxis          :='Axe de profondeur';
  TeeMsg_PieOther           :='Autre';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Camembert';
  TeeMsg_ValuesBar          :='Barre';
  TeeMsg_ValuesAngle        :='Angle';
  TeeMsg_ValuesGanttStart   :='D�but';
  TeeMsg_ValuesGanttEnd     :='Fin';
  TeeMsg_ValuesGanttNextTask:='Nouvelle t�che';
  TeeMsg_ValuesBubbleRadius :='Rayon';
  TeeMsg_ValuesArrowEndX    :='FinX';
  TeeMsg_ValuesArrowEndY    :='FinY';
  TeeMsg_Legend             :='L�gende';
  TeeMsg_Title              :='Titre';
  TeeMsg_Foot               :='Pied';
  TeeMsg_Period		    :='P�riode';
  TeeMsg_PeriodRange        :='Plage de P�riode';
  TeeMsg_CalcPeriod         :='Calculer %s � chaque:';
  TeeMsg_SmallDotsPen       :='Pointill�s';

  TeeMsg_InvalidTeeFile     :='Graphique invalide dans le fichier *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Mauvais format de fichier *.'+TeeMsg_TeeExtension;
  TeeMsg_EmptyTeeFile       :='Fichier *.'+TeeMsg_TeeExtension+' vide';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Axes du Graphique';
  TeeMsg_ChartAxesCategoryDesc   :='Propri�t�s et �v�nements des Axes du Graphique';
  TeeMsg_ChartWallsCategoryName  :='Parois du Graphique';
  TeeMsg_ChartWallsCategoryDesc  :='Propri�t�s et �v�nements des Parois du Graphique';
  TeeMsg_ChartTitlesCategoryName :='Titres du Graphique';
  TeeMsg_ChartTitlesCategoryDesc :='Propri�t�s et �v�nements des Titres du Graphique';
  TeeMsg_Chart3DCategoryName     :='Graphique 3D';
  TeeMsg_Chart3DCategoryDesc     :='Propri�t�s et �v�nements du Graphique 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Personnaliser';
  TeeMsg_Series                 :='S�ries';
  TeeMsg_SeriesList             :='S�ries...';

  TeeMsg_PageOfPages            :='Page %d de %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Premier';
  TeeMsg_Prior  :='Pr�c�dent';
  TeeMsg_Next   :='Suivant';
  TeeMsg_Last   :='Dernier';
  TeeMsg_Insert :='Ins�rer';
  TeeMsg_Delete :='Supprimer';
  TeeMsg_Edit   :='Editer';
  TeeMsg_Post   :='Valider';
  TeeMsg_Cancel :='Annuler';

  TeeMsg_All    :='(tous)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Texte';

  TeeMsg_AsBMP        :='comme &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='comme &Metafile';
  TeeMsg_EMFFilter    :='Metafiles Avanc�s(*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Les propri�t�s du panneau n''ont pas le format d''exportation';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Pas de bordure';
  TeeMsg_Dotted    :='Pointill�';
  TeeMsg_Colors    :='Couleurs';
  TeeMsg_Filled    :='Rempli';
  TeeMsg_Marks     :='Marques';
  TeeMsg_Stairs    :='Escaliers';
  TeeMsg_Points    :='Points';
  TeeMsg_Height    :='Hauteur';
  TeeMsg_Hollow    :='Creux';
  TeeMsg_Point2D   :='Point 2D';
  TeeMsg_Triangle  :='Triangle';
  TeeMsg_Star      :='Etoile';
  TeeMsg_Circle    :='Cercle';
  TeeMsg_DownTri   :='Tri. Invers�';
  TeeMsg_Cross     :='Croix';
  TeeMsg_Diamond   :='Diamant';
  TeeMsg_NoLines   :='Pas de Lignes';
  TeeMsg_Stack100  :='Empil�s 100%';
  TeeMsg_Pyramid   :='Pyramide';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='Pyramide Inv.';
  TeeMsg_Sides     :='C�t�s';
  TeeMsg_SideAll   :='Tous les c�t�s';
  TeeMsg_Patterns  :='Motifs';
  TeeMsg_Exploded  :='Explos�s';
  TeeMsg_Shadow    :='Ombre';
  TeeMsg_SemiPie   :='Demi-Camembert';
  TeeMsg_Rectangle :='Rectangle';
  TeeMsg_VertLine  :='Ligne Vert.';
  TeeMsg_HorizLine :='Ligne Horiz.';
  TeeMsg_Line      :='Ligne';
  TeeMsg_Cube      :='Cube';
  TeeMsg_DiagCross :='Crois� Diag.';

  TeeMsg_CanNotFindTempPath    :='Ne peut pas trouver le dossier Temp';
  TeeMsg_CanNotCreateTempChart :='Ne peut pas cr�er le fichier temporaire';
  TeeMsg_CanNotEmailChart      :='Ne peut pas envoyer le graphique par e-mail. Erreur Mapi: %d';

  TeeMsg_SeriesDelete :='S�rie effac�e: Valeur d''indice %d hors limite (0 � %d).';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polaire';
  TeeMsg_GalleryCandle      :='Chandelier';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Surface';
  TeeMsg_GalleryContour     :='Contour';
  TeeMsg_GalleryBezier      :='B�zier';
  TeeMsg_GalleryPoint3D     :='Point 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Couronne';
  TeeMsg_GalleryCursor      :='Curseur';
  TeeMsg_GalleryBar3D       :='Barre 3D';
  TeeMsg_GalleryBigCandle   :='Gros chandelier';
  TeeMsg_GalleryLinePoint   :='Ligne-Point';
  TeeMsg_GalleryHistogram   :='Histogramme';
  TeeMsg_GalleryWaterFall   :='Cascade';
  TeeMsg_GalleryWindRose    :='Rose des vents';
  TeeMsg_GalleryClock       :='Horloge';
  TeeMsg_GalleryColorGrid   :='Grille de couleur';
  TeeMsg_GalleryBoxPlot     :='Trac� en bo�te';
  TeeMsg_GalleryHorizBoxPlot:='Trac� en bo�te Horiz.';
  TeeMsg_GalleryBarJoin     :='Barre Jointe';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramide';
  TeeMsg_GalleryMap         :='Carte';

  TeeMsg_PolyDegreeRange    :='Le degr� polynomial doit �tre entre 1 et 20';
  TeeMsg_AnswerVectorIndex   :='L''index de la r�ponse du vecteur doit �tre entre 1 et %d';
  TeeMsg_FittingError        :='Ne peut pas r�aliser l''ajustement';
  TeeMsg_PeriodRange         :='La P�riode doit �tre >= 0';
  TeeMsg_ExpAverageWeight    :='Moyenne pond�r�e Exp doit �tre entre 0 et 1';
  TeeMsg_GalleryErrorBar     :='Erreur de barre';
  TeeMsg_GalleryError        :='Erreur';
  TeeMsg_GalleryHighLow      :='Haut-Bas';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum de diff�rence';
  TeeMsg_FunctionExpAverage  :='Moyenne Exp.';
  TeeMsg_FunctionMovingAverage:='Moyenne mobile';
  TeeMsg_FunctionExpMovAve   :='Moyenne mobile Exp.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Ajustement de la courbe';
  TeeMsg_FunctionTrend       :='Tendance';
  TeeMsg_FunctionExpTrend    :='Tendance Exp.';
  TeeMsg_FunctionLogTrend    :='Tendance Log.';
  TeeMsg_FunctionCumulative  :='Cumulatif';
  TeeMsg_FunctionStdDeviation:='D�viation Std.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Racine Signifie Carr�';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Compte';
  TeeMsg_LoadChart           :='Ouvrir graphique...';
  TeeMsg_SaveChart           :='Sauve graphique...';
  TeeMsg_TeeFiles            :='Fichiers graphiques';

  TeeMsg_GallerySamples      :='Autre';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='Ne peut pas trouver l''Editeur de S�ries: %s';


  TeeMsg_CannotLoadChartFromURL:='Code Erreur: %d lors du t�l�chargement du graphique � partir de l''URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Code Erreur: %d lors du t�l�chargement des donn�es de s�ries � partir de l''URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Date';
  TeeMsg_ValuesOpen          :='Ouvrir';
  TeeMsg_ValuesHigh          :='Haut';
  TeeMsg_ValuesLow           :='Bas';
  TeeMsg_ValuesClose         :='Fermer';
  TeeMsg_ValuesOffset        :='D�calage';
  TeeMsg_ValuesStdError      :='ErreurStd';

  TeeMsg_Grid3D              :='Grille 3D';

  TeeMsg_LowBezierPoints     :='Nombre des Points de B�zier doit �tre > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Editer';
  TeeCommanMsg_Print    :='Imprimer';
  TeeCommanMsg_Copy     :='Copier';
  TeeCommanMsg_Save     :='Sauve';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotation: %d� El�vation: %d�';
  TeeCommanMsg_Rotate   :='Tourner';

  TeeCommanMsg_Moving   :='D�calage Horiz.: %d D�calage Vert.: %d';
  TeeCommanMsg_Move     :='D�placer';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Profondeur';

  TeeCommanMsg_Chart    :='le graphique';
  TeeCommanMsg_Panel    :='Panneau';

  TeeCommanMsg_RotateLabel:='D�placer avec la souris %s pour le tourner';
  TeeCommanMsg_MoveLabel  :='D�placer avec la souris %s pour le d�placer';
  TeeCommanMsg_ZoomLabel  :='D�placer avec la souris %s pour le zoomer';
  TeeCommanMsg_DepthLabel :='D�placer avec la souris %s pour changer sa taille 3D';

  TeeCommanMsg_NormalLabel:='Bouton gauche de la souris pour zoomer, bouton droit pour d�filer';
  TeeCommanMsg_NormalPieLabel:='D�placer avec la souris une tranche du camembert pour l''exploser';

  TeeCommanMsg_PieExploding :='Tranche: %d Explos�: %d %%';

  TeeMsg_TriSurfaceLess:='Le nombre de points doit �tre >= 4';
  TeeMsg_TriSurfaceAllColinear:='Tous les points sont colin�aires';
  TeeMsg_TriSurfaceSimilar:='Les points sont similaires - impossible d''ex�cuter';
  TeeMsg_GalleryTriSurface:='Surf. Triangle';

  TeeMsg_AllSeries :='Toutes les S�ries';
  TeeMsg_Edit      :='Editer';

  TeeMsg_GalleryFinancial    :='Financi�re';

  TeeMsg_CursorTool    :='R�ticule';
  TeeMsg_DragMarksTool :='Marques d�pla�ables';
  TeeMsg_AxisArrowTool :='Axes fl�ch�s';
  TeeMsg_DrawLineTool  :='D�placement de ligne';
  TeeMsg_NearestTool   :='Le point le plus pr�s';
  TeeMsg_ColorBandTool :='Bande de couleur';
  TeeMsg_ColorLineTool :='Ligne de couleur';
  TeeMsg_RotateTool    :='Tourner';
  TeeMsg_ImageTool     :='Image';
  TeeMsg_MarksTipTool  :='Marques dynamiques';

  TeeMsg_CantDeleteAncestor  :='Impossible d''effacer l''anc�tre';

  TeeMsg_Load	         :='Charger...';
  TeeMsg_NoSeriesSelected:='Pas de s�rie s�lectionn�e';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Graphique';
  TeeMsg_CategorySeriesActions :='S�ries du Graphique';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Commutateur 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Actif';
  TeeMsg_ActionSeriesActiveHint :='Afficher / Masquer les S�ries';
  TeeMsg_ActionEditHint         :='Editer Graphique';
  TeeMsg_ActionEdit             :='&Editer...';
  TeeMsg_ActionCopyHint         :='Copier vers bloc-notes';
  TeeMsg_ActionCopy             :='&Copier';
  TeeMsg_ActionPrintHint        :='Aper�u avant impression du graphique';
  TeeMsg_ActionPrint            :='&Imprimer...';
  TeeMsg_ActionAxesHint         :='Afficher / Masquer les Axes';
  TeeMsg_ActionAxes             :='&Axes';
  TeeMsg_ActionGridsHint        :='Afficher / Masquer les Grilles';
  TeeMsg_ActionGrids            :='&Grilles';
  TeeMsg_ActionLegendHint       :='Afficher / Masquer la L�gende';
  TeeMsg_ActionLegend           :='&L�gende';
  TeeMsg_ActionSeriesEditHint   :='Editer les S�ries';
  TeeMsg_ActionSeriesMarksHint  :='Afficher / Masquer les marques des S�ries';
  TeeMsg_ActionSeriesMarks      :='&Marques';
  TeeMsg_ActionSaveHint         :='Sauve le Graphique';
  TeeMsg_ActionSave             :='&Sauve...';

  TeeMsg_CandleBar              :='Barre';
  TeeMsg_CandleNoOpen           :='Pas d''ouverture';
  TeeMsg_CandleNoClose          :='Pas de cl�ture';
  TeeMsg_NoLines                :='Pas de Lignes';
  TeeMsg_NoHigh                 :='Pas de haut';
  TeeMsg_NoLow                  :='Pas de bas';
  TeeMsg_ColorRange             :='Plage de couleur';
  TeeMsg_WireFrame              :='Squelette';
  TeeMsg_DotFrame               :='Cadre en pointill�s';
  TeeMsg_Positions              :='Positions';
  TeeMsg_NoGrid                 :='Pas de grille';
  TeeMsg_NoPoint                :='Pas de points';
  TeeMsg_NoLine                 :='Pas de ligne';
  TeeMsg_Labels                 :='Etiquettes';
  TeeMsg_NoCircle               :='Pas de cercle';
  TeeMsg_Lines                  :='Lignes';
  TeeMsg_Border                 :='Bordure';

  TeeMsg_SmithResistance      :='R�sistance';
  TeeMsg_SmithReactance       :='R�actance';
  
  TeeMsg_Column               :='Colonne';

  { 5.02 }
  TeeMsg_Origin               := 'Origine';
  TeeMsg_Transparency         := 'Transparent';
  //TeeMsg_InvertedScroll       := 'D�filement invers�';
  TeeMsg_Box		      := 'Bo�te';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'No. de page';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='comme &JPEG';
  TeeMsg_JPEGFilter    :='Fichiers JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='comme &GIF';
  TeeMsg_GIFFilter     :='comme GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='comme &PNG';
  TeeMsg_PNGFilter     :='Fichiers PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='comme PC&X';
  TeeMsg_PCXFilter     :='Fichiers PCX (*.pcx)|*.pcx';

  { 5.01 }
  TeeMsg_Separator            :='S�parateur';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Chemin�e';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Exc�de le quota';
  TeeMsg_FunnelWithin         :=' Respecte le quota';
  TeeMsg_FunnelBelow          :=' ou en dessous du quota';
  TeeMsg_CalendarSeries       :='Calendrier';
  TeeMsg_DeltaPointSeries     :='DeltaPoint';
  TeeMsg_ImagePointSeries     :='ImagePoint';
  TeeMsg_ImageBarSeries       :='ImageBarre';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Le champ index doit �tre plus grand que zero.';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='como &JPEG';
  TeeMsg_JPEGFilter    :='Archivos JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='como &GIF';
  TeeMsg_GIFFilter     :='Archivos GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='como &PNG';
  TeeMsg_PNGFilter     :='Archivos PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='como PC&X';
  TeeMsg_PCXFilter     :='Archivos PCX (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='como &VML (HTM)';
  TeeMsg_VMLFilter     :='Archivos VML (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_Origin               := 'Origin';
  TeeMsg_Transparency         := 'Transparency';
  TeeMsg_Box		      := 'Box';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'N�m Page';
  TeeMsg_TextFile             := 'Fichiers Texte';

  { 5.03 }
  TeeMsg_Gradient             :='Gradient';
  TeeMsg_WantToSave           :='Save %s?';

  TeeMsg_Property            :='Property';
  TeeMsg_Value               :='Valeur';
  TeeMsg_Yes                 :='Oui';
  TeeMsg_No                  :='Non';
  TeeMsg_Image              :='(image)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'ActiveX Version ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Impossible d''importer le TeeChart � partir de %s';
  TeeMsg_ActiveXVerbPrint    := '&Aper�u...';
  TeeMsg_ActiveXVerbExport   := 'E&xporter...';
  TeeMsg_ActiveXVerbImport   := '&Importer...';
  TeeMsg_ActiveXVerbHelp     := '&Aide...';
  TeeMsg_ActiveXVerbAbout    := '&A propos du TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Code erreur: %d t�l�chargeant: %s';
  TeeMsg_DatasourceError     := 'TeeChart DataSource n''est pas une S�rie ou un Enregistrement';
  TeeMsg_SeriesTextSrcError  := 'Type de S�rie pas valide';
  TeeMsg_AxisTextSrcError    := 'Type d''axe pas valide';
  TeeMsg_DelSeriesDatasource := 'Etes-vous s�r de vouloir supprimer %s ?';
  TeeMsg_OCXNoPrinter        := 'Aucune imprimante install�e.';
  TeeMsg_ActiveXPictureNotValid:='Figure pas valide';
  {$ENDIF}
end;

Procedure TeeCreateFrench;
begin
  if not Assigned(TeeFrenchLanguage) then
  begin
    TeeFrenchLanguage:=TStringList.Create;
    TeeFrenchLanguage.Text:=

'GRADIENT EDITOR=Editeur de d�grad�'#13+
'GRADIENT=D�grad�'#13+
'DIRECTION=Direction'#13+
'VISIBLE=Visible'#13+
'TOP BOTTOM=Haut-Bas'#13+
'BOTTOM TOP=Bas-Haut'#13+
'LEFT RIGHT=Gauche-Droit'#13+
'RIGHT LEFT=Droit-Gauche'#13+
'FROM CENTER=Depuis le centre'#13+
'FROM TOP LEFT=Depuis Haut Gauche'#13+
'FROM BOTTOM LEFT=Depuis Bas Gauche'#13+
'OK=Ok'#13+
'CANCEL=Annuler'#13+
'COLORS=Couleurs'#13+
'START=D�but'#13+
'MIDDLE=Milieu'#13+
'END=Fin'#13+
'SWAP=Inverser'#13+
'NO MIDDLE=Pas de milieu'#13+
'TEEFONT EDITOR=Editeur de police'#13+
'INTER-CHAR SPACING=Espacement entre caract�res'#13+
'FONT=Police'#13+
'SHADOW=Ombre'#13+
'HORIZ. SIZE=Taille Horiz.'#13+
'VERT. SIZE=Taille Vert.'#13+
'COLOR=Couleur'#13+
'OUTLINE=Contour'#13+
'OPTIONS=Options'#13+
'FORMAT=Format'#13+
'TEXT=Texte'#13+
'POSITION=Position'#13+
'LEFT=Gauche'#13+
'TOP=Haut'#13+
'AUTO=Auto'#13+
'CUSTOM=Personnalis�'#13+
'LEFT TOP=Gauche Haut'#13+
'LEFT BOTTOM=Gauche Bas'#13+
'RIGHT TOP=Droit Haut'#13+
'RIGHT BOTTOM=Droit Bas'#13+
'MULTIPLE AREAS=Aires Multiples'#13+
'NONE=Aucun'#13+
'STACKED=Empil�es'#13+
'STACKED 100%=Empil�es � 100%'#13+
'AREA=Aire'#13+
'PATTERN=Motif'#13+
'STAIRS=Escaliers'#13+
'SOLID=Pleine'#13+
'CLEAR=Vide'#13+
'HORIZONTAL=Horizontal'#13+
'VERTICAL=Vertical'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=I.Diagonale'#13+
'CROSS=Crois�e'#13+
'DIAG.CROSS=Diag.Crois�e'#13+
'AREA LINES=Aire des lignes'#13+
'BORDER=Bordure'#13+
'INVERTED=Invers�'#13+
'COLOR EACH=Chaque couleur'#13+
'ORIGIN=Origine'#13+
'USE ORIGIN=Utiliser l''Origine'#13+
'WIDTH=Largeur'#13+
'HEIGHT=Hauteur'#13+
'AXIS=Axes'#13+
'LENGTH=Longueur'#13+
'SCROLL=D�filement'#13+
'BOTH=Les deux'#13+
'AXIS INCREMENT=Incr�mentation des Axes'#13+
'INCREMENT=Incr�mentation'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Une milliseconde'#13+
'ONE SECOND=Une seconde'#13+
'FIVE SECONDS=Cinq secondes'#13+
'TEN SECONDS=Dix secondes'#13+
'FIFTEEN SECONDS=Quinze secondes'#13+
'THIRTY SECONDS=Trente secondes'#13+
'ONE MINUTE=Une minute'#13+
'FIVE MINUTES=Cinq minutes'#13+
'TEN MINUTES=Dix minutes'#13+
'FIFTEEN MINUTES=Quinze minutes'#13+
'THIRTY MINUTES=Trente minutes'#13+
'ONE HOUR=Une heure'#13+
'TWO HOURS=Deux heures'#13+
'SIX HOURS=Six heures'#13+
'TWELVE HOURS=Douze heures'#13+
'ONE DAY=Un jour'#13+
'TWO DAYS=Deux jours'#13+
'THREE DAYS=Trois jours'#13+
'ONE WEEK=Une semaine'#13+
'HALF MONTH=Quinze jours'#13+
'ONE MONTH=Un mois'#13+
'TWO MONTHS=Deux mois'#13+
'THREE MONTHS=Trois mois'#13+
'FOUR MONTHS=Quatre mois'#13+
'SIX MONTHS=Six mois'#13+
'ONE YEAR=Un an'#13+
'EXACT DATE TIME=Date et Heure Exactes'#13+
'AXIS MAXIMUM AND MINIMUM=Maximum et Minimum des Axes'#13+
'VALUE=Valeur'#13+
'TIME=Heure'#13+
'LEFT AXIS=Axe de gauche'#13+
'RIGHT AXIS=Axe de droite'#13+
'TOP AXIS=Axe du haut'#13+
'BOTTOM AXIS=Axe du bas'#13+
'% BAR WIDTH=% Largeur de la Barre'#13+
'STYLE=Style'#13+
'% BAR OFFSET=% D�calage de la Barre'#13+
'RECTANGLE=Rectangle'#13+
'PYRAMID=Pyramide'#13+
'INVERT. PYRAMID=Pyramide Invers�e'#13+
'CYLINDER=Cylindre'#13+
'ELLIPSE=Ellipse'#13+
'ARROW=Fl�che'#13+
'RECT. GRADIENT=Rect. Gradient'#13+
'CONE=C�ne'#13+
'DARK BAR 3D SIDES=Barre fonc�e 3D'#13+
'BAR SIDE MARGINS=Marges des Barres'#13+
'AUTO MARK POSITION=Position Auto des Marques'#13+
'JOIN=Accoler'#13+
'DATASET=Dataset'#13+
'APPLY=Appliquer'#13+
'SOURCE=Source'#13+
'MONOCHROME=Monochrome'#13+
'DEFAULT=Par d�faut'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=M�dian'#13+
'WHISKER=Favoris'#13+
'PATTERN COLOR EDITOR=Editeur de la couleur des motifs'#13+
'IMAGE=Image'#13+
'BACK DIAGONAL=Diagonale inverse'#13+
'DIAGONAL CROSS=Diagonales Crois�es'#13+
'FILL 80%=Plein � 80%'#13+
'FILL 60%=Plein � 60%'#13+
'FILL 40%=Plein � 40%'#13+
'FILL 20%=Plein � 20%'#13+
'FILL 10%=Plein � 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=Petite Verticale'#13+
'HORIZ. SMALL=Petite Horiz.'#13+
'DIAG. SMALL=Petite Diag.'#13+
'BACK DIAG. SMALL=Petite Diag. Inverse'#13+
'CROSS SMALL=Petite crois�e'#13+
'DIAG. CROSS SMALL=Petite Diag. Crois�e'#13+
'DAYS=Jours'#13+
'WEEKDAYS=Jours de la semaine'#13+
'TODAY=Aujourd''hui'#13+
'SUNDAY=Dimanche'#13+
'TRAILING=Suite'#13+
'MONTHS=Mois'#13+
'LINES=Lignes'#13+
'SHOW WEEKDAYS=Aff. Jours semaine'#13+
'UPPERCASE=Majuscules'#13+
'TRAILING DAYS=Jours suivants'#13+
'SHOW TODAY=Afficher Aujourd''hui'#13+
'SHOW MONTHS=Afficher les Mois'#13+
'CANDLE WIDTH=Largeur Chand.'#13+
'STICK=Chandeliers'#13+
'BAR=B�tonnets'#13+
'OPEN CLOSE=Ouverture Cl�ture'#13+
'UP CLOSE=Haut Cl�ture'#13+
'DOWN CLOSE=Bas ferm�'#13+
'SHOW OPEN=Afficher Ouverture'#13+
'SHOW CLOSE=Afficher Cl�ture'#13+
'DRAW 3D=Dess. 3D'#13+
'DARK 3D=3D Fonc�'#13+
'EDITING=Editing'#13+
'CHART=Graphique'#13+
'SERIES=S�ries'#13+
'DATA=Donn�es'#13+
'TOOLS=Outils'#13+
'EXPORT=Exporter'#13+
'PRINT=Imprimer'#13+
'GENERAL=G�n�ral'#13+
'TITLES=Titres'#13+
'LEGEND=L�gende'#13+
'PANEL=Panneau'#13+
'PAGING=Mise en page'#13+
'WALLS=Parois'#13+
'3D=3D'#13+
'ADD=Ajouter'#13+
'DELETE=Supprimer'#13+
'TITLE=Titre'#13+
'CLONE=Cl�ner'#13+
'CHANGE=Modifier'#13+
'HELP=Aide'#13+
'CLOSE=Fermer'#13+
'TEECHART PRINT PREVIEW=Aper�u avant l''impression'#13+
'PRINTER=Impriman.'#13+
'SETUP=Param�trage'#13+
'ORIENTATION=Orientation'#13+
'PORTRAIT=Portrait'#13+
'LANDSCAPE=Paysage'#13+
'MARGINS (%)=Marges (%)'#13+
'DETAIL=D�tail'#13+
'MORE=Plus'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=R�init. les Marges'#13+
'VIEW MARGINS=Voir les Marges'#13+
'PROPORTIONAL=Proportionnel'#13+
'CIRCLE=Cercle'#13+
'VERTICAL LINE=Ligne Verticale'#13+
'HORIZ. LINE=Ligne Horiz.'#13+
'TRIANGLE=Triangle'#13+
'INVERT. TRIANGLE=Triangle Invers�'#13+
'LINE=Ligne'#13+
'DIAMOND=Diamant'#13+
'CUBE=Cube'#13+
'STAR=Etoile'#13+
'TRANSPARENT=Transparent'#13+
'HORIZ. ALIGNMENT=Alignement Horiz.'#13+
'CENTER=Centr�'#13+
'RIGHT=Droit'#13+
'ROUND RECTANGLE=Rectangle Arrondi'#13+
'ALIGNMENT=Alignement'#13+
'BOTTOM=Bas'#13+
'UNITS=Unit�s'#13+
'PIXELS=Pixels'#13+
'AXIS ORIGIN=Origine des Axes'#13+
'ROTATION=Rotation'#13+
'CIRCLED=Encercl�'#13+
'3 DIMENSIONS=3 Dimensions'#13+
'RADIUS=Rayon'#13+
'ANGLE INCREMENT=Incr�m. angle'#13+
'RADIUS INCREMENT=Incr�m. rayon'#13+
'CLOSE CIRCLE=Cercle Ferm�'#13+
'PEN=Stylo'#13+
'LABELS=Etiquettes'#13+
'ROTATED=Tourn�'#13+
'CLOCKWISE=Sens aiguilles'#13+
'INSIDE=Int�rieur'#13+
'ROMAN=Romain'#13+
'HOURS=Heures'#13+
'MINUTES=Minutes'#13+
'SECONDS=Secondes'#13+
'START VALUE=Val.d�part'#13+
'END VALUE=Val.fin'#13+
'TRANSPARENCY=Transparence'#13+
'DRAW BEHIND=Dessiner derri�re'#13+
'COLOR MODE=Mode Couleur'#13+
'STEPS=Pas'#13+
'RANGE=Plage'#13+
'PALETTE=Palette'#13+
'PALE=P�le'#13+
'STRONG=Vive'#13+
'GRID SIZE=Taille de la grille'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Profond.'#13+
'IRREGULAR=Irr�gulier'#13+
'GRID=Grille'#13+
'ALLOW DRAG=Autoriser d�pl.'#13+
'VERTICAL POSITION=Position Verticale'#13+
'LEVELS POSITION=Position des Niveaux'#13+
'LEVELS=Niveaux'#13+
'NUMBER=Nombre'#13+
'LEVEL=Niveau'#13+
'AUTOMATIC=Automatique'#13+
'SNAP=Alig.pt.'#13+
'FOLLOW MOUSE=Suivre la souris'#13+
'STACK=Pile'#13+
'HEIGHT 3D=Hauteur 3D'#13+
'LINE MODE=Mode Ligne'#13+
'OVERLAP=Superposer'#13+
'STACK 100%=Empil�e � 100%'#13+
'CLICKABLE=Clicable'#13+
'AVAILABLE=Disponible'#13+
'SELECTED=Selectionn�'#13+
'DATASOURCE=Source de donn�es'#13+
'GROUP BY=Grouper par'#13+
'CALC=Calc'#13+
'OF=de'#13+
'SUM=Somme'#13+
'COUNT=Nombre'#13+
'AVG=Moyenne'#13+
'HOUR=Heure'#13+
'DAY=Jour'#13+
'WEEK=Semaine'#13+
'WEEKDAY=Jour de la semaine'#13+
'MONTH=Mois'#13+
'QUARTER=Trimestre'#13+
'YEAR=Ann�e'#13+
'HOLE %=Trou %'#13+
'RESET POSITIONS=R�init. positions'#13+
'MOUSE BUTTON=Bouton souris'#13+
'ENABLE DRAWING=Activer le dessin'#13+
'ENABLE SELECT=Activer la s�lection'#13+
'ENHANCED=Avanc�'#13+
'ERROR WIDTH=Largeur erreur'#13+
'WIDTH UNITS=Unit�s de largeur'#13+
'PERCENT=Pourcentage'#13+
'LEFT AND RIGHT=Gauche et Droit'#13+
'TOP AND BOTTOM=Haut et Bas'#13+
'BORDER EDITOR=Editeur de Bordure'#13+
'DASH=Tiret'#13+
'DOT=Point'#13+
'DASH DOT=TiretPoint'#13+
'DASH DOT DOT=Tiret Point Point'#13+
'CALCULATE EVERY=Calculer � chaque'#13+
'ALL POINTS=Tous les points'#13+
'NUMBER OF POINTS=Nombre de points'#13+
'RANGE OF VALUES=Plage de valeurs'#13+
'FIRST=Premier'#13+
'LAST=Dernier'#13+
'TEEPREVIEW EDITOR=Editeur de pr�visualisation'#13+
'ALLOW MOVE=Autoriser D�pl.'#13+
'ALLOW RESIZE=Autoriser Redim.'#13+
'DRAG IMAGE=D�placer Image'#13+
'AS BITMAP=comme Bitmap'#13+
'SHOW IMAGE=Afficher Image'#13+
'MARGINS=Marges'#13+
'SIZE=Taille'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=El�vation'#13+
'100%=100%'#13+
'HORIZ. OFFSET=D�calage Horiz.'#13+
'VERT. OFFSET=D�calage Vert.'#13+
'PERSPECTIVE=Perspective'#13+
'ANGLE=Angle'#13+
'ORTHOGONAL=Orthogonal'#13+
'ZOOM TEXT=Zoom.Texte'#13+
'SCALES=Echelles'#13+
'TICKS=Principale'#13+
'MINOR=Secondaire'#13+
'MAXIMUM=Maximum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Incr�m. d�sir�e'#13+
'(INCREMENT)=(incr�mentation)'#13+
'LOG BASE=Base Log'#13+
'LOGARITHMIC=Logarithmique'#13+
'MIN. SEPARATION %=S�paration Min.%'#13+
'MULTI-LINE=Multi-ligne'#13+
'LABEL ON AXIS=Etiquette sur l''axe'#13+
'ROUND FIRST=Arrondir'#13+
'MARK=Marque'#13+
'LABELS FORMAT=Format des Etiquettes'#13+
'EXPONENTIAL=Exponentiel'#13+
'DEFAULT ALIGNMENT=Alignement par d�faut'#13+
'LEN=Long.'#13+
'INNER=Int�rieure'#13+
'AT LABELS ONLY=Sur Etiqu. seult.'#13+
'CENTERED=Centr�'#13+
'POSITION %=Position %'#13+
'START %=D�but %'#13+
'END %=Fin %'#13+
'OTHER SIDE=Autre c�t�'#13+
'AXES=Axes'#13+
'BEHIND=Derri�re'#13+
'CLIP POINTS=Hach� points'#13+
'PRINT PREVIEW=Impression'#13+
'MINIMUM PIXELS=Pixels Minimum'#13+
'ALLOW=Autoriser'#13+
'ANIMATED=Anim�'#13+
'ALLOW SCROLL=Autoriser d�filement'#13+
'TEEOPENGL EDITOR=Editeur OpenGL'#13+
'AMBIENT LIGHT=Lumi�re ambiante'#13+
'SHININESS=Lustre'#13+
'FONT 3D DEPTH=Profondeur Police 3D'#13+
'ACTIVE=Activ�'#13+
'FONT OUTLINES=Contours de la police'#13+
'SMOOTH SHADING=Ombre douce'#13+
'LIGHT=Lumi�re'#13+
'Y=Y'#13+
'INTENSITY=Intensit�'#13+
'BEVEL=Biseau'#13+
'FRAME=Cadre'#13+
'ROUND FRAME=Cadre arrondi'#13+
'LOWERED=Enfonc�'#13+
'RAISED=Relev�'#13+
'SYMBOLS=Symboles'#13+
'TEXT STYLE=Style Texte'#13+
'LEGEND STYLE=Style L�gende'#13+
'VERT. SPACING=Espac. Vert.'#13+
'SERIES NAMES=Nom des S�ries'#13+
'SERIES VALUES=Valeurs des S�ries'#13+
'LAST VALUES=Derni�res Valeurs'#13+
'PLAIN=Plein'#13+
'LEFT VALUE=Valeur de gauche'#13+
'RIGHT VALUE=Valeur de droite'#13+
'LEFT PERCENT=Pourcentage de gauche'#13+
'RIGHT PERCENT=Pourcentage de droite'#13+
'X VALUE=Valeur X'#13+
'X AND VALUE=X et Valeur'#13+
'X AND PERCENT=X et Pourcentage'#13+
'CHECK BOXES=Cases � cocher'#13+
'DIVIDING LINES=Lignes de Division'#13+
'FONT SERIES COLOR=Couleur Police s�ries'#13+
'POSITION OFFSET %=D�calage Position %'#13+
'MARGIN=Marge'#13+
'RESIZE CHART=Redim. Graphique'#13+
'CONTINUOUS=Continu'#13+
'POINTS PER PAGE=Points par Page'#13+
'SCALE LAST PAGE=Ech. dern. Page'#13+
'CURRENT PAGE LEGEND=L�gende page courante'#13+
'PANEL EDITOR=Editeur de panneau'#13+
'BACKGROUND=Fond'#13+
'BORDERS=Bordures'#13+
'BACK IMAGE=Image de fond'#13+
'STRETCH=Etir�e'#13+
'TILE=Mosa�que'#13+
'BEVEL INNER=Biseau interne'#13+
'BEVEL OUTER=Biseau externe'#13+
'MARKS=Marques'#13+
'DATA SOURCE=Source de donn�es'#13+
'SORT=Trier'#13+
'CURSOR=Curseur'#13+
'SHOW IN LEGEND=Placer dans L�gende'#13+
'FORMATS=Formats'#13+
'VALUES=Valeurs'#13+
'PERCENTS=Pourcent.'#13+
'HORIZONTAL AXIS=Axe Horizontal'#13+
'DATETIME=Date/Heure'#13+
'VERTICAL AXIS=Axe Vertical'#13+
'ASCENDING=Ascendant'#13+
'DESCENDING=Descendant'#13+
'DRAW EVERY=Dess.chaque'#13+
'CLIPPED=Hach�'#13+
'ARROWS=Fl�ches'#13+
'MULTI LINE=Lig.Multi'#13+
'ALL SERIES VISIBLE=Toutes S�r.Visibles'#13+
'LABEL=Etiquette'#13+
'LABEL AND PERCENT=Etiquette et Pourcentage'#13+
'LABEL AND VALUE=Etiquette et Valeur'#13+
'PERCENT TOTAL=Pourcentage Total'#13+
'LABEL & PERCENT TOTAL=Etiquette et Pourcentage Total'#13+
'X AND Y VALUES=Valeurs X et Y'#13+
'MANUAL=Manuel'#13+
'RANDOM=Al�atoire'#13+
'FUNCTION=Fonction'#13+
'NEW=Nouveau'#13+
'EDIT=Editer'#13+
'PERSISTENT=Persistant'#13+
'ADJUST FRAME=Cadre ajust�'#13+
'SUBTITLE=Sous-titre'#13+
'SUBFOOT=Sous-pied'#13+
'FOOT=Pied'#13+
'VISIBLE WALLS=Parois Visibles'#13+
'BACK=Derri�re'#13+
'DIF. LIMIT=Limite Dif.'#13+
'ABOVE=Au-dessus'#13+
'WITHIN=Dedans'#13+
'BELOW=Au-dessous'#13+
'CONNECTING LINES=Lignes de connexion'#13+
'HIGH=Haut'#13+
'LOW=Bas'#13+
'BROWSE=Parcourir'#13+
'TILED=en mosa�que'#13+
'INFLATE MARGINS=Marges �largies'#13+
'SQUARE=Carr�'#13+
'DOWN TRIANGLE=Triangulaire Invers�'#13+
'SMALL DOT=Petit Point'#13+
'GLOBAL=Global'#13+
'SHAPES=Formes'#13+
'BRUSH=Pinceau'#13+
'DELAY=Retard'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Action de la souris'#13+
'MOVE=D�plac.'#13+
'CLICK=Clic'#13+
'DRAW LINE=Dessiner Ligne'#13+
'EXPLODE BIGGEST=Exploser le plus gros'#13+
'TOTAL ANGLE=Angle Total'#13+
'GROUP SLICES=Grouper les tranches'#13+
'BELOW %=Au-dessous %'#13+
'BELOW VALUE=En dessous de valeur'#13+
'OTHER=Autre'#13+
'PATTERNS=Motifs'#13+
'SIZE %=Taille %'#13+
'SERIES DATASOURCE TEXT EDITOR=Editeur des Sources de donn�es des S�ries'#13+
'FIELDS=Champs'#13+
'NUMBER OF HEADER LINES=Nombre de lignes d''en-t�te'#13+
'SEPARATOR=S�parateur'#13+
'COMMA=Virgule'#13+
'SPACE=Espace'#13+
'TAB=Tabulation'#13+
'FILE=Fichier'#13+
'WEB URL=Web URL'#13+
'LOAD=Charger'#13+
'C LABELS=C Etiquettes'#13+
'R LABELS=R Etiquettes'#13+
'C PEN=C Stylo'#13+
'R PEN=R Stylo'#13+
'STACK GROUP=Groupe d''empilement'#13+
'MULTIPLE BAR=Barre Multiple'#13+
'SIDE=C�te � c�te'#13+
'SIDE ALL=Toutes c�te � c�te'#13+
'DRAWING MODE=Mode de dessin'#13+
'WIREFRAME=Squelette'#13+
'DOTFRAME=Cadre en pointill�s'#13+
'SMOOTH PALETTE=Palette lisse'#13+
'SIDE BRUSH=Pinceau adjoint'#13+
'ABOUT TEECHART PRO V7.0=A propos TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Tous droits reserv�s.'#13+
'VISIT OUR WEB SITE !=Visitez notre site Web !'#13+
'TEECHART WIZARD=Assistant Graphique'#13+
'SELECT A CHART STYLE=S�lectionner un style de graphique'#13+
'DATABASE CHART=Graphique base de donn�es'#13+
'NON DATABASE CHART=Graphique Non base de donn�es'#13+
'SELECT A DATABASE TABLE=S�lectionner un tableau de base de donn�es'#13+
'ALIAS=Alias'#13+
'TABLE=Table'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=S�lectionner les champs d�sir�s pour le graphique'#13+
'SELECT A TEXT LABELS FIELD=S�lectioner un champ pour les textes d''�tiquettes'#13+
'CHOOSE THE DESIRED CHART TYPE=Choisissez le type de graphique d�sir�'#13+
'2D=2D'#13+
'CHART PREVIEW=Pr�visualisation du graphique'#13+
'SHOW LEGEND=Afficher la L�gende'#13+
'SHOW MARKS=Afficher les Marques'#13+
'< BACK=< Retour'#13+
'EXPORT CHART=Exportation du graphique'#13+
'PICTURE=Image'#13+
'NATIVE=Natif'#13+
'KEEP ASPECT RATIO=Conserver le ratio'#13+
'INCLUDE SERIES DATA=Inclure donn�es S�ries'#13+
'FILE SIZE=Taille Fichier'#13+
'DELIMITER=S�parateur'#13+
'XML=XML'#13+
'HTML TABLE=Tableau HTML'#13+
'EXCEL=Excel'#13+
'COLON=Colonne'#13+
'INCLUDE=Inclure'#13+
'POINT LABELS=Etiquettes de Points'#13+
'POINT INDEX=Index de Points'#13+
'HEADER=En-t�te'#13+
'COPY=Copier'#13+
'SAVE=Sauve'#13+
'SEND=Envoyer'#13+
'FUNCTIONS=Fonctions'#13+
'ADX=ADX'#13+
'AVERAGE=Moyenne'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Diviser'#13+
'EXP. AVERAGE=Moyenne Exp.'#13+
'EXP.MOV.AVRG.=MOyenne Mobile Exp.'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Moyenne Mobile'#13+
'MULTIPLY=Multiplier'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Racine carr�e.S.I.'#13+
'STD.DEVIATION=D�viation Standard'#13+
'STOCHASTIC=Stochastic'#13+
'SUBTRACT=Soustraire'#13+
'SOURCE SERIES=S�ries sources'#13+
'TEECHART GALLERY=Galerie'#13+
'DITHER=Correction'#13+
'REDUCTION=R�duction'#13+
'COMPRESSION=Compression'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Le plus pr�s'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Gris Windows'#13+
'GRAY SCALE=Echelle de gris'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Qualit�'#13+
'PERFORMANCE=Performance'#13+
'QUALITY=Qualit�'#13+
'SPEED=Vitesse'#13+
'COMPRESSION LEVEL=Niveau de compression'#13+
'CHART TOOLS GALLERY=Galerie des outils graphiques'#13+
'ANNOTATION=Annotation'#13+
'AXIS ARROWS=Axes fl�ch�s'#13+
'COLOR BAND=Bande de couleur'#13+
'COLOR LINE=Ligne de couleur'#13+
'DRAG MARKS=D�placer des �tiquettes'#13+
'MARK TIPS=Etquettes'#13+
'NEAREST POINT=Le point le plus pr�s'#13+
'ROTATE=Tourner'#13+
'YES=Oui'#13+
'NO=Non'#13

{$IFDEF TEEOCX}
+
{ADO Editor}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- Choix d''une source ADO'#13+
'CONNECTION=Connexion'#13+
'DATASET=Dataset'#13+
'TABLE=Tableau'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=Tableaux Syst�me'#13+
'LOGIN PROMPT=Login prompt'#13+
'SELECT=Choisir'#13+
{Import dialogue}
'TEECHART IMPORT=TeeChart Importation'#13+
'IMPORT CHART FROM=Importer le graphique depuis'#13+
'IMPORT NOW=Importer'#13+
{Property page}
'EDIT CHART=Editer le graphique'#13
{$ENDIF}
;
  end;
  TeeLanguage:=TeeFrenchLanguage;
  TeeFrenchConstants;
end;

Procedure TeeSetFrench;
begin
  TeeCreateFrench;
  TeeLanguage:=TeeFrenchLanguage;
  TeeFrenchConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeFrenchLanguage);
end.
