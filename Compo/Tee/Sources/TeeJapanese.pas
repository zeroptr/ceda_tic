unit TeeJapanese;
{$I TeeDefs.inc}

interface

Uses Classes;

Var TeeJapaneseLanguage:TStringList=nil;

Procedure TeeSetJapanese;
Procedure TeeCreateJapanese;

implementation

Uses SysUtils, TeeTranslate, TeeConst, TeeProCo {$IFNDEF D5},TeCanvas{$ENDIF};

Procedure TeeJapaneseConstants;
begin
  { TeeConst }
  TeeMsg_Copyright          :='(C) 1995-2009 by Steema Software';
  TeeMsg_LegendFirstValue   :='�ŏ��̖}��̒l��0���傫���Ȃ���΂Ȃ�܂���B';
  TeeMsg_LegendColorWidth   :='�}��̐F�̕���0%���傫���Ȃ���΂Ȃ�܂���B';
  TeeMsg_SeriesSetDataSource:='�L���ȃf�[�^�\�[�X��ParentChart������܂���B';
  TeeMsg_SeriesInvDataSource:='�����ȃf�[�^�\�[�X: %s';
  TeeMsg_FillSample         :='FillSampleValues�̒l��0���傫���Ȃ���΂Ȃ�܂���B';
  TeeMsg_AxisLogDateTime    :='���t���Ԏ���ΐ����ɂ��邱�Ƃ͂ł��܂���B';
  TeeMsg_AxisLogNotPositive :='�ΐ����̍ŏ��l�ƍő�l��0�ȏ�łȂ���΂Ȃ�܂���B';
  TeeMsg_AxisLabelSep       :='�����x���Ԃ̋����̊���(%)��0���傫���Ȃ���΂Ȃ�܂���B';
  TeeMsg_AxisIncrementNeg   :='���̑����ʂ�0�ȏ�łȂ���΂Ȃ�܂���B';
  TeeMsg_AxisMinMax         :='���̍ŏ��l�͍ő�l�ȉ��łȂ���΂Ȃ�܂���B';
  TeeMsg_AxisMaxMin         :='���̍ő�l�͍ŏ��l�ȏ�łȂ���΂Ȃ�܂���B';
  TeeMsg_AxisLogBase        :='�ΐ����̊��2�ȏ�ɂ��Ă��������B';
  TeeMsg_MaxPointsPerPage   :='1�y�[�W������̍ő�|�C���g����0���傫�����Ă��������B';
  TeeMsg_3dPercent          :='3D�̃p�[�Z���g�� %d ���� %d �̊Ԃɂ��Ă��������B';
  TeeMsg_CircularSeries     :='�~�n��̈ˑ��͋�����܂���B';
  TeeMsg_WarningHiColor     :='�\���F����16k�F�������͂���ȏ�𐄏��������܂��B';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';

  TeeMsg_AxisTitle          :='���̃^�C�g��';
  TeeMsg_AxisLabels         :='���̃��x��';
  TeeMsg_RefreshInterval    :='�X�V�Ԋu��0����60�̊ԂłȂ���΂Ȃ�܂���B';
  TeeMsg_SeriesParentNoSelf :='�n���ParentChart�́uSelf�v�ł͂���܂���I';
  TeeMsg_GalleryLine        :='���{��';
  TeeMsg_GalleryPoint       :='�U�z�}';
  TeeMsg_GalleryArea        :='��';
  TeeMsg_GalleryBar         :='�c�_';
  TeeMsg_GalleryHorizBar    :='���_';
  TeeMsg_GalleryPie         :='�~';
  TeeMsg_GalleryCircled     :='�~';
  TeeMsg_GalleryFastLine    :='�܂��';
  TeeMsg_GalleryHorizLine   :='�����{��';

  TeeMsg_PieSample1         :='Cars';
  TeeMsg_PieSample2         :='Phones';
  TeeMsg_PieSample3         :='Tables';
  TeeMsg_PieSample4         :='Monitors';
  TeeMsg_PieSample5         :='Lamps';
  TeeMsg_PieSample6         :='Keyboards';
  TeeMsg_PieSample7         :='Bikes';
  TeeMsg_PieSample8         :='Chairs';

  TeeMsg_GalleryLogoFont    :='�l�r �o�S�V�b�N';
  TeeMsg_Editing            :='%s �̕ҏW';

  TeeMsg_GalleryStandard    :='�W��';
  TeeMsg_GalleryExtended    :='�g��';
  TeeMsg_GalleryFunctions   :='�֐�';

  TeeMsg_EditChart          :='�`���[�g�̕ҏW(&D)...';
  TeeMsg_PrintPreview       :='����v���r���[(&P)...';
  TeeMsg_ExportChart        :='�`���[�g�̃G�N�X�|�[�g(&X)...';
  TeeMsg_CustomAxes         :='�J�X�^����...';

  TeeMsg_InvalidEditorClass :='%s: �����ȃG�f�B�^�N���X: %s';
  TeeMsg_MissingEditorClass :='%s: �G�f�B�^�_�C�A���O������܂���B';

  TeeMsg_GalleryArrow       :='���';

  TeeMsg_ExpFinish          :='����(&F)';
  TeeMsg_ExpNext            :='����(&N) >';

  TeeMsg_GalleryGantt       :='�K���g';

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

  TeeMsg_ChangeSeriesTitle  :='�n��̃^�C�g����ύX����';
  TeeMsg_NewSeriesTitle     :='�n��̐V�����^�C�g��:';
  TeeMsg_DateTime           :='���t�Ǝ���';
  TeeMsg_TopAxis            :='�㎲';
  TeeMsg_BottomAxis         :='����';
  TeeMsg_LeftAxis           :='����';
  TeeMsg_RightAxis          :='�E��';

  TeeMsg_SureToDelete       :='%s ���폜���܂����H';
  TeeMsg_DateTimeFormat     :='���t���ԏ���(&M):';
  TeeMsg_Default            :='�f�t�H���g';
  TeeMsg_ValuesFormat       :='�l�̏���(&M):';
  TeeMsg_Maximum            :='�ő�';
  TeeMsg_Minimum            :='�ŏ�';
  TeeMsg_DesiredIncrement   :='�v�]������ %s';

  TeeMsg_IncorrectMaxMinValue:='�������Ȃ��l�̗��R: %s';
  TeeMsg_EnterDateTime      :='���� [����] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='�ύX��K�p���܂����H';
  TeeMsg_SelectedSeries     :='(�I�����ꂽ�n��)';
  TeeMsg_RefreshData        :='�f�[�^�̍X�V(&R)';

  TeeMsg_DefaultFontSize    :='9';
  TeeMsg_DefaultEditorSize  :='439';
  TeeMsg_DefaultEditorHeight:='439';

  TeeMsg_FunctionAdd        :='�a';
  TeeMsg_FunctionSubtract   :='����';
  TeeMsg_FunctionMultiply   :='��';
  TeeMsg_FunctionDivide     :='��';
  TeeMsg_FunctionHigh       :='�ő�';
  TeeMsg_FunctionLow        :='�ŏ�';
  TeeMsg_FunctionAverage    :='���ϒl';

  TeeMsg_GalleryShape       :='�V�F�[�v';
  TeeMsg_GalleryBubble      :='�A';
  TeeMsg_FunctionNone       :='�R�s�[';

  TeeMsg_None               :='(�Ȃ�)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :='�l�r �o�S�V�b�N';

  TeeMsg_CheckPointerSize   :='�|�C���^�̃T�C�Y��0���傫�����Ă��������B';
  TeeMsg_About              :='�o�[�W�������(&A)...';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='�f�[�^�Z�b�g';
  TeeMsg_AskDataSet         :='�ް����(&D):';

  TeeMsg_SingleRecord       :='�P�ꃌ�R�[�h';
  TeeMsg_AskDataSource      :='�ް����(&D):';

  TeeMsg_Summary            :='�T�}���[';

  TeeMsg_FunctionPeriod     :='�֐��̃s���I�h��0�ȏ�ɂ��Ă��������B';

  TeeMsg_TeeChartWizard     :='TeeChart �E�B�U�[�h';
  TeeMsg_WizardTab          :='�Ɩ�';

  TeeMsg_ClearImage         :='�N���A(&R)';
  TeeMsg_BrowseImage        :='�Q��(&R)...';

  TeeMsg_WizardSureToClose  :='TeeChart �E�B�U�[�h���I�����Ă���낵���ł����H';
  TeeMsg_FieldNotFound      :='�t�B�[���h %s �����݂��܂���B';

  TeeMsg_DepthAxis          :='����(�E)';
  TeeMsg_PieOther           :='���̑�';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='�~';
  TeeMsg_ValuesBar          :='�_';
  TeeMsg_ValuesAngle        :='�p�x';
  TeeMsg_ValuesGanttStart   :='�J�n';
  TeeMsg_ValuesGanttEnd     :='�Ō�';
  TeeMsg_ValuesGanttNextTask:='�������';
  TeeMsg_ValuesBubbleRadius :='���a';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='�}��';
  TeeMsg_Title              :='�^�C�g��';
  TeeMsg_Foot               :='�t�b�^�[';
  TeeMsg_Period             :='�s���I�h�͈̔�';
  TeeMsg_PeriodRange        :='�s���I�h�͈̔�';
  TeeMsg_CalcPeriod         :='�S�Ă� %s ���v�Z:';
  TeeMsg_SmallDotsPen       :='�����ȓ_';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' �t�@�C���̃`���[�g�͖����ł��B';
  TeeMsg_WrongTeeFileFormat :='*.'+TeeMsg_TeeExtension+' �t�@�C���̌`�����Ԉ���Ă��܂��B';
  TeeMsg_EmptyTeeFile       :='*.'+TeeMsg_TeeExtension+' �t�@�C������ł��B';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := '�`���[�g�̎�';
  TeeMsg_ChartAxesCategoryDesc   := '�`���[�g�̎��̃v���p�e�B�ƃC�x���g';
  TeeMsg_ChartWallsCategoryName  := '�`���[�g�̕�';
  TeeMsg_ChartWallsCategoryDesc  := '�`���[�g�̕ǂ̃v���p�e�B�ƃC�x���g';
  TeeMsg_ChartTitlesCategoryName := '�`���[�g�̃^�C�g��';
  TeeMsg_ChartTitlesCategoryDesc := '�`���[�g�̃^�C�g���̃v���p�e�B�ƃC�x���g';
  TeeMsg_Chart3DCategoryName     := '�`���[�g��3D';
  TeeMsg_Chart3DCategoryDesc     := '�`���[�g��3D�̃v���p�e�B�ƃC�x���g';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       := '�J�X�^��';
  TeeMsg_Series                 := '�n��';
  TeeMsg_SeriesList             := '�n��...';

  TeeMsg_PageOfPages            := '�y�[�W %d / %d';
  TeeMsg_FileSize               := '%d �o�C�g';

  TeeMsg_First  := '�擪';
  TeeMsg_Prior  := '�O��';
  TeeMsg_Next   := '����';
  TeeMsg_Last   := '����';
  TeeMsg_Insert := '�}��';
  TeeMsg_Delete := '�폜';
  TeeMsg_Edit   := '�ҏW';
  TeeMsg_Post   := '�o�^';
  TeeMsg_Cancel := '�L�����Z��';

  TeeMsg_All    := '(�S��)';
  TeeMsg_Index  := '�C���f�b�N�X';
  TeeMsg_Text   := '�e�L�X�g';

  TeeMsg_AsBMP        :='�r�b�g�}�b�v(&B)';
  TeeMsg_BMPFilter    :='�r�b�g�}�b�v (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='���^�t�@�C��(&M)';
  TeeMsg_EMFFilter    :='�g�����^�t�@�C�� (*.emf)|*.emf|���^�t�@�C�� (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := '�p�l���̃v���p�e�B���G�N�X�|�[�g�`���ɐݒ肳��Ă��܂���B';

  TeeMsg_Normal    := '�W��';
  TeeMsg_NoBorder  := '�g�Ȃ�';
  TeeMsg_Dotted    := '�_��';
  TeeMsg_Colors    := '�F����';
  TeeMsg_Filled    := '�h��Ԃ�';
  TeeMsg_Marks     := '�}�[�J�t';
  TeeMsg_Stairs    := '�K�i';
  TeeMsg_Points    := '�|�C���g';
  TeeMsg_Height    := '3D����';
  TeeMsg_Hollow    := '������';
  TeeMsg_Point2D   := '2D�|�C���g';
  TeeMsg_Triangle  := '�O�p�`';
  TeeMsg_Star      := '��';
  TeeMsg_Circle    := '�~';
  TeeMsg_DownTri   := '�|���O�p�`';
  TeeMsg_Cross     := '������';
  TeeMsg_Diamond   := '�H�`';
  TeeMsg_NoLines   := '���Ȃ�';
  TeeMsg_Stack     := '�ςݏd��';
  TeeMsg_Stack100  := '�S����';
  TeeMsg_Pyramid   := '�l�p��';
  TeeMsg_Ellipse   := '�ȉ~';
  TeeMsg_InvPyramid:= '�|���l�p��';
  TeeMsg_Sides     := '���u';
  TeeMsg_SideAll   := '����(�n��)';
  TeeMsg_Patterns  := '�p�^�[��';
  TeeMsg_Exploded  := '�ő啪��';
  TeeMsg_Shadow    := '�e';
  TeeMsg_SemiPie   := '���~';
  TeeMsg_Rectangle := '��`';
  TeeMsg_VertLine  := '������';
  TeeMsg_HorizLine := '������';
  TeeMsg_Line      := '����';
  TeeMsg_Cube      := '������';
  TeeMsg_DiagCross := '�΂ߌ�����';

  TeeMsg_CanNotFindTempPath    := '�e���|�����t�H���_��������܂���';
  TeeMsg_CanNotCreateTempChart := '�e���|�����t�@�C�����쐬�ł��܂���';
  TeeMsg_CanNotEmailChart      := '�`���[�g�����[���ő��M�ł��܂���B Mapi �G���[: %d';

  TeeMsg_SeriesDelete := '�n��̍폜: ValueIndex %d ���͈͊O (0 �` %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='����(&L)...';
  TeeMsg_TextFile     := 'Text�t�@�C��';

  { 5.03 }
  TeeMsg_Gradient := '����ް���';
  TeeMsg_WantToSave   :='%s ��ۑ����܂����H';
  TeeMsg_NativeFilter :='TeeChart�t�@�C��';

  TeeMsg_Property     :='�v���p�e�B';
  TeeMsg_Value        :='�l';
  TeeMsg_Yes          :='�͂�';
  TeeMsg_No           :='������';
  TeeMsg_Image        :='(�Ұ��)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='��';
  TeeMsg_GalleryCandle      :='�L�����h��';
  TeeMsg_GalleryVolume      :='�{�����[��';
  TeeMsg_GallerySurface     :='�T�[�t�F�X';
  TeeMsg_GalleryContour     :='������';
  TeeMsg_GalleryBezier      :='�x�W�F';
  TeeMsg_GalleryPoint3D     :='3D �U�z';
  TeeMsg_GalleryRadar       :='���[�_�[';
  TeeMsg_GalleryDonut       :='�h�[�i�c';
  TeeMsg_GalleryCursor      :='�J�[�\��';
  TeeMsg_GalleryBar3D       :='3D �o�[';
  TeeMsg_GalleryBigCandle   :='�ޯ�޷�����';
  TeeMsg_GalleryLinePoint   :='ײ��߲��';
  TeeMsg_GalleryHistogram   :='�q�X�g�O����';
  TeeMsg_GalleryWaterFall   :='�����̫��';
  TeeMsg_GalleryWindRose    :='�����}';
  TeeMsg_GalleryClock       :='���v';
  TeeMsg_GalleryColorGrid   :='�װ��د��';
  TeeMsg_GalleryBoxPlot     :='�c�ޯ����ۯ�';
  TeeMsg_GalleryHorizBoxPlot:='���ޯ����ۯ�';
  TeeMsg_GalleryBarJoin     :='�o�[ �W���C��';
  TeeMsg_GallerySmith       :='�X�~�X';
  TeeMsg_GalleryPyramid     :='�s���~�b�h';
  TeeMsg_GalleryMap         :='�}�b�v';

  // 7.06
  TeeMsg_GalleryVolumePipe  :='��ح���߲��';

  TeeMsg_PolyDegreeRange     :='�������̎����� 1 ���� 20 �̊Ԃɂ��Ă��������B';
  TeeMsg_AnswerVectorIndex   :='AnswerVector�v���p�e�B�̃C���f�b�N�X�l�� 1 ���� %d �̊Ԃɂ��Ă��������B';
  TeeMsg_FittingError        :='��Ԃ������ł��܂���B';
  TeeMsg_PeriodRange         :='�s���I�h��0�ȏ�ɐݒ肵�Ă��������B';
  TeeMsg_ExpAverageWeight    :='�w�����ϒl�̏d�݂�0��1�ɐݒ肵�Ă��������B';
  TeeMsg_GalleryErrorBar     :='�G���[�o�[';
  TeeMsg_GalleryError        :='�G���[';
  TeeMsg_GalleryHighLow      :='High-Low';
  TeeMsg_FunctionMomentum    :='�^����';
  TeeMsg_FunctionMomentumDiv :='���^����';
  TeeMsg_FunctionExpAverage  :='�w�����ϒl';
  TeeMsg_FunctionMovingAverage:='�ړ����ϒl';
  TeeMsg_FunctionExpMovAve   :='�w���ړ����ϒl';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='�n��g�ݍ��킹';
  TeeMsg_FunctionTrend       :='�g�����h';
  TeeMsg_FunctionExpTrend    :='�w���g�����h';
  TeeMsg_FunctionLogTrend    :='�ΐ��g�����h';
  TeeMsg_FunctionCumulative  :='�ݐ�';
  TeeMsg_FunctionStdDeviation:='�W���΍�';
  TeeMsg_FunctionBollinger   :='�{�����W���[';
  TeeMsg_FunctionRMS         :='�덷��2��';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='�m��';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='�v�Z';
  TeeMsg_LoadChart           :='TeeChart���J��...';
  TeeMsg_SaveChart           :='TeeChart��ۑ�...';
  TeeMsg_TeeFiles            :='TeeChart Pro �t�@�C��';

  TeeMsg_GallerySamples      :='���̑�';
  TeeMsg_GalleryStats        :='���v';

  TeeMsg_CannotFindEditor    :='�n���ҏW����t�H�[�� %s ��������܂���B';

  TeeMsg_CannotLoadChartFromURL:='�G���[�R�[�h: %d URL: %s ����`���[�g���_�E�����[�h���Ă��܂��B';
  TeeMsg_CannotLoadSeriesDataFromURL:='�G���[�R�[�h: %d URL: %s ����n��̃f�[�^���_�E�����[�h���Ă��܂��B';

  TeeMsg_Test                :='�e�X�g...';

  TeeMsg_ValuesDate          :='���t';
  TeeMsg_ValuesOpen          :='�n�l';
  TeeMsg_ValuesHigh          :='���l';
  TeeMsg_ValuesLow           :='���l';
  TeeMsg_ValuesClose         :='�I�l';
  TeeMsg_ValuesOffset        :='�̾��';
  TeeMsg_ValuesStdError      :='�W���װ';

  TeeMsg_Grid3D              :='3D�O���b�h';

  TeeMsg_LowBezierPoints     :='�x�W�F�̃|�C���g����1���傫�Ȓl��ݒ肵�Ă��������B';

  { TeeCommander component... }

  TeeCommanMsg_Normal   := '�W��';
  TeeCommanMsg_Edit     := '�ҏW';
  TeeCommanMsg_Print    := '���';
  TeeCommanMsg_Copy     := '�R�s�[';
  TeeCommanMsg_Save     := '�ۑ�';
  TeeCommanMsg_3D       := '3D';

  TeeCommanMsg_Rotating := '��]: %d�� �p: %d��';
  TeeCommanMsg_Rotate   := '��]';

  TeeCommanMsg_Moving   := '�����I�t�Z�b�g: %d �����I�t�Z�b�g: %d';
  TeeCommanMsg_Move     := '�ړ�';

  TeeCommanMsg_Zooming  := '�Y�[��: %d %%';
  TeeCommanMsg_Zoom     := '�Y�[��';

  TeeCommanMsg_Depthing := '3D: %d %%';
  TeeCommanMsg_Depth    := '�[��';

  TeeCommanMsg_Chart    :='�`���[�g';
  TeeCommanMsg_Panel    :='�p�l��';

  TeeCommanMsg_RotateLabel:='%s ���h���b�O����Ɖ�]';
  TeeCommanMsg_MoveLabel  :='%s ���h���b�O����ƈړ�';
  TeeCommanMsg_ZoomLabel  :='%s ���h���b�O����ƃY�[��';
  TeeCommanMsg_DepthLabel :='%s ���h���b�O�����3D�����T�C�Y';

  TeeCommanMsg_NormalLabel:='�ް�(ϳ���������ׯ��) ��۰�(ϳ��E������ׯ��)';
  TeeCommanMsg_NormalPieLabel:='�~�̈�̋敪���h���b�O����ƕ���';

  TeeCommanMsg_PieExploding := '�敪: %d ����: %d %%';

  TeeMsg_TriSurfaceLess:='�|�C���g�̐���4�ȏ�ɂ��Ă��������B';
  TeeMsg_TriSurfaceAllColinear:='���꒼����ɂ���f�[�^�|�C���g�̑S��';
  TeeMsg_TriSurfaceSimilar:='�ގ������|�C���g�͎��s�ł��܂���B';
  TeeMsg_GalleryTriSurface:='��̪�(�O�p)';

  TeeMsg_AllSeries := '�S�Ă̌n��';
  TeeMsg_Edit      := '�ҏW';

  TeeMsg_GalleryFinancial    :='���Z';

  TeeMsg_CursorTool    := '�J�[�\��';
  TeeMsg_DragMarksTool := '�h���b�O�}�[�J';
  TeeMsg_AxisArrowTool := '�����';
  TeeMsg_DrawLineTool  := '�h���[���C��';
  TeeMsg_NearestTool   := '�ߖT�_';
  TeeMsg_ColorBandTool := '�J���[�o���h';
  TeeMsg_ColorLineTool := '�J���[���C��';
  TeeMsg_RotateTool    := '��]';
  TeeMsg_ImageTool     := '�C���[�W';
  TeeMsg_MarksTipTool  := '�}�[�J�`�b�v';
  Teemsg_AnnotationTool:= '�A�m�e�[�V����';

  TeeMsg_CantDeleteAncestor  := '�e�N���X�͍폜�ł��܂���B';

  TeeMsg_Load            := '�Ǎ�...';
  TeeMsg_NoSeriesSelected:= '�n�񂪑I������Ă��܂���B';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  := 'Chart';
  TeeMsg_CategorySeriesActions := 'Chart Series';

  TeeMsg_Action3D               := '3D(&3)';
  TeeMsg_Action3DHint           := '�؂�ւ� 2D / 3D';
  TeeMsg_ActionSeriesActive     := '�L��(&A)';
  TeeMsg_ActionSeriesActiveHint := '�\�� / ��\�� �n��';
  TeeMsg_ActionEditHint         := '�`���[�g�̕ҏW';
  TeeMsg_ActionEdit             := '�ҏW(&E)...';
  TeeMsg_ActionCopyHint         := '�N���b�v�{�[�h�փR�s�[';
  TeeMsg_ActionCopy             := '�R�s�[(&C)';
  TeeMsg_ActionPrintHint        := '�`���[�g�̈���v���r���[';
  TeeMsg_ActionPrint            := '���(&P)...';
  TeeMsg_ActionAxesHint         := '�\�� / ��\�� ��';
  TeeMsg_ActionAxes             := '��(&A)';
  TeeMsg_ActionGridsHint        := '�\�� / ��\�� �O���b�h';
  TeeMsg_ActionGrids            := '�O���b�h(&G)';
  TeeMsg_ActionLegendHint       := '�\�� / ��\�� �}��';
  TeeMsg_ActionLegend           := '�}��(&L)';
  TeeMsg_ActionSeriesEditHint   := '�n��̕ҏW';
  TeeMsg_ActionSeriesMarksHint  := '�\�� / ��\�� �n��̃}�[�J';
  TeeMsg_ActionSeriesMarks      := '�}�[�J(&M)';
  TeeMsg_ActionSaveHint         := '�`���[�g�̕ۑ�';
  TeeMsg_ActionSave             := '�ۑ�(&S)...';

  TeeMsg_CandleBar              := '����';
  TeeMsg_CandleNoOpen           := '�n�l�Ȃ�';
  TeeMsg_CandleNoClose          := '�I�l�Ȃ�';
  TeeMsg_NoLines                := '���Ȃ�';
  TeeMsg_NoHigh                 := '���l�Ȃ�';
  TeeMsg_NoLow                  := '���l�Ȃ�';
  TeeMsg_ColorRange             := '�F�͈�';
  TeeMsg_WireFrame              := '���C���[';
  TeeMsg_DotFrame               := '�_';
  TeeMsg_Positions              := '���x���ʒu';
  TeeMsg_NoGrid                 := '��د�ނȂ�';
  TeeMsg_NoPoint                := '�߲�ĂȂ�';
  TeeMsg_NoLine                 := '���Ȃ�';
  TeeMsg_Labels                 := '���x���t';
  TeeMsg_NoCircle               := '�O�~�Ȃ�';
  TeeMsg_Lines                  := '�����t';
  TeeMsg_Border                 := '�g�t';

  TeeMsg_SmithResistance      := '��R';
  TeeMsg_SmithReactance       := 'ر��ݽ';

  TeeMsg_Column  := '��';

  { 5.01 }
  TeeMsg_Separator            :='���ڰ�';
  TeeMsg_FunnelSegment        :='������ ';
  TeeMsg_FunnelSeries         :='�t�@�l��';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='�����ȏ�';
  TeeMsg_FunnelWithin         :=' �����ȓ�';
  TeeMsg_FunnelBelow          :=' �����ȉ�';
  TeeMsg_CalendarSeries       :='�J�����_�[';
  TeeMsg_DeltaPointSeries     :='�����߲��';
  TeeMsg_ImagePointSeries     :='�Ұ���߲��';
  TeeMsg_ImageBarSeries       :='�C���[�W�o�[';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Field �̐���0���傫�Ȓl��ݒ肵�Ă��������B';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='JPEG(&J)';
  TeeMsg_JPEGFilter    :='JPEG�t�@�C�� (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='GIF(&G)';
  TeeMsg_GIFFilter     :='GIF�t�@�C�� (*.gif)|*.gif';
  TeeMsg_AsPNG         :='PNG(&P)';
  TeeMsg_PNGFilter     :='PNG�t�@�C�� (*.png)|*.png';
  TeeMsg_AsPCX         :='PCX(&X)';
  TeeMsg_PCXFilter     :='PCX�t�@�C�� (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='VML(HTM)(&V)';
  TeeMsg_VMLFilter     :='VML�t�@�C�� (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_Origin               := '���_';
  TeeMsg_Transparency         := '����';
  TeeMsg_Box                  := '��';
  TeeMsg_ExtrOut              := '�ɒl';
  TeeMsg_MildOut              := '�O��l';
  TeeMsg_PageNumber           := '�y�[�W��';

  { 5.03 }
  TeeMsg_DragPoint            := '�h���b�O�|�C���g';
  TeeMsg_OpportunityValues    := '������è�l';
  TeeMsg_QuoteValues          := '���Ēl';

  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'ActiveX �����[�X ' + AXVer;
  TeeMsg_ActiveXCannotImport := '%s����TeeChart���C���|�[�g�ł��܂���B';
  TeeMsg_ActiveXVerbPrint    := '�v���r���[';
  TeeMsg_ActiveXVerbExport   := '�G�N�X�|�[�g';
  TeeMsg_ActiveXVerbImport   := '�C���|�[�g';
  TeeMsg_ActiveXVerbHelp     := '�w���v';
  TeeMsg_ActiveXVerbAbout    := '�o�[�W�������';
  TeeMsg_ActiveXError        := 'TeeChart: �G���[�R�[�h: %d �_�E�����[�h: %s';
  TeeMsg_DatasourceError     := 'TeeChart�̃f�[�^�\�[�X�͌n��܂��̓��R�[�h�Z�b�g�ł͂���܂���B';
  TeeMsg_SeriesTextSrcError  := '�����Ȍn��^';
  TeeMsg_AxisTextSrcError    := '�����Ȏ��^';
  TeeMsg_DelSeriesDatasource := '%s���폜���Ă�낵���ł����H';
  TeeMsg_OCXNoPrinter        := '�v�����^���C���X�g�[������Ă��܂���B';
  TeeMsg_ActiveXPictureNotValid:='�s�N�`���������ł��B';
  {$ENDIF}

  { 6.0 }
  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='PDF(&P)';
  TeeMsg_PDFFilter        :='PDF�t�@�C�� (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='PostScript';
  TeeMsg_PSFilter         :='PostScript�t�@�C�� (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='����';
  TeeMsg_SelfStack        :='�P�Ɛςݏd��';
  TeeMsg_DarkPen          :='�g���Â�';
  TeeMsg_SelectFolder     :='�ް��ް���̫��ނ�I�����Ă�������';
  TeeMsg_BDEAlias         :='�G���A�X(&A):';
  TeeMsg_ADOConnection    :='�ڑ�(&C):';

  { TeeProCo }
  TeeMsg_FunctionSmooth       :='�X���[�Y';
  TeeMsg_FunctionCross        :='�N���X�|�C���g';
  TeeMsg_GridTranspose        :='3D�O���b�h�u��';
  TeeMsg_FunctionCompress     :='����گ���';
  TeeMsg_ExtraLegendTool      :='�g���}��';
  TeeMsg_FunctionCLV          :='CLV';
  TeeMsg_FunctionOBV          :='OBV';
  TeeMsg_FunctionCCI          :='CCI';
  TeeMsg_FunctionPVO          :='PVO';
  TeeMsg_SeriesAnimTool       :='�n��A�j���[�V����';
  TeeMsg_GalleryPointFigure   :='�߲��&̨�ޭ�';
  TeeMsg_Up                   :='����';
  TeeMsg_Down                 :='�޳�';
  TeeMsg_GanttTool            :='�K���g�h���b�O';
  TeeMsg_XMLFile              :='XML�t�@�C��';
  TeeMsg_GridBandTool         :='�O���b�h�o���h';
  TeeMsg_FunctionPerf         :='�p�t�H�[�}���X';
  TeeMsg_GalleryGauge         :='�Q�[�W';
  TeeMsg_GalleryGauges        :='�Q�[�W';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='3D �x�N�^';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='�^���[';
  TeeMsg_SingleColor          :='�P��F';
  TeeMsg_Cover                :='�J�o�[';
  TeeMsg_Cone                 :='�~��';
  TeeMsg_PieTool              :='�~�X���C�X';

  { 6.01 }
  TeeMsg_TextFilter1  :='��߰���������Ƃ���÷��̧�� (*.txt)|*.txt';
  TeeMsg_TextFilter2  :='��ނ�������Ƃ���÷��̧�� (*.txt)|*.txt';
  TeeMsg_TextFilter3  :='��ς�������Ƃ���÷��̧�� (*.csv)|*.csv';
  TeeMsg_TextFilter4  :='��݂�������Ƃ���÷��̧�� (*.txt)|*.txt';
  TeeMsg_TextFilter5  :='���т�������Ƃ���÷��̧�� (*.txt)|*.txt';
  TeeMsg_XMLFilter    :='XML�t�@�C�� (*.xml)|*.xml';
  TeeMsg_HTMLFilter   :='HTML�t�@�C�� (*.htm)|*.htm';
  TeeMsg_ExcelFilter  :='Microsoft Excel�t�@�C�� (*.xls)|*.xls';

  // 6.02
  TeeMsg_Apply            :='�K�p(&A)';
  TeeMsg_AddNewGroup      :='�V������ٰ�߂̒ǉ�';
  TeeMsg_ChangeGroupName  :='�O���[�v���̕ύX';
  TeeMsg_GroupName        :='�O���[�v��:';
  TeeMsg_FunctionMedian   :='���f�B�A��';
  TeeMsg_FunctionMode     :='���[�h';
  TeeMsg_Options          :='�I�v�V����(&O)...';
  TeeMsg_DepthTopAxis     :='����(��)';

  // 7.0
  TeeMsg_View2D           :='2D';
  TeeMsg_Outline          :='���ײ�';

  // 7.05
  TeeMsg_ViewOrthoRight   :='���� �E';
  TeeMsg_ViewOrthoLeft    :='���� ��';
  TeeMsg_View3DFront      :='3D �O';
  TeeMsg_View3DRight      :='3D �E';
  TeeMsg_View3DLeft       :='3D ��';
  TeeMsg_AsSVG            :='SVG(&S)';
  TeeMsg_SVGFilter        :='SVG�t�@�C�� (*.svg)|*.svg';

  TeeMsg_SubTitle := '�T�u�^�C�g��';
  TeeMsg_SubFoot  := '�T�u�t�b�^�[';

  // 8.0
  TeeMsg_FunctionSubset   :='�����W��';
  TeeMsg_Hexagon          :='�Z�p�`';
  TeeMsg_AntiAlias        :='�A���`�G�C���A�X';
  TeeMsg_Percent          :='�S����';
  TeeMsg_Smooth           :='���炩';
  TeeMsg_Blur             :='�ڂ���';
  TeeMsg_Width            :='��';
  TeeMsg_Resize           :='���T�C�Y';
  TeeMsg_Left             :='��';
  TeeMsg_Top              :='��';
  TeeMsg_Crop             :='�؂���';
  TeeMsg_Invert           :='�F�̔��]';
  TeeMsg_GrayScale        :='�O���[�X�P�[��';
  TeeMsg_Mosaic           :='���U�C�N';
  TeeMsg_Flip             :='�㉺���]';
  TeeMsg_Reverse          :='���E���]';
  TeeMsg_Brightness       :='�P�x';
  TeeMsg_Color            :='�F';
  TeeMsg_HueLumSat        :='�F��,�P�x,�ʓx';
  TeeMsg_Sharpen          :='����';
  TeeMsg_GammaCorrection  :='�K���} �R���N�V����';
  TeeMsg_Emboss           :='�G���{�X';
  TeeMsg_Contrast         :='�R���g���X�g';
  TeeMsg_Rotate           :='��]';
  TeeMsg_Back             :='�w�i�F';
  TeeMsg_Autosize         :='�����T�C�Y';
  TeeMsg_Mirror           :='��';
  TeeMsg_Columns          :='��';
  TeeMsg_Rows             :='�s';
  TeeMsg_Tile             :='�^�C��';
  TeeMsg_Bevel            :='�x�x��';
  TeeMsg_Zoom             :='�Y�[��';
  TeeMsg_ThemeDefault     :='�f�t�H���g';
  TeeMsg_ThemeTeeChart    :='TeeChart';
  TeeMsg_ThemeExcel       :='Excel';
  TeeMsg_ThemeVictorian   :='�r�N�g���A';
  TeeMsg_ThemePastels     :='�p�X�e��';
  TeeMsg_ThemeSolid       :='�\���b�h';
  TeeMsg_ThemeClassic     :='�N���V�b�N';
  TeeMsg_ThemeWeb         :='Web';
  TeeMsg_ThemeModern      :='���_��';
  TeeMsg_ThemeRainbow     :='��';
  TeeMsg_ThemeWinXP       :='Win. XP';
  TeeMsg_ThemeMacOS       :='Mac OS';
  TeeMsg_ThemeWinVista    :='Win. Vista';
  TeeMsg_ThemeGrayScale   :='�O���[�X�P�[��';
  TeeMsg_ThemeOpera       :='�I�y��';
  TeeMsg_ThemeWarm        :='�E�H�[��';
  TeeMsg_ThemeCool        :='�N�[��';

  TeeMsg_MenuFilters      :='�t�B���^(&F)...';
  TeeMsg_CrossTab         :='�N���X�^�u';
  TeeMsg_DBSumEditCaption :='�T�}���[�̃v���p�e�B';

  // v8.02
  TeeMsg_AsFlex               :='Flex (Flash)';
  TeeMsg_FlexFilter           :='Flex Flash �t�@�C�� (*.mxml)|*.mxml';
  TeeMsg_AsXAML               :='XAML (WPF)';
  TeeMsg_XAMLFilter           :='XAML�t�@�C�� (*.xaml)|*.xaml';
  TeeMsg_SelectTmpFolder      :='�e���|�����t�H���_��I�����Ă�������';
  TeeMsg_PathAdobeFlexCompiler:='Adobe Flex mxmlc.exe �R���p�C���̃t�H���_��I�����Ă�������';
  TeePolarDegreeSymbol        :='��';
  TeeMsg_NewChart             :='�V�����`���[�g';
  TeeMsg_RenameChart          :='�`���[�g���̕ύX';
  TeeMsg_ChartName            :='�`���[�g�̖���:';
  TeeMsg_SelectTextFile       :='�e�L�X�g�t�@�C����I�����Ă�������';
  TeeMsg_SaveTextFile         :='�e�L�X�g�t�@�C���̕ۑ�';
  TeeMsg_RecordVideo          :='�r�f�I�^�� !(&R)';

  { TeeProCo }
  // 7.0
  TeeMsg_Stop                 :='��~';
  TeeMsg_Execute              :='���s!';
  TeeMsg_Themes               :='�e�[�}';
  TeeMsg_LightTool            :='2D �Ɩ�';
  TeeMsg_Current              :='�J�����g';
  TeeMsg_FunctionCorrelation  :='����';
  TeeMsg_FunctionVariance     :='���U';
  TeeMsg_GalleryBubble3D      :='3D �A';
  TeeMsg_GalleryHorizHistogram:='���q�X�g�O����';
  TeeMsg_FunctionPerimeter    :='���E';
  TeeMsg_SurfaceNearestTool   :='�T�[�t�F�X�ߖT';
  TeeMsg_AxisScrollTool       :='���X�N���[��';
  TeeMsg_RectangleTool        :='��`';
  TeeMsg_GalleryPolarBar      :='�ɖ_';
  TeeMsg_AsWapBitmap          :='ܲ�ڽ �ޯ�ϯ��';
  TeeMsg_WapBMPFilter         :='ܲ�ڽ �ޯ�ϯ�� (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='�N���b�v�n��';
  TeeMsg_SeriesBandTool       :='�n��o���h';

  // 7.01
  TeeMsg_ThemeFacts           :='�t�@�N�g';
  TeeMsg_FunctionDownSampling :='�޳ݻ����ݸ�';

  TeeMsg_SelectorTool         :='�Z���N�^';
  TeeMsg_LegendScrollBar      :='�}��X�N���[���o�[';

  // 7.06
  TeeMsg_DataTableTool        :='�f�[�^�e�[�u��';

  // 8.0
  TeeMsg_IsoSurfaceSeries     :='Iso �T�[�t�F�X';
  TeeMsg_UpToValue            :='���̒l�܂�';	//'Up to Value'
  TeeMsg_NoCompression        :='�񈳏k'; // TeeVideo tool

  TeeMsg_GalleryDarvas        :='�_�[�o�X';
  TeeMsg_VideoTool            :='�r�f�I�N���G�C�^�[';
  TeeMsg_VideoToolDesc        :='�`���[�g�C���[�W��AVI�r�f�I�Ƃ��č쐬���܂�';
  TeeMsg_VideoPlayerTool      :='�r�f�I�v���C���[';
  TeeMsg_VideoPlayerToolDesc  :='�`���[�g�̈�̓����Ƀr�f�I���Đ����܂�';

  TeeMsg_CursorToolDesc       :='�n���Ƀh���b�O�\�ȃJ�[�\������`�悵�܂��B';
  TeeMsg_DragMarksDesc        :='�}�E�X���h���b�O���邱�Ƃɂ��n��}�[�J���ړ��ł��܂��B';
  TeeMsg_DragPointDesc        :='�}�E�X���h���b�O���邱�Ƃɂ��n��|�C���g���ړ��ł��܂��B';
  TeeMsg_DrawLineDesc         :='�}�E�X�̃h���b�O�ɂ��J�X�^���Ȑ��̕`�悪�L���ɂȂ�܂��B';
  TeeMsg_ExtraLegendDesc      :='�`���[�g���̔C�ӂ̈ʒu�ɃJ�X�^���Ȗ}���`�悵�܂��B';
  TeeMsg_GanttToolDesc        :='�K���g�o�[�̃h���b�O�⃊�T�C�Y���L���ɂȂ�܂��B';
  TeeMsg_MarksTipDesc         :='�n��|�C���g��Ƀ}�E�X�J�[�\�����ړ����邢�̓N���b�N����Ɓu�`�b�v�v���邢�́u�q���g�v��\�����܂��B';
  TeeMsg_NearestToolDesc      :='�}�E�X�J�[�\���ɍł��߂��n��|�C���g�Ƀ}�[�J��`�悵�܂��B';
  TeeMsg_PieToolDesc          :='�}�E�X���ړ����邢�̓N���b�N����Ɖ~�X���C�X���t�H�[�J�X���邢�͕������܂��B';
  TeeMsg_SeriesAnimationDesc  :='�n��|�C���g�����_����l�܂ŐL�тčs����������s���܂��B';
  TeeMsg_AxisArrowDesc        :='�����X�N���[�����邽�߂Ɏ��̍ŏ��ƍŌ�̈ʒu�ɃN���b�N�\�Ȗ���\�����܂��B';
  TeeMsg_ColorBandDesc        :='�w�肵������ʒu�ɐF�t����`�i�o���h�j��`�悵�܂��B';
  TeeMsg_ColorLineDesc        :='�w�肵�����̈ʒu�Ƀh���b�O�\�Ȑ���`�悵�܂��B';
  TeeMsg_GridBandDesc         :='�w�肵������2�{�̌��݂̐F�t����`�i�o���h�j��`�悵�܂��B';
  TeeMsg_GridTransposeDesc    :='�n���90�x��]�����邽�߂�X��Z�̍��W���������܂��B';
  TeeMsg_AnnotationDesc       :='�`���[�g���̔C�ӂ̈ʒu�ɃJ�X�^���ȃe�L�X�g��`�悵�܂��B';
  TeeMsg_RectangleToolDesc    :='���T�C�Y�\�ȋ�`���̔C�ӂ̈ʒu�ɃJ�X�^���ȃe�L�X�g��`�悵�܂��B';
  TeeMsg_RotateDesc           :='�}�E�X�h���b�O�ɂ��`���[�g�̉�]��L���ɂ��܂��B';

//  TeeMsg_SeriesHotspotDesc    :='Displays "tips" or "hints" or provides drilldown capacity when the end-user moves or clicks the mouse over a series point.';
//  TeeMsg_ZoomToolDesc         :='Provides clientside Chart zoom functionality for WebCharts on a WebForm';

  TeeMsg_ImageToolDesc        :='�w�肵���n�񎲂͈̔͂ɃC���[�W��`�悵�܂��B�����Y�[�����邢�̓X�N���[�����ꂽ�ꍇ�A�C���[�W���V�����͈͂ɏ]���ĕ`�悳��܂��B';
  TeeMsg_LightToolDesc        :='�`���[�g�L�����o�X���2D�́u�Ɩ��v���ʂ�`�悵�܂��B';
  TeeMsg_SurfaceNearestDesc   :='�T�[�t�F�X�n���Ń}�E�X���ړ������ꍇ�A�}�E�X�J�[�\���ɍł��߂��T�[�t�F�X�Z���Ƀ}�[�J��\�����܂��B';
  TeeMsg_AxisScrollDesc       :='�}�E�X�̃h���b�O�ɂ�莲�̃X�N���[�����L���ɂȂ�܂��B';
  TeeMsg_LegendScrollBarDesc  :='�}��̃X�N���[�����L���ɂȂ�܂��B';
  TeeMsg_ClipSeriesDesc       :='�n����֘A�t���Ă��鎲�͈͓̔��ɕ`�悵�܂��B';
  TeeMsg_SelectorDesc         :='�`���[�g�A�C�e����A�m�e�[�V�����̑I����h���b�O��L���ɂ��܂��B';
  TeeMsg_StatsToolDesc        :='�n��f�[�^�Ɋւ��铝�v����\�����܂��B';
  TeeMsg_PageNumberDesc       :='�`���[�g�Ɍ��݂̃`���[�g�y�[�W�ԍ��⍇�v�y�[�W����\�����܂��B';

  TeeMsg_TransposeSeries      :='�n��u��';
  TeeMsg_TransposeSeriesDesc  :='�n��̍s�Ɨ�����ւ��܂��B';
  TeeMsg_GridTranspDesc       :='3D�O���b�h�n��ɂ����āAZ�l��X�l�ɒu�����܂��B';
  TeeMsg_LegendScrollDesc     :='�}��ɃX�N���[���o�[��`�悵�܂��B';
  TeeMsg_DataTableDesc        :='�n��̃f�[�^�l�ŃO���b�h��`�悵�܂��B';
  TeeMsg_SeriesBandDesc       :='2�̌n��Ԃ̗̈��h��Ԃ��܂��B';

  TeeMsg_ThemeRandom          :='�����_��';
  TeeMsg_Play                 :='�Đ�(&P)';
  TeeMsg_GalleryHighLowLine   :='HighLow ���C��';
  TeeMsg_Mirrored             :='��';
  TeeMsg_PolarGridSeries      :='�ɃO���b�h';

  TeeMsg_FullScreen           :='�S���';
  TeeMsg_FullScreenDesc       :='�`���[�g���ő剻���đS��ʂɕ\�����܂�';

  TeeMsg_MagnifyTool          :='���ዾ';
  TeeMsg_MagnifyToolDesc      :='�`���[�g�̈ꕔ���g�債�܂�';

  TeeMsg_Fader                :='�t�F�[�_';
  TeeMsg_FaderDesc            :='�`���[�g�̃A�j���[�V����������ɂ͂����肳���܂��B';

  TeeMsg_SubChartTool         :='�T�u�`���[�g';
  TeeMsg_SubChartDesc         :='�`���[�g���ɕ����̃`���[�g��`�悵�܂��B';

  //��Őݒ肳��Ă��邽��
  //TeeMsg_AntiAlias            :='Anti-Alias';
  TeeMsg_AntiAliasDesc        :='�W�O�U�O���������đΊp����Ȑ��̕\�������炩�ɂ��܂��B';

  TeeMsg_SeriesRegion         :='�n��̈�';
  TeeMsg_SeriesRegionDesc     :='�Œ肵���l�ƌn��|�C���g�Ԃ̗̈��h��Ԃ��܂��B';

  TeeMsg_Text3D               :='�e�L�X�g 3D';
  TeeMsg_Text3DDesc           :='3D�t�H���g��3D��]�Ńe�L�X�g��`�悵�܂��B';

  TeeMsg_BannerTool           :='�o�i�[';
  TeeMsg_BannerToolDesc       :='�e�L�X�g�̃X�N���[���Ɠ_��';

  TeeMsg_MenuNew              :='�V�K(&N)';
  TeeMsg_MenuDelete           :='�폜(&D)';
  TeeMsg_MenuRename           :='���l�[��(&R)...';
  TeeMsg_MenuEdit             :='�ҏW(&E)...';
  TeeMsg_MenuViewToolbar      :='�c�[���o�[�̕\��(&V)';
  TeeMsg_RenamePage           :='�`���[�g�y�[�W�̃��l�[��';
  TeeMsg_NewName              :='�V��������:';

  TeeMsg_FrameTool            :='�t���[��';
  TeeMsg_FrameToolDesc        :='�`���[�g�p�l���̎���ɑ����I�Șg��`�悵�܂��B';

  TeeMsg_HistogramFunction    :='�q�X�g�O����';

  TeeMsg_ExcelEmptyFile       :='Excel �t�@�C������ł�';
  TeeMsg_ExcelFile            :='Excel';
  TeeMsg_ExcelSheetEmpty      :='Excel �̃��[�N�V�[�g���w�肵�Ȃ���΂Ȃ�܂���B';
  TeeMsg_ExcelRangeMissing    :='�͈͂��w�肵�ĂȂ���΂Ȃ�܂���i��FA1����A10�j�B';
  //��Őݒ肳��Ă��邽��
  //TeeMsg_DBSumEditCaption     :='Summary properties';
  TeeMsg_LegendPalette        :='�}��p���b�g';
  TeeMsg_LegendPaletteDesc    :='3D�n��̃p���b�g�F�ō쐬�����}���\�����܂��B';
  TeeMsg_Statistics           :='�n�񓝌v';
  TeeMsg_TeeScrollBar         :='�X�N���[���o�[';

  TeeMsg_GalleryOrgSeries     :='�g�D�}';

  TeeMsg_GalleryWorld         :='���E';
  TeeMsg_GalleryAfrica        :='�A�t���J';
  TeeMsg_GalleryAsia          :='�A�W�A';
  TeeMsg_GalleryAustralia     :='�I�[�X�g�����A';
  TeeMsg_GalleryCentralAmerica:='�����A�����J';
  TeeMsg_GalleryEurope        :='���[���b�p';
  TeeMsg_GalleryEurope15      :='���[���b�p 15';
  TeeMsg_GalleryEurope27      :='���[���b�p 27';
  TeeMsg_GallerySpain         :='�X�y�C��';
  TeeMsg_GalleryMiddleEast    :='����';
  TeeMsg_GalleryNorthAmerica  :='�k�A�����J';
  TeeMsg_GallerySouthAmerica  :='��A�����J';
  TeeMsg_GalleryUSA           :='�A�����J';
  TeeMsg_GalleryUSAHawaiiAlaska:='��ض �ܲ �׽�';
  TeeMsg_GalleryMaps          :='�}�b�v';
  TeeMsg_GalleryTagCloud      :='�^�O�N���E�h';
  TeeMsg_GalleryRenko         :='���s��';
  TeeMsg_GalleryKagi          :='������';

  // v8.01

  TeeMsg_NumericGauge         :='���l�Q�[�W';
  TeeMsg_CircularGauge        :='�~�`�Q�[�W';
  TeeMsg_LEDGauge             :='LED';
  TeeMsg_LinearGauge          :='�����`�Q�[�W';

  TeeMsg_LinkTool             :='�����N';
  TeeMsg_LinkToolDesc         :='URL�A�h���X�փi�r�Q�[�g���邽�߂ɃN���b�N�\�ȃe�L�X�g��\�����܂��B';

  TeeMsg_Fibonacci            :='�t�B�{�i�b�`';
  TeeMsg_FibonacciDesc        :='���Z�f�[�^��Ƀt�B�{�i�b�`�̌ʂ���`�悵�܂��B';

  // v8.02
  TeeMsg_LinearGaugeVertical  :='�c���`�Q�[�W';
  TeeMsg_AVIFile              :='AVI �t�@�C��';
  TeeMsg_SelectAVIFile        :='�r�f�I��ۑ�����AVI�t�@�C���I�����Ă�������';
  TeeMsg_MPEGFile             :='MPEG �r�f�I�t�@�C��';
end;

Procedure TeeCreateJapanese;
begin
  if not Assigned(TeeJapaneseLanguage) then
  begin
    TeeJapaneseLanguage:=TStringList.Create;
    TeeJapaneseLanguage.Text:=
'GRADIENT EDITOR=����ް��� ��ި�'#13+
'GRADIENT=����ް���'#13+
'DIRECTION=����'#13+
'VISIBLE=�\��'#13+
'TOP BOTTOM=��������'#13+
'BOTTOM TOP=�ォ�牺��'#13+
'LEFT RIGHT=�E���獶��'#13+
'RIGHT LEFT=������E��'#13+
'FROM CENTER=��������'#13+
'FROM TOP LEFT=�E�������'#13+
'FROM BOTTOM LEFT=�E��������'#13+
'OK=OK'#13+
'CANCEL=�L�����Z��'#13+
'COLORS=�F'#13+
'START=�J�n'#13+
'MIDDLE=����'#13+
'END=�I��'#13+
'SWAP=����'#13+
'NO MIDDLE=�����s��'#13+
'TEEFONT EDITOR=TeeFont ��ި�'#13+
'INTER-CHAR SPACING=�����̊Ԋu'#13+
'FONT=�t�H���g'#13+
'SHADOW=�e'#13+
'HORIZ. SIZE=��������'#13+
'VERT. SIZE=��������'#13+
'COLOR=�F'#13+
'OUTLINE=���ײ�'#13+
'FORMAT=�`��'#13+
'BEVEL=�����'#13+
'SIZE=����'#13+
//V8.03
//'FRAME=�g'#13+
'FRAME=�ڰ�'#13+
'PATTERN=�����'#13+
'ROUND FRAME=�g�̊p���ۂ�����'#13+
'TRANSPARENT=����'#13+
'NONE=�Ȃ�'#13+
'LOWERED=��'#13+
'RAISED=��'#13+
'COLOR=�F'#13+
'LEFT TOP=����'#13+
'LEFT BOTTOM=����'#13+
'RIGHT TOP=�E��'#13+
'RIGHT BOTTOM=�E��'#13+
'MULTIPLE AREAS=����'#13+
'STACKED=�ςݏd��'#13+
'STACKED 100%=�S����'#13+
'AREA=��'#13+
'STAIRS=�K�i'#13+
'SOLID=�h��Ԃ�'#13+
'CLEAR=�Ȃ�'#13+
'HORIZONTAL=����'#13+
'VERTICAL=����'#13+
'DIAGONAL=�E������ΐ�'#13+
'B.DIAGONAL=�E�オ��ΐ�'#13+
'CROSS=������'#13+
'DIAG.CROSS=�΂ߌ�����'#13+
'AREA LINES=�����'#13+
'BORDER=�g'#13+
'INVERTED=���]'#13+
'COLOR=�F'#13+
'COLOR EACH=�F�𕪂���'#13+
'ORIGIN=���_'#13+
'USE ORIGIN=���_���g�p'#13+
'WIDTH=��'#13+
'HEIGHT=����'#13+
'TEECHART LANGUAGES=TeeChart ����'#13+
'CHOOSE A LANGUAGE=����̑I��'#13+
'SELECT ALL=�S�đI��'#13+
'MOVE UP=��ֈړ�'#13+
'MOVE DOWN=���ֈړ�'#13+
'CANCEL=�L�����Z��'#13+
'AXIS=��'#13+
'LENGTH=����'#13+
'POSITION=�ʒu'#13+
'SCROLL=�X�N���[��'#13+
'START=�J�n'#13+
'END=�I��'#13+
'BOTH=����'#13+
'INVERTED SCROLL=�t�X�N���[��'#13+
'AXIS INCREMENT=Axis Increment'#13+
'INCREMENT=������'#13+
'INCREMENT=������'#13+
'STANDARD=�W��'#13+
'CUSTOM=����'#13+
'ONE MILLISECOND=1�~���b'#13+
'ONE SECOND=1�b'#13+
'FIVE SECONDS=5�b'#13+
'TEN SECONDS=10�b'#13+
'FIFTEEN SECONDS=15�b'#13+
'THIRTY SECONDS=30�b'#13+
'ONE MINUTE=1��'#13+
'FIVE MINUTES=5��'#13+
'TEN MINUTES=10��'#13+
'FIFTEEN MINUTES=15��'#13+
'THIRTY MINUTES=30��'#13+
'ONE HOUR=1����'#13+
'TWO HOURS=2����'#13+
'SIX HOURS=6����'#13+
'TWELVE HOURS=12����'#13+
'ONE DAY=1��'#13+
'TWO DAYS=2��'#13+
'THREE DAYS=3��'#13+
'ONE WEEK=1�T��'#13+
'HALF MONTH=����'#13+
'ONE MONTH=1����'#13+
'TWO MONTHS=2����'#13+
'THREE MONTHS=3����'#13+
'FOUR MONTHS=4����'#13+
'SIX MONTHS=6����'#13+
'ONE YEAR=1�N'#13+
'EXACT DATE TIME=���m�ȓ��t'#13+
'AXIS MAXIMUM AND MINIMUM=���̍ő�l�ƍŏ��l'#13+
'VALUE=�l'#13+
'DATE=���t'#13+
'TIME=����'#13+
'LEFT AXIS=����'#13+
'RIGHT AXIS=�E��'#13+
'TOP AXIS=�㎲'#13+
'BOTTOM AXIS=����'#13+
'% BAR WIDTH=�_�̕�'#13+
'STYLE=����'#13+
'% BAR OFFSET=�_�̈ʒu'#13+
'RECTANGLE=��`'#13+
'PYRAMID=�l�p��'#13+
'INVERT. PYRAMID=�|���l�p��'#13+
'CYLINDER=�~��'#13+
'ELLIPSE=�ȉ~'#13+
'ARROW=���'#13+
'RECT. GRADIENT=����ް��݋�`'#13+
'CONE=�~��'#13+
'DARK BAR 3D SIDES=3D�����Â�����'#13+
'BAR SIDE MARGINS=�_�̘e�ɗ]�������'#13+
'AUTO MARK POSITION=ϰ��ʒu�̎�������'#13+
'GRADIENT=����ް���'#13+
'JOIN=����'#13+
'AUTO MARK POSITION=ϰ��ʒu�̎�������'#13+
'DATASET=�ް����'#13+
'APPLY=�K�p'#13+
'SOURCE=�\�[�X'#13+
'COLORS=�F'#13+
'MONOCHROME=���m�N��'#13+
'DEFAULT=��̫��'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=�����l'#13+
'WHISKER=�Ђ�'#13+
'PATTERN COLOR EDITOR=�p�^�[���ƐF�̐ݒ�'#13+
'IMAGE=�C���[�W'#13+
'IMAGE=�C���[�W'#13+
'BACK DIAGONAL=�E�オ��ΐ�'#13+
'DIAGONAL CROSS=�΂ߌ�����'#13+
'FILL 80%=�h��Ԃ� 80%'#13+
'FILL 60%=�h��Ԃ� 60%'#13+
'FILL 40%=�h��Ԃ� 40%'#13+
'FILL 20%=�h��Ԃ� 20%'#13+
'FILL 10%=�h��Ԃ� 10%'#13+
'ZIG ZAG=�W�O�U�O'#13+
'VERTICAL SMALL=������ (��)'#13+
'HORIZ. SMALL=������ (��)'#13+
'DIAG. SMALL=�E������ΐ� (��)'#13+
'BACK DIAG. SMALL=�E�オ��ΐ� (��)'#13+
'CROSS SMALL=������ (��)'#13+
'DIAG. CROSS SMALL=�΂ߌ����� (��)'#13+
'PATTERN COLOR EDITOR=�p�^�[���ƐF�̐ݒ�'#13+
'OPTIONS=�I�v�V����'#13+
'DAYS=��'#13+
'WEEKDAYS=�j��'#13+
'TODAY=����'#13+
'SUNDAY=���j��'#13+
'TRAILING=�O�㌎'#13+
'MONTHS=�N��'#13+
'LINES=��'#13+
'SHOW WEEKDAYS=�j���̕\��'#13+
'UPPERCASE=�啶��'#13+
'TRAILING DAYS=�O�㌎�̕\��'#13+
'SHOW TODAY=�����̕\��'#13+
'SHOW MONTHS=�N���̕\��'#13+
'UPPERCASE=�啶��'#13+
{'UPPERCASE=NOTVisible'#13+}
'SHOW PREVIOUS BUTTON=�O���{�^���̕\��'#13+
'SHOW NEXT BUTTON=�����{�^���̕\��'#13+
'CANDLE WIDTH=�����ق̕�'#13+
'STYLE=����'#13+
'STICK=�_��'#13+
'BAR=����'#13+
'OPEN CLOSE=�n�l�E�I�l'#13+
'UP CLOSE=���l�̐F'#13+
'DOWN CLOSE=���l�̐F'#13+
'SHOW OPEN=�n�l��\��'#13+
'SHOW CLOSE=�I�l��\��'#13+
'BORDER=�g'#13+
'DRAW 3D=3D'#13+
'DARK 3D=3D�����Â�����'#13+
'EDITING=�ҏW��'#13+
'CHART=�`���[�g'#13+
'SERIES=�n��'#13+
'DATA=�f�[�^'#13+
'TOOLS=�c�[��'#13+
'EXPORT=�G�N�X�|�[�g'#13+
'PRINT=���'#13+
'GENERAL=���'#13+
'AXIS=��'#13+
'TITLES=�^�C�g��'#13+
'LEGEND=�}��'#13+
'PANEL=�p�l��'#13+
'PAGING=�y�[�W'#13+
'WALLS=��'#13+
'3D=3D'#13+
'ADD=�ǉ�'#13+
'DELETE=�폜'#13+
'TITLE=����'#13+
'CLONE=����'#13+
'CHANGE=�ύX'#13+
'WWW.STEEMA.COM=www.newtone.co.jp'#13+
'HELP=�w���v'#13+
'CLOSE=����'#13+
'SERIES=�n��'#13+
'IMAGE=�C���[�W'#13+
'TEECHART PRINT PREVIEW=TeeChart ����v���r���['#13+
'PRINTER=�����'#13+
'SETUP=�ݒ�'#13+
'PRINT=���'#13+
'ORIENTATION=����̌���'#13+
'PORTRAIT=�c'#13+
'LANDSCAPE=��'#13+
'MARGINS (%)=�]�� (%)'#13+
'DETAIL=�ڍ�'#13+
'MORE=���ڂ���'#13+
'NORMAL=�W��'#13+
'RESET MARGINS=�]����ؾ��'#13+
'VIEW MARGINS=�]���̕\��'#13+
'PROPORTIONAL=�����l��'#13+
'TEECHART PRINT PREVIEW=TeeChart ����v���r���['#13+
'STYLE=����'#13+
'CIRCLE=�~'#13+
'VERTICAL LINE=������'#13+
'HORIZ. LINE=������'#13+
'TRIANGLE=�O�p�`'#13+
'INVERT. TRIANGLE=�|���O�p�`'#13+
'LINE=����'#13+
'DIAMOND=�H�`'#13+
'CUBE=������'#13+
'STAR=���`'#13+
'BORDER=�g'#13+
'TRANSPARENT=����'#13+
'HORIZ. ALIGNMENT=���������̔z�u'#13+
'LEFT=��'#13+
'CENTER=����'#13+
'RIGHT=�E'#13+
'ROUND RECTANGLE=�p���ۂ�����'#13+
'ALIGNMENT=�z�u'#13+
'TOP=��'#13+
'BOTTOM=��'#13+
'GRADIENT=����ް���'#13+
'LEFT=��'#13+
'RIGHT=:�E'#13+
'TOP=��'#13+
'BOTTOM=��'#13+
'UNITS=�P��'#13+
'PIXELS=�s�N�Z��'#13+
'AXIS ORIGIN=���̌��_'#13+
'ROTATION=��]'#13+
'CIRCLED=���~'#13+
'3 DIMENSIONS=3D'#13+
'RADIUS=���a'#13+
'HORIZONTAL=����'#13+
'VERTICAL=����'#13+
'AUTO=����'#13+
'AUTO=����'#13+
'ANGLE INCREMENT=�p�x�̑�����'#13+
'RADIUS INCREMENT=���a�̑�����'#13+
'CLOSE CIRCLE=�n�_�ƏI�_�̐ڑ�'#13+
'PEN=�y��'#13+
'CIRCLE=�~'#13+
'PATTERN=�����'#13+
'LABELS=���x��'#13+
'ROTATED=90�x��]'#13+
'CLOCKWISE=���v���'#13+
'INSIDE=����'#13+
'ROMAN=۰ϐ���'#13+
'HOURS=����'#13+
'MINUTES=��'#13+
'SECONDS=�b'#13+
'RADIUS=���a'#13+
'START VALUE=�J�n�l'#13+
'END VALUE=�I���l'#13+
'TRANSPARENCY=�����x'#13+
'DRAW BEHIND=�w�ʂɕ`��'#13+
'COLOR MODE=�F�̎��'#13+
'STEPS=�ï��'#13+
'RANGE=�͈�'#13+
'PALETTE=�p���b�g'#13+
'PALE=�W��'#13+
'STRONG=�Z��'#13+
'GRID SIZE=��د�޻���'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=�[��'#13+
'IRREGULAR=�s�K��'#13+
'GRID=�O���b�h'#13+
//'VALUE=�l'#13+
'ALLOW DRAG=�h���b�O��'#13+
'DRAG REPAINT=�h���b�O�̕`��'#13+
'NO LIMIT DRAG=�������h���b�O'#13+
'VERTICAL POSITION=�����ʒu'#13+
'LEVELS POSITION=���x���ʒu'#13+
'LEVELS=���x��'#13+
'NUMBER=��'#13+ {'NUMBER=��'#13+}
'LEVEL=���x��'#13+
'AUTOMATIC=����'#13+
'COLOR EACH=�F�𕪂���'#13+
'STYLE=����'#13+
'SNAP=�ړ�����'#13+
'FOLLOW MOUSE=�}�E�X�ɘA��'#13+
'STACK=�ςݏd��'#13+
'HEIGHT 3D=3D�̍���'#13+
'LINE MODE=���̎��'#13+
'INVERTED=���]'#13+
'DARK 3D=3D�����Â�����'#13+
'OVERLAP=���ްׯ��'#13+
'STACK=�ςݏd��'#13+
'STACK 100%=�S����'#13+
'CLICKABLE=�N���b�N��'#13+
'OUTLINE=���ײ�'#13+
'LABELS=���x��'#13+
'AVAILABLE=�I���\�ȍ���'#13+
'SELECTED=�I�����ꂽ����'#13+
'>=>'#13+
'>>=>>'#13+
'<=<'#13+
'<<=<<'#13+
'DATASOURCE=�ް����'#13+
'GROUP BY=��ٰ��'#13+
'CALC=�v�Z'#13+
'OF=of'#13+
'SUM=�a'#13+
'COUNT=�v�Z'#13+
'HIGH=�ő�'#13+
'LOW=�ŏ�'#13+
'AVG=���ϒl'#13+
'HOUR=����'#13+
'DAY=��'#13+
'WEEK=�T'#13+
'WEEKDAY=�j��'#13+
'MONTH=��'#13+
'QUARTER=�l����'#13+
'YEAR=�N'#13+
'HOLE %=�� %'#13+
'RESET POSITIONS=�ʒu�̃��Z�b�g'#13+
'MOUSE BUTTON=ϳ�����'#13+
'MIDDLE=����'#13+
'ENABLE DRAWING=�`���'#13+
'ENABLE SELECT=�I����'#13+
'ENHANCED=�g��'#13+
'ERROR WIDTH=�װ�̕�'#13+
'WIDTH UNITS=���̒P��'#13+
'PERCENT=�S����'#13+
'PIXELS=�s�N�Z��'#13+
'RIGHT=�E'#13+
'LEFT AND RIGHT=���ƉE'#13+
'TOP AND BOTTOM=��Ɖ�'#13+
'BORDER=�y��'#13+
'BORDER EDITOR=��� ��ި�'#13+
'SOLID=����'#13+
'DASH=�j��'#13+
'DOT=�_��'#13+
'DASH DOT=��_����'#13+
'DASH DOT DOT=��_����'#13+
'DRAW ALL=�S�ĕ`��'#13+
'CALCULATE EVERY=�v�Z'#13+
'ALL POINTS=�S���̓_'#13+
'NUMBER OF POINTS=�|�C���g�̐�'#13+
'RANGE OF VALUES=�l�͈̔�'#13+
'ALIGNMENT=�z�u'#13+
'FIRST=�ŏ�'#13+
'CENTER=����'#13+
'LAST=�Ō�'#13+
'TEEPREVIEW EDITOR=TeePreview ��ި�'#13+
'ALLOW MOVE=�ړ���'#13+
'ALLOW RESIZE=���T�C�Y��'#13+
'DRAG IMAGE=�Ұ�ނ���ׯ��'#13+
'AS BITMAP=�ޯ�ϯ��'#13+
'SHOW IMAGE=�C���[�W�̕\��'#13+
'PORTRAIT=�c'#13+
'LANDSCAPE=��'#13+
'MARGINS=�]��'#13+
'SIZE=����'#13+
'3D %=3D %'#13+
'ZOOM=�Y�[��'#13+
'ELEVATION=�p'#13+
'100%=100%'#13+
'HORIZ. OFFSET=�����̾��'#13+
'VERT. OFFSET=�����̾��'#13+
'PERSPECTIVE=���ߌ���'#13+
'ANGLE=�p�x'#13+
'ORTHOGONAL=����'#13+
'ZOOM TEXT=÷�Ă�ް�'#13+
'SCALES=�X�P�[��'#13+
'TITLE=����'#13+
'TICKS=�ڐ�'#13+
'MINOR=���ڐ�'#13+
'MAXIMUM=�ő�l'#13+
'MINIMUM=�ŏ��l'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=���҂��鑝����'#13+
'(INCREMENT)=(increment)'#13+
'LOG BASE=�ΐ��̊'#13+
'LOGARITHMIC=�ΐ���'#13+
'AUTO=����'#13+
'CHANGE=�ύX'#13+
'CHANGE=�ύX'#13+
'TITLE=����'#13+
'ANGLE=�p�x'#13+
'MIN. SEPARATION %=�ŏ��Ԋu %'#13+
'VISIBLE=�\��'#13+
'MULTI-LINE=�����s'#13+
'LABEL ON AXIS=�����x��'#13+
'ROUND FIRST=�n�_�ő�����'#13+
'AUTO=����'#13+
'VALUE=�l'#13+
'MARK=�}�[�J'#13+
'LABELS FORMAT=�l�̏���'#13+
'EXPONENTIAL=�w��'#13+
'DEFAULT ALIGNMENT=�f�t�H���g�̔z�u'#13+
'LEN=����'#13+
'TICKS=�ڐ�'#13+
'INNER=����'#13+
'AT LABELS ONLY=���x���̂�'#13+
'CENTERED=�����ɔz�u'#13+
'LENGTH=����'#13+
'COUNT=��'#13+
'TICKS=�ڐ�'#13+
'GRID=�O���b�h'#13+
'POSITION %=�ʒu %'#13+
'START %=�J�n %'#13+
'END %=�I�� %'#13+
'OTHER SIDE=���Α�'#13+
'AXES=��'#13+
'VISIBLE=�\��'#13+
'BEHIND=�w��'#13+
'CLIP POINTS=�د��ݸ�'#13+
'PRINT PREVIEW=�������ޭ�'#13+
'ZOOM=�Y�[��'#13+
'SCROLL=�X�N���[��'#13+
'STEPS=�ï��'#13+
'MINIMUM PIXELS=�ŏ��s�N�Z��'#13+
'ALLOW=��'#13+
'ANIMATED=��Ұ���'#13+
'PEN=�y��'#13+
'HORIZONTAL=����'#13+
'VERTICAL=����'#13+
'ALLOW SCROLL=���@'#13+
'NONE=�Ȃ�'#13+
'BOTH=����'#13+
'TEEOPENGL EDITOR=TeeOpenGL ��ި�'#13+
'AMBIENT LIGHT=���޴�Č�'#13+
'SHININESS=���邳'#13+
'FONT 3D DEPTH=3D̫�Ă̐[��'#13+
'ACTIVE=�L��'#13+
'FONT OUTLINES=̫�Ă̱��ײ�'#13+
'SMOOTH SHADING=���炩�ȉe'#13+
'LIGHT=��'#13+
'Y=Y'#13+
'INTENSITY=����'#13+
'SYMBOLS=�V���{��'#13+
'TEXT STYLE=÷�Ľ���'#13+
'LEGEND STYLE=�}�����'#13+
'VERT. SPACING=�c�����̊Ԋu'#13+
'AUTOMATIC=����'#13+
'SERIES NAMES=�n��̖���'#13+
'SERIES VALUES=�n��̒l'#13+
'LAST VALUES=�Ō�̒l'#13+
'PLAIN=������̂�'#13+
'LEFT VALUE=�l���E��'#13+
'RIGHT VALUE=�l������'#13+
'LEFT PERCENT=�S�������E��'#13+
'RIGHT PERCENT=�S����������'#13+
'X VALUE=X�l'#13+
'PERCENT=�S����'#13+
'X AND VALUE=X�l�ƒl'#13+
'X AND PERCENT=X�l�ƕS����'#13+
'CHECK BOXES=�����ޯ��'#13+
'DIVIDING LINES=������'#13+
'FONT SERIES COLOR=̫�Ă��n��F��'#13+
'POSITION OFFSET %=�ʒu�̾�� %'#13+
'MARGIN=�]��'#13+
'RESIZE CHART=�ʒu���킹'#13+
'LEFT=��'#13+
'TOP=��'#13+
'WIDTH UNITS=���̒P��'#13+
'CONTINUOUS=�A��'#13+
'POINTS PER PAGE=1�߰�ނ��߲�Đ�'#13+
'SCALE LAST PAGE=�ŏI�߰�ނ��قɕ\��'#13+
'CURRENT PAGE LEGEND=���݂��߰�ނ̖}��'#13+
'SHOW PAGE NUMBER=�߰�ސ��̕\��'#13+
'PANEL EDITOR=���� ��ި�'#13+
'BACKGROUND=�w�i'#13+
'BORDERS=�g'#13+
'COLOR=�F'#13+
'BACK IMAGE=�w�i�C���[�W'#13+
'STRETCH=�X�g���b�`'#13+
'TILE=�^�C��'#13+
'CENTER=����'#13+
'BROWSE=�Q��'#13+
'INSIDE=���̂̓���'#13+
'TRANSPARENT=����'#13+
'WIDTH=��'#13+
'BEVEL INNER=���������'#13+
'BEVEL OUTER=�O�������'#13+
'LOWERED=��'#13+
'RAISED=��'#13+
'MARKS=�}�[�J'#13+
'DATA SOURCE=�ް����'#13+
'SORT=���'#13+
'CURSOR=����'#13+
'SHOW IN LEGEND=�}���\������'#13+
'FORMATS=����'#13+
'VALUES=�l'#13+
'PERCENTS=�S����'#13+
'HORIZONTAL AXIS=������'#13+
'TOP AND BOTTOM=��Ɖ�'#13+
'DATETIME=���t����'#13+
'VERTICAL AXIS=������'#13+
'LEFT AND RIGHT=���ƉE'#13+
'DATETIME=���t����'#13+
'ASCENDING=����'#13+
'DESCENDING=�~��'#13+
'DRAW EVERY=�\���Ԋu'#13+
'STYLE=����'#13+
'CLIPPED=�د��ݸ�'#13+
'ARROWS=���o��'#13+
'MULTI LINE=�����s'#13+
'ALL SERIES VISIBLE=�S�n��̕\��'#13+
'VALUE=�l'#13+
'PERCENT=�S����'#13+
'LABEL=����'#13+
'LABEL AND PERCENT=���قƕS����'#13+
'LABEL AND VALUE=���قƒl'#13+
'LEGEND=�}��'#13+
'PERCENT TOTAL=�S�̂ɑ΂��銄��'#13+
'LABEL AND PERCENT TOTAL=���قƊ���'#13+
'X VALUE=X�l'#13+
'X AND Y VALUES=X�l��Y�l'#13+
'MANUAL=�蓮'#13+
'RANDOM=����'#13+
'FUNCTION=�֐�'#13+
'NEW=�V�K'#13+
'EDIT=�ҏW'#13+
'DELETE=�폜'#13+
'PERSISTENT=��������'#13+
'TEXT=÷��'#13+
'ADJUST FRAME=�ڰтɍ��킹��'#13+
'CENTER=����'#13+
'SUBTITLE=�������'#13+
'SUBFOOT=���̯�-'#13+
'FOOT=̯�-'#13+
'ACTIVE=�L��'#13+
'VISIBLE WALLS=�ǂ̕\��'#13+
'LEFT=����'#13+
'RIGHT=�E��'#13+
'BOTTOM=����'#13+
'BACK=�w��'#13+
'BORDER=�g'#13+
'DARK 3D=3D�����Â�����'#13+
'DIF. LIMIT=���~�b�g'#13+
'LINES=��'#13+
'ABOVE=�ȏ�'#13+
'WITHIN=�ȓ�'#13+
'BELOW=�ȉ�'#13+
'CONNECTING LINES=�ڑ���'#13+
'HIGH=����'#13+
'LOW=�Ⴂ'#13+
'PATTERN=�����'#13+
'BROWSE=�Q��'#13+
'TILED=�^�C��'#13+
'3D=3D'#13+
'INFLATE MARGINS=�߲�Ă̊��S�\��'#13+
'SQUARE=�����`'#13+
'FLAT=����'#13+
'ROUND=��'#13+
'DOWN TRIANGLE=�|���O�p�`'#13+
'STAR=��'#13+
'SMALL DOT=�_'#13+
'DARK 3D=3D�����Â�����'#13+
'DEFAULT=��̫��'#13+
'GLOBAL=��۰���'#13+
'SHAPES=�`��'#13+
'BRUSH=�u���V'#13+
'GLOBAL=��۰���'#13+
'BRUSH=�u���V'#13+
'GLOBAL=��۰���'#13+
'DELAY=�x������'#13+
'MSEC.=�~���b'#13+
'PERCENT=�S����'#13+
'LABEL=����'#13+
'LABEL AND PERCENT=���قƕS����'#13+
'LABEL AND VALUE=���قƒl'#13+
'LEGEND=�}��'#13+
'PERCENT TOTAL=�S�̂ɑ΂��銄��'#13+
'X VALUE=X�l'#13+
'X AND Y VALUES=X�l��Y�l'#13+
'MOUSE ACTION=�}�E�X�̓���'#13+
'MOVE=�ړ�'#13+
'CLICK=�N���b�N'#13+
'SIZE=����'#13+
'BRUSH=�u���V'#13+
'DRAW LINE=���̕`��'#13+
'EXPLODE BIGGEST=�ő�敪�̕���'#13+
'TOTAL ANGLE=�S�̂̊p�x'#13+
'GROUP SLICES=�O���[�v'#13+
'VALUE=�l'#13+
'LABEL=����'#13+
'BELOW %=�w��%����'#13+
'BELOW VALUE=�w��l����'#13+
'OTHER=���̑�'#13+
'PATTERNS=�����'#13+
'DEPTH=�[��'#13+
'LINE=��'#13+
'SIZE %=����'#13+
'SERIES DATASOURCE TEXT EDITOR=Series DataSource Text ��ި�'#13+
'FIELDS=�t�B�[���h'#13+
'SOURCE=�\�[�X'#13+
'NUMBER OF HEADER LINES=�w�b�_�[�̍s��'#13+
'SEPARATOR=���ڰ�'#13+
'SERIES=�n��'#13+
'COMMA=���'#13+
'SPACE=��߰�'#13+
'TAB=���'#13+
'FILE=̧��'#13+
'WEB URL=URL'#13+
'LOAD=�Ǎ�'#13+
'IMAG. SYMBOL=���������'#13+
'C LABELS=C ���x��'#13+
'R LABELS=R ���x��'#13+
'C PEN=C �y��'#13+
'R PEN=R �y��'#13+
'CIRCLE=�O�~'#13+
'COLOR EACH=�F�𕪂���'#13+
'FONT=�t�H���g'#13+
'STACK GROUP=�ςݏd�˂̸�ٰ��'#13+
'USE ORIGIN=���_���g�p'#13+
'MULTIPLE BAR=����'#13+
'SIDE=���u'#13+
'SIDE ALL=����i�n�񖈁j'#13+
'DRAWING MODE=�`�惂�[�h'#13+
'WIREFRAME=���C���['#13+
'DOTFRAME=�_'#13+
'SMOOTH PALETTE=��گĂ����炩��'#13+
'SIDE BRUSH=���ʃu���V'#13+
'ABOUT TEECHART PRO V7.0=About TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'STEEMA SOFTWARE=NEWTONE Corp.'#13+
//'WWW.STEEMA.COM=http://www.newtone.co.jp/'#13+
//'VISIT OUR WEB SITE !=Visit our Web site !'#13+
'VISIT OUR WEB SITE !=Web�T�C�g�͂�����!'#13+
'TEECHART WIZARD=TeeChart �E�B�U�[�h'#13+
'WWW.STEEMA.COM=www.newtone.co.jp'#13+
'SELECT A CHART STYLE=�`���[�g�̃X�^�C���̑I��'#13+
'DATABASE CHART=�f�[�^�x�[�X�`���[�g'#13+
'NON DATABASE CHART=��f�[�^�x�[�X�`���[�g'#13+
'SELECT A DATABASE TABLE=�f�[�^�x�[�X�e�[�u���̑I��'#13+
'ALIAS=�G���A�X'#13+
'TABLE=�e�[�u����'#13+
'SOURCE=�\�[�X'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=�`���[�g�ɐݒ肷�鍀�ڂ̑I��'#13+
'SELECT A TEXT LABELS FIELD=���x���ɂ���������'#13+
'CHOOSE THE DESIRED CHART TYPE=�`���[�g�̑I��'#13+
'2D=2D'#13+
'CHART PREVIEW=�`���[�g�v���r���['#13+
'3D=3D'#13+
'SHOW LEGEND=�}���\��'#13+
'SHOW MARKS=ϰ���\��'#13+
'COLOR EACH=�F�𕪂���'#13+
'< BACK=< �߂�'#13+
'NEXT >=���� >'#13+
'EXPORT CHART=�`���[�g�̃G�N�X�|�[�g'#13+
'PICTURE=�s�N�`��'#13+
'NATIVE=�l�C�e�B�u'#13+
'FORMAT=�`��'#13+
'SIZE=����'#13+
'KEEP ASPECT RATIO=�c�����ۂ�'#13+
'INCLUDE SERIES DATA=�n��f�[�^���܂�'#13+
'FILE SIZE=�t�@�C���T�C�Y'#13+
'SERIES=�n��'#13+
'DELIMITER=�f���~�^'#13+
'XML=XML'#13+
'HTML TABLE=HTML �e�[�u��'#13+
'EXCEL=Excel'#13+
'COLON=���'#13+
'CUSTOM=����'#13+
'INCLUDE=�܂߂鍀��'#13+
'POINT LABELS=�߲������'#13+
'POINT INDEX=�߲�Ĳ��ޯ��'#13+
'HEADER=ͯ�ް'#13+
'COPY=�R�s�['#13+
'SAVE=�ۑ�'#13+
'SEND=����'#13+
'FUNCTIONS=�֐�'#13+
'ADD=Add'#13+
'ADX=ADX'#13+
'AVERAGE=���ϒl'#13+
'BOLLINGER=�{�����W���['#13+
'COPY=�R�s�['#13+
'COUNT=Count'#13+
'CUMULATIVE=�ݐ�'#13+
'CURVE FITTING=�n��g�ݍ��킹'#13+
'DIVIDE=��'#13+
'EXP. AVERAGE=�w�����ϒl'#13+
'EXP.MOV.AVRG.=�w���ړ����ϒl'#13+
'EXP.TREND=�w���g�����h'#13+
'HIGH=High'#13+
'LOW=Low'#13+
'MACD=MACD'#13+
'MOMENTUM=�^����'#13+
'MOMENTUM DIV=���^����'#13+
'MOVING AVRG.=�ړ����ϒl'#13+
'MULTIPLY=��'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=�덷��2��'#13+
'STD.DEVIATION=�W���΍�'#13+
'STOCHASTIC=�m��'#13+
'SUBTRACT=����'#13+
'TREND=�g�����h'#13+
'SOURCE SERIES=�n��'#13+
'TEECHART GALLERY=TeeChart �M������'#13+
'FUNCTIONS=�֐�'#13+
'STANDARD=�W��'#13+
'FINANCIAL=���Z'#13+
'STATS=���v'#13+
'EXTENDED=�g��'#13+
'OTHER=���̑�'#13+
'DITHER=�f�B�U'#13+
'REDUCTION=���F'#13+
'COMPRESSION=���k'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Nearest'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'NONE=�Ȃ�'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'MONOCHROME=���m�N��'#13+
'GRAY SCALE=��ڰ����'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% �i��'#13+
'GRAY SCALE=��ڰ����'#13+
'PERFORMANCE=��̫��ݽ'#13+
'QUALITY=�i��'#13+
'SPEED=���x'#13+
'COMPRESSION LEVEL=���k���x��'#13+
'CHART TOOLS GALLERY=Chart Tools �M������'#13+
'ANNOTATION=�A�m�e�[�V����'#13+
'AXIS ARROWS=�����'#13+
'COLOR BAND=�J���[�o���h'#13+
'COLOR LINE=�J���[���C��'#13+
'CURSOR=����'#13+
'DRAG MARKS=�h���b�O�}�[�J'#13+
'DRAW LINE=�h���[���C��'#13+
'DRAGPOINT=�h���b�O�|�C���g'#13+
'DRAG STYLE=��ׯ�޽���'#13+
'IMAGE=�C���[�W'#13+
'MARK TIPS=�}�[�J�`�b�v'#13+
'NEAREST POINT=�ߖT�_'#13+
'PAGE NUMBER=�y�[�W��'#13+
'ROTATE=��]'#13+
'CHART TOOLS GALLERY=Chart Tools �M������'#13+
'OUTLINE=�g'#13+
'USE Y ORIGIN=Y���_���g�p'#13+

'AVAILABLE LANGUAGES=���p�\�Ȍ���'#13+
'EXPORT DIALOG=����߰� �޲�۸�'#13+
'SHADOW EDITOR=���޳ ��ި�'#13+

{ 6.0 }
'BEVEL SIZE=����ٻ���'#13+
'DELETE ROW=�s�̍폜'#13+
'VOLUME SERIES=��ح�ьn��'#13+
'SINGLE=�V���O��'#13+
'REMOVE CUSTOM COLORS=���ѐF�̍폜'#13+
'USE PALETTE MINIMUM=�ŏ��l���g�p'#13+
'STEP=�ï��'#13+
'AXIS MAXIMUM=���̍ő�l'#13+
'AXIS CENTER=���̒���'#13+
'AXIS MINIMUM=���̍ŏ��l'#13+
'DAILY (NONE)=����'#13+
'WEEKLY=�T��'#13+
'MONTHLY=����'#13+
'BI-MONTHLY=2������1�x'#13+
'QUARTERLY=�l����'#13+
'YEARLY=�N��'#13+
//'DATETIME PERIOD=������ص��'#13+ //Ver7.0
'CASE SENSITIVE=�召�����̋��'#13+
'SQUARED=�����`'#13+
'GRID 3D SERIES=3D�O���b�h�n��'#13+
'DARK BORDER=�g���Â�����'#13+
'PIE SERIES=�~�n��'#13+
'FOCUS=̫���'#13+
'EXPLODE=����'#13+
'FACTOR=�v�f'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=����ڰĂ������Ă��쐬'#13+
'OPEN TEECHART TEMPLATE FILE FROM=TeeChart����ڰ�̧�ق�������I�����Ă�������'#13+
'BINARY=�޲��'#13+
'VOLUME OSCILLATOR=��ح�ѐU��'#13+
'PIE SLICES=�~�X���C�X'#13+
'ARROW WIDTH=���̕�'#13+
'ARROW HEIGHT=���̍���'#13+
'DEFAULT COLOR=�f�t�H���g�F'#13+
'BALANCE=���ݽ'#13+
'OFFSET=�̾��'#13+
'DEFAULT BORDER=�f�t�H���g�g'#13+
'SEPARATION=����'#13+
'ROUND BORDER=�g���ۂ�����'#13+
'NOTHING=�Ȃ�'#13+
'LEFT TRIANGLE=�������O�p�`'#13+
'RIGHT TRIANGLE=�E�����O�p�`'#13+
'SELF STACK=�P�Ɛςݏd��'#13+
'POINTER=�|�C���^'#13+
'ARROW HEAD=���̐�['#13+
'DISTANCE=�Ԋu'#13+
'OUTLINE GRADIENT=���ײ̸݂���ް���'#13+
'RADIAL OFFSET=���˕��̵̾��'#13+
'HORIZ=����'#13+
'VERT=����'#13+
'NUMBER OF SAMPLE VALUES=�T���v���l�̐�'#13+
'POINT COLORS=�߲�Ă̐F'#13+
'IGNORE NULLS=�ق𖳎�'#13+
//V8.03
//'END POINT=�I�_'#13+
'END POINT=�߲��'#13+
'FULL REPAINT=�S�̂̍ĕ`��'#13+
'SHOW LABELS=���ق̕\��'#13+
'SIDE LINES=���ʂ̐�'#13+
'SMOOTH=���炩��'#13+
'COVER=�J�o�['#13+
'INTERPOLATE=���'#13+
'BOX SIZE=�ޯ������'#13+
'REVERSAL AMOUNT=�t��'#13+
'VALUE SOURCE=��ح����'#13+
'PERIOD=��ص��'#13+
'UP=����'#13+
'DOWN=�޳�'#13+
'CONSTANT=�ݽ���'#13+
'ACCUMULATE=�ݐ�'#13+
'PERIOD 1=��ص��1'#13+
'PERIOD 2=��ص��2'#13+
'PERIOD 3=��ص��3'#13+
'HISTOGRAM=˽ĸ���'#13+
'EXP. LINE=�w��ײ�'#13+
'PERCENTAGE=�S����'#13+
'CALCULATE USING=�v�Z���@'#13+
'EVERY NUMBER OF POINTS=�߲�Ė�'#13+
'EVERY RANGE=�͈͖�'#13+
'START X=�J�n X'#13+
'NUM. POINTS=�߲�Ă̐�'#13+
'FORMTEELEGEND=�}��'#13+
'UPPER=���'#13+
'LOWER=����'#13+
'DEVIATION=�΍�'#13+
'WEIGHTED=���d'#13+
'WEIGHTED BY INDEX=���ޯ���ɂ����d'#13+
'COMPLETE R.M.S.=���S�Ȍ덷��2��'#13+
'INCLUDE NULL VALUES=�ْl���܂߂�'#13+
'WEIGHT=�d��'#13+
'RESIZE PIXELS TOLERANCE=�����ް�̒[����̋���'#13+
'EDIT LEGEND=�}��̕ҏW'#13+
'START AT MIN. VALUE=�ŏ��l�ŊJ�n'#13+
'EXECUTE !=���s'#13+
'BAND 1=�����1'#13+
'BAND 2=�����2'#13+
'TRANSPOSE NOW=�u��'#13+
'TEXT ALIGNMENT=÷�Ă̔z�u'#13+
'CALLOUT=���o��'#13+	//��ٱ��
'SORT BY=���'#13+
'DRAW STYLE=�`�����'#13+
'POINTS=�|�C���g'#13+
'LIGHT 0=ײ�0'#13+
'LIGHT 1=ײ�1'#13+
'LIGHT 2=ײ�2'#13+

{ 7.0 }
'VIEW SERIES NAMES=�n�񖼂̕\��'#13+
'NAME=����'#13+
'ZOOM ON UP LEFT DRAG=�A���Y�[���Ȃ�'#13+
'NO CHECK BOXES=�����ޯ���Ȃ�'#13+
'RADIO BUTTONS=׼޵����'#13+
'ONE MICROSECOND=1�}�C�N���b'#13+
'DIAGONAL UP=��������Ίp��'#13+
'DIAGONAL DOWN=���ォ��Ίp��'#13+
'AUTO HIDE=�����ŉB��'#13+
'VIEWS=�r���['#13+
'METAL=���^��'#13+
'WOOD=��'#13+
'STONE=��'#13+
'CLOUDS=�_'#13+
'GRASS=��'#13+
'FIRE=��'#13+
'SNOW=��'#13+
'SYMBOL=�����'#13+
'TICK LINES=�ڐ���'#13+
'SLANT CUBE=�X�Η�����'#13+
'INVERT. ARROW=���������'#13+
'INVERT. CONE=�|���~��'#13+
'% BAR DEPTH=�_�̉��s %'#13+
'MULTIPLE PIES=�����̉~'#13+
'DISABLE=����'#13+
'3D GRADIENT=3D����ް���'#13+
'COLOR EACH SLICE=�ײ��̐F�𕪂���'#13+
'Z DATETIME=Z ���t����'#13+
'MARGIN %=�]�� %'#13+
'SHAPE INDEX=����� ���ޯ��'#13+
'CLOSED=����'#13+
'FAST BRUSH=������׼'#13+
'GALLERY=�ެ��'#13+
'INVERTED GRAY=��ڰ���ٔ��]'#13+
'RAINBOW=��'#13+
'GRID EVERY=��د�ނ̊Ԋu'#13+
'BASE LINE=���'#13+
'HIDE TRIANGLES=�O�p�`���B��'#13+
'HIGH-LOW=���l-���l'#13+
'COLOR STYLE=�F�̽���'#13+
'RELATIVE TO OPEN=�O���I�l�Ɠ����n�l�̔�r'#13+
'RELATIVE TO PREVIOUS CLOSE=�O���I�l�Ɠ����I�l�̔�r'#13+
'MIRRORED=���E����'#13+
'TEXT ANTI-ALIAS=÷�� �����ر�'#13+
'TEXT QUOTES=÷�Ĉ��p��'#13+
'THEMES=�e�[�}'#13+
'PREVIEW=�v���r���['#13+
'MICROSOFT� EXCEL=Microsoft Excel'#13+
'TEECHART DEFAULT=TeeChart ��̫��'#13+
'BLUES=��'#13+
'COLOR PALETTE=�װ��گ�'#13+
'VICTORIAN=�r�N�g���A'#13+
'PASTELS=�p�X�e��'#13+
'CLASSIC=�N���V�b�N'#13+
'MODERN=���_��'#13+
'VIEW 3D=3D�\��'#13+
'SCALE=����'#13+
'FIXED POSITION=�ʒu���Œ�'#13+
'SPOT=��߯�'#13+
'SET DIRECTION=������ݒ�'#13+
'DIRECTIONS=����'#13+
//Function
'DATE PERIOD=���t��ص��'#13+
'TIME PERIOD=������ص��'#13+
'SECOND=�b'#13+
'TENSECOND=10�b'#13+
'MINUTE=��'#13+
'TWOMINUTES=2��'#13+
'FIVEMINUTES=5��'#13+
'TENMINUTES=10��'#13+
'FIFTEENMINUTES=15��'#13+
'TWENTYMINUTES=20��'#13+
'HALFHOUR=30��'#13+
'TWOHOURS=2����'#13+
'THREEHOUR=3����'#13+
'SIXHOUR=6����'#13+
'TWELVEHOUR=12����'#13+
'(NONE)=(�Ȃ�)'#13+
//Tool
'USE SERIES Z=�n���Z�����g�p'#13+
'CLICK TOLERANCE=�د��덷'#13+
'SELECT NEW LINES=�V�������̑I��'#13+
'CELL=�Z��'#13+
'ROW=�s'#13+
'COLUMN=��'#13+
'LOOP=ٰ��'#13+
'NO=�Ȃ�'#13+
'ONE WAY=�����'#13+
'CIRCULAR=�z��'#13+
'SERIES 2=�n��2'#13+
'DRAW BEHIND SERIES=�n��̔w�ʂɕ`��'#13+
'DRAW BEHIND AXES=���̔w�ʂɕ`��'#13+
'LINEAR=���`'#13+
'SPOTLIGHT=��߯�ײ�'#13+
'THUMB=�T��'#13+
'BACK COLOR=�w�i�F'#13+
'INITIAL DELAY=�x������'#13+
'AUTO-REPEAT=�����߰�'#13+
'HANDLES=�p�̋�`'#13+
'ALLOW RESIZE CHART=���Ă�ػ��މ�'#13+
//Dialog
'THEME=�e�[�}'#13+
'CHART THEME SELECTOR=Chart�̃e�[�}�̑I��'#13+
'DESIGN TIME OPTIONS=�݌v���̃I�v�V����'#13+
'LANGUAGE=����'#13+
'CHART GALLERY=�`���[�g�M������'#13+
'ALTERNATE=�g��'#13+
'MODE=Ӱ��'#13+
'CHART EDITOR=�`���[�g�G�f�B�^'#13+
'TREE MODE=�ذӰ��'#13+
'REMEMBER POSITION=�ʒu�̕ۑ�'#13+
'REMEMBER SIZE=�T�C�Y�̕ۑ�'#13+
'RESET=ؾ��'#13+
'NEW CHART=�V�����`���[�g'#13+
'DEFAULT THEME=��̫�Ă�ð�'#13+
'TEECHART PRO GALLERY=TeeChart Pro �M������'#13+
'NUMERIC FORMAT=���l�̌`��'#13+
//'NUMBER=��'#13+
'DECIMALS=10�i'#13+
'FIXED=�Œ�'#13+
'THOUSANDS=��'#13+
//'PERCENT=�S����'#13+
'CURRENCY=�ʉ�'#13+
'DATE TIME=���t'#13+
'GEOGRAPHIC=�n��'#13+
//'CUSTOM=����'#13+

//7.06
'ENTER DATE=���t����'#13+
'ENTER TIME=���ԓ���'#13+
'SHOW COLORS=�F�̕\��'#13+
'XYZ SERIES=XYZ�n��'#13+
'SHOW X VALUES=X�l�̕\��'#13+
'EDIT COLOR=�F�̕ҏW'#13+
'MAKE NULL POINT=���߲�Ă̍쐬'#13+
'APPEND ROW=�s�̒ǉ�'#13+
'TEXT FONT=÷�� ̫��'#13+
'HIDE SERIES AT EDITOR=�n��̔�\��'#13+
'CALCULATION=�v�Z'#13+
'GROUP=��ٰ��'#13+
'SHOW IN THIS EDITOR=���̃G�f�B�^�ŕ\��'#13+
'TEECHART LIGHTING=TEECHART�Ɩ�'#13+
'SURFACE=��̪�'#13+
'SVG OPTIONS=SVG��߼��'#13+
//'TEECHART PRO V7.06='#13+
//'BUSINESS='#13+
//'CARIBE SUN='#13+
//'CLEAR DAY='#13+
//'DESERT='#13+
//'FARM='#13+
//'FUNKY='#13+
//'GOLF='#13+
//'HOT='#13+
//'NIGHT='#13+
//'PASTEL='#13+
//'SEA='#13+
//'SEA 2='#13+
//'SUNSET=�ݾ��'#13+
//'TROPICAL=���߶�'#13+
'LOAD MODE=�Ǎ����@'#13+
'APPEND=�ǉ�'#13+

'CONE PERCENT=�~���̕S����'#13+
'GRADIENT DIRECTION=����ް��݂̕���'#13+
'BRUSH BACK CLEAR=��׼�̔w�i��ر'#13+
'ROWS=�s'#13+
'COLUMNS=��'#13+

//7.07
'DATATABLE EDITOR=�ް�ð��� ��ި�'#13+
'FILTERS=̨��'#13+
'SCALED=����'#13+
'ANTI-ALIAS LINES=�����ر� ײ�'#13+
'LEGEND SYMBOL EDITOR=�}������ ��ި�'#13+

'PERIOD RANGE=�s���I�h�͈̔�'#13+

//8.01
'SAMPLES=�T���v��'#13+
'CLIP TEXT=�د��ݸ�'#13+
'ANTI-ALIAS=�����ر�'#13+
'TREAT NULLS=�ق̎戵'#13+
'DONT PAINT=�`�悵�Ȃ�'#13+
'SKIP=�X�L�b�v'#13+
'IGNORE=����'#13+

'SCROLL INVERTED=�t�X�N���[��'#13+

'BANNER=�o�i�['#13+
'SCROLL DELAY=��۰ْx��'#13+
'BLINK DELAY ON=�_�Œx���I��'#13+
'BLINK DELAY OFF=�_�Œx���I�t'#13+
'SCROLL DIRECTION=��۰ق̕���'#13+
'BLINK=�_��'#13+
'RIGHT TO LEFT=�E���獶��'#13+
'LEFT TO RIGHT=������E��'#13+
'HEXAGON=�Z�p�`'#13+
'VIEW=�\��'#13+
'VIEW SERIES GROUPS=�n��O���[�v�̕\��'#13+
'PLANE=����'#13+
'FILLED=�h��Ԃ�'#13+
'INDEX=���ޯ��'#13+
'UP TO VALUE=���̒l�܂�'#13+
'EMPTY=�Ȃ�'#13+
'DENSITY=���x'#13+
'AT SEGMENTS=�Z�O�����g'#13+
'FONT COLOR LEVEL=̫�Ă̐F����'#13+
'ANTI OVERLAP=�d�˂Ȃ�'#13+
'AT BOTTOM=����'#13+
'MOUSE=�}�E�X'#13+
'SCOPE SIZE=����߻���'#13+
'SCOPE STYLE=����߽���'#13+
'SCOPE=�X�R�[�v'#13+
'SCOPE ONLY=�X�R�[�v�̂�'#13+
'CAMERA=�J����'#13+
'SNAP STYLE=�ů�߽���'#13+
'CALCULATE=�v�Z'#13+
'DISPLAY=�\��'#13+
'POLYNOMY=������'#13+
'DEGREE=����'#13+
'HORIZ. PARALLEL=��������'#13+
'VERT. PARALLEL=��������'#13+
'EXCEL FILE=Exceļ��'#13+
'WORKSHEET=ܰ����'#13+
'VALUES RANGE=�l�͈̔�'#13+
'FROM=����'#13+
'TO=�܂�'#13+
'LABELS RANGE=���ق͈̔�'#13+
'FADE=̪���'#13+
'FADE IN=̪��޲�'#13+
'FADE OUT=̪��ޱ��'#13+
'SHOW ALL LABELS=�S�Ẵ��x���̕\��'#13+

'SERIES GROUPS=�n��O���[�v'#13+
'AUTO SCALE AXIS=���̎�������'#13+
'NO PAGES=�߰�ނȂ�'#13+
'BACK IMAGE INSIDE=�w�i�Ұ�ނ���̂̓�����'#13+
'TEXT ALIGN=�z�u'#13+
'SERIES TITLE=�n�������'#13+
'PERCENT RELATIVE=���ΕS����'#13+
'VERT. MARGIN=�����̗]��'#13+
'POINT SIZE=�߲�Ļ���'#13+

'PASPARTOU=�]��'#13+
'GOLD=��'#13+
'SILVER=��'#13+
'CHERRY=�`�F���['#13+
'PINE=�p�C��'#13+
'CHANGE COLOR=�F�̕ύX'#13+
'LEGEND EVERY=�}�ᖈ'#13+
'CUSTOM PALETTES=������گ�'#13+
//'WIN. XP='#13+
//'MAC OS='#13+
//'WIN. VISTA='#13+
'OPERA=�I�y��'#13+
'WARM=�E�H�[��'#13+
'COOL=�N�[��'#13+
'INVERT=���]'#13+
'HIDE CELLS=�ق��\��'#13+
'BANDS PEN=�уy��'#13+
'MOUSE WHEEL ZOOM=ϳ�β�ق̽ް�'#13+
'ZOOM %=�Y�[�� %'#13+
//'HIDE DELAY=�x�����Ԃ̔�\��'#13+
'HIDE DELAY=�\����������'#13+

'RESET POSITION=�ʒu�̃��Z�b�g'#13+

'CALLOUT LEG SIZE=���o���̒���'#13+
'VERTICAL CENTER CALLOUT=���o���𐂒�������'#13+
'INERTIA=����'#13+
'ACCELERATION=�����x'#13+
'MAX. STEP=�ő�ï��'#13+
'THUMB 1=�T�� 1'#13+
'THUMB 2=�T�� 2'#13+
'THUMB 3=�T�� 3'#13+
'THUMB 4=�T�� 4'#13+
'BOUNDS=���E'#13+
'INFO=���'#13+
'TEXT EDITOR=÷�� ��ި�'#13+
'LOAD..=�Ǎ�..'#13+

'ITALIC=�Α�'#13+
'BOLD=����'#13+
'STRIKEOUT=��������'#13+
'UNDERLINE=����'#13+

'SUBGRADIENT=��޸���ް���'#13+

'TILT=�X��'#13+
'FILE NAME=�t�@�C����'#13+

'PLAY=�Đ�'#13+
'IMAGE TOOL=�Ұ��°�'#13+
'WALL=��'#13+
'MSEC PER FRAME=1�ڰт��ؕb'#13+

//'HIGHEST=�ł�����'#13+
//'VERY HIGH=��荂��'#13+
//'MEDIUM=����'#13+
'RECORD=�^��'#13+

'STOP=��~'#13+
'MIRROR ANGLES=��'#13+
'XML DATA=XML�f�[�^'#13+

'BLUR=�ڂ���'#13+
'CLIP=�د��ݸ�'#13+
'SPACING=�Ԋu'#13+
'LINE STYLE=���̽���'#13+
'NODES=�m�[�h'#13+
'BUY=����'#13+
'SELL=����'#13+
'FILTER=̨��'#13+
'SEPARATION %=�Ԋu %'#13+
'DIGITAL FONT=�޼���̫��'#13+
'MARKERS=�}�[�J'#13+
'OUTER=�O��'#13+
'VALUE AREA=�l�͈̔�'#13+
'MAX. INDICATOR=�ő�ݼ޹��'#13+
'HAND=�j'#13+
'MINOR TICKS=���ڐ�'#13+
'GREEN LINE=�ΐ�'#13+
'RED LINE=�Ԑ�'#13+
'LABELS INSIDE=���ق������'#13+
'ROTATE LABELS=���ق̉�]'#13+
'HAND DISTANCE=�j�̊Ԋu'#13+
'HAND OFFSET=�j�̵̾��'#13+
'MAP=�}�b�v'#13+
'WORLD=���E'#13+
'AFRICA=�A�t���J'#13+
'ASIA=�A�W�A'#13+
'AUSTRALIA=�I�[�X�g�����A'#13+
'CENTRAL AMERICA=�����A�����J'#13+
'EUROPE=���[���b�p'#13+
'EUROPE 15=���[���b�p 15'#13+
'EUROPE 27=���[���b�p 27'#13+
'SPAIN=�X�y�C��'#13+
'MIDDLE EAST=����'#13+
'NORTH AMERICA=�k�A�����J'#13+
'SOUTH AMERICA=��A�����J'#13+
'USA=�A�����J'#13+
'USA HAWAII ALASKA=��ض �ܲ �׽�'#13+
'SECTORS=�Z�N�^'#13+
'TRACKS=�g���b�N'#13+

//Tool
'FIBONACCI STYLE=̨��ů� ����'#13+
'ARCS=��'#13+
'FANS=��'#13+
'TRENDLINE=�g�����h���C��'#13+
'REMOVE=�폜'#13+
'DRAW LABELS=���x���̕`��'#13+
'ANIMATE !=��Ұ��� !'#13+
'TRANSPOSE !=�u�� !'#13+
'LINK=�����N'#13+
'HINT=�q���g'#13+
//Editor
'PAGENUMTOOLEDIT=�߰�ސ� °ٴ�ި�'#13+
'SHOW BUTTONS=�{�^���̕\��'#13+
'BUTTON WIDTH=�{�^���̕�'#13+
'ENABLED BUTTON=�L���ȃ{�^��'#13+
'DISABLED BUTTON=�����ȃ{�^��'#13+
//Export
'COMPILE=�R���p�C��'#13+
'PREVIEW AFTER COMPILE=�R���p�C����̃v���r���['#13+
'TEMPORARY FOLDER=�e���|�����t�H���_'#13+
'DISABLED BUTTON=�����ȃ{�^��'#13+
'PATH TO ADOBE FLEX COMPILER=Adobe Flex �R���p�C���̃p�X'#13+
'DELETE TEMPORARY FILES AFTER COMPILATION=�R���p�C����Ƀe���|�����t�@�C�����폜'#13+
'EMBEDDED IMAGES=�C���[�W�̖��ߍ���'#13+

//8.02
'GRADIENT BRIGHT=����ް��݂̋P�x'#13+

'REGION=�̈�'#13+
'PERCENT FONT=�t�H���g�̕S����'#13+
'PERCENT SIZE=�T�C�Y�̕S����'#13+
'RENAME=�Ȱ�'#13+
'ANTIALIAS=�A���`�G�C���A�X'#13+
'CURRENT=�J�����g'#13+
'FADE !=̪��� !'#13+
'FULL SCREEN !=�S��� !'#13+

'USE SERIES FORMAT=�n��̌`�����g�p'#13+
'VALUE FORMAT=�l�̌`��'#13+
'SPOT LIGHT=��߯�ײ�'#13+
'FONTS=�t�H���g'#13+
//TeeEdiGene.pas - TFormTeeGeneral.FillFonts
'DEPTH AXIS=����'#13+
'DEPTH TOP AXIS=����(��)'#13+
'FOOTER=̯�-'#13+
'LEGEND TITLE=�}��^�C�g��'#13+
'SUBFOOTER=���̯�-'#13+
'CUSTOM AXIS=�J�X�^����'#13+

{AX 5.0.4}
'COLOR EACH LINE=���̐F�𕪂���'#13+
'SUBFOOT=�T�u�t�b�^�['#13+
'FOOT=�t�b�^�['#13+
'RADIAL=���ˏ��'#13+
'BUTTON=�{�^��'#13+
'ALL=�S��'#13

{$IFDEF TEEOCX}
+
{ADO Editor}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- ADO�f�[�^�\�[�X�̑I��'#13+
'CONNECTION=�ڑ�'#13+
'DATASET=�f�[�^�Z�b�g'#13+
'TABLE=�e�[�u��'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=�V�X�e���e�[�u��'#13+
'LOGIN PROMPT=۸޲� �������'#13+
'SELECT=�I��'#13+
{Import dialogue}
'TEECHART IMPORT=TeeChart �C���|�[�g'#13+
'IMPORT CHART FROM=�C���|�[�g�`���[�g�ꏊ'#13+
'IMPORT NOW=�C���|�[�g'#13+
{Property page}
'EDIT CHART=�`���[�g�̕ҏW'#13
{$ENDIF}
;
  end;
end;

Procedure TeeSetJapanese;
begin
  TeeCreateJapanese;
  TeeLanguage:=TeeJapaneseLanguage;
  TeeJapaneseConstants;
  TeeLanguageHotKeyAtEnd:=True;
  TeeLanguageCanUpper:=False;
end;

initialization
finalization
  FreeAndNil(TeeJapaneseLanguage);
end.
