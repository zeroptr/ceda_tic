{*******************************************************}
{                                                       }
{       TiOpenDialog Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iOpenDialog;{$endif}
{$ifdef iCLX}unit QiOpenDialog;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}CommDlg,  iGPFunctions;{$ENDIF}
  {$IFDEF iCLX}CommDlg, QiGPFunctions;{$ENDIF}

type
  TiOpenDialog = class(TComponent)
  private
    FFileName         : String;
    FFilter           : String;
    FDefaultExt       : String;
    FFileMustExist    : Boolean;
    FAllowMultiSelect : Boolean;
    FFiles            : TStrings;
    function ExtractFileName(P: PChar; var S: TFilename): PChar;
    procedure ExtractFileNames(P: PChar);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute : Boolean;
    property AllowMultiSelect : Boolean  read FAllowMultiSelect write FAllowMultiSelect;
    property Files            : TStrings read FFiles;
  published
    property FileName      : String  read FFileName      write FFileName;
    property Filter        : String  read FFilter        write FFilter;
    property DefaultExt    : String  read FDefaultExt    write FDefaultExt;
    property FileMustExist : Boolean read FFileMustExist write FFileMustExist;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiOpenDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFiles := TStringList.Create;
end;
//****************************************************************************************************************************************************
destructor TiOpenDialog.Destroy;
begin
  FFiles.Free;
  inherited;
end;
//****************************************************************************************************************************************************
function TiOpenDialog.Execute : Boolean;
var
  OpenFilenameRec : TOpenFilename;
  TempFileName    : String;
  TempFilter      : String;
  AParent         : TWinControl;

  function AllocFilterStr(const S: string): string;
  var
    P: PChar;
  begin
    Result := '' + #0;
    if S <> '' then
    begin
      Result := S + #0;  // double null terminators
      P := AnsiStrScan(PChar(Result), '|');
      while P <> nil do
      begin
        P^ := #0;
        Inc(P);
        P := AnsiStrScan(P, '|');
      end;
    end;
  end;
begin
  FFiles.Clear;
  Result := False;
  AParent := GetCustomFormOwner(Self);
  if not Assigned(AParent) then Exit;

  SetLength(TempFilename, 4096);
  TempFilter := AllocFilterStr(FFilter);

  FillChar(OpenFilenameRec, SizeOf(OpenFilenameRec), 0);

  OpenFilenameRec.hWndOwner                    := HWND(AParent.Handle);
  OpenFilenameRec.lStructSize                  := SizeOf(TOpenFilename);
  OpenFilenameRec.hInstance                    := SysInit.HInstance;

  OpenFilenameRec.lpstrDefExt                  := PChar(FDefaultExt);

  OpenFilenameRec.nFilterIndex                 := 1;
  OpenFilenameRec.lpstrFilter                  := PChar(TempFilter);

  OpenFilenameRec.lpstrFile                    := PChar(TempFileName);
  OpenFilenameRec.nMaxFile                     := 4096;

  OpenFilenameRec.Flags                           := OFN_PATHMUSTEXIST + OFN_HIDEREADONLY;
  if FFileMustExist    then OpenFilenameRec.Flags := OpenFilenameRec.Flags + OFN_FILEMUSTEXIST;
  if FAllowMultiSelect then OpenFilenameRec.Flags := OpenFilenameRec.Flags + OFN_ALLOWMULTISELECT + OFN_EXPLORER;


  OpenFilenameRec.lpstrInitialDir              := '.';

  FillChar(OpenFilenameRec.lpstrFile^, MAX_PATH + 2, 0);
  StrLCopy(OpenFilenameRec.lpstrFile, PChar(FFileName), MAX_PATH);

  if GetOpenFileName(OpenFilenameRec) then
    begin
      Result := True;
      FFileName := OpenFilenameRec.lpstrFile;
      if FAllowMultiSelect then
        begin
          ExtractFileNames(OpenFilenameRec.lpstrFile);
          FFileName := FFiles[0];
        end
      else
        begin
          FFileName := OpenFilenameRec.lpstrFile;
          FFiles.Add(FFileName);
        end;
    end
  else if CommDlgExtendedError <> 0 then
    begin
      OpenFilenameRec.lStructSize := SizeOf(TOpenFilename) - (SizeOf(DWORD) shl 1) - SizeOf(Pointer); 
      if GetOpenFileName(OpenFilenameRec) then
        begin
          Result := True;
          if FAllowMultiSelect then
            begin
              ExtractFileNames(OpenFilenameRec.lpstrFile);
              FFileName := FFiles[0];
            end
          else
            begin
              FFileName := OpenFilenameRec.lpstrFile;
              FFiles.Add(FFileName);
            end;
        end
    end;
end;
//****************************************************************************************************************************************************
function TiOpenDialog.ExtractFileName(P: PChar; var S: TFilename): PChar;
const
  Separator = #0;
begin
  Result := AnsiStrScan(P, Separator);
  if Result = nil then
  begin
    S := P;
    Result := StrEnd(P);
  end
  else
  begin
    SetString(S, P, Result - P);
    Inc(Result);
  end;
end;
//****************************************************************************************************************************************************
procedure TiOpenDialog.ExtractFileNames(P: PChar);
const
  Separator = #0;
var
  DirName, FileName: TFilename;
begin
  P := ExtractFileName(P, DirName);
  P := ExtractFileName(P, FileName);
  if FileName = '' then
    FFiles.Add(DirName)
  else
  begin
    if AnsiLastChar(DirName)^ <> '\' then
      DirName := DirName + '\';
    repeat
      if (FileName[1] <> '\') and ((Length(FileName) <= 3) or
        (FileName[2] <> ':') or (FileName[3] <> '\')) then
        FileName := DirName + FileName;
      FFiles.Add(FileName);
      P := ExtractFileName(P, FileName);
    until FileName = '';
  end;
end;
//****************************************************************************************************************************************************
end.


