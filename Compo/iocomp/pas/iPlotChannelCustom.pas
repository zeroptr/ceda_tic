{*******************************************************}
{                                                       }
{       TiPlotChannelCustom                             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotChannelCustom;{$endif}
{$ifdef iCLX}unit QiPlotChannelCustom;{$endif}

interface

uses
  {$I iIncludeUses.inc}

  {$IFDEF iVCL} iPlotDataCustomList,  iPlotDataFullList,  iPlotDataNullList,  iPlotDataCompactList,  iPlotDataCompactIntervalList,{$ENDIF}
  {$IFDEF iCLX}QiPlotDataCustomList, QiPlotDataFullList, QiPlotDataNullList, QiPlotDataCompactList, QiPlotDataCompactIntervalList,{$ENDIF}


  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iClasses,  iPlotObjects,  iPlotAxis;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiClasses, QiPlotObjects, QiPlotAxis;{$ENDIF}

type
  TiPlotDataCursorStyle           = (ipcsValueXY, ipcsValueX, ipcsValueY, ipcsDeltaX, ipcsDeltaY, ipcsInverseDeltaX);
  TiPlotDataPointStatus           = (ipdpsValid, ipdpsNull, ipdpsEmpty);
  TiPlotDataStyle                 = (ipdsStandard, ipdsCompact, ipdsCompactInterval, ipdsFullFeature);
  TiPlotChannelDataPointMoveStyle = (ipcdpmsXandY, ipcdpmsXOnly, ipcdpmsYOnly);

  TiPlotChannelCustom = class(TiPlotManagerObject)
  private
    FXAxis                             : TiPlotXAxis;
    FYAxis                             : TiPlotYAxis;

    FSelectDataIndex                   : Integer;
    FSelectHitTestRect                 : TRect;
    FSelectMouseDown                   : Boolean;
    FSelectMouseDownIndex              : Integer;
    FMouseDownDataIndex                : Integer;
    FSelectDownRect                    : TRect;
    FMouseDownValueX                   : Double;
    FMouseDownValueY                   : Double;
    FMouseDownPixelX                   : Integer;
    FMouseDownPixelY                   : Integer;

    FStartIndex                        : Integer;
    FStopIndex                         : Integer;
    FDataList                          : TiPlotDataCustomList;

    FTitleText                         : String;
    FYAxisName                         : String;
    FXAxisName                         : String;
    FXAxisTrackingEnabled              : Boolean;
    FYAxisTrackingEnabled              : Boolean;

    FLoggingActive                     : Boolean;
    FLogBufferCount                    : Integer;

    FMarkersAllowIndividual            : Boolean;
    FMarkersTurnOffLimit               : Integer;

    FLegendRect                        : TRect;

    FVisibleInLegend                   : Boolean;
    FClipToAxes                        : Boolean;
    FShowDataPointHints                : Boolean;
    FUserCanMoveDataPoints             : Boolean;
    FUserCanMoveDataPointsStyle        : TiPlotChannelDataPointMoveStyle;
    FMarkersBrushUseChannelColor       : Boolean;
    FMarkersPenUseChannelColor         : Boolean;
    FTraceVisible                      : Boolean;
    FLogBufferSize                     : Integer;
    FLogFileName                       : String;

    FTag                               : OleVariant;

    FRunningCount                      : Integer;

    FRunningXMin                       : Double;
    FRunningXMax                       : Double;
    FRunningXMean                      : Double;
    FRunningXTotal                     : Extended;

    FRunningYMin                       : Double;
    FRunningYMax                       : Double;
    FRunningYMean                      : Double;
    FRunningYTotal                     : Extended;

    FDataStyle                         : TiPlotDataStyle;
    FMarkersFont                       : TFont;

    FLoadingSeparator                  : Char;
  protected
    FDataCursorXText             : String;
    FDataCursorYText             : String;
    FDataCursorYValue            : Double;
    FDataCursorXValue            : Double;
    FDataCursorStatus            : TiPlotDataPointStatus;

    procedure SetTitleText                  (const Value: String);
    procedure SetColor                      (const Value: TColor);
    procedure SetCount                      (const Value: Integer);
    procedure SetLegendRect                 (const Value: TRect);
    procedure SetXAxisName                  (const Value: String);
    procedure SetYAxisName                  (const Value: String);
    procedure SetMarkersVisible             (const Value: Boolean);
    procedure SetMarkersBrushColor          (const Value: TColor);
    procedure SetMarkersBrushStyle          (const Value: TBrushStyle);
    procedure SetMarkersPenColor            (const Value: TColor);
    procedure SetMarkersPenStyle            (const Value: TPenStyle);
    procedure SetMarkersPenWidth            (const Value: Integer);
    procedure SetMarkersSize                (const Value: Integer);
    procedure SetMarkersStyle               (const Value: TiPlotMarkerStyle);
    procedure SetMarkersFont                (const Value: TFont);
    procedure SetXAxisTrackingEnabled       (const Value: Boolean);
    procedure SetYAxisTrackingEnabled       (const Value: Boolean);
    procedure SetVisibleInLegend            (const Value: Boolean);
    procedure SetClipToAxes                 (const Value: Boolean);
    procedure SetShowDataPointHints         (const Value: Boolean);
    procedure SetUserCanMoveDataPoints      (const Value: Boolean);
    procedure SetUserCanMoveDataPointsStyle (const Value: TiPlotChannelDataPointMoveStyle);
    procedure SetMarkersBrushUseChannelColor(const Value: Boolean);
    procedure SetMarkersPenUseChannelColor  (const Value: Boolean);
    procedure SetTraceVisible               (const Value: Boolean);
    procedure SetTraceLineStyle             (const Value: TiPlotLineStyle);
    procedure SetTraceLineWidth             (const Value: Integer);
    procedure SetLogBufferSize              (const Value: Integer);
    procedure SetLogFileName                (const Value: String);
    procedure SetMarkersAllowIndividual     (const Value: Boolean);
    procedure SetMarkersTurnOffLimit        (const Value: Integer);
    procedure SetDataStyle                  (const Value: TiPlotDataStyle);

    function GetTraceLineWidth   : Integer;
    function GetColor            : TColor;
    function GetTraceLineStyle   : TiPlotLineStyle;
    function GetMarkersVisible   : Boolean;
    function GetMarkersSize      : Integer;
    function GetMarkersStyle     : TiPlotMarkerStyle;
    function GetMarkersPenColor  : TColor;
    function GetMarkersBrushColor: TColor;
    function GetMarkersBrushStyle: TBrushStyle;
    function GetMarkersPenStyle  : TPenStyle;
    function GetMarkersPenWidth  : Integer;
    function GetCapacity         : Integer;
    function GetMemoryUsed       : Integer;

    function GetXAxis            : TiPlotXAxis;
    function GetYAxis            : TiPlotYAxis;

    function  GetDataMarkerBrushColor(const Index: Integer): TColor;
    function  GetDataMarkerBrushStyle(const Index: Integer): TBrushStyle;
    function  GetDataMarkerPenColor  (const Index: Integer): TColor;
    function  GetDataMarkerPenStyle  (const Index: Integer): TPenStyle;
    function  GetDataMarkerPenWidth  (const Index: Integer): Integer;
    function  GetDataMarkerSize      (const Index: Integer): Integer;
    function  GetDataMarkerCharacter (const Index: Integer): Char;
    function  GetDataTraceLineColor  (const Index: Integer): TColor;
    function  GetDataTraceLineStyle  (const Index: Integer): TiPlotLineStyle;
    function  GetDataTraceLineWidth  (const Index: Integer): Integer;

    procedure SetDataMarkerBrushColor(const Index: Integer; const Value: TColor);
    procedure SetDataMarkerBrushStyle(const Index: Integer; const Value: TBrushStyle);
    procedure SetDataMarkerPenColor  (const Index: Integer; const Value: TColor);
    procedure SetDataMarkerPenStyle  (const Index: Integer; const Value: TPenStyle);
    procedure SetDataMarkerPenWidth  (const Index, Value: Integer);
    procedure SetDataMarkerSize      (const Index, Value: Integer);
    procedure SetDataMarkerCharacter (const Index: Integer; const Value: Char);
    procedure SetDataTraceLineColor  (const Index: Integer; const Value: TColor);
    procedure SetDataTraceLineStyle  (const Index: Integer; const Value: TiPlotLineStyle);
    procedure SetDataTraceLineWidth  (const Index, Value: Integer);

    function GetIndexFirst: Integer;
    function GetIndexLast : Integer;
    function GetXFirst    : Double;
    function GetXLast     : Double;
    function GetYFirst    : Double;
    function GetYLast     : Double;

    function GetPixelRect(X1, Y1, X2, Y2: Double): TRect;

    function GetMarkerPoint(DataIndex: Integer): TPoint;
    function GetMarkerRect (DataIndex: Integer): TRect;

    function GetDataPointSize: Integer;
    function GetMaxDataPoints: Integer;

    function GetDataMarkerShowing(const Index: Integer): Boolean;

    procedure SetRingBufferSize(const Value: Integer);
    function  GetRingBufferSize: Integer;

    procedure GetViewIntersectPoint(ValueXInView, ValueYInView: Double; var ValueXOutOfView: Double; var ValueYOutOfView: Double);
    function  GetNewY(DataX1, DataY1, DataX2, DataY2, NewX: Double): Double;
    function  GetNewX(DataX1, DataY1, DataX2, DataY2, NewY: Double): Double;

    procedure GetPointPixels(ValueX, ValueY : Double; var PixelsX : Integer; var PixelsY : Integer);

    function  AxesValid : Boolean;

    function  GetCount                                : Integer;
    function  GetDataX          (const Index: Integer): Double;
    function  GetDataY          (const Index: Integer): Double;
    function  GetDataNull       (const Index: Integer): Boolean;
    function  GetDataEmpty      (const Index: Integer): Boolean;
    function  GetDataValid      (const Index: Integer): Boolean;
    function  GetDataMarkerShow (const Index: Integer): Boolean;
    function  GetDataMarkerStyle(const Index: Integer): TiPlotMarkerStyle;

    procedure SetDataX           (const Index: Integer; const Value: Double);
    procedure SetDataY           (const Index: Integer; const Value: Double);
    procedure SetDataNull        (const Index: Integer; const Value: Boolean);
    procedure SetDataEmpty       (const Index: Integer; const Value: Boolean);
    procedure SetDataMarkerShow  (const Index: Integer; const Value: Boolean);
    procedure SetDataMarkerStyle (const Index: Integer; const Value: TiPlotMarkerStyle);

    function GetDataXDrawMax(Index: Integer): Double;
    function GetDataXDrawMin(Index: Integer): Double;
    function GetDataYDrawMax(Index: Integer): Double;
    function GetDataYDrawMin(Index: Integer): Double;

    procedure CalcStartXIndex; virtual; abstract;
    procedure CalcStopXIndex;  virtual; abstract;

    function  GetVisibleMaxX : Double; virtual; abstract;
    function  GetVisibleMinX : Double; virtual; abstract;
    function  GetVisibleMaxY : Double; virtual; abstract;
    function  GetVisibleMinY : Double; virtual; abstract;

    procedure DataCursorUpate(Sender: TObject); virtual; abstract;

    function  AddXYInternal(const X, Y: Double; const Null, Empty: Boolean) : Integer;

    function  GetXValueFromMousePoint(X, Y: Integer): Double;

    procedure DrawConnectPoints(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor); virtual;
    procedure DrawLine         (Canvas: TCanvas; XYAxisReverse: Boolean; X1, Y1, X2, Y2: Double; YRef: TiPlotUnitReferenceStyle);
    procedure DrawQuadPolygon  (Canvas: TCanvas; XYAxisReverse: Boolean; Point1, Point2, Point3, Point4: TPointDouble);
    procedure DrawMarkers      (Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor); virtual;
    procedure DrawMarker       (Canvas: TCanvas; Index: Integer; CenterPoint : TPoint; BackGroundColor: TColor);

    procedure WriteLog;

    procedure DoMouseHint(MouseData: TiPlotMouseData; var HintData: TiHintData);                                override;
    procedure DoMouseLeft(MouseData: TiPlotMouseData);                                                          override;
    procedure DoMouseMove(MouseData: TiPlotMouseData);                                                          override;
    procedure DoMouseUp  (MouseData: TiPlotMouseData);                                                          override;

    function  GetMousePointer(APoint: TPoint): TCursor;                                                         override;

    function  iMouseHitTest(MouseData: TiPlotMouseData): Boolean;                                               override;

    procedure NotificationRemove  (Sender: TObject); override;
    procedure NotificationRename  (Sender: TObject); override;
    procedure NotificationSetFocus(Sender: TObject); override;

    procedure AddMenuItems(PopupMenu: TPopUpMenu);                                                              override;

    property DataList          : TiPlotDataCustomList   read FDataList;
    property LegendRect        : TRect                  read FLegendRect              write SetLegendRect;
    property StartIndex        : Integer                read FStartIndex              write FStartIndex;
    property StopIndex         : Integer                read FStopIndex               write FStopIndex;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);              override;
    destructor  Destroy;                                                                                        override;

    function AddXY         (const X, Y :Double): Integer;                                                       virtual;

    procedure AddXYArrays(XData, YData: Variant);
    procedure AddXYArray(Data: Variant);

    procedure Clear;

    procedure DeletePoints(Size: Integer);

    procedure SavePropertiesToFile  (FileName: String);
    procedure LoadPropertiesFromFile(FileName: String);

    procedure SaveDataToFile  (FileName: String);
    procedure LoadDataFromFile(FileName: String; ClearPreviousData: Boolean);

    procedure LogActivate(Append: Boolean);
    procedure LogDeactivate;

    function GetXMin : Double;
    function GetXMax : Double;
    function GetXMean: Double;

    function GetYMin : Double;
    function GetYMax : Double;
    function GetYMean: Double;

    procedure ReCalcRunningMinMaxMean;

    function GetXValueText(Value: Double): String;
    function GetYValueText(Value: Double): String;

    procedure GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean);

    property XAxis                                     : TiPlotXAxis         read GetXAxis;
    property YAxis                                     : TiPlotYAxis         read GetYAxis;

    property XFirst                                    : Double              read GetXFirst;
    property XLast                                     : Double              read GetXLast;
    property YFirst                                    : Double              read GetYFirst;
    property YLast                                     : Double              read GetYLast;
    property IndexFirst                                : Integer             read GetIndexFirst;
    property IndexLast                                 : Integer             read GetIndexLast;

    property DrawStartIndex                            : Integer             read FStartIndex;
    property DrawStopIndex                             : Integer             read FStopIndex;

    property DataPointSize                             : Integer             read GetDataPointSize;
    property MaxDataPoints                             : Integer             read GetMaxDataPoints;
    property Capacity                                  : Integer             read GetCapacity;
    property MemoryUsed                                : Integer             read GetMemoryUsed;

    property Count                                     : Integer             read GetCount                     write SetCount;
    property DataX               [const Index: Integer]: Double              read GetDataX                     write SetDataX;
    property DataY               [const Index: Integer]: Double              read GetDataY                     write SetDataY;
    property DataNull            [const Index: Integer]: Boolean             read GetDataNull                  write SetDataNull;
    property DataEmpty           [const Index: Integer]: Boolean             read GetDataEmpty                 write SetDataEmpty;
    property DataValid           [const Index: Integer]: Boolean             read GetDataValid;

    property DataTraceLineColor  [const Index: Integer]: TColor              read GetDataTraceLineColor        write SetDataTraceLineColor;
    property DataTraceLineWidth  [const Index: Integer]: Integer             read GetDataTraceLineWidth        write SetDataTraceLineWidth;
    property DataTraceLineStyle  [const Index: Integer]: TiPlotLineStyle     read GetDataTraceLineStyle        write SetDataTraceLineStyle;

    property DataMarkerShowing   [const Index: Integer]: Boolean             read GetDataMarkerShowing;
    property DataMarkerShow      [const Index: Integer]: Boolean             read GetDataMarkerShow            write SetDataMarkerShow;
    property DataMarkerStyle     [const Index: Integer]: TiPlotMarkerStyle   read GetDataMarkerStyle           write SetDataMarkerStyle;
    property DataMarkerSize      [const Index: Integer]: Integer             read GetDataMarkerSize            write SetDataMarkerSize;
    property DataMarkerPenColor  [const Index: Integer]: TColor              read GetDataMarkerPenColor        write SetDataMarkerPenColor;
    property DataMarkerPenStyle  [const Index: Integer]: TPenStyle           read GetDataMarkerPenStyle        write SetDataMarkerPenStyle;
    property DataMarkerPenWidth  [const Index: Integer]: Integer             read GetDataMarkerPenWidth        write SetDataMarkerPenWidth;
    property DataMarkerBrushColor[const Index: Integer]: TColor              read GetDataMarkerBrushColor      write SetDataMarkerBrushColor;
    property DataMarkerBrushStyle[const Index: Integer]: TBrushStyle         read GetDataMarkerBrushStyle      write SetDataMarkerBrushStyle;
    property DataMarkerCharacter [const Index: Integer]: Char                read GetDataMarkerCharacter       write SetDataMarkerCharacter;

    property RunningXMin                  : Double                         read FRunningXMin;
    property RunningXMax                  : Double                         read FRunningXMax;
    property RunningXMean                 : Double                         read FRunningXMean;

    property RunningYMin                  : Double                         read FRunningYMin;
    property RunningYMax                  : Double                         read FRunningYMax;
    property RunningYMean                 : Double                         read FRunningYMean;

    property DataXDrawMax[Index: Integer]: Double                          read GetDataXDrawMax;
    property DataXDrawMin[Index: Integer]: Double                          read GetDataXDrawMin;
    property DataYDrawMax[Index: Integer]: Double                          read GetDataYDrawMax;
    property DataYDrawMin[Index: Integer]: Double                          read GetDataYDrawMin;

    property DataCursorXText             : String                          read FDataCursorXText;
    property DataCursorYText             : String                          read FDataCursorYText;
    property DataCursorXValue            : Double                          read FDataCursorXValue;
    property DataCursorYValue            : Double                          read FDataCursorYValue;
    property DataCursorStatus            : TiPlotDataPointStatus           read FDataCursorStatus;
  published
    property TitleText                   : String                          read FTitleText                   write SetTitleText;
    property VisibleInLegend             : Boolean                         read FVisibleInLegend             write SetVisibleInLegend              default True;
    property ClipToAxes                  : Boolean                         read FClipToAxes                  write SetClipToAxes                   default False;
    property ShowDataPointHints          : Boolean                         read FShowDataPointHints          write SetShowDataPointHints           default False;
    property UserCanMoveDataPoints       : Boolean                         read FUserCanMoveDataPoints       write SetUserCanMoveDataPoints        default False;
    property UserCanMoveDataPointsStyle  : TiPlotChannelDataPointMoveStyle read FUserCanMoveDataPointsStyle  write SetUserCanMoveDataPointsStyle   default ipcdpmsXandY;
    property RingBufferSize              : Integer                         read GetRingBufferSize            write SetRingBufferSize               default 0;

    property TraceVisible                : Boolean                         read FTraceVisible                write SetTraceVisible                 default True;
    property Color                       : TColor                          read GetColor                     write SetColor                        default clRed;
    property TraceLineStyle              : TiPlotLineStyle                 read GetTraceLineStyle            write SetTraceLineStyle               default iplsSolid;
    property TraceLineWidth              : Integer                         read GetTraceLineWidth            write SetTraceLineWidth               default 1;

    property MarkersAllowIndividual      : Boolean                         read FMarkersAllowIndividual      write SetMarkersAllowIndividual       default False;
    property MarkersPenUseChannelColor   : Boolean                         read FMarkersPenUseChannelColor   write SetMarkersPenUseChannelColor    default True;
    property MarkersBrushUseChannelColor : Boolean                         read FMarkersBrushUseChannelColor write SetMarkersBrushUseChannelColor  default True;
    property MarkersTurnOffLimit         : Integer                         read FMarkersTurnOffLimit         write SetMarkersTurnOffLimit;

    property MarkersVisible              : Boolean                         read GetMarkersVisible            write SetMarkersVisible               default False;
    property MarkersSize                 : Integer                         read GetMarkersSize               write SetMarkersSize                  default 3;
    property MarkersStyle                : TiPlotMarkerStyle               read GetMarkersStyle              write SetMarkersStyle                 default ipmsCircle;
    property MarkersPenColor             : TColor                          read GetMarkersPenColor           write SetMarkersPenColor              default clRed;
    property MarkersPenStyle             : TPenStyle                       read GetMarkersPenStyle           write SetMarkersPenStyle              default psSolid;
    property MarkersPenWidth             : Integer                         read GetMarkersPenWidth           write SetMarkersPenWidth              default 0;
    property MarkersBrushColor           : TColor                          read GetMarkersBrushColor         write SetMarkersBrushColor            default clRed;
    property MarkersBrushStyle           : TBrushStyle                     read GetMarkersBrushStyle         write SetMarkersBrushStyle            default bsSolid;
    property MarkersFont                 : TFont                           read FMarkersFont                 write SetMarkersFont;

    property XAxisName                   : String                          read FXAxisName                   write SetXAxisName;
    property YAxisName                   : String                          read FYAxisName                   write SetYAxisName;
    property XAxisTrackingEnabled        : Boolean                         read FXAxisTrackingEnabled        write SetXAxisTrackingEnabled         default True;
    property YAxisTrackingEnabled        : Boolean                         read FYAxisTrackingEnabled        write SetYAxisTrackingEnabled         default True;

    property LogFileName                 : String                          read FLogFileName                 write SetLogFileName;
    property LogBufferSize               : Integer                         read FLogBufferSize               write SetLogBufferSize                default 0;
    property LoggingActive               : Boolean                         read FLoggingActive;

    property DataStyle                   : TiPlotDataStyle                 read FDataStyle                   write SetDataStyle;

    property Tag                         : OleVariant                      read FTag                         write FTag;
  end;

  TiPlotChannelCustomClass = class of TiPlotChannelCustom;

implementation

uses
{$ifdef iVCL} iPlotComponent,  iPlotDataCursor,  iPlotLegend,  iPlotChannel,  iXYPlotChannel;{$endif}
{$ifdef iCLX}QiPlotComponent, QiPlotDataCursor, QiPlotLegend, QiPlotChannel, QiXYPlotChannel;{$endif}

type
  TiPlotChannelAccess    = class(TiPlotChannel)end;
  TiPlotDataCursorAccess = class(TiPlotDataCursor)end;
  TiPlotComponentAccess  = class(TiPlotComponent )end;
//****************************************************************************************************************************************************
constructor TiPlotChannelCustom.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;
  FDataList                    := TiPlotDataNullList.Create;

  FVisibleInLegend             := True;

  FXAxisTrackingEnabled        := True;
  FYAxisTrackingEnabled        := True;

  FTraceVisible                := True;
  FMarkersBrushUseChannelColor := True;
  FMarkersPenUseChannelColor   := True;

  FRunningXMax                 := -1E+300;
  FRunningXMin                 :=  1E+300;
  FRunningXMean                :=      0;

  FRunningYMax                 := -1E+300;
  FRunningYMin                 :=  1E+300;
  FRunningYMean                :=      0;

  SetColor            (clRed);
  SetTraceLineWidth   (1);
  SetTraceLineStyle   (iplsSolid);

  SetMarkersSize      (3);
  SetMarkersPenColor  (clRed);
  SetMarkersBrushColor(clRed);

  FMarkersFont          := TFont.Create;
  FMarkersFont.Color    := clWhite;
  FMarkersFont.Style    := [fsBold];
  FMarkersFont.OnChange := TriggerChange;
end;
//****************************************************************************************************************************************************
destructor TiPlotChannelCustom.Destroy;
begin
  FMarkersFont.Free;
  FDataList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetXAxis: TiPlotXAxis;
begin
  if not Assigned(FXAxis)then FXAxis:=(Owner as TiPlotComponent).GetXAxisByName(FXAxisName);
  Result := FXAxis;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetYAxis: TiPlotYAxis;
begin
  if not Assigned(FYAxis)then FYAxis:=(Owner as TiPlotComponent).GetYAxisByName(FYAxisName);
  Result := FYAxis;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.NotificationRemove(Sender: TObject);
begin
  if Sender = FXAxis then FXAxis := nil;
  if Sender = FYAxis then FYAxis := nil;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.NotificationRename(Sender: TObject);
begin
  if Sender = FXAxis then FXAxisName := (Sender as TiPlotXAxis).Name;
  if Sender = FYAxis then FYAxisName := (Sender as TiPlotYAxis).Name;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetXAxisName(const Value:String);
begin
  if FXAxisName <> Value then
    begin
      FXAxisName := Value;
      FXAxis     := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetYAxisName(const Value:String);
begin
  if FYAxisName <> Value then
    begin
      FYAxisName := Value;
      FYAxis     := nil;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetUserCanMoveDataPointsStyle(const Value: TiPlotChannelDataPointMoveStyle);
begin
  if FUserCanMoveDataPointsStyle <> Value then
    begin
      FUserCanMoveDataPointsStyle := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetTitleText                  (const Value:String );begin SetStringProperty (Value,FTitleText,                        TriggerChange);end;
procedure TiPlotChannelCustom.SetTraceVisible               (const Value:Boolean);begin SetBooleanProperty(Value,FTraceVisible,                     TriggerChange);end;
procedure TiPlotChannelCustom.SetMarkersAllowIndividual     (const Value:Boolean);begin SetBooleanProperty(Value,FMarkersAllowIndividual,           TriggerChange);end;
procedure TiPlotChannelCustom.SetXAxisTrackingEnabled       (const Value:Boolean);begin SetBooleanProperty(Value,FXAxisTrackingEnabled,             TriggerChange);end;
procedure TiPlotChannelCustom.SetYAxisTrackingEnabled       (const Value:Boolean);begin SetBooleanProperty(Value,FYAxisTrackingEnabled,             TriggerChange);end;
procedure TiPlotChannelCustom.SetVisibleInLegend            (const Value:Boolean);begin SetBooleanProperty(Value,FVisibleInLegend,                  TriggerChange);end;
procedure TiPlotChannelCustom.SetClipToAxes                 (const Value:Boolean);begin SetBooleanProperty(Value,FClipToAxes,                       TriggerChange);end;
procedure TiPlotChannelCustom.SetShowDataPointHints         (const Value:Boolean);begin SetBooleanProperty(Value,FShowDataPointHints,               nil          );end;
procedure TiPlotChannelCustom.SetUserCanMoveDataPoints      (const Value:Boolean);begin SetBooleanProperty(Value,FUserCanMoveDataPoints,            nil          );end;
procedure TiPlotChannelCustom.SetMarkersBrushUseChannelColor(const Value:Boolean);begin SetBooleanProperty(Value,FMarkersBrushUseChannelColor,      TriggerChange);end;
procedure TiPlotChannelCustom.SetMarkersPenUseChannelColor  (const Value:Boolean);begin SetBooleanProperty(Value,FMarkersPenUseChannelColor,        TriggerChange);end;
procedure TiPlotChannelCustom.SetLogBufferSize              (const Value:Integer);begin SetIntegerProperty(Value,FLogBufferSize,                    nil          );end;
procedure TiPlotChannelCustom.SetMarkersTurnOffLimit        (const Value:Integer);begin SetIntegerProperty(Value,FMarkersTurnOffLimit,              TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetMarkersFont(const Value: TFont);begin FMarkersFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetLogFileName(const Value: String);
begin
  if FLogFileName <> Value then
    begin
      if FLoggingActive then raise Exception.Create(GetTranslation('Log File Name can not be changed while logging is active.'));
      FLogFileName := Value;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetNewY(DataX1, DataY1, DataX2, DataY2, NewX : Double) : Double;
var
  Slope    : Double;
  Constant : Double;
begin
  if (DataX2-DataX1) <> 0 then
    begin
      Slope    := (DataY2-DataY1)/(DataX2-DataX1);
      Constant :=  DataY1 - Slope*DataX1;

      Result   := Slope*NewX + Constant;
    end
  else
    Result := 0;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetNewX(DataX1, DataY1, DataX2, DataY2, NewY : Double) : Double;
var
  Slope    : Double;
  Constant : Double;
begin
  if (DataX2-DataX1) <> 0 then
    begin
      Slope    := (DataY2-DataY1)/(DataX2-DataX1);
      Constant :=  DataY1 - Slope*DataX1;

      if Slope <> 0 then  Result := (NewY - Constant)/Slope else Result := DataY1;
    end
  else
    Result := DataX1;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.GetViewIntersectPoint(ValueXInView, ValueYInView: Double; var ValueXOutOfView: Double; var ValueYOutOfView: Double);
var
  Slope    : Double;
  Constant : Double;
begin
  if (ValueXOutOfView-ValueXInView) <> 0 then
    begin
      Slope    := (ValueYOutOfView-ValueYInView)/(ValueXOutOfView-ValueXInView);
      Constant :=  ValueYInView - Slope*ValueXInView;

      if not XAxis.ValueOnScale(ValueXOutOfView) then
        begin
          if ValueXOutOfView >= XAxis.Max then
            begin
              ValueXOutOfView := XAxis.Max;
              ValueYOutOfView := Slope*XAxis.Max + Constant;
            end
          else
            begin
              ValueXOutOfView := XAxis.Min;
              ValueYOutOfView := Slope*XAxis.Min + Constant;
            end
        end
      else
        begin
          if ValueYOutOfView >= YAxis.Max then
            begin
              ValueYOutOfView := YAxis.Max;
              if Slope <> 0 then ValueXOutOfView := (YAxis.Max - Constant)/Slope;
            end
          else
            begin
              ValueYOutOfView := YAxis.Min;
              if Slope <> 0 then ValueXOutOfView := (YAxis.Min - Constant)/Slope;
            end ;
        end;
    end
  else
    begin
      ValueXOutOfView := ValueXInView;
      if ValueYOutOfView > YAxis.Max then ValueYOutOfView := YAxis.Max
        else                              ValueYOutOfView := YAxis.Min;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DrawConnectPoints(Canvas: TCanvas; XYAxisReverse: Boolean; BackGroundColor: TColor);
var
  i            : Integer;
  Point1Empty  : Boolean;
  Point1XValue : Double;
  Point1YValue : Double;
  AInteger     : Integer;
begin
  if not FTraceVisible then Exit;

  Canvas.Pen.Color   := Color;
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style   := TPenStyle(TraceLineStyle);
  if TraceLineWidth = 1 then Canvas.Pen.Width := 0 else Canvas.Pen.Width := TraceLineWidth;

  if FStartIndex = FStopIndex then exit;

  Point1Empty  := True;
  Point1XValue := 0;
  Point1YValue := 0;

  for i := FStartIndex to FStopIndex do
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
          Canvas.Pen.Color   := DataTraceLineColor[i];
          Canvas.Pen.Style   := TPenStyle(DataTraceLineStyle[i]);
          AInteger           := DataTraceLineWidth[i];
          if AInteger = 1 then Canvas.Pen.Width := 0 else Canvas.Pen.Width := AInteger;

          Windows.SetBkColor(Canvas.Handle, BackGroundColor);

          DrawLine(Canvas, XYAxisReverse, Point1XValue, Point1YValue, DataX[i], DataY[i], ipurScale);

          Point1XValue := DataX[i];
          Point1YValue := DataY[i];
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DrawQuadPolygon(Canvas: TCanvas; XYAxisReverse: Boolean; Point1, Point2, Point3, Point4: TPointDouble);
var
  PointArray : array[0..3] of TPoint;
begin
  if XYAxisReverse then
    begin
      PointArray[0].y := XAxis.PositionToPixels(Point1.x);
      PointArray[0].x := YAxis.PositionToPixels(Point1.y);

      PointArray[1].y := XAxis.PositionToPixels(Point2.x);
      PointArray[1].x := YAxis.PositionToPixels(Point2.y);

      PointArray[2].y := XAxis.PositionToPixels(Point3.x);
      PointArray[2].x := YAxis.PositionToPixels(Point3.y);

      PointArray[3].y := XAxis.PositionToPixels(Point4.x);
      PointArray[3].x := YAxis.PositionToPixels(Point4.y);
    end
  else
    begin
      PointArray[0].x := XAxis.PositionToPixels(Point1.x);
      PointArray[0].y := YAxis.PositionToPixels(Point1.y);

      PointArray[1].x := XAxis.PositionToPixels(Point2.x);
      PointArray[1].y := YAxis.PositionToPixels(Point2.y);

      PointArray[2].x := XAxis.PositionToPixels(Point3.x);
      PointArray[2].y := YAxis.PositionToPixels(Point3.y);

      PointArray[3].x := XAxis.PositionToPixels(Point4.x);
      PointArray[3].y := YAxis.PositionToPixels(Point4.y);
    end;
  Canvas.Polygon(PointArray);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DrawLine(Canvas: TCanvas; XYAxisReverse: Boolean; X1, Y1, X2, Y2: Double; YRef: TiPlotUnitReferenceStyle);
var
  PixelsX1     : Integer;  // m = Slope == DeltaY/DeltaX
  PixelsX2     : Integer;  // b = Constant
  PixelsY2     : Integer;  // y = mx + b
  PixelsY1     : Integer;  // b = y - mx
  DataX1       : Double;
  DataX2       : Double;
  DataY1       : Double;
  DataY2       : Double;
  Point1InView : Boolean;
  Point2InView : Boolean;
  XCrossesView : Boolean;
  YCrossesView : Boolean;
begin
  with Canvas do
    begin
      if X1 <= X2 then
        begin
          DataX1 := X1;
          DataY1 := Y1;
          DataX2 := X2;
          DataY2 := Y2;
        end
      else
        begin
          DataX1 := X2;
          DataY1 := Y2;
          DataX2 := X1;
          DataY2 := Y1;
        end;

                                                              XCrossesView := False;
      if (DataX1 <  XAxis.Min) and (DataX2 >  XAxis.Max) then XCrossesView := True;
      if (DataX1 >= XAxis.Min) and (DataX1 <= XAxis.Max) then XCrossesView := True;
      if (DataX2 >= XAxis.Min) and (DataX2 <= XAxis.Max) then XCrossesView := True;

      if (YRef = ipurScale) and ClipToAxes then
        begin
                                                                  YCrossesView := False;
          if (DataY1 <  YAxis.Min) and (DataY2 >  YAxis.Max) then YCrossesView := True;
          if (DataY1 >  YAxis.Max) and (DataY2 <  YAxis.Min) then YCrossesView := True;
          if (DataY1 >= YAxis.Min) and (DataY1 <= YAxis.Max) then YCrossesView := True;
          if (DataY2 >= YAxis.Min) and (DataY2 <= YAxis.Max) then YCrossesView := True;
        end
      else
        YCrossesView := True;

      if not XCrossesView then Exit;
      if not YCrossesView then Exit;

      if DataX1 < XAxis.Min then
        begin
          DataY1 := GetNewY(DataX1, DataY1, DataX2, DataY2, XAxis.Min);
          DataX1 := XAxis.Min;
        end;

      if DataX2 > XAxis.Max then
        begin
          DataY2 := GetNewY(DataX1, DataY1, DataX2, DataY2, XAxis.Max);
          DataX2 := XAxis.Max;
        end;

      if (YRef = ipurScale) and ClipToAxes then
        begin
          if DataY1 > YAxis.Max then
            begin
              DataX1 := GetNewX(DataX1, DataY1, DataX2, DataY2, YAxis.Max);
              DataY1 := YAxis.Max;
            end
          else if DataY1 < YAxis.Min then
            begin
              DataX1 := GetNewX(DataX1, DataY1, DataX2, DataY2, YAxis.Min);
              DataY1 := YAxis.Min;
            end;

          if DataY2 > YAxis.Max then
            begin
              DataX2 := GetNewX(DataX1, DataY1, DataX2, DataY2, YAxis.Max);
              DataY2 := YAxis.Max;
            end
          else if DataY2 < YAxis.Min then
            begin
              DataX2 := GetNewX(DataX1, DataY1, DataX2, DataY2, YAxis.Min);
              DataY2 := YAxis.Min;
            end;

          Point1InView := XAxis.ValueOnScale(DataX1) and YAxis.ValueOnScale(DataY1);
          Point2InView := XAxis.ValueOnScale(DataX2) and YAxis.ValueOnScale(DataY2);
        end
      else
        begin
          Point1InView := XAxis.ValueOnScale(DataX1);
          Point2InView := XAxis.ValueOnScale(DataX2);
        end;

      if not ClipToAxes then
        begin
          Point1InView := True;
          Point2InView := True;
        end;

      if Point1InView and Point2InView then
        begin
          PixelsX1 := XAxis.PositionToPixels(DataX1);
          if YRef = ipurScale then
            begin
                                        PixelsY1 := YAxis.PositionToPixels(DataY1);
            end
          else
            begin
              if not XYAxisReverse then PixelsY1 := TiPlotComponentAccess(Owner).DataView[0].PositionPercentToPixelsY(DataY1)
              else                      PixelsY1 := TiPlotComponentAccess(Owner).DataView[0].PositionPercentToPixelsX(DataY1);
            end;

          PixelsX2 := XAxis.PositionToPixels(DataX2);
          if YRef = ipurScale then
            begin
                                        PixelsY2 := YAxis.PositionToPixels(DataY2);
            end
          else
            begin
              if not XYAxisReverse then PixelsY2 := TiPlotComponentAccess(Owner).DataView[0].PositionPercentToPixelsY(DataY2)
              else                      PixelsY2 := TiPlotComponentAccess(Owner).DataView[0].PositionPercentToPixelsX(DataY2);
            end;

          if XYAxisReverse then Polyline([Point(PixelsY1, PixelsX1), Point(PixelsY2, PixelsX2)])
            else                Polyline([Point(PixelsX1, PixelsY1), Point(PixelsX2, PixelsY2)]);
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataMarkerShowing(const Index: Integer): Boolean;
begin
  Result := False;

  if not MarkersVisible                                        then Exit;
  if DataNull[Index]                                           then Exit;
  if DataEmpty[Index]                                          then Exit;
  if not Assigned(XAxis)                                       then Exit;
  if not Assigned(YAxis)                                       then Exit;
  if FMarkersAllowIndividual then if not DataMarkerShow[Index] then Exit;
  if not XAxis.ValueOnScale(DataList.X[Index])                 then Exit;
  if not YAxis.ValueOnScale(DataList.Y[Index])                 then Exit;
  Result := True;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetMarkerPoint(DataIndex: Integer): TPoint;
var
  PixelsX : Integer;
  PixelsY : Integer;
begin
  PixelsX := XAxis.PositionToPixels(GetDataX(DataIndex));
  PixelsY := YAxis.PositionToPixels(GetDataY(DataIndex));

  if XYAxesReversed then Result := Point(PixelsY, PixelsX)
  else                   Result := Point(PixelsX, PixelsY);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetMarkerRect(DataIndex: Integer): TRect;
var
  APoint      : TPoint;
  AMarkerSize : Integer;
begin
  APoint := GetMarkerPoint(DataIndex);

  if MarkersAllowIndividual then AMarkerSize := DataMarkerSize[DataIndex]
  else                           AMarkerSize := MarkersSize;

  Result := Rect(APoint.X - AMarkerSize, APoint.Y - AMarkerSize, APoint.X + AMarkerSize, APoint.Y + AMarkerSize);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DrawMarkers(Canvas: TCanvas; XYAxisReverse : Boolean; BackGroundColor: TColor);
var
  i : Integer;
begin
  if not MarkersVisible then Exit;

  Canvas.Font.Assign(FMarkersFont);

  if (FMarkersTurnOffLimit > 0) and (ABS(FStopIndex - FStartIndex) > FMarkersTurnOffLimit) then Exit;

  for i := FStartIndex to FStopIndex do
    begin
      if not GetDataMarkerShowing(i) then Continue;

      if XYAxisReverse then DrawMarker(Canvas, i, GetMarkerPoint(i), BackGroundColor)
        else                DrawMarker(Canvas, i, GetMarkerPoint(i), BackGroundColor);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DrawMarker(Canvas: TCanvas; Index: Integer; CenterPoint : TPoint; BackGroundColor: TColor);
var
  MarkerStyle : TiPlotMarkerStyle;
  MarkerSize  : Integer;
  ARect       : TRect;
begin
  if not MarkersVisible then Exit;
  with Canvas do
    begin
      if Index <> - 1 then
        begin
          if MarkersAllowIndividual then
            begin
              MarkerStyle := DataMarkerStyle[Index];
              MarkerSize  := DataMarkerSize[Index];
              Pen.Width   := DataMarkerPenWidth[Index];
              Pen.Style   := DataMarkerPenStyle[Index];

              if FMarkersPenUseChannelColor   then Pen.Color   := Color else Pen.Color   := DataMarkerPenColor[Index];
              if FMarkersBrushUseChannelColor then Brush.Color := Color else Brush.Color := DataMarkerBrushColor[Index];

              Brush.Style := DataMarkerBrushStyle[Index];
            end
          else
            begin
              MarkerStyle := MarkersStyle;
              MarkerSize  := MarkersSize;
              Pen.Width   := MarkersPenWidth;
              Pen.Style   := MarkersPenStyle;

              if FMarkersPenUseChannelColor   then Pen.Color   := Color else Pen.Color   := MarkersPenColor;
              if FMarkersBrushUseChannelColor then Brush.Color := Color else Brush.Color := MarkersBrushColor;

              Brush.Style := MarkersBrushStyle;
            end;
        end
      else //Legend Requesting Draw
        begin
          MarkerStyle := MarkersStyle;
          MarkerSize  := MarkersSize; if MarkerSize > 6 then MarkerSize := 6;  //Legend Maximum

          Pen.Width   := MarkersPenWidth;
          Pen.Style   := MarkersPenStyle;

          if FMarkersPenUseChannelColor   then Pen.Color   := Color else Pen.Color   := MarkersPenColor;
          if FMarkersBrushUseChannelColor then Brush.Color := Color else Brush.Color := MarkersBrushColor;

          Brush.Style := MarkersBrushStyle;
        end;

      case MarkerStyle of
        ipmsCircle         : Ellipse   (       CenterPoint.X - MarkerSize, CenterPoint.Y - MarkerSize, CenterPoint.X + MarkerSize, CenterPoint.Y + MarkerSize);
        ipmsSquare         : Rectangle (       CenterPoint.X - MarkerSize, CenterPoint.Y - MarkerSize, CenterPoint.X + MarkerSize, CenterPoint.Y + MarkerSize);
        ipmsDiamond        : Polygon   ([Point(CenterPoint.X + MarkerSize, CenterPoint.Y              ),
                                         Point(CenterPoint.X             , CenterPoint.Y + MarkerSize),
                                         Point(CenterPoint.X - MarkerSize, CenterPoint.Y              ),
                                         Point(CenterPoint.X             , CenterPoint.Y - MarkerSize)]);

        ipmsCross          : begin
                               PolyLine([Point(CenterPoint.X + MarkerSize, CenterPoint.Y + MarkerSize),
                                         Point(CenterPoint.X - MarkerSize, CenterPoint.Y - MarkerSize)]);
                               PolyLine([Point(CenterPoint.X + MarkerSize, CenterPoint.Y - MarkerSize),
                                         Point(CenterPoint.X - MarkerSize, CenterPoint.Y + MarkerSize)]);
                             end;
        ipmsPlus           : begin
                               PolyLine([Point(CenterPoint.X             , CenterPoint.Y + MarkerSize),
                                         Point(CenterPoint.X             , CenterPoint.Y - MarkerSize)]);
                               PolyLine([Point(CenterPoint.X + MarkerSize, CenterPoint.Y              ),
                                         Point(CenterPoint.X - MarkerSize, CenterPoint.Y              )]);
                             end;
        ipmsTriangleUp     : Polygon   ([Point(CenterPoint.X - MarkerSize, CenterPoint.Y + MarkerSize),
                                         Point(CenterPoint.X             , CenterPoint.Y              ),
                                         Point(CenterPoint.X + MarkerSize, CenterPoint.Y + MarkerSize)]);
        ipmsTriangleDown   : Polygon   ([Point(CenterPoint.X - MarkerSize, CenterPoint.Y - MarkerSize),
                                         Point(CenterPoint.X             , CenterPoint.Y              ),
                                         Point(CenterPoint.X + MarkerSize, CenterPoint.Y - MarkerSize)]);
        ipmsTriangleLeft   : Polygon   ([Point(CenterPoint.X + MarkerSize, CenterPoint.Y - MarkerSize),
                                         Point(CenterPoint.X             , CenterPoint.Y              ),
                                         Point(CenterPoint.X + MarkerSize, CenterPoint.Y + MarkerSize)]);
        ipmsTriangleRight  : Polygon   ([Point(CenterPoint.X - MarkerSize, CenterPoint.Y - MarkerSize),
                                         Point(CenterPoint.X             , CenterPoint.Y              ),
                                         Point(CenterPoint.X - MarkerSize, CenterPoint.Y + MarkerSize)]);
        ipmsVerticalLine   : PolyLine  ([Point(CenterPoint.X,              CenterPoint.Y - MarkerSize), Point(CenterPoint.X, CenterPoint.Y + MarkerSize)]);
        ipmsHorizontalLine : PolyLine  ([Point(CenterPoint.X - MarkerSize, CenterPoint.Y),              Point(CenterPoint.X + MarkerSize, CenterPoint.Y)]);
        ipmsCharacter      : if DataMarkerCharacter[Index] <> #0 then
                               begin
                                 ARect := Rect(CenterPoint.X, CenterPoint.Y, CenterPoint.X, CenterPoint.Y);
                                 Brush.Style := bsClear;

                                 Windows.SetBkColor(Canvas.Handle, BackGroundColor);

                                 iDrawText(Canvas, DataMarkerCharacter[Index], ARect, [itfSingleLine, itfNoClip, itfHCenter, itfVCenter], True, clBtnFace);
                               end;
      end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.AxesValid: Boolean;
begin
  if Assigned(XAxis) and Assigned(YAxis) then Result := True else Result := False;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.GetPointPixels(ValueX, ValueY : Double; var PixelsX : Integer; var PixelsY : Integer);
begin
  if AxesValid then
    begin
      PixelsX := XAxis.PositionToPixels(ValueX);
      PixelsY := YAxis.PositionToPixels(ValueY);
    end
  else
    begin
      PixelsX := 0;
      PixelsY := 0;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.Clear;
begin
  FRunningXMax  := -1E+300;
  FRunningXMin  :=  1E+300;
  FRunningXMean :=      0;

  FRunningYMax  := -1E+300;
  FRunningYMin  :=  1E+300;
  FRunningYMean :=      0;

  FStartIndex := -1;
  FStopIndex  := -1;

  if FLoggingActive then LogDeactivate;
  DataList.Clear;
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.AddXY(const X, Y: Double) : Integer;
begin
  Result := AddXYInternal(X, Y, False, False);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.AddXYInternal(const X, Y: Double; const Null, Empty: Boolean) : Integer;
var
  NeedsWriteLog : Boolean;
begin
  Result := DataList.Add(X, Y, Null, Empty);

  if X > FRunningXMax then FRunningXMax := X;
  if X < FRunningXMin then FRunningXMin := X;

  if Y > FRunningYMax then FRunningYMax := Y;
  if Y < FRunningYMin then FRunningYMin := Y;

  Inc(FRunningCount);

  FRunningXTotal := FRunningXTotal + X;
  FRunningXMean  := FRunningXTotal / FRunningCount;

  FRunningYTotal := FRunningYTotal + Y;
  FRunningYMean  := FRunningYTotal / FRunningCount;

  if FXAxisTrackingEnabled or FYAxisTrackingEnabled then
    begin
      if MarkersVisible then
        begin
          if FXAxisTrackingEnabled and Assigned(XAxis) then
            begin
              if not DataNull[Count-1] then XAxis.NewTrackingData(GetDataXDrawMax(Count-1));
              if not DataNull[Count-1] then XAxis.NewTrackingData(GetDataXDrawMin(Count-1));
            end;
          if FYAxisTrackingEnabled and Assigned(YAxis) then
            begin
              if not DataNull[Count-1] then YAxis.NewTrackingData(GetDataYDrawMax(Count-1));
              if not DataNull[Count-1] then YAxis.NewTrackingData(GetDataYDrawMin(Count-1));
            end;
        end
      else
        begin
          if FXAxisTrackingEnabled and Assigned(XAxis)                                then XAxis.NewTrackingData(X);
          if FYAxisTrackingEnabled and Assigned(YAxis) and (not Null) and not (Empty) then YAxis.NewTrackingData(Y);
        end;
    end;

  if FLoggingActive then
    begin
      FLogBufferCount := FLogBufferCount + 1;

      NeedsWriteLog := False;

      if FLogBufferSize  <  2              then NeedsWriteLog := True;
      if FLogBufferCount >= FLogBufferSize then NeedsWriteLog := True;

      if NeedsWriteLog then WriteLog;
    end;

  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.AddXYArrays(XData, YData: Variant);
var
  x          : Integer;
  LowBoundX  : Integer;
  LowBoundY  : Integer;
  HighBoundX : Integer;
  HighBoundY : Integer;
begin
  if VarArrayDimCount(XData) <> 1 then raise Exception.Create('X-Data array must be 1 dimensional');
  if VarArrayDimCount(YData) <> 1 then raise Exception.Create('Y-Data array must be 1 dimensional');

  LowBoundX  := VarArrayLowBound (XData, 1);
  LowBoundY  := VarArrayLowBound (YData, 1);
  HighBoundX := VarArrayHighBound(XData, 1);
  HighBoundY := VarArrayHighBound(YData, 1);

  if LowBoundX  <> LowBoundY  then raise Exception.Create('X-Data and Y-Data low bound dimension must match');
  if HighBoundX <> HighBoundY then raise Exception.Create('X-Data and Y-Data hogh bound dimension must match');

  for x := LowBoundX to HighBoundX do
    AddXYInternal(XData[x], YData[x], False, False);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.AddXYArray(Data: Variant);
var
  x                 : Integer;

  LowBoundColumn    : Integer;
  HighBoundColumn   : Integer;

  LowBoundElements  : Integer;
  HighBoundElements : Integer;
begin
  if VarArrayDimCount(Data) <> 2 then raise Exception.Create('Array Must Be 2 Dimensional');

  LowBoundColumn    := VarArrayLowBound (Data, 1);
  HighBoundColumn   := VarArrayHighBound(Data, 1);

  if (HighBoundColumn - LowBoundColumn) <> 1 then raise Exception.Create('Array First Dimension Must Be 2 Elements');

  LowBoundElements  := VarArrayLowBound (Data, 2);
  HighBoundElements := VarArrayHighBound(Data, 2);

  for x := LowBoundElements to HighBoundElements do
    AddXYInternal(Data[LowBoundColumn, x], Data[HighBoundColumn, x], False, False);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.GetXYEmptyNull(const Index: Integer; var X, Y: Double; var Empty, Null: Boolean);
begin
  DataList.GetXYEmptyNull(Index, X, Y, Empty, Null);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetCount: Integer;
begin
  Result := DataList.Count;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetCount(const Value: Integer);
begin
  DataList.SetCapacity(Value);
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetLegendRect(const Value: TRect);
begin
  FLegendRect := Value;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataXDrawMax(Index: Integer): Double;
begin
  if DataNull[Index] then raise Exception.Create('Data Point Null');
  Result := DataList.X[Index];
  if MarkersVisible then
    begin
      if not Assigned(XAxis) then raise Exception.Create('X-Axis not assigned');
      Result := Result + ABS(XAxis.PixelsToPosition(MarkersSize + XAxis.MinPixels) - XAxis.Min);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataXDrawMin(Index: Integer): Double;
begin
  if DataNull[Index] then raise Exception.Create('Data Point Null');
  Result := DataList.X[Index];
  if MarkersVisible then
    begin
      if not Assigned(XAxis) then raise Exception.Create('X-Axis not assigned');
      Result := Result - ABS(XAxis.PixelsToPosition(MarkersSize + XAxis.MinPixels) - XAxis.Min);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataYDrawMax(Index: Integer): Double;
begin
  if DataNull[Index] then raise Exception.Create('Data Point Null');
  Result := DataList.Y[Index];
  if MarkersVisible then
    begin
      if not Assigned(YAxis) then raise Exception.Create('Y-Axis not assigned');
      Result := Result + ABS(YAxis.PixelsToPosition(MarkersSize + YAxis.MinPixels) - YAxis.Min);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataYDrawMin(Index: Integer): Double;
begin
  if DataNull[Index] then raise Exception.Create('Data Point Null');
  Result := DataList.Y[Index];
  if MarkersVisible then
    begin
      if not Assigned(YAxis) then raise Exception.Create('Y-Axis not assigned');
      Result := Result - ABS(YAxis.PixelsToPosition(MarkersSize + YAxis.MinPixels) - YAxis.Min);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetRingBufferSize(const Value: Integer);
begin
  DataList.RingBufferSize := Value;
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetRingBufferSize: Integer;
begin
  Result := DataList.RingBufferSize;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SavePropertiesToFile(FileName: String);
var
  AList      : TStringList;
  IgnoreList : TStringList;
begin
  try
    AList := TStringList.Create;
    IgnoreList := TStringList.Create;
    try
    IgnoreList.Add('Name');
    try
      AList.Add('File Type = Plot Channel Config');

      SaveObjectToStringList(Self, 'Channel', AList, IgnoreList);
      AList.SaveToFile(FileName);
    finally
      AList.Free;
    end;
  finally
    IgnoreList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Saving Properties - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.LoadPropertiesFromFile(FileName: String);
var
  AList   : TStringList;
  Found   : Boolean;
  AString : String;
begin
  try
  AList := TStringList.Create;
  AList.LoadFromFile(FileName);

  Found := GetPropertyValueString('File Type', AString, AList);
  if (not Found) or (UpperCase(AString) <> UpperCase('Plot Channel Config')) then
    raise Exception.Create('Incompatible Plot Channel Configuration File Type');
  try
    LoadObjectFromStringList(Self, 'Channel', AList);
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Loading Properties - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SaveDataToFile(FileName: String);
var
  x     : Integer;
  AList : TStringList;
begin
  AList := TStringList.Create;
  try
    for x := 0 to Count-1 do
      begin
        if      DataEmpty[x] then Continue
        else if DataNull[x]  then AList.Add(FloatToStr(DataX[x]) + TiPlotComponentAccess(Owner).GetSavingSeparator + 'Null')
        else                      AList.Add(FloatToStr(DataX[x]) + TiPlotComponentAccess(Owner).GetSavingSeparator + FloatToStr(DataY[x]));
      end;
    AList.SaveToFile(FileName);
  finally
    AList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.LoadDataFromFile(FileName: String; ClearPreviousData: Boolean);
var
  x         : Integer;
  AList     : TStringList;
  XString   : String;
  YString   : String;
begin
  if FLoggingActive then LogDeactivate;
  AList := TStringList.Create;
  try
    AList.LoadFromFile(FileName);
    if ClearPreviousData then Clear;

    if AList.Count <> 0 then if AnsiPos(#9, AList.Strings[0]) <> 0 then FLoadingSeparator := #9 else FLoadingSeparator := ',';

    for x := 0 to AList.Count-1 do
      begin
        SeparateStrings(AList.Strings[x], FLoadingSeparator, XString, YString);
        if XString = '' then Continue;
        if UpperCase(YString) = UpperCase('Null') then
          begin
            AddXYInternal(StrToFloat(XString), 0, True, False);
          end
        else
          AddXYInternal(StrToFloat(XString), StrToFloat(YString), False, False);
      end;
  finally
    AList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.LogActivate(Append: Boolean);
var
  FileStream : TFileStream;
begin
  if Trim(FLogFileName) = '' then raise Exception.Create('Log File Name not Defined');
  if FLoggingActive          then raise Exception.Create('Logging Already Active');

  if Append then
    FileStream := TFileStream.Create(FLogFileName, fmOpenReadWrite)
  else
    begin
      FileStream := TFileStream.Create(FLogFileName, fmCreate);
      FileStream.Size := 0;
    end;

  FileStream.Free;

  FLoggingActive  := True;
  FLogBufferCount := 0;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.LogDeactivate;
begin
  if not FLoggingActive then raise Exception.Create('Logging not Active');

  FLoggingActive := False;
  if FLogBufferCount > 0 then WriteLog;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.WriteLog;
var
  x          : Integer;
  FileStream : TFileStream;
  OutString  : ShortString;
begin
  FileStream := TFileStream.Create(FLogFileName, fmOpenReadWrite);
  try
    FileStream.Position := FileStream.Size;
    for x := Count-FLogBufferCount to Count-1 do
      begin
        OutString := FloatToStr(DataX[x]) + TiPlotComponentAccess(Owner).GetSavingSeparator + FloatToStr(DataY[x]) + #13+#10;
        FileStream.Write(OutString[1],Length(OutString));
      end;
    FLogBufferCount := 0;
  finally
    FileStream.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.ReCalcRunningMinMaxMean;
var
  Index : Integer;
  X     : Double;
  Y     : Double;
begin
  FRunningCount := 0;

  FRunningXMax  := -1E+300;
  FRunningXMin  :=  1E+300;
  FRunningXMean :=      0;

  FRunningYMax  := -1E+300;
  FRunningYMin  :=  1E+300;
  FRunningYMean :=      0;

  FRunningXTotal := 0;
  FRunningYTotal := 0;

  for Index := 0 to Count-1 do
    begin
      if DataNull [Index] then Continue;
      if DataEmpty[Index] then Continue;

      Inc(FRunningCount);

      X := DataX[Index];
      Y := DataY[Index];

      if X > FRunningXMax then FRunningXMax := X;
      if X < FRunningXMin then FRunningXMin := X;

      if Y > FRunningYMax then FRunningYMax := Y;
      if Y < FRunningYMin then FRunningYMin := Y;

      FRunningXTotal := FRunningXTotal + X;
      FRunningYTotal := FRunningYTotal + Y;
    end;

  if FRunningCount <> 0 then
    begin
      FRunningXMean := FRunningXTotal / FRunningCount;
      FRunningYMean := FRunningYTotal / FRunningCount;
    end
  else
    begin
      FRunningXMean := 0;
      FRunningYMean := 0;
    end
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetXMax: Double;
var
  Index : Integer;
  Data  : Double;
begin
  Result := -1E+300;
  for Index := 0 to Count-1 do
    begin
      if DataNull [Index] then Continue;
      if DataEmpty[Index] then Continue;

      Data := DataX[Index];
      if Data > Result then Result := Data;
    end;
  FRunningXMax := Result;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetXMin: Double;
var
  Index : Integer;
  Data  : Double;
begin
  Result := 1E+300;
  for Index := 0 to Count-1 do
    begin
      if DataNull [Index] then Continue;
      if DataEmpty[Index] then Continue;

      Data := DataX[Index];
      if Data < Result then Result := Data;
    end;
  FRunningXMin := Result;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetXMean: Double;
var
  Index : Integer;
begin
  FRunningXTotal := 0;
  FRunningCount  := 0;
  for Index := 0 to Count-1 do
    begin
      if DataNull [Index] then Continue;
      if DataEmpty[Index] then Continue;

      FRunningXTotal := FRunningXTotal + DataX[Index];
      Inc(FRunningCount)
    end;

  if FRunningCount <> 0 then Result := FRunningXTotal/FRunningCount else Result := 0;
  FRunningXMean := Result;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetYMax: Double;
var
  Index : Integer;
  Data  : Double;
begin
  Result := -1E+300;
  for Index := 0 to Count-1 do
    begin
      if DataNull [Index] then Continue;
      if DataEmpty[Index] then Continue;

      Data := DataY[Index];
      if Data > Result then Result := Data;
    end;
  FRunningYMax := Result;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetYMin: Double;
var
  Index : Integer;
  Data  : Double;
begin
  Result := 1E+300;
  for Index := 0 to Count-1 do
    begin
      if DataNull [Index] then Continue;
      if DataEmpty[Index] then Continue;

      Data := DataY[Index];
      if Data < Result then Result := Data;
    end;
  FRunningYMin := Result;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetYMean: Double;
var
  Index  : Integer;
begin
  FRunningYTotal := 0;
  FRunningCount  := 0;
  for Index := 0 to Count-1 do
    begin
      if DataNull [Index] then Continue;
      if DataEmpty[Index] then Continue;

      FRunningYTotal := FRunningYTotal + DataY[Index];
      Inc(FRunningCount)
    end;
  if FRunningCount <> 0 then Result := FRunningYTotal/FRunningCount else Result := 0;
  FRunningYMean := Result;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetXValueText(Value: Double): String;
begin
  if Assigned(XAxis) then Result := XAxis.GetCursorText(Value) else Result := GetTranslation('No X-Axis');
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetYValueText(Value: Double): String;
begin
  if Assigned(YAxis) then Result := YAxis.GetCursorText(Value) else Result := GetTranslation('No Y-Axis');
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.AddMenuItems(PopupMenu: TPopUpMenu);
begin
  inherited AddMenuItems(PopupMenu);
  AddEditMenuItems(PopupMenu);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetXValueFromMousePoint(X, Y: Integer): Double;
begin
  if XYAxesReversed then
    Result := XAxis.PixelsToPosition(Y)
  else
    Result := XAxis.PixelsToPosition(X);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                                                                    then Exit;
  if not (Sender as TiPlotObject).UserSelected                                        then Exit;
  if Sender is TiPlotDataCursor then if TiPlotDataCursorAccess(Sender).Channel = Self then Exit;
  if Sender is TiPlotLegend                                                           then Exit;

  SetUserSelected(False);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetPixelRect(X1, Y1, X2, Y2: Double): TRect;
var
  X1Pixels, X2Pixels, Y1Pixels, Y2Pixels : Integer;
begin
  X1Pixels := XAxis.PositionToPixels(X1);
  X2Pixels := XAxis.PositionToPixels(X2);

  Y1Pixels := YAxis.PositionToPixels(Y1);
  Y2Pixels := YAxis.PositionToPixels(Y2);

  if X1Pixels > X2Pixels then SwapIntegers(X1Pixels, X2Pixels);
  if Y1Pixels > Y2Pixels then SwapIntegers(Y1Pixels, Y2Pixels);

  if XYAxesReversed then Result := iRect(Y1Pixels, X1Pixels, Y2Pixels, X2Pixels)
  else                   Result := iRect(X1Pixels, Y1Pixels, X2Pixels, Y2Pixels);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.iMouseHitTest(MouseData: TiPlotMouseData): Boolean;
var
  i        : Integer;
  AIsBar   : Boolean;
  AChannel : TiPlotChannel;
begin
  Result := inherited iMouseHitTest(MouseData);

  if FVisibleInLegend then
    begin
      Result := PtInRect(LegendRect, Point(MouseData.X, MouseData.Y));
      if Result then Exit;
    end;

  if not TiPlotComponentAccess(Owner).SelectModeActive then Exit;

  FSelectDataIndex := -1;

  if (self is TiPlotChannel) then AChannel := self as TiPlotChannel else AChannel := nil;

  if AChannel <> nil then AIsBar := AChannel.BarEnabled
  else                    AIsBar := False;

  if (MarkersVisible or AIsBar) and (Count <> 0) then
    begin
      CalcStartXIndex;
      CalcStopXIndex;
      for i := FStartIndex to FStopIndex do
        begin
          if not AIsBar and not DataMarkerShowing[i] then Continue;
          if DataNull[i]                             then Continue;
          if DataEmpty[i]                            then Continue;

          if AIsBar then  FSelectHitTestRect := TiPlotChannelAccess(AChannel).GetBarRect(i)
          else            FSelectHitTestRect := GetMarkerRect(i);

          if PtInRect(FSelectHitTestRect, Point(MouseData.X, MouseData.Y)) then
            begin
              Result := True;
              FSelectDataIndex := i;
              Exit;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DoMouseHint(MouseData: TiPlotMouseData; var HintData: TiHintData);
var
  AHintWidth    : Integer;
  AHintHeight   : Integer;
  ADataViewRect : TRect;
  AHintOffsetX  : Integer;
  AHintOffsetY  : Integer;
begin
  TiPlotComponentAccess(Owner as TiPlotComponent).DoDataPointMouseMove(Self, FSelectDataIndex, MouseData); //Special for Data-Point Mouse Move

  if FShowDataPointHints and (FSelectDataIndex <> - 1) and PtInRect(FSelectHitTestRect, Point(MouseData.X,MouseData.Y)) then
    begin
      HintData.Text := XAxis.GetLabelText(DataX[FSelectDataIndex]) + ', ' + YAxis.GetLabelText(DataY[FSelectDataIndex]);

     TiPlotComponentAccess(Owner as TiPlotComponent).DoDataPointCustomizeHint(Self, FSelectDataIndex, HintData.Text);

      TiPlotComponentAccess(Owner).Canvas.Font := TiPlotComponentAccess(Owner).HintsFont;
      AHintWidth  := TiPlotComponentAccess(Owner).Canvas.TextWidth (HintData.Text) + 4;
      AHintHeight := TiPlotComponentAccess(Owner).Canvas.TextHeight(HintData.Text) + 4;

      ADataViewRect :=  TiPlotComponentAccess(Owner).DataView[0].DrawRect;

      AHintOffsetX  := AHintWidth div 2;
      AHintOffsetY  := AHintHeight + MarkersSize div 2 + 4;

      HintData.Top  := MouseData.Y - AHintOffsetY;
      HintData.Left := MouseData.X - AHintOffsetX;

      if HintData.Top <= ADataViewRect.Top then HintData.Top  := MouseData.Y + AHintOffsetY;

      if HintData.Left <= ADataViewRect.Left then
        begin
          HintData.Left := MouseData.X + MarkersSize div 2 + 8;
          HintData.Top  := MouseData.Y - AHintHeight div 2;

        end
      else if (HintData.Left + AHintWidth) >= ADataViewRect.Right then
        begin
          HintData.Left := MouseData.X - MarkersSize div 2 - 4 - AHintWidth;
          HintData.Top  := MouseData.Y - AHintHeight div 2;

        end;

      if HintData.Top + AHintHeight >= ADataViewRect.Bottom then HintData.Top := ADataViewRect.Bottom - AHintHeight;
      if HintData.Top               <= ADataViewRect.Top    then HintData.Top := ADataViewRect.Top;
    end;

end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DoMouseLeft(MouseData: TiPlotMouseData);
begin
  TiPlotComponentAccess(Owner as TiPlotComponent).DoDataPointMouseDown(Self, FSelectDataIndex, MouseData);

  FMouseDownDataIndex := FSelectDataIndex;

  if (FSelectDataIndex <> - 1) and PtInRect(FSelectHitTestRect, Point(MouseData.X,MouseData.Y)) then
    begin
      FSelectMouseDown      := True;
      FSelectMouseDownIndex := FSelectDataIndex;
      FSelectDownRect       := FSelectHitTestRect;

      FMouseDownValueX      := DataX[FSelectDataIndex];
      FMouseDownValueY      := DataY[FSelectDataIndex];
      FMouseDownPixelX      := MouseData.XAxisPixels;
      FMouseDownPixelY      := MouseData.YAxisPixels;
    end
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DoMouseMove(MouseData: TiPlotMouseData);
var
  DeltaValueX : Double;
  DeltaValueY : Double;
begin
  if FSelectMouseDown then TiPlotComponentAccess(Owner as TiPlotComponent).DoDataPointMouseMove(Self, FMouseDownDataIndex, MouseData); //Special for Data-Point Mouse Move

  if (not FSelectMouseDown) or (not FUserCanMoveDataPoints) then Exit;

  DeltaValueX := 0;
  DeltaValueY := 0;
  
  if UserCanMoveDataPointsStyle in [ipcdpmsXandY, ipcdpmsXOnly] then DeltaValueX := XAxis.PixelsToPosition(FMouseDownPixelX) - XAxis.PixelsToPosition(MouseData.XAxisPixels);
  if UserCanMoveDataPointsStyle in [ipcdpmsXandY, ipcdpmsYOnly] then DeltaValueY := YAxis.PixelsToPosition(FMouseDownPixelY) - YAxis.PixelsToPosition(MouseData.YAxisPixels);

  DataX[FSelectMouseDownIndex] := FMouseDownValueX - DeltaValueX;
  DataY[FSelectMouseDownIndex] := FMouseDownValueY - DeltaValueY;
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DoMouseUp(MouseData: TiPlotMouseData);
var
  ACurrentX : Double;
  ACurrentY : Double;
begin
  TiPlotComponentAccess(Owner as TiPlotComponent).DoDataPointMouseUp(Self, FMouseDownDataIndex, MouseData);

  if not MouseDown and not FSelectMouseDown then Exit;

  if FSelectMouseDown then
    begin
      FSelectMouseDown := False;
      if PtInRect(FSelectDownRect, Point(MouseData.X,MouseData.Y)) then
        begin
          TiPlotComponentAccess(Owner).DoDataPointClick(Self, FSelectMouseDownIndex);
        end;

      ACurrentX := DataX[FSelectMouseDownIndex];
      ACurrentY := DataY[FSelectMouseDownIndex];

      if (ACurrentX <> FMouseDownValueX) or (ACurrentY <> FMouseDownValueY) then
        begin
          TiPlotComponentAccess(Owner).DoDataPointMoved(Self, FSelectMouseDownIndex, FMouseDownValueX, FMouseDownValueY, ACurrentX, ACurrentY);
        end;

    end
  else if MouseDown then
    begin
      if PtInRect(FLegendRect, Point(MouseData.X, MouseData.Y)) then TiPlotComponentAccess(Owner).DoObjectClick(Self);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetMousePointer(APoint: TPoint): TCursor;
begin
  Result := crHandPoint;

  TiPlotComponentAccess(Owner).DoGetMouseCursor(Self, Result);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.DeletePoints(Size: Integer);
begin
  if Size = Count then
    begin
      Clear;
      Exit;
    end;

  DataList.DeletePoints(Size);
  TriggerChange(Self);
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataPointSize: Integer;begin Result := DataList.DataPointSize;end;
function TiPlotChannelCustom.GetMaxDataPoints: Integer;begin Result := DataList.MaxDataPoints;end;
function TiPlotChannelCustom.GetCapacity     : Integer;begin Result := DataList.Capacity;     end;
function TiPlotChannelCustom.GetMemoryUsed   : Integer;begin Result := DataList.MemoryUsed;   end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetDataStyle(const Value: TiPlotDataStyle);
var
  OldTraceLineColor  : TColor;
  OldTraceLineWidth  : Integer;
  OldTraceLineStyle  : TiPlotLineStyle;

  OldMarkerVisible   : Boolean;
  OldMarkerSize      : Integer;
  OldMarkerStyle     : TiPlotMarkerStyle;
  OldMarkerPenColor  : TColor;
  OldMarkerPenStyle  : TPenStyle;
  OldMarkerPenWidth  : Integer;
  OldMarkerBrushColor: TColor;
  OldMarkerBrushStyle: TBrushStyle;

  OldBarVisible      : Boolean;
  OldBarWidth        : Double;
  OldBarReference    : Double;
  OldBarPenColor     : TColor;
  OldBarPenStyle     : TPenStyle;
  OldBarPenWidth     : Integer;
  OldBarBrushColor   : TColor;
  OldBarBrushStyle   : TBrushStyle;
  OldRingBufferSize  : Integer;
begin
  if FDataStyle <> Value then
    begin
      FDataStyle := Value;

      OldTraceLineColor   := FDataList.StoredTraceLineColor;
      OldTraceLineWidth   := FDataList.StoredTraceLineWidth;
      OldTraceLineStyle   := FDataList.StoredTraceLineStyle;

      OldMarkerVisible    := FDataList.StoredMarkerVisible;
      OldMarkerSize       := FDataList.StoredMarkerSize;
      OldMarkerStyle      := FDataList.StoredMarkerStyle;
      OldMarkerPenColor   := FDataList.StoredMarkerPenColor;
      OldMarkerPenStyle   := FDataList.StoredMarkerPenStyle;
      OldMarkerPenWidth   := FDataList.StoredMarkerPenWidth;
      OldMarkerBrushColor := FDataList.StoredMarkerBrushColor;
      OldMarkerBrushStyle := FDataList.StoredMarkerBrushStyle;

      OldBarVisible       := FDataList.StoredBarVisible;
      OldBarWidth         := FDataList.StoredBarWidth;
      OldBarReference     := FDataList.StoredBarReference;
      OldBarPenColor      := FDataList.StoredBarPenColor;
      OldBarPenStyle      := FDataList.StoredBarPenStyle;
      OldBarPenWidth      := FDataList.StoredBarPenWidth;
      OldBarBrushColor    := FDataList.StoredBarBrushColor;
      OldBarBrushStyle    := FDataList.StoredBarBrushStyle;

      OldRingBufferSize   := FDataList.RingBufferSize;

      FDataList.Free;

      case FDataStyle of
        ipdsStandard        : FDataList := TiPlotDataNullList.Create;
        ipdsCompact         : FDataList := TiPlotDataCompactList.Create;
        ipdsCompactInterval : FDataList := TiPlotDataCompactIntervalList.Create;
        ipdsFullFeature     : FDataList := TiPlotDataFullList.Create;
      end;

      FDataList.StoredTraceLineColor   := OldTraceLineColor;
      FDataList.StoredTraceLineWidth   := OldTraceLineWidth;
      FDataList.StoredTraceLineStyle   := OldTraceLineStyle;

      FDataList.StoredMarkerVisible    := OldMarkerVisible;
      FDataList.StoredMarkerSize       := OldMarkerSize;
      FDataList.StoredMarkerStyle      := OldMarkerStyle;
      FDataList.StoredMarkerPenColor   := OldMarkerPenColor;
      FDataList.StoredMarkerPenStyle   := OldMarkerPenStyle;
      FDataList.StoredMarkerPenWidth   := OldMarkerPenWidth;
      FDataList.StoredMarkerBrushColor := OldMarkerBrushColor;
      FDataList.StoredMarkerBrushStyle := OldMarkerBrushStyle;

      FDataList.StoredBarVisible       := OldBarVisible;
      FDataList.StoredBarWidth         := OldBarWidth;
      FDataList.StoredBarReference     := OldBarReference;
      FDataList.StoredBarPenColor      := OldBarPenColor;
      FDataList.StoredBarPenStyle      := OldBarPenStyle;
      FDataList.StoredBarPenWidth      := OldBarPenWidth;
      FDataList.StoredBarBrushColor    := OldBarBrushColor;
      FDataList.StoredBarBrushStyle    := OldBarBrushStyle;

      FDataList.RingBufferSize         := OldRingBufferSize;

      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataX    (const Index: Integer): Double; begin Result := DataList.X[Index];    end;
function TiPlotChannelCustom.GetDataY    (const Index: Integer): Double; begin Result := DataList.Y[Index];    end;
function TiPlotChannelCustom.GetDataNull (const Index: Integer): Boolean;begin Result := DataList.Null[Index]; end;
function TiPlotChannelCustom.GetDataEmpty(const Index: Integer): Boolean;begin Result := DataList.Empty[Index];end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataValid(const Index: Integer): Boolean;
begin
  Result := (not DataEmpty[Index]) and (not DataNull[Index]);
end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetDataX               (const Index:Integer;const Value:Double           );begin DataList.X[Index]               := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataY               (const Index:Integer;const Value:Double           );begin DataList.Y[Index]               := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataNull            (const Index:Integer;const Value:Boolean          );begin DataList.Null[Index]            := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataEmpty           (const Index:Integer;const Value:Boolean          );begin DataList.Empty[Index]           := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerShow      (const Index:Integer;const Value:Boolean          );begin DataList.MarkerVisible[Index]   := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerStyle     (const Index:Integer;const Value:TiPlotMarkerStyle);begin DataList.MarkerStyle[Index]     := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerBrushColor(const Index:Integer;const Value:TColor           );begin DataList.MarkerBrushColor[Index]:= Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerBrushStyle(const Index:Integer;const Value:TBrushStyle      );begin DataList.MarkerBrushStyle[Index]:= Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerPenColor  (const Index:Integer;const Value:TColor           );begin DataList.MarkerPenColor[Index]  := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerPenStyle  (const Index:Integer;const Value:TPenStyle        );begin DataList.MarkerPenStyle[Index]  := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerPenWidth  (const Index:Integer;const Value:Integer          );begin DataList.MarkerPenWidth[Index]  := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerSize      (const Index:Integer;const Value:Integer          );begin DataList.MarkerSize[Index]      := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataMarkerCharacter (const Index:Integer;const Value: Char            );begin DataList.MarkerCharacter[Index] := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataTraceLineColor  (const Index:Integer;const Value:TColor           );begin DataList.TraceLineColor[Index]  := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataTraceLineStyle  (const Index:Integer;const Value:TiPlotLineStyle  );begin DataList.TraceLineStyle[Index]  := Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetDataTraceLineWidth  (const Index:Integer;const Value:Integer          );begin DataList.TraceLineWidth[Index]  := Value;TriggerChange(Self);end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetDataMarkerShow      (const Index:Integer):Boolean;          begin Result := DataList.MarkerVisible[Index];   end;
function TiPlotChannelCustom.GetDataMarkerStyle     (const Index:Integer):TiPlotMarkerStyle;begin Result := DataList.MarkerStyle[Index];     end;
function TiPlotChannelCustom.GetDataMarkerBrushColor(const Index:Integer):TColor;           begin Result := DataList.MarkerBrushColor[Index];end;
function TiPlotChannelCustom.GetDataMarkerBrushStyle(const Index:Integer):TBrushStyle;      begin Result := DataList.MarkerBrushStyle[Index];end;
function TiPlotChannelCustom.GetDataMarkerPenColor  (const Index:Integer):TColor;           begin Result := DataList.MarkerPenColor[Index];  end;
function TiPlotChannelCustom.GetDataMarkerPenStyle  (const Index:Integer):TPenStyle;        begin Result := DataList.MarkerPenStyle[Index];  end;
function TiPlotChannelCustom.GetDataMarkerPenWidth  (const Index:Integer):Integer;          begin Result := DataList.MarkerPenWidth[Index];  end;
function TiPlotChannelCustom.GetDataMarkerSize      (const Index:Integer):Integer;          begin Result := DataList.MarkerSize[Index];      end;
function TiPlotChannelCustom.GetDataMarkerCharacter (const Index:Integer):Char;             begin Result := DataList.MarkerCharacter[Index]; end;
function TiPlotChannelCustom.GetDataTraceLineColor  (const Index:Integer):TColor;           begin Result := DataList.TraceLineColor[Index];  end;
function TiPlotChannelCustom.GetDataTraceLineStyle  (const Index:Integer):TiPlotLineStyle;  begin Result := DataList.TraceLineStyle[Index];  end;
function TiPlotChannelCustom.GetDataTraceLineWidth  (const Index:Integer):Integer;          begin Result := DataList.TraceLineWidth[Index];  end;
//****************************************************************************************************************************************************
procedure TiPlotChannelCustom.SetColor            (const Value:TColor);           begin DataList.StoredTraceLineColor  :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetTraceLineWidth   (const Value:Integer);          begin DataList.StoredTraceLineWidth  :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetTraceLineStyle   (const Value:TiPlotLineStyle);  begin DataList.StoredTraceLineStyle  :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetMarkersVisible   (const Value:Boolean);          begin DataList.StoredMarkerVisible   :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetMarkersSize      (const Value:Integer);          begin DataList.StoredMarkerSize      :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetMarkersStyle     (const Value:TiPlotMarkerStyle);begin DataList.StoredMarkerStyle     :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetMarkersPenColor  (const Value:TColor);           begin DataList.StoredMarkerPenColor  :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetMarkersBrushColor(const Value:TColor);           begin DataList.StoredMarkerBrushColor:=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetMarkersPenWidth  (const Value:Integer);          begin DataList.StoredMarkerPenWidth  :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetMarkersPenStyle  (const Value:TPenStyle);        begin DataList.StoredMarkerPenStyle  :=Value;TriggerChange(Self);end;
procedure TiPlotChannelCustom.SetMarkersBrushStyle(const Value:TBrushStyle);      begin DataList.StoredMarkerBrushStyle:=Value;TriggerChange(Self);end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetColor            :TColor;           begin Result:=DataList.StoredTraceLineColor;  end;
function TiPlotChannelCustom.GetTraceLineWidth   :Integer;          begin Result:=DataList.StoredTraceLineWidth;  end;
function TiPlotChannelCustom.GetTraceLineStyle   :TiPlotLineStyle;  begin Result:=DataList.StoredTraceLineStyle;  end;
function TiPlotChannelCustom.GetMarkersVisible   :Boolean;          begin Result:=DataList.StoredMarkerVisible;   end;
function TiPlotChannelCustom.GetMarkersSize      :Integer;          begin Result:=DataList.StoredMarkerSize;      end;
function TiPlotChannelCustom.GetMarkersStyle     :TiPlotMarkerStyle;begin Result:=DataList.StoredMarkerStyle;     end;
function TiPlotChannelCustom.GetMarkersPenColor  :TColor;           begin Result:=DataList.StoredMarkerPenColor;  end;
function TiPlotChannelCustom.GetMarkersPenStyle  :TPenStyle;        begin Result:=DataList.StoredMarkerPenStyle;  end;
function TiPlotChannelCustom.GetMarkersPenWidth  :Integer;          begin Result:=DataList.StoredMarkerPenWidth;  end;
function TiPlotChannelCustom.GetMarkersBrushColor:TColor;           begin Result:=DataList.StoredMarkerBrushColor;end;
function TiPlotChannelCustom.GetMarkersBrushStyle:TBrushStyle;      begin Result:=DataList.StoredMarkerBrushStyle;end;
//****************************************************************************************************************************************************
function TiPlotChannelCustom.GetIndexFirst: Integer;begin if Count = 0 then Result := -1 else Result := 0;             end;
function TiPlotChannelCustom.GetIndexLast : Integer;begin if Count = 0 then Result := -1 else Result := Count-1;       end;
function TiPlotChannelCustom.GetXFirst    : Double; begin if Count = 0 then Result := -1 else Result := DataX[0];      end;
function TiPlotChannelCustom.GetXLast     : Double; begin if Count = 0 then Result := -1 else Result := DataX[Count-1];end;
function TiPlotChannelCustom.GetYFirst    : Double; begin if Count = 0 then Result := -1 else Result := DataY[0];      end;
function TiPlotChannelCustom.GetYLast     : Double; begin if Count = 0 then Result := -1 else Result := DataY[Count-1];end;
//****************************************************************************************************************************************************
end.
