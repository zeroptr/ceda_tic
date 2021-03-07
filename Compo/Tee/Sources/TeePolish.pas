unit TeePolish;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeePolishLanguage:TStringList=nil;

Procedure TeeCreatePolish;
Procedure TeeSetPolish;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeePolishConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='© 1995-2009 by David Berneda';
  TeeMsg_LegendFirstValue   :='Pierwsza wartoúÊ legendy musi byÊ > 0';
  TeeMsg_LegendColorWidth   :='SzerokoúÊ musi byÊ pomiÍdzy 0 i 100';
  TeeMsg_SeriesSetDataSource:='Brak ParentChart øeby sprawdziÊ ürÛd≥o danych';
  TeeMsg_SeriesInvDataSource:='Brak poprawnego ürÛd≥a danych: %s';
  TeeMsg_FillSample         :='Wartoúci liczbowe FillSampleValues muszπ byÊ > 0';
  TeeMsg_AxisLogDateTime    :='Oú daty/czasu nie moøe byÊ logarytmiczna';
  TeeMsg_AxisLogNotPositive :='Min i Max wartoúci osi logarytmicznej powinny byÊ >= 0';
  TeeMsg_AxisLabelSep       :='% odstÍpu etykiet musi byÊ wiÍkszy niø 0';
  TeeMsg_AxisIncrementNeg   :='Przyrost osi musi byÊ >= 0';
  TeeMsg_AxisMinMax         :='WartoúÊ minimum osi musi byÊ <= maksimum';
  TeeMsg_AxisMaxMin         :='WartoúÊ maksimum osi musi byÊ >= minimum';
  TeeMsg_AxisLogBase        :='Podstawa logarytmiczna osi powinna byÊ >= 2';
  TeeMsg_MaxPointsPerPage   :='Max. iloúÊ punktÛw na stronÍ musi byÊ >= 0';
  TeeMsg_3dPercent          :='Procent efektu 3D musi byÊ pomiÍdzy %d i %d';
  TeeMsg_CircularSeries     :='Cykliczne zaleønoúci miÍdzy seriami sπ niedozwolone';
  TeeMsg_WarningHiColor     :='Aby uzyskaÊ lepszy wyglπd wymagany jest kolor 16K';

  TeeMsg_DefaultPercentOf   :='%s z %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'z %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Tytu≥ osi';
  TeeMsg_AxisLabels         :='Etykiety osi';
  TeeMsg_RefreshInterval    :='Interwa≥ odswieøania musi byÊ zawarty miÍdzy 0 i 60';
  TeeMsg_SeriesParentNoSelf :='Sam nie jestem Series.ParentChart!';
  TeeMsg_GalleryLine        :='Liniowy';
  TeeMsg_GalleryPoint       :='Punkty';
  TeeMsg_GalleryArea        :='Warstwowy';
  TeeMsg_GalleryBar         :='Kolumnowy';
  TeeMsg_GalleryHorizBar    :='Kolumnowy horyz.';
  TeeMsg_Stack              :='Skumulowany';
  TeeMsg_GalleryPie         :='Ko≥owy';
  TeeMsg_GalleryCircled     :='Zaokrπglony';
  TeeMsg_GalleryFastLine    :='Liniowy szybki';
  TeeMsg_GalleryHorizLine   :='Liniowy horyz.';

  TeeMsg_PieSample1         :='Samochody';
  TeeMsg_PieSample2         :='Telefony';
  TeeMsg_PieSample3         :='Sto≥y';
  TeeMsg_PieSample4         :='Monitory';
  TeeMsg_PieSample5         :='Lampy';
  TeeMsg_PieSample6         :='Klawiatury';
  TeeMsg_PieSample7         :='Rowery';
  TeeMsg_PieSample8         :='Krzes≥a';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Edycja %s';

  TeeMsg_GalleryStandard    :='Standardowe';
  TeeMsg_GalleryExtended    :='Rozszerzone';
  TeeMsg_GalleryFunctions   :='Funkcje';

  TeeMsg_EditChart          :='&Edycja wykresu...';
  TeeMsg_PrintPreview       :='&Podglπd wydruku...';
  TeeMsg_ExportChart        :='E&ksport wykresu...';
  TeeMsg_CustomAxes         :='Osie uøytkownika...';

  TeeMsg_InvalidEditorClass :='%s: Nieprawid≥owa klasa edytora: %s';
  TeeMsg_MissingEditorClass :='%s: brak okna dialogowego edytora';

  TeeMsg_GalleryArrow       :='Strza≥kowy';

  TeeMsg_ExpFinish          :='&Koniec';
  TeeMsg_ExpNext            :='&Dalej >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Projekt';
  TeeMsg_GanttSample2       :='Prototyp';
  TeeMsg_GanttSample3       :='RozwÛj';
  TeeMsg_GanttSample4       :='Sprzedaø';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testowanie';
  TeeMsg_GanttSample7       :='Produkcja';
  TeeMsg_GanttSample8       :='Ulepszanie';
  TeeMsg_GanttSample9       :='Nowa wersja';
  TeeMsg_GanttSample10      :='BankowoúÊ';

  TeeMsg_ChangeSeriesTitle  :='ZmieÒ tytu≥ serii';
  TeeMsg_NewSeriesTitle     :='Nowy tytu≥ serii:';
  TeeMsg_DateTime           :='Data/czas';
  TeeMsg_TopAxis            :='GÛrna oú';
  TeeMsg_BottomAxis         :='Dolna oú';
  TeeMsg_LeftAxis           :='Lewa oú';
  TeeMsg_RightAxis          :='Prawa oú';

  TeeMsg_SureToDelete       :='UsunπÊ %s ?';
  TeeMsg_DateTimeFormat     :='For&mat daty/czasu:';
  TeeMsg_Default            :='Domyúlnie';
  TeeMsg_ValuesFormat       :='For&mat wartoúci:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Poøadany %s przyrost';

  TeeMsg_IncorrectMaxMinValue:='Nieprawid≥owa wartoúÊ. Przyczyna: %s';
  TeeMsg_EnterDateTime      :='Wprowadü [liczba dni] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='ZastosowaÊ zmiany ?';
  TeeMsg_SelectedSeries     :='(Wybrane serie)';
  TeeMsg_RefreshData        :='&Odúwieø dane';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_FunctionAdd        :='Suma';
  TeeMsg_FunctionSubtract   :='RÛønica';
  TeeMsg_FunctionMultiply   :='Iloczyn';
  TeeMsg_FunctionDivide     :='Iloraz';
  TeeMsg_FunctionHigh       :='Wysoko';
  TeeMsg_FunctionLow        :='Nisko';
  TeeMsg_FunctionAverage    :='årednia';

  TeeMsg_GalleryShape       :='Kszta≥ty';
  TeeMsg_GalleryBubble      :='Bπbelkowy';
  TeeMsg_FunctionNone       :='Kopiuj';

  TeeMsg_None               :='(Brak)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='WielkoúÊ wskaünika musi byÊ wiÍksza niø zero';
  TeeMsg_About              :='&O TeeChart...';

  tcAdditional              :='Dodatkowe';
  tcDControls               :='Kontrolki danych';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='ZbiÛr danych';
  TeeMsg_AskDataSet         :='&ZbiÛr danych:';

  TeeMsg_SingleRecord       :='Pojedynczy wiersz';
  TeeMsg_AskDataSource      :='&èrÛd≥o danych:';

  TeeMsg_Summary            :='Podsumowanie';

  TeeMsg_FunctionPeriod     :='Okres funkcji powinien byÊ >= 0';

  TeeMsg_WizardTab          :='Biznes';

  TeeMsg_ClearImage         :='&WyczyúÊ';
  TeeMsg_BrowseImage        :='&Szukaj w...';

  TeeMsg_WizardSureToClose  :='Czy jesteú pewien, øe chcesz zamknπÊ kreatora TeeChart ?';
  TeeMsg_FieldNotFound      :='Pole %s nie istnieje';

  TeeMsg_DepthAxis          :='Oú g≥Íbokoúci';
  TeeMsg_PieOther           :='Inny';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Ko≥o';
  TeeMsg_ValuesBar          :='Kolumna';
  TeeMsg_ValuesAngle        :='Kπt';
  TeeMsg_ValuesGanttStart   :='Poczπtek';
  TeeMsg_ValuesGanttEnd     :='Koniec';
  TeeMsg_ValuesGanttNextTask:='Nastepne zadanie';
  TeeMsg_ValuesBubbleRadius :='PromieÒ';
  TeeMsg_ValuesArrowEndX    :='KoniecX';
  TeeMsg_ValuesArrowEndY    :='KoniecY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Tytu≥';
  TeeMsg_Foot               :='Stopka';
  TeeMsg_Period             :='Okres';
  TeeMsg_PeriodRange        :='Zakres okresÛw';
  TeeMsg_CalcPeriod         :='Oblicz %s co:';
  TeeMsg_SmallDotsPen       :='Ma≥e kropki';

  TeeMsg_InvalidTeeFile     :='Nieprawid≥owy wykres w pliku *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Nieprawid≥owy format pliku *.'+TeeMsg_TeeExtension;
  TeeMsg_EmptyTeeFile       :='Pusty plik *.'+TeeMsg_TeeExtension;  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Osie wykresu';
  TeeMsg_ChartAxesCategoryDesc   :='Osie wykresu - w≥aúciwoúci i zdarzenia';
  TeeMsg_ChartWallsCategoryName  :='åciany wykresu';
  TeeMsg_ChartWallsCategoryDesc  :='åciany wykresu - w≥aúciwoúci i zdarzenia';
  TeeMsg_ChartTitlesCategoryName :='Tytu≥y wykresu';
  TeeMsg_ChartTitlesCategoryDesc :='Tytu≥y wykresu - w≥aúciwoúci i zdarzenia';
  TeeMsg_Chart3DCategoryName     :='Wykres 3D';
  TeeMsg_Chart3DCategoryDesc     :='Wykres 3D - w≥aúciwoúci i zdarzenia';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Uøytkownika ';
  TeeMsg_Series                 :='Serie';
  TeeMsg_SeriesList             :='Serie...';

  TeeMsg_PageOfPages            :='Strona %d z %d';
  TeeMsg_FileSize               :='%d bajtÛw';

  TeeMsg_First  :='Pierwszy';
  TeeMsg_Prior  :='Poprzedni';
  TeeMsg_Next   :='NastÍpny';
  TeeMsg_Last   :='Ostatni';
  TeeMsg_Insert :='Wstaw';
  TeeMsg_Delete :='UsuÒ';
  TeeMsg_Edit   :='Edytuj';
  TeeMsg_Post   :='Zastosuj';
  TeeMsg_Cancel :='Anuluj';

  TeeMsg_All    :='(wszystkie)';
  TeeMsg_Index  :='Indeks';
  TeeMsg_Text   :='Tekst';

  TeeMsg_AsBMP        :='jako &Bitmapa';
  TeeMsg_BMPFilter    :='Bitmapy (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='jako &Metaplik';
  TeeMsg_EMFFilter    :='Rozszerzone Metapliki (*.emf)|*.emf|Metapliki (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='W formacie Eksportu nie jest ustawiona w≥aúciwoúÊ panelu';

  TeeMsg_Normal    :='Normalny';
  TeeMsg_NoBorder  :='Bez krawÍdzi';
  TeeMsg_Dotted    :='Kropkowany';
  TeeMsg_Colors    :='Kolory';
  TeeMsg_Filled    :='Wype≥niony';
  TeeMsg_Marks     :='Znaczniki';
  TeeMsg_Stairs    :='Schody';
  TeeMsg_Points    :='Punkty';
  TeeMsg_Height    :='Pogrubiony';//'WysokoúÊ';
  TeeMsg_Hollow    :='Szkielet';//'Pusty';
  TeeMsg_Point2D   :='Punkt 2D';
  TeeMsg_Triangle  :='TrÛjkπt';
  TeeMsg_Star      :='Gwiazda';
  TeeMsg_Circle    :='Ko≥o';
  TeeMsg_DownTri   :='TrÛjkπt odwr.';
  TeeMsg_Cross     :='Krzyø';
  TeeMsg_Diamond   :='Diament';
  TeeMsg_NoLines   :='Bez linii';
  TeeMsg_Stack100  :='Skumul. 100%';
  TeeMsg_Pyramid   :='Piramida';
  TeeMsg_Ellipse   :='Elipsa';
  TeeMsg_InvPyramid:='Piramida odwr.';
  TeeMsg_Sides     :='Sπsiadujπco';//'Boki';
  TeeMsg_SideAll   :='Sπsiadujπco'#13'wszystkie';//'Wszystkie boki';
  TeeMsg_Patterns  :='Wzory';
  TeeMsg_Exploded  :='RozsuniÍty';
  TeeMsg_Shadow    :='CieÒ';
  TeeMsg_SemiPie   :='PÛ≥kole';
  TeeMsg_Rectangle :='Prostokπt';
  TeeMsg_VertLine  :='Linia pionowa';
  TeeMsg_HorizLine :='Linia pozioma';
  TeeMsg_Line      :='Linia';
  TeeMsg_Cube      :='Szeúcian';
  TeeMsg_DiagCross :='Diag.krzyø';

  TeeMsg_CanNotFindTempPath    :='Nie moøna znaleüÊ folderu Temp';
  TeeMsg_CanNotCreateTempChart :='Nie moøna utworzyÊ pliku Temp';
  TeeMsg_CanNotEmailChart      :='Nie moøna wys≥aÊ wykresu TeeChart. B≥πd MAPI: %d';

  TeeMsg_SeriesDelete :='Usuwanie serii: Indeks wartoúci %d poza przedzia≥em (od 0 do %d).';

  // 5.02
  TeeMsg_AskLanguage  :='&JÍzyk...';


  { TeeProCo }
  TeeMsg_GalleryPolar       :='Biegunowy';
  TeeMsg_GalleryCandle      :='Gie≥dowy';
  TeeMsg_GalleryVolume      :='Wolumen';
  TeeMsg_GallerySurface     :='Powierzchniowy';
  TeeMsg_GalleryContour     :='Konturowy';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Punktowy 3D';
  TeeMsg_GalleryRadar       :='Radarowy';
  TeeMsg_GalleryDonut       :='Pierúcieniowy';
  TeeMsg_GalleryCursor      :='Kursor';
  TeeMsg_GalleryBar3D       :='Kolumnowy 3D';
  TeeMsg_GalleryBigCandle   :='Gie≥dowy-wielki';
  TeeMsg_GalleryLinePoint   :='Punktowy'#13'z liniami';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Wodospad';
  TeeMsg_GalleryWindRose    :='RÛøa wiatrÛw';
  TeeMsg_GalleryClock       :='Zegarowy';
  TeeMsg_GalleryColorGrid   :='Siatka kolorÛw';
  TeeMsg_GalleryBoxPlot     :='Pude≥kowy';
  TeeMsg_GalleryHorizBoxPlot:='Pude≥kowy poziomy';
  TeeMsg_GalleryBarJoin     :='Kolumnowy po≥πcz.';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramida';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange    :='StopieÒ wielomianu musi byÊ pomiÍdzy 1 i 20';
  TeeMsg_AnswerVectorIndex   :='Indeks wektora odpowiedzi musi byÊ pomiÍdzy 1 i %d';
  TeeMsg_FittingError        :='Nie moøna przeprowadziÊ dopasowania';
  TeeMsg_PeriodRange         :='Okres musi byÊ >= 0';
  TeeMsg_ExpAverageWeight    :='Waga úredniej exp. musi byÊ pomiÍdzy 0 i 1';
  TeeMsg_GalleryErrorBar     :='S≥upki b≥Ídu';
  TeeMsg_GalleryError        :='B≥πd';
  TeeMsg_GalleryHighLow      :='Wysoko-nisko';
  TeeMsg_FunctionMomentum    :='PÍd';
  TeeMsg_FunctionMomentumDiv :='PÍd (div.)';
  TeeMsg_FunctionExpAverage  :='årednia exp.';
  TeeMsg_FunctionMovingAverage:='årednia ruchoma';
  TeeMsg_FunctionExpMovAve   :='årednia exp.'#13'ruchoma';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Krzywa dopasowana';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Trend exp.';
  TeeMsg_FunctionLogTrend    :='Trend log.';
  TeeMsg_FunctionCumulative  :='Kumulacja';
  TeeMsg_FunctionStdDeviation:='Odchylenie std.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='åredni pierw.'#13'kwadrat.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastyczny';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='IloúÊ';
  TeeMsg_LoadChart           :='OtwÛrz TeeChart...';
  TeeMsg_SaveChart           :='Zapisz TeeChart...';
  TeeMsg_TeeFiles            :='Pliki TeeChart Pro';

  TeeMsg_GallerySamples      :='Inne';
  TeeMsg_GalleryStats        :='Stat.';

  TeeMsg_CannotFindEditor    :='Nie moøna znaleüÊ formularza edytora serii: %s';


  TeeMsg_CannotLoadChartFromURL:='Kod b≥Ídu: %d ≥adowanie wykresu z URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Kod b≥Ídu: %d ≥adowanie danych serii z URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='OtwÛrz';
  TeeMsg_ValuesHigh          :='Wysoko';
  TeeMsg_ValuesLow           :='Nisko';
  TeeMsg_ValuesClose         :='Zamknij';
  TeeMsg_ValuesOffset        :='PrzesuniÍcie';
  TeeMsg_ValuesStdError      :='B≥πd std.';

  TeeMsg_Grid3D              :='Siatka 3D';

  TeeMsg_LowBezierPoints     :='IloúÊ punktÛw Beziera powinna byÊ > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normalny';
  TeeCommanMsg_Edit     :='Edytuj';
  TeeCommanMsg_Print    :='Drukuj';
  TeeCommanMsg_Copy     :='Kopiuj';
  TeeCommanMsg_Save     :='Zapisz';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='ObrÛt: %d∞ Podniesienie: %d∞';
  TeeCommanMsg_Rotate   :='ObrÛÊ';

  TeeCommanMsg_Moving   :='Przesun. poz.: %d Przesun. pion.: %d';
  TeeCommanMsg_Move     :='PrzesuÒ';

  TeeCommanMsg_Zooming  :='PowiÍkszenie: %d %%';
  TeeCommanMsg_Zoom     :='PowiÍkszenie';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='G≥Íbok.';

  TeeCommanMsg_Chart    :='Wykres';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Ciπgnij %s aby obrÛciÊ';
  TeeCommanMsg_MoveLabel  :='Ciπgnij %s aby przesunπÊ';
  TeeCommanMsg_ZoomLabel  :='Ciπgnij %s aby powiÍkszyÊ';
  TeeCommanMsg_DepthLabel :='Ciπgnij %s aby zmieniÊ g≥ÍbokoúÊ 3D';

  TeeCommanMsg_NormalLabel:='Ciπgnij lewym przyciskiem aby powiÍkszyÊ, prawym by przesunπÊ';
  TeeCommanMsg_NormalPieLabel:='Ciπgnij odpowiedni wycinek ko≥a aby go wysunπÊ';

  TeeCommanMsg_PieExploding :='Wycinek: %d WysuniÍty: %d %%';

  TeeMsg_TriSurfaceLess:='Liczba punktÛw musi byÊ >= 4';
  TeeMsg_TriSurfaceAllColinear:='Wszystkie wspÛ≥liniowe punkty danych';
  TeeMsg_TriSurfaceSimilar:='Podobne punkty XYZ. Nie moøna wyliczyÊ trÛjkπtÛw.';
  TeeMsg_GalleryTriSurface:='Powierzch.'#13'z trÛjkπtÛw';

  TeeMsg_AllSeries :='Wszystkie serie';
  TeeMsg_Edit      :='Edytuj';

  TeeMsg_GalleryFinancial    :='Finansowe';

  TeeMsg_CursorTool    :='Kursor';
  TeeMsg_DragMarksTool :='Ciπgnij znaczniki';
  TeeMsg_AxisArrowTool :='Strza≥ki osi';
  TeeMsg_DrawLineTool  :='Rysuj linie';
  TeeMsg_NearestTool   :='Najbliøszy punkt';
  TeeMsg_ColorBandTool :='Kolorowe pasmo';
  TeeMsg_ColorLineTool :='Kolorowa linia';
  TeeMsg_RotateTool    :='ObrÛt';
  TeeMsg_ImageTool     :='Obraz';
  TeeMsg_MarksTipTool  :='Dymki ze znacznikiem';

  TeeMsg_CantDeleteAncestor  :='Nie moøna usunπÊ poprzednika';

  TeeMsg_Load            :='Wczytywanie...';
  TeeMsg_NoSeriesSelected:='Nie wybrano øadnej serii';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Wykres';
  TeeMsg_CategorySeriesActions :='Serie wykresu';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Prze≥πcz 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Aktywne';
  TeeMsg_ActionSeriesActiveHint :='Pokaø/Ukryj serie';
  TeeMsg_ActionEditHint         :='Edytuj wykres';
  TeeMsg_ActionEdit             :='&Edytuj...';
  TeeMsg_ActionCopyHint         :='Kopiuj do schowka';
  TeeMsg_ActionCopy             :='&Kopiuj';
  TeeMsg_ActionPrintHint        :='Podglπd wydruku';
  TeeMsg_ActionPrint            :='&Drukuj...';
  TeeMsg_ActionAxesHint         :='Pokaø/Ukryj osie';
  TeeMsg_ActionAxes             :='&Osie';
  TeeMsg_ActionGridsHint        :='Pokaø/Ukryj siatkÍ';
  TeeMsg_ActionGrids            :='&Siatka';
  TeeMsg_ActionLegendHint       :='Pokaø/Ukryj legendÍ';
  TeeMsg_ActionLegend           :='&Legenda';
  TeeMsg_ActionSeriesEditHint   :='Edytuj serie';
  TeeMsg_ActionSeriesMarksHint  :='Pokaø/Ukryj znaczniki serii';
  TeeMsg_ActionSeriesMarks      :='&Znaczniki';
  TeeMsg_ActionSaveHint         :='Zapisz wykres';
  TeeMsg_ActionSave             :='&Zapisz...';

  TeeMsg_CandleBar              :='S≥upek';
  TeeMsg_CandleNoOpen           :='Bez otwarcia';
  TeeMsg_CandleNoClose          :='Bez zamkniÍcia';
  TeeMsg_NoLines                :='Bez linii';
  TeeMsg_NoHigh                 :='Bez wysoko';
  TeeMsg_NoLow                  :='Bez nisko';
  TeeMsg_ColorRange             :='Gama kolorÛw';//zakres
  TeeMsg_WireFrame              :='Szkielet druc.';
  TeeMsg_DotFrame               :='Szkielet punkt.';
  TeeMsg_Positions              :='Poziomy';
  TeeMsg_NoGrid                 :='Bez siatki';
  TeeMsg_NoPoint                :='Bez punktu';
  TeeMsg_NoLine                 :='Bez linii';
  TeeMsg_Labels                 :='Etykiety';
  TeeMsg_NoCircle               :='Bez obrysu';//okrÍgu;
  TeeMsg_Lines                  :='Linie';
  TeeMsg_Border                 :='KrawÍdü';

  TeeMsg_SmithResistance      :='OpÛr(Smith)';
  TeeMsg_SmithReactance       :='OpÛr bierny';
  
  TeeMsg_Column               :='Kolumna';

  { 5.01 }
  TeeMsg_Separator            :='Separator';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Lejkowy';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='przekroczony limit';
  TeeMsg_FunnelWithin         :=' wewnπtrz limitu';
  TeeMsg_FunnelBelow          :=' poniøej limitu';
  TeeMsg_CalendarSeries       :='Kalendarz';
  TeeMsg_DeltaPointSeries     :='Punkt delta';
  TeeMsg_ImagePointSeries     :='Punkt z obrazkiem';
  TeeMsg_ImageBarSeries       :='Kolumnowy'#13'z obrazem';
  TeeMsg_SeriesTextFieldZero  :='Tekst serii: Indeks pola powinien byÊ wiÍkszy niø zero.';

  { 5.02 }
  TeeMsg_Origin               :='Poczπtek';
  TeeMsg_Transparency         :='Przezroczysty';
  TeeMsg_Box                  :='Pude≥ko';
  TeeMsg_ExtrOut              :='Ekstrema';
  TeeMsg_MildOut              :='Wart. odstaj.';
  TeeMsg_PageNumber           :='Numer strony';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='jako &JPEG';
  TeeMsg_JPEGFilter    :='Pliki JPEG (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='jako &GIF';
  TeeMsg_GIFFilter     :='Pliki GIF (*.gif)|*.gif';
  TeeMsg_AsPNG         :='jako &PNG';
  TeeMsg_PNGFilter     :='Pliki PNG (*.png)|*.png';
  TeeMsg_AsPCX         :='jako PC&X';
  TeeMsg_PCXFilter     :='Pliki PCX (*.pcx)|*.pcx';

  { 5.03 }
  TeeMsg_Property            :='W≥aúciwoúci';
  TeeMsg_Value               :='WartoúÊ';
  TeeMsg_Yes                 :='Tak';
  TeeMsg_No                  :='Nie';
  TeeMsg_Image               :='(obrazek)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Ciπgnij punkt';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'ActiveX wersja ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Nie moøna zaimportowaÊ TeeChart z %s';
  TeeMsg_ActiveXVerbPrint    := '&Podglπd wydruku...';
  TeeMsg_ActiveXVerbExport   := 'E&xport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Pomoc...';
  TeeMsg_ActiveXVerbAbout    := '&O TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Kod b≥Ídu: %d úciπganie: %s';
  TeeMsg_DatasourceError     := 'èrÛd≥o danych TeeChart nie jest Seriπ lub RecordSetem';
  TeeMsg_SeriesTextSrcError  := 'Nieprawid≥owy typ serii';
  TeeMsg_AxisTextSrcError    := 'Nieprawid≥owy typ osi';
  TeeMsg_DelSeriesDatasource := 'Czy jesteú pewny, øe chcesz usunπÊ %s ?';
  TeeMsg_OCXNoPrinter        := 'Nie zainstalowano domyúlnej drukarki.';
  TeeMsg_ActiveXPictureNotValid:='Obraz jest nieprawid≥owy';
  {$ENDIF}

  // 6.0

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='jako &PDF';
  TeeMsg_PDFFilter        :='Pliki PDF (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='jako PostScript';
  TeeMsg_PSFilter         :='Pliki PostScript (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Warstwowy'#13'horyzontalny';
  TeeMsg_SelfStack        :='Zsumowany';
  TeeMsg_DarkPen          :='Ciemna krawÍdü';
  TeeMsg_SelectFolder     :='Wybierz folder bazy danych';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Po≥πczenie:';

  // 6.0

  TeeMsg_FunctionSmooth       :='Wyg≥adzanie';
  TeeMsg_FunctionCross        :='Punkty krzyøa';
  TeeMsg_GridTranspose        :='Transpozycja siatki 3D';
  TeeMsg_FunctionCompress     :='Kompresja';
  TeeMsg_ExtraLegendTool      :='Extra legenda';
  TeeMsg_FunctionCLV          :='ZamkniÍcie miejsce'#13'wartoúÊ (CLV)';
  TeeMsg_FunctionOBV          :='Balans'#13'wolumen (OBV)';
  TeeMsg_FunctionCCI          :='Towar'#13'indeks kana≥u (CCI)';
  TeeMsg_FunctionPVO          :='Wolumen'#13'oscylator (PVO)';
  TeeMsg_SeriesAnimTool       :='Animacja serii';
  TeeMsg_GalleryPointFigure   :='Punkty i liczby';
  TeeMsg_Up                   :='GÛra';
  TeeMsg_Down                 :='DÛ≥';
  TeeMsg_GanttTool            :='Ciπgnij Gantt';
  TeeMsg_XMLFile              :='Plik XML';
  TeeMsg_GridBandTool         :='Pasmo siatki';
  TeeMsg_FunctionPerf         :='Wykonanie';
  TeeMsg_GalleryGauge         :='Wskaünik';
  TeeMsg_GalleryGauges        :='Wskaüniki';
  TeeMsg_ValuesVectorEndZ     :='KoniecZ';
  TeeMsg_GalleryVector3D      :='Wektor 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Wieøa';
  TeeMsg_SingleColor          :='Jeden kolor';
  TeeMsg_Cover                :='Pokrywa i dno';//'Pokrywa';
  TeeMsg_Cone                 :='Stoøek';
  TeeMsg_PieTool              :='Wycinki ko≥a';


  // 7.0
  TeeMsg_Stop                 :='Stop';
  TeeMsg_Execute              :='Wykonaj !';
  TeeMsg_Themes               :='Tematy';
  TeeMsg_LightTool            :='Oúwietlenie 2D';
  TeeMsg_Current              :='Aktualny';
  TeeMsg_FunctionCorrelation  :='Korelacja';
  TeeMsg_FunctionVariance     :='Wariancja';
  TeeMsg_GalleryBubble3D      :='Bπbelki 3D';
  TeeMsg_GalleryHorizHistogram:='Histogram'#13'horyzontalny';
  TeeMsg_FunctionPerimeter    :='ObwÛd';
  TeeMsg_SurfaceNearestTool   :='Najbliøszy na powierzchni';
  TeeMsg_AxisScrollTool       :='Przesuwanie osi';
  TeeMsg_RectangleTool        :='Prostokπt';
  TeeMsg_GalleryPolarBar      :='Biegunowo-'#13'kolumnowy';
  TeeMsg_AsWapBitmap          :='Bitmapa WAP';
  TeeMsg_WapBMPFilter         :='Bitmapy WAP (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='ObciÍcie serii';
  TeeMsg_SeriesBandTool       :='Pasmo serii';

  // 7.01
  TeeMsg_ThemeFacts           :='Fakty';
  TeeMsg_FunctionDownSampling :='Kompresja prÛbkowania';

  // compatible with 7.05
  // missing translations added by masch(at)zg.pl 20.3.2005

  TeeMsg_Outline              :='Kontur';
  TeeMsg_AnnotationTool       :='Adnotacja';
  TeeMsg_AsVML                :='jako &VML (HTM)';
  TeeMsg_VMLFilter            :='Pliki VML (*.htm)|*.htm';
//  TeeMsg_AsSVG                :='jako &SVG (HTM)';
//  TeeMsg_SVGFilter            :='Pliki SVG (*.svg)|*.svg';
  TeeMsg_DefaultEditorSize    :='410';
  TeeMsg_Gradient             :='Gradient';
  TeeMsg_Options              :='&Opcje...';
  TeeMsg_TeeChartWizard       :='Kreator TeeChart';
  TeeMsg_TextFile             :='Plik tekstowy';
  TeeMsg_View2D               :='2D';
  TeeMsg_WantToSave           :='Czy chcesz zapisaÊ %s ?';



end;

Procedure TeeCreatePolish;
begin
  if not Assigned(TeePolishLanguage) then
  begin
    TeePolishLanguage:=TStringList.Create;
    TeePolishLanguage.Text:=

'GRADIENT EDITOR=Edytor gradientu'#13+
'GRADIENT=Gradient'#13+
'DIRECTION=Kierunek'#13+
'VISIBLE=Pokaø'#13+
'TOP BOTTOM=Z gÛry na dÛ≥'#13+
'BOTTOM TOP=Z do≥u do gÛry'#13+
'LEFT RIGHT=Z lewiej na prawo'#13+
'RIGHT LEFT=Z prawej na lewo'#13+
'FROM CENTER=Od úrodka'#13+
'FROM TOP LEFT=Z gÛrnego-lewego rogu'#13+
'FROM BOTTOM LEFT=Z dolnego-lewego rogu'#13+
'OK=OK'#13+
'CANCEL=Anuluj'#13+
'COLORS=Kolory'#13+
'START=Poczπtek'#13+
'MIDDLE=årodek'#13+
'END=Koniec'#13+
'SWAP=ZamieÒ'#13+
'NO MIDDLE=Bez úrodka'#13+
'TEEFONT EDITOR=Edytor czcionki'#13+
'INTER-CHAR SPACING=OdstÍp miÍdzyznakowy'#13+
'FONT=Czcionka'#13+
'SHADOW=CieÒ'#13+
'HORIZ. SIZE=Rozmiar poziomy'#13+
'VERT. SIZE=Rozmiar pionowy'#13+
'COLOR=Kolor'#13+
'OUTLINE=Kontur'#13+
'OPTIONS=Opcje'#13+
'FORMAT=Format'#13+
'TEXT=Tekst'#13+
'POSITION=Pozycja'#13+
'LEFT=Lewo'#13+
'TOP=GÛra'#13+
'AUTO=Automatycz.'#13+
'CUSTOM=Uøytkownika'#13+
'LEFT TOP=Lewy gÛrny'#13+
'LEFT BOTTOM=Lewy dolny'#13+
'RIGHT TOP=Prawy gÛrny'#13+
'RIGHT BOTTOM=Prawy dolny'#13+
'MULTIPLE AREAS=Wiele powierzchni'#13+
'NONE=Brak'#13+
'STACKED=Skumulowany'#13+
'STACKED 100%=Skumulowany 100%'#13+
'AREA=Powierzchnia'#13+
'PATTERN=WzÛr'#13+
'STAIRS=Schody'#13+
'SOLID=Pe≥ny'#13+
'CLEAR=Pusty'#13+
'HORIZONTAL=W poziomie'#13+
'VERTICAL=W pionie'#13+
'DIAGONAL=Ukoúny'#13+
'B.DIAGONAL=Ukoúny odw.'#13+
'CROSS=Krzyø'#13+
'DIAG.CROSS=Ukoúny krzyø'#13+
'AREA LINES=Linie punktÛw'#13+
'BORDER=KrawÍdü'#13+
'INVERTED=OdwrÛcony'#13+
'COLOR EACH=Koloruj kaødy'#13+
'ORIGIN=Poczπtek'#13+
'USE ORIGIN=Uøyj poczπtku'#13+
'WIDTH=SzerokoúÊ'#13+
'HEIGHT=WysokoúÊ'#13+
'AXIS=Oú'#13+
'LENGTH=D≥ugoúÊ'#13+
'SCROLL=Przesuwanie'#13+
'BOTH=Oba'#13+
'AXIS INCREMENT=Przyrost osi'#13+
'INCREMENT=Przyrost'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Jedna milisekunda'#13+
'ONE SECOND=Jedna sekunda'#13+
'FIVE SECONDS=PiÍÊ sekund'#13+
'TEN SECONDS=DziesiÍÊ sekund'#13+
'FIFTEEN SECONDS=PiÍtnaúcie sekund'#13+
'THIRTY SECONDS=Trzydzieúci sekund'#13+
'ONE MINUTE=Jedna minuta'#13+
'FIVE MINUTES=PiÍÊ minut'#13+
'TEN MINUTES=DziesÍÊ minut'#13+
'FIFTEEN MINUTES=PiÍtnaúcie minut'#13+
'THIRTY MINUTES=Trzydzieúci minut'#13+
'ONE HOUR=Jedna godzina'#13+
'TWO HOURS=Dwie godziny'#13+
'SIX HOURS=SzeúÊ godzina'#13+
'TWELVE HOURS=Dwanaúcie godzin'#13+
'ONE DAY=Jeden dzieÒ'#13+
'TWO DAYS=Dwa dni'#13+
'THREE DAYS=Trzy dni'#13+
'ONE WEEK=Jeden tydzieÒ'#13+
'HALF MONTH=PÛ≥ miesiπca'#13+
'ONE MONTH=Jeden miesiπc'#13+
'TWO MONTHS=Dwa miesiπce'#13+
'THREE MONTHS=Trzy miesiπce'#13+
'FOUR MONTHS=Cztery miesiπce'#13+
'SIX MONTHS=SzeúÊ miesiÍcy'#13+
'ONE YEAR=Jeden rok'#13+
'EXACT DATE TIME=Dok≥adna data/czas'#13+
'AXIS MAXIMUM AND MINIMUM=Maksimum i minimum osi'#13+
'VALUE=WartoúÊ'#13+
'TIME=Czas'#13+
'LEFT AXIS=Oú lewa'#13+
'RIGHT AXIS=Oú prawa'#13+
'TOP AXIS=Oú gÛrna'#13+
'BOTTOM AXIS=Oú dolna'#13+
'% BAR WIDTH=SzerokoúÊ %'#13+
'STYLE=Styl'#13+
'% BAR OFFSET=PrzesuniÍcie %'#13+
'RECTANGLE=Prostokπt'#13+
'PYRAMID=Piramida'#13+
'INVERT. PYRAMID=OdwrÛcona piramida'#13+
'CYLINDER=Cylinder'#13+
'ELLIPSE=Elipsa'#13+
'ARROW=Strza≥ka'#13+
'RECT. GRADIENT=Prostokπt z gradientem'#13+
'CONE=Stoøek'#13+
'DARK BAR 3D SIDES=Ciemne boki kolumny 3D'#13+
'BAR SIDE MARGINS=Boczne marginesy kolumny'#13+
'AUTO MARK POSITION=Autom. pozycja znacznika'#13+
'JOIN=Po≥πcz'#13+
'DATASET=ZbiÛr danych'#13+
'APPLY=Zastosuj'#13+
'SOURCE=èrÛd≥o'#13+
'MONOCHROME=Monochromatyczny'#13+
'DEFAULT=Domyúlnie'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Mediana'#13+
'WHISKER=Wπsy'#13+
'PATTERN COLOR EDITOR=Edytor koloru wzoru'#13+
'IMAGE=Obraz'#13+
'BACK DIAGONAL=Ukoúny odwrotny'#13+
'DIAGONAL CROSS=Siatka ukoúna'#13+
'FILL 80%=Wype≥nienie 80%'#13+
'FILL 60%=Wype≥nienie 60%'#13+
'FILL 40%=Wype≥nienie 40%'#13+
'FILL 20%=Wype≥nienie 20%'#13+
'FILL 10%=Wype≥nienie 10%'#13+
'ZIG ZAG=Zygzak'#13+
'VERTICAL SMALL=Pionowy drobny'#13+
'HORIZ. SMALL=Poziomy drobny'#13+
'DIAG. SMALL=Ukoúny drobny'#13+
'BACK DIAG. SMALL=Ukoúny odwr. drobny'#13+
'CROSS SMALL=Drobna siatka'#13+
'DIAG. CROSS SMALL=Drobna siatka ukoúna'#13+
'DAYS=Dni'#13+
'WEEKDAYS=Dni tygodnia'#13+
'TODAY=Dziú'#13+
'SUNDAY=Niedziela'#13+
'TRAILING=Dni poúrednie'#13+
'MONTHS=Miesiπce'#13+
'LINES=Linie'#13+
'SHOW WEEKDAYS=Dni tygodnia'#13+
'UPPERCASE=Duøe litery'#13+
'TRAILING DAYS=Dni poúrednie'#13+
'SHOW TODAY=Pokaø dzisiaj'#13+
'SHOW MONTHS=Pokaø miesiπce'#13+
'CANDLE WIDTH=SzerokoúÊ s≥upka'#13+
'STICK=Sztyft'#13+
'BAR=Kolumna'#13+
'OPEN CLOSE=Otwar.-zamkn.'#13+
'UP CLOSE=GÛra zamkniÍcia'#13+
'DOWN CLOSE=DÛ≥ zamkniÍcia'#13+
'SHOW OPEN=Pokaø otwarcie'#13+
'SHOW CLOSE=Pokaø zamkniÍcie'#13+
'DRAW 3D=3D'#13+
'DARK 3D=Ciemny bok 3D'#13+
'EDITING=Edycja'#13+
'CHART=Wykres'#13+
'SERIES=Serie'#13+
'DATA=Dane'#13+
'TOOLS=NarzÍdzia'#13+
'EXPORT=Eksport'#13+
'PRINT=Drukowanie'#13+
'GENERAL=OgÛlne'#13+
'TITLES=Tytu≥'#13+
'LEGEND=Legenda'#13+
'PANEL=Panel'#13+
'PAGING=Strona'#13+
'WALLS=åciana'#13+
'3D=3D'#13+
'ADD=Dodaj'#13+
'DELETE=UsuÒ'#13+
'TITLE=Tytu≥'#13+
'CLONE=Powiel'#13+
'CHANGE=ZmieÒ'#13+
'HELP=Pomoc'#13+
'CLOSE=Zamknij'#13+
'TEECHART PRINT PREVIEW=Podglπd wydruku TeeChart'#13+
'PRINTER=Drukarka'#13+
'SETUP=Ustawienia'#13+
'ORIENTATION=Orientacja'#13+
'PORTRAIT=Pionowo'#13+
'LANDSCAPE=Poziomo'#13+
'MARGINS (%)=Marginesy (%)'#13+
'DETAIL=SzczegÛ≥y'#13+
'MORE=WiÍcej'#13+
'NORMAL=Normalnie'#13+
'RESET MARGINS=Resetuj marginesy'#13+
'VIEW MARGINS=Pokaø marginesy'#13+
'PROPORTIONAL=Proporcjonalnie'#13+
'CIRCLE=Ko≥o'#13+
'VERTICAL LINE=Linia pionowa'#13+
'HORIZ. LINE=Linia pozioma'#13+
'TRIANGLE=TrÛkat'#13+
'INVERT. TRIANGLE=OdwrÛcony trÛkπt'#13+
'LINE=Linia'#13+
'DIAMOND=Diament'#13+
'CUBE=Szeúcian'#13+
'STAR=Gwiazda'#13+
'TRANSPARENT=Przezroczysty'#13+
'HORIZ. ALIGNMENT=Po≥oøenie poziome'#13+
'CENTER=årodek'#13+
'RIGHT=Prawo'#13+
'ROUND RECTANGLE=Zaokrπglony prostokπt'#13+
'ALIGNMENT=P≥oøenie'#13+
'BOTTOM=DÛ≥'#13+
'UNITS=Jednostki'#13+
'PIXELS=Piksele'#13+
'AXIS ORIGIN=Poczπtek osi'#13+
'ROTATION=ObrÛt'#13+
'CIRCLED=Okrπg≥y'#13+
'3 DIMENSIONS=3D'#13+
'RADIUS=PromieÒ'#13+
'ANGLE INCREMENT=Przyrost kπta'#13+
'RADIUS INCREMENT=Przyrost promienia'#13+
'CLOSE CIRCLE=Zamknij ko≥o'#13+
'PEN=PiÛrko'#13+
'LABELS=Etykiety'#13+
'ROTATED=ObrÛcone'#13+
'CLOCKWISE=Z ruchem wskaz.'#13+
'INSIDE=Wewnπtrz'#13+
'ROMAN=Rzymskie'#13+
'HOURS=Godziny'#13+
'MINUTES=Minuty'#13+
'SECONDS=Sekundy'#13+
'START VALUE=WartoúÊ pocz.'#13+
'END VALUE=WartoúÊ koÒc.'#13+
'TRANSPARENCY=PrzezroczystoúÊ'#13+
'DRAW BEHIND=Rysuj w tle'#13+
'COLOR MODE=Tryb koloru'#13+
'STEPS=Kroki'#13+
'RANGE=Zakres'#13+
'PALETTE=Paleta'#13+
'PALE=Blado'#13+
'STRONG=Mocno'#13+
'GRID SIZE=Rozmiar siatki'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=G≥Íbok.'#13+
'IRREGULAR=Nieregularny'#13+
'GRID=Siatka'#13+
'ALLOW DRAG=PozwÛl przeciπgaÊ'#13+
'VERTICAL POSITION=Pozycja pionowa'#13+
'LEVELS POSITION=Podziel na poziomy'#13+
'LEVELS=Poziomy'#13+
'NUMBER=Liczba'#13+
'LEVEL=Poziom'#13+
'AUTOMATIC=Automatycz.'#13+
'SNAP=Przyciπgaj'#13+
'FOLLOW MOUSE=Podπøaj za myszπ'#13+
'STACK=Skumulowany'#13+
'HEIGHT 3D=WysokoúÊ 3D'#13+
'LINE MODE=Tryb linii'#13+
'OVERLAP=Na≥Ûø'#13+
'STACK 100%=Skumulowany 100%'#13+
'CLICKABLE=Moøna klikaÊ'#13+
'AVAILABLE=DostÍpne'#13+
'SELECTED=Wybrane'#13+
'DATASOURCE=èrÛd≥o danych'#13+
'GROUP BY=Grupuj wg'#13+
'CALC=Licz.'#13+
'OF=z'#13+
'SUM=Sumuj'#13+
'COUNT=IloúÊ'#13+
'HIGH=Wysoko'#13+
'LOW=Nisko'#13+
'AVG=årednio'#13+
'HOUR=Godz.'#13+
'DAY=DzieÒ'#13+
'WEEK=TydzieÒ'#13+
'WEEKDAY=DzieÒ tygodnia'#13+
'MONTH=Miesiπc'#13+
'QUARTER=Kwarta≥'#13+
'YEAR=Rok'#13+
'HOLE %=OtwÛr %'#13+
'RESET POSITIONS=Resetuj pozycje'#13+
'MOUSE BUTTON=Przycisk myszy'#13+
'ENABLE DRAWING=PozwÛl rysowaÊ'#13+
'ENABLE SELECT=PozwÛl wybieraÊ'#13+
'ENHANCED=Rozszerzony'#13+
'ERROR WIDTH=SzerokoúÊ b≥Ídu'#13+
'WIDTH UNITS=Jedn. szerokoúci'#13+
'PERCENT=Procenty'#13+
'LEFT AND RIGHT=Lewo i Prawo'#13+
'TOP AND BOTTOM=GÛra i DÛ≥'#13+
'BORDER EDITOR=Edytor krawÍdzi'#13+
'DASH=Kreska'#13+
'DOT=Kropka'#13+
'DASH DOT=Kreska Kropka'#13+
'DASH DOT DOT=Kreska Kropka Kropka'#13+
'CALCULATE EVERY=Oblicz kaødy'#13+
'ALL POINTS=Wszystkie punkty'#13+
'NUMBER OF POINTS=Liczba punktÛw'#13+
'RANGE OF VALUES=Zakres wartoúci'#13+
'FIRST=Pierwszy'#13+
'LAST=Ostatni'#13+
'TEEPREVIEW EDITOR=Edytor Tee-podglπdu'#13+
'ALLOW MOVE=PozwÛl przesuwaÊ'#13+
'ALLOW RESIZE=PozwÛl zmieniaÊ rozmiar'#13+
'DRAG IMAGE=Ciπgnij obraz'#13+
'AS BITMAP=Jako bitmapa'#13+
'SHOW IMAGE=Pokaø obraz'#13+
'MARGINS=Marginesy'#13+
'SIZE=Rozmiar'#13+
'3D %=3D %'#13+
'ZOOM=PowiÍksz.'#13+
'ELEVATION=Wzniesienie'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Przes. poziome'#13+
'VERT. OFFSET=Przes. pionowe'#13+
'PERSPECTIVE=Perspektywa'#13+
'ANGLE=Kπt'#13+
'ORTHOGONAL=Ortogonalny'#13+
'ZOOM TEXT=Skala tekstu'#13+
'SCALES=Skale'#13+
'TICKS=Podzia≥ka'#13+
'MINOR=Drobna podzia≥ka'#13+
'MAXIMUM=Maksimum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Poøπdany przyrost'#13+
'(INCREMENT)=(przyrost)'#13+
'LOG BASE=Podstawa log'#13+
'LOGARITHMIC=Logarytmiczny'#13+
'MIN. SEPARATION %=Minimalny odstÍp %'#13+
'MULTI-LINE=Wieloliniowy'#13+
'LABEL ON AXIS=Etykiety na osi'#13+
'ROUND FIRST=Zaokrπglij pierwszπ'#13+
'MARK=Znaczniki'#13+
'LABELS FORMAT=Format etykiet'#13+
'EXPONENTIAL=Wyk≥adniczy'#13+
'DEFAULT ALIGNMENT=Domyúlne po≥oøenie'#13+
'LEN=D≥ug.'#13+
'INNER=Wewnπtrz'#13+
'AT LABELS ONLY=Tylko przy etykietach'#13+
'CENTERED=Wyúrodkowany'#13+
'POSITION %=Pozycja %'#13+
'START %=Poczπtek %'#13+
'END %=Koniec %'#13+
'OTHER SIDE=Druga strona'#13+
'AXES=Osie'#13+
'BEHIND=Z ty≥u'#13+
'CLIP POINTS=Obetnij wykres'#13+
'PRINT PREVIEW=Podglπd wydruku'#13+
'MINIMUM PIXELS=Minimum pikseli'#13+
'ALLOW=PozwÛl'#13+
'ANIMATED=Animowany'#13+
'ALLOW SCROLL=PozwÛl przesuwaÊ'#13+
'TEEOPENGL EDITOR=Edytor TeeOpenGL'#13+
'AMBIENT LIGHT=Oúwietlenie'#13+
'SHININESS=Po≥ysk'#13+
'FONT 3D DEPTH=G≥ÍbokoúÊ czcionki 3D'#13+
'ACTIVE=Aktywny'#13+
'FONT OUTLINES=Kontur czcionki'#13+
'SMOOTH SHADING=P≥ynne cieniowanie'#13+
'LIGHT=åwiat≥o'#13+
'Y=Y'#13+
'INTENSITY=Intensyw.'#13

{$IFDEF LCL}
;  TeePolishLanguage.Text:=TeePolishLanguage.Text
{$ENDIF}

+
'BEVEL=Skos'#13+
'FRAME=Ramka'#13+
'ROUND FRAME=Zaokrπglona ramka'#13+
'LOWERED=Obniøony'#13+
'RAISED=Podniesiony'#13+
'SYMBOLS=Symbole'#13+
'TEXT STYLE=Styl tekstu'#13+
'LEGEND STYLE=Styl legendy'#13+
'VERT. SPACING=OdstÍp pionowy'#13+
'SERIES NAMES=Nazwy serii'#13+
'SERIES VALUES=Wartoúci serii'#13+
'LAST VALUES=Ostatnie wartoúci'#13+
'PLAIN=Zwyk≥y'#13+
'LEFT VALUE=Lewo wartoúÊ'#13+
'RIGHT VALUE=Prawo wartoúÊ'#13+
'LEFT PERCENT=Lewo procent'#13+
'RIGHT PERCENT=Prawo procent'#13+
'X VALUE=X wartoúÊ'#13+
'X AND VALUE=X i wartoúÊ'#13+
'X AND PERCENT=X i procent'#13+
'CHECK BOXES=Pola wielokrot. wyboru'#13+
'DIVIDING LINES=Linie podzia≥u'#13+
'FONT SERIES COLOR=Koloruj kolorem serii'#13+
'POSITION OFFSET %=PrzesuniÍcie %'#13+
'MARGIN=Margines'#13+
'RESIZE CHART=Przeskaluj wykres'#13+
'CONTINUOUS=Ciπg≥y'#13+
'POINTS PER PAGE=PunktÛw na stronÍ'#13+
'SCALE LAST PAGE=Skaluj ostatniπ stronÍ'#13+
'CURRENT PAGE LEGEND=Legenda tylko dla bieøacej str.'#13+
'PANEL EDITOR=Edytor panelu'#13+
'BACKGROUND=T≥o'#13+
'BORDERS=KrawÍdzie'#13+
'BACK IMAGE=Obraz w tle'#13+
'STRETCH=Rozciπgnij'#13+
'TILE=Wype≥nij'#13+
'BEVEL INNER=Skos wewn.'#13+
'BEVEL OUTER=Skos zewn.'#13+
'MARKS=Znaczniki'#13+
'DATA SOURCE=èrÛd≥o danych'#13+
'SORT=Sortuj'#13+
'CURSOR=Kursor'#13+
'SHOW IN LEGEND=Pokaø w legendzie'#13+
'FORMATS=Formaty'#13+
'VALUES=Wartoúci'#13+
'PERCENTS=Procenty'#13+
'HORIZONTAL AXIS=Oú pozioma'#13+
'DATETIME=Data/czas'#13+
'VERTICAL AXIS=Oú pionowa'#13+
'ASCENDING=Rosnπco'#13+
'DESCENDING=Malejπco'#13+
'DRAW EVERY=Rysuj co'#13+
'CLIPPED=ObciÍty'#13+
'ARROWS=Strza≥ki'#13+
'MULTI LINE=Wieloliniowy'#13+
'ALL SERIES VISIBLE=Pokaø dla wszystkich serii'#13+
'LABEL=Etykieta'#13+
'LABEL AND PERCENT=Etykieta i procent'#13+
'LABEL AND VALUE=Etykieta i wartoúÊ'#13+
'PERCENT TOTAL=Procent ca≥oúci'#13+
'LABEL AND PERCENT TOTAL=Etykieta i procent ca≥oúci'#13+
'X AND Y VALUES=X i Y WartoúÊ'#13+
'MANUAL=RÍcznie'#13+
'RANDOM=Losowo'#13+
'FUNCTION=Funkcja'#13+
'NEW=Nowy'#13+
'EDIT=Edytuj'#13+
'PERSISTENT=Trwa≥y'#13+
'ADJUST FRAME=Dopasuj ramkÍ'#13+
'SUBTITLE=Podtytu≥'#13+
'SUBFOOT=Stopka 2'#13+
'FOOT=Stopka'#13+
'VISIBLE WALLS=åciany widoczne'#13+
'BACK=Z ty≥u'#13+
'DIF. LIMIT=Limit'#13+
'ABOVE=Powyøej'#13+
'WITHIN=Wewnπtrz'#13+
'BELOW=Poniøej'#13+
'CONNECTING LINES=Linie ≥πczπce'#13+
'BROWSE=Szukaj w'#13+
'TILED=Wype≥niony'#13+
'INFLATE MARGINS=ZwiÍksz marginesy'#13+
'SQUARE=Kwadrat'#13+
'DOWN TRIANGLE=OdwrÛcony trÛjkπt'#13+
'SMALL DOT=Ma≥e kropki'#13+
'GLOBAL=Globalny'#13+
'SHAPES=Kszta≥ty'#13+
'BRUSH=PÍdzel'#13+
'DELAY=OpÛünienie'#13+
'MSEC.=msek.'#13+
'MOUSE ACTION=Akcja myszy'#13+
'MOVE=PrzesuÒ'#13+
'CLICK=Klik'#13+
'DRAW LINE=Rysuj linie'#13+
'EXPLODE BIGGEST=WysuÒ najwiÍkszy'#13+
'TOTAL ANGLE=Kπt sumaryczny'#13+
'GROUP SLICES=Grupuj wycinki'#13+
'BELOW %=Poniøej %'#13+
'BELOW VALUE=Poniøej wartoúci'#13+
'OTHER=Inne'#13+
'PATTERNS=Wzory'#13+
'SIZE %=Rozmiar %'#13+
'SERIES DATASOURCE TEXT EDITOR=Edytor tekstu zrÛde≥ danych serii'#13+
'FIELDS=Pola'#13+
'NUMBER OF HEADER LINES=IloúÊ linii nag≥Ûwka'#13+
'SEPARATOR=Separator'#13+
'COMMA=Przecinek'#13+
'SPACE=PrzestrzeÒ'#13+
'TAB=Tabulator'#13+
'FILE=Plik'#13+
'WEB URL=Web URL'#13+
'LOAD=Za≥aduj'#13+
'C LABELS=C Etykiety'#13+
'R LABELS=R Etykiety'#13+
'C PEN=C PiÛrko'#13+
'R PEN=R PiÛrko'#13+
'STACK GROUP=Grupowanie'#13+
'MULTIPLE BAR=Wiele kolumn'#13+
'SIDE=Sπsiadujπco'#13+
'SIDE ALL=Sπsiad. wszystkie'#13+
'DRAWING MODE=Tryb rysowania'#13+
'WIREFRAME=Siatka druciana'#13+
'DOTFRAME=Siatka punktowa'#13+
'SMOOTH PALETTE=Wyg≥adü paletÍ'#13+
'SIDE BRUSH=PÍdzel boczny'#13+
'ABOUT TEECHART PRO V7.0=O TeeChart Pro v7.0...'#13+
'ALL RIGHTS RESERVED.=Wczystkie Prawa Zastrzeøone.'#13+
'VISIT OUR WEB SITE !=Odwiedü naszπ witrynÍ!'#13+
'TEECHART WIZARD=TeeChart Kreator'#13+
'SELECT A CHART STYLE=Wybierz styl wykresu'#13+
'DATABASE CHART=Wykres bazodanowy'#13+
'NON DATABASE CHART=Wykres nie bazodanowy'#13+
'SELECT A DATABASE TABLE=Wybierz tabelÍ bazy danych'#13+
'ALIAS=Alias'#13+
'TABLE=Tabela'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Wybierz pola do wykresu'#13+
'SELECT A TEXT LABELS FIELD=Wybierz pole z tekstem etykiet'#13+
'CHOOSE THE DESIRED CHART TYPE=Wybierz typ wykresu'#13+
'2D=2D'#13+
'CHART PREVIEW=Podglπd wykresu'#13+
'SHOW LEGEND=Pokaø legendÍ'#13+
'SHOW MARKS=Pokaø znaczniki'#13+
'< BACK=< Wstecz'#13+
'EXPORT CHART=Eksportuj wykres'#13+
'PICTURE=Obraz'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Zachowaj proporcje'#13+
'INCLUDE SERIES DATA=Do≥πcz dane serii'#13+
'FILE SIZE=Rozmiar pliku'#13+
'DELIMITER=Separator'#13+
'XML=XML'#13+
'HTML TABLE=Tabela HTML'#13+
'EXCEL=Excel'#13+
'COLON=Dwukropek'#13+
'INCLUDE=Do≥πcz'#13+
'POINT LABELS=Etykiety punktu'#13+
'POINT INDEX=Indeks punktu'#13+
'HEADER=Nag≥Ûwek'#13+
'COPY=Kopiuj'#13+
'SAVE=Zapisz'#13+
'SEND=Wyúlij'#13+
'FUNCTIONS=Funkcje'#13+
'ADX=ADX'#13+
'AVERAGE=årednia'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Podziel'#13+
'EXP. AVERAGE=årednia exp.'#13+
'EXP.MOV.AVRG.=årednia exp. ruch.'#13+
'MACD=MACD'#13+
'MOMENTUM=PÍd'#13+
'MOMENTUM DIV=PÍd (div.)'#13+
'MOVING AVRG.=årednia ruchoma'#13+
'MULTIPLY=PomnÛø'#13+
'R.S.I.=R.S.I'#13+
'ROOT MEAN SQ.=åred.pierw.kw.'#13+
'STD.DEVIATION=Odchylenie stand.'#13+
'STOCHASTIC=Stochastyczny'#13+
'SUBTRACT=Odejmij'#13+
'SOURCE SERIES=èrÛd≥o serii'#13+
'TEECHART GALLERY=Galeria TeeChart'#13+
'DITHER=Dithering'#13+
'REDUCTION=Redukcja'#13+
'COMPRESSION=Kompresja'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Najbliøszy'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Szary'#13+
'GRAY SCALE=Skala szaroúci'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Kwantyzuj'#13+
'QUANTIZE 256=Kwantyzuj 256'#13+
'% QUALITY=% jakoúci'#13+
'PERFORMANCE=WydajnoúÊ'#13+
'QUALITY=JakoúÊ'#13+
'SPEED=PrÍdkoúÊ'#13+
'COMPRESSION LEVEL=Poziom kompresji'#13+
'CHART TOOLS GALLERY=Galeria narzÍdzi wykresu'#13+
'ANNOTATION=Adnotacja'#13+
'AXIS ARROWS=Strza≥ki osi'#13+
'COLOR BAND=Koloruj pasmo'#13+
'COLOR LINE=Koloruj linie'#13+
'DRAG MARKS=Ciπgnij znaczniki'#13+
'MARK TIPS=Dymki ze znacznikiem'#13+
'NEAREST POINT=Najbliøszy punkt'#13+
'ROTATE=ObrÛÊ'#13+
'YES=Tak'#13+

{$IFDEF TEEOCX}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- Wybierz ørod≥o danych ADO'#13+
'CONNECTION=Po≥πczenie'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=Tabele systemowe'#13+
'LOGIN PROMPT=Login'#13+
'SELECT=Wybierz'#13+
'TEECHART IMPORT=TeeChart import'#13+
'IMPORT CHART FROM=Importuj wykres z'#13+
'IMPORT NOW=Importuj teraz'#13+
'EDIT CHART=Edytuj wykres'#13+
{$ENDIF}

// 6.0
'BEVEL SIZE=Rozmiar skosu'#13+
'DELETE ROW=UsuÒ wiersz'#13+
'VOLUME SERIES=Pasmowy'#13+
'SINGLE=Pojedynczy'#13+
'REMOVE CUSTOM COLORS=UsuÒ kolory uøytkownika'#13+
'USE PALETTE MINIMUM=Uøyj minimum dla palety'#13+
'AXIS MAXIMUM=Maksimum osi'#13+
'AXIS CENTER=årodek osi'#13+
'AXIS MINIMUM=Minimum osi'#13+
'DAILY (NONE)=Dziennie (brak)'#13+
'WEEKLY=Tygodniowo'#13+
'MONTHLY=MiesiÍcznie'#13+
'BI-MONTHLY=DwumiesiÍcznie'#13+
'QUARTERLY=Kwartalnie'#13+
'YEARLY=Rocznie'#13+
'DATETIME PERIOD=Okres daty/czasu'#13+
'CASE SENSITIVE=RozrÛøniaj wielkoúÊ liter'#13+
'DRAG STYLE=Kierunek przeciπgania'#13+
'SQUARED=Kwadratowy'#13+
'GRID 3D SERIES=Siatka 3D'#13+
'DARK BORDER=Ciemna krawÍdü'#13+
'PIE SERIES=Wycinek ko≥a'#13+
'FOCUS=Podúwietl'#13+
'EXPLODE=RozsuÒ'#13+
'FACTOR=JasnoúÊ'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Wykres z szablonu (*.tee)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=OtwÛrz plik szablonu z'#13+
'BINARY=Binarny'#13+
'VOLUME OSCILLATOR=Oscylator wolumenu'#13+
'PIE SLICES=Wycinki ko≥a'#13+
'ARROW WIDTH=SzerokoúÊ strza≥ki'#13+
'ARROW HEIGHT=WysokoúÊ strza≥ki'#13+
'DEFAULT COLOR=Domyúlny kolor'#13+
'PERIOD=Okres'#13+
'UP=GÛra'#13+
'DOWN=DÛ≥'#13+
'SHADOW EDITOR=Edytor cienia'#13+
'CALLOUT=Strza≥ka'#13+//odsy≥acz?
'TEXT ALIGNMENT=WyrÛwnanie tekstu'#13+
'DISTANCE=Odleg≥oúÊ'#13+
'ARROW HEAD=Koniec strza≥ki'#13+
'POINTER=Wskaünik'#13+
'AVAILABLE LANGUAGES=DostÍpne jÍzyki'#13+
'CHOOSE A LANGUAGE=Wybierz jÍzyk'#13+
'CALCULATE USING=Oblicz uøywajπc'#13+
'EVERY NUMBER OF POINTS=Co zadanπ liczbÍ punktÛw'#13+
'EVERY RANGE=Kaødy zakres'#13+
'INCLUDE NULL VALUES=UwzglÍdniaj puste wartoúci'#13+
'INVERTED SCROLL=Odwrotne przesuwanie'#13+
'ONE MICROSECOND=Jedna mikrosekunda'#13+
'DATE=Data'#13+
'ENTER DATE=Wprowadü datÍ'#13+
'ENTER TIME=Wprowadü czas'#13+
'SLANT CUBE=Ukoúny szeúcian'#13+
'INVERT. ARROW=OdwrÛcona strza≥ka'#13+
'INVERT. CONE=OdwrÛcony stoøek'#13+
'TICK LINES=Linie podzia≥ki'#13+
'% BAR DEPTH=G≥ÍbokoúÊ %'#13+
'DEVIATION=Odchylenie'#13+
'UPPER=GÛrny'#13+
'LOWER=Dolny'#13+
'METAL=Metal'#13+
'WOOD=Drewno'#13+
'STONE=KamieÒ'#13+
'CLOUDS=Chmury'#13+
'GRASS=Trawa'#13+
'FIRE=OgieÒ'#13+
'SNOW=ånieg'#13+
'NOTHING=Brak'#13+
'LEFT TRIANGLE=TrÛjkπt lewy'#13+
'RIGHT TRIANGLE=TrÛjkπt prawy'#13+
'SHOW PREVIOUS BUTTON=Pokaø poprzedni przycisk'#13+
'SHOW NEXT BUTTON=Pokaø nastÍpny przycisk'#13+
'HIGH-LOW=Wysoko-nisko'#13+
'COLOR STYLE=Styl koloru'#13+
'RELATIVE TO OPEN=WzglÍdem otwarcia'#13+
'RELATIVE TO PREVIOUS CLOSE=WzglÍd. poprzed. zamkniÍcia'#13+
'CONSTANT=Sta≥a'#13+
'VIEW SERIES NAMES=Pokaø nazwy serii'#13+
'SHOW LABELS=Pokaø etykiety'#13+
'SHOW COLORS=Pokaø kolory'#13+
'XYZ SERIES=Serie XYZ'#13+
'SHOW X VALUES=Pokaø wartoúci X'#13+
'EDIT COLOR=Edytuj kolor'#13+
'MAKE NULL POINT=UtwÛrz pusty punkt'#13+
'APPEND ROW=Do≥πcz wiersz'#13+
'TEXT FONT=Czcionka tekstu'#13+
'SMOOTH=Wyg≥adü'#13+
'CHART THEME SELECTOR=WybÛr tematu wykresu'#13+
'PREVIEW=Podglπd'#13+
'THEMES=Tematy'#13+
'COLOR PALETTE=Paleta kolorÛw'#13+
'VIEW 3D=Widok 3D'#13+
'SCALE=Skaluj'#13+
'MARGIN %=% marginesu'#13+
'ACCUMULATE=Akumuluj'#13+
'DRAW BEHIND AXES=Rysuj przed osiami'#13+
'GRID EVERY=Siatka co'#13+
'DRAG REPAINT=Odúwieøaj przy przeciπganiu'#13+
'NO LIMIT DRAG=Nie ograniczaj przeciπgania'#13+
'DATE PERIOD=Okres daty'#13+
'TIME PERIOD=Okres czasu'#13+
'INTERPOLATE=Interpoluj'#13+
'CLICK TOLERANCE=Obszar klikniÍcia'#13+
'USE SERIES Z=Uøyj serii Z'#13+
'START X=Poczπtek X'#13+
'STEP=Krok'#13+
'NUM. POINTS=IloúÊ punktÛw'#13+
'COLOR EACH LINE=Koloruj kaødπ liniÍ'#13+
'SORT BY=Sortuj wg'#13+
'(NONE)=(brak)'#13+
'CALCULATION=Obliczenia'#13+
'GROUP=Grupa'#13+
'SELECT NEW LINES=Zaznacz nowe linie'#13+
'WEIGHT=Waga'#13+
'EDIT LEGEND=Edytuj legendÍ'#13+
'ROUND=Okrπg≥y'#13+
'FLAT=P≥aski'#13+
'DRAW ALL=Rysuj wszystkie'#13+
'IGNORE NULLS=Ignoruj puste wartoúci'#13+
'NUMERIC FORMAT=Format dla tekstu'#13+
'D.M.YYYY=dd.mm.yyyy'#13+
'DATE TIME=Data/czas'#13+
'GEOGRAPHIC=Geograficzny'#13+
'DECIMALS=DziesiÍtne'#13+
'FIXED=Sta≥e'#13+
'THOUSANDS=Tysiπce'#13+
'CURRENCY=Waluta'#13+
'VIEWS=Widoki'#13+
'OFFSET=PrzesuniÍcie'#13+
'ALTERNATE=Alternatywnie'#13+
'ZOOM ON UP LEFT DRAG=PowiÍksz przy ciπgn. w lewy gÛrny rÛg'#13+
'LIGHT 0=åwiat≥o 0'#13+
'LIGHT 1=åwiat≥o 1'#13+
'LIGHT 2=åwiat≥o 2'#13+
'FIXED POSITION=Sta≥a pozycja'#13+
'DRAW STYLE=Styl rysowania'#13+
'POINTS=Punkty'#13+
'NO CHECK BOXES=Brak pÛl wyboru'#13+
'RADIO BUTTONS=Pola pojedyÒczego wyboru'#13+
'DEFAULT BORDER=Domyúlna krawÍdü'#13+
'SHOW PAGE NUMBER=Pokaø numer strony'#13+
'SEPARATION=OdstÍp'#13+
'ROUND BORDER=Zaokrπglona krawÍdü'#13+
'Z DATETIME=Oú Z jako data/czas'#13+
'NUMBER OF SAMPLE VALUES=IloúÊ losowych danych'#13+
'AUTO HIDE=Auto-ukrywanie'#13+
'RESIZE PIXELS TOLERANCE=Tolerancja przy przeciπganiu'#13+
'FULL REPAINT=Wype≥nij kolorem'#13+
'END POINT=Punkt koÒcowy'#13+
'GALLERY=Galeria'#13+
'INVERTED GRAY=OdwrÛcona szaroúÊ'#13+
'RAINBOW=TÍcza'#13+
'BAND 1=Pasmo 1'#13+
'BAND 2=Pasmo 2'#13+
'TRANSPOSE NOW=Transponuj teraz'#13+
'TEECHART LIGHTING=Oúwietlenie TeeChart'#13+
'LINEAR=Liniowe'#13+
'SPOTLIGHT=Reflektor'#13+
'PERIOD 1=Okres 1'#13+
'PERIOD 2=Okres 2'#13+
'PERIOD 3=Okres 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Linia exp.'#13+
'SHAPE INDEX=Indeks kszta≥tu'#13+
'CLOSED=Zamknij'#13+
'WEIGHTED=Waøona'#13+
'WEIGHTED BY INDEX=Waøona wg indeksu'#13+
'DESIGN TIME OPTIONS=Opcje wyúwietlania'#13+
'LANGUAGE=JÍzyk'#13+
'CHART GALLERY=Galeria wykresÛw'#13+
'MODE=Tryb      (Modalna)'#13+
'CHART EDITOR=Edytor wykresu'#13+
'REMEMBER SIZE=ZapamiÍtaj rozmiar'#13+
'REMEMBER POSITION=ZapamiÍtaj pozycjÍ'#13+
'TREE MODE=Tryb drzewiasty'#13+
'NEW CHART=Nowy wykres'#13+
'DEFAULT THEME=Domyúlny temat'#13+
'TEECHART DEFAULT=Standardowy'#13+
'CLASSIC=Klasyczny'#13+
'BIZNES=Biznesowy'#13+
'BLUES=Blues'#13+
'FACTS=Fakty'#13+
'MULTIPLE PIES=Kilka wykresÛw'#13+
'3D GRADIENT=Gradient 3D'#13+
'DISABLE=Wy≥πcz'#13+
'COLOR EACH SLICE=Koloruj kaødy wycinek'#13+
'BASE LINE=Linia odniesienia'#13+
'BOX SIZE=Rozmiar pude≥ka'#13+
'REVERSAL AMOUNT=Odwrotny kierunek'#13+
'PERCENTAGE=Procenty'#13+
'COMPLETE R.M.S.=Ca≥kowity R.M.S.'#13+
'BUTTON=Przycisk'#13+
'INITIAL DELAY=OpÛünienie poczπtkowe'#13+
'THUMB=Suwak'#13+
'AUTO-REPEAT=Auto-powtarzanie'#13+
'BACK COLOR=Kolor w tle'#13+
'HANDLES=Uchwyty'#13+
'ALLOW RESIZE CHART=PozwÛl zmieniaÊ rozmiar wykresu'#13+
'LOOP=PÍtla'#13+
'START AT MIN. VALUE=Zacznij od wartoúci min.'#13+
'EXECUTE !=Wykonaj !'#13+
'ONE WAY=Jeden kierunek'#13+
'CIRCULAR=Okrπg≥y'#13+
'DRAW BEHIND SERIES=Rysuj za seriami'#13+
'IMAG. SYMBOL=Symbol urojon.'#13+
'SELF STACK=Zsumowany'#13+
'SURFACE=Powierzchnia'#13+
'CELL=KomÛrka'#13+
'ROW=Wiersz'#13+
'COLUMN=Kolumna'#13+
'SIDE LINES=Linie boczne'#13+
'FAST BRUSH=Szybki pÍdzel'#13+
'SVG OPTIONS=Opcje SVG'#13+
'TEXT ANTI-ALIAS=Wyg≥adü tekst'#13+
'THEME=Temat'#13+
'EXPORT DIALOG=Okno eksportu'#13+
'TEXT QUOTES=Znaczniki tekstu'#13+
'POINT COLORS=Kolor punktu'#13+
'OUTLINE GRADIENT=Kontur gradientowy'#13+
'BALANS WOLUMEN=Wolumen zrÛwnowaøony'#13+
'STAT.=Statystyczne'#13+
'ACE=As'#13+
'BUSINESS=Biznes'#13+
'CARIBE SUN=Tropikalne s≥oÒce'#13+
'CLEAR DAY=PiÍkny dzieÒ'#13+
'DESERT=Pustynia'#13+
'FARM=Farma'#13+
'FUNKY=Funky'#13+
'GOLF=Golf'#13+
'HOT=Upa≥'#13+
'NIGHT=Noc'#13+
'PASTEL=Pastele'#13+
'SEA=Morze'#13+
'SEA 2=Morze 2'#13+
'SUNSET=ZachÛd s≥oÒca'#13+
'TROPICAL=Tropiki'#13+
'BALANCE=Balans'#13+
'RADIAL OFFSET=PrzesuniÍcie promienia'#13+
'HORIZ=Poziom'#13+
'VERT=Pion'#13+
'RADIAL=Promienisty'#13+
'DIAGONAL UP=Ukoúny do gÛry'#13+
'DIAGONAL DOWN=Ukoúny na dÛ≥'#13+
'COVER=Przykrycie'#13+
'HIDE TRIANGLES=Ukryj trÛjkπty'#13+
'MIRRORED=Lustrzany'#13+
'VALUE SOURCE=èrÛd≥o wartoúci'#13+

  // compatible with TeeChart 7.05
  // missing translations added by masch(at)zg.pl 20.3.2005

'3D GRID TRANSPOSE=Transponuj siatkÍ 3D'#13+
'ALL=Wszystko'#13+
'ANNOTATION PROPERTIES=W≥aúciwoúci adnotacji'#13+
'AUTO SIZE=Rozmiar autom.'#13+
'AXIS LINE=Linie osi'#13+
'AXIS PROPERTIES=W≥aúciwoúci osi'#13+
'BAR DEPTH=G≥ÍbokoúÊ kolumny'#13+
'BUBBLE=Bπbelek'+#13+
'CANDLE=S≥upek'+#13+
'CHANGE SERIES TITLE=ZmieÒ tytu≥ serii'+#13+
'COMMODITY CHANNEL INDEX=Indeks kszta≥tu'#13'towaru (CCI)'#13+
'CROSS POINTS=Punkty krzyøowe'#13+
'CURRENT=Aktualny'#13+
'CUSTOM POSITION=Pozycja uøytkownika'#13+
'DEFAULT COLOR=Domyúlny kolor'#13+
'DEFAULT=Domyúlny'+#13+
'DELETE %S ?=UsunπÊ %s ?'+#13+
'DEPTH TOP=G≥ÍbokoúÊ u gÛry'#13+
'DESIRED %S INCREMENT=Poøπdany przyrost %s'+#13+
'DRAG POINT=Ciπgnij punkt'#13+
'DRAG=Przeciπgaj'#13+
'EDIT COLOR=Editar Color'#13+
'EXP.TREND=Trend exp.'#13+
'EXTENDED=Rozszerzony'+#13+
'EXTRA LEGEND=Dodatkowa legenda'#13+
'FAST LINE=Liniowy szybki'+#13+
'FINANCIAL=Finansowe'+#13+
'FINISH=Koniec'+#13+
'GANTT DRAG=Ciπgnij Gantt'#13+
'GAUGES=Wskaüniki'#13+
'GRAY SCALE VISUAL=Skala szar. ulepszona'#13+
'GRID BAND TOOL=Pasmo siatki'#13+
'HANDPOINT=RÍka'#13+
'HORIZ. BAR=Kolumna pozioma'+#13+
'HOURGLASS=Klepsydra'#13+
'INCORRECT VALUE. REASON: %S=nieprawid≥owa wartoúÊ. PowÛd: %s'+#13+
'INVERTED PYRAMID=OdwrÛcona piramida'+#13+
'LABEL PERCENT TOTAL=Etykieta procent ca≥k.'#13+
'LABEL PERCENT=Etykieta procent'#13+
'LABEL VALUE=Etykieta wartoúÊ'#13+
'LEGEND PROPERTIES=W≥aúciwoúci legendy'#13+
'MARKS PROPERTIES=W≥aúciwoúci znacznika'#13+
'MINOR GRID=Drobna siatka'#13+
'MODERN=Nowoczesny'#13+
'MOVE DOWN=PrzesuÒ w gÛrÍ'#13+
'MOVE UP=PrzesuÒ w dÛ≥'#13+
'NEXT >= Dalej >'+#13+
'OFF=Wy≥πczony'#13+
'ON BALANCE VOLUME=Balans wolumen'#13+
'ON=W≥πczony'#13+
'PAGE %D OF %D=Strona %d z %d'#13+
'PAGE NUMBER=Numer strony'#13+
'PANEL COLOR=Kolor panelu'+#13+
'PANEL PROPERTIES=W≥aúciwoúci panelu'#13+
'PERIMETER=ObwÛd'#13+
'PIE=Ko≥o'+#13+
'POINT=Punkt'+#13+
'RESET=Resetuj'#13+
'SELECT ALL=Zaznacz wszystkie'#13+
'SERIES ANIMATION=Animacja serii'#13+
'SERIES COLOR=Kolor serii'#13+
'SERIES PROPERTIES=W≥aúciwoúci serii'#13+
'SMOOTHING=Wyg≥adzanie'#13+
'STAIRS INVERTED=OdwrÛcone schody'#13+
'STATS=Statystyki'+#13+
'TEECHART LANGUAGES=JÍzyki TeeChart'#13+
'TEXT FILE=Plik tekstowy'#13+
'TITLE PROPERTIES=W≥aúciwoúci tytu≥u'#13+
'TREND=Trend'#13+
'VICTORIAN=WiktoriaÒski'#13+
'VOLUME=Wolumen'+#13+
'WALL PROPERTIES=W≥aúciwoúci úciany'#13+
'WEB=Sieciowy'#13+
'WINDOWS XP=Windows XP'#13+
'VIEW=Widok'#13+
'DATASOURCES=èrÛd≥a danych'#13+
'X GRID EVERY=Siatka X co'#13+
'Y GRID EVERY=Siatka Y co'#13+
'XY=XY'#13+
'Z GRID EVERY=Siatka Z co'#13+
'Z %=Z %'#13+
'3D FRONT=3D z przodu'#13+
'FROM=Od'#13+
'TO=Do'#13+
'PERIOD RANGE=Zakres okresu'#13+
'INVERTED GRAY SCALE=OdwrÛcona skala szar.'#13+
'PASTELS=Pastele'#13+
'BACK WALL=Tylna úciana'#13+
'EXPRESSION=Wyraøenie'
;

  end;
end;

Procedure TeeSetPolish;
begin
  TeeCreatePolish;
  TeeLanguage:=TeePolishLanguage;
  TeePolishConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeePolishLanguage);
end.
