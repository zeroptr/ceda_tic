unit TeeSwedish;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeSwedishLanguage:TStringList=nil;

Procedure TeeSetSwedish;
Procedure TeeCreateSwedish;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeSwedishConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='(c) 1995-2009 David Berneda';
  TeeMsg_LegendFirstValue   :='F�rsta F�rklarande V�rdet m�ste vara > 0';
  TeeMsg_LegendColorWidth   :='F�rklaringens F�rgbredd m�ste vara > 0%';
  TeeMsg_SeriesSetDataSource:='Inget �verordnat Diagram f�r att validera Datak�lla';
  TeeMsg_SeriesInvDataSource:='Ingen giltig Datak�lla: %s';
  TeeMsg_FillSample         :='Det numeriska Utfyllningsv�rdet m�ste vara > 0';
  TeeMsg_AxisLogDateTime    :='DatumTid Axeln kan inte vara Logaritmisk ';
  TeeMsg_AxisLogNotPositive :='Min och Max v�rde f�r Logaritmisk Axel m�ste vara >= 0';
  TeeMsg_AxisLabelSep       :='Etiketternas Separation % m�ste vara > 0';
  TeeMsg_AxisIncrementNeg   :='Axelns �kning m�ste vara >= 0';
  TeeMsg_AxisMinMax         :='Axelns Minimum V�rde m�ste vara <= Maximum';
  TeeMsg_AxisMaxMin         :='Axelns Maximum V�rde b�r vara >= Minimum';
  TeeMsg_AxisLogBase        :='Axelns Logaritmiska Bas b�r vara >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPunkterPerSida m�ste vara >= 0';
  TeeMsg_3dPercent          :='3D effekt i procent m�ste vara mellan %d och %d';
  TeeMsg_CircularSeries     :='Sammanh�ngande Cirkel Serier �r inte till�tet';
  TeeMsg_WarningHiColor     :='16k F�rger eller b�ttre f�r b�ttre resultat';

  TeeMsg_DefaultPercentOf   :='%s av %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'av %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Axel Titel';
  TeeMsg_AxisLabels         :='Axel Etiketter';
  TeeMsg_RefreshInterval    :='Uppdaterings Intervall m�ste vara mellan 0 och 60';
  TeeMsg_SeriesParentNoSelf :='Serie �verordnat Diagram �r inte jag sj�lv!';
  TeeMsg_GalleryLine        :='Linje';
  TeeMsg_GalleryPoint       :='Punkt';
  TeeMsg_GalleryArea        :='Yta';
  TeeMsg_GalleryBar         :='Stapel';
  TeeMsg_GalleryHorizBar    :='Liggande';
  TeeMsg_Stack              :='Stapel';
  TeeMsg_GalleryPie         :='Paj';
  TeeMsg_GalleryCircled     :='Cirkel';
  TeeMsg_GalleryFastLine    :='Snabb Linje';
  TeeMsg_GalleryHorizLine   :='Horis. Linje';

  TeeMsg_PieSample1         :='Bilar';
  TeeMsg_PieSample2         :='Telefoner';
  TeeMsg_PieSample3         :='Bord';
  TeeMsg_PieSample4         :='Sk�rmar';
  TeeMsg_PieSample5         :='Lampor';
  TeeMsg_PieSample6         :='Tangentbord';
  TeeMsg_PieSample7         :='Cyklar';
  TeeMsg_PieSample8         :='Stolar';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='�ndrar %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Ut�kad';
  TeeMsg_GalleryFunctions   :='Funktioner';

  TeeMsg_EditChart          :='�n&dra Diagram...';
  TeeMsg_PrintPreview       :='&F�rhandsgranska...';
  TeeMsg_ExportChart        :='E&xportera Diagram...';
  TeeMsg_CustomAxes         :='Egen Axel...';

  TeeMsg_InvalidEditorClass :='%s: Ogiltig Redigerings Klass: %s';
  TeeMsg_MissingEditorClass :='%s: har ingen Redigerings Dialog';

  TeeMsg_GalleryArrow       :='Pil';

  TeeMsg_ExpFinish          :='&Avsluta';
  TeeMsg_ExpNext            :='&N�sta >';

  TeeMsg_GalleryGantt       :='Staplad';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototyp';
  TeeMsg_GanttSample3       :='Utveckling';
  TeeMsg_GanttSample4       :='F�rs�ljning';
  TeeMsg_GanttSample5       :='Marknadsf�ring';
  TeeMsg_GanttSample6       :='Prov';
  TeeMsg_GanttSample7       :='Tillv.';
  TeeMsg_GanttSample8       :='R�ttning';
  TeeMsg_GanttSample9       :='Ny Version';
  TeeMsg_GanttSample10      :='Bankv�sen';

  TeeMsg_ChangeSeriesTitle  :='�ndra Serie Titel';
  TeeMsg_NewSeriesTitle     :='Ny Serie Titel:';
  TeeMsg_DateTime           :='DatumTid';
  TeeMsg_TopAxis            :='�vre Axel';
  TeeMsg_BottomAxis         :='Nedre Axel';
  TeeMsg_LeftAxis           :='V�nster Axel';
  TeeMsg_RightAxis          :='H�ger Axel';

  TeeMsg_SureToDelete       :='Radera %s ?';
  TeeMsg_DateTimeFormat     :='DatumTid For&mat:';
  TeeMsg_Default            :='Standard';
  TeeMsg_ValuesFormat       :='V�rde For&mat:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='�nskad %s �kning';

  TeeMsg_IncorrectMaxMinValue:='Ogiltigt v�rde. Anledning: %s';
  TeeMsg_EnterDateTime      :='Skriv [Antal Dagar] [tt:mm:ss]';

  TeeMsg_SureToApply        :='Spara �ndringar ?';
  TeeMsg_SelectedSeries     :='(Vald Serie)';
  TeeMsg_RefreshData        :='Uppdate&ra Data';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_DefaultEditorSize  :='431';
  TeeMsg_FunctionAdd        :='Addera';
  TeeMsg_FunctionSubtract   :='Subtrahera';
  TeeMsg_FunctionMultiply   :='Multiplicera';
  TeeMsg_FunctionDivide     :='Dividera';
  TeeMsg_FunctionHigh       :='H�g';
  TeeMsg_FunctionLow        :='L�g';
  TeeMsg_FunctionAverage    :='Medel';

  TeeMsg_GalleryShape       :='Form';
  TeeMsg_GalleryBubble      :='Bubbla';
  TeeMsg_FunctionNone       :='Kopia';

  TeeMsg_None               :='(inget)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Punkt storlek m�ste vara >0';
  TeeMsg_About              :='&Om TeeChart...';

  tcAdditional              :='Ytterligare';
  tcDControls               :='Data Kontroller';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataupps�ttning';
  TeeMsg_AskDataSet         :='&Dataupps�ttning:';

  TeeMsg_SingleRecord       :='En Post';
  TeeMsg_AskDataSource      :='&Datak�lla:';

  TeeMsg_Summary            :='Sammandrag';

  TeeMsg_FunctionPeriod     :='FunktionsPeriod b�r vara >= 0';

  TeeMsg_TeeChartWizard     :='TeeChart Guide';
  TeeMsg_WizardTab          :='F�retag';

  TeeMsg_ClearImage         :='&Rensa';
  TeeMsg_BrowseImage        :='Bl�ddra...';

  TeeMsg_WizardSureToClose  :='�r du s�ker p� att du vill st�nga TeeChart Guiden ?';
  TeeMsg_FieldNotFound      :='F�lt %s existerar inte';

  TeeMsg_DepthAxis          :='Axel Djup';
  TeeMsg_PieOther           :='Andra';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Paj';
  TeeMsg_ValuesBar          :='Stapel';
  TeeMsg_ValuesAngle        :='Vinkel';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Slut';
  TeeMsg_ValuesGanttNextTask:='N�staUppgift';
  TeeMsg_ValuesBubbleRadius :='Radie';
  TeeMsg_ValuesArrowEndX    :='SlutX';
  TeeMsg_ValuesArrowEndY    :='SlutY';
  TeeMsg_Legend             :='F�rklaring';
  TeeMsg_Title              :='Titel';
  TeeMsg_Foot               :='Fot';
  TeeMsg_Period             :='Period';
  TeeMsg_PeriodRange        :='Period skala';
  TeeMsg_CalcPeriod         :='Ber�kna %s varje:';
  TeeMsg_SmallDotsPen       :='Sm� Punkter';

  TeeMsg_InvalidTeeFile     :='Ogiltigt Diagram i *.'+TeeMsg_TeeExtension+' fil';
  TeeMsg_WrongTeeFileFormat :='Fel *.'+TeeMsg_TeeExtension+' fil format';

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Diagram Axlar';
  TeeMsg_ChartAxesCategoryDesc   :='Diagram Axlar, egenskaper och h�ndelser ';
  TeeMsg_ChartWallsCategoryName  :='Diagram V�ggar';
  TeeMsg_ChartWallsCategoryDesc  :='Diagram V�ggar, egenskaper och h�ndelser ';
  TeeMsg_ChartTitlesCategoryName :='Diagram Titlar';
  TeeMsg_ChartTitlesCategoryDesc :='Diagram Titlar, egenskaper och h�ndelser';
  TeeMsg_Chart3DCategoryName     :='Diagram 3D';
  TeeMsg_Chart3DCategoryDesc     :='Diagram 3D, egenskaper och h�ndelser';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Egen ';
  TeeMsg_Series                 :='Serie';
  TeeMsg_SeriesList             :='Serier...';

  TeeMsg_PageOfPages            :='Sida %d av %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='F�rsta';
  TeeMsg_Prior  :='F�reg�ende';
  TeeMsg_Next   :='N�sta';
  TeeMsg_Last   :='Sista';
  TeeMsg_Insert :='Infoga';
  TeeMsg_Delete :='Radera';
  TeeMsg_Edit   :='�ndra';
  TeeMsg_Post   :='Spara';
  TeeMsg_Cancel :='Avbryt';

  TeeMsg_All    :='(allt)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='som &Bitmapp';
  TeeMsg_BMPFilter    :='Bitmapp (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='som &Metafil';
  TeeMsg_EMFFilter    :='Ut�kad Metafil (*.emf)|*.emf|Metafil (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Panel egenskap �r inte satt till Export format';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Ingen Ram';
  TeeMsg_Dotted    :='Prickad';
  TeeMsg_Colors    :='F�rger';
  TeeMsg_Filled    :='Fylld';
  TeeMsg_Marks     :='Markeringar';
  TeeMsg_Stairs    :='Trappor';
  TeeMsg_Points    :='Punkter';
  TeeMsg_Height    :='H�jd';
  TeeMsg_Hollow    :='Ih�lig';
  TeeMsg_Point2D   :='2D Punkt';
  TeeMsg_Triangle  :='Triangel';
  TeeMsg_Star      :='Stj�rna';
  TeeMsg_Circle    :='Cirkel';
  TeeMsg_DownTri   :='Ner Tri.';
  TeeMsg_Cross     :='Kors';
  TeeMsg_Diamond   :='Ruta';
  TeeMsg_NoLines   :='Inga Linjer';
  TeeMsg_Stack100  :='Stapla 100%';
  TeeMsg_Pyramid   :='Pyramid';
  TeeMsg_Ellipse   :='Ellips';
  TeeMsg_InvPyramid:='Omv�nd Pyramid';
  TeeMsg_Sides     :='Sidor';
  TeeMsg_SideAll   :='Sida Alla';
  TeeMsg_Patterns  :='M�nster';
  TeeMsg_Exploded  :='Uppdelad';
  TeeMsg_Shadow    :='Skugga';
  TeeMsg_SemiPie   :='Halv Bit';
  TeeMsg_Rectangle :='Rektangel';
  TeeMsg_VertLine  :='Lodr�t Linje';
  TeeMsg_HorizLine :='V�gr�t Linje';
  TeeMsg_Line      :='Linje';
  TeeMsg_Cube      :='Kub';
  TeeMsg_DiagCross :='Diag.Kors';

  TeeMsg_CanNotFindTempPath    :='Kan inte hitta Temp katalogen';
  TeeMsg_CanNotCreateTempChart :='Kan inte skapa Temp fil';
  TeeMsg_CanNotEmailChart      :='Kan inte e-posta TeeChart. Mapi Fel: %d';

  TeeMsg_SeriesDelete :='Radera Serie: IndexV�rde %d �r utanf�r gr�nsen (0 to %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Spr�k...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Pol�r';
  TeeMsg_GalleryCandle      :='Ljus';
  TeeMsg_GalleryVolume      :='Volym';
  TeeMsg_GallerySurface     :='Yta';
  TeeMsg_GalleryContour     :='Kontur';
  TeeMsg_GalleryBezier      :='Bezi�r';
  TeeMsg_GalleryPoint3D     :='3D Punkt';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Munk';
  TeeMsg_GalleryCursor      :='Mark�r';
  TeeMsg_GalleryBar3D       :='3D Stapel';
  TeeMsg_GalleryBigCandle   :='Stort Ljus';
  TeeMsg_GalleryLinePoint   :='Punktad Linje';
  TeeMsg_GalleryHistogram   :='Historik';
  TeeMsg_GalleryWaterFall   :='Vattenfall';
  TeeMsg_GalleryWindRose    :='Kompass';
  TeeMsg_GalleryClock       :='Klocka';
  TeeMsg_GalleryColorGrid   :='F�rgat Rutn�t';
  TeeMsg_GalleryBoxPlot     :='Box';
  TeeMsg_GalleryHorizBoxPlot:='Horis.Box';
  TeeMsg_GalleryBarJoin     :='F�renad Stapel';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramid';
  TeeMsg_GalleryMap         :='Karta';

  TeeMsg_PolyDegreeRange    :='Polynom grader m�ste vara mellan 1 och 20';
  TeeMsg_AnswerVectorIndex   :='Vektor index m�ste vara mellan 1 och %d';
  TeeMsg_FittingError        :='Kan inte utf�ra montering';
  TeeMsg_PeriodRange         :='Period m�ste vara >= 0';
  TeeMsg_ExpAverageWeight    :='F�rv�ntad Medel Vikt m�ste vara mellan 0 and 1';
  TeeMsg_GalleryErrorBar     :='Fel Stapel';
  TeeMsg_GalleryError        :='Fel';
  TeeMsg_GalleryHighLow      :='H�g-L�g';
  TeeMsg_FunctionMomentum    :='R�relsem�ngd';
  TeeMsg_FunctionMomentumDiv :='R�relsem�ngd Div';
  TeeMsg_FunctionExpAverage  :='F�rv. Medel';
  TeeMsg_FunctionMovingAverage:='R�r. Genomsnitt';
  TeeMsg_FunctionExpMovAve   :='F�rv. R�relseMedel';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Utg�mning';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='F�rv.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Ackumulerad';
  TeeMsg_FunctionStdDeviation:='Std.Avvikelse';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Effektivv�rde';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Slumpm�ssig'; //Stochastic
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Ber�kna';
  TeeMsg_LoadChart           :='�ppna TeeChart...';
  TeeMsg_SaveChart           :='Spara TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro filer';

  TeeMsg_GallerySamples      :='Exempel';
  TeeMsg_GalleryStats        :='Statistik';

  TeeMsg_CannotFindEditor    :='Kan inte hitta redigeringen f�r Serier: %s';


  TeeMsg_CannotLoadChartFromURL:='Fel kod: %d vid laddning av Diagram fr�n URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Fel kod: %d vid laddning av Data Serie fr�n URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Datum';
  TeeMsg_ValuesOpen          :='�ppen';
  TeeMsg_ValuesHigh          :='H�g';
  TeeMsg_ValuesLow           :='L�g';
  TeeMsg_ValuesClose         :='St�ng';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='Std.Fel';

  TeeMsg_Grid3D              :='Rutn�t 3D';

  TeeMsg_LowBezierPoints     :='Antal Bezi�r punkter b�r var > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='�ndra';
  TeeCommanMsg_Print    :='Skriv ut';
  TeeCommanMsg_Copy     :='Kopiera';
  TeeCommanMsg_Save     :='Spara';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotation: %d� H�jning: %d�';
  TeeCommanMsg_Rotate   :='Rotera';

  TeeCommanMsg_Moving   :='Horis.Offset: %d Vert.Offset: %d';
  TeeCommanMsg_Move     :='Flytta';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zooma';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Djup';

  TeeCommanMsg_Chart    :='Diagram';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Dra %s f�r att Rotera';
  TeeCommanMsg_MoveLabel  :='Dra %s f�r att Flytta';
  TeeCommanMsg_ZoomLabel  :='Dra %s f�r att Zooma';
  TeeCommanMsg_DepthLabel :='Dra %s f�r att storleks�ndra 3D';

  TeeCommanMsg_NormalLabel:='Dra V�nstra knappen f�r att Zooma, H�gra knappen f�r att Bl�ddra';
  TeeCommanMsg_NormalPieLabel:='Dra en Paj Bit f�r att dra ut den';

  TeeCommanMsg_PieExploding :='Paj Bit: %d Utdragen: %d %%';

  TeeMsg_TriSurfaceLess:='Antalet punkter m�ste vara >= 4';
  TeeMsg_TriSurfaceAllColinear:='Alla data punkter f�r samma linje';
  TeeMsg_TriSurfaceSimilar:='Liknande punkter - kan inte utf�ra';
  TeeMsg_GalleryTriSurface:='Triangel Yta';

  TeeMsg_AllSeries :='Alla Serier';
  TeeMsg_Edit      :='�ndra';

  TeeMsg_GalleryFinancial    :='Finansiell';

  TeeMsg_CursorTool    :='Mark�r';
  TeeMsg_DragMarksTool :='Dra M�rken';
  TeeMsg_AxisArrowTool :='Axel Pilar';
  TeeMsg_DrawLineTool  :='Rita Linje';
  TeeMsg_NearestTool   :='N�rmaste Punkt';
  TeeMsg_ColorBandTool :='F�rg Band';
  TeeMsg_ColorLineTool :='F�rg Linje';
  TeeMsg_RotateTool    :='Rotera';
  TeeMsg_ImageTool     :='Bild';
  TeeMsg_MarksTipTool  :='M�rkes Tips';

  TeeMsg_CantDeleteAncestor  :='Kan inte radera UpphovsInformation'; //ancestor

  TeeMsg_Load	         :='Laddar...';
  TeeMsg_NoSeriesSelected:='Ingen Serie vald';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Diagram';
  TeeMsg_CategorySeriesActions :='Diagram Serie';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='�ndra 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Aktiv';
  TeeMsg_ActionSeriesActiveHint :='Visa / D�lj Serie';
  TeeMsg_ActionEditHint         :='�ndra Diagram';
  TeeMsg_ActionEdit             :='&�ndra...';
  TeeMsg_ActionCopyHint         :='Kopiera till Urklipp';
  TeeMsg_ActionCopy             :='&Kopiera';
  TeeMsg_ActionPrintHint        :='F�rhandsgranska Diagram';
  TeeMsg_ActionPrint            :='&Skriv ut...';
  TeeMsg_ActionAxesHint         :='Visa / D�lj Axlar';
  TeeMsg_ActionAxes             :='&Axlar';
  TeeMsg_ActionGridsHint        :='Visa / D�lj Rutn�t';
  TeeMsg_ActionGrids            :='&Rutn�t';
  TeeMsg_ActionLegendHint       :='Visa / D�lj F�rklaring';
  TeeMsg_ActionLegend           :='&F�rklaring';
  TeeMsg_ActionSeriesEditHint   :='�ndra Serie';
  TeeMsg_ActionSeriesMarksHint  :='Visa / D�lj Serie M�rke';
  TeeMsg_ActionSeriesMarks      :='&M�rke';
  TeeMsg_ActionSaveHint         :='Spara Diagram';
  TeeMsg_ActionSave             :='&Spara...';

  TeeMsg_CandleBar              :='Stapel';
  TeeMsg_CandleNoOpen           :='�ppna Ej';
  TeeMsg_CandleNoClose          :='St�ng Ej';
  TeeMsg_NoLines                :='Ej Linjer';
  TeeMsg_NoHigh                 :='Ej H�g';
  TeeMsg_NoLow                  :='Ej L�g';
  TeeMsg_ColorRange             :='F�rg Omr�de';
  TeeMsg_WireFrame              :='Tr�d Ram';
  TeeMsg_DotFrame               :='Prick Ram';
  TeeMsg_Positions              :='Positioner';
  TeeMsg_NoGrid                 :='Inget Rutn�t';
  TeeMsg_NoPoint                :='Ingen Punkt';
  TeeMsg_NoLine                 :='Ingen Linje';
  TeeMsg_Labels                 :='Etiketter';
  TeeMsg_NoCircle               :='Ingen Cirkel';
  TeeMsg_Lines                  :='Linjer';
  TeeMsg_Border                 :='Kant';

  TeeMsg_SmithResistance      :='Motst�nd';
  TeeMsg_SmithReactance       :='Reaktans';

  TeeMsg_Column  :='Kolumn';

  { 5.02 }
  TeeMsg_Origin               :='Ursprung';
  TeeMsg_Transparency         :='Genomskinlig';
  TeeMsg_Box		      :='Box';
  TeeMsg_ExtrOut	      :='ExtrUt';
  TeeMsg_MildOut	      :='Mildut';
  TeeMsg_PageNumber	      :='Sidnummer';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='som &JPEG';
  TeeMsg_JPEGFilter    :='JPEG Filer (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='som &GIF';
  TeeMsg_GIFFilter     :='GIF Filer (*.gif)|*.gif';
  TeeMsg_AsPNG         :='som &PNG';
  TeeMsg_PNGFilter     :='PNG Filer (*.png)|*.png';
  TeeMsg_AsPCX         :='som PC&X';
  TeeMsg_PCXFilter     :='PCX Filer(*.pcx)|*.pcx';

  { 5.03 }
  TeeMsg_Property            :='Egenskap';
  TeeMsg_Value               :='V�rde';
  TeeMsg_Yes                 :='Ja';
  TeeMsg_No                  :='Nej';
  TeeMsg_Image              :='(bild)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Punkt';
  TeeMsg_OpportunityValues    := 'M�jlighetsV�rden';
  TeeMsg_QuoteValues          := 'OffertV�rden';

  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'ActiveX Version ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Kan in te importera TeeChart fr�n %s';
  TeeMsg_ActiveXVerbPrint    := '&F�rhandsgranskning...';
  TeeMsg_ActiveXVerbExport   := 'E&xport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Hj�lp...';
  TeeMsg_ActiveXVerbAbout    := '&Om TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Felkod: %d nedladdning: %s';
  TeeMsg_DatasourceError     := 'TeeChart DataK�lla �r ingen Serie eller tabelldata';
  TeeMsg_SeriesTextSrcError  := 'Ogiltig Serie Typ';
  TeeMsg_AxisTextSrcError    := 'Ogiltig Axel typ';
  TeeMsg_DelSeriesDatasource := '�r du s�ker p� att du vill radera %s ?';
  TeeMsg_OCXNoPrinter        := 'Ingen Standard skrivare �r installerad.';
  TeeMsg_ActiveXPictureNotValid:='Bilden �r ogiltig';
  {$ENDIF}
  
  // 6.0

  // TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='som &PDF';
  TeeMsg_PDFFilter        :='PDF filer (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='som PostScript';
  TeeMsg_PSFilter         :='PostScript filer (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horisontal'#13'Yta';
  TeeMsg_SelfStack        :='En Stapel';
  TeeMsg_DarkPen          :='M�rk Penna';
  TeeMsg_SelectFolder     :='V�lj Databas Katalog';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Anslutning:';

  // TeeProCo

  TeeMsg_FunctionSmooth       :='Utj�mnad';
  TeeMsg_FunctionCross        :='Sk�rpunkter';
  TeeMsg_GridTranspose        :='F�rflytta 3D Rutn�t';
  TeeMsg_FunctionCompress     :='Kompression';
  TeeMsg_ExtraLegendTool      :='Extra F�rklaring';
  TeeMsg_FunctionCLV          :='St�ng Plats'#13'V�rde';
  TeeMsg_FunctionOBV          :='I Balans'#13'Volym';
  TeeMsg_FunctionCCI          :='Handelsvara'#13'Kanal Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Animerad Serie';
  TeeMsg_GalleryPointFigure   :='Punkt & Siffra';
  TeeMsg_Up                   :='Upp';
  TeeMsg_Down                 :='Ner';
  TeeMsg_GanttTool            :='Dra Gantt';
  TeeMsg_XMLFile              :='XML file';
  TeeMsg_GridBandTool         :='Rutn�t band verktyg';

  TeeMsg_FunctionPerf         :='Prestanda';
  TeeMsg_GalleryGauge         :='M�ta';
  TeeMsg_GalleryGauges        :='M�tare';
  TeeMsg_ValuesVectorEndZ     :='SlutZ';
  TeeMsg_GalleryVector3D      :='Vektor 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Torn';
  TeeMsg_SingleColor          :='Enkel F�rg';
  TeeMsg_Cover                :='D�lja';
  TeeMsg_Cone                 :='Kon';
  TeeMsg_PieTool              :='T�rtbitar';
end;

Procedure TeeCreateSwedish;
begin
  if not Assigned(TeeSwedishLanguage) then
  begin
    TeeSwedishLanguage:=TStringList.Create;
    TeeSwedishLanguage.Text:=

'GRADIENT EDITOR=�ndra Toning'#13+
'GRADIENT=Toning'#13+
'DIRECTION=Riktning'#13+
'VISIBLE=Synlig'#13+
'TOP BOTTOM=Topp Botten'#13+
'BOTTOM TOP=Botten Topp'#13+
'LEFT RIGHT=V�nster H�ger'#13+
'RIGHT LEFT=H�ger V�nster'#13+
'FROM CENTER=Fr�n Center'#13+
'FROM TOP LEFT=Fr�n Topp V�nster'#13+
'FROM BOTTOM LEFT=Fr�n Botten V�nster'#13+
'OK=Ok'#13+
'CANCEL=Avbryt'#13+
'COLORS=F�rger'#13+
'START=Start'#13+
'MIDDLE=Mitten'#13+
'END=Slut'#13+
'SWAP=Byt'#13+
'NO MIDDLE=Ingen Mitt'#13+
'TEEFONT EDITOR=�ndra TeeTypsnitt'#13+
'INTER-CHAR SPACING=Inre mellanrum'#13+
'FONT=Typsnitt'#13+
'SHADOW=Skugga'#13+
'HORIZ. SIZE=Horis. Storlek'#13+
'VERT. SIZE=Vert. Storlek'#13+
'COLOR=F�rg'#13+
'OUTLINE=Kontur'#13+
'OPTIONS=Val'#13+
'FORMAT=Format'#13+
'TEXT=Text'#13+
'POSITION=Position'#13+
'LEFT=V�nster'#13+
'TOP=Topp'#13+
'AUTO=Auto'#13+
'CUSTOM=Egen'#13+
'LEFT TOP=V�nster Topp'#13+
'LEFT BOTTOM=V�nster Botten'#13+
'RIGHT TOP=H�ger Topp'#13+
'RIGHT BOTTOM=H�ger Botten'#13+
'MULTIPLE AREAS=Flera Ytor'#13+
'NONE=Ingen'#13+
'STACKED=Travad'#13+
'STACKED 100%=Travad 100%'#13+
'AREA=Yta'#13+
'PATTERN=M�nster'#13+
'STAIRS=Steg'#13+
'SOLID=Hel'#13+
'CLEAR=Rensa'#13+
'HORIZONTAL=Horisontell'#13+
'VERTICAL=Vertikal'#13+
'DIAGONAL=Diagonal'#13+
'B.DIAGONAL=B.Diagonal'#13+
'CROSS=Kryss'#13+
'DIAG.CROSS=Diag.Kryss'#13+
'AREA LINES=Yt Linjer'#13+
'BORDER=Kant'#13+
'INVERTED=Omv�nd'#13+
'INVERTED SCROLL=Omv�nd Bl�ddring'#13+
'COLOR EACH=F�rga Varje'#13+
'ORIGIN=Ursprung'#13+
'USE ORIGIN=Anv�nd Ursprung'#13+
'WIDTH=Bredd'#13+
'HEIGHT=H�jd'#13+
'AXIS=Axel'#13+
'LENGTH=L�ngd'#13+
'SCROLL=Bl�ddra'#13+
'BOTH=B�da'#13+
'AXIS INCREMENT=Axel �kning'#13+
'INCREMENT=�kning'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=En Millisekund'#13+
'ONE SECOND=En Sekund'#13+
'FIVE SECONDS=Fem Sekunder'#13+
'TEN SECONDS=Tio Sekunder'#13+
'FIFTEEN SECONDS=Femton Sekunder'#13+
'THIRTY SECONDS=Tretio Sekunder'#13+
'ONE MINUTE=En Minut'#13+
'FIVE MINUTES=Fem Minuter'#13+
'TEN MINUTES=Tio Minuter'#13+
'FIFTEEN MINUTES=Femton Minuter'#13+
'THIRTY MINUTES=Tretio Minuter'#13+
'ONE HOUR=En Timme'#13+
'TWO HOURS=Tv� Timmar'#13+
'SIX HOURS=Sex Timmar'#13+
'TWELVE HOURS=Tolv Timmar'#13+
'ONE DAY=En Dag'#13+
'TWO DAYS=Tv� Dagar'#13+
'THREE DAYS=Tre Dagar'#13+
'ONE WEEK=En Vecka'#13+
'HALF MONTH=Tv� Veckor'#13+
'ONE MONTH=En M�nad'#13+
'TWO MONTHS=Tv� M�nader'#13+
'THREE MONTHS=Tre M�nader'#13+
'FOUR MONTHS=Fyra M�nader'#13+
'SIX MONTHS=Sex M�nader'#13+
'ONE YEAR=Ett �r'#13+
'EXACT DATE TIME=Exakt Datum Tid'#13+
'AXIS MAXIMUM AND MINIMUM=Axelns Max och Min'#13+
'VALUE=V�rde'#13+
'TIME=Tid'#13+
'LEFT AXIS=V�nster Axel'#13+
'RIGHT AXIS=H�ger Axel'#13+
'TOP AXIS=�vre Axel'#13+
'BOTTOM AXIS=Nedre Axel'#13+
'% BAR WIDTH=% Stapel Bredd'#13+
'STYLE=Stil'#13+
'% BAR OFFSET=% Stapel Offset'#13+
'RECTANGLE=Rektangel'#13+
'PYRAMID=Pyramid'#13+
'INVERT. PYRAMID=Omv�nd Pyramid'#13+
'CYLINDER=Cylinder'#13+
'ELLIPSE=Ellips'#13+
'ARROW=Pil'#13+
'RECT. GRADIENT=Rekt. Lutning'#13+
'CONE=Kon'#13+
'DARK BAR 3D SIDES=M�rka Stapel sidor 3D'#13+
'BAR SIDE MARGINS=Anv�nd tapel Marginal'#13+
'AUTO MARK POSITION=Auto Mark. Position'#13+
'JOIN=F�rena'#13+
'DATASET=Dataupps�ttning'#13+
'APPLY=Genomf�r'#13+
'SOURCE=K�lla'#13+
'MONOCHROME=Monokrom'#13+
'DEFAULT=Standard'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Median'#13+
'WHISKER=Tunn'#13+
'PATTERN COLOR EDITOR=�ndra F�rgm�nster'#13+
'IMAGE=Bild'#13+
'BACK DIAGONAL=Bak Diagonal'#13+
'DIAGONAL CROSS=Diagonal Kryss'#13+
'FILL 80%=Fyll 80%'#13+
'FILL 60%=Fyll 60%'#13+
'FILL 40%=Fyll 40%'#13+
'FILL 20%=Fyll 20%'#13+
'FILL 10%=Fyll 10%'#13+
'ZIG ZAG=Sicksack'#13+
'VERTICAL SMALL=Vertikal liten'#13+
'HORIZ. SMALL=Horis. liten'#13+
'DIAG. SMALL=Diag. lite'#13+
'BACK DIAG. SMALL=Bak Diag. liten'#13+
'CROSS SMALL=Kryss liten'#13+
'DIAG. CROSS SMALL=Diag. kryss liten'#13+
'DAYS=Dagar'#13+
'WEEKDAYS=Veckodagar'#13+
'TODAY=I Dag'#13+
'SUNDAY=S�ndag'#13+
'TRAILING=F�ljande'#13+
'MONTHS=M�nader'#13+
'LINES=Linjer'#13+
'SHOW WEEKDAYS=Visa Veckodagar'#13+
'UPPERCASE=Versaler'#13+
'TRAILING DAYS=F�ljande dagar'#13+
'SHOW TODAY=Visa I Dag'#13+
'SHOW MONTHS=Visa M�nader'#13+
'CANDLE WIDTH=Ljus Bredd'#13+
'STICK=Sticka'#13+
'BAR=Stapel'#13+
'OPEN CLOSE=�ppna St�ng'#13+
'UP CLOSE=Upp St�ng'#13+
'DOWN CLOSE=Ner St�ng'#13+
'SHOW OPEN=Visa �ppna'#13+
'SHOW CLOSE=Visa St�ng'#13+
'DRAW 3D=Rita 3D'#13+
'DARK 3D=M�rk 3D'#13+
'EDITING=�ndrar'#13+
'CHART=Diagram'#13+
'SERIES=Serier'#13+
'DATA=Data'#13+
'TOOLS=Verktyg'#13+
'EXPORT=Exportera'#13+
'PRINT=Skriv Ut'#13+
'GENERAL=Allm�nt'#13+
'TITLES=Titel'#13+
'LEGEND=Beskrivning'#13+
'PANEL=Panel'#13+
'PAGING=Sidor'#13+
'WALLS=V�ggar'#13+
'3D=3D'#13+
'ADD=Addera'#13+
'DELETE=Radera'#13+
'TITLE=Titel'#13+
'CLONE=Kopiera'#13+
'CHANGE=�ndra'#13+
'HELP=Hj�lp'#13+
'CLOSE=St�ng'#13+
'TEECHART PRINT PREVIEW=TeeChart F�rhandsgranskning'#13+
'PRINTER=Skrivare'#13+
'SETUP=Inst�llning'#13+
'ORIENTATION=Orientering'#13+
'PORTRAIT=St�ende'#13+
'LANDSCAPE=Liggande'#13+
'MARGINS (%)=Marginal (%)'#13+
'DETAIL=Detalj'#13+
'MORE=Mer'#13+
'NORMAL=Normal'#13+
'RESET MARGINS=�terst�ll Marginal'#13+
'VIEW MARGINS=Se Marginal'#13+
'PROPORTIONAL=Proportionell'#13+
'CIRCLE=Cirkel'#13+
'VERTICAL LINE=Vertikal Linje'#13+
'HORIZ. LINE=Horis. Linje'#13+
'TRIANGLE=Triangel'#13+
'INVERT. TRIANGLE=Omv�nd Triangel'#13+
'LINE=Linjer'#13+
'DIAMOND=Diamant'#13+
'CUBE=Kub'#13+
'STAR=Star'#13+
'TRANSPARENT=Genomskinlig'#13+
'HORIZ. ALIGNMENT=Horis. Inriktning'#13+
'CENTER=Centrerad'#13+
'RIGHT=H�ger'#13+
'ROUND RECTANGLE=Rund Rektangel'#13+
'ALIGNMENT=Inriktning'#13+
'BOTTOM=Botten'#13+
'UNITS=Enheter'#13+
'PIXELS=Punkter'#13+
'AXIS ORIGIN=Axel Ursprung'#13+
'ROTATION=Rotation'#13+
'CIRCLED=Cirkul�r'#13+
'3 DIMENSIONS=3 D'#13+
'RADIUS=Radie'#13+
'ANGLE INCREMENT=Vinkel �kning'#13+
'RADIUS INCREMENT=Radie �kning'#13+
'CLOSE CIRCLE=St�ng Cirkel'#13+
'PEN=Penna'#13+
'LABELS=Etiketter'#13+
'ROTATED=Roterad'#13+
'CLOCKWISE=Medurs'#13+
'INSIDE=Insida'#13+
'ROMAN=Romersk'#13+
'HOURS=Timmar'#13+
'MINUTES=Minuter'#13+
'SECONDS=Sekunder'#13+
'START VALUE=Start v�rde'#13+
'END VALUE=End v�rde'#13+
'TRANSPARENCY=Genomskinlig'#13+
'DRAW BEHIND=Rita Bakom'#13+
'COLOR MODE=F�rg val'#13+
'STEPS=Steg'#13+
'RANGE=Omr�de'#13+
'PALETTE=Palett'#13+
'PALE=Svag'#13+
'STRONG=Stark'#13+
'GRID SIZE=Storlek p� Rutn�t'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Djup'#13+
'IRREGULAR=Oregelbunden'#13+
'GRID=Rutn�t'#13+
'ALLOW DRAG=Till�t Drag'#13+
'VERTICAL POSITION=Vertikal Position'#13+
'LEVELS POSITION=Niv� position'#13+
'LEVELS=Niv�er'#13+
'NUMBER=Nummer'#13+
'LEVEL=Niv�'#13+
'AUTOMATIC=Automatisk'#13+
'SNAP=H�ll ihop'#13+
'FOLLOW MOUSE=F�lj mus'#13+
'STACK=Stapla'#13+
'HEIGHT 3D=H�jd 3D'#13+
'LINE MODE=Linje Modeller'#13+
'OVERLAP=�verlappning'#13+
'STACK 100%=Stapel 100%'#13+
'CLICKABLE=Klickbar'#13+
'AVAILABLE=Tillg�ngliga'#13+
'SELECTED=Valda'#13+
'DATASOURCE=Datak�lla'#13+
'GROUP BY=Gruppera med'#13+
'CALC=Ber�kna'#13+
'OF=med'#13+
'SUM=Sum'#13+
'COUNT=Antal'#13+
'HIGH=H�g'#13+
'LOW=L�g'#13+
'AVG=Med.'#13+
'HOUR=Timme'#13+
'DAY=Dag'#13+
'WEEK=Vecka'#13+
'WEEKDAY=Veckodag'#13+
'MONTH=M�nad'#13+
'QUARTER=Kvartal'#13+
'YEAR=Year'#13+
'HOLE %=H�l %'#13+
'RESET POSITIONS=�terst�ll position'#13+
'MOUSE BUTTON=Mus Knapp'#13+
'ENABLE DRAWING=Till�t Ritning'#13+
'ENABLE SELECT=Till�t Val'#13+
'ENHANCED=Ut�kad'#13+
'ERROR WIDTH=Fel Bredd'#13+
'WIDTH UNITS=Bredd Enhet'#13+
'PERCENT=Procent'#13+
'LEFT AND RIGHT=V�nster och H�ger'#13+
'TOP AND BOTTOM=Topp och Botten'#13+
'BORDER EDITOR=�ndra Kant'#13+
'DASH=Streck'#13+
'DOT=Prick'#13+
'DASH DOT=Streck Prick'#13+
'DASH DOT DOT=Streck Prick Prick'#13+
'CALCULATE EVERY=Ber�kna varje'#13+
'ALL POINTS=Alla punkter'#13+
'NUMBER OF POINTS=Antal punkter'#13+
'RANGE OF VALUES=Omf�ng p� v�rden'#13+
'FIRST=F�rst'#13+
'LAST=Sist'#13+
'TEEPREVIEW EDITOR=�ndra TeeCharts F�rhandsgranskning'#13+
'ALLOW MOVE=Till�ta Flytta'#13+
'ALLOW RESIZE=Till�ta Storleks�ndra'#13+
'DRAG IMAGE=Dra Bild'#13+
'AS BITMAP=Som Bitmap'#13+
'SHOW IMAGE=Visa Bild'#13+
'MARGINS=Marginal'#13+
'SIZE=Storlek'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Tryck Ihop'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Horis. Offset'#13+
'VERT. OFFSET=Vert. Offset'#13+
'PERSPECTIVE=Perspektiv'#13+
'ANGLE=Vinkel'#13+
'ORTHOGONAL=Rektangul�r'#13+
'ZOOM TEXT=Zoom Text'#13+
'SCALES=Skala'#13+
'TICKS=Markering'#13+
'MINOR=Mindre'#13+
'MAXIMUM=Maximal'#13+
'MINIMUM=Minimal'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=�nskad �kning'#13+
'(INCREMENT)=(�kning)'#13+
'LOG BASE=Log. Bas'#13+
'LOGARITHMIC=Logaritmisk'#13+
'MIN. SEPARATION %=Min. Separation %'#13+
'MULTI-LINE=Flera Linjer'#13+
'LABEL ON AXIS=Etiketter p� Axeln'#13+
'ROUND FIRST=Avrunda F�rsta'#13+
'MARK=Markering'#13+
'LABELS FORMAT=Etiketts Format'#13+
'EXPONENTIAL=Exponentiell'#13+
'DEFAULT ALIGNMENT=Standard Inst�llning'#13+
'LEN=L�ngd'#13+
'INNER=Inre'#13+
'AT LABELS ONLY=Bara vid Etiketter'#13+
'CENTERED=Centrerad'#13+
'POSITION %=Position %'#13+
'START %=Start %'#13+
'END %=Slut %'#13+
'OTHER SIDE=Andra sidan'#13+
'AXES=Axlar'#13+
'BEHIND=Bakom'#13+
'CLIP POINTS=Klipp Punkter'#13+
'PRINT PREVIEW=F�rhandsgranska'#13+
'MINIMUM PIXELS=Min. punkter'#13+
'ALLOW=Till�t'#13+
'ANIMATED=Animerad'#13+
'ALLOW SCROLL=Till�t Bl�ddring'#13+
'TEEOPENGL EDITOR=�ndra TeeOpenGL'#13+
'AMBIENT LIGHT=Omgivande Ljus'#13+
'SHININESS=Blankhet'#13+
'FONT 3D DEPTH=Typsnitt 3D Djup'#13+
'ACTIVE=Aktiv'#13+
'FONT OUTLINES=Typsnitts Kontur'#13+
'SMOOTH SHADING=Mjuk Skuggning'#13+
'LIGHT=Ljus'#13+
'Y=Y'#13+
'INTENSITY=Intensitet'#13+
'BEVEL=Fas'#13+
'FRAME=Ram'#13+
'ROUND FRAME=Rund Ram'#13+
'LOWERED=Neds�nkt'#13+
'RAISED=Upph�jd'#13+
'SYMBOLS=Symboler'#13+
'TEXT STYLE=Text Stil'#13+
'LEGEND STYLE=Beskrivnings Stil'#13+
'VERT. SPACING=Vert. Mellanrum'#13+
'SERIES NAMES=Series Names'#13+
'SERIES VALUES=Series Values'#13+
'LAST VALUES=Last Values'#13+
'PLAIN=Enkel'#13+
'LEFT VALUE=V�nster V�rde'#13+
'RIGHT VALUE=H�ger V�rde'#13+
'LEFT PERCENT=V�nster Procent'#13+
'RIGHT PERCENT=H�ger Procent'#13+
'X VALUE=X V�rde'#13+
'X AND Y VALUES=X Y V�rde'#13+
'X AND VALUE=X och V�rde'#13+
'X AND PERCENT=X och Procent'#13+
'CHECK BOXES=Kontroll boxar'#13+
'DIVIDING LINES=Avgr�nsande Linjer'#13+
'FONT SERIES COLOR=F�rg p� Typsnitts Serier'#13+
'POSITION OFFSET %=Position Offset %'#13+
'MARGIN=Marginal'#13+
'RESIZE CHART=Storleks�ndra Diagram'#13+
'CONTINUOUS=Kontinuerlig'#13+
'POINTS PER PAGE=Punkter per Sida'#13+
'SCALE LAST PAGE=Skala Sista sidan'#13+
'CURRENT PAGE LEGEND=Aktuelll sid beskrivning'#13+
'PANEL EDITOR=Panel Redigerare'#13+
'BACKGROUND=Bakgrund'#13+
'BORDERS=Ramar'#13+
'BACK IMAGE=Bakgrundsbild'#13+
'STRETCH=Str�cka'#13+
'TILE=Utj�mnad'#13+
'BEVEL INNER=Fasad Innre'#13+
'BEVEL OUTER=Fasad Yttrer'#13+
'MARKS=M�rken'#13+
'DATA SOURCE=Data K�lla'#13+
'SORT=Sortering'#13+
'CURSOR=Mark�r'#13+
'SHOW IN LEGEND=Visa i Beskrivning'#13+
'FORMATS=Format'#13+
'VALUES=V�rden'#13+
'PERCENTS=Procent'#13+
'HORIZONTAL AXIS=Horisontell Axel'#13+
'DATETIME=DatumTid'#13+
'VERTICAL AXIS=Vertikal Axel'#13+
'ASCENDING=Stigande'#13+
'DESCENDING=Fallande'#13+
'DRAW EVERY=Rita varje'#13+
'CLIPPED=Nedklippt'#13+
'ARROWS=Pilar'#13

{$IFDEF LCL}
;  TeeSwedishLanguage.Text:=TeeSwedishLanguage.Text
{$ENDIF}

+
'MULTI LINE=Flera Linjer'#13+
'ALL SERIES VISIBLE=Alla Serier Synliga'#13+
'LABEL=Etikett'#13+
'LABEL AND PERCENT=Etikett Procent'#13+
'LABEL AND VALUE=Etikett V�rde'#13+
'PERCENT TOTAL=Total Procent'#13+
'LABEL AND PERCENT TOTAL=Etikett Total Procent'#13+
'MANUAL=Manuell'#13+
'RANDOM=Slumpvis'#13+
'FUNCTION=Funktion'#13+
'NEW=Ny'#13+
'EDIT=�ndra'#13+
'PERSISTENT=Konstant'#13+
'ADJUST FRAME=Justera Ram'#13+
'SUBTITLE=Undertitel'#13+
'SUBFOOT=Undre Sidfot'#13+
'FOOT=Sidfot'#13+
'VISIBLE WALLS=Synliga V�ggar'#13+
'BACK=Bak'#13+
'DIF. LIMIT=Begr�nsa Skillnad'#13+
'ABOVE=Ovanf�r'#13+
'WITHIN=Innanf�r'#13+
'BELOW=Under'#13+
'CONNECTING LINES=Sammanh�ngande Linjer'#13+
'BROWSE=S�k'#13+
'TILED=Utj�mnad'#13+
'INFLATE MARGINS=�ka Marginaler'#13+
'SQUARE=Fyrkant'#13+
'DOWN TRIANGLE=Ner Triangel'#13+
'SMALL DOT=Sm� Prickar'#13+
'GLOBAL=Global'#13+
'SHAPES=Format'#13+
'BRUSH=Pensel'#13+
'DELAY=F�rdr�j'#13+
'MSEC.=msek.'#13+
'MOUSE ACTION=Mus h�ndelse'#13+
'MOVE=Flytta'#13+
'CLICK=Klick'#13+
'DRAW LINE=Rita Linje'#13+
'EXPLODE BIGGEST=Exponera St�rsta'#13+
'TOTAL ANGLE=Vinkel Totalt'#13+
'GROUP SLICES=Grupp Bitar'#13+
'BELOW %=Under %'#13+
'BELOW VALUE=under V�rde'#13+
'OTHER=Andra'#13+
'PATTERNS=M�nster'#13+
'SIZE %=Storlek %'#13+
'SERIES DATASOURCE TEXT EDITOR=Seriernas Datak�lla Text Redigerare'#13+
'FIELDS=F�lt'#13+
'NUMBER OF HEADER LINES=Antal Rubriks Linjer'#13+
'SEPARATOR=Avgr�nsare'#13+
'COMMA=Komma'#13+
'SPACE=Mellanslag'#13+
'TAB=Tabb'#13+
'FILE=Fil'#13+
'WEB URL=Webb URL'#13+
'LOAD=Ladda'#13+
'C LABELS=C Etikett'#13+
'R LABELS=R Etikett'#13+
'C PEN=C Penna'#13+
'R PEN=R Penna'#13+
'STACK GROUP=Stapla Grupp'#13+
'MULTIPLE BAR=Flera Staplar'#13+
'SIDE=Sida'#13+
'SIDE ALL=Sida vid Sida'#13+
'DRAWING MODE=Ritnings L�ge'#13+
'WIREFRAME=Transp.Ram'#13+
'DOTFRAME=PrickRam'#13+
'SMOOTH PALETTE=Mjuk Palett'#13+
'SIDE BRUSH=Sid Pensel'#13+
'ABOUT TEECHART PRO V7.0=Om TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Samtliga R�ttigheter F�rbeh�lles.'#13+
'VISIT OUR WEB SITE !=Bes�k v�r hemsida !'#13+
'TEECHART WIZARD=TeeChart Guide'#13+
'SELECT A CHART STYLE=Anv�nd Databas?'#13+
'DATABASE CHART=Diagram med Databas'#13+
'NON DATABASE CHART=Diagram utan Databas'#13+
'SELECT A DATABASE TABLE=V�lj en Datatabell'#13+
'ALIAS=Alias'#13+
'TABLE=Tabell'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=V�lj �nskade f�lt f�r Diagramet'#13+
'SELECT A TEXT LABELS FIELD=V�lj ett Etikettsf�lt'#13+
'CHOOSE THE DESIRED CHART TYPE=V�lj �nskad Diagramtyp'#13+
'2D=2D'#13+
'CHART PREVIEW=Diagram F�rhandsvisning'#13+
'SHOW LEGEND=Visa Beskrivning'#13+
'SHOW MARKS=Visa M�rken'#13+
'< BACK=< Bak'#13+
'EXPORT CHART=Exportera Diagram'#13+
'PICTURE=Bild'#13+
'NATIVE=Ursprung'#13+
'KEEP ASPECT RATIO=Beh�ll proportioner'#13+
'INCLUDE SERIES DATA=Inkludera Data Serie'#13+
'FILE SIZE=Fil Storlek'#13+
'DELIMITER=Separator'#13+
'XML=XML'#13+
'HTML TABLE=HTML Tabell'#13+
'EXCEL=Excel'#13+
'COLON=Kolon'#13+
'INCLUDE=Inkludera'#13+
'POINT LABELS=Punkt Etiketter'#13+
'POINT INDEX=Punkt Index'#13+
'HEADER=Rubrik'#13+
'COPY=Kopiera'#13+
'SAVE=Spara'#13+
'SEND=S�nd'#13+
'FUNCTIONS=Funktioner'#13+
'ADX=ADX'#13+
'AVERAGE=Genomsnitt'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Dividera'#13+
'EXP. AVERAGE=F�rv. Medel'#13+
'EXP.MOV.AVRG.=F�rv. R�r. Medel'#13+
'MACD=MACD'#13+
'MOMENTUM=R�relsem�ngd'#13+
'MOMENTUM DIV=Del R�relsem�ngd'#13+
'MOVING AVRG.r�rligt Medel'#13+
'MULTIPLY=Multiplicera'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=Effektivv�rde'#13+
'STD.DEVIATION=Standardavvikelse'#13+
'STOCHASTIC=Stokastisk'#13+
'SUBTRACT=Subtrahera'#13+
'SOURCE SERIES=K�ll Serie'#13+
'TEECHART GALLERY=TeeChart Galleri'#13+
'DITHER=Tveka'#13+
'REDUCTION=Reducering'#13+
'COMPRESSION=Kompression'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=N�rmast'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=F�nster 20'#13+
'WINDOWS 256=F�nster 256'#13+
'WINDOWS GRAY=F�nster Gray'#13+
'GRAY SCALE=Gr�skala'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Kvantisera'#13+
'QUANTIZE 256=Kvantisera 256'#13+
'% QUALITY=% Kvalitet'#13+
'PERFORMANCE=Utf�rande'#13+
'QUALITY=Kvalitet'#13+
'SPEED=Snabbhet'#13+
'COMPRESSION LEVEL=Komressionsniv�'#13+
'CHART TOOLS GALLERY=Galleri f�r Diagram Verktyg'#13+
'ANNOTATION=Anteckning'#13+
'AXIS ARROWS=Axel Pilar'#13+
'COLOR BAND=Bild'#13+
'COLOR LINE=F�rg Linje'#13+
'DRAG MARKS=Dra M�rken'#13+
'MARK TIPS=N�rmaste Punkt'#13+
'NEAREST POINT=N�rmaste Punkt'#13+
'ROTATE=Rotera'#13+

// 6.0

'BEVEL SIZE=Kant storlek'#13+
'DELETE ROW=Radera rad'#13+
'VOLUME SERIES=Volym serier'#13+
'SINGLE=Enstaka'#13+
'REMOVE CUSTOM COLORS=Radera valfria f�rger'#13+
'USE PALETTE MINIMUM=Anv�nd minimal palett'#13+
'AXIS MAXIMUM=Axel max'#13+
'AXIS CENTER=Axel centrum'#13+
'AXIS MINIMUM=Axel min'#13+
'DAILY (NONE)=Daglig (ingen)'#13+
'WEEKLY=Veckovis'#13+
'MONTHLY=M�natlig'#13+
'BI-MONTHLY=Varannan m�nad'#13+
'QUARTERLY=Kvartalsvis'#13+
'YEARLY=�rlig'#13+
'DATETIME PERIOD=Datum/tid period'#13+
'CASE SENSITIVE=Skilljer p� versaler och gemener'#13+
'DRAG STYLE=Dra stil'#13+
'SQUARED=Fyrkant'#13+
'GRID 3D SERIES=Serie i 3D rutn�t'#13+
'DARK BORDER=M�rk kant'#13+
'PIE SERIES=T�rt serie'#13+
'FOCUS=Fokus'#13+
'EXPLODE=Spr�ngskiss'#13+
'FACTOR=Faktor'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Diagram fr�n mall (*.tee fil)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=�ppna TeeChart mall fr�n'#13+
'BINARY=Bin�r'#13+
'VOLUME OSCILLATOR=Volym oscillator'#13+
'PIE SLICES=T�rtbitar'#13+
'ARROW WIDTH=Pil bredd'#13+
'ARROW HEIGHT=Pil H�jd'#13+
'DEFAULT COLOR=Standard f�rg'#13+
'PERIOD=Period'#13+
'SHADOW EDITOR=Skugg Redigerare'#13+
'CALLOUT=V�rde Info'#13+
'TEXT ALIGNMENT=Text Placering'#13+
'DISTANCE=Distans'#13+
'ARROW HEAD=Pilhuvud'#13+
'POINTER=Visare'#13+
'AVAILABLE LANGUAGES=Tillg�ngliga Spr�k'#13+
'CHOOSE A LANGUAGE=V�lj Spr�k'#13+
'CALCULATE USING=Ber�kna med'#13+
'EVERY NUMBER OF POINTS=Varje Antal Punkter'#13+
'EVERY RANGE=Varje Grupp'#13+
'INCLUDE NULL VALUES=Inkludera Blanka V�rden'#13+
'DATE=Datum'#13+
'ENTER DATE=Skriv Datum'#13+
'ENTER TIME=Skriv Tid'#13+
'DEVIATION=Avvikelser'#13+
'UPPER=�vre'#13+
'LOWER=Nedre'#13+
'NOTHING=Ingenting'#13+
'LEFT TRIANGLE=V�nster Triangel'#13+
'RIGHT TRIANGLE=H�ger Triangel'#13+
'SHOW PREVIOUS BUTTON=Visa F�reg�ende Knapp'#13+
'SHOW NEXT BUTTON=Visa N�sta Knapp'#13+
'CONSTANT=Konstant'#13+
'SHOW LABELS=Visa Etikett'#13+
'SHOW COLORS=Visa F�rger'#13+
'XYZ SERIES=XYZ Serier'#13+
'SHOW X VALUES=Visa X V�rden'#13+
'ACCUMULATE=Ackumulera'#13+
'STEP=Steg'#13+
'DRAG REPAINT=Dra Uppdatering'#13+
'NO LIMIT DRAG=Ingen Begr�nsning vid Dra'#13+
'SMOOTH=Mjuk'#13+
'INTERPOLATE=Inflika'#13+
'START X=Start X'#13+
'NUM. POINTS=Ant. Punkter'#13+
'COLOR EACH LINE=F�rgl�gg Varje Linje'#13+
'SORT BY=Sortera med'#13+
'(NONE)=(Ingen)'#13+
'CALCULATION=Ber�kning'#13+
'WEIGHT=Vikt'#13+
'EDIT LEGEND=Redigera Beskrivning'#13+
'ROUND=Rund'#13+
'FLAT=Platt'#13+
'DRAW ALL=Rita Alla'#13+
'IGNORE NULLS=Ignorera Blanka'#13+
'OFFSET=Offset'#13+
'Z %=Z %'#13+
'LIGHT 0=Ljus 0'#13+
'LIGHT 1=Ljus 1'#13+
'LIGHT 2=Ljus 2'#13+
'DRAW STYLE=Rit Stil'#13+
'POINTS=Punkter'#13+
'DEFAULT BORDER=Standard Kant'#13+
'SHOW PAGE NUMBER=Visa Sidnummer'#13+
'SEPARATION=Delning'#13+
'ROUND BORDER=Rund Kant'#13+
'NUMBER OF SAMPLE VALUES=Antal Test V�rden'#13+
'RESIZE PIXELS TOLERANCE=�ndra Pixeltolerans'#13+
'FULL REPAINT=Full Uppdatering'#13+
'END POINT=Slut Punkt'#13+
'BAND 1=Band 1'#13+
'BAND 2=Band 2'#13+
'TRANSPOSE NOW=F�rflytta Nu'#13+
'PERIOD 1=Period 1'#13+
'PERIOD 2=Period 2'#13+
'PERIOD 3=Period 3'#13+
'HISTOGRAM=Stapeldiagram'#13+
'EXP. LINE=Uppskattad Linje'#13+
'WEIGHTED=Avv�gd'#13+
'WEIGHTED BY INDEX=Avv�gd genom Index'#13+
'BOX SIZE=Ram storlek'#13+
'REVERSAL AMOUNT=Omv�nd Summa'#13+
'PERCENTAGE=Procentuellt'#13+
'COMPLETE R.M.S.=Komplett Effektivv�rde'#13+
'BUTTON=Knapp'#13+
'START AT MIN. VALUE=Starta p� Minsta V�rdet'#13+
'EXECUTE !=K�r !'#13+
'IMAG. SYMBOL=Bild Symbol'#13+
'SELF STACK=En Stapel'#13+
'SIDE LINES=Sido Linjer'#13+
'EXPORT DIALOG=Export Dialog'#13+
'POINT COLORS=Punkt F�rger'#13+
'OUTLINE GRADIENT=Kontur Lutning'#13+
'RADIAL=Radial'#13+
'BALANCE=Balans'#13+
'RADIAL OFFSET=Radial Offset'#13+
'COVER=T�cka'#13+
'VALUE SOURCE=V�rde K�lla'#13+
'DOWN=Ner'#13+
'GROUP=Grupp'#13
;
  end;
end;

Procedure TeeSetSwedish;
begin
  TeeCreateSwedish;
  TeeLanguage:=TeeSwedishLanguage;
  TeeSwedishConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

initialization
finalization
  FreeAndNil(TeeSwedishLanguage);
end.
