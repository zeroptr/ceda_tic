// Interbase Manager Component V1.1 April 1999
// by Toni Martir
//
// Requirements: Interbase server installed on the machine
// that executes this code (it does not support management
// from a client). It is designed to make scheduled tasks
// on the server.
//
// Features:
// - It do not need BDE
// - It's BDE compatible
// - It's multiprocess, with unix like process comunication,
//   so the backup and restore operations can be canceled.
// - It has progress indicator.
// - Supports database backup, restore, sweep, repair,
//   shutdown and setting forced writes and page size.
//
// Properties
// - Databasename If you want to specify a BDE Alias
// - Filename     Database filename
// - PageSize     Page size of restored database
// - Destination  Destination filename on backup (source
//                on restore)
//
// Methods
// - Backup       Backups the database on destination
// - Restore      Restores the database from destination
// - Sweep        Sweeps the database
// - Repair       Repairs the database
// - ShutDown     ShutDowns the database (waits until no
//                active connections)
// - EnableForcedWrites  Enables or disables forced Writes

unit ibman;

interface

uses Windows, Messages,SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,registry,dbtables,dialogs,imagehlp,filectrl,ibmanst;


type
  tpagesizetype=(tp1024,tp2048,tp4096,tp8192);

const
 constpagesizes:array [tp1024..tp8192] of string=('1024','2048','4096','8192');

type
  TThreadCopy=class;
  TFCopyProgressIB = class;

  TIbManager=class(TComponent)
   private
    FDatabasename:string;
    FServer:string;
    FBusy:boolean;
    DiaCopy:TFCopyProgressIB;
    FCopy:TThreadCopy;
    FOldOnIdle:TIdleEvent;
    FPageSize:TPageSizeType;
    FDestination:string;
    FFilename:string;
    procedure CheckBusy;
    function GetServerName:string;
    function GetBusy:boolean;
    procedure Endcopy(Sender:TObject);
    procedure IdleCopy(Sender:TObject;var done:Boolean);
    function IBAction(title,exename,commandline:string;closeonexit:boolean):boolean;
    procedure endsincro;
   public
    opresult:boolean;
    constructor Create(AOwner:TComponent);override;
    procedure Backup(ignoreerrors:boolean;autoclose:boolean);
    procedure Restore(forcedwrites:Boolean);
    procedure Sweep;
    procedure Repair(ignoreerrors:boolean);
    procedure ShutDown;
    procedure EnableForcedWrites(Valor:Boolean);
    property ServerName:string read GetServerName;
    property Busy:boolean read GetBusy;
   published
    property Databasename:string read FDataBaseName write FDatabasename;
    property PageSize:tpagesizetype read FPageSize write FPageSize default tp1024;
    property Destination:string read FDestination write FDestination;
    property Filename:string read FFIleName write FFileName;
   end;


  TFCopyProgressIB = class(TForm)
    BCancel: TButton;
    LProceso: TLabel;
    LMessages: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure BCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    docancel:boolean;
    fcopy:TThreadCopy;
    Fib:TIbManager;
    opresult:integer;
  public
    { Public declarations }
  end;

 TThreadCopy=class(TThread)
  private
   Fcommandline,FExename:string;
   Form:TFCopyProgressIB;
   FMessage:string;
   opresult:integer;
   procesinfo:TProcessInformation;
  public
   endedwitherror:Boolean;
   endoffile:boolean;
   errormsg:string;
   closeonexit:boolean;
   hpipewrite:THandle;
   procedure execute;override;
   procedure CShowMessage;
  end;

var
  FCopyProgressIB: TFCopyProgressIB;

function Obtaindatabasefilename(alias:string):string;



implementation
{$R IBMAN.DCR}

{$R *.DFM}


procedure TTHreadCopy.CShowMessage;
begin
 Form.LMessages.items.Insert(0,FMessage);
 if Endoffile then
  Form.update;
end;

procedure TThreadCopy.execute;
var
 startinfo:TStartupinfo;
 hpiperead:THandle;
 readcount:integer;
 buffer:Pchar;
 linecount:string;
 tempstring:string;
 index:integer;
 exitcode:DWORD;
begin
 endedwitherror:=false;
 errormsg:='';
 try
 linecount:='';
 buffer:=AllocMem(200);
 try
  if not CreatePipe(hpiperead,hpipewrite,nil,0) then
  Begin
   FMessage:=SIBComunError;
   Synchronize(Cshowmessage);
  end;
  try
   try
    with startinfo do
    begin
     cb:=sizeof(startinfo);
     lpReserved:=nil;
     lpDesktop:=nil;
     lpTitle:=Pchar(SIBBackup);
     dwX:=0;
     dwY:=0;
     dwXSize:=400;
     dwYSize:=400;
     dwXCountChars:=80;
     dwYCountChars:=25;
     dwFillAttribute:=FOREGROUND_RED or BACKGROUND_RED or BACKGROUND_GREEN or BACKGROUND_BLUe;
     dwFlags:=STARTF_USECOUNTCHARS or STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
     wShowWindow:=SW_HIDE;
     cbReserved2:=0;
     lpreserved2:=nil;
     hStdInput:=GetStdhandle(STD_INPUT_HANDLE);
     hStdOutput:=hpipewrite;
     hStdError:=hpipewrite;
    end;
    // Creates the interbase command line proces
    if Not CreateProcess(Pchar(FExename),Pchar(Fcommandline),nil,nil,False,NORMAL_PRIORITY_CLASS or CREATE_NEW_PROCESS_GROUP,nil,nil,
    startinfo,procesinfo) then
     Raise Exception.Create(SIBErrorcreatepr);
   finally
    CloseHandle(hpipewrite);
   end;
   Endoffile:=false;
   FMessage:='';
   linecount:='';
   While not Endoffile do
   begin
    if Not ReadFile(hpiperead,buffer^,10,DWORD(readcount),nil) then
    begin
     Endoffile:=True;
     buffer[readcount]:=chr(0);
    end
    else
    begin
     buffer[readcount]:=chr(0);
    end;
    // If the buffer have an Intro char...
    tempstring:=strpas(buffer);
    index:=Pos(chr(13),tempstring);
    if index<1 then
    begin
     linecount:=linecount+tempstring;
     if Endoffile then
     begin
      FMessage:=linecount;
      Synchronize(cshowmessage);
     end;
    end
    else
    begin
     FMessage:=linecount+Copy(tempstring,1,index-1);
     While length(FMessage)>0 do
     begin
      if ((FMessage[1]=chr(10)) or (FMessage[1]=chr(13)) or (FMessage[1]=chr(9))) then
       delete(FMessage,1,1)
      else
       break;
     end;
     linecount:=Copy(tempstring,index+1,200);
     While length(linecount)>0 do
     begin
      if ((linecount[1]=chr(10)) or (linecount[1]=chr(13))) then
       delete(linecount,1,1)
      else
       break;
     end;
     Synchronize(cshowmessage);
     FMessage:='';
    end;
   end;
  finally
   CloseHandle(hpiperead);
  end;
 finally
  Freemem(buffer);
 end;
 except
  on E:Exception do
  begin
   errormsg:=E.Message;
   endedwitherror:=True;
  end;
 end;
 // Waits until the process ends
 WaitForSingleObject(procesinfo.hProcess,INFINITE);
 if NOt GetExitCodeProcess(procesinfo.hProcess,exitcode) then
 begin
  FMessage:=SIBNoResult;
  Synchronize(cshowmessage);
 end
 else
 begin
  opresult:=exitcode;
  FMessage:=IntToStr(exitcode);
  Synchronize(cshowmessage);
 end;
end;

constructor TIbManager.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 FDatabasename:='';
 FFilename:='';
 FServer:='';
 FBusy:=False;
 FCopy:=nil;
 FpageSize:=tp1024;
 FDestination:='';
end;

procedure TIbManager.CheckBusy;
begin
 if Busy then
  Raise Exception.Create(SIBBusy);
end;

function TIbManager.IBAction(title,exename,commandline:string;closeonexit:boolean):boolean;
var
 nomserver:string;
 han:integer;
 rec:Tsmallrect;
begin
 AllocConsole();
 try
 han:=GetStdhandle(STD_OUTPUT_HANDLE);
 rec.top:=100;
 rec.left:=100;
 rec.Right:=-200;
 rec.bottom:=-200;
 SetConsoleWindowInfo(han,true,rec);
 // Check if it es doing a operation
 CheckBusy;
 nomserver:=Servername;
 // New progress form
 diacopy:=TFCopyProgressIB.Create(Application);
 diacopy.caption:=title;
 FCopy:=TThreadCopy.Create(true);
 FCopy.Fcommandline:=NomServer+'\'+commandline;
 FCopy.FExename:=NomServer+'\'+exename;
 FCopy.freeonterminate:=true;
 FCopy.Onterminate:=EndCopy;
 FCopy.Form:=diacopy;
 FCopy.closeonexit:=closeonexit;
 diacopy.fcopy:=FCopy;
 diacopy.FIb:=self;
 FOldOnIdle:=Application.Onidle;
 Application.OnIdle:=IdleCopy;
 diacopy.showmodal;
 Result:=(diacopy.opresult=0);
 finally
  FreeConsole();
 end;
end;

procedure TIbManager.Backup(ignoreerrors:boolean;autoclose:boolean);
var
 basename:string;
 desti:string;
 opresult:boolean;
begin
 if filename<>'' then
  basename:=filename
 else
  basename:=Obtaindatabasefilename(Fdatabasename);
 if Length(destination)<1 then
  desti:=changefileext(basename,'.gbk')
 else
  desti:=destination;
 if ignoreerrors then
  opresult:=IBAction(SIBBackup,'gbak.exe','gbak.exe -IG -B -Z -VERBOSE -USER SYSDBA -PASSWORD masterkey '+' "'+basename+'" '+'"'+desti+'"',autoclose)
 else
  opresult:=IBAction(SIBBackup,'gbak.exe','gbak.exe -B -Z -VERBOSE -USER SYSDBA -PASSWORD masterkey '+' "'+basename+'" '+'"'+desti+'"',autoclose);
 if not opresult then
 begin
  windows.deleteFile(pchar(desti));
  Raise Exception.Create(SIBCopyError);
 end;
end;

procedure TIbManager.Restore(Forcedwrites:Boolean);
var
 basename:string;
 origen:string;
begin
 if filename<>'' then
  basename:=filename
 else
  basename:=Obtaindatabasefilename(Fdatabasename);
 if Length(destination)<1 then
  origen:=changefileext(basename,'.gbk')
 else
  origen:=destination;
 // When restoring we must shutdown the database
 Shutdown;
 IBAction(SIBRestoring,'gbak.exe','gbak.exe -R -Z -VERBOSE -USER SYSDBA -PASSWORD masterkey -p '+constpagesizes[FPagesize]+' "'+origen+'" '+'"'+basename+'"',false);
end;

procedure TIbManager.Repair(ignoreerrors:boolean);
var
 basename:string;
begin
 if filename<>'' then
  basename:=filename
 else
  basename:=Obtaindatabasefilename(Fdatabasename);
 // Before repair we must shutdown the database
 Shutdown;
 if ignoreerrors then
  IBAction(SIBRepairing,'gfix.exe','gfix.exe -v -z -x -full -ignore -USER SYSDBA -PASSWORD masterkey '+' "'+basename+'"',false)
 else
  IBAction(SIBRepairing,'gfix.exe','gfix.exe -v -z -x -full -USER SYSDBA -PASSWORD masterkey '+' "'+basename+'"',false)
end;

procedure TIbManager.EnableForcedWrites(Valor:Boolean);
var
 basename:string;
begin
 if filename<>'' then
  basename:=filename
 else
  basename:=Obtaindatabasefilename(Fdatabasename);
 if Valor then
  IBAction(SIBDisable,'gfix.exe','gfix.exe -write sync -USER SYSDBA -PASSWORD masterkey '+' "'+basename+'"',true)
 else
  IBAction(SIBEnable,'gfix.exe','gfix.exe -write async -USER SYSDBA -PASSWORD masterkey '+' "'+basename+'"',true)
end;

procedure TIbManager.Sweep;
var
 basename:string;
begin
 if filename<>'' then
  basename:=filename
 else
  basename:=Obtaindatabasefilename(Fdatabasename);
 IBAction(SIBSweep,'gfix.exe','gfix.exe -sweep -USER SYSDBA -PASSWORD masterkey '+' "'+basename+'"',true)
end;

function TIbManager.GetBusy:Boolean;
begin
 Result:=False;
 if FCopy<>nil then
  result:=true;
end;

function TIbManager.GetServerName:string;
var
 reg:TRegistry;
begin
 if Length(FServer)>0 then
 begin
  result:=FServer;
  Exit;
 end;
 reg:=TRegistry.create;
 try
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  if Not reg.OpenKey('Software\InterBase Corp\InterBase\CurrentVersion',false) then
   Raise Exception.Create(SIBNotInstalled);
  Result:=reg.ReadString('ServerDirectory');
  if Length(Result)<=0 then
   Raise Exception.create(SIBNotInstalled);
  if Result[length(Result)]='\' then
   Result:=Copy(Result,1,Length(Result)-1);
 finally
  reg.free;
 end;
end;

procedure TFCopyProgressIB.FormCreate(Sender: TObject);
begin
 SendMessage(LMessages.Handle,LB_SETHORIZONTALEXTENT,2048,0);
 docancel:=false;
 LProceso.Caption:=SIBProgress;
 BCancel.Caption:=SIBCancel;
end;

procedure TFCopyProgressIB.BCancelClick(Sender: TObject);
begin
 docancel:=true;
 if BCancel.Caption=SIBOK then
 begin
  if FIb<>nil then
   FIb.opresult:=True;
  close;
 end
 else
 begin
  // Try to end the interbase command line process
  if FCopy<>nil then
  begin
   docancel:=true;
//   if not GenerateConsoleCtrlEvent(CTRL_BREAK_EVENT,FCopy.procesinfo.dwProcessId) then
//    RaiseLastWin32Error;
   if not GenerateConsoleCtrlEvent(CTRL_C_EVENT,FCopy.procesinfo.dwProcessId) then
    RaiseLastWin32Error;
  end
  else
   close;
 end;
end;

function Obtaindatabasefilename(alias:string):string;
var
 params:TStrings;
 j:integer;
begin
 result:='';
 params:=TStringList.Create;
 try
  Session.GetAliasParams(alias,params);
  j:=0;
  While (j<params.count) do
  begin
   if Pos('SERVER NAME=',Uppercase(params.strings[j]))=1 then
   begin
    Result:=Copy(params.strings[j],13,1000);
    break;
   end;
  end;
 finally
  params.free;
 end;
end;

procedure TFCopyProgressIB.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action:=cafree;
end;

procedure TFCopyProgressIB.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 canclose:=docancel;
end;

procedure TIbManager.endsincro;
var
 doclose:boolean;
 closeonexit:boolean;
begin
 diacopy.opresult:=fcopy.opresult;
 closeonexit:=FCopy.closeonexit;
 doclose:=False;
 try
  if FCopy.endedwitherror then
  begin
   ShowMessage(SIBCopyError+FCopy.errormsg);
   doclose:=true;
  end
  else
   if diacopy.docancel then
   begin
    ShowMessage(SIBCanceled);
    doclose:=true;
   end;
 finally
  diacopy.Fcopy:=nil;
  diacopy.docancel:=true;
  FCopy:=nil;
  Application.OnIdle:=FOldOnIdle;
  if doclose then
  begin
   diacopy.close;
  end
  else
  begin
   diacopy.BCancel.Caption:=SIBOK;
   if closeonexit then
   begin
    diacopy.Fib.opresult:=true;
    PostMessage(diacopy.Handle,WM_CLOSE,0,0);
   end;
  end;
 end;
end;

procedure TIbManager.EndCopy(Sender:TObject);
begin
 (Sender As TThreadCopy).Synchronize(endsincro);
end;

procedure TIbManager.IdleCopy(Sender:TObject;var done:Boolean);
begin
 Done:=True;
 FCopy.Resume;
 Application.OnIdle:=nil;
end;


procedure TIbManager.ShutDown;
var
 basename:string;
 stream:TFileStream;
 doexit:boolean;
 opresult:integer;
begin
 if filename<>'' then
  basename:=filename
 else
  basename:=Obtaindatabasefilename(Fdatabasename);
 doexit:=False;
 if Not FileExists(basename) then
  doexit:=True;
 While Not doexit do
 begin
  try
   // Look if the file exists
   Stream:=TFileStream.Create(basename,fmOpenRead or fmShareDenyWrite);
   Stream.free;
   doexit:=True;
  except
   opresult:=MessageDlg(SIBUsersconnected1+chr(10)+
   SIBUsersConnected2,mtWarning,[mbRetry,mbCancel],0);
   if opresult=ID_Cancel then
    Raise Exception.Create(SIBCanceled);
  end;
 end;
end;


procedure TFCopyProgressIB.FormShow(Sender: TObject);
begin
 if assigned(FIb) then
  FIb.opresult:=False;
end;


initialization


end.
