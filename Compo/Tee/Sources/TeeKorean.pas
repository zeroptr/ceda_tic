unit TeeKorean;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeKoreanLanguage:TStringList=nil;

Procedure TeeSetKorean;
Procedure TeeCreateKorean;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeKoreanConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 by David Berneda';

  TeeMsg_Test               :='�׽�Ʈ...';
  TeeMsg_LegendFirstValue   :='ù��° ���ʰ��� 0 ���� Ŀ���մϴ�.';
  TeeMsg_LegendColorWidth   :='���� �� �ʺ�� 0% �̻��Դϴ�.';
  TeeMsg_SeriesSetDataSource:='������Ʈ�� ������ ��õ�� �ٸ��� �ʽ��ϴ�.';
  TeeMsg_SeriesInvDataSource:='�����Ͱ� �ٸ��� �ʽ��ϴ�.: %s';
  TeeMsg_FillSample         :='���ð�ä����� ���� 0 �̻��Դϴ�.';
  TeeMsg_AxisLogDateTime    :='�ð����� �α�ȭ �� �� �����ϴ�.';
  TeeMsg_AxisLogNotPositive :='�α����� �ִ�, �ּҴ� 0 �̻��Դϴ�.';
  TeeMsg_AxisLabelSep       :='�� �и����� 0 ���� Ů�ϴ�.';
  TeeMsg_AxisIncrementNeg   :='�� ������ 0 �̻��Դϴ�.';
  TeeMsg_AxisMinMax         :='�� ���ϰ��� �ִ밪 �����Դϴ�.';
  TeeMsg_AxisMaxMin         :='�� �ִ밪�� �ּҰ� �̻��Դϴ�.';
  TeeMsg_AxisLogBase        :='�α��� �ؼ��� 2 �̻��Դϴ�.';
  TeeMsg_MaxPointsPerPage   :='�������� �ִ�����Ʈ�� 0 �̻��Դϴ�.';
  TeeMsg_3dPercent          :='3D ȿ�� ������� %d ���� %d ���� �Դϴ�.';
  TeeMsg_CircularSeries     :='���� �迭�� ������ ������ �ʽ��ϴ�.';
  TeeMsg_WarningHiColor     :='���� ȭ���� ���ؼ��� 16k �÷��̰ų� �� �̻� �Ǿ�� �մϴ�.';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='�� ����';
  TeeMsg_AxisLabels         :='�� ��';
  TeeMsg_RefreshInterval    :='���ΰ�ħ ������ 0 ���� 60 ���� �Դϴ�.';
  TeeMsg_SeriesParentNoSelf :='�迭�� �θ� ��Ʈ�� �ڱ��ڽ��� �� �����ϴ�.';
  TeeMsg_GalleryLine        :='����';
  TeeMsg_GalleryPoint       :='����Ʈ��';
  TeeMsg_GalleryArea        :='������';
  TeeMsg_GalleryBar         :='���� ������';
  TeeMsg_GalleryHorizBar    :='���� ������';
  TeeMsg_Stack              :='����';
  TeeMsg_GalleryPie         :='����';
  TeeMsg_GalleryCircled     :='��';
  TeeMsg_GalleryFastLine    :='���� ����';
  TeeMsg_GalleryHorizLine   :='���� ����';

  TeeMsg_PieSample1         :='�ڵ���';
  TeeMsg_PieSample2         :='��ȭ��';
  TeeMsg_PieSample3         :='���̺�';
  TeeMsg_PieSample4         :='�����';
  TeeMsg_PieSample5         :='����';
  TeeMsg_PieSample6         :='Ű����';
  TeeMsg_PieSample7         :='������';
  TeeMsg_PieSample8         :='����';

  TeeMsg_GalleryLogoFont    :='����';
  TeeMsg_Editing            :='���� %s';

  TeeMsg_GalleryStandard    :='ǥ��';
  TeeMsg_GalleryExtended    :='Ȯ��';
  TeeMsg_GalleryFunctions   :='�Լ�';

  TeeMsg_EditChart          :='��Ʈ ����(&d)...';
  TeeMsg_PrintPreview       :='��� �̸�����(&p)...';
  TeeMsg_ExportChart        :='��Ʈ ��������(&x)...';
  TeeMsg_CustomAxes         :='����� ��...';

  TeeMsg_InvalidEditorClass :='%s: ��ȿ���� ���� Editor Class: %s';
  TeeMsg_MissingEditorClass :='%s: ��(��) Editor Dialog�� ������ ���� �ʽ��ϴ�.';

  TeeMsg_GalleryArrow       :='ȭ��ǥ��';

  TeeMsg_ExpFinish          :='����(&f)';
  TeeMsg_ExpNext            :='����(&n) >';

  TeeMsg_GalleryGantt       :='��Ʈ��';

  TeeMsg_GanttSample1       :='������';
  TeeMsg_GanttSample2       :='����';
  TeeMsg_GanttSample3       :='����';
  TeeMsg_GanttSample4       :='�Ǹ�';
  TeeMsg_GanttSample5       :='������';
  TeeMsg_GanttSample6       :='����';
  TeeMsg_GanttSample7       :='����';
  TeeMsg_GanttSample8       :='����';
  TeeMsg_GanttSample9       :='�� ����';
  TeeMsg_GanttSample10      :='����';

  TeeMsg_ChangeSeriesTitle  :='�迭 ���� �ٲٱ�';
  TeeMsg_NewSeriesTitle     :='���ο� �迭 ����:';
  TeeMsg_DateTime           :='�Ͻ�';
  TeeMsg_TopAxis            :='�� ��';
  TeeMsg_BottomAxis         :='�Ʒ� ��';
  TeeMsg_LeftAxis           :='���� ��';
  TeeMsg_RightAxis          :='������ ��';

  TeeMsg_SureToDelete       :='%s ��(��) ����ڽ��ϱ�?';
  TeeMsg_DateTimeFormat     :='�Ͻ� ����(&m)';
  TeeMsg_Default            :='�⺻��';
  TeeMsg_ValuesFormat       :='�� ����(&m)';
  TeeMsg_Maximum            :='�ִ밪';
  TeeMsg_Minimum            :='�ּҰ�';
  TeeMsg_DesiredIncrement   :='���ϴ� %s ����ġ ';

  TeeMsg_IncorrectMaxMinValue:='�߸��� ���Դϴ�. ����: %s';
  TeeMsg_EnterDateTime      :='�Է��Ͻʽÿ� [�ϼ�] [�ð�:��:��]';

  TeeMsg_SureToApply        :='�ٲ� ������ �����Ͻðڽ��ϱ�?';
  TeeMsg_SelectedSeries     :='(���õ� �迭)';
  TeeMsg_RefreshData        :='������ ���ΰ�ħ(&r)';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='���ϱ�';
  TeeMsg_FunctionSubtract   :='����';
  TeeMsg_FunctionMultiply   :='���ϱ�';
  TeeMsg_FunctionDivide     :='������';
  TeeMsg_FunctionHigh       :='������';
  TeeMsg_FunctionLow        :='������';
  TeeMsg_FunctionAverage    :='��հ�';

  TeeMsg_GalleryShape       :='������';
  TeeMsg_GalleryBubble      :='��ǰ��';
  TeeMsg_FunctionNone       :='����';

  TeeMsg_None               :='(����)';

  TeeMsg_PrivateDeclarations:='{ ���� ���� }';
  TeeMsg_PublicDeclarations :='{ ���� ���� }';
  TeeMsg_DefaultFontName    :={$IFDEF CLX}'Helvetica'{$ELSE}'Arial'{$ENDIF};
  TeeMsg_CheckPointerSize   :='������ ũ��� 0 ���� Ŀ�� �մϴ�.';
  TeeMsg_About              :='��Ʈ�� ���ؼ�(&u)...';

  tcAdditional              :='�ΰ�����';
  tcDControls               :='������ ����';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='�����ͼ�';
  TeeMsg_AskDataSet         :='�����ͼ�(&d):';

  TeeMsg_SingleRecord       :='���� ���ڵ�';
  TeeMsg_AskDataSource      :='�����Ϳ�õ(&d)';

  TeeMsg_Summary            :='���';

  TeeMsg_FunctionPeriod     :='�Լ� �Ⱓ�� 0 �̻��Դϴ�.';

  TeeMsg_WizardTab          :='����Ͻ�';
  TeeMsg_TeeChartWizard     :='��Ʈ ������';

  TeeMsg_ClearImage         :='�����(&r)';
  TeeMsg_BrowseImage        :='�˻�â(&r)...';

  TeeMsg_WizardSureToClose  :='��Ʈ �����縦 �����Ͻðڽ��ϱ�?';
  TeeMsg_FieldNotFound      :='%s �ʵ尡 �������� �ʽ��ϴ�.';

  TeeMsg_DepthAxis          :='���� ��';
  TeeMsg_PieOther           :='��Ÿ';
  TeeMsg_ShapeGallery1      :='������';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='��';
  TeeMsg_ValuesBar          :='����';
  TeeMsg_ValuesAngle        :='����';
  TeeMsg_ValuesGanttStart   :='����';
  TeeMsg_ValuesGanttEnd     :='��';
  TeeMsg_ValuesGanttNextTask:='����';
  TeeMsg_ValuesBubbleRadius :='������';
  TeeMsg_ValuesArrowEndX    :='X��';
  TeeMsg_ValuesArrowEndY    :='Y��';
  TeeMsg_Legend             :='����';
  TeeMsg_Title              :='����';
  TeeMsg_Foot               :='����';
  TeeMsg_Period		          :='�Ⱓ';
  TeeMsg_PeriodRange        :='�Ⱓ ����';
  TeeMsg_CalcPeriod         :='�� %s���� ���';
  TeeMsg_SmallDotsPen       :='���� ����';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' file �ȿ� ��ȿ���� ���� ��Ʈ';
  TeeMsg_WrongTeeFileFormat :='�߸��� *.'+TeeMsg_TeeExtension+' file ����';
  TeeMsg_EmptyTeeFile       :='����ִ� *.'+TeeMsg_TeeExtension+' file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := '��Ʈ ��';
  TeeMsg_ChartAxesCategoryDesc   := '��Ʈ �� �Ӽ��� �̺�Ʈ';
  TeeMsg_ChartWallsCategoryName  := '��Ʈ ����';
  TeeMsg_ChartWallsCategoryDesc  := '��Ʈ ���� �Ӽ��� �̺�Ʈ';
  TeeMsg_ChartTitlesCategoryName := '��Ʈ ����';
  TeeMsg_ChartTitlesCategoryDesc := '��Ʈ ���� �Ӽ��� �̺�Ʈ';
  TeeMsg_Chart3DCategoryName     := '3D ��Ʈ';
  TeeMsg_Chart3DCategoryDesc     := '3D ��Ʈ �Ӽ��� �̺�Ʈ';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='����� ���� ';
  TeeMsg_Series                 :='�迭';
  TeeMsg_SeriesList             :='�迭...';

  TeeMsg_PageOfPages            :='%d / %d ������';
  TeeMsg_FileSize               :='%d ����Ʈ';

  TeeMsg_First  :='�� ��';
  TeeMsg_Prior  :='����';
  TeeMsg_Next   :='����';
  TeeMsg_Last   :='�� ��';
  TeeMsg_Insert :='����';
  TeeMsg_Delete :='����';
  TeeMsg_Edit   :='����';
  TeeMsg_Post   :='Ȯ��';
  TeeMsg_Cancel :='���';

  TeeMsg_All    :='(��ü)';
  TeeMsg_Index  :='�ε���';
  TeeMsg_Text   :='�ؽ�Ʈ';

  TeeMsg_AsBMP        :='��Ʈ������(&b)';
  TeeMsg_BMPFilter    :='��Ʈ�� (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='��Ÿ���Ϸ�(&m)';
  TeeMsg_EMFFilter    :='���� ��Ÿ���� (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := '�г� �Ӽ��� �������� ���Ŀ� ������ �� �����ϴ�.';

  TeeMsg_Normal    :='�Ϲ�';
  TeeMsg_NoBorder  :='�׵θ� ����';
  TeeMsg_Dotted    :='����';
  TeeMsg_Colors    :='��';
  TeeMsg_Filled    :='ä��';
  TeeMsg_Marks     :='ǥ��';
  TeeMsg_Stairs    :='���';
  TeeMsg_Points    :='����Ʈ';
  TeeMsg_Height    :='����';
  TeeMsg_Hollow    :='����';
  TeeMsg_Point2D   :='2D ����Ʈ';
  TeeMsg_Triangle  :='�ﰢ';
  TeeMsg_Star      :='��';
  TeeMsg_Circle    :='��';
  TeeMsg_DownTri   :='���ﰢ';
  TeeMsg_Cross     :='���ڰ�';
  TeeMsg_Diamond   :='���̾Ƹ��';
  TeeMsg_NoLines   :='�� ����';
  TeeMsg_Stack100  :='���� 100%';
  TeeMsg_Pyramid   :='�Ƕ�̵�';
  TeeMsg_Ellipse   :='Ÿ��';
  TeeMsg_InvPyramid:='���Ƕ�̵�';
  TeeMsg_Sides     :='����';
  TeeMsg_SideAll   :='�迭 ����';
  TeeMsg_Patterns  :='����';
  TeeMsg_Exploded  :='�и��� ��';
  TeeMsg_Shadow    :='�׸���';
  TeeMsg_SemiPie   :='�ݿ�';
  TeeMsg_Rectangle :='�簢��';
  TeeMsg_VertLine  :='���� ��';
  TeeMsg_HorizLine :='���� ��';
  TeeMsg_Line      :='��';
  TeeMsg_Cube      :='������ü';
  TeeMsg_DiagCross :='�밢�� ������';

  TeeMsg_CanNotFindTempPath    :='�ӽ� ������ ã�� �� �����ϴ�.';
  TeeMsg_CanNotCreateTempChart :='�ӽ� ������ ������ �� �����ϴ�.';
  TeeMsg_CanNotEmailChart      :='email�� ����� �� �����ϴ�. Mapi ����: %d';

  TeeMsg_SeriesDelete :='�迭 ����: �ε����� %d ���� �ʰ� (0 ���� %d)';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='JPEG��(&j)';
  TeeMsg_JPEGFilter    :='JPEG ���� (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='GIF��(&g)';
  TeeMsg_GIFFilter     :='GIF ���� (*.gif)|*.gif';
  TeeMsg_AsPNG         :='PNG��(&p)';
  TeeMsg_PNGFilter     :='PNG ���� (*.png)|*.png';
  TeeMsg_AsPCX         :='PCX��(&x)';
  TeeMsg_PCXFilter     :='PCX ���� (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='VML��(&v) (HTM)';
  TeeMsg_VMLFilter     :='VML files (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='���(&l)...';

  { 5.03 }
  TeeMsg_Gradient     :='��ȭ';
  TeeMsg_WantToSave   :='%s ��(��) �����Ͻðڽ��ϱ�?';
  TeeMsg_NativeFilter :='��Ʈ ����';

  TeeMsg_Property     :='�Ӽ�';	
  TeeMsg_Value        :='��';
  TeeMsg_Yes          :='��';
  TeeMsg_No           :='�ƴϿ�';
  TeeMsg_Image        :='(�̹���)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='������';
  TeeMsg_GalleryCandle      :='�ֽĸ�����';
  TeeMsg_GalleryVolume      :='���� ���θ�����';
  TeeMsg_GallerySurface     :='ǥ����';
  TeeMsg_GalleryContour     :='�����';
  TeeMsg_GalleryBezier      :='��������';
  TeeMsg_GalleryPoint3D     :='3D ����Ʈ��';
  TeeMsg_GalleryRadar       :='���̴���';
  TeeMsg_GalleryDonut       :='������';
  TeeMsg_GalleryCursor      :='Ŀ��';
  TeeMsg_GalleryBar3D       :='3D ������';
  TeeMsg_GalleryBigCandle   :='ū �ֽĸ�����';
  TeeMsg_GalleryLinePoint   :='�� ����Ʈ��';
  TeeMsg_GalleryHistogram   :='���� �׷�����';
  TeeMsg_GalleryWaterFall   :='��������';
  TeeMsg_GalleryWindRose    :='��ħ����';
  TeeMsg_GalleryClock       :='�ð���';
  TeeMsg_GalleryColorGrid   :='���׸�����';
  TeeMsg_GalleryBoxPlot     :='���� BoxPlot��';
  TeeMsg_GalleryHorizBoxPlot:='���� BoxPlot��';
  TeeMsg_GalleryBarJoin     :='���� ������';
  TeeMsg_GallerySmith       :='���̽���';
  TeeMsg_GalleryPyramid     :='�Ƕ�̵���';
  TeeMsg_GalleryMap         :='������';

  TeeMsg_PolyDegreeRange    :='���� ������ 1 ���� 20 �����Դϴ�.';
  TeeMsg_AnswerVectorIndex   :='���� �ε����� 1 ���� %d �����Դϴ�.';
  TeeMsg_FittingError        :='����ȭ �� �� �����ϴ�.';
  TeeMsg_PeriodRange         :='�Ⱓ�� 0 �̻��Դϴ�.';
  TeeMsg_ExpAverageWeight    :='���� ��� ����ġ�� 0 ���� 1 �����Դϴ�.';
  TeeMsg_GalleryErrorBar     :='���� ������';
  TeeMsg_GalleryError        :='������';
  TeeMsg_GalleryHighLow      :='������';
  TeeMsg_FunctionMomentum    :='���Ʈ��';
  TeeMsg_FunctionMomentumDiv :='���Ʈ ������';
  TeeMsg_FunctionExpAverage  :='���� ���';
  TeeMsg_FunctionMovingAverage:='�̵� ���';
  TeeMsg_FunctionExpMovAve   :='���� �̵� ���';
  TeeMsg_FunctionRSI         :='��밭������';
  TeeMsg_FunctionCurveFitting:='���';
  TeeMsg_FunctionTrend       :='�߼�';
  TeeMsg_FunctionExpTrend    :='���� �߼�';
  TeeMsg_FunctionLogTrend    :='�α� �߼�';
  TeeMsg_FunctionCumulative  :='����';
  TeeMsg_FunctionStdDeviation:='ǥ�� ����';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='������ ����';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Ȯ��';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='�հ�';
  TeeMsg_LoadChart           :='��Ʈ ����...';
  TeeMsg_SaveChart           :='��Ʈ ����...';
  TeeMsg_TeeFiles            :='��Ʈ ����';

  TeeMsg_GallerySamples      :='��Ÿ';
  TeeMsg_GalleryStats        :='����';

  TeeMsg_CannotFindEditor    :='�迭 ����â�� ã�� �� �����ϴ�.: %s';


  TeeMsg_CannotLoadChartFromURL:='���� �ڵ�: %d ��Ʈ �ٿ�ε� URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='���� �ڵ�: %d �迭 ������ �ٿ�ε� URL: %s';

  TeeMsg_ValuesDate          :='��¥';
  TeeMsg_ValuesOpen          :='����';
  TeeMsg_ValuesHigh          :='����';
  TeeMsg_ValuesLow           :='����';
  TeeMsg_ValuesClose         :='����';
  TeeMsg_ValuesOffset        :='������';
  TeeMsg_ValuesStdError      :='ǥ�ؿ���';

  TeeMsg_Grid3D              :='3D �׸���';

  TeeMsg_LowBezierPoints     :='�������� ������ ���� 1���� Ŀ���մϴ�.';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='ǥ��';
  TeeCommanMsg_Edit     :='����';
  TeeCommanMsg_Print    :='����Ʈ';
  TeeCommanMsg_Copy     :='����';
  TeeCommanMsg_Save     :='����';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='ȸ��: %d? ����: %d?';
  TeeCommanMsg_Rotate   :='ȸ��';

  TeeCommanMsg_Moving   :='���� ������: %d ���� ������: %d';
  TeeCommanMsg_Move     :='�̵�';

  TeeCommanMsg_Zooming  :='��: %d %%';
  TeeCommanMsg_Zoom     :='��';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='����';

  TeeCommanMsg_Chart    :='��Ʈ';
  TeeCommanMsg_Panel    :='�г�';

  TeeCommanMsg_RotateLabel:='ȸ���� ���� �巡�� %s';
  TeeCommanMsg_MoveLabel  :='�̵��� ���� �巡�� %s';
  TeeCommanMsg_ZoomLabel  :='���� ���� �巡�� %s';
  TeeCommanMsg_DepthLabel :='3D ũ�� �缳���� ���� �巡�� %s';

  TeeCommanMsg_NormalLabel:='���� ��ư�� �巡���ϸ� ��, ������ ��ư�� ��ũ�� �˴ϴ�.';
  TeeCommanMsg_NormalPieLabel:='���� ������ �巡���ϸ� �и��� �� �ֽ��ϴ�.';

  TeeCommanMsg_PieExploding :='����: %d �и�: %d %%';

  TeeMsg_TriSurfaceLess        :='����Ʈ ������ 4 �̻��̾�� �մϴ�.';
  TeeMsg_TriSurfaceAllColinear :='���ϼ����� ��� ������ ����Ʈ';
  TeeMsg_TriSurfaceSimilar     :='������ ����Ʈ - ������ �� �����ϴ�.';
  TeeMsg_GalleryTriSurface     :='�ﰢ ǥ����';

  TeeMsg_AllSeries :='��� �迭';
  TeeMsg_Edit      :='����';

  TeeMsg_GalleryFinancial    :='����';

  TeeMsg_CursorTool    :='Ŀ��';
  TeeMsg_DragMarksTool :='ǥ�� �巡��';
  TeeMsg_AxisArrowTool :='�� ȭ��ǥ';
  TeeMsg_DrawLineTool  :='�� �׸���';
  TeeMsg_NearestTool   :='��ó ����Ʈ';
  TeeMsg_ColorBandTool :='�����';
  TeeMsg_ColorLineTool :='�� ��';
  TeeMsg_RotateTool    :='ȸ��';
  TeeMsg_ImageTool     :='�̹���';
  TeeMsg_MarksTipTool  :='��Ʈ ǥ��';
  TeeMsg_AnnotationTool:='�ּ�';

  TeeMsg_CantDeleteAncestor  :='������ ���� �� �����ϴ�.';

  TeeMsg_Load	          :='�ҷ�����...';
  TeeMsg_NoSeriesSelected :='���õ� �迭�� �����ϴ�.';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='��Ʈ';
  TeeMsg_CategorySeriesActions :='��Ʈ �迭';

  TeeMsg_Action3D               := '3D(&3)';
  TeeMsg_Action3DHint           := '2D / 3D ��ȯ';
  TeeMsg_ActionSeriesActive     := 'Ȱ��ȭ(&a)';
  TeeMsg_ActionSeriesActiveHint := '�迭 ���� / ����';
  TeeMsg_ActionEditHint         := '��Ʈ ����';
  TeeMsg_ActionEdit             := '����(&e)...';
  TeeMsg_ActionCopyHint         := 'Ŭ������� ����';
  TeeMsg_ActionCopy             := '����(&c)';
  TeeMsg_ActionPrintHint        := '��Ʈ �̸�����';
  TeeMsg_ActionPrint            := '�μ�(&p)...';
  TeeMsg_ActionAxesHint         := '�� ���� / ����';
  TeeMsg_ActionAxes             := '��(&a)';
  TeeMsg_ActionGridsHint        := '�׸��� ���� / ����';
  TeeMsg_ActionGrids            := '�׸���(&g)';
  TeeMsg_ActionLegendHint       := '���� ���� / ����';
  TeeMsg_ActionLegend           := '����(&l)';
  TeeMsg_ActionSeriesEditHint   := '�迭 ����';
  TeeMsg_ActionSeriesMarksHint  := '�迭 ǥ�� ���� / ����';
  TeeMsg_ActionSeriesMarks      := 'ǥ��(&m)';
  TeeMsg_ActionSaveHint         := '��Ʈ ����';
  TeeMsg_ActionSave             := '����(&s)...';

  TeeMsg_CandleBar              := '����';
  TeeMsg_CandleNoOpen           := '������ ����';
  TeeMsg_CandleNoClose          := '������ ����';
  TeeMsg_NoHigh                 := '���� ����';
  TeeMsg_NoLow                  := '���� ����';
  TeeMsg_ColorRange             := '�� ����';
  TeeMsg_WireFrame              := '����';
  TeeMsg_DotFrame               := '���� ����';
  TeeMsg_Positions              := '��ġ';
  TeeMsg_NoGrid                 := '�׸��� ����';
  TeeMsg_NoPoint                := '����Ʈ ����';
  TeeMsg_NoLine                 := '�� ����';
  TeeMsg_Labels                 := '��';
  TeeMsg_NoCircle               := '�� ����';
  TeeMsg_Lines                  := '��';
  TeeMsg_Border                 := '�׵θ�';

  TeeMsg_SmithResistance      := '���׷�';
  TeeMsg_SmithReactance       := '�����Ͻ�';

  TeeMsg_Column               := '�÷�';

  { 5.01 }
  TeeMsg_Separator            := '������';
  TeeMsg_FunnelSegment        := '��ȹ ';
  TeeMsg_FunnelSeries         := '�򶧱�';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := '�Ҵ� �ʰ�';
  TeeMsg_FunnelWithin         := ' ���Ե�';
  TeeMsg_FunnelBelow          := ' �̰ų� �Ҵ� �̸�';
  TeeMsg_CalendarSeries       := '�޷���';
  TeeMsg_DeltaPointSeries     := '��Ÿ����Ʈ��';
  TeeMsg_ImagePointSeries     := '����������Ʈ��';
  TeeMsg_ImageBarSeries       := '�̹���������';
  TeeMsg_SeriesTextFieldZero  := '�迭 �ؽ�Ʈ: �ʵ� �ε����� 0 ���� Ŀ�� �մϴ�.';

  { 5.02 }
  TeeMsg_Origin               := '����';
  TeeMsg_Transparency         := '����';
  TeeMsg_Box		      := '����';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := '������ ��ȣ';
  TeeMsg_TextFile             := '�ؽ�Ʈ ����';

  { 5.03 }
  TeeMsg_DragPoint            := '�巡�� ����Ʈ';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

end;

Procedure TeeCreateKorean;
begin
  if not Assigned(TeeKoreanLanguage) then
  begin
    TeeKoreanLanguage:=TStringList.Create;
    TeeKoreanLanguage.Text:=

'LABELS=��'+#13+
'DATASET=�����ͼ�'+#13+
'ALL RIGHTS RESERVED.=ALL RIGHTS RESERVED.'+#13+
'APPLY=����'+#13+
'CLOSE=�ݱ�'+#13+
'OK=Ȯ��'+#13+
'ABOUT TEECHART PRO V7.0=TeeChart Pro v7.0 �� ���Ͽ�'+#13+
'OPTIONS=�ɼ�'+#13+
'FORMAT=����'+#13+
'TEXT=�ؽ�Ʈ'+#13+
'GRADIENT=��ȭ'+#13+
'SHADOW=�׸���'+#13+
'POSITION=��ġ'+#13+
'LEFT=����'+#13+
'TOP=����'+#13+
'CUSTOM=����� ����'+#13+
'PEN=��'+#13+
'PATTERN=����'+#13+
'SIZE=ũ��'+#13+
'BEVEL=����'+#13+
'INVERTED=������'+#13+
'INVERTED SCROLL=�� ��ũ��'+#13+
'BORDER=�׵θ�'+#13+
'ORIGIN=��õ'+#13+
'USE ORIGIN=���� ��ġ'+#13+
'AREA LINES=���� ��'+#13+
'AREA=����'+#13+
'COLOR=��'+#13+
'SERIES=�迭'+#13+
'SUM=�հ�'+#13+
'DAY=��'+#13+
'QUARTER=4���� 1'+#13+
'(MAX)=(�ִ�)'+#13+
'(MIN)=(�ּ�)'+#13+
'VISIBLE=����'+#13+
'CURSOR=Ŀ��'+#13+
'GLOBAL=����'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=���� ��'+#13+
'LABEL AND PERCENT=�󺧰� �����'+#13+
'LABEL AND VALUE=�󺧰� ��'+#13+
'LABEL AND PERCENT TOTAL=�󺧰� ����� �Ѱ�'+#13+
'PERCENT TOTAL=����� �Ѱ�'+#13+
'MSEC.=msec.'+#13+
'SUBTRACT=����'+#13+
'MULTIPLY=���ϱ�'+#13+
'DIVIDE=������'+#13+
'STAIRS=���'+#13+
'MOMENTUM=������'+#13+
'AVERAGE=���'+#13+
'XML=XML'+#13+
'HTML TABLE=HTML ���̺�'+#13+
'EXCEL=Excel'+#13+
'NONE=����'+#13+
'(NONE)=����'#13+
'WIDTH=�ʺ�'+#13+
'HEIGHT=����'+#13+
'COLOR EACH=���� �ٸ� ��'+#13+
'STACK=����'+#13+
'STACKED=����'+#13+
'STACKED 100%=���� 100%'+#13+
'AXIS=��'+#13+
'LENGTH=����'+#13+
'CANCEL=���'+#13+
'SCROLL=��ũ��'+#13+
'INCREMENT=����'+#13+
'VALUE=��'+#13+
'STYLE=��Ÿ��'+#13+
'JOIN=����'+#13+
'AXIS INCREMENT=�� ����'+#13+
'AXIS MAXIMUM AND MINIMUM=�� �ִ�� �ּ�'+#13+
'% BAR WIDTH=���� �ʺ� %'+#13+
'% BAR OFFSET=���� ������ %'+#13+
'BAR SIDE MARGINS=���� ���� ���� �����'+#13+
'AUTO MARK POSITION=�ڵ� ǥ�� ��ġ'+#13+
'DARK BAR 3D SIDES=3D ���� ���� ��Ӱ� �����'+#13+
'MONOCHROME=���'+#13+
'COLORS=��'+#13+
'DEFAULT=�⺻��'+#13+
'MEDIAN=�߾�'+#13+
'IMAGE=�̹���'+#13+
'DAYS=��¥'+#13+
'WEEKDAYS=����'+#13+
'TODAY=����'+#13+
'SUNDAY=�Ͽ���'+#13+
'MONTHS=��'+#13+
'LINES=��'+#13+
'UPPERCASE=�빮��'+#13+
'STICK=������'+#13+
'CANDLE WIDTH=���� �ʺ�'+#13+
'BAR=����'+#13+
'OPEN CLOSE=�ݱ� ����'+#13+
'DRAW 3D=3D �׸���'+#13+
'DARK 3D=��ο� 3D'+#13+
'SHOW OPEN=���� ����'+#13+
'SHOW CLOSE=�ݱ� ����'+#13+
'UP CLOSE=���� ����'+#13+
'DOWN CLOSE=�Ʒ��� ����'+#13+
'CIRCLED=����'+#13+
'CIRCLE=����'+#13+
'3 DIMENSIONS=3D'+#13+
'ROTATION=ȸ��'+#13+
'RADIUS=������'+#13+
'HOURS=�ð�'+#13+
'HOUR=�ð�'+#13+
'MINUTES=��'+#13+
'SECONDS=��'+#13+
'FONT=�۲�'+#13+
'INSIDE=����'+#13+
'ROTATED=ȸ��'+#13+
'ROMAN=�θ�'+#13+
'TRANSPARENCY=����'+#13+
'DRAW BEHIND=���� �׸���'+#13+
'RANGE=����'+#13+
'PALETTE=�ȷ�Ʈ'+#13+
'STEPS=�ܰ�'+#13+
'GRID=�׸���'+#13+
'GRID SIZE=�׸��� ũ��'+#13+
'ALLOW DRAG=�巡�� Ȱ��ȭ'+#13+
'AUTOMATIC=�ڵ�'+#13+
'LEVEL=�ܰ�'+#13+
'LEVELS POSITION=�ܰ� ��ġ'+#13+
'SNAP=����'+#13+
'FOLLOW MOUSE=���콺 ����ٴϱ�'+#13+
'TRANSPARENT=�����ϰ� �ϱ�'+#13+
'ROUND FRAME=�ձ��� �ϱ�'+#13+
'FRAME=����'+#13+
'START=����'+#13+
'END=��'+#13+
'MIDDLE=�߰�'+#13+
'NO MIDDLE=�߰��� ����'+#13+
'DIRECTION=����'+#13+
'DATASOURCE=������ ��õ'+#13+
'AVAILABLE=������'+#13+
'SELECTED=���õ� ��'+#13+
'CALC=���'+#13+
'GROUP BY=GROUP BY'+#13+
'OF=OF'+#13+
'HOLE %=���� %'+#13+
'RESET POSITIONS=��ġ �ʱ�ȭ'+#13+
'MOUSE BUTTON=���콺 ��ư'+#13+
'ENABLE DRAWING=�׸��� ����'+#13+
'ENABLE SELECT=���� ����'+#13+
'ORTHOGONAL=���� ����'+#13+
'ANGLE=����'+#13+
'ZOOM TEXT=�� �ؽ�Ʈ'+#13+
'PERSPECTIVE=���ٰ�'+#13+
'ZOOM=��'+#13+
'ELEVATION=����'+#13+
'BEHIND=�ڿ� ��ġ'+#13+
'AXES=��'+#13+
'SCALES=�ܰ�'+#13+
'TITLE=����'+#13+
'TICKS=ǥ��'+#13+
'MINOR=���� ǥ��'+#13+
'CENTERED=�߽�����'+#13+
'CENTER=���'+#13+
'PATTERN COLOR EDITOR=���� �� ����â'+#13+
'START VALUE=���� ��'+#13+
'END VALUE=������ ��'+#13+
'COLOR MODE=���� ���'+#13+
'LINE MODE=�� ���'+#13+
'HEIGHT 3D=3D ����'+#13+
'OUTLINE=�ܰ���'+#13+
'PRINT PREVIEW=�̸�����'+#13+
'ANIMATED=�ܰ輳��'+#13+
'ALLOW=Ȱ��ȭ'+#13+
'DASH=�ܼӼ�'+#13+
'DOT=��'+#13+
'DASH DOT DOT=�ܼӼ� �� ��'+#13+
'PALE=���� ��'+#13+
'STRONG=������ ��'+#13+
'WIDTH UNITS=�ʺ� ����'+#13+
'FOOT=����'+#13+
'SUBFOOT=�ΰ���'+#13+
'SUBTITLE=������'+#13+
'LEGEND=����'+#13+
'COLON=��ħǥ'+#13+
'AXIS ORIGIN=���� ��'+#13+
'UNITS=����'+#13+
'PYRAMID=�Ƕ�̵���'+#13+
'DIAMOND=���̾Ƹ����'+#13+
'CUBE=������ü��'+#13+
'TRIANGLE=�ﰢ��'+#13+
'STAR=����'+#13+
'SQUARE=���簢��'+#13+
'DOWN TRIANGLE=���ﰢ��'+#13+
'SMALL DOT=���� ��'+#13+
'LOAD=�ҷ�����'+#13+
'FILE=����'+#13+
'RECTANGLE=�簢��'+#13+
'HEADER=���'+#13+
'CLEAR=����'+#13+
'ONE HOUR=�� �ð�'+#13+
'ONE YEAR=�� ��'+#13+
'ELLIPSE=Ÿ����'+#13+
'CONE=��'+#13+
'ARROW=ȭ��ǥ'+#13+
'CYLLINDER=�����'+#13+
'TIME=�ð�'+#13+
'BRUSH=�귯��'+#13+
'LINE=��'+#13+
'VERTICAL LINE=���� ��'+#13+
'AXIS ARROWS=�� ȭ��ǥ'+#13+
'MARK TIPS=��Ʈ ǥ��'+#13+
'DASH DOT=�ܼӼ� ��'+#13+
'COLOR BAND=���� ��'+#13+
'COLOR LINE=����'+#13+
'INVERT. TRIANGLE=���ﰢ��'+#13+
'INVERT. PYRAMID=���Ƕ�̵�'+#13+
'INVERTED PYRAMID=���Ƕ�̵�'+#13+
'SERIES DATASOURCE TEXT EDITOR=�迭 ������ ��õ ����â'+#13+
'SOLID=��'+#13+
'WIREFRAME=����'+#13+
'DOTFRAME=���� ����'+#13+
'SIDE BRUSH=���� �귯��'+#13+
'SIDE=����'+#13+
'SIDE ALL=�迭 ����'+#13+
'ROTATE=ȸ��'+#13+
'SMOOTH PALETTE=�ε巯�� �ȷ�Ʈ'+#13+
'CHART TOOLS GALLERY=��Ʈ ���� ����'+#13+
'ADD=���ϱ�'+#13+
'BORDER EDITOR=�׵θ� ����â'+#13+
'DRAWING MODE=�׸��� ���'+#13+
'CLOSE CIRCLE=�󱸰�'+#13+
'PICTURE=�׸�'+#13+
'NATIVE=����'+#13+
'DATA=������'+#13+
'KEEP ASPECT RATIO=���� ���� ����'+#13+
'COPY=����'+#13+
'SAVE=����'+#13+
'SEND=����'+#13+
'INCLUDE SERIES DATA=�迭 ������ ����'+#13+
'FILE SIZE=���� ũ��'+#13+
'INCLUDE=����'+#13+
'POINT INDEX=����Ʈ �ε���'+#13+
'POINT LABELS=����Ʈ ��'+#13+
'DELIMITER=������'+#13+
'DEPTH=����'+#13+
'COMPRESSION LEVEL=���� ����'+#13+
'COMPRESSION=����'+#13+
'PATTERNS=����'+#13+
'LABEL=��'+#13+
'GROUP SLICES=�׷� ����'+#13+
'EXPLODE BIGGEST=���� ū �� �и�'+#13+
'TOTAL ANGLE=��ü ����'+#13+
'HORIZ. SIZE=���� ũ��'+#13+
'VERT. SIZE=���� ũ��'+#13+
'SHAPES=����'+#13+
'INFLATE MARGINS=���� ��â'+#13+
'QUALITY=ǰ��'+#13+
'SPEED=�ӵ�'+#13+
'% QUALITY=% ����'+#13+
'GRAY SCALE=ȸ����'+#13+
'PERFORMANCE=����'+#13+
'BROWSE=ã�ƺ���'+#13+
'TILED=�ٵ��ǽ�'+#13+
'HIGH=����'+#13+
'LOW=����'+#13+
'DATABASE CHART=�����ͺ��̽� ��Ʈ'+#13+
'NON DATABASE CHART=�Ϲ� ��Ʈ'+#13+
'HELP=����'+#13+
'NEXT >=���� >'+#13+
'< BACK=< ����'+#13+
'TEECHART WIZARD=��Ʈ ������'+#13+
'PERCENT=�����'+#13+
'PIXELS=�ȼ�'+#13+
'ERROR WIDTH=���� �ʺ�'+#13+
'ENHANCED=���'+#13+
'VISIBLE WALLS=���� ����'+#13+
'ACTIVE=Ȱ��ȭ'+#13+
'DELETE=����'+#13+
'ALIGNMENT=����'+#13+
'ADJUST FRAME=���� ����'+#13+
'HORIZONTAL=����'+#13+
'VERTICAL=����'+#13+
'VERTICAL POSITION=���� ��ġ'+#13+
'NUMBER=��'+#13+
'LEVELS=����'+#13+
'OVERLAP=��ġ��'+#13+
'STACK 100%=���� 100%'+#13+
'MOVE=�̵�'+#13+
'CLICK=Ŭ��'+#13+
'DELAY=����'+#13+
'DRAW LINE=�� �׸���'+#13+
'FUNCTIONS=�Լ�'+#13+
'SOURCE SERIES=��õ �迭'+#13+
'ABOVE=����'+#13+
'BELOW=�Ʒ�'+#13+
'Dif. Limit=�Ѱ� ����'+#13+
'WITHIN=�ȿ�'+#13+
'EXTENDED=Ȯ��'+#13+
'STANDARD=ǥ��'+#13+
'STATS=����'+#13+
'FINANCIAL=����'+#13+
'OTHER=��Ÿ'+#13+
'TEECHART GALLERY=��Ʈ ����'+#13+
'CONNECTING LINES=�� ����'+#13+
'REDUCTION=���'+#13+
'LIGHT=����'+#13+
'INTENSITY=����'+#13+
'FONT OUTLINES=�۲� �ܰ���'+#13+
'SMOOTH SHADING=�ε巯�� ����'+#13+
'AMBIENT LIGHT=������'+#13+
'MOUSE ACTION=���콺 ����'+#13+
'CLOCKWISE=�ð� ����'+#13+
'ANGLE INCREMENT=���� ����'+#13+
'RADIUS INCREMENT=������ ����'+#13+
'PRINTER=������'+#13+
'SETUP=����'+#13+
'ORIENTATION=����'+#13+
'PORTRAIT=����'+#13+
'LANDSCAPE=����'+#13+
'MARGINS (%)=���� (%)'+#13+
'MARGINS=����'+#13+
'DETAIL=���μ���'+#13+
'MORE=������'+#13+
'PROPORTIONAL=��� ���߱�'+#13+
'VIEW MARGINS=���� ����'+#13+
'RESET MARGINS=���� �ʱ�ȭ'+#13+
'PRINT=���'+#13+
'TEEPREVIEW EDITOR=�̸����� ����â'+#13+
'ALLOW MOVE=�����̱� Ȱ��ȭ'+#13+
'ALLOW RESIZE=ũ������ Ȱ��ȭ'+#13+
'SHOW IMAGE=����̹��� ����'+#13+
'DRAG IMAGE=����̹��� ����'+#13+
'AS BITMAP=��Ʈ������'+#13+
'SIZE %=ũ�� %'+#13+
'FIELDS=�ʵ�'+#13+
'SOURCE=��õ'+#13+
'SEPARATOR=������'+#13+
'NUMBER OF HEADER LINES=��� ���� ��'+#13+
'COMMA=��ǥ'+#13+
'EDITING=����'+#13+
'TAB=��'+#13+
'SPACE=����'+#13+
'ROUND RECTANGLE=�ձ� �簢��'+#13+
'BOTTOM=�Ʒ���'+#13+
'RIGHT=������'+#13+
'C PEN=C ��'+#13+
'R PEN=R ��'+#13+
'C LABELS=C ��'+#13+
'R LABELS=R ��'+#13+
'MULTIPLE BAR=���� ����'+#13+
'MULTIPLE AREAS=���� ����'+#13+
'STACK GROUP=���� �׷�'+#13+
'BOTH=����'+#13+
'BACK DIAGONAL=���밢��'+#13+
'B.DIAGONAL=���밢��'+#13+
'DIAG.CROSS=���� �밢��'+#13+
'WHISKER=����'+#13+
'CROSS=����'+#13+
'DIAGONAL CROSS=���� �밢��'+#13+
'LEFT RIGHT=���� ������'+#13+
'RIGHT LEFT=������ ����'+#13+
'FROM CENTER=�߾����κ���'+#13+
'FROM TOP LEFT=������ ��������'+#13+
'FROM BOTTOM LEFT=�Ʒ����� ��������'+#13+
'SHOW WEEKDAYS=���� ����'+#13+
'SHOW MONTHS=�� ����'+#13+
'SHOW PREVIOUS BUTTON=���� ��ư ����'#13+
'SHOW NEXT BUTTON=���� ��ư ����'#13+
'TRAILING DAYS=���� �� ����'+#13+
'SHOW TODAY=���� ����'+#13+
'TRAILING=���� ��'+#13+
'LOWERED=�Ʒ���'+#13+
'RAISED=����'+#13+
'HORIZ. OFFSET=���� ������'+#13+
'VERT. OFFSET=���� ������'+#13+
'INNER=����'+#13+
'LEN=����'+#13+
'AT LABELS ONLY=�󺧸� ����'+#13+
'MAXIMUM=�ִ밪'+#13+
'MINIMUM=�ּҰ�'+#13+
'CHANGE=����'+#13+
'LOGARITHMIC=�α�ȭ'+#13+
'LOG BASE=�α� �ؼ�'+#13+
'DESIRED INCREMENT=���ϴ� ����ġ'+#13+
'(INCREMENT)=(����)'+#13+
'MULTI-LINE=���� ����'+#13+
'MULTI LINE=���� ����'+#13+
'RESIZE CHART=��ġ�� ����'+#13+
'X AND PERCENT=X�� �����'+#13+
'X AND VALUE=X�� ��'+#13+
'RIGHT PERCENT=������ �����'+#13+
'LEFT PERCENT=���� �����'+#13+
'LEFT VALUE=���� ��'+#13+
'RIGHT VALUE=������ ��'+#13+
'PLAIN=������'+#13+
'LAST VALUES=���� ��'+#13+
'SERIES VALUES=�迭 ��'+#13+
'SERIES NAMES=�迭 �̸�'+#13+
'NEW=���� �����'+#13+
'EDIT=����'+#13+
'PANEL COLOR=�г� ��'+#13+
'TOP BOTTOM=�� �Ʒ�'+#13+
'BOTTOM TOP=�Ʒ� ��'+#13+
'DEFAULT ALIGNMENT=�⺻ ����'+#13+
'EXPONENTIAL=����'+#13+
'LABELS FORMAT=�� ����'+#13+
'MIN. SEPARATION %=�ּ� �и��� %'+#13+
'YEAR=��'+#13+
'MONTH=��'+#13+
'WEEK=��'+#13+
'WEEKDAY=����'+#13+
'MARK=ǥ��'+#13+
'ROUND FIRST=������ ����'+#13+
'LABEL ON AXIS=���� ��'+#13+
'COUNT=����'+#13+
'POSITION %=��ġ %'+#13+
'START %=���� %'+#13+
'END %=�� %'+#13+
'OTHER SIDE=�ݴ���'+#13+
'INTER-CHAR SPACING=���� ���� ����'+#13+
'VERT. SPACING=���� ���� ����'+#13+
'POSITION OFFSET %=��ġ ������ %'+#13+
'GENERAL=�Ϲ�'+#13+
'MANUAL=����'+#13+
'PERSISTENT=�Һ�'+#13+
'PANEL=�г�'+#13+
'ALIAS=��Ī'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=OpenGL ����â'+#13+
'FONT 3D DEPTH=3D �۲�'+#13+
'NORMAL=ǥ��'+#13+
'TEEFONT EDITOR=�۲� ����â'+#13+
'CLIP POINTS=���� ����Ʈ'+#13+
'CLIPPED=����'+#13+
'3D %=3D %'+#13+
'QUANTIZE=����ȭ'+#13+
'QUANTIZE 256=����ȭ 256'+#13+
'DITHER=���'+#13+
'VERTICAL SMALL=���� ����'+#13+
'HORIZ. SMALL=���� ����'+#13+
'DIAG. SMALL=���� �밢��'+#13+
'BACK DIAG. SMALL=���� ���밢��'+#13+
'DIAG. CROSS SMALL=���� �밢�� ����'+#13+
'MINIMUM PIXELS=�ּ� �ȼ�'+#13+
'ALLOW SCROLL=��ũ�� Ȱ��ȭ'+#13+
'SWAP=��ȯ'+#13+
'GRADIENT EDITOR=��ȭ ����â'+#13+
'TEXT STYLE=�ؽ�Ʈ ��Ÿ��'+#13+
'DIVIDING LINES=������ �����ϱ�'+#13+
'SYMBOLS=��ȣ'+#13+
'CHECK BOXES=üũ ����'+#13+
'FONT SERIES COLOR=�迭 ���� ����'+#13+
'LEGEND STYLE=���� ��Ÿ��'+#13+
'POINTS PER PAGE=�������� ������ ��'+#13+
'SCALE LAST PAGE=������ ������ ũ�� ����'+#13+
'CURRENT PAGE LEGEND=���� ������ ����'+#13+
'BACKGROUND=���'+#13+
'BACK IMAGE=��� �̹���'+#13+
'STRETCH=���̱�'+#13+
'TILE=�ٵ��ǽ�'+#13+
'BORDERS=���'+#13+
'CALCULATE EVERY=��ü ���'+#13+
'NUMBER OF POINTS=����Ʈ ����'+#13+
'RANGE OF VALUES=�� ����'+#13+
'FIRST=�� ��'+#13+
'LAST=�� ��'+#13+
'ALL POINTS=��� ����Ʈ'+#13+
'DATA SOURCE=������ ��õ'+#13+
'WALLS=����'+#13+
'PAGING=������'+#13+
'CLONE=����'+#13+
'TITLES=����'+#13+
'TOOLS=����'+#13+
'EXPORT=��������'+#13

{$IFDEF LCL}
;  TeeKoreanLanguage.Text:=TeeKoreanLanguage.Text
{$ENDIF}

+
'CHART=��Ʈ'+#13+
'BACK=�ڷ�'+#13+
'LEFT AND RIGHT=���� ������'+#13+
'SELECT A CHART STYLE=��Ʈ ��Ÿ���� �����ϼ���'+#13+
'SELECT A DATABASE TABLE=�����ͺ��̽� ���̺��� �����ϼ���'+#13+
'TABLE=���̺�'+#13+
'SELECT THE DESIRED FIELDS TO CHART=��Ʈ�� �����ְ� ���� �ʵ带 �����ϼ���'+#13+
'SELECT A TEXT LABELS FIELD=�ؽ�Ʈ �� �ʵ带 �����ϼ���'+#13+
'CHOOSE THE DESIRED CHART TYPE=���ϴ� ��Ʈ ���¸� �����ϼ���'+#13+
'CHART PREVIEW=��Ʈ �̸�����'+#13+
'SHOW LEGEND=���� ����'+#13+
'SHOW MARKS=ǥ�� ����'+#13+
'FINISH=����'+#13+
'RANDOM=���Ǽ�'+#13+
'DRAW EVERY=�׸��� ����'+#13+
'ARROWS=������'+#13+
'ASCENDING=��������'+#13+
'DESCENDING=��������'+#13+
'VERTICAL AXIS=���� ��'+#13+
'DATETIME=�Ͻ�'+#13+
'TOP AND BOTTOM=�� �Ʒ�'+#13+
'HORIZONTAL AXIS=���� ��'+#13+
'PERCENTS=�����'+#13+
'VALUES=��'+#13+
'FORMATS=����'+#13+
'SHOW IN LEGEND=���� �ȿ� ���̱�'+#13+
'SORT=����'+#13+
'MARKS=ǥ��'+#13+
'BEVEL INNER=���� ��'+#13+
'BEVEL OUTER=���� ��'+#13+
'PANEL EDITOR=�г� ����â'+#13+
'CONTINUOUS=���� ����'+#13+
'HORIZ. ALIGNMENT=���� ����'+#13+
'EXPORT CHART=��Ʈ ��������'+#13+
'BELOW %=���� %'+#13+
'BELOW VALUE=���� ��'+#13+
'NEAREST POINT=��ó ����Ʈ'+#13+
'DRAG MARKS=ǥ�� �巡��'+#13+
'TEECHART PRINT PREVIEW=��Ʈ ��� �̸�����'+#13+
'X VALUE=X ��'+#13+
'X AND Y VALUES=X�� Y ��'+#13+
'SHININESS=���'+#13+
'ALL SERIES VISIBLE=��� �迭 ����'+#13+
'MARGIN=����'+#13+
'DIAGONAL=�밢��'+#13+
'LEFT TOP=���� ��'+#13+
'LEFT BOTTOM=���� �Ʒ�'+#13+
'RIGHT TOP=���� ��'+#13+
'RIGHT BOTTOM=���� �Ʒ�'+#13+
'EXACT DATE TIME=���� �ð�'+#13+
'RECT. GRADIENT=�簢 ��ȭ'+#13+
'CROSS SMALL=���� ����'+#13+
'AVG=���ġ'+#13+
'FUNCTION=�Լ�'+#13+
'AUTO=�ڵ�'+#13+
'ONE MILLISECOND=õ���� 1��'+#13+
'ONE SECOND=1 ��'+#13+
'FIVE SECONDS=5 ��'+#13+
'TEN SECONDS=10 ��'+#13+
'FIFTEEN SECONDS=15 ��'+#13+
'THIRTY SECONDS=30 ��'+#13+
'ONE MINUTE=1 ��'+#13+
'FIVE MINUTES=5 ��'+#13+
'TEN MINUTES=10 ��'+#13+
'FIFTEEN MINUTES=15 ��'+#13+
'THIRTY MINUTES=30 ��'+#13+
'TWO HOURS=2 �ð�'+#13+
'TWO HOURS=2 �ð�'+#13+
'SIX HOURS=6 �ð�'+#13+
'TWELVE HOURS=12 �ð�'+#13+
'ONE DAY=�Ϸ�'+#13+
'TWO DAYS=��Ʋ'+#13+
'THREE DAYS=����'+#13+
'ONE WEEK=�� ��'+#13+
'HALF MONTH=����'+#13+
'ONE MONTH=1 ����'+#13+
'TWO MONTHS=2 ����'+#13+
'THREE MONTHS=3 ����'+#13+
'FOUR MONTHS=4 ����'+#13+
'SIX MONTHS=6 ����'+#13+
'IRREGULAR=�ұ�Ģ'+#13+
'CLICKABLE=Ŭ������'+#13+
'ROUND=�ձ۰�'+#13+
'FLAT=�����ϰ�'+#13+
'PIE=����'+#13+
'HORIZ. BAR=���� ������'+#13+
'BUBBLE=��ǰ��'+#13+
'SHAPE=������'+#13+
'POINT=����Ʈ��'+#13+
'FAST LINE=���� ����'+#13+
'CANDLE=�ֽĸ�����'+#13+
'VOLUME=���� ���θ�����'+#13+
'HORIZ LINE=���� ����'+#13+
'SURFACE=ǥ����'+#13+
'LEFT AXIS=���� ��'+#13+
'RIGHT AXIS=������ ��'+#13+
'TOP AXIS=���� ��'+#13+
'BOTTOM AXIS=���� ��'+#13+
'CHANGE SERIES TITLE=�迭 ���� �ٲٱ�'+#13+
'DELETE %S ?=%s ��(��) ����ڽ��ϱ�?'+#13+
'DESIRED %S INCREMENT=���ϴ� %s ����ġ'+#13+
'INCORRECT VALUE. REASON: %S=�߸��� ���Դϴ�. ����: %s'+#13+
'FillSampleValues NumValues must be > 0=���ð�ä����� ���� 0 �̻��Դϴ�.'#13+
'VISIT OUR WEB SITE !=Ȩ�������� �����ϱ� �ٶ��ϴ�!'#13+
'SHOW PAGE NUMBER=������ ��ȣ ����'#13+
'PAGE NUMBER=������ ��ȣ'#13+
'PAGE %D OF %D=������ %d / %d'#13+
'TEECHART LANGUAGES=��Ʈ ���'#13+
'CHOOSE A LANGUAGE=��� ����'+#13+
'SELECT ALL=��� ����'#13+
'MOVE UP=���� �̵�'#13+
'MOVE DOWN=�Ʒ��� �̵�'#13+
'DRAW ALL=��ü �׸���'#13+
'TEXT FILE=�ؽ�Ʈ ����'#13+
'IMAG. SYMBOL=�̹��� ��ȣ'#13+
'DRAG REPAINT=�ٽ� �׸���'#13+
'NO LIMIT DRAG=���� ���� ����'
;
  end;
end;

Procedure TeeSetKorean;
begin
  TeeCreateKorean;
  TeeLanguage:=TeeKoreanLanguage;
  TeeKoreanConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeKoreanLanguage);
end.


