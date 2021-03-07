////////////////////////////////////////////////////////
// TeeChart Pro Farsi Translation by Mehdi Keramati . //
// Email: delphi@novinmedia.com                       //
// Finished on : 1382/1/24 - 2:22 AM                  //
////////////////////////////////////////////////////////

unit TeeFarsi;
{$I TeeDefs.inc}

interface

uses Classes;

var TeeFarsiLanguage: TStringList = nil;

procedure TeeSetFarsi;
procedure TeeCreateFarsi;

implementation

uses SysUtils, TeeConst, TeeProCo{$IFNDEF D5}, TeCanvas{$ENDIF};

procedure TeeFarsiConstants;
begin
  { TeeConst }
  TeeMsg_Copyright := '� 1995-2009 by David Berneda';

  TeeMsg_Test := '���...';
  TeeMsg_LegendFirstValue := '����� ����� ���� ���� ��ѐ�� �� 0 ����';
  TeeMsg_LegendColorWidth := '�� ���� ���� ��ѐ�� �� 0% ����';
  TeeMsg_SeriesSetDataSource := '��� ���� ����� ���� ������� DataSource ����� ���� ���';
  TeeMsg_SeriesInvDataSource := '%s �� DataSource ����� ����';
  TeeMsg_FillSample := '���� ��ѐ�� �� ��� ���� NumValues FillSampleValues';
  TeeMsg_AxisLogDateTime := '���� DateTime �������� ������� ����';
  TeeMsg_AxisLogNotPositive := '������ ������� � �������� ���� ������� ���� ��ѐ�� �� ��� ����';
  TeeMsg_AxisLabelSep := '������� ���� �� ���� ��ѐ�� �� ��� ����';
  TeeMsg_AxisIncrementNeg := '������ ���� ���� ��ѐ�� �� ��� ����';
  TeeMsg_AxisMinMax := '����� ������� ���� ���� ����� �� ����� ����� ������� ����';
  TeeMsg_AxisMaxMin := '����� ������� ���� ���� ��ѐ�� �� ����� ����� ������� ����';
  TeeMsg_AxisLogBase := '���� ���� ������� ���� ��ѐ�� �� 2 ����';
  TeeMsg_MaxPointsPerPage := 'MaxPointsPerPage ���� ��ѐ�� �� ��� ����';
  TeeMsg_3dPercent := '���� 3D Effects ���� ��� %d � %d ����';
  TeeMsg_CircularSeries := '������ ��� ������ ���� ���� ����';
  TeeMsg_WarningHiColor := '16k Color �� ����� ���� ����� �� ����� ����� ���� ���� ���';

  TeeMsg_DefaultPercentOf := '%s �� %s';
  TeeMsg_DefaultPercentOf2 := '%s' + #13 + '�� %s';
  TeeMsg_DefPercentFormat := '##0.## %';
  TeeMsg_DefValueFormat := '#,##0.###';
  TeeMsg_DefLogValueFormat := '#.0 "x10" E+0';
  TeeMsg_AxisTitle := '����� ����';
  TeeMsg_AxisLabels := '������� ����';
  TeeMsg_RefreshInterval := 'Refresh Interval ���� ��� 0 � 60 ����';
  TeeMsg_SeriesParentNoSelf := 'Series.ParentChart �������� ����� ��� ����';
  TeeMsg_GalleryLine := '��';
  TeeMsg_GalleryPoint := '����';
  TeeMsg_GalleryArea := '�����';
  TeeMsg_GalleryBar := '����';
  TeeMsg_GalleryHorizBar := '���� ����';
  TeeMsg_Stack := '����';
  TeeMsg_GalleryPie := 'Pie';
  TeeMsg_GalleryCircled := '����';
  TeeMsg_GalleryFastLine := 'Fast Line';
  TeeMsg_GalleryHorizLine := '�� ����';

  TeeMsg_PieSample1 := '�������';
  TeeMsg_PieSample2 := '������';
  TeeMsg_PieSample3 := '������';
  TeeMsg_PieSample4 := '���������';
  TeeMsg_PieSample5 := '�����';
  TeeMsg_PieSample6 := '���� ������';
  TeeMsg_PieSample7 := '����� �������';
  TeeMsg_PieSample8 := '�������';

  TeeMsg_GalleryLogoFont := 'Courier New';
  TeeMsg_Editing := '������ %s';

  TeeMsg_GalleryStandard := '���������';
  TeeMsg_GalleryExtended := '����� �����';
  TeeMsg_GalleryFunctions := '�����';

  TeeMsg_EditChart := '������ ����...';
  TeeMsg_PrintPreview := '��� ����� �ǁ...';
  TeeMsg_ExportChart := 'Export ���� ����...';
  TeeMsg_CustomAxes := '������� ������';

  TeeMsg_InvalidEditorClass := '%s: �� ���� ����� Editor ����: %s';
  TeeMsg_MissingEditorClass := '%s: ����� Editor �����';

  TeeMsg_GalleryArrow := '�����';

  TeeMsg_ExpFinish := '�����';
  TeeMsg_ExpNext := '���� >';

  TeeMsg_GalleryGantt := 'Gantt';

  TeeMsg_GanttSample1 := '�����';
  TeeMsg_GanttSample2 := '��� ���� ����';
  TeeMsg_GanttSample3 := '�����';
  TeeMsg_GanttSample4 := '������';
  TeeMsg_GanttSample5 := '����';
  TeeMsg_GanttSample6 := '��� ����';
  TeeMsg_GanttSample7 := '�����';
  TeeMsg_GanttSample8 := '��� ����';
  TeeMsg_GanttSample9 := '���� ����';
  TeeMsg_GanttSample10 := '������ �����';

  TeeMsg_ChangeSeriesTitle := '����� ���� �����';
  TeeMsg_NewSeriesTitle := '����� ������ ����:';
  TeeMsg_DateTime := '����� � ����';
  TeeMsg_TopAxis := '���� ����';
  TeeMsg_BottomAxis := '���� �����';
  TeeMsg_LeftAxis := '���� ��';
  TeeMsg_RightAxis := '���� ����';

  TeeMsg_SureToDelete := '%s ��� ��Ͽ';
  TeeMsg_DateTimeFormat := '���� ����� � ����';
  TeeMsg_Default := '��ԝ ���';
  TeeMsg_ValuesFormat := '���� ������:';
  TeeMsg_Maximum := '�������';
  TeeMsg_Minimum := '�������';
  TeeMsg_DesiredIncrement := '������ %s �������';

  TeeMsg_IncorrectMaxMinValue := '����� ������. ����: %s';
  TeeMsg_EnterDateTime := '���� ���� [����� �����] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply := '������� ����� ��Ͽ';
  TeeMsg_SelectedSeries := '(������ ������ ���)';
  TeeMsg_RefreshData := '��������� ������';

  TeeMsg_DefaultFontSize := {$IFDEF LINUX} '10'{$ELSE} '8'{$ENDIF};
  TeeMsg_DefaultEditorSize := '414';
  TeeMsg_FunctionAdd := '������';
  TeeMsg_FunctionSubtract := '�� ����';
  TeeMsg_FunctionMultiply := '���';
  TeeMsg_FunctionDivide := '�����';
  TeeMsg_FunctionHigh := '��ѐ��';
  TeeMsg_FunctionLow := '�����';
  TeeMsg_FunctionAverage := '������';

  TeeMsg_GalleryShape := '���';
  TeeMsg_GalleryBubble := '����';
  TeeMsg_FunctionNone := '߁�';

  TeeMsg_None := '(������)';

  TeeMsg_PrivateDeclarations := '{ Private declarations }';
  TeeMsg_PublicDeclarations := '{ Public declarations }';
  TeeMsg_DefaultFontName := TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize := 'Pointer size ���� ��ѐ�� �� ��� ����';
  TeeMsg_About := '������ TeeChart...';

  tcAdditional := '�����';
  tcDControls := 'Data Controls';
  tcQReport := 'QReport';

  TeeMsg_DataSet := 'Dataset';
  TeeMsg_AskDataSet := '&Dataset:';

  TeeMsg_SingleRecord := 'Single Record';
  TeeMsg_AskDataSource := '&DataSource:';

  TeeMsg_Summary := '�����';

  TeeMsg_FunctionPeriod := 'Function Period ���� ��ѐ�� �� ��� ����';

  TeeMsg_WizardTab := '�����';
  TeeMsg_TeeChartWizard := 'TeeChart Wizard';

  TeeMsg_ClearImage := '��� ����';
  TeeMsg_BrowseImage := '�����...';

  TeeMsg_WizardSureToClose := '��� ������� �� �������� TeeChart Wizard �� �����Ͽ';
  TeeMsg_FieldNotFound := '���� %s ���� �����';

  TeeMsg_DepthAxis := '���� ���';
  TeeMsg_PieOther := '����';
  TeeMsg_ShapeGallery1 := 'abc';
  TeeMsg_ShapeGallery2 := '123';
  TeeMsg_ValuesX := 'X';
  TeeMsg_ValuesY := 'Y';
  TeeMsg_ValuesPie := 'Pie';
  TeeMsg_ValuesBar := '����';
  TeeMsg_ValuesAngle := '�����';
  TeeMsg_ValuesGanttStart := '����';
  TeeMsg_ValuesGanttEnd := '�����';
  TeeMsg_ValuesGanttNextTask := '��� ����';
  TeeMsg_ValuesBubbleRadius := '����';
  TeeMsg_ValuesArrowEndX := 'EndX';
  TeeMsg_ValuesArrowEndY := 'EndY';
  TeeMsg_Legend := '����� �����';
  TeeMsg_Title := '�����';
  TeeMsg_Foot := '������';
  TeeMsg_Period := '����';
  TeeMsg_PeriodRange := '������ ����';
  TeeMsg_CalcPeriod := '������ %s ��:';
  TeeMsg_SmallDotsPen := '������� ���';

  TeeMsg_InvalidTeeFile := '���� ����� �� ���� *.'+TeeMsg_TeeExtension+' ����� ����';
  TeeMsg_WrongTeeFileFormat := '���� ���� *.'+TeeMsg_TeeExtension+' ���� ����';
  TeeMsg_EmptyTeeFile := '���� *.'+TeeMsg_TeeExtension+' ���� ���'; { 5.01 }

{$IFDEF D5}
  TeeMsg_ChartAxesCategoryName := '������� ����';
  TeeMsg_ChartAxesCategoryDesc := 'property �� � event ��� ������� ����';
  TeeMsg_ChartWallsCategoryName := '��������� ����';
  TeeMsg_ChartWallsCategoryDesc := 'property �� � event ��� ��������� ����';
  TeeMsg_ChartTitlesCategoryName := '������� ����';
  TeeMsg_ChartTitlesCategoryDesc := 'property �� � event ��� ������� ����';
  TeeMsg_Chart3DCategoryName := '���� 3 ����';
  TeeMsg_Chart3DCategoryDesc := 'property �� � event ��� ���� 3 ����';
{$ENDIF}

  TeeMsg_CustomAxesEditor := '������ ';
  TeeMsg_Series := '�����';
  TeeMsg_SeriesList := '�����...';

  TeeMsg_PageOfPages := '���� %d �� %d';
  TeeMsg_FileSize := '%d ����';

  TeeMsg_First := '�����';
  TeeMsg_Prior := '����';
  TeeMsg_Next := '����';
  TeeMsg_Last := '�����';
  TeeMsg_Insert := '���';
  TeeMsg_Delete := '���';
  TeeMsg_Edit := '������';
  TeeMsg_Post := '���';
  TeeMsg_Cancel := '���';

  TeeMsg_All := '(���)';
  TeeMsg_Index := '������';
  TeeMsg_Text := '���';

  TeeMsg_AsBMP := 'as &Bitmap';
  TeeMsg_BMPFilter := 'Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF := 'as &Metafile';
  TeeMsg_EMFFilter := 'Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'Panel property is not set in Export format';

  TeeMsg_Normal := '������';
  TeeMsg_NoBorder := '���� �����';
  TeeMsg_Dotted := '���� ����';
  TeeMsg_Colors := '���';
  TeeMsg_Filled := '�����';
  TeeMsg_Marks := '�����';
  TeeMsg_Stairs := '�����';
  TeeMsg_Points := '������';
  TeeMsg_Height := '������';
  TeeMsg_Hollow := '�������';
  TeeMsg_Point2D := '���� 2 ����';
  TeeMsg_Triangle := '����';
  TeeMsg_Star := '�����';
  TeeMsg_Circle := '�����';
  TeeMsg_DownTri := '���� �� �� �����';
  TeeMsg_Cross := '����';
  TeeMsg_Diamond := '�����';
  TeeMsg_NoLines := '���� ��';
  TeeMsg_Stack100 := '���� 100%';
  TeeMsg_Pyramid := '���';
  TeeMsg_Ellipse := '����';
  TeeMsg_InvPyramid := '��� �����';
  TeeMsg_Sides := '�����';
  TeeMsg_SideAll := '���� �����';
  TeeMsg_Patterns := '���';
  TeeMsg_Exploded := '������';
  TeeMsg_Shadow := '����';
  TeeMsg_SemiPie := '���� Pie';
  TeeMsg_Rectangle := '������';
  TeeMsg_VertLine := '�� �����';
  TeeMsg_HorizLine := '�� ����';
  TeeMsg_Line := '��';
  TeeMsg_Cube := '����';
  TeeMsg_DiagCross := '���� �����';

  TeeMsg_CanNotFindTempPath := '����� temp ���� ���';
  TeeMsg_CanNotCreateTempChart := '����� ����� ���� temp ����� ����';
  TeeMsg_CanNotEmailChart := '�������� TeeChart �� email ���. ����� �� mapi: %d';

  TeeMsg_SeriesDelete := '��� �����: ValueIndex %d ���� �� ������ ���.(0 �� %d)';

  { 5.02 }{ Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG := 'as &JPEG';
  TeeMsg_JPEGFilter := 'JPEG files (*.jpg)|*.jpg';
  TeeMsg_AsGIF := 'as &GIF';
  TeeMsg_GIFFilter := 'GIF files (*.gif)|*.gif';
  TeeMsg_AsPNG := 'as &PNG';
  TeeMsg_PNGFilter := 'PNG files (*.png)|*.png';
  TeeMsg_AsPCX := 'as PC&X';
  TeeMsg_PCXFilter := 'PCX files (*.pcx)|*.pcx';
  TeeMsg_AsVML := 'as &VML (HTM)';
  TeeMsg_VMLFilter := 'VML files (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage := '����...';

  { 5.03 }
  TeeMsg_Gradient := 'Gradient';
  TeeMsg_WantToSave := '��� �������� %s �� save ���Ͽ';
  TeeMsg_NativeFilter := 'TeeChart files';

  TeeMsg_Property := 'Property';
  TeeMsg_Value := '�����';
  TeeMsg_Yes := '���';
  TeeMsg_No := '��';
  TeeMsg_Image := '(�����)';

  { TeeProCo }
  TeeMsg_GalleryPolar := '����';
  TeeMsg_GalleryCandle := '���';
  TeeMsg_GalleryVolume := '����';
  TeeMsg_GallerySurface := '���';
  TeeMsg_GalleryContour := '���� ������';
  TeeMsg_GalleryBezier := 'Bezier';
  TeeMsg_GalleryPoint3D := '���� 3 ����';
  TeeMsg_GalleryRadar := '�����';
  TeeMsg_GalleryDonut := 'Donut';
  TeeMsg_GalleryCursor := 'Cursor';
  TeeMsg_GalleryBar3D := '���� 3 ����';
  TeeMsg_GalleryBigCandle := '��� ��ѐ';
  TeeMsg_GalleryLinePoint := '�� ����';
  TeeMsg_GalleryHistogram := '��������';
  TeeMsg_GalleryWaterFall := '�����';
  TeeMsg_GalleryWindRose := '������ ��� ����';
  TeeMsg_GalleryClock := '����';
  TeeMsg_GalleryColorGrid := '���� ��';
  TeeMsg_GalleryBoxPlot := '���� ���';
  TeeMsg_GalleryHorizBoxPlot := '���� ��� ����';
  TeeMsg_GalleryBarJoin := '���� ����';
  TeeMsg_GallerySmith := '����';
  TeeMsg_GalleryPyramid := '���';
  TeeMsg_GalleryMap := '����';

  TeeMsg_PolyDegreeRange := '���� ��������� ���� ��� 1 � 20 ����';
  TeeMsg_AnswerVectorIndex := 'Answer Vector index ���� ��� 1 � %d ����';
  TeeMsg_FittingError := '�������� ����� ����� �� ������ ���';
  TeeMsg_PeriodRange := '���� ���� ��ѐ�� �� ��� ����';
  TeeMsg_ExpAverageWeight := 'ExpAverage Weight ���� ��� 0 � 1 ����';
  TeeMsg_GalleryErrorBar := '���� ���';
  TeeMsg_GalleryError := '���';
  TeeMsg_GalleryHighLow := '����-�����';
  TeeMsg_FunctionMomentum := 'Momentum';
  TeeMsg_FunctionMomentumDiv := 'Momentum Div';
  TeeMsg_FunctionExpAverage := 'Exp. Average';
  TeeMsg_FunctionMovingAverage := 'Moving Avrg.';
  TeeMsg_FunctionExpMovAve := 'Exp.Mov.Avrg.';
  TeeMsg_FunctionRSI := 'R.S.I.';
  TeeMsg_FunctionCurveFitting := 'Curve Fitting';
  TeeMsg_FunctionTrend := 'Trend';
  TeeMsg_FunctionExpTrend := 'Exp.Trend';
  TeeMsg_FunctionLogTrend := 'Log.Trend';
  TeeMsg_FunctionCumulative := 'Cumulative';
  TeeMsg_FunctionStdDeviation := 'Std.Deviation';
  TeeMsg_FunctionBollinger := 'Bollinger';
  TeeMsg_FunctionRMS := 'Root Mean Sq.';
  TeeMsg_FunctionMACD := 'MACD';
  TeeMsg_FunctionStochastic := 'Stochastic';
  TeeMsg_FunctionADX := 'ADX';

  TeeMsg_FunctionCount := '�����';
  TeeMsg_LoadChart := '������� TeeChart...';
  TeeMsg_SaveChart := 'save ���� TeeChart...';
  TeeMsg_TeeFiles := 'TeeChart Pro �������';

  TeeMsg_GallerySamples := '����';
  TeeMsg_GalleryStats := '����';

  TeeMsg_CannotFindEditor := '�������� ��� editor������ �� ���� ���: %s';


  TeeMsg_CannotLoadChartFromURL := 'Error code: %d downloading Chart from URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL := 'Error code: %d downloading Series data from URL: %s';

  TeeMsg_ValuesDate := '�����';
  TeeMsg_ValuesOpen := '���';
  TeeMsg_ValuesHigh := '����';
  TeeMsg_ValuesLow := '�����';
  TeeMsg_ValuesClose := '����';
  TeeMsg_ValuesOffset := '����';
  TeeMsg_ValuesStdError := '���� ���������';

  TeeMsg_Grid3D := 'Grid 3D';

  TeeMsg_LowBezierPoints := '����� ���� Bezier ���� ��ѐ�� �� 1 ����';

  { TeeCommander component... }

  TeeCommanMsg_Normal := '�����';
  TeeCommanMsg_Edit := '������';
  TeeCommanMsg_Print := '�ǁ';
  TeeCommanMsg_Copy := '߁�';
  TeeCommanMsg_Save := '�����';
  TeeCommanMsg_3D := '3 ����';

  TeeCommanMsg_Rotating := '����: %d� ����ϐ�: %d�';
  TeeCommanMsg_Rotate := '����';

  TeeCommanMsg_Moving := '���� ����: %d ���� �����: %d';
  TeeCommanMsg_Move := '������';

  TeeCommanMsg_Zooming := 'Zoom: %d %%';
  TeeCommanMsg_Zoom := 'Zoom';

  TeeCommanMsg_Depthing := '3 ����: %d %%';
  TeeCommanMsg_Depth := '���';

  TeeCommanMsg_Chart := '����';
  TeeCommanMsg_Panel := '����';

  TeeCommanMsg_RotateLabel := '���� ������� %s �� �����';
  TeeCommanMsg_MoveLabel := '���� ������ %s �� �����';
  TeeCommanMsg_ZoomLabel := '���� zoom ���� %s �� �����';
  TeeCommanMsg_DepthLabel := '���� ����� ������ ����� 3 ���� %s �� �����';

  TeeCommanMsg_NormalLabel := '���� ����� �� �� ���� zoom����� � ���� ����� ���� �� ���� ������� ����� ';
  TeeCommanMsg_NormalPieLabel := 'Drag a Pie Slice to Explode it';

  TeeCommanMsg_PieExploding := 'Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess := '����� ���� ���� ����� �� 4 ����';
  TeeMsg_TriSurfaceAllColinear := '���� ���� colinear data';
  TeeMsg_TriSurfaceSimilar := '���� ���� �� �����. ����� ���� ���� �����';
  TeeMsg_GalleryTriSurface := '��� �����';

  TeeMsg_AllSeries := '���� �����';
  TeeMsg_Edit := '������';

  TeeMsg_GalleryFinancial := '����';

  TeeMsg_CursorTool := '���� ���';
  TeeMsg_DragMarksTool := '����� �������';
  TeeMsg_AxisArrowTool := '���� �������';
  TeeMsg_DrawLineTool := '��� ��';
  TeeMsg_NearestTool := '��������� ����';
  TeeMsg_ColorBandTool := '���� ��';
  TeeMsg_ColorLineTool := '�� ���';
  TeeMsg_RotateTool := '����';
  TeeMsg_ImageTool := '�����';
  TeeMsg_MarksTipTool := '����� ������';
  TeeMsg_AnnotationTool := '����������';

  TeeMsg_CantDeleteAncestor := '�������� ���� �� ��� ���';

  TeeMsg_Load := 'load ����...';
  TeeMsg_NoSeriesSelected := '��� ����� ������ ���� ���';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions := '����';
  TeeMsg_CategorySeriesActions := '������ ����';

  TeeMsg_Action3D := '3 ����';
  TeeMsg_Action3DHint := '��� ���� ��� 2 ���� � 3 ����';
  TeeMsg_ActionSeriesActive := '����';
  TeeMsg_ActionSeriesActiveHint := '�����/����� ���� �����';
  TeeMsg_ActionEditHint := '������ ����';
  TeeMsg_ActionEdit := '������...';
  TeeMsg_ActionCopyHint := '߁� �� Clipboard';
  TeeMsg_ActionCopy := '߁�';
  TeeMsg_ActionPrintHint := '��� ����� �ǁ ����';
  TeeMsg_ActionPrint := '�ǁ...';
  TeeMsg_ActionAxesHint := '�����/����� ���� ������';
  TeeMsg_ActionAxes := '������';
  TeeMsg_ActionGridsHint := '�����/����� ���� grid ��';
  TeeMsg_ActionGrids := 'grid� ��';
  TeeMsg_ActionLegendHint := '�����/����� ���� ����� �����';
  TeeMsg_ActionLegend := '����� �����';
  TeeMsg_ActionSeriesEditHint := '������ �����';
  TeeMsg_ActionSeriesMarksHint := '�����/����� ���� ����� �����';
  TeeMsg_ActionSeriesMarks := '�����';
  TeeMsg_ActionSaveHint := 'save ���� ����';
  TeeMsg_ActionSave := 'save ����...';

  TeeMsg_CandleBar := '����';
  TeeMsg_CandleNoOpen := 'No Open';
  TeeMsg_CandleNoClose := 'No Close';
  TeeMsg_NoHigh := 'No High';
  TeeMsg_NoLow := 'No Low';
  TeeMsg_ColorRange := '������ ��';
  TeeMsg_WireFrame := '��� ������';
  TeeMsg_DotFrame := '��� ������';
  TeeMsg_Positions := '��������';
  TeeMsg_NoGrid := '���� grid';
  TeeMsg_NoPoint := '���� ����';
  TeeMsg_NoLine := '���� ��';
  TeeMsg_Labels := '������';
  TeeMsg_NoCircle := '���� �������';
  TeeMsg_Lines := '����';
  TeeMsg_Border := '�����';

  TeeMsg_SmithResistance := '�������';
  TeeMsg_SmithReactance := '�����';

  TeeMsg_Column := '����';

  { 5.01 }
  TeeMsg_Separator := '��������';
  TeeMsg_FunnelSegment := '���� ';
  TeeMsg_FunnelSeries := '���';
  TeeMsg_FunnelPercent := '0.00 %';
  TeeMsg_FunnelExceed := '����� �� ����� ����';
  TeeMsg_FunnelWithin := '  �� ����� ����';
  TeeMsg_FunnelBelow := ' �� ����� �� ����� ����� ����';
  TeeMsg_CalendarSeries := '�����';
  TeeMsg_DeltaPointSeries := 'DeltaPoint';
  TeeMsg_ImagePointSeries := 'ImagePoint';
  TeeMsg_ImageBarSeries := 'ImageBar';
  TeeMsg_SeriesTextFieldZero := 'SeriesText: Field index ���� ��ѐ�� �� ��� ����.';

  { 5.02 }
  TeeMsg_Origin := '����';
  TeeMsg_Transparency := '������';
  TeeMsg_Box := '����';
  TeeMsg_ExtrOut := 'ExtrOut';
  TeeMsg_MildOut := 'MildOut';
  TeeMsg_PageNumber := '����� ����';
  TeeMsg_TextFile := '���� Text';

  { 5.03 }
  TeeMsg_DragPoint := '���� ���';
  TeeMsg_OpportunityValues := 'OpportunityValues';
  TeeMsg_QuoteValues := 'QuoteValues';
end;

procedure TeeCreateFarsi;
begin
  if not Assigned(TeeFarsiLanguage) then
  begin
    TeeFarsiLanguage := TStringList.Create;
    TeeFarsiLanguage.Text :=

'LABELS=���� ��' + #13 +
'DATASET=Dataset' + #13 +
'ALL RIGHTS RESERVED.=���� ���� ����� ���' + #13 +
'APPLY=�����' + #13 +
'CLOSE=����' + #13 +
'OK=����' + #13 +
'ABOUT TEECHART PRO V7.0=������ TeeChart Pro v7.0' + #13 +
'OPTIONS=����� ��' + #13 +
'FORMAT=����' + #13 +
'TEXT=���' + #13 +
'GRADIENT=Gradient' + #13 +
'SHADOW=����' + #13 +
'POSITION=������' + #13 +
'LEFT=��' + #13 +
'TOP=����' + #13 +
'CUSTOM=������' + #13 +
'PEN=���' + #13 +
'PATTERN=���' + #13 +
'SIZE=������' + #13 +
'BEVEL=����' + #13 +
'INVERTED=�ژ��' + #13 +
'INVERTED SCROLL=���� �ژ��' + #13 +
'BORDER=�����' + #13 +
'ORIGIN=����' + #13 +
'USE ORIGIN=������� �� ����' + #13 +
'AREA LINES=���� �����' + #13 +
'AREA=�����' + #13 +
'COLOR=��' + #13 +
'SERIES=�����' + #13 +
'SUM=���' + #13 +
'DAY=���' + #13 +
'QUARTER=���' + #13 +
'(MAX)=(max)' + #13 +
'(MIN)=(min)' + #13 +
'VISIBLE=����' + #13 +
'CURSOR=��� ���' + #13 +
'GLOBAL=����' + #13 +
'X=X' + #13 +
'Y=Y' + #13 +
'Z=Z' + #13 +
'3D=3 ����' + #13 +
'HORIZ. LINE=�� ����.' + #13 +
'LABEL AND PERCENT=���� � ����' + #13 +
'LABEL AND VALUE=���� � �����' + #13 +
'LABEL AND PERCENT TOTAL=���� � ���� �����' + #13 +
'PERCENT TOTAL=���� �����' + #13 +
'MSEC.=msec.' + #13 +
'SUBTRACT=����' + #13 +
'MULTIPLY=���' + #13 +
'DIVIDE=�����' + #13 +
'STAIRS=��� ��' + #13 +
'MOMENTUM=����� �ј�' + #13 +
'AVERAGE=������' + #13 +
'XML=XML' + #13 +
'HTML TABLE=���� HTML' + #13 +
'EXCEL=Excel' + #13 +
'NONE=�퍘���' + #13 +
'(NONE)=�퍘���'#13 +
'WIDTH=���' + #13 +
'HEIGHT=������' + #13 +
'COLOR EACH=�� �ј���' + #13 +
'STACK=����' + #13 +
'STACKED=���� ��' + #13 +
'STACKED 100%=����  100%' + #13 +
'AXIS=����' + #13 +
'LENGTH=���' + #13 +
'CANCEL=���' + #13 +
'SCROLL=����' + #13 +
'INCREMENT=������' + #13 +
'VALUE=�����' + #13 +
'STYLE=�����' + #13 +
'JOIN=�����' + #13 +
'AXIS INCREMENT=������ ����' + #13 +
'AXIS MAXIMUM AND MINIMUM=������� � ������� ����' + #13 +
'% BAR WIDTH=% ��� ����' + #13 +
'% BAR OFFSET=% ���� ����' + #13 +
'BAR SIDE MARGINS=����� ����� ����' + #13 +
'AUTO MARK POSITION=����ʐ���� �������� ������' + #13 +
'DARK BAR 3D SIDES=����� ����� ���� �� ����' + #13 +
'MONOCHROME=�� ��' + #13 +
'COLORS=����' + #13 +
'DEFAULT=��� ���' + #13 +
'MEDIAN=�����' + #13 +
'IMAGE=�����' + #13 +
'DAYS=�����' + #13 +
'WEEKDAYS=������ ����' + #13 +
'TODAY=�����' + #13 +
'SUNDAY=������' + #13 +
'MONTHS=�����' + #13 +
'LINES=����' + #13 +
'UPPERCASE=���� ��ѐ' + #13 +
'STICK=���' + #13 +
'CANDLE WIDTH=��� ���' + #13 +
'BAR=����' + #13 +
'OPEN CLOSE=��� � ����' + #13 +
'DRAW 3D=��� �� ����' + #13 +
'DARK 3D=���� 3 ����' + #13 +
'SHOW OPEN=���� ���' + #13 +
'SHOW CLOSE=���� ����' + #13 +
'UP CLOSE=���� ����' + #13 +
'DOWN CLOSE=���� �����' + #13 +
'CIRCLED=����' + #13 +
'CIRCLE=�����' + #13 +
'3 DIMENSIONS=3 ����' + #13 +
'ROTATION=����' + #13 +
'RADIUS=����' + #13 +
'HOURS=����' + #13 +
'HOUR=����' + #13 +
'MINUTES=�����' + #13 +
'SECONDS=�����' + #13 +
'FONT=����' + #13 +
'INSIDE=����' + #13 +
'ROTATED=���� �����' + #13 +
'ROMAN=����' + #13 +
'TRANSPARENCY=������' + #13 +
'DRAW BEHIND=��� ���' + #13 +
'RANGE=������' + #13 +
'PALETTE=����' + #13 +
'STEPS=���' + #13 +
'GRID=Grid' + #13 +
'GRID SIZE=������ Grid' + #13 +
'ALLOW DRAG=����� ���' + #13 +
'AUTOMATIC=��������' + #13 +
'LEVEL=���' + #13 +
'LEVELS POSITION=������ ����' + #13 +
'SNAP=���' + #13 +
'FOLLOW MOUSE=����� �� ����' + #13 +
'TRANSPARENT=����' + #13 +
'ROUND FRAME=��� ���' + #13 +
'FRAME=���' + #13 +
'START=����' + #13 +
'END=�����' + #13 +
'MIDDLE=���' + #13 +
'NO MIDDLE=���� ���' + #13 +
'DIRECTION=���' + #13 +
'DATASOURCE=DataSource' + #13 +
'AVAILABLE=�����' + #13 +
'SELECTED=������ ���' + #13 +
'CALC=������' + #13 +
'GROUP BY=���� ��' + #13 +
'OF=��' + #13 +
'HOLE %=% ����' + #13 +
'RESET POSITIONS=reset ���� ��������' + #13 +
'MOUSE BUTTON=���� ����' + #13 +
'ENABLE DRAWING=���� ���� ���' + #13 +
'ENABLE SELECT=���� ���� ������' + #13 +
'ORTHOGONAL=����' + #13 +
'ANGLE=�����' + #13 +
'ZOOM TEXT=zoom ���' + #13 +
'PERSPECTIVE=��������' + #13 +
'ZOOM=Zoom' + #13 +
'ELEVATION=����ϐ�' + #13 +
'BEHIND=���' + #13 +
'AXES=������' + #13 +
'SCALES=�����' + #13 +
'TITLE=����' + #13 +
'TICKS=���' + #13 +
'MINOR=�����' + #13 +
'CENTERED=���' + #13 +
'CENTER=����' + #13 +
'PATTERN COLOR EDITOR=�����Ԑ� �� ���' + #13 +
'START VALUE=����� ����' + #13 +
'END VALUE=����� �����' + #13 +
'COLOR MODE=���� ��' + #13 +
'LINE MODE=���� ��' + #13 +
'HEIGHT 3D=������ 3 ����' + #13 +
'OUTLINE=���' + #13 +
'PRINT PREVIEW=��ԝ����� �ǁ' + #13 +
'ANIMATED=�����' + #13 +
'ALLOW=����� ����' + #13 +
'DASH=�� �����' + #13 +
'DOT=����' + #13 +
'DASH DOT DOT=�� ���� ����' + #13 +
'PALE=����' + #13 +
'STRONG=����' + #13 +
'WIDTH UNITS=���� ���' + #13 +
'FOOT=����' + #13 +
'SUBFOOT=��� ����' + #13 +
'SUBTITLE=���� ����' + #13 +
'LEGEND=�����' + #13 +
'COLON=����� �� ����' + #13 +
'AXIS ORIGIN=���� ����' + #13 +
'UNITS=������' + #13 +
'PYRAMID=���' + #13 +
'DIAMOND=�����' + #13 +
'CUBE=����' + #13 +
'TRIANGLE=����' + #13 +
'STAR=�����' + #13 +
'SQUARE=�����' + #13 +
'DOWN TRIANGLE=���� ���� �����' + #13 +
'SMALL DOT=���� ���' + #13 +
'LOAD=��ѐ����' + #13 +
'FILE=����' + #13 +
'RECTANGLE=����' + #13 +
'HEADER=�����' + #13 +
'CLEAR=��� ����' + #13 +
'ONE HOUR=�� ����' + #13 +
'ONE YEAR=�� ���' + #13 +
'ELLIPSE=����' + #13 +
'CONE=�����' + #13 +
'ARROW=�����' + #13 +
'CYLLINDER=�������' + #13 +
'TIME=����' + #13 +
'BRUSH=��� ��' + #13 +
'LINE=��' + #13 +
'VERTICAL LINE=�� �����' + #13 +
'AXIS ARROWS=�������� ������' + #13 +
'MARK TIPS=������ ����ʐ����' + #13 +
'DASH DOT=�� ����' + #13 +
'COLOR BAND=���� ���' + #13 +
'COLOR LINE=�� ���' + #13 +
'INVERT. TRIANGLE=���� �����' + #13 +
'INVERT. PYRAMID=��� �����' + #13 +
'INVERTED PYRAMID=��� �����' + #13 +
'SERIES DATASOURCE TEXT EDITOR=�����Ԑ� ��� DataSource �����' + #13 +
'SOLID=����' + #13 +
'WIREFRAME=��� ������' + #13 +
'DOTFRAME=��� ������' + #13 +
'SIDE BRUSH=������ �����' + #13 +
'SIDE=���' + #13 +
'SIDE ALL=��� ���' + #13 +
'ROTATE=�������' + #13 +
'SMOOTH PALETTE=���� �����' + #13 +
'CHART TOOLS GALLERY=����� �������� ����' + #13 +
'ADD=������' + #13 +
'BORDER EDITOR=�����Ԑ� �����' + #13 +
'DRAWING MODE=���� ���' + #13 +
'CLOSE CIRCLE=����� ����' + #13 +
'PICTURE=�����' + #13 +
'NATIVE=�����' + #13 +
'DATA=������' + #13 +
'KEEP ASPECT RATIO=��� ���� �����' + #13 +
'COPY=߁�' + #13 +
'SAVE=�����' + #13 +
'SEND=�������' + #13 +
'INCLUDE SERIES DATA=���� ��� ������' + #13 +
'FILE SIZE=���� ����' + #13 +
'INCLUDE=����' + #13 +
'POINT INDEX=������ ����' + #13 +
'POINT LABELS=������� ����' + #13 +
'DELIMITER=��������' + #13 +
'DEPTH=���' + #13 +
'COMPRESSION LEVEL=����� ����� ����' + #13 +
'COMPRESSION=���������' + #13 +
'PATTERNS=�����' + #13 +
'LABEL=������' + #13 +
'GROUP SLICES=������� ����' + #13 +
'EXPLODE BIGGEST=��ѐ���� ���' + #13 +
'TOTAL ANGLE=����� �����' + #13 +
'HORIZ. SIZE=���� ����' + #13 +
'VERT. SIZE=���� �����' + #13 +
'SHAPES=�����' + #13 +
'INFLATE MARGINS=���� �������' + #13 +
'QUALITY=�����' + #13 +
'SPEED=����' + #13 +
'% QUALITY=% �����' + #13 +
'GRAY SCALE=��� �������' + #13 +
'PERFORMANCE=�����' + #13 +
'BROWSE=�����' + #13 +
'TILED=��������' + #13 +
'HIGH=����' + #13 +
'LOW=�����' + #13 +
'DATABASE CHART=���� ���� �������' + #13 +
'NON DATABASE CHART=���� ��� ���� �������' + #13 +
'HELP=���' + #13 +
'NEXT >=���� >' + #13 +
'< BACK=< ����' + #13 +
'TEECHART WIZARD=TeeChart Wizard' + #13 +
'PERCENT=����' + #13 +
'PIXELS=����' + #13 +
'ERROR WIDTH=����� �� ���' + #13 +
'ENHANCED=������' + #13 +
'VISIBLE WALLS=��������� ����' + #13 +
'ACTIVE=����' + #13 +
'DELETE=���' + #13 +
'ALIGNMENT=����' + #13 +
'ADJUST FRAME=����� ���' + #13 +
'HORIZONTAL=����' + #13 +
'VERTICAL=�����' + #13 +
'VERTICAL POSITION=������ �����' + #13 +
'NUMBER=���' + #13 +
'LEVELS=����' + #13 +
'OVERLAP=�������' + #13 +
'STACK 100%=���� 100%' + #13 +
'MOVE=������' + #13 +
'CLICK=����' + #13 +
'DELAY=�����' + #13 +
'DRAW LINE=��� ��' + #13 +
'FUNCTIONS=�����' + #13 +
'SOURCE SERIES=������ ����' + #13 +
'ABOVE=�����' + #13 +
'BELOW=�����' + #13 +
'Dif. Limit=�� ������' + #13 +
'WITHIN=��' + #13 +
'EXTENDED=����� �����' + #13 +
'STANDARD=���������' + #13 +
'STATS=����' + #13 +
'FINANCIAL=����' + #13 +
'OTHER=����' + #13 +
'TEECHART GALLERY=����� TeeChart' + #13 +
'CONNECTING LINES=���� �����' + #13 +
'REDUCTION=�����' + #13 +
'LIGHT=���' + #13 +
'INTENSITY=���' + #13 +
'FONT OUTLINES=���� ���' + #13 +
'SMOOTH SHADING=���� �����' + #13 +
'AMBIENT LIGHT=��� �����' + #13 +
'MOUSE ACTION=��ӝ����� ����' + #13 +
'CLOCKWISE=��� �������� ����' + #13 +
'ANGLE INCREMENT=������ �����' + #13 +
'RADIUS INCREMENT=������ ����' + #13 +
'PRINTER=�ǁ��' + #13 +
'SETUP=��� ������' + #13 +
'ORIENTATION=�����' + #13 +
'PORTRAIT=�����' + #13 +
'LANDSCAPE=����' + #13 +
'MARGINS (%)=������� (%)' + #13 +
'MARGINS=�������' + #13 +
'DETAIL=������' + #13 +
'MORE=�����' + #13 +
'PROPORTIONAL=������' + #13 +
'VIEW MARGINS=������ �������' + #13 +
'RESET MARGINS=reset ���� �������' + #13 +
'PRINT=�ǁ' + #13 +
'TEEPREVIEW EDITOR=�����Ԑ� TeePreview' + #13 +
'ALLOW MOVE=����� ������' + #13 +
'ALLOW RESIZE=����� ����� ������' + #13 +
'SHOW IMAGE=����� �����' + #13 +
'DRAG IMAGE=����� �����' + #13 +
'AS BITMAP=������ Bitmap' + #13 +
'SIZE %=������ %' + #13 +
'FIELDS=������' + #13 +
'SOURCE=����' + #13 +
'SEPARATOR=��������' + #13 +
'NUMBER OF HEADER LINES=����� ���� ������' + #13 +
'COMMA=��ѐ��' + #13 +
'EDITING=������' + #13 +
'TAB=Tab' + #13 +
'SPACE=�����' + #13 +
'ROUND RECTANGLE=������ ���� ���' + #13 +
'BOTTOM=�����' + #13 +
'RIGHT=����' + #13 +
'C PEN=��� C' + #13 +
'R PEN=��� R' + #13 +
'C LABELS=������� C' + #13 +
'R LABELS=������� R' + #13 +
'MULTIPLE BAR=��� �����' + #13 +
'MULTIPLE AREAS=��� �������' + #13 +
'STACK GROUP=���� ������' + #13 +
'BOTH=�� ��' + #13 +
'BACK DIAGONAL=��� ����' + #13 +
'B.DIAGONAL=���� �����' + #13 +
'DIAG.CROSS=���� �����' + #13 +
'WHISKER=Whisker' + #13 +
'CROSS=����' + #13 +
'DIAGONAL CROSS=���� ����' + #13 +
'LEFT RIGHT=�� ����' + #13 +
'RIGHT LEFT=���� ��' + #13 +
'FROM CENTER=�� ���' + #13 +
'FROM TOP LEFT=�� ���� ����� ��' + #13 +
'FROM BOTTOM LEFT=�� ���� ����� ����' + #13 +
'SHOW WEEKDAYS=����� ������ ����' + #13 +
'SHOW MONTHS=����� �����' + #13 +
'SHOW PREVIOUS BUTTON=����� ���� ����'#13 +
'SHOW NEXT BUTTON=����� ���� ����'#13 +
'TRAILING DAYS=������ ������' + #13 +
'SHOW TODAY=����� �����' + #13 +
'TRAILING=������' + #13 +
'LOWERED=�������' + #13 +
'RAISED=������' + #13 +
'HORIZ. OFFSET=���� ����' + #13 +
'VERT. OFFSET=���� �����' + #13 +
'INNER=�����' + #13 +
'LEN=���' + #13 +
'AT LABELS ONLY=��� �� ������' + #13 +
'MAXIMUM=�������' + #13 +
'MINIMUM=�������' + #13 +
'CHANGE=�����' + #13 +
'LOGARITHMIC=�������' + #13 +
'LOG BASE=���� Log.' + #13 +
'DESIRED INCREMENT=������ �������' + #13 +
'(INCREMENT)=(������)' + #13 +
'MULTI-LINE=������' + #13 +
'MULTI LINE=������' + #13 +
'RESIZE CHART=����� ������ ����' + #13 +
'X AND PERCENT=X � ����' + #13 +
'X AND VALUE=X � �����' + #13 +
'RIGHT PERCENT=���� ����' + #13 +
'LEFT PERCENT=���� ��' + #13 +
'LEFT VALUE=����� ��' + #13 +
'RIGHT VALUE=���� ����' + #13 +
'PLAIN=����' + #13 +
'LAST VALUES=����� ������' + #13 +
'SERIES VALUES=����� ���' + #13 +
'SERIES NAMES=������ �����' + #13 +
'NEW=����' + #13 +
'EDIT=������' + #13 +
'PANEL COLOR=�� ����' + #13 +
'TOP BOTTOM=���� �����' + #13 +
'BOTTOM TOP=����� ����' + #13 +
'DEFAULT ALIGNMENT=���� ��ԝ ���' + #13 +
'EXPONENTIAL=�����' + #13 +
'LABELS FORMAT=���� ������' + #13 +
'MIN. SEPARATION %=% ����� �������' + #13 +
'YEAR=���' + #13 +
'MONTH=���' + #13 +
'WEEK=����' + #13 +
'WEEKDAY=�������' + #13 +
'MARK=�����' + #13 +
'ROUND FIRST=��� ���' + #13 +
'LABEL ON AXIS=������ �� ��� ������' + #13 +
'COUNT=�����' + #13 +
'POSITION %=������ %' + #13 +
'START %=���� %' + #13 +
'END %=����� %' + #13 +
'OTHER SIDE=��� ���' + #13 +
'INTER-CHAR SPACING=����� ��� ������' + #13 +
'VERT. SPACING=����� �����' + #13 +
'POSITION OFFSET %=���� ������ %' + #13 +
'GENERAL=�����' + #13 +
'MANUAL=����' + #13 +
'PERSISTENT=���ϐ��' + #13 +
'PANEL=����' + #13 +
'ALIAS=��� ������' + #13 +
'2D=2 ����' + #13 +
'ADX=ADX' + #13 +
'BOLLINGER=Bollinger' + #13 +
'TEEOPENGL EDITOR=�����Ԑ� OpenGL' + #13 +
'FONT 3D DEPTH=��� ���� 3 ����' + #13 +
'NORMAL=�����' + #13 +
'TEEFONT EDITOR=�����Ԑ� ����' + #13 +
'CLIP POINTS=���� ���' + #13 +
'CLIPPED=�����' + #13 +
'3D %=3 ���� %' + #13 +
'QUANTIZE=����� ����' + #13 +
'QUANTIZE 256=����� ���� 256' + #13 +
'DITHER=������' + #13 +
'VERTICAL SMALL=����� ���' + #13 +
'HORIZ. SMALL=���� ���' + #13 +
'DIAG. SMALL=��� ���' + #13 +
'BACK DIAG. SMALL=��� ���� ���' + #13 +
'DIAG. CROSS SMALL=���� ���� ���' + #13 +
'MINIMUM PIXELS=������� ����' + #13 +
'ALLOW SCROLL=����� ����' + #13 +
'SWAP=������' + #13 +
'GRADIENT EDITOR=������ Gradient' + #13 +
'TEXT STYLE=����� ���' + #13 +
'DIVIDING LINES=���� ����� �����' + #13 +
'SYMBOLS=�������' + #13 +
'CHECK BOXES=�� �����' + #13 +
'FONT SERIES COLOR=���� ������ ���' + #13 +
'LEGEND STYLE=����� �����' + #13 +
'POINTS PER PAGE=����� ���� �� ����' + #13 +
'SCALE LAST PAGE=����� ����� ����' + #13 +
'CURRENT PAGE LEGEND=����� ���� �����' + #13 +
'BACKGROUND=�� �����' + #13 +
'BACK IMAGE=����� �� ������' + #13 +
'STRETCH=����� ���' + #13 +
'TILE=��������' + #13 +
'BORDERS=�������' + #13 +
'CALCULATE EVERY=������ ��' + #13 +
'NUMBER OF POINTS=����� ����' + #13 +
'RANGE OF VALUES=������ ������' + #13 +
'FIRST=���' + #13 +
'LAST=���' + #13 +
'ALL POINTS=���� ����' + #13 +
'DATA SOURCE=Data Source' + #13

{$IFDEF LCL}
;  TeeFarsiLanguage.Text:=TeeFarsiLanguage.Text
{$ENDIF}

+
'WALLS=��������' + #13 +
'PAGING=��������' + #13 +
'CLONE=����� ����' + #13 +
'TITLES=������' + #13 +
'TOOLS=�������' + #13 +
'EXPORT=����' + #13 +
'CHART=����' + #13 +
'BACK=���' + #13 +
'LEFT AND RIGHT=�� � ����' + #13 +
'SELECT A CHART STYLE=������ �� ����� ���� ����' + #13 +
'SELECT A DATABASE TABLE=������ �� Table �� Database' + #13 +
'TABLE=Table' + #13 +
'SELECT THE DESIRED FIELDS TO CHART=������ ������� ������� ���� ������� �� ����' + #13 +
'SELECT A TEXT LABELS FIELD=������ �� ���� ������' + #13 +
'CHOOSE THE DESIRED CHART TYPE=��� ���� ������� �� ������ ����' + #13 +
'CHART PREVIEW=��ԝ���� ����' + #13 +
'SHOW LEGEND=����� �����' + #13 +
'SHOW MARKS=����� �������' + #13 +
'FINISH=�����' + #13 +
'RANDOM=������' + #13 +
'DRAW EVERY=��� ��' + #13 +
'ARROWS=�������' + #13 +
'ASCENDING=�����' + #13 +
'DESCENDING=�����' + #13 +
'VERTICAL AXIS=���� �����' + #13 +
'DATETIME=�����/����' + #13 +
'TOP AND BOTTOM=���� � �����' + #13 +
'HORIZONTAL AXIS=���� ����' + #13 +
'PERCENTS=����' + #13 +
'VALUES=������' + #13 +
'FORMATS=������' + #13 +
'SHOW IN LEGEND=����� �� �����' + #13 +
'SORT=����' + #13 +
'MARKS=�������' + #13 +
'BEVEL INNER=��� �����' + #13 +
'BEVEL OUTER=��� ������' + #13 +
'PANEL EDITOR=�����Ԑ� ����' + #13 +
'CONTINUOUS=��������' + #13 +
'HORIZ. ALIGNMENT=���� ����' + #13 +
'EXPORT CHART=���� ����' + #13 +
'BELOW %=����� �� �� %' + #13 +
'BELOW VALUE=����� �� �� �����' + #13 +
'NEAREST POINT=��������� ����' + #13 +
'DRAG MARKS=����� ����' + #13 +
'TEECHART PRINT PREVIEW=��� ����� �ǁ' + #13 +
'X VALUE=����� X' + #13 +
'X AND Y VALUES=������ X Y' + #13 +
'SHININESS=�����ϐ�' + #13 +
'ALL SERIES VISIBLE=���� ���� ���� �����' + #13 +
'MARGIN=�����' + #13 +
'DIAGONAL=����' + #13 +
'LEFT TOP=���� ����� ��' + #13 +
'LEFT BOTTOM=���� ����� ��' + #13 +
'RIGHT TOP=���� ����� ����' + #13 +
'RIGHT BOTTOM=���� ����� ����' + #13 +
'EXACT DATE TIME=�����/���� ����' + #13 +
'RECT. GRADIENT=Gradient' + #13 +
'CROSS SMALL=���� ���' + #13 +
'AVG=������' + #13 +
'FUNCTION=����' + #13 +
'AUTO=Auto' + #13 +
'ONE MILLISECOND=�� ���������' + #13 +
'ONE SECOND=�� �����' + #13 +
'FIVE SECONDS=��� �����' + #13 +
'TEN SECONDS=�� �����' + #13 +
'FIFTEEN SECONDS=������ �����' + #13 +
'THIRTY SECONDS=�� �����' + #13 +
'ONE MINUTE=�� �����' + #13 +
'FIVE MINUTES=��� �����' + #13 +
'TEN MINUTES=�� �����' + #13 +
'FIFTEEN MINUTES=������ �����' + #13 +
'THIRTY MINUTES=�� �����' + #13 +
'TWO HOURS=�� ����' + #13 +
'SIX HOURS=�� ����' + #13 +
'TWELVE HOURS=������ ����' + #13 +
'ONE DAY=�� ���' + #13 +
'TWO DAYS=�� ���' + #13 +
'THREE DAYS=�� ����' + #13 +
'ONE WEEK=�� ����' + #13 +
'HALF MONTH=������ ���' + #13 +
'ONE MONTH=�� ���' + #13 +
'TWO MONTHS=�� ���' + #13 +
'THREE MONTHS=�� ���' + #13 +
'FOUR MONTHS=���� ���' + #13 +
'SIX MONTHS=�� ���' + #13 +
'IRREGULAR=��������' + #13 +
'CLICKABLE=���� ����' + #13 +
'ROUND=���' + #13 +
'FLAT=����' + #13 +
'PIE=���' + #13 +
'HORIZ. BAR=���� ����' + #13 +
'BUBBLE=����' + #13 +
'SHAPE=���' + #13 +
'POINT=����' + #13 +
'FAST LINE=�� ����' + #13 +
'CANDLE=���' + #13 +
'VOLUME=���' + #13 +
'HORIZ LINE=�� ����' + #13 +
'SURFACE=���' + #13 +
'LEFT AXIS=���� ��' + #13 +
'RIGHT AXIS=���� ����' + #13 +
'TOP AXIS=���� ����' + #13 +
'BOTTOM AXIS=���� �����' + #13 +
'CHANGE SERIES TITLE=����� ���� �����' + #13 +
'DELETE %S ?=��� %s ?' + #13 +
'DESIRED %S INCREMENT=������ %s ���� ���' + #13 +
'INCORRECT VALUE. REASON: %S=����� ������. ����: %S' + #13 +
'FillSampleValues NumValues must be > 0=FillSampleValues ���� ��ѐ�� �� ��� ����'#13 +
'VISIT OUR WEB SITE !=�� ���� �� ������ ����!'#13 +
'SHOW PAGE NUMBER=����� ����� ����'#13 +
'PAGE NUMBER=����� ����'#13 +
'PAGE %D OF %D=���� %d �� %d'#13 +
'TEECHART LANGUAGES=���� TeeChart'#13 +
'CHOOSE A LANGUAGE=�� ���� �� ������ ����' + #13 +
'SELECT ALL=������ ���'#13 +
'MOVE UP=������ �� ����'#13 +
'MOVE DOWN=������ �� �����'#13 +
'DRAW ALL=��� ���'#13 +
'TEXT FILE=���� Text'#13 +
'IMAG. SYMBOL=�����  IMAG.'#13 +
'DRAG REPAINT=��� ���� �� ��� �����'#13 +
'NO LIMIT DRAG=��� �������';
  end;
end;

// ������� ���� ��. ��� ��� ���� ����!!! :)

procedure TeeSetFarsi;
begin
  TeeCreateFarsi;
  TeeLanguage := TeeFarsiLanguage;
  TeeFarsiConstants;
  TeeLanguageHotKeyAtEnd := False;
end;

initialization
finalization
  FreeAndNil(TeeFarsiLanguage);
end.

