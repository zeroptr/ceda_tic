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
  TeeMsg_LegendFirstValue   :='第一个图例值必须大于 0';
  TeeMsg_LegendColorWidth   :='图例的颜色宽度必须大于 0%';
  TeeMsg_SeriesSetDataSource:='没有主图表来确认资料来源';
  TeeMsg_SeriesInvDataSource:='不正确的资料来源: %s';
  TeeMsg_FillSample         :='FillSampleValues 的 NumValues 必须大于 0';
  TeeMsg_AxisLogDateTime    :='日期时间的轴不能是对数';
  TeeMsg_AxisLogNotPositive :='对数轴的最大最小值必须大于或等于 0';
  TeeMsg_AxisLabelSep       :='卷标的间隔百分比必须大于 0';
  TeeMsg_AxisIncrementNeg   :='轴的递增值必须大于或等于 0';
  TeeMsg_AxisMinMax         :='轴的最小值必须小于或等于最大值';
  TeeMsg_AxisMaxMin         :='轴的最大值必须大于或等于最小值';
  TeeMsg_AxisLogBase        :='轴的对数基数必须大于或等于 2';
  TeeMsg_MaxPointsPerPage   :='每页的总标点数必须大于或等于 0';
  TeeMsg_3dPercent          :='3D 效果的百分比必须位于 %d 到 %d 之间';
  TeeMsg_CircularSeries     :='圈形的序列不可有循环相关性';
  TeeMsg_WarningHiColor     :='需要 16k 或以上的色彩来得到良好的效果';

  TeeMsg_DefaultPercentOf   :='%s 之 %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'之 %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';
  TeeMsg_AxisTitle          :='轴的标题';
  TeeMsg_AxisLabels         :='轴的卷标';
  TeeMsg_RefreshInterval    :='更新时间必须位于 0 到 60 之间';
  TeeMsg_SeriesParentNoSelf :='Series.ParentChart 不是自己!';
  TeeMsg_GalleryLine        :='线条图';
  TeeMsg_GalleryPoint       :='标点';
  TeeMsg_GalleryArea        :='面积图';
  TeeMsg_GalleryBar         :='棒形图';
  TeeMsg_GalleryHorizBar    :='横向棒形图';
  TeeMsg_Stack              :='堆迭图';
  TeeMsg_GalleryPie         :='图形图';
  TeeMsg_GalleryCircled     :='圆圈';
  TeeMsg_GalleryFastLine    :='快速线条图';
  TeeMsg_GalleryHorizLine   :='并行线条图';

  TeeMsg_PieSample1         :='汽车';
  TeeMsg_PieSample2         :='电话';
  TeeMsg_PieSample3         :='桌子';
  TeeMsg_PieSample4         :='显示器';
  TeeMsg_PieSample5         :='台灯';
  TeeMsg_PieSample6         :='键盘';
  TeeMsg_PieSample7         :='脚踏车';
  TeeMsg_PieSample8         :='椅子';

  TeeMsg_GalleryLogoFont    :='新细明体';
  TeeMsg_Editing            :='编辑 %s';

  TeeMsg_GalleryStandard    :='标准';
  TeeMsg_GalleryExtended    :='延伸';
  TeeMsg_GalleryFunctions   :='函数';

  TeeMsg_EditChart          :='编辑图表(&D)...';
  TeeMsg_PrintPreview       :='预览打印(&P)...';
  TeeMsg_ExportChart        :='汇出图表(&X)...';
  TeeMsg_CustomAxes         :='自定轴...';

  TeeMsg_InvalidEditorClass :='%s: 不正确的编辑器对象: %s';
  TeeMsg_MissingEditorClass :='%s: 没有编辑对话窗口';

  TeeMsg_GalleryArrow       :='箭头';

  TeeMsg_ExpFinish          :='完成(&F)';
  TeeMsg_ExpNext            :='下一步(&N) >';

  TeeMsg_GalleryGantt       :='进度图(甘特)';

  TeeMsg_GanttSample1       :='设计';
  TeeMsg_GanttSample2       :='制作样品';
  TeeMsg_GanttSample3       :='开发';
  TeeMsg_GanttSample4       :='销售';
  TeeMsg_GanttSample5       :='开发巿场';
  TeeMsg_GanttSample6       :='测试';
  TeeMsg_GanttSample7       :='生产';
  TeeMsg_GanttSample8       :='除错';
  TeeMsg_GanttSample9       :='新版本';
  TeeMsg_GanttSample10      :='银行服务';

  TeeMsg_ChangeSeriesTitle  :='变更序列的标题';
  TeeMsg_NewSeriesTitle     :='新的序列标题:';
  TeeMsg_DateTime           :='日期时间';
  TeeMsg_TopAxis            :='上轴';
  TeeMsg_BottomAxis         :='下轴';
  TeeMsg_LeftAxis           :='左轴';
  TeeMsg_RightAxis          :='右轴';

  TeeMsg_SureToDelete       :='移除 %s ?';
  TeeMsg_DateTimeFormat     :='日期时间格式(&M):';
  TeeMsg_Default            :='预设';
  TeeMsg_ValuesFormat       :='数值格式(&M):';
  TeeMsg_Maximum            :='最大';
  TeeMsg_Minimum            :='最小';
  TeeMsg_DesiredIncrement   :='需求的 %s 递增';

  TeeMsg_IncorrectMaxMinValue:='错误数值。原因：%s';
  TeeMsg_EnterDateTime      :='输入 [总天数] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='套用变更?';
  TeeMsg_SelectedSeries     :='(已选的序列)';
  TeeMsg_RefreshData        :='更新资料(&R)';

  TeeMsg_DefaultFontSize    :={$IFDEF LINUX}'10'{$ELSE}'8'{$ENDIF};
  TeeMsg_FunctionAdd        :='加';
  TeeMsg_FunctionSubtract   :='减';
  TeeMsg_FunctionMultiply   :='乘';
  TeeMsg_FunctionDivide     :='除';
  TeeMsg_FunctionHigh       :='最高值';
  TeeMsg_FunctionLow        :='最低值';
  TeeMsg_FunctionAverage    :='平均';

  TeeMsg_GalleryShape       :='形状图';
  TeeMsg_GalleryBubble      :='泡泡图';
  TeeMsg_FunctionNone       :='复制';

  TeeMsg_None               :='(无)';

  TeeMsg_PrivateDeclarations:='{ Private 宣告 }';
  TeeMsg_PublicDeclarations :='{ Public 宣告 }';

  TeeMsg_DefaultFontName    :=TeeMsg_DefaultEngFontName;

  TeeMsg_CheckPointerSize   :='指针大小必须大于零';
  TeeMsg_About              :='有关 TeeChart(&U)...';

  TeeMsg_DataSet            :='资料组';
  TeeMsg_AskDataSet         :='资料组(&D):';

  TeeMsg_SingleRecord       :='单笔资料';
  TeeMsg_AskDataSource      :='资料来源(&D):';

  TeeMsg_Summary            :='摘要';

  TeeMsg_FunctionPeriod     :='函数的周期值必须大于或等于零';

  TeeMsg_ClearImage         :='清除(&r)';
  TeeMsg_BrowseImage        :='浏览(&R)...';

  TeeMsg_WizardSureToClose  :='确定要关闭 TeeChart 精灵？';
  TeeMsg_FieldNotFound      :='字段 %s 不存在';

  TeeMsg_DepthAxis          :='深度轴';
  TeeMsg_PieOther           :='其它';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='饼状';
  TeeMsg_ValuesBar          :='长条';
  TeeMsg_ValuesAngle        :='角度';
  TeeMsg_ValuesGanttStart   :='开始';
  TeeMsg_ValuesGanttEnd     :='结束';
  TeeMsg_ValuesGanttNextTask:='下个工作';
  TeeMsg_ValuesBubbleRadius :='半径';
  TeeMsg_ValuesArrowEndX    :='结束X';
  TeeMsg_ValuesArrowEndY    :='结束Y';
  TeeMsg_Legend             :='图例';
  TeeMsg_Title              :='标题';
  TeeMsg_Foot               :='标尾';
  TeeMsg_Period		    :='周期';
  TeeMsg_PeriodRange        :='周期的范围';
  TeeMsg_CalcPeriod         :='计算 %s 于每个:';
  TeeMsg_SmallDotsPen       :='小点';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' 档案的图表不正确';
  TeeMsg_WrongTeeFileFormat :='*.'+TeeMsg_TeeExtension+' 档案格式错误';
  TeeMsg_EmptyTeeFile       :='空白的 *.'+TeeMsg_TeeExtension+' 档案';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   :='图表轴';
  TeeMsg_ChartAxesCategoryDesc   :='图表轴的属性与事件';
  TeeMsg_ChartWallsCategoryName  :='图表壁板';
  TeeMsg_ChartWallsCategoryDesc  :='图表壁板的属性与事件';
  TeeMsg_ChartTitlesCategoryName :='图表标题';
  TeeMsg_ChartTitlesCategoryDesc :='图表标题的属性与事件';
  TeeMsg_Chart3DCategoryName     :='3D 图表';
  TeeMsg_Chart3DCategoryDesc     :='3D 图表的属性与事件';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       :='自定 ';
  TeeMsg_Series                 :='序列';
  TeeMsg_SeriesList             :='序列...';

  TeeMsg_PageOfPages            :='第 %d页,共 %d页';
  TeeMsg_FileSize               :='%d 个字节';

  TeeMsg_First  :='最初';
  TeeMsg_Prior  :='之前';
  TeeMsg_Next   :='之后';
  TeeMsg_Last   :='最后';
  TeeMsg_Insert :='插入';
  TeeMsg_Delete :='移除';
  TeeMsg_Edit   :='编辑';
  TeeMsg_Post   :='传寄';
  TeeMsg_Cancel :='取消';

  TeeMsg_All    :='(全部)';
  TeeMsg_Index  :='索引';
  TeeMsg_Text   :='文字';

  TeeMsg_AsBMP        :='位图(&B)';
  TeeMsg_BMPFilter    :='位图档 (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='&Metafile';
  TeeMsg_EMFFilter    :='Enhanced Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet :='汇出格式中未有设定面板属性';

  TeeMsg_Normal    :='正常';
  TeeMsg_NoBorder  :='无边缘';
  TeeMsg_Dotted    :='点线';
  TeeMsg_Colors    :='颜色';
  TeeMsg_Filled    :='填满';
  TeeMsg_Marks     :='标志';
  TeeMsg_Stairs    :='阶梯';
  TeeMsg_Points    :='标点';
  TeeMsg_Height    :='高度';
  TeeMsg_Hollow    :='空心';
  TeeMsg_Point2D   :='2D 标点';
  TeeMsg_Triangle  :='三角形';
  TeeMsg_Star      :='星形';
  TeeMsg_Circle    :='圆形';
  TeeMsg_DownTri   :='反三角形';
  TeeMsg_Cross     :='十字形';
  TeeMsg_Diamond   :='菱形';
  TeeMsg_NoLines   :='无线条';
  TeeMsg_Stack100  :='堆积 100%';
  TeeMsg_Pyramid   :='角锥形';
  TeeMsg_Ellipse   :='椭圆形';
  TeeMsg_InvPyramid:='反角锥形';
  TeeMsg_Sides     :='侧边';
  TeeMsg_SideAll   :='全部侧边';
  TeeMsg_Patterns  :='样式';
  TeeMsg_Exploded  :='爆出';
  TeeMsg_Shadow    :='阴影';
  TeeMsg_SemiPie   :='半饼状';
  TeeMsg_Rectangle :='矩形';
  TeeMsg_VertLine  :='直线';
  TeeMsg_HorizLine :='横线';
  TeeMsg_Line      :='线条';
  TeeMsg_Cube      :='立方体';
  TeeMsg_DiagCross :='叉形';

  TeeMsg_CanNotFindTempPath    :='无法找到 Temp 资料夹';
  TeeMsg_CanNotCreateTempChart :='无法开新临时文件';
  TeeMsg_CanNotEmailChart      :='无法以电子邮件传送 TeeChart。Mapi 错误：%d';

  TeeMsg_SeriesDelete :='移除序列：ValueIndex %d 超出范围 (0 到 %d).';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='极线图';
  TeeMsg_GalleryCandle      :='烛光图';
  TeeMsg_GalleryVolume      :='容量图';
  TeeMsg_GallerySurface     :='表面图';
  TeeMsg_GalleryContour     :='轮廓图';
  TeeMsg_GalleryBezier      :='Bezier图';
  TeeMsg_GalleryPoint3D     :='3D标点图';
  TeeMsg_GalleryRadar       :='雷达图';
  TeeMsg_GalleryDonut       :='环状图';
  TeeMsg_GalleryCursor      :='光标图';
  TeeMsg_GalleryBar3D       :='3D长条图';
  TeeMsg_GalleryBigCandle   :='大烛光图';
  TeeMsg_GalleryLinePoint   :='标点线图';
  TeeMsg_GalleryHistogram   :='直方图';
  TeeMsg_GalleryWaterFall   :='瀑布图';
  TeeMsg_GalleryWindRose    :='风向图';
  TeeMsg_GalleryClock       :='失量圆图';
  TeeMsg_GalleryColorGrid   :='彩色格图';
  TeeMsg_GalleryBoxPlot     :='标盒图';
  TeeMsg_GalleryHorizBoxPlot:='横标盒图';
  TeeMsg_GalleryBarJoin     :='长条连接图';
  TeeMsg_GallerySmith       :='史密斯图';
  TeeMsg_GalleryPyramid     :='角锥图';
  TeeMsg_GalleryMap         :='地图';

  TeeMsg_PolyDegreeRange    :='Polynomial degree 必须位于 1 到 20 之间';
  TeeMsg_AnswerVectorIndex   :='Answer Vector 索引值必须位于 1 到 %d 之间';
  TeeMsg_FittingError        :='无法对位';
  TeeMsg_PeriodRange         :='周期必须大于或等于零';
  TeeMsg_ExpAverageWeight    :='ExpAverage Weight 必须位于 0 到 1 之间';
  TeeMsg_GalleryErrorBar     :='误差条图';
  TeeMsg_GalleryError        :='误差图';
  TeeMsg_GalleryHighLow      :='高低图';
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

  TeeMsg_FunctionCount       :='数量';
  TeeMsg_LoadChart           :='开启 TeeChart...';
  TeeMsg_SaveChart           :='储存 TeeChart...';
  TeeMsg_TeeFiles            :='TeeChart Pro 档案';

  TeeMsg_GallerySamples      :='其它';
  TeeMsg_GalleryStats        :='统计';

  TeeMsg_CannotFindEditor    :='无法找到序列的编辑窗口: %s';


  TeeMsg_CannotLoadChartFromURL:='错误码: %d 从以下网址下载图表: %s';
  TeeMsg_CannotLoadSeriesDataFromURL:='错误码: %d 从以下网址下载序列资料: %s';

  TeeMsg_Test                :='测试...';

  TeeMsg_ValuesDate          :='日期';
  TeeMsg_ValuesOpen          :='开启';
  TeeMsg_ValuesHigh          :='高';
  TeeMsg_ValuesLow           :='低';
  TeeMsg_ValuesClose         :='关闭';
  TeeMsg_ValuesOffset        :='偏移';
  TeeMsg_ValuesStdError      :='标准误差';

  TeeMsg_Grid3D              :='3D表格';

  TeeMsg_LowBezierPoints     :='Bezier的点数必须大于 1';

  { TeeCommander component... }

  TeeCommanMsg_Normal   :='正常';
  TeeCommanMsg_Edit     :='编辑';
  TeeCommanMsg_Print    :='打印';
  TeeCommanMsg_Copy     :='复制';
  TeeCommanMsg_Save     :='储存';
  TeeCommanMsg_3D       :='3D';

  TeeCommanMsg_Rotating :='旋转: %d?上升幅度: %d?';
  TeeCommanMsg_Rotate   :='旋转';

  TeeCommanMsg_Moving   :='水平偏移: %d 垂直偏移: %d';
  TeeCommanMsg_Move     :='移动';

  TeeCommanMsg_Zooming  :='缩放: %d %%';
  TeeCommanMsg_Zoom     :='缩放';

  TeeCommanMsg_Depthing :='3D: %d %%';
  TeeCommanMsg_Depth    :='深度';

  TeeCommanMsg_Chart    :='图表';
  TeeCommanMsg_Panel    :='面板';

  TeeCommanMsg_RotateLabel:='拖曳 %s 来旋转';
  TeeCommanMsg_MoveLabel  :='拖曳 %s 来移动';
  TeeCommanMsg_ZoomLabel  :='拖曳 %s 来缩放';
  TeeCommanMsg_DepthLabel :='拖曳 %s 来变更 3D 大小';

  TeeCommanMsg_NormalLabel:='拖曳左键来缩放, 右键来转动';
  TeeCommanMsg_NormalPieLabel:='拖曳饼状内的片块来将它分解';

  TeeCommanMsg_PieExploding :='片块: %d 分解: %d %%';

  TeeMsg_TriSurfaceLess:='标点数量必须大于或等于 4';
  TeeMsg_TriSurfaceAllColinear:='全部共同性资料的标点';
  TeeMsg_TriSurfaceSimilar:='相近点 - 无法执行';
  TeeMsg_GalleryTriSurface:='三角面';

  TeeMsg_AllSeries :='全部序列';
  TeeMsg_Edit      :='编辑';

  TeeMsg_GalleryFinancial    :='财经';

  TeeMsg_CursorTool    :='指针';
  TeeMsg_DragMarksTool :='拖曳标志';
  TeeMsg_AxisArrowTool :='轴箭头';
  TeeMsg_DrawLineTool  :='画线';
  TeeMsg_NearestTool   :='最近点';
  TeeMsg_ColorBandTool :='颜色带';
  TeeMsg_ColorLineTool :='颜色线';
  TeeMsg_RotateTool    :='旋转';
  TeeMsg_ImageTool     :='图案';
  TeeMsg_MarksTipTool  :='标志说明';

  TeeMsg_CantDeleteAncestor  :='无法移除原始对象';

  TeeMsg_Load	         :='读取...';
  TeeMsg_NoSeriesSelected:='并未选取任何序列';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  :='图表';
  TeeMsg_CategorySeriesActions :='图表的序列';

  TeeMsg_Action3D               :='&3D';
  TeeMsg_Action3DHint           :='切换 2D / 3D';
  TeeMsg_ActionSeriesActive     :='起动(&A)';
  TeeMsg_ActionSeriesActiveHint :='显示 / 隐藏 序列';
  TeeMsg_ActionEditHint         :='编辑图表';
  TeeMsg_ActionEdit             :='编辑(&E)...';
  TeeMsg_ActionCopyHint         :='复制到剪贴簿';
  TeeMsg_ActionCopy             :='复制(&C)';
  TeeMsg_ActionPrintHint        :='预览打印图表';
  TeeMsg_ActionPrint            :='打印(&P)...';
  TeeMsg_ActionAxesHint         :='显示 / 隐藏 轴';
  TeeMsg_ActionAxes             :='轴(&A)';
  TeeMsg_ActionGridsHint        :='显示 / 隐藏 表格';
  TeeMsg_ActionGrids            :='表格(&G)';
  TeeMsg_ActionLegendHint       :='显示 / 隐藏 图例';
  TeeMsg_ActionLegend           :='图例(&L)';
  TeeMsg_ActionSeriesEditHint   :='编辑图例';
  TeeMsg_ActionSeriesMarksHint  :='显示 / 隐藏 序列标志';
  TeeMsg_ActionSeriesMarks      :='标志(&M)';
  TeeMsg_ActionSaveHint         :='储存图表';
  TeeMsg_ActionSave             :='储存(&S)...';

  TeeMsg_CandleBar              :='长条';
  TeeMsg_CandleNoOpen           :='无开启';
  TeeMsg_CandleNoClose          :='无关闭';
  TeeMsg_NoLines                :='无线条';
  TeeMsg_NoHigh                 :='无高';
  TeeMsg_NoLow                  :='无低';
  TeeMsg_ColorRange             :='颜色范围';
  TeeMsg_WireFrame              :='框架线';
  TeeMsg_DotFrame               :='框架点';
  TeeMsg_Positions              :='位置';
  TeeMsg_NoGrid                 :='无表格';
  TeeMsg_NoPoint                :='无标点';
  TeeMsg_NoLine                 :='无线条';
  TeeMsg_Labels                 :='卷标';
  TeeMsg_NoCircle               :='无圆圈';
  TeeMsg_Lines                  :='线条';
  TeeMsg_Border                 :='边缘';

  TeeMsg_SmithResistance      :='阻力';
  TeeMsg_SmithReactance       :='力抗';
  
  TeeMsg_Column               :='字段';

  { 5.01 }
  TeeMsg_Separator            :='分隔符';
  TeeMsg_FunnelSegment        :='片段 ';
  TeeMsg_FunnelSeries         :='漏斗图';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='超出限额';
  TeeMsg_FunnelWithin         :=' 在限额之内';
  TeeMsg_FunnelBelow          :=' 或更低于限额';
  TeeMsg_CalendarSeries       :='月历';
  TeeMsg_DeltaPointSeries     :='三脚标点(Delta)';
  TeeMsg_ImagePointSeries     :='图案标点';
  TeeMsg_ImageBarSeries       :='图案长条';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Field index 必须大须 0';

  TeeMsg_Yes    :='是';
  TeeMsg_No    :='否';

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

  TeeMsg_SubTitle           :='副标题';
  TeeMsg_SubFoot            :='副标尾';
  TeeMsg_DepthTopAxis       :='左轴顶';
  TeeMsg_Themes             :='主题样式';
  TeeMsg_SelectorTool       :='选择样式';

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

'GRADIENT EDITOR=渐彩编辑器'#13+
'SHADOW EDITOR=阴影编辑器'#13+
'GRADIENT=渐彩'#13+
'AUTO SIZE=自动缩放'#13+
'VIEW 3D=3D显示'#13+
'YES=是'#13+
'WHITE=白'#13+
'COLOR EACH POINT=颜色各异'#13+
'DIRECTION=方向'#13+
'VISIBLE=显示'#13+
'TOP BOTTOM=上至下'#13+
'BOTTOM TOP=下至上'#13+
'LEFT RIGHT=左至右'#13+
'RIGHT LEFT=右至左'#13+
'FROM CENTER=从中央'#13+
'FROM TOP LEFT=从左上'#13+
'FROM BOTTOM LEFT=从左下'#13+
'OK=确定'#13+
'CANCEL=取消'#13+
'COLORS=颜色'#13+
'START=开始'#13+
'MIDDLE=中间'#13+
'END=结束'#13+
'SWAP=替换'#13+
'NO MIDDLE=无中间'#13+
'TEEFONT EDITOR=TeeFont 编辑'#13+
'INTER-CHAR SPACING=字母间隔'#13+
'FONT=字型'#13+
'SHADOW=阴影'#13+
'HORIZ. SIZE=水平大小'#13+
'VERT. SIZE=垂直大小'#13+
'COLOR=颜色'#13+
'OUTLINE=轮廓'#13+
'OPTIONS=选项'#13+
'FORMAT=格式'#13+
'TEXT=文字'#13+
'TEXT=文字'#13+
'POSITION=位置'#13+
'LEFT=左'#13+
'TOP=上'#13+
'AUTO=自动'#13+
'CUSTOM=自定'#13+
'LEFT TOP=左上'#13+
'LEFT BOTTOM=左下'#13+
'RIGHT TOP=右上'#13+
'RIGHT BOTTOM=右下'#13+
'MULTIPLE AREAS=多面积'#13+
'NONE=无'#13+
'STACKED=堆积'#13+
'STACKED 100%=堆积 100%'#13+
'AREA=面积'#13+
'PATTERN=花纹'#13+
'STAIRS=阶梯'#13+
'SOLID=实线'#13+
'CLEAR=透明'#13+
'HORIZONTAL=横线'#13+
'VERTICAL=直线'#13+
'DIAGONAL=斜线'#13+
'B.DIAGONAL=反斜线'#13+
'CROSS=十字'#13+
'DIAG.CROSS=叉线'#13+
'AREA LINES=面积线条'#13+
'BORDER=边缘'#13+
'INVERTED=颠倒'#13+
'COLOR=颜色'#13+
'COLOR EACH=各别色'#13+
'ORIGIN=中心点'#13+
'USE ORIGIN=使用原点'#13+
'SIDE MARGINS=与边界相离'#13+
'WIDTH=宽度'#13+
'HEIGHT=高度'#13+
'AXIS=轴'#13+
'LENGTH=长度'#13+
'POSITION=位置'#13+
'SCROLL=卷动'#13+
'START=开始'#13+
'END=结束'#13+
'BOTH=两者'#13+
'AXIS INCREMENT=轴的递增值'#13+
'INCREMENT=Increment'#13+
'INCREMENT=递增'#13+
'STANDARD=标准'#13+
'ONE MILLISECOND=一毫秒'#13+
'ONE SECOND=一秒'#13+
'FIVE SECONDS=五秒'#13+
'TEN SECONDS=十秒'#13+
'FIFTEEN SECONDS=十五秒'#13+
'THIRTY SECONDS=三十秒'#13+
'ONE MINUTE=一分钟'#13+
'FIVE MINUTES=五分钟'#13+
'TEN MINUTES=十分钟'#13+
'FIFTEEN MINUTES=十五分钟'#13+
'THIRTY MINUTES=三十分钟'#13+
'ONE HOUR=一小时'#13+
'TWO HOURS=两小时'#13+
'SIX HOURS=六小时'#13+
'TWELVE HOURS=十二小时'#13+
'ONE DAY=一天'#13+
'TWO DAYS=两天'#13+
'THREE DAYS=三天'#13+
'ONE WEEK=一礼拜'#13+
'HALF MONTH=半个月'#13+
'ONE MONTH=一个月'#13+
'TWO MONTHS=两个月'#13+
'THREE MONTHS=三个月'#13+
'FOUR MONTHS=四个月'#13+
'SIX MONTHS=六个月'#13+
'ONE YEAR=一年'#13+
'EXACT DATE TIME=精确日期时间'#13+
'AXIS MAXIMUM AND MINIMUM=轴的最大最小值'#13+
'VALUE=数值'#13+
'TIME=时间'#13+
'LEFT AXIS=左轴'#13+
'RIGHT AXIS=右轴'#13+
'TOP AXIS=上轴'#13+
'BOTTOM AXIS=下轴'#13+
'% BAR WIDTH=% 长条宽度'#13+
'STYLE=样式'#13+
'SYMBOL=符号'#13+
'% BAR OFFSET=% 长条偏移'#13+
'RECTANGLE=矩形'#13+
'PYRAMID=角锥形'#13+
'INVERT. PYRAMID=反角锥形'#13+
'CYLINDER=圆柱形'#13+
'ELLIPSE=椭圆形'#13+
'ARROW=箭头'#13+
'RECT. GRADIENT=渐彩矩形'#13+
'CONE=圆锥形'#13+
'DARK BAR 3D SIDES=3D 明暗长条'#13+
'BAR SIDE MARGINS=长条面的边界'#13+
'AUTO MARK POSITION=自动标志位置'#13+
'GRADIENT=渐彩'#13+
'JOIN=连接'#13+
'DATASET=资料组'#13+
'APPLY=套用'#13+
'SOURCE=来源'#13+
'COLORS=颜色'#13+
'MONOCHROME=单色'#13+
'DEFAULT=预设'#13+
'2 (1 BIT)=双色 (1位)'#13+
'16 (4 BIT)=16色 (4位)'#13+
'256 (8 BIT)=256色 (8位)'#13+
'32768 (15 BIT)=32768色 (15位)'#13+
'65536 (16 BIT)=65536色 (16位)'#13+
'16M (24 BIT)=16M色 (24位)'#13+
'16M (32 BIT)=16M色 (32位)'#13+
'MEDIAN=中央线'#13+
'WHISKER=触须线'#13+
'PATTERN COLOR EDITOR=花纹颜色编辑'#13+
'IMAGE=图案'#13+
'IMAGE=图案'#13+
'SOLID=实色'#13+
'NONE=透明'#13+
'BACK DIAGONAL=反斜线'#13+
'DIAGONAL CROSS=叉线'#13+
'FILL 80%=填满 80%'#13+
'FILL 60%=填满 60%'#13+
'FILL 40%=填满 40%'#13+
'FILL 20%=填满 20%'#13+
'FILL 10%=填满 10%'#13+
'ZIG ZAG=锯齿状'#13+
'VERTICAL SMALL=小直线'#13+
'HORIZ. SMALL=小横线'#13+
'DIAG. SMALL=小斜线'#13+
'BACK DIAG. SMALL=小反斜线'#13+
'CROSS SMALL=小十字'#13+
'DIAG. CROSS SMALL=小叉线'#13+
'DAYS=天数'#13+
'WEEKDAYS=工作日'#13+
'TODAY=今天'#13+
'SUNDAY=星期日'#13+
'TRAILING=之后'#13+
'MONTHS=月份'#13+
'LINES=线条'#13+
'SHOW WEEKDAYS=显示工作日'#13+
'UPPERCASE=大写'#13+
'TRAILING DAYS=之后天数'#13+
'SHOW TODAY=显示今天'#13+
'SHOW MONTHS=显示月份'#13+
'UPPERCASE=大写'#13+
'CANDLE WIDTH=烛光宽度'#13+
'STYLE=样式'#13+
'STICK=棒状'#13+
'BAR=条状'#13+
'OPEN CLOSE=开启关闭'#13+
'UP CLOSE=关闭上方'#13+
'DOWN CLOSE=关闭下方'#13+
'SHOW OPEN=显示开口'#13+
'SHOW CLOSE=显示关口'#13+
'BORDER=边缘'#13+
'DRAW 3D=3D 绘画'#13+
'DARK 3D=3D 明暗'#13+
'EDITING=编辑'#13+
'CHART=图表'#13+
'SERIES=序列'#13+
'DATA=资料'#13+
'TOOLS=工具'#13+
'EXPORT=汇出'#13+
'PRINT=打印'#13+
'GENERAL=一般'#13+
'AXIS=轴'#13+
'TITLES=标题'#13+
'LEGEND=图例'#13+
'PANEL=面板'#13+
'THEMES=样式'#13+
'PAGING=分页'#13+
'WALLS=壁板'#13+
'3D=3D'#13+
'ADD=新增'#13+
'DELETE=移除'#13+
'TITLE=标题'#13+
'CLONE=复制'#13+
'CHANGE=变更'#13+
'HELP=说明'#13+
'CLOSE=关闭'#13+
'SERIES=序列'#13+
'TEECHART PRINT PREVIEW=TeeChart 预览打印'#13+
'PRINTER=打印机'#13+
'SETUP=设定'#13+
'PRINT=打印'#13+
'ORIENTATION=方向'#13+
'PORTRAIT=纵向'#13+
'LANDSCAPE=横向'#13+
'MARGINS (%)=边界 (%)'#13+
'DETAIL=细节'#13+
'MORE=多'#13+
'NORMAL=正常'#13+
'RESET MARGINS=重设边界'#13+
'VIEW MARGINS=显示边界'#13+
'PROPORTIONAL=成正比'#13+
'TEECHART PRINT PREVIEW=TeeChart 预览打印'#13+
'STYLE=样式'#13+
'TEXT=文字'#13+
'CIRCLE=圆形'#13+
'VERTICAL LINE=直线'#13+
'HORIZ. LINE=横线'#13+
'TRIANGLE=三角形'#13+
'INVERT. TRIANGLE=反三角形'#13+
'LINE=线条'#13+
'DIAMOND=菱形'#13+
'CUBE=立方体'#13+
'DIAGONAL CROSS=交叉'#13+
'STAR=星形'#13+
'BORDER=边缘'#13+
'TRANSPARENT=透明'#13+
'HORIZ. ALIGNMENT=水平对齐'#13+
'LEFT=向左'#13+
'CENTER=置中'#13+
'RIGHT=向右'#13+
'ROUND RECTANGLE=圆角矩形'#13+
'ALIGNMENT=对齐'#13+
'TOP=向上'#13+
'BOTTOM=向下'#13+
'LEFT=左'#13+
'RIGHT=:右'#13+
'TOP=上'#13+
'BOTTOM=下'#13+
'UNITS=单位'#13+
'PIXELS=像素'#13+
'AXIS ORIGIN=轴中心点'#13+
'ROTATION=旋转'#13+
'CIRCLED=正圆形'#13+
'3 DIMENSIONS=3D 效果'#13+
'RADIUS=半径'#13+
'HORIZONTAL=水平'#13+
'VERTICAL=垂直'#13+
'COLOR=颜色'#13+
'ANGLE INCREMENT=角度递增'#13+
'RADIUS INCREMENT=半径递增'#13+
'CLOSE CIRCLE=关闭圆形'#13+
'PEN=绘笔'#13+
'CIRCLE=圆形'#13+
'PATTERN=花纹'#13+
'LABELS=卷标'#13+
'ROTATED=旋转'#13+
'CLOCKWISE=顺时钟'#13+
'INSIDE=内部'#13+
'ROMAN=罗马'#13+
'HOURS=小时'#13+
'MINUTES=分钟'#13+
'SECONDS=秒数'#13+
'RADIUS=半径'#13+
'START VALUE=开始值'#13+
'END VALUE=结束值'#13+
'TRANSPARENCY=透明'#13+
'DRAW BEHIND=画在下层'#13+
'COLOR MODE=颜色模式'#13+
'STEPS=区段'#13+
'STYLE=种类'#13+
'RANGE=范围'#13+
'PALETTE=调色盘'#13+
'PALE=浅淡'#13+
'STRONG=强烈'#13+
'GRID SIZE=格子大小'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=深度'#13+
'IRREGULAR=不规则的'#13+
'GRID=表格'#13+
'VALUE=数值'#13+
'ALLOW DRAG=可拖曳'#13+
'VERTICAL POSITION=垂直位置'#13+
'LEVELS POSITION=层次位置'#13+
'LEVELS=层次'#13+
'NUMBER=数字'#13+
'LEVEL=层次'#13+
'AUTOMATIC=自动'#13+
'COLOR EACH=各别色'#13+
'STYLE=样式'#13+
'HORIZONTAL=水平'#13+
'VERTICAL=垂直'#13+
'SNAP=间隔移动'#13+
'FOLLOW MOUSE=跟随鼠标'#13+
'STACK=堆积'#13+
'HEIGHT 3D=3D 高度'#13+
'LINE MODE=线条模式'#13+
'INVERTED=颠倒'#13+
'DARK 3D=3D 明暗'#13+
'OVERLAP=重叠'#13+
'STACK=堆积'#13+
'STACK 100%=堆积 100%'#13+
'CLICKABLE=可点选'#13+
'LABELS=卷标'#13+
'AVAILABLE=有关项目'#13+
'SELECTED=已选项目'#13+
'DATASOURCE=资料来源'#13+
'NUMBER OF SAMPLE VALUES=样点数量'#13+
'GROUP BY=分类'#13+
'CALC=计算'#13+
'OF=之'#13+
'SUM=总计'#13+
'COUNT=数量'#13+
'HIGH=最高'#13+
'LOW=最低'#13+
'AVG=平均'#13+
'HOUR=小时'#13+
'DAY=天'#13+
'WEEK=礼拜'#13+
'WEEKDAY=工作日'#13+
'MONTH=月'#13+
'QUARTER=季'#13+
'YEAR=年'#13+
'HOLE %=洞 %'#13+
'RESET POSITIONS=重设位置'#13+
'MOUSE BUTTON=鼠标按键'#13+
'LEFT=左键'#13+
'RIGHT=右键'#13+
'MIDDLE=中键'#13+
'ENABLE DRAWING=启用绘画'#13+
'ENABLE SELECT=启用选择'#13+
'ENHANCED=增强格式'#13+
'ERROR WIDTH=误差宽度'#13+
'WIDTH UNITS=宽度单位'#13+
'PERCENT=百分比'#13+
'PIXELS=像素'#13+
'RIGHT=右'#13+
'LEFT AND RIGHT=左与右'#13+
'TOP AND BOTTOM=上与下'#13+
'BORDER EDITOR=绘笔编辑'#13+
'DASH=实线'#13+
'DOT=虚线'#13+
'DASH DOT=点线'#13+
'DASH DOT DOT=虚点线'#13+
'DASH=虚线'#13+
'DOT=点线'#13+
'DASH DOT=虚点线'#13+
'DASH DOT DOT=虚点点线'#13+
'CALCULATE EVERY=计算每个'#13+
'ALL POINTS=所有标点'#13+
'NUMBER OF POINTS=标点数量'#13+
'RANGE OF VALUES=数值范围'#13+
'ALIGNMENT=对齐'#13+
'FIRST=最初'#13+
'CENTER=中间'#13+
'LAST=最后'#13+
'TEEPREVIEW EDITOR=预览编辑'#13+
'ALLOW MOVE=可移动'#13+
'ALLOW RESIZE=可缩放'#13+
'DRAG IMAGE=拖曳图案'#13+
'AS BITMAP=为位图'#13+
'SHOW IMAGE=显示图案'#13+
'PORTRAIT=纵向'#13+
'LANDSCAPE=横向'#13+
'MARGINS=边界'#13+
'SIZE=大小'#13+
'3D %=3D %'#13+
'ZOOM=缩放'#13+
'ELEVATION=升度'#13+
'100%=100%'#13+
'HORIZ. OFFSET=水平偏移'#13+
'VERT. OFFSET=垂直偏移'#13+
'PERSPECTIVE=透视深度'#13+
'ANGLE=角度'#13+
'ORTHOGONAL=直角图'#13+
'ZOOM TEXT=缩放文字'#13+
'SCALES=刻度'#13+
'TITLE=标题'#13+
'TICKS=记号'#13+
'MINOR=次要'#13+
'MAXIMUM=最大值'#13+
'MINIMUM=最小值'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=需求的递增值'#13+
'(INCREMENT)=(increment)'#13+
'LOG BASE=对数底'#13+
'LOGARITHMIC=启用对数(Log)'#13+
'AUTO=自动'#13+
'AUTO=自动'#13+
'CHANGE=变更'#13+
'CHANGE=变更'#13+
'TITLE=标题'#13+
'ANGLE=角度'#13+
'MIN. SEPARATION %=最小分离 %'#13+
'VISIBLE=显示'#13+
'MULTI-LINE=多行'#13+
'LABEL ON AXIS=在轴上'#13+
'ROUND FIRST=先舍入值'#13+
'AUTO=自动'#13+
'MARK=记号'#13+
'LABELS FORMAT=卷标格式'#13+
'EXPONENTIAL=指数(Exponential)'#13+
'DEFAULT ALIGNMENT=预设对齐'#13+
'LEN=长度'#13+
'TICKS=记号'#13+
'INNER=内部'#13+
'AT LABELS ONLY=只在卷标'#13+
'CENTERED=置中'#13+
'COUNT=数量'#13+
'TICKS=记号'#13+
'POSITION %=位置 %'#13+
'START %=开始 %'#13+
'END %=结束 %'#13+
'OTHER SIDE=另一面'#13+
'AXES=轴'#13+
'VISIBLE=显示'#13+
'BEHIND=下层'#13+
'CLIP POINTS=显示范围内'#13+
'PRINT PREVIEW=预览打印'#13+
'ZOOM=缩放'#13+
'SCROLL=卷动'#13+
'STEPS=区段'#13+
'MINIMUM PIXELS=最少点数'#13+
'DIRECTION=方位'#13+
'MOUSE BUTTON=鼠标键'#13+
'ALLOW=允许'#13+
'ANIMATED=动画'#13+
'PEN=绘笔'#13+
'PATTERN=花纹'#13+
'ALLOW SCROLL=允许卷动'#13+
'NONE=无'#13+
'BOTH=两者'#13+
'TEEOPENGL EDITOR=TeeOpenGL 编辑'#13+
'AMBIENT LIGHT=环境亮度'#13+
'SHININESS=光泽'#13+
'FONT 3D DEPTH=3D 字型深度'#13+
'ACTIVE=有效'#13+
'FONT OUTLINES=字型轮廓'#13+
'SMOOTH SHADING=平滑描绘阴影'#13+
'LIGHT=灯光'#13+
'Y=Y'#13+
'INTENSITY=强烈度'#13+
'BEVEL=斜面'#13+
'SIZE=大小'#13+
'FRAME=框架'#13+
'ROUND FRAME=圆角外框'#13+
'TRANSPARENT=透明'#13+
'LOWERED=陷入'#13+
'RAISED=浮起'#13+
'YES=是'#13+
'SYMBOLS=符号'#13+
'TEXT STYLE=文字样式'#13+
'LEGEND STYLE=图例样式'#13+
'VERT. SPACING=垂直空间'#13+
'AUTOMATIC=自动'#13+
'SERIES NAMES=序列名称'#13+
'SERIES VALUES=序列数值'#13+
'LAST VALUES=最后数值'#13+
'PLAIN=普通'#13+
'LEFT VALUE=左数值'#13+
'RIGHT VALUE=右数值'#13+
'LEFT PERCENT=左百分比'#13+
'RIGHT PERCENT=右百分比'#13+
'X VALUE=X 数值'#13+
'VALUE=数植'#13+
'PERCENT=百分比'#13+
'X AND VALUE=X 与 数值'#13+
'X AND PERCENT=X 与 百分比'#13+
'CHECK BOXES=勾选项目'#13+
'DIVIDING LINES=分隔线'#13+
'FONT SERIES COLOR=序列字型颜色'#13+
'POSITION OFFSET %=位置偏移 %'#13+
'MARGIN=边界'#13+
'RESIZE CHART=变更图表大小'#13+
'WIDTH UNITS=宽度单位'#13+
'LEFT=左'#13+
'RIGHT=右'#13+
'CONTINUOUS=连续的'#13+
'POINTS PER PAGE=每页的标点数'#13+
'SCALE LAST PAGE=缩放到最后一页'#13+
'SHOW PAGE NUMBER=显示页数'#13+
'CURRENT PAGE LEGEND=本页显示图例'#13+
'PANEL EDITOR=面板编辑'#13+
'BACKGROUND=背景'#13+
'BORDERS=边缘'#13+
'COLOR=面板颜色'#13+
'BACK IMAGE=背景图案'#13+
'STRETCH=展开'#13+
'TILE=并列'#13+
'INSIDE=范围之内'#13+
'WIDTH=宽'#13+
'WIDTH=宽'#13+
'BEVEL INNER=内斜面'#13+
'BEVEL OUTER=外斜面'#13+
'MARKS=标志'#13

{$IFDEF LCL}
;  TeeChineseSimpLanguage.Text:=TeeChineseSimpLanguage.Text
{$ENDIF}

+
'DATA SOURCE=资料来源'#13+
'SORT=排序'#13+
'CURSOR=指针'#13+
'SHOW IN LEGEND=显示在图标'#13+
'FORMATS=格式'#13+
'VALUES=数值'#13+
'PERCENTS=百分比'#13+
'HORIZONTAL AXIS=横轴'#13+
'TOP=上'#13+
'BOTTOM=下'#13+
'TOP AND BOTTOM=上与下'#13+
'DATETIME=日期时间'#13+
'VERTICAL AXIS=直轴'#13+
'LEFT AND RIGHT=左与右'#13+
'DATETIME=日期时间'#13+
'ASCENDING=递增'#13+
'DESCENDING=递减'#13+
'DRAW EVERY=画每个'#13+
'CLIPPED=修剪'#13+
'ARROWS=箭头'#13+
'MULTI LINE=多行'#13+
'ALL SERIES VISIBLE=显示所有序列'#13+
'LABEL=卷标'#13+
'LABEL AND PERCENT=卷标与百分比'#13+
'LABEL AND VALUE=卷标与数值'#13+
'LEGEND=图标'#13+
'PERCENT TOTAL=总百分比'#13+
'X AND Y VALUES=X 和 Y 数值'#13+
'MANUAL=手动'#13+
'RANDOM=随机数'#13+
'FUNCTION=函数'#13+
'NEW=新增'#13+
'EDIT=修改'#13+
'PERSISTENT=保留'#13+
'ADJUST FRAME=调整框架'#13+
'LEFT=向左'#13+
'CENTER=置中'#13+
'RIGHT=向右'#13+
'TOP=上'#13+
'SUBTITLE=子标题'#13+
'SUBFOOT=子标尾'#13+
'FOOT=标尾'#13+
'ACTIVE=有效'#13+
'VISIBLE WALLS=显示壁板'#13+
'LEFT=左面'#13+
'RIGHT=右面'#13+
'BOTTOM=下面'#13+
'BACK=后方'#13+
'BORDER=边缘'#13+
'DIF. LIMIT=相差限'#13+
'LINES=线条.'#13+
'ABOVE=高于'#13+
'WITHIN=之内'#13+
'BELOW=低于'#13+
'CONNECTING LINES=连接线条'#13+
'HIGH=高'#13+
'LOW=低'#13+
'BROWSE=浏览'#13+
'TILED=并列显示'#13+
'INFLATE MARGINS=涨大边界 '#13+
'SQUARE=正方形'#13+
'ROUND=圆角'#13+
'FLAT=平角'#13+
'DOWN TRIANGLE=反三角形'#13+
'SMALL DOT=小点'#13+
'DEFAULT=预设'#13+
'GLOBAL=整体'#13+
'SHAPES=形状'#13+
'BRUSH=笔刷'#13+
'GLOBAL=整体'#13+
'BRUSH=笔刷'#13+
'GLOBAL=整体'#13+
'BORDER=边缘'#13+
'DELAY=延迟'#13+
'MSEC.=微秒'#13+
'LABEL AND PERCENT TOTAL=卷标与总百分比'#13+
'MOUSE ACTION=鼠标动作'#13+
'MOVE=移动'#13+
'CLICK=点选'#13+
'SIZE=大小'#13+
'BRUSH=笔刷'#13+
'DRAW LINE=画线'#13+
'EXPLODE BIGGEST=分解最大'#13+
'TOTAL ANGLE=总角度'#13+
'GROUP SLICES=分类'#13+
'VALUE=数值'#13+
'LABEL=卷标'#13+
'BELOW %=百分比之下'#13+
'BELOW VALUE=数值之下'#13+
'OTHER=Other'#13+
'PATTERNS=花纹'#13+
'DEPTH=深度'#13+
'LINE=线条'#13+
'SIZE %=大小 %'#13+
'SERIES DATASOURCE TEXT EDITOR=图表资料来缘文字编辑'#13+
'FIELDS=Fields'#13+
'SOURCE=来源'#13+
'NUMBER OF HEADER LINES=标头总行数'#13+
'SEPARATOR=分隔符'#13+
'SERIES=序列'#13+
'COMMA=逗点'#13+
'SPACE=空白'#13+
'TAB=Tab'#13+
'FILE=文件'#13+
'VIEW=视图'#13+
'DATA SOURCES=数据源'#13+
'SERIES LIST=图表系列'#13+
'INSPECTOR=对象管理器'#13+
'GALLERY=图表类型'#13+
'STATUS BAR=状态栏'#13+
'PROPERTIES=属性'#13+
'CHART TOOLS=图表工具'#13+
'SAVE AS=另存为'#13+
'REOPEN=重新打开'#13+
'OPEN=打开'#13+
'TOOLBARS=工具栏'#13+
'SEND BY E-MAIL=发送邮件'#13+
'EXIT=退出'#13+
'NEW USING WIZARD=图表向导'#13+
'PAGE=分页'#13+
'NEW USING WIZARD=图表向导'#13+

'SHOW AT LEGEND=显示图例'#13+
'SELECT=选择'#13+
'SHOW SERIES MARKS=显示标记'#13+
'VIEW=显示'#13+
'PREVIEW=预览'#13+
'PROPERTY=属性'#13+
'ADD ANNOTATION=添加注释'#13+
'ENABLE ZOOM=放大'#13+
'DRAW LINES=画线'#13+
'SHOW HINTS=显示提示'#13+
'ENABLE SCROLL=拖动'#13+
'BOLD=粗体'#13+
'ITALIC=斜体'#13+
'UNDERLINE=下划线'#13+
'STRIKE OUT=删除线'#13+
'LEFT JUSTIFY=左对齐'#13+
'RIGHT JUSTIFY=右对齐'#13+
'BORDER WIDTH=边界宽度'#13+
'X VALUES=X值'#13+
'TEXT LABELS=文字'#13+
'SERIES=序列'#13+
'SMOOTH=平滑'#13+
'WEB URL=网址'#13+
'LOAD=读取'#13+
'C LABELS=C 卷标'#13+
'R LABELS=R 卷标'#13+
'C PEN=C 绘笔'#13+
'R PEN=R 绘笔'#13+
'CIRCLE=圆圈'#13+
'COLOR EACH=各别色'#13+
'FONT=字型'#13+
'STACK GROUP=堆放组数'#13+
'USE ORIGIN=使用中心点'#13+
'MULTIPLE BAR=多长条图'#13+
'SIDE=侧放'#13+
'SIDE ALL=全侧放'#13+
'DRAWING MODE=绘图模式'#13+
'SOLID=实体'#13+
'WIREFRAME=外框线'#13+
'DOTFRAME=外框点'#13+
'SMOOTH PALETTE=平滑色泽'#13+
'SIDE BRUSH=侧面笔刷'#13+
'ABOUT TEECHART PRO V7.0=有关 TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'VISIT OUR WEB SITE !=Visit our Web site !'#13+
'TEECHART WIZARD=TeeChart 精灵'#13+
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
'CHART PREVIEW=图表预览'#13+
'SHOW LEGEND=显示图例'#13+
'SHOW MARKS=显示标志'#13+
'COLOR EACH=个别色'#13+
'< BACK=< 上一步'#13+
'SELECT A CHART STYLE=Select a Chart style'#13+
'NON DATABASE CHART=Non Database Chart'#13+
'SELECT A DATABASE TABLE=Select a Database Table'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'SELECT THE DESIRED FIELDS TO CHART=Select the desired Fields to Chart'#13+
'SELECT A TEXT LABELS FIELD=Select a text labels Field'#13+
'CHOOSE THE DESIRED CHART TYPE=Choose the desired Chart type'#13+
'EXPORT CHART=汇出图表'#13+
'PICTURE=图片'#13+
'NATIVE=原始'#13+
'FORMAT=格式'#13+
'SIZE=大小'#13+
'HEIGHT=高'#13+
'KEEP ASPECT RATIO=保留大小比例'#13+
'INCLUDE SERIES DATA=加入序列资料'#13+
'FILE SIZE=档案大小'#13+
'SERIES=序列'#13+
'DELIMITER=分隔码'#13+
'XML=XML'#13+
'HTML TABLE=HTML 表格'#13+
'EXCEL=Excel'#13+
'COMMA=逗号'#13+
'COLON=冒号'#13+
'CUSTOM=自定'#13+
'INCLUDE=加入'#13+
'POINT LABELS=标点卷标'#13+
'POINT INDEX=标点索引'#13+
'HEADER=表头'#13+
'COPY=复制'#13+
'SAVE=储存'#13+
'SEND=传送'#13+
'FUNCTIONS=函数'#13+
'ADD=减'#13+
'ADX=加'#13+
'AVERAGE=平均'#13+
'BOLLINGER=低'#13+
'COPY=除'#13+
'DIVIDE=高'#13+
'EXP. AVERAGE=乘'#13+
'EXP.MOV.AVRG.=复制'#13+
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
'SOURCE SERIES=来源序列'#13+
'TEECHART GALLERY=TeeChart 陈列室'#13+
'FUNCTIONS=函数'#13+
'DITHER=色调'#13+
'REDUCTION=转换'#13+
'COMPRESSION=压缩格式'#13+
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
'MONOCHROME=单色'#13+
'GRAY SCALE=渐灰度'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% 品质'#13+
'GRAY SCALE=灰阶'#13+
'PERFORMANCE=效能'#13+
'QUALITY=品质'#13+
'SPEED=速度'#13+
'COMPRESSION LEVEL=压缩程度'#13+
'CHART TOOLS GALLERY=图表工具陈列室'#13+
'ANNOTATION=旋转'#13+
'AXIS ARROWS=指针'#13+
'COLOR BAND=拖曳标志'#13+
'COLOR LINE=画线'#13+
'CURSOR=轴箭头'#13+
'DRAG MARKS=标志说明'#13+
'DRAW LINE=图案'#13+
'IMAGE=最近点'#13+
'MARK TIPS=颜色带'#13+
'NEAREST POINT=颜色线'#13+
'SIDE MARGINS=与边界相离'#13+
'DATASOURCES=数据源'#13+
'AUTO HIDE=自动隐藏'#13+
'COLOR EACH LINE=颜色各异'#13+
'DISTANCE=距离'#13+
'POINTER=点'#13+
'ARROW HEAD=箭头形状'#13+
'OUTLINE GRADIENT=轮廓渐彩'#13+
'BALANCE=平衡'#13+
'RADIAL OFFSET=光线偏移'#13+
'SMOOTH=平滑'#13+
'HORIZ=水平方向'#13+
'VERT=垂直方向'#13+
'% BAR DEPTH=% 长条厚度'#13+
'SELF STACK=堆积在一起'#13+
'TICK LINES=标记线'#13+
'DEPTH TOP=右轴顶'#13+
'OFFSET=偏移'#13+
'VALUE=值'#13+
'SELECTOR=选择'#13+

'DEFAULT BORDER=默认边框'#13+
'SQUARED=正方形'#13+
'TEXT ALIGNMENT=文本对齐方式'#13+
'SEPARATION=分隔'#13+
'ROUND BORDER=圆边'#13+
'ALLOW RESIZE CHART=允许缩放图'#13+

'POINT COLORS=点颜色'#13+
'DRAW STYLE=画线格式'#13+
'FIXED POSITION=固定位置'#13+
'HANDLES=绘笔编辑'#13+
'COLOR PALETTE=调色板'#13+
'SCALE=比例缩放'#13+
'RADIO BUTTONS=单选按钮'#13+
'NO CHECK BOXES=无复选框'#13+
'VIEWS=视图'#13+
'THEME=样式'#13+
'AXIS LINE=轴线'#13+
'MINOR GRID=次要网络线'#13+
'SERIES COLOR=序列颜色'#13+
'CHECK-BOXES=选择框'#13+
'CUSTOM POSITION=自定义位置'#13+
'ROTATE=旋转'#13
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

