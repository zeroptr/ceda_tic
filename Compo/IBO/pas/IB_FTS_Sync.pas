
{                                                                              }
{ IB_FTS_Sync                                                                  }
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
  IB_FTS_Sync;

interface

uses
  Windows, Messages, SysUtils, Classes,

  IB_Constants,
  IB_Session,
  IB_Components,
  IB_Events,
  IB_Process,

  IB_FTS_Base;

type
  TIB_PassiveQueryRef = record
    Cursor: TIB_Dataset;
    Trans: TIB_Transaction;
    KEY_COL: string;
    Cycle: boolean;
    CommitCount: integer;
    AbortGen: integer;
    WordList,
    LogList: TIB_StringList;
  end;

  TIB_FTS_Sync = class( TIB_FTS_Base )
  private
    evQ: TIB_Events;
    qrQ: TIB_PassiveQueryRef;
    qrFull: TIB_PassiveQueryRef;
    crMin: TIB_Cursor;
    crUpd: TIB_Cursor;
    dNmD: TIB_DSQL;
    dDel: TIB_DSQL;
    dIns: TIB_DSQL;
    dUpd: TIB_DSQL;
    prmFull_KEY_COL: TIB_Column;
    fldFull_KEY_COL: TIB_Column;
    fldFull_WRD: TIB_Column;
    fldFull_AUX_COL: TIB_Column;
    fldFull_SCH_COL: TIB_Column;
    fldQ_KEY_COL: TIB_Column;
    fldQ_AUX_COL: TIB_Column;
    fldQ_SCH_COL: TIB_Column;
    fldQ_Q_TYP: TIB_Column;
    fldQ_Q_KEY : TIB_Column;
    prmcrUPD_FTKEY: TIB_Column;
    fldcrUPD_FTWRD: TIB_Column;
    prmdNMD_FTQ_KEY: TIB_Column;
    prmdDEL_FTKEY: TIB_Column;
    prmFTKEY: TIB_Column;
    prmFTWRD: TIB_Column;
    prmFTMTP: TIB_Column;
    prmFTSDX: TIB_Column;
    prmFTSMX: TIB_Column;
    prmdUPD_FTKEY: TIB_Column;
    prmdUPD_FTWRD: TIB_Column;
    FLogList: TStrings;
    FOnLogItem: TNotifyEvent;
    NeedToResyncQueue: boolean;
    NeedToCleanWRD: boolean;
    NeedToCleanMTP: boolean;
    NeedToCleanSDX: boolean;
    NeedToCleanSMX: boolean;
    FUseDefaultWakeup: boolean;
    function GetWakeup: TNotifyEvent;
    procedure SetWakeup( AValue: TNotifyEvent );
    function GetInterval: cardinal;
    procedure SetInterval( AValue: cardinal );
    procedure evQEventAlert( Sender: TObject;
                             AEventName: string; AEventCount: Integer );
    procedure crFullAfterFetchRow( IB_Dataset: TIB_Dataset );
    procedure crFullAfterFetchEof( IB_Dataset: TIB_Dataset );
    procedure crQAfterFetchRow( IB_Dataset: TIB_Dataset );
    procedure SetUseDefaultWakeup( AValue: boolean );
  protected
    procedure CheckNameWord( const AWord: string;
                             const APQR: TIB_PassiveQueryRef );
    procedure InsertNameWords( const APQR: TIB_PassiveQueryRef );
    procedure DoAfterPrepare; override;
    procedure DoStatusChange; override;
    procedure SysPrepare; override;
    procedure SysUnprepare; override;
    procedure SysFinalize; override;
    procedure SysExecute( var IsDone: boolean ); override;
    function SysNeedToExecute: boolean; override;
    procedure SetSearchIndexName( AValue: string ); override;
    procedure SetPassive( AValue: boolean ); override;
    procedure ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                    AEvent: TIB_ConnectionEventType ); override;
    procedure DoLogText( const AText: string );
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure ResyncQueue;
    procedure ResyncIndex;
    procedure CleanIndex;
    property LogList: TStrings read FLogList;
  published
    property Interval: cardinal read GetInterval write SetInterval default 250;
    property Passive;
    property UseDefaultWakeup: boolean read FUseDefaultWakeup
                                       write SetUseDefaultWakeup
                                       default true;
    property BeforePrepare;
    property AfterPrepare;
    property AfterUnprepare;
    property BeforeExecute;
    property AfterExecute;
    property OnStatusChange;
    property OnModifySearchWords;
    property OnLogItem: TNotifyEvent read FOnLogItem write FOnLogItem;
    property OnWakeup: TNotifyEvent read GetWakeup write SetWakeup;
  end;

implementation

uses
  IB_Parse, IB_Utils;

constructor TIB_FTS_Sync.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FUseDefaultWakeup := true;
  FPreventPassive := false;
  FLogList := TIB_StringList.Create;
  qrQ.LogList := TIB_StringList.Create;
  qrQ.WordList := TIB_StringList.Create;
  qrQ.WordList.Sorted := true;
  qrQ.WordList.Duplicates := dupIgnore;
  qrFull.LogList := TIB_StringList.Create;
  qrFull.WordList := TIB_StringList.Create;
  qrFull.WordList.Sorted := true;
  qrFull.WordList.Duplicates := dupIgnore;
  evQ := TIB_Events.Create( Self );
  evQ.Name := 'evQ';
  evQ.AlertOnRegister := false;
  evQ.OnEventAlert := evQEventAlert;
  qrQ.Trans := TIB_Transaction.Create( Self );
  qrQ.Trans.Name := 'tQ';
  qrQ.Trans.Isolation := tiCommitted;
  qrQ.Trans.AutoCommit := false;
  qrQ.Trans.ServerAutoCommit := false;
  qrQ.Cursor := TIB_Cursor.Create( Self );
  qrQ.Cursor.Name := 'crQ';
  qrQ.Cursor.IB_Transaction := qrQ.Trans;
  qrQ.Cursor.AutoFetchFirst := false;
  qrQ.Cursor.CallbackInc := -1;
  crUpd := TIB_Cursor.Create( Self );
  crUpd.Name := 'crUpd';
  crUpd.IB_Transaction := qrQ.Trans;
  crUpd.PreparedEdits := True;
  crUpd.RequestLive := True;
  crUpd.CallbackInc := -1;
  dDel := TIB_DSQL.Create( Self );
  dDel.Name := 'dDel';
  dDel.IB_Transaction := qrQ.Trans;
  qrFull.Trans := TIB_Transaction.Create( Self );
  qrFull.Trans.Name := 'tFull';
  qrFull.Trans.Isolation := tiCommitted;
  qrFull.Trans.AutoCommit := false;
  qrFull.Trans.ServerAutoCommit := false;
  qrFull.Cursor := TIB_Cursor.Create( Self );
  qrFull.Cursor.Name := 'crFull';
  qrFull.Cursor.IB_Transaction := qrFull.Trans;
  qrFull.Cursor.AutoFetchFirst := false;
  qrFull.Cursor.CallbackInc := 1;
  qrFull.Cursor.AfterFetchRow := crFullAfterFetchRow;
  qrFull.Cursor.AfterFetchEof := crFullAfterFetchEof;
  crMin := TIB_Cursor.Create( Self );
  crMin.Name := 'crMin';
  crMin.IB_Transaction := qrFull.Trans;
  crMin.CallbackInc := -1;
  dNmD := TIB_DSQL.Create( Self );
  dNmD.Name := 'dNmD';
  dNmD.IB_Transaction := qrQ.Trans;
  dIns := TIB_DSQL.Create( Self );
  dIns.Name := 'dIns';
  dIns.IB_Transaction := qrFull.Trans;
  dUpd := TIB_DSQL.Create( Self );
  dUpd.Name := 'dUpd';
  dUpd.IB_Transaction := qrFull.Trans;
  qrQ.Cursor.AfterFetchRow := crQAfterFetchRow;
  qrFull.Cursor.OnMacroSubstitute := SysMacroSubstitute;
  crMin.OnMacroSubstitute := SysMacroSubstitute;
  qrQ.Cursor.OnMacroSubstitute := SysMacroSubstitute;
  crUpd.OnMacroSubstitute := SysMacroSubstitute;
  dNmd.OnMacroSubstitute := SysMacroSubstitute;
  dDel.OnMacroSubstitute := SysMacroSubstitute;
  dIns.OnMacroSubstitute := SysMacroSubstitute;
  dUpd.OnMacroSubstitute := SysMacroSubstitute;
  qrFull.Cursor.SQL.Text :=
  'SELECT w.FTS$<<KEY_COL>> AS FTS$KEY_COL'                           + #13#10 +
  '     , w.FTS$WRD'                                                  + #13#10 +
  '     , ( SELECT <<AUX_COL>>'                                       + #13#10 +
  '         FROM <<TBL_NME>> n'                                       + #13#10 +
  '         WHERE n.<<KEY_COL>> = w.FTS$<<KEY_COL>> ) as FTS$AUX_COL' + #13#10 +
  '     , ( SELECT n.<<SCH_COL>>'                                     + #13#10 +
  '         FROM <<TBL_NME>> n'                                       + #13#10 +
  '         WHERE n.<<KEY_COL>> = w.FTS$<<KEY_COL>> ) as FTS$SCH_COL' + #13#10 +
  'FROM FTS$<<IND_NME>>$WRD w'                                        + #13#10 +
  'WHERE w.FTS$<<KEY_COL>> >= :FTS$KEY_COL'                           + #13#10 +
  'ORDER BY w.FTS$<<KEY_COL>>';
  crMin.SQL.Text :=
  'SELECT MIN( w.FTS$<<KEY_COL>> )'                                   + #13#10 +
  'FROM FTS$<<IND_NME>>$WRD w';
  qrQ.Cursor.SQL.Text :=
  'SELECT q.FTS$q_key'                                                + #13#10 +
  '     , q.FTS$q_typ'                                                + #13#10 +
  '     , q.FTS$<<KEY_COL>> AS FTS$KEY_COL'                           + #13#10 +
  '     , ( SELECT t.<<AUX_COL>>'                                     + #13#10 +
  '         FROM <<TBL_NME>> t '                                      + #13#10 +
  '         WHERE t.<<KEY_COL>> = q.FTS$<<KEY_COL>> ) AS FTS$AUX_COL' + #13#10 +
  '     , ( SELECT t.<<SCH_COL>>'                                     + #13#10 +
  '         FROM <<TBL_NME>> t '                                      + #13#10 +
  '         WHERE t.<<KEY_COL>> = q.FTS$<<KEY_COL>> ) AS FTS$SCH_COL' + #13#10 +
  'FROM FTS$<<IND_NME>>$Q q'                                          + #13#10 +
  'ORDER BY q.FTS$q_key';
  crUpd.SQL.Text :=
  'SELECT FTS$WRD'                                                    + #13#10 +
  'FROM FTS$<<IND_NME>>$WRD'                                          + #13#10 +
  'WHERE FTS$<<KEY_COL>> = :FTS$KEY'                                  + #13#10 +
  'ORDER BY FTS$WRD';
  dNmD.SQL.Text :=
  'DELETE FROM FTS$<<IND_NME>>$Q'                                     + #13#10 +
  'WHERE FTS$Q_KEY = :FTS$Q_KEY';
  dDel.SQL.Text :=
  'DELETE FROM FTS$<<IND_NME>>$WRD'                                   + #13#10 +
  'WHERE FTS$<<KEY_COL>> = :FTS$KEY';
  dIns.SQL.Text :=
  'EXECUTE PROCEDURE FTS$<<IND_NME>>$ADD_WRD'                         + #13#10 +
  '  :FTS$KEY,'                                                       + #13#10 +
  '  :FTS$WRD,'                                                       + #13#10 +
  '  :FTS$MTP,'                                                       + #13#10 +
  '  :FTS$SDX,'                                                       + #13#10 +
  '  :FTS$SMX ';
  dUpd.SQL.Text :=
  'DELETE FROM FTS$<<IND_NME>>$WRD' + #13#10 +
  'WHERE FTS$<<KEY_COL>> = :FTS$KEY' + #13#10 +
  '  AND FTS$WRD = :FTS$WRD';
end;

destructor TIB_FTS_Sync.Destroy;
begin
  inherited Destroy;
  FLogList.Free;
  FLogList := nil;
  qrQ.WordList.Free;
  qrQ.WordList := nil;
  qrQ.LogList.Free;
  qrQ.LogList := nil;
  qrFull.WordList.Free;
  qrFull.WordList := nil;
  qrFull.LogList.Free;
  qrFull.LogList := nil;
// Not sure why this is here.
// This is causing an AV upon closing the IB_FTS application.  
//  SetInterval( 250 );
end;

procedure TIB_FTS_Sync.DoLogText( const AText: string );
begin
  if Assigned( FOnLogItem ) then
  begin
    FLogList.Text := AText;
    FOnLogItem( Self );
    FLogList.Clear;
  end;
end;

procedure TIB_FTS_Sync.evQEventAlert( Sender: TObject;
                                      AEventName: string;
                                      AEventCount: Integer );
begin
  if AEventName = 'FTS$' + SearchIndexName + '$Q_INSERT' then ResyncQueue else
  if AEventName = 'FTS$' + SearchIndexName + '$RESYNC' then ResyncIndex else
  if AEventName = 'FTS$' + SearchIndexName + '$CLEAN' then CleanIndex;
end;

procedure TIB_FTS_Sync.ResyncQueue;
begin
  BeginBusy( Yield );
  try
    if not Prepared then Prepare;
    if Prepared then
    begin
      if qrQ.Cursor.Active then qrQ.Cursor.Close;
      qrQ.Cursor.Open;
      NeedToResyncQueue := false;
      qrQ.AbortGen := qrQ.Cursor.FetchingAbortedGen;
      if not Passive and not Executing then Execute;
    end;
  finally
    EndBusy;
  end;
end;

procedure TIB_FTS_Sync.ResyncIndex;
begin
  BeginBusy( Yield );
  try
    if not Prepared then Prepare;
    if Prepared then
    begin
      if qrFull.Cursor.Active then
      begin
        qrFull.Cursor.Close;
        qrFull.Trans.Rollback;
        DoLogText( 'Check of the ' + SearchIndexName + ' FTS index halted' );
      end;
      qrFull.Cycle := false;
      qrFull.CommitCount := 0;
      try
        crMin.First;
        qrFull.KEY_COL := crMIN.Fields[0].AsString;
      finally
        crMin.Unprepare;
      end;
      DoLogText( 'Check of the ' + SearchIndexName + ' FTS index initiated' );
      qrFull.Cursor.ParamByName( 'FTS$KEY_COL' ).AsString := qrFull.KEY_COL;
      qrFull.Cursor.Open;
      qrFull.AbortGen := qrFull.Cursor.FetchingAbortedGen;
      if not Passive and not Executing then Execute;
    end;
  finally
    EndBusy;
  end;
end;

procedure TIB_FTS_Sync.CleanIndex;
begin
  if not Prepared then Prepare;
  if Prepared then
  begin
    NeedToCleanWRD := true;
    NeedToCleanMTP := true;
    NeedToCleanSDX := true;
    NeedToCleanSMX := true;
    if not Passive and not Executing then Execute;
  end;
end;

procedure TIB_FTS_Sync.crFullAfterFetchRow( IB_Dataset: TIB_Dataset );
var
  tmpStr: string;
begin
  if ( qrFull.KEY_COL <> fldFull_KEY_COL.AsString ) or
     ( qrFull.Cursor.RowNum = 1 ) then
  begin
    if qrFull.Cursor.RowNum > 1 then
    begin
      InsertNameWords( qrFull );
      if ( qrFull.LogList.Count > 1 ) then
      begin
        qrFull.Trans.CommitRetaining;
        DoLogText( qrFull.LogList.Text );
        Inc( qrFull.CommitCount );
      end;
      qrFull.LogList.Clear;
      if ( qrFull.Trans.TimeActive * 2880 >= 1 ) or
         ( qrFull.CommitCount >= 200 ) then
      begin
        qrFull.Cycle := true;
        Exit;
      end;
    end;
    tmpStr := fldFull_SCH_COL.AsString; 
    qrFull.LogList.Text :=
      KEY_COL + ': ' + fldFull_KEY_COL.AsString + ' ' +
      AUX_COL + ': ' + fldFull_AUX_COL.AsString + ' ' +
      SCH_COL + ': ' + tmpStr;
    if Assigned( OnModifySearchWords ) then
      OnModifySearchWords( Self, tmpStr, fldQ_AUX_COL.AsString );
    parse_word_list( tmpStr, WRD_LEN, qrFull.WordList );
    qrFull.KEY_COL := fldFull_KEY_COL.AsString;
  end;
  CheckNameWord( fldFull_WRD.AsString, qrFull );
end;

procedure TIB_FTS_Sync.crFullAfterFetchEof( IB_Dataset: TIB_Dataset );
begin
  InsertNameWords( qrFull );
  if ( qrFull.LogList.Count > 1 ) and Assigned( FOnLogItem ) then
  begin
    FLogList.Assign( qrFull.LogList );
    FOnLogItem( Self );
    FLogList.Clear;
  end;
  qrFull.LogList.Clear;
  if qrFull.Trans.TransactionIsActive then
    qrFull.Trans.CommitRetaining;
end;

procedure TIB_FTS_Sync.crQAfterFetchRow( IB_Dataset: TIB_Dataset );
var
  tmpStr: string;
begin
  qrQ.KEY_COL := fldQ_KEY_COL.AsString;
  qrQ.LogList.Text := KEY_COL + ': ' + qrQ.KEY_COL +
                      ' Action: ' + fldQ_Q_TYP.AsString +
                      ' ' + AUX_COL + ': ' + fldQ_AUX_COL.AsString +
                      ' ' + SCH_COL + ': ' + fldQ_SCH_COL.AsString;
  if fldQ_Q_TYP.AsString = 'D' then
  begin
    prmdDEL_FTKEY.AsString := qrQ.KEY_COL;
    dDel.ExecSQL;
    qrQ.LogList.Add( '  Removed all words' );
  end
  else
  begin
    tmpStr := fldQ_SCH_COL.AsString;
    if Assigned( OnModifySearchWords ) then
      OnModifySearchWords( Self, tmpStr, fldQ_AUX_COL.AsString );
    parse_word_list( tmpStr, WRD_LEN, qrQ.WordList );
    if fldQ_Q_TYP.AsString = 'U' then
    begin
      prmcrUPD_FTKEY.AsString := qrQ.KEY_COL;
      try
        crUpd.First;
        while not crUpd.Eof do
        begin
          CheckNameWord( fldcrUPD_FTWRD.AsString, qrQ );
          crUpd.Next;
        end;
      finally
        crUpd.Close;
      end;
    end;
    InsertNameWords( qrQ );
  end;
  try
    prmdNMD_FTQ_KEY.Assign( fldQ_Q_KEY );
    dNmD.ExecSQL;
    qrQ.Trans.CommitRetaining;
    if qrQ.LogList.Count > 1 then DoLogText( qrQ.LogList.Text );
  finally
    qrQ.LogList.Clear;
  end;
end;

procedure TIB_FTS_Sync.CheckNameWord( const AWord: string;
                                      const APQR: TIB_PassiveQueryRef );
var
  tmpInd: integer;
begin
  tmpInd := APQR.WordList.IndexOf( AWord );
  if tmpInd = -1 then
  begin
    APQR.Trans.Started := true;
    dUpd.IB_Transaction := APQR.Trans;
    prmdUPD_FTKEY.AsString := APQR.KEY_COL;
    prmdUPD_FTWRD.AsString := AWord;
    dUpd.ExecSQL;
    APQR.LogList.Add( '  Removed: ' + AWord );
  end
  else
    APQR.WordList.Delete( tmpInd );
end;

procedure TIB_FTS_Sync.InsertNameWords( const APQR: TIB_PassiveQueryRef );
var
  tmpS: string;
  ii: integer;
begin
  if APQR.WordList.Count > 0 then
  begin
    APQR.Trans.Started := true;
    dIns.IB_Transaction := APQR.Trans;
    prmFTKEY.AsString := APQR.KEY_COL;
    for ii := 0 to APQR.WordList.Count - 1 do
    begin
      tmpS := Trim( APQR.WordList[ii] );
      if Length( tmpS ) > 1 then
      begin
        prmFTWRD.AsString := tmpS;
        prmFTMTP.AsString := MetaPh( tmpS, WRD_LEN );
        prmFTSDX.AsString := IB_Connection.GetSoundEx( tmpS );
        prmFTSMX.AsString := IB_Connection.GetSoundExMax( tmpS );
        dIns.ExecSQL;
        APQR.Trans.Activate;
        APQR.LogList.Add( '  Added: ' + tmpS );
      end;
    end;
  end;
end;

procedure TIB_FTS_Sync.SysPrepare;
begin
  inherited SysPrepare;
  if not IsActivated then
    raise Exception.Create( 'Search Index ' + SearchIndexName +
                            ' is not activated' );
  prmFull_KEY_COL := qrFull.Cursor.ParamByName( 'FTS$KEY_COL' );
  fldFull_KEY_COL := qrFull.Cursor.FieldByName( 'FTS$KEY_COL' );
  fldFull_WRD     := qrFull.Cursor.FieldByName( 'FTS$WRD'     );
  fldFull_AUX_COL := qrFull.Cursor.FieldByName( 'FTS$AUX_COL' );
  fldFull_SCH_COL := qrFull.Cursor.FieldByName( 'FTS$SCH_COL' );
  fldQ_Q_KEY      := qrQ.Cursor.FieldByName( 'FTS$Q_KEY' );
  fldQ_Q_TYP      := qrQ.Cursor.FieldByName( 'FTS$Q_TYP' );
  fldQ_KEY_COL    := qrQ.Cursor.FieldByName( 'FTS$KEY_COL' );
  fldQ_AUX_COL    := qrQ.Cursor.FieldByName( 'FTS$AUX_COL' );
  fldQ_SCH_COL    := qrQ.Cursor.FieldByName( 'FTS$SCH_COL' );
  prmcrUPD_FTKEY  := crUPD.ParamByName( 'FTS$KEY' );
  fldcrUPD_FTWRD  := crUPD.FieldByName( 'FTS$WRD' );
  prmdNMD_FTQ_KEY := dNmD.ParamByName( 'FTS$Q_KEY' );
  prmdDEL_FTKEY   := dDel.ParamByName( 'FTS$KEY' );
  prmFTKEY        := dIns.ParamByName( 'FTS$KEY' );
  prmFTWRD        := dIns.ParamByName( 'FTS$WRD' );
  prmFTMTP        := dIns.ParamByName( 'FTS$MTP' );
  prmFTSDX        := dIns.ParamByName( 'FTS$SDX' );
  prmFTSMX        := dIns.ParamByName( 'FTS$SMX' );
  prmdUPD_FTKEY   := dUPD.ParamByName( 'FTS$KEY' );
  prmdUPD_FTWRD   := dUPD.ParamByName( 'FTS$WRD' );
  evQ.Events.Text := 'FTS$' + SearchIndexName + '$Q_INSERT'#13#10 +
                     'FTS$' + SearchIndexName + '$RESYNC'#13#10 +
                     'FTS$' + SearchIndexName + '$CLEAN'#13#10;
  qrQ.LogList.Clear;
  qrFull.LogList.Clear;
  DoLogText( 'FTS Index ' + SearchIndexName + ' prepared for synchronization' );
end;

procedure TIB_FTS_Sync.DoAfterPrepare;
begin
  inherited DoAfterPrepare;
  NeedToResyncQueue := true;
  if not Passive then ResyncQueue;
end;

procedure TIB_FTS_Sync.DoStatusChange;
begin
  inherited DoStatusChange;
  if IsCorrupted or not IsMetaLoaded or not Prepared then
  begin
    crUpd.Unprepare;
    dNmD.Unprepare;
    dDel.Unprepare;
    dIns.Unprepare;
    dUpd.Unprepare;
    if not IsActivated or not Prepared then
    begin
      qrFull.Cursor.Unprepare;
      qrQ.Cursor.Unprepare;
      qrQ.Trans.Close;
      qrFull.Trans.Close;
    end;
    evQ.UnregisterEvents;
    if Assigned( IB_Connection ) then
      IB_Connection.FreeStmtHandleCache( 0 );
    NeedToResyncQueue := false;
  end
  else
  if IsActivated and
     (( Interval > 0 ) or Assigned( OnWakeup ) or UseDefaultWakeup ) then
  begin
    if not evQ.Registered then
      evQ.RegisterEvents;
  end
  else
  begin
    evQ.UnregisterEvents;
  end;
end;

procedure TIB_FTS_Sync.SysUnprepare;
begin
  inherited SysUnprepare;
  evQ.UnregisterEvents;
  qrFull.Cursor.Unprepare;
  qrQ.Cursor.Unprepare;
  crUpd.Unprepare;
  dNmD.Unprepare;
  dDel.Unprepare;
  dIns.Unprepare;
  dUpd.Unprepare;
  qrQ.Trans.Close;
  qrFull.Trans.Close;
  if not ( csDestroying in ComponentState ) then
    DoLogText( 'FTS Index ' + SearchIndexName + ' has been unprepared' );
end;

procedure TIB_FTS_Sync.SysFinalize;
  procedure FinalizePQR( const PQR: TIB_PassiveQueryRef );
  var
    tmpStr: string;
  begin
    if PQR.Cursor.Active then
    begin
      if ( ExecutingAborted ) or
         ( PQR.Cursor.FetchingAbortedGen <> PQR.AbortGen ) then
        tmpStr := 'aborted'
      else
      if ExecutingFailed then
        tmpStr := 'failed'
      else
      if not PQR.Cursor.Eof then
        tmpStr := 'abandoned'
      else
        tmpStr := 'completed';
      PQR.Cursor.Close;
      tmpStr := PQR.Cursor.Name + ' Cursor ' + tmpStr;
      DoLogText( 'Check of the ' + SearchIndexName + ' FTS index ' + tmpStr );
    end;
    if PQR.Trans.Started then
      PQR.Trans.Commit;
  end;
begin
  NeedToCleanWRD := false;
  NeedToCleanMTP := false;
  NeedToCleanSDX := false;
  NeedToCleanSMX := false;
  NeedToResyncQueue := false;
  FinalizePQR( qrQ );
  FinalizePQR( qrFull );
  inherited SysFinalize;
end;

procedure TIB_FTS_Sync.SysExecute( var IsDone: boolean );
  function QueryDone( var AQR: TIB_PassiveQueryRef ): boolean;
  begin
    Result := not AQR.Cursor.Active or AQR.Cursor.Eof or
              ( AQR.Cursor.FetchingAbortedGen <> AQR.AbortGen );
    if not Result then
    begin
      AQR.Cursor.Next;
      if AQR.Cycle then
      begin
        DoLogText( 'Cycling ' + AQR.Cursor.Name + ' ' +
                   'Key Col ' + AQR.KEY_COL + ' ' +
                   'Row Num ' + IntToStr( AQR.Cursor.RowNum ) + ' ' +
                   'Commit Count ' + IntToStr( AQR.CommitCount ));
        AQR.Cycle := false;
        AQR.CommitCount := 0;
        AQR.Cursor.Close;
        if AQR.Trans.Started then AQR.Trans.Commit;
        AQR.Cursor.ParamByName( 'FTS$KEY_COL' ).AsString := AQR.KEY_COL;
        AQR.Trans.Started := true;
        AQR.Cursor.Open;
        DoLogText( 'Cycled ' + AQR.Cursor.Name );
      end;
    end;
  end;
  procedure CleanStatTable( var AFlg: boolean; const ATbl: string );
  var
    S, T: string;
  begin
    if IsDone and AFlg then
      with TIB_Transaction.Create( Self ) do
        try
          IB_Connection := Self.IB_Connection;
          S := SearchIndexName;
          T := 'FTS$' + S + '$CNT_' + ATbl;
          DoLogText( 'Cleaning ' + T );
          ExecuteImmediate( 'delete from ' + T + ' where FTS$CNT <= 0' );
          Commit;
          AFlg := false;
          DoLogText( 'Cleaned ' + T );
        finally
          Free;
        end;
  end;
var
  tmpWait, tmpTerm: boolean;  
begin
  evQ.CheckEvents;
  if NeedToResyncQueue then ResyncQueue;
  IsDone := QueryDone( qrQ );
  IsDone := QueryDone( qrFull ) and IsDone and not NeedToResyncQueue;
  if IsDone then
  begin
    CleanStatTable( NeedToCleanWRD, 'WRD' );
    CleanStatTable( NeedToCleanMTP, 'MTP' );
    CleanStatTable( NeedToCleanSDX, 'SDX' );
    CleanStatTable( NeedToCleanSMX, 'SMX' );
    IsDone := not NeedToCleanWRD and
              not NeedToCleanMTP and
              not NeedToCleanSDX and
              not NeedToCleanSMX;
  end;
  if IsDone then qrQ.Trans.ProcessPassiveTasks( IsDone, tmpWait, tmpTerm );
  if IsDone then qrFull.Trans.ProcessPassiveTasks( IsDone, tmpWait, tmpTerm );
end;

function TIB_FTS_Sync.SysNeedToExecute: boolean;
begin
  Result := inherited SysNeedToExecute;
  if Prepared and not Result then
    Result := evQ.EventsPending or
              qrQ.Cursor.Active or
              qrFull.Cursor.Active or
              qrQ.Trans.Started or
              qrFull.Trans.Started or
              NeedToResyncQueue or
              NeedToCleanWRD or
              NeedToCleanMTP or
              NeedToCleanSDX or
              NeedToCleanSMX;
end;

procedure TIB_FTS_Sync.SetSearchIndexName( AValue: string );
begin
  if SearchIndexName <> Trim( AValue ) then Unprepare;
  inherited SetSearchIndexName( AValue );
end;

procedure TIB_FTS_Sync.SetPassive( AValue: boolean );
begin
  inherited SetPassive( AValue );
  evQ.Passive := Passive;
end;

function TIB_FTS_Sync.GetWakeup: TNotifyEvent;
begin
  Result := evQ.OnWakeup;
end;

procedure TIB_FTS_Sync.SetWakeup( AValue: TNotifyEvent );
begin
  evQ.OnWakeup := AValue;
end;

function TIB_FTS_Sync.GetInterval: cardinal;
begin
  Result := evQ.Interval;
end;

procedure TIB_FTS_Sync.SetInterval( AValue: cardinal );
begin
  evQ.Interval := AValue;
end;

procedure TIB_FTS_Sync.ProcessConnectionEvent(
  AConnectionLink: TIB_ConnectionLink;
  AEvent: TIB_ConnectionEventType ); 
begin
  inherited ProcessConnectionEvent( AConnectionLink, AEvent );
  if AEvent = cetAfterAssignment then
  begin
    evQ.IB_Connection := IB_Connection;
    crMin.IB_Connection := IB_Connection;
    crUpd.IB_Connection := IB_Connection;
    dNmD.IB_Connection := IB_Connection;
    dDel.IB_Connection := IB_Connection;
    dIns.IB_Connection := IB_Connection;
    dUpd.IB_Connection := IB_Connection;
    qrQ.Cursor.IB_Connection := IB_Connection;
    qrQ.Trans.IB_Connection := IB_Connection;
    qrFull.Cursor.IB_Connection := IB_Connection;
    qrFull.Trans.IB_Connection := IB_Connection;
  end;
end;

procedure TIB_FTS_Sync.SetUseDefaultWakeup( AValue: boolean );
begin
  if FUseDefaultWakeup <> AValue then
  begin
    FUseDefaultWakeup := AValue;
    DoStatusChange;
  end;
end;

end.

