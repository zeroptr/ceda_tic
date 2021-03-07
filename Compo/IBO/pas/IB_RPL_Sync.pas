
{                                                                              }
{ IB_RPL_Sync                                                                  }
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
  IB_RPL_Sync;

interface

uses
  Windows, Messages, SysUtils, Classes,

  IB_Constants,
  IB_Session,
  IB_Components,
  IB_Events,
  IB_Process,
  IB_DataPump,

  IB_RPL_Base;

type
  TIB_RPL_Sync = class( TIB_RPL_Base )
  private
    evQ: TIB_Events;
    dpQ: TIB_DataPump;
    trQ: TIB_Transaction;
    crQ: TIB_Dataset;
    crQDst: TIB_Dataset;
    dsqlDelQ: TIB_DSQL;
    dsqlUpdQ: TIB_DSQL;
    evFull: TIB_Events;
    dpFull: TIB_DataPump;
    trFull: TIB_Transaction;
    crFull: TIB_Dataset;
    crBlobDst: TIB_Dataset;
    dsqlFull: TIB_DSQL;
    dsqlDrop: TIB_DSQL;
    FullSyncID: extended;
    FLogList: TStrings;
    FLoadWithInserts: boolean;
    FOnLogItem: TNotifyEvent;
    FBeforeResyncIndex: TNotifyEvent;
    FAfterResyncIndex: TNotifyEvent;
    FUseDefaultWakeup: boolean;
    FDPItemAttributes: TIB_StringList;
    FOnGetDPItem: TIB_GetDPItemEvent;
    procedure SetDPItemAttributes( AValue: TIB_StringList );
    function GetWakeup: TNotifyEvent;
    procedure SetWakeup( AValue: TNotifyEvent );
    function GetInterval: cardinal;
    procedure SetInterval( AValue: cardinal );
    procedure SetUseDefaultWakeup( AValue: boolean );
    procedure evEventAlert( Sender: TObject;
                            AEventName: string; AEventCount: Integer );
    procedure dpFullBeforeExecuteItems( Sender: TObject );
    procedure crFullAfterFetchEof( IB_Dataset: TIB_Dataset );
    procedure crQAfterFetchRow( IB_Dataset: TIB_Dataset );
    procedure crQAfterFetchEof( IB_Dataset: TIB_Dataset );
    procedure dpBeforeExecute( Sender: TObject );
    procedure dpAfterExecute( Sender: TObject );
    procedure dpCursorWasReset( IB_Dataset: TIB_Dataset );
    procedure evRegisterChg( Sender: TObject );
    procedure GetBlobHandler(     Sender: TIB_DataPump;
                                  AIndex: integer;
                                  ADstLink: TIB_Column;
                                  AClass: string;
                              var ADPItem: TIB_DPItemBase );
  protected
    NeedToResyncQueue: boolean;
    procedure DoBeforeResyncIndex; virtual;
    procedure DoAfterResyncIndex; virtual;
    procedure DoAfterPrepare; override;
    procedure DoStatusChange; override;
    procedure SysPrepare; override;
    procedure SysUnprepare; override;
    procedure SysFinalize; override;
    procedure SysExecute( var IsDone: boolean ); override;
    function SysNeedToExecute: boolean; override;
    procedure SetReplicatorIndexName( AValue: string ); override;
    procedure SetPassive( AValue: boolean ); override;
    procedure ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                    AEvent: TIB_ConnectionEventType ); override;
    procedure DoLogText( const AText: string );
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure ResyncQueue;
    procedure ResyncIndex;
    property LogList: TStrings read FLogList;
    property LoadWithInserts: boolean read FLoadWithInserts
                                      write FLoadWithInserts
                                      default true;
  published
{: Special flags to create custom data handling like trimming the strings,
etc.
<br><br>
This will be enhanced and expanded in the future as I have need of more
routines. For now this property has not been implemented.}
    property DPItemAttributes: TIB_StringList read FDPItemAttributes
                                              write SetDPItemAttributes;
    property Interval: cardinal read GetInterval write SetInterval default 250;
    property Passive;
    property UseDefaultWakeup: boolean read FUseDefaultWakeup
                                       write SetUseDefaultWakeup
                                       default true;
    property BeforeResyncIndex: TNotifyEvent read FBeforeResyncIndex
                                             write FBeforeResyncIndex;
    property AfterResyncIndex: TNotifyEvent read FAfterResyncIndex
                                            write FAfterResyncIndex;
    property OnGetDPItem: TIB_GetDPItemEvent read FOnGetDPItem
                                             write FOnGetDPItem;
    property OnLogItem: TNotifyEvent read FOnLogItem write FOnLogItem;
    property OnWakeup: TNotifyEvent read GetWakeup write SetWakeup;
  end;

implementation

uses
  IB_Parse, IB_Utils;

constructor TIB_RPL_Sync.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FPreventPassive := false;
  FLoadWithInserts := true;
  FDPItemAttributes := TIB_StringList.Create;
  FLogList := TIB_StringList.Create;
  evQ := TIB_Events.Create( Self );
  evQ.Name := 'evQ';
  evQ.AlertOnRegister := false;
  evQ.OnEventAlert := evEventAlert;
  evQ.AfterRegister := evRegisterChg;
  evQ.AfterUnregister := evRegisterChg;
  evFull := TIB_Events.Create( Self );
  evFull.Name := 'evFull';
  evFull.AlertOnRegister := false;
  evFull.OnEventAlert := evEventAlert;
  evFull.AfterRegister := evRegisterChg;
  evFull.AfterUnregister := evRegisterChg;
  dpQ := TIB_DataPump.Create( Self );
  dpQ.Name := 'dpQ';
  dpQ.BeforeExecute := dpBeforeExecute;
  dpQ.AfterExecute := dpAfterExecute;
  dpQ.OnCursorWasReset := dpCursorWasReset;
  dpQ.OnGetDPItem := GetBlobHandler;
  dpQ.DstIsSingleton := true;
  trQ := TIB_Transaction.Create( Self );
  trQ.Name := 'trQ';
  trQ.Isolation := tiCommitted;
  trQ.AutoCommit := false;
  trQ.ServerAutoCommit := false;
  crQ := TIB_Dataset.Create( Self );
  crQ.IB_Transaction := trQ;
  crQ.AutoFetchFirst := false;
  crQ.CallbackInc := -1;
  crQ.Name := 'crQ';
  crQ.OnMacroSubstitute := SysMacroSubstitute;
  crQ.AfterFetchRow := crQAfterFetchRow;
  crQ.AfterFetchEof := crQAfterFetchEof;
  crQ.SQL.Text :=
    'SELECT *'#13#10 +
    'FROM RPL$<<IND_NME>>$SEND_Q'#13#10 +
    'ORDER BY RPL$Q_KEY';
  crQDst := TIB_Dataset.Create( Self );
  crQDst.IB_Transaction := trQ;
  crQDst.Name := 'crQDst';
  crQDst.OnMacroSubstitute := SysMacroSubstitute;
  crQDst.SQL.Text :=
    'SELECT * FROM RPL$<<IND_NME>>$SYNC_Q ( ?RPL$Q_KEY, ' +
                                           '?RPL$Q_TYP, ' +
                                           '<<DST_OLD_KEY_CLS_INPUT_PRM>>, ' +
                                           '<<DST_CLS_INPUT_PRM>>' +
                                           '<<DST_BLA_INPUT_PRM>> )';
  dpQ.CloneCursor := false;
  dpQ.SrcDataset := crQ;
  dpQ.DstStatement := crQDst;
  dpFull := TIB_DataPump.Create( Self );
  dpFull.Name := 'dpFull';
  dpFull.BeforeExecute := dpBeforeExecute;
  dpFull.AfterExecute := dpAfterExecute;
  dpFull.OnCursorWasReset := dpCursorWasReset;
  dpFull.OnGetDPItem := GetBlobHandler;
  dpFull.BeforeExecuteItems := dpFullBeforeExecuteItems;
  trFull := TIB_Transaction.Create( Self );
  trFull.Name := 'trFull';
  trFull.Isolation := tiCommitted;
  trFull.AutoCommit := false;
  trFull.ServerAutoCommit := false;
  crFull := TIB_Dataset.Create( Self );
  crFull.IB_Transaction := trFull;
  crFull.AutoFetchFirst := false;
  crFull.CallbackInc := -1;
  crFull.Name := 'crFull';
  crFull.OnMacroSubstitute := SysMacroSubstitute;
  crFull.AfterFetchEof := crFullAfterFetchEof;
  crFull.SQL.Text :=
    'SELECT *'#13#10 +
    'FROM RPL$<<IND_NME>>$SEND_FULL';
  crBlobDst := TIB_Dataset.Create( Self );
  crBlobDst.IB_Transaction := trFull;
  crBlobDst.AutoFetchFirst := false;
  crBlobDst.CallbackInc := -1;
  crBlobDst.Name := 'crBlobDst';
  crBlobDst.OnMacroSubstitute := SysMacroSubstitute;
  crBlobDst.SQL.Text :=
    'SELECT <<DST_BLA_CLS>>'#13#10 +
    'FROM <<DST_TBL_NME>> n'#13#10 +
    'WHERE <<DST_KEY_WHERE>>';
  dsqlFull := TIB_DSQL.Create( Self );
  dsqlFull.IB_Transaction := trFull;
  dsqlFull.Name := 'dsqlFull';
  dsqlFull.OnMacroSubstitute := SysMacroSubstitute;
  dsqlDrop := TIB_DSQL.Create( Self );
  dsqlDrop.IB_Transaction := trFull;
  dsqlDrop.Name := 'dsqlDrop';
  dsqlDrop.OnMacroSubstitute := SysMacroSubstitute;
  dsqlDrop.SQL.Text :=
    'EXECUTE PROCEDURE RPL$<<IND_NME>>$SYNC_DROP ?RPL$SYNC_ID';
  dpFull.CloneCursor := false;
  dpFull.SrcDataset := crFull;
  dpFull.DstStatement := dsqlFull;
  dsqlDelQ := TIB_DSQL.Create( Self );
  dsqlDelQ.OnMacroSubstitute := SysMacroSubstitute;
  dsqlDelQ.IB_Transaction := trQ;
  dsqlDelQ.Name := 'dsqlDelQ';
  dsqlDelQ.SQL.Text :=
    'DELETE FROM RPL$<<IND_NME>>$Q'#13#10 +
    'WHERE RPL$Q_KEY = :RPL$Q_KEY';
  dsqlUpdQ := TIB_DSQL.Create( Self );
  dsqlUpdQ.OnMacroSubstitute := SysMacroSubstitute;
  dsqlUpdQ.IB_Transaction := trQ;
  dsqlUpdQ.Name := 'dsqlUpdQ';
  dsqlUpdQ.SQL.Text :=
    'UPDATE RPL$<<IND_NME>>$Q'#13#10 +
    '  SET RPL$Q_TYP = ''I'''#13#10 +
    '  WHERE RPL$Q_KEY = :RPL$Q_KEY';
  FUseDefaultWakeup := true;
  SetInterval( 250 );
end;

destructor TIB_RPL_Sync.Destroy;
begin
  inherited Destroy;
  FLogList.Free;
  FLogList := nil;
  FDPItemAttributes.Free;
  FDPItemAttributes := nil;
end;

procedure TIB_RPL_Sync.SetDPItemAttributes( AValue: TIB_StringList );
begin FDPItemAttributes.Assign( AValue ); end;

procedure TIB_RPL_Sync.DoLogText( const AText: string );
begin
  if Assigned( FOnLogItem ) and ( Trim( AText ) <> '' ) then
  begin
    FLogList.Text := AText;
    FOnLogItem( Self );
    FLogList.Clear;
  end;
end;

procedure TIB_RPL_Sync.DoBeforeResyncIndex;
begin
  if Assigned( FBeforeResyncIndex ) then FBeforeResyncIndex( Self );
end;

procedure TIB_RPL_Sync.DoAfterResyncIndex;
begin
  if Assigned( FAfterResyncIndex ) then FAfterResyncIndex( Self );
end;

procedure TIB_RPL_Sync.evEventAlert( Sender: TObject;
                                     AEventName: string;
                                     AEventCount: Integer );
begin
  if AEventName = 'RPL$' + ReplicatorIndexName + '$Q' then ResyncQueue else
  if AEventName = 'RPL$' + ReplicatorIndexName + '$FULL' then ResyncIndex else
end;

procedure TIB_RPL_Sync.ResyncQueue;
begin
  CheckLoaded;
  BeginBusy( Yield );
  try
    if not Prepared then Prepare;
    if Prepared then
    begin
      NeedToResyncQueue := false;
      if dpQ.Executing then
        dpQ.ResetCursor
      else
      begin
        dpQ.DPItemActions.Clear;
        dpQ.DPItemAttributes.Assign( FDPItemAttributes );
        dpQ.DstLinks.Text := DST_SRC_CLS_MAP;
        dpQ.Execute;
      end;
    end;
  finally
    EndBusy;
  end;
end;

procedure TIB_RPL_Sync.ResyncIndex;
var
  tmpCursor: TIB_Cursor;
begin
  CheckLoaded;
  BeginBusy( Yield );
  try
    if not Prepared then Prepare;
    if Prepared then
    begin
      if dpFull.Executing then
        dpFull.ResetCursor
      else
      begin
        dsqlFull.SQL.Text :=
          'EXECUTE PROCEDURE RPL$<<IND_NME>>$SYNC_FULL ' +
            '<<DST_CLS_INPUT_PRM>><<DST_BLA_INPUT_PRM>>';
        if IsActivated and IsPending and LoadWithInserts then
        begin
          tmpCursor := TIB_Cursor.Create( Self );
          try
            tmpCursor.IB_Connection := Self.IB_Connection;
            tmpCursor.IB_Transaction := TIB_Transaction.Create( tmpCursor );
            tmpCursor.IB_Transaction.IB_Connection := Self.IB_Connection;
            tmpCursor.IB_Transaction.ServerAutoCommit := true;
            tmpCursor.IB_Transaction.Isolation := tiCommitted;
            tmpCursor.OnMacroSubstitute := SysMacroSubstitute;
            tmpCursor.SQL.Text := 'SELECT * FROM <<DST_TBL_NME>> n ' +
                                  '<<SET_EXP_N>>' +
                                  'WHERE ( <<DST_DEL_EXP>> )';
            tmpCursor.First;
            if tmpCursor.Eof then
              dsqlFull.SQL.Text :=
                'INSERT INTO <<DST_TBL_NME>> ( <<DST_CLS>> ) ' +
                'VALUES ( <<DST_CLS_VARS>> )'
          finally
            tmpCursor.Free;
          end;
        end;
        DoBeforeResyncIndex;
        dpFull.DPItemActions.Clear;
        dpFull.DPItemAttributes.Assign( FDPItemAttributes );
        dpFull.DstLinks.Text := DST_SRC_CLS_MAP;
        dpFull.Execute;
      end;
    end;
  finally
    EndBusy;
  end;
end;

procedure TIB_RPL_Sync.evRegisterChg( Sender: TObject );
var
  tmpStr: string;
begin
  if Sender = evQ then tmpStr := 'Queue' else tmpStr := 'Full';
  tmpStr := tmpStr + ' resync events: ' + ReplicatorIndexName;
  with Sender as TIB_Events do
    if Registered then
      DoLogText( 'Waiting for RPL ' + tmpStr )
    else
      DoLogText( 'Not waiting for RPL ' + tmpStr );
end;

type
  TIB_DPItemRPL = class(TIB_DPItemBase)
  private
    FSync: TIB_RPL_Sync;
  protected
    procedure Execute; override;
  public
    property Sync: TIB_RPL_Sync read FSync;
  end;

  TIB_DPItemRPL_BLA_Q = class(TIB_DPItemRPL)
  private
    FChgCol: TIB_Column;
  protected
    procedure Prepare; override;
    procedure Execute; override;
  end;

procedure TIB_DPItemRPL.Execute;
begin
// Do nothing here.
end;

procedure TIB_DPItemRPL_BLA_Q.Prepare;
begin
  inherited Prepare;
  FChgCol := SrcRow.ByName( 'RPL$' + SrcColumn.FieldName );
end;

procedure TIB_DPItemRPL_BLA_Q.Execute;
begin
  if FChgCol.AsString = 'T' then
    inherited Execute
  else
    DstColumn.Clear;
end;

type
  TIB_DPItemRPL_BLA_FULL = class(TIB_DPItemRPL)
  private
    FChgColDst: TIB_Column;
    FDstBLA: TIB_Column;
    function BlobsAreDifferent: boolean;
  protected
    procedure Prepare; override;
    procedure Execute; override;
  end;

procedure TIB_DPItemRPL_BLA_FULL.Prepare;
begin
  inherited Prepare;
  DstRow.GetByName( 'RPL$' + DstColumn.FieldName, FChgColDst );
  FDstBLA := nil;
  if ( Assigned( FChgColDst )) and
     ( DstRow.BlobCount + DstRow.ArrayCount > 0 ) then
    FDstBLA := Sync.crBlobDst.FieldByName( DstColumn.FieldName );
end;

procedure TIB_DPItemRPL_BLA_FULL.Execute;
begin
  if not Assigned( FChgColDst ) or not Assigned( FDstBLA ) then
    DstColumn.Assign( SrcColumn )
  else
  if BlobsAreDifferent then
  begin
    FChgColDst.AsString := 'T';
    DstColumn.Assign( SrcColumn );
  end
  else
  begin
    FChgColDst.AsString := 'F';
    DstColumn.Clear;
  end;
end;

function TIB_DPItemRPL_BLA_FULL.BlobsAreDifferent: boolean;
begin
  if SrcColumn.IsBlob and DstColumn.IsBlob then
    Result := not TIB_ColumnBlob(SrcColumn).IsEqualTo(TIB_ColumnBlob(FDstBLA))
  else
  if SrcColumn.IsArray and DstColumn.IsArray then
    Result := not TIB_ColumnArray(SrcColumn).IsEqualTo(TIB_ColumnArray(FDstBLA))
  else
    Result := true;
end;

procedure TIB_RPL_Sync.GetBlobHandler(     Sender: TIB_DataPump;
                                           AIndex: integer;
                                           ADstLink: TIB_Column;
                                           AClass: string;
                                       var ADPItem: TIB_DPItemBase );
var
  tmpDPItem: TIB_DPItemRPL;
begin
  tmpDPItem := nil;
  if ADstLink.IsBlob or ADstLink.IsArray then
  begin
    if Sender = dpQ then
      tmpDPItem := TIB_DPItemRPL_BLA_Q.Create( Sender )
    else
      tmpDPItem := TIB_DPItemRPL_BLA_FULL.Create( Sender );
  end
  else
  if ( Copy( stLitCriteria( ADstLink.FieldName ), 1, 4 ) = 'RPL$' ) and
     ( ADstLink.IsText ) and
     ( ADstLink.SQLLen = 1 ) then
    tmpDPItem := TIB_DPItemRPL.Create( Sender );
  if Assigned( tmpDPItem ) then
    tmpDPItem.FSync := Self;
  ADPItem := tmpDPItem;
  if not Assigned( ADPItem ) and Assigned( FOnGetDPItem ) then
    FOnGetDPItem( Sender, AIndex, ADstLink, AClass, ADPItem );
end;

procedure TIB_RPL_Sync.dpFullBeforeExecuteItems( Sender: TObject );
var
  ii: integer;
begin
  if ( dsqlFull.StatementType = stExecProcedure ) and
     ( dpFull.DstRow.BlobCount + dpFull.DstRow.ArrayCount > 0 ) then
  begin
    for ii := 0 to crBlobDst.Params.ColumnCount - 1 do
      with crBlobDst.Params[ ii ] do
        Assign( crFull.FieldByName( FieldName ));
    crBlobDst.First;
  end;
end;

procedure TIB_RPL_Sync.crFullAfterFetchEof( IB_Dataset: TIB_Dataset );
begin
  trFull.CommitRetaining;
end;

procedure TIB_RPL_Sync.crQAfterFetchRow( IB_Dataset: TIB_Dataset );
var
  tmpStr: string;
begin
  tmpStr := crQDst.Fields[1].AsString;
  if tmpStr = 'D' then
  begin
    if not dsqlDelQ.Prepared then
      dsqlDelQ.Prepare;
    dsqlDelQ.Params[0].Assign( crQDst.Fields[0] );
    dsqlDelQ.ExecSQL;
    trQ.CommitRetaining;
  end
  else
  if tmpStr = 'U' then
  begin
    if not dsqlUpdQ.Prepared then
      dsqlUpdQ.Prepare;
    dsqlUpdQ.Params[0].Assign( crQDst.Fields[0] );
    dsqlUpdQ.ExecSQL;
    trQ.CommitRetaining;
    dpQ.ResetCursor;
  end
  else
    raise Exception.Create( 'Invalid return code: ' + tmpStr );
end;

procedure TIB_RPL_Sync.crQAfterFetchEof( IB_Dataset: TIB_Dataset );
begin
  trQ.CommitRetaining;
end;

procedure TIB_RPL_Sync.dpAfterExecute( Sender: TObject );
var
  tmpStr: string;
begin
  with Sender as TIB_DataPump do
  begin
    case ProcessResult of
      prIncomplete: tmpStr := 'incomplete';
      prAborted: tmpStr := 'aborted';
      prFailed: tmpStr := 'failed';
      prAbandoned: tmpStr := 'abandoned';
      prCompleted: tmpStr := 'completed';
    end;
    tmpStr := Name + ' Cursor ' + tmpStr;
    if Sender = dpFull then
      if dpFull.ProcessResult = prCompleted then
      begin
        dsqlDrop.ParamByName( 'RPL$SYNC_ID' ).AsExtended := FullSyncID;
        dsqlDrop.ExecSQL;
        trFull.CommitRetaining;
      end;
    DoLogText( 'Check of the ' + ReplicatorIndexName + ' RPL index ' + tmpStr );
  end;
  if Sender = dpFull then
  begin
    DoAfterResyncIndex;
    if trFull.Started then
      trFull.Commit;
  end
  else
    if trQ.Started then
      trQ.Commit;
end;

procedure TIB_RPL_Sync.dpBeforeExecute( Sender: TObject );
begin
  with Sender as TIB_DataPump do
    DoLogText( 'Initiating RPL ' + SrcDataset.Name + ' Resync for: ' +
               ReplicatorIndexName );
  if Sender = dpFull then
    FullSyncID := dsqlFull.GEN_ID( 'RPL$' + ReplicatorIndexName +
                                   '$SYNC_ID_GEN', 1 );
end;

procedure TIB_RPL_Sync.dpCursorWasReset( IB_Dataset: TIB_Dataset );
begin
  DoLogText( 'Reseting RPL ' + IB_Dataset.Name + ' Resync for: ' +
             ReplicatorIndexName );
  if IB_Dataset = crFull then
    FullSyncID := dsqlFull.GEN_ID( 'RPL$' + ReplicatorIndexName +
                                   '$SYNC_ID_GEN', 1 );
end;

procedure TIB_RPL_Sync.SysPrepare;
begin
  inherited SysPrepare;
  evQ.Events.Text := 'RPL$' + ReplicatorIndexName + '$Q';
  evFull.Events.Text := 'RPL$' + ReplicatorIndexName + '$FULL'#13#10;
  if ReplicatorIndexName <> '' then
    DoLogText( 'RPL Index ' + ReplicatorIndexName + ' has been prepared' );
end;

procedure TIB_RPL_Sync.DoStatusChange;
begin
  inherited DoStatusChange;
  if IsCorrupted or IsPending or not IsMetaLoaded or not Prepared then
  begin
    dpQ.Unprepare;
    crQ.Unprepare;
    crQDst.Unprepare;
    dsqlDelQ.Unprepare;
    dsqlUpdQ.Unprepare;
    if not IsActivated or not Prepared then
    begin
      dpFull.Unprepare;
      crFull.Unprepare;
      crBlobDst.Unprepare;
      dsqlFull.Unprepare;
      dsqlDrop.Unprepare;
    end;
    evQ.UnregisterEvents;
    evFull.UnregisterEvents;
    if Assigned( IB_Connection ) then
      IB_Connection.FreeStmtHandleCache( 0 );
    if Assigned( IB_ConnectionSrc ) then
      IB_ConnectionSrc.FreeStmtHandleCache( 0 );
    NeedToResyncQueue := false;
  end
  else
  if IsActivated and
     (( Interval > 0 ) or Assigned( OnWakeup ) or UseDefaultWakeup ) then
  begin
    if not evQ.Registered then evQ.RegisterEvents;
    if not evFull.Registered then evFull.RegisterEvents;
  end
  else
  begin
    evQ.UnregisterEvents;
    evFull.UnregisterEvents;
  end;
end;

procedure TIB_RPL_Sync.DoAfterPrepare;
begin
  inherited DoAfterPrepare;
  if IsActivated and not IsCorrupted and not IsPending then
  begin
    NeedToResyncQueue := true;
    if not Passive then ResyncQueue;
  end;
end;

procedure TIB_RPL_Sync.SysUnprepare;
begin
  inherited SysUnprepare;
  evQ.UnregisterEvents;
  evFull.UnregisterEvents;
  dpQ.Unprepare;
  dpFull.Unprepare;
  crQDst.Unprepare;
  dsqlFull.Unprepare;
  crFull.Unprepare;
  crBlobDst.Unprepare;
  crQ.Unprepare;
  trQ.Close;
  trFull.Close;
  dsqlDelQ.Unprepare;
  dsqlUpdQ.Unprepare;
  dsqlDrop.Unprepare;
  if ReplicatorIndexName <> '' then
    if not ( csDestroying in ComponentState ) then
      DoLogText( 'RPL Index ' + ReplicatorIndexName + ' has been unprepared' );
end;

procedure TIB_RPL_Sync.SysFinalize;
begin
  crBlobDst.Close;
  NeedToResyncQueue := false;
  inherited SysFinalize;
end;

procedure TIB_RPL_Sync.SysExecute( var IsDone: boolean );
begin
  if dpQ.NeedToExecute then dpQ.Execute;
  if dpFull.NeedToExecute then dpFull.Execute;
  IsDone := not dpFull.Executing and
            not dpQ.Executing and
            not NeedToResyncQueue;
  if IsDone and trQ.Started then trQ.Commit;
  if IsDone and trFull.Started then trFull.Commit;
  if NeedToResyncQueue then ResyncQueue;
  evQ.CheckEvents;
  evFull.CheckEvents;
  if IsDone then inherited SysExecute( IsDone );
end;

function TIB_RPL_Sync.SysNeedToExecute: boolean;
begin
  Result := inherited SysNeedToExecute;
  if Prepared and not Result then
    Result := evQ.EventsPending or
              evFull.EventsPending or
              dpQ.NeedToExecute or
              dpFull.NeedToExecute or
              trQ.Started or
              trFull.Started or
              NeedToResyncQueue;
end;

procedure TIB_RPL_Sync.SetReplicatorIndexName( AValue: string );
begin
  if ReplicatorIndexName <> Trim( AValue ) then Unprepare;
  inherited SetReplicatorIndexName( AValue );
end;

procedure TIB_RPL_Sync.SetPassive( AValue: boolean );
begin
  inherited SetPassive( AValue );
  evQ.Passive := Passive;
  evFull.Passive := Passive;
  dpQ.Passive := Passive;
  dpFull.Passive := Passive;
end;

function TIB_RPL_Sync.GetWakeup: TNotifyEvent;
begin
  Result := evQ.OnWakeup;
end;

procedure TIB_RPL_Sync.SetWakeup( AValue: TNotifyEvent );
begin
  evQ.OnWakeup := AValue;
  evFull.OnWakeup := AValue;
end;

function TIB_RPL_Sync.GetInterval: cardinal;
begin
  Result := evQ.Interval;
end;

procedure TIB_RPL_Sync.SetInterval( AValue: cardinal );
begin
  evQ.Interval := AValue;
  evFull.Interval := AValue;
end;

procedure TIB_RPL_Sync.SetUseDefaultWakeup( AValue: boolean );
begin
  if FUseDefaultWakeup <> AValue then
  begin
    FUseDefaultWakeup := AValue;
    DoStatusChange;
  end;
end;

procedure TIB_RPL_Sync.ProcessConnectionEvent(
  AConnectionLink: TIB_ConnectionLink;
  AEvent: TIB_ConnectionEventType ); 
begin
  inherited ProcessConnectionEvent( AConnectionLink, AEvent );
  if AEvent = cetAfterAssignment then
  begin
    evQ.IB_Connection := IB_ConnectionSrc;
    evFull.IB_Connection := IB_Connection;
    crQ.IB_Connection := IB_ConnectionSrc;
    crQDst.IB_Connection := IB_Connection;
    trQ.IB_Connection := IB_ConnectionSrc;
    trQ.IB_Connection1 := IB_Connection;
    crFull.IB_Connection := IB_ConnectionSrc;
    crBlobDst.IB_Connection := IB_Connection;
    dsqlFull.IB_Connection := IB_Connection;
    trFull.IB_Connection := IB_ConnectionSrc;
    trFull.IB_Connection1 := IB_Connection;
    dsqlDelQ.IB_Connection := IB_ConnectionSrc;
    dsqlUpdQ.IB_Connection := IB_ConnectionSrc;
    dsqlDrop.IB_Connection := IB_Connection;
  end;
end;

end.

