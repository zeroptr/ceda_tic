{*******************************************************}
{                                                       }
{       TiSaveDialog Component                          }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iSaveDialog;{$endif}
{$ifdef iCLX}unit QiSaveDialog;{$endif}

interface

uses                     
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}CommDlg,  iGPFunctions;{$ENDIF}
  {$IFDEF iCLX}CommDlg, QiGPFunctions;{$ENDIF}

type
  TiSaveDialog = class(TComponent)
  private
    FFileName    : String;
    FFilter      : String;
    FDefaultExt  : String;
    FFilterIndex : Integer;
    FFilterList  : TStringList;
    FReturnExt   : String;
  protected
    procedure UpdateFilterList;
  public
    function Execute : Boolean;

    constructor Create(AOwner: TComponent); override;  
    destructor Destroy;                     override;
  published
    property FileName    : String  read FFileName    write FFileName;
    property Filter      : String  read FFilter      write FFilter;
    property FilterIndex : Integer read FFilterIndex write FFilterIndex;
    property DefaultExt  : String  read FDefaultExt  write FDefaultExt;
    property ReturnExt   : String  read FReturnExt;
  end;

implementation

//****************************************************************************************************************************************************
constructor TiSaveDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFilterIndex := 1;
  FFilterList  := TStringList.Create;
end;
//****************************************************************************************************************************************************
destructor TiSaveDialog.Destroy;
begin
  FFilterList.Free;
  inherited;
end;
//****************************************************************************************************************************************************
procedure TiSaveDialog.UpdateFilterList;
var
  BuildString : String;
  AChar       : String;
  x           : Integer;
begin
  BuildString := '';
  for x := 1 to Length(FFilter) do
    begin
      AChar := Copy(FFilter, x, 1);
      if AChar <> '|' then
        BuildString := BuildString + AChar
      else
        begin
          FFilterList.Add(BuildString);
          BuildString := '';
        end;
    end;
  if Length(BuildString) <> 0 then FFilterList.Add(BuildString);

  x := 0;
  while x < FFilterList.Count do
    if Copy(FFilterList.Strings[x], 1, 1) <> '*' then FFilterList.Delete(x) else inc(x);
end;
//****************************************************************************************************************************************************
function TiSaveDialog.Execute : Boolean;
var
  OpenFilenameRec : TOpenFilename;
  TempFileName    : String;
  TempFilter      : String;
  FileExt         : String;
  FileExtMatch    : Boolean;
  AParent         : TWinControl;

  function AllocFilterStr(const S: string): string;
  var
    P: PChar;
  begin
    Result := '';
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
  Result := False;
  AParent := GetCustomFormOwner(Self);
  if not Assigned(AParent) then Exit;
  
  SetLength(TempFilename, MAX_PATH + 2);
  TempFilter := AllocFilterStr(FFilter);

  FillChar(OpenFilenameRec, SizeOf(OpenFilenameRec), 0);

  OpenFilenameRec.lStructSize := SizeOf(TOpenFilename);
                                   
  OpenFilenameRec.hWndOwner       := HWND(AParent.Handle);

  OpenFilenameRec.hInstance       := SysInit.HInstance;

  OpenFilenameRec.lpstrDefExt     := PChar(FDefaultExt);

  OpenFilenameRec.nFilterIndex    := FFilterIndex;
  OpenFilenameRec.lpstrFilter     := PChar(TempFilter);

  OpenFilenameRec.lpstrFile       := PChar(TempFileName);
  OpenFilenameRec.nMaxFile        := MAX_PATH;

  OpenFilenameRec.Flags           := OFN_PATHMUSTEXIST + OFN_HIDEREADONLY + OFN_OVERWRITEPROMPT;

  OpenFilenameRec.lpstrInitialDir := '.';

  FillChar(OpenFilenameRec.lpstrFile^, MAX_PATH + 2, 0);
  StrLCopy(OpenFilenameRec.lpstrFile, PChar(FFileName), MAX_PATH);

  if GetSaveFileName(OpenFilenameRec) then
    begin
      Result       := True;
      FFileName    := OpenFilenameRec.lpstrFile;
      FFilterIndex := OpenFilenameRec.nFilterIndex;

      UpdateFilterList;

      FReturnExt := '';
      if (FFilterList.Count <> 0) and (FFilterIndex <= FFilterList.Count) then
        begin
          FReturnExt := FFilterList.Strings[FFilterIndex-1];
          FReturnExt := Copy(FReturnExt, 2, Length(FReturnExt) - 1);
        end;

      if (FReturnExt <> '') and (FReturnExt <> '.*') then
        begin
          FileExtMatch := True;
          FileExt := ExtractFileExt(FFileName);
          if Length(FileExt) = 0                                      then FileExtMatch := False;
          if (FFilterList.IndexOf('*' + FileExt) + 1) <> FFilterIndex then FileExtMatch := False;

          if not FileExtMatch then FFileName := FFileName + FReturnExt;
        end;
    end
  else if CommDlgExtendedError <> 0 then
    begin
      OpenFilenameRec.lStructSize := SizeOf(TOpenFilename) - (SizeOf(DWORD) shl 1) - SizeOf(Pointer); { subtract size of added fields }

      if GetSaveFileName(OpenFilenameRec) then
        begin
          Result       := True;
          FFileName    := OpenFilenameRec.lpstrFile;
          FFilterIndex := OpenFilenameRec.nFilterIndex;

          UpdateFilterList;

          FReturnExt := '';
          if (FFilterList.Count <> 0) and (FFilterIndex <= FFilterList.Count) then
            begin
              FReturnExt := FFilterList.Strings[FFilterIndex-1];
              FReturnExt := Copy(FReturnExt, 2, Length(FReturnExt) - 1);
            end;

          if (FReturnExt <> '') and (FReturnExt <> '.*') then
            begin
              FileExtMatch := True;
              FileExt := ExtractFileExt(FFileName);
              if Length(FileExt) = 0                                      then FileExtMatch := False;
              if (FFilterList.IndexOf('*' + FileExt) + 1) <> FFilterIndex then FileExtMatch := False;

              if not FileExtMatch then FFileName := FFileName + FReturnExt;
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
end.


