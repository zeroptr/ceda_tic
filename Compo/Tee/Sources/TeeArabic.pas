unit TeeArabic;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeArabicLanguage:TStringList=nil;

Procedure TeeSetArabic;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeArabicConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 by David Berneda';
  TeeMsg_LegendFirstValue   :='������ ������ ������ �����  ��� �� ����> 0';
  TeeMsg_LegendColorWidth   :='��� ����� ������ ����� ��� �� ���� > 0%';
  TeeMsg_SeriesSetDataSource:='������ ���� ������� ���� ��������';
  TeeMsg_SeriesInvDataSource:='��� ����� ���� ��������: %s';
  TeeMsg_FillSample         :='����� ������� ��� �� ���� > 0';
  TeeMsg_AxisLogDateTime    :='����������� ��� ��� ���� ���������';
  TeeMsg_AxisLogNotPositive :='���� ������ � ������ ������ ����������� ��� �� ���� >= 0';
  TeeMsg_AxisLabelSep       :='����� ������ % ��� �� ���� 0';
  TeeMsg_AxisIncrementNeg   :='������� �� ������ ��� �� ���� >= 0';
  TeeMsg_AxisMinMax         :='���� ������ ������ ��� �� ���� <= ���� ������';
  TeeMsg_AxisMaxMin         :='���� ������ ������ ��� �� ���� <= ���� ������';
  TeeMsg_AxisLogBase        :='���� ���� ����������  ��� �� ���� >= 2';
  TeeMsg_MaxPointsPerPage   :='���� ������ ������ �������  ��� �� ���� >= 0';
  TeeMsg_3dPercent          :='3D �����  ��� �� ���� ��� %d � %d';
  TeeMsg_CircularSeries     :='  ��� ����� �������� �������� ������ �������� ';
  TeeMsg_WarningHiColor     :='16k ��� �� ���� ������ ��� ���� ���';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='����� ������ ';
  TeeMsg_AxisLabels         :='����� ������ ';
  TeeMsg_RefreshInterval    :='Refresh Interval must be between 0 and 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart is not myself!';
  TeeMsg_GalleryLine        :='��';
  TeeMsg_GalleryPoint       :='����';
  TeeMsg_GalleryArea        :='�����';
  TeeMsg_GalleryBar         :='�����';
  TeeMsg_GalleryHorizBar    :='���� �����';
  TeeMsg_Stack              :='����� �������';
  TeeMsg_GalleryPie         :='�����';
  TeeMsg_GalleryCircled     :='�����';
  TeeMsg_GalleryFastLine    :='�� ����';
  TeeMsg_GalleryHorizLine   :='�� ����';

  TeeMsg_PieSample1         :='������';
  TeeMsg_PieSample2         :='�����';
  TeeMsg_PieSample3         :='�����';
  TeeMsg_PieSample4         :='�����';
  TeeMsg_PieSample5         :='������';
  TeeMsg_PieSample6         :='����� ������';
  TeeMsg_PieSample7         :='������';
  TeeMsg_PieSample8         :='�����';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='����� %s';

  TeeMsg_GalleryStandard    :='�����';
  TeeMsg_GalleryExtended    :='����';
  TeeMsg_GalleryFunctions   :='����';

  TeeMsg_EditChart          :='�&���� ����� �������...';
  TeeMsg_PrintPreview       :='&��� �������...';
  TeeMsg_ExportChart        :='����� ����� �������...';
  TeeMsg_CustomAxes         :='����� ����� ..';

  TeeMsg_InvalidEditorClass :='%s: Invalid Editor Class: %s';
  TeeMsg_MissingEditorClass :='%s: has no Editor Dialog';

  TeeMsg_GalleryArrow       :='���';

  TeeMsg_ExpFinish          :='&�����';
  TeeMsg_ExpNext            :='&������ >';

  TeeMsg_GalleryGantt       :='���� ����';

  TeeMsg_GanttSample1       :='�����';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :='�����';
  TeeMsg_GanttSample4       :='������';
  TeeMsg_GanttSample5       :='�����';
  TeeMsg_GanttSample6       :='�����';
  TeeMsg_GanttSample7       :='�����';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='���� �����';
  TeeMsg_GanttSample10      :='����';

  TeeMsg_ChangeSeriesTitle  :='�����  ����� ����� ';
  TeeMsg_NewSeriesTitle     :='����� ����� ���� :';
  TeeMsg_DateTime           :='�������';
  TeeMsg_TopAxis            :='���� ���� ';
  TeeMsg_BottomAxis         :='���� ���� ';
  TeeMsg_LeftAxis           :='���� ���� ';
  TeeMsg_RightAxis          :='���� ���� ';

  TeeMsg_SureToDelete       :='��� %s ?';
  TeeMsg_DateTimeFormat     :='��� �������:';
  TeeMsg_Default            :='�������';
  TeeMsg_ValuesFormat       :='����� �������:';
  TeeMsg_Maximum            :='������';
  TeeMsg_Minimum            :='������';
  TeeMsg_DesiredIncrement   :='�������� %s ������� ';

  TeeMsg_IncorrectMaxMinValue:='������ ��� ����� .����: %s';
  TeeMsg_EnterDateTime      :='���� [��� ������] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='��� ��������� ?';
  TeeMsg_SelectedSeries     :='(����� �������)';
  TeeMsg_RefreshData        :='&Refresh Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_FunctionAdd        :='�����';
  TeeMsg_FunctionSubtract   :='���';
  TeeMsg_FunctionMultiply   :='���';
  TeeMsg_FunctionDivide     :='����';
  TeeMsg_FunctionHigh       :='������';
  TeeMsg_FunctionLow        :='������';
  TeeMsg_FunctionAverage    :='�������';

  TeeMsg_GalleryShape       :='�����';
  TeeMsg_GalleryBubble      :='�����';
  TeeMsg_FunctionNone       :='���';

  TeeMsg_None               :='(����)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='���� �� ���� ���� ��Pointer ���  zero';
  TeeMsg_About              :='��&� TeeChart...';

  tcAdditional              :='�����';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='��� ����';
  TeeMsg_AskDataSource      :='&DataSource:';

  TeeMsg_Summary            :='Summary';

  TeeMsg_FunctionPeriod     :='���� ���� ���� �� ����  >= 0';

  TeeMsg_WizardTab          :='Business';
  TeeMsg_TeeChartWizard     :='TeeChart �����';

  TeeMsg_ClearImage         :='���';
  TeeMsg_BrowseImage        :='������&�...';

  TeeMsg_WizardSureToClose  :='��� ��� ����� TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='�����  %s ��� ����� ';

  TeeMsg_DepthAxis          :='���� ����� ';
  TeeMsg_PieOther           :='����';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='�����';
  TeeMsg_ValuesBar          :='�����';
  TeeMsg_ValuesAngle        :='�������';
  TeeMsg_ValuesGanttStart   :='�������';
  TeeMsg_ValuesGanttEnd     :='�������';
  TeeMsg_ValuesGanttNextTask:='������ �������';
  TeeMsg_ValuesBubbleRadius :='�����';
  TeeMsg_ValuesArrowEndX    :='����� X';
  TeeMsg_ValuesArrowEndY    :='����� Y';
  TeeMsg_Legend             :='����� �����';
  TeeMsg_Title              :='�����';
  TeeMsg_Foot               :='����� ';
  TeeMsg_Period		    :='����';
  TeeMsg_PeriodRange        :='���� ���';
  TeeMsg_CalcPeriod         :='����  %s  �� :';
  TeeMsg_SmallDotsPen       :='Small Dots';

  TeeMsg_InvalidTeeFile     :='Invalid ����� ������� in *.'+TeeMsg_TeeExtension+' file';
  TeeMsg_WrongTeeFileFormat :='Wrong *.'+TeeMsg_TeeExtension+' file format';
  TeeMsg_EmptyTeeFile       :='Empty *.'+TeeMsg_TeeExtension+' file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := '���� �����';
  TeeMsg_ChartAxesCategoryDesc   := '����� ������� Axes properties and events';
  TeeMsg_ChartWallsCategoryName  := '����� ������� Walls';
  TeeMsg_ChartWallsCategoryDesc  := '����� ������� Walls properties and events';
  TeeMsg_ChartTitlesCategoryName := '������ �����';
  TeeMsg_ChartTitlesCategoryDesc := '����� ������� Titles properties and events';
  TeeMsg_Chart3DCategoryName     := '����� ������� 3D';
  TeeMsg_Chart3DCategoryDesc     := '����� ������� 3D properties and events';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='����� ';
  TeeMsg_Series                 :='�����';
  TeeMsg_SeriesList             :='�����...';

  TeeMsg_PageOfPages            :='������ ��� %d �� %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='�����';
  TeeMsg_Prior  :='������';
  TeeMsg_Next   :='������';
  TeeMsg_Last   :='������';
  TeeMsg_Insert :='�����';
  TeeMsg_Delete :='���';
  TeeMsg_Edit   :='�����';
  TeeMsg_Post   :='���';
  TeeMsg_Cancel :='�����';

  TeeMsg_All    :='(����)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='as &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='as &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := '���� property is not set in Export �����';

  TeeMsg_Normal    :='�����';
  TeeMsg_NoBorder  :='�� ����';
  TeeMsg_Dotted    :='����';
  TeeMsg_Colors    :='�����';
  TeeMsg_Filled    :='�����';
  TeeMsg_Marks     :='������';
  TeeMsg_Stairs    :='Stairs';
  TeeMsg_Points    :='����';
  TeeMsg_Height    :='������';
  TeeMsg_Hollow    :='����';
  TeeMsg_Point2D   :='���� 2D';
  TeeMsg_Triangle  :='����';
  TeeMsg_Star      :='����';
  TeeMsg_Circle    :='�����';
  TeeMsg_DownTri   :='Down Tri.';
  TeeMsg_Cross     :='Cross';
  TeeMsg_Diamond   :='Diamond';
  TeeMsg_NoLines   :='���� ����';
  TeeMsg_Stack100  :='������� 100%';
  TeeMsg_Pyramid   :='����';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='��� �����';
  TeeMsg_Sides     :='�����';
  TeeMsg_SideAll   :='����� ����';
  TeeMsg_Patterns  :='����';
  TeeMsg_Exploded  :='�����';
  TeeMsg_Shadow    :='��';
  TeeMsg_SemiPie   :='��� �����';
  TeeMsg_Rectangle :='������';
  TeeMsg_VertLine  :='�� ����';
  TeeMsg_HorizLine :='�� ����';
  TeeMsg_Line      :='��';
  TeeMsg_Cube      :='����';
  TeeMsg_DiagCross :='Diag.Cross';

  TeeMsg_CanNotFindTempPath    :='�� ������ find Temp folder';
  TeeMsg_CanNotCreateTempChart :='�� ������ create Temp file';
  TeeMsg_CanNotEmailChart      :='�� ������ email TeeChart. Mapi ���: %d';

  TeeMsg_SeriesDelete :='Series Delete: ValueIndex %d out of bounds (0 to %d).';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='as &JPEG';
  TeeMsg_JPEGFilter    :='JPEG files (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='as &GIF';
  TeeMsg_GIFFilter     :='GIF files (*.gif)|*.gif';
  TeeMsg_AsPNG         :='as &PNG';
  TeeMsg_PNGFilter     :='PNG files (*.png)|*.png';
  TeeMsg_AsPCX         :='as PC&X';
  TeeMsg_PCXFilter     :='PCX files (*.pcx)|*.pcx';

  { 5.02 }
  TeeMsg_AskLanguage  :='���&��...';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='����';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='����';
  TeeMsg_GalleryContour     :='Contour';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='���� 3D';
  TeeMsg_GalleryRadar       :='�����';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='����� 3D';
  TeeMsg_GalleryBigCandle   :='Big Candle';
  TeeMsg_GalleryLinePoint   :='�� ����';
  TeeMsg_GalleryHistogram   :='��� ������';
  TeeMsg_GalleryWaterFall   :='������';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='����';
  TeeMsg_GalleryColorGrid   :='���� �����';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='����� ����';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='���';
  TeeMsg_GalleryMap         :='�����';

  TeeMsg_PolyDegreeRange    :='���� ����� ������ ��� �� ���� ��� 1 � 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index must be between 1 and %d';
  TeeMsg_FittingError        :='Cannot process fitting';
  TeeMsg_PeriodRange         :='���� ��� �� ���� >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage Weight must be between 0 and 1';
  TeeMsg_GalleryErrorBar     :='��� �����';
  TeeMsg_GalleryError        :='���';
  TeeMsg_GalleryHighLow      :='����-�����';
  TeeMsg_FunctionMomentum    :='���� ������';
  TeeMsg_FunctionMomentumDiv :='���� ������ ���';
  TeeMsg_FunctionExpAverage  :='Exp. Average';
  TeeMsg_FunctionMovingAverage:='������� �������';
  TeeMsg_FunctionExpMovAve   :='Exp.Mov.Avrg.';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='Curve Fitting';
  TeeMsg_FunctionTrend       :='Trend';
  TeeMsg_FunctionExpTrend    :='Exp.Trend';
  TeeMsg_FunctionLogTrend    :='Log.Trend';
  TeeMsg_FunctionCumulative  :='������';
  TeeMsg_FunctionStdDeviation:='�������� ��������';
  TeeMsg_FunctionBollinger   :='Bollinger';
  TeeMsg_FunctionRMS         :='Root Mean Sq.';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='Stochastic';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='���';
  TeeMsg_LoadChart           :='��� TeeChart...';
  TeeMsg_SaveChart           :='��� TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro �����';

  TeeMsg_GallerySamples      :='���';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='�� ������ ����� ���� �������: %s';


  TeeMsg_CannotLoadChartFromURL:='��� code: %d ����� ����� ������� from URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='��� code: %d ����� ������ ������� �� URL: %s';

  TeeMsg_Test                :='�����...';

  TeeMsg_ValuesDate          :='�����';
  TeeMsg_ValuesOpen          :='���';
  TeeMsg_ValuesHigh          :='����';
  TeeMsg_ValuesLow           :='�����';
  TeeMsg_ValuesClose         :='�����';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='��� �����';

  TeeMsg_Grid3D              :='������ 3D';

  TeeMsg_LowBezierPoints     :='Number of Bezier points should be > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='�����';
  TeeCommanMsg_Edit     :='�����';
  TeeCommanMsg_Print    :='�����';
  TeeCommanMsg_Copy     :='���';
  TeeCommanMsg_Save     :='���';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='�����: %d� Elevation: %d�';
  TeeCommanMsg_Rotate   :='���';

  TeeCommanMsg_Moving   :='Horiz.Offset: %d Vert.Offset: %d';
  TeeCommanMsg_Move     :='���';

  TeeCommanMsg_Zooming  :='������: %d %%';
  TeeCommanMsg_Zoom     :='������';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='���';

  TeeCommanMsg_Chart    :='����� �������';
  TeeCommanMsg_Panel    :='����';

  TeeCommanMsg_RotateLabel:='���� %s �����';
  TeeCommanMsg_MoveLabel  :='���� %s ������';
  TeeCommanMsg_ZoomLabel  :='���� %s ������ �������';
  TeeCommanMsg_DepthLabel :='���� %s ������ �����  3D';

  TeeCommanMsg_NormalLabel:='���� Left button to Zoom, Right button to Scroll';
  TeeCommanMsg_NormalPieLabel:='���� a ����� Slice to Explode it';

  TeeCommanMsg_PieExploding :='Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess        :='��� ������ ��� ��  ����  >= 4';
  TeeMsg_TriSurfaceAllColinear :='All colinear data points';
  TeeMsg_TriSurfaceSimilar     :='Similar points - cannot execute';
  TeeMsg_GalleryTriSurface     :='���� ����';

  TeeMsg_AllSeries :='�� �������';
  TeeMsg_Edit      :='�����';

  TeeMsg_GalleryFinancial    :='����';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='���� ������';
  TeeMsg_AxisArrowTool :='���� ������';
  TeeMsg_DrawLineTool  :='��� ��';
  TeeMsg_NearestTool   :='����  ����';
  TeeMsg_ColorBandTool :='��� ������';
  TeeMsg_ColorLineTool :='��� ����';
  TeeMsg_RotateTool    :='����';
  TeeMsg_ImageTool     :='����';
  TeeMsg_MarksTipTool  :='Mark Tips';

  TeeMsg_CantDeleteAncestor  :='�� ������ delete ancestor';

  TeeMsg_Load	          :='�����...';
  TeeMsg_NoSeriesSelected :='�� ���� ����� ������';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='��� �����';
  TeeMsg_CategorySeriesActions :='����� ����� �������';

  TeeMsg_Action3D               := '&����� �������';
  TeeMsg_Action3DHint           := '������� ��� 2D / 3D';
  TeeMsg_ActionSeriesActive     := '&���';
  TeeMsg_ActionSeriesActiveHint := '�����\����� �������';
  TeeMsg_ActionEditHint         := '����� ����� �������';
  TeeMsg_ActionEdit             := '&�����...';
  TeeMsg_ActionCopyHint         := '���';
  TeeMsg_ActionCopy             := '&���';
  TeeMsg_ActionPrintHint        := '��� ������� ����� �������';
  TeeMsg_ActionPrint            := '&�����...';
  TeeMsg_ActionAxesHint         := '�����\����� ������';
  TeeMsg_ActionAxes             := '&����';
  TeeMsg_ActionGridsHint        := '�����\����� ������';
  TeeMsg_ActionGrids            := '&������';
  TeeMsg_ActionLegendHint       := '�����\�����  ����� �����';
  TeeMsg_ActionLegend           := '&����� �����';
  TeeMsg_ActionSeriesEditHint   := '����� �������';
  TeeMsg_ActionSeriesMarksHint  := '�����\�����  ������ �������';
  TeeMsg_ActionSeriesMarks      := '&������';
  TeeMsg_ActionSaveHint         := '��� ����� �������';
  TeeMsg_ActionSave             := '&���...';

  TeeMsg_CandleBar              := '�����';
  TeeMsg_CandleNoOpen           := 'No Open';
  TeeMsg_CandleNoClose          := 'No Close';
  TeeMsg_NoLines                := 'No Lines';
  TeeMsg_NoHigh                 := 'No High';
  TeeMsg_NoLow                  := 'No Low';
  TeeMsg_ColorRange             := '��� ���';
  TeeMsg_WireFrame              := 'Wireframe';
  TeeMsg_DotFrame               := 'Dot Frame';
  TeeMsg_Positions              := '�����';
  TeeMsg_NoGrid                 := '��� ����';
  TeeMsg_NoPoint                := '��� ����';
  TeeMsg_NoLine                 := '��� ��';
  TeeMsg_Labels                 := '������';
  TeeMsg_NoCircle               := '��� �����';
  TeeMsg_Lines                  := '����';
  TeeMsg_Border                 := '����';

  TeeMsg_SmithResistance      := '������';
  TeeMsg_SmithReactance       := 'Reactance';

  TeeMsg_Column               := '����';

  { 5.01 }
  TeeMsg_Separator            := '����';
  TeeMsg_FunnelSegment        := '���� ';
  TeeMsg_FunnelSeries         := 'Funnel';
  TeeMsg_FunnelPercent        := '0.00 %';
  TeeMsg_FunnelExceed         := 'Exceeds quota';
  TeeMsg_FunnelWithin         := ' within quota';
  TeeMsg_FunnelBelow          := ' or more below quota';
  TeeMsg_CalendarSeries       := 'Calendar';
  TeeMsg_DeltaPointSeries     := 'DeltaPoint';
  TeeMsg_ImagePointSeries     := 'ImagePoint';
  TeeMsg_ImageBarSeries       := 'ImageBar';
  TeeMsg_SeriesTextFieldZero  := 'SeriesText: Field index should be greater than zero.';

  { 5.02 }
  TeeMsg_Origin               := '�����';
  TeeMsg_Transparency         := '����';
  //TeeMsg_InvertedScroll       := '����� �����';
  TeeMsg_Box		      := '�����';
  TeeMsg_ExtrOut	      := 'ExtrOut';
  TeeMsg_MildOut	      := 'MildOut';
  TeeMsg_PageNumber	      := '��� ������';
end;

Procedure TeeCreateArabic;
begin
  if not Assigned(TeeArabicLanguage) then
  begin
    TeeArabicLanguage:=TStringList.Create;
    TeeArabicLanguage.Text:=

'LABELS=��������'+#13+
'DATASET=����� ��������'+#13+
'ALL RIGHTS RESERVED.=���� ������ ������.'+#13+
'APPLY=���'+#13+
'CLOSE=�����'+#13+
'OK=�����'+#13+
'ABOUT TEECHART PRO V7.0=��� TeeChart Pro v7.0'+#13+
'OPTIONS=��������'+#13+
'FORMAT=�����'+#13+
'TEXT=���'+#13+
'GRADIENT=���� �������'+#13+
'SHADOW=��'+#13+
'POSITION=����'+#13+
'LEFT=����'+#13+
'TOP=����'+#13+
'CUSTOM=�����'+#13+
'PEN=�����'+#13+
'PATTERN=���'+#13+
'SIZE=���'+#13+
'BEVEL=Marco'+#13+
'INVERTED=�����'+#13+
'BORDER=����'+#13+
'ORIGIN=�����'+#13+
'USE ORIGIN=������� �����'+#13+
'AREA LINES=�� �����'+#13+
'AREA=�����'+#13+
'COLOR=�����'+#13+
'SERIES=�����'+#13+
'SUM=�����'+#13+
'DAY=�����'+#13+
'QUARTER=��� ���'+#13+
'(MAX)=(������)'+#13+
'(MIN)=(������)'+#13+
'VISIBLE=����'+#13+
'CURSOR=Cursor'+#13+
'GLOBAL=���'+#13+
'X=X'+#13+
'Y=Y'+#13+
'Z=Z'+#13+
'3D=3D'+#13+
'HORIZ. LINE=�� ����'+#13+
'LABEL AND PERCENT=����� y ������'+#13+
'LABEL AND VALUE=����� y ������'+#13+
'LABEL AND PERCENT TOTAL=����� y ������ ���������'+#13+
'PERCENT TOTAL=������ ������'+#13+
'MSEC.=����'+#13+
'SUBTRACT=���'+#13+
'MULTIPLY=���'+#13+
'DIVIDE=����'+#13+
'STAIRS=����'+#13+
'MOMENTUM=���� ������'+#13+
'AVERAGE=�������'+#13+
'XML=XML'+#13+
'HTML TABLE=���� HTML'+#13+
'EXCEL=Excel'+#13+
'NONE=����'+#13+
'(NONE)= ����'#13+
'WIDTH=�����'+#13+
'HEIGHT=�����'+#13+
'COLOR EACH=����� ���'+#13+
'STACK=�����'+#13+
'STACKED=�����'+#13+
'STACKED 100%=����� 100%'+#13+
'AXIS=����'+#13+
'LENGTH=�����'+#13+
'CANCEL=�����'+#13+
'SCROLL=�����'+#13+
'INCREMENT=�����'+#13+
'VALUE=������'+#13+
'STYLE=���'+#13+
'JOIN=����'+#13+
'AXIS INCREMENT=������ ����'+#13+
'AXIS MAXIMUM AND MINIMUM=���� ������ � ������ ������'+#13+
'% BAR WIDTH=��� ����� %'+#13+
'% BAR OFFSET=���� ����� %'+#13+
'BAR SIDE MARGINS=����� ������'+#13+
'AUTO MARK POSITION=��� ������ ��������.'+#13+
'DARK BAR 3D SIDES=����� ���� 3D'+#13+
'MONOCHROME=����� �����'+#13+
'COLORS=�������'+#13+
'DEFAULT=�������'+#13+
'MEDIAN=������'+#13+
'IMAGE=������'+#13+
'DAYS=������'+#13+
'WEEKDAYS=���� �������'+#13+
'TODAY=�����'+#13+
'SUNDAY=�����'+#13+
'MONTHS=������'+#13+
'LINES=������'+#13+
'UPPERCASE=���� �����'+#13+
'STICK=Candle'+#13+
'CANDLE WIDTH=��� ������'+#13+
'BAR=�����'+#13+
'OPEN CLOSE=���\�����'+#13+
'DRAW 3D=��� 3D'+#13+
'DARK 3D=���� 3D'+#13+
'SHOW OPEN=��� �����'+#13+
'SHOW CLOSE=��� ����'+#13+
'UP CLOSE=���� ����'+#13+
'DOWN CLOSE=���� ����'+#13+
'CIRCLED=�����'+#13+
'CIRCLE=�����'+#13+
'3 DIMENSIONS=3 Dimensiones'+#13+
'ROTATION=����'+#13+
'RADIUS=���'+#13+
'HOURS=�����'+#13+
'HOUR=����'+#13+
'MINUTES=�����'+#13+
'SECONDS=�����'+#13+
'FONT=���'+#13+
'INSIDE=�����'+#13+
'ROTATED=�����'+#13+
'ROMAN=������'+#13+
'TRANSPARENCY=����'+#13+
'DRAW BEHIND=��� �� �����'+#13+
'RANGE=���'+#13+
'PALETTE=���'+#13+
'STEPS=�����'+#13+
'GRID=����'+#13+
'GRID SIZE=��� ������'+#13+
'ALLOW DRAG=����� ������'+#13+
'AUTOMATIC=������'+#13+
'LEVEL=�������'+#13+
'LEVELS POSITION=���� �������'+#13+
'SNAP=Ajustar'+#13+
'FOLLOW MOUSE=������� ������'+#13+
'TRANSPARENT=����'+#13+
'ROUND FRAME=����� �������'+#13+
'FRAME=����'+#13+
'START=����'+#13+
'END=�����'+#13+
'MIDDLE=���'+#13+
'NO MIDDLE=���� ���'+#13+
'DIRECTION=�������'+#13+
'DATASOURCE=���� ��������'+#13+
'AVAILABLE=����'+#13+
'SELECTED=�����'+#13+
'CALC=�����'+#13+
'GROUP BY=����� �� ����'+#13+
'OF=��'+#13+
'HOLE %=������ %'+#13+
'RESET POSITIONS=������ ������ ������'+#13+
'MOUSE BUTTON=������'+#13+
'ENABLE DRAWING=������ ������'+#13+
'ENABLE SELECT=������ ��������'+#13+
'ORTHOGONAL=Ortogonal'+#13+
'ANGLE=�����'+#13+
'ZOOM TEXT=����� ����'+#13+
'PERSPECTIVE=Perspectiva'+#13+
'ZOOM=�����'+#13+
'ELEVATION=Elevaci�n'+#13+
'BEHIND=���'+#13+
'AXES=����'+#13+
'SCALES=�����'+#13+
'TITLE=�����'+#13+
'TICKS=Marcas'+#13+
'MINOR=Menores'+#13+
'CENTERED=�����'+#13+
'CENTER=�����'+#13+
'PATTERN COLOR EDITOR=���� ������'+#13+
'START VALUE=���� ������'+#13+
'END VALUE=���� �������'+#13+
'COLOR MODE=Modo de ���'+#13+
'LINE MODE=Modo de ��'+#13+
'HEIGHT 3D=�������� 3D'+#13+
'OUTLINE=������ �������'+#13+
'PRINT PREVIEW=������ �������'+#13+
'ANIMATED=�����'+#13+
'ALLOW=�����'+#13+
'DASH=�����'+#13+
'DOT=����'+#13+
'DASH DOT DOT=����� ����'+#13+
'PALE=����'+#13+
'STRONG=���'+#13+
'WIDTH UNITS=����� �����'+#13+
'FOOT=�����'+#13+
'SUBFOOT=��� ����'+#13+
'SUBTITLE=����� ����'+#13+
'leghend=����� �����'+#13+
'COLON=������ '+#13+
'AXIS ORIGIN=����� ����'+#13+
'UNITS=�����'+#13+
'PYRAMID=����'+#13+
'DIAMOND=Diamante'+#13+
'CUBE=����'+#13+
'TRIANGLE=����'+#13+
'STAR=����'+#13+
'SQUARE=����'+#13+
'DOWN TRIANGLE=���� �����'+#13+
'SMALL DOT=���� �����'+#13+
'LOAD=�����'+#13+
'FILE=���'+#13+
'RECTANGLE=������'+#13+
'HEADER=���'+#13+
'CLEAR=����'+#13+
'ONE HOUR=����� ����'+#13+
'ONE YEAR=���� ���'+#13+
'ELLIPSE=Elipse'+#13+
'CONE=������'+#13+
'ARROW=���'+#13+
'CYLLINDER=�������'+#13+
'TIME=���'+#13+
'BRUSH=�������'+#13+
'LINE=��'+#13+
'VERTICAL LINE=�� ����'+#13+
'AXIS ARROWS=���� ������'+#13+
'MARK TIPS=Sugerencias'+#13+
'DASH DOT=�� �����'+#13+
'COLOR BAND=������  ���'+#13+
'COLOR LINE=���� ���'+#13+
'INVERT. TRIANGLE=���� �����'+#13+
'INVERT. PYRAMID=��� �����'+#13+
'INVERTED PYRAMID=��� �����'+#13+
'SERIES DATASOURCE TEXT EDITOR= ���� ���� �������'+#13+
'SOLID=S�lido'+#13+
'WIREFRAME=Alambres'+#13+
'DOTFRAME=���� ����'+#13+
'SIDE BRUSH=������� ��������'+#13+
'SIDE=������'+#13+
'SIDE ALL=���� ������'+#13+
'ANNOTATION=�����'+#13+
'ROTATE=���'+#13+
'SMOOTH PALETTE=���� �������'+#13+
'CHART TOOLS GALLERY=Galer�a de Herramientas'+#13+
'ADD=���'+#13+
'BORDER EDITOR=���� ������'+#13+
'DRAWING MODE=Modo de Dibujo'+#13+
'CLOSE CIRCLE=����� �����'+#13+
'PICTURE=����'+#13+
'NATIVE=Nativo'+#13+
'DATA=������'+#13+
'KEEP ASPECT RATIO=�������� ��� ��� �����'+#13+
'COPY=���'+#13+
'SAVE=���'+#13+
'SEND=�����'+#13+
'INCLUDE SERIES DATA= ����� ������'+#13+
'FILE SIZE=��� �����o'+#13+
'INCLUDE=�����'+#13+
'POINT INDEX=��� ������'+#13+
'POINT LABELS=����� ������'+#13+
'DELIMITER=����'+#13+
'DEPTH=���'+#13+
'COMPRESSION LEVEL=����� �����'+#13+
'COMPRESSION=���'+#13+
'PATTERNS=����'+#13+
'LABEL=�����'+#13+
'GROUP SLICES=Agrupar porciones'+#13+
'EXPLODE BIGGEST=����� ������'+#13+
'TOTAL ANGLE=������� ������'+#13+
'HORIZ. SIZE=����� ������'+#13+
'VERT. SIZE=����� ������'+#13+
'SHAPES=�����'+#13+
'INFLATE MARGINS=����� �����'+#13+
'QUALITY=������'+#13+
'SPEED=������'+#13+
'% QUALITY=% ������'+#13+
'GRAY SCALE=��� ��� �������'+#13+
'PERFORMANCE=����'+#13+
'BROWSE=�������'+#13+
'TILED=�����'+#13+
'HIGH=�����'+#13+
'LOW=�����'+#13+
'DATABASE CHART=����� ������ ����� ������� '+#13+
'NON DATABASE CHART=����� ������� ���� ����� ������'+#13+
'HELP=������'+#13+
'NEXT >=������ >'+#13+
'< BACK=< ������'+#13+
'TEECHART WIZARD=����� TeeChart'+#13+
'PERCENT=����'+#13+
'PIXELS=Pixels'+#13+
'ERROR WIDTH=��� ���'+#13+
'ENHANCED=����'+#13+
'VISIBLE WALLS=����� �����'+#13+
'ACTIVE=���'+#13+
'DELETE=���'+#13+
'ALIGNMENT=������'+#13+
'ADJUST FRAME=������ ������'+#13+
'HORIZONTAL=����'+#13+
'VERTICAL=����'+#13+
'VERTICAL POSITION=���� ����'+#13+
'NUMBER=���'+#13+
'LEVELS=�������'+#13+
'OVERLAP=������'+#13+
'STACK 100%=����� 100%'+#13+
'MOVE=���'+#13+
'CLICK=����'+#13+
'DELAY=����'+#13+
'DRAW LINE= �� ��� '+#13+
'FUNCTIONS=����'+#13+
'SOURCE SERIES=���� �������'+#13+
'ABOVE=����'+#13+
'BELOW=����'+#13+
'Dif. Limit=L�mite Dif.'+#13+
'WITHIN=����'+#13+
'EXTENDED=����'+#13+
'STANDARD=�����'+#13+
'STATS=Estad�stica'+#13+
'FINANCIAL=����'+#13+
'OTHER=���'+#13+
'TEECHART GALLERY=Galer�a de Gr�ficos TeeChart'+#13+
'CONNECTING LINES=����� ������'+#13+
'REDUCTION=���'+#13+
'LIGHT=Luz'+#13+
'INTENSITY=�������'+#13+
'FONT OUTLINES=���� �����'+#13+
'SMOOTH SHADING=����� ������'+#13+
'AMBIENT LIGHT=Luz de Ambiente'+#13+
'MOUSE ACTION=���� ������'+#13+
'CLOCKWISE=����� ����� ������'+#13+
'ANGLE INCREMENT=������� �� �������'+#13+
'RADIUS INCREMENT=������� �� �����'+#13+
'PRINTER=�������'+#13+
'SETUP=�����'+#13+
'ORIENTATION=�������'+#13+
'PORTRAIT=����'+#13+
'LANDSCAPE=����'+#13+
'MARGINS (%)=����� (%)'+#13+
'MARGINS=�����'+#13+
'DETAIL=������'+#13+
'MORE=����'+#13+
'PROPORTIONAL=����'+#13+
'VIEW MARGINS=��� �����'+#13+
'RESET MARGINS=����� �������'+#13+
'PRINT=����'+#13+
'TEEPREVIEW EDITOR=���� ���� ������'+#13+
'ALLOW MOVE=������ �������'+#13+
'ALLOW RESIZE=������ ������ �����'+#13+
'SHOW IMAGE=����� ������'+#13+
'DRAG IMAGE=���� ������'+#13+
'AS BITMAP=����� � BITMAP'+#13+
'SIZE %=��� %'+#13+
'FIELDS=����'+#13+
'SOURCE=����'+#13+
'SEPARATOR=����'+#13+
'NUMBER OF HEADER LINES=��� ���� �����'+#13+
'COMMA=�����'+#13+
'EDITING=�����'+#13+
'TAB=Tab'+#13+
'SPACE=����'+#13+
'ROUND RECTANGLE=������ ���� �������'+#13+
'BOTTOM=����'+#13+
'RIGHT=����'+#13+
'C PEN=����� C'+#13+
'R PEN=����� R'+#13+
'C LABELS=����� C'+#13+
'R LABELS=����� R'+#13+
'MULTIPLE BAR=����� ������'+#13+
'MULTIPLE AREAS=������ ������'+#13+
'STACK GROUP=������ ������'+#13+
'BOTH=������'+#13+
'BACK DIAGONAL=���� �����'+#13+
'B.DIAGONAL=���� �����'+#13+
'DIAG.CROSS=Cruz en Diagonal'+#13+
'WHISKER=Whisker'+#13+
'CROSS=Cruz'+#13+
'DIAGONAL CROSS=Cruz en Diagonal'+#13+
'LEFT RIGHT=���� ����'+#13+
'RIGHT LEFT=���� ����'+#13+
'FROM CENTER=�� �����'+#13+
'FROM TOP LEFT=�� ���� ������'+#13+
'FROM BOTTOM LEFT=�� ���� ������'+#13+
'SHOW WEEKDAYS=����� ���� �������'+#13+
'SHOW MONTHS=����� ������'+#13+
'TRAILING DAYS=���� �������'+#13+
'SHOW TODAY=����� �����'+#13+
'TRAILING=�����'+#13+
'LOWERED=�����'+#13+
'RAISED=����'+#13+
'HORIZ. OFFSET=Desplaz. ����'+#13+
'VERT. OFFSET=Desplaz. Vert.'+#13+
'INNER=�����'+#13+
'LEN=���'+#13+
'AT LABELS ONLY=��� �������� ���'+#13+
'MAXIMUM=��� ������'+#13+
'MINIMUM=���� ������'+#13+
'CHANGE=����'+#13+
'LOGARITHMIC=���������'+#13+
'LOG BASE=���� ����������'+#13+
'DESIRED INCREMENT=����� �������'+#13+
'(INCREMENT)=(������)'+#13+
'MULTI-LINE=����� ������'+#13+
'MULTI LINE=����� ������'+#13+
'RESIZE CHART=����� ���. ����� �������'+#13+
'X AND PERCENT=X y ������'+#13+
'X AND VALUE=X y ������'+#13+
'RIGHT PERCENT=������ ����'+#13+
'LEFT PERCENT=������ ����'+#13+
'LEFT VALUE=������ ����'+#13+
'RIGHT VALUE=������ ����'+#13+
'PLAIN=���'+#13+
'LAST VALUES=��� ����'+#13+
'SERIES VALUES=��� �����'+#13+
'SERIES NAMES=��� �������'+#13+
'NEW=����'+#13+
'EDIT=�����'+#13+
'PANEL COLOR=��� �����'+#13+
'TOP BOTTOM=���� ����'+#13+
'BOTTOM TOP=���� ����'+#13+
'DEFAULT ALIGNMENT=������ ��������'+#13+
'EXPONENTIAL=e ��������'+#13+
'LABELS FORMAT=����� �������'+#13+
'MIN. SEPARATION %=���� ���� %'+#13+
'YEAR=���'+#13+
'MONTH=���'+#13+
'WEEK=�����'+#13+
'WEEKDAY=��� �������'+#13+
'MARK=�����'+#13+
'ROUND FIRST=����� �����'+#13+
'LABEL ON AXIS=����� ��� ����'+#13+
'COUNT=���'+#13+
'POSITION %=���� %'+#13+
'START %=����� %'+#13+
'END %=����� %'+#13+
'OTHER SIDE=������ �����'+#13+
'INTER-CHAR SPACING=�������� ��� ����� �������'+#13+
'VERT. SPACING= �������� �������'+#13+
'POSITION OFFSET %=��� %'+#13+
'GENERAL=���'+#13+
'MANUAL=����'+#13+
'PERSISTENT=Persistente'+#13+
'PANEL=����'+#13+
'ALIAS=Alias'+#13+
'2D=2D'+#13+
'ADX=ADX'+#13+
'BOLLINGER=Bollinger'+#13+
'TEEOPENGL EDITOR=���� OpenGL'+#13+
'FONT 3D DEPTH=���  ��� &3D'+#13+
'NORMAL=�����'+#13+
'TEEFONT EDITOR=���� �� ���'+#13+
'CLIP POINTS=Ocultar'+#13+
'CLIPPED=Oculta'+#13+
'3D %=3D %'+#13+
'QUANTIZE=Cuantifica'+#13+
'QUANTIZE 256=Cuantifica 256'+#13+
'DITHER=���'+#13+
'VERTICAL SMALL=���� ����'+#13+
'HORIZ. SMALL=���� ����'+#13+
'DIAG. SMALL=���� ����'+#13+
'BACK DIAG. SMALL=���� ���� �����'+#13+
'DIAG. CROSS SMALL=Cruz Diagonal Peq.'+#13+
'MINIMUM PIXELS=M�nimos pixels'+#13+
'ALLOW SCROLL=������  ����� �������'+#13+
'SWAP=�����'+#13+
'GRADIENT EDITOR=���� ������� ��������'+#13+
'TEXT STYLE=��� ����'+#13+
'DIVIDING LINES=���� �����'+#13+
'SYMBOLS=������'+#13+
'CHECK BOXES=���� ������'+#13+
'FONT SERIES COLOR=��� ��� �������'+#13+
'legend STYLE=����� ����� �����'+#13+
'POINTS PER PAGE=��� ������ ������'+#13+
'SCALE LAST PAGE=���� ��� ����'+#13+
'CURRENT PAGE Legend=����� ����� ������ �������'+#13+
'BACKGROUND=�������'+#13+
'BACK IMAGE=���� �������'+#13+
'STRETCH=���'+#13+
'TILE=�����'+#13+
'BORDERS=������'+#13+
'CALCULATE EVERY=���� ��'+#13+
'NUMBER OF POINTS=��� ������'+#13+
'RANGE OF VALUES=��� �� ���'+#13+
'FIRST=�����'+#13+
'LAST=������'+#13+
'ALL POINTS=�� ������'+#13+
'DATA SOURCE=���� ��������'+#13+
'WALLS=�����'+#13+
'PAGING=����� �������'+#13+
'CLONE=���'+#13+
'TITLES=�����'+#13+
'TOOLS=�����'+#13+
'EXPORT=�����'+#13+
'CHART=����� �������'+#13+
'BACK=�����'+#13+
'LEFT AND RIGHT=���� � ����'+#13+
'SELECT A CHART STYLE=����� ���  ����� �������'+#13+
'SELECT A DATABASE TABLE=�������� ���� '+#13+
'TABLE=����'+#13+
'SELECT THE DESIRED FIELDS TO CHART=����� ���� �����'+#13+
'SELECT A TEXT LABELS FIELD=����� ������ ������'+#13+
'CHOOSE THE DESIRED CHART TYPE=����� ��� ����� �������'+#13+
'CHART PREVIEW=����� �����'+#13+
'SHOW legend=����� ����� �����'+#13+
'SHOW MARKS=����� ��������'+#13+
'FINISH=�����'+#13+
'RANDOM=������'+#13+
'DRAW EVERY=��� ���'+#13+
'ARROWS=����'+#13+
'ASCENDING=������'+#13+
'DESCENDING=������'+#13+
'VERTICAL AXIS=���� ����'+#13+
'DATETIME=���\���'+#13+
'TOP AND BOTTOM=���� � ����'+#13+
'HORIZONTAL AXIS=���� ����'+#13

{$IFDEF LCL}
;  TeeArabicLanguage.Text:=TeeArabicLanguage.Text
{$ENDIF}

+
'PERCENTS=����'+#13+
'VALUES=�����'+#13+
'FORMATS=�����'+#13+
'SHOW IN Legend=����� �� ����� �����'+#13+
'SORT=���'+#13+
'MARKS=������'+#13+
'BEVEL INNER=Marco interior'+#13+
'BEVEL OUTER=Marco exterior'+#13+
'PANEL EDITOR=���� �����'+#13+
'CONTINUOUS=����'+#13+
'HORIZ. ALIGNMENT=������ �����'+#13+
'EXPORT CHART=���� ����� �������'+#13+
'BELOW %=���� �� a %'+#13+
'BELOW VALUE=���� �� ����'+#13+
'NEAREST POINT=���� ����'+#13+
'DRAG MARKS=���� ��������'+#13+
'TEECHART PRINT PREVIEW=������ ����� �����'+#13+
'X VALUE=������ X'+#13+
'X AND Y VALUES=������ X �Y'+#13+
'SHININESS=�������'+#13+
'ALL SERIES VISIBLE=�� ������� ����'+#13+
'MARGIN=�����'+#13+
'DIAGONAL=�����'+#13+
'LEFT TOP=���� ����'+#13+
'LEFT BOTTOM=���� ����'+#13+
'RIGHT TOP=���� ����'+#13+
'RIGHT BOTTOM=���� ����'+#13+
'EXACT DATE TIME=������� ������'+#13+
'RECT. GRADIENT=���� �������'+#13+
'CROSS SMALL=Cruz peque�a'+#13+
'AVG=�����'+#13+
'FUNCTION=����'+#13+
'AUTO=��������'+#13+
'ONE MILLISECOND=����� �������'+#13+
'ONE SECOND=����� �����'+#13+
'FIVE SECONDS=��� �����'+#13+
'TEN SECONDS=��� �����'+#13+
'FIFTEEN SECONDS=���� ��� �����'+#13+
'THIRTY SECONDS=������ �����'+#13+
'ONE MINUTE=����� �����'+#13+
'FIVE MINUTES=���� �����'+#13+
'TEN MINUTES=���� �����'+#13+
'FIFTEEN MINUTES=���� ��� �����'+#13+
'THIRTY MINUTES=������ �����'+#13+
'TWO HOURS=������'+#13+
'TWO HOURS=������'+#13+
'SIX HOURS=��� �����'+#13+
'TWELVE HOURS=���� ��� �����'+#13+
'ONE DAY=���� ���'+#13+
'TWO DAYS=����� ����'+#13+
'THREE DAYS=����� ����'+#13+
'ONE WEEK=���� �����'+#13+
'HALF MONTH=��� ���'+#13+
'ONE MONTH=���� ���'+#13+
'TWO MONTHS=����� ����'+#13+
'THREE MONTHS=����� ����'+#13+
'FOUR MONTHS=����� ����'+#13+
'SIX MONTHS=��� ����'+#13+
'IRREGULAR=��� �����'+#13+
'CLICKABLE=���� �����'+#13+
'ROUND=����'+#13+
'FLAT=����'+#13+
'PIE=�����'+#13+
'HORIZ. BAR=����� ����'+#13+
'BUBBLE=�����'+#13+
'SHAPE=���'+#13+
'POINT=����'+#13+
'FAST LINE=�� ����'+#13+
'CANDLE=����'+#13+
'VOLUME=���'+#13+
'HORIZ LINE=�� ����'+#13+
'SURFACE=���'+#13+
'LEFT AXIS=���� ����'+#13+
'RIGHT AXIS=���� ����'+#13+
'TOP AXIS=���� ����'+#13+
'BOTTOM AXIS=���� ����'+#13+
'CHANGE SERIES TITLE=����� ����� �����'+#13+
'NEW SERIES TITLE:= ����� ����:'+#13+
'DELETE %S ?=��� %s ?'+#13+
'DESIRED %S INCREMENT=������� %s ��������'+#13+
'INCORRECT VALUE. REASON: %S=���� ��� ����� ����: %s'+#13+
'FillSampleValues NumValues must be > 0=����� ������� ��� �� ����> 0.'#13+
'VISIT OUR WEB SITE !=�� ������ ������  !'#13+
'SHOW PAGE NUMBER=����� ��� ������'#13+
'PAGE NUMBER=��� ������a'#13+
'PAGE %D OF %D=���� %d �� %d'#13+
'TEECHART LANGUAGE SELECTOR=����� ��� TeeChart'#13+
'CHOOSE A LANGUAGE=����� ���'+#13+
'SELECT ALL=����� ����'#13+
'MOVE UP=���� ��� ����'#13+
'MOVE DOWN=���� ������'#13
;
  end;
end;

Procedure TeeSetArabic;
begin
  TeeCreateArabic;
  TeeLanguage:=TeeArabicLanguage;
  TeeArabicConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;

initialization
finalization
  FreeAndNil(TeeArabicLanguage);
end.
