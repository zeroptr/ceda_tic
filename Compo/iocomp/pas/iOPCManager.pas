{*******************************************************}
{                                                       }
{       TiOPCManager Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCManager;{$endif}
{$ifdef iCLX}unit QiOPCManager;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} iTypes,  iGPFunctions,  iOPCDLLLoader;{$ENDIF}
  {$IFDEF iCLX}QiTypes, QiGPFunctions, QiOPCDLLLoader, QImgList;{$ENDIF}

type
  TGroupUpdateEvent  = procedure(Sender: TObject; GroupName: String) of object;

  TiOPCGroupStream = class(TPersistent)
  private
    FName           : String;
    FComputerName   : String;
    FOPCServerName  : String;
    FUpdateRate     : Integer;
  published
    property Name          : String  read FName          write FName;
    property ComputerName  : String  read FComputerName  write FComputerName;
    property OPCServerName : String  read FOPCServerName write FOPCServerName;
    property UpdateRate    : Integer read FUpdateRate    write FUpdateRate;
  end;

  TiOPCGroupObject = class(TPersistent)
  private
    FName           : String;
    FComputerName   : String;
    FOPCServerName  : String;
    FUpdateRate     : Integer;
    FDLLGroupHandle : Integer;
  protected
    procedure SetUpdateRate(const Value: Integer);

    property DLLGroupHandle : Integer read FDLLGroupHandle  write FDLLGroupHandle;
  public
    procedure Resume;
    procedure Suspend;
  published
    property Name          : String  read FName;
    property ComputerName  : String  read FComputerName;
    property OPCServerName : String  read FOPCServerName;
    property UpdateRate    : Integer read FUpdateRate     write SetUpdateRate;
  end;

  TiOPCManager = class(TCustomControl, IOPCGroupUpdate)
  private
    FImageList           : TImageList;
    FFirstInstance       : Boolean;
    FOnAfterGroupUpdate  : TGroupUpdateEvent;
    FOnBeforeGroupUpdate : TGroupUpdateEvent;
    FGroupList           : TStringList;
  protected
    function GetGroup        (Index:  Integer): TiOPCGroupObject;
    function GetGroupByHandle(Handle: Integer): TiOPCGroupObject;

    function GetGroupCount: Integer;

    procedure DefineProperties    (Filer: TFiler); override;
    procedure ReadFromStreamGroups(Reader: TReader);
    procedure WriteToStreamGroups (Writer: TWriter);

    procedure BeforeUpdate(Handle: Integer); stdcall;
    procedure AfterUpdate (Handle: Integer); stdcall;

    procedure Paint;                                              override;
  public
    constructor Create(AOwner: TComponent);                       override;
    destructor  Destroy;                                          override;
    procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure ExplorerShow;

    procedure CloseAllServerConnections;

    function  GroupAdd(Name, ComputerName, OPCServerName: String; UpdateRate: Integer): Integer;
    procedure GroupDelete(Index: Integer);
    procedure GroupClear;

    function  GetGroupIndex(Name: String): Integer;

    property  GroupCount            : Integer          read GetGroupCount;
    property  Group[Index: Integer] : TiOPCGroupObject read GetGroup;
  published
    property Visible default False;
    property PopupMenu;

    property Width  default 28;
    property Height default 28;

    property OnBeforeGroupUpdate : TGroupUpdateEvent read FOnBeforeGroupUpdate write FOnBeforeGroupUpdate;
    property OnAfterGroupUpdate  : TGroupUpdateEvent read FOnAfterGroupUpdate  write FOnAfterGroupUpdate;
  end;

implementation

uses
  {$IFDEF iVCL} iOPCExplorer;{$ENDIF}
  {$IFDEF iCLX}QiOPCExplorer;{$ENDIF}

type
  TWriterAccess = class(TWriter)end;
  TReaderAccess = class(TReader)end;

//****************************************************************************************************************************************************
constructor TiOPCManager.Create(AOwner: TComponent);
var
  Bitmap  : TBitmap;
begin
  FFirstInstance := OPCDLLManagerCreated;

  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csReplicatable];

  Width   := 28;
  Height  := 28;
  Visible := False;

  FImageList := TImageList.CreateSize(24, 24);

  FGroupList := TStringList.Create;

  Bitmap := TBitmap.Create;
  try
    Bitmap.LoadFromResourceName(HInstance, 'OPCMANAGER');
    FImageList.AddMasked(Bitmap, clWhite);
  finally
    Bitmap.Free;
  end;

  iOPCExplorerForm := nil;
end;
//****************************************************************************************************************************************************
destructor TiOPCManager.Destroy;
begin
  FImageList.Free;
  GroupClear;
  FGroupList.Free;

  if not Assigned(iOPCExplorerForm) then iOPCExplorerForm.Free;

  if FFirstInstance then OPCDLLManagerDestroyed;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiOPCManager.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  AWidth  := 28;
  AHeight := 28;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiOPCManager.Paint;
begin
  with Canvas do
    begin
      Pen.Color := clBtnHighlight;
      PolyLine([Point(0,Height-1), Point(0,0), Point(Width-1,0)]);

      Pen.Color := clBtnShadow;
      PolyLine([Point(Width-1, 1), Point(Width-1,Height-1), Point(0,Height-1)]);
    end;
  {$ifdef iVCL}FImageList.Draw(Canvas, 2, 2, 0, Enabled);         {$endif}
  {$ifdef iCLX}FImageList.Draw(Canvas, 2, 2, 0, itImage, Enabled);{$endif}
end;
//****************************************************************************************************************************************************
function TiOPCManager.GroupAdd(Name, ComputerName, OPCServerName: String; UpdateRate: Integer): Integer;
var
  iGroupObject : TiOPCGroupObject;
begin
  iGroupObject := TiOPCGroupObject.Create;

  iGroupObject.FName          := Name;
  iGroupObject.FComputerName  := ComputerName;
  iGroupObject.FOPCServerName := OPCServerName;
  iGroupObject.FUpdateRate    := UpdateRate;

  Result := FGroupList.AddObject('', iGroupObject);

  if OPCDLLNotLoaded then Exit;

  iGroupObject.DLLGroupHandle := OPCDLLGroupAdd(PChar(Name), PChar(ComputerName), PChar(OPCServerName), iGroupObject.UpdateRate, self);
end;
//****************************************************************************************************************************************************
procedure TiOPCManager.GroupDelete(Index: Integer);
begin
  if Group[Index].DLLGroupHandle <> 0 then OPCDLLGroupDelete(Group[Index].DLLGroupHandle);
  FGroupList.Objects[Index].Free;
  FGroupList.Delete(Index);
end;
//****************************************************************************************************************************************************
procedure TiOPCManager.GroupClear;
begin
  while GroupCount <> 0 do GroupDelete(0);
end;
//****************************************************************************************************************************************************
function TiOPCManager.GetGroup(Index: Integer): TiOPCGroupObject;
begin
  Result := FGroupList.Objects[Index] as TiOPCGroupObject;
end;
//*************************************************************************************************************************************
function TiOPCManager.GetGroupByHandle(Handle: Integer): TiOPCGroupObject;
var
  x : Integer;
begin
  Result := nil;
  for x := 0 to FGroupList.Count-1 do
    if Group[x].FDLLGroupHandle = Handle then
      begin
        Result := Group[x];
        Break;
      end;
end;
//****************************************************************************************************************************************************
function TiOPCManager.GetGroupCount: Integer;
begin
  Result := FGroupList.Count;
end;
//****************************************************************************************************************************************************
procedure TiOPCManager.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Groups', ReadFromStreamGroups, WriteToStreamGroups, GroupCount <> 0);
end;
//****************************************************************************************************************************************************
procedure TiOPCManager.ReadFromStreamGroups(Reader: TReader);
var
  iOPCGroupStream : TiOPCGroupStream;
begin
  GroupClear;
  if not Reader.EndOfList then GroupClear;
  if TReaderAccess(Reader).ReadValue <> vaCollection then exit;
  while not Reader.EndOfList do
  begin
    iOPCGroupStream := TiOPCGroupStream.Create;
    try
      Reader.ReadListBegin;
      while not Reader.EndOfList do TReaderAccess(Reader).ReadProperty(iOPCGroupStream);
      Reader.ReadListEnd;
      GroupAdd(iOPCGroupStream.Name, iOPCGroupStream.ComputerName, iOPCGroupStream.OPCServerName, iOPCGroupStream.UpdateRate);
    finally
      iOPCGroupStream.Free;
    end;
  end;
  Reader.ReadListEnd;
end;
//****************************************************************************************************************************************************
procedure TiOPCManager.WriteToStreamGroups(Writer: TWriter);
var
  x               : Integer;
  iOPCGroupStream : TiOPCGroupStream;
begin
  iOPCGroupStream := TiOPCGroupStream.Create;
  try
    TWriterAccess(Writer).WriteValue(vaCollection);
    for x := 0 to GroupCount - 1 do
    begin
      Writer.WriteListBegin;

      iOPCGroupStream.Name          := Group[x].Name;
      iOPCGroupStream.ComputerName  := Group[x].ComputerName;
      iOPCGroupStream.OPCServerName := Group[x].OPCServerName;
      iOPCGroupStream.UpdateRate    := Group[x].UpdateRate;

      WriterWriteProperties(Writer, iOPCGroupStream);

      Writer.WriteListEnd;
    end;
    Writer.WriteListEnd;
  finally
    iOPCGroupStream.Free;
  end;
end;
//*************************************************************************************************************************************
procedure TiOPCManager.BeforeUpdate(Handle: Integer);
var
  iOPCGroupObject : TiOPCGroupObject;
  AName           : String;
begin
  AName := '';
  iOPCGroupObject := GetGroupByHandle(Handle);
  if Assigned(iOPCGroupObject) then AName := iOPCGroupObject.Name;

  if Assigned(FOnBeforeGroupUpdate) then FOnBeforeGroupUpdate(Self, AName);
end;
//*************************************************************************************************************************************
procedure TiOPCManager.AfterUpdate(Handle: Integer);
var
  iOPCGroupObject : TiOPCGroupObject;
  AName           : String;
begin
  AName := '';
  iOPCGroupObject := GetGroupByHandle(Handle);
  if Assigned(iOPCGroupObject) then AName := iOPCGroupObject.Name;

  if Assigned(FOnAfterGroupUpdate) then FOnAfterGroupUpdate(Self, AName);
end;
//*************************************************************************************************************************************
procedure TiOPCGroupObject.Resume;
begin
  OPCDLLGroupResume(DLLGroupHandle);
end;
//*************************************************************************************************************************************
procedure TiOPCGroupObject.SetUpdateRate(const Value: Integer);
begin
  if FUpdateRate <> Value then
    begin
      FUpdateRate := Value;
      OPCDLLGroupSetUpdateRate(FDLLGroupHandle, FUpdateRate);
    end;
end;
//*************************************************************************************************************************************
procedure TiOPCGroupObject.Suspend;
begin
  OPCDLLGroupSuspend(DLLGroupHandle);
end;
//*************************************************************************************************************************************
function TiOPCManager.GetGroupIndex(Name: String): Integer;
var
  x : Integer;
begin
  Result := -1;
  for x := 0 to GroupCount-1 do
    if UpperCase(Group[x].Name) = UpperCase(Name) then
      begin
        Result := x;
        Break;
      end;
end;
//*************************************************************************************************************************************
procedure TiOPCManager.CloseAllServerConnections;
begin
  OPCDLLCloseAllServerConnections;
end;
//*************************************************************************************************************************************
procedure TiOPCManager.ExplorerShow;
begin
  if not Assigned(iOPCExplorerForm) then iOPCExplorerForm := TiOPCExplorerForm.Create(Application);
  iOPCExplorerForm.Refresh;
  iOPCExplorerForm.Show;
end;
//*************************************************************************************************************************************
end.


