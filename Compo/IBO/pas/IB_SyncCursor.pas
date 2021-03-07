
{                                                                              }
{ IB_SyncCursor                                                                }
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

{: This unit contains the component that is used to bring change notifications
from the server to the client so that client datasets can be kept updated
according to changes being made by other users real-time.
<br><br>
For the time being this is going to contain a lot of hard coded settings. I
consider this unit in pre-BETA status.}
unit
  IB_SyncCursor;

interface

uses
  Windows, SysUtils, Classes, 

{$ifdef IBO_VCL60_OR_GREATER}
  Variants,
{$endif}

  IB_Header,
  IB_Session,
  IB_Components,
  IB_Events;

type
{: This component is still pre-BETA status. All aspects including the name
itself are subject to change.
<br><br>
To see an application where this is made use of see the D4Apps\Survey
application.}
TIB_SyncCursor = class(TIB_Dataset)
private
  FActionEditVal: string;
  FActionInsertVal: string;
  FActionDeleteVal: string;
  FLastID: longint;
  FIB_Events: TIB_Events;
  FEventName: string;
  FTableName: string;
  FColIDName: string;
  FColActionName: string;
  FColKeyFieldsName: string;
  FColKeyValuesNames: string;
  FColUserName: string;
  FKeyValues: variant;
  procedure SetEventName( AValue: string );
  procedure SetTableName( AValue: string );
  procedure SetColIDName( AValue: string );
  procedure SetColActionName( AValue: string );
  procedure SetColKeyFieldsName( AValue: string );
  procedure SetColKeyValuesNames( AValue: string );
  procedure SetColUserName( AValue: string );
protected
  procedure SysAfterPrepare; override;
  procedure SysBeforePrepare; override;
  procedure SysBeforeUnprepare; override;
  procedure SysPrepareSQL; override;
  function SysAfterFetchCursorRow: boolean; override;
  procedure EventAlert( Sender: TObject;
                        AEventName: string;
                        AEventCount: longint ); virtual;
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
  function CheckTransaction( RequestStart: boolean ): boolean; override;
{: This is the value of the last ID processed from the sync table.}
  property LastID: longint read FLastID;
published
{: The connection for which this will receive event notifications and keep in
sync with.}
  property IB_Connection;
{: This is the value in the synch table that means the action for that entry
was an update.}
  property ActionEditVal: string read FActionEditVal write FActionEditVal;
{: This is the value in the synch table that means the action for that entry
was an insert.}
  property ActionInsertVal: string read FActionInsertVal write FActionInsertVal;
{: This is the value in the synch table that means the action for that entry
was a delete.}
  property ActionDeleteVal: string read FActionDeleteVal write FActionDeleteVal;
{: This is the name of the event that is used in the After Insert trigger of
the sync table to indicate that an item needs to be processed. This trigger
should have POST_EVENT "IBO$DMLCACHE" call or similar.
<br><br>
It may be different if you have two sync tables each accomodating a different
structure. For example, you may have one specially for single column integer
based keys and then another one for a more complex multi-column key. Each
of these different systems should use their own event so that their activity
can be isolated from each other.}
  property EventName: string read FEventName write SetEventName;
{: This is the name of the table that is used to store the synchronization
information.}
  property TableName: string read FTableName write SetTableName;
{: This is the column name of the unique ID for tracking of the log entries.}
  property ColIDName: string read FColIDName write SetColIDName;
{: This is the column name of the action that produced the entry.}
  property ColActionName: string read FColActionName write SetColActionName;
{: This is the column that holds what the names of the key columns are in the
key values columns.}  
  property ColKeyFieldsName: string read FColKeyFieldsName
                                    write SetColKeyFieldsName;
{: This is the name of the columns that store the values of the key columns.
Since there can be more than one please separate them by commas and be sure that
they are in the same order as they are in the KeyFieldNames column.}
  property ColKeyValuesNames: string read FColKeyValuesNames
                                     write SetColKeyValuesNames;
{: This is the name of the column that stored what the user was that initiated
the entry.}
  property ColUserName: string read FColUserName write SetColUserName;
end;

implementation

constructor TIB_SyncCursor.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FActionEditVal := 'U';
  FActionInsertVal := 'I';
  FActionDeleteVal := 'D';
  FEventName := 'IBO$DMLCACHE';
  FTableName := 'IBO$DMLCACHE';
  FColIDName := 'DMLID';
  FColUserName := 'DMLUSER';
  FColActionName := 'DMLACTION';
  FColKeyFieldsName := 'KEYFIELDS';
  FColKeyValuesNames := 'KEYVALUE1,KEYVALUE2,KEYVALUE3';
  FIB_Events := TIB_Events.Create( Self );
  FIB_Events.OnEventAlert := EventAlert;
  FIB_Events.Events.Add( FEventName );
end;

destructor TIB_SyncCursor.Destroy;
begin
  Unprepare;
  FIB_Events.Free;
  FIB_Events := nil;
  inherited Destroy;
end;

procedure TIB_SyncCursor.SetEventName( AValue: string );
begin
  if EventName <> AValue then
  begin
    FEventName := AValue;
    with FIB_Events.Events do
      try
        BeginUpdate;
        Clear;
        Add( FEventName );
      finally
        EndUpdate;
      end;
  end;
end;

procedure TIB_SyncCursor.SetTableName( AValue: string );
begin
  if TableName <> AValue then
  begin
    FTableName := AValue;
    Unprepare;
  end;
end;

procedure TIB_SyncCursor.SetColIDName( AValue: string );
begin
  if ColIDName <> AValue then
  begin
    FColIDName := AValue;
    Unprepare;
  end;
end;

procedure TIB_SyncCursor.SetColActionName( AValue: string );
begin
  if ColActionName <> AValue then
  begin
    FColActionName := AValue;
    Unprepare;
  end;
end;

procedure TIB_SyncCursor.SetColKeyFieldsName( AValue: string );
begin
  if ColKeyFieldsName <> AValue then
  begin
    FColKeyFieldsName := AValue;
    Unprepare;
  end;
end;

procedure TIB_SyncCursor.SetColKeyValuesNames( AValue: string );
begin
  if ColKeyValuesNames <> AValue then
  begin
    FColKeyValuesNames := AValue;
    Unprepare;
  end;
end;

procedure TIB_SyncCursor.SetColUserName( AValue: string );
begin
  if ColUserName <> AValue then
  begin
    FColUserName := AValue;
    Unprepare;
  end;
end;

procedure TIB_SyncCursor.SysBeforePrepare;
begin
  CheckConnection( false );
  CheckTransaction( false );
  with TIB_Dataset.Create( Self ) do
    try
      IB_Connection := Self.IB_Connection;
      IB_Transaction := Self.IB_Transaction;
      SQL.Text := 'SELECT MAX(' + FColIDName + ') FROM ' + FTableName;
      First;
      FLastID := Fields[0].AsInteger;
    finally
      Free;
    end;
  inherited SysBeforePRepare;
end;

procedure TIB_SyncCursor.SysPrepareSQL;
begin
  inherited SysPrepareSQL;
  SQL.Clear;
  SQL.Add( 'SELECT ' + FColIDName +
                ', ' + FColActionName +
                ', ' + FColKeyFieldsName +
                ', ' + FColKeyValuesNames );
  SQL.Add( 'FROM ' + FTableName );
  SQL.Add( 'ORDER BY ' + FColIDName + ' ASCENDING' );
  SQLWhereItems.Add( FColIDName + ' > ?LastID' );
  SQLWhereItems.Add( FColUserName + ' <> USER' );
end;

procedure TIB_SyncCursor.SysAfterPrepare;
begin
  FKeyValues := VarArrayCreate( [ 0, FieldCount - 4 ], varVariant );
  inherited SysAfterPrepare;
  FIB_Events.IB_Connection := IB_Connection;
  FIB_Events.RegisterEvents;
end;

procedure TIB_SyncCursor.SysBeforeUnprepare;
begin
  FIB_Events.UnregisterEvents;
  VarClear( FKeyValues );
  inherited SysBeforeUnprepare;
end;

procedure TIB_SyncCursor.EventAlert( Sender: TObject;
                                     AEventName: string;
                                     AEventCount: longint );
begin
  Params[0].AsInteger := LastID;
  try
    FetchAll;
  finally
    Close;
  end;
end;

function TIB_SyncCursor.SysAfterFetchCursorRow: boolean;
var
  ii: integer;
  tmpStr: string;
  tmpType: TIB_DMLCacheItemType;
begin
  Result := inherited SysAfterFetchCursorRow;
  if Result then
  begin
    FLastID := Fields[0].AsInteger;
    for ii := 0 to FieldCount - 4 do
      FKeyValues[ ii ] := Fields[ ii + 3 ].Value;
    tmpStr := Fields[1].AsString;
    if tmpStr = ActionEditVal then
      tmpType := ditEdit
    else
    if tmpStr = ActionInsertVal then
      tmpType := ditInsert
    else
    if tmpStr = ActionDeleteVal then
      tmpType := ditDelete
    else
      raise Exception.Create( 'Invalid DMLAction code: ' + tmpStr );
    tmpStr := Fields[2].AsString;
    IB_Connection.ProcessDMLCacheItem( tmpStr, FKeyValues, tmpType );
  end;
end;

function TIB_SyncCursor.CheckTransaction( RequestStart: boolean ): boolean;
begin
// Avoid the problem of not allowing the default transaction here.
// We want to force this into its own transaction.
  if ( IB_Transaction = nil ) then
    CheckConnection( false );
  if ( IB_Transaction = nil ) then
  begin
    if FIB_Transaction = nil then
    begin
      FIB_Transaction := TIB_TransactionDefault.Create( Self );
      FIB_Transaction.Name := 'tr' + Self.Name;
      FIB_Transaction.AutoCommit := true;
      FIB_Transaction.Isolation := tiCommitted;
    end
    else
    with FIB_Transaction do
      if AutoCommit and Started then
        Commit;
    IB_Transaction := FIB_Transaction;
  end;
  Result := inherited CheckTransaction( RequestStart );
end;

end.
 
