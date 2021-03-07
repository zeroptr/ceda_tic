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
  TeeMsg_Copyright          :='� 1995-2009 by David Berneda';
  TeeMsg_LegendFirstValue   :='Pierwsza warto�� legendy musi by� > 0';
  TeeMsg_LegendColorWidth   :='Szeroko�� musi by� pomi�dzy 0 i 100';
  TeeMsg_SeriesSetDataSource:='Brak ParentChart �eby sprawdzi� �r�d�o danych';
  TeeMsg_SeriesInvDataSource:='Brak poprawnego �r�d�a danych: %s';
  TeeMsg_FillSample         :='Warto�ci liczbowe FillSampleValues musz� by� > 0';
  TeeMsg_AxisLogDateTime    :='O� daty/czasu nie mo�e by� logarytmiczna';
  TeeMsg_AxisLogNotPositive :='Min i Max warto�ci osi logarytmicznej powinny by� >= 0';
  TeeMsg_AxisLabelSep       :='% odst�pu etykiet musi by� wi�kszy ni� 0';
  TeeMsg_AxisIncrementNeg   :='Przyrost osi musi by� >= 0';
  TeeMsg_AxisMinMax         :='Warto�� minimum osi musi by� <= maksimum';
  TeeMsg_AxisMaxMin         :='Warto�� maksimum osi musi by� >= minimum';
  TeeMsg_AxisLogBase        :='Podstawa logarytmiczna osi powinna by� >= 2';
  TeeMsg_MaxPointsPerPage   :='Max. ilo�� punkt�w na stron� musi by� >= 0';
  TeeMsg_3dPercent          :='Procent efektu 3D musi by� pomi�dzy %d i %d';
  TeeMsg_CircularSeries     :='Cykliczne zale�no�ci mi�dzy seriami s� niedozwolone';
  TeeMsg_WarningHiColor     :='Aby uzyska� lepszy wygl�d wymagany jest kolor 16K';

  TeeMsg_DefaultPercentOf   :='%s z %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'z %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Tytu� osi';
  TeeMsg_AxisLabels         :='Etykiety osi';
  TeeMsg_RefreshInterval    :='Interwa� odswie�ania musi by� zawarty mi�dzy 0 i 60';
  TeeMsg_SeriesParentNoSelf :='Sam nie jestem Series.ParentChart!';
  TeeMsg_GalleryLine        :='Liniowy';
  TeeMsg_GalleryPoint       :='Punkty';
  TeeMsg_GalleryArea        :='Warstwowy';
  TeeMsg_GalleryBar         :='Kolumnowy';
  TeeMsg_GalleryHorizBar    :='Kolumnowy horyz.';
  TeeMsg_Stack              :='Skumulowany';
  TeeMsg_GalleryPie         :='Ko�owy';
  TeeMsg_GalleryCircled     :='Zaokr�glony';
  TeeMsg_GalleryFastLine    :='Liniowy szybki';
  TeeMsg_GalleryHorizLine   :='Liniowy horyz.';

  TeeMsg_PieSample1         :='Samochody';
  TeeMsg_PieSample2         :='Telefony';
  TeeMsg_PieSample3         :='Sto�y';
  TeeMsg_PieSample4         :='Monitory';
  TeeMsg_PieSample5         :='Lampy';
  TeeMsg_PieSample6         :='Klawiatury';
  TeeMsg_PieSample7         :='Rowery';
  TeeMsg_PieSample8         :='Krzes�a';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Edycja %s';

  TeeMsg_GalleryStandard    :='Standardowe';
  TeeMsg_GalleryExtended    :='Rozszerzone';
  TeeMsg_GalleryFunctions   :='Funkcje';

  TeeMsg_EditChart          :='&Edycja wykresu...';
  TeeMsg_PrintPreview       :='&Podgl�d wydruku...';
  TeeMsg_ExportChart        :='E&ksport wykresu...';
  TeeMsg_CustomAxes         :='Osie u�ytkownika...';

  TeeMsg_InvalidEditorClass :='%s: Nieprawid�owa klasa edytora: %s';
  TeeMsg_MissingEditorClass :='%s: brak okna dialogowego edytora';

  TeeMsg_GalleryArrow       :='Strza�kowy';

  TeeMsg_ExpFinish          :='&Koniec';
  TeeMsg_ExpNext            :='&Dalej >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Projekt';
  TeeMsg_GanttSample2       :='Prototyp';
  TeeMsg_GanttSample3       :='Rozw�j';
  TeeMsg_GanttSample4       :='Sprzeda�';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testowanie';
  TeeMsg_GanttSample7       :='Produkcja';
  TeeMsg_GanttSample8       :='Ulepszanie';
  TeeMsg_GanttSample9       :='Nowa wersja';
  TeeMsg_GanttSample10      :='Bankowo��';

  TeeMsg_ChangeSeriesTitle  :='Zmie� tytu� serii';
  TeeMsg_NewSeriesTitle     :='Nowy tytu� serii:';
  TeeMsg_DateTime           :='Data/czas';
  TeeMsg_TopAxis            :='G�rna o�';
  TeeMsg_BottomAxis         :='Dolna o�';
  TeeMsg_LeftAxis           :='Lewa o�';
  TeeMsg_RightAxis          :='Prawa o�';

  TeeMsg_SureToDelete       :='Usun�� %s ?';
  TeeMsg_DateTimeFormat     :='For&mat daty/czasu:';
  TeeMsg_Default            :='Domy�lnie';
  TeeMsg_ValuesFormat       :='For&mat warto�ci:';
  TeeMsg_Maximum            :='Maksimum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Po�adany %s przyrost';

  TeeMsg_IncorrectMaxMinValue:='Nieprawid�owa warto��. Przyczyna: %s';
  TeeMsg_EnterDateTime      :='Wprowad� [liczba dni] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Zastosowa� zmiany ?';
  TeeMsg_SelectedSeries     :='(Wybrane serie)';
  TeeMsg_RefreshData        :='&Od�wie� dane';

  TeeMsg_DefaultFontSize    :='8';
  TeeMsg_FunctionAdd        :='Suma';
  TeeMsg_FunctionSubtract   :='R�nica';
  TeeMsg_FunctionMultiply   :='Iloczyn';
  TeeMsg_FunctionDivide     :='Iloraz';
  TeeMsg_FunctionHigh       :='Wysoko';
  TeeMsg_FunctionLow        :='Nisko';
  TeeMsg_FunctionAverage    :='�rednia';

  TeeMsg_GalleryShape       :='Kszta�ty';
  TeeMsg_GalleryBubble      :='B�belkowy';
  TeeMsg_FunctionNone       :='Kopiuj';

  TeeMsg_None               :='(Brak)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Wielko�� wska�nika musi by� wi�ksza ni� zero';
  TeeMsg_About              :='&O TeeChart...';

  tcAdditional              :='Dodatkowe';
  tcDControls               :='Kontrolki danych';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Zbi�r danych';
  TeeMsg_AskDataSet         :='&Zbi�r danych:';

  TeeMsg_SingleRecord       :='Pojedynczy wiersz';
  TeeMsg_AskDataSource      :='&�r�d�o danych:';

  TeeMsg_Summary            :='Podsumowanie';

  TeeMsg_FunctionPeriod     :='Okres funkcji powinien by� >= 0';

  TeeMsg_WizardTab          :='Biznes';

  TeeMsg_ClearImage         :='&Wyczy��';
  TeeMsg_BrowseImage        :='&Szukaj w...';

  TeeMsg_WizardSureToClose  :='Czy jeste� pewien, �e chcesz zamkn�� kreatora TeeChart ?';
  TeeMsg_FieldNotFound      :='Pole %s nie istnieje';

  TeeMsg_DepthAxis          :='O� g��boko�ci';
  TeeMsg_PieOther           :='Inny';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Ko�o';
  TeeMsg_ValuesBar          :='Kolumna';
  TeeMsg_ValuesAngle        :='K�t';
  TeeMsg_ValuesGanttStart   :='Pocz�tek';
  TeeMsg_ValuesGanttEnd     :='Koniec';
  TeeMsg_ValuesGanttNextTask:='Nastepne zadanie';
  TeeMsg_ValuesBubbleRadius :='Promie�';
  TeeMsg_ValuesArrowEndX    :='KoniecX';
  TeeMsg_ValuesArrowEndY    :='KoniecY';
  TeeMsg_Legend             :='Legenda';
  TeeMsg_Title              :='Tytu�';
  TeeMsg_Foot               :='Stopka';
  TeeMsg_Period             :='Okres';
  TeeMsg_PeriodRange        :='Zakres okres�w';
  TeeMsg_CalcPeriod         :='Oblicz %s co:';
  TeeMsg_SmallDotsPen       :='Ma�e kropki';

  TeeMsg_InvalidTeeFile     :='Nieprawid�owy wykres w pliku *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Nieprawid�owy format pliku *.'+TeeMsg_TeeExtension;
  TeeMsg_EmptyTeeFile       :='Pusty plik *.'+TeeMsg_TeeExtension;  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Osie wykresu';
  TeeMsg_ChartAxesCategoryDesc   :='Osie wykresu - w�a�ciwo�ci i zdarzenia';
  TeeMsg_ChartWallsCategoryName  :='�ciany wykresu';
  TeeMsg_ChartWallsCategoryDesc  :='�ciany wykresu - w�a�ciwo�ci i zdarzenia';
  TeeMsg_ChartTitlesCategoryName :='Tytu�y wykresu';
  TeeMsg_ChartTitlesCategoryDesc :='Tytu�y wykresu - w�a�ciwo�ci i zdarzenia';
  TeeMsg_Chart3DCategoryName     :='Wykres 3D';
  TeeMsg_Chart3DCategoryDesc     :='Wykres 3D - w�a�ciwo�ci i zdarzenia';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='U�ytkownika ';
  TeeMsg_Series                 :='Serie';
  TeeMsg_SeriesList             :='Serie...';

  TeeMsg_PageOfPages            :='Strona %d z %d';
  TeeMsg_FileSize               :='%d bajt�w';

  TeeMsg_First  :='Pierwszy';
  TeeMsg_Prior  :='Poprzedni';
  TeeMsg_Next   :='Nast�pny';
  TeeMsg_Last   :='Ostatni';
  TeeMsg_Insert :='Wstaw';
  TeeMsg_Delete :='Usu�';
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
  TeeMsg_ExportPanelNotSet :='W formacie Eksportu nie jest ustawiona w�a�ciwo�� panelu';

  TeeMsg_Normal    :='Normalny';
  TeeMsg_NoBorder  :='Bez kraw�dzi';
  TeeMsg_Dotted    :='Kropkowany';
  TeeMsg_Colors    :='Kolory';
  TeeMsg_Filled    :='Wype�niony';
  TeeMsg_Marks     :='Znaczniki';
  TeeMsg_Stairs    :='Schody';
  TeeMsg_Points    :='Punkty';
  TeeMsg_Height    :='Pogrubiony';//'Wysoko��';
  TeeMsg_Hollow    :='Szkielet';//'Pusty';
  TeeMsg_Point2D   :='Punkt 2D';
  TeeMsg_Triangle  :='Tr�jk�t';
  TeeMsg_Star      :='Gwiazda';
  TeeMsg_Circle    :='Ko�o';
  TeeMsg_DownTri   :='Tr�jk�t odwr.';
  TeeMsg_Cross     :='Krzy�';
  TeeMsg_Diamond   :='Diament';
  TeeMsg_NoLines   :='Bez linii';
  TeeMsg_Stack100  :='Skumul. 100%';
  TeeMsg_Pyramid   :='Piramida';
  TeeMsg_Ellipse   :='Elipsa';
  TeeMsg_InvPyramid:='Piramida odwr.';
  TeeMsg_Sides     :='S�siaduj�co';//'Boki';
  TeeMsg_SideAll   :='S�siaduj�co'#13'wszystkie';//'Wszystkie boki';
  TeeMsg_Patterns  :='Wzory';
  TeeMsg_Exploded  :='Rozsuni�ty';
  TeeMsg_Shadow    :='Cie�';
  TeeMsg_SemiPie   :='P�kole';
  TeeMsg_Rectangle :='Prostok�t';
  TeeMsg_VertLine  :='Linia pionowa';
  TeeMsg_HorizLine :='Linia pozioma';
  TeeMsg_Line      :='Linia';
  TeeMsg_Cube      :='Sze�cian';
  TeeMsg_DiagCross :='Diag.krzy�';

  TeeMsg_CanNotFindTempPath    :='Nie mo�na znale�� folderu Temp';
  TeeMsg_CanNotCreateTempChart :='Nie mo�na utworzy� pliku Temp';
  TeeMsg_CanNotEmailChart      :='Nie mo�na wys�a� wykresu TeeChart. B��d MAPI: %d';

  TeeMsg_SeriesDelete :='Usuwanie serii: Indeks warto�ci %d poza przedzia�em (od 0 do %d).';

  // 5.02
  TeeMsg_AskLanguage  :='&J�zyk...';


  { TeeProCo }
  TeeMsg_GalleryPolar       :='Biegunowy';
  TeeMsg_GalleryCandle      :='Gie�dowy';
  TeeMsg_GalleryVolume      :='Wolumen';
  TeeMsg_GallerySurface     :='Powierzchniowy';
  TeeMsg_GalleryContour     :='Konturowy';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Punktowy 3D';
  TeeMsg_GalleryRadar       :='Radarowy';
  TeeMsg_GalleryDonut       :='Pier�cieniowy';
  TeeMsg_GalleryCursor      :='Kursor';
  TeeMsg_GalleryBar3D       :='Kolumnowy 3D';
  TeeMsg_GalleryBigCandle   :='Gie�dowy-wielki';
  TeeMsg_GalleryLinePoint   :='Punktowy'#13'z liniami';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Wodospad';
  TeeMsg_GalleryWindRose    :='R�a wiatr�w';
  TeeMsg_GalleryClock       :='Zegarowy';
  TeeMsg_GalleryColorGrid   :='Siatka kolor�w';
  TeeMsg_GalleryBoxPlot     :='Pude�kowy';
  TeeMsg_GalleryHorizBoxPlot:='Pude�kowy poziomy';
  TeeMsg_GalleryBarJoin     :='Kolumnowy po��cz.';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Piramida';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange    :='Stopie� wielomianu musi by� pomi�dzy 1 i 20';
  TeeMsg_AnswerVectorIndex   :='Indeks wektora odpowiedzi musi by� pomi�dzy 1 i %d';
  TeeMsg_FittingError        :='Nie mo�na przeprowadzi� dopasowania';
  TeeMsg_PeriodRange         :='Okres musi by� >= 0';
  TeeMsg_ExpAverageWeight    :='Waga �redniej exp. musi by� pomi�dzy 0 i 1';
  TeeMsg_GalleryErrorBar     :='S�upki b��du';
  TeeMsg_GalleryError        :='B��d';
  TeeMsg_GalleryHighLow      :='Wysoko-nisko';
  TeeMsg_FunctionMomentum    :='P�d';
  TeeMsg_FunctionMomentumDiv :='P�d (div.)';
  TeeMsg_FunctionExpAverage  :='�rednia exp.';
  TeeMsg_FunctionMovingAverage:='�rednia ruchoma';
  TeeMsg_FunctionExpMovAve   :='�rednia exp.'#13'ruchoma';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Krzywa dopasowana';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Trend exp.';
  TeeMsg_FunctionLogTrend    :='Trend log.';
  TeeMsg_FunctionCumulative  :='Kumulacja';
  TeeMsg_FunctionStdDeviation:='Odchylenie std.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='�redni pierw.'#13'kwadrat.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastyczny';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Ilo��';
  TeeMsg_LoadChart           :='Otw�rz TeeChart...';
  TeeMsg_SaveChart           :='Zapisz TeeChart...';
  TeeMsg_TeeFiles            :='Pliki TeeChart Pro';

  TeeMsg_GallerySamples      :='Inne';
  TeeMsg_GalleryStats        :='Stat.';

  TeeMsg_CannotFindEditor    :='Nie mo�na znale�� formularza edytora serii: %s';


  TeeMsg_CannotLoadChartFromURL:='Kod b��du: %d �adowanie wykresu z URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Kod b��du: %d �adowanie danych serii z URL: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Data';
  TeeMsg_ValuesOpen          :='Otw�rz';
  TeeMsg_ValuesHigh          :='Wysoko';
  TeeMsg_ValuesLow           :='Nisko';
  TeeMsg_ValuesClose         :='Zamknij';
  TeeMsg_ValuesOffset        :='Przesuni�cie';
  TeeMsg_ValuesStdError      :='B��d std.';

  TeeMsg_Grid3D              :='Siatka 3D';

  TeeMsg_LowBezierPoints     :='Ilo�� punkt�w Beziera powinna by� > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normalny';
  TeeCommanMsg_Edit     :='Edytuj';
  TeeCommanMsg_Print    :='Drukuj';
  TeeCommanMsg_Copy     :='Kopiuj';
  TeeCommanMsg_Save     :='Zapisz';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Obr�t: %d� Podniesienie: %d�';
  TeeCommanMsg_Rotate   :='Obr��';

  TeeCommanMsg_Moving   :='Przesun. poz.: %d Przesun. pion.: %d';
  TeeCommanMsg_Move     :='Przesu�';

  TeeCommanMsg_Zooming  :='Powi�kszenie: %d %%';
  TeeCommanMsg_Zoom     :='Powi�kszenie';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='G��bok.';

  TeeCommanMsg_Chart    :='Wykres';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Ci�gnij %s aby obr�ci�';
  TeeCommanMsg_MoveLabel  :='Ci�gnij %s aby przesun��';
  TeeCommanMsg_ZoomLabel  :='Ci�gnij %s aby powi�kszy�';
  TeeCommanMsg_DepthLabel :='Ci�gnij %s aby zmieni� g��boko�� 3D';

  TeeCommanMsg_NormalLabel:='Ci�gnij lewym przyciskiem aby powi�kszy�, prawym by przesun��';
  TeeCommanMsg_NormalPieLabel:='Ci�gnij odpowiedni wycinek ko�a aby go wysun��';

  TeeCommanMsg_PieExploding :='Wycinek: %d Wysuni�ty: %d %%';

  TeeMsg_TriSurfaceLess:='Liczba punkt�w musi by� >= 4';
  TeeMsg_TriSurfaceAllColinear:='Wszystkie wsp�liniowe punkty danych';
  TeeMsg_TriSurfaceSimilar:='Podobne punkty XYZ. Nie mo�na wyliczy� tr�jk�t�w.';
  TeeMsg_GalleryTriSurface:='Powierzch.'#13'z tr�jk�t�w';

  TeeMsg_AllSeries :='Wszystkie serie';
  TeeMsg_Edit      :='Edytuj';

  TeeMsg_GalleryFinancial    :='Finansowe';

  TeeMsg_CursorTool    :='Kursor';
  TeeMsg_DragMarksTool :='Ci�gnij znaczniki';
  TeeMsg_AxisArrowTool :='Strza�ki osi';
  TeeMsg_DrawLineTool  :='Rysuj linie';
  TeeMsg_NearestTool   :='Najbli�szy punkt';
  TeeMsg_ColorBandTool :='Kolorowe pasmo';
  TeeMsg_ColorLineTool :='Kolorowa linia';
  TeeMsg_RotateTool    :='Obr�t';
  TeeMsg_ImageTool     :='Obraz';
  TeeMsg_MarksTipTool  :='Dymki ze znacznikiem';

  TeeMsg_CantDeleteAncestor  :='Nie mo�na usun�� poprzednika';

  TeeMsg_Load            :='Wczytywanie...';
  TeeMsg_NoSeriesSelected:='Nie wybrano �adnej serii';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Wykres';
  TeeMsg_CategorySeriesActions :='Serie wykresu';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Prze��cz 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Aktywne';
  TeeMsg_ActionSeriesActiveHint :='Poka�/Ukryj serie';
  TeeMsg_ActionEditHint         :='Edytuj wykres';
  TeeMsg_ActionEdit             :='&Edytuj...';
  TeeMsg_ActionCopyHint         :='Kopiuj do schowka';
  TeeMsg_ActionCopy             :='&Kopiuj';
  TeeMsg_ActionPrintHint        :='Podgl�d wydruku';
  TeeMsg_ActionPrint            :='&Drukuj...';
  TeeMsg_ActionAxesHint         :='Poka�/Ukryj osie';
  TeeMsg_ActionAxes             :='&Osie';
  TeeMsg_ActionGridsHint        :='Poka�/Ukryj siatk�';
  TeeMsg_ActionGrids            :='&Siatka';
  TeeMsg_ActionLegendHint       :='Poka�/Ukryj legend�';
  TeeMsg_ActionLegend           :='&Legenda';
  TeeMsg_ActionSeriesEditHint   :='Edytuj serie';
  TeeMsg_ActionSeriesMarksHint  :='Poka�/Ukryj znaczniki serii';
  TeeMsg_ActionSeriesMarks      :='&Znaczniki';
  TeeMsg_ActionSaveHint         :='Zapisz wykres';
  TeeMsg_ActionSave             :='&Zapisz...';

  TeeMsg_CandleBar              :='S�upek';
  TeeMsg_CandleNoOpen           :='Bez otwarcia';
  TeeMsg_CandleNoClose          :='Bez zamkni�cia';
  TeeMsg_NoLines                :='Bez linii';
  TeeMsg_NoHigh                 :='Bez wysoko';
  TeeMsg_NoLow                  :='Bez nisko';
  TeeMsg_ColorRange             :='Gama kolor�w';//zakres
  TeeMsg_WireFrame              :='Szkielet druc.';
  TeeMsg_DotFrame               :='Szkielet punkt.';
  TeeMsg_Positions              :='Poziomy';
  TeeMsg_NoGrid                 :='Bez siatki';
  TeeMsg_NoPoint                :='Bez punktu';
  TeeMsg_NoLine                 :='Bez linii';
  TeeMsg_Labels                 :='Etykiety';
  TeeMsg_NoCircle               :='Bez obrysu';//okr�gu;
  TeeMsg_Lines                  :='Linie';
  TeeMsg_Border                 :='Kraw�d�';

  TeeMsg_SmithResistance      :='Op�r(Smith)';
  TeeMsg_SmithReactance       :='Op�r bierny';
  
  TeeMsg_Column               :='Kolumna';

  { 5.01 }
  TeeMsg_Separator            :='Separator';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Lejkowy';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='przekroczony limit';
  TeeMsg_FunnelWithin         :=' wewn�trz limitu';
  TeeMsg_FunnelBelow          :=' poni�ej limitu';
  TeeMsg_CalendarSeries       :='Kalendarz';
  TeeMsg_DeltaPointSeries     :='Punkt delta';
  TeeMsg_ImagePointSeries     :='Punkt z obrazkiem';
  TeeMsg_ImageBarSeries       :='Kolumnowy'#13'z obrazem';
  TeeMsg_SeriesTextFieldZero  :='Tekst serii: Indeks pola powinien by� wi�kszy ni� zero.';

  { 5.02 }
  TeeMsg_Origin               :='Pocz�tek';
  TeeMsg_Transparency         :='Przezroczysty';
  TeeMsg_Box                  :='Pude�ko';
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
  TeeMsg_Property            :='W�a�ciwo�ci';
  TeeMsg_Value               :='Warto��';
  TeeMsg_Yes                 :='Tak';
  TeeMsg_No                  :='Nie';
  TeeMsg_Image               :='(obrazek)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Ci�gnij punkt';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'ActiveX wersja ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Nie mo�na zaimportowa� TeeChart z %s';
  TeeMsg_ActiveXVerbPrint    := '&Podgl�d wydruku...';
  TeeMsg_ActiveXVerbExport   := 'E&xport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Pomoc...';
  TeeMsg_ActiveXVerbAbout    := '&O TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Kod b��du: %d �ci�ganie: %s';
  TeeMsg_DatasourceError     := '�r�d�o danych TeeChart nie jest Seri� lub RecordSetem';
  TeeMsg_SeriesTextSrcError  := 'Nieprawid�owy typ serii';
  TeeMsg_AxisTextSrcError    := 'Nieprawid�owy typ osi';
  TeeMsg_DelSeriesDatasource := 'Czy jeste� pewny, �e chcesz usun�� %s ?';
  TeeMsg_OCXNoPrinter        := 'Nie zainstalowano domy�lnej drukarki.';
  TeeMsg_ActiveXPictureNotValid:='Obraz jest nieprawid�owy';
  {$ENDIF}

  // 6.0

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='jako &PDF';
  TeeMsg_PDFFilter        :='Pliki PDF (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='jako PostScript';
  TeeMsg_PSFilter         :='Pliki PostScript (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Warstwowy'#13'horyzontalny';
  TeeMsg_SelfStack        :='Zsumowany';
  TeeMsg_DarkPen          :='Ciemna kraw�d�';
  TeeMsg_SelectFolder     :='Wybierz folder bazy danych';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Po��czenie:';

  // 6.0

  TeeMsg_FunctionSmooth       :='Wyg�adzanie';
  TeeMsg_FunctionCross        :='Punkty krzy�a';
  TeeMsg_GridTranspose        :='Transpozycja siatki 3D';
  TeeMsg_FunctionCompress     :='Kompresja';
  TeeMsg_ExtraLegendTool      :='Extra legenda';
  TeeMsg_FunctionCLV          :='Zamkni�cie miejsce'#13'warto�� (CLV)';
  TeeMsg_FunctionOBV          :='Balans'#13'wolumen (OBV)';
  TeeMsg_FunctionCCI          :='Towar'#13'indeks kana�u (CCI)';
  TeeMsg_FunctionPVO          :='Wolumen'#13'oscylator (PVO)';
  TeeMsg_SeriesAnimTool       :='Animacja serii';
  TeeMsg_GalleryPointFigure   :='Punkty i liczby';
  TeeMsg_Up                   :='G�ra';
  TeeMsg_Down                 :='D�';
  TeeMsg_GanttTool            :='Ci�gnij Gantt';
  TeeMsg_XMLFile              :='Plik XML';
  TeeMsg_GridBandTool         :='Pasmo siatki';
  TeeMsg_FunctionPerf         :='Wykonanie';
  TeeMsg_GalleryGauge         :='Wska�nik';
  TeeMsg_GalleryGauges        :='Wska�niki';
  TeeMsg_ValuesVectorEndZ     :='KoniecZ';
  TeeMsg_GalleryVector3D      :='Wektor 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Wie�a';
  TeeMsg_SingleColor          :='Jeden kolor';
  TeeMsg_Cover                :='Pokrywa i dno';//'Pokrywa';
  TeeMsg_Cone                 :='Sto�ek';
  TeeMsg_PieTool              :='Wycinki ko�a';


  // 7.0
  TeeMsg_Stop                 :='Stop';
  TeeMsg_Execute              :='Wykonaj !';
  TeeMsg_Themes               :='Tematy';
  TeeMsg_LightTool            :='O�wietlenie 2D';
  TeeMsg_Current              :='Aktualny';
  TeeMsg_FunctionCorrelation  :='Korelacja';
  TeeMsg_FunctionVariance     :='Wariancja';
  TeeMsg_GalleryBubble3D      :='B�belki 3D';
  TeeMsg_GalleryHorizHistogram:='Histogram'#13'horyzontalny';
  TeeMsg_FunctionPerimeter    :='Obw�d';
  TeeMsg_SurfaceNearestTool   :='Najbli�szy na powierzchni';
  TeeMsg_AxisScrollTool       :='Przesuwanie osi';
  TeeMsg_RectangleTool        :='Prostok�t';
  TeeMsg_GalleryPolarBar      :='Biegunowo-'#13'kolumnowy';
  TeeMsg_AsWapBitmap          :='Bitmapa WAP';
  TeeMsg_WapBMPFilter         :='Bitmapy WAP (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='Obci�cie serii';
  TeeMsg_SeriesBandTool       :='Pasmo serii';

  // 7.01
  TeeMsg_ThemeFacts           :='Fakty';
  TeeMsg_FunctionDownSampling :='Kompresja pr�bkowania';

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
  TeeMsg_WantToSave           :='Czy chcesz zapisa� %s ?';



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
'VISIBLE=Poka�'#13+
'TOP BOTTOM=Z g�ry na d�'#13+
'BOTTOM TOP=Z do�u do g�ry'#13+
'LEFT RIGHT=Z lewiej na prawo'#13+
'RIGHT LEFT=Z prawej na lewo'#13+
'FROM CENTER=Od �rodka'#13+
'FROM TOP LEFT=Z g�rnego-lewego rogu'#13+
'FROM BOTTOM LEFT=Z dolnego-lewego rogu'#13+
'OK=OK'#13+
'CANCEL=Anuluj'#13+
'COLORS=Kolory'#13+
'START=Pocz�tek'#13+
'MIDDLE=�rodek'#13+
'END=Koniec'#13+
'SWAP=Zamie�'#13+
'NO MIDDLE=Bez �rodka'#13+
'TEEFONT EDITOR=Edytor czcionki'#13+
'INTER-CHAR SPACING=Odst�p mi�dzyznakowy'#13+
'FONT=Czcionka'#13+
'SHADOW=Cie�'#13+
'HORIZ. SIZE=Rozmiar poziomy'#13+
'VERT. SIZE=Rozmiar pionowy'#13+
'COLOR=Kolor'#13+
'OUTLINE=Kontur'#13+
'OPTIONS=Opcje'#13+
'FORMAT=Format'#13+
'TEXT=Tekst'#13+
'POSITION=Pozycja'#13+
'LEFT=Lewo'#13+
'TOP=G�ra'#13+
'AUTO=Automatycz.'#13+
'CUSTOM=U�ytkownika'#13+
'LEFT TOP=Lewy g�rny'#13+
'LEFT BOTTOM=Lewy dolny'#13+
'RIGHT TOP=Prawy g�rny'#13+
'RIGHT BOTTOM=Prawy dolny'#13+
'MULTIPLE AREAS=Wiele powierzchni'#13+
'NONE=Brak'#13+
'STACKED=Skumulowany'#13+
'STACKED 100%=Skumulowany 100%'#13+
'AREA=Powierzchnia'#13+
'PATTERN=Wz�r'#13+
'STAIRS=Schody'#13+
'SOLID=Pe�ny'#13+
'CLEAR=Pusty'#13+
'HORIZONTAL=W poziomie'#13+
'VERTICAL=W pionie'#13+
'DIAGONAL=Uko�ny'#13+
'B.DIAGONAL=Uko�ny odw.'#13+
'CROSS=Krzy�'#13+
'DIAG.CROSS=Uko�ny krzy�'#13+
'AREA LINES=Linie punkt�w'#13+
'BORDER=Kraw�d�'#13+
'INVERTED=Odwr�cony'#13+
'COLOR EACH=Koloruj ka�dy'#13+
'ORIGIN=Pocz�tek'#13+
'USE ORIGIN=U�yj pocz�tku'#13+
'WIDTH=Szeroko��'#13+
'HEIGHT=Wysoko��'#13+
'AXIS=O�'#13+
'LENGTH=D�ugo��'#13+
'SCROLL=Przesuwanie'#13+
'BOTH=Oba'#13+
'AXIS INCREMENT=Przyrost osi'#13+
'INCREMENT=Przyrost'#13+
'STANDARD=Standard'#13+
'ONE MILLISECOND=Jedna milisekunda'#13+
'ONE SECOND=Jedna sekunda'#13+
'FIVE SECONDS=Pi�� sekund'#13+
'TEN SECONDS=Dziesi�� sekund'#13+
'FIFTEEN SECONDS=Pi�tna�cie sekund'#13+
'THIRTY SECONDS=Trzydzie�ci sekund'#13+
'ONE MINUTE=Jedna minuta'#13+
'FIVE MINUTES=Pi�� minut'#13+
'TEN MINUTES=Dzies�� minut'#13+
'FIFTEEN MINUTES=Pi�tna�cie minut'#13+
'THIRTY MINUTES=Trzydzie�ci minut'#13+
'ONE HOUR=Jedna godzina'#13+
'TWO HOURS=Dwie godziny'#13+
'SIX HOURS=Sze�� godzina'#13+
'TWELVE HOURS=Dwana�cie godzin'#13+
'ONE DAY=Jeden dzie�'#13+
'TWO DAYS=Dwa dni'#13+
'THREE DAYS=Trzy dni'#13+
'ONE WEEK=Jeden tydzie�'#13+
'HALF MONTH=P� miesi�ca'#13+
'ONE MONTH=Jeden miesi�c'#13+
'TWO MONTHS=Dwa miesi�ce'#13+
'THREE MONTHS=Trzy miesi�ce'#13+
'FOUR MONTHS=Cztery miesi�ce'#13+
'SIX MONTHS=Sze�� miesi�cy'#13+
'ONE YEAR=Jeden rok'#13+
'EXACT DATE TIME=Dok�adna data/czas'#13+
'AXIS MAXIMUM AND MINIMUM=Maksimum i minimum osi'#13+
'VALUE=Warto��'#13+
'TIME=Czas'#13+
'LEFT AXIS=O� lewa'#13+
'RIGHT AXIS=O� prawa'#13+
'TOP AXIS=O� g�rna'#13+
'BOTTOM AXIS=O� dolna'#13+
'% BAR WIDTH=Szeroko�� %'#13+
'STYLE=Styl'#13+
'% BAR OFFSET=Przesuni�cie %'#13+
'RECTANGLE=Prostok�t'#13+
'PYRAMID=Piramida'#13+
'INVERT. PYRAMID=Odwr�cona piramida'#13+
'CYLINDER=Cylinder'#13+
'ELLIPSE=Elipsa'#13+
'ARROW=Strza�ka'#13+
'RECT. GRADIENT=Prostok�t z gradientem'#13+
'CONE=Sto�ek'#13+
'DARK BAR 3D SIDES=Ciemne boki kolumny 3D'#13+
'BAR SIDE MARGINS=Boczne marginesy kolumny'#13+
'AUTO MARK POSITION=Autom. pozycja znacznika'#13+
'JOIN=Po��cz'#13+
'DATASET=Zbi�r danych'#13+
'APPLY=Zastosuj'#13+
'SOURCE=�r�d�o'#13+
'MONOCHROME=Monochromatyczny'#13+
'DEFAULT=Domy�lnie'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=Mediana'#13+
'WHISKER=W�sy'#13+
'PATTERN COLOR EDITOR=Edytor koloru wzoru'#13+
'IMAGE=Obraz'#13+
'BACK DIAGONAL=Uko�ny odwrotny'#13+
'DIAGONAL CROSS=Siatka uko�na'#13+
'FILL 80%=Wype�nienie 80%'#13+
'FILL 60%=Wype�nienie 60%'#13+
'FILL 40%=Wype�nienie 40%'#13+
'FILL 20%=Wype�nienie 20%'#13+
'FILL 10%=Wype�nienie 10%'#13+
'ZIG ZAG=Zygzak'#13+
'VERTICAL SMALL=Pionowy drobny'#13+
'HORIZ. SMALL=Poziomy drobny'#13+
'DIAG. SMALL=Uko�ny drobny'#13+
'BACK DIAG. SMALL=Uko�ny odwr. drobny'#13+
'CROSS SMALL=Drobna siatka'#13+
'DIAG. CROSS SMALL=Drobna siatka uko�na'#13+
'DAYS=Dni'#13+
'WEEKDAYS=Dni tygodnia'#13+
'TODAY=Dzi�'#13+
'SUNDAY=Niedziela'#13+
'TRAILING=Dni po�rednie'#13+
'MONTHS=Miesi�ce'#13+
'LINES=Linie'#13+
'SHOW WEEKDAYS=Dni tygodnia'#13+
'UPPERCASE=Du�e litery'#13+
'TRAILING DAYS=Dni po�rednie'#13+
'SHOW TODAY=Poka� dzisiaj'#13+
'SHOW MONTHS=Poka� miesi�ce'#13+
'CANDLE WIDTH=Szeroko�� s�upka'#13+
'STICK=Sztyft'#13+
'BAR=Kolumna'#13+
'OPEN CLOSE=Otwar.-zamkn.'#13+
'UP CLOSE=G�ra zamkni�cia'#13+
'DOWN CLOSE=D� zamkni�cia'#13+
'SHOW OPEN=Poka� otwarcie'#13+
'SHOW CLOSE=Poka� zamkni�cie'#13+
'DRAW 3D=3D'#13+
'DARK 3D=Ciemny bok 3D'#13+
'EDITING=Edycja'#13+
'CHART=Wykres'#13+
'SERIES=Serie'#13+
'DATA=Dane'#13+
'TOOLS=Narz�dzia'#13+
'EXPORT=Eksport'#13+
'PRINT=Drukowanie'#13+
'GENERAL=Og�lne'#13+
'TITLES=Tytu�'#13+
'LEGEND=Legenda'#13+
'PANEL=Panel'#13+
'PAGING=Strona'#13+
'WALLS=�ciana'#13+
'3D=3D'#13+
'ADD=Dodaj'#13+
'DELETE=Usu�'#13+
'TITLE=Tytu�'#13+
'CLONE=Powiel'#13+
'CHANGE=Zmie�'#13+
'HELP=Pomoc'#13+
'CLOSE=Zamknij'#13+
'TEECHART PRINT PREVIEW=Podgl�d wydruku TeeChart'#13+
'PRINTER=Drukarka'#13+
'SETUP=Ustawienia'#13+
'ORIENTATION=Orientacja'#13+
'PORTRAIT=Pionowo'#13+
'LANDSCAPE=Poziomo'#13+
'MARGINS (%)=Marginesy (%)'#13+
'DETAIL=Szczeg�y'#13+
'MORE=Wi�cej'#13+
'NORMAL=Normalnie'#13+
'RESET MARGINS=Resetuj marginesy'#13+
'VIEW MARGINS=Poka� marginesy'#13+
'PROPORTIONAL=Proporcjonalnie'#13+
'CIRCLE=Ko�o'#13+
'VERTICAL LINE=Linia pionowa'#13+
'HORIZ. LINE=Linia pozioma'#13+
'TRIANGLE=Tr�kat'#13+
'INVERT. TRIANGLE=Odwr�cony tr�k�t'#13+
'LINE=Linia'#13+
'DIAMOND=Diament'#13+
'CUBE=Sze�cian'#13+
'STAR=Gwiazda'#13+
'TRANSPARENT=Przezroczysty'#13+
'HORIZ. ALIGNMENT=Po�o�enie poziome'#13+
'CENTER=�rodek'#13+
'RIGHT=Prawo'#13+
'ROUND RECTANGLE=Zaokr�glony prostok�t'#13+
'ALIGNMENT=P�o�enie'#13+
'BOTTOM=D�'#13+
'UNITS=Jednostki'#13+
'PIXELS=Piksele'#13+
'AXIS ORIGIN=Pocz�tek osi'#13+
'ROTATION=Obr�t'#13+
'CIRCLED=Okr�g�y'#13+
'3 DIMENSIONS=3D'#13+
'RADIUS=Promie�'#13+
'ANGLE INCREMENT=Przyrost k�ta'#13+
'RADIUS INCREMENT=Przyrost promienia'#13+
'CLOSE CIRCLE=Zamknij ko�o'#13+
'PEN=Pi�rko'#13+
'LABELS=Etykiety'#13+
'ROTATED=Obr�cone'#13+
'CLOCKWISE=Z ruchem wskaz.'#13+
'INSIDE=Wewn�trz'#13+
'ROMAN=Rzymskie'#13+
'HOURS=Godziny'#13+
'MINUTES=Minuty'#13+
'SECONDS=Sekundy'#13+
'START VALUE=Warto�� pocz.'#13+
'END VALUE=Warto�� ko�c.'#13+
'TRANSPARENCY=Przezroczysto��'#13+
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
'DEPTH=G��bok.'#13+
'IRREGULAR=Nieregularny'#13+
'GRID=Siatka'#13+
'ALLOW DRAG=Pozw�l przeci�ga�'#13+
'VERTICAL POSITION=Pozycja pionowa'#13+
'LEVELS POSITION=Podziel na poziomy'#13+
'LEVELS=Poziomy'#13+
'NUMBER=Liczba'#13+
'LEVEL=Poziom'#13+
'AUTOMATIC=Automatycz.'#13+
'SNAP=Przyci�gaj'#13+
'FOLLOW MOUSE=Pod��aj za mysz�'#13+
'STACK=Skumulowany'#13+
'HEIGHT 3D=Wysoko�� 3D'#13+
'LINE MODE=Tryb linii'#13+
'OVERLAP=Na��'#13+
'STACK 100%=Skumulowany 100%'#13+
'CLICKABLE=Mo�na klika�'#13+
'AVAILABLE=Dost�pne'#13+
'SELECTED=Wybrane'#13+
'DATASOURCE=�r�d�o danych'#13+
'GROUP BY=Grupuj wg'#13+
'CALC=Licz.'#13+
'OF=z'#13+
'SUM=Sumuj'#13+
'COUNT=Ilo��'#13+
'HIGH=Wysoko'#13+
'LOW=Nisko'#13+
'AVG=�rednio'#13+
'HOUR=Godz.'#13+
'DAY=Dzie�'#13+
'WEEK=Tydzie�'#13+
'WEEKDAY=Dzie� tygodnia'#13+
'MONTH=Miesi�c'#13+
'QUARTER=Kwarta�'#13+
'YEAR=Rok'#13+
'HOLE %=Otw�r %'#13+
'RESET POSITIONS=Resetuj pozycje'#13+
'MOUSE BUTTON=Przycisk myszy'#13+
'ENABLE DRAWING=Pozw�l rysowa�'#13+
'ENABLE SELECT=Pozw�l wybiera�'#13+
'ENHANCED=Rozszerzony'#13+
'ERROR WIDTH=Szeroko�� b��du'#13+
'WIDTH UNITS=Jedn. szeroko�ci'#13+
'PERCENT=Procenty'#13+
'LEFT AND RIGHT=Lewo i Prawo'#13+
'TOP AND BOTTOM=G�ra i D�'#13+
'BORDER EDITOR=Edytor kraw�dzi'#13+
'DASH=Kreska'#13+
'DOT=Kropka'#13+
'DASH DOT=Kreska Kropka'#13+
'DASH DOT DOT=Kreska Kropka Kropka'#13+
'CALCULATE EVERY=Oblicz ka�dy'#13+
'ALL POINTS=Wszystkie punkty'#13+
'NUMBER OF POINTS=Liczba punkt�w'#13+
'RANGE OF VALUES=Zakres warto�ci'#13+
'FIRST=Pierwszy'#13+
'LAST=Ostatni'#13+
'TEEPREVIEW EDITOR=Edytor Tee-podgl�du'#13+
'ALLOW MOVE=Pozw�l przesuwa�'#13+
'ALLOW RESIZE=Pozw�l zmienia� rozmiar'#13+
'DRAG IMAGE=Ci�gnij obraz'#13+
'AS BITMAP=Jako bitmapa'#13+
'SHOW IMAGE=Poka� obraz'#13+
'MARGINS=Marginesy'#13+
'SIZE=Rozmiar'#13+
'3D %=3D %'#13+
'ZOOM=Powi�ksz.'#13+
'ELEVATION=Wzniesienie'#13+
'100%=100%'#13+
'HORIZ. OFFSET=Przes. poziome'#13+
'VERT. OFFSET=Przes. pionowe'#13+
'PERSPECTIVE=Perspektywa'#13+
'ANGLE=K�t'#13+
'ORTHOGONAL=Ortogonalny'#13+
'ZOOM TEXT=Skala tekstu'#13+
'SCALES=Skale'#13+
'TICKS=Podzia�ka'#13+
'MINOR=Drobna podzia�ka'#13+
'MAXIMUM=Maksimum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=Po��dany przyrost'#13+
'(INCREMENT)=(przyrost)'#13+
'LOG BASE=Podstawa log'#13+
'LOGARITHMIC=Logarytmiczny'#13+
'MIN. SEPARATION %=Minimalny odst�p %'#13+
'MULTI-LINE=Wieloliniowy'#13+
'LABEL ON AXIS=Etykiety na osi'#13+
'ROUND FIRST=Zaokr�glij pierwsz�'#13+
'MARK=Znaczniki'#13+
'LABELS FORMAT=Format etykiet'#13+
'EXPONENTIAL=Wyk�adniczy'#13+
'DEFAULT ALIGNMENT=Domy�lne po�o�enie'#13+
'LEN=D�ug.'#13+
'INNER=Wewn�trz'#13+
'AT LABELS ONLY=Tylko przy etykietach'#13+
'CENTERED=Wy�rodkowany'#13+
'POSITION %=Pozycja %'#13+
'START %=Pocz�tek %'#13+
'END %=Koniec %'#13+
'OTHER SIDE=Druga strona'#13+
'AXES=Osie'#13+
'BEHIND=Z ty�u'#13+
'CLIP POINTS=Obetnij wykres'#13+
'PRINT PREVIEW=Podgl�d wydruku'#13+
'MINIMUM PIXELS=Minimum pikseli'#13+
'ALLOW=Pozw�l'#13+
'ANIMATED=Animowany'#13+
'ALLOW SCROLL=Pozw�l przesuwa�'#13+
'TEEOPENGL EDITOR=Edytor TeeOpenGL'#13+
'AMBIENT LIGHT=O�wietlenie'#13+
'SHININESS=Po�ysk'#13+
'FONT 3D DEPTH=G��boko�� czcionki 3D'#13+
'ACTIVE=Aktywny'#13+
'FONT OUTLINES=Kontur czcionki'#13+
'SMOOTH SHADING=P�ynne cieniowanie'#13+
'LIGHT=�wiat�o'#13+
'Y=Y'#13+
'INTENSITY=Intensyw.'#13

{$IFDEF LCL}
;  TeePolishLanguage.Text:=TeePolishLanguage.Text
{$ENDIF}

+
'BEVEL=Skos'#13+
'FRAME=Ramka'#13+
'ROUND FRAME=Zaokr�glona ramka'#13+
'LOWERED=Obni�ony'#13+
'RAISED=Podniesiony'#13+
'SYMBOLS=Symbole'#13+
'TEXT STYLE=Styl tekstu'#13+
'LEGEND STYLE=Styl legendy'#13+
'VERT. SPACING=Odst�p pionowy'#13+
'SERIES NAMES=Nazwy serii'#13+
'SERIES VALUES=Warto�ci serii'#13+
'LAST VALUES=Ostatnie warto�ci'#13+
'PLAIN=Zwyk�y'#13+
'LEFT VALUE=Lewo warto��'#13+
'RIGHT VALUE=Prawo warto��'#13+
'LEFT PERCENT=Lewo procent'#13+
'RIGHT PERCENT=Prawo procent'#13+
'X VALUE=X warto��'#13+
'X AND VALUE=X i warto��'#13+
'X AND PERCENT=X i procent'#13+
'CHECK BOXES=Pola wielokrot. wyboru'#13+
'DIVIDING LINES=Linie podzia�u'#13+
'FONT SERIES COLOR=Koloruj kolorem serii'#13+
'POSITION OFFSET %=Przesuni�cie %'#13+
'MARGIN=Margines'#13+
'RESIZE CHART=Przeskaluj wykres'#13+
'CONTINUOUS=Ci�g�y'#13+
'POINTS PER PAGE=Punkt�w na stron�'#13+
'SCALE LAST PAGE=Skaluj ostatni� stron�'#13+
'CURRENT PAGE LEGEND=Legenda tylko dla bie�acej str.'#13+
'PANEL EDITOR=Edytor panelu'#13+
'BACKGROUND=T�o'#13+
'BORDERS=Kraw�dzie'#13+
'BACK IMAGE=Obraz w tle'#13+
'STRETCH=Rozci�gnij'#13+
'TILE=Wype�nij'#13+
'BEVEL INNER=Skos wewn.'#13+
'BEVEL OUTER=Skos zewn.'#13+
'MARKS=Znaczniki'#13+
'DATA SOURCE=�r�d�o danych'#13+
'SORT=Sortuj'#13+
'CURSOR=Kursor'#13+
'SHOW IN LEGEND=Poka� w legendzie'#13+
'FORMATS=Formaty'#13+
'VALUES=Warto�ci'#13+
'PERCENTS=Procenty'#13+
'HORIZONTAL AXIS=O� pozioma'#13+
'DATETIME=Data/czas'#13+
'VERTICAL AXIS=O� pionowa'#13+
'ASCENDING=Rosn�co'#13+
'DESCENDING=Malej�co'#13+
'DRAW EVERY=Rysuj co'#13+
'CLIPPED=Obci�ty'#13+
'ARROWS=Strza�ki'#13+
'MULTI LINE=Wieloliniowy'#13+
'ALL SERIES VISIBLE=Poka� dla wszystkich serii'#13+
'LABEL=Etykieta'#13+
'LABEL AND PERCENT=Etykieta i procent'#13+
'LABEL AND VALUE=Etykieta i warto��'#13+
'PERCENT TOTAL=Procent ca�o�ci'#13+
'LABEL AND PERCENT TOTAL=Etykieta i procent ca�o�ci'#13+
'X AND Y VALUES=X i Y Warto��'#13+
'MANUAL=R�cznie'#13+
'RANDOM=Losowo'#13+
'FUNCTION=Funkcja'#13+
'NEW=Nowy'#13+
'EDIT=Edytuj'#13+
'PERSISTENT=Trwa�y'#13+
'ADJUST FRAME=Dopasuj ramk�'#13+
'SUBTITLE=Podtytu�'#13+
'SUBFOOT=Stopka 2'#13+
'FOOT=Stopka'#13+
'VISIBLE WALLS=�ciany widoczne'#13+
'BACK=Z ty�u'#13+
'DIF. LIMIT=Limit'#13+
'ABOVE=Powy�ej'#13+
'WITHIN=Wewn�trz'#13+
'BELOW=Poni�ej'#13+
'CONNECTING LINES=Linie ��cz�ce'#13+
'BROWSE=Szukaj w'#13+
'TILED=Wype�niony'#13+
'INFLATE MARGINS=Zwi�ksz marginesy'#13+
'SQUARE=Kwadrat'#13+
'DOWN TRIANGLE=Odwr�cony tr�jk�t'#13+
'SMALL DOT=Ma�e kropki'#13+
'GLOBAL=Globalny'#13+
'SHAPES=Kszta�ty'#13+
'BRUSH=P�dzel'#13+
'DELAY=Op�nienie'#13+
'MSEC.=msek.'#13+
'MOUSE ACTION=Akcja myszy'#13+
'MOVE=Przesu�'#13+
'CLICK=Klik'#13+
'DRAW LINE=Rysuj linie'#13+
'EXPLODE BIGGEST=Wysu� najwi�kszy'#13+
'TOTAL ANGLE=K�t sumaryczny'#13+
'GROUP SLICES=Grupuj wycinki'#13+
'BELOW %=Poni�ej %'#13+
'BELOW VALUE=Poni�ej warto�ci'#13+
'OTHER=Inne'#13+
'PATTERNS=Wzory'#13+
'SIZE %=Rozmiar %'#13+
'SERIES DATASOURCE TEXT EDITOR=Edytor tekstu zr�de� danych serii'#13+
'FIELDS=Pola'#13+
'NUMBER OF HEADER LINES=Ilo�� linii nag��wka'#13+
'SEPARATOR=Separator'#13+
'COMMA=Przecinek'#13+
'SPACE=Przestrze�'#13+
'TAB=Tabulator'#13+
'FILE=Plik'#13+
'WEB URL=Web URL'#13+
'LOAD=Za�aduj'#13+
'C LABELS=C Etykiety'#13+
'R LABELS=R Etykiety'#13+
'C PEN=C Pi�rko'#13+
'R PEN=R Pi�rko'#13+
'STACK GROUP=Grupowanie'#13+
'MULTIPLE BAR=Wiele kolumn'#13+
'SIDE=S�siaduj�co'#13+
'SIDE ALL=S�siad. wszystkie'#13+
'DRAWING MODE=Tryb rysowania'#13+
'WIREFRAME=Siatka druciana'#13+
'DOTFRAME=Siatka punktowa'#13+
'SMOOTH PALETTE=Wyg�ad� palet�'#13+
'SIDE BRUSH=P�dzel boczny'#13+
'ABOUT TEECHART PRO V7.0=O TeeChart Pro v7.0...'#13+
'ALL RIGHTS RESERVED.=Wczystkie Prawa Zastrze�one.'#13+
'VISIT OUR WEB SITE !=Odwied� nasz� witryn�!'#13+
'TEECHART WIZARD=TeeChart Kreator'#13+
'SELECT A CHART STYLE=Wybierz styl wykresu'#13+
'DATABASE CHART=Wykres bazodanowy'#13+
'NON DATABASE CHART=Wykres nie bazodanowy'#13+
'SELECT A DATABASE TABLE=Wybierz tabel� bazy danych'#13+
'ALIAS=Alias'#13+
'TABLE=Tabela'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Wybierz pola do wykresu'#13+
'SELECT A TEXT LABELS FIELD=Wybierz pole z tekstem etykiet'#13+
'CHOOSE THE DESIRED CHART TYPE=Wybierz typ wykresu'#13+
'2D=2D'#13+
'CHART PREVIEW=Podgl�d wykresu'#13+
'SHOW LEGEND=Poka� legend�'#13+
'SHOW MARKS=Poka� znaczniki'#13+
'< BACK=< Wstecz'#13+
'EXPORT CHART=Eksportuj wykres'#13+
'PICTURE=Obraz'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=Zachowaj proporcje'#13+
'INCLUDE SERIES DATA=Do��cz dane serii'#13+
'FILE SIZE=Rozmiar pliku'#13+
'DELIMITER=Separator'#13+
'XML=XML'#13+
'HTML TABLE=Tabela HTML'#13+
'EXCEL=Excel'#13+
'COLON=Dwukropek'#13+
'INCLUDE=Do��cz'#13+
'POINT LABELS=Etykiety punktu'#13+
'POINT INDEX=Indeks punktu'#13+
'HEADER=Nag��wek'#13+
'COPY=Kopiuj'#13+
'SAVE=Zapisz'#13+
'SEND=Wy�lij'#13+
'FUNCTIONS=Funkcje'#13+
'ADX=ADX'#13+
'AVERAGE=�rednia'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=Podziel'#13+
'EXP. AVERAGE=�rednia exp.'#13+
'EXP.MOV.AVRG.=�rednia exp. ruch.'#13+
'MACD=MACD'#13+
'MOMENTUM=P�d'#13+
'MOMENTUM DIV=P�d (div.)'#13+
'MOVING AVRG.=�rednia ruchoma'#13+
'MULTIPLY=Pomn�'#13+
'R.S.I.=R.S.I'#13+
'ROOT MEAN SQ.=�red.pierw.kw.'#13+
'STD.DEVIATION=Odchylenie stand.'#13+
'STOCHASTIC=Stochastyczny'#13+
'SUBTRACT=Odejmij'#13+
'SOURCE SERIES=�r�d�o serii'#13+
'TEECHART GALLERY=Galeria TeeChart'#13+
'DITHER=Dithering'#13+
'REDUCTION=Redukcja'#13+
'COMPRESSION=Kompresja'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Najbli�szy'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Szary'#13+
'GRAY SCALE=Skala szaro�ci'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Kwantyzuj'#13+
'QUANTIZE 256=Kwantyzuj 256'#13+
'% QUALITY=% jako�ci'#13+
'PERFORMANCE=Wydajno��'#13+
'QUALITY=Jako��'#13+
'SPEED=Pr�dko��'#13+
'COMPRESSION LEVEL=Poziom kompresji'#13+
'CHART TOOLS GALLERY=Galeria narz�dzi wykresu'#13+
'ANNOTATION=Adnotacja'#13+
'AXIS ARROWS=Strza�ki osi'#13+
'COLOR BAND=Koloruj pasmo'#13+
'COLOR LINE=Koloruj linie'#13+
'DRAG MARKS=Ci�gnij znaczniki'#13+
'MARK TIPS=Dymki ze znacznikiem'#13+
'NEAREST POINT=Najbli�szy punkt'#13+
'ROTATE=Obr��'#13+
'YES=Tak'#13+

{$IFDEF TEEOCX}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- Wybierz �rod�o danych ADO'#13+
'CONNECTION=Po��czenie'#13+
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
'DELETE ROW=Usu� wiersz'#13+
'VOLUME SERIES=Pasmowy'#13+
'SINGLE=Pojedynczy'#13+
'REMOVE CUSTOM COLORS=Usu� kolory u�ytkownika'#13+
'USE PALETTE MINIMUM=U�yj minimum dla palety'#13+
'AXIS MAXIMUM=Maksimum osi'#13+
'AXIS CENTER=�rodek osi'#13+
'AXIS MINIMUM=Minimum osi'#13+
'DAILY (NONE)=Dziennie (brak)'#13+
'WEEKLY=Tygodniowo'#13+
'MONTHLY=Miesi�cznie'#13+
'BI-MONTHLY=Dwumiesi�cznie'#13+
'QUARTERLY=Kwartalnie'#13+
'YEARLY=Rocznie'#13+
'DATETIME PERIOD=Okres daty/czasu'#13+
'CASE SENSITIVE=Rozr�niaj wielko�� liter'#13+
'DRAG STYLE=Kierunek przeci�gania'#13+
'SQUARED=Kwadratowy'#13+
'GRID 3D SERIES=Siatka 3D'#13+
'DARK BORDER=Ciemna kraw�d�'#13+
'PIE SERIES=Wycinek ko�a'#13+
'FOCUS=Pod�wietl'#13+
'EXPLODE=Rozsu�'#13+
'FACTOR=Jasno��'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Wykres z szablonu (*.tee)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Otw�rz plik szablonu z'#13+
'BINARY=Binarny'#13+
'VOLUME OSCILLATOR=Oscylator wolumenu'#13+
'PIE SLICES=Wycinki ko�a'#13+
'ARROW WIDTH=Szeroko�� strza�ki'#13+
'ARROW HEIGHT=Wysoko�� strza�ki'#13+
'DEFAULT COLOR=Domy�lny kolor'#13+
'PERIOD=Okres'#13+
'UP=G�ra'#13+
'DOWN=D�'#13+
'SHADOW EDITOR=Edytor cienia'#13+
'CALLOUT=Strza�ka'#13+//odsy�acz?
'TEXT ALIGNMENT=Wyr�wnanie tekstu'#13+
'DISTANCE=Odleg�o��'#13+
'ARROW HEAD=Koniec strza�ki'#13+
'POINTER=Wska�nik'#13+
'AVAILABLE LANGUAGES=Dost�pne j�zyki'#13+
'CHOOSE A LANGUAGE=Wybierz j�zyk'#13+
'CALCULATE USING=Oblicz u�ywaj�c'#13+
'EVERY NUMBER OF POINTS=Co zadan� liczb� punkt�w'#13+
'EVERY RANGE=Ka�dy zakres'#13+
'INCLUDE NULL VALUES=Uwzgl�dniaj puste warto�ci'#13+
'INVERTED SCROLL=Odwrotne przesuwanie'#13+
'ONE MICROSECOND=Jedna mikrosekunda'#13+
'DATE=Data'#13+
'ENTER DATE=Wprowad� dat�'#13+
'ENTER TIME=Wprowad� czas'#13+
'SLANT CUBE=Uko�ny sze�cian'#13+
'INVERT. ARROW=Odwr�cona strza�ka'#13+
'INVERT. CONE=Odwr�cony sto�ek'#13+
'TICK LINES=Linie podzia�ki'#13+
'% BAR DEPTH=G��boko�� %'#13+
'DEVIATION=Odchylenie'#13+
'UPPER=G�rny'#13+
'LOWER=Dolny'#13+
'METAL=Metal'#13+
'WOOD=Drewno'#13+
'STONE=Kamie�'#13+
'CLOUDS=Chmury'#13+
'GRASS=Trawa'#13+
'FIRE=Ogie�'#13+
'SNOW=�nieg'#13+
'NOTHING=Brak'#13+
'LEFT TRIANGLE=Tr�jk�t lewy'#13+
'RIGHT TRIANGLE=Tr�jk�t prawy'#13+
'SHOW PREVIOUS BUTTON=Poka� poprzedni przycisk'#13+
'SHOW NEXT BUTTON=Poka� nast�pny przycisk'#13+
'HIGH-LOW=Wysoko-nisko'#13+
'COLOR STYLE=Styl koloru'#13+
'RELATIVE TO OPEN=Wzgl�dem otwarcia'#13+
'RELATIVE TO PREVIOUS CLOSE=Wzgl�d. poprzed. zamkni�cia'#13+
'CONSTANT=Sta�a'#13+
'VIEW SERIES NAMES=Poka� nazwy serii'#13+
'SHOW LABELS=Poka� etykiety'#13+
'SHOW COLORS=Poka� kolory'#13+
'XYZ SERIES=Serie XYZ'#13+
'SHOW X VALUES=Poka� warto�ci X'#13+
'EDIT COLOR=Edytuj kolor'#13+
'MAKE NULL POINT=Utw�rz pusty punkt'#13+
'APPEND ROW=Do��cz wiersz'#13+
'TEXT FONT=Czcionka tekstu'#13+
'SMOOTH=Wyg�ad�'#13+
'CHART THEME SELECTOR=Wyb�r tematu wykresu'#13+
'PREVIEW=Podgl�d'#13+
'THEMES=Tematy'#13+
'COLOR PALETTE=Paleta kolor�w'#13+
'VIEW 3D=Widok 3D'#13+
'SCALE=Skaluj'#13+
'MARGIN %=% marginesu'#13+
'ACCUMULATE=Akumuluj'#13+
'DRAW BEHIND AXES=Rysuj przed osiami'#13+
'GRID EVERY=Siatka co'#13+
'DRAG REPAINT=Od�wie�aj przy przeci�ganiu'#13+
'NO LIMIT DRAG=Nie ograniczaj przeci�gania'#13+
'DATE PERIOD=Okres daty'#13+
'TIME PERIOD=Okres czasu'#13+
'INTERPOLATE=Interpoluj'#13+
'CLICK TOLERANCE=Obszar klikni�cia'#13+
'USE SERIES Z=U�yj serii Z'#13+
'START X=Pocz�tek X'#13+
'STEP=Krok'#13+
'NUM. POINTS=Ilo�� punkt�w'#13+
'COLOR EACH LINE=Koloruj ka�d� lini�'#13+
'SORT BY=Sortuj wg'#13+
'(NONE)=(brak)'#13+
'CALCULATION=Obliczenia'#13+
'GROUP=Grupa'#13+
'SELECT NEW LINES=Zaznacz nowe linie'#13+
'WEIGHT=Waga'#13+
'EDIT LEGEND=Edytuj legend�'#13+
'ROUND=Okr�g�y'#13+
'FLAT=P�aski'#13+
'DRAW ALL=Rysuj wszystkie'#13+
'IGNORE NULLS=Ignoruj puste warto�ci'#13+
'NUMERIC FORMAT=Format dla tekstu'#13+
'D.M.YYYY=dd.mm.yyyy'#13+
'DATE TIME=Data/czas'#13+
'GEOGRAPHIC=Geograficzny'#13+
'DECIMALS=Dziesi�tne'#13+
'FIXED=Sta�e'#13+
'THOUSANDS=Tysi�ce'#13+
'CURRENCY=Waluta'#13+
'VIEWS=Widoki'#13+
'OFFSET=Przesuni�cie'#13+
'ALTERNATE=Alternatywnie'#13+
'ZOOM ON UP LEFT DRAG=Powi�ksz przy ci�gn. w lewy g�rny r�g'#13+
'LIGHT 0=�wiat�o 0'#13+
'LIGHT 1=�wiat�o 1'#13+
'LIGHT 2=�wiat�o 2'#13+
'FIXED POSITION=Sta�a pozycja'#13+
'DRAW STYLE=Styl rysowania'#13+
'POINTS=Punkty'#13+
'NO CHECK BOXES=Brak p�l wyboru'#13+
'RADIO BUTTONS=Pola pojedy�czego wyboru'#13+
'DEFAULT BORDER=Domy�lna kraw�d�'#13+
'SHOW PAGE NUMBER=Poka� numer strony'#13+
'SEPARATION=Odst�p'#13+
'ROUND BORDER=Zaokr�glona kraw�d�'#13+
'Z DATETIME=O� Z jako data/czas'#13+
'NUMBER OF SAMPLE VALUES=Ilo�� losowych danych'#13+
'AUTO HIDE=Auto-ukrywanie'#13+
'RESIZE PIXELS TOLERANCE=Tolerancja przy przeci�ganiu'#13+
'FULL REPAINT=Wype�nij kolorem'#13+
'END POINT=Punkt ko�cowy'#13+
'GALLERY=Galeria'#13+
'INVERTED GRAY=Odwr�cona szaro��'#13+
'RAINBOW=T�cza'#13+
'BAND 1=Pasmo 1'#13+
'BAND 2=Pasmo 2'#13+
'TRANSPOSE NOW=Transponuj teraz'#13+
'TEECHART LIGHTING=O�wietlenie TeeChart'#13+
'LINEAR=Liniowe'#13+
'SPOTLIGHT=Reflektor'#13+
'PERIOD 1=Okres 1'#13+
'PERIOD 2=Okres 2'#13+
'PERIOD 3=Okres 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Linia exp.'#13+
'SHAPE INDEX=Indeks kszta�tu'#13+
'CLOSED=Zamknij'#13+
'WEIGHTED=Wa�ona'#13+
'WEIGHTED BY INDEX=Wa�ona wg indeksu'#13+
'DESIGN TIME OPTIONS=Opcje wy�wietlania'#13+
'LANGUAGE=J�zyk'#13+
'CHART GALLERY=Galeria wykres�w'#13+
'MODE=Tryb      (Modalna)'#13+
'CHART EDITOR=Edytor wykresu'#13+
'REMEMBER SIZE=Zapami�taj rozmiar'#13+
'REMEMBER POSITION=Zapami�taj pozycj�'#13+
'TREE MODE=Tryb drzewiasty'#13+
'NEW CHART=Nowy wykres'#13+
'DEFAULT THEME=Domy�lny temat'#13+
'TEECHART DEFAULT=Standardowy'#13+
'CLASSIC=Klasyczny'#13+
'BIZNES=Biznesowy'#13+
'BLUES=Blues'#13+
'FACTS=Fakty'#13+
'MULTIPLE PIES=Kilka wykres�w'#13+
'3D GRADIENT=Gradient 3D'#13+
'DISABLE=Wy��cz'#13+
'COLOR EACH SLICE=Koloruj ka�dy wycinek'#13+
'BASE LINE=Linia odniesienia'#13+
'BOX SIZE=Rozmiar pude�ka'#13+
'REVERSAL AMOUNT=Odwrotny kierunek'#13+
'PERCENTAGE=Procenty'#13+
'COMPLETE R.M.S.=Ca�kowity R.M.S.'#13+
'BUTTON=Przycisk'#13+
'INITIAL DELAY=Op�nienie pocz�tkowe'#13+
'THUMB=Suwak'#13+
'AUTO-REPEAT=Auto-powtarzanie'#13+
'BACK COLOR=Kolor w tle'#13+
'HANDLES=Uchwyty'#13+
'ALLOW RESIZE CHART=Pozw�l zmienia� rozmiar wykresu'#13+
'LOOP=P�tla'#13+
'START AT MIN. VALUE=Zacznij od warto�ci min.'#13+
'EXECUTE !=Wykonaj !'#13+
'ONE WAY=Jeden kierunek'#13+
'CIRCULAR=Okr�g�y'#13+
'DRAW BEHIND SERIES=Rysuj za seriami'#13+
'IMAG. SYMBOL=Symbol urojon.'#13+
'SELF STACK=Zsumowany'#13+
'SURFACE=Powierzchnia'#13+
'CELL=Kom�rka'#13+
'ROW=Wiersz'#13+
'COLUMN=Kolumna'#13+
'SIDE LINES=Linie boczne'#13+
'FAST BRUSH=Szybki p�dzel'#13+
'SVG OPTIONS=Opcje SVG'#13+
'TEXT ANTI-ALIAS=Wyg�ad� tekst'#13+
'THEME=Temat'#13+
'EXPORT DIALOG=Okno eksportu'#13+
'TEXT QUOTES=Znaczniki tekstu'#13+
'POINT COLORS=Kolor punktu'#13+
'OUTLINE GRADIENT=Kontur gradientowy'#13+
'BALANS WOLUMEN=Wolumen zr�wnowa�ony'#13+
'STAT.=Statystyczne'#13+
'ACE=As'#13+
'BUSINESS=Biznes'#13+
'CARIBE SUN=Tropikalne s�o�ce'#13+
'CLEAR DAY=Pi�kny dzie�'#13+
'DESERT=Pustynia'#13+
'FARM=Farma'#13+
'FUNKY=Funky'#13+
'GOLF=Golf'#13+
'HOT=Upa�'#13+
'NIGHT=Noc'#13+
'PASTEL=Pastele'#13+
'SEA=Morze'#13+
'SEA 2=Morze 2'#13+
'SUNSET=Zach�d s�o�ca'#13+
'TROPICAL=Tropiki'#13+
'BALANCE=Balans'#13+
'RADIAL OFFSET=Przesuni�cie promienia'#13+
'HORIZ=Poziom'#13+
'VERT=Pion'#13+
'RADIAL=Promienisty'#13+
'DIAGONAL UP=Uko�ny do g�ry'#13+
'DIAGONAL DOWN=Uko�ny na d�'#13+
'COVER=Przykrycie'#13+
'HIDE TRIANGLES=Ukryj tr�jk�ty'#13+
'MIRRORED=Lustrzany'#13+
'VALUE SOURCE=�r�d�o warto�ci'#13+

  // compatible with TeeChart 7.05
  // missing translations added by masch(at)zg.pl 20.3.2005

'3D GRID TRANSPOSE=Transponuj siatk� 3D'#13+
'ALL=Wszystko'#13+
'ANNOTATION PROPERTIES=W�a�ciwo�ci adnotacji'#13+
'AUTO SIZE=Rozmiar autom.'#13+
'AXIS LINE=Linie osi'#13+
'AXIS PROPERTIES=W�a�ciwo�ci osi'#13+
'BAR DEPTH=G��boko�� kolumny'#13+
'BUBBLE=B�belek'+#13+
'CANDLE=S�upek'+#13+
'CHANGE SERIES TITLE=Zmie� tytu� serii'+#13+
'COMMODITY CHANNEL INDEX=Indeks kszta�tu'#13'towaru (CCI)'#13+
'CROSS POINTS=Punkty krzy�owe'#13+
'CURRENT=Aktualny'#13+
'CUSTOM POSITION=Pozycja u�ytkownika'#13+
'DEFAULT COLOR=Domy�lny kolor'#13+
'DEFAULT=Domy�lny'+#13+
'DELETE %S ?=Usun�� %s ?'+#13+
'DEPTH TOP=G��boko�� u g�ry'#13+
'DESIRED %S INCREMENT=Po��dany przyrost %s'+#13+
'DRAG POINT=Ci�gnij punkt'#13+
'DRAG=Przeci�gaj'#13+
'EDIT COLOR=Editar Color'#13+
'EXP.TREND=Trend exp.'#13+
'EXTENDED=Rozszerzony'+#13+
'EXTRA LEGEND=Dodatkowa legenda'#13+
'FAST LINE=Liniowy szybki'+#13+
'FINANCIAL=Finansowe'+#13+
'FINISH=Koniec'+#13+
'GANTT DRAG=Ci�gnij Gantt'#13+
'GAUGES=Wska�niki'#13+
'GRAY SCALE VISUAL=Skala szar. ulepszona'#13+
'GRID BAND TOOL=Pasmo siatki'#13+
'HANDPOINT=R�ka'#13+
'HORIZ. BAR=Kolumna pozioma'+#13+
'HOURGLASS=Klepsydra'#13+
'INCORRECT VALUE. REASON: %S=nieprawid�owa warto��. Pow�d: %s'+#13+
'INVERTED PYRAMID=Odwr�cona piramida'+#13+
'LABEL PERCENT TOTAL=Etykieta procent ca�k.'#13+
'LABEL PERCENT=Etykieta procent'#13+
'LABEL VALUE=Etykieta warto��'#13+
'LEGEND PROPERTIES=W�a�ciwo�ci legendy'#13+
'MARKS PROPERTIES=W�a�ciwo�ci znacznika'#13+
'MINOR GRID=Drobna siatka'#13+
'MODERN=Nowoczesny'#13+
'MOVE DOWN=Przesu� w g�r�'#13+
'MOVE UP=Przesu� w d�'#13+
'NEXT >= Dalej >'+#13+
'OFF=Wy��czony'#13+
'ON BALANCE VOLUME=Balans wolumen'#13+
'ON=W��czony'#13+
'PAGE %D OF %D=Strona %d z %d'#13+
'PAGE NUMBER=Numer strony'#13+
'PANEL COLOR=Kolor panelu'+#13+
'PANEL PROPERTIES=W�a�ciwo�ci panelu'#13+
'PERIMETER=Obw�d'#13+
'PIE=Ko�o'+#13+
'POINT=Punkt'+#13+
'RESET=Resetuj'#13+
'SELECT ALL=Zaznacz wszystkie'#13+
'SERIES ANIMATION=Animacja serii'#13+
'SERIES COLOR=Kolor serii'#13+
'SERIES PROPERTIES=W�a�ciwo�ci serii'#13+
'SMOOTHING=Wyg�adzanie'#13+
'STAIRS INVERTED=Odwr�cone schody'#13+
'STATS=Statystyki'+#13+
'TEECHART LANGUAGES=J�zyki TeeChart'#13+
'TEXT FILE=Plik tekstowy'#13+
'TITLE PROPERTIES=W�a�ciwo�ci tytu�u'#13+
'TREND=Trend'#13+
'VICTORIAN=Wiktoria�ski'#13+
'VOLUME=Wolumen'+#13+
'WALL PROPERTIES=W�a�ciwo�ci �ciany'#13+
'WEB=Sieciowy'#13+
'WINDOWS XP=Windows XP'#13+
'VIEW=Widok'#13+
'DATASOURCES=�r�d�a danych'#13+
'X GRID EVERY=Siatka X co'#13+
'Y GRID EVERY=Siatka Y co'#13+
'XY=XY'#13+
'Z GRID EVERY=Siatka Z co'#13+
'Z %=Z %'#13+
'3D FRONT=3D z przodu'#13+
'FROM=Od'#13+
'TO=Do'#13+
'PERIOD RANGE=Zakres okresu'#13+
'INVERTED GRAY SCALE=Odwr�cona skala szar.'#13+
'PASTELS=Pastele'#13+
'BACK WALL=Tylna �ciana'#13+
'EXPRESSION=Wyra�enie'
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
