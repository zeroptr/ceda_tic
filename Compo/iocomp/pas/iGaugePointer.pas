{*******************************************************}
{                                                       }
{       TiGaugePointer                                  }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iGaugePointer;{$endif}
{$ifdef iCLX}unit QiGaugePointer;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes, iGPFunctions; {$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions;{$ENDIF}

type
  TiGaugePointer = class;
  
  TiGaugePointerManager = class(TObject)
  private
    FList              : TStringList;
    FOnInsert          : TNotifyEvent;
    FOnRemove          : TNotifyEvent;
    FOnChange          : TNotifyEvent;
    FOnPositionChanged : TNotifyEvent;
  protected
    function  GetCount: Integer;
    function  GetItem  (Index: Integer): TiGaugePointer;

    procedure NotificationInsert(Sender : TObject);
    procedure NotificationRemove(Sender : TObject);

    procedure DoChange         (Sender: TObject);
    procedure DoPositionChanged(Sender: TObject);
  public
    constructor Create(AOnChange, AOnInsert, AOnRemove, APositionChanged : TNotifyEvent); virtual;
    destructor  Destroy; override;

    function  DoWriteToStream : Boolean;
    procedure WriteToStream (Writer: TWriter);
    procedure ReadFromStream(Reader: TReader);

    procedure Clear;
    procedure Delete(Index: Integer);
    function  CreateObject : TiGaugePointer;
    function  Add: Integer;

    function  IndexOfObject(Pointer: TiGaugePointer): Integer;

    procedure ClearAllFocus;

    property  Items[Index: Integer]: TiGaugePointer read GetItem;
    property  Count                : Integer        read GetCount;
  end;

  TiGaugePointer = class(TPersistent)
  private
    {$IFDEF iVCL} FRegion : HRGN; {$ENDIF}
    {$IFDEF iCLX} FRegion : TRect;{$ENDIF}

    FSize             : Integer;
    FStyle            : Integer;
    FStyle3D          : Boolean;
    FMargin           : Integer;
    FColor            : TColor;
    FDisabledColor    : TColor;
    FOwner            : TiGaugePointerManager;
    FPosition         : Double;
    FVisible          : Boolean;
    FEnabled          : Boolean;
    FMouseDown        : Boolean;
    FUserCanMove      : Boolean;
    FUseDisabledColor : Boolean;
    FDrawScaleSide    : Boolean;
    FFocused          : Boolean;
  protected
    procedure SetSize            (const Value: Integer);
    procedure SetColor           (const Value: TColor);
    procedure SetDisabledColor   (const Value: TColor);
    procedure SetMargin          (const Value: Integer);
    procedure SetStyle           (const Value: Integer);
    procedure SetStyle3D         (const Value: Boolean);
    procedure SetPosition        (const Value: Double);
    procedure SetVisible         (const Value: Boolean);
    procedure SetEnabled         (const Value: Boolean);
    procedure SetFocused         (const Value: Boolean);
    procedure SetDrawScaleSide   (const Value: Boolean);
    procedure SetMouseDown       (const Value: Boolean);
    procedure SetUseDisabledColor(const Value: Boolean);

    {$IFDEF iVCL} procedure SetRegion  (Value: HRGN);  {$ENDIF}
    {$IFDEF iCLX} procedure SetRegion  (Value: TRect); {$ENDIF}

    function  GetDrawColor: TColor;

    procedure DoChange;
    procedure DoPositionChanged;

    property MouseDown : Boolean      read FMouseDown write SetMouseDown;

    {$IFDEF iVCL} property Region : HRGN  read FRegion write SetRegion;{$ENDIF}
    {$IFDEF iCLX} property Region : TRect read FRegion write SetRegion;{$ENDIF}
  public
    constructor Create(AOwner: TiGaugePointerManager);
    destructor  Destroy; override;

    function  iMouseHitTest(X, Y: Integer): Boolean;
    function  GetMousePointer(): TCursor;

    property ColorDraw        : TColor  read GetDrawColor;
    property Focused          : Boolean read FFocused          write SetFocused;
  published
    property Visible          : Boolean read FVisible          write SetVisible          default True;
    property Enabled          : Boolean read FEnabled          write SetEnabled          default True;
    property Size             : Integer read FSize             write SetSize             default 10;
    property Margin           : Integer read FMargin           write SetMargin           default 0;
    property Color            : TColor  read FColor            write SetColor            default clBlue;
    property DisabledColor    : TColor  read FDisabledColor    write SetDisabledColor    default clGray;
    property Style            : Integer read FStyle            write SetStyle;
    property Style3D          : Boolean read FStyle3D          write SetStyle3D          default False;
    property Position         : Double  read FPosition         write SetPosition;
    property DrawScaleSide    : Boolean read FDrawScaleSide    write SetDrawScaleSide    default False;
    property UserCanMove      : Boolean read FUserCanMove      write FUserCanMove        default False;
    property UseDisabledColor : Boolean read FUseDisabledColor write SetUseDisabledColor default False;
  end;

implementation

type
  TWriterAccess     = class(TWriter    ) end;
  TReaderAccess     = class(TReader    ) end;
  TPersistentAccess = class(TPersistent) end;
//****************************************************************************************************************************************************
constructor TiGaugePointer.Create(AOwner: TiGaugePointerManager);
begin
  FSize             := 10;
  FMargin           := 0;
  FColor            := clBlue;
  FDisabledColor    := clGray;
  FStyle            := 3;
  FStyle3D          := False;
  FVisible          := True;
  FEnabled          := True;
  FDrawScaleSide    := False;
  FUserCanMove      := False;
  FUseDisabledColor := False;

  FOwner := AOwner;
  if Assigned(FOwner) then FOwner.NotificationInsert(Self);
end;
//****************************************************************************************************************************************************
destructor TiGaugePointer.Destroy;
begin
  {$IFDEF iVCL} if FRegion <> 0 then DeleteObject(FRegion); FRegion := 0;{$ENDIF}

  if Assigned(FOwner) then FOwner.NotificationRemove(Self);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.DoChange;
begin
  if Assigned(FOwner) then FOwner.DoChange(Self);
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.DoPositionChanged;
begin
  if Assigned(FOwner) then
    FOwner.DoPositionChanged(Self);
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetPosition(const Value: Double);
begin
  if FPosition <> Value then
    begin
      FPosition := Value;
      DoChange;
      DoPositionChanged;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetColor(const Value: TColor);
begin
  if FColor <> Value then
    begin
      FColor := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetDisabledColor(const Value: TColor);
begin
  if FDisabledColor <> Value then
    begin
      FDisabledColor := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetMargin(const Value: Integer);
begin
  if FMargin <> Value then
    begin
      FMargin := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetSize(const Value: Integer);
begin
  if FSize <> Value then
    begin
      FSize := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
    begin
      FVisible := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
    begin
      FEnabled := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetFocused(const Value: Boolean);
begin
  if FFocused <> Value then
    begin
      FFocused := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetDrawScaleSide(const Value: Boolean);
begin
  if FDrawScaleSide <> Value then
    begin
      FDrawScaleSide := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetMouseDown(const Value: Boolean);
begin
  if FMouseDown <> Value then
    begin
      FMouseDown := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetStyle(const Value: Integer);
begin
  if FStyle <> Value then
    begin
      FStyle := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetStyle3D(const Value: Boolean);
begin
  if FStyle3D <> Value then
    begin
      FStyle3D := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointer.SetUseDisabledColor(const Value: Boolean);
begin
  if FUseDisabledColor <> Value then
    begin
      FUseDisabledColor := Value;
      DoChange;
    end;
end;
//****************************************************************************************************************************************************
{$IFDEF iVCL}
procedure TiGaugePointer.SetRegion(Value: HRGN);
begin
  if FRegion <> 0 then DeleteObject(FRegion);
  FRegion := Value;
end;
{$ENDIF}
//****************************************************************************************************************************************************
{$IFDEF iCLX}
procedure TiGaugePointer.SetRegion(Value: TRect);
begin
  FRegion := Value;
end;
{$ENDIF}
//****************************************************************************************************************************************************
{ TiGaugePointerManager }
//****************************************************************************************************************************************************
constructor TiGaugePointerManager.Create(AOnChange, AOnInsert, AOnRemove, APositionChanged : TNotifyEvent);
begin
  if not Assigned(AOnChange)  then raise Exception.Create('OnChange event handler can not be null');
  if not Assigned(AOnInsert)  then raise Exception.Create('OnInsert event handler can not be null');
  if not Assigned(AOnRemove)  then raise Exception.Create('OnRemove event handler can not be null');

  FOnChange          := AOnChange;
  FOnInsert          := AOnInsert;
  FOnRemove          := AOnRemove;
  FOnPositionChanged := APositionChanged;

  FList := TStringList.Create;

  if Assigned(FOnInsert) then FOnInsert(Self);
end;
//****************************************************************************************************************************************************
destructor TiGaugePointerManager.Destroy;
begin
  Clear;
  FList.Free;

  if Assigned(FOnRemove) then FOnRemove(Self);
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.DoChange(Sender: TObject);
begin
  if Assigned(FOnChange) then FOnChange(Sender);
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.DoPositionChanged(Sender: TObject);
begin
  if Assigned(FOnPositionChanged) then FOnPositionChanged(Sender);
end;
//****************************************************************************************************************************************************
function TiGaugePointerManager.GetCount: Integer;
begin
  Result := FList.Count;
end;
//****************************************************************************************************************************************************
function TiGaugePointerManager.Add: Integer;
begin
  Result := FList.IndexOfObject(CreateObject);
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.Clear;
begin
  while FList.Count <> 0 do
    FList.Objects[0].Free;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.ClearAllFocus;
var
  i : Integer;
begin
  for i := 0 to Count-1 do
    Items[i].Focused := False;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.Delete(Index: Integer);
begin
  FList.Objects[Index].Free;
end;
//****************************************************************************************************************************************************
function TiGaugePointerManager.CreateObject: TiGaugePointer;
begin
  Result := TiGaugePointer.Create(Self);
end;
//****************************************************************************************************************************************************
function TiGaugePointerManager.GetItem(Index: Integer): TiGaugePointer;
begin
  Result := FList.Objects[Index] as TiGaugePointer;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.NotificationInsert(Sender: TObject);
begin
  if Sender is TiGaugePointer then if FList.IndexOfObject(Sender) = -1 then
    FList.AddObject('', Sender);

  if Assigned(FOnInsert) then FOnInsert(Sender);
  if Assigned(FOnChange) then FOnChange(Sender);
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.NotificationRemove(Sender: TObject);
var
  x : Integer;
begin
  if Assigned(FOnRemove) then FOnRemove(Sender);
  if Assigned(FOnChange) then FOnChange(Sender);

  for x := 0 to Count-1 do
    if (FList.Objects[x] = Sender) then
      begin
        FList.Delete(x);
        Break;
      end;
end;
//****************************************************************************************************************************************************
function TiGaugePointerManager.DoWriteToStream: Boolean;
begin
  Result := FList.Count <> 0;
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.ReadFromStream(Reader: TReader);
var
  Item : TiGaugePointer;
begin
  Clear;
  if not Reader.EndOfList then Clear;
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    Item := CreateObject;
    Reader.ReadListBegin;
    while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(Item);
    Reader.ReadListEnd;
  end;
  Reader.ReadListEnd; 
end;
//****************************************************************************************************************************************************
procedure TiGaugePointerManager.WriteToStream(Writer: TWriter);
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
//****************************************************************************************************************************************************
function TiGaugePointerManager.IndexOfObject(Pointer: TiGaugePointer): Integer;
begin
  Result := FList.IndexOfObject(Pointer);
end;
//****************************************************************************************************************************************************
function TiGaugePointer.iMouseHitTest(X, Y: Integer): Boolean;
begin
  Result := False;

  if not Enabled then Exit;
  if not Visible then Exit;
  {$IFDEF iVCL}
  if Region  = 0 then Exit;
  if not PtInRegion(Region, X, Y) then Exit;
  {$ENDIF}
  {$IFDEF iCLX}
   Exit; //TODO CLX
  {$ENDIF}
  Result := True;
end;
//****************************************************************************************************************************************************
function TiGaugePointer.GetMousePointer: TCursor;
begin
  if UserCanMove then Result := crHandPoint
  else                Result := crArrow;
end;
//****************************************************************************************************************************************************
function TiGaugePointer.GetDrawColor: TColor;
begin
  if Enabled or not UseDisabledColor then Result := Color
  else                                    Result := DisabledColor;
end;
//****************************************************************************************************************************************************
end.
