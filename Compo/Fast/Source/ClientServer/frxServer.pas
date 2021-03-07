
{******************************************}
{                                          }
{             FastReport v4.0              }
{            HTTP Report Server            }
{                                          }
{         Copyright (c) 1998-2009          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxServer;

{$I frx.inc}

{$IFDEF Delphi12}
{$WARNINGS OFF}
{$ENDIF}

interface

uses
  Forms, Windows, Classes, frxClass, ScktComp, Registry,
  WinSock, frxVariables, frxGZip, frxServerLog,
  frxServerSessionManager, frxServerStat, frxServerReports,
  frxServerVariables, frxServerSSI, frxServerUtils, frxNetUtils, frxMD5,
  frxServerCache, frxServerReportsList, frxUnicodeUtils, frxUsers

  , frxServerClient, SysUtils, frxServerConfig, frxServerTemplates, frxServerPrinter;

type
  TfrxHTTPServer = class;
  TfrxServerSession = class;
  TfrxServerData = class;
  TfrxServerGuard = class;
  TfrxServerGetReportEvent = procedure(const ReportName: String;
    Report: TfrxReport; User: String = '') of object;
  TfrxServerGetVariablesEvent = procedure(const ReportName: String;
    Variables: TfrxVariables; User: String = '') of object;
  TfrxServerAfterBuildReport = procedure(const ReportName: String;
    Variables: TfrxVariables; User: String = '') of object;

  PSecHandle = ^TSecHandle;
  TSecHandle = record
    dwLower: Cardinal;
    dwUpper: Cardinal;
  end;
  TCredHandle = TSecHandle;
  PCredHandle = ^TCredHandle;
  PCtxtHandle = ^TCtxtHandle;
  TCtxtHandle = TSecHandle;

  PSecBuffer = ^TSecBuffer;
  TSecBuffer = record
    cbBuffer: Cardinal;
    BufferType: Cardinal;
    pvBuffer: Pointer;
  end;

  PSecBufferDesc = ^TSecBufferDesc;
  TSecBufferDesc = record
    ulVersion: Cardinal;
    cBuffers: Cardinal;
    pBuffers: PSecBuffer;
  end;

  PTimeStamp = ^TTimeStamp;
  TTimeStamp = Currency;

  PSecPkgInfo = ^TSecPkgInfo;
  TSecPkgInfo = record
    fCapabilities: Cardinal;
    wVersion: Word;
    wRPCID: Word;
    cbMaxToken: Cardinal;
    Name: PChar;
    Comment: PChar;
  end;

  TfrxReportServer = class(TComponent)
  private
    FActive: Boolean;
    FAllow: TStrings;
    FConfig: TfrxServerConfig; // obsolete
    FDeny: TStrings;
    FGetReport: TfrxServerGetReportEvent;
    FPDFPrint: Boolean;
    FTotals: TStrings;
    FVariables: TfrxServerVariables;
    FWebServer: TfrxHTTPServer;
    FGetVariables: TfrxServerGetVariablesEvent;
    FBuildReport: TfrxServerAfterBuildReport;
    FReportList: TfrxServerReportsList;

    FSocketOpen: Boolean;
    FConfigFileName: String;
    FGuard: TfrxServerGuard;
    FPrint: Boolean;
    function GetTotals: TStrings;
    procedure SetActive(const Value: Boolean);
    procedure SetConfig(const Value: TfrxServerConfig);
    procedure StatToVar;
//    procedure IdleEventHandler(Sender: TObject; var Done: Boolean);
    procedure Initialize;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateWithRoot(const Folder: String; const Socket: Boolean);
    destructor Destroy; override;
    procedure Open;
    procedure Close;
    procedure Get(Data: TfrxServerData);
    procedure LoadConfigs;
    property Totals: TStrings read GetTotals;
    property Variables: TfrxServerVariables read FVariables;
    property ReportsList: TfrxServerReportsList read FReportList;
  published
    property Configuration: TfrxServerConfig read FConfig write SetConfig; // obsolete
    property Active: Boolean read FActive write SetActive;
    property AllowIP: TStrings read FAllow write FAllow;
    property DenyIP: TStrings read FDeny write FDeny;
    property PrintPDF: Boolean read FPDFPrint write FPDFPrint;
    property Print: Boolean read FPrint write FPrint;
    property OnGetReport: TfrxServerGetReportEvent read FGetReport
      write FGetReport;
    property OnGetVariables: TfrxServerGetVariablesEvent read FGetVariables
      write FGetVariables;
    property OnAfterBuildReport: TfrxServerAfterBuildReport read FBuildReport
      write FBuildReport;
    property SocketOpen: Boolean read FSocketOpen write FSocketOpen;
    property WebServer: TfrxHTTPServer read FWebServer;
  end;

  TfrxHTTPServer = class(TServerSocket)
  private
    FBasePath: String;
    FGzip: Boolean;
    FMainDocument: String;
    FNoCacheHeader: Boolean;
    FParentReportServer: TfrxReportServer;
    FReportPath: String;
    FSocketTimeOut: Integer;
    procedure ClientAccept(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientError(Sender: TObject; Socket: TCustomWinSocket;
         ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GetThread(Sender: TObject; ClientSocket: TServerClientWinSocket;
         var SocketThread: TServerClientThread);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BasePath: String read FBasePath write FBasePath;
    property Gzip: Boolean read FGzip write FGzip;
    property MainDocument: String read FMainDocument write FMainDocument;
    property NoCacheHeader: Boolean read FNoCacheHeader write FNoCacheHeader;
    property ParentReportServer: TfrxReportServer read FParentReportServer
      write FParentReportServer;
    property ReportPath: String read FReportPath write FReportPath;
    property SocketTimeOut: Integer read FSocketTimeOut write FSocketTimeOut;
  end;

  TfrxServerSession = class(TServerClientThread)
  private
    FAuthNeeded: Boolean;
    FDialog: Boolean;
    FDialogSessionId: AnsiString;
    FErrorCode: Integer;
    FErrorText: AnsiString;
    FFormat: TfrxServerFormat;
    FGzip: Boolean;
    FHeader: AnsiString;
    FHost: AnsiString;
    FHTTPVersion: AnsiString;
    FIsReport: Boolean;
    FKeepAlive: boolean;
    FMethod: AnsiString;
    FMIMEType: AnsiString;
    FMultipage: Boolean;
    FName: AnsiString;
    FNoCacheHeader: Boolean;
    FPageNavigator: Boolean;
    FPageRange: String;
    FParentHTTPServer: TfrxHTTPServer;
    FParentReportServer: TfrxReportServer;
    FRedirect: Boolean;
    FReferer: AnsiString;
    FRemoteIP: String;
    FReplyBody: TStringList;
    FReplyHeader: TStringList;
    FRepSession: TfrxReportSession;
    FResultPage: String;
    FServerReplyData: TStringList;
    FSessionId: AnsiString;
    FSessionItem: TfrxSessionItem;
    FSize: integer;
    FUserAgent: AnsiString;
    FVariables: TfrxVariables;
    FStream: TMemoryStream;
    FFileDate: TDateTime;
    FCacheId: String;
    FPrn: String;
    FLogin: String;
    FCookie: AnsiString;
    FPassword: String;
    FReportMessage: String;
    FReturnData: AnsiString;
    FInParams: TStringList;
    FOutParams: TStringList;
    FData: TfrxServerData;
    FActive: Boolean;
    FAuthInProgress: Boolean;
    FAuthResponse: AnsiString;
    FAuthFinished: Boolean;
    FAuthNewConv: Boolean;
    FMaxTokenSize: integer;
    FCredHandle: TSecHandle;
    FExpire: TTimeStamp;
    FToken: cardinal;
    FContextHandle: TSecHandle;
    FAuthType: String;
    function InitAuth(const SecPackageName: String): boolean;
    function ProcessAuthRequest(AuthRequest: AnsiString; NewConversation: boolean; var AuthResponse: AnsiString;
      var ContextHandle: TSecHandle; var AuthFinished: boolean): boolean;
    procedure FinalAuth;
    function GetCurrentUserToken: cardinal;
    function CheckBadPath: Boolean;
    function CheckDeflate(FileName: String): Boolean;
    function CheckSSI(FileName: String): Boolean;
    function ParseHeaderField(Field: AnsiString): AnsiString;
    function ParseParam(S: String): String;
    procedure CheckAuth;
    procedure CloseSession;
    procedure CreateReplyHTTPData;
    procedure ErrorLog;
//    procedure GetFileMIMEType;
    procedure MakeServerReply;
    procedure ParseHTTPHeader;
    procedure UpdateSessionFName;
    procedure WriteLogs;
    procedure DoGetVariables;
    procedure AddOutData(const Name: String; const Value: String);
  public
    constructor Create(CreateSuspended: Boolean;
      ASocket: TServerClientWinSocket);
    destructor Destroy; override;
    procedure ClientExecute; override;
    procedure PrepareReportQuery;

    property NoCacheHeader: Boolean read FNoCacheHeader write FNoCacheHeader;
    property ParentHTTPServer: TfrxHTTPServer read FParentHTTPServer
      write FParentHTTPServer;
    property ParentReportServer: TfrxReportServer read FParentReportServer
      write FParentReportServer;
    property SessionId: AnsiString read FSessionId write FSessionId;
    property SessionItem: TfrxSessionItem read FSessionItem write FSessionItem;
    property Login: String read FLogin;
    property Password: String read FPassword;
    property Data: TfrxServerData read FData write FData;
    property Active: Boolean read FActive write FActive;
  end;

  TfrxServerData = class(TObject)
  private
    FErrorCode: Integer;
    FInParams: TStringList;
    FOutParams: TStringList;
    FStream: TMemoryStream;
    FFileName: String;
    FHeader: String;
    FRepHeader: String;
    FHTTPVer: String;
    FLastMod: TDateTime;
    FExpires: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TfrxServerData);

    property InParams: TStringList read FInParams;
    property OutParams: TStringList read FOutParams;
    property ErrorCode: Integer read FErrorCode write FErrorCode;
    property Stream: TMemoryStream read FStream;
    property FileName: String read FFileName write FFileName;
    property Header: String read FHeader write FHeader;
    property RepHeader: String read FRepHeader write FRepHeader;
    property HTTPVer: String read FHTTPVer write FHTTPVer;
    property Expires: TDateTime read FExpires write FExpires;
    property LastMod: TDateTime read FLastMod write FLastMod;
  end;

  TfrxServerGuard = class(TThread)
  private
    FTimeOut: Integer;
    FServer: TfrxReportServer;
    FListTimeOut: Integer;
    procedure DoLoadConf;
  protected
    procedure Execute; override;
  public
    constructor Create(Server: TfrxReportServer);
    destructor Destroy; override;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property ListTimeOut: Integer read FListTimeOut write FListTimeOut;
  end;

const
  MAX_IE_GZIP = 4096;
  SERVER_NAME = 'FastReport Server'{$IFDEF FR_FIB} + ' Firebird edition'{$ENDIF};
  SERVER_VERSION = {$I frxServerVersion.inc};
  SERVER_DATA = '';
  SID_SIGN = 'sid_f';



implementation

uses frxUtils, frxFileUtils, SyncObjs, ComObj;

const
  SERVER_COPY = '&copy; Copyright 1998-2009 by Fast Reports Inc.';
  METHOD_GET = 'GET';
  METHOD_POST = 'POST';
  HTML = 'text/html';
  ERR_UNKNOWN_METHOD = '1';
  ERR_OK = '0';
  SECPKG_CRED_INBOUND  = $00000001;
  SECBUFFER_VERSION = 0;
  SECBUFFER_TOKEN = 2;
  SECURITY_NATIVE_DREP = $00000010;
  SEC_I_COMPLETE_NEEDED = HRESULT($00090313);
  SEC_I_COMPLETE_AND_CONTINUE = HRESULT($00090314);
  SEC_I_CONTINUE_NEEDED = HRESULT($00090312);
  NameSamCompatible = 2;
  secur32 = 'secur32.dll';

type
  TSecGetKeyFn = procedure (
    Arg: Pointer;
    Principal: Pointer;
    KeyVer: Cardinal;
    var Key: Pointer;
    var Status: Cardinal); stdcall;

function AcceptSecurityContext(phCredential: PCredHandle; phContext: PCtxtHandle;
  pInput: PSecBufferDesc; fContextReq, TargetDataRep: Cardinal;
  phNewContext: PCtxtHandle; pOutput: PSecBufferDesc; var pfContextAttr: Cardinal;
  ptsExpiry: PTimeStamp): Cardinal; stdcall; forward;

function CompleteAuthToken(phContext: PCtxtHandle; pToken: PSecBufferDesc): Cardinal; stdcall; forward;

function ImpersonateSecurityContext(phContext: PCtxtHandle): Cardinal; stdcall; forward;

function RevertSecurityContext(phContext: PCtxtHandle): Cardinal; stdcall; forward;

function QuerySecurityPackageInfo(pszPackageName: PChar;
  var ppPackageInfo: PSecPkgInfo): Cardinal; stdcall; forward;

function AcquireCredentialsHandle(pszPrincipal, pszPackage: PChar;
  fCredentialUse: Cardinal; pvLogonId, pAuthData: Pointer;
  pGetKeyFn: TSecGetKeyFn; pvGetKeyArgument: Pointer; phCredential: PCredHandle;
  var ptsExpiry: TTimeStamp): Cardinal; stdcall; forward;

function FreeCredentialsHandle(phCredential: PCredHandle): Cardinal; stdcall; forward;

function FreeContextBuffer(pvContextBuffer: Pointer): Cardinal; stdcall; forward;

function GetUserNameEx(NameFormat: cardinal; lpNameBuffer: PChar;
  var nSize: cardinal): ByteBool; stdcall; forward;


var
  ServCS: TCriticalSection;
  _AcceptSecurityContext: Pointer;
  _CompleteAuthToken: Pointer;
  _ImpersonateSecurityContext: Pointer;
  _RevertSecurityContext: Pointer;
  _QuerySecurityPackageInfo: Pointer;
  _AcquireCredentialsHandle: Pointer;
  _FreeCredentialsHandle: Pointer;
  _FreeContextBuffer: Pointer;
  _GetUserNameEx: Pointer;

procedure GetProcedureAddress(var P: Pointer; const ModuleName, ProcName: string);
var ModuleHandle: HMODULE;
begin
  if not Assigned(P) then
  begin
    ModuleHandle := GetModuleHandle(PChar(ModuleName));
    if ModuleHandle = 0 then
    begin
      ModuleHandle := LoadLibrary(PChar(ModuleName));
      if ModuleHandle = 0 then
        raise Exception.Create('Library not found: ' + ModuleName);
    end;
    P := GetProcAddress(ModuleHandle, PChar(ProcName));
    if not Assigned(P) then
      raise Exception.Create('Function not found: ' + ModuleName + '.' + ProcName);
  end;
end;

{$IFNDEF Delphi12}
{$WARNINGS OFF}
{$ENDIF}
function FreeContextBuffer;
begin
  GetProcedureAddress(_FreeContextBuffer, secur32, 'FreeContextBuffer');
  asm
    mov esp, ebp
    pop ebp
    jmp [_FreeContextBuffer]
  end;
end;

function FreeCredentialsHandle;
begin
  GetProcedureAddress(_FreeCredentialsHandle, secur32, 'FreeCredentialsHandle');
  asm
    mov esp, ebp
    pop ebp
    jmp [_FreeCredentialsHandle]
  end;
end;

function AcquireCredentialsHandle;
begin
  GetProcedureAddress(_AcquireCredentialsHandle, secur32, 'AcquireCredentialsHandleA');
  asm
    mov esp, ebp
    pop ebp
    jmp [_AcquireCredentialsHandle]
  end;
end;

function AcceptSecurityContext;
begin
  GetProcedureAddress(_AcceptSecurityContext, secur32, 'AcceptSecurityContext');
  asm
    mov esp, ebp
    pop ebp
    jmp [_AcceptSecurityContext]
  end;
end;

function CompleteAuthToken;
begin
  GetProcedureAddress(_CompleteAuthToken, secur32, 'CompleteAuthToken');
  asm
    mov esp, ebp
    pop ebp
    jmp [_CompleteAuthToken]
  end;
end;

function ImpersonateSecurityContext;
begin
  GetProcedureAddress(_ImpersonateSecurityContext, secur32, 'ImpersonateSecurityContext');
  asm
    mov esp, ebp
    pop ebp
    jmp [_ImpersonateSecurityContext]
  end;
end;

function RevertSecurityContext;
begin
  GetProcedureAddress(_RevertSecurityContext, secur32, 'RevertSecurityContext');
  asm
    mov esp, ebp
    pop ebp
    jmp [_RevertSecurityContext]
  end;
end;

function QuerySecurityPackageInfo;
begin
  GetProcedureAddress(_QuerySecurityPackageInfo, secur32, 'QuerySecurityPackageInfoA');
  asm
    mov esp, ebp
    pop ebp
    jmp [_QuerySecurityPackageInfo]
  end;
end;

function GetUserNameEx;
begin
  GetProcedureAddress(_GetUserNameEx, secur32, 'GetUserNameExA');
  asm
    mov esp, ebp
    pop ebp
    jmp [_GetUserNameEx]
  end;
end;
{$IFNDEF Delphi12}
{$WARNINGS ON}
{$ENDIF}



{ TfrxReportServer }

procedure TfrxReportServer.LoadConfigs;
begin
  ServerConfig.LoadFromFile(FConfigFileName);
  ServerUsers.LoadFromFile(frxGetAbsPathDir(ServerConfig.GetValue('server.security.usersfile'), ServerConfig.ConfigFolder));
end;

procedure TfrxReportServer.Initialize;
var
  s: String;
begin
  LogWriter := TfrxServerLog.Create;
  FConfig := TfrxServerConfig.Create; // obsolete
  FConfigFileName :=  ServerConfig.ConfigFolder  + 'config.xml';

  LoadConfigs;

  LogWriter.MaxLogSize := StrToInt(ServerConfig.GetValue('server.logs.rotatesize'));
  LogWriter.MaxLogFiles := StrToInt(ServerConfig.GetValue('server.logs.rotatefiles'));
  LogWriter.LogDir := frxGetAbsPathDir(ServerConfig.GetValue('server.logs.path'), ServerConfig.ConfigFolder);
  LogWriter.AddLevel(ServerConfig.GetValue('server.logs.errorlog'));
  LogWriter.AddLevel(ServerConfig.GetValue('server.logs.accesslog'));
  LogWriter.AddLevel(ServerConfig.GetValue('server.logs.refererlog'));
  LogWriter.AddLevel(ServerConfig.GetValue('server.logs.agentlog'));
  LogWriter.AddLevel(ServerConfig.GetValue('server.logs.serverlog'));



  FAllow := TStringList.Create;
  FDeny := TStringList.Create;

  s := frxGetAbsPathDir(ServerConfig.GetValue('server.security.allowfile'), ServerConfig.ConfigFolder);
  if FileExists(s) then
    FAllow.LoadFromFile(s{$IFDEF Delphi12},TEncoding.ASCII{$ENDIF});
  s := frxGetAbsPathDir(ServerConfig.GetValue('server.security.denyfile'), ServerConfig.ConfigFolder);
  if FileExists(s) then
    FDeny.LoadFromFile(s{$IFDEF Delphi12},TEncoding.ASCII{$ENDIF});

  FTotals := TStringList.Create;
  LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'Started');
  LogWriter.Write(SERVER_LEVEL, 'Logs path:' + #9 + frxGetAbsPathDir(ServerConfig.GetValue('server.logs.path'), ServerConfig.ConfigFolder));
  LogWriter.Write(SERVER_LEVEL, 'Reports path:' + #9 + frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder));
  LogWriter.Write(SERVER_LEVEL, 'Reports cache path:' + #9 + frxGetAbsPathDir(ServerConfig.GetValue('server.cache.path'), ServerConfig.ConfigFolder));
  LogWriter.Write(SERVER_LEVEL, 'Root path:' + #9 + frxGetAbsPathDir(ServerConfig.GetValue('server.http.rootpath'), ServerConfig.ConfigFolder));
  if FileExists(FConfigFileName) then
    LogWriter.Write(SERVER_LEVEL, 'Config file:' + #9 + FConfigFileName)
  else
    LogWriter.Write(SERVER_LEVEL, 'ERROR! Config file ' + FConfigFileName + ' not found!');

  SessionManager := TfrxSessionManager.Create;
  FWebServer := TfrxHTTPServer.Create(nil);
  FWebServer.ParentReportServer := Self;
  ReportCache := TfrxServerCache.Create;
  ServerStatistic := TfrxServerStatistic.Create;
  FVariables := TfrxServerVariables.Create;
  ServerPrinter := TfrxServerPrinter.Create;

  ServerUsers.LoadFromFile(ServerConfig.GetValue('server.security.usersfile'));


  FVariables.AddVariable('SERVER_NAME', ServerConfig.GetValue('server.name'));


  FVariables.AddVariable('SERVER_COPYRIGHT', SERVER_COPY);
  FVariables.AddVariable('SERVER_SOFTWARE', SERVER_VERSION);
  FVariables.AddVariable('SERVER_LAST_UPDATE', SERVER_DATA);

  FPDFPrint := False;
  FPrint := True;
  Active := False;

  ReportCache.Clear;
  FReportList := TfrxServerReportsList.Create;


  LogWriter.Active := ServerConfig.GetBool('server.logs.active');

  FGuard := TfrxServerGuard.Create(Self);
end;

constructor TfrxReportServer.CreateWithRoot(const Folder: String; const Socket: Boolean);
begin
  inherited Create(nil);
  FSocketOpen := Socket;
  ServerConfig.ConfigFolder := Folder;
  Initialize;
end;

constructor TfrxReportServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ServerConfig.ConfigFolder := GetAppPath;
  FSocketOpen := True;
  Initialize;
end;

destructor TfrxReportServer.Destroy;
begin

  FWebServer.Free;
  ReportCache.Terminate;
  PMessages;
  ReportCache.Free;
  ServerPrinter.Terminate;
  PMessages;
  ServerPrinter.Free;
  FGuard.Terminate;
  PMessages;
  FGuard.Free;
  FAllow.Free;
  FDeny.Free;
  LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'Stopped'#9 + #13#10 + Totals.Text);
  LogWriter.Flush;
  if Active then
    Active := False;
  ServerStatistic.Free;
  SessionManager.Free;
  FConfig.Free;
  FTotals.Free;
  FVariables.Free;
  LogWriter.Free;
  FReportList.Free;
  inherited;
end;

procedure TfrxReportServer.SetActive(const Value: Boolean);
begin
  if SocketOpen then
  begin
    try
      FWebServer.Active := Value;
    except
      on E:Exception do
      begin
        if Value then
          LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'Port open failed. ' + E.Message + #13#10)
        else
          LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'Port close failed. ' + E.Message + #13#10)
      end;
    end;
  end;
  if FWebServer.Active = Value then
    FActive := Value;
//  if Value and LogWriter.Suspended then
//    LogWriter.Resume;
end;

procedure TfrxReportServer.Open;
begin
  if ServerConfig.GetBool('server.security.reportslist') then
  begin
    FReportList.ReportsPath := frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder);
    FReportList.BuildListOfReports;
    FVariables.AddVariable('SERVER_REPORTS_LIST', FReportList.Lines.Text);
    FVariables.AddVariable('SERVER_REPORTS_HTML', FReportList.Html);
  end;
  Active := True;
end;

procedure TfrxReportServer.Close;
begin
  Active := False;
  ReportCache.Clear;
end;

procedure TfrxReportServer.SetConfig(const Value: TfrxServerConfig);
begin
  FConfig.Assign(Value);
end;

function TfrxReportServer.GetTotals: TStrings;
begin
  FTotals.Clear;
  FTotals.Add('Uptime: ' + ServerStatistic.FormatUpTime);
  FTotals.Add('Total sessions: ' + IntToStr(ServerStatistic.TotalSessionsCount));
  FTotals.Add('Total reports: ' + IntToStr(ServerStatistic.TotalReportsCount));
  FTotals.Add('Total cache hits: ' + IntToStr(ServerStatistic.TotalCacheHits));
  FTotals.Add('Total errors: ' + IntToStr(ServerStatistic.TotalErrors));
  FTotals.Add('Max sessions: ' + IntToStr(ServerStatistic.MaxSessionsCount));
  FTotals.Add('Max reports: ' + IntToStr(ServerStatistic.MaxReportsCount));
  Result := FTotals;
end;

procedure TfrxReportServer.StatToVar;
begin
  FVariables.AddVariable('SERVER_UPTIME', ServerStatistic.FormatUpTime);
  FVariables.AddVariable('SERVER_TOTAL_SESSIONS', IntToStr(ServerStatistic.TotalSessionsCount));
  FVariables.AddVariable('SERVER_TOTAL_REPORTS', IntToStr(ServerStatistic.TotalReportsCount));
  FVariables.AddVariable('SERVER_TOTAL_ERRORS', IntToStr(ServerStatistic.TotalErrors));
  FVariables.AddVariable('SERVER_TOTAL_CACHE', IntToStr(ServerStatistic.TotalCacheHits));
  FVariables.AddVariable('SERVER_MAX_SESSIONS', IntToStr(ServerStatistic.MaxSessionsCount));
  FVariables.AddVariable('SERVER_MAX_REPORTS', IntToStr(ServerStatistic.MaxReportsCount));
end;

procedure TfrxReportServer.Get(Data: TfrxServerData);
var
  Session: TfrxServerSession;
  Socket: TServerClientWinSocket;
begin
  Socket := TServerClientWinSocket.Create(-1, FWebServer.Socket);
  FWebServer.GetThread(nil, Socket, TServerClientThread(Session));
  Session.Data := Data;
  Session.Active := True;
  Session.Resume;
  while Session.Active do
    Sleep(10);
  SessionManager.CompleteSessionId(String(TCustomWinSocket(Socket).Data));
end;

{ TfrxHTTPServer }

constructor TfrxHTTPServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Active := False;
  ServerType := stThreadBlocking;
  Port := StrToInt(ServerConfig.GetValue('server.http.port'));
  FGzip := ServerConfig.GetBool('server.http.compression');
  FMainDocument := ServerConfig.GetValue('server.http.indexfile');
  FBasePath := frxGetAbsPathDir(ServerConfig.GetValue('server.http.rootpath'), ServerConfig.ConfigFolder);
  FSocketTimeOut := StrToInt(ServerConfig.GetValue('server.http.sockettimeout'));
  FNoCacheHeader := ServerConfig.GetBool('server.http.nocacheheader');
  OnClientError := ClientError;
  OnClientDisconnect := ClientDisconnect;
  OnAccept := ClientAccept;
  OnGetThread := GetThread;
  LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'HTTP server created');
end;

destructor TfrxHTTPServer.Destroy;
begin
  LogWriter.Write(SERVER_LEVEL, DateTimeToStr(Now) + #9'HTTP server closed');
  inherited;
end;

procedure TfrxHTTPServer.ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  if (ErrorCode <> 10053) and (ErrorCode <> 10054) then
  begin
    LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Socket.RemoteAddress + #9 + GetSocketErrorText(ErrorCode));
    LogWriter.ErrorReached;
  end;
  ErrorCode := 0;
  SessionManager.CompleteSessionId(String(TCustomWinSocket(Socket).Data));
  Socket.Close;
end;

procedure TfrxHTTPServer.ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  SessionManager.CompleteSessionId(String(TCustomWinSocket(Socket).Data));
end;

procedure TfrxHTTPServer.GetThread(Sender: TObject;
  ClientSocket: TServerClientWinSocket;  var SocketThread: TServerClientThread);
begin
  try
    SocketThread := TfrxServerSession.Create(True, ClientSocket);
    SocketThread.FreeOnTerminate := True;
    SocketThread.KeepInCache := False;
    TfrxServerSession(SocketThread).ParentReportServer := ParentReportServer;
    TfrxServerSession(SocketThread).ParentHTTPServer := Self;
    if ClientSocket <> nil then
      ClientSocket.Data := PChar(TfrxServerSession(SocketThread).SessionId);
    TfrxServerSession(SocketThread).SessionItem := SessionManager.AddSession(TfrxServerSession(SocketThread).SessionId, TCustomWinSocket(ClientSocket));
    if ParentReportServer.SocketOpen then
      SocketThread.Resume;
    FParentReportServer.StatToVar;
  except
    on E:Exception do
      LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + ClientSocket.RemoteAddress + ' client session creation error. ' + E.Message);
  end;
end;

procedure TfrxHTTPServer.ClientAccept(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  if ParentReportServer.DenyIP.IndexOf(Socket.RemoteAddress) <> -1 then
  begin
    LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Socket.RemoteAddress + ' denial of client connection');
    Socket.Close;
  end
  else if (ParentReportServer.AllowIP.Count > 0) and
     (ParentReportServer.AllowIP.IndexOf(Socket.RemoteAddress) = -1) then
  begin
    LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + Socket.RemoteAddress + ' client connection not allowed');
    Socket.Close;
  end;
end;

{ TfrxServerSession }

constructor TfrxServerSession.Create(CreateSuspended: Boolean; ASocket: TServerClientWinSocket);
begin
  inherited Create(CreateSuspended, ASocket);
  FSessionId := SID_SIGN + MakeSessionId;
  FIsReport := False;
  FSize := 0;
  FKeepAlive := False;
  FRemoteIP := ClientSocket.RemoteAddress;
  FServerReplyData := TStringList.Create;
  FReplyHeader := TStringList.Create;
  FReplyBody := TStringList.Create;
  FFormat := sfHTM;
  FPageRange := '';
  FGzip := False;
  FResultPage := '';
  FRedirect := False;
  FStream := TMemoryStream.Create;
  FInParams := TStringList.Create;
  FOutParams := TStringList.Create;
  FData := nil;
  FAuthInProgress := False;
  FAuthFinished := False;
  FAuthNewConv := True;
  FToken := 0;
end;

destructor TfrxServerSession.Destroy;
begin
  FInParams.Free;
  FOutParams.Free;
  FStream.Free;
  FServerReplyData.Free;
  FReplyHeader.Free;
  FReplyBody.Free;
  inherited;
end;

function TfrxServerSession.ParseHeaderField(Field: AnsiString): AnsiString;
var
  i: integer;
  s: Ansistring;
begin
  i := Pos(Field, FHeader);
  Result := '';
  if i > 0 then
  begin
    s := Copy(FHeader, i + Length(Field), Length(FHeader) - i + Length(Field));
    i := Pos(AnsiString(#13#10), s);
    if i > 0 then
      Result := Copy(s, 1, i - 1);
  end;
end;

procedure TfrxServerSession.ParseHTTPHeader;
var
  i, j: Integer;
  s: Ansistring;
  P, V: AnsiString;
  RepName: AnsiString;
begin
// DEBUG!!!
//  LogWriter.Write(ACCESS_LEVEL, FHeader);

  FMethod := ERR_UNKNOWN_METHOD;
  FErrorCode := 0;
  FReturnData := '';
  i := Pos(AnsiString(' '), FHeader);
  FMethod := Copy(FHeader, 1, i - 1);
  if (FMethod = METHOD_GET) or (FMethod = METHOD_POST) then
  begin
    i := Pos(AnsiString('/'), FHeader);
    if i > 0 then
    begin
      FName := Trim(String(Copy(FHeader, i + 1, Pos(AnsiString('HTTP'), FHeader) - i - 2)));
      FHTTPVersion := Copy(FHeader, Pos(AnsiString('HTTP/'), FHeader), 8);
      FHost := ParseHeaderField('Host: ');
      //FKeepAlive := ParseHeaderField('Connection: ') = 'keep-alive';
      FKeepAlive := False;
      FReferer := ParseHeaderField('Referer: ');
      FUserAgent := ParseHeaderField('User-Agent: ');
      if ServerConfig.GetBool('server.security.cgiauth') then
        FLogin := ParseHeaderField('UserName: ')
      else if ServerConfig.GetBool('server.security.remoteauth') then
        FLogin := ParseHeaderField('RemoteUserName: ')
      else if ServerConfig.GetBool('server.security.cookieauth') then
      begin
        FCookie := ParseHeaderField('Cookie: ');
        s := 'LI_USR';
        i := Pos(AnsiString(s), FCookie);
        j := i + Length(s) + 1;
        if (i > 0) then
        begin
          FLogin := '';
          while((FCookie[j] <> ';') and (j <= Length(FCookie))) do
          begin
            FLogin := FLogin + FCookie[j];
            Inc(j);
          end;
        end;
      end;
      s := ParseHeaderField('Accept-Encoding: ');
      if Length(s) > 0 then
        if (Pos('gzip', LowerCase(s)) > 0) and (FParentHTTPServer.Gzip) then
          FGzip := True;
      CheckAuth;
      WriteLogs;
      if not FAuthNeeded then
      begin
        FKeepAlive := False;
        if FMethod = METHOD_GET then
        begin
          i := Pos('?', FName);
          if i > 0 then
            FName := Copy(FName, i + 1, Length(FName) - i);
        end else
        if (FMethod = METHOD_POST) and (FStream.Size > 0) then
        begin
          SetLength(FName, FStream.Size);
          FStream.Position := 0;
          FStream.ReadBuffer(FName[1], FStream.Size);
        end;
        s := ParseParam('getvariable');
        if Length(s) = 0 then
        begin
          RepName := ParseParam('report');
          FDialogSessionId := ParseParam('sessionid');
          FCacheId := ParseParam('cacheid');
          FPrn := ParseParam('prn');
          if (FPrn = '1') and ServerConfig.GetBool('server.http.allowprint') then
          begin
          // print window
            FReturnData := ServerPrinter.GetHTML(FCacheId, RepName);
            FMIMEType := 'text/html';
          end
          else
          if (FPrn = '2') and ServerConfig.GetBool('server.http.allowprint') then
          begin
            ServerPrinter.AddPrintJob(FCacheId, Utf8Decode(ParseParam('printer')), Parseparam('pages'), StrToInt(ParseParam('copies')), ParseParam('collate') = '1', ParseParam('reverse') = '1');
            FName := FCacheId + '/index.html';
          end
          else
          if RepName <> '' then
          begin
            FIsReport := True;
              if Length(FDialogSessionId) > 0 then
                FDialog := True;
              s := ParseParam('format');
              if Length(s) > 0 then
              begin
                s := UpperCase(s);
                if s = 'PDF' then FFormat := sfPDF else
                if s = 'ODS' then FFormat := sfODS else
                if s = 'ODT' then FFormat := sfODT else
                if s = 'XML' then FFormat := sfXML else
                if s = 'XLS' then FFormat := sfXLS else
                if s = 'RTF' then FFormat := sfRTF else
                if s = 'TXT' then FFormat := sfTXT else
                if s = 'CSV' then FFormat := sfCSV else
                if s = 'JPG' then FFormat := sfJPG else
                if s = 'BMP' then FFormat := sfBMP else
                if s = 'GIF' then FFormat := sfGIF else
                if (s = 'TIFF') or (s = 'TIF') then FFormat := sfTIFF else
                if (s = 'FRP') or (s = 'FP3') then FFormat := sfFRP else
                FFormat := sfHTM;
              end;
              s := ParseParam('multipage');
              if s = '0' then FMultipage := False
              else if s = '1' then FMultipage := True
              else FMultipage := not ServerConfig.GetBool('server.exports.html.singlepage');
              s := ParseParam('pagenav');
              if s = '0' then FPageNavigator := False
              else if s = '1' then FPageNavigator := True
              else FPageNavigator := ServerConfig.GetBool('server.exports.html.navigator');
              s := ParseParam('pagerange');
              FPageRange := s;

              FVariables := TfrxVariables.Create;
              try
                if Pos('=', FName) > 0 then
                begin
                  i := 1;
                  while i > 0 do
                  begin
                    j := 1;
                    while (j <= i) and (j <> 0) do
                    begin
                      i := Pos('=', FName);
                      j := Pos('&', FName);
                      if (j < i) and (j <> 0) then
                        FName := Copy(FName, j + 1, Length(FName) - j);
                    end;
                    if i > 0 then
                    begin
                      P := Copy(FName, 1, i - 1);
                      V := '''' + UTF8Decode(ParseParam(P)) + '''';
                      FVariables[P] := V;
                    end;
                  end;
                end;
                FName := frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder) + RepName;
                PrepareReportQuery;
              finally
                FVariables.Free;
              end;
          end else
            if i > 0 then
              FErrorCode := 403;
        end else
        begin
          FReturnData := TfrxReportServer(ParentReportServer).Variables.GetValue(s);
          if Length(FReturnData) = 0 then
            FErrorCode := 404;
        end;
      end;
    end
  end;
end;

function TfrxServerSession.ParseParam(S: String): String;
var
  i, j: integer;
begin
  i := Pos(UpperCase(S) + '=', UpperCase(FName));
  if i > 0 then
  begin
    Result := Copy(FName, i + Length(S) + 1, Length(FName) - i + Length(S) + 1);
    j := Pos('&', Result);
    if j > 0 then
      Result := Copy(Result, 1, j - 1);
    Delete(FName, i, Length(S) + Length(Result) + 1);
  end else
    Result := '';
  if Length(FName) > 0 then
  begin
    i := 1;
    while (FName[i] = '&') and (i < Length(FName)) do
      Inc(i);
    Delete(FName, 1, i - 1);
  end;
  if Result <> '' then
    Result := HTML2Str(Result);
end;

function TfrxServerSession.CheckBadPath: Boolean;
begin
  Result := (Pos('..\', FName) > 0) or (Pos('../', FName) > 0);
end;

procedure TfrxServerSession.CreateReplyHTTPData;
var
  SearchRec: TSearchRec;
  s, sn: String;
begin
  FServerReplyData.Clear;
  FReplyHeader.Clear;

  if Length(FReturnData) > 0 then
    FErrorCode := 200;

  if (FErrorCode = 0) then
    if CheckBadPath then
      FErrorCode := 403
    else if FAuthNeeded then
      FErrorCode := 401
    else if (Length(FResultPage) > 0) and FileExists(FParentHTTPServer.BasePath + FResultPage) then
    begin
      FErrorCode := 301;
      FRedirect := True;
    end else
    begin
      if FName = '' then
        FName := FParentHTTPServer.MainDocument;
      if (FindFirst(FParentHTTPServer.BasePath + FName, faReadOnly + faArchive, SearchRec) = 0) or
         (FindFirst(FParentHTTPServer.BasePath + FName + FParentHTTPServer.MainDocument, faReadOnly + faArchive, SearchRec) = 0)
      then
      begin
        FErrorCode := 200;
        FSize := SearchRec.Size;
        FFileDate := FileDateToDateTime(SearchRec.Time);
      end else
        FErrorCode := 404;
      FindClose(SearchRec);
    end;
  UpdateSessionFName;
  s := ExtractFileExt(FName);
  if s = '.xml' then
    FMIMEType := GetFileMIMEType('.xls')
  else if FMIMEType = '' then
    FMIMEType := GetFileMIMEType(s);
  s := '';
  if FErrorCode = 401 then
    s := ' Unauthorized'
  else if FErrorCode = 403 then
    s := ' Forbidden';
  if FData <> nil then
    FData.HTTPVer := FHTTPVersion;
  if FData <> nil then
    FData.ErrorCode := FErrorCode;
  FReplyHeader.Add(FHTTPVersion + ' ' + IntToStr(FErrorCode) + s);
  if Length(s) = 0 then
  begin
    sn := 'Server';

    FReplyHeader.Add(sn + ': ' + SERVER_NAME);
    AddOutData(sn, SERVER_NAME);

    if FErrorCode = 200 then
    begin
      sn := 'Content-type';
      AddOutData(sn, FMIMEType);
      FReplyHeader.Add(sn + ': ' + FMIMEType);
    end;
    if (FParentHTTPServer.FNoCacheHeader) and (not FRedirect) then
    begin
      sn := 'Cache-Control';
      s := 'must-revalidate, max-age=0';
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s);
      sn := 'Pragma';
      s := 'no-cache';
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s);
    end;
    sn := 'Accept-ranges';
    s := 'none';
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ': ' + s);
    sn := 'Last-Modified';
    s := DateTimeToRFCDateTime(FFileDate);
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ':' + s);
    sn := 'Expires';
    s := DateTimeToRFCDateTime(FFileDate);
    if FData <> nil then
    begin
      FData.Expires := FFileDate;
      FData.LastMod := FFileDate;
    end;
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ':' + s);
    if FGzip and CheckDeflate(FName) and (FErrorCode = 200) and FParentReportServer.SocketOpen then
    begin
      sn := 'Content-Encoding';
      s := 'gzip';
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s)
    end else
      FGzip := False;
    if FRedirect then
    begin
      sn := 'Location';
      s := FResultPage;
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s);
    end;
    if FIsReport then
    begin
      sn := 'SessionId';
      if FDialogSessionId <> '' then
        s := FDialogSessionId
      else
        s := FSessionId;
      AddOutData(sn, s);
      FReplyHeader.Add(sn + ': ' + s);
    end;
  end;
end;

procedure TfrxServerSession.PrepareReportQuery;
var
 Path: String;
 SecAtrtrs: TSecurityAttributes;
begin
  if FIsReport then
  begin
    Path := FParentHTTPServer.BasePath + FSessionId;
    SecAtrtrs.nLength := SizeOf(TSecurityAttributes);
    SecAtrtrs.lpSecurityDescriptor := nil;
    SecAtrtrs.bInheritHandle := true;
    CreateDirectory(PChar(Path), @SecAtrtrs);
    if not FDialog then
    begin
      FRepSession := TfrxReportSession.Create;
      FRepSession.ParentThread := Self;
      FRepSession.NativeClient := Pos('FastReport', FUserAgent) > 0;
      FRepSession.Stream := FStream;
      FRepSession.ParentReportServer := ParentReportServer;
      FRepSession.SessionId := FSessionId;
      FRepSession.CacheId := FCacheId;
      FRepSession.FileName := FName;
      FRepSession.ReportPath := FParentHTTPServer.ReportPath;
      FRepSession.IndexFileName := FParentHTTPServer.MainDocument;
      FRepSession.RootPath := FParentHTTPServer.BasePath;
      FRepSession.PageRange := FPageRange;
      FRepSession.Format := FFormat;
      if Assigned(ParentReportServer.OnGetVariables) then
        DoGetVariables;
      FRepSession.Variables := FVariables;
      FRepSession.FreeOnTerminate := True;

      FRepSession.Password := FPassword;

      FSessionItem.ReportThread := FRepSession;

      FRepSession.PageNav := FPageNavigator;
      FRepSession.Multipage := FMultipage;
      FRepSession.UserLogin := FLogin;

      FRepSession.Resume;
    end else
    begin
      FSessionItem := SessionManager.FindSessionById(FDialogSessionId);
      if FSessionItem <> nil then
      begin
        FRepSession := FSessionItem.ReportThread;
        if FRepSession <> nil then
        begin
          FRepSession.Stream := FStream;
          FRepSession.Variables := FVariables;
          FRepSession.Continue := True;
          while FRepSession.DialogActive and (not Terminated) do
            Sleep(25);
        end
      end
    end;
    if (FRepSession <> nil) and (not Terminated) then
    begin
      while (not Terminated) and (FRepSession.Active) and (not FRepSession.DialogActive) do
        Sleep(10);
      if FDialog then
        FName := '\' + FDialogSessionId + FRepSession.ResultPage
      else
      begin
        FName := '\' + FSessionId + FRepSession.ResultPage;
      end;

      FReportMessage := FRepSession.ReportMessage;

      if FRepSession.Auth then
        FAuthNeeded := True;

      if (not FRepSession.DialogActive) then
        if FDialog then
        begin
          FRepSession.Terminate;
          PMessages;
          SessionManager.FindSessionById(FDialogSessionId).ReportThread := nil;
        end else
          SessionManager.FindSessionById(FSessionId).ReportThread := nil;
      FRepSession.Readed := True;
    end else
      FName := '';
    FResultPage := StringReplace(FName, '\', '/', [rfReplaceAll]);
    FFileDate := Now;
  end;
end;

procedure TfrxServerSession.MakeServerReply;
var
  FStream: TFileStream;
  Buffer, sn, s: AnsiString;
  i: Integer;
  MemStream, MemStreamOut: TMemoryStream;
  FSSIStream: TfrxSSIStream;
  FTemplate: TfrxServerTemplate;
{$IFDEf Delphi12}
  TempStr: AnsiString;
{$ENDIF}
begin
  if FData <> nil then
    FData.FileName := FName;
  if FErrorCode = 200 then
  begin
    if ClientSocket.Connected or (not FParentReportServer.SocketOpen) then
    begin
      MemStream := TMemoryStream.Create;
      FSSIStream := TfrxSSIStream.Create;
      FSSIStream.BasePath := FParentHTTPServer.BasePath;
      FSSIStream.Variables := FParentReportServer.Variables;
      try
        try
          if Length(FReturnData) = 0 then
          begin
            FStream := TFileStream.Create(FParentHTTPServer.BasePath + FName, fmOpenRead + fmShareDenyWrite);
            try
              FSSIStream.CopyFrom(FStream, 0);
            finally
              FStream.Free;
            end;
            if CheckSSI(FName) then
              FSSIStream.Prepare
          end
          else
            FSSIStream.Write(FReturnData[1], Length(FReturnData));

          FSSIStream.Position := 0;
          if FGzip and FParentReportServer.SocketOpen then
          begin
            try
              frxCompressStream(FSSIStream, MemStream, gzMax, FName);
            except
              on E:Exception do
              begin
                FErrorText := 'GZIP pack error. ' + E.Message;
                ErrorLog;
              end;
            end;
          end else
            MemStream.CopyFrom(FSSIStream, 0);
          MemStream.Position := 0;
          sn := 'Content-length';
          s := IntToStr(MemStream.Size);
          AddOutData(sn, s);
          FReplyHeader.Add(sn + ': ' + s);
          if FKeepAlive then
            FReplyHeader.Add('Connection: Keep-Alive')
          else
            FReplyHeader.Add('Connection: Close');
          if ServerConfig.GetBool('server.http.mic') then
          begin
            sn := 'Content-MD5';
            s := MD5Stream(MemStream);
            AddOutData(sn, s);
            FReplyHeader.Add(sn + ': ' + s);
          end;
          FReplyHeader.Add('');
          Buffer := FReplyHeader.Text;
        except
          on E:Exception do
          begin
            FErrorText := 'error prepare output result ' + E.Message;
            ErrorLog;
          end;
        end;
        if FParentReportServer.SocketOpen then
        begin
          MemStreamOut := TMemoryStream.Create;
          try
            MemStream.SaveToStream(MemStreamOut);
            MemStreamOut.Position := 0;
            /// DEBUG!
            ///LogWriter.Write(ACCESS_LEVEL, Buffer);
            ClientSocket.SendBuf(Buffer[1], Length(Buffer));
            ClientSocket.SendStreamThenDrop(MemStreamOut);
          except
            on E:Exception do
            begin
              MemStreamOut.Free;
              FErrorText := 'error socket stream output result' + E.Message;
              ErrorLog;
            end;
          end;
        end else
        begin
          FData.RepHeader := Buffer;
          FData.Stream.CopyFrom(MemStream, 0);
        end;
      finally
        MemStream.Free;
        FSSIStream.Free;
      end
    end;
  end else
  begin
    sn := 'Content-type';
    s := 'text/html';
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ': ' + s);

    if FErrorCode = 404 then
    begin
      FTemplate := TfrxServerTemplate.Create;
      try
        FTemplate.SetTemplate('error404');
        FTemplate.Variables.AddVariable('ERROR', FReportMessage + '<br>' + ServerConfig.ServerMessage);
        FTemplate.Prepare;
        Buffer := FTemplate.TemplateStrings.Text;
      finally
        FTemplate.Free;
      end;

      i := Length(Buffer);
      FErrorText := FName + ' document not found ' + FReportMessage;
      ErrorLog;
    end else
    if FRedirect or (FErrorCode = 403) then
    begin
      i := 0;
      Buffer := '';
    end else
    if FErrorCode = 401 then
    begin
      i := 0;
      Buffer := '';
      if FAuthInProgress then
        FReplyHeader.Add(Format('WWW-Authenticate: ' + FAuthType + ' %s', [FAuthResponse]))
      else
      begin
        if ServerConfig.GetBool('server.security.winauth') then
        begin
          FReplyHeader.Add('WWW-Authenticate: NTLM');
          FReplyHeader.Add('WWW-Authenticate: Negotiate');
          FReplyHeader.Add('WWW-Authenticate: Kerberos');
          FKeepAlive := True;
        end
        else
        begin
          sn := 'WWW-Authenticate';
          s := 'Basic realm="' + SERVER_NAME + '"';
          AddOutData(sn, s);
          FReplyHeader.Add(sn + ': ' + s);
        end;
      end;
    end else
    begin
      FTemplate := TfrxServerTemplate.Create;
      try
        FTemplate.SetTemplate('error500');
        FTemplate.Variables.AddVariable('ERROR', '');
        FTemplate.Prepare;
        Buffer := FTemplate.TemplateStrings.Text;
      finally
        FTemplate.Free;
      end;
      i := Length(Buffer);
      FErrorText := 'unknown error';
      ErrorLog;
    end;

    if FKeepAlive then
      FReplyHeader.Add('Connection: Keep-Alive')
    else
      FReplyHeader.Add('Connection: Close');

    sn := 'Content-length';
    s := IntToStr(i);
    AddOutData(sn, s);
    FReplyHeader.Add(sn + ': ' + s);
    FReplyHeader.Add('');
//    Buffer := FReplyHeader.Text + Buffer;
    if FParentReportServer.SocketOpen then
    begin
      try
{$IFDEF Delphi12}
        TempStr := AnsiString(FReplyHeader.Text);
        ClientSocket.SendText(TempStr);
{$ELSE}
        // DEBUG!
        //LogWriter.Write(ACCESS_LEVEL, FReplyHeader.Text);
        ClientSocket.SendText(FReplyHeader.Text);
{$ENDIF}
        ClientSocket.SendText(Buffer);
        if not FKeepAlive then
          ClientSocket.Close;
      except
        on E: Exception do
        begin
          FErrorText := 'error socket stream output answer. ' + E.Message;
          ErrorLog;
        end;
      end;
    end else
    begin
      FData.RepHeader := FReplyHeader.Text;
      FData.Stream.Write(Buffer[1], Length(Buffer));
    end;
  end;
end;

procedure TfrxServerSession.ClientExecute;
var
  FDSet: TFDSet;
  TimeVal: TTimeVal;
  TempStream, TempStream1: TMemoryStream;
  i: Integer;
  Len: Integer;
begin
  LogWriter.StatAddCurrentSession;

  if FParentReportServer.SocketOpen then
  begin
    FD_ZERO(FDSet);
    FD_SET(ClientSocket.SocketHandle, FDSet);
    TimeVal.tv_sec := FParentHTTPServer.SocketTimeOut;
    TimeVal.tv_usec := 0;
    repeat
      ServCS.Enter;
      try
        i := select(0, @FDSet, nil, nil, @TimeVal);
      finally
        ServCS.Leave;
      end;
      if i = -1 then
        FKeepAlive := False;
      if (i > 0) and not Terminated then
      begin
        TempStream := TMemoryStream.Create;
        TempStream1 := TMemoryStream.Create;
        try
          i := ClientSocket.ReceiveLength;
          try
            while i <> 0 do
            begin
              TempStream1.SetSize(i);
              ClientSocket.ReceiveBuf(TempStream1.Memory^, i);
              i := ClientSocket.ReceiveLength;
              TempStream.CopyFrom(TempStream1, 0);
            end;
          except
            on E: Exception do
            begin
              FErrorText := 'error socket stream read.' + E.Message;
              ErrorLog;
            end;
          end;

          TempStream.Position := 0;
          i := StreamSearch(TempStream, 0, #13#10#13#10);
          if i <> -1 then
          begin
            Len := i + 4;
            SetLength(FHeader, Len);
            try
              TempStream.Position := 0;
              TempStream.ReadBuffer(FHeader[1], Len);
              try
                FStream.CopyFrom(TempStream, TempStream.Size - Len);
              except
                on E:Exception do
                begin
                  FErrorText := 'error client query.' + E.Message;
                  ErrorLog;
                end;
              end;
            except
              on E:Exception do
              begin
                FErrorText := 'error client stream parsing. ' + E.Message;
                ErrorLog;
              end;
            end;
          end;
        finally
          TempStream.Free;
          TempStream1.Free;
        end;
      end;
      ServCS.Enter;
      try
        i := select(0, nil, @FDSet, nil, @TimeVal);
      finally
        ServCS.Leave;
      end;
      if (i > 0) and not Terminated then
        if (Length(FHeader) > 0) and ClientSocket.Connected then
        begin
          ParseHTTPHeader;
          CreateReplyHTTPData;
          MakeServerReply;
        end;
    until not FKeepAlive;
    CloseSession;
  end
  else
  begin
    if FData.Stream.Size > 0 then
    begin
      FStream.CopyFrom(FData.Stream, 0);
      FData.Stream.Clear;
    end;
    FHeader := FData.Header;
    ParseHTTPHeader;
    CreateReplyHTTPData;
    MakeServerReply;
    FActive := False;
    Sleep(100);
  end;
  LogWriter.StatRemoveCurrentSession;
end;

procedure TfrxServerSession.WriteLogs;
begin
  LogWriter.Write(ACCESS_LEVEL, DateTimeToStr(Now) + #9 + FSessionId + #9 + FRemoteIP + #9 + FName);
  if Length(FReferer) > 0 then
    LogWriter.Write(REFERER_LEVEL, DateTimeToStr(Now) + #9 + FRemoteIP + #9 + FReferer);
  if Length(FUserAgent) > 0 then
    LogWriter.Write(AGENT_LEVEL, DateTimeToStr(Now) + #9 + FRemoteIP + #9 + FUserAgent);
end;

procedure TfrxServerSession.ErrorLog;
begin
  LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + FRemoteIP + #9 + FErrorText);
  LogWriter.ErrorReached;
end;

procedure TfrxServerSession.UpdateSessionFName;
begin
  SessionManager.FindSessionById(FSessionId).FileName := FName;
end;

procedure TfrxServerSession.CloseSession;
begin
  SessionManager.CompleteSessionId(SessionId);
end;

function TfrxServerSession.CheckSSI(FileName: String): Boolean;
var
  ext: String;
begin
  ext := LowerCase(ExtractFileExt(FileName));
  Result := (ext = '.htm') or (ext = '.html') or
            (ext = '.shtm') or (ext = '.shtml');
end;

function TfrxServerSession.CheckDeflate(FileName: String): Boolean;
var
  ext: String;
begin
  ext := LowerCase(ExtractFileExt(FileName));
  if Pos('MSIE', FUserAgent) > 0 then
    Result := ((ext = '.htm') or (ext = '.html') or
              (ext = '.shtm') or (ext = '.shtml') or
              (ext = '.css') or (ext = '.txt') or
              (ext = '.bmp')) and (FSize > MAX_IE_GZIP)
  else
    Result := (ext <> '.jpg') and (ext <> '.jpeg') and
              (ext <> '.gif') and (ext <> '.png') and
              (ext <> '.ods') and (ext <> '.odt') and
              (ext <> '.zip') and (ext <> '.rar');
end;

function TfrxServerSession.InitAuth(const SecPackageName: String): boolean;
var
  ntlmSecPI: PSecPkgInfo;
begin
  Result := false;
  if QuerySecurityPackageInfo(PChar(SecPackageName),ntlmSecPI) = 0 then
  begin
    FMaxTokenSize := ntlmSecPI^.cbMaxToken;
    FreeContextBuffer(ntlmSecPI);
    if AcquireCredentialsHandle(nil, PChar(SecPackageName),
      SECPKG_CRED_INBOUND, nil, nil, nil, nil, @FCredHandle, FExpire) = 0 then
      Result:=true;
  end;
end;

procedure TfrxServerSession.FinalAuth;
begin
  FreeCredentialsHandle(@FCredHandle);
end;

function TfrxServerSession.ProcessAuthRequest(AuthRequest: AnsiString; NewConversation: boolean; var AuthResponse: AnsiString;
  var ContextHandle: TSecHandle; var AuthFinished: boolean): boolean;
var
  InBufD: TSecBufferDesc;
  InBuf: TSecBuffer;
  OutBufD: TSecBufferDesc;
  OutBuf: TSecBuffer;
  Attribs: cardinal;
  R: integer;
  Context: PCtxtHandle;
begin
  Result := false;
  // prepare input buffer
  AuthRequest := Base64Decode(AuthRequest);
  inBufD.ulVersion := SECBUFFER_VERSION;
  inBufD.cBuffers := 1;
  inBufD.pBuffers := @inBuf;
  inBuf.BufferType := SECBUFFER_TOKEN;
  inBuf.cbBuffer := length(AuthRequest);
  inBuf.pvBuffer := AllocMem(inBuf.cbBuffer);
  Move(AuthRequest[1], inBuf.pvBuffer^, inBuf.cbBuffer);
  // prepare output buffer
  outBufD.ulVersion := SECBUFFER_VERSION;
  outBufD.cBuffers := 1;
  outBufD.pBuffers := @outBuf;
  outBuf.BufferType := SECBUFFER_TOKEN;
  outBuf.cbBuffer := FMaxTokenSize;
  outBuf.pvBuffer := AllocMem(outBuf.cbBuffer);
  // process request
  if NewConversation then
    Context := nil
  else
    Context := @ContextHandle;
  Attribs := 0;
  R := AcceptSecurityContext(@FCredHandle, Context, @inBufD, Attribs, SECURITY_NATIVE_DREP, @ContextHandle,
    @outBufD, Attribs, @FExpire);
  if (R = SEC_I_COMPLETE_NEEDED) or (R = SEC_I_COMPLETE_AND_CONTINUE) then
    if CompleteAuthToken(@ContextHandle, @outBufD) <> 0 then
      exit;
  AuthFinished := not((R = SEC_I_CONTINUE_NEEDED) or (R = SEC_I_COMPLETE_AND_CONTINUE));
  SetLength(AuthResponse, outBuf.cbBuffer);
  Move(outBuf.pvBuffer^, AuthResponse[1], outBuf.cbBuffer);
  AuthResponse := Base64Encode(AuthResponse);
  // free buffers
  FreeMem(inBuf.pvBuffer);
  FreeMem(outBuf.pvBuffer);
  Result := true;
end;

function TfrxServerSession.GetCurrentUserToken: cardinal;
begin
  if not OpenThreadToken(GetCurrentThread, TOKEN_READ or
    TOKEN_DUPLICATE or TOKEN_IMPERSONATE, true, Result) then
    if not OpenProcessToken(GetCurrentProcess, TOKEN_READ or
      TOKEN_DUPLICATE or TOKEN_IMPERSONATE, Result) then
      Result := 0;
end;


procedure TfrxServerSession.CheckAuth;
var
  i: Integer;
  s: AnsiString;
  L, P: AnsiString;
  sz: cardinal;

begin
  FAuthNeeded := ((Length(ServerConfig.GetValue('server.security.login')) > 0) and
     (Length(ServerConfig.GetValue('server.security.password')) > 0))
     or (ServerConfig.GetBool('server.security.userauth'));
  s := ParseHeaderField('Authorization: ');
  if Length(s) > 0 then
  begin
    FKeepAlive := True;
    i := Pos('Basic ', s);
    if (i > 0) and  not ServerConfig.GetBool('server.security.winauth') then
    begin
      FKeepAlive := False;
      s := Copy(s, i + 6, Length(s) - i - 5);
      s := Base64Decode(s);
      i := Pos(':', s);
      if i > 0 then
      begin
        L := Copy(s, 1, i - 1);
        P := Copy(s, i + 1, Length(s) - i);
        FLogin := L;
        FPassword := P;

        if ServerConfig.GetBool('server.security.userauth') then
        begin
          FAuthNeeded := not ServerUsers.AllowLogin(L, P);
          if FName = '' then
            FName := ServerUsers.GetUserIndex(L);
        end
        else
        if (L = ServerConfig.GetValue('server.security.login')) and
           (P = ServerConfig.GetValue('server.security.password')) then
          FAuthNeeded := False
      end;
    end else
    begin
      // not basic auth
      i := Pos(' ', s);
      if i = 0 then
        i := Length(s);
      FAuthType := Copy(s, 1, i - 1);
      s := Copy(s, i + 1, Length(s) - i);

      if (Pos('Negotiate', FAuthType) > 0 ) or (Pos('Kerberos', FAuthType) > 0) or (Pos('NTLM', FAuthType) > 0 ) and not FAuthFinished then
      begin
        if FAuthNewConv then
        begin
          FAuthInProgress := true;
          if not InitAuth(FAuthType) then
            exit;
        end;
        if not ProcessAuthRequest(s, FAuthNewConv, FAuthResponse, FContextHandle, FAuthFinished) then
        begin
          FinalAuth;
          exit;
        end;
        FAuthNewConv := false;
        if FAuthFinished then
        begin
          if ImpersonateSecurityContext(@FContextHandle) <> 0 then
            exit;
          sz := 0;
          GetUserNameEx(NameSamCompatible, nil, sz);
          if sz = 0 then
            exit;
          SetLength(FLogin, sz);
          GetUserNameEx(NameSamCompatible, pointer(FLogin), sz);
          FLogin := string(PChar(FLogin));
          FPassword := '';
          if FToken <> 0 then
            CloseHandle(FToken);
          FToken := GetCurrentUserToken;
          if RevertSecurityContext(@FContextHandle) <> 0 then
            exit;
          FinalAuth;
          FAuthNewConv := True;
          FAuthInProgress := False;
          FAuthFinished := False;
          FAuthNeeded := False;
          FKeepAlive := False;
        end;
      end;
    end;
  end;
end;

procedure TfrxServerSession.DoGetVariables;
begin
  ParentReportServer.OnGetVariables(FName, FVariables, FLogin);
end;

procedure TfrxServerSession.AddOutData(const Name: String; const Value: String);
begin
  if FData <> nil then
    FData.OutParams.Add(Name + '=' + Value);
end;

{ TfrxServerData }

procedure TfrxServerData.Assign(Source: TfrxServerData);
begin
  FInParams.Assign(Source.InParams);
  FOutParams.Assign(Source.FOutParams);
  FErrorCode := Source.ErrorCode;
  FStream.Clear;
  if Source.Stream.Size > 0 then
  begin
    Source.Stream.Position := 0;
    FStream.CopyFrom(Source.Stream, 0);
  end;
  FErrorCode := Source.ErrorCode;
  FFileName := Source.FileName;
end;

constructor TfrxServerData.Create;
begin
  FInParams := TStringList.Create;
  FOutParams := TStringList.Create;
  FStream := TMemoryStream.Create;
  FErrorCode := 0;
end;

destructor TfrxServerData.Destroy;
begin
  FStream.Free;
  FInParams.Free;
  FOutParams.Free;
  inherited;
end;

{ TfrxServerGuard }

constructor TfrxServerGuard.Create(Server: TfrxReportServer);
begin
  inherited Create(True);
  FServer := Server;
  FTimeOut := 10;
  FListTimeOut := 20;
  Priority := tpLowest;
  Resume;
end;

destructor TfrxServerGuard.Destroy;
begin
  Sleep(10);
  inherited;
end;

procedure TfrxServerGuard.DoLoadConf;
begin
  FServer.LoadConfigs;
end;

procedure TfrxServerGuard.Execute;
var
  time1, time2, out1, out2: Cardinal;
begin
  time1 := GetTickCount;
  time2 := time1;
  out1 := FTimeOut * 1000;
  out2 := FListTimeOut * 1000;
  while not Terminated do
  begin
    if (GetTickCount - time1) > out1 then
    begin
//      Synchronize(DoLoadConf);
      DoLoadConf;
      time1 := GetTickCount;
    end;
    if (GetTickCount - time2) > out2 then
    begin
      FServer.ReportsList.BuildListOfReports;
      FServer.Variables.AddVariable('SERVER_REPORTS_LIST', FServer.ReportsList.Lines.Text);
      FServer.Variables.AddVariable('SERVER_REPORTS_HTML', FServer.ReportsList.Html);
      time2 := GetTickCount;
    end;
    Sleep(1000);
    PMessages;
  end;
end;

initialization
  ServCS := TCriticalSection.Create;

finalization
  ServCS.Free;

end.
