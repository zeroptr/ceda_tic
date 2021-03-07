unit TeeHellenic;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeHellenicLanguage:TStringList=nil;

Procedure TeeSetHellenic;
Procedure TeeCreateHellenic;

implementation

Uses SysUtils, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeHellenicConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='� 1995-2009 by David Berneda';

  TeeMsg_Test               :='Test...';
  TeeMsg_LegendFirstValue   :='First Legend Value must be > 0';
  TeeMsg_LegendColorWidth   :='Legend Color Width must be > 0%';
  TeeMsg_SeriesSetDataSource:='No ParentChart to validate DataSource';
  TeeMsg_SeriesInvDataSource:='No valid DataSource: %s';
  TeeMsg_FillSample         :='FillSampleValues NumValues must be > 0';
  TeeMsg_AxisLogDateTime    :='DateTime Axis cannot be Logarithmic';
  TeeMsg_AxisLogNotPositive :='Logarithmic Axis Min and Max values should be >= 0';
  TeeMsg_AxisLabelSep       :='Labels Separation % must be greater than 0';
  TeeMsg_AxisIncrementNeg   :='Axis increment must be >= 0';
  TeeMsg_AxisMinMax         :='Axis Minimum Value must be <= Maximum';
  TeeMsg_AxisMaxMin         :='Axis Maximum Value must be >= Minimum';
  TeeMsg_AxisLogBase        :='Axis Logarithmic Base should be >= 2';
  TeeMsg_MaxPointsPerPage   :='MaxPointsPerPage must be >= 0';
  TeeMsg_3dPercent          :='3D effect percent must be between %d and %d';
  TeeMsg_CircularSeries     :='Circular Series dependences are not allowed';
  TeeMsg_WarningHiColor     :='16k Color or greater required to get better look';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='Axis Title';
  TeeMsg_AxisLabels         :='Axis Labels';
  TeeMsg_RefreshInterval    :='Refresh Interval must be between 0 and 60';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart is not myself!';
  TeeMsg_GalleryLine        :='Line';
  TeeMsg_GalleryPoint       :='Point';
  TeeMsg_GalleryArea        :='Area';
  TeeMsg_GalleryBar         :='Bar';
  TeeMsg_GalleryHorizBar    :='Horiz. Bar';
  TeeMsg_Stack              :='Stack';
  TeeMsg_GalleryPie         :='Pie';
  TeeMsg_GalleryCircled     :='Circled';
  TeeMsg_GalleryFastLine    :='Fast Line';
  TeeMsg_GalleryHorizLine   :='Horiz Line';

  TeeMsg_PieSample1         :='Cars';
  TeeMsg_PieSample2         :='Phones';
  TeeMsg_PieSample3         :='Tables';
  TeeMsg_PieSample4         :='Monitors';
  TeeMsg_PieSample5         :='Lamps';
  TeeMsg_PieSample6         :='Keyboards';
  TeeMsg_PieSample7         :='Bikes';
  TeeMsg_PieSample8         :='Chairs';

  TeeMsg_GalleryLogoFont    :='Courier New';
  TeeMsg_Editing            :='Editing %s';

  TeeMsg_GalleryStandard    :='Standard';
  TeeMsg_GalleryExtended    :='Extended';
  TeeMsg_GalleryFunctions   :='Functions';

  TeeMsg_EditChart          :='E&dit Chart...';
  TeeMsg_PrintPreview       :='&Print Preview...';
  TeeMsg_ExportChart        :='E&xport Chart...';
  TeeMsg_CustomAxes         :='Custom Axes...';

  TeeMsg_InvalidEditorClass :='%s: Invalid Editor Class: %s';
  TeeMsg_MissingEditorClass :='%s: has no Editor Dialog';

  TeeMsg_GalleryArrow       :='Arrow';

  TeeMsg_ExpFinish          :='&Finish';
  TeeMsg_ExpNext            :='&Next >';

  TeeMsg_GalleryGantt       :='Gantt';

  TeeMsg_GanttSample1       :='Design';
  TeeMsg_GanttSample2       :='Prototyping';
  TeeMsg_GanttSample3       :='Development';
  TeeMsg_GanttSample4       :='Sales';
  TeeMsg_GanttSample5       :='Marketing';
  TeeMsg_GanttSample6       :='Testing';
  TeeMsg_GanttSample7       :='Manufac.';
  TeeMsg_GanttSample8       :='Debugging';
  TeeMsg_GanttSample9       :='New Version';
  TeeMsg_GanttSample10      :='Banking';

  TeeMsg_ChangeSeriesTitle  :='Change Series Title';
  TeeMsg_NewSeriesTitle     :='New Series Title:';
  TeeMsg_DateTime           :='DateTime';
  TeeMsg_TopAxis            :='Top Axis';
  TeeMsg_BottomAxis         :='Bottom Axis';
  TeeMsg_LeftAxis           :='Left Axis';
  TeeMsg_RightAxis          :='Right Axis';

  TeeMsg_SureToDelete       :='Delete %s ?';
  TeeMsg_DateTimeFormat     :='DateTime For&mat:';
  TeeMsg_Default            :='Default';
  TeeMsg_ValuesFormat       :='Values For&mat:';
  TeeMsg_Maximum            :='Maximum';
  TeeMsg_Minimum            :='Minimum';
  TeeMsg_DesiredIncrement   :='Desired %s Increment';

  TeeMsg_IncorrectMaxMinValue:='Incorrect value. Reason: %s';
  TeeMsg_EnterDateTime      :='Enter [Number of Days] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='Apply Changes ?';
  TeeMsg_SelectedSeries     :='(Selected Series)';
  TeeMsg_RefreshData        :='&Refresh Data';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_DefaultEditorSize  :='414';
  TeeMsg_FunctionAdd        :='Add';
  TeeMsg_FunctionSubtract   :='Subtract';
  TeeMsg_FunctionMultiply   :='Multiply';
  TeeMsg_FunctionDivide     :='Divide';
  TeeMsg_FunctionHigh       :='High';
  TeeMsg_FunctionLow        :='Low';
  TeeMsg_FunctionAverage    :='Average';

  TeeMsg_GalleryShape       :='Shape';
  TeeMsg_GalleryBubble      :='Bubble';
  TeeMsg_FunctionNone       :='Copy';

  TeeMsg_None               :='(none)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';
  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='Pointer size must be greater than zero';
  TeeMsg_About              :='Abo&ut TeeChart...';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='Dataset';
  TeeMsg_AskDataSet         :='&Dataset:';

  TeeMsg_SingleRecord       :='Single Record';
  TeeMsg_AskDataSource      :='&DataSource:';

  TeeMsg_Summary            :='Summary';

  TeeMsg_FunctionPeriod     :='Function Period should be >= 0';

  TeeMsg_WizardTab          :='Business';
  TeeMsg_TeeChartWizard     :='TeeChart Wizard';

  TeeMsg_ClearImage         :='Clea&r';
  TeeMsg_BrowseImage        :='B&rowse...';

  TeeMsg_WizardSureToClose  :='Are you sure that you want to close the TeeChart Wizard ?';
  TeeMsg_FieldNotFound      :='Field %s does not exist';

  TeeMsg_DepthAxis          :='Depth Axis';
  TeeMsg_PieOther           :='Other';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='Pie';
  TeeMsg_ValuesBar          :='Bar';
  TeeMsg_ValuesAngle        :='Angle';
  TeeMsg_ValuesGanttStart   :='Start';
  TeeMsg_ValuesGanttEnd     :='End';
  TeeMsg_ValuesGanttNextTask:='NextTask';
  TeeMsg_ValuesBubbleRadius :='Radius';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='Legend';
  TeeMsg_Title              :='Title';
  TeeMsg_Foot               :='Footer';
  TeeMsg_Period		          :='Period';
  TeeMsg_PeriodRange        :='Period range';
  TeeMsg_CalcPeriod         :='Calculate %s every:';
  TeeMsg_SmallDotsPen       :='Small Dots';

  TeeMsg_InvalidTeeFile     :='Invalid Chart in *.'+TeeMsg_TeeExtension+' file';
  TeeMsg_WrongTeeFileFormat :='Wrong *.'+TeeMsg_TeeExtension+' file format';
  TeeMsg_EmptyTeeFile       :='Empty *.'+TeeMsg_TeeExtension+' file';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='Chart Axes';
  TeeMsg_ChartAxesCategoryDesc   :='Chart Axes properties and events';
  TeeMsg_ChartWallsCategoryName  :='Chart Walls';
  TeeMsg_ChartWallsCategoryDesc  :='Chart Walls properties and events';
  TeeMsg_ChartTitlesCategoryName :='Chart Titles';
  TeeMsg_ChartTitlesCategoryDesc :='Chart Titles properties and events';
  TeeMsg_Chart3DCategoryName     :='Chart 3D';
  TeeMsg_Chart3DCategoryDesc     :='Chart 3D properties and events';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='Custom';
  TeeMsg_Series                 :='Series';
  TeeMsg_SeriesList             :='Series...';

  TeeMsg_PageOfPages            :='Page %d of %d';
  TeeMsg_FileSize               :='%d bytes';

  TeeMsg_First  :='First';
  TeeMsg_Prior  :='Prior';
  TeeMsg_Next   :='Next';
  TeeMsg_Last   :='Last';
  TeeMsg_Insert :='Insert';
  TeeMsg_Delete :='Delete';
  TeeMsg_Edit   :='Edit';
  TeeMsg_Post   :='Post';
  TeeMsg_Cancel :='Cancel';

  TeeMsg_All    :='(all)';
  TeeMsg_Index  :='Index';
  TeeMsg_Text   :='Text';

  TeeMsg_AsBMP        :='as &Bitmap';
  TeeMsg_BMPFilter    :='Bitmaps (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='as &Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='Panel property is not set in Export format';

  TeeMsg_Normal    :='Normal';
  TeeMsg_NoBorder  :='No Border';
  TeeMsg_Dotted    :='Dotted';
  TeeMsg_Colors    :='Colors';
  TeeMsg_Filled    :='Filled';
  TeeMsg_Marks     :='Marks';
  TeeMsg_Stairs    :='Stairs';
  TeeMsg_Points    :='Points';
  TeeMsg_Height    :='Height';
  TeeMsg_Hollow    :='Hollow';
  TeeMsg_Point2D   :='Point 2D';
  TeeMsg_Triangle  :='Triangle';
  TeeMsg_Star      :='Star';
  TeeMsg_Circle    :='Circle';
  TeeMsg_DownTri   :='Down Tri.';
  TeeMsg_Cross     :='Cross';
  TeeMsg_Diamond   :='Diamond';
  TeeMsg_NoLines   :='No Lines';
  TeeMsg_Stack100  :='Stack 100%';
  TeeMsg_Pyramid   :='Pyramid';
  TeeMsg_Ellipse   :='Ellipse';
  TeeMsg_InvPyramid:='Inv. Pyramid';
  TeeMsg_Sides     :='Sides';
  TeeMsg_SideAll   :='Side All';
  TeeMsg_Patterns  :='Patterns';
  TeeMsg_Exploded  :='Exploded';
  TeeMsg_Shadow    :='Shadow';
  TeeMsg_SemiPie   :='Semi Pie';
  TeeMsg_Rectangle :='Rectangle';
  TeeMsg_VertLine  :='Vert.Line';
  TeeMsg_HorizLine :='Horiz.Line';
  TeeMsg_Line      :='Line';
  TeeMsg_Cube      :='Cube';
  TeeMsg_DiagCross :='Diag.Cross';

  TeeMsg_CanNotFindTempPath    :='Can not find Temp folder';
  TeeMsg_CanNotCreateTempChart :='Can not create Temp file';
  TeeMsg_CanNotEmailChart      :='Can not email TeeChart. Mapi Error: %d';

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
  TeeMsg_AsVML         :='as &VML (HTM)';
  TeeMsg_VMLFilter     :='VML files (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_AskLanguage  :='&Language...';

  { 5.03 }
  TeeMsg_Gradient     :='Gradient';
  TeeMsg_WantToSave   :='Do you want to save %s?';
  TeeMsg_NativeFilter :='TeeChart files';

  TeeMsg_Property     :='Property';
  TeeMsg_Value        :='Value';
  TeeMsg_Yes          :='Yes';
  TeeMsg_No           :='No';
  TeeMsg_Image        :='(image)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='Polar';
  TeeMsg_GalleryCandle      :='Candle';
  TeeMsg_GalleryVolume      :='Volume';
  TeeMsg_GallerySurface     :='Surface';
  TeeMsg_GalleryContour     :='Contour';
  TeeMsg_GalleryBezier      :='Bezier';
  TeeMsg_GalleryPoint3D     :='Point 3D';
  TeeMsg_GalleryRadar       :='Radar';
  TeeMsg_GalleryDonut       :='Donut';
  TeeMsg_GalleryCursor      :='Cursor';
  TeeMsg_GalleryBar3D       :='Bar 3D';
  TeeMsg_GalleryBigCandle   :='Big Candle';
  TeeMsg_GalleryLinePoint   :='Line Point';
  TeeMsg_GalleryHistogram   :='Histogram';
  TeeMsg_GalleryWaterFall   :='Water Fall';
  TeeMsg_GalleryWindRose    :='Wind Rose';
  TeeMsg_GalleryClock       :='Clock';
  TeeMsg_GalleryColorGrid   :='ColorGrid';
  TeeMsg_GalleryBoxPlot     :='BoxPlot';
  TeeMsg_GalleryHorizBoxPlot:='Horiz.BoxPlot';
  TeeMsg_GalleryBarJoin     :='Bar Join';
  TeeMsg_GallerySmith       :='Smith';
  TeeMsg_GalleryPyramid     :='Pyramid';
  TeeMsg_GalleryMap         :='Map';

  TeeMsg_PolyDegreeRange    :='Polynomial degree must be between 1 and 20';
  TeeMsg_AnswerVectorIndex   :='Answer Vector index must be between 1 and %d';
  TeeMsg_FittingError        :='Cannot process fitting';
  TeeMsg_PeriodRange         :='Period must be >= 0';
  TeeMsg_ExpAverageWeight    :='ExpAverage Weight must be between 0 and 1';
  TeeMsg_GalleryErrorBar     :='Error Bar';
  TeeMsg_GalleryError        :='Error';
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

  TeeMsg_FunctionCount       :='Count';
  TeeMsg_LoadChart           :='Open TeeChart...';
  TeeMsg_SaveChart           :='Save TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro files';

  TeeMsg_GallerySamples      :='Other';
  TeeMsg_GalleryStats        :='Stats';

  TeeMsg_CannotFindEditor    :='Cannot find Series editor Form: %s';


  TeeMsg_CannotLoadChartFromURL:='Error code: %d downloading Chart from URL: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='Error code: %d downloading Series data from URL: %s';

  TeeMsg_ValuesDate          :='Date';
  TeeMsg_ValuesOpen          :='Open';
  TeeMsg_ValuesHigh          :='High';
  TeeMsg_ValuesLow           :='Low';
  TeeMsg_ValuesClose         :='Close';
  TeeMsg_ValuesOffset        :='Offset';
  TeeMsg_ValuesStdError      :='StdError';

  TeeMsg_Grid3D              :='Grid 3D';

  TeeMsg_LowBezierPoints     :='Number of Bezier points should be > 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='Normal';
  TeeCommanMsg_Edit     :='Edit';
  TeeCommanMsg_Print    :='Print';
  TeeCommanMsg_Copy     :='Copy';
  TeeCommanMsg_Save     :='Save';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='Rotation: %d� Elevation: %d�';
  TeeCommanMsg_Rotate   :='Rotate';

  TeeCommanMsg_Moving   :='Horiz.Offset: %d Vert.Offset: %d';
  TeeCommanMsg_Move     :='Move';

  TeeCommanMsg_Zooming  :='Zoom: %d %%';
  TeeCommanMsg_Zoom     :='Zoom';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='Depth';

  TeeCommanMsg_Chart    :='Chart';
  TeeCommanMsg_Panel    :='Panel';

  TeeCommanMsg_RotateLabel:='Drag %s to Rotate';
  TeeCommanMsg_MoveLabel  :='Drag %s to Move';
  TeeCommanMsg_ZoomLabel  :='Drag %s to Zoom';
  TeeCommanMsg_DepthLabel :='Drag %s to resize 3D';

  TeeCommanMsg_NormalLabel:='Drag Left button to Zoom, Right button to Scroll';
  TeeCommanMsg_NormalPieLabel:='Drag a Pie Slice to Explode it';

  TeeCommanMsg_PieExploding :='Slice: %d Exploded: %d %%';

  TeeMsg_TriSurfaceLess        :='Number of points must be >= 4';
  TeeMsg_TriSurfaceAllColinear :='All colinear data points';
  TeeMsg_TriSurfaceSimilar     :='Similar points - cannot execute';
  TeeMsg_GalleryTriSurface     :='Triangle Surf.';

  TeeMsg_AllSeries :='All Series';
  TeeMsg_Edit      :='Edit';

  TeeMsg_GalleryFinancial    :='Financial';

  TeeMsg_CursorTool    :='Cursor';
  TeeMsg_DragMarksTool :='Drag Marks';
  TeeMsg_AxisArrowTool :='Axis Arrows';
  TeeMsg_DrawLineTool  :='Draw Line';
  TeeMsg_NearestTool   :='Nearest Point';
  TeeMsg_ColorBandTool :='Color Band';
  TeeMsg_ColorLineTool :='Color Line';
  TeeMsg_RotateTool    :='Rotate';
  TeeMsg_ImageTool     :='Image';
  TeeMsg_MarksTipTool  :='Mark Tips';
  TeeMsg_AnnotationTool:='Annotation';

  TeeMsg_CantDeleteAncestor  :='Can not delete ancestor';

  TeeMsg_Load	          :='Load...';
  TeeMsg_NoSeriesSelected :='No Series selected';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='Chart';
  TeeMsg_CategorySeriesActions :='Chart Series';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='Switch 2D / 3D';
  TeeMsg_ActionSeriesActive     :='&Active';
  TeeMsg_ActionSeriesActiveHint :='Show / Hide Series';
  TeeMsg_ActionEditHint         :='Edit Chart';
  TeeMsg_ActionEdit             :='&Edit...';
  TeeMsg_ActionCopyHint         :='Copy to Clipboard';
  TeeMsg_ActionCopy             :='&Copy';
  TeeMsg_ActionPrintHint        :='Print preview Chart';
  TeeMsg_ActionPrint            :='&Print...';
  TeeMsg_ActionAxesHint         :='Show / Hide Axes';
  TeeMsg_ActionAxes             :='&Axes';
  TeeMsg_ActionGridsHint        :='Show / Hide Grids';
  TeeMsg_ActionGrids            :='&Grids';
  TeeMsg_ActionLegendHint       :='Show / Hide Legend';
  TeeMsg_ActionLegend           :='&Legend';
  TeeMsg_ActionSeriesEditHint   :='Edit Series';
  TeeMsg_ActionSeriesMarksHint  :='Show / Hide Series Marks';
  TeeMsg_ActionSeriesMarks      :='&Marks';
  TeeMsg_ActionSaveHint         :='Save Chart';
  TeeMsg_ActionSave             :='&Save...';

  TeeMsg_CandleBar              :='Bar';
  TeeMsg_CandleNoOpen           :='No Open';
  TeeMsg_CandleNoClose          :='No Close';
  TeeMsg_NoHigh                 :='No High';
  TeeMsg_NoLow                  :='No Low';
  TeeMsg_ColorRange             :='Color Range';
  TeeMsg_WireFrame              :='Wireframe';
  TeeMsg_DotFrame               :='Dot Frame';
  TeeMsg_Positions              :='Positions';
  TeeMsg_NoGrid                 :='No Grid';
  TeeMsg_NoPoint                :='No Point';
  TeeMsg_NoLine                 :='No Line';
  TeeMsg_Labels                 :='Labels';
  TeeMsg_NoCircle               :='No Circle';
  TeeMsg_Lines                  :='Lines';
  TeeMsg_Border                 :='Border';

  TeeMsg_SmithResistance        :='Resistance';
  TeeMsg_SmithReactance         :='Reactance';

  TeeMsg_Column                 :='Column';

  { 5.01 }
  TeeMsg_Separator            :='Separator';
  TeeMsg_FunnelSegment        :='Segment ';
  TeeMsg_FunnelSeries         :='Funnel';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='Exceeds quota';
  TeeMsg_FunnelWithin         :=' within quota';
  TeeMsg_FunnelBelow          :=' or more below quota';
  TeeMsg_CalendarSeries       :='Calendar';
  TeeMsg_DeltaPointSeries     :='DeltaPoint';
  TeeMsg_ImagePointSeries     :='ImagePoint';
  TeeMsg_ImageBarSeries       :='ImageBar';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Field index should be greater than zero.';

  { 5.02 }
  TeeMsg_Origin               :='Origin';
  TeeMsg_Transparency         :='Transparency';
  TeeMsg_Box		              :='Box';
  TeeMsg_ExtrOut	            :='ExtrOut';
  TeeMsg_MildOut	            :='MildOut';
  TeeMsg_PageNumber	          :='Page Number';
  TeeMsg_TextFile             :='Text File';

  { 5.03 }
  TeeMsg_DragPoint            :='Drag Point';
  TeeMsg_OpportunityValues    :='OpportunityValues';
  TeeMsg_QuoteValues          :='QuoteValues';

  { 6.0 }
  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='as &PDF';
  TeeMsg_PDFFilter        :='PDF files (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='as PostScript';
  TeeMsg_PSFilter         :='PostScript files (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='Horizontal'#13'Area';
  TeeMsg_SelfStack        :='Self Stacked';
  TeeMsg_DarkPen          :='Dark Border';
  TeeMsg_SelectFolder     :='Select database folder';
  TeeMsg_BDEAlias         :='&Alias:';
  TeeMsg_ADOConnection    :='&Connection:';

  { 6.0 }
  TeeMsg_FunctionSmooth       :='Smoothing';
  TeeMsg_FunctionCross        :='Cross Points';
  TeeMsg_GridTranspose        :='3D Grid Transpose';
  TeeMsg_FunctionCompress     :='Compression';
  TeeMsg_ExtraLegendTool      :='Extra Legend';
  TeeMsg_FunctionCLV          :='Close Location'#13'Value';
  TeeMsg_FunctionOBV          :='On Balance'#13'Volume';
  TeeMsg_FunctionCCI          :='Commodity'#13'Channel Index';
  TeeMsg_FunctionPVO          :='Volume'#13'Oscillator';
  TeeMsg_SeriesAnimTool       :='Series Animation';
  TeeMsg_GalleryPointFigure   :='Point & Figure';
  TeeMsg_Up                   :='Up';
  TeeMsg_Down                 :='Down';
  TeeMsg_GanttTool            :='Gantt Drag';
  TeeMsg_XMLFile              :='XML file';
  TeeMsg_GridBandTool         :='Grid Band';
  TeeMsg_FunctionPerf         :='Performance';
  TeeMsg_GalleryGauge         :='Gauge';
  TeeMsg_GalleryGauges        :='Gauges';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='Vector 3D';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='Tower';
  TeeMsg_SingleColor          :='Single Color';
  TeeMsg_Cover                :='Cover';
  TeeMsg_Cone                 :='Cone';
  TeeMsg_PieTool              :='Pie Slices';
end;

Procedure TeeCreateHellenic;
begin
  if not Assigned(TeeHellenicLanguage) then
  begin
    TeeHellenicLanguage:=TStringList.Create;
    TeeHellenicLanguage.Text:=

'GRADIENT EDITOR=����������� �������� ��������'#13+
'GRADIENT=���������� ��������'#13+
'DIRECTION=����������'#13+
'VISIBLE=�����'#13+
'TOP BOTTOM=��� ���� ���� �� ����'#13+
'BOTTOM TOP=��� ���� ���� �� �����'#13+
'LEFT RIGHT=��� �������� ���� �� �����'#13+
'RIGHT LEFT=��� ����� ���� �� ��������'#13+
'FROM CENTER=��� �� ������'#13+
'FROM TOP LEFT=��� ���� ��������'#13+
'FROM BOTTOM LEFT=��� ���� ��������'#13+
'OK=�������'#13+
'CANCEL=�����'#13+
'COLORS=�������'#13+
'START=������'#13+
'MIDDLE=������'#13+
'END=�����'#13+
'SWAP=������������'#13+
'NO MIDDLE=����� ������'#13+
'TEEFONT EDITOR=������������ ��������������'#13+
'INTER-CHAR SPACING=������������ ����������'#13+
'FONT=������������'#13+
'SHADOW=����'#13+
'HORIZ. SIZE=��������� �������'#13+
'VERT. SIZE=������ �������'#13+
'COLOR=�����'#13+
'OUTLINE=����������'#13+
'OPTIONS=��������'#13+
'FORMAT=����������'#13+
'TEXT=������'#13+
'POSITION=����'#13+
'TOP=����'#13+
'AUTO=��������'#13+
'CUSTOM=�������'#13+ //////////////////////
'LEFT TOP=���� ��������'#13+
'LEFT BOTTOM=���� ��������'#13+
'RIGHT TOP=���� �����'#13+
'RIGHT BOTTOM=���� �����'#13+
'MULTIPLE AREAS=��������� ��������'#13+
'NONE=������'#13+
'STACKED=STACKED'#13+
'AREA=�������'#13+
'PATTERN=������'#13+
'STAIRS=����������'#13+
'SOLID=������'#13+
'CLEAR=����������'#13+
'HORIZONTAL=���������'#13+
'VERTICAL=������'#13+
'DIAGONAL=��������'#13+
'B.DIAGONAL=B.��������'#13+
'CROSS=�������'#13+
'DIAG.CROSS=��������� �������'#13+
'AREA LINES=������� ��������'#13+
'BORDER=����������'#13+
'INVERTED=����������'#13+
'INVERTED SCROLL=���������� ������'#13+
'COLOR EACH=��������� ����������'#13+
'ORIGIN=���������'#13+
'USE ORIGIN=����� ����������'#13+
'WIDTH=������'#13+
'HEIGHT=����'#13+
'AXIS=������'#13+
'LENGTH=�����'#13+
'SCROLL=������'#13+
'BOTH=��������'#13+
'AXIS INCREMENT=���������� �����'#13+
'INCREMENT=����������'#13+
'STANDARD=�������'#13+
'ONE MILLISECOND=��� �������� ��� ����.'#13+
'ONE SECOND=��� ������������'#13+
'FIVE SECONDS=����� �����������'#13+
'TEN SECONDS=���� �����������'#13+
'FIFTEEN SECONDS=��������� �����������'#13+
'THIRTY SECONDS=������� �����������'#13+
'ONE MINUTE=��� �����'#13+
'FIVE MINUTES=����� �����'#13+
'TEN MINUTES=���� �����'#13+
'FIFTEEN MINUTES=��������� �����'#13+
'THIRTY MINUTES=������� �����'#13+
'ONE HOUR=��� ���'#13+
'TWO HOURS=��� ����'#13+
'SIX HOURS=��� ����'#13+
'TWELVE HOURS=������ ����'#13+
'ONE DAY=��� �����'#13+
'TWO DAYS=��� ������'#13+
'THREE DAYS=����� ������'#13+
'ONE WEEK=��� ��������'#13+
'HALF MONTH=����� �����'#13+
'ONE MONTH=���� �����'#13+
'TWO MONTHS=��� �����'#13+
'THREE MONTHS=����� �����'#13+
'FOUR MONTHS=�������� �����'#13+
'SIX MONTHS=��� �����'#13+
'ONE YEAR=��� �����'#13+
'EXACT DATE TIME=������� ���������� ��� ���'#13+
'AXIS MAXIMUM AND MINIMUM=�������� & ������� �����'#13+
'VALUE=����'#13+
'TIME=���'#13+
'LEFT AXIS=��������� ������'#13+
'RIGHT AXIS=������ ������'#13+
'TOP AXIS=����� ������'#13+
'BOTTOM AXIS=���� ������'#13+
'% BAR WIDTH=������ % ������'#13+
'STYLE=�����'#13+
'% BAR OFFSET=���������� % ������'#13+
'RECTANGLE=���������'#13+
'PYRAMID=��������'#13+
'INVERT. PYRAMID=������� ��������'#13+
'CYLINDER=���������'#13+
'ELLIPSE=�������'#13+
'ARROW=�����'#13+
'RECT. GRADIENT=�������������� ��������� ���������'#13+
'CONE=�����'#13+
'DARK BAR 3D SIDES=���������� ������� 3� ������'#13+
'BAR SIDE MARGINS=��������� ������� ������'#13+
'AUTO MARK POSITION=�������� ������� �����'#13+ //////////////////
'JOIN=�����'#13+
'DATASET=DataSet'#13+
'APPLY=��������'#13+
'SOURCE=���������'#13+
'MONOCHROME=���������'#13+
'DEFAULT=����������'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=���������'#13+
'PATTERN COLOR EDITOR=������������ �������� �������'#13+
'IMAGE=������'#13+
'BACK DIAGONAL=�������� ����'#13+
'DIAGONAL CROSS=�������� ��������'#13+
'FILL 80%=������� 80%'#13+
'FILL 60%=������� 60%'#13+
'FILL 40%=������� 40%'#13+
'FILL 20%=������� 20%'#13+
'FILL 10%=������� 10%'#13+
'ZIG ZAG=Zig zag'#13+
'VERTICAL SMALL=������ �����'#13+
'HORIZ. SMALL=����. �����'#13+
'DIAG. SMALL=����. �����'#13+
'BACK DIAG. SMALL=����. ���� �����'#13+
'CROSS SMALL=����. �����'#13+
'DIAG. CROSS SMALL=����. �����. �����'#13+
'DAYS=������'#13+
'WEEKDAYS=������ ���������'#13+
'TODAY=������'#13+
'SUNDAY=�������'#13+
'TRAILING=��� �����'#13+
'MONTHS=�����'#13+
'LINES=�������'#13+
'SHOW WEEKDAYS=�������� ������ �����.'#13+
'UPPERCASE=��������'#13+
'TRAILING DAYS=��������� ������'#13+ //////////////////////////////////
'SHOW TODAY=�������� ��������� ������'#13+
'SHOW MONTHS=�������� �����'#13+
'SHOW PREVIOUS BUTTON=�������� �������� �����.'#13+
'SHOW NEXT BUTTON=�������� �������� ����.'#13+
'CANDLE WIDTH=����� �������'#13+
'STICK=�����'#13+
'BAR=������'#13+
'OPEN CLOSE=�������� �����������'#13+
'UP CLOSE=����������� ����������'#13+
'DOWN CLOSE=�������� ����������'#13+
'SHOW OPEN=�������� ��������'#13+
'SHOW CLOSE=�������� ��������'#13+
'DRAW 3D=���������� 3�'#13+
'DARK 3D=������ 3�'#13+
'EDITING=�����������'#13+
'CHART=�������'#13+
'SERIES=�����'#13+
'DATA=��������'#13+
'TOOLS=��������'#13+
'EXPORT=�������'#13+
'PRINT=��������'#13+
'GENERAL=�������'#13+  ////////////////////
'TITLES=������'#13+
'LEGEND=�������'#13+
'PANEL=�������'#13+
'PAGING=������������'#13+
'WALLS=������'#13+
'3D=3�'#13+
'ADD=��������'#13+
'DELETE=��������'#13+
'TITLE=������'#13+
'CLONE=���������'#13+
'CHANGE=������'#13+
'HELP=�������'#13+
'CLOSE=��������'#13+
'TEECHART PRINT PREVIEW=������������� ��������� TeeChart'#13+
'PRINTER=���������'#13+
'SETUP=���������'#13+
'ORIENTATION=���������������'#13+
'PORTRAIT=���������'#13+
'LANDSCAPE=������'#13+
'MARGINS (%)=��������� (%)'#13+
'DETAIL=����������'#13+
'MORE=�����������'#13+
'NORMAL=��������'#13+
'RESET MARGINS=��������� ����������'#13+
'VIEW MARGINS=�������� ����������'#13+
'PROPORTIONAL=���������'#13+
'CIRCLE=������'#13+
'VERTICAL LINE=������ ������'#13+
'HORIZ. LINE=��������� ������'#13+
'TRIANGLE=�������'#13+
'INVERT. TRIANGLE=������� �������'#13+
'LINE=������'#13+
'DIAMOND=��������'#13+
'CUBE=�����'#13+
'STAR=������'#13+
'TRANSPARENT=�������'#13+
'HORIZ. ALIGNMENT=��������� ������������'#13+ ///////////////////////////////////////////////////////
'LEFT=��������'#13+
'CENTER=������'#13+
'RIGHT=�����'#13+
'ROUND RECTANGLE=������������� ���������'#13+
'ALIGNMENT=������������'#13+
'BOTTOM=����'#13+
'UNITS=�������'#13+
'PIXELS=��������������'#13+
'AXIS ORIGIN=��������� �����'#13+//////////////////////////////////////////////////////////
'ROTATION=����������'#13+
'CIRCLED=�������'#13+
'3 DIMENSIONS=����� ����������'#13+
'RADIUS=������'#13+
'ANGLE INCREMENT=������ ������'#13+
'RADIUS INCREMENT=����� ������'#13+
'CLOSE CIRCLE=���������� ������'#13+
'PEN=�����'#13+
'LABELS=��������'#13+
'ROTATED=������������'#13+
'CLOCKWISE=�����������'#13+
'INSIDE=���������'#13+
'ROMAN=ROMAN'#13+
'HOURS=����'#13+
'MINUTES=�����'#13+
'SECONDS=������������'#13+
'START VALUE=���� ���������'#13+
'END VALUE=���� ������'#13+
'TRANSPARENCY=�������'#13+
'DRAW BEHIND=�������� ��� ����'#13+
'COLOR MODE=���� ��������'#13+
'STEPS=����������'#13+
'RANGE=���������'#13+
'PALETTE=�������'#13+
'PALE=�����'#13+
'STRONG=������'#13+
'GRID SIZE=������� ���������'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=�����'#13+
'IRREGULAR=����������'#13+
'GRID=������'#13+
'ALLOW DRAG=��������'#13+
'VERTICAL POSITION=������ ����'#13+
'LEVELS POSITION=���� ��������'#13+
'LEVELS=�������'#13+
'NUMBER=������'#13+
'LEVEL=�������'#13+
'AUTOMATIC=��������'#13+
'SNAP=SNAP'#13+
'FOLLOW MOUSE=���������� �� �������'#13+
'STACK=������'#13+
'HEIGHT 3D=���� 3�'#13+
'LINE MODE=���� �������'#13+
'OVERLAP=���������'#13+
'STACK 100%=������ 100%'#13+
'AVAILABLE=���������'#13+
'SELECTED=����������'#13+
'DATASOURCE=���� ���������'#13+
'GROUP BY=����������� ��'#13+
'CALC=�����������'#13+
'OF=���'#13+
'SUM=��������'#13+
'COUNT=�����������'#13+
'HIGH=�����'#13+
'LOW=������'#13+
'AVG=����� ����'#13+
'HOUR=���'#13+
'DAY=�����'#13+
'WEEK=��������'#13+
'WEEKDAY=����� ���������'#13+
'MONTH=�����'#13+
'QUARTER=��� �������'#13+
'YEAR=������'#13+
'HOLE %=��� %'#13+
'RESET POSITIONS=��������� ������'#13+
'MOUSE BUTTON=������ ��������'#13+
'ENABLE DRAWING=������������ ���������'#13+
'ENABLE SELECT=������������ ��������'#13+
'ENHANCED=�������������'#13+
'ERROR WIDTH=����� �����'#13+
'WIDTH UNITS=������� ������'#13+
'PERCENT=������� %'#13+
'LEFT AND RIGHT=�������� & �����'#13+
'TOP AND BOTTOM=���� & ����'#13+
'BORDER EDITOR=����. ������������'#13+
'DASH=�����'#13+
'DOT=������'#13+
'DASH DOT=����� ������'#13+
'DASH DOT DOT=����� ������ ������'#13+
'CALCULATE EVERY=����������� �������'#13+
'ALL POINTS=��� �� ������'#13+
'NUMBER OF POINTS=������� �������'#13+
'RANGE OF VALUES=��������� �����'#13+
'FIRST=�����'#13+
'LAST=���������'#13+
'TEEPREVIEW EDITOR=����. ��������. TEE'#13+
'ALLOW MOVE=�������� ����������'#13+
'ALLOW RESIZE=�������� ������ ��������'#13+
'DRAG IMAGE=���������� �������'#13+
'AS BITMAP=�� Bitmap'#13+
'SHOW IMAGE=�������� �������'#13+
'MARGINS=���������'#13+
'SIZE=�������'#13+
'3D %=3� %'#13+
'ZOOM=�������'#13+
'ELEVATION=�������'#13+
'100%=100%'#13+
'HORIZ. OFFSET=����. ����������'#13+
'VERT. OFFSET=���. ����������'#13+
'PERSPECTIVE=���������'#13+
'ANGLE=������'#13+
'ORTHOGONAL=���������'#13+
'ZOOM TEXT=������� ��������'#13+
'SCALES=���������'#13+
'TICKS=�������'#13+
'MINOR=��������'#13+
'MAXIMUM=�������'#13+
'MINIMUM=��������'#13+
'DESIRED INCREMENT=��������� ������'#13+ // OR ������
'(INCREMENT)=(������)'#13+
'LOG BASE=���� �����.'#13+
'LOGARITHMIC=�����������'#13+
'MIN. SEPARATION %=��������� ������. %'#13+
'MULTI-LINE=��������� �������'#13+
'LABEL ON AXIS=������� ���� �����'#13+
'ROUND FIRST=��������������� �����'#13+
'MARK=�������������'#13+
'LABELS FORMAT=����� ��������'#13+
'EXPONENTIAL=���������'#13+
'DEFAULT ALIGNMENT=�������������� ������������'#13+
'LEN=�����'#13+
'INNER=���'#13+
'AT LABELS ONLY=���� ���� ��������'#13+
'CENTERED=��� ������'#13+
'POSITION %=���� %'#13+
'START %=������ %'#13+
'END %=����� %'#13+
'OTHER SIDE=���� ������'#13+
'AXES=������'#13+
'BEHIND=��� ����'#13+
'CLIP POINTS=������� �������'#13+
'PRINT PREVIEW=������������� ���������'#13+
'MINIMUM PIXELS=�������� ��������������'#13+
'ALLOW=��������'#13+
'ANIMATED=���������'#13+
'ALLOW SCROLL=���������'#13+
'TEEOPENGL EDITOR=������������ TeeOpenGL'#13+
'AMBIENT LIGHT=���������� ���'#13+
'SHININESS=�����������'#13+
'FONT 3D DEPTH=����� ����. 3D'#13+
'ACTIVE=������'#13+
'FONT OUTLINES=���������� ����.'#13+
'SMOOTH SHADING=����� ������'#13+
'LIGHT=���'#13+
'Y=Y'#13+
'INTENSITY=������'#13+
'BEVEL=��������'#13+
'FRAME=�������'#13+
'ROUND FRAME=������������� �������'#13+
'LOWERED=����������'#13+
'RAISED=��������'#13+
'SYMBOLS=�������'#13+
'TEXT STYLE=����� ��������'#13+
'LEGEND STYLE=����� ��������.'#13+
'VERT. SPACING=������ �������'#13+
'SERIES NAMES=����� ������'#13+
'SERIES VALUES=����� ������'#13+
'LAST VALUES=��������� ����'#13+
'PLAIN=����'#13+
'LEFT VALUE=�������� ����'#13+
'RIGHT VALUE=����� ����'#13+
'LEFT PERCENT=�������� �������'#13+
'RIGHT PERCENT=���� �������'#13+
'X VALUE=���� X'#13+
'X AND VALUE=X & ����'#13+
'X AND PERCENT=X & �������'#13+
'DIVIDING LINES=�������� �������'#13+
'FONT SERIES COLOR=����� ����. ������'#13+
'POSITION OFFSET %=���������� ����� %'#13+
'MARGIN=���������'#13+
'RESIZE CHART=������ ���. ������.'#13+
'CONTINUOUS=�������'#13+
'POINTS PER PAGE=������ ��� ������'#13+
'SCALE LAST PAGE=��������� ������. �������'#13+
'CURRENT PAGE LEGEND=������� ����. ���.'#13+
'PANEL EDITOR=������������ ������'#13+
'BACKGROUND=��������'#13+
'BORDERS=����'#13+
'BACK IMAGE=������ ���������'#13+
'STRETCH=��������'#13+
'TILE=�������'#13+
'BEVEL INNER=����. ��������'#13+
'BEVEL OUTER=����. ��������'#13+
'MARKS=�������'#13+
'DATA SOURCE=���� ���������'#13+
'SORT=����������'#13+
'CURSOR=�������'#13+
'SHOW IN LEGEND=�������� ���� �������'#13+
'FORMATS=������'#13+
'VALUES=�����'#13+
'PERCENTS=�������'#13+
'HORIZONTAL AXIS=���������� ������'#13+
'DATETIME=���/��� & ���'#13+
'VERTICAL AXIS=������� ������'#13+
'ASCENDING=�������'#13+
'DESCENDING=��������'#13+
'DRAW EVERY=�������� ����'#13+
'CLIPPED=�����������'#13+
'ARROWS=����'#13+
'MULTI LINE=��������� �������'#13+
'ALL SERIES VISIBLE=������ ���� �� ������'#13+
'LABEL=��������'#13+
'LABEL AND PERCENT=������� & �������'#13+
'LABEL AND VALUE=������� & ����'#13+
'PERCENT TOTAL=������ �������'#13+
'LABEL AND PERCENT TOTAL=����� �������� ��� ��������'#13

{$IFDEF LCL}
;  TeeHellenicLanguage.Text:=TeeHellenicLanguage.Text
{$ENDIF}

+
'X AND Y VALUES=���� X & Y'#13+
'MANUAL=�����������'#13+
'RANDOM=������'#13+
'FUNCTION=���������'#13+
'NEW=���'#13+
'EDIT=�����������'#13+
'PERSISTENT=�������'#13+
'ADJUST FRAME=���������� ��������'#13+
'SUBTITLE=���������'#13+
'SUBFOOT=SUBFOOT'#13+
'FOOT=FOOT'#13+
'VISIBLE WALLS=����� ������'#13+
'BACK=����'#13+
'DIF. LIMIT=���� ����.'#13+
'ABOVE=���� ���'#13+
'WITHIN=���� ��'#13+
'BELOW=���� ���'#13+
'CONNECTING LINES=�������� �������'#13+
'BROWSE=���������'#13+
'TILED=����������'#13+
'INFLATE MARGINS=�������� ����������'#13+
'ROUND=���������������'#13+
'SQUARE=���������'#13+
'FLAT=�������'+#13+
'DOWN TRIANGLE=������� �������'#13+
'SMALL DOT=����� ������'#13+
'GLOBAL=������'#13+
'SHAPES=�������'#13+
'BRUSH=�������'#13+
'MOVE=����������'#13+
'DRAW LINE=�������� �������'#13+
'BELOW %=���� ��� %'#13+
'BELOW VALUE=���������� �����'#13+
'OTHER=����'#13+
'PATTERNS=������'#13+
'SIZE %=������� %'#13+
'FIELDS=�����'#13+
'NUMBER OF HEADER LINES=������� ������� ������.'#13+
'SEPARATOR=������������'#13+
'COMMA=�����'#13+
'SPACE=����'#13+
'FILE=������'#13+
'WEB URL=��������� ����������(URL)'#13+
'LOAD=�������'#13+
'C LABELS=�������� C'#13+
'R LABELS=�������� R'#13+
'C PEN=����� C'#13+
'R PEN=����� R'#13+
'STACK GROUP=����� �������'#13+
'MULTIPLE BAR=��������� ������'#13+
'SIDE=������'#13+
'STACKED 100%=����������� 100%'#13+
'SIDE ALL=������ ���'#13+
'DRAWING MODE=���� ���������'#13+
'WIREFRAME=������ �������'#13+
'DOTFRAME=������ ��������'#13+
'SMOOTH PALETTE=����� ������'#13+
'SIDE BRUSH=������ �������'#13+
'ABOUT TEECHART PRO V7.0=����������� ��� TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'VISIT OUR WEB SITE !=������������ ��� ���������� ���!'#13+
'SELECT A CHART STYLE=������� ������ ����������'#13+
'DATABASE CHART=������� �� ���� ���������'#13+
'NON DATABASE CHART=������� ����� ���� ���������'#13+
'SELECT A DATABASE TABLE=������� ������ �����.'#13+
'ALIAS=���������'#13+
'TABLE=�������'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=�������� �� ��������� �����'#13+
'SELECT A TEXT LABELS FIELD=�������� ����� ��� ��� �������'#13+
'CHOOSE THE DESIRED CHART TYPE=�������� ��� ��������� ���� ����������'#13+
'2D=2�'#13+
'CHART PREVIEW=������������� ����������'#13+
'SHOW LEGEND=��������� ��������'#13+
'SHOW MARKS=�������� �������'#13+
'< BACK=< �����������'#13+
'PICTURE=������'#13+
'NATIVE=������ Tee'#13+
'KEEP ASPECT RATIO=��������� ����������'#13+
'INCLUDE SERIES DATA=���������� ��������� ������'#13+
'FILE SIZE=������� �������'#13+
'DELIMITER=������������'#13+
'XML=XML'#13+
'HTML TABLE=������� HTML'#13+
'EXCEL=Excel'#13+
'COLON=��� ���� ������'#13+
'INCLUDE=����������'#13+
'POINT LABELS=�������� �������'#13+
'POINT INDEX=������� �������'#13+
'HEADER=�����������'#13+
'COPY=���������'#13+
'SAVE=����������'#13+
'SEND=��������'#13+
'FUNCTIONS=�����������'#13+
'ADX=ADX'#13+
'AVERAGE=����� ����'#13+
'BOLLINGER=Bollinger'#13+
'DIVIDE=��������'#13+
'EXP. AVERAGE=���� ��� Exp.'#13+
'EXP.MOV.AVRG.=������ ���� ��� Exp.'#13+
'MACD=MACD'#13+
'R.S.I.=R.S.I.'#13+
'SOURCE SERIES=����� ����'#13+
'COMPRESSION=��������'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows ����'#13+
'GRAY SCALE=���������� ��� ����'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'PERFORMANCE=�������'#13+
'QUALITY=��������'#13+
'SPEED=��������'#13+
'COMPRESSION LEVEL=������� ���������'#13+
'AXIS ARROWS=���� ������'#13+
'ROTATE=����������'#13+
'YES=���'#13+
'SHOW PAGE NUMBER=�������� ������� �������'#13+
'PAGE NUMBER=������� �������'#13+
'PAGE %D OF %D=������ %d ��� %d'#13+
'TEECHART LANGUAGES=������� ��� TeeChart'#13+
'CHOOSE A LANGUAGE=������� �������'+#13+
'SELECT ALL=������� ����'#13+
'DRAW ALL=�������� ����'#13+
'TEXT FILE=������ ��������'#13+
'IMAG. SYMBOL=������� �����.'#13+
'MSEC.=msec.'#13+

// Pending:

'CHECK BOXES=Check boxes'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'CLICKABLE=Clickable'#13+
'WHISKER=Whisker'#13+
'DELAY=Delay'#13+
'MOUSE ACTION=Mouse Action'#13+
'EXPLODE BIGGEST=Explode Biggest'#13+
'TOTAL ANGLE=Total Angle'#13+
'GROUP SLICES=Group Slices'#13+
'SERIES DATASOURCE TEXT EDITOR=Series DataSource Text Editor'#13+
'TEECHART WIZARD=TeeChart Wizard'#13+
'CLICK=Click'#13+
'EXPORT CHART=Export Chart'#13+
'TAB=Tab'#13+
'MOMENTUM=Momentum'#13+
'MOMENTUM DIV=Momentum Div.'#13+
'MOVING AVRG.=Moving Avrg.'#13+
'MULTIPLY=Multiply'#13+
'ROOT MEAN SQ.=Root Mean Sq.'#13+
'STD.DEVIATION=Std. Deviation'#13+
'STOCHASTIC=Stochastic'#13+
'SUBTRACT=Subtract'#13+
'TEECHART GALLERY=TeeChart Gallery'#13+
'DITHER=Dither'#13+
'REDUCTION=Reduction'#13+
'NEAREST=Nearest'#13+
'% QUALITY=% Quality'#13+
'PERIOD=Period'#13+
'UP=Up'#13+
'DOWN=Down'#13+
'COLOR BAND=Color Band'#13+
'COLOR LINE=Color Line'#13+
'DRAG MARKS=Drag Marks'#13+
'MARK TIPS=Mark Tips'#13+
'NEAREST POINT=Nearest Point'#13+
'CHART TOOLS GALLERY=Chart Tools Gallery'#13+
'ANNOTATION=Annotation'#13+
'DRAG REPAINT=Drag repaint'#13+
'NO LIMIT DRAG=No limit drag'#13+
'PREVIEW=Preview'#13+
'SHADOW EDITOR=Shadow editor'#13+
'CALLOUT=Callout'#13+
'TEXT ALIGNMENT=Text alignment'#13+
'DISTANCE=Distance'#13+
'ARROW HEAD=Arrow head'#13+
'POINTER=Pointer'#13+
'AVAILABLE LANGUAGES=Available languages'#13+
'CALCULATE USING=Calculate using'#13+
'EVERY NUMBER OF POINTS=Every number of points'#13+
'EVERY RANGE=Every range'#13+
'INCLUDE NULL VALUES=Include null values'#13+
'DATE=Date'#13+
'ENTER DATE=Enter Date'#13+
'ENTER TIME=Enter Time'#13+
'BEVEL SIZE=Bevel size'#13+
'DEVIATION=Deviation'#13+
'UPPER=Upper'#13+
'LOWER=Lower'#13+
'NOTHING=Nothing'#13+
'LEFT TRIANGLE=Left triangle'#13+
'RIGHT TRIANGLE=Right triangle'#13+
'CONSTANT=Constant'#13+
'SHOW LABELS=Show labels'#13+
'SHOW COLORS=Show colors'#13+
'XYZ SERIES=XYZ series'#13+
'SHOW X VALUES=Show X values'#13+
'DELETE ROW=Delete row'#13+
'VOLUME SERIES=Volume series'#13+
'ACCUMULATE=Accumulate'#13+
'SINGLE=Single'#13+
'REMOVE CUSTOM COLORS=Remove custom colors'#13+
'STEP=Step'#13+
'USE PALETTE MINIMUM=Use palette minimum'#13+
'AXIS MAXIMUM=Axis maximum'#13+
'AXIS CENTER=Axis center'#13+
'AXIS MINIMUM=Axis minimum'#13+
'DAILY (NONE)=Daily (none)'#13+
'WEEKLY=Weekly'#13+
'MONTHLY=Monthly'#13+
'BI-MONTHLY=Bi-Monthly'#13+
'QUARTERLY=Quarterly'#13+
'YEARLY=Yearly'#13+
'DATETIME PERIOD=Datetime period'#13+
'ARROW FROM=Arrow from'#13+
'ARROW TO=Arrow to'#13+
'POINTS=Points'#13+
'SIDES=Sides'#13+
'INVERTED SIDES=Inverted sides'#13+
'CURVE=Curve'#13+
'POINT=Point'#13+
'COLOR EACH LINE=Color each line'#13+
'CASE SENSITIVE=Case sensitive'#13+
'SORT BY=Sort by'#13+
'CALCULATION=Calculation'#13+
'DRAG STYLE=Drag style'#13+
'WEIGHT=Weight'#13+
'EDIT LEGEND=Edit legend'#13+
'IGNORE NULLS=Ignore nulls'#13+
'OFFSET=Offset'#13+
'LIGHT 0=Light 0'#13+
'LIGHT 1=Light 1'#13+
'LIGHT 2=Light 2'#13+
'DRAW STYLE=Draw style'#13+
'DEFAULT BORDER=Default border'#13+
'SQUARED=Squared'#13+
'SEPARATION=Separation'#13+
'ROUND BORDER=Round border'#13+
'NUMBER OF SAMPLE VALUES=Number of sample values'#13+
'SPACING=Spacing'#13+
'TRANSP=Transp'#13+
'HORIZ.=Horiz.'#13+
'VERT.=Vert.'#13+
'RESIZE PIXELS TOLERANCE=Resize pixels tolerance'#13+
'FULL REPAINT=Full repaint'#13+
'END POINT=End point'#13+
'BAND 1=Band 1'#13+
'BAND 2=Band 2'#13+
'GRID 3D SERIES=Grid 3D Series'#13+
'TRANSPOSE NOW=Transpose now'#13+
'PERIOD 1=Period 1'#13+
'PERIOD 2=Period 2'#13+
'PERIOD 3=Period 3'#13+
'HISTOGRAM=Histogram'#13+
'EXP. LINE=Exp. Line'#13+
'DRAG TO RESIZE=Drag to resize'#13+
'MOVE UP=Move Up'#13+
'MOVE DOWN=Move Down'#13+
'SERIES MARKS=Series Marks'#13+
'WALL=Wall'#13+
'TEXT LABELS=Text Labels'#13+
'SMOOTH=Smooth'#13+
'INTERPOLATE=Interpolate'#13+
'START X=Start X'#13+
'NUM. POINTS=Num. Points'#13+
'(NONE)=(none)'#13+
'WEIGHTED=Weighted'#13+
'WEIGHTED BY INDEX=Weighted by index'#13+
'DARK BORDER=Dark border'#13+
'PIE SERIES=Pie series'#13+
'FOCUS=Focus'#13+
'BOX SIZE=Box size'#13+
'REVERSAL AMOUNT=Reversal amount'#13+
'PERCENTAGE=Percentage'#13+
'COMPLETE R.M.S.=Complete R.M.S.'#13+
'BUTTON=Button'#13+
'START AT MIN. VALUE=Start at min. value'#13+
'EXECUTE !=Execute !'#13+
'FACTOR=Factor'#13+
'SELF STACK=Self stack'#13+
'SIDE LINES=Side lines'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=Chart from template (*.tee file)'#13+
'OPEN TEECHART TEMPLATE FILE FROM=Open TeeChart template file from'#13+
'COVER=Cover'#13+
'ARROW WIDTH=Arrow Width'#13+
'ARROW HEIGHT=Arrow Height'#13+
'DEFAULT COLOR=Default color'#13+
'VALUE SOURCE=Value source'#13+
'BALANCE=Balance'#13+
'RADIAL OFFSET=Radial Offset'#13+
'RADIAL=Radial'#13+
'EXPORT DIALOG=Export dialog'#13+
'BINARY=Binary'#13+
'POINT COLORS=Point colors'#13+
'OUTLINE GRADIENT=Outline gradient'

;
  end;
end;

Procedure TeeSetHellenic;
begin
  TeeCreateHellenic;
  TeeLanguage:=TeeHellenicLanguage;
  TeeHellenicConstants;
  TeeLanguageHotKeyAtEnd:=False;
  TeeLanguageCanUpper:=True;
end;


initialization
finalization
  FreeAndNil(TeeHellenicLanguage);
end.
