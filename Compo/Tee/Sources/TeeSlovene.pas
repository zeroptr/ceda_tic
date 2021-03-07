unit TeeSlovene;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeSloveneLanguage:TStringList=nil;

Procedure TeeSetSlovene;
Procedure TeeCreateSlovene;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};
                               
Procedure TeeSloveneConstants;
begin
  TeeMsg_Copyright          :='� 1995-2009 by David Berneda';
  TeeMsg_LegendFirstValue   :='Vrednost prve legende mora biti > 0';
  TeeMsg_LegendColorWidth   :='Barvna �irina legende mora biti > 0%';
  TeeMsg_SeriesSetDataSource:='Ni Grafa, ki bi potrdil podatkovni set';
  TeeMsg_SeriesInvDataSource:='Ni veljavnega podatkovnega seta: %s';
  TeeMsg_FillSample         :='Vrednosti morajo biti > 0';
  TeeMsg_AxisLogDateTime    :='Datum�as os ne more biti logaritmi�na';
  TeeMsg_AxisLogNotPositive :='Min in Max vrednosti logaritmi�ne osi morajo biti >= 0';
  TeeMsg_AxisLabelSep       :='Lo�enost Napisov % mora biti ve�ji od 0';
  TeeMsg_AxisIncrementNeg   :='Prirastek osi mora biti >= 0';
  TeeMsg_AxisMinMax         :='Minimalna vrednost osi mora biti <= Maximalne vrednosti';
  TeeMsg_AxisMaxMin         :='Maksimalna vrednost osi mora biti >= Minimalne vrednosti';
  TeeMsg_AxisLogBase        :='Logaritmi�na baza osi mora biti >= 2';
  TeeMsg_MaxPointsPerPage   :='Maksimalno �tevilo pik na staran mora biti >= 0';
  TeeMsg_3dPercent          :='Procent 3D efekta mora biti med %d in %d';
  TeeMsg_CircularSeries     :='Kro�ne odvisnosti nizov niso dovoljene';
  TeeMsg_WarningHiColor     :='16k barv ali vec je zahtevanih za bolj�i izgled';

  TeeMsg_DefaultPercentOf   :='%s od %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'od %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Ime osi';
  TeeMsg_AxisLabels         :='Labele osi';
  TeeMsg_RefreshInterval    :='Interval osve�evanja mora biti med 0 in 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart ni myself!';
  TeeMsg_GalleryLine        :='�rta';
  TeeMsg_GalleryPoint       :='Pika';
  TeeMsg_GalleryArea        :='Podro�je';
  TeeMsg_GalleryBar         :='Stolpec';
  TeeMsg_GalleryHorizBar    :='Horiz. Stolpec';
  TeeMsg_Stack              :='Sklad';
  TeeMsg_GalleryPie         :='Pita';
  TeeMsg_GalleryCircled     :='Kro�en';
  TeeMsg_GalleryFastLine    :='Hitra �rta';
  TeeMsg_GalleryHorizLine   :='Horiz �rta';

  TeeMsg_PieSample1         :='Avtomobili';
  TeeMsg_PieSample2         :='Telefoni';
  TeeMsg_PieSample3         :='Tabele';
  TeeMsg_PieSample4         :='Monitorji';
  TeeMsg_PieSample5         :='Svetilke';
  TeeMsg_PieSample6         :='Tipkovnice';
  TeeMsg_PieSample7         :='Kolesa';
  TeeMsg_PieSample8         :='Stoli';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Urejam %s';

  TeeMsg_GalleryStandard    :='Klasi�en';
  TeeMsg_GalleryExtended    :='Raz�irjen';
  TeeMsg_GalleryFunctions   :='Funkcije';

  TeeMsg_EditChart          :='&Uredi Graf...';
  TeeMsg_PrintPreview       :='&Predogled tiskanja...';
  TeeMsg_ExportChart        :='&Izvozi Graf...';
  TeeMsg_CustomAxes         :='Osi Po meri...';

  TeeMsg_InvalidEditorClass :='%s: Napa�en razred urejevalnika: %s';
  TeeMsg_MissingEditorClass :='%s: nima urejevalnika';

  TeeMsg_GalleryArrow       :='Pu��ica';

  TeeMsg_ExpFinish          :='&Kon�aj';
  TeeMsg_ExpNext            :='&Naprej >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Na�rt';
  TeeMsg_GanttSample2       :='Prototip';
  TeeMsg_GanttSample3       :='Razvoj';
  TeeMsg_GanttSample4       :='Prodaja';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testiranje';
  TeeMsg_GanttSample7       :='Proizvodnja';
  TeeMsg_GanttSample8       :='Odstranjevanje napak';
  TeeMsg_GanttSample9       :='Nova Razli�ica';
  TeeMsg_GanttSample10      :='Ban�ni�tvo';

  TeeMsg_ChangeSeriesTitle  :='Spremeni ime niza';
  TeeMsg_NewSeriesTitle     :='Ime nove serije:';
  TeeMsg_DateTime           :='DatumUra';
  TeeMsg_TopAxis            :='Zgornja Os';
  TeeMsg_BottomAxis         :='Spodnja Os';
  TeeMsg_LeftAxis           :='Leva Os';
  TeeMsg_RightAxis          :='Desna Os';

  TeeMsg_SureToDelete       :='Bri�i %s ?';
  TeeMsg_DateTimeFormat     :='DatumUra For&mat :';
  TeeMsg_Default            :='Privzeto';
  TeeMsg_ValuesFormat       :='Vrednosti For&mat:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='�eljen %s prirastek';

  TeeMsg_IncorrectMaxMinValue:='Napa�na vrednost. Vzrok: %s';
  TeeMsg_EnterDateTime      :='Vnesi [�tevilo Dni] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Uporabi spremembe ?';
  TeeMsg_SelectedSeries     :='(Izbrani Nizi)';
  TeeMsg_RefreshData        :='&Osve�i Podatke';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='421';
  TeeMsg_FunctionAdd        :='Pri�tej';
  TeeMsg_FunctionSubtract   :='Od�tej';
  TeeMsg_FunctionMultiply   :='Mno�i';
  TeeMsg_FunctionDivide     :='Deli';
  TeeMsg_FunctionHigh       :='Visoko';
  TeeMsg_FunctionLow        :='Nizko';
  TeeMsg_FunctionAverage    :='Povpre�je';

  TeeMsg_GalleryShape       :='Lik';
  TeeMsg_GalleryBubble      :='Mehur�ek';
  TeeMsg_FunctionNone       :='Kopiraj';

  TeeMsg_None               :='(nih�e)';

  TeeMsg_PrivateDeclarations:='{ Zasebne napovedi }';
  TeeMsg_PublicDeclarations :='{ Javne napovedi }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Velikost kazalca mora biti ve�ja od ni�';
  TeeMsg_About              :='&O TeeChart...';

  tcAdditional              :='Dodatno';
  tcDControls               :='Nadzor podatkov';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Podatkovni set';
  TeeMsg_AskDataSet         :='&Podatkovni set:';

  TeeMsg_SingleRecord       :='Posamezen vnos';
  TeeMsg_AskDataSource      :='&Podatkovni set:';

  TeeMsg_Summary            :='Povzetek';

  TeeMsg_FunctionPeriod     :='Perioda funkcije mora biti >= 0';

  TeeMsg_WizardTab          :='Poslovno';
  TeeMsg_TeeChartWizard     :='TeeChart �arovnik';

  TeeMsg_ClearImage         :='&O�isti';
  TeeMsg_BrowseImage        :='&Prebrskaj...';

  TeeMsg_WizardSureToClose  :='Ali ste prepri�ani da �elite zepreti TeeChart arovnika ?';
  TeeMsg_FieldNotFound      :='Polje %s ne obstaja';

  TeeMsg_DepthAxis          :='Globina Osi';
  TeeMsg_PieOther           :='Ostalo';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pita';
  TeeMsg_ValuesBar          :='Stolpec';
  TeeMsg_ValuesAngle        :='Kot';
  TeeMsg_ValuesGanttStart   :='Za�etek';
  TeeMsg_ValuesGanttEnd     :='Konec';
  TeeMsg_ValuesGanttNextTask:='Naslednje Opravilo';
  TeeMsg_ValuesBubbleRadius :='Radij';
  TeeMsg_ValuesArrowEndX    :='KonecX';
  TeeMsg_ValuesArrowEndY    :='KonecY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Naslov';
  TeeMsg_Foot               :='Noga';
  TeeMsg_Period		    :='Perioda';
  TeeMsg_PeriodRange        :='Obseg Periode';
  TeeMsg_CalcPeriod         :='Prera�unaj %s vsake:';
  TeeMsg_SmallDotsPen       :='Majhne Pike';

  TeeMsg_InvalidTeeFile     :='Neveljaven graf v *.'+TeeMsg_TeeExtension+' datoteki';
  TeeMsg_WrongTeeFileFormat :='Napa�en *.'+TeeMsg_TeeExtension+' format datoteke';
  TeeMsg_EmptyTeeFile       :='Prazna *.'+TeeMsg_TeeExtension+' datoteka';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Graf Osi';
  TeeMsg_ChartAxesCategoryDesc   := 'Graf Osi lastnosti in dogodki';
  TeeMsg_ChartWallsCategoryName  := 'Graf zidovi';
  TeeMsg_ChartWallsCategoryDesc  := 'Graf zidovi lastnosti in dogodki';
  TeeMsg_ChartTitlesCategoryName := 'Graf imena';
  TeeMsg_ChartTitlesCategoryDesc := 'Graf imena lastnosti in dogodki';
  TeeMsg_Chart3DCategoryName     := 'Graf 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Graf 3D lastnosti in dogodki';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Po meri ';
  TeeMsg_Series                 :='Nizi';
  TeeMsg_SeriesList             :='Nizi...';

  TeeMsg_PageOfPages            :='Stran %d od %d';
  TeeMsg_FileSize               :='%d bajtov';

  TeeMsg_First  :='Prvi';
  TeeMsg_Prior  :='Predhodnji';
  TeeMsg_Next   :='Naslednji';
  TeeMsg_Last   :='Zadnji';
  TeeMsg_Insert :='Dodaj';
  TeeMsg_Delete :='Zbri�i';
  TeeMsg_Edit   :='Uredi';
  TeeMsg_Post   :='Objavi';
  TeeMsg_Cancel :='Prekli�i';

  TeeMsg_All    :='(vsi)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Tekst';

  TeeMsg_AsBMP        :='kot &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='kot &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Lastnost platna ni dolo�ena v formatu za izvoz';

  TeeMsg_Normal    :='Normalno';
  TeeMsg_NoBorder  :='Brez Robu';
  TeeMsg_Dotted    :='Pik�asto';
  TeeMsg_Colors    :='Barve';
  TeeMsg_Filled    :='Zapolnjeno';
  TeeMsg_Marks     :='Oznake';
  TeeMsg_Stairs    :='Zvezde';
  TeeMsg_Points    :='Pike';
  TeeMsg_Height    :='Vi�ina';
  TeeMsg_Hollow    :='Votel';
  TeeMsg_Point2D   :='2D pika';
  TeeMsg_Triangle  :='Trikotnik';
  TeeMsg_Star      :='Zvezda';
  TeeMsg_Circle    :='Krog';
  TeeMsg_DownTri   :='Navzdol usmerjen trikotnik';
  TeeMsg_Cross     :='Kri�';
  TeeMsg_Diamond   :='Karo';
  TeeMsg_NoLines   :='Brez �rt';
  TeeMsg_Stack100  :='Sklad 100%';
  TeeMsg_Pyramid   :='Piramida';
  TeeMsg_Ellipse   :='Elipsa';
  TeeMsg_InvPyramid:='Obrnjena Piramida';
  TeeMsg_Sides     :='Strani';
  TeeMsg_SideAll   :='Strani Vse';
  TeeMsg_Patterns  :='Vzorci';
  TeeMsg_Exploded  :='Razpo�eno';
  TeeMsg_Shadow    :='Senca';
  TeeMsg_SemiPie   :='Pol Pite';
  TeeMsg_Rectangle :='Pravokotnik';
  TeeMsg_VertLine  :='Vert.�rta';
  TeeMsg_HorizLine :='Horiz.�rta';
  TeeMsg_Line      :='�rta';
  TeeMsg_Cube      :='Kocka';
  TeeMsg_DiagCross :='Diag.Kri�';

  TeeMsg_CanNotFindTempPath    :='Ne morem najti Temp mape';
  TeeMsg_CanNotCreateTempChart :='Ne morem ustvariti Temp datoteke';
  TeeMsg_CanNotEmailChart      :='Ne morem postlati TeeChart. Mapi Napaka: %d';

  TeeMsg_SeriesDelete :='Niz Bri�i: VrednostIndeksa %d izben omejitev (0 do %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='kot &JPEG';
  TeeMsg_JPEGFilter    :='JPEG datoteke (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='kot &GIF';
  TeeMsg_GIFFilter     :='GIF datoteke (*.gif)|*.gif';
  TeeMsg_AsPNG         :='kot &PNG';
  TeeMsg_PNGFilter     :='PNG datoteke (*.png)|*.png';
  TeeMsg_AsPCX         :='kot PC&X';
  TeeMsg_PCXFilter     :='PCX datoteke (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='kot &VML (HTM)';
  TeeMsg_VMLFilter     :='VML datoteke (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Jezik...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polaren';
  TeeMsg_GalleryCandle      :='Sve�a';
  TeeMsg_GalleryVolume      :='Volumen';
  TeeMsg_GallerySurface     :='Povr�je';
  TeeMsg_GalleryContour     :='Obris';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='To�ka 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Kolobar';
  TeeMsg_GalleryCursor      :='Kurzor';
  TeeMsg_GalleryBar3D       :='Stolpec 3D';
  TeeMsg_GalleryBigCandle   :='Velika Sve�a';
  TeeMsg_GalleryLinePoint   :='�rta To�ka';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Slap';
  TeeMsg_GalleryWindRose    :='Veterna Ro�a';
  TeeMsg_GalleryClock       :='Ura';
  TeeMsg_GalleryColorGrid   :='Mre�aBarv';
  TeeMsg_GalleryBoxPlot     :='Zasnova�katle';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.Zasnova�katle';
  TeeMsg_GalleryBarJoin     :='Zdru�eni Stolpci';
  TeeMsg_GallerySmith       :='Kova�';
  TeeMsg_GalleryPyramid     :='Piramida';
  TeeMsg_GalleryMap         :='Zemljevid';

  TeeMsg_PolyDegreeRange    :='Polinomske stopinje morajo biti med 1 in 20';
  TeeMsg_AnswerVectorIndex   :='Indeks odzivnega vektorja mora biti med 1 in %d';
  TeeMsg_FittingError        :='Ne morem izvesti postopka prileganja';
  TeeMsg_PeriodRange         :='Obdobje mora biti >= 0';
  TeeMsg_ExpAverageWeight    :='�irina Eksp.Povpre�ja mora biti med 0 in 1';
  TeeMsg_GalleryErrorBar     :='Stolpec Napak';
  TeeMsg_GalleryError        :='Napaka';
  TeeMsg_GalleryHighLow      :='Visoko-Nizko';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div';
  TeeMsg_FunctionExpAverage  :='Eksp. Povpre�je';
  TeeMsg_FunctionMovingAverage:='Premikajo�e Povpre�je';
  TeeMsg_FunctionExpMovAve   :='Eksp.Premik.Povp.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Prilagajanje Krivine';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Eksp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Kumulativen';
  TeeMsg_FunctionStdDeviation:='Stand.Odklon';
  TeeMsg_FunctionBollinger   :='Delitelj';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='�tetje';
  TeeMsg_LoadChart           :='Odpri TeeChart...';
  TeeMsg_SaveChart           :='Shrani TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro filtri';

  TeeMsg_GallerySamples      :='Ostalo';
  TeeMsg_GalleryStats        :='Statisike';

  TeeMsg_CannotFindEditor    :='Ne morem najti obrazca urejevalnika nizov: %s';


  TeeMsg_CannotLoadChartFromURL:='Koda napake: %d nalaganje Grafa iz URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Koda napake: %d nalaganje podatkov za Niza iz URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Datum';
  TeeMsg_ValuesOpen          :='Odpri';
  TeeMsg_ValuesHigh          :='Visoko';
  TeeMsg_ValuesLow           :='Nizko';
  TeeMsg_ValuesClose         :='Zapri';
  TeeMsg_ValuesOffset        :='Ofset';
  TeeMsg_ValuesStdError      :='StandNapaka';

  TeeMsg_Grid3D              :='3D Mre�a';

  TeeMsg_LowBezierPoints     :='�tevilo Bezier-jevih to�k mora biti > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normalen';
  TeeCommanMsg_Edit     :='Uredi';
  TeeCommanMsg_Print    :='Natisni';
  TeeCommanMsg_Copy     :='Kopiraj';
  TeeCommanMsg_Save     :='Shrani';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Obra�anje: %d� Dviganje: %d�';
  TeeCommanMsg_Rotate   :='Obrni';

  TeeCommanMsg_Moving   :='Horiz.Ofset: %d Vert.Ofset: %d';
  TeeCommanMsg_Move     :='Premakni';

  TeeCommanMsg_Zooming  :='Pove�ava: %d %%';
  TeeCommanMsg_Zoom     :='Pove�ava';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Globina';

  TeeCommanMsg_Chart    :='Graf';
  TeeCommanMsg_Panel    :='Platno';

  TeeCommanMsg_RotateLabel:='Potegni %s za Obra�anje';
  TeeCommanMsg_MoveLabel  :='Potegni %s za Premikanje';
  TeeCommanMsg_ZoomLabel  :='Potegni %s za Pove�avo';
  TeeCommanMsg_DepthLabel :='Potegni %s za Spreminjenje velikosti 3D';

  TeeCommanMsg_NormalLabel:='Potegni Levi gumb za Pove�avo, Desni gumb za pomikanje';
  TeeCommanMsg_NormalPieLabel:='Potegni kos Pite da se bo razpo�ila';

  TeeCommanMsg_PieExploding :='Rezina: %d Razpo�eno: %d %%';

  TeeMsg_TriSurfaceLess        :='�tevilo to�k mora biti >= 4';
  TeeMsg_TriSurfaceAllColinear :='Vse kolinearne podatkovne to�ke';
  TeeMsg_TriSurfaceSimilar     :='Podobne to�ke - ne morem izvr�iti';
  TeeMsg_GalleryTriSurface     :='Povr�ina Trikotnika';

  TeeMsg_AllSeries :='Vsi Nizi';
  TeeMsg_Edit      :='Uredi';

  TeeMsg_GalleryFinancial    :='Finan�no';

  TeeMsg_CursorTool    :='Kurzor';
  TeeMsg_DragMarksTool :='Znamenja za poteg';
  TeeMsg_AxisArrowTool :='Pu��ice Osi';
  TeeMsg_DrawLineTool  :='Nari�i �rto';
  TeeMsg_NearestTool   :='Najbli�ja to�ka';
  TeeMsg_ColorBandTool :='Barvni pas';
  TeeMsg_ColorLineTool :='Barvna �rta';
  TeeMsg_RotateTool    :='Zavrti';
  TeeMsg_ImageTool     :='Slika';
  TeeMsg_MarksTipTool  :='Ozna�i Vrhove';

  TeeMsg_CantDeleteAncestor  :='Ne morem brisati prednika';

  TeeMsg_Load	          :='Nalo�i...';
  TeeMsg_NoSeriesSelected :='Nobenega Niza ozna�enega';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Graf';
  TeeMsg_CategorySeriesActions :='Nizi Grafa';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Preklopi 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Aktiven';
  TeeMsg_ActionSeriesActiveHint := 'Poka�i / Skrij Nize';
  TeeMsg_ActionEditHint         := 'Uredi Graf';
  TeeMsg_ActionEdit             := '&Uredi...';
  TeeMsg_ActionCopyHint         := 'Kopiraj v odlo�i��e';
  TeeMsg_ActionCopy             := '&Kopiraj';
  TeeMsg_ActionPrintHint        := 'Predogled tiskanja Grafa';
  TeeMsg_ActionPrint            := '&Tiskaj...';
  TeeMsg_ActionAxesHint         := 'Poka�i / Skrij Osi';
  TeeMsg_ActionAxes             := '&Osi';
  TeeMsg_ActionGridsHint        := 'Poka�i / Skrij Mre�e';
  TeeMsg_ActionGrids            := '&Mre�e';
  TeeMsg_ActionLegendHint       := 'Poka�i / Skrij Legendo';
  TeeMsg_ActionLegend           := '&Legenda';
  TeeMsg_ActionSeriesEditHint   := 'Uredi Nize';
  TeeMsg_ActionSeriesMarksHint  := 'Poka�i / Skrij Znamenja Nizov';
  TeeMsg_ActionSeriesMarks      := '&Znamenja';
  TeeMsg_ActionSaveHint         := 'Shrani Graf';
  TeeMsg_ActionSave             := '&Shrani...';

  TeeMsg_CandleBar              := 'Stolpec';
  TeeMsg_CandleNoOpen           := 'Ni Odpiranja';
  TeeMsg_CandleNoClose          := 'Ni Zapiranja';
  TeeMsg_NoLines                := 'Ni �rt';
  TeeMsg_NoHigh                 := 'Ni Visokega';
  TeeMsg_NoLow                  := 'Ni Nizkega';
  TeeMsg_ColorRange             := 'Barvna Lestvica';
  TeeMsg_WireFrame              := '�i�ni okvir';
  TeeMsg_DotFrame               := 'Pik�ast Okvir';
  TeeMsg_Positions              := 'Polo�aji';
  TeeMsg_NoGrid                 := 'Ni Mre�e';
  TeeMsg_NoPoint                := 'Ni Pike';
  TeeMsg_NoLine                 := 'Ni �rte';
  TeeMsg_Labels                 := 'Napisi';
  TeeMsg_NoCircle               := 'Ni Krogov';
  TeeMsg_Lines                  := 'Vrstice';
  TeeMsg_Border                 := 'Rob';

  TeeMsg_SmithResistance      := 'Upornost';
  TeeMsg_SmithReactance       := 'Reaktanca';

  TeeMsg_Column               := 'Stolpec';

  { 5.01 }
  TeeMsg_Separator            := 'Lo�ilec';
  TeeMsg_FunnelSegment        := 'Segment ';
  TeeMsg_FunnelSeries         := 'Lijak';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Presega kvoto';
  TeeMsg_FunnelWithin         := 'znotraj kvote';
  TeeMsg_FunnelBelow          := 'ali ve� pod kvoto';
  TeeMsg_CalendarSeries       := 'Koledar';
  TeeMsg_DeltaPointSeries     := 'DeltaTo�ka';
  TeeMsg_ImagePointSeries     := 'SlikaTo�ka';
  TeeMsg_ImageBarSeries       := 'SlikaStolpec';
  TeeMsg_SeriesTextFieldZero  := 'BesediloNiza: Indeksi polj morajo biti ve�ji kot ni�.';

  { 5.02 }
  TeeMsg_Origin               := 'Izvor';
  TeeMsg_Transparency         := 'Transparentnost';
  TeeMsg_Box		      := '�katla';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := '�tevilka Strani';
  TeeMsg_TextFile             := 'Tekstovna Datoteka';

  { 5.03 }
  TeeMsg_Gradient             :='Gradient';
  TeeMsg_WantToSave           :='Shrani %s?';

  TeeMsg_Property             :='Property';
  TeeMsg_Value                :='Vrednost';
  TeeMsg_Yes                  :='Da';
  TeeMsg_No                   :='Ni';
  TeeMsg_Image                :='(Slika)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Potegni Pik';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  // 6.0

// TeeConst
  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='kot &PDF';
  TeeMsg_PDFFilter        :='PDF datoteke (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='kot PostScript';
  TeeMsg_PSFilter         :='PostScript datoteke (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Vodoravno'#13'podro?je';
  TeeMsg_SelfStack        :='Stolpci zlo�eni';
  TeeMsg_DarkPen          :='Temni rob';
  TeeMsg_SelectFolder     :='Izberi direktorij';
  TeeMsg_BDEAlias         :='&Drugo ime:';
  TeeMsg_ADOConnection    :='&Povezava:';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Meh?anje';
  TeeMsg_FunctionCross        :='Prese?i�?e';
  TeeMsg_GridTranspose        :='3D transponiraj mre�o';
  TeeMsg_FunctionCompress     :='Stiskanje';
  TeeMsg_ExtraLegendTool      :='Dodatna legenda';
  TeeMsg_FunctionCLV          :='Close Location'#13'Value';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Animacija serije';
  TeeMsg_GalleryPointFigure   :='Point & Figure';
  TeeMsg_Up                   :='Gor';
  TeeMsg_Down                 :='Dol';
  TeeMsg_GanttTool            :='Poteg Gantt to?k';
  TeeMsg_XMLFile              :='XML datoteka';
  TeeMsg_GridBandTool         :='Pas mre�e';
  TeeMsg_FunctionPerf         :='Performance';
  TeeMsg_GalleryGauge         :='�tevec';
  TeeMsg_GalleryGauges        :='�tevci';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='Vektorji 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Stolp';
  TeeMsg_SingleColor          :='Ena barva';
  TeeMsg_Cover                :='Pokrij';
  TeeMsg_Cone                 :='Sto�ec';
  TeeMsg_PieTool              :='Kos pite';

end;

Procedure TeeCreateSlovene;
begin
  if not Assigned(TeeSloveneLanguage) then
  begin
    TeeSloveneLanguage:=TStringList.Create;
    TeeSloveneLanguage.Text:=

'GRADIENT EDITOR=Urejevalnik Gradienta'#13+
'GRADIENT=Gradient'#13+
'DIRECTION=Smer'#13+
'VISIBLE=Vidno'#13+
'TOP BOTTOM=Vrh Dno'#13+
'BOTTOM TOP=Dno Vrh'#13+
'LEFT RIGHT=Levo Desno'#13+
'RIGHT LEFT=Desno Levo'#13+
'FROM CENTER=Od Sredine'#13+
'FROM TOP LEFT=Od Zgoraj Levo'#13+
'FROM BOTTOM LEFT=Od Dna Levo'#13+
'OK=Vredu'#13+
'CANCEL=Prekli�i'#13+
'COLORS=Barve'#13+
'START=Za�etek'#13+
'MIDDLE=Stredina'#13+
'END=Konec'#13+
'SWAP=Zamenjaj'#13+
'NO MIDDLE=Ni sredine'#13+
'TEEFONT EDITOR=Urejevalnik Pisav'#13+
'INTER-CHAR SPACING=Razmik med grafi'#13+
'FONT=Pisava'#13+
'SHADOW=Senca'#13+
'HORIZ. SIZE=Horiz. velikost'#13+
'VERT. SIZE=Vert. velikost'#13+
'COLOR=Barva'#13+
'OUTLINE=Obris'#13+
'OPTIONS=Mo�nosti'#13+
'FORMAT=Format'#13+
'TEXT=Tekst'#13+
'LEFT=Levo'#13+
'TOP=Zgoraj'#13+
'AUTO=Samod.'#13+
'CUSTOM=Po meri'#13+
'LEFT TOP=Levo zgoraj'#13+
'LEFT BOTTOM=Levo spodaj'#13+
'RIGHT TOP=Desno zgoraj'#13+
'RIGHT BOTTOM=Desno spodaj'#13+
'MULTIPLE AREAS=Ve� povr�in'#13+
'NONE=Ni�'#13+
'STACKED=Sklad'#13+
'STACKED 100%=Skladno 100%'#13+
'AREA=Povr�ina'#13+
'PATTERN=Vzorec'#13+
'STAIRS=Zvezde'#13+
'SOLID=Cel'#13+
'CLEAR=O�isti'#13+
'HORIZONTAL=Horizontalno'#13+
'VERTICAL=Verticalno'#13+
'DIAGONAL=Diagonalno'#13+
'B.DIAGONAL=B.Diagonalno'#13+
'CROSS=Kri�'#13+
'DIAG.CROSS=Diag.Kri�'#13+
'AREA LINES=Ploskovne �rte'#13+
'BORDER=Rob'#13+
'INVERTED=Obrnjeno'#13+
'INVERTED SCROLL=Obrnjeno Pomikanje'#13+
'COLOR EACH=Obarvaj vsako'#13+
'ORIGIN=Izvor'#13+
'USE ORIGIN=Uporavi izvor'#13+
'WIDTH=�irina'#13+
'HEIGHT=Vi�ina'#13+
'AXIS=Osi'#13+
'LENGTH=Dol�ina'#13+
'SCROLL=Pomikanje'#13+
'BOTH=Oboje'#13+
'AXIS INCREMENT=Prirastek osi'#13+
'INCREMENT=Prirastek'#13+
'STANDARD=Obi�ajno'#13+
'ONE MILLISECOND=Ena milisekunda'#13+
'ONE SECOND=Ena sekunda'#13+
'FIVE SECONDS=Pet sekund'#13+
'TEN SECONDS=Deset sekund'#13+
'FIFTEEN SECONDS=Petnajst sekund'#13+
'THIRTY SECONDS=Trideset sekund'#13+
'ONE MINUTE=Ena minuta'#13+
'FIVE MINUTES=Pet minut'#13+
'TEN MINUTES=Deset minut'#13+
'FIFTEEN MINUTES=Petnajst minut'#13+
'THIRTY MINUTES=Trideset minut'#13+
'ONE HOUR=Ena ura'#13+
'TWO HOURS=Dve uri'#13+
'SIX HOURS=�est ur'#13+
'TWELVE HOURS=Dvanajst ur'#13+
'ONE DAY=En dan'#13+
'TWO DAYS=Dva dni'#13+
'THREE DAYS=Trije dnevi'#13+
'ONE WEEK=En Teden'#13+
'HALF MONTH=Pol meseca'#13+
'ONE MONTH=En mesec'#13+
'TWO MONTHS=Dva meseca'#13+
'THREE MONTHS=Tri mesece'#13+
'FOUR MONTHS=�tiri mesece'#13+
'SIX MONTHS=�est mesecev'#13+
'ONE YEAR=Eno Leto'#13+
'EXACT DATE TIME=Natan�en datum �as'#13+
'AXIS MAXIMUM AND MINIMUM=Minimum in maksimum osi'#13+
'VALUE=Vrednost'#13+
'TIME=�as'#13+
'LEFT AXIS=Leva os'#13+
'RIGHT AXIS=Desna os'#13+
'TOP AXIS=Zgornja os'#13+
'BOTTOM AXIS=Spodnja os'#13+
'% BAR WIDTH=% �irina stolpca'#13+
'STYLE=Stil'#13+
'% BAR OFFSET=% ofset stolpca'#13+
'RECTANGLE=Pravokotnik'#13+
'PYRAMID=Piramida'#13+
'INVERT. PYRAMID=Obrnjena Piramida'#13+
'CYLINDER=Cilinder'#13+
'ELLIPSE=Elipsa'#13+
'ARROW=Pu��ica'#13+
'RECT. GRADIENT=Prav. Gradient'#13+
'CONE=Cona'#13+
'DARK BAR 3D SIDES=Dark bar 3D Sides'#13+
'BAR SIDE MARGINS=Bar Side Margins'#13+
'AUTO MARK POSITION=Avtomati�no ozna�i lego'#13+
'JOIN=Zdru�i'#13+
'DATASET=Podatkovni set'#13+
'APPLY=Uporabi'#13+
'SOURCE=Vir'#13+
'MONOCHROME=Monokromatsko'#13+
'DEFAULT=Privzeto'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Srednji'#13+
'WHISKER=Whisker'#13+
'PATTERN COLOR EDITOR=Urejevalnik vzorca barv'#13+
'IMAGE=Slika'#13+
'BACK DIAGONAL=Zadnja Diagonala'#13+
'DIAGONAL CROSS=Diagonalen Kri�'#13+
'FILL 80%=Zapolni 80%'#13+
'FILL 60%=Zapolni 60%'#13+
'FILL 40%=Zapolni 40%'#13+
'FILL 20%=Zapolni 20%'#13+
'FILL 10%=Zapolni 10%'#13+
'ZIG ZAG=Cik Cak'#13+
'VERTICAL SMALL=Vertikalno majhen'#13+
'HORIZ. SMALL=Horizontalno majhen'#13+
'DIAG. SMALL=Diagonalno majhen'#13+
'BACK DIAG. SMALL=Zadnja Diag.'#13+
'CROSS SMALL=Kri� majhen'#13+
'DIAG. CROSS SMALL=Diag. Kri�'#13+
'DAYS=Dnevi'#13+
'WEEKDAYS=Dnevi v tednu'#13+
'TODAY=Danes'#13+
'SUNDAY=Nedelja'#13+
'TRAILING=Sledenje'#13+
'MONTHS=Meseci'#13+
'LINES=�rte'#13+
'SHOW WEEKDAYS=Poka�i Dneve v tednu'#13+
'UPPERCASE=Z veliko za�etnico'#13+
'TRAILING DAYS=Sledenje dnevom'#13+
'SHOW TODAY=Poka�i danes'#13+
'SHOW MONTHS=Poka�i mesece'#13+
'CANDLE WIDTH=�irina sve�e'#13+
'STICK=Palica'#13+
'BAR=Stolpec'#13+
'OPEN CLOSE=Odpri Zapri'#13+
'UP CLOSE=Barvno nara��ajo�'#13+
'DOWN CLOSE=Barvno Padajo�'#13+
'SHOW OPEN=Odpiri'#13+
'SHOW CLOSE=Zapri'#13+
'DRAW 3D=3D'#13+
'DARK 3D=3D Tekmno'#13+
'EDITING=Urejanje'#13+
'CHART=Graf'#13+
'SERIES=Nizi'#13+
'DATA=Podatki'#13+
'TOOLS=Nastavitve'#13+
'EXPORT=Pretvori'#13+
'PRINT=Tiskaj'#13+
'GENERAL=Splo�en'#13+
'TITLES=Naslovi'#13+
'LEGEND=Legende'#13+
'PANEL=Platno'#13+
'PAGING=Stran'#13+
'WALLS=Zidovi'#13+
'3D=3D'#13+
'ADD=Dodaj'#13+
'DELETE=Zbri�i'#13+
'TITLE=Naslov'#13+
'CLONE=Podvoji'#13+
'CHANGE=Spremeni'#13+
'HELP=Pomo�'#13+
'CLOSE=Zapri'#13+
'PRINTER=Tiskalnik'#13+
'SETUP=Nastavi'#13+
'ORIENTATION=Usmerjenost'#13+
'PORTRAIT=Pokon�no'#13+
'LANDSCAPE=Le�e�e'#13+
'MARGINS (%)=Robovi (%)'#13+
'DETAIL=Detajl'#13+
'MORE=Ve�'#13+
'NORMAL=Normalno'#13+
'RESET MARGINS=Ponastavi robove'#13+
'VIEW MARGINS=Poka�i robove'#13+
'PROPORTIONAL=Proporcionalno'#13+
'TEECHART PRINT PREVIEW=TeeChart Predogled tiskanja'#13+
'CIRCLE=Krog'#13+
'VERTICAL LINE=Vert. �rta'#13+
'HORIZ. LINE=Horiz. �rta'#13+
'TRIANGLE=Trikotnik'#13+
'INVERT. TRIANGLE=Obrnjen Trikotnik'#13+
'LINE=�rta'#13+
'DIAMOND=Diamant'#13+
'CUBE=Kocka'#13+
'STAR=Zvezda'#13+
'TRANSPARENT=Transparentno'#13+
'HORIZ. ALIGNMENT=Horiz. Poravnava'#13+
'CENTER=Sredina'#13+
'RIGHT=Desno'#13+
'ROUND RECTANGLE=Zaokro�en pravokotnik'#13+
'ALIGNMENT=Poravnava'#13+
'BOTTOM=Spodaj'#13+
'UNITS=Enote'#13+
'PIXELS=Piksli'#13+
'AXIS ORIGIN=Izvor Osi'#13+
'ROTATION=Vrtenje'#13+
'CIRCLED=Zaokro�en'#13+
'3 DIMENSIONS=3 Dimensionalen'#13+
'RADIUS=Radij'#13+
'ANGLE INCREMENT=Inkrement kota'#13+
'RADIUS INCREMENT=Inkrement radija'#13+
'CLOSE CIRCLE=Bli�en kri�'#13+
'PEN=Pisalo'#13+
'LABELS=Napisi'#13+
'ROTATED=Zavrteno'#13+
'CLOCKWISE=V smeri urnega kazalca'#13+
'INSIDE=Znotraj'#13+
'ROMAN=Roman'#13+
'HOURS=Ure'#13+
'MINUTES=Minute'#13+
'SECONDS=Sekunde'#13+
'START VALUE=Za�etna vred'#13+
'END VALUE=Kon�na vred'#13+
'TRANSPARENCY=Trensparentnost'#13+
'DRAW BEHIND=Ri�i zadaj'#13+
'COLOR MODE=Barvni na�in'#13+
'STEPS=Koraki'#13+
'RANGE=Obseg'#13+
'PALETTE=Paleta'#13+
'PALE=Bledo'#13+
'STRONG=Mo�no'#13+
'GRID SIZE=Velikost mre�e'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=Globina'#13+
'IRREGULAR=Nepravilno'#13+
'GRID=Mre�a'#13+
'ALLOW DRAG=Dopusti poteg'#13+
'VERTICAL POSITION=Vertikalen polo�aj'#13+
'LEVELS POSITION=Polo�aj ravnine'#13+
'LEVELS=Ravnine'#13+
'NUMBER=�tevilka'#13+
'LEVEL=Ravnina'#13+
'AUTOMATIC=Samodejno'#13+
'SNAP=Snap'#13+
'FOLLOW MOUSE=Sledi Mi�ki'#13+
'STACK=Sklad'#13+
'HEIGHT 3D=3D Vi�ina'#13+
'LINE MODE=Na�in �rte'#13+
'OVERLAP=Prekrivanje'#13+
'STACK 100%=Sklad 100%'#13+
'CLICKABLE=Dopustiti klik'#13+
'AVAILABLE=Razpolo�ljiv'#13+
'SELECTED=Ozna�en'#13+
'DATASOURCE=Podatkovni izvir'#13+
'GROUP BY=Grpiraj po'#13+
'CALC=Izra�unaj'#13+
'OF=od'#13+
'SUM=Vsota'#13+
'COUNT=�tej'#13+
'HIGH=Visoko'#13+
'LOW=Nizko'#13+
'AVG=Povpre�no'#13+
'HOUR=Ura'#13+
'DAY=Dan'#13+
'WEEK=Teden'#13+
'WEEKDAY=Dan v tednu'#13+
'MONTH=Mesec'#13+
'QUARTER=�etrt'#13+
'YEAR=Leto'#13+
'HOLE %=Luknja %'#13+
'RESET POSITIONS=Ponastavi polo�aje'#13+
'MOUSE BUTTON=Mi�kin gumb'#13+
'ENABLE DRAWING=Omogo�i risanje'#13+
'ENABLE SELECT=Omogo�i ozna�evanje'#13+
'ENHANCED=Pove�an'#13+
'ERROR WIDTH=Napa�na �irina'#13+
'WIDTH UNITS=Enote za �irino'#13+
'PERCENT=Procent'#13+
'LEFT AND RIGHT=Levo in desno'#13+
'TOP AND BOTTOM=Zgoraj in spodaj'#13+
'BORDER EDITOR=Urejevalnik robu'#13+
'DASH=�rta'#13+
'DOT=Pika'#13+
'DASH DOT=�rta pika'#13+
'DASH DOT DOT=�rta pika pika'#13+
'CALCULATE EVERY=Izra�unaj vsake'#13+
'ALL POINTS=Vse to�ke'#13+
'NUMBER OF POINTS=�tevilo pik'#13+
'RANGE OF VALUES=Obseg vrednosti'#13+
'FIRST=Prvi'#13+
'LAST=Zadnji'#13+
'TEEPREVIEW EDITOR=TeePredpregled Urejevalnik'#13+
'ALLOW MOVE=Omogo�i premik'#13+
'ALLOW RESIZE=Omogo�i spremembo velikosti'#13+
'DRAG IMAGE=Potegni sliko'#13+
'AS BITMAP=Kot bitmap'#13+
'SHOW IMAGE=Poka�i sliko'#13+
'MARGINS=Robovi'#13+
'SIZE=Velikost'#13+
'3D %=3D %'#13+
'ZOOM=Pove�ava'#13+
'ELEVATION=Elevacija'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Horiz. Ofset'#13+
'VERT. OFFSET=Vert. Ofset'#13+
'PERSPECTIVE=Perspektiva'#13+
'ANGLE=Kot'#13+
'ORTHOGONAL=Ortaogonalen'#13+
'ZOOM TEXT=Pove�aj Tekst'#13+
'SCALES=Lestvice'#13+
'TICKS=Ticks'#13+
'MINOR=Manj�ina'#13+
'MAXIMUM=Maksimum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=�eljen prirastek'#13+
'(INCREMENT)=(prirastek)'#13+
'LOG BASE=Log Basis'#13+
'LOGARITHMIC=Logaritmi�en'#13+
'MIN. SEPARATION %=Min. lo�itev %'#13+
'MULTI-LINE=Mnogo-�rt'#13+
'LABEL ON AXIS=Napis na osi'#13+
'ROUND FIRST=Zaokro�i prvega'#13+
'MARK=Oznaka.'#13+
'LABELS FORMAT=Oblika napisa'#13+
'EXPONENTIAL=Exponenten'#13+
'DEFAULT ALIGNMENT=Privzeta poravnava'#13+
'LEN=Dol�ina'#13+
'INNER=Notranji'#13+
'AT LABELS ONLY=Samo pri napisih'#13+
'CENTERED=Centriran'#13+
'POSITION %=Polo�aj %'#13+
'START %=Za�etek %'#13+
'END %=Konec %'#13+
'OTHER SIDE=Druga Stran'#13+
'AXES=Osi'#13+
'BEHIND=Zadaj'#13+
'CLIP POINTS=Clip Points'#13+
'PRINT PREVIEW=Predogled tiskanja'#13+
'MINIMUM PIXELS=Minimum Pikslov'#13+
'ALLOW=Pribli�uj/Oddaljuj'#13+
'ANIMATED=Animiran'#13+
'ALLOW SCROLL=Dovoli pomikanje'#13+
'TEEOPENGL EDITOR=TeeOpenGL Urejevalnik'#13+
'AMBIENT LIGHT=Okoli�ka svetloba'#13+
'SHININESS=Osvetlitev'#13+
'FONT 3D DEPTH=Pisava 3D globine'#13+
'ACTIVE=Dejaven'#13+
'FONT OUTLINES=Pisava Obrisa'#13+
'SMOOTH SHADING=Gladko Sen�enje'#13+
'LIGHT=Svetloba'#13+
'Y=Y'#13+
'INTENSITY=Jakost'#13+
'BEVEL=Po�evno Platno'#13+
'FRAME=Okvir'#13+
'ROUND FRAME=Okrogel okvir'#13+
'LOWERED=Zni�an'#13+
'RAISED=Zvi�an'#13+
'POSITION=Polo�aj'#13+
'SYMBOLS=Simboli'#13+
'TEXT STYLE=Slog Teksta'#13+
'LEGEND STYLE=Slog legende'#13+
'VERT. SPACING=Vert. Razmik'#13+
'SERIES NAMES=Imena Nizov'#13+
'SERIES VALUES=Vrednosti Nizov'#13+
'LAST VALUES=Zadnje Vrednosti'#13+
'PLAIN=Ravnina'#13+
'LEFT VALUE=Leva Vrednost'#13+
'RIGHT VALUE=Desna Vrednost'#13+
'LEFT PERCENT=Levi Procent'#13+
'RIGHT PERCENT=Desni Procent'#13+
'X VALUE=Vrednost X'#13+
'X AND VALUE=X in Vrednost'#13+
'X AND PERCENT=X in Procent'#13+
'CHECK BOXES=�katle s kljukico'#13+
'DIVIDING LINES=Delilna �rta'#13+
'FONT SERIES COLOR=Barva pisave niza'#13+
'POSITION OFFSET %=Polo�aj ofset %'#13+
'MARGIN=Rob'#13+
'RESIZE CHART=Spremeni velikost Grafa'#13+
'CONTINUOUS=Nadaljevano'#13+
'POINTS PER PAGE=Pik na stran'#13+
'SCALE LAST PAGE=Raz�leni zadnjo stran'#13+
'CURRENT PAGE LEGEND=Legenda trenutne strani'#13+
'PANEL EDITOR=Urejevalnik platna'#13+
'BACKGROUND=Ozadje'#13+
'BORDERS=Robovi'#13+
'BACK IMAGE=Slika v ozadju'#13+
'STRETCH=Raztegni'#13+
'TILE=Naslov'#13+
'BEVEL INNER=Notranjost'#13+
'BEVEL OUTER=Zunanjost'#13+
'MARKS=Oznake'#13+
'DATA SOURCE=Podatkovni vir'#13+
'SORT=Razvrsti'#13+
'CURSOR=Kurzor'#13+
'SHOW IN LEGEND=Poka�i v legendi'#13+
'FORMATS=Formati'#13+
'VALUES=Vrednosti'#13+
'PERCENTS=Procent'#13+
'HORIZONTAL AXIS=Horizontalna Os'#13+
'DATETIME=Datum/�as'#13+
'VERTICAL AXIS=Vertikalna Os'#13+
'ASCENDING=Nara��ajo�e'#13+
'DESCENDING=Padajo�e'#13+
'DRAW EVERY=Ri�i vsakih'#13+
'CLIPPED=Izrezan'#13+
'ARROWS=Pu��ice'#13+
'MULTI LINE=Ve�-�rtno'#13

{$IFDEF LCL}
;  TeeSloveneLanguage.Text:=TeeSloveneLanguage.Text
{$ENDIF}

+
'ALL SERIES VISIBLE=Vidni vsi nizi'#13+
'LABEL=Napis'#13+
'LABEL AND PERCENT=Napis in Procent'#13+
'LABEL AND VALUE=Napis in Vrednost'#13+
'PERCENT TOTAL=Procent Skupaj'#13+
'LABEL AND PERCENT TOTAL=Napis in Procent Skupaj'#13+
'X AND Y VALUES=Vrednosti X in Y'#13+
'MANUAL=Ro�no'#13+
'RANDOM=Naklju�no'#13+
'FUNCTION=Funkcija'#13+
'NEW=Nov'#13+
'EDIT=Uredi'#13+
'PERSISTENT=Stalen'#13+
'ADJUST FRAME=Prilagodi okvir'#13+
'SUBTITLE=Podnaslov'#13+
'SUBFOOT=Pod Noga Strani'#13+
'FOOT=Noga strani'#13+
'VISIBLE WALLS=Vidni Zidovi'#13+
'BACK=Nazaj'#13+
'DIF. LIMIT=Dif. Limit'#13+
'ABOVE=Nad'#13+
'WITHIN=Znotraj'#13+
'BELOW=Spodaj'#13+
'CONNECTING LINES=Povezajo�e �rte'#13+
'BROWSE=Prebrskaj'#13+
'TILED=Uravnote�en'#13+
'INFLATE MARGINS=Odmik od roba'#13+
'SQUARE=Kvadrat'#13+
'DOWN TRIANGLE=Spodnji trikotnik'#13+
'SMALL DOT=Majhna pika'#13+
'GLOBAL=Globalen'#13+
'SHAPES=Oblike'#13+
'BRUSH=�opi�'#13+
'DELAY=Zakasnitev'#13+
'MSEC.=msec.'#13+
'MOUSE ACTION=Akcija Mi�ke'#13+
'MOVE=Premakni'#13+
'CLICK=Klikni'#13+
'DRAW LINE=Nari�i �rto'#13+
'EXPLODE BIGGEST=Razpo�i najve�jega'#13+
'TOTAL ANGLE=Skupen kot'#13+
'GROUP SLICES=Kos skupine'#13+
'BELOW %=Spodaj %'#13+
'BELOW VALUE=Pod vrednostjo Value'#13+
'OTHER=Ostalo'#13+
'PATTERNS=Vzorci'#13+
'SIZE %=Velikost %'#13+
'SERIES DATASOURCE TEXT EDITOR=Tekstovni urejevalnik niz podatkovnih izvirov'#13+
'FIELDS=Polja'#13+
'NUMBER OF HEADER LINES=�tevilo vrstic glave'#13+
'SEPARATOR=Lo�ilec'#13+
'COMMA=Vejica'#13+
'SPACE=Presledek'#13+
'TAB=Tabulator'#13+
'FILE=Datoteka'#13+
'WEB URL=Internet naslov'#13+
'LOAD=Nalagam'#13+
'C LABELS=C Napisi'#13+
'R LABELS=R Napisi'#13+
'C PEN=C Pisalo'#13+
'R PEN=R Pisalo'#13+
'STACK GROUP=Sklad Skupina'#13+
'MULTIPLE BAR=Mnogodelen stolpec'#13+
'SIDE=Stran'#13+
'SIDE ALL=Drug poleg drugega'#13+
'DRAWING MODE=Na�in risanja'#13+
'WIREFRAME=�i�ni okvir'#13+
'DOTFRAME=Pik�ast okvir'#13+
'SMOOTH PALETTE=Gladka paleta'#13+
'SIDE BRUSH=Stranjski �opi�'#13+
'ABOUT TEECHART PRO V7.0=O TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=Vse pravice pridr�ane.'#13+
'VISIT OUR WEB SITE !=Obi��ite na�o spletno stran !'#13+
'TEECHART WIZARD=TeeChart �arovnik'#13+
'SELECT A CHART STYLE=Ozna�i Slog Grafa'#13+
'DATABASE CHART=Graf iz podatkovne baze'#13+
'NON DATABASE CHART=Graf brez podatkovne baze'#13+
'SELECT A DATABASE TABLE=Izberi Podatkovno tabelo'#13+
'ALIAS=Drugo Ime'#13+
'TABLE=Tabela'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Ozna�i �eljena polja za Graf'#13+
'SELECT A TEXT LABELS FIELD=Ozna�i tekstovna polja za Napise'#13+
'CHOOSE THE DESIRED CHART TYPE=Izberi �eljen tip Grafa'#13+
'2D=2D'#13+
'CHART PREVIEW=Predogled Grafa'#13+
'SHOW LEGEND=Poka�i Legendo'#13+
'SHOW MARKS=Poka�i Oznake'#13+
'< BACK=< Nazaj'#13+
'EXPORT CHART=Izvozi graf'#13+
'PICTURE=Slika'#13+
'NATIVE=TeeDatoteka'#13+
'KEEP ASPECT RATIO=Obdr�i videz'#13+
'INCLUDE SERIES DATA=Vklju�i Podatke za Nize'#13+
'FILE SIZE=Velikost datoteke'#13+
'DELIMITER=Omejitelj'#13+
'XML=XML'#13+
'HTML TABLE=HTML Tabela'#13+
'EXCEL=Excel'#13+
'COLON=Dvopi�je'#13+
'INCLUDE=Vklju�i'#13+
'POINT LABELS=Pik�asti Napisi'#13+
'POINT INDEX=Index Pik'#13+
'HEADER=Glava'#13+
'COPY=Kopiraj'#13+
'SAVE=Shrani'#13+
'SEND=Po�lji'#13+
'FUNCTIONS=Funkcije'#13+
'ADX=ADX'#13+
'AVERAGE=Povpre�je'#13+
'BOLLINGER=Delitelj'#13+
'DIVIDE=Deli.'#13+
'EXP. AVERAGE=Exp.Povpre�je.'#13+
'EXP.MOV.AVRG.=Exp.Premikajo�e.Povpre�je'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Premikajo�e povpre�je'#13+
'MULTIPLY=Mno�i'#13+
'R.S.I.=Standardno odstopanje'#13+
'ROOT MEAN SQ.=Stochastik'#13+
'STD.DEVIATION=Standarden odklon'#13+
'STOCHASTIC=Tief'#13+
'SUBTRACT=Od�tej'#13+
'SOURCE SERIES=Izvir Nizov'#13+
'TEECHART GALLERY=TeeChart Galerija'#13+
'DITHER=Natan�nost'#13+
'REDUCTION=Redukcija'#13+
'COMPRESSION=Kompresija'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Najbli�ji'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Sive'#13+
'GRAY SCALE=Gray Scale'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Kvaliteta'#13+
'PERFORMANCE=U�inek'#13+
'QUALITY=Kvaliteta'#13+
'SPEED=Hirost'#13+
'COMPRESSION LEVEL=Stopnja kompresije'#13+
'CHART TOOLS GALLERY=Galerija orodij grafa'#13+
'ANNOTATION=Pripomba'#13+
'AXIS ARROWS=Pu��ice osi'#13+
'COLOR BAND=Barvni trak'#13+
'COLOR LINE=Barvna �rta'#13+
'DRAG MARKS=Oznake potega'#13+
'MARK TIPS=Ozna�i vrhove'#13+
'NEAREST POINT=Najbli�ja to�ka'#13+
'ROTATE=Zavrti'#13+
'YES=Da'#13+

// 6.0

'BEVEL SIZE=Bevel size'#13+
'DELETE ROW=Izbri�i vrstico'#13+
'VOLUME SERIES=Volumen serija'#13+
'SINGLE=Sam'#13+
'REMOVE CUSTOM COLORS=Odstrani barve po meri'#13+
'USE PALETTE MINIMUM=Uporabi minimum palete'#13+
'AXIS MAXIMUM=Najve?ja vrednost osi'#13+
'AXIS CENTER=Srednja vrednosti osi'#13+
'AXIS MINIMUM=Najmanj�a vrednost osi'#13+
'DAILY (NONE)=Dnevno'#13+
'WEEKLY=Tedensko'#13+
'MONTHLY=Mese?no'#13+
'BI-MONTHLY=Dvakrat na mesec'#13+
'QUARTERLY=?etrtletno'#13+
'YEARLY=Letno'#13+
'DATETIME PERIOD=?asovna perioda'#13+
'CASE SENSITIVE='#13+
'DRAG STYLE=Stil potega'#13+
'SQUARED=Kvadratno'#13+
'GRID 3D SERIES='#13+
'DARK BORDER=Temni rob'#13+
'PIE SERIES='#13+
'FOCUS=Fokus'#13+
'EXPLODE='#13+
'FACTOR=Faktor'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Graf iz predloge'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Odpri TeeChart predlogo iz'#13+
'BINARY=Binarno'#13+
'VOLUME OSCILLATOR='#13+
'PIE SLICES=Tortni kos'#13+
'ARROW WIDTH=Dol�ina pu�?ice'#13+
'ARROW HEIGHT=Vi�ina pu�?ice'#13+
'DEFAULT COLOR=Privzeta barva'#13+
'PERIOD=Perioda'#13+
'UP=Gor'#13+
'DOWN=Dol'#13+
'SHADOW EDITOR=Urejevalnik sence'#13+
'CALLOUT=Callout'#13+
'TEXT ALIGNMENT=Poravnava besediila'#13+
'AVAILABLE LANGUAGES=Jeziki'#13+
'CHOOSE A LANGUAGE=Izberi jezik'#13+
'CALCULATE USING=Izra?unaj'#13+
'EVERY NUMBER OF POINTS=vsakih to?k'#13+
'EVERY RANGE=vsako obmo?je'#13+
'INCLUDE NULL VALUES=vlju?i NULL vrednosti'#13+
'INVERTED SCROLL=inverzno skroliranje'#13+
'DATE=Datum'#13+
'ENTER DATE=Vnesi datum'#13+
'ENTER TIME=Vnesi ?as'#13+
'DEVIATION=Deviacija'#13+
'UPPER=Zgornja'#13+
'LOWER=Spodnja'#13+
'NOTHING=Ni?'#13+
'LEFT TRIANGLE=Spodnji trikotnik'#13+
'RIGHT TRIANGLE=Desni trikotnik'#13+
'CONSTANT=Konstanta'#13+
'SHOW LABELS=Poka�i tekst'#13+
'SHOW COLORS=Poka�i barve'#13+
'XYZ SERIES=XYZ serija'#13+
'SHOW X VALUES=Poka�i X vrednost'#13+
'ACCUMULATE=Accumulate'#13+
'STEP=Korak'#13+
'DRAG REPAINT=Drag repaint'#13+
'NO LIMIT DRAG=No limit drag'#13+
'SMOOTH=Meh?anje'#13+
'INTERPOLATE=Interpoliraj'#13+
'START X=ZAcetni X'#13+
'NUM. POINTS=�t. tock'#13+
'SORT BY=Razvrsti po'#13+
'(NONE)=(noben)'#13+
'CALCULATION=Izracun'#13+
'GROUP=Zdru�i'#13+
'WEIGHT=Ute�'#13+
'EDIT LEGEND=Urejevalnik legende'#13+
'FLAT=Plosko'#13+
'DRAW ALL=Ri�i vse'#13+
'IGNORE NULLS=Izpusti NULL vrendnosti'#13+
'OFFSET=Zamik'#13+
'Z %=Z %'#13+
'LIGHT 0=Luc 0'#13+
'LIGHT 1=Luc 1'#13+
'LIGHT 2=Luc 2'#13+
'DRAW STYLE=Na?in risanja'#13+
'POINTS=To?ke'#13+
'DEFAULT BORDER=Privzet rob'#13+
'SEPARATION=Medsebojna razdalja'#13+
'ROUND BORDER=Zaokro�en rob'#13+
'RESIZE PIXELS TOLERANCE=Resize pixels tolerance'#13+
'FULL REPAINT=Full repaint'#13+
'END POINT=End point'#13+
'BAND 1=Pas 1'#13+
'BAND 2=Pas 2'#13+
'TRANSPOSE NOW=Transponiraj zdaj'#13+
'PERIOD 1=Perioda 1'#13+
'PERIOD 2=Perioda 2'#13+
'PERIOD 3=Perioda 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Ekp. crta'#13+
'WEIGHTED=Ute�eno'#13+
'WEIGHTED BY INDEX=Ute�i glede na indeks'#13+
'BOX SIZE=Velikost �katle'#13+
'REVERSAL AMOUNT=Reversal amount'#13+
'PERCENTAGE=Odstotek'#13+
'COMPLETE R.M.S.=Polna R.M.S.'#13+
'BUTTON=Gumb'#13+
'ALL=Vse'#13+
'START AT MIN. VALUE=Zacni pri min. vrednosti'#13+
'EXECUTE !=Po�eni !'#13+
'IMAG. SYMBOL=Imag. symbol'#13+
'SELF STACK=Self stack'#13+
'SIDE LINES=Side lines'#13+
'EXPORT DIALOG=Export dialog'
;
  end;
end;

Procedure TeeSetSlovene;
begin
  TeeCreateSlovene;
  TeeLanguage:=TeeSloveneLanguage;
  TeeSloveneConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeSloveneLanguage);
end.
