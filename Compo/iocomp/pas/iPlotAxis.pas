{*******************************************************}
{                                                       }
{       TiPlotAxis                                      }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotAxis;{$endif}
{$ifdef iCLX}unit QiPlotAxis;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iDateUtils,  iTypes,  iGPFunctions,  iMath,  iPlotObjects;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiDateUtils, QiTypes, QiGPFunctions, QiMath, QiPlotObjects;{$ENDIF}

const
  TIME_HOUR        = 1/24;
  TIME_MINUTE      = TIME_HOUR/60;
  TIME_SECOND      = TIME_MINUTE/60;
  TIME_MILLISECOND = TIME_SECOND/1000;

type
  TiPlotAxis = class;

  TiQuadSide                   = (iqsLeft, iqsTop, iqsRight, iqsBottom);
  TiPlotTrackingStyle          = (iptsScaleMinMax, iptsScaleMax, iptsScaleMin, iptsScrollSmooth, iptsScrollPage, iptsExpandCollapse, iptsExpandCollapseFast, iptsExpandMinMax);
  TiPlotTrackingIncrementStyle = (iptisMinimum, iptisMajor, iptisMinor);
  TiPlotAlignFirstStyle        = (ipafsMin, ipafsMax, ipafsAuto, ipafsNone);
  TiPlotScaleType              = (ipstLinear, ipstLog10);
  TiPlotTextFormat             = (iptfValue, iptfExponent, iptfPrefix, iptfDateTime, iptfPrice32nds, iptfThousands);
  TiPlotAxisMode               = (ipamScroll, ipamZoom);
  TiPlotTickType               = (ipttMajor, ipttMinor);
  TiPlotGridLineStyle          = (ipglsSolid, ipglsDash, ipglsDot);
  TiPlotCartesianStyle         = (ipcsNone, ipcsMaster, ipcsChild);

  TiPlotTickObject = class(TObject)
  public
    TickType       : TiPlotTickType;
    Position       : Double;
    PositionPixels : Integer;
    Text           : String;
    Show           : Boolean;
  end;

  TiPlotAxis = class(TiPlotLayoutObject)
  private
    FActualStart                   : Integer;
    FActualStop                    : Integer;
    FPixelsPerSpanUnit             : Double;

    FCartesianRefAxis              : TiPlotAxis;
    FAlignRefAxis                  : TiPlotAxis;

    FBlockMinSpanEvents            : Boolean;

    FTickList                      : TStringList;
    FQuadSide                      : TiQuadSide;
    FMouseDown                     : Boolean;
    FMouseDownX                    : Integer;
    FMouseDownY                    : Integer;
    FMouseDownMin                  : Double;
    FMouseDownSpan                 : Double;
    FFirstAlignDone                : Boolean;
    FScaleRect                     : TRect;
    FFocusRect                     : TRect;
    FRequiredWidth                 : Integer;
    FTitleOffset                   : Integer;

    FPreviousMin                   : Double;
    FPreviousSpan                  : Double;
    FPreviousLabelsMinLength       : Double;

    FAllowLabelMinAdjust           : Boolean;

    FSpan                          : Double;
    FMin                           : Double;
    FReverseScale                  : Boolean;

    FInnerMargin                   : Integer;
    FOuterMargin                   : Integer;
    FStackingEndsMargin            : Double;

    FMinorLength                   : Integer;
    FMajorLength                   : Integer;
    FMinorCount                    : Integer;

    FLabelsVisible                 : Boolean;
    FLabelsMargin                  : Double;
    FLabelsPrecision               : Integer;
    FLabelsPrecisionStyle          : TiPrecisionStyle;
    FLabelsFont                    : TFont;
    FLabelsMinLength               : Double;
    FLabelsMinLengthAutoAdjust     : Boolean;
    FLabelSeparation               : Double;

    FTitleMargin                   : Double;
    FTitleFont                     : TFont;
    FTitleShow                     : Boolean;
    FTitle                         : String;
    FTitleRotated                  : Boolean;

    FScaleLineShow                 : Boolean;
    FScaleLinesColor               : TColor;

    FTrackingEnabled               : Boolean;
    FTrackingStyle                 : TiPlotTrackingStyle;
    FTrackingIncrementStyle        : TiPlotTrackingIncrementStyle;
    FTrackingScrollCompressMax     : Double;
    FTrackingSpanMinimum           : Double;
    FTrackingMaxMargin             : Double;
    FTrackingMinMargin             : Double;
    FTrackingAlignFirstStyle       : TiPlotAlignFirstStyle;
    FScaleType                     : TiPlotScaleType;
    FDateTimeFormat                : String;
    FLabelsFormatStyle             : TiPlotTextFormat;
    FMode                          : TiPlotAxisMode;
    FDesiredIncrement              : Double;
    FCursorScaler                  : Double;
    FRestoreValuesOnResume         : Boolean;
    FScrollMin                     : Double;
    FScrollMax                     : Double;
    FScrollMinMaxEnabled           : Boolean;
    FMasterUIInput                 : Boolean;
    FDesiredStart                  : Double;
    FMonthModeEnabled              : Boolean;
    FYearModeEnabled               : Boolean;

    FMajorIncrement                : Double;
    FMinorIncrement                : Double;

    FCartesianStyle                : TiPlotCartesianStyle;
    FCartesianChildRefValue        : Double;
    FCartesianChildRefAxisName     : String;
    FGridLinesVisible              : Boolean;
    FScaleLinesShow                : Boolean;

    FCursorUseDefaultFormat        : Boolean;
    FCursorDateTimeFormat          : String;
    FCursorFormatStyle             : TiPlotTextFormat;
    FCursorPrecisionStyle          : TiPrecisionStyle;
    FCursorPrecision               : Integer;
    FCursorMinLengthAutoAdjust     : Boolean;
    FCursorMinLength               : Double;

    FLegendUseDefaultFormat        : Boolean;
    FLegendFormatStyle             : TiPlotTextFormat;
    FLegendDateTimeFormat          : String;
    FLegendPrecisionStyle          : TiPrecisionStyle;
    FLegendPrecision               : Integer;
    FLegendMinLength               : Double;
    FLegendMinLengthAutoAdjust     : Boolean;
    FTickListCustom                : Boolean;
    FAlignRefAxisName              : String;
    FLabelsRotation                : TiRotationAngle;

    function GetMax : Double;
    function GetMid : Double;

    procedure SetSpan                     (const Value: Double);
    procedure SetMin                      (const Value: Double);
    procedure SetReverseScale             (const Value: Boolean);

    procedure SetInnerMargin              (const Value: Integer);
    procedure SetOuterMargin              (const Value: Integer);
    procedure SetStackingEndsMargin       (const Value: Double);

    procedure SetLabelsVisible            (const Value: Boolean);
    procedure SetLabelsPrecisionStyle     (const Value: TiPrecisionStyle);
    procedure SetLabelsFont               (const Value: TFont);
    procedure SetLabelsMargin             (const Value: Double);
    procedure SetLabelsPrecision          (const Value: Integer);
    procedure SetLabelsMinLength          (const Value: Double);
    procedure SetLabelsMinLengthAutoAdjust(const Value: Boolean);
    procedure SetLabelsFormatStyle        (const Value: TiPlotTextFormat);
    procedure SetLabelsRotation           (const Value: TiRotationAngle);

    procedure SetMajorLength              (const Value: Integer);
    procedure SetMinorLength              (const Value: Integer);
    procedure SetMinorCount               (const Value: Integer);

    procedure SetTitleFont                (const Value: TFont);
    procedure SetTitleMargin              (const Value: Double);
    procedure SetTitleShow                (const Value: Boolean);
    procedure SetTitle                    (const Value: String);
    procedure SetTitleRotated             (const Value: Boolean);

    procedure SetScaleLineShow            (const Value: Boolean);
    procedure SetScaleLinesShow           (const Value: Boolean);
    procedure SetLabelSeparation          (const Value: Double);
    procedure SetScaleLinesColor          (const Value: TColor);

    procedure SetTrackingEnabled          (const Value: Boolean);
    procedure SetTrackingStyle            (const Value: TiPlotTrackingStyle);
    procedure SetTrackingIncrementStyle   (const Value: TiPlotTrackingIncrementStyle);
    procedure SetTrackingScrollCompressMax(const Value: Double);
    procedure SetTrackingSpanMinimum      (const Value: Double);
    procedure SetTrackingMaxMargin        (const Value: Double);
    procedure SetTrackingMinMargin        (const Value: Double);
    procedure SetTrackingAlignFirstStyle  (const Value: TiPlotAlignFirstStyle);
    procedure SetScaleType                (const Value: TiPlotScaleType);
    procedure SetDateTimeFormat           (const Value: String);
    procedure SetMode                     (const Value: TiPlotAxisMode);
    procedure SetDesiredIncrement         (const Value: Double);
    procedure SetCursorScaler             (const Value: Double);
    procedure SetRestoreValuesOnResume    (const Value: Boolean);
    procedure SetScrollMax                (const Value: Double);
    procedure SetScrollMin                (const Value: Double);
    procedure SetScrollMinMaxEnabled      (const Value: Boolean);
    procedure SetMasterUIInput            (const Value: Boolean);
    procedure SetDesiredStart             (const Value: Double);
    procedure SetCartesianStyle           (const Value: TiPlotCartesianStyle);
    procedure SetCartesianChildRefAxisName(const Value: String);
    procedure SetCartesianChildRefValue   (const Value: Double);
    procedure SetAlignRefAxisName         (const Value: String);
    procedure SetGridLinesVisible         (const Value: Boolean);

    procedure SetCursorDateTimeFormat     (const Value: String);
    procedure SetCursorFormatStyle        (const Value: TiPlotTextFormat);
    procedure SetCursorPrecisionStyle     (const Value: TiPrecisionStyle);
    procedure SetCursorPrecision          (const Value: Integer);
    procedure SetCursorUseDefaultFormat   (const Value: Boolean);
    procedure SetCursorMinLength          (const Value: Double);
    procedure SetCursorMinLengthAutoAdjust(const Value: Boolean);

    procedure SetLegendUseDefaultFormat   (const Value: Boolean);
    procedure SetLegendFormatStyle        (const Value: TiPlotTextFormat);
    procedure SetLegendDateTimeFormat     (const Value: String);
    procedure SetLegendPrecisionStyle     (const Value: TiPrecisionStyle);
    procedure SetLegendPrecision          (const Value: Integer);
    procedure SetLegendMinLength          (const Value: Double);
    procedure SetLegendMinLengthAutoAdjust(const Value: Boolean);

    procedure SetTickListCustom           (const Value: Boolean);

    function GetMinPixels                 : Integer;
    function GetMaxPixels                 : Integer;
    function GetTickListCount             : Integer;

    function GetTickObject(Index: Integer): TiPlotTickObject;

    function GetCartesianRefAxis          : TiPlotAxis;
    function GetAlignRefAxis              : TiPlotAxis;

    function TickDiv(Count, Divisor: Integer): Integer;

    function  GetLabelTextAdjust(const Value  : Double): String;

    function GetTickListItemLabel   (Index: Integer): String;
    function GetTickListItemPosition(Index: Integer): Double;
    function GetTickListItemStyle   (Index: Integer): TiPlotTickType;

    procedure SetTickListItemLabel   (Index: Integer; const Value: String);
    procedure SetTickListItemPosition(Index: Integer; const Value: Double);
    procedure SetTickListItemStyle   (Index: Integer; const Value: TiPlotTickType);
  protected
    procedure DefineProperties    (Filer : TFiler);               override;
    procedure WriteSpan           (Writer: TWriter);
    procedure ReadSpan            (Reader: TReader);
    procedure WriteLabelSeperation(Writer: TWriter);
    procedure ReadLabelSeperation (Reader: TReader);
    procedure WriteTitleMargin    (Writer: TWriter);
    procedure ReadTitleMargin     (Reader: TReader);

    procedure NotificationSetFocus(Sender: TObject); override;
    procedure NotificationRemove  (Sender: TObject); override;
    procedure NotificationRename  (Sender: TObject); override;

    procedure TrackingEnabledMenuItemClick   (Sender : TObject);
    procedure UpdateResumeValuesMenuItemClick(Sender : TObject);
    procedure ZoomToFitClick                 (Sender : TObject);

    procedure CalcTicks            (const Canvas: TCanvas);
    procedure CalcTickPixels;
    procedure ClearTickList;

    procedure CalcScaleRect    (const Canvas: TCanvas);
    procedure CalcLinearTicks  (const Canvas: TCanvas; MaxMajorTicks: Integer; var MajorCount: Integer; var MajorStepValue: Double);
    procedure CalcPrice32Ticks (const Canvas: TCanvas; MaxMajorTicks: Integer; var MajorCount: Integer; var MajorStepValue: Double);
    procedure CalcDateTimeTicks(const Canvas: TCanvas; MaxMajorTicks: Integer; var MajorCount: Integer; var MajorStepValue: Double);
    procedure CalcLog10Ticks   (const Canvas: TCanvas; MaxMajorTicks: Integer);

    procedure AddTick(Value : Double; Style : TiPlotTickType);

    function  GetSpanLength   : Integer;
    function  GetMousePointer(APoint: TPoint) : TCursor;                       override;

    function  GetActualMode : TiPlotAxisMode;

    procedure AdjustToIncrement;

    procedure Draw              (const Canvas: TCanvas; const BackGroundColor: TColor); override;
    procedure DrawSetup         (const Canvas: TCanvas);                                override;
    procedure DrawLines         (const Canvas: TCanvas; const BackGroundColor: TColor);

    procedure DrawScaleLine     (Canvas: TCanvas);
    procedure DrawTitle         (Canvas: TCanvas);
    procedure DrawScaleMajorTick(Canvas: TCanvas; iPlotTickObject: TiPlotTickObject);
    procedure DrawScaleMinorTick(Canvas: TCanvas; iPlotTickObject: TiPlotTickObject);
    procedure DrawScaleTick     (Canvas: TCanvas; PositionPixels, StartOffset, StopOffset: Integer);
    procedure DrawScaleLabel    (Canvas: TCanvas; iPlotTickObject: TiPlotTickObject);
    procedure DrawGridLines     (Canvas: TCanvas; ARect: TRect; ShowMajors, ShowMinors : Boolean; MajorStyle, MinorStyle : TiPlotGridLineStyle;
                                 MajorColor, MinorColor: TColor; MajorWidth, MinorWidth: Integer);

    procedure AddMenuItems(PopupMenu: TPopUpMenu);                                                       override;

    procedure DoMouseHint(MouseData: TiPlotMouseData; var HintData: TiHintData);                         override;
    procedure DoMouseLeft(MouseData: TiPlotMouseData);                                                   override;
    procedure DoMouseMove(MouseData: TiPlotMouseData);                                                   override;
    procedure DoMouseUp  (MouseData: TiPlotMouseData);                                                   override;

    procedure iKeyDown   (var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);               override;
    function  DoMouseWheel(WheelDelta: Integer; Shift: TShiftState; AX, AY: Integer): Boolean;           override;
    function  iMouseHitTest(MouseData: TiPlotMouseData): Boolean;                                        override;


    function  GetRequiredWidth       (const Canvas: TCanvas): Integer;                                   override;
    function  GetRequiredLengthGaurd (const Canvas: TCanvas): Integer;                                   override;

    function  GetRequiredLabelLength (const Canvas: TCanvas; AFont: TFont): Integer;
    function  GetRequiredLegendLength(const Canvas: TCanvas; AFont: TFont): Integer;
    function  GetRequiredCursorLength(const Canvas: TCanvas; AFont: TFont): Integer;

    procedure ZoomRect                (ARect : TRect);
    procedure ScrollPercentByReference(RefMin, RefSpan, RefMax, Percent: Double);
    procedure ZoomPercentByReference  (RefMin, RefSpan, RefMax, Percent: Double);
    property  ScaleRect                : TRect                 read FScaleRect;
    property  FocusRect                : TRect                 read FFocusRect;

    property  BlockMinSpanEvents       : Boolean               read FBlockMinSpanEvents   write FBlockMinSpanEvents;

    property  CartesianRefAxis         : TiPlotAxis            read GetCartesianRefAxis;
    property  AlignRefAxis             : TiPlotAxis            read GetAlignRefAxis;

    property  TickObject[Index: Integer] : TiPlotTickObject read GetTickObject;

    function GetText (const Value: Double; const FormatStyle: TiPlotTextFormat; const DateTimeFormat: String; const PrecisionStyle: TiPrecisionStyle;
                      const Precision: Integer; const MinLengthAutoAdjust: Boolean; var MinLength: Double): String;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);   override;
    destructor  Destroy;                                                                                 override;

    function GetLabelText      (const Value: Double): String;
    function GetCursorText     (const Value: Double): String;
    function GetCursorValueText(const Value: Double): String;
    function GetLegendText     (const Value: Double): String;

    function  PointOnScale(Value : Double) : Boolean;
    procedure SetMinSpan(NewMin, NewSpan: Double);

    procedure NewTrackingData(Value: Double);

    procedure ResetFirstAlign;
    procedure UpdateResumeValues;

    procedure Zoom(Value : Double);

    procedure ZoomToFit;
    procedure ZoomToFitFast;

    procedure TickListClear;
    function  TickListAdd(Position: Double; ALabel: String; Style : TiPlotTickType): Integer;

    property  TickListCustom                       : Boolean        read FTickListCustom         write SetTickListCustom;
    property  TickListCount                        : Integer        read GetTickListCount;

    property  TickListItemLabel   [Index: Integer] : String         read GetTickListItemLabel    write SetTickListItemLabel;
    property  TickListItemPosition[Index: Integer] : Double         read GetTickListItemPosition write SetTickListItemPosition;
    property  TickListItemStyle   [Index: Integer] : TiPlotTickType read GetTickListItemStyle    write SetTickListItemStyle;

    function  PositionToPixels (const Value: Double ): Integer;
    function  WidthToPixels    (const Value: Double ): Integer;
    function  PixelsToPosition (const Value: Integer): Double;
    function  PercentToPosition(const Value: Double) : Double;
    function  PositionToPercent(const Value: Double) : Double;
    function  ValueOnScale     (const Value: Double ): Boolean;

    property MinPixels : Integer read GetMinPixels;
    property MaxPixels : Integer read GetMaxPixels;

    property MajorIncrement : double read FMajorIncrement;
    property MinorIncrement : double read FMinorIncrement;

    property Mode                      : TiPlotAxisMode               read FMode                      write SetMode;
    property Max                       : Double                       read GetMax;
    property Mid                       : Double                       read GetMid;
  published
    property Min                       : Double                       read FMin                       write SetMin;
    property Span                      : Double                       read FSpan                      write SetSpan;
    property DesiredStart              : Double                       read FDesiredStart              write SetDesiredStart;
    property DesiredIncrement          : Double                       read FDesiredIncrement          write SetDesiredIncrement;

    property ReverseScale              : Boolean                      read FReverseScale              write SetReverseScale              default False;

    property InnerMargin               : Integer                      read FInnerMargin               write SetInnerMargin               default 5;
    property OuterMargin               : Integer                      read FOuterMargin               write SetOuterMargin               default 5;

    property Title                     : String                       read FTitle                     write SetTitle;
    property TitleMargin               : Double                       read FTitleMargin               write SetTitleMargin;
    property TitleFont                 : TFont                        read FTitleFont                 write SetTitleFont;
    property TitleShow                 : Boolean                      read FTitleShow                 write SetTitleShow                 default False;
    property TitleRotated              : Boolean                      read FTitleRotated              write SetTitleRotated              default False;

    property MajorLength               : Integer                      read FMajorLength               write SetMajorLength               default 7;
    property MinorLength               : Integer                      read FMinorLength               write SetMinorLength               default 3;
    property MinorCount                : Integer                      read FMinorCount                write SetMinorCount                default 1;

    property LabelsVisible             : Boolean                      read FLabelsVisible             write SetLabelsVisible             default True;
    property LabelsMargin              : Double                       read FLabelsMargin              write SetLabelsMargin;
    property LabelsFont                : TFont                        read FLabelsFont                write SetLabelsFont;
    property LabelSeparation           : Double                       read FLabelSeparation           write SetLabelSeparation;
    property LabelsRotation            : TiRotationAngle              read FLabelsRotation            write SetLabelsRotation;

    property LabelsPrecision           : Integer                      read FLabelsPrecision           write SetLabelsPrecision           default 3;
    property LabelsPrecisionStyle      : TiPrecisionStyle             read FLabelsPrecisionStyle      write SetLabelsPrecisionStyle      default ipsSignificantDigits;
    property LabelsFormatStyle         : TiPlotTextFormat             read FLabelsFormatStyle         write SetLabelsFormatStyle         default iptfValue;
    property DateTimeFormat            : String                       read FDateTimeFormat            write SetDateTimeFormat;
    property LabelsMinLength           : Double                       read FLabelsMinLength           write SetLabelsMinLength;
    property LabelsMinLengthAutoAdjust : Boolean                      read FLabelsMinLengthAutoAdjust write SetLabelsMinLengthAutoAdjust default False;

    property ScaleLineShow             : Boolean                      read FScaleLineShow             write SetScaleLineShow;
    property ScaleLinesShow            : Boolean                      read FScaleLinesShow            write SetScaleLinesShow            default True;
    property ScaleLinesColor           : TColor                       read FScaleLinesColor           write SetScaleLinesColor           default clWhite;

    property StackingEndsMargin        : Double                       read FStackingEndsMargin        write SetStackingEndsMargin;

    property ScaleType                 : TiPlotScaleType              read FScaleType                 write SetScaleType                 default ipstLinear;

    property TrackingEnabled           : Boolean                      read FTrackingEnabled           write SetTrackingEnabled           default True;
    property TrackingStyle             : TiPlotTrackingStyle          read FTrackingStyle             write SetTrackingStyle;
    property TrackingIncrementStyle    : TiPlotTrackingIncrementStyle read FTrackingIncrementStyle    write SetTrackingIncrementStyle;
    property TrackingAlignFirstStyle   : TiPlotAlignFirstStyle        read FTrackingAlignFirstStyle   write SetTrackingAlignFirstStyle   default ipafsMin;
    property TrackingScrollCompressMax : Double                       read FTrackingScrollCompressMax write SetTrackingScrollCompressMax;
    property TrackingSpanMinimum       : Double                       read FTrackingSpanMinimum       write SetTrackingSpanMinimum;
    property TrackingMaxMargin         : Double                       read FTrackingMaxMargin         write SetTrackingMaxMargin;
    property TrackingMinMargin         : Double                       read FTrackingMinMargin         write SetTrackingMinMargin;

    property CursorUseDefaultFormat    : Boolean                      read FCursorUseDefaultFormat    write SetCursorUseDefaultFormat    default True;
    property CursorFormatStyle         : TiPlotTextFormat             read FCursorFormatStyle         write SetCursorFormatStyle         default iptfValue;
    property CursorDateTimeFormat      : String                       read FCursorDateTimeFormat      write SetCursorDateTimeFormat;
    property CursorPrecisionStyle      : TiPrecisionStyle             read FCursorPrecisionStyle      write SetCursorPrecisionStyle      default ipsSignificantDigits;
    property CursorPrecision           : Integer                      read FCursorPrecision           write SetCursorPrecision;
    property CursorMinLength           : Double                       read FCursorMinLength           write SetCursorMinLength;
    property CursorMinLengthAutoAdjust : Boolean                      read FCursorMinLengthAutoAdjust write SetCursorMinLengthAutoAdjust default False;

    property LegendUseDefaultFormat    : Boolean                      read FLegendUseDefaultFormat    write SetLegendUseDefaultFormat    default True;
    property LegendFormatStyle         : TiPlotTextFormat             read FLegendFormatStyle         write SetLegendFormatStyle         default iptfValue;
    property LegendDateTimeFormat      : String                       read FLegendDateTimeFormat      write SetLegendDateTimeFormat;
    property LegendPrecisionStyle      : TiPrecisionStyle             read FLegendPrecisionStyle      write SetLegendPrecisionStyle      default ipsSignificantDigits;
    property LegendPrecision           : Integer                      read FLegendPrecision           write SetLegendPrecision;
    property LegendMinLength           : Double                       read FLegendMinLength           write SetLegendMinLength;
    property LegendMinLengthAutoAdjust : Boolean                      read FLegendMinLengthAutoAdjust write SetLegendMinLengthAutoAdjust default False;

    property CursorScaler              : Double                       read FCursorScaler              write SetCursorScaler;

    property ScrollMinMaxEnabled       : Boolean                      read FScrollMinMaxEnabled       write SetScrollMinMaxEnabled;
    property ScrollMax                 : Double                       read FScrollMax                 write SetScrollMax;
    property ScrollMin                 : Double                       read FScrollMin                 write SetScrollMin;

    property RestoreValuesOnResume     : Boolean                      read FRestoreValuesOnResume     write SetRestoreValuesOnResume;
    property MasterUIInput             : Boolean                      read FMasterUIInput             write SetMasterUIInput;

    property CartesianStyle            : TiPlotCartesianStyle         read FCartesianStyle            write SetCartesianStyle;
    property CartesianChildRefAxisName : String                       read FCartesianChildRefAxisName write SetCartesianChildRefAxisName;
    property CartesianChildRefValue    : Double                       read FCartesianChildRefValue    write SetCartesianChildRefValue;

    property AlignRefAxisName          : String                       read FAlignRefAxisName          write SetAlignRefAxisName;

    property GridLinesVisible          : Boolean                      read FGridLinesVisible          write SetGridLinesVisible;

    property ForceStacking;
  end;

  TiPlotXAxis = class(TiPlotAxis)
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
  end;
  TiPlotYAxis = class(TiPlotAxis)
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
  end;

implementation

uses
{$ifdef iVCL} iPlotChannelCustom,  iPlotDataView,  iPlotLimit,  iPlot,  iXYPlot,  iPlotManagers,  iPlotComponent;{$endif}
{$ifdef iCLX}QiPlotChannelCustom, QiPlotDataView, QiPlotLimit, QiPlot, QiXYPlot, QiPlotManagers, QiPlotComponent;{$endif}


type
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom)end;
  TiPlotDataViewAccess      = class(TiPlotDataView     )end;
  TiPlotLimitAccess         = class(TiPlotLimit        )end;
  TiPlotComponentAccess     = class(TiPlotComponent    )end;
//****************************************************************************************************************************************************
constructor TiPlotXAxis.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);
  if AOwner is TiPlot then
    TrackingStyle := iptsScrollSmooth
  else
    TrackingStyle := iptsScaleMinMax;

  TrackingAlignFirstStyle := ipafsAuto;
end;
//****************************************************************************************************************************************************
constructor TiPlotYAxis.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);
  TrackingStyle           := iptsScaleMinMax;
  TrackingAlignFirstStyle := ipafsNone;
end;
//****************************************************************************************************************************************************
constructor TiPlotAxis.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited Create(AOwner, AOnChange, AOnInsert, AOnRemove, AOnRename);

  FSpan                      := 100;
  FPreviousSpan              := 100;

  FMajorLength               := 7;
  FMinorLength               := 3;
  FMinorCount                := 1;

  FTitleMargin               := 0.25;

  FGridLinesVisible          := True;

  FScaleLinesShow            := True;

  FLabelsVisible             := True;
  FLabelSeparation           := 2;
  FLabelsMargin              := 0.25;

  FLabelsFormatStyle         := iptfValue;
  FDateTimeFormat            := 'hh:nn:ss';
  FLabelsPrecisionStyle      := ipsSignificantDigits;
  FLabelsPrecision           := 3;
  FLabelsMinLength           := 5;

  FCursorUseDefaultFormat    := True;
  FCursorFormatStyle         := iptfValue;
  FCursorDateTimeFormat      := 'hh:nn:ss';
  FCursorPrecisionStyle      := ipsSignificantDigits;
  FCursorPrecision           := 3;
  FCursorMinLength           := 5;

  FLegendUseDefaultFormat    := True;
  FLegendFormatStyle         := iptfValue;
  FLegendDateTimeFormat      := 'hh:nn:ss';
  FLegendPrecisionStyle      := ipsSignificantDigits;
  FLegendPrecision           := 3;
  FLegendMinLength           := 5;

  FStackingEndsMargin        := 0.5;

  FCartesianChildRefAxisName := '<None>';
  FAlignRefAxisName          := '<None>';

  FInnerMargin               := 5;
  FOuterMargin               := 5;

  FCursorScaler              := 1;
  FCursorPrecision           := 3;

  FScrollMax                 := 100;
  FScrollMinMaxEnabled       := False;

  FScaleLinesColor           := clWhite;
  FScaleLineShow             := True;

  TrackingEnabled            := True;

  FRestoreValuesOnResume     := True;

  FTickList                  := TStringList.Create;
  FTickList.Sorted           := False;

  FLabelsFont                := TFont.Create;
  FLabelsFont.OnChange       := TriggerChange;
  FLabelsFont.Color          := clWhite;

  FTitleFont                 := TFont.Create;
  FTitleFont.OnChange        := TriggerChange;
  FTitleFont.Color           := clWhite;
  FTitleFont.Name            := 'Arial';
  FTitleFont.Size            := 10;
  FTitleFont.Style           := [fsBold];
end;
//****************************************************************************************************************************************************
destructor TiPlotAxis.Destroy;
begin
  FLabelsFont.Free;
  FTitleFont.Free;

  ClearTickList;
  FTickList.Free;

  inherited Destroy;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.NotificationRemove(Sender: TObject);
begin
  if Sender = FCartesianRefAxis then FCartesianRefAxis := nil;
  if Sender = FAlignRefAxis     then FAlignRefAxis     := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.NotificationRename(Sender: TObject);
begin
  if Sender = FCartesianRefAxis then FCartesianChildRefAxisName := (Sender as TiPlotAxis).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetCartesianChildRefAxisName(const Value: String);
begin
  if FCartesianChildRefAxisName <> Value then
    begin
      FCartesianChildRefAxisName := Value;
      FCartesianRefAxis          := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetAlignRefAxisName(const Value: String);
begin
  if FAlignRefAxisName <> Value then
    begin
      FAlignRefAxisName := Value;
      FAlignRefAxis     := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetCartesianRefAxis: TiPlotAxis;
begin
  if not Assigned(FCartesianRefAxis) then
    begin
      if Self is TiPlotXAxis then FCartesianRefAxis := TiPlotComponentAccess(Owner).GetYAxisByName(FCartesianChildRefAxisName)
      else                        FCartesianRefAxis := TiPlotComponentAccess(Owner).GetXAxisByName(FCartesianChildRefAxisName);
    end;
  Result := FCartesianRefAxis;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetAlignRefAxis: TiPlotAxis;
begin
  if not Assigned(FAlignRefAxis) then
    begin
      if Self is TiPlotXAxis then FAlignRefAxis := TiPlotComponentAccess(Owner).GetXAxisByName(FAlignRefAxisName)
      else                        FAlignRefAxis := TiPlotComponentAccess(Owner).GetYAxisByName(FAlignRefAxisName);
    end;
  Result := FAlignRefAxis;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.AddMenuItems(PopupMenu: TPopUpMenu);
var
  MenuItem       : TMenuItem;
  RestoreEnabled : Boolean;
begin
  inherited;
  AddEditMenuItems(PopupMenu);

                                                             RestoreEnabled := True;
  if     FTrackingEnabled                               then RestoreEnabled := False;
  if (FPreviousMin  = FMin) and (FPreviousSpan = FSpan) then RestoreEnabled := False;

  MenuItem         := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := GetTranslation('Tracking Enabled');
  MenuItem.OnClick := TrackingEnabledMenuItemClick;
  MenuItem.Checked := FTrackingEnabled;
  PopupMenu.Items.Insert(0, MenuItem);

  MenuItem            := TMenuItem.Create(PopupMenu);
  MenuItem.Caption    := GetTranslation('Update Resume Values');
  MenuItem.OnClick    := UpdateResumeValuesMenuItemClick;
  MenuItem.Enabled    := RestoreEnabled;

  PopupMenu.Items.Insert(1, MenuItem);

  MenuItem            := TMenuItem.Create(PopupMenu);
  MenuItem.Caption    := GetTranslation('Zoom to Fit');
  MenuItem.OnClick    := ZoomToFitClick;

  PopupMenu.Items.Insert(2, MenuItem);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DoMouseHint(MouseData: TiPlotMouseData; var HintData: TiHintData);
begin
  if not FTitleShow then
    begin
      HintData.Text := FTitle;
      HintData.Left := MouseData.X;
      HintData.Top  := MouseData.Y-20;
    end;

  if Self is TiPlotXAxis then TiPlotComponentAccess(Owner as TiPlotComponent).DoXAxisCustomizeHint(Self as TiPlotXAxis, HintData.Text);
  if Self is TiPlotYAxis then TiPlotComponentAccess(Owner as TiPlotComponent).DoYAxisCustomizeHint(Self as TiPlotYAxis, HintData.Text);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DoMouseLeft(MouseData: TiPlotMouseData);
begin
  if FMasterUIInput then TiPlotComponentAccess(Owner).MasterAxisMouseLeft(Self, MouseData);

  FMouseDown     := True;
  FMouseDownX    := MouseData.X;
  FMouseDownY    := MouseData.Y;

  FMouseDownMin  := Min;
  FMouseDownSpan := Span;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DoMouseMove(MouseData: TiPlotMouseData);
var
  PercentChange : Double;
begin
  if not FMouseDown then Exit;

  if FMasterUIInput then TiPlotComponentAccess(Owner).MasterAxisMouseMove(Self, MouseData);

  if FMouseDown and (not MouseData.DblClickActive) then
    begin
      TriggerInvalidateNow(Self);
      TrackingEnabled := False;
      if IsHorz then
        begin
          if FReverseScale then PercentChange := (FMouseDownX - MouseData.X)/GetSpanLength
            else                PercentChange := (MouseData.X - FMouseDownX)/GetSpanLength;
        end
      else
        begin
          if FReverseScale then PercentChange := (MouseData.Y - FMouseDownY)/GetSpanLength
            else                PercentChange := (FMouseDownY - MouseData.Y)/GetSpanLength;
        end;
                                               

      case GetActualMode of
        ipamScroll : case
                       FScaleType of
                         ipstLinear : ScrollPercentByReference(Min, Span, Max, -PercentChange);
                         ipstLog10  : ScrollPercentByReference(Min, Max,  Max, -PercentChange);
                     end;
        ipamZoom   : begin
                       case FScaleType of
                         ipstLinear : ZoomPercentByReference(Min, Span, Max, PercentChange/4);
                         ipstLog10  : ZoomPercentByReference(Min, Span, Max, PercentChange*2);
                       end;
                     end;
      end;

      FMouseDownX := MouseData.X;
      FMouseDownY := MouseData.Y;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DoMouseUp(MouseData: TiPlotMouseData);
begin
  if not FMouseDown then exit;

  if FMasterUIInput then TiPlotComponentAccess(Owner).MasterAxisMouseUp(Self, MouseData);

  try
    if iMouseHitTest(MouseData) then TiPlotComponentAccess(Owner).DoObjectClick(Self);

    if (FMouseDownMin <> Min) or (FMouseDownSpan <> Span) then TiPlotComponentAccess(Owner).DoAxesMinSpanChangeFinished(Self, FMouseDownMin, FMouseDownSpan, Min, Span);
  finally
    FMouseDown := False;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.DoMouseWheel(WheelDelta: Integer; Shift: TShiftState; AX, AY: Integer): Boolean;
var
  Sign : Integer;
begin
  Result := True;
  if WheelDelta = 0 then Exit;
  TrackingEnabled := False;

  if FMasterUIInput then TiPlotComponentAccess(Owner).MasterAxisMouseWheel(Self, WheelDelta, Shift, AX, AY);

  Sign := WheelDelta div ABS(WheelDelta);

  case GetActualMode of
    ipamScroll : case
                   FScaleType of
                     ipstLinear : ScrollPercentByReference(Min, Span, Max, Sign*0.05);
                     ipstLog10  : ScrollPercentByReference(Min, Max,  Max, Sign*0.05);
                 end;
    ipamZoom   : case FScaleType of
                   ipstLinear : ZoomPercentByReference(Min, Span, Max, Sign*0.0250);
                   ipstLog10  : ZoomPercentByReference(Min, Span, Max, Sign*0.0500);
                 end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.iKeyDown(var CharCode: Word; Shift: TShiftState; PopupMenu : TPopupMenu);
var
  Percent : Double;
begin
  inherited iKeyDown(CharCode, Shift, PopupMenu);

  if FMasterUIInput then TiPlotComponentAccess(Owner).MasterAxisKeyDown(Self, CharCode, Shift);

  TrackingEnabled := False;

  FMouseDownMin  := Min;
  FMouseDownSpan := Span;

  case CharCode of
    VK_LEFT  : Percent := -0.01;
    VK_DOWN  : Percent := -0.01;
    VK_RIGHT : Percent := +0.01;
    VK_UP    : Percent := +0.01;
    VK_PRIOR : Percent := +1.00;
    VK_NEXT  : Percent := -1.00;
    VK_HOME  : Percent := -1.00;
    VK_END   : Percent := +1.00;
    else       Percent := 0;
  end;

  if Percent <> 0 then
    begin
      TriggerInvalidateNow(Self);
      case FMode of
        ipamScroll : ScrollPercentByReference(Min, Span, Max, Percent);
        ipamZoom   : ZoomPercentByReference  (Min, Span, Max, Percent);
      end;
    end;

  if (FMouseDownMin <> Min) or (FMouseDownSpan <> Span) then
    TiPlotComponentAccess(Owner).DoAxesMinSpanChangeFinished(Self, FMouseDownMin, FMouseDownSpan, Min, Span);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Span_2',          ReadSpan,            WriteSpan,            False);
  Filer.DefineProperty('Span',            ReadSpan,            WriteSpan,            False);
  Filer.DefineProperty('LabelSeparation', ReadLabelSeperation, WriteLabelSeperation, FLabelSeparation = 0);
  Filer.DefineProperty('TitleMargin',     ReadTitleMargin,     WriteTitleMargin,     FTitleMargin     = 0);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.WriteSpan           (Writer: TWriter);begin Writer.WriteFloat(FSpan           );end;
procedure TiPlotAxis.WriteLabelSeperation(Writer: TWriter);begin Writer.WriteFloat(FLabelSeparation);end;
procedure TiPlotAxis.WriteTitleMargin    (Writer: TWriter);begin Writer.WriteFloat(FTitleMargin    );end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ReadSpan            (Reader: TReader);begin FSpan            := Reader.ReadFloat;end;
procedure TiPlotAxis.ReadLabelSeperation (Reader: TReader);begin FLabelSeparation := Reader.ReadFloat;end;
procedure TiPlotAxis.ReadTitleMargin     (Reader: TReader);begin FTitleMargin     := Reader.ReadFloat;end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetLabelsMargin             (const Value:Double );begin SetDoubleProperty (Value,FLabelsMargin,             TriggerChange);end;
procedure TiPlotAxis.SetLabelsPrecision          (const Value:Integer);begin SetIntegerProperty(Value,FLabelsPrecision,          TriggerChange);end;
procedure TiPlotAxis.SetLabelsMinLength          (const Value:Double );begin SetDoubleProperty (Value,FLabelsMinLength,          TriggerChange);end;
procedure TiPlotAxis.SetMajorLength              (const Value:Integer);begin SetIntegerProperty(Value,FMajorLength,              TriggerChange);end;
procedure TiPlotAxis.SetInnerMargin              (const Value:Integer);begin SetIntegerProperty(Value,FInnerMargin,              TriggerChange);end;
procedure TiPlotAxis.SetOuterMargin              (const Value:Integer);begin SetIntegerProperty(Value,FOuterMargin,              TriggerChange);end;
procedure TiPlotAxis.SetMinorCount               (const Value:Integer);begin SetIntegerProperty(Value,FMinorCount,               TriggerChange);end;
procedure TiPlotAxis.SetMinorLength              (const Value:Integer);begin SetIntegerProperty(Value,FMinorLength,              TriggerChange);end;
procedure TiPlotAxis.SetReverseScale             (const Value:Boolean);begin SetBooleanProperty(Value,FReverseScale,             TriggerChange);end;
procedure TiPlotAxis.SetTitle                    (const Value:String );begin SetStringProperty (Value,FTitle,                    TriggerChange);end;
procedure TiPlotAxis.SetTitleRotated             (const Value:Boolean);begin SetBooleanProperty(Value,FTitleRotated,             TriggerChange);end;
procedure TiPlotAxis.SetTitleShow                (const Value:Boolean);begin SetBooleanProperty(Value,FTitleShow,                TriggerChange);end;
procedure TiPlotAxis.SetTitleMargin              (const Value:Double );begin SetDoubleProperty (Value,FTitleMargin,              TriggerChange);end;
procedure TiPlotAxis.SetScaleLineShow            (const Value:Boolean);begin SetBooleanProperty(Value,FScaleLineShow,            TriggerChange);end;
procedure TiPlotAxis.SetScaleLinesShow           (const Value:Boolean);begin SetBooleanProperty(Value,FScaleLinesShow,           TriggerChange);end;
procedure TiPlotAxis.SetTrackingScrollCompressMax(const Value:Double );begin SetDoubleProperty (Value,FTrackingScrollCompressMax,TriggerChange);end;
procedure TiPlotAxis.SetTrackingSpanMinimum      (const Value:Double );begin SetDoubleProperty (Value,FTrackingSpanMinimum,      TriggerChange);end;
procedure TiPlotAxis.SetTrackingMaxMargin        (const Value:Double );begin SetDoubleProperty (Value,FTrackingMaxMargin,        TriggerChange);end;
procedure TiPlotAxis.SetTrackingMinMargin        (const Value:Double );begin SetDoubleProperty (Value,FTrackingMinMargin,        TriggerChange);end;
procedure TiPlotAxis.SetStackingEndsMargin       (const Value:Double );begin SetDoubleProperty (Value,FStackingEndsMargin,       TriggerChange);end;
procedure TiPlotAxis.SetLabelsVisible            (const Value:Boolean);begin SetBooleanProperty(Value,FLabelsVisible,            TriggerChange);end;
procedure TiPlotAxis.SetLabelSeparation          (const Value:Double );begin SetDoubleProperty (Value,FLabelSeparation,          TriggerChange);end;
procedure TiPlotAxis.SetScaleLinesColor          (const Value:TColor );begin SetColorProperty  (Value,FScaleLinesColor,          TriggerChange);end;
procedure TiPlotAxis.SetDateTimeFormat           (const Value:String );begin SetStringProperty (Value,FDateTimeFormat,           TriggerChange);end;
procedure TiPlotAxis.SetLabelsMinLengthAutoAdjust(const Value:Boolean);begin SetBooleanProperty(Value,FLabelsMinLengthAutoAdjust,TriggerChange);end;
procedure TiPlotAxis.SetCursorScaler             (const Value:Double );begin SetDoubleProperty (Value,FCursorScaler,             TriggerChange);end;
procedure TiPlotAxis.SetRestoreValuesOnResume    (const Value:Boolean);begin SetBooleanProperty(Value,FRestoreValuesOnResume,    TriggerChange);end;
procedure TiPlotAxis.SetScrollMinMaxEnabled      (const Value:Boolean);begin SetBooleanProperty(Value,FScrollMinMaxEnabled,      TriggerChange);end;
procedure TiPlotAxis.SetScrollMax                (const Value:Double );begin SetDoubleProperty (Value,FScrollMax,                TriggerChange);end;
procedure TiPlotAxis.SetScrollMin                (const Value:Double );begin SetDoubleProperty (Value,FScrollMin,                TriggerChange);end;
procedure TiPlotAxis.SetMasterUIInput            (const Value:Boolean);begin SetBooleanProperty(Value,FMasterUIInput,            TriggerChange);end;
procedure TiPlotAxis.SetDesiredStart             (const Value:Double );begin SetDoubleProperty (Value,FDesiredStart,             TriggerChange);end;
procedure TiPlotAxis.SetCartesianChildRefValue   (const Value:Double );begin SetDoubleProperty (Value,FCartesianChildRefValue,   TriggerChange);end;
procedure TiPlotAxis.SetGridLinesVisible         (const Value:Boolean);begin SetBooleanProperty(Value,FGridLinesVisible,         TriggerChange);end;

procedure TiPlotAxis.SetCursorUseDefaultFormat   (const Value:Boolean);begin SetBooleanProperty(Value,FCursorUseDefaultFormat,   TriggerChange);end;
procedure TiPlotAxis.SetCursorDateTimeFormat     (const Value:String );begin SetStringProperty (Value,FCursorDateTimeFormat,     TriggerChange);end;
procedure TiPlotAxis.SetCursorPrecision          (const Value:Integer);begin SetIntegerProperty(Value,FCursorPrecision,          TriggerChange);end;
procedure TiPlotAxis.SetCursorMinLength          (const Value:Double );begin SetDoubleProperty (Value,FCursorMinLength,          TriggerChange);end;
procedure TiPlotAxis.SetCursorMinLengthAutoAdjust(const Value:Boolean);begin SetBooleanProperty(Value,FCursorMinLengthAutoAdjust,TriggerChange);end;

procedure TiPlotAxis.SetLegendUseDefaultFormat   (const Value:Boolean);begin SetBooleanProperty(Value,FLegendUseDefaultFormat,   TriggerChange);end;
procedure TiPlotAxis.SetLegendDateTimeFormat     (const Value:String );begin SetStringProperty (Value,FLegendDateTimeFormat,     TriggerChange);end;
procedure TiPlotAxis.SetLegendPrecision          (const Value:Integer);begin SetIntegerProperty(Value,FLegendPrecision,          TriggerChange);end;
procedure TiPlotAxis.SetLegendMinLength          (const Value:Double );begin SetDoubleProperty (Value,FLegendMinLength,          TriggerChange);end;
procedure TiPlotAxis.SetLegendMinLengthAutoAdjust(const Value:Boolean);begin SetBooleanProperty(Value,FLegendMinLengthAutoAdjust,TriggerChange);end;
procedure TiPlotAxis.SetTickListCustom           (const Value:Boolean);begin SetBooleanProperty(Value,FTickListCustom,           TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetTitleFont (const Value:TFont);begin FTitleFont.Assign (Value);end;
procedure TiPlotAxis.SetLabelsFont(const Value:TFont);begin FLabelsFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetCartesianStyle(const Value: TiPlotCartesianStyle);
begin
  if FCartesianStyle <> Value then
    begin
      FCartesianStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetLabelsRotation(const Value: TiRotationAngle);
begin
  if FLabelsRotation <> Value then
    begin
      FLabelsRotation := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetSpan(const Value : Double);
var
  TempValue : Double;
  OldValue  : Double;
begin
  TempValue := Value;
  if TempValue < 1e-300 then TempValue := 1e-300;
  if TempValue > 1e+300 then TempValue := 1e+300;
  if FSpan <> TempValue then
    begin
      OldValue := FSpan;
      FSpan := TempValue;
      TriggerChange(Self);
      if not BlockMinSpanEvents then if Owner is TiPlotComponent then TiPlotComponentAccess(Owner).DoAxesSpanChange   (Self,      OldValue,      FSpan);
      if not BlockMinSpanEvents then if Owner is TiPlotComponent then TiPlotComponentAccess(Owner).DoAxesMinSpanChange(Self, Min, OldValue, Min, FSpan);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetMin(const Value : Double);
var
  TempValue : Double;
  OldValue  : Double;
begin
  TempValue := Value;
  if TempValue > +1e+300 then TempValue := +1e+300;
  if TempValue < -1e+300 then TempValue := -1e+300;
  if FMin <> TempValue then
    begin
      OldValue := FMin;
      FMin := TempValue;
      TriggerChange(Self);
      if not BlockMinSpanEvents then if Owner is TiPlotComponent then TiPlotComponentAccess(Owner).DoAxesMinChange    (Self, OldValue,       FMin);
      if not BlockMinSpanEvents then if Owner is TiPlotComponent then TiPlotComponentAccess(Owner).DoAxesMinSpanChange(Self, OldValue, Span, FMin, Span);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetDesiredIncrement(const Value: Double);
var
  TempValue : Double;
begin
  TempValue := Value;
  if TempValue > +1e+300 then TempValue := +1e+300;
  if TempValue < 0       then TempValue := 0;
  if FDesiredIncrement <> TempValue then
    begin
      FDesiredIncrement := TempValue;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.UpdateResumeValues;
begin
  FPreviousMin             := FMin;
  FPreviousSpan            := FSpan;
  FPreviousLabelsMinLength := FLabelsMinLength;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetTrackingEnabled(const Value:Boolean);
begin
  if FTrackingEnabled <> Value then
    begin
      FTrackingEnabled := Value;
      if FRestoreValuesOnResume then
        begin
          if TrackingEnabled then
            begin
              SetMinSpan(FPreviousMin, FPreviousSpan);
              FLabelsMinLength := FPreviousLabelsMinLength;
            end
          else UpdateResumeValues;
        end;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetLabelsFormatStyle(const Value: TiPlotTextFormat);
begin
  if FLabelsFormatStyle <> Value then
    begin
      FLabelsFormatStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetCursorFormatStyle(const Value: TiPlotTextFormat);
begin
  if FCursorFormatStyle <> Value then
    begin
      FCursorFormatStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetLegendFormatStyle(const Value: TiPlotTextFormat);
begin
  if FLegendFormatStyle <> Value then
    begin
      FLegendFormatStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetCursorPrecisionStyle(const Value: TiPrecisionStyle);
begin
  if FCursorPrecisionStyle <> Value then
    begin
      FCursorPrecisionStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetLegendPrecisionStyle(const Value: TiPrecisionStyle);
begin
  if FLegendPrecisionStyle <> Value then
    begin
      FLegendPrecisionStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetScaleType(const Value: TiPlotScaleType);
begin
  if FScaleType <> Value then
    begin
      FScaleType := Value;
      if FScaleType = ipstLog10 then if FMin <= 0 then FMin := 1;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetTrackingAlignFirstStyle(const Value: TiPlotAlignFirstStyle);
begin
  if FTrackingAlignFirstStyle <> Value then
    begin
      FTrackingAlignFirstStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetTrackingStyle(const Value: TiPlotTrackingStyle);
begin
  if FTrackingStyle <> Value then
    begin
      FTrackingStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetTrackingIncrementStyle(const Value: TiPlotTrackingIncrementStyle);
begin
  if FTrackingIncrementStyle <> Value then
    begin
      FTrackingIncrementStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetLabelsPrecisionStyle(const Value: TiPrecisionStyle);
begin
  if FLabelsPrecisionStyle <> Value then
    begin
      FLabelsPrecisionStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetMode(const Value: TiPlotAxisMode);
begin
  if FMode <> Value then
    begin
      FMode := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetSpanLength: Integer;
begin
  with FScaleRect do
    begin
      if Horizontal then Result := Right - Left else Result := Bottom - Top;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ClearTickList;
begin
  while FTickList.Count <> 0 do
    begin
      FTickList.Objects[0].Free;
      FTickList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetTickObject(Index: Integer): TiPlotTickObject;
begin
  Result := (FTickList.Objects[Index] as TiPlotTickObject);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.TickListClear;
begin
  ClearTickList;
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetTickListCount: Integer;
begin
  Result := FTickList.Count;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetTickListItemLabel   (Index:Integer):String;        begin Result:=TickObject[Index].Text;    end;
function TiPlotAxis.GetTickListItemPosition(Index:Integer):Double;        begin Result:=TickObject[Index].Position;end;
function TiPlotAxis.GetTickListItemStyle   (Index:Integer):TiPlotTickType;begin Result:=TickObject[Index].TickType;end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetTickListItemLabel   (Index:Integer;const Value:String);        begin TickObject[Index].Text    := Value;TriggerChange(Self);end;
procedure TiPlotAxis.SetTickListItemPosition(Index:Integer;const Value:Double);        begin TickObject[Index].Position:= Value;TriggerChange(Self);end;
procedure TiPlotAxis.SetTickListItemStyle   (Index:Integer;const Value:TiPlotTickType);begin TickObject[Index].TickType:= Value;TriggerChange(Self);end;
//****************************************************************************************************************************************************
function TiPlotAxis.TickListAdd(Position: Double; ALabel: String; Style: TiPlotTickType): Integer;
var
  TickObject : TiPlotTickObject;
begin
  if (FScaleType = ipstLog10) and (Position <= 0) then raise Exception.Create('Log Scale Requires Position to be Greater Than Zero');

  TickObject                := TiPlotTickObject.Create;
  TickObject.TickType       := Style;
  TickObject.Position       := Position;
  TickObject.Text           := ALabel;

  Result := FTickList.AddObject('', TickObject);

  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.AddTick(Value : Double; Style : TiPlotTickType);
var
  TickObject : TiPlotTickObject;
begin
  if not PointOnScale(Value) then Exit;

  if (FScaleType = ipstLog10) and (Value <= 0) then Exit;

  TickObject                := TiPlotTickObject.Create;
  TickObject.TickType       := Style;
  TickObject.Position       := Value;

  if Style = ipttMajor then
    TickObject.Text           := GetLabelText(Value);

  FTickList.AddObject('', TickObject);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ZoomRect(ARect: TRect);
var
  NewMin  : Double;
  NewMax  : Double;
begin
  if Horizontal then
    begin
      if FReverseScale then
        begin
          NewMin := PixelsToPosition(ARect.Right);
          NewMax := PixelsToPosition(ARect.Left);
        end
      else
        begin
          NewMin := PixelsToPosition(ARect.Left);
          NewMax := PixelsToPosition(ARect.Right);
        end;
    end
  else
    begin
      if FReverseScale then
        begin
          NewMin := PixelsToPosition(ARect.Top);
          NewMax := PixelsToPosition(ARect.Bottom);
        end
      else     
        begin
          NewMin := PixelsToPosition(ARect.Bottom);
          NewMax := PixelsToPosition(ARect.Top);
        end;
    end;

  SetMinSpan(NewMin, NewMax-NewMin);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.PointOnScale(Value: Double): Boolean;
var
  PositionPixels : Integer;
begin
  PositionPixels := PositionToPixels(Value);
  if Horizontal then
    begin
      if (PositionPixels >= FScaleRect.Left) and (PositionPixels <= FScaleRect.Right) then Result := True else Result := False;
    end
  else
    begin
      if (PositionPixels >= FScaleRect.Top) and (PositionPixels <= FScaleRect.Bottom) then Result := True else Result := False;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetRequiredLabelLength(const Canvas: TCanvas; AFont: TFont): Integer;
var
  x      : Integer;
  AWidth : Integer;
begin
  with Canvas do
    begin
      Font.Assign(AFont);
      Result := Round(TextWidth('0') * FLabelsMinLength);
      AWidth := iTextWidth(Canvas, GetLabelTextAdjust(Int(FMin/FSpan)*FSpan+FSpan));
      if AWidth > Result then Result := AWidth;
      for x := 0 to TickListCount-1 do
        begin
          AWidth := iTextWidth(Canvas, TickObject[x].Text);
          if AWidth > Result then Result := AWidth;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetRequiredLegendLength(const Canvas: TCanvas; AFont: TFont): Integer;
begin
  with Canvas do
    begin
      Font.Assign(AFont);
      if FLegendUseDefaultFormat then
        Result := Round(iTextWidth(Canvas, '0') * FLabelsMinLength)
      else
        Result := Round(iTextWidth(Canvas, '0') * FLegendMinLength);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetRequiredCursorLength(const Canvas: TCanvas; AFont: TFont): Integer;
begin
  with Canvas do
    begin
      Font.Assign(AFont);
      if FCursorUseDefaultFormat then
        Result := Round(iTextWidth(Canvas, '0') * FLabelsMinLength)
      else
        Result := Round(iTextWidth(Canvas, '0') * FCursorMinLength);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetRequiredWidth(const Canvas: TCanvas): Integer;
var
  MaxTickLength     : Integer;
  MaxLabelWidth     : Integer;
  MaxTitleSpace     : Integer;
  LabelMarginPixels : Integer;
begin
  with Canvas do
    begin
      MaxLabelWidth := 0;
      
      if FTitleShow and (FCartesianStyle = ipcsNone) then
        begin
          Font.Assign(FTitleFont);
          if FTitleRotated then MaxTitleSpace := Round(iTextWidth(Canvas, FTitle) + iTextHeight(Canvas, FTitle)*FTitleMargin)
          else                  MaxTitleSpace := Round(iTextHeight(Canvas, FTitle)+ iTextHeight(Canvas, FTitle)*FTitleMargin);
        end
      else MaxTitleSpace := 0;

                                           MaxTickLength := 0;
      if FMajorLength > MaxTickLength then MaxTickLength := FMajorLength;
      if FMinorLength > MaxTickLength then MaxTickLength := FMinorLength;

      if not FScaleLinesShow then          MaxTickLength := 0;

      if FLabelsVisible then
        begin
          Font.Assign(FLabelsFont);
          LabelMarginPixels := Round(TextHeight('A')*FLabelsMargin);

          if IsVert then
            case FLabelsRotation of
              ira000, ira180 : MaxLabelWidth := GetRequiredLabelLength(Canvas, FLabelsFont);
              ira090, ira270 : MaxLabelWidth := iTextHeight(Canvas, GetLabelText(FMin));
            end
          else
            case FLabelsRotation of
              ira000, ira180 : MaxLabelWidth := iTextHeight(Canvas, GetLabelText(FMin));
              ira090, ira270 : MaxLabelWidth := GetRequiredLabelLength(Canvas, FLabelsFont);
            end;
        end
      else
        begin
          MaxLabelWidth     := 0;
          LabelMarginPixels := 0;
        end;


      FTitleOffset := FInnerMargin + MaxTickLength + LabelMarginPixels + MaxLabelWidth;

      FRequiredWidth := FInnerMargin + FOuterMargin + MaxTickLength + LabelMarginPixels + MaxLabelWidth + MaxTitleSpace;

      Result := FRequiredWidth;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetRequiredLengthGaurd(const Canvas : TCanvas) : Integer;
begin
  Result := 0;

  if not FLabelsVisible then Exit;
    
  with Canvas do
    begin
      Font.Assign(FLabelsFont);

      if IsVert then
        case FLabelsRotation of
          ira000, ira180 : Result := iTextHeight(Canvas, 'XYZ') div 2;
          ira090, ira270 : Result := GetRequiredLabelLength(Canvas, FLabelsFont) div 2;
        end
      else
        case FLabelsRotation of
          ira000, ira180 : Result := GetRequiredLabelLength(Canvas, FLabelsFont) div 2;
          ira090, ira270 : Result := iTextHeight(Canvas, 'XYZ') div 2;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetCursorValueText(const Value: Double): String;
begin
  if FCursorUseDefaultFormat then
    Result := GetText(Value, iptfValue, '', FLabelsPrecisionStyle, FLabelsPrecision, FLabelsMinLengthAutoAdjust, FLabelsMinLength)
  else
    Result := GetText(Value, iptfValue, '', FCursorPrecisionStyle, FCursorPrecision, FCursorMinLengthAutoAdjust, FCursorMinLength);

  Result := StringReplace(Result, #13+#10, ' ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, #13,     ' ', [rfReplaceAll, rfIgnoreCase]);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetCursorText(const Value: Double): String;
begin
  if FCursorUseDefaultFormat then
    Result := GetText(Value, FLabelsFormatStyle, FDateTimeFormat,       FLabelsPrecisionStyle, FLabelsPrecision, FLabelsMinLengthAutoAdjust, FLabelsMinLength)
  else
    Result := GetText(Value, FCursorFormatStyle, FCursorDateTimeFormat, FCursorPrecisionStyle, FCursorPrecision, FCursorMinLengthAutoAdjust, FCursorMinLength);

  Result := StringReplace(Result, #13+#10, ' ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, #13,     ' ', [rfReplaceAll, rfIgnoreCase]);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetLegendText(const Value: Double): String;
begin
  if FLegendUseDefaultFormat then
    Result := GetText(Value, FLabelsFormatStyle, FDateTimeFormat,       FLabelsPrecisionStyle, FLabelsPrecision, FLabelsMinLengthAutoAdjust, FLabelsMinLength)
  else
    Result := GetText(Value, FLegendFormatStyle, FLegendDateTimeFormat, FLegendPrecisionStyle, FLegendPrecision, FLegendMinLengthAutoAdjust, FLegendMinLength);

  Result := StringReplace(Result, #13+#10, ' ', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, #13,     ' ', [rfReplaceAll, rfIgnoreCase]);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetLabelText(const Value: Double): String;
begin
  Result := GetText(Value, FLabelsFormatStyle, FDateTimeFormat, FLabelsPrecisionStyle, FLabelsPrecision, FLabelsMinLengthAutoAdjust, FLabelsMinLength);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetText(const Value: Double; const FormatStyle: TiPlotTextFormat; const DateTimeFormat: String; const PrecisionStyle: TiPrecisionStyle;
                            const Precision: Integer; const MinLengthAutoAdjust: Boolean; var MinLength: Double): String;
var
  x                  : Integer;
  NewFormatString    : String;
  Prefix             : Integer;
  AValue             : Double;
  DecimalPoints      : Integer;
  FracValue          : Double;
  _32nds             : Integer;
  _256ths            : Integer;
  _32ndsString       : String;
  _256thsString      : String;
begin
  Result := 'Unknown';

  try
    case FormatStyle of
      iptfValue      : begin
                         case FScaleType of
                           ipstLinear : Result := Trim(Format('%.' + IntToStr(GetDecimalPoints(FSPan, 0, Precision, PrecisionStyle)) + 'f', [Value]));
                           ipstLog10  : if Value > 0 then
                                          begin
                                           if LabelsPrecisionStyle = ipsFixedDecimalPoints then
                                             DecimalPoints := LabelsPrecision
                                           else
                                             DecimalPoints := LabelsPrecision -1 -Trunc(Log10(Value));
                                             
                                           if DecimalPoints < 0 then DecimalPoints := 0;
                                           Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [Value]));
                                          end
                                        else Exit;
                         end;
                       end;
      iptfExponent   : case PrecisionStyle of
                         ipsSignificantDigits  : Result := Trim(Format('%.' + IntToStr(Precision  ) + 'e', [Value]));
                         ipsFixedDecimalPoints : Result := Trim(Format('%.' + IntToStr(Precision+1) + 'e', [Value]));
                       end;
      iptfPrefix     : begin
                         if Value = 0 then Prefix := 0 else Prefix := Trunc((Int(Log10(ABS(Value))/3))*3);
                         AValue := Value / Power(10, Prefix);
                         DecimalPoints := GetDecimalPoints(AValue, 0, Precision, PrecisionStyle);
                         case Prefix of
                            24 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'Y';
                            21 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'Z';
                            18 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'E';
                            15 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'P';
                            12 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'T';
                             9 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'G';
                             6 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'M';
                             3 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'K';
                             0 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue]));
                            -3 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'm';
                            -6 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'µ';
                            -9 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'n';
                           -12 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'p';
                           -15 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'f';
                           -18 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'a';
                           -21 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'z';
                           -24 : Result := Trim(Format('%.' + IntToStr(DecimalPoints) + 'f', [AValue])) + 'y';
                         end;

                         if (Span > 1E-10) and (Value < 1E-12) and (Value > -1E-12) then
                           begin
                             Result := '0.';
                             for x := 0 to DecimalPoints-1 do
                               Result := Result + '0';
                           end;
                       end;
      iptfDateTime   : begin
                         if UpperCase(Copy(DateTimeFormat, 1, 1)) = 'J' then
                           begin
                             NewFormatString := Copy(DateTimeFormat, 2, Length(DateTimeFormat) - 1);
                             Result := Trim(IntToStr(Trunc(Value)) + ' ' + FormatDateTime(NewFormatString, Value));
                           end
                         else Result := Trim(FormatDateTime(DateTimeFormat, Value));
                       end;
      iptfPrice32nds : begin
                         FracValue := Frac(Value+(1/512));
                         _32nds    :=  Round(FracValue*1024) div 32;
                         _256ths   := (Round((FracValue*1024)) mod 32) div 4;

                         _32ndsString := IntToStr(_32nds);
                         while Length(_32ndsString) < 2 do _32ndsString := '0' + _32ndsString;

                         _256thsString := IntToStr(_256ths);

                         Result := Format('%.0f', [Int(Value+(1/512))]) + '.' + _32ndsString + _256thsString;
                       end;
      iptfThousands  : begin
                         NewFormatString := '#,#0';
                         DecimalPoints := GetDecimalPoints(FSPan, 0, Precision, PrecisionStyle);
                         if DecimalPoints > 0 then
                           begin
                             NewFormatString := NewFormatString + '.';
                             for x := 1 to DecimalPoints do
                               NewFormatString := NewFormatString + '0';
                           end;
                         Result := Trim(FormatFloat(NewFormatString, Value))
                       end;
    end;
  except
    on Exception do Result := 'Error';
  end;

  TiPlotComponentAccess(Owner as TiPlotComponent).DoAxesCustomizeLabel(Self, Value, Result);

  if MinLengthAutoAdjust and FAllowLabelMinAdjust then
    begin
      if Length(Result) > MinLength then MinLength := Length(Result);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawGridLines(Canvas: TCanvas; ARect: TRect; ShowMajors, ShowMinors : Boolean; MajorStyle, MinorStyle : TiPlotGridLineStyle;
                                   MajorColor, MinorColor: TColor; MajorWidth, MinorWidth: Integer);
var
  i               : Integer;
  PositionPixels  : Integer;
  iPlotTickObject : TiPlotTickObject;
begin
  if not FGridLinesVisible then Exit;

  for i := 0 to TickListCount-1 do
    begin
      iPlotTickObject := TickObject[i];
      if not iPlotTickObject.Show then Continue;
      case iPlotTickObject.TickType of
        ipttMajor : if ShowMajors then
                      begin
                        case MajorStyle of
                          ipglsSolid    : Canvas.Pen.Style := psSolid;
                          ipglsDash     : Canvas.Pen.Style := psDash;
                          ipglsDot      : Canvas.Pen.Style := psDot;
                        end;
                        Canvas.Pen.Width := MajorWidth;
                        Canvas.Pen.Color := MajorColor;
                      end
                    else Continue;

        ipttMinor : if ShowMinors then
                      begin
                        case MinorStyle of
                          ipglsSolid    : Canvas.Pen.Style := psSolid;
                          ipglsDash     : Canvas.Pen.Style := psDash;
                          ipglsDot      : Canvas.Pen.Style := psDot;
                        end;
                        Canvas.Pen.Width := MinorWidth;
                        Canvas.Pen.Color := MinorColor;
                      end
                    else Continue;
      end;
      PositionPixels  := iPlotTickObject.PositionPixels;

      if Horizontal then Canvas.PolyLine([Point(PositionPixels, ARect.Top     ), Point(PositionPixels, ARect.Bottom  )])
      else               Canvas.PolyLine([Point(ARect.Left,     PositionPixels), Point(ARect.Right,    PositionPixels)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.CalcScaleRect(const Canvas: TCanvas);
var
  ACharHeight   : Integer;
  ACharWidth    : Integer;
  StackOffset   : Integer;
  MaxLabelWidth : Integer;
begin
  with Canvas do
    begin
      if FCartesianStyle = ipcsNone then
        begin
          if Horizontal then begin if ReverseSide then FQuadSide := iqsTop   else FQuadSide := iqsBottom; end
          else               begin if ReverseSide then FQuadSide := iqsRight else FQuadSide := iqsLeft;   end;
        end
      else
        begin
          if Horizontal then FQuadSide := iqsBottom
          else               FQuadSide := iqsRight;
        end;

      Font.Assign(FLabelsFont);

      case FQuadSide of
        iqsLeft, iqsRight : begin
                              FScaleRect.Left  := DrawRect.Left;
                              FScaleRect.Right := DrawRect.Right;
                              FFocusRect.Left  := DrawRect.Left  + 2 ;
                              FFocusRect.Right := DrawRect.Right - 2;

                              ACharHeight := iTextHeight(Canvas, '0');

                              case FLabelsRotation of
                                ira000, ira180 : MaxLabelWidth := iTextHeight(Canvas, GetLabelText(FMin));
                                ira090, ira270 : MaxLabelWidth := GetRequiredLabelLength(Canvas, FLabelsFont);
                                else             MaxLabelWidth := 0;
                              end;

                              if FCartesianStyle = ipcsNone then
                                StackOffset := (MaxLabelWidth + Round(FStackingEndsMargin * ACharHeight)) div 2
                              else StackOffset := 0;

                              if     StartStacked then FScaleRect.Bottom := DrawRect.Bottom - StackOffset else FScaleRect.Bottom := DrawRect.Bottom;
                              if     StopStacked  then FScaleRect.Top    := DrawRect.Top    + StackOffset else FScaleRect.Top    := DrawRect.Top;

                              FFocusRect.Bottom := FScaleRect.Bottom + StackOffset;
                              FFocusRect.Top    := FScaleRect.Top    - StackOffset;
                            end;
        iqsTop, iqsBottom : begin
                              FScaleRect.Top    := DrawRect.Top;
                              FScaleRect.Bottom := DrawRect.Bottom;
                              FFocusRect.Top    := DrawRect.Top    + 2;
                              FFocusRect.Bottom := DrawRect.Bottom - 2;

                              ACharWidth  := iTextWidth(Canvas, '0');

                              case FLabelsRotation of
                                ira000, ira180 : MaxLabelWidth := GetRequiredLabelLength(Canvas, FLabelsFont);
                                ira090, ira270 : MaxLabelWidth := iTextHeight(Canvas, GetLabelText(FMin));
                                else             MaxLabelWidth := 0;
                              end;

                              if not FLabelsVisible then MaxLabelWidth := 0;

                              if FCartesianStyle = ipcsNone then
                                StackOffset := Round(MaxLabelWidth/2) + Round(FStackingEndsMargin * ACharWidth)
                              else StackOffset := 0;

                              if     StartStacked then FScaleRect.Left  := DrawRect.Left  + StackOffset else FScaleRect.Left  := DrawRect.Left;
                              if     StopStacked  then FScaleRect.Right := DrawRect.Right - StackOffset else FScaleRect.Right := DrawRect.Right;

                              FFocusRect.Left  := FScaleRect.Left  - StackOffset;
                              FFocusRect.Right := FScaleRect.Right + StackOffset;
                            end;
      end;
    end;

  with FScaleRect do
    begin
      if Horizontal then
        begin
          if FReverseScale then begin FActualStart := Right;  FActualStop := Left;  end
            else                begin FActualStart := Left;   FActualStop := Right; end;
        end                                              
      else
        begin
          if FReverseScale then begin FActualStart := Top;    FActualStop := Bottom;end
            else                begin FActualStart := Bottom; FActualStop := Top;   end;
        end;
    end;

  FPixelsPerSpanUnit := (FActualStart - FActualStop)/FSpan;

  if ABS(FPixelsPerSpanUnit) > 1E300 then FPixelsPerSpanUnit := 0;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawLines(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  x               : Integer;
  iPlotTickObject : TiPlotTickObject;
begin
  inherited;

  if not Visible then Exit;

  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Style   := psSolid;
  Canvas.Pen.Width   := 1;

  DrawScaleLine(Canvas);

  for x := 0 to TickListCount-1 do
    begin
      iPlotTickObject := TickObject[x];
      if not iPlotTickObject.Show then Continue;
      if iPlotTickObject.TickType = ipttMajor then
        begin
          DrawScaleMajorTick(Canvas, iPlotTickObject);
        end
      else DrawScaleMinorTick(Canvas, iPlotTickObject);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawSetup(const Canvas: TCanvas);
var
  LineEdge : Integer;
  ARect    : TRect;
begin
  if FCartesianStyle = ipcsNone then Exit;

  LineEdge := 0;

  with FScaleRect do
    case FQuadSide of
      iqsLeft   : begin
                    ARect := iRect(Right  - LineEdge, Top, Right  - LineEdge + 1, Bottom+1);
                    TiPlotComponentAccess(Owner).AddAxesCollisionItem(ARect);
                  end;
      iqsRight  : begin
                    ARect := iRect(Left   + LineEdge, Top, Left   + LineEdge + 1, Bottom+1);
                    TiPlotComponentAccess(Owner).AddAxesCollisionItem(ARect);
                  end;
      iqsTop    : begin
                    ARect := iRect(Left, Bottom - LineEdge, Right,   Bottom - LineEdge + 1);
                    TiPlotComponentAccess(Owner).AddAxesCollisionItem(ARect);
                  end;
      iqsBottom : begin
                    ARect := iRect(Left, Top    + LineEdge, Right+1, Top    + LineEdge + 1);
                    TiPlotComponentAccess(Owner).AddAxesCollisionItem(ARect);
                  end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  x               : Integer;
  iPlotTickObject : TiPlotTickObject;
  ARect           : TRect;
begin
  if not Visible then Exit;

  for x := 0 to TickListCount-1 do
    begin
      iPlotTickObject := TickObject[x];

      if not PointOnScale(iPlotTickObject.Position) then
        begin
          iPlotTickObject.Show := False;
        end
      else
        begin
          iPlotTickObject.Show := True;
          iPlotTickObject.PositionPixels := PositionToPixels(iPlotTickObject.Position);
          if iPlotTickObject.TickType = ipttMajor then
           if FLabelsVisible then DrawScaleLabel(Canvas, iPlotTickObject);
        end;
    end;

  if FScaleLinesShow then DrawLines(Canvas, BackGroundColor);

  if FCartesianStyle <> ipcsNone then
    begin
      if Horizontal then
        begin
          FFocusRect.Top    := DrawRect.Top - (FMajorLength + 1) div 2 - 5;
          FFocusRect.Bottom := FFocusRect.Top + FRequiredWidth;
        end
      else
        begin
          FFocusRect.Left  := DrawRect.Left - (FMajorLength + 1) div 2 - 5;
          FFocusRect.Right := FFocusRect.Left + FRequiredWidth;
        end;
    end
  else
    DrawTitle(Canvas);

  if UserSelected then
    begin
      Canvas.Font.Color := clWhite;
      ARect := Rect(FFocusRect.Left, FFocusRect.Top, FFocusRect.Right + 1, FFocusRect.Bottom + 1);
      iDrawFocusRect2(Canvas, ARect);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawScaleLine(Canvas: TCanvas);
var
  LineEdge : Integer;
begin
  if not FScaleLineShow then Exit;

  if FCartesianStyle = ipcsNone then
    LineEdge := FInnerMargin
  else
    LineEdge := 0;

  Canvas.Pen.Color := FScaleLinesColor;
  Canvas.Pen.Width := 1;

  with FScaleRect do
    case FQuadSide of
      iqsLeft   : Canvas.Polyline([Point(Right  - LineEdge, Top),Point(Right  - LineEdge, Bottom+1)]);
      iqsRight  : Canvas.Polyline([Point(Left + LineEdge, Top),Point(Left + LineEdge, Bottom+1)]);
      iqsTop    : Canvas.Polyline([Point(Left, Bottom - LineEdge),Point(Right,   Bottom - LineEdge)]);
      iqsBottom : Canvas.Polyline([Point(Left, Top    + LineEdge),Point(Right+1, Top    + LineEdge)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawScaleTick(Canvas: TCanvas; PositionPixels, StartOffset, StopOffset: Integer);
var
  ARect : TRect;
begin
  case FQuadSide of
    iqsLeft   : begin
                  if FCartesianStyle <> ipcsNone then
                    begin
                      ARect := iRect(Right - StartOffset, PositionPixels, Right - StopOffset, PositionPixels + 1);
                      TiPlotComponentAccess(Owner).AddAxesCollisionItem(ARect);
                    end;
                  Canvas.Polyline([Point(Right - StartOffset, PositionPixels),Point(Right - StopOffset, PositionPixels)]);
                end;
    iqsRight  : begin
                  if FCartesianStyle <> ipcsNone then
                    begin
                      ARect := iRect(Left + StartOffset, PositionPixels, Left + StopOffset, PositionPixels + 1);
                      TiPlotComponentAccess(Owner).AddAxesCollisionItem(ARect);
                    end;
                  Canvas.Polyline([Point(Left + StartOffset, PositionPixels),Point(Left + StopOffset, PositionPixels)]);
                end;

    iqsTop    : begin
                  if FCartesianStyle <> ipcsNone then
                    begin
                      ARect := iRect(PositionPixels, Bottom - StartOffset, PositionPixels + 1, Bottom - StopOffset);
                      TiPlotComponentAccess(Owner).AddAxesCollisionItem(ARect);
                    end;
                  Canvas.Polyline([Point(PositionPixels, Bottom - StartOffset),Point(PositionPixels, Bottom - StopOffset)]);
                end;
    iqsBottom : begin
                  if FCartesianStyle <> ipcsNone then
                    begin
                      ARect := iRect(PositionPixels, Top + StartOffset, PositionPixels + 1, Top + StopOffset);
                      TiPlotComponentAccess(Owner).AddAxesCollisionItem(ARect);
                    end;
                  Canvas.Polyline([Point(PositionPixels, Top + StartOffset),Point(PositionPixels, Top + StopOffset)]);
                end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawScaleMajorTick(Canvas: TCanvas; iPlotTickObject: TiPlotTickObject);
var
  PositionPixels   : Integer;
  StartOffset : Integer;
  StopOffset  : Integer;
begin
  PositionPixels := iPlotTickObject.PositionPixels;
  Canvas.Pen.Color := FScaleLinesColor;

  if FCartesianStyle = ipcsNone then
    begin
      StartOffset := FInnerMargin;
      StopOffset  := StartOffset + FMajorLength;
    end
  else
    begin
      StartOffset :=   (FMajorLength + 1) div 2;
      StopOffset  := -((FMajorLength + 1) div 2 + 1);
    end;

  DrawScaleTick(Canvas, PositionPixels, StartOffset, StopOffset);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawScaleMinorTick(Canvas: TCanvas; iPlotTickObject: TiPlotTickObject);
var
  PositionPixels : Integer;
  StartOffset    : Integer;
  StopOffset     : Integer;
begin
  PositionPixels   := iPlotTickObject.PositionPixels;
  Canvas.Pen.Color := FScaleLinesColor;

  if FCartesianStyle = ipcsNone then
    begin
      StopOffset  := FInnerMargin;
      StartOffset := StopOffset + FMinorLength;
    end
  else
    begin
      StartOffset :=   (FMinorLength + 1) div 2;
      StopOffset  := -((FMinorLength + 1) div 2 + 1);
    end;

  DrawScaleTick(Canvas, PositionPixels, StartOffset, StopOffset);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawScaleLabel(Canvas: TCanvas; iPlotTickObject: TiPlotTickObject);
var
  PositionPixels    : Integer;
  LabelOffset       : Integer;
  AText             : String;
  ATextHeight       : Integer;
  ATextWidth        : Integer;
  ARect             : TRect;
  LabelMarginPixels : Integer;
begin
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(FLabelsFont);

  PositionPixels := iPlotTickObject.PositionPixels;

  LabelMarginPixels := Round(iTextHeight(Canvas, 'A')*FLabelsMargin);

  AText       := iPlotTickObject.Text;
  ATextHeight := iTextHeight(Canvas, AText);
  ATextWidth  := iTextWidth (Canvas, AText);

  //----------------------------------------------------------
  //Compiler Bug Requires following Formatting of Code
  LabelOffset := 0;

  if FCartesianStyle = ipcsNone then
    begin
      if FScaleLinesShow then LabelOffset := FInnerMargin + FMajorLength + LabelMarginPixels
      else                    LabelOffset := FInnerMargin + LabelMarginPixels;
    end;

  if FCartesianStyle <> ipcsNone then
    begin
      if FScaleLinesShow then LabelOffset := (FMajorLength + 1) div 2 + LabelMarginPixels
      else                    LabelOffset := (FMajorLength + 1) div 2 + LabelMarginPixels;
    end;
  //----------------------------------------------------------
  case FQuadSide of
    iqsLeft   : begin
                  case FLabelsRotation of
                    ira000, ira180 : ARect := Rect(Right-LabelOffset-ATextWidth,  PositionPixels-ATextHeight div 2, Right-LabelOffset, PositionPixels+ATextHeight div 2);
                    ira090, ira270 : ARect := Rect(Right-LabelOffset-ATextHeight, PositionPixels-ATextWidth  div 2, Right-LabelOffset, PositionPixels+ATextWidth  div 2);
                  end;
                end;
    iqsRight  : begin
                  case FLabelsRotation of
                    ira000, ira180 : ARect := Rect(Left +LabelOffset, PositionPixels-ATextHeight div 2, Left+LabelOffset+ATextWidth,  PositionPixels+ATextHeight div 2);
                    ira090, ira270 : ARect := Rect(Left +LabelOffset, PositionPixels-ATextWidth  div 2, Left+LabelOffset+ATextHeight, PositionPixels+ATextWidth  div 2);
                  end;
                end;
    iqsTop    : begin
                  case FLabelsRotation of
                    ira000, ira180 : ARect := Rect(PositionPixels-ATextWidth  div 2, Bottom-LabelOffset-ATextHeight, PositionPixels+ATextWidth  div 2, Bottom-LabelOffset);
                    ira090, ira270 : ARect := Rect(PositionPixels-ATextHeight div 2, Bottom-LabelOffset-ATextWidth,  PositionPixels+ATextHeight div 2, Bottom-LabelOffset);
                  end;
                end;
    iqsBottom : begin
                  case FLabelsRotation of                        
                    ira000, ira180 : ARect := Rect(PositionPixels-ATextWidth  div 2, Top+LabelOffset, PositionPixels+ATextWidth  div 2, Top+LabelOffset+ATextHeight);
                    ira090, ira270 : ARect := Rect(PositionPixels-ATextHeight div 2, Top+LabelOffset, PositionPixels+ATextHeight div 2, Top+LabelOffset+ATextWidth);
                  end;
                end;
  end;

  if FCartesianStyle <> ipcsNone then if not TiPlotComponentAccess(Owner).AddAxesCollisionDetectionItem(ARect) then Exit;

  iDrawRotatedText(Canvas, AText, ARect, FLabelsRotation, iahCenter, True, clBtnFace);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.DrawTitle(Canvas: TCanvas);
var
  ATextHeight : Integer;
  ATextWidth  : Integer;
  ARect       : TRect;
  Angle       : TiRotationAngle;
begin
  if not FTitleShow           then Exit;
  if Length(Trim(FTitle)) = 0 then Exit;

  Canvas.Font.Assign(FTitleFont);

  if FTitleRotated then
    begin
      ATextHeight := iTextWidth (Canvas, FTitle);
      ATextWidth  := iTextHeight(Canvas, FTitle);
    end
  else
    begin
      ATextHeight := iTextHeight(Canvas, FTitle);
      ATextWidth  := iTextWidth (Canvas, FTitle);
    end;

  Canvas.Brush.Style := bsClear;

  with Canvas, FScaleRect do
    if Horizontal then
      begin
        case FQuadSide of
          iqsTop    : ARect := Rect(Left,  Top    + FOuterMargin,
                                    Right, Top    + FOuterMargin + ATextHeight);
          iqsBottom : ARect := Rect(Left,  Bottom - FOuterMargin - ATextHeight,
                                    Right, Bottom - FOuterMargin);
        end;

        if FTitleRotated then Angle := ira090 else Angle := ira000;
      end
    else
      begin
        case FQuadSide of
          iqsLeft  : ARect := iRect(Left  + FOuterMargin              , (Bottom + Top) div 2 - ATextWidth div 2,
                                    Left  + FOuterMargin + ATextHeight, (Bottom + Top) div 2 + ATextWidth div 2);
          iqsRight : ARect := iRect(Right - FOuterMargin,               (Bottom + Top) div 2 - ATextWidth div 2,
                                    Right - FOuterMargin - ATextHeight, (Bottom + Top) div 2 + ATextWidth div 2);
        end;
        if FTitleRotated then Angle := ira000 else Angle := ira090;
      end;

  iDrawRotatedText(Canvas, FTitle, ARect, Angle, iahCenter, True, clBtnFace);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.CalcTickPixels;
var
  x               : Integer;
  iPlotTickObject : TiPlotTickObject;
begin
  for x := 0 to TickListCount-1 do
    begin
      iPlotTickObject := TickObject[x];

      if not PointOnScale(iPlotTickObject.Position) then
        begin
          iPlotTickObject.Show := False;
        end
      else
        begin
          iPlotTickObject.Show := True;
          iPlotTickObject.PositionPixels := PositionToPixels(iPlotTickObject.Position);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.CalcTicks(const Canvas: TCanvas);
var
  x                   : Integer;
  CurrentPosition     : Double;
  CurrentPositionTest : Double;
  MaxMajorTicks       : Integer;

  LabelLengthPixels   : Double;
  SpanStart           : Double;
  SpanLength          : Integer;
  MajorCount          : Integer;
  NeedsDesiredStart   : Boolean;
  ShowMinorTicks      : Boolean;
  Year, Month         : Integer;
begin
  FMonthModeEnabled := False;
  FYearModeEnabled  := False;

  CalcScaleRect(Canvas);

  try
    if FTickListCustom then Exit;

    ClearTickList;
    //----------------------------- Calc MaxTicks ------------------------------------------------------------
    Canvas.Font.Assign(FLabelsFont);

    LabelLengthPixels := 0;

    if Horizontal then
      case FLabelsRotation of
        ira000, ira180 : LabelLengthPixels := Round((FLabelSeparation + 1) * iTextWidth (Canvas, '0') + GetRequiredLabelLength(Canvas, FLabelsFont));
        ira090, ira270 : LabelLengthPixels := Round((FLabelSeparation + 1) * iTextHeight(Canvas, '0'));
      end
    else
      case FLabelsRotation of
        ira000, ira180 : LabelLengthPixels := Round((FLabelSeparation + 1) * iTextHeight(Canvas, '0'));
        ira090, ira270 : LabelLengthPixels := Round((FLabelSeparation + 1) * iTextWidth (Canvas, '0') + GetRequiredLabelLength(Canvas, FLabelsFont));
      end;

    if LabelLengthPixels < 1 then LabelLengthPixels := 1;

    SpanLength        := GetSpanLength;
    MaxMajorTicks     := Trunc(SpanLength/LabelLengthPixels);
    if MaxMajorTicks < 1 then MaxMajorTicks := 1;
    //----------------------------- Auto Major Ticks ---------------------------------------------------------
    if (FScaleType = ipstLog10) and ((Log10(Max) - Log10(Min)) > 1) then
    begin
      CalcLog10Ticks(Canvas, MaxMajorTicks);
      Exit;
    end;

    FMajorIncrement := 0;
    MajorCount      := 0;

    begin
      if FSpan <= 1E-299 then
        begin
          MajorCount      := 1;
          FMajorIncrement := FSpan;
        end;

      if (MajorCount = 0) and (FDesiredIncrement <> 0) and (not FLabelsVisible) then
          if (FSpan/FDesiredIncrement) < (GetSpanLength/(1+FMinorCount)) then
            begin
              MajorCount      := Round(FSpan/FDesiredIncrement);
              FMajorIncrement := FDesiredIncrement;
              MaxMajorTicks   := MajorCount;
            end;

      if MajorCount = 0 then
        if FDesiredIncrement <> 0 then
          if FSpan/FDesiredIncrement < MaxMajorTicks then
            begin
              MajorCount      := Round(FSpan/FDesiredIncrement);
              FMajorIncrement := FDesiredIncrement;
              MaxMajorTicks   := MajorCount;
            end;

      if MaxMajorTicks < 1 then MaxMajorTicks := 1;

      if MajorCount = 0 then
        case LabelsFormatStyle of
          iptfPrice32nds : CalcPrice32Ticks (Canvas, MaxMajorTicks, MajorCount, FMajorIncrement);
          iptfDateTime   : CalcDateTimeTicks(Canvas, MaxMajorTicks, MajorCount, FMajorIncrement);
          else             CalcLinearTicks  (Canvas, MaxMajorTicks, MajorCount, FMajorIncrement);
        end;

      if (MajorCount < 2) and (MaxMajorTicks > 1) then
        begin
          FMajorIncrement := FMajorIncrement /2;
          MajorCount      := 2;
        end;

      if MajorCount > MaxMajorTicks then
        begin
          MajorCount      := MaxMajorTicks;
          FMajorIncrement := FSpan/MajorCount;
        end;

      SpanStart       := Int(FMin/FMajorIncrement) * FMajorIncrement;
      FMinorIncrement := FMajorIncrement/(FMinorCount+1);

      NeedsDesiredStart := True;
      if FDesiredStart  = 0  then NeedsDesiredStart := False;
      if FDesiredStart < Min then NeedsDesiredStart := False;
      if FDesiredStart > Max then NeedsDesiredStart := False;

      ShowMinorTicks := True;
      if FMinorCount < 1     then ShowMinorTicks := False;
      if FMonthModeEnabled   then ShowMinorTicks := False;
      if FYearModeEnabled    then ShowMinorTicks := False;
      if FMinorIncrement = 0 then ShowMinorTicks := False;

      if NeedsDesiredStart then
        begin
          CurrentPosition := FDesiredStart;
          while CurrentPosition > Min do
            CurrentPosition := CurrentPosition - FMajorIncrement;
        end
      else if FMonthModeEnabled then
        begin
          if FMin  <       0 then FMin  :=       0;
          if FMin  > 2593224 then FMin  := 2593224;
          if FSPan >   36525 then FSpan :=   36525;

          if FMajorIncrement < 1 then FMajorIncrement := 1;

          CurrentPosition := FMin;
          Month := MonthOf(CurrentPosition);
          Month := (Month div Round(FMajorIncrement))*Round(FMajorIncrement);

          if Month < 1 then Month := 1;

          CurrentPosition := RecodeDay  (CurrentPosition, 1);
          CurrentPosition := RecodeMonth(CurrentPosition, Month);
          CurrentPosition := IncMonth   (CurrentPosition, -Round(FMajorIncrement));//Start one major tick before
        end
      else if FYearModeEnabled then
        begin
          if FMin  < -182625 then FMin  := -182625;
          if FMin  > 2593224 then FMin  := 2593224;
          if FSPan >   36525 then FSpan :=   36525;

          if FMajorIncrement < 1 then FMajorIncrement := 1;

          CurrentPosition := FMin;
          Year := YearOf(CurrentPosition);

          if Round(FMajorIncrement) <> 0 then
            Year := (Year div Round(FMajorIncrement))*Round(FMajorIncrement);

          CurrentPosition := RecodeYear (CurrentPosition, Year);
          CurrentPosition := IncYear    (CurrentPosition, -Round(FMajorIncrement));//Start one major tick before
          CurrentPosition := RecodeMonth(CurrentPosition, 1);
          CurrentPosition := RecodeDay  (CurrentPosition, 1);
        end
      else
        begin
          CurrentPosition := SpanStart;
          CurrentPosition := CurrentPosition - FMajorIncrement; //Start one major tick before
        end;

      while CurrentPosition <= (Max + FMajorIncrement) do
        begin
          AddTick(CurrentPosition, ipttMajor);
          if ShowMinorTicks then
            begin
              for x := 1 to FMinorCount do
                begin
                  CurrentPosition := CurrentPosition + FMinorIncrement;
                  AddTick(CurrentPosition, ipttMinor);
                end;
            end
          else if FMonthModeEnabled then CurrentPosition := IncMonth(CurrentPosition, Round(FMajorIncrement))
          else if FYearModeEnabled  then CurrentPosition := IncYear (CurrentPosition, Round(FMajorIncrement))
          else
            begin
              if CurrentPosition = (CurrentPosition + FMajorIncrement) then
                Break
              else CurrentPosition := CurrentPosition + FMajorIncrement;
            end;

          CurrentPositionTest := CurrentPosition + FMinorIncrement;

          if (FTickList.Count > 5000) or  (CurrentPosition = CurrentPositionTest) then
            begin
              ClearTickList;
              AddTick(Min + Span/2, ipttMajor);
              Exit;
            end;

          CurrentPosition := CurrentPosition + FMinorIncrement;
        end;
    end;
  finally
    CalcTickPixels;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.CalcLinearTicks(const Canvas: TCanvas; MaxMajorTicks: Integer; var MajorCount: Integer; var MajorStepValue: Double);
var
  BasePower : Integer;
  Base      : Double;
begin
  BasePower  := Trunc(Log10(FSpan) - 1 - Log10(MaxMajorTicks));
  MajorCount := 1;

  while True do
    begin
      Base := Power(10, BasePower);
      if      FSPan/(Base*1.0)<=MaxMajorTicks then begin MajorCount:=Round(FSPan/(Base*1.0));MajorStepValue:=Base*1.0;Break;end
      else if FSPan/(Base*2.0)<=MaxMajorTicks then begin MajorCount:=Round(FSPan/(Base*2.0));MajorStepValue:=Base*2.0;Break;end
      else if FSPan/(Base*5.0)<=MaxMajorTicks then begin MajorCount:=Round(FSPan/(Base*5.0));MajorStepValue:=Base*5.0;Break;end;
      BasePower := BasePower + 1;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.TickDiv(Count, Divisor: Integer): Integer;
begin
  Result := Count div Divisor;
  if Result < 1 then Result := 1;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.CalcDateTimeTicks(const Canvas: TCanvas; MaxMajorTicks: Integer; var MajorCount: Integer; var MajorStepValue: Double);
var
  ACount    : Integer;
  BasePower : Integer;
  Base      : Integer;
begin
  ACount := DateToMilliSeconds(Span);
  if      (ACount div   1) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,   1); MajorStepValue := TIME_MILLISECOND*1;   end
  else if (ACount div   2) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,   2); MajorStepValue := TIME_MILLISECOND*2;   end
  else if (ACount div   5) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,   5); MajorStepValue := TIME_MILLISECOND*5;   end
  else if (ACount div  10) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  10); MajorStepValue := TIME_MILLISECOND*10;  end
  else if (ACount div  20) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  20); MajorStepValue := TIME_MILLISECOND*20;  end
  else if (ACount div  50) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  50); MajorStepValue := TIME_MILLISECOND*50;  end
  else if (ACount div 100) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 100); MajorStepValue := TIME_MILLISECOND*100; end
  else if (ACount div 200) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 200); MajorStepValue := TIME_MILLISECOND*200; end
  else if (ACount div 500) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 500); MajorStepValue := TIME_MILLISECOND*500; end;

  if MajorCount = 0 then
    begin
      ACount := DateToSeconds(Span);
      if      (ACount div   1) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  1); MajorStepValue := TIME_SECOND*1;  end
      else if (ACount div   2) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  2); MajorStepValue := TIME_SECOND*2;  end
      else if (ACount div   5) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  5); MajorStepValue := TIME_SECOND*5;  end
      else if (ACount div  10) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 10); MajorStepValue := TIME_SECOND*10; end
      else if (ACount div  15) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 15); MajorStepValue := TIME_SECOND*15; end
      else if (ACount div  20) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 20); MajorStepValue := TIME_SECOND*20; end
      else if (ACount div  30) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 30); MajorStepValue := TIME_SECOND*30; end;
    end;

  if MajorCount = 0 then
    begin
      ACount := DateToMinutes(Span);
      if      (ACount div   1) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  1); MajorStepValue := TIME_MINUTE*1;  end
      else if (ACount div   2) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  2); MajorStepValue := TIME_MINUTE*2;  end
      else if (ACount div   5) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  5); MajorStepValue := TIME_MINUTE*5;  end
      else if (ACount div  10) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 10); MajorStepValue := TIME_MINUTE*10; end
      else if (ACount div  15) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 15); MajorStepValue := TIME_MINUTE*15; end
      else if (ACount div  20) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 20); MajorStepValue := TIME_MINUTE*20; end
      else if (ACount div  30) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 30); MajorStepValue := TIME_MINUTE*30; end;
    end;

  if MajorCount = 0 then
    begin
      ACount := DateToHours(Span);
      if      (ACount div   1) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  1); MajorStepValue := TIME_HOUR*1;  end
      else if (ACount div   2) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  2); MajorStepValue := TIME_HOUR*2;  end
      else if (ACount div   4) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  4); MajorStepValue := TIME_HOUR*4;  end
      else if (ACount div   6) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  6); MajorStepValue := TIME_HOUR*6;  end
      else if (ACount div  12) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 12); MajorStepValue := TIME_HOUR*12; end
    end;

  if MajorCount = 0 then
    begin
      ACount := Trunc(Span);
      if      (ACount div   1) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  1); MajorStepValue := 1;  end
      else if (ACount div   7) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount,  7); MajorStepValue := 7;  end
      else if (ACount div  14) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 14); MajorStepValue := 14; end
      else if (ACount div  31) <= MaxMajorTicks-1 then
        begin
          MajorCount        := TickDiv(ACount, 31);
          MajorStepValue    := 1;
          FMonthModeEnabled := True;
        end
      else if (ACount div  61) <= MaxMajorTicks-1 then
        begin
          MajorCount        := TickDiv(ACount, 61);
          MajorStepValue    := 2;
          FMonthModeEnabled := True;
        end
      else if (ACount div  92) <= MaxMajorTicks-1 then
        begin
          MajorCount        := TickDiv(ACount, 92);
          MajorStepValue    := 3;
          FMonthModeEnabled := True;
        end
      else if (ACount div  183) <= MaxMajorTicks-1 then
        begin
          MajorCount        := TickDiv(ACount, 183);
          MajorStepValue    := 6;
          FMonthModeEnabled := True;
        end
    end;

  if MajorCount = 0 then
    begin
      FYearModeEnabled := True;
      ACount           := Trunc(Span);
      BasePower        := 0;
      while True do
        begin
          Base := Trunc(Power(10, BasePower));
          if      (ACount div (1*Base*365)) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 1*Base*365); MajorStepValue := 1*Base; Break; end
          else if (ACount div (2*Base*365)) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 2*Base*365); MajorStepValue := 2*Base; Break; end
          else if (ACount div (5*Base*365)) <= MaxMajorTicks-1 then begin MajorCount := TickDiv(ACount, 5*Base*365); MajorStepValue := 5*Base; Break; end;
          Inc(BasePower);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.CalcPrice32Ticks(const Canvas: TCanvas; MaxMajorTicks: Integer; var MajorCount: Integer; var MajorStepValue: Double);
var
  BasePower : Integer;
  Base      : Integer;
begin
  if      (FSpan/( 1/256)) <= MaxMajorTicks then begin MajorCount := Trunc(FSpan /( 1/256)); MajorStepValue := (1/256); end
  else if (FSpan/( 2/256)) <= MaxMajorTicks then begin MajorCount := Trunc(FSpan /( 2/256)); MajorStepValue := (2/256); end
  else if (FSpan/( 4/256)) <= MaxMajorTicks then begin MajorCount := Trunc(FSpan /( 4/256)); MajorStepValue := (4/256); end
  else if (FSpan/( 1/ 32)) <= MaxMajorTicks then begin MajorCount := Trunc(FSpan /( 1/ 32)); MajorStepValue := (1/32);  end
  else if (FSpan/( 2/ 32)) <= MaxMajorTicks then begin MajorCount := Trunc(FSpan /( 2/ 32)); MajorStepValue := (2/32);  end
  else if (FSpan/( 4/ 32)) <= MaxMajorTicks then begin MajorCount := Trunc(FSpan /( 4/ 32)); MajorStepValue := (4/32);  end
  else if (FSpan/( 8/ 32)) <= MaxMajorTicks then begin MajorCount := Trunc(FSpan /( 8/ 32)); MajorStepValue := (8/32);  end
  else if (FSpan/(16/ 32)) <= MaxMajorTicks then begin MajorCount := Trunc(FSpan /(16/ 32)); MajorStepValue := (16/32); end;

  if MajorCount = 0 then
    begin
      BasePower := 0;
      while True do
        begin
          Base := Trunc(Power(10, BasePower));
          if      (FSpan/(1*Base))<=MaxMajorTicks then begin MajorCount:=Trunc(FSpan/(1*Base));MajorStepValue:=1*Base;Break;end
          else if (FSpan/(2*Base))<=MaxMajorTicks then begin MajorCount:=Trunc(FSpan/(2*Base));MajorStepValue:=2*Base;Break;end
          else if (FSpan/(5*Base))<=MaxMajorTicks then begin MajorCount:=Trunc(FSpan/(5*Base));MajorStepValue:=5*Base;Break;end;
          Inc(BasePower);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.CalcLog10Ticks(const Canvas : TCanvas; MaxMajorTicks: Integer);
var
  x               : Integer;
  CurrentPosition : Double;
  MinorPosition   : Double;
  BasePower       : Double;
  LogMin          : Double;
  StepSize        : Double;
  Log10Span       : Double;
begin
  with Canvas do
    begin
      if FMin <= 0 then LogMin := 1 else LogMin := FMin;

      Log10Span := Log10(Max) - Log10(Min);

      StepSize := 1;
      if Log10Span/StepSize > MaxMajorTicks then
        begin
          if Log10Span/StepSize > MaxMajorTicks then StepSize := 1;
          if Log10Span/StepSize > MaxMajorTicks then StepSize := 2;
          if Log10Span/StepSize > MaxMajorTicks then StepSize := 5;
          if Log10Span/StepSize > MaxMajorTicks then StepSize := 10;
          if Log10Span/StepSize > MaxMajorTicks then StepSize := 20;
          if Log10Span/StepSize > MaxMajorTicks then StepSize := 50;
          if Log10Span/StepSize > MaxMajorTicks then StepSize := 100;
          if Log10Span/StepSize > MaxMajorTicks then StepSize := 200;
          BasePower := Int(Log10(LogMin));
        end
      else
        begin
          BasePower := Int(Log10(FMin)) - 1;
        end;

      CurrentPosition := Power(10, BasePower);

      while CurrentPosition <= (LogMin + FSpan) do
        begin
          if PointOnScale(CurrentPosition) then AddTick(CurrentPosition, ipttMajor);
          if StepSize = 1 then
            begin
              for x := 2 to 9 do
                begin
                  MinorPosition := CurrentPosition*x;
                  if PointOnScale(MinorPosition) then AddTick(MinorPosition, ipttMinor);
                end;
            end;
          BasePower       := BasePower + StepSize;
          CurrentPosition := Power(10, BasePower);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.Zoom(Value: Double);
var
  NewMin  : Double;
  NewSpan : Double;
  Center  : Double;
begin
  case FScaleType of
    ipstLinear : begin
                   if Value <=0 then raise Exception.Create('Linear Scale Zoom Factor must be Greater than Zero');
                   NewSpan := FSpan * Value;
                   Center  := (Min + Max)/2;
                   NewMin  :=  Center - NewSpan/2;
                   SetMinSpan(NewMin, NewSpan);
                 end;
    ipstLog10  : begin
                   NewMin  := FMin  / Power(10, Value);
                   NewSpan := FSpan * Power(10, Value);
                   SetMinSpan(NewMin, NewSpan);
                 end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ZoomPercentByReference(RefMin, RefSpan, RefMax, Percent: Double);
var
  NewMin  : Double;
  NewSpan : Double;
  Center  : Double;
begin
  case FScaleType of
    ipstLinear : begin
                   NewSpan := RefSpan * 1/Power(10,Percent);
                   Center  := (Min + Max)/2;
                   NewMin  :=  Center - NewSpan/2;

                   SetMinSpan(NewMin, NewSpan);
                 end;
    ipstLog10  : begin
                   NewMin  := RefMin * Power(10, Percent);
                   NewSpan := RefSpan / Power(10, Percent);
                   SetMinSpan(NewMin, NewSpan);
                 end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ScrollPercentByReference(RefMin, RefSpan, RefMax, Percent: Double);
var
  Decades : Double;
  NewMin  : Double;
  NewMax  : Double;
begin
  case
    FScaleType of
      ipstLinear : begin
                     NewMin := RefMin + Percent*RefSpan;

                     if FScrollMinMaxEnabled then
                       begin
                         if       NewMin       <= FScrollMin then NewMin := FScrollMin
                         else if (NewMin+Span) >= FScrollMax then NewMin := FScrollMax - Span
                       end;

                     SetMinSpan(NewMin, Span);
                   end;
      ipstLog10  : begin
                     Decades := Log10(RefMax) - Log10(RefMin);
                     NewMin  := RefMin *Power(10, Percent*Decades);
                     NewMax  := RefMax *Power(10, Percent*Decades);

                     if FScrollMinMaxEnabled then
                       begin
                         if NewMin <= FScrollMin then
                           begin
                             NewMin := FScrollMin;
                             NewMax := FScrollMin * Power(10, Decades);
                           end
                         else if (NewMin+Span) >= FScrollMax then
                           begin
                             NewMin := FScrollMax/Power(10, Decades);
                             NewMax := FScrollMax;
                           end;
                       end;

                     SetMinSpan(NewMin, NewMax - NewMin);
                   end;
  end;
end;
//******************************************************************************************************************************
procedure TiPlotAxis.AdjustToIncrement;
var
  AOldMin    : Double;
  AOldMax    : Double;

  ANewMin    : Double;
  ANewMax    : Double;

  AIncrement : Double;
begin
  if TrackingIncrementStyle = iptisMinimum then Exit;

  if TrackingIncrementStyle = iptisMajor then AIncrement := FMajorIncrement
  else                                        AIncrement := FMinorIncrement;

  AOldMin := Min;
  AOldMax := Max;

  ANewMin := AOldMin;
  ANewMax := AOldMax;

  if AOldMax/AIncrement <> Trunc(AOldMax/AIncrement) then ANewMax := Trunc(AOldMax/AIncrement)*AIncrement;
  if AOldMin/AIncrement <> Trunc(AOldMin/AIncrement) then ANewMin := Trunc(AOldMin/AIncrement)*AIncrement;

  if (ANewMax < AOldMax) then ANewMax := ANewMax + AIncrement;
  if (ANewMin > AOldMin) then ANewMin := ANewMin - AIncrement;

  if (AOldMin <> ANewMin) or (AOldMax <> ANewMax) then SetMinSpan(ANewMin, ANewMax - ANewMin);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.NewTrackingData(Value: Double);
var
  NewMin    : Double;
  NewSpan   : Double;
  OldMax    : double;
  MarginPos : Double;
begin
  if not TrackingEnabled then Exit;

  NewMin  := FMin;
  NewSpan := FSpan;
  OldMax  := Max;

  if not FFirstAlignDone then
    begin
      FFirstAlignDone := True;
      case FTrackingAlignFirstStyle of
        ipafsAuto : if (Value < FMin) or (Value > (Max)) then NewMin := Value;
        ipafsMax  :                                           NewMin := Value - FSpan;
        ipafsMin  :                                           NewMin := Value;
        ipafsNone :                                           Exit;
      end;
      SetMinSpan(NewMin, NewSpan);
      exit;
    end;

  case FTrackingStyle of
    iptsScaleMinMax        : begin
                               if Value > (NewMin + Span)  then NewSpan := Value-NewMin;
                               if Value < (NewMin)         then NewMin  := Value;

                               SetMinSpan(NewMin, NewSpan);
                               AdjustToIncrement;
                             end;
    iptsScaleMax           : begin
                               if Value > (Max) then
                                 begin
                                   NewSpan := Span + (Value - Max);
                                   SetMinSpan(NewMin, NewSpan);
                                   AdjustToIncrement;
                                 end;
                             end;
    iptsScaleMin           : begin
                               if Value < (Min) then
                                 begin
                                   NewMin  := Value;
                                   NewSpan := OldMax - NewMin;
                                   SetMinSpan(NewMin, NewSpan);
                                   AdjustToIncrement;
                                 end;
                             end;

    iptsScrollSmooth,
    iptsScrollPage         : begin
                               if Value > (NewMin + Span) then
                                 begin
                                   if FTrackingScrollCompressMax <> 0 then
                                     begin
                                       if FSpan < (Value-NewMin)             then NewSpan := Value-NewMin;
                                       if FSpan > FTrackingScrollCompressMax then NewSpan := FTrackingScrollCompressMax;
                                     end;
                                   case FTrackingStyle of
                                     iptsScrollSmooth : if Value > (NewMin + Span) then NewMin := Value  - NewSpan;
                                     iptsScrollPage   : if Value > (NewMin + Span) then NewMin := NewMin + NewSpan;
                                   end;
                                 end
                               else
                                 begin
                                   case FTrackingStyle of
                                     iptsScrollSmooth : if Value < Min then NewMin := Value;
                                     iptsScrollPage   : if Value < Min then NewMin := NewMin - NewSpan;
                                   end;
                                 end;
                               SetMinSpan(NewMin, NewSpan);
                             end;
    iptsExpandCollapse     : begin
                               ZoomToFit;
                               AdjustToIncrement;
                             end;
    iptsExpandCollapseFast : begin
                               ZoomToFitFast;
                               AdjustToIncrement;
                             end;
    iptsExpandMinMax       : begin
                               if Value > (Max) then NewSpan := NewSpan + (Value - Max);
                               if Value < (Min) then
                                 begin
                                   NewSpan := Span + (Min - Value);
                                   NewMin  := Value;
                                 end;

                               SetMinSpan(NewMin, NewSpan);
                               AdjustToIncrement;
                             end;
  end;

  if (TrackingSpanMinimum <> 0) and (Span < TrackingSpanMinimum) then
    begin
      SetMinSpan(Mid - TrackingSpanMinimum/2, TrackingSpanMinimum);
    end;

  if (TrackingMinMargin <> 0) then
    begin
      MarginPos := Min + TrackingMinMargin;
      if MarginPos > Value then SetMinSpan(Min - (MarginPos - Value), Span);
    end;

  if (TrackingMaxMargin <> 0) then
    begin
      MarginPos := Max - TrackingMaxMargin;
      if Value > MarginPos then SetMinSpan(Min, Span + (Value - MarginPos));
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ResetFirstAlign;
begin
  FFirstAlignDone := False;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.TrackingEnabledMenuItemClick(Sender: TObject);
begin
  TrackingEnabled := not TrackingEnabled;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.UpdateResumeValuesMenuItemClick(Sender: TObject);
begin
  UpdateResumeValues;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ZoomToFitClick(Sender: TObject);
begin
  ZoomToFit;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetMax: Double;
begin
  Result := FMin + FSpan;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetMid: Double;
begin
  Result := FMin + FSpan/2;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetMousePointer(APoint: TPoint): TCursor;
begin
  case FMode of
    ipamScroll  : if Horizontal then Result := crHandPoint else Result := crHandPoint;
    ipamZoom    : if Horizontal then Result := crSizeWE else Result := crSizeNS;
    else          Result := crDefault;
  end;

  TiPlotComponentAccess(Owner).DoGetMouseCursor(Self, Result);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.ValueOnScale(const Value: Double): Boolean;
begin
  Result := PointOnScale(Value);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetLabelTextAdjust(const Value: Double): String;
begin
  FAllowLabelMinAdjust := True;
  try
    Result := GetLabelText(Value);
  finally
    FAllowLabelMinAdjust := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                                                      then Exit;
  if not (Sender as TiPlotObject).UserSelected                          then Exit;
  if Sender is TiPlotAxis and ((ssShift in Shift) or (ssCtrl in Shift)) then Exit;

  SetUserSelected(False);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.PositionToPercent(const Value: Double): Double;
begin
  if FReverseScale then Result := (Max   - Value)/Span
    else                Result := (Value - FMin )/Span;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.PercentToPosition(const Value: Double): Double;
var
  Decades : Double;
  SpanPercent : Double;
begin
  SpanPercent := StopPercent - StartPercent;
  if SpanPercent <= 0 then
    begin
      Result := 0;
      Exit;
    end;

  case FScaleType of
    ipstLinear : begin
                   if FReverseScale then Result := Max  - Value*Span
                     else                Result := FMin + (Value*100 - StartPercent)/(StopPercent - StartPercent) *Span;
                 end;
    ipstLog10  : begin
                   Decades := Log10(Max)-Log10(Min);
                   if FReverseScale then Result := Power(10, (1 - Value)*Decades + Log10(FMin))
                     else                Result := Power(10, (    Value)*Decades + Log10(FMin));
                 end;
    else Result := FMin;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.PixelsToPosition(const Value: Integer): Double;
var
  Decades : Double;
begin
  Result := FMin;

  case FScaleType of
    ipstLinear : if Horizontal then
                   begin
                     if (FScaleRect.Right = FScaleRect.Left) then Exit;
                     if FReverseScale then Result := (FScaleRect.Right - Value          ) /(FScaleRect.Right - FScaleRect.Left)*FSpan + FMin
                       else                Result := (Value            - FScaleRect.Left) /(FScaleRect.Right - FScaleRect.Left)*FSpan + FMin;
                   end
                 else
                   begin
                     if (FScaleRect.Bottom = FScaleRect.Top) then Exit;
                     if FReverseScale then Result := (Value             -  FScaleRect.Top)/(FScaleRect.Bottom - FScaleRect.Top)*FSpan + FMin
                       else                Result := (FScaleRect.Bottom - Value          )/(FScaleRect.Bottom - FScaleRect.Top)*FSpan + FMin;
                   end;
    ipstLog10  : begin
                   Decades := Log10(Max)-Log10(Min);
                   if Horizontal then
                     begin
                       if (FScaleRect.Right = FScaleRect.Left) then Exit;
                       if FReverseScale then Result := Power(10, (FScaleRect.Right - Value          )/(FScaleRect.Right - FScaleRect.Left)*Decades + Log10(FMin))
                         else                Result := Power(10, (Value            - FScaleRect.Left)/(FScaleRect.Right - FScaleRect.Left)*Decades + Log10(FMin));
                     end
                   else
                     begin
                       if (FScaleRect.Bottom = FScaleRect.Top) then Exit;
                       if FReverseScale then Result := Power(10, (Value             - FScaleRect.Top)/(FScaleRect.Bottom - FScaleRect.Top)*Decades + Log10(FMin))
                         else                Result := Power(10, (FScaleRect.Bottom - Value         )/(FScaleRect.Bottom - FScaleRect.Top)*Decades + Log10(FMin));
                     end;
                 end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.WidthToPixels(const Value: Double): Integer;
begin
  Result := ABS(PositionToPixels(Min + Value) - PositionToPixels(Min));
end;
//****************************************************************************************************************************************************
function TiPlotAxis.PositionToPixels(const Value: Double): Integer;
var
  LogMin     : Double;
  LogSpan    : Double;
  LogValue   : Double;
  TempResult : Int64;
begin
  Result := 0;

  if FActualStart = FActualStop then
    begin
      Result := (FActualStart + FActualStop) div 2;
      Exit;
    end;

  if FSpan <= 1E-300 then
    begin
      Result := (FActualStart + FActualStop) div 2;
      Exit;
    end;

  case ScaleType of
    ipstLinear : begin
                   TempResult := FActualStart - Round((Value - FMin)*FPixelsPerSpanUnit);
                   if      TempResult >  32000 then TempResult :=  32000
                   else if TempResult < -32000 then TempResult := -32000;
                   Result := TempResult;
                 end
    else         begin
                   if FMin  <= 0 then LogMin   := 1 else LogMin   := FMin;
                   if FSPan <= 0 then LogSpan  := 1 else LogSpan  := FSpan;
                   if Value <= 0 then LogValue := 1 else LogValue := Value;
                   if Log10(LogMin+LogSpan) - Log10(LogMin) <> 0 then
                     Result := FActualStart - Round((FActualStart - FActualStop) * (Log10(LogValue) - Log10(LogMin))/(Log10(LogMin+LogSpan) - Log10(LogMin)));
                 end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetMaxPixels: Integer;
begin
  Result := PositionToPixels(Max);
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetMinPixels: Integer;
begin
  Result := PositionToPixels(Min);
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ZoomToFit;
var
  x              : Integer;
  ChannelManager : TiPlotChannelManager;
  Channel        : TiPlotChannelCustomAccess;
  MaxValue       : Double;
  MinValue       : Double;
  TempValue      : Double;
  NewSpan        : Double;
begin
  MaxValue := -1e300;
  MinValue :=  1e300;
  ChannelManager := TiPlotComponentAccess(Owner).Master.ChannelManager;
  for x := 0 to ChannelManager.Count-1 do
    begin
      Channel := TiPlotChannelCustomAccess(ChannelManager.Items[x]);
      if Self is TiPlotYAxis then
        begin
          if UpperCase(Channel.YAxisName) = UpperCase(Name) then
            begin
              TempValue := Channel.GetVisibleMaxY;
              if TempValue > MaxValue then MaxValue := TempValue;
              TempValue := Channel.GetVisibleMinY;
              if TempValue < MinValue then MinValue := TempValue;
            end;
        end
      else
        begin
          if UpperCase(Channel.XAxisName) = UpperCase(Name) then
            begin
              TempValue := Channel.GetVisibleMaxX;
              if TempValue > MaxValue then MaxValue := TempValue;
              TempValue := Channel.GetVisibleMinX;
              if TempValue < MinValue then MinValue := TempValue;
            end;
        end;
    end;
  if (MaxValue > -1e299) and (MinValue < 1e299) and (MaxValue <> MinValue) then
    begin
      NewSpan := MaxValue - MinValue;
      if ((FTrackingSpanMinimum <> 0) and (NewSpan < FTrackingSpanMinimum)) then NewSpan := FTrackingSpanMinimum;
      SetMinSpan(MinValue - FTrackingMinMargin, NewSpan + FTrackingMaxMargin + FTrackingMinMargin);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.ZoomToFitFast;
var
  x              : Integer;
  ChannelManager : TiPlotChannelManager;
  Channel        : TiPlotChannelCustomAccess;
  MaxValue       : Double;
  MinValue       : Double;
  TempValue      : Double;
begin
  MaxValue := -1e300;
  MinValue :=  1e300;
  ChannelManager := TiPlotComponentAccess(Owner).Master.ChannelManager;
  for x := 0 to ChannelManager.Count-1 do
    begin
      Channel := TiPlotChannelCustomAccess(ChannelManager.Items[x]);
      if Self is TiPlotYAxis then
        begin
          if UpperCase(Channel.YAxisName) = UpperCase(Name) then
            begin
              TempValue := Channel.RunningYMax;
              if TempValue > MaxValue then MaxValue := TempValue;
              TempValue := Channel.RunningYMin;
              if TempValue < MinValue then MinValue := TempValue;
            end;
        end
      else
        begin
          if UpperCase(Channel.XAxisName) = UpperCase(Name) then
            begin
              TempValue := Channel.RunningXMax;
              if TempValue > MaxValue then MaxValue := TempValue;
              TempValue := Channel.RunningXMin;
              if TempValue < MinValue then MinValue := TempValue;
            end;
        end;
    end;
  if (MaxValue > -1e299) and (MinValue < 1e299) and (MaxValue <> MinValue) then
    begin
      SetMinSpan(MinValue - FTrackingMinMargin, MaxValue - MinValue + FTrackingMaxMargin + FTrackingMinMargin);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotAxis.iMouseHitTest(MouseData: TiPlotMouseData): Boolean;
begin
  Result := PtInRect(FFocusRect, Point(MouseData.X, MouseData.Y));
end;
//****************************************************************************************************************************************************
function TiPlotAxis.GetActualMode: TiPlotAxisMode;
begin
  Result := FMode;
  if GetCtrlDown then
    if Result = ipamScroll then Result := ipamZoom else Result := ipamScroll;
end;
//****************************************************************************************************************************************************
procedure TiPlotAxis.SetMinSpan(NewMin, NewSpan: Double);
var
  OldMin  : Double;
  OldSpan : Double;
begin
  if ScaleType = ipstLog10 then
    begin
      if NewMin  <= 0 then NewMin  := 1;
      if NewSpan <= 0 then NewSpan := 1;
    end;

  if (NewMin <> Min) or (NewSpan <> Span) then
    begin
      OldMin  := Min;
      OldSpan := Span;

      BlockMinSpanEvents := True;
      try
        Min  := NewMin;
        Span := NewSpan;
      finally
        BlockMinSpanEvents := False;
      end;

      if Owner is TiPlotComponent then
        begin
          if NewMin  <> OldMin  then TiPlotComponentAccess(Owner).DoAxesMinChange    (Self, OldMin,  NewMin);
          if NewSpan <> OldSpan then TiPlotComponentAccess(Owner).DoAxesSpanChange   (Self, OldSpan, NewSpan);
                                     TiPlotComponentAccess(Owner).DoAxesMinSpanChange(Self, OldMin, OldSpan, Min, Span);
        end;
    end;
end;
//****************************************************************************************************************************************************
end.
