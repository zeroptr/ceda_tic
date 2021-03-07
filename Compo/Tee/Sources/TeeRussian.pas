unit TeeRussian;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeRussianLanguage:TStringList=nil;

Procedure TeeSetRussian;
Procedure TeeCreateRussian;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeRussianConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 ����� �������';
  TeeMsg_LegendFirstValue   :='������ �������� ������� ������ ���� > 0';
  TeeMsg_LegendColorWidth   :='������� ����� ������� ������ ���� > 0%';
  TeeMsg_SeriesSetDataSource:='��� ������������� ������� ����� ��������� �������� ������';
  TeeMsg_SeriesInvDataSource:='������������ �������� ������: %s';
  TeeMsg_FillSample         :='FillSampleValues NumValues ������ ���� > 0';
  TeeMsg_AxisLogDateTime    :='��������� ��� �� ����� ���� �������������';
  TeeMsg_AxisLogNotPositive :='���. � ����. �������� ��������������� ��������� ���� >= 0';
  TeeMsg_AxisLabelSep       :='����������� �������� % ������ ���� ������ 0';
  TeeMsg_AxisIncrementNeg   :='��� ��� ������ ���� >= 0';
  TeeMsg_AxisMinMax         :='����������� �������� ��� ������ ���� <= �������������';
  TeeMsg_AxisMaxMin         :='������������ �������� ��� ������ ���� >= ������������';
  TeeMsg_AxisLogBase        :='������ ������������� ��� ������ ���� >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage ������ ���� >= 0';
  TeeMsg_3dPercent          :='�������� 3D ������� ������ ���� ����� %d � %d';
  TeeMsg_CircularSeries     :='����������� �� �������� ����� �����������';
  TeeMsg_WarningHiColor     :='16k ���� ��� ������� ��������� ��� ������� ����';

  TeeMsg_DefaultPercentOf   :='%s �� %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'�� %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='��������� ����';
  TeeMsg_AxisLabels         :='������� ����';
  TeeMsg_RefreshInterval    :='�������� ���������� ������ ���� ����� 0 � 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart �� ����� ���� ����� �����!';
  TeeMsg_GalleryLine        :='�����';
  TeeMsg_GalleryPoint       :='�����';
  TeeMsg_GalleryArea        :='�������';
  TeeMsg_GalleryBar         :='������';
  TeeMsg_GalleryHorizBar    :='�����. ������';
  TeeMsg_Stack              :='����';
  TeeMsg_GalleryPie         :='�����';
  TeeMsg_GalleryCircled     :='��������';
  TeeMsg_GalleryFastLine    :='������� �����';
  TeeMsg_GalleryHorizLine   :='�����. �����';

  TeeMsg_PieSample1         :='������';
  TeeMsg_PieSample2         :='��������';
  TeeMsg_PieSample3         :='�������';
  TeeMsg_PieSample4         :='��������';
  TeeMsg_PieSample5         :='�����';
  TeeMsg_PieSample6         :='����������';
  TeeMsg_PieSample7         :='����������';
  TeeMsg_PieSample8         :='������';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='�������������� %s';

  TeeMsg_GalleryStandard    :='�����������';
  TeeMsg_GalleryExtended    :='�����������';
  TeeMsg_GalleryFunctions   :='�������';

  TeeMsg_EditChart          :='�&�����. ������...';
  TeeMsg_PrintPreview       :='&���������. ��������...';
  TeeMsg_ExportChart        :='�&������������� ������...';
  TeeMsg_CustomAxes         :='�����. ���...';

  TeeMsg_InvalidEditorClass :='%s: ������������ �������� ������: %s';
  TeeMsg_MissingEditorClass :='%s: ��� ������� ���������';

  TeeMsg_GalleryArrow       :='������';

  TeeMsg_ExpFinish          :='&�����';
  TeeMsg_ExpNext            :='&��������� >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='������';
  TeeMsg_GanttSample2       :='�������� ���������';
  TeeMsg_GanttSample3       :='����������';
  TeeMsg_GanttSample4       :='�������';
  TeeMsg_GanttSample5       :='���������';
  TeeMsg_GanttSample6       :='������������';
  TeeMsg_GanttSample7       :='��������.';
  TeeMsg_GanttSample8       :='�������';
  TeeMsg_GanttSample9       :='����� ������';
  TeeMsg_GanttSample10      :='�������';

  TeeMsg_ChangeSeriesTitle  :='�������� �������� �����';
  TeeMsg_NewSeriesTitle     :='����� �������� �����:';
  TeeMsg_DateTime           :='���������';
  TeeMsg_TopAxis            :='������� ���';
  TeeMsg_BottomAxis         :='������ ���';
  TeeMsg_LeftAxis           :='����� ���';
  TeeMsg_RightAxis          :='������ ���';

  TeeMsg_SureToDelete       :='������� %s ?';
  TeeMsg_DateTimeFormat     :='���&��� �����������:';
  TeeMsg_Default            :='�� ���������';
  TeeMsg_ValuesFormat       :='�&����� ��������:';
  TeeMsg_Maximum            :='��������';
  TeeMsg_Minimum            :='�������';
  TeeMsg_DesiredIncrement   :='�������� %s ����������';

  TeeMsg_IncorrectMaxMinValue:='������������ ��������. ��-��: %s';
  TeeMsg_EnterDateTime      :='������� [����� ����] [��:��:��]';

  TeeMsg_SureToApply        :='��������� ��������� ?';
  TeeMsg_SelectedSeries     :='(��������� �����)';
  TeeMsg_RefreshData        :='&�������� ������';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='484';
  TeeMsg_FunctionAdd        :='�������';
  TeeMsg_FunctionSubtract   :='�������';
  TeeMsg_FunctionMultiply   :='��������';
  TeeMsg_FunctionDivide     :='���������';
  TeeMsg_FunctionHigh       :='�������';
  TeeMsg_FunctionLow        :='������';
  TeeMsg_FunctionAverage    :='�������';

  TeeMsg_GalleryShape       :='������';
  TeeMsg_GalleryBubble      :='Bubble';
  TeeMsg_FunctionNone       :='����������';

  TeeMsg_None               :='(������)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='������ ����� ������ ���� ������ ����';
  TeeMsg_About              :='&� TeeChart...';

  tcAdditional              :='�������������';
  tcDControls               :='���������� �������';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='����� ������';
  TeeMsg_AskDataSet         :='&����� ������:';

  TeeMsg_SingleRecord       :='���������. ������';
  TeeMsg_AskDataSource      :='&�������� ������:';

  TeeMsg_Summary            :='�����';

  TeeMsg_FunctionPeriod     :='������ ������� ������ ���� >= 0';

  TeeMsg_WizardTab          :='�������';
  TeeMsg_TeeChartWizard     :='TeeChart ������';

  TeeMsg_ClearImage         :='����&����';
  TeeMsg_BrowseImage        :='�&����...';

  TeeMsg_WizardSureToClose  :='�� �������, ��� ������ ������� ������� TeeChart ?';
  TeeMsg_FieldNotFound      :='���� %s �� ����������';

  TeeMsg_DepthAxis          :='��� �������';
  TeeMsg_PieOther           :='������';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='�����';
  TeeMsg_ValuesBar          :='������';
  TeeMsg_ValuesAngle        :='����';
  TeeMsg_ValuesGanttStart   :='����';
  TeeMsg_ValuesGanttEnd     :='�����';
  TeeMsg_ValuesGanttNextTask:='�������. ������';
  TeeMsg_ValuesBubbleRadius :='������';
  TeeMsg_ValuesArrowEndX    :='���������X';
  TeeMsg_ValuesArrowEndY    :='���������Y';
  TeeMsg_Legend             :='�������';
  TeeMsg_Title              :='��������';
  TeeMsg_Foot               :='������ �������';
  TeeMsg_Period		    :='������';
  TeeMsg_PeriodRange        :='�������� �������';
  TeeMsg_CalcPeriod         :='��������� %s ������:';
  TeeMsg_SmallDotsPen       :='��������� �����';

  TeeMsg_InvalidTeeFile     :='������������ ������ � *.'+TeeMsg_TeeExtension+' �����';
  TeeMsg_WrongTeeFileFormat :='������������ ������ *.'+TeeMsg_TeeExtension+' �����';
  TeeMsg_EmptyTeeFile       :='������ *.'+TeeMsg_TeeExtension+' ����';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := '��� �������';
  TeeMsg_ChartAxesCategoryDesc   := '�������� � ������� �������';
  TeeMsg_ChartWallsCategoryName  := '���� �������';
  TeeMsg_ChartWallsCategoryDesc  := '�������� � ������� ����� �������';
  TeeMsg_ChartTitlesCategoryName := '������� �������';
  TeeMsg_ChartTitlesCategoryDesc := '�������� � ������� �������� �������';
  TeeMsg_Chart3DCategoryName     := '3D ������';
  TeeMsg_Chart3DCategoryDesc     := '�������� � ������� 3D �������';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='���� ';
  TeeMsg_Series                 :='�����';
  TeeMsg_SeriesList             :='�����...';

  TeeMsg_PageOfPages            :='�������� %d �� %d';
  TeeMsg_FileSize               :='%d ����';

  TeeMsg_First  :='������';
  TeeMsg_Prior  :='����������';
  TeeMsg_Next   :='���������';
  TeeMsg_Last   :='���������';
  TeeMsg_Insert :='��������';
  TeeMsg_Delete :='�������';
  TeeMsg_Edit   :='�������������';
  TeeMsg_Post   :='���������';
  TeeMsg_Cancel :='������';

  TeeMsg_All    :='(���)';
  TeeMsg_Index  :='������';
  TeeMsg_Text   :='�����';

  TeeMsg_AsBMP        :='��� &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='��� &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := '�������� ������ �� ����������� � ������ ��������';

  TeeMsg_Normal    :='���������';
  TeeMsg_NoBorder  :='��� �������';
  TeeMsg_Dotted    :='�������';
  TeeMsg_Colors    :='�����';
  TeeMsg_Filled    :='�����������';
  TeeMsg_Marks     :='�������';
  TeeMsg_Stairs    :='��������';
  TeeMsg_Points    :='�����';
  TeeMsg_Height    :='������';
  TeeMsg_Hollow    :='Hollow';
  TeeMsg_Point2D   :='����� 2D';
  TeeMsg_Triangle  :='�����������';
  TeeMsg_Star      :='������';
  TeeMsg_Circle    :='����';
  TeeMsg_DownTri   :='���� ���.';
  TeeMsg_Cross     :='�����';
  TeeMsg_Diamond   :='�����';
  TeeMsg_NoLines   :='��� �����';
  TeeMsg_Stack100  :='���� 100%';
  TeeMsg_Pyramid   :='��������';
  TeeMsg_Ellipse   :='������';
  TeeMsg_InvPyramid:='����. ��������';
  TeeMsg_Sides     :='�������';
  TeeMsg_SideAll   :='��� �������';
  TeeMsg_Patterns  :='��������';
  TeeMsg_Exploded  :='Exploded';
  TeeMsg_Shadow    :='����';
  TeeMsg_SemiPie   :='����-�����';
  TeeMsg_Rectangle :='Rectangle';
  TeeMsg_VertLine  :='����. �����';
  TeeMsg_HorizLine :='�����. �����';
  TeeMsg_Line      :='�����';
  TeeMsg_Cube      :='���';
  TeeMsg_DiagCross :='����. �����';

  TeeMsg_CanNotFindTempPath    :='�� ���� ����� ��������� �����';
  TeeMsg_CanNotCreateTempChart :='�� ���� ������� ��������� ����';
  TeeMsg_CanNotEmailChart      :='�� ���� ��������� TeeChart. ������ Mapi : %d';

  TeeMsg_SeriesDelete :='�������� �����: ValueIndex %d �� ��������� (0 �� %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='��� &JPEG';
  TeeMsg_JPEGFilter    :='JPEG ����� (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='��� &GIF';
  TeeMsg_GIFFilter     :='GIF ����� (*.gif)|*.gif';
  TeeMsg_AsPNG         :='��� &PNG';
  TeeMsg_PNGFilter     :='PNG ����� (*.png)|*.png';
  TeeMsg_AsPCX         :='��� PC&X';
  TeeMsg_PCXFilter     :='PCX ����� (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='&����...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='�����';
  TeeMsg_GalleryCandle      :='�����';
  TeeMsg_GalleryVolume      :='�����';
  TeeMsg_GallerySurface     :='��������';
  TeeMsg_GalleryContour     :='������';
  TeeMsg_GalleryBezier      :='�����';
  TeeMsg_GalleryPoint3D     :='3D �����';
  TeeMsg_GalleryRadar       :='�����';
  TeeMsg_GalleryDonut       :='����';
  TeeMsg_GalleryCursor      :='������';
  TeeMsg_GalleryBar3D       :='3D ������';
  TeeMsg_GalleryBigCandle   :='������� �����';
  TeeMsg_GalleryLinePoint   :='����� �����';
  TeeMsg_GalleryHistogram   :='�����������';
  TeeMsg_GalleryWaterFall   :='�������';
  TeeMsg_GalleryWindRose    :='���� ������';
  TeeMsg_GalleryClock       :='����';
  TeeMsg_GalleryColorGrid   :='������� �����';
  TeeMsg_GalleryBoxPlot     :='�������';
  TeeMsg_GalleryHorizBoxPlot:='�����. �������';
  TeeMsg_GalleryBarJoin     :='�������. ������';
  TeeMsg_GallerySmith       :='����';
  TeeMsg_GalleryPyramid     :='��������';
  TeeMsg_GalleryMap         :='�����';

  TeeMsg_PolyDegreeRange    :='Polynomial degree ������ ���� ����� 1 � 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index ������ ���� ����� 1 � %d';
  TeeMsg_FittingError        :='�� ���� ������� fitting';
  TeeMsg_PeriodRange         :='������ ������ ���� >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage ��� ������ ���� ����� 0 and 1';
  TeeMsg_GalleryErrorBar     :='��������� ������';
  TeeMsg_GalleryError        :='������';
  TeeMsg_GalleryHighLow      :='High-Low';
  TeeMsg_FunctionMomentum    :='Momentum';
  TeeMsg_FunctionMomentumDiv :='Momentum Div';
  TeeMsg_FunctionExpAverage  :='Exp. Average';
  TeeMsg_FunctionMovingAverage:='Moving Avrg.';
  TeeMsg_FunctionExpMovAve   :='Exp.Mov.Avrg.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='Cumulative';
  TeeMsg_FunctionStdDeviation:='Std.Deviation';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='�������';
  TeeMsg_LoadChart           :='������� TeeChart...';
  TeeMsg_SaveChart           :='��������� TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro �����';

  TeeMsg_GallerySamples      :='������';
  TeeMsg_GalleryStats        :='����������';

  TeeMsg_CannotFindEditor    :='�� ���� ����� �������� ����� : %s';


  TeeMsg_CannotLoadChartFromURL:='��� ������: %d �������� ������� �� URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='��� ������: %d �������� ������ ����� �� URL: %s';

  TeeMsg_Test                :='����...';

  TeeMsg_ValuesDate          :='����';
  TeeMsg_ValuesOpen          :='��������';
  TeeMsg_ValuesHigh          :='������';
  TeeMsg_ValuesLow           :='������';
  TeeMsg_ValuesClose         :='��������';
  TeeMsg_ValuesOffset        :='��������';
  TeeMsg_ValuesStdError      :='StdError';

  TeeMsg_Grid3D              :='3D �����';

  TeeMsg_LowBezierPoints     :='���������� ����� ����� ������ ���� > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='���������';
  TeeCommanMsg_Edit     :='��������������';
  TeeCommanMsg_Print    :='������';
  TeeCommanMsg_Copy     :='����������';
  TeeCommanMsg_Save     :='���������';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='��������: %d� ������: %d�';
  TeeCommanMsg_Rotate   :='��������';

  TeeCommanMsg_Moving   :='�����.��������: %d ����.��������: %d';
  TeeCommanMsg_Move     :='�������';

  TeeCommanMsg_Zooming  :='�������: %d %%';
  TeeCommanMsg_Zoom     :='�����������';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='�������';

  TeeCommanMsg_Chart    :='������';
  TeeCommanMsg_Panel    :='������';

  TeeCommanMsg_RotateLabel:='����� %s ��� ��������';
  TeeCommanMsg_MoveLabel  :='����� %s ��� ��������';
  TeeCommanMsg_ZoomLabel  :='����� %s ��� �����������';
  TeeCommanMsg_DepthLabel :='����� %s ��� �����. ������� 3D';

  TeeCommanMsg_NormalLabel:='������� ����� ������ ��� �����������, ������ ������ ��� �������';
  TeeCommanMsg_NormalPieLabel:='Drag a Pie Slice to Explode it';

  TeeCommanMsg_PieExploding :='Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess        :='���������� ����� ������ ���� >= 4';
  TeeMsg_TriSurfaceAllColinear :='��� ������������ ����� ������';
  TeeMsg_TriSurfaceSimilar     :='������� ����� - �� ���� ���������';
  TeeMsg_GalleryTriSurface     :='Triangle Surf.';

  TeeMsg_AllSeries :='��� �����';
  TeeMsg_Edit      :='�������������';

  TeeMsg_GalleryFinancial    :='�������';

  TeeMsg_CursorTool    :='������';
  TeeMsg_DragMarksTool :='Drag �������';
  TeeMsg_AxisArrowTool :='������� ����';
  TeeMsg_DrawLineTool  :='���������� �����';
  TeeMsg_NearestTool   :='��������� �����';
  TeeMsg_ColorBandTool :='Color Band';
  TeeMsg_ColorLineTool :='������� �����';
  TeeMsg_RotateTool    :='��������';
  TeeMsg_ImageTool     :='�������';
  TeeMsg_MarksTipTool  :='��������� �������';

  TeeMsg_CantDeleteAncestor  :='�� ���� ������� ancestor';

  TeeMsg_Load	          :='�������...';
  TeeMsg_NoSeriesSelected :='����� �� �������';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='������';
  TeeMsg_CategorySeriesActions :='����� �������';

  TeeMsg_Action3D               := '&3D';
  TeeMsg_Action3DHint           := '������������ 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&��������';
  TeeMsg_ActionSeriesActiveHint := '�������� / �������� �����';
  TeeMsg_ActionEditHint         := '������������� ������';
  TeeMsg_ActionEdit             := '&�������������...';
  TeeMsg_ActionCopyHint         := '���������� � �����';
  TeeMsg_ActionCopy             := '&����������';
  TeeMsg_ActionPrintHint        := '��������������� ������� �������';
  TeeMsg_ActionPrint            := '&������...';
  TeeMsg_ActionAxesHint         := '�������� / �������� ���';
  TeeMsg_ActionAxes             := '&���';
  TeeMsg_ActionGridsHint        := '�������� / �������� �����';
  TeeMsg_ActionGrids            := '&�����';
  TeeMsg_ActionLegendHint       := '�������� / �������� �������';
  TeeMsg_ActionLegend           := '&�������';
  TeeMsg_ActionSeriesEditHint   := '������������� �����';
  TeeMsg_ActionSeriesMarksHint  := '�������� / �������� ������� �����';
  TeeMsg_ActionSeriesMarks      := '&�������';
  TeeMsg_ActionSaveHint         := '��������� ������';
  TeeMsg_ActionSave             := '&���������...';

  TeeMsg_CandleBar              := '������';
  TeeMsg_CandleNoOpen           := '��� ��������';
  TeeMsg_CandleNoClose          := '��� ��������';
  TeeMsg_NoLines                := '��� �����';
  TeeMsg_NoHigh                 := '��� ������';
  TeeMsg_NoLow                  := '��� ������';
  TeeMsg_ColorRange             := '����� �����';
  TeeMsg_WireFrame              := 'Wireframe';
  TeeMsg_DotFrame               := 'Dot Frame';
  TeeMsg_Positions              := '�������';
  TeeMsg_NoGrid                 := '��� �����';
  TeeMsg_NoPoint                := '��� �����';
  TeeMsg_NoLine                 := '��� �����';
  TeeMsg_Labels                 := '�������';
  TeeMsg_NoCircle               := '��� ������';
  TeeMsg_Lines                  := '�����';
  TeeMsg_Border                 := '����������';

  TeeMsg_SmithResistance      := 'Resistance';
  TeeMsg_SmithReactance       := 'Reactance';

  TeeMsg_Column               := '�������';

  { 5.01 }
  TeeMsg_Separator            := '�����������';
  TeeMsg_FunnelSegment        := '������� ';
  TeeMsg_FunnelSeries         := '�������';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := '��������� �������';
  TeeMsg_FunnelWithin         := ' � ��������';
  TeeMsg_FunnelBelow          := ' ��� ���� ��������';
  TeeMsg_CalendarSeries       := '���������';
  TeeMsg_DeltaPointSeries     := '����� ������';
  TeeMsg_ImagePointSeries     := '����� �������';
  TeeMsg_ImageBarSeries       := '������� ������';
  TeeMsg_SeriesTextFieldZero  := '����� �����: ���������� ����� ������ ���� ������ ����.';

  { 5.02 }
  TeeMsg_Origin               := 'Origin';
  TeeMsg_Transparency         := '������������';
  TeeMsg_Box		      := '����';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := '�������� �����';

  { 5.03 }
  TeeMsg_DragPoint            := 'Drag Point';
  TeeMsg_OpportunityValues    := 'OpportunityValues';
  TeeMsg_QuoteValues          := 'QuoteValues';

  TeeMsg_Property             := '��������';
  TeeMsg_Value                := '��������';

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
end;

Procedure TeeCreateRussian;
begin
  if not Assigned(TeeRussianLanguage) then
  begin
    TeeRussianLanguage:=TStringList.Create;
    TeeRussianLanguage.Text:=
'GRADIENT EDITOR=�������� ���������'#13+
'GRADIENT=��������'#13+
'DIRECTION=�����������'#13+
'VISIBLE=���������'#13+
'TOP BOTTOM=������ ����'#13+
'BOTTOM TOP=����� �����'#13+
'LEFT RIGHT=����� �������'#13+
'RIGHT LEFT=������ ������'#13+
'FROM CENTER=�� ������'#13+
'FROM TOP LEFT=�� �������� ������ ����'#13+
'FROM BOTTOM LEFT=�� ������� ������ ���� '#13+
'OK=Ok'#13+
'CANCEL=������'#13+
'COLORS=�����'#13+
'START=������'#13+
'MIDDLE=��������'#13+
'END=�����'#13+
'SWAP=��������'#13+
'NO MIDDLE=��� ��������'#13+
'TEEFONT EDITOR=�������� �������'#13+
'INTER-CHAR SPACING=������������� ����������'#13+
'FONT=�����'#13+
'SHADOW=����'#13+
'HORIZ. SIZE=�����. ������'#13+
'VERT. SIZE=����. ������'#13+
'COLOR=����'#13+
'OUTLINE=������'#13+
'OPTIONS=�����'#13+
'FORMAT=������'#13+
'TEXT=�����'#13+
'GRADIENT=��������'#13+
'POSITION=�������'#13+
'LEFT=�����'#13+
'TOP=������'#13+
'AUTO=����'#13+
'CUSTOM=�������������'#13+
'LEFT TOP=�� ������ �������� ����'#13+
'LEFT BOTTOM=�� ������ ������� ����'#13+
'RIGHT TOP=�� ������� �������� ����'#13+
'RIGHT BOTTOM=�� ������� ������� ����'#13+
'MULTIPLE AREAS=��������� ��������'#13+
'NONE=������'#13+
'STACKED=�������'#13+
'STACKED 100%=������� 100%'#13+
'AREA=�������'#13+
'PATTERN=����'#13+
'STAIRS=��������'#13+
'SOLID=��������'#13+
'CLEAR=��������'#13+
'HORIZONTAL=�������������'#13+
'VERTICAL=�����������'#13+
'DIAGONAL=�����������'#13+
'B.DIAGONAL=�.�����������'#13+
'CROSS=�����'#13+
'DIAG.CROSS=����. �����'#13+
'AREA LINES=����� �������'#13+
'BORDER=�������'#13+
'INVERTED=���������������'#13+
'INVERTED SCROLL=������������ ������'#13+
'COLOR EACH=���� �������'#13+
'ORIGIN=��������'#13+
'USE ORIGIN=������������ ��������'#13+
'WIDTH=������'#13+
'HEIGHT=������'#13+
'AXIS=���'#13+
'LENGTH=�����'#13+
'SCROLL=���������'#13+
'PATTERN=����'#13+
'START=������'#13+
'END=�����'#13+
'BOTH=���'#13+
'AXIS INCREMENT=��� ���'#13+
'INCREMENT=���'#13+
'INCREMENT=���'#13+
'STANDARD=����������'#13+
'CUSTOM=�������������'#13+
'ONE MILLISECOND=���� �����������'#13+
'ONE SECOND=���� �������'#13+
'FIVE SECONDS=���� ������'#13+
'TEN SECONDS=������ ������'#13+
'FIFTEEN SECONDS=���������� ������'#13+
'THIRTY SECONDS=�������� ������'#13+
'ONE MINUTE=���� ������'#13+
'FIVE MINUTES=���� �����'#13+
'TEN MINUTES=������ �����'#13+
'FIFTEEN MINUTES=���������� �����'#13+
'THIRTY MINUTES=�������� �����'#13+
'ONE HOUR=���� ���'#13+
'TWO HOURS=��� ����'#13+
'SIX HOURS=����� �����'#13+
'TWELVE HOURS=���������� �����'#13+
'ONE DAY=���� ����'#13+
'TWO DAYS=��� ���'#13+
'THREE DAYS=��� ���'#13+
'ONE WEEK=���� ������'#13+
'HALF MONTH=���������'#13+
'ONE MONTH=���� �����'#13+
'TWO MONTHS=��� ������'#13+
'THREE MONTHS=��� ������'#13+
'FOUR MONTHS=������ ������'#13+
'SIX MONTHS=����� �������'#13+
'ONE YEAR=���� ���'#13+
'EXACT DATE TIME=������ ���� � �����'#13+
'AXIS MAXIMUM AND MINIMUM=����������� � ������������ �������� ���'#13+
'VALUE=��������'#13+
'TIME=�����'#13+
'LEFT AXIS=����� ���'#13+
'RIGHT AXIS=������ ���'#13+
'TOP AXIS=������� ���'#13+
'BOTTOM AXIS=������ ���'#13+
'% BAR WIDTH=% ������ �������'#13+
'STYLE=�����'#13+
'% BAR OFFSET=% ������ �������'#13+
'RECTANGLE=�������������'#13+
'PYRAMID=��������'#13+
'INVERT. PYRAMID=������. ��������'#13+
'CYLINDER=�������'#13+
'ELLIPSE=������'#13+
'ARROW=������'#13+
'RECT. GRADIENT=�������. ��������'#13+
'CONE=Kegel'#13+
'DARK BAR 3D SIDES= ���������� �������'#13+
'BAR SIDE MARGINS=������� ������� '#13+
'AUTO MARK POSITION=������������� �������� �������'#13+
'COLOR EACH=���� �������'#13+
'BORDER=�������'#13+
'JOIN=����������'#13+
'BAR SIDE MARGINS=������� �������'#13+
'DATASET=����� ������'#13+
'APPLY=���������'#13+
'SOURCE=��������'#13+
'MONOCHROME=�����������'#13+
'DEFAULT=�� ���������'#13+
'2 (1 BIT)=2 (1 ���)'#13+
'16 (4 BIT)=16 (4 ���)'#13+
'256 (8 BIT)=256 (8 ���)'#13+
'32768 (15 BIT)=32768 (15 ���)'#13+
'65536 (16 BIT)=65536 (16 ���)'#13+
'16M (24 BIT)=16M (24 ���)'#13+
'16M (32 BIT)=16M (32 ���)'#13+
'LENGTH=�����'#13+
'MEDIAN=�������'#13+
'WHISKER=�������'#13+
'PATTERN COLOR EDITOR=�������� ������ �����'#13+
'IMAGE=�����������'#13+
'NONE=������'#13+
'BACK DIAGONAL=������ ���������'#13+
'CROSS=�����'#13+
'DIAGONAL CROSS=������������ �����'#13+
'FILL 80%=80% ����������'#13+
'FILL 60%=60% ����������'#13+
'FILL 40%=40% ����������'#13+
'FILL 20%=20% ����������'#13+
'FILL 10%=10% ����������'#13+
'ZIG ZAG=������'#13+
'VERTICAL SMALL=������������ ���������'#13+
'HORIZ. SMALL=��������. ���������'#13+
'DIAG. SMALL=������. ���������'#13+
'BACK DIAG. SMALL=������ ������. ���������'#13+
'CROSS SMALL=��������� �����'#13+
'DIAG. CROSS SMALL=������. ��������� �����'#13+
'PATTERN COLOR EDITOR=�������� ������ �����'#13+
'OPTIONS=���������'#13+
'DAYS=���'#13+
'WEEKDAYS=��� ������'#13+
'TODAY=�������'#13+
'SUNDAY=�����������'#13+
'TRAILING=����������'#13+
'MONTHS=������'#13+
'LINES=�����'#13+
'SHOW WEEKDAYS=�������� ��� ������'#13+
'UPPERCASE=������� �������'#13+
'TRAILING DAYS=���������� ���'#13+
'SHOW TODAY=�������� �������'#13+
'SHOW MONTHS=�������� ������'#13+
'CANDLE WIDTH=������ �����'#13+
'STICK=�����'#13+
'BAR=�������'#13+
'OPEN CLOSE=������� �������'#13+
'UP CLOSE=���� �������'#13+
'DOWN CLOSE=��� �������'#13+
'SHOW OPEN=�������� ��������'#13+
'SHOW CLOSE=�������� ��������'#13+
'DRAW 3D=���������'#13+
'DARK 3D=Ҹ���� ���������'#13+
'EDITING=��������������'#13+
'CHART=���������'#13+
'SERIES=�����'#13+
'DATA=������'#13+
'TOOLS=�����������'#13+
'EXPORT=�������'#13+
'PRINT=��������'#13+
'GENERAL=�����'#13+
'TITLES=���������'#13+
'LEGEND=�������'#13+
'PANEL=������'#13+
'PAGING=�� ���������'#13+
'WALLS=�����'#13+
'3D=���������'#13+
'ADD=��������'#13+
'DELETE=�������'#13+
'TITLE=��������'#13+
'CLONE=�����������'#13+
'CHANGE=��������'#13+
'HELP=������'#13+
'CLOSE=�������'#13+
'IMAGE=�����������'#13+
'TEECHART PRINT PREVIEW=�������� ������ TeeChart'#13+
'PRINTER=�������'#13+
'SETUP=���������'#13+
'ORIENTATION=����������'#13+
'PORTRAIT=����������'#13+
'LANDSCAPE=�����������'#13+
'MARGINS (%)=������� (%)'#13+
'DETAIL=������'#13+
'MORE=������'#13+
'NORMAL=���������'#13+
'RESET MARGINS=�������� �������'#13+
'VIEW MARGINS=�������� ������'#13+
'PROPORTIONAL=����������������'#13+
'TEECHART PRINT PREVIEW= �������� ������ TeeChart'#13+
'RECTANGLE=�������������'#13+
'CIRCLE=����'#13+
'VERTICAL LINE=����. �����'#13+
'HORIZ. LINE=�����. �����'#13+
'TRIANGLE=�����������'#13+
'INVERT. TRIANGLE=������. �����������'#13+
'LINE=�����'#13+
'DIAMOND=���������'#13+
'CUBE=���'#13+
'DIAGONAL CROSS=������������ �����'#13+
'STAR=������'#13+
'TRANSPARENT=����������'#13+
'HORIZ. ALIGNMENT=�����. ������������'#13+
'LEFT=�����'#13+
'CENTER=�� ������'#13+
'RIGHT=������'#13+
'ROUND RECTANGLE=���������� �������������'#13+
'ALIGNMENT=������������'#13+
'TOP=�������'#13+
'BOTTOM=������'#13+
'RIGHT=:������'#13+
'BOTTOM=������'#13+
'UNITS=�������'#13+
'PIXELS=�������'#13+
'AXIS=���'#13+
'AXIS ORIGIN=�������� ���'#13+
'ROTATION=��������'#13+
'CIRCLED=��������'#13+
'3 DIMENSIONS=���������'#13+
'RADIUS=������'#13+
'ANGLE INCREMENT=������� ����������'#13+
'RADIUS INCREMENT=���������� �������'#13+
'CLOSE CIRCLE=�������� ����'#13+
'PEN=����'#13+
'CIRCLE=����'#13+
'LABELS=�����'#13+
'VISIBLE=�������'#13+
'ROTATED=���������'#13+
'CLOCKWISE=�� ������� �������'#13+
'INSIDE=������'#13+
'ROMAN=�������'#13+
'HOURS=����'#13+
'MINUTES=������'#13+
'SECONDS=�������'#13+
'START VALUE=��������� ��������'#13+
'END VALUE=�������� ��������'#13+
'TRANSPARENCY=������������'#13+
'DRAW BEHIND=�������� �����'#13+
'COLOR MODE=�������� �����'#13+
'STEPS=����'#13+
'RANGE=��������'#13+
'PALETTE=�������'#13+
'PALE=�����'#13+
'STRONG=������'#13+
'GRID SIZE=��� �����'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=�������'#13+
'IRREGULAR=������������'#13+
'GRID=�����'#13+
'VALUE=��������'#13+
'ALLOW DRAG=��������� ��������������'#13+
'VERTICAL POSITION=������������ �������'#13+
'PEN=����'#13+
'LEVELS POSITION=������� �������'#13+
'LEVELS=������'#13+
'NUMBER=�����'#13+
'LEVEL=�������'#13+
'AUTOMATIC=�������������'#13+
'BOTH=���'#13+
'SNAP=��������'#13+
'FOLLOW MOUSE=��������� �� �����'#13+
'STACK=������'#13+
'HEIGHT 3D=��������� ������'#13+
'LINE MODE=����� �����'#13+
'STAIRS=���������'#13+
'NONE=������'#13+
'OVERLAP=����������'#13+
'STACK=������'#13+
'STACK 100%=������ 100%'#13+
'CLICKABLE=��� ������'#13+
'LABELS=�����'#13+
'AVAILABLE=��������'#13+
'SELECTED=����������'#13+
'DATASOURCE=�������� ������'#13+
'GROUP BY=������������ ��'#13+
'CALC=�����������'#13+
'OF=of'#13+
'SUM=Sum'#13+
'COUNT=Count'#13+
'HIGH=High'#13+
'LOW=Low'#13+
'AVG=Avg'#13+
'HOUR=Hour'#13+
'DAY=Day'#13+
'WEEK=Week'#13+
'WEEKDAY=WeekDay'#13+
'MONTH=Month'#13+
'QUARTER=Quarter'#13+
'YEAR=Year'#13+
'HOLE %=���� %'#13+
'RESET POSITIONS=����� �������'#13+
'MOUSE BUTTON=������ ����'#13+
'ENABLE DRAWING=�������� ���������'#13+
'ENABLE SELECT=�������� �����'#13+
'ENHANCED=�������������������'#13+
'ERROR WIDTH=������ ������'#13+
'WIDTH UNITS=������� ������'#13+
'PERCENT=�������'#13+
'PIXELS=������'#13+
'LEFT AND RIGHT=����� � ������'#13+
'TOP AND BOTTOM=������ � �����'#13+
'COLOR EACH=���� �������'#13+
'BORDER=�������'#13+
'BORDER EDITOR=�������� �������'#13+
'DASH=���������'#13+
'DOT=����������'#13+
'DASH DOT=����� ����������'#13+
'DASH DOT DOT=�����-��� ����������'#13+
'CALCULATE EVERY=��������� ������'#13+
'ALL POINTS=��� �����'#13+
'NUMBER OF POINTS=���������� �����'#13+
'RANGE OF VALUES=�������� ��������'#13+
'FIRST=������'#13+
'CENTER=�����������'#13+
'LAST=���������'#13+
'TEEPREVIEW EDITOR=TeePreview ��������'#13+
'ALLOW MOVE=��������� �����������'#13+
'ALLOW RESIZE=��������� ��������� �������'#13+
'DRAG IMAGE=���������� �����������'#13+
'AS BITMAP=��� ������� �����'#13+
'SHOW IMAGE=�������� �����������'#13+
'DEFAULT=�� ���������'#13+
'MARGINS=�������'#13+
'SIZE=������'#13+
'3D %=��������� %'#13+
'ZOOM=����������'#13+
'ROTATION=��������'#13+
'ELEVATION=������'#13+
'100%=100%'#13+
'HORIZ. OFFSET=�����. ��������'#13+
'VERT. OFFSET=����. ��������'#13+
'PERSPECTIVE=�����������'#13+
'ANGLE=����'#13+
'ORTHOGONAL=�������������'#13+
'ZOOM TEXT=��������� �����'#13+
'SCALES=�����'#13+
'TITLE=���������'#13+
'TICKS=�������'#13+
'MINOR=��������������'#13+
'MAXIMUM=������������'#13+
'MINIMUM=�����������'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=�������� ����������'#13+
'(INCREMENT)=(����������)'#13+
'LOG BASE=��������� ���������'#13+
'LOGARITHMIC=���������������'#13+
'TITLE=���������'#13+
'MIN. SEPARATION %=���. ���������� %'#13+
'MULTI-LINE=��������� �����'#13+
'LABEL ON AXIS=����� �� ���'#13+
'ROUND FIRST=��������� ������'#13+
'MARK=�������'#13+
'LABELS FORMAT=������ �����'#13+
'EXPONENTIAL=����������������'#13+
'DEFAULT ALIGNMENT=������������ �� ���������'#13+
'LEN=�����'#13+
'AXIS=���'#13+
'INNER=����������'#13+
'GRID=�����'#13+
'AT LABELS ONLY=������ �� ������'#13+
'CENTERED=��������������'#13+
'COUNT=����������'#13+
'TICKS=�������'#13+
'POSITION %=������� %'#13+
'START %=������ %'#13+
'END %=����� %'#13+
'OTHER SIDE=������ �������'#13+
'AXES=���'#13+
'BEHIND=������'#13+
'CLIP POINTS=����� ������'#13+
'PRINT PREVIEW=�������� ������'#13+
'MINIMUM PIXELS=���������� ��������'#13+
'MOUSE BUTTON=������ ����'#13+
'ALLOW=���������'#13+
'ANIMATED=�������������'#13+
'VERTICAL=������������'#13+
'RIGHT=������'#13+
'MIDDLE=���������'#13+
'ALLOW SCROLL=��������� ���������'#13+
'TEEOPENGL EDITOR=�������� TeeOpenGL'#13+
'AMBIENT LIGHT=���������� ����'#13+
'SHININESS=������'#13+
'FONT 3D DEPTH=��������� ������� ������'#13+
'ACTIVE=��������'#13+
'FONT OUTLINES=��������� ������'#13+
'SMOOTH SHADING=������� ���������'#13+
'LIGHT=����'#13+
'Y=Y'#13+
'INTENSITY=�������������'#13+
'BEVEL=�����'#13+
'FRAME=�����'#13+
'ROUND FRAME=���������� �����'#13+
'LOWERED=����������'#13+
'RAISED=�����������'#13+
'POSITION=�������'#13+
'SYMBOLS=�������'#13+
'TEXT STYLE=����� ������'#13+
'LEGEND STYLE=������� ������'#13+
'VERT. SPACING=����������� ������'#13+
'AUTOMATIC=��������������'#13+
'SERIES NAMES=������������ �����'#13+
'SERIES VALUES=�������� �����'#13+
'LAST VALUES=��������� ��������'#13+
'PLAIN=�������'#13+
'LEFT VALUE=����� ��������'#13+
'RIGHT VALUE=������ ��������'#13+
'LEFT PERCENT=��������� �����'#13+
'RIGHT PERCENT=��������� ������'#13+
'X VALUE=�������� �� X'#13+
'VALUE=��������'#13+
'PERCENT=�������'#13+
'X AND VALUE=X and ��������'#13+
'X AND PERCENT=X and �������'#13+
'CHECK BOXES=������ ������'#13+
'DIVIDING LINES=�������������� �����'#13+
'FONT SERIES COLOR=���� ��������� �������'#13+
'POSITION OFFSET %=������ ������� %'#13+
'MARGIN=�������'#13+
'RESIZE CHART=�������� ������ ���������'#13+
'CUSTOM=��������������'#13+
'WIDTH UNITS=������� ������'#13+
'CONTINUOUS=��������'#13+
'POINTS PER PAGE=����� �� ��������'#13+
'SCALE LAST PAGE=��������� ��������� ��������'#13+
'CURRENT PAGE LEGEND=������� ������� ��������'#13+
'PANEL EDITOR=�������� �������'#13+
'BACKGROUND=���'#13+
'BORDERS=�������'#13+
'BACK IMAGE=������� �����������'#13+
'STRETCH=���������'#13+
'TILE=���������'#13+
'CENTER=�����'#13+
'BEVEL INNER=���������� ����'#13+
'LOWERED=����������'#13+
'RAISED=�����������'#13+
'BEVEL OUTER=������� ����'#13+
'MARKS=�������'#13+
'DATA SOURCE=�������� ������'#13+
'SORT=�����������'#13+
'CURSOR=������'#13+
'SHOW IN LEGEND=�������� � �������'#13+
'FORMATS=�������'#13+
'VALUES=��������'#13+
'PERCENTS=��������'#13+
'HORIZONTAL AXIS=�������������� ���'#13+
'TOP AND BOTTOM=���� � ���'#13+
'DATETIME=���� � �����'#13+
'VERTICAL AXIS=������������ ���'#13+
'LEFT=�����'#13+
'RIGHT=������'#13+
'LEFT AND RIGHT=����� � ������'#13+
'ASCENDING=�����������'#13+
'DESCENDING=���������'#13+
'DRAW EVERY=�������� ������'#13+
'CLIPPED=���������'#13+
'ARROWS=�������'#13+
'MULTI LINE=��������� �����'#13+
'ALL SERIES VISIBLE=��� ����� �������'#13+
'LABEL=�����'#13+
'LABEL AND PERCENT=����� � �������'#13+
'LABEL AND VALUE=����� � ��������'#13+
'PERCENT TOTAL=����� ���������'#13+
'LABEL AND PERCENT TOTAL=����� � ����� ���������'#13+
'X VALUE=�������� �� X'#13+
'X AND Y VALUES=�������� �� X � Y'#13+
'MANUAL=�������'#13+
'RANDOM=��������'#13+
'FUNCTION=�������'#13+
'NEW=�����'#13+
'EDIT=�������������'#13+
'DELETE=�������'#13+
'PERSISTENT=����������'#13+
'ADJUST FRAME=��������� �����'#13+
'SUBTITLE=������������'#13+
'SUBFOOT=�������'#13+
'FOOT= ����'#13+
'DELETE=�������'#13+
'VISIBLE WALLS=������� �����'#13+
'BACK=������ ���'#13+
'DIF. LIMIT=������� ������'#13+
'LINES=�����'#13+
'ABOVE=����'#13+
'WITHIN=������'#13+
'BELOW=����'#13+
'CONNECTING LINES=�������������� �����'#13+
'SERIES=�����'#13+
'PALE=�������'#13+
'STRONG=������'#13+
'HIGH=Oben'#13+
'LOW=������'#13+
'BROWSE=��������'#13+
'TILED=���������'#13+
'INFLATE MARGINS=������� �������'#13+
'SQUARE=�������'#13+
'DOWN TRIANGLE=������ �����������'#13+
'SMALL DOT=��������� �����'#13+
'DEFAULT=�� ���������'#13+
'COLOR EACH=���� �������'#13+
'GLOBAL=����������'#13+
'SHAPES=�����'#13+
'BRUSH=�����'#13+
'BRUSH=�����'#13+
'BORDER=�������'#13+
'COLOR=����'#13+
'DELAY=��������'#13+
'MSEC.=�������.'#13+
'MOUSE ACTION=�������� ����'#13+
'MOVE=��������'#13+
'CLICK=������'#13+
'BRUSH=�����'#13+
'DRAW LINE=�������� �����'#13+
'BORDER EDITOR=�������� �������'#13+
'DASH=Solid'#13+
'DOT=Dash'#13+
'DASH DOT=Dot'#13+
'DASH DOT DOT=Dash Dot'#13+
'EXPLODE BIGGEST=����������� ����������'#13+
'TOTAL ANGLE=������ ����'#13+
'GROUP SLICES=����� �����'#13+
'BELOW %=����� %'#13+
'BELOW VALUE=�������� ����'#13+
'OTHER=������'#13+
'PATTERNS=����'#13+
'CLOSE CIRCLE=�������� ����'#13+
'VISIBLE=�������'#13+
'CLOCKWISE=�� ������� �������'#13+
'SIZE %=������ %'#13+
'PATTERN=����'#13+
'DEFAULT=�� ���������'#13+
'SERIES DATASOURCE TEXT EDITOR=�������� ������� ������ ��� �����'#13+
'FIELDS=����'#13+
'NUMBER OF HEADER LINES=���������� ����� ���������'#13+
'SEPARATOR=�����������'#13+
'COMMA=�������'#13+
'SPACE=������'#13+
'TAB=���������'#13+
'FILE=����'#13+
'WEB URL=����� Web'#13+
'LOAD=���������'#13+
'C LABELS=C �����'#13+
'R LABELS=R �����'#13+
'C PEN=C ����'#13+
'R PEN=R ����'#13+
'STACK GROUP=������ ������'#13+
'USE ORIGIN=������������ ��������'#13+
'MULTIPLE BAR=��������� ��������'#13+
'SIDE=�������'#13+
'STACKED 100%=� ������ 100%'#13+
'SIDE ALL=��� �������'#13+
'BRUSH=�����'#13+
'DRAWING MODE=����� ���������'#13+
'SOLID=��������'#13+
'WIREFRAME=�����������'#13+
'DOTFRAME=��������'#13+
'SMOOTH PALETTE=������� �������'#13+
'SIDE BRUSH=������� �����'#13+
'ABOUT TEECHART PRO V7.0=� TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=��� ����� ��������.'#13+
'VISIT OUR WEB SITE !=�������� ���� �������� � �������� !'#13+
'TEECHART WIZARD=������ TeeChart'#13+
'SELECT A CHART STYLE=�������� ��� ���������'#13+
'DATABASE CHART=���������, ��������� � �������'#13+
'NON DATABASE CHART= ���������, �� ��������� � ������� '#13+
'SELECT A DATABASE TABLE=�������� ������� ���� ������'#13+
'ALIAS=���������'#13+
'TABLE=�������'#13+
'SOURCE=��������'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=�������� ����������� ����'#13+
'SELECT A TEXT LABELS FIELD=�������� ����� ��� ����� ������'#13+
'CHOOSE THE DESIRED CHART TYPE=�������� ������� ��� ���������'#13+
'2D=����������'#13+
'CHART PREVIEW=�������� ���������'#13+
'SHOW LEGEND=�������� �������'#13+
'SHOW MARKS=�������� �������'#13+
'COLOR EACH=���� �������'#13+
'< BACK=< �����'#13+
'SELECT A CHART STYLE=�������� ����� ���������'#13+
'NON DATABASE CHART=���������, �� ��������� � �������'#13+
'SELECT A DATABASE TABLE= �������� ������� ���� ������'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=�������� ����������� ����'#13+
'SELECT A TEXT LABELS FIELD=�������� ����� ��� ����� ������'#13+
'CHOOSE THE DESIRED CHART TYPE=�������� ������� ��� ���������'#13+
'EXPORT CHART=�������������� ���������'#13+
'PICTURE=��������'#13+
'NATIVE=TeeFile'#13+
'KEEP ASPECT RATIO=��������� ����������� ������'#13+
'INCLUDE SERIES DATA=�������� ������ �����'#13+
'FILE SIZE=������ �����'#13+
'DELIMITER=�����������'#13+
'XML=XML'#13+
'HTML TABLE=HTML �������'#13+
'EXCEL=Excel'#13+
'TAB=Tab'#13+
'COLON=���������'#13+
'INCLUDE=��������'#13+
'POINT LABELS=����� �����'#13+
'POINT INDEX=������ �����'#13+
'HEADER=���������'#13+
'COPY=����������'#13+
'SAVE=���������'#13+
'SEND=���������'#13+
'KEEP ASPECT RATIO=��������� ����������� ������'#13+
'INCLUDE SERIES DATA=�������� ������ ����� '#13+
'FUNCTIONS=�������'#13+
'ADD=��������'#13+
'ADX=ADX'#13+
'AVERAGE=�������'#13+
'BOLLINGER=Dividieren'#13+
'COPY=����������'#13+
'DIVIDE=���������'#13+
'EXP. AVERAGE=���. ��������'#13+
'EXP.MOV.AVRG.=Gleit.Durchschn.'#13+
'HIGH=�������'#13+
'LOW=������'#13+
'MACD=MACD'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div'#13+
'MOVING AVRG.=Multiplizieren'#13+
'MULTIPLY=�����������'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=���������� ������'#13+
'STD.DEVIATION=Subtrahieren'#13+
'STOCHASTIC=��������������'#13+
'SUBTRACT=���������'#13+
'APPLY=���������'#13+
'SOURCE SERIES=����� ����������'#13+
'TEECHART GALLERY=������� TeeChart'#13+
'FUNCTIONS=�������'#13+
'DITHER=Dither'#13+
'REDUCTION=Reduction'#13+
'COMPRESSION=Compression'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=���������'#13+
'FLOYD STEINBERG=����� ���������'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=���� ���'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows �����'#13+
'MONOCHROME=�����������'#13+
'GRAY SCALE=������� ������'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=��������������'#13+
'QUANTIZE 256=�������������� 256'#13+
'% QUALITY=% ��������'#13+
'GRAY SCALE=������� ������'#13+
'PERFORMANCE=������������������'#13+
'QUALITY=��������'#13+
'SPEED=��������'#13+
'COMPRESSION LEVEL=������� ������'#13+
'CHART TOOLS GALLERY=������� Chart Tools'#13+
'ANNOTATION=���������'#13+
'AXIS ARROWS=������� ����'#13+
'COLOR BAND=������� ����'#13+
'COLOR LINE=������� �����'#13+
'CURSOR=������'#13+
'DRAG MARKS=����������� �������'#13+
'DRAW LINE=�������� �����'#13+
'IMAGE=�����������'#13+
'MARK TIPS=�������� ���������'#13+
'NEAREST POINT=��������� �����'#13+
'ROTATE=�������'#13+
'CHART TOOLS GALLERY=������� Chart Tools'#13+
'BRUSH=�����'#13+
'DRAWING MODE=����� ���������'#13+
'WIREFRAME=�����������'#13+
'SMOOTH PALETTE=������� �������'#13+
'SIDE BRUSH=������� �����'#13+
'YES=��'#13
;
  end;
end;

Procedure TeeSetRussian;
begin
  TeeCreateRussian;
  TeeLanguage:=TeeRussianLanguage;
  TeeRussianConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeRussianLanguage);
end.
