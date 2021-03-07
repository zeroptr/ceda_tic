{**********************************************}
{   TVideoTool component and editor dialog.    }
{   TVideoPlayerTool component.                }
{                                              }
{   Copyright (c) 2006-2009 by David Berneda   }
{**********************************************}
unit TeeVideo;
{$I TeeDefs.inc}

interface

// Idea and code based on TAviWriter components:
//
// (c) Elliott Shevin (shevine@aol.com)
// (c) 1996 Thomas Schimming, schimmin@iee1.et.tu-dresden.de
// (c) 1998,99 Anders Melander

{$IFDEF CLR}
{$UNSAFECODE ON}
{$ENDIF}

uses
  {$IFNDEF LINUX}
  Windows,
  {$ENDIF}
  SysUtils, Classes,
  {$IFDEF CLX}
  Qt, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls,
  QButtons,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons,
  {$ENDIF}
  TeCanvas, TeEngine, Chart, TeeProCo, TeeFilters;

type
  PAVIFile = Pointer;
  PAVIStream = Pointer;

  TAviStreamInfoA = packed record
    fccType        : DWord;
    fccHandler     : DWord;
    dwFlags        : DWord;
    dwCaps         : DWord;
    wPriority      : Word;
    wLanguage      : Word;
    dwScale        : DWord;
    dwRate         : DWord;
    dwStart        : DWord;
    dwLength       : DWord;
    dwInitialFrames: DWord;
    dwSuggestedBufferSize: DWord;
    dwQuality      : DWord;
    dwSampleSize   : DWord;
    rcFrame        : TRect;
    dwEditCount    : DWord;
    dwFormatChangeCount: DWord;
    szName         : packed Array[0..63] of AnsiChar;
  end;

  PAVICompressOptions = ^TAVICompressOptions;
  TAVICompressOptions = packed record
    fccType           : DWord;
    fccHandler        : DWord;
    dwKeyFrameEvery   : DWord;
    dwQuality         : DWord;
    dwBytesPerSecond  : DWord;
    dwFlags           : DWord;
    lpFormat          : Pointer;
    cbFormat          : DWord;
    lpParms           : Pointer;
    cbParms           : DWord;
    dwInterleaveEvery : DWord;
  end;

  TVideoTool=class(TTeeCustomTool)
  private
    FCount      : Integer;
    FDuration   : Integer;
    FFileName   : String;
    FFourCC     : String;
    FOnNewFrame : TNotifyEvent;
    FOnStart    : TNotifyEvent;
    FOnStop     : TNotifyEvent;
    FQuality    : Integer;
    FRecording  : Boolean;

    IFile    : PAVIFile;
    IStream  : TAviStreamInfoA;
    IPStream : PAVIStream;
    ICompStream : PAVIStream;
    IPInInfo : PBitmapInfo;
    AviCompressoptions: TAVICompressOptions;

    procedure AddFrame(Bitmap:TBitmap);
    procedure Clean;
    procedure CreateStream;
    procedure InitStreamFormat(Bitmap:TBitmap);
    procedure PrepareBitmapHeader(var Header:TBitmapInfoHeader);
    procedure SetCompression(const Value:String);
  protected
    Procedure ChartEvent(AEvent:TChartToolEvent); override;
    class Function GetEditorClass:String; override;
  public
    Constructor Create(AOwner:TComponent); override;
    Destructor Destroy; override;

    class Function Description:String; override;
    class Function LongDescription:String; override;

    procedure GetCompressors(const List:TStrings);

    procedure ShowCompressorOptions(Parent:TWinControl);

    procedure StartRecording(const FileName:String);
    procedure StopRecording;

    property FrameCount:Integer read FCount;
    property IsRecording:Boolean read FRecording;
  published
    property Compression:String read FFourCC write SetCompression;
    property CompressionQuality:Integer read FQuality write FQuality default 8000;
    property FileName:String read FFileName write FFileName;
    property FrameDuration:Integer read FDuration write FDuration default 50;

    property OnNewFrame:TNotifyEvent read FOnNewFrame write FOnNewFrame;
    property OnStart:TNotifyEvent read FOnStart write FOnStart;
    property OnStop:TNotifyEvent read FOnStop write FOnStop;
  end;

  TVideoToolEditor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SBMsec: TScrollBar;
    CBCompress: TComboFlat;
    CBQuality: TComboFlat;
    BEdit: TButton;
    GroupBox1: TGroupBox;
    BStart: TButton;
    BStop: TButton;
    Label5: TLabel;
    EFile: TEdit;
    SpeedButton1: TSpeedButton;
    OpenDialog1: TOpenDialog;
    LFrameCap: TLabel;
    LFrame: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBMsecChange(Sender: TObject);
    procedure BStartClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EFileChange(Sender: TObject);
    procedure BStopClick(Sender: TObject);
    procedure CBQualityChange(Sender: TObject);
    procedure CBCompressChange(Sender: TObject);
    procedure BEditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CBCompressDropDown(Sender: TObject);
  private
    { Private declarations }
    CompressFilled : Boolean;
    Video       : TVideoTool;
    OldNewFrame : TNotifyEvent;

    procedure SetLabelFrame;
    procedure SetupProgress;
    procedure VideoNewFrame(Sender: TObject);
  public
    { Public declarations }
  end;

  PAVIFILEINFOA = ^TAVIFILEINFOA;
  TAVIFILEINFOA = record
      dwMaxBytesPerSec      : DWORD;
      dwFlags               : DWORD;
      dwCaps                : DWORD;
      dwStreams             : DWORD;
      dwSuggestedBufferSize : DWORD;
      dwWidth               : DWORD;
      dwHeight              : DWORD;
      dwScale               : DWORD;
      dwRate                : DWORD;
      dwLength              : DWORD;
      dwEditCount           : DWORD;
      szFileType            : packed Array[0..63] of AnsiChar;
  end;

  PVOID=Pointer;

  PGetFrame = ^IGetFrame;
  IGetFrame = packed class
  public
    function GetFrame(lPos: DWORD): PVOID; virtual; stdcall; abstract;
    function _Begin(lStart, lEnd: DWORD; lRate: DWORD): HResult; virtual; stdcall; abstract;
    function _End: HResult; virtual; stdcall; abstract;
    function SetFormat(lpbi: PBITMAPINFOHEADER; lpBits: PVOID; x, y, dx, dy: Integer): HResult; virtual; stdcall; abstract;
  end;

Const
    AVIERR_OK             = 0;

    AVIERR_UNSUPPORTED    = $80044065;
    AVIERR_BADFORMAT      = $80044066;
    AVIERR_MEMORY         = $80044067;
    AVIERR_INTERNAL       = $80044068;
    AVIERR_BADFLAGS       = $80044069;
    AVIERR_BADPARAM       = $8004406A;
    AVIERR_BADSIZE        = $8004406B;
    AVIERR_BADHANDLE      = $8004406C;
    AVIERR_FILEREAD       = $8004406D;
    AVIERR_FILEWRITE      = $8004406E;
    AVIERR_FILEOPEN       = $8004406F;
    AVIERR_COMPRESSOR     = $80044070;
    AVIERR_NOCOMPRESSOR   = $80044071;
    AVIERR_READONLY       = $80044072;
    AVIERR_NODATA         = $80044073;
    AVIERR_BUFFERTOOSMALL = $80044074;
    AVIERR_CANTCOMPRESS   = $80044075;
    AVIERR_USERABORT      = $800440C6;
    AVIERR_ERROR          = $800440C7;

    StreamTypeVIDEO = $73646976; // mmioFOURCC('v', 'i', 'd', 's')
    StreamTypeAUDIO = $73647561; // mmioFOURCC('a', 'u', 'd', 's')

var
  AVIFileExit: procedure stdcall;
  AVIFileGetStream:function(pfile: PAVIFILE; var ppavi: PAVISTREAM;
                            fccType: DWORD; lParam: DWORD): HResult; stdcall;
  AVIFileInit : procedure stdcall;
  AVIFileOpen: function(var ppfile: PAVIFile; szFile: PChar; uMode: UINT;
                        lpHandler: Pointer): HRESULT; stdcall;
  AVIFileRelease:function(pfile: PAVIFile): ULONG; stdcall;
  AVIFileInfo:function(pfile: PAVIFILE; pfi: PAVIFILEINFOA; lSize: DWORD): HResult; stdcall;

  AVIStreamGetFrame:function(pg: PGETFRAME; lPos: DWORD): PVOID; stdcall;
  AVIStreamGetFrameClose:function(pg: PGETFRAME): HResult; stdcall;
  AVIStreamGetFrameOpen:function(pavi: PAVISTREAM;
                                 lpbiWanted: PBITMAPINFOHEADER): PGETFRAME; stdcall;
  AVIStreamLength:function(pavi: PAVISTREAM): DWORD; stdcall;
  AVIStreamRelease:function(pavi: PAVIStream): ULONG; stdcall;
  AVIStreamStart:function(pavi: PAVISTREAM): DWORD; stdcall;
  AVIStreamInfo:function(pavi: PAVISTREAM; var psi: TAviStreamInfoA; lSize: DWORD):DWORD; stdcall;

procedure AviCheck(const ErrorCode:HRESULT);
function InitVideoForWindows:Boolean;

implementation

{$IFNDEF CLX}
{$IFNDEF LCL}
{$R *.DFM}
{$ENDIF}
{$ELSE}
{$R *.xfm}
{$ENDIF}

uses
  MMSystem;

const
  VFW_Name='MSVFW32.DLL';
  AVIFil_Name='avifil32.dll';

  VideoBitmapFormat: TPixelFormat = pf32bit; // pf24Bit;

type
  PICINFO = ^TICINFO;
  TICINFO = packed record
    dwSize       : DWord; // sizeof(ICINFO)
    fccType      : DWord; // compressor type     'vidc' 'audc'
    fccHandler   : DWord; // compressor sub-type 'rle ' 'jpeg' 'pcm '
    dwFlags      : DWord; // flags LOWORD is type specific
    dwVersion    : DWord; // version of the driver
    dwVersionICM : DWord; // version of the ICM used
    //
    // under Win32, the driver always returns UNICODE strings.
    //
    szName       : packed Array[0..15] of WChar; // short name
    szDescription: packed Array[0..127] of WChar; // DWORD name
    szDriver     : packed Array[0..127] of WChar; // driver that contains compressor
  end;

{$IFDEF CLR}
// PENDING !
//[DllImport(AVIFil_Name, CharSet = CharSet.Ansi, EntryPoint = 'AVIFileInit')]
//procedure AVIFileInit; external;

{$ELSE}
var
  VFWHandle    : HINST;
  AVIFilHandle : HINST;

  // AVI File
  AVIFileCreateStream:function(pfile: PAVIFile; var ppavi: PAVIStream;
                               var psi: TAviStreamInfoA): HRESULT; stdcall;

  AVIStreamWrite:function(pavi: PAVIStream; lStart, lSamples: LongInt;
                     lpBuffer: Pointer; cbBuffer: LongInt; dwFlags: DWord;
                     var plSampWritten: LongInt; var plBytesWritten: LongInt): HRESULT; stdcall;

  AVIMakeCompressedStream:function(var ppsCompressed: PAVIStream; ppsSource: PAVIStream;
                     lpOptions: PAVICompressOptions; pclsidHandler: PGUID): HRESULT; stdcall;

  AVIStreamSetFormat:function(pavi: PAVIStream; lPos: LongInt; lpFormat: Pointer;
                     cbFormat: LongInt): HRESULT; stdcall;

  // Video For Windows

  ICInfo: function(fccType, fccHandler: DWord; lpicinfo: PICINFO): BOOL; stdcall;
  ICOpen: function(fccType, fccHandler: DWord; wMode: UINT): THandle; stdcall;
  ICSendMessage: function (hic: THandle; Msg: UINT; dw1, dw2: DWord): DWord; stdcall;
  ICGetInfo: function(hic: THandle; PICINFO: PICINFO; cb: DWord): DWord; stdcall;
  ICClose: function(hic: THandle): DWord; stdcall;
  ICLocate: function(fccType, fccHandler: DWord; lpbiIn, lpbiOut: PBitmapInfoHeader;
                 wFlags: Word): THandle; stdcall;

{$ENDIF}

{ TVideoTool }
procedure TVideoTool.ChartEvent(AEvent: TChartToolEvent);
begin
  inherited;

  if IsRecording and (AEvent=cteAfterDraw) then
  try
    AddFrame(TTeeCanvas3D(ParentChart.Canvas).Bitmap);
  except
    on E:Exception do
    begin
      StopRecording;
      raise;
    end;
  end;
end;

Const
  AVICodeOK = 0;
  AVIIF_KEYFRAME = $00000010;
  AVICOMPRESSF_KEYFRAMES = $00000004;
  AVICOMPRESSF_VALID = $00000008;

procedure AviCheck(const ErrorCode:HRESULT);
begin
  if ErrorCode<>AVICodeOK then
     Raise Exception.Create('AVI Error: '+IntToHex(ErrorCode,8));
end;

procedure TVideoTool.StartRecording(const FileName: String);
var tmp : Integer;
begin
  FFileName:=FileName;

  if Assigned(ParentChart) then
  begin
    AVIFileInit;

    tmp:=FileCreate(FileName);
    if tmp<>0 then
       FileClose(tmp);

    AviCheck(AVIFileOpen(IFile,PChar(FileName),OF_CREATE or OF_WRITE,nil));

    CreateStream;

    FCount:=0;

    FRecording:=True;

    if Assigned(FOnStart) then
       FOnStart(Self);
  end;
end;

procedure TVideoTool.CreateStream;
var s : String;
begin
  ZeroMemory(@IStream, SizeOf(IStream));

  IStream.dwRate:=1000;
  IStream.dwScale:=FrameDuration;
  IStream.fccType:=StreamTypeVIDEO;

  if Compression='' then
     IStream.fccHandler:=0
  else
  begin
    s:=Compression;
    IStream.fccHandler:=mmioStringToFOURCC(PChar(s), 0);
  end;

  IStream.dwQuality:=CompressionQuality;
  IStream.dwFlags:=0;
  IStream.dwSuggestedBufferSize:=0;

  IStream.rcFrame.Right:=ParentChart.Width;
  IStream.rcFrame.Bottom:=ParentChart.Height;

  AVICheck(AVIFileCreateStream(IFile, IPStream, IStream));
end;

procedure TVideoTool.StopRecording;
begin
  Clean;
  FRecording:=False;

  if Assigned(FOnStop) then
     FOnStop(Self);
end;

procedure TVideoTool.AddFrame(Bitmap:TBitmap);
var
  Samples_Written: LongInt;
  Bytes_Written: Longint;
  DIB: TDIBSection;
  DIBErr: integer;
  flag: DWord;
begin
  if FrameCount = 0 then
     InitStreamFormat(Bitmap);

  Bitmap.PixelFormat:=VideoBitmapFormat;

  FillChar(DIB, SizeOf(DIB), 0);

  DIBErr:=GetObject({$IFDEF CLX}QPixmap_hbm{$ENDIF}(Bitmap.Handle), SizeOf(DIB), @DIB);
  if DIBErr=0 then
     Raise Exception.Create('Failed to retrieve bitmap header and pixels. '+
                            'Error: ' + IntToStr(GetLastError));

  flag:= AVIIF_KEYFRAME;

  AVICheck(AVIStreamWrite(ICompStream, FrameCount, 1, DIB.dsBm.bmBits,
           DIB.dsbmih.biSizeImage, flag,
           Samples_Written, Bytes_Written));

  Inc(FCount);

  if Assigned(FOnNewFrame) then
     FOnNewFrame(Self);
end;

procedure TVideoTool.InitStreamFormat(Bitmap:TBitmap);
var
  DIB    : TDIBSection;
  Bits   : Pointer;
  DIBErr : Integer;
  S      : String;
  fInInfoSize: Integer;
begin
  Bitmap.PixelFormat:=VideoBitmapFormat;

  FillChar(DIB, SizeOf(DIB), 0);
  DIBErr:=GetObject({$IFDEF CLX}QPixmap_hbm{$ENDIF}(Bitmap.Handle), SizeOf(DIB), @DIB);
  if DIBErr=0 then
     Raise Exception.Create('Failed to retrieve bitmap header and pixels. '+
                            'Error: ' + IntToStr(GetLastError));

  if Assigned(IPInInfo) then
  begin
    FreeMem(IPInInfo);
    IPInInfo:=nil;
  end;

  fInInfoSize := SizeOf(TBitmapInfoHeader);

  if DIB.dsbmih.biBitCount <= 8 then
     fInInfoSize := fInInfoSize + SizeOf(TRGBQuad) * (1 shl DIB.dsbmih.biBitCount);

  GetMem(IPInInfo, fInInfoSize);

  GetMem(Bits, DIB.dsbmih.biSizeImage);
  try
    {$IFNDEF CLX}
    if not GetDIB(Bitmap.Handle, 0, IPInInfo^, Bits^) then
       Raise Exception.Create('Failed to retrieve bitmap info');
    {$ENDIF}
  finally
    FreeMem(Bits);
  end;

  ZeroMemory(@AviCompressoptions, SizeOf(AviCompressoptions));

  if Compression<>'' then
  begin
    S:=Compression;

    with AviCompressoptions do
    begin
      fccType := streamtypeVIDEO;
      fccHandler := mmioStringToFOURCC(PChar(S), 0);
      dwKeyFrameEvery := Round(1000/FDuration);
      dwQuality := FQuality;
      dwFlags := AVICOMPRESSF_KEYFRAMES or AVICOMPRESSF_VALID;
      lpFormat := IPInInfo;
      cbFormat := fInInfoSize;
    end;

    AVICheck(AVIMakeCompressedStream(ICompStream, IPStream, @AviCompressoptions, nil));
  end
  else
  begin
    ICompStream := IPstream;
    IPstream := nil;
  end;

  AVICheck(AVIStreamSetFormat(ICompStream, 0, IPInInfo, fInInfoSize));
end;

Destructor TVideoTool.Destroy;
begin
  if IsRecording then
     StopRecording;

  Clean;
  inherited;
end;

procedure TVideoTool.Clean;
var RefCount : Integer;
begin
  if Assigned(IPInInfo) then
  begin
    FreeMem(IPInInfo);
    IPInInfo:=nil;
  end;

  if Assigned(IFile) then
  try
    repeat
      RefCount:=AVIFileRelease(IFile);
    until RefCount<=0;
  except
    IFile:=nil;
  end;

  IFile:=nil;

  if FFourCC<>'' then
  if Assigned(ICompStream) then
  begin
    //AVICheck(AVIStreamRelease(ICompStream));
    ICompStream:=nil;
  end;

  if FFourCC='' then
  if Assigned(IPStream) then
  begin
    AVICheck(AVIStreamRelease(IPStream));
    IPStream:=Nil;
  end;

  AVIFileExit;
end;

const
  BitCounts: Array[pf1Bit..pf32Bit] of Byte =
              {$IFDEF CLX}
               (1, 8, 16, 32);
              {$ELSE}
               (1, 4, 8, 16, 16, 24, 32);
              {$ENDIF}

  ICTYPE_VIDEO = $63646976; {vidc}
  ICMODE_COMPRESS = 1;
  ICMODE_QUERY = 4;

  ICM_USER = (DRV_USER + $0000);
  ICM_RESERVED_LOW = (DRV_USER + $1000);
  ICM_RESERVED_HIGH = (DRV_USER + $2000);
  ICM_RESERVED = ICM_RESERVED_LOW;
  ICM_COMPRESS_QUERY = (ICM_USER + 6); // query support for compress
  ICM_CONFIGURE = (ICM_RESERVED + 10); // show the configure dialog
  ICMF_CONFIGURE_QUERY = $00000001;


function ICCompressQuery(hic: THandle; lpbiInput, lpbiOutput: PBitmapInfoHeader): DWord;
begin
  Result := ICSendMessage(hic, ICM_COMPRESS_QUERY, DWord(lpbiInput), DWord(lpbiOutput));
end;

function FourCCToString(const f: DWord): String;
var
  S, s1: string;
  b: byte;
  c: Char;
begin
  result:='    ';
  S := IntToHex(f, 8);
  s1 := '$' + copy(S, 7, 2);
  b := StrToInt(s1);
  c := chr(b);
  Result[1] := c;
  Result[2] := chr(StrToInt('$' + copy(S, 5, 2)));
  Result[3] := chr(StrToInt('$' + copy(S, 3, 2)));
  Result[4] := chr(StrToInt('$' + copy(S, 1, 2)));
end;

procedure TVideoTool.PrepareBitmapHeader(var Header:TBitmapInfoHeader);
begin
  ZeroMemory(@Header, SizeOf(Header));

  with Header do
  begin
    biSize := SizeOf(BitmapInfoHeader);

    if Assigned(ParentChart) then
    begin
      biWidth := ParentChart.Width;
      biHeight := ParentChart.Height;
    end;

    biPlanes := 1;
    biCompression := BI_RGB;
    biBitCount := BitCounts[VideoBitmapFormat];
    biSizeImage := 0;
    biXPelsPerMeter :=1;
    biYPelsPerMeter :=1;
    biClrUsed :=0;
    biClrImportant :=0;
  end;
end;

procedure TVideoTool.GetCompressors(const List:TStrings);
const
  AllValid = False;

var
  ii: TICINFO;
  i: DWord;
  ic: THandle;
  BitmapInfoHeader: TBitmapInfoHeader;
  Name: WideString;
  j: integer;
begin
  List.Clear;
  List.Add(TeeMsg_NoCompression);

  PrepareBitmapHeader(BitmapInfoHeader);

  ii.dwSize := SizeOf(ii);

  i:=0;

  while ICInfo(ICTYPE_VIDEO, i, @ii) do
  begin
    try
      ic:=ICOpen(ICTYPE_VIDEO, ii.fccHandler, ICMODE_QUERY);

      try
        if ic <> 0 then
        begin
          if AllValid or (ICCompressQuery(ic, @BitmapInfoHeader, nil) = 0) then
          begin
            ICGetInfo(ic, @ii, SizeOf(ii));

            Name := '';
            for j := 0 to 15 do
                Name := Name + ii.szName[j];

            List.Add(FourCCToString(ii.fccHandler) + ' ' + String(Name));
          end;
        end;

      finally
        ICClose(ic);
      end;

    except
    end;

    Inc(i);
  end;
end;

function ICQueryConfigure(hic: THandle): BOOL;
begin
  Result := ICSendMessage(hic, ICM_CONFIGURE, DWord(-1), ICMF_CONFIGURE_QUERY) = 0;
end;

function ICConfigure(hic: THandle; HWND: HWND): DWord;
begin
  Result := ICSendMessage(hic, ICM_CONFIGURE, HWND, 0);
end;

procedure TVideoTool.ShowCompressorOptions(Parent:TWinControl);
var ic: THandle;
  S: string;
begin
  if FFourCC = '' then
     Exit;

  S := FFourCC;

  ic := ICOpen(ICTYPE_VIDEO, mmioStringToFOURCC(PChar(S), 0), ICMODE_QUERY);
  try
    if ic <> 0 then
    begin
      if ICQueryConfigure(ic) then
         ICConfigure(ic, {$IFDEF CLX}QWidget_winId{$ENDIF}(Parent.Handle));
    end;
  finally
    ICClose(ic);
  end;
end;

procedure TVideoTool.SetCompression(const Value:String);
var
  // ic: THandle;
  i : integer;
  BitmapInfoHeader: TBitmapInfoHeader;
  tmpStr : TStrings;
  cexists : boolean;
begin
  // Check compresor passed exists in the list of GetCompressors
  cexists := false;
  tmpStr := TStringList.Create;

  try
    GetCompressors(tmpStr);

    for i := 1 to tmpStr.Count-1 do
    begin
     if Copy(UpperCase(tmpStr[i]),1,4)=UpperCase(Value) then
     begin
        cexists := true;
        break;
     end;
    end;

    FFourCC:=Value;
    if cexists then
     PrepareBitmapHeader(BitmapInfoHeader)
    else
         raise Exception.Create('No compressor for ' + FFourCC + ' available');
  finally
    tmpStr.Free;
  end;
  {
  ic:=ICLocate(ICTYPE_VIDEO, mmioStringToFOURCC(PChar(S), 0),
             @BitmapInfoHeader, nil, ICMODE_COMPRESS);

  if ic <> 0 then
     ICClose(ic)
  else
     raise Exception.Create('No compressor for ' + FFourCC + ' available');

  ICClose(ic)
  }
end;

procedure LoadProcAddresses;
begin
  {$IFNDEF CLR}
  if (VFWHandle > 0) and (not Assigned(ICInfo)) then
  begin
    ICInfo:=GetProcAddress(VFWHandle, 'ICInfo');
    ICOpen:=GetProcAddress(VFWHandle, 'ICOpen');
    ICSendMessage:=GetProcAddress(VFWHandle, 'ICSendMessage');
    ICGetInfo:=GetProcAddress(VFWHandle, 'ICGetInfo');
    ICClose:=GetProcAddress(VFWHandle, 'ICClose');
    ICLocate:=GetProcAddress(VFWHandle, 'ICLocate');
  end;

  if (AVIFilHandle > 0) and (not Assigned(AVIFileInit)) then
  begin
    AVIFileInit:=GetProcAddress(AVIFilHandle, 'AVIFileInit');
    AVIFileExit:=GetProcAddress(AVIFilHandle, 'AVIFileExit');
    AVIFileOpen:=GetProcAddress(AVIFilHandle, 'AVIFileOpen');
    AVIFileCreateStream:=GetProcAddress(AVIFilHandle, 'AVIFileCreateStreamA');
    AVIStreamWrite:=GetProcAddress(AVIFilHandle, 'AVIStreamWrite');
    AVIMakeCompressedStream:=GetProcAddress(AVIFilHandle, 'AVIMakeCompressedStream');
    AVIStreamSetFormat:=GetProcAddress(AVIFilHandle, 'AVIStreamSetFormat');
    AVIFileRelease:=GetProcAddress(AVIFilHandle, 'AVIFileRelease');
    AVIStreamRelease:=GetProcAddress(AVIFilHandle, 'AVIStreamRelease');

    AVIFileInfo:=GetProcAddress(AVIFilHandle, 'AVIFileInfoA');
    AVIFileGetStream:=GetProcAddress(AVIFilHandle, 'AVIFileGetStream');
    AVIStreamGetFrameOpen:=GetProcAddress(AVIFilHandle, 'AVIStreamGetFrameOpen');
    AVIStreamGetFrame:=GetProcAddress(AVIFilHandle, 'AVIStreamGetFrame');
    AVIStreamGetFrameClose:=GetProcAddress(AVIFilHandle, 'AVIStreamGetFrameClose');
    AVIStreamStart:=GetProcAddress(AVIFilHandle, 'AVIStreamStart');
    AVIStreamLength:=GetProcAddress(AVIFilHandle, 'AVIStreamLength');
    AVIStreamInfo:=GetProcAddress(AVIFilHandle, 'AVIStreamInfoA');
  end;
  {$ENDIF}
end;

{$IFNDEF CLR}
procedure ClearProcAddresses;
begin
  ICInfo:=nil;
  ICOpen:=nil;
  ICSendMessage:=nil;
  ICGetInfo:=nil;
  ICClose:=nil;
  ICLocate:=nil;
end;
{$ENDIF}

procedure CloseVFW;
begin
  {$IFNDEF CLR}
  if VFWHandle > 0 then
  begin
    FreeLibrary(VFWHandle);
    VFWHandle:=0;
  end;

  if AVIFilHandle > 0 then
  begin
    FreeLibrary(AVIFilHandle);
    AVIFilHandle:=0;
  end;

  ClearProcAddresses;
  {$ENDIF}
end;

function InitVideoForWindows:Boolean;
{$IFNDEF D5}
var OldError: Integer;
{$ENDIF}
begin
{$IFDEF CLR}
  //CloseVFW;
  result:=True;
{$ELSE}

  result:=False;

  if (VFWHandle=0) or (AVIFilHandle=0) then
  begin

    {$IFNDEF D5}
    OldError:=SetErrorMode(SEM_NOOPENFILEERRORBOX);
    try
    {$ENDIF}
      VFWHandle:={$IFDEF D5}SafeLoadLibrary{$ELSE}LoadLibrary{$ENDIF}(PChar(VFW_Name));
      AVIFilHandle:={$IFDEF D5}SafeLoadLibrary{$ELSE}LoadLibrary{$ENDIF}(PChar(AVIFil_Name));

      if (VFWHandle > 0) and (AVIFilHandle > 0) then
      begin
        LoadProcAddresses;
        Result:=True;
      end
      else
      begin
        if VFWHandle > 0 then FreeLibrary(VFWHandle);
        if AVIFilHandle > 0 then FreeLibrary(AVIFilHandle);
      end;
    {$IFNDEF D5}
    finally
      SetErrorMode(OldError);
    end;
    {$ENDIF}
  end;

{$ENDIF}
end;

{ TVideoTool }

Constructor TVideoTool.Create(AOwner: TComponent);
begin
  inherited;

  InitVideoForWindows;

  FDuration:=50;
  FQuality:=8000;
end;

class function TVideoTool.Description: String;
begin
  result:=TeeMsg_VideoTool;
end;

class function TVideoTool.LongDescription: String;
begin
  result:=TeeMsg_VideoToolDesc;
end;

procedure TVideoToolEditor.FormCreate(Sender: TObject);
begin
  with OpenDialog1 do
  begin
    Filter:=TeeMsg_AVIFile+'|*.avi';
    Title:=TeeMsg_SelectAVIFile;
  end;

  Align:=alClient;
  CBCompress.Add(TeeMsg_NoCompression);
  CBCompress.ItemIndex:=0;
end;

procedure TVideoToolEditor.FormShow(Sender: TObject);
begin
  Label2.Caption:=IntToStr(SBMsec.Position);
  CBQuality.ItemIndex:=0;
  BEdit.Enabled:=False;

  Video:=TVideoTool(Tag);

  if Assigned(Video) then
  with Video do
  begin
     // Pending: obtain ItemIndex from "Compression" property FourCC
    CBCompress.ItemIndex:=0;

    EFile.Text:=FileName;
    SBMsec.Position:=FrameDuration;

    case CompressionQuality of
     10000 : CBQuality.ItemIndex:=0;
      9000 : CBQuality.ItemIndex:=1;
      8000 : CBQuality.ItemIndex:=2;
      6000 : CBQuality.ItemIndex:=3;
      4000 : CBQuality.ItemIndex:=4;
    end;

    BStart.Enabled:=(FileName<>'') and (not IsRecording);
    BStop.Enabled:=IsRecording;

    SetLabelFrame;

    if IsRecording then
       SetupProgress;
  end;
end;

procedure TVideoToolEditor.SetupProgress;
begin
  OldNewFrame:=Video.OnNewFrame;
  Video.OnNewFrame:=VideoNewFrame;
end;

procedure TVideoToolEditor.SBMsecChange(Sender: TObject);
begin
  Video.FrameDuration:=SBMsec.Position;
  Label2.Caption:=IntToStr(Video.FrameDuration);
end;

procedure TVideoToolEditor.VideoNewFrame(Sender: TObject);
begin
  if Assigned(OldNewFrame) then
     OldNewFrame(Sender);

  SetLabelFrame;
end;

procedure TVideoToolEditor.SetLabelFrame;
begin
  LFrame.Caption:=IntToStr(Video.FrameCount);
end;

procedure TVideoToolEditor.BStartClick(Sender: TObject);
begin
  Video.StartRecording(EFile.Text);
  BStart.Enabled:=False;
  BStop.Enabled:=True;
  SetupProgress;
end;

procedure TVideoToolEditor.SpeedButton1Click(Sender: TObject);
begin
  OpenDialog1.FileName:=EFile.Text;

  if OpenDialog1.Execute then
     EFile.Text:=OpenDialog1.FileName;
end;

procedure TVideoToolEditor.EFileChange(Sender: TObject);
begin
  BStart.Enabled:=EFile.Text<>'';
end;

procedure TVideoToolEditor.BStopClick(Sender: TObject);
begin
  Video.StopRecording;

  Video.OnNewFrame:=OldNewFrame;

  BStop.Enabled:=False;
  BStart.Enabled:=True;
end;

procedure TVideoToolEditor.CBQualityChange(Sender: TObject);
begin
  case CBQuality.ItemIndex of
    0: Video.CompressionQuality:=10000;
    1: Video.CompressionQuality:=9000;
    2: Video.CompressionQuality:=8000;
    3: Video.CompressionQuality:=6000;
    4: Video.CompressionQuality:=4000;
  end;
end;

procedure TVideoToolEditor.CBCompressChange(Sender: TObject);
begin
  if CBCompress.ItemIndex>0 then
     Video.Compression:=Copy(CBCompress.CurrentItem,1,4)
  else
     Video.Compression:='';

  BEdit.Enabled:=CBCompress.ItemIndex>0;
end;

procedure TVideoToolEditor.BEditClick(Sender: TObject);
begin
  Video.ShowCompressorOptions(Self);
end;

class function TVideoTool.GetEditorClass: String;
begin
  result:='TVideoToolEditor';
end;

procedure TVideoToolEditor.FormDestroy(Sender: TObject);
begin
  if Assigned(Video) then
     Video.OnNewFrame:=OldNewFrame;
end;

procedure TVideoToolEditor.CBCompressDropDown(Sender: TObject);
begin
  if Assigned(Video) and (not CompressFilled) then
  begin
    Screen.Cursor:=crHourGlass;
    try
      Video.GetCompressors(CBCompress.Items);
    finally
      Screen.Cursor:=crDefault;
    end;

    CBCompress.ItemIndex:=0;
    CompressFilled:=True;
  end;
end;

initialization
  RegisterTeeTools([TVideoTool]);
  RegisterClass(TVideoToolEditor);
finalization
  CloseVFW;
  UnRegisterTeeTools([TVideoTool]);
end.
