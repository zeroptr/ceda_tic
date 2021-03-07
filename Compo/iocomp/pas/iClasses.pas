{*******************************************************}
{                                                       }
{       iClasses                                        }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iClasses;{$endif}
{$ifdef iCLX}unit QiClasses;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions,   iDoubleList, iDataNullList;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiDoubleList, QiDataNullList;{$ENDIF}

type
  TiURLShowCommand = (ssHide,
                      ssMaximize,
                      ssMinimize,
                      ssRestore,
                      ssShow,
                      ssShowDefault,
                      ssShowMaximized,
                      ssShowMinimized,
                      ssShowMinNoActivate,
                      ssShowNA,
                      ssShowNoActivate,
                      ssShowNormal);

  TiDraw = class(TObject)
  public
    {$IFDEF iVCL}function  Triangle(Canvas: TCanvas; r: TRect; Direction: TiQuadDirection; Style3D: TiBevelStyle; Color: TColor; Enabled: Boolean): HRGN; {$ENDIF}
    {$IFDEF iCLX}function  Triangle(Canvas: TCanvas; r: TRect; Direction: TiQuadDirection; Style3D: TiBevelStyle; Color: TColor; Enabled: Boolean): TRect;{$ENDIF}

    {$IFDEF iVCL}function  Pointer (Canvas: TCanvas; r: TRect; Direction: TiQuadDirection; Style3D: TiBevelStyle; Color: TColor; Enabled: Boolean): HRGN; {$ENDIF}
    {$IFDEF iCLX}function  Pointer (Canvas: TCanvas; r: TRect; Direction: TiQuadDirection; Style3D: TiBevelStyle; Color: TColor; Enabled: Boolean): TRect;{$ENDIF}

                 procedure Border      (Canvas: TCanvas; r: TRect; Inflate: Integer; Style: TiBevelStyle);
                 procedure GradientTube(Canvas: TCanvas; r : TRect; Color: TColor; Orientation: TiOrientation);
  end;

  TiMemoryStream = class(TMemoryStream)
  public
    procedure WriteString    (Value : String);
    procedure WriteStringCRLF(Value : String);
    procedure WriteCRLF;
    function  ReadChar : Char;
  end;

  TiUserSchemeList            = class(TStringList) end;
  TiIocompSchemeList          = class(TStringList) end;
  TiSchemeListClass           = class of TStringList;

  TiXMLMemoryStream = class(TiMemoryStream)
  private
    FCurrentElementStart: String;
  public
    procedure StartElement(Name : String);
    procedure EndElement  (Name : String);
    procedure WriteElement(Name, Value : String);

    function  GetElement      (Name  : String) : String;
    procedure GotoElementStart(Value : String);
    function  GetNameElementStart : String;
    function  GetElementValue     : String;
    function  GetNameElementStop  : String;

    function  GetNextPiece : String;
    function  PeekNextPiece: String;
    property  CurrentElementStart : String read FCurrentElementStart;
  end;

  TiPercentItemObject = class(TObject)
  public
    Title : String;
    Color : TColor;
    Value : Double;
  end;

  TiLimitObject = class(TObject)
  public
    UpperValue        : Double;
    LowerValue        : Double;
    PointerSize       : Integer;
    PointerMargin     : Integer;
    DrawScaleSide     : Boolean;
    UpperPointerColor : TColor;
    LowerPointerColor : TColor;
    ShowUpperPointer  : Boolean;
    ShowLowerPointer  : Boolean;
  end;

  TiStripChartVertLineObject = class(TObject)
  public
    Position : Double;
    Color    : TColor;
    Width    : Integer;
    Style    : TiChannelLineStyle;
  end;


  TiStripChartChannelObject = class(TObject)
  private
    FTrackLimitColors          : Boolean;
    FColor                     : TColor;
    FControlLimitUpperColor    : TColor;
    FControlLimitLowerColor    : TColor;
    FWarningLimitUpperColor    : TColor;
    FWarningLimitLowerColor    : TColor;
    procedure SetColor                 (const Value: TColor);
    procedure SetControlLimitLowerColor(const Value: TColor);
    procedure SetControlLimitUpperColor(const Value: TColor);
    procedure SetWarningLimitLowerColor(const Value: TColor);
    procedure SetWarningLimitUpperColor(const Value: TColor);
  public
    Title                      : String;
    LineStyle                  : TiChannelLineStyle;
    LineWidth                  : Integer;
    HighestIndex               : Integer;
    Visible                    : Boolean;
    VisibleInLegend            : Boolean;
    ControlLimitUpperValue     : Double;
    ControlLimitLowerValue     : Double;
    WarningLimitUpperValue     : Double;
    WarningLimitLowerValue     : Double;
    ControlLimitUpperShow      : Boolean;
    ControlLimitLowerShow      : Boolean;
    WarningLimitUpperShow      : Boolean;
    WarningLimitLowerShow      : Boolean;
    ControlLimitUpperLineStyle : TiChannelLineStyle;
    ControlLimitLowerLineStyle : TiChannelLineStyle;
    WarningLimitUpperLineStyle : TiChannelLineStyle;
    WarningLimitLowerLineStyle : TiChannelLineStyle;
    ControlLimitUpperLineWidth : Integer;
    ControlLimitLowerLineWidth : Integer;
    WarningLimitUpperLineWidth : Integer;
    WarningLimitLowerLineWidth : Integer;
    UseFixedAxis               : Boolean;

    constructor Create; virtual;
    procedure   DataClear;                                                                                virtual; abstract;
    procedure   SetBufferSize    (Value: Integer);                                                        virtual; abstract;
    procedure   SetRingBufferSize(Value: Integer);                                                        virtual; abstract;
    procedure   DataDeleteRange  (Value: Integer);                                                        virtual; abstract;
    procedure   DataAdd          (Value: Double);                                                         virtual; abstract;
    function    GetDataItem      (Index: Integer; var IsNull : Boolean): Double;                          virtual; abstract;
    function    GetDataStatus    (Index: Integer): TiChannelDataSatus;                                    virtual; abstract;
    procedure   SetDataItem      (Index: Integer; const Value: Double; const Status: TiChannelDataSatus); virtual; abstract;
    property    Color                  : TColor read FColor                  write SetColor;
    property    ControlLimitUpperColor : TColor read FControlLimitUpperColor write SetControlLimitUpperColor;
    property    ControlLimitLowerColor : TColor read FControlLimitLowerColor write SetControlLimitLowerColor;
    property    WarningLimitUpperColor : TColor read FWarningLimitUpperColor write SetWarningLimitUpperColor;
    property    WarningLimitLowerColor : TColor read FWarningLimitLowerColor write SetWarningLimitLowerColor;
  end;

  TiStripChartContinuousDataChannelObject = class(TiStripChartChannelObject)
  private
    FDataList : TiDataNullList;
  public
    constructor Create;                                                                                   override;
    destructor  Destroy;                                                                                  override;
    procedure   DataClear;                                                                                override;
    procedure   SetBufferSize    (Value: Integer);                                                        override;
    procedure   SetRingBufferSize(Value: Integer);                                                        override;
    function    GetDataStatus    (Index: Integer): TiChannelDataSatus;                                    override;
    procedure   DataDeleteRange  (Value: Integer);                                                        override;
    procedure   DataAdd          (Value: Double );                                                        override;
    function    GetDataItem      (Index: Integer; var IsNull : Boolean): Double;                          override;
    procedure   SetDataItem      (Index: Integer; const Value: Double; const Status: TiChannelDataSatus); override;
  end;

  TiStripChartDiscontinuousDataChannelObject = class(TiStripChartChannelObject)
  private
    FDataList : TiDataNullList;
  public
    constructor Create;                                                                                   override;
    destructor  Destroy;                                                                                  override;
    procedure   DataClear;                                                                                override;
    procedure   SetBufferSize    (Value: Integer);                                                        override;
    procedure   SetRingBufferSize(Value: Integer);                                                        override;
    function    GetDataStatus    (Index: Integer): TiChannelDataSatus;                                    override;
    procedure   DataDeleteRange  (Value: Integer);                                                        override;
    procedure   DataAdd          (Value: Double );                                                        override;
    function    GetDataItem      (Index: Integer; var IsNull : Boolean): Double;                          override;
    procedure   SetDataItem      (Index: Integer; const Value: Double; const Status: TiChannelDataSatus); override;
  end;

  TiLabelChannelObject = class(TObject)
  public
    YPosition  : Double;
    Font       : TFont;
    LabelList  : TStringList;
    Visible    : Boolean;
    constructor Create;
    destructor  Destroy; override;
  end;

  TiDrawObject = class(TObject)
  private
    FCount         : Integer;
    FPointArray    : PointDoubleDynamicArray;
  protected
    function  GetPolyPoint(Index: Integer): TPointDouble;
    procedure SetPolyPoint(Index: Integer; const Value: TPointDouble);
    function  GetPolyPointCount: Integer;
  public
    AType         : TiDrawObjectType;

    Visible       : Boolean;
    X             : Double;
    Y             : Double;
    Width         : Double;
    Height        : Double;
    StartAngle    : Double;
    StopAngle     : Double;

    ImageIndex    : Integer;
    ImageRotation : Double;

    FontCaption   : String;
    FontName      : String;
    FontSize      : Integer;
    FontColor     : TColor;
    FontBold      : Boolean;
    FontItalic    : Boolean;
    FontUnderLine : Boolean;
    FontStrikeOut : Boolean;

    BrushColor    : TColor;
    BrushStyle    : TBrushStyle;

    PenColor      : TColor;
    PenStyle      : TPenStyle;
    PenWidth      : Integer;
    DrawRect      : TRect;


    procedure   AddPolyPoint(Point: TPointDouble);
    procedure   ClearPolyPoints;

    property    PolyPoint[Index: Integer] : TPointDouble read GetPolyPoint write SetPolyPoint;
    property    PolyPointCount : Integer read GetPolyPointCount;

    destructor  Destroy; override;
  end;

  TiMinMaxPoint = class(TPersistent)
  public
    Empty             : Boolean;
    IsNull            : Boolean;
    PixelsX           : Integer;
    YMax              : Double;
    YMin              : Double;
    YFirst            : Double;
    YLast             : Double;
    procedure AssignDown(Source: TPersistent);
    procedure Clear;
    procedure AddData(Value: Double; Null: Boolean; X: Integer);
    constructor Create;
  end;

  TDigitalSequenceData = class(TObject)
  public
    StartSet         : Boolean;
    StartXValue      : Double;
    StartYValue      : Boolean;
    StopSet          : Boolean;
    StopXValue       : Double;
    TransitionSet    : Boolean;
    TransitionXValue : Double;

    procedure Clear;
  end;


  TiPlotMinMaxPoint = class(TPersistent)
  private
  public
    Empty             : Boolean;
    XPixels           : Integer;
    XValue            : Double;
    YMax              : Double;
    YMin              : Double;
    YFirst            : Double;
    YLast             : Double;

    constructor Create;
    procedure Clear;
    procedure AddData(const NewXValue, NewYValue: Double; const NewXPixels: Integer);
    procedure AssignDown(const Source: TiPlotMinMaxPoint);
  end;

  TiButton = class(TPersistent)
  private
    FTop               : Integer;
    FBottom            : Integer;
    FRight             : Integer;
    FLeft              : Integer;
    FVisible           : Boolean;
    FMouseDown         : Boolean;
    FOnClick           : TNotifyEvent;
    FOnInvalidate      : TNotifyEvent;
    FEnabled           : Boolean;
    FGroupIndex        : Integer;
    FCaption           : String;
    FFont              : TFont;
    procedure SetEnabled(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  protected
    function  GetDrawRect: TRect;
    function  GetHeight  : Integer;
    function  GetWidth   : Integer;

    procedure SetDrawRect(const Value: TRect);
    procedure SetCaption (const Value: String);
    procedure SetFont    (const Value: TFont);

    procedure FontChange(Sender : TObject);

    procedure Invalidate;
    procedure DoChange;
    procedure SetMouseDown(const Value: Boolean);
  public
    constructor Create; virtual;
    destructor  Destroy; override;

    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer); virtual;
    procedure iMouseMove(                      Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer); virtual;
    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer); virtual;

    procedure Draw(const Canvas : TCanvas; ControlEnabled: Boolean); virtual; 

    property DrawRect     : TRect        read GetDrawRect   write SetDrawRect;
    property Left         : Integer      read FLeft         write FLeft;
    property Top          : Integer      read FTop          write FTop;
    property Right        : Integer      read FRight        write FRight;
    property Bottom       : Integer      read FBottom       write FBottom;
    property MouseDown    : Boolean      read FMouseDown    write SetMouseDown;
    property Width        : Integer      read GetWidth;
    property Height       : Integer      read GetHeight;
    property Visible      : Boolean      read FVisible      write SetVisible;
    property Enabled      : Boolean      read FEnabled      write SetEnabled;
    property GroupIndex   : Integer      read FGroupIndex   write FGroupIndex;

    property Caption      : String       read FCaption write SetCaption;
    property Font         : TFont        read FFont write SetFont;

    property OnInvalidate : TNotifyEvent read FOnInvalidate write FOnInvalidate;
    property OnClick      : TNotifyEvent read FOnClick      write FOnClick;
  end;

  TiGotoURL = class(TObject)
  private
    {$ifndef iCLX}function RegKey(Key: HKey; SubKey: String; var Data: String) : LongInt;{$endif}
  public
    procedure Connect(URLString: String; ShowCommand: TiURLShowCommand);
  end;

type
  TiLimitData = record
    Value1 : Double;
    Value2 : Double;
    Value3 : Double;
  end;
type
  PiLimitDataArray = ^TiLimitDataArray;
  TiLimitDataArray = array[0..(Maxint div 32) - 1] of TiLimitData;

  TiLimitDataList = class(TObject)
  private
    FList     : PiLimitDataArray;
    FCount    : Integer;
    FCapacity : Integer;

    function  GetItem           (Index: Integer): TiLimitData;
    function  GetItem1          (Index: Integer): Double;
    function  GetItem2          (Index: Integer): Double;
    function  GetItem3          (Index: Integer): Double;

    procedure SetItem           (Index: Integer; const Value: TiLimitData);
    procedure SetItem1          (Index: Integer; const Value: Double);
    procedure SetItem2          (Index: Integer; const Value: Double);
    procedure SetItem3          (Index: Integer; const Value: Double);
  protected
    procedure Grow;
  public
    destructor Destroy; override;
    function  Add(Value1, Value2, Value3: Double): Integer;
    procedure SetCapacity(NewCapacity: Integer);
    procedure Clear;

    property Count                : Integer read FCount;
    property Item1[Index: Integer]: Double  read GetItem1 write SetItem1;
    property Item2[Index: Integer]: Double  read GetItem2 write SetItem2;
    property Item3[Index: Integer]: Double  read GetItem3 write SetItem3;
  end;

var
  iDraw : TiDraw;

implementation
//****************************************************************************************************************************************************
procedure TiMemoryStream.WriteString(Value: String);
var
  OutString : ShortString;
begin
  if Length(Value) > 255 then raise Exception.Create('String Exceeds 255 Characters');
  OutString := Value;
  Write(OutString[1],Length(OutString));
end;
//****************************************************************************************************************************************************
procedure TiMemoryStream.WriteCRLF;
begin
  WriteString(#13+#10);
end;
//****************************************************************************************************************************************************
procedure TiMemoryStream.WriteStringCRLF(Value: String);
begin
  WriteString(Value);
  WriteCRLF;
end;
//****************************************************************************************************************************************************
function TiMemoryStream.ReadChar: Char;
begin
  Read(Result, 1);
  if Position = Size then raise Exception.Create('EOF');
end;
//****************************************************************************************************************************************************
{TiXMLFileStream}
//****************************************************************************************************************************************************
procedure TiXMLMemoryStream.StartElement(Name: String);
begin
  WriteStringCRLF('<' + Name + '>');
end;
//****************************************************************************************************************************************************
procedure TiXMLMemoryStream.EndElement(Name: String);
begin
  WriteStringCRLF('</' + Name + '>');
end;
//****************************************************************************************************************************************************
procedure TiXMLMemoryStream.WriteElement(Name, Value: String);
begin
  WriteStringCRLF('<' + Name + '>' + Value + '</' + Name + '>');
end;
//****************************************************************************************************************************************************
function TiXMLMemoryStream.GetNameElementStart : String;
var
  NextChar     : Char;
  EndOfElement : Boolean;
  EndOfName    : Boolean;
begin
  Result       := '';
  EndOfElement := False;
  EndOfName    := False;

  while ReadChar <> '<' do;
  while not EndOfElement do
    begin
      NextChar := ReadChar;
      if NextChar = '/' then
        begin
          while ReadChar <> '<' do;
          Continue;
        end;

      if NextChar = '>' then
        begin
          EndOfElement := True;
          EndOfName    := True;
        end;
      if NextChar = ' ' then EndOfName := True;

      if not EndOfName then Result := Result + NextChar;
    end;
end;
//****************************************************************************************************************************************************
procedure TiXMLMemoryStream.GotoElementStart(Value : String);
begin
  while GetNameElementStart <> Value do;
end;
//****************************************************************************************************************************************************
function TiXMLMemoryStream.GetElementValue : String;
var
  NextChar     : Char;
  EndOfElement : Boolean;
begin
  Result := '';
  EndOfElement := False;
  while not EndOfElement do
    begin
      NextChar := ReadChar;
      if NextChar = '<' then EndOfElement := True;
      if not EndOfElement then Result := Result + NextChar;
    end;
  Seek(-1, soFromCurrent);
end;
//****************************************************************************************************************************************************
function TiXMLMemoryStream.GetNameElementStop: String;
var
  NextChar     : Char;
  EndOfElement : Boolean;
  EndOfName    : Boolean;
begin
  Result       := '';
  EndOfElement := False;
  EndOfName    := False;

  if ReadChar <> '<' then raise Exception.Create('XML Parsing Error - "<" not Found');
  if ReadChar <> '/' then raise Exception.Create('XML Parsing Error - "/" not Found');
  while not EndOfElement do
    begin
      NextChar := ReadChar;
      if NextChar = '>' then
        begin
          EndOfElement := True;
          EndOfName    := True;
        end;
      if NextChar = ' ' then EndOfName := True;

      if not EndOfName then Result := Result + NextChar;
    end;
end;
//****************************************************************************************************************************************************
function TiXMLMemoryStream.GetElement(Name: String): String;
begin
  while GetNameElementStart <> Name do;
  Result := GetElementValue;
  while GetNameElementStop <> Name do;
end;
//****************************************************************************************************************************************************
function TiXMLMemoryStream.GetNextPiece: String;
var
  NextChar : Char;
begin
  Result := '';

  repeat
    NextChar := ReadChar;
  until (NextChar <> #10) and (NextChar <> #13);
  
  if NextChar = '<' then
    begin
      while True do
        begin
          NextChar := ReadChar;
          if NextChar = '>' then Break
          else Result := Result + NextChar;
        end;
    end
  else
    begin
      while True do
        begin
          NextChar := ReadChar;
          if NextChar = '<' then
            begin
              Seek(-1, soFromCurrent);
              Break;
            end
          else Result := Result + NextChar;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiXMLMemoryStream.PeekNextPiece: String;
var
  OldPosition : Integer;
begin
  OldPosition := Position;
  Result := GetNextPiece;
  Position := OldPosition;
end;
//****************************************************************************************************************************************************
{ TiStripChartChannelObject }
//*************************************************************************************************************************************
constructor TiStripChartChannelObject.Create;
begin
  Visible           := True;
  VisibleInLegend   := True;
  HighestIndex      := -1;
  FTrackLimitColors := True;
end;
//*************************************************************************************************************************************
procedure TiStripChartChannelObject.SetColor(const Value: TColor);
begin
  if FColor <> Value then
    begin
      FColor := Value;
      if FTrackLimitColors then
        begin
          ControlLimitUpperColor := FColor;
          ControlLimitLowerColor := FColor;
          WarningLimitUpperColor := FColor;
          WarningLimitLowerColor := FColor;
        end;
    end;
end;
//*************************************************************************************************************************************
procedure TiStripChartChannelObject.SetControlLimitUpperColor(const Value: TColor);
begin
  if FControlLimitUpperColor <> Value then
    begin
      FControlLimitUpperColor := Value;
      FTrackLimitColors := False;
    end;
end;
//*************************************************************************************************************************************
procedure TiStripChartChannelObject.SetControlLimitLowerColor(const Value: TColor);
begin
  if FControlLimitLowerColor <> Value then
    begin
      FControlLimitLowerColor := Value;
      FTrackLimitColors := False;
    end;
end;
//*************************************************************************************************************************************
procedure TiStripChartChannelObject.SetWarningLimitUpperColor(const Value: TColor);
begin
  if FWarningLimitUpperColor <> Value then
    begin
      FWarningLimitUpperColor := Value;
      FTrackLimitColors := False;
    end;
end;
//*************************************************************************************************************************************
procedure TiStripChartChannelObject.SetWarningLimitLowerColor(const Value: TColor);
begin
  if FWarningLimitLowerColor <> Value then
    begin
      FWarningLimitLowerColor := Value;
      FTrackLimitColors := False;
    end;
end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
{ TiStripChartContinuousDataChannelObject }
//*************************************************************************************************************************************
//*************************************************************************************************************************************
constructor TiStripChartContinuousDataChannelObject.Create;
begin
  inherited;
  FDataList := TiDataNullList.Create;
end;
//*************************************************************************************************************************************
destructor TiStripChartContinuousDataChannelObject.Destroy;
begin
  FDataList.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiStripChartContinuousDataChannelObject.DataAdd(Value: Double);
var
  DataNull : TDataNull;
begin                             
  DataNull.Data   := Value;
  DataNull.Status := icdsNull;
  FDataList.Add(DataNull);
end;
//*************************************************************************************************************************************
procedure TiStripChartContinuousDataChannelObject.DataClear;
begin
  FDataList.Clear;
end;
//*************************************************************************************************************************************
procedure TiStripChartContinuousDataChannelObject.SetBufferSize(Value: Integer);
begin
  FDataList.UseRingBuffer := False;
  FDataList.SetCapacity(Value);
end;
//*************************************************************************************************************************************
procedure TiStripChartContinuousDataChannelObject.SetRingBufferSize(Value: Integer);
begin
  FDataList.UseRingBuffer := True;
  FDataList.SetCapacity(Value);
end;
//*************************************************************************************************************************************
function TiStripChartContinuousDataChannelObject.GetDataStatus(Index: Integer): TiChannelDataSatus;
var
  DataNull : TDataNull;
begin
  DataNull := FDataList.Item[Index];
  Result := DataNull.Status;
end;
//*************************************************************************************************************************************
procedure TiStripChartContinuousDataChannelObject.DataDeleteRange(Value: Integer);
begin
  FDataList.DeleteRange(Value);
end;
//*************************************************************************************************************************************
function TiStripChartContinuousDataChannelObject.GetDataItem(Index: Integer; var IsNull : Boolean): Double;
var
  DataNull : TDataNull;
begin
  DataNull := FDataList.Item[Index];
  Result   := DataNull.Data;
  IsNull   := False;
end;
//*************************************************************************************************************************************
procedure TiStripChartContinuousDataChannelObject.SetDataItem(Index: Integer; const Value: Double; const Status: TiChannelDataSatus);
var
  DataNull : TDataNull;
begin
  if Status = icdsNull then Exit;
  DataNull        := FDataList.Item[Index];
  DataNull.Data   := Value;
  DataNull.Status := Status;
  FDataList.Item[Index] := DataNull;

  if Index > HighestIndex then HighestIndex := Index;
end;
//*************************************************************************************************************************************
//*************************************************************************************************************************************
{ TiStripChartDiscontinuousDataChannelObject }
//*************************************************************************************************************************************
//*************************************************************************************************************************************
constructor TiStripChartDiscontinuousDataChannelObject.Create;
begin
  inherited;
  FDataList := TiDataNullList.Create;
end;
//*************************************************************************************************************************************
destructor TiStripChartDiscontinuousDataChannelObject.Destroy;
begin
  inherited;
  DataClear;
  FDataList.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiStripChartDiscontinuousDataChannelObject.DataAdd(Value: Double);
var
  DataNull    : TDataNull;
  ItemDropped : Boolean;
begin                             
  DataNull.Data   := Value;
  DataNull.Status := icdsNull;
  ItemDropped := FDataList.Add(DataNull);
  if ItemDropped then HighestIndex := HighestIndex-1;
end;
//*************************************************************************************************************************************
procedure TiStripChartDiscontinuousDataChannelObject.DataClear;
begin
  FDataList.Clear;
end;
//*************************************************************************************************************************************
procedure TiStripChartDiscontinuousDataChannelObject.SetBufferSize(Value: Integer);
begin
  FDataList.UseRingBuffer := False;
  FDataList.SetCapacity(Value);
end;
//*************************************************************************************************************************************
procedure TiStripChartDiscontinuousDataChannelObject.SetRingBufferSize(Value: Integer);
begin
  FDataList.UseRingBuffer := True;
  FDataList.SetCapacity(Value);
end;
//*************************************************************************************************************************************
function TiStripChartDiscontinuousDataChannelObject.GetDataStatus(Index: Integer): TiChannelDataSatus;
var
  DataNull : TDataNull;
begin
  DataNull := FDataList.Item[Index];
  Result   := DataNull.Status;
end;
//*************************************************************************************************************************************
procedure TiStripChartDiscontinuousDataChannelObject.DataDeleteRange(Value: Integer);
begin
  FDataList.DeleteRange(Value);
end;
//*************************************************************************************************************************************
function TiStripChartDiscontinuousDataChannelObject.GetDataItem(Index: Integer; var IsNull: Boolean): Double;
var
  DataNull : TDataNull;
begin
  DataNull := FDataList.Item[Index];
  Result   := DataNull.Data;
  IsNull   := DataNull.Status = icdsNull;
end;
//*************************************************************************************************************************************
procedure TiStripChartDiscontinuousDataChannelObject.SetDataItem(Index: Integer; const Value: Double; const Status: TiChannelDataSatus);
var
  DataNull : TDataNull;
begin
  DataNull              := FDataList.Item[Index];
  DataNull.Data         := Value;
  DataNull.Status       := Status;
  FDataList.Item[Index] := DataNull;

  if Index > HighestIndex then HighestIndex := Index;
end;
//*************************************************************************************************************************************
{ TiLabelChannelObject }
//*************************************************************************************************************************************
constructor TiLabelChannelObject.Create;
begin
  Font       := TFont.Create;
  Font.Color := clWhite;
  Font.Style := [fsBold];

  YPosition  := 50;

  LabelList := TStringList.Create;
  Visible   := True;
end;
//*************************************************************************************************************************************
destructor TiLabelChannelObject.Destroy;
begin
  inherited;
  Font.Free;
  LabelList.Free;
end;
//****************************************************************************************************************************************************
//****************************************************************************************************************************************************
//****************************************************************************************************************************************************
constructor TiButton.Create;
begin
  FEnabled := True;
  FVisible := True;
  FFont := TFont.Create; FFont.OnChange := FontChange;
end;
//*************************************************************************************************************************************
destructor TiButton.Destroy;
begin
  FFont.Free;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiButton.FontChange(Sender: TObject);
begin
  Invalidate;
end;
//****************************************************************************************************************************************************
procedure TiButton.SetDrawRect(const Value: TRect);
begin
  if (Left <> Value.Left) or (Top <> Value.Top) or (Right <> Value.Right) or (Bottom <> Value.Bottom) then
    begin
      Left   := Value.Left;
      Top    := Value.Top;
      Right  := Value.Right;
      Bottom := Value.Bottom;
      Invalidate;
    end;
end;
//*************************************************************************************************************************************
procedure TiButton.SetCaption(const Value: String);
begin
  if FCaption <> Value then
    begin
      FCaption := Value;
      Invalidate;
    end;
end;
//*************************************************************************************************************************************
procedure TiButton.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
    begin
      FEnabled := Value;
      Invalidate;
    end;
end;
//*************************************************************************************************************************************
procedure TiButton.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
    begin
      FVisible := Value;
      Invalidate;
    end;
end;
//*************************************************************************************************************************************
procedure TiButton.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;
//****************************************************************************************************************************************************
function TiButton.GetDrawRect: TRect;
begin
  Result := Rect(Left, Top, Right, Bottom)
end;
//****************************************************************************************************************************************************
function TiButton.GetHeight: Integer;
begin
  Result := FBottom - FTop;
end;
//****************************************************************************************************************************************************
function TiButton.GetWidth: Integer;
begin
  Result := FRight - FLeft;
end;
//****************************************************************************************************************************************************
procedure TiButton.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer);
begin
  if not FEnabled then Exit;
  MouseDown := True;
end;
//****************************************************************************************************************************************************
procedure TiButton.iMouseMove(Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer);
begin
  if not FEnabled then Exit;

end;
//****************************************************************************************************************************************************
procedure TiButton.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y, ScreenX, ScreenY: Integer);
begin
  if not FEnabled then Exit;

  MouseDown := False;
  if PtInRect(DrawRect, Point(X, Y)) then DoChange;
end;
//*************************************************************************************************************************************
procedure TiButton.DoChange;
begin
  if Assigned(FOnClick) then FOnClick(Self);
end;
//****************************************************************************************************************************************************
procedure TiButton.Invalidate;
begin
  if Assigned(FOnInvalidate) then FOnInvalidate(Self);
end;
//****************************************************************************************************************************************************
procedure TiButton.SetMouseDown(const Value: Boolean);
begin
  if FMouseDown <> Value then
    begin
      FMouseDown := Value;
      Invalidate;
    end;
end;
//*************************************************************************************************************************************
procedure TiButton.Draw(const Canvas: TCanvas; ControlEnabled: Boolean);
var
  ARect  : TRect;
  AText  : String;
  AFlags : TiTextFlags;
begin
  with Canvas do
    begin
      ARect := DrawRect;

      if MouseDown then iDrawEdge(Canvas, ARect, idesSunken)
      else              iDrawEdge(Canvas, ARect, idesRaised);
      
      Font.Assign(FFont);
      Brush.Style := bsClear;
      AFlags      := [itfHCenter, itfVCenter, itfSingleLine];
      AText       := FCaption;
      
      iDrawText(Canvas, AText, ARect, AFlags, Enabled and ControlEnabled, clBtnFace);
    end;
end;
//*************************************************************************************************************************************
{ TiMinMaxPoint }
//*************************************************************************************************************************************
constructor TiMinMaxPoint.Create;
begin
  Empty  := True;
  IsNull := True;
  YMax   := -1E301;
  YMin   :=  1E301;
end;
//*************************************************************************************************************************************
procedure TiMinMaxPoint.AddData(Value: Double; Null: Boolean; X: Integer);
begin
  Empty := False;

  if not Null then
    begin
      if IsNull then
        begin
         IsNull  := False;
         YFirst  := Value;
         PixelsX := X;
        end;

      if Value > YMax then YMax := Value;
      if Value < YMin then YMin := Value;
      YLast := Value;
    end
end;
//*************************************************************************************************************************************
procedure TiMinMaxPoint.AssignDown(Source: TPersistent);
begin
  if not(Source is TiMinMaxPoint) then raise Exception.Create('Assign class must be TiMinMaxPoint');

  Empty   := (Source as TiMinMaxPoint).Empty;
  IsNull  := (Source as TiMinMaxPoint).IsNull;
  PixelsX := (Source as TiMinMaxPoint).PixelsX;
  YMax    := (Source as TiMinMaxPoint).YMax;
  YMin    := (Source as TiMinMaxPoint).YMin;
  YFirst  := (Source as TiMinMaxPoint).YFirst;
  YLast   := (Source as TiMinMaxPoint).YLast;
end;
//*************************************************************************************************************************************
procedure TiMinMaxPoint.Clear;
begin
  Empty  := True;
  IsNull := True;
  YMax   := -1E301;
  YMin   :=  1E301;
end;
//*************************************************************************************************************************************
{ TiPlotMinMaxPoint }
//*************************************************************************************************************************************
constructor TiPlotMinMaxPoint.Create;
begin
  Clear;
end;
//*************************************************************************************************************************************
procedure TiPlotMinMaxPoint.Clear;
begin
  Empty  := True;
  YMax   := -1E301;
  YMin   :=  1E301;
end;
//*************************************************************************************************************************************
procedure TiPlotMinMaxPoint.AddData(const NewXValue, NewYValue: Double; const NewXPixels: Integer);
begin
  if Empty then
    begin
      Empty   := False;
      XPixels := NewXPixels;
      XValue  := NewXValue;
      YFirst  := NewYValue;
    end;

  if NewYValue > YMax then YMax := NewYValue;
  if NewYValue < YMin then YMin := NewYValue;
  YLast := NewYValue;
end;
//*************************************************************************************************************************************
procedure TiPlotMinMaxPoint.AssignDown(const Source: TiPlotMinMaxPoint);
begin
  Empty   := Source.Empty;
  XPixels := Source.XPixels;
  XValue  := Source.XValue;
  YMax    := Source.YMax;
  YMin    := Source.YMin;
  YFirst  := Source.YFirst;
  YLast   := Source.YLast;
end;
//*************************************************************************************************************************************
{ TiGotoURL }
//*************************************************************************************************************************************
{$ifndef iCLX}
function TiGotoURL.RegKey(Key: HKey; SubKey: String; var Data: String): LongInt;
var
  TempKey : HKey;
  TData   : array[0..259] of Char;
  DSize   : Integer;
begin
  Result := regopenkeyex(Key, PChar(subkey), 0, KEY_QUERY_VALUE, TempKey);
  if result = ERROR_SUCCESS then
  begin
    DSize := Sizeof(TData);
    regqueryvalue(TempKey, nil, TData, DSize);
    Data := StrPas(TData);
    RegCloseKey(TempKey);
  end;
end;
{$endif}
//*************************************************************************************************************************************
procedure TiGotoURL.Connect(URLString: String; ShowCommand: TiURLShowCommand);
{$ifdef iVCL}
var
  Show         : Integer;
  Key          : String;
  P            : Integer;
  WindowHandle : THandle;
{$endif}
begin
  {$ifdef iVCL}
  case ShowCommand of
    ssHide              : Show := sw_Hide;
    ssMaximize          : Show := sw_Maximize;
    ssMinimize          : Show := sw_Minimize;
    ssRestore           : Show := sw_Restore;
    ssShow              : Show := sw_Show;
    ssShowDefault       : Show := sw_ShowDefault;
    ssShowMaximized     : Show := sw_ShowMaximized;
    ssShowMinimized     : Show := sw_ShowMinimized;
    ssShowMinNoActivate : Show := sw_ShowMinNoActive;
    ssShowNA            : Show := sw_ShowNA;
    ssShowNoActivate    : Show := sw_ShowNoActivate;
    else                  Show := sw_ShowNormal;
  end;

  WindowHandle := FindWindow('IEFrame', nil);
  if WindowHandle <> 0 then
    begin
      ShowWindow(WindowHandle, SW_RESTORE);
      BringWindowToTop(WindowHandle);

      exit;
    end;
    
  if RegKey(HKEY_CLASSES_ROOT, '.htm', Key) = ERROR_SUCCESS then
  begin
    Key := Key + '\shell\open\command';
    if RegKey(HKEY_CLASSES_ROOT, Key, Key) = ERROR_SUCCESS then
    begin
      P := Pos('"%1"', Key);
      if P = 0 then
        P := Pos('%1', Key);
      if P <> 0 then
       SetLength(Key, P-1);
      Key := Key + ' ' + URLString;
      if winexec(PChar(Key), show) < 32 then
        raise exception.create('Couldn''t launch default browser');
    end;
  end;
  {$endif}
end;
//*************************************************************************************************************************************
{ TiLimitDataList }
//*************************************************************************************************************************************
destructor TiLimitDataList.Destroy;
begin
  FreeMem(FList);
  inherited;
end;
//*************************************************************************************************************************************
function TiLimitDataList.Add(Value1, Value2, Value3: Double): Integer;
var
  Item : TiLimitData;
begin
  Item.Value1 := Value1;
  Item.Value2 := Value2;
  Item.Value3 := Value3;

  Result := FCount;
  if Result = FCapacity then Grow;
  FList^[Result] := Item;
  Inc(FCount);
end;
//*************************************************************************************************************************************
procedure TiLimitDataList.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else
    if FCapacity > 8 then
      Delta := 16
    else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;
//*************************************************************************************************************************************
procedure TiLimitDataList.SetCapacity(NewCapacity: Integer);
begin
  if (NewCapacity > MaxListSize) then Exception.Create('Exceed Maximum List Size');
  if NewCapacity <> FCapacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TiLimitData));
    FCapacity := NewCapacity;
    if FCapacity < FCount then FCount := FCapacity;
  end;
end;
//*************************************************************************************************************************************
procedure TiLimitDataList.Clear;
begin
  FCount := 0;
  SetCapacity(0);
end;
//*************************************************************************************************************************************
function TiLimitDataList.GetItem(Index: Integer): TiLimitData;
begin
  if (Index < 0) or (Index >= FCount) then raise Exception.Create('Index out of Bounds');
  Result := FList^[Index];
end;
//*************************************************************************************************************************************
function TiLimitDataList.GetItem1(Index: Integer): Double;
begin
  Result := GetItem(Index).Value1;
end;
//*************************************************************************************************************************************
function TiLimitDataList.GetItem2(Index: Integer): Double;
begin
  Result := GetItem(Index).Value2;
end;
//*************************************************************************************************************************************
function TiLimitDataList.GetItem3(Index: Integer): Double;
begin
  Result := GetItem(Index).Value3;
end;
//*************************************************************************************************************************************
procedure TiLimitDataList.SetItem(Index: Integer; const Value: TiLimitData);
begin
  if (Index < 0) or (Index >= FCount) then raise Exception.Create('Index out of Bounds');
  FList^[Index] := Value;
end;
//*************************************************************************************************************************************
procedure TiLimitDataList.SetItem1(Index: Integer; const Value: Double);
var
  iLimitData : TiLimitData;
begin
  iLimitData   := GetItem(Index);
  iLimitData.Value1 := Value;
  SetItem(Index, iLimitData);
end;
//*************************************************************************************************************************************
procedure TiLimitDataList.SetItem2(Index: Integer; const Value: Double);
var
  iLimitData : TiLimitData;
begin
  iLimitData   := GetItem(Index);
  iLimitData.Value2 := Value;
  SetItem(Index, iLimitData);
end;
//*************************************************************************************************************************************
procedure TiLimitDataList.SetItem3(Index: Integer; const Value: Double);
var
  iLimitData : TiLimitData;
begin
  iLimitData   := GetItem(Index);
  iLimitData.Value3 := Value;
  SetItem(Index, iLimitData);
end;
//*************************************************************************************************************************************
procedure TDigitalSequenceData.Clear;
begin
  StartSet      := False;
  StopSet       := False;
  TransitionSet := False;
end;
//*************************************************************************************************************************************
{ TiDrawObject }
//*************************************************************************************************************************************
destructor TiDrawObject.Destroy;
begin
  FPointArray := nil;
  inherited;
end;
//*************************************************************************************************************************************
procedure TiDrawObject.ClearPolyPoints;
begin
  FCount := 0;
  SetLength(FPointArray, FCount);
end;
//*************************************************************************************************************************************
procedure TiDrawObject.AddPolyPoint(Point: TPointDouble);
begin
  inc(FCount);
  SetLength(FPointArray, FCount);

  FPointArray[FCount-1].x := Point.x;
  FPointArray[FCount-1].y := Point.y;
end;
//*************************************************************************************************************************************
function TiDrawObject.GetPolyPoint(Index: Integer): TPointDouble;
begin
  if (Index < 0) or (Index >= FCount) then raise Exception.Create('Index out of Bounds');

  Result.x := FPointArray[Index].x;
  Result.y := FPointArray[Index].y;
end;
//*************************************************************************************************************************************
procedure TiDrawObject.SetPolyPoint(Index: Integer; const Value: TPointDouble);
begin
  if (Index < 0) or (Index >= FCount) then raise Exception.Create('Index out of Bounds');

  FPointArray[Index].x := Value.x;
  FPointArray[Index].y := Value.y;
end;
//*************************************************************************************************************************************
function TiDrawObject.GetPolyPointCount: Integer;
begin
  Result := FCount;
end;
//*************************************************************************************************************************************
{ TiDraw }
//*************************************************************************************************************************************
{$IFDEF iVCL}function TiDraw.Triangle(Canvas: TCanvas; r: TRect; Direction: TiQuadDirection; Style3D: TiBevelStyle; Color: TColor; Enabled: Boolean): HRGN; {$ENDIF}
{$IFDEF iCLX}function TiDraw.Triangle(Canvas: TCanvas; r: TRect; Direction: TiQuadDirection; Style3D: TiBevelStyle; Color: TColor; Enabled: Boolean): TRect;{$ENDIF}
var
  APoints : Array[0..2] of TPoint;
begin
  with Canvas, r do
    begin
      Brush.Color := Color;
      Pen.Color   := Brush.Color;
      Brush.Style := bsSolid;
      Pen.Style   := psClear;

      case Direction of
        iqdRight :  begin
                      APoints[0] := Point(Left,   Top               ); //0
                      APoints[1] := Point(Right, (Top+Bottom) div 2 ); //**1
                      APoints[2] := Point(Left,   Bottom            ); //2
                    end;
        iqdLeft  :  begin
                      APoints[0] := Point(Right, Top                ); //  0
                      APoints[1] := Point(Left, (Top+Bottom) div 2  ); //1**
                      APoints[2] := Point(Right, Bottom             ); //  2
                    end;
        iqdBottom : begin
                      APoints[0] := Point(Left,  Top                ); //0*2
                      APoints[1] := Point((Left+Right) div 2, Bottom); // 1
                      APoints[2] := Point(Right, Top                );
                    end;
        else        begin //Top
                      APoints[0] := Point(Left,  Bottom             ); // 1
                      APoints[1] := Point((Left+Right) div 2, Top   ); //0*2
                      APoints[2] := Point(Right,  Bottom            );
                    end;
      end;

      Polygon(APoints);

      Pen.Style := psSolid;

      if Style3D = ibsRaised then
        begin
          case Direction of
            iqdRight :  begin
                          Pen.Color := clBlack; Polyline([APoints[1], APoints[2]]);
                          Pen.Color := clWhite; Polyline([APoints[0], APoints[1]]);
                          Pen.Color := clWhite; Polyline([APoints[0], APoints[2]]);
                        end;
            iqdLeft  :  begin
                          Pen.Color := clBlack; Polyline([APoints[0], APoints[2]]);
                          Pen.Color := clBlack; Polyline([APoints[1], APoints[2]]);
                          Pen.Color := clWhite; Polyline([APoints[0], APoints[1]]);
                        end;
            iqdBottom : begin
                          Pen.Color := clBlack; Polyline([APoints[1], APoints[2]]);
                          Pen.Color := clWhite; Polyline([APoints[0], APoints[1]]);
                          Pen.Color := clWhite; Polyline([APoints[0], APoints[2]]);
                        end;
            else        begin //Top
                          Pen.Color := clBlack; Polyline([APoints[1], APoints[2]]);
                          Pen.Color := clBlack; Polyline([APoints[0], APoints[2]]);
                          Pen.Color := clWhite; Polyline([APoints[0], APoints[1]]);
                        end;
          end;
        end;
      {$IFDEF iVCL}Result := CreatePolygonRgn(APoints, 3, ALTERNATE);{$ENDIF}
      {$IFDEF iCLX}Result := r;{$ENDIF}
    end;
end;
//*************************************************************************************************************************************
{$IFDEF iVCL}function TiDraw.Pointer(Canvas: TCanvas; r: TRect; Direction: TiQuadDirection; Style3D: TiBevelStyle; Color: TColor; Enabled: Boolean): HRGN; {$ENDIF}
{$IFDEF iCLX}function TiDraw.Pointer(Canvas: TCanvas; r: TRect; Direction: TiQuadDirection; Style3D: TiBevelStyle; Color: TColor; Enabled: Boolean): TRect;{$ENDIF}
var
  APoints     : Array[0..4] of TPoint;
  AHalfWidth  : Integer;
  AHalfHeight : Integer;
begin
  with Canvas, r do
    begin
      AHalfWidth  := (Left + Right ) div 2;
      AHalfHeight := (Top  + Bottom) div 2;

      Brush.Color := Color;
      Pen.Color   := Brush.Color;
      Brush.Style := bsSolid;
      Pen.Style   := psClear;

      case Direction of
        iqdRight :  begin
        { 34  }       APoints[0] := Point(Right,      AHalfHeight);
        { **0 }       APoints[1] := Point(AHalfWidth, Bottom     );
        { 21  }       APoints[2] := Point(Left,       Bottom     );
                      APoints[3] := Point(Left,       Top        );
                      APoints[4] := Point(AHalfWidth, Top        );
                    end;
        iqdLeft  :  begin
        {  43 }       APoints[0] := Point(Left,       AHalfHeight);
        { 0** }       APoints[1] := Point(AHalfWidth, Bottom     );
        {  12 }       APoints[2] := Point(Right,      Bottom     );
                      APoints[3] := Point(Right,      Top        );
                      APoints[4] := Point(AHalfWidth, Top        );
                    end;
        iqdBottom : begin
        { 3*2 }       APoints[0] := Point(AHalfWidth, Bottom     );
        { 4*1 }       APoints[1] := Point(Right,      AHalfHeight);
        {  0  }       APoints[2] := Point(Right,      Top        );
                      APoints[3] := Point(Left,       Top        );
                      APoints[4] := Point(Left,       AHalfHeight);
                    end;
        else        begin //Top
        {  0  }       APoints[0] := Point(AHalfWidth, Top        );
        { 4*1 }       APoints[1] := Point(Right,      AHalfHeight);
        { 3*2 }       APoints[2] := Point(Right,      Bottom     );
                      APoints[3] := Point(Left,       Bottom     );
                      APoints[4] := Point(Left,       AHalfHeight);
                    end;
      end;

      Polygon(APoints);

      Pen.Style := psSolid;

      if Style3D = ibsRaised then
        begin
          case Direction of
            iqdRight :  begin
                          Pen.Color := clBlack; Polyline([APoints[0], APoints[1]]);
                          Pen.Color := clBlack; Polyline([APoints[1], APoints[2]]);
                          Pen.Color := clWhite; Polyline([APoints[2], APoints[3]]);
                          Pen.Color := clWhite; Polyline([APoints[3], APoints[4]]);
                          Pen.Color := clWhite; Polyline([APoints[4], APoints[0]]);
                        end;
            iqdLeft  :  begin
                          Pen.Color := clBlack; Polyline([APoints[3], APoints[2]]);
                          Pen.Color := clBlack; Polyline([APoints[2], APoints[1]]);
                          Pen.Color := clBlack; Polyline([APoints[1], APoints[0]]);
                          Pen.Color := clWhite; Polyline([APoints[0], APoints[4]]);
                          Pen.Color := clWhite; Polyline([APoints[4], APoints[3]]);
                        end;
            iqdBottom : begin
                          Pen.Color := clBlack; Polyline([APoints[2], APoints[1]]);
                          Pen.Color := clBlack; Polyline([APoints[1], APoints[0]]);
                          Pen.Color := clWhite; Polyline([APoints[0], APoints[4]]);
                          Pen.Color := clWhite; Polyline([APoints[4], APoints[3]]);
                          Pen.Color := clWhite; Polyline([APoints[3], APoints[2]]);
                        end;
            else        begin //Top
                          Pen.Color := clBlack; Polyline([APoints[0], APoints[1]]);
                          Pen.Color := clBlack; Polyline([APoints[1], APoints[2]]);
                          Pen.Color := clBlack; Polyline([APoints[2], APoints[3]]);
                          Pen.Color := clWhite; Polyline([APoints[3], APoints[4]]);
                          Pen.Color := clWhite; Polyline([APoints[4], APoints[0]]);
                        end;
          end;
        end;
      {$IFDEF iVCL}Result := CreatePolygonRgn(APoints, 5, ALTERNATE);{$ENDIF}
      {$IFDEF iCLX}Result := r;{$ENDIF}
    end;
end;
//****************************************************************************************************************************************************
procedure TiDraw.Border(Canvas: TCanvas; r: TRect; Inflate: Integer; Style: TiBevelStyle);
var
  ARect : TRect;
begin
  ARect := r;
  InflateRect(ARect, Inflate, Inflate);

  case Style of
    ibsLowered : iDrawEdge(Canvas, ARect, idesSunken);
    ibsRaised  : iDrawEdge(Canvas, ARect, idesRaised);
  end;
end;
//****************************************************************************************************************************************************
procedure TiDraw.GradientTube(Canvas: TCanvas; r : TRect; Color: TColor; Orientation: TiOrientation);
var
  i                : Integer;
  AWidth           : Integer;
  AHeight          : Integer;
  ARed             : Integer;
  AGreen           : Integer;
  ABlue            : Integer;
  AStartRed        : Integer;
  AStartGreen      : Integer;
  AStartBlue       : Integer;
  AStopRed         : Integer;
  AStopGreen       : Integer;
  AStopBlue        : Integer;
  ADelta           : Integer;
  ACenter          : Integer;
  APos             : Integer;
  AColorStart      : TColor;
  AColorStop       : TColor;
  APercentComplete : Double;
begin
  AWidth  := r.Right  - r.Left;
  AHeight := r.Bottom - r.Top;

  if AWidth  < 1 then Exit;
  if AHeight < 1 then Exit;

  with Canvas do
    begin
      AColorStart := ColorToRGB (Color);
      AColorStop  := ColorOffset(Color, $80, False);

      AStartRed   := iGetRValue(AColorStart);
      AStartGreen := iGetGValue(AColorStart);
      AStartBlue  := iGetBValue(AColorStart);

      AStopRed    := iGetRValue(AColorStop);
      AStopGreen  := iGetGValue(AColorStop);
      AStopBlue   := iGetBValue(AColorStop); 

      Brush.Style := bsClear;
      Pen.Style   := psSolid;

      if Orientation = ioVertical then
        begin                                    
          ACenter := (r.Left + r.Right) div 2;
          ADelta  := ACenter - r.Left +1;

          for i := 0 to ADelta do
            begin
              APercentComplete := i/ADelta;

              ARed   := Round((APercentComplete*AStopRed   + (1-APercentComplete)*AStartRed  ));
              AGreen := Round((APercentComplete*AStopGreen + (1-APercentComplete)*AStartGreen));
              ABlue  := Round((APercentComplete*AStopBlue  + (1-APercentComplete)*AStartBlue ));

              Pen.Color := $02000000 or (ARed + (AGreen shl 8) + (ABlue shl 16));

              APos := ACenter - i; if APos >= r.Left  then Polyline([Point(APos, r.Top), Point(APos, r.Bottom)]);
              APos := ACenter + i; if APos <= r.Right then Polyline([Point(APos, r.Top), Point(APos, r.Bottom)]);
            end;
        end
      else
        begin
          ACenter := (r.Top + r.Bottom) div 2;
          ADelta  := ACenter - r.Top +1;

          for i := 0 to ADelta do
            begin
              APercentComplete := i/ADelta;

              ARed   := Round((APercentComplete*AStopRed   + (1-APercentComplete)*AStartRed  ));
              AGreen := Round((APercentComplete*AStopGreen + (1-APercentComplete)*AStartGreen));
              ABlue  := Round((APercentComplete*AStopBlue  + (1-APercentComplete)*AStartBlue ));

              Pen.Color := $02000000 or (ARed + (AGreen shl 8) + (ABlue shl 16));

              APos := ACenter - i; if APos >= r.Top    then Polyline([Point(r.Left, APos), Point(r.Right, APos)]);
              APos := ACenter + i; if APos <= r.Bottom then Polyline([Point(r.Left, APos), Point(r.Right, APos)]);
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
end.

