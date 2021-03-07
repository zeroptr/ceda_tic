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
  TeeMsg_LegendFirstValue   :='最初の凡例の値は0より大きくなければなりません。';
  TeeMsg_LegendColorWidth   :='凡例の色の幅は0%より大きくなければなりません。';
  TeeMsg_SeriesSetDataSource:='有効なデータソースのParentChartがありません。';
  TeeMsg_SeriesInvDataSource:='無効なデータソース: %s';
  TeeMsg_FillSample         :='FillSampleValuesの値は0より大きくなければなりません。';
  TeeMsg_AxisLogDateTime    :='日付時間軸を対数軸にすることはできません。';
  TeeMsg_AxisLogNotPositive :='対数軸の最小値と最大値は0以上でなければなりません。';
  TeeMsg_AxisLabelSep       :='軸ラベル間の距離の割合(%)は0より大きくなければなりません。';
  TeeMsg_AxisIncrementNeg   :='軸の増加量は0以上でなければなりません。';
  TeeMsg_AxisMinMax         :='軸の最小値は最大値以下でなければなりません。';
  TeeMsg_AxisMaxMin         :='軸の最大値は最小値以上でなければなりません。';
  TeeMsg_AxisLogBase        :='対数軸の基数は2以上にしてください。';
  TeeMsg_MaxPointsPerPage   :='1ページあたりの最大ポイント数は0より大きくしてください。';
  TeeMsg_3dPercent          :='3Dのパーセントは %d から %d の間にしてください。';
  TeeMsg_CircularSeries     :='円系列の依存は許されません。';
  TeeMsg_WarningHiColor     :='表示色数は16k色もしくはそれ以上を推奨いたします。';

  TeeMsg_DefaultPercentOf   :='%s of %s';
  TeeMsg_DefaultPercentOf2  :='%s'+#13+'of %s';
  TeeMsg_DefPercentFormat   :='##0.## %';
  TeeMsg_DefValueFormat     :='#,##0.###';
  TeeMsg_DefLogValueFormat  :='#.0 "x10" E+0';

  TeeMsg_AxisTitle          :='軸のタイトル';
  TeeMsg_AxisLabels         :='軸のラベル';
  TeeMsg_RefreshInterval    :='更新間隔は0から60の間でなければなりません。';
  TeeMsg_SeriesParentNoSelf :='系列のParentChartは「Self」ではありません！';
  TeeMsg_GalleryLine        :='リボン';
  TeeMsg_GalleryPoint       :='散布図';
  TeeMsg_GalleryArea        :='面';
  TeeMsg_GalleryBar         :='縦棒';
  TeeMsg_GalleryHorizBar    :='横棒';
  TeeMsg_GalleryPie         :='円';
  TeeMsg_GalleryCircled     :='円';
  TeeMsg_GalleryFastLine    :='折れ線';
  TeeMsg_GalleryHorizLine   :='横リボン';

  TeeMsg_PieSample1         :='Cars';
  TeeMsg_PieSample2         :='Phones';
  TeeMsg_PieSample3         :='Tables';
  TeeMsg_PieSample4         :='Monitors';
  TeeMsg_PieSample5         :='Lamps';
  TeeMsg_PieSample6         :='Keyboards';
  TeeMsg_PieSample7         :='Bikes';
  TeeMsg_PieSample8         :='Chairs';

  TeeMsg_GalleryLogoFont    :='ＭＳ Ｐゴシック';
  TeeMsg_Editing            :='%s の編集';

  TeeMsg_GalleryStandard    :='標準';
  TeeMsg_GalleryExtended    :='拡張';
  TeeMsg_GalleryFunctions   :='関数';

  TeeMsg_EditChart          :='チャートの編集(&D)...';
  TeeMsg_PrintPreview       :='印刷プレビュー(&P)...';
  TeeMsg_ExportChart        :='チャートのエクスポート(&X)...';
  TeeMsg_CustomAxes         :='カスタム軸...';

  TeeMsg_InvalidEditorClass :='%s: 無効なエディタクラス: %s';
  TeeMsg_MissingEditorClass :='%s: エディタダイアログがありません。';

  TeeMsg_GalleryArrow       :='矢印';

  TeeMsg_ExpFinish          :='完了(&F)';
  TeeMsg_ExpNext            :='次へ(&N) >';

  TeeMsg_GalleryGantt       :='ガント';

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

  TeeMsg_ChangeSeriesTitle  :='系列のタイトルを変更する';
  TeeMsg_NewSeriesTitle     :='系列の新しいタイトル:';
  TeeMsg_DateTime           :='日付と時間';
  TeeMsg_TopAxis            :='上軸';
  TeeMsg_BottomAxis         :='下軸';
  TeeMsg_LeftAxis           :='左軸';
  TeeMsg_RightAxis          :='右軸';

  TeeMsg_SureToDelete       :='%s を削除しますか？';
  TeeMsg_DateTimeFormat     :='日付時間書式(&M):';
  TeeMsg_Default            :='デフォルト';
  TeeMsg_ValuesFormat       :='値の書式(&M):';
  TeeMsg_Maximum            :='最大';
  TeeMsg_Minimum            :='最小';
  TeeMsg_DesiredIncrement   :='要望増加量 %s';

  TeeMsg_IncorrectMaxMinValue:='正しくない値の理由: %s';
  TeeMsg_EnterDateTime      :='入力 [日数] '+TeeMsg_HHNNSS;

  TeeMsg_SureToApply        :='変更を適用しますか？';
  TeeMsg_SelectedSeries     :='(選択された系列)';
  TeeMsg_RefreshData        :='データの更新(&R)';

  TeeMsg_DefaultFontSize    :='9';
  TeeMsg_DefaultEditorSize  :='439';
  TeeMsg_DefaultEditorHeight:='439';

  TeeMsg_FunctionAdd        :='和';
  TeeMsg_FunctionSubtract   :='差分';
  TeeMsg_FunctionMultiply   :='積';
  TeeMsg_FunctionDivide     :='商';
  TeeMsg_FunctionHigh       :='最大';
  TeeMsg_FunctionLow        :='最小';
  TeeMsg_FunctionAverage    :='平均値';

  TeeMsg_GalleryShape       :='シェープ';
  TeeMsg_GalleryBubble      :='泡';
  TeeMsg_FunctionNone       :='コピー';

  TeeMsg_None               :='(なし)';

  TeeMsg_PrivateDeclarations:='{ Private declarations }';
  TeeMsg_PublicDeclarations :='{ Public declarations }';

  TeeMsg_DefaultFontName    :='ＭＳ Ｐゴシック';

  TeeMsg_CheckPointerSize   :='ポインタのサイズは0より大きくしてください。';
  TeeMsg_About              :='バージョン情報(&A)...';

  tcAdditional              :='Additional';
  tcDControls               :='Data Controls';
  tcQReport                 :='QReport';

  TeeMsg_DataSet            :='データセット';
  TeeMsg_AskDataSet         :='ﾃﾞｰﾀｾｯﾄ(&D):';

  TeeMsg_SingleRecord       :='単一レコード';
  TeeMsg_AskDataSource      :='ﾃﾞｰﾀｿｰｽ(&D):';

  TeeMsg_Summary            :='サマリー';

  TeeMsg_FunctionPeriod     :='関数のピリオドは0以上にしてください。';

  TeeMsg_TeeChartWizard     :='TeeChart ウィザード';
  TeeMsg_WizardTab          :='業務';

  TeeMsg_ClearImage         :='クリア(&R)';
  TeeMsg_BrowseImage        :='参照(&R)...';

  TeeMsg_WizardSureToClose  :='TeeChart ウィザードを終了してもよろしいですか？';
  TeeMsg_FieldNotFound      :='フィールド %s が存在しません。';

  TeeMsg_DepthAxis          :='奥軸(右)';
  TeeMsg_PieOther           :='その他';
  TeeMsg_ShapeGallery1      :='abc';
  TeeMsg_ShapeGallery2      :='123';
  TeeMsg_ValuesX            :='X';
  TeeMsg_ValuesY            :='Y';
  TeeMsg_ValuesPie          :='円';
  TeeMsg_ValuesBar          :='棒';
  TeeMsg_ValuesAngle        :='角度';
  TeeMsg_ValuesGanttStart   :='開始';
  TeeMsg_ValuesGanttEnd     :='最後';
  TeeMsg_ValuesGanttNextTask:='次のﾀｽｸ';
  TeeMsg_ValuesBubbleRadius :='半径';
  TeeMsg_ValuesArrowEndX    :='EndX';
  TeeMsg_ValuesArrowEndY    :='EndY';
  TeeMsg_Legend             :='凡例';
  TeeMsg_Title              :='タイトル';
  TeeMsg_Foot               :='フッター';
  TeeMsg_Period             :='ピリオドの範囲';
  TeeMsg_PeriodRange        :='ピリオドの範囲';
  TeeMsg_CalcPeriod         :='全ての %s を計算:';
  TeeMsg_SmallDotsPen       :='小さな点';

  TeeMsg_InvalidTeeFile     :='*.'+TeeMsg_TeeExtension+' ファイルのチャートは無効です。';
  TeeMsg_WrongTeeFileFormat :='*.'+TeeMsg_TeeExtension+' ファイルの形式が間違っています。';
  TeeMsg_EmptyTeeFile       :='*.'+TeeMsg_TeeExtension+' ファイルが空です。';  { 5.01 }

  {$IFDEF D5}
  TeeMsg_ChartAxesCategoryName   := 'チャートの軸';
  TeeMsg_ChartAxesCategoryDesc   := 'チャートの軸のプロパティとイベント';
  TeeMsg_ChartWallsCategoryName  := 'チャートの壁';
  TeeMsg_ChartWallsCategoryDesc  := 'チャートの壁のプロパティとイベント';
  TeeMsg_ChartTitlesCategoryName := 'チャートのタイトル';
  TeeMsg_ChartTitlesCategoryDesc := 'チャートのタイトルのプロパティとイベント';
  TeeMsg_Chart3DCategoryName     := 'チャートの3D';
  TeeMsg_Chart3DCategoryDesc     := 'チャートの3Dのプロパティとイベント';
  {$ENDIF}

  TeeMsg_CustomAxesEditor       := 'カスタム';
  TeeMsg_Series                 := '系列';
  TeeMsg_SeriesList             := '系列...';

  TeeMsg_PageOfPages            := 'ページ %d / %d';
  TeeMsg_FileSize               := '%d バイト';

  TeeMsg_First  := '先頭';
  TeeMsg_Prior  := '前へ';
  TeeMsg_Next   := '次へ';
  TeeMsg_Last   := '末尾';
  TeeMsg_Insert := '挿入';
  TeeMsg_Delete := '削除';
  TeeMsg_Edit   := '編集';
  TeeMsg_Post   := '登録';
  TeeMsg_Cancel := 'キャンセル';

  TeeMsg_All    := '(全て)';
  TeeMsg_Index  := 'インデックス';
  TeeMsg_Text   := 'テキスト';

  TeeMsg_AsBMP        :='ビットマップ(&B)';
  TeeMsg_BMPFilter    :='ビットマップ (*.bmp)|*.bmp';
  TeeMsg_AsEMF        :='メタファイル(&M)';
  TeeMsg_EMFFilter    :='拡張メタファイル (*.emf)|*.emf|メタファイル (*.wmf)|*.wmf';
  TeeMsg_ExportPanelNotSet := 'パネルのプロパティがエクスポート形式に設定されていません。';

  TeeMsg_Normal    := '標準';
  TeeMsg_NoBorder  := '枠なし';
  TeeMsg_Dotted    := '点線';
  TeeMsg_Colors    := '色分け';
  TeeMsg_Filled    := '塗りつぶし';
  TeeMsg_Marks     := 'マーカ付';
  TeeMsg_Stairs    := '階段';
  TeeMsg_Points    := 'ポイント';
  TeeMsg_Height    := '3D高さ';
  TeeMsg_Hollow    := '中抜き';
  TeeMsg_Point2D   := '2Dポイント';
  TeeMsg_Triangle  := '三角形';
  TeeMsg_Star      := '星';
  TeeMsg_Circle    := '円';
  TeeMsg_DownTri   := '倒立三角形';
  TeeMsg_Cross     := '交差線';
  TeeMsg_Diamond   := '菱形';
  TeeMsg_NoLines   := '線なし';
  TeeMsg_Stack     := '積み重ね';
  TeeMsg_Stack100  := '百分率';
  TeeMsg_Pyramid   := '四角錐';
  TeeMsg_Ellipse   := '楕円';
  TeeMsg_InvPyramid:= '倒立四角錐';
  TeeMsg_Sides     := '併置';
  TeeMsg_SideAll   := '並列(系列毎)';
  TeeMsg_Patterns  := 'パターン';
  TeeMsg_Exploded  := '最大分割';
  TeeMsg_Shadow    := '影';
  TeeMsg_SemiPie   := '半円';
  TeeMsg_Rectangle := '矩形';
  TeeMsg_VertLine  := '垂直線';
  TeeMsg_HorizLine := '水平線';
  TeeMsg_Line      := '直線';
  TeeMsg_Cube      := '立方体';
  TeeMsg_DiagCross := '斜め交差線';

  TeeMsg_CanNotFindTempPath    := 'テンポラリフォルダが見つかりません';
  TeeMsg_CanNotCreateTempChart := 'テンポラリファイルが作成できません';
  TeeMsg_CanNotEmailChart      := 'チャートをメールで送信できません。 Mapi エラー: %d';

  TeeMsg_SeriesDelete := '系列の削除: ValueIndex %d が範囲外 (0 ～ %d).';

  { 5.02 }
  TeeMsg_AskLanguage  :='言語(&L)...';
  TeeMsg_TextFile     := 'Textファイル';

  { 5.03 }
  TeeMsg_Gradient := 'ｸﾞﾗﾃﾞｰｼｮﾝ';
  TeeMsg_WantToSave   :='%s を保存しますか？';
  TeeMsg_NativeFilter :='TeeChartファイル';

  TeeMsg_Property     :='プロパティ';
  TeeMsg_Value        :='値';
  TeeMsg_Yes          :='はい';
  TeeMsg_No           :='いいえ';
  TeeMsg_Image        :='(ｲﾒｰｼﾞ)';

  { TeeProCo }
  TeeMsg_GalleryPolar       :='極';
  TeeMsg_GalleryCandle      :='キャンドル';
  TeeMsg_GalleryVolume      :='ボリューム';
  TeeMsg_GallerySurface     :='サーフェス';
  TeeMsg_GalleryContour     :='等高線';
  TeeMsg_GalleryBezier      :='ベジェ';
  TeeMsg_GalleryPoint3D     :='3D 散布';
  TeeMsg_GalleryRadar       :='レーダー';
  TeeMsg_GalleryDonut       :='ドーナツ';
  TeeMsg_GalleryCursor      :='カーソル';
  TeeMsg_GalleryBar3D       :='3D バー';
  TeeMsg_GalleryBigCandle   :='ﾋﾞｯｸﾞｷｬﾝﾄﾞﾙ';
  TeeMsg_GalleryLinePoint   :='ﾗｲﾝﾎﾟｲﾝﾄ';
  TeeMsg_GalleryHistogram   :='ヒストグラム';
  TeeMsg_GalleryWaterFall   :='ｳｫｰﾀｰﾌｫｰﾙ';
  TeeMsg_GalleryWindRose    :='風向図';
  TeeMsg_GalleryClock       :='時計';
  TeeMsg_GalleryColorGrid   :='ｶﾗｰｸﾞﾘｯﾄﾞ';
  TeeMsg_GalleryBoxPlot     :='縦ﾎﾞｯｸｽﾌﾟﾛｯﾄ';
  TeeMsg_GalleryHorizBoxPlot:='横ﾎﾞｯｸｽﾌﾟﾛｯﾄ';
  TeeMsg_GalleryBarJoin     :='バー ジョイン';
  TeeMsg_GallerySmith       :='スミス';
  TeeMsg_GalleryPyramid     :='ピラミッド';
  TeeMsg_GalleryMap         :='マップ';

  // 7.06
  TeeMsg_GalleryVolumePipe  :='ﾎﾞﾘｭｰﾑﾊﾟｲﾌﾟ';

  TeeMsg_PolyDegreeRange     :='多項式の次数は 1 から 20 の間にしてください。';
  TeeMsg_AnswerVectorIndex   :='AnswerVectorプロパティのインデックス値は 1 から %d の間にしてください。';
  TeeMsg_FittingError        :='補間を処理できません。';
  TeeMsg_PeriodRange         :='ピリオドは0以上に設定してください。';
  TeeMsg_ExpAverageWeight    :='指数平均値の重みは0か1に設定してください。';
  TeeMsg_GalleryErrorBar     :='エラーバー';
  TeeMsg_GalleryError        :='エラー';
  TeeMsg_GalleryHighLow      :='High-Low';
  TeeMsg_FunctionMomentum    :='運動量';
  TeeMsg_FunctionMomentumDiv :='商運動量';
  TeeMsg_FunctionExpAverage  :='指数平均値';
  TeeMsg_FunctionMovingAverage:='移動平均値';
  TeeMsg_FunctionExpMovAve   :='指数移動平均値';
  TeeMsg_FunctionRSI         :='R.S.I.';
  TeeMsg_FunctionCurveFitting:='系列組み合わせ';
  TeeMsg_FunctionTrend       :='トレンド';
  TeeMsg_FunctionExpTrend    :='指数トレンド';
  TeeMsg_FunctionLogTrend    :='対数トレンド';
  TeeMsg_FunctionCumulative  :='累積';
  TeeMsg_FunctionStdDeviation:='標準偏差';
  TeeMsg_FunctionBollinger   :='ボリンジャー';
  TeeMsg_FunctionRMS         :='誤差の2乗';
  TeeMsg_FunctionMACD        :='MACD';
  TeeMsg_FunctionStochastic  :='確率';
  TeeMsg_FunctionADX         :='ADX';

  TeeMsg_FunctionCount       :='計算';
  TeeMsg_LoadChart           :='TeeChartを開く...';
  TeeMsg_SaveChart           :='TeeChartを保存...';
  TeeMsg_TeeFiles            :='TeeChart Pro ファイル';

  TeeMsg_GallerySamples      :='その他';
  TeeMsg_GalleryStats        :='統計';

  TeeMsg_CannotFindEditor    :='系列を編集するフォーム %s が見つかりません。';

  TeeMsg_CannotLoadChartFromURL:='エラーコード: %d URL: %s からチャートをダウンロードしています。';
  TeeMsg_CannotLoadSeriesDataFromURL:='エラーコード: %d URL: %s から系列のデータをダウンロードしています。';

  TeeMsg_Test                :='テスト...';

  TeeMsg_ValuesDate          :='日付';
  TeeMsg_ValuesOpen          :='始値';
  TeeMsg_ValuesHigh          :='高値';
  TeeMsg_ValuesLow           :='安値';
  TeeMsg_ValuesClose         :='終値';
  TeeMsg_ValuesOffset        :='ｵﾌｾｯﾄ';
  TeeMsg_ValuesStdError      :='標準ｴﾗｰ';

  TeeMsg_Grid3D              :='3Dグリッド';

  TeeMsg_LowBezierPoints     :='ベジェのポイント数は1より大きな値を設定してください。';

  { TeeCommander component... }

  TeeCommanMsg_Normal   := '標準';
  TeeCommanMsg_Edit     := '編集';
  TeeCommanMsg_Print    := '印刷';
  TeeCommanMsg_Copy     := 'コピー';
  TeeCommanMsg_Save     := '保存';
  TeeCommanMsg_3D       := '3D';

  TeeCommanMsg_Rotating := '回転: %d° 仰角: %d°';
  TeeCommanMsg_Rotate   := '回転';

  TeeCommanMsg_Moving   := '水平オフセット: %d 垂直オフセット: %d';
  TeeCommanMsg_Move     := '移動';

  TeeCommanMsg_Zooming  := 'ズーム: %d %%';
  TeeCommanMsg_Zoom     := 'ズーム';

  TeeCommanMsg_Depthing := '3D: %d %%';
  TeeCommanMsg_Depth    := '深さ';

  TeeCommanMsg_Chart    :='チャート';
  TeeCommanMsg_Panel    :='パネル';

  TeeCommanMsg_RotateLabel:='%s をドラッグすると回転';
  TeeCommanMsg_MoveLabel  :='%s をドラッグすると移動';
  TeeCommanMsg_ZoomLabel  :='%s をドラッグするとズーム';
  TeeCommanMsg_DepthLabel :='%s をドラッグすると3Dをリサイズ';

  TeeCommanMsg_NormalLabel:='ｽﾞｰﾑ(ﾏｳｽ左ﾎﾞﾀﾝﾄﾞﾗｯｸﾞ) ｽｸﾛｰﾙ(ﾏｳｽ右ﾎﾞﾀﾝﾄﾞﾗｯｸﾞ)';
  TeeCommanMsg_NormalPieLabel:='円の一つの区分をドラッグすると分割';

  TeeCommanMsg_PieExploding := '区分: %d 分割: %d %%';

  TeeMsg_TriSurfaceLess:='ポイントの数は4以上にしてください。';
  TeeMsg_TriSurfaceAllColinear:='同一直線上にあるデータポイントの全て';
  TeeMsg_TriSurfaceSimilar:='類似したポイントは実行できません。';
  TeeMsg_GalleryTriSurface:='ｻｰﾌｪｽ(三角)';

  TeeMsg_AllSeries := '全ての系列';
  TeeMsg_Edit      := '編集';

  TeeMsg_GalleryFinancial    :='金融';

  TeeMsg_CursorTool    := 'カーソル';
  TeeMsg_DragMarksTool := 'ドラッグマーカ';
  TeeMsg_AxisArrowTool := '軸矢印';
  TeeMsg_DrawLineTool  := 'ドローライン';
  TeeMsg_NearestTool   := '近傍点';
  TeeMsg_ColorBandTool := 'カラーバンド';
  TeeMsg_ColorLineTool := 'カラーライン';
  TeeMsg_RotateTool    := '回転';
  TeeMsg_ImageTool     := 'イメージ';
  TeeMsg_MarksTipTool  := 'マーカチップ';
  Teemsg_AnnotationTool:= 'アノテーション';

  TeeMsg_CantDeleteAncestor  := '親クラスは削除できません。';

  TeeMsg_Load            := '読込...';
  TeeMsg_NoSeriesSelected:= '系列が選択されていません。';

  { TeeChart Actions }
  TeeMsg_CategoryChartActions  := 'Chart';
  TeeMsg_CategorySeriesActions := 'Chart Series';

  TeeMsg_Action3D               := '3D(&3)';
  TeeMsg_Action3DHint           := '切り替え 2D / 3D';
  TeeMsg_ActionSeriesActive     := '有効(&A)';
  TeeMsg_ActionSeriesActiveHint := '表示 / 非表示 系列';
  TeeMsg_ActionEditHint         := 'チャートの編集';
  TeeMsg_ActionEdit             := '編集(&E)...';
  TeeMsg_ActionCopyHint         := 'クリップボードへコピー';
  TeeMsg_ActionCopy             := 'コピー(&C)';
  TeeMsg_ActionPrintHint        := 'チャートの印刷プレビュー';
  TeeMsg_ActionPrint            := '印刷(&P)...';
  TeeMsg_ActionAxesHint         := '表示 / 非表示 軸';
  TeeMsg_ActionAxes             := '軸(&A)';
  TeeMsg_ActionGridsHint        := '表示 / 非表示 グリッド';
  TeeMsg_ActionGrids            := 'グリッド(&G)';
  TeeMsg_ActionLegendHint       := '表示 / 非表示 凡例';
  TeeMsg_ActionLegend           := '凡例(&L)';
  TeeMsg_ActionSeriesEditHint   := '系列の編集';
  TeeMsg_ActionSeriesMarksHint  := '表示 / 非表示 系列のマーカ';
  TeeMsg_ActionSeriesMarks      := 'マーカ(&M)';
  TeeMsg_ActionSaveHint         := 'チャートの保存';
  TeeMsg_ActionSave             := '保存(&S)...';

  TeeMsg_CandleBar              := '線状';
  TeeMsg_CandleNoOpen           := '始値なし';
  TeeMsg_CandleNoClose          := '終値なし';
  TeeMsg_NoLines                := '線なし';
  TeeMsg_NoHigh                 := '高値なし';
  TeeMsg_NoLow                  := '安値なし';
  TeeMsg_ColorRange             := '色範囲';
  TeeMsg_WireFrame              := 'ワイヤー';
  TeeMsg_DotFrame               := '点';
  TeeMsg_Positions              := 'レベル位置';
  TeeMsg_NoGrid                 := 'ｸﾞﾘｯﾄﾞなし';
  TeeMsg_NoPoint                := 'ﾎﾟｲﾝﾄなし';
  TeeMsg_NoLine                 := '線なし';
  TeeMsg_Labels                 := 'ラベル付';
  TeeMsg_NoCircle               := '外円なし';
  TeeMsg_Lines                  := '中線付';
  TeeMsg_Border                 := '枠付';

  TeeMsg_SmithResistance      := '抵抗';
  TeeMsg_SmithReactance       := 'ﾘｱｸﾀﾝｽ';

  TeeMsg_Column  := '列';

  { 5.01 }
  TeeMsg_Separator            :='ｾﾊﾟﾚｰﾀ';
  TeeMsg_FunnelSegment        :='ｾｸﾞﾒﾝﾄ ';
  TeeMsg_FunnelSeries         :='ファネル';
  TeeMsg_FunnelPercent        :='0.00 %';
  TeeMsg_FunnelExceed         :='ｸｫｰﾀ以上';
  TeeMsg_FunnelWithin         :=' ｸｫｰﾀ以内';
  TeeMsg_FunnelBelow          :=' ｸｫｰﾀ以下';
  TeeMsg_CalendarSeries       :='カレンダー';
  TeeMsg_DeltaPointSeries     :='ﾃﾞﾙﾀﾎﾟｲﾝﾄ';
  TeeMsg_ImagePointSeries     :='ｲﾒｰｼﾞﾎﾟｲﾝﾄ';
  TeeMsg_ImageBarSeries       :='イメージバー';
  TeeMsg_SeriesTextFieldZero  :='SeriesText: Field の数は0より大きな値を設定してください。';

  { 5.02 } { Moved from TeeImageConstants.pas unit }

  TeeMsg_AsJPEG        :='JPEG(&J)';
  TeeMsg_JPEGFilter    :='JPEGファイル (*.jpg)|*.jpg';
  TeeMsg_AsGIF         :='GIF(&G)';
  TeeMsg_GIFFilter     :='GIFファイル (*.gif)|*.gif';
  TeeMsg_AsPNG         :='PNG(&P)';
  TeeMsg_PNGFilter     :='PNGファイル (*.png)|*.png';
  TeeMsg_AsPCX         :='PCX(&X)';
  TeeMsg_PCXFilter     :='PCXファイル (*.pcx)|*.pcx';
  TeeMsg_AsVML         :='VML(HTM)(&V)';
  TeeMsg_VMLFilter     :='VMLファイル (*.htm)|*.htm';

  { 5.02 }
  TeeMsg_Origin               := '原点';
  TeeMsg_Transparency         := '透明';
  TeeMsg_Box                  := '箱';
  TeeMsg_ExtrOut              := '極値';
  TeeMsg_MildOut              := '外れ値';
  TeeMsg_PageNumber           := 'ページ数';

  { 5.03 }
  TeeMsg_DragPoint            := 'ドラッグポイント';
  TeeMsg_OpportunityValues    := 'ｵﾌﾟﾁｭﾆﾃｨ値';
  TeeMsg_QuoteValues          := 'ｸｫｰﾄ値';

  {OCX 5.0.4}
  {$IFDEF TEEOCX}
  TeeMsg_ActiveXVersion      := 'ActiveX リリース ' + AXVer;
  TeeMsg_ActiveXCannotImport := '%sからTeeChartをインポートできません。';
  TeeMsg_ActiveXVerbPrint    := 'プレビュー';
  TeeMsg_ActiveXVerbExport   := 'エクスポート';
  TeeMsg_ActiveXVerbImport   := 'インポート';
  TeeMsg_ActiveXVerbHelp     := 'ヘルプ';
  TeeMsg_ActiveXVerbAbout    := 'バージョン情報';
  TeeMsg_ActiveXError        := 'TeeChart: エラーコード: %d ダウンロード: %s';
  TeeMsg_DatasourceError     := 'TeeChartのデータソースは系列またはレコードセットではありません。';
  TeeMsg_SeriesTextSrcError  := '無効な系列型';
  TeeMsg_AxisTextSrcError    := '無効な軸型';
  TeeMsg_DelSeriesDatasource := '%sを削除してよろしいですか？';
  TeeMsg_OCXNoPrinter        := 'プリンタがインストールされていません。';
  TeeMsg_ActiveXPictureNotValid:='ピクチャが無効です。';
  {$ENDIF}

  { 6.0 }
  TeeMsg_FunctionCustom   :='y = f(x)';
  TeeMsg_AsPDF            :='PDF(&P)';
  TeeMsg_PDFFilter        :='PDFファイル (*.pdf)|*.pdf';
  TeeMsg_AsPS             :='PostScript';
  TeeMsg_PSFilter         :='PostScriptファイル (*.eps)|*.eps';
  TeeMsg_GalleryHorizArea :='横面';
  TeeMsg_SelfStack        :='単独積み重ね';
  TeeMsg_DarkPen          :='枠を暗く';
  TeeMsg_SelectFolder     :='ﾃﾞｰﾀﾍﾞｰｽのﾌｫﾙﾀﾞを選択してください';
  TeeMsg_BDEAlias         :='エリアス(&A):';
  TeeMsg_ADOConnection    :='接続(&C):';

  { TeeProCo }
  TeeMsg_FunctionSmooth       :='スムーズ';
  TeeMsg_FunctionCross        :='クロスポイント';
  TeeMsg_GridTranspose        :='3Dグリッド置換';
  TeeMsg_FunctionCompress     :='ｺﾝﾌﾟﾚｯｼｮﾝ';
  TeeMsg_ExtraLegendTool      :='拡張凡例';
  TeeMsg_FunctionCLV          :='CLV';
  TeeMsg_FunctionOBV          :='OBV';
  TeeMsg_FunctionCCI          :='CCI';
  TeeMsg_FunctionPVO          :='PVO';
  TeeMsg_SeriesAnimTool       :='系列アニメーション';
  TeeMsg_GalleryPointFigure   :='ﾎﾟｲﾝﾄ&ﾌｨｷﾞｭｱ';
  TeeMsg_Up                   :='ｱｯﾌﾟ';
  TeeMsg_Down                 :='ﾀﾞｳﾝ';
  TeeMsg_GanttTool            :='ガントドラッグ';
  TeeMsg_XMLFile              :='XMLファイル';
  TeeMsg_GridBandTool         :='グリッドバンド';
  TeeMsg_FunctionPerf         :='パフォーマンス';
  TeeMsg_GalleryGauge         :='ゲージ';
  TeeMsg_GalleryGauges        :='ゲージ';
  TeeMsg_ValuesVectorEndZ     :='EndZ';
  TeeMsg_GalleryVector3D      :='3D ベクタ';
  TeeMsg_Gallery3D            :='3D';
  TeeMsg_GalleryTower         :='タワー';
  TeeMsg_SingleColor          :='単一色';
  TeeMsg_Cover                :='カバー';
  TeeMsg_Cone                 :='円錐';
  TeeMsg_PieTool              :='円スライス';

  { 6.01 }
  TeeMsg_TextFilter1  :='ｽﾍﾟｰｽをﾃﾞﾘﾐﾀとしたﾃｷｽﾄﾌｧｲﾙ (*.txt)|*.txt';
  TeeMsg_TextFilter2  :='ﾀﾌﾞをﾃﾞﾘﾐﾀとしたﾃｷｽﾄﾌｧｲﾙ (*.txt)|*.txt';
  TeeMsg_TextFilter3  :='ｶﾝﾏをﾃﾞﾘﾐﾀとしたﾃｷｽﾄﾌｧｲﾙ (*.csv)|*.csv';
  TeeMsg_TextFilter4  :='ｺﾛﾝをﾃﾞﾘﾐﾀとしたﾃｷｽﾄﾌｧｲﾙ (*.txt)|*.txt';
  TeeMsg_TextFilter5  :='ｶｽﾀﾑをﾃﾞﾘﾐﾀとしたﾃｷｽﾄﾌｧｲﾙ (*.txt)|*.txt';
  TeeMsg_XMLFilter    :='XMLファイル (*.xml)|*.xml';
  TeeMsg_HTMLFilter   :='HTMLファイル (*.htm)|*.htm';
  TeeMsg_ExcelFilter  :='Microsoft Excelファイル (*.xls)|*.xls';

  // 6.02
  TeeMsg_Apply            :='適用(&A)';
  TeeMsg_AddNewGroup      :='新しいｸﾞﾙｰﾌﾟの追加';
  TeeMsg_ChangeGroupName  :='グループ名の変更';
  TeeMsg_GroupName        :='グループ名:';
  TeeMsg_FunctionMedian   :='メディアン';
  TeeMsg_FunctionMode     :='モード';
  TeeMsg_Options          :='オプション(&O)...';
  TeeMsg_DepthTopAxis     :='奥軸(上)';

  // 7.0
  TeeMsg_View2D           :='2D';
  TeeMsg_Outline          :='ｱｳﾄﾗｲﾝ';

  // 7.05
  TeeMsg_ViewOrthoRight   :='直交 右';
  TeeMsg_ViewOrthoLeft    :='直交 左';
  TeeMsg_View3DFront      :='3D 前';
  TeeMsg_View3DRight      :='3D 右';
  TeeMsg_View3DLeft       :='3D 左';
  TeeMsg_AsSVG            :='SVG(&S)';
  TeeMsg_SVGFilter        :='SVGファイル (*.svg)|*.svg';

  TeeMsg_SubTitle := 'サブタイトル';
  TeeMsg_SubFoot  := 'サブフッター';

  // 8.0
  TeeMsg_FunctionSubset   :='部分集合';
  TeeMsg_Hexagon          :='六角形';
  TeeMsg_AntiAlias        :='アンチエイリアス';
  TeeMsg_Percent          :='百分率';
  TeeMsg_Smooth           :='滑らか';
  TeeMsg_Blur             :='ぼかし';
  TeeMsg_Width            :='幅';
  TeeMsg_Resize           :='リサイズ';
  TeeMsg_Left             :='左';
  TeeMsg_Top              :='上';
  TeeMsg_Crop             :='切り取り';
  TeeMsg_Invert           :='色の反転';
  TeeMsg_GrayScale        :='グレースケール';
  TeeMsg_Mosaic           :='モザイク';
  TeeMsg_Flip             :='上下反転';
  TeeMsg_Reverse          :='左右反転';
  TeeMsg_Brightness       :='輝度';
  TeeMsg_Color            :='色';
  TeeMsg_HueLumSat        :='色相,輝度,彩度';
  TeeMsg_Sharpen          :='強調';
  TeeMsg_GammaCorrection  :='ガンマ コレクション';
  TeeMsg_Emboss           :='エンボス';
  TeeMsg_Contrast         :='コントラスト';
  TeeMsg_Rotate           :='回転';
  TeeMsg_Back             :='背景色';
  TeeMsg_Autosize         :='自動サイズ';
  TeeMsg_Mirror           :='鏡';
  TeeMsg_Columns          :='列';
  TeeMsg_Rows             :='行';
  TeeMsg_Tile             :='タイル';
  TeeMsg_Bevel            :='ベベル';
  TeeMsg_Zoom             :='ズーム';
  TeeMsg_ThemeDefault     :='デフォルト';
  TeeMsg_ThemeTeeChart    :='TeeChart';
  TeeMsg_ThemeExcel       :='Excel';
  TeeMsg_ThemeVictorian   :='ビクトリア';
  TeeMsg_ThemePastels     :='パステル';
  TeeMsg_ThemeSolid       :='ソリッド';
  TeeMsg_ThemeClassic     :='クラシック';
  TeeMsg_ThemeWeb         :='Web';
  TeeMsg_ThemeModern      :='モダン';
  TeeMsg_ThemeRainbow     :='虹';
  TeeMsg_ThemeWinXP       :='Win. XP';
  TeeMsg_ThemeMacOS       :='Mac OS';
  TeeMsg_ThemeWinVista    :='Win. Vista';
  TeeMsg_ThemeGrayScale   :='グレースケール';
  TeeMsg_ThemeOpera       :='オペラ';
  TeeMsg_ThemeWarm        :='ウォーム';
  TeeMsg_ThemeCool        :='クール';

  TeeMsg_MenuFilters      :='フィルタ(&F)...';
  TeeMsg_CrossTab         :='クロスタブ';
  TeeMsg_DBSumEditCaption :='サマリーのプロパティ';

  // v8.02
  TeeMsg_AsFlex               :='Flex (Flash)';
  TeeMsg_FlexFilter           :='Flex Flash ファイル (*.mxml)|*.mxml';
  TeeMsg_AsXAML               :='XAML (WPF)';
  TeeMsg_XAMLFilter           :='XAMLファイル (*.xaml)|*.xaml';
  TeeMsg_SelectTmpFolder      :='テンポラリフォルダを選択してください';
  TeeMsg_PathAdobeFlexCompiler:='Adobe Flex mxmlc.exe コンパイラのフォルダを選択してください';
  TeePolarDegreeSymbol        :='°';
  TeeMsg_NewChart             :='新しいチャート';
  TeeMsg_RenameChart          :='チャート名の変更';
  TeeMsg_ChartName            :='チャートの名称:';
  TeeMsg_SelectTextFile       :='テキストファイルを選択してください';
  TeeMsg_SaveTextFile         :='テキストファイルの保存';
  TeeMsg_RecordVideo          :='ビデオ録画 !(&R)';

  { TeeProCo }
  // 7.0
  TeeMsg_Stop                 :='停止';
  TeeMsg_Execute              :='実行!';
  TeeMsg_Themes               :='テーマ';
  TeeMsg_LightTool            :='2D 照明';
  TeeMsg_Current              :='カレント';
  TeeMsg_FunctionCorrelation  :='相関';
  TeeMsg_FunctionVariance     :='分散';
  TeeMsg_GalleryBubble3D      :='3D 泡';
  TeeMsg_GalleryHorizHistogram:='横ヒストグラム';
  TeeMsg_FunctionPerimeter    :='境界';
  TeeMsg_SurfaceNearestTool   :='サーフェス近傍';
  TeeMsg_AxisScrollTool       :='軸スクロール';
  TeeMsg_RectangleTool        :='矩形';
  TeeMsg_GalleryPolarBar      :='極棒';
  TeeMsg_AsWapBitmap          :='ﾜｲﾔﾚｽ ﾋﾞｯﾄﾏｯﾌﾟ';
  TeeMsg_WapBMPFilter         :='ﾜｲﾔﾚｽ ﾋﾞｯﾄﾏｯﾌﾟ (*.wbmp)|*.wbmp';
  TeeMsg_ClipSeries           :='クリップ系列';
  TeeMsg_SeriesBandTool       :='系列バンド';

  // 7.01
  TeeMsg_ThemeFacts           :='ファクト';
  TeeMsg_FunctionDownSampling :='ﾀﾞｳﾝｻﾝﾌﾟﾘﾝｸﾞ';

  TeeMsg_SelectorTool         :='セレクタ';
  TeeMsg_LegendScrollBar      :='凡例スクロールバー';

  // 7.06
  TeeMsg_DataTableTool        :='データテーブル';

  // 8.0
  TeeMsg_IsoSurfaceSeries     :='Iso サーフェス';
  TeeMsg_UpToValue            :='この値まで';	//'Up to Value'
  TeeMsg_NoCompression        :='非圧縮'; // TeeVideo tool

  TeeMsg_GalleryDarvas        :='ダーバス';
  TeeMsg_VideoTool            :='ビデオクリエイター';
  TeeMsg_VideoToolDesc        :='チャートイメージをAVIビデオとして作成します';
  TeeMsg_VideoPlayerTool      :='ビデオプレイヤー';
  TeeMsg_VideoPlayerToolDesc  :='チャート領域の内側にビデオを再生します';

  TeeMsg_CursorToolDesc       :='系列上にドラッグ可能なカーソル線を描画します。';
  TeeMsg_DragMarksDesc        :='マウスをドラッグすることにより系列マーカを移動できます。';
  TeeMsg_DragPointDesc        :='マウスをドラッグすることにより系列ポイントを移動できます。';
  TeeMsg_DrawLineDesc         :='マウスのドラッグによりカスタムな線の描画が有効になります。';
  TeeMsg_ExtraLegendDesc      :='チャート内の任意の位置にカスタムな凡例を描画します。';
  TeeMsg_GanttToolDesc        :='ガントバーのドラッグやリサイズが有効になります。';
  TeeMsg_MarksTipDesc         :='系列ポイント上にマウスカーソルを移動あるいはクリックすると「チップ」あるいは「ヒント」を表示します。';
  TeeMsg_NearestToolDesc      :='マウスカーソルに最も近い系列ポイントにマーカを描画します。';
  TeeMsg_PieToolDesc          :='マウスを移動あるいはクリックすると円スライスをフォーカスあるいは分離します。';
  TeeMsg_SeriesAnimationDesc  :='系列ポイントが原点から値まで伸びて行く動画を実行します。';
  TeeMsg_AxisArrowDesc        :='軸をスクロールするために軸の最初と最後の位置にクリック可能な矢印を表示します。';
  TeeMsg_ColorBandDesc        :='指定した軸や位置に色付き矩形（バンド）を描画します。';
  TeeMsg_ColorLineDesc        :='指定した軸の位置にドラッグ可能な線を描画します。';
  TeeMsg_GridBandDesc         :='指定した軸に2本の交互の色付き矩形（バンド）を描画します。';
  TeeMsg_GridTransposeDesc    :='系列を90度回転させるためにXとZの座標を交換します。';
  TeeMsg_AnnotationDesc       :='チャート内の任意の位置にカスタムなテキストを描画します。';
  TeeMsg_RectangleToolDesc    :='リサイズ可能な矩形内の任意の位置にカスタムなテキストを描画します。';
  TeeMsg_RotateDesc           :='マウスドラッグによりチャートの回転を有効にします。';

//  TeeMsg_SeriesHotspotDesc    :='Displays "tips" or "hints" or provides drilldown capacity when the end-user moves or clicks the mouse over a series point.';
//  TeeMsg_ZoomToolDesc         :='Provides clientside Chart zoom functionality for WebCharts on a WebForm';

  TeeMsg_ImageToolDesc        :='指定した系列軸の範囲にイメージを描画します。軸がズームあるいはスクロールされた場合、イメージも新しい範囲に従って描画されます。';
  TeeMsg_LightToolDesc        :='チャートキャンバス上に2Dの「照明」効果を描画します。';
  TeeMsg_SurfaceNearestDesc   :='サーフェス系列上でマウスを移動した場合、マウスカーソルに最も近いサーフェスセルにマーカを表示します。';
  TeeMsg_AxisScrollDesc       :='マウスのドラッグにより軸のスクロールが有効になります。';
  TeeMsg_LegendScrollBarDesc  :='凡例のスクロールが有効になります。';
  TeeMsg_ClipSeriesDesc       :='系列を関連付けている軸の範囲内に描画します。';
  TeeMsg_SelectorDesc         :='チャートアイテムやアノテーションの選択やドラッグを有効にします。';
  TeeMsg_StatsToolDesc        :='系列データに関する統計情報を表示します。';
  TeeMsg_PageNumberDesc       :='チャートに現在のチャートページ番号や合計ページ数を表示します。';

  TeeMsg_TransposeSeries      :='系列置換';
  TeeMsg_TransposeSeriesDesc  :='系列の行と列を入れ替えます。';
  TeeMsg_GridTranspDesc       :='3Dグリッド系列において、Z値をX値に置換します。';
  TeeMsg_LegendScrollDesc     :='凡例にスクロールバーを描画します。';
  TeeMsg_DataTableDesc        :='系列のデータ値でグリッドを描画します。';
  TeeMsg_SeriesBandDesc       :='2つの系列間の領域を塗りつぶします。';

  TeeMsg_ThemeRandom          :='ランダム';
  TeeMsg_Play                 :='再生(&P)';
  TeeMsg_GalleryHighLowLine   :='HighLow ライン';
  TeeMsg_Mirrored             :='鏡';
  TeeMsg_PolarGridSeries      :='極グリッド';

  TeeMsg_FullScreen           :='全画面';
  TeeMsg_FullScreenDesc       :='チャートを最大化して全画面に表示します';

  TeeMsg_MagnifyTool          :='虫眼鏡';
  TeeMsg_MagnifyToolDesc      :='チャートの一部を拡大します';

  TeeMsg_Fader                :='フェーダ';
  TeeMsg_FaderDesc            :='チャートのアニメーションを次第にはっきりさせます。';

  TeeMsg_SubChartTool         :='サブチャート';
  TeeMsg_SubChartDesc         :='チャート内に複数のチャートを描画します。';

  //上で設定されているため
  //TeeMsg_AntiAlias            :='Anti-Alias';
  TeeMsg_AntiAliasDesc        :='ジグザグを除去して対角線や曲線の表示を滑らかにします。';

  TeeMsg_SeriesRegion         :='系列領域';
  TeeMsg_SeriesRegionDesc     :='固定した値と系列ポイント間の領域を塗りつぶします。';

  TeeMsg_Text3D               :='テキスト 3D';
  TeeMsg_Text3DDesc           :='3Dフォントと3D回転でテキストを描画します。';

  TeeMsg_BannerTool           :='バナー';
  TeeMsg_BannerToolDesc       :='テキストのスクロールと点滅';

  TeeMsg_MenuNew              :='新規(&N)';
  TeeMsg_MenuDelete           :='削除(&D)';
  TeeMsg_MenuRename           :='リネーム(&R)...';
  TeeMsg_MenuEdit             :='編集(&E)...';
  TeeMsg_MenuViewToolbar      :='ツールバーの表示(&V)';
  TeeMsg_RenamePage           :='チャートページのリネーム';
  TeeMsg_NewName              :='新しい名称:';

  TeeMsg_FrameTool            :='フレーム';
  TeeMsg_FrameToolDesc        :='チャートパネルの周りに装飾的な枠を描画します。';

  TeeMsg_HistogramFunction    :='ヒストグラム';

  TeeMsg_ExcelEmptyFile       :='Excel ファイルが空です';
  TeeMsg_ExcelFile            :='Excel';
  TeeMsg_ExcelSheetEmpty      :='Excel のワークシートを指定しなければなりません。';
  TeeMsg_ExcelRangeMissing    :='範囲を指定してなければなりません（例：A1からA10）。';
  //上で設定されているため
  //TeeMsg_DBSumEditCaption     :='Summary properties';
  TeeMsg_LegendPalette        :='凡例パレット';
  TeeMsg_LegendPaletteDesc    :='3D系列のパレット色で作成した凡例を表示します。';
  TeeMsg_Statistics           :='系列統計';
  TeeMsg_TeeScrollBar         :='スクロールバー';

  TeeMsg_GalleryOrgSeries     :='組織図';

  TeeMsg_GalleryWorld         :='世界';
  TeeMsg_GalleryAfrica        :='アフリカ';
  TeeMsg_GalleryAsia          :='アジア';
  TeeMsg_GalleryAustralia     :='オーストラリア';
  TeeMsg_GalleryCentralAmerica:='中央アメリカ';
  TeeMsg_GalleryEurope        :='ヨーロッパ';
  TeeMsg_GalleryEurope15      :='ヨーロッパ 15';
  TeeMsg_GalleryEurope27      :='ヨーロッパ 27';
  TeeMsg_GallerySpain         :='スペイン';
  TeeMsg_GalleryMiddleEast    :='中東';
  TeeMsg_GalleryNorthAmerica  :='北アメリカ';
  TeeMsg_GallerySouthAmerica  :='南アメリカ';
  TeeMsg_GalleryUSA           :='アメリカ';
  TeeMsg_GalleryUSAHawaiiAlaska:='ｱﾒﾘｶ ﾊﾜｲ ｱﾗｽｶ';
  TeeMsg_GalleryMaps          :='マップ';
  TeeMsg_GalleryTagCloud      :='タグクラウド';
  TeeMsg_GalleryRenko         :='練行足';
  TeeMsg_GalleryKagi          :='かぎ足';

  // v8.01

  TeeMsg_NumericGauge         :='数値ゲージ';
  TeeMsg_CircularGauge        :='円形ゲージ';
  TeeMsg_LEDGauge             :='LED';
  TeeMsg_LinearGauge          :='横線形ゲージ';

  TeeMsg_LinkTool             :='リンク';
  TeeMsg_LinkToolDesc         :='URLアドレスへナビゲートするためにクリック可能なテキストを表示します。';

  TeeMsg_Fibonacci            :='フィボナッチ';
  TeeMsg_FibonacciDesc        :='金融データ上にフィボナッチの弧や扇を描画します。';

  // v8.02
  TeeMsg_LinearGaugeVertical  :='縦線形ゲージ';
  TeeMsg_AVIFile              :='AVI ファイル';
  TeeMsg_SelectAVIFile        :='ビデオを保存するAVIファイル選択してください';
  TeeMsg_MPEGFile             :='MPEG ビデオファイル';
end;

Procedure TeeCreateJapanese;
begin
  if not Assigned(TeeJapaneseLanguage) then
  begin
    TeeJapaneseLanguage:=TStringList.Create;
    TeeJapaneseLanguage.Text:=
'GRADIENT EDITOR=ｸﾞﾗﾃﾞｰｼｮﾝ ｴﾃﾞｨﾀ'#13+
'GRADIENT=ｸﾞﾗﾃﾞｰｼｮﾝ'#13+
'DIRECTION=方向'#13+
'VISIBLE=表示'#13+
'TOP BOTTOM=下から上へ'#13+
'BOTTOM TOP=上から下へ'#13+
'LEFT RIGHT=右から左へ'#13+
'RIGHT LEFT=左から右へ'#13+
'FROM CENTER=中央から'#13+
'FROM TOP LEFT=右上隅から'#13+
'FROM BOTTOM LEFT=右下隅から'#13+
'OK=OK'#13+
'CANCEL=キャンセル'#13+
'COLORS=色'#13+
'START=開始'#13+
'MIDDLE=中央'#13+
'END=終了'#13+
'SWAP=入替'#13+
'NO MIDDLE=中央不可'#13+
'TEEFONT EDITOR=TeeFont ｴﾃﾞｨﾀ'#13+
'INTER-CHAR SPACING=文字の間隔'#13+
'FONT=フォント'#13+
'SHADOW=影'#13+
'HORIZ. SIZE=水平ｻｲｽﾞ'#13+
'VERT. SIZE=垂直ｻｲｽﾞ'#13+
'COLOR=色'#13+
'OUTLINE=ｱｳﾄﾗｲﾝ'#13+
'FORMAT=形式'#13+
'BEVEL=ﾍﾞﾍﾞﾙ'#13+
'SIZE=ｻｲｽﾞ'#13+
//V8.03
//'FRAME=枠'#13+
'FRAME=ﾌﾚｰﾑ'#13+
'PATTERN=ﾊﾟﾀｰﾝ'#13+
'ROUND FRAME=枠の角を丸くする'#13+
'TRANSPARENT=透明'#13+
'NONE=なし'#13+
'LOWERED=凹'#13+
'RAISED=凸'#13+
'COLOR=色'#13+
'LEFT TOP=左上'#13+
'LEFT BOTTOM=左下'#13+
'RIGHT TOP=右上'#13+
'RIGHT BOTTOM=右下'#13+
'MULTIPLE AREAS=複合'#13+
'STACKED=積み重ね'#13+
'STACKED 100%=百分率'#13+
'AREA=面'#13+
'STAIRS=階段'#13+
'SOLID=塗りつぶし'#13+
'CLEAR=なし'#13+
'HORIZONTAL=水平'#13+
'VERTICAL=垂直'#13+
'DIAGONAL=右下がり斜線'#13+
'B.DIAGONAL=右上がり斜線'#13+
'CROSS=交差線'#13+
'DIAG.CROSS=斜め交差線'#13+
'AREA LINES=縁取り'#13+
'BORDER=枠'#13+
'INVERTED=反転'#13+
'COLOR=色'#13+
'COLOR EACH=色を分ける'#13+
'ORIGIN=原点'#13+
'USE ORIGIN=原点を使用'#13+
'WIDTH=幅'#13+
'HEIGHT=高さ'#13+
'TEECHART LANGUAGES=TeeChart 言語'#13+
'CHOOSE A LANGUAGE=言語の選択'#13+
'SELECT ALL=全て選択'#13+
'MOVE UP=上へ移動'#13+
'MOVE DOWN=下へ移動'#13+
'CANCEL=キャンセル'#13+
'AXIS=軸'#13+
'LENGTH=長さ'#13+
'POSITION=位置'#13+
'SCROLL=スクロール'#13+
'START=開始'#13+
'END=終了'#13+
'BOTH=両方'#13+
'INVERTED SCROLL=逆スクロール'#13+
'AXIS INCREMENT=Axis Increment'#13+
'INCREMENT=増加量'#13+
'INCREMENT=増加量'#13+
'STANDARD=標準'#13+
'CUSTOM=ｶｽﾀﾑ'#13+
'ONE MILLISECOND=1ミリ秒'#13+
'ONE SECOND=1秒'#13+
'FIVE SECONDS=5秒'#13+
'TEN SECONDS=10秒'#13+
'FIFTEEN SECONDS=15秒'#13+
'THIRTY SECONDS=30秒'#13+
'ONE MINUTE=1分'#13+
'FIVE MINUTES=5分'#13+
'TEN MINUTES=10分'#13+
'FIFTEEN MINUTES=15分'#13+
'THIRTY MINUTES=30分'#13+
'ONE HOUR=1時間'#13+
'TWO HOURS=2時間'#13+
'SIX HOURS=6時間'#13+
'TWELVE HOURS=12時間'#13+
'ONE DAY=1日'#13+
'TWO DAYS=2日'#13+
'THREE DAYS=3日'#13+
'ONE WEEK=1週間'#13+
'HALF MONTH=半月'#13+
'ONE MONTH=1ヶ月'#13+
'TWO MONTHS=2ヶ月'#13+
'THREE MONTHS=3ヶ月'#13+
'FOUR MONTHS=4ヶ月'#13+
'SIX MONTHS=6ヶ月'#13+
'ONE YEAR=1年'#13+
'EXACT DATE TIME=正確な日付'#13+
'AXIS MAXIMUM AND MINIMUM=軸の最大値と最小値'#13+
'VALUE=値'#13+
'DATE=日付'#13+
'TIME=時間'#13+
'LEFT AXIS=左軸'#13+
'RIGHT AXIS=右軸'#13+
'TOP AXIS=上軸'#13+
'BOTTOM AXIS=下軸'#13+
'% BAR WIDTH=棒の幅'#13+
'STYLE=ｽﾀｲﾙ'#13+
'% BAR OFFSET=棒の位置'#13+
'RECTANGLE=矩形'#13+
'PYRAMID=四角錐'#13+
'INVERT. PYRAMID=倒立四角錐'#13+
'CYLINDER=円筒'#13+
'ELLIPSE=楕円'#13+
'ARROW=矢印'#13+
'RECT. GRADIENT=ｸﾞﾗﾃﾞｰｼｮﾝ矩形'#13+
'CONE=円錐'#13+
'DARK BAR 3D SIDES=3D部を暗くする'#13+
'BAR SIDE MARGINS=棒の脇に余白を取る'#13+
'AUTO MARK POSITION=ﾏｰｶ位置の自動調整'#13+
'GRADIENT=ｸﾞﾗﾃﾞｰｼｮﾝ'#13+
'JOIN=結合'#13+
'AUTO MARK POSITION=ﾏｰｶ位置の自動調整'#13+
'DATASET=ﾃﾞｰﾀｾｯﾄ'#13+
'APPLY=適用'#13+
'SOURCE=ソース'#13+
'COLORS=色'#13+
'MONOCHROME=モノクロ'#13+
'DEFAULT=ﾃﾞﾌｫﾙﾄ'#13+
'2 (1 BIT)=2 (1 bit)'#13+
'16 (4 BIT)=16 (4 bit)'#13+
'256 (8 BIT)=256 (8 bit)'#13+
'32768 (15 BIT)=32768 (15 bit)'#13+
'65536 (16 BIT)=65536 (16 bit)'#13+
'16M (24 BIT)=16M (24 bit)'#13+
'16M (32 BIT)=16M (32 bit)'#13+
'MEDIAN=中央値'#13+
'WHISKER=ひげ'#13+
'PATTERN COLOR EDITOR=パターンと色の設定'#13+
'IMAGE=イメージ'#13+
'IMAGE=イメージ'#13+
'BACK DIAGONAL=右上がり斜線'#13+
'DIAGONAL CROSS=斜め交差線'#13+
'FILL 80%=塗りつぶし 80%'#13+
'FILL 60%=塗りつぶし 60%'#13+
'FILL 40%=塗りつぶし 40%'#13+
'FILL 20%=塗りつぶし 20%'#13+
'FILL 10%=塗りつぶし 10%'#13+
'ZIG ZAG=ジグザグ'#13+
'VERTICAL SMALL=垂直線 (密)'#13+
'HORIZ. SMALL=水平線 (密)'#13+
'DIAG. SMALL=右下がり斜線 (密)'#13+
'BACK DIAG. SMALL=右上がり斜線 (密)'#13+
'CROSS SMALL=交差線 (密)'#13+
'DIAG. CROSS SMALL=斜め交差線 (密)'#13+
'PATTERN COLOR EDITOR=パターンと色の設定'#13+
'OPTIONS=オプション'#13+
'DAYS=日'#13+
'WEEKDAYS=曜日'#13+
'TODAY=今日'#13+
'SUNDAY=日曜日'#13+
'TRAILING=前後月'#13+
'MONTHS=年月'#13+
'LINES=線'#13+
'SHOW WEEKDAYS=曜日の表示'#13+
'UPPERCASE=大文字'#13+
'TRAILING DAYS=前後月の表示'#13+
'SHOW TODAY=今日の表示'#13+
'SHOW MONTHS=年月の表示'#13+
'UPPERCASE=大文字'#13+
{'UPPERCASE=NOTVisible'#13+}
'SHOW PREVIOUS BUTTON=前月ボタンの表示'#13+
'SHOW NEXT BUTTON=次月ボタンの表示'#13+
'CANDLE WIDTH=ｷｬﾝﾄﾞﾙの幅'#13+
'STYLE=ｽﾀｲﾙ'#13+
'STICK=棒状'#13+
'BAR=線状'#13+
'OPEN CLOSE=始値・終値'#13+
'UP CLOSE=高値の色'#13+
'DOWN CLOSE=安値の色'#13+
'SHOW OPEN=始値を表示'#13+
'SHOW CLOSE=終値を表示'#13+
'BORDER=枠'#13+
'DRAW 3D=3D'#13+
'DARK 3D=3D部を暗くする'#13+
'EDITING=編集中'#13+
'CHART=チャート'#13+
'SERIES=系列'#13+
'DATA=データ'#13+
'TOOLS=ツール'#13+
'EXPORT=エクスポート'#13+
'PRINT=印刷'#13+
'GENERAL=一般'#13+
'AXIS=軸'#13+
'TITLES=タイトル'#13+
'LEGEND=凡例'#13+
'PANEL=パネル'#13+
'PAGING=ページ'#13+
'WALLS=壁'#13+
'3D=3D'#13+
'ADD=追加'#13+
'DELETE=削除'#13+
'TITLE=ﾀｲﾄﾙ'#13+
'CLONE=複製'#13+
'CHANGE=変更'#13+
'WWW.STEEMA.COM=www.newtone.co.jp'#13+
'HELP=ヘルプ'#13+
'CLOSE=閉じる'#13+
'SERIES=系列'#13+
'IMAGE=イメージ'#13+
'TEECHART PRINT PREVIEW=TeeChart 印刷プレビュー'#13+
'PRINTER=ﾌﾟﾘﾝﾀ'#13+
'SETUP=設定'#13+
'PRINT=印刷'#13+
'ORIENTATION=印刷の向き'#13+
'PORTRAIT=縦'#13+
'LANDSCAPE=横'#13+
'MARGINS (%)=余白 (%)'#13+
'DETAIL=詳細'#13+
'MORE=より詳しく'#13+
'NORMAL=標準'#13+
'RESET MARGINS=余白のﾘｾｯﾄ'#13+
'VIEW MARGINS=余白の表示'#13+
'PROPORTIONAL=初期値に'#13+
'TEECHART PRINT PREVIEW=TeeChart 印刷プレビュー'#13+
'STYLE=ｽﾀｲﾙ'#13+
'CIRCLE=円'#13+
'VERTICAL LINE=垂直線'#13+
'HORIZ. LINE=水平線'#13+
'TRIANGLE=三角形'#13+
'INVERT. TRIANGLE=倒立三角形'#13+
'LINE=直線'#13+
'DIAMOND=菱形'#13+
'CUBE=立方体'#13+
'STAR=星形'#13+
'BORDER=枠'#13+
'TRANSPARENT=透明'#13+
'HORIZ. ALIGNMENT=水平方向の配置'#13+
'LEFT=左'#13+
'CENTER=中央'#13+
'RIGHT=右'#13+
'ROUND RECTANGLE=角を丸くする'#13+
'ALIGNMENT=配置'#13+
'TOP=上'#13+
'BOTTOM=下'#13+
'GRADIENT=ｸﾞﾗﾃﾞｰｼｮﾝ'#13+
'LEFT=左'#13+
'RIGHT=:右'#13+
'TOP=上'#13+
'BOTTOM=下'#13+
'UNITS=単位'#13+
'PIXELS=ピクセル'#13+
'AXIS ORIGIN=軸の原点'#13+
'ROTATION=回転'#13+
'CIRCLED=正円'#13+
'3 DIMENSIONS=3D'#13+
'RADIUS=半径'#13+
'HORIZONTAL=水平'#13+
'VERTICAL=垂直'#13+
'AUTO=自動'#13+
'AUTO=自動'#13+
'ANGLE INCREMENT=角度の増加量'#13+
'RADIUS INCREMENT=半径の増加量'#13+
'CLOSE CIRCLE=始点と終点の接続'#13+
'PEN=ペン'#13+
'CIRCLE=円'#13+
'PATTERN=ﾊﾟﾀｰﾝ'#13+
'LABELS=ラベル'#13+
'ROTATED=90度回転'#13+
'CLOCKWISE=時計回り'#13+
'INSIDE=内側'#13+
'ROMAN=ﾛｰﾏ数字'#13+
'HOURS=時間'#13+
'MINUTES=分'#13+
'SECONDS=秒'#13+
'RADIUS=半径'#13+
'START VALUE=開始値'#13+
'END VALUE=終了値'#13+
'TRANSPARENCY=透明度'#13+
'DRAW BEHIND=背面に描画'#13+
'COLOR MODE=色の種類'#13+
'STEPS=ｽﾃｯﾌﾟ'#13+
'RANGE=範囲'#13+
'PALETTE=パレット'#13+
'PALE=淡い'#13+
'STRONG=濃い'#13+
'GRID SIZE=ｸﾞﾘｯﾄﾞｻｲｽﾞ'#13+
'X=X'#13+
'Z=Z'#13+
'DEPTH=深さ'#13+
'IRREGULAR=不規則'#13+
'GRID=グリッド'#13+
//'VALUE=値'#13+
'ALLOW DRAG=ドラッグ可'#13+
'DRAG REPAINT=ドラッグの描画'#13+
'NO LIMIT DRAG=無制限ドラッグ'#13+
'VERTICAL POSITION=垂直位置'#13+
'LEVELS POSITION=レベル位置'#13+
'LEVELS=レベル'#13+
'NUMBER=数'#13+ {'NUMBER=個数'#13+}
'LEVEL=レベル'#13+
'AUTOMATIC=自動'#13+
'COLOR EACH=色を分ける'#13+
'STYLE=ｽﾀｲﾙ'#13+
'SNAP=移動制限'#13+
'FOLLOW MOUSE=マウスに連動'#13+
'STACK=積み重ね'#13+
'HEIGHT 3D=3Dの高さ'#13+
'LINE MODE=線の種類'#13+
'INVERTED=反転'#13+
'DARK 3D=3D部を暗くする'#13+
'OVERLAP=ｵｰﾊﾞｰﾗｯﾌﾟ'#13+
'STACK=積み重ね'#13+
'STACK 100%=百分率'#13+
'CLICKABLE=クリック可'#13+
'OUTLINE=ｱｳﾄﾗｲﾝ'#13+
'LABELS=ラベル'#13+
'AVAILABLE=選択可能な項目'#13+
'SELECTED=選択された項目'#13+
'>=>'#13+
'>>=>>'#13+
'<=<'#13+
'<<=<<'#13+
'DATASOURCE=ﾃﾞｰﾀｿｰｽ'#13+
'GROUP BY=ｸﾞﾙｰﾌﾟ'#13+
'CALC=計算'#13+
'OF=of'#13+
'SUM=和'#13+
'COUNT=計算'#13+
'HIGH=最大'#13+
'LOW=最小'#13+
'AVG=平均値'#13+
'HOUR=時間'#13+
'DAY=日'#13+
'WEEK=週'#13+
'WEEKDAY=曜日'#13+
'MONTH=月'#13+
'QUARTER=四半期'#13+
'YEAR=年'#13+
'HOLE %=穴 %'#13+
'RESET POSITIONS=位置のリセット'#13+
'MOUSE BUTTON=ﾏｳｽﾎﾞﾀﾝ'#13+
'MIDDLE=中央'#13+
'ENABLE DRAWING=描画可'#13+
'ENABLE SELECT=選択可'#13+
'ENHANCED=拡張'#13+
'ERROR WIDTH=ｴﾗｰの幅'#13+
'WIDTH UNITS=幅の単位'#13+
'PERCENT=百分率'#13+
'PIXELS=ピクセル'#13+
'RIGHT=右'#13+
'LEFT AND RIGHT=左と右'#13+
'TOP AND BOTTOM=上と下'#13+
'BORDER=ペン'#13+
'BORDER EDITOR=ﾍﾟﾝ ｴﾃﾞｨﾀ'#13+
'SOLID=実線'#13+
'DASH=破線'#13+
'DOT=点線'#13+
'DASH DOT=一点鎖線'#13+
'DASH DOT DOT=二点鎖線'#13+
'DRAW ALL=全て描画'#13+
'CALCULATE EVERY=計算'#13+
'ALL POINTS=全部の点'#13+
'NUMBER OF POINTS=ポイントの数'#13+
'RANGE OF VALUES=値の範囲'#13+
'ALIGNMENT=配置'#13+
'FIRST=最初'#13+
'CENTER=中央'#13+
'LAST=最後'#13+
'TEEPREVIEW EDITOR=TeePreview ｴﾃﾞｨﾀ'#13+
'ALLOW MOVE=移動可'#13+
'ALLOW RESIZE=リサイズ可'#13+
'DRAG IMAGE=ｲﾒｰｼﾞのﾄﾞﾗｯｸﾞ'#13+
'AS BITMAP=ﾋﾞｯﾄﾏｯﾌﾟ'#13+
'SHOW IMAGE=イメージの表示'#13+
'PORTRAIT=縦'#13+
'LANDSCAPE=横'#13+
'MARGINS=余白'#13+
'SIZE=ｻｲｽﾞ'#13+
'3D %=3D %'#13+
'ZOOM=ズーム'#13+
'ELEVATION=仰角'#13+
'100%=100%'#13+
'HORIZ. OFFSET=水平ｵﾌｾｯﾄ'#13+
'VERT. OFFSET=垂直ｵﾌｾｯﾄ'#13+
'PERSPECTIVE=遠近効果'#13+
'ANGLE=角度'#13+
'ORTHOGONAL=直交'#13+
'ZOOM TEXT=ﾃｷｽﾄをｽﾞｰﾑ'#13+
'SCALES=スケール'#13+
'TITLE=ﾀｲﾄﾙ'#13+
'TICKS=目盛'#13+
'MINOR=副目盛'#13+
'MAXIMUM=最大値'#13+
'MINIMUM=最小値'#13+
'(MAX)=(max)'#13+
'(MIN)=(min)'#13+
'DESIRED INCREMENT=期待する増加量'#13+
'(INCREMENT)=(increment)'#13+
'LOG BASE=対数の基数'#13+
'LOGARITHMIC=対数軸'#13+
'AUTO=自動'#13+
'CHANGE=変更'#13+
'CHANGE=変更'#13+
'TITLE=ﾀｲﾄﾙ'#13+
'ANGLE=角度'#13+
'MIN. SEPARATION %=最小間隔 %'#13+
'VISIBLE=表示'#13+
'MULTI-LINE=複数行'#13+
'LABEL ON AXIS=軸ラベル'#13+
'ROUND FIRST=始点で揃える'#13+
'AUTO=自動'#13+
'VALUE=値'#13+
'MARK=マーカ'#13+
'LABELS FORMAT=値の書式'#13+
'EXPONENTIAL=指数'#13+
'DEFAULT ALIGNMENT=デフォルトの配置'#13+
'LEN=長さ'#13+
'TICKS=目盛'#13+
'INNER=内側'#13+
'AT LABELS ONLY=ラベルのみ'#13+
'CENTERED=中央に配置'#13+
'LENGTH=長さ'#13+
'COUNT=個数'#13+
'TICKS=目盛'#13+
'GRID=グリッド'#13+
'POSITION %=位置 %'#13+
'START %=開始 %'#13+
'END %=終了 %'#13+
'OTHER SIDE=反対側'#13+
'AXES=軸'#13+
'VISIBLE=表示'#13+
'BEHIND=背面'#13+
'CLIP POINTS=ｸﾘｯﾋﾟﾝｸﾞ'#13+
'PRINT PREVIEW=印刷ﾌﾟﾚﾋﾞｭｰ'#13+
'ZOOM=ズーム'#13+
'SCROLL=スクロール'#13+
'STEPS=ｽﾃｯﾌﾟ'#13+
'MINIMUM PIXELS=最小ピクセル'#13+
'ALLOW=可'#13+
'ANIMATED=ｱﾆﾒｰｼｮﾝ'#13+
'PEN=ペン'#13+
'HORIZONTAL=水平'#13+
'VERTICAL=垂直'#13+
'ALLOW SCROLL=方法'#13+
'NONE=なし'#13+
'BOTH=両方'#13+
'TEEOPENGL EDITOR=TeeOpenGL ｴﾃﾞｨﾀ'#13+
'AMBIENT LIGHT=ｱﾝﾋﾞｴﾝﾄ光'#13+
'SHININESS=明るさ'#13+
'FONT 3D DEPTH=3Dﾌｫﾝﾄの深さ'#13+
'ACTIVE=有効'#13+
'FONT OUTLINES=ﾌｫﾝﾄのｱｳﾄﾗｲﾝ'#13+
'SMOOTH SHADING=滑らかな影'#13+
'LIGHT=光'#13+
'Y=Y'#13+
'INTENSITY=強さ'#13+
'SYMBOLS=シンボル'#13+
'TEXT STYLE=ﾃｷｽﾄｽﾀｲﾙ'#13+
'LEGEND STYLE=凡例ｽﾀｲﾙ'#13+
'VERT. SPACING=縦方向の間隔'#13+
'AUTOMATIC=自動'#13+
'SERIES NAMES=系列の名称'#13+
'SERIES VALUES=系列の値'#13+
'LAST VALUES=最後の値'#13+
'PLAIN=文字列のみ'#13+
'LEFT VALUE=値を右寄せ'#13+
'RIGHT VALUE=値を左寄せ'#13+
'LEFT PERCENT=百分率を右寄せ'#13+
'RIGHT PERCENT=百分率を左寄せ'#13+
'X VALUE=X値'#13+
'PERCENT=百分率'#13+
'X AND VALUE=X値と値'#13+
'X AND PERCENT=X値と百分率'#13+
'CHECK BOXES=ﾁｪｯｸﾎﾞｯｸｽ'#13+
'DIVIDING LINES=分割線'#13+
'FONT SERIES COLOR=ﾌｫﾝﾄを系列色に'#13+
'POSITION OFFSET %=位置ｵﾌｾｯﾄ %'#13+
'MARGIN=余白'#13+
'RESIZE CHART=位置合わせ'#13+
'LEFT=左'#13+
'TOP=上'#13+
'WIDTH UNITS=幅の単位'#13+
'CONTINUOUS=連続'#13+
'POINTS PER PAGE=1ﾍﾟｰｼﾞのﾎﾟｲﾝﾄ数'#13+
'SCALE LAST PAGE=最終ﾍﾟｰｼﾞをﾌﾙに表示'#13+
'CURRENT PAGE LEGEND=現在のﾍﾟｰｼﾞの凡例'#13+
'SHOW PAGE NUMBER=ﾍﾟｰｼﾞ数の表示'#13+
'PANEL EDITOR=ﾊﾟﾈﾙ ｴﾃﾞｨﾀ'#13+
'BACKGROUND=背景'#13+
'BORDERS=枠'#13+
'COLOR=色'#13+
'BACK IMAGE=背景イメージ'#13+
'STRETCH=ストレッチ'#13+
'TILE=タイル'#13+
'CENTER=中央'#13+
'BROWSE=参照'#13+
'INSIDE=ｸﾞﾗﾌの内側'#13+
'TRANSPARENT=透明'#13+
'WIDTH=幅'#13+
'BEVEL INNER=内側ﾍﾞﾍﾞﾙ'#13+
'BEVEL OUTER=外側ﾍﾞﾍﾞﾙ'#13+
'LOWERED=凹'#13+
'RAISED=凸'#13+
'MARKS=マーカ'#13+
'DATA SOURCE=ﾃﾞｰﾀｿｰｽ'#13+
'SORT=ｿｰﾄ'#13+
'CURSOR=ｶｰｿﾙ'#13+
'SHOW IN LEGEND=凡例を表示する'#13+
'FORMATS=書式'#13+
'VALUES=値'#13+
'PERCENTS=百分率'#13+
'HORIZONTAL AXIS=水平軸'#13+
'TOP AND BOTTOM=上と下'#13+
'DATETIME=日付書式'#13+
'VERTICAL AXIS=垂直軸'#13+
'LEFT AND RIGHT=左と右'#13+
'DATETIME=日付書式'#13+
'ASCENDING=昇順'#13+
'DESCENDING=降順'#13+
'DRAW EVERY=表示間隔'#13+
'STYLE=ｽﾀｲﾙ'#13+
'CLIPPED=ｸﾘｯﾋﾟﾝｸﾞ'#13+
'ARROWS=引出線'#13+
'MULTI LINE=複数行'#13+
'ALL SERIES VISIBLE=全系列の表示'#13+
'VALUE=値'#13+
'PERCENT=百分率'#13+
'LABEL=ﾗﾍﾞﾙ'#13+
'LABEL AND PERCENT=ﾗﾍﾞﾙと百分率'#13+
'LABEL AND VALUE=ﾗﾍﾞﾙと値'#13+
'LEGEND=凡例'#13+
'PERCENT TOTAL=全体に対する割合'#13+
'LABEL AND PERCENT TOTAL=ﾗﾍﾞﾙと割合'#13+
'X VALUE=X値'#13+
'X AND Y VALUES=X値とY値'#13+
'MANUAL=手動'#13+
'RANDOM=乱数'#13+
'FUNCTION=関数'#13+
'NEW=新規'#13+
'EDIT=編集'#13+
'DELETE=削除'#13+
'PERSISTENT=持続する'#13+
'TEXT=ﾃｷｽﾄ'#13+
'ADJUST FRAME=ﾌﾚｰﾑに合わせる'#13+
'CENTER=中央'#13+
'SUBTITLE=ｻﾌﾞﾀｲﾄﾙ'#13+
'SUBFOOT=ｻﾌﾞﾌｯﾀ-'#13+
'FOOT=ﾌｯﾀ-'#13+
'ACTIVE=有効'#13+
'VISIBLE WALLS=壁の表示'#13+
'LEFT=左面'#13+
'RIGHT=右面'#13+
'BOTTOM=下面'#13+
'BACK=背面'#13+
'BORDER=枠'#13+
'DARK 3D=3D部を暗くする'#13+
'DIF. LIMIT=リミット'#13+
'LINES=線'#13+
'ABOVE=以上'#13+
'WITHIN=以内'#13+
'BELOW=以下'#13+
'CONNECTING LINES=接続線'#13+
'HIGH=高い'#13+
'LOW=低い'#13+
'PATTERN=ﾊﾟﾀｰﾝ'#13+
'BROWSE=参照'#13+
'TILED=タイル'#13+
'3D=3D'#13+
'INFLATE MARGINS=ﾎﾟｲﾝﾄの完全表示'#13+
'SQUARE=正方形'#13+
'FLAT=平ら'#13+
'ROUND=丸'#13+
'DOWN TRIANGLE=倒立三角形'#13+
'STAR=星'#13+
'SMALL DOT=点'#13+
'DARK 3D=3D部を暗くする'#13+
'DEFAULT=ﾃﾞﾌｫﾙﾄ'#13+
'GLOBAL=ｸﾞﾛｰﾊﾞﾙ'#13+
'SHAPES=形状'#13+
'BRUSH=ブラシ'#13+
'GLOBAL=ｸﾞﾛｰﾊﾞﾙ'#13+
'BRUSH=ブラシ'#13+
'GLOBAL=ｸﾞﾛｰﾊﾞﾙ'#13+
'DELAY=遅延時間'#13+
'MSEC.=ミリ秒'#13+
'PERCENT=百分率'#13+
'LABEL=ﾗﾍﾞﾙ'#13+
'LABEL AND PERCENT=ﾗﾍﾞﾙと百分率'#13+
'LABEL AND VALUE=ﾗﾍﾞﾙと値'#13+
'LEGEND=凡例'#13+
'PERCENT TOTAL=全体に対する割合'#13+
'X VALUE=X値'#13+
'X AND Y VALUES=X値とY値'#13+
'MOUSE ACTION=マウスの動作'#13+
'MOVE=移動'#13+
'CLICK=クリック'#13+
'SIZE=ｻｲｽﾞ'#13+
'BRUSH=ブラシ'#13+
'DRAW LINE=線の描画'#13+
'EXPLODE BIGGEST=最大区分の分割'#13+
'TOTAL ANGLE=全体の角度'#13+
'GROUP SLICES=グループ'#13+
'VALUE=値'#13+
'LABEL=ﾗﾍﾞﾙ'#13+
'BELOW %=指定%未満'#13+
'BELOW VALUE=指定値未満'#13+
'OTHER=その他'#13+
'PATTERNS=ﾊﾟﾀｰﾝ'#13+
'DEPTH=深さ'#13+
'LINE=線'#13+
'SIZE %=ｻｲｽﾞ'#13+
'SERIES DATASOURCE TEXT EDITOR=Series DataSource Text ｴﾃﾞｨﾀ'#13+
'FIELDS=フィールド'#13+
'SOURCE=ソース'#13+
'NUMBER OF HEADER LINES=ヘッダーの行数'#13+
'SEPARATOR=ｾﾊﾟﾚｰﾀ'#13+
'SERIES=系列'#13+
'COMMA=ｶﾝﾏ'#13+
'SPACE=ｽﾍﾟｰｽ'#13+
'TAB=ﾀﾌﾞ'#13+
'FILE=ﾌｧｲﾙ'#13+
'WEB URL=URL'#13+
'LOAD=読込'#13+
'IMAG. SYMBOL=虚数ｼﾝﾎﾞﾙ'#13+
'C LABELS=C ラベル'#13+
'R LABELS=R ラベル'#13+
'C PEN=C ペン'#13+
'R PEN=R ペン'#13+
'CIRCLE=外円'#13+
'COLOR EACH=色を分ける'#13+
'FONT=フォント'#13+
'STACK GROUP=積み重ねのｸﾞﾙｰﾌﾟ'#13+
'USE ORIGIN=原点を使用'#13+
'MULTIPLE BAR=複合'#13+
'SIDE=併置'#13+
'SIDE ALL=並列（系列毎）'#13+
'DRAWING MODE=描画モード'#13+
'WIREFRAME=ワイヤー'#13+
'DOTFRAME=点'#13+
'SMOOTH PALETTE=ﾊﾟﾚｯﾄを滑らかに'#13+
'SIDE BRUSH=側面ブラシ'#13+
'ABOUT TEECHART PRO V7.0=About TeeChart Pro v7.0'#13+
'ALL RIGHTS RESERVED.=All Rights Reserved.'#13+
'STEEMA SOFTWARE=NEWTONE Corp.'#13+
//'WWW.STEEMA.COM=http://www.newtone.co.jp/'#13+
//'VISIT OUR WEB SITE !=Visit our Web site !'#13+
'VISIT OUR WEB SITE !=Webサイトはこちら!'#13+
'TEECHART WIZARD=TeeChart ウィザード'#13+
'WWW.STEEMA.COM=www.newtone.co.jp'#13+
'SELECT A CHART STYLE=チャートのスタイルの選択'#13+
'DATABASE CHART=データベースチャート'#13+
'NON DATABASE CHART=非データベースチャート'#13+
'SELECT A DATABASE TABLE=データベーステーブルの選択'#13+
'ALIAS=エリアス'#13+
'TABLE=テーブル名'#13+
'SOURCE=ソース'#13+
'BORLAND DATABASE ENGINE=Borland Database Engine'#13+
'MICROSOFT ADO=Microsoft ADO'#13+
'SELECT THE DESIRED FIELDS TO CHART=チャートに設定する項目の選択'#13+
'SELECT A TEXT LABELS FIELD=ラベルにしたい項目'#13+
'CHOOSE THE DESIRED CHART TYPE=チャートの選択'#13+
'2D=2D'#13+
'CHART PREVIEW=チャートプレビュー'#13+
'3D=3D'#13+
'SHOW LEGEND=凡例を表示'#13+
'SHOW MARKS=ﾏｰｶを表示'#13+
'COLOR EACH=色を分ける'#13+
'< BACK=< 戻る'#13+
'NEXT >=次へ >'#13+
'EXPORT CHART=チャートのエクスポート'#13+
'PICTURE=ピクチャ'#13+
'NATIVE=ネイティブ'#13+
'FORMAT=形式'#13+
'SIZE=ｻｲｽﾞ'#13+
'KEEP ASPECT RATIO=縦横比を保つ'#13+
'INCLUDE SERIES DATA=系列データを含む'#13+
'FILE SIZE=ファイルサイズ'#13+
'SERIES=系列'#13+
'DELIMITER=デリミタ'#13+
'XML=XML'#13+
'HTML TABLE=HTML テーブル'#13+
'EXCEL=Excel'#13+
'COLON=ｺﾛﾝ'#13+
'CUSTOM=ｶｽﾀﾑ'#13+
'INCLUDE=含める項目'#13+
'POINT LABELS=ﾎﾟｲﾝﾄﾗﾍﾞﾙ'#13+
'POINT INDEX=ﾎﾟｲﾝﾄｲﾝﾃﾞｯｸｽ'#13+
'HEADER=ﾍｯﾀﾞｰ'#13+
'COPY=コピー'#13+
'SAVE=保存'#13+
'SEND=送る'#13+
'FUNCTIONS=関数'#13+
'ADD=Add'#13+
'ADX=ADX'#13+
'AVERAGE=平均値'#13+
'BOLLINGER=ボリンジャー'#13+
'COPY=コピー'#13+
'COUNT=Count'#13+
'CUMULATIVE=累積'#13+
'CURVE FITTING=系列組み合わせ'#13+
'DIVIDE=商'#13+
'EXP. AVERAGE=指数平均値'#13+
'EXP.MOV.AVRG.=指数移動平均値'#13+
'EXP.TREND=指数トレンド'#13+
'HIGH=High'#13+
'LOW=Low'#13+
'MACD=MACD'#13+
'MOMENTUM=運動量'#13+
'MOMENTUM DIV=商運動量'#13+
'MOVING AVRG.=移動平均値'#13+
'MULTIPLY=積'#13+
'R.S.I.=R.S.I.'#13+
'ROOT MEAN SQ.=誤差の2乗'#13+
'STD.DEVIATION=標準偏差'#13+
'STOCHASTIC=確率'#13+
'SUBTRACT=差分'#13+
'TREND=トレンド'#13+
'SOURCE SERIES=系列'#13+
'TEECHART GALLERY=TeeChart ギャラリ'#13+
'FUNCTIONS=関数'#13+
'STANDARD=標準'#13+
'FINANCIAL=金融'#13+
'STATS=統計'#13+
'EXTENDED=拡張'#13+
'OTHER=その他'#13+
'DITHER=ディザ'#13+
'REDUCTION=減色'#13+
'COMPRESSION=圧縮'#13+
'LZW=LZW'#13+
'RLE=RLE'#13+
'NEAREST=Nearest'#13+
'FLOYD STEINBERG=Floyd Steinberg'#13+
'STUCKI=Stucki'#13+
'SIERRA=Sierra'#13+
'JAJUNI=JaJuNI'#13+
'STEVE ARCHE=Steve Arche'#13+
'BURKES=Burkes'#13+
'NONE=なし'#13+
'WINDOWS 20=Windows 20'#13+
'WINDOWS 256=Windows 256'#13+
'WINDOWS GRAY=Windows Gray'#13+
'MONOCHROME=モノクロ'#13+
'GRAY SCALE=ｸﾞﾚｰｽｹｰﾙ'#13+
'NETSCAPE=Netscape'#13+
'QUANTIZE=Quantize'#13+
'QUANTIZE 256=Quantize 256'#13+
'% QUALITY=% 品質'#13+
'GRAY SCALE=ｸﾞﾚｰｽｹｰﾙ'#13+
'PERFORMANCE=ﾊﾟﾌｫｰﾏﾝｽ'#13+
'QUALITY=品質'#13+
'SPEED=速度'#13+
'COMPRESSION LEVEL=圧縮レベル'#13+
'CHART TOOLS GALLERY=Chart Tools ギャラリ'#13+
'ANNOTATION=アノテーション'#13+
'AXIS ARROWS=軸矢印'#13+
'COLOR BAND=カラーバンド'#13+
'COLOR LINE=カラーライン'#13+
'CURSOR=ｶｰｿﾙ'#13+
'DRAG MARKS=ドラッグマーカ'#13+
'DRAW LINE=ドローライン'#13+
'DRAGPOINT=ドラッグポイント'#13+
'DRAG STYLE=ﾄﾞﾗｯｸﾞｽﾀｲﾙ'#13+
'IMAGE=イメージ'#13+
'MARK TIPS=マーカチップ'#13+
'NEAREST POINT=近傍点'#13+
'PAGE NUMBER=ページ数'#13+
'ROTATE=回転'#13+
'CHART TOOLS GALLERY=Chart Tools ギャラリ'#13+
'OUTLINE=枠'#13+
'USE Y ORIGIN=Y原点を使用'#13+

'AVAILABLE LANGUAGES=利用可能な言語'#13+
'EXPORT DIALOG=ｴｸｽﾎﾟｰﾄ ﾀﾞｲｱﾛｸﾞ'#13+
'SHADOW EDITOR=ｼｬﾄﾞｳ ｴﾃﾞｨﾀ'#13+

{ 6.0 }
'BEVEL SIZE=ﾍﾞﾍﾞﾙｻｲｽﾞ'#13+
'DELETE ROW=行の削除'#13+
'VOLUME SERIES=ﾎﾞﾘｭｰﾑ系列'#13+
'SINGLE=シングル'#13+
'REMOVE CUSTOM COLORS=ｶｽﾀﾑ色の削除'#13+
'USE PALETTE MINIMUM=最小値を使用'#13+
'STEP=ｽﾃｯﾌﾟ'#13+
'AXIS MAXIMUM=軸の最大値'#13+
'AXIS CENTER=軸の中央'#13+
'AXIS MINIMUM=軸の最小値'#13+
'DAILY (NONE)=日間'#13+
'WEEKLY=週間'#13+
'MONTHLY=月間'#13+
'BI-MONTHLY=2ヶ月に1度'#13+
'QUARTERLY=四半期'#13+
'YEARLY=年間'#13+
//'DATETIME PERIOD=日時ﾋﾟﾘｵﾄﾞ'#13+ //Ver7.0
'CASE SENSITIVE=大小文字の区別'#13+
'SQUARED=正方形'#13+
'GRID 3D SERIES=3Dグリッド系列'#13+
'DARK BORDER=枠を暗くする'#13+
'PIE SERIES=円系列'#13+
'FOCUS=ﾌｫｰｶｽ'#13+
'EXPLODE=分離'#13+
'FACTOR=要素'#13+
'CHART FROM TEMPLATE (*.TEE FILE)=ﾃﾝﾌﾟﾚｰﾄからﾁｬｰﾄを作成'#13+
'OPEN TEECHART TEMPLATE FILE FROM=TeeChartﾃﾝﾌﾟﾚｰﾄﾌｧｲﾙを次から選択してください'#13+
'BINARY=ﾊﾞｲﾅﾘ'#13+
'VOLUME OSCILLATOR=ﾎﾞﾘｭｰﾑ振動'#13+
'PIE SLICES=円スライス'#13+
'ARROW WIDTH=矢印の幅'#13+
'ARROW HEIGHT=矢印の高さ'#13+
'DEFAULT COLOR=デフォルト色'#13+
'BALANCE=ﾊﾞﾗﾝｽ'#13+
'OFFSET=ｵﾌｾｯﾄ'#13+
'DEFAULT BORDER=デフォルト枠'#13+
'SEPARATION=分離'#13+
'ROUND BORDER=枠を丸くする'#13+
'NOTHING=なし'#13+
'LEFT TRIANGLE=左向き三角形'#13+
'RIGHT TRIANGLE=右向き三角形'#13+
'SELF STACK=単独積み重ね'#13+
'POINTER=ポインタ'#13+
'ARROW HEAD=矢印の先端'#13+
'DISTANCE=間隔'#13+
'OUTLINE GRADIENT=ｱｳﾄﾗｲﾝのｸﾞﾗﾃﾞｰｼｮﾝ'#13+
'RADIAL OFFSET=放射部のｵﾌｾｯﾄ'#13+
'HORIZ=水平'#13+
'VERT=垂直'#13+
'NUMBER OF SAMPLE VALUES=サンプル値の数'#13+
'POINT COLORS=ﾎﾟｲﾝﾄの色'#13+
'IGNORE NULLS=ﾇﾙを無視'#13+
//V8.03
//'END POINT=終点'#13+
'END POINT=ﾎﾟｲﾝﾀ'#13+
'FULL REPAINT=全体の再描画'#13+
'SHOW LABELS=ﾗﾍﾞﾙの表示'#13+
'SIDE LINES=側面の線'#13+
'SMOOTH=滑らかに'#13+
'COVER=カバー'#13+
'INTERPOLATE=補間'#13+
'BOX SIZE=ﾎﾞｯｸｽｻｲｽﾞ'#13+
'REVERSAL AMOUNT=逆量'#13+
'VALUE SOURCE=ﾊﾞﾘｭｰｿｰｽ'#13+
'PERIOD=ﾋﾟﾘｵﾄﾞ'#13+
'UP=ｱｯﾌﾟ'#13+
'DOWN=ﾀﾞｳﾝ'#13+
'CONSTANT=ｺﾝｽﾀﾝﾄ'#13+
'ACCUMULATE=累積'#13+
'PERIOD 1=ﾋﾟﾘｵﾄﾞ1'#13+
'PERIOD 2=ﾋﾟﾘｵﾄﾞ2'#13+
'PERIOD 3=ﾋﾟﾘｵﾄﾞ3'#13+
'HISTOGRAM=ﾋｽﾄｸﾞﾗﾑ'#13+
'EXP. LINE=指数ﾗｲﾝ'#13+
'PERCENTAGE=百分率'#13+
'CALCULATE USING=計算方法'#13+
'EVERY NUMBER OF POINTS=ﾎﾟｲﾝﾄ毎'#13+
'EVERY RANGE=範囲毎'#13+
'START X=開始 X'#13+
'NUM. POINTS=ﾎﾟｲﾝﾄの数'#13+
'FORMTEELEGEND=凡例'#13+
'UPPER=上限'#13+
'LOWER=下限'#13+
'DEVIATION=偏差'#13+
'WEIGHTED=加重'#13+
'WEIGHTED BY INDEX=ｲﾝﾃﾞｯｸｽによる加重'#13+
'COMPLETE R.M.S.=完全な誤差の2乗'#13+
'INCLUDE NULL VALUES=ﾇﾙ値を含める'#13+
'WEIGHT=重み'#13+
'RESIZE PIXELS TOLERANCE=ｶﾞﾝﾄﾊﾞｰの端からの距離'#13+
'EDIT LEGEND=凡例の編集'#13+
'START AT MIN. VALUE=最小値で開始'#13+
'EXECUTE !=実行'#13+
'BAND 1=ﾊﾞﾝﾄﾞ1'#13+
'BAND 2=ﾊﾞﾝﾄﾞ2'#13+
'TRANSPOSE NOW=置換'#13+
'TEXT ALIGNMENT=ﾃｷｽﾄの配置'#13+
'CALLOUT=引出線'#13+	//ｺｰﾙｱｳﾄ
'SORT BY=ｿｰﾄ'#13+
'DRAW STYLE=描画ｽﾀｲﾙ'#13+
'POINTS=ポイント'#13+
'LIGHT 0=ﾗｲﾄ0'#13+
'LIGHT 1=ﾗｲﾄ1'#13+
'LIGHT 2=ﾗｲﾄ2'#13+

{ 7.0 }
'VIEW SERIES NAMES=系列名の表示'#13+
'NAME=名称'#13+
'ZOOM ON UP LEFT DRAG=アンズームなし'#13+
'NO CHECK BOXES=ﾁｪｯｸﾎﾞｯｸｽなし'#13+
'RADIO BUTTONS=ﾗｼﾞｵﾎﾞﾀﾝ'#13+
'ONE MICROSECOND=1マイクロ秒'#13+
'DIAGONAL UP=左下から対角に'#13+
'DIAGONAL DOWN=左上から対角に'#13+
'AUTO HIDE=自動で隠す'#13+
'VIEWS=ビュー'#13+
'METAL=メタル'#13+
'WOOD=木'#13+
'STONE=石'#13+
'CLOUDS=雲'#13+
'GRASS=草'#13+
'FIRE=火'#13+
'SNOW=雪'#13+
'SYMBOL=ｼﾝﾎﾞﾙ'#13+
'TICK LINES=目盛線'#13+
'SLANT CUBE=傾斜立方体'#13+
'INVERT. ARROW=下向き矢印'#13+
'INVERT. CONE=倒立円錐'#13+
'% BAR DEPTH=棒の奥行 %'#13+
'MULTIPLE PIES=複数の円'#13+
'DISABLE=無効'#13+
'3D GRADIENT=3Dｸﾞﾗﾃﾞｰｼｮﾝ'#13+
'COLOR EACH SLICE=ｽﾗｲｽの色を分ける'#13+
'Z DATETIME=Z 日付書式'#13+
'MARGIN %=余白 %'#13+
'SHAPE INDEX=ｼｪｰﾌﾟ ｲﾝﾃﾞｯｸｽ'#13+
'CLOSED=閉じる'#13+
'FAST BRUSH=高速ﾌﾞﾗｼ'#13+
'GALLERY=ｷﾞｬﾗﾘ'#13+
'INVERTED GRAY=ｸﾞﾚｰｽｹｰﾙ反転'#13+
'RAINBOW=虹'#13+
'GRID EVERY=ｸﾞﾘｯﾄﾞの間隔'#13+
'BASE LINE=基準線'#13+
'HIDE TRIANGLES=三角形を隠す'#13+
'HIGH-LOW=高値-安値'#13+
'COLOR STYLE=色のｽﾀｲﾙ'#13+
'RELATIVE TO OPEN=前日終値と当日始値の比較'#13+
'RELATIVE TO PREVIOUS CLOSE=前日終値と当日終値の比較'#13+
'MIRRORED=左右入替'#13+
'TEXT ANTI-ALIAS=ﾃｷｽﾄ ｱﾝﾁｴｲﾘｱｽ'#13+
'TEXT QUOTES=ﾃｷｽﾄ引用符'#13+
'THEMES=テーマ'#13+
'PREVIEW=プレビュー'#13+
'MICROSOFTｮ EXCEL=Microsoft Excel'#13+
'TEECHART DEFAULT=TeeChart ﾃﾞﾌｫﾙﾄ'#13+
'BLUES=青'#13+
'COLOR PALETTE=ｶﾗｰﾊﾟﾚｯﾄ'#13+
'VICTORIAN=ビクトリア'#13+
'PASTELS=パステル'#13+
'CLASSIC=クラシック'#13+
'MODERN=モダン'#13+
'VIEW 3D=3D表示'#13+
'SCALE=ｽｹｰﾙ'#13+
'FIXED POSITION=位置を固定'#13+
'SPOT=ｽﾎﾟｯﾄ'#13+
'SET DIRECTION=方向を設定'#13+
'DIRECTIONS=方向'#13+
//Function
'DATE PERIOD=日付ﾋﾟﾘｵﾄﾞ'#13+
'TIME PERIOD=時間ﾋﾟﾘｵﾄﾞ'#13+
'SECOND=秒'#13+
'TENSECOND=10秒'#13+
'MINUTE=分'#13+
'TWOMINUTES=2分'#13+
'FIVEMINUTES=5分'#13+
'TENMINUTES=10分'#13+
'FIFTEENMINUTES=15分'#13+
'TWENTYMINUTES=20分'#13+
'HALFHOUR=30分'#13+
'TWOHOURS=2時間'#13+
'THREEHOUR=3時間'#13+
'SIXHOUR=6時間'#13+
'TWELVEHOUR=12時間'#13+
'(NONE)=(なし)'#13+
//Tool
'USE SERIES Z=系列のZ軸を使用'#13+
'CLICK TOLERANCE=ｸﾘｯｸ誤差'#13+
'SELECT NEW LINES=新しい線の選択'#13+
'CELL=セル'#13+
'ROW=行'#13+
'COLUMN=列'#13+
'LOOP=ﾙｰﾌﾟ'#13+
'NO=なし'#13+
'ONE WAY=一方向'#13+
'CIRCULAR=循環'#13+
'SERIES 2=系列2'#13+
'DRAW BEHIND SERIES=系列の背面に描画'#13+
'DRAW BEHIND AXES=軸の背面に描画'#13+
'LINEAR=線形'#13+
'SPOTLIGHT=ｽﾎﾟｯﾄﾗｲﾄ'#13+
'THUMB=サム'#13+
'BACK COLOR=背景色'#13+
'INITIAL DELAY=遅延時間'#13+
'AUTO-REPEAT=ｵｰﾄﾘﾋﾟｰﾄ'#13+
'HANDLES=角の矩形'#13+
'ALLOW RESIZE CHART=ﾁｬｰﾄのﾘｻｲｽﾞ可'#13+
//Dialog
'THEME=テーマ'#13+
'CHART THEME SELECTOR=Chartのテーマの選択'#13+
'DESIGN TIME OPTIONS=設計時のオプション'#13+
'LANGUAGE=言語'#13+
'CHART GALLERY=チャートギャラリ'#13+
'ALTERNATE=拡張'#13+
'MODE=ﾓｰﾄﾞ'#13+
'CHART EDITOR=チャートエディタ'#13+
'TREE MODE=ﾂﾘｰﾓｰﾄﾞ'#13+
'REMEMBER POSITION=位置の保存'#13+
'REMEMBER SIZE=サイズの保存'#13+
'RESET=ﾘｾｯﾄ'#13+
'NEW CHART=新しいチャート'#13+
'DEFAULT THEME=ﾃﾞﾌｫﾙﾄのﾃｰﾏ'#13+
'TEECHART PRO GALLERY=TeeChart Pro ギャラリ'#13+
'NUMERIC FORMAT=数値の形式'#13+
//'NUMBER=数'#13+
'DECIMALS=10進'#13+
'FIXED=固定'#13+
'THOUSANDS=千'#13+
//'PERCENT=百分率'#13+
'CURRENCY=通貨'#13+
'DATE TIME=日付'#13+
'GEOGRAPHIC=地域'#13+
//'CUSTOM=ｶｽﾀﾑ'#13+

//7.06
'ENTER DATE=日付入力'#13+
'ENTER TIME=時間入力'#13+
'SHOW COLORS=色の表示'#13+
'XYZ SERIES=XYZ系列'#13+
'SHOW X VALUES=X値の表示'#13+
'EDIT COLOR=色の編集'#13+
'MAKE NULL POINT=ﾇﾙﾎﾟｲﾝﾄの作成'#13+
'APPEND ROW=行の追加'#13+
'TEXT FONT=ﾃｷｽﾄ ﾌｫﾝﾄ'#13+
'HIDE SERIES AT EDITOR=系列の非表示'#13+
'CALCULATION=計算'#13+
'GROUP=ｸﾞﾙｰﾌﾟ'#13+
'SHOW IN THIS EDITOR=このエディタで表示'#13+
'TEECHART LIGHTING=TEECHART照明'#13+
'SURFACE=ｻｰﾌｪｽ'#13+
'SVG OPTIONS=SVGｵﾌﾟｼｮﾝ'#13+
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
//'SUNSET=ｻﾝｾｯﾄ'#13+
//'TROPICAL=ﾄﾛﾋﾟｶﾙ'#13+
'LOAD MODE=読込方法'#13+
'APPEND=追加'#13+

'CONE PERCENT=円錐の百分率'#13+
'GRADIENT DIRECTION=ｸﾞﾗﾃﾞｰｼｮﾝの方向'#13+
'BRUSH BACK CLEAR=ﾌﾞﾗｼの背景をｸﾘｱ'#13+
'ROWS=行'#13+
'COLUMNS=列'#13+

//7.07
'DATATABLE EDITOR=ﾃﾞｰﾀﾃｰﾌﾞﾙ ｴﾃﾞｨﾀ'#13+
'FILTERS=ﾌｨﾙﾀ'#13+
'SCALED=ｽｹｰﾙ'#13+
'ANTI-ALIAS LINES=ｱﾝﾁｴｲﾘｱｽ ﾗｲﾝ'#13+
'LEGEND SYMBOL EDITOR=凡例ｼﾝﾎﾞﾙ ｴﾃﾞｨﾀ'#13+

'PERIOD RANGE=ピリオドの範囲'#13+

//8.01
'SAMPLES=サンプル'#13+
'CLIP TEXT=ｸﾘｯﾋﾟﾝｸﾞ'#13+
'ANTI-ALIAS=ｱﾝﾁｴｲﾘｱｽ'#13+
'TREAT NULLS=ﾇﾙの取扱'#13+
'DONT PAINT=描画しない'#13+
'SKIP=スキップ'#13+
'IGNORE=無視'#13+

'SCROLL INVERTED=逆スクロール'#13+

'BANNER=バナー'#13+
'SCROLL DELAY=ｽｸﾛｰﾙ遅延'#13+
'BLINK DELAY ON=点滅遅延オン'#13+
'BLINK DELAY OFF=点滅遅延オフ'#13+
'SCROLL DIRECTION=ｽｸﾛｰﾙの方向'#13+
'BLINK=点滅'#13+
'RIGHT TO LEFT=右から左へ'#13+
'LEFT TO RIGHT=左から右へ'#13+
'HEXAGON=六角形'#13+
'VIEW=表示'#13+
'VIEW SERIES GROUPS=系列グループの表示'#13+
'PLANE=平面'#13+
'FILLED=塗りつぶし'#13+
'INDEX=ｲﾝﾃﾞｯｸｽ'#13+
'UP TO VALUE=この値まで'#13+
'EMPTY=なし'#13+
'DENSITY=密度'#13+
'AT SEGMENTS=セグメント'#13+
'FONT COLOR LEVEL=ﾌｫﾝﾄの色ﾚﾍﾞﾙ'#13+
'ANTI OVERLAP=重ねない'#13+
'AT BOTTOM=下に'#13+
'MOUSE=マウス'#13+
'SCOPE SIZE=ｽｺｰﾌﾟｻｲｽﾞ'#13+
'SCOPE STYLE=ｽｺｰﾌﾟｽﾀｲﾙ'#13+
'SCOPE=スコープ'#13+
'SCOPE ONLY=スコープのみ'#13+
'CAMERA=カメラ'#13+
'SNAP STYLE=ｽﾅｯﾌﾟｽﾀｲﾙ'#13+
'CALCULATE=計算'#13+
'DISPLAY=表示'#13+
'POLYNOMY=多項式'#13+
'DEGREE=次数'#13+
'HORIZ. PARALLEL=水平並列'#13+
'VERT. PARALLEL=垂直並列'#13+
'EXCEL FILE=Excelﾌｧｲﾙ'#13+
'WORKSHEET=ﾜｰｸｼｰﾄ'#13+
'VALUES RANGE=値の範囲'#13+
'FROM=から'#13+
'TO=まで'#13+
'LABELS RANGE=ﾗﾍﾞﾙの範囲'#13+
'FADE=ﾌｪｰﾄﾞ'#13+
'FADE IN=ﾌｪｰﾄﾞｲﾝ'#13+
'FADE OUT=ﾌｪｰﾄﾞｱｳﾄ'#13+
'SHOW ALL LABELS=全てのラベルの表示'#13+

'SERIES GROUPS=系列グループ'#13+
'AUTO SCALE AXIS=軸の自動ｽｹｰﾙ'#13+
'NO PAGES=ﾍﾟｰｼﾞなし'#13+
'BACK IMAGE INSIDE=背景ｲﾒｰｼﾞをｸﾞﾗﾌの内側へ'#13+
'TEXT ALIGN=配置'#13+
'SERIES TITLE=系列のﾀｲﾄﾙ'#13+
'PERCENT RELATIVE=相対百分率'#13+
'VERT. MARGIN=垂直の余白'#13+
'POINT SIZE=ﾎﾟｲﾝﾄｻｲｽﾞ'#13+

'PASPARTOU=余白'#13+
'GOLD=金'#13+
'SILVER=銀'#13+
'CHERRY=チェリー'#13+
'PINE=パイン'#13+
'CHANGE COLOR=色の変更'#13+
'LEGEND EVERY=凡例毎'#13+
'CUSTOM PALETTES=ｶｽﾀﾑﾊﾟﾚｯﾄ'#13+
//'WIN. XP='#13+
//'MAC OS='#13+
//'WIN. VISTA='#13+
'OPERA=オペラ'#13+
'WARM=ウォーム'#13+
'COOL=クール'#13+
'INVERT=反転'#13+
'HIDE CELLS=ｾﾙを非表示'#13+
'BANDS PEN=帯ペン'#13+
'MOUSE WHEEL ZOOM=ﾏｳｽﾎｲｰﾙのｽﾞｰﾑ'#13+
'ZOOM %=ズーム %'#13+
//'HIDE DELAY=遅延時間の非表示'#13+
'HIDE DELAY=表示解除時間'#13+

'RESET POSITION=位置のリセット'#13+

'CALLOUT LEG SIZE=引出線の長さ'#13+
'VERTICAL CENTER CALLOUT=引出線を垂直中央に'#13+
'INERTIA=慣性'#13+
'ACCELERATION=加速度'#13+
'MAX. STEP=最大ｽﾃｯﾌﾟ'#13+
'THUMB 1=サム 1'#13+
'THUMB 2=サム 2'#13+
'THUMB 3=サム 3'#13+
'THUMB 4=サム 4'#13+
'BOUNDS=境界'#13+
'INFO=情報'#13+
'TEXT EDITOR=ﾃｷｽﾄ ｴﾃﾞｨﾀ'#13+
'LOAD..=読込..'#13+

'ITALIC=斜体'#13+
'BOLD=太字'#13+
'STRIKEOUT=取り消し線'#13+
'UNDERLINE=下線'#13+

'SUBGRADIENT=ｻﾌﾞｸﾞﾗﾃﾞｰｼｮﾝ'#13+

'TILT=傾斜'#13+
'FILE NAME=ファイル名'#13+

'PLAY=再生'#13+
'IMAGE TOOL=ｲﾒｰｼﾞﾂｰﾙ'#13+
'WALL=壁'#13+
'MSEC PER FRAME=1ﾌﾚｰﾑのﾐﾘ秒'#13+

//'HIGHEST=最も高い'#13+
//'VERY HIGH=より高い'#13+
//'MEDIUM=中間'#13+
'RECORD=録画'#13+

'STOP=停止'#13+
'MIRROR ANGLES=鏡'#13+
'XML DATA=XMLデータ'#13+

'BLUR=ぼかし'#13+
'CLIP=ｸﾘｯﾋﾟﾝｸﾞ'#13+
'SPACING=間隔'#13+
'LINE STYLE=線のｽﾀｲﾙ'#13+
'NODES=ノード'#13+
'BUY=買い'#13+
'SELL=売り'#13+
'FILTER=ﾌｨﾙﾀ'#13+
'SEPARATION %=間隔 %'#13+
'DIGITAL FONT=ﾃﾞｼﾞﾀﾙﾌｫﾝﾄ'#13+
'MARKERS=マーカ'#13+
'OUTER=外側'#13+
'VALUE AREA=値の範囲'#13+
'MAX. INDICATOR=最大ｲﾝｼﾞｹｰﾀ'#13+
'HAND=針'#13+
'MINOR TICKS=副目盛'#13+
'GREEN LINE=緑線'#13+
'RED LINE=赤線'#13+
'LABELS INSIDE=ﾗﾍﾞﾙを内側に'#13+
'ROTATE LABELS=ﾗﾍﾞﾙの回転'#13+
'HAND DISTANCE=針の間隔'#13+
'HAND OFFSET=針のｵﾌｾｯﾄ'#13+
'MAP=マップ'#13+
'WORLD=世界'#13+
'AFRICA=アフリカ'#13+
'ASIA=アジア'#13+
'AUSTRALIA=オーストラリア'#13+
'CENTRAL AMERICA=中央アメリカ'#13+
'EUROPE=ヨーロッパ'#13+
'EUROPE 15=ヨーロッパ 15'#13+
'EUROPE 27=ヨーロッパ 27'#13+
'SPAIN=スペイン'#13+
'MIDDLE EAST=中東'#13+
'NORTH AMERICA=北アメリカ'#13+
'SOUTH AMERICA=南アメリカ'#13+
'USA=アメリカ'#13+
'USA HAWAII ALASKA=ｱﾒﾘｶ ﾊﾜｲ ｱﾗｽｶ'#13+
'SECTORS=セクタ'#13+
'TRACKS=トラック'#13+

//Tool
'FIBONACCI STYLE=ﾌｨﾎﾞﾅｯﾁ ｽﾀｲﾙ'#13+
'ARCS=弧'#13+
'FANS=扇'#13+
'TRENDLINE=トレンドライン'#13+
'REMOVE=削除'#13+
'DRAW LABELS=ラベルの描画'#13+
'ANIMATE !=ｱﾆﾒｰｼｮﾝ !'#13+
'TRANSPOSE !=置換 !'#13+
'LINK=リンク'#13+
'HINT=ヒント'#13+
//Editor
'PAGENUMTOOLEDIT=ﾍﾟｰｼﾞ数 ﾂｰﾙｴﾃﾞｨﾀ'#13+
'SHOW BUTTONS=ボタンの表示'#13+
'BUTTON WIDTH=ボタンの幅'#13+
'ENABLED BUTTON=有効なボタン'#13+
'DISABLED BUTTON=無効なボタン'#13+
//Export
'COMPILE=コンパイル'#13+
'PREVIEW AFTER COMPILE=コンパイル後のプレビュー'#13+
'TEMPORARY FOLDER=テンポラリフォルダ'#13+
'DISABLED BUTTON=無効なボタン'#13+
'PATH TO ADOBE FLEX COMPILER=Adobe Flex コンパイラのパス'#13+
'DELETE TEMPORARY FILES AFTER COMPILATION=コンパイル後にテンポラリファイルを削除'#13+
'EMBEDDED IMAGES=イメージの埋め込み'#13+

//8.02
'GRADIENT BRIGHT=ｸﾞﾗﾃﾞｰｼｮﾝの輝度'#13+

'REGION=領域'#13+
'PERCENT FONT=フォントの百分率'#13+
'PERCENT SIZE=サイズの百分率'#13+
'RENAME=ﾘﾈｰﾑ'#13+
'ANTIALIAS=アンチエイリアス'#13+
'CURRENT=カレント'#13+
'FADE !=ﾌｪｰﾄﾞ !'#13+
'FULL SCREEN !=全画面 !'#13+

'USE SERIES FORMAT=系列の形式を使用'#13+
'VALUE FORMAT=値の形式'#13+
'SPOT LIGHT=ｽﾎﾟｯﾄﾗｲﾄ'#13+
'FONTS=フォント'#13+
//TeeEdiGene.pas - TFormTeeGeneral.FillFonts
'DEPTH AXIS=奥軸'#13+
'DEPTH TOP AXIS=奥軸(上)'#13+
'FOOTER=ﾌｯﾀ-'#13+
'LEGEND TITLE=凡例タイトル'#13+
'SUBFOOTER=ｻﾌﾞﾌｯﾀ-'#13+
'CUSTOM AXIS=カスタム軸'#13+

{AX 5.0.4}
'COLOR EACH LINE=線の色を分ける'#13+
'SUBFOOT=サブフッター'#13+
'FOOT=フッター'#13+
'RADIAL=放射状に'#13+
'BUTTON=ボタン'#13+
'ALL=全て'#13

{$IFDEF TEEOCX}
+
{ADO Editor}
'TEECHART PRO -- SELECT ADO DATASOURCE=TeeChart Pro -- ADOデータソースの選択'#13+
'CONNECTION=接続'#13+
'DATASET=データセット'#13+
'TABLE=テーブル'#13+
'SQL=SQL'#13+
'SYSTEM TABLES=システムテーブル'#13+
'LOGIN PROMPT=ﾛｸﾞｲﾝ ﾌﾟﾛﾝﾌﾟﾄ'#13+
'SELECT=選択'#13+
{Import dialogue}
'TEECHART IMPORT=TeeChart インポート'#13+
'IMPORT CHART FROM=インポートチャート場所'#13+
'IMPORT NOW=インポート'#13+
{Property page}
'EDIT CHART=チャートの編集'#13
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
