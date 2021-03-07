
{                                                                              }
{ DM_UCCSync                                                                   }
{                                                                              }

unit
  DM_UCCSync;

interface

uses
  Windows, Messages, SysUtils, Classes, SvcMgr, Dialogs,
  Psock, NMsmtp,

  IB_Session,
  IB_Constants,
  IB_Components,
  IB_DataPump,
  IB_Process,

  IB_RPL_Base,
  IB_RPL_Sync,

  IBS_Base;

type
  TsvcUCCSync = class(TsvcBase)
    cnUCCdb: TIB_Connection;
    cnUCCdb_Search: TIB_Connection;
    Lien: TIB_RPL_Sync;
    Filing: TIB_RPL_Sync;
    D_IND: TIB_RPL_Sync;
    D_ORG: TIB_RPL_Sync;
    S_IND: TIB_RPL_Sync;
    S_ORG: TIB_RPL_Sync;
    procedure cnAfterConnect(Sender: TIB_Connection);
    procedure seError(Sender: TObject; const ERRCODE: Integer;
      ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer;
      SQLMessage, SQL: TStringList; var RaiseException: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure RPLLogItem(Sender: TObject);
  private
    { Private declarations }
    WasConnected: boolean;
    KillCon: boolean;
  protected
  // These methods are the hooks from the base class that drive the service.
    procedure DoServiceInitialization; override;
    procedure DoServiceFinalization; override;
    procedure DoServiceItems; override;
    procedure DoServiceLoopException( E: Exception ); override;
    procedure DoWorkerTimeout; override;
    function DoServiceCanSleep( var IsDone,
                                    IsWaiting,
                                    WasTerminated: boolean ): boolean; override;
  public
    procedure EstablishConnections;
    procedure KillConnections;
    procedure ToggleWasConnected;
    { Public declarations }
  end;

var
  svcUCCSync: TsvcUCCSync;

implementation

{$R *.DFM}

procedure TsvcUCCSync.ServiceCreate(Sender: TObject);
begin
{ NOTE!!! }
// This demo isn't intended to run. It is merely an example of an implementation
// of a sub-class of a IBS_Base service application module.
// It using the replication components that are used to synchronize a source
// and a destination.
// For much of what is going on in here, please investigate the sources of IBO.
  inherited;
  try
    LogItem( 'ServiceCreate' );
    se.TimerInterval := 0;
    LogThread := true;
    LogTrans := true;
    LogFiles.LogDir := 'd:\ibsvc\output\';
    LogFiles.LogFmt := '"SVC"yyyymmddhh';
    cnUCCdb.Server := 'localhost';
    cnUCCdb.Path := 'D:\ibdb\Mydb.gdb';
    cnUCCdb.Username := 'SYSDBA';
    cnUCCdb.Password := 'masterkey';
    cnUCCdb_Search.Server := 'localhost';
    cnUCCdb_Search.Path := 'D:\ibdb\Mydb_Search.gdb';
    cnUCCdb_Search.Username := 'SYSDBA';
    cnUCCdb_Search.Password := 'masterkey';
  except
    on E: Exception do
      LogMessage( 'Exception in ServiceCreate: ' + E.Message );
  end;
end;

procedure TsvcUCCSync.DoServiceInitialization;
begin
  try
    LogItem( 'DoServiceInitialization' );
    inherited DoServiceInitialization;
    WasConnected := true;
    WorkerSynchronize( EstablishConnections );
    DoWorkerTimeout;
  except
    on E: Exception do
      LogMessage( 'Exception in ServiceInitialization: ' + E.Message );
  end;
end;

procedure TsvcUCCSync.DoServiceFinalization;
begin
  try
    LogItem( 'DoServiceFinalization' );
    inherited DoServiceFinalization;
    WasConnected := false;
    KillConnections;
  except
    on E: Exception do
      LogMessage( 'Exception in ServiceFinalization: ' + E.Message );
  end;
end;

procedure TsvcUCCSync.DoServiceItems;
begin
// If the connection failed then kill it so that a new connection can be made.
  if KillCon then
  begin
    KillConnections;
    KillCon := false;
  end
  else
// Make sure there is a valid database connection.
  if cnUCCdb.Connected and cnUCCdb_Search.Connected then
  begin
// Calling the Execute method will only process a single item rather than the
// whole queue of records. THis is because all of the sync objects have had
// their Passive property set to true. What this means is that the service
// app loop will go around and around many times working off the items a piece
// at a time. This allows multiple tasks to be worked at in a somewhat parallel
// manner so that one long work task won't take up all the time.
// In the case below, some need to be finished before another is worked on.
// If a table is a master be sure to allow it to synchronize completely before
// the detail tables will replicate. This avoids referential integrity problems.
    if Lien.NeedToExecute then
      Lien.Execute
    else
    if Filing.NeedToExecute then
      Filing.Execute
    else
    begin
      if D_IND.NeedToExecute then D_IND.Execute;
      if D_ORG.NeedToExecute then D_ORG.Execute;
      if S_IND.NeedToExecute then S_IND.Execute;
      if S_ORG.NeedToExecute then S_ORG.Execute;
    end;
  end;
end;

procedure TsvcUCCSync.DoServiceLoopException( E: Exception );
begin
// Check if the problem is actually to do with a broken connection.
// If it is, set a flag so that the connection can be reset.
// It is not wise to do it directly here but in the service loop itself.
  if E is EIB_ISCError then
    with E as EIB_ISCError do
      if ConnectionLostErrcode( ERRCODE ) then
        KillCon := true;
  inherited DoServiceLoopException( E );
end;

procedure TsvcUCCSync.DoWorkerTimeout;
begin
// If the service has a timeout, go ahead and try to proceed with items in
// case there was a lost connection or some other reason there may not have
// been a notification sent.
  LogItem( 'DoWorkerTimeout' );
  if not cnUCCdb.Connected or not cnUCCdb_Search.Connected then
    WorkerSynchronize( EstablishConnections );
// Double check to make sure the queue tables have been processed.
  if cnUCCdb.Connected and cnUCCdb_Search.Connected then
  begin
    Lien.ResyncQueue;
    Filing.ResyncQueue;
    D_IND.ResyncQueue;
    D_ORG.ResyncQueue;
    S_IND.ResyncQueue;
    S_ORG.ResyncQueue;
  end;
end;

function TsvcUCCSync.DoServiceCanSleep( var IsDone,
                                            IsWaiting,
                                            WasTerminated: boolean ): boolean; 
begin
// Check and make sure there isn't any actions that need to be taken so
// the service can go to sleep.
  Result := ( cnUCCdb.StartedTransactionCount = 0 ) and
            ( cnUCCdb_Search.StartedTransactionCount = 0 ) and
            ( not Lien.NeedToExecute ) and
            ( not Filing.NeedToExecute ) and
            ( not D_IND.NeedToExecute ) and
            ( not D_ORG.NeedToExecute ) and
            ( not S_IND.NeedToExecute ) and
            ( not S_ORG.NeedToExecute );
  if not Result then IsDone := false; 
end;

procedure TsvcUCCSync.EstablishConnections;
begin
// Try to get valid database connections.
  if not cnUCCdb.Connected then
    try
      cnUCCdb.Connect;
    except
      on E: Exception do
        if WasConnected then
        begin
          WasConnected := false;
          HandleProblem( cnUCCdb.DatabaseName + ' Database is off-line', E );
        end;
    end;
  if not cnUCCdb_Search.Connected then
    try
      cnUCCdb_Search.Connect;
    except
      on E: Exception do
        if WasConnected then
        begin
          WasConnected := false;
          HandleProblem( cnUCCdb_Search.DatabaseName +
                         ' Database is off-line', E );
        end;
    end;
  if cnUCCdb.Connected and cnUCCdb_Search.Connected then
  begin
    if not WasConnected then
      ToggleWasConnected;
  end
  else
  if not cnUCCdb.Connected and not cnUCCdb_Search.Connected then
  begin
    if WasConnected then
      ToggleWasConnected;
  end;
end;

procedure TsvcUCCSync.KillConnections;
begin
// Get rid of existing failed connections, transactions, etc.
// This allows a clean attempt at a new connection to happen.
  try
    try
      try
        cnUCCdb.Disconnect;
      except
        cnUCCdb.Disconnect;
      end;
    except
      cnUCCdb.Disconnect;
    end;
  except
  // Gobble the exception.
  end;
  try
    try
      try
        cnUCCdb_Search.Disconnect;
      except
        cnUCCdb_Search.Disconnect;
      end;
    except
      cnUCCdb_Search.Disconnect;
    end;
  except
  // Gobble the exception.
  end;
end;

procedure TsvcUCCSync.ToggleWasConnected;
begin
  WasConnected := not WasConnected;
  if not WasConnected then
    LogItem( 'Database is off-line' )
  else
    LogItem( 'Database is on-line' );
end;

procedure TsvcUCCSync.cnAfterConnect(Sender: TIB_Connection);
begin
// With a new connection established, prepare all other resources the
// service app makes use of.
  LogItem( Sender.Name + '.Connected' );
  if cnUCCdb.Connected and cnUCCdb_Search.Connected then
  begin
    Lien.Prepare;
    Filing.Prepare;
    D_IND.Prepare;
    D_ORG.Prepare;
    S_IND.Prepare;
    S_ORG.Prepare;
  end;
end;

procedure TsvcUCCSync.seError(Sender: TObject; const ERRCODE: Integer;
  ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer;
  SQLMessage, SQL: TStringList; var RaiseException: Boolean);
begin
// Log any errors that crop up for review.
  if WasConnected then
    LogItem( 'ERROR!'#13#10#13#10 + ErrorMessage.Text );
end;

procedure TsvcUCCSync.RPLLogItem(Sender: TObject);
begin
// Send items of interest to the log.
  LogItem( (Sender as TIB_RPL_Sync).LogList.Text, 'Index' );
end;

end.

