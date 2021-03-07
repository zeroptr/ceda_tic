unit TeeMexican;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeMexicanLanguage:TStringList=nil;

Procedure TeeSetMexican;
Procedure TeeCreateMexican;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeMexicanConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 por David Berneda'; { 5.01 }
  TeeMsg_LegendFirstValue   :='Valor de primera leyenda debe ser > 0';
  TeeMsg_LegendColorWidth   :='Ancho de Color de leyenda > 0%';
  TeeMsg_SeriesSetDataSource:='No hay Gr�fico padre para validar DataSource';
  TeeMsg_SeriesInvDataSource:='DataSource no v�lido: %s';
  TeeMsg_FillSample         :='Rellenar valores ejemplo, n�mero de valores debe ser > 0';
  TeeMsg_AxisLogDateTime    :='Eje Fecha/Hora no puede ser Logar�tmico';
  TeeMsg_AxisLogNotPositive :='Valores Min y Max de Eje Logar�tmico deben ser >= 0';
  TeeMsg_AxisLabelSep       :='% Separaci�n de etiquetas debe ser > 0';
  TeeMsg_AxisIncrementNeg   :='Incremento de eje debe ser >= 0';
  TeeMsg_AxisMinMax         :='Valor m�nimo de eje debe ser <= M�nimo';
  TeeMsg_AxisMaxMin         :='Valor m�ximo de eje debe ser >= M�nimo';
  TeeMsg_AxisLogBase        :='Base de eje logar�tmico debe ser >= 2';
  TeeMsg_MaxPointsPerPage   :='N�mero de puntos por p�gina debe ser >= 0';
  TeeMsg_3dPercent          :='% Efecto 3D debe estar entre %d y %d';
  TeeMsg_CircularSeries     :='No se permiten referencias circulares de series';
  TeeMsg_WarningHiColor     :='Para una mejor visualizaci�n se requiere color de 16k';

  TeeMsg_DefaultPercentOf   :='%s de %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'de %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='T�tulo Eje';
  TeeMsg_AxisLabels         :='Etiquetas Eje';
  TeeMsg_RefreshInterval    :='Intervalo de refresco debe estar entre 0 y 60';
  TeeMsg_SeriesParentNoSelf :='�El Series.ParentChart no soy yo!';
  TeeMsg_GalleryLine        :='L�nea';
  TeeMsg_GalleryPoint       :='Punto';
  TeeMsg_GalleryArea        :='Area';
  TeeMsg_GalleryBar         :='Barra';
  TeeMsg_GalleryHorizBar    :='Barra Horiz.';
  TeeMsg_Stack              :='Apilado';
  TeeMsg_GalleryPie         :='Pastel';
  TeeMsg_GalleryCircled     :='Circular';
  TeeMsg_GalleryFastLine    :='L�nea r�pida';
  TeeMsg_GalleryHorizLine   :='L�nea Horiz.';

  TeeMsg_PieSample1         :='Coches';
  TeeMsg_PieSample2         :='Tel�fonos';
  TeeMsg_PieSample3         :='Tablas';
  TeeMsg_PieSample4         :='Monitores';
  TeeMsg_PieSample5         :='L�mparas';
  TeeMsg_PieSample6         :='Teclados';
  TeeMsg_PieSample7         :='Bicis';
  TeeMsg_PieSample8         :='Sillas';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editando %s';

  TeeMsg_GalleryStandard    :='Estandard';
  TeeMsg_GalleryExtended    :='Extendidas';
  TeeMsg_GalleryFunctions   :='Funciones';

  TeeMsg_EditChart          :='E&ditar Gr�fico...';
  TeeMsg_PrintPreview       :='&Previsualizar...';
  TeeMsg_ExportChart        :='E&xportar Gr�fico...';
  TeeMsg_CustomAxes         :='Ejes Personalizados...';

  TeeMsg_InvalidEditorClass :='%s: Clase Editor no v�lida: %s';
  TeeMsg_MissingEditorClass :='%s: no tiene cuadro de edici�n';

  TeeMsg_GalleryArrow       :='Flecha';

  TeeMsg_ExpFinish          :='&Finalizar';
  TeeMsg_ExpNext            :='&Siguiente >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Dise�o';
  TeeMsg_GanttSample2       :='Prototipo';
  TeeMsg_GanttSample3       :='Desarrollo';
  TeeMsg_GanttSample4       :='Ventas';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testear';
  TeeMsg_GanttSample7       :='Manufac.';
  TeeMsg_GanttSample8       :='Debugando';
  TeeMsg_GanttSample9       :='Nueva Versi�n';
  TeeMsg_GanttSample10      :='Finanzas';

  TeeMsg_ChangeSeriesTitle  :='Cambiar T�tulo de Series';
  TeeMsg_NewSeriesTitle     :='Nuevo T�tulo de Serie:';
  TeeMsg_DateTime           :='Fecha/Hora';
  TeeMsg_TopAxis            :='Eje superior';
  TeeMsg_BottomAxis         :='Eje inferior';
  TeeMsg_LeftAxis           :='Eje izquierdo';
  TeeMsg_RightAxis          :='Eje derecho';

  TeeMsg_SureToDelete       :='�Eliminar  %s?';
  TeeMsg_DateTimeFormat     :='For&mato Fecha/Hora:';
  TeeMsg_Default            :='Defecto';
  TeeMsg_ValuesFormat       :='For&mato Valores:';
  TeeMsg_Maximum            :='M�ximo';
  TeeMsg_Minimum            :='M�nimo';
  TeeMsg_DesiredIncrement   :='Incremento Deseado %s';

  TeeMsg_IncorrectMaxMinValue:='Valor incorrecto. %s';
  TeeMsg_EnterDateTime      :='Introduzca [N� de d�as] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='�Aplicar cambios?';
  TeeMsg_SelectedSeries     :='(Series Seleccionadas)';
  TeeMsg_RefreshData        :='&Refrescar datos';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='419';
  TeeMsg_FunctionAdd        :='Sumar';
  TeeMsg_FunctionSubtract   :='Restar';
  TeeMsg_FunctionMultiply   :='Multiplicar';
  TeeMsg_FunctionDivide     :='Dividir';
  TeeMsg_FunctionHigh       :='Alto';
  TeeMsg_FunctionLow        :='Bajo';
  TeeMsg_FunctionAverage    :='Media';

  TeeMsg_GalleryShape       :='Forma';
  TeeMsg_GalleryBubble      :='Burbujas';
  TeeMsg_FunctionNone       :='Copiar';

  TeeMsg_None               :='(ninguno)';

  TeeMsg_PrivateDeclarations:='{ Declaraciones privadas }';
  TeeMsg_PublicDeclarations :='{ Declaraciones p�blicas }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Tama�o de puntero debe ser mayor que cero';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_About              :='&Acerca de TeeChart...';

  TeeMsg_DataSet            :='Tabla/consulta';
  TeeMsg_AskDataSet         :='&Tabla/consulta:';

  TeeMsg_SingleRecord       :='Registro �nico';
  TeeMsg_AskDataSource      :='&Fuente de datos:';

  TeeMsg_Summary            :='Sumario';

  TeeMsg_FunctionPeriod     :='El periodo de la funci�n debe ser >= 0';

  TeeMsg_TeeChartWizard     :='Asistente TeeChart';

  TeeMsg_ClearImage         :='Quita&r';
  TeeMsg_BrowseImage        :='&Abrir...';

  TeeMsg_WizardSureToClose  :='�Est� seguro de cerrar el Asistente TeeChart?';
  TeeMsg_FieldNotFound      :='El campo %s no existe';

  TeeMsg_DepthAxis          :='Eje Prof.';
  TeeMsg_PieOther           :='Otro';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pastel';
  TeeMsg_ValuesBar          :='Barra';
  TeeMsg_ValuesAngle        :='Angulo';
  TeeMsg_ValuesGanttStart   :='Comienzo';
  TeeMsg_ValuesGanttEnd     :='Fin';
  TeeMsg_ValuesGanttNextTask:='ProxTarea';
  TeeMsg_ValuesBubbleRadius :='Radio';
  TeeMsg_ValuesArrowEndX    :='Fin X';
  TeeMsg_ValuesArrowEndY    :='Fin Y';
  TeeMsg_Legend             :='Leyenda';
  TeeMsg_Title              :='T�tulo';
  TeeMsg_Foot               :='Pie';
  TeeMsg_Period		    :='Periodo';
  TeeMsg_PeriodRange        :='Rango Periodo';
  TeeMsg_CalcPeriod         :='Calcular %s cada:';
  TeeMsg_SmallDotsPen       :='Puntitos';

  TeeMsg_InvalidTeeFile     :='Gr�fico no v�lido en archivo *.'+TeeMsg_TeeExtension;
  TeeMsg_WrongTeeFileFormat :='Formato de archivo *.'+TeeMsg_TeeExtension+' incorrecto.';
  TeeMsg_EmptyTeeFile       :='Archivo *.'+TeeMsg_TeeExtension+' vacio.';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'Ejes Gr�fico';
  TeeMsg_ChartAxesCategoryDesc   := 'Propiedades y Eventos de Ejes';
  TeeMsg_ChartWallsCategoryName  := 'Paredes del Gr�fico';
  TeeMsg_ChartWallsCategoryDesc  := 'Propiedades y Eventos de la pared del gr�fico';
  TeeMsg_ChartTitlesCategoryName := 'T�tulos del Gr�fico';
  TeeMsg_ChartTitlesCategoryDesc := 'Eventos y propiedades del t�tulo del gr�fico';
  TeeMsg_Chart3DCategoryName     := 'Gr�fico 3D';
  TeeMsg_Chart3DCategoryDesc     := 'Propiedades y eventos del gr�fico 3D';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Personalizado ';
  TeeMsg_Series                 :='Series';
  TeeMsg_SeriesList             :='Series...';

  TeeMsg_PageOfPages            :='P�gina %d de %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='Primero';
  TeeMsg_Prior  :='Anterior';
  TeeMsg_Next   :='Siguiente';
  TeeMsg_Last   :='�ltimo';
  TeeMsg_Insert :='Insertar';
  TeeMsg_Delete :='Eliminar';
  TeeMsg_Edit   :='Editar';
  TeeMsg_Post   :='Guardar';
  TeeMsg_Cancel :='Cancelar';

  TeeMsg_All    :='(todas)'; {las series}
  TeeMsg_Index  :='Indice';
  TeeMsg_Text   :='Texto';

  TeeMsg_AsBMP        :='como &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='como &Metafile';
  TeeMsg_EMFFilter    :='Metafiles mejorados (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'La propiedad Panel no est� asignada.';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='Sin Borde';
  TeeMsg_Dotted    :='Puntos';
  TeeMsg_Colors    :='Colores';
  TeeMsg_Filled    :='Relleno';
  TeeMsg_Marks     :='Marcas';
  TeeMsg_Stairs    :='Escaleras';
  TeeMsg_Points    :='Puntos';
  TeeMsg_Height    :='Altura';
  TeeMsg_Hollow    :='Hueco';
  TeeMsg_Point2D   :='Punto 2D';
  TeeMsg_Triangle  :='Tri�ngulos';
  TeeMsg_Star      :='Estrella';
  TeeMsg_Circle    :='Circulo';
  TeeMsg_DownTri   :='Tri. Bajo';
  TeeMsg_Cross     :='Cruz';
  TeeMsg_Diamond   :='Diamante';
  TeeMsg_NoLines   :='Sin l�neas';
  TeeMsg_Stack100  :='Apilado 100%';
  TeeMsg_Pyramid   :='Pir�mide';
  TeeMsg_Ellipse   :='Elipse';
  TeeMsg_InvPyramid:='Pir�mide Inv.';
  TeeMsg_Sides     :='Caras';
  TeeMsg_SideAll   :='Todas las caras';
  TeeMsg_Patterns  :='Patrones';
  TeeMsg_Exploded  :='Expandido';
  TeeMsg_Shadow    :='Sombra';
  TeeMsg_SemiPie   :='Semi Tarta';
  TeeMsg_Rectangle :='Rect�ngulo';
  TeeMsg_VertLine  :='L�n.Vert.';
  TeeMsg_HorizLine :='L�n.Horiz.';
  TeeMsg_Line      :='L�nea';
  TeeMsg_Cube      :='Cubo';
  TeeMsg_DiagCross :='Aspa';

  TeeMsg_CanNotFindTempPath    :='No se puede localizar la carpeta Temp';
  TeeMsg_CanNotCreateTempChart :='No se puede crear archivo Temp';
  TeeMsg_CanNotEmailChart      :='No se puede enviar Gr�fico por correo elec. Error Mapi: %d';

  TeeMsg_SeriesDelete :='Borrar Series: Indice de Series fuera de l�mites %d (0 a %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Lenguaje...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Vela';
  TeeMsg_GalleryVolume      :='Volumen';
  TeeMsg_GallerySurface     :='Superf�cie';
  TeeMsg_GalleryContour     :='Contorno';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Puntos 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Barras 3D';
  TeeMsg_GalleryBigCandle   :='Vela Grande';
  TeeMsg_GalleryLinePoint   :='Punto L�nea';
  TeeMsg_GalleryHistogram   :='Histograma';
  TeeMsg_GalleryWaterFall   :='Caida de Agua';
  TeeMsg_GalleryWindRose    :='Rosa de Vientos';
  TeeMsg_GalleryClock       :='Reloj';
  TeeMsg_GalleryColorGrid   :='Rejilla de Color';
  TeeMsg_GalleryBoxPlot     :='Esquema Vertical';
  TeeMsg_GalleryHorizBoxPlot:='Esquema Horizontal';
  TeeMsg_GalleryBarJoin     :='Union de Barras';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pir�mide';
  TeeMsg_GalleryMap         :='Mapa';

  TeeMsg_PolyDegreeRange     :='El grado polinomial debe estar entre 1 y 20';
  TeeMsg_AnswerVectorIndex   :='El �ndice de matriz de vectores debe estar entre 1 y %d';
  TeeMsg_FittingError        :='No es posible calcular el ajuste';
  TeeMsg_PeriodRange         :='El periodo debe ser >= 0';
  TeeMsg_ExpAverageWeight    :='Peso de Promedio Exp. debe estar entre 0 y 1';
  TeeMsg_GalleryErrorBar     :='Barras de Error';
  TeeMsg_GalleryError        :='Error';
  TeeMsg_GalleryHighLow      :='Alto-Bajo';
  TeeMsg_FunctionMomentum    :='Momento';
  TeeMsg_FunctionMomentumDiv :='Mom. Divisi�n';
  TeeMsg_FunctionExpAverage  :='Promedio Exp.';
  TeeMsg_FunctionMovingAverage:='Media M�vil';
  TeeMsg_FunctionExpMovAve   :='Media M�vil Exp.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Ajuste a Curva';
  TeeMsg_FunctionTrend       :='Tendencia';
  TeeMsg_FunctionExpTrend    :='Tendencia Exp.';
  TeeMsg_FunctionLogTrend    :='Tendencia Logar�tm.';
  TeeMsg_FunctionCumulative  :='Acumular';
  TeeMsg_FunctionStdDeviation:='Desviaci�n Estand.';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Raiz Media Cuad.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Estoc�stico';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='Contar';
  TeeMsg_LoadChart           :='Abrir TeeChart...';
  TeeMsg_SaveChart           :='Guardar TeeChart...';
  TeeMsg_TeeFiles            :='Archivos TeeChart Pro';

  TeeMsg_GallerySamples      :='Otras';
  TeeMsg_GalleryStats        :='Estad�sticas';

  TeeMsg_CannotFindEditor    :='No puedo localizar el formulario %s';

  TeeMsg_CannotLoadChartFromURL:='C�digo de error: %d descargando gr�fico de Web: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='C�digo de error: %d descargando datos de series de Web: %s';

  TeeMsg_Test                :='Test...';

  TeeMsg_ValuesDate          :='Fecha';
  TeeMsg_ValuesOpen          :='Apertura';
  TeeMsg_ValuesHigh          :='Alto';
  TeeMsg_ValuesLow           :='Bajo';
  TeeMsg_ValuesClose         :='Cierre';
  TeeMsg_ValuesOffset        :='Desplazar';
  TeeMsg_ValuesStdError      :='Error Est.';

  TeeMsg_Grid3D              :='Rejilla3D';

  TeeMsg_LowBezierPoints     :='N�mero de puntos Bezier debe ser > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Editar';
  TeeCommanMsg_Print    :='Imprimir';
  TeeCommanMsg_Copy     :='Copiar';
  TeeCommanMsg_Save     :='Guardar';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotaci�n: %d� Elevaci�n: %d�';
  TeeCommanMsg_Rotate   :='Rotar';

  TeeCommanMsg_Moving   :='Desp.Horiz.: %d Desp.Vert.: %d';
  TeeCommanMsg_Move     :='Mover';

  TeeCommanMsg_Zooming  :='Ampliar: %d %%';
  TeeCommanMsg_Zoom     :='Ampliar';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Profundidad'; { 5.01 }

  TeeCommanMsg_Chart    :='Chart';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Arrastrar %s para Rotar'; { 5.01 }
  TeeCommanMsg_MoveLabel  :='Arrastrar %s para Mover'; { 5.01 }
  TeeCommanMsg_ZoomLabel  :='Arrastrar %s para Zoom'; { 5.01 }
  TeeCommanMsg_DepthLabel :='Arrastrar %s para Profundidad 3D'; { 5.01 }

  TeeCommanMsg_NormalLabel:='Arrastrar bot�n izq. para ampliar, der. para desplazar';
  TeeCommanMsg_NormalPieLabel:='Arrastrar Porci�n de Pastel para expandir.';

  TeeCommanMsg_PieExploding := 'Porci�n: %d Expandida: %d %%';

  TeeMsg_TriSurfaceLess:='N�mero de puntos debe ser >= 4';
  TeeMsg_TriSurfaceAllColinear:='Todos los puntos estan alineados.';
  TeeMsg_TriSurfaceSimilar:='Puntos similares - no se pueden calcular tri�ngulos.';
  TeeMsg_GalleryTriSurface:='Sup. Tri�ng.';

  TeeMsg_AllSeries := 'Todas las Series';
  TeeMsg_Edit      := 'Editar';

  TeeMsg_GalleryFinancial    :='Financieras';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Arrastrar Marcas'; { 5.01 }
  TeeMsg_AxisArrowTool :='Flechas en Ejes';
  TeeMsg_DrawLineTool  :='Dibujar L�neas';
  TeeMsg_NearestTool   :='Punto m�s cercano';
  TeeMsg_ColorBandTool :='Bandas de color';
  TeeMsg_ColorLineTool :='L�neas de color';
  TeeMsg_RotateTool    :='Rotar';
  TeeMsg_ImageTool     :='Imagen';
  TeeMsg_MarksTipTool  :='Marcas';
  TeeMsg_AnnotationTool:='Anotaci�n';

  TeeMsg_CantDeleteAncestor  :='No puedo eliminar componente heredado. (Ancestor)';

  TeeMsg_Load	         :='Cargar...';
  TeeMsg_NoSeriesSelected:='No hay Series seleccionadas';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Chart';
  TeeMsg_CategorySeriesActions :='Chart Series';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Intercambiar 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Activo';
  TeeMsg_ActionSeriesActiveHint :='Mostrar / Ocultar Series';
  TeeMsg_ActionEditHint         :='Editar Gr�fico';
  TeeMsg_ActionEdit             :='&Editar...';
  TeeMsg_ActionCopyHint         :='Copiar al portapapeles';
  TeeMsg_ActionCopy             :='&Copiar';
  TeeMsg_ActionPrintHint        :='Previsualizaci�n de gr�fico';
  TeeMsg_ActionPrint            :='&Imprimir...';
  TeeMsg_ActionAxesHint         :='Mostrar / Ocultar Ejes';
  TeeMsg_ActionAxes             :='&Ejes';
  TeeMsg_ActionGridsHint        :='Mostrar / Ocultar rejilla';
  TeeMsg_ActionGrids            :='&Rejillas';
  TeeMsg_ActionLegendHint       :='Mostrar / Ocultar leyenda';
  TeeMsg_ActionLegend           :='&Leyenda';
  TeeMsg_ActionSeriesEditHint   :='Editar Series';
  TeeMsg_ActionSeriesMarksHint  :='Mostrar / Ocultar marcas de series';
  TeeMsg_ActionSeriesMarks      :='&Marcas';
  TeeMsg_ActionSaveHint         :='Guardar Gr�fico';
  TeeMsg_ActionSave             :='&Guardar...';

  TeeMsg_CandleBar              :='Barras';
  TeeMsg_CandleNoOpen           :='Sin Apertura';
  TeeMsg_CandleNoClose          :='Sin Cierre';
  TeeMsg_NoLines                :='Sin L�neas';
  TeeMsg_NoHigh                 :='Sin valor Alto';
  TeeMsg_NoLow                  :='Sin valor Bajo';
  TeeMsg_ColorRange             :='Rango de Color';
  TeeMsg_WireFrame              :='Alambres';
  TeeMsg_DotFrame               :='Puntos';
  TeeMsg_Positions              :='Posiciones';
  TeeMsg_NoGrid                 :='Sin rejilla';
  TeeMsg_NoPoint                :='Sin punto';
  TeeMsg_NoLine                 :='Sin l�nea';
  TeeMsg_Labels                 :='Etiquetas';
  TeeMsg_NoCircle               :='Sin circulo';
  TeeMsg_Lines                  :='L�neas';
  TeeMsg_Border                 :='Borde';

  TeeMsg_SmithResistance      :='Resistencia';
  TeeMsg_SmithReactance       :='Reactancia';

  TeeMsg_Column  :='Columna';

  { 5.01 }
  TeeMsg_Separator            :='Separador';
  TeeMsg_FunnelSegment        :='Segmento ';
  TeeMsg_FunnelSeries         :='Embudo';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Rebasar cuota';
  TeeMsg_FunnelWithin         :=' entre cuota';
  TeeMsg_FunnelBelow          :=' o debajo de cuota';
  TeeMsg_CalendarSeries       :='Calendario';
  TeeMsg_DeltaPointSeries     :='Tendencias';
  TeeMsg_ImagePointSeries     :='Imagen Punto';
  TeeMsg_ImageBarSeries       :='Imagen Barra';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: El campo debe ser mayor que zero.';

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
  TeeMsg_Origin               := 'Origen';
  TeeMsg_Transparency         := 'Transparencia';
  TeeMsg_Box		      := 'Caja';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := 'N�m P�gina';
  TeeMsg_TextFile             := 'Archivos Texto';

  { 5.03 }
  TeeMsg_Gradient             :='Gradiente';
  TeeMsg_WantToSave           :='�Desea guardar %s?';

  TeeMsg_Property            :='Propiedad';
  TeeMsg_Value               :='Valor';
  TeeMsg_Yes                 :='S�';
  TeeMsg_No                  :='No';
  TeeMsg_Image                :='(imagen)';

  TeeMsg_DragPoint            :='Arrastrar Puntos';
  TeeMsg_OpportunityValues    :='OpportunityValues';
  TeeMsg_QuoteValues          :='QuoteValues';

  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'Versi�n ActiveX ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'No se puede importar TeeChart desde %s';
  TeeMsg_ActiveXVerbPrint    := 'Vista &Preliminar...';
  TeeMsg_ActiveXVerbExport   := 'E&xportar...';
  TeeMsg_ActiveXVerbImport   := '&Importar...';
  TeeMsg_ActiveXVerbHelp     := 'Ayu&da...';
  TeeMsg_ActiveXVerbAbout    := '&Acerca de TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Codigo error: %d downloading: %s';
  TeeMsg_DatasourceError     := 'El Datsource no es una Series o Recordset';
  TeeMsg_SeriesTextSrcError  := 'Tipo de Series invalido';
  TeeMsg_AxisTextSrcError    := 'Tipo de Eje invalido';
  TeeMsg_DelSeriesDatasource := '�Esta seguro que quiere borrar %s ?';
  TeeMsg_OCXNoPrinter        := 'No hay una ninguna impresora instalada por omissi�n';
  TeeMsg_ActiveXPictureNotValid:='Imagen no valida';
  {$ENDIF}

  { 6.0 }
  TeeMsg_AsPDF            :='como &PDF';
  TeeMsg_PDFFilter        :='Archivos PDF (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='como PostScript';
  TeeMsg_PSFilter         :='Archivos PostScript (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Area'#13'Horizontal';
  TeeMsg_SelfStack        :='Apilado �l mismo';
  TeeMsg_DarkPen          :='Borde oscuro';
  TeeMsg_SelectFolder     :='Seleccione carpeta base datos';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Conexi�n:';

  TeeMsg_FunctionSmooth       :='Suavizado';
  TeeMsg_FunctionCross        :='Puntos de corte';
  TeeMsg_GridTranspose        :='Invertir matriz 3D';
  TeeMsg_FunctionCompress     :='Compresi�n';
  TeeMsg_ExtraLegendTool      :='Leyenda Extra';
  TeeMsg_FunctionCLV          :='Close Location'#13'Value';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Animaci�n de Series';
  TeeMsg_GalleryPointFigure   :='Punto y Figura';
  TeeMsg_Up                   :='Arriba';
  TeeMsg_Down                 :='Abajo';
  TeeMsg_GanttTool            :='Arrastre Gantt';
  TeeMsg_XMLFile              :='Archivo XML';
  TeeMsg_GridBandTool         :='Bandas de rejilla';
  TeeMsg_FunctionPerf         :='Rendimiento';
  TeeMsg_GalleryGauge         :='Indicador';
  TeeMsg_GalleryGauges        :='Indicadores';
  TeeMsg_GalleryVector3D      :='Vector 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Torre';
  TeeMsg_SingleColor          :='Un solo color';
  TeeMsg_Cover                :='Cubierta';
  TeeMsg_Cone                 :='Cono';
  TeeMsg_PieTool              :='Porciones Pastel';
end;

Procedure TeeCreateMexican;
begin
  if not Assigned(TeeMexicanLanguage) then
  begin
    TeeMexicanLanguage:=TStringList.Create;
    TeeMexicanLanguage.Text:=

'LABELS=Textos'+#13+
'DATASET=Tabla'+#13+
'ALL RIGHTS RESERVED.=Todos los Derechos Reservados.'+#13+
'APPLY=Aplicar'+#13+
'CLOSE=Cerrar'+#13+
'OK=Aceptar'+#13+
'ABOUT TEECHART PRO V7.0=Acerca de TeeChart Pro v7.0'+#13+
'OPTIONS=Opciones'+#13+
'FORMAT=Formato'+#13+
'TEXT=Texto'+#13+
'GRADIENT=Gradiente'+#13+
'SHADOW=Sombra'+#13+
'POSITION=Posici�n'+#13+
'LEFT=Izquierda'+#13+
'TOP=Arriba'+#13+
'CUSTOM=Person.'+#13+
'PEN=L�piz'+#13+
'PATTERN=Trama'+#13+
'SIZE=Tama�o'+#13+
'BEVEL=Marco'+#13+
'INVERTED=Invertido'+#13+
'INVERTED SCROLL=Desplaz. Invertido'+#13+
'BORDER=Borde'+#13+
'ORIGIN=Origen'+#13+
'USE ORIGIN=Usar Origen'+#13+
'AREA LINES=L�neas Area'+#13+
'AREA=Area'+#13+
'COLOR=Color'+#13+
'SERIES=Series'+#13+
'SUM=Suma'+#13+
'DAY=Dia'+#13+
'QUARTER=Trimestre'+#13+
'(MAX)=(max)'+#13+
'(MIN)=(min)'+#13+
'VISIBLE=Visible'+#13+
'CURSOR=Cursor'+#13+
'GLOBAL=Global'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=L�nea Horiz.'+#13+
'LABEL AND PERCENT=Etiqueta y Porcentaje'+#13+
'LABEL AND VALUE=Etiqueta y Valor'+#13+
'LABEL AND PERCENT TOTAL=Etiqueta Porc. Total'+#13+
'PERCENT TOTAL=Total Porcentaje'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=Restar'+#13+
'MULTIPLY=Multiplicar'+#13+
'DIVIDE=Dividir'+#13+
'STAIRS=Escaleras'+#13+
'MOMENTUM=Momento'+#13+
'AVERAGE=Media'+#13+
'XML=XML'+#13+
'HTML TABLE=Tabla HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=Ninguno'+#13+
'(NONE)=Ninguna'#13+
'WIDTH=Ancho'+#13+
'HEIGHT=Alto'+#13+
'COLOR EACH=Colorea Cada'+#13+
'STACK=Apilar'+#13+
'STACKED=Apilado'+#13+
'STACKED 100%=Apilado 100%'+#13+
'AXIS=Eje'+#13+
'LENGTH=Longitud'+#13+
'CANCEL=Cancelar'+#13+
'SCROLL=Desplazamiento'+#13+
'INCREMENT=Incremento'+#13+
'VALUE=Valor'+#13+
'STYLE=Estilo'+#13+
'JOIN=Uni�n'+#13+
'AXIS INCREMENT=Incremento de Eje'+#13+
'AXIS MAXIMUM AND MINIMUM=M�ximo y M�nimo de Eje'+#13+
'% BAR WIDTH=Ancho Barra %'+#13+
'% BAR OFFSET=Desplaz. Barra %'+#13+
'BAR SIDE MARGINS=M�rgenes Laterales'+#13+
'AUTO MARK POSITION=Posici�n Marcas Auto.'+#13+
'DARK BAR 3D SIDES=Lados Barra Oscuros'+#13+
'MONOCHROME=Monocromo'+#13+
'COLORS=Colores'+#13+
'DEFAULT=Defecto'+#13+
'MEDIAN=Mediana'+#13+
'IMAGE=Imagen'+#13+
'DAYS=Dias'+#13+
'WEEKDAYS=Laborables'+#13+
'TODAY=Hoy'+#13+
'SUNDAY=Domingo'+#13+
'MONTHS=Meses'+#13+
'LINES=L�neas'+#13+
'UPPERCASE=May�sculas'+#13+
'STICK=Candle'+#13+
'CANDLE WIDTH=Ancho Candle'+#13+
'BAR=Barra'+#13+
'OPEN CLOSE=Aper. Cierre'+#13+
'DRAW 3D=Dibujar 3D'+#13+
'DARK 3D=Oscuro 3D'+#13+
'SHOW OPEN=Ver Apertura'+#13+
'SHOW CLOSE=Ver Cierre'+#13+
'UP CLOSE=Cierre Arriba'+#13+
'DOWN CLOSE=Cierre Abajo'+#13+
'CIRCLED=Circular'+#13+
'CIRCLE=C�rculo'+#13+
'3 DIMENSIONS=3 Dimensiones'+#13+
'ROTATION=Rotaci�n'+#13+
'RADIUS=Radios'+#13+
'HOURS=Horas'+#13+
'HOUR=Hora'+#13+
'MINUTES=Minutos'+#13+
'SECONDS=Segundos'+#13+
'FONT=Fuente'+#13+
'INSIDE=Interior'+#13+
'ROTATED=Rotar'+#13+
'ROMAN=Romanos'+#13+
'TRANSPARENCY=Transparencia'+#13+
'DRAW BEHIND=Dibujar Detr�s'+#13+
'RANGE=Rango'+#13+
'PALETTE=Paleta'+#13+
'STEPS=Pasos'+#13+
'GRID=Rejilla'+#13+
'GRID SIZE=Tama�o Rejilla'+#13+
'ALLOW DRAG=Permite arrastrar'+#13+
'AUTOMATIC=Autom�tico'+#13+
'LEVEL=Nivel'+#13+
'LEVELS POSITION=Posici�n Niveles'+#13+
'SNAP=Ajustar'+#13+
'FOLLOW MOUSE=Seguir Rat�n'+#13+
'TRANSPARENT=Transparente'+#13+
'ROUND FRAME=Marco Redondo'+#13+
'FRAME=Marco'+#13+
'START=Inicio'+#13+
'END=Final'+#13+
'MIDDLE=Medio'+#13+
'NO MIDDLE=Sin Medio'+#13+
'DIRECTION=Direcci�n'+#13+
'DATASOURCE=Origen de Datos'+#13+
'AVAILABLE=Disponibles'+#13+
'SELECTED=Seleccionados'+#13+
'CALC=Calcular'+#13+
'GROUP BY=Agrupar por'+#13+
'OF=de'+#13+
'HOLE %=Agujero %'+#13+
'RESET POSITIONS=Posiciones defecto'+#13+
'MOUSE BUTTON=Bot�n Rat�n'+#13+
'ENABLE DRAWING=Permite Dibujar'+#13+
'ENABLE SELECT=Permite Seleccionar'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=Angulo'+#13+
'ZOOM TEXT=Amplia Textos'+#13+
'PERSPECTIVE=Perspectiva'+#13+
'ZOOM=Ampliar'+#13+
'ELEVATION=Elevaci�n'+#13+
'BEHIND=Detr�s'+#13+
'AXES=Ejes'+#13+
'SCALES=Escalas'+#13+
'TITLE=T�tulo'+#13+
'TICKS=Marcas'+#13+
'MINOR=Menores'+#13+
'CENTERED=Centrado'+#13+
'CENTER=Centro'+#13+
'PATTERN COLOR EDITOR=Editor de Trama'+#13+
'START VALUE=Valor Inicial'+#13+
'END VALUE=Valor Final'+#13+
'COLOR MODE=Modo de Color'+#13+
'LINE MODE=Modo de L�nea'+#13+
'HEIGHT 3D=Alto 3D'+#13+
'OUTLINE=Borde'+#13+
'PRINT PREVIEW=Imprimir'+#13+
'ANIMATED=Animado'+#13+
'ALLOW=Permitir'+#13+
'DASH=L�neas'+#13+
'DOT=Puntos'+#13+
'DASH DOT DOT=L�nea Punto Punto'+#13+
'PALE=Suave'+#13+
'STRONG=Fuerte'+#13+
'WIDTH UNITS=Unidades'+#13+
'FOOT=Pie'+#13+
'SUBFOOT=Sub Pie'+#13+
'SUBTITLE=Subt�tulo'+#13+
'LEGEND=Leyenda'+#13+
'COLON=Dos puntos'+#13+
'AXIS ORIGIN=Origen Eje'+#13+
'UNITS=Unidades'+#13+
'PYRAMID=Pir�mide'+#13+
'DIAMOND=Diamante'+#13+
'CUBE=Cubo'+#13+
'TRIANGLE=Tri�ngulo'+#13+
'STAR=Estrella'+#13+
'SQUARE=Cuadrado'+#13+
'DOWN TRIANGLE=Tri�ngulo Invert.'+#13+
'SMALL DOT=Puntito'+#13+
'LOAD=Cargar'+#13+
'FILE=Archivo'+#13+
'RECTANGLE=Rect�ngulo'+#13+
'HEADER=Cabecera'+#13+
'CLEAR=Borrar'+#13+
'ONE HOUR=Una Hora'+#13+
'ONE YEAR=Un A�o'+#13+
'ELLIPSE=Elipse'+#13+
'CONE=Cono'+#13+
'ARROW=Flecha'+#13+
'CYLLINDER=Cilindro'+#13+
'TIME=Hora'+#13+
'BRUSH=Trama'+#13+
'LINE=L�nea'+#13+
'VERTICAL LINE=L�nea Vertical'+#13+
'AXIS ARROWS=Flechas en Ejes'+#13+
'MARK TIPS=Sugerencias'+#13+
'DASH DOT=L�nea Punto'+#13+
'COLOR BAND=Bandas de Color'+#13+
'COLOR LINE=Linea de Color'+#13+
'INVERT. TRIANGLE=Tri�ngulo Invert.'+#13+
'INVERT. PYRAMID=Pir�mide Invert.'+#13+
'INVERTED PYRAMID=Pir�mide Invert.'+#13+
'SERIES DATASOURCE TEXT EDITOR=Editor de Origen de Datos de Texto'+#13+
'SOLID=S�lido'+#13+
'WIREFRAME=Alambres'+#13+
'DOTFRAME=Puntos'+#13+
'SIDE BRUSH=Trama Lateral'+#13+
'SIDE=Al lado'+#13+
'SIDE ALL=Lateral'+#13+
'ROTATE=Rotar'+#13+
'SMOOTH PALETTE=Paleta suavizada'+#13+
'CHART TOOLS GALLERY=Galer�a de Herramientas'+#13+
'ADD=A�adir'+#13+
'BORDER EDITOR=Editor de Borde'+#13+
'DRAWING MODE=Modo de Dibujo'+#13+
'CLOSE CIRCLE=Cerrar C�rculo'+#13+
'PICTURE=Imagen'+#13+
'NATIVE=Nativo'+#13+
'DATA=Datos'+#13+
'KEEP ASPECT RATIO=Mantener proporci�n'+#13+
'COPY=Copiar'+#13+
'SAVE=Guardar'+#13+
'SEND=Enviar'+#13+
'INCLUDE SERIES DATA=Incluir Datos de Series'+#13+
'FILE SIZE=Tama�o del Archivo'+#13+
'INCLUDE=Incluir'+#13+
'POINT INDEX=Indice de Puntos'+#13+
'POINT LABELS=Etiquetas de Puntos'+#13+
'DELIMITER=Delimitador'+#13+
'DEPTH=Profund.'+#13+
'COMPRESSION LEVEL=Nivel Compresi�n'+#13+
'COMPRESSION=Compresi�n'+#13+
'PATTERNS=Tramas'+#13+
'LABEL=Etiqueta'+#13+
'GROUP SLICES=Agrupar porciones'+#13+
'EXPLODE BIGGEST=Separar Porci�n'+#13+
'TOTAL ANGLE=Angulo Total'+#13+
'HORIZ. SIZE=Tama�o Horiz.'+#13+
'VERT. SIZE=Tama�o Vert.'+#13+
'SHAPES=Formas'+#13+
'INFLATE MARGINS=Ampliar M�rgenes'+#13+
'QUALITY=Calidad'+#13+
'SPEED=Velocidad'+#13+
'% QUALITY=% Calidad'+#13+
'GRAY SCALE=Escala de Grises'+#13+
'PERFORMANCE=Mejor'+#13+
'BROWSE=Seleccionar'+#13+
'TILED=Mosaico'+#13+
'HIGH=Alto'+#13+
'LOW=Bajo'+#13+
'DATABASE CHART=Gr�fico con Base de Datos'+#13+
'NON DATABASE CHART=Gr�fico sin Base de Datos'+#13+
'HELP=Ayuda'+#13+
'NEXT >=Siguiente >'+#13+
'< BACK=< Anterior'+#13+
'TEECHART WIZARD=Asistente de TeeChart'+#13+
'PERCENT=Porcentual'+#13+
'PIXELS=Pixels'+#13+
'ERROR WIDTH=Ancho Error'+#13+
'ENHANCED=Mejorado'+#13+
'VISIBLE WALLS=Ver Paredes'+#13+
'ACTIVE=Activo'+#13+
'DELETE=Borrar'+#13+
'ALIGNMENT=Alineaci�n'+#13+
'ADJUST FRAME=Ajustar Marco'+#13+
'HORIZONTAL=Horizontal'+#13+
'VERTICAL=Vertical'+#13+
'VERTICAL POSITION=Posici�n Vertical'+#13+
'NUMBER=N�mero'+#13+
'LEVELS=Niveles'+#13+
'OVERLAP=Sobreponer'+#13+
'STACK 100%=Apilar 100%'+#13+
'MOVE=Mover'+#13+
'CLICK=Clic'+#13+
'DELAY=Retraso'+#13+
'DRAW LINE=Dibujar L�nea'+#13+
'FUNCTIONS=Funciones'+#13+
'SOURCE SERIES=Series Origen'+#13+
'ABOVE=Arriba'+#13+
'BELOW=Abajo'+#13+
'Dif. Limit=L�mite Dif.'+#13+
'WITHIN=Dentro'+#13+
'EXTENDED=Extendidas'+#13+
'STANDARD=Estandard'+#13+
'STATS=Estad�stica'+#13+
'FINANCIAL=Financieras'+#13+
'OTHER=Otras'+#13+
'TEECHART GALLERY=Galer�a de Gr�ficos TeeChart'+#13+
'CONNECTING LINES=L�neas de Conexi�n'+#13+
'REDUCTION=Reducci�n'+#13+
'LIGHT=Luz'+#13+
'INTENSITY=Intensidad'+#13+
'FONT OUTLINES=Borde Fuentes'+#13+
'SMOOTH SHADING=Sombras suaves'+#13+
'AMBIENT LIGHT=Luz Ambiente'+#13+
'MOUSE ACTION=Acci�n del Rat�n'+#13+
'CLOCKWISE=Segun horario'+#13+
'ANGLE INCREMENT=Incremento Angulo'+#13+
'RADIUS INCREMENT=Incremento Radio'+#13+
'PRINTER=Impresora'+#13+
'SETUP=Opciones'+#13+
'ORIENTATION=Orientaci�n'+#13+
'PORTRAIT=Vertical'+#13+
'LANDSCAPE=Horizontal'+#13+
'MARGINS (%)=M�rgenes (%)'+#13+
'MARGINS=M�rgenes'+#13+
'DETAIL=Detalle'+#13+
'MORE=M�s'+#13+
'PROPORTIONAL=Proporcional'+#13+
'VIEW MARGINS=Ver M�rgenes'+#13+
'RESET MARGINS=M�rg. Defecto'+#13+
'PRINT=Imprimir'+#13+
'TEEPREVIEW EDITOR=Editor Impresi�n Preliminar'+#13+
'ALLOW MOVE=Permitir Mover'+#13+
'ALLOW RESIZE=Permitir Redimensionar'+#13+
'SHOW IMAGE=Ver Imagen'+#13+
'DRAG IMAGE=Arrastrar Imagen'+#13+
'AS BITMAP=Como mapa de bits'+#13+
'SIZE %=Tama�o %'+#13+
'FIELDS=Campos'+#13+
'SOURCE=Origen'+#13+
'SEPARATOR=Separador'+#13+
'NUMBER OF HEADER LINES=L�neas de cabecera'+#13+
'COMMA=Coma'+#13+
'EDITING=Editando'+#13+
'TAB=Tabulaci�n'+#13+
'SPACE=Espacio'+#13+
'ROUND RECTANGLE=Rect�ng. Redondeado'+#13+
'BOTTOM=Abajo'+#13+
'RIGHT=Derecha'+#13+
'C PEN=L�piz C'+#13+
'R PEN=L�piz R'+#13+
'C LABELS=Textos C'+#13+
'R LABELS=Textos R'+#13+
'MULTIPLE BAR=Barras M�ltiples'+#13+
'MULTIPLE AREAS=Areas M�ltiples'+#13+
'STACK GROUP=Grupo de Apilado'+#13+
'BOTH=Ambos'+#13+
'BACK DIAGONAL=Diagonal Invertida'+#13+
'B.DIAGONAL=Diagonal Invertida'+#13+
'DIAG.CROSS=Cruz en Diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Cruz'+#13+
'DIAGONAL CROSS=Cruz en Diagonal'+#13+
'LEFT RIGHT=Izquierda Derecha'+#13+
'RIGHT LEFT=Derecha Izquierda'+#13+
'FROM CENTER=Desde el centro'+#13+
'FROM TOP LEFT=Desde Izq. Arriba'+#13+
'FROM BOTTOM LEFT=Desde Izq. Abajo'+#13+
'SHOW WEEKDAYS=Ver Laborables'+#13+
'SHOW MONTHS=Ver Meses'+#13+
'SHOW PREVIOUS BUTTON=Ver Bot�n Anterior'#13+
'SHOW NEXT BUTTON=Ver Bot�n Siguiente'#13+
'TRAILING DAYS=Ver otros D�as'+#13+
'SHOW TODAY=Ver Hoy'+#13+
'TRAILING=Otros D�as'+#13+
'LOWERED=Hundido'+#13+
'RAISED=Elevado'+#13+
'HORIZ. OFFSET=Desplaz. Horiz.'+#13+
'VERT. OFFSET=Desplaz. Vert.'+#13+
'INNER=Dentro'+#13+
'LEN=Long.'+#13+
'AT LABELS ONLY=S�lo en etiquetas'+#13+
'MAXIMUM=M�ximo'+#13+
'MINIMUM=M�nimo'+#13+
'CHANGE=Cambiar'+#13+
'LOGARITHMIC=Logar�tmico'+#13+
'LOG BASE=Base Log.'+#13+
'DESIRED INCREMENT=Incremento'+#13+
'(INCREMENT)=(Incremento)'+#13+
'MULTI-LINE=Multi-L�nea'+#13+
'MULTI LINE=Multil�nea'+#13+
'RESIZE CHART=Redim. Gr�fico'+#13+
'X AND PERCENT=X y Porcentaje'+#13+
'X AND VALUE=X y Valor'+#13+
'RIGHT PERCENT=Porcentaje derecha'+#13+
'LEFT PERCENT=Porcentaje izquierda'+#13+
'LEFT VALUE=Valor izquierda'+#13+
'RIGHT VALUE=Valor derecha'+#13+
'PLAIN=Texto'+#13+
'LAST VALUES=Ultimos Valores'+#13+
'SERIES VALUES=Valores de Series'+#13+
'SERIES NAMES=Nombres de Series'+#13+
'NEW=Nuevo'+#13+
'EDIT=Editar'+#13+
'PANEL COLOR=Color de fondo'+#13+
'TOP BOTTOM=Arriba Abajo'+#13+
'BOTTOM TOP=Abajo Arriba'+#13+
'DEFAULT ALIGNMENT=Alineaci�n defecto'+#13+
'EXPONENTIAL=Exponencial'+#13+
'LABELS FORMAT=Formato Etiquetas'+#13+
'MIN. SEPARATION %=Min. Separaci�n %'+#13+
'YEAR=A�o'+#13+
'MONTH=Mes'+#13+
'WEEK=Semana'+#13+
'WEEKDAY=Dia Laborable'+#13+
'MARK=Marcas'+#13+
'ROUND FIRST=Redondear primera'+#13+
'LABEL ON AXIS=Etiqueta en eje'+#13+
'COUNT=N�mero'+#13+
'POSITION %=Posici�n %'+#13+
'START %=Empieza %'+#13+
'END %=Termina %'+#13+
'OTHER SIDE=Lado opuesto'+#13+
'INTER-CHAR SPACING=Espacio entre caracteres'+#13+
'VERT. SPACING=Espaciado Vertical'+#13+
'POSITION OFFSET %=Desplazamiento %'+#13+
'GENERAL=General'+#13+
'MANUAL=Manual'+#13+
'PERSISTENT=Persistente'+#13+
'PANEL=Panel'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=Editor de OpenGL'+#13+
'FONT 3D DEPTH=Profund. Fuentes'+#13+
'NORMAL=Normal'+#13+
'TEEFONT EDITOR=Editor de Fuente'+#13+
'CLIP POINTS=Ocultar'+#13+
'CLIPPED=Oculta'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Cuantifica'+#13+
'QUANTIZE 256=Cuantifica 256'+#13+
'DITHER=Reduce'+#13+
'VERTICAL SMALL=Vertical Peque�o'+#13+
'HORIZ. SMALL=Horizontal Peque�o'+#13+
'DIAG. SMALL=Diagonal Peque�o'+#13+
'BACK DIAG. SMALL=Diagonal Invert. Peq.'+#13+
'DIAG. CROSS SMALL=Cruz Diagonal Peq.'+#13+
'MINIMUM PIXELS=M�nimos pixels'+#13+
'ALLOW SCROLL=Permitir Desplaz.'+#13+
'SWAP=Cambiar'+#13+
'GRADIENT EDITOR=Editor de Gradiente'+#13+
'TEXT STYLE=Estilo de textos'+#13+
'DIVIDING LINES=L�neas de Divisi�n'+#13+
'SYMBOLS=S�mbolos'+#13+
'CHECK BOXES=Casillas'+#13+
'FONT SERIES COLOR=Color de Series'+#13+
'LEGEND STYLE=Estilo de Leyenda'+#13+
'POINTS PER PAGE=Puntos por p�gina'+#13+
'SCALE LAST PAGE=Escalar �ltima p�gina'+#13+
'CURRENT PAGE LEGEND=Leyenda con p�gina actual'+#13+
'BACKGROUND=Fondo'+#13+
'BACK IMAGE=Imagen fondo'+#13+
'STRETCH=Ajustar'+#13+
'TILE=Mosaico'+#13+
'BORDERS=Bordes'+#13+
'CALCULATE EVERY=Calcular cada'+#13+
'NUMBER OF POINTS=N�mero puntos'+#13+
'RANGE OF VALUES=Rango de valores'+#13+
'FIRST=Primero'+#13+
'LAST=Ultimo'+#13+
'ALL POINTS=Todos los puntos'+#13+
'DATA SOURCE=Origen de Datos'+#13+
'WALLS=Pared'+#13+
'PAGING=P�gina'+#13+
'CLONE=Duplicar'+#13+
'TITLES=T�tulo'+#13+
'TOOLS=Herramientas'+#13+
'EXPORT=Exportar'+#13+
'CHART=Gr�fico'+#13+
'BACK=Fondo'+#13+
'LEFT AND RIGHT=Izq. y Derecha'+#13+
'SELECT A CHART STYLE=Seleccione tipo de Gr�fico'+#13+
'SELECT A DATABASE TABLE=Seleccione una Tabla'+#13+
'TABLE=Tabla'+#13+
'SELECT THE DESIRED FIELDS TO CHART=Seleccione los campos a graficar'+#13+
'SELECT A TEXT LABELS FIELD=Campo de etiquetas'+#13+
'CHOOSE THE DESIRED CHART TYPE=Seleccione el tipo deseado'+#13+
'CHART PREVIEW=Visi�n Preliminar'+#13+
'SHOW LEGEND=Ver Leyenda'+#13+
'SHOW MARKS=Ver Marcas'+#13+
'FINISH=Terminar'+#13+
'RANDOM=Aleatorio'+#13+
'DRAW EVERY=Dibujar cada'+#13+
'ARROWS=Flechas'+#13+
'ASCENDING=Ascendente'+#13+
'DESCENDING=Descendente'+#13+
'VERTICAL AXIS=Eje Vertical'+#13+
'DATETIME=Fecha/Hora'+#13+
'TOP AND BOTTOM=Superior e Inferior'+#13+
'HORIZONTAL AXIS=Eje Horizontal'+#13+
'PERCENTS=Porcentajes'+#13+
'VALUES=Valores'+#13+
'FORMATS=Formatos'+#13+
'SHOW IN LEGEND=Ver en Leyenda'+#13+
'SORT=Orden'+#13+
'MARKS=Marcas'+#13+
'BEVEL INNER=Marco interior'+#13+
'BEVEL OUTER=Marco exterior'+#13+
'PANEL EDITOR=Editor de Panel'+#13+
'CONTINUOUS=Continuos'+#13+
'HORIZ. ALIGNMENT=Alineaci�n Horiz.'+#13+
'EXPORT CHART=Exportar Gr�fico'+#13+
'BELOW %=Inferior a %'+#13+
'BELOW VALUE=Inferior a Valor'+#13+
'NEAREST POINT=Punto cercano'+#13+
'DRAG MARKS=Mover Marcas'+#13+
'TEECHART PRINT PREVIEW=Impresi�n Preliminar'+#13+
'X VALUE=Valor X'+#13+
'X AND Y VALUES=Valores X Y'+#13+
'SHININESS=Brillo'+#13+
'ALL SERIES VISIBLE=Todas las Series Visible'+#13+
'MARGIN=Margen'+#13+
'DIAGONAL=Diagonal'+#13+
'LEFT TOP=Izquierda Arriba'+#13+
'LEFT BOTTOM=Izquierda Abajo'+#13+
'RIGHT TOP=Derecha Arriba'+#13+
'RIGHT BOTTOM=Derecha Abajo'+#13+
'EXACT DATE TIME=Fecha/Hora Exacta'+#13+
'RECT. GRADIENT=Gradiente'+#13+
'CROSS SMALL=Cruz peque�a'+#13+
'AVG=Media'+#13+
'FUNCTION=Funci�n'+#13+
'AUTO=Auto'+#13+
'ONE MILLISECOND=Un milisegundo'+#13+
'ONE SECOND=Un segundo'+#13+
'FIVE SECONDS=Cinco segundos'+#13+
'TEN SECONDS=Diez segundos'+#13+
'FIFTEEN SECONDS=Quince segundos'+#13+
'THIRTY SECONDS=Trenta segundos'+#13+
'ONE MINUTE=Un minuto'+#13+
'FIVE MINUTES=Cinco minutos'+#13+
'TEN MINUTES=Diez minutos'+#13+
'FIFTEEN MINUTES=Quince minutos'+#13+
'THIRTY MINUTES=Trenta minutos'+#13+
'TWO HOURS=Dos horas'+#13+
'SIX HOURS=Seis horas'+#13+
'TWELVE HOURS=Doce horas'+#13+
'ONE DAY=Un dia'+#13+
'TWO DAYS=Dos dias'+#13+
'THREE DAYS=Tres dias'+#13+
'ONE WEEK=Una semana'+#13+
'HALF MONTH=Medio mes'+#13+
'ONE MONTH=Un mes'+#13+
'TWO MONTHS=Dos meses'+#13+
'THREE MONTHS=Tres meses'+#13+
'FOUR MONTHS=Cuatro meses'+#13+
'SIX MONTHS=Seis meses'+#13+
'IRREGULAR=Irregular'+#13+
'CLICKABLE=Clicable'+#13+
'ROUND=Redondo'+#13+
'FLAT=Plano'+#13+
'PIE=Pastel'+#13+
'HORIZ. BAR=Barra Horiz.'+#13+
'BUBBLE=Burbuja'+#13+
'SHAPE=Forma'+#13+
'POINT=Puntos'+#13+
'FAST LINE=L�nea R�pida'+#13+
'CANDLE=Vela'+#13+
'VOLUME=Volumen'+#13+
'HORIZ LINE=L�nea Horiz.'+#13+
'SURFACE=Superf�cie'+#13+
'LEFT AXIS=Eje Izquierdo'+#13+
'RIGHT AXIS=Eje Derecho'+#13+
'TOP AXIS=Eje Superior'+#13+
'BOTTOM AXIS=Eje Inferior'+#13+
'CHANGE SERIES TITLE=Cambiar T�tulo de Series'+#13+
'DELETE %S ?=Eliminar %s ?'+#13+
'DESIRED %S INCREMENT=Incremento %s deseado'+#13+
'INCORRECT VALUE. REASON: %S=Valor incorrecto. Raz�n: %s'+#13+
'FillSampleValues NumValues must be > 0=FillSampleValues. N�mero de valores debe ser > 0.'#13+
'VISIT OUR WEB SITE !=Visite nuestra Web !'#13+
'SHOW PAGE NUMBER=Ver N�mero de P�gina'#13+
'PAGE NUMBER=N�mero de P�gina'#13+
'PAGE %D OF %D=P�g. %d de %d'#13+
'TEECHART LANGUAGES=Lenguajes de TeeChart'#13+
'CHOOSE A LANGUAGE=Escoja un idioma'+#13+
'SELECT ALL=Seleccionar Todas'#13+
'MOVE UP=Mover Arriba'#13+
'MOVE DOWN=Mover Abajo'#13+
'DRAW ALL=Dibujar todo'#13+
'TEXT FILE=Archivo de Texto'#13+
'IMAG. SYMBOL=S�mbolo Imag.'#13+
'DRAG REPAINT=Repinta todo'#13+
'NO LIMIT DRAG=Sin l�mites arrastre'#13+
'AVAILABLE LANGUAGES=Lenguajes disponibles'#13+
'PERIOD=Periodo'#13+
'FILL 80%=Relleno 80%'#13+
'FILL 60%=Relleno 60%'#13+
'FILL 40%=Relleno 40%'#13+
'FILL 20%=Relleno 20%'#13+
'FILL 10%=Relleno 10%'#13+
'ZIG ZAG=Zig-Zag'#13+
'IGNORE NULLS=Ignorar nulos'#13+
'LIGHT 0=Luz 0'#13+
'LIGHT 1=Luz 1'#13+
'LIGHT 2=Luz 2'#13+
'DRAW STYLE=Estilo'#13+
'POINTS=Puntos'#13+
'EXPORT DIALOG=Di�logo de Exportaci�n'#13+
'POINT COLORS=Color de puntos'#13+
'OUTLINE GRADIENT=Gradiente en borde'#13+
'GAUGES=Indicadores'#13+
'RADIAL=Radial'#13+
'RADIAL OFFSET=Desplaz. Radial'#13+
'SHADOW EDITOR=Editor de Sombra'#13+
'3D GRID TRANSPOSE=Invertir matriz 3D'#13+
'EXTRA LEGEND=Leyenda Extra'#13+
'GANTT DRAG=Arrastra Gantt'#13+
'GRID BAND TOOL=Bandas en rejilla'#13+
'SERIES ANIMATION=Animaci�n de Series'#13+
'UP=Arriba'#13+
'DOWN=Abajo'#13+
'CALLOUT=Enlace'#13+
'TEXT ALIGNMENT=Alineaci�n texto'#13+
'DISTANCE=Distancia'#13+
'ARROW HEAD=Cabeza flecha'#13+
'POINTER=Puntero'#13+
'CALCULATE USING=Calcular usando'#13+
'EVERY NUMBER OF POINTS=Cada num. puntos'#13+
'EVERY RANGE=Cada rango'#13+
'INCLUDE NULL VALUES=Incluir nulos'#13+
'DATE=Fecha'#13+
'ENTER DATE=Entrar fecha'#13+
'ENTER TIME=Entrar hora'#13+
'CYLINDER=Cilindro'#13+
'DEVIATION=Desviaci�n'#13+
'UPPER=Superior'#13+
'LOWER=Inferior'#13+
'CONSTANT=Constante'#13+
'SHOW LABELS=Ver textos'#13+
'SHOW COLORS=Ver colores'#13+
'XYZ SERIES=Series xyz'#13+
'SHOW X VALUES=Ver valores X'#13+
'ACCUMULATE=Acumular'#13+
'SMOOTH=Suave'#13+
'INTERPOLATE=Interpolar'#13+
'START X=Inicio X'#13+
'STEP=Paso'#13+
'NUM. POINTS=Num. puntos'#13+
'COLOR EACH LINE=Color cada linea'#13+
'SORT BY=Ordenar por'#13+
'CALCULATION=C�lculo'#13+
'GROUP=Grupo'#13+
'WEIGHT=Ponderar'#13+
'EDIT LEGEND=Editar Leyenda'#13+
'OFFSET=Desplaz.'#13+
'DEFAULT BORDER=Borde defecto'#13+
'SEPARATION=Separaci�n'#13+
'ROUND BORDER=Borde redondo'#13+
'NUMBER OF SAMPLE VALUES=Num. muestras'#13+
'DIF. LIMIT=Limite dif.'#13+
'RESIZE PIXELS TOLERANCE=Tolerancia pixels'#13+
'FULL REPAINT=Repintar todo'#13+
'END POINT=Punto final'#13+
'BAND 1=Banda 1'#13+
'BAND 2=Banda 2'#13+
'TRANSPOSE NOW=Invertir'#13+
'NOTHING=Nada'#13+
'LEFT TRIANGLE=Tri�ngulo Izq.'#13+
'RIGHT TRIANGLE=Tri�ngulo Der.'#13+
'PERIOD 1=Periodo 1'#13+
'PERIOD 2=Periodo 2'#13+
'PERIOD 3=Periodo 3'#13+
'HISTOGRAM=Histograma'#13+
'EXP. LINE=Linea Exp.'#13+
'WEIGHTED=Ponderado'#13+
'WEIGHTED BY INDEX=Ponderar indices'#13+
'BOX SIZE=Tama�o caja'#13+
'REVERSAL AMOUNT=Valor inversi�n'#13+
'PERCENTAGE=Porcentaje'#13+
'COMPLETE R.M.S.=RMS completa'#13+
'BUTTON=Bot�n'#13+
'ALL=Todo'#13+
'START AT MIN. VALUE=Empezar en valor m�n.'#13+
'EXECUTE !=Ejecutar !'#13+
'WEB URL=Direcci�n web'#13+
'SELF STACK=Apilado s� mismo'#13+
'SIDE LINES=Lineas laterales'#13+
'COVER=Cubierta'#13+
'VALUE SOURCE=Fuente valores'#13+

// 6.0
'BEVEL SIZE=Tam. Marco'#13+
'DELETE ROW=Eliminar fila'#13+
'VOLUME SERIES=Serie Volumen'#13+
'SINGLE=Unico'#13+
'REMOVE CUSTOM COLORS=Eliminar colores'#13+
'USE PALETTE MINIMUM=Usar m�nimo paleta'#13+
'AXIS MAXIMUM=M�ximo eje'#13+
'AXIS CENTER=Centro eje'#13+
'AXIS MINIMUM=M�nimo eje'#13+
'DAILY (NONE)=Diario'#13+
'WEEKLY=Semanal'#13+
'MONTHLY=Mensual'#13+
'BI-MONTHLY=Bimensual'#13+
'QUARTERLY=Trimestral'#13+
'YEARLY=Anual'#13+
'DATETIME PERIOD=Periodo fecha/hora'#13+
'CASE SENSITIVE=Mayusc./Minusc.'#13+
'DRAG STYLE=Estilo arrastre'#13+
'SQUARED=Cuadrado'#13+
'GRID 3D SERIES=Serie 3D'#13+
'DARK BORDER=Borde oscuro'#13+
'PIE SERIES=Serie Pastel'#13+
'FOCUS=Marcar'#13+
'EXPLODE=Expandir'#13+
'FACTOR=Factor'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Desde archivo plantilla (*.tee)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Abrir plantilla desde'#13+
'BINARY=Binario'#13+
'VOLUME OSCILLATOR=Oscilador Volumen'#13+
'PIE SLICES=Porciones pastel'#13+
'ARROW WIDTH=Ancho flecha'#13+
'ARROW HEIGHT=Alto flecha'#13+
'DEFAULT COLOR=Color defecto'#13+
'BALANCE=Balance'
;
  end;
end;

Procedure TeeSetMexican;
begin
  TeeCreateMexican;
  TeeLanguage:=TeeMexicanLanguage;
  TeeMexicanConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeMexicanLanguage);
end.
