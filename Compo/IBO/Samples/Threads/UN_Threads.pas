unit UN_Threads;

// I have this directive so that I can easily switch between using the tick
// based timings or simply watch the record count one by one.

// I am trying to get an idea of how well IB load balances simultaneous queries.

{$DEFINE USETICKS}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Session, IB_Components, DM_Threads;

type
  TSaferThread = class(TThread)
  public
    constructor Create(CreateSuspended: Boolean; AOnTerminate: TNotifyEvent);
    function SaferWaitFor: DWORD;
    destructor Destroy; override;
    property Terminated;
  end;

  TMyThread = class(TSaferThread)
  private
    FThreadIndex: Integer;
{$IFDEF USETICKS}
    TicksInc: DWORD;
    NewTicks: DWORD;
    StartTicks: DWORD;
    LastTicks: DWORD;
    LastRowNum: longint;
{$ENDIF}
    dmThreads: TdmThreads;
  protected
    procedure Execute; override;
    procedure UpdateLabel;
  public
    FExceptionMsg: string;
    constructor Create(AThreadIndex: Integer; AOnTerminate: TNotifyEvent);
    property ThreadIndex: Integer read FThreadIndex;
  end;

implementation

uses FRM_Threads;

{$IFNDEF VER110}
var CSCreateDestroyDM: TRTLCriticalSection;
{$ENDIF}

constructor TSaferThread.Create(CreateSuspended: Boolean; AOnTerminate: TNotifyEvent);
begin
  FreeOnTerminate := true; //thread free's itself, don't call .free
  OnTerminate := AOnTerminate; //the OnTerminate handler should set the pointer
                               //var to this thread to nil
  inherited Create(CreateSuspended);
end;

destructor TSaferThread.Destroy;
begin
  //it's assumed FFishied=true, but can't check because it's private in TThread

  if Handle <> 0 then CloseHandle(Handle);

  //Don't call inherited Destroy to avoid calling RemoveThread. Don't laugh, RemoveThread
  //isn't thread save, for two reasons: 1. It does Dec(ThreadCount) asynchronous to the
  //main thread instead of InterlockedDecrement(ThreadCount) what would be SMP-safe.
  //2. If ThreadCount becomes zero RemoveThread does a PostMessage(ThreadWindow, CM_DESTROYWINDOW)
  //to synchronize with the main thread and instruct the ThreadWindow to destroy itself.
  //This is very dangerous because it's not unlikely that a new thread is started in the
  //meantime (before the appeneded CM_DESTROYWINDOW is picked out of the main-thread message queue)
  //that relies on an existing ThreadWindow. Since it's not very useful to destroy the
  //ThreadWindow every time the (unsafe) ThreadCount becomes zero and also the inherited
  //TThread.Destroy not TObject.Destroy does nothing else that I really need, I workaround this
  //problem by just not calling these methods.
end;

function TSaferThread.SaferWaitFor: DWORD;
var
  Msg: TMsg;
  H: THandle;
begin
  //duplicate handle to be able to do GetExitCodeThread at the end of this method
  Win32Check( DuplicateHandle( GetCurrentProcess,
                               Handle,
                               GetCurrentProcess,
                               @H,
                               0,
                               false,
                               DUPLICATE_SAME_ACCESS ));
  if GetCurrentThreadID = MainThreadID then
    while MsgWaitForMultipleObjects( 1, H, False, INFINITE,
                                     QS_SENDMESSAGE ) = WAIT_OBJECT_0 + 1 do
      PeekMessage( Msg, 0, 0, 0, PM_NOREMOVE )
  else
    WaitForSingleObject( H, INFINITE );
  Win32Check( GetExitCodeThread( H, Result ));
  Win32Check( CloseHandle( H ));
end;

constructor TMyThread.Create(AThreadIndex: Integer; AOnTerminate: TNotifyEvent);
begin
// Tells which label to update.
  FThreadIndex := AThreadIndex;

{$IFDEF USETICKS}
// This is a setting for how often the thread should update the form with stats.
// It is in 1000ths of a second. For now it is set to once a second.
  TicksInc := 1000;
{$ENDIF}

// If you would like to tinker with a threads priority to see if it makes a
// difference then make the adjustments here.
  case ThreadIndex of
    1: Priority := tpNormal;
    2: Priority := tpNormal;
    3: Priority := tpNormal;
    4: Priority := tpNormal;
  end;
  inherited Create(false, AOnTerminate);
end;

procedure TMyThread.Execute;
begin
  try
  // Must create the data access components with the sub-thread and not in the
  // TMyThread constructor since it is executed by the main thread.
  // This is in order to get a new session for the sub-thread a data access
  // component must be created in order for a new thread local default
  // session to be created.

  //Creating the data modules is serialized using a critical section. This is
  //because TDataModule.CreateNew calls Screen.AddDataModule(Self) what is not
  //thread safe (Only true for Delphi Versions < 4).

  {$IFNDEF VER110}
    EnterCriticalSection(CSCreateDestroyDM);
    try
  {$ENDIF}
      dmThreads := TdmThreads.Create( nil );
  {$IFNDEF VER110}
    finally
      LeaveCriticalSection(CSCreateDestroyDM);
    end;
  {$ENDIF}
  // You will need to define your own connection parameters below.
    try
      with dmThreads do
      begin
        if Terminated then Exit;
        with cr do begin
          try
            AutoFetchFirst := false;
            Prepare;
            if Terminated then begin
              cn.Disconnect;
              Exit;
            end;
            Open;
            if Terminated then begin
              cn.Disconnect;
              Exit;
            end;
  {$IFDEF USETICKS}
          // Initialize the timing variables.
            NewTicks := GetTickCount;
            StartTicks := NewTicks;
            LastTicks := NewTicks;
            LastRowNum := 0;
  {$ENDIF}
          // Keep GUI alterations thread safe.
            if not Terminated then begin
              Synchronize(UpdateLabel);
            end;
          // Get the first record of the dataset.
            First;
          // Keep GUI alterations thread safe.
  {$IFDEF USETICKS}
            LastRowNum := RowNum;
            NewTicks := GetTickCount;
  {$ENDIF}
            if Terminated then begin
              cn.Disconnect;
            end else begin
              Synchronize(UpdateLabel);
            end;
            while not Terminated and not EOF do begin
            // Get the next record.
              Next;
            // Get the new ticks for calculating timings.
  {$IFDEF USETICKS}
              NewTicks := GetTickCount;
              if NewTicks > LastTicks + TicksInc then begin
  {$ENDIF}
              // Keep GUI alterations thread safe.
                if not Terminated then begin
                  Synchronize( UpdateLabel );
                end;
              // Increment timing variables.
  {$IFDEF USETICKS}
                LastRowNum := RowNum;
                LastTicks := NewTicks + TicksInc;
              end;
  {$ENDIF}
            end;
          finally
  {$IFDEF USETICKS}
          // Keep GUI alterations thread safe.
            LastRowNum := RowNum;
            NewTicks := GetTickCount;
  {$ENDIF}
            if not Terminated then begin
              Synchronize(UpdateLabel);
            end;
          end;
        end;
      end;
    finally
      if dmThreads.cn.Connected then dmThreads.cn.Disconnect;
  {$IFNDEF VER110}
      EnterCriticalSection(CSCreateDestroyDM);
      try
  {$ENDIF}
        dmThreads.Free;
  {$IFNDEF VER110}
      finally
        LeaveCriticalSection(CSCreateDestroyDM);
      end;
  {$ENDIF}
    end;
  except
    on E: EIB_ISCError do FExceptionMsg := E.ErrorMessage.Text;
    on E: Exception do FExceptionMsg := E.Message;
  end;
end;

procedure TMyThread.UpdateLabel;
{$IFDEF USETICKS}
var
  IncRecsPerSec: integer;
  AvgRecsPerSec: integer;
{$ENDIF}
begin
{$IFDEF USETICKS}
// Calculate the records per second for the increment.
  if ( NewTicks - LastTicks + TicksInc ) <> 0 then begin
    IncRecsPerSec := ( 1000 * ( dmThreads.cr.RowNum - LastRowNum )) div
                              ( NewTicks - LastTicks + TicksInc );
  end else begin
    IncRecsPerSec := 0;
  end;
// Calculate the average records per second for the whole query.
  if NewTicks <> StartTicks then begin
    AvgRecsPerSec := (1000 * dmThreads.cr.RowNum) div (NewTicks - StartTicks);
  end else begin
    AvgRecsPerSec := 0;
  end;
{$ENDIF}
  with frmThreads.FThreads[ThreadIndex] do
  begin
    LRowCnt.Caption := IntToStr( dmThreads.cr.RowNum );
 {$IFDEF USETICKS}
    LIncCnt.Caption  := IntToStr( dmThreads.cr.RowNum - LastRowNum);
    LIncRowPS.Caption := IntToStr( IncRecsPerSec );
    LAvg.Caption := IntToStr( AvgRecsPerSec );
 {$ENDIF}
  end;
end;

{$IFNDEF VER110}
initialization
  InitializeCriticalSection(CSCreateDestroyDM);

finalization
  DeleteCriticalSection(CSCreateDestroyDM);
{$ENDIF}

end.


