
{                                                                              }
{ TIB_Process                                                                  }
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

{: This unit contains the TIB_Process component.}
unit
  IB_Process;

interface

uses
  Classes, SysUtils, Forms,

  IB_Session,
  IB_Constants,
  IB_Components;
//IB_DataScan
//IB_Export
//IB_Import
//IB_DataPump
//IB_Script

//IB_Process.PBL

type
{: This tells the result of the process.}
TIB_ProcessResult = ( prIncomplete,
                      prAborted,
                      prFailed,
                      prAbandoned,
                      prCompleted );

{: This component serves as a base class to components needing an item by item
flow. The TIB_Script, TIB_DataPump and TIB_Export are a few examples.}
TIB_Process = class( TIB_Component )
private
{ Property storage variables }
  FPrepared: boolean;
  FExecuting: boolean;
  FExecutingAbortInit: integer;
  FExecutingAbortGen: integer;
  FExecutingFailed: boolean;
  FYield: boolean;
  FPassive: boolean;
  FProcessResult: TIB_ProcessResult;
  FBeforePrepare: TNotifyEvent;
  FAfterPrepare: TNotifyEvent;
  FAfterUnprepare: TNotifyEvent;
  FBeforeExecute: TNotifyEvent;
  FAfterExecute: TNotifyEvent;
  FOnStatusChange: TNotifyEvent;
  function GetExecutingAborted: boolean;
  procedure SetPrepared( AValue: boolean );
  procedure SetProcessResult;
protected
  FPreventPassive: boolean;
  procedure SysPrepare; virtual;
  procedure SysUnprepare; virtual;
  procedure SysExecute( var IsDone: boolean ); virtual;
  function SysWasCompleted: boolean; virtual; 
  function SysNeedToExecute: boolean; virtual;
  procedure SysInitialize; virtual;
  procedure SysFinalize; virtual;
  procedure SysBeforeExecute; virtual;
  procedure SysAfterExecute; virtual;
  procedure DoBeforePrepare; virtual;
  procedure DoAfterUnprepare; virtual;
  procedure DoAfterPrepare; virtual;
  procedure DoBeforeExecute; virtual;
  procedure DoAfterExecute; virtual;
  procedure DoProcessYield; virtual;
  procedure DoStatusChange; virtual;
  procedure SetPassive( AValue: boolean ); virtual;
  procedure SetYield( AValue: boolean ); virtual;
  function NeedTimerNotifications: boolean; override;
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{: Method to abort the execution of the process.
<br><br>
Yield must be true in order for this to be an accessible option to the user
via. a dialog or button of some sort.}
  procedure AbortExecuting;
{: Method to begin execution of the process.}
  procedure Execute;
{: Method to prepare for the execution of the process.}
  procedure Prepare;
{: Method to reverse the preparation for the execution of the process.}
  procedure Unprepare;
{: Method to hook into the internal passive task processing.}
  procedure ProcessPassiveTasks( var IsDone,
                                     IsWaiting,
                                     Terminate: boolean ); override;
{: Flag which returns whether or not the process is currently executing.}
  property Executing: boolean read FExecuting;
{: Flag which returns whether or not the process execution was aborted.}
  property ExecutingAborted: boolean read GetExecutingAborted;
{: Flag which returns whether or not the process execution was successful.}
  property ExecutingFailed: boolean read FExecutingFailed;
{: This is a way to tell if the process has been flagged with a task to
accomplish without having to actually execute the process.
<br><br>
It will always return true if the process is in Passive mode and it is currently
executing.}
  function NeedToExecute: boolean;
{: This property is designed to allow a process to be executed a piece at a
time. In passive mode the Execute method is called over and over again until it
is finally completed.
<br><br>
An example could be to hook a process up to the Application.OnIdle event. In
this event you would call the Execute method and then return whether the process
was still executing or not as the Done parameter. You must keep calling Execute
until the process returns Executing property returns false.}
  property Passive: boolean read FPassive write SetPassive;  
{: Flag to determine if Execution can occur.}
  property Prepared: boolean read FPrepared write SetPrepared;
{: This tells the result of the process.}
  property ProcessResult: TIB_ProcessResult read FProcessResult;
{: Determines if an Application.ProcessMessages should be called during
the execution of the process.}
  property Yield: boolean read FYield write SetYield default true;
{: Event notification that execution is about to begin.
<br><br>
If you wish to prevent execution simply raise an exception and no action
will be taken. The AfterExecute event will not be triggered in this case.}
  property BeforeExecute: TNotifyEvent read FBeforeExecute write FBeforeExecute;
{: Event notification that execution has ended.
<br><br>
This event will not be triggered in an exception is raised in the
BeforeExecute event. Otherwise, regardless of an exception in the process
this event will be triggered.
<br><br>
To check if an exception was raised or the process was aborted check the
ExecutingAborted and ExecutingFailed properties.}
  property AfterExecute: TNotifyEvent read FAfterExecute write FAfterExecute;
{: The process is about to be prepared.}
  property BeforePrepare: TNotifyEvent read FBeforePrepare write FBeforePrepare;
{: The process has just been prepared.}
  property AfterPrepare: TNotifyEvent read FAfterPrepare write FAfterPrepare;
{: The process has been unprepared.}
  property AfterUnprepare: TNotifyEvent read FAfterUnprepare
                                        write FAfterUnprepare;
{: Notification when the process changes state.}
  property OnStatusChange: TNotifyEvent read FOnStatusChange
                                        write FOnStatusChange;
end;

{: This class simply provides a link to the connection and prepares or unprepares the
process depending on events the connection generates.}
TIB_ConnectionProcess = class ( TIB_Process )
private
  FCL: TIB_ConnectionLink;
protected
  function GetConnection: TIB_Connection;
  procedure SetConnection( AValue: TIB_Connection ); virtual;
  procedure ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                    AEvent: TIB_ConnectionEventType ); virtual;
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
published
  property IB_Connection: TIB_Connection read GetConnection write SetConnection;
end;

implementation

constructor TIB_Process.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIsProcess := true;
  FYield := true;
  FPassive := false;
  FPreventPassive := true;
end;

destructor TIB_Process.Destroy;
begin
  if Executing then
  begin
    AbortExecuting;
    if Passive then
      Execute
    else
    begin
      SetProcessResult;
      SysFinalize;
    end;
  end;
  Prepared := false;
  inherited Destroy;
end;

function TIB_Process.GetExecutingAborted: boolean;
begin
  Result := FExecutingAbortInit <> FExecutingAbortGen;
end;

procedure TIB_Process.SetPrepared( AValue: boolean );
begin
  if Prepared <> AValue then
  begin
    if AValue then
      Prepare
    else
      Unprepare;
  end;
end;

procedure TIB_Process.SetPassive( AValue: boolean );
begin
  if Passive <> AValue then
  begin
    if AValue and FPreventPassive then
      raise Exception.Create( 'This process does not support Passive mode' );
    FPassive := AValue;
  end;
end;

procedure TIB_Process.SetYield( AValue: boolean );
begin
  FYield := AValue;
end;

procedure TIB_Process.Prepare;
begin
  if not Prepared then
  begin
    DoBeforePrepare;
    SysPrepare;
    FPrepared := true;
    DoAfterPrepare;
    DoStatusChange;
    IB_Session.ResetTimerNotification( Self );
  end;
end;

procedure TIB_Process.Unprepare;
begin
  if Executing then
  begin
    if Passive then
    begin
      AbortExecuting;
      Execute;
    end
    else
    if not ExecutingAborted then
      raise EIB_Error.Create( E_Cant_Unprepare_executing_process );
  end;
  if Prepared then
  begin
    SysUnprepare;
    FPrepared := false;
    DoAfterUnprepare;
    DoStatusChange;
    IB_Session.ResetTimerNotification( Self );
  end;
end;

procedure TIB_Process.Execute;
var
  IsDone: boolean;
begin
  if not Prepared then Prepare;
  if Prepared then
  begin
    if Passive or not Executing then
    begin
      if not Executing then SysBeforeExecute;
      try
        try
          BeginBusy( Yield );
          try
            if not Executing then
            begin
              SysInitialize;
              if FExecutingAbortInit < MaxInt - High( Word ) then
                Inc( FExecutingAbortInit )
              else
                FExecutingAbortInit := 0;
              FExecutingAbortGen := FExecutingAbortInit;
              FExecuting := true;
              FExecutingFailed := false;
              DoStatusChange;
            end;
            try
              IsDone := false;
              if Passive and not ExecutingAborted then
                SysExecute( IsDone );
              while not IsDone and not Passive and not ExecutingAborted do
              begin
                IsDone := true;
                SysExecute( IsDone );
                if Yield and not IsDone and not ExecutingAborted then
                  DoProcessYield;
              end;
            except
              on E: Exception do
              begin
                if E is EAbort then AbortExecuting
                               else FExecutingFailed := true;
                raise;
              end;
            end;
          finally
            if ExecutingFailed or ExecutingAborted then IsDone := true;
            if IsDone then
            begin
              SetProcessResult;
              SysFinalize;
            end;
          end;
        finally
          if IsDone then FExecuting := false;
          EndBusy;
        end;
      finally
        if IsDone then
        begin
          SysAfterExecute;
          DoStatusChange;
        end;
      end;
    end
    else
      raise Exception.Create( 'Executing already or not in Passive mode' );
  end
  else
    raise Exception.Create( 'Process failed to prepare' );
end;

function TIB_Process.NeedToExecute: boolean;
begin
  Result := Prepared;
  if Result and not( Passive and Executing ) then
    Result := SysNeedToExecute;
end;

procedure TIB_Process.SysBeforeExecute;
begin DoBeforeExecute; end;
procedure TIB_Process.SysAfterExecute;
begin DoAfterExecute; end;
procedure TIB_Process.DoBeforeExecute;
begin if Assigned( FBeforeExecute ) then FBeforeExecute( Self ); end;
procedure TIB_Process.DoAfterExecute;
begin if Assigned( FAfterExecute ) then FAfterExecute( Self ); end;
procedure TIB_Process.DoBeforePrepare;
begin if Assigned( FBeforePrepare ) then FBeforePrepare( Self ); end;
procedure TIB_Process.DoAfterPrepare;
begin if Assigned( FAfterPrepare ) then FAfterPrepare( Self ); end;
procedure TIB_Process.DoAfterUnprepare;
begin if Assigned( FAfterUnprepare ) then FAfterUnprepare( Self ); end;
procedure TIB_Process.AbortExecuting;
begin if FExecutingAbortGen < MaxInt then Inc( FExecutingAbortGen ) else
                                               FExecutingAbortGen := 0; end;
procedure TIB_Process.SysPrepare;
begin FPrepared := true; end;
procedure TIB_Process.SysUnprepare;
begin FPrepared := false; end;
procedure TIB_Process.SysInitialize;
begin FProcessResult := prIncomplete; end;
procedure TIB_Process.SysFinalize;
begin
end;
procedure TIB_Process.SetProcessResult;
begin
  if ExecutingAborted then
    FProcessResult := prAborted
  else
  if ExecutingFailed then
    FProcessResult := prFailed
  else
  if SysWasCompleted then
    FProcessResult := prCompleted
  else
    FProcessResult := prAbandoned;
end;
procedure TIB_Process.SysExecute( var IsDone: boolean );
begin
//raise Exception.Create( 'Nothing to execute' );
end;
function TIB_Process.SysNeedToExecute: boolean;
begin Result := false end;
function TIB_Process.SysWasCompleted: boolean;
begin Result := true; end;
function TIB_Process.NeedTimerNotifications: boolean;
begin Result := Prepared; end;
procedure TIB_Process.ProcessPassiveTasks( var IsDone,
                                               IsWaiting,
                                               Terminate: boolean );
begin
  if Passive and NeedToExecute then Execute;
  IsDone := not Executing;
  IsWaiting := NeedToExecute;
  Terminate := ExecutingAborted or ExecutingFailed;
  inherited ProcessPassiveTasks( IsDone, IsWaiting, Terminate );
end;
procedure TIB_Process.DoProcessYield;
begin
  if Yield and not Passive then
    try
      Application.ProcessMessages;
    except
      on E: Exception do
        Application.HandleException( E );
    end;
end;

procedure TIB_Process.DoStatusChange;
begin
  if Assigned( OnStatusChange ) then OnStatusChange( Self );
end;

{----------------------------------------------------------------------------------------}

constructor TIB_ConnectionProcess.Create( AOwner: TComponent );
begin
  FCL := TIB_ConnectionLink.Create( Self );
  inherited Create( AOwner );
  FCL.OnProcessEvent := ProcessConnectionEvent;
end;

destructor TIB_ConnectionProcess.Destroy;
begin
  FCL.OnProcessEvent := nil;
  inherited Destroy;
end;

function TIB_ConnectionProcess.GetConnection: TIB_Connection;
begin
  Result := FCL.IB_Connection;
end;

procedure TIB_ConnectionProcess.SetConnection( AValue: TIB_Connection );
begin
  FCL.IB_Connection := AValue;
end;

procedure TIB_ConnectionProcess.ProcessConnectionEvent(
  AConnectionLink: TIB_ConnectionLink;
  AEvent: TIB_ConnectionEventType );
begin
  if AEvent in [ cetBeforeAssignment,
                 cetBeforeDisconnect,
                 cetBeforeDropDatabase ] then
    Unprepare;
end;

end.
