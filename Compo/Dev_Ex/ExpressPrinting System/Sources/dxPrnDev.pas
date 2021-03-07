{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System(tm) COMPONENT SUITE                  }
{                                                                   }
{       Copyright (C) 1998-2009 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxPrnDev;

interface

(*$HPPEMIT '#include <winspool.h>' *)

{$I cxVer.inc}

uses
  Windows, Classes, ImgList, Controls, SysUtils, Graphics, Messages,
  dxCore, cxControls, dxPSGlbl;

type
  // Follow structures are supported only in W2K and upper

  // specifies the global default printer settings
  
 {$IFDEF CBUILDER5}
  {$EXTERNALSYM _PRINTER_INFO_8A}
 {$ENDIF}
  _PRINTER_INFO_8A = record
    DevMode:  PDeviceModeA ;
  end;
 {$IFDEF CBUILDER5}
  {$EXTERNALSYM _PRINTER_INFO_8W}
 {$ENDIF}
  _PRINTER_INFO_8W = record
    DevMode:  PDeviceModeW ;
  end;
 {$IFDEF CBUILDER5}
  {$EXTERNALSYM _PRINTER_INFO_8}
 {$ENDIF}
  _PRINTER_INFO_8 = _PRINTER_INFO_8A;
  TPrinterInfo8A = _PRINTER_INFO_8A;
  TPrinterInfo8W = _PRINTER_INFO_8W;
  TPrinterInfo8 = TPrinterInfo8A;
 {$IFDEF CBUILDER5} 
  {$EXTERNALSYM PRINTER_INFO_8A}
 {$ENDIF}
  PRINTER_INFO_8A = _PRINTER_INFO_8A;
 {$IFDEF CBUILDER5} 
  {$EXTERNALSYM PRINTER_INFO_8W}
 {$ENDIF}
  PRINTER_INFO_8W = _PRINTER_INFO_8W;
 {$IFDEF CBUILDER5} 
  {$EXTERNALSYM PRINTER_INFO_8}
 {$ENDIF}
  PRINTER_INFO_8 = PRINTER_INFO_8A;
  PPrinterInfo8A = ^TPrinterInfo8A;
  PPrinterInfo8W = ^TPrinterInfo8W;
  PPrinterInfo8 = PPrinterInfo8A;
  
  // specifies the per-user default printer settings

 {$IFDEF CBUILDER5}
  {$EXTERNALSYM _PRINTER_INFO_9A}
 {$ENDIF}
  _PRINTER_INFO_9A = record
    DevMode:  PDeviceModeA ;
  end;
 {$IFDEF CBUILDER5}
  {$EXTERNALSYM _PRINTER_INFO_9W}
 {$ENDIF}
  _PRINTER_INFO_9W = record
    DevMode:  PDeviceModeW ;
  end;  
 {$IFDEF CBUILDER5}
  {$EXTERNALSYM _PRINTER_INFO_8}
 {$ENDIF}
  _PRINTER_INFO_9 = _PRINTER_INFO_9A;
  TPrinterInfo9A = _PRINTER_INFO_9A;
  TPrinterInfo9W = _PRINTER_INFO_9W;
  TPrinterInfo9 = TPrinterInfo9A;
 {$IFDEF CBUILDER5} 
  {$EXTERNALSYM PRINTER_INFO_9A}
 {$ENDIF}
  PRINTER_INFO_9A = _PRINTER_INFO_9A;
 {$IFDEF CBUILDER5} 
  {$EXTERNALSYM PRINTER_INFO_9W}
 {$ENDIF}
  PRINTER_INFO_9W = _PRINTER_INFO_9W;
 {$IFDEF CBUILDER5} 
  {$EXTERNALSYM PRINTER_INFO_9}
 {$ENDIF}
  PRINTER_INFO_9 = PRINTER_INFO_9A;
  PPrinterInfo9A = ^TPrinterInfo9A;
  PPrinterInfo9W = ^TPrinterInfo9W;
  PPrinterInfo9 = PPrinterInfo9A;

  TdxPrinterState = (psNoHandle, psHandleIC, psHandleDC);
  TdxDuplexMode = (dmSimplex, dmHorizontal, dmVertical);
  TdxPrinterOrientation = (poPortrait, poLandscape);
  TdxPrinterCapability = (pcCopies, pcOrientation, pcCollation);//, pcDuplex, pcColor);
  TdxPrinterCapabilities = set of TdxPrinterCapability;
  
  EdxPrintDevice = class(EdxException);

  TdxPrintDeviceInfo = class
  private
    FDevice:  PChar ; 
    FDriver:  PChar ; 
    FPort:  PChar ; 
    FIsDefault: Boolean;
    FIsNetwork: Boolean;
  public
    constructor Create(ADriver, ADevice, APort:  PChar ;
      AnIsDefault, AnIsNetwork: Boolean);
    destructor Destroy; override;
    function IsEqual(ADriver, ADevice, APort:  PChar ): Boolean;

    property Device:  PChar  read FDevice;
    property Driver:  PChar  read FDriver;
    property Port:  PChar  read FPort;
    property IsDefault: Boolean read FIsDefault write FIsDefault;
    property IsNetwork: Boolean read FIsNetwork;
  end;
    
  TdxPrintDevice = class
  private
    FAborted: Boolean;
    FAutoRefresh: Boolean;
    FBins: TStrings;
    FCanvas: TCanvas;
    FCapabilities: TdxPrinterCapabilities;
    FCurrentDevice:  PChar ;
    FCurrentDriver:  PChar ;
    FCurrentPort:  PChar ;
    FDC: HDC;
    FDeviceHandle: THandle;
    FDeviceMode:  PDeviceMode ;
    FDeviceModeChanged: Boolean;
    FHDeviceMode: THandle;
    FFileName: string;
    FFonts: TStrings;
    FIsDeviceModePersistent: Boolean;
    FMaxCopies: Integer;
    FMaxExtents: Integer;
    FMinExtents: Integer;
    FPageNumber: Integer;
    FPapers: TStrings;
    FPrinters: TStrings;
    FPrinterIndex: Integer;
    FPrinting: Boolean;
    FState: TdxPrinterState;
    FTitle: string;
    FWindowHandle: HWND;
    FOnNewPage: TNotifyEvent;
    FOnPrinterChange: TNotifyEvent;
    FOnRefresh: TNotifyEvent;
    function GetBinIndex: Integer;
    function GetBins: TStrings;
    function GetCanvas: TCanvas;
    function GetCollate: Boolean;
    function GetColorMode: Boolean;
    function GetCurrentDevice:  PChar ;
    function GetCurrentDriver:  PChar ;
    function GetCurrentPort:  PChar ;
    function GetDefaultDMPaper: Integer;
    function GetDeviceMode: PDeviceMode;
    function GetDuplex: TdxDuplexMode;
    function GetFonts: TStrings;
    function GetHandle: HDC;
    function GetHDeviceMode: THandle;
    function GetIsDefault: Boolean;
    function GetIsInitialized: Boolean;
    function GetIsNetwork: Boolean;
    function GetMaxExtents(Index: Integer): Integer;
    function GetMinExtents(Index: Integer): Integer;
    function GetNumCopies: Integer;
    function GetOrientation: TdxPrinterOrientation;
    function GetPageHeight: Integer;
    function GetPageHeightLoMetric: Integer;
    function GetPageWidth: Integer;
    function GetPageWidthLoMetric: Integer;
    function GetPaperCount: Integer;
    function GetPaperIndex: Integer;
    function GetPapers: TStrings;
    function GetPhysOffset(Index: Integer): Integer;
    function GetPrinterCount: Integer;
    function GetPrinterIndex: Integer;
    function GetPrinterInfo(Index: Integer): TdxPrintDeviceInfo;
    function GetPrinters: TStrings;
    procedure SetBinIndex(Value: Integer);
    procedure SetCollate(Value: Boolean);
    procedure SetColorMode(Value: Boolean);
    procedure SetDuplex(Value: TdxDuplexMode);
    procedure SetIsDefault(Value: Boolean);
    procedure SetNumCopies(Value: Integer);
    procedure SetOrientation(Value: TdxPrinterOrientation);
    procedure SetPaperIndex(Value: Integer);
    procedure SetPrinterCapabilities(Value: Integer);
    procedure SetPrinterIndex(Value: Integer);

    procedure CheckPrinting(Value: Boolean);
    procedure ClosePrintDevice;
    procedure DeselectHandles;
    procedure FixMinMaxExtents;
    procedure FreeAndNilBins;
    procedure FreeAndNilCanvas;
    procedure FreeAndNilFonts;
    procedure FreeAndNilPapers;
    procedure FreeAndNilPrinters;
    procedure InternalSelectPaperBySize(var AWidth, AHeight: Integer);
    procedure OpenPrintDevice(AIndex: Integer);
    procedure SetState(Value: TdxPrinterState);
    procedure SetToDefaultPrintDevice;
    procedure WndProc(var Message: TMessage);
  protected
    procedure DoNewPage; dynamic;
    procedure DoPrinterChanged; dynamic;
    procedure DoRefresh; dynamic;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Abort;
    function BeginDoc: Integer; {returns the print job identifier for the document}
    procedure EndDoc;
    procedure NewPage;

    function FindPrintDevice(ADevice, APort:  PChar ): Integer;
    function IsDeviceModeChanged: Boolean;
    procedure Refresh;
    procedure ResetDC(IsForced: Boolean);
    procedure ResetPrintDevice;
    
    function FindBin(ABin: Integer): Integer; overload;
    function FindBin(const AName: string): Integer; overload;
    function IsAutoSelectBin(AIndex: Integer): Boolean;
    function IsUserPaperSource(AIndex: Integer): Boolean;
    function SelectBin(Value: Integer): Boolean; overload;
    function SelectBin(const AName: string): Boolean; overload;

    function FindPaper(ADMPaper: Integer): Integer; overload;
    function FindPaper(const AName: string): Integer; overload;
    function FindPaper(const ASize: TPoint): Integer; overload;
    function FindPaper(AWidth, AHeight: Integer): Integer; overload;
    function IsEnvelopePaper(AIndex: Integer): Boolean;
    function IsUserPaperSize(AIndex: Integer): Boolean;
    function SelectPaper(ADMPaper: Integer): Boolean; overload;
    function SelectPaper(const AName: string): Boolean; overload;
    function SelectPaper(var AWidth, AHeight: Integer): Boolean; overload;

    function IsSupportColoration: Boolean;
    function IsSupportDuplex: Boolean;
    
    property Aborted: Boolean read FAborted;
    property AutoRefresh: Boolean read FAutoRefresh write FAutoRefresh;
    property BinIndex: Integer read GetBinIndex write SetBinIndex;
    property Bins: TStrings read GetBins;
    property Canvas: TCanvas read GetCanvas;
    property Capabilities: TdxPrinterCapabilities read FCapabilities;
    property Collate: Boolean read GetCollate write SetCollate;
    property ColorMode: Boolean read GetColorMode write SetColorMode;
    property Copies: Integer read GetNumCopies write SetNumCopies;
    property CurrentDevice:  PChar  read GetCurrentDevice;
    property CurrentDriver:  PChar  read GetCurrentDriver;
    property CurrentPort:  PChar  read GetCurrentPort;
    property DefaultDMPaper: Integer read GetDefaultDMPaper;
    property DeviceMode: PDeviceMode read GetDeviceMode;
    property Duplex: TdxDuplexMode read GetDuplex write SetDuplex;
    property FileName: string read FFileName write FFileName;
    property Fonts: TStrings read GetFonts;
    property Handle: HDC read GetHandle;
    property HDeviceMode: THandle read GetHDeviceMode;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
    property IsDeviceModePersistent: Boolean read FIsDeviceModePersistent write FIsDeviceModePersistent;
    property IsInitialized: Boolean read GetIsInitialized;
    property IsNetwork: Boolean read GetIsNetwork;
    property MaxCopies: Longint read FMaxCopies;
    property MaxExtentX: Integer index 0 read GetMaxExtents;
    property MaxExtentY: Integer index 1 read GetMaxExtents;
    property MinExtentX: Integer index 0 read GetMinExtents;
    property MinExtentY: Integer index 1 read GetMinExtents;
    property Orientation: TdxPrinterOrientation read GetOrientation write SetOrientation;
    property PageHeight: Integer read GetPageHeight;
    property PageHeightLoMetric: Integer read GetPageHeightLoMetric;
    property PageWidth: Integer read GetPageWidth;
    property PageWidthLoMetric: Integer read GetPageWidthLoMetric;
    property PageNumber: Integer read FPageNumber;
    property PaperIndex: Integer read GetPaperIndex write SetPaperIndex;
    property PaperCount: Integer read GetPaperCount;
    property Papers: TStrings read GetPapers;
    property PhysOffsetX: Integer index 0 read GetPhysOffset;
    property PhysOffsetY: Integer index 1 read GetPhysOffset;
    property PrinterCount: Integer read GetPrinterCount;
    property PrinterIndex: Integer read GetPrinterIndex write SetPrinterIndex;
    property PrinterInfos[Index: Integer]: TdxPrintDeviceInfo read GetPrinterInfo;
    property Printers: TStrings read GetPrinters;
    property Printing: Boolean read FPrinting;
    property Title: string read FTitle write FTitle;

    property OnNewPage: TNotifyEvent read FOnNewPage write FOnNewPage;
    property OnPrinterChange: TNotifyEvent read FOnPrinterChange write FOnPrinterChange;
    property OnRefresh: TNotifyEvent read FOnRefresh write FOnRefresh;
  end;

  TdxPaperInfo = class
  private
    FDMPaper: Integer;
    FName: string;
    FPrintDevice: TdxPrintDevice;
    FSize: TPoint;
    function GetSize(Index: Integer): Integer;
    procedure SetSize(Index: Integer; Value: Integer);
  public
    constructor Create(APrintDevice: TdxPrintDevice);
    procedure Assign(Source: TdxPaperInfo);
    function IsEqual(Source: TdxPaperInfo): Boolean;

    property DMPaper: Integer read FDMPaper;
    property Height: Integer index 1 read GetSize write SetSize;
    property Name: string read FName;
    property Size: TPoint read FSize;
    property Width: Integer index 0 read GetSize write SetSize;
  end;

function dxConnectToNetPrinter(AParentWnd: HWND): Boolean;
function dxDocumentProperties(AParentWnd: HWND): Boolean;
function dxInitPrintDevice(ARaiseException: Boolean): Boolean;
function dxIsAutoSelectBin(const AName: string): Boolean;
function dxIsEnvelopePaper(const AName: string): Boolean;
function dxIsPrintDeviceAllocated: Boolean;
function dxIsPrintDeviceInitialized: Boolean;
function dxPrintDevice: TdxPrintDevice;
procedure dxReleasePrintDevice;
function dxSetPrintDevice(APrintDevice: TdxPrintDevice): TdxPrintDevice;

procedure dxDrawPrinter(ACanvas: TCanvas; ARect: TRect; const AText: string; 
  AImageList: TCustomImageList; AImageIndex: Integer);
procedure dxGetPrinterList(AStrings: TStrings);

function dxGetDefaultDMPaper: Integer;
function dxGetDefaultPrinter: string;

function dxIsDefaultPrinter(ADevice:  PChar ): Boolean;
procedure dxSetDefaultPrinter(ADevice:  PChar );

type                                                         
  TConnectToPrinterDlg = function(hWnd: HWND; Flags: DWORD): THandle; stdcall;
  TGetDefaultPrinter = function(pszBuffer: PChar; var cchBuffer: DWORD): BOOL; stdcall;
  TGetDefaultPrinterA = function(pszBuffer: PAnsiChar; var cchBuffer: DWORD): BOOL; stdcall;  
  TGetDefaultPrinterW = function(pszBuffer: PWideChar; var cchBuffer: DWORD): BOOL; stdcall;    
  TSetDefaultPrinter = function(pszPrinter: PChar): BOOL; stdcall;
  TSetDefaultPrinterA = function(pszPrinter: PAnsiChar): BOOL; stdcall;  
  TSetDefaultPrinterW = function(pszPrinter: PWideChar): BOOL; stdcall;    
  
var  
  dxPSUseCachedDMPaper: Boolean = True;
  
const  
  cMinPaperExtent = 254;
  cMaxPaperExtent = 30  * cMinPaperExtent;

 {$EXTERNALSYM LOCALE_IPAPERSIZE}
  LOCALE_IPAPERSIZE = $0000100A;
  
implementation

uses
  Forms, WinSpool, cxClasses, dxPSUtl, dxPSRes;
  
  
const  
  dxDefaultMaxPaperExtents = 5000;
  dxDefaultMinPaperExtents = 500;

  DuplexModeMap: array[DMDUP_SIMPLEX..DMDUP_HORIZONTAL] of TdxDuplexMode = (dmSimplex, dmHorizontal, dmVertical);
  OrientationMap: array[DMORIENT_PORTRAIT..DMORIENT_LANDSCAPE] of TdxPrinterOrientation = (poPortrait, poLandscape);
  PrinterOrientationMap: array[TdxPrinterOrientation] of Integer = (DMORIENT_PORTRAIT, DMORIENT_LANDSCAPE);
  
var
  FPrintDevice: TdxPrintDevice = nil;
  FConnectToPrinterDlg: TConnectToPrinterDlg = nil;
  FGetDefaultPrinter: TGetDefaultPrinter = nil;
  FSetDefaultPrinter: TSetDefaultPrinter = nil;

                                                           
function DocumentProperties(hWnd: HWND; hPrinter: THandle; pDeviceName: PChar;
  pDevModeOutput, pDevModeInput: PDeviceMode; fMode: DWORD): Longint;
  stdcall; external winspl name {$IFNDEF DELPHI12} 'DocumentPropertiesA' {$ELSE} 'DocumentPropertiesW' {$ENDIF};
			 

function IsConnectToPrinterDlgInitialized: Boolean;
begin
  Result := @FConnectToPrinterDlg <> nil;
end;

function IsGetDefaultPrinterInitialized: Boolean;
begin
  Result := @FGetDefaultPrinter <> nil;
end;

function IsSetDefaultPrinterInitialized: Boolean;
begin
  Result := @FSetDefaultPrinter <> nil;
end;

{ Memory Management Routines }

function dxAllocMem(ASize: Integer): Pointer;
begin
  Result := AllocMem(ASize);
end;

procedure dxFreeMem(var P: Pointer; ASize: Integer);
begin
  FreeMem(P, ASize);
  P := nil;
end;

{.$DEFINE DEBUG_PRINTDEVICE}  

{$IFDEF DEBUG_PRINTDEVICE}
var
  LogFile: TextFile;

procedure RewriteLog;
begin
  Rewrite(LogFile);
end;

procedure WriteLog(const S: string);
begin
  WriteLn(LogFile, S);
end;

{$ENDIF}

function FetchStr(var Str: PChar): PChar;
var
  P: PChar;
begin
  Result := Str;
  if Str = nil then Exit;
  P := Str;
  while P^ = ' ' do
    Inc(P);
  Result := P;
  while (P^ <> #0) and (P^ <> ',') do
    P := StrNextChar(P);
  if P^ = ',' then
  begin
    P^ := #0;
    Inc(P);
  end;
  Str := P;
end;

procedure RaiseError(const Msg: string);
begin
  raise EdxPrintDevice.Create(Msg);
end;

function AbortProc(Prn: HDC; Error: Integer): Bool;  stdcall; 
begin
{$IFDEF DEBUG_PRINTDEVICE}
  WriteLog('AbortProc');
{$ENDIF}  
//  Application.ProcessMessages;
  Result := not FPrintDevice.Aborted;
end;

function dxIsPrintDeviceAllocated: Boolean;
begin
  Result := FPrintDevice <> nil;
end;

function dxIsPrintDeviceInitialized: Boolean;
begin
  Result := dxIsPrintDeviceAllocated and dxPrintDevice.IsInitialized;
end;

function dxPrintDevice: TdxPrintDevice;
begin
  if FPrintDevice = nil then FPrintDevice := TdxPrintDevice.Create;
  Result := FPrintDevice;
end;

function dxConnectToNetPrinter(AParentWnd: HWND): Boolean;
var
  Handle: THandle;
begin
  if IsConnectToPrinterDlgInitialized then
  begin
    Handle := FConnectToPrinterDlg(AParentWnd, 0);
    Result := Handle <> 0;
    if Result then
    begin
      ClosePrinter(Handle);
      dxPrintDevice.Refresh;
    end;
  end
  else
    Result := False;
end;

{.$WARN SYMBOL_DEPRECATED OFF}

function dxDocumentProperties(AParentWnd: HWND): Boolean;
var
  HNewDevMode: THandle;
  PNewDevMode:  PDevMode ;
begin
  Result := False;
  HNewDevMode := 0;
  try
    HNewDevMode := CopyDeviceMode(dxPrintDevice.HDeviceMode);
    if HNewDevMode <> 0 then
    try
      PNewDevMode := GlobalLock(HNewDevMode);
      try
        with dxPrintDevice do
          Result := IDOK = DocumentProperties(AParentWnd, FDeviceHandle, CurrentDevice,
            PNewDevMode, DeviceMode, DM_IN_PROMPT or DM_OUT_BUFFER or DM_IN_BUFFER);
      finally
        GlobalUnlock(HNewDevMode);
      end;
    finally
      if Result then
        with dxPrintDevice do
        begin
          while GlobalUnlock(FHDeviceMode) do;
          GlobalFree(FHDeviceMode);
          FHDeviceMode := HNewDevMode;
          FDeviceMode := GlobalLock(FHDeviceMode);
        end
      else 
        if HNewDevMode <> 0 then GlobalFree(HNewDevMode);
    end;
  except
    if HNewDevMode <> 0 then GlobalFree(HNewDevMode);
  end;
end;

{.$WARN SYMBOL_DEPRECATED ON}

{$HINTS OFF}

function dxInitPrintDevice(ARaiseException: Boolean): Boolean;
var
  Stub: HDC;
begin
  Result := True;
  try
    Result := dxPrintDevice.Printers.Count > 0;
    if Result then Stub := dxPrintDevice.Handle;
  except
    Result := False;
    if ARaiseException then raise;
  end;
end;

{$HINTS ON}

procedure dxReleasePrintDevice;
begin
  dxSetPrintDevice(nil).Free;
end;

function dxSetPrintDevice(APrintDevice: TdxPrintDevice): TdxPrintDevice;
begin
  Result := FPrintDevice;
  FPrintDevice := APrintDevice;
end;                                                             

function dxIsAutoSelectBin(const AName: string): Boolean;
begin
  Result := Pos(UpperCase(cxGetResourceString(@sdxAuto)), UpperCase(AName)) > 0;
end;

function dxIsEnvelopePaper(const AName: string): Boolean;
begin
  Result := Pos(UpperCase(cxGetResourceString(@sdxEnv)), UpperCase(AName)) > 0;
end;

function dxGetDefaultDMPaper: Integer;
const
  CachedDMPaper: Integer = -1;
var
  Device: string;
  HPrinter: THandle;
  dwNeeded: DWORD;
  PI9: PPrinterInfo9;
begin 
  if not dxPSUseCachedDMPaper or (CachedDMPaper = -1) then
  begin
    Result := Windows.DMPAPER_FIRST;
    if IsWin2KOrLater then
    begin
      Device := dxGetDefaultPrinter;     
      if (Device <> '') and OpenPrinter(PChar(Device), HPrinter, nil) and (HPrinter <> 0) then
      try
        dwNeeded := 0; {3.03}
        if GetPrinter(HPrinter, 9, nil, 0, @dwNeeded) or (dwNeeded <> 0) then
        begin
          PI9 := GlobalAllocPtr(GPTR, dwNeeded);
          if PI9 <> nil then 
          try
            if GetPrinter(HPrinter, 9, PI9, dwNeeded, @dwNeeded) then
              if PI9^.DevMode <> nil then
              try
                Result := PI9^.DevMode^.dmPaperSize;
              finally
                //GlobalFreePtr(PI9^.DevMode); //TODO: check necessity
              end;  
          finally
            GlobalFreePtr(PI9);
          end;    
        end;
      finally    
        ClosePrinter(HPrinter);
      end
      else
        case GetLocaleChar(LOCALE_USER_DEFAULT, LOCALE_IPAPERSIZE, '0') of 
          '1': Result := Windows.DMPAPER_LETTER;
          '5': Result := Windows.DMPAPER_LEGAL;
          '8': Result := Windows.DMPAPER_A3;
          '9': Result := Windows.DMPAPER_A4;
        end;  
    end;  
    CachedDMPaper := Result;  
  end
  else
    Result := CachedDMPaper;
end;

function dxGetDefaultPrinter: string;
const
  MAX_BUFFER_SIZE = 1024;
var
  L: DWORD;
  Buffer: array[0..MAX_BUFFER_SIZE] of Char;
  C: PChar;
begin
  Result := '';
  L := MAX_BUFFER_SIZE;
  FillChar(Buffer, SizeOf(Buffer), 0);
  if false and IsGetDefaultPrinterInitialized and FGetDefaultPrinter(@Buffer, L) and
    (GetLastError = ERROR_SUCCESS) then
    Result := Buffer
  else
    if GetProfileString('WINDOWS', 'DEVICE', '', Buffer, L) > 0 then
    begin
      C := @Buffer[0];
      Result := FetchStr(C);
    end;
end;

function dxIsDefaultPrinter(ADevice:  PChar ): Boolean;
begin
  Result := StrIComp(PChar(dxGetDefaultPrinter), ADevice) = 0;
end;

procedure dxSetDefaultPrinter(ADevice:  PChar );
var
  dwNeeded: DWORD;
  HPrinter: THandle;
  PI2: PPrinterInfo2;
  S: string;
begin
  if IsSetDefaultPrinterInitialized then // Win2KOrXP
    FSetDefaultPrinter(ADevice)
  else  
    if OpenPrinter(ADevice, HPrinter, nil) and (HPrinter <> 0) then 
    try
      dwNeeded := 0; {3.03}
      if GetPrinter(HPrinter, 2, nil, 0, @dwNeeded) or (dwNeeded <> 0) then
      begin
        PI2 := GlobalAllocPtr(GPTR, dwNeeded);
        if PI2 <> nil then 
        try
          if GetPrinter(HPrinter, 2, PI2, dwNeeded, @dwNeeded) then 
            if IsWin9X then
            begin
              PI2^.Attributes := PI2^.Attributes or PRINTER_ATTRIBUTE_DEFAULT;
              SetPrinter(HPrinter, 2, PI2, 0);
              SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, LPARAM(PChar('windows')), SMTO_NORMAL, 1000, dwNeeded);
            end
            else // WinNT or earlier
              if (PI2^.pDriverName <> nil) and (PI2^.pPortName <> nil) then 
              begin
                S := dxConcatenateStrings([PI2^.pPrinterName, ',',PI2^.pDriverName, ',', PI2^.pDriverName]);
                if WriteProfileString('windows', 'device', PChar(S)) then
                begin
                  dwNeeded := Length(S);
                  SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, 0, SMTO_NORMAL, 1000, dwNeeded);
                end;  
              end;  
        finally
          GlobalFreePtr(PI2);
        end;    
      end;  
    finally    
      ClosePrinter(hPrinter);
    end;
end;
                  
procedure dxDrawPrinter(ACanvas: TCanvas; ARect: TRect; const AText: string; 
  AImageList: TCustomImageList; AImageIndex: Integer);
var
  Offset: Integer;   
begin
  with ACanvas, ARect do
  begin 
    FillRect(ARect);
    // Image
    InflateRect(ARect, -1, -1);
    Offset := (Bottom - Top - AImageList.Height) div 2;
    Inc(Left, Offset);
    Inc(Top, Offset);    
    AImageList.Draw(ACanvas, Left, Top, AImageIndex);
    // Text
    Inc(Offset);
    Inc(Left, Offset + AImageList.Width + Offset);
    Brush.Style := bsClear;
    TextRect(ARect, Left + Offset, Top + Offset, AText);
    Brush.Style := bsSolid;
  end;  
end;

procedure dxGetPrinterList(AStrings: TStrings);
begin
  with AStrings do
  begin
    BeginUpdate;
    try
      Clear;
      if dxPrintDevice.Printers <> nil then 
        Assign(dxPrintDevice.Printers);
    finally
      EndUpdate;
    end;
  end;  
end;

{ TdxPrintDeviceInfo }

constructor TdxPrintDeviceInfo.Create(ADriver, ADevice, APort:  PChar ;
  AnIsDefault, AnIsNetwork: Boolean);
begin
  inherited Create;
  FDriver := StrNew(ADriver);
  FDevice := StrNew(ADevice);
  FPort := StrNew(APort);
  FIsDefault := AnIsDefault;
  FIsNetwork := AnIsNetwork;
end;

destructor TdxPrintDeviceInfo.Destroy;
begin
  StrDispose(FPort);
  StrDispose(FDevice);
  StrDispose(FDriver);
  inherited;
end;

function TdxPrintDeviceInfo.IsEqual(ADriver, ADevice, APort:  PChar ): Boolean;
begin
  Result := (StrIComp(Device, ADevice) = 0) and ((Port = nil) or (APort = nil) or (StrIComp(Port, APort) = 0));
end;

{ TdxPrintDeviceCanvas }

type
  TdxPrintDeviceCanvas = class(TCanvas)
  private
    FPrintDevice: TdxPrintDevice;
  protected
    procedure CreateHandle; override;
    procedure Changing; override;
    procedure UpdateFont;
  public
    constructor Create(APrintDevice: TdxPrintDevice);
  end;

constructor TdxPrintDeviceCanvas.Create(APrintDevice: TdxPrintDevice);
begin
  inherited Create;
  FPrintDevice := APrintDevice;
end;

procedure TdxPrintDeviceCanvas.CreateHandle;
begin
  FPrintDevice.SetState(psHandleIC);
  UpdateFont;
  Handle := FPrintDevice.FDC;
end;

procedure TdxPrintDeviceCanvas.Changing;
begin
  FPrintDevice.CheckPrinting(True);
  inherited Changing;
  UpdateFont;
end;

procedure TdxPrintDeviceCanvas.UpdateFont;
var
  FontSize: Integer;
begin
  if GetDeviceCaps(FPrintDevice.FDC, LOGPIXELSY) <> Font.PixelsPerInch then
  begin
    FontSize := Font.Size;
    Font.PixelsPerInch := GetDeviceCaps(FPrintDevice.FDC, LOGPIXELSY);
    Font.Size := FontSize;
  end;
end;

{ TdxPaperInfo }

constructor TdxPaperInfo.Create(APrintDevice: TdxPrintDevice);
begin
  inherited Create;
  FPrintDevice := APrintDevice;
end;

function TdxPaperInfo.IsEqual(Source: TdxPaperInfo): Boolean;
begin
  Result := (DMPaper = Source.DMPaper) and (FName = Source.Name) and 
    dxPSUtl.ArePointsEqual(Size, Source.Size);
end;

procedure TdxPaperInfo.Assign(Source: TdxPaperInfo);
begin
  FDMPaper := Source.FDMPaper;
  FName := Source.FName;
  FSize := Source.FSize;
end;

function TdxPaperInfo.GetSize(Index: Integer): Integer;
begin
  with Size do 
    if Index = 0 then
      Result := X
    else
      Result := Y;
end;

procedure TdxPaperInfo.SetSize(Index: Integer; Value: Integer);
begin
  if DMPaper < DMPAPER_USER then Exit;
  if Index = 0 then
  begin
    FSize.X := Value;
    if (FPrintDevice <> nil) and (FPrintDevice.FDeviceMode <> nil) then
      FPrintDevice.DeviceMode^.dmPaperWidth := FSize.X;
  end
  else
  begin
    FSize.Y := Value;
    if (FPrintDevice <> nil) and (FPrintDevice.FDeviceMode <> nil) then
      FPrintDevice.DeviceMode^.dmPaperLength := FSize.Y;
  end;
end;

{ TdxPrintDevice }

constructor TdxPrintDevice.Create;
begin
  inherited Create;
  FAutoRefresh := {True; //}False;
  FIsDeviceModePersistent := True;
  FPrinterIndex := -MaxInt;
  FWindowHandle := dxPSUtl.dxAllocateHWnd(WndProc);
end;

destructor TdxPrintDevice.Destroy;
begin
  if Printing then EndDoc;
  DeselectHandles;
  SetState(psNoHandle);
  dxPSUtl.dxDeallocatehWnd(FWindowHandle);
  FWindowHandle := 0;
  ClosePrintDevice;
  
  FreeAndNilPrinters;
  inherited;
end;

procedure TdxPrintDevice.Abort;
begin
  CheckPrinting(True);
  AbortDoc(Canvas.Handle);
  FAborted := True;
  EndDoc;
end;

function TdxPrintDevice.BeginDoc: Integer;
var
  DocInfo: TDocInfo;
begin
  Application.ProcessMessages;
 {$IFDEF DEBUG_PRINTDEVICE}
  RewriteLog;
  WriteLog('BeginDoc');
 {$ENDIF}  
  CheckPrinting(False);
  SetState(psNoHandle);
  SetState(psHandleDC);
  Canvas.Refresh;
  TdxPrintDeviceCanvas(Canvas).UpdateFont;
  FPrinting := True;
  FAborted := False;
  FPageNumber := 1;
  
  FillChar(DocInfo, SizeOf(DocInfo), 0);
  with DocInfo do
  begin
    cbSize := SizeOf(DocInfo);
    if Title <> '' then
      lpszDocName := PChar(Title)
    else
      lpszDocName := PChar('Document');
    if FileName <> '' then lpszOutput := PChar(FileName);
  end;
  SetAbortProc(FDC, AbortProc);
  Result := StartDoc(FDC, DocInfo);
  if Result > 0 then
    StartPage(FDC)
  else
  begin
    FPrinting := False;
    FAborted := False;
    SetState(psNoHandle);
    FPageNumber := 0;
  end;
end;

procedure TdxPrintDevice.EndDoc;
begin
{$IFDEF DEBUG_PRINTDEVICE}
  WriteLog('EndDoc');
{$ENDIF}
  CheckPrinting(True);
//  EndPage(FDC);
  if not Aborted then Windows.EndDoc(FDC);
  FPrinting := False;
  FAborted := False;
  SetState(psNoHandle);
  FPageNumber := 0;
end;

procedure TdxPrintDevice.NewPage;
begin
{$IFDEF DEBUG_PRINTDEVICE}
  WriteLog('NewPage');
{$ENDIF}
  CheckPrinting(True);
  EndPage(FDC);
  Inc(FPageNumber);
  Application.ProcessMessages;
  DoNewPage;
  ResetDC(False);
  StartPage(FDC);
  Canvas.Refresh;
end;

function TdxPrintDevice.FindPrintDevice(ADevice, APort:  PChar ): Integer;
begin
  for Result := 0 to Printers.Count - 1 do
    if PrinterInfos[Result].IsEqual(nil, ADevice, APort) then Exit;
  Result := -1;
end;

function TdxPrintDevice.IsDeviceModeChanged: Boolean;
begin
  Result := FDeviceModeChanged;
end;

procedure TdxPrintDevice.Refresh;
var
  ADevice, APort:  PChar ;
  APrinterIndex: Integer;
  AHDeviceMode: THandle;
begin
  ADevice := StrNew(FCurrentDevice);
  try
    APort := StrNew(FCurrentPort);
    try
      AHDeviceMode := 0;
      if FHDeviceMode <> 0 then AHDeviceMode := CopyDeviceMode(FHDeviceMode);
      try
        ClosePrintDevice;
        FreeAndNilPrinters;
        GetPrinters;
        if AHDeviceMode <> 0 then
        begin
          APrinterIndex := FindPrintDevice(ADevice, APort);
          if APrinterIndex <> -1 then
          begin
            OpenPrintDevice(APrinterIndex);
            if FHDeviceMode <> 0 then
            begin
              while GlobalUnLock(FHDeviceMode) do;
              GlobalFree(FHDeviceMode);
              FDeviceMode := nil;
              FHDeviceMode := CopyDeviceMode(AHDeviceMode);
              FDeviceMode := GlobalLock(FHDeviceMode);
            end;
          end
          else 
            if Printers.Count > 0 then GetPrinterIndex;
        end;
      finally
        if AHDeviceMode <> 0 then GlobalFree(AHDeviceMode);
      end;
    finally
      StrDispose(APort);
    end;
  finally
    StrDispose(ADevice);
  end;
  DoRefresh;
end;

procedure TdxPrintDevice.ResetDC(IsForced: Boolean);
var
  ACanvas: TCanvas;
  ABrushBitmap: TBitmap;

  procedure SaveCanvas;
  begin
    ACanvas := TdxPrintDeviceCanvas.Create(Self);
    with ACanvas do
    begin
      OnChanging := Canvas.OnChanging;
      OnChange := Canvas.OnChange;
      Canvas.OnChanging := nil;
      Canvas.OnChange := nil;

      Brush := Canvas.Brush;
      ABrushBitmap := nil;
      if Brush.Bitmap <> nil then ABrushBitmap := Brush.Bitmap;
      Font := Canvas.Font;
      Pen := Canvas.Pen;
      PenPos := Canvas.PenPos;
      CopyMode := Canvas.CopyMode;
    end;
  end;

  procedure RestoreCanvas;
  begin
    with Canvas do
    begin
      Brush := ACanvas.Brush;
      if ABrushBitmap <> nil then Brush.Bitmap := ABrushBitmap;
      Font := ACanvas.Font;
      Pen := ACanvas.Pen;
      PenPos := ACanvas.PenPos;
      CopyMode := ACanvas.CopyMode;
      OnChanging := ACanvas.OnChanging;
      OnChange := ACanvas.OnChange;
    end;
    ACanvas.Free;
  end;
  
begin
  if IsDeviceModeChanged or IsForced then
  begin
    FDeviceModeChanged := False;
    SaveCanvas;
    try
      if FDeviceMode <> nil then 
        Windows.ResetDC(FDC, FDeviceMode^);
    finally
      RestoreCanvas;
    end;
  end;
end;

procedure TdxPrintDevice.ResetPrintDevice;
var
  Index: Integer;
begin
  Index := PrinterIndex;
  ClosePrintDevice;
  OpenPrintDevice(Index);
end;

function TdxPrintDevice.FindBin(ABin: Integer): Integer;
begin
  if Bins <> nil then 
    Result := Bins.IndexOfObject(TObject(ABin))
  else
    Result := -1;  
end;

function TdxPrintDevice.FindBin(const AName: string): Integer;
begin
  if Bins <> nil then 
    Result := Bins.IndexOf(AName)
  else
    Result := -1;  
end;

function TdxPrintDevice.IsAutoSelectBin(AIndex: Integer): Boolean;
begin
  Result := (Bins <> nil) and (AIndex > -1) and (AIndex < Bins.Count) and
    dxIsAutoSelectBin(Bins[AIndex]);
end;

function TdxPrintDevice.IsUserPaperSource(AIndex: Integer): Boolean;
begin
  Result := (Bins <> nil) and (AIndex > -1) and (AIndex < Bins.Count) and
    (Integer(Papers.Objects[AIndex]) >= DMBIN_USER);
end;

function TdxPrintDevice.SelectBin(Value: Integer): Boolean;
var
  Index: Integer;
begin
  Index := FindBin(Value);
  Result := Index > -1;
  if Result then BinIndex := Index;
end;

function TdxPrintDevice.SelectBin(const AName: string): Boolean;
var
  Index: Integer;
begin
  Index := FindBin(AName);
  Result := Index > -1;
  if Result then BinIndex := Index;
end;

function TdxPrintDevice.FindPaper(ADMPaper: Integer): Integer;
begin
  if Papers <> nil then
    for Result := 0 to Papers.Count - 1 do
      if TdxPaperInfo(Papers.Objects[Result]).DMPaper = ADMPaper then
        Exit;
  Result := -1;
end;

function TdxPrintDevice.FindPaper(const AName: string): Integer;
begin
  if Papers <> nil then
    Result := Papers.IndexOf(AName)
  else
    Result := -1;  
end;

function TdxPrintDevice.FindPaper(const ASize: TPoint): Integer;
begin
  if Papers <> nil then
  begin
    for Result := 0 to Papers.Count - 1 do
      if dxPSUtl.ArePointsEqual(TdxPaperInfo(Papers.Objects[Result]).Size, ASize) then
        Exit;
    Result := Papers.Count - 1;
  end
  else
    Result := -1;
end;

function TdxPrintDevice.FindPaper(AWidth, AHeight: Integer): Integer;
begin
  Result := FindPaper(MakePoint(AWidth, AHeight));
end;

function TdxPrintDevice.IsEnvelopePaper(AIndex: Integer): Boolean;
begin
  Result := (Papers <> nil) and (AIndex > -1) and (AIndex < Papers.Count) and
    dxIsEnvelopePaper(Papers[AIndex]);
end;

function TdxPrintDevice.IsUserPaperSize(AIndex: Integer): Boolean;
var
  PaperInfo: TdxPaperInfo;
begin
  Result := (Papers <> nil) and (AIndex > -1) and (AIndex < Papers.Count);
  if Result then
  begin
    PaperInfo := TdxPaperInfo(Papers.Objects[AIndex]);
    Result := (PaperInfo.DMPaper >= DMPAPER_USER) or 
      (Pos(cxGetResourceString(@sdxCustom), PaperInfo.Name) > 0);
  end;  
end;

function TdxPrintDevice.SelectPaper(ADMPaper: Integer): Boolean;
var
  Index: Integer;
begin
  Index := FindPaper(ADMPaper);
  Result := Index > -1;
  if Result then PaperIndex := Index;
end;

function TdxPrintDevice.SelectPaper(const AName: string): Boolean;
var
  Index: Integer;
begin
  Index := FindPaper(AName);
  Result := Index > -1;
  if Result then PaperIndex := Index;
end;

function TdxPrintDevice.SelectPaper(var AWidth, AHeight: Integer): Boolean;
var
  Index: Integer;
begin
  Index := FindPaper(AWidth, AHeight);
  Result := Index > -1;
  if Result then 
  begin
    PaperIndex := Index; // setting FDeviceModeChanged := True;
    if FDeviceMode <> nil then 
      if PaperIndex <> Papers.Count - 1 then 
      begin
        DeviceMode^.dmPaperWidth := 0;
        DeviceMode^.dmPaperLength := 0;
      end
      else
        InternalSelectPaperBySize(AWidth, AHeight)
  end;  
end;

function TdxPrintDevice.IsSupportColoration: Boolean;
begin
  Result := 1 = WinSpool.DeviceCapabilities(CurrentDevice, CurrentPort, DC_COLORDEVICE, nil, nil);
end;

function TdxPrintDevice.IsSupportDuplex: Boolean;
begin
  Result := 1 = WinSpool.DeviceCapabilities(CurrentDevice, CurrentPort, DC_DUPLEX, nil, nil);
end;

procedure TdxPrintDevice.DoNewPage;
begin
  if Assigned(FOnNewPage) then FOnNewPage(Self)
end;

procedure TdxPrintDevice.DoPrinterChanged;
begin
  if Assigned(FOnPrinterChange) then FOnPrinterChange(Self);
end;

procedure TdxPrintDevice.DoRefresh;
begin
  if Assigned(FOnRefresh) then FOnRefresh(Self);
end;

function TdxPrintDevice.GetBinIndex: Integer;
begin
  if FDeviceMode <> nil then
  begin
    Result := FindBin(FDeviceMode^.dmDefaultSource);
    if (Result = -1) and (FBins <> nil) and (FBins.Count <> 0) then 
      Result := 0;
  end  
  else
    Result := 0;
end;

function TdxPrintDevice.GetBins: TStrings;
const
  BinSize = SizeOf(Word);
  BinNameSize = 24;
type
  TdxBin = Word;
  TdxBins = array[0..0] of TdxBin;
  PdxBins = ^TdxBins;
  TdxBinName = array[0..BinNameSize - 1] of Char;
  TdxBinNames = array[0..0] of TdxBinName;
  PdxBinNames = ^TdxBinNames;
var
  BinCount: Integer;
  BinValues:  PdxBins ;
  BinNames:  PdxBinNames ;
  I: Integer;
  BinName: string;
begin
  if FBins = nil then
  try
    if Printers.Count > 0 then
    begin
      GetPrinterIndex;
      if FDeviceMode = nil then
      begin
        Result := nil;
        Exit;
      end;
      BinCount := DeviceCapabilities(CurrentDevice, CurrentPort, DC_BINS, nil, nil);
      if BinCount > 0 then
      begin
        BinValues := AllocMem(BinSize * BinCount * SizeOf(Char));
        try
          if DeviceCapabilities(CurrentDevice, CurrentPort, DC_BINS, PChar(BinValues), nil) <> -1 then
          begin
            BinNames := AllocMem(BinNameSize * BinCount * SizeOf(Char));
            try
              if DeviceCapabilities(CurrentDevice, CurrentPort, DC_BINNAMES, PChar(BinNames), nil) <> -1 then
              begin
                FBins := TStringList.Create;
                for I := 0 to BinCount - 1 do
                begin
                  BinName := BinNames^[I]; 
                  FBins.AddObject(BinName, TObject(BinValues^[I]));
                end;  
              end;
            finally
              FreeMem(BinNames);
            end;
          end;
        finally
          FreeMem(BinValues);
        end;
      end;
    end
    else
    begin
      FBins := TStringList.Create;
      FBins.AddObject(cxGetResourceString(@sdxDefaultTray), TObject(DMBIN_USER));
    end;
  except
    FreeAndNil(FBins);
    raise;
  end;
  Result := FBins;
end;

function TdxPrintDevice.GetCanvas: TCanvas;
begin
  if FCanvas = nil then FCanvas := TdxPrintDeviceCanvas.Create(Self);
  Result := FCanvas;
end;

function TdxPrintDevice.GetCollate: Boolean;
const
  CollationMap: array[DMCOLLATE_FALSE..DMCOLLATE_TRUE] of Boolean = (False, True);
begin
  Result := False;
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
        Result := CollationMap[FDeviceMode^.dmCollate];
  end;    
end;

function TdxPrintDevice.GetColorMode: Boolean;
begin
  Result := False;
  if Printers.Count > 0 then
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
        Result := FDeviceMode^.dmColor = DMCOLOR_COLOR;
  end;
end;

function TdxPrintDevice.GetCurrentDevice:  PChar ;
begin
  Result := nil;
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FHDeviceMode <> 0 then 
      Result := FCurrentDevice;
  end;    
end;

function TdxPrintDevice.GetCurrentDriver:  PChar ;
begin
  Result := nil;
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FHDeviceMode <> 0 then 
      Result := FCurrentDriver;
  end;    
end;

function TdxPrintDevice.GetCurrentPort:  PChar ;
begin
  Result := nil;
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FHDeviceMode <> 0 then 
      Result := FCurrentPort;
  end;    
end;

function TdxPrintDevice.GetDefaultDMPaper: Integer;
begin
  if Printers.Count > 0 then
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
      Result := DeviceMode^.dmPaperSize
    else
      Result := Windows.DMPAPER_FIRST;
  end
  else
    Result := Windows.DMPAPER_FIRST;
end;

function TdxPrintDevice.GetDeviceMode: PDeviceMode;
begin
  if Printers.Count > 0 then
  begin
    GetPrinterIndex;
    Result := FDeviceMode;
  end
  else
    Result := nil;
end;

function TdxPrintDevice.GetDuplex: TdxDuplexMode;
begin
  Result := dmSimplex;
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
      Result := DuplexModeMap[DeviceMode^.dmDuplex];
  end;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: DWORD; Data: LPARAM): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

function TdxPrintDevice.GetFonts: TStrings;
begin
  if FFonts = nil then
  try
    SetState(psHandleIC);
    FFonts := TStringList.Create;
    EnumFonts(FDC, nil, @EnumFontsProc, Pointer(FFonts));
  except
    FreeAndNil(FFonts);
    raise;                    
  end;
  Result := FFonts;
end;

function TdxPrintDevice.GetHandle: HDC;
begin
  SetState(psHandleIC);
  Result := FDC;
end;

function TdxPrintDevice.GetHDeviceMode: THandle;
begin
  if Printers.Count > 0 then
  begin
    GetPrinterIndex;
    Result := FHDeviceMode;
  end
  else
    Result := 0;
end;

function TdxPrintDevice.GetIsDefault: Boolean;
begin
  if PrinterIndex <> -1 then
    Result := PrinterInfos[PrinterIndex].IsDefault
  else
    Result := False;
end;

function TdxPrintDevice.GetIsInitialized: Boolean;
begin
  Result := FPrinters <> nil;
end;

function TdxPrintDevice.GetIsNetwork: Boolean;
begin
  if PrinterIndex <> -1 then 
    Result := PrinterInfos[PrinterIndex].IsNetwork
  else
    Result := False;
end;

function TdxPrintDevice.GetMaxExtents(Index: Integer): Integer;
begin
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if Index = 0 then
      Result := LOWORD(FMaxExtents)
    else
      Result := HIWORD(FMaxExtents);
  end
  else
    Result := dxDefaultMaxPaperExtents;
end;

function TdxPrintDevice.GetMinExtents(Index: Integer): Integer;
begin
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if Index = 0 then
      Result := LOWORD(FMinExtents)
    else
      Result := HIWORD(FMinExtents);
  end
  else
    Result := dxDefaultMinPaperExtents;
end;

function TdxPrintDevice.GetNumCopies: Integer;
begin
  Result := 0;
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then 
      Result := FDeviceMode^.dmCopies;
  end;    
end;

function TdxPrintDevice.GetOrientation: TdxPrinterOrientation;
begin
  Result := poPortrait;
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
    if FDeviceMode^.dmOrientation = DMORIENT_LANDSCAPE then
      Result := poLandscape;
  end;
end;

function TdxPrintDevice.GetPageHeight: Integer;
begin
  SetState(psHandleIC);
  Result := GetDeviceCaps(FDC, VertRes);
end;

function TdxPrintDevice.GetPageHeightLoMetric: Integer;
begin
  SetState(psHandleIC);
  Result := 10 * GetDeviceCaps(FDC, VertSize);
end;

function TdxPrintDevice.GetPageWidth: Integer;
begin
  SetState(psHandleIC);
  Result := GetDeviceCaps(FDC, HorzRes);
end;

function TdxPrintDevice.GetPageWidthLoMetric: Integer;
begin
  SetState(psHandleIC);
  Result := 10 * GetDeviceCaps(FDC, HorzSize);
end;

function TdxPrintDevice.GetPaperCount: Integer;
begin
  if FPapers <> nil then
    Result := FPapers.Count
  else
    Result := 0;
end;
    
function TdxPrintDevice.GetPaperIndex: Integer;
begin
  if FDeviceMode <> nil then
  begin
    Result := FindPaper(FDeviceMode^.dmPaperSize);
    if (Result = -1) and (FPapers <> nil) and (FPapers.Count > 0) then 
      Result := 0;    
  end  
  else
    Result := 0;
end;

function TdxPrintDevice.GetPapers: TStrings;
const
  PaperNameSize = 64;
  PaperValueSize = SizeOf(Word);
  PaperSizeSize = SizeOf(TPoint);
type
  TdxPaperSize = TPoint;
  TdxPaperSizes = array[0..0] of TdxPaperSize;
  PdxPaperSizes = ^TdxPaperSizes;
  TdxPaperValue = Word;
  TdxPaperValues = array[0..0] of TdxPaperValue;
  PdxPaperValues = ^TdxPaperValues;
  TdxPaperName = array[0..PaperNameSize - 1] of Char;
  TdxPaperNames = array[0..0] of TdxPaperName;
  PdxPaperNames = ^TdxPaperNames;
var
  HasStandardPapers: Boolean;
  PaperCount: Integer;
  PaperNames:  PdxPaperNames ;
  PaperValues:  PdxPaperValues ;
  PaperSizes:  PdxPaperSizes ;
  I: Integer;
  Paper: TdxPaperInfo;
begin
  if FPapers = nil then
  try
    HasStandardPapers := False;
    if Printers.Count > 0 then
    begin
      GetPrinterIndex;
      if DeviceMode = nil then
      begin
        Result := nil;
        Exit;
      end;
      if FPapers <> nil then
      begin
        Result := FPapers;
        Exit;
      end; 
      PaperCount := DeviceCapabilities(CurrentDevice, CurrentPort, DC_PAPERNAMES, nil, nil);
      if PaperCount > 0 then
      begin
        PaperNames := AllocMem(PaperNameSize * PaperCount * SizeOf(Char));
        try
          if DeviceCapabilities(CurrentDevice, CurrentPort, DC_PAPERNAMES, PChar(PaperNames), nil) <> -1 then
          begin
            PaperValues := AllocMem(PaperValueSize * PaperCount);
            try
              if DeviceCapabilities(CurrentDevice, CurrentPort, DC_PAPERS, PChar(PaperValues), nil) <> -1 then
              begin
                PaperSizes := AllocMem(PaperSizeSize * PaperCount);
                try
                  if DeviceCapabilities(CurrentDevice, CurrentPort, DC_PAPERSIZE, PChar(PaperSizes), nil) <> -1 then
                  begin
                    HasStandardPapers := True;
                    FPapers := TStringList.Create;
                    for I := 0 to PaperCount - 1 do
                    begin
                      Paper := TdxPaperInfo.Create(Self);
                      with Paper do
                      begin
                        FSize := PaperSizes^[I];
                        FDMPaper := PaperValues^[I];
                        FName := PaperNames^[I];
                      end;
                      FPapers.AddObject(Paper.Name, Paper);
                    end;
                    if Pos(cxGetResourceString(@sdxCustom), FPapers[PaperCount - 1]) = 0 then
                    begin
                      Paper := TdxPaperInfo.Create(Self);
                      with Paper do
                      begin
                        FSize := TdxPaperInfo(FPapers.Objects[0]).Size;
                        FDMPaper := DMPAPER_USER;
                        FName := cxGetResourceString(@sdxCustomSize);
                      end;
                      FPapers.AddObject(Paper.Name, Paper);
                    end;
                  end;
                finally
                  FreeMem(PaperSizes);
                end;
              end;
            finally
              FreeMem(PaperValues);
            end;
          end;
        finally
          FreeMem(PaperNames);
        end;
      end;
    end;

    if not HasStandardPapers then
    begin
      FPapers := TStringList.Create;
      Paper := TdxPaperInfo.Create(Self);
      with Paper do
      begin
        FSize := Point(2100, 2970); {A4} // TODO: use default locale paper
        FDMPaper := DMPAPER_USER;
        FName := cxGetResourceString(@sdxCustomSize);
      end;
      FPapers.AddObject(Paper.Name, Paper);
    end;
  except
    FreeAndNil(FPapers);
    raise;
  end;
  Result := FPapers;
end;

function TdxPrintDevice.GetPhysOffset(Index: Integer): Integer;
const
  PhysicalOffsets: array[0..1] of Integer = (PHYSICALOFFSETX, PHYSICALOFFSETY);
begin
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    try
      Result := GetDeviceCaps(Handle, PhysicalOffsets[Index]);
    except
      Result := 0;
    end;  
  end
  else
    Result := 0;
end;

function TdxPrintDevice.GetPrinterCount: Integer;
begin
  if FPrinters <> nil then
    Result := FPrinters.Count
  else 
    Result := 0;
end;

function TdxPrintDevice.GetPrinterIndex: Integer;
begin
  if FPrinterIndex = -MaxInt then SetToDefaultPrintDevice;
  Result := FPrinterIndex;
end;

function TdxPrintDevice.GetPrinterInfo(Index: Integer): TdxPrintDeviceInfo;
begin
  if (FPrinters <> nil) and (Index >= 0) and (Index < FPrinters.Count)  then
    Result := TdxPrintDeviceInfo(FPrinters.Objects[Index])
  else
    Result := nil;  
end;

function TdxPrintDevice.GetPrinters: TStrings;

  function IsDefaultDevice(AnAttributes: DWORD): Boolean;
  begin
    Result := AnAttributes and PRINTER_ATTRIBUTE_DEFAULT = PRINTER_ATTRIBUTE_DEFAULT;
  end;

  function IsNetworkDevice(AnAttributes: DWORD): Boolean;
  begin
    Result := AnAttributes and PRINTER_ATTRIBUTE_NETWORK = PRINTER_ATTRIBUTE_NETWORK; 
  end;
  

  procedure GetAsPrinterInfo4(var AnOffset: Integer; ABuffer: PChar);
  var
    PrintDeviceInfo: TdxPrintDeviceInfo;
  begin
    Inc(PByte(ABuffer), AnOffset);
    with PPrinterInfo4(ABuffer)^ do
    begin
      PrintDeviceInfo := TdxPrintDeviceInfo.Create('', pPrinterName, '', dxIsDefaultPrinter(pPrinterName), IsNetworkDevice(Attributes));
      FPrinters.AddObject(pPrinterName, PrintDeviceInfo);
    end;
    Inc(AnOffset, SizeOf(TPrinterInfo4));
  end;

  procedure GetAsPrinterInfo5(var AnOffset: Integer; ABuffer: PChar);
  var
    LineCur, PortName: PChar;
    PrintDeviceTitle: string;
    PrintDeviceInfo: TdxPrintDeviceInfo;
  begin
    Inc(PByte(ABuffer), AnOffset);
    with PPrinterInfo5(ABuffer)^ do 
    begin
      LineCur := pPortName;
      PortName := FetchStr(LineCur);
      while PortName^ <> #0 do
      begin
        PrintDeviceTitle := Format(cxGetResourceString(@sdxDeviceOnPort), [pPrinterName, PortName]);
        PrintDeviceInfo := TdxPrintDeviceInfo.Create(nil, pPrinterName, PortName, dxIsDefaultPrinter(pPrinterName), IsNetworkDevice(Attributes));
        FPrinters.AddObject(PrintDeviceTitle, PrintDeviceInfo);
        PortName := FetchStr(LineCur);
      end;
    end;
    Inc(AnOffset, SizeOf(TPrinterInfo5));
  end;

const
  Levels: array[Boolean] of DWORD = (5, 4);
  Flags: array[Boolean] of DWORD = (PRINTER_ENUM_LOCAL, PRINTER_ENUM_CONNECTIONS or PRINTER_ENUM_LOCAL);
var
  Level, Flag, Count, NumInfo: DWORD;
  Buffer: Pointer;
  Offset, I: Integer;
begin
  if FPrinters = nil then
  begin
    FPrinters := TStringList.Create;
    try
      Level := Levels[IsWinNT];
      Flag := Flags[IsWinNT];
      Count := 0;
      EnumPrinters(Flag, nil, Level, nil, 0, Count, NumInfo);
      if Count <> 0 then
      begin
        Buffer := dxAllocMem(Count);
        try
          if EnumPrinters(Flag, nil, Level, Buffer, Count, Count, NumInfo) then
          begin
            Offset := 0;
            for I := 0 to NumInfo - 1 do
              if Level = 4 then
                GetAsPrinterInfo4(Offset, Buffer)
              else
                GetAsPrinterInfo5(Offset, Buffer);
          end;
        finally
          dxFreeMem(Buffer, Count);
        end;
      end;
    except
      FreeAndNil(FPrinters);
      raise;
    end;
  end;
  Result := FPrinters;
end;

procedure TdxPrintDevice.SetBinIndex(Value: Integer);
begin
  if (FDeviceMode <> nil) and (Bins <> nil) and (Value > -1) and (Value < Bins.Count) then
  begin
    if FDeviceMode^.dmDefaultSource <> Value then
    begin
      FDeviceMode^.dmDefaultSource := Integer(Bins.Objects[Value]);
      FDeviceMode^.dmFields := FDeviceMode^.dmFields or DM_DEFAULTSOURCE;
      FDeviceModeChanged := True;
    end;
  end;  
end;

procedure TdxPrintDevice.SetCollate(Value: Boolean);
const
  Collations: array[Boolean] of ShortInt = (DMCOLLATE_FALSE, DMCOLLATE_TRUE);
begin
  //CheckPrinting(False);
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
    begin
      FDeviceMode^.dmCollate := Collations[Value];
      FDeviceMode^.dmFields := FDeviceMode^.dmFields or DM_COLLATE;      
      FDeviceModeChanged := True;
    end;
  end;  
end;

procedure TdxPrintDevice.SetColorMode(Value: Boolean);
const
  ColorModes: array[Boolean] of ShortInt = (DMCOLOR_MONOCHROME, DMCOLOR_COLOR);
begin
  //CheckPrinting(False);
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
    begin
      FDeviceMode^.dmColor := ColorModes[Value];
      FDeviceMode^.dmFields := FDeviceMode^.dmFields or DM_COLOR;      
      FDeviceModeChanged := True;
    end;
  end;  
end;

procedure TdxPrintDevice.SetDuplex(Value: TdxDuplexMode);
const
  DuplexModeMap: array[TdxDuplexMode] of UINT = (DMDUP_SIMPLEX, DMDUP_VERTICAL, DMDUP_HORIZONTAL);
begin
  //CheckPrinting(False);
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if (FDeviceMode <> nil) and IsSupportDuplex then
    begin
      FDeviceMode^.dmDuplex := DuplexModeMap[Value];
      FDeviceMode^.dmFields := FDeviceMode^.dmFields or DM_DUPLEX;
      FDeviceModeChanged := True;
    end;
  end;    
end;

procedure TdxPrintDevice.SetIsDefault(Value: Boolean);
var
  I: Integer;
begin
  if (PrinterIndex <> -1) and (IsDefault <> Value) then
  begin 
    for I := 0 to Printers.Count - 1 do
      PrinterInfos[I].IsDefault := False;
    dxSetDefaultPrinter(CurrentDevice);
  end  
end;

procedure TdxPrintDevice.SetNumCopies(Value: Integer);
begin
  CheckPrinting(False);
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
    begin
      FDeviceMode^.dmCopies := Value;
      FDeviceMode^.dmFields := FDeviceMode^.dmFields or DM_COPIES;
      FDeviceModeChanged := True;
    end;
  end;  
end;

procedure TdxPrintDevice.SetOrientation(Value: TdxPrinterOrientation);
begin
  //CheckPrinting(False);
  if Printers.Count > 0 then 
  begin
    GetPrinterIndex;
    if FDeviceMode <> nil then
    begin
      FDeviceMode^.dmOrientation := PrinterOrientationMap[Value];
      FDeviceMode^.dmFields := FDeviceMode^.dmFields or DM_ORIENTATION;
      FDeviceModeChanged := True;
    end;
  end;  
end;

procedure TdxPrintDevice.SetPaperIndex(Value: Integer);
begin
  if (FDeviceMode <> nil) and (Papers <> nil) and (Value > -1) and (Value < Papers.Count) then
  begin
    FDeviceMode^.dmPaperSize := TdxPaperInfo(Papers.Objects[Value]).DMPaper;
    FDeviceMode^.dmFields := FDeviceMode^.dmFields or DM_PAPERSIZE;
    if Value = Papers.Count - 1 then
      FDeviceMode^.dmFields := FDeviceMode^.dmFields or DM_PAPERWIDTH or DM_PAPERLENGTH;
    FDeviceModeChanged := True;
  end;
end;

procedure TdxPrintDevice.SetPrinterCapabilities(Value: Integer);
begin
  FCapabilities := [];
  if Value and DM_ORIENTATION <> 0 then Include(FCapabilities, pcOrientation);
  if Value and DM_COPIES <> 0 then Include(FCapabilities, pcCopies);
  if Value and DM_COLLATE <> 0 then Include(FCapabilities, pcCollation);
//  if Value and DM_DUPLEX <> 0 then Include(FCapabilities, pcDuplex);
//  if Value and DM_COLLATE <> 0 then Include(FCapabilities, pcColor);
end;

procedure TdxPrintDevice.SetPrinterIndex(Value: Integer);
begin
  CheckPrinting(False);
  if (Value < -1) or (Value >= Printers.Count) then
    RaiseError(cxGetResourceString(@sdxPrinterIndexError))
  else 
    if Value = -1 then
    begin
      FPrinterIndex := -MaxInt;
      GetPrinterIndex;
    end
    else
      OpenPrintDevice(Value);
  SetState(psNoHandle);
end;

procedure TdxPrintDevice.CheckPrinting(Value: Boolean);
begin
  if Printing <> Value then
    if Value then
      RaiseError(cxGetResourceString(@sdxNotPrinting))
    else
      RaiseError(cxGetResourceString(@sdxPrinting));
end;

procedure TdxPrintDevice.ClosePrintDevice;
begin
  StrDispose(FCurrentDevice);
  FCurrentDevice := nil;
  StrDispose(FCurrentDriver);
  FCurrentDriver := nil;
  StrDispose(FCurrentPort);
  FCurrentPort := nil;
 
  FreeAndNilBins;
  FreeAndNilFonts;
  FreeAndNilPapers;

  if FHDeviceMode <> 0 then
  begin
    while GlobalUnlock(FHDeviceMode) do;
    GlobalFree(FHDeviceMode);
    //Marshal.DestroyStructure(DeviceMode, TypeOf(TDeviceMode));
    FHDeviceMode := 0;
    FDeviceMode := nil;
  end;

  if FDeviceHandle <> 0 then
  begin
    ClosePrinter(FDeviceHandle);
    FDeviceHandle := 0;
  end;

  SetState(psNoHandle);
  FreeAndNilCanvas;

  FPrinterIndex := -MaxInt;
end;

procedure TdxPrintDevice.DeselectHandles;
begin
  if FDC <> 0 then
  begin
    SelectObject(FDC, GetStockObject(BLACK_PEN));
    SelectObject(FDC, GetStockObject(HOLLOW_BRUSH));
    SelectObject(FDC, GetStockObject(SYSTEM_FONT));
  end;
end;

procedure TdxPrintDevice.FixMinMaxExtents;
var
  I: Integer;
  MaxSize, MinSize, PaperSize: TPoint;
begin
  if (FMaxExtents = -1) or (FMaxExtents = 0) then
    FMaxExtents := SetLoHiWords(FMaxExtents, cMaxPaperExtent, cMaxPaperExtent);
  if (FMinExtents = -1) or (FMinExtents = 0) then
    FMinExtents := SetLoHiWords(FMinExtents, cMinPaperExtent, cMinPaperExtent);
  
  if Papers <> nil then 
  begin
    MaxSize := Point(LoWord(FMaxExtents), HiWord(FMaxExtents));
    MinSize := Point(LoWord(FMinExtents), HiWord(FMinExtents));

    for I := 0 to Papers.Count - 1 do
    begin
      PaperSize := TdxPaperInfo(Papers.Objects[I]).Size;
      if PaperSize.X < MinSize.X then MinSize.X := PaperSize.X;
      if PaperSize.X > MaxSize.X then MaxSize.X := PaperSize.X;
      if PaperSize.Y < MinSize.Y then MinSize.Y := PaperSize.Y;
      if PaperSize.Y > MaxSize.Y then MaxSize.Y := PaperSize.Y;
    end;

    if MinSize.X <> LoWord(FMinExtents) then
      FMinExtents := SetLoWord(FMinExtents, MinSize.X);
    if MinSize.Y <> HiWord(FMinExtents) then
      FMinExtents := SetHiWord(FMinExtents, MinSize.Y);
    if MaxSize.X <> LoWord(FMaxExtents) then
      FMaxExtents := SetLoWord(FMaxExtents, MaxSize.X);
    if MaxSize.Y <> HiWord(FMaxExtents) then
      FMaxExtents := SetHiWord(FMaxExtents, MaxSize.Y);
  end;

  if LoWord(FMinExtents) < 500 then
    FMinExtents := SetLoWord(FMinExtents, 500);
  if HiWord(FMinExtents) < 500 then
    FMinExtents := SetHiWord(FMinExtents, 500);
  if LoWord(FMaxExtents) < LoWord(FMinExtents) then
    FMaxExtents := SetLoWord(FMaxExtents, LoWord(FMinExtents));
  if HiWord(FMaxExtents) < HiWord(FMinExtents) then
    FMaxExtents := SetHiWord(FMaxExtents, HiWord(FMinExtents));
end;

procedure TdxPrintDevice.FreeAndNilBins;
begin
  FreeAndNil(FBins);
end;

procedure TdxPrintDevice.FreeAndNilFonts;
begin
  FreeAndNil(FFonts);
end;

procedure TdxPrintDevice.FreeAndNilCanvas;
begin
  FreeAndNil(FCanvas);
end;

procedure TdxPrintDevice.FreeAndNilPapers;
var
  I: Integer;
begin
  for I := 0 to PaperCount - 1 do
    FPapers.Objects[I].Free;
  FreeAndNil(FPapers);
end;

procedure TdxPrintDevice.FreeAndNilPrinters;
var
  I: Integer;
begin
  for I := 0 to PrinterCount - 1 do
    PrinterInfos[I].Free;
  FreeAndNil(FPrinters);  
end;

procedure TdxPrintDevice.InternalSelectPaperBySize(var AWidth, AHeight: Integer);
var
  DeviceMode: TDeviceMode;
begin
  if AWidth > MaxExtentX then AWidth := MaxExtentX;
  if AWidth < MinExtentX then AWidth := MinExtentX;
  if AHeight > MaxExtentY then AHeight := MaxExtentY;
  if AHeight < MinExtentY then AHeight := MinExtentY;

  if FDeviceMode <> nil then
  begin
    DeviceMode := FDeviceMode^;
    if DeviceMode.dmPaperWidth <> AWidth then
      TdxPaperInfo(Papers.Objects[Papers.Count - 1]).Width := AWidth;
    if DeviceMode.dmPaperLength <> AHeight then
      TdxPaperInfo(Papers.Objects[Papers.Count - 1]).Height := AHeight;
  end;    
end;

procedure TdxPrintDevice.OpenPrintDevice(AIndex: Integer);
const
  dmFields: UINT = DM_ORIENTATION or DM_PAPERSIZE or DM_PAPERLENGTH or
    DM_PAPERWIDTH or DM_SCALE or DM_COPIES or DM_DEFAULTSOURCE or DM_PRINTQUALITY or
    DM_COLOR or DM_DUPLEX or DM_YRESOLUTION or DM_TTOPTION or DM_COLLATE or
    DM_FORMNAME or DM_LOGPIXELS or DM_BITSPERPEL or DM_PELSWIDTH or DM_PELSHEIGHT;
var
  DeviceMode: TDeviceMode;
  MemSize: Integer;
  SaveHDeviceMode: THandle;
  SavePaperWidth, SavePaperHeight: Integer;

  procedure RestoreDeviceMode(ASaveHDeviceMode: THandle);
  var
    PDevMode:  Pointer ;
    DevMode: TDeviceMode;
  begin
    PDevMode := GlobalLock(ASaveHDeviceMode);  
    try
      DevMode := PDeviceMode(PDevMode)^;
      Copies := DevMode.dmCopies;
      Duplex := DuplexModeMap[DevMode.dmDuplex];
      Orientation := OrientationMap[DevMode.dmOrientation];
      if not SelectPaper(DevMode.dmPaperSize) then
        SelectPaper(SavePaperWidth, SavePaperHeight);
      SelectBin(DevMode.dmDefaultSource);
    finally
      GlobalUnlock(ASaveHDeviceMode);
    end;
  end;

begin
  if FPrinterIndex = AIndex then Exit;
  SaveHDeviceMode := 0;
  if IsDeviceModePersistent and (FHDeviceMode <> 0) then
  begin
    SaveHDeviceMode := CopyDeviceMode(FHDeviceMode);
    if (Papers <> nil) and (PaperIndex > -1) and (PaperIndex < Papers.Count) then
      with TdxPaperInfo(Papers.Objects[PaperIndex]) do
      begin
        SavePaperWidth := Width;
        SavePaperHeight := Height;
      end;
  end;
  
  try
    ClosePrintDevice;
    with PrinterInfos[AIndex] do
    begin
      FCurrentDevice := StrNew(FDevice);
      FCurrentDriver := StrNew(FDriver);
      FCurrentPort := StrNew(FPort);
    end;
    
    if OpenPrinter(FCurrentDevice, FDeviceHandle, nil) then
    begin
      MemSize := DocumentProperties(0, FDeviceHandle, FCurrentDevice, nil, nil, 0);
      if MemSize <= 0 then 
      begin
        ClosePrintDevice;      
        Exit;
      end;

      FHDeviceMode := GlobalAlloc(GHND, MemSize);
      if FHDeviceMode = 0 then 
      begin
        ClosePrintDevice;      
        Exit;
      end;
      
      FDeviceMode := GlobalLock(FHDeviceMode);
      FDeviceMode^.dmFields := dmFields;
      if IDOK <> DocumentProperties(0, FDeviceHandle, FCurrentDevice, FDeviceMode, nil, DM_OUT_BUFFER) then
      begin
        ClosePrintDevice;                        
        Exit;
      end;
      FPrinterIndex := AIndex;

      SetPrinterCapabilities(DeviceMode.dmFields);
      
      FMaxCopies := DeviceCapabilities(FCurrentDevice, FCurrentPort, DC_COPIES, nil, nil);
      FMaxExtents := DeviceCapabilities(FCurrentDevice, FCurrentPort, DC_MAXEXTENT, nil, nil);
      FMinExtents := DeviceCapabilities(FCurrentDevice, FCurrentPort, DC_MINEXTENT, nil, nil);
      FixMinMaxExtents;
        
      if IsDeviceModePersistent and (SaveHDeviceMode <> 0) then
        RestoreDeviceMode(SaveHDeviceMode);
      DoPrinterChanged;
    end;
  finally
    if SaveHDeviceMode <> 0 then GlobalFree(SaveHDeviceMode);
  end;
end;

procedure TdxPrintDevice.SetState(Value: TdxPrinterState);
type
  TCreateHandleFunc = function(DriverName, DeviceName, Output: PChar;
    InitData: PDeviceMode): HDC stdcall;
var
  CreateHandleFunc: TCreateHandleFunc;
begin
  if Value <> FState then
  begin
    CreateHandleFunc := nil;
    case Value of
      psNoHandle:
        begin
          CheckPrinting(False);
          if FCanvas <> nil then 
            FCanvas.Handle := 0;
          DeleteDC(FDC);
          FDC := 0;
        end;
      psHandleIC:
        if FState <> psHandleDC then
          CreateHandleFunc := CreateIC
        else
          Exit;
      psHandleDC:
        begin
          if FCanvas <> nil then FCanvas.Handle := 0;
          if FDC <> 0 then DeleteDC(FDC);
          CreateHandleFunc := CreateDC;
        end;
    end;
    if Assigned(CreateHandleFunc) and (PrinterIndex >= 0) and (PrinterIndex < PrinterCount) then
      with PrinterInfos[PrinterIndex] do
      begin
        FDC := CreateHandleFunc(Driver, Device, Port, FDeviceMode);
        if FDC = 0 then
          RaiseError(cxGetResourceString(@sdxInvalidPrintDevice));
        if FCanvas <> nil then
          FCanvas.Handle := FDC;
      end;                      
    FState := Value;
  end;
end;

procedure TdxPrintDevice.SetToDefaultPrintDevice;
var
  Device: string;
  Index: Integer;
begin
  Device := dxGetDefaultPrinter;
  if Device <> '' then
  begin
    Index := FindPrintDevice(PChar(Device), nil);
    if Index <> -1 then
    begin
      OpenPrintDevice(Index);
      Exit;
    end;
  end;
  RaiseError(cxGetResourceString(@sdxNoDefaultPrintDevice));
end;

procedure TdxPrintDevice.WndProc(var Message: TMessage);

  procedure PostPrnMessage;
  begin
    PostMessage(FWindowHandle, WMPS_PRINTERLISTCHANGED, 0, 0);
  end;

  function PeekPrnMessage(ARemove: Boolean): Boolean;
  const 
    RemoveMap: array[Boolean] of UINT = (PM_NOREMOVE, PM_REMOVE);
  var
    Msg: TMsg;
  begin
    Result := PeekMessage(Msg, FWindowHandle, WMPS_PRINTERLISTCHANGED, WMPS_PRINTERLISTCHANGED, RemoveMap[ARemove]);
  end;

begin
  with Message do 
  begin
    case Msg of 
      WM_SETTINGCHANGE:
        if AutoRefresh then PostPrnMessage;
          
      WMPS_PRINTERLISTCHANGED:
        if AutoRefresh then
          if not FPrinting then
          begin
            while PeekPrnMessage(True) do ;
            Refresh;
          end
          else
            if not PeekPrnMessage(False) then PostPrnMessage;
    end;  
    Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);    
  end;
end;

var 
  LibHandle: THandle = 0;
  
procedure InitializeProcs;
begin
  LibHandle := LoadLibrary(winspl);
  if LibHandle > HINSTANCE_ERROR then 
  begin
    @FConnectToPrinterDlg := GetProcAddress(LibHandle, 'ConnectToPrinterDlg');
    @FGetDefaultPrinter := GetProcAddress(LibHandle, 'GetDefaultPrinterA');
    @FSetDefaultPrinter := GetProcAddress(LibHandle, 'SetDefaultPrinterA');
  end
  else
    LibHandle := 0;     
end;

procedure DeinitializeProcs;
begin
  if LibHandle <> 0 then 
  begin
    @FConnectToPrinterDlg := nil;
    @FGetDefaultPrinter := nil;
    @FSetDefaultPrinter := nil;
    FreeLibrary(LibHandle);
    LibHandle := 0;
  end;
end;

initialization           
  InitializeProcs;

 {$IFDEF DEBUG_PRINTDEVICE}
  AssignFile(LogFile, 'PrinterLog.txt');
  Rewrite(LogFile);
 {$ENDIF}
  
finalization
 {$IFDEF DEBUG_PRINTDEVICE}
  CloseFile(LogFile);
 {$ENDIF}  

  FreeAndNil(FPrintDevice);
  DeinitializeProcs;
  
end.
