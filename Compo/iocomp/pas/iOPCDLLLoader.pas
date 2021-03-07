{$I iInclude.inc}

{$ifdef iVCL}unit  iOPCDLLLoader;{$endif}
{$ifdef iCLX}unit QiOPCDLLLoader;{$endif}

interface
                                               
uses                                                                                
  {$I iIncludeUsesForms.inc}             
  {$IFDEF iVCL} iTypes, ComObj;{$ENDIF} //Need ComObj file to init COM
  {$IFDEF iCLX}QiTypes;{$ENDIF}

const                                                                                 
  OPCMANAGERDLLSTRINGRESOURCE = 'iOPC2.dll';

type
TSignalAdd                       = procedure(var Handle: Integer; ComputerName, OPCServerName, ItemName, GroupName: WideString; UpdateRate: Integer; Suspend: Boolean; DataType: TVarType; UpdateInterface: IOPCSignalUpdate); stdcall;
TSignalRemove                    = procedure(SignalHandle: Integer);                                                        stdcall;
TSignalSuspend                   = procedure(SignalHandle: Integer);                                                        stdcall;
TSignalResume                    = procedure(SignalHandle: Integer);                                                        stdcall;
TSignalGetActive                 = procedure(SignalHandle: Integer; var Value: Boolean);                                    stdcall;
TSignalGetUpdateSuspended        = procedure(SignalHandle: Integer; var Value: Boolean);                                    stdcall;
TSignalGetGroupHandle            = procedure(SignalHandle: Integer; var Value: Integer);                                    stdcall;
TSignalSendData                  = procedure(SignalHandle: Integer; var Data: OLEVariant);                                  stdcall;
TSignalGetDataNow                = procedure(SignalHandle: Integer);                                                        stdcall;

TSignalGetData                   = procedure(SignalHandle: Integer; var Value: OLEVariant);                                 stdcall;
TSignalGetTimeStamp              = procedure(SignalHandle: Integer; var Value: TDateTime);                                  stdcall;
TSignalGetQuality                = procedure(SignalHandle: Integer; var Value: Word);                                       stdcall;

TGroupAdd                        = procedure(var Handle: Integer; Name, ComputerName, OPCServerName: WideString; UpdateRate: Integer; UpdateInterface: IOPCGroupUpdate); stdcall;
TGroupDelete                     = procedure(GroupHandle: Integer);                        stdcall;

TGroupResume                     = procedure(GroupHandle: Integer);                        stdcall;
TGroupSuspend                    = procedure(GroupHandle: Integer);                        stdcall;

TGroupGetHandleByName            = procedure(Name: WideString;     var Value: Integer   ); stdcall;
TGroupGetCount                   = procedure(                      var Value: Integer   ); stdcall;
TGroupGetHandle                  = procedure(Index: Integer;       var Value: Integer   ); stdcall;
TGroupGetName                    = procedure(GroupHandle: Integer; var Value: WideString); stdcall;
TGroupGetComputerName            = procedure(GroupHandle: Integer; var Value: WideString); stdcall;
TGroupGetOPCServerName           = procedure(GroupHandle: Integer; var Value: WideString); stdcall;
TGroupGetUpdateRate              = procedure(GroupHandle: Integer; var Value: Integer);    stdcall;
TGroupSetUpdateRate              = procedure(GroupHandle: Integer; Value: Integer);        stdcall;

TEditorSessionStart              = function: Integer;                                                                       stdcall;
TEditorSessionStop               = procedure(SessionHandle: Integer);                                                       stdcall;

TEditorComputerBranchOpen        = procedure(SessionHandle: Integer; NetResource: TiNetData                );               stdcall;
TEditorComputerBranchClose       = procedure(SessionHandle: Integer                                        );               stdcall;
TEditorComputerBranchGetItemCount= function (SessionHandle: Integer                                        ): Integer;      stdcall;
TEditorComputerBranchGetItemData = function (SessionHandle: Integer; Index: Integer                        ): TiNetData;    stdcall;

TEditorServerSetup               = procedure(SessionHandle: Integer; MachineName: WideString               );               stdcall;
TEditorServerGetCount            = function (SessionHandle: Integer                                        ): Integer;      stdcall;
TEditorServerGetData             = function (SessionHandle: Integer; Index: Integer                        ): TiServerData; stdcall;

TEditorItemSetup                 = procedure(SessionHandle: Integer; MachineName, OPCServerName: WideString);               stdcall;
TEditorItemGetBrowseType         = function (SessionHandle: Integer                            ): TiNameSpaceType;          stdcall;
TEditorItemSetPath               = procedure(SessionHandle: Integer; Path: WideString          );                           stdcall;
TEditorItemGetBranchItems        = function (SessionHandle: Integer; iBrowseType: TiBrowseType ): WideString;               stdcall;
TEditorItemGetQualifiedName      = function (SessionHandle: Integer; Path, ItemName: WideString): WideString;               stdcall;

TCloseAllServerConnections       = procedure;                                             stdcall;
TServerConnectionGetCount        = function: Integer;                                     stdcall;
TServerConnectionGetName         = function(Index: Integer): WideString;                  stdcall;
TServerConnectionGetGroupCount   = function: Integer;                                     stdcall;
TServerConnectionGetGroupName    = function(Index: Integer): WideString;                  stdcall;
TServerConnectionReconnect       = procedure(Name: WideString);                           stdcall;
TServerConnectionDisconnect      = procedure(Name: WideString);                           stdcall;

TManagerCreated                  = function: Boolean;                                     stdcall;
TManagerAddItem                  = procedure(GroupName: WideString; UpdateRate: Integer); stdcall;
TManagerDestroyed                = procedure;                                             stdcall;

TGetIsEvaluation                 = procedure(var Value: Boolean);                         stdcall;
TGetLastCallErrorString          = procedure(var Value: WideString);                      stdcall;

function  OPCDLLSignalAdd                      (ComputerName, OPCServerName, ItemName, GroupName: String; UpdateRate: Integer; Suspend: Boolean; DataType: TVarType; UpdateInterface: IOPCSignalUpdate): Integer; stdcall;
procedure OPCDLLSignalRemove                   (SignalHandle: Integer);                                                   
procedure OPCDLLSignalSuspend                  (SignalHandle: Integer);                                                   
procedure OPCDLLSignalResume                   (SignalHandle: Integer);
function  OPCDLLSignalGetActive                (SignalHandle: Integer): Boolean;
function  OPCDLLSignalGetUpdateSuspended       (SignalHandle: Integer): Boolean;
function  OPCDLLSignalGetGroupHandle           (SignalHandle: Integer): Integer;
procedure OPCDLLSignalSendData                 (SignalHandle: Integer; Data: OLEVariant);
procedure OPCDLLSignalGetDataNow               (SignalHandle: Integer);

function  OPCDLLSignalGetData                  (SignalHandle: Integer):OLEVariant;
function  OPCDLLSignalGetTimeStamp             (SignalHandle: Integer):TDateTime;
function  OPCDLLSignalGetQuality               (SignalHandle: Integer):Word;

function  OPCDLLEditorSessionStart: Integer;
procedure OPCDLLEditorSessionStop(SessionHandle: Integer);

procedure OPCDLLEditorComputerBranchOpen        (SessionHandle: Integer; NetResource: TiNetData            );
procedure OPCDLLEditorComputerBranchClose       (SessionHandle: Integer                                    );
function  OPCDLLEditorComputerBranchGetItemCount(SessionHandle: Integer                                    ): Integer;
function  OPCDLLEditorComputerBranchGetItemData (SessionHandle: Integer; Index: Integer                    ): TiNetData;

procedure OPCDLLEditorServerSetup               (SessionHandle: Integer; MachineName: String               );
function  OPCDLLEditorServerGetCount            (SessionHandle: Integer                                    ): Integer;
function  OPCDLLEditorServerGetData             (SessionHandle: Integer; Index: Integer                    ): TiServerData;

procedure OPCDLLEditorItemSetup                 (SessionHandle: Integer; MachineName, OPCServerName: String);
function  OPCDLLEditorItemGetBrowseType         (SessionHandle: Integer                                    ): TiNameSpaceType;
procedure OPCDLLEditorItemSetPath               (SessionHandle: Integer; Path: String                      );
function  OPCDLLEditorItemGetBranchItems        (SessionHandle: Integer; iBrowseType: TiBrowseType         ): String;
function  OPCDLLEditorItemGetQualifiedName      (SessionHandle: Integer; Path, ItemName: String            ): String;

function  OPCDLLGroupAdd                        (Name, ComputerName, OPCServerName: String; UpdateRate: Integer; UpdateInterface: IOPCGroupUpdate): Integer;
procedure OPCDLLGroupDelete                     (GroupHandle: Integer);

procedure OPCDLLGroupResume                     (GroupHandle: Integer);
procedure OPCDLLGroupSuspend                    (GroupHandle: Integer);

function  OPCDLLGroupGetHandleByName            (Name: String)        : Integer;
function  OPCDLLGroupGetCount                                         : Integer;
function  OPCDLLGroupGetHandle                  (Index: Integer)      : Integer;
function  OPCDLLGroupGetName                    (GroupHandle: Integer): String;
function  OPCDLLGroupGetComputerName            (GroupHandle: Integer): String;
function  OPCDLLGroupGetOPCServerName           (GroupHandle: Integer): String;
function  OPCDLLGroupGetUpdateRate              (GroupHandle: Integer): Integer;
procedure OPCDLLGroupSetUpdateRate              (GroupHandle: Integer; Value: Integer);

procedure OPCDLLCloseAllServerConnections;
function  OPCDLLServerConnectionGetCount               : Integer;
function  OPCDLLServerConnectionGetName(Index: Integer): String;

function  OPCDLLServerConnectionGetGroupCount               : Integer;
function  OPCDLLServerConnectionGetGroupName(Index: Integer): String;

procedure OPCDLLServerConnectionReconnect (Name: String);
procedure OPCDLLServerConnectionDisconnect(Name: String);

function  OPCDLLManagerCreated: Boolean;
procedure OPCDLLManagerAddItem(GroupName: String; UpdateRate: Integer);
procedure OPCDLLManagerDestroyed;

function  OPCDLLNotLoaded          : Boolean;
function  OPCDLLIsEvaluation       : Boolean;
function  OPCDLLLastCallErrorString: String;


implementation

var
  OPCManagerDLLHandle : HINST;
  OPCDLLLoaded        : Boolean;

  RawOPCDLLSignalAdd                        : TSignalAdd;
  RawOPCDLLSignalRemove                     : TSignalRemove;
  RawOPCDLLSignalSuspend                    : TSignalSuspend;
  RawOPCDLLSignalResume                     : TSignalResume;
  RawOPCDLLSignalGetActive                  : TSignalGetActive;
  RawOPCDLLSignalGetUpdateSuspended         : TSignalGetUpdateSuspended;
  RawOPCDLLSignalGetGroupHandle             : TSignalGetGroupHandle;
  RawOPCDLLSignalSendData                   : TSignalSendData;
  RawOPCDLLSignalGetDataNow                 : TSignalGetDataNow;

  RawOPCDLLSignalGetData                    : TSignalGetData;
  RawOPCDLLSignalGetTimeStamp               : TSignalGetTimeStamp;
  RawOPCDLLSignalGetQuality                 : TSignalGetQuality;

  RawOPCDLLEditorSessionStart               : TEditorSessionStart;
  RawOPCDLLEditorSessionStop                : TEditorSessionStop;

  RawOPCDLLEditorComputerBranchOpen         : TEditorComputerBranchOpen;
  RawOPCDLLEditorComputerBranchClose        : TEditorComputerBranchClose;
  RawOPCDLLEditorComputerBranchGetItemCount : TEditorComputerBranchGetItemCount;
  RawOPCDLLEditorComputerBranchGetItemData  : TEditorComputerBranchGetItemData;

  RawOPCDLLEditorServerSetup                : TEditorServerSetup;
  RawOPCDLLEditorServerGetCount             : TEditorServerGetCount;
  RawOPCDLLEditorServerGetData              : TEditorServerGetData;

  RawOPCDLLEditorItemSetup                  : TEditorItemSetup;
  RawOPCDLLEditorItemGetBrowseType          : TEditorItemGetBrowseType;
  RawOPCDLLEditorItemSetPath                : TEditorItemSetPath;
  RawOPCDLLEditorItemGetBranchItems         : TEditorItemGetBranchItems;
  RawOPCDLLEditorItemGetQualifiedName       : TEditorItemGetQualifiedName;

  RawOPCDLLGroupAdd                         : TGroupAdd;
  RawOPCDLLGroupDelete                      : TGroupDelete;
  RawOPCDLLGroupResume                      : TGroupResume;
  RawOPCDLLGroupSuspend                     : TGroupSuspend;
  RawOPCDLLGroupGetHandleByName             : TGroupGetHandleByName;
  RawOPCDLLGroupGetCount                    : TGroupGetCount;
  RawOPCDLLGroupGetHandle                   : TGroupGetHandle;
  RawOPCDLLGroupGetName                     : TGroupGetName;
  RawOPCDLLGroupGetComputerName             : TGroupGetComputerName;
  RawOPCDLLGroupGetOPCServerName            : TGroupGetOPCServerName;
  RawOPCDLLGroupGetUpdateRate               : TGroupGetUpdateRate;
  RawOPCDLLGroupSetUpdateRate               : TGroupSetUpdateRate;

  RawOPCDLLCloseAllServerConnections        : TCloseAllServerConnections;
  RawOPCDLLServerConnectionGetCount         : TServerConnectionGetCount;
  RawOPCDLLServerConnectionGetName          : TServerConnectionGetName;
  RawOPCDLLServerConnectionGetGroupCount    : TServerConnectionGetGroupCount;
  RawOPCDLLServerConnectionGetGroupName     : TServerConnectionGetGroupName;
  RawOPCDLLServerConnectionReconnect        : TServerConnectionReconnect;
  RawOPCDLLServerConnectionDisconnect       : TServerConnectionDisconnect;

  RawOPCDLLManagerCreated                   : TManagerCreated;
  RawOPCDLLManagerAddItem                   : TManagerAddItem;
  RawOPCDLLManagerDestroyed                 : TManagerDestroyed;

  RawOPCDLLGetIsEvaluation                  : TGetIsEvaluation;
  RawOPCDLLGetLastCallErrorString           : TGetLastCallErrorString;
//******************************************************************************
procedure MapFunctionPointers;
begin

  @RawOPCDLLSignalAdd                        := GetProcAddress(OPCManagerDLLHandle, 'SignalAdd');
  @RawOPCDLLSignalRemove                     := GetProcAddress(OPCManagerDLLHandle, 'SignalRemove');

  @RawOPCDLLSignalSuspend                    := GetProcAddress(OPCManagerDLLHandle, 'SignalSuspend');
  @RawOPCDLLSignalResume                     := GetProcAddress(OPCManagerDLLHandle, 'SignalResume');
  @RawOPCDLLSignalGetActive                  := GetProcAddress(OPCManagerDLLHandle, 'SignalGetActive');
  @RawOPCDLLSignalGetUpdateSuspended         := GetProcAddress(OPCManagerDLLHandle, 'SignalGetUpdateSuspended');
  @RawOPCDLLSignalGetGroupHandle             := GetProcAddress(OPCManagerDLLHandle, 'SignalGetGroupHandle');
  @RawOPCDLLSignalSendData                   := GetProcAddress(OPCManagerDLLHandle, 'SignalSendData');
  @RawOPCDLLSignalGetDataNow                 := GetProcAddress(OPCManagerDLLHandle, 'SignalGetDataNow');

  @RawOPCDLLSignalGetData                    := GetProcAddress(OPCManagerDLLHandle, 'SignalGetData');
  @RawOPCDLLSignalGetTimeStamp               := GetProcAddress(OPCManagerDLLHandle, 'SignalGetTimeStamp');
  @RawOPCDLLSignalGetQuality                 := GetProcAddress(OPCManagerDLLHandle, 'SignalGetQuality');

  @RawOPCDLLEditorSessionStart               := GetProcAddress(OPCManagerDLLHandle, 'EditorSessionStart');
  @RawOPCDLLEditorSessionStop                := GetProcAddress(OPCManagerDLLHandle, 'EditorSessionStop');

  @RawOPCDLLEditorComputerBranchOpen         := GetProcAddress(OPCManagerDLLHandle, 'EditorComputerBranchOpen');
  @RawOPCDLLEditorComputerBranchClose        := GetProcAddress(OPCManagerDLLHandle, 'EditorComputerBranchClose');
  @RawOPCDLLEditorComputerBranchGetItemCount := GetProcAddress(OPCManagerDLLHandle, 'EditorComputerBranchGetItemCount');
  @RawOPCDLLEditorComputerBranchGetItemData  := GetProcAddress(OPCManagerDLLHandle, 'EditorComputerBranchGetItemData');

  @RawOPCDLLEditorServerSetup                := GetProcAddress(OPCManagerDLLHandle, 'EditorServerSetup');
  @RawOPCDLLEditorServerGetCount             := GetProcAddress(OPCManagerDLLHandle, 'EditorServerGetCount');
  @RawOPCDLLEditorServerGetData              := GetProcAddress(OPCManagerDLLHandle, 'EditorServerGetData');

  @RawOPCDLLEditorItemSetup                  := GetProcAddress(OPCManagerDLLHandle, 'EditorItemSetup');
  @RawOPCDLLEditorItemGetBrowseType          := GetProcAddress(OPCManagerDLLHandle, 'EditorItemGetBrowseType');
  @RawOPCDLLEditorItemSetPath                := GetProcAddress(OPCManagerDLLHandle, 'EditorItemSetPath');
  @RawOPCDLLEditorItemGetBranchItems         := GetProcAddress(OPCManagerDLLHandle, 'EditorItemGetBranchItems');
  @RawOPCDLLEditorItemGetQualifiedName       := GetProcAddress(OPCManagerDLLHandle, 'EditorItemGetQualifiedName');

  @RawOPCDLLGroupAdd                         := GetProcAddress(OPCManagerDLLHandle, 'GroupAdd');
  @RawOPCDLLGroupDelete                      := GetProcAddress(OPCManagerDLLHandle, 'GroupDelete');
  @RawOPCDLLGroupResume                      := GetProcAddress(OPCManagerDLLHandle, 'GroupResume');
  @RawOPCDLLGroupSuspend                     := GetProcAddress(OPCManagerDLLHandle, 'GroupSuspend');
  @RawOPCDLLGroupGetCount                    := GetProcAddress(OPCManagerDLLHandle, 'GroupGetCount');
  @RawOPCDLLGroupGetHandleByName             := GetProcAddress(OPCManagerDLLHandle, 'GroupGetHandleByName');
  @RawOPCDLLGroupGetName                     := GetProcAddress(OPCManagerDLLHandle, 'GroupGetName');
  @RawOPCDLLGroupGetComputerName             := GetProcAddress(OPCManagerDLLHandle, 'GroupGetComputerName');
  @RawOPCDLLGroupGetOPCServerName            := GetProcAddress(OPCManagerDLLHandle, 'GroupGetOPCServerName');
  @RawOPCDLLGroupGetUpdateRate               := GetProcAddress(OPCManagerDLLHandle, 'GroupGetUpdateRate');
  @RawOPCDLLGroupSetUpdateRate               := GetProcAddress(OPCManagerDLLHandle, 'GroupSetUpdateRate');
  @RawOPCDLLGroupGetHandle                   := GetProcAddress(OPCManagerDLLHandle, 'GroupGetHandle');

  @RawOPCDLLCloseAllServerConnections        := GetProcAddress(OPCManagerDLLHandle, 'CloseAllServerConnections');
  @RawOPCDLLServerConnectionGetCount         := GetProcAddress(OPCManagerDLLHandle, 'ServerConnectionGetCount');
  @RawOPCDLLServerConnectionGetName          := GetProcAddress(OPCManagerDLLHandle, 'ServerConnectionGetName');
  @RawOPCDLLServerConnectionGetGroupCount    := GetProcAddress(OPCManagerDLLHandle, 'ServerConnectionGetGroupCount');
  @RawOPCDLLServerConnectionGetGroupName     := GetProcAddress(OPCManagerDLLHandle, 'ServerConnectionGetGroupName');
  @RawOPCDLLServerConnectionReconnect        := GetProcAddress(OPCManagerDLLHandle, 'ServerConnectionReconnect');
  @RawOPCDLLServerConnectionDisconnect       := GetProcAddress(OPCManagerDLLHandle, 'ServerConnectionDisconnect');

  @RawOPCDLLManagerCreated                   := GetProcAddress(OPCManagerDLLHandle, 'ManagerCreated');
  @RawOPCDLLManagerAddItem                   := GetProcAddress(OPCManagerDLLHandle, 'ManagerAddItem');
  @RawOPCDLLManagerDestroyed                 := GetProcAddress(OPCManagerDLLHandle, 'ManagerDestroyed');

  @RawOPCDLLGetIsEvaluation                  := GetProcAddress(OPCManagerDLLHandle, 'GetIsEvaluation');
  @RawOPCDLLGetLastCallErrorString           := GetProcAddress(OPCManagerDLLHandle, 'GetLastCallErrorString');
end;
//******************************************************************************
procedure DoDLLCheck;
begin
  if not OPCDLLLoaded then raise Exception.Create('Iocomp OPC DLL Not Found.');
end;
//******************************************************************************
procedure CheckError;
var
  ErrorString : String;
begin
  ErrorString := OPCDLLLastCallErrorString;
  if ErrorString <> '' then raise Exception.Create(ErrorString);
end;
//******************************************************************************
procedure RaiseFunctionNotFoundException(FunctionName: String);
begin
  raise Exception.Create('Function "' + FunctionName + '" not found in "' + OPCMANAGERDLLSTRINGRESOURCE + '".');
end;
//******************************************************************************
function OPCDLLSignalAdd(ComputerName, OPCServerName, ItemName, GroupName: String; UpdateRate: Integer; Suspend: Boolean; DataType: TVarType; UpdateInterface: IOPCSignalUpdate): Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalAdd) then RaiseFunctionNotFoundException('SignalAdd');
  RawOPCDLLSignalAdd(Result, ComputerName, OPCServerName, ItemName, GroupName, UpdateRate, Suspend, DataType, UpdateInterface);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLSignalRemove(SignalHandle: Integer);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalRemove) then RaiseFunctionNotFoundException('SignalRemove');
  RawOPCDLLSignalRemove(SignalHandle);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLSignalSuspend(SignalHandle: Integer);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalSuspend) then RaiseFunctionNotFoundException('SignalSuspend');
  RawOPCDLLSignalSuspend(SignalHandle);
  CheckError;
end;
//******************************************************************************
function OPCDLLSignalGetUpdateSuspended(SignalHandle: Integer): Boolean;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalGetUpdateSuspended) then RaiseFunctionNotFoundException('SignalGetUpdateSuspended');
  RawOPCDLLSignalGetUpdateSuspended(SignalHandle, Result);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLSignalResume(SignalHandle: Integer);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalResume) then RaiseFunctionNotFoundException('SignalResume');
  RawOPCDLLSignalResume(SignalHandle);
  CheckError;
end;
//******************************************************************************
function OPCDLLSignalGetActive(SignalHandle: Integer): Boolean;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalGetActive) then RaiseFunctionNotFoundException('SignalGetActive');
  RawOPCDLLSignalGetActive(SignalHandle, Result);
  CheckError;
end;
//******************************************************************************
function OPCDLLSignalGetGroupHandle(SignalHandle: Integer): Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalGetGroupHandle) then RaiseFunctionNotFoundException('SignalGetGroupHandle');
  RawOPCDLLSignalGetGroupHandle(SignalHandle, Result);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLSignalSendData(SignalHandle: Integer; Data: OLEVariant);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalSendData) then RaiseFunctionNotFoundException('SignalSendData');
  RawOPCDLLSignalSendData(SignalHandle, Data);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLSignalGetDataNow(SignalHandle: Integer);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalGetDataNow) then RaiseFunctionNotFoundException('SignalGetDataNow');
  RawOPCDLLSignalGetDataNow(SignalHandle);
  CheckError;
end;
//******************************************************************************
function OPCDLLSignalGetData(SignalHandle: Integer): OLEVariant;
var
  AResult : OLEVariant;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalGetData) then RaiseFunctionNotFoundException('SignalGetData');
  RawOPCDLLSignalGetData(SignalHandle, AResult);
  CheckError;
  Result := AResult;
end;
//******************************************************************************
function OPCDLLSignalGetTimeStamp(SignalHandle: Integer): TDateTime;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalGetTimeStamp) then RaiseFunctionNotFoundException('SignalGetTimeStamp');
  RawOPCDLLSignalGetTimeStamp(SignalHandle, Result);
  CheckError;
end;
//******************************************************************************
function OPCDLLSignalGetQuality(SignalHandle: Integer): Word;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLSignalGetQuality) then RaiseFunctionNotFoundException('SignalGetQuality');
  RawOPCDLLSignalGetQuality(SignalHandle, Result);
  CheckError;
end;
//******************************************************************************
function OPCDLLEditorSessionStart: Integer;
begin
  Result := -1;
  if not OPCDLLLoaded                           then Exit;
  if not Assigned(@RawOPCDLLEditorSessionStart) then Exit;
  Result := RawOPCDLLEditorSessionStart;
  CheckError;
end;
//******************************************************************************
procedure OPCDLLEditorSessionStop(SessionHandle: Integer);
begin
  if not OPCDLLLoaded                          then Exit;
  if not Assigned(@RawOPCDLLEditorSessionStop) then Exit;
  RawOPCDLLEditorSessionStop(SessionHandle);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLEditorComputerBranchOpen(SessionHandle: Integer; NetResource: TiNetData);
begin
  if not OPCDLLLoaded                                 then Exit;
  if not Assigned(@RawOPCDLLEditorComputerBranchOpen) then Exit;
  RawOPCDLLEditorComputerBranchOpen(SessionHandle, NetResource);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLEditorComputerBranchClose(SessionHandle: Integer);
begin
  if not OPCDLLLoaded                                  then Exit;
  if not Assigned(@RawOPCDLLEditorComputerBranchClose) then Exit;
  RawOPCDLLEditorComputerBranchClose(SessionHandle);
  CheckError;
end;
//******************************************************************************
function OPCDLLEditorComputerBranchGetItemCount(SessionHandle: Integer): Integer;
begin
  Result := 0;
  if not OPCDLLLoaded                                         then Exit;
  if not Assigned(@RawOPCDLLEditorComputerBranchGetItemCount) then Exit;
  Result := RawOPCDLLEditorComputerBranchGetItemCount(SessionHandle);
  CheckError;
end;
//******************************************************************************
function OPCDLLEditorComputerBranchGetItemData (SessionHandle: Integer; Index: Integer): TiNetData;
begin
  if not OPCDLLLoaded                                        then Exit;
  if not Assigned(@RawOPCDLLEditorComputerBranchGetItemData) then Exit;
  Result := RawOPCDLLEditorComputerBranchGetItemData(SessionHandle, Index);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLEditorServerSetup(SessionHandle: Integer; MachineName: String);
begin
  if not OPCDLLLoaded                          then Exit;
  if not Assigned(@RawOPCDLLEditorServerSetup) then Exit;
  RawOPCDLLEditorServerSetup(SessionHandle, MachineName);
  CheckError;
end;
//******************************************************************************
function OPCDLLEditorServerGetCount(SessionHandle: Integer): Integer;
begin
  Result := 0;
  if not OPCDLLLoaded                             then Exit;
  if not Assigned(@RawOPCDLLEditorServerGetCount) then Exit;
  Result := RawOPCDLLEditorServerGetCount(SessionHandle);
  CheckError;
end;
//******************************************************************************
function OPCDLLEditorServerGetData(SessionHandle: Integer; Index: Integer): TiServerData;
begin
  if not OPCDLLLoaded                            then Exit;
  if not Assigned(@RawOPCDLLEditorServerGetData) then Exit;
  Result := RawOPCDLLEditorServerGetData(SessionHandle, Index);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLEditorItemSetup(SessionHandle: Integer; MachineName, OPCServerName: String);
begin
  if not OPCDLLLoaded                        then Exit;
  if not Assigned(@RawOPCDLLEditorItemSetup) then Exit;
  RawOPCDLLEditorItemSetup(SessionHandle, MachineName, OPCServerName);
  CheckError;
end;
//******************************************************************************
function OPCDLLEditorItemGetBrowseType(SessionHandle: Integer): TiNameSpaceType;
begin
  Result := instFlat;
  if not OPCDLLLoaded                                then Exit;
  if not Assigned(@RawOPCDLLEditorItemGetBrowseType) then Exit;
  Result := RawOPCDLLEditorItemGetBrowseType(SessionHandle);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLEditorItemSetPath(SessionHandle: Integer; Path: String);
begin
  if not OPCDLLLoaded                          then Exit;
  if not Assigned(@RawOPCDLLEditorItemSetPath) then Exit;
  RawOPCDLLEditorItemSetPath(SessionHandle, Path);
  CheckError;
end;
//******************************************************************************
function OPCDLLEditorItemGetBranchItems(SessionHandle: Integer; iBrowseType: TiBrowseType): String;
begin
  Result := '';
  if not OPCDLLLoaded                                 then Exit;
  if not Assigned(@RawOPCDLLEditorItemGetBranchItems) then Exit;
  Result := RawOPCDLLEditorItemGetBranchItems(SessionHandle, iBrowseType);
  CheckError;
end;
//******************************************************************************
function OPCDLLEditorItemGetQualifiedName(SessionHandle: Integer; Path, ItemName: String): String;
begin
  Result := '';
  if not OPCDLLLoaded                                   then Exit;
  if not Assigned(@RawOPCDLLEditorItemGetQualifiedName) then Exit;
  Result := RawOPCDLLEditorItemGetQualifiedName(SessionHandle, Path, ItemName);
  CheckError;
end;
//******************************************************************************
function OPCDLLGroupAdd(Name, ComputerName, OPCServerName: String; UpdateRate: Integer; UpdateInterface: IOPCGroupUpdate): Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupAdd) then RaiseFunctionNotFoundException('GroupAdd');
  RawOPCDLLGroupAdd(Result, Name, ComputerName, OPCServerName, UpdateRate, UpdateInterface);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLGroupDelete(GroupHandle: Integer);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupDelete) then RaiseFunctionNotFoundException('GroupDelete');
  RawOPCDLLGroupDelete(GroupHandle);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLGroupResume(GroupHandle: Integer);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupResume) then RaiseFunctionNotFoundException('GroupResume');
  RawOPCDLLGroupResume(GroupHandle);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLGroupSuspend(GroupHandle: Integer);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupSuspend) then RaiseFunctionNotFoundException('GroupSuspend');
  RawOPCDLLGroupSuspend(GroupHandle);
  CheckError;
end;
//******************************************************************************
function OPCDLLGroupGetHandleByName(Name: String): Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupGetHandleByName) then RaiseFunctionNotFoundException('GroupGetHandleByName');
  RawOPCDLLGroupGetHandleByName(Name, Result);
  CheckError;
end;
//******************************************************************************
function OPCDLLGroupGetCount: Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupGetCount) then RaiseFunctionNotFoundException('GroupGetCount');
  RawOPCDLLGroupGetCount(Result);
  CheckError;
end;
//******************************************************************************
function OPCDLLGroupGetHandle(Index: Integer): Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupGetHandle) then RaiseFunctionNotFoundException('GroupGetHandle');
  RawOPCDLLGroupGetHandle(Index, Result);
  CheckError;
end;
//******************************************************************************
function OPCDLLGroupGetName(GroupHandle: Integer): String;
var
  AValue : WideString;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupGetName) then RaiseFunctionNotFoundException('GroupGetName');
  RawOPCDLLGroupGetName(GroupHandle, AValue);
  Result := AValue;
  CheckError;
end;
//******************************************************************************
function OPCDLLGroupGetComputerName(GroupHandle: Integer): String;
var
  AValue : WideString;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupGetComputerName) then RaiseFunctionNotFoundException('GroupGetComputerName');
  RawOPCDLLGroupGetComputerName(GroupHandle, AValue);
  Result := AValue;
  CheckError;
end;
//******************************************************************************
function OPCDLLGroupGetOPCServerName(GroupHandle: Integer): String;
var
  AValue : WideString;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupGetOPCServerName) then RaiseFunctionNotFoundException('GroupGetOPCServerName');
  RawOPCDLLGroupGetOPCServerName(GroupHandle, AValue);
  Result := AValue;
  CheckError;
end;
//******************************************************************************
function OPCDLLGroupGetUpdateRate(GroupHandle: Integer): Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupGetUpdateRate) then RaiseFunctionNotFoundException('GroupGetUpdateRate');
  RawOPCDLLGroupGetUpdateRate(GroupHandle, Result);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLGroupSetUpdateRate(GroupHandle: Integer; Value: Integer);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLGroupSetUpdateRate) then RaiseFunctionNotFoundException('GroupSetUpdateRate');
  RawOPCDLLGroupSetUpdateRate(GroupHandle, vALUE);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLCloseAllServerConnections;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLCloseAllServerConnections) then RaiseFunctionNotFoundException('CloseAllServerConnections');
  RawOPCDLLCloseAllServerConnections;
  CheckError;
end;
//******************************************************************************
function OPCDLLServerConnectionGetCount: Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLServerConnectionGetCount) then RaiseFunctionNotFoundException('ServerConnectionGetCount');
  Result := RawOPCDLLServerConnectionGetCount;
  CheckError;
end;
//******************************************************************************
function OPCDLLServerConnectionGetName(Index: Integer): String;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLServerConnectionGetName) then RaiseFunctionNotFoundException('ServerConnectionGetName');
  Result := RawOPCDLLServerConnectionGetName(Index);
  CheckError;
end;
//******************************************************************************
function OPCDLLServerConnectionGetGroupCount: Integer;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLServerConnectionGetGroupCount) then RaiseFunctionNotFoundException('ServerConnectionGetGroupCount');
  Result := RawOPCDLLServerConnectionGetGroupCount;
  CheckError;
end;
//******************************************************************************
function OPCDLLServerConnectionGetGroupName(Index: Integer): String;
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLServerConnectionGetGroupName) then RaiseFunctionNotFoundException('ServerConnectionGetGroupName');
  Result := RawOPCDLLServerConnectionGetGroupName(Index);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLServerConnectionReconnect(Name: String);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLServerConnectionReconnect) then RaiseFunctionNotFoundException('ServerConnectionReconnect');
  RawOPCDLLServerConnectionReconnect(Name);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLServerConnectionDisconnect(Name: String);
begin
  DoDLLCheck;
  if not Assigned(@RawOPCDLLServerConnectionDisconnect) then RaiseFunctionNotFoundException('ServerConnectionDisconnect');
  RawOPCDLLServerConnectionDisconnect(Name);
  CheckError;
end;
//******************************************************************************
function OPCDLLManagerCreated: Boolean;
begin
  Result := False;
  if not OPCDLLLoaded                       then Exit;
  if not Assigned(@RawOPCDLLManagerCreated) then Exit;
  Result := RawOPCDLLManagerCreated;
  CheckError;
end;
//******************************************************************************
procedure OPCDLLManagerAddItem(GroupName: String; UpdateRate: Integer);
begin
  if not OPCDLLLoaded                       then Exit;
  if not Assigned(@RawOPCDLLManagerAddItem) then Exit;
  RawOPCDLLManagerAddItem(GroupName, UpdateRate);
  CheckError;
end;
//******************************************************************************
procedure OPCDLLManagerDestroyed;
begin
  if not OPCDLLLoaded                         then Exit;
  if not Assigned(@RawOPCDLLManagerDestroyed) then Exit;
  RawOPCDLLManagerDestroyed;
  CheckError;
end;
//******************************************************************************
function OPCDLLIsEvaluation: Boolean;
begin
  Result := False;
  if not OPCDLLLoaded                        then Exit;
  if not Assigned(@RawOPCDLLGetIsEvaluation) then Exit;
  RawOPCDLLGetIsEvaluation(Result);
end;
//******************************************************************************
function OPCDLLLastCallErrorString: String;
var
  AWideString : WideString;
begin
  Result := '';
  if not OPCDLLLoaded                               then Exit;
  if not Assigned(@RawOPCDLLGetLastCallErrorString) then Exit;
  RawOPCDLLGetLastCallErrorString(AWideString);

  Result := AWideString;
end;
//******************************************************************************
function  OPCDLLNotLoaded: Boolean;
begin
  Result := not OPCDLLLoaded;
end;
//******************************************************************************
initialization
  OPCManagerDLLHandle := LoadLibrary(OPCMANAGERDLLSTRINGRESOURCE);
  if OPCManagerDLLHandle <> 0 then
    begin
      OPCDLLLoaded := True;
      MapFunctionPointers;
    end
  else
    begin
      OPCDLLLoaded := False;
    end;
//******************************************************************************
finalization
  if OPCManagerDLLHandle <> 0 then FreeLibrary(OPCManagerDLLHandle);
//******************************************************************************
end.
