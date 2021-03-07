
{                                                                              }
{ IBS_Base                                                                     }
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
  IBS_Base;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, SyncObjs,
  Dialogs,

  IB_LogFiles, IB_Session, IB_Components, IB_Constants, Psock, NMsmtp;

type
  TsvcWorkerThread = class( TThread )
  public
    procedure Execute; override;
    function SafeWaitFor( Timeout: DWORD ): LongWord;
  end;

  TsvcBase = class( TService )
    se: TIB_Session;
    em: TNMSMTP;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure emSuccess(Sender: TObject);
    procedure emFailure(Sender: TObject);
    procedure BeforeConnect(Sender: TIB_Connection);
    procedure AfterConnect(Sender: TIB_Connection);
    procedure BeforeStart(Sender: TIB_Transaction);
    procedure AfterStart(Sender: TIB_Transaction);
    procedure BeforeCommitRetaining(Sender: TIB_Transaction);
    procedure AfterCommitRetaining(Sender: TIB_Transaction);
    procedure BeforeCommit(Sender: TIB_Transaction);
    procedure AfterCommit(Sender: TIB_Transaction);
    procedure BeforeRollback(Sender: TIB_Transaction);
    procedure AfterRollback(Sender: TIB_Transaction);
    procedure AfterEnd(Sender: TIB_Transaction);
    procedure WakeupThread(Sender: TObject);
  private
    { Private declarations }
    logCS: TCriticalSection;
    svcCS: TMultiReadExclusiveWriteSynchronizer;
    svcEvent: TEvent;
    FWorkerThread: TsvcWorkerThread;
    LastEmailSent: TDateTime;
    FCurrentDay: word;
    FWorkerTimeoutTicks: DWORD; 
    FLogItems: boolean;
    FLogThread: boolean;
    FLogTrans: boolean;
    FLogFiles: TLogFiles;
    function GetWorkerTerminated: boolean;
    procedure SysExecuteService;
  protected
    { Methods to be overridden }
    procedure DoServiceInitialization; virtual;
    procedure DoServiceFinalization; virtual;
    procedure DoServiceItems; virtual;
    procedure DoServiceProcessMidnightItems; virtual;
    procedure DoWorkerTimeout; virtual;
    function DoServiceCanSleep( var IsDone,
                                    IsWaiting,
                                    WasTerminated: boolean ): boolean; virtual;
    function DoServiceCanProcessMidnightItems: boolean; virtual;
    procedure DoPutServiceToSleep( Timeout: DWORD ); virtual;
    procedure DoServiceLoopException( E: Exception ); virtual;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
{: Flag to determine if any items are sent to a log file via the LogItem()
method.}
    property LogItems: boolean read FLogItems write FLogItems;
{: Flag to determine if thread related events are sent to a log file.}
    property LogThread: boolean read FLogThread write FLogThread;
{: Flag to determine if transaction related events are sent to a log file.}
    property LogTrans: boolean read FLogTrans write FLogTrans;
{: Access to the object responsible for maintain a hook into the log files.}
    property LogFiles: TLogFiles read FLogFiles;
{: Property used to tell if the worker has been requested to terminate.
<br><br>
This is different than the service itself being terminated.}
    property WorkerTerminated: boolean read GetWorkerTerminated;
{: Access to the critical section used to synchronize things that the worker
thread does.}
    property WorkerCS: TMultiReadExclusiveWriteSynchronizer read svcCS;
{: When all items are completed by the worker thread it is put to sleep. This
determines the amount of time before the thread wakes up and looks to see if
there is something that it can do.}    
    property WorkerTimeoutTicks: DWORD read FWorkerTimeoutTicks
                                       write FWorkerTimeoutTicks; 
    { Procedures }
    procedure CheckCursor( ACursor: TIB_Dataset );
    procedure CheckCursorItem(     ACursor: TIB_Cursor;
                               var Flag: boolean;
                                   CommitCnt: integer );
    procedure HandleProblem( const Prefix: string; E: Exception );
{: This method is called to log an item into a log file. Use the Sub parameter
to funnell items into separate files distinguished by the value sent it. It ends
up being used as part of the file name so keep it to a simple text string.}
    procedure LogItem( InTran: string; Sub: string = '' );
{: Access to the worker thread's Synchronize() method so that things can be
synchronized.}
    procedure WorkerSynchronize( Method: TThreadMethod );
{: Method to fire off an alert email. By default this is designed to only send
of emails during a certain window of time and only so many per period of time.
See source for more details.}
    procedure SendEmailNotice( const AMsg: string );
{: This method will cause the worker thread to become terminated.}
    procedure TerminateWorker;
  end;

implementation

{$R *.DFM}

var
  svcBase: TsvcBase;

procedure ServiceController( CtrlCode: DWord ); stdcall;
begin
  svcBase.Controller( CtrlCode );
end;

function TsvcBase.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsvcBase.LogItem( InTran: string; Sub: string = '' );
begin
  if Assigned( logCS ) and Assigned( LogFiles ) then
  begin
    logCS.Enter;
    try
      LogFiles.LogItem( InTran, Sub );
    except
      LogItems := false;
      LogMessage( 'Failed to log item: ' + InTran + #13#10 + 'Sub: ' +
                                           Sub + #13#10 );
    end;
    logCS.Leave;
  end;
end;

procedure TsvcWorkerThread.Execute;
begin
  svcBase.SysExecuteService;
end;

function TsvcWorkerThread.SafeWaitFor( Timeout: DWORD ): LongWord;
var
  Msg: TMsg;
  H: THandle;
begin
  H := Handle;
  if GetCurrentThreadID = MainThreadID then
    while MsgWaitForMultipleObjects( 1,
                                     H,
                                     False,
                                     Timeout,
                                     QS_SENDMESSAGE ) = WAIT_OBJECT_0 + 1 do
      PeekMessage( Msg, 0, 0, 0, PM_NOREMOVE )
  else
    WaitForSingleObject( H, Timeout );
  GetExitCodeThread( H, Result );
end;

procedure TsvcBase.HandleProblem( const Prefix: string; E: Exception );
var
  tmpStr: string;
begin
  if E is EIB_ISCError then
  begin
    tmpStr := Prefix + #13#10 +
              Trim(( E as EIB_ISCError).ErrorMessage.Text ) + #13#10#13#10;
    if Trim( (E as EIB_ISCError).SQL.Text ) <> '' then
      tmpStr := tmpStr + (E as EIB_ISCError).SQL.Text + #13#10#13#10;
    if (E as EIB_ISCError).Sender is TComponent then
      tmpStr := tmpStr + ((E as EIB_ISCError).Sender as TComponent).Name;
  end
  else
    tmpStr := Prefix + #13#10#13#10 + Trim( E.Message );
  LogItem( tmpStr );
  if ( now > LastEmailSent + 0.1 ) then
    SendEmailNotice( tmpStr );
end;

procedure TsvcBase.CheckCursor( ACursor: TIB_Dataset );
begin
  if not WorkerTerminated and ACursor.Active then
    try
      if not ACursor.Eof then
        ACursor.Next;
      if ACursor.Eof then
      begin
        ACursor.Close;
        ACursor.IB_Transaction.Commit;
      end;
    except
      on E: Exception do
      begin
        HandleProblem( '[' + ACursor.Name + '.Close]', E );
        ACursor.Close;
        HandleProblem( '[' + ACursor.IB_Transaction.Name + '.Rollback]', E );
        ACursor.IB_Transaction.Rollback;
        raise;
      end;
    end;
end;

procedure TsvcBase.CheckCursorItem(     ACursor: TIB_Cursor;
                                    var Flag: boolean;
                                        CommitCnt: integer );
begin
  try
    if WorkerTerminated then
    begin
      Flag := false;
      ACursor.Close;
      ACursor.IB_Transaction.Rollback;
    end
    else
    begin
      if Flag then
      begin
        if ACursor.Eof or not ACursor.Active then
          ACursor.First
        else
          ACursor.Next;
        Flag := not ACursor.Eof;
      end;
      if not Flag or ( ACursor.RowNum >= CommitCnt ) then
      begin
        ACursor.Close;
        ACursor.IB_Transaction.Commit;
      end;
    end;
  except
    on E: Exception do
    begin
      Flag := false;
      HandleProblem( '[' + ACursor.Name + '.Close]', E );
      ACursor.Close;
      HandleProblem( '[' + ACursor.IB_Transaction.Name + '.Rollback]', E );
      ACursor.IB_Transaction.Rollback;
      raise;
    end;
  end;
end;

procedure TsvcBase.SendEmailNotice( const AMsg: string );
var
  hour, min, sec, msec: word;
begin
  try
    with em do
    begin
      if not DayOfWeek( now ) in [2..6] then
        Exit;
      DecodeTime( now, hour, min, sec, msec );
      if not hour in [7..16] then
        Exit;
      LastEmailSent := now;
      PostMessage.Body.Text := AMsg;
      Connect;
      try
        SendMail;
      finally
        Disconnect;
      end;
    end;
  except
    on E: Exception do
      LogItem( 'Failed to send email notification: ' + E.Message );
  end;
end;

procedure TsvcBase.SysExecuteService;
var
  tmpDay, tmpMonth, tmpYear: word;
  IsDone, IsWaiting, WasTerminated: boolean;
begin
  LastEmailSent := 0;
  DecodeDate( now, tmpYear, tmpMonth, FCurrentDay );
  if LogThread then LogItem( '[INITIALIZING]', 'Thread' );
  try
    DoServiceInitialization;
  except
    on E: Exception do
      LogMessage( 'Exception in ServiceInitialization: ' + E.Message );
  end;
  if LogThread then LogItem( '[EXECUTING]', 'Thread' );
  repeat
    try
      IsDone := true;
      IsWaiting := false;
      WasTerminated := false;
      if not WorkerTerminated then
      begin
        try
          DoServiceItems;
        except
          on E: Exception do
            HandleProblem( 'Problem in DoServiceItems', E );
        end;
        if not WorkerTerminated then
        begin
          DecodeDate( now, tmpYear, tmpMonth, tmpDay );
          if FCurrentDay <> tmpDay then
            if DoServiceCanProcessMidnightItems then
              try
                DoServiceProcessMidnightItems;
                FCurrentDay := tmpDay;
              except
                on E: Exception do
                  HandleProblem( 'Problem in DoProcessMidnightItems', E );
              end;
        end;
        if not WorkerTerminated then
          try
            se.ProcessPassiveTasks( IsDone, IsWaiting, WasTerminated );
          except
            on E: Exception do
              HandleProblem( 'Problem in se.ProcessPassiveTasks', E );
          end;
      end;
      if not WorkerTerminated and
         DoServiceCanSleep( IsDone, IsWaiting, WasTerminated ) and
         not WorkerTerminated then
        begin
          if IsWaiting then
            DoPutServiceToSleep( WorkerTimeoutTicks div 10 )
          else
            DoPutServiceToSleep( WorkerTimeoutTicks );
        end;
    except
      on E: Exception do
        DoServiceLoopException( E );
    end;
  until WorkerTerminated;
  if LogThread then LogItem( '[TERMINATING]', 'Thread' );
  try
    DoServiceFinalization;
  except
    on E: Exception do
      LogMessage( 'Exception in ServiceFinalization: ' + E.Message );
  end;
  if LogThread then LogItem( '[TERMINATED]', 'Thread' );
end;

procedure TsvcBase.DoPutServiceToSleep( Timeout: DWORD );
var
  WR: TWaitResult;
begin
  if LogThread then LogItem( '[WAITING: ' + IntToStr( Timeout ) +
                             ' Ticks ]', 'Thread' );
  LogFiles.ReleaseFiles;
  WR := svcEvent.WaitFor( Timeout );
  svcEvent.ResetEvent;
  case WR of
  wrAbandoned:
  begin
    if LogThread then LogItem( '[ABANDONED]', 'Thread' );
    TerminateWorker;
  end;
  wrError:
  begin
    if LogThread then LogItem( '[ERROR]', 'Thread' );
    TerminateWorker;
  end;
  wrTimeout:
  begin
    if LogThread then LogItem( '[TIMEOUT]', 'Thread' );
    if not WorkerTerminated then
      DoWorkerTimeout;
  end;
  wrSignaled:
    if LogThread then LogItem( '[SIGNALED]', 'Thread' );
  end;
end;

procedure TsvcBase.DoServiceInitialization;
begin
// Abstract.
end;

procedure TsvcBase.DoServiceFinalization;
begin
// Abstract.
end;

procedure TsvcBase.DoServiceItems;
begin
// Abstract.
end;

procedure TsvcBase.DoWorkerTimeout;
begin
// Abstract.
end;

procedure TsvcBase.DoServiceProcessMidnightItems;
begin
// Abstract.
end;

function TsvcBase.DoServiceCanSleep( var IsDone,
                                         IsWaiting,
                                         WasTerminated: boolean ): boolean;
begin
  Result := IsDone;
end;

function TsvcBase.DoServiceCanProcessMidnightItems: boolean;
begin
  Result := true;
end;

procedure TsvcBase.DoServiceLoopException( E: Exception );
begin
  HandleProblem( 'ServiceLoopException', E );
end;

procedure TsvcBase.ServiceStart(Sender: TService; var Started: Boolean);
begin
  FWorkerThread := TsvcWorkerThread.Create( true );
  FWorkerThread.FreeOnTerminate := true;
  FWorkerThread.Resume;
end;

procedure TsvcBase.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  while FWorkerThread.Suspended do FWorkerThread.Resume;
end;

procedure TsvcBase.ServicePause(Sender: TService; var Paused: Boolean);
begin
  FWorkerThread.Suspend;
end;

procedure TsvcBase.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  ServiceShutDown( Sender );
  svcEvent.SetEvent;
  FWorkerThread.SafeWaitFor( 60000 );
end;

procedure TsvcBase.ServiceShutdown(Sender: TService);
begin
//  LogItem( 'Request to Shutdown' );
  FWorkerThread.Terminate;
  svcEvent.SetEvent;
  while FWorkerThread.Suspended do
  begin
    FWorkerThread.Resume;
    svcEvent.SetEvent;
  end;
end;

procedure TsvcBase.WorkerSynchronize( Method: TThreadMethod );
begin
  FWorkerThread.Synchronize( Method );
end;

procedure TsvcBase.TerminateWorker;
begin
  if Assigned( FWorkerThread ) then FWorkerThread.Terminate;
end;

function TsvcBase.GetWorkerTerminated: boolean;
begin
  Result := not Assigned( FWorkerThread ) or FWorkerThread.Terminated;
end;

procedure TsvcBase.WakeupThread( Sender: TObject );
begin
  if LogThread then LogItem( '[WAKEUP]' + TComponent(Sender).Name, 'Thread' );
  svcEvent.SetEvent;
end;

procedure TsvcBase.BeforeConnect(Sender: TIB_Connection);
begin if LogTrans then LogItem( '[CONNECT]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.AfterConnect(Sender: TIB_Connection);
begin if LogTrans then LogItem( '[CONNECTED]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.BeforeStart(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[START]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.AfterStart(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[STARTED]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.BeforeCommitRetaining(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[COMMIT-RETAIN]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.AfterCommitRetaining(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[COMMIT-RETAINED]' + Sender.Name,'Trans'); end;
procedure TsvcBase.BeforeCommit(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[COMMIT]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.AfterCommit(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[COMMITTED]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.BeforeRollback(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[ROLLBACK]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.AfterRollback(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[ROLLEDBACK]' + Sender.Name, 'Trans' ); end;
procedure TsvcBase.AfterEnd(Sender: TIB_Transaction);
begin if LogTrans then LogItem( '[ENDED]' + Sender.Name, 'Trans' ); end;

procedure TsvcBase.ServiceCreate(Sender: TObject);
begin
  FWorkerTimeoutTicks := 120000; // 2 minutes.
  svcBase := Self;
  logCS := TCriticalSection.Create;
  svcEvent := TEvent.Create( nil, false, true, '' );
  svcCS := TMultiReadExclusiveWriteSynchronizer.Create;
  FLogItems := true;
  FLogFiles := TLogFiles.Create;
end;

procedure TsvcBase.ServiceDestroy(Sender: TObject);
begin
  logCS.Free;
  logCS := nil;
  svcEvent.Free;
  svcEvent := nil;
  svcCS.Free;
  svcCS := nil;
  FLogFiles.Free;
  FLogFiles := nil;
end;

procedure TsvcBase.emSuccess(Sender: TObject);
begin
  LogItem( 'NOTICE EMAIL SUCCESS' );
end;

procedure TsvcBase.emFailure(Sender: TObject);
begin
  LogItem( 'NOTICE EMAIL FAILURE' );
end;

end.

