
{                                                                              }
{ IB_Events                                                                    }
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
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  09/30/2002                                                                  }
{     I changed the event dispatching so that it doesn't have to eat the       }
{     exceptions while processing events. If an exception takes place it will  }
{     leave it raised if it is other than EAbort. Then, the flag indicating    }
{     that events are pending will be left true so they will still process.    }
{     I also have it suppress announcing the events which have zero counts.    }
{            Copyright (C) 2002 Jason Wharton                                  }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit encapsulates the InterBase event functionality.
<br><br>
It contains the IB_Events component.}
unit
  IB_Events;

interface

uses
  SysUtils, Windows, Messages, Classes, Forms, ExtCtrls,  

  IB_Constants,
  IB_Header,
  IB_Session,
  IB_Components;

type
{: Event type for the notification received from the database.
<br><br>
AEventName is the name of the event that was posted and registered for
receiving notification.
<br><br>
AEventCount is the number of accumulated POST_EVENT counts since the last
event notification was received and processed.
<br><br>
Each event is handled separately and only if the event count is more than zero.}
TIB_EventAlert = procedure( Sender: TObject;
                            AEventName: string;
                            AEventCount: longint ) of object;
{: This component is used to encapsulate InterBase's event functionality.
<br><br>
It is much more stable and flexible than all known components that deliver
this unique and powerful feature of InterBase.
<br><br>
It takes care of all multi-threading issues by using synchronous event
notification instead of processing the events immediately in a sub-thread.
<br><br>
To use this component fill in the Events property with the names of the
events for which a registered interest exists. Each IB_Events component can
handle only 16 event names. This is an InterBase limitation.
<br><br>
Then call the RegisterEvents method or set Registered to true.
<br><br>
Either assign an OnEventAlert event handler or override the DoEventAlert()
method and build-in your own custom event handling logic. If you need
Asynchroneous processing of the events then use System.BeginThread() to spawn
a new thread or a TThread sub-class instance to do the asynchronous
processing that you need performed.
<br><br>
It has been my observation that when using a remote server that TCP/IP
is more reliable and stable than NetBEUI. If you are using NT 4.0 SP 3 then
you will need to get a MS hot-fix for NT due to a bug in the OS. This can be
accessed at:
<br><br>
<a HREF="ftp://ftp.microsoft.com
/bussys/winnt/winnt-public/fixes/usa/NT40/hotfixes-postSP3/teardrop2-fix">
ftp://ftp.microsoft.com
/bussys/winnt/winnt-public/fixes/usa/NT40/hotfixes-postSP3/teardrop2-fix</a>
<br><br>
LIBS has always worked just fine and does not need this patch applied.}
TIB_Events = class( TIB_Component )
private
{ Utility storage }
  EventCS: TRTLCriticalSection;
  ResultBuffer: pchar;
  EventBuffer: pchar;
  EventBufferLen: integer;
  EventID: isc_long;
  RegisteringEvents: boolean;
  CancelingEvents: boolean;
  QueingEvents: boolean;
  Queued: boolean;
  SkipNextAlert: boolean;
  RegisteredState: boolean;
{ Property Storage & Methods }
  FCL: TIB_ConnectionLink;
  FProcessingEvents: boolean;
  FEventsPending: boolean;
  FEvents: TIB_StringList;
  FRegistered: boolean;
  FPassive: boolean;
  FTimer: TTimer;
  FAlertOnRegister: boolean;
  FOnEventAlert: TIB_EventAlert;
  FOnWakeup: TNotifyEvent;
  FBeforeRegister: TNotifyEvent;
  FBeforeUnregister: TNotifyEvent;
  FAfterRegister: TNotifyEvent;
  FAfterUnregister: TNotifyEvent;
  FEventCounts: status_vector;
  FEventsReceived: boolean;
  function GetConnection: TIB_Connection;
  procedure SetConnection( AValue: TIB_Connection );
  function GetEvents: TStrings;
  procedure SetEvents( AValue: TStrings );
  function GetEventsPending: boolean;
  function GetInterval: cardinal;
  procedure SetInterval( AValue: cardinal );
  procedure SetRegistered( AValue: boolean );
  function GetWakeup: TNotifyEvent;
  procedure SetWakeup( AValue: TNotifyEvent );
  procedure SetPassive( AValue: boolean );
{ Utility Methods }
  procedure API_Register;
  procedure API_QueueEvents;
  procedure API_CancelEvents;
  procedure CheckConnection;
  procedure EventChange( Sender: TObject );
  procedure EventChanging( Sender: TObject );
  procedure ReceiveTimer( Sender: TObject );
  procedure UpdateTimer;
protected
{ Utility Methods }
  procedure Loaded; override;
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation ); override;
  function NeedTimerNotifications: boolean; override;
  procedure DoAfterRegister; virtual;
  procedure DoBeforeRegister; virtual;
  procedure DoAfterUnregister; virtual;
  procedure DoBeforeUnregister; virtual;
  procedure DoEventAlert( AEventName: string; AEventCount: integer ); virtual;
  procedure ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                    AEvent: TIB_ConnectionEventType ); virtual;
  property EventsReceived: boolean read FEventsReceived;
public
{$IFNDEF HELPSCAN}
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{$ENDIF}
{: This method will check for events and dispatch them if necessary.
<br><br>
Please refer to the example with the
<see class=TIB_Events event=OnWakeup> event for more information.}
  procedure CheckEvents;
{: Register specified events to receive notification from the database.}
  procedure RegisterEvents;
{: Cancel notification requests for specified events.}
  procedure UnregisterEvents;
{: Override of the base class method in TIB_Component.
<br><br>
This is where the check for events is done when Passive is set to true and the
session is processing PassiveTasks. Normally you won't have to call this method
directly.}
  procedure ProcessPassiveTasks( var IsDone,
                                     IsWaiting,
                                     Terminate: boolean ); override;
{: Status flag that tells if there are events pending or not.}
  property EventsPending: boolean read GetEventsPending;
{: Status flag to tell if events are currently being processed.}
  property ProcessingEvents: boolean read FProcessingEvents;
{: Allow customization of how events are synchronized instead of using the
default TTimer based mechanism.
<br><br>
This event must be kept thread-safe because it is invoked from the context of
the AST callback in a separate thread originating from the GDS32.DLL session.
@example
This example shows how a secondary thread could be used to wait for event
notification and then process events when they occurred.
<br>
<code>
//not the main thread, separate IB_Session & IB_Connection
procedure TMyDatamodule.RegisterAndWait;
begin
  IB_Events.OnWakeup := Wakeup;
  IB_Events.RegisterEvents;
  repeat
    if WaitForSingleObject(FMyWakeupEvent) = OBJECT_0 then
      IB_Events.CheckEvents; //this will fire on OnEventAlert
  until ... whatever ;
end;

procedure TMyDatamodule.Wakeup;
begin
  SetEvent(FMyWakeupEvent);
end;

</code>}
  property OnWakeup: TNotifyEvent read GetWakeup write SetWakeup;

published

{: Registered status of the events.}
  property Registered: boolean read FRegistered
                               write SetRegistered
                               default false;
{: This property causes an alert to fire upon registration.
<br><br>
The counts for the first time will all be one and then if it is unregistered
and then reregistered it will be the total count of all events since the
first time it was registered plus the first one.
<br><br>
@bug I did notice an occasional garbage number slip into the counts if rapidly
toggling the Registered property.}
  property AlertOnRegister: Boolean read FAlertOnRegister
                                    write FAlertOnRegister;
{: Interval of time between instances where a flag is polled checking for an
event notification from the database. If an event has been received then
upon checking the flag the main thread will call the OnEventAlert.
<br><br>
This corresponds to the Interval property of the internal TTimer used to
accomplish this. Therefore, these synchronous event notifications are
processed in a TTimer.OnTimer event execution.}
  property Interval: cardinal read GetInterval write SetInterval default 250;
{: Reference to the database which will be generating event notifications.
<br><br>
It has been my observation that when using a remote server that TCP/IP
is more reliable and stable than NetBEUI. If you are using NT 4.0 SP 3 then
you will need to get a MS hot-fix for NT due to a bug in the OS. This can be
accessed
at <a HREF="ftp://198.105.232.37/fixes/usa/nt40/hotfixes-postSP3/icmp-fix/">
here</a> unless MS changes it to something else.
<br><br>
The NT bug has to do with OOB (Out of Band) processing.
<br><br>
LIBS has always worked just fine.}
  property IB_Connection: TIB_Connection read GetConnection
                                         write SetConnection;
{: List of event names to be monitored and receive notification for.
<br><br>
This list may be changed while the Registered property is true. In this case,
the events are automatically unregistered and re-registered for you.}
  property Events: TStrings read GetEvents write SetEvents;
{: This property indicates that you will take care of checking for events and that there
is no need for it to use the internal timer to check for events.}  
  property Passive: boolean read FPassive write SetPassive;
{: Event where notification is received from the databse.}
  property OnEventAlert: TIB_EventAlert read FOnEventAlert write FOnEventAlert;
{: Event hook for added flexibility.}
  property BeforeRegister: TNotifyEvent read FBeforeRegister
                                        write FBeforeRegister;
{: Event hook for added flexibility.}
  property BeforeUnregister: TNotifyEvent read FBeforeUnregister
                                          write FBeforeUnregister;
{: Event hook for added flexibility.}
  property AfterRegister: TNotifyEvent read FAfterRegister
                                       write FAfterRegister;
{: Event hook for added flexibility.}
  property AfterUnregister: TNotifyEvent read FAfterUnregister
                                         write FAfterUnregister;

{$I IB_Component.PBL}

end;

implementation

var
  EventListCS: TRTLCriticalSection;
  EventList: TList;

constructor TIB_Events.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FPassive := false;
  InitializeCriticalSection( EventCS );
  FCL := TIB_ConnectionLink.Create( Self );
  FCL.OnProcessEvent := ProcessConnectionEvent;
  FEvents := TIB_StringList.Create;
  FEvents.OnChange := EventChange;
  FEvents.OnChanging := EventChanging;
  FEvents.Duplicates := dupIgnore;
  FTimer := TTimer.Create( Self );
  FTimer.OnTimer := ReceiveTimer;
  FTimer.Interval := 250;
  FEventsReceived := false;
  try
    EnterCriticalSection( EventListCS );
    if not Assigned( EventList ) then
      EventList := TList.Create;
    EventList.Add( Self );
  finally
    LeaveCriticalSection( EventListCS );
  end;
end;

destructor TIB_Events.Destroy;
begin
  try
    UnregisterEvents;
  except
  // Ignore this possibility here.
  end;
  FTimer.OnTimer := nil;
  try
    EnterCriticalSection( EventListCS );
    EventList.Remove( Self );
    if EventList.Count = 0 then
    begin
      EventList.Free;
      EventList := nil;
    end;
  finally
    LeaveCriticalSection( EventListCS );
  end;
  IB_Connection := nil;
  FCL.OnProcessEvent := nil;
  DeleteCriticalSection( EventCS );
  FTimer.Free;   // For some reason someone reported this not being properly
  FTimer := nil; // freed by the owning component. So, I put this here in case.
  inherited Destroy;
  FEvents.Free;
  FEvents := nil;
end;

procedure TIB_Events.Notification( AComponent: TComponent;
                                   Operation: TOperation);
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( AComponent = IB_Connection ) then
    IB_Connection := nil;
end;

procedure TIB_Events.Loaded;
begin
  inherited Loaded;
  try
    Registered := RegisteredState;
  except
    if csDesigning in ComponentState then
      Application.HandleException( Self )
    else
      raise;
  end;
end;

function TIB_Events.NeedTimerNotifications: boolean;
begin
  Result := Registered and Passive and not (csDesigning in ComponentState);
end;

procedure TIB_Events.ProcessPassiveTasks( var IsDone,
                                              IsWaiting,
                                              Terminate: boolean );
begin
  if EventsPending then
  begin
    CheckEvents;
    IsDone := not EventsPending;
  end;
  inherited ProcessPassiveTasks( IsDone, IsWaiting, Terminate );
end;

procedure TIB_Events.DoAfterRegister;
begin if Assigned( FAfterRegister ) then FAfterRegister( Self ); end;
procedure TIB_Events.DoBeforeRegister;
begin if Assigned( FBeforeRegister ) then FBeforeRegister( Self ); end;
procedure TIB_Events.DoAfterUnregister;
begin if Assigned( FAfterUnregister ) then FAfterUnregister( Self ); end;
procedure TIB_Events.DoBeforeUnregister;
begin if Assigned( FBeforeUnregister ) then FBeforeUnregister( Self ); end;

function TIB_Events.GetConnection: TIB_Connection;
begin
  Result := FCL.IB_Connection
end;

procedure TIB_Events.SetConnection( AValue: TIB_Connection );
begin
  FCL.IB_Connection := AValue;
  if Assigned( IB_Connection ) then
    IB_Connection.FreeNotification( Self );
end;

procedure TIB_Events.SetRegistered( AValue: boolean );
begin
  if csReading in ComponentState then
    RegisteredState := AValue
  else
  if Registered <> AValue then
  begin
    if AValue then
      RegisterEvents
    else
      UnregisterEvents;
  end;
end;

function TIB_Events.GetEvents: TStrings;
begin
  Result := FEvents; 
end;

procedure TIB_Events.SetEvents( AValue: TStrings );
begin
  FEvents.Assign( AValue );
end;

function TIB_Events.GetEventsPending: boolean;
begin
  EnterCriticalSection( EventCS );
  try
    Result := FEventsPending;
  finally
    LeaveCriticalSection( EventCS );
  end;
end;

function TIB_Events.GetInterval: cardinal;
begin
  Result := FTimer.Interval;
end;

procedure TIB_Events.SetInterval( AValue: cardinal );
begin
  FTimer.Interval := AValue;
end;

function TIB_Events.GetWakeup: TNotifyEvent;
begin
  EnterCriticalSection( EventCS );
  try
    Result := FOnWakeUp;
  finally
    LeaveCriticalSection( EventCS );
  end;
end;

procedure TIB_Events.SetWakeup( AValue: TNotifyEvent );
begin
  EnterCriticalSection( EventCS );
  try
    FOnWakeUp := AValue;
    UpdateTimer;
  finally
    LeaveCriticalSection( EventCS );
  end;
end;

procedure TIB_Events.SetPassive( AValue: boolean );
begin
  if FPassive <> AValue then
  begin
    FPassive := AValue;
    UpdateTimer;
  end;
end;

procedure TIB_Events.CheckConnection;
begin
  if IB_Connection = nil then
    IB_Connection := IB_Session.DefaultConnection;
  if IB_Connection = nil then 
    raise EIB_StatementError.Create( E_NO_CONNECTION );
  IB_Connection.Connected := true;
  if not IB_Connection.Connected then
    raise EIB_Error.Create( E_NO_CONNECTION );
end;

procedure TIB_Events.ProcessConnectionEvent(
  AConnectionLink: TIB_ConnectionLink;
  AEvent: TIB_ConnectionEventType );
begin
  if AEvent in [ cetBeforeAssignment, cetBeforeDisconnect ] then
  begin
    if not RegisteringEvents then
      UnregisterEvents;
  end
  else
  if AEvent in [ cetAfterAssignment ] then
    if RegisteredState and
       not Registered and
       not RegisteringEvents and
       Assigned( IB_Connection ) then
      RegisterEvents;
end;

procedure TIB_Events.EventChanging( Sender: TObject );
begin
  if ProcessingEvents then raise EIB_Error.Create( E_Cannot_Change_Events );
end;

procedure TIB_Events.EventChange( Sender: TObject );
var
  ii: integer;
  tmpStr: string;
begin
  with FEvents do
  begin
    OnChange := nil;
    try
      for ii := Count - 1 downto 0 do
      begin
        tmpStr:= Trim( Strings[ii] );
        tmpStr := Copy( tmpStr, 1, IB_EventLength );
        if Length( tmpStr ) = 0 then
          Delete( ii )
        else
          Strings[ii] := tmpStr;
      end;
    finally
      OnChange := EventChange;
    end;
    if Count > IB_MaxEvents then
      raise EIB_Error.Create( E_MAX_EVENTS_BLOCK );
  end;
  if Registered then
    RegisterEvents;
end;

procedure TIB_Events.UpdateTimer;
begin
  IB_Session.ResetTimerNotification( Self );
  FTimer.Enabled := Registered and not Passive and
                                   not FProcessingEvents and
                                   not Assigned( OnWakeup ) and
                                   not (csDesigning in ComponentState);
end;

procedure TIB_Events.RegisterEvents;
begin
  if not RegisteringEvents then
    try
      RegisteringEvents := true;
      if Registered then
        UnregisterEvents
      else
        CheckConnection;
      DoBeforeRegister;
      FRegistered := true;
      if not (( csDesigning in ComponentState ) or ( FEvents.Count = 0 )) then
      begin
        EnterCriticalSection( EventCS );
        try
          API_Register;
          API_QueueEvents;
          SkipNextAlert := not FAlertOnRegister;
          FEventsPending := false;
          FEventsReceived := false;
        finally
          LeaveCriticalSection( EventCS );
        end;
      end;
      RegisteredState := false;
    // Avoids a bug in event alerter when closing app.
      if ( IB_Connection.Protocol <> cpLocal ) {and
         ( IB_Connection.Characteristics.dbODS_VERSION < 10 )} then
        IB_Connection.RequestReconnect;
      DoAfterRegister;
    finally
      RegisteringEvents := false;
      UpdateTimer;
    end;
end;

procedure TIB_Events.UnregisterEvents;
begin
  if Registered then
  begin
    if ProcessingEvents then
      raise EIB_Error.Create( E_Cannot_Unregister_Events );
    DoBeforeUnregister;
    FRegistered := false;
    UpdateTimer;
    EnterCriticalSection( EventCS );
    try
      if Queued then
        API_CancelEvents;
      if EventBufferLen > 0 then
      begin
        isc_free( EventBuffer );
        EventBuffer := nil;
        isc_free( ResultBuffer );
        ResultBuffer := nil;
        EventBufferLen := 0;
      end;
      FEventsPending := false;
      FEventsReceived := false;
    finally
      LeaveCriticalSection( EventCS );
    end;
    DoAfterUnregister;
  end;
end;

// AST trap function used to receive database event notifications.
procedure IBEventCallback( ptr: pointer; length: short; updated: PChar ); cdecl;
var
  AEvents: TIB_Events absolute ptr;
  ii: integer;
  IsValid: boolean;
begin
  EnterCriticalSection( EventListCS );
  try
    IsValid := Assigned( EventList ) and
               ( EventList.IndexOf( AEvents ) <> -1 ) and
               not ( AEvents.CancelingEvents or not AEvents.Registered );
  finally
    LeaveCriticalSection( EventListCS );
  end;
  if IsValid then
  begin
    EnterCriticalSection( AEvents.EventCS );
    try
      AEvents.Queued := false;
      if Assigned( AEvents.ResultBuffer ) then
      begin
        for ii := 0 to length - 1 do
          AEvents.ResultBuffer[ii] := updated[ii];
        if not AEvents.FEventsPending then
        begin
          AEvents.FEventsPending := true;
          if Assigned( AEvents.FOnWakeup ) then
            AEvents.FOnWakeup( AEvents )
          else
            AEvents.DoWakeUp( AEvents );
        end
        else
        if AEvents.SkipNextAlert then
          AEvents.SkipNextAlert := false;
      end
      else
        AEvents.FEventsPending := false;
    finally
      LeaveCriticalSection( AEvents.EventCS );
    end;
  end;
end;

procedure TIB_Events.ReceiveTimer( Sender: TObject );
begin
  CheckEvents;
end;

procedure TIB_Events.CheckEvents;
var
  ii: integer;
begin
  if Registered and not ProcessingEvents then
  try
    FProcessingEvents := true;
    UpdateTimer;
{ TryEnterCriticalSection( EventCS ) is for WINNT only but I think it would    }
{ be the best to use here in this spot.                                        }
//    if TryEnterCriticalSection( EventCS ) then
    EnterCriticalSection( EventCS );
    try
      if not EventsReceived and FEventsPending then
      begin
        FEventsPending := false;
        isc_event_counts( @FEventCounts,
                          EventBufferLen,
                          EventBuffer,
                          ResultBuffer );
        FEventsReceived := true;
      end;
    finally
      LeaveCriticalSection( EventCS );
    end;
    if EventsReceived then
    begin
      if SkipNextAlert then
        SkipNextAlert := false
      else
        for ii := FEvents.Count - 1 downto 0 do
          if FEventCounts[ii] > 0 then
            try
              if FEventCounts[ii] > 0 then
              begin
                DoEventAlert(FEvents[FEvents.Count - ii - 1], FEventCounts[ii]);
                FEventCounts[ii] := 0;
              end;
            except
              on E: Exception do
              begin
                if E is EAbort then
                  FEventCounts[ii] := 0
                else
                  raise;
              end;
            end;
      FEventsReceived := false;
    end;
  finally
    FProcessingEvents := false;
  end;
  if Registered then
  begin
{ TryEnterCriticalSection( EventCS ) is for WINNT only but I think it would    }
{ be the best to use here in this spot.                                        }
//    if TryEnterCriticalSection( EventCS ) then
    EnterCriticalSection( EventCS );
    try
      if not Queued then
        API_QueueEvents;
    finally
      LeaveCriticalSection( EventCS );
    end;
  end;
  UpdateTimer;
end;

procedure TIB_Events.DoEventAlert( AEventName: string; AEventCount: integer );
begin
  if Assigned( FOnEventAlert ) then
    FOnEventAlert( Self, AEventName, AEventCount )
end;

{------------------------------------------------------------------------------}

type
  TIB_EventBuffer = array[0..IB_MaxEvents - 1,
                          0..IB_EventLength - 1] of char;

procedure TIB_Events.API_Register;
var
  ii: integer;
  bufptr: pointer;
  eventbufptr: pointer;
  resultbufptr: pointer;
  buflen: integer;
  Buffer: TIB_EventBuffer;
  local_isc_event_block: Tisc_event_block;
begin
  for ii := 0 to FEvents.Count - 1 do
    StrPCopy( @Buffer[ii][0], FEvents[ii] );
  ii := FEvents.Count;
  bufptr := @Buffer[0];
  eventbufptr := @EventBuffer;
  resultbufptr := @ResultBuffer;
  local_isc_event_block := isc_event_block;
  asm
    mov  ecx,  dword ptr [ii]
    mov  eax,  dword ptr [bufptr]
    @@1:
    push eax
    add  eax,  IB_EventLength
    loop @@1
    push dword ptr [ii]
    push dword ptr [resultBufPtr]
    push dword ptr [eventBufPtr]
    call [local_isc_event_block]
    mov  dword ptr [bufLen], eax
    mov  eax,  dword ptr [ii]
    shl  eax,  2
    add  eax,  12
    add  esp,  eax
  end;
  EventBufferLen := Buflen;
end;

procedure TIB_Events.API_QueueEvents;
var
  ast: pointer;
begin
  if not QueingEvents then
  begin
    QueingEvents := true;
    try
      ast := @IBEventCallback;
      with IB_Session do
      begin
        errcode := isc_que_events( @status,
                                   IB_Connection.PdbHandle,
                                   @EventID,
                                   EventBufferLen,
                                   EventBuffer,
                                   isc_callback( ast ),
                                   Self );
        if errcode <> 0 then HandleException( Self );
      end;
      Queued := true;
    finally
      QueingEvents := false;
    end;
  end;
end;

procedure TIB_Events.API_CancelEvents;
begin
  if not CancelingEvents then
  begin
    CancelingEvents := true;
    try
      FEventsPending := false;
      FEventsReceived := false;
      with IB_Session do
        errcode := isc_cancel_events( @status,
                                      IB_Connection.PdbHandle,
                                      @EventID );
      if Queued then
        Queued := false;
    finally
      CancelingEvents := false;
    end;
  end;
end;

initialization
  System.IsMultiThread := true;
  InitializeCriticalSection( EventListCS );

finalization
  try
    try
      EnterCriticalSection( EventListCS );
      while Assigned( EventList ) do
        TIB_Events( EventList[0] ).Free;
    finally
      LeaveCriticalSection( EventListCS );
    end;
  finally
    DeleteCriticalSection( EventListCS );
  end;

end.

