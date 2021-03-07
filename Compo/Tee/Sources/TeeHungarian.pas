unit TeeHungarian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeHungarianLanguage:TStringList=nil;

Procedure TeeSetHungarian;
Procedure TeeCreateHungarian;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeHungarianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 by David Berneda';
  TeeMsg_LegendFirstValue   :='A jelmagyar�zat els� �rt�ke legyen > 0';
  TeeMsg_LegendColorWidth   :='A jelmagyar�zat sz�nm�lys�ge legyen > 0%';
  TeeMsg_SeriesSetDataSource:='Nincs sz�l� diagram az adatforr�s �rv�nyes�t�s�hez';
  TeeMsg_SeriesInvDataSource:='�rv�nytelen adatforr�s: %s';
  TeeMsg_FillSample         :='A kit�lt�si p�lda �rt�kei legyenek > 0';
  TeeMsg_AxisLogDateTime    :='A d�tum/id� tengely nem lehet logaritmikus';
  TeeMsg_AxisLogNotPositive :='A logaritmikus tengely min �s max �rt�ke legyen >= 0';
  TeeMsg_AxisLabelSep       :='A felirat elv�laszt�s % legyen nagyobb mint 0';
  TeeMsg_AxisIncrementNeg   :='A tengely n�veked�s legyen  >= 0';
  TeeMsg_AxisMinMax         :='A tengely legkissebb �rt�ke legyen <= Maximum';
  TeeMsg_AxisMaxMin         :='A tengely legnagyobb �rt�ke legyen >= Minimum';
  TeeMsg_AxisLogBase        :='A tengely logaritmikus alapja legyen >= 2';
  TeeMsg_MaxPointsPerPage   :='A maximum pont / oldal legyen >= 0';
  TeeMsg_3dPercent          :='A 3D hat�s sz�zal�ka legyen %d �s %d k�z�tt';
  TeeMsg_CircularSeries     :='A visszat�r� sorok f�gg�s�ge nincs megengedve';
  TeeMsg_WarningHiColor     :='A jobb l�tv�nyhoz 16k sz�n vagy t�bb sz�ks�ges';

  TeeMsg_DefaultPercentOf   :='%s %s-a';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'%s-a';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Tengely neve';
  TeeMsg_AxisLabels         :='Tengelyfeliratok';
  TeeMsg_RefreshInterval    :='A friss�t�si intervallumnak 0 �s 60 k�z�tt kell lennie';
  TeeMsg_SeriesParentNoSelf :='A sor sz�l� diagramja nem saj�t maga!';
  TeeMsg_GalleryLine        :='Vonal';
  TeeMsg_GalleryPoint       :='Pont';
  TeeMsg_GalleryArea        :='Felsz�n';
  TeeMsg_GalleryBar         :='S�v';
  TeeMsg_GalleryHorizBar    :='V�zsz. s�v';
  TeeMsg_Stack              :='Halom';
  TeeMsg_GalleryPie         :='K�rdiagram';
  TeeMsg_GalleryCircled     :='K�r';
  TeeMsg_GalleryFastLine    :='Er�s vonal';
  TeeMsg_GalleryHorizLine   :='V�zsz. vonal';

  TeeMsg_PieSample1         :='Aut�k';
  TeeMsg_PieSample2         :='Telefonok';
  TeeMsg_PieSample3         :='Asztalok';
  TeeMsg_PieSample4         :='Monitorok';
  TeeMsg_PieSample5         :='L�mp�k';
  TeeMsg_PieSample6         :='Billenty�zetek';
  TeeMsg_PieSample7         :='Ker�kp�rok';
  TeeMsg_PieSample8         :='Sz�kek';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='%s-os szerkeszt�s';

  TeeMsg_GalleryStandard    :='�tlag';
  TeeMsg_GalleryExtended    :='Kiterjesztett';
  TeeMsg_GalleryFunctions   :='F�ggv�nyek';

  TeeMsg_EditChart          :='Grafikon &szerkeszt�s...';
  TeeMsg_PrintPreview       :='&Nyomtat�si k�p...';
  TeeMsg_ExportChart        :='Grafikon &export...';
  TeeMsg_CustomAxes         :='K�z�s tengelyek...';

  TeeMsg_InvalidEditorClass :='%s: �rv�nytelen szerkeszt�si oszt�ly: %s';
  TeeMsg_MissingEditorClass :='%s: nincs szerkeszt�si dial�gus';

  TeeMsg_GalleryArrow       :='Ny�l';

  TeeMsg_ExpFinish          :='&V�ge';
  TeeMsg_ExpNext            :='&K�vetkez� >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Tervez�s';
  TeeMsg_GanttSample2       :='Protot�pusk�sz�t�s';
  TeeMsg_GanttSample3       :='Fejleszt�s';
  TeeMsg_GanttSample4       :='�rt�kes�t�s';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Tesztel�s';
  TeeMsg_GanttSample7       :='Gy�rt�s';
  TeeMsg_GanttSample8       :='Hibakeres�s';
  TeeMsg_GanttSample9       :='�j verzi�';
  TeeMsg_GanttSample10      :='Bank�gylet';

  TeeMsg_ChangeSeriesTitle  :='Sor-c�m v�ltoztat�s';
  TeeMsg_NewSeriesTitle     :='�j sor-c�m:';
  TeeMsg_DateTime           :='D�tum/id�';
  TeeMsg_TopAxis            :='Fels� tengely';
  TeeMsg_BottomAxis         :='Als� tengely';
  TeeMsg_LeftAxis           :='Bal tengely';
  TeeMsg_RightAxis          :='Jobb tengely';

  TeeMsg_SureToDelete       :='T�rl�s %s ?';
  TeeMsg_DateTimeFormat     :='D�tum/id� &form�tum:';
  TeeMsg_Default            :='Alap�rtelmezett';
  TeeMsg_ValuesFormat       :='�rt�k For&m�tum:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='K�v�nt %s-os N�veked�s';

  TeeMsg_IncorrectMaxMinValue:='Hib�s �rt�k. Ok: %s';
  TeeMsg_EnterDateTime      :='Felv�tel [Napok sz�ma] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='V�ltoz�s elfogadva ?';
  TeeMsg_SelectedSeries     :='(Kiv�lasztott sor)';
  TeeMsg_RefreshData        :='&Adat friss�t�s';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_FunctionAdd        :='Hozz�ad�s';
  TeeMsg_FunctionSubtract   :='Kivon�s';
  TeeMsg_FunctionMultiply   :='Szorz�s';
  TeeMsg_FunctionDivide     :='Oszt�s';
  TeeMsg_FunctionHigh       :='Nagy';
  TeeMsg_FunctionLow        :='Alacsony';
  TeeMsg_FunctionAverage    :='�tlagos';

  TeeMsg_GalleryShape       :='Minta';
  TeeMsg_GalleryBubble      :='Bubor�k';
  TeeMsg_FunctionNone       :='M�sol';

  TeeMsg_None               :='(none)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :=' A Pointer m�rete legyen nagyobb, mint 0';
  TeeMsg_About              :='Abo&ut TeeChart...';

  tcAdditional              :='Tov�bbi';
  tcDControls               :='Adatvez�rl�s';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Adat�llom�ny';
  TeeMsg_AskDataSet         :='&Adat�llom�ny:';

  TeeMsg_SingleRecord       :='Egyes rekord';
  TeeMsg_AskDataSource      :='&Adatforr�s:';

  TeeMsg_Summary            :='�sszegz�s';

  TeeMsg_FunctionPeriod     :='A f�ggv�ny peri�dus legyen >= 0';

  TeeMsg_WizardTab          :='�zlet';
  TeeMsg_TeeChartWizard     :='TeeChart Var�zsl�';

  TeeMsg_ClearImage         :='&T�r�l';
  TeeMsg_BrowseImage        :='&B�ng�sz�s...';

  TeeMsg_WizardSureToClose  :='Biztos, hogy bez�rja a TeeChart var�zsl�t ?';
  TeeMsg_FieldNotFound      :='A %s mez� nem l�tezik';

  TeeMsg_DepthAxis          :='Tengely m�lys�ge';
  TeeMsg_PieOther           :='Egy�b';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='K�rdiagram';
  TeeMsg_ValuesBar          :='S�v';
  TeeMsg_ValuesAngle        :='Sz�g';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='V�ge';
  TeeMsg_ValuesGanttNextTask:='K�vetkez� feladat';
  TeeMsg_ValuesBubbleRadius :='Radi�n';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='Jelmagyar�zat';
  TeeMsg_Title              :='C�m';
  TeeMsg_Foot               :='L�bl�c';
  TeeMsg_Period		    :='Szakasz';
  TeeMsg_PeriodRange        :='Szakaszhat�r';
  TeeMsg_CalcPeriod         :='Minden %s-ot sz�mol:';
  TeeMsg_SmallDotsPen       :='Kis pontok';

  TeeMsg_InvalidTeeFile     :='�rv�ny�telen karakter a *.'+TeeMsg_TeeExtension+' f�jlban';
  TeeMsg_WrongTeeFileFormat :='Rossz *.'+TeeMsg_TeeExtension+' f�jl form�tum';
  TeeMsg_EmptyTeeFile       :='�res *.'+TeeMsg_TeeExtension+' f�jl';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Grafikon tengelyek';
  TeeMsg_ChartAxesCategoryDesc   := 'Grafikon tengelyek jellemz�i �s esem�nyei';
  TeeMsg_ChartWallsCategoryName  := 'Grafikon h�tterek';
  TeeMsg_ChartWallsCategoryDesc  := 'Grafikon h�tterek jellemz�i �s esem�nyei';
  TeeMsg_ChartTitlesCategoryName := 'Grafikon c�mek';
  TeeMsg_ChartTitlesCategoryDesc := 'Grafikonc�mek jellemz�i �s esem�nyei';
  TeeMsg_Chart3DCategoryName     := '3D Grafikon';
  TeeMsg_Chart3DCategoryDesc     := '3D Grafikon jellemz�i �s esem�nyei';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='K�z�s ';
  TeeMsg_Series                 :='Sorok';
  TeeMsg_SeriesList             :='Sorok...';

  TeeMsg_PageOfPages            :='A %d %d oldala';
  TeeMsg_FileSize               :='%d b�jt';

  TeeMsg_First  :='Els�';
  TeeMsg_Prior  :='El�z�';
  TeeMsg_Next   :='K�vetkez�';
  TeeMsg_Last   :='Utols�';
  TeeMsg_Insert :='Besz�r�s';
  TeeMsg_Delete :='T�rl�s';
  TeeMsg_Edit   :='Szerkeszt�s';
  TeeMsg_Post   :='Ment�s';
  TeeMsg_Cancel :='M�gsem';

  TeeMsg_All    :='(all)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Sz�veg';

  TeeMsg_AsBMP        :='&Bitmapk�nt';
  TeeMsg_BMPFilter    :='Bitmap-ek (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='&Metafile-k�nt';
  TeeMsg_EMFFilter    :='Fejlesztett Metafile-ok (*.emf)|*.emf|Metafile-ok (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'A Panel jellemz� nincs be�ll�tva az Export form�tumban';

  TeeMsg_Normal    :='Szab�lyos';
  TeeMsg_NoBorder  :='Nincs hat�r';
  TeeMsg_Dotted    :='Pontozott';
  TeeMsg_Colors    :='Sz�nek';
  TeeMsg_Filled    :='Kit�ltve';
  TeeMsg_Marks     :='Jel�l�sek';
  TeeMsg_Stairs    :='Csillagok';
  TeeMsg_Points    :='Pontok';
  TeeMsg_Height    :='Magass�g';
  TeeMsg_Hollow    :='�reges';
  TeeMsg_Point2D   :='2D-s pont';
  TeeMsg_Triangle  :='H�romsz�g';
  TeeMsg_Star      :='Csillag';
  TeeMsg_Circle    :='K�r';
  TeeMsg_DownTri   :='H�romsz�g lefel�';
  TeeMsg_Cross     :='Kereszt';
  TeeMsg_Diamond   :='Gy�m�nt';
  TeeMsg_NoLines   :='Nincs vonal';
  TeeMsg_Stack100  :='100%-os halom';
  TeeMsg_Pyramid   :='Piramis';
  TeeMsg_Ellipse   :='Ellipszis';
  TeeMsg_InvPyramid:='Inverz Piramis';
  TeeMsg_Sides     :='Oldalak';
  TeeMsg_SideAll   :='Minden oldal';
  TeeMsg_Patterns  :='Mint�z�s';
  TeeMsg_Exploded  :='Robbantott';
  TeeMsg_Shadow    :='�rny�k';
  TeeMsg_SemiPie   :='F�l k�rdiagram';
  TeeMsg_Rectangle :='T�glalap';
  TeeMsg_VertLine  :='F�gg. vonal';
  TeeMsg_HorizLine :='V�zsz. vonal';
  TeeMsg_Line      :='Vonal';
  TeeMsg_Cube      :='Kocka';
  TeeMsg_DiagCross :='�tl�s kereszt';

  TeeMsg_CanNotFindTempPath    :='Nem tal�lhat� Temp mappa';
  TeeMsg_CanNotCreateTempChart :='Nem hozhat� l�tre Temp f�jl';
  TeeMsg_CanNotEmailChart      :='Nem k�ldhet� email a TeeChart-hoz. Mapi Error: %d';

  TeeMsg_SeriesDelete :='Sor t�rl�s: %d �rt�kindexe tiltott ter�leten (0-t�l %d-ig).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='&JPEG-k�nt';
  TeeMsg_JPEGFilter    :='JPEG f�jlok (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='&GIF-k�nt';
  TeeMsg_GIFFilter     :='GIF f�jlok (*.gif)|*.gif';
  TeeMsg_AsPNG         :='&PNG-k�nt';
  TeeMsg_PNGFilter     :='PNG f�jlok (*.png)|*.png';
  TeeMsg_AsPCX         :='PC&X-k�nt';
  TeeMsg_PCXFilter     :='PCX f�jlok (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Nyelvek...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Pol�ris';
  TeeMsg_GalleryCandle      :='Gyertya';
  TeeMsg_GalleryVolume      :='Er�ss�g';
  TeeMsg_GallerySurface     :='Fel�let';
  TeeMsg_GalleryContour     :='Kont�r';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='3D-s pont';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Kurzor';
  TeeMsg_GalleryBar3D       :='3D-s s�v';
  TeeMsg_GalleryBigCandle   :='Nagy gyertya';
  TeeMsg_GalleryLinePoint   :='Vonal pont';
  TeeMsg_GalleryHistogram   :='Hisztogram';
  TeeMsg_GalleryWaterFall   :='V�zszintes';
  TeeMsg_GalleryWindRose    :='Sz�lr�zsa';
  TeeMsg_GalleryClock       :='�ra';
  TeeMsg_GalleryColorGrid   :='Sz�nr�cs';
  TeeMsg_GalleryBoxPlot     :='Cellafeloszt�s ';
  TeeMsg_GalleryHorizBoxPlot:='V�zsz. cellafeloszt�s';
  TeeMsg_GalleryBarJoin     :='S�v illeszt�si hely';
  TeeMsg_GallerySmith       :='Kov�cs';
  TeeMsg_GalleryPyramid     :='Piramis';
  TeeMsg_GalleryMap         :='T�rk�p';

  TeeMsg_PolyDegreeRange    :='Polinom foknak 1 �s 20 k�z�tt kell lennie';
  TeeMsg_AnswerVectorIndex   :='A v�lasz vektor index�nek 1 �s %d k�z�tt kell lennie';
  TeeMsg_FittingError        :='Nem lehet megfelel�en feldolgozni';
  TeeMsg_PeriodRange         :='A szakasz legyen >= 0';
  TeeMsg_ExpAverageWeight    :='Az ExpAverage s�lya legyen 0 �s 1 k�z�tt';
  TeeMsg_GalleryErrorBar     :='S�vhiba';
  TeeMsg_GalleryError        :='Hiba';
  TeeMsg_GalleryHighLow      :='Magas-alacsony';
  TeeMsg_FunctionMomentum    :='Lend�let';
  TeeMsg_FunctionMomentumDiv :='Lend�let Elt�r�s';
  TeeMsg_FunctionExpAverage  :='Exponenci�lis �tlag';
  TeeMsg_FunctionMovingAverage:='Mozg�si �tlag';
  TeeMsg_FunctionExpMovAve   :='Exp.Mozg.�tlag';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='G�rbe illeszt�s';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Halmozott';
  TeeMsg_FunctionStdDeviation:='Szabv�nyos elhajl�s';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='N�gyzetes k�z�p�rt�k';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='V�letlenszer�';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Mennyis�g';
  TeeMsg_LoadChart           :='TeeChart megnyit�s...';
  TeeMsg_SaveChart           :='TeeChart ment�s...';
  TeeMsg_TeeFiles            :='TeeChart Pro f�jlok';

  TeeMsg_GallerySamples      :='Egy�b ';
  TeeMsg_GalleryStats        :='Statisztik�k';

  TeeMsg_CannotFindEditor    :='Nem tal�lhat� a sorozat szerkeszt� �rlap: %s';


  TeeMsg_CannotLoadChartFromURL:='Hibak�d: %d grafikon let�lt�se a %s URL-r�l';
  TeeMsg_CannotLoadSeriesDataFromURL:='Hibak�d: %d soradatok let�lt�se a %s URL-r�l';

  TeeMsg_Test                :='Teszt...';

  TeeMsg_ValuesDate          :='D�tum';
  TeeMsg_ValuesOpen          :='Megnyit�s';
  TeeMsg_ValuesHigh          :='Magas';
  TeeMsg_ValuesLow           :='Alacsony';
  TeeMsg_ValuesClose         :='Bez�r�s';
  TeeMsg_ValuesOffset        :='Eltol�s';
  TeeMsg_ValuesStdError      :='Szabv�ny hiba';

  TeeMsg_Grid3D              :='3D-s r�cs';

  TeeMsg_LowBezierPoints     :='A Bezier-pontok sz�ma legyen > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Szab�lyos';
  TeeCommanMsg_Edit     :='Szerkeszt�s';
  TeeCommanMsg_Print    :='Nyomtat�s';
  TeeCommanMsg_Copy     :='M�sol�sCopy';
  TeeCommanMsg_Save     :='Ment�s';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Elforgat�s: %d� Emelked�s: %d�';
  TeeCommanMsg_Rotate   :='Elforgat�s';

  TeeCommanMsg_Moving   :='V�zszintes eltol�s: %d F�gg�leges eltol�s: %d';
  TeeCommanMsg_Move     :='Mozgat�s';

  TeeCommanMsg_Zooming  :='K�zel�t�s: %d %%';
  TeeCommanMsg_Zoom     :='K�zel�t�s';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='M�lys�g';

  TeeCommanMsg_Chart    :='Grafikon';
  TeeCommanMsg_Panel    :='T�bla';

  TeeCommanMsg_RotateLabel:='Elforgat�s %s-al';
  TeeCommanMsg_MoveLabel  :='Mozgat�s %s-al';
  TeeCommanMsg_ZoomLabel  :='K�zel�t�s %s-al';
  TeeCommanMsg_DepthLabel :='3D-s �jram�retez�s %s-al';

  TeeCommanMsg_NormalLabel:='K�zel�t�shez a bal gombbal, g�rget�s a jobb gombbal';
  TeeCommanMsg_NormalPieLabel:='K�rszeletek h�z�sa robbant�shoz';

  TeeCommanMsg_PieExploding :='K�rszelet: %d Robbant�s: %d %%';

  TeeMsg_TriSurfaceLess        :='A pontok sz�ma legyen >= 4';
  TeeMsg_TriSurfaceAllColinear :='Minen koline�ris adatpont';
  TeeMsg_TriSurfaceSimilar     :='Hasonl� pontok - Nem v�grehajthat�';
  TeeMsg_GalleryTriSurface     :='H�romsz�g felsz�n';

  TeeMsg_AllSeries :='Minden sor';
  TeeMsg_Edit      :='Szerkeszt�s';

  TeeMsg_GalleryFinancial    :='P�nz�gy';

  TeeMsg_CursorTool    :='Kurzor';
  TeeMsg_DragMarksTool :='Jel�l�sek h�z�sa';
  TeeMsg_AxisArrowTool :='Tengely ny�l';
  TeeMsg_DrawLineTool  :='Vonal rajzol�s';
  TeeMsg_NearestTool   :='Legk�zelebbi pont';
  TeeMsg_ColorBandTool :='Oszlopsz�n';
  TeeMsg_ColorLineTool :='Vonalsz�n';
  TeeMsg_RotateTool    :='Elforgat�s';
  TeeMsg_ImageTool     :='K�p';
  TeeMsg_MarksTipTool  :='Jel�l�si tippek';

  TeeMsg_CantDeleteAncestor  :='Az el�d nem t�r�lhet�';

  TeeMsg_Load	          :='Bet�lt�s...';
  TeeMsg_NoSeriesSelected :='Nincs sor kiv�lasztva';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Grafikon';
  TeeMsg_CategorySeriesActions :='Grafikon sorok';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := 'V�lt�s 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&Akt�v';
  TeeMsg_ActionSeriesActiveHint := 'Sorokat mutat / elrejt';
  TeeMsg_ActionEditHint         := 'Grafikon szerkeszt�s';
  TeeMsg_ActionEdit             := '&Szerkeszt�s...';
  TeeMsg_ActionCopyHint         := 'M�sol�s v�g�lapra';
  TeeMsg_ActionCopy             := '&M�sol�s';
  TeeMsg_ActionPrintHint        := 'Grafikon nyomtat�si k�p';
  TeeMsg_ActionPrint            := '&Nyomtat�s...';
  TeeMsg_ActionAxesHint         := 'Tengelyeket mutat / elrejt';
  TeeMsg_ActionAxes             := '&Tengelyek';
  TeeMsg_ActionGridsHint        := 'R�csot mutat / elrejt';
  TeeMsg_ActionGrids            := '&R�csvonalak';
  TeeMsg_ActionLegendHint       := 'Jelmagyarz�atot mutat / elrejt';
  TeeMsg_ActionLegend           := '&Jelmagyar�zat';
  TeeMsg_ActionSeriesEditHint   := 'Sorok szerkeszt�se';
  TeeMsg_ActionSeriesMarksHint  := 'Sor-jel�l�st mutat / elrejt';
  TeeMsg_ActionSeriesMarks      := '&Jel�l�sek';
  TeeMsg_ActionSaveHint         := 'Grafikon ment�s';
  TeeMsg_ActionSave             := '&Ment�s...';

  TeeMsg_CandleBar              := 'S�v';
  TeeMsg_CandleNoOpen           := 'Nincs megnyit�s';
  TeeMsg_CandleNoClose          := 'Nincs bez�r�s';
  TeeMsg_NoLines                := 'Nincsenek vonalak';
  TeeMsg_NoHigh                 := 'Nincs magass�g';
  TeeMsg_NoLow                  := 'Nincs m�lys�g';
  TeeMsg_ColorRange             := 'Sz�nsk�la';
  TeeMsg_WireFrame              := 'F�mkeret';
  TeeMsg_DotFrame               := 'Pontozott keret';
  TeeMsg_Positions              := 'Elhelyez�s';
  TeeMsg_NoGrid                 := 'Nincs r�csvonal';
  TeeMsg_NoPoint                := 'Nincs pont';
  TeeMsg_NoLine                 := 'Nincs vonal';
  TeeMsg_Labels                 := 'Feliratok';
  TeeMsg_NoCircle               := 'Nincs k�r';
  TeeMsg_Lines                  := 'Vonalak';
  TeeMsg_Border                 := 'Szeg�ly';

  TeeMsg_SmithResistance      := 'Ellen�ll�s';
  TeeMsg_SmithReactance       := 'Reakt�v ellen�ll�s';

  TeeMsg_Column               := 'Oszlop';

  { 5.01 }
  TeeMsg_Separator            := 'Elv�laszt�jel';
  TeeMsg_FunnelSegment        := 'Szegmens ';
  TeeMsg_FunnelSeries         := 'T�lcs�r';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Kv�t�n k�v�l';
  TeeMsg_FunnelWithin         := ' kv�t�n bel�l';
  TeeMsg_FunnelBelow          := ' vagy ink�bb kv�t�n bel�l';
  TeeMsg_CalendarSeries       := 'Napt�r';
  TeeMsg_DeltaPointSeries     := 'Delta Pont';
  TeeMsg_ImagePointSeries     := 'K�ppont';
  TeeMsg_ImageBarSeries       := 'S�v k�pe';
  TeeMsg_SeriesTextFieldZero  := 'Sor sz�vege: A mez�index legyen nagyobb, mint 0.';

  { 5.02 }
  TeeMsg_Origin               := 'Orig�';
  TeeMsg_Transparency         := '�tl�tsz�s�g';
  TeeMsg_Box		      := 'Doboz';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'Oldalsz�m';

  { 5.03 }
  TeeMsg_Gradient             :='Gradient';
  TeeMsg_WantToSave           :='Save %s?';

  TeeMsg_Property            :='Property';
  TeeMsg_Value               :='Value';
  TeeMsg_Yes                 :='Yes';
  TeeMsg_No                  :='No';
  TeeMsg_Image              :='(image)';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

//6.0

// TeeConst

  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='&PDF f�jlk�nt';
  TeeMsg_PDFFilter        :='PDF f�jlok (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='PostScript f�jlk�nt';
  TeeMsg_PSFilter         :='PostScript f�jlok (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='V�zszintes'#13'ter�let';
  TeeMsg_SelfStack        :='Pakolt';
  TeeMsg_DarkPen          :='S�t�t szeg�ly';
  TeeMsg_SelectFolder     :='Adatb�zis k�nyvt�r';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Kapcsolat:';

// TeeProCo

  TeeMsg_FunctionSmooth       :='Sim�t�s';
  TeeMsg_FunctionCross        :='metsz�spontok';
  TeeMsg_GridTranspose        :='3D r�cs transzpon�l�s';
  TeeMsg_FunctionCompress     :='T�m�r�t�s';
  TeeMsg_ExtraLegendTool      :='Extra jelmagyar�zat';
  TeeMsg_FunctionCLV          :='Szoros helyi'#13'�rt�k';
  TeeMsg_FunctionOBV          :='kiegyenl�tett'#13'mennyis�g';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Mennyis�g'#13'oszcill�tor';
  TeeMsg_SeriesAnimTool       :='Sz�ria anim�l�s';
  TeeMsg_GalleryPointFigure   :='Pont �s alakzat';
  TeeMsg_Up                   :='Fel';
  TeeMsg_Down                 :='Le';
  TeeMsg_GanttTool            :='Gantt eszk�z';
  TeeMsg_XMLFile              :='XML f�jl';
  TeeMsg_GridBandTool         :='R�cs s�v eszk�z';
  TeeMsg_FunctionPerf         :='Hat�konys�g';
  TeeMsg_GalleryGauge         :='M�r�eszk�z';
  TeeMsg_GalleryGauges        :='M�r�eszk�z�k';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='3D Vektor';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Torony';
  TeeMsg_SingleColor          :='Egysz�n�';
  TeeMsg_Cover                :='Bor�t�s';
  TeeMsg_Cone                 :='K�p';
  TeeMsg_PieTool              :='Tortaszelet';
end;

Procedure TeeCreateHungarian;
begin
  if not Assigned(TeeHungarianLanguage) then
  begin
    TeeHungarianLanguage:=TStringList.Create;
    TeeHungarianLanguage.Text:=

'GRADIENT EDITOR=Sz�n�tmenet Szerkeszt�'#13+
'GRADIENT=Sz�n�tmenet'#13+
'DIRECTION=Ir�ny'#13+
'VISIBLE=L�that�'#13+
'TOP BOTTOM=Fentr�l Le'#13+
'BOTTOM TOP=Lentr�l Fel'#13+
'LEFT RIGHT=Balr�l Jobbra'#13+
'RIGHT LEFT=Jobbr�l Balra'#13+
'FROM CENTER=K�z�pr�l'#13+
'FROM TOP LEFT=Bal fels� sarokb�l'#13+
'FROM BOTTOM LEFT=Bal als� sarokb�l'#13+
'OK=Rendben'#13+
'CANCEL=M�gsem'#13+
'COLORS=Sz�nek'#13+
'START=Kezd�sz�n'#13+
'MIDDLE=K�z�psz�n'#13+
'END=Befej. sz�n'#13+
'SWAP=Felcser�l'#13+
'NO MIDDLE=Nincs k�z�psz�n'#13+
'TEEFONT EDITOR=TEECHART bet�szerkeszt�'#13+
'INTER-CHAR SPACING=Bet�t�vols�g'#13+
'FONT=Bet�t�pus'#13+
'SHADOW=�rny�k'#13+
'HORIZ. SIZE=V�zsz. m�ret'#13+
'VERT. SIZE=F�gg. m�ret'#13+
'COLOR=Sz�n'#13+
'OUTLINE=K�rvonal'#13+
'OPTIONS=Be�ll�t�sok'#13+
'FORMAT=Form�tum'#13+
'TEXT=Sz�veg'#13+
'POSITION=Elhelyez�s'#13+
'LEFT=Baloldalt'#13+
'TOP=Fel�l'#13+
'AUTO=Automata'#13+
'CUSTOM=Egyedi'#13+
'LEFT TOP=Balra fent'#13+
'LEFT BOTTOM=Balra lent'#13+
'RIGHT TOP=Jobbra fent'#13+
'RIGHT BOTTOM=Jobbra lent'#13+
'MULTIPLE AREAS=T�bbsz�r�s felsz�n'#13+
'NONE=�res'#13+
'STACKED=Halom'#13+
'STACKED 100%=100%-os halom'#13+
'AREA=Ter�let'#13+
'PATTERN=Mint�zat'#13+
'STAIRS=L�pcs�k'#13+
'SOLID=Egysz�n�'#13+
'CLEAR=�res'#13+
'HORIZONTAL=V�zszintes'#13+
'VERTICAL=F�gg�leges'#13+
'DIAGONAL=�tl�'#13+
'B.DIAGONAL=Ford�tott �tl�'#13+
'CROSS=Kereszt'#13+
'DIAG.CROSS=�tl�s kereszt'#13+
'AREA LINES=Felsz�n-von.'#13+
'BORDER=Szeg�ly'#13+
'INVERTED=Inverz'#13+
'COLOR EACH=Minden sz�n'#13+
'ORIGIN=Forr�s'#13+
'USE ORIGIN=Forr�s haszn�lva'#13+
'WIDTH=Sz�less�g'#13+
'HEIGHT=Magass�g'#13+
'AXIS=Tengely'#13+
'LENGTH=Hossz�s�g'#13+
'SCROLL=G�rget�s'#13+
'BOTH=Mindkett�'#13+
'AXIS INCREMENT=Oszt�sjelek'#13+
'INCREMENT=L�p�s-egys�g'#13+
'STANDARD=�tlag'#13+
'ONE MILLISECOND=Egy Milim�sodperc'#13+
'ONE SECOND=Egy m�sodperc'#13+
'FIVE SECONDS=�t m�sodperc'#13+
'TEN SECONDS=T�z m�sodperc'#13+
'FIFTEEN SECONDS=Tizen�t m�sodperc'#13+
'THIRTY SECONDS=Harminc m�sodperc'#13+
'ONE MINUTE=Egy perc'#13+
'FIVE MINUTES=�t perc'#13+
'TEN MINUTES=T�z perc'#13+
'FIFTEEN MINUTES=Tizen�t perc'#13+
'THIRTY MINUTES=Harminc perc'#13+
'ONE HOUR=Egy �ra'#13+
'TWO HOURS=K�t �ra'#13+
'SIX HOURS=Hat �ra'#13+
'TWELVE HOURS=Tizenk�t �ra'#13+
'ONE DAY=Egy nap'#13+
'TWO DAYS=K�t nap'#13+
'THREE DAYS=H�rom nap'#13+
'ONE WEEK=Egy h�t'#13+
'HALF MONTH=F�l h�nap'#13+
'ONE MONTH=Egy h�nap'#13+
'TWO MONTHS=K�t h�nap'#13+
'THREE MONTHS=H�rom h�nap'#13+
'FOUR MONTHS=N�gy h�nap'#13+
'SIX MONTHS=Hat h�nap'#13+
'ONE YEAR=Egy �v'#13+
'EXACT DATE TIME=Pontos d�tum'#13+
'AXIS MAXIMUM AND MINIMUM=Tengely maximum �s minimum'#13+
'VALUE=�rt�k'#13+
'TIME=Id�'#13+
'LEFT AXIS=Bal tengely'#13+
'RIGHT AXIS=Jobb tengely'#13+
'TOP AXIS=Fels� tengely'#13+
'BOTTOM AXIS=Als� tengely'#13+
'% BAR WIDTH=% S�vsz�less�g'#13+
'STYLE=St�lus'#13+
'% BAR OFFSET=S�v eltol�s %-a'#13+
'RECTANGLE=T�glalap'#13+
'PYRAMID=Piramis'#13+
'INVERT. PYRAMID=Inverz piramis'#13+
'CYLINDER=Henger'#13+
'ELLIPSE=Ellipszis'#13+
'ARROW=Ny�l'#13+
'RECT. GRADIENT=N�gysz�g� sz�n�tmenet'#13+
'CONE=K�p'#13+
'DARK BAR 3D SIDES=S�t�t  3D s�v'#13+
'BAR SIDE MARGINS=S�vsz�less�g'#13+
'AUTO MARK POSITION=Automatikusan jel�lt poz�ci�'#13+
'JOIN=Illeszt�s'#13+
'DATASET=Adat�llom�ny'#13+
'APPLY=Alkalmaz'#13+
'SOURCE=Forr�s'#13+
'MONOCHROME=Egysz�n�'#13+
'DEFAULT=Alap�rtelmezett'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=K�z�p�rt�k'#13+
'WHISKER=Hajl�t�s'#13+
'PATTERN COLOR EDITOR=Sz�npaletta szerkeszt�s'#13+
'IMAGE=K�p'#13+
'BACK DIAGONAL=Ford�tott �tl�'#13+
'DIAGONAL CROSS=�tl�s kereszt'#13+
'FILL 80%=80% kit�ltve'#13+
'FILL 60%=60% kit�ltve'#13+
'FILL 40%=40% kit�ltve'#13+
'FILL 20%=20% kit�ltve'#13+
'FILL 10%=10% kit�ltve'#13+
'ZIG ZAG=Cikk-cakkos'#13+
'VERTICAL SMALL=F�gg�leges, kicsi'#13+
'HORIZ. SMALL=V�zszintes, kicsi'#13+
'DIAG. SMALL=�tl�s, kicsi'#13+
'BACK DIAG. SMALL=H�ts� �tl�, kicsi'#13+
'CROSS SMALL=Kereszt, kicsi'#13+
'DIAG. CROSS SMALL=�tl�s kereszt, kicsi'#13+
'DAYS=Napok'#13+
'WEEKDAYS=H�t napjai'#13+
'TODAY=Ma'#13+
'SUNDAY=Vas�rnap'#13+
'TRAILING=�tny�l�s'#13+
'MONTHS=H�napok'#13+
'LINES=Vonalak'#13+
'SHOW WEEKDAYS=H�t napjai'#13+
'UPPERCASE=Nagybet�s'#13+
'TRAILING DAYS=�tny�l� napok'#13+
'SHOW TODAY=Mai nap'#13+
'SHOW MONTHS=H�nap'#13+
'CANDLE WIDTH=Gyertya-sz�less�g'#13+
'STICK=P�lca'#13+
'BAR=S�v'#13+
'OPEN CLOSE=Nyit z�r'#13+
'UP CLOSE=Emelkedve z�r'#13+
'DOWN CLOSE=S�llyedve z�r'#13+
'SHOW OPEN=Nyit�st mutat'#13+
'SHOW CLOSE=Z�r�st mutat'#13+
'DRAW 3D=3D'#13+
'DARK 3D=3D S�t�t'#13+
'EDITING=Szerkeszt�s'#13+
'CHART=Grafikon'#13+
'SERIES=Sorok'#13+
'DATA=Adatok'#13+
'TOOLS=Eszk�z�k'#13+
'EXPORT=Export'#13+
'PRINT=Nyomtat�s'#13+
'GENERAL=�ltal�nos'#13+
'TITLES=C�mek'#13+
'LEGEND=Jelmagyar.'#13+
'PANEL=Panel'#13+
'PAGING=Oldalak'#13+
'WALLS=Falak'#13+
'3D=3D'#13+
'ADD=Hozz�ad'#13+
'DELETE=T�rl�s'#13+
'TITLE=C�m'#13+
'CLONE=Kl�noz�s'#13+
'CHANGE=M�dos�t�s'#13+
'HELP=Seg�ts�g'#13+
'CLOSE=Bez�r'#13+
'TEECHART PRINT PREVIEW=TeeChart Nyomtat�si k�p'#13+
'PRINTER=Nyomtat�'#13+
'SETUP=Telep�t�s'#13+
'ORIENTATION=Igaz�t�s'#13+
'PORTRAIT=�ll�k�p'#13+
'LANDSCAPE=Fekv�k�p'#13+
'MARGINS (%)=Marg�k (%)'#13+
'DETAIL=R�szletek'#13+
'MORE=Egyebek'#13+
'NORMAL=Szok�sos'#13+
'RESET MARGINS=Marg�k vissza�l.'#13+
'VIEW MARGINS=Marg�k megtek.'#13+
'PROPORTIONAL=Ar�nyok'#13+
'CIRCLE=K�r'#13+
'VERTICAL LINE=F�gg�leges vonal'#13+
'HORIZ. LINE=V�zszintes vonal'#13+
'TRIANGLE=H�romsz�g'#13+
'INVERT. TRIANGLE=Inverz h�romsz�g'#13+
'LINE=Vonal'#13+
'DIAMOND=Rombusz'#13+
'CUBE=Kocka'#13+
'STAR=Csillag'#13+
'TRANSPARENT=�tl�tsz�'#13+
'HORIZ. ALIGNMENT=V�zszintes igaz�t�s'#13+
'CENTER=K�z�p'#13+
'RIGHT=Jobb'#13+
'ROUND RECTANGLE=Kerek�tett n�gysz�g'#13+
'ALIGNMENT=Igaz�t�s'#13+
'BOTTOM=Lent'#13+
'UNITS=Elemek'#13+
'PIXELS=K�ppontok'#13+
'AXIS ORIGIN=Orig�'#13+
'ROTATION=Elforgat�s'#13+
'CIRCLED=K�rvonal'#13+
'3 DIMENSIONS=3 dimenzi�s'#13+
'RADIUS=Sug�r'#13+
'ANGLE INCREMENT=Sz�g nagy�t�s'#13+
'RADIUS INCREMENT=Sug�r nagy�t�s'#13+
'CLOSE CIRCLE=Z�rt k�r'#13+
'PEN=Toll'#13+
'LABELS=Feliratok'#13+
'ROTATED=Elforgatott'#13+
'CLOCKWISE=�raj�r�s ir�ny�ban'#13+
'INSIDE=Bel�l'#13+
'ROMAN=Roman'#13+
'HOURS=�r�k'#13+
'MINUTES=Percek'#13+
'SECONDS=M�sodpercek'#13+
'START VALUE:=Kezd��rt�k:'#13+
'END VALUE=Befejez� �rt�k'#13+
'TRANSPARENCY=�tl�tsz�s�g'#13+
'DRAW BEHIND=M�g� rajzol'#13+
'COLOR MODE=Szinez�si m�d'#13+
'STEPS=L�p�sek'#13+
'RANGE=Ter�let'#13+
'PALETTE=Paletta'#13+
'PALE=Halv�ny'#13+
'STRONG=Er�s'#13+
'GRID SIZE=R�cs m�rete'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=M�lys�g'#13+
'IRREGULAR=Szab�lytalan'#13+
'GRID=R�cs'#13+
'VALUE:=�rt�k:'#13+
'ALLOW DRAG=Vonszol�s enged�lyezve'#13+
'VERTICAL POSITION=F�gg�leges helyzet'#13+
'LEVELS POSITION=Szintek helyzete'#13+
'LEVELS=Szintek'#13+
'NUMBER=Mennyis�g'#13+
'LEVEL=Szint'#13+
'AUTOMATIC=Autom.'#13+
'SNAP=Lekap'#13+
'FOLLOW MOUSE=Eg�r k�vet�se'#13+
'STACK=Halom'#13+
'HEIGHT 3D=3D magass�g'#13+
'LINE MODE=Vonal m�d'#13+
'OVERLAP=�tfed�s'#13+
'STACK 100%=100%-os halom'#13+
'CLICKABLE=Kattinthat�'#13+
'AVAILABLE=Rendelkez�sre �ll�'#13+
'SELECTED:=Kiv�lasztva:'#13+
'DATASOURCE=Adatforr�s'#13+
'GROUP BY=Csoportos�t�s'#13+
'CALC=Sz�m�t�s'#13+
'OF=K�z�l'#13+
'SUM=�sszeg'#13+
'COUNT=Sz�mol'#13+
'HIGH=Magasg'#13+
'LOW=Alacsony'#13+
'AVG=�tlag'#13+
'HOUR=�ra'#13+
'DAY=Nap'#13+
'WEEK=H�t'#13+
'WEEKDAY=H�t napja'#13+
'MONTH=H�nap'#13+
'QUARTER=N�gyzet'#13+
'YEAR=�v'#13+
'HOLE %:=Lyuk %:'#13+
'RESET POSITIONS=Helyzet vissza�ll�t�sa'#13+
'MOUSE BUTTON=Eg�rgomb'#13+
'ENABLE DRAWING=Rajzol�s enged�lyezve'#13+
'ENABLE SELECT=Kiv�laszt�s enged�lyezve'#13+
'ENHANCED=N�vel�s'#13+
'ERROR WIDTH=Hib�s sz�less�g'#13+
'WIDTH UNITS=Sz�less�g egys�g'#13+
'PERCENT=Sz�zal�k'#13+
'LEFT AND RIGHT=Bal �s jobb'#13+
'TOP AND BOTTOM=Fent �s lent'#13+
'BORDER EDITOR=Szeg�ly szerkeszt�'#13+
'DASH=K�t�jelek'#13+
'DOT=Pontok'#13+
'DASH DOT=K�t�jel-pont'#13+
'DASH DOT DOT=K�t�jel-k�t pont'#13+
'CALCULATE EVERY=Mindent sz�mol'#13+
'ALL POINTS=Minden pont'#13+
'NUMBER OF POINTS=Pontok sz�ma'#13+
'RANGE OF VALUES=�rt�khat�r'#13+
'FIRST=Els�'#13+
'LAST=Utols�'#13+
'TEEPREVIEW EDITOR=TeeL�tv�ny szerkeszt�'#13+
'ALLOW MOVE=Mozgat�s enged�lyezve'#13+
'ALLOW RESIZE=�tm�retez�s enged�lyezve'#13+
'DRAG IMAGE=�bra vonszol�s'#13+
'AS BITMAP=Bitmap-k�nt'#13+
'SHOW IMAGE=�br�t mutat'#13+
'MARGINS=Marg�k'#13+
'SIZE=M�ret'#13+
'3D %=3D %'#13+
'ZOOM=Zoom'#13+
'ELEVATION=Emelked�s'#13+
'100%=100%'#13+
'HORIZ. OFFSET=V�zszintes eltol�s'#13+
'VERT. OFFSET=F�gg�leges eltol�s'#13+
'PERSPECTIVE=T�vlati k�p'#13+
'ANGLE=Sz�g'#13+
'ORTHOGONAL=Der�ksz�g�'#13+
'ZOOM TEXT=Sz�veg-k�zel�t�s'#13+
'SCALES=Sk�l�z�s'#13+
'TICKS=Jel�l�s'#13+
'MINOR=Kisebb'#13+
'MAXIMUM=Maximum'#13+
'MINIMUM=Minimum'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=L�p�sk�z'#13+
'(INCREMENT)=(n�veked�s)'#13+
'LOG BASE=Logaritmus alapja'#13+
'LOGARITHMIC=Logaritmikus'#13+
'MIN. SEPARATION %=Min. elv�laszt�s %'#13+
'MULTI-LINE=T�bb sor'#13+
'LABEL ON AXIS=Tengely-felirat'#13+
'ROUND FIRST=Els� k�r'#13+
'MARK=Jel�l�s'#13+
'LABELS FORMAT=Felirat form�tum'#13+
'EXPONENTIAL=Exponenci�lis'#13+
'DEFAULT ALIGNMENT=Alap�rtelmezett igaz�t�s'#13+
'LEN=Hossz'#13+
'INNER=Bels�'#13+
'AT LABELS ONLY=Csak Feliraton'#13+
'CENTERED=K�z�pen'#13+
'POSITION %=Poz�ci� %'#13+
'START %=Kezd� %'#13+
'END %=Befejez� %'#13+
'OTHER SIDE=M�sik oldal'#13+
'AXES=Tengelyek'#13+
'BEHIND=H�tul'#13+
'CLIP POINTS=Illeszt�pontok'#13+
'PRINT PREVIEW=Nyomtat�si k�p'#13+
'MINIMUM PIXELS=K�ppontok minimum'#13+
'ALLOW=Enged�ly'#13+
'ANIMATED=Anim�lt'#13+
'ALLOW SCROLL=G�rget�s'#13+
'TEEOPENGL EDITOR=TeeOpenGL Szerkeszt�'#13+
'AMBIENT LIGHT=K�rnyezet'#13+
'SHININESS=F�nyess�g'#13+
'FONT 3D DEPTH=3D Bet�m�lys�g'#13+
'ACTIVE=Akt�v'#13+
'FONT OUTLINES=Bet� k�rvonal'#13+
'SMOOTH SHADING=Egyenletes �rny�kol�s'#13+
'LIGHT=F�nyer�'#13+
'Y=Y'#13+
'INTENSITY=Intenzit�s'#13+
'BEVEL=S�llyesztett keret'#13+
'FRAME=Keret'#13+
'ROUND FRAME=Kerek�tett keret'#13+
'LOWERED=H�tra'#13+
'RAISED=El�re'#13+
'SYMBOLS=Szimb�lum'#13+
'TEXT STYLE=Sz�vegst�lus'#13+
'LEGEND STYLE=Jelmagyar�zat st�lus'#13+
'VERT. SPACING=F�gg. t�rk�z'#13+
'SERIES NAMES=Sor-nevek'#13+
'SERIES VALUES=Sor-�rt�kek'#13+
'LAST VALUES=Utols� �rt�k'#13+
'PLAIN=Sima'#13+
'LEFT VALUE=Bal, �rt�k'#13+
'RIGHT VALUE=Jobb, �rt�k'#13+
'LEFT PERCENT=Bal, sz�zal�k'#13+
'RIGHT PERCENT=Jobb, sz�zal�k'#13+
'X VALUE=X �rt�k'#13+
'X AND VALUE=X �s �rt�k'#13+
'X AND PERCENT=X �s sz�zal�k'#13+
'CHECK BOXES=Ellen�rz� gomb'#13+
'DIVIDING LINES=V�laszt�vonalak'#13+
'FONT SERIES COLOR=Bet�sor sz�ne'#13+
'POSITION OFFSET %=Helyzet eltol�s %-a'#13+
'MARGIN=Szeg�ly'#13+
'RESIZE CHART=Grafikont �jram�retez'#13+
'CONTINUOUS=Folyamatos'#13+
'POINTS PER PAGE=Pontok oldalank�nt'#13+
'SCALE LAST PAGE=Utols� oldalt feloszt'#13+
'CURRENT PAGE LEGEND=Aktu�lis jelmagyar�zat'#13+
'PANEL EDITOR=H�tt�r szerkeszt�'#13+
'BACKGROUND=H�tt�r'#13+
'BORDERS=Keretek'#13+
'BACK IMAGE=H�tt�rk�p'#13+
'STRETCH=Ny�jt�s'#13+
'TILE=Kit�lt�s'#13+
'BEVEL INNER=Bels� s�llyesz.'#13+
'BEVEL OUTER=K�ls� s�llyesz.'#13+
'MARKS=Jel�l�sek'#13+
'DATA SOURCE=Adatforr�s'#13+
'SORT=V�logat�s'#13+
'CURSOR=Kurzor'#13+
'SHOW IN LEGEND=L�that� a jelmagyar.'#13+
'FORMATS=Form�tumok'#13+
'VALUES=�rt�k'#13+
'PERCENTS=Sz�zal�kok'#13+
'HORIZONTAL AXIS=V�zszintes tengely'#13+
'DATETIME=D�tum-Id�'#13+
'VERTICAL AXIS=F�gg�leges tengely'#13+
'ASCENDING=Emelked�'#13+
'DESCENDING=Cs�kken�'#13+
'DRAW EVERY=H�z mindent'#13+
'CLIPPED=Lev�g'#13+
'ARROWS=Nyilak'#13+
'MULTI LINE=T�bbsz�r�s sor'#13+
'ALL SERIES VISIBLE=Minden sor l�that�'#13+
'LABEL=Felirat'#13+
'LABEL AND PERCENT=Felirat �s sz�zal�k'#13+
'LABEL AND VALUE=Felirat �s �rt�k'#13+
'PERCENT TOTAL=Sz�zal�k �sszesen'#13+
'LABEL AND PERCENT TOTAL=Felirat �s sz�zal�k�rt�k'#13+
'X AND Y VALUES=X �s Y �rt�k'#13+
'MANUAL=Manu�lis'#13+
'RANDOM=V�letlenszer�'#13+
'FUNCTION=F�ggv�ny'#13+
'NEW=�j'#13+
'EDIT=Szerkeszt�s'#13+
'PERSISTENT=Folytonos'#13+
'ADJUST FRAME=Keretek igaz�t�sa'#13+
'SUBTITLE=Alc�m'#13+
'SUBFOOT=L�bjegyzet 2'#13+
'FOOT=2. L�bjegyzet'#13+
'VISIBLE WALLS=Falak l�that�k'#13+
'BACK=H�tra'#13+
'DIF. LIMIT=K�l�nbs�g hat�ra'#13+
'ABOVE=Fent'#13+
'WITHIN=Bel�l'#13+
'BELOW=Alul'#13+
'CONNECTING LINES=Kapcsol�d� vonalak'#13+
'BROWSE=B�ng�sz�s'#13+
'TILED=Kit�ltve'#13+
'INFLATE MARGINS=N�velt szeg�lyek'#13+
'SQUARE=Kocka'#13+
'DOWN TRIANGLE=Als� h�romsz�g'#13+
'SMALL DOT=Kis pont'#13+
'GLOBAL=Glob�lis'#13+
'SHAPES=Alakzatok'#13+
'BRUSH=Ecset'#13+
'DELAY=K�s�s'#13+
'MSEC.=ms'#13+
'MOUSE ACTION=Eg�rm�velet'#13+
'MOVE=Mozgat�s'#13+
'CLICK=Kattint�s'#13+
'DRAW LINE=Vonal h�z�s'#13+
'EXPLODE BIGGEST=Legnagyobb m�ret�'#13+
'TOTAL ANGLE=Sz�gek �ssz.'#13+
'GROUP SLICES=Szelet-csoportok'#13+
'BELOW %=Alatta, %'#13+
'BELOW VALUE=Alatta, �rt�k'#13+
'OTHER=Egy�b'#13+
'PATTERNS=Mint�k'#13+
'SIZE %=M�ret %'#13+
'SERIES DATASOURCE TEXT EDITOR=Adatforr�s sz�vegszerkeszt�'#13+
'FIELDS=Mez�k'#13+
'NUMBER OF HEADER LINES=Fejl�c sz�ma'#13+
'SEPARATOR=Elv�laszt�s'#13+
'COMMA=Vessz�'#13+
'SPACE=Sz�k�z'#13+
'TAB=Tabul�tor'#13+
'FILE=F�jl'#13+
'WEB URL=Web URL'#13+
'LOAD=Bet�lt�s'#13+
'C LABELS=C Feliratok'#13+
'R LABELS=R Feliratok'#13+
'C PEN=C toll'#13+
'R PEN=R toll'#13+
'STACK GROUP=Halomcsoport'#13+
'MULTIPLE BAR=T�bbsz�r�s s�v'#13+
'SIDE=Egym�s mellett'#13+
'SIDE ALL=Mind egym�s mellett'#13+
'DRAWING MODE=Rajzol�s m�d'#13+
'WIREFRAME=R�csh�l�'#13+
'DOTFRAME=Pont-h�l�'#13+
'SMOOTH PALETTE=Sima paletta'#13+
'SIDE BRUSH=Oldalecset'#13+
'ABOUT TEECHART PRO V7.0=TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'VISIT OUR WEB SITE !=L�togasd meg honlapunkat !'#13+
'TEECHART WIZARD=TeeChart Var�zsl�'#13+
'SELECT A CHART STYLE=Grafikon-st�lus v�laszt�s'#13+
'DATABASE CHART=Adatb�zis grafikon'#13+
'NON DATABASE CHART=Nem adatb�zis grafikon'#13+
'SELECT A DATABASE TABLE=Adatb�zis t�bla kiv�laszt�s'#13+
'ALIAS=Alias'#13+
'TABLE=T�bla'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=K�v�nt mez� v�laszt�sa a grafikonhoz'#13+
'SELECT A TEXT LABELS FIELD=Felirat-mez� v�laszt�sa'#13+
'CHOOSE THE DESIRED CHART TYPE=K�v�nt grafikont�pus v�laszt�sa'#13+
'2D=2D'#13+
'CHART PREVIEW=Grafikon nyomtat�si k�p'#13+
'SHOW LEGEND=Jelmagyar. mutat'#13+
'SHOW MARKS=Jegyzetek megtek.'#13+
'< BACK=< El�z�'#13+
'EXPORT CHART=Grafikon export�l�s'#13+
'PICTURE=K�p'#13+
'NATIVE=Eredeti'#13+
'KEEP ASPECT RATIO=Elhelyez�si ar�nyokat megtart'#13+
'INCLUDE SERIES DATA=Adatsorral egy�tt'#13+
'FILE SIZE=F�jl m�ret'#13+
'DELIMITER=Hat�rol�jel'#13+
'XML=XML'#13+
'HTML TABLE=HTML T�bl�zat'#13+
'EXCEL=Excel'#13+
'COLON=Kett�spont'#13+
'INCLUDE=Tartalmaz'#13+
'POINT LABELS=Pont feliratok'#13+
'POINT INDEX=Pontok indexe'#13+
'HEADER=Fejl�c'#13+
'COPY=M�sol�s'#13+
'SAVE=Ment�s'#13+
'SEND=K�ld�s'#13+
'FUNCTIONS=F�ggv�nyek'#13+
'ADX=ADX'#13+
'AVERAGE=�tlag'#13+
'BOLLINGER=Oszt�s'#13+
'DIVIDE=Oszt'#13+
'EXP. AVERAGE=Kifejtett �tlag'#13+
'EXP.MOV.AVRG.=Kifejtett mozg� �tlag'#13+
'MACD=MACD'#13+
'MOMENTUM=N�veked�s'#13+
'MOMENTUM DIV=N�veked�ssel oszt'#13+
'MOVING AVRG.=Mozg� �tlag'#13+
'MULTIPLY=Szorz�s'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=N�gyzetes k�z�p�rt�k'#13+
'STD.DEVIATION=Kivont elt�r�s'#13+
'STOCHASTIC=V�letlenszer�'#13+
'SUBTRACT=Kivon�s'#13+
'SOURCE SERIES=Sor forr�s'#13+
'TEECHART GALLERY=TeeChart Gal�ria'#13+
'DITHER=Remeg'#13+
'REDUCTION=Cs�kkent�s'#13+
'COMPRESSION=T�m�r�t�s'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Legk�zelebbi'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'GRAY SCALE=Gray Scale'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Min�s�g'#13+
'PERFORMANCE=V�grehajt�s'#13+
'QUALITY=Min�s�g'#13+
'SPEED=Gyorsas�g'#13+
'COMPRESSION LEVEL=T�m�r�t�si fok'#13+
'CHART TOOLS GALLERY=Grafikon eszk�z-k�pt�r'#13+
'ANNOTATION=Magyar�zat'#13+
'AXIS ARROWS=Tengely-ny�l'#13+
'COLOR BAND=Sz�ns�v'#13+
'COLOR LINE=Sz�nes vonal'#13+
'DRAG MARKS=Jel�l�st elh�z'#13+
'MARK TIPS=Jel�l�si tippek'#13+
'NEAREST POINT=Legk�zelebbi pont'#13+
'ROTATE=Elforgat�s'#13+
'YES=Ja'#13+

// 6.0

'PERIOD=Peri�dus'#13+
'UP=Fel'#13+
'DOWN=Le'#13+
'SHADOW EDITOR=�rny�k editor'#13+
'CALLOUT=Kimen�'#13+
'TEXT ALIGNMENT=Sz�veg igaz�t�s'#13+
'DISTANCE=T�vols�g'#13+
'ARROW HEAD=Ny�lhegy'#13+
'POINTER=Mutat�'#13+
'DRAG=Vonszol/h�z'#13+
'HOURGLASS=Homok�ra'#13+
'AVAILABLE LANGUAGES=Nyelv v�laszt�k'#13+
'CHOOSE A LANGUAGE=V�lasszon nyelvet'#13+
'CALCULATE USING=Mi alapj�n sz�mol'#13+
'EVERY NUMBER OF POINTS=Pontok mindegyik�t'#13+
'EVERY RANGE=Minden inervallumot'#13+
'INCLUDE NULL VALUES=Null �rt�keket is'#13+
'INVERTED SCROLL=Ford�tott g�rget�s'#13+
'DATE=D�tum'#13+
'ENTER DATE=D�tum'#13+
'ENTER TIME=Id�pont'#13+
'BEVEL SIZE=Bevel m�ret'#13+
'DEVIATION=Elt�r�s/devi�ci�'#13+
'UPPER=Fels�'#13+
'LOWER=Als�'#13+
'NOTHING=Semmi'#13+
'LEFT TRIANGLE=Bal h�romsz�g'#13+
'RIGHT TRIANGLE=Jobb h�romsz�g'#13+
'SHOW PREVIOUS BUTTON=El�z� gomb mutat�sa'#13+
'SHOW NEXT BUTTON=K�v. gomb mutat�sa'#13+
'CONSTANT=Konstans'#13+
'SHOW LABELS=L�that� cimk�k'#13+
'SHOW COLORS=L�that� sz�nek'#13+
'XYZ SERIES=XYZ sz�ri�k'#13+
'SHOW X VALUES=X �rt�kek l�that�ak'#13+
'DELETE ROW=Sor t�rl�se'#13+
'VOLUME SERIES=Mennyis�g sz�ri�k'#13+
'ACCUMULATE=Kumul�l'#13+
'START VALUE=Kezd� �rt�k'#13+
'SINGLE=Egyedi'#13+
'REMOVE CUSTOM COLORS=Saj�t sz�neket elvesz'#13+
'STEP=L�p�s'#13+
'USE PALETTE MINIMUM=Paletta minimum�t haszn�lja'#13+
'AXIS MAXIMUM=Tengely maximum'#13+
'AXIS CENTER=Tengely k�z�ppont'#13+
'AXIS MINIMUM=Tengely minimum'#13+
'DRAG REPAINT=H�z�s k�zben friss�t'#13+
'NO LIMIT DRAG=B�rhova h�zhat�'#13+
'DAILY (NONE)=Napi (semmi)'#13+
'WEEKLY=Heti'#13+
'MONTHLY=Havi'#13+
'BI-MONTHLY=K�thavi'#13+
'QUARTERLY=Negyed�ves'#13+
'YEARLY=�ves'#13+
'DATETIME PERIOD=Id�tartam'#13+
'SMOOTH=Sim�t�s'#13+
'INTERPOLATE=Interpol�l'#13+
'START X=Kezd� X'#13+
'NUM. POINTS=Pontok sz�ma'#13+
'COLOR EACH LINE=Minden sor sz�nes'#13+
'CASE SENSITIVE=a/A k�l�nb�z�'#13+
'SORT BY=Rendez�s'#13+
'(NONE)=(semmi)'#13+
'CALCULATION=Sz�mol�s'#13+
'GROUP=Csoportos�t�s'#13+
'HOLE %=Lyuk %'#13+
'DRAG STYLE=Drag-el�s t�pusa'#13+
'WEIGHT=S�ly'#13+
'EDIT LEGEND=Jelmagy. szerk.'#13+
'ROUND=Kerek�tett'#13+
'FLAT=Tomp�tott/flat'#13+
'DRAW ALL=Mindet rajzolja'#13+
'IGNORE NULLS=NULLokat kihagyja'#13+
'OFFSET=Ofszet'#13+
'LIGHT 0=Vil�gos 0'#13+
'LIGHT 1=Vil�gos 1'#13+
'LIGHT 2=Vil�gos 2'#13+
'DRAW STYLE=Rajzol�s st�lusa'#13+
'POINTS=Pontok'#13+
'DEFAULT BORDER=Alap szeg�ly'#13+
'SQUARED=N�gysz�gletes'#13+
'SHOW PAGE NUMBER=Oldalsz�mot mutat'#13+
'SEPARATION=Sz�tv�laszt�s'#13+
'ROUND BORDER=Kerek szeg�ly'#13+
'NUMBER OF SAMPLE VALUES=Minta �rt�kek sz�ma'#13+
'RESIZE PIXELS TOLERANCE=M�retez�skori pixel toler�l�s'#13+
'FULL REPAINT=Teljes �jrarajzol�s'#13+
'END POINT=V�gpont'#13+
'BAND 1=S�v 1'#13+
'BAND 2=S�v 2'#13+
'GRID 3D SERIES=3D r�cs sz�ria'#13+
'TRANSPOSE NOW=Transzpon�l�s most'#13+
'PERIOD 1=1.Peri�dus'#13+
'PERIOD 2=2.Peri�dus'#13+
'PERIOD 3=3.Peri�dus'#13+
'HISTOGRAM=Gyakoris�g.'#13+
'EXP. LINE=Exp. vonal'#13+
'WEIGHTED=S�lyozott'#13+
'WEIGHTED BY INDEX=S�lyoz�si index'#13+
'DARK BORDER=S�t�t szeg�ly'#13+
'PIE SERIES=Torta sz�ria'#13+
'FOCUS=F�kusz'#13+
'EXPLODE=Szeletel'#13+
'BOX SIZE=Doboz m�ret'#13+
'REVERSAL AMOUNT=Visszavont mennyis�g'#13+
'PERCENTAGE=Sz�zal�k'#13+
'COMPLETE R.M.S.=Teljes RMS'#13+
'BUTTON=Gomb'#13+
'SELECTED=Kijel�lt'#13+
'START AT MIN. VALUE=Min. �rt�ken kezdi'#13+
'EXECUTE !=V�grehajt�s!'#13+
'IMAG. SYMBOL=K�pz. szimb�lum'#13+
'FACTOR=Faktor'#13+
'SELF STACK=Pakolt'#13+
'SIDE LINES=Oldalvonalak'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Grafikon sablonb�l (*.tee f�jl)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=TeeChart sablon megnyit�sa innen'#13+
'EXPORT DIALOG=Export ablak'#13+
'BINARY=Bin�ris'#13+
'POINT COLORS=Pontok sz�nez�se'#13+
'OUTLINE GRADIENT=K�rvonal gradiens'#13+
'RADIAL=Sug�rir�ny�'#13+
'BALANCE=Egyens�ly'#13+
'RADIAL OFFSET=Sug�rir�ny� ofszet'#13+
'HORIZ=V�zsz.'#13+
'VERT=F�gg.'#13+
'DRAG POINT=Pont h�z�sa'#13+
'COVER=Bor�t�s'#13+
'ARROW WIDTH=Ny�l sz�less�g'#13+
'ARROW HEIGHT=Ny�l magass�g'#13+
'DEFAULT COLOR=Alap sz�n'#13+
'VALUE SOURCE=�rt�k forr�s'

;
  end;
end;

Procedure TeeSetHungarian;
begin
  TeeCreateHungarian;
  TeeLanguage:=TeeHungarianLanguage;
  TeeHungarianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeHungarianLanguage);
end.
