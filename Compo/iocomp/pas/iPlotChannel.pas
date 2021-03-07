{*******************************************************}
{                                                       }
{       TiPlotChannel                                   }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotChannel;{$endif}
{$ifdef iCLX}unit QiPlotChannel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iMath,  iClasses,  iPlotObjects,  iPlotDataNullList,  iPlotChannelCustom,  iOPCManager,  iPlotAxis, iOPCItem;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiMath, QiClasses, QiPlotObjects, QiPlotDataNullList, QiPlotChannelCustom, QiOPCManager, QiPlotAxis;          {$ENDIF}

type
  TiPlotDigitalReferenceStyle = (ipdrScale, ipdrPercent);
  TiPlotInterpolationStyle    = (ipistStraightLine, ipistCubicSpline, ipistPolynomial, ipistRational, ipistDifferential, ipistDifferentialTerminated);
  TiPlotHighLowStyle          = (iphlsOpenClose, iphlsCandleStick);
  TiOPCXValueSourceStyle      = (iopcxvsOPCServerTimeStamp, iopcxvsSystemTimeStamp, iopcxvsElapsedTime, iopcxvsElapsedSeconds, iopcxvsOPCItem);

  TiPlotPixelPoint = class(TObject)
  public
    Null   : Boolean;
    XPixel : Integer;
    YValue : Double;
  end;

  TiPlotChannel = class(TiPlotChannelCustom)
  private
    FPixelList                      : TStringList;
    FPixelListStart                 : Integer;
    FPixelListStop                  : Integer;

    FPixelsHigh                     : Integer;
    FPixelsLow                      : Integer;

    FXIncreasing                    : Boolean;

    FFastDrawEnabled                : Boolean;
    FAllowOutOfOrderXValues         : Boolean;
    FDrawOutOfOrderXValues          : Boolean;
    FResetStartTimeOnFirstDataPoint : Boolean;
    FInterpolationStyle             : TiPlotInterpolationStyle;
    FElapsedStartTime               : Double;

    FFillEnabled                    : Boolean;
    FFillReference                  : Double;
    FFillUseChannelColor            : Boolean;
    FFillStyle                      : TBrushStyle;
    FFillColor                      : TColor;

    FHighLowStyle                   : TiPlotHighLowStyle;
    FHighLowEnabled                 : Boolean;
    FHighLowBarColor                : TColor;
    FHighLowBarWidth                : Double;
    FHighLowOpenShow                : Boolean;
    FHighLowOpenColor               : TColor;
    FHighLowOpenWidth               : Double;
    FHighLowOpenHeight              : Double;
    FHighLowCloseShow               : Boolean;
    FHighLowCloseColor              : TColor;
    FHighLowCloseWidth              : Double;
    FHighLowCloseHeight             : Double;
    FHighLowShadowColor             : TColor;
    FHighLowBullishColor            : TColor;
    FHighLowBearishColor            : TColor;

    FDigitalEnabled                 : Boolean;
    FDigitalReferenceLow            : Double;
    FDigitalReferenceHigh           : Double;
    FDigitalReferenceStyle          : TiPlotDigitalReferenceStyle;

    {$IFDEF iVCL}
    FOPCXValueSource                : TiOPCXValueSourceStyle;
    FOPCManager                     : TiOPCManager;
    FOPCItemManager                 : TiOPCItemManager;
    {$endif}

    FBarEnabled                     : Boolean;
    FBarPenUseChannelColor          : Boolean;
    FBarBrushUseChannelColor        : Boolean;

    {$IFDEF iVCL}
    procedure AfterGroupUpdate(Sender: TObject; GroupName: String);
    {$endif}
  protected
    procedure SetFastDrawEnabled               (const Value: Boolean);
    procedure SetAllowOutOfOrderXValues        (const Value: Boolean);
    procedure SetDrawOutOfOrderXValues         (const Value: Boolean);
    procedure SetResetStartTimeOnFirstDataPoint(const Value: Boolean);

    procedure SetInterpolationStyle            (const Value: TiPlotInterpolationStyle);

    procedure SetFillEnabled                   (const Value: Boolean);
    procedure SetFillReference                 (const Value: Double);
    procedure SetFillStyle                     (const Value: TBrushStyle);
    procedure SetFillColor                     (const Value: TColor);
    procedure SetFillUseChannelColor           (const Value: Boolean);

    procedure SetDigitalEnabled                (const Value: Boolean);
    procedure SetDigitalReferenceStyle         (const Value: TiPlotDigitalReferenceStyle);
    procedure SetDigitalReferenceHigh          (const Value: Double);
    procedure SetDigitalReferenceLow           (const Value: Double);

    procedure SetBarEnabled                    (const Value: Boolean);
    procedure SetBarWidth                      (const Value: Double);
    procedure SetBarReference                  (const Value: Double);
    procedure SetBarPenColor                   (const Value: TColor);
    procedure SetBarPenUseChannelColor         (const Value: Boolean);
    procedure SetBarPenStyle                   (const Value: TPenStyle);
    procedure SetBarPenWidth                   (const Value: Integer);
    procedure SetBarBrushColor                 (const Value: TColor);
    procedure SetBarBrushUseChannelColor       (const Value: Boolean);
    procedure SetBarBrushStyle                 (const Value: TBrushStyle);

    procedure SetHighLowStyle                  (const Value: TiPlotHighLowStyle);
    procedure SetHighLowEnabled                (const Value: Boolean);
    procedure SetHighLowBarColor               (const Value: TColor);
    procedure SetHighLowBarWidth               (const Value: Double);
    procedure SetHighLowOpenShow               (const Value: Boolean);
    procedure SetHighLowOpenColor              (const Value: TColor);
    procedure SetHighLowOpenWidth              (const Value: Double);
    procedure SetHighLowOpenHeight             (const Value: Double);
    procedure SetHighLowCloseShow              (const Value: Boolean);
    procedure SetHighLowCloseColor             (const Value: TColor);
    procedure SetHighLowCloseWidth             (const Value: Double);
    procedure SetHighLowCloseHeight            (const Value: Double);
    procedure SetHighLowShadowColor            (const Value: TColor);
    procedure SetHighLowBullishColor           (const Value: TColor);
    procedure SetHighLowBearishColor           (const Value: TColor);

    function  GetBarReference : Double;
    function  GetBarWidth     : Double;
    function  GetBarPenColor  : TColor;
    function  GetBarPenWidth  : Integer;
    function  GetBarPenStyle  : TPenStyle;
    function  GetBarBrushColor: TColor;
    function  GetBarBrushStyle: TBrushStyle;

    function  GetDataHigh         (const Index: Integer): Double;
    function  GetDataLow          (const Index: Integer): Double;
    function  GetDataOpen         (const Index: Integer): Double;
    function  GetDataClose        (const Index: Integer): Double;

    function  GetDataBarVisible   (const Index: Integer): Boolean;
    function  GetDataBarReference (const Index: Integer): Double;
    function  GetDataBarWidth     (const Index: Integer): Double;
    function  GetDataBarPenColor  (const Index: Integer): TColor;
    function  GetDataBarPenWidth  (const Index: Integer): Integer;
    function  GetDataBarPenStyle  (const Index: Integer): TPenStyle;
    function  GetDataBarBrushColor(const Index: Integer): TColor;
    function  GetDataBarBrushStyle(const Index: Integer): TBrushStyle;

    procedure SetDataHigh         (const Index: Integer; const Value: Double);
    procedure SetDataLow          (const Index: Integer; const Value: Double);
    procedure SetDataOpen         (const Index: Integer; const Value: Double);
    procedure SetDataClose        (const Index: Integer; const Value: Double);

    procedure SetDataBarVisible   (const Index: Integer; const Value: Boolean);
    procedure SetDataBarReference (const Index: Integer; const Value: Double);
    procedure SetDataBarWidth     (const Index: Integer; const Value: Double);
    procedure SetDataBarPenColor  (const Index: Integer; const Value: TColor);
    procedure SetDataBarPenWidth  (const Index: Integer; const Value: Integer);
    procedure SetDataBarPenStyle  (const Index: Integer; const Value: TPenStyle);
    procedure SetDataBarBrushColor(const Index: Integer; const Value: TColor);
    procedure SetDataBarBrushStyle(const Index: Integer; const Value: TBrushStyle);

   {$IFDEF iVCL}
    procedure SetOPCGroupName   (const Value: String);
    procedure SetOPCComputerName(const Value: String);
    procedure SetOPCItemName    (const Value: String);
    procedure SetOPCItem2Name   (const Value: String);
    procedure SetOPCServerName  (const Value: String);
    procedure SetOPCUpdateRate  (const Value: Integer);
    procedure SetOPCScalar      (const Value: Double);
    procedure SetOPCOffset      (const Value: Double);
    procedure SetOPCScalar2     (const Value: Double);
    procedure SetOPCOffset2     (const Value: Double);
    procedure SetOPCAutoConnect (const Value: Boolean);

    function GetOPCGroupName    : String;
    function GetOPCComputerName : String;
    function GetOPCItemName     : String;
    function GetOPCItem2Name    : String;
    function GetOPCServerName   : String;
    function GetOPCUpdateRate   : Integer;
    function GetOPCScalar       : Double;
    function GetOPCOffset       : Double;
    function GetOPCScalar2      : Double;
    function GetOPCOffset2      : Double;
    function GetOPCAutoConnect  : Boolean;
    function GetOPCActive       : Boolean;
    function GetOPCQualityGood  : Boolean;

    procedure OPCNewData(Sender: TObject);
    {$endif}

    procedure CalcStartXIndex; override;
    procedure CalcStopXIndex;  override;

    procedure CheckForValidXValue(const X: Double);

    function CalcXIndexIncreasing(TargetValue: Double): Integer;
    function CalcXIndexDecreasing(TargetValue: Double): Integer;

    function  GetVisibleMaxX : Double; override;
    function  GetVisibleMinX : Double; override;
    function  GetVisibleMaxY : Double; override;
    function  GetVisibleMinY : Double; override;

    function  GetBarRect(DataIndex: Integer): TRect;

    procedure DataCursorUpate(Sender: TObject); override;

    function  DoYLookup(XValue: Double; var YValue: Double): TiPlotDataPointStatus;

    function  GetDataCursorDisplayText(Style: TiPlotDataCursorStyle; XValue, YValue: Double; Status: TiPlotDataPointStatus): String;

    procedure DrawSetup             (const Canvas: TCanvas);                                override;
    procedure Draw                  (const Canvas: TCanvas; const BackGroundColor: TColor); override;
    procedure DrawFill              (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawBar               (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawHighLow           (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawHighLowCandleStick(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawConnectPoints     (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor); override;
    procedure DrawMarkers           (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor); override;
    procedure DrawDigital           (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawFast              (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawDigitalSequence   (Canvas: TCanvas; XYAxisReverse: Boolean; SequenceData: TDigitalSequenceData);
    procedure DrawCubicSpline       (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawCubicSplineSet    (Canvas: TCanvas; XYAxisReverse: Boolean; XArray, YArray, Y2Array: DoubleDynamicArray; Size: Integer);
    procedure DrawPolynomial        (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawRational          (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawDifferential      (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
    procedure DrawPointSet          (const Canvas: TCanvas; const XYAxisReverse: Boolean; const Point1, Point2, Point3: TiPlotMinMaxPoint);

    function  iMouseHitTest(MouseData: TiPlotMouseData): Boolean;                                               override;
    procedure Loaded;                                                                                           override;

    procedure AddPixelListValue(XPixel: Integer; YValue: Double);
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent); override;
    destructor  Destroy;                                                                           override;
    function GetYInterpolated(XValue: Double; var YValue: Double): Boolean;

    function AddXNull          (X                          : Double): Integer;
    function AddXEmpty         (X                          : Double): Integer;
    function AddHighLow        (X,   High, Low, Open, Close: Double): Integer;
    function AddYNow           (   Y                       : Double): Integer;
    function AddYElapsedTime   (   Y                       : Double): Integer;
    function AddYElapsedSeconds(   Y                       : Double): Integer;

    function AddXY         (const X, Y :Double): Integer; override;
    procedure AddYArray(XInterval: Double; YData: Variant);

    procedure ResetElapsedStartTime;

    function CalcIndex(TargetValue: Double): Integer;

   {$IFDEF iVCL}
    procedure OPCActivate;
    procedure OPCActivateSuspend;
    procedure OPCDeactivate;
    procedure OPCUpdateSuspend;
    procedure OPCUpdateResume;

    property OPCActive                              : Boolean      read GetOPCActive;
    property OPCQualityGood                         : Boolean      read GetOPCQualityGood;
    {$endif}

    property DataHigh         [const Index: Integer]: Double       read GetDataHigh              write SetDataHigh;
    property DataLow          [const Index: Integer]: Double       read GetDataLow               write SetDataLow;
    property DataOpen         [const Index: Integer]: Double       read GetDataOpen              write SetDataOpen;
    property DataClose        [const Index: Integer]: Double       read GetDataClose             write SetDataClose;

    property DataBarVisible   [const Index: Integer]: Boolean      read GetDataBarVisible        write SetDataBarVisible;
    property DataBarReference [const Index: Integer]: Double       read GetDataBarReference      write SetDataBarReference;
    property DataBarWidth     [const Index: Integer]: Double       read GetDataBarWidth          write SetDataBarWidth;
    property DataBarPenColor  [const Index: Integer]: TColor       read GetDataBarPenColor       write SetDataBarPenColor;
    property DataBarPenWidth  [const Index: Integer]: Integer      read GetDataBarPenWidth       write SetDataBarPenWidth;
    property DataBarPenStyle  [const Index: Integer]: TPenStyle    read GetDataBarPenStyle       write SetDataBarPenStyle;
    property DataBarBrushColor[const Index: Integer]: TColor       read GetDataBarBrushColor     write SetDataBarBrushColor;
    property DataBarBrushStyle[const Index: Integer]: TBrushStyle  read GetDataBarBrushStyle     write SetDataBarBrushStyle;

    property ElapsedStartTime               : Double                      read FElapsedStartTime               write FElapsedStartTime;
  published
    property FastDrawEnabled                : Boolean                     read FFastDrawEnabled                write SetFastDrawEnabled                default True;
    property AllowOutOfOrderXValues         : Boolean                     read FAllowOutOfOrderXValues         write SetAllowOutOfOrderXValues         default True;
    property DrawOutOfOrderXValues          : Boolean                     read FDrawOutOfOrderXValues          write SetDrawOutOfOrderXValues          default False;
    property ResetStartTimeOnFirstDataPoint : Boolean                     read FResetStartTimeOnFirstDataPoint write SetResetStartTimeOnFirstDataPoint default False;
    property InterpolationStyle             : TiPlotInterpolationStyle    read FInterpolationStyle             write SetInterpolationStyle             default ipistStraightLine;

    property FillEnabled                    : Boolean                     read FFillEnabled                    write SetFillEnabled                    default False;
    property FillReference                  : Double                      read FFillReference                  write SetFillReference;
    property FillStyle                      : TBrushStyle                 read FFillStyle                      write SetFillStyle                      default bsSolid;
    property FillColor                      : TColor                      read FFillColor                      write SetFillColor                      default clBlack;
    property FillUseChannelColor            : Boolean                     read FFillUseChannelColor            write SetFillUseChannelColor            default True;

    property DigitalEnabled                 : Boolean                     read FDigitalEnabled                 write SetDigitalEnabled                 default False;
    property DigitalReferenceStyle          : TiPlotDigitalReferenceStyle read FDigitalReferenceStyle          write SetDigitalReferenceStyle          default ipdrScale;
    property DigitalReferenceLow            : Double                      read FDigitalReferenceLow            write SetDigitalReferenceLow;
    property DigitalReferenceHigh           : Double                      read FDigitalReferenceHigh           write SetDigitalReferenceHigh;

    property HighLowStyle                   : TiPlotHighLowStyle          read FHighLowStyle                   write SetHighLowStyle                   default iphlsOpenClose;
    property HighLowEnabled                 : Boolean                     read FHighLowEnabled                 write SetHighLowEnabled                 default False;
    property HighLowBarColor                : TColor                      read FHighLowBarColor                write SetHighLowBarColor                default clBlue;
    property HighLowBarWidth                : Double                      read FHighLowBarWidth                write SetHighLowBarWidth;
    property HighLowOpenShow                : Boolean                     read FHighLowOpenShow                write SetHighLowOpenShow                default True;
    property HighLowOpenColor               : TColor                      read FHighLowOpenColor               write SetHighLowOpenColor               default clGreen;
    property HighLowOpenWidth               : Double                      read FHighLowOpenWidth               write SetHighLowOpenWidth;
    property HighLowOpenHeight              : Double                      read FHighLowOpenHeight              write SetHighLowOpenHeight;
    property HighLowCloseShow               : Boolean                     read FHighLowCloseShow               write SetHighLowCloseShow               default True;
    property HighLowCloseColor              : TColor                      read FHighLowCloseColor              write SetHighLowCloseColor              default clRed;
    property HighLowCloseWidth              : Double                      read FHighLowCloseWidth              write SetHighLowCloseWidth;
    property HighLowCloseHeight             : Double                      read FHighLowCloseHeight             write SetHighLowCloseHeight;
    property HighLowShadowColor             : TColor                      read FHighLowShadowColor             write SetHighLowShadowColor             default clGray;
    property HighLowBullishColor            : TColor                      read FHighLowBullishColor            write SetHighLowBullishColor            default clWhite;
    property HighLowBearishColor            : TColor                      read FHighLowBearishColor            write SetHighLowBearishColor            default clGray;

    property BarEnabled                     : Boolean                     read FBarEnabled                     write SetBarEnabled                     default False;
    property BarPenUseChannelColor          : Boolean                     read FBarPenUseChannelColor          write SetBarPenUseChannelColor          default True;
    property BarBrushUseChannelColor        : Boolean                     read FBarBrushUseChannelColor        write SetBarBrushUseChannelColor        default True;

    property BarReference                   : Double                      read GetBarReference                 write SetBarReference;
    property BarWidth                       : Double                      read GetBarWidth                     write SetBarWidth;
    property BarPenColor                    : TColor                      read GetBarPenColor                  write SetBarPenColor                    default clRed;
    property BarPenWidth                    : Integer                     read GetBarPenWidth                  write SetBarPenWidth                    default 0;
    property BarPenStyle                    : TPenStyle                   read GetBarPenStyle                  write SetBarPenStyle                    default psSolid;
    property BarBrushColor                  : TColor                      read GetBarBrushColor                write SetBarBrushColor                  default clRed;
    property BarBrushStyle                  : TBrushStyle                 read GetBarBrushStyle                write SetBarBrushStyle                  default bsSolid;

    {$IFDEF iVCL}
    property OPCGroupName                   : String                      read GetOPCGroupName                 write SetOPCGroupName;
    property OPCComputerName                : String                      read GetOPCComputerName              write SetOPCComputerName;
    property OPCServerName                  : String                      read GetOPCServerName                write SetOPCServerName;
    property OPCItemName                    : String                      read GetOPCItemName                  write SetOPCItemName;
    property OPCItem2Name                   : String                      read GetOPCItem2Name                 write SetOPCItem2Name;
    property OPCUpdateRate                  : Integer                     read GetOPCUpdateRate                write SetOPCUpdateRate                  default 500;
    property OPCScalar                      : Double                      read GetOPCScalar                    write SetOPCScalar;
    property OPCOffset                      : Double                      read GetOPCOffset                    write SetOPCOffset;
    property OPCScalar2                     : Double                      read GetOPCScalar2                   write SetOPCScalar2;
    property OPCOffset2                     : Double                      read GetOPCOffset2                   write SetOPCOffset2;
    property OPCAutoConnect                 : Boolean                     read GetOPCAutoConnect               write SetOPCAutoConnect                 default True;
    property OPCXValueSource                : TiOPCXValueSourceStyle      read FOPCXValueSource                write FOPCXValueSource                  default iopcxvsOPCServerTimeStamp;
   {$endif}
  end;

implementation

uses
{$ifdef iVCL} iPlotComponent,  iPlotDataCursor,  iPlotDataCustomList,  iPlotDataView;{$endif}
{$ifdef iCLX}QiPlotComponent, QiPlotDataCursor, QiPlotDataCustomList, QiPlotDataView;{$endif}

type
  TiPlotDataCursorAccess = class(TiPlotDataCursor)end;
  TiPlotAxisAccess       = class(TiPlotAxis      )end;
  TiPlotComponentAccess  = class(TiPlotComponent )end;
//****************************************************************************************************************************************************
constructor TiPlotChannel.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;
  FFillUseChannelColor     := True;
  FElapsedStartTime        := Now;

  FDigitalReferenceHigh    := 90;
  FDigitalReferenceLow     := 10;

  FBarPenUseChannelColor   := True;
  FBarBrushUseChannelColor := True;

  FHighLowOpenShow         := True;
  FHighLowCloseShow        := True;

  FHighLowBarColor         := clAqua;
  FHighLowOpenColor        := clLime;
  FHighLowCloseColor       := clRed;

  FHighLowBarWidth         := 0.5;
  FHighLowOpenWidth        := 1;
  FHighLowCloseWidth       := 1;
  FHighLowOpenHeight       := 1.0;
  FHighLowCloseHeight      := 1.0;

  FHighLowShadowColor      := clGray;
  FHighLowBullishColor     := clWhite;
  FHighLowBearishColor     := clGray;

  SetBarWidth     (5);
  SetBarPenColor  (clRed);
  SetBarBrushColor(clRed);

  FFastDrawEnabled         := True;
  FAllowOutOfOrderXValues  := True;

  FXIncreasing             := True;

  FPixelList               := TStringList.Create;

  {$IFDEF iVCL}
  FOPCManager                    := TiOPCManager.Create(nil);
  FOPCManager.OnAfterGroupUpdate := AfterGroupUpdate;

  FOPCItemManager                := TiOPCItemManager.Create;
  FOPCItemManager.OnGetDesigning := TiPlotComponentAccess(Owner).DoIsDesigning;
  FOPCItemManager.OnNewData      := OPCNewData;

  FOPCItemManager.Add; FOPCItemManager.Items[0].PropertyName := 'Data';
  FOPCItemManager.Add; FOPCItemManager.Items[1].PropertyName := 'Data';
  {$endif}
end;
//****************************************************************************************************************************************************
destructor TiPlotChannel.Destroy;
begin
  {$IFDEF iVCL}
  FOPCItemManager.Free;
  FOPCManager.Free;
  {$endif}
  while FPixelList.Count <> 0 do
    begin
      FPixelList.Objects[0].Free;
      FPixelList.Delete(0);
    end;
  FPixelList.Free;
  inherited Destroy;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.Loaded;
begin
  inherited;
{$IFDEF iVCL}
  if FOPCItemManager.Items[0].AutoConnect then OPCActivate;
{$endif}
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiPlotChannel.SetOPCGroupName   (const Value:String );begin FOPCItemManager.Items[0].GroupName    := Value; end;
procedure TiPlotChannel.SetOPCComputerName(const Value:String );begin FOPCItemManager.Items[0].ComputerName := Value; end;
procedure TiPlotChannel.SetOPCServerName  (const Value:String );begin FOPCItemManager.Items[0].ServerName   := Value; end;
procedure TiPlotChannel.SetOPCItemName    (const Value:String );begin FOPCItemManager.Items[0].ItemName     := Value; end;
procedure TiPlotChannel.SetOPCItem2Name   (const Value:String );begin FOPCItemManager.Items[1].ItemName     := Value; end;
procedure TiPlotChannel.SetOPCUpdateRate  (const Value:Integer);begin FOPCItemManager.Items[0].UpdateRate   := Value; end;
procedure TiPlotChannel.SetOPCScalar      (const Value:Double );begin FOPCItemManager.Items[0].Scalar       := Value; end;
procedure TiPlotChannel.SetOPCOffset      (const Value:Double );begin FOPCItemManager.Items[0].Offset       := Value; end;
procedure TiPlotChannel.SetOPCScalar2     (const Value:Double );begin FOPCItemManager.Items[1].Scalar       := Value; end;
procedure TiPlotChannel.SetOPCOffset2     (const Value:Double );begin FOPCItemManager.Items[1].Offset       := Value; end;
procedure TiPlotChannel.SetOPCAutoConnect (const Value:Boolean);begin FOPCItemManager.Items[0].AutoConnect  := Value; end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetOPCGroupName    : String;  begin Result := FOPCItemManager.Items[0].GroupName;    end;
function TiPlotChannel.GetOPCComputerName : String;  begin Result := FOPCItemManager.Items[0].ComputerName; end;
function TiPlotChannel.GetOPCItemName     : String;  begin Result := FOPCItemManager.Items[0].ItemName;     end;
function TiPlotChannel.GetOPCItem2Name    : String;  begin Result := FOPCItemManager.Items[1].ItemName;     end;
function TiPlotChannel.GetOPCServerName   : String;  begin Result := FOPCItemManager.Items[0].ServerName;   end;
function TiPlotChannel.GetOPCUpdateRate   : Integer; begin Result := FOPCItemManager.Items[0].UpdateRate;   end;
function TiPlotChannel.GetOPCScalar       : Double;  begin Result := FOPCItemManager.Items[0].Scalar;       end;
function TiPlotChannel.GetOPCOffset       : Double;  begin Result := FOPCItemManager.Items[0].Offset;       end;
function TiPlotChannel.GetOPCScalar2      : Double;  begin Result := FOPCItemManager.Items[1].Scalar;       end;
function TiPlotChannel.GetOPCOffset2      : Double;  begin Result := FOPCItemManager.Items[1].Offset;       end;
function TiPlotChannel.GetOPCAutoConnect  : Boolean; begin Result := FOPCItemManager.Items[0].AutoConnect;  end;
function TiPlotChannel.GetOPCActive       : Boolean; begin Result := FOPCItemManager.Items[0].Active;       end;
function TiPlotChannel.GetOPCQualityGood  : Boolean; begin Result := FOPCItemManager.Items[0].QualityGood;  end;
{$endif}
//****************************************************************************************************************************************************
{$IFDEF iVCL}
//****************************************************************************************************************************************************
procedure TiPlotChannel.AfterGroupUpdate(Sender: TObject; GroupName: String);
begin
  AddXY(FOPCItemManager.Items[0].Data, FOPCItemManager.Items[1].Data);
end;
//****************************************************************************************************************************************************
//procedure TiPlotChannel.OPCActivate;       begin FOPCItemManager.Items[0].Activate;       end;


procedure TiPlotChannel.OPCActivate;
begin
  if TiPlotComponentAccess(Owner).IsDesigning then Exit;

  FOPCItemManager.Items[0].Deactivate;
  FOPCItemManager.Items[1].Deactivate;

  if OPCXValueSource <> iopcxvsOPCItem then
    begin
      FOPCItemManager.Items[0].Activate;
    end
  else
    begin
      FOPCManager.GroupClear;

      if FOPCManager.GetGroupIndex(FOPCItemManager.Items[0].GroupName) = -1 then
        begin
          if Trim(FOPCItemManager.Items[0].ServerName) <> '' then
            begin
              FOPCManager.GroupAdd(Format('%p', [@FOPCManager]),
                                   FOPCItemManager.Items[0].ComputerName,
                                   FOPCItemManager.Items[0].ServerName,
                                   FOPCItemManager.Items[0].UpdateRate);

             FOPCItemManager.Items[0].GroupName := FOPCManager.Group[0].Name;
            end;
        end;

      FOPCItemManager.Items[1].GroupName := FOPCItemManager.Items[0].GroupName;

      FOPCItemManager.Items[0].Activate;
      FOPCItemManager.Items[1].Activate;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.OPCActivateSuspend;begin FOPCItemManager.Items[0].ActivateSuspend;end;
procedure TiPlotChannel.OPCDeactivate;     begin FOPCItemManager.Items[0].Deactivate;     end;
procedure TiPlotChannel.OPCUpdateSuspend;  begin FOPCItemManager.Items[0].UpdateSuspend;  end;
procedure TiPlotChannel.OPCUpdateResume;   begin FOPCItemManager.Items[0].UpdateResume;   end;
{$endif}
//****************************************************************************************************************************************************
procedure TiPlotChannel.SetFillEnabled                   (const Value:Boolean);begin SetBooleanProperty(Value,FFillEnabled,                   TriggerChange);end;
procedure TiPlotChannel.SetFillReference                 (const Value:Double );begin SetDoubleProperty (Value,FFillReference,                 TriggerChange);end;
procedure TiPlotChannel.SetFillColor                     (const Value:TColor );begin SetColorProperty  (Value,FFillColor,                     TriggerChange);end;
procedure TiPlotChannel.SetFillUseChannelColor           (const Value:Boolean);begin SetBooleanProperty(Value,FFillUseChannelColor,           TriggerChange);end;
procedure TiPlotChannel.SetDigitalEnabled                (const Value:Boolean);begin SetBooleanProperty(Value,FDigitalEnabled,                TriggerChange);end;
procedure TiPlotChannel.SetDigitalReferenceHigh          (const Value:Double );begin SetDoubleProperty (Value,FDigitalReferenceHigh,          TriggerChange);end;
procedure TiPlotChannel.SetDigitalReferenceLow           (const Value:Double );begin SetDoubleProperty (Value,FDigitalReferenceLow,           TriggerChange);end;
procedure TiPlotChannel.SetFastDrawEnabled               (const Value:Boolean);begin SetBooleanProperty(Value,FFastDrawEnabled,               TriggerChange);end;
procedure TiPlotChannel.SetAllowOutOfOrderXValues        (const Value:Boolean);begin SetBooleanProperty(Value,FAllowOutOfOrderXValues,        nil          );end;
procedure TiPlotChannel.SetDrawOutOfOrderXValues         (const Value:Boolean);begin SetBooleanProperty(Value,FDrawOutOfOrderXValues,         TriggerChange);end;
procedure TiPlotChannel.SetResetStartTimeOnFirstDataPoint(const Value:Boolean);begin SetBooleanProperty(Value,FResetStartTimeOnFirstDataPoint,nil          );end;
procedure TiPlotChannel.SetBarEnabled                    (const Value:Boolean);begin SetBooleanProperty(Value,FBarEnabled,                    TriggerChange);end;
procedure TiPlotChannel.SetBarPenUseChannelColor         (const Value:Boolean);begin SetBooleanProperty(Value,FBarPenUseChannelColor,         TriggerChange);end;
procedure TiPlotChannel.SetBarBrushUseChannelColor       (const Value:Boolean);begin SetBooleanProperty(Value,FBarBrushUseChannelColor,       TriggerChange);end;
procedure TiPlotChannel.SetHighLowEnabled                (const Value:Boolean);begin SetBooleanProperty(Value,FHighLowEnabled,                TriggerChange);end;
procedure TiPlotChannel.SetHighLowBarColor               (const Value:TColor );begin SetColorProperty  (Value,FHighLowBarColor,               TriggerChange);end;
procedure TiPlotChannel.SetHighLowBarWidth               (const Value:Double );begin SetDoubleProperty (Value,FHighLowBarWidth,               TriggerChange);end;
procedure TiPlotChannel.SetHighLowOpenShow               (const Value:Boolean);begin SetBooleanProperty(Value,FHighLowOpenShow,               TriggerChange);end;
procedure TiPlotChannel.SetHighLowOpenColor              (const Value:TColor );begin SetColorProperty  (Value,FHighLowOpenColor,              TriggerChange);end;
procedure TiPlotChannel.SetHighLowOpenWidth              (const Value:Double );begin SetDoubleProperty (Value,FHighLowOpenWidth,              TriggerChange);end;
procedure TiPlotChannel.SetHighLowOpenHeight             (const Value:Double );begin SetDoubleProperty (Value,FHighLowOpenHeight,             TriggerChange);end;
procedure TiPlotChannel.SetHighLowCloseShow              (const Value:Boolean);begin SetBooleanProperty(Value,FHighLowCloseShow,              TriggerChange);end;
procedure TiPlotChannel.SetHighLowCloseColor             (const Value:TColor );begin SetColorProperty  (Value,FHighLowCloseColor,             TriggerChange);end;
procedure TiPlotChannel.SetHighLowCloseWidth             (const Value:Double );begin SetDoubleProperty (Value,FHighLowCloseWidth,             TriggerChange);end;
procedure TiPlotChannel.SetHighLowCloseHeight            (const Value:Double );begin SetDoubleProperty (Value,FHighLowCloseHeight,            TriggerChange);end;
procedure TiPlotChannel.SetHighLowShadowColor            (const Value:TColor );begin SetColorProperty  (Value,FHighLowShadowColor,            TriggerChange);end;
procedure TiPlotChannel.SetHighLowBullishColor           (const Value:TColor );begin SetColorProperty  (Value,FHighLowBullishColor,           TriggerChange);end;
procedure TiPlotChannel.SetHighLowBearishColor           (const Value:TColor );begin SetColorProperty  (Value,FHighLowBearishColor,           TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.SetHighLowStyle(const Value: TiPlotHighLowStyle);
begin
  if FHighLowStyle <> Value then
    begin
      FHighLowStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.SetInterpolationStyle(const Value: TiPlotInterpolationStyle);
begin
  if FInterpolationStyle <> Value then
    begin
      FInterpolationStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.SetDigitalReferenceStyle(const Value: TiPlotDigitalReferenceStyle);
begin
  if FDigitalReferenceStyle <> Value then
    begin
      FDigitalReferenceStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.SetFillStyle(const Value: TBrushStyle);
begin
  if FFillStyle <> Value then
    begin
      FFillStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.CheckForValidXValue(const X: Double);
var
  XIncreasing : Boolean;
begin
  if (not FAllowOutOfOrderXValues) and (DataList.Count > 1) then
    begin
      if DataList.X[0] <= DataList.X[1] then XIncreasing := True else XIncreasing := False;

      if XIncreasing then
        begin
          if X < DataList.X[Count-1] then raise Exception.Create('New Data-Point X-Value is out of order');
        end
      else
        begin
          if X > DataList.X[Count-1] then raise Exception.Create('New Data-Point X-Value is out of order.');
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.AddXY(const X, Y: Double) : Integer;
begin
  if (ResetStartTimeOnFirstDataPoint and (Count = 0)) then ResetElapsedStartTime;

  CheckForValidXValue(X);

  Result := AddXYInternal(X, Y, False, False)
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.AddYArray(XInterval: Double; YData: Variant);
var
  x          : Integer;
  LowBoundY  : Integer;
  HighBoundY : Integer;
  XStart     : Double;
begin
  if VarArrayDimCount(YData) <> 1 then raise Exception.Create('Y-Data array must be 1 dimensional');

  if (ResetStartTimeOnFirstDataPoint and (Count = 0)) then ResetElapsedStartTime;

  LowBoundY  := VarArrayLowBound (YData, 1);
  HighBoundY := VarArrayHighBound(YData, 1);

  if Count = 0 then XStart := 0 else XStart := DataX[Count-1];

  for x := LowBoundY to HighBoundY do
    AddXYInternal(XStart + (x-LowBoundY)*XInterval, YData[x], False, False);
end;
//****************************************************************************************************************************************************
function TiPlotChannel.AddXNull(X: Double): Integer;
begin
  if (ResetStartTimeOnFirstDataPoint and (Count = 0)) then ResetElapsedStartTime;

  CheckForValidXValue(X);

  Result := AddXYInternal(X, 0, True, False);
end;
//****************************************************************************************************************************************************
function TiPlotChannel.AddXEmpty(X: Double): Integer;
begin
  if (ResetStartTimeOnFirstDataPoint and (Count = 0)) then ResetElapsedStartTime;

  CheckForValidXValue(X);

  Result := AddXYInternal(X, 0, False, True);
end;
//****************************************************************************************************************************************************
function TiPlotChannel.AddHighLow(X, High, Low, Open, Close: Double): Integer;
begin
  if (ResetStartTimeOnFirstDataPoint and (Count = 0)) then ResetElapsedStartTime;

  CheckForValidXValue(X);

  Result := DataList.Add(X, 0, False, False);
  DataList.High [Result] := High;
  DataList.Low  [Result] := Low;
  DataList.Open [Result] := Open;
  DataList.Close[Result] := Close;

  if XAxisTrackingEnabled and Assigned(XAxis) then
    begin
      XAxis.NewTrackingData(X);
    end;

  if YAxisTrackingEnabled and Assigned(YAxis) then
    begin
      YAxis.NewTrackingData(High);
      YAxis.NewTrackingData(Low);
      YAxis.NewTrackingData(Open);
      YAxis.NewTrackingData(Close);
    end;

  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotChannel.AddYElapsedTime(Y: Double): Integer;
begin
  if (ResetStartTimeOnFirstDataPoint and (Count = 0)) then ResetElapsedStartTime;

  Result := AddXYInternal(Now - FElapsedStartTime, Y, False, False);
end;
//****************************************************************************************************************************************************
function TiPlotChannel.AddYElapsedSeconds(Y: Double): Integer;
begin
  if (ResetStartTimeOnFirstDataPoint and (Count = 0)) then ResetElapsedStartTime;

  Result := AddXYInternal((Now - FElapsedStartTime)*60*60*24, Y, False, False);
end;
//****************************************************************************************************************************************************
function TiPlotChannel.AddYNow(Y: Double): Integer;
begin
  if (ResetStartTimeOnFirstDataPoint and (Count = 0)) then ResetElapsedStartTime;

  Result := AddXYInternal(Now, Y, False, False);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.ResetElapsedStartTime;
begin
 FElapsedStartTime := Now;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawSetup(const Canvas: TCanvas);
var
  x               : Integer;
  iPlotPixelPoint : TiPlotPixelPoint;
begin
  CanDraw := False;

  if not Assigned(XAxis) then exit;
  if not Assigned(YAxis) then exit;
  if not Visible         then exit;
  if DataList.Count = 0  then exit;

  if DataList.Count > 2 then
    begin
      if DataList.X[0] <= DataList.X[1] then FXIncreasing := True else FXIncreasing := False;
    end
  else FXIncreasing := True;

  if (not DrawOutOfOrderXValues) then
    begin
      if FXIncreasing then
        begin
          if XAxis.Min > XLast   then exit;
          if XAxis.Max < XFirst  then exit;
        end
      else
        begin
          if XAxis.Min > XFirst  then exit;
          if XAxis.Max < XLast   then exit;
        end;
    end;

  CalcStartXIndex;
  CalcStopXIndex;

  if not (FInterpolationStyle in [ipistDifferential, ipistDifferentialTerminated]) then
    begin
      if StartIndex = - 1 then exit;
      if StopIndex  = - 1 then exit;
    end;

  case FDigitalReferenceStyle of
    ipdrScale : begin
                  FPixelsHigh := YAxis.PositionToPixels(FDigitalReferenceHigh);
                  FPixelsLow  := YAxis.PositionToPixels(FDigitalReferenceLow);
                end
    else        begin
                  FPixelsHigh := YAxis.PositionToPixels(YAxis.Span*FDigitalReferenceHigh/100 + YAxis.Min);
                  FPixelsLow  := YAxis.PositionToPixels(YAxis.Span*FDigitalReferenceLow /100 + YAxis.Min);
                end;
  end;

  if XAxis.MinPixels < XAxis.MaxPixels then
    begin
      FPixelListStart := XAxis.MinPixels;
      FPixelListStop  := XAxis.MaxPixels;
    end
  else
    begin
      FPixelListStart := XAxis.MaxPixels;
      FPixelListStop  := XAxis.MinPixels;
    end;

  while FPixelList.Count < (FPixelListStop - FPixelListStart +1) do
    begin
      iPlotPixelPoint := TiPlotPixelPoint.Create;
      FPixelList.AddObject('', iPlotPixelPoint);
    end;

  for x := 0 to FPixelList.Count - 1 do
    (FPixelList.Objects[x] as TiPlotPixelPoint).Null := True;

  CanDraw := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
{$IFDEF iVCL}
var
  ARect : TRect;                             
{$ENDIF}
begin
  try
    {$IFDEF iVCL}
    if ClipToAxes then
      begin
        if XYAxesReversed then ARect := iRect(YAxis.MinPixels, XAxis.MinPixels, YAxis.MaxPixels, XAxis.MaxPixels)
        else                   ARect := iRect(XAxis.MinPixels, YAxis.MinPixels, XAxis.MaxPixels, YAxis.MaxPixels);

        IntersectClipRect(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      end;
    {$ENDIF}

    DrawFill         (Canvas, XYAxesReversed, BackGroundColor);
    DrawBar          (Canvas, XYAxesReversed, BackGroundColor);
    DrawConnectPoints(Canvas, XYAxesReversed, BackGroundColor);
    DrawMarkers      (Canvas, XYAxesReversed, BackGroundColor);

    case FHighLowStyle of
      iphlsOpenClose   : DrawHighLow           (Canvas, XYAxesReversed, BackGroundColor);
      iphlsCandleStick : DrawHighLowCandleStick(Canvas, XYAxesReversed, BackGroundColor);
    end;

  except
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawConnectPoints(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
begin
  if not TraceVisible then Exit;

  with Canvas do
    begin
      Pen.Color   := Color;
      Brush.Style := bsClear;
      Pen.Style   := TPenStyle(TraceLineStyle);
      if TraceLineWidth = 1 then Pen.Width := 0 else Pen.Width := TraceLineWidth;

      Windows.SetBkColor(Canvas.Handle, BackGroundColor);
    end;

  if FDigitalEnabled then
    DrawDigital(Canvas, XYAxisReverse, BackGroundColor)
  else
    case FInterpolationStyle of
      ipistStraightLine           : if FFastDrawEnabled then DrawFast(Canvas, XYAxisReverse, BackGroundColor)
                                    else inherited DrawConnectPoints(Canvas, XYAxisReverse, BackGroundColor);
      ipistCubicSpline            : DrawCubicSpline (Canvas, XYAxisReverse, BackGroundColor);
      ipistPolynomial             : DrawPolynomial  (Canvas, XYAxisReverse, BackGroundColor);
      ipistRational               : DrawRational    (Canvas, XYAxisReverse, BackGroundColor);
      ipistDifferential           : DrawDifferential(Canvas, XYAxisReverse, BackGroundColor);
      ipistDifferentialTerminated : DrawDifferential(Canvas, XYAxisReverse, BackGroundColor);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawFill(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i            : Integer;
  Point1Empty  : Boolean;
  Point1XValue : Double;
  Point1YValue : Double;
begin
  if not FFillEnabled                         then Exit;
  if FFillStyle = bsClear                     then Exit;
  if FInterpolationStyle <> ipistStraightLine then Exit;
  if FDigitalEnabled                          then Exit;

  Point1Empty  := True;
  Point1XValue := 0;
  Point1YValue := 0;

  with Canvas do
    begin
      Brush.Style := FFillStyle;
      if FillUseChannelColor then Brush.Color := Color else Brush.Color := FillColor;
      Pen.Color := Brush.Color;
      Pen.Width := 0;
      Pen.Style := psClear;

      Windows.SetBkColor(Canvas.Handle, BackGroundColor);

      for i := StartIndex to StopIndex do
        begin
          if DataEmpty[i] then Continue;
          if DataNull[i]  then
            begin
              Point1Empty := True;
              Continue;
            end;

          if Point1Empty then
            begin
              Point1Empty  := False;
              Point1XValue := DataX[i];
              Point1YValue := DataY[i];
            end
          else
            begin
              DrawQuadPolygon(Canvas, XYAxisReverse, PointDouble(Point1XValue, FFillReference),
                                                     PointDouble(Point1XValue, Point1YValue),
                                                     PointDouble(DataX[i],     DataY[i]),
                                                     PointDouble(DataX[i],     FFillReference));

              Point1XValue := DataX[i];
              Point1YValue := DataY[i];
            end;
        end;

    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetBarRect(DataIndex: Integer): TRect;
var
  X1 : Double;
  X2 : Double;
  Y1 : Double;
  Y2 : Double;
begin
  X1 := DataX[DataIndex] - DataBarWidth[DataIndex]/2;
  X2 := DataX[DataIndex] + DataBarWidth[DataIndex]/2;

  Y1 := DataBarReference[DataIndex];
  Y2 := DataY[DataIndex];

  Result := GetPixelRect(X1, Y1, X2, Y2);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawBar(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i     : Integer;
  ARect : TRect;
begin
  if not FBarEnabled then Exit;
  with Canvas do
    begin
      for i := StartIndex to StopIndex do
        begin
          if     DataNull [i]      then Continue;
          if     DataEmpty[i]      then Continue;
          if not DataBarVisible[i] then Continue;

          if FBarBrushUseChannelColor then Brush.Color := Color else Brush.Color := DataBarBrushColor[i];
          if FBarPenUseChannelColor   then Pen.Color   := Color else Pen.Color   := DataBarPenColor[i];
                                                                     Pen.Width   := DataBarPenWidth[i];
                                                                     Pen.Style   := DataBarPenStyle[i];
                                                                     Brush.Style := DataBarBrushStyle[i];

          Windows.SetBkColor(Canvas.Handle, BackGroundColor);

          ARect := GetBarRect(i);

          if ARect.Left = ARect.Right then ARect.Right := ARect.Right +1;
          Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawHighLow(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i           : Integer;
  YStart      : Integer;
  YStop       : Integer;
  XStart      : Integer;
  XStop       : Integer;
  ARect       : TRect;
  WidthPixel  : Integer;
  HeightPixel : Integer;
  BarCenterX  : Integer;
  CenterY     : Integer;
  BarRect     : TRect;
begin
  if not FHighLowEnabled then Exit;

  with Canvas do
    begin
      Pen.Width   := 0;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;

      Windows.SetBkColor(Canvas.Handle, BackGroundColor);

      for i := StartIndex to StopIndex do
        begin
          if     DataNull [i]      then Continue;
          if     DataEmpty[i]      then Continue;

          WidthPixel := XAxis.WidthToPixels(FHighLowBarWidth);

          XStart := XAxis.PositionToPixels(DataX[i]) + WidthPixel - WidthPixel div 2;
          XStop  := XAxis.PositionToPixels(DataX[i]) -              WidthPixel div 2;

          YStart := YAxis.PositionToPixels(DataLow [i]);
          YStop  := YAxis.PositionToPixels(DataHigh[i]);

          if XStart = XStop then XStop := XStart + 1;
          if YStart = YStop then YStop := YStart + 1;

          BarCenterX := (XStart + XStop) div 2;

          if XYAxisReverse then BarRect := iRect(YStart, XStart, YStop, XStop)
            else                BarRect := iRect(XStart, YStart, XStop, YStop);

          if FHighLowOpenShow then
            begin

              WidthPixel  := XAxis.WidthToPixels(FHighLowOpenWidth);
              XStart      := BarCenterX - WidthPixel + 1;
              XStop       := BarCenterX;

              HeightPixel := YAxis.WidthToPixels(FHighLowOpenHeight);
              CenterY     := YAxis.PositionToPixels(DataOpen[i]);

              YStart      := CenterY + HeightPixel - HeightPixel div 2 - 1;
              YStop       := CenterY -               HeightPixel div 2;

              Brush.Color := FHighLowOpenColor;
              Pen.Color   := FHighLowOpenColor;

              if XStart = XStop then XStop := XStart + 1;
              if YStart = YStop then YStop := YStart + 1;

              if XYAxisReverse then ARect := iRect(YStart, XStart, YStop, XStop)
                else                ARect := iRect(XStart, YStart, XStop, YStop);

              Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
            end;

          if FHighLowCloseShow then
            begin
              WidthPixel  := XAxis.WidthToPixels(FHighLowCloseWidth);
              XStart      := BarCenterX;
              XStop       := BarCenterX + WidthPixel - 1;

              HeightPixel := YAxis.WidthToPixels(FHighLowCloseHeight);
              CenterY     := YAxis.PositionToPixels(DataClose[i]);

              YStart      := CenterY + HeightPixel - HeightPixel div 2 - 1;
              YStop       := CenterY -               HeightPixel div 2;

              Brush.Color := FHighLowCloseColor;
              Pen.Color   := FHighLowCloseColor;

              if XStart = XStop then XStop := XStart + 1;
              if YStart = YStop then YStop := YStart + 1;

              if XYAxisReverse then ARect := iRect(YStart, XStart, YStop, XStop)
                else                ARect := iRect(XStart, YStart, XStop, YStop);

              Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
            end;

          Brush.Color := FHighLowBarColor;
          Pen.Color   := FHighLowBarColor;
          Rectangle(BarRect.Left, BarRect.Top, BarRect.Right, BarRect.Bottom);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawHighLowCandleStick(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i          : Integer;
  YStart     : Integer;
  YStop      : Integer;
  XStart     : Integer;
  XStop      : Integer;
  WidthPixel : Integer;
  BarRect    : TRect;
begin
  if not FHighLowEnabled then Exit;

  with Canvas do
    begin
      Pen.Width   := 0;
      Pen.Style   := psSolid;
      Brush.Style := bsSolid;

      Windows.SetBkColor(Canvas.Handle, BackGroundColor);

      for i := StartIndex to StopIndex do
        begin
          if     DataNull [i]      then Continue;
          if     DataEmpty[i]      then Continue;

          Pen.Color := FHighLowShadowColor;

          XStart := XAxis.PositionToPixels(DataX[i]);
          XStop  := XAxis.PositionToPixels(DataX[i]);

          YStart := YAxis.PositionToPixels(DataHigh[i]);
          YStop  := YAxis.PositionToPixels(DataLow [i]);

          Polyline([Point(XStart, YStart), Point(XStop, YStop)]);

          WidthPixel := XAxis.WidthToPixels(FHighLowBarWidth);

          XStart := XAxis.PositionToPixels(DataX[i]) + WidthPixel div 2 + 1;
          XStop  := XAxis.PositionToPixels(DataX[i]) - WidthPixel div 2;

          YStart := YAxis.PositionToPixels(DataOpen [i]);
          YStop  := YAxis.PositionToPixels(DataClose[i]);

          if DataClose[i] < DataOpen[i] then Brush.Color := FHighLowBearishColor
          else                               Brush.Color := FHighLowBullishColor;

          if XStart = XStop then XStop := XStart + 1;
          if YStart = YStop then YStop := YStart + 1;

          if XYAxisReverse then BarRect := iRect(YStart, XStart, YStop, XStop)
            else                BarRect := iRect(XStart, YStart, XStop, YStop);

          Rectangle(BarRect.Left, BarRect.Top, BarRect.Right, BarRect.Bottom);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawDifferential(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i            : Integer;
  Point1Empty  : Boolean;
  Point1XValue : Double;
  Point1YValue : Double;
begin
  if Count = 0 then Exit;

  Point1Empty  := True;
  Point1XValue := 0;
  Point1YValue := 0;

  Canvas.Brush.Style := FFillStyle;
  if FillUseChannelColor then Canvas.Brush.Color := Color else Canvas.Brush.Color := FillColor;

  if (StartIndex <> -1) and (StopIndex <> -1) then
    begin
      for i := StartIndex to StopIndex do
        begin
          if DataEmpty[i] then Continue;
          if DataNull[i]  then
            begin
              if not Point1Empty then
                begin
                  if FFillEnabled and (FFillStyle <> bsClear) then
                    begin
                      Canvas.Pen.Color := Canvas.Brush.Color;
                      DrawQuadPolygon(Canvas, XYAxisReverse, PointDouble(Point1XValue, FFillReference),
                                                             PointDouble(Point1XValue, Point1YValue),
                                                             PointDouble(DataX[i],     Point1YValue),
                                                             PointDouble(DataX[i],     FFillReference));
                      Canvas.Pen.Color := Color;
                    end;
                  DrawLine(Canvas, XYAxisReverse, Point1XValue, Point1YValue, DataX[i], Point1YValue, ipurScale);
                end;
              Point1Empty := True;
              Continue;
            end;

          if Point1Empty then
            begin
              Point1Empty  := False;
              Point1XValue := DataX[i];
              Point1YValue := DataY[i];
            end
          else
            begin
              if FFillEnabled  and (FFillStyle <> bsClear) then
                begin
                  Canvas.Pen.Color := Canvas.Brush.Color;
                  DrawQuadPolygon(Canvas, XYAxisReverse, PointDouble(Point1XValue, FFillReference),
                                                         PointDouble(Point1XValue, Point1YValue),
                                                         PointDouble(DataX[i],     Point1YValue),
                                                         PointDouble(DataX[i],     FFillReference));
                  Canvas.Pen.Color := Color;
                end;

              DrawLine(Canvas, XYAxisReverse, Point1XValue, Point1YValue, DataX[i], Point1YValue, ipurScale);
              DrawLine(Canvas, XYAxisReverse, DataX[i],     Point1YValue, DataX[i], DataY[i], ipurScale);

              Point1XValue := DataX[i];
              Point1YValue := DataY[i];
            end;
        end;
      end
  else
    begin
      for i := Count-1 downto 0 do
        begin
          if DataEmpty[i] then Continue;
          if DataNull[i]  then Continue;
          Point1Empty  := False;
          Point1XValue := DataX[i];
          Point1YValue := DataY[i];
          Break;
        end;
    end;

  if (FInterpolationStyle = ipistDifferential) and not Point1Empty then
    begin
      Canvas.Pen.Color := Color;
      DrawLine(Canvas, XYAxisReverse, Point1XValue, Point1YValue, XAxis.Max, Point1YValue, ipurScale);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawMarkers(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i       : Integer;
  DataX   : Double;
  DataY   : Double;
  PixelsX : Integer;
  PixelsY : Integer;
begin
  if StartIndex = - 1   then Exit;
  if StopIndex  = - 1   then Exit;
  if not MarkersVisible then Exit;

  if FDigitalEnabled then
    begin
      for i := StartIndex to StopIndex do
        begin
          if     DataNull[i]       then Continue;
          if     DataEmpty[i]      then Continue;
          if not DataMarkerShow[i] then Continue;

          DataX  := GetDataX(i);
          DataY  := GetDataY(i);

          if XAxis.ValueOnScale(DataX) and YAxis.ValueOnScale(DataY) then
            begin
              PixelsX := XAxis.PositionToPixels(DataX);
              if DataY = 0 then PixelsY := FPixelsLow else PixelsY := FPixelsHigh;

              if XYAxisReverse then DrawMarker(Canvas, i, Point(PixelsY, PixelsX), BackGroundColor)
                else                DrawMarker(Canvas, i, Point(PixelsX, PixelsY), BackGroundColor);
            end;
        end;
    end
  else inherited DrawMarkers(Canvas, XYAxisReverse, BackGroundColor);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawPointSet(const Canvas: TCanvas; const XYAxisReverse: Boolean; const Point1, Point2, Point3: TiPlotMinMaxPoint);
begin
  if not Point1.Empty then
    if Point1.YMin <> Point1.YMax then DrawLine(Canvas, XYAxisReverse, Point1.XValue, Point1.YMin, Point1.XValue, Point1.YMax, ipurScale);

  if not Point2.Empty then
    if Point2.YMin <> Point2.YMax then DrawLine(Canvas, XYAxisReverse, Point2.XValue, Point2.YMin, Point2.XValue, Point2.YMax, ipurScale);

  if (not Point1.Empty) and (not Point2.Empty) then
    DrawLine(Canvas, XYAxisReverse, Point1.XValue, Point1.YLast, Point2.XValue, Point2.YFirst, ipurScale);

  if (not Point2.Empty) and (not Point3.Empty) then
    DrawLine(Canvas, XYAxisReverse, Point2.XValue, Point2.YLast, Point3.XValue, Point3.YFirst, ipurScale);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawFast(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i       : Integer;
  Point1  : TiPlotMinMaxPoint;
  Point2  : TiPlotMinMaxPoint;
  Point3  : TiPlotMinMaxPoint;

  XValue  : Double;
  YValue  : Double;

  Empty   : Boolean;
  Null    : Boolean;

  XPixels : Integer;
begin
  if StartIndex = StopIndex then exit;

  Point1 := TiPlotMinMaxPoint.Create; try
  Point2 := TiPlotMinMaxPoint.Create; try
  Point3 := TiPlotMinMaxPoint.Create; try

  for i := StartIndex to StopIndex do
    begin
      GetXYEmptyNull(i, XValue, YValue, Empty, Null);

      if Empty then Continue;

      if Null then
        begin
          DrawPointSet(Canvas, XYAxisReverse, Point1, Point2, Point3);
          Point1.Clear;
          Point2.Clear;
          Point3.Clear;
          Continue;
        end;

      XPixels := XAxis.PositionToPixels(XValue);

      if      Point1.Empty             then Point1.AddData(XValue, YValue, XPixels)
      else if XPixels = Point1.XPixels then Point1.AddData(XValue, YValue, XPixels)
      else if Point2.Empty             then Point2.AddData(XValue, YValue, XPixels)
      else if XPixels = Point2.XPixels then Point2.AddData(XValue, YValue, XPixels)
      else
        begin
          Point3.AddData(XValue, YValue, XPixels);
          DrawPointSet(Canvas, XYAxisReverse, Point1, Point2, Point3);
          Point1.AssignDown(Point3);
          Point2.Clear;
          Point3.Clear;
        end;
    end;
  DrawPointSet(Canvas, XYAxisReverse, Point1, Point2, Point3);

  finally Point3.Free; end;
  finally Point2.Free; end;
  finally Point1.Free; end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawDigitalSequence(Canvas: TCanvas; XYAxisReverse: Boolean; SequenceData: TDigitalSequenceData);
var
  PointDouble1 : TPointDouble;
  PointDouble2 : TPointDouble;
  PointDouble3 : TPointDouble;
  PointDouble4 : TPointDouble;
begin
  Canvas.Brush.Style := FFillStyle;
  if FillUseChannelColor then Canvas.Brush.Color := Color else Canvas.Brush.Color := FillColor;

  if SequenceData.TransitionSet then
    begin
      if FFillEnabled then
        begin
          Canvas.Pen.Color := Canvas.Brush.Color;

          PointDouble1.x := SequenceData.StartXValue;
          PointDouble1.y := FFillReference;
                                                                         
          PointDouble2.x := SequenceData.StartXValue;
          if SequenceData.StartYValue then PointDouble2.y := FDigitalReferenceHigh else PointDouble2.y := FDigitalReferenceLow;

          PointDouble3.x := SequenceData.TransitionXValue;
          if SequenceData.StartYValue then PointDouble3.y := FDigitalReferenceHigh else PointDouble3.y := FDigitalReferenceLow;

          PointDouble4.x := SequenceData.TransitionXValue;
          PointDouble1.y := FFillReference;

          DrawQuadPolygon(Canvas, XYAxisReverse, PointDouble1, PointDouble2, PointDouble3, PointDouble4);

          Canvas.Pen.Color := Color;
        end;

      if SequenceData.StartYValue then
        DrawLine(Canvas, XYAxisReverse, SequenceData.StartXValue, FDigitalReferenceHigh, SequenceData.TransitionXValue, FDigitalReferenceHigh, TiPlotUnitReferenceStyle(ord(FDigitalReferenceStyle)))
      else
        DrawLine(Canvas, XYAxisReverse, SequenceData.StartXValue, FDigitalReferenceLow,  SequenceData.TransitionXValue, FDigitalReferenceLow,  TiPlotUnitReferenceStyle(ord(FDigitalReferenceStyle)));

      if SequenceData.StartYValue then
        DrawLine(Canvas, XYAxisReverse, SequenceData.TransitionXValue, FDigitalReferenceHigh, SequenceData.TransitionXValue, FDigitalReferenceLow, TiPlotUnitReferenceStyle(ord(FDigitalReferenceStyle)))
      else
        DrawLine(Canvas, XYAxisReverse, SequenceData.TransitionXValue, FDigitalReferenceLow,  SequenceData.TransitionXValue, FDigitalReferenceHigh, TiPlotUnitReferenceStyle(ord(FDigitalReferenceStyle)));
    end
  else if SequenceData.StartSet and SequenceData.StopSet then
  begin
    if FFillEnabled then
      begin
        Canvas.Pen.Color := Color;

        PointDouble1.x := SequenceData.StartXValue;
        PointDouble1.y := FFillReference;

        PointDouble2.x := SequenceData.StartXValue;
        if SequenceData.StartYValue then PointDouble2.y := FDigitalReferenceHigh else PointDouble2.y := FDigitalReferenceLow;

        PointDouble3.x := SequenceData.StopXValue;
        if SequenceData.StartYValue then PointDouble3.y := FDigitalReferenceHigh else PointDouble3.y := FDigitalReferenceLow;

        PointDouble4.x := SequenceData.StopXValue;
        PointDouble1.y := FFillReference;

        DrawQuadPolygon(Canvas, XYAxisReverse, PointDouble1, PointDouble2, PointDouble3, PointDouble4);

        Canvas.Pen.Color := Color;
      end;

    if SequenceData.StartYValue then
      DrawLine(Canvas, XYAxisReverse, SequenceData.StartXValue, FDigitalReferenceHigh, SequenceData.StopXValue, FDigitalReferenceHigh, TiPlotUnitReferenceStyle(ord(FDigitalReferenceStyle)))
    else
      DrawLine(Canvas, XYAxisReverse, SequenceData.StartXValue, FDigitalReferenceLow,  SequenceData.StopXValue, FDigitalReferenceLow, TiPlotUnitReferenceStyle(ord(FDigitalReferenceStyle)));
  end;
  SequenceData.Clear;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawDigital(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i            : Integer;
  SequenceData : TDigitalSequenceData;
begin
  SequenceData := TDigitalSequenceData.Create;
  try
    SequenceData.Clear;

    if StartIndex = StopIndex then exit;

    for i := StartIndex to StopIndex do
      begin
        if DataEmpty[i] then Continue;

        if DataNull[i] then
          begin
            DrawDigitalSequence(Canvas, XYAxisReverse, SequenceData);
            Continue;
          end;

        if not SequenceData.StartSet then
          begin
            SequenceData.StartSet    := True;
            SequenceData.StartXValue := DataX[i];
            SequenceData.StartYValue := DataY[i] <> 0;
          end
        else
          begin
            if (DataY[i] <> 0) = SequenceData.StartYValue then
              begin
                SequenceData.StopSet    := True;
                SequenceData.StopXValue := DataX[i];
              end
            else
              begin
                SequenceData.TransitionSet := True;
                SequenceData.TransitionXValue := DataX[i];
                DrawDigitalSequence(Canvas, XYAxisReverse, SequenceData);

                SequenceData.StartSet    := True;
                SequenceData.StartXValue := DataX[i];
                SequenceData.StartYValue := DataY[i] <> 0;
              end;
          end;
      end;
    DrawDigitalSequence(Canvas, XYAxisReverse, SequenceData);
  finally
    SequenceData.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawCubicSplineSet(Canvas: TCanvas; XYAxisReverse: Boolean; XArray, YArray, Y2Array: DoubleDynamicArray; Size: Integer);
var
  i            : Integer;
  XPixelsStart : Integer;
  XPixelsStop  : Integer;
  XStart       : Double;
  XStop        : Double;
  XValue       : Double;
  YValue       : Double;
  X1, X2       : Double;
  Y1, Y2       : Double;
begin
  if Size < 2 then Exit;
  Spline(XArray, YArray, Size, 1E30, 1E30, Y2Array);

  Canvas.Brush.Style := FFillStyle;
  if FillUseChannelColor then Canvas.Brush.Color := Color else Canvas.Brush.Color := FillColor;

  XStart := XArray[1];
  XStop  := XArray[Size];

  if XStart < XAxis.Min then XStart := XAxis.Min;
  if XStop  > XAxis.Max then XStop  := XAxis.Max;

  XPixelsStart := XAxis.PositionToPixels(XStart);
  XPixelsStop  := XAxis.PositionToPixels(XStop);

  if XPixelsStart > XPixelsStop then SwapIntegers(XPixelsStart, XPixelsStop);

  XValue := XAxis.PixelsToPosition(XPixelsStart);
  SplineInterpolation(XArray, YArray, Y2Array, Size, XValue, YValue);
  X1 := XValue;
  Y1 := YValue;

  if FFillEnabled and (FFillStyle <> bsClear) then
    begin
      Canvas.Pen.Color := Canvas.Brush.Color;
      DrawLine(Canvas, XYAxisReverse, X1, FFillReference, X1, Y1, ipurScale);
      Canvas.Pen.Color := Color;
      AddPixelListValue(XAxis.PositionToPixels(X1), Y1);
    end;

  for i := XPixelsStart{+1} to XPixelsStop do
    begin
      XValue := XAxis.PixelsToPosition(i);
      SplineInterpolation(XArray, YArray, Y2Array, Size, XValue, YValue);

      X2 := XValue;
      Y2 := YValue;

      if FFillEnabled and (FFillStyle <> bsClear) then
        begin
          Canvas.Pen.Color := Canvas.Brush.Color;
          DrawLine(Canvas, XYAxisReverse, X2, FFillReference, X2, Y2, ipurScale);
          Canvas.Pen.Color := Color;
        end;

      DrawLine(Canvas, XYAxisReverse, X1, Y1, X2, Y2, ipurScale);
      AddPixelListValue(XAxis.PositionToPixels(X2), Y2);

      X1 := X2;
      Y1 := Y2;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawCubicSpline(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i       : Integer;
  XArray  : DoubleDynamicArray;
  YArray  : DoubleDynamicArray;
  Y2Array : DoubleDynamicArray;
  Size    : Integer;
begin
  if Count < 2 then Exit;

  SetLength(XArray,  Count+1);
  SetLength(YArray,  Count+1);
  SetLength(Y2Array, Count+1);

  Size := 0;
  for i := 0 to Count-1 do
    begin
      if DataEmpty[i] then Continue;
      if not DataNull[i] then
        begin
          Size := Size + 1;
          XArray[Size] := DataX[i];
          YArray[Size] := DataY[i];
        end
      else
        begin
          DrawCubicSplineSet(Canvas, XYAxisReverse, XArray, YArray, Y2Array, Size);
          Size := 0;
        end;
    end;

  if Size  > 0 then DrawCubicSplineSet(Canvas, XYAxisReverse, XArray, YArray, Y2Array, Size);

  XArray  := nil;
  YArray  := nil;
  Y2Array := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawPolynomial(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i            : Integer;
  XArray       : DoubleDynamicArray;
  YArray       : DoubleDynamicArray;
  Y2Array      : DoubleDynamicArray;
  XPixelsStart : Integer;
  XPixelsStop  : Integer;
  XStart       : Double;
  XStop        : Double;
  XValue       : Double;
  YValue       : Double;
  X1, X2       : Double;
  Y1, Y2       : Double;
  DY           : Double;
begin
  if Count < 2 then Exit;

  Canvas.Brush.Style := FFillStyle;
  if FillUseChannelColor then Canvas.Brush.Color := Color else Canvas.Brush.Color := FillColor;

  Windows.SetBkColor(Canvas.Handle, BackGroundColor);

  SetLength(XArray,  Count+1);
  SetLength(YArray,  Count+1);
  SetLength(Y2Array, Count+1);
  for i := 0 to Count -1 do
    begin
      XArray[i+1] := DataX[i];
      YArray[i+1] := DataY[i];
    end;

  XStart := DataX[0];
  XStop  := DataX[Count-1];

  if XStart < XAxis.Min then XStart := XAxis.Min;
  if XStop  > XAxis.Max then XStop  := XAxis.Max;

  XPixelsStart := XAxis.PositionToPixels(XStart);
  XPixelsStop  := XAxis.PositionToPixels(XStop);

  if XPixelsStart > XPixelsStop then SwapIntegers(XPixelsStart, XPixelsStop);

  XValue := XAxis.PixelsToPosition(XPixelsStart);
  PolynomialInterpolation(XArray, YArray, Count, XValue, YValue, DY);
  X1 := XValue;
  Y1 := YValue;

  if FFillEnabled and (FFillStyle <> bsClear) then
    begin
      Canvas.Pen.Color := Canvas.Brush.Color;
      DrawLine(Canvas, XYAxisReverse, X1, FFillReference, X1, Y1, ipurScale);
      Canvas.Pen.Color := Color;
      AddPixelListValue(XAxis.PositionToPixels(X1), Y1);
    end;

  for i := XPixelsStart to XPixelsStop do
    begin
      XValue := XAxis.PixelsToPosition(i);
      PolynomialInterpolation(XArray, YArray, Count, XValue, YValue, DY);

      X2 := XValue;
      Y2 := YValue;

      if FFillEnabled and (FFillStyle <> bsClear) then
        begin
          Canvas.Pen.Color := Canvas.Brush.Color;
          DrawLine(Canvas, XYAxisReverse, X2, FFillReference, X2, Y2, ipurScale);
          Canvas.Pen.Color := Color;
        end;

      DrawLine(Canvas, XYAxisReverse, X1, Y1, X2, Y2, ipurScale);
      AddPixelListValue(XAxis.PositionToPixels(X2), Y2);

      X1 := X2;
      Y1 := Y2;
    end;

  XArray  := nil;
  YArray  := nil;
  Y2Array := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DrawRational(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i            : Integer;
  XArray       : DoubleDynamicArray;
  YArray       : DoubleDynamicArray;
  Y2Array      : DoubleDynamicArray;
  XPixelsStart : Integer;
  XPixelsStop  : Integer;
  XStart       : Double;
  XStop        : Double;
  XValue       : Double;
  YValue       : Double;
  X1, X2       : Double;
  Y1, Y2       : Double;
  DY           : Double;
begin
  if Count < 2 then Exit;

  Canvas.Brush.Style := FFillStyle;
  if FillUseChannelColor then Canvas.Brush.Color := Color else Canvas.Brush.Color := FillColor;

  SetLength(XArray,  Count+1);
  SetLength(YArray,  Count+1);
  SetLength(Y2Array, Count+1);
  for i := 0 to Count -1 do
    begin
      XArray[i+1] := DataX[i];
      YArray[i+1] := DataY[i];
    end;

  XStart := DataX[0];
  XStop  := DataX[Count-1];

  if XStart < XAxis.Min then XStart := XAxis.Min;
  if XStop  > XAxis.Max then XStop  := XAxis.Max;

  XPixelsStart := XAxis.PositionToPixels(XStart);
  XPixelsStop  := XAxis.PositionToPixels(XStop);

  if XPixelsStart > XPixelsStop then SwapIntegers(XPixelsStart, XPixelsStop);

  XValue := XAxis.PixelsToPosition(XPixelsStart);
  RationalInterpolation(XArray, YArray, Count, XValue, YValue, DY);
  X1 := XValue;
  Y1 := YValue;

  if FFillEnabled and (FFillStyle <> bsClear) then
    begin
      Canvas.Pen.Color := Canvas.Brush.Color;
      DrawLine(Canvas, XYAxisReverse, X1, FFillReference, X1, Y1, ipurScale);
      Canvas.Pen.Color := Color;
      AddPixelListValue(XAxis.PositionToPixels(X1), Y1);
    end;

  for i := XPixelsStart to XPixelsStop do
    begin
      XValue := XAxis.PixelsToPosition(i);
      RationalInterpolation(XArray, YArray, Count, XValue, YValue, DY);

      X2 := XValue;
      Y2 := YValue;

      if FFillEnabled and (FFillStyle <> bsClear) then
        begin
          Canvas.Pen.Color := Canvas.Brush.Color;
          DrawLine(Canvas, XYAxisReverse, X2, FFillReference, X2, Y2, ipurScale);
          Canvas.Pen.Color := Color;
        end;

      DrawLine(Canvas, XYAxisReverse, X1, Y1, X2, Y2, ipurScale);
      AddPixelListValue(XAxis.PositionToPixels(X2), Y2);

      X1 := X2;
      Y1 := Y2;
    end;

  XArray  := nil;
  YArray  := nil;
  Y2Array := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.CalcStartXIndex;
var
  i : Integer;
begin
  StartIndex := -1;

  if not Assigned(XAxis) then exit;
  if DataList.Count = 0  then exit;

  if (not DrawOutOfOrderXValues) then
    begin
      if FXIncreasing then
        begin
          StartIndex := CalcXIndexIncreasing(XAxis.Min);
          if DataList.X[StartIndex] > XAxis.Min then StartIndex := StartIndex - 1;
        end
      else
        begin
          StartIndex := CalcXIndexDecreasing(XAxis.Max);
          if DataList.X[StartIndex] < XAxis.Max then StartIndex := StartIndex - 1;
        end;
    end
  else
    begin
      StartIndex := Count-1;

      for i := 0 to Count-1 do                        
        if XAxis.PointOnScale(DataX[i]) and (i < StartIndex) then StartIndex := i;

      if StartIndex <> -1 then StartIndex := StartIndex - 1;
    end;

  if StartIndex < 0                  then StartIndex := 0;
  if StartIndex > (DataList.Count-1) then StartIndex := DataList.Count-1;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.CalcStopXIndex;
var
  i : Integer;
begin
  StopIndex := -1;

  if not Assigned(XAxis) then exit;
  if DataList.Count = 0  then exit;

  if (not DrawOutOfOrderXValues) then
    begin
      if FXIncreasing then
        begin
          StopIndex := CalcXIndexIncreasing(XAxis.Max);
          if DataList.X[StopIndex] < XAxis.Max then StopIndex := StopIndex + 1;
        end
      else
        begin
          StopIndex := CalcXIndexDecreasing(XAxis.Min);
          if DataList.X[StopIndex] > XAxis.Min then StopIndex := StopIndex + 1;
        end;
    end
  else
    begin
      for i := 0 to Count-1 do
        if XAxis.PointOnScale(DataX[i]) and (i > StopIndex) then
          StopIndex := i;

      if StopIndex <> -1 then StopIndex := StopIndex + 1;
    end;

   if StopIndex <  0                 then StopIndex := 0;
   if StopIndex > (DataList.Count-1) then StopIndex := DataList.Count-1;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.CalcXIndexIncreasing(TargetValue: Double): Integer;
var
  MinIndex    : Integer;
  MaxIndex    : Integer;
  MiddleIndex : Integer;
  MiddleValue : Double;
begin
  Result   := -1;
  MinIndex := 0;
  MaxIndex := DataList.Count - 1;

  while MinIndex <= MaxIndex do
    begin
      MiddleIndex := (MinIndex + MaxIndex) div 2;
      MiddleValue := DataList.X[MiddleIndex];
      Result  := MiddleIndex;

      if MiddleValue = TargetValue then Break;

      if MiddleValue > TargetValue then MaxIndex := MiddleIndex - 1
      else                              MinIndex := MiddleIndex + 1;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.CalcXIndexDecreasing(TargetValue: Double): Integer;
var
  MinIndex    : Integer;
  MaxIndex    : Integer;
  MiddleIndex : Integer;
  MiddleValue : Double;
begin
  Result   := -1;
  MinIndex := 0;
  MaxIndex := DataList.Count - 1;

  while MinIndex <= MaxIndex do
    begin
      MiddleIndex := (MinIndex + MaxIndex) div 2;
      MiddleValue := DataList.X[MiddleIndex];
      Result  := MiddleIndex;

      if MiddleValue = TargetValue then Break;

      if MiddleValue > TargetValue then MinIndex := MiddleIndex + 1
      else                              MaxIndex := MiddleIndex - 1;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.CalcIndex(TargetValue: Double): Integer;
begin
  Result := -1;

  if not Assigned(XAxis) then exit;
  if DataList.Count = 0  then exit;

  if fXIncreasing then
    begin
      if TargetValue < DataList.X[0]                then Exit;
      if TargetValue > DataList.X[DataList.Count-1] then Exit;

      Result := CalcXIndexIncreasing(TargetValue);
      if DataList.X[Result] < TargetValue then Result := Result + 1;
    end
  else
    begin
      if TargetValue > DataList.X[0]                then Exit;
      if TargetValue < DataList.X[DataList.Count-1] then Exit;

      Result := CalcXIndexDecreasing(TargetValue);
      if DataList.X[Result] < TargetValue then Result := Result - 1;
    end;

   if Result < 0                  then Result := 0;
   if Result > (DataList.Count-1) then Result := DataList.Count-1;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetYInterpolated(XValue: Double; var YValue : Double): Boolean;
var
  DataIndex    : Integer;
  DeltaXFound  : Double;
  DeltaYFound  : Double;
  DeltaXActual : Double;
  XFound       : Double;
  XIndexLower  : Integer;
  XIndexHigher : Integer;
begin
  if (Count <> 0) then
  begin
    if DataValid[0] and (XValue = DataX[0]) then
      begin
        YValue := DataY[0];
        Result := True;
        Exit;
      end;
    if DataValid[Count-1] and (XValue = DataX[Count-1]) then
      begin
        YValue := DataY[Count-1];
        Result := True;
        Exit;
      end;
  end;

  Result := False;
  YValue := 0;
  DataIndex := CalcIndex(XValue);

  if FXIncreasing then
    begin
      XIndexLower  := DataIndex - 1;
      XIndexHigher := DataIndex;
    end
  else
    begin
      XIndexLower  := DataIndex + 1;
      XIndexHigher := DataIndex;
    end;                                 

  if (XIndexLower <> - 1) and (XIndexHigher <> - 1) then
    begin
      if DigitalEnabled then
        begin
          Result := True;
          YValue := GetDataY(XIndexLower);
          Exit;
        end;
      XFound := DataX[XIndexHigher];
      if XFound = XValue then
        begin
          YValue := GetDataY(XIndexHigher);
          Result := True;
        end
      else
        begin
          if XIndexHigher > 0 then
            begin
              if not DataNull[XIndexHigher] and not DataNull[XIndexLower] then
                begin
                  DeltaXFound  := TiPlotAxisAccess(XAxis).PositionToPixels(DataX[XIndexLower]) - TiPlotAxisAccess(XAxis).PositionToPixels(DataX[XIndexHigher]);
                  DeltaXActual := TiPlotAxisAccess(XAxis).PositionToPixels(XValue)             - TiPlotAxisAccess(XAxis).PositionToPixels(DataX[XIndexHigher]);
                  DeltaYFound  := DataY[XIndexLower] - DataY[XIndexHigher];

                  if (DeltaXFound = 0) or (DeltaXActual = 0) then
                    YValue := DataY[XIndexHigher]
                  else
                    YValue := DataY[XIndexHigher] + DeltaYFound*DeltaXActual/DeltaXFound;
                  Result := True;
                end;
            end;
        end
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetVisibleMaxX: Double;
var
  x : Integer;
begin
  Result := -1E300;
  if not AxesValid then Exit;
  if not Visible   then Exit;

  if DataList.Count > 2 then
    begin
      if DataList.X[0] <= DataList.X[1] then FXIncreasing := True else FXIncreasing := False;
    end
  else FXIncreasing := True;

  if Count <> 0 then
    begin
      if (FXIncreasing) then
        begin
          for x := Count-1 downto 0 do
            begin
              if DataNull [x] then Continue;
              if DataEmpty[x] then Continue;

              Result := DataXDrawMax[x];
              Break;
            end;
        end
      else
        begin
          for x := 0 to Count-1 do
            begin
              if DataNull [x] then Continue;
              if DataEmpty[x] then Continue;
              if not DataNull[x] then
                 begin
                  Result := DataXDrawMin[x];
                  Break;
                 end;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetVisibleMinX: Double;
var
  x : Integer;
begin
  Result := 1E300;
  if not AxesValid then Exit;
  if not Visible   then Exit;

  if DataList.Count > 2 then
    begin
      if DataList.X[0] <= DataList.X[1] then FXIncreasing := True else FXIncreasing := False;
    end
  else FXIncreasing := True;

  if Count <> 0 then
    begin
      if (FXIncreasing) then
        begin
          for x := 0 to Count-1 do
            begin
              if DataNull [x] then Continue;
              if DataEmpty[x] then Continue;
              if not DataNull[x] then
                 begin
                  Result := DataXDrawMin[x];
                  Break;
                 end;
            end;
        end
      else
        begin
          for x := Count-1 downto 0 do
            begin
              if DataNull [x] then Continue;
              if DataEmpty[x] then Continue;

              Result := DataXDrawMax[x];
              Break;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetVisibleMaxY: Double;
var
  x      : Integer;
  AValue : Double;
begin

  CalcStartXIndex;
  CalcStopXIndex;

  Result := -1E300;
  if not AxesValid   then Exit;
  if not Visible     then Exit;
  if StartIndex = -1 then Exit;
  if StopIndex  = -1 then Exit;

  for x := StartIndex to StopIndex do
    begin
      if DataNull [x] then Continue;
      if DataEmpty[x] then Continue;
      AValue := DataYDrawMax[x];
      if AValue > Result then Result := AValue;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetVisibleMinY: Double;
var
  x      : Integer;
  AValue : Double;
begin
  CalcStartXIndex;
  CalcStopXIndex;

  Result := 1E300;
  if not AxesValid   then Exit;
  if not Visible     then Exit;
  if StartIndex = -1 then Exit;
  if StopIndex  = -1 then Exit;

  for x := StartIndex to StopIndex do
    begin
      if DataNull[x]  then Continue;
      if DataEmpty[x] then Continue;
      AValue := DataYDrawMin[x];
      if AValue < Result then Result := AValue;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.DoYLookup(XValue: Double; var YValue: Double): TiPlotDataPointStatus;
var
  AIndex                    : Integer;
  AValid                    : Boolean;
  APointer1Pixels           : Integer;
  CanLookUp                 : Boolean;
  APixelPoint               : TiPlotPixelPoint;
  AActualInterpolationStyle : TiPlotInterpolationStyle;
begin
  Result := ipdpsEmpty;
  YValue := 0;

  if Count = 0                                then Exit;

  {if     FXIncreasing then if XValue < XFirst then Exit;
  if     FXIncreasing then if XValue > XLast  then Exit;

  if not FXIncreasing then if XValue > XFirst then Exit;
  if not FXIncreasing then if XValue < XLast  then Exit;   }

  if (XValue = XFirst) and DataValid[IndexFirst] then begin YValue := DataY[IndexFirst]; Result := ipdpsValid; Exit; end;
  if (XValue = XLast ) and DataValid[IndexLast]  then begin YValue := DataY[IndexLast];  Result := ipdpsValid; Exit; end;

  AActualInterpolationStyle := FInterpolationStyle;

  if DigitalEnabled then AActualInterpolationStyle := ipistStraightLine;

  case AActualInterpolationStyle of
    ipistStraightLine           :  begin
                                                    AValid := GetYInterpolated(XValue, YValue);
                                     if AValid then Result := ipdpsValid
                                     else           Result := ipdpsEmpty;
                                   end;
    ipistCubicSpline,
    ipistPolynomial,
    ipistRational               :  begin
                                     CanLookUp := True;

                                     APointer1Pixels := XAxis.PositionToPixels(XValue);

                                     if APointer1Pixels < FPixelListStart              then CanLookUp := False;
                                     if APointer1Pixels > FPixelListStop               then CanLookUp := False;
                                     if (FPixelListStart = 0) and (FPixelListStop = 0) then CanLookUp := False;
                                     if XValue < XFirst                                then CanLookUp := False;
                                     if XValue > XLast                                 then CanLookUp := False;

                                     if CanLookUp then
                                       begin
                                         APixelPoint := FPixelList.Objects[APointer1Pixels - FPixelListStart] as TiPlotPixelPoint;

                                                                  YValue := APixelPoint.YValue;
                                         if APixelPoint.Null then Result := ipdpsNull
                                         else                     Result := ipdpsValid;
                                       end;
                                   end;
    ipistDifferential           :  begin
                                     AIndex := CalcIndex(XValue) - 1;
                                     if AIndex > - 1 then
                                       begin
                                         YValue := DataY[AIndex];
                                         Result := ipdpsValid;
                                       end
                                     else if DataValid[Count-1] and (XValue > XLast) then
                                       begin
                                         YValue := YLast;
                                         Result := ipdpsValid;
                                       end;
                                   end;
    ipistDifferentialTerminated :  begin
                                     AIndex := CalcIndex(XValue) - 1;
                                     if AIndex > - 1 then
                                       begin
                                         YValue := DataY[AIndex];
                                         Result := ipdpsValid;
                                       end
                                   end;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.DataCursorUpate(Sender: TObject);
var
  iDataCursor : TiPlotDataCursor;

  AValue1     : Double;
  AValue2     : Double;
  APercent1   : Double;
  APercent2   : Double;
  ADelta      : Double;
  AScaler     : Double;

  AXValue     : Double;
  AYValue     : Double;
  AStatus     : TiPlotDataPointStatus;
begin
  iDataCursor := Sender as TiPlotDataCursor;
  AStatus     := ipdpsEmpty;
  AXValue     := 0;
  AYValue     := 0;

  APercent1   := iDataCursor.Pointer1Position/100;
  APercent2   := iDataCursor.Pointer2Position/100;

  if XAxis <> nil then AScaler := XAxis.CursorScaler else AScaler := 0;

  case iDataCursor.Style of
    ipcsValueXY       : begin
                          if XAxis <> nil then
                            begin
                              AXValue := XAxis.PercentToPosition(APercent1);
                              AStatus := DoYLookup(AXValue, AYValue);
                            end;
                        end;
    ipcsValueX        : begin
                          if XAxis <> nil then
                            begin
                              AXValue := XAxis.PercentToPosition(APercent1);
                              AStatus := DoYLookup(AXValue, AYValue);
                            end;
                        end;
    ipcsValueY        : begin
                          if XAxis <> nil then
                            begin
                              AXValue := XAxis.PercentToPosition(APercent1);
                              AStatus := DoYLookup(AXValue, AYValue);
                            end;
                        end;
    ipcsDeltaX        : begin
                          if XAxis <> nil then
                            begin
                              AValue1 := XAxis.PercentToPosition(APercent1);
                              AValue2 := XAxis.PercentToPosition(APercent2);
                              ADelta  := ABS(AValue1 - AValue2);
                              AXValue := ADelta*XAxis.CursorScaler;
                              AStatus := ipdpsValid;
                            end;
                        end;
    ipcsDeltaY        : begin
                          if YAxis <> nil then
                            begin
                              AValue1 := YAxis.PercentToPosition(APercent1);
                              AValue2 := YAxis.PercentToPosition(APercent2);
                              ADelta  := ABS(AValue1 - AValue2);
                              AYValue := ADelta*AScaler;
                              AStatus := ipdpsValid;
                            end;
                        end;
    ipcsInverseDeltaX : begin
                          if XAxis <> nil then
                            begin
                              AValue1 := XAxis.PercentToPosition(APercent1);
                              AValue2 := XAxis.PercentToPosition(APercent2);
                              ADelta  := ABS(AValue1 - AValue2);
                              if (ADelta <> 0) and (AScaler <> 0) then AXValue := 1/(ADelta*AScaler)
                              else                                     AXValue := 1E320;
                              AStatus := ipdpsValid;
                            end;
                        end;
  end;

  TiPlotDataCursorAccess(iDataCursor).SetData(AXValue, AYValue, AStatus);
  TiPlotDataCursorAccess(iDataCursor).CursorDisplayText := GetDataCursorDisplayText(iDataCursor.Style, AXValue, AYValue, AStatus);
end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetDataCursorDisplayText(Style: TiPlotDataCursorStyle; XValue, YValue: Double; Status: TiPlotDataPointStatus): String;
begin
  FDataCursorXText  := '';
  FDataCursorYText  := '';
  FDataCursorXValue := XValue;
  FDataCursorYValue := YValue;
  FDataCursorStatus := Status;

  if Assigned(XAxis) then
    begin
      case Style of
        ipcsValueXY       : begin
                              FDataCursorXText := GetXValueText(XValue);
                              if Assigned(YAxis) then
                                begin
                                  if DigitalEnabled then
                                    begin
                                      case Status of
                                        ipdpsValid : if YValue = 0 then
                                                       FDataCursorYText := GetTranslation('Low')
                                                     else
                                                       FDataCursorYText := GetTranslation('High');
                                        ipdpsNull  :   FDataCursorYText := GetTranslation('Null');
                                        ipdpsEmpty :   FDataCursorYText := GetTranslation('Empty');
                                      end;

                                    end
                                  else
                                    case Status of
                                      ipdpsValid : FDataCursorYText := GetYValueText(YValue);
                                      ipdpsNull  : FDataCursorYText := GetTranslation('Null');
                                      ipdpsEmpty : FDataCursorYText := GetTranslation('Empty');
                                    end;
                                end
                              else FDataCursorYText := 'No Y-Axis';

                              Result := FDataCursorXText + ', ' + FDataCursorYText;
                            end;
        ipcsValueX        : begin
                              FDataCursorXText := GetXValueText(XValue);
                              Result := FDataCursorXText;
                            end;
        ipcsValueY        : begin
                              if Assigned(YAxis) then
                                begin
                                  if DigitalEnabled then
                                    begin
                                      case Status of
                                        ipdpsValid : if YValue = 0 then FDataCursorYText := GetTranslation('Low') else Result := GetTranslation('High');
                                        ipdpsNull  :                    FDataCursorYText := GetTranslation('Null');
                                        ipdpsEmpty :                    FDataCursorYText := GetTranslation('Empty');
                                      end;
                                    end
                                  else
                                    case Status of
                                      ipdpsValid : FDataCursorYText := GetYValueText(YValue);
                                      ipdpsNull  : FDataCursorYText := GetTranslation('Null');
                                      ipdpsEmpty : FDataCursorYText := GetTranslation('Empty');
                                    end;
                                end
                              else FDataCursorYText := 'No Y-Axis';

                              Result := FDataCursorYText;
                            end;
        ipcsDeltaX        : begin
                              FDataCursorXText := GetXValueText(XValue);
                              Result := FDataCursorXText;
                            end;
        ipcsDeltaY        : begin
                              if Assigned(YAxis) then
                                begin
                                  FDataCursorYText := GetYValueText(YValue);
                                end
                              else FDataCursorYText := 'No Y-Axis';

                              Result := FDataCursorYText;
                            end;
        ipcsInverseDeltaX : begin
                              if XValue < 1E301 then
                                begin
                                  if Assigned(XAxis) then
                                    FDataCursorXText := TiPlotAxisAccess(XAxis).GetCursorValueText(XValue)
                                  else
                                    Result := GetTranslation('No X-Axis');
                                end
                              else
                                FDataCursorXText := GetTranslation('Infinite');
                              Result := FDataCursorXText;
                            end;
      end;
    end
  else
    begin
      FDataCursorXText := GetTranslation('No X-Axis');
      Result := FDataCursorXText;
    end;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiPlotChannel.OPCNewData(Sender: TObject);
var
  OPCItem : TiOPCItem;
begin
  OPCItem := Sender as TiOPCItem;
  case FOPCXValueSource of
    iopcxvsOPCServerTimeStamp : AddXYInternal     (OPCItem.TimeStamp, OPCItem.Data, False, False);
    iopcxvsSystemTimeStamp    : AddXYInternal     (Now,               OPCItem.Data, False, False);
    iopcxvsElapsedTime        : AddYElapsedTime   (                   OPCItem.Data);
    iopcxvsElapsedSeconds     : AddYElapsedSeconds(                   OPCItem.Data);
  end;
end;
{$endif}
//****************************************************************************************************************************************************
function TiPlotChannel.GetDataHigh         (const Index: Integer): Double;     begin Result := DataList.High [Index];        end;
function TiPlotChannel.GetDataLow          (const Index: Integer): Double;     begin Result := DataList.Low  [Index];        end;
function TiPlotChannel.GetDataOpen         (const Index: Integer): Double;     begin Result := DataList.Open [Index];        end;
function TiPlotChannel.GetDataClose        (const Index: Integer): Double;     begin Result := DataList.Close[Index];        end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetDataBarVisible   (const Index: Integer): Boolean;    begin Result := DataList.BarVisible[Index];   end;
function TiPlotChannel.GetDataBarReference (const Index: Integer): Double;     begin Result := DataList.BarReference[Index]; end;
function TiPlotChannel.GetDataBarWidth     (const Index: Integer): Double;     begin Result := DataList.BarWidth[Index];     end;
function TiPlotChannel.GetDataBarPenColor  (const Index: Integer): TColor;     begin Result := DataList.BarPenColor[Index];  end;
function TiPlotChannel.GetDataBarPenWidth  (const Index: Integer): Integer;    begin Result := DataList.BarPenWidth[Index];  end;
function TiPlotChannel.GetDataBarPenStyle  (const Index: Integer): TPenStyle;  begin Result := DataList.BarPenStyle[Index];  end;
function TiPlotChannel.GetDataBarBrushColor(const Index: Integer): TColor;     begin Result := DataList.BarBrushColor[Index];end;
function TiPlotChannel.GetDataBarBrushStyle(const Index: Integer): TBrushStyle;begin Result := DataList.BarBrushStyle[Index];end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.SetDataHigh         (const Index:Integer;const Value:Double     );begin DataList.High [Index]        :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataLow          (const Index:Integer;const Value:Double     );begin DataList.Low  [Index]        :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataOpen         (const Index:Integer;const Value:Double     );begin DataList.Open [Index]        :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataClose        (const Index:Integer;const Value:Double     );begin DataList.Close[Index]        :=Value;TriggerChange(Self);end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.SetDataBarVisible   (const Index:Integer;const Value:Boolean    );begin DataList.BarVisible[Index]   :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataBarReference (const Index:Integer;const Value:Double     );begin DataList.BarReference[Index] :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataBarWidth     (const Index:Integer;const Value:Double     );begin DataList.BarWidth[Index]     :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataBarPenColor  (const Index:Integer;const Value:TColor     );begin DataList.BarPenColor[Index]  :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataBarPenWidth  (const Index:Integer;const Value:Integer    );begin DataList.BarPenWidth[Index]  :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataBarPenStyle  (const Index:Integer;const Value:TPenStyle  );begin DataList.BarPenStyle[Index]  :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataBarBrushColor(const Index:Integer;const Value:TColor     );begin DataList.BarBrushColor[Index]:=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetDataBarBrushStyle(const Index:Integer;const Value:TBrushStyle);begin DataList.BarBrushStyle[Index]:=Value;TriggerChange(Self);end;
//****************************************************************************************************************************************************
function TiPlotChannel.GetBarReference : Double;     begin Result := DataList.StoredBarReference; end;
function TiPlotChannel.GetBarWidth     : Double;     begin Result := DataList.StoredBarWidth;     end;
function TiPlotChannel.GetBarPenColor  : TColor;     begin Result := DataList.StoredBarPenColor;  end;
function TiPlotChannel.GetBarPenWidth  : Integer;    begin Result := DataList.StoredBarPenWidth;  end;
function TiPlotChannel.GetBarPenStyle  : TPenStyle;  begin Result := DataList.StoredBarPenStyle;  end;
function TiPlotChannel.GetBarBrushColor: TColor;     begin Result := DataList.StoredBarBrushColor;end;
function TiPlotChannel.GetBarBrushStyle: TBrushStyle;begin Result := DataList.StoredBarBrushStyle;end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.SetBarReference (const Value:Double     );begin DataList.StoredBarReference :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetBarWidth     (const Value:Double     );begin DataList.StoredBarWidth     :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetBarPenColor  (const Value:TColor     );begin DataList.StoredBarPenColor  :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetBarPenWidth  (const Value:Integer    );begin DataList.StoredBarPenWidth  :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetBarPenStyle  (const Value:TPenStyle  );begin DataList.StoredBarPenStyle  :=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetBarBrushColor(const Value:TColor     );begin DataList.StoredBarBrushColor:=Value;TriggerChange(Self);end;
procedure TiPlotChannel.SetBarBrushStyle(const Value:TBrushStyle);begin DataList.StoredBarBrushStyle:=Value;TriggerChange(Self);end;
//****************************************************************************************************************************************************
procedure TiPlotChannel.AddPixelListValue(XPixel: Integer; YValue: Double);
var
  Index : Integer;
begin
  if XPixel < FPixelListStart then Raise Exception.Create('Pixel List XPixel out of Range');
  if XPixel > FPixelListStop  then Raise Exception.Create('Pixel List XPixel out of Range');

  Index := XPixel - FPixelListStart;
  (FPixelList.Objects[Index] as TiPlotPixelPoint).Null   := False;
  (FPixelList.Objects[Index] as TiPlotPixelPoint).YValue := YValue;
end;
//****************************************************************************************************************************************************
function TiPlotChannel.iMouseHitTest(MouseData: TiPlotMouseData): Boolean;
var
  YValue  : Double;
  YPixels : Integer;
  ARect   : TRect;
begin
  Result := inherited iMouseHitTest(MouseData);
  if not Assigned(XAxis) then Exit;
  if not Assigned(YAxis) then Exit;

  if MouseData.Button <> mbRight then Exit;

  if GetYInterpolated(XAxis.PixelsToPosition(MouseData.XAxisPixels), YValue) then
    begin
      YPixels := YAxis.PositionToPixels(YValue);

      ARect := iXYReverseRect(XYAxesReversed, MouseData.XAxisPixels - 10, MouseData.YAxisPixels - 10,
                                              MouseData.XAxisPixels + 10, MouseData.YAxisPixels + 10);
      if PtInRect(ARect, iXYReversePoint(XYAxesReversed, MouseData.XAxisPixels, YPixels)) then Result := True;
    end;
end;
//****************************************************************************************************************************************************
end.
