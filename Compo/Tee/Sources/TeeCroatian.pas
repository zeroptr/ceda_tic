//Fran Supek - comments (last update: 3-Jun-2004)
//mark = oznaka; label = oznaka? uvesti razli�ite termine (label:natpis,etiketa; mark:znak)
//stack = stog (alternative: slog, slagalina, hrpa); glagol=slo�iti (alt: naslagati)
//poravnavanje ili poravnanje?
//scroll = skrolati? skrolanje? (bolje od "pomicanje", to je nedovoljno specifi�no)
//bevel = izdignuti rub?
//explode, exploded = razdvoji, razdvojeno (cijelu tortu) ili izdvoji, izdvojeno (jedan komad)
//bar = stupac; alternative: stup, kolona, traka, pravokutnik
//cylinder = valjak; conus = sto�ac
//drag = povla�enje; alt: vu�enje, vu�a, potezanje
//transpose = preuredi; alt: razmjesti?
//native = prirodno; alt: uro�eno(?), normalno, osnovno

unit TeeCroatian;   
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeCroatianLanguage:TStringList=nil;

Procedure TeeSetCroatian;
Procedure TeeCreateCroatian;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeCroatianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 by David Berneda';

  TeeMsg_Test               :='Test...';
  TeeMsg_LegendFirstValue   :='Prva vrijednost legende mora biti ve�a od 0';
  TeeMsg_LegendColorWidth   :='Obojeni dio legende mora biti �iri od 0 %';
  TeeMsg_SeriesSetDataSource:='Ne postoji graf za provjeru valjanosti izvora podataka';
  TeeMsg_SeriesInvDataSource:='Ne postoji valjani izvor podataka: %s';
  TeeMsg_FillSample         :='Vrijednosti moraju biti ve�e od 0';
  TeeMsg_AxisLogDateTime    :='DatumSat os ne mo�e biti logaritamska';
  TeeMsg_AxisLogNotPositive :='Min i Max vrijednost logaritamske osi trebaju biti ve�e ili jednake 0';
  TeeMsg_AxisLabelSep       :='Odvajanje oznaka mora biti ve�e od 0 %';
  TeeMsg_AxisIncrementNeg   :='Prirast osi mora biti ve�i ili jednak 0';
  TeeMsg_AxisMinMax         :='Minimalna vrijednost osi mora biti manja ili jednaka maksimalnoj vrijednosti';
  TeeMsg_AxisMaxMin         :='Maksimalna vrijednost osi mora biti ve�a ili jednaka minimalnoj vrijednosti';
  TeeMsg_AxisLogBase        :='Baza logaritamske osi treba biti ve�a ili jednaka 2';
  TeeMsg_MaxPointsPerPage   :='Maksimalni broj to�aka po strani mora biti ve�i ili jednak 0';
  TeeMsg_3dPercent          :='Snaga 3D efekta mora biti izme�u %d i %d %';
  TeeMsg_CircularSeries     :='Cirkularne ovisnosti izme�u serija nisu dozvoljene';
  TeeMsg_WarningHiColor     :='16-bitna ili ve�a paleta boja je neophodna za bolji izgled';

  TeeMsg_DefaultPercentOf   :='%s od %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'od %s';
  TeeMsg_DefPercentFormat   :='##0,## %';
  TeeMsg_DefValueFormat     :='#.##0,###';
  TeeMsg_DefLogValueFormat  :='#,0 "x10" E+0';
  TeeMsg_AxisTitle          :='Naziv osi';
  TeeMsg_AxisLabels         :='Oznake osi';
  TeeMsg_RefreshInterval    :='Interval osvje�avanja mora biti izme�u 0 i 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart nije self!';
  TeeMsg_GalleryLine        :='Linija';
  TeeMsg_GalleryPoint       :='To�ka';
  TeeMsg_GalleryArea        :='Podru�je';
  TeeMsg_GalleryBar         :='Stupac';
  TeeMsg_GalleryHorizBar    :='Horiz. stupac';
  TeeMsg_Stack              :='Red';
  TeeMsg_GalleryPie         :='Torta';
  TeeMsg_GalleryCircled     :='Kru�no';
  TeeMsg_GalleryFastLine    :='Brza linija';
  TeeMsg_GalleryHorizLine   :='Horiz. linija';

  TeeMsg_PieSample1         :='Automobili';
  TeeMsg_PieSample2         :='Telefoni';
  TeeMsg_PieSample3         :='Tablice';
  TeeMsg_PieSample4         :='Monitori';
  TeeMsg_PieSample5         :='Lampe';
  TeeMsg_PieSample6         :='Tastature';
  TeeMsg_PieSample7         :='Bicikli';
  TeeMsg_PieSample8         :='Stolice';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Ure�ivanje %s';

  TeeMsg_GalleryStandard    :='Standardno';
  TeeMsg_GalleryExtended    :='Pro�ireno';
  TeeMsg_GalleryFunctions   :='Funkcije';

  TeeMsg_EditChart          :='U&re�ivanje grafikona...';
  TeeMsg_PrintPreview       :='&Pretpregled ispisa...';
  TeeMsg_ExportChart        :='I&zvoz grafikona...';
  TeeMsg_CustomAxes         :='Korisni�ke osi...';

  TeeMsg_InvalidEditorClass :='%s: Nepostoje�a klasa Editora: %s';
  TeeMsg_MissingEditorClass :='%s: nema dijaloga Editora';

  TeeMsg_GalleryArrow       :='Strelica';

  TeeMsg_ExpFinish          :='&Zavr�i';
  TeeMsg_ExpNext            :='&Naprijed >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Dizajn';
  TeeMsg_GanttSample2       :='Prototip';
  TeeMsg_GanttSample3       :='Razvoj';
  TeeMsg_GanttSample4       :='Prodaja';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testiranje';
  TeeMsg_GanttSample7       :='Proizvodnja';
  TeeMsg_GanttSample8       :='Debagiranje';
  TeeMsg_GanttSample9       :='Nova verzija';
  TeeMsg_GanttSample10      :='Bankarstvo';

  TeeMsg_ChangeSeriesTitle  :='Promjeni naziv serije';
  TeeMsg_NewSeriesTitle     :='Novi naziv serije:';
  TeeMsg_DateTime           :='DatumSat';
  TeeMsg_TopAxis            :='Gornja os';
  TeeMsg_BottomAxis         :='Donja os';
  TeeMsg_LeftAxis           :='Lijeva os';
  TeeMsg_RightAxis          :='Desna os';

  TeeMsg_SureToDelete       :='Bri�i %s ?';
  TeeMsg_DateTimeFormat     :='DatumSat format:';
  TeeMsg_Default            :='Podrazumijevano';
  TeeMsg_ValuesFormat       :='Format vrijednosti:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='�eljeni %s prirast';

  TeeMsg_IncorrectMaxMinValue:='Neto�na vrijednost. Razlog: %s';
  TeeMsg_EnterDateTime      :='Unesi [Broj dana] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Primjeni promjene ?';
  TeeMsg_SelectedSeries     :='(Ozna�ene serije)';
  TeeMsg_RefreshData        :='&Osvje�i podatke';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Dodaj';
  TeeMsg_FunctionSubtract   :='Oduzmi';
  TeeMsg_FunctionMultiply   :='Pomno�i';
  TeeMsg_FunctionDivide     :='Podijeli';
  TeeMsg_FunctionHigh       :='Najvi�e';
  TeeMsg_FunctionLow        :='Najni�e';
  TeeMsg_FunctionAverage    :='Prosjek';

  TeeMsg_GalleryShape       :='Oblik';
  TeeMsg_GalleryBubble      :='Balon';
  TeeMsg_FunctionNone       :='Kopiraj';

  TeeMsg_None               :='(ni�ta)';

  TeeMsg_PrivateDeclarations:='{ Privatne deklaracije }';
  TeeMsg_PublicDeclarations :='{ Javne deklaracije }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Veli�ina pokaziva�a mora biti ve�a od nule';
  TeeMsg_About              :='&O TeeChart...';

  tcAdditional              :='Dodatno';
  tcDControls               :='Kontrole podataka';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Skup podataka';
  TeeMsg_AskDataSet         :='Skup podataka:';

  TeeMsg_SingleRecord       :='Jedan slog';
  TeeMsg_AskDataSource      :='Izvor podataka:';

  TeeMsg_Summary            :='Sumiranje';

  TeeMsg_FunctionPeriod     :='Period funkcije treba biti ve�i ili jednak 0';

  TeeMsg_WizardTab          :='Posao';
  TeeMsg_TeeChartWizard     :='TeeChart �arobnjak';

  TeeMsg_ClearImage         :='Isprazni';
  TeeMsg_BrowseImage        :='Pregled...';

  TeeMsg_WizardSureToClose  :='Da li ste sigurni da �elite zatvoriti TeeChart �arobnjaka?';
  TeeMsg_FieldNotFound      :='Polje %s ne postoji';

  TeeMsg_DepthAxis          :='Dubina osi';
  TeeMsg_PieOther           :='Ostalo';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Torta';
  TeeMsg_ValuesBar          :='Stupac';
  TeeMsg_ValuesAngle        :='Ugao';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='Kraj';
  TeeMsg_ValuesGanttNextTask:='Sljede�iZadatak';
  TeeMsg_ValuesBubbleRadius :='Radijus';
  TeeMsg_ValuesArrowEndX    :='KrajnjeX';
  TeeMsg_ValuesArrowEndY    :='KrajnjeY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Naslov';
  TeeMsg_Foot               :='Podno�je';
  TeeMsg_Period		    :='Period';
  TeeMsg_PeriodRange        :='Opseg perioda';
  TeeMsg_CalcPeriod         :='Izra�unaj %s svaki:';
  TeeMsg_SmallDotsPen       :='Male to�ke';

  TeeMsg_InvalidTeeFile     :='Nepostoje�i grafikon u *.'+TeeMsg_TeeExtension+' datoteci';
  TeeMsg_WrongTeeFileFormat :='Pogre�an *.'+TeeMsg_TeeExtension+' format datoteke';
  TeeMsg_EmptyTeeFile       :='Prazna *.'+TeeMsg_TeeExtension+' datoteka';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Osi grafikona';
  TeeMsg_ChartAxesCategoryDesc   := 'Osobine i doga�aji osi grafikona';
  TeeMsg_ChartWallsCategoryName  := 'Zidovi grafikona';
  TeeMsg_ChartWallsCategoryDesc  := 'Osobine i doga�aji zidova grafikona';
  TeeMsg_ChartTitlesCategoryName := 'Naslovi grafikona';
  TeeMsg_ChartTitlesCategoryDesc := 'Osobine i doga�aji naslova grafikona';
  TeeMsg_Chart3DCategoryName     := '3D svojstva grafikona';
  TeeMsg_Chart3DCategoryDesc     := 'Osobine i doga�aji 3D grafikona';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Korisni�ki editor osi ';
  TeeMsg_Series                 :='Serije';
  TeeMsg_SeriesList             :='Serije...';

  TeeMsg_PageOfPages            :='Strana %d od %d';
  TeeMsg_FileSize               :='%d bajtova';

  TeeMsg_First  :='Prvi';
  TeeMsg_Prior  :='Prethodni';
  TeeMsg_Next   :='Sljede�i';
  TeeMsg_Last   :='Poslijednji';
  TeeMsg_Insert :='Umetni';
  TeeMsg_Delete :='Obri�i';
  TeeMsg_Edit   :='Uredi';
  TeeMsg_Post   :='Snimi';
  TeeMsg_Cancel :='Prekini';

  TeeMsg_All    :='(sve)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Tekst';

  TeeMsg_AsBMP        :='kao &Bitmapa';
  TeeMsg_BMPFilter    :='Bitmape (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='kao &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafile (*.emf)|*.emf|Metafile (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Osobina panela nije pode�ena u formatu za izvoz';

  TeeMsg_Normal    :='Normalno';
  TeeMsg_NoBorder  :='Bez okvira';
  TeeMsg_Dotted    :='To�kasto';
  TeeMsg_Colors    :='Boje';
  TeeMsg_Filled    :='Popunjeno';
  TeeMsg_Marks     :='Oznake';
  TeeMsg_Stairs    :='Zvijezde';
  TeeMsg_Points    :='To�ke';
  TeeMsg_Height    :='Visina';
  TeeMsg_Hollow    :='Prazno';
  TeeMsg_Point2D   :='2D to�ka';
  TeeMsg_Triangle  :='Trokut';
  TeeMsg_Star      :='Zvijezda';
  TeeMsg_Circle    :='Krug';
  TeeMsg_DownTri   :='Trokut dolje';
  TeeMsg_Cross     :='Kri�';
  TeeMsg_Diamond   :='Romb';
  TeeMsg_NoLines   :='Bez linija';
  TeeMsg_Stack100  :='Red 100%';
  TeeMsg_Pyramid   :='Piramida';
  TeeMsg_Ellipse   :='Elipsa';
  TeeMsg_InvPyramid:='Inv. piramida';
  TeeMsg_Sides     :='Strane';
  TeeMsg_SideAll   :='Sve strane';
  TeeMsg_Patterns  :='Uzorci';
  TeeMsg_Exploded  :='Razdvojeno';
  TeeMsg_Shadow    :='Sjena';
  TeeMsg_SemiPie   :='Polu-torta';
  TeeMsg_Rectangle :='Pravokutnik';
  TeeMsg_VertLine  :='Vert. linija';
  TeeMsg_HorizLine :='Horiz. linija';
  TeeMsg_Line      :='Linija';
  TeeMsg_Cube      :='Kocka';
  TeeMsg_DiagCross :='Dijag. kri�';

  TeeMsg_CanNotFindTempPath    :='Ne mogu na�i privremeni direktorij';
  TeeMsg_CanNotCreateTempChart :='Ne mogu stvoriti privremenu datoteku';
  TeeMsg_CanNotEmailChart      :='Ne mogu poslati TeeChart poruku. MAPI gre�ka: %d';

  TeeMsg_SeriesDelete :='Brisanje serije: Vrijednost indeksa %d izvan opsega (0 do %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='kao &JPEG';
  TeeMsg_JPEGFilter    :='JPEG datoteke (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='kao &GIF';
  TeeMsg_GIFFilter     :='GIF datoteke (*.gif)|*.gif';
  TeeMsg_AsPNG         :='kao &PNG';
  TeeMsg_PNGFilter     :='PNG datoteke (*.png)|*.png';
  TeeMsg_AsPCX         :='kao PC&X';
  TeeMsg_PCXFilter     :='PCX datoteke (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='kao &VML (HTM)';
  TeeMsg_VMLFilter     :='VML datoteke (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='Jezik...';

  { 5.03 }
  TeeMsg_Gradient     :='Preljev';
  TeeMsg_WantToSave   :='�elite li snimiti %s?';
  TeeMsg_NativeFilter :='TeeChart datoteke';

  TeeMsg_Property     :='Osobina';	
  TeeMsg_Value        :='Vrijednost';
  TeeMsg_Yes          :='Da';
  TeeMsg_No           :='Ne';
  TeeMsg_Image        :='(slika)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polarno';
  TeeMsg_GalleryCandle      :='Svije�a';
  TeeMsg_GalleryVolume      :='Volumen';
  TeeMsg_GallerySurface     :='Povr�ina';
  TeeMsg_GalleryContour     :='Kontura';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='3D to�ka';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Krafna';
  TeeMsg_GalleryCursor      :='Kursor';
  TeeMsg_GalleryBar3D       :='3D stupac';
  TeeMsg_GalleryBigCandle   :='Velika svije�a';
  TeeMsg_GalleryLinePoint   :='Linijska to�ka';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Vodopad';
  TeeMsg_GalleryWindRose    :='Ru�a vjetrova';
  TeeMsg_GalleryClock       :='Sat';
  TeeMsg_GalleryColorGrid   :='Mre�a u boji';
  TeeMsg_GalleryBoxPlot     :='Kutije';
  TeeMsg_GalleryHorizBoxPlot:='Horiz. kutije';
  TeeMsg_GalleryBarJoin     :='Udru�eni stupci';
  TeeMsg_GallerySmith       :='Potkova';
  TeeMsg_GalleryPyramid     :='Piramida';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange    :='Stupanj polinoma mora biti izmedju 1 i 20';
  TeeMsg_AnswerVectorIndex   :='Indeks rezultiraju�eg vektora mora biti izmedju 1 i %d';
  TeeMsg_FittingError        :='Ne mogu aproksimirati';
  TeeMsg_PeriodRange         :='Period mora biti ve�i ili jednak 0';
  TeeMsg_ExpAverageWeight    :='Eksp. prosjek te�ine mora biti izme�u 0 i 1';
  TeeMsg_GalleryErrorBar     :='Traka gre�ke';
  TeeMsg_GalleryError        :='Gre�ka';
  TeeMsg_GalleryHighLow      :='Visoko-nisko';
  TeeMsg_FunctionMomentum    :='Moment';
  TeeMsg_FunctionMomentumDiv :='Podjela momenta';
  TeeMsg_FunctionExpAverage  :='Eksp. prosjek';
  TeeMsg_FunctionMovingAverage:='Pomi�ni prosj.';
  TeeMsg_FunctionExpMovAve   :='Eksp. pom. pros.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Aproks. krivuljom';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Eksp. trend';
  TeeMsg_FunctionLogTrend    :='Log. trend';
  TeeMsg_FunctionCumulative  :='Kumulativno';
  TeeMsg_FunctionStdDeviation:='Std. devijacija';
  TeeMsg_FunctionBollinger   :='Djelitelj';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stohasti�ki';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Broj';
  TeeMsg_LoadChart           :='Otvori TeeChart...';
  TeeMsg_SaveChart           :='Snimi TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro datoteke';

  TeeMsg_GallerySamples      :='Ostalo';
  TeeMsg_GalleryStats        :='Statistike';

  TeeMsg_CannotFindEditor    :='Ne mogu na�i formular editora serije: %s';

  TeeMsg_CannotLoadChartFromURL:='Kod gre�ke: %d prilikom preuzimanja grafikona sa adrese: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Kod gre�ke: %d prilikom preuzimanja podataka serija sa adrese: %s';

  TeeMsg_ValuesDate          :='Datum';
  TeeMsg_ValuesOpen          :='Otvori';
  TeeMsg_ValuesHigh          :='Visoko';
  TeeMsg_ValuesLow           :='Nisko';
  TeeMsg_ValuesClose         :='Zatvori';
  TeeMsg_ValuesOffset        :='Pomak';
  TeeMsg_ValuesStdError      :='Std. gre�ka';

  TeeMsg_Grid3D              :='3D tabela';

  TeeMsg_LowBezierPoints     :='Broj Bezier to�aka treba biti ve�i ili jednak 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normalno';
  TeeCommanMsg_Edit     :='Uredi';
  TeeCommanMsg_Print    :='Ispis';
  TeeCommanMsg_Copy     :='Kopiraj';
  TeeCommanMsg_Save     :='Snimi';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotacija: %d� Elevacija: %d�';
  TeeCommanMsg_Rotate   :='Rotiraj';

  TeeCommanMsg_Moving   :='Horiz. pomak: %d Vert. pomak: %d';
  TeeCommanMsg_Move     :='Pomakni';

  TeeCommanMsg_Zooming  :='Uve�anje: %d %%';
  TeeCommanMsg_Zoom     :='Uve�aj';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Dubina';

  TeeCommanMsg_Chart    :='Grafikon';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Pomakni %s za rotiranje';
  TeeCommanMsg_MoveLabel  :='Pomakni %s za pomicanje';
  TeeCommanMsg_ZoomLabel  :='Pomakni %s za uve�anje';
  TeeCommanMsg_DepthLabel :='Pomakni %s za 3D promjenu';

  TeeCommanMsg_NormalLabel:='Pomakni lijevu tipku za uve�anje, desnu tipku za listanje';
  TeeCommanMsg_NormalPieLabel:='Pomakni komad torte da bi se izdvojio';

  TeeCommanMsg_PieExploding :='Komad: %d Razdvojeno: %d %%';

  TeeMsg_TriSurfaceLess        :='Broj to�aka mora biti ve�i ili jednak 4';
  TeeMsg_TriSurfaceAllColinear :='Sve kolinearne to�ke podataka';
  TeeMsg_TriSurfaceSimilar     :='Sli�ne to�ke - ne mogu izvr�iti';
  TeeMsg_GalleryTriSurface     :='Trokutasta povr�ina';

  TeeMsg_AllSeries :='Sve serije';
  TeeMsg_Edit      :='Uredi';

  TeeMsg_GalleryFinancial    :='Financijsko';

  TeeMsg_CursorTool    :='Kursor';
  TeeMsg_DragMarksTool :='Pomakni oznake';
  TeeMsg_AxisArrowTool :='Strelice osi';
  TeeMsg_DrawLineTool  :='Crtaj liniju';
  TeeMsg_NearestTool   :='Najbli�a to�ka';
  TeeMsg_ColorBandTool :='Boja trake';
  TeeMsg_ColorLineTool :='Boja linije';
  TeeMsg_RotateTool    :='Rotiraj';
  TeeMsg_ImageTool     :='Slika';
  TeeMsg_MarksTipTool  :='Oznake';
  TeeMsg_AnnotationTool:='Napomena';

  TeeMsg_CantDeleteAncestor  :='Ne mogu obrisati pretka';

  TeeMsg_Load	          :='U�itaj...';
  TeeMsg_NoSeriesSelected :='Nije odabrana serija';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Grafikon';
  TeeMsg_CategorySeriesActions :='Serije grafikona';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'Prebaci 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Aktivno';
  TeeMsg_ActionSeriesActiveHint := 'Prika�i / Sakrij seriju';
  TeeMsg_ActionEditHint         := 'Uredi grafikon';
  TeeMsg_ActionEdit             := '&Uredi...';
  TeeMsg_ActionCopyHint         := 'Kopiraj na Clipboard';
  TeeMsg_ActionCopy             := '&Kopiraj';
  TeeMsg_ActionPrintHint        := 'Prika�i pregled grafikona';
  TeeMsg_ActionPrint            := 'Is&pis...';
  TeeMsg_ActionAxesHint         := 'Prika�i / Sakrij osi';
  TeeMsg_ActionAxes             := '&Osi';
  TeeMsg_ActionGridsHint        := 'Prika�i / Sakrij linije';
  TeeMsg_ActionGrids            := '&Linije';
  TeeMsg_ActionLegendHint       := 'Prika�i / Sakrij legendu';
  TeeMsg_ActionLegend           := 'Le&genda';
  TeeMsg_ActionSeriesEditHint   := 'Uredi Serije';
  TeeMsg_ActionSeriesMarksHint  := 'Prika�i / Sakrij oznake serija';
  TeeMsg_ActionSeriesMarks      := 'Oz&nake';
  TeeMsg_ActionSaveHint         := 'Snimi grafikon';
  TeeMsg_ActionSave             := '&Snimi...';

  TeeMsg_CandleBar              := 'Stupac';
  TeeMsg_CandleNoOpen           := 'Nema otvaranja';
  TeeMsg_CandleNoClose          := 'Nema zatvaranja';
  TeeMsg_NoHigh                 := 'Nema visokog';
  TeeMsg_NoLow                  := 'Nema niskog';
  TeeMsg_ColorRange             := 'Opseg boja';
  TeeMsg_WireFrame              := '�i�ani prikaz';
  TeeMsg_DotFrame               := 'To�kasti prikaz';
  TeeMsg_Positions              := 'Polo�aji';
  TeeMsg_NoGrid                 := 'Nema tablica';
  TeeMsg_NoPoint                := 'Nema to�ke';
  TeeMsg_NoLine                 := 'Nema linije';
  TeeMsg_Labels                 := 'Oznake';
  TeeMsg_NoCircle               := 'Nema kruga';
  TeeMsg_Lines                  := 'Linije';
  TeeMsg_Border                 := 'Okvir';

  TeeMsg_SmithResistance      := 'Pasivni otpor';
  TeeMsg_SmithReactance       := 'Reaktivni otpor';

  TeeMsg_Column               := 'Stupac';

  { 5.01 }
  TeeMsg_Separator            := 'Separator';
  TeeMsg_FunnelSegment        := 'Segment ';
  TeeMsg_FunnelSeries         := 'Lijevak';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Prelazi kvotu'; 
  TeeMsg_FunnelWithin         := 'Unutar kvote';
  TeeMsg_FunnelBelow          := 'Ispod kvote';
  TeeMsg_CalendarSeries       := 'Kalendar';
  TeeMsg_DeltaPointSeries     := 'DeltaTo�ka';
  TeeMsg_ImagePointSeries     := 'SlikaTo�ka';
  TeeMsg_ImageBarSeries       := 'SlikaStupac';
  TeeMsg_SeriesTextFieldZero  := 'Tekst serije: Indeks polja treba biti ve�i od nule.';

  { 5.02 }
  TeeMsg_Origin               := 'Po�etak';
  TeeMsg_Transparency         := 'Prozirnost';
  TeeMsg_Box		      := 'Kutija';
  TeeMsg_ExtrOut	      := 'Ekstra Izlaz';
  TeeMsg_MildOut	      := 'Blagi Izlaz';
  TeeMsg_PageNumber	      := 'Broj strane';
  TeeMsg_TextFile             := 'Tekstualna datoteka';

  { 5.03 }
  TeeMsg_DragPoint            := 'Pomakni to�ku';
  TeeMsg_OpportunityValues    := 'Vrijednosti prilike';
  TeeMsg_QuoteValues          := 'Vrijednosti navoda'; 
end;

Procedure TeeCreateCroatian;
begin
  if not Assigned(TeeCroatianLanguage) then
  begin
    TeeCroatianLanguage:=TStringList.Create;
    TeeCroatianLanguage.Text:=

'LABELS=Oznake'+#13+
'DATASET=Skup podataka'+#13+
'ALL RIGHTS RESERVED.=Sva prava zadr�ana.'+#13+
'APPLY=Prijmeni'+#13+
'CLOSE=Zatvori'+#13+
'OK=OK'+#13+
'ABOUT TEECHART PRO V7.0=O TeeChart Pro v7.0'+#13+
'OPTIONS=Opcije'+#13+
'FORMAT=Format'+#13+
'TEXT=Tekst'+#13+
'GRADIENT=Preljev'+#13+
'SHADOW=Sjena'+#13+
'POSITION=Polo�aj'+#13+
'LEFT=Lijevo'+#13+
'TOP=Gore'+#13+
'CUSTOM=Korisni�ki'+#13+
'PEN=Olovka'+#13+
'PATTERN=Uzorak'+#13+
'SIZE=Veli�ina'+#13+
'BEVEL=Reljefni rub'+#13+
'INVERTED=Obrnuto'+#13+
'INVERTED SCROLL=Obrnuto skrolanje'+#13+
'BORDER=Okvir'+#13+
'ORIGIN=Ishodi�te'+#13+
'USE ORIGIN=Koristi ishodi�te'+#13+
'AREA LINES=Linije podru�ja'+#13+
'AREA=Podru�je'+#13+
'COLOR=Boja'+#13+
'SERIES=Serija'+#13+
'SUM=Zbroj'+#13+
'DAY=Dan'+#13+
'QUARTER=Tromjese�je'+#13+
'(MAX)=(max)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Vidljivo'+#13+
'CURSOR=Kursor'+#13+
'GLOBAL=Globalno'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=Horiz. linija'+#13+
'LABEL AND PERCENT=Oznaka i postotak'+#13+
'LABEL AND VALUE=Oznaka i vrijednost'+#13+
'LABEL AND PERCENT TOTAL=Oznaka i ukupni postotak'+#13+
'PERCENT TOTAL=Ukupni postotak'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=Oduzmi'+#13+
'MULTIPLY=Pomno�i'+#13+
'DIVIDE=Podijeli'+#13+
'STAIRS=Zvijezde'+#13+
'MOMENTUM=Moment'+#13+
'AVERAGE=Prosjek'+#13+
'XML=XML'+#13+
'HTML TABLE=HTML Tablica'+#13+
'EXCEL=Excel'+#13+
'NONE=Ni�ta'+#13+
'(NONE)=(Ni�ta)'#13+
'WIDTH=�irina'+#13+
'HEIGHT=Visina'+#13+
'COLOR EACH=Oboji svako'+#13+
'STACK=Stog'+#13+
'STACKED=Naslagano'+#13+
'STACKED 100%=Naslagano do 100%'+#13+
'AXIS=Os'+#13+
'LENGTH=Duljina'+#13+
'CANCEL=Prekini'+#13+
'SCROLL=Skrolanje'+#13+
'INCREMENT=Prirast'+#13+
'VALUE=Vrijednost'+#13+
'STYLE=Stil'+#13+
'JOIN=Unija'+#13+
'AXIS INCREMENT=Prirast osi'+#13+
'AXIS MAXIMUM AND MINIMUM=Minimum i maksimum osi'+#13+
'% BAR WIDTH=% �irine stupca'+#13+
'% BAR OFFSET=% pomaka stupca'+#13+
'BAR SIDE MARGINS=Bo�ne margine stupca'+#13+
'AUTO MARK POSITION=Polo�aj aut. oznaka'+#13+
'DARK BAR 3D SIDES=Tamne strane 3D stupca'+#13+
'MONOCHROME=Crno/bijelo'+#13+
'COLORS=Boje'+#13+
'DEFAULT=Podrazumijevano'+#13+
'MEDIAN=Medijan'+#13+
'IMAGE=Slika'+#13+
'DAYS=Dani'+#13+
'WEEKDAYS=Radni dani'+#13+
'TODAY=Danas'+#13+
'SUNDAY=Nedjelja'+#13+
'MONTHS=Mjeseci'+#13+
'LINES=Linije'+#13+
'UPPERCASE=Velika slova'+#13+
'STICK=Palica'+#13+
'CANDLE WIDTH=�irina svije�e'+#13+
'BAR=Stupac'+#13+
'OPEN CLOSE=Otvoreno/zatvoreno'+#13+
'DRAW 3D=Crtaj 3D'+#13+
'DARK 3D=Tamno 3D'+#13+
'SHOW OPEN=Prika�i otvoreno'+#13+
'SHOW CLOSE=Prika�i zatvoreno'+#13+
'UP CLOSE=Zatvoreno gore'+#13+
'DOWN CLOSE=Zatvoreno dolje'+#13+
'CIRCLED=Kru�no'+#13+
'CIRCLE=Krug'+#13+
'3 DIMENSIONS=3 dimenzije'+#13+
'ROTATION=Rotacija'+#13+
'RADIUS=Radijus'+#13+
'HOURS=Sati'+#13+
'HOUR=Sat'+#13+
'MINUTES=Minute'+#13+
'SECONDS=Sekunde'+#13+
'FONT=Pismo'+#13+
'INSIDE=Unutra'+#13+
'ROTATED=Rotirano'+#13+
'ROMAN=Rimski'+#13+
'TRANSPARENCY=Prozirnost'+#13+
'DRAW BEHIND=Crtaj iza'+#13+
'RANGE=Opseg'+#13+
'PALETTE=Paleta'+#13+
'STEPS=Koraci'+#13+
'GRID=Mre�a'+#13+
'GRID SIZE=Veli�ina mre�e'+#13+
'ALLOW DRAG=Dozvoli povla�enje'+#13+
'AUTOMATIC=Automatski'+#13+
'LEVEL=Razina'+#13+
'LEVELS POSITION=Polo�aji razina'+#13+
'SNAP=Prisloni'+#13+
'FOLLOW MOUSE=Slijedi mi�a'+#13+
'TRANSPARENT=Prozirno'+#13+
'ROUND FRAME=Zaobljeni okvir'+#13+
'FRAME=Okvir'+#13+
'START=Start'+#13+
'END=Kraj'+#13+
'MIDDLE=Sredina'+#13+
'NO MIDDLE=Nema sredine'+#13+
'DIRECTION=Smjer'+#13+
'DATASOURCE=Izvor podataka'+#13+
'AVAILABLE=Dostupno'+#13+
'SELECTED=Odabrana'+#13+
'CALC=Izra�unaj'+#13+
'GROUP BY=Grupiraj po'+#13+
'OF=od'+#13+
'HOLE %=Rupa %'+#13+
'RESET POSITIONS=Resetiraj poziciju'+#13+
'MOUSE BUTTON=Tipke mi�a'+#13+
'ENABLE DRAWING=Uklju�i crtanje'+#13+
'ENABLE SELECT=Uklju�i odabiranje'+#13+
'ORTHOGONAL=Pravokutno'+#13+
'ANGLE=Ugao'+#13+
'ZOOM TEXT=Uve�anje teksta'+#13+
'PERSPECTIVE=Perspektiva'+#13+
'ZOOM=Uve�anje'+#13+
'ELEVATION=Elevacija'+#13+
'BEHIND=Iza'+#13+
'AXES=Osi'+#13+
'SCALES=Skale'+#13+
'TITLE=Naslov'+#13+
'TICKS=Crtice'+#13+
'MINOR=Najmanji'+#13+
'CENTERED=Centrirano'+#13+
'CENTER=Centar'+#13+
'PATTERN COLOR EDITOR=Editor uzoraka'+#13+
'START VALUE=Po�etna vrijednost'+#13+
'END VALUE=Krajnja vrijednost'+#13+
'COLOR MODE=Re�im boje'+#13+
'LINE MODE=Re�im linije'+#13+
'HEIGHT 3D=Visina 3D'+#13+
'OUTLINE=Obrub'+#13+
'PRINT PREVIEW=Pretpregled ispisa'+#13+
'ANIMATED=Animirano'+#13+
'ALLOW=Dozvoli'+#13+
'DASH=Crtica'+#13+
'DOT=To�ka'+#13+
'DASH DOT DOT=Crtica to�ka to�ka'+#13+
'PALE=Blijedo'+#13+
'STRONG=Sna�no'+#13+
'WIDTH UNITS=Jedinice �irine'+#13+
'FOOT=Podno�je'+#13+
'SUBFOOT=Pot-podno�je'+#13+
'SUBTITLE=Podnaslov'+#13+
'LEGEND=Legenda'+#13+
'COLON=Kolona'+#13+
'AXIS ORIGIN=Po�etak osi'+#13+
'UNITS=Jedinice'+#13+
'PYRAMID=Piramida'+#13+
'DIAMOND=Romb'+#13+
'CUBE=Kocka'+#13+
'TRIANGLE=Trokut'+#13+
'STAR=Zvijezda'+#13+
'SQUARE=Kvadrat'+#13+
'DOWN TRIANGLE=Trokut dolje'+#13+
'SMALL DOT=Mala to�ka'+#13+
'LOAD=U�itaj'+#13+
'FILE=Datoteka'+#13+
'RECTANGLE=Pravokutnik'+#13+
'HEADER=Zaglavlje'+#13+
'CLEAR=Isprazni'+#13+
'ONE HOUR=Jedan sat'+#13+
'ONE YEAR=Jedna godina'+#13+
'ELLIPSE=Elipsa'+#13+
'CONE=Sto�ac'+#13+
'ARROW=Strelica'+#13+
'CYLLINDER=Valjak'+#13+
'TIME=Vrijeme'+#13+
'BRUSH=�etka'+#13+
'LINE=Linija'+#13+
'VERTICAL LINE=Vertikalna linija'+#13+
'AXIS ARROWS=Strelice osi'+#13+
'MARK TIPS=Ozna�i vrhove'+#13+
'DASH DOT=Crtica to�ka'+#13+
'COLOR BAND=Obojena vrpca'+#13+
'COLOR LINE=Obojena linija'+#13+
'INVERT. TRIANGLE=Obrn. trokut'+#13+
'INVERT. PYRAMID=Obrn. piramida'+#13+
'INVERTED PYRAMID=Obrnuta piramida'+#13+
'SERIES DATASOURCE TEXT EDITOR=Tekstualni editor izvora podataka serije'+#13+
'SOLID=Ispunjeno'+#13+
'WIREFRAME=�i�ano'+#13+
'DOTFRAME=To�kasto'+#13+
'SIDE BRUSH=Bo�na �etka'+#13+
'SIDE=Strana'+#13+
'SIDE ALL=Sve strane'+#13+
'ROTATE=Rotiraj'+#13+
'SMOOTH PALETTE=Glatka paleta'+#13+
'CHART TOOLS GALLERY=Galerija alata grafikona'+#13+
'ADD=Dodaj'+#13+
'BORDER EDITOR=Editor okvira'+#13+
'DRAWING MODE=Re�im crtanja'+#13+
'CLOSE CIRCLE=Zatvoreni krug'+#13+
'PICTURE=Slika'+#13+
'NATIVE=Prirodno'+#13+
'DATA=Podaci'+#13+
'KEEP ASPECT RATIO=Sa�uvaj proporcije'+#13+
'COPY=Kopiraj'+#13+
'SAVE=Snimi'+#13+
'SEND=Po�alji'+#13+
'INCLUDE SERIES DATA=Uklju�i podatke serije'+#13+
'FILE SIZE=Veli�ina datoteke'+#13+
'INCLUDE=Uklju�i'+#13+
'POINT INDEX=Indeks to�ke'+#13+
'POINT LABELS=Oznaka to�ke'+#13+
'DELIMITER=Grani�nik'+#13+
'DEPTH=Dubina'+#13+
'COMPRESSION LEVEL=Razina kompresije'+#13+
'COMPRESSION=Kompresija'+#13+
'PATTERNS=Uzorci'+#13+
'LABEL=Oznaka'+#13+
'GROUP SLICES=Grupiraj komada'+#13+
'EXPLODE BIGGEST=Izdvoji najve�i'+#13+
'TOTAL ANGLE=Ukupan kut'+#13+
'HORIZ. SIZE=Horiz. veli�ina'+#13+
'VERT. SIZE=Vert. veli�ina'+#13+
'SHAPES=Oblici'+#13+
'INFLATE MARGINS=Uve�aj margine'+#13+
'QUALITY=Kvaliteta'+#13+
'SPEED=Brzina'+#13+
'% QUALITY=% Kvalitete'+#13+
'GRAY SCALE=Siva skala'+#13+
'PERFORMANCE=Performanse'+#13+
'BROWSE=Pregledaj'+#13+
'TILED=Mozaik'+#13+
'HIGH=Visoko'+#13+
'LOW=Nisko'+#13+
'DATABASE CHART=Grafikon baze podataka'+#13+
'NON DATABASE CHART=Grafikon bez baze podataka'+#13+
'HELP=Pomo�'+#13+
'NEXT >=Naprijed >'+#13+
'< BACK=< Natrag'+#13+
'TEECHART WIZARD=TeeChart �arobnjak'+#13+
'PERCENT=Postotak'+#13+
'PIXELS=To�ke'+#13+
'ERROR WIDTH=�irina gre�ke'+#13+
'ENHANCED=Pobolj�ano'+#13+
'VISIBLE WALLS=Vidljivi zidovi'+#13+
'ACTIVE=Aktivno'+#13+
'DELETE=Bri�i'+#13+
'ALIGNMENT=Poravnanje'+#13+
'ADJUST FRAME=Prilagodi okvir'+#13+
'HORIZONTAL=Horizontalno'+#13+
'VERTICAL=Vertikalno'+#13+
'VERTICAL POSITION=Vertikalna pozicija'+#13+
'NUMBER=Broj'+#13+
'LEVELS=Razine'+#13+
'OVERLAP=Prekrivanje'+#13+
'STACK 100%=Stog 100%'+#13+ 
'MOVE=Pomakni'+#13+
'CLICK=Klik'+#13+
'DELAY=Odgoda'+#13+
'DRAW LINE=Crtaj liniju'+#13+
'FUNCTIONS=Funkcije'+#13+
'SOURCE SERIES=Serije-izvori'+#13+
'ABOVE=Iznad'+#13+
'BELOW=Ispod'+#13+
'Dif. Limit=Raz. limita'+#13+
'WITHIN=iz'+#13+
'EXTENDED=Pro�ireno'+#13+
'STANDARD=Standardno'+#13+
'STATS=Statistika'+#13+
'FINANCIAL=Financijsko'+#13+
'OTHER=Ostalo'+#13+
'TEECHART GALLERY=TeeChart galerija'+#13+
'CONNECTING LINES=Povezuju�e linije'+#13+
'REDUCTION=Smanjenje'+#13+
'LIGHT=Svjetlo'+#13+
'INTENSITY=Intenzitet'+#13+
'FONT OUTLINES=Obrub pisma'+#13+
'SMOOTH SHADING=Glatko sjen�enje'+#13+
'AMBIENT LIGHT=Svjetlo okoline'+#13+
'MOUSE ACTION=Akcija mi�a'+#13+
'CLOCKWISE=U smjeru kazaljke'+#13+
'ANGLE INCREMENT=Prirast kuta'+#13+
'RADIUS INCREMENT=Prirast polumjera'+#13+
'PRINTER=Pisa�'+#13+
'SETUP=Pode�avanje'+#13+
'ORIENTATION=Orijentacija'+#13+
'PORTRAIT=Portret'+#13+
'LANDSCAPE=Krajolik'+#13+
'MARGINS (%)=Margine (%)'+#13+
'MARGINS=Margine'+#13+
'DETAIL=Detalji'+#13+
'MORE=Vi�e'+#13+
'PROPORTIONAL=Proporcionalno'+#13+
'VIEW MARGINS=Pogledaj margine'+#13+
'RESET MARGINS=Resetiraj margine'+#13+
'PRINT=Ispi�i'+#13+
'TEEPREVIEW EDITOR=Editor Tee predpregleda'+#13+
'ALLOW MOVE=Dozvoli pomicanje'+#13+
'ALLOW RESIZE=Dozvoli promjenu veli�ine'+#13+
'SHOW IMAGE=Prika�i sliku'+#13+
'DRAG IMAGE=Pomakni sliku'+#13+
'AS BITMAP=kao bitmapa'+#13+
'SIZE %=Veli�ina %'+#13+
'FIELDS=Polja'+#13+
'SOURCE=Izvor'+#13+
'SEPARATOR=Separator'+#13+
'NUMBER OF HEADER LINES=Broj linija zaglavlja'+#13+
'COMMA=Zarez'+#13+
'EDITING=Ure�ivanje'+#13+
'TAB=Tabulator'+#13+
'SPACE=Razmak'+#13+
'ROUND RECTANGLE=Zaobljeni pravokutnik'+#13+
'BOTTOM=Na dnu'+#13+
'RIGHT=Desno'+#13+
'C PEN=C olovka'+#13+
'R PEN=R olovka'+#13+
'C LABELS=C oznake'+#13+
'R LABELS=R oznake'+#13+
'MULTIPLE BAR=Vi�estruki stupac'+#13+
'MULTIPLE AREAS=Vi�estruko podru�je'+#13+
'STACK GROUP=Grupa stoga'+#13+
'BOTH=Oba'+#13+
'BACK DIAGONAL=Dijagonalno nazad'+#13+
'B.DIAGONAL=Dijag. nazad'+#13+
'DIAG.CROSS=Diag. kri�'+#13+
'WHISKER=Brkovi'+#13+
'CROSS=Kri�'+#13+
'DIAGONAL CROSS=Dijagonalni kri�'+#13+
'LEFT RIGHT=Lijevo desno'+#13+
'RIGHT LEFT=Desno lijevo'+#13+
'FROM CENTER=Iz centra'+#13+
'FROM TOP LEFT=Iz gornjeg lijevog ugla'+#13+
'FROM BOTTOM LEFT=Iz donjeg lijevog ugla'+#13+
'SHOW WEEKDAYS=Prika�i radne dane'+#13+
'SHOW MONTHS=Prika�i mjesece'+#13+
'SHOW PREVIOUS BUTTON=Prika�i prethodnu tipku'#13+
'SHOW NEXT BUTTON=Prika�i sljede�u tipku'#13+
'TRAILING DAYS=Preostali dani'+#13+
'SHOW TODAY=Prika�i danas'+#13+
'TRAILING=Preostali'+#13+
'LOWERED=Sni�eno'+#13+
'RAISED=Povi�eno'+#13+
'HORIZ. OFFSET=Horiz. pomak'+#13+
'VERT. OFFSET=Vert. pomak'+#13+
'INNER=Unutra'+#13+
'LEN=Du�ina'+#13+
'AT LABELS ONLY=Samo na oznakama'+#13+
'MAXIMUM=Maksimum'+#13+
'MINIMUM=Minimum'+#13+
'CHANGE=Promijeni'+#13+
'LOGARITHMIC=Logaritamski'+#13+
'LOG BASE=Baza log.'+#13+
'DESIRED INCREMENT=�eljeni prirast'+#13+
'(INCREMENT)=(Prirast)'+#13+
'MULTI-LINE=Vi�estruko-linijski'+#13+
'MULTI LINE=Vi�estruka linija'+#13+
'RESIZE CHART=Promijeni veli�inu grafikona'+#13+
'X AND PERCENT=X i postotak'+#13+
'X AND VALUE=X i vrijednost'+#13+
'RIGHT PERCENT=Desni postotak'+#13+
'LEFT PERCENT=Lijevi postotak'+#13+
'LEFT VALUE=Lijeva vrijednost'+#13+
'RIGHT VALUE=Desna vrijednost'+#13+
'PLAIN=�ist'+#13+
'LAST VALUES=Posljednja vrijednost'+#13+
'SERIES VALUES=Vrijednosti serija'+#13+
'SERIES NAMES=Imena serija'+#13+
'NEW=Novo'+#13+
'EDIT=Uredi'+#13+
'PANEL COLOR=Boja panela'+#13+
'TOP BOTTOM=Gore dolje'+#13+
'BOTTOM TOP=Dolje gore'+#13+
'DEFAULT ALIGNMENT=Podrazumijevano poravnanje'+#13+
'EXPONENTIAL=Eksponencijal'+#13+
'LABELS FORMAT=Format oznaka'+#13+
'MIN. SEPARATION %=Min. odvajanje %'+#13+
'YEAR=Godina'+#13+
'MONTH=Mjesec'+#13+
'WEEK=Tjedan'+#13+
'WEEKDAY=Radni dan'+#13+
'MARK=Oznaka'+#13+ 
'ROUND FIRST=Zaokru�i prvi'+#13+
'LABEL ON AXIS=Oznaka na osi'+#13+
'COUNT=Broj'+#13+
'POSITION %=Pozicija %'+#13+
'START %=Start %'+#13+
'END %=Kraj %'+#13+
'OTHER SIDE=Druga strana'+#13+
'INTER-CHAR SPACING=Razmak me�u znakovima'+#13+
'VERT. SPACING=Vertikalni razmak'+#13+
'POSITION OFFSET %=Pomak polo�aja %'+#13+
'GENERAL=Op�enito'+#13+
'MANUAL=Ru�no'+#13+
'PERSISTENT=Stalno'+#13+
'PANEL=Panel'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollingerova vrpca'+#13+  
'TEEOPENGL EDITOR=OpenGL Editor'+#13+
'FONT 3D DEPTH=Dubina 3D pisma'+#13+
'NORMAL=Normalno'+#13+
'TEEFONT EDITOR=Editor pisma'+#13+
'CLIP POINTS=To�ke spoja'+#13+ //clip=spoj? to�ke rezanja?
'CLIPPED=Spojeno'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Kvantiziraj'+#13+
'QUANTIZE 256=Kvantiziraj 256'+#13+
'DITHER=Dither'+#13+
'VERTICAL SMALL=Vert. malo'+#13+
'HORIZ. SMALL=Horiz. malo'+#13+
'DIAG. SMALL=Dijag. malo'+#13+
'BACK DIAG. SMALL=Dijag. obrnuto malo'+#13+
'DIAG. CROSS SMALL=Dijag. kri�no malo'+#13+
'MINIMUM PIXELS=Minimalno piksela'+#13+
'ALLOW SCROLL=Dozvoli skrolanje'+#13+ 
'SWAP=Zamijeni'+#13+
'GRADIENT EDITOR=Editor preljeva'+#13+
'TEXT STYLE=Stil teksta'+#13+
'DIVIDING LINES=Linije podjele'+#13+
'SYMBOLS=Simboli'+#13+
'CHECK BOXES=Check box-ovi'+#13+
'FONT SERIES COLOR=Boja pisma serije'+#13+
'LEGEND STYLE=Stil legende'+#13+
'POINTS PER PAGE=To�aka po stranici'+#13+
'SCALE LAST PAGE=Skaliraj zadnju stranicu'+#13+
'CURRENT PAGE LEGEND=Legenda trenutne stranice'+#13+
'BACKGROUND=Pozadina'+#13+
'BACK IMAGE=Pozadinska slika'+#13+
'STRETCH=Razvuci'+#13+
'TILE=Mozaik'+#13+
'BORDERS=Okviri'+#13+
'CALCULATE EVERY=Izra�unaj svaki'+#13+
'NUMBER OF POINTS=Broj to�aka'+#13+
'RANGE OF VALUES=Raspon vrijednosti'+#13+
'FIRST=Prvi'+#13+
'LAST=Posljednji'+#13+
'ALL POINTS=Sve to�ke'+#13+
'DATA SOURCE=Izvor podataka'+#13+
'WALLS=Zidovi'+#13+
'PAGING=Strani�enje'+#13+
'CLONE=Duplikat'+#13+
'TITLES=Naslovi'+#13+
'TOOLS=Alati'+#13+
'EXPORT=Izvoz'+#13+
'CHART=Grafikon'+#13+
'BACK=Natrag'+#13+
'LEFT AND RIGHT=Lijevo i desno'+#13+
'SELECT A CHART STYLE=Izaberi stil grafikona'+#13+
'SELECT A DATABASE TABLE=Izaberi tablicu baze'+#13+
'TABLE=Tablica'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Izaberi �eljena polja za grafikon'+#13+
'SELECT A TEXT LABELS FIELD=Izaberi polje tekstualnih oznaka'+#13+
'CHOOSE THE DESIRED CHART TYPE=Izaberi �eljeni tip grafikona'+#13+
'CHART PREVIEW=Pretpregled grafikona'+#13+
'SHOW LEGEND=Prika�i legendu'+#13+
'SHOW MARKS=Prika�i oznake'+#13+
'FINISH=Zavr�i'+#13+
'RANDOM=Slu�ajno'+#13+
'DRAW EVERY=Crtaj svaki'+#13+
'ARROWS=Strelice'+#13+
'ASCENDING=Rastu�e'+#13+
'DESCENDING=Opadaju�e'+#13+
'VERTICAL AXIS=Vertikalna os'+#13+
'DATETIME=DatumSat'+#13+
'TOP AND BOTTOM=Gornji i donji'+#13+
'HORIZONTAL AXIS=Horizontalna os'+#13+
'PERCENTS=Postoci'+#13+
'VALUES=Vrijednosti'+#13+
'FORMATS=Formati'+#13+
'SHOW IN LEGEND=Prika�i u legendi'+#13+
'SORT=Redoslijed'+#13+
'MARKS=Oznake'+#13+
'BEVEL INNER=Unutarnji reljefni rub'+#13+
'BEVEL OUTER=Vanjski reljefni rub'+#13+
'PANEL EDITOR=Editor panela'+#13+
'CONTINUOUS=Nastavljeno'+#13+
'HORIZ. ALIGNMENT=Horiz. poravnanje'+#13+
'EXPORT CHART=Izvoz grafikona'+#13+
'BELOW %=Ispod %'+#13+
'BELOW VALUE=Ispod vrijednosti'+#13+
'NEAREST POINT=Najbli�a ta�ka'+#13+
'DRAG MARKS=Pomakni naslove'+#13+
'TEECHART PRINT PREVIEW=Pretpregled ispisa'+#13+
'X VALUE=Vrijednost X'+#13+
'X AND Y VALUES=Vrijednosti X i Y'+#13+
'SHININESS=Sjaj'+#13+
'ALL SERIES VISIBLE=Sve serije vidljive'+#13+
'MARGIN=Margina'+#13+
'DIAGONAL=Dijagonala'+#13+
'LEFT TOP=Lijevo gore'+#13+
'LEFT BOTTOM=Lijevo dole'+#13+
'RIGHT TOP=Desno gore'+#13+
'RIGHT BOTTOM=Desno dole'+#13+
'EXACT DATE TIME=To�an DatumSat'+#13+
'RECT. GRADIENT=Gradijent'+#13+
'CROSS SMALL=Kri�no malo'+#13+
'AVG=Prosjek'+#13+
'FUNCTION=Funkcija'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Jedna milisekunda'+#13+
'ONE SECOND=Jedna sekunda'+#13+
'FIVE SECONDS=Pet sekundi'+#13+
'TEN SECONDS=Deset sekundi'+#13+
'FIFTEEN SECONDS=Petnaest sekundi'+#13+
'THIRTY SECONDS=Trideset sekundi'+#13+
'ONE MINUTE=Jedna minuta'+#13+
'FIVE MINUTES=Pet minuta'+#13+
'TEN MINUTES=Deset minuta'+#13+
'FIFTEEN MINUTES=Petnaest minuta'+#13+
'THIRTY MINUTES=Trideset minuta'+#13+
'ONE HOUR=Jedan sat'+#13+ //this line also stated 'TWO HOURS', I thought this was in error so I changed it to 'ONE HOUR'. FS.
'TWO HOURS=Dva sata'+#13+
'SIX HOURS=�est sati'+#13+
'TWELVE HOURS=Dvanaest sati'+#13+
'ONE DAY=Jedan dan'+#13+
'TWO DAYS=Dva dana'+#13+
'THREE DAYS=Tri dana'+#13+
'ONE WEEK=Jedan tjedan'+#13+
'HALF MONTH=Pola mjeseca'+#13+
'ONE MONTH=Jedan mjesec'+#13+
'TWO MONTHS=Dva mjeseca'+#13+
'THREE MONTHS=Tri mjeseca'+#13+
'FOUR MONTHS=�etiri mjeseca'+#13+
'SIX MONTHS=�est mjeseci'+#13+
'IRREGULAR=Nepravilno'+#13+
'CLICKABLE=Dopustiti klik'+#13+
'ROUND=Zaokru�iti'+#13+
'FLAT=Ravno'+#13+
'PIE=Torta'+#13+
'HORIZ. BAR=Horiz. stupac'+#13+
'BUBBLE=Balon'+#13+
'SHAPE=Oblik'+#13+
'POINT=To�ka'+#13+
'FAST LINE=Brza linija'+#13+
'CANDLE=Svije�a'+#13+
'VOLUME=Volumen'+#13+
'HORIZ LINE=Horiz. linija'+#13+
'SURFACE=Povr�ina'+#13+
'LEFT AXIS=Lijeva os'+#13+
'RIGHT AXIS=Desna os'+#13+
'TOP AXIS=Gornja os'+#13+
'BOTTOM AXIS=Donja os'+#13+
'CHANGE SERIES TITLE=Promijeni natpise serija'+#13+
'DELETE %S ?=Bri�i %s ?'+#13+
'DESIRED %S INCREMENT=�eljeni %s prira�taj'+#13+
'INCORRECT VALUE. REASON: %S=Neto�na vrednost. Razlog: %s'+#13+
'FillSampleValues NumValues must be > 0=Popunjene slu�ajne vrijednosti trebaju biti ve�e od 0.'#13+
'VISIT OUR WEB SITE !=Posjetite na�u Web stranicu!'#13+
'SHOW PAGE NUMBER=Prika�i broj stranice'#13+
'PAGE NUMBER=Broj stranice'#13+
'PAGE %D OF %D=Stranica %d od %d'#13+
'TEECHART LANGUAGES=TeeChart jezici'#13+
'CHOOSE A LANGUAGE=Izaberi jezik'+#13+
'SELECT ALL=Odaberi sve'#13+
'MOVE UP=Pomakni gore'#13+
'MOVE DOWN=Pomakni dole'#13+
'DRAW ALL=Iscrtaj sve'#13+
'TEXT FILE=Tekstualna datoteka'#13+
'IMAG. SYMBOL=Imag. simbol'#13+
'DRAG REPAINT=Iscrtavanje povla�enja'#13+
'NO LIMIT DRAG=Povla�enje bez ograni�enja'#13+ 
'PERIOD=Period'#13+
'UP=Gore'#13+
'DOWN=Dolje'#13+
'SHADOW EDITOR=Editor sjene'#13+
'CALLOUT=Strip-balon'#13+
'TEXT ALIGNMENT=Poravnavanje teksta'#13+
'DISTANCE=Udaljenost'#13+
'ARROW HEAD=Glava strelice'#13+
'POINTER=Pokaziva�'#13+
'AVAILABLE LANGUAGES=Dostupni jezici'#13+
'CALCULATE USING=Izra�unaj koriste�i'#13+
'EVERY NUMBER OF POINTS=Svaki broj to�aka'#13+
'EVERY RANGE=Svaki raspon'#13+
'INCLUDE NULL VALUES=Uklju�uju�i Null vrijednosti'#13+
'DATE=Datum'#13+
'ENTER DATE=Unesi datum'#13+
'ENTER TIME=Unesi vrijeme'#13+
'BEVEL SIZE=Veli�ina reljefnog ruba'#13+
'CYLINDER=Valjak'#13+
'DEVIATION=Odstupanje'#13+
'UPPER=Gornji'#13+
'LOWER=Donji'#13+
'FILL 80%=Popuni 80%'#13+
'FILL 60%=Popuni 60%'#13+
'FILL 40%=Popuni 40%'#13+
'FILL 20%=Popuni 20%'#13+
'FILL 10%=Popuni 10%'#13+
'ZIG ZAG=Cik-Cak'#13+
'NOTHING=Ni�ta'#13+
'LEFT TRIANGLE=Lijevi trokut'#13+
'RIGHT TRIANGLE=Desni trokut'#13+
'CONSTANT=Konstanta'#13+
'SHOW LABELS=Prika�i oznake'#13+
'SHOW COLORS=Prika�i boje'#13+
'XYZ SERIES=Serija XYZ'#13+
'SHOW X VALUES=Prika�i X vrijednosti'#13+
'DELETE ROW=Obri�i red'#13+
'VOLUME SERIES=Volumna serija'#13+
'ACCUMULATE=Akumuliraj'#13+
'SINGLE=Jednostruko'#13+
'REMOVE CUSTOM COLORS=Ukloni korisni�ke boje'#13+
'STEP=Korak'#13+
'USE PALETTE MINIMUM=Koristi minimum palete'#13+
'AXIS MAXIMUM=Maksimum osi'#13+
'AXIS CENTER=Sredi�te osi'#13+
'AXIS MINIMUM=Minimum osi'#13+
'DAILY (NONE)=Dnevno (ni�ta)'#13+
'WEEKLY=Tjedno'#13+
'MONTHLY=Mjese�no'#13+
'BI-MONTHLY=Dvomjese�no'#13+
'QUARTERLY=Tromjese�no'#13+
'YEARLY=Godi�nje'#13+
'DATETIME PERIOD=DatumSat period'#13+
'SMOOTH=Glatko'#13+
'INTERPOLATE=Interpoliraj'#13+
'START X=Start X'#13+
'NUM. POINTS=Broj to�aka'#13+
'COLOR EACH LINE=Oboji svaku liniju'#13+
'CASE SENSITIVE=Pazi na velika/mala slova'#13+
'SORT BY=Sortiraj po'#13+
'CALCULATION=Izra�un'#13+
'GROUP=Grupiraj'#13+
'DRAG STYLE=Stil povla�enja'#13+
'WEIGHT=Te�ina'#13+
'EDIT LEGEND=Uredi legendu'#13+
'IGNORE NULLS=Ignoriraj Null-ove'#13+
'OFFSET=Pomak'#13+
'LIGHT 0=Svjetlo 0'#13+
'LIGHT 1=Svjetlo 1'#13+
'LIGHT 2=Svjetlo 2'#13+
'DRAW STYLE=Stil crtanja'#13+
'POINTS=To�ke'#13+
'DEFAULT BORDER=Podrazumijevani okvir'#13+
'SQUARED=Kvadratno'#13+
'SEPARATION=Razdvajanje'#13+
'ROUND BORDER=Zakrivljeni rubovi'#13+
'NUMBER OF SAMPLE VALUES=Broj slu�ajnih vrijednosti'#13+
'DIF. LIMIT=Dif. limit'#13+
'RESIZE PIXELS TOLERANCE=Promijeni toleranciju piksela'#13+
'FULL REPAINT=Potpuno iscrtavanje'#13+
'END POINT=Krajnja to�ka'#13+
'BAND 1=Traka 1'#13+
'BAND 2=Traka 2'#13+
'GRID 3D SERIES=Serija 3D-mre�a'#13+
'TRANSPOSE NOW=Preuredi odmah'#13+
'PERIOD 1=Period 1'#13+
'PERIOD 2=Period 2'#13+
'PERIOD 3=Period 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Eksp. linija'#13+
'MACD=MACD'#13+
'WEIGHTED=Pridjeljene te�ine'#13+
'WEIGHTED BY INDEX=Pridjeljene te�ine po indeksu'#13+
'DARK BORDER=Tamni rub'#13+
'PIE SERIES=Serija torta'#13+
'FOCUS=Fokus'#13+
'EXPLODE=Razdvoji'#13+
'BOX SIZE=Veli�ina kutije'#13+
'REVERSAL AMOUNT=Inverzna suma'#13+
'PERCENTAGE=Postotak'#13+
'COMPLETE R.M.S.=�itav R.M.S.'#13+
'BUTTON=Tipka'#13+
'ALL=Sve'#13+
'START AT MIN. VALUE=Start od min. vrijednosti'#13+
'EXECUTE !=Izvr�i !'#13+
'WEB URL=Web URL'#13+
'FACTOR=Faktor'#13+
'SELF STACK=Nasla�i se'#13+
'SIDE LINES=Bo�ne linije'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Grafikon po predlo�ku (*.TEE datoteka)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Otvori TeeChart datoteku predlo�ka iz'#13+
'EXPORT DIALOG=Dijalog izvoza'#13+
'BINARY=Binarno'#13+
'POINT COLORS=Boje to�aka'#13+
'OUTLINE GRADIENT=Preljev obruba'#13+
'CLOSE LOCATION VALUE=Vrijednost bliske lokacije'#13+
'COMMODITY CHANNEL INDEX=Indeks robnog kanala'#13+
'CROSS POINTS=To�ke kri�anja'#13+
'ON BALANCE VOLUME=Na koli�inu bilance'#13+
'SMOOTHING=Ravnomjernost'#13+ //?
'TREND=Trend'#13+
'VOLUME OSCILLATOR=Oscilator koli�ine'#13+
'BALANCE=Bilanca'#13+
'RADIAL OFFSET=Radijalni pomak'#13+
'RADIAL=Radijalno'#13+
'COVER=Pokrij'#13+
'ARROW WIDTH=�irina strelice'#13+
'ARROW HEIGHT=Du�ina strelice'#13+
'DEFAULT COLOR=Podrazum. boja'#13+
'VALUE SOURCE=Izvor vrijednosti'
;
  end;
end;

Procedure TeeSetCroatian;
begin
  TeeCreateCroatian;
  TeeLanguage:=TeeCroatianLanguage;
  TeeCroatianConstants;
  TeeLanguageHotKeyAtEnd:=False;
end;

initialization
finalization
  FreeAndNil(TeeCroatianLanguage);
end.


