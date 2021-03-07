
{                                                                              }
{ FRM_Events                                                                   }
{                                                                              }

unit
  FRM_Events;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls,
  StdCtrls,

  DBTables, Db, BDE, 

  IB_Components,
  IB_Events,
  IB_StoredProc,
  IB_Process,
  IB_Script;

type
  TfrmEvents = class(TForm)
    StoredProc: TIB_StoredProc;
    meEvents: TMemo;
    IB_Events: TIB_Events;
    dbEvents: TDatabase;
    ibEvents: TIB_Database;
    pnExecProc: TPanel;
    btExecProc: TButton;
    btExit: TButton;
    scEvents: TIB_Script;
    procedure FormCreate(Sender: TObject);
    procedure btExecProcClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IB_EventsEventAlert(Sender: TObject; EventName: string;
      EventCount: Longint);
    procedure btExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEvents: TfrmEvents;

implementation

{$R *.DFM}

function GetNativeHandle(Database: TDatabase): Pointer;
var
  length: word;
begin
// This is how you get a native IB handle out of a TDatabase.
  Result := nil;
  if Assigned( Database ) and
     Database.Connected and
     ( Database.DriverName = 'INTRBASE' ) then
    Check( DBIGetProp( HDBIOBJ( Database.Handle ), dbNATIVEHNDL,
                                                   @Result,
                                                   SizeOf( Pointer ),
                                                   length ));
end;

procedure TfrmEvents.FormCreate(Sender: TObject);
begin
// Dynamically create the sample GDB if it does not exist.
  if not FileExists( 'Test.GDB' ) then
  begin
    scEvents.Execute;
    ibEvents.Disconnect;
  end;
// An IB_Connection can take a raw handle from a TDatabase
  dbEvents.Connected := True;
  ibEvents.dbHandleShared := GetNativeHandle(dbEvents);
// Register the events to receive notification.
  IB_Events.RegisterEvents;
end;

procedure TfrmEvents.FormDestroy(Sender: TObject);
begin
// Before the TDatabase closes be sure to clear the dbHandle out of the
// IB_Connection. Otherwise, it may attempt an operation after the handle has
// become invalid.
  ibEvents.dbHandleShared := nil;
  dbEvents.Connected := False;
end;

procedure TfrmEvents.btExecProcClick(Sender: TObject);
begin
// IB events are kept within transaction control.
// Posted events are not notified until they commit.
// If they are rolledback then no event notification will be given.
  StoredProc.ExecProc;
  ibEvents.CommitRetaining;
end;

procedure TfrmEvents.IB_EventsEventAlert(Sender: TObject; EventName: string;
  EventCount: Longint);
begin
// Do not need to protect for multi-threaded issues since Asynchronous is false.
// This line of code is executed by the main thread on an idle CPU cycle.
  meEvents.Lines.Add( EventName + ': ' + IntToStr( EventCount ));
end;

procedure TfrmEvents.btExitClick(Sender: TObject);
begin
  Close;
end;

end.
