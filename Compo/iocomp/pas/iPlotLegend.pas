{*******************************************************}
{                                                       }
{       TiPlotLegend                                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotLegend;{$endif}
{$ifdef iCLX}unit QiPlotLegend;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iPlotObjects,  iPlotChannelCustom;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiPlotObjects, QiPlotChannelCustom;{$ENDIF}

type
  TiPlotLegendChannelNameColorStyle = (iplcncsFont, iplcncsChannelColor, iplcncsXAxisFontColor, iplcncsYAxisFontColor);

  TiPlotLegendButton = class(TiPlotButton)
  public
    procedure Draw(const Canvas: TCanvas; const BackGroundColor: TColor); override;
  end;

  TiPlotLegendItem = class(TObject)
  public
    Channel   : TiPlotChannelCustom;
    MaxHeight : Integer;
    ALeft     : Integer;
    ATop      : Integer;
    ARow      : Integer;
    ACol      : Integer;
  end;

  TiPlotLegend = class(TiPlotLayoutObject)
  private
    FUpButton                    : TiPlotLegendButton;
    FDownButton                  : TiPlotLegendButton;
    FRequiredWidth               : Integer;
    FRequiredHeight              : Integer;

    FInnerRect                   : TRect;

    FItemList                    : TStringList;
    FColumnList                  : TStringList;

    FColumnWidth                 : Integer;
    FItemWidth                   : Integer;
    FActualWrapColCount          : Integer;
    FActualWrapRowCount          : Integer;

    FColumnSpacingPixels         : Integer;
    FRowSpacingPixels            : Integer;
    FWrapSpacingPixels           : Integer;

    FColumnStartChannel          : Integer;
    FColumnStartLine             : Integer;
    FColumnStartMarker           : Integer;
    FColumnStartXName            : Integer;
    FColumnStartYName            : Integer;
    FColumnStartXValue           : Integer;
    FColumnStartYValue           : Integer;
    FColumnStartYMax             : Integer;
    FColumnStartYMin             : Integer;
    FColumnStartYMean            : Integer;

    FMaxWidthLine                : Integer;
    FMaxWidthMarker              : Integer;
    FMaxWidthChannelLabel        : Integer;
    FMaxWidthXName               : Integer;
    FMaxWidthYName               : Integer;
    FMaxWidthXValue              : Integer;
    FMaxWidthYValue              : Integer;
    FMaxWidthYMax                : Integer;
    FMaxWidthYMin                : Integer;
    FMaxWidthYMean               : Integer;

    FItemViewStartIndex          : Integer;
    FItemViewStopIndex           : Integer;
    FItemHeight                  : Integer;

    FMaxItemHeight               : Integer;

    FColumnTitlesHeightPixels    : Integer;
    FColumnTitlesMarginPixels    : Integer;

    FColumnTitlesRect            : TRect;
    FItemsRect                   : TRect;

    FMarginLeft                  : Double;
    FMarginRight                 : Double;
    FMarginBottom                : Double;
    FMarginTop                   : Double;
    FBackGroundTransparent       : Boolean;
    FBackGroundColor             : TColor;

    FColumnSpacing               : Double;
    FFont                        : TFont;

    FSelectedItemBackGroundColor : TColor;
    FSelectedItemFont            : TFont;

    FShowColumnLine              : Boolean;
    FShowColumnMarker            : Boolean;
    FShowColumnXName             : Boolean;
    FShowColumnYName             : Boolean;
    FShowColumnXValue            : Boolean;
    FShowColumnYValue            : Boolean;
    FColumnTitlesVisible         : Boolean;
    FColumnTitlesFont            : TFont;
    FChannelNameMaxWidth         : Double;
    FChannelNameColorStyle       : TiPlotLegendChannelNameColorStyle;
    FShowColumnYMax              : Boolean;
    FShowColumnYMin              : Boolean;
    FShowColumnYMean             : Boolean;

    FCursorAllChannels           : Boolean;
    FShowColumnXValue2           : Boolean;
    FShowColumnYValue2           : Boolean;

    FCaptionColumnYMax           : String;
    FCaptionColumnYValue         : String;
    FCaptionColumnTitle          : String;
    FCaptionColumnYMean          : String;
    FCaptionColumnXName          : String;
    FCaptionColumnYName          : String;
    FCaptionColumnXValue         : String;
    FCaptionColumnYMin           : String;

    FWrapColDesiredCount         : Integer;
    FWrapRowDesiredCount         : Integer;
    FWrapColAutoCountEnabled     : Boolean;
    FWrapRowAutoCountEnabled     : Boolean;
    FWrapRowAutoCountMax         : Integer;
    FWrapColAutoCountMax         : Integer;
    FWrapColSpacingMin           : Double;
    FWrapRowSpacingMin           : Double;
    FWrapRowSpacingAuto          : Boolean;
    FWrapColSpacingAuto          : Boolean;

    FLineColumnWidth             : Integer;
    FLineColumnHeight            : Integer;
  protected
    procedure SetMarginBottom               (const Value: Double);
    procedure SetMarginLeft                 (const Value: Double);
    procedure SetMarginRight                (const Value: Double);
    procedure SetMarginTop                  (const Value: Double);
    procedure SetBackGroundColor            (const Value: TColor);
    procedure SetBackGroundTransparent      (const Value: Boolean);
    procedure SetFont                       (const Value: TFont);
    procedure SetSelectedItemBackGroundColor(const Value: TColor);
    procedure SetSelectedItemFont           (const Value: TFont);
    procedure SetShowColumnLine             (const Value: Boolean);
    procedure SetShowColumnMarker           (const Value: Boolean);
    procedure SetShowColumnXAxisTitle       (const Value: Boolean);
    procedure SetShowColumnYAxisTitle       (const Value: Boolean);
    procedure SetShowColumnXValue           (const Value: Boolean);
    procedure SetShowColumnYValue           (const Value: Boolean);
    procedure SetShowColumnYMax             (const Value: Boolean);
    procedure SetShowColumnYMean            (const Value: Boolean);
    procedure SetShowColumnYMin             (const Value: Boolean);
    procedure SetColumnSpacing              (const Value: Double);
    procedure SetLineColumnWidth            (const Value: Integer);
    procedure SetLineColumnHeight           (const Value: Integer);
    procedure SetItemViewStartIndex         (const Value: Integer);
    procedure SetColumnTitlesFont           (const Value: TFont);
    procedure SetColumnTitlesVisible        (const Value: Boolean);
    procedure SetChannelNameMaxWidth        (const Value: Double);
    procedure SetChannelNameColorStyle      (const Value: TiPlotLegendChannelNameColorStyle);
    procedure SetWrapColDesiredCount        (const Value: Integer);
    procedure SetWrapRowDesiredCount        (const Value: Integer);
    procedure SetWrapColAutoCountEnabled    (const Value: Boolean);
    procedure SetWrapRowAutoCountEnabled    (const Value: Boolean);
    procedure SetWrapColAutoCountMax        (const Value: Integer);
    procedure SetWrapRowAutoCountMax        (const Value: Integer);
    procedure SetWrapColSpacingMin          (const Value: Double);
    procedure SetWrapRowSpacingMin          (const Value: Double);
    procedure SetWrapColSpacingAuto         (const Value: Boolean);
    procedure SetWrapRowSpacingAuto         (const Value: Boolean);

    procedure SetCaptionColumnTitle         (const Value: String);
    procedure SetCaptionColumnXAxisTitle    (const Value: String);
    procedure SetCaptionColumnXValue        (const Value: String);
    procedure SetCaptionColumnYAxisTitle    (const Value: String);
    procedure SetCaptionColumnYMax          (const Value: String);
    procedure SetCaptionColumnYMean         (const Value: String);
    procedure SetCaptionColumnYMin          (const Value: String);
    procedure SetCaptionColumnYValue        (const Value: String);

    procedure CalcRects            (Canvas : TCanvas);
    procedure CalcColumnChannelName(Canvas: TCanvas);
    procedure CalcColumnTitles     (Canvas: TCanvas);

    procedure ButtonInvalidate(Sender : TObject);
    procedure UpButtonClick   (Sender : TObject);
    procedure DownButtonClick (Sender : TObject);

    procedure ClearItemList;

    procedure NotificationSetFocus(Sender: TObject);                                                                  override;

    function  GetMouseObject(X, Y: Integer): TiPlotObject;                                                            override;
    function  GetMousePointer(APoint: TPoint): TCursor;                                                               override;
    procedure AddMenuItems(PopupMenu: TPopUpMenu);                                                                    override;

    procedure DoMouseUp         (MouseData: TiPlotMouseData);                                                         override;


    function GetRequiredWidth(const Canvas: TCanvas): Integer;                                                        override;
    procedure GetNewMax(Value: Integer; var Max: Integer);

    procedure Draw            (const Canvas: TCanvas; const BackGroundColor: TColor);                                 override;
    procedure DrawLine        (const Canvas: TCanvas; X, Y : Integer; AColor : TColor; LineStyle : TiPlotLineStyle);
    procedure DrawColumnTitles(const Canvas: TCanvas);
    procedure DrawDownButton  (const Canvas: TCanvas);
    procedure DrawUpButton    (const Canvas: TCanvas);
                                                                                      
    function GetXAxisNameText (iChannel: TiPlotChannelCustom): String;
    function GetYAxisNameText (iChannel: TiPlotChannelCustom): String;
    function GetXAxisValueText(iChannel: TiPlotChannelCustom): String;
    function GetYAxisValueText(iChannel: TiPlotChannelCustom): String;
    function GetYAxisMaxText  (iChannel: TiPlotChannelCustom): String;
    function GetYAxisMeanText (iChannel: TiPlotChannelCustom): String;
    function GetYAxisMinText  (iChannel: TiPlotChannelCustom): String;

    property CursorAllChannels : Boolean read FCursorAllChannels write FCursorAllChannels;
  public
    constructor Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);                  override;
    destructor  Destroy;                                                                                            override;

    property ViewStartIndex              : Integer                           read FItemViewStartIndex          write SetItemViewStartIndex;
    property ViewStopIndex               : Integer                           read FItemViewStopIndex;
  published
    property MarginLeft                  : Double                            read FMarginLeft                  write SetMarginLeft;
    property MarginTop                   : Double                            read FMarginTop                   write SetMarginTop;
    property MarginRight                 : Double                            read FMarginRight                 write SetMarginRight;
    property MarginBottom                : Double                            read FMarginBottom                write SetMarginBottom;

    property BackGroundColor             : TColor                            read FBackGroundColor             write SetBackGroundColor              default clGray;
    property BackGroundTransparent       : Boolean                           read FBackGroundTransparent       write SetBackGroundTransparent        default True;

    property SelectedItemBackGroundColor : TColor                            read FSelectedItemBackGroundColor write SetSelectedItemBackGroundColor  default clYellow;
    property SelectedItemFont            : TFont                             read FSelectedItemFont            write SetSelectedItemFont;

    property ShowColumnLine              : Boolean                           read FShowColumnLine              write SetShowColumnLine               default True;
    property ShowColumnMarker            : Boolean                           read FShowColumnMarker            write SetShowColumnMarker             default False;
    property ShowColumnXAxisTitle        : Boolean                           read FShowColumnXName             write SetShowColumnXAxisTitle         default False;
    property ShowColumnYAxisTitle        : Boolean                           read FShowColumnYName             write SetShowColumnYAxisTitle         default False;
    property ShowColumnXValue            : Boolean                           read FShowColumnXValue            write SetShowColumnXValue             default False;
    property ShowColumnYValue            : Boolean                           read FShowColumnYValue            write SetShowColumnYValue             default False;
    property ShowColumnYMax              : Boolean                           read FShowColumnYMax              write SetShowColumnYMax               default False;
    property ShowColumnYMin              : Boolean                           read FShowColumnYMin              write SetShowColumnYMin               default False;
    property ShowColumnYMean             : Boolean                           read FShowColumnYMean             write SetShowColumnYMean              default False;

    property CaptionColumnTitle          : String                            read FCaptionColumnTitle          write SetCaptionColumnTitle;
    property CaptionColumnXAxisTitle     : String                            read FCaptionColumnXName          write SetCaptionColumnXAxisTitle;
    property CaptionColumnYAxisTitle     : String                            read FCaptionColumnYName          write SetCaptionColumnYAxisTitle;
    property CaptionColumnXValue         : String                            read FCaptionColumnXValue         write SetCaptionColumnXValue;
    property CaptionColumnYValue         : String                            read FCaptionColumnYValue         write SetCaptionColumnYValue;
    property CaptionColumnYMax           : String                            read FCaptionColumnYMax           write SetCaptionColumnYMax;
    property CaptionColumnYMin           : String                            read FCaptionColumnYMin           write SetCaptionColumnYMin;
    property CaptionColumnYMean          : String                            read FCaptionColumnYMean          write SetCaptionColumnYMean;

    property Font                        : TFont                             read FFont                        write SetFont;
    property ColumnSpacing               : Double                            read FColumnSpacing               write SetColumnSpacing;
    property RowSpacing                  : Double                            read FWrapRowSpacingMin           write SetWrapRowSpacingMin;

    property WrapColDesiredCount         : Integer                           read FWrapColDesiredCount         write SetWrapColDesiredCount;
    property WrapColAutoCountEnabled     : Boolean                           read FWrapColAutoCountEnabled     write SetWrapColAutoCountEnabled;
    property WrapColAutoCountMax         : Integer                           read FWrapColAutoCountMax         write SetWrapColAutoCountMax;
    property WrapColSpacingMin           : Double                            read FWrapColSpacingMin           write SetWrapColSpacingMin;
    property WrapColSpacingAuto          : Boolean                           read FWrapColSpacingAuto          write SetWrapColSpacingAuto;

    property WrapRowDesiredCount         : Integer                           read FWrapRowDesiredCount         write SetWrapRowDesiredCount;
    property WrapRowAutoCountEnabled     : Boolean                           read FWrapRowAutoCountEnabled     write SetWrapRowAutoCountEnabled;
    property WrapRowAutoCountMax         : Integer                           read FWrapRowAutoCountMax         write SetWrapRowAutoCountMax;
    property WrapRowSpacingMin           : Double                            read FWrapRowSpacingMin           write SetWrapRowSpacingMin;
    property WrapRowSpacingAuto          : Boolean                           read FWrapRowSpacingAuto          write SetWrapRowSpacingAuto;

    property ColumnTitlesVisible         : Boolean                           read FColumnTitlesVisible         write SetColumnTitlesVisible          default False;
    property ColumnTitlesFont            : TFont                             read FColumnTitlesFont            write SetColumnTitlesFont;
    property ChannelNameMaxWidth         : Double                            read FChannelNameMaxWidth         write SetChannelNameMaxWidth;
    property ChannelNameColorStyle       : TiPlotLegendChannelNameColorStyle read FChannelNameColorStyle       write SetChannelNameColorStyle        default iplcncsFont;

    property LineColumnWidth             : Integer                           read FLineColumnWidth             write SetLineColumnWidth  default 13;
    property LineColumnHeight            : Integer                           read FLineColumnHeight            write SetLineColumnHeight default 13;
  end;

implementation

uses                                                                                      
{$ifdef iVCL} iPlotManagers,  iPlotAxis,  iPlotChannel,  iXYPlotChannel,  iPlotComponent;{$endif}
{$ifdef iCLX}QiPlotManagers, QiPlotAxis, QiPlotChannel, QiXYPlotChannel, QiPlotComponent;{$endif}

type
  TiPlotChannelCustomAccess = class(TiPlotChannelCustom) end;
  TiPlotAxisAccess          = class(TiPlotAxis         ) end;
  TiPlotComponentAccess     = class(TiPlotComponent    )end;
//****************************************************************************************************************************************************
constructor TiPlotLegend.Create(AOwner: TObject; AOnChange, AOnInsert, AOnRemove, AOnRename: TNotifyEvent);
begin
  inherited;

  FMarginLeft                  := 1;
  FMarginRight                 := 1;
  FMarginBottom                := 1;
  FMarginTop                   := 1;

  FBackGroundColor             := clGray;
  FBackGroundTransparent       := True;
  FColumnSpacing               := 0.5;
  FShowColumnLine              := True;

  FWrapColDesiredCount         := 1;
  FWrapRowDesiredCount         := 5;

  FWrapColAutoCountMax         := 100;
  FWrapRowAutoCountMax         := 100;

  FWrapColAutoCountEnabled     := False;
  FWrapRowAutoCountEnabled     := True;

  FWrapColSpacingAuto          := True;
  FWrapRowSpacingAuto          := False;

  FWrapColSpacingMin           := 2;
  FWrapRowSpacingMin           := 0.25;

  FCaptionColumnTitle          := 'Title';
  FCaptionColumnXName          := 'X-Axis';
  FCaptionColumnYName          := 'Y-Axis';
  FCaptionColumnXValue         := 'X';
  FCaptionColumnYValue         := 'Y';
  FCaptionColumnYMax           := 'Y-Max';
  FCaptionColumnYMin           := 'Y-Min';
  FCaptionColumnYMean          := 'Y-Mean';

  FSelectedItemBackGroundColor := clYellow;

  FLineColumnWidth             := 13;
  FLineColumnHeight            := 3;

  Horizontal          := False;

  FItemList           := TStringList.Create;
  FColumnList         := TStringList.Create;

  FFont             := TFont.Create; FFont.OnChange             := TriggerChange; FFont.Color             := clWhite;
  FSelectedItemFont := TFont.Create; FSelectedItemFont.OnChange := TriggerChange; FSelectedItemFont.Color := clBlack;
  FColumnTitlesFont := TFont.Create; FColumnTitlesFont.OnChange := TriggerChange; FColumnTitlesFont.Color := clAqua; FColumnTitlesFont.Style := [fsBold];

  FUpButton   := TiPlotLegendButton.Create(Owner, nil, nil, nil, nil);
  with FUpButton do
    begin
      TimerEnabled := True;
      OnClick      := UpButtonClick;
      OnInvalidate := ButtonInvalidate;
    end;

  FDownButton := TiPlotLegendButton.Create(Owner, nil, nil, nil, nil);
  with FDownButton do
    begin
      TimerEnabled := True;
      OnClick      := DownButtonClick;
      OnInvalidate := ButtonInvalidate;
    end;
end;
//****************************************************************************************************************************************************
destructor TiPlotLegend.Destroy;
begin
  ClearItemList;

  FItemList.Free;
  FColumnList.Free;

  FFont.Free;
  FSelectedItemFont.Free;
  FColumnTitlesFont.Free;

  FUpButton.Free;
  FDownButton.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.ClearItemList;
begin
  while FItemList.Count <> 0 do
    begin
      FItemList.Objects[0].Free;
      FItemList.Delete(0);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.AddMenuItems(PopupMenu: TPopUpMenu);
begin
  inherited AddMenuItems(PopupMenu);
  AddEditMenuItems(PopupMenu);
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetMouseObject(X, Y: Integer): TiPlotObject;
var
  i        : Integer;
  iChannel : TiPlotChannelCustom;
begin
  Result := inherited GetMouseObject(X, Y);

  if      PtInRect(FUpButton.DrawRect,   Point(X, Y)) then Result := FUpButton
  else if PtInRect(FDownButton.DrawRect, Point(X, Y)) then Result := FDownButton
  else
  for i := 0 to FItemList.Count-1 do
    begin
      iChannel := (FItemList.Objects[i] as TiPlotLegendItem).Channel;
      if not iChannel.VisibleInLegend then Continue;
      if PtInRect(TiPlotChannelCustomAccess(iChannel).LegendRect, Point(X, Y)) then
        begin
          Result := iChannel;
          Break;
        end
    end;
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetMousePointer(APoint: TPoint): TCursor;
begin
  inherited GetMousePointer(APoint);

  TiPlotComponentAccess(Owner).DoGetMouseCursor(Self, Result);
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.SetMarginBottom               (const Value:Double );begin SetDoubleProperty (Value,FMarginBottom,               TriggerChange);end;
procedure TiPlotLegend.SetMarginLeft                 (const Value:Double );begin SetDoubleProperty (Value,FMarginLeft,                 TriggerChange);end;
procedure TiPlotLegend.SetMarginRight                (const Value:Double );begin SetDoubleProperty (Value,FMarginRight,                TriggerChange);end;
procedure TiPlotLegend.SetMarginTop                  (const Value:Double );begin SetDoubleProperty (Value,FMarginTop,                  TriggerChange);end;
procedure TiPlotLegend.SetBackGroundColor            (const Value:TColor );begin SetColorProperty  (Value,FBackGroundColor,            TriggerChange);end;
procedure TiPlotLegend.SetBackGroundTransparent      (const Value:Boolean);begin SetBooleanProperty(Value,FBackGroundTransparent,      TriggerChange);end;
procedure TiPlotLegend.SetSelectedItemBackGroundColor(const Value:TColor );begin SetColorProperty  (Value,FSelectedItemBackGroundColor,TriggerChange);end;
procedure TiPlotLegend.SetShowColumnLine             (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnLine,             TriggerChange);end;
procedure TiPlotLegend.SetShowColumnMarker           (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnMarker,           TriggerChange);end;
procedure TiPlotLegend.SetShowColumnXAxisTitle       (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnXName,            TriggerChange);end;
procedure TiPlotLegend.SetShowColumnYAxisTitle       (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnYName,            TriggerChange);end;
procedure TiPlotLegend.SetShowColumnXValue           (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnXValue,           TriggerChange);end;
procedure TiPlotLegend.SetShowColumnYValue           (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnYValue,           TriggerChange);end;
procedure TiPlotLegend.SetShowColumnYMax             (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnYMax,             TriggerChange);end;
procedure TiPlotLegend.SetShowColumnYMin             (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnYMin,             TriggerChange);end;
procedure TiPlotLegend.SetShowColumnYMean            (const Value:Boolean);begin SetBooleanProperty(Value,FShowColumnYMean,            TriggerChange);end;
procedure TiPlotLegend.SetColumnSpacing              (const Value:Double );begin SetDoubleProperty (Value,FColumnSpacing,              TriggerChange);end;
procedure TiPlotLegend.SetColumnTitlesVisible        (const Value:Boolean);begin SetBooleanProperty(Value,FColumnTitlesVisible,        TriggerChange);end;
procedure TiPlotLegend.SetChannelNameMaxWidth        (const Value:Double );begin SetDoubleProperty (Value,FChannelNameMaxWidth,        TriggerChange);end;
procedure TiPlotLegend.SetWrapColAutoCountEnabled    (const Value:Boolean);begin SetBooleanProperty(Value,FWrapColAutoCountEnabled,    TriggerChange);end;
procedure TiPlotLegend.SetWrapRowAutoCountEnabled    (const Value:Boolean);begin SetBooleanProperty(Value,FWrapRowAutoCountEnabled,    TriggerChange);end;
procedure TiPlotLegend.SetWrapColAutoCountMax        (const Value:Integer);begin SetIntegerProperty(Value,FWrapColAutoCountMax,        TriggerChange);end;
procedure TiPlotLegend.SetWrapRowAutoCountMax        (const Value:Integer);begin SetIntegerProperty(Value,FWrapRowAutoCountMax,        TriggerChange);end;
procedure TiPlotLegend.SetWrapColSpacingMin          (const Value:Double );begin SetDoubleProperty (Value,FWrapColSpacingMin,          TriggerChange);end;
procedure TiPlotLegend.SetWrapRowSpacingMin          (const Value:Double );begin SetDoubleProperty (Value,FWrapRowSpacingMin,          TriggerChange);end;
procedure TiPlotLegend.SetWrapColSpacingAuto         (const Value:Boolean);begin SetBooleanProperty(Value,FWrapColSpacingAuto,         TriggerChange);end;
procedure TiPlotLegend.SetWrapRowSpacingAuto         (const Value:Boolean);begin SetBooleanProperty(Value,FWrapRowSpacingAuto,         TriggerChange);end;
procedure TiPlotLegend.SetCaptionColumnTitle         (const Value:String );begin SetStringProperty (Value,FCaptionColumnTitle,         TriggerChange);end;
procedure TiPlotLegend.SetCaptionColumnXAxisTitle    (const Value:String );begin SetStringProperty (Value,FCaptionColumnXName,         TriggerChange);end;
procedure TiPlotLegend.SetCaptionColumnXValue        (const Value:String );begin SetStringProperty (Value,FCaptionColumnXValue,        TriggerChange);end;
procedure TiPlotLegend.SetCaptionColumnYAxisTitle    (const Value:String );begin SetStringProperty (Value,FCaptionColumnYName,         TriggerChange);end;
procedure TiPlotLegend.SetCaptionColumnYMax          (const Value:String );begin SetStringProperty (Value,FCaptionColumnYMax,          TriggerChange);end;
procedure TiPlotLegend.SetCaptionColumnYMean         (const Value:String );begin SetStringProperty (Value,FCaptionColumnYMean,         TriggerChange);end;
procedure TiPlotLegend.SetCaptionColumnYMin          (const Value:String );begin SetStringProperty (Value,FCaptionColumnYMin,          TriggerChange);end;
procedure TiPlotLegend.SetCaptionColumnYValue        (const Value:String );begin SetStringProperty (Value,FCaptionColumnYValue,        TriggerChange);end;
procedure TiPlotLegend.SetLineColumnWidth            (const Value:Integer);begin SetIntegerProperty(Value,FLineColumnWidth,            TriggerChange);end;
procedure TiPlotLegend.SetLineColumnHeight           (const Value:Integer);begin SetIntegerProperty(Value,FLineColumnHeight,           TriggerChange);end;
procedure TiPlotLegend.SetItemViewStartIndex         (const Value:Integer);begin SetIntegerProperty(Value,FItemViewStartIndex,         TriggerChange);end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.SetFont            (const Value:TFont);begin FFont.Assign(Value);            end;
procedure TiPlotLegend.SetSelectedItemFont(const Value:TFont);begin FSelectedItemFont.Assign(Value);end;
procedure TiPlotLegend.SetColumnTitlesFont(const Value:TFont);begin FColumnTitlesFont.Assign(Value);end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.SetChannelNameColorStyle(const Value:TiPlotLegendChannelNameColorStyle);
begin
  if FChannelNameColorStyle <> Value then
    begin
      FChannelNameColorStyle := Value;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.SetWrapColDesiredCount(const Value:Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue < 1 then TempValue := 1;
  if FWrapColDesiredCount <> TempValue then
    begin
      FWrapColDesiredCount := TempValue;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.SetWrapRowDesiredCount(const Value:Integer);
var
  TempValue : Integer;
begin
  TempValue := Value;
  if TempValue < 1 then TempValue := 1;
  if FWrapRowDesiredCount <> TempValue then
    begin
      FWrapRowDesiredCount := TempValue;
      TriggerChange(Self);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.GetNewMax(Value: Integer; var Max: Integer);
begin
  if Value > Max then Max := Value;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.CalcColumnChannelName(Canvas: TCanvas);
var
  ACharWidth  : Integer;
  ACharHeight : Integer;
  AText       : String;
  x           : Integer;
  LegendItem  : TiPlotLegendItem;
  iChannel    : TiPlotChannelCustom;
  MaxHeight   : Integer;
begin
  with Canvas, DrawRect do
    begin
      Font.Assign(FFont);

      if FChannelNameMaxWidth = 0 then
        begin
          ACharHeight := TextHeight('0');
          FMaxWidthChannelLabel := 0;

          for x := 0 to FItemList.Count - 1 do
            begin
              LegendItem := FItemList.Objects[x] as TiPlotLegendItem;
              iChannel   := LegendItem.Channel;
              LegendItem.MaxHeight := ACharHeight;
              if Trim(iChannel.TitleText) <> '' then AText := iChannel.TitleText else AText := iChannel.Name;

              Font.Assign(FFont);             GetNewMax(TextWidth(AText), FMaxWidthChannelLabel);
              Font.Assign(FSelectedItemFont); GetNewMax(TextWidth(AText), FMaxWidthChannelLabel);
            end;
        end
      else
        begin
          ACharWidth := TextWidth ('0');
          FMaxWidthChannelLabel := Round(FChannelNameMaxWidth * ACharWidth);
          for x := 0 to FItemList.Count - 1 do
            begin
              MaxHeight := 0;

              LegendItem := FItemList.Objects[x] as TiPlotLegendItem;
              iChannel   := LegendItem.Channel;

              Font.Assign(FFont);             GetNewMax(iTextHeightFixedWidth(Canvas, iChannel.TitleText, FMaxWidthChannelLabel), MaxHeight);
              Font.Assign(FSelectedItemFont); GetNewMax(iTextHeightFixedWidth(Canvas, iChannel.TitleText, FMaxWidthChannelLabel), MaxHeight);

              LegendItem.MaxHeight := MaxHeight;
            end;
        end;
    end;

  for x := 0 to FItemList.Count - 1 do
    begin
      LegendItem := FItemList.Objects[x] as TiPlotLegendItem;
      GetNewMax(LegendItem.MaxHeight, FMaxItemHeight);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.CalcColumnTitles(Canvas: TCanvas);
begin
  with Canvas, DrawRect do
    begin
      if FColumnTitlesVisible then
        begin
          Font.Assign(FColumnTitlesFont);
          FColumnTitlesHeightPixels := TextHeight('0');
          FColumnTitlesMarginPixels := FColumnTitlesHeightPixels div 4;

                                     GetNewMax(TextWidth(GetTranslation(FCaptionColumnTitle )), FMaxWidthChannelLabel);
          if FShowColumnXName   then GetNewMax(TextWidth(GetTranslation(FCaptionColumnXName )), FMaxWidthXName);
          if FShowColumnYName   then GetNewMax(TextWidth(GetTranslation(FCaptionColumnYName )), FMaxWidthYName);
          if FShowColumnXValue2 then GetNewMax(TextWidth(GetTranslation(FCaptionColumnXValue)), FMaxWidthXValue);
          if FShowColumnYValue2 then GetNewMax(TextWidth(GetTranslation(FCaptionColumnYValue)), FMaxWidthYValue);
          if FShowColumnYMax    then GetNewMax(TextWidth(GetTranslation(FCaptionColumnYMax  )), FMaxWidthYMax);
          if FShowColumnYMin    then GetNewMax(TextWidth(GetTranslation(FCaptionColumnYMin  )), FMaxWidthYMin);
          if FShowColumnYMean   then GetNewMax(TextWidth(GetTranslation(FCaptionColumnYMean )), FMaxWidthYMean);
        end
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.CalcRects(Canvas: TCanvas);
var
  x                   : Integer;
  ACharWidth          : Integer;
  ACharHeight         : Integer;
  iChannel            : TiPlotChannelCustom;
  CurrentX            : Integer;
  LegendItem          : TiPlotLegendItem;
  ItemCount           : Integer;

  CurrentTop          : Integer;

  RowCount            : Integer;
  MaxRowHeight        : Integer;
  MaxCurrentRowHeight : Integer;

  ColumnIndex         : Integer;
  RowIndex            : Integer;

  MarginTopPixels     : Integer;
  MarginBottomPixels  : Integer;
  MarginLeftPixels    : Integer;
  MarginRightPixels   : Integer;

  MaxColCount         : Integer;
  MaxRowCount         : Integer;
  MaxWidth            : Integer;
  MaxHeight           : Integer;

  ActualWidth         : Integer;
  ActualHeight        : Integer;
  ActualColSpacing    : Integer;
  ActualRowCount      : Integer;
begin
  with Canvas, DrawRect do
    begin
      Font.Assign(FFont);

      FColumnList.Clear;

      ACharWidth                := TextWidth ('0');
      ACharHeight               := TextHeight('0');

      ActualRowCount            := 0;

      MarginTopPixels           := Round(FMarginTop   *ACharHeight);
      MarginBottomPixels        := Round(FMarginBottom*ACharHeight);
      MarginLeftPixels          := Round(FMarginLeft  *ACharWidth);
      MarginRightPixels         := Round(FMarginRight *ACharWidth);

      FInnerRect                := Rect(Left + MarginLeftPixels, Top + MarginTopPixels, Right - MarginRightPixels, Bottom - MarginBottomPixels);

      FColumnSpacingPixels      := Round(ACharWidth * FColumnSpacing);
      FRowSpacingPixels         := Round(ACharHeight*FWrapRowSpacingMin);
      FWrapSpacingPixels        := Round(ACharHeight*FWrapColSpacingMin);

      FItemHeight               := ACharHeight;
      FMaxItemHeight            := 0;

      FColumnWidth              := 0;

      FColumnTitlesHeightPixels := 0;
      FColumnTitlesMarginPixels := 0;

      FMaxWidthLine             := 0;
      FMaxWidthMarker           := 0;
      FMaxWidthChannelLabel     := 0;
      FMaxWidthXName            := 0;
      FMaxWidthYName            := 0;
      FMaxWidthXValue           := 0;
      FMaxWidthYValue           := 0;
      FMaxWidthYMax             := 0;
      FMaxWidthYMin             := 0;
      FMaxWidthYMean            := 0;

      FShowColumnXValue2        := FShowColumnXValue or FCursorAllChannels;
      FShowColumnYValue2        := FShowColumnYValue or FCursorAllChannels;

      ClearItemList;
      for x := 0 to TiPlotComponentAccess(Owner).ChannelCount - 1 do
        begin
          iChannel := TiPlotComponentAccess(Owner).Channel[x] as TiPlotChannelCustom;
          if iChannel.VisibleInLegend then
            begin
              LegendItem := TiPlotLegendItem.Create;
              LegendItem.Channel := iChannel;
              FItemList.AddObject('', LegendItem);
            end;
        end;

      ItemCount := FItemList.Count;

      if ItemCount = 0 then Exit;

      if FItemViewStartIndex < 0           then FItemViewStartIndex := 0;
      if FItemViewStartIndex > ItemCount-1 then FItemViewStartIndex := ItemCount-1;

      CalcColumnChannelName(Canvas);
      CalcColumnTitles     (Canvas);

      if FShowColumnLine    then GetNewMax(LineColumnWidth + 3, FMaxWidthLine);
      if FShowColumnMarker  then GetNewMax(LineColumnWidth + 3, FMaxWidthMarker);
      //----------------------------------------------------------------------------------------------------------------
      Font.Assign(FFont);
      for x := 0 to ItemCount - 1 do
        begin
          LegendItem := (FItemList.Objects[x] as TiPlotLegendItem);

          if FShowColumnXName   then GetNewMax(TextWidth(GetXAxisNameText (LegendItem.Channel)), FMaxWidthXName);
          if FShowColumnYName   then GetNewMax(TextWidth(GetYAxisNameText (LegendItem.Channel)), FMaxWidthYName);

          if FCursorAllChannels then
            begin
              if Assigned(LegendItem.Channel.XAxis) then GetNewMax(TiPlotAxisAccess(LegendItem.Channel.XAxis).GetRequiredCursorLength(Canvas, FFont), FMaxWidthXValue);
              if Assigned(LegendItem.Channel.YAxis) then GetNewMax(TiPlotAxisAccess(LegendItem.Channel.YAxis).GetRequiredCursorLength(Canvas, FFont), FMaxWidthYValue);

              GetNewMax(Round(Length(LegendItem.Channel.DataCursorXText)*ACharWidth), FMaxWidthXValue);
              GetNewMax(Round(Length(LegendItem.Channel.DataCursorYText)*ACharWidth), FMaxWidthYValue);
            end
          else
            begin
              if Assigned(LegendItem.Channel.XAxis) then GetNewMax(TiPlotAxisAccess(LegendItem.Channel.XAxis).GetRequiredLegendLength(Canvas, FFont), FMaxWidthXValue);
              if Assigned(LegendItem.Channel.YAxis) then GetNewMax(TiPlotAxisAccess(LegendItem.Channel.YAxis).GetRequiredLegendLength(Canvas, FFont), FMaxWidthYValue);

              if FShowColumnXValue2 then GetNewMax(TextWidth(GetXAxisValueText(LegendItem.Channel)), FMaxWidthXValue);
              if FShowColumnYValue2 then GetNewMax(TextWidth(GetYAxisValueText(LegendItem.Channel)), FMaxWidthYValue);
            end;

          if FShowColumnYMax    then GetNewMax(TextWidth(GetYAxisMaxText  (LegendItem.Channel)), FMaxWidthYMax);
          if FShowColumnYMin    then GetNewMax(TextWidth(GetYAxisMinText  (LegendItem.Channel)), FMaxWidthYMin);
          if FShowColumnYMean   then GetNewMax(TextWidth(GetYAxisMeanText (LegendItem.Channel)), FMaxWidthYMean);
        end;

      CurrentX := 0;

      FColumnStartLine    := CurrentX; if FShowColumnLine    then CurrentX := CurrentX + FMaxWidthLine         + FColumnSpacingPixels;
      FColumnStartMarker  := CurrentX; if FShowColumnMarker  then CurrentX := CurrentX + FMaxWidthMarker       + FColumnSpacingPixels;
      FColumnStartChannel := CurrentX;                            CurrentX := CurrentX + FMaxWidthChannelLabel + FColumnSpacingPixels;
      FColumnStartXName   := CurrentX; if FShowColumnXName   then CurrentX := CurrentX + FMaxWidthXName        + FColumnSpacingPixels;
      FColumnStartYName   := CurrentX; if FShowColumnYName   then CurrentX := CurrentX + FMaxWidthYName        + FColumnSpacingPixels;
      FColumnStartXValue  := CurrentX; if FShowColumnXValue2 then CurrentX := CurrentX + FMaxWidthXValue       + FColumnSpacingPixels;
      FColumnStartYValue  := CurrentX; if FShowColumnYValue2 then CurrentX := CurrentX + FMaxWidthYValue       + FColumnSpacingPixels;
      FColumnStartYMax    := CurrentX; if FShowColumnYMax    then CurrentX := CurrentX + FMaxWidthYMax         + FColumnSpacingPixels;
      FColumnStartYMin    := CurrentX; if FShowColumnYMin    then CurrentX := CurrentX + FMaxWidthYMin         + FColumnSpacingPixels;
      FColumnStartYMean   := CurrentX; if FShowColumnYMean   then CurrentX := CurrentX + FMaxWidthYMean        + FColumnSpacingPixels;

      FItemWidth := CurrentX - FColumnSpacingPixels;

      FColumnTitlesRect  := Rect(FInnerRect.Left,  FInnerRect.Top,                                       FInnerRect.Right, FInnerRect.Top + FColumnTitlesHeightPixels);
      FItemsRect         := Rect(FInnerRect.Left,  FColumnTitlesRect.Bottom + FColumnTitlesMarginPixels, FInnerRect.Right, FInnerRect.Bottom);

      MaxWidth  := FItemsRect.Right  - FItemsRect.Left;
      MaxHeight := FItemsRect.Bottom - FItemsRect.Top;

      if Horizontal then MaxWidth := MaxWidth - 25;

      MaxColCount := (MaxWidth  + FWrapSpacingPixels) div (FItemWidth     + FWrapSpacingPixels);
      MaxRowCount := (MaxHeight + FRowSpacingPixels ) div (FMaxItemHeight + FRowSpacingPixels);

      if MaxColCount < 1 then MaxColCount := 1;
      if MaxRowCount < 1 then MaxRowCount := 1;

      if FWrapColAutoCountEnabled then                   FActualWrapColCount := FWrapColAutoCountMax
        else                                             FActualWrapColCount := FWrapColDesiredCount;

      if FWrapRowAutoCountEnabled  then                  FActualWrapRowCount := FWrapRowAutoCountMax
        else                                             FActualWrapRowCount := FWrapRowDesiredCount;
      //---------------------------------------------------------------------------------------------------------
      if Horizontal then
        begin                                                                                           
          if FActualWrapColCount > MaxColCount          then FActualWrapColCount := MaxColCount;

          if FWrapRowAutoCountEnabled then RowCount := (ItemCount + FActualWrapColCount -1) div FActualWrapColCount
            else                           RowCount := FActualWrapRowCount;

          if RowCount            > FActualWrapRowCount                       then RowCount := FActualWrapRowCount;
          if (RowCount < 3) and ((RowCount*FActualWrapColCount) < ItemCount) then RowCount := 3;

          if RowCount = 0 then
            begin
              FActualWrapColCount := 0;
            end
          else
            begin
              if FWrapColAutoCountEnabled then if FActualWrapColCount > (ItemCount + RowCount -1) div RowCount then
                FActualWrapColCount := (ItemCount + RowCount -1) div RowCount;
            end;
        end
      else
        begin
          if FWrapColAutoCountEnabled then FActualWrapColCount := (ItemCount + MaxRowCount -1) div MaxRowCount;
          if FActualWrapColCount > FWrapColAutoCountMax then FActualWrapColCount := FWrapColAutoCountMax;

          RowCount := MaxRowCount;

          if RowCount > ItemCount                                            then RowCount := ItemCount;
          if RowCount > FActualWrapRowCount                                  then RowCount := FActualWrapRowCount;
          if (RowCount < 3) and ((RowCount*FActualWrapColCount) < ItemCount) then RowCount := 3;
        end;
      //---------------------------------------------------------------------------------------------------------
      ColumnIndex        := 1;
      RowIndex           := 1;
      CurrentTop         := FItemsRect.Top;
      FItemViewStopIndex := ItemCount-1;

      FColumnList.AddObject('', Pointer(FInnerRect.Left));

      if FItemViewStartIndex <> -1 then
        begin
          for x := FItemViewStartIndex to ItemCount-1 do
            begin
              LegendItem       := (FItemList.Objects[x] as TiPlotLegendItem);
              LegendItem.ARow  := RowIndex;
              LegendItem.ACol  := ColumnIndex;
              LegendItem.ALeft := Integer(FColumnList.Objects[LegendItem.ACol-1]);
              LegendItem.ATop  := CurrentTop;

              if ColumnIndex = 1 then ActualRowCount := RowIndex;

              CurrentTop       := CurrentTop + FMaxItemHeight + FRowSpacingPixels;
              Inc(RowIndex);

              if (RowIndex > RowCount) and (x <> ItemCount-1) then
                begin
                  RowIndex   := 1;
                  CurrentTop := FItemsRect.Top;
                  Inc(ColumnIndex);
                  if ColumnIndex > FActualWrapColCount then
                    begin
                      FItemViewStopIndex := x;
                      Break;
                    end;
                  if (FColumnList.Count -1) < ColumnIndex then FColumnList.AddObject('', Pointer(FInnerRect.Left + (FItemWidth + FWrapSpacingPixels)*(ColumnIndex-1)));
                end;
            end;
        end;
      //---------------------------------------------------------------------------------------------------------
      FRequiredWidth  := MarginLeftPixels + (FActualWrapColCount*(FItemWidth) + FWrapSpacingPixels*(FActualWrapColCount -1)) + MarginRightPixels;
      FRequiredHeight := MarginTopPixels  + FColumnTitlesHeightPixels + FColumnTitlesMarginPixels + RowCount*(FMaxItemHeight + FRowSpacingPixels) - FRowSpacingPixels + MarginBottomPixels;

      if (ItemCount > RowCount*FActualWrapColCount) and Enabled then
        begin
          FUpButton.Visible    := True;
          FDownButton.Visible  := True;                                          
          FUpButton.DrawRect   := Rect(FItemsRect.Right-17, FItemsRect.Top,       FItemsRect.Right, FItemsRect.Top+17);
          FDownButton.DrawRect := Rect(FItemsRect.Right-17, FItemsRect.Bottom-17, FItemsRect.Right, FItemsRect.Bottom);

          FRequiredWidth       := FRequiredWidth + 25;
        end
      else
        begin
          FUpButton.Visible   := False;
          FDownButton.Visible := False;
          FItemViewStartIndex := 0;
        end;
    end;
  //---------------------------------------------------------------------------------------------------------
  if FWrapColSpacingAuto and Horizontal and (FActualWrapColCount > 1) then
    begin
      ActualWidth      := FItemsRect.Right - FItemsRect.Left -25;
      ActualColSpacing := Trunc((ActualWidth - FActualWrapColCount*FItemWidth)/(FActualWrapColCount - 1));

      for x := 0 to ItemCount-1 do
        begin
          LegendItem       := (FItemList.Objects[x] as TiPlotLegendItem);
          LegendItem.ALeft := FInnerRect.Left + (FItemWidth + ActualColSpacing)*(LegendItem.ACol-1);
        end;

      for x := 0 to FColumnList.Count-1 do
        FColumnList.Objects[x] := Pointer(FInnerRect.Left + (FItemWidth + ActualColSpacing)*x);
    end;
  //---------------------------------------------------------------------------------------------------------
  if FWrapRowSpacingAuto and (not Horizontal) and (ActualRowCount > 1) then
    begin
      FRowSpacingPixels := Trunc((MaxHeight - FMaxItemHeight*ActualRowCount)/(ActualRowCount - 1));

      for x := 0 to ItemCount-1 do
        begin
          LegendItem      := (FItemList.Objects[x] as TiPlotLegendItem);
          LegendItem.ATop := FInnerRect.Top + (LegendItem.ARow-1)*(FMaxItemHeight + FRowSpacingPixels);
          if FColumnTitlesVisible then LegendItem.ATop := LegendItem.ATop + FColumnTitlesHeightPixels + FColumnTitlesMarginPixels;
        end;
    end;
  //---------------------------------------------------------------------------------------------------------

  FUpButton.Enabled   := FItemViewStartIndex <> 0;
  FDownButton.Enabled := FItemViewStopIndex <> (ItemCount -1);
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  iChannel    : TiPlotChannelCustom;
  AText       : String;
  ARect       : TRect;
  x           : Integer;
  YPos        : Integer;
  CenterPoint : TPoint;
  Item        : TiPlotLegendItem;
begin
  if not Visible         then Exit;
  if FItemList.Count = 0 then Exit;
  CalcRects(Canvas);

  with Canvas, DrawRect do
    begin
      Brush.Style := bsSolid;
      Pen.Style   := psSolid;

      if not FBackGroundTransparent then
        begin
          Brush.Color := FBackGroundColor;
          FillRect(DrawRect);
        end;

      DrawColumnTitles(Canvas);
                                
      Font.Color := $FFEEDD; //Borland Bug Hack.
      Font.Assign(FFont);
      Brush.Style := bsClear;

      YPos := FItemsRect.Top;

      for x := 0 to FItemList.Count-1 do
        TiPlotChannelCustomAccess((FItemList.Objects[x] as TiPlotLegendItem).Channel).LegendRect := Rect(0,0,0,0);

      for x := FItemViewStartIndex to FItemViewStopIndex do
        begin
          Item := FItemList.Objects[x] as TiPlotLegendItem;
          iChannel := Item.Channel;

          ARect := Rect(Item.ALeft + FColumnStartChannel,                           Item.ATop,
                        Item.ALeft + FColumnStartChannel + FMaxWidthChannelLabel+1, Item.ATop + Item.MaxHeight);

          TiPlotChannelCustomAccess(iChannel).LegendRect := ARect;

          if FShowColumnLine then DrawLine(Canvas, Item.ALeft + FColumnStartLine, Item.ATop + FItemHeight div 2, iChannel.Color, iChannel.TraceLineStyle);

          if FShowColumnMarker then
            begin
              CenterPoint := Point(Item.ALeft + FColumnStartMarker + FMaxWidthMarker div 2, Item.ATop + FItemHeight div 2);
              TiPlotChannelCustomAccess(iChannel).DrawMarker(Canvas, -1, CenterPoint, BackGroundColor);
            end;

          if Trim(iChannel.TitleText) <> '' then AText := iChannel.TitleText else AText := iChannel.Name;

          if TiPlotChannelCustomAccess(iChannel).UserSelected then
            begin
              Brush.Style := bsSolid;
              Brush.Color := FSelectedItemBackGroundColor;
              FillRect(TiPlotChannelCustomAccess(iChannel).LegendRect);
              Font.Assign(FSelectedItemFont);
            end
          else
            begin
              Brush.Style := bsClear;
              Font.Assign(FFont);
            end;

          case FChannelNameColorStyle of
            iplcncsChannelColor   : Font.Color := iChannel.Color;
            iplcncsXAxisFontColor : if Assigned(TiPlotChannelCustomAccess(iChannel).XAxis) then Font.Color := TiPlotChannelCustomAccess(iChannel).XAxis.LabelsFont.Color;
            iplcncsYAxisFontColor : if Assigned(TiPlotChannelCustomAccess(iChannel).YAxis) then Font.Color := TiPlotChannelCustomAccess(iChannel).YAxis.LabelsFont.Color;
          end;


          iDrawText(Canvas, AText, ARect, [itfHLeft, itfVTop, itfWordBreak, itfWordEllipsis], True, clBtnFace);

          Brush.Style := bsClear;
          Font.Assign(FFont);

          if FShowColumnXName then
            begin
              AText := GetXAxisNameText(iChannel);
              ARect := Rect(Item.ALeft + FColumnStartXName, Item.ATop, Item.ALeft + FColumnStartXName + FMaxWidthXName, Item.ATop + FItemHeight);
              iDrawText(Canvas, AText, ARect, [itfHLeft, itfVCenter], True, clBtnFace);
            end;

          if FShowColumnYName then
            begin
              AText := GetYAxisNameText(iChannel);
              ARect := Rect(Item.ALeft + FColumnStartYName, Item.ATop, Item.ALeft + FColumnStartYName + FMaxWidthYName, Item.ATop + FItemHeight);
              iDrawText(Canvas, AText, ARect, [itfHLeft, itfVCenter], True, clBtnFace);
            end;

          if (FShowColumnXValue2) then
            begin
              if FCursorAllChannels then
                AText := iChannel.DataCursorXText
              else
                AText := GetXAxisValueText(iChannel);
              ARect      := Rect(Item.ALeft + FColumnStartXValue, Item.ATop, Item.ALeft + FColumnStartXValue + FMaxWidthXValue, Item.ATop + FItemHeight);
              iDrawText(Canvas, AText, ARect, [itfHRight, itfVCenter], True, clBtnFace);
            end;

          if (FShowColumnYValue2) then
            begin
              if FCursorAllChannels then
                AText := iChannel.DataCursorYText
              else
                AText := GetYAxisValueText(iChannel);
              ARect      := Rect(Item.ALeft + FColumnStartYValue, Item.ATop, Item.ALeft + FColumnStartYValue + FMaxWidthYValue, Item.ATop + FItemHeight);
              iDrawText(Canvas, AText, ARect, [itfHRight, itfVCenter], True, clBtnFace);
            end;

          if (FShowColumnYMax) then
            begin
              AText      := GetYAxisMaxText(iChannel);
              ARect      := Rect(Item.ALeft + FColumnStartYMax, Item.ATop, Item.ALeft + FColumnStartYMax + FMaxWidthYMax, Item.ATop + FItemHeight);
              iDrawText(Canvas, AText, ARect, [itfHRight, itfVCenter], True, clBtnFace);
            end;

          if (FShowColumnYMin) then
            begin
              AText      := GetYAxisMinText(iChannel);
              ARect      := Rect(Item.ALeft + FColumnStartYMin, Item.ATop, Item.ALeft + FColumnStartYMin + FMaxWidthYMin, Item.ATop + FItemHeight);
              iDrawText(Canvas, AText, ARect, [itfHRight, itfVCenter], True, clBtnFace);
            end;

          if (FShowColumnYMean) then
            begin
              AText      := GetYAxisMeanText(iChannel);
              ARect      := Rect(Item.ALeft + FColumnStartYMean, Item.ATop, Item.ALeft + FColumnStartYMean + FMaxWidthYMean, Item.ATop + FItemHeight);
              iDrawText(Canvas, AText, ARect, [itfHRight, itfVCenter], True, clBtnFace);
            end;

          YPos := YPos + Item.MaxHeight + FRowSpacingPixels;
        end;
    end;

  DrawUpButton  (Canvas);
  DrawDownButton(Canvas);

  if UserSelected then
    begin
      Canvas.Brush.Style := bsClear;
      Canvas.Font.Color := clWhite;
      if Horizontal then iDrawFocusRect2(Canvas, Rect(DrawRect.Left,   DrawRect.Top+2, DrawRect.Right,   DrawRect.Bottom-2))
        else             iDrawFocusRect2(Canvas, Rect(DrawRect.Left+2, DrawRect.Top,   DrawRect.Right-2, DrawRect.Bottom  ))
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.DrawColumnTitles(const Canvas: TCanvas);
var
  x     : Integer;
  ATop  : Integer;
  ARect : TRect;
  ALeft : Integer;
begin
  if not FColumnTitlesVisible then Exit;
  
  with Canvas do
    begin
      Font.Assign(FColumnTitlesFont);
      Brush.Style := bsClear;
                                                                                   
      for x := 0 to FColumnList.Count - 1 do
        begin
          ALeft := Integer(FColumnList.Objects[x]);
          ATop  := FColumnTitlesRect.Top;

          ARect := Rect(0, ATop, 0, ATop + FColumnTitlesHeightPixels);

            begin
              ARect.Left  := ALeft + FColumnStartChannel;
              ARect.Right := ALeft + FColumnStartChannel + FMaxWidthChannelLabel;
              iDrawText(Canvas, GetTranslation(FCaptionColumnTitle), ARect, [itfHLeft, itfVCenter, itfSingleLine, itfNoClip], True, clBtnFace);
            end;

          if FShowColumnXName then
            begin
              ARect.Left  := ALeft + FColumnStartXName;
              ARect.Right := ALeft + FColumnStartXName + FMaxWidthXName;
              iDrawText(Canvas, GetTranslation(FCaptionColumnXName), ARect, [itfHCenter, itfVCenter, itfSingleLine, itfNoClip], True, clBtnFace);
            end;

          if FShowColumnYName then
            begin
              ARect.Left  := ALeft + FColumnStartYName;
              ARect.Right := ALeft + FColumnStartYName + FMaxWidthYName;
              iDrawText(Canvas, GetTranslation(FCaptionColumnYName), ARect, [itfHCenter, itfVCenter, itfSingleLine, itfNoClip], True, clBtnFace);
           end;

          if (FShowColumnXValue2) then
            begin
              ARect.Left  := ALeft + FColumnStartXValue;
              ARect.Right := ALeft + FColumnStartXValue + FMaxWidthXValue;

              iDrawText(Canvas, GetTranslation(FCaptionColumnXValue), ARect, [itfHRight, itfVCenter, itfSingleLine, itfNoClip], True, clBtnFace);
            end;

          if (FShowColumnYValue2) then
            begin
              ARect.Left  := ALeft + FColumnStartYValue;
              ARect.Right := ALeft + FColumnStartYValue + FMaxWidthYValue;
              iDrawText(Canvas, GetTranslation(FCaptionColumnYValue), ARect, [itfHRight, itfVCenter, itfSingleLine, itfNoClip], True, clBtnFace);
            end;

          if (FShowColumnYMax) then
            begin
              ARect.Left  := ALeft + FColumnStartYMax;
              ARect.Right := ALeft + FColumnStartYMax + FMaxWidthYMax;
              iDrawText(Canvas, GetTranslation(FCaptionColumnYMax), ARect, [itfHRight, itfVCenter, itfSingleLine, itfNoClip], True, clBtnFace);
            end;

          if (FShowColumnYMin) then
            begin
              ARect.Left  := ALeft + FColumnStartYMin;
              ARect.Right := ALeft + FColumnStartYMin + FMaxWidthYMin;
              iDrawText(Canvas, GetTranslation(FCaptionColumnYMin), ARect, [itfHRight, itfVCenter, itfSingleLine, itfNoClip], True, clBtnFace);
            end;

          if (FShowColumnYMean) then
            begin
              ARect.Left  := ALeft + FColumnStartYMean;
              ARect.Right := ALeft + FColumnStartYMean + FMaxWidthYMean;
              iDrawText(Canvas, GetTranslation(FCaptionColumnYMean), ARect, [itfHRight, itfVCenter, itfSingleLine, itfNoClip], True, clBtnFace);
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.DrawLine(const Canvas: TCanvas; X, Y: Integer; AColor : TColor; LineStyle : TiPlotLineStyle);
var
  i : Integer;
begin
  with Canvas do
    begin
      Pen.Color := AColor;
      Pen.Width := 1;
      for i := -LineColumnHeight div 2 to -LineColumnHeight div 2 + LineColumnHeight do
        if LineColumnWidth = 13 then
          begin
            Pen.Style := psSolid;
            case LineStyle of
              iplsSolid      : begin
                                 PolyLine([Point(X,      Y+i), Point(X + 13, Y+i)]);
                               end;
              iplsDash       : begin
                                 PolyLine([Point(X,      Y+i), Point(X +  5, Y+i)]);
                                 PolyLine([Point(X +  8, Y+i), Point(X + 13, Y+i)]);
                               end;
              iplsDot        : begin
                                 PolyLine([Point(X,      Y+i), Point(X +  2, Y+i)]);
                                 PolyLine([Point(X +  4, Y+i), Point(X +  6, Y+i)]);
                                 PolyLine([Point(X +  8, Y+i), Point(X + 10, Y+i)]);
                               end;
              iplsDashDot    : begin
                                 PolyLine([Point(X,      Y+i), Point(X +  5, Y+i)]);
                                 PolyLine([Point(X +  7, Y+i), Point(X +  9, Y+i)]);
                               end;
              iplsDashDotDot : begin
                                 PolyLine([Point(X,      Y+i), Point(X +  5, Y+i)]);
                                 PolyLine([Point(X +  7, Y+i), Point(X +  9, Y+i)]);
                                 PolyLine([Point(X + 11, Y+i), Point(X + 13, Y+i)]);
                               end;
            end;
        end
      else
        begin
          Pen.Style := TPenStyle(LineStyle);
          PolyLine([Point(X, Y+i), Point(X + LineColumnWidth, Y+i)]);
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.DrawUpButton(const Canvas: TCanvas);
var
  CenterPoint : TPoint;
begin
  if not FUpButton.Visible then Exit;
  with Canvas do
    begin
      FUpButton.Draw(Canvas, BackGroundColor);

      if FUpButton.Enabled then
        begin
          Pen.Color   := clBlack;
          Brush.Color := clBlack;
        end
      else
        begin
          Pen.Color   := clGray;
          Brush.Color := clGray;
        end;

      CenterPoint.X := (FUpButton.Left   + FUpButton.Right) div 2;
      CenterPoint.Y := (FUpButton.Bottom + FUpButton.Top  ) div 2;

      Polygon([Point(CenterPoint.x - 4, CenterPoint.y + 2),
               Point(CenterPoint.x + 4, CenterPoint.y + 2),
               Point(CenterPoint.x,     CenterPoint.y - 2)]);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.DrawDownButton(const Canvas: TCanvas);
var
  CenterPoint : TPoint;
begin
  if not FDownButton.Visible then Exit;
  with Canvas do
    begin
      FDownButton.Draw(Canvas, BackGroundColor);

      if FDownButton.Enabled then
        begin
          Pen.Color   := clBlack;
          Brush.Color := clBlack;
        end
      else
        begin
          Pen.Color   := clGray;
          Brush.Color := clGray;
        end;

      CenterPoint.X := (FDownButton.Left   + FDownButton.Right) div 2;
      CenterPoint.Y := (FDownButton.Bottom + FDownButton.Top  ) div 2;

      Polygon([Point(CenterPoint.x - 4, CenterPoint.y - 2),
               Point(CenterPoint.x + 4, CenterPoint.y - 2),
               Point(CenterPoint.x,     CenterPoint.y + 2)]);
    end;
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetRequiredWidth(const Canvas: TCanvas) : Integer;
begin
  CalcRects(Canvas);
  if Horizontal then Result := FRequiredHeight else Result := FRequiredWidth;
end;
//****************************************************************************************************************************************************
{ TiPlotLegendButton }
//****************************************************************************************************************************************************
procedure TiPlotLegendButton.Draw(const Canvas: TCanvas; const BackGroundColor: TColor);
var
  ARect : TRect;
begin
  if not Visible then exit;
  with Canvas do
    begin
      Brush.Style := bsSolid;
      ARect       := DrawRect;
      Brush.Color := clBtnFace;
      FillRect(ARect);

      if MouseDown then
        iDrawEdge(Canvas, ARect, idesSunken)
      else
        iDrawEdge(Canvas, ARect, idesRaised);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.ButtonInvalidate(Sender: TObject);
begin
  TriggerInvalidateNow(Self);
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.DownButtonClick(Sender: TObject);
begin
  if FItemViewStartIndex < FItemList.Count-1 then FItemViewStartIndex := FItemViewStartIndex + 1;
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.UpButtonClick(Sender: TObject);
begin
  if FItemViewStartIndex > 0 then FItemViewStartIndex := FItemViewStartIndex - 1;
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetXAxisNameText(iChannel: TiPlotChannelCustom): String;
var
  XAxis : TiPlotAxis;
begin
  XAxis := TiPlotChannelCustomAccess(iChannel).XAxis;
  if Assigned(XAxis) then
    begin
      if Trim(XAxis.Title) <> '' then Result := XAxis.Title else Result := XAxis.Name;
    end
  else Result := GetTranslation('None');
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetYAxisNameText(iChannel: TiPlotChannelCustom): String;
var
  YAxis : TiPlotAxis;
begin
  YAxis := TiPlotChannelCustomAccess(iChannel).YAxis;
  if Assigned(YAxis) then
    begin
      if Trim(YAxis.Title) <> '' then Result := YAxis.Title else Result := YAxis.Name;
    end
  else Result := GetTranslation('None');
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetXAxisValueText(iChannel: TiPlotChannelCustom): String;
begin
  if iChannel.Count <> 0 then
    begin
      if Assigned(iChannel.XAxis) then
        Result := iChannel.XAxis.GetLegendText(iChannel.DataX[iChannel.Count-1])
      else Result := GetTranslation('N/A')
    end
  else Result := GetTranslation('Empty');
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetYAxisValueText(iChannel: TiPlotChannelCustom): String;
begin
  if iChannel.Count <> 0 then
    begin
      if Assigned(iChannel.YAxis) then
        Result := iChannel.YAxis.GetLegendText(iChannel.DataY[iChannel.Count-1])
      else Result := GetTranslation('N/A')
    end
  else Result := GetTranslation('Empty');
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetYAxisMaxText(iChannel: TiPlotChannelCustom): String;
begin
  if iChannel.Count <> 0 then
    begin
      if Assigned(iChannel.YAxis) then
        Result := iChannel.YAxis.GetLegendText(iChannel.RunningYMax)
      else Result := GetTranslation('N/A')
    end
  else Result := GetTranslation('Empty');
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetYAxisMinText(iChannel: TiPlotChannelCustom): String;
begin
  if iChannel.Count <> 0 then
    begin
      if Assigned(iChannel.YAxis) then
        Result := iChannel.YAxis.GetLegendText(iChannel.RunningYMin)
      else Result := GetTranslation('N/A')
    end
  else Result := GetTranslation('Empty');
end;
//****************************************************************************************************************************************************
function TiPlotLegend.GetYAxisMeanText(iChannel: TiPlotChannelCustom): String;
begin
  if iChannel.Count <> 0 then
    begin
      if Assigned(iChannel.YAxis) then
        Result := iChannel.YAxis.GetLegendText(iChannel.RunningYMean)
      else Result := GetTranslation('N/A')
    end
  else Result := GetTranslation('Empty');
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.NotificationSetFocus(Sender: TObject);
begin
  if Sender = Self                                                      then Exit;
  if not (Sender as TiPlotObject).UserSelected                          then Exit;

  SetUserSelected(False);
end;
//****************************************************************************************************************************************************
procedure TiPlotLegend.DoMouseUp(MouseData: TiPlotMouseData);
begin
  if not MouseDown then Exit;

  if PtInRect(DrawRect, Point(MouseData.X, MouseData.Y)) then TiPlotComponentAccess(Owner).DoObjectClick(Self);
end;
//****************************************************************************************************************************************************
end.
