unit Un_Kul_Con_Fb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,Registry, Variants ;


const
  isc_dpb_version1    = 1;
  isc_dpb_user_name   = 28;
  isc_dpb_password    = 29;

  isc_info_end        = 1;
  isc_info_truncated  = 2;
  isc_info_error      = 3;
  isc_info_user_names = 53;

  IBASE_DLL           = 'GDS32.DLL';
  KILOBYTE            = 1024;

type
  ISC_LONG            = Longint;
  ISC_STATUS          = ISC_LONG;
  ISC_STATUS_VECTOR   = array[0..19] of ISC_STATUS;
  PSTATUS_VECTOR      = ^ISC_STATUS_VECTOR;
  PPSTATUS_VECTOR     = ^PSTATUS_VECTOR;

  Tisc_db_handle      = Pointer;
  pisc_db_handle      = ^Tisc_db_handle;

  TParamBlock         = array [0..KILOBYTE-1] of Char;
  TLargePB            = array [0..(4*KILOBYTE)-1] of Char;
  TSmallPB            = array [0..(KILOBYTE div 4)-1] of Char;

function IsIBRunning(): boolean;
function StartServer(): boolean;
function Fb_Calistir():Boolean;

function kul_bul(mdUserName1:String;mdPassword1:String;mdDBName1:String):Integer;

implementation



function isc_interprete(buffer: PChar; status_vector_ptr: PPSTATUS_VECTOR): ISC_STATUS;
  stdcall; external IBASE_DLL name 'isc_interprete';

function isc_attach_database(status_vector: PSTATUS_VECTOR; db_name_length: Short;
  db_name: PChar; db_handle: pisc_db_handle; parm_buffer_length: Short;
  parm_buffer: PChar): ISC_STATUS; stdcall; external IBASE_DLL name 'isc_attach_database';

function isc_database_info(status_vector: PSTATUS_VECTOR; db_handle: pisc_db_handle;
  item_list_buffer_length: Smallint; item_list_buffer: Pointer;
  result_buffer_length: Smallint; result_buffer: Pointer): ISC_STATUS;
  stdcall; external IBASE_DLL name 'isc_database_info';

function isc_vax_integer(result_buffer : PChar; result_length : SmallInt): ISC_LONG;
  stdcall; external IBASE_DLL name 'isc_vax_integer';

function isc_detach_database(status_vector: PSTATUS_VECTOR; db_handle:
  pisc_db_handle): ISC_STATUS; stdcall; external IBASE_DLL name 'isc_detach_database';







function kul_bul(mdUserName1:String;mdPassword1:String;mdDBName1:String):Integer;
var
  UserFound: boolean;
  Mode: (mdDBName, mdUserName, mdPassword);
  s, DBName, UserName, Password: string;

  ErrorCode: ISC_STATUS;
  StatusVector: ISC_STATUS_VECTOR;
  DBHandle: Tisc_db_handle;
  DPB: TParamBlock;        //parameter block for database connection
  DPBLen: Integer;         //length of Paramblock
  ItemList:  TSmallPB;
  UserNames: TLargePB;
  UserCount: Integer;

  i: Integer;
  Item,           //InfoItem we are testing for
  Pos,            //marker for position in array
  Len,            //Length of section
  namelength: SmallInt;
  UserStr: array[0..255] of char;

  procedure Error;
  var
    buffer: array[0..511] of char;
    ErrorMessages, lastMsg: string;
    pStatus: PSTATUS_VECTOR;
  begin
    fillchar(buffer,512,#0);
    pStatus:=@StatusVector;
    ErrorMessages:='';
    repeat
      ErrorCode := isc_interprete( @buffer, @pstatus);
      if lastMsg <> strPas( buffer) then
      begin
        lastMsg := strPas( buffer);
        if length(ErrorMessages) <> 0 then ErrorMessages := ErrorMessages+#13#10;
        ErrorMessages := ErrorMessages+lastMsg;
      end;
    until ErrorCode = 0;
    raise Exception.Create(ErrorMessages);
  end;

  procedure BuildPBString( var PB: array of char; var PBLen: Integer; item: byte; contents: string);
  //Add a string value to a parameter block
  var len: Integer;
  begin
    {PBLen is the current size of the populated array, as well as the indicator}
    PB[PBLen] := char(item);
    inc(PBLen);
    len:=Length(Contents);
    PB[PBLen] := char(len);
    inc(PBLen);
    StrPCopy(@PB[PBLen],Contents);
    inc(PBLen,len);
  end;

begin
     Result:=-1;
{  try
    UserFound := false;
    Mode := mdDBName;
    DBName := '';
    UserName := '';
    Password := '';
    for i := 1 to paramcount do
    begin
      s := paramstr(i);
      if s[1] = '-' then
        case upcase(s[2]) of
          'U':
          begin
            Mode := mdUserName;
            delete(s, 1, 2);
          end;
          'P':
          begin
            Mode := mdPassword;
            delete(s, 1, 2);
          end;
        end;
      if s <> '' then
      begin
        case Mode of
          mdDBName: DBName := s;
          mdUserName: UserName := s;
          mdPassword: Password := s;
        end;
        Mode := mdDBName
      end;
    end;
    if (DBName = '') or (UserName = '') then
    begin
      writeln('IB_SHOWUSERS is a console mode program that lists all users currently');
      writeln('connected to a database.');
      writeln('IB_SHOWUSERS is freeware and comes AS-IS. Use it on your own risk.');
      writeln('IB_SHOWUSERS has been tested with Interbase V5.5 on Windows 95/NT4.');
      writeln('V1.0, Author: Karsten Strobel');
      writeln;
      writeln('Usage:');
      writeln('IB_SHOWUSERS -U username -P password path-to-database');
      halt(2);
    end;

}
///param alýmý
   try
      Result:=0;

      DBName:=mdDBName1;
      UserName:=mdUserName1;
      Password:=mdPassword1;


    for i:=low(StatusVector) to high(StatusVector) do StatusVector[i] := 0;
    DBHandle := nil;
    fillchar(DPB,sizeof(DPB),#0);
    DPB[0] := char(isc_dpb_version1);
    DPBLen := 1;
    BuildPBString(DPB,DPBLen,isc_dpb_user_name,Username);
    BuildPBString(DPB,DPBLen,isc_dpb_password,Password);
    ErrorCode := isc_attach_database(@StatusVector, Length(DBName), PChar(DBName),
      @DBHandle, DPBLen, @DPB);
    if ErrorCode <> 0 then
    begin
      Error;
      halt;
    end;

    fillchar(itemlist, sizeof(itemlist),#0);
    ItemList[0] := char(isc_info_user_names);
    fillchar(UserNames, sizeof(UserNames),#0);
    ErrorCode := isc_database_info(@StatusVector, @DBHandle, 1, @itemlist, 1024, @UserNames);
    if ErrorCode = 0 then
    begin
//////önceden kaldýrýlmýþ
      (* Usernames will now have data in the following format:

        '5',                            //Info type - isc_info_user_name
        #6, #0,                         //Number of bytes in next section
        #5,                             //length of name
        'G', 'U', 'E', 'S', 'T',        //name
        '5',                            //Info type - isc_info_user_name
        #7, #0,                         //Number of bytes in next section
        #6,                             //length of name
        'S', 'Y', 'S', 'D', 'B', 'A',   //name

          etc. etc.

        #1,                             //isc_info_end (hopefully)

      *)

//////önceden kaldýrýlmýþ
//    writeln('The following users are currently connected:'#13#10);
      item:=0;
      UserCount:=0;

      while not ((((UserNames[item])=char(isc_info_end)) or
        ((UserNames[item])=char(isc_info_error))) or
        ((UserNames[item])=char(isc_info_truncated))) do
      begin
        pos:=item;                                      //isc_info_user_name
        inc(pos);                                       //start of length byte pair
        len := isc_vax_integer(@UserNames[pos],2);      //read the two-byte length and save it for Ron.
        inc(pos,2);                                     //move forward to byte telling us length of name
        UserStr:='';
        NameLength:=byte(UserNames[pos])+1;
        fillChar(UserStr,256,#0);
        for i:=1 to namelength-1 do UserStr[i-1] := UserNames[pos+i];
//        write(UserStr);

        if not UserFound and (AnsiCompareText(UserName, UserStr) = 0) then
        begin
          UserFound := true;
//          write(' (this program)');
        end;
//        writeln;
        inc(UserCount);
        inc(item,len+3);{move to next item  (3 covers length of item (one byte) and len (two bytes)}
      end;
//    write(#13#10, IntToStr(UserCount),' user');
//      if UserCount > 1 then   write('s');
//      writeln;
        Result:=UserCount;
      exitcode := ord(UserCount > 1);
    end
    else Error;

    if assigned(DBHandle) then
    begin
      ErrorCode := isc_detach_database(@StatusVector, @DBHandle);
      if ErrorCode <> 0 then Error;
    end;
  except
    on E:Exception do
    begin
      s := E.Message + #13#10;
      //WriteFile(GetStdHandle(STD_ERROR_HANDLE), s[1], Length(s), DWORD(i), nil);
      ExitCode := 2;
    end;
  end;
end;




function IsIBRunning(): boolean;
begin
     if GetWindow(GetDesktopWindow,GW_HWNDNEXT) = FindWindow(Nil,'Firebird Server') then result := false
     else result := true;
end;

function StartServer(): boolean;
var
   lRegistry: TRegistry;
   lStartUpInfo: STARTUPINFO;
   lSecurityAttr: SECURITY_ATTRIBUTES;
   lProcessInfo: PROCESS_INFORMATION;
   lEXEName: string;
   lArray: array[0..255] of char;
begin
    result := false;
    lRegistry := TRegistry.Create;
    try
       Screen.Cursor := crHourglass;
       lRegistry.RootKey := HKEY_LOCAL_MACHINE;
       //if not lRegistry.OpenKey('Software\Borland\InterBase\CurrentVersion',False) then

       if not lRegistry.OpenKey('SOFTWARE\Firebird Project\Firebird Server\Instances',False) then
       ShowMessage('Firebird server sisteme kurulmamýþ.')
       else
//       lEXEName := Format('%s%s -a',[lRegistry.ReadString('DefaultInstance'),'ibserver.exe']);
       lEXEName := Format('%s%s -a',[lRegistry.ReadString('DefaultInstance')+'Bin\','fbguard.exe']);
//       lEXEName := Format('%s%s -a',[lRegistry.ReadString('ServerDirectory'),'ibguard.exe']);
//       Udf_Dizin:=lRegistry.ReadString('RootDirectory')+'\Udf';
       ZeroMemory(@lStartUpInfo, SizeOf(lStartUpInfo));
       lStartUpInfo.cb := SizeOf(lStartUpInfo);
       lSecurityAttr.nLength := SizeOf (lSecurityAttr);
       lSecurityAttr.lpSecurityDescriptor := nil;
       lSecurityAttr.bInheritHandle := TRUE;
       if CreateProcess (nil,StrPCopy(lArray,lEXEName), @lSecurityAttr, nil, FALSE, 0, nil,
       nil, lStartUpInfo, lProcessInfo) <> Null then result := true
       else ShowMessage('Firebird server çalýþtýrýlamýyor.')
    finally
       lRegistry.Free;
       Screen.Cursor := crDefault;
    end;
    Sleep(2000);
end;


function Fb_Calistir:Boolean;
begin
     Result:=True;
     if not IsIBRunning then
     begin
         Result:=False;
         if not StartServer then
         begin
              //Application.MessageBox(Pchar('Firebird Çalýþmýyor') ,'Bilgi', MB_OK+MB_ICONINFORMATION);
              //Application.Terminate;
              //Halt;
              Result:=False;
         end
         else
         Result:=True;
     end;
end;

end.

{   LAbel1.Caption:=inttostr(kul_bul('sysdba','masterkey','c:\ceda\db\Cevresel_2006.fdb'));
Fb_Calistir;
}
