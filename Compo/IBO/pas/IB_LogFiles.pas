
{                                                                              }
{    IB_LogFiles                                                               }
{                                                                              }

{***************************************************************}
{                                                               }
{          IB Objects Components and Resources Library          }
{                                                               }
{          Copyright (C) 1996-2001 Jason Wharton                }
{          and Computer Programming Solutions, Mesa, AZ         }
{                                                               }
{  This source code unit is released under the terms of the     }
{  CPS Trustware License.                                       }
{  It may be distributed or deployed as source code or in       }
{  compiled form only in compliance with the terms and          }
{  conditions of the CPS Trustware License which may be         )
{  examined at http://www.ibobjects.com/ibo_trustware.html      )
{                                                               }
{***************************************************************}

{******************************************************************************}
{  CONTRIBUTED MODIFICATIONS                                                   }
{  Additions or modifications listed below using format:                       }
{                                                                              }
{  Joe Citizen <joe@joecitizen.com>                                            }
{  mm/dd/yyyy                                                                  }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx                 }
{            Copyright (C) 2001 Joe Citizen                                    }
{                                                                              }
{------------------------------------------------------------------------------}
{  Place your credits and information in the top of the section                }
{  below with any other descriptions or explanations desired.                  }
{------------------------------------------------------------------------------}
{                                                                              }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_LogFiles;

interface

uses
  Windows, SysUtils, Classes, SyncObjs, Forms;
  
type
  TLogFile = class;
  
  TLogFiles = class
  private
    FLogDir: string;
    FLogExt: string;
    FLogFmt: string;
    FItemFmt: string;
    SL: TStringList;
    CS: TCriticalSection;
    FOnException: TNotifyEvent;
    function GetLogFile( const ASub: string ): TLogFile;
    procedure SetLogDir( const AValue: string );
    procedure SetLogExt( const AValue: string );
    procedure SetLogFmt( const AValue: string );
  protected
    property LogFiles[ const ASub: string ]: TLogFile read GetLogFile;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LogItem( const InTran: string; const Sub: string = '' );
    procedure ReleaseFiles;
    property LogDir: string read FLogDir write SetLogDir;
    property LogExt: string read FLogExt write SetLogExt;
    property LogFmt: string read FLogFmt write SetLogFmt;
    property ItemFmt: string read FItemFmt write FItemFmt;
    property OnException: TNotifyEvent read FOnException write FOnException;
  end;

  TLogFile = class
  private
    FLogFiles: TLogFiles;
    FFileName: string;
    FSub: string;
    FH: integer;
    function GetFileHandle: THandle;
  public
    constructor Create( ALogFiles: TLogFiles; const ASub: string );
    destructor Destroy; override;
    property FileHandle: THandle read GetFileHandle;
  end;

implementation

uses
  IB_Utils;

function FileOpenCreate( const FileName: string; Mode: LongWord ): integer;
const
  AccessMode: array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
begin
  Result := integer( CreateFile( PChar( FileName ),
                     AccessMode[Mode and 3],
                     ShareMode[(Mode and $F0) shr 4],
                     nil,
                     OPEN_ALWAYS,
                     FILE_ATTRIBUTE_NORMAL, 0 ));
end;

constructor TLogFile.Create( ALogFiles: TLogFiles; const ASub: string );
begin
  FH := -1;
  FSub := ASub;
  FLogFiles := ALogFiles;
  inherited Create;
end;

destructor TLogFile.Destroy;
begin
  if FH >= 0 then FileClose( FH );
  inherited Destroy;
end;

function TLogFile.GetFileHandle: THandle;
var
  tmpDate: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: word;
  NewFileName: string;
begin
  tmpDate := now;
  DecodeDate( tmpDate, Year, Month, Day );
  DecodeTime( tmpDate, Hour, Min, Sec, Msec );
  NewFileName := FormatDateTime( FLogFiles.FLogFmt, now );
  if FSub <> '' then
    NewFileName := NewFileName + '_' + FSub;
  NewFileName := FLogFiles.LogDir + NewFileName + '.' + FLogFiles.FLogExt;
  if ( NewFileName <> FFileName ) or ( FH < 0 ) then
  begin
    if FH >= 0 then FileClose( FH ); 
    FFileName := NewFileName;
    FH := FileOpenCreate( FFileName, fmOpenWrite or fmShareDenyWrite );
  end;
  FileSeek( FH, 0, soFromEnd );
  Result := FH; 
end;

constructor TLogFiles.Create;
begin
  CS := TCriticalSection.Create;
  FLogDir := '';
  FLogExt := 'log';
  FLogFmt := '"SVC"yyyymmddhh';
  FItemFmt := '[ddd hh:nn:ss]';
  SL := TStringList.Create;
  SL.Duplicates := dupError;
  inherited Create;
end;

destructor TLogFiles.Destroy;
begin
  ReleaseFiles;
  SL.Free;
  SL := nil;
  CS.Free;
  CS := nil;
  inherited Destroy;
end;

procedure TLogFiles.ReleaseFiles;
begin
  CS.Enter;
  try
    with SL do
      while Count > 0 do
      begin
        Objects[ 0 ].Free;
        Delete( 0 );
      end;
  finally
    CS.Leave;
  end;
end;

procedure TLogFiles.SetLogDir( const AValue: string );
begin
  if FLogDir <> AValue then
  begin
    ReleaseFiles;
    FLogDir := AValue;
  end;
end;

procedure TLogFiles.SetLogExt( const AValue: string );
begin
  if FLogExt <> AValue then
  begin
    ReleaseFiles;
    FLogExt := AValue;
  end;
end;

procedure TLogFiles.SetLogFmt( const AValue: string );
begin
  if FLogFmt <> AValue then
  begin
    ReleaseFiles;
    FLogFmt := AValue;
  end;
end;

function TLogFiles.GetLogFile( const ASub: string ): TLogFile;
var
  tmpInd: integer;
begin
  tmpInd := SL.IndexOf( ASub );
  if ( tmpInd < 0 ) or ( tmpInd >= SL.Count ) then
  begin
    Result := TLogFile.Create( Self, ASub );
    SL.AddObject( ASub, Result );
  end
  else
    Result := SL.Objects[ tmpInd ] as TLogFile;
end;

procedure TLogFiles.LogItem( const InTran: string; const Sub: string = '' );
var
  tmpStr: string;
begin
  CS.Enter;
  try
    try
      tmpStr := FormatDateTime( FItemFmt, now ) + InTran + #13#10;
      FileWrite( LogFiles[ Sub ].FileHandle, Pchar(tmpStr)^, Length( tmpStr ));
    except
      on E: Exception do
        if Assigned( FOnException ) then
          FOnException( E )
        else
          Application.HandleException( E );
    end;
  finally
    CS.Leave;
  end;
end;

end.
