{*******************************************************}
{                                                       }
{       TiStripChart Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iStripChart;{$endif}
{$ifdef iCLX}unit QiStripChart;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Printers,  iTypes,  iGPFunctions,  iClasses,  iMath,  iDoubleList,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QPrinters, QiTypes, QiGPFunctions, QiClasses, QiMath, QiDoubleList, QiCustomComponent;{$ENDIF}

const
  TIME_HOUR   = 1/24;
  TIME_MINUTE = TIME_HOUR/60;
  TIME_SECOND = TIME_MINUTE/60;

type
  TiAutoScroll           = (iasSmooth, iasStep, iasPage, iasSmoothOffset);
  TiStripChartMode       = (iscmPlot, iscmScrollX, iscmScrollY, iscmScrollXY, iscmCursor, iscmZoomX, iscmZoomY, iscmZoomXY, iscmZoomBox);
  TiAutoScrollFirstStyle = (iasfsAuto, iasfsLeftJustify, iasfsRightJustify);

  TiStripChart = class(TiCustomComponent)
  private
    FPrinterCommentList           : TStringList;
    FMouseDownX                   : Integer;
    FMouseDownY                   : Integer;
    FZoomMouseDownX               : Integer;
    FZoomMouseDownY               : Integer;
    FZoomMouseUpX                 : Integer;
    FZoomMouseUpY                 : Integer;

    //Kylix TODO
    {$ifndef iCLX}
    FMetaFile                     : TMetafile;
    {$endif}
    FSnapShotPicture              : TPicture;

    FElapsedStartTime             : TDateTime;

    FLimitLinesOnTop              : Boolean;
    FGridLinesOnTop               : Boolean;

    FOriginalXMax                 : Double;
    FOriginalXMin                 : Double;
    FOriginalYMax                 : Double;
    FOriginalYMin                 : Double;

    FCursorChannel                : Integer;
    FCursorIndex                  : Integer;

    FToolBarButtonIndex           : Integer;

    FToolBarTop                   : Integer;
    FToolBarBottom                : Integer;
    FToolBarHeight                : Integer;
    FToolBarVCenter               : Integer;

    FPlotTextStart                : Integer;
    FScrollXTextStart             : Integer;
    FScrollYTextStart             : Integer;
    FScrollXYTextStart            : Integer;
    FCursorTextStart              : Integer;
    FZoomXTextStart               : Integer;
    FZoomYTextStart               : Integer;
    FZoomXYTextStart              : Integer;
    FZoomBoxTextStart             : Integer;

    FPlotTextStop                 : Integer;
    FScrollXTextStop              : Integer;
    FScrollYTextStop              : Integer;
    FScrollXYTextStop             : Integer;
    FCursorTextStop               : Integer;
    FZoomXTextStop                : Integer;
    FZoomYTextStop                : Integer;
    FZoomXYTextStop               : Integer;
    FZoomBoxTextStop              : Integer;

    FMinXAxisData                 : Double;
    FMaxXAxisData                 : Double;
    FMinYAxisData                 : Double;
    FMaxYAxisData                 : Double;
    FIndexList                    : TiDoubleList;
    FPlotStartIndex               : Integer;
    FPlotStopIndex                : Integer;

    FNeedsDataUpdate              : Boolean;
    FFirstDataPoint               : Boolean;

    FChannelList                  : TStringList;
    FLabelChannelList             : TStringList;
    FVerticalLineList             : TStringList;
    FXMLCommentList               : TStringList;
    FMouseDown                    : Boolean;
    FGridLeft                     : Integer;
    FGridTop                      : Integer;
    FGridBottom                   : Integer;
    FGridRight                    : Integer;
    FXAxisLabelTop                : Integer;
    FXAxisLabelBottom             : Integer;
    FXAxisTitleTop                : Integer;
    FYAxisLabelRight              : Integer;
    FYAxisTitleRight              : Integer;
    FXAxisWidth                   : Integer;
    FYAxisHeight                  : Integer;
    FTitleBottom                  : Integer;
    FLegendLeft                   : Integer;
    FLegendTop                    : Integer;
    FLegendRight                  : Integer;
    FLegendBottom                 : Integer;
    FLegendRowHeight              : Integer;

    FXAxisMax                     : Double;
    FXAxisMin                     : Double;
    FXAxisShow                    : Boolean;
    FXAxisMargin                  : Integer;
    FXAxisDateTimeEnabled         : Boolean;
    FXAxisDateTimeFormatString    : String;
    FXAxisTickMajorCount          : Integer;
    FXAxisTickMajorLength         : Integer;
    FXAxisTickMajorColor          : TColor;
    FXAxisTickMinorCount          : Integer;
    FXAxisTickMinorLength         : Integer;
    FXAxisTickMinorColor          : TColor;
    FXAxisLabelFont               : TFont;
    FXAxisLabelMargin             : Integer;
    FXAxisLabelPrecision          : Integer;
    FXAxisTitle                   : String;
    FXAxisTitleFont               : TFont;
    FXAxisTitleMargin             : Integer;

    FYAxisMax                     : Double;
    FYAxisMin                     : Double;
    FYAxisReverseScale            : Boolean;
    FYAxisShow                    : Boolean;
    FYAxisMargin                  : Integer;
    FYAxisTickMajorCount          : Integer;
    FYAxisTickMajorLength         : Integer;
    FYAxisTickMajorColor          : TColor;
    FYAxisTickMinorColor          : TColor;
    FYAxisTickMinorCount          : Integer;
    FYAxisTickMinorLength         : Integer;
    FYAxisLabelFont               : TFont;
    FYAxisLabelMargin             : Integer;
    FYAxisLabelPrecision          : Integer;
    FYAxisTitleMargin             : Integer;
    FYAxisTitle                   : String;
    FYAxisTitleFont               : TFont;
    FYAxisLabelWidthFixed         : Boolean;
    FYAxisLabelWidth              : Integer;

    FOuterMarginTop               : Integer;
    FOuterMarginLeft              : Integer;
    FOuterMarginRight             : Integer;
    FOuterMarginBottom            : Integer;

    FAxisGridColor                : TColor;
    FGridLineStyle                : TiChannelLineStyle;
    FGridBackGroundColor          : TColor;
    FShowGrid                     : Boolean;
    FShowLegend                   : Boolean;
    FLegendWidth                  : Integer;
    FLegendMargin                 : Integer;
    FShowToolBar                  : Boolean;
    FLegendFont                   : TFont;
    FTitleText                    : String;
    FTitleMargin                  : Integer;
    FTitleFont                    : TFont;
    FAutoScrollEnabled            : Boolean;
    FAutoScrollType               : TiAutoScroll;
    FAutoScrollStepSize           : Double;
    FAutoScaleEnabled             : Boolean;
    FAutoScaleHysterisis          : Double;
    FToolBarActiveModeFont        : TFont;
    FToolBarInactiveModeFont      : TFont;
    FToolBarMode                  : TiStripChartMode;
    FCursorColor                  : TColor;
    FCursorChannelBackGroundColor : TColor;
    FCursorChannelFontColor       : TColor;
    FOnDataUpdate                 : TNotifyEvent;
    FOnModeChange                 : TNotifyEvent;
    FOnCursorChange               : TNotifyEvent;
    FOnXAxisMaxChange             : TNotifyEvent;
    FOnYAxisMaxChange             : TNotifyEvent;
    FOnXAxisMinChange             : TNotifyEvent;
    FOnYAxisMinChange             : TNotifyEvent;
    //Kylix TODO
    {$ifndef iCLX}
    FPrinterOrientation           : TPrinterOrientation;
    {$endif}
    FRestoreXYAxisOnPlotMode      : Boolean;
    FPrinterMarginRight           : Double;
    FPrinterMarginBottom          : Double;
    FPrinterMarginTop             : Double;
    FPrinterMarginLeft            : Double;
    FOnCursorIndexChange          : TNotifyEvent;
    FMaxBufferSize                : Integer;
    FMinBufferSize                : Integer;
    FPrinterCommentLinesFont      : TFont;
    FPrinterCommentLineSpacing    : Double;
    FCursorHideAllOtherChannels   : Boolean;
    FEnableDataDrawMinMax         : Boolean;
    FAutoScaleMinAdjustEnabled    : Boolean;
    FAutoScaleMaxAdjustEnabled    : Boolean;
    FDiscontinuousDataEnabled     : Boolean;
    FAutoScrollFirstStyle         : TiAutoScrollFirstStyle;
    FPrecisionStyle               : TiPrecisionStyle;
    FInterpolateMissingDataPoints : Boolean;
    FPrinterShowDialog            : Boolean;

    function GetLabelChannelCount                            : Integer;
    function GetChannelCount                                 : Integer;
    function GetIndexCount                                   : Integer;
    function GetChannelTitle       (Index: Integer)          : String;
    function GetChannelColor       (Index: Integer)          : TColor;
    function GetChannelLineStyle   (Index: Integer)          : TiChannelLineStyle;
    function GetChannelLineWidth   (Index: Integer)          : Integer;
    function GetChannelVisible     (Index: Integer)          : Boolean;
    function GetChannelData        (Channel, Index: Integer) : Double;
    function GetChannelUseFixedAxis(Index: Integer)          : Boolean;
    function GetIndexTime          (Index: Integer)          : Double;

    procedure SetXAxisMax                    (const Value: Double);
    procedure SetXAxisMin                    (const Value: Double);
    procedure SetXAxisDateTimeEnabled        (const Value: Boolean);
    procedure SetXAxisDateTimeFormatString   (const Value: String);
    procedure SetXAxisTickMajorCount         (const Value: Integer);
    procedure SetXAxisTickMinorCount         (const Value: Integer);
    procedure SetYAxisMax                    (const Value: Double);
    procedure SetYAxisMin                    (const Value: Double);
    procedure SetYAxisTickMajorCount         (const Value: Integer);
    procedure SetYAxisTickMinorCount         (const Value: Integer);
    procedure SetXAxisLabelFont              (const Value: TFont);
    procedure SetXAxisLabelMargin            (const Value: Integer);
    procedure SetXAxisMargin                 (const Value: Integer);
    procedure SetYAxisLabelFont              (const Value: TFont);
    procedure SetYAxisLabelMargin            (const Value: Integer);
    procedure SetYAxisMargin                 (const Value: Integer);
    procedure SetXAxisTickMajorLength        (const Value: Integer);
    procedure SetXAxisTickMinorLength        (const Value: Integer);
    procedure SetYAxisTickMajorLength        (const Value: Integer);
    procedure SetYAxisTickMinorLength        (const Value: Integer);
    procedure SetXAxisLabelPrecision         (const Value: Integer);
    procedure SetYAxisLabelPrecision         (const Value: Integer);
    procedure SetOuterMarginBottom           (const Value: Integer);
    procedure SetOuterMarginLeft             (const Value: Integer);
    procedure SetOuterMarginRight            (const Value: Integer);
    procedure SetOuterMarginTop              (const Value: Integer);
    procedure SetXAxisTickMajorColor         (const Value: TColor);
    procedure SetXAxisTickMinorColor         (const Value: TColor);
    procedure SetYAxisTickMajorColor         (const Value: TColor);
    procedure SetYAxisTickMinorColor         (const Value: TColor);
    procedure SetAxisGridColor               (const Value: TColor);
    procedure SetGridLineStyle               (const Value: TiChannelLineStyle);
    procedure SetShowGrid                    (const Value: Boolean);
    procedure SetShowLegend                  (const Value: Boolean);
    procedure SetLegendWidth                 (const Value: Integer);
    procedure SetLegendMargin                (const Value: Integer);
    procedure SetShowToolBar                 (const Value: Boolean);
    procedure SetLegendFont                  (const Value: TFont);
    procedure SetXAxisTitle                  (const Value: String);
    procedure SetXAxisTitleFont              (const Value: TFont);
    procedure SetXAxisTitleMargin            (const Value: Integer);
    procedure SetYAxisTitle                  (const Value: String);
    procedure SetYAxisTitleFont              (const Value: TFont);
    procedure SetYAxisTitleMargin            (const Value: Integer);
    procedure SetTitleText                   (const Value: String);
    procedure SetTitleFont                   (const Value: TFont);
    procedure SetTitleMargin                 (const Value: Integer);
    procedure SetAutoScrollEnabled           (const Value: Boolean);
    procedure SetAutoScrollType              (const Value: TiAutoScroll);
    procedure SetAutoScrollStepSize          (const Value: Double);
    procedure SetAutoScaleEnabled            (const Value: Boolean);
    procedure SetAutoScaleHysterisis         (const Value: Double);
    procedure SetToolBarActiveModeFont       (const Value: TFont);
    procedure SetToolBarInactiveModeFont     (const Value: TFont);
    procedure SetToolBarMode                 (const Value: TiStripChartMode);
    procedure SetCursorChannel               (const Value: Integer);
    procedure SetCursorColor                 (const Value: TColor);
    procedure SetCursorChannelBackGroundColor(const Value: TColor);
    procedure SetCursorChannelFontColor      (const Value: TColor);
    procedure SetXAxisShow                   (const Value: Boolean);

    procedure SetChannelColor                (Index: Integer; const Value: TColor);
    procedure SetChannelLineStyle            (Index: Integer; const Value: TiChannelLineStyle);
    procedure SetChannelTitle                (Index: Integer; const Value: String);
    procedure SetChannelLineWidth            (Index: Integer; const Value: Integer);
    procedure SetChannelVisible              (Index: Integer; const Value: Boolean);
    procedure SetChannelData                 (Channel, Index: Integer; const Value: Double);
    procedure SetChannelUseFixedAxis         (Index: Integer; const Value: Boolean);

    procedure SetGridBackGroundColor         (const Value: TColor);
    procedure SetMaxBufferSize               (const Value: Integer);
    procedure SetMinBufferSize               (const Value: Integer);
    procedure SetCursorIndex                 (const Value: Integer);
    procedure SetPrinterCommentLinesFont     (const Value: TFont);
    procedure SetCursorHideAllOtherChannels  (const Value: Boolean);
    procedure SetEnableDataDrawMinMax        (const Value: Boolean);
    function GetChannelMax                   (Index: Integer): Double;
    function GetChannelMean                  (Index: Integer): Double;
    function GetChannelMin                   (Index: Integer): Double;

    //Kylix TODO
    {$ifndef iCLX}
    function GetSnapShotPicture: TPicture;
    {$endif}
    
    function GetLabelChannelText(Channel, Index: Integer): String;
    function GetLabelYPosition           (Index: Integer): Double;
    function GetLabelChannelFontName     (Index: Integer): String;
    function GetLabelChannelFontSize     (Index: Integer): Integer;
    function GetLabelChannelFontColor    (Index: Integer): TColor;
    function GetLabelChannelFontBold     (Index: Integer): Boolean;
    function GetLabelChannelFontItalic   (Index: Integer): Boolean;
    function GetLabelChannelFontUnderLine(Index: Integer): Boolean;
    function GetLabelChannelFontStrikeOut(Index: Integer): Boolean;

    procedure SetLabelChannelText(Channel, Index: Integer; const Value: String);
    procedure SetLabelYPosition           (Index: Integer; const Value: Double);
    procedure SetLabelChannelFontName     (Index: Integer; const Value: String);
    procedure SetLabelChannelFontSize     (Index: Integer; const Value: Integer);
    procedure SetLabelChannelFontColor    (Index: Integer; const Value: TColor);
    procedure SetLabelChannelFontBold     (Index: Integer; const Value: Boolean);
    procedure SetLabelChannelFontItalic   (Index: Integer; const Value: Boolean);
    procedure SetLabelChannelFontUnderLine(Index: Integer; const Value: Boolean);
    procedure SetLabelChannelFontStrikeOut(Index: Integer; const Value: Boolean);

    procedure SetChannelControlLimitUpperShow     (Index: Integer; const Value: Boolean);
    procedure SetChannelControlLimitUpperValue    (Index: Integer; const Value: Double);
    procedure SetChannelControlLimitUpperColor    (Index: Integer; const Value: TColor);
    procedure SetChannelControlLimitUpperLineStyle(Index: Integer; const Value: TiChannelLineStyle);

    procedure SetChannelControlLimitLowerShow     (Index: Integer; const Value: Boolean);
    procedure SetChannelControlLimitLowerValue    (Index: Integer; const Value: Double);
    procedure SetChannelControlLimitLowerColor    (Index: Integer; const Value: TColor);
    procedure SetChannelControlLimitLowerLineStyle(Index: Integer; const Value: TiChannelLineStyle);

    procedure SetChannelWarningLimitUpperShow     (Index: Integer; const Value: Boolean);
    procedure SetChannelWarningLimitUpperValue    (Index: Integer; const Value: Double);
    procedure SetChannelWarningLimitUpperColor    (Index: Integer; const Value: TColor);
    procedure SetChannelWarningLimitUpperLineStyle(Index: Integer; const Value: TiChannelLineStyle);

    procedure SetChannelWarningLimitLowerShow     (Index: Integer; const Value: Boolean);
    procedure SetChannelWarningLimitLowerValue    (Index: Integer; const Value: Double);
    procedure SetChannelWarningLimitLowerColor    (Index: Integer; const Value: TColor);
    procedure SetChannelWarningLimitLowerLineStyle(Index: Integer; const Value: TiChannelLineStyle);

    function  GetChannelControlLimitUpperShow     (Index: Integer): Boolean;
    function  GetChannelControlLimitUpperValue    (Index: Integer): Double;
    function  GetChannelControlLimitUpperColor    (Index: Integer): TColor;
    function  GetChannelControlLimitUpperLineStyle(Index: Integer): TiChannelLineStyle;

    function  GetChannelControlLimitLowerShow     (Index: Integer): Boolean;
    function  GetChannelControlLimitLowerValue    (Index: Integer): Double;
    function  GetChannelControlLimitLowerColor    (Index: Integer): TColor;
    function  GetChannelControlLimitLowerLineStyle(Index: Integer): TiChannelLineStyle;

    function  GetChannelWarningLimitUpperShow     (Index: Integer): Boolean;
    function  GetChannelWarningLimitUpperValue    (Index: Integer): Double;
    function  GetChannelWarningLimitUpperColor    (Index: Integer): TColor;
    function  GetChannelWarningLimitUpperLineStyle(Index: Integer): TiChannelLineStyle;

    function  GetChannelWarningLimitLowerShow     (Index: Integer): Boolean;
    function  GetChannelWarningLimitLowerValue    (Index: Integer): Double;
    function  GetChannelWarningLimitLowerColor    (Index: Integer): TColor;
    function  GetChannelWarningLimitLowerLineStyle(Index: Integer): TiChannelLineStyle;

    procedure SetAutoScaleMaxAdjustEnabled(const Value: Boolean);
    procedure SetAutoScaleMinAdjustEnabled(const Value: Boolean);
    procedure SetDiscontinuousDataEnabled (const Value: Boolean);
    procedure SetPrecisionStyle(const Value: TiPrecisionStyle);
    procedure SetInterpolateMissingDataPoints(const Value: Boolean);
    procedure SetYAxisShow(const Value: Boolean);
    function GetChannelVisibleInLegend(Index: Integer): Boolean;
    procedure SetChannelVisibleInLegend(Index: Integer; const Value: Boolean);
    procedure SetYAxisLabelWidth(const Value: Integer);
    procedure SetYAxisLabelWidthFixed(const Value: Boolean);
    procedure SetYAxisReverseScale(const Value: Boolean);
    function GetChannelControlLimitLowerLineWidth(Index: Integer): Integer;
    function GetChannelControlLimitUpperLineWidth(Index: Integer): Integer;
    function GetChannelWarningLimitLowerLineWidth(Index: Integer): Integer;
    function GetChannelWarningLimitUpperLineWidth(Index: Integer): Integer;
    procedure SetChannelControlLimitLowerLineWidth(Index: Integer; const Value: Integer);
    procedure SetChannelControlLimitUpperLineWidth(Index: Integer; const Value: Integer);
    procedure SetChannelWarningLimitLowerLineWidth(Index: Integer; const Value: Integer);
    procedure SetChannelWarningLimitUpperLineWidth(Index: Integer; const Value: Integer);
  private
    function GetAddYChannel1Now: Double;
    procedure SetAddYChannel1Now(const Value: Double);
  protected
    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint);            override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);             override;

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure CalcPoints;
    procedure CalcCursorIndex(X : Integer);
    procedure CalcNewStartXIndex;
    procedure CalcNewStopXIndex;
    function  CalcIndex(TargetValue : Double) : Integer;

    procedure iPaintTo          (Canvas: TCanvas); override;
    procedure DrawXTicks        (Canvas: TCanvas);
    procedure DrawYTicks        (Canvas: TCanvas);
    procedure DrawLegend        (Canvas: TCanvas);
    procedure DrawTitle         (Canvas: TCanvas);
    procedure DrawXAxisLabels   (Canvas: TCanvas);
    procedure DrawModeLabels    (Canvas: TCanvas);
    procedure DrawData          (Canvas: TCanvas);
    procedure DrawLabels        (Canvas: TCanvas);
    procedure DrawClip          (Canvas: TCanvas);
    procedure DrawLimits        (Canvas: TCanvas);
    procedure DrawVertLines     (Canvas: TCanvas);
    procedure DrawAxisLines     (Canvas: TCanvas);
    procedure DrawGrid          (Canvas: TCanvas);
    procedure DrawGridBackGround(Canvas: TCanvas);
    procedure DrawConnectPoints (Canvas: TCanvas);

    function GetChannel     (Index : Integer): TiStripChartChannelObject;
    function GetLabelChannel(Index: Integer) : TiLabelChannelObject;
    function GetActualTimeIndex(Value : Integer) : Integer;

    function GetXPixels(Value: Double): Integer;
    function GetYPixels(Value: Double): Integer;
    function GetChannelYPixels(Value: Double; FixedAxis: Boolean): Integer;

    procedure ScrollCursorInView;

    function  GetXAxisDecimalPoints: Integer;
    function  GetYAxisDecimalPoints: Integer;

    function  GetToolBarButtonIndex(X, Y: Integer): Integer;

    function  ChannelColorInUse(Value: TColor): Boolean;

    procedure DefineProperties(Filer: TFiler); override;
    function  DoWriteChannels : Boolean;
    procedure WriteChannels   (Writer: TWriter);
    procedure ReadChannels    (Reader: TReader);
    procedure WriteXAxisMax   (Writer: TWriter);
    procedure ReadXAxisMax    (Reader: TReader);
    procedure WriteYAxisMax   (Writer: TWriter);
    procedure ReadYAxisMax    (Reader: TReader);

    procedure DoAutoScroll(Time : Double);

    procedure DoModeChange;
    procedure DoDataUpdate;
    procedure DoCursorChange;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy;                     override;

    procedure   AddChannel(Title: String; AColor: TColor; LineStyle: TiChannelLineStyle; LineWidth: Integer);
    procedure   RemoveChannel(Index : Integer);
    procedure   RemoveAllChannels;
    property    ChannelCount                          : Integer            read GetChannelCount;

    property    ChannelTitle          [Index : Integer] : String             read GetChannelTitle              write SetChannelTitle;
    property    ChannelColor          [Index : Integer] : TColor             read GetChannelColor              write SetChannelColor;
    property    ChannelLineStyle      [Index : Integer] : TiChannelLineStyle read GetChannelLineStyle          write SetChannelLineStyle;
    property    ChannelLineWidth      [Index : Integer] : Integer            read GetChannelLineWidth          write SetChannelLineWidth;
    property    ChannelVisible        [Index : Integer] : Boolean            read GetChannelVisible            write SetChannelVisible;
    property    ChannelVisibleInLegend[Index : Integer] : Boolean            read GetChannelVisibleInLegend    write SetChannelVisibleInLegend;
    property    ChannelUseFixedAxis   [Index : Integer] : Boolean            read GetChannelUseFixedAxis       write SetChannelUseFixedAxis;
    property    ChannelMin            [Index : Integer] : Double             read GetChannelMin;
    property    ChannelMax            [Index : Integer] : Double             read GetChannelMax;
    property    ChannelMean           [Index : Integer] : Double             read GetChannelMean;
    property    ChannelData  [Channel, Index : Integer] : Double             read GetChannelData               write SetChannelData;

    procedure   AddLabelChannel(YPosition : Double);
    procedure   RemoveLabelChannel(Index : Integer);
    procedure   RemoveAllLabelChannels;
    property    LabelChannelCount                          : Integer       read GetLabelChannelCount;

    property    LabelChannelText[Channel, Index : Integer] : String        read GetLabelChannelText          write SetLabelChannelText;
    property    LabelChannelYPosition    [Index : Integer] : Double        read GetLabelYPosition            write SetLabelYPosition;
    property    LabelChannelFontName     [Index : Integer] : String        read GetLabelChannelFontName      write SetLabelChannelFontName;
    property    LabelChannelFontSize     [Index : Integer] : Integer       read GetLabelChannelFontSize      write SetLabelChannelFontSize;
    property    LabelChannelFontColor    [Index : Integer] : TColor        read GetLabelChannelFontColor     write SetLabelChannelFontColor;
    property    LabelChannelFontBold     [Index : Integer] : Boolean       read GetLabelChannelFontBold      write SetLabelChannelFontBold;
    property    LabelChannelFontItalic   [Index : Integer] : Boolean       read GetLabelChannelFontItalic    write SetLabelChannelFontItalic;
    property    LabelChannelFontUnderLine[Index : Integer] : Boolean       read GetLabelChannelFontUnderLine write SetLabelChannelFontUnderLine;
    property    LabelChannelFontStrikeOut[Index : Integer] : Boolean       read GetLabelChannelFontStrikeOut write SetLabelChannelFontStrikeOut;

    property    CursorIndex                           : Integer            read FCursorIndex                 write SetCursorIndex;

    procedure   EndUpdate; override;
    procedure   ClearData;

    procedure   SetBufferSize    (Value : Integer);
    procedure   SetRingBufferSize(Value : Integer);

    procedure   SetChannelControlLimits(Channel : Integer; ShowUpper : Boolean; UpperValue : Double; UpperLineStyle : TiChannelLineStyle;
                                                           ShowLower : Boolean; LowerValue : Double; LowerLineStyle : TiChannelLineStyle);
    procedure   SetChannelWarningLimits(Channel : Integer; ShowUpper : Boolean; UpperValue : Double; UpperLineStyle : TiChannelLineStyle;
                                                           ShowLower : Boolean; LowerValue : Double; LowerLineStyle : TiChannelLineStyle);

    procedure   SetLimitLinesOnTop(const Value : Boolean);
    procedure   SetGridLinesOnTop (const Value : Boolean);

    property   ElapsedStartTime : TDateTime read FElapsedStartTime write FElapsedStartTime;    

    property   ChannelControlLimitUpperShow     [Index : Integer] : Boolean            read GetChannelControlLimitUpperShow      write SetChannelControlLimitUpperShow;
    property   ChannelControlLimitUpperValue    [Index : Integer] : Double             read GetChannelControlLimitUpperValue     write SetChannelControlLimitUpperValue;
    property   ChannelControlLimitUpperColor    [Index : Integer] : TColor             read GetChannelControlLimitUpperColor     write SetChannelControlLimitUpperColor;
    property   ChannelControlLimitUpperLineStyle[Index : Integer] : TiChannelLineStyle read GetChannelControlLimitUpperLineStyle write SetChannelControlLimitUpperLineStyle;
    property   ChannelControlLimitUpperLineWidth[Index : Integer] : Integer            read GetChannelControlLimitUpperLineWidth write SetChannelControlLimitUpperLineWidth;

    property   ChannelControlLimitLowerShow     [Index : Integer] : Boolean            read GetChannelControlLimitLowerShow      write SetChannelControlLimitLowerShow;
    property   ChannelControlLimitLowerValue    [Index : Integer] : Double             read GetChannelControlLimitLowerValue     write SetChannelControlLimitLowerValue;
    property   ChannelControlLimitLowerColor    [Index : Integer] : TColor             read GetChannelControlLimitLowerColor     write SetChannelControlLimitLowerColor;
    property   ChannelControlLimitLowerLineStyle[Index : Integer] : TiChannelLineStyle read GetChannelControlLimitLowerLineStyle write SetChannelControlLimitLowerLineStyle;
    property   ChannelControlLimitLowerLineWidth[Index : Integer] : Integer            read GetChannelControlLimitLowerLineWidth write SetChannelControlLimitLowerLineWidth;

    property   ChannelWarningLimitUpperShow     [Index : Integer] : Boolean            read GetChannelWarningLimitUpperShow      write SetChannelWarningLimitUpperShow;
    property   ChannelWarningLimitUpperValue    [Index : Integer] : Double             read GetChannelWarningLimitUpperValue     write SetChannelWarningLimitUpperValue;
    property   ChannelWarningLimitUpperColor    [Index : Integer] : TColor             read GetChannelWarningLimitUpperColor     write SetChannelWarningLimitUpperColor;
    property   ChannelWarningLimitUpperLineStyle[Index : Integer] : TiChannelLineStyle read GetChannelWarningLimitUpperLineStyle write SetChannelWarningLimitUpperLineStyle;
    property   ChannelWarningLimitUpperLineWidth[Index : Integer] : Integer            read GetChannelWarningLimitUpperLineWidth write SetChannelWarningLimitUpperLineWidth;

    property   ChannelWarningLimitLowerShow     [Index : Integer] : Boolean            read GetChannelWarningLimitLowerShow      write SetChannelWarningLimitLowerShow;
    property   ChannelWarningLimitLowerValue    [Index : Integer] : Double             read GetChannelWarningLimitLowerValue     write SetChannelWarningLimitLowerValue;
    property   ChannelWarningLimitLowerColor    [Index : Integer] : TColor             read GetChannelWarningLimitLowerColor     write SetChannelWarningLimitLowerColor;
    property   ChannelWarningLimitLowerLineStyle[Index : Integer] : TiChannelLineStyle read GetChannelWarningLimitLowerLineStyle write SetChannelWarningLimitLowerLineStyle;
    property   ChannelWarningLimitLowerLineWidth[Index : Integer] : Integer            read GetChannelWarningLimitLowerLineWidth write SetChannelWarningLimitLowerLineWidth;

    procedure   SetChannelsData(Index: Integer; Data : Variant);
    procedure   AddData(Interval : Double; Data : Variant);
    procedure   SetChannelDataNull  (Channel, Index: Integer);
    function    GetChannelDataIsNull(Channel, Index: Integer; var Data: Double) : Boolean;
    function    GetChannelDataStatus(Channel, Index: Integer) : TiChannelDataSatus;

    procedure   AddVerticalLine(Position: Double; Color: TColor; Width : Integer; Style : TiChannelLineStyle);
    procedure   RemoveAllVerticalLines;

    function    GetNextChannelColor: TColor;
    function    GetNow: Double;

    function    AddIndexTime(Time: Double) : Integer;
    function    AddIndexTimeNow            : Integer;
    function    AddIndexTimeElapsedNow     : Integer;

    property    IndexTime[Index : Integer]: Double   read GetIndexTime;
    property    IndexCount                : Integer  read GetIndexCount;

    property    MinXAxisData              : Double   read FMinXAxisData;
    property    MaxXAxisData              : Double   read FMaxXAxisData;
    property    MinYAxisData              : Double   read FMinYAxisData;
    property    MaxYAxisData              : Double   read FMaxYAxisData;

    property    DisplayStartIndex         : Integer  read FPlotStartIndex;
    property    DisplayStopIndex          : Integer  read FPlotStopIndex;

    //Kylix TODO
    {$ifndef iCLX}
    property    SnapShotPicture           : TPicture read GetSnapShotPicture;
    procedure   CopyToClipBoard;
    {$endif}

    //Kylix TODO
    {$ifndef iCLX}
    procedure   SaveToMetaFile   (FileName: String);
    procedure   SaveToBitmap     (FileName: String);
    {$endif}
    
    procedure   SaveToXMLFile    (FileName: String);
    procedure   LoadFromXMLFile  (FileName: String);

    procedure   ClearAllXMLComments;
    procedure   AddXMLComment(ElementName, ElementValue : String);

    procedure   ResetElapsedStartTime;

    //Kylix TODO
    {$ifndef iCLX}
    procedure   PrintChart;
    {$endif}
    procedure   PrinterClearCommentLines;
    procedure   PrinterAddCommentLine(Value: String);

    procedure   ScrollXAxis   (Value: Double);
    procedure   ScrollYAxis   (Value: Double);
    procedure   SetXAxisMinMax(Min, Max: Double);
    procedure   SetYAxisMinMax(Min, Max: Double);
    procedure   ZoomXAxis     (Value: Double);
    procedure   ZoomYAxis     (Value: Double);
  published
    property AxisGridColor                 : TColor                 read FAxisGridColor                write SetAxisGridColor                default clGreen;
    property TitleText                     : String                 read FTitleText                    write SetTitleText;
    property TitleMargin                   : Integer                read FTitleMargin                  write SetTitleMargin                  default 0;
    property TitleFont                     : TFont                  read FTitleFont                    write SetTitleFont;

    property XAxisShow                     : Boolean                read FXAxisShow                    write SetXAxisShow                    default True;
    property XAxisMin                      : Double                 read FXAxisMin                     write SetXAxisMin;
    property XAxisMax                      : Double                 read FXAxisMax                     write SetXAxisMax;
    property XAxisDateTimeEnabled          : Boolean                read FXAxisDateTimeEnabled         write SetXAxisDateTimeEnabled         default False;
    property XAxisDateTimeFormatString     : String                 read FXAxisDateTimeFormatString    write SetXAxisDateTimeFormatString;
    property XAxisMargin                   : Integer                read FXAxisMargin                  write SetXAxisMargin                  default 5;
    property XAxisLabelMargin              : Integer                read FXAxisLabelMargin             write SetXAxisLabelMargin             default 5;
    property XAxisLabelFont                : TFont                  read FXAxisLabelFont               write SetXAxisLabelFont;
    property XAxisLabelPrecision           : Integer                read FXAxisLabelPrecision          write SetXAxisLabelPrecision          default 2;
    property XAxisTitle                    : String                 read FXAxisTitle                   write SetXAxisTitle;
    property XAxisTitleMargin              : Integer                read FXAxisTitleMargin             write SetXAxisTitleMargin             default 0;
    property XAxisTitleFont                : TFont                  read FXAxisTitleFont               write SetXAxisTitleFont;
    property XAxisTickMajorCount           : Integer                read FXAxisTickMajorCount          write SetXAxisTickMajorCount          default 11;
    property XAxisTickMajorLength          : Integer                read FXAxisTickMajorLength         write SetXAxisTickMajorLength         default 7;
    property XAxisTickMajorColor           : TColor                 read FXAxisTickMajorColor          write SetXAxisTickMajorColor          default clWhite;
    property XAxisTickMinorCount           : Integer                read FXAxisTickMinorCount          write SetXAxisTickMinorCount          default 4;
    property XAxisTickMinorLength          : Integer                read FXAxisTickMinorLength         write SetXAxisTickMinorLength         default 3;
    property XAxisTickMinorColor           : TColor                 read FXAxisTickMinorColor          write SetXAxisTickMinorColor          default clWhite;

    property YAxisShow                     : Boolean                read FYAxisShow                    write SetYAxisShow                    default True;
    property YAxisMin                      : Double                 read FYAxisMin                     write SetYAxisMin;
    property YAxisMax                      : Double                 read FYAxisMax                     write SetYAxisMax;
    property YAxisMargin                   : Integer                read FYAxisMargin                  write SetYAxisMargin                  default 5;
    property YAxisLabelMargin              : Integer                read FYAxisLabelMargin             write SetYAxisLabelMargin             default 5;
    property YAxisLabelFont                : TFont                  read FYAxisLabelFont               write SetYAxisLabelFont;
    property YAxisLabelPrecision           : Integer                read FYAxisLabelPrecision          write SetYAxisLabelPrecision          default 3;
    property YAxisTitle                    : String                 read FYAxisTitle                   write SetYAxisTitle;
    property YAxisTitleMargin              : Integer                read FYAxisTitleMargin             write SetYAxisTitleMargin             default 0;
    property YAxisTitleFont                : TFont                  read FYAxisTitleFont               write SetYAxisTitleFont;
    property YAxisTickMajorCount           : Integer                read FYAxisTickMajorCount          write SetYAxisTickMajorCount          default 6;
    property YAxisTickMajorLength          : Integer                read FYAxisTickMajorLength         write SetYAxisTickMajorLength         default 7;
    property YAxisTickMajorColor           : TColor                 read FYAxisTickMajorColor          write SetYAxisTickMajorColor          default clWhite;
    property YAxisTickMinorCount           : Integer                read FYAxisTickMinorCount          write SetYAxisTickMinorCount          default 4;
    property YAxisTickMinorLength          : Integer                read FYAxisTickMinorLength         write SetYAxisTickMinorLength         default 3;
    property YAxisTickMinorColor           : TColor                 read FYAxisTickMinorColor          write SetYAxisTickMinorColor          default clWhite;
    property YAxisLabelWidth               : Integer                read FYAxisLabelWidth              write SetYAxisLabelWidth              default 20;
    property YAxisLabelWidthFixed          : Boolean                read FYAxisLabelWidthFixed         write SetYAxisLabelWidthFixed         default False;
    property YAxisReverseScale             : Boolean                read FYAxisReverseScale            write SetYAxisReverseScale            default False;

    property GridLineStyle                 : TiChannelLineStyle     read FGridLineStyle                write SetGridLineStyle                default iclsSolid;
    property GridBackGroundColor           : TColor                 read FGridBackGroundColor          write SetGridBackGroundColor          default clBlack;

    property OuterMarginLeft               : Integer                read FOuterMarginLeft              write SetOuterMarginLeft              default 10;
    property OuterMarginTop                : Integer                read FOuterMarginTop               write SetOuterMarginTop               default 10;
    property OuterMarginRight              : Integer                read FOuterMarginRight             write SetOuterMarginRight             default 10;
    property OuterMarginBottom             : Integer                read FOuterMarginBottom            write SetOuterMarginBottom            default 10;

    property LegendWidth                   : Integer                read FLegendWidth                  write SetLegendWidth                  default 80;
    property LegendMargin                  : Integer                read FLegendMargin                 write SetLegendMargin                 default 10;
    property LegendFont                    : TFont                  read FLegendFont                   write SetLegendFont;

    property ShowGrid                      : Boolean                read FShowGrid                     write SetShowGrid                     default True;
    property ShowLegend                    : Boolean                read FShowLegend                   write SetShowLegend                   default True;
    property ShowToolBar                   : Boolean                read FShowToolBar                  write SetShowToolBar                  default True;

    property AutoScrollEnabled             : Boolean                read FAutoScrollEnabled            write SetAutoScrollEnabled            default True;
    property AutoScrollType                : TiAutoScroll           read FAutoScrollType               write SetAutoScrollType               default iasSmooth;
    property AutoScrollStepSize            : Double                 read FAutoScrollStepSize           write SetAutoScrollStepSize;
    property AutoScrollFirstStyle          : TiAutoScrollFirstStyle read FAutoScrollFirstStyle         write FAutoScrollFirstStyle           default iasfsAuto;

    property AutoScaleEnabled              : Boolean                read FAutoScaleEnabled             write SetAutoScaleEnabled             default True;
    property AutoScaleHysterisis           : Double                 read FAutoScaleHysterisis          write SetAutoScaleHysterisis;
    property AutoScaleMinAdjustEnabled     : Boolean                read FAutoScaleMinAdjustEnabled    write SetAutoScaleMinAdjustEnabled    default True;
    property AutoScaleMaxAdjustEnabled     : Boolean                read FAutoScaleMaxAdjustEnabled    write SetAutoScaleMaxAdjustEnabled    default True;

    property ToolBarActiveModeFont         : TFont                  read FToolBarActiveModeFont        write SetToolBarActiveModeFont;
    property ToolBarInactiveModeFont       : TFont                  read FToolBarInactiveModeFont      write SetToolBarInactiveModeFont;
    property ToolBarMode                   : TiStripChartMode       read FToolBarMode                  write SetToolBarMode                  default iscmPlot;

    property CursorChannel                 : Integer                read FCursorChannel                write SetCursorChannel                default 0;
    property CursorColor                   : TColor                 read FCursorColor                  write SetCursorColor                  default clYellow;
    property CursorChannelBackGroundColor  : TColor                 read FCursorChannelBackGroundColor write SetCursorChannelBackGroundColor default clYellow;
    property CursorChannelFontColor        : TColor                 read FCursorChannelFontColor       write SetCursorChannelFontColor       default clBlack;
    property CursorHideAllOtherChannels    : Boolean                read FCursorHideAllOtherChannels   write SetCursorHideAllOtherChannels   default False;

    property OnModeChange                  : TNotifyEvent           read FOnModeChange                 write FOnModeChange;
    property OnDataUpdate                  : TNotifyEvent           read FOnDataUpdate                 write FOnDataUpdate;
    property OnCursorChange                : TNotifyEvent           read FOnCursorChange               write FOnCursorChange;
    property OnCursorIndexChange           : TNotifyEvent           read FOnCursorIndexChange          write FOnCursorIndexChange;
    property OnXAxisMaxChange              : TNotifyEvent           read FOnXAxisMaxChange             write FOnXAxisMaxChange;
    property OnXAxisMinChange              : TNotifyEvent           read FOnXAxisMinChange             write FOnXAxisMinChange;
    property OnYAxisMaxChange              : TNotifyEvent           read FOnYAxisMaxChange             write FOnYAxisMaxChange;
    property OnYAxisMinChange              : TNotifyEvent           read FOnYAxisMinChange             write FOnYAxisMinChange;

    //Kylix TODO
    {$ifndef iCLX}
    property PrinterOrientation            : TPrinterOrientation    read FPrinterOrientation           write FPrinterOrientation             default poPortrait;
    {$endif}
    property PrinterMarginLeft             : Double                 read FPrinterMarginLeft            write FPrinterMarginLeft;
    property PrinterMarginTop              : Double                 read FPrinterMarginTop             write FPrinterMarginTop;
    property PrinterMarginRight            : Double                 read FPrinterMarginRight           write FPrinterMarginRight;
    property PrinterMarginBottom           : Double                 read FPrinterMarginBottom          write FPrinterMarginBottom;
    property PrinterShowDialog             : Boolean                read FPrinterShowDialog            write FPrinterShowDialog              default True;

    property MaxBufferSize                 : Integer                read FMaxBufferSize                write SetMaxBufferSize                default 0;
    property MinBufferSize                 : Integer                read FMinBufferSize                write SetMinBufferSize                default 0;

    property RestoreXYAxisOnPlotMode       : Boolean                read FRestoreXYAxisOnPlotMode      write FRestoreXYAxisOnPlotMode        default True;
    property EnableDataDrawMinMax          : Boolean                read FEnableDataDrawMinMax         write SetEnableDataDrawMinMax         default True;
    property DiscontinuousDataEnabled      : Boolean                read FDiscontinuousDataEnabled     write SetDiscontinuousDataEnabled     default False;
    property PrecisionStyle                : TiPrecisionStyle       read FPrecisionStyle               write SetPrecisionStyle               default ipsSignificantDigits;
    property InterpolateMissingDataPoints  : Boolean                read FInterpolateMissingDataPoints write SetInterpolateMissingDataPoints default True;

    property PrinterCommentLinesFont       : TFont                  read FPrinterCommentLinesFont      write SetPrinterCommentLinesFont;
    property PrinterCommentLineSpacing     : Double                 read FPrinterCommentLineSpacing    write FPrinterCommentLineSpacing;

    property AddYChannel1Now               : Double                 read GetAddYChannel1Now            write SetAddYChannel1Now              stored False;

    property BorderStyle      default ibsLowered;
    property BackGroundColor  default clBlack;
    property Align;
    property Width            default 500;
    property Height           default 250;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiStripChart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width            := 500;
  Height           := 250;
  BackGroundColor  := clBlack;
  BorderStyle      := ibsLowered;

  FXAxisShow                    := True;
  FXAxisMin                     := 0;
  FXAxisMax                     := 10;
  FXAxisMargin                  := 5;
  FXAxisDateTimeFormatString    := 'hh:nn:ssam/pm';
  FXAxisLabelMargin             := 5;
  FXAxisLabelPrecision          := 1;
  FXAxisTickMajorCount          := 11;
  FXAxisTickMajorLength         := 7;
  FXAxisTickMajorColor          := clWhite;
  FXAxisTickMinorCount          := 4;
  FXAxisTickMinorLength         := 3;
  FXAxisTickMinorColor          := clWhite;

  FYAxisShow                    := True;
  FYAxisMin                     := 0;
  FYAxisMax                     := 100;
  FYAxisMargin                  := 5;
  FYAxisLabelMargin             := 5;
  FYAxisLabelPrecision          := 1;
  FYAxisTickMajorCount          := 6;
  FYAxisTickMajorLength         := 7;
  FYAxisTickMajorColor          := clWhite;
  FYAxisTickMinorCount          := 4;
  FYAxisTickMinorLength         := 3;
  FYAxisTickMinorColor          := clWhite;
  FYAxisLabelWidth              := 20;

  FOuterMarginLeft              := 10;
  FOuterMarginTop               := 10;
  FOuterMarginRight             := 10;
  FOuterMarginBottom            := 10;

  FShowGrid                     := True;
  FShowLegend                   := True;
  FShowToolBar                  := False;

  FAutoScrollEnabled            := True;
  FAutoScaleEnabled             := True;

  FAutoScaleMinAdjustEnabled    := True;
  FAutoScaleMaxAdjustEnabled    := True;

  FLegendWidth                  := 80;
  FLegendMargin                 := 10;

  FCursorColor                  := clYellow;
  FCursorChannelBackGroundColor := clYellow;

  FAxisGridColor                := clGreen;

  FPlotStartIndex               := -1;
  FPlotStopIndex                := -1;
  FCursorChannel                := -1;
  FFirstDataPoint               := True;

  FPrinterMarginLeft            := 0.5;
  FPrinterMarginTop             := 0.5;
  FPrinterMarginRight           := 0.5;
  FPrinterMarginBottom          := 0.5;

  FRestoreXYAxisOnPlotMode      := True;
  FInterpolateMissingDataPoints := True;
  FPrinterShowDialog            := True;

  FTitleFont      := TFont.Create; FTitleFont.OnChange      := BackGroundChangeEvent; FTitleFont.Color      := clWhite;
  FLegendFont     := TFont.Create; FLegendFont.OnChange     := BackGroundChangeEvent; FLegendFont.Color     := clWhite;

  FXAxisLabelFont := TFont.Create; FXAxisLabelFont.OnChange := BackGroundChangeEvent; FXAxisLabelFont.Color := clWhite;
  FXAxisTitleFont := TFont.Create; FXAxisTitleFont.OnChange := BackGroundChangeEvent; FXAxisTitleFont.Color := clWhite; FXAxisTitleFont.Name := 'Arial';

  FYAxisLabelFont := TFont.Create; FYAxisLabelFont.OnChange := BackGroundChangeEvent; FYAxisLabelFont.Color := clWhite;
  FYAxisTitleFont := TFont.Create; FYAxisTitleFont.OnChange := BackGroundChangeEvent; FYAxisTitleFont.Color := clWhite; FYAxisTitleFont.Name := 'Arial';

  FToolBarActiveModeFont            := TFont.Create; FToolBarActiveModeFont.OnChange   := BackGroundChangeEvent;
  FToolBarActiveModeFont.Color      := clYellow;
  FToolBarActiveModeFont.Style      := [fsBold];

  FToolBarInactiveModeFont          := TFont.Create; FToolBarInactiveModeFont.OnChange := BackGroundChangeEvent;
  FToolBarInactiveModeFont.Color    := clAqua;
  FToolBarInactiveModeFont.Style    := [fsBold];

  FPrinterCommentLinesFont          := TFont.Create;

  FChannelList        := TStringList.Create;
  FLabelChannelList   := TStringList.Create;
  FVerticalLineList   := TStringList.Create;
  FIndexList          := TiDoubleList.Create;
  FPrinterCommentList := TStringList.Create;
  FXMLCommentList     := TStringList.Create;

  AddChannel('Untitled', clRed, iclsSolid, 1);

  FEnableDataDrawMinMax := True;
  FShowToolBar          := True;
  FXAxisLabelPrecision  := 2;
  FYAxisLabelPrecision  := 3;

  FElapsedStartTime := Now;
end;
//****************************************************************************************************************************************************
destructor TiStripChart.Destroy;
begin
  FTitleFont.Free;
  FLegendFont.Free;

  FXAxisLabelFont.Free;
  FXAxisTitleFont.Free;

  FYAxisLabelFont.Free;
  FYAxisTitleFont.Free;

  FToolBarActiveModeFont.Free;
  FToolBarInactiveModeFont.Free;

  FPrinterCommentLinesFont.Free;

  //Kylix TODO
  {$ifndef iCLX}
  if Assigned(FMetaFile)        then FMetaFile.Free;
  {$endif}
  if Assigned(FSnapShotPicture) then FSnapShotPicture.Free;

  RemoveAllChannels;
  RemoveAllLabelChannels;
  RemoveAllVerticalLines;

  FChannelList.Free;
  FLabelChannelList.Free;
  FVerticalLineList.Free;

  FIndexList.Free;
  FPrinterCommentList.Free;
  FXMLCommentList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetTitleText                   (const Value:String );begin SetStringProperty (Value,FTitleText,                   irtBackGround);end;
procedure TiStripChart.SetTitleMargin                 (const Value:Integer);begin SetIntegerProperty(Value,FTitleMargin,                 irtBackGround);end;
procedure TiStripChart.SetAxisGridColor               (const Value:TColor );begin SetColorProperty  (Value,FAxisGridColor,               irtBackGround);end;
procedure TiStripChart.SetXAxisShow                   (const Value:Boolean);begin SetBooleanProperty(Value,FXAxisShow,                   irtBackGround);end;
procedure TiStripChart.SetXAxisTickMinorCount         (const Value:Integer);begin SetIntegerProperty(Value,FXAxisTickMinorCount,         irtBackGround);end;
procedure TiStripChart.SetYAxisTickMinorCount         (const Value:Integer);begin SetIntegerProperty(Value,FYAxisTickMinorCount,         irtBackGround);end;
procedure TiStripChart.SetXAxisLabelMargin            (const Value:Integer);begin SetIntegerProperty(Value,FXAxisLabelMargin,            irtBackGround);end;
procedure TiStripChart.SetXAxisMargin                 (const Value:Integer);begin SetIntegerProperty(Value,FXAxisMargin,                 irtBackGround);end;
procedure TiStripChart.SetYAxisLabelMargin            (const Value:Integer);begin SetIntegerProperty(Value,FYAxisLabelMargin,            irtBackGround);end;
procedure TiStripChart.SetYAxisMargin                 (const Value:Integer);begin SetIntegerProperty(Value,FYAxisMargin,                 irtBackGround);end;
procedure TiStripChart.SetXAxisTickMajorLength        (const Value:Integer);begin SetIntegerProperty(Value,FXAxisTickMajorLength,        irtBackGround);end;
procedure TiStripChart.SetXAxisTickMinorLength        (const Value:Integer);begin SetIntegerProperty(Value,FXAxisTickMinorLength,        irtBackGround);end;
procedure TiStripChart.SetYAxisTickMajorLength        (const Value:Integer);begin SetIntegerProperty(Value,FYAxisTickMajorLength,        irtBackGround);end;
procedure TiStripChart.SetYAxisTickMinorLength        (const Value:Integer);begin SetIntegerProperty(Value,FYAxisTickMinorLength,        irtBackGround);end;
procedure TiStripChart.SetXAxisLabelPrecision         (const Value:Integer);begin SetIntegerProperty(Value,FXAxisLabelPrecision,         irtBackGround);end;
procedure TiStripChart.SetYAxisLabelPrecision         (const Value:Integer);begin SetIntegerProperty(Value,FYAxisLabelPrecision,         irtBackGround);end;
procedure TiStripChart.SetYAxisLabelWidth             (const Value:Integer);begin SetIntegerProperty(Value,FYAxisLabelWidth,             irtBackGround);end;
procedure TiStripChart.SetYAxisLabelWidthFixed        (const Value:Boolean);begin SetBooleanProperty(Value,FYAxisLabelWidthFixed,        irtBackGround);end;
procedure TiStripChart.SetYAxisReverseScale           (const Value:Boolean);begin SetBooleanProperty(Value,FYAxisReverseScale,           irtBackGround);end;
procedure TiStripChart.SetOuterMarginBottom           (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginBottom,           irtBackGround);end;
procedure TiStripChart.SetOuterMarginLeft             (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginLeft,             irtBackGround);end;
procedure TiStripChart.SetOuterMarginRight            (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginRight,            irtBackGround);end;
procedure TiStripChart.SetOuterMarginTop              (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginTop,              irtBackGround);end;
procedure TiStripChart.SetYAxisShow                   (const Value:Boolean);begin SetBooleanProperty(Value,FYAxisShow,                   irtBackGround);end;
procedure TiStripChart.SetXAxisTickMajorColor         (const Value:TColor );begin SetColorProperty  (Value,FXAxisTickMajorColor,         irtBackGround);end;
procedure TiStripChart.SetXAxisTickMinorColor         (const Value:TColor );begin SetColorProperty  (Value,FXAxisTickMinorColor,         irtBackGround);end;
procedure TiStripChart.SetYAxisTickMajorColor         (const Value:TColor );begin SetColorProperty  (Value,FYAxisTickMajorColor,         irtBackGround);end;
procedure TiStripChart.SetYAxisTickMinorColor         (const Value:TColor );begin SetColorProperty  (Value,FYAxisTickMinorColor,         irtBackGround);end;
procedure TiStripChart.SetGridBackGroundColor         (const Value:TColor );begin SetColorProperty  (Value,FGridBackGroundColor,         irtBackGround);end;
procedure TiStripChart.SetShowGrid                    (const Value:Boolean);begin SetBooleanProperty(Value,FShowGrid,                    irtBackGround);end;
procedure TiStripChart.SetShowLegend                  (const Value:Boolean);begin SetBooleanProperty(Value,FShowLegend,                  irtBackGround);end;
procedure TiStripChart.SetLegendWidth                 (const Value:Integer);begin SetIntegerProperty(Value,FLegendWidth,                 irtBackGround);end;
procedure TiStripChart.SetLegendMargin                (const Value:Integer);begin SetIntegerProperty(Value,FLegendMargin,                irtBackGround);end;
procedure TiStripChart.SetCursorChannelBackGroundColor(const Value:TColor );begin SetColorProperty  (Value,FCursorChannelBackGroundColor,irtBackGround);end;
procedure TiStripChart.SetXAxisTitle                  (const Value:String );begin SetStringProperty (Value,FXAxisTitle,                  irtBackGround);end;
procedure TiStripChart.SetXAxisTitleMargin            (const Value:Integer);begin SetIntegerProperty(Value,FXAxisTitleMargin,            irtBackGround);end;
procedure TiStripChart.SetYAxisTitle                  (const Value:String );begin SetStringProperty (Value,FYAxisTitle,                  irtBackGround);end;
procedure TiStripChart.SetYAxisTitleMargin            (const Value:Integer);begin SetIntegerProperty(Value,FYAxisTitleMargin,            irtBackGround);end;
procedure TiStripChart.SetAutoScrollEnabled           (const Value:Boolean);begin SetBooleanProperty(Value,FAutoScrollEnabled,           irtBackGround);end;
procedure TiStripChart.SetAutoScrollStepSize          (const Value:Double );begin SetDoubleProperty (Value,FAutoScrollStepSize,          irtBackGround);end;
procedure TiStripChart.SetAutoScaleEnabled            (const Value:Boolean);begin SetBooleanProperty(Value,FAutoScaleEnabled,            irtBackGround);end;
procedure TiStripChart.SetAutoScaleHysterisis         (const Value:Double );begin SetDoubleProperty (Value,FAutoScaleHysterisis,         irtBackGround);end;
procedure TiStripChart.SetAutoScaleMaxAdjustEnabled   (const Value:Boolean);begin SetBooleanProperty(Value,FAutoScaleMaxAdjustEnabled,   irtBackGround);end;
procedure TiStripChart.SetAutoScaleMinAdjustEnabled   (const Value:Boolean);begin SetBooleanProperty(Value,FAutoScaleMinAdjustEnabled,   irtBackGround);end;
procedure TiStripChart.SetCursorColor                 (const Value:TColor );begin SetColorProperty  (Value,FCursorColor,                 irtBackGround);end;
procedure TiStripChart.SetCursorChannelFontColor      (const Value:TColor );begin SetColorProperty  (Value,FCursorChannelFontColor,      irtBackGround);end;
procedure TiStripChart.SetCursorHideAllOtherChannels  (const Value:Boolean);begin SetBooleanProperty(Value,FCursorHideAllOtherChannels,  irtBackGround);end;
procedure TiStripChart.SetInterpolateMissingDataPoints(const Value:Boolean);begin SetBooleanProperty(Value,FInterpolateMissingDataPoints,irtBackGround);end;
procedure TiStripChart.SetEnableDataDrawMinMax        (const Value:Boolean);begin SetBooleanProperty(Value,FEnableDataDrawMinMax,        irtBackGround);end;
procedure TiStripChart.SetXAxisDateTimeEnabled        (const Value:Boolean);begin SetBooleanProperty(Value,FXAxisDateTimeEnabled,        irtBackGround);end;
procedure TiStripChart.SetShowToolBar                 (const Value:Boolean);begin SetBooleanProperty(Value,FShowToolBar,                 irtBackGround);end;
procedure TiStripChart.SetXAxisDateTimeFormatString   (const Value:String );begin SetStringProperty (Value,FXAxisDateTimeFormatString,   irtBackGround);end;
procedure TiStripChart.SetLimitLinesOnTop             (const Value:Boolean);begin SetBooleanProperty(Value,FLimitLinesOnTop,             irtInvalidate);end;
procedure TiStripChart.SetGridLinesOnTop              (const Value:Boolean);begin SetBooleanProperty(Value,FGridLinesOnTop,              irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetTitleFont              (const Value: TFont);begin FTitleFont.Assign(Value);              BackGroundChange;end;
procedure TiStripChart.SetXAXisLabelFont         (const Value: TFont);begin FXAxisLabelFont.Assign(Value);         BackGroundChange;end;
procedure TiStripChart.SetYAXisLabelFont         (const Value: TFont);begin FYAxisLabelFont.Assign(Value);         BackGroundChange;end;
procedure TiStripChart.SetLegendFont             (const Value: TFont);begin FLegendFont.Assign(Value);             BackGroundChange;end;
procedure TiStripChart.SetXAxisTitleFont         (const Value: TFont);begin FXAxisTitleFont.Assign(Value);         BackGroundChange;end;
procedure TiStripChart.SetYAxisTitleFont         (const Value: TFont);begin FYAxisTitleFont.Assign(Value);         BackGroundChange;end;
procedure TiStripChart.SetToolBarActiveModeFont  (const Value: TFont);begin FToolBarActiveModeFont.Assign(Value);  BackGroundChange;end;
procedure TiStripChart.SetToolBarInactiveModeFont(const Value: TFont);begin FToolBarInactiveModeFont.Assign(Value);BackGroundChange;end;
//****************************************************************************************************************************************************
procedure TiStripChart.EndUpdate;
begin
  inherited;
  CalcNewStartXIndex;
  CalcNewStopXIndex;
  
  if FNeedsDataUpdate then
    begin
      FNeedsDataUpdate := False;
      DoDataUpdate;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetAutoScrollType(const Value: TiAutoScroll);
begin
  if FAutoScrollType  <> Value then
    begin
      FAutoScrollType := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetPrecisionStyle(const Value: TiPrecisionStyle);
begin
  if FPrecisionStyle <>Value then
    begin
      FPrecisionStyle := Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetGridLineStyle(const Value: TiChannelLineStyle);
begin
  if FGridLineStyle <> Value then
    begin
      FGridLineStyle :=Value;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetXAxisMax(const Value: Double);
begin
  if FXAXisMax <> Value then
    begin
      FXAxisMax :=Value;
      CalcNewStopXIndex;
      InvalidateChange;
      if Assigned(FOnXAxisMaxChange) then FOnXAxisMaxChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetXAxisMin(const Value: Double);
begin
  if FXAxisMin <> Value then
    begin
      FXAxisMin := Value;
      CalcNewStartXIndex;
      InvalidateChange;
      if Assigned(FOnXAxisMinChange) then FOnXAxisMinChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetYAxisMax(const Value:Double);
begin
  if FYAxisMax <> Value then
    begin
      FYAxisMax :=Value;
      BackGroundChange;
      if Assigned(FOnYAxisMaxChange) then FOnYAxisMaxChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetYAxisMin(const Value: Double);
begin
  if FYAxisMin <> Value then
    begin
      FYAxisMin :=Value;
      BackGroundChange;
      if Assigned(FOnYAxisMinChange) then FOnYAxisMinChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetXAxisTickMajorCount(const Value: Integer);
begin
  if FXAxisTickMajorCount <> Value then
    begin
      FXAxisTickMajorCount := Value;
      if FXAxisTickMajorCount < 2 then FXAxisTickMajorCount := 2;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetYAxisTickMajorCount(const Value: Integer);
begin
  if FYAxisTickMajorCount <> Value then
    begin
      FYAxisTickMajorCount := Value;
      if FYAxisTickMajorCount < 2 then FYAxisTickMajorCount := 2;
      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetMaxBufferSize(const Value: Integer);
begin
  if Value < 0 then exit;
  if FMaxBufferSize <> Value then
    begin
      FMaxBufferSize := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetMinBufferSize(const Value: Integer);
begin
  if Value < 0 then exit;
  if FMinBufferSize <> Value then
    begin
      FMinBufferSize := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetDiscontinuousDataEnabled(const Value: Boolean);
var
  Channel           : Integer;
  TempChannelList   : TStringList;
  ChannelObject     : TiStripChartChannelObject;
  TempChannelObject : TiStripChartChannelObject;
begin
  if FDiscontinuousDataEnabled <> Value then
    begin
      FDiscontinuousDataEnabled := Value;
      ClearData;
      TempChannelList := TStringList.Create;
      for Channel := 0 to FChannelList.Count - 1 do
        begin
          ChannelObject := GetChannel(Channel);

          if FDiscontinuousDataEnabled then TempChannelObject := TiStripChartDiscontinuousDataChannelObject.Create
            else                            TempChannelObject := TiStripChartContinuousDataChannelObject.Create;

          TempChannelObject.Color     := ChannelObject.Color;
          TempChannelObject.Title     := ChannelObject.Title;
          TempChannelObject.LineStyle := ChannelObject.LineStyle;
          TempChannelObject.LineWidth := ChannelObject.LineWidth;

          TempChannelList.AddObject('', TempChannelObject);
        end;
      RemoveAllChannels;
      FChannelList.Free;
      FChannelList := TempChannelList;

      BackGroundChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetToolBarMode(const Value: TiStripChartMode);
begin
  if FToolBarMode <> Value then
    begin
      if (FToolBarMode = iscmPlot)  then
        begin
          FOriginalXMax := FXAxisMax;
          FOriginalXMin := FXAxisMin;
          FOriginalYMax := FYAxisMax;
          FOriginalYMin := FYAxisMin;
        end;
      if (Value = iscmPlot) and FRestoreXYAxisOnPlotMode then
        begin
          SetXAxisMinMax(FOriginalXMin, FOriginalXMax);
          SetYAxisMinMax(FOriginalYMin, FOriginalYMax);
        end;

      FToolBarMode := Value;
      if FToolBarMode = iscmCursor then
        begin
           CalcCursorIndex((FGridLeft + FGridRight)div 2);
           if Assigned(FOnCursorIndexChange) then FOnCursorIndexChange(Self);
        end;
      BackGroundChange;
      DoModeChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetCursorChannel(const Value: Integer);
begin
  if FCursorChannel <> Value then
    begin
      FCursorChannel := Value;
      if FCursorChannel > (FChannelList.Count -1) then FCursorChannel := FChannelList.Count -1;
      BackGroundChange;
      DoCursorChange;
      if FToolBarMode = iscmCursor then  if Assigned(FOnCursorIndexChange) then FOnCursorIndexChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetCursorIndex(const Value: Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue < 0 then TempValue := 0;
  if TempValue > (FIndexList.Count -1) then TempValue := (FIndexList.Count -1);

  if FCursorIndex <> TempValue then
    begin
      FCursorIndex := TempValue;
      ScrollCursorInView;
      BackGroundChange;
      DoCursorChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.CalcCursorIndex(X: Integer);
var
  CursorValue : Double;
  MaxValue    : Double;
begin
  if (FGridRight <> FGridLeft) then
    begin
      CursorValue := (X - FGridLeft)/(FGridRight - FGridLeft) * (FXAxisMax - FXAxisMin) + FXAxisMin;

      FCursorIndex := CalcIndex(CursorValue);

      if FIndexList.Count <> 0 then
        begin
          if (FPlotStartIndex = - 1) or (FPlotStopIndex = - 1) then
            begin
              if FCursorIndex = 0 then SetXAxisMinMax(-(FXAxisMax - FXAxisMin)/2,(FXAxisMax - FXAxisMin)/2)
                else
                  begin
                    MaxValue := FIndexList.Item[FIndexList.Count-1];
                    SetXAxisMinMax(MaxValue-(FXAxisMax - FXAxisMin)/2,MaxValue+(FXAxisMax - FXAxisMin)/2);
                  end;
            end
          else
            begin
              if FCursorIndex < FPlotStartIndex then ScrollXAxis(FIndexList.Item[FCursorIndex] - FXAxisMin);
              if FCursorIndex > FPlotStopIndex  then ScrollXAxis(FIndexList.Item[FCursorIndex] - FXAxisMax);

              if (FCursorIndex = FPlotStartIndex) and (FIndexList.Item[0]                  = FXAxisMin) then ScrollXAxis(-(FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));
              if (FCursorIndex = FPlotStopIndex ) and (FIndexList.Item[FIndexList.Count-1] = FXAxisMax) then ScrollXAxis((FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));
            end;
        end;
      BackGroundChange;
      DoCursorChange;
    end;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetToolBarButtonIndex(X, Y: Integer): Integer;
begin
  if      (X>=FPlotTextStart    ) and (X<=FPlotTextStop    ) and (Y <= FToolBarVCenter) then Result :=  ord(iscmPlot)
  else if (X>=FScrollXTextStart ) and (X<=FScrollXTextStop ) and (Y <= FToolBarVCenter) then Result :=  ord(iscmScrollX)
  else if (X>=FScrollYTextStart ) and (X<=FScrollYTextStop ) and (Y <= FToolBarVCenter) then Result :=  ord(iscmScrollY)
  else if (X>=FScrollXYTextStart) and (X<=FScrollXYTextStop) and (Y <= FToolBarVCenter) then Result :=  ord(iscmScrollXY)
  else if (X>=FCursorTextStart  ) and (X<=FCursorTextStop  ) and (Y <= FToolBarVCenter) then Result :=  ord(iscmCursor)
  else if (X>=FZoomXTextStart   ) and (X<=FZoomXTextStop   ) and (Y >= FToolBarVCenter) then Result :=  ord(iscmZoomX)
  else if (X>=FZoomYTextStart   ) and (X<=FZoomYTextStop   ) and (Y >= FToolBarVCenter) then Result :=  ord(iscmZoomY)
  else if (X>=FZoomXYTextStart  ) and (X<=FZoomXYTextStop  ) and (Y >= FToolBarVCenter) then Result :=  ord(iscmZoomXY)
  else if (X>=FZoomBoxTextStart ) and (X<=FZoomBoxTextStop ) and (Y >= FToolBarVCenter) then Result :=  ord(iscmZoomBox)
  else                                                                                       Result := -1;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  PlotRect     : TRect;
  ToolBarRect  : TRect;
  LegendRect   : TRect;
  YPos         : Integer;
  ChannelIndex : Integer;
begin
  if Button = mbLeft then
    begin
      SetFocus;
      FMouseDownX     := X; FMouseDownY     := Y;
      FZoomMouseDownX := X; FZoomMouseDownY := Y;
      FZoomMouseUpX   := X; FZoomMouseUpY   := Y;

      PlotRect    := Rect(FGridLeft, FGridTop, FGridRight, FGridBottom);
      ToolBarRect := Rect(2, FToolBarTop, Width -3, FToolBarBottom);
      LegendRect  := Rect(FLegendLeft, FLegendTop, FLegendRight, FLegendBottom);

      if PtInRect(PlotRect, Point(X,Y)) then
        begin
          FMouseDown := True;
          if FToolBarMode = iscmCursor then
            begin
              CalcCursorIndex(X);
              if Assigned(FOnCursorIndexChange) then FOnCursorIndexChange(Self);
            end;
        end
      else if PtInRect(ToolBarRect, Point(X,Y)) then
        begin
          FToolBarButtonIndex := GetToolBarButtonIndex(X,Y);
          if FToolBarButtonIndex <> - 1 then ToolBarMode := TiStripChartMode(FToolBarButtonIndex);
        end
      else if PtInRect(LegendRect, Point(X,Y)) then
        begin
          YPos := FLegendTop;
          for ChannelIndex := 0 to ChannelCount - 1 do
            if ChannelVisibleInLegend[ChannelIndex] then
              begin
                if (Y >= YPos) and (Y <= YPos + FLegendRowHeight) then
                  begin
                    CursorChannel := ChannelIndex;
                    Break;
                  end;
                YPos := YPos + FLegendRowHeight;
              end;
        end
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.iMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if FGridRight  = FGridLeft then exit;
  if FGridBottom = FGridTop  then exit;

  if FMouseDown then
    begin
      if FToolBarMode in [iscmScrollX,iscmScrollXY] then ScrollXAxis((FMouseDownX-X)/(FGridRight  - FGridLeft)*(FXAxisMax - FXAxisMin));
      if FToolBarMode in [iscmScrollY,iscmScrollXY] then
        begin
          if FYAxisReverseScale then ScrollYAxis((FMouseDownY - Y)/(FGridBottom - FGridTop)*(FYAxisMax - FYAxisMin))
            else                     ScrollYAxis((Y-FMouseDownY  )/(FGridBottom - FGridTop)*(FYAxisMax - FYAxisMin));
        end;

      if FToolBarMode in [iscmZoomX,iscmZoomXY    ] then ZoomXAxis  (1 + (FMouseDownX-X)/(FGridRight  - FGridLeft));
      if FToolBarMode in [iscmZoomY,iscmZoomXY    ] then ZoomYAxis  (1 + (Y-FMouseDownY)/(FGridBottom - FGridTop ));

      if FToolBarMode in [iscmCursor              ] then
        begin
          CalcCursorIndex(X);
          if Assigned(FOnCursorIndexChange) then FOnCursorIndexChange(Self);
        end;

      if FToolBarMode in [iscmZoomBox             ] then
        begin
          FZoomMouseUpX := X; if FZoomMouseUpX > FGridRight  then FZoomMouseUpX := FGridRight;
          FZoomMouseUpY := Y; if FZoomMouseUpY > FGridBottom then FZoomMouseUpY := FGridBottom;
          InvalidateChange;
        end;

      FMouseDownX := X;
      FMouseDownY := Y;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewMin : Double;
  NewMax : Double;
begin
  if FGridRight  = FGridLeft then exit;
  if FGridBottom = FGridTop  then exit;

  if FMouseDown then
    begin
      if FToolBarMode = iscmZoomBox then
        begin
          if (FZoomMouseUpX > FZoomMouseDownX) and (FZoomMouseUpY > FZoomMouseDownY) then
            begin                                         
              NewMin := (FZoomMouseDownX - FGridLeft)/(FGridRight - FGridLeft)*(FXAxisMax - FXAxisMin) + FXAxisMin;
              NewMax := (FZoomMouseUpX   - FGridLeft)/(FGridRight - FGridLeft)*(FXAxisMax - FXAxisMin) + FXAxisMin;
              SetXAxisMinMax(NewMin, NewMax);

              if FYAxisReverseScale then
                begin
                  NewMax := (FZoomMouseUpY   - FGridTop)/(FGridBottom - FGridTop)*(FYAxisMax - FYAxisMin)+FYAxisMin;
                  NewMin := (FZoomMouseDownY - FGridTop)/(FGridBottom - FGridTop)*(FYAxisMax - FYAxisMin)+FYAxisMin;
                end          
              else
                begin
                  NewMax := (FGridBottom - FZoomMouseDownY)/(FGridBottom - FGridTop)*(FYAxisMax - FYAxisMin)+FYAxisMin;
                  NewMin := (FGridBottom - FZoomMouseUpY  )/(FGridBottom - FGridTop)*(FYAxisMax - FYAxisMin)+FYAxisMin;
                end;
              SetYAxisMinMax(NewMin, NewMax);

            end;
          FZoomMouseUpX := FZoomMouseDownX;
          FZoomMouseUpY := FZoomMouseDownY;
        end;
      FMouseDown := False;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetXPixels(Value: Double): Integer;
begin
  Result := Round((Value - FXAxisMin)/(FXAxisMax-FXAxisMin)*FXAxisWidth) + FGridLeft;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetYPixels(Value: Double): Integer;
begin
  if FYAxisReverseScale then
    Result := FGridTop    + Round((Value - FYAxisMin)/(FYAxisMax-FYAxisMin)*(FGridBottom - FGridTop))
  else
    Result := FGridBottom - Round((Value - FYAxisMin)/(FYAxisMax-FYAxisMin)*(FGridBottom - FGridTop));
end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelYPixels(Value: Double; FixedAxis: Boolean): Integer;
begin
  if FYAxisReverseScale then
    begin
      if FixedAxis then
        Result := FGridTop + Round(Value/100*(FGridBottom - FGridTop))
      else
        Result := FGridTop + Round((Value - FYAxisMin)/(FYAxisMax-FYAxisMin)*(FGridBottom - FGridTop))
    end
  else
    begin
      if FixedAxis then
        Result := FGridBottom - Round(Value/100*(FGridBottom - FGridTop))
      else
        Result := FGridBottom - Round((Value - FYAxisMin)/(FYAxisMax-FYAxisMin)*(FGridBottom - FGridTop));
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.CalcPoints;
var
  AxisMaxLabelWidth   : Integer;
  MaxLabelWidth       : Integer;
  MinLabelWidth       : Integer;
  MaxLabelHeight      : Integer;
  LabelHalfHeight     : Integer;
  ClientRect          : TRect;
  MaxTooBarTextHeight : Integer;
begin
  ClientRect := Rect(0, 0 ,Width, Height);
  with Canvas, ClientRect do
    begin
      Font.Assign(FToolBarActiveModeFont);
      MaxTooBarTextHeight := TextHeight('ABC');
      Font.Assign(FToolBarInactiveModeFont);
      if TextHeight('ABC') > MaxTooBarTextHeight then MaxTooBarTextHeight := TextHeight('ABC');
      FToolBarHeight := 2*MaxTooBarTextHeight;

      if not FYAxisLabelWidthFixed then
        begin
          Font.Assign(FYAxisLabelFont);
          MaxLabelWidth   := TextWidth(Trim(Format('%.' + IntToStr(GetYAxisDecimalPoints) + 'f', [FYAxisMax])));
          MinLabelWidth   := TextWidth(Trim(Format('%.' + IntToStr(GetYAxisDecimalPoints) + 'f', [FYAxisMin])));
          if MaxLabelWidth > MinLabelWidth then AxisMaxLabelWidth := MaxLabelWidth else AxisMaxLabelWidth := MinLabelWidth;
        end
      else AxisMaxLabelWidth := FYAxisLabelWidth;

      if FYAxisShow then FGridLeft := FYAxisMargin + FYAxisLabelMargin + AxisMaxLabelWidth + FYAxisTickMajorLength + FOuterMarginLeft
        else FGridLeft := FOuterMarginLeft;

      LabelHalfHeight := TextHeight(Trim(Format('%.' + IntToStr(GetYAxisDecimalPoints) + 'f', [FYAxisMax]))) div 2;
      FGridTop        := FOuterMarginTop + LabelHalfHeight;

      if FShowToolBar then FGridTop := FGridTop + FToolBarHeight + 10;

      if Length(Trim(FTitleText)) <> 0 then
        begin
          Font.Assign(FTitleFont);
          FGridTop := FGridTop + TextHeight(FTitleText) + FTitleMargin;
        end;

      FTitleBottom := FGridTop - LabelHalfHeight - FTitleMargin;

      if Length(Trim(FYAxisTitle)) <> 0 then
        begin
          Font.Assign(FYAxisTitleFont);
          FGridLeft := FGridLeft + TextHeight(FYAxisTitle) + FYAxisTitleMargin;
        end;

      FYAxisLabelRight := FGridLeft - FYAxisMargin - FYAxisTickMajorLength - FYAxisLabelMargin;
      FYAxisTitleRight := FYAxisLabelRight - AxisMaxLabelWidth - FYAxisTitleMargin;

      Font.Assign(FXAxisLabelFont);
      MaxLabelHeight := TextHeight(Trim(Format('%.' + IntToStr(GetXAxisDecimalPoints) + 'f', [FXAxisMax])));
      if FXAxisShow then FGridBottom := Bottom - (FXAxisMargin + FXAxisTickMajorLength + FXAxisLabelMargin + MaxLabelHeight + FOuterMarginBottom)
        else FGridBottom := Bottom - FOuterMarginBottom - FXAxisMargin;

      if Length(Trim(FXAxisTitle)) <> 0 then
        begin             
          Font.Assign(FXAxisTitleFont);
          FGridBottom := FGridBottom - TextHeight(FXAxisTitle) - FXAxisTitleMargin;
        end;

      FXAxisLabelTop    := FGridBottom   + FXAxisMargin + FXAxisTickMajorLength + FXAxisLabelMargin;
      FXAxisLabelBottom := FXAxisLabelTop + MaxLabelHeight;
      FXAxisTitleTop    := FXAxisLabelTop + MaxLabelHeight + FXAxisTitleMargin;

      if FShowLegend then FGridRight := Right - FLegendWidth - FLegendMargin - FOuterMarginRight
        else
          begin
            if FXAxisShow then
              FGridRight  := Right - (FOuterMarginRight + TextWidth(Trim(Format('%.' + IntToStr(GetXAxisDecimalPoints) + 'f', [FXAxisMax]))) div 2)
            else
              FGridRight  := Right - FOuterMarginRight;
          end;

      FXAxisWidth  := FGridRight  - FGridLeft + 1;
      FYAxisHeight := FGridBottom - FGridTop  + 1;
      ////////////// Legend /////////////////////////
      Font.Assign(FLegendFont);
      FLegendRowHeight := TextHeight('ABC');
      FLegendLeft      := FGridRight + FLegendMargin;
      FLegendTop       := FGridTop;
      FLegendRight     := FGridRight + FLegendMargin + FLegendWidth;
      FLegendBottom    := FGridTop   + FLegendRowHeight*FChannelList.Count + 10;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.iPaintTo(Canvas: TCanvas);
begin
  CalcPoints;

  {$IFDEF iVCL}
  IntersectClipRect(Canvas.Handle, 0, 0, Width, Height);
  {$ENDIF}
  try
    DrawBackGround(Canvas, BackGroundColor);

    if (FXAxisWidth > 0) and (FYAxisHeight > 0) then
      begin
                                     DrawGridBackGround(Canvas);
                                     DrawAxisLines     (Canvas);
        if not FGridLinesOnTop  then DrawGrid          (Canvas);
        if not FLimitLinesOnTop then DrawLimits        (Canvas);
                                     DrawVertLines     (Canvas);

        if (FIndexList.Count > 0)                   then
        if (FPlotStartIndex >= 0)                   then
        if (FPlotStopIndex <= (FIndexList.Count-1)) then
        if (FPlotStopIndex >= 0)                    then
          begin
            DrawData  (Canvas);
            DrawLabels(Canvas);
            DrawClip  (Canvas);
          end;

        if FGridLinesOnTop  then DrawGrid  (Canvas);
        if FLimitLinesOnTop then DrawLimits(Canvas);
      end;

    DrawTitle      (Canvas);
    DrawYTicks     (Canvas);
    DrawXTicks     (Canvas);
    DrawXAxisLabels(Canvas);
    DrawLegend     (Canvas);
    DrawModeLabels (Canvas);

    if (ToolBarMode = iscmZoomBox) and FMouseDown then
      begin
        Canvas.Brush.Color := FGridBackGroundColor;
        Canvas.Pen.Color   := FGridBackGroundColor;
        iDrawFocusRect(Canvas, Rect(FZoomMouseDownX, FZoomMouseDownY, FZoomMouseUpX, FZoomMouseUpY), BackGroundColor);
      end;
  finally
    {$IFDEF iVCL}
    SelectClipRgn(Canvas.Handle, 0);
    {$ENDIF}
  end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawLimits(Canvas: TCanvas);
var
  Channel        : Integer;
  iChannelObject : TiStripChartChannelObject;
begin
  if (FXAxisMax = FXAxisMin) or (FYAxisMax = FYAxisMin) then exit;
  with Canvas do
    begin
      for Channel := 0 to FChannelList.Count - 1 do
        begin
          if (FToolBarMode = iscmCursor) and (FCursorHideAllOtherChannels) and (Channel <> FCursorChannel) then Continue;
          iChannelObject := GetChannel(Channel);
          if iChannelObject.Visible then
            begin
              if iChannelObject.ControlLimitUpperShow then
                begin
                  if (iChannelObject.ControlLimitUpperValue <= FYAxisMax) and (iChannelObject.ControlLimitUpperValue >= FYAxisMin) then
                    begin
                      Pen.Style := TPenStyle(iChannelObject.ControlLimitUpperLineStyle);
                      Pen.Color := iChannelObject.ControlLimitUpperColor;
                      Pen.Width := iChannelObject.ControlLimitUpperLineWidth;
                      PolyLine([Point(FGridLeft,  GetChannelYPixels(iChannelObject.ControlLimitUpperValue, iChannelObject.UseFixedAxis)),
                                Point(FGridRight, GetChannelYPixels(iChannelObject.ControlLimitUpperValue, iChannelObject.UseFixedAxis))]);
                    end;
                end;

              if iChannelObject.ControlLimitLowerShow then
                begin
                  if (iChannelObject.ControlLimitLowerValue <= FYAxisMax) and (iChannelObject.ControlLimitLowerValue >= FYAxisMin) then
                    begin
                      Pen.Style := TPenStyle(iChannelObject.ControlLimitLowerLineStyle);
                      Pen.Color := iChannelObject.ControlLimitLowerColor;
                      Pen.Width := iChannelObject.ControlLimitLowerLineWidth;
                      PolyLine([Point(FGridLeft,  GetChannelYPixels(iChannelObject.ControlLimitLowerValue, iChannelObject.UseFixedAxis)),
                                Point(FGridRight, GetChannelYPixels(iChannelObject.ControlLimitLowerValue, iChannelObject.UseFixedAxis))]);
                    end;
                end;

              if iChannelObject.WarningLimitUpperShow then
                begin
                  if (iChannelObject.WarningLimitUpperValue <= FYAxisMax) and (iChannelObject.WarningLimitUpperValue >= FYAxisMin) then
                    begin
                      Pen.Style := TPenStyle(iChannelObject.WarningLimitUpperLineStyle);
                      Pen.Color := iChannelObject.WarningLimitUpperColor;
                      Pen.Width := iChannelObject.WarningLimitUpperLineWidth;
                      PolyLine([Point(FGridLeft,  GetChannelYPixels(iChannelObject.WarningLimitUpperValue, iChannelObject.UseFixedAxis)),
                                Point(FGridRight, GetChannelYPixels(iChannelObject.WarningLimitUpperValue, iChannelObject.UseFixedAxis))]);
                    end;
                end;

              if iChannelObject.WarningLimitLowerShow then
                begin
                  if (iChannelObject.WarningLimitLowerValue <= FYAxisMax) and (iChannelObject.WarningLimitLowerValue >= FYAxisMin) then
                    begin
                      Pen.Style := TPenStyle(iChannelObject.WarningLimitLowerLineStyle);
                      Pen.Color := iChannelObject.WarningLimitLowerColor;
                      Pen.Width := iChannelObject.WarningLimitLowerLineWidth;
                      PolyLine([Point(FGridLeft,  GetChannelYPixels(iChannelObject.WarningLimitLowerValue, iChannelObject.UseFixedAxis)),
                                Point(FGridRight, GetChannelYPixels(iChannelObject.WarningLimitLowerValue, iChannelObject.UseFixedAxis))]);
                    end;
                end;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawVertLines(Canvas: TCanvas);
var
  x                         : Integer;
  iStripChartVertLineObject : TiStripChartVertLineObject;
  PointX                    : Integer;
begin
  with Canvas do
    begin
      for x := 0 to FVerticalLineList.Count - 1 do
        begin
          iStripChartVertLineObject := FVerticalLineList.Objects[x] as TiStripChartVertLineObject;
          if (iStripChartVertLineObject.Position >= FXAxisMin) and (iStripChartVertLineObject.Position <= FXAxisMax) then
            begin
              Pen.Color := iStripChartVertLineObject.Color;
              Pen.Width := iStripChartVertLineObject.Width;
              Pen.Style := TPenStyle(iStripChartVertLineObject.Style);
              PointX    := GetXPixels(iStripChartVertLineObject.Position);
              Polyline([Point(PointX, FGridTop), Point(PointX, FGridBottom)]);
            end;

        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawConnectPoints(Canvas: TCanvas);
var
  Channel        : Integer;
  Index          : Integer;
  iChannelObject : TiStripChartChannelObject;
  DataX,  DataY  : Double;
  PointX         : Integer;
  DataIsNull     : Boolean;

  Point1         : TiMinMaxPoint;
  Point2         : TiMinMaxPoint;
  Point3         : TiMinMaxPoint;
begin
  Point1 := TiMinMaxPoint.Create;                      
  Point2 := TiMinMaxPoint.Create;
  Point3 := TiMinMaxPoint.Create;

  with Canvas do
    begin
      for Channel := 0 to FChannelList.Count - 1 do
        begin
          if FToolBarMode = iscmCursor then if FCursorHideAllOtherChannels then if Channel <> FCursorChannel then Continue;
          iChannelObject := GetChannel(Channel);
          if not iChannelObject.Visible then Continue;

          if Pen.Color <> iChannelObject.Color                then Pen.Color := iChannelObject.Color;
          if Pen.Style <> TPenStyle(iChannelObject.LineStyle) then Pen.Style := TPenStyle(iChannelObject.LineStyle);
          if Pen.Width <> iChannelObject.LineWidth            then Pen.Width := iChannelObject.LineWidth;

          Point1.Clear;
          Point2.Clear;
          Point3.Clear;

          for Index := FPlotStartIndex to FPlotStopIndex do
            begin
              DataX  := FIndexList.Item[Index];
              DataY  := iChannelObject.GetDataItem(Index, DataIsNull);
              PointX := GetXPixels(DataX);

              if      Point1.Empty            then Point1.AddData(DataY, DataIsNull, PointX)
              else if PointX = Point1.PixelsX then Point1.AddData(DataY, DataIsNull, PointX)
              else if Point2.Empty            then Point2.AddData(DataY, DataIsNull, PointX)
              else if PointX = Point2.PixelsX then Point2.AddData(DataY, DataIsNull, PointX)
              else
                begin
                  Point3.AddData(DataY, DataIsNull, PointX);

                  if (not Point1.IsNull)                         then Polyline([Point(Point1.PixelsX, GetChannelYPixels(Point1.YMax,  iChannelObject.UseFixedAxis)),
                                                                                Point(Point1.PixelsX, GetChannelYPixels(Point1.YMin,  iChannelObject.UseFixedAxis))]);
                  if (not Point2.IsNull)                         then Polyline([Point(Point2.PixelsX, GetChannelYPixels(Point2.YMax,  iChannelObject.UseFixedAxis)),
                                                                                Point(Point2.PixelsX, GetChannelYPixels(Point2.YMin,  iChannelObject.UseFixedAxis))]);

                  if (not Point1.IsNull) and (not Point2.IsNull) then Polyline([Point(Point1.PixelsX, GetChannelYPixels(Point1.YLast, iChannelObject.UseFixedAxis)),
                                                                                Point(Point2.PixelsX, GetChannelYPixels(Point2.YFirst,iChannelObject.UseFixedAxis))]);
                  if (not Point2.IsNull) and (not Point3.IsNull) then Polyline([Point(Point2.PixelsX, GetChannelYPixels(Point2.YLast, iChannelObject.UseFixedAxis)),
                                                                                Point(Point3.PixelsX, GetChannelYPixels(Point3.YFirst,iChannelObject.UseFixedAxis))]);

                  Point1.AssignDown(Point3);
                  Point2.Clear;
                  Point3.Clear;
                end;
            end;
            if (not Point1.IsNull)                         then Polyline([Point(Point1.PixelsX, GetChannelYPixels(Point1.YMax,  iChannelObject.UseFixedAxis)),
                                                                          Point(Point1.PixelsX, GetChannelYPixels(Point1.YMin,  iChannelObject.UseFixedAxis))]);
            if (not Point2.IsNull)                         then Polyline([Point(Point2.PixelsX, GetChannelYPixels(Point2.YMax,  iChannelObject.UseFixedAxis)),
                                                                          Point(Point2.PixelsX, GetChannelYPixels(Point2.YMin,  iChannelObject.UseFixedAxis))]);

            if (not Point1.IsNull) and (not Point2.IsNull) then Polyline([Point(Point1.PixelsX, GetChannelYPixels(Point1.YLast, iChannelObject.UseFixedAxis)),
                                                                          Point(Point2.PixelsX, GetChannelYPixels(Point2.YFirst,iChannelObject.UseFixedAxis))]);
            if (not Point2.IsNull) and (not Point3.IsNull) then Polyline([Point(Point2.PixelsX, GetChannelYPixels(Point2.YLast, iChannelObject.UseFixedAxis)),
                                                                          Point(Point3.PixelsX, GetChannelYPixels(Point3.YFirst,iChannelObject.UseFixedAxis))]);
          end;
        end;
  Point1.Free;
  Point2.Free;
  Point3.Free;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawData(Canvas: TCanvas);
var
  DataX : Double;
begin
  with Canvas do
    begin
      DrawConnectPoints(Canvas);
      if (FToolBarMode = iscmCursor) and (FCursorIndex >= 0) and (FCursorIndex <= (FIndexList.Count-1)) then
        begin
          Pen.Width := 1;
          Pen.Style := psSolid;
          Pen.Color := FCursorColor;
          DataX     := FIndexList.Item[FCursorIndex];
          PolyLine([Point(GetXPixels(DataX)-1,FGridTop), Point(GetXPixels(DataX)-1,FGridBottom)]);
          PolyLine([Point(GetXPixels(DataX)+0,FGridTop), Point(GetXPixels(DataX)+0,FGridBottom)]);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawClip(Canvas: TCanvas);
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := BackGroundColor;
      Pen.Style   := psSolid;
      Pen.Color   := BackGroundColor;
      Pen.Width   := 1;

      Rectangle(0,           0,             FGridLeft, Height);
      Rectangle(0,           0,             Width,     FGridTop);
      Rectangle(FGridRight+1,0,             Width,     Height);
      Rectangle(0,           FGridBottom+1, Width,     Height);

      DrawBorder(Canvas);
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawLabels(Canvas: TCanvas);
var
  LabelChannel        : Integer;
  Index               : Integer;
  iLabelChannelObject : TiLabelChannelObject;
  PointX, PointY      : Integer;
  LabelString         : String;
begin
  with Canvas do
    begin
      Brush.Style := bsClear;
      for LabelChannel := 0 to FLabelChannelList.Count - 1 do
        begin
          iLabelChannelObject := GetLabelChannel(LabelChannel);
          Font.Assign(iLabelChannelObject.Font);
          if iLabelChannelObject.Visible then
            begin
              for Index := FPlotStartIndex to FPlotStopIndex do
                begin
                  LabelString := iLabelChannelObject.LabelList.Strings[Index];
                  if Trim(LabelString) <> '' then
                    begin
                      PointX := GetXPixels(FIndexList.Item[Index]);
                      PointY := GetChannelYPixels(iLabelChannelObject.YPosition, True);
                      TextOut(PointX - TextWidth (LabelString) div 2, PointY - TextHeight(LabelString) div 2, LabelString);
                    end;
                end;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawAxisLines(Canvas: TCanvas);
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;
      Pen.Color   := FAxisGridColor;
      Pen.Width   := 1;
      Pen.Style   := psSolid;
      PolyLine([Point(FGridLeft, FGridTop   ), Point(FGridLeft, FGridBottom)]);
      PolyLine([Point(FGridLeft, FGridBottom), Point(FGridRight,FGridBottom)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawGridBackGround(Canvas: TCanvas);
begin
  with Canvas do
    begin
      Brush.Color := FGridBackGroundColor;
      Brush.Style := bsSolid;
      Pen.Color   := FGridBackGroundColor;
      Pen.Style   := psSolid;
      Rectangle(FGridLeft, FGridTop, FGridRight, FGridBottom);
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawGrid(Canvas: TCanvas);
var
  x              : Integer;
  MajorTickStep  : Double;
  LabelXStepSize : Double;
  StartX         : Double;
  DataX          : Double;
begin
  if not FShowGrid then Exit;
  with Canvas do
    begin
      Pen.Color := FAxisGridColor;
      Pen.Style := TPenStyle(FGridLineStyle);
      Pen.Width := 0;

      PolyLine([Point(FGridRight, FGridTop), Point(FGridRight, FGridBottom)]);
      PolyLine([Point(FGridLeft,  FGridTop), Point(FGridRight, FGridTop   )]);

      MajorTickStep := (FYAxisMax - FYAxisMin)/(FYAxisTickMajorCount-1);
      for x := 1 to FYAxisTickMajorCount - 2 do
        PolyLine([Point(GetXPixels(FXAxisMin), GetYPixels(FYAxisMin+x*MajorTickStep)),
                  Point(GetXPixels(FXAxisMax), GetYPixels(FYAxisMin+x*MajorTickStep))]);

      if FXAxisShow then
        begin
          for x := 1 to FXAxisTickMajorCount - 2 do
            begin
              MajorTickStep := (FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount-1);
              PolyLine([Point(GetXPixels(FXAxisMin+x*MajorTickStep), GetYPixels(FYAxisMin)),
                        Point(GetXPixels(FXAxisMin+x*MajorTickStep), GetYPixels(FYAxisMax))]);
            end
        end
      else
        begin
          LabelXStepSize := (FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1);
          StartX := Trunc(FXAxisMin/LabelXStepSize) * LabelXStepSize;
          for x := 0 to FXAxisTickMajorCount do
            begin
              DataX := StartX + x*LabelXStepSize;
              if DataX < FXAxisMin then Continue;
              if DataX > FXAxisMax then Continue;
              PolyLine([Point(GetXPixels(DataX), GetYPixels(FYAxisMin)),
                        Point(GetXPixels(DataX), GetYPixels(FYAxisMax))]);
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawYTicks(Canvas: TCanvas);
var
  ClientRect        : TRect;
  x, y              : Integer;
  TickValue         : Double;
  ATextRect         : TRect;
  ATextString       : String;
  ATextHeight       : Integer;
  ATextWidth        : Integer;
  TempRect          : TRect;
  MajorTickStep     : Integer;
  MajorTickStepSize : Double;
  MinorTickStepSize : Double;
  AxisLength        : Integer;
  {$ifdef iVCL}
  FontInfo          : TLogFont;
  NewFont           : HFont;
  OldFont           : HFont;
  TextSize          : TSize;
  {$endif}
  XPosition         : Integer;
begin
  if not FYAxisShow then exit;
  with Canvas, ClientRect do
    begin
      ClientRect  := Rect(0, 0 ,Width, Height);
      Brush.Style := bsClear;
      Pen.Width   := 1;
      Pen.Style   := psSolid;
      AxisLength  := FGridBottom - FGridTop;
      MajorTickStepSize := AxisLength        / (FYAxisTickMajorCount - 1);
      MinorTickStepSize := MajorTickStepSize / (FYAxisTickMinorCount + 1);

      Font.Assign(FYAxisLabelFont);

      XPosition := FGridLeft-FYAxisMargin;

      for x := 0 to FYAxisTickMajorCount - 1 do
        begin
          TickValue     := (FYAxisMax - FYAxisMin) /(FYAxisTickMajorCount-1) * x + FYAxisMin;

          ATextString   := Trim(Format('%.' + IntToStr(GetYAxisDecimalPoints) + 'f', [TickValue]));
          ATextHeight   := TextHeight(ATextString);
          ATextWidth    := TextWidth (ATextString);
          MajorTickStep := Round(x * MajorTickStepSize);

          if FYAxisReverseScale then
               TempRect := Rect(XPosition, FGridTop   +MajorTickStep,XPosition-FYAxisTickMajorLength, FGridTop   +MajorTickStep)
          else TempRect := Rect(XPosition, FGridBottom-MajorTickStep,XPosition-FYAxisTickMajorLength, FGridBottom-MajorTickStep);

          Pen.Color := FYAxisTickMajorColor;
          PolyLine([Point(TempRect.Left, TempRect.Top), Point(TempRect.Right, TempRect.Bottom)]);

          if (x < (FYAxisTickMajorCount - 1)) then
            begin
              Pen.Color := FYAxisTickMinorColor;
              for y := 1 to FYAxisTickMinorCount do
                begin
                  if FYAxisReverseScale then                                                               
                    TempRect := Rect(XPosition,                         FGridTop + (MajorTickStep + Round(Y*MinorTickStepSize)),
                                     XPosition - FYAxisTickMinorLength, FGridTop + (MajorTickStep + Round(Y*MinorTickStepSize)))
                  else
                    TempRect := Rect(XPosition,                         FGridBottom - (MajorTickStep + Round(Y*MinorTickStepSize)),
                                     XPosition - FYAxisTickMinorLength, FGridBottom - (MajorTickStep + Round(Y*MinorTickStepSize)));
                  PolyLine([Point(TempRect.Left, TempRect.Top), Point(TempRect.Right, TempRect.Bottom)]);
                end;
            end;

          if FYAxisReverseScale then
            ATextRect := Rect(FYAxisLabelRight,              FGridTop + MajorTickStep - ATextHeight div 2,
                              FYAxisLabelRight - ATextWidth, FGridTop + MajorTickStep + ATextHeight div 2)
          else
            ATextRect := Rect(FYAxisLabelRight,              FGridBottom - MajorTickStep - ATextHeight div 2,
                              FYAxisLabelRight - ATextWidth, FGridBottom - MajorTickStep + ATextHeight div 2);

          with ATextRect do
            TextOut((Left + Right) div 2 - TextWidth(ATextString) div 2, (Top + Bottom) div 2 - TextHeight(ATextString) div 2, ATextString);
        end;

        if Length(Trim(FYAxisTitle)) <> 0 then
          begin
            {$ifndef iCLX}
            Font.Assign(FYAxisTitleFont);

            with FontInfo do
              begin
                lfHeight         := FYAxisTitleFont.Height;
                lfWidth          := FW_DONTCARE;
                lfEscapement     := 900;
                lfOrientation    := 900;
                lfItalic         := Byte(fsItalic in FYAxisTitleFont.Style);
                lfUnderline      := Byte(fsUnderline in FYAxisTitleFont.Style);
                lfStrikeOut      := Byte(fsStrikeOut in FYAxisTitleFont.Style);
                lfCharSet        := DEFAULT_CHARSET;
                lfPitchAndFamily := VARIABLE_PITCH;
                lfQuality        := DEFAULT_QUALITY;
                lfOutPrecision   := OUT_DEFAULT_PRECIS;
                lfClipPrecision  := CLIP_DEFAULT_PRECIS;
                if fsBold in FYAxisTitleFont.Style then lfWeight := FW_BOLD else lfWeight := FW_NORMAL;
                StrPCopy(lfFaceName, FYAxisTitleFont.Name);
              end;
            NewFont := CreateFontIndirect(FontInfo);
            try
              OldFont := SelectObject(Handle, NewFont);
              Font.Color := FYAxisTitleFont.Color;

              Windows.GetTextExtentPoint32(Handle, PChar(FYAxisTitle), Length(FYAxisTitle), TextSize);
              ATextHeight := TextSize.cy;
              ATextWidth  := TextSize.cx;

              ATextRect    := Rect(FYAxisTitleRight - ATextHeight, (FGridBottom + FGridTop) div 2 + ATextWidth div 2,
                                   FYAxisTitleRight,               (FGridBottom + FGridTop) div 2 + ATextWidth div 2);
              DrawText(Handle, PChar(FYAxisTitle), Length(FYAxisTitle), ATextRect, DT_VCENTER + DT_LEFT + DT_NOCLIP);
              SelectObject(Handle, OldFont);
            finally
              DeleteObject(NewFont);
            end;
            {$endif}
          end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawXAxisLabels(Canvas: TCanvas);
var
  x                 : Integer;
  MajorTickStep     : Integer;
  MajorTickStepSize : Double;
  AxisLength        : Integer;
  TickValue         : Double;
  ATextRect         : TRect;
  ATextString       : String;
  ATextHeight       : Integer;
  ATextWidth        : Integer;
begin
  if not FXAxisShow then exit;
  with Canvas do
    begin
      AxisLength        := FGridRight - FGridLeft;
      MajorTickStepSize := AxisLength/(FXAxisTickMajorCount - 1);

      Brush.Style := bsClear;
      Font.Assign(FXAxisLabelFont);

      for x := 0 to FXAxisTickMajorCount - 1 do
        begin
          TickValue := (FXAxisMax - FXAxisMin) /(FXAxisTickMajorCount-1) * x + FXAxisMin;

          if FXAxisDateTimeEnabled then
            begin
              if UpperCase(Copy(FXAxisDateTimeFormatString, 1, 1)) = 'J' then
                   ATextString   := Trim(IntToStr(Trunc(TickValue)) + ' ' + FormatDateTime(Copy(FXAxisDateTimeFormatString, 2, Length(FXAxisDateTimeFormatString) - 1), TickValue))
              else ATextString   := Trim(FormatDateTime(FXAxisDateTimeFormatString, TickValue));
            end
          else
            begin
              ATextString   := Trim(Format('%.' + IntToStr(GetXAxisDecimalPoints) + 'f', [TickValue]));
            end;
          ATextHeight   := TextHeight(ATextString);
          ATextWidth    := TextWidth (ATextString);

          MajorTickStep := Round(x * MajorTickStepSize);
          if (FXAxisTickMajorCount = 2) and FXAxisDateTimeEnabled then
            begin
              case x of
                0 : ATextRect := Rect(FGridLeft + MajorTickStep,              FXAxisLabelTop,
                                      FGridLeft + MajorTickStep + ATextWidth, FXAxisLabelTop + ATextHeight);
                1 : ATextRect := Rect(FGridLeft + MajorTickStep - ATextWidth, FXAxisLabelTop,
                                      FGridLeft + MajorTickStep,              FXAxisLabelTop + ATextHeight);
              end;
            end
          else ATextRect := Rect(FGridLeft + MajorTickStep - ATextWidth div 2, FXAxisLabelTop,
                                 FGridLeft + MajorTickStep + ATextWidth div 2, FXAxisLabelTop + ATextHeight);

          with ATextRect do
            TextOut((Left + Right) div 2 - TextWidth(ATextString) div 2, (Top + Bottom) div 2 - TextHeight(ATextString) div 2, ATextString);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawXTicks(Canvas: TCanvas);
var
  ClientRect        : TRect;
  x, y              : Integer;
  ARect             : TRect;
  MajorTickStep     : Integer;
  MajorTickStepSize : Double;
  MinorTickStepSize : Double;
  AxisLength        : Integer;
  ATextHeight       : Integer;
  ATextWidth        : Integer;    
begin
  if not FXAxisShow then exit;
  with Canvas, ClientRect do
    begin
      ClientRect  := Rect(0, 0 ,Width, Height);
      Brush.Style := bsSolid;
      Pen.Width   := 1;
      Pen.Style   := psSolid;
      AxisLength  := FGridRight - FGridLeft;
      MajorTickStepSize := AxisLength        / (FXAxisTickMajorCount - 1);
      MinorTickStepSize := MajorTickStepSize / (FXAxisTickMinorCount + 1);

      Font.Assign(FXAxisLabelFont);

      for x := 0 to FXAxisTickMajorCount - 1 do
        begin
          MajorTickStep := Round(x * MajorTickStepSize);

          Pen.Color := FXAxisTickMajorColor;
          ARect  := Rect(FGridLeft + MajorTickStep, FGridBottom + FXAxisMargin,
                         FGridLeft + MajorTickStep, FGridBottom + FXAxisMargin + FXAxisTickMajorLength);
          PolyLine([Point(ARect.Left, ARect.Top), Point(ARect.Right, ARect.Bottom)]);

          if (x < (FXAxisTickMajorCount - 1)) then
            begin
              Pen.Color := FXAxisTickMinorColor;
              for y := 1 to FXAxisTickMinorCount do
                begin
                  ARect := Rect(FGridLeft + MajorTickStep + Round(Y*MinorTickStepSize), FGridBottom + FXAxisMargin,
                                FGridLeft + MajorTickStep + Round(Y*MinorTickStepSize), FGridBottom + FXAxisMargin + FXAxisTickMinorLength);
                  PolyLine([Point(ARect.Left, ARect.Top), Point(ARect.Right, ARect.Bottom)]);
                end;
            end;
        end;
      if Length(Trim(FXAxisTitle)) <> 0 then
         begin
           Brush.Style := bsClear;
           Font.Assign(FXAxisTitleFont);
           ATextHeight  := TextHeight(FXAxisTitle);
           ATextWidth   := TextWidth(FXAxisTitle);
           ARect     := Rect((FGridLeft + FGridRight) div 2 - ATextWidth div 2, FXAxisTitleTop,
                             (FGridLeft + FGridRight) div 2 + ATextWidth div 2, FXAxisTitleTop + ATextHeight);
           with ARect do
             TextOut((Left + Right) div 2 - TextWidth(FXAxisTitle) div 2, (Top + Bottom) div 2 - TextHeight(FXAxisTitle) div 2, FXAxisTitle);
         end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawTitle(Canvas: TCanvas);
var
  ClientRect  : TRect;
  ATextHeight : Integer;
  ATextWidth  : Integer;
begin
  with Canvas, ClientRect do
    begin
      ClientRect := Rect(0, 0 ,Width, Height);
      if Length(Trim(FTitleText)) <> 0 then
        begin
          Font.Assign(FTitleFont);
          Brush.Style := bsClear;
          ATextHeight  := TextHeight(FTitleText);
          ATextWidth   := TextWidth(FTitleText);
          TextOut((FGridLeft + FGridRight) div 2 - ATextWidth div 2, FTitleBottom - ATextHeight, FTitleText);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawLegend(Canvas: TCanvas);
var
  ClientRect    : TRect;
  ATextString   : String;
  ATextRect     : TRect;
  YPoint        : Integer;
  YPos          : Integer;
  XStart        : Integer;
  x             : Integer;
  ChannelObject : TiStripChartChannelObject;
begin
  with Canvas, ClientRect do
    begin
      ClientRect := Rect(0, 0 ,Width, Height);
      if FShowLegend then
        begin
          Font.Assign(FLegendFont);

          YPoint := FLegendTop + 5;
          for x := 0 to FChannelList.Count - 1 do
            begin
              ChannelObject := GetChannel(x);
              if ChannelObject.VisibleInLegend then
                begin
                  Pen.Color     := ChannelObject.Color;
                  Brush.Color   := BackGroundColor;
                  ATextString   := ChannelObject.Title;
                  ATextRect     := Rect(FLegendLeft  + 20, YPoint, FLegendRight -  5, YPoint + FLegendRowHeight);

                  Pen.Width := 0;
                  YPos      := YPoint+FLegendRowHeight div 2;
                  XStart    := FLegendLeft + 2;
                  case ChannelObject.LineStyle of
                    iclsSolid      : begin
                                       PolyLine([Point(XStart,      YPos), Point(XStart + 13, YPos)]);
                                     end;
                    iclsDash       : begin
                                       PolyLine([Point(XStart,      YPos), Point(XStart +  5, YPos)]);
                                       PolyLine([Point(XStart +  8, YPos), Point(XStart + 13, YPos)]);
                                     end;
                    iclsDot        : begin
                                       PolyLine([Point(XStart,      YPos), Point(XStart +  2, YPos)]);
                                       PolyLine([Point(XStart +  4, YPos), Point(XStart +  6, YPos)]);
                                       PolyLine([Point(XStart +  8, YPos), Point(XStart + 10, YPos)]);
                                     end;
                    iclsDashDot    : begin
                                       PolyLine([Point(XStart,      YPos), Point(XStart +  5, YPos)]);
                                       PolyLine([Point(XStart +  7, YPos), Point(XStart +  9, YPos)]);
                                     end;
                    iclsDashDotDot : begin
                                       PolyLine([Point(XStart,      YPos), Point(XStart +  5, YPos)]);
                                       PolyLine([Point(XStart +  7, YPos), Point(XStart +  9, YPos)]);
                                       PolyLine([Point(XStart + 11, YPos), Point(XStart + 13, YPos)]);
                                     end;
                  end;

                  if (FToolBarMode = iscmCursor) and (FCursorChannel = x) then
                    begin
                      Brush.Color := FCursorChannelBackGroundColor;
                      Font.Color  := FCursorChannelFontColor;
                    end
                  else
                    begin
                      Brush.Style := bsClear;
                      Font.Color  := FLegendFont.Color;
                    end;
                  TextOut(ATextRect.Left, ATextRect.Top, ATextString);
                  YPoint := YPoint + FLegendRowHeight;
                end;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DrawModeLabels(Canvas: TCanvas);
var
  LeftTotal      : Integer;
  AText          : String;
  MaxHeight      : Integer;
  MaxWidth       : Integer;
  XData          : Double;
  YData          : Double;
  iChannelObject : TiStripChartChannelObject;
  DataIsNull     : Boolean;
  AClientRect    : TRect;
begin
  if not FShowToolBar then exit;
  AClientRect := Rect(0, 0, Width, Height);
  with Canvas, AClientRect do
    begin
      Brush.Style := bsClear;
      LeftTotal   := 10;

      AText := 'Zoom-Box ';
      Font.Assign(FToolBarActiveModeFont);
      MaxHeight := TextHeight(AText);
      MaxWidth  := TextWidth(AText);
      Font.Assign(FToolBarInactiveModeFont);
      if TextHeight(AText) > MaxHeight then MaxHeight := TextHeight(AText);
      if TextWidth(AText)  > MaxWidth  then MaxWidth  := TextWidth(AText);

      FToolBarTop     := 10;
      FToolBarVCenter := 10 + MaxHeight;
      FToolBarHeight  := 2*MaxHeight;
      FToolBarBottom  := FToolBarTop + FToolBarHeight;

      AText := 'Mode :  ';
      TextOut(LeftTotal, 10, AText);
      LeftTotal          := LeftTotal + TextWidth(AText);

      if FToolBarMode = iscmPlot then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Plot ';
      TextOut(LeftTotal, 10, AText);
      FPlotTextStart     := LeftTotal;
      FPlotTextStop      := LeftTotal + TextWidth(AText);
      LeftTotal          := LeftTotal + TextWidth(AText);

      if FToolBarMode = iscmScrollX then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Scroll-X';
      TextOut(LeftTotal + (MaxWidth - TextWidth(AText)) div 2, 10, AText);
      FScrollXTextStart  := LeftTotal;
      FScrollXTextStop   := FScrollXTextStart + MaxWidth;
      LeftTotal          := LeftTotal + MaxWidth;

      if FToolBarMode = iscmScrollY then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Scroll-Y';
      TextOut(LeftTotal + (MaxWidth - TextWidth(AText)) div 2, 10, AText);
      FScrollYTextStart  := LeftTotal;
      FScrollYTextStop   := FScrollYTextStart + MaxWidth;
      LeftTotal          := LeftTotal + MaxWidth;

      if FToolBarMode = iscmScrollXY then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Scroll-XY';
      TextOut(LeftTotal + (MaxWidth - TextWidth(AText)) div 2, 10, AText);
      FScrollXYTextStart := LeftTotal;
      FScrollXYTextStop  := FScrollXYTextStart + MaxWidth;
      LeftTotal          := LeftTotal + MaxWidth;

      if FToolBarMode = iscmCursor then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Cursor';
      TextOut(LeftTotal + (MaxWidth - TextWidth(AText)) div 2, 10, AText);
      FCursorTextStart   := LeftTotal;
      FCursorTextStop    := FCursorTextStart + MaxWidth;
      LeftTotal          := LeftTotal + MaxWidth;

      if (FToolBarMode = iscmCursor) and (FChannelList.Count <> 0) and (FIndexList.Count <> 0) then
         begin
           iChannelObject := FChannelList.Objects[FCursorChannel] as TiStripChartChannelObject;
           XData          := FIndexList.Item[FCursorIndex];
           YData          := iChannelObject.GetDataItem(FCursorIndex, DataIsNull);

           if not DataIsNull then
             begin
               if FXAxisDateTimeEnabled then
                 begin
                  if UpperCase(Copy(FXAxisDateTimeFormatString, 1, 1)) = 'J' then
                    AText   := 'X = ' + Trim(IntToStr(Trunc(XData)) + FormatDateTime(Copy(FXAxisDateTimeFormatString, 2, Length(FXAxisDateTimeFormatString) - 1), XData)) + '  ' + Trim(Format('  Y = %.' + IntToStr(GetYAxisDecimalPoints) + 'f',[YData]))
                  else AText := 'X = ' + Trim(FormatDateTime(FXAxisDateTimeFormatString, XData)) + '  ' + Trim(Format('  Y = %.' + IntToStr(GetYAxisDecimalPoints) + 'f',[YData]));
                 end
               else
                 begin
                  AText := Trim(Format('X = %.' + IntToStr(GetXAxisDecimalPoints) + 'f  Y = %.' + IntToStr(GetYAxisDecimalPoints) + 'f',[XData, YData]));
                 end;
             end
           else
             AText := Trim(Format('X = %.' + IntToStr(GetXAxisDecimalPoints) + 'f Y = ' ,[XData]) + 'Null');

           TextOut(LeftTotal, 10, AText);
         end;

      if FToolBarMode = iscmZoomX then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Zoom-X';
      TextOut((FScrollXTextStart + FScrollXTextStop) div 2 - TextWidth(AText) div 2, 10 + MaxHeight, AText);
      FZoomXTextStart    := FScrollXTextStart;
      FZoomXTextStop     := FScrollXTextStop;

      if FToolBarMode = iscmZoomY then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Zoom-Y';
      TextOut((FScrollYTextStart + FScrollYTextStop) div 2 - TextWidth(AText) div 2, 10 + MaxHeight, AText);
      FZoomYTextStart    := FScrollYTextStart;
      FZoomYTextStop     := FScrollYTextStop;

      if FToolBarMode = iscmZoomXY then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Zoom-XY';
      TextOut((FScrollXYTextStart + FScrollXYTextStop) div 2 - TextWidth(AText) div 2, 10 + MaxHeight, AText);
      FZoomXYTextStart   := FScrollXYTextStart;
      FZoomXYTextStop    := FScrollXYTextStop;

      if FToolBarMode = iscmZoomBox then Font.Assign(FToolBarActiveModeFont) else Font.Assign(FToolBarInactiveModeFont);
      AText := 'Zoom-Box';
      TextOut((FCursorTextStart + FCursorTextStop) div 2 - TextWidth(AText) div 2, 10 + MaxHeight, AText);
      FZoomBoxTextStart  := FCursorTextStart;
      FZoomBoxTextStop   := FCursorTextStop;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.AddChannel(Title: String; AColor: TColor; LineStyle: TiChannelLineStyle; LineWidth: Integer);
var
  ChannelObject : TiStripChartChannelObject;
  x             : Integer;
begin
  case FDiscontinuousDataEnabled of
    False : ChannelObject := TiStripChartContinuousDataChannelObject.Create;
    else    ChannelObject := TiStripChartDiscontinuousDataChannelObject.Create;
  end;
  ChannelObject.Color     := AColor;
  ChannelObject.Title     := Title;
  ChannelObject.LineStyle := LineStyle;
  ChannelObject.LineWidth := LineWidth;
  FChannelList.AddObject('', ChannelObject);

  if not FDiscontinuousDataEnabled then
    begin
      ClearData;
    end
  else
    begin
      for x := 0 to FIndexList.Count - 1 do
        ChannelObject.DataAdd(0);
    end;

  if FCursorChannel < 0 then FCursorChannel := 0;

  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.RemoveChannel(Index: Integer);
begin
  GetChannel(Index).Free;
  FChannelList.Delete(Index);
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.RemoveLabelChannel(Index: Integer);
begin
  GetLabelChannel(Index).Free;
  FLabelChannelList.Delete(Index);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.RemoveAllChannels;
begin
  while FChannelList.Count > 0 do RemoveChannel(0)
end;
//****************************************************************************************************************************************************
procedure TiStripChart.RemoveAllLabelChannels;
begin
  while FLabelChannelList.Count > 0 do RemoveLabelChannel(0);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.AddLabelChannel(YPosition: Double);
var
  LabelChannelObject : TiLabelChannelObject;
begin
  LabelChannelObject           := TiLabelChannelObject.Create;
  LabelChannelObject.YPosition := YPosition;
  FLabelChannelList.AddObject('', LabelChannelObject);

  ClearData;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetLabelChannelCount: Integer;begin Result:=FLabelChannelList.Count;end;
function TiStripChart.GetChannelCount     : Integer;begin Result:=FChannelList.Count;     end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelTitle          (Index:Integer):String;            begin Result:=GetChannel(Index).Title;          end;
function TiStripChart.GetChannelColor          (Index:Integer):TColor;            begin Result:=GetChannel(Index).Color;          end;
function TiStripChart.GetChannelLineStyle      (Index:Integer):TiChannelLineStyle;begin Result:=GetChannel(Index).LineStyle;      end;
function TiStripChart.GetChannelLineWidth      (Index:Integer):Integer;           begin Result:=GetChannel(Index).LineWidth;      end;
function TiStripChart.GetChannelVisible        (Index:Integer):Boolean;           begin Result:=GetChannel(Index).Visible;        end;
function TiStripChart.GetChannelVisibleInLegend(Index:Integer):Boolean;           begin Result:=GetChannel(Index).VisibleInLegend;end;
function TiStripChart.GetChannelUseFixedAxis   (Index:Integer):Boolean;           begin Result:=GetChannel(Index).UseFixedAxis;   end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelMin(Index: Integer): Double;
var
  ChannelObject : TiStripChartChannelObject;
  x             : Integer;
  DataIsNull    : Boolean;
  Data          : Double;
begin
  ChannelObject := GetChannel(Index);

  Result := 1e+300;
  for x := 0 to ChannelObject.HighestIndex do
    begin
      Data := ChannelObject.GetDataItem(x, DataIsNull);
      if not DataIsNull then
        begin
          if Data < Result then Result := Data;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelMax(Index: Integer): Double;
var
  ChannelObject : TiStripChartChannelObject;
  x             : Integer;
  DataIsNull    : Boolean;
  Data          : Double;
begin
  ChannelObject := GetChannel(Index);

  Result := 1e-300;
  for x := 0 to ChannelObject.HighestIndex do
    begin
      Data := ChannelObject.GetDataItem(x, DataIsNull);
      if not DataIsNull then
        begin
          if Data > Result then Result := Data;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelMean(Index: Integer): Double;
var
  ChannelObject : TiStripChartChannelObject;
  x             : Integer;
  Count         : Integer;
  Total         : Double;
  DataIsNull    : Boolean;
  Data          : Double;
begin
  ChannelObject := GetChannel(Index);

  Total := 0;
  Count := 0;
  for x := 0 to ChannelObject.HighestIndex do
    begin
      Data := ChannelObject.GetDataItem(x, DataIsNull);
      if not DataIsNull then
        begin
          Total := Total + Data;
          inc(Count)
        end;
    end;
  if Count <> 0 then Result := Total/Count else Result := 0;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetChannelTitle          (Index:Integer;const Value:String            );begin GetChannel(Index).Title          := Value;BackGroundChange;end;
procedure TiStripChart.SetChannelColor          (Index:Integer;const Value:TColor            );begin GetChannel(Index).Color          := Value;BackGroundChange;end;
procedure TiStripChart.SetChannelLineStyle      (Index:Integer;const Value:TiChannelLineStyle);begin GetChannel(Index).LineStyle      := Value;BackGroundChange;end;
procedure TiStripChart.SetChannelLineWidth      (Index:Integer;const Value:Integer           );begin GetChannel(Index).LineWidth      := Value;BackGroundChange;end;
procedure TiStripChart.SetChannelVisible        (Index:Integer;const Value:Boolean           );begin GetChannel(Index).Visible        := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelVisibleInLegend(Index:Integer;const Value:Boolean           );begin GetChannel(Index).VisibleInLegend:= Value;BackGroundChange;end;
procedure TiStripChart.SetChannelUseFixedAxis   (Index:Integer;const Value:Boolean           );begin GetChannel(Index).UseFixedAxis   := Value;InvalidateChange;end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetChannelControlLimits(Channel: Integer; ShowUpper: Boolean; UpperValue: Double; UpperLineStyle: TiChannelLineStyle;
                                                                 ShowLower: Boolean; LowerValue: Double; LowerLineStyle: TiChannelLineStyle);
begin
  GetChannel(Channel).ControlLimitUpperShow      := ShowUpper;
  GetChannel(Channel).ControlLimitUpperValue     := UpperValue;
  GetChannel(Channel).ControlLimitUpperLineStyle := UpperLineStyle;

  GetChannel(Channel).ControlLimitLowerShow      := ShowLower;
  GetChannel(Channel).ControlLimitLowerValue     := LowerValue;
  GetChannel(Channel).ControlLimitLowerLineStyle := LowerLineStyle;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetChannelWarningLimits(Channel: Integer; ShowUpper: Boolean; UpperValue: Double; UpperLineStyle: TiChannelLineStyle;
                                                                 ShowLower: Boolean; LowerValue: Double; LowerLineStyle: TiChannelLineStyle);
begin
  GetChannel(Channel).WarningLimitUpperShow      := ShowUpper;
  GetChannel(Channel).WarningLimitUpperValue     := UpperValue;
  GetChannel(Channel).WarningLimitUpperLineStyle := UpperLineStyle;

  GetChannel(Channel).WarningLimitLowerShow      := ShowLower;
  GetChannel(Channel).WarningLimitLowerValue     := LowerValue;
  GetChannel(Channel).WarningLimitLowerLineStyle := LowerLineStyle;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.AddVerticalLine(Position: Double; Color: TColor; Width: Integer; Style: TiChannelLineStyle);
var
  iStripChartVertLineObject : TiStripChartVertLineObject;
begin
  iStripChartVertLineObject          := TiStripChartVertLineObject.Create;
  iStripChartVertLineObject.Position := Position;
  iStripChartVertLineObject.Color    := Color;
  iStripChartVertLineObject.Width    := Width;
  iStripChartVertLineObject.Style    := Style;

  FVerticalLineList.AddObject('', iStripChartVertLineObject);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.RemoveAllVerticalLines;
begin
  while FVerticalLineList.Count <> 0 do
    begin
      FVerticalLineList.Objects[0].Free;
      FVerticalLineList.Delete(0);
    end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Channels', ReadChannels, WriteChannels, DoWriteChannels);
  Filer.DefineProperty('XAxisMax_2', ReadXAxisMax, WriteXAxisMax, True);
  Filer.DefineProperty('YAxisMax_2', ReadyAxisMax, WriteYAxisMax, True);
end;
//****************************************************************************************************************************************************
function TiStripChart.DoWriteChannels: Boolean;
begin
  Result := FChannelList.Count <> 0;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ReadChannels(Reader: TReader);
var
  ChannelObject : TiStripChartChannelObject;
begin
  ClearData;
  RemoveAllChannels;

  Reader.ReadListBegin;
  while not Reader.EndOfList do
    begin
      if FDiscontinuousDataEnabled then ChannelObject := TiStripChartDiscontinuousDataChannelObject.Create
        else                            ChannelObject := TiStripChartContinuousDataChannelObject.Create;

      FChannelList.AddObject('', ChannelObject);
      ChannelObject.Title     := Reader.ReadString;

      Reader.ReadListBegin;
        ChannelObject.Color     := Reader.ReadInteger;
        ChannelObject.LineStyle := TiChannelLineStyle(Reader.ReadInteger);
        ChannelObject.LineWidth := Reader.ReadInteger;
      Reader.ReadListEnd
    end;
  if FChannelList.Count <> 0 then FCursorChannel := 0;
  Reader.ReadListEnd;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.WriteChannels(Writer: TWriter);
var
  x             : Integer;
  ChannelObject : TiStripChartChannelObject;
begin
  Writer.WriteListBegin;
  for x := 0 to FChannelList.Count - 1 do
    begin
      ChannelObject := FChannelList.Objects[x] as TiStripChartChannelObject;
      Writer.WriteString (ChannelObject.Title);
      Writer.WriteListBegin;
        Writer.WriteInteger(ChannelObject.Color);
        Writer.WriteInteger(Integer(ChannelObject.LineStyle));
        Writer.WriteInteger(ChannelObject.LineWidth);
      Writer.WriteListEnd;
    end;
  Writer.WriteListEnd;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ClearData;
var
  x : Integer;
begin
  FMinXAxisData   := 0;
  FMaxXAxisData   := 0;
  FMinYAxisData   := 0;
  FMaxYAxisData   := 0;
  FPlotStartIndex := -1;
  FPlotStopIndex  := -1;
  FFirstDataPoint := True;
  FCursorIndex    := 0;

  FIndexList.Clear;
  for x := 0 to FChannelList.Count - 1 do
    begin
      GetChannel(x).DataClear;
      GetChannel(x).HighestIndex := - 1;
    end;

  for x := 0 to FLabelChannelList.Count - 1 do
    GetLabelChannel(x).LabelList.Clear;

  InvalidateChange;
  DoDataUpdate;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelDataIsNull(Channel, Index: Integer; var Data: Double): Boolean;
begin
  Data := GetChannel(Channel).GetDataItem(GetActualTimeIndex(Index), Result);
end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelDataStatus(Channel, Index: Integer): TiChannelDataSatus;
begin
  Result := GetChannel(Channel).GetDataStatus(GetActualTimeIndex(Index));
end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelData(Channel, Index: Integer): Double;
var                           
  DataIsNull : Boolean;
begin
  Result := GetChannel(Channel).GetDataItem(GetActualTimeIndex(Index), DataIsNull);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetChannelData(Channel, Index: Integer; const Value: Double);
var
  iChannelObject     : TiStripChartChannelObject;
  HighestIndex       : Integer;
  HighestValue       : Double;
  RangeCount         : Integer;
  StepValue          : Double;
  x                  : Integer;
  ActualIndex        : Integer;
  MinorRange         : Double;
  DataIsNull         : Boolean;
  NeedsInterpolation : Boolean;
begin
  if (Channel < 0) or (Channel > (FChannelList.Count-1)) then raise Exception.Create('Channel Index out of Bounds');

  ActualIndex := GetActualTimeIndex(Index);

  iChannelObject := GetChannel(Channel);
  HighestIndex   := iChannelObject.HighestIndex;
  if HighestIndex = - 1 then
    begin
      HighestValue := 0;
      DataIsNull   := True;
    end
  else HighestValue := iChannelObject.GetDataItem(HighestIndex, DataIsNull);

  NeedsInterpolation := True;


  if not FInterpolateMissingDataPoints   then NeedsInterpolation := False;
  if     ActualIndex <= (HighestIndex+1) then NeedsInterpolation := False;
  if     DataIsNull                      then NeedsInterpolation := False;
  if     HighestIndex = - 1              then NeedsInterpolation := False;

  if NeedsInterpolation then
    begin
      RangeCount := ActualIndex - HighestIndex;
      StepValue  := (Value - HighestValue)/RangeCount;

      for x := 1 to RangeCount-1 do
        iChannelObject.SetDataItem(HighestIndex + x, HighestValue + (StepValue * x), icdsInterpolated);

      iChannelObject.SetDataItem(ActualIndex, Value, icdsActual);
    end
  else
    iChannelObject.SetDataItem(ActualIndex, Value, icdsActual);

  if FFirstDataPoint then
    begin
      FMinYAxisData   := Value;
      FMaxYAxisData   := Value;
      FFirstDataPoint := False;
    end
  else
    begin
      if Value < FMinYAxisData then FMinYAxisData := Value;
      if Value > FMaxYAxisData then FMaxYAxisData := Value;
    end;

  if FAutoScaleEnabled and (FToolBarMode = iscmPlot) then
    begin
      MinorRange := (YAxisMax - YAxisMin)/(YAxisTickMajorCount - 1)/(YAxisTickMinorCount+1);
      if FAutoScaleHysterisis = 0 then
        begin
          if FAutoScaleMaxAdjustEnabled then if FMaxYAxisData > (FYAxisMax - MinorRange) then YAxisMax := FMaxYAxisData + MinorRange;
          if FAutoScaleMinAdjustEnabled then if (FMinYAxisData - MinorRange) < FYAxisMin then YAxisMin := FMinYAxisData - MinorRange;
        end
      else
        begin
          if FAutoScaleMaxAdjustEnabled then if FMaxYAxisData > (FYAxisMax - MinorRange) then YAxisMax := FMaxYAxisData + FAutoScaleHysterisis;
          if FAutoScaleMinAdjustEnabled then if (FMinYAxisData - MinorRange) < FYAxisMin then YAxisMin := FMinYAxisData - FAutoScaleHysterisis;
        end;
    end;
  InvalidateChange;

  DoDataUpdate;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetBufferSize(Value: Integer);
var
  x : Integer;
begin
  FIndexList.SetCapacity(Value);

  for x := 0 to FChannelList.Count - 1 do
    GetChannel(x).SetBufferSize(Value);
end;
//****************************************************************************************************************************************************
function TiStripChart.AddIndexTime(Time: Double): Integer;
var
  x, y         : Integer;
  OldIndexTime : Double;
begin
  if FIndexList.Count > 0 then if Time < FIndexList.Item[FIndexList.Count-1]
    then raise Exception.Create('Time indexes must be incremental');

  if (FMaxBufferSize <> 0) and (FMinBufferSize <> 0) and (FMaxBufferSize > FMinBufferSize) and (not FIndexList.UseRingBuffer) then
    begin
      if FIndexList.Count > FMaxBufferSize then
        begin
          FIndexList.DeleteRange(FMaxBufferSize - FMinBufferSize);
          for x := 0 to FChannelList.Count - 1 do
            begin
              GetChannel(x).DataDeleteRange(FMaxBufferSize - FMinBufferSize);
              if GetChannel(x).HighestIndex > (FIndexList.Count -1) then GetChannel(x).HighestIndex := FIndexList.Count -1;
            end;
          for x := 0 to FLabelChannelList.Count - 1 do
            for y := 1 to (FMaxBufferSize - FMinBufferSize) do
              GetLabelChannel(x).LabelList.Delete(0);
          FCursorIndex := FCursorIndex - (FMaxBufferSize - FMinBufferSize);
          if FCursorIndex < 0 then FCursorIndex := 0;
          BackGroundChange;
        end;
    end;

  if FIndexList.UseRingBuffer then
    begin
      if (FCursorIndex > 0) and (FCursorIndex < FIndexList.Count) then
        begin
          OldIndexTime := FIndexList.Item[FCursorIndex];
          FIndexList.Add(Time);
          FCursorIndex := CalcIndex(OldIndexTime);
        end
      else FIndexList.Add(Time);
    end
  else FIndexList.Add(Time);

  for x := 0 to FChannelList.Count - 1 do
    GetChannel(x).DataAdd(0);

  for x := 0 to FLabelChannelList.Count - 1 do
    GetLabelChannel(x).LabelList.Add('');

  if not UpdateActive then
    begin
      CalcNewStartXIndex;
      CalcNewStopXIndex;
    end;

  if FAutoScrollEnabled and (FToolBarMode = iscmPlot) then DoAutoScroll(Time);

  Result := FIndexList.Count-1;
end;
//****************************************************************************************************************************************************
function TiStripChart.AddIndexTimeNow: Integer;
begin
  Result := AddIndexTime(Now);
end;
//****************************************************************************************************************************************************
function TiStripChart.AddIndexTimeElapsedNow: Integer;
begin
  if FXAxisDateTimeEnabled then
    Result := AddIndexTime(Now - FElapsedStartTime)
  else
    Result := AddIndexTime((Now - FElapsedStartTime)*60*60*24);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DoAutoScroll(Time: Double);
begin
  if (FIndexList.Count = 1) then
    begin
      case FAutoScrollFirstStyle of
        iasfsAuto         : if (Time < FXAxisMin) or (Time > FXAxisMax) then SetXAxisMinMax(Time, Time + (FXAxisMax - FXAxisMin));
        iasfsLeftJustify  :                                                  SetXAxisMinMax(Time, Time + (FXAxisMax - FXAxisMin));
        iasfsRightJustify :                                                  SetXAxisMinMax(Time - (FXAxisMax - FXAxisMin), Time );
      end;
      exit;
    end;

  if (Time > FXAxisMax) or ((FAutoScrollType = iasSmoothOffset) and (Time > FXAxisMax-FAutoScrollStepSize)) then
    begin
      case FAutoScrollType of
        iasSmooth       : ScrollXAxis(Time-FXAxisMax);
        iasStep         : ScrollXAxis(FAutoScrollStepSize);
        iasPage         : ScrollXAxis(FXAxisMax-FXAxisMin);
        iasSmoothOffset : ScrollXAxis(Time-FXAxisMax+FAutoScrollStepSize);
      end;
    end
  else if Time < FXAxisMin then ScrollXAxis(Time-FXAxisMin);
end;
//****************************************************************************************************************************************************
function TiStripChart.GetIndexCount: Integer;
begin
  Result := FIndexList.Count;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetIndexTime(Index: Integer): Double;
begin
  Result := FIndexList.Item[GetActualTimeIndex(Index)];
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ScrollXAxis(Value: Double);
begin
  XAxisMin := XAxisMin + Value;
  XAxisMax := XAxisMax + Value;
  InvalidateChange
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ScrollYAxis(Value: Double);
begin
  YAxisMin := YAxisMin + Value;
  YAxisMax := YAxisMax + Value;
  BackGroundChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ZoomXAxis(Value: Double);
var
  NewRange : Double;
  CenterX  : Double;
begin
  NewRange := (FXAxisMax - FXAxisMin) * (Value);
  CenterX  :=  (FXAxisMax + FXAxisMin)/2;
  if NewRange <> 0 then
    begin
      XAxisMin := CenterX - NewRange/2;
      XAxisMax := XAxisMin + NewRange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetXAxisMinMax(Min, Max: Double);
begin
  XAxisMin := Min;
  XAxisMax := Max;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetYAxisMinMax(Min, Max: Double);
begin
  YAxisMin := Min;
  YAxisMax := Max;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ZoomYAxis(Value: Double);
var
  NewRange : Double;
  CenterY  : Double;
begin
  NewRange := (FYAxisMax - FYAxisMin) * (Value);
  CenterY  := (FYAxisMax + FYAxisMin)/2;
  if NewRange <> 0 then
    begin
      YAxisMin := CenterY - NewRange/2;
      YAxisMax := YAxisMin + NewRange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.CalcNewStartXIndex;
var
  TargetValue : Double;
  MinIndex    : Integer;
  MaxIndex    : Integer;
  MiddleIndex : Integer;
  MiddleValue : Double;
begin
  FPlotStartIndex := -1;

  MinIndex    := 0;
  MaxIndex    := FIndexList.Count - 1;
  TargetValue := FXAxisMin;

  if MaxIndex < 0                            then exit;
  if TargetValue > FIndexList.Item[MaxIndex] then exit;

  while MinIndex < MaxIndex do
    begin
      MiddleIndex := Round((MinIndex + MaxIndex)/2);
      MiddleValue := FIndexList.Item[MiddleIndex];

      if MiddleValue = TargetValue then
        begin
          FPlotStartIndex := MiddleIndex;
          exit;
        end
      else if MiddleValue > TargetValue then MaxIndex := MiddleIndex - 1
      else MinIndex := MiddleIndex + 1;
    end;

   if MinIndex <= 0 then
     begin
       FPlotStartIndex := 0;
       exit;
     end;

   if MinIndex >= FIndexList.Count then
     begin
       FPlotStartIndex := FIndexList.Count-1;
       exit;
     end;

   if FIndexList.Item[MinIndex] <= TargetValue then FPlotStartIndex := MinIndex
     else FPlotStartIndex := MinIndex - 1;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.CalcNewStopXIndex;
var
  TargetValue : Double;
  MinIndex    : Integer;
  MaxIndex    : Integer;
  MiddleIndex : Integer;
  MiddleValue : Double;
begin
  FPlotStopIndex := -1;

  MinIndex    := 0;
  MaxIndex    := FIndexList.Count - 1;
  TargetValue := FXAxisMax;

  if MaxIndex    < 0                         then exit;
  if TargetValue < FIndexList.Item[MinIndex] then exit;

  while MinIndex < MaxIndex do
    begin
      MiddleIndex := Round((MinIndex + MaxIndex)/2);
      MiddleValue := FIndexList.Item[MiddleIndex];

      if MiddleValue = TargetValue then
        begin
          FPlotStopIndex := MiddleIndex;
          exit;
        end
      else if MiddleValue < TargetValue then MinIndex := MiddleIndex + 1
      else MaxIndex := MiddleIndex - 1;
    end;

   if MinIndex <= 0 then
     begin
       FPlotStopIndex := 0;
       exit;
     end;

   if MinIndex >= (FIndexList.Count-1) then
     begin
       FPlotStopIndex := FIndexList.Count-1;
       exit;
     end;

   if FIndexList.Item[MinIndex] >= TargetValue then FPlotStopIndex := MinIndex
     else FPlotStopIndex := MinIndex + 1;
end;
//****************************************************************************************************************************************************
function TiStripChart.CalcIndex(TargetValue: Double): Integer;
var
  MinIndex    : Integer;
  MaxIndex    : Integer;
  MiddleIndex : Integer;
  MiddleValue : Double;
begin
  MinIndex    := 0;
  MaxIndex    := FIndexList.Count - 1;

  if MaxIndex = -1                           then begin Result := MinIndex; exit; end;
  if TargetValue < FIndexList.Item[MinIndex] then begin Result := MinIndex; exit; end;
  if TargetValue > FIndexList.Item[MaxIndex] then begin Result := MaxIndex; exit; end;

  while MinIndex <= MaxIndex do
    begin
      MiddleIndex := Round((MinIndex + MaxIndex)/2);
      MiddleValue := FIndexList.Item[MiddleIndex];

      if MiddleValue = TargetValue then
        begin
          Result := MiddleIndex;
          exit;
        end
      else if MiddleValue < TargetValue then MinIndex := MiddleIndex + 1
      else                                   MaxIndex := MiddleIndex - 1;
    end;

   if MinIndex >= (FIndexList.Count-1) then
     begin
       Result := FIndexList.Count-1;
       exit;
     end;

   if MinIndex <= 0 then
     begin
       Result := 0;
       exit;
     end;

   if FIndexList.Item[MinIndex] >= TargetValue then Result := MinIndex
     else Result := MinIndex + 1;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DoCursorChange;
begin
  if not Loading then if Assigned(FOnCursorChange) then FOnCursorChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DoDataUpdate;
begin
  if UpdateActive then FNeedsDataUpdate := True
    else if Assigned(FOnDataUpdate) then FOnDataUpdate(Self);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.DoModeChange;
begin
  if not Loading then if Assigned(FOnModeChange) then FOnModeChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ReadXAxisMax(Reader: TReader);
begin
  FXAxisMax := Reader.ReadFloat;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ReadYAxisMax(Reader: TReader);
begin
  FYAxisMax := Reader.ReadFloat;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.WriteXAxisMax(Writer: TWriter);
begin
  Writer.WriteFloat(FXAxisMax);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.WriteYAxisMax(Writer: TWriter);
begin
  Writer.WriteFloat(FYAxisMax);
end;
//****************************************************************************************************************************************************
//Kylix TODO
{$ifndef iCLX}
procedure TiStripChart.PrintChart;
var
  ScaleX            : Double;
  ScaleY            : Double;
  MaxZoom           : Double;

  ADevice           : Array[0..255] of Char;
  ADriver           : Array[0..255] of Char;
  APort             : Array[0..255] of Char;
  DeviceHandle      : THandle;
  DevMode           : PDeviceMode;
  XPixelsPerInch    : Integer;
  YPixelsPerInch    : Integer;

  CommentListStartY : Integer;
  CommentHeight     : Integer;
  x                 : Integer;
  PrintDialog       : TPrintDialog;
begin
  Printer.Orientation := FPrinterOrientation;
  if FPrinterShowDialog then
    begin
      PrintDialog := TPrintDialog.Create(Self);
      try
        if not PrintDialog.Execute then exit;
      finally
        PrintDialog.Free;
      end;
    end;

  Printer.GetPrinter(ADevice, ADriver, APort, DeviceHandle);
  if DeviceHandle = 0 then
    begin
      Printer.PrinterIndex := Printer.PrinterIndex;
      Printer.GetPrinter(ADevice, ADriver, APort, DeviceHandle);
    end;
  if DeviceHandle = 0 then raise Exception.Create('Could not initialize printer DeviceMode Structure');
  DevMode := GlobalLock(DeviceHandle);
  try
    with DevMode^ do
      begin
        case dmPaperSize of
          DMPAPER_LETTER : begin
                             XPixelsPerInch := Round(1/ 8.5 * Printer.PageWidth);
                             YPixelsPerInch := Round(1/11.0 * Printer.PageHeight);
                           end;
          DMPAPER_LEGAL  : begin
                             XPixelsPerInch := Round(1/ 8.5 * Printer.PageWidth);
                             YPixelsPerInch := Round(1/14.0 * Printer.PageHeight);
                           end;
          else             begin
                             XPixelsPerInch := Round(1/ 8.5 * Printer.PageWidth);
                             YPixelsPerInch := Round(1/11.0 * Printer.PageHeight);
                           end;

        end;
      end;
  finally
    GlobalUnlock(DeviceHandle);
  end;

  Printer.BeginDoc;
  try
    ScaleX := (Printer.PageWidth  - FPrinterMarginLeft*XPixelsPerInch - FPrinterMarginRight *XPixelsPerInch ) / Width;
    ScaleY := (Printer.PageHeight - FPrinterMarginTop *YPixelsPerInch - FPrinterMarginBottom*YPixelsPerInch) / Height;
    if ScaleX < ScaleY then MaxZoom := ScaleX else MaxZoom := ScaleY;

    Printer.Canvas.StretchDraw(Rect(Round(FPrinterMarginLeft*XPixelsPerInch),
                                    Round(FPrinterMarginTop*YPixelsPerInch),
                                    Round(FPrinterMarginLeft*XPixelsPerInch + MaxZoom * Width),
                                    Round(FPrinterMarginTop*YPixelsPerInch  + MaxZoom * Height)),GetSnapShotPicture.Metafile);

    Printer.Canvas.Font.Assign(FPrinterCommentLinesFont);
    CommentHeight     := Printer.Canvas.TextHeight('ABC');
    CommentListStartY := Round(FPrinterMarginTop*YPixelsPerInch) + Round(MaxZoom * Height) + Round(FPrinterCommentLineSpacing * CommentHeight);

    for x := 0 to FPrinterCommentList.Count - 1 do
     begin
       Printer.Canvas.TextOut(Round(FPrinterMarginLeft*XPixelsPerInch),
                              CommentListStartY + Round((CommentHeight + CommentHeight*FPrinterCommentLineSpacing) * x),
                              FPrinterCommentList.Strings[x]);
     end;

  finally
    Printer.EndDoc;
  end;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiStripChart.PrinterAddCommentLine(Value: String);
begin
  FPrinterCommentList.Add(Value);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.PrinterClearCommentLines;
begin
  FPrinterCommentList.Clear;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetPrinterCommentLinesFont(const Value: TFont);
begin
  FPrinterCommentLinesFont.Assign(Value);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  Result := 0;
  if HasFocus then if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  case CharCode of
    VK_LEFT  : case FToolBarMode of
                 iscmCursor   : begin CursorIndex := CursorIndex - 1;                                                              CharCode := 0; end;
                 iscmScrollX  : begin ScrollXAxis(-(FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1)/(FXAxisTickMajorCount + 1)); CharCode := 0; end;
                 iscmScrollXY : begin ScrollXAxis(-(FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1)/(FXAxisTickMajorCount + 1)); CharCode := 0; end;
               end;
    VK_DOWN  : case FToolBarMode of
                 iscmCursor   : begin CursorIndex := CursorIndex - 1;                                                              CharCode := 0; end;
                 iscmScrollY  : begin ScrollYAxis(-(FYAxisMax - FYAxisMin)/(FYAxisTickMajorCount - 1)/(FYAxisTickMajorCount + 1)); CharCode := 0; end;
                 iscmScrollXY : begin ScrollYAxis(-(FYAxisMax - FYAxisMin)/(FYAxisTickMajorCount - 1)/(FYAxisTickMajorCount + 1)); CharCode := 0; end;
               end;
    VK_RIGHT : case FToolBarMode of
                 iscmCursor   : begin CursorIndex := CursorIndex + 1;                                                              CharCode := 0; end;
                 iscmScrollX  : begin ScrollXAxis((FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1)/(FXAxisTickMajorCount + 1));  CharCode := 0; end;
                 iscmScrollXY : begin ScrollXAxis((FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1)/(FXAxisTickMajorCount + 1));  CharCode := 0; end;
               end;
    VK_UP    : case FToolBarMode of
                 iscmCursor   : begin CursorIndex := CursorIndex + 1;                                                              CharCode := 0; end;
                 iscmScrollY  : begin ScrollYAxis((FYAxisMax - FYAxisMin)/(FYAxisTickMajorCount - 1)/(FYAxisTickMajorCount + 1));  CharCode := 0; end;
                 iscmScrollXY : begin ScrollYAxis((FYAxisMax - FYAxisMin)/(FYAxisTickMajorCount - 1)/(FYAxisTickMajorCount + 1));  CharCode := 0; end;
               end;
    VK_PRIOR : case FToolBarMode of
                 iscmCursor   : begin CursorIndex := CursorIndex + (FPlotStopIndex - FPlotStartIndex);                             CharCode := 0; end;
                 iscmScrollX  : begin ScrollXAxis((FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));                             CharCode := 0; end;
                 iscmScrollXY : begin ScrollXAxis((FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));                             CharCode := 0; end;
                 iscmScrollY  : begin ScrollYAxis((FYAxisMax - FYAxisMin)/(FYAxisTickMajorCount - 1));                             CharCode := 0; end;
               end;
    VK_NEXT  : case FToolBarMode of
                 iscmCursor   : begin CursorIndex := CursorIndex - (FPlotStopIndex - FPlotStartIndex);                             CharCode := 0; end;
                 iscmScrollX  : begin ScrollXAxis(-(FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));                            CharCode := 0; end;
                 iscmScrollXY : begin ScrollXAxis(-(FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));                            CharCode := 0; end;
                 iscmScrollY  : begin ScrollYAxis(-(FYAxisMax - FYAxisMin)/(FYAxisTickMajorCount - 1));                            CharCode := 0; end;
               end;
    VK_HOME  : case FToolBarMode of
                 iscmCursor   : begin CursorIndex := 0;                                                                            CharCode := 0; end;
                 iscmScrollX  : begin CursorIndex := 0;                                                                            CharCode := 0; end;
                 iscmScrollXY : begin CursorIndex := 0;                                                                            CharCode := 0; end;
               end;
    VK_END   : case FToolBarMode of
                 iscmCursor   : begin CursorIndex := FIndexList.Count -1;                                                          CharCode := 0; end;
                 iscmScrollX  : begin CursorIndex := FIndexList.Count -1;                                                          CharCode := 0; end;
                 iscmScrollXY : begin CursorIndex := FIndexList.Count -1;                                                          CharCode := 0; end;
               end;
  end;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ScrollCursorInView;
begin
  if (FCursorIndex < 0) or (FCursorIndex > FIndexList.Count - 1) then exit;

  if FCursorIndex < FPlotStartIndex then ScrollXAxis(FIndexList.Item[FCursorIndex] - FXAxisMin);
  if FCursorIndex > FPlotStopIndex  then ScrollXAxis(FIndexList.Item[FCursorIndex] - FXAxisMax);

  if (FCursorIndex = FPlotStartIndex) and (FIndexList.Item[FPlotStartIndex] = FXAxisMin)
    then ScrollXAxis(-(FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));
  while FIndexList.Item[FCursorIndex] <= FXAxisMin do ScrollXAxis(-(FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));

  if (FCursorIndex = FPlotStopIndex ) and (FIndexList.Item[FPlotStopIndex] = FXAxisMax)
    then ScrollXAxis((FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));
  while FIndexList.Item[FCursorIndex] >= FXAxisMax do ScrollXAxis((FXAxisMax - FXAxisMin)/(FXAxisTickMajorCount - 1));
end;
//****************************************************************************************************************************************************
function TiStripChart.GetXAxisDecimalPoints: Integer;
var
  Multiplier : Integer;
begin
  Result := 0;
  case FPrecisionStyle of
    ipsSignificantDigits : if FXAxisLabelPrecision > 0 then
                             begin
                               Multiplier := 0;
                               if FXAxisMax <> FXAxisMin then
                                 begin
                                   while IntToStr(ABS(Trunc((FXAxisMax - FXAxisMin)*Power(10, Multiplier)))) = '0' do
                                     Inc(Multiplier);
                                 end;

                               Result := FXAxisLabelPrecision - Length(IntToStr(ABS(Trunc((FXAxisMax - FXAxisMin)*Power(10, Multiplier))))) + Multiplier;
                               if Result < 0 then Result := 0;
                             end;
    ipsFixedDecimalPoints : Result := FXAxisLabelPrecision;
  end;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetYAxisDecimalPoints: Integer;
var
  Multiplier : Integer;
begin
  Result := 0;
  case FPrecisionStyle of
    ipsSignificantDigits  : if FYAxisLabelPrecision > 0 then
                              begin
                                Multiplier := 0;
                                if FYAxisMax <> FYAxisMin then
                                  begin
                                    while IntToStr(ABS(Trunc((FYAxisMax - FYAxisMin)*Power(10, Multiplier)))) = '0' do
                                      Inc(Multiplier);
                                  end;

                                Result := FYAxisLabelPrecision - Length(IntToStr(ABS(Trunc((FYAxisMax - FYAxisMin)*Power(10, Multiplier))))) + Multiplier;
                                if Result < 0 then Result := 0;
                              end;
    ipsFixedDecimalPoints : Result := FYAxisLabelPrecision;
  end;
end;
//****************************************************************************************************************************************************
//Kylix TODO
{$ifndef iCLX}
procedure TiStripChart.SaveToMetaFile(FileName: String);
var
  MetaFileCanvas : TMetaFileCanvas;
begin
  if not Assigned(FMetaFile) then FMetaFile := TMetaFile.Create;

  FMetaFile.Width    := Width;
  FMetaFile.Height   := Height;
  FMetaFile.Enhanced := True;

  MetaFileCanvas := TMetafileCanvas.CreateWithComment(FMetaFile, 0{Canvas.Handle}, 'Iocomp', 'Strip Chart');
  try
    iPaintTo(MetaFileCanvas);
  finally
    MetaFileCanvas.Free;
  end;
  FMetaFile.SaveToFile(FileName);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SaveToBitmap(FileName: String);
var
  Bitmap : TBitmap;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap.Width  := Width;
    Bitmap.Height := Height;

    iPaintTo(Bitmap.Canvas);

    Bitmap.SaveToFile(FileName);
  finally
    Bitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetSnapShotPicture: TPicture;
var
  MetaFileCanvas : TMetaFileCanvas;
begin
  if not Assigned(FSnapShotPicture) then FSnapShotPicture := TPicture.Create;
  if not Assigned(FMetaFile) then FMetaFile := TMetaFile.Create;

  FMetaFile.Width := Width;
  FMetaFile.Height := Height;

  MetaFileCanvas := TMetafileCanvas.CreateWithComment(FMetaFile, 0, 'Iocomp', 'Strip Chart');
  try
    iPaintTo(MetaFileCanvas);
  finally
    MetaFileCanvas.Free;
  end;
  FSnapShotPicture.Graphic := FMetaFile;

  Result := FSnapShotPicture;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiStripChart.SetChannelDataNull(Channel, Index: Integer);
begin
  GetChannel(Channel).SetDataItem(GetActualTimeIndex(Index), 0, icdsNull);
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetChannelsData(Index: Integer; Data: Variant);
var
  x         : Integer;
  LowBound  : Integer;
  HighBound : Integer;
begin
  if VarArrayDimCount(Data) <> 1                       then raise Exception.Create('Array must be 1 dimensional');
  LowBound  := VarArrayLowBound(Data, 1);
  HighBound := VarArrayHighBound(Data, 1);
  if LowBound <> 0                                     then raise Exception.Create('Low element does not start at 0');
  if (HighBound - LowBound) > (FChannelList.Count - 1) then raise Exception.Create('Number of data points exceed the number of Channels');
  for x := 0 to HighBound do
    ChannelData[x, Index] := Data[x];
end;
//****************************************************************************************************************************************************
//Kylix TODO
{$ifndef iCLX}
procedure TiStripChart.CopyToClipBoard;
var
  MetaFileCanvas : TMetaFileCanvas;
begin
  if not Assigned(FMetaFile) then FMetaFile := TMetaFile.Create;

  FMetaFile.Width := Width;
  FMetaFile.Height := Height;

  MetaFileCanvas := TMetafileCanvas.CreateWithComment(FMetaFile, 0, 'Iocomp', 'Strip Chart');
  try
    iPaintTo(MetaFileCanvas);
  finally
    MetaFileCanvas.Free;
  end;
  Clipboard.Assign(FMetaFile);
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiStripChart.ResetElapsedStartTime;
begin
  FElapsedStartTime := Now;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetLabelChannelText(Channel, Index: Integer): String;
begin
  Result := GetLabelChannel(Channel).LabelList.Strings[GetActualTimeIndex(Index)];
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetLabelChannelText(Channel, Index: Integer; const Value: String);
begin
  GetLabelChannel(Channel).LabelList.Strings[GetActualTimeIndex(Index)] := Value;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetLabelYPosition           (Index:Integer):Double; begin Result:=GetLabelChannel(Index).YPosition;                end;
function TiStripChart.GetLabelChannelFontName     (Index:Integer):String; begin Result:=GetLabelChannel(Index).Font.Name;                end;
function TiStripChart.GetLabelChannelFontSize     (Index:Integer):Integer;begin Result:=GetLabelChannel(Index).Font.Size;                end;
function TiStripChart.GetLabelChannelFontColor    (Index:Integer):TColor ;begin Result:=GetLabelChannel(Index).Font.Color;               end;
function TiStripChart.GetLabelChannelFontBold     (Index:Integer):Boolean;begin Result:=fsBold      in GetLabelChannel(Index).Font.Style;end;
function TiStripChart.GetLabelChannelFontItalic   (Index:Integer):Boolean;begin Result:=fsItalic    in GetLabelChannel(Index).Font.Style;end;
function TiStripChart.GetLabelChannelFontUnderLine(Index:Integer):Boolean;begin Result:=fsUnderline in GetLabelChannel(Index).Font.Style;end;
function TiStripChart.GetLabelChannelFontStrikeOut(Index:Integer):Boolean;begin Result:=fsStrikeOut in GetLabelChannel(Index).Font.Style;end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetLabelYPosition       (Index:Integer;const Value:Double );begin GetLabelChannel(Index).YPosition :=Value;InvalidateChange;end;
procedure TiStripChart.SetLabelChannelFontName (Index:Integer;const Value:String );begin GetLabelChannel(Index).Font.Name :=Value;InvalidateChange;end;
procedure TiStripChart.SetLabelChannelFontSize (Index:Integer;const Value:Integer);begin GetLabelChannel(Index).Font.Size :=Value;InvalidateChange;end;
procedure TiStripChart.SetLabelChannelFontColor(Index:Integer;const Value:TColor );begin GetLabelChannel(Index).Font.Color:=Value;InvalidateChange;end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetLabelChannelFontBold(Index: Integer; const Value: Boolean);
begin
  if Value then GetLabelChannel(Index).Font.Style := GetLabelChannel(Index).Font.Style + [fsBold]
    else  GetLabelChannel(Index).Font.Style := GetLabelChannel(Index).Font.Style - [fsBold];
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetLabelChannelFontItalic(Index: Integer; const Value: Boolean);
begin
  if Value then GetLabelChannel(Index).Font.Style := GetLabelChannel(Index).Font.Style + [fsItalic]
    else  GetLabelChannel(Index).Font.Style := GetLabelChannel(Index).Font.Style - [fsItalic];
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetLabelChannelFontUnderLine(Index: Integer; const Value: Boolean);
begin
  if Value then GetLabelChannel(Index).Font.Style := GetLabelChannel(Index).Font.Style + [fsUnderline]
    else  GetLabelChannel(Index).Font.Style := GetLabelChannel(Index).Font.Style - [fsUnderline];
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetLabelChannelFontStrikeOut(Index: Integer; const Value: Boolean);
begin
  if Value then GetLabelChannel(Index).Font.Style := GetLabelChannel(Index).Font.Style + [fsStrikeOut]
    else  GetLabelChannel(Index).Font.Style := GetLabelChannel(Index).Font.Style - [fsStrikeOut];
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiStripChart.ChannelColorInUse(Value : TColor): Boolean;
var
  x : Integer;
begin
  Result := False;
  for x := 0 to FChannelList.Count - 1 do
    if GetChannel(x).Color = Value then
      begin
        Result := True;
        Exit;
      end;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetNextChannelColor: TColor;
begin
  if      not ChannelColorInUse(clRed)     then Result := clRed
  else if not ChannelColorInUse(clYellow)  then Result := clYellow
  else if not ChannelColorInUse(clBlue)    then Result := clBlue
  else if not ChannelColorInUse(clFuchsia) then Result := clFuchsia
  else if not ChannelColorInUse(clAqua)    then Result := clAqua
  else if not ChannelColorInUse(clLime)    then Result := clLime
  else if not ChannelColorInUse(clWhite)   then Result := clWhite

  else if not ChannelColorInUse($000080)   then Result := $000080
  else if not ChannelColorInUse($008000)   then Result := $008000
  else if not ChannelColorInUse($008080)   then Result := $008080
  else if not ChannelColorInUse($800000)   then Result := $800000
  else if not ChannelColorInUse($800080)   then Result := $800080
  else if not ChannelColorInUse($808000)   then Result := $808000
  else if not ChannelColorInUse($808080)   then Result := $808080

  else if not ChannelColorInUse($0000C0)   then Result := $000080
  else if not ChannelColorInUse($00C000)   then Result := $008000
  else if not ChannelColorInUse($00C0C0)   then Result := $008080
  else if not ChannelColorInUse($C00000)   then Result := $800000
  else if not ChannelColorInUse($C000C0)   then Result := $800080
  else if not ChannelColorInUse($C0C000)   then Result := $808000
  else if not ChannelColorInUse($C0C0C0)   then Result := $808080

  else if not ChannelColorInUse($0080FF)   then Result := $000080
  else if not ChannelColorInUse($8000FF)   then Result := $008000
  else if not ChannelColorInUse($8080FF)   then Result := $008080
  else if not ChannelColorInUse($FF0080)   then Result := $800000
  else if not ChannelColorInUse($FF8000)   then Result := $800080
  else if not ChannelColorInUse($FF8080)   then Result := $808000
  else if not ChannelColorInUse($00FF80)   then Result := $808080
  else if not ChannelColorInUse($80FF00)   then Result := $808080
  else if not ChannelColorInUse($80FF80)   then Result := $808080
  else Result := clRed;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetNow: Double;
begin
  Result := Now;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetChannelControlLimitLowerColor    (Index:Integer;const Value:TColor);            begin GetChannel(Index).ControlLimitLowerColor    := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitLowerLineStyle(Index:Integer;const Value:TiChannelLineStyle);begin GetChannel(Index).ControlLimitLowerLineStyle:= Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitLowerShow     (Index:Integer;const Value:Boolean);           begin GetChannel(Index).ControlLimitLowerShow     := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitLowerValue    (Index:Integer;const Value:Double);            begin GetChannel(Index).ControlLimitLowerValue    := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitLowerColor    (Index:Integer;const Value:TColor);            begin GetChannel(Index).WarningLimitLowerColor    := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitLowerLineStyle(Index:Integer;const Value:TiChannelLineStyle);begin GetChannel(Index).WarningLimitLowerLineStyle:= Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitLowerShow     (Index:Integer;const Value:Boolean);           begin GetChannel(Index).WarningLimitLowerShow     := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitLowerValue    (Index:Integer;const Value:Double);            begin GetChannel(Index).WarningLimitLowerValue    := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitUpperColor    (Index:Integer;const Value:TColor);            begin GetChannel(Index).ControlLimitUpperColor    := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitUpperLineStyle(Index:Integer;const Value:TiChannelLineStyle);begin GetChannel(Index).ControlLimitUpperLineStyle:= Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitUpperShow     (Index:Integer;const Value:Boolean);           begin GetChannel(Index).ControlLimitUpperShow     := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitUpperValue    (Index:Integer;const Value:Double);            begin GetChannel(Index).ControlLimitUpperValue    := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitUpperColor    (Index:Integer;const Value:TColor);            begin GetChannel(Index).WarningLimitUpperColor    := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitUpperLineStyle(Index:Integer;const Value:TiChannelLineStyle);begin GetChannel(Index).WarningLimitUpperLineStyle:= Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitUpperShow     (Index:Integer;const Value:Boolean);           begin GetChannel(Index).WarningLimitUpperShow     := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitUpperValue    (Index:Integer;const Value:Double);            begin GetChannel(Index).WarningLimitUpperValue    := Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitLowerLineWidth(Index:Integer;const Value:Integer);           begin GetChannel(Index).ControlLimitLowerLineWidth:= Value;InvalidateChange;end;
procedure TiStripChart.SetChannelControlLimitUpperLineWidth(Index:Integer;const Value:Integer);           begin GetChannel(Index).ControlLimitUpperLineWidth:= Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitLowerLineWidth(Index:Integer;const Value:Integer);           begin GetChannel(Index).WarningLimitLowerLineWidth:= Value;InvalidateChange;end;
procedure TiStripChart.SetChannelWarningLimitUpperLineWidth(Index:Integer;const Value:Integer);           begin GetChannel(Index).WarningLimitUpperLineWidth:= Value;InvalidateChange;end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannelControlLimitLowerColor    (Index:Integer):TColor;            begin Result:=GetChannel(Index).ControlLimitLowerColor;    end;
function TiStripChart.GetChannelControlLimitLowerLineStyle(Index:Integer):TiChannelLineStyle;begin Result:=GetChannel(Index).ControlLimitLowerLineStyle;end;
function TiStripChart.GetChannelControlLimitLowerShow     (Index:Integer):Boolean;           begin Result:=GetChannel(Index).ControlLimitLowerShow;     end;
function TiStripChart.GetChannelControlLimitLowerValue    (Index:Integer):Double;            begin Result:=GetChannel(Index).ControlLimitLowerValue;    end;
function TiStripChart.GetChannelWarningLimitLowerColor    (Index:Integer):TColor;            begin Result:=GetChannel(Index).WarningLimitLowerColor;    end;
function TiStripChart.GetChannelWarningLimitLowerLineStyle(Index:Integer):TiChannelLineStyle;begin Result:=GetChannel(Index).WarningLimitLowerLineStyle;end;
function TiStripChart.GetChannelWarningLimitLowerShow     (Index:Integer):Boolean;           begin Result:=GetChannel(Index).WarningLimitLowerShow;     end;
function TiStripChart.GetChannelWarningLimitLowerValue    (Index:Integer):Double;            begin Result:=GetChannel(Index).WarningLimitLowerValue;    end;
function TiStripChart.GetChannelControlLimitUpperColor    (Index:Integer):TColor;            begin Result:=GetChannel(Index).ControlLimitUpperColor;    end;
function TiStripChart.GetChannelControlLimitUpperLineStyle(Index:Integer):TiChannelLineStyle;begin Result:=GetChannel(Index).ControlLimitUpperLineStyle;end;
function TiStripChart.GetChannelControlLimitUpperShow     (Index:Integer):Boolean;           begin Result:=GetChannel(Index).ControlLimitUpperShow;     end;
function TiStripChart.GetChannelControlLimitUpperValue    (Index:Integer):Double;            begin Result:=GetChannel(Index).ControlLimitUpperValue;    end;
function TiStripChart.GetChannelWarningLimitUpperColor    (Index:Integer):TColor;            begin Result:=GetChannel(Index).WarningLimitUpperColor;    end;
function TiStripChart.GetChannelWarningLimitUpperLineStyle(Index:Integer):TiChannelLineStyle;begin Result:=GetChannel(Index).WarningLimitUpperLineStyle;end;
function TiStripChart.GetChannelWarningLimitUpperShow     (Index:Integer):Boolean;           begin Result:=GetChannel(Index).WarningLimitUpperShow;     end;
function TiStripChart.GetChannelWarningLimitUpperValue    (Index:Integer):Double;            begin Result:=GetChannel(Index).WarningLimitUpperValue;    end;
function TiStripChart.GetChannelControlLimitLowerLineWidth(Index:Integer):Integer;           begin Result:=GetChannel(Index).ControlLimitLowerLineWidth;end;
function TiStripChart.GetChannelControlLimitUpperLineWidth(Index:Integer):Integer;           begin Result:=GetChannel(Index).ControlLimitUpperLineWidth;end;
function TiStripChart.GetChannelWarningLimitLowerLineWidth(Index:Integer):Integer;           begin Result:=GetChannel(Index).WarningLimitLowerLineWidth;end;
function TiStripChart.GetChannelWarningLimitUpperLineWidth(Index:Integer):Integer;           begin Result:=GetChannel(Index).WarningLimitUpperLineWidth;end;
//****************************************************************************************************************************************************
function TiStripChart.GetChannel(Index: Integer): TiStripChartChannelObject;
begin
  if (Index < 0) or (Index > (FChannelList.Count-1)) then raise Exception.Create('Channel Index out of Bounds');
  Result := (FChannelList.Objects[Index] as TiStripChartChannelObject);
end;
//****************************************************************************************************************************************************
function TiStripChart.GetLabelChannel(Index: Integer): TiLabelChannelObject;
begin
  if (Index < 0) or (Index > (FLabelChannelList.Count-1)) then raise Exception.Create('Label Channel Index out of Bounds');
  Result := (FLabelChannelList.Objects[Index] as TiLabelChannelObject);
end;
//****************************************************************************************************************************************************
procedure TiStripChart.AddData(Interval: Double; Data: Variant);
var
  Channel         : Integer;
  DataRow         : Integer;
  LowBoundDim1    : Integer;
  LowBoundDim2    : Integer;
  HighBoundDim1   : Integer;
  HighBoundDim2   : Integer;
  TimeStamp       : Double;
  TimeIndex       : Integer;
  IntervalSeconds : Double;
begin
  if VarArrayDimCount(Data) <> 2  then raise Exception.Create('Array must be 2 dimensional');

  LowBoundDim1  := VarArrayLowBound (Data, 1);
  LowBoundDim2  := VarArrayLowBound (Data, 2);
  HighBoundDim1 := VarArrayHighBound(Data, 1);
  HighBoundDim2 := VarArrayHighBound(Data, 2);

  if FXAxisDateTimeEnabled then
    begin
      IntervalSeconds := Interval*TIME_SECOND;
      if FIndexList.Count = 0 then TimeStamp := Now else TimeStamp := FIndexList.Item[FIndexList.Count - 1];
    end
  else
    begin
      IntervalSeconds := Interval;
      if FIndexList.Count = 0 then TimeStamp := 0 else TimeStamp := FIndexList.Item[FIndexList.Count - 1];
    end;

  for DataRow := LowBoundDim2 to HighBoundDim2 do
    begin
      TimeIndex := AddIndexTime(TimeStamp + (DataRow + 1)*IntervalSeconds);
      for Channel := LowBoundDim1 to HighBoundDim1 do
        SetChannelData(Channel, TimeIndex, Data[Channel, DataRow]);
  end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
function TiStripChart.GetActualTimeIndex(Value: Integer): Integer;
begin
  if Value = - 1 then
    begin
      Result := FIndexList.Count-1;
    end
  else
    begin
      Result := Value;
      if (Result < 0) or (Result > (FIndexList.Count-1)) then raise Exception.Create('Time Index out of Bounds');
    end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SaveToXMLFile(FileName: String);
var
  FileStream : TiXMLMemoryStream;
  x          : Integer;
  Channel    : Integer;
begin
  FileStream := TiXMLMemoryStream.Create;
  try
    with FileStream do
      begin
        StartElement('IocompStripChartData');
        for x := 0 to FXMLCommentList.Count - 1 do
          WriteStringCRLF(FXMLCommentList.Strings[x]);

        WriteElement('ChannelCount', IntToStr(ChannelCount));
        WriteElement('Date',  FormatDateTime('yy/mm/dd hh:nn:ss', Now));
        WriteElement('Title', TitleText);

        StartElement('TimeIndexes');
        for x := 0 to IndexCount - 1 do
          WriteElement('X', FloatToStr(GetIndexTime(x)));
        EndElement('TimeIndexes');

        StartElement('Channels');
          for Channel := 0 to ChannelCount - 1 do
            begin
              StartElement('Channel');
                WriteElement('Title',     ChannelTitle[Channel]);
                WriteElement('Color',     IntToStr(ChannelColor[Channel]));
                WriteElement('LineWidth', IntToStr(ChannelLineWidth[Channel]));
                WriteElement('LineStyle', IntToStr(ord(ChannelLineStyle[Channel])));
                StartElement('Data');
                  for x := 0 to IndexCount - 1 do
                    WriteElement('Y', FloatToStr(ChannelData[Channel, x]));
                EndElement('Data');
              EndElement('Channel');
            end;
        EndElement('Channels');

        EndElement('IocompStripChartData');
      end;
  finally
    FileStream.SaveToFile(FileName);
    FileStream.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.LoadFromXMLFile(FileName: String);
var
  FileStream    : TiXMLMemoryStream;
  ChannelCount  : Integer;
  ChannelNumber : Integer;
  DataNumber    : Integer;
  x             : Integer;
begin
  ClearData;
  RemoveAllChannels;
  TitleText := '';
  FileStream := TiXMLMemoryStream.Create;
  FileStream.LoadFromFile(FileName);
  try
    with FileStream do
      begin
        if GetNameElementStart <> 'IocompStripChartData' then raise Exception.Create('File Format not Supported');

        ChannelCount := StrToInt(GetElement('ChannelCount'));
        TitleText    := GetElement('Title');

        for x := 0 to ChannelCount -1 do
          AddChannel('', clRed, iclsSolid, 0);                       

        GotoElementStart('TimeIndexes');
        while GetNextPiece = 'X' do
          begin
            AddIndexTime(StrToFloat(GetElementValue));
            if GetNextPiece <> '/X' then raise Exception.Create('XML not Well Formed');
          end;

        GotoElementStart('Channels');
        ChannelNumber := 0;
        while GetNextPiece = 'Channel' do
          begin
            ChannelTitle    [ChannelNumber] := GetElement('Title');
            ChannelColor    [ChannelNumber] := StrToInt(GetElement('Color'));
            ChannelLineWidth[ChannelNumber] := StrToInt(GetElement('LineWidth'));
            ChannelLineStyle[ChannelNumber] := TiChannelLineStyle(StrToInt(GetElement('LineStyle')));

            GotoElementStart('Data');
            DataNumber := 0;
            while GetNextPiece = 'Y' do
              begin
                ChannelData[ChannelNumber, DataNumber] := StrToFloat(GetElementValue);
                if GetNextPiece <> '/Y' then raise Exception.Create('XML not Well Formed');
                Inc(DataNumber);
              end;
            if GetNextPiece <> '/Channel' then raise Exception.Create('XML not Well Formed');
            Inc(ChannelNumber);
          end;
      end;
  finally
    FileStream.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.AddXMLComment(ElementName, ElementValue: String);
begin
  FXMLCommentList.Add('<' + ElementName + '>' + ElementValue + '</' + ElementName + '>');
end;
//****************************************************************************************************************************************************
procedure TiStripChart.ClearAllXMLComments;
begin
  FXMLCommentList.Clear;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetRingBufferSize(Value: Integer);
var
  x : Integer;
begin
  FIndexList.UseRingBuffer := True;
  FIndexList.SetCapacity(Value);

  for x := 0 to FChannelList.Count - 1 do
    GetChannel(x).SetRingBufferSize(Value);
end;
//****************************************************************************************************************************************************
function TiStripChart.GetAddYChannel1Now: Double;
begin
  Result := 0;
end;
//****************************************************************************************************************************************************
procedure TiStripChart.SetAddYChannel1Now(const Value: Double);
begin
  if ChannelCount > 0 then
    begin
      AddIndexTimeNow;
      SetChannelData(0, IndexCount-1, Value);
    end;
end;
//****************************************************************************************************************************************************
end.


