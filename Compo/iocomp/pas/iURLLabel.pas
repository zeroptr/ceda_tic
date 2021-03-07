{*******************************************************}
{                                                       }
{       TiURLLabel Component                            }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iURLLabel;{$endif}
{$ifdef iCLX}unit QiURLLabel;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL}Printers;{$ENDIF}
  {$IFDEF iCLX}QPrinters;{$ENDIF}

type
  TiURLShowCommand = (ssHide,
                      ssMaximize,
                      ssMinimize,
                      ssRestore,
                      ssShow,
                      ssShowDefault,
                      ssShowMaximized,
                      ssShowMinimized,
                      ssShowMinNoActivate,
                      ssShowNA,
                      ssShowNoActivate,
                      ssShowNormal);
  TiURLLabel = class(TCustomLabel)
  private
    FURL         : String;
    FShowCommand : TiURLShowCommand;
    {$ifdef MSWINDOWS}
    function RegKey(Key: HKey; SubKey: String; var Data: String) : LongInt;
    {$endif}
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function GetWebBrowser : String;
    {$ifdef LINUX}
    function RPMInstalled(RPMName: String) : String;
    {$endif}
  public
    constructor Create(AOwner: TComponent);                                       override;
    procedure Connect;
  published
    property URL         : String           read FURL         write FURL;
    property ShowCommand : TiURLShowCommand read FShowCommand write FShowCommand default ssShowDefault;
    property Caption;
    property AutoSize;
    property Visible;
  end;

implementation
//****************************************************************************************************************************************************
constructor TiURLLabel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FShowCommand := ssShowDefault;
  Width        := 32;
  Height       := 13;
  Font.Color   := clBlue;
  Font.Style   := [fsUnderline];
  FURL         := 'http://www.iocomp.com';
  Caption      := 'http://www.iocomp.com';
  Cursor       := crHandPoint;     
end;
//****************************************************************************************************************************************************
procedure TiURLLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
    begin
      Connect;
    end;
end;
//****************************************************************************************************************************************************
{$ifdef MSWINDOWS}
Function TiURLLabel.RegKey(Key : HKey; SubKey : String; var Data : String) : LongInt;
var
  TempKey : HKey;
  TData   : array[0..259] of Char;
  DSize   : Integer;
begin
  Result := regopenkeyex(Key, PChar(subkey), 0, KEY_QUERY_VALUE, TempKey);
  if result = ERROR_SUCCESS then
  begin
    DSize := Sizeof(TData);
    regqueryvalue(TempKey, nil, TData, DSize);
    Data := StrPas(TData);
    RegCloseKey(TempKey);
  end;
end;
{$endif}
//****************************************************************************************************************************************************
procedure TiURLLabel.Connect;
var
{$ifdef MSWINDOWS}
  Show : Integer;
{$endif}
{$ifdef LINUX}
{$endif}
  ConnectCommand : PChar;
begin
  {$ifdef LINUX}
  ConnectCommand := PChar(GetWebBrowser + ' ' + FURL + '&');
  if Length(ConnectCommand) > 0 then Libc.system(ConnectCommand);
  {$endif}
  {$ifdef MSWINDOWS}
  case FShowCommand of
    ssHide              : Show := sw_Hide;
    ssMaximize          : Show := sw_Maximize;
    ssMinimize          : Show := sw_Minimize;
    ssRestore           : Show := sw_Restore;
    ssShow              : Show := sw_Show;
    ssShowDefault       : Show := sw_ShowDefault;
    ssShowMaximized     : Show := sw_ShowMaximized;
    ssShowMinimized     : Show := sw_ShowMinimized;
    ssShowMinNoActivate : Show := sw_ShowMinNoActive;
    ssShowNA            : Show := sw_ShowNA;
    ssShowNoActivate    : Show := sw_ShowNoActivate;
    else                  Show := sw_ShowNormal;
  end;

  ConnectCommand := PChar(GetWebBrowser + ' ' + FURL);
  if winexec(ConnectCommand, Show) < 32 then
    raise exception.create('Couldn''t launch default browser');
  {$endif}
end;
//****************************************************************************************************************************************************
function TiURLLabel.GetWebBrowser: String;
{$ifdef MSWINDOWS}
var
  Key  : String;
  P    : Integer;
{$endif}
begin
  {$IFDEF LINUX}
  //Check BROWSER environment variable to see if it is set
  //if so, use that as the default browser
  Result := Trim(getenv('BROWSER'));
  //Our website doesn't like Konqueror
  if (Pos('kfmclient', Result) > 0) or (Pos('konqueror', Result) > 0)
    then Result := '';
  if (Length(Result) = 0) then
    begin
      //if BROWSER environment variable is not set
      //then look for an available browser according to the following list
      if (Length(Result) = 0) then Result := RPMInstalled('mozilla');
      if (Length(Result) = 0) then Result := RPMInstalled('galeon');
      if (Length(Result) = 0) then Result := RPMInstalled('opera');

      if (Length(Result) = 0) and FileExists('/usr/bin/mozilla') then Result := '/usr/bin/mozilla';
      if (Length(Result) = 0) and FileExists('/usr/bin/galeon')  then Result := '/usr/bin/galeon';
      if (Length(Result) = 0) and FileExists('/usr/bin/opera')   then Result := '/usr/bin/opera';

      if (Length(Result) = 0) and FileExists('/usr/bin/netscape') then Result := '/usr/bin/netscape';
      if (Length(Result) = 0) then Result := RPMInstalled('netscape-common');

      //Try Konqueror
      if (Length(Result) = 0) then
        if (Pos('kfmclient', Trim(getenv('BROWSER'))) > 0) or
           (Pos('konqueror', Trim(getenv('BROWSER'))) > 0) then
           Result := Trim(getenv('BROWSER'));
      if (Length(Result) = 0) and FileExists('/usr/bin/konqueror') then Result := '/usr/bin/konqueror';

      //Try Text Browsers
      if (Length(Result) = 0) then Result := RPMInstalled('lynx');
      if (Length(Result) = 0) then Result := RPMInstalled('links');

      //Add found browser to the environment variable BROWSER
      if (Length(Result) > 0) then Libc.putenv(PChar('BROWSER=' + Result));
    end;
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  //Get default browser from the windows registry
  if RegKey(HKEY_CLASSES_ROOT, '.htm', Key) = ERROR_SUCCESS then
  begin
    Key := Key + '\shell\open\command';
    if RegKey(HKEY_CLASSES_ROOT, Key, Key) = ERROR_SUCCESS then
    begin
      P := Pos('"%1"', Key);
      if P = 0 then
        P := Pos('%1', Key);
      if P <> 0 then
       SetLength(Key, P-1);
      Result := Trim(Key);
    end;
  end;
  {$ENDIF}
end;
//****************************************************************************************************************************************************
{$IFDEF LINUX}
function TiURLLabel.RPMInstalled(RPMName: String): String;
var
  TempStringList : TStringList;
  TempFileName   : String;
begin
  Result := '';

  TempFileName := '/tmp/iocomp-rpminstalled-deleteme.txt';
  TempStringList := TStringList.Create;

  try
    Libc.system(PChar('rpm -ql ' + RPMName + ' > ' + TempFileName));

    TempStringList.LoadFromFile(TempFileName);
    if (TempStringList.Strings[0] <> '') then
      begin
        if (Pos('Not Installed', TempStringList.Strings[0]) = 0) then
          begin
            if FileExists(TempStringList.Strings[0]) then Result := TempStringList.Strings[0];
          end;
      end;
  finally
    DeleteFile(TempFileName);
    TempStringList.Free;
  end;
end;
{$ENDIF}
//****************************************************************************************************************************************************
end.
