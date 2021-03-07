{*******************************************************}
{                                                       }
{       TiPlotComponent                                 }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotComponent;{$endif}
{$ifdef iCLX}unit QiPlotComponent;{$endif}

interface

uses
  {$I iIncludeUses.inc}                                 
  {$IFDEF iVCL} Menus,  Printers,  iTypes,  iGPFunctions,  iMath, iCustomComponent,  iEditorBasicComponents,  ImgList, CommCtrl, JPeg,{$ENDIF}
  {$IFDEF iCLX}QMenus, QPrinters, QiTypes, QiGPFunctions, QiMath, QiCustomComponent, QiEditorBasicComponents, QImgList,                {$ENDIF}

  {$IFDEF iVCL} iPlotMasterManager,  iPlotManagers,  iPlotLayoutManager,  iPlotObjects,{$ENDIF}
  {$IFDEF iCLX}QiPlotMasterManager, QiPlotManagers, QiPlotLayoutManager, QiPlotObjects,{$ENDIF}

  {$IFDEF iVCL} iPlotChannelCustom,  iPlotChannel,  iXYPlotChannel,  iPlotTranslation,  iPlotAnnotation, iPlotPreview, {$ENDIF}
  {$IFDEF iCLX}QiPlotChannelCustom, QiPlotChannel, QiXYPlotChannel, QiPlotTranslation, QiPlotAnnotation, QiPlotPreview,{$ENDIF}

  {$IFDEF iVCL} iPlotDataCursor,  iPlotAxis,  iPlotLegend,  iPlotToolBar,  iPlotLimit,  iPlotLabel,  iPlotDataView,  iPlotTable;{$ENDIF}
  {$IFDEF iCLX}QiPlotDataCursor, QiPlotAxis, QiPlotLegend, QiPlotToolBar, QiPlotLimit, QiPlotLabel, QiPlotDataView, QiPlotTable;{$ENDIF}

type
  TiPlotFormStyle                    = (ipfsModal, ipfsStayOnTop);
  TiPlotDataFileColumnSeparator      = (ipdfcsTab, ipdfcsComma);
  TiPlotDataFileFormat               = (ipdffText, ipdffCompactInterval);

  TiPlotAxesMinSpanChangeEvent       = procedure(Index: Integer; OldMin, OldSpan, NewMin, NewSpan : Double)                                 of object;
  TiPlotObjectDoubleValueChangeEvent = procedure(Index: Integer; OldValue, NewValue : Double)                                               of object;
  TiPlotAxesCustomizeLabelEvent      = procedure(Index: Integer; Value: Double; var ALabel: String)                                         of object;
  TiPlotObjectMouseEvent             = procedure(Index: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer)                   of object;
  TiPlotObjectMouseWheelEvent        = procedure(Index: Integer; WheelDelta: Integer;  Shift: TShiftState; X, Y: Integer)                   of object;
  TiPlotObjectMouseMoveEvent         = procedure(Index: Integer;                       Shift: TShiftState; X, Y: Integer)                   of object;
  TiPlotObjectEvent                  = procedure(Index: Integer)                                                                            of object;
  TiPlotObjectGetMouseCursorEvent    = procedure(Index: Integer; var MouseCursor: TCursor)                                                  of object;
  TiPlotPopupMenuEvent               = procedure(Index: Integer; var Cancel: Boolean; ScreenX, ScreenY: Integer)                            of object;
  TiPlotPrintPageEvent               = procedure(PageIndex: Integer; LastPage: Boolean)                                                     of object;
  TiPlotClickDataPointEvent          = procedure(ChannelIndex, DataIndex: Integer)                                                          of object;
  TiPlotDataPointMouseEvent          = procedure(ChannelIndex, DataIndex: Integer; Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;
  TiPlotDataPointMouseMoveEvent      = procedure(ChannelIndex, DataIndex: Integer;                       Shift: TShiftState; X, Y: Integer) of object;
  TiPlotDataPointMovedEvent          = procedure(ChannelIndex, DataIndex: Integer; OldX, OldY, NewX, NewY: Double)                          of object;
  TiPlotZoomBoxEvent                 = procedure(var ZoomRect: TRect; var Cancel: Boolean)                                                  of object;
  TiPlotObjectCustomizeTextEvent     = procedure(Index: Integer; var AText: String)                                                         of object;
  TiPlotDataPointCustomizeTextEvent  = procedure(ChannelIndex, DataPointIndex: Integer; var AText: String)                                  of object;
  TiPlotToolBarButtonEvent           = procedure(Index: Integer; ButtonType: TiPlotToolBarButtonType)                                       of object;
  TiPlotToolBarButtonBeforeEvent     = procedure(Index: Integer; ButtonType: TiPlotToolBarButtonType; var Cancel: Boolean)                  of object;

  TiPlotComponent = class(TiCustomComponent)
  private
    FMaster                                : TiPlotMasterManager;
    FLayerList                             : TStringList;
    FHintData                              : TiHintData;
    FLastHintX                             : Integer;
    FLastHintY                             : Integer;
    FLastHintShowRect                      : TRect;
    FLastHintObject                        : TObject;
    FHintShowing                           : Boolean;
    FHintsFont                             : TFont;

    FAxesCollisionList                     : TStringList;

    FStringCurrentPos                      : PChar;
    FStringScanPos                         : PChar;

    FShiftState                            : TShiftState;

    FPopupMenu                             : TPopupMenu;

    FImageList0                            : TImageList;
    FImageList1                            : TImageList;
    FImageList2                            : TImageList;

    FSaveDialog                            : TiComponentEditorSavePicker;

    FMasterAxisBlock                       : Boolean;

    FUserCanAddRemoveChannels              : Boolean;

    FPrintShowDialog                       : Boolean;
    FPrintOrientation                      : TPrinterOrientation;
    FPrintMarginTop                        : Double;
    FPrintMarginLeft                       : Double;
    FPrintMarginRight                      : Double;
    FPrintMarginBottom                     : Double;
    FPrintDocumentName                     : String;
    FPrinterName                           : String;
    FPrinterPaperWidthInches               : Double;
    FPrinterPaperHeightInches              : Double;
    FPrinterPaperWidthCentimeters          : Double;
    FPrinterPaperHeightCentimeters         : Double;
    FPrinterPaperWidthPixels               : Integer;
    FPrinterPaperHeightPixels              : Integer;

    FPrintXStart                           : Double;
    FPrintXStop                            : Double;

    FMouseDown                             : Boolean;
    FMouseDownObject                       : TiPlotObject;
    FLastMouseOverObject                   : TiPlotObject;
    FLastMouseClickObject                  : TiPlotObject;
    FLastMouseClickButton                  : TMouseButton;
    FLastMouseClickShift                   : TShiftState;
    FLastMouseClickX                       : Integer;
    FLastMouseClickY                       : Integer;
    FLastMouseClickScreenX                 : Integer;
    FLastMouseClickScreenY                 : Integer;

    FVisibleListLeft                       : TStringList;
    FVisibleListRight                      : TStringList;
    FVisibleListTop                        : TStringList;
    FVisibleListBottom                     : TStringList;

    {$ifdef iVCL}FMetaFile            : TMetafile;{$endif}
    {$ifdef iVCL}FCaptureWindowHandle : HWnd;    {$endif}
    {$ifdef iVCL}FSnapShotPicture     : TPicture; {$endif}

    FOuterMarginTop                        : Integer;
    FOuterMarginLeft                       : Integer;
    FOuterMarginRight                      : Integer;
    FOuterMarginBottom                     : Integer;

    FSelectingActive                       : Boolean;
    FJustReleasedCapture                   : Boolean;

    FEditorFormStyle                       : TiPlotFormStyle;
    FCopyToClipBoardFormat                 : TiPlotExportFormat;
    FClipAnnotationsToAxes                 : Boolean;

    FHintsShow                             : Boolean;
    FHintsPause                            : Integer;
    FHintsHidePause                        : Integer;

    FLoggingActive                         : Boolean;
    FLogBufferSize                         : Integer;
    FLogFileName                           : String;
    FLogBufferCount                        : Integer;

    FAnnotationDefaultPenWidth             : Integer;
    FAnnotationDefaultBrushStlye           : TBrushStyle;
    FAnnotationDefaultBrushColor           : TColor;
    FAnnotationDefaultPenColor             : TColor;
    FAnnotationDefaultFont                 : TFont;
    FAnnotationDefaultPenStlye             : TPenStyle;

    FAnnotationDefaultReference            : TiPlotReferenceType;
    FAnnotationDefaultReferencePositionX   : TiPlotReferenceIndividual;
    FAnnotationDefaultReferencePositionY   : TiPlotReferenceIndividual;
    FAnnotationDefaultReferenceSizeX       : TiPlotReferenceIndividual;
    FAnnotationDefaultReferenceSizeY       : TiPlotReferenceIndividual;


    FOnMouseDownLimit                      : TiPlotObjectMouseEvent;
    FOnMouseDownYAxis                      : TiPlotObjectMouseEvent;
    FOnMouseDownDataCursor                 : TiPlotObjectMouseEvent;
    FOnMouseDownChannel                    : TiPlotObjectMouseEvent;
    FOnMouseDownAnnotation                 : TiPlotObjectMouseEvent;
    FOnMouseDownLegend                     : TiPlotObjectMouseEvent;
    FOnMouseDownXAxis                      : TiPlotObjectMouseEvent;
    FOnMouseDownDataView                   : TiPlotObjectMouseEvent;
    FOnMouseDownDataPoint                  : TiPlotDataPointMouseEvent;

    FOnMouseMoveLimit                      : TiPlotObjectMouseMoveEvent;
    FOnMouseMoveYAxis                      : TiPlotObjectMouseMoveEvent;
    FOnMouseMoveDataCursor                 : TiPlotObjectMouseMoveEvent;
    FOnMouseMoveChannel                    : TiPlotObjectMouseMoveEvent;
    FOnMouseMoveAnnotation                 : TiPlotObjectMouseMoveEvent;
    FOnMouseMoveLegend                     : TiPlotObjectMouseMoveEvent;
    FOnMouseMoveXAxis                      : TiPlotObjectMouseMoveEvent;
    FOnMouseMoveDataView                   : TiPlotObjectMouseMoveEvent;
    FOnMouseMoveDataPoint                  : TiPlotDataPointMouseMoveEvent;

    FOnMouseUpLimit                        : TiPlotObjectMouseEvent;
    FOnMouseUpYAxis                        : TiPlotObjectMouseEvent;
    FOnMouseUpDataCursor                   : TiPlotObjectMouseEvent;
    FOnMouseUpChannel                      : TiPlotObjectMouseEvent;
    FOnMouseUpAnnotation                   : TiPlotObjectMouseEvent;
    FOnMouseUpLegend                       : TiPlotObjectMouseEvent;
    FOnMouseUpXAxis                        : TiPlotObjectMouseEvent;
    FOnMouseUpDataView                     : TiPlotObjectMouseEvent;
    FOnMouseUpDataPoint                    : TiPlotDataPointMouseEvent;

    FOnClickXAxis                          : TiPlotObjectEvent;
    FOnClickYAxis                          : TiPlotObjectEvent;
    FOnClickDataPoint                      : TiPlotClickDataPointEvent;
    FOnDataPointMoved                      : TiPlotDataPointMovedEvent;
    FOnClickAnnotation                     : TiPlotObjectEvent;
    FOnClickDataCursor                     : TiPlotObjectEvent;
    FOnClickLegend                         : TiPlotObjectEvent;
    FOnClickChannel                        : TiPlotObjectEvent;
    FOnClickDataView                       : TiPlotObjectEvent;
    FOnClickLimit                          : TiPlotObjectEvent;

    FOnDblClickAnnotation                  : TiPlotObjectEvent;
    FOnDblClickDataView                    : TiPlotObjectEvent;
    FOnDblClickYAxis                       : TiPlotObjectEvent;
    FOnDblClickXAxis                       : TiPlotObjectEvent;
    FOnDblClickChannel                     : TiPlotObjectEvent;
    FOnDblClickLimit                       : TiPlotObjectEvent;
    FOnDblClickLegend                      : TiPlotObjectEvent;
    FOnDblClickDataCursor                  : TiPlotObjectEvent;

    FOnMouseWheelXAxis                     :  TiPlotObjectMouseWheelEvent;
    FOnMouseWheelYAxis                     :  TiPlotObjectMouseWheelEvent;
    FOnMouseWheelDataView                  :  TiPlotObjectMouseWheelEvent;
    FOnMouseWheelLegend                    :  TiPlotObjectMouseWheelEvent;
    FOnMouseWheelChannel                   :  TiPlotObjectMouseWheelEvent;
    FOnMouseWheelLimit                     :  TiPlotObjectMouseWheelEvent;
    FOnMouseWheelDataCursor                :  TiPlotObjectMouseWheelEvent;
    FOnMouseWheelAnnotation                :  TiPlotObjectMouseWheelEvent;

    FOnDataCursorChange                    : TiPlotObjectEvent;

    FOnXAxisMinChange                      : TiPlotObjectDoubleValueChangeEvent;
    FOnXAxisSpanChange                     : TiPlotObjectDoubleValueChangeEvent;
    FOnXAxisMinSpanChange                  : TiPlotAxesMinSpanChangeEvent;
    FOnXAxisMinSpanChangeFinished          : TiPlotAxesMinSpanChangeEvent;
    FOnXAxisCustomizeLabel                 : TiPlotAxesCustomizeLabelEvent;

    FOnYAxisMinChange                      : TiPlotObjectDoubleValueChangeEvent;
    FOnYAxisSpanChange                     : TiPlotObjectDoubleValueChangeEvent;
    FOnYAxisMinSpanChange                  : TiPlotAxesMinSpanChangeEvent;
    FOnYAxisMinSpanChangeFinished          : TiPlotAxesMinSpanChangeEvent;
    FOnYAxisCustomizeLabel                 : TiPlotAxesCustomizeLabelEvent;

    FOnDataCursorCustomizeHint             : TiPlotObjectCustomizeTextEvent;
    FOnYAxisCustomizeHint                  : TiPlotObjectCustomizeTextEvent;
    FOnXAxisCustomizeHint                  : TiPlotObjectCustomizeTextEvent;
    FOnDataPointCustomizeHint              : TiPlotDataPointCustomizeTextEvent;
    FOnToolBarCustomizeHint                : TiPlotObjectCustomizeTextEvent;
    FOnToolBarButtonClick                  : TiPlotToolBarButtonEvent;
    FOnBeforeToolBarButtonClick            : TiPlotToolBarButtonBeforeEvent;

    FOnLimitLine1PositionChange            : TiPlotObjectDoubleValueChangeEvent;
    FOnLimitLine2PositionChange            : TiPlotObjectDoubleValueChangeEvent;
    FOnBeforePrint                         : TNotifyEvent;
    FOnBeforePrintPage                     : TiPlotPrintPageEvent;
    FOnAfterPrint                          : TNotifyEvent;

    FOnAfterLoadProperties                 : TNotifyEvent;
    FOnBeforeLoadProperties                : TNotifyEvent;
    FOnAfterLoadData                       : TNotifyEvent;
    FOnAfterSaveData                       : TNotifyEvent;
    FOnAfterSaveProperties                 : TNotifyEvent;
    FOnAfterPaint                          : TNotifyEvent;

    FOnAfterCloseEditor                    : TNotifyEvent;
    FOnAfterOpenEditor                     : TNotifyEvent;

    FOnBeforeZoomBox                       : TiPlotZoomBoxEvent;
    FOnBeforeDataCursorUpdate              : TiPlotObjectEvent;

    FOnAnnotationCoordinatesChange         : TiPlotObjectEvent;
    FOnAnnotationMoveUser                  : TiPlotObjectEvent;
    FOnAnnotationResizeUser                : TiPlotObjectEvent;
    FOnAnnotationCoordinatesChangeFinished : TiPlotObjectEvent;

    FOnGotFocusChannel                     : TiPlotObjectEvent;
    FOnGotFocusLegend                      : TiPlotObjectEvent;
    FOnGotFocusDataCursor                  : TiPlotObjectEvent;
    FOnGotFocusDataView                    : TiPlotObjectEvent;
    FOnGotFocusXAxis                       : TiPlotObjectEvent;
    FOnGotFocusYAxis                       : TiPlotObjectEvent;
    FOnGotFocusAnnotation                  : TiPlotObjectEvent;

    FOnLostFocusXAxis                      : TiPlotObjectEvent;
    FOnLostFocusYAxis                      : TiPlotObjectEvent;
    FOnLostFocusChannel                    : TiPlotObjectEvent;
    FOnLostFocusDataCursor                 : TiPlotObjectEvent;
    FOnLostFocusLegend                     : TiPlotObjectEvent;
    FOnLostFocusDataView                   : TiPlotObjectEvent;
    FOnLostFocusAnnotation                 : TiPlotObjectEvent;

    FOnAddChannel                          : TiPlotObjectEvent;
    FOnAddXAxis                            : TiPlotObjectEvent;
    FOnAddYAxis                            : TiPlotObjectEvent;
    FOnAddDataCursor                       : TiPlotObjectEvent;
    FOnAddDataView                         : TiPlotObjectEvent;
    FOnAddLegend                           : TiPlotObjectEvent;
    FOnAddLimit                            : TiPlotObjectEvent;
    FOnAddTable                            : TiPlotObjectEvent;
    FOnAddAnnotation                       : TiPlotObjectEvent;

    FOnRemoveChannel                       : TiPlotObjectEvent;
    FOnRemoveXAxis                         : TiPlotObjectEvent;
    FOnRemoveYAxis                         : TiPlotObjectEvent;
    FOnRemoveDataCursor                    : TiPlotObjectEvent;
    FOnRemoveDataView                      : TiPlotObjectEvent;
    FOnRemoveLegend                        : TiPlotObjectEvent;
    FOnRemoveLimit                         : TiPlotObjectEvent;
    FOnRemoveTable                         : TiPlotObjectEvent;
    FOnRemoveAnnotation                    : TiPlotObjectEvent;

    FOnGetMouseCursorChannel               : TiPlotObjectGetMouseCursorEvent;
    FOnGetMouseCursorXAxis                 : TiPlotObjectGetMouseCursorEvent;
    FOnGetMouseCursorYAxis                 : TiPlotObjectGetMouseCursorEvent;
    FOnGetMouseCursorDataCursor            : TiPlotObjectGetMouseCursorEvent;
    FOnGetMouseCursorDataView              : TiPlotObjectGetMouseCursorEvent;
    FOnGetMouseCursorLegend                : TiPlotObjectGetMouseCursorEvent;
    FOnGetMouseCursorLimit                 : TiPlotObjectGetMouseCursorEvent;
    FOnGetMouseCursorTable                 : TiPlotObjectGetMouseCursorEvent;
    FOnGetMouseCursorAnnotation            : TiPlotObjectGetMouseCursorEvent;

    FOnPopupMenuYAxis                      : TiPlotPopupMenuEvent;
    FOnPopupMenuChannel                    : TiPlotPopupMenuEvent;
    FOnPopupMenuDataCursor                 : TiPlotPopupMenuEvent;
    FOnPopupMenuDataView                   : TiPlotPopupMenuEvent;
    FOnPopupMenuXAxis                      : TiPlotPopupMenuEvent;
    FOnPopupMenuLegend                     : TiPlotPopupMenuEvent;
    FOnPopupMenuLimit                      : TiPlotPopupMenuEvent;
    FOnPopupMenuAnnotation                 : TiPlotPopupMenuEvent;

    FBackGroundGradientEnabled             : Boolean;
    FBackGroundGradientStartColor          : TColor;
    FBackGroundGradientStopColor           : TColor;
    FBackGroundGradientDirection           : TiFillDirection;

    FPaintingActive                        : Boolean;
    FOnDblClickDataPoint                   : TiPlotClickDataPointEvent;
    FDBLClickActive                        : Boolean;
    FLoadingSeparator                      : Char;
    FDataFileColumnSeparator               : TiPlotDataFileColumnSeparator;
    FDataFileFormat                        : TiPlotDataFileFormat;
    FLastPropertiesFileName                : String;
    FLastDataFileName                      : String;

    function GetDataViewZHorz              : Integer;
    function GetDataViewZVert              : Integer;
    function GetXYAxesReverse              : Boolean;
    function GetUserCanEditObjects         : Boolean;

    procedure SetDataViewZHorz               (const Value: Integer);
    procedure SetDataViewZVert               (const Value: Integer);
    procedure SetXYAxesReverse               (const Value: Boolean);
    procedure SetUserCanEditObjects          (const Value: Boolean);
    procedure SetHintsFont                   (const Value: TFont);

    procedure SetOuterMarginBottom           (const Value: Integer);
    procedure SetOuterMarginLeft             (const Value: Integer);
    procedure SetOuterMarginRight            (const Value: Integer);
    procedure SetOuterMarginTop              (const Value: Integer);
    procedure SetHintsHidePause              (const Value: Integer);
    procedure SetHintsPause                  (const Value: Integer);
    procedure SetHintsShow                   (const Value: Boolean);
    procedure SetTitleFont                   (const Value: TFont);
    procedure SetTitleMargin                 (const Value: Double);
    procedure SetTitleVisible                (const Value: Boolean);
    procedure SetTitleText                   (const Value: String);
    procedure SetLogBufferSize               (const Value: Integer);
    procedure SetLogFileName                 (const Value: String);
    procedure SetEditorFormStyle             (const Value: TiPlotFormStyle);
    procedure SetCopyToClipBoardFormat       (const Value: TiPlotExportFormat);
    procedure SetClipAnnotationsToAxes       (const Value: Boolean);
    procedure SetBackGroundGradientDirection (const Value: TiFillDirection);
    procedure SetBackGroundGradientEnabled   (const Value: Boolean);
    procedure SetBackGroundGradientStartColor(const Value: TColor);
    procedure SetBackGroundGradientStopColor (const Value: TColor);
    procedure SetDataFileFormat              (const Value: TiPlotDataFileFormat);
    procedure SetDataFileColumnSeparator     (const Value: TiPlotDataFileColumnSeparator);

    procedure SetAnnotationDefaultFont(const Value: TFont);

    function GetDataView   (Index: Integer): TiPlotDataView;
    function GetXAxis      (Index: Integer): TiPlotXAxis;
    function GetYAxis      (Index: Integer): TiPlotYAxis;
    function GetLegend     (Index: Integer): TiPlotLegend;
    function GetTable      (Index: Integer): TiPlotTable;
    function GetToolBar    (Index: Integer): TiPlotToolBar;
    function GetChannel    (Index: Integer): TiPlotChannelCustom;
    function GetAnnotation (Index: Integer): TiPlotAnnotation;
    function GetLimit      (Index: Integer): TiPlotLimit;
    function GetLabel      (Index: Integer): TiPlotLabel;
    function GetDataCursor (Index: Integer): TiPlotDataCursor;
    function GetTranslation(Index: Integer): TiPlotTranslationObject;

    function  GetZOrderMaxWidth     (Canvas: TCanvas; AList: TStringList; ZOrder : Integer)    : Integer;
    function  GetTotalRequiredWidth (Canvas: TCanvas; AList: TStringList)                      : Integer;
    function  GetAxesTouchesDataView(AList: TStringList; QuadSide: TiQuadSide): Boolean;
    procedure UpdateStacking(AList: TStringList);

    procedure KillHint;
    function GetMaxGaurd(Canvas: TCanvas; AList: TStringList; StartGaurd : Boolean): Integer;

    function  FindMouseObject(MouseData: TiPlotMouseData): TiPlotObject;
    procedure UpdateAxisPixels(var MouseData: TiPlotMouseData);

    function GetTitleFont        : TFont;
    function GetTitleMargin      : Double;
    function GetTitleText        : String;
    function GetTitleVisible     : Boolean;
    function GetSelectModeActive : Boolean;

    procedure SetSelectModeActive(const Value: Boolean);

    function GetChannelManager    : TiPlotChannelManager;
    function GetDataCursorManager : TiPlotDataCursorManager;
    function GetDataViewManager   : TiPlotDataViewManager;
    function GetLabelManager      : TiPlotLabelManager;
    function GetLayoutManager     : TiPlotLayoutManager;
    function GetLegendManager     : TiPlotLegendManager;
    function GetTableManager      : TiPlotTableManager;
    function GetLimitManager      : TiPlotLimitManager;
    function GetPlotObjectManager : TiPlotObjectManager;
    function GetToolBarManager    : TiPlotToolBarManager;
    function GetTranslationManager: TiPlotTranslationManager;
    function GetXAxisManager      : TiPlotXAxisManager;
    function GetYAxisManager      : TiPlotYAxisManager;
  protected
    procedure iWantSpecialKey(var CharCode: Word; var Result: Longint);            override;
    procedure iKeyDown       (var CharCode: Word; Shift: TShiftState);             override;

    procedure iMouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer         );          override;
    procedure iMouseUp   (Button: TMouseButton; Shift: TShiftState; X, Y: Integer         );          override;
    procedure iMouseMove (                      Shift: TShiftState; X, Y: Integer         );          override;
    function  iMouseWheel(WheelDelta: Integer;  Shift: TShiftState; const MousePos: TPoint): Boolean; override;
    procedure iDoubleClick;                                                                           override;

    {$ifdef iVCL}procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;{$endif}

    {$IFDEF NASA_KENNEDY}
    procedure Nasa_KennedyGetRegistryOptions; override;
    {$ENDIF}

    procedure iPaintTo(Canvas: TCanvas); override;

    procedure DrawOutSideObjects(Canvas: TCanvas);

    procedure MasterInsert    (Sender: TObject); virtual;
    procedure MasterRemove    (Sender: TObject); virtual;
    procedure MasterChange    (Sender: TObject); virtual;
    procedure DataCursorChange(Sender: TObject);

    procedure ReadDataViewZHorz (Reader: TReader);
    procedure ReadDataViewZVert (Reader: TReader);
    procedure WriteDataViewZHorz(Writer: TWriter);
    procedure WriteDataViewZVert(Writer: TWriter);

    procedure ReadImageList0 (Stream: TStream);
    procedure ReadImageList1 (Stream: TStream);
    procedure ReadImageList2 (Stream: TStream);
    procedure WriteImageList0(Stream: TStream);
    procedure WriteImageList1(Stream: TStream);
    procedure WriteImageList2(Stream: TStream);

    procedure Loaded;                          override;
    procedure DefineProperties(Filer: TFiler); override;

    procedure AppendColumn(var BuildString: String; ColumnIndex: Integer; ColumnString : String);
    procedure SeperateColumns(LineString: String; const ColumnDataList: TStringList);
    function  GetNextRowString: String;

    procedure UpdateVisibleList(AList, VisibleList: TStringList);

    procedure BeforePropertyEditorLoad; virtual;
    procedure AfterPropertyEditorApply; virtual;

    procedure MasterAxisMouseLeft (Axis: TiPlotAxis; MouseData: TiPlotMouseData);
    procedure MasterAxisMouseMove (Axis: TiPlotAxis; MouseData: TiPlotMouseData);
    procedure MasterAxisMouseUp   (Axis: TiPlotAxis; MouseData: TiPlotMouseData);
    procedure MasterAxisMouseWheel(Axis: TiPlotAxis; WheelDelta: Integer; Shift: TShiftState; AX, AY: Integer);
    procedure MasterAxisKeyDown   (Axis: TiPlotAxis; var CharCode: Word; Shift: TShiftState);

    procedure DoObjectMouseDown   (Sender: TiPlotObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoObjectMouseMove   (Sender: TiPlotObject;                       Shift: TShiftState; X, Y: Integer);
    procedure DoObjectMouseUp     (Sender: TiPlotObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoObjectMouseWheel  (Sender: TiPlotObject; WheelDelta: Integer;  Shift: TShiftState; X, Y: Integer);
    procedure DoObjectClick       (Sender:TiPlotObject);
    procedure DoDataPointClick    (Sender: TiPlotChannelCustom; Index: Integer);
    procedure DoDataPointMoved    (Sender: TiPlotChannelCustom; Index: Integer; OldX, OldY, NewX, NewY: Double);
    procedure DoDataPointMouseDown(Sender: TiPlotChannelCustom; DataIndex: Integer; MouseData: TiPlotMouseData);
    procedure DoDataPointMouseMove(Sender: TiPlotChannelCustom; DataIndex: Integer; MouseData: TiPlotMouseData);
    procedure DoDataPointMouseUp  (Sender: TiPlotChannelCustom; DataIndex: Integer; MouseData: TiPlotMouseData);
    procedure DoGetMouseCursor    (Sender: TiPlotObject; var MouseCursor: TCursor);

    procedure DoAxesSpanChange                     (Sender: TiPlotAxis; OldValue, NewValue: Double);
    procedure DoAxesMinChange                      (Sender: TiPlotAxis; OldValue, NewValue: Double);
    procedure DoAxesMinSpanChange                  (Sender: TiPlotAxis; OldMin, OldSpan, NewMin, NewSpan: Double);
    procedure DoAxesMinSpanChangeFinished          (Sender: TiPlotAxis; OldMin, OldSpan, NewMin, NewSpan: Double);
    procedure DoAxesCustomizeLabel                 (Sender: TiPlotAxis; Value: Double; var ALabel: String);
    procedure DoToolBarButtonClick                 (Sender: TiPlotToolBar; ButtonType: TiPlotToolBarButtonType);
    procedure DoToolBarButtonBeforeClick           (Sender: TiPlotToolBar; ButtonType: TiPlotToolBarButtonType; var Cancel: Boolean);
    procedure DoDataCursorCustomizeHint            (Sender: TiPlotDataCursor;                             var AText: String);
    procedure DoToolBarCustomizeHint               (Sender: TiPlotToolBar;                                var AText: String);
    procedure DoXAxisCustomizeHint                 (Sender: TiPlotXAxis;                                  var AText: String);
    procedure DoYAxisCustomizeHint                 (Sender: TiPlotYAxis;                                  var AText: String);
    procedure DoDataPointCustomizeHint             (Sender: TiPlotChannelCustom; DataPointIndex: Integer; var AText: String);
    procedure DoBeforeDataCursorUpdate             (Sender: TiPlotDataCursor);
    procedure DoLimitLine1PositionChange           (Sender: TiPlotLimit; OldValue, NewValue: Double);
    procedure DoLimitLine2PositionChange           (Sender: TiPlotLimit; OldValue, NewValue: Double);
    procedure DoAnnotationCoordinatesChange        (Sender: TiPlotAnnotation);
    procedure DoAnnotationMoveUser                 (Sender: TiPlotAnnotation);
    procedure DoAnnotationResizeUser               (Sender: TiPlotAnnotation);
    procedure DoAnnotationCoordinatesChangeFinished(Sender: TiPlotAnnotation);

    procedure DoObjectGotFocus (Sender: TiPlotObject);
    procedure DoObjectLostFocus(Sender: TiPlotObject);
    procedure DoPopUpMenuEvent (Sender: TiPlotObject; var Cancel: Boolean; ScreenX, ScreenY: Integer);

    procedure DoPrintChart;
    procedure DoPrintPage(ARect: TRect);

    procedure ClearAxesCollisionList;
    procedure ClearLayerList;
    procedure AddLayerObject(LayerString: String; PlotObject: TiPlotObject);

    procedure AddAxesCollisionItem(ARect: TRect);
    function  AddAxesCollisionDetectionItem(ARect: TRect): Boolean;

    procedure MousePointerSet(ACursor : TCursor);

    procedure CalcLayout(Canvas: TCanvas);

    procedure HintTimer(Sender : TObject);

    property SelectModeActive : Boolean                      read GetSelectModeActive write SetSelectModeActive;

    property Master : TiPlotMasterManager                    read FMaster;

    function GetStreamRowString(Stream: TStream): String;
    function GetStreamSingle   (Stream: TStream): Single;

    function GetSavingSeparator: Char;

    procedure SaveDataToFileText           (FileName: String);
    procedure SaveDataToFileCompactInterval(FileName: String);

    function ValueIsEmpty       (Value: Double): Boolean;
    function ValueIsNull        (Value: Double): Boolean;
    function ValueIsNotDataPoint(Value: Double): Boolean;

    function GetEmptyValue   : Double;
    function GetNullValue    : Double;
    function GetNotDataPoint : Double;

    property ObjectManager        : TiPlotObjectManager      read GetPlotObjectManager;
    property ToolBarManager       : TiPlotToolBarManager     read GetToolBarManager;
    property LegendManager        : TiPlotLegendManager      read GetLegendManager;
    property TableManager         : TiPlotTableManager       read GetTableManager;
    property XAxisManager         : TiPlotXAxisManager       read GetXAxisManager;
    property YAxisManager         : TiPlotYAxisManager       read GetYAxisManager;
    property ChannelManager       : TiPlotChannelManager     read GetChannelManager;
    property DataViewManager      : TiPlotDataViewManager    read GetDataViewManager;
    property DataCursorManager    : TiPlotDataCursorManager  read GetDataCursorManager;
    property LimitManager         : TiPlotLimitManager       read GetLimitManager;
    property LabelManager         : TiPlotLabelManager       read GetLabelManager;
    property TranslationManager   : TiPlotTranslationManager read GetTranslationManager;
    property LayoutManager        : TiPlotLayoutManager      read GetLayoutManager;

    property ImageList0           : TImageList               read FImageList0;
    property ImageList1           : TImageList               read FImageList1;
    property ImageList2           : TImageList               read FImageList2;

    procedure LoadXYData;
    procedure LoadLogData;
    procedure LoadCompactInterval(Stream : TStream);
    procedure WriteLog;

    procedure ImageListLoadFromBitmap(ImageListIndex: Integer; ABitmap: TBitmap);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy;                    override;

    procedure SavePropertiesToFile    (FileName: String); override;
    procedure LoadPropertiesFromFile  (FileName: String); override;

    procedure SaveDataToFile          (FileName: String);
    procedure LoadDataFromFile        (FileName: String);

    procedure SaveAnnotationsToFile   (FileName: String);
    procedure LoadAnnotationsFromFile (FileName: String);

    procedure SaveTranslationsToFile  (FileName: String);
    procedure LoadTranslationsFromFile(FileName: String);

    procedure ImageListClear               (ImageListIndex: Integer);
    procedure ImageListAdd                 (ImageListIndex: Integer; ABitmap: TBitmap);
    procedure ImageListLoadFromResourceID  (ImageListIndex: Integer; Instance: Cardinal; ResID: Integer);
    procedure ImageListLoadFromResourceName(ImageListIndex: Integer; Instance: Cardinal; ResName: String);

    procedure PrintChart;
    procedure PreviewChart;
    procedure PrintSizeToFillPage;
    procedure PrintAdjustXSpanToMinutesPerMillimeter(MinutesPerMillimeter: Double);

    procedure CopyToClipBoard;
    procedure Save;
    function  GetSnapShotPicture: TPicture;

    procedure DisableLayoutManager;
    procedure EnableLayoutManager;
    procedure RefreshLayoutManager;

    procedure DisableAllTracking;
    procedure EnableAllTracking;

    procedure LogActivate(Append: Boolean);
    procedure LogDeactivate;

    procedure ClearAllData;

    procedure ReCalcLayout;

    procedure RemoveAllToolBars;    virtual;
    procedure RemoveAllLegends;     virtual;
    procedure RemoveAllTables;      virtual;
    procedure RemoveAllXAxes;       virtual;
    procedure RemoveAllYAxes;       virtual;
    procedure RemoveAllDataViews;   virtual;
    procedure RemoveAllDataCursors; virtual;
    procedure RemoveAllChannels;    virtual;
    procedure RemoveAllAnnotations; virtual;
    procedure RemoveAllLimits;      virtual;
    procedure RemoveAllLabels;      virtual;
    procedure RemoveAllTranslations;virtual;

    procedure DeleteToolBar    (Index: Integer); virtual;
    procedure DeleteLegend     (Index: Integer); virtual;
    procedure DeleteTable      (Index: Integer); virtual;
    procedure DeleteXAxis      (Index: Integer); virtual;
    procedure DeleteYAxis      (Index: Integer); virtual;
    procedure DeleteDataView   (Index: Integer); virtual;
    procedure DeleteDataCursor (Index: Integer); virtual;
    procedure DeleteChannel    (Index: Integer); virtual;
    procedure DeleteAnnotation (Index: Integer); virtual;
    procedure DeleteLimit      (Index: Integer); virtual;
    procedure DeleteLabel      (Index: Integer); virtual;
    procedure DeleteTranslation(Index: Integer); virtual;

    function GetToolBarByName   (Value: String): TiPlotToolBar;
    function GetLegendByName    (Value: String): TiPlotLegend;
    function GetTableByName     (Value: String): TiPlotTable;
    function GetXAxisByName     (Value: String): TiPlotXAxis;
    function GetYAxisByName     (Value: String): TiPlotYAxis;
    function GetDataViewByName  (Value: String): TiPlotDataView;
    function GetDataCursorByName(Value: String): TiPlotDataCursor;
    function GetChannelByName   (Value: String): TiPlotChannelCustom;
    function GetLimitByName     (Value: String): TiPlotLimit;
    function GetLabelByName     (Value: String): TiPlotLabel;
    function GetAnnotationByName(Value: String): TiPlotAnnotation;

    function GetChannelIndexByName   (Value : String): Integer;
    function GetXAxisIndexByName     (Value : String): Integer;
    function GetYAxisIndexByName     (Value : String): Integer;
    function GetDataViewIndexByName  (Value : String): Integer;
    function GetToolBarIndexByName   (Value : String): Integer;
    function GetLegendIndexByName    (Value : String): Integer;
    function GetAnnotationIndexByName(Value : String): Integer;
    function GetDataCursorIndexByName(Value : String): Integer;
    function GetLabelIndexByName     (Value : String): Integer;
    function GetLimitIndexByName     (Value : String): Integer;
    function GetTableIndexByName     (Value : String): Integer;

    function GetTranslationOriginalString   (Index: Integer): String;
    function GetTranslationReplacementString(Index: Integer): String;

    procedure TransferChannelData(SourceChannelIndex, DestinationChannelIndex, StartIndex, StopIndex: Integer);

    function GetNow: Double;

    function AddChannel     : Integer; virtual;
    function AddDataView    : Integer; virtual;
    function AddDataCursor  : Integer; virtual;
    function AddXAxis       : Integer; virtual;
    function AddYAxis       : Integer; virtual;
    function AddLegend      : Integer; virtual;
    function AddTable       : Integer; virtual;
    function AddToolBar     : Integer; virtual;
    function AddAnnotation  : Integer; virtual;
    function AddLimit       : Integer; virtual;
    function AddLabel       : Integer; virtual;

    function AddTranslation(OriginalString, ReplacementString: String) : Integer;

    procedure AddDataArray(XValue: Double; Data : Variant);

    function ChannelCount     : Integer;
    function DataViewCount    : Integer;
    function DataCursorCount  : Integer;
    function XAxisCount       : Integer;
    function YAxisCount       : Integer;
    function LegendCount      : Integer;
    function TableCount       : Integer;
    function ToolBarCount     : Integer;
    function AnnotationCount  : Integer;
    function LimitCount       : Integer;
    function LabelCount       : Integer;
    function TranslationCount : Integer;

    property ToolBar    [Index:Integer] : TiPlotToolBar           read GetToolBar;
    property Legend     [Index:Integer] : TiPlotLegend            read GetLegend;
    property Table      [Index:Integer] : TiPlotTable             read GetTable;
    property XAxis      [Index:Integer] : TiPlotXAxis             read GetXAxis;
    property YAxis      [Index:Integer] : TiPlotYAxis             read GetYAxis;
    property DataView   [Index:Integer] : TiPlotDataView          read GetDataView;
    property DataCursor [Index:Integer] : TiPlotDataCursor        read GetDataCursor;
    property Channel    [Index:Integer] : TiPlotChannelCustom     read GetChannel;
    property Annotation [Index:Integer] : TiPlotAnnotation        read GetAnnotation;
    property Limit      [Index:Integer] : TiPlotLimit             read GetLimit;
    property Labels     [Index:Integer] : TiPlotLabel             read GetLabel;
    property Translation[Index:Integer] : TiPlotTranslationObject read GetTranslation;

    property PaintingActive                        : Boolean                            read FPaintingActive;
    property LastPropertiesFileName                : String                             read FLastPropertiesFileName;
    property LastDataFileName                      : String                             read FLastDataFileName;

    property PrinterPaperWidthInches               : Double                             read FPrinterPaperWidthInches;
    property PrinterPaperHeightInches              : Double                             read FPrinterPaperHeightInches;
    property PrinterPaperWidthCentimeters          : Double                             read FPrinterPaperWidthCentimeters;
    property PrinterPaperHeightCentimeters         : Double                             read FPrinterPaperHeightCentimeters;
    property PrinterPaperWidthPixels               : Integer                            read FPrinterPaperWidthPixels;
    property PrinterPaperHeightPixels              : Integer                            read FPrinterPaperHeightPixels;

    property PrintXStart                           : Double                             read FPrintXStart                           write FPrintXStart;
    property PrintXStop                            : Double                             read FPrintXStop                            write FPrintXStop;
  published
    property DataViewZHorz                         : Integer                            read GetDataViewZHorz                       write SetDataViewZHorz;
    property DataViewZVert                         : Integer                            read GetDataViewZVert                       write SetDataViewZVert;
    property XYAxesReverse                         : Boolean                            read GetXYAxesReverse                       write SetXYAxesReverse          default False;
    property UserCanEditObjects                    : Boolean                            read GetUserCanEditObjects                  write SetUserCanEditObjects     default True;
    property UserCanAddRemoveChannels              : Boolean                            read FUserCanAddRemoveChannels              write FUserCanAddRemoveChannels default False;

    property OuterMarginLeft                       : Integer                            read FOuterMarginLeft                       write SetOuterMarginLeft    default 5;
    property OuterMarginTop                        : Integer                            read FOuterMarginTop                        write SetOuterMarginTop     default 5;
    property OuterMarginRight                      : Integer                            read FOuterMarginRight                      write SetOuterMarginRight   default 5;
    property OuterMarginBottom                     : Integer                            read FOuterMarginBottom                     write SetOuterMarginBottom  default 5;

    property PrintOrientation                      : TPrinterOrientation                read FPrintOrientation                      write FPrintOrientation     default poLandscape;
    property PrintMarginLeft                       : Double                             read FPrintMarginLeft                       write FPrintMarginLeft;
    property PrintMarginTop                        : Double                             read FPrintMarginTop                        write FPrintMarginTop;
    property PrintMarginRight                      : Double                             read FPrintMarginRight                      write FPrintMarginRight;
    property PrintMarginBottom                     : Double                             read FPrintMarginBottom                     write FPrintMarginBottom;
    property PrintShowDialog                       : Boolean                            read FPrintShowDialog                       write FPrintShowDialog      default True;
    property PrintDocumentName                     : String                             read FPrintDocumentName                     write FPrintDocumentName;
    property PrinterName                           : String                             read FPrinterName                           write FPrinterName;

    property HintsPause                            : Integer                            read FHintsPause                            write SetHintsPause         default 500;
    property HintsHidePause                        : Integer                            read FHintsHidePause                        write SetHintsHidePause     default 2500;
    property HintsShow                             : Boolean                            read FHintsShow                             write SetHintsShow          default True;
    property HintsFont                             : TFont                              read FHintsFont                             write SetHintsFont;

    property EditorFormStyle                       : TiPlotFormStyle                    read FEditorFormStyle                       write SetEditorFormStyle;

    property CopyToClipBoardFormat                 : TiPlotExportFormat                 read FCopyToClipBoardFormat                 write SetCopyToClipBoardFormat;

    property TitleVisible                          : Boolean                            read GetTitleVisible                        write SetTitleVisible       default True;
    property TitleText                             : String                             read GetTitleText                           write SetTitleText;
    property TitleFont                             : TFont                              read GetTitleFont                           write SetTitleFont;
    property TitleMargin                           : Double                             read GetTitleMargin                         write SetTitleMargin;

    property LogFileName                           : String                             read FLogFileName                           write SetLogFileName;
    property LogBufferSize                         : Integer                            read FLogBufferSize                         write SetLogBufferSize      default 0;
    property LoggingActive                         : Boolean                            read FLoggingActive;

    property OnMouseDownXAxis                      : TiPlotObjectMouseEvent             read FOnMouseDownXAxis                      write FOnMouseDownXAxis;
    property OnMouseDownYAxis                      : TiPlotObjectMouseEvent             read FOnMouseDownYAxis                      write FOnMouseDownYAxis;
    property OnMouseDownDataView                   : TiPlotObjectMouseEvent             read FOnMouseDownDataView                   write FOnMouseDownDataView;
    property OnMouseDownLegend                     : TiPlotObjectMouseEvent             read FOnMouseDownLegend                     write FOnMouseDownLegend;
    property OnMouseDownChannel                    : TiPlotObjectMouseEvent             read FOnMouseDownChannel                    write FOnMouseDownChannel;
    property OnMouseDownLimit                      : TiPlotObjectMouseEvent             read FOnMouseDownLimit                      write FOnMouseDownLimit;
    property OnMouseDownDataCursor                 : TiPlotObjectMouseEvent             read FOnMouseDownDataCursor                 write FOnMouseDownDataCursor;
    property OnMouseDownAnnotation                 : TiPlotObjectMouseEvent             read FOnMouseDownAnnotation                 write FOnMouseDownAnnotation;
    property OnMouseDownDataPoint                  : TiPlotDataPointMouseEvent          read FOnMouseDownDataPoint                  write FOnMouseDownDataPoint;

    property OnMouseMoveXAxis                      : TiPlotObjectMouseMoveEvent         read FOnMouseMoveXAxis                      write FOnMouseMoveXAxis;
    property OnMouseMoveYAxis                      : TiPlotObjectMouseMoveEvent         read FOnMouseMoveYAxis                      write FOnMouseMoveYAxis;
    property OnMouseMoveDataView                   : TiPlotObjectMouseMoveEvent         read FOnMouseMoveDataView                   write FOnMouseMoveDataView;
    property OnMouseMoveLegend                     : TiPlotObjectMouseMoveEvent         read FOnMouseMoveLegend                     write FOnMouseMoveLegend;
    property OnMouseMoveChannel                    : TiPlotObjectMouseMoveEvent         read FOnMouseMoveChannel                    write FOnMouseMoveChannel;
    property OnMouseMoveLimit                      : TiPlotObjectMouseMoveEvent         read FOnMouseMoveLimit                      write FOnMouseMoveLimit;
    property OnMouseMoveDataCursor                 : TiPlotObjectMouseMoveEvent         read FOnMouseMoveDataCursor                 write FOnMouseMoveDataCursor;
    property OnMouseMoveAnnotation                 : TiPlotObjectMouseMoveEvent         read FOnMouseMoveAnnotation                 write FOnMouseMoveAnnotation;
    property OnMouseMoveDataPoint                  : TiPlotDataPointMouseMoveEvent      read FOnMouseMoveDataPoint                  write FOnMouseMoveDataPoint;

    property OnMouseUpXAxis                        : TiPlotObjectMouseEvent             read FOnMouseUpXAxis                        write FOnMouseUpXAxis;
    property OnMouseUpYAxis                        : TiPlotObjectMouseEvent             read FOnMouseUpYAxis                        write FOnMouseUpYAxis;
    property OnMouseUpDataView                     : TiPlotObjectMouseEvent             read FOnMouseUpDataView                     write FOnMouseUpDataView;
    property OnMouseUpLegend                       : TiPlotObjectMouseEvent             read FOnMouseUpLegend                       write FOnMouseUpLegend;
    property OnMouseUpChannel                      : TiPlotObjectMouseEvent             read FOnMouseUpChannel                      write FOnMouseUpChannel;
    property OnMouseUpLimit                        : TiPlotObjectMouseEvent             read FOnMouseUpLimit                        write FOnMouseUpLimit;
    property OnMouseUpDataCursor                   : TiPlotObjectMouseEvent             read FOnMouseUpDataCursor                   write FOnMouseUpDataCursor;
    property OnMouseUpAnnotation                   : TiPlotObjectMouseEvent             read FOnMouseUpAnnotation                   write FOnMouseUpAnnotation;
    property OnMouseUpDataPoint                    : TiPlotDataPointMouseEvent          read FOnMouseUpDataPoint                    write FOnMouseUpDataPoint;

    property OnClickXAxis                          : TiPlotObjectEvent                  read FOnClickXAxis                          write FOnClickXAxis;
    property OnClickYAxis                          : TiPlotObjectEvent                  read FOnClickYAxis                          write FOnClickYAxis;
    property OnClickDataView                       : TiPlotObjectEvent                  read FOnClickDataView                       write FOnClickDataView;
    property OnClickLegend                         : TiPlotObjectEvent                  read FOnClickLegend                         write FOnClickLegend;
    property OnClickChannel                        : TiPlotObjectEvent                  read FOnClickChannel                        write FOnClickChannel;
    property OnClickLimit                          : TiPlotObjectEvent                  read FOnClickLimit                          write FOnClickLimit;
    property OnClickDataCursor                     : TiPlotObjectEvent                  read FOnClickDataCursor                     write FOnClickDataCursor;
    property OnClickDataPoint                      : TiPlotClickDataPointEvent          read FOnClickDataPoint                      write FOnClickDataPoint;
    property OnDataPointMoved                      : TiPlotDataPointMovedEvent          read FOnDataPointMoved                      write FOnDataPointMoved;
    property OnClickAnnotation                     : TiPlotObjectEvent                  read FOnClickAnnotation                     write FOnClickAnnotation;

    property OnDblClickXAxis                       : TiPlotObjectEvent                  read FOnDblClickXAxis                       write FOnDblClickXAxis;
    property OnDblClickYAxis                       : TiPlotObjectEvent                  read FOnDblClickYAxis                       write FOnDblClickYAxis;
    property OnDblClickDataView                    : TiPlotObjectEvent                  read FOnDblClickDataView                    write FOnDblClickDataView;
    property OnDblClickLegend                      : TiPlotObjectEvent                  read FOnDblClickLegend                      write FOnDblClickLegend;
    property OnDblClickChannel                     : TiPlotObjectEvent                  read FOnDblClickChannel                     write FOnDblClickChannel;
    property OnDblClickLimit                       : TiPlotObjectEvent                  read FOnDblClickLimit                       write FOnDblClickLimit;
    property OnDblClickDataCursor                  : TiPlotObjectEvent                  read FOnDblClickDataCursor                  write FOnDblClickDataCursor;
    property OnDblClickDataPoint                   : TiPlotClickDataPointEvent          read FOnDblClickDataPoint                   write FOnDblClickDataPoint;
    property OnDblClickAnnotation                  : TiPlotObjectEvent                  read FOnDblClickAnnotation                  write FOnDblClickAnnotation;

    property OnMouseWheelXAxis                     : TiPlotObjectMouseWheelEvent        read FOnMouseWheelXAxis                     write FOnMouseWheelXAxis;
    property OnMouseWheelYAxis                     : TiPlotObjectMouseWheelEvent        read FOnMouseWheelYAxis                     write FOnMouseWheelYAxis;
    property OnMouseWheelDataView                  : TiPlotObjectMouseWheelEvent        read FOnMouseWheelDataView                  write FOnMouseWheelDataView;
    property OnMouseWheelLegend                    : TiPlotObjectMouseWheelEvent        read FOnMouseWheelLegend                    write FOnMouseWheelLegend;
    property OnMouseWheelChannel                   : TiPlotObjectMouseWheelEvent        read FOnMouseWheelChannel                   write FOnMouseWheelChannel;
    property OnMouseWheelLimit                     : TiPlotObjectMouseWheelEvent        read FOnMouseWheelLimit                     write FOnMouseWheelLimit;
    property OnMouseWheelDataCursor                : TiPlotObjectMouseWheelEvent        read FOnMouseWheelDataCursor                write FOnMouseWheelDataCursor;
    property OnMouseWheelAnnotation                : TiPlotObjectMouseWheelEvent        read FOnMouseWheelAnnotation                write FOnMouseWheelAnnotation;

    property OnDataCursorChange                    : TiPlotObjectEvent                  read FOnDataCursorChange                    write FOnDataCursorChange;

    property OnXAxisMinChange                      : TiPlotObjectDoubleValueChangeEvent read FOnXAxisMinChange                      write FOnXAxisMinChange;
    property OnXAxisSpanChange                     : TiPlotObjectDoubleValueChangeEvent read FOnXAxisSpanChange                     write FOnXAxisSpanChange;
    property OnXAxisMinSpanChange                  : TiPlotAxesMinSpanChangeEvent       read FOnXAxisMinSpanChange                  write FOnXAxisMinSpanChange;
    property OnXAxisMinSpanChangeFinished          : TiPlotAxesMinSpanChangeEvent       read FOnXAxisMinSpanChangeFinished          write FOnXAxisMinSpanChangeFinished;

    property OnYAxisSpanChange                     : TiPlotObjectDoubleValueChangeEvent read FOnYAxisSpanChange                     write FOnYAxisSpanChange;
    property OnYAxisMinChange                      : TiPlotObjectDoubleValueChangeEvent read FOnYAxisMinChange                      write FOnYAxisMinChange;
    property OnYAxisMinSpanChange                  : TiPlotAxesMinSpanChangeEvent       read FOnYAxisMinSpanChange                  write FOnYAxisMinSpanChange;
    property OnYAxisMinSpanChangeFinished          : TiPlotAxesMinSpanChangeEvent       read FOnYAxisMinSpanChangeFinished          write FOnYAxisMinSpanChangeFinished;

    property OnXAxisCustomizeLabel                 : TiPlotAxesCustomizeLabelEvent      read FOnXAxisCustomizeLabel                 write FOnXAxisCustomizeLabel;
    property OnYAxisCustomizeLabel                 : TiPlotAxesCustomizeLabelEvent      read FOnYAxisCustomizeLabel                 write FOnYAxisCustomizeLabel;

    property OnDataCursorCustomizeHint             : TiPlotObjectCustomizeTextEvent     read FOnDataCursorCustomizeHint             write FOnDataCursorCustomizeHint;
    property OnXAxisCustomizeHint                  : TiPlotObjectCustomizeTextEvent     read FOnXAxisCustomizeHint                  write FOnXAxisCustomizeHint;
    property OnYAxisCustomizeHint                  : TiPlotObjectCustomizeTextEvent     read FOnYAxisCustomizeHint                  write FOnYAxisCustomizeHint;
    property OnDataPointCustomizeHint              : TiPlotDataPointCustomizeTextEvent  read FOnDataPointCustomizeHint              write FOnDataPointCustomizeHint;
    property OnToolBarCustomizeHint                : TiPlotObjectCustomizeTextEvent     read FOnToolBarCustomizeHint                write FOnToolBarCustomizeHint;

    property OnLimitLine1PositionChange            : TiPlotObjectDoubleValueChangeEvent read FOnLimitLine1PositionChange            write FOnLimitLine1PositionChange;
    property OnLimitLine2PositionChange            : TiPlotObjectDoubleValueChangeEvent read FOnLimitLine2PositionChange            write FOnLimitLine2PositionChange;

    property OnBeforePrint                         : TNotifyEvent                       read FOnBeforePrint                         write FOnBeforePrint;
    property OnBeforePrintPage                     : TiPlotPrintPageEvent               read FOnBeforePrintPage                     write FOnBeforePrintPage;
    property OnAfterPrint                          : TNotifyEvent                       read FOnAfterPrint                          write FOnAfterPrint;

    property OnGotFocusChannel                     : TiPlotObjectEvent                  read FOnGotFocusChannel                     write FOnGotFocusChannel;
    property OnGotFocusXAxis                       : TiPlotObjectEvent                  read FOnGotFocusXAxis                       write FOnGotFocusXAxis;
    property OnGotFocusYAxis                       : TiPlotObjectEvent                  read FOnGotFocusYAxis                       write FOnGotFocusYAxis;
    property OnGotFocusDataCursor                  : TiPlotObjectEvent                  read FOnGotFocusDataCursor                  write FOnGotFocusDataCursor;
    property OnGotFocusDataView                    : TiPlotObjectEvent                  read FOnGotFocusDataView                    write FOnGotFocusDataView;
    property OnGotFocusLegend                      : TiPlotObjectEvent                  read FOnGotFocusLegend                      write FOnGotFocusLegend;
    property OnGotFocusAnnotation                  : TiPlotObjectEvent                  read FOnGotFocusAnnotation                  write FOnGotFocusAnnotation;

    property OnLostFocusChannel                    : TiPlotObjectEvent                  read FOnLostFocusChannel                    write FOnLostFocusChannel;
    property OnLostFocusXAxis                      : TiPlotObjectEvent                  read FOnLostFocusXAxis                      write FOnLostFocusXAxis;
    property OnLostFocusYAxis                      : TiPlotObjectEvent                  read FOnLostFocusYAxis                      write FOnLostFocusYAxis;
    property OnLostFocusDataCursor                 : TiPlotObjectEvent                  read FOnLostFocusDataCursor                 write FOnLostFocusDataCursor;
    property OnLostFocusDataView                   : TiPlotObjectEvent                  read FOnLostFocusDataView                   write FOnLostFocusDataView;
    property OnLostFocusLegend                     : TiPlotObjectEvent                  read FOnLostFocusLegend                     write FOnLostFocusLegend;
    property OnLostFocusAnnotation                 : TiPlotObjectEvent                  read FOnLostFocusAnnotation                 write FOnLostFocusAnnotation;

    property OnAddChannel                          : TiPlotObjectEvent                  read FOnAddChannel                          write FOnAddChannel;
    property OnAddXAxis                            : TiPlotObjectEvent                  read FOnAddXAxis                            write FOnAddXAxis;
    property OnAddYAxis                            : TiPlotObjectEvent                  read FOnAddYAxis                            write FOnAddYAxis;
    property OnAddDataCursor                       : TiPlotObjectEvent                  read FOnAddDataCursor                       write FOnAddDataCursor;
    property OnAddDataView                         : TiPlotObjectEvent                  read FOnAddDataView                         write FOnAddDataView;
    property OnAddLegend                           : TiPlotObjectEvent                  read FOnAddLegend                           write FOnAddLegend;
    property OnAddLimit                            : TiPlotObjectEvent                  read FOnAddLimit                            write FOnAddLimit;
    property OnAddTable                            : TiPlotObjectEvent                  read FOnAddTable                            write FOnAddTable;
    property OnAddAnnotation                       : TiPlotObjectEvent                  read FOnAddAnnotation                       write FOnAddAnnotation;

    property OnRemoveChannel                       : TiPlotObjectEvent                  read FOnRemoveChannel                      write FOnRemoveChannel;
    property OnRemoveXAxis                         : TiPlotObjectEvent                  read FOnRemoveXAxis                        write FOnRemoveXAxis;
    property OnRemoveYAxis                         : TiPlotObjectEvent                  read FOnRemoveYAxis                        write FOnRemoveYAxis;
    property OnRemoveDataCursor                    : TiPlotObjectEvent                  read FOnRemoveDataCursor                   write FOnRemoveDataCursor;
    property OnRemoveDataView                      : TiPlotObjectEvent                  read FOnRemoveDataView                     write FOnRemoveDataView;
    property OnRemoveLegend                        : TiPlotObjectEvent                  read FOnRemoveLegend                       write FOnRemoveLegend;
    property OnRemoveLimit                         : TiPlotObjectEvent                  read FOnRemoveLimit                        write FOnRemoveLimit;
    property OnRemoveTable                         : TiPlotObjectEvent                  read FOnRemoveTable                        write FOnRemoveTable;
    property OnRemoveAnnotation                    : TiPlotObjectEvent                  read FOnRemoveAnnotation                   write FOnRemoveAnnotation;

    property OnGetMouseCursorChannel               : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorChannel              write FOnGetMouseCursorChannel;
    property OnGetMouseCursorXAxis                 : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorXAxis                write FOnGetMouseCursorXAxis;
    property OnGetMouseCursorYAxis                 : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorYAxis                write FOnGetMouseCursorYAxis;
    property OnGetMouseCursorDataCursor            : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorDataCursor           write FOnGetMouseCursorDataCursor;
    property OnGetMouseCursorDataView              : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorDataView             write FOnGetMouseCursorDataView;
    property OnGetMouseCursorLegend                : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorLegend               write FOnGetMouseCursorLegend;
    property OnGetMouseCursorLimit                 : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorLimit                write FOnGetMouseCursorLimit;
    property OnGetMouseCursorTable                 : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorTable                write FOnGetMouseCursorTable;
    property OnGetMouseCursorAnnotation            : TiPlotObjectGetMouseCursorEvent    read FOnGetMouseCursorAnnotation           write FOnGetMouseCursorAnnotation;

    property OnPopupMenuChannel                    : TiPlotPopupMenuEvent               read FOnPopupMenuChannel                    write FOnPopupMenuChannel;
    property OnPopupMenuXAxis                      : TiPlotPopupMenuEvent               read FOnPopupMenuXAxis                      write FOnPopupMenuXAxis;
    property OnPopupMenuYAxis                      : TiPlotPopupMenuEvent               read FOnPopupMenuYAxis                      write FOnPopupMenuYAxis;
    property OnPopupMenuDataCursor                 : TiPlotPopupMenuEvent               read FOnPopupMenuDataCursor                 write FOnPopupMenuDataCursor;
    property OnPopupMenuDataView                   : TiPlotPopupMenuEvent               read FOnPopupMenuDataView                   write FOnPopupMenuDataView;
    property OnPopupMenuLegend                     : TiPlotPopupMenuEvent               read FOnPopupMenuLegend                     write FOnPopupMenuLegend;
    property OnPopupMenuLimit                      : TiPlotPopupMenuEvent               read FOnPopupMenuLimit                      write FOnPopupMenuLimit;
    property OnPopupMenuAnnotation                 : TiPlotPopupMenuEvent               read FOnPopupMenuAnnotation                 write FOnPopupMenuAnnotation;

    property OnBeforeLoadProperties                : TNotifyEvent                       read FOnBeforeLoadProperties                write FOnBeforeLoadProperties;
    property OnAfterLoadProperties                 : TNotifyEvent                       read FOnAfterLoadProperties                 write FOnAfterLoadProperties;
    property OnAfterSaveProperties                 : TNotifyEvent                       read FOnAfterSaveProperties                 write FOnAfterSaveProperties;

    property OnAfterLoadData                       : TNotifyEvent                       read FOnAfterLoadData                       write FOnAfterLoadData;
    property OnAfterSaveData                       : TNotifyEvent                       read FOnAfterSaveData                       write FOnAfterSaveData;

    property OnAfterPaint                          : TNotifyEvent                       read FOnAfterPaint                          write FOnAfterPaint;

    property OnAfterOpenEditor                     : TNotifyEvent                       read FOnAfterOpenEditor                     write FOnAfterOpenEditor;
    property OnAfterCloseEditor                    : TNotifyEvent                       read FOnAfterCloseEditor                    write FOnAfterCloseEditor;

    property OnBeforeZoomBox                       : TiPlotZoomBoxEvent                 read FOnBeforeZoomBox                       write FOnBeforeZoomBox;
    property OnToolBarButtonClick                  : TiPlotToolBarButtonEvent           read FOnToolBarButtonClick                  write FOnToolBarButtonClick;
    property OnBeforeToolBarButtonClick            : TiPlotToolBarButtonBeforeEvent     read FOnBeforeToolBarButtonClick            write FOnBeforeToolBarButtonClick;

    property OnBeforeDataCursorUpdate              : TiPlotObjectEvent                  read FOnBeforeDataCursorUpdate              write FOnBeforeDataCursorUpdate;

    property OnAnnotationCoordinatesChange         : TiPlotObjectEvent                  read FOnAnnotationCoordinatesChange         write FOnAnnotationCoordinatesChange;
    property OnAnnotationMoveUser                  : TiPlotObjectEvent                  read FOnAnnotationMoveUser                  write FOnAnnotationMoveUser;
    property OnAnnotationResizeUser                : TiPlotObjectEvent                  read FOnAnnotationResizeUser                write FOnAnnotationResizeUser;
    property OnAnnotationCoordinatesChangeFinished : TiPlotObjectEvent                  read FOnAnnotationCoordinatesChangeFinished write FOnAnnotationCoordinatesChangeFinished;

    property AnnotationDefaultFont                 : TFont                              read FAnnotationDefaultFont                 write SetAnnotationDefaultFont;
    property AnnotationDefaultBrushStlye           : TBrushStyle                        read FAnnotationDefaultBrushStlye           write FAnnotationDefaultBrushStlye;
    property AnnotationDefaultBrushColor           : TColor                             read FAnnotationDefaultBrushColor           write FAnnotationDefaultBrushColor;
    property AnnotationDefaultPenStlye             : TPenStyle                          read FAnnotationDefaultPenStlye             write FAnnotationDefaultPenStlye;
    property AnnotationDefaultPenColor             : TColor                             read FAnnotationDefaultPenColor             write FAnnotationDefaultPenColor;
    property AnnotationDefaultPenWidth             : Integer                            read FAnnotationDefaultPenWidth             write FAnnotationDefaultPenWidth;

    property AnnotationDefaultReference            : TiPlotReferenceType                read FAnnotationDefaultReference            write FAnnotationDefaultReference;
    property AnnotationDefaultReferencePositionX   : TiPlotReferenceIndividual          read FAnnotationDefaultReferencePositionX   write FAnnotationDefaultReferencePositionX;
    property AnnotationDefaultReferencePositionY   : TiPlotReferenceIndividual          read FAnnotationDefaultReferencePositionY   write FAnnotationDefaultReferencePositionY;
    property AnnotationDefaultReferenceSizeX       : TiPlotReferenceIndividual          read FAnnotationDefaultReferenceSizeX       write FAnnotationDefaultReferenceSizeX;
    property AnnotationDefaultReferenceSizeY       : TiPlotReferenceIndividual          read FAnnotationDefaultReferenceSizeY       write FAnnotationDefaultReferenceSizeY;

    property ClipAnnotationsToAxes                 : Boolean                            read FClipAnnotationsToAxes                 write SetClipAnnotationsToAxes;

    property BackGroundGradientEnabled             : Boolean                            read FBackGroundGradientEnabled             write SetBackGroundGradientEnabled;
    property BackGroundGradientDirection           : TiFillDirection                    read FBackGroundGradientDirection           write SetBackGroundGradientDirection;
    property BackGroundGradientStartColor          : TColor                             read FBackGroundGradientStartColor          write SetBackGroundGradientStartColor;
    property BackGroundGradientStopColor           : TColor                             read FBackGroundGradientStopColor           write SetBackGroundGradientStopColor;

    property DataFileColumnSeparator               : TiPlotDataFileColumnSeparator      read FDataFileColumnSeparator               write SetDataFileColumnSeparator;
    property DataFileFormat                        : TiPlotDataFileFormat               read FDataFileFormat                        write SetDataFileFormat;

    property BackGroundColor default clBlack;
    property BorderStyle     default ibsLowered;
    property Align;
    property AutoFrameRate   default True;
    property Anchors;
    property Constraints;
    property TabStop;
    property TabOrder;
    property OnResize;
  end;

implementation

uses iComponent, iVCLComponent;

type
  TiPlotObjectAccess        = class(TiPlotObject       ) end;
  TiPlotLayoutAccess        = class(TiPlotLayoutObject ) end;
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom) end;
  TiPlotChannelAccess       = class(TiPlotChannel      ) end;
  TiPlotAxisAccess          = class(TiPlotAxis         ) end;
  TiPlotLabelAccess         = class(TiPlotLabel        ) end;
  TiPlotDataViewAccess      = class(TiPlotDataView     ) end;
  TiPlotLegendAccess        = class(TiPlotLegend       ) end;
  TiPlotTableAccess         = class(TiPlotTable        ) end;
  TiPlotLimitAccess         = class(TiPlotLimit        ) end;
  TiPlotToolBarAccess       = class(TiPlotToolBar      ) end;
  TiPlotDataCursorAccess    = class(TiPlotDataCursor   ) end;
  TiPlotAnnotationAccess    = class(TiPlotAnnotation   ) end;
  TStringListAccess         = class(TStringList        ) end;
//****************************************************************************************************************************************************
constructor TiPlotComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width  := 500;
  Height := 200;

  BackGroundColor               := clBlack;
  BorderStyle                   := ibsLowered;

  UpdateFrameRate               := 60;
  AutoFrameRate                 := True;

  FBackGroundGradientStartColor := clBlue;

  FOuterMarginLeft              := 5;
  FOuterMarginTop               := 5;
  FOuterMarginRight             := 5;
  FOuterMarginBottom            := 5;

  FHintsShow                    := True;
  FHintsPause                   := 500;
  FHintsHidePause               := 2500;

  FPrintShowDialog              := True;
  FPrintOrientation             := poLandscape;
  FPrintMarginTop               := 1;
  FPrintMarginLeft              := 1;
  FPrintMarginRight             := 1;
  FPrintMarginBottom            := 1;
  FPrintDocumentName            := 'Untitled';

  FMaster                       := TiPlotMasterManager.Create(Self);
  FMaster.OnChange              := MasterChange;
  FMaster.OnRemove              := MasterRemove;
  FMaster.OnInsert              := MasterInsert;

  FMaster.OnInvalidateNow       := InvalidateNowEvent;

  FPopupMenu                    := TPopupMenu.Create(Self);

  FHintsFont                    := TFont.Create;

  FImageList0                   := TImageList.CreateSize(24, 24);
  FImageList1                   := TImageList.CreateSize(24, 24);
  FImageList2                   := TImageList.CreateSize(24, 24);

  FAnnotationDefaultFont        := TFont.Create;
  FAnnotationDefaultFont.Color  := clWhite;

  FAnnotationDefaultBrushStlye  := bsSolid;
  FAnnotationDefaultBrushColor  := clWhite;
  FAnnotationDefaultPenStlye    := pssolid;
  FAnnotationDefaultPenColor    := clWhite;
  FAnnotationDefaultPenwidth    := 1;

  FAnnotationDefaultReference          := iprtDataView;
  FAnnotationDefaultReferencePositionX := ipriAuto;
  FAnnotationDefaultReferencePositionY := ipriAuto;
  FAnnotationDefaultReferenceSizeX     := ipriAuto;
  FAnnotationDefaultReferenceSizeY     := ipriAuto;

  FAxesCollisionList            := TStringList.Create;
  FAxesCollisionList.Sorted     := False;

  FVisibleListLeft   := TStringList.Create;
  FVisibleListRight  := TStringList.Create;
  FVisibleListTop    := TStringList.Create;
  FVisibleListBottom := TStringList.Create;

  FLayerList                    := TStringList.Create;
  FLayerList.Sorted             := True;
  FLayerList.Duplicates         := dupAccept;

  FClipAnnotationsToAxes        := True;

  UserCanEditObjects            := True;

  OnInternalTimer               := HintTimer;
end;
//****************************************************************************************************************************************************
destructor TiPlotComponent.Destroy;
begin
  FMouseDownObject := nil;

  ClearAxesCollisionList;

  FMaster.ObjectManager.ShutDownSetup;

  if Assigned(FMaster) then
    begin
      FMaster.Free;
      FMaster := nil;
    end;

  {$ifdef iVCL}if Assigned(FSnapShotPicture) then FSnapShotPicture.Free;{$endif}
  {$ifdef iVCL}if Assigned(FMetaFile)        then FMetaFile.Free;       {$endif}
               if Assigned(FSaveDialog)      then FSaveDialog.Free;

  FHintsFont.Free;                   
  FAnnotationDefaultFont.Free;
  FImageList0.Free;
  FImageList1.Free;
  FImageList2.Free;
  FPopupMenu.Free;

  FAxesCollisionList.Free;
  FLayerList.Free;

  FVisibleListBottom.Free;
  FVisibleListTop.Free;
  FVisibleListRight.Free;
  FVisibleListLeft.Free;

  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.Loaded;
begin
  inherited;
  FMaster.LayoutManager.Enabled := True;
  EndUpdate;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ClearAxesCollisionList;
begin
  while FAxesCollisionList.Count <> 0 do
    begin
      FAxesCollisionList.Objects[0].Free;
      FAxesCollisionList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ClearLayerList;
begin
  FLayerList.Clear;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.AddLayerObject(LayerString: String; PlotObject: TiPlotObject);
begin
  FLayerList.AddObject(LayerString, PlotObject);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.AddAxesCollisionItem(ARect: TRect);
var
  iPlotRectObject : TiPlotRectObject;
begin
  iPlotRectObject       := TiPlotRectObject.Create;
  iPlotRectObject.ARect := ARect;
  FAxesCollisionList.AddObject('', iPlotRectObject);
end;
//****************************************************************************************************************************************************
function TiPlotComponent.AddAxesCollisionDetectionItem(ARect: TRect): Boolean;
var
  x           : Integer;
  CurrentRect : TRect;
  DummyRect   : TRect;
begin
  Result := False;
  for x := 0 to FAxesCollisionList.Count - 1 do
    begin
      CurrentRect := (FAxesCollisionList.Objects[x] as TiPlotRectObject).ARect;
      if IntersectRect(DummyRect, CurrentRect, ARect) then Exit;

      UnionRect(DummyRect, Master.DataViewManager.Items[0].DrawRect, ARect);
      if not EqualRect(DummyRect, Master.DataViewManager.Items[0].DrawRect) then Exit;
    end;

  AddAxesCollisionItem(ARect);
  Result := True;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetChannelManager    : TiPlotChannelManager;     begin Result := FMaster.ChannelManager;     end;
function TiPlotComponent.GetDataCursorManager : TiPlotDataCursorManager;  begin Result := FMaster.DataCursorManager;  end;
function TiPlotComponent.GetDataViewManager   : TiPlotDataViewManager;    begin Result := FMaster.DataViewManager;    end;
function TiPlotComponent.GetLabelManager      : TiPlotLabelManager;       begin Result := FMaster.LabelManager;       end;
function TiPlotComponent.GetLayoutManager     : TiPlotLayoutManager;      begin Result := FMaster.LayoutManager;      end;
function TiPlotComponent.GetLegendManager     : TiPlotLegendManager;      begin Result := FMaster.LegendManager;      end;
function TiPlotComponent.GetTableManager      : TiPlotTableManager;       begin Result := FMaster.TableManager;       end;
function TiPlotComponent.GetLimitManager      : TiPlotLimitManager;       begin Result := FMaster.LimitManager;       end;
function TiPlotComponent.GetPlotObjectManager : TiPlotObjectManager;      begin Result := FMaster.ObjectManager;      end;
function TiPlotComponent.GetToolBarManager    : TiPlotToolBarManager;     begin Result := FMaster.ToolBarManager;     end;
function TiPlotComponent.GetTranslationManager: TiPlotTranslationManager; begin Result := FMaster.TranslationManager; end;
function TiPlotComponent.GetXAxisManager      : TiPlotXAxisManager;       begin Result := FMaster.XAxisManager;       end;
function TiPlotComponent.GetYAxisManager      : TiPlotYAxisManager;       begin Result := FMaster.YAxisManager;       end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetOuterMarginBottom           (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginBottom,           irtInvalidate);end;
procedure TiPlotComponent.SetOuterMarginLeft             (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginLeft,             irtInvalidate);end;
procedure TiPlotComponent.SetOuterMarginRight            (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginRight,            irtInvalidate);end;
procedure TiPlotComponent.SetOuterMarginTop              (const Value:Integer);begin SetIntegerProperty(Value,FOuterMarginTop,              irtInvalidate);end;
procedure TiPlotComponent.SetHintsHidePause              (const Value:Integer);begin SetIntegerProperty(Value,FHintsHidePause,              irtNone      );end;
procedure TiPlotComponent.SetHintsPause                  (const Value:Integer);begin SetIntegerProperty(Value,FHintsPause,                  irtNone      );end;
procedure TiPlotComponent.SetHintsShow                   (const Value:Boolean);begin SetBooleanProperty(Value,FHintsShow,                   irtNone      );end;
procedure TiPlotComponent.SetLogBufferSize               (const Value:Integer);begin SetIntegerProperty(Value,FLogBufferSize,               irtNone      );end;
procedure TiPlotComponent.SetClipAnnotationsToAxes       (const Value:Boolean);begin SetBooleanProperty(Value,FClipAnnotationsToAxes,       irtInvalidate);end;
procedure TiPlotComponent.SetBackGroundGradientEnabled   (const Value:Boolean);begin SetBooleanProperty(Value,FBackGroundGradientEnabled,   irtInvalidate);end;
procedure TiPlotComponent.SetBackGroundGradientStartColor(const Value:TColor );begin SetColorProperty  (Value,FBackGroundGradientStartColor,irtInvalidate);end;
procedure TiPlotComponent.SetBackGroundGradientStopColor (const Value:TColor );begin SetColorProperty  (Value,FBackGroundGradientStopColor, irtInvalidate);end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetTitleText   (const Value:String );begin if LabelCount > 0 then Labels[0].Caption      := Value;end;
procedure TiPlotComponent.SetTitleVisible(const Value:Boolean);begin if LabelCount > 0 then Labels[0].Visible      := Value;end;
procedure TiPlotComponent.SetTitleMargin (const Value:Double );begin if LabelCount > 0 then Labels[0].MarginBottom := Value;end;
procedure TiPlotComponent.SetTitleFont   (const Value:TFont  );begin if LabelCount > 0 then Labels[0].Font.Assign(Value);   end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetTitleText   : String; begin if LabelCount > 0 then Result := Labels[0].Caption      else Result := '';    end;
function TiPlotComponent.GetTitleVisible: Boolean;begin if LabelCount > 0 then Result := Labels[0].Visible      else Result := False; end;
function TiPlotComponent.GetTitleMargin : Double; begin if LabelCount > 0 then Result := Labels[0].MarginBottom else Result := 0;     end;
function TiPlotComponent.GetTitleFont   : TFont;  begin if LabelCount > 0 then Result := Labels[0].Font         else Result := Font;  end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetHintsFont            (const Value: TFont);begin FHintsFont.Assign(Value);            end;
procedure TiPlotComponent.SetAnnotationDefaultFont(const Value: TFont);begin FAnnotationDefaultFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetBackGroundGradientDirection(const Value: TiFillDirection);
begin
  if FBackGroundGradientDirection <> Value then
    begin
      FBackGroundGradientDirection := Value;
      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetDataFileColumnSeparator(const Value: TiPlotDataFileColumnSeparator);
begin
  if FDataFileColumnSeparator <> Value then
    begin
      if FLoggingActive then raise Exception.Create('Data File Column Seperator can not be changed while logging active');
      FDataFileColumnSeparator := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetDataFileFormat(const Value: TiPlotDataFileFormat);
begin
  if FLoggingActive then raise Exception.Create('Data File Format can not be changed while logging active');
  if FDataFileFormat <> Value then
    begin
      FDataFileFormat := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetEditorFormStyle(const Value:TiPlotFormStyle);
begin
  FEditorFormStyle := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DefineProperties(Filer: TFiler);
begin
  FMaster.LayoutManager.Enabled := False;
  BeginUpdate;

  Filer.DefineProperty('DataViewZHorz',  ReadDataViewZHorz, WriteDataViewZHorz, True);
  Filer.DefineProperty('DataViewZVert',  ReadDataViewZVert, WriteDataViewZVert, True);

                                                
  Filer.DefineBinaryProperty('ImageList0', ReadImageList0, WriteImageList0, FImageList0.Count <> 0);
  Filer.DefineBinaryProperty('ImageList1', ReadImageList1, WriteImageList1, FImageList1.Count <> 0);
  Filer.DefineBinaryProperty('ImageList2', ReadImageList2, WriteImageList2, FImageList2.Count <> 0);

  if Assigned(FMaster.ToolBarManager    ) then Filer.DefineProperty('ToolBarManager',    FMaster.ToolBarManager.ReadFromStream,    FMaster.ToolBarManager.WriteToStream,    FMaster.ToolBarManager.DoWriteToStream);
  if Assigned(FMaster.LegendManager     ) then Filer.DefineProperty('LegendManager',     FMaster.LegendManager.ReadFromStream,     FMaster.LegendManager.WriteToStream,     FMaster.LegendManager.DoWriteToStream);
  if Assigned(FMaster.TableManager      ) then Filer.DefineProperty('TableManager',      FMaster.TableManager.ReadFromStream,      FMaster.TableManager.WriteToStream,      FMaster.TableManager.DoWriteToStream);
  if Assigned(FMaster.XAxisManager      ) then Filer.DefineProperty('XAxisManager',      FMaster.XAxisManager.ReadFromStream,      FMaster.XAxisManager.WriteToStream,      FMaster.XAxisManager.DoWriteToStream);
  if Assigned(FMaster.YAxisManager      ) then Filer.DefineProperty('YAxisManager',      FMaster.YAxisManager.ReadFromStream,      FMaster.YAxisManager.WriteToStream,      FMaster.YAxisManager.DoWriteToStream);
  if Assigned(FMaster.ChannelManager    ) then Filer.DefineProperty('ChannelManager',    FMaster.ChannelManager.ReadFromStream,    FMaster.ChannelManager.WriteToStream,    FMaster.ChannelManager.DoWriteToStream);
  if Assigned(FMaster.DataViewManager   ) then Filer.DefineProperty('DataViewManager',   FMaster.DataViewManager.ReadFromStream,   FMaster.DataViewManager.WriteToStream,   FMaster.DataViewManager.DoWriteToStream);
  if Assigned(FMaster.DataCursorManager ) then Filer.DefineProperty('DataCursorManager', FMaster.DataCursorManager.ReadFromStream, FMaster.DataCursorManager.WriteToStream, FMaster.DataCursorManager.DoWriteToStream);
  if Assigned(FMaster.LimitManager      ) then Filer.DefineProperty('LimitManager',      FMaster.LimitManager.ReadFromStream,      FMaster.LimitManager.WriteToStream,      FMaster.LimitManager.DoWriteToStream);
  if Assigned(FMaster.LabelManager      ) then Filer.DefineProperty('LabelManager',      FMaster.LabelManager.ReadFromStream,      FMaster.LabelManager.WriteToStream,      FMaster.LabelManager.DoWriteToStream);
  if Assigned(FMaster.TranslationManager) then Filer.DefineProperty('TranslationManager',FMaster.TranslationManager.ReadFromStream,FMaster.TranslationManager.WriteToStream,FMaster.TranslationManager.DoWriteToStream);
  inherited;
                                                                                 
  if (FMaster.ToolBarManager.Count <> 0) and (FMaster.LabelManager.Count <> 0) then
    begin
      if (FMaster.ToolBarManager.Items[0].Horizontal = FMaster.LabelManager.Items[0].Horizontal) and
         (FMaster.ToolBarManager.Items[0].ZOrder     = FMaster.LabelManager.Items[0].ZOrder) then
          FMaster.ToolBarManager.Items[0].ZOrder := FMaster.ToolBarManager.Items[0].ZOrder + 1;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetLogFileName(const Value: String);
begin
  if FLogFileName <> Value then
    begin
      if FLoggingActive then raise Exception.Create('Log File Name can not be changed while logging is active.');
      FLogFileName := Value;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MasterChange(Sender: TObject);
begin
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MasterRemove(Sender: TObject);
begin
  if Sender = FMouseDownObject      then FMouseDownObject      := nil;
  if Sender = FLastMouseOverObject  then FLastMouseOverObject  := nil;
  if Sender = FLastMouseClickObject then FLastMouseClickObject := nil;

  if Sender is TiPlotChannelCustom then if Assigned(FOnRemoveChannel   ) then FOnRemoveChannel   (FMaster.ChannelManager.GetIndex   (Sender as TiPlotObject));
  if Sender is TiPlotXAxis         then if Assigned(FOnRemoveXAxis     ) then FOnRemoveXAxis     (FMaster.XAxisManager.GetIndex     (Sender as TiPlotObject));
  if Sender is TiPlotYAxis         then if Assigned(FOnRemoveYAxis     ) then FOnRemoveYAxis     (FMaster.YAxisManager.GetIndex     (Sender as TiPlotObject));
  if Sender is TiPlotDataCursor    then if Assigned(FOnRemoveDataCursor) then FOnRemoveDataCursor(FMaster.DataCursorManager.GetIndex(Sender as TiPlotObject));
  if Sender is TiPlotDataView      then if Assigned(FOnRemoveDataView  ) then FOnRemoveDataView  (FMaster.DataViewManager.GetIndex  (Sender as TiPlotObject));
  if Sender is TiPlotLegend        then if Assigned(FOnRemoveLegend    ) then FOnRemoveLegend    (FMaster.LegendManager.GetIndex    (Sender as TiPlotObject));
  if Sender is TiPlotLimit         then if Assigned(FOnRemoveLimit     ) then FOnRemoveLimit     (FMaster.LimitManager.GetIndex     (Sender as TiPlotObject));
  if Sender is TiPlotTable         then if Assigned(FOnRemoveTable     ) then FOnRemoveTable     (FMaster.TableManager.GetIndex     (Sender as TiPlotObject));
  if Sender is TiPlotAnnotation    then if Assigned(FOnRemoveAnnotation) then FOnRemoveAnnotation(FMaster.AnnotationManager.GetIndex(Sender as TiPlotObject));
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MasterInsert(Sender: TObject);
begin
  if Sender is TiPlotChannelCustom then if Assigned(FOnAddChannel   ) then FOnAddChannel   (FMaster.ChannelManager.GetIndex   (Sender as TiPlotObject));
  if Sender is TiPlotXAxis         then if Assigned(FOnAddXAxis     ) then FOnAddXAxis     (FMaster.XAxisManager.GetIndex     (Sender as TiPlotObject));
  if Sender is TiPlotYAxis         then if Assigned(FOnAddYAxis     ) then FOnAddYAxis     (FMaster.YAxisManager.GetIndex     (Sender as TiPlotObject));
  if Sender is TiPlotDataCursor    then if Assigned(FOnAddDataCursor) then FOnAddDataCursor(FMaster.DataCursorManager.GetIndex(Sender as TiPlotObject));
  if Sender is TiPlotDataView      then if Assigned(FOnAddDataView  ) then FOnAddDataView  (FMaster.DataViewManager.GetIndex  (Sender as TiPlotObject));
  if Sender is TiPlotLegend        then if Assigned(FOnAddLegend    ) then FOnAddLegend    (FMaster.LegendManager.GetIndex    (Sender as TiPlotObject));
  if Sender is TiPlotLimit         then if Assigned(FOnAddLimit     ) then FOnAddLimit     (FMaster.LimitManager.GetIndex     (Sender as TiPlotObject));
  if Sender is TiPlotTable         then if Assigned(FOnAddTable     ) then FOnAddTable     (FMaster.TableManager.GetIndex     (Sender as TiPlotObject));
  if Sender is TiPlotAnnotation    then if Assigned(FOnAddAnnotation) then FOnAddAnnotation(FMaster.AnnotationManager.GetIndex(Sender as TiPlotObject));
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetXYAxesReverse: Boolean;
begin
  Result := FMaster.LayoutManager.XYAxesReverse;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetXYAxesReverse(const Value: Boolean);
begin
  FMaster.XYAxesReverse := Value;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetUserCanEditObjects: Boolean;
begin
  Result := FMaster.UserCanEditObjects;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetUserCanEditObjects(const Value: Boolean);
begin
  FMaster.UserCanEditObjects := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetCopyToClipBoardFormat(const Value: TiPlotExportFormat);
begin
  FCopyToClipBoardFormat := Value;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.AddChannel   : Integer;begin Result:=FMaster.AddChannel;   end;
function TiPlotComponent.AddDataView  : Integer;begin Result:=FMaster.AddDataView;  end;
function TiPlotComponent.AddDataCursor: Integer;begin Result:=FMaster.AddDataCursor;end;
function TiPlotComponent.AddXAxis     : Integer;begin Result:=FMaster.AddXAxis;     end;
function TiPlotComponent.AddYAxis     : Integer;begin Result:=FMaster.AddYAxis;     end;
function TiPlotComponent.AddLegend    : Integer;begin Result:=FMaster.AddLegend;    end;
function TiPlotComponent.AddTable     : Integer;begin Result:=FMaster.AddTable;     end;
function TiPlotComponent.AddToolBar   : Integer;begin Result:=FMaster.AddToolBar;   end;
function TiPlotComponent.AddLimit     : Integer;begin Result:=FMaster.AddLimit;     end;
function TiPlotComponent.AddLabel     : Integer;begin Result:=FMaster.AddLabel;     end;
//****************************************************************************************************************************************************
function TiPlotComponent.AddAnnotation: Integer;
var
  iAnnotation : TiPlotAnnotation;
begin
  Result := FMaster.AddAnnotation;
                                                                          
  iAnnotation                     := Annotation[Result];
  iAnnotation.BrushStyle          := FAnnotationDefaultBrushStlye;
  iAnnotation.BrushColor          := FAnnotationDefaultBrushColor;
  iAnnotation.PenStyle            := FAnnotationDefaultPenStlye;
  iAnnotation.PenColor            := FAnnotationDefaultPenColor;
  iAnnotation.PenWidth            := FAnnotationDefaultPenWidth;
  iAnnotation.Reference           := FAnnotationDefaultReference;
  iAnnotation.ReferencePositionX  := FAnnotationDefaultReferencePositionX;
  iAnnotation.ReferencePositionY  := FAnnotationDefaultReferencePositionY;
  iAnnotation.ReferenceSizeX      := FAnnotationDefaultReferenceSizeX;
  iAnnotation.ReferenceSizeY      := FAnnotationDefaultReferenceSizeY;
  iAnnotation.Font.Assign(FAnnotationDefaultFont);
end;
//****************************************************************************************************************************************************
function TiPlotComponent.AddTranslation(OriginalString, ReplacementString: String): Integer;
begin
  Result := FMaster.TranslationManager.Add;
  FMaster.TranslationManager.Items[Result].OriginalString    := OriginalString;
  FMaster.TranslationManager.Items[Result].ReplacementString := ReplacementString;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DisableLayoutManager; begin FMaster.LayoutManager.Enabled := False;                                       end;
procedure TiPlotComponent.EnableLayoutManager;  begin FMaster.LayoutManager.Enabled := True;                                        end;
procedure TiPlotComponent.RefreshLayoutManager; begin FMaster.LayoutManager.Enabled := False; FMaster.LayoutManager.Enabled := True;end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetDataViewZHorz:Integer;begin Result:= FMaster.LayoutManager.DataViewHorz.ZOrder;end;
function TiPlotComponent.GetDataViewZVert:Integer;begin Result:= FMaster.LayoutManager.DataViewVert.ZOrder;end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetDataViewZHorz(const Value:Integer);begin FMaster.LayoutManager.DataViewHorz.ZOrder:=Value;end;
procedure TiPlotComponent.SetDataViewZVert(const Value:Integer);begin FMaster.LayoutManager.DataViewVert.ZOrder:=Value;end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.RemoveAllChannels;    begin FMaster.ChannelManager.Clear;    InvalidateNow; end;
procedure TiPlotComponent.RemoveAllDataViews;   begin FMaster.DataViewManager.Clear;   InvalidateNow; end;
procedure TiPlotComponent.RemoveAllLegends;     begin FMaster.LegendManager.Clear;     InvalidateNow; end;
procedure TiPlotComponent.RemoveAllTables;      begin FMaster.TableManager.Clear;      InvalidateNow; end;
procedure TiPlotComponent.RemoveAllToolBars;    begin FMaster.ToolBarManager.Clear;    InvalidateNow; end;
procedure TiPlotComponent.RemoveAllXAxes;       begin FMaster.XAxisManager.Clear;      InvalidateNow; end;
procedure TiPlotComponent.RemoveAllYAxes;       begin FMaster.YAxisManager.Clear;      InvalidateNow; end;
procedure TiPlotComponent.RemoveAllDataCursors; begin FMaster.DataCursorManager.Clear; InvalidateNow; end;
procedure TiPlotComponent.RemoveAllLimits;      begin FMaster.LimitManager.Clear;      InvalidateNow; end;
procedure TiPlotComponent.RemoveAllAnnotations; begin FMaster.AnnotationManager.Clear; InvalidateNow; end;
procedure TiPlotComponent.RemoveAllTranslations;begin FMaster.TranslationManager.Clear;InvalidateNow; end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.RemoveAllLabels;
begin
  while FMaster.LabelManager.Count > 1 do
    Labels[1].Free;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DeleteChannel    (Index:Integer);begin Channel[Index].Free;             InvalidateNow;end;
procedure TiPlotComponent.DeleteDataView   (Index:Integer);begin DataView[Index].Free;            InvalidateNow;end;
procedure TiPlotComponent.DeleteDataCursor (Index:Integer);begin DataCursor[Index].Free;          InvalidateNow;end;
procedure TiPlotComponent.DeleteLegend     (Index:Integer);begin Legend[Index].Free;              InvalidateNow;end;
procedure TiPlotComponent.DeleteTable      (Index:Integer);begin Table[Index].Free;               InvalidateNow;end;
procedure TiPlotComponent.DeleteToolBar    (Index:Integer);begin ToolBar[Index].Free;             InvalidateNow;end;
procedure TiPlotComponent.DeleteXAxis      (Index:Integer);begin XAxis[Index].Free;               InvalidateNow;end;
procedure TiPlotComponent.DeleteYAxis      (Index:Integer);begin YAxis[Index].Free;               InvalidateNow;end;
procedure TiPlotComponent.DeleteLimit      (Index:Integer);begin Limit[Index].Free;               InvalidateNow;end;
procedure TiPlotComponent.DeleteAnnotation (Index:Integer);begin Annotation[Index].Free;          InvalidateNow;end;
procedure TiPlotComponent.DeleteTranslation(Index:Integer);begin TranslationManager.Delete(Index);InvalidateNow;end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DeleteLabel(Index:Integer);
begin
  if Index = 0 then raise Exception.Create('Label Index 0 can not be Deleted (Resevered for Title)');
  Labels[Index].Free;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.ChannelCount    : Integer;begin Result := FMaster.ChannelManager.Count;    end;
function TiPlotComponent.DataViewCount   : Integer;begin Result := FMaster.DataViewManager.Count;   end;
function TiPlotComponent.DataCursorCount : Integer;begin Result := FMaster.DataCursorManager.Count; end;
function TiPlotComponent.LegendCount     : Integer;begin Result := FMaster.LegendManager.Count;     end;
function TiPlotComponent.TableCount      : Integer;begin Result := FMaster.TableManager.Count;      end;
function TiPlotComponent.ToolBarCount    : Integer;begin Result := FMaster.ToolBarManager.Count;    end;
function TiPlotComponent.XAxisCount      : Integer;begin Result := FMaster.XAxisManager.Count;      end;
function TiPlotComponent.YAxisCount      : Integer;begin Result := FMaster.YAxisManager.Count;      end;
function TiPlotComponent.LimitCount      : Integer;begin Result := FMaster.LimitManager.Count;      end;
function TiPlotComponent.LabelCount      : Integer;begin Result := FMaster.LabelManager.Count;      end;
function TiPlotComponent.AnnotationCount : Integer;begin Result := FMaster.AnnotationManager.Count; end;
function TiPlotComponent.TranslationCount: Integer;begin Result := FMaster.TranslationManager.Count;end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetToolBar    (Index:Integer):TiPlotToolBar;          begin Result:=FMaster.ToolBarManager.Items[Index];    end;
function TiPlotComponent.GetLegend     (Index:Integer):TiPlotLegend;           begin Result:=FMaster.LegendManager.Items[Index];     end;
function TiPlotComponent.GetTable      (Index:Integer):TiPlotTable;            begin Result:=FMaster.TableManager.Items[Index];      end;
function TiPlotComponent.GetDataView   (Index:Integer):TiPlotDataView;         begin Result:=FMaster.DataViewManager.Items[Index];   end;
function TiPlotComponent.GetDataCursor (Index:Integer):TiPlotDataCursor;       begin Result:=FMaster.DataCursorManager.Items[Index]; end;
function TiPlotComponent.GetXAxis      (Index:Integer):TiPlotXAxis;            begin Result:=FMaster.XAxisManager.Items[Index];      end;
function TiPlotComponent.GetYAxis      (Index:Integer):TiPlotYAxis;            begin Result:=FMaster.YAxisManager.Items[Index];      end;
function TiPlotComponent.GetChannel    (Index:Integer):TiPlotChannelCustom;    begin Result:=FMaster.ChannelManager.Items[Index];    end;
function TiPlotComponent.GetLimit      (Index:Integer):TiPlotLimit;            begin Result:=FMaster.LimitManager.Items[Index];      end;
function TiPlotComponent.GetLabel      (Index:Integer):TiPlotLabel;            begin Result:=FMaster.LabelManager.Items[Index];      end;
function TiPlotComponent.GetTranslation(Index:Integer):TiPlotTranslationObject;begin Result:=FMaster.TranslationManager.Items[Index];end;
function TiPlotComponent.GetAnnotation (Index:Integer):TiPlotAnnotation;       begin Result:=FMaster.AnnotationManager.Items[Index]; end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetZOrderMaxWidth(Canvas: TCanvas; AList : TStringList; ZOrder : Integer) : Integer;
var
  x            : Integer;
  LayoutObject : TiPlotLayoutObject;
  NewWidth     : Integer;
begin
  Result := 0;
  for x := 0 to AList.Count -1 do
    begin
      LayoutObject := AList.Objects[x] as TiPlotLayoutObject;
      NewWidth := TiPlotLayoutAccess(LayoutObject).GetRequiredWidth(Canvas); //Call to Set Required Width even if not used in Layout
      if LayoutObject is TiPlotAxis then if (LayoutObject as TiPlotAxis).CartesianStyle <> ipcsNone then Continue;

      if LayoutObject.ZOrder = ZOrder then
        begin
          if NewWidth > Result then Result := NewWidth;
        end
    end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetMaxGaurd(Canvas: TCanvas; AList : TStringList; StartGaurd : Boolean) : Integer;
var
  x            : Integer;
  LayoutObject : TiPlotLayoutObject;
  AGaurd       : Integer;
begin
  Result   := 0;
  for x := 0 to AList.Count -1 do
    begin
      LayoutObject := AList.Objects[x] as TiPlotLayoutObject;

      if LayoutObject is TiPlotAxis then if (LayoutObject as TiPlotAxis).CartesianStyle <> ipcsNone then Continue;

      if StartGaurd then
        begin
          if not TiPlotLayoutAccess(LayoutObject).StartStacked then
            begin
              AGaurd := TiPlotLayoutAccess(LayoutObject).GetRequiredLengthGaurd(Canvas);
              if AGaurd > Result then Result := AGaurd;
            end
        end
      else                                                     
        begin
          if not TiPlotLayoutAccess(LayoutObject).StopStacked then
            begin
              AGaurd := TiPlotLayoutAccess(LayoutObject).GetRequiredLengthGaurd(Canvas);
              if AGaurd > Result then Result := AGaurd;
            end
        end
    end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetTotalRequiredWidth(Canvas: TCanvas; AList : TStringList) : Integer;
var
  x             : Integer;
  LayoutObject  : TiPlotLayoutObject;
  CurrentZOrder : Integer;
begin
  Result   := 0;
  CurrentZOrder  := -1;
  for x :=  0 to AList.Count-1 do
    begin
      LayoutObject := AList.Objects[x] as TiPlotLayoutObject;

      if LayoutObject.ZOrder <> CurrentZOrder then
        begin
          CurrentZOrder := LayoutObject.ZOrder;
          Result        := Result + GetZOrderMaxWidth(Canvas, AList, CurrentZOrder);
        end
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.UpdateStacking(AList : TStringList);
var
  x                : Integer;
  LayoutObject     : TiPlotLayoutAccess;
  LastLayoutObject : TiPlotLayoutAccess;
  CurrentZOrder    : Integer;
begin
  CurrentZOrder    := -1;
  LastLayoutObject := nil;
                                     
  for x := 0 to AList.Count-1 do
    begin
      TiPlotLayoutAccess(AList.Objects[x]).StartStacked := False;
      TiPlotLayoutAccess(AList.Objects[x]).StopStacked  := False;
    end;

  for x := 0 to AList.Count-1 do
    begin
      LayoutObject := TiPlotLayoutAccess(AList.Objects[x]);

      if AList.Objects[x] is TiPlotAxis then if (AList.Objects[x] as TiPlotAxis).CartesianStyle <> ipcsNone then Continue;

      if LayoutObject.ForceStacking then
        begin
          LayoutObject.StartStacked := True;
          LayoutObject.StopStacked  := True;
        end
      else
        begin
          if LayoutObject.ZOrder <> CurrentZOrder then
            begin
              CurrentZOrder := LayoutObject.ZOrder;
            end
          else
            begin
              if Assigned(LastLayoutObject) then LastLayoutObject.StopStacked  := True;
                                                 LayoutObject    .StartStacked := True;
            end;
        end;

      LastLayoutObject := LayoutObject;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetAxesTouchesDataView(AList: TStringList; QuadSide: TiQuadSide): Boolean;
var
  x             : Integer;
  ClosestZorder : Integer;
  LayoutObject  : TiPlotLayoutObject;
begin
  Result := False;

  if Alist.Count <> 0 then
    begin
      case QuadSide of
        iqsLeft   : ClosestZorder := (AList.Objects[AList.Count-1] as TiPlotLayoutObject).ZOrder;
        iqsRight  : ClosestZorder := (AList.Objects[0]             as TiPlotLayoutObject).ZOrder;
        iqsTop    : ClosestZorder := (AList.Objects[0]             as TiPlotLayoutObject).ZOrder;
        iqsBottom : ClosestZorder := (AList.Objects[AList.Count-1] as TiPlotLayoutObject).ZOrder;
        else        ClosestZorder := 0;
      end;

      for x := 0 to AList.Count - 1 do
        begin
          LayoutObject := AList.Objects[x] as TiPlotLayoutObject;
          if (LayoutObject.ZOrder = ClosestZorder) then if (LayoutObject is TiPlotAxis) then
            begin
              Result := True;
              Break;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.UpdateVisibleList(AList, VisibleList: TStringList);
var
  x : Integer;
begin
  VisibleList.Clear;
  for x := 0 to AList.Count-1 do
    if (AList.Objects[x] as TiPlotLayoutObject).Visible then
      VisibleList.AddObject('', AList.Objects[x]);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ReCalcLayout;
var
  OffScreenBitmap : Tbitmap;
begin
  OffScreenBitmap         := TBitmap.Create;
  OffScreenBitmap.Width   := Width;
  OffScreenBitmap.Height  := Height;
  try
    iPaintTo(OffScreenBitmap.Canvas);
  finally
    OffScreenBitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.CalcLayout(Canvas: TCanvas);
var
  x                         : Integer;

  AList                     : TStringList;
  iDataView                 : TiPlotDataView;
  Axis                      : TiPlotAxis;
  RefAxis                   : TiPlotAxis;
  AInteger                  : Integer;

  AMax                      : Integer;
  AMin                      : Integer;

  DataViewLeft              : Integer;
  DataViewTop               : Integer;
  DataViewRight             : Integer;
  DataViewBottom            : Integer;

  DataViewWidth             : Integer;
  DataViewHeight            : Integer;

  BorderMargin              : Integer;
  CurrentOffset             : Integer;
  LayoutObject              : TiPlotLayoutObject;
  MaxWidth                  : Integer;
  CurrentZOrder             : Integer;
  GaurdUsed                 : Boolean;

  ObjectsWidthLeft          : Integer;
  ObjectsWidthRight         : Integer;
  ObjectsWidthTop           : Integer;
  ObjectsWidthBottom        : Integer;

  StartGaurdTop             : Integer;
  StartGaurdBottom          : Integer;
  StartGaurdLeft            : Integer;
  StartGaurdRight           : Integer;

  StopGaurdTop              : Integer;
  StopGaurdBottom           : Integer;
  StopGaurdLeft             : Integer;
  StopGaurdRight            : Integer;

  MaxGaurdTop               : Integer;
  MaxGaurdBottom            : Integer;
  MaxGaurdLeft              : Integer;
  MaxGaurdRight             : Integer;

  AxisTopTouchesDataView    : Boolean;
  AxisBottomTouchesDataView : Boolean;
  AxisLeftTouchesDataView   : Boolean;
  AxisRightTouchesDataView  : Boolean;

  SpacingTop                : Integer;
  SpacingBottom             : Integer;
  SpacingLeft               : Integer;
  SpacingRight              : Integer;
begin
  FVisibleListLeft.Clear;
  FVisibleListRight.Clear;
  FVisibleListTop.Clear;
  FVisibleListBottom.Clear;

  UpdateVisibleList(FMaster.LayoutManager.TopList,    FVisibleListTop);
  UpdateVisibleList(FMaster.LayoutManager.BottomList, FVisibleListBottom);
  UpdateVisibleList(FMaster.LayoutManager.LeftList,   FVisibleListLeft);
  UpdateVisibleList(FMaster.LayoutManager.RightList,  FVisibleListRight);

  if BorderStyle <> ibsNone then BorderMargin := 2 else BorderMargin := 0;

  UpdateStacking(FVisibleListTop);
  UpdateStacking(FVisibleListBottom);
  UpdateStacking(FVisibleListLeft);
  UpdateStacking(FVisibleListRight);

  StartGaurdTop      := GetMaxGaurd(Canvas, FVisibleListTop,    True );
  StopGaurdTop       := GetMaxGaurd(Canvas, FVisibleListTop,    False);
  StartGaurdBottom   := GetMaxGaurd(Canvas, FVisibleListBottom, True );
  StopGaurdBottom    := GetMaxGaurd(Canvas, FVisibleListBottom, False);
  StartGaurdLeft     := GetMaxGaurd(Canvas, FVisibleListLeft,   True );
  StopGaurdLeft      := GetMaxGaurd(Canvas, FVisibleListLeft,   False);
  StartGaurdRight    := GetMaxGaurd(Canvas, FVisibleListRight,  True );
  StopGaurdRight     := GetMaxGaurd(Canvas, FVisibleListRight,  False);

  ObjectsWidthLeft   := GetTotalRequiredWidth(Canvas, FVisibleListLeft);
  ObjectsWidthRight  := GetTotalRequiredWidth(Canvas, FVisibleListRight);
  ObjectsWidthTop    := GetTotalRequiredWidth(Canvas, FVisibleListTop);
  ObjectsWidthBottom := GetTotalRequiredWidth(Canvas, FVisibleListBottom);

  AxisTopTouchesDataView    := GetAxesTouchesDataView(FVisibleListTop,    iqsTop);
  AxisBottomTouchesDataView := GetAxesTouchesDataView(FVisibleListBottom, iqsBottom);
  AxisLeftTouchesDataView   := GetAxesTouchesDataView(FVisibleListLeft,   iqsLeft);
  AxisRightTouchesDataView  := GetAxesTouchesDataView(FVisibleListRight,  iqsRight);

                                            MaxGaurdTop    := 0;
  if StopGaurdLeft    > MaxGaurdTop    then MaxGaurdTop    := StopGaurdLeft;
  if StopGaurdRight   > MaxGaurdTop    then MaxGaurdTop    := StopGaurdRight;

                                            MaxGaurdBottom := 0;
  if StartGaurdLeft   > MaxGaurdBottom then MaxGaurdBottom := StartGaurdLeft;
  if StartGaurdRight  > MaxGaurdBottom then MaxGaurdBottom := StartGaurdRight;

                                            MaxGaurdRight  := 0;
  if StopGaurdTop     > MaxGaurdRight  then MaxGaurdRight  := StopGaurdTop;
  if StopGaurdBottom  > MaxGaurdRight  then MaxGaurdRight  := StopGaurdBottom;

                                            MaxGaurdLeft   := 0;
  if StartGaurdTop    > MaxGaurdLeft   then MaxGaurdLeft   := StartGaurdTop;
  if StartGaurdBottom > MaxGaurdLeft   then MaxGaurdLeft   := StartGaurdBottom;

  if MaxGaurdLeft   > ObjectsWidthLeft   then ObjectsWidthLeft   := MaxGaurdLeft;
  if MaxGaurdRight  > ObjectsWidthRight  then ObjectsWidthRight  := MaxGaurdRight;
  if MaxGaurdTop    > ObjectsWidthTop    then ObjectsWidthTop    := MaxGaurdTop;
  if MaxGaurdBottom > ObjectsWidthBottom then ObjectsWidthBottom := MaxGaurdBottom;

  if (FVisibleListTop.Count = 1) and (FVisibleListTop.Objects[0] is TiPlotToolBar) then
    begin
      SpacingTop := ObjectsWidthTop    + BorderMargin + FOuterMarginTop + MaxGaurdTop;
    end
  else
    begin
      SpacingTop    := ObjectsWidthTop    + BorderMargin + FOuterMarginTop;    MaxGaurdTop := 0;
    end;

  SpacingBottom := ObjectsWidthBottom + BorderMargin + FOuterMarginBottom; MaxGaurdBottom := 0;
  SpacingLeft   := ObjectsWidthLeft   + BorderMargin + FOuterMarginLeft;   MaxGaurdLeft   := 0;
  SpacingRight  := ObjectsWidthRight  + BorderMargin + FOuterMarginRight;  MaxGaurdRight  := 0;

  //----------------------------------------------------------------------------
  DataViewLeft   :=          SpacingLeft;
  DataViewRight  := Width -  SpacingRight  - 1;
  DataViewTop    :=          SpacingTop;
  DataViewBottom := Height - SpacingBottom - 1;

  DataViewWidth  := DataViewRight  - DataViewLeft;
  DataViewHeight := DataViewBottom - DataViewTop;
  //----------------------------------------------------------------------------
  AList         := FVisibleListLeft;
  CurrentZOrder := -1;
  MaxWidth      := 0;
  CurrentOffset := DataViewLeft;
  GaurdUsed     := False;

  for x := AList.Count-1 downto 0 do
    begin
      LayoutObject := AList.Objects[x] as TiPlotLayoutObject;

      if (not GaurdUsed) and (not(LayoutObject is TiPlotAxis)) then
        begin
          CurrentOffset := CurrentOffset - MaxGaurdLeft;
          GaurdUsed     := True;
        end;

      if LayoutObject.ZOrder <> CurrentZOrder then
        begin
          CurrentOffset := CurrentOffset - MaxWidth;
          CurrentZOrder := LayoutObject.ZOrder;
          MaxWidth      := GetZOrderMaxWidth(Canvas, AList, CurrentZOrder);
        end;

      TiPlotLayoutAccess(LayoutObject).Left  := CurrentOffset - MaxWidth;
      TiPlotLayoutAccess(LayoutObject).Right := CurrentOffset;
    end;
  //----------------------------------------------------------
  AList         := FVisibleListRight;
  CurrentZOrder := -1;
  MaxWidth      := 0;
  CurrentOffset := DataViewRight;
  GaurdUsed     := False;

  for x :=  0 to AList.Count-1 do
    begin
      LayoutObject := AList.Objects[x] as TiPlotLayoutObject;

      if (not GaurdUsed) and (not(LayoutObject is TiPlotAxis)) then
        begin
          CurrentOffset := CurrentOffset + MaxGaurdRight;
          GaurdUsed     := True;
        end;

      if LayoutObject.ZOrder <> CurrentZOrder then
        begin
          CurrentOffset := CurrentOffset + MaxWidth;
          CurrentZOrder := LayoutObject.ZOrder;
          MaxWidth      := GetZOrderMaxWidth(Canvas, AList, CurrentZOrder);
        end;

      TiPlotLayoutAccess(LayoutObject).Left  := CurrentOffset;
      TiPlotLayoutAccess(LayoutObject).Right := CurrentOffset + MaxWidth
    end;
  //----------------------------------------------------------
  AList         := FVisibleListTop;
  CurrentZOrder := -1;
  MaxWidth      := 0;
  CurrentOffset := DataViewTop;
  GaurdUsed     := False;

  for x := 0 to AList.Count-1 do
    begin
      LayoutObject := AList.Objects[x] as TiPlotLayoutObject;

      if (not GaurdUsed) and (not(LayoutObject is TiPlotAxis)) then
        begin
          CurrentOffset := CurrentOffset - MaxGaurdTop;
          GaurdUsed     := True;
        end;

      if LayoutObject.ZOrder <> CurrentZOrder then
        begin
          CurrentOffset := CurrentOffset - MaxWidth;
          CurrentZOrder := LayoutObject.ZOrder;
          MaxWidth      := GetZOrderMaxWidth(Canvas, AList, CurrentZOrder);
        end;

      TiPlotLayoutAccess(LayoutObject).Top    := CurrentOffset - MaxWidth;
      TiPlotLayoutAccess(LayoutObject).Bottom := CurrentOffset;

      if LayoutObject is TiPlotToolBar then
        begin
          TiPlotLayoutAccess(LayoutObject).Top    := BorderMargin;
          TiPlotLayoutAccess(LayoutObject).Bottom := BorderMargin + TiPlotLayoutAccess(LayoutObject).GetRequiredWidth(Canvas);
        end;
    end;
  //----------------------------------------------------------
  AList         := FVisibleListBottom;
  CurrentZOrder := -1;
  MaxWidth      := 0;
  CurrentOffset := DataViewBottom;
  GaurdUsed     := False;

  for x := AList.Count-1 downto 0 do
    begin
      LayoutObject := AList.Objects[x] as TiPlotLayoutObject;

      if (not GaurdUsed) and (not(LayoutObject is TiPlotAxis)) then
        begin
          CurrentOffset := CurrentOffset + MaxGaurdBottom;
          GaurdUsed     := True;
        end;

      if LayoutObject.ZOrder <> CurrentZOrder then
        begin
          CurrentOffset := CurrentOffset + MaxWidth;
          CurrentZOrder := LayoutObject.ZOrder;
          MaxWidth      := GetZOrderMaxWidth(Canvas, AList, CurrentZOrder);
        end;

      TiPlotLayoutAccess(LayoutObject).Top    := CurrentOffset;
      TiPlotLayoutAccess(LayoutObject).Bottom := CurrentOffset + MaxWidth;
    end;
  //----------------------------------------------------------
  iDataView := FMaster.DataViewManager.Items[0];

  TiPlotLayoutAccess(iDataView).SetDrawRect(Rect(DataViewLeft, DataViewTop, DataViewRight, DataViewBottom));

  for x := 0 to FMaster.LayoutManager.Count - 1 do
    begin
      LayoutObject := FMaster.LayoutManager.Items[x];
      if LayoutObject is TiPlotDataViewLayout then Continue;
      if LayoutObject is TiPlotDataView       then Continue;
      if LayoutObject.IsHorz then
        begin
          if (LayoutObject is TiPlotToolBar) then
            begin
              TiPlotLayoutAccess(LayoutObject).Left  := BorderMargin + Round(LayoutObject.StartPercent/100 * (Width-2*BorderMargin));
              TiPlotLayoutAccess(LayoutObject).Right := BorderMargin + Round(LayoutObject.StopPercent/100  * (Width-2*BorderMargin));
              TiPlotLayoutAccess(LayoutObject).Right := TiPlotLayoutAccess(LayoutObject).Right - 1;
            end
          else if (LayoutObject is TiPlotLegend) then
            begin
              TiPlotLayoutAccess(LayoutObject).Left  := DataViewLeft + Round(LayoutObject.StartPercent/100 * iDataView.Width);
              TiPlotLayoutAccess(LayoutObject).Right := DataViewLeft + Round(LayoutObject.StopPercent/100  * iDataView.Width);
            end
          else if (LayoutObject is TiPlotTable) then
            begin
              TiPlotLayoutAccess(LayoutObject).Left  := DataViewLeft + Round(LayoutObject.StartPercent/100 * iDataView.Width);
              TiPlotLayoutAccess(LayoutObject).Right := DataViewLeft + Round(LayoutObject.StopPercent/100  * iDataView.Width);
            end
          else if (LayoutObject is TiPlotLabel) then
            begin
              TiPlotLayoutAccess(LayoutObject).Left  := BorderMargin + OuterMarginLeft + Round(LayoutObject.StartPercent/100 * (Width-BorderMargin-OuterMarginLeft-OuterMarginRight));
              TiPlotLayoutAccess(LayoutObject).Right := BorderMargin + OuterMarginLeft + Round(LayoutObject.StopPercent/100  * (Width-BorderMargin-OuterMarginLeft-OuterMarginRight));
            end
          else if (LayoutObject is TiPlotAxis) then
            begin
              TiPlotLayoutAccess(LayoutObject).Left  := DataViewLeft + Round(LayoutObject.StartPercent/100 * iDataView.Width);
              TiPlotLayoutAccess(LayoutObject).Right := DataViewLeft + Round(LayoutObject.StopPercent/100  * iDataView.Width);

              //TiPlotAxisAccess(LayoutObject).CalcTicks(Canvas);
            end;
        end
      else
        begin
          if (LayoutObject is TiPlotLegend) then
            begin
              TiPlotLayoutAccess(LayoutObject).Top    := DataViewBottom - Round(LayoutObject.StopPercent /100 * iDataView.Height);
              TiPlotLayoutAccess(LayoutObject).Bottom := DataViewBottom - Round(LayoutObject.StartPercent/100 * iDataView.Height);
            end
          else if (LayoutObject is TiPlotTable) then
            begin
              TiPlotLayoutAccess(LayoutObject).Top    := DataViewBottom - Round(LayoutObject.StopPercent /100 * iDataView.Height);
              TiPlotLayoutAccess(LayoutObject).Bottom := DataViewBottom - Round(LayoutObject.StartPercent/100 * iDataView.Height);
            end
          else if (LayoutObject is TiPlotLabel) then
            begin
              TiPlotLayoutAccess(LayoutObject).Top    := DataViewBottom - Round(LayoutObject.StopPercent /100 * iDataView.Height);
              TiPlotLayoutAccess(LayoutObject).Bottom := DataViewBottom - Round(LayoutObject.StartPercent/100 * iDataView.Height);
            end
          else if (LayoutObject is TiPlotAxis) then
            begin
              TiPlotLayoutAccess(LayoutObject).Top    := DataViewBottom - Round(LayoutObject.StopPercent /100 * iDataView.Height);
              TiPlotLayoutAccess(LayoutObject).Bottom := DataViewBottom - Round(LayoutObject.StartPercent/100 * iDataView.Height);

              //TiPlotAxisAccess(LayoutObject).CalcTicks(Canvas);
            end;
        end;
    end;

  for x := 0 to FMaster.LayoutManager.Count - 1 do
    begin
      if not(FMaster.LayoutManager.Items[x] is TiPlotAxis)                              then Continue;
      if    (FMaster.LayoutManager.Items[x] as TiPlotAxis).CartesianStyle <> ipcsMaster then Continue;

      Axis := FMaster.LayoutManager.Items[x] as TiPlotAxis;

      if Axis.IsHorz then
        begin
          TiPlotLayoutAccess(Axis).Left   := iDataView.DrawRect.Left;
          TiPlotLayoutAccess(Axis).Right  := iDataView.DrawRect.Right;
          TiPlotLayoutAccess(Axis).Top    := (iDataView.DrawRect.Top + iDataView.DrawRect.Bottom) div 2;
          TiPlotLayoutAccess(Axis).Bottom := (iDataView.DrawRect.Top + iDataView.DrawRect.Bottom) div 2;
        end
      else
        begin
          TiPlotLayoutAccess(Axis).Left   := (iDataView.DrawRect.Left + iDataView.DrawRect.Right) div 2;
          TiPlotLayoutAccess(Axis).Right  := (iDataView.DrawRect.Left + iDataView.DrawRect.Right) div 2;
          TiPlotLayoutAccess(Axis).Top    := iDataView.DrawRect.Top;
          TiPlotLayoutAccess(Axis).Bottom := iDataView.DrawRect.Bottom;
        end;
    end;

  for x := 0 to FMaster.LayoutManager.Count - 1 do
    begin
      if not(FMaster.LayoutManager.Items[x] is TiPlotAxis)                             then Continue;
      if    (FMaster.LayoutManager.Items[x] as TiPlotAxis).CartesianStyle <> ipcsChild then Continue;

      Axis := FMaster.LayoutManager.Items[x] as TiPlotAxis;

      RefAxis := TiPlotAxisAccess(Axis).CartesianRefAxis;

      if Assigned(RefAxis) then
        begin
          if Axis.IsHorz then
            begin
              TiPlotLayoutAccess(Axis).Left   := iDataView.DrawRect.Left;
              TiPlotLayoutAccess(Axis).Right  := iDataView.DrawRect.Right;
              TiPlotLayoutAccess(Axis).Top    := RefAxis.PositionToPixels(Axis.CartesianChildRefValue);
              TiPlotLayoutAccess(Axis).Bottom := RefAxis.PositionToPixels(Axis.CartesianChildRefValue);
            end
          else
            begin
              TiPlotLayoutAccess(Axis).Left   := RefAxis.PositionToPixels(Axis.CartesianChildRefValue);
              TiPlotLayoutAccess(Axis).Right  := RefAxis.PositionToPixels(Axis.CartesianChildRefValue);
              TiPlotLayoutAccess(Axis).Top    := iDataView.DrawRect.Top;
              TiPlotLayoutAccess(Axis).Bottom := iDataView.DrawRect.Bottom;
            end;
        end
      else
        begin
          TiPlotLayoutAccess(Axis).Left   := 0;
          TiPlotLayoutAccess(Axis).Right  := 0;
          TiPlotLayoutAccess(Axis).Top    := 0;
          TiPlotLayoutAccess(Axis).Bottom := 0;
        end;
    end;

  for x := 0 to FMaster.LayoutManager.Count - 1 do
    begin
      if not(FMaster.LayoutManager.Items[x] is TiPlotAxis) then Continue;

      Axis    := FMaster.LayoutManager.Items[x] as TiPlotAxis;
      RefAxis := TiPlotAxisAccess(Axis).AlignRefAxis;

      if Assigned(RefAxis) then
        begin
          if Axis.IsHorz then
            begin
              TiPlotLayoutAccess(Axis).Left         := RefAxis.DrawRect.Left;
              TiPlotLayoutAccess(Axis).Right        := RefAxis.DrawRect.Right;
              TiPlotLayoutAccess(Axis).StartStacked := TiPlotLayoutAccess(RefAxis).StartStacked;
              TiPlotLayoutAccess(Axis).StopStacked  := TiPlotLayoutAccess(RefAxis).StopStacked;
            end
          else
            begin
              TiPlotLayoutAccess(Axis).Top          := RefAxis.DrawRect.Top;
              TiPlotLayoutAccess(Axis).Bottom       := RefAxis.DrawRect.Bottom;
              TiPlotLayoutAccess(Axis).StartStacked := TiPlotLayoutAccess(RefAxis).StartStacked;
              TiPlotLayoutAccess(Axis).StopStacked  := TiPlotLayoutAccess(RefAxis).StopStacked;
            end;
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
        end;
    end;

  if not XYAxesReverse then
    begin
      AMin := Height;
      for x := 0 to YAxisCount-1 do
        begin
          Axis := YAxis[x];
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
          if TiPlotAxisAccess(Axis).ScaleRect.Top < AMin then AMin := TiPlotAxisAccess(Axis).ScaleRect.Top;
        end;
      TiPlotLayoutAccess(iDataView).Top := AMin;

      AMax := 0;
      for x := 0 to YAxisCount-1 do
        begin
          Axis := YAxis[x];
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
          if TiPlotAxisAccess(Axis).ScaleRect.Bottom > AMax then AMax := TiPlotAxisAccess(Axis).ScaleRect.Bottom;
        end;
      TiPlotLayoutAccess(iDataView).Bottom := AMax;

      AMin := Width;
      for x := 0 to XAxisCount-1 do
        begin
          Axis := XAxis[x];
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
          if TiPlotAxisAccess(Axis).ScaleRect.Left < AMin then AMin := TiPlotAxisAccess(Axis).ScaleRect.Left;
        end;
      TiPlotLayoutAccess(iDataView).Left := AMin;

      AMax := 0;
      for x := 0 to XAxisCount-1 do
        begin
          Axis := XAxis[x];
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
          if TiPlotAxisAccess(Axis).ScaleRect.Right > AMax then AMax := TiPlotAxisAccess(Axis).ScaleRect.Right;
        end;
      TiPlotLayoutAccess(iDataView).Right := AMax;
    end
  else
    begin
      AMin := Height;
      for x := 0 to XAxisCount-1 do
        begin
          Axis := XAxis[x];
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
          if TiPlotAxisAccess(Axis).ScaleRect.Top < AMin then AMin := TiPlotAxisAccess(Axis).ScaleRect.Top;
        end;
      TiPlotLayoutAccess(iDataView).Top := AMin;

      AMax := 0;
      for x := 0 to XAxisCount-1 do
        begin
          Axis := XAxis[x];
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
          if TiPlotAxisAccess(Axis).ScaleRect.Bottom > AMax then AMax := TiPlotAxisAccess(Axis).ScaleRect.Bottom;
        end;
      TiPlotLayoutAccess(iDataView).Bottom := AMax;

      AMin := Width;
      for x := 0 to YAxisCount-1 do
        begin
          Axis := YAxis[x];
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
          if TiPlotAxisAccess(Axis).ScaleRect.Left < AMin then AMin := TiPlotAxisAccess(Axis).ScaleRect.Left;
        end;
      TiPlotLayoutAccess(iDataView).Left := AMin;

      AMax := 0;
      for x := 0 to YAxisCount-1 do
        begin
          Axis := YAxis[x];
          TiPlotAxisAccess(Axis).CalcScaleRect(Canvas);
          if TiPlotAxisAccess(Axis).ScaleRect.Right > AMax then AMax := TiPlotAxisAccess(Axis).ScaleRect.Right;
        end;
      TiPlotLayoutAccess(iDataView).Right := AMax;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DrawOutSideObjects(Canvas: TCanvas);
var
  x : Integer;
begin
  Canvas.Brush.Color := BackGroundColor;
  Canvas.Brush.Style := bsSolid;

  DrawBorder(Canvas);

  for x := 0 to Master.XAxisManager.Count -1 do
    if TiPlotAxisAccess(Master.XAxisManager.Items[x]).CartesianStyle = ipcsnone then
      TiPlotAxisAccess(Master.XAxisManager.Items[x]).Draw     (Canvas, BackGroundColor);
 
  for x := 0 to Master.YAxisManager.Count -1 do
    if TiPlotAxisAccess(Master.YAxisManager.Items[x]).CartesianStyle = ipcsnone then
      TiPlotAxisAccess(Master.YAxisManager.Items[x]).Draw     (Canvas, BackGroundColor);

  for x := 0 to Master.LabelManager.Count -1 do
    TiPlotLabelAccess(Master.LabelManager.Items[x]).Draw(Canvas, BackGroundColor);

  for x := 0 to Master.ToolBarManager.Count -1 do
    TiPlotToolBarAccess(Master.ToolBarManager.Items[x]).Draw(Canvas, BackGroundColor);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.iPaintTo(Canvas: TCanvas);
var
  x                       : Integer;
  iDataView               : TiPlotDataView;
  HintRect                : TRect;
  iDataCursor             : TiPlotDataCursor;
  DataViewBackgroundColor : TColor;
begin
  FPaintingActive := True;
  try
    if Master.ToolBarManager.Count  = 0 then Exit;
    if Master.LegendManager.Count   = 0 then Exit;
    if Master.DataViewManager.Count = 0 then Exit;

    iDataView := Master.DataViewManager.Items[0];

    if iDataView.BackgroundTransparent then DataViewBackgroundColor := BackGroundColor
    else                                    DataViewBackgroundColor := iDataView.BackgroundColor;

    ClearAxesCollisionList;

    FLayerList.Clear;

    TiPlotLegendAccess(Master.LegendManager.Items[0]).CursorAllChannels := False;
    for x := 0 to Master.DataCursorManager.Count -1 do
      begin
        iDataCursor := Master.DataCursorManager.Items[x];
        TiPlotDataCursorAccess(iDataCursor).DoUpdate;
        if iDataCursor.Visible and (iDataCursor.ChannelName = '<All>') and iDataCursor.ChannelShowAllInLegend then
          TiPlotLegendAccess(Master.LegendManager.Items[0]).CursorAllChannels := True;
      end;
                                        
    //----------------------------------------------------
    for x := 0 to XAxisCount-1 do TiPlotAxisAccess(XAxis[x]).CalcTicks(Canvas);
    for x := 0 to YAxisCount-1 do TiPlotAxisAccess(YAxis[x]).CalcTicks(Canvas);
    //----------------------------------------------------
    CalcLayout(Canvas);
    CalcLayout(Canvas);
    //----------------------------------------------------
    for x := 0 to XAxisCount-1 do TiPlotAxisAccess(XAxis[x]).CalcTicks(Canvas);
    for x := 0 to YAxisCount-1 do TiPlotAxisAccess(YAxis[x]).CalcTicks(Canvas);
    //----------------------------------------------------

    //for x := 0 to Master.DataCursorManager.Count -1 do  //Position may shift after CalcLayout
    //    TiPlotDataCursorAccess(Master.DataCursorManager.Items[x]).DoUpdate;

    for x := 0 to Master.ChannelManager.Count - 1 do
      TiPlotAxisAccess(Master.ChannelManager.Items[x]).DrawSetup(Canvas);

    for x := 0 to Master.XAxisManager.Count - 1 do
      TiPlotAxisAccess(Master.XAxisManager.Items[x]).DrawSetup(Canvas);

    for x := 0 to Master.YAxisManager.Count - 1 do
      TiPlotAxisAccess(Master.YAxisManager.Items[x]).DrawSetup(Canvas);

    for x := 0 to AnnotationCount - 1 do
      begin
        TiPlotAnnotationAccess(Annotation[x]).DataView       := DataView[0];
        TiPlotAnnotationAccess(Annotation[x]).XYAxesReversed := FMaster.XYAxesReverse;
      end;

    for x := 0 to Master.DataCursorManager.Count -1 do
      TiPlotDataCursorAccess(Master.DataCursorManager.Items[x]).DataView := DataView[0];

    if FBackGroundGradientEnabled then
      begin
        {$IFDEF iVCL}
        SelectClipRgn(Canvas.Handle, 0);
        IntersectClipRect(Canvas.Handle, 0, 0, Width, Height);
        {$ENDIF}
        DrawGradientDirection(Canvas, Rect(0, 0 ,Width, Height), FBackGroundGradientDirection, FBackGroundGradientStartColor, FBackGroundGradientStopColor);
        {$IFDEF iVCL}
        SelectClipRgn(Canvas.Handle, 0);
        {$ENDIF}
      end
    else
      begin
        DrawBackGround(Canvas, BackGroundColor);
      end;

    TiPlotDataViewAccess(iDataView).DrawBackground(Canvas);
    //----------------------------------------------------------------------------
    for x := 0 to Master.LimitManager.Count - 1 do
      begin
        if not TiPlotLimitAccess(Master.LimitManager.Items[x]).IsFillType then Continue;
        AddLayerObject(TiPlotObjectAccess(Master.LimitManager.Items[x]).LayerString + 'A', Master.LimitManager.Items[x]);
      end;

    AddLayerObject(TiPlotObjectAccess(iDataView).LayerString + 'B', iDataView);

    for x := 0 to Master.LimitManager.Count - 1 do
      begin
        if TiPlotLimitAccess(Master.LimitManager.Items[x]).IsFillType then Continue;
        AddLayerObject(TiPlotObjectAccess(Master.LimitManager.Items[x]).LayerString + 'C', Master.LimitManager.Items[x]);
      end;
                
    for x := 0 to Master.YAxisManager.Count -1 do
      if TiPlotAxisAccess(Master.YAxisManager.Items[x]).CartesianStyle <> ipcsnone then
        AddLayerObject(TiPlotObjectAccess(YAxis[x]).LayerString + 'D', YAxis[x]);

    for x := 0 to Master.XAxisManager.Count -1 do
      if TiPlotAxisAccess(Master.XAxisManager.Items[x]).CartesianStyle <> ipcsnone then
        AddLayerObject(TiPlotObjectAccess(XAxis[x]).LayerString + 'E', XAxis[x]);

    for x := 0 to Master.ChannelManager.Count - 1 do
      if TiPlotObjectAccess(Master.ChannelManager.Items[x]).CanDraw then
        AddLayerObject(TiPlotObjectAccess(Master.ChannelManager.Items[x]).LayerString + 'F', Master.ChannelManager.Items[x]);

    for x := 0 to AnnotationCount - 1 do
      AddLayerObject(TiPlotObjectAccess(Annotation[x]).LayerString + 'G', Annotation[x]);

    for x := 0 to FLayerList.Count-1 do
      begin                                 
        {$IFDEF iVCL}
        IntersectClipRect(Canvas.Handle, iDataView.DrawRect.Left, iDataView.DrawRect.Top, iDataView.DrawRect.Right+1, iDataView.DrawRect.Bottom+1);
        {$ENDIF}
        try
          TiPlotObjectAccess(FLayerList.Objects[x]).Draw(Canvas, DataViewBackGroundColor);
        finally
          {$IFDEF iVCL}
          SelectClipRgn(Canvas.Handle, 0);
          {$ENDIF}
        end;
      end;

    TiPlotDataViewAccess(iDataView).DrawForeground(Canvas);
    //-----------------------------------------------------------------------------------------------
    DrawOutSideObjects(Canvas);

    for x := 0 to Master.DataCursorManager.Count -1 do
      TiPlotDataCursorAccess(Master.DataCursorManager.Items[x]).Draw(Canvas, DataViewBackGroundColor);

    for x := 0 to Master.LegendManager.Count -1 do
      TiPlotLegendAccess(Master.LegendManager.Items[x]).Draw(Canvas, BackGroundColor);

    for x := 0 to Master.TableManager.Count -1 do
      TiPlotTableAccess(Master.TableManager.Items[x]).Draw(Canvas, BackGroundColor);

    if FHintData.Visible then
      begin
        with Canvas do
          begin
            Font.Assign(FHintsFont);
            Brush.Color := clInfoBk;
            Font.Color  := clInfoText;
            HintRect := Rect(FHintData.Left, FHintData.Top, FHintData.Left + TextWidth(FHintData.Text) + 4, FHintData.Top + TextHeight(FHintData.Text) + 4);
            TextRect(HintRect, FHintData.Left + 2, FHintData.Top + 2, FHintData.Text);
            FHintShowing := True;
          end;
      end
    else FHintShowing := False;
  finally
    FPaintingActive := False;
  end;

  if assigned(FOnAfterPaint) then FOnAfterPaint(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ReadDataViewZHorz (Reader: TReader);begin FMaster.LayoutManager.DataViewHorz.Zorder := Reader.ReadInteger;end;
procedure TiPlotComponent.ReadDataViewZVert (Reader: TReader);begin FMaster.LayoutManager.DataViewVert.Zorder := Reader.ReadInteger;end;
procedure TiPlotComponent.WriteDataViewZHorz(Writer: TWriter);begin Writer.WriteInteger(FMaster.LayoutManager.DataViewHorz.Zorder); end;
procedure TiPlotComponent.WriteDataViewZVert(Writer: TWriter);begin Writer.WriteInteger(FMaster.LayoutManager.DataViewVert.Zorder); end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ReadImageList0(Stream: TStream);
{$IFDEF iVCL}
var
  SA: TStreamAdapter;
{$ENDIF}
begin
 {$IFDEF iVCL}
  FImageList0.Clear;
  SA := TStreamAdapter.Create(Stream);
  try
    FImageList0.Handle := ImageList_Read(SA);
    if FImageList0.Handle = 0 then raise EReadError.Create('Failed to read ImageList data from stream');
  finally
    SA.Free;
  end;
 {$ENDIF}
 {$IFDEF iCLX}
 FImageList0.ReadData(Stream);
 {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ReadImageList1(Stream: TStream);
{$IFDEF iVCL}
var
  SA: TStreamAdapter;
{$ENDIF}
begin
 {$IFDEF iVCL}
  FImageList1.Clear;
  SA := TStreamAdapter.Create(Stream);
  try
    FImageList1.Handle := ImageList_Read(SA);
    if FImageList1.Handle = 0 then raise EReadError.Create('Failed to read ImageList data from stream');
  finally
    SA.Free;
  end;
 {$ENDIF}
 {$IFDEF iCLX}
 FImageList1.ReadData(Stream);
 {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ReadImageList2(Stream: TStream);
{$IFDEF iVCL}
var
  SA: TStreamAdapter;
{$ENDIF}
begin
 {$IFDEF iVCL}
  FImageList2.Clear;
  SA := TStreamAdapter.Create(Stream);
  try
    FImageList2.Handle := ImageList_Read(SA);
    if FImageList2.Handle = 0 then raise EReadError.Create('Failed to read ImageList data from stream');
  finally
    SA.Free;
  end;
 {$ENDIF}
 {$IFDEF iCLX}
 FImageList2.ReadData(Stream);
 {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.WriteImageList0(Stream: TStream);
{$IFDEF iVCL}
var
  SA: TStreamAdapter;
{$ENDIF}
begin
 {$IFDEF iVCL}
  SA := TStreamAdapter.Create(Stream);
  try
    if not ImageList_Write(FImageList0.Handle, SA) then raise EWriteError.Create('Failed to write ImageList data to stream');
  finally
    SA.Free;
  end;
 {$ENDIF}
 {$IFDEF iCLX}
 FImageList0.WriteData(Stream);
 {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.WriteImageList1(Stream: TStream);
{$IFDEF iVCL}
var
  SA: TStreamAdapter;
{$ENDIF}
begin
 {$IFDEF iVCL}
  SA := TStreamAdapter.Create(Stream);
  try
    if not ImageList_Write(FImageList1.Handle, SA) then raise EWriteError.Create('Failed to write ImageList data to stream');
  finally
    SA.Free;
  end;
 {$ENDIF}
 {$IFDEF iCLX}
 FImageList1.WriteData(Stream);
 {$ENDIF}
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.WriteImageList2(Stream: TStream);
{$IFDEF iVCL}
var
  SA: TStreamAdapter;
{$ENDIF}
begin
 {$IFDEF iVCL}
  SA := TStreamAdapter.Create(Stream);
  try
    if not ImageList_Write(FImageList2.Handle, SA) then raise EWriteError.Create('Failed to write ImageList data to stream');
  finally
    SA.Free;
  end;
 {$ENDIF}
 {$IFDEF iCLX}
 FImageList2.WriteData(Stream);
 {$ENDIF}
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetChannelIndexByName   (Value: String): Integer;begin Result := FMaster.ChannelManager.GetIndexByName(Value);   end;
function TiPlotComponent.GetXAxisIndexByName     (Value: String): Integer;begin Result := FMaster.XAxisManager.GetIndexByName(Value);     end;
function TiPlotComponent.GetYAxisIndexByName     (Value: String): Integer;begin Result := FMaster.YAxisManager.GetIndexByName(Value);     end;
function TiPlotComponent.GetAnnotationIndexByName(Value: String): Integer;begin Result := FMaster.AnnotationManager.GetIndexByName(Value);end;
function TiPlotComponent.GetDataCursorIndexByName(Value: String): Integer;begin Result := FMaster.DataCursorManager.GetIndexByName(Value);end;
function TiPlotComponent.GetDataViewIndexByName  (Value: String): Integer;begin Result := FMaster.DataViewManager.GetIndexByName(Value);  end;
function TiPlotComponent.GetLabelIndexByName     (Value: String): Integer;begin Result := FMaster.LabelManager.GetIndexByName(Value);     end;
function TiPlotComponent.GetLegendIndexByName    (Value: String): Integer;begin Result := FMaster.LegendManager.GetIndexByName(Value);    end;
function TiPlotComponent.GetLimitIndexByName     (Value: String): Integer;begin Result := FMaster.LimitManager.GetIndexByName(Value);     end;
function TiPlotComponent.GetTableIndexByName     (Value: String): Integer;begin Result := FMaster.TableManager.GetIndexByName(Value);     end;
function TiPlotComponent.GetToolBarIndexByName   (Value: String): Integer;begin Result := FMaster.ToolBarManager.GetIndexByName(Value);   end;
//****************************************************************************************************************************************************
function TiPlotComponent.FindMouseObject(MouseData: TiPlotMouseData): TiPlotObject;
var
  iPlotObject : TiPlotObject;
  i           : Integer;
begin
  Result := nil;

  for i := 0 to FMaster.ObjectManager.Count-1 do
    begin
      iPlotObject := FMaster.ObjectManager.Items[i];

      if not iPlotObject.Enabled             then Continue;
      if not iPlotObject.Visible             then Continue;
      if not iPlotObject.UserSelected        then Continue;
      if iPlotObject is TiPlotDataViewLayout then Continue;
      if iPlotObject is TiPlotDataView       then Continue;
      if iPlotObject is TiPlotLegend         then Continue;

      if TiPlotObjectAccess(iPlotObject).iMouseHitTest(MouseData) then
        begin
          Result := TiPlotObjectAccess(iPlotObject).GetMouseObject(MouseData.X, MouseData.Y);
          Exit;
        end;
    end;

  for i := 0 to FMaster.ObjectManager.Count-1 do
    begin
      iPlotObject := FMaster.ObjectManager.Items[i];

      if not iPlotObject.Enabled             then Continue;
      if not iPlotObject.Visible             then Continue;
      if iPlotObject is TiPlotDataViewLayout then Continue;
      if iPlotObject is TiPlotDataView       then Continue;
      if iPlotObject is TiPlotLegend         then Continue;

      if TiPlotObjectAccess(iPlotObject).iMouseHitTest(MouseData) then
        begin
          Result := TiPlotObjectAccess(iPlotObject).GetMouseObject(MouseData.X, MouseData.Y);
          Exit;
        end;
    end;

  if Result = nil then
    begin
      for i := 0 to FMaster.ObjectManager.Count-1 do
        begin
          iPlotObject := FMaster.ObjectManager.Items[i];

          if not iPlotObject.Enabled then Continue;
          if not iPlotObject.Visible then Continue;

          if (iPlotObject is TiPlotDataView) or (iPlotObject is TiPlotLegend) then
            begin
              if TiPlotObjectAccess(iPlotObject).iMouseHitTest(MouseData) then
                begin
                  Result := TiPlotObjectAccess(iPlotObject).GetMouseObject(MouseData.X, MouseData.Y);
                  Break;
                end;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ScreenPoint : TPoint;
  MouseData   : TiPlotMouseData;
begin
  FShiftState := Shift;
  FMaster.ObjectManager.SetShiftState(Shift);
  FMouseDown := True;

  MouseData.X      := X;
  MouseData.Y      := Y;
  MouseData.Button := Button;
  UpdateAxisPixels(MouseData);

  iSetFocus(Self);
  KillHint;

  ScreenPoint := ClientToScreen(Point(X, Y));

  if Button = mbRight then FMaster.ObjectManager.ClearAllUserSelections;

  FMouseDownObject      := FindMouseObject(MouseData);
  FLastMouseClickObject := nil;

  if Assigned(FMouseDownObject) then
    begin
      if (ssShift in Shift) then
        begin
          if FMouseDownObject is TiPlotAxis then
            begin
              FSelectingActive := True;
              TiPlotObjectAccess(FMouseDownObject).SetUserSelected(True);
            end
          else
            begin
              FSelectingActive := False;
              FMouseDownObject.UserSelected := True;
            end;
        end
      else if (ssCtrl in Shift) then
        begin
          if FMouseDownObject is TiPlotAxis then
            begin
              FSelectingActive := True;
              FMouseDownObject.UserSelected := not FMouseDownObject.UserSelected;
            end
          else
            begin
              FSelectingActive := False;
              FMouseDownObject.UserSelected := True;
            end;
        end
      else
        begin
          if not(FMouseDownObject is TiPlotToolBar) and FMouseDownObject.CanFocus then FMouseDownObject.UserSelected := True;
        end;

      if Button = mbRight then SetCapture(Handle);

      if (Button = mbRight) or (FMouseDownObject is TiPlotAnnotation)    or
                               (FMouseDownObject is TiPlotLegendButton)  or
                               (FMouseDownObject is TiPlotTableButton)   or
                               (FMouseDownObject is TiPlotToolBarButton) or
                               (FMouseDownObject is TiPlotLimit)         or
                               (not FMouseDownObject.CanFocus) then
        TiPlotObjectAccess(FMouseDownObject).iMouseDown(Button, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FPopupMenu)
      else
        FMaster.ObjectManager.MouseDownFocusObjects(Button, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FPopupMenu);
    end
  else FMaster.ObjectManager.ClearAllUserSelections;

  FMouseDown := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  iPlotObject   : TiPlotObject;
  ScreenPoint   : TPoint;
  NewHintData   : TiHintData;
  MouseData     : TiPlotMouseData;
begin
try
  if (csDesigning in ComponentState) then exit;
  if FSelectingActive                then exit;

  {$ifdef iVCL}
  if not PtInRect(Rect(0, 0 , Width, Height), Point(X, Y)) then
    begin
      if not FMouseDown then if GetCapture = Handle then ReleaseCapture;
    end;
  {$endif}

  FShiftState := Shift;
  FMaster.ObjectManager.SetShiftState(Shift);

  MouseData.X := X;
  MouseData.Y := Y;
  UpdateAxisPixels(MouseData);

  ScreenPoint := ClientToScreen(Point(X, Y));

  //KillHint;

  if ((ssLeft in Shift) or (ssRight in Shift)) and Assigned(FMouseDownObject) then
    begin
      if (FMouseDownObject is TiPlotAnnotation) or (FMouseDownObject is TiPlotToolBar) or (not FMouseDownObject.CanFocus) then
        TiPlotObjectAccess(FMouseDownObject).iMouseMove(NewHintData, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FDBLClickActive)
      else
        FMaster.ObjectManager.MouseMoveFocusObjects(NewHintData, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FDBLClickActive);
      Cursor := crDefault;
    end
  else
    begin
      if Assigned(FMouseDownObject) then TiPlotObjectAccess(FMouseDownObject).iMouseUp(mbLeft, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FDBLClickActive, FPopupMenu);
      if Assigned(FMaster)          then FMaster.ObjectManager.MouseUpFocusObjects(mbLeft, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FDBLClickActive, FPopupMenu);

      iPlotObject := FindMouseObject(MouseData);

      if Assigned(FLastMouseOverObject) then
        begin
          if FLastMouseOverObject <> iPlotObject then TiPlotObjectAccess(FLastMouseOverObject).DoMouseNotOver;
          FLastMouseOverObject := nil;
        end;

      if not Assigned(iPlotObject) then
        begin
          Cursor := crDefault;
          Exit;
        end;

      Cursor := TiPlotObjectAccess(iPlotObject).GetMousePointer(Point(X, Y));
      {$ifdef iVCL}
      Windows.SetCursor(Screen.Cursors[Cursor]);
      {$endif}

      NewHintData.Text := '';
      TiPlotObjectAccess(iPlotObject).iMouseMove(NewHintData, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FDBLClickActive);

      if FHintsShow then
        begin
          FHintData.Text := NewHintData.Text;
          if not FHintData.Visible then
            begin
              FHintData.Left := NewHintData.Left;
              FHintData.Top  := NewHintData.Top;
            end;

          if FMouseDown then
            begin
              KillHint;
            end
          else if FHintData.Text = '' then
            begin
              KillHint;
              FLastHintObject := nil;
              FLastHintShowRect := Rect (0, 0, 0, 0);
            end
          else if (FLastHintObject <> nil) and (iPlotObject <> FLastHintObject) and not(FLastHintObject is TiPlotToolBarButton) then
            begin
              KillHint;
              FLastHintObject := nil;
            end
          else if TimerRunning and not FHintData.Visible then
            begin
              TimerStop;
              TimerStart(0, FHintsPause);
            end
          else if TimerRunning and FHintData.Visible and ((FLastHintObject is TiPlotToolBarButton) or (FLastHintObject is TiPlotChannelCustom)) then
            begin
              TimerStop;
              TimerStart(0, FHintsHidePause);
            end
          else if TimerRunning and FHintData.Visible and not (FLastHintObject is TiPlotToolBarButton) then
            begin
              KillHint;
            end
          else if (not TimerRunning) and (not PtInRect(FLastHintShowRect, Point(X, Y))) and (iPlotObject <> FLastHintObject) then
            begin
              FLastHintX      := X;
              FLastHintY      := Y;
              FLastHintObject := iPlotObject;
              TimerStop;
              TimerStart(0, FHintsPause);
            end;

          if FHintData.Visible then InvalidateNow;
        end;

       FLastMouseOverObject := iPlotObject;
    end;
except
  on exception do;
end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.iMouseWheel(WheelDelta: Integer; Shift: TShiftState; const MousePos: TPoint): Boolean;
begin
  FMaster.ObjectManager.MouseWheelFocusObjects(WheelDelta, Shift, MousePos);
  Result := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ScreenPoint : TPoint;
begin
  if (csDesigning in ComponentState) then exit;

  FMouseDown := False;
  FShiftState := Shift;
  if not Assigned(FMaster) then Exit;
  FMaster.ObjectManager.SetShiftState(Shift);

  KillHint;

  FSelectingActive := False;
  ScreenPoint := ClientToScreen(Point(X, Y));

  if Assigned(FMouseDownObject) then TiPlotObjectAccess(FMouseDownObject).iMouseUp(Button, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FDBLClickActive, FPopupMenu);
  if Assigned(FMaster)          then FMaster.ObjectManager.MouseUpFocusObjects(Button, Shift, X, Y, ScreenPoint.X, ScreenPoint.Y, FDBLClickActive, FPopupMenu);

  FLastMouseClickObject           := FMouseDownObject;
  FLastMouseClickButton           := Button;
  FLastMouseClickShift            := Shift;
  FLastMouseClickX                := X;
  FLastMouseClickY                := Y;
  FLastMouseClickScreenX          := ScreenPoint.X;
  FLastMouseClickScreenY          := ScreenPoint.Y;

  FMouseDownObject := nil;
  FDBLClickActive  := False;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.iDoubleClick;
begin
  FDBLClickActive := True;
//  FBlockNextClick := True;
//  if Assigned(FLastMouseClickObject) then TiPlotObjectAccess(FLastMouseClickObject).iDoubleClick(FLastMouseClickButton, FLastMouseClickShift, FLastMouseClickX, FLastMouseClickY, FLastMouseClickScreenX, FLastMouseClickScreenY);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.HintTimer(Sender: TObject);
begin
  TimerStop;
  if not FHintData.Visible then
    begin
      FHintData.Visible := True;
      FLastHintShowRect := Rect(FLastHintX - 3, FLastHintY - 3, FLastHintX + 3, FLastHintY + 3);
      TimerStart(0, FHintsHidePause);
      {$ifdef iVCL}
      if GetCapture <> Handle then SetCapture(Handle);
     {$endif}
    end
  else
    begin
      KillHint;
      {$ifdef iVCL}
      if GetCapture = Handle then ReleaseCapture;
     {$endif}
    end;
  InvalidateNow;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.KillHint;
begin
  TimerStop;
  FHintData.Visible := False;
  if FHintShowing then InvalidateNow;
end;
//****************************************************************************************************************************************************
{$ifdef iVCL}
procedure TiPlotComponent.WMCaptureChanged(var Message: TMessage);
begin
  FCaptureWindowHandle := Message.LParam;
  if FCaptureWindowHandle <> Handle then
    begin
      KillHint;
      FJustReleasedCapture := True;
      if FHintShowing then InvalidateNow;
      if Assigned(FLastMouseOverObject) then
        begin
          TiPlotObjectAccess(FLastMouseOverObject).DoMouseNotOver;
          FLastMouseOverObject := nil;
        end;
    end;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiPlotComponent.iWantSpecialKey(var CharCode: Word; var Result: Longint);
begin
  if CharCode in [VK_LEFT, VK_DOWN, VK_RIGHT, VK_UP] then Result := 1 else Result := 0;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.iKeyDown(var CharCode: Word; Shift: TShiftState);
begin
  FMaster.ObjectManager.KeyDownFocusObjects(CharCode, Shift, FPopupMenu);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.CopyToClipBoard;
{$ifdef iVCL}
var
  MetaFileCanvas    : TMetaFileCanvas;
  ToolBarWasVisible : Boolean;
  JPeg              : TJPEGImage;
  Bitmap            : TBitmap;
  Image             : TImage;
{$endif}
begin
  {$ifdef iVCL}
  BeginUpdate;
  try
    ToolBarWasVisible := FMaster.ToolBarManager.Items[0].Visible;
    FMaster.ShowToolBars(False);
    try
      FMaster.DeSelectAll;
      case FCopyToClipBoardFormat of
        ipefMetaFile : begin
                         if not Assigned(FMetaFile) then FMetaFile := TMetaFile.Create;
                         FMetaFile.Width  := Width;
                         FMetaFile.Height := Height;

                         MetaFileCanvas := TMetafileCanvas.CreateWithComment(FMetaFile, 0, 'Iocomp', 'Strip Chart');
                         try
                           iPaintTo(MetaFileCanvas);

                           {$IFDEF EVAL}
                           with MetaFileCanvas do
                             begin
                               Brush.Color := clBlack;
                               Font.Color  := clYellow;
                               Font.Style  := [fsBold];
                               TextOut(0,0, 'Iocomp Evaluation');
                             end;
                           {$ENDIF}

                         finally
                           MetaFileCanvas.Free;
                         end;
                         Clipboard.Assign(FMetaFile);
                       end;
        ipefBitmap   : begin
                         Bitmap := TBitmap.Create;
                         Bitmap.Width  := Width;
                         Bitmap.Height := Height;
                         try
                           iPaintTo(Bitmap.Canvas);

                           {$IFDEF EVAL}
                           with Bitmap.Canvas do
                             begin
                               Brush.Color := clBlack;
                               Font.Color  := clYellow;
                               Font.Style  := [fsBold];
                               TextOut(0,0, 'Iocomp Evaluation');
                             end;
                           {$ENDIF}

                           Clipboard.Assign(Bitmap);
                         finally
                           Bitmap.Free;
                         end;
                       end;
        ipefJPEG     : begin
                         TPicture.RegisterClipboardFormat(87, TJPEGImage);
                         JPeg := GetJPEG(100, False);
                         if Assigned(JPeg) then
                           begin
                             Image := TImage.Create(nil);
                             try
                               Image.Picture.Assign(JPeg);
                               Clipboard.Assign(Image.Picture);
                             finally
                               Image.Free;
                             end;
                             JPeg.Free;
                           end;
                       end;
      end;
    finally
      FMaster.ShowToolBars(ToolBarWasVisible);
    end
  finally
    EndUpdate;
  end;
  {$endif}
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetSnapShotPicture: TPicture;
{$ifdef iVCL}
var
  MetaFileCanvas : TMetaFileCanvas;
{$endif}
begin
  {$ifdef iVCL}
  if not Assigned(FSnapShotPicture) then FSnapShotPicture := TPicture.Create;
  if not Assigned(FMetaFile)        then FMetaFile        := TMetaFile.Create;

  FMetaFile.Width  := Width;
  FMetaFile.Height := Height;

  MetaFileCanvas := TMetafileCanvas.CreateWithComment(FMetaFile, 0, 'Iocomp', 'iPlot');
  try
    iPaintTo(MetaFileCanvas);
  finally
    MetaFileCanvas.Free;
  end;

  FSnapShotPicture.Graphic := FMetaFile;
  Result                   := FSnapShotPicture;
  {$endif}
  {$ifdef iCLX}Result := nil;{$endif}
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.PrintSizeToFillPage;
var
  ASizeRatio : Double;
begin
  ASizeRatio := PrinterPaperHeightInches/PrinterPaperWidthInches;
  Height     := Trunc(ASizeRatio*Width);
  ReCalcLayout;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.PrintAdjustXSpanToMinutesPerMillimeter(MinutesPerMillimeter: Double);
const
  MINUTESPERDAY = 24*60;
var
  AInnerHeightInches : Double;
  AAxisLengthPixels  : Integer;
  AAxisLengthInches  : Double;
  AAxisLengthMM      : Double;
begin
  ReCalcLayout;

  AInnerHeightInches := PrinterPaperHeightInches - PrintMarginTop - PrintMarginBottom;
  AAxisLengthPixels  := Abs(XAxis[0].MaxPixels - XAxis[0].MinPixels);
  AAxisLengthInches  := AInnerHeightInches * AAxisLengthPixels/Height;
  AAxisLengthMM      := AAxisLengthInches * 25.4;

  XAxis[0].Span := (AAxisLengthMM*MinutesPerMillimeter)/MINUTESPERDAY;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.PrintChart;
{$ifdef iVCL}
var
  PrintDialog : TPrintDialog;
{$endif}
begin
  try
    if Printer.Printing then Printer.EndDoc;

    Printer.Orientation := FPrintOrientation;
    Printer.Title       := FPrintDocumentName;
    if FPrintShowDialog then
      begin
        {$ifdef iVCL}
        PrintDialog := TPrintDialog.Create(Self);
        try
          if not PrintDialog.Execute then exit;
        finally
          PrintDialog.Free;
        end;
        {$endif}
        {$ifdef iCLX}
        if not (Printer.PrintAdapter as TQPrintAdapter).ExecuteSetup then Exit;
        {$endif}
      end;

    BeginUpdate;
    try
      FPrintXStart := XAxis[0].Min;
      FPrintXStop  := XAxis[0].Max;
      DoPrintChart;
    finally
      EndUpdate;
    end;
  except
    on E: Exception do raise Exception.Create('Error Printing : ' + e.Message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.PreviewChart;
begin
  iPlotPreviewForm := TiPlotPreviewForm.Create(Application);
  try
    iPlotPreviewForm.iComponent        := Self;
    iPlotPreviewForm.PrintMarginLeft   := PrintMarginLeft;
    iPlotPreviewForm.PrintMarginRight  := PrintMarginRight;
    iPlotPreviewForm.PrintMarginTop    := PrintMarginTop;
    iPlotPreviewForm.PrintMarginBottom := PrintMarginBottom;
    iPlotPreviewForm.PrintOrientation  := PrintOrientation;
    iPlotPreviewForm.PrintDocumentName := PrintDocumentName;
    iPlotPreviewForm.Caption           := PrintDocumentName + ' (Preview)';
    iPlotPreviewForm.DoTranslation;
    iPlotPreviewForm.ShowModal;
  finally
    iPlotPreviewForm.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoPrintChart;
var
  AScaleX            : Double;
  AScaleY            : Double;
  AXPixelsPerInch    : Integer;
  AYPixelsPerInch    : Integer;
  AXOffset           : Integer;
  AYOffset           : Integer;
  AMaxZoom           : Double;
  AToolBarWasVisible : Boolean;
  ARect              : TRect;

  AOldXAxisMin       : Double;
  AOldXAxisSpan      : Double;
  AOldWidth          : Integer;
  AOldHeight         : Integer;

  AOldMarginLeft     : Integer;
  AOldMarginRight    : Integer;
  AOldMarginTop      : Integer;
  AOldMarginBottom   : Integer;

  APageIndex         : Integer;
  {$ifdef iVCL}
  AIndex             : Integer;
  {$endif}
begin
  if Trim(FPrinterName) <> '' then
    begin
      {$ifdef iVCL}
      AIndex := Printer.Printers.IndexOf(FPrinterName);                
      if AIndex <> - 1 then Printer.PrinterIndex := AIndex;
      {$endif}
      {$ifdef iCLX}
      Printer.SetPrinter(FPrinterName);
      {$endif}
    end;

  GetPrinterPaperSize(FPrinterPaperWidthInches, FPrinterPaperHeightInches);

  FPrinterPaperWidthCentimeters  := FPrinterPaperWidthInches *2.54;
  FPrinterPaperHeightCentimeters := FPrinterPaperHeightInches*2.54;

  {$ifdef iVCL}
  AXPixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  AYPixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  AXOffset        := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX);
  AYOffset        := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY);
  {$endif}

  {$ifdef iCLX}
  AXPixelsPerInch := Round(Printer.PageWidth / FPrinterPaperWidthInches);
  AYPixelsPerInch := Round(Printer.PageHeight/ FPrinterPaperHeightInches);
  AXOffset        := 0;
  AYOffset        := 0;
  {$endif}

  FPrinterPaperWidthPixels  := Round(FPrinterPaperWidthInches  * AXPixelsPerInch);
  FPrinterPaperHeightPixels := Round(FPrinterPaperHeightInches * AYPixelsPerInch);

  Printer.BeginDoc;
  try
    AToolBarWasVisible := FMaster.ToolBarManager.Items[0].Visible;
    AOldXAxisMin       := XAxis[0].Min;
    AOldXAxisSpan      := XAxis[0].Span;
    AOldWidth          := Width;
    AOldHeight         := Height;

    AOldMarginLeft     := OuterMarginLeft;
    AOldMarginRight    := OuterMarginRight;
    AOldMarginTop      := OuterMarginTop;
    AOldMarginBottom   := OuterMarginBottom;

    try
      FMaster.DeSelectAll;
      FMaster.ShowToolBars(False);

      if Assigned(FOnBeforePrint) then FOnBeforePrint(Self);

      APageIndex  := 1;

      XAxis[0].Min := PrintXStart;

      while XAxis[0].Min < FPrintXStop do
        begin
          if Assigned(FOnBeforePrintPage) then FOnBeforePrintPage(APageIndex, XAxis[0].Max >= FPrintXStop);

          AScaleX := (FPrinterPaperWidthPixels  - (FPrintMarginLeft + FPrintMarginRight )*AXPixelsPerInch)/Width;
          AScaleY := (FPrinterPaperHeightPixels - (FPrintMarginTop  + FPrintMarginBottom)*AYPixelsPerInch)/Height;

          if AScaleX < AScaleY then AMaxZoom := AScaleX
          else                      AMaxZoom := AScaleY;

          ARect := Rect(Round(FPrintMarginLeft*AXPixelsPerInch - AXOffset                  ),
                        Round(FPrintMarginTop *AYPixelsPerInch - AYOffset                  ),
                        Round(FPrintMarginLeft*AXPixelsPerInch - AXOffset + AMaxZoom*Width ),
                        Round(FPrintMarginTop *AYPixelsPerInch - AYOffset + AMaxZoom*Height));

          ReCalcLayout();

          DoPrintPage(ARect);

          if XAxis[0].Min + XAxis[0].Span <= XAxis[0].Min then Break;
          if XAxis[0].Max >= FPrintXStop                  then Break
          else                                                 Printer.NewPage;

          APageIndex   := APageIndex + 1;
          XAxis[0].Min := XAxis[0].Min + XAxis[0].Span;
        end;

      if Assigned(FOnAfterPrint) then FOnAfterPrint(Self);
    finally
      FMaster.ShowToolBars(AToolBarWasVisible);
      XAxis[0].Min  := AOldXAxisMin;
      XAxis[0].Span := AOldXAxisSpan;
      Width         := AOldWidth;
      Height        := AOldHeight;

      OuterMarginLeft   := AOldMarginLeft;
      OuterMarginRight  := AOldMarginRight;
      OuterMarginTop    := AOldMarginTop;
      OuterMarginBottom := AOldMarginBottom;
    end;
  finally
    Printer.EndDoc;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoPrintPage(ARect: TRect);
var
  {$ifdef iVCL}
  AMetaFile       : TMetaFile;
  AMetaFileCanvas : TMetaFileCanvas;
  {$endif}
  {$ifdef iCLX}
  ABitmap         : TBitmap;
  {$endif}
begin
  {$ifdef iVCL}
  AMetaFile := TMetaFile.Create;
  try
    AMetaFile.Width    := Width;
    AMetaFile.Height   := Height;
    AMetaFile.Enhanced := True;

    AMetaFileCanvas := TMetafileCanvas.CreateWithComment(AMetaFile, 0, 'Iocomp', '');
    try
      iPaintTo(AMetaFileCanvas);
    finally
      AMetaFileCanvas.Free;
    end;

    PlayEnhMetaFile(Printer.Canvas.Handle, AMetaFile.Handle, ARect);
  finally
    AMetaFile.Free;
  end;
  {$endif}

  {$ifdef iCLX}
  ABitmap := TBitmap.Create;
  try
    ABitmap.Width  := Width;
    ABitmap.Height := Height;
    iPaintTo(ABitmap.Canvas);

    Printer.PrintAdapter.Canvas.StretchDraw(ARect, ABitmap);
  finally
    ABitmap.Free;
  end;
 {$endif}
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.Save;
var
  Ext : String;
begin
  if not Assigned(FSaveDialog) then FSaveDialog := TiComponentEditorSavePicker.Create(Self);

  FSaveDialog.Visible := False;
  FSaveDialog.Parent := Self;

  {$ifdef iVCL} FSaveDialog.Filter   := 'Bitmap (*.bmp)|*.bmp|Enhanced Metafile (*.emf)|*.emf|JPEG File (*.jpg)|*.jpg|PNG (*.png)|*.png';{$endif}
  {$ifdef iCLX} FSaveDialog.Filter   := 'Bitmap (*.bmp)|*.bmp|JPEG File (*.jpg)|*.jpg|PNG (*.png)|*.png';                                {$endif}

  FSaveDialog.FileName := 'Untitled';
  if not FSaveDialog.Execute then exit;

  FMaster.DeSelectAll;

  Ext := Copy(FSaveDialog.FileName, Length(FSaveDialog.FileName) - 2, 3);
                if      Ext = 'bmp' then SaveImageToBitmap  (FSaveDialog.FileName)
  {$ifdef iVCL} else if Ext = 'emf' then SaveImageToMetaFile(FSaveDialog.FileName)            {$endif}
                else if Ext = 'jpg' then SaveImageToJPEG    (FSaveDialog.FileName, 100, True)
                else if Ext = 'png' then SaveImageToPNG     (FSaveDialog.FileName,   9      )
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ClearAllData;
begin
  if FLoggingActive then LogDeactivate;
  FMaster.ClearAllData;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MousePointerSet(ACursor: TCursor);
begin
  Cursor := ACursor;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DisableAllTracking;
var
  x : Integer;
begin
  for x := 0 to XAxisCount-1 do
    XAxis[x].TrackingEnabled := False;
  for x := 0 to YAxisCount-1 do
    YAxis[x].TrackingEnabled := False;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.EnableAllTracking;
var
  x : Integer;
begin
  for x := 0 to XAxisCount-1 do
    XAxis[x].TrackingEnabled := True;
  for x := 0 to YAxisCount-1 do
    YAxis[x].TrackingEnabled := True;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.AddDataArray(XValue: Double; Data: Variant);
var
  LowBoundDim1  : Integer;            //Real  (Data > 1E-300)
  LowBoundDim2  : Integer;            //Null  (Data < 1E-300) and (Data > 1E-301)
  HighBoundDim1 : Integer;            //Empty (Data < 1E-301) and (Data > 1E-302)
  HighBoundDim2 : Integer;
  ChannelIndex  : Integer;
  DataIndex     : Integer;
  ActualX       : Double;
  DataY         : Double;
begin
  if VarArrayDimCount(Data) = 1 then
    begin
      LowBoundDim1  := VarArrayLowBound (Data, 1);
      HighBoundDim1 := VarArrayHighBound(Data, 1);

      for DataIndex := LowBoundDim1 to HighBoundDim1 do
        begin
          ActualX := XValue;
          DataY   := Data[DataIndex];
          ChannelIndex := DataIndex - LowBoundDim1;
          if ValueIsNull(DataY) then
            begin
              if      Channel[ChannelIndex] is TiPlotChannel   then (Channel[ChannelIndex] as TiPlotChannel  ).AddXNull(ActualX)
              else if Channel[ChannelIndex] is TiXYPlotChannel then (Channel[ChannelIndex] as TiXYPlotChannel).AddNull;
            end
          else if ValueIsEmpty(DataY) then
            begin
              if      Channel[ChannelIndex] is TiPlotChannel   then (Channel[ChannelIndex] as TiPlotChannel  ).AddXEmpty(ActualX)
              else if Channel[ChannelIndex] is TiXYPlotChannel then (Channel[ChannelIndex] as TiXYPlotChannel).AddEmpty;
            end
          else Channel[ChannelIndex].AddXY(ActualX, DataY);
        end;
      FLogBufferCount := FLogBufferCount + 1;
    end
  else if VarArrayDimCount(Data) = 2 then
    begin
      LowBoundDim1  := VarArrayLowBound (Data, 1);
      LowBoundDim2  := VarArrayLowBound (Data, 2);
      HighBoundDim1 := VarArrayHighBound(Data, 1);
      HighBoundDim2 := VarArrayHighBound(Data, 2);

      for DataIndex := LowBoundDim2 to HighBoundDim2 do
        begin
          for ChannelIndex := LowBoundDim1 to HighBoundDim1 do
            begin
              if Channel[ChannelIndex].Count = 0 then
                ActualX := 0
              else
                ActualX := Channel[ChannelIndex].DataX[Channel[ChannelIndex].Count-1]+XValue;

              Channel[ChannelIndex].AddXY(ActualX, Data[ChannelIndex, DataIndex]);
            end
        end;
      FLogBufferCount := FLogBufferCount + (HighBoundDim2 - LowBoundDim2);
    end
  else raise Exception.Create('Data Array must be 1 or 2 Dimensions');

  if FLoggingActive then
    begin
      if FLogBufferCount >= FLogBufferSize then WriteLog;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetNow: Double;
begin
  Result := Now;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SavePropertiesToFile(FileName: String);
var
  x          : Integer;
  AList      : TStringList;
  IgnoreList : TStringList;
begin
  try
  AList := TStringList.Create;
  try
    IgnoreList := TStringList.Create;
  try
    IgnoreList.Add('Name');
    if not OptionSaveAllProperties then
      begin
        IgnoreList.Add('Left');
        IgnoreList.Add('Top');
        IgnoreList.Add('Width');
        IgnoreList.Add('Height');
        IgnoreList.Add('Align');
        IgnoreList.Add('Cursor');
        IgnoreList.Add('ShowHint');
        IgnoreList.Add('Tag');
        IgnoreList.Add('Visible');
        IgnoreList.Add('Enabled');
        IgnoreList.Add('Hint');
        IgnoreList.Add('HelpContext');
        IgnoreList.Add('HelpKeyword');
      end;

    AList.Add('File Type = Plot Config');

    AList.Add('ChannelCount = '    + IntToStr(ChannelCount));
    AList.Add('XAxisCount = '      + IntToStr(XAxisCount));
    AList.Add('YAxisCount = '      + IntToStr(YAxisCount));
    AList.Add('ToolBarCount = '    + IntToStr(ToolBarCount));
    AList.Add('LegendCount = '     + IntToStr(LegendCount));
    AList.Add('TableCount = '      + IntToStr(TableCount));
    AList.Add('LabelCount = '      + IntToStr(LabelCount));
    AList.Add('DataViewCount = '   + IntToStr(DataViewCount));
    AList.Add('DataCursorCount = ' + IntToStr(DataCursorCount));
    AList.Add('LimitCount = '      + IntToStr(LimitCount));

    AList.Add('DataViewZHorz = ' + IntToStr(DataViewZHorz));
    AList.Add('DataViewZVert = ' + IntToStr(DataViewZVert));

    for x := 0 to ChannelCount-1    do SaveObjectToStringList(Channel[x],    'Channel'    + IntToStr(x), AList, nil);
    for x := 0 to XAxisCount-1      do SaveObjectToStringList(XAxis[x],      'XAxis'      + IntToStr(x), AList, nil);
    for x := 0 to YAxisCount-1      do SaveObjectToStringList(YAxis[x],      'YAxis'      + IntToStr(x), AList, nil);
    for x := 0 to ToolBarCount-1    do SaveObjectToStringList(ToolBar[x],    'ToolBar'    + IntToStr(x), AList, nil);
    for x := 0 to LegendCount-1     do SaveObjectToStringList(Legend[x],     'Legend'     + IntToStr(x), AList, nil);
    for x := 0 to TableCount-1      do SaveObjectToStringList(Table[x],      'Table'      + IntToStr(x), AList, nil);
    for x := 0 to LabelCount-1      do SaveObjectToStringList(Labels[x],     'Label'      + IntToStr(x), AList, nil);
    for x := 0 to DataViewCount-1   do SaveObjectToStringList(DataView[x],   'DataView'   + IntToStr(x), AList, nil);
    for x := 0 to DataCursorCount-1 do SaveObjectToStringList(DataCursor[x], 'DataCursor' + IntToStr(x), AList, nil);
    for x := 0 to LimitCount-1      do SaveObjectToStringList(Limit[x],      'Limit'      + IntToStr(x), AList, nil);

    SaveObjectToStringList(Self, '', AList, IgnoreList);

    AList.SaveToFile(FileName);

    FLastPropertiesFileName := FileName;
    if Assigned(FOnAfterSaveProperties) then FOnAfterSaveProperties(Self);
  finally
    IgnoreList.Free;
  end;
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Saving Properties - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LoadPropertiesFromFile(FileName: String);
var
  x       : Integer;
  AList   : TStringList;
  AString : String;
  Found   : Boolean;

  ACountChannels    : Integer;
  ACountXAxes       : Integer;
  ACountYAxes       : Integer;
  ACountToolBars    : Integer;
  ACountLegends     : Integer;
  ACountTables      : Integer;
  ACountLabels      : Integer;
  ACountDataViews   : Integer;
  ACountDataCursors : Integer;
  ACountLimits      : Integer;

begin
  if Assigned(FOnBeforeLoadProperties) then FOnBeforeLoadProperties(Self);
  try
  AList := TStringList.Create;
  try
    AList.LoadFromFile(FileName);

    Found := GetPropertyValueString('File Type', AString, AList);
    if (not Found) or (UpperCase(AString) <> UpperCase('Plot Config')) then
      raise Exception.Create('Incompatible Plot Configuration File Type');

    DisableLayoutManager;
    BeginUpdate;

    if GetPropertyValueString('ChannelCount',    AString, AList) then ACountChannels    := StrToInt(AString) else ACountChannels    := 0;
    if GetPropertyValueString('XAxisCount',      AString, AList) then ACountXAxes       := StrToInt(AString) else ACountXAxes       := 0;
    if GetPropertyValueString('YAxisCount',      AString, AList) then ACountYAxes       := StrToInt(AString) else ACountYAxes       := 0;
    if GetPropertyValueString('ToolBarCount',    AString, AList) then ACountToolBars    := StrToInt(AString) else ACountToolBars    := 0;
    if GetPropertyValueString('LegendCount',     AString, AList) then ACountLegends     := StrToInt(AString) else ACountLegends     := 0;
    if GetPropertyValueString('TableCount',      AString, AList) then ACountTables      := StrToInt(AString) else ACountTables      := 0;
    if GetPropertyValueString('LabelCount',      AString, AList) then ACountLabels      := StrToInt(AString) else ACountLabels      := 0;
    if GetPropertyValueString('DataViewCount',   AString, AList) then ACountDataViews   := StrToInt(AString) else ACountDataViews   := 0;
    if GetPropertyValueString('DataCursorCount', AString, AList) then ACountDataCursors := StrToInt(AString) else ACountDataCursors := 0;
    if GetPropertyValueString('LimitCount',      AString, AList) then ACountLimits      := StrToInt(AString) else ACountLimits      := 0;

    if GetPropertyValueString('DataViewZHorz', AString, AList) then DataViewZHorz := StrToInt(AString);
    if GetPropertyValueString('DataViewZVert', AString, AList) then DataViewZVert := StrToInt(AString);

    //RemoveAllToolBars; //Do not Remove
    RemoveAllLegends;
    RemoveAllTables;
    RemoveAllLabels;
    RemoveAllLimits;
    RemoveAllXAxes;
    RemoveAllYAxes;
    RemoveAllDataViews;
    RemoveAllChannels;
    RemoveAllAnnotations;
    RemoveAllDataCursors;

    for x := 0 to ACountChannels-1    do LoadObjectFromStringList(Channel[AddChannel],       'Channel'    + IntToStr(x), AList);
    for x := 0 to ACountXAxes-1       do LoadObjectFromStringList(XAxis[AddXAxis],           'XAxis'      + IntToStr(x), AList);
    for x := 0 to ACountYAxes-1       do LoadObjectFromStringList(YAxis[AddYAxis],           'YAxis'      + IntToStr(x), AList);
    for x := 0 to ACountToolBars-1    do LoadObjectFromStringList(ToolBar[0],                'ToolBar'    + IntToStr(x), AList);
    for x := 0 to ACountLegends-1     do LoadObjectFromStringList(Legend[AddLegend],         'Legend'     + IntToStr(x), AList);
    for x := 0 to ACountTables-1      do LoadObjectFromStringList(Table[AddTable],           'Table'      + IntToStr(x), AList);

    for x := 0 to ACountLabels-1 do
      if x = 0 then                      LoadObjectFromStringList(Labels[0],                 'Label'      + IntToStr(x), AList)
      else                               LoadObjectFromStringList(Labels[AddLabel],          'Label'      + IntToStr(x), AList);

    for x := 0 to ACountDataViews-1   do LoadObjectFromStringList(DataView[AddDataView],     'DataView'   + IntToStr(x), AList);
    for x := 0 to ACountDataCursors-1 do LoadObjectFromStringList(DataCursor[AddDataCursor], 'DataCursor' + IntToStr(x), AList);
    for x := 0 to ACountLimits-1      do LoadObjectFromStringList(Limit[AddLimit],           'Limit'      + IntToStr(x), AList);

    LoadObjectFromStringList(Self, '', AList);

    EnableLayoutManager;
    EndUpdate;

    FLastPropertiesFileName := FileName;
    if Assigned(FOnAfterLoadProperties) then FOnAfterLoadProperties(Self);
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Loading Properties - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SaveAnnotationsToFile(FileName: String);
var
  x     : Integer;
  AList : TStringList;
begin
  try
  AList := TStringList.Create;
  try
    AList.Add('AnnotationCount = '    + IntToStr(AnnotationCount));
    for x := 0 to AnnotationCount-1 do SaveObjectToStringList(Annotation[x], 'Annotation' + IntToStr(x), AList, nil);
                                       
    AList.SaveToFile(FileName);
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Saving Annotations - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LoadAnnotationsFromFile(FileName: String);
var
  x       : Integer;
  AList   : TStringList;
  AString : String;
  Found   : Boolean;
begin
  try
  AList := TStringList.Create;
  try
    AList.LoadFromFile(FileName);

    BeginUpdate;
                                    
    RemoveAllAnnotations;

    Found := GetPropertyValueString('AnnotationCount', AString, AList);
    if Found then
      for x := 0 to StrToInt(AString)-1 do
        LoadObjectFromStringList(Annotation[AddAnnotation], 'Annotation' + IntToStr(x), AList);

    EndUpdate;
  finally
    AList.Free;
  end;
  except
    on e: Exception do raise Exception.Create('Error Loading Annotations - ' + e.message);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.AppendColumn(var BuildString: String; ColumnIndex: Integer; ColumnString : String);
begin
  if ColumnIndex <> 0 then BuildString := BuildString + GetSavingSeparator + ColumnString
    else BuildString := BuildString + ColumnString;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SaveDataToFile(FileName: String);
begin
  try
    case FDataFileFormat of
      ipdffText            : SaveDataToFileText           (FileName);
      ipdffCompactInterval : SaveDataToFileCompactInterval(FileName);
    end;
  except
    on e: Exception do raise Exception.Create('Error Saving Data - ' + e.message);
  end;

  FLastDataFileName := FileName;
  if Assigned(FOnAfterSaveData) then FOnAfterSaveData(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SaveDataToFileText(FileName: String);
var
  ChannelIndex  : Integer;
  RowIndex      : Integer;
  RowString     : String;
  RowMax        : Integer;
  AList         : TStringList;
  AChannel      : TiPlotChannelCustom;
begin
  RowMax := 0;
  for ChannelIndex := 0 to ChannelCount - 1 do
    if Channel[ChannelIndex].Count > RowMax then RowMax := Channel[ChannelIndex].Count;

  RowString := '';

  AList := TStringList.Create;
  try
    for ChannelIndex := 0 to ChannelCount - 1 do
      begin
        AppendColumn(RowString, ChannelIndex*2  , Channel[ChannelIndex].TitleText + '(X)');
        AppendColumn(RowString, ChannelIndex*2+1, Channel[ChannelIndex].TitleText + '(Y)');
      end;
    AList.Add(RowString);

    for RowIndex := 0 to RowMax - 1 do
      begin
        RowString := '';
        for ChannelIndex := 0 to ChannelCount - 1 do
          begin
            if RowIndex < Channel[ChannelIndex].Count then
              begin
                AChannel := Channel[ChannelIndex];

                if      Channel[ChannelIndex].DataNull[RowIndex] then
                  begin
                    AppendColumn(RowString, ChannelIndex*2  , FloatToStr(AChannel.DataX[RowIndex]));
                    AppendColumn(RowString, ChannelIndex*2+1, 'Null');
                  end
                else if Channel[ChannelIndex].DataEmpty[RowIndex] then
                  begin
                    AppendColumn(RowString, ChannelIndex*2  , FloatToStr(AChannel.DataX[RowIndex]));
                    AppendColumn(RowString, ChannelIndex*2+1, 'Empty');
                  end
                else
                  begin
                    AppendColumn(RowString, ChannelIndex*2  , FloatToStr(AChannel.DataX[RowIndex]));
                    AppendColumn(RowString, ChannelIndex*2+1, FloatToStr(AChannel.DataY[RowIndex]));
                  end;
              end
                else
                  begin
                    AppendColumn(RowString, ChannelIndex*2  , '');
                    AppendColumn(RowString, ChannelIndex*2+1, '');
                  end;
          end;
        AList.Add(RowString);
      end;
    AList.SaveToFile(FileName);
  finally
    AList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SaveDataToFileCompactInterval(FileName: String);
var
  ChannelIndex : Integer;
  RowIndex     : Integer;
  RowString    : String;
  RowMax       : Integer;
  FileStream   : TFileStream;
  ASingle      : Single;
begin
  RowMax := 0;
  for ChannelIndex := 0 to ChannelCount - 1 do
    if Channel[ChannelIndex].Count > RowMax then RowMax := Channel[ChannelIndex].Count;

  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    RowString := 'Compact Interval'     + #13 + #10; FileStream.Write(RowString[1],Length(RowString));
    RowString := IntToStr(ChannelCount) + #13 + #10; FileStream.Write(RowString[1],Length(RowString));
                                           
    for RowIndex := 0 to RowMax-1 do
      begin
        for ChannelIndex := 0 to ChannelCount-1 do
          begin
            if RowIndex < 2 then
              begin
                if   RowIndex > (Channel[ChannelIndex].Count-1) then ASingle := 1E38
                else                                                 ASingle := Channel[ChannelIndex].DataX[RowIndex];
                FileStream.Write(ASingle, SizeOf(Single));
              end;

            if   RowIndex > (Channel[ChannelIndex].Count-1) then ASingle := 1E38
            else                                                 ASingle := Channel[ChannelIndex].DataY[RowIndex];

            FileStream.Write(ASingle, SizeOf(Single));
          end;
      end;
    ASingle := 2E38; FileStream.Write(ASingle, SizeOf(Single));
  finally
    FileStream.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.WriteLog;
var
  x            : Integer;
  ChannelIndex : Integer;
  RowIndex     : Integer;
  FileStream   : TFileStream;
  RowString    : String;
  ASingle      : Single;
begin
  FileStream := TFileStream.Create(FLogFileName, fmOpenReadWrite);
  try
    FileStream.Position := FileStream.Size;
    for x := 0 to FLogBufferCount-1 do
      begin
        RowIndex := Channel[0].Count-1 - FLogBufferCount+1 + x;

        case FDataFileFormat of
          ipdffCompactInterval : begin
                                   for ChannelIndex := 0 to ChannelCount-1 do
                                     begin
                                       if RowIndex < 2 then
                                         begin
                                           ASingle := Channel[ChannelIndex].DataX[RowIndex];
                                           FileStream.Write(ASingle, SizeOf(Single));
                                         end;

                                       ASingle := Channel[ChannelIndex].DataY[RowIndex];
                                       FileStream.Write(ASingle, SizeOf(Single));
                                     end;
                                 end;
          ipdffText            : begin
                                   RowString := '';
                                   AppendColumn(RowString, 0, FloatToStr(Channel[0].DataX[RowIndex]));

                                   for ChannelIndex := 0 to ChannelCount-1 do
                                     begin
                                       if      Channel[ChannelIndex].DataNull [RowIndex] then AppendColumn(RowString, 1, 'Null')
                                       else if Channel[ChannelIndex].DataEmpty[RowIndex] then AppendColumn(RowString, 1, 'Empty')
                                       else                                                   AppendColumn(RowString, 1, FloatToStr(Channel[ChannelIndex].DataY[RowIndex]));
                                     end;

                                   RowString := RowString + #13+#10;

                                   FileStream.Write(RowString[1],Length(RowString));
                                 end;
        end;



      end;
    FLogBufferCount := 0;
  finally
    FileStream.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SeperateColumns(LineString: String; const ColumnDataList : TStringList);
var
  AString    : String;
  CurrentPos : Pointer;
  ScanPos    : Pointer;
  StartPos   : Pointer;
begin
  ColumnDataList.Clear;

  CurrentPos := Pointer(LineString);
  StartPos   := CurrentPos;
  ScanPos    := CurrentPos;

  while (PChar(ScanPos)^ <> #0) and ((PChar(ScanPos) - PChar(StartPos)) < Length(LineString)) do
    begin
      while not (PChar(ScanPos)^ in [FLoadingSeparator, #0]) do Inc(PChar(ScanPos));

      SetString(AString, PChar(CurrentPos), PChar(ScanPos) - PChar(CurrentPos));
      ColumnDataList.Add(AString);
      Inc(PChar(ScanPos));
      CurrentPos := ScanPos;
    end;
end;
//****************************************************************************************************************************************************//****************************************************************************************************************************************************
function TiPlotComponent.GetNextRowString: String;
begin
  if FStringScanPos^ <> #0 then
    begin
      while not (FStringScanPos^ in [#0, #13, #10]) do Inc(FStringScanPos);

      SetString(Result, FStringCurrentPos, FStringScanPos - FStringCurrentPos);

      if FStringScanPos^ = #13 then Inc(FStringScanPos);
      if FStringScanPos^ = #10 then Inc(FStringScanPos);

      FStringCurrentPos := FStringScanPos;
    end
  else
    begin
      Result := '';
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LoadDataFromFile(FileName: String);
var
  Stream         : TStream;
  FirstRowString : String;
  Size           : Integer;
  AString        : String;
begin
  try
    BeginUpdate;
    try
      Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
      try
        Size := Stream.Size - Stream.Position;
        SetString(AString, nil, Size);
        Stream.Read(Pointer(AString)^, Size);
      finally
        Stream.Free;
      end;

      FStringCurrentPos := Pointer(AString);
      FStringScanPos    := FStringCurrentPos;

      FirstRowString := GetNextRowString;

      if UpperCase(FirstRowString) = UpperCase('Compact Interval') then
        begin
          SetString(AString, nil, 0);
                                                   
          Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
          try
            LoadCompactInterval(Stream);
          finally
            Stream.Free;
          end;
        end
      else
        begin
          if AnsiPos(#9, FirstRowString) <> 0 then FLoadingSeparator := #9 else FLoadingSeparator := ',';

          if Copy(UpperCase(FirstRowString), 1, 3) = '(X)' then
            LoadLogData
          else
            LoadXYData;
        end;
      SetString(AString, nil, 0);
    finally
      EndUpdate;
    end;
  except
    on e: Exception do raise Exception.Create('Error Loading Data - ' + e.message);
  end;

  FLastDataFileName := FileName;
  if Assigned(FOnAfterLoadData) then FOnAfterLoadData(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LoadXYData;
var
  ChannelIndex     : Integer;
  ColumnDataList   : TStringList;
  ColumnIndex      : Integer;
  XString, YString : String;
  X, Y             : Double;
  DecimalChar      : String;
  RowString        : String;
begin
  DecimalChar := Copy(FloatToStr(1.1), 2,1);

  ColumnDataList        := TStringList.Create;
  ColumnDataList.Sorted := False;
  ColumnDataList.BeginUpdate;
  try
    while FStringScanPos^ <> #0 do
      begin
        RowString := GetNextRowString;
        SeperateColumns(RowString, ColumnDataList);
        for ChannelIndex := 0 to (ColumnDataList.Count div 2) -1 do
          begin
            if ChannelIndex < ChannelCount then
              begin
                ColumnIndex := ChannelIndex*2;
                XString := ColumnDataList.Strings[ColumnIndex];

                if      DecimalChar = '.' then XString := StringReplace(XString, ',', DecimalChar, [rfIgnoreCase])
                else if DecimalChar = ',' then XString := StringReplace(XString, '.', DecimalChar, [rfIgnoreCase]);

                if Trim(XString) = '' then Continue;
                X := StrToFloat(XString);

                YString := ColumnDataList.Strings[ColumnIndex+1];

                if      DecimalChar = '.' then YString := StringReplace(YString, ',', DecimalChar, [rfIgnoreCase])
                else if DecimalChar = ',' then YString := StringReplace(YString, '.', DecimalChar, [rfIgnoreCase]);

                if Trim(YString) = '' then Continue;

                if UpperCase(YString) = 'NULL' then
                  begin
                    Channel[ChannelIndex].AddXY(X, 0);
                    Channel[ChannelIndex].DataNull[Channel[ChannelIndex].Count-1] := True;
                  end
                else if UpperCase(YString) = 'EMPTY' then
                  begin
                    Channel[ChannelIndex].AddXY(X, 0);
                    Channel[ChannelIndex].DataEmpty[Channel[ChannelIndex].Count-1] := True;
                  end
                else
                  begin
                    Y := StrToFloat(YString);
                    Channel[ChannelIndex].AddXY(X, Y);
                  end;
              end;
          end;
        end;
  finally
    ColumnDataList.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LoadLogData;
var
  ChannelIndex     : Integer;
  ColumnDataList   : TStringList;
  XString, YString : String;
  X, Y             : Double;
  DecimalChar      : String;
begin
  DecimalChar := Copy(FloatToStr(1.1), 2,1);

  ColumnDataList := TStringList.Create;
  try
    while FStringScanPos^ <> #0 do
      begin
        SeperateColumns(GetNextRowString, ColumnDataList);

        XString := ColumnDataList.Strings[0];
        if Trim(XString) = '' then Continue;
        X := StrToFloat(XString);

        for ChannelIndex := 0 to ColumnDataList.Count-2 do
          begin
            if ChannelIndex < ChannelCount then
              begin
                YString := ColumnDataList.Strings[ChannelIndex+1];
                if Trim(YString) = '' then Continue;

                if UpperCase(YString) = UpperCase('Null') then
                  begin
                    Channel[ChannelIndex].AddXY(X, 0);
                    Channel[ChannelIndex].DataNull[Channel[ChannelIndex].Count-1] := True;
                  end
                else if UpperCase(YString) = UpperCase('EMPTY') then
                  begin
                    Channel[ChannelIndex].AddXY(X, 0);
                    Channel[ChannelIndex].DataEmpty[Channel[ChannelIndex].Count-1] := True;
                  end
                else
                  begin
                    if      DecimalChar = '.' then YString := StringReplace(YString, ',', DecimalChar, [rfIgnoreCase])
                    else if DecimalChar = ',' then YString := StringReplace(YString, '.', DecimalChar, [rfIgnoreCase]);

                    Y := StrToFloat(YString);
                    Channel[ChannelIndex].AddXY(X, Y);
                  end;
              end;
          end;
        end;
  finally
    ColumnDataList.Free;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetStreamRowString(Stream : TStream): String;
var
  AChar : Char;
begin
  Result := '';
  AChar  := #1;

  while (Stream.Position < Stream.Size) and (AChar <> #10) do
    begin
      Stream.Read(AChar, SizeOf(AChar));
      if (AChar <> #13) and (AChar <> #10) then Result := Result + AChar;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetStreamSingle(Stream : TStream): Single;
begin
  if Stream.Read(Result, SizeOf(Result)) <> SizeOf(Single) then raise Exception.Create('Invalid Data');
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LoadCompactInterval(Stream : TStream);
var
  AChannelCount : Integer;
  ChannelIndex  : Integer;
  AString       : String;
  RowIndex      : Integer;
  XValue        : Double;
  YValue        : Double;
begin
  AString := GetStreamRowString(Stream); //Get Title
  AString := GetStreamRowString(Stream); //Get Channel Count

  AChannelCount := StrToInt(AString);
  RowIndex := 0;

  while Stream.Position < Stream.Size do
    begin
      for ChannelIndex := 0 to AChannelCount-1 do
        begin
          if RowIndex < 2 then XValue := GetStreamSingle(Stream)
          else                 XValue := 0;
          if (XValue > 1.5E38) then
            Exit;

          YValue := GetStreamSingle(Stream);
          if (YValue > 1.5E38) then
            Exit;

          if (XValue < 0.9E38) and (YValue < 0.9E38) and (ChannelIndex < ChannelCount) then
            Channel[ChannelIndex].AddXY(XValue, YValue);
        end;
      Inc(RowIndex);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LogActivate(Append: Boolean);
var
  FileStream : TFileStream;
  ChannelIndex : Integer;
  RowString    : String;
begin
  if Trim(FLogFileName) = '' then raise Exception.Create('Log File Name not Defined');
  if FLoggingActive          then raise Exception.Create('Logging Already Active');

  if Append then
    begin
      FileStream := TFileStream.Create(FLogFileName, fmOpenReadWrite);
      FileStream.Free;
    end
  else
    begin
      FileStream := TFileStream.Create(FLogFileName, fmCreate);
      try
        FileStream.Size := 0;

        case FDataFileFormat of
          ipdffCompactInterval : begin
                                   RowString := 'Compact Interval'     + #13 + #10; FileStream.Write(RowString[1],Length(RowString));
                                   RowString := IntToStr(ChannelCount) + #13 + #10; FileStream.Write(RowString[1],Length(RowString));
                                 end;
          ipdffText            : begin
                                   RowString := '';
                                   AppendColumn(RowString, 0, '(X)');

                                   for ChannelIndex := 0 to ChannelCount - 1 do
                                     AppendColumn(RowString, ChannelIndex*2+1, Channel[ChannelIndex].TitleText + '(Y)');

                                   RowString := RowString + #13 + #10;
                                   FileStream.Write(RowString[1],Length(RowString));
                                 end;
        end;
      finally
        FileStream.Free;
      end;
    end;

  FLoggingActive  := True;
  FLogBufferCount := 0;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LogDeactivate;
begin
  if not FLoggingActive then raise Exception.Create('Logging not Active');

  FLoggingActive := False;
  if FLogBufferCount > 0 then WriteLog;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DataCursorChange(Sender: TObject);
begin                                                                                                    
  if Assigned(FOnDataCursorChange) then FOnDataCursorChange(FMaster.DataCursorManager.GetIndex(Sender as TiPlotObject));
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.AfterPropertyEditorApply;
begin

end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.BeforePropertyEditorLoad;
begin

end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.LoadTranslationsFromFile(FileName: String);
begin
  FMaster.TranslationManager.LoadFromFile(FileName);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SaveTranslationsToFile(FileName: String);
begin
  FMaster.TranslationManager.SaveToFile(FileName);
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetTranslationOriginalString(Index: Integer): String;
begin
  Result := FMaster.TranslationManager.Items[Index].OriginalString;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetTranslationReplacementString(Index: Integer): String;
begin
  Result := FMaster.TranslationManager.Items[Index].ReplacementString;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MasterAxisMouseLeft(Axis: TiPlotAxis; MouseData: TiPlotMouseData);
var
  i : Integer;
begin
  if FMasterAxisBlock then Exit;
  FMasterAxisBlock := True;
  try
    if Axis is TiPlotXAxis then
      begin
        for i := 0 to XAxisCount-1 do
          begin
            if Axis = XAxis[i] then Continue;
            TiPlotAxisAccess(XAxis[i]).DoMouseLeft(MouseData);
          end;
      end;

    if Axis is TiPlotYAxis then
      begin
        for i := 0 to YAxisCount-1 do
          begin
            if Axis = YAxis[i] then Continue;
            TiPlotAxisAccess(YAxis[i]).DoMouseLeft(MouseData);
          end;
      end;
  finally
    FMasterAxisBlock := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MasterAxisMouseMove(Axis: TiPlotAxis; MouseData: TiPlotMouseData);
var
  i : Integer;
begin
  if FMasterAxisBlock then Exit;
  FMasterAxisBlock := True;
  try
    if Axis is TiPlotXAxis then
      begin
        for i := 0 to XAxisCount-1 do
          begin
            if Axis = XAxis[i] then Continue;
            TiPlotAxisAccess(XAxis[i]).DoMouseMove(MouseData);
          end;
      end;

    if Axis is TiPlotYAxis then
      begin
        for i := 0 to YAxisCount-1 do
          begin
            if Axis = YAxis[i] then Continue;
            TiPlotAxisAccess(YAxis[i]).DoMouseMove(MouseData);
          end;
      end;
  finally
    FMasterAxisBlock := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MasterAxisMouseUp(Axis: TiPlotAxis; MouseData: TiPlotMouseData);
var
  i : Integer;
begin
  if FMasterAxisBlock then Exit;
  FMasterAxisBlock := True;
  try
    if Axis is TiPlotXAxis then
      begin
        for i := 0 to XAxisCount-1 do
          begin
            if Axis = XAxis[i] then Continue;
            TiPlotAxisAccess(XAxis[i]).DoMouseUp(MouseData);
          end;
      end;

    if Axis is TiPlotYAxis then
      begin
        for i := 0 to YAxisCount-1 do
          begin
            if Axis = YAxis[i] then Continue;
            TiPlotAxisAccess(YAxis[i]).DoMouseUp(MouseData);
          end;
      end;
  finally
    FMasterAxisBlock := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MasterAxisMouseWheel(Axis: TiPlotAxis; WheelDelta: Integer; Shift: TShiftState; AX, AY: Integer);
var
  i : Integer;
begin
  if FMasterAxisBlock then Exit;
  FMasterAxisBlock := True;
  try
    if Axis is TiPlotXAxis then
      begin
        for i := 0 to XAxisCount-1 do
          begin
            if Axis = XAxis[i] then Continue;
            TiPlotAxisAccess(XAxis[i]).DoMouseWheel(WheelDelta, Shift, AX, AY);
          end;
      end;

    if Axis is TiPlotYAxis then
      begin
        for i := 0 to YAxisCount-1 do
          begin
            if Axis = YAxis[i] then Continue;
            TiPlotAxisAccess(YAxis[i]).DoMouseWheel(WheelDelta, Shift, AX, AY);
          end;
      end;
  finally
    FMasterAxisBlock := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.MasterAxisKeyDown(Axis: TiPlotAxis; var CharCode: Word; Shift: TShiftState);
var
  i : Integer;
begin
  if FMasterAxisBlock then Exit;
  FMasterAxisBlock := True;
  try
    if Axis is TiPlotXAxis then
      begin
        for i := 0 to XAxisCount-1 do
          begin
            if Axis = XAxis[i] then Continue;
            TiPlotAxisAccess(XAxis[i]).iKeyDown(CharCode, Shift, PopupMenu);
          end;
      end;

    if Axis is TiPlotYAxis then
      begin
        for i := 0 to YAxisCount-1 do
          begin
            if Axis = YAxis[i] then Continue;
            TiPlotAxisAccess(YAxis[i]).iKeyDown(CharCode, Shift, PopupMenu);
          end;
      end;
  finally
    FMasterAxisBlock := False;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAxesMinChange(Sender: TiPlotAxis; OldValue, NewValue: Double);
begin
  if Loading then Exit;

  if Sender is TiPlotXAxis then
    begin
      if Assigned(FOnXAxisMinChange) then FOnXAxisMinChange(FMaster.XAxisManager.GetIndex(Sender), OldValue, NewValue);
    end;
  if Sender is TiPlotYAxis then
    begin
      if Assigned(FOnYAxisMinChange) then FOnYAxisMinChange(FMaster.YAxisManager.GetIndex(Sender), OldValue, NewValue);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAxesSpanChange(Sender: TiPlotAxis; OldValue, NewValue: Double);
begin
  if Loading then Exit;

  if Sender is TiPlotXAxis then
    begin
      if Assigned(FOnXAxisSpanChange) then FOnXAxisSpanChange(FMaster.XAxisManager.GetIndex(Sender), OldValue, NewValue);
    end;
  if Sender is TiPlotYAxis then
    begin
      if Assigned(FOnYAxisSpanChange) then FOnYAxisSpanChange(FMaster.YAxisManager.GetIndex(Sender), OldValue, NewValue);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAxesMinSpanChange(Sender: TiPlotAxis; OldMin, OldSpan, NewMin, NewSpan: Double);
begin
  if Loading then Exit;

  if Sender is TiPlotXAxis then
    begin
      if Assigned(FOnXAxisMinSpanChange) then FOnXAxisMinSpanChange(FMaster.XAxisManager.GetIndex(Sender), OldMin, OldSpan, NewMin, NewSpan);
    end;
  if Sender is TiPlotYAxis then
    begin
      if Assigned(FOnYAxisMinSpanChange) then FOnYAxisMinSpanChange(FMaster.YAxisManager.GetIndex(Sender), OldMin, OldSpan, NewMin, NewSpan);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAxesMinSpanChangeFinished(Sender: TiPlotAxis; OldMin, OldSpan, NewMin, NewSpan: Double);
begin
  if Loading then Exit;

  if Sender is TiPlotXAxis then
    begin
      if Assigned(FOnXAxisMinSpanChangeFinished) then FOnXAxisMinSpanChangeFinished(FMaster.XAxisManager.GetIndex(Sender), OldMin, OldSpan, NewMin, NewSpan);
    end;
  if Sender is TiPlotYAxis then
    begin
      if Assigned(FOnYAxisMinSpanChangeFinished) then FOnYAxisMinSpanChangeFinished(FMaster.YAxisManager.GetIndex(Sender), OldMin, OldSpan, NewMin, NewSpan);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAxesCustomizeLabel(Sender: TiPlotAxis; Value: Double; var ALabel: String);
begin
  if Loading then Exit;

  if Sender is TiPlotXAxis then
    begin
      if Assigned(FOnXAxisCustomizeLabel) then FOnXAxisCustomizeLabel(FMaster.XAxisManager.GetIndex(Sender), Value, ALabel);
    end;
  if Sender is TiPlotYAxis then
    begin
      if Assigned(FOnYAxisCustomizeLabel) then FOnYAxisCustomizeLabel(FMaster.YAxisManager.GetIndex(Sender), Value, ALabel);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoDataCursorCustomizeHint(Sender: TiPlotDataCursor; var AText: String);
begin
  if Loading then Exit;

  if Assigned(FOnDataCursorCustomizeHint) then
    begin
      FOnDataCursorCustomizeHint(FMaster.DataCursorManager.GetIndex(Sender), AText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoXAxisCustomizeHint(Sender: TiPlotXAxis; var AText: String);
begin
  if Loading then Exit;

  if Assigned(FOnXAxisCustomizeHint) then
    begin
      FOnXAxisCustomizeHint(FMaster.XAxisManager.GetIndex(Sender), AText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoYAxisCustomizeHint(Sender: TiPlotYAxis; var AText: String);
begin
  if Loading then Exit;

  if Assigned(FOnYAxisCustomizeHint) then
    begin
      FOnYAxisCustomizeHint(FMaster.YAxisManager.GetIndex(Sender), AText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoDataPointCustomizeHint(Sender: TiPlotChannelCustom; DataPointIndex: Integer; var AText: String);
begin
  if Loading then Exit;

  if Assigned(FOnDataPointCustomizeHint) then
    begin
      FOnDataPointCustomizeHint(FMaster.ChannelManager.GetIndex(Sender), DataPointIndex, AText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoToolBarCustomizeHint(Sender: TiPlotToolBar; var AText: String);
begin
  if Loading then Exit;

  if Assigned(FOnToolBarCustomizeHint) then
    begin
      FOnToolBarCustomizeHint(FMaster.ToolBarManager.GetIndex(Sender), AText);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoToolBarButtonClick(Sender: TiPlotToolBar; ButtonType: TiPlotToolBarButtonType);
begin
  if Loading then Exit;

  if Assigned(FOnToolBarButtonClick) then
    begin
      FOnToolBarButtonClick(FMaster.ToolBarManager.GetIndex(Sender), ButtonType);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoToolBarButtonBeforeClick(Sender: TiPlotToolBar; ButtonType: TiPlotToolBarButtonType; var Cancel: Boolean);
begin
  if Loading then Exit;

  if Assigned(FOnBeforeToolBarButtonClick) then
    begin
      FOnBeforeToolBarButtonClick(FMaster.ToolBarManager.GetIndex(Sender), ButtonType, Cancel);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoBeforeDataCursorUpdate(Sender: TiPlotDataCursor);
begin
  if Loading then Exit;

  if Assigned(FOnBeforeDataCursorUpdate) then
    begin
      FOnBeforeDataCursorUpdate(FMaster.DataCursorManager.GetIndex(Sender));
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoObjectClick(Sender:TiPlotObject);
begin
  if Loading then Exit;

  if not FDBLClickActive then
    begin
      if      Sender is TiPlotChannelCustom and Assigned(FOnClickChannel)    then FOnClickChannel   (FMaster.ChannelManager.   GetIndex(Sender))
      else if Sender is TiPlotXAxis         and Assigned(FOnClickXAxis)      then FOnClickXAxis     (FMaster.XAxisManager.     GetIndex(Sender))
      else if Sender is TiPlotYAxis         and Assigned(FOnClickYAxis)      then FOnClickYAxis     (FMaster.YAxisManager.     GetIndex(Sender))
      else if Sender is TiPlotDataCursor    and Assigned(FOnClickDataCursor) then FOnClickDataCursor(FMaster.DataCursorManager.GetIndex(Sender))
      else if Sender is TiPlotDataView      and Assigned(FOnClickDataView)   then FOnClickDataView  (FMaster.DataViewManager.  GetIndex(Sender))
      else if Sender is TiPlotLegend        and Assigned(FOnClickLegend)     then FOnClickLegend    (FMaster.LegendManager.    GetIndex(Sender))
      else if Sender is TiPlotLimit         and Assigned(FOnClickLimit)      then FOnClickLimit     (FMaster.LimitManager.     GetIndex(Sender))
      else if Sender is TiPlotAnnotation    and Assigned(FOnClickAnnotation) then FOnClickAnnotation(FMaster.AnnotationManager.GetIndex(Sender));
    end
  else
    begin
      if      Sender is TiPlotChannelCustom and Assigned(FOnDblClickChannel)    then FOnDblClickChannel   (FMaster.ChannelManager.   GetIndex(Sender))
      else if Sender is TiPlotXAxis         and Assigned(FOnDblClickXAxis)      then FOnDblClickXAxis     (FMaster.XAxisManager.     GetIndex(Sender))
      else if Sender is TiPlotYAxis         and Assigned(FOnDblClickYAxis)      then FOnDblClickYAxis     (FMaster.YAxisManager.     GetIndex(Sender))
      else if Sender is TiPlotDataCursor    and Assigned(FOnDblClickDataCursor) then FOnDblClickDataCursor(FMaster.DataCursorManager.GetIndex(Sender))
      else if Sender is TiPlotDataView      and Assigned(FOnDblClickDataView)   then FOnDblClickDataView  (FMaster.DataViewManager.  GetIndex(Sender))
      else if Sender is TiPlotLegend        and Assigned(FOnDblClickLegend)     then FOnDblClickLegend    (FMaster.LegendManager.    GetIndex(Sender))
      else if Sender is TiPlotLimit         and Assigned(FOnDblClickLimit)      then FOnDblClickLimit     (FMaster.LimitManager.     GetIndex(Sender))
      else if Sender is TiPlotAnnotation    and Assigned(FOnDblClickAnnotation) then FOnDblClickAnnotation(FMaster.AnnotationManager.GetIndex(Sender));
    end;

   FDBLClickActive := False;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoObjectMouseDown(Sender: TiPlotObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Loading then Exit;

  if      Sender is TiPlotChannelCustom and Assigned(FOnMouseDownChannel)    then FOnMouseDownChannel   (FMaster.ChannelManager.   GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotXAxis         and Assigned(FOnMouseDownXAxis)      then FOnMouseDownXAxis     (FMaster.XAxisManager.     GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotYAxis         and Assigned(FOnMouseDownYAxis)      then FOnMouseDownYAxis     (FMaster.YAxisManager.     GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotDataCursor    and Assigned(FOnMouseDownDataCursor) then FOnMouseDownDataCursor(FMaster.DataCursorManager.GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotDataView      and Assigned(FOnMouseDownDataView)   then FOnMouseDownDataView  (FMaster.DataViewManager.  GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotLegend        and Assigned(FOnMouseDownLegend)     then FOnMouseDownLegend    (FMaster.LegendManager.    GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotLimit         and Assigned(FOnMouseDownLimit)      then FOnMouseDownLimit     (FMaster.LimitManager.     GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotAnnotation    and Assigned(FOnMouseDownAnnotation) then FOnMouseDownAnnotation(FMaster.AnnotationManager.GetIndex(Sender), Button, Shift, X, Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoGetMouseCursor(Sender: TiPlotObject; var MouseCursor: TCursor);
begin
  if Loading then Exit;

  if      Sender is TiPlotChannelCustom and Assigned(FOnGetMouseCursorChannel)    then FOnGetMouseCursorChannel   (FMaster.ChannelManager.   GetIndex(Sender), MouseCursor)
  else if Sender is TiPlotXAxis         and Assigned(FOnGetMouseCursorXAxis)      then FOnGetMouseCursorXAxis     (FMaster.XAxisManager.     GetIndex(Sender), MouseCursor)
  else if Sender is TiPlotYAxis         and Assigned(FOnGetMouseCursorYAxis)      then FOnGetMouseCursorYAxis     (FMaster.YAxisManager.     GetIndex(Sender), MouseCursor)
  else if Sender is TiPlotDataCursor    and Assigned(FOnGetMouseCursorDataCursor) then FOnGetMouseCursorDataCursor(FMaster.DataCursorManager.GetIndex(Sender), MouseCursor)
  else if Sender is TiPlotDataView      and Assigned(FOnGetMouseCursorDataView)   then FOnGetMouseCursorDataView  (FMaster.DataViewManager.  GetIndex(Sender), MouseCursor)
  else if Sender is TiPlotLegend        and Assigned(FOnGetMouseCursorLegend)     then FOnGetMouseCursorLegend    (FMaster.LegendManager.    GetIndex(Sender), MouseCursor)
  else if Sender is TiPlotLimit         and Assigned(FOnGetMouseCursorLimit)      then FOnGetMouseCursorLimit     (FMaster.LimitManager.     GetIndex(Sender), MouseCursor)
  else if Sender is TiPlotAnnotation    and Assigned(FOnGetMouseCursorAnnotation) then FOnGetMouseCursorAnnotation(FMaster.AnnotationManager.GetIndex(Sender), MouseCursor);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoObjectMouseMove(Sender: TiPlotObject; Shift: TShiftState; X, Y: Integer);
begin
  if Loading then Exit;

  if      Sender is TiPlotChannelCustom and Assigned(FOnMouseMoveChannel)    then FOnMouseMoveChannel   (FMaster.ChannelManager.   GetIndex(Sender), Shift, X, Y)
  else if Sender is TiPlotXAxis         and Assigned(FOnMouseMoveXAxis)      then FOnMouseMoveXAxis     (FMaster.XAxisManager.     GetIndex(Sender), Shift, X, Y)
  else if Sender is TiPlotYAxis         and Assigned(FOnMouseMoveYAxis)      then FOnMouseMoveYAxis     (FMaster.YAxisManager.     GetIndex(Sender), Shift, X, Y)
  else if Sender is TiPlotDataCursor    and Assigned(FOnMouseMoveDataCursor) then FOnMouseMoveDataCursor(FMaster.DataCursorManager.GetIndex(Sender), Shift, X, Y)
  else if Sender is TiPlotDataView      and Assigned(FOnMouseMoveDataView)   then FOnMouseMoveDataView  (FMaster.DataViewManager.  GetIndex(Sender), Shift, X, Y)
  else if Sender is TiPlotLegend        and Assigned(FOnMouseMoveLegend)     then FOnMouseMoveLegend    (FMaster.LegendManager.    GetIndex(Sender), Shift, X, Y)
  else if Sender is TiPlotLimit         and Assigned(FOnMouseMoveLimit)      then FOnMouseMoveLimit     (FMaster.LimitManager.     GetIndex(Sender), Shift, X, Y)
  else if Sender is TiPlotAnnotation    and Assigned(FOnMouseMoveAnnotation) then FOnMouseMoveAnnotation(FMaster.AnnotationManager.GetIndex(Sender), Shift, X, Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoObjectMouseUp(Sender: TiPlotObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Loading then Exit;

  if      Sender is TiPlotChannelCustom and Assigned(FOnMouseUpChannel)    then FOnMouseUpChannel   (FMaster.ChannelManager.   GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotXAxis         and Assigned(FOnMouseUpXAxis)      then FOnMouseUpXAxis     (FMaster.XAxisManager.     GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotYAxis         and Assigned(FOnMouseUpYAxis)      then FOnMouseUpYAxis     (FMaster.YAxisManager.     GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotDataCursor    and Assigned(FOnMouseUpDataCursor) then FOnMouseUpDataCursor(FMaster.DataCursorManager.GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotDataView      and Assigned(FOnMouseUpDataView)   then FOnMouseUpDataView  (FMaster.DataViewManager.  GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotLegend        and Assigned(FOnMouseUpLegend)     then FOnMouseUpLegend    (FMaster.LegendManager.    GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotLimit         and Assigned(FOnMouseUpLimit)      then FOnMouseUpLimit     (FMaster.LimitManager.     GetIndex(Sender), Button, Shift, X, Y)
  else if Sender is TiPlotAnnotation    and Assigned(FOnMouseUpAnnotation) then FOnMouseUpAnnotation(FMaster.AnnotationManager.GetIndex(Sender), Button, Shift, X, Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoObjectMouseWheel(Sender: TiPlotObject; WheelDelta: Integer; Shift: TShiftState; X, Y: Integer);
begin
  if Loading then Exit;

  if      Sender is TiPlotXAxis      and Assigned(OnMouseWheelXAxis     ) then OnMouseWheelXAxis     (FMaster.XAxisManager.     GetIndex(Sender), WheelDelta, Shift, X, Y)
  else if Sender is TiPlotYAxis      and Assigned(OnMouseWheelYAxis     ) then OnMouseWheelYAxis     (FMaster.YAxisManager.     GetIndex(Sender), WheelDelta, Shift, X, Y)
  else if Sender is TiPlotDataView   and Assigned(OnMouseWheelDataView  ) then OnMouseWheelDataView  (FMaster.DataViewManager.  GetIndex(Sender), WheelDelta, Shift, X, Y)
  else if Sender is TiPlotLegend     and Assigned(OnMouseWheelLegend    ) then OnMouseWheelLegend    (FMaster.LegendManager.    GetIndex(Sender), WheelDelta, Shift, X, Y)
  else if Sender is TiPlotChannel    and Assigned(OnMouseWheelChannel   ) then OnMouseWheelChannel   (FMaster.ChannelManager.   GetIndex(Sender), WheelDelta, Shift, X, Y)
  else if Sender is TiPlotLimit      and Assigned(OnMouseWheelLimit     ) then OnMouseWheelLimit     (FMaster.LimitManager.     GetIndex(Sender), WheelDelta, Shift, X, Y)
  else if Sender is TiPlotDataCursor and Assigned(OnMouseWheelDataCursor) then OnMouseWheelDataCursor(FMaster.DataCursorManager.GetIndex(Sender), WheelDelta, Shift, X, Y)
  else if Sender is TiPlotAnnotation and Assigned(OnMouseWheelAnnotation) then OnMouseWheelAnnotation(FMaster.AnnotationManager.GetIndex(Sender), WheelDelta, Shift, X, Y);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoDataPointClick(Sender:TiPlotChannelCustom; Index: Integer);
begin
  if Loading then Exit;

  if not FDBLClickActive then
    begin
      if Assigned(FOnClickDataPoint)    then FOnClickDataPoint(FMaster.ChannelManager.GetIndex(Sender), Index)
    end
  else
    begin
      if Assigned(FOnDblClickDataPoint) then FOnDblClickDataPoint(FMaster.ChannelManager.GetIndex(Sender), Index);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoDataPointMouseDown(Sender:TiPlotChannelCustom; DataIndex: Integer; MouseData: TiPlotMouseData);
begin
  if Loading then Exit;

  if Assigned(OnMouseDownDataPoint) then
    begin
      OnMouseDownDataPoint(FMaster.ChannelManager.GetIndex(Sender), DataIndex, MouseData.Button, MouseData.Shift, MouseData.X, MouseData.Y);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoDataPointMouseMove(Sender:TiPlotChannelCustom; DataIndex: Integer; MouseData: TiPlotMouseData);
begin
  if Loading then Exit;

  if Assigned(OnMouseMoveDataPoint) then
    begin
      OnMouseMoveDataPoint(FMaster.ChannelManager.GetIndex(Sender), DataIndex, MouseData.Shift, MouseData.X, MouseData.Y);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoDataPointMouseUp(Sender:TiPlotChannelCustom; DataIndex: Integer; MouseData: TiPlotMouseData);
begin
  if Loading then Exit;

  if Assigned(OnMouseUpDataPoint) then
    begin
      OnMouseUpDataPoint(FMaster.ChannelManager.GetIndex(Sender), DataIndex, MouseData.Button, MouseData.Shift, MouseData.X, MouseData.Y);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoDataPointMoved(Sender:TiPlotChannelCustom; Index: Integer; OldX, OldY, NewX, NewY: Double);
begin
  if Loading then Exit;

  if Assigned(FOnDataPointMoved) then
    begin
      FOnDataPointMoved(FMaster.ChannelManager.GetIndex(Sender), Index, OldX, OldY, NewX, NewY);
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAnnotationCoordinatesChange(Sender: TiPlotAnnotation);
begin
  if Loading then Exit;

  if Assigned(FOnAnnotationCoordinatesChange) then
    begin
      FOnAnnotationCoordinatesChange(FMaster.AnnotationManager.GetIndex(Sender));
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAnnotationMoveUser(Sender: TiPlotAnnotation);
begin
  if Loading then Exit;

  if Assigned(FOnAnnotationMoveUser) then
    begin
      FOnAnnotationMoveUser(FMaster.AnnotationManager.GetIndex(Sender));
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAnnotationResizeUser(Sender: TiPlotAnnotation);
begin
  if Loading then Exit;

  if Assigned(FOnAnnotationResizeUser) then
    begin
      FOnAnnotationResizeUser(FMaster.AnnotationManager.GetIndex(Sender));
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoAnnotationCoordinatesChangeFinished(Sender: TiPlotAnnotation);
begin
  if Loading then Exit;

  if Assigned(FOnAnnotationCoordinatesChangeFinished) then
    begin
      FOnAnnotationCoordinatesChangeFinished(FMaster.AnnotationManager.GetIndex(Sender));
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoLimitLine1PositionChange(Sender: TiPlotLimit; OldValue, NewValue: Double);
begin
  if Loading then Exit;

  if Assigned(FOnLimitLine1PositionChange) then
    begin
      FOnLimitLine1PositionChange(FMaster.LimitManager.GetIndex(Sender), OldValue, NewValue);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoLimitLine2PositionChange(Sender: TiPlotLimit; OldValue, NewValue: Double);
begin
  if Loading then Exit;

  if Assigned(FOnLimitLine2PositionChange) then
    begin
      FOnLimitLine2PositionChange(FMaster.LimitManager.GetIndex(Sender), OldValue, NewValue);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoObjectGotFocus(Sender: TiPlotObject);
begin
  if Loading then Exit;

  if      Sender is TiPlotChannelCustom and Assigned(FOnGotFocusChannel)    then FOnGotFocusChannel   (FMaster.ChannelManager.   GetIndex(Sender))
  else if Sender is TiPlotXAxis         and Assigned(FOnGotFocusXAxis)      then FOnGotFocusXAxis     (FMaster.XAxisManager.     GetIndex(Sender))
  else if Sender is TiPlotYAxis         and Assigned(FOnGotFocusYAxis)      then FOnGotFocusYAxis     (FMaster.YAxisManager.     GetIndex(Sender))
  else if Sender is TiPlotDataCursor    and Assigned(FOnGotFocusDataCursor) then FOnGotFocusDataCursor(FMaster.DataCursorManager.GetIndex(Sender))
  else if Sender is TiPlotDataView      and Assigned(FOnGotFocusDataView)   then FOnGotFocusDataView  (FMaster.DataViewManager.  GetIndex(Sender))
  else if Sender is TiPlotLegend        and Assigned(FOnGotFocusLegend)     then FOnGotFocusLegend    (FMaster.LegendManager.    GetIndex(Sender))
  else if Sender is TiPlotAnnotation    and Assigned(FOnGotFocusAnnotation) then FOnGotFocusAnnotation(FMaster.AnnotationManager.GetIndex(Sender))
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoObjectLostFocus(Sender: TiPlotObject);
begin
  if Loading then Exit;

  if      Sender is TiPlotChannelCustom and Assigned(FOnLostFocusChannel)    then FOnLostFocusChannel   (FMaster.ChannelManager.   GetIndex(Sender))
  else if Sender is TiPlotXAxis         and Assigned(FOnLostFocusXAxis)      then FOnLostFocusXAxis     (FMaster.XAxisManager.     GetIndex(Sender))
  else if Sender is TiPlotYAxis         and Assigned(FOnLostFocusYAxis)      then FOnLostFocusYAxis     (FMaster.YAxisManager.     GetIndex(Sender))
  else if Sender is TiPlotDataCursor    and Assigned(FOnLostFocusDataCursor) then FOnLostFocusDataCursor(FMaster.DataCursorManager.GetIndex(Sender))
  else if Sender is TiPlotDataView      and Assigned(FOnLostFocusDataView)   then FOnLostFocusDataView  (FMaster.DataViewManager.  GetIndex(Sender))
  else if Sender is TiPlotLegend        and Assigned(FOnLostFocusLegend)     then FOnLostFocusLegend    (FMaster.LegendManager.    GetIndex(Sender))
  else if Sender is TiPlotAnnotation    and Assigned(FOnLostFocusAnnotation) then FOnLostFocusAnnotation(FMaster.AnnotationManager.GetIndex(Sender))
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.DoPopUpMenuEvent(Sender: TiPlotObject; var Cancel: Boolean; ScreenX, ScreenY: Integer);
begin
  if Loading then Exit;

  if      Sender is TiPlotChannelCustom and Assigned(FOnPopupMenuChannel)   then FOnPopupMenuChannel   (FMaster.ChannelManager.   GetIndex(Sender), Cancel, ScreenX, ScreenY)
  else if Sender is TiPlotXAxis         and Assigned(FOnPopupMenuXAxis)     then FOnPopupMenuXAxis     (FMaster.XAxisManager.     GetIndex(Sender), Cancel, ScreenX, ScreenY)
  else if Sender is TiPlotYAxis         and Assigned(FOnPopupMenuYAxis)     then FOnPopupMenuYAxis     (FMaster.YAxisManager.     GetIndex(Sender), Cancel, ScreenX, ScreenY)
  else if Sender is TiPlotDataCursor    and Assigned(FOnPopupMenuDataCursor)then FOnPopupMenuDataCursor(FMaster.DataCursorManager.GetIndex(Sender), Cancel, ScreenX, ScreenY)
  else if Sender is TiPlotDataView      and Assigned(FOnPopupMenuDataView)  then FOnPopupMenuDataView  (FMaster.DataViewManager.  GetIndex(Sender), Cancel, ScreenX, ScreenY)
  else if Sender is TiPlotLegend        and Assigned(FOnPopupMenuLegend)    then FOnPopupMenuLegend    (FMaster.LegendManager.    GetIndex(Sender), Cancel, ScreenX, ScreenY)
  else if Sender is TiPlotLimit         and Assigned(FOnPopupMenuLimit)     then FOnPopupMenuLimit     (FMaster.LimitManager.     GetIndex(Sender), Cancel, ScreenX, ScreenY)
  else if Sender is TiPlotAnnotation    and Assigned(FOnPopupMenuAnnotation)then FOnPopupMenuAnnotation(FMaster.AnnotationManager.GetIndex(Sender), Cancel, ScreenX, ScreenY)
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.UpdateAxisPixels(var MouseData: TiPlotMouseData);
begin
  if FMaster.LayoutManager.XYAxesReverse then
    begin
      MouseData.XAxisPixels := MouseData.Y;
      MouseData.YAxisPixels := MouseData.X;
    end
  else
    begin                                                
      MouseData.XAxisPixels := MouseData.X;
      MouseData.YAxisPixels := MouseData.Y;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetChannelByName   (Value:String):TiPlotChannelCustom;begin Result:=FMaster.ChannelManager.GetObjectByName   (Value)as TiPlotChannelCustom;end;
function TiPlotComponent.GetDataCursorByName(Value:String):TiPlotDataCursor;   begin Result:=FMaster.DataCursorManager.GetObjectByName(Value)as TiPlotDataCursor;   end;
function TiPlotComponent.GetDataViewByName  (Value:String):TiPlotDataView;     begin Result:=FMaster.DataViewManager.GetObjectByName  (Value)as TiPlotDataView;     end;
function TiPlotComponent.GetLabelByName     (Value:String):TiPlotLabel;        begin Result:=FMaster.LabelManager.GetObjectByName     (Value)as TiPlotLabel;        end;
function TiPlotComponent.GetLegendByName    (Value:String):TiPlotLegend;       begin Result:=FMaster.LegendManager.GetObjectByName    (Value)as TiPlotLegend;       end;
function TiPlotComponent.GetTableByName     (Value:String):TiPlotTable;        begin Result:=FMaster.TableManager.GetObjectByName     (Value)as TiPlotTable;        end;
function TiPlotComponent.GetLimitByName     (Value:String):TiPlotLimit;        begin Result:=FMaster.LimitManager.GetObjectByName     (Value)as TiPlotLimit;        end;
function TiPlotComponent.GetToolBarByName   (Value:String):TiPlotToolBar;      begin Result:=FMaster.ToolBarManager.GetObjectByName   (Value)as TiPlotToolBar;      end;
function TiPlotComponent.GetXAxisByName     (Value:String):TiPlotXAxis;        begin Result:=FMaster.XAxisManager.GetObjectByName     (Value)as TiPlotXAxis;        end;
function TiPlotComponent.GetYAxisByName     (Value:String):TiPlotYAxis;        begin Result:=FMaster.YAxisManager.GetObjectByName     (Value)as TiPlotYAxis;        end;
function TiPlotComponent.GetannotationByName(Value:String): TiPlotAnnotation;  begin Result:=FMaster.AnnotationManager.GetObjectByName(Value)as TiPlotAnnotation;   end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ImageListClear(ImageListIndex: Integer);
begin
  case ImageListIndex of
    0 : FImageList0.Clear;
    1 : FImageList1.Clear;
    2 : FImageList2.Clear;
    else raise Exception.Create('ImageList Index must be 0-2');
  end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ImageListLoadFromBitmap(ImageListIndex: Integer; ABitmap: TBitmap);
var
  BBitmap    : TBitmap;
  OffsetX    : Integer;
  OffsetY    : Integer;
  AImageList : TImageList;
begin
  case ImageListIndex of
    0 : AImageList := FImageList0;
    1 : AImageList := FImageList1;
    2 : AImageList := FImageList2;
    else raise Exception.Create('ImageList Index must be 0-2');
  end;

  if AImageList.Count = 0 then
    begin
      AImageList.Width  := ABitmap.Width;
      AImageList.Height := ABitmap.Height;
    end
  else if (ABitmap.Width < AImageList.Width) and (ABitmap.Height < AImageList.Height) then
    begin
      BBitmap := TBitmap.Create;
      try
        BBitmap.Width  := AImageList.Width;
        BBitmap.Height := AImageList.Height;

        BBitmap.Canvas.Brush.Style := bsSolid;
        BBitmap.Canvas.Brush.Color := ABitmap.TransparentColor;
        BBitmap.Canvas.FillRect(Rect(0, 0, BBitmap.Width, BBitmap.Height));

        OffsetX := BBitmap.Width  div 2 - ABitmap.Width  div 2;
        OffsetY := BBitmap.Height div 2 - ABitmap.Height div 2;

        BBitmap.Canvas.Draw(OffsetX, OffsetY, ABitmap);

        ABitmap.Assign(BBitmap);
      finally
        BBitmap.Free;
      end;
    end
  else if (ABitmap.Width > AImageList.Width) and (ABitmap.Height > AImageList.Height) then
    begin

    end
  else if (ABitmap.Width <> AImageList.Width) and (ABitmap.Height <> AImageList.Height) then
    raise Exception.Create('Image Width and Height must be the same as other images, or both smaller, or both larger');

  AImageList.InsertMasked(AImageList.Count, ABitmap, ABitmap.TransparentColor);

  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ImageListAdd(ImageListIndex: Integer; ABitmap: TBitmap);
begin
  ImageListLoadFromBitmap(ImageListIndex, ABitmap);
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ImageListLoadFromResourceID(ImageListIndex: Integer; Instance: Cardinal; ResID: Integer);
var
  ABitmap : TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.LoadFromResourceID(Instance, ResID);
    ImageListLoadFromBitmap(ImageListIndex, ABitmap);
  finally
    ABitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.ImageListLoadFromResourceName(ImageListIndex: Integer; Instance: Cardinal; ResName: String);
var
  ABitmap : TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.LoadFromResourceName(Instance, ResName);

    ImageListLoadFromBitmap(ImageListIndex, ABitmap);
  finally
    ABitmap.Free;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetSelectModeActive: Boolean;
begin
  Result := False;
  if ToolBarCount <> 0 then Result := ToolBar[0].SelectActive;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.SetSelectModeActive(const Value: Boolean);
begin
  if ToolBarCount <> 0 then if ToolBar[0].SelectActive <> Value then ToolBar[0].DoButtonClickSelect;
end;
//****************************************************************************************************************************************************
procedure TiPlotComponent.TransferChannelData(SourceChannelIndex, DestinationChannelIndex, StartIndex, StopIndex: Integer);
var
  x                  : Integer;
  SourceChannel      : TiPlotChannelCustom;
  DestinationChannel : TiPlotChannelCustom;
  Index              : Integer;
begin
  SourceChannel      := Channel[SourceChannelIndex];
  DestinationChannel := Channel[DestinationChannelIndex];

  if StartIndex < 0                       then raise Exception.Create('Start Index Must be 0 or Greater');
  if StopIndex  > (SourceChannel.Count-1) then raise Exception.Create('StopIndex Must Out Of Range');

  for x := StartIndex to StopIndex do
    begin
      Index := DestinationChannel.AddXY(SourceChannel.DataX[x], SourceChannel.DataY[x]);

      DestinationChannel.DataNull [Index] := SourceChannel.DataNull[x];
      DestinationChannel.DataEmpty[Index] := SourceChannel.DataEmpty[x];

    end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetSavingSeparator: Char;
begin
  case FDataFileColumnSeparator of
    ipdfcsTab : Result := #9;
    else        Result := ',';
  end;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.ValueIsNull(Value: Double): Boolean;
begin
  if (Value < 1E-300) and (Value > 1E-301) then Result := True else Result := False;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.ValueIsEmpty(Value: Double): Boolean;
begin
  if (Value < 1E-301) and (Value > 1E-302) then Result := True else Result := False;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.ValueIsNotDataPoint(Value: Double): Boolean;
begin
  if (Value < 1E-302) and (Value > 1E-303) then Result := True else Result := False;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetNullValue: Double;
begin
  Result := 5E-301;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetEmptyValue: Double;
begin
  Result := 5E-302;
end;
//****************************************************************************************************************************************************
function TiPlotComponent.GetNotDataPoint: Double;
begin
  Result := 5E-307;
end;
//****************************************************************************************************************************************************
{$IFDEF NASA_KENNEDY}
procedure TiPlotComponent.Nasa_KennedyGetRegistryOptions();
begin
  inherited Nasa_KennedyGetRegistryOptions;
  FDetailsEnabled := False;
end;
{$ENDIF}
//****************************************************************************************************************************************************
end.


