{******************************************}
{   TeeChart Pro  - URL files retrieval    }
{ Copyright (c) 1995-2009 by David Berneda }
{    All Rights Reserved                   }
{******************************************}
unit TeeURL;
{$I TeeDefs.inc}

interface

Uses {$IFNDEF LINUX}
     Windows,
     {$ENDIF}
     Classes, Chart, TeEngine;

type
  TCustomChartLink = class(TComponent)
  private
    { Private declarations }
    FChart : TCustomChart;
    procedure SetChart(const Value: TCustomChart);
  protected
    { Protected declarations }
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation); override;
  public
    { Public declarations }
    property Chart:TCustomChart read FChart write SetChart;
  end;

  { Series Source with FileName property }
  TTeeSeriesSourceFile=class(TTeeSeriesSource)
  private
    FFileName : String;
    procedure SetFileName(const Value:String);
  public
    Procedure Load; override;
    Procedure LoadFromFile(Const AFileName:String);
    Procedure LoadFromStream(AStream:TStream); virtual;
    Procedure LoadFromURL(Const AURL:AnsiString);

    property FileName:String read FFileName write SetFileName;
  end;

  TImportChart=class(TCustomChartLink)
  private
    { Private declarations }
    FKeepPosition : Boolean;
    FKeepSize     : Boolean;

    FOnLoaded     : TNotifyEvent;
    FOnLoading    : TNotifyEvent;

    procedure CheckChart;
    procedure CheckPosition(const Rect:TRect);
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;

    procedure LoadFromFile(const FileName:String);
    procedure LoadFromStream(const Stream:TStream);
    procedure LoadFromURL(const URL:String);
  published
    { Published declarations }
    property Chart;
    property KeepPosition:Boolean read FKeepPosition write FKeepPosition default True;
    property KeepSize:Boolean read FKeepSize write FKeepSize default True;

    { Events }
    property OnLoaded:TNotifyEvent read FOnLoaded write FOnLoaded;
    property OnLoading:TNotifyEvent read FOnLoading write FOnLoading;
  end;

  TChartWebSource = class(TImportChart)
  private
    FURL : String;
  public
    { Public declarations }
    Constructor Create(AOwner:TComponent); override;
    Procedure Execute;
  published
    { Published declarations }
    property URL:String read FURL write FURL;
  end;


{ Read a Chart from a file (ie: Chart1,'http://www.steema.com/demo.tee' ) }
Procedure LoadChartFromURL(Var AChart:TCustomChart; Const URL:AnsiString);

Function DownloadURL(AURL:{$IFDEF CLR}String{$ELSE}PAnsiChar{$ENDIF}; ToStream:TStream): HResult;

// Returns True when St parameter contains a web address (http or ftp)
Function TeeIsURL(St:String):Boolean;

{ Returns a string with the error message from WinInet.dll.
  The Parameter ErrorCode is the result of the DownloadURL function. }
function TeeURLErrorMessage(ErrorCode: Integer): string;  { 5.01 }

{$IFNDEF CLR}
{$IFNDEF CLX}
{ The Windows Handle to WinInet.dll. 0=not opened yet. }
var TeeWinInetDLL:THandle=0;   // 5.01
{$ENDIF}
{$ENDIF}

implementation

Uses
  {$IFDEF CLX}
  Types,
  {$IFNDEF LINUX}
  IdHTTP,
  {$ENDIF}
  {$ENDIF}

  {$IFDEF CLX}
  QControls,
  {$ELSE}
  Controls,
  {$ENDIF}

  {$IFDEF CLR}
  System.Text, System.Net, System.IO,
  {$ENDIF}

  TeCanvas, TeeHtml, TeeProcs, SysUtils, TeeConst, TeeStore;

Procedure LoadChartFromURL(Var AChart:TCustomChart; Const URL:AnsiString);
var tmp    : Integer;
    R      : TRect;
    Stream : TMemoryStream;
    tmpURL : AnsiString;
begin
  Stream:=TMemoryStream.Create;
  try
    tmpURL:=URL;

    tmp:=DownloadURL({$IFNDEF CLR}PAnsiChar{$ENDIF}(tmpURL),Stream);

    if tmp=0 then
    begin
      R:=AChart.BoundsRect;
      Stream.Position:=0; { 5.01 }
      LoadChartFromStream(TCustomChart(AChart),Stream);

      if csDesigning in AChart.ComponentState then
         AChart.BoundsRect:=R;
    end
    else
      Raise ChartException.CreateFmt(TeeMsg_CannotLoadChartFromURL,
                                   [tmp,#13+URL+#13+TeeURLErrorMessage(tmp)]);
  finally
    Stream.Free;
  end;
end;

{$IFNDEF CLX}
Const INTERNET_OPEN_TYPE_PRECONFIG = 0;
      INTERNET_FLAG_RAW_DATA       = $40000000;  { receive the item as raw data }
      INTERNET_FLAG_NO_CACHE_WRITE = $04000000;  { do not write this item to the cache }
      INTERNET_FLAG_DONT_CACHE     = INTERNET_FLAG_NO_CACHE_WRITE;
      WININET_API_FLAG_SYNC        = $00000004;  { force sync operation }
      INTERNET_FLAG_RELOAD         = $80000000;  { retrieve the original item }
      INTERNET_FLAG_HYPERLINK      = $00000400;  { asking wininet to do hyperlinking semantic which works right for scripts }
      INTERNET_FLAG_PRAGMA_NOCACHE = $00000100;  { asking wininet to add "pragma: no-cache" }
      INTERNET_FLAG_RESYNCHRONIZE  = $00000800;  { Reloads HTTP resources if the resource has been modified since the last time it was downloaded. All FTP and Gopher resources are reloaded }

type
  HINTERNET = Pointer;

{$IFNDEF CLR}
var
   _InternetOpenA:function(lpszAgent: PAnsiChar; dwAccessType: DWORD;
                          lpszProxy, lpszProxyBypass: PAnsiChar;
                          dwFlags: DWORD): HINTERNET; stdcall;

   _InternetOpenURLA:function(hInet: HINTERNET; lpszUrl: PAnsiChar;
                         lpszHeaders: PAnsiChar; dwHeadersLength: DWORD; dwFlags: DWORD;
                         dwContext: DWORD): HINTERNET; stdcall;

  _InternetReadFile:function(hFile: HINTERNET; lpBuffer: Pointer;
                         dwNumberOfBytesToRead: DWORD;
                         var lpdwNumberOfBytesRead: DWORD): BOOL; stdcall;

  _InternetCloseHandle:function(hInet: HINTERNET): BOOL; stdcall;
{$ENDIF}

{$IFNDEF CLR}
procedure InitWinInet;
begin
  if TeeWinInetDLL=0 then
  begin
    TeeWinInetDLL:=TeeLoadLibrary('wininet.dll');
    if TeeWinInetDLL<>0 then
    begin
      @_InternetOpenA      :=GetProcAddress(TeeWinInetDLL,'InternetOpenA');
      @_InternetOpenURLA   :=GetProcAddress(TeeWinInetDLL,'InternetOpenUrlA');
      @_InternetReadFile   :=GetProcAddress(TeeWinInetDLL,'InternetReadFile');
      @_InternetCloseHandle:=GetProcAddress(TeeWinInetDLL,'InternetCloseHandle');
    end;
  end;
end;
{$ENDIF}

(*
function InternetSetStatusCallback(hInet: HINTERNET;
  lpfnInternetCallback: PFNInternetStatusCallback): PFNInternetStatusCallback; stdcall;
*)

Function DownloadURL(AURL:{$IFDEF CLR}String{$ELSE}PAnsiChar{$ENDIF}; ToStream:TStream): HResult;
Const
  MaxSize= 128*1024;

var
{$IFNDEF CLR}
    H1  : HINTERNET;
    H2  : HINTERNET;
    Buf : Pointer;
    tmp : Boolean;
    r   : DWord;
{$ELSE}
    tmpClient : WebClient;
    Buf       : packed Array of Byte;
{$ENDIF}
begin
  {$IFDEF CLR}

  tmpClient:=WebClient.Create;
  Buf:=tmpClient.DownloadData(AURL);
  if Length(Buf)>0 then
  begin
    ToStream.Write(Buf,Length(Buf));
    ToStream.Position:=0;
    result:=0;
  end
  else result:=-1;

  {$ELSE}
  {$IFDEF D5}
  result:=-1;
  {$ELSE}
  result:=$80000000;
  {$ENDIF}
  if TeeWinInetDLL=0 then
     InitWinInet;
     
  if TeeWinInetDLL<>0 then
  begin
    h1:=_InternetOpenA('Tee', INTERNET_OPEN_TYPE_PRECONFIG,
                              nil,nil,INTERNET_FLAG_RESYNCHRONIZE
                             {WININET_API_FLAG_SYNC INTERNET_FLAG_DONT_CACHE 5.02 });

    if h1<>nil then
    try
      h2:=_InternetOpenUrlA(h1, AURL, nil,$80000000,
                              { INTERNET_FLAG_DONT_CACHE or 5.02 }
                              INTERNET_FLAG_RELOAD or
                              INTERNET_FLAG_NO_CACHE_WRITE or
                              INTERNET_FLAG_HYPERLINK or
                              INTERNET_FLAG_PRAGMA_NOCACHE

                              ,
                              {INTERNET_FLAG_EXISTING_CONNECT}
                              0);


      if h2<>nil then
      try
        ToStream.Position:=0;
        Buf:=AllocMem(MaxSize);
        try
          Repeat
            r:=0;
            tmp:=_InternetReadFile(h2,Buf,MaxSize,r);
            if tmp then
            begin
              if r>0 then
                 ToStream.WriteBuffer(Buf^,r)
              else
              begin
                ToStream.Position:=0;
                result:=0;
                break;
              end;
            end
            else result:=GetLastError;
          Until r=0;
        finally
          FreeMem(Buf,MaxSize);
        end;
      finally
        if not _InternetCloseHandle(h2) then
           result:=GetLastError;
      end
      else
        result:=GetLastError;
    finally
      if not _InternetCloseHandle(h1) then
         result:=GetLastError;
    end
    else
      result:=GetLastError;
  end
  else
    ShowMessageUser('Cannot load WinInet.dll to access TeeChart file: '+AURL);
  {$ENDIF}
end;

{$ELSE}

Function DownloadURL(AURL:PChar; ToStream:TStream): HResult;
begin
  {$IFDEF LINUX}
  result:=-1;
  {$ELSE}
  With TIdHttp.Create(nil) do
  try
    Get(string(AURL),ToStream);
    ToStream.Position:=0;
    result:=0;
  finally
    Free;
  end;
  {$ENDIF}
end;
{$ENDIF}

function TeeURLErrorMessage(ErrorCode: Integer): string;
{$IFNDEF CLX}
var
  Len    : Integer;
  Buffer : {$IFDEF CLR}StringBuilder{$ELSE}TeeString256{$ENDIF};
{$ENDIF}
begin
  {$IFDEF CLX}
  result:=IntToStr(ErrorCode);
  {$ELSE}

  {$IFDEF CLR}
  Buffer:=StringBuilder.Create(256);
  Len:=0;
  {$ENDIF}

  {$IFNDEF CLR}
  Len := FormatMessage(FORMAT_MESSAGE_FROM_HMODULE or
                       FORMAT_MESSAGE_ARGUMENT_ARRAY,
                       {$IFDEF CLR}IntPtr{$ELSE}Pointer{$ENDIF}(TeeWinInetDLL),
                       ErrorCode, 0, Buffer,
                       SizeOf(Buffer), nil);
  while (Len > 0) and ({$IFDEF CLR}AnsiChar{$ENDIF}(Buffer[Len - 1]) in [#0..#32, '.']) do Dec(Len);
  {$ENDIF}

  {$IFDEF CLR}
  result:=Buffer.ToString(0,Len);
  {$ELSE}
  SetString(result, Buffer, Len);
  {$ENDIF}
  {$ENDIF}
end;

// Returns True when "St" is suspicious to contain a web address...
Function TeeIsURL(St:String):Boolean;
begin
  St:=UpperCase(Trim(St));
  result:=(Pos('HTTP://',St)>0) or (Pos('FTP://',St)>0);
end;

{ TTeeSeriesSourceFile }
Procedure TTeeSeriesSourceFile.Load;
begin
  if Assigned(Series) and (FileName<>'') then
     if TeeIsURL(FileName) then LoadFromURL(FileName)
                           else LoadFromFile(FileName);
end;

procedure TTeeSeriesSourceFile.SetFileName(const Value: String);
begin
  if FFileName<>Value then
  begin
    Close;
    FFileName:=Value;
  end;
end;

procedure TTeeSeriesSourceFile.LoadFromFile(const AFileName: String);
var tmp : TFileStream;
begin
  tmp:=TFileStream.Create(AFileName,fmOpenRead);
  try
    LoadFromStream(tmp);
  finally
    tmp.Free;
  end;
end;

procedure TTeeSeriesSourceFile.LoadFromURL(const AURL: AnsiString);
var Stream : TMemoryStream;
    tmpURL : String;
    tmp    : Integer;
begin
  Stream:=TMemoryStream.Create;
  try
    tmpURL:=AURL;
    tmp:=DownloadURL({$IFNDEF CLR}PAnsiChar{$ENDIF}(tmpURL),Stream);
    if tmp=0 then LoadFromStream(Stream)
    else
       raise ChartException.CreateFmt(TeeMsg_CannotLoadSeriesDataFromURL,
          [tmp,AURL+' '+TeeURLErrorMessage(tmp)]);
  finally
    Stream.Free;
  end;
end;

procedure TTeeSeriesSourceFile.LoadFromStream(AStream: TStream);
begin
  if not Assigned(Series) then
     Raise Exception.Create(TeeMsg_NoSeriesSelected);
end;

{ TCustomChartLink }
procedure TCustomChartLink.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if (Operation=opRemove) and Assigned(FChart) and (AComponent=FChart) then
     Chart:=nil;
end;

procedure TCustomChartLink.SetChart(const Value: TCustomChart);
begin
  if FChart<>Value then
  begin
    {$IFDEF D5}
    if Assigned(FChart) then
       FChart.RemoveFreeNotification(Self);
    {$ENDIF}

    FChart:=Value;

    if Assigned(FChart) then
       FChart.FreeNotification(Self);
  end;
end;

{ TChartWebSource }
Constructor TChartWebSource.Create(AOwner: TComponent);
begin
  inherited {$IFDEF CLR}Create(AOwner){$ENDIF};
  FURL:=TeeMsg_DefaultDemoTee;
end;

procedure TChartWebSource.Execute;
begin
  if FURL<>'' then
     LoadFromURL(FURL);
end;

type
  TCachedStream=class
  public
    URL : String;
    Stream : TMemoryStream;
    Constructor Create;
    Destructor Destroy; override;
  end;

var
  Cached : TThreadList;

{ TCachedImage }

Constructor TCachedStream.Create;
begin
  inherited;
  Stream:=TMemoryStream.Create;
end;

Destructor TCachedStream.Destroy;
begin
  Stream.Free;
  inherited;
end;

procedure DestroyCachedStreams;
var t : Integer;
begin
  with Cached,LockList do
  try
    for t:=0 to Count-1 do
        TCachedStream(Items[t]).Free;
  finally
    UnlockList;
  end;
end;

Function CacheDownload(Const URL:String; St:TStream):Integer;
var tmpUrl : String;
    t      : Integer;
    NewCached : TCachedStream;
begin
  result:=0;

  tmpUrl:=UpperCase(url);

  with Cached,LockList do
  try
    for t:=0 to Count-1 do
    if UpperCase(TCachedStream(Items[t]).URL)=tmpUrl then
    begin
      TCachedStream(Items[t]).Stream.SaveToStream(St);
      Exit;
    end;
  finally
    UnlockList;
  end;

  NewCached:=TCachedStream.Create;

  try
    NewCached.URL:=tmpUrl;
    result:=DownloadURL({$IFNDEF CLR}PAnsiChar{$ENDIF}(URL),NewCached.Stream);

    if result=0 then
    begin
      NewCached.Stream.Position:=0;
      NewCached.Stream.SaveToStream(St);

      with Cached,LockList do
      try
        Add(NewCached);
      finally
        UnlockList;
      end;
    end
    else
      NewCached.Free;

  except
    on Exception do
    begin
      NewCached.Free;
      raise;
    end;
  end;
end;

{ TImportChart }
Constructor TImportChart.Create(AOwner: TComponent);
begin
  inherited;
  FKeepPosition:=True;
  FKeepSize:=True;
end;

procedure TImportChart.LoadFromFile(const FileName: String);
var f : TFileStream;
begin
  f:=TFileStream.Create(FileName,fmOpenRead);
  try
    LoadFromStream(f);
  finally
    f.Free;
  end;
end;

procedure TImportChart.CheckChart;
begin
  if not Assigned(FChart) then
     raise ChartException.Create('Chart not assigned. Cannot import.');
end;

procedure TImportChart.CheckPosition(const Rect:TRect);
begin
  if KeepPosition or KeepSize then
     FChart.Align:=alNone;

  if KeepPosition then
  begin
    FChart.Left:=Rect.Left;
    FChart.Top:=Rect.Top;
  end;

  if KeepSize then
  begin
    FChart.Width:=(Rect.Right-Rect.Left);
    FChart.Height:=(Rect.Bottom-Rect.Top);
  end;
end;

procedure TImportChart.LoadFromStream(const Stream: TStream);
var tmpR : TRect;
begin
  CheckChart;

  if Assigned(FOnLoading) then
     FOnLoading(Self);

  tmpR:=FChart.BoundsRect;
  try
    LoadChartFromStream(FChart,Stream);
  finally
    CheckPosition(tmpR);
  end;

  if Assigned(FOnLoaded) then
     FOnLoaded(Self);
end;

procedure TImportChart.LoadFromURL(const URL: String);
var tmpR : TRect;
begin
  CheckChart;

  if Assigned(FOnLoading) then
     FOnLoading(Self);

  tmpR:=FChart.BoundsRect;
  try
    LoadChartFromURL(FChart,URL);
  finally
    CheckPosition(tmpR);
  end;

  if Assigned(FOnLoaded) then
     FOnLoaded(Self);
end;

initialization
  {$IFNDEF CLR}
  {$IFNDEF CLX}
  {$IFDEF C3}
  TeeWinInetDLL:=0; { <-- BCB3 crashes in Win95 if we do not do this... }
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  Cached:=TThreadList.Create;
  TeeHtml.GraphicDownload:=CacheDownload;
finalization
  {$IFNDEF CLR}
  {$IFNDEF CLX}
  if TeeWinInetDLL<>0 then
     TeeFreeLibrary(TeeWinInetDLL);
  {$ENDIF}
  {$ENDIF}
  DestroyCachedStreams;
  Cached.Free;
end.

