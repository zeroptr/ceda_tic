unit TeeCzech;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeCzechLanguage:TStringList=nil;

Procedure TeeSetCzech;
Procedure TeeCreateCzech;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeCzechConstants;
begin
    TeeMsg_Copyright          :='� 1995-2009 by David Berneda';
    TeeMsg_LegendFirstValue   :='Prvn� hodnota legendy mus� b�t > 0';
    TeeMsg_LegendColorWidth   :='���ka barvy legendy mus� b�t > 0%';
    TeeMsg_SeriesSetDataSource:='Nen� ParentChart pro ov��en� DataSource';
    TeeMsg_SeriesInvDataSource:='Nen� platn� DataSource: %s';
    TeeMsg_FillSample         :='FillSampleValues NumValues mus� b�t > 0';
    TeeMsg_AxisLogDateTime    :='Osa datum/�as nem��e b�t logaritmick�';
    TeeMsg_AxisLogNotPositive :='Hodnoty minimum a maximum logaritmick� osy by m�ly b�t >= 0';
    TeeMsg_AxisLabelSep       :='Procentn� odstup popis� mus� b�t v�t�� ne� 0';
    TeeMsg_AxisIncrementNeg   :='P��r�stek osy mus� b�t >= 0';
    TeeMsg_AxisMinMax         :='Minim�ln� hodnota osy mus� b�t <= maxim�ln�';
    TeeMsg_AxisMaxMin         :='Maxim�ln� hodnota osy mus� b�t >= minim�ln�';
    TeeMsg_AxisLogBase        :='Z�klad logaritmick� osy by m�l b�t >= 2';
    TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage mus� b�t >= 0';
    TeeMsg_3dPercent          :='Procenta efektu 3D mus� b�t mezi %d a %d';
    TeeMsg_CircularSeries     :='Z�vislost kruhov� s�rie nen� mo�n�';
    TeeMsg_WarningHiColor     :='Pro lep�� vzhled je po�adov�no 16 tis�c nebo v�ce barev';

    TeeMsg_DefaultPercentOf   :='%s z %s';
    TeeMsg_DefaultPercentOf2  :='%s'+#13+'z %s';
    TeeMsg_DefPercentFormat   :='##0.## %';
    TeeMsg_DefValueFormat     :='#,##0.###';
    TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
    TeeMsg_AxisTitle          :='N�zev osy';
    TeeMsg_AxisLabels         :='Popisy osy';
    TeeMsg_RefreshInterval    :='Interval obnoven� mus� b�t mezi 0 a 60';
    TeeMsg_SeriesParentNoSelf :='Series.ParentChart nen� s�m!';
    TeeMsg_GalleryLine        :='��ra';
    TeeMsg_GalleryPoint       :='Bod';
    TeeMsg_GalleryArea        :='Prostor';
    TeeMsg_GalleryBar         :='Sloupec';
    TeeMsg_GalleryHorizBar    :='Horiz. sloupec';
    TeeMsg_Stack              :='Vrstva';
    TeeMsg_GalleryPie         :='Kol��';
    TeeMsg_GalleryCircled     :='Kruhov�';
    TeeMsg_GalleryFastLine    :='Rychl� ��ra';
    TeeMsg_GalleryHorizLine   :='Horiz. ��ra';

    TeeMsg_PieSample1         :='Auta';
    TeeMsg_PieSample2         :='Telefony';
    TeeMsg_PieSample3         :='Tabulky';
    TeeMsg_PieSample4         :='Monitory';
    TeeMsg_PieSample5         :='Lampy';
    TeeMsg_PieSample6         :='Kl�vesnice';
    TeeMsg_PieSample7         :='Kola';
    TeeMsg_PieSample8         :='�idle';

    TeeMsg_GalleryLogoFont    :='Courier New';
    TeeMsg_Editing            :='Editace %s';

    TeeMsg_GalleryStandard    :='Standardn�';
    TeeMsg_GalleryExtended    :='Roz���en�';
    TeeMsg_GalleryFunctions   :='Funkce';

    TeeMsg_EditChart          :='&Zm�nit graf...';
    TeeMsg_PrintPreview       :='&N�hled tisku...';
    TeeMsg_ExportChart        :='E&xportovat grafu...';
    TeeMsg_CustomAxes         :='Upravit osy...';

    TeeMsg_InvalidEditorClass :='%s: Neplatn� t��da editoru: %s';
    TeeMsg_MissingEditorClass :='%s: nem� dialogov� okno editoru';

    TeeMsg_GalleryArrow       :='�ipka';

    TeeMsg_ExpFinish          :='&Dokon�it';
    TeeMsg_ExpNext            :='&Dal�� >';

    TeeMsg_GalleryGantt       :='Schody';

    TeeMsg_GanttSample1       :='N�vrh';
    TeeMsg_GanttSample2       :='Modelov�n�';
    TeeMsg_GanttSample3       :='V�voj';
    TeeMsg_GanttSample4       :='Prodej';
    TeeMsg_GanttSample5       :='Marketing';
    TeeMsg_GanttSample6       :='Testov�n�';
    TeeMsg_GanttSample7       :='V�roba';
    TeeMsg_GanttSample8       :='Lad�n�';
    TeeMsg_GanttSample9       :='Nov� verze';
    TeeMsg_GanttSample10      :='Bankovnictv�';

    TeeMsg_ChangeSeriesTitle  :='Zm�nit nadpis s�rie';
    TeeMsg_NewSeriesTitle     :='Nadpis nov� s�rie:';
    TeeMsg_DateTime           :='Datum a �as';
    TeeMsg_TopAxis            :='Horn� osa';
    TeeMsg_BottomAxis         :='Spodn� osa';
    TeeMsg_LeftAxis           :='Lev� osa';
    TeeMsg_RightAxis          :='Prav� osa';

    TeeMsg_SureToDelete       :='Vymazat %s ?';
    TeeMsg_DateTimeFormat     :='For&m�t data a �asu:';
    TeeMsg_Default            :='V�choz�';
    TeeMsg_ValuesFormat       :='For&m�t hodnot:';
    TeeMsg_Maximum            :='Maximum';
    TeeMsg_Minimum            :='Minimum';
    TeeMsg_DesiredIncrement   :='Po�adovan� p��r�stek %s';

    TeeMsg_IncorrectMaxMinValue:='Neplatn� hodnota. D�vod: %s';
    TeeMsg_EnterDateTime      :='Vlo�te [po�et dn�] '+TeeMsg_HHNNSS;

    TeeMsg_SureToApply        :='Prov�st zm�ny?';
    TeeMsg_SelectedSeries     :='(vybran� s�rie)';
    TeeMsg_RefreshData        :='&Obnovit data';

    TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
    TeeMsg_DefaultEditorSize  :='414';
    TeeMsg_FunctionAdd        :='Sou�et';
    TeeMsg_FunctionSubtract   :='Rozd�l';
    TeeMsg_FunctionMultiply   :='N�soben�';
    TeeMsg_FunctionDivide     :='D�len�';
    TeeMsg_FunctionHigh       :='Nejvy���';
    TeeMsg_FunctionLow        :='Nejni���';
    TeeMsg_FunctionAverage    :='Pr�m�r';

    TeeMsg_GalleryShape       :='Tvar';
    TeeMsg_GalleryBubble      :='Bublina';
    TeeMsg_FunctionNone       :='Kopie';

    TeeMsg_None               :='(��dn�)';

    TeeMsg_PrivateDeclarations:='{ Priv�tn� deklarace }';
    TeeMsg_PublicDeclarations :='{ Ve�ejn� deklarace }';
    TeeMsg_DefaultFontName    :={$IFDEF CLX}'Helvetica'{$ELSE}'Arial'{$ENDIF};

    TeeMsg_CheckPointerSize   :='Velikost ukazatele mus� b�t v�t�� ne� nula';
    TeeMsg_About              :='&O TeeChart...';

    tcAdditional              :='Dal��';
    tcDControls               :='Datov� prvky';
    tcQReport                 :='QReport';

    TeeMsg_DataSet            :='Dataset';
    TeeMsg_AskDataSet         :='&Dataset:';

    TeeMsg_SingleRecord       :='Jeden z�znam';
    TeeMsg_AskDataSource      :='&Datov� zdroj:';

    TeeMsg_Summary            :='Souhrn';

    TeeMsg_FunctionPeriod     :='Perioda funkce by m�la b�t >= 0';

    TeeMsg_WizardTab          :='Obchodn�';
    TeeMsg_TeeChartWizard     :='Pr�vodce TeeChart';

    TeeMsg_ClearImage         :='V&ymazat';
    TeeMsg_BrowseImage        :='P&roch�zet...';

    TeeMsg_WizardSureToClose  :='Jste si jist�, �e chcete zav��t pr�vodce TeeChart?';
    TeeMsg_FieldNotFound      :='Pole %s neexistuje';

    TeeMsg_DepthAxis          :='Hloubka osy';
    TeeMsg_PieOther           :='Ostatn�';
    TeeMsg_ShapeGallery1      :='abc';
    TeeMsg_ShapeGallery2      :='123';
    TeeMsg_ValuesX            :='X';
    TeeMsg_ValuesY            :='Y';
    TeeMsg_ValuesPie          :='Kol��';
    TeeMsg_ValuesBar          :='Sloupec';
    TeeMsg_ValuesAngle        :='�hel';
    TeeMsg_ValuesGanttStart   :='Po��tek';
    TeeMsg_ValuesGanttEnd     :='Konec';
    TeeMsg_ValuesGanttNextTask:='Dal�� �loha';
    TeeMsg_ValuesBubbleRadius :='Polom�r';
    TeeMsg_ValuesArrowEndX    :='KonecX';
    TeeMsg_ValuesArrowEndY    :='KonecY';
    TeeMsg_Legend             :='Legenda';
    TeeMsg_Title              :='Nadpis';
    TeeMsg_Foot               :='Pata';
    TeeMsg_Period		          :='Perioda';
    TeeMsg_PeriodRange        :='Rozsah periody';
    TeeMsg_CalcPeriod         :='Po��tat %s ka�d�ch:';
    TeeMsg_SmallDotsPen       :='Mal� te�ky';

    TeeMsg_InvalidTeeFile     :='Neplatn� graf v souboru *.'+TeeMsg_TeeExtension;
    TeeMsg_WrongTeeFileFormat :='�patn� form�t souboru *.'+TeeMsg_TeeExtension;
    TeeMsg_EmptyTeeFile       :='Pr�zdn� soubor *.'+TeeMsg_TeeExtension;  { 5.01 }

  {$IFDEF D5}
    TeeMsg_ChartAxesCategoryName   := 'Osy grafu';
    TeeMsg_ChartAxesCategoryDesc   := 'Vlastnosti a ud�losti os grafu';
    TeeMsg_ChartWallsCategoryName  := 'St�ny grafu';
    TeeMsg_ChartWallsCategoryDesc  := 'Vlastnosti a ud�losti st�n grafu';
    TeeMsg_ChartTitlesCategoryName := 'Nadpisy grafu';
    TeeMsg_ChartTitlesCategoryDesc := 'Vlastnosti a ud�losti nadpis� grafu';
    TeeMsg_Chart3DCategoryName     := 'Graf 3D';
    TeeMsg_Chart3DCategoryDesc     := 'Vlastnosti a ud�losti grafu 3D';
  {$ENDIF}

    TeeMsg_CustomAxesEditor       :='U�ivatelsk� ';
    TeeMsg_Series                 :='Skupiny';
    TeeMsg_SeriesList             :='Skupiny...';

    TeeMsg_PageOfPages            :='Strana %d z %d';
    TeeMsg_FileSize               :='%d bajt�';

    TeeMsg_First  :='Prvn�';
    TeeMsg_Prior  :='P�edchoz�';
    TeeMsg_Next   :='N�sleduj�c�';
    TeeMsg_Last   :='Posledn�';
    TeeMsg_Insert :='Vlo�it';
    TeeMsg_Delete :='Vymazat';
    TeeMsg_Edit   :='Zm�nit';
    TeeMsg_Post   :='Ulo�it';
    TeeMsg_Cancel :='Storno';

    TeeMsg_All    :='(v�e)';
    TeeMsg_Index  :='Index';
    TeeMsg_Text   :='Text';

    TeeMsg_AsBMP        :='jako &bitmapa';
    TeeMsg_BMPFilter    :='Bitmapy (*.bmp)|*.bmp';
    TeeMsg_AsEMF        :='jako &metasoubor';
    TeeMsg_EMFFilter    :='Roz���en� metasoubory (*.emf)|*.emf|Metasoubory (*.wmf)|*.wmf';
    TeeMsg_ExportPanelNotSet := 'Vlastnost panelu nem� nastaven form�t exportu';

    TeeMsg_Normal    :='Norm�ln�';
    TeeMsg_NoBorder  :='Bez okraj�';
    TeeMsg_Dotted    :='Te�kovan�';
    TeeMsg_Colors    :='Barvy';
    TeeMsg_Filled    :='Vypln�n�';
    TeeMsg_Marks     :='Zna�ky';
    TeeMsg_Stairs    :='Schody';
    TeeMsg_Points    :='Body';
    TeeMsg_Height    :='V��ka';
    TeeMsg_Hollow    :='Dutina';
    TeeMsg_Point2D   :='Bod 2D';
    TeeMsg_Triangle  :='Troj�heln�k';
    TeeMsg_Star      :='Hv�zda';
    TeeMsg_Circle    :='Kruh';
    TeeMsg_DownTri   :='Spodn� troj�heln�k';
    TeeMsg_Cross     :='K��';
    TeeMsg_Diamond   :='Diamant';
    TeeMsg_NoLines   :='Bez �ar';
  TeeMsg_Stack100  :='Stack 100%';
    TeeMsg_Pyramid   :='Pyramida';
    TeeMsg_Ellipse   :='Elipsa';
    TeeMsg_InvPyramid:='Inv. pyramida';
    TeeMsg_Sides     :='Strany';
    TeeMsg_SideAll   :='V�echny strany';
    TeeMsg_Patterns  :='V�pln�';
    TeeMsg_Exploded  :='Vysunut�';
    TeeMsg_Shadow    :='St�n';
    TeeMsg_SemiPie   :='Polovi�n� kol��';
    TeeMsg_Rectangle :='Obd�ln�k';
    TeeMsg_VertLine  :='Vert. ��ra';
    TeeMsg_HorizLine :='Horiz. 48ra';
    TeeMsg_Line      :='��ra';
    TeeMsg_Cube      :='Krychle';
    TeeMsg_DiagCross :='Diag. k��';

    TeeMsg_CanNotFindTempPath    :='Nemohu naj�t adres�� do�asn�ch soubor�';
    TeeMsg_CanNotCreateTempChart :='Nemohu vytvo�it do�asn� soubor';
    TeeMsg_CanNotEmailChart      :='Nemohu odeslat e-mailem TeeChart. Chyba MAPI: %d';

    TeeMsg_SeriesDelete :='Vymaz�n� s�rie: ValueIndex %d mimo rozsah (0 a� %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

    TeeMsg_AsJPEG        :='jako &JPEG';
    TeeMsg_JPEGFilter    :='Soubory JPEG (*.jpg)|*.jpg';
    TeeMsg_AsGIF         :='jako &GIF';
    TeeMsg_GIFFilter     :='Soubory GIF (*.gif)|*.gif';
    TeeMsg_AsPNG         :='jako &PNG';
    TeeMsg_PNGFilter     :='Soubory PNG (*.png)|*.png';
    TeeMsg_AsPCX         :='jako PC&X';
    TeeMsg_PCXFilter     :='Soubory PCX (*.pcx)|*.pcx';
    TeeMsg_AsVML         :='jako &VML (HTM)';
    TeeMsg_VMLFilter     :='Soubory VML (*.htm)|*.htm';

  { 5.02 }
    TeeMsg_AskLanguage  :='&Jazyk...';

  { TeeProCo }
    TeeMsg_GalleryPolar       :='Pol�rn�';
    TeeMsg_GalleryCandle      :='Sv�ce';
    TeeMsg_GalleryVolume      :='Intenzita';
    TeeMsg_GallerySurface     :='Povrch';
    TeeMsg_GalleryContour     :='Obrys';
    TeeMsg_GalleryBezier      :='B�zier';
    TeeMsg_GalleryPoint3D     :='Bod 3D';
    TeeMsg_GalleryRadar       :='Radar';
    TeeMsg_GalleryDonut       :='Kobliha';
    TeeMsg_GalleryCursor      :='Kurzor';
    TeeMsg_GalleryBar3D       :='Sloupec 3D';
    TeeMsg_GalleryBigCandle   :='Velk� sv�ce';
    TeeMsg_GalleryLinePoint   :='��ra a bod';
    TeeMsg_GalleryHistogram   :='Histogram';
    TeeMsg_GalleryWaterFall   :='Pokles vody';
    TeeMsg_GalleryWindRose    :='V�trn� r��ice';
    TeeMsg_GalleryClock       :='Hodiny';
    TeeMsg_GalleryColorGrid   :='Barevn� m��';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
    TeeMsg_GalleryBarJoin     :='Spojen� sloupec';
    TeeMsg_GallerySmith       :='Smith�v diagram';
    TeeMsg_GalleryPyramid     :='Pyramida';
    TeeMsg_GalleryMap         :='Mapa';

    TeeMsg_PolyDegreeRange    :='Stupe� polynomie mus� b�t mezi 1 a 20';
    TeeMsg_AnswerVectorIndex   :='Index odpov�daj�c�ho vektoru mus� b�t mezi 1 a %d';
    TeeMsg_FittingError        :='Nelze prov�st �pravu';
    TeeMsg_PeriodRange         :='Perioda mus� b�t >= 0';
    TeeMsg_ExpAverageWeight    :='Hmotnost ExpAverage mus� b�t mezi 0 a 1';
    TeeMsg_GalleryErrorBar     :='Sloupec Chyba';
    TeeMsg_GalleryError        :='Chyba';
    TeeMsg_GalleryHighLow      :='Horn�-spodn�';
    TeeMsg_FunctionMomentum    :='Moment';
    TeeMsg_FunctionMomentumDiv :='Moment d�len�';
    TeeMsg_FunctionExpAverage  :='Exp. pr�m�r';
    TeeMsg_FunctionMovingAverage:='Pohybliv� pr�m�r.';
    TeeMsg_FunctionExpMovAve   :='Exp. pohybliv� pr�m�r.';
    TeeMsg_FunctionRSI         :='R.S.I.';
    TeeMsg_FunctionCurveFitting:='�prava k�ivky';
    TeeMsg_FunctionTrend       :='Sm�r';
    TeeMsg_FunctionExpTrend    :='Exp. sm�r';
    TeeMsg_FunctionLogTrend    :='Log. sm�r';
    TeeMsg_FunctionCumulative  :='Kumulativn�';
    TeeMsg_FunctionStdDeviation:='Standardn� odchylka';
    TeeMsg_FunctionBollinger   :='Bollinger';
    TeeMsg_FunctionRMS         :='Ko�en �tverec';
    TeeMsg_FunctionMACD        :='MACD';
    TeeMsg_FunctionStochastic  :='N�hodn�';
    TeeMsg_FunctionADX         :='ADX';

    TeeMsg_FunctionCount       :='Po�et';
    TeeMsg_LoadChart           :='Otev��t TeeChart...';
    TeeMsg_SaveChart           :='Ulo�it TeeChart...';
    TeeMsg_TeeFiles            :='Soubory TeeChart Pro';

    TeeMsg_GallerySamples      :='Jin�';
    TeeMsg_GalleryStats        :='Statistick�';

    TeeMsg_CannotFindEditor    :='Nemohu naj�t formul�� edotoru s�rie: %s';


    TeeMsg_CannotLoadChartFromURL:='K�d chyby: %d stahov�n� grafu z URL: %s';
    TeeMsg_CannotLoadSeriesDataFromURL:='K�d chyby: %d stahov�n� dat s�rie z URL: %s';

    TeeMsg_Test                :='Test...';

    TeeMsg_ValuesDate          :='Datum';
    TeeMsg_ValuesOpen          :='Otev��t';
    TeeMsg_ValuesHigh          :='Vysok�';
    TeeMsg_ValuesLow           :='N�zk�';
    TeeMsg_ValuesClose         :='Zav��t';
    TeeMsg_ValuesOffset        :='Posun';
  TeeMsg_ValuesStdError      :='StdError';

    TeeMsg_Grid3D              :='M�� 3D';

    TeeMsg_LowBezierPoints     :='Po�et B�zi�rov�ch bod� by m�l b�t > 1';

  { TeeCommander component... }

    TeeCommanMsg_Normal   :='Norm�ln�';
    TeeCommanMsg_Edit     :='Zm�nit';
    TeeCommanMsg_Print    :='Tisknout';
    TeeCommanMsg_Copy     :='Kop�rovat';
    TeeCommanMsg_Save     :='Ulo�it';
    TeeCommanMsg_3D       :='3D';

    TeeCommanMsg_Rotating :='Rotace: %d� Elevace: %d�';
    TeeCommanMsg_Rotate   :='Rotace';

    TeeCommanMsg_Moving   :='Horiz. posun: %d Vert. posun: %d';
    TeeCommanMsg_Move     :='P�esunout';

    TeeCommanMsg_Zooming  :='Zv�t�en�: %d %%';
    TeeCommanMsg_Zoom     :='Zv�t�en�';

    TeeCommanMsg_Depthing :='3D: %d %%';
    TeeCommanMsg_Depth    :='Hloubka';

    TeeCommanMsg_Chart    :='Graf';
    TeeCommanMsg_Panel    :='Panel';

    TeeCommanMsg_RotateLabel:='T�hn�te %s pro oto�en�';
    TeeCommanMsg_MoveLabel  :='T�hn�te %s pro p�esun';
    TeeCommanMsg_ZoomLabel  :='T�hn�te %s pro zv�t�en�';
    TeeCommanMsg_DepthLabel :='T�hn�te %s pro zm�nu velikosti 3D';

    TeeCommanMsg_NormalLabel:='T�hn�te lev�m tla��tkem pro zv�t�wn�, prav�m tla��tkem pro posun';
    TeeCommanMsg_NormalPieLabel:='D�l kol��e m��ete t�hnut�m vysunout';

    TeeCommanMsg_PieExploding :='D�l: %d Vysunuto: %d %%';

    TeeMsg_TriSurfaceLess        :='Po�et bod� mus� b�t >= 4';
    TeeMsg_TriSurfaceAllColinear :='V�echny body koline�rn�ch dat';
    TeeMsg_TriSurfaceSimilar     :='Podovn� body - nelze vykonat';
    TeeMsg_GalleryTriSurface     :='Troj�heln�k povrch';

    TeeMsg_AllSeries :='V�echny s�rie';
    TeeMsg_Edit      :='Zm�nit';

    TeeMsg_GalleryFinancial    :='Finan�n�';

    TeeMsg_CursorTool    :='Kurzor';
    TeeMsg_DragMarksTool :='P�esunout zna�ky';
    TeeMsg_AxisArrowTool :='�ipky osy';
    TeeMsg_DrawLineTool  :='Kreslit ��ru';
    TeeMsg_NearestTool   :='Nejbli��� bod';
    TeeMsg_ColorBandTool :='Barva skupiny';
    TeeMsg_ColorLineTool :='Barva ��ry';
    TeeMsg_RotateTool    :='Rotace';
    TeeMsg_ImageTool     :='Obr�zek';
    TeeMsg_MarksTipTool  :='Tipy zna�ek';

    TeeMsg_CantDeleteAncestor  :='Nemohu vymazat p�edka';

    TeeMsg_Load	          :='Na��st...';
    TeeMsg_NoSeriesSelected :='Nen� vybr�na s�rie';

  { TeeChart Actions }
    TeeMsg_CategoryChartActions  :='Graf';
    TeeMsg_CategorySeriesActions :='S�rie grafu';

    TeeMsg_Action3D               := '&3D';
    TeeMsg_Action3DHint           := 'P�epnout 2D / 3D';
    TeeMsg_ActionSeriesActive     := '&Aktivn�';
    TeeMsg_ActionSeriesActiveHint := 'Uk�zat / skr�t s�rie';
    TeeMsg_ActionEditHint         := 'Zm�nit graf';
    TeeMsg_ActionEdit             := 'Zm�&nit...';
    TeeMsg_ActionCopyHint         := 'Kop�rovat do schr�nky';
    TeeMsg_ActionCopy             := '&Kop�rovat';
    TeeMsg_ActionPrintHint        := 'N�hled tisku grafu';
    TeeMsg_ActionPrint            := '&Tisk...';
    TeeMsg_ActionAxesHint         := 'Uk�zat / skr�t osy';
    TeeMsg_ActionAxes             := '&Osy';
    TeeMsg_ActionGridsHint        := 'Uk�zat / skr�t m��ky';
    TeeMsg_ActionGrids            := '&M��ky';
    TeeMsg_ActionLegendHint       := 'Uk�zat / skr�t legendu';
    TeeMsg_ActionLegend           := '&Legenda';
    TeeMsg_ActionSeriesEditHint   := 'Zm�nit s�rie';
    TeeMsg_ActionSeriesMarksHint  := 'Uk�zat / skr�t zna�ky s�rie';
    TeeMsg_ActionSeriesMarks      := '&Zna�ky';
    TeeMsg_ActionSaveHint         := 'Ulo�it graf';
    TeeMsg_ActionSave             := '&Ulo�it...';

    TeeMsg_CandleBar              := 'Sloupec';
    TeeMsg_CandleNoOpen           := 'Nen� otev�en�';
    TeeMsg_CandleNoClose          := 'Nen� zav�en�';
    TeeMsg_NoLines                := 'Nejsou ��ry';
    TeeMsg_NoHigh                 := 'Nen� vysok�';
    TeeMsg_NoLow                  := 'Nen� n�zk�';
    TeeMsg_ColorRange             := 'Rozsah barev';
    TeeMsg_WireFrame              := 'Tenk� r�me�ek';
    TeeMsg_DotFrame               := 'Bodov� r�me�ek';
    TeeMsg_Positions              := 'Pozice';
    TeeMsg_NoGrid                 := 'Nen� m��ka';
    TeeMsg_NoPoint                := 'Nen� bod';
    TeeMsg_NoLine                 := 'Nen� ��ra';
    TeeMsg_Labels                 := 'Popisy';
    TeeMsg_NoCircle               := 'Nen� kruh';
    TeeMsg_Lines                  := '��ry';
    TeeMsg_Border                 := 'Okraj';

    TeeMsg_SmithResistance      := 'Odpor';
    TeeMsg_SmithReactance       := 'Jalov� odpor';

    TeeMsg_Column               := 'Sloupec';

  { 5.01 }
    TeeMsg_Separator            := 'Odd�lova�';
    TeeMsg_FunnelSegment        := 'Segment ';
    TeeMsg_FunnelSeries         := 'Trycht��';
    TeeMsg_FunnelPercent        := '0.00 %';
    TeeMsg_FunnelExceed         := 'P�ekra�uje meze';
    TeeMsg_FunnelWithin         := ' v mez�ch';
    TeeMsg_FunnelBelow          := ' nebo nedos�hlo mez�';
    TeeMsg_CalendarSeries       := 'Kalend��';
    TeeMsg_DeltaPointSeries     := 'Bod delta';
    TeeMsg_ImagePointSeries     := 'Bod obr�zk�';
    TeeMsg_ImageBarSeries       := 'Sloupec obr�zk�';
    TeeMsg_SeriesTextFieldZero  := 'SeriesText: Index polo�ky by m�l b�t v�t�� ne� nula.';

  { 5.02 }
    TeeMsg_Origin               := 'Po��tek';
    TeeMsg_Transparency         := 'Transparentn�';
    TeeMsg_Box		              := 'Box';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
    TeeMsg_PageNumber	      := 'Strana ��slo';
    TeeMsg_TextFile             := 'Textov� soubor';

  { 5.03 }
    TeeMsg_Gradient     :='P�echod';
    TeeMsg_WantToSave   :='Chcete ulo�it %s?';
    TeeMsg_NativeFilter :='Soubory TeeChart';

    TeeMsg_Property     :='Vlastnost';
    TeeMsg_Value        :='Hodnota';
    TeeMsg_Yes          :='Ano';
    TeeMsg_No           :='Ne';
    TeeMsg_Image        :='(obr�zek)';

    TeeMsg_DragPoint            := 'P�esunout bod';
    TeeMsg_OpportunityValues    := 'OpportunityValues';
    TeeMsg_QuoteValues          := 'QuoteValues';
end;

Procedure TeeCreateCzech;
begin
  if not Assigned(TeeCzechLanguage) then
  begin
    TeeCzechLanguage:=TStringList.Create;
    TeeCzechLanguage.Text:=

  'GRADIENT EDITOR=Editor p�echodu'#13+
  'GRADIENT=P�echod'#13+
  'DIRECTION=Sm�r'#13+
  'VISIBLE=Viditeln�'#13+
  'TOP BOTTOM=Nahoru dol�'#13+
  'BOTTOM TOP=Dol� nahoru'#13+
  'LEFT RIGHT=Vlevo vpraco'#13+
  'RIGHT LEFT=Vpravo vlevo'#13+
  'FROM CENTER=Od st�edu'#13+
  'FROM TOP LEFT=Zlevanaho�e'#13+
  'FROM BOTTOM LEFT=Zespodu zleva'#13+
  'OK=OK'#13+
  'CANCEL=Storno'#13+
  'COLORS=Barvy'#13+
  'START=Za��tek'#13+
  'MIDDLE=St�ed'#13+
  'END=Konec'#13+
  'SWAP=Prohodit'#13+
  'NO MIDDLE=Nen� st�ed'#13+
  'TEEFONT EDITOR=Editor p�sma'#13+
  'INTER-CHAR SPACING=Mezera mezi znaky'#13+
  'FONT=P�smo'#13+
  'SHADOW=St�n'#13+
  'HORIZ. SIZE=Horiz. velikost'#13+
  'VERT. SIZE=Vert. velikost'#13+
  'COLOR=Barva'#13+
  'OUTLINE=Obrys'#13+
  'OPTIONS=Volby'#13+
  'FORMAT=Form�t'#13+
  'TEXT=Text'#13+
  'GRADIENT=P�echod'#13+
  'POSITION=Pozice'#13+
  'LEFT=Vlevo'#13+
  'TOP=Naho�e'#13+
  'AUTO=Automaticky'#13+
  'CUSTOM=Voliteln�'#13+
  'LEFT TOP=Vlevo naho�e'#13+
  'LEFT BOTTOM=Vlevo dole'#13+
  'RIGHT TOP=Vpravo naho�e'#13+
  'RIGHT BOTTOM=Vpravo dole'#13+
  'MULTIPLE AREAS=V�ce oblast�'#13+
  'NONE=��dn�'#13+
'STACKED=Stacked'#13+
'STACKED 100%=Stacked 100%'#13+
  'AREA=Oblast'#13+
  'PATTERN=V�pl�'#13+
  'STAIRS=Schody'#13+
  'SOLID=Pln�'#13+
  'CLEAR=Smazat'#13+
  'HORIZONTAL=Horizont�ln�'#13+
  'VERTICAL=Vertik�ln�'#13+
  'DIAGONAL=Diagon�ln�'#13+
  'B.DIAGONAL=oboudiagon�ln�'#13+
  'CROSS=K��'#13+
  'DIAG.CROSS=Diag. k��'#13+
  'AREA LINES=��ry oblasti'#13+
  'BORDER=Okraj'#13+
  'INVERTED=Inverzn�'#13+
  'INVERTED SCROLL=Obr�cen� posun'#13+
  'COLOR EACH=Ka�d� barva'#13+
  'ORIGIN=Po��tek'#13+
  'USE ORIGIN=Pou��t po��tek'#13+
  'WIDTH=���ka'#13+
  'HEIGHT=V��ka'#13+
  'AXIS=Osy'#13+
  'LENGTH=D�lka'#13+
  'SCROLL=Posun'#13+
  'PATTERN=V�pl�'#13+
  'START=Za��tek'#13+
  'END=Konec'#13+
  'BOTH=Oba'#13+
  'AXIS INCREMENT=P��r�stek osy'#13+
  'INCREMENT=P��r�stek'#13+
  'STANDARD=Standardn�'#13+
  'CUSTOM=U�ivatelsk�'#13+
  'ONE MILLISECOND=Jedna milisekunda'#13+
  'ONE SECOND=Jedna sekunda'#13+
  'FIVE SECONDS=P�t sekund'#13+
  'TEN SECONDS=Deset sekund'#13+
  'FIFTEEN SECONDS=Patn�ct sekund'#13+
  'THIRTY SECONDS=T�icet sekund'#13+
  'ONE MINUTE=Jedna minuta'#13+
  'FIVE MINUTES=P�t minut'#13+
  'TEN MINUTES=Deset minut'#13+
  'FIFTEEN MINUTES=Patn�ct minut'#13+
  'THIRTY MINUTES=T�icet minut'#13+
  'ONE HOUR=Jedna hodina'#13+
  'TWO HOURS=Dv� hodiny'#13+
  'SIX HOURS=�est hodin'#13+
  'TWELVE HOURS=Dvan�ct hodin'#13+
  'ONE DAY=Jeden den'#13+
  'TWO DAYS=Dva dny'#13+
  'THREE DAYS=T�i dny'#13+
  'ONE WEEK=Jeden t�den'#13+
  'HALF MONTH=P�l m�s�ce'#13+
  'ONE MONTH=Jeden m�s�c'#13+
  'TWO MONTHS=Dva m�s�ce'#13+
  'THREE MONTHS=T�i m�s�ce'#13+
  'FOUR MONTHS=�ty�i m�s�ce'#13+
  'SIX MONTHS=�est m�s�c�'#13+
  'ONE YEAR=Jeden rok'#13+
  'EXACT DATE TIME=Exaktn� datum a �as'#13+
  'AXIS MAXIMUM AND MINIMUM=Minimum a maximum osy'#13+
  'VALUE=Hodnota'#13+
  'TIME=�as'#13+
  'LEFT AXIS=Lev� osa'#13+
  'RIGHT AXIS=Prav� osa'#13+
  'TOP AXIS=Horn� osa'#13+
  'BOTTOM AXIS=Spodn� osa'#13+
  '% BAR WIDTH=% ���ka sloupce'#13+
  'STYLE=Styl'#13+
  '% BAR OFFSET=% Posun sloupce'#13+
  'RECTANGLE=Obd�ln�k'#13+
  'PYRAMID=Pyramida'#13+
  'INVERT. PYRAMID=Obr�cenn� pyramida'#13+
  'CYLINDER=V�lec'#13+
  'ELLIPSE=Elipsa'#13+
  'ARROW=�ipka'#13+
  'RECT. GRADIENT=Obd�ln�kov� p�echod'#13+
  'CONE=Ku�el'#13+
  'DARK BAR 3D SIDES=Strany tmav� 3D sloupce'#13+
  'BAR SIDE MARGINS=Okraje strany sloupce'#13+
  'AUTO MARK POSITION=Automaticky ozna�it pozici'#13+
  'BORDER=Okraj'#13+
  'JOIN=Spojen�'#13+
  'BAR SIDE MARGINS=Okraje strany sloupce'#13+
  'DATASET=Dataset'#13+
  'APPLY=Pou��t'#13+
  'SOURCE=Zdroj'#13+
  'MONOCHROME=�ernob�le'#13+
  'DEFAULT=V�choz�'#13+
  '2 (1 BIT)=2 (1 bit)'#13+
  '16 (4 BIT)=16 (4 bit)'#13+
  '256 (8 BIT)=256 (8 bit)'#13+
  '32768 (15 BIT)=32768 (15 bit)'#13+
  '65536 (16 BIT)=65536 (16 bit)'#13+
  '16M (24 BIT)=16M (24 bit)'#13+
  '16M (32 BIT)=16M (32 bit)'#13+
  'LENGTH=D�lka'#13+
  'MEDIAN=St�edn�'#13+
'WHISKER=Whisker'#13+
  'PATTERN COLOR EDITOR=Editor barevn� v�pln�'#13+
  'IMAGE=Obr�zek'#13+
  'NONE=��dn�'#13+
  'BACK DIAGONAL=Zadn� diagon�la'#13+
  'CROSS=K��'#13+
  'DIAGONAL CROSS=Diagon�ln� k��'#13+
  'FILL 80%=V�pl� 80%'#13+
  'FILL 60%=V�pl� 60%'#13+
  'FILL 40%=V�pl� 40%'#13+
  'FILL 20%=V�pl� 20%'#13+
  'FILL 10%=V�pl� 10%'#13+
  'ZIG ZAG=Cik cak'#13+
  'VERTICAL SMALL=Vertik�ln� mal�'#13+
  'HORIZ. SMALL=Horizont�ln� mal�'#13+
  'DIAG. SMALL=Diagon�ln� mal�'#13+
  'BACK DIAG. SMALL=Obr�cen� diagon�ln�'#13+
  'CROSS SMALL=Mal� k��'#13+
  'DIAG. CROSS SMALL=Mal� diagon�ln� k��'#13+
  'PATTERN COLOR EDITOR=Editor barevn� v�pln�'#13+
  'OPTIONS=Volby'#13+
  'DAYS=Dny'#13+
  'WEEKDAYS=Pracovn� dny'#13+
  'TODAY=Dnes'#13+
  'SUNDAY=Ned�le'#13+
  'TRAILING=Vle�en�'#13+
  'MONTHS=M�s�ce'#13+
  'LINES=��ry'#13+
  'SHOW WEEKDAYS=Uk�zat pracovn� dny'#13+
  'UPPERCASE=Velk� p�smena'#13+
'TRAILING DAYS=Trailing days'#13+
  'SHOW TODAY=Uk�zat dne�ek'#13+
  'SHOW MONTHS=Uk�zat m�s�ce'#13+
  'CANDLE WIDTH=���ka sv��ky'#13+
'STICK=Stick'#13+
  'BAR=Sloupec'#13+
  'OPEN CLOSE=Otev��t zav��t'#13+
  'UP CLOSE=Naho�e zav��t'#13+
  'DOWN CLOSE=Dole zav��t'#13+
  'SHOW OPEN=Uk�zat otev�en�'#13+
  'SHOW CLOSE=Uk�zat zav�en�'#13+
  'DRAW 3D=Kreslit 3D'#13+
  'DARK 3D=3D st�n'#13+
  'EDITING=�prava'#13+
  'CHART=Graf'#13+
  'SERIES=S�rie'#13+
  'DATA=Data'#13+
  'TOOLS=N�stroje'#13+
  'EXPORT=Exportovat'#13+
  'PRINT=Tisknout'#13+
  'GENERAL=Hlavn�'#13+
  'TITLES=Nadpisy'#13+
  'LEGEND=Legenda'#13+
  'PANEL=Panel'#13+
  'PAGING=Str�nkov�n�'#13+
  'WALLS=St�ny'#13+
  '3D=3D'#13+
  'ADD=P�idat'#13+
  'DELETE=Vymazat'#13+
  'TITLE=Nadpis'#13+
  'CLONE=Duplikovat'#13+
  'CHANGE=Zm�nit'#13+
  'HELP=Pomoc'#13+
  'CLOSE=Zav��t'#13+
  'IMAGE=Obr�zek'#13+
  'TEECHART PRINT PREVIEW=N�hled tisku TeeChart'#13+
  'PRINTER=Tisk�rna'#13+
  'SETUP=Nastaven�'#13+
  'ORIENTATION=Orientace'#13+
  'PORTRAIT=Na v��ku'#13+
  'LANDSCAPE=Na ���ku'#13+
  'MARGINS (%)=Okraje (%)'#13+
  'DETAIL=Detail'#13+
  'MORE=V�t��'#13+
  'NORMAL=Norm�ln�'#13+
  'RESET MARGINS=Obnovit okraje'#13+
  'VIEW MARGINS=Viditeln� okraje'#13+
  'PROPORTIONAL=Proporcion�ln�'#13+
  'TEECHART PRINT PREVIEW=N�hled tisku TeeChart'#13+
  'RECTANGLE=Obd�ln�k'#13+
  'CIRCLE=Kruh'#13+
  'VERTICAL LINE=Vert. ��ra'#13+
  'HORIZ. LINE=Horiz. ��ra'#13+
  'TRIANGLE=Troj�heln�k'#13+
  'INVERT. TRIANGLE=Obr�cen� troj�heln�k'#13+
  'LINE=��ra'#13+
  'DIAMOND=Diamant'#13+
  'CUBE=Krychle'#13+
  'DIAGONAL CROSS=Diagon�ln� k��'#13+
  'STAR=Hv�zda'#13+
  'TRANSPARENT=Pr�hledn�'#13+
  'HORIZ. ALIGNMENT=Horizont�ln� zarovn�n�'#13+
  'LEFT=Lev�'#13+
  'CENTER=St�ed'#13+
  'RIGHT=Prav�'#13+
  'ROUND RECTANGLE=Zaoblen� rohy'#13+
  'ALIGNMENT=Zarovn�n�'#13+
  'TOP=Nahoru'#13+
  'BOTTOM=Dol�'#13+
  'RIGHT=Vpravo'#13+
  'BOTTOM=Dol�'#13+
  'UNITS=Jednotky'#13+
  'PIXELS=Pixely'#13+
  'AXIS=Osy'#13+
  'AXIS ORIGIN=Po��tek osy'#13+
  'ROTATION=Oto�en�'#13+
  'CIRCLED=Zaoblen�'#13+
  '3 DIMENSIONS=3 dimenzion�ln�'#13+
  'RADIUS=Polom�r'#13+
  'ANGLE INCREMENT=P��r�stek �hlu'#13+
  'RADIUS INCREMENT=P��r�stek polom�ru'#13+
  'CLOSE CIRCLE=Uzav�en� kruh'#13+
  'PEN=Tu�ka'#13+
  'CIRCLE=Kruh'#13+
  'LABELS=Popisy'#13+
  'VISIBLE=Viditeln�'#13+
  'ROTATED=Oto�en�'#13+
  'CLOCKWISE=Vpravo'#13+
  'INSIDE=Uvnit�'#13+
  'ROMAN=Roman'#13+
  'HOURS=Hodiny'#13+
  'MINUTES=Minuty'#13+
  'SECONDS=Sekundy'#13+
  'START VALUE=Po��te�n� hodnota'#13+
  'END VALUE=Kone�n� hodnota'#13+
  'TRANSPARENCY=Pr�hlednost'#13+
  'DRAW BEHIND=Kreslit pozad�'#13+
  'COLOR MODE=Barevn� re�im'#13+
  'STEPS=Kroky'#13+
  'RANGE=Rozsah'#13+
  'PALETTE=Paleta'#13+
'PALE=Pale'#13+
  'STRONG=Siln�'#13+
  'GRID SIZE=Velikost m��ky'#13+
  'X=X'#13+
  'Z=Z'#13+
  'DEPTH=Hloubka'#13+
  'IRREGULAR=Nepravideln�'#13+
  'GRID=M��ka'#13+
  'VALUE=Hodnota'#13+
  'ALLOW DRAG=Umo�nit p�esun'#13+
  'VERTICAL POSITION=Vertik�ln� pozice'#13+
  'PEN=Pero'#13+
  'LEVELS POSITION=Pozice �rovn�'#13+
  'LEVELS=�rovn�'#13+
  'NUMBER=��slo'#13+
  'LEVEL=�rove�'#13+
  'AUTOMATIC=Automaticky'#13+
  'BOTH=Oba'#13+
  'SNAP=Uchytit'#13+
  'FOLLOW MOUSE=N�sledovat my�'#13+
'STACK=Stapel'#13+
  'HEIGHT 3D=V��ka 3D'#13+
  'LINE MODE=��rov� re�im'#13+
  'STAIRS=Schody'#13+
  'NONE=��dn�'#13+
'OVERLAP=Overlap'#13+
'STACK=Stack'#13+
'STACK 100%=Stack 100%'#13+
  'CLICKABLE=Umo�nit kliknut�'#13+
  'LABELS=Popisy'#13+
  'AVAILABLE=Dostupn�'#13+
  'SELECTED=Vybran�'#13+
  'DATASOURCE=Datov� zdroj'#13+
  'GROUP BY=Seskupit'#13+
  'CALC=Vypo��tat'#13+
  'OF=z'#13+
  'SUM=Suma'#13+
  'COUNT=Po�et'#13+
  'HIGH=Vysok�'#13+
  'LOW=N�zk�'#13+
  'AVG=Pr�m�r'#13+
  'HOUR=Hodina'#13+
  'DAY=Den'#13+
  'WEEK=T�den'#13+
  'WEEKDAY=Pracovn� den'#13+
  'MONTH=M�s�c'#13+
  'QUARTER=�tvrtlet�'#13+
  'YEAR=Rok'#13+
  'HOLE %=D�ra %'#13+
  'RESET POSITIONS=Obnovit pozice'#13+
  'MOUSE BUTTON=Tla��tko my�i'#13+
  'ENABLE DRAWING=Umo�nit kreslen�'#13+
  'ENABLE SELECT=Umo�nit v�b�r'#13+
  'ENHANCED=Roz���en�'#13+
  'ERROR WIDTH=Chyba ���ky'#13+
  'WIDTH UNITS=Jednotka ���ky'#13+
  'PERCENT=Procenta'#13+
  'PIXELS=Pixely'#13+
  'LEFT AND RIGHT=Vlevo a vpravo'#13+
  'TOP AND BOTTOM=Nahoru a dol�'#13+
  'BORDER=Okraj'#13+
  'BORDER EDITOR=Editor okraj�'#13+
  'DASH=��rka'#13+
  'DOT=Te�ka'#13+
  'DASH DOT=��rka te�ka'#13+
  'DASH DOT DOT=��rka te�ka te�ka'#13+
  'CALCULATE EVERY=Po��tat ka�d�'#13+
  'ALL POINTS=V�echny body'#13+
  'NUMBER OF POINTS=Po�et bod�'#13+
  'RANGE OF VALUES=Rozsah hodnot'#13+
  'FIRST=Prvn�'#13+
  'CENTER=St�edn�'#13+
  'LAST=Posledn�'#13+
  'TEEPREVIEW EDITOR=Editor n�hledu'#13+
  'ALLOW MOVE=Umo�nit p�esun'#13+
  'ALLOW RESIZE=Umo�nit zm�nu velikosti'#13+
  'DRAG IMAGE=P�esunout obr�zek'#13+
  'AS BITMAP=Jako bitmapu'#13+
  'SHOW IMAGE=Uk�zat obr�zek'#13+
  'DEFAULT=V�choz�'#13+
  'MARGINS=Okraje'#13+
  'SIZE=Velikost'#13+
  '3D %=3D %'#13+
  'ZOOM=Zv�t�en�'#13+
  'ROTATION=Oto�en�'#13+
  'ELEVATION=Elevace'#13+
  '100%=100%'#13+
  'HORIZ. OFFSET=Horiz. posun'#13+
  'VERT. OFFSET=Vert. posun'#13+
  'PERSPECTIVE=Perspektiva'#13+
  'ANGLE=�hel'#13+
  'ORTHOGONAL=Orthogon�ln�'#13+
  'ZOOM TEXT=Zv�t�it text'#13+
  'SCALES=Velikost'#13+
  'TITLE=Nadpis'#13+
'TICKS=Ticks'#13+
  'MINOR=Minoritn�'#13+
  'MAXIMUM=Maximum'#13+
  'MINIMUM=Minimum'#13+
  '(MAX)=(max)'#13+
  '(MIN)=(min)'#13+
  'DESIRED INCREMENT=P��r�stek'#13+
  '(INCREMENT)=(p��r�stek)'#13+
  'LOG BASE=Log. z�klad'#13+
  'LOGARITHMIC=Logaritmick�'#13+
  'TITLE=Nadpis'#13+
  'MIN. SEPARATION %=Min. rozestup %'#13+
  'MULTI-LINE=V�ce��dkov�'#13+
  'LABEL ON AXIS=Popis na ose'#13+
  'ROUND FIRST=Zaoblit'#13+
  'MARK=Zna�ka'#13+
  'LABELS FORMAT=Form�t popisu'#13+
  'EXPONENTIAL=Exponenci�ln�'#13+
  'DEFAULT ALIGNMENT=V�choz� zarovn�n�'#13+
  'LEN=D�lka'#13+
  'LENGTH=D�lka'#13+
  'AXIS=Osa'#13+
  'INNER=Vnit�n�'#13+
  'GRID=M��ka'#13+
  'AT LABELS ONLY=Pouze na popisech'#13+
  'CENTERED=Na st�ed'#13+
  'COUNT=Po�et'#13+
'TICKS=Unterticks'#13+
  'POSITION %=Pozice %'#13+
  'START %=Za��tek %'#13+
  'END %=Konec %'#13+
  'OTHER SIDE=Jin� strana'#13+
  'AXES=Osy'#13+
  'BEHIND=Pozad�'#13+
'CLIP POINTS=Clip Points'#13+
  'PRINT PREVIEW=N�hled tisku'#13+
  'MINIMUM PIXELS=Minimum pixel�'#13+
  'MOUSE BUTTON=Tla��tko my�i'#13+
  'ALLOW=Umo�nit zv�t�en�'#13+
  'ANIMATED=Animovat'#13+
  'VERTICAL=Vertik�ln�'#13+
  'RIGHT=Prav�'#13+
  'MIDDLE=St�edn�'#13+
  'ALLOW SCROLL=Umo�nit posun'#13+
  'TEEOPENGL EDITOR=Editor TeeOpenGL'#13+
  'AMBIENT LIGHT=Okoln� sv�tlo'#13+
'SHININESS=Beleuchtung'#13+
  'FONT 3D DEPTH=Hloubka 3D p�sma'#13+
  'ACTIVE=Aktivn�'#13+
  'FONT OUTLINES=Obrysov� p�smo'#13+
  'SMOOTH SHADING=Rozmazan� st�n'#13+
  'LIGHT=Sv�tlo'#13+
  'Y=Y'#13+
  'INTENSITY=Intenzita'#13+
  'BEVEL=Ze�ikmen�'#13+
  'FRAME=R�me�ek'#13+
  'ROUND FRAME=Zaoblen� r�me�ek'#13+
  'LOWERED=Sn�en�'#13+
  'RAISED=Zv��en�'#13+
  'POSITION=Pozice'#13+
  'SYMBOLS=Symboly'#13+
  'TEXT STYLE=Styl textu'#13+
  'LEGEND STYLE=Styl legendy'#13+
  'VERT. SPACING=Vertik�ln� rozestup'#13+
  'AUTOMATIC=Automatick�'#13+
  'SERIES NAMES=N�zvy s�ri�'#13+
  'SERIES VALUES=Hodnoty s�ri�'#13+
  'LAST VALUES=Posledn� hodnoty'#13+
  'PLAIN=Prost�'#13+
  'LEFT VALUE=Lev� hodnota'#13+
  'RIGHT VALUE=Prav� hodnota'#13+
  'LEFT PERCENT=Lev� procenta'#13+
  'RIGHT PERCENT=Prav� procenta'#13+
  'X VALUE=Hodnota X'#13+
  'VALUE=Hodnota'#13+
  'PERCENT=Procenta'#13+
  'X AND VALUE=X a hodnota'#13+
  'X AND PERCENT=X a procenta'#13+
  'CHECK BOXES=Za�krt�vac� pole'#13+
  'DIVIDING LINES=D�l�c� ��ry'#13+
  'FONT SERIES COLOR=Barva p�sma s�rie'#13+
  'POSITION OFFSET %=Posun pozice %'#13+
  'MARGIN=Okraj'#13+
  'RESIZE CHART=M�nit velikost'#13+
  'CUSTOM=Voliteln�'#13+
  'WIDTH UNITS=Jednotky ���ky'#13+
  'CONTINUOUS=Souvisl�'#13+
  'POINTS PER PAGE=Bod� na str�nku'#13+
  'SCALE LAST PAGE=Pom�rn� k posledn� stran�'#13+
  'CURRENT PAGE LEGEND=Legenda na t�to stran�'#13+
  'PANEL EDITOR=Editor panelu'#13+
  'BACKGROUND=Pozad�'#13+
  'BORDERS=Okraje'#13+
  'BACK IMAGE=Obr�zek na pozad�'#13+
  'STRETCH=Nat�hnout'#13+
  'TILE=Nadpis'#13+
  'CENTER=Na st�ed'#13+
  'BEVEL INNER=Vnit�n� ze�ekmen�'#13+
  'LOWERED=Sn�en�'#13+
  'RAISED=Zv��en�'#13+
  'BEVEL OUTER=Vn�j�� ze�ikmen�'#13+
  'MARKS=Zna�ky'#13+
  'DATA SOURCE=Datov� zdroj'#13+
  'SORT=T��d�n�'#13+
  'CURSOR=Kurzor'#13+
  'SHOW IN LEGEND=Zobrazit v legend�'#13+
  'FORMATS=Form�ty'#13+
  'VALUES=Hodnoty'#13+
  'PERCENTS=Procenta'#13+
  'HORIZONTAL AXIS=Horizont�ln� osa'#13+
  'TOP AND BOTTOM=Naho�e a dole'#13+
  'DATETIME=Datum/�as'#13+
  'VERTICAL AXIS=Vertik�ln� osa'#13+
  'LEFT=Lev�'#13+
  'RIGHT=Prav�'#13+
  'LEFT AND RIGHT=Lev� a prav�'#13+
  'ASCENDING=Vzestupn�'#13+
  'DESCENDING=Sestupn�'#13+
  'DRAW EVERY=Kreslit ka�d�'#13+
  'CLIPPED=Zkr�tit'#13+
  'ARROWS=�ipky'#13+
  'MULTI LINE=V�ce��dkov�'#13+
  'ALL SERIES VISIBLE=V�echny s�rie viditeln�'#13+
  'LABEL=Popis'#13+
  'LABEL AND PERCENT=Popis a procenta'#13+
  'LABEL AND VALUE=Popis a hodnota'#13+
  'PERCENT TOTAL=Celkov� procenta'#13+
  'LABEL & PERCENT TOTAL=Popis a celkov� procenta'#13+
  'X VALUE=Hodnota X'#13+
  'X AND Y VALUES=Hodnoty X a Y'#13+
  'MANUAL=Ru�n�'#13+
  'RANDOM=N�hodn�'#13+
  'FUNCTION=Funkce'#13+
  'NEW=Nov�'#13+
  'EDIT=Zm�nit'#13+
  'DELETE=Vymazat'#13+
  'PERSISTENT=Trval�'#13+
  'ADJUST FRAME=P�izp�sobit r�me�ek'#13+
  'SUBTITLE=Podnadpis'#13+
  'SUBFOOT=Podz�pat�'#13+
  'FOOT=Z�pat�'#13+
  'DELETE=Vymazat'#13+
  'VISIBLE WALLS=Viditeln� st�ny'#13+
  'BACK=Zp�t'#13+
'DIF. LIMIT=Dif. Limit'#13+
  'LINES=��ry'#13+
  'ABOVE=Nad'#13+
  'WITHIN=Uvnit�'#13+
  'BELOW=Dole'#13+
  'CONNECTING LINES=Spojovac� ��ry'#13+
  'SERIES=S�rie'#13+
'PALE=Pale'#13+
  'STRONG=Siln�'#13+
  'HIGH=Vysok�'#13+
  'LOW=N�zk�'#13+
  'BROWSE=Proch�zet'#13+
  'TILED=Dla�dice'#13+
  'INFLATE MARGINS=Vyplnit okraje'#13+
  'SQUARE=�tverec'#13+
  'DOWN TRIANGLE=Spodn� troj�heln�k'#13+
  'SMALL DOT=Mal� bod'#13+
  'DEFAULT=V�choz�'#13+
  'GLOBAL=Glob�ln�'#13+
  'SHAPES=Tvary'#13+
  'BRUSH=�t�tec'#13+
  'BRUSH=�t�tec'#13+
  'BORDER=Okraj'#13+
  'COLOR=Barva'#13+
  'DELAY=Prodleva'#13+
  'MSEC.=ms'#13+
  'MOUSE ACTION=Akce my�i'#13+
  'MOVE=P�esunout'#13+
  'CLICK=Klik'#13+
  'BRUSH=�t�tec'#13+
  'DRAW LINE=Kreslit ��ru'#13+
  'BORDER EDITOR=Editor okraje'#13+
  'DASH=��rka'#13+
  'DOT=Te�ka'#13+
  'DASH DOT=��rka te�ka'#13+
  'DASH DOT DOT=��rka te�ka te�ka'#13+
  'EXPLODE BIGGEST=Nejv�t�� zv�t�en�'#13+
  'TOTAL ANGLE=Celkov� �hel'#13+
  'GROUP SLICES=Seskupov�n�'#13+
  'BELOW %=Spodn� %'#13+
  'BELOW VALUE=Spodn� hodnota'#13+
  'OTHER=Ostatn�'#13+
  'PATTERNS=V�pln�'#13+
  'CLOSE CIRCLE=Zav��t kruh'#13+
  'VISIBLE=Viditeln�'#13+
  'CLOCKWISE=Pravoto�iv�'#13+
  'SIZE %=Velikost %'#13+
  'PATTERN=V�pl�'#13+
  'DEFAULT=V�choz�'#13+
  'SERIES DATASOURCE TEXT EDITOR=Editor textov�ch zdroj� s�rie'#13+
  'FIELDS=Pole'#13+
  'NUMBER OF HEADER LINES=Po�et �ar z�hlav�'#13+
  'SEPARATOR=Odd�lova�'#13+
  'COMMA=��rka'#13+
  'SPACE=Mezera'#13+
  'TAB=Tabul�tor'#13+
  'FILE=Soubor'#13+
  'WEB URL=Web URL'#13+
  'LOAD=Na��st'#13+
  'C LABELS=Popisy C'#13+
  'R LABELS=Popisy R'#13+
  'C PEN=Tu�ka C'#13+
  'R PEN=Tu�ka R'#13+
'STACK GROUP=Stapel gruppieren'#13+
  'USE ORIGIN=Pou��t po��tek'#13+
  'MULTIPLE BAR=V�cesloupcov�'#13+
  'SIDE=Strana'#13+
'STACKED 100%=Stacked 100%'#13+
  'SIDE ALL=V�echny st�ny'#13+
  'BRUSH=�t�tec..'#13+
  'DRAWING MODE=Kresl�c� re�im'#13+
  'SOLID=Pln�'#13+
  'WIREFRAME=Tenk� r�me�ek'#13+
  'DOTFRAME=Bodov� r�me�ek'#13+
  'SMOOTH PALETTE=Paleta rozmaz�n�'#13+
  'SIDE BRUSH=Stranov� �t�tec'#13+
  'ABOUT TEECHART PRO V7.0=O TeeChart Pro v7.0'#13+
  'ALL RIGHTS RESERVED.=V�echna pr�va vyhrazena.'#13+
  'VISIT OUR WEB SITE !=Nav�tivt� n� web!'#13+
  'TEECHART WIZARD=Pr�vodce TeeChart'#13+
  'SELECT A CHART STYLE=Vyberte styl grafu'#13+
  'DATABASE CHART=Datab�zov� graf'#13+
  'NON DATABASE CHART=Nedatab�zov� graf'#13+
  'SELECT A DATABASE TABLE=Vyberte tabulku datab�ze'#13+
  'ALIAS=Alias'#13+
  'TABLE=Tabulka'#13+
  'SOURCE=Zdroj'#13+
  'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
  'MICROSOFT ADO=Microsoft ADO'#13+
  'SELECT THE DESIRED FIELDS TO CHART=Vyberte po�adovan� pole pro graf'#13+
  'SELECT A TEXT LABELS FIELD=Vyberte polo�ku textov�ho popisu'#13+
  'CHOOSE THE DESIRED CHART TYPE=Vyberte po�adovan� typ grafu'#13+
  '2D=2D'#13+
  'CHART PREVIEW=N�hled grafu'#13+
  'SHOW LEGEND=Uk�zat legendu'#13+
  'SHOW MARKS=Uk�zat zna�ky'#13+
  '< BACK=< Zp�t'#13+
  'SELECT A CHART STYLE=Vyberte styl grafu'#13+
  'NON DATABASE CHART=Nedatab�zov� graf'#13+
  'SELECT A DATABASE TABLE=Vyberte tabulku datab�ze'#13+
  'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
  'SELECT THE DESIRED FIELDS TO CHART=Vyberte po�adovan� pole pro graf'#13+
  'SELECT A TEXT LABELS FIELD=Vyberte pole textov�ho popisu'#13+
  'CHOOSE THE DESIRED CHART TYPE=Vyberte po�adovan� typ grafu'#13+
  'EXPORT CHART=Export grafu'#13+
  'PICTURE=Obr�zek'#13+
  'NATIVE=Soubor TeeChart'#13+
  'KEEP ASPECT RATIO=Zachovat pom�ry'#13+
  'INCLUDE SERIES DATA=V�etn� dat s�ri�'#13+
  'FILE SIZE=Velikost souboru'#13+
  'DELIMITER=Odd�lova�'#13+
  'XML=XML'#13+
  'HTML TABLE=Tabulka HTML'#13+
  'EXCEL=Excel'#13+
  'TAB=Tab'#13+
  'COLON=Dvojte�ka'#13+
  'INCLUDE=Vlo�it'#13+
  'POINT LABELS=Popisy bod�'#13+
  'POINT INDEX=Seznam bod�'#13+
  'HEADER=Hlavi�ka'#13+
  'COPY=Kop�rovat'#13+
  'SAVE=Ulo�it'#13+
  'SEND=Odeslat'#13+
  'KEEP ASPECT RATIO=Zachovat pom�r'#13+
  'INCLUDE SERIES DATA=V�etn� dat s�ri�'#13+
  'FUNCTIONS=Funkce'#13+
  'ADD=P�id�n�'#13+
  'ADX=ADX'#13+
  'AVERAGE=Pr�m�r'#13+
'BOLLINGER=Bollinger'#13+
  'COPY=Kopie'#13+
  'DIVIDE=D�len�'#13+
  'EXP. AVERAGE=Exp. pr�m�r'#13+
  'EXP.MOV.AVRG.=Exp. posunut� pr�m�r'#13+
  'HIGH=Vysok�'#13+
  'LOW=N�zk�'#13+
  'MACD=MACD'#13+
  'MOMENTUM=Hybnost'#13+
  'MOMENTUM DIV=Pod�l hybnosti'#13+
  'MOVING AVRG.=Posunut� pr�m�r'#13+
  'MULTIPLY=N�soben�'#13+
  'R.S.I.=R.S.I.'#13+
  'ROOT MEAN SQ.=Ko�en znamen� �tverec'#13+
  'STD.DEVIATION=Standardn� odchylka'#13+
  'STOCHASTIC=N�hodn�'#13+
  'SUBTRACT=Rozd�l'#13+
  'APPLY=Pou��t'#13+
  'SOURCE SERIES=Zdrojov� s�rie'#13+
  'TEECHART GALLERY=galerie TeeChart'#13+
  'FUNCTIONS=Funkce'#13+
  'DITHER=P�epo�et'#13+
  'REDUCTION=Redukce'#13+
  'COMPRESSION=Komprese'#13+
  'LZW=LZW'#13+
  'RLE=RLE'#13+
  'NEAREST=Nejbli���'#13+
  'FLOYD STEINBERG=Floyd Steinberg'#13+
  'STUCKI=Stucki'#13+
  'SIERRA=Sierra'#13+
  'JAJUNI=JaJuNI'#13+
  'STEVE ARCHE=Steve Arche'#13+
  'BURKES=Burkes'#13+
  'WINDOWS 20=Windows 20'#13+
  'WINDOWS 256=Windows 256'#13+
  'WINDOWS GRAY=Windows �edi'#13+
  'MONOCHROME=�ernob�le'#13+
  'GRAY SCALE=Odst�ny �edi'#13+
  'NETSCAPE=Netscape'#13+
  'QUANTIZE=Kvantovan�'#13+
  'QUANTIZE 256=Kvantovan� 256'#13+
  '% QUALITY=% kvality'#13+
  'GRAY SCALE=Odst�ny �edi'#13+
  'PERFORMANCE=V�kon'#13+
  'QUALITY=Kvalita'#13+
  'SPEED=Rychlost'#13+
  'COMPRESSION LEVEL=�rove� komprese'#13+
  'CHART TOOLS GALLERY=Galerie n�stroj� grafu'#13+
  'ANNOTATION=Anotace'#13+
  'AXIS ARROWS=�ipky osy'#13+
  'COLOR BAND=Skupina barev'#13+
  'COLOR LINE=Kurzor'#13+
  'CURSOR=Kurzor'#13+
  'DRAG MARKS=P�esunout zna�ky'#13+
  'DRAW LINE=Kreslit ��ru'#13+
  'IMAGE=Obr�zek'#13+
  'MARK TIPS=Tipy zna�ek'#13+
  'NEAREST POINT=Nejbli��� bod'#13+
  'ROTATE=Oto�it'#13+
  'CHART TOOLS GALLERY=Galerie n�stroj� grafu'#13+
  'BRUSH=�t�tec'#13+
  'DRAWING MODE=Kresl�c� re�im'#13+
  'WIREFRAME=Tenk� okraj'#13+
  'SMOOTH PALETTE=Paleta rozmaz�n�'#13+
  'SIDE BRUSH=Stranov� �t�tec'#13+
  'YES=Ano'#13
;
  end;
end;

Procedure TeeSetCzech;
begin
  TeeCreateCzech;
  TeeLanguage:=TeeCzechLanguage;
  TeeCzechConstants;
end;

initialization
finalization
  FreeAndNil(TeeCzechLanguage);
end.

