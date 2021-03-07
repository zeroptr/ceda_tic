unit TeeFinnish;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeFinnishLanguage:TStringList=nil;

Procedure TeeSetFinnish;
Procedure TeeCreateFinnish;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeFinnishConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 by David Berneda';

  TeeMsg_Test               :='Testaus...';
  TeeMsg_LegendFirstValue   :='Ensimm�isen muuttujan arvon tulee olla > 0';
  TeeMsg_LegendColorWidth   :='Muuttujan v�rin leveyden tulee olla > 0%';
  TeeMsg_SeriesSetDataSource:='Ei rinnakkaiskaaviota alkutietoja varten';
  TeeMsg_SeriesInvDataSource:='Alkutietoja ei ole valittu: %s';
  TeeMsg_FillSample         :='FillSampleValues tulee olla > 0';
  TeeMsg_AxisLogDateTime    :='P�iv�ys-aika-akeli ei voi olla logaritminen';
  TeeMsg_AxisLogNotPositive :='Logaritmisen akselin minimi ja maksimiarvojen tulee olla >= 0';
  TeeMsg_AxisLabelSep       :='Nimi�n erottimen % tulee olla suurempi kuin 0';
  TeeMsg_AxisIncrementNeg   :='Akselin askeleen tulee olla >= 0';
  TeeMsg_AxisMinMax         :='Akselin minimiarvon tulee olla <= maksimiarvo';
  TeeMsg_AxisMaxMin         :='Akselin maksimiarvon tulee olla >= minimiarvo';
  TeeMsg_AxisLogBase        :='Logaritmisen akselin kannan tulee olla >= 2';
  TeeMsg_MaxPointsPerPage   :='Maksimipistem��r�n sivulla tulee olla >= 0';
  TeeMsg_3dPercent          :='3D:ss� efektin prosenttiosuuden tulee olla v�lill� % - %';
  TeeMsg_CircularSeries     :='Sarja ei saa viitata itseens�';
  TeeMsg_WarningHiColor     :='16k tai suurempi v�rien m��r� tarpeen, jotta saataisiin parempi kuva';

  TeeMsg_DefaultPercentOf   :='% %sta';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'%sta';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Akselin otsikko';
  TeeMsg_AxisLabels         :='Akselin nimi�t';
  TeeMsg_RefreshInterval    :='Virkistysv�lin tulee olla v�lill� 0 - 60';
  TeeMsg_SeriesParentNoSelf :='Sarjat.Rinnakkaiskaavio ei ole min� itse!';
  TeeMsg_GalleryLine        :='Viiva';
  TeeMsg_GalleryPoint       :='Piste';
  TeeMsg_GalleryArea        :='Pinta-ala';
  TeeMsg_GalleryBar         :='Pylv�s';
  TeeMsg_GalleryHorizBar    :='Vaakapylv�s';
  TeeMsg_Stack              :='Pino';
  TeeMsg_GalleryPie         :='Piirakka';
  TeeMsg_GalleryCircled     :='Ympyr�ity';
  TeeMsg_GalleryFastLine    :='Pikaviiva';
  TeeMsg_GalleryHorizLine   :='Vaakaviiva';

  TeeMsg_PieSample1         :='Autot';
  TeeMsg_PieSample2         :='Puhelimet';
  TeeMsg_PieSample3         :='P�yd�t';
  TeeMsg_PieSample4         :='Monitorit';
  TeeMsg_PieSample5         :='Lamput';
  TeeMsg_PieSample6         :='N�pp�imist�t';
  TeeMsg_PieSample7         :='Py�r�t';
  TeeMsg_PieSample8         :='Tuolit';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editoi %s';

  TeeMsg_GalleryStandard    :='Standardi';
  TeeMsg_GalleryExtended    :='Laajennettu';
  TeeMsg_GalleryFunctions   :='Functiot';

  TeeMsg_EditChart          :='E&ditoi kaaviota...';
  TeeMsg_PrintPreview       :='&Esikatselu...';
  TeeMsg_ExportChart        :='&Vie kaavio...';
  TeeMsg_CustomAxes         :='Muokkaa akselia...';

  TeeMsg_InvalidEditorClass :='%s: Ep�kelpo editoriluokka: %s';
  TeeMsg_MissingEditorClass :='%s:ll� ei ole editorin viesti�';

  TeeMsg_GalleryArrow       :='Nuoli';

  TeeMsg_ExpFinish          :='&Loppu';
  TeeMsg_ExpNext            :='&Seuraava >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Muokkaus';
  TeeMsg_GanttSample2       :='Prototypin teko';
  TeeMsg_GanttSample3       :='Kehitt�minen';
  TeeMsg_GanttSample4       :='Myynti';
  TeeMsg_GanttSample5       :='Markkinointi';
  TeeMsg_GanttSample6       :='Testaus';
  TeeMsg_GanttSample7       :='Valmistus';
  TeeMsg_GanttSample8       :='Virheiden etsint�';
  TeeMsg_GanttSample9       :='Uusi versio';
  TeeMsg_GanttSample10      :='Pankkitoiminta';

  TeeMsg_ChangeSeriesTitle  :='Muuta sarjan otsikkoa';
  TeeMsg_NewSeriesTitle     :='Uusi sarjan otsikko:';
  TeeMsg_DateTime           :='Pvm/aika';
  TeeMsg_TopAxis            :='Yl�akseli';
  TeeMsg_BottomAxis         :='Ala-akseli';
  TeeMsg_LeftAxis           :='Vasen akseli';
  TeeMsg_RightAxis          :='Oikea akseli';

  TeeMsg_SureToDelete       :='Poistatko %n?';
  TeeMsg_DateTimeFormat     :='Pvm/aika-for&maatti:';
  TeeMsg_Default            :='Oletus';
  TeeMsg_ValuesFormat       :='Arvojen for&maatti:';
  TeeMsg_Maximum            :='Maksimi';
  TeeMsg_Minimum            :='Minimi';
  TeeMsg_DesiredIncrement   :='Haluttu %s askellis�ys';

  TeeMsg_IncorrectMaxMinValue:='V��r� arvo. Syy: %s';
  TeeMsg_EnterDateTime      :='Anna [p�ivien lukum��r�] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='K�yt�tk� muutoksia?';
  TeeMsg_SelectedSeries     :='(Valittu sarja)';
  TeeMsg_RefreshData        :='&P�ivit� Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Lis��';
  TeeMsg_FunctionSubtract   :='V�henn�';
  TeeMsg_FunctionMultiply   :='Kerro';
  TeeMsg_FunctionDivide     :='Jaa';
  TeeMsg_FunctionHigh       :='Yl�arvo';
  TeeMsg_FunctionLow        :='Ala-arvo';
  TeeMsg_FunctionAverage    :='Keskiarvo';

  TeeMsg_GalleryShape       :='Muoto';
  TeeMsg_GalleryBubble      :='Kupla';
  TeeMsg_FunctionNone       :='Kopioi';
//  TeeMsg_AxisDlgValue       :='Arvo:';

  TeeMsg_None               :='(ei mit��n)';

  TeeMsg_PrivateDeclarations:='{ Henkil�kohtaiset esittelyt }';
  TeeMsg_PublicDeclarations :='{ Julkiset esittelyt }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Osoittimen koon tulee olla nollaa suurempi';
  TeeMsg_About              :='TeeChart''ista...';

  tcAdditional              :='Lis�';
  tcDControls               :='Datan ohjaimet';
  tcQReport                 :='QRaportti';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Yksitt�inen tietue';
  TeeMsg_AskDataSource      :='&Datan alkuper�:';

  TeeMsg_Summary            :='Yhteenveto';

  TeeMsg_FunctionPeriod     :='Funktion ajanjakson tulee olla >= 0';

  TeeMsg_WizardTab          :='Liikeala';
  TeeMsg_TeeChartWizard     :='TeeChart apuri';

  TeeMsg_ClearImage         :='Tyhjenn�';
  TeeMsg_BrowseImage        :='Selaa...';

  TeeMsg_WizardSureToClose  :='Oletko varma ett� haluat sulkea TeeChart apurin?';
  TeeMsg_FieldNotFound      :='Kentt�� %s ei ole';

  TeeMsg_DepthAxis          :='Syvyysakseli';
  TeeMsg_PieOther           :='Muu';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Piirakka';
  TeeMsg_ValuesBar          :='Pylv�s';
  TeeMsg_ValuesAngle        :='Kulma';
  TeeMsg_ValuesGanttStart   :='Alku';
  TeeMsg_ValuesGanttEnd     :='Loppu';
  TeeMsg_ValuesGanttNextTask:='Seuraava teht�v�';
  TeeMsg_ValuesBubbleRadius :='S�de';
  TeeMsg_ValuesArrowEndX    :='Loppu X';
  TeeMsg_ValuesArrowEndY    :='Loppu Y';
  TeeMsg_Legend             :='Selite';
  TeeMsg_Title              :='Otsikko';
  TeeMsg_Foot               :='Alatunniste';
  TeeMsg_Period		    :='Jakso';
  TeeMsg_PeriodRange        :='Jaksoalue';
  TeeMsg_CalcPeriod         :='Laske %s jokainen:';
  TeeMsg_SmallDotsPen       :='Pienet t�pl�t';

  TeeMsg_InvalidTeeFile     :='Ep�kelpo kaavio *.'+TeeMsg_TeeExtension+' tiedostossa';
  TeeMsg_WrongTeeFileFormat :='V��r� *.'+TeeMsg_TeeExtension+' tiedostomuoto';
  TeeMsg_EmptyTeeFile       :='Tyhj� *.'+TeeMsg_TeeExtension+' tiedosto';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Kaavion akselit';
  TeeMsg_ChartAxesCategoryDesc   := 'Kaavion akselin ominaisuudet ja tapahtumat';
  TeeMsg_ChartWallsCategoryName  := 'Kaavion sein�t';
  TeeMsg_ChartWallsCategoryDesc  := 'Kaavion seinien ominaisuudet ja tapahtumat';
  TeeMsg_ChartTitlesCategoryName := 'Kaavion otsikot';
  TeeMsg_ChartTitlesCategoryDesc := 'Kaavion otsikkojen ominaisuudet ja tapahtumat';
  TeeMsg_Chart3DCategoryName     := '3D-kaavio';
  TeeMsg_Chart3DCategoryDesc     := '3D-kaavion ominaisuudet ja tapahtumat';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Muokkaa ';
  TeeMsg_Series                 :='Sarjaa';
  TeeMsg_SeriesList             :='Sarjaa...';

  TeeMsg_PageOfPages            :='Sivu %d of %d';
  TeeMsg_FileSize               :='%d tavua';

  TeeMsg_First  :='Ensimm�inen';
  TeeMsg_Prior  :='Edellinen';
  TeeMsg_Next   :='Seuraava';
  TeeMsg_Last   :='Viimeinen';
  TeeMsg_Insert :='Lis��';
  TeeMsg_Delete :='Poista';
  TeeMsg_Edit   :='Muokkaa';
  TeeMsg_Post   :='Merkitse';
  TeeMsg_Cancel :='Peruuta';

  TeeMsg_All    :='(kaikki)';
  TeeMsg_Index  :='Indeksi';
  TeeMsg_Text   :='Teksti';

  TeeMsg_AsBMP        :='&Bittikarttana';
  TeeMsg_BMPFilter    :='Bittikartat (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='&Metatiedosto';
  TeeMsg_EMFFilter    :='Laajennetut metatiedostot (*.emf)|*.emf|Metatiedostot (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Taulun arvoa ei ole asetettu vientimuotoon';

  TeeMsg_Normal    :='Normaali';
  TeeMsg_NoBorder  :='Ei kehyst�';
  TeeMsg_Dotted    :='Pisteviiva';
  TeeMsg_Colors    :='V�rit';
  TeeMsg_Filled    :='T�ytetty';
  TeeMsg_Marks     :='Merkit';
  TeeMsg_Stairs    :='Portaat';
  TeeMsg_Points    :='Pisteet';
  TeeMsg_Height    :='Korkeus';
  TeeMsg_Hollow    :='Ontto';
  TeeMsg_Point2D   :='2D piste';
  TeeMsg_Triangle  :='Kolmio';
  TeeMsg_Star      :='T�hti';
  TeeMsg_Circle    :='Ympyr�';
  TeeMsg_DownTri   :='Kolmio k�rjell�';
  TeeMsg_Cross     :='Risti';
  TeeMsg_Diamond   :='Timantti';
  TeeMsg_NoLines   :='Ei viivoja';
  TeeMsg_Stack100  :='Pino 100%';
  TeeMsg_Pyramid   :='Pyramidi';
  TeeMsg_Ellipse   :='Ellipsi';
  TeeMsg_InvPyramid:='K��nt. pyramidi';
  TeeMsg_Sides     :='Reunat';
  TeeMsg_SideAll   :='Reunat joka puolelle';
  TeeMsg_Patterns  :='Kuviot';
  TeeMsg_Exploded  :='Levitetty';
  TeeMsg_Shadow    :='Varjo';
  TeeMsg_SemiPie   :='Piirakan puolikas';
  TeeMsg_Rectangle :='Suorakulmio';
  TeeMsg_VertLine  :='Pystyviiva';
  TeeMsg_HorizLine :='Vaakaviiva';
  TeeMsg_Line      :='Viiva';
  TeeMsg_Cube      :='Kuutio';
  TeeMsg_DiagCross :='Vinoristi';

  TeeMsg_CanNotFindTempPath    :='Temp-hakemistoa ei l�ydy';
  TeeMsg_CanNotCreateTempChart :='Ei voi luoda Temp-tiedostoa';
  TeeMsg_CanNotEmailChart      :='Ei voi l�hett�� TeeChart''ia s�hk�postissa. Mapi Virhe: %d';

  TeeMsg_SeriesDelete :='Sarjan poisto: Indexin %d arvo rajojen (0 to %d)ulkopuolella.';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='&JPEG:in�';
  TeeMsg_JPEGFilter    :='JPEG-tiedostot (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='&GIF:in�';
  TeeMsg_GIFFilter     :='GIF-tiedostot (*.gif)|*.gif';
  TeeMsg_AsPNG         :='&PNG:n�';
  TeeMsg_PNGFilter     :='PNG-tiedostot (*.png)|*.png';
  TeeMsg_AsPCX         :='PC&X:n�';
  TeeMsg_PCXFilter     :='PCX tiedostot (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='&VML:n� (HTM)';
  TeeMsg_VMLFilter     :='VML-tiedostot (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Kieli...';

  { 5.03 }
  TeeMsg_Gradient     :='Gradientti';
  TeeMsg_WantToSave   :='Haluatko tallentaa %s?';
  TeeMsg_NativeFilter :='TeeChart-tiedostot';

  TeeMsg_Property     :='Ominaisuus';
  TeeMsg_Value        :='Arvo';
  TeeMsg_Yes          :='Kyll�';
  TeeMsg_No           :='Ei';
  TeeMsg_Image        :='(kuva)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polaarinen';
  TeeMsg_GalleryCandle      :='Kynttil�';
  TeeMsg_GalleryVolume      :='Tilavuus';
  TeeMsg_GallerySurface     :='Pinta';
  TeeMsg_GalleryContour     :='��riviiva';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='3D piste';
  TeeMsg_GalleryRadar       :='Tutka';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Kursori';
  TeeMsg_GalleryBar3D       :='3D pylv�s';
  TeeMsg_GalleryBigCandle   :='Suuri kynttil�';
  TeeMsg_GalleryLinePoint   :='Viiva piste';
  TeeMsg_GalleryHistogram   :='Histogrammi';
  TeeMsg_GalleryWaterFall   :='Vesiputous';
  TeeMsg_GalleryWindRose    :='Tuuliruusu';
  TeeMsg_GalleryClock       :='Kello';
  TeeMsg_GalleryColorGrid   :='V�riGrid';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='Bar Join';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramidi';
  TeeMsg_GalleryMap         :='Kartta';

  TeeMsg_PolyDegreeRange    :='Polynomin asteen tulee olla v�lill� 1 - 20';
  TeeMsg_AnswerVectorIndex   :='Vastausvektorin indeksin tulee olla v�lill� 1 - %d';
  TeeMsg_FittingError        :='Ei voi jatkaa korjausta';
  TeeMsg_PeriodRange         :='Jakson tulee olla >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage-arvon tulee olla v�lill� 0 - 1';
  TeeMsg_GalleryErrorBar     :='Virhepylv�s';
  TeeMsg_GalleryError        :='Virhe';
  TeeMsg_GalleryHighLow      :='Suuri-Pieni';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum jako';
  TeeMsg_FunctionExpAverage  :='Exp. keskiarvo';
  TeeMsg_FunctionMovingAverage:='Liukuva keskiarvo';
  TeeMsg_FunctionExpMovAve   :='Exp.liuk.keskia.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='K�yr�n sovitus';
  TeeMsg_FunctionTrend       :='Trendi';
  TeeMsg_FunctionExpTrend    :='Exp.trendi';
  TeeMsg_FunctionLogTrend    :='Log.trendi';
  TeeMsg_FunctionCumulative  :='Kertym�';
  TeeMsg_FunctionStdDeviation:='Std.poikkeama';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stokastinen';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Lasku';
  TeeMsg_LoadChart           :='Avaa TeeChart...';
  TeeMsg_SaveChart           :='Tallenna TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro-tiedostot';

  TeeMsg_GallerySamples      :='Muut';
  TeeMsg_GalleryStats        :='Statistiikka';

  TeeMsg_CannotFindEditor    :='Sarjaeditori-ikkunaa: %s ei l�ydy';


  TeeMsg_CannotLoadChartFromURL:='Virhekoodi: %d kaaviota ladatessa URLst�: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Virhekoodi: %d sarjan dataa ladatessa URLst�: %s';

  TeeMsg_ValuesDate          :='P�iv�ys';
  TeeMsg_ValuesOpen          :='Avaa';
  TeeMsg_ValuesHigh          :='Korkea';
  TeeMsg_ValuesLow           :='Matala';
  TeeMsg_ValuesClose         :='Sulje';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='StdVirhe';

  TeeMsg_Grid3D              :='3D hila';

  TeeMsg_LowBezierPoints     :='Bezier-pisteiden m��r�n tulee olla > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normaali';
  TeeCommanMsg_Edit     :='Editointi';
  TeeCommanMsg_Print    :='Tulosta';
  TeeCommanMsg_Copy     :='Kopioi';
  TeeCommanMsg_Save     :='Tallenna';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Py�ritys: %d� Nousu: %d�';
  TeeCommanMsg_Rotate   :='Py�rit�';

  TeeCommanMsg_Moving   :='Vaakasuuntainen.Offset: %d Pystysuuntainen.Offset: %d';
  TeeCommanMsg_Move     :='Siirr�';

  TeeCommanMsg_Zooming  :='Zoomaa: %d %%';
  TeeCommanMsg_Zoom     :='Zoomaa';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Syvyys';

  TeeCommanMsg_Chart    :='Kaavio';
  TeeCommanMsg_Panel    :='Taulu';

  TeeCommanMsg_RotateLabel:='Ved� %s py�ritt��ksesi';
  TeeCommanMsg_MoveLabel  :='Ved� %s liikuttaaksesi';
  TeeCommanMsg_ZoomLabel  :='Ved� %s zoomataksesi';
  TeeCommanMsg_DepthLabel :='Ved� %s muuttaaksesi 3D kokoa';

  TeeCommanMsg_NormalLabel:='Ved� vasemmalla painikkeella zoomataksesi, oikealla vieritt��ksesi';
  TeeCommanMsg_NormalPieLabel:='Ved� piirakan viipaletta irroittaaksesisen';

  TeeCommanMsg_PieExploding :='Viipale: %d irrotettu: %d %%';

  TeeMsg_TriSurfaceLess        :='Pisteiden m��r�n tulee olla >= 4';
  TeeMsg_TriSurfaceAllColinear :='Kaikki datapisteet kolineaarisia';
  TeeMsg_TriSurfaceSimilar     :='Samanlaiset pisteet - ei voi suorittaa';
  TeeMsg_GalleryTriSurface     :='Kolmiopinta';

  TeeMsg_AllSeries :='Kaikki sarjat';
  TeeMsg_Edit      :='Editoi';

  TeeMsg_GalleryFinancial    :='Finanssinen';

  TeeMsg_CursorTool    :='Kursori';
  TeeMsg_DragMarksTool :='Ved� merkit';
  TeeMsg_AxisArrowTool :='Akselinuolet';
  TeeMsg_DrawLineTool  :='Piirr� viiva';
  TeeMsg_NearestTool   :='L�hin piste';
  TeeMsg_ColorBandTool :='V�rinauha';
  TeeMsg_ColorLineTool :='Color Line';
  TeeMsg_RotateTool    :='Py�rit�';
  TeeMsg_ImageTool     :='Kuva';
  TeeMsg_MarksTipTool  :='Merkkivihjeet';
  TeeMsg_AnnotationTool:='Selitys';

  TeeMsg_CantDeleteAncestor  :='Ei voi poistaa l�hdett��n';

  TeeMsg_Load	          :='Lataa...';
//  TeeMsg_WinInet          :='(WinInet.dll to access TeeChart)';
  TeeMsg_NoSeriesSelected :='Sarjaa ei valittu';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Kaavio';
  TeeMsg_CategorySeriesActions :='Kaavion sarja';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Vaihda 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Aktiivinen';
  TeeMsg_ActionSeriesActiveHint := 'N�yt� / piilota sarja';
  TeeMsg_ActionEditHint         := 'Editoi kaaviota';
  TeeMsg_ActionEdit             := '&Editoi...';
  TeeMsg_ActionCopyHint         := 'Kopioi leikep�yd�lle';
  TeeMsg_ActionCopy             := '&Kopioi';
  TeeMsg_ActionPrintHint        := 'Tulosta esikatselukaavio';
  TeeMsg_ActionPrint            := '&Tulostaa...';
  TeeMsg_ActionAxesHint         := 'N�yt� / piilota akselit';
  TeeMsg_ActionAxes             := '&Akselit';
  TeeMsg_ActionGridsHint        := 'N�yt� / piilota ruudukko';
  TeeMsg_ActionGrids            := '&Ruudukko';
  TeeMsg_ActionLegendHint       := 'N�yt� / piilota selite';
  TeeMsg_ActionLegend           := '&Selite';
  TeeMsg_ActionSeriesEditHint   := 'Editoi sarjaa';
  TeeMsg_ActionSeriesMarksHint  := 'N�yt� / piilota sarjan merkit';
  TeeMsg_ActionSeriesMarks      := '&Merkit';
  TeeMsg_ActionSaveHint         := 'Tallenna kaavio';
  TeeMsg_ActionSave             := '&Tallentaa...';

  TeeMsg_CandleBar              := 'Pylv�s';
  TeeMsg_CandleNoOpen           := 'Ei auki';
  TeeMsg_CandleNoClose          := 'Ei suljettu';
  TeeMsg_NoHigh                 := 'Ei yl�arvoa';
  TeeMsg_NoLow                  := 'Ei ala-arvoa';
  TeeMsg_ColorRange             := 'V�rialue';
  TeeMsg_WireFrame              := 'Lankamalli';
  TeeMsg_DotFrame               := 'Pistemalli';
  TeeMsg_Positions              := 'Paikat';
  TeeMsg_NoGrid                 := 'Ei ruudukkoa';
  TeeMsg_NoPoint                := 'Ei pistett�';
  TeeMsg_NoLine                 := 'Ei viivaa';
  TeeMsg_Labels                 := 'Nimi�t';
  TeeMsg_NoCircle               := 'Ei ympyr��';
  TeeMsg_Lines                  := 'Viivat';
  TeeMsg_Border                 := 'Raja';

  TeeMsg_SmithResistance      := 'Vastus';
  TeeMsg_SmithReactance       := 'Reaktanssi';

  TeeMsg_Column               := 'Sarake';

  { 5.01 }
  TeeMsg_Separator            := 'Erotin';
  TeeMsg_FunnelSegment        := 'Segmentti ';
  TeeMsg_FunnelSeries         := 'Suppilo';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Ylitt�� osuuden';
  TeeMsg_FunnelWithin         := ' osuuden sis�ll�';
  TeeMsg_FunnelBelow          := ' tai enemm�n alle osuuden';
  TeeMsg_CalendarSeries       := 'Kalenteri';
  TeeMsg_DeltaPointSeries     := 'Deltapiste';
  TeeMsg_ImagePointSeries     := 'Kuvapiste';
  TeeMsg_ImageBarSeries       := 'Kuvapylv�s';
  TeeMsg_SeriesTextFieldZero  := 'Sarjan teksti: Kentt�indeksin tulee olla nollaa suurempi.';

  { 5.02 }
  TeeMsg_Origin               := 'Alkuper�';
  TeeMsg_Transparency         := 'L�pin�kyvyys';
  TeeMsg_Box		      := 'Laatikko';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Sivunumero';
  TeeMsg_TextFile             := 'Tekstitiedosto';

  { 5.03 }
  TeeMsg_DragPoint            := 'Ved� piste';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';
end;

Procedure TeeCreateFinnish;
begin
  if not Assigned(TeeFinnishLanguage) then
  begin
    TeeFinnishLanguage:=TStringList.Create;
    TeeFinnishLanguage.Text:=

'LABELS=Tunnisteet'+#13+
'DATASET=Tiedostos'+#13+
'ALL RIGHTS RESERVED.=Kaikki oikeudet pid�tet��n.'+#13+
'APPLY=K�yt�'+#13+
'CLOSE=Sulje'+#13+
'OK=OK'+#13+
'ABOUT TEECHART PRO V7.0=TeeChart Pro v7.0 ohjelmasta'+#13+
'OPTIONS=Vaihtoehdot'+#13+
'FORMAT=Muoto'+#13+
'TEXT=Teksti'+#13+
'GRADIENT=Gradientti'+#13+
'SHADOW=Varjo'+#13+
'POSITION=Paikka'+#13+
'LEFT=Vasen'+#13+
'TOP=Yl�'+#13+
'CUSTOM=R��t�l�i.'+#13+
'PEN=Kyn�'+#13+
'PATTERN=Kuvio'+#13+
'SIZE=Koko'+#13+
'BEVEL=Vino'+#13+
'INVERTED=K��nteinen'+#13+
'INVERTED SCROLL=K��nteinen vieritys'+#13+
'BORDER=Reuna'+#13+
'ORIGIN=Alkuper�'+#13+
'USE ORIGIN=K�yt� alkuper�ist�'+#13+
'AREA LINES=Pintaviivat'+#13+
'AREA=Pinta'+#13+
'COLOR=V�ri'+#13+
'SERIES=Sarjat'+#13+
'SUM=Summa'+#13+
'DAY=P�iv�'+#13+
'QUARTER=Nelj�nnes'+#13+
'(MAX)=(maks)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=N�kyv�'+#13+
'CURSOR=kursori'+#13+
'GLOBAL=Yleis'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Vaakaviiva'+#13+
'LABEL AND PERCENT=Nimi� ja prosentti'+#13+
'LABEL AND VALUE=Nimi� ja arvo'+#13+
'LABEL AND PERCENT TOTAL=Nimi� ja kokonaisprosentti'+#13+
'PERCENT TOTAL=Kokonaisprosentti'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=V�henn�'+#13+
'MULTIPLY=Kerro'+#13+
'DIVIDE=Jaa'+#13+
'STAIRS=Portaat'+#13+
'MOMENTUM=Voima'+#13+
'AVERAGE=Keskiarvo'+#13+
'XML=XML'+#13+
'HTML TABLE=HTML taulukko'+#13+
'EXCEL=Excel'+#13+
'NONE=Ei mit��n'+#13+
'(NONE)=Ei mit��n'#13+
'WIDTH=Leveys'+#13+
'HEIGHT=Korkeus'+#13+
'COLOR EACH=V�rit� jokainen'+#13+
'STACK=Pino'+#13+
'STACKED=Pinottu'+#13+
'STACKED 100%=Pinottu 100%'+#13+
'AXIS=Akseli'+#13+
'LENGTH=Pituus'+#13+
'CANCEL=Peruuta'+#13+
'SCROLL=Vierit�'+#13+
'INCREMENT=Askellis�ys'+#13+
'VALUE=Arvo'+#13+
'STYLE=Tyyli'+#13+
'JOIN=Liit�'+#13+
'AXIS INCREMENT=Akselin askellis�ys'+#13+
'AXIS MAXIMUM AND MINIMUM=Akselin maksimi ja minimi'+#13+
'% BAR WIDTH=Pylv��n leveys %'+#13+
'% BAR OFFSET=Pylv��n offset %'+#13+
'BAR SIDE MARGINS=Pylv��n sivumarginaalit'+#13+
'AUTO MARK POSITION=Automaattinen paikan merkint�.'+#13+
'DARK BAR 3D SIDES=Tummat 3D sivut'+#13+
'MONOCHROME=Yksiv�rinen'+#13+
'COLORS=V�rit'+#13+
'DEFAULT=Oletus'+#13+
'MEDIAN=Mediaani'+#13+
'IMAGE=Kuva'+#13+
'DAYS=P�iv�t'+#13+
'WEEKDAYS=Viikonp�iv�t'+#13+
'TODAY=T�n��n'+#13+
'SUNDAY=Sunnuntai'+#13+
'MONTHS=Kuukaudet'+#13+
'LINES=Viivat'+#13+
'UPPERCASE=Yl�indeksi'+#13+
'STICK=Keppi'+#13+
'CANDLE WIDTH=Kynttil�n leveys'+#13+
'BAR=Pylv�s'+#13+
'OPEN CLOSE=Avaa Sulje'+#13+
'DRAW 3D=Piirr� 3D'+#13+
'DARK 3D=Tumma 3D'+#13+
'SHOW OPEN=N�yt� Avaa'+#13+
'SHOW CLOSE=N�yt� Sulje'+#13+
'UP CLOSE=Ul�s Sulje'+#13+
'DOWN CLOSE=Alas sulje'+#13+
'CIRCLED=Ympyr�ity'+#13+
'CIRCLE=Ympyr�'+#13+
'3 DIMENSIONS=3 dimensiot'+#13+
'ROTATION=Py�ritys'+#13+
'RADIUS=S�de'+#13+
'HOURS=Tunnit'+#13+
'HOUR=Tunti'+#13+
'MINUTES=Minuutit'+#13+
'SECONDS=Sekunnit'+#13+
'FONT=Fontti'+#13+
'INSIDE=Sis�osa'+#13+
'ROTATED=Py�ritetty'+#13+
'ROMAN=Roman'+#13+
'TRANSPARENCY=L�pin�kyvyys'+#13+
'DRAW BEHIND=Piirr� taakse'+#13+
'RANGE=Alue'+#13+
'PALETTE=Paletti'+#13+
'STEPS=Askeleet'+#13+
'GRID=Ruudukko'+#13+
'GRID SIZE=Ruudukon koko'+#13+
'ALLOW DRAG=Salli vet�minen'+#13+
'AUTOMATIC=Automattinen'+#13+
'LEVEL=Taso'+#13+
'LEVELS POSITION=Tasojen paikka'+#13+
'SNAP=Snap'+#13+
'FOLLOW MOUSE=Seuraa hiirt�'+#13+
'TRANSPARENT=L�pin�kyv�'+#13+
'ROUND FRAME=Py�ristetty kehys'+#13+
'FRAME=Kehys'+#13+
'START=Alku'+#13+
'END=Loppu'+#13+
'MIDDLE=Keski'+#13+
'NO MIDDLE=Ei keskustaa'+#13+
'DIRECTION=Suunta'+#13+
'DATASOURCE=Tietol�hde'+#13+
'AVAILABLE=K�ytett�viss�'+#13+
'SELECTED=Valittu'+#13+
'CALC=Laske'+#13+
'GROUP BY=Ryhmittele'+#13+
'OF=sta'+#13+
'HOLE %=reik� %'+#13+
'RESET POSITIONS=Palauta paikat'+#13+
'MOUSE BUTTON=Hiiripainike'+#13+
'ENABLE DRAWING=Salli piirt�minen'+#13+
'ENABLE SELECT=Salli valinta'+#13+
'ORTHOGONAL=Ortogonaalinen'+#13+
'ANGLE=Kulma'+#13+
'ZOOM TEXT=Zoomaa teksti�'+#13+
'PERSPECTIVE=Perspektiivi'+#13+
'ZOOM=Zoomaa'+#13+
'ELEVATION=Korkeus'+#13+
'BEHIND=Takana'+#13+
'AXES=Akselit'+#13+
'SCALES=Skaalat'+#13+
'TITLE=Otsikko'+#13+
'TICKS=Merkit'+#13+
'MINOR=Pinemm�t'+#13+
'CENTERED=Keskitetty'+#13+
'CENTER=Keskus'+#13+
'PATTERN COLOR EDITOR=Kuvion v�rin editori'+#13+
'START VALUE=L�ht�arvo'+#13+
'END VALUE=Loppuarvo'+#13+
'COLOR MODE=V�rityyppi'+#13+
'LINE MODE=Viivatyyppi'+#13+
'HEIGHT 3D=Korkeus 3D'+#13+
'OUTLINE=Ymp�rysviiva'+#13+
'PRINT PREVIEW=Tulostuksen esikatselu'+#13+
'ANIMATED=Animoitu'+#13+
'ALLOW=Salli'+#13+
'DASH=Viiva'+#13+
'DOT=Piste'+#13+
'DASH DOT DOT=Viiva-piste-piste'+#13+
'PALE=Kelme�'+#13+
'STRONG=Vahva'+#13+
'WIDTH UNITS=Leveysyksik�t'+#13+
'FOOT=Tunniste'+#13+
'SUBFOOT=Alatunniste'+#13+
'SUBTITLE=Alaotsikko'+#13+
'LEGEND=Selite'+#13+
'COLON=Kaksoispiste'+#13+
'AXIS ORIGIN=Akselin alkuper�'+#13+
'UNITS=Yksik�t'+#13+
'PYRAMID=Pyramidi'+#13+
'DIAMOND=Timantti'+#13+
'CUBE=Kuutio'+#13+
'TRIANGLE=Kolmio'+#13+
'STAR=T�hti'+#13+
'SQUARE=Neli�'+#13+
'DOWN TRIANGLE=Kolmio k�rjell�'+#13+
'SMALL DOT=Pieni piste'+#13+
'LOAD=Lataa'+#13+
'FILE=Tiedosto'+#13+
'RECTANGLE=Suorakulmio'+#13+
'HEADER=Otsikko'+#13+
'CLEAR=Tyhjenn�'+#13+
'ONE HOUR=Tunti'+#13+
'ONE YEAR=Vuosi'+#13+
'ELLIPSE=Ellipsi'+#13+
'CONE=Kartio'+#13+
'ARROW=Nuoli'+#13+
'CYLLINDER=Sylinteri'+#13+
'TIME=Tunti'+#13+
'BRUSH=Sivellin'+#13+
'LINE=Viiva'+#13+
'VERTICAL LINE=Vaakaviiva'+#13+
'AXIS ARROWS=Akselinuolet'+#13+
'MARK TIPS=Merkkivihjeet'+#13+
'DASH DOT=Viiva-piste'+#13+
'COLOR BAND=V�rinauha'+#13+
'COLOR LINE=V�riviiva'+#13+
'INVERT. TRIANGLE=K��nteinen kolmio'+#13+
'INVERT. PYRAMID=K��nteinen pyramidi'+#13+
'INVERTED PYRAMID=K��nteinen pyramidi'+#13+
'SERIES DATASOURCE TEXT EDITOR=Sarjan datal�hteen tekstieditori'+#13+
'SOLID=Ehyt'+#13+
'WIREFRAME=Lankamalli'+#13+
'DOTFRAME=Pistemalli'+#13+
'SIDE BRUSH=Reunasivellin'+#13+
'SIDE=Reuna'+#13+
'SIDE ALL=Kaikki reunat'+#13+
'ROTATE=Py�rit�'+#13+
'SMOOTH PALETTE=Liukupaletti'+#13+
'CHART TOOLS GALLERY=Kaavioty�kalujen valikoima'+#13+
'ADD=Lis��'+#13+
'BORDER EDITOR=Reunaeditori'+#13+
'DRAWING MODE=Piirtotapa'+#13+
'CLOSE CIRCLE=Sulje ympyr�'+#13+
'PICTURE=Kuva'+#13+
'NATIVE=Alkuper�inen'+#13+
'DATA=Data'+#13+
'KEEP ASPECT RATIO=S�ilyt� muoto'+#13+
'COPY=Kopioi'+#13+
'SAVE=Tallenna'+#13+
'SEND=L�het�'+#13+
'INCLUDE SERIES DATA=Sis�llyt� datatiedot'+#13+
'FILE SIZE=Tiedoston koko'+#13+
'INCLUDE=Sis�llyt�'+#13+
'POINT INDEX=Pisteindeksi'+#13+
'POINT LABELS=Pistenimi�t'+#13+
'DELIMITER=Erotin'+#13+
'DEPTH=Syvyys'+#13+
'COMPRESSION LEVEL=Pakkausaste'+#13+
'COMPRESSION=Pakkaus'+#13+
'PATTERNS=Kuviot'+#13+
'LABEL=Nimi�'+#13+
'GROUP SLICES=Palaryhm�t'+#13+
'EXPLODE BIGGEST=Irrota suurin'+#13+
'TOTAL ANGLE=Kokonaiskulma'+#13+
'HORIZ. SIZE=Vaakas. koko'+#13+
'VERT. SIZE=Pystys. koko'+#13+
'SHAPES=Muodot'+#13+
'INFLATE MARGINS=Sovita marginaalit'+#13+
'QUALITY=Laatu'+#13+
'SPEED=Nopeus'+#13+
'% QUALITY=% laatu'+#13+
'GRAY SCALE=Harmaa-asteikko'+#13+
'PERFORMANCE=Suorityskyky'+#13+
'BROWSE=Selaa'+#13+
'TILED=Mosaiikki'+#13+
'HIGH=Korkea'+#13+
'LOW=Matala'+#13+
'DATABASE CHART=Tietokantakaavio'+#13+
'NON DATABASE CHART=Ei tietokantakaavio'+#13+
'HELP=Apua'+#13+
'NEXT >=Seuraava >'+#13+
'< BACK=< Takaisin'+#13+
'TEECHART WIZARD=TeeChartin apuri'+#13+
'PERCENT=Prosenttinen'+#13+
'PIXELS=Pikselit'+#13+
'ERROR WIDTH=Virheen leveys'+#13+
'ENHANCED=Laajennettu'+#13+
'VISIBLE WALLS=N�kyv�t sein�t'+#13+
'ACTIVE=Aktiivinen'+#13+
'DELETE=Poista'+#13+
'ALIGNMENT=Tasaus'+#13+
'ADJUST FRAME=S��d� reunus'+#13+
'HORIZONTAL=Vaaka'+#13+
'VERTICAL=Pysty'+#13+
'VERTICAL POSITION=Pystysijainti'+#13+
'NUMBER=Numero'+#13+
'LEVELS=Tasot'+#13+
'OVERLAP=P��llekk�isyys'+#13+
'STACK 100%=Pino 100%'+#13+
'MOVE=Siirr�'+#13+
'CLICK=Napsaus'+#13+
'DELAY=Viive'+#13+
'DRAW LINE=Piirr� viiva'+#13+
'FUNCTIONS=Funktiot'+#13+
'SOURCE SERIES=Sarjan alkuper�'+#13+
'ABOVE=Yl�puolella'+#13+
'BELOW=Alapuolella'+#13+
'Dif. Limit=Eroraja'+#13+
'WITHIN=sis�ll�'+#13+
'EXTENDED=laajennettu'+#13+
'STANDARD=Standardi'+#13+
'STATS=Tilastot'+#13+
'FINANCIAL=raha'+#13+
'OTHER=muu'+#13+
'TEECHART GALLERY=TeeChart''in valikoima'+#13+
'CONNECTING LINES=Viivojen yhdist�minen'+#13+
'REDUCTION=V�hent�m.'+#13+
'LIGHT=Valo'+#13+
'INTENSITY=Intensiteetti'+#13+
'FONT OUTLINES=Fontin ��riviivat'+#13+
'SMOOTH SHADING=Liukuvarjostus'+#13+
'AMBIENT LIGHT=Ymp�r�iv� valo'+#13+
'MOUSE ACTION=Hiiren toiminto'+#13+
'CLOCKWISE=My�t�p�iv��n'+#13+
'ANGLE INCREMENT=Kulman askellis�ys'+#13+
'RADIUS INCREMENT=S�teen askellis�ys'+#13+
'PRINTER=Kirjoitin'+#13+
'SETUP=Asennus'+#13+
'ORIENTATION=Suunta'+#13+
'PORTRAIT=Pysty'+#13+
'LANDSCAPE=Vaaka'+#13+
'MARGINS (%)=Marginaalit (%)'+#13+
'MARGINS=Marginaalit'+#13+
'DETAIL=Yksityiskohta'+#13+
'MORE=Lis��'+#13+
'PROPORTIONAL=Suhteellinen'+#13+
'VIEW MARGINS=N�yt� marginaalit'+#13+
'RESET MARGINS=Palauta marginaalit'+#13+
'PRINT=Tulosta'+#13+
'TEEPREVIEW EDITOR=Esikatselun editori'+#13+
'ALLOW MOVE=Salli siirt�minen'+#13+
'ALLOW RESIZE=Salli koon muuttaminen'+#13+
'SHOW IMAGE=N�yt� kuva'+#13+
'DRAG IMAGE=Ved� kuvaa'+#13+
'AS BITMAP=Bittikarttana'+#13+
'SIZE %=Koko %'+#13+
'FIELDS=Kent�t'+#13+
'SOURCE=Alkuper�'+#13+
'SEPARATOR=Erotin'+#13+
'NUMBER OF HEADER LINES=Otsikkorivien m��r�'+#13+
'COMMA=Pilkku'+#13+
'EDITING=Editointi'+#13+
'TAB=Tabulaattori'+#13+
'SPACE=V�lily�nti'+#13+
'ROUND RECTANGLE=Py�ristetty suorakulmio'+#13+
'BOTTOM=Ala'+#13+
'RIGHT=Oikea'+#13+
'C PEN=Kyn� C'+#13+
'R PEN=Kyn� R'+#13+
'C LABELS=Tunniste C'+#13+
'R LABELS=Tunniste R'+#13+
'MULTIPLE BAR=Useat pylv�it�'+#13+
'MULTIPLE AREAS=Useat alat'+#13+
'STACK GROUP=Pinoryhm�'+#13+
'BOTH=Molemmat'+#13+
'BACK DIAGONAL= K��nteisdiagonaali'+#13+
'B.DIAGONAL=K��nteisdiagonaali'+#13+
'DIAG.CROSS=Diagonaaliristi'+#13+
'WHISKER=Parta'+#13+
'CROSS=Risti'+#13+
'DIAGONAL CROSS=Diagonaaliristi'+#13+
'LEFT RIGHT=Vasemmalta oikealle'+#13+
'RIGHT LEFT=Oikealta vasemmalle'+#13+
'FROM CENTER=Keskelt�'+#13+
'FROM TOP LEFT=Ylh��lt� vasemmalle'+#13+
'FROM BOTTOM LEFT=Alhaalta vasemmalle'+#13+
'SHOW WEEKDAYS=N�yt� viikonp�iv�t'+#13+
'SHOW MONTHS=N�yt� kuukaudet'+#13+
'SHOW PREVIOUS BUTTON=N�yt� edellinen painike'#13+
'SHOW NEXT BUTTON=N�yt� seuraava painike'#13+
'TRAILING DAYS=Loput p�iv�t'+#13+
'SHOW TODAY=N�yt� t�m� p�iv�'+#13+
'TRAILING=Loput'+#13+
'LOWERED=Alaindeksi'+#13+
'RAISED=Yl�indeksi'+#13+
'HORIZ. OFFSET=Vaakasuuntainen offset'+#13+
'VERT. OFFSET=Pystysuuntainen offset'+#13+
'INNER=Sis�inen'+#13+
'LEN=Pituus'+#13+
'AT LABELS ONLY=Vain nimi�ille'+#13+
'MAXIMUM=Maksimi'+#13+
'MINIMUM=Minimi'+#13+
'CHANGE=Muutos'+#13+
'LOGARITHMIC=Logaritminen'+#13+
'LOG BASE=Log. kantaluku'+#13+
'DESIRED INCREMENT=Askellis�ys'+#13+
'(INCREMENT)=(askellis�ys)'+#13+
'MULTI-LINE=Moniviivainen'+#13+
'MULTI LINE=Monta viivaa'+#13+
'RESIZE CHART=Muuta kaavion kokoa'+#13+
'X AND PERCENT=X:n ja Y:n prosentit'+#13+
'X AND VALUE=X:n ja Y:n arvot'+#13+
'RIGHT PERCENT=Oikean prosentti'+#13+
'LEFT PERCENT=Vasemman prosentti'+#13+
'LEFT VALUE=Vasemman arvo'+#13+
'RIGHT VALUE=Oikean arvo'+#13+
'PLAIN=Tavallinen'+#13+
'LAST VALUES=Viimeinen arvo'+#13+
'SERIES VALUES=sarjojen arvot'+#13+
'SERIES NAMES=Sarjojen nimet'+#13+
'NEW=Uusi'+#13+
'EDIT=Editoi'+#13+
'PANEL COLOR=Taulun v�ri'+#13+
'TOP BOTTOM=Ylh��lt� alas'+#13+
'BOTTOM TOP=Alhaalta yl�s'+#13+
'DEFAULT ALIGNMENT=Oletustasaus'+#13+
'EXPONENTIAL=Exponentiaalinen'+#13+
'LABELS FORMAT=Nimi�iden muoto'+#13+
'MIN. SEPARATION %=Min. erotin %'+#13+
'YEAR=Vuosi'+#13+
'MONTH=Kuukausi'+#13+
'WEEK=Viikko'+#13+
'WEEKDAY=Viikonp�iv�'+#13+
'MARK=Markitse'+#13+
'ROUND FIRST=Py�rist� ensin'+#13+
'LABEL ON AXIS=Nimi akselissa'+#13+
'COUNT=Lukema'+#13+
'POSITION %=Paikka %'+#13+
'START %=Alku %'+#13+
'END %=Loppu %'+#13+
'OTHER SIDE=Toinen puoli'+#13+
'INTER-CHAR SPACING=Sis�isen merkin v�li'+#13+
'VERT. SPACING=Pystysuuntainen v�li'+#13+
'POSITION OFFSET %=Paikan offset %'+#13+
'GENERAL=Yleinen'+#13+
'MANUAL=Manuaalinen'+#13+
'PERSISTENT=Pysyv�'+#13+
'PANEL=Taulu'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=TeeOpenGL:n editori'+#13+
'FONT 3D DEPTH=Fontin 3D syvyys'+#13+
'NORMAL=Normaali'+#13+
'TEEFONT EDITOR=TeeFontin editori'+#13+
'CLIP POINTS=Leikkauspisteet'+#13+
'CLIPPED=Leikattu'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Kvantitoi'+#13+
'QUANTIZE 256=Kvantitoi 256'+#13+
'DITHER=Pehmenn�'+#13+
'VERTICAL SMALL=Pieni pystysuuntainen'+#13+
'HORIZ. SMALL=Pieni vaakasuuntainen'+#13+
'DIAG. SMALL=Pieni diagonaali'+#13+
'BACK DIAG. SMALL=Pieni k��nteinen diagonaali'+#13+
'DIAG. CROSS SMALL=Cruz Pieni diagonaalinen risti'+#13+
'MINIMUM PIXELS=Pikselien minimim��r�'+#13+
'ALLOW SCROLL=Salli vieritys'+#13+
'SWAP=Vaihda'+#13+
'GRADIENT EDITOR=Gradientin editori'+#13+
'TEXT STYLE=Tekstityyli'+#13+
'DIVIDING LINES=Jakavat viivat'+#13+
'SYMBOLS=Symbolit'+#13+
'CHECK BOXES=Asetusnapit'+#13+
'FONT SERIES COLOR=Sarjan v�ri'+#13+
'LEGEND STYLE=Selitteen tyyli'+#13+
'POINTS PER PAGE=Pisteit� sivulla'+#13+
'SCALE LAST PAGE=Skaalaa viimeinen sivu'+#13+
'CURRENT PAGE LEGEND=Nykyisen sivun selite'+#13+
'BACKGROUND=Tausta'+#13+
'BACK IMAGE=Taustakuva'+#13+
'STRETCH=Venyt�'+#13+
'TILE=Kaakeli'+#13+
'BORDERS=Rajat'+#13+
'CALCULATE EVERY=Laske jokainen'+#13+
'NUMBER OF POINTS=Pisteiden lukum��r�'+#13+
'RANGE OF VALUES=Arvojen alue'+#13+
'FIRST=Ensimm�inen'+#13+
'LAST=Viimeinen'+#13+
'ALL POINTS=Kaikki pisteet'+#13+
'DATA SOURCE=Datan alkuper�'+#13+
'WALLS=Sein�t'+#13+
'PAGING=Sivutus'+#13+
'CLONE=Kopio'+#13+
'TITLES=Otsikot'+#13

{$IFDEF LCL}
;  TeeFinnishLanguage.Text:=TeeFinnishLanguage.Text
{$ENDIF}

+
'TOOLS=Ty�kalut'+#13+
'EXPORT=Vie'+#13+
'CHART=Kaavio'+#13+
'BACK=Tausta'+#13+
'LEFT AND RIGHT=Vasen ja oikea'+#13+
'SELECT A CHART STYLE=Valitse kaavion tyyli'+#13+
'SELECT A DATABASE TABLE=Valitse tietokannan taulu'+#13+
'TABLE=Taulu'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Valitse haluamasi kent�t kaavioon'+#13+
'SELECT A TEXT LABELS FIELD=Valitse tekstinimi�iden kentt�'+#13+
'CHOOSE THE DESIRED CHART TYPE=Valitse kaaviotyyppi'+#13+
'CHART PREVIEW=Kaavion esikatselu'+#13+
'SHOW LEGEND=N�yt� selite'+#13+
'SHOW MARKS=N�yt� merkit'+#13+
'FINISH=Lopeta'+#13+
'RANDOM=Satunnainen'+#13+
'DRAW EVERY=Piirr� kaikki'+#13+
'ARROWS=Nuolet'+#13+
'ASCENDING=Nouseva'+#13+
'DESCENDING=Laskeva'+#13+
'VERTICAL AXIS=Pystyakselit'+#13+
'DATETIME=P�iv�ys/aika'+#13+
'TOP AND BOTTOM=Yl� ja ala'+#13+
'HORIZONTAL AXIS=Vaaka-akseli'+#13+
'PERCENTS=Prosentit'+#13+
'VALUES=Arvot'+#13+
'FORMATS=Muodot'+#13+
'SHOW IN LEGEND=N�yt� selitteess�'+#13+
'SORT=Lajittele'+#13+
'MARKS=Merkit'+#13+
'BEVEL INNER=Viisto reuna sis��n'+#13+
'BEVEL OUTER=Viisto reuna ulos'+#13+
'PANEL EDITOR=Taulun editori'+#13+
'CONTINUOUS=Jatkuva'+#13+
'HORIZ. ALIGNMENT=Vaakasuuntainen sovitus'+#13+
'EXPORT CHART=Tallenna kaavio'+#13+
'BELOW %=Alapuolella %'+#13+
'BELOW VALUE=Ala-arvo'+#13+
'NEAREST POINT=L�hin piste'+#13+
'DRAG MARKS=Siirr� merkkej�'+#13+
'TEECHART PRINT PREVIEW=Tulostuksen esikatselu'+#13+
'X VALUE=X:n arvo'+#13+
'X AND Y VALUES=X:n ja Y:n arvot'+#13+
'SHININESS=Kirkkaus'+#13+
'ALL SERIES VISIBLE=Kaikki sarjat n�kyvi�'+#13+
'MARGIN=Marginaalit'+#13+
'DIAGONAL=Diagonaalinen'+#13+
'LEFT TOP=Vasemmalta oikealle'+#13+
'LEFT BOTTOM=Vasemmalta pohjalle'+#13+
'RIGHT TOP=Oikealta yl�s'+#13+
'RIGHT BOTTOM=Oikealta pohjalle'+#13+
'EXACT DATE TIME=Tarkka p�iv� ja tunti'+#13+
'RECT. GRADIENT=Gradientti'+#13+
'CROSS SMALL=Pieni risti'+#13+
'AVG=Keskiarvo'+#13+
'FUNCTION=Funktio'+#13+
'AUTO=Automaattinen'+#13+
'ONE MILLISECOND=Millisekuntti'+#13+
'ONE SECOND=Sekuntti'+#13+
'FIVE SECONDS=Viisi sekunttia'+#13+
'TEN SECONDS=Kymmenen sekunttia'+#13+
'FIFTEEN SECONDS=Viisitoista sekunttia'+#13+
'THIRTY SECONDS=Kolmekymment� sekunttia'+#13+
'ONE MINUTE=Minuutti'+#13+
'FIVE MINUTES=Viisi minuuttia'+#13+
'TEN MINUTES=Kymmenen minuuttia'+#13+
'FIFTEEN MINUTES=Viisitoista minuuttia'+#13+
'THIRTY MINUTES=Kolmekymment� minuuttia'+#13+
'ONE HOUR=Tunti'+#13+ 
'TWO HOURS=Kaksi tuntia'+#13+
'SIX HOURS=Kuusi tuntia'+#13+
'TWELVE HOURS=Kaksitoista tuntia'+#13+
'ONE DAY=Yksi p�iv�'+#13+
'TWO DAYS=Kaksi p�iv��'+#13+
'THREE DAYS=Kolme p�iv��'+#13+
'ONE WEEK=Viikko'+#13+
'HALF MONTH=Puoli kuukautta'+#13+
'ONE MONTH=Kuukausi'+#13+
'TWO MONTHS=Kaksi kuukautta'+#13+
'THREE MONTHS=Kolme kuukautta'+#13+
'FOUR MONTHS=Nelj� kuukautta'+#13+
'SIX MONTHS=Kuusi kuukautta'+#13+
'IRREGULAR=Ep�s��nn�llinen'+#13+
'CLICKABLE=Klikattava'+#13+
'ROUND=Py�re�'+#13+
'FLAT=Taso'+#13+
'PIE=Piirakka'+#13+
'HORIZ. BAR=Vaakapylv�s'+#13+
'BUBBLE=Kupla'+#13+
'SHAPE=Muoto'+#13+
'POINT=Piste'+#13+
'FAST LINE=Pikaviiva'+#13+
'CANDLE=Kynttil�'+#13+
'VOLUME=M��r�'+#13+
'HORIZ LINE=Vaakaviiva'+#13+
'SURFACE=Pinta'+#13+
'LEFT AXIS=Vasen akseli'+#13+
'RIGHT AXIS=Oikea akseli'+#13+
'TOP AXIS=Yl�akseli'+#13+
'BOTTOM AXIS=Ala-akseli'+#13+
'CHANGE SERIES TITLE=Muuta sarjan otsikkoa'+#13+
'DELETE %S ?=Poista %s ?'+#13+
'DESIRED %S INCREMENT=Haluttu % askellis�ys'+#13+
'INCORRECT VALUE. REASON: %S=V��r� arvo. Syy: %s'+#13+
'FILLSAMPLEVALUES NUMVALUES MUST BE > 0=FillSampleValues tulee olla > 0.'#13+
'VISIT OUR WEB SITE !=Vieraile web-sivuillamme!'#13+
'SHOW PAGE NUMBER=N�yt� sivunumero'#13+
'PAGE NUMBER=Sivunumero'#13+
'PAGE %D OF %D=Sivu %d %d:st�'#13+
'TEECHART LANGUAGES=TeeChartin kielet'#13+
'CHOOSE A LANGUAGE=Valitse kieli'+#13+
'SELECT ALL=Valitse kaikki'#13+
'MOVE UP=Siirry yl�s'#13+
'MOVE DOWN=Siirry alas'#13+
'DRAW ALL=Piirr� kaikki'#13+
'TEXT FILE=Tekstitiedosto'#13+
'IMAG. SYMBOL=Kuvasymboli'#13+
'DRAG REPAINT=Ved� Uudelleenmaalaus'#13+
'NO LIMIT DRAG=Vet�miselle ei raja-arvoa'
;
  end;
end;

Procedure TeeSetFinnish;
begin
  TeeCreateFinnish;
  TeeLanguage:=TeeFinnishLanguage;
  TeeFinnishConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

initialization
finalization
  FreeAndNil(TeeFinnishLanguage);
end.

