{*******************************************************}
{                                                       }
{       TiOPCItem Component                             }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCItem;{$endif}
{$ifdef iCLX}unit QiOPCItem;{$endif}

interface

uses
  {$I iIncludeUses.inc}

  {$IFDEF iVCL}  iTypes,  iGPFunctions,  iOPCDLLLoader;{$ENDIF}
  {$IFDEF iCLX} QiTypes, QiGPFunctions, QiOPCDLLLoader;{$ENDIF}

type

  TiOPCItem        = class;
  TiOPCItemManager = class;

  TOPCItemGetDataTypeEvent = procedure(PropertyName: String; var AVarType: TiTypeKind) of object;

  TiOPCItem = class(TPersistent, IOPCSignalUpdate)
  private
    FPropertyName : String;
    FPropertyType : TiTypeKind;
    FGroupName    : String;
    FServerName   : String;
    FComputerName : String;
    FItemName     : String;
    FAutoConnect  : Boolean;
    FUpdateRate   : Integer;
    FScalar       : Double;
    FOffset       : Double;

    FSignalHandle : Integer;

    FData         : OleVariant;
    FTimeStamp    : TDateTime;
    FQuality      : Word;

    FOwner        : TiOPCItemManager;
    FAutoError    : Boolean;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    procedure SetPropertyName(const Value: String);
    procedure SetGroupName   (const Value: String);
    procedure SetServerName  (const Value: String);
    procedure SetComputerName(const Value: String);
    procedure SetItemName    (const Value: String);
    procedure SetAutoConnect (const Value: Boolean);
    procedure SetUpdateRate  (const Value: Integer);
    procedure SetAutoError   (const Value: Boolean);

    function GetActive: Boolean;

    procedure ReceiveData(Handle: Integer);

    procedure NewData(Handle: Integer); cdecl;


    function GetQualityGood: Boolean;
    function GetUpdateSuspended: Boolean;

    procedure SetData(const Value: OleVariant);

    procedure UpdateError;
  public
    constructor Create;
    destructor  Destroy; override;

    procedure Activate;
    procedure ActivateSuspend;
    procedure Deactivate;

    procedure UpdateResume;
    procedure UpdateSuspend;

    function  GetDataNow(var Quality: Word): OLEVariant;

    procedure Loaded;

    property Data            : OleVariant       read FData               write SetData;
    property TimeStamp       : TDateTime        read FTimeStamp;
    property Quality         : Word             read FQuality;
    property Active          : Boolean          read GetActive;

    property QualityGood     : Boolean          read GetQualityGood;

    property Owner           : TiOPCItemManager read FOwner              write FOwner;
  published
    property PropertyName    : String           read FPropertyName       write SetPropertyName;
    property GroupName       : String           read FGroupName          write SetGroupName;
    property ComputerName    : String           read FComputerName       write SetComputerName;
    property ServerName      : String           read FServerName         write SetServerName;
    property ItemName        : String           read FItemName           write SetItemName;
    property Scalar          : double           read FScalar             write FScalar;
    property Offset          : double           read FOffset             write FOffset;
    property UpdateRate      : Integer          read FUpdateRate         write SetUpdateRate;
    property UpdateSuspended : Boolean          read GetUpdateSuspended;

    property AutoConnect     : Boolean          read FAutoConnect        write SetAutoConnect;
    property AutoError       : Boolean          read FAutoError          write SetAutoError;
  end;

  TiOPCItemManager = class(TObject)
  private
    FList           : TStringList;
    FOnGetDesigning : TGetDesigningEvent;
    FOnNewData      : TNotifyEvent;
    FOnGetType      : TOPCItemGetDataTypeEvent;
    FOwner          : TComponent;
  protected
    function  GetCount: Integer;
    function  GetItem  (Index: Integer): TiOpcItem;
    function  GetDesigning: Boolean;
  public
    constructor Create;
    destructor  Destroy; override;

    function  DoWriteToStream : Boolean;
    procedure WriteToStream (Writer: TWriter);
    procedure ReadFromStream(Reader: TReader);

    function FindIndex(OPCItem: TiOPCItem): Integer;

    procedure Clear;
    procedure Delete(Index: Integer);
    function  Add: Integer;

    property  Items[Index: Integer]: TiOpcItem                read GetItem;
    property  Count                : Integer                  read GetCount;

    property IsDesigning           : Boolean                  read GetDesigning;

    property Owner                 : TComponent               read FOwner          write FOwner;

    property OnGetDesigning        : TGetDesigningEvent       read FOnGetDesigning write FOnGetDesigning;
    property OnNewData             : TNotifyEvent             read FOnNewData      write FOnNewData;
    property OnGetType             : TOPCItemGetDataTypeEvent read FOnGetType      write FOnGetType;
  end;

implementation

uses
{$IFDEF iVCL}  iComponent;{$ENDIF}
{$IFDEF iCLX} QiComponent;{$ENDIF}

type
  TWriterAccess        = class(TWriter)    end;
  TReaderAccess        = class(TReader)    end;
  TiComponentAccess    = class(TiComponent)end;
//***********************************************************************************************************************************
constructor TiOPCItem.Create;
begin
  FUpdateRate   := 500;
  FAutoConnect  := True;
  FComputerName := 'Local';
end;
//***********************************************************************************************************************************
destructor TiOPCItem.Destroy;
begin
  try
    Deactivate;
  except
  end;
  inherited;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.Loaded;
begin
  try
    if FAutoError then UpdateError;

    if FAutoConnect then
      begin
        try
          if not FOwner.IsDesigning then Activate;
        except
          on exception do;
        end;
      end;
  except
  end;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetServerName(const Value: String);
begin
  FServerName := Value;
  if OPCDLLNotLoaded then Exit;
  if Active then Activate;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetComputerName(const Value: String);
begin
  FComputerName := Value;
  if OPCDLLNotLoaded then Exit;
  if Active then Activate;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetItemName(const Value: String);
begin
  FItemName := Value;
  if OPCDLLNotLoaded then Exit;
  if Active then Activate;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetUpdateRate(const Value: Integer);
begin
  FUpdateRate := Value;
  if OPCDLLNotLoaded then Exit;
  if Active then Activate;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetAutoConnect(const Value: Boolean);
var
  IsLoading : Boolean;
begin
  FAutoConnect := Value;

  if OPCDLLNotLoaded then Exit;

  if not Assigned(Owner)       then Exit;
  if not Assigned(Owner.Owner) then Exit;

  IsLoading := True;

  if Owner.Owner is TiComponent then IsLoading := TiComponentAccess(Owner.Owner as TiComponent).Loading;
  if IsLoading                  then Exit;
  if FAutoConnect               then Activate;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetPropertyName(const Value: String);
begin
  FPropertyName := Value;

  if not Assigned(Owner) then Exit;

  if Assigned(Owner.OnGetType) then Owner.OnGetType(PropertyName, FPropertyType);
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetGroupName(const Value: String);
begin
  FGroupName := Value;
  if Active then Activate;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.Activate;
var
  AVarType : TVarType;
begin
  if OPCDLLNotLoaded          then Exit;
  if not Assigned(Owner)      then Exit;

  if Owner.IsDesigning        then Exit;

  if FAutoError               then UpdateError;
  if FSignalHandle <> 0       then Deactivate;

  if Trim(FPropertyName) = ''                               then Exit;
  if (Trim(FGroupName)   = '') and (Trim(FServerName) = '') then Exit;
  if Trim(FItemName)     = ''                               then Exit;

  if Active then Deactivate;

  if FPropertyType in [tkLString, tkWString] then AVarType :=  varOleStr
  else                                            AVarType := varEmpty;

  FSignalHandle := OPCDLLSignalAdd(PChar(FComputerName), PChar(FServerName), PChar(FItemName), PChar(FGroupName), FUpdateRate, False, AVarType, Self);
end;
//***********************************************************************************************************************************
procedure TiOPCItem.ActivateSuspend;
var
  AVarType : TVarType;
begin
  if OPCDLLNotLoaded          then Exit;
  if not Assigned(Owner)      then Exit;

  if Owner.IsDesigning        then Exit;

  if FAutoError               then UpdateError;
  if FSignalHandle <> 0       then Deactivate;

  if Trim(FPropertyName) = ''                               then Exit;
  if (Trim(FGroupName)   = '') and (Trim(FServerName) = '') then Exit;
  if Trim(FItemName)     = ''                               then Exit;

  if Active then Deactivate;

  if FPropertyType in [tkLString, tkWString] then AVarType :=  varOleStr
  else                                            AVarType := varEmpty;

  FSignalHandle := OPCDLLSignalAdd(PChar(FComputerName), PChar(FServerName), PChar(FItemName), PChar(FGroupName), FUpdateRate, True, AVarType, Self);
end;
//***********************************************************************************************************************************
procedure TiOPCItem.Deactivate;
begin
  if OPCDLLNotLoaded     then Exit;
  if not Assigned(Owner) then Exit;
  if Owner.IsDesigning   then Exit;

  OPCDLLSignalRemove(FSignalHandle);
  FSignalHandle := 0;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.NewData(Handle: Integer);
begin
  ReceiveData(Handle);
end;
//***********************************************************************************************************************************
procedure TiOPCItem.ReceiveData(Handle: Integer);
var
  ADouble  : Double;
  AInteger : Integer;
begin
  FData      := OPCDLLSignalGetData     (FSignalHandle);
  FTimeStamp := OPCDLLSignalGetTimeStamp(FSignalHandle);
  FQuality   := OPCDLLSignalGetQuality  (FSignalHandle);

  if QualityGood then
    begin
      if FScalar <> 0 then
        begin
          case TVarData(FData).VType of
            varDouble, varSingle : begin
                                      ADouble := FData;
                                      ADouble := ADouble * FScalar;
                                      FData   := ADouble;
                                    end;
            varInteger,
            varByte,
            {$IFDEF COMPILER_6_UP}
            varInt64,
            varShortInt,
            varWord,
            varLongWord,
            {$endif}
            varSmallInt             : begin
                                      AInteger := FData;
                                      AInteger := Round(AInteger * FScalar);
                                      FData    := AInteger;
                                    end;
          end;

        end;
      if FOffset <> 0 then
        begin
          case TVarData(FData).VType of
            varDouble, varSingle : begin
                                      ADouble := FData;
                                      ADouble := ADouble + FOffset;
                                      FData   := ADouble;
                                    end;
            varInteger,
            varByte,
            {$IFDEF COMPILER_6_UP}
            varInt64,
            varShortInt,
            varWord,
            varLongWord,
            {$endif}
            varSmallInt           : begin
                                      AInteger := FData;
                                      AInteger := Round(AInteger + FOffset);
                                      FData    := AInteger;
                                    end;
          end;

        end;
    end;

    if FAutoError                 then UpdateError;
  if Assigned(FOwner.OnNewData) then FOwner.OnNewData(Self);
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetData(const Value: OleVariant);
begin
  if OPCDLLNotLoaded then Exit;
  
  OPCDLLSignalSendData(FSignalHandle, Value);
end;
//***********************************************************************************************************************************
function TiOPCItem.GetDataNow(var Quality: Word): OleVariant;
begin
  if OPCDLLNotLoaded then Exit;

  OPCDLLSignalGetDataNow(FSignalHandle);

  FData      := OPCDLLSignalGetData     (FSignalHandle);
  FTimeStamp := OPCDLLSignalGetTimeStamp(FSignalHandle);
  FQuality   := OPCDLLSignalGetQuality  (FSignalHandle);

  Quality := FQuality;
  Result  := FData;
end;
//***********************************************************************************************************************************
{ TiOPCItemManager }
//***********************************************************************************************************************************
constructor TiOPCItemManager.Create;
begin
  FList := TStringList.Create;
end;
//***********************************************************************************************************************************
destructor TiOPCItemManager.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;
//***********************************************************************************************************************************
function TiOPCItemManager.Add: Integer;
var
  iOPCItem : TiOPCItem;
begin
  iOPCItem := TiOPCItem.Create;
  iOPCItem.Owner := Self;
  Result := FList.AddObject('',iOPCItem);
end;
//***********************************************************************************************************************************
procedure TiOPCItemManager.Clear;
begin
  while FList.Count > 0 do
    begin
      FList.Objects[0].Free;
      FList.Delete(0);
    end;
end;
//***********************************************************************************************************************************
procedure TiOPCItemManager.Delete(Index: Integer);
begin
  FList.Objects[Index].Free;
  FList.Delete(Index);
end;
//***********************************************************************************************************************************
function TiOPCItemManager.GetCount: Integer;
begin
  Result := FList.Count;
end;
//***********************************************************************************************************************************
function TiOPCItemManager.GetItem(Index: Integer): TiOPCItem;
begin
  Result := FList.Objects[Index] as TiOPCItem;
end;
//***********************************************************************************************************************************
function TiOPCItemManager.FindIndex(OPCItem: TiOPCItem): Integer;
begin
  Result := FList.IndexOfObject(OPCItem);
end;
//***********************************************************************************************************************************
function TiOPCItemManager.DoWriteToStream: Boolean;
begin
  Result := Count > 0;
end;
//***********************************************************************************************************************************
procedure TiOPCItemManager.WriteToStream(Writer: TWriter);
var
  x : Integer;
begin
  TWriterAccess(Writer).WriteValue(vaCollection);
  for x := 0 to Count - 1 do
  begin
    Writer.WriteListBegin;
    WriterWriteProperties(Writer, GetItem(x));
    Writer.WriteListEnd;
  end;
  Writer.WriteListEnd;
end;
//***********************************************************************************************************************************
procedure TiOPCItemManager.ReadFromStream(Reader: TReader);
var
  Item : TiOPCItem;
begin
  Clear;
  if not Reader.EndOfList then Clear;
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Item := TiOPCItem.Create;
    Item.Owner := Self;
    FList.AddObject('',Item);
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(Item);
    Reader.ReadListEnd;
    Item.Loaded;
  end;
  Reader.ReadListEnd; 
end;
//***********************************************************************************************************************************
function TiOPCItemManager.GetDesigning: Boolean;
begin
  Result := False;
  if Assigned(FOnGetDesigning) then FOnGetDesigning(Self, Result);
end;
//***********************************************************************************************************************************
procedure TiOPCItem.UpdateResume;
begin
  if OPCDLLNotLoaded then Exit;
  OPCDLLSignalResume(FSignalHandle);
end;
//***********************************************************************************************************************************
procedure TiOPCItem.UpdateSuspend;
begin
  if OPCDLLNotLoaded then Exit;
  OPCDLLSignalSuspend(FSignalHandle);
end;
//***********************************************************************************************************************************
function TiOPCItem.GetUpdateSuspended: Boolean;
begin
  Result := False;

  if OPCDLLNotLoaded then Exit;
  if FSignalHandle <> 0 then Result := OPCDLLSignalGetUpdateSuspended(FSignalHandle);
end;
//***********************************************************************************************************************************
procedure TiOPCItem.SetAutoError(const Value: Boolean);
begin
  if FAutoError <> Value then
    begin
      FAutoError := Value;
      if FAutoError then UpdateError;
    end;
end;
//***********************************************************************************************************************************
procedure TiOPCItem.UpdateError;
var
  iComponent : TiComponent;
begin
  if not Active                 then                                               Exit;
  if not Assigned(Owner)        then                                               Exit;
  if not Assigned(Owner.Owner)  then                                               Exit;
  if Owner.Owner is TiComponent then iComponent := Owner.Owner as TiComponent else Exit;

  if Active then
    begin
      if QualityGood then TiComponentAccess(iComponent).ErrorActive := False
        else TiComponentAccess(iComponent).ErrorActive := True;
    end;
end;
//***********************************************************************************************************************************
function TiOPCItem.GetQualityGood: Boolean;
begin
  Result := (FQuality and $C0) = $C0;
end;
//***********************************************************************************************************************************
function TiOPCItem.GetActive: Boolean;
begin
  Result := False;
  if not Assigned(Owner) then Exit;
  if Owner.IsDesigning   then Exit;
  if OPCDLLNotLoaded     then Exit;
  Result := OPCDLLSignalGetActive(FSignalHandle);
end;
//***********************************************************************************************************************************
function TiOPCItem.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else                           Result := E_NOINTERFACE;
end;
//***********************************************************************************************************************************
function TiOPCItem._AddRef: Integer;
begin
  Result := -1;
end;
//***********************************************************************************************************************************
function TiOPCItem._Release: Integer;
begin
  Result := -1;
end;
//***********************************************************************************************************************************
end.
