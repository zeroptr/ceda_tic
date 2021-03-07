unit TeeChineseSimp;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeChineseSimpLanguage:TStringList=nil;

Procedure TeeSetChineseSimp;
Procedure TeeCreateChineseSimp;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeChineseSimpConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='(C) 1995-2009 by David Berneda';
  TeeMsg_LegendFirstValue   :='��һ��ͼ��ֵ������� 0';
  TeeMsg_LegendColorWidth   :='ͼ������ɫ��ȱ������ 0%';
  TeeMsg_SeriesSetDataSource:='û����ͼ����ȷ��������Դ';
  TeeMsg_SeriesInvDataSource:='����ȷ��������Դ: %s';
  TeeMsg_FillSample         :='FillSampleValues �� NumValues ������� 0';
  TeeMsg_AxisLogDateTime    :='����ʱ����᲻���Ƕ���';
  TeeMsg_AxisLogNotPositive :='������������Сֵ������ڻ���� 0';
  TeeMsg_AxisLabelSep       :='���ļ���ٷֱȱ������ 0';
  TeeMsg_AxisIncrementNeg   :='��ĵ���ֵ������ڻ���� 0';
  TeeMsg_AxisMinMax         :='�����Сֵ����С�ڻ�������ֵ';
  TeeMsg_AxisMaxMin         :='������ֵ������ڻ������Сֵ';
  TeeMsg_AxisLogBase        :='��Ķ�������������ڻ���� 2';
  TeeMsg_MaxPointsPerPage   :='ÿҳ���ܱ����������ڻ���� 0';
  TeeMsg_3dPercent          :='3D Ч���İٷֱȱ���λ�� %d �� %d ֮��';
  TeeMsg_CircularSeries     :='Ȧ�ε����в�����ѭ�������';
  TeeMsg_WarningHiColor     :='��Ҫ 16k �����ϵ�ɫ�����õ����õ�Ч��';

  TeeMsg_DefaultPercentOf   :='%s ֮ %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'֮ %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='��ı���';
  TeeMsg_AxisLabels         :='��ľ��';
  TeeMsg_RefreshInterval    :='����ʱ�����λ�� 0 �� 60 ֮��';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart �����Լ�!';
  TeeMsg_GalleryLine        :='����ͼ';
  TeeMsg_GalleryPoint       :='���';
  TeeMsg_GalleryArea        :='���ͼ';
  TeeMsg_GalleryBar         :='����ͼ';
  TeeMsg_GalleryHorizBar    :='�������ͼ';
  TeeMsg_Stack              :='�ѵ�ͼ';
  TeeMsg_GalleryPie         :='ͼ��ͼ';
  TeeMsg_GalleryCircled     :='ԲȦ';
  TeeMsg_GalleryFastLine    :='��������ͼ';
  TeeMsg_GalleryHorizLine   :='��������ͼ';

  TeeMsg_PieSample1         :='����';
  TeeMsg_PieSample2         :='�绰';
  TeeMsg_PieSample3         :='����';
  TeeMsg_PieSample4         :='��ʾ��';
  TeeMsg_PieSample5         :='̨��';
  TeeMsg_PieSample6         :='����';
  TeeMsg_PieSample7         :='��̤��';
  TeeMsg_PieSample8         :='����';

  TeeMsg_GalleryLogoFont    :='��ϸ����';
  TeeMsg_Editing            :='�༭ %s';

  TeeMsg_GalleryStandard    :='��׼';
  TeeMsg_GalleryExtended    :='����';
  TeeMsg_GalleryFunctions   :='����';

  TeeMsg_EditChart          :='�༭ͼ��(&D)...';
  TeeMsg_PrintPreview       :='Ԥ����ӡ(&P)...';
  TeeMsg_ExportChart        :='���ͼ��(&X)...';
  TeeMsg_CustomAxes         :='�Զ���...';

  TeeMsg_InvalidEditorClass :='%s: ����ȷ�ı༭������: %s';
  TeeMsg_MissingEditorClass :='%s: û�б༭�Ի�����';

  TeeMsg_GalleryArrow       :='��ͷ';

  TeeMsg_ExpFinish          :='���(&F)';
  TeeMsg_ExpNext            :='��һ��(&N) >';

  TeeMsg_GalleryGantt       :='����ͼ(����)';

  TeeMsg_GanttSample1       :='���';
  TeeMsg_GanttSample2       :='������Ʒ';
  TeeMsg_GanttSample3       :='����';
  TeeMsg_GanttSample4       :='����';
  TeeMsg_GanttSample5       :='��������';
  TeeMsg_GanttSample6       :='����';
  TeeMsg_GanttSample7       :='����';
  TeeMsg_GanttSample8       :='����';
  TeeMsg_GanttSample9       :='�°汾';
  TeeMsg_GanttSample10      :='���з���';

  TeeMsg_ChangeSeriesTitle  :='������еı���';
  TeeMsg_NewSeriesTitle     :='�µ����б���:';
  TeeMsg_DateTime           :='����ʱ��';
  TeeMsg_TopAxis            :='����';
  TeeMsg_BottomAxis         :='����';
  TeeMsg_LeftAxis           :='����';
  TeeMsg_RightAxis          :='����';

  TeeMsg_SureToDelete       :='�Ƴ� %s ?';
  TeeMsg_DateTimeFormat     :='����ʱ���ʽ(&M):';
  TeeMsg_Default            :='Ԥ��';
  TeeMsg_ValuesFormat       :='��ֵ��ʽ(&M):';
  TeeMsg_Maximum            :='���';
  TeeMsg_Minimum            :='��С';
  TeeMsg_DesiredIncrement   :='����� %s ����';

  TeeMsg_IncorrectMaxMinValue:='������ֵ��ԭ��%s';
  TeeMsg_EnterDateTime      :='���� [������] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='���ñ��?';
  TeeMsg_SelectedSeries     :='(��ѡ������)';
  TeeMsg_RefreshData        :='��������(&R)';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_FunctionAdd        :='��';
  TeeMsg_FunctionSubtract   :='��';
  TeeMsg_FunctionMultiply   :='��';
  TeeMsg_FunctionDivide     :='��';
  TeeMsg_FunctionHigh       :='���ֵ';
  TeeMsg_FunctionLow        :='���ֵ';
  TeeMsg_FunctionAverage    :='ƽ��';

  TeeMsg_GalleryShape       :='��״ͼ';
  TeeMsg_GalleryBubble      :='����ͼ';
  TeeMsg_FunctionNone       :='����';

  TeeMsg_None               :='(��)';

  TeeMsg_PrivateDeclarations:='{ Private ���� }';
  TeeMsg_PublicDeclarations :='{ Public ���� }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='ָ���С���������';
  TeeMsg_About              :='�й� TeeChart(&U)...';

  TeeMsg_DataSet            :='������';
  TeeMsg_AskDataSet         :='������(&D):';

  TeeMsg_SingleRecord       :='��������';
  TeeMsg_AskDataSource      :='������Դ(&D):';

  TeeMsg_Summary            :='ժҪ';

  TeeMsg_FunctionPeriod     :='����������ֵ������ڻ������';

  TeeMsg_ClearImage         :='���(&r)';
  TeeMsg_BrowseImage        :='���(&R)...';

  TeeMsg_WizardSureToClose  :='ȷ��Ҫ�ر� TeeChart ���飿';
  TeeMsg_FieldNotFound      :='�ֶ� %s ������';

  TeeMsg_DepthAxis          :='�����';
  TeeMsg_PieOther           :='����';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='��״';
  TeeMsg_ValuesBar          :='����';
  TeeMsg_ValuesAngle        :='�Ƕ�';
  TeeMsg_ValuesGanttStart   :='��ʼ';
  TeeMsg_ValuesGanttEnd     :='����';
  TeeMsg_ValuesGanttNextTask:='�¸�����';
  TeeMsg_ValuesBubbleRadius :='�뾶';
  TeeMsg_ValuesArrowEndX    :='����X';
  TeeMsg_ValuesArrowEndY    :='����Y';
  TeeMsg_Legend             :='ͼ��';
  TeeMsg_Title              :='����';
  TeeMsg_Foot               :='��β';
  TeeMsg_Period		    :='����';
  TeeMsg_PeriodRange        :='���ڵķ�Χ';
  TeeMsg_CalcPeriod         :='���� %s ��ÿ��:';
  TeeMsg_SmallDotsPen       :='С��';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' ������ͼ����ȷ';
  TeeMsg_WrongTeeFileFormat :='*.'+TeeMsg_TeeExtension+' ������ʽ����';
  TeeMsg_EmptyTeeFile       :='�հ׵� *.'+TeeMsg_TeeExtension+' ����';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='ͼ����';
  TeeMsg_ChartAxesCategoryDesc   :='ͼ������������¼�';
  TeeMsg_ChartWallsCategoryName  :='ͼ��ڰ�';
  TeeMsg_ChartWallsCategoryDesc  :='ͼ��ڰ���������¼�';
  TeeMsg_ChartTitlesCategoryName :='ͼ�����';
  TeeMsg_ChartTitlesCategoryDesc :='ͼ�������������¼�';
  TeeMsg_Chart3DCategoryName     :='3D ͼ��';
  TeeMsg_Chart3DCategoryDesc     :='3D ͼ����������¼�';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='�Զ� ';
  TeeMsg_Series                 :='����';
  TeeMsg_SeriesList             :='����...';

  TeeMsg_PageOfPages            :='�� %dҳ,�� %dҳ';
  TeeMsg_FileSize               :='%d ���ֽ�';

  TeeMsg_First  :='���';
  TeeMsg_Prior  :='֮ǰ';
  TeeMsg_Next   :='֮��';
  TeeMsg_Last   :='���';
  TeeMsg_Insert :='����';
  TeeMsg_Delete :='�Ƴ�';
  TeeMsg_Edit   :='�༭';
  TeeMsg_Post   :='����';
  TeeMsg_Cancel :='ȡ��';

  TeeMsg_All    :='(ȫ��)';
  TeeMsg_Index  :='����';
  TeeMsg_Text   :='����';

  TeeMsg_AsBMP        :='λͼ(&B)';
  TeeMsg_BMPFilter    :='λͼ�� (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='&Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='�����ʽ��δ���趨�������';

  TeeMsg_Normal    :='����';
  TeeMsg_NoBorder  :='�ޱ�Ե';
  TeeMsg_Dotted    :='����';
  TeeMsg_Colors    :='��ɫ';
  TeeMsg_Filled    :='����';
  TeeMsg_Marks     :='��־';
  TeeMsg_Stairs    :='����';
  TeeMsg_Points    :='���';
  TeeMsg_Height    :='�߶�';
  TeeMsg_Hollow    :='����';
  TeeMsg_Point2D   :='2D ���';
  TeeMsg_Triangle  :='������';
  TeeMsg_Star      :='����';
  TeeMsg_Circle    :='Բ��';
  TeeMsg_DownTri   :='��������';
  TeeMsg_Cross     :='ʮ����';
  TeeMsg_Diamond   :='����';
  TeeMsg_NoLines   :='������';
  TeeMsg_Stack100  :='�ѻ� 100%';
  TeeMsg_Pyramid   :='��׶��';
  TeeMsg_Ellipse   :='��Բ��';
  TeeMsg_InvPyramid:='����׶��';
  TeeMsg_Sides     :='���';
  TeeMsg_SideAll   :='ȫ�����';
  TeeMsg_Patterns  :='��ʽ';
  TeeMsg_Exploded  :='����';
  TeeMsg_Shadow    :='��Ӱ';
  TeeMsg_SemiPie   :='���״';
  TeeMsg_Rectangle :='����';
  TeeMsg_VertLine  :='ֱ��';
  TeeMsg_HorizLine :='����';
  TeeMsg_Line      :='����';
  TeeMsg_Cube      :='������';
  TeeMsg_DiagCross :='����';

  TeeMsg_CanNotFindTempPath    :='�޷��ҵ� Temp ���ϼ�';
  TeeMsg_CanNotCreateTempChart :='�޷�������ʱ�ļ�';
  TeeMsg_CanNotEmailChart      :='�޷��Ե����ʼ����� TeeChart��Mapi ����%d';

  TeeMsg_SeriesDelete :='�Ƴ����У�ValueIndex %d ������Χ (0 �� %d).';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='����ͼ';
  TeeMsg_GalleryCandle      :='���ͼ';
  TeeMsg_GalleryVolume      :='����ͼ';
  TeeMsg_GallerySurface     :='����ͼ';
  TeeMsg_GalleryContour     :='����ͼ';
  TeeMsg_GalleryBezier      :='Bezierͼ';
  TeeMsg_GalleryPoint3D     :='3D���ͼ';
  TeeMsg_GalleryRadar       :='�״�ͼ';
  TeeMsg_GalleryDonut       :='��״ͼ';
  TeeMsg_GalleryCursor      :='���ͼ';
  TeeMsg_GalleryBar3D       :='3D����ͼ';
  TeeMsg_GalleryBigCandle   :='�����ͼ';
  TeeMsg_GalleryLinePoint   :='�����ͼ';
  TeeMsg_GalleryHistogram   :='ֱ��ͼ';
  TeeMsg_GalleryWaterFall   :='�ٲ�ͼ';
  TeeMsg_GalleryWindRose    :='����ͼ';
  TeeMsg_GalleryClock       :='ʧ��Բͼ';
  TeeMsg_GalleryColorGrid   :='��ɫ��ͼ';
  TeeMsg_GalleryBoxPlot     :='���ͼ';
  TeeMsg_GalleryHorizBoxPlot:='����ͼ';
  TeeMsg_GalleryBarJoin     :='��������ͼ';
  TeeMsg_GallerySmith       :='ʷ��˹ͼ';
  TeeMsg_GalleryPyramid     :='��׶ͼ';
  TeeMsg_GalleryMap         :='��ͼ';

  TeeMsg_PolyDegreeRange    :='Polynomial degree ����λ�� 1 �� 20 ֮��';
  TeeMsg_AnswerVectorIndex   :='Answer Vector ����ֵ����λ�� 1 �� %d ֮��';
  TeeMsg_FittingError        :='�޷���λ';
  TeeMsg_PeriodRange         :='���ڱ�����ڻ������';
  TeeMsg_ExpAverageWeight    :='ExpAverage Weight ����λ�� 0 �� 1 ֮��';
  TeeMsg_GalleryErrorBar     :='�����ͼ';
  TeeMsg_GalleryError        :='���ͼ';
  TeeMsg_GalleryHighLow      :='�ߵ�ͼ';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div.';
  TeeMsg_FunctionExpAverage  :='Exp. Avg.';
  TeeMsg_FunctionMovingAverage:='Moving Avg.';
  TeeMsg_FunctionExpMovAve   :='Exp. Mov. Avg.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp. Trend';
  TeeMsg_FunctionLogTrend    :='Log. Trend';
  TeeMsg_FunctionCumulative  :='Cumulative';
  TeeMsg_FunctionStdDeviation:='StdDeviation';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='����';
  TeeMsg_LoadChart           :='���� TeeChart...';
  TeeMsg_SaveChart           :='���� TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro ����';

  TeeMsg_GallerySamples      :='����';
  TeeMsg_GalleryStats        :='ͳ��';

  TeeMsg_CannotFindEditor    :='�޷��ҵ����еı༭����: %s';


  TeeMsg_CannotLoadChartFromURL:='������: %d ��������ַ����ͼ��: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='������: %d ��������ַ������������: %s';

  TeeMsg_Test                :='����...';

  TeeMsg_ValuesDate          :='����';
  TeeMsg_ValuesOpen          :='����';
  TeeMsg_ValuesHigh          :='��';
  TeeMsg_ValuesLow           :='��';
  TeeMsg_ValuesClose         :='�ر�';
  TeeMsg_ValuesOffset        :='ƫ��';
  TeeMsg_ValuesStdError      :='��׼���';

  TeeMsg_Grid3D              :='3D���';

  TeeMsg_LowBezierPoints     :='Bezier�ĵ���������� 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='����';
  TeeCommanMsg_Edit     :='�༭';
  TeeCommanMsg_Print    :='��ӡ';
  TeeCommanMsg_Copy     :='����';
  TeeCommanMsg_Save     :='����';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='��ת: %d?��������: %d?';
  TeeCommanMsg_Rotate   :='��ת';

  TeeCommanMsg_Moving   :='ˮƽƫ��: %d ��ֱƫ��: %d';
  TeeCommanMsg_Move     :='�ƶ�';

  TeeCommanMsg_Zooming  :='����: %d %%';
  TeeCommanMsg_Zoom     :='����';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='���';

  TeeCommanMsg_Chart    :='ͼ��';
  TeeCommanMsg_Panel    :='���';

  TeeCommanMsg_RotateLabel:='��ҷ %s ����ת';
  TeeCommanMsg_MoveLabel  :='��ҷ %s ���ƶ�';
  TeeCommanMsg_ZoomLabel  :='��ҷ %s ������';
  TeeCommanMsg_DepthLabel :='��ҷ %s ����� 3D ��С';

  TeeCommanMsg_NormalLabel:='��ҷ���������, �Ҽ���ת��';
  TeeCommanMsg_NormalPieLabel:='��ҷ��״�ڵ�Ƭ���������ֽ�';

  TeeCommanMsg_PieExploding :='Ƭ��: %d �ֽ�: %d %%';

  TeeMsg_TriSurfaceLess:='�������������ڻ���� 4';
  TeeMsg_TriSurfaceAllColinear:='ȫ����ͬ�����ϵı��';
  TeeMsg_TriSurfaceSimilar:='����� - �޷�ִ��';
  TeeMsg_GalleryTriSurface:='������';

  TeeMsg_AllSeries :='ȫ������';
  TeeMsg_Edit      :='�༭';

  TeeMsg_GalleryFinancial    :='�ƾ�';

  TeeMsg_CursorTool    :='ָ��';
  TeeMsg_DragMarksTool :='��ҷ��־';
  TeeMsg_AxisArrowTool :='���ͷ';
  TeeMsg_DrawLineTool  :='����';
  TeeMsg_NearestTool   :='�����';
  TeeMsg_ColorBandTool :='��ɫ��';
  TeeMsg_ColorLineTool :='��ɫ��';
  TeeMsg_RotateTool    :='��ת';
  TeeMsg_ImageTool     :='ͼ��';
  TeeMsg_MarksTipTool  :='��־˵��';

  TeeMsg_CantDeleteAncestor  :='�޷��Ƴ�ԭʼ����';

  TeeMsg_Load	         :='��ȡ...';
  TeeMsg_NoSeriesSelected:='��δѡȡ�κ�����';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='ͼ��';
  TeeMsg_CategorySeriesActions :='ͼ�������';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='�л� 2D / 3D';
  TeeMsg_ActionSeriesActive     :='��(&A)';
  TeeMsg_ActionSeriesActiveHint :='��ʾ / ���� ����';
  TeeMsg_ActionEditHint         :='�༭ͼ��';
  TeeMsg_ActionEdit             :='�༭(&E)...';
  TeeMsg_ActionCopyHint         :='���Ƶ�������';
  TeeMsg_ActionCopy             :='����(&C)';
  TeeMsg_ActionPrintHint        :='Ԥ����ӡͼ��';
  TeeMsg_ActionPrint            :='��ӡ(&P)...';
  TeeMsg_ActionAxesHint         :='��ʾ / ���� ��';
  TeeMsg_ActionAxes             :='��(&A)';
  TeeMsg_ActionGridsHint        :='��ʾ / ���� ���';
  TeeMsg_ActionGrids            :='���(&G)';
  TeeMsg_ActionLegendHint       :='��ʾ / ���� ͼ��';
  TeeMsg_ActionLegend           :='ͼ��(&L)';
  TeeMsg_ActionSeriesEditHint   :='�༭ͼ��';
  TeeMsg_ActionSeriesMarksHint  :='��ʾ / ���� ���б�־';
  TeeMsg_ActionSeriesMarks      :='��־(&M)';
  TeeMsg_ActionSaveHint         :='����ͼ��';
  TeeMsg_ActionSave             :='����(&S)...';

  TeeMsg_CandleBar              :='����';
  TeeMsg_CandleNoOpen           :='�޿���';
  TeeMsg_CandleNoClose          :='�޹ر�';
  TeeMsg_NoLines                :='������';
  TeeMsg_NoHigh                 :='�޸�';
  TeeMsg_NoLow                  :='�޵�';
  TeeMsg_ColorRange             :='��ɫ��Χ';
  TeeMsg_WireFrame              :='�����';
  TeeMsg_DotFrame               :='��ܵ�';
  TeeMsg_Positions              :='λ��';
  TeeMsg_NoGrid                 :='�ޱ��';
  TeeMsg_NoPoint                :='�ޱ��';
  TeeMsg_NoLine                 :='������';
  TeeMsg_Labels                 :='���';
  TeeMsg_NoCircle               :='��ԲȦ';
  TeeMsg_Lines                  :='����';
  TeeMsg_Border                 :='��Ե';

  TeeMsg_SmithResistance      :='����';
  TeeMsg_SmithReactance       :='����';
  
  TeeMsg_Column               :='�ֶ�';

  { 5.01 }
  TeeMsg_Separator            :='�ָ���';
  TeeMsg_FunnelSegment        :='Ƭ�� ';
  TeeMsg_FunnelSeries         :='©��ͼ';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='�����޶�';
  TeeMsg_FunnelWithin         :=' ���޶�֮��';
  TeeMsg_FunnelBelow          :=' ��������޶�';
  TeeMsg_CalendarSeries       :='����';
  TeeMsg_DeltaPointSeries     :='���ű��(Delta)';
  TeeMsg_ImagePointSeries     :='ͼ�����';
  TeeMsg_ImageBarSeries       :='ͼ������';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Field index ������� 0';

  TeeMsg_Yes    :='��';
  TeeMsg_No    :='��';

  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'ActiveX Release ' + AXVer;
  TeeMsg_ActiveXCannotImport := 'Cannot import TeeChart from %s';
  TeeMsg_ActiveXVerbPrint    := '&Print Preview...';
  TeeMsg_ActiveXVerbExport   := 'E&xport...';
  TeeMsg_ActiveXVerbImport   := '&Import...';
  TeeMsg_ActiveXVerbHelp     := '&Help...';
  TeeMsg_ActiveXVerbAbout    := '&About TeeChart...';
  TeeMsg_ActiveXError        := 'TeeChart: Error code: %d downloading: %s';
  TeeMsg_DatasourceError     := 'TeeChart DataSource is not a Series or RecordSet';
  TeeMsg_SeriesTextSrcError  := 'Invalid Series type';
  TeeMsg_AxisTextSrcError    := 'Invalid Axis type';
  TeeMsg_DelSeriesDatasource := 'Are you sure you want to delete %s ?';
  TeeMsg_OCXNoPrinter        := 'No default printer installed.';
  TeeMsg_ActiveXPictureNotValid:='Picture not valid';
  {$ENDIF}

  TeeMsg_SubTitle           :='������';
  TeeMsg_SubFoot            :='����β';
  TeeMsg_DepthTopAxis       :='���ᶥ';
  TeeMsg_Themes             :='������ʽ';
  TeeMsg_SelectorTool       :='ѡ����ʽ';

  // Missing:

  (*
  TeeMsg_NoSeriesSelected,
  TeeMsg_CannotLoadChartFromURL,
  TeeMsg_CannotLoadSeriesDataFromURL,

  { 5.02 }
  TeeMsg_AsJPEG,
  TeeMsg_JPEGFilter,
  TeeMsg_AsGIF,
  TeeMsg_GIFFilter,
  TeeMsg_AsPNG,
  TeeMsg_PNGFilter,
  TeeMsg_AsPCX,
  TeeMsg_PCXFilter,
  TeeMsg_AsVML,
  TeeMsg_VMLFilter,

  { 5.02 }
  TeeMsg_AskLanguage,

  { 5.03 }
  TeeMsg_Gradient,
  TeeMsg_WantToSave,
  TeeMsg_NativeFilter,
  TeeMsg_Property,
  TeeMsg_Value,
  TeeMsg_Yes,
  TeeMsg_No,
  TeeMsg_Image,

  { 6.0 }
  TeeMsg_FunctionCustom,
  TeeMsg_AsPDF,
  TeeMsg_PDFFilter,
  TeeMsg_AsPS,
  TeeMsg_PSFilter,
  TeeMsg_GalleryHorizArea,
  TeeMsg_SelfStack,
  TeeMsg_DarkPen,
  TeeMsg_SelectFolder,
  TeeMsg_BDEAlias,
  TeeMsg_ADOConnection,

  // 6.02
  TeeMsg_Apply,
  TeeMsg_AddNewGroup,
  TeeMsg_ChangeGroupName,
  TeeMsg_GroupName,
  TeeMsg_FunctionMedian,
  TeeMsg_FunctionMode,
  TeeMsg_Options,
  TeeMsg_DepthTopAxis,

  // 7.0
  TeeMsg_View2D,
  TeeMsg_Outline,

  // 7.05
  TeeMsg_TextFilter1,
  TeeMsg_TextFilter2,
  TeeMsg_TextFilter3,
  TeeMsg_TextFilter4,
  TeeMsg_TextFilter5,
  TeeMsg_XMLFilter,
  TeeMsg_HTMLFilter,
  TeeMsg_ExcelFilter,

  TeeMsg_ViewOrthoRight,
  TeeMsg_ViewOrthoLeft,
  TeeMsg_View3DFront,
  TeeMsg_View3DRight,
  TeeMsg_View3DLeft,
  TeeMsg_AsSVG,
  TeeMsg_SVGFilter,
  *)

end;

Procedure TeeCreateChineseSimp;
begin
  if not Assigned(TeeChineseSimpLanguage) then
  begin
    TeeChineseSimpLanguage:=TStringList.Create;
    TeeChineseSimpLanguage.Text:=

'GRADIENT EDITOR=���ʱ༭��'#13+
'SHADOW EDITOR=��Ӱ�༭��'#13+
'GRADIENT=����'#13+
'AUTO SIZE=�Զ�����'#13+
'VIEW 3D=3D��ʾ'#13+
'YES=��'#13+
'WHITE=��'#13+
'COLOR EACH POINT=��ɫ����'#13+
'DIRECTION=����'#13+
'VISIBLE=��ʾ'#13+
'TOP BOTTOM=������'#13+
'BOTTOM TOP=������'#13+
'LEFT RIGHT=������'#13+
'RIGHT LEFT=������'#13+
'FROM CENTER=������'#13+
'FROM TOP LEFT=������'#13+
'FROM BOTTOM LEFT=������'#13+
'OK=ȷ��'#13+
'CANCEL=ȡ��'#13+
'COLORS=��ɫ'#13+
'START=��ʼ'#13+
'MIDDLE=�м�'#13+
'END=����'#13+
'SWAP=�滻'#13+
'NO MIDDLE=���м�'#13+
'TEEFONT EDITOR=TeeFont �༭'#13+
'INTER-CHAR SPACING=��ĸ���'#13+
'FONT=����'#13+
'SHADOW=��Ӱ'#13+
'HORIZ. SIZE=ˮƽ��С'#13+
'VERT. SIZE=��ֱ��С'#13+
'COLOR=��ɫ'#13+
'OUTLINE=����'#13+
'OPTIONS=ѡ��'#13+
'FORMAT=��ʽ'#13+
'TEXT=����'#13+
'TEXT=����'#13+
'POSITION=λ��'#13+
'LEFT=��'#13+
'TOP=��'#13+
'AUTO=�Զ�'#13+
'CUSTOM=�Զ�'#13+
'LEFT TOP=����'#13+
'LEFT BOTTOM=����'#13+
'RIGHT TOP=����'#13+
'RIGHT BOTTOM=����'#13+
'MULTIPLE AREAS=�����'#13+
'NONE=��'#13+
'STACKED=�ѻ�'#13+
'STACKED 100%=�ѻ� 100%'#13+
'AREA=���'#13+
'PATTERN=����'#13+
'STAIRS=����'#13+
'SOLID=ʵ��'#13+
'CLEAR=͸��'#13+
'HORIZONTAL=����'#13+
'VERTICAL=ֱ��'#13+
'DIAGONAL=б��'#13+
'B.DIAGONAL=��б��'#13+
'CROSS=ʮ��'#13+
'DIAG.CROSS=����'#13+
'AREA LINES=�������'#13+
'BORDER=��Ե'#13+
'INVERTED=�ߵ�'#13+
'COLOR=��ɫ'#13+
'COLOR EACH=����ɫ'#13+
'ORIGIN=���ĵ�'#13+
'USE ORIGIN=ʹ��ԭ��'#13+
'SIDE MARGINS=��߽�����'#13+
'WIDTH=���'#13+
'HEIGHT=�߶�'#13+
'AXIS=��'#13+
'LENGTH=����'#13+
'POSITION=λ��'#13+
'SCROLL=��'#13+
'START=��ʼ'#13+
'END=����'#13+
'BOTH=����'#13+
'AXIS INCREMENT=��ĵ���ֵ'#13+
'INCREMENT=Increment'#13+
'INCREMENT=����'#13+
'STANDARD=��׼'#13+
'ONE MILLISECOND=һ����'#13+
'ONE SECOND=һ��'#13+
'FIVE SECONDS=����'#13+
'TEN SECONDS=ʮ��'#13+
'FIFTEEN SECONDS=ʮ����'#13+
'THIRTY SECONDS=��ʮ��'#13+
'ONE MINUTE=һ����'#13+
'FIVE MINUTES=�����'#13+
'TEN MINUTES=ʮ����'#13+
'FIFTEEN MINUTES=ʮ�����'#13+
'THIRTY MINUTES=��ʮ����'#13+
'ONE HOUR=һСʱ'#13+
'TWO HOURS=��Сʱ'#13+
'SIX HOURS=��Сʱ'#13+
'TWELVE HOURS=ʮ��Сʱ'#13+
'ONE DAY=һ��'#13+
'TWO DAYS=����'#13+
'THREE DAYS=����'#13+
'ONE WEEK=һ���'#13+
'HALF MONTH=�����'#13+
'ONE MONTH=һ����'#13+
'TWO MONTHS=������'#13+
'THREE MONTHS=������'#13+
'FOUR MONTHS=�ĸ���'#13+
'SIX MONTHS=������'#13+
'ONE YEAR=һ��'#13+
'EXACT DATE TIME=��ȷ����ʱ��'#13+
'AXIS MAXIMUM AND MINIMUM=��������Сֵ'#13+
'VALUE=��ֵ'#13+
'TIME=ʱ��'#13+
'LEFT AXIS=����'#13+
'RIGHT AXIS=����'#13+
'TOP AXIS=����'#13+
'BOTTOM AXIS=����'#13+
'% BAR WIDTH=% �������'#13+
'STYLE=��ʽ'#13+
'SYMBOL=����'#13+
'% BAR OFFSET=% ����ƫ��'#13+
'RECTANGLE=����'#13+
'PYRAMID=��׶��'#13+
'INVERT. PYRAMID=����׶��'#13+
'CYLINDER=Բ����'#13+
'ELLIPSE=��Բ��'#13+
'ARROW=��ͷ'#13+
'RECT. GRADIENT=���ʾ���'#13+
'CONE=Բ׶��'#13+
'DARK BAR 3D SIDES=3D ��������'#13+
'BAR SIDE MARGINS=������ı߽�'#13+
'AUTO MARK POSITION=�Զ���־λ��'#13+
'GRADIENT=����'#13+
'JOIN=����'#13+
'DATASET=������'#13+
'APPLY=����'#13+
'SOURCE=��Դ'#13+
'COLORS=��ɫ'#13+
'MONOCHROME=��ɫ'#13+
'DEFAULT=Ԥ��'#13+
'2 (1 BIT)=˫ɫ (1λ)'#13+
'16 (4 BIT)=16ɫ (4λ)'#13+
'256 (8 BIT)=256ɫ (8λ)'#13+
'32768 (15 BIT)=32768ɫ (15λ)'#13+
'65536 (16 BIT)=65536ɫ (16λ)'#13+
'16M (24 BIT)=16Mɫ (24λ)'#13+
'16M (32 BIT)=16Mɫ (32λ)'#13+
'MEDIAN=������'#13+
'WHISKER=������'#13+
'PATTERN COLOR EDITOR=������ɫ�༭'#13+
'IMAGE=ͼ��'#13+
'IMAGE=ͼ��'#13+
'SOLID=ʵɫ'#13+
'NONE=͸��'#13+
'BACK DIAGONAL=��б��'#13+
'DIAGONAL CROSS=����'#13+
'FILL 80%=���� 80%'#13+
'FILL 60%=���� 60%'#13+
'FILL 40%=���� 40%'#13+
'FILL 20%=���� 20%'#13+
'FILL 10%=���� 10%'#13+
'ZIG ZAG=���״'#13+
'VERTICAL SMALL=Сֱ��'#13+
'HORIZ. SMALL=С����'#13+
'DIAG. SMALL=Сб��'#13+
'BACK DIAG. SMALL=С��б��'#13+
'CROSS SMALL=Сʮ��'#13+
'DIAG. CROSS SMALL=С����'#13+
'DAYS=����'#13+
'WEEKDAYS=������'#13+
'TODAY=����'#13+
'SUNDAY=������'#13+
'TRAILING=֮��'#13+
'MONTHS=�·�'#13+
'LINES=����'#13+
'SHOW WEEKDAYS=��ʾ������'#13+
'UPPERCASE=��д'#13+
'TRAILING DAYS=֮������'#13+
'SHOW TODAY=��ʾ����'#13+
'SHOW MONTHS=��ʾ�·�'#13+
'UPPERCASE=��д'#13+
'CANDLE WIDTH=�����'#13+
'STYLE=��ʽ'#13+
'STICK=��״'#13+
'BAR=��״'#13+
'OPEN CLOSE=�����ر�'#13+
'UP CLOSE=�ر��Ϸ�'#13+
'DOWN CLOSE=�ر��·�'#13+
'SHOW OPEN=��ʾ����'#13+
'SHOW CLOSE=��ʾ�ؿ�'#13+
'BORDER=��Ե'#13+
'DRAW 3D=3D �滭'#13+
'DARK 3D=3D ����'#13+
'EDITING=�༭'#13+
'CHART=ͼ��'#13+
'SERIES=����'#13+
'DATA=����'#13+
'TOOLS=����'#13+
'EXPORT=���'#13+
'PRINT=��ӡ'#13+
'GENERAL=һ��'#13+
'AXIS=��'#13+
'TITLES=����'#13+
'LEGEND=ͼ��'#13+
'PANEL=���'#13+
'THEMES=��ʽ'#13+
'PAGING=��ҳ'#13+
'WALLS=�ڰ�'#13+
'3D=3D'#13+
'ADD=����'#13+
'DELETE=�Ƴ�'#13+
'TITLE=����'#13+
'CLONE=����'#13+
'CHANGE=���'#13+
'HELP=˵��'#13+
'CLOSE=�ر�'#13+
'SERIES=����'#13+
'TEECHART PRINT PREVIEW=TeeChart Ԥ����ӡ'#13+
'PRINTER=��ӡ��'#13+
'SETUP=�趨'#13+
'PRINT=��ӡ'#13+
'ORIENTATION=����'#13+
'PORTRAIT=����'#13+
'LANDSCAPE=����'#13+
'MARGINS (%)=�߽� (%)'#13+
'DETAIL=ϸ��'#13+
'MORE=��'#13+
'NORMAL=����'#13+
'RESET MARGINS=����߽�'#13+
'VIEW MARGINS=��ʾ�߽�'#13+
'PROPORTIONAL=������'#13+
'TEECHART PRINT PREVIEW=TeeChart Ԥ����ӡ'#13+
'STYLE=��ʽ'#13+
'TEXT=����'#13+
'CIRCLE=Բ��'#13+
'VERTICAL LINE=ֱ��'#13+
'HORIZ. LINE=����'#13+
'TRIANGLE=������'#13+
'INVERT. TRIANGLE=��������'#13+
'LINE=����'#13+
'DIAMOND=����'#13+
'CUBE=������'#13+
'DIAGONAL CROSS=����'#13+
'STAR=����'#13+
'BORDER=��Ե'#13+
'TRANSPARENT=͸��'#13+
'HORIZ. ALIGNMENT=ˮƽ����'#13+
'LEFT=����'#13+
'CENTER=����'#13+
'RIGHT=����'#13+
'ROUND RECTANGLE=Բ�Ǿ���'#13+
'ALIGNMENT=����'#13+
'TOP=����'#13+
'BOTTOM=����'#13+
'LEFT=��'#13+
'RIGHT=:��'#13+
'TOP=��'#13+
'BOTTOM=��'#13+
'UNITS=��λ'#13+
'PIXELS=����'#13+
'AXIS ORIGIN=�����ĵ�'#13+
'ROTATION=��ת'#13+
'CIRCLED=��Բ��'#13+
'3 DIMENSIONS=3D Ч��'#13+
'RADIUS=�뾶'#13+
'HORIZONTAL=ˮƽ'#13+
'VERTICAL=��ֱ'#13+
'COLOR=��ɫ'#13+
'ANGLE INCREMENT=�Ƕȵ���'#13+
'RADIUS INCREMENT=�뾶����'#13+
'CLOSE CIRCLE=�ر�Բ��'#13+
'PEN=���'#13+
'CIRCLE=Բ��'#13+
'PATTERN=����'#13+
'LABELS=���'#13+
'ROTATED=��ת'#13+
'CLOCKWISE=˳ʱ��'#13+
'INSIDE=�ڲ�'#13+
'ROMAN=����'#13+
'HOURS=Сʱ'#13+
'MINUTES=����'#13+
'SECONDS=����'#13+
'RADIUS=�뾶'#13+
'START VALUE=��ʼֵ'#13+
'END VALUE=����ֵ'#13+
'TRANSPARENCY=͸��'#13+
'DRAW BEHIND=�����²�'#13+
'COLOR MODE=��ɫģʽ'#13+
'STEPS=����'#13+
'STYLE=����'#13+
'RANGE=��Χ'#13+
'PALETTE=��ɫ��'#13+
'PALE=ǳ��'#13+
'STRONG=ǿ��'#13+
'GRID SIZE=���Ӵ�С'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=���'#13+
'IRREGULAR=�������'#13+
'GRID=���'#13+
'VALUE=��ֵ'#13+
'ALLOW DRAG=����ҷ'#13+
'VERTICAL POSITION=��ֱλ��'#13+
'LEVELS POSITION=���λ��'#13+
'LEVELS=���'#13+
'NUMBER=����'#13+
'LEVEL=���'#13+
'AUTOMATIC=�Զ�'#13+
'COLOR EACH=����ɫ'#13+
'STYLE=��ʽ'#13+
'HORIZONTAL=ˮƽ'#13+
'VERTICAL=��ֱ'#13+
'SNAP=����ƶ�'#13+
'FOLLOW MOUSE=�������'#13+
'STACK=�ѻ�'#13+
'HEIGHT 3D=3D �߶�'#13+
'LINE MODE=����ģʽ'#13+
'INVERTED=�ߵ�'#13+
'DARK 3D=3D ����'#13+
'OVERLAP=�ص�'#13+
'STACK=�ѻ�'#13+
'STACK 100%=�ѻ� 100%'#13+
'CLICKABLE=�ɵ�ѡ'#13+
'LABELS=���'#13+
'AVAILABLE=�й���Ŀ'#13+
'SELECTED=��ѡ��Ŀ'#13+
'DATASOURCE=������Դ'#13+
'NUMBER OF SAMPLE VALUES=��������'#13+
'GROUP BY=����'#13+
'CALC=����'#13+
'OF=֮'#13+
'SUM=�ܼ�'#13+
'COUNT=����'#13+
'HIGH=���'#13+
'LOW=���'#13+
'AVG=ƽ��'#13+
'HOUR=Сʱ'#13+
'DAY=��'#13+
'WEEK=���'#13+
'WEEKDAY=������'#13+
'MONTH=��'#13+
'QUARTER=��'#13+
'YEAR=��'#13+
'HOLE %=�� %'#13+
'RESET POSITIONS=����λ��'#13+
'MOUSE BUTTON=��갴��'#13+
'LEFT=���'#13+
'RIGHT=�Ҽ�'#13+
'MIDDLE=�м�'#13+
'ENABLE DRAWING=���û滭'#13+
'ENABLE SELECT=����ѡ��'#13+
'ENHANCED=��ǿ��ʽ'#13+
'ERROR WIDTH=�����'#13+
'WIDTH UNITS=��ȵ�λ'#13+
'PERCENT=�ٷֱ�'#13+
'PIXELS=����'#13+
'RIGHT=��'#13+
'LEFT AND RIGHT=������'#13+
'TOP AND BOTTOM=������'#13+
'BORDER EDITOR=��ʱ༭'#13+
'DASH=ʵ��'#13+
'DOT=����'#13+
'DASH DOT=����'#13+
'DASH DOT DOT=�����'#13+
'DASH=����'#13+
'DOT=����'#13+
'DASH DOT=�����'#13+
'DASH DOT DOT=������'#13+
'CALCULATE EVERY=����ÿ��'#13+
'ALL POINTS=���б��'#13+
'NUMBER OF POINTS=�������'#13+
'RANGE OF VALUES=��ֵ��Χ'#13+
'ALIGNMENT=����'#13+
'FIRST=���'#13+
'CENTER=�м�'#13+
'LAST=���'#13+
'TEEPREVIEW EDITOR=Ԥ���༭'#13+
'ALLOW MOVE=���ƶ�'#13+
'ALLOW RESIZE=������'#13+
'DRAG IMAGE=��ҷͼ��'#13+
'AS BITMAP=Ϊλͼ'#13+
'SHOW IMAGE=��ʾͼ��'#13+
'PORTRAIT=����'#13+
'LANDSCAPE=����'#13+
'MARGINS=�߽�'#13+
'SIZE=��С'#13+
'3D %=3D %'#13+
'ZOOM=����'#13+
'ELEVATION=����'#13+
'100%=100%'#13+
'HORIZ. OFFSET=ˮƽƫ��'#13+
'VERT. OFFSET=��ֱƫ��'#13+
'PERSPECTIVE=͸�����'#13+
'ANGLE=�Ƕ�'#13+
'ORTHOGONAL=ֱ��ͼ'#13+
'ZOOM TEXT=��������'#13+
'SCALES=�̶�'#13+
'TITLE=����'#13+
'TICKS=�Ǻ�'#13+
'MINOR=��Ҫ'#13+
'MAXIMUM=���ֵ'#13+
'MINIMUM=��Сֵ'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=����ĵ���ֵ'#13+
'(INCREMENT)=(increment)'#13+
'LOG BASE=������'#13+
'LOGARITHMIC=���ö���(Log)'#13+
'AUTO=�Զ�'#13+
'AUTO=�Զ�'#13+
'CHANGE=���'#13+
'CHANGE=���'#13+
'TITLE=����'#13+
'ANGLE=�Ƕ�'#13+
'MIN. SEPARATION %=��С���� %'#13+
'VISIBLE=��ʾ'#13+
'MULTI-LINE=����'#13+
'LABEL ON AXIS=������'#13+
'ROUND FIRST=������ֵ'#13+
'AUTO=�Զ�'#13+
'MARK=�Ǻ�'#13+
'LABELS FORMAT=����ʽ'#13+
'EXPONENTIAL=ָ��(Exponential)'#13+
'DEFAULT ALIGNMENT=Ԥ�����'#13+
'LEN=����'#13+
'TICKS=�Ǻ�'#13+
'INNER=�ڲ�'#13+
'AT LABELS ONLY=ֻ�ھ��'#13+
'CENTERED=����'#13+
'COUNT=����'#13+
'TICKS=�Ǻ�'#13+
'POSITION %=λ�� %'#13+
'START %=��ʼ %'#13+
'END %=���� %'#13+
'OTHER SIDE=��һ��'#13+
'AXES=��'#13+
'VISIBLE=��ʾ'#13+
'BEHIND=�²�'#13+
'CLIP POINTS=��ʾ��Χ��'#13+
'PRINT PREVIEW=Ԥ����ӡ'#13+
'ZOOM=����'#13+
'SCROLL=��'#13+
'STEPS=����'#13+
'MINIMUM PIXELS=���ٵ���'#13+
'DIRECTION=��λ'#13+
'MOUSE BUTTON=����'#13+
'ALLOW=����'#13+
'ANIMATED=����'#13+
'PEN=���'#13+
'PATTERN=����'#13+
'ALLOW SCROLL=�����'#13+
'NONE=��'#13+
'BOTH=����'#13+
'TEEOPENGL EDITOR=TeeOpenGL �༭'#13+
'AMBIENT LIGHT=��������'#13+
'SHININESS=����'#13+
'FONT 3D DEPTH=3D �������'#13+
'ACTIVE=��Ч'#13+
'FONT OUTLINES=��������'#13+
'SMOOTH SHADING=ƽ�������Ӱ'#13+
'LIGHT=�ƹ�'#13+
'Y=Y'#13+
'INTENSITY=ǿ�Ҷ�'#13+
'BEVEL=б��'#13+
'SIZE=��С'#13+
'FRAME=���'#13+
'ROUND FRAME=Բ�����'#13+
'TRANSPARENT=͸��'#13+
'LOWERED=����'#13+
'RAISED=����'#13+
'YES=��'#13+
'SYMBOLS=����'#13+
'TEXT STYLE=������ʽ'#13+
'LEGEND STYLE=ͼ����ʽ'#13+
'VERT. SPACING=��ֱ�ռ�'#13+
'AUTOMATIC=�Զ�'#13+
'SERIES NAMES=��������'#13+
'SERIES VALUES=������ֵ'#13+
'LAST VALUES=�����ֵ'#13+
'PLAIN=��ͨ'#13+
'LEFT VALUE=����ֵ'#13+
'RIGHT VALUE=����ֵ'#13+
'LEFT PERCENT=��ٷֱ�'#13+
'RIGHT PERCENT=�Ұٷֱ�'#13+
'X VALUE=X ��ֵ'#13+
'VALUE=��ֲ'#13+
'PERCENT=�ٷֱ�'#13+
'X AND VALUE=X �� ��ֵ'#13+
'X AND PERCENT=X �� �ٷֱ�'#13+
'CHECK BOXES=��ѡ��Ŀ'#13+
'DIVIDING LINES=�ָ���'#13+
'FONT SERIES COLOR=����������ɫ'#13+
'POSITION OFFSET %=λ��ƫ�� %'#13+
'MARGIN=�߽�'#13+
'RESIZE CHART=���ͼ���С'#13+
'WIDTH UNITS=��ȵ�λ'#13+
'LEFT=��'#13+
'RIGHT=��'#13+
'CONTINUOUS=������'#13+
'POINTS PER PAGE=ÿҳ�ı����'#13+
'SCALE LAST PAGE=���ŵ����һҳ'#13+
'SHOW PAGE NUMBER=��ʾҳ��'#13+
'CURRENT PAGE LEGEND=��ҳ��ʾͼ��'#13+
'PANEL EDITOR=���༭'#13+
'BACKGROUND=����'#13+
'BORDERS=��Ե'#13+
'COLOR=�����ɫ'#13+
'BACK IMAGE=����ͼ��'#13+
'STRETCH=չ��'#13+
'TILE=����'#13+
'INSIDE=��Χ֮��'#13+
'WIDTH=��'#13+
'WIDTH=��'#13+
'BEVEL INNER=��б��'#13+
'BEVEL OUTER=��б��'#13+
'MARKS=��־'#13

{$IFDEF LCL}
;  TeeChineseSimpLanguage.Text:=TeeChineseSimpLanguage.Text
{$ENDIF}

+
'DATA SOURCE=������Դ'#13+
'SORT=����'#13+
'CURSOR=ָ��'#13+
'SHOW IN LEGEND=��ʾ��ͼ��'#13+
'FORMATS=��ʽ'#13+
'VALUES=��ֵ'#13+
'PERCENTS=�ٷֱ�'#13+
'HORIZONTAL AXIS=����'#13+
'TOP=��'#13+
'BOTTOM=��'#13+
'TOP AND BOTTOM=������'#13+
'DATETIME=����ʱ��'#13+
'VERTICAL AXIS=ֱ��'#13+
'LEFT AND RIGHT=������'#13+
'DATETIME=����ʱ��'#13+
'ASCENDING=����'#13+
'DESCENDING=�ݼ�'#13+
'DRAW EVERY=��ÿ��'#13+
'CLIPPED=�޼�'#13+
'ARROWS=��ͷ'#13+
'MULTI LINE=����'#13+
'ALL SERIES VISIBLE=��ʾ��������'#13+
'LABEL=���'#13+
'LABEL AND PERCENT=�����ٷֱ�'#13+
'LABEL AND VALUE=�������ֵ'#13+
'LEGEND=ͼ��'#13+
'PERCENT TOTAL=�ܰٷֱ�'#13+
'X AND Y VALUES=X �� Y ��ֵ'#13+
'MANUAL=�ֶ�'#13+
'RANDOM=�����'#13+
'FUNCTION=����'#13+
'NEW=����'#13+
'EDIT=�޸�'#13+
'PERSISTENT=����'#13+
'ADJUST FRAME=�������'#13+
'LEFT=����'#13+
'CENTER=����'#13+
'RIGHT=����'#13+
'TOP=��'#13+
'SUBTITLE=�ӱ���'#13+
'SUBFOOT=�ӱ�β'#13+
'FOOT=��β'#13+
'ACTIVE=��Ч'#13+
'VISIBLE WALLS=��ʾ�ڰ�'#13+
'LEFT=����'#13+
'RIGHT=����'#13+
'BOTTOM=����'#13+
'BACK=��'#13+
'BORDER=��Ե'#13+
'DIF. LIMIT=�����'#13+
'LINES=����.'#13+
'ABOVE=����'#13+
'WITHIN=֮��'#13+
'BELOW=����'#13+
'CONNECTING LINES=��������'#13+
'HIGH=��'#13+
'LOW=��'#13+
'BROWSE=���'#13+
'TILED=������ʾ'#13+
'INFLATE MARGINS=�Ǵ�߽� '#13+
'SQUARE=������'#13+
'ROUND=Բ��'#13+
'FLAT=ƽ��'#13+
'DOWN TRIANGLE=��������'#13+
'SMALL DOT=С��'#13+
'DEFAULT=Ԥ��'#13+
'GLOBAL=����'#13+
'SHAPES=��״'#13+
'BRUSH=��ˢ'#13+
'GLOBAL=����'#13+
'BRUSH=��ˢ'#13+
'GLOBAL=����'#13+
'BORDER=��Ե'#13+
'DELAY=�ӳ�'#13+
'MSEC.=΢��'#13+
'LABEL AND PERCENT TOTAL=������ܰٷֱ�'#13+
'MOUSE ACTION=��궯��'#13+
'MOVE=�ƶ�'#13+
'CLICK=��ѡ'#13+
'SIZE=��С'#13+
'BRUSH=��ˢ'#13+
'DRAW LINE=����'#13+
'EXPLODE BIGGEST=�ֽ����'#13+
'TOTAL ANGLE=�ܽǶ�'#13+
'GROUP SLICES=����'#13+
'VALUE=��ֵ'#13+
'LABEL=���'#13+
'BELOW %=�ٷֱ�֮��'#13+
'BELOW VALUE=��ֵ֮��'#13+
'OTHER=Other'#13+
'PATTERNS=����'#13+
'DEPTH=���'#13+
'LINE=����'#13+
'SIZE %=��С %'#13+
'SERIES DATASOURCE TEXT EDITOR=ͼ��������Ե���ֱ༭'#13+
'FIELDS=Fields'#13+
'SOURCE=��Դ'#13+
'NUMBER OF HEADER LINES=��ͷ������'#13+
'SEPARATOR=�ָ���'#13+
'SERIES=����'#13+
'COMMA=����'#13+
'SPACE=�հ�'#13+
'TAB=Tab'#13+
'FILE=�ļ�'#13+
'VIEW=��ͼ'#13+
'DATA SOURCES=����Դ'#13+
'SERIES LIST=ͼ��ϵ��'#13+
'INSPECTOR=���������'#13+
'GALLERY=ͼ������'#13+
'STATUS BAR=״̬��'#13+
'PROPERTIES=����'#13+
'CHART TOOLS=ͼ����'#13+
'SAVE AS=���Ϊ'#13+
'REOPEN=���´�'#13+
'OPEN=��'#13+
'TOOLBARS=������'#13+
'SEND BY E-MAIL=�����ʼ�'#13+
'EXIT=�˳�'#13+
'NEW USING WIZARD=ͼ����'#13+
'PAGE=��ҳ'#13+
'NEW USING WIZARD=ͼ����'#13+

'SHOW AT LEGEND=��ʾͼ��'#13+
'SELECT=ѡ��'#13+
'SHOW SERIES MARKS=��ʾ���'#13+
'VIEW=��ʾ'#13+
'PREVIEW=Ԥ��'#13+
'PROPERTY=����'#13+
'ADD ANNOTATION=���ע��'#13+
'ENABLE ZOOM=�Ŵ�'#13+
'DRAW LINES=����'#13+
'SHOW HINTS=��ʾ��ʾ'#13+
'ENABLE SCROLL=�϶�'#13+
'BOLD=����'#13+
'ITALIC=б��'#13+
'UNDERLINE=�»���'#13+
'STRIKE OUT=ɾ����'#13+
'LEFT JUSTIFY=�����'#13+
'RIGHT JUSTIFY=�Ҷ���'#13+
'BORDER WIDTH=�߽���'#13+
'X VALUES=Xֵ'#13+
'TEXT LABELS=����'#13+
'SERIES=����'#13+
'SMOOTH=ƽ��'#13+
'WEB URL=��ַ'#13+
'LOAD=��ȡ'#13+
'C LABELS=C ���'#13+
'R LABELS=R ���'#13+
'C PEN=C ���'#13+
'R PEN=R ���'#13+
'CIRCLE=ԲȦ'#13+
'COLOR EACH=����ɫ'#13+
'FONT=����'#13+
'STACK GROUP=�ѷ�����'#13+
'USE ORIGIN=ʹ�����ĵ�'#13+
'MULTIPLE BAR=�೤��ͼ'#13+
'SIDE=���'#13+
'SIDE ALL=ȫ���'#13+
'DRAWING MODE=��ͼģʽ'#13+
'SOLID=ʵ��'#13+
'WIREFRAME=�����'#13+
'DOTFRAME=����'#13+
'SMOOTH PALETTE=ƽ��ɫ��'#13+
'SIDE BRUSH=�����ˢ'#13+
'ABOUT TEECHART PRO V7.0=�й� TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'VISIT OUR WEB SITE !=Visit our Web site !'#13+
'TEECHART WIZARD=TeeChart ����'#13+
'SELECT A CHART STYLE=Select a Chart style'#13+
'DATABASE CHART=Database Chart'#13+
'NON DATABASE CHART=Non Database Chart'#13+
'SELECT A DATABASE TABLE=Select a Database Table'#13+
'ALIAS=Alias'#13+
'TABLE=Table'#13+
'SOURCE=Source'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=Select the desired Fields to Chart'#13+
'SELECT A TEXT LABELS FIELD=Select a text labels Field'#13+
'CHOOSE THE DESIRED CHART TYPE=Choose the desired Chart type'#13+
'2D=2D'#13+
'CHART PREVIEW=ͼ��Ԥ��'#13+
'SHOW LEGEND=��ʾͼ��'#13+
'SHOW MARKS=��ʾ��־'#13+
'COLOR EACH=����ɫ'#13+
'< BACK=< ��һ��'#13+
'SELECT A CHART STYLE=Select a Chart style'#13+
'NON DATABASE CHART=Non Database Chart'#13+
'SELECT A DATABASE TABLE=Select a Database Table'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=Select the desired Fields to Chart'#13+
'SELECT A TEXT LABELS FIELD=Select a text labels Field'#13+
'CHOOSE THE DESIRED CHART TYPE=Choose the desired Chart type'#13+
'EXPORT CHART=���ͼ��'#13+
'PICTURE=ͼƬ'#13+
'NATIVE=ԭʼ'#13+
'FORMAT=��ʽ'#13+
'SIZE=��С'#13+
'HEIGHT=��'#13+
'KEEP ASPECT RATIO=������С����'#13+
'INCLUDE SERIES DATA=������������'#13+
'FILE SIZE=������С'#13+
'SERIES=����'#13+
'DELIMITER=�ָ���'#13+
'XML=XML'#13+
'HTML TABLE=HTML ���'#13+
'EXCEL=Excel'#13+
'COMMA=����'#13+
'COLON=ð��'#13+
'CUSTOM=�Զ�'#13+
'INCLUDE=����'#13+
'POINT LABELS=�����'#13+
'POINT INDEX=�������'#13+
'HEADER=��ͷ'#13+
'COPY=����'#13+
'SAVE=����'#13+
'SEND=����'#13+
'FUNCTIONS=����'#13+
'ADD=��'#13+
'ADX=��'#13+
'AVERAGE=ƽ��'#13+
'BOLLINGER=��'#13+
'COPY=��'#13+
'DIVIDE=��'#13+
'EXP. AVERAGE=��'#13+
'EXP.MOV.AVRG.=����'#13+
'HIGH=ADX'#13+
'LOW=Bollinger'#13+
'MACD=Exp. Avg.'#13+
'MOMENTUM=Exp. Mov. Avg.'#13+
'MOMENTUM DIV=MACD'#13+
'MOVING AVRG.=Momentum'#13+
'MULTIPLY=Momentum Div.'#13+
'R.S.I.=Moving Avg.'#13+
'ROOT MEAN SQ.=R.S.I.'#13+
'STD.DEVIATION=Root Mean Sq.'#13+
'STOCHASTIC=StdDeviation'#13+
'SUBTRACT=Stochastic'#13+
'SOURCE SERIES=��Դ����'#13+
'TEECHART GALLERY=TeeChart ������'#13+
'FUNCTIONS=����'#13+
'DITHER=ɫ��'#13+
'REDUCTION=ת��'#13+
'COMPRESSION=ѹ����ʽ'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Nearest'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'MONOCHROME=��ɫ'#13+
'GRAY SCALE=���Ҷ�'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% Ʒ��'#13+
'GRAY SCALE=�ҽ�'#13+
'PERFORMANCE=Ч��'#13+
'QUALITY=Ʒ��'#13+
'SPEED=�ٶ�'#13+
'COMPRESSION LEVEL=ѹ���̶�'#13+
'CHART TOOLS GALLERY=ͼ���߳�����'#13+
'ANNOTATION=��ת'#13+
'AXIS ARROWS=ָ��'#13+
'COLOR BAND=��ҷ��־'#13+
'COLOR LINE=����'#13+
'CURSOR=���ͷ'#13+
'DRAG MARKS=��־˵��'#13+
'DRAW LINE=ͼ��'#13+
'IMAGE=�����'#13+
'MARK TIPS=��ɫ��'#13+
'NEAREST POINT=��ɫ��'#13+
'SIDE MARGINS=��߽�����'#13+
'DATASOURCES=����Դ'#13+
'AUTO HIDE=�Զ�����'#13+
'COLOR EACH LINE=��ɫ����'#13+
'DISTANCE=����'#13+
'POINTER=��'#13+
'ARROW HEAD=��ͷ��״'#13+
'OUTLINE GRADIENT=��������'#13+
'BALANCE=ƽ��'#13+
'RADIAL OFFSET=����ƫ��'#13+
'SMOOTH=ƽ��'#13+
'HORIZ=ˮƽ����'#13+
'VERT=��ֱ����'#13+
'% BAR DEPTH=% �������'#13+
'SELF STACK=�ѻ���һ��'#13+
'TICK LINES=�����'#13+
'DEPTH TOP=���ᶥ'#13+
'OFFSET=ƫ��'#13+
'VALUE=ֵ'#13+
'SELECTOR=ѡ��'#13+

'DEFAULT BORDER=Ĭ�ϱ߿�'#13+
'SQUARED=������'#13+
'TEXT ALIGNMENT=�ı����뷽ʽ'#13+
'SEPARATION=�ָ�'#13+
'ROUND BORDER=Բ��'#13+
'ALLOW RESIZE CHART=��������ͼ'#13+

'POINT COLORS=����ɫ'#13+
'DRAW STYLE=���߸�ʽ'#13+
'FIXED POSITION=�̶�λ��'#13+
'HANDLES=��ʱ༭'#13+
'COLOR PALETTE=��ɫ��'#13+
'SCALE=��������'#13+
'RADIO BUTTONS=��ѡ��ť'#13+
'NO CHECK BOXES=�޸�ѡ��'#13+
'VIEWS=��ͼ'#13+
'THEME=��ʽ'#13+
'AXIS LINE=����'#13+
'MINOR GRID=��Ҫ������'#13+
'SERIES COLOR=������ɫ'#13+
'CHECK-BOXES=ѡ���'#13+
'CUSTOM POSITION=�Զ���λ��'#13+
'ROTATE=��ת'#13
;

// Pending:
(*
'PERIOD='#13+
'UP='#13+
'DOWN='#13+
'RADIAL='#13+
'DIAGONAL UP='#13+
'DIAGONAL DOWN='#13+
'SHADOW EDITOR='#13+
'CALLOUT='#13+
'TEXT ALIGNMENT='#13+
'DISTANCE='#13+
'ARROW HEAD='#13+
'POINTER='#13+
'50%='#13+
'AVAILABLE LANGUAGES='#13+
'CHOOSE A LANGUAGE='#13+
'CALCULATE USING='#13+
'EVERY NUMBER OF POINTS='#13+
'EVERY RANGE='#13+
'INCLUDE NULL VALUES='#13+
'INVERTED SCROLL='#13+
'ONE MICROSECOND='#13+
'DATE='#13+
'ENTER DATE='#13+
'ENTER TIME='#13+
'BEVEL SIZE='#13+
'SLANT CUBE='#13+
'INVERT. ARROW='#13+
'INVERT. CONE='#13+
'TICK LINES='#13+
'% BAR DEPTH='#13+
'DEVIATION='#13+
'UPPER='#13+
'LOWER='#13+
'METAL='#13+
'WOOD='#13+
'STONE='#13+
'CLOUDS='#13+
'GRASS='#13+
'FIRE='#13+
'SNOW='#13+
'NOTHING='#13+
'LEFT TRIANGLE='#13+
'RIGHT TRIANGLE='#13+
'SHOW PREVIOUS BUTTON='#13+
'SHOW NEXT BUTTON='#13+
'HIGH-LOW='#13+
'COLOR STYLE='#13+
'RELATIVE TO OPEN='#13+
'RELATIVE TO PREVIOUS CLOSE='#13+
'CONSTANT='#13+
'VIEW SERIES NAMES='#13+
'SHOW LABELS='#13+
'SHOW COLORS='#13+
'XYZ SERIES='#13+
'SHOW X VALUES='#13+
'EDIT COLOR='#13+
'DEFAULT COLOR='#13+
'MAKE NULL POINT='#13+
'APPEND ROW='#13+
'DELETE ROW='#13+
'TEXT FONT='#13+
'SMOOTH='#13+
'CHART THEME SELECTOR='#13+
'PREVIEW='#13+
'THEMES='#13+
'COLOR PALETTE='#13+
'VIEW 3D='#13+
'SCALE='#13+
'MARGIN %='#13+
'VOLUME SERIES='#13+
'ACCUMULATE='#13+
'DRAW BEHIND AXES='#13+
'GRID EVERY='#13+
'AXIS MAXIMUM='#13+
'AXIS CENTER='#13+
'AXIS MINIMUM='#13+
'DRAG REPAINT='#13+
'NO LIMIT DRAG='#13+
'DAILY (NONE)='#13+
'WEEKLY='#13+
'MONTHLY='#13+
'BI-MONTHLY='#13+
'QUARTERLY='#13+
'YEARLY='#13+
'DATE PERIOD='#13+
'TIME PERIOD='#13+
'INTERPOLATE='#13+
'CLICK TOLERANCE='#13+
'SNAP STYLE='#13+
'USE SERIES Z='#13+
'START X='#13+
'STEP='#13+
'NUM. POINTS='#13+
'COLOR EACH LINE='#13+
'DATATABLE EDITOR='#13+
'ROWS='#13+
'COLUMNS='#13+
'SYMBOL='#13+
'CASE SENSITIVE='#13+
'HIDE SERIES AT EDITOR='#13+
'SORT BY='#13+
'(NONE)='#13+
'CALCULATION='#13+
'GROUP='#13+
'DRAG STYLE='#13+
'SELECT NEW LINES='#13+
'WEIGHT='#13+
'EDIT LEGEND='#13+
'ROUND='#13+
'FLAT='#13+
'DRAW ALL='#13+
'IGNORE NULLS='#13+
'FILTERS='#13+
'SCALED='#13+
'NUMERIC FORMAT='#13+
'HH:MM='#13+
'DATE TIME='#13+
'GEOGRAPHIC='#13+
'DECIMALS='#13+
'FIXED='#13+
'THOUSANDS='#13+
'CURRENCY='#13+
'VIEWS='#13+
'OFFSET='#13+
'ALTERNATE='#13+
'ZOOM ON UP LEFT DRAG='#13+
'LIGHT 0='#13+
'LIGHT 1='#13+
'LIGHT 2='#13+
'SPOT='#13+
'FIXED POSITION='#13+
'SET DIRECTION='#13+
'DRAW STYLE='#13+
'POINTS='#13+
'ANTI-ALIAS LINES='#13+
'X='#13+
'Y='#13+
'Z='#13+
'NO CHECK BOXES='#13+
'RADIO BUTTONS='#13+
'SHOW PAGE NUMBER='#13+
'AUTO SCALE AXIS='#13+
'NO PAGES='#13+
'SEPARATION='#13+
'ROUND BORDER='#13+
'Z DATETIME='#13+
'SHOW IN THIS EDITOR='#13+
'NUMBER OF SAMPLE VALUES='#13+
'REMOVE='#13+
'AUTO HIDE='#13+
'RESIZE PIXELS TOLERANCE='#13+
'FULL REPAINT='#13+
'END POINT='#13+
'SINGLE='#13+
'REMOVE CUSTOM COLORS='#13+
'GALLERY='#13+
'LEGEND EVERY='#13+
'USE PALETTE MINIMUM='#13+
'CUSTOM PALETTES='#13+
'INVERTED GRAY='#13+
'RAINBOW='#13+
'VICTORIAN='#13+
'PASTELS='#13+
'CLASSIC='#13+
'WEB='#13+
'MODERN='#13+
'WIN. XP='#13+
'BAND 1='#13+
'BAND 2='#13+
'GRID 3D SERIES='#13+
'TRANSPOSE NOW='#13+
'TEECHART LIGHTING='#13+
'FACTOR='#13+
'LINEAR='#13+
'SPOTLIGHT='#13+
'PERIOD 1='#13+
'PERIOD 2='#13+
'PERIOD 3='#13+
'HISTOGRAM='#13+
'EXP. LINE='#13+
'SHAPE INDEX='#13+
'CLOSED='#13+
'HIDE DELAY='#13+
'WEIGHTED='#13+
'WEIGHTED BY INDEX='#13+
'DESIGN TIME OPTIONS='#13+
'LANGUAGE='#13+
'CHART GALLERY='#13+
'MODE='#13+
'CHART EDITOR='#13+
'REMEMBER SIZE='#13+
'REMEMBER POSITION='#13+
'TREE MODE='#13+
'RESET='#13+
'NEW CHART='#13+
'DEFAULT THEME='#13+
'TEECHART DEFAULT='#13+
'BUSINESS='#13+
'BLUES='#13+
'FACTS='#13+
'DARK BORDER='#13+
'MULTIPLE PIES='#13+
'3D GRADIENT='#13+
'DISABLE='#13+
'COLOR EACH SLICE='#13+
'PIE SERIES='#13+
'FOCUS='#13+
'EXPLODE='#13+
'BASE LINE='#13+
'BOX SIZE='#13+
'REVERSAL AMOUNT='#13+
'PERCENTAGE='#13+
'COMPLETE R.M.S.='#13+
'BUTTON='#13+
'INITIAL DELAY='#13+
'THUMB='#13+
'AUTO-REPEAT='#13+
'BACK COLOR='#13+
'HANDLES='#13+
'ALLOW RESIZE CHART='#13+
'LOOP='#13+
'START AT MIN. VALUE='#13+
'EXECUTE !='#13+
'ONE WAY='#13+
'CIRCULAR='#13+
'DRAW BEHIND SERIES='#13+
'IMAG. SYMBOL='#13+
'SELF STACK='#13+
'SURFACE='#13+
'CELL='#13+
'ROW='#13+
'COLUMN='#13+
'SIDE LINES='#13+
'FAST BRUSH='#13+
'SVG OPTIONS='#13+
'TEXT ANTI-ALIAS='#13+
'LEGEND SYMBOL EDITOR='#13+
'DEFAULT BORDER='#13+
'SQUARED='#13+
'CHART FROM TEMPLATE (*.TEE FILE)='#13+
'THEME='#13+
'OPEN TEECHART TEMPLATE FILE FROM='#13+
'ALIAS='#13+
'TABLE='#13+
'SELECT A TEXT LABELS FIELD='#13+
'EXPORT DIALOG='#13+
'BINARY='#13+
'TEXT QUOTES='#13+
'POINT COLORS='#13+
'OUTLINE GRADIENT='#13+
'CROSS POINTS='#13+
'CUMULATIVE='#13+
'CURVE FITTING='#13+
'DOWNSAMPLING='#13+
'EXP. TREND='#13+
'PERIMETER='#13+
'SMOOTHING='#13+
'TREND='#13+
'VOLUME OSCILLATOR='#13+
'DIRECTIONS='#13+
'ACE='#13+
'CARIBE SUN='#13+
'CLEAR DAY='#13+
'DESERT='#13+
'FARM='#13+
'FUNKY='#13+
'GOLF='#13+
'HOT='#13+
'NIGHT='#13+
'PASTEL='#13+
'SEA='#13+
'SEA 2='#13+
'SUNSET='#13+
'TROPICAL='#13+
'BALANCE='#13+
'RADIAL OFFSET='#13+
'HORIZ='#13+
'VERT='#13+
'COVER='#13+
'HIDE TRIANGLES='#13+
'ARROW WIDTH='#13+
'ARROW HEIGHT='#13+
'CONE PERCENT='#13+
'GRADIENT DIRECTION='#13+
'BRUSH BACK CLEAR='#13+
'MIRRORED='#13+
'VALUE SOURCE='#13+
'LOAD MODE='#13+
'APPEND='#13+
*)

  end;
end;

Procedure TeeSetChineseSimp;
begin
  TeeCreateChineseSimp;
  TeeLanguage:=TeeChineseSimpLanguage;
  TeeChineseSimpConstants;
  TeeLanguageHotKeyAtEnd:=True;
  TeeLanguageCanUpper:=False;
end;

initialization
finalization
  FreeAndNil(TeeChineseSimpLanguage);
end.

