
{                                                                              }
{ IB_RPL_Meta                                                                  }
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
  IB_RPL_Meta;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms,

  IB_Header,
  IB_Constants,
  IB_Session,
  IB_Components,
  IB_DataPump,

  IB_RPL_Base,
  IB_RPL_Sync,
  IB_RPL_Scripts;

type
  TIB_RPL_Meta = class( TIB_RPL_Sync )
  private
    dmRPL_Scripts: TdmRPL_Scripts;
    procedure ChangeStatus( const NewStatus,
                                  PrevStatus,
                                  ErrorMessage: string );
  protected
    procedure ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                    AEvent: TIB_ConnectionEventType ); override;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure LoadBase;
    procedure DropBase;
    procedure LoadIndexMeta;
    procedure DropIndexMeta;
    procedure ActivateIndex;
  end;

implementation

uses
  IB_Parse,
  IB_Utils;

constructor TIB_RPL_Meta.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  dmRPL_Scripts := TdmRPL_Scripts.Create( IB_Session );
  dmRPL_Scripts.SetMacroEvent( SysMacroSubstitute );
end;

destructor TIB_RPL_Meta.Destroy;
begin
  dmRPL_Scripts.Free;
  dmRPL_Scripts := nil;
  inherited Destroy;
end;

procedure TIB_RPL_Meta.ProcessConnectionEvent(
  AConnectionLink: TIB_ConnectionLink;
  AEvent: TIB_ConnectionEventType );
begin
  inherited ProcessConnectionEvent( AConnectionLink, AEvent );
  if AEvent = cetAfterAssignment then
    dmRPL_Scripts.SetConnection( IB_ConnectionSrc, IB_Connection );
end;

procedure TIB_RPL_Meta.ChangeStatus( const NewStatus,
                                           PrevStatus,
                                           ErrorMessage: string );
var
  tmpStatus: string;
  tmpPos: integer;
  tmpTxt: string;
  tmpItm: string;
  tmpDSQL: TIB_DSQL;
begin
  tmpTxt := '';
  tmpStatus := PrevStatus;
  tmpPos := Pos( '.', tmpStatus );
  while tmpPos > 0 do
  begin
    if tmpTxt <> '' then
      tmpTxt := tmpTxt + ' OR'#13#10'        ';
    tmpItm := Copy( tmpStatus, 1, tmpPos - 1 );
    tmpTxt := tmpTxt + 'RPL$STATUS = ' + mkLitCriteria( tmpItm, '''' );
    tmpStatus := Copy( tmpStatus, tmpPos + 1, MaxInt );
    tmpPos := Pos( '.', tmpStatus );
  end;
  if tmpTxt <> '' then
    tmpTxt := tmpTxt + ' OR'#13#10'        ';
  tmpTxt := tmpTxt + 'RPL$STATUS = ' + mkLitCriteria( tmpStatus, '''' );
  tmpTxt := 'UPDATE RPL$_IND'#13#10 +
            '   SET RPL$STATUS = ' + mkLitCriteria( NewStatus, '''' ) +
            #13#10 +
            'WHERE ( ' +
            tmpTxt +
            ' )'#13#10 +
            '  AND RPL$IND_NME = ' + mkLitCriteria( ReplicatorIndexName, '''' );
  tmpDSQL := TIB_DSQL.Create( Self );
  try
    tmpDSQL.IB_Connection := Self.IB_Connection;
    tmpDSQL.IB_Transaction := dmRPL_Scripts.trDST;
    tmpDSQL.SQL.Text := tmpTxt;
    tmpDSQL.Prepare;
    tmpDSQL.ExecSQL;
    if tmpDSQL.RowsAffected = 1 then
    begin
      _STATUS := NewStatus;
      DoStatusChange;
    end
    else
      raise Exception.Create( ErrorMessage );
  finally
    tmpDSQL.Free;
  end;
end;

procedure TIB_RPL_Meta.LoadBase;
begin
  if Assigned( IB_Connection ) and Assigned( IB_ConnectionSrc ) then
  begin
    IB_Connection.Connect;
    IB_ConnectionSrc.Connect;
    Prepare;
    if not BaseLoaded then
    begin
      dmRPL_Scripts.scDSTLoadBase.Execute;
      FBaseLoaded := true;
    end;
  end;
end;

procedure TIB_RPL_Meta.DropBase;
begin
  if Assigned( IB_Connection ) and Assigned( IB_ConnectionSrc ) then
  begin
    IB_Connection.Connect;
    IB_ConnectionSrc.Connect;
    Prepare;
    if BaseLoaded then
    begin
      IB_Connection.DeallocateStatements;
      dmRPL_Scripts.scDSTDropBase.Execute;
      FBaseLoaded := false;
    end;
  end;
end;

procedure TIB_RPL_Meta.LoadIndexMeta;
var
  tmpCursor: TIB_Cursor;
  tmpSYNC_ID: TIB_Column;
  tblCreated: boolean;
  tmpStr: string;
begin
  Prepare;
  ChangeStatus( 'MP', 'I', 'Invalid status to load this index metadata from' );
  try
    dmRPL_Scripts.scSRCLoadMeta.Execute;
// See if the destination table already exists.
// In this case we merely need to add the sync columns.
    tmpCursor := TIB_Cursor.Create( Self );
    try
      tmpCursor.IB_Connection := Self.IB_Connection;
      tmpCursor.IB_Transaction := dmRPL_Scripts.trDST;
      tmpCursor.OnMacroSubstitute := SysMacroSubstitute;
      tmpCursor.SQL.Text := 'SELECT * FROM <<DST_TBL_NME>> n';
      with tmpCursor do
      begin
        try
          ExecuteImmediate( 'CREATE GENERATOR RPL$<<IND_NME>>$SYNC_ID_GEN',
                            nil );
        except
        end;
        ExecuteImmediate( 'SET GENERATOR RPL$<<IND_NME>>$SYNC_ID_GEN TO 999',
                            nil );
      end;
      tblCreated := DST_TBL_CREATE <> 'T';
      try
        tmpCursor.Prepare;
      except
        on E: EIB_ISCError do
        begin
          if E.ERRCODE = isc_dsql_error then
            tblCreated := false
          else
            raise;
        end
        else
          raise;
      end;
      if not tblCreated then
      begin
        tmpCursor.ExecuteImmediate(
          'CREATE TABLE <<DST_TBL_NME>> ( ' +
            'RPL$SYNC_ID RPL$ID_DM,' +
            '<<DST_TBL_SRC>> );', nil );
        tmpCursor.ExecuteImmediate(
          'ALTER TABLE <<DST_TBL_NME>>' +
          '  ADD CONSTRAINT <<PK_DST_TBL_NME>>' +
          '        PRIMARY KEY ( <<DST_KEY_CLS>> );', nil );
      end;
      tmpCursor.Prepare;
      tmpSYNC_ID := tmpCursor.FindField( 'RPL$SYNC_ID' );
      if not Assigned( tmpSYNC_ID ) then
        tmpCursor.ExecuteImmediate(
          'ALTER TABLE <<DST_TBL_NME>> ' +
            'ADD RPL$SYNC_ID RPL$ID_DM', nil );
      tmpCursor.SQL.Text := 'SELECT MAX( RPL$SYNC_ID ) FROM <<DST_TBL_NME>>';
      tmpCursor.First;
      tmpStr := tmpCursor.Fields[0].AsString;
      if tmpStr = '' then tmpStr := '999';
      tmpCursor.
      ExecuteImmediate( 'SET GENERATOR RPL$<<IND_NME>>$SYNC_ID_GEN TO ' +
                        tmpStr, nil );
      tmpCursor.ExecuteImmediate(
        'UPDATE <<DST_TBL_NME>> n SET <<SET_EXP_N>>'#13#10 +
          '  RPL$SYNC_ID = GEN_ID( RPL$<<IND_NME>>$SYNC_ID_GEN, 0 )'#13#10 +
          'WHERE n.RPL$SYNC_ID IS NULL'#13#10 +
          '  AND ( <<DST_DEL_EXP>> )', nil );
    finally
      tmpCursor.Free;
    end;
    dmRPL_Scripts.scDSTLoadMeta.Execute;
    ResetVariables;
    dmRPL_Scripts.scSRCLoadProc.Execute;
    dmRPL_Scripts.scDSTLoadProc.Execute;
    ChangeStatus( 'M',
                  'MP', 'Invalid status to load this index metadata from' );
  except
    on E: Exception do
    begin
      Application.HandleException( E );
      ChangeStatus( 'MC',
                    'MP', 'Invalid status to load this index metadata from' );
    end;
  end;
end;

procedure TIB_RPL_Meta.DropIndexMeta;
begin
  Prepare;
  ChangeStatus( 'IP','IC.M.MC.L.LC.A.AC',
                'Invalid status to drop this index metadata from' );
  try
    dmRPL_Scripts.scSRCDropProc.Execute;
    dmRPL_Scripts.scDSTDropProc.Execute;
    dmRPL_Scripts.scSRCDropMeta.Execute;
    dmRPL_Scripts.scDSTDropMeta.Execute;
    ChangeStatus( 'I',
                  'IP', 'Invalid status to drop this index metadata from' );
  except
    on E: Exception do
    begin
      Application.HandleException( E );
      ChangeStatus( 'IC',
                    'IP', 'Invalid status to drop this index metadata from' );
    end;
  end;
end;

procedure TIB_RPL_Meta.ActivateIndex;
var
  oldPassive: boolean;
begin
  if not IsMetaLoaded then
    raise Exception.Create( 'Search Index ' + ReplicatorIndexName +
                            ' metadata is not loaded' );
  oldPassive := Passive;
  Prepare;
  if IsActivated and not IsCorrupted then Exit;
  ChangeStatus( 'AP', 'M.AC.AP', 'Invalid status to activate this index from' );
  try
    Passive := false;
    ResyncIndex;
    ChangeStatus( 'A', 'A.AP', 'Invalid status to activate this index from' );
  except
    on E: Exception do
    begin
      Application.HandleException( E );
      ChangeStatus( 'AC', 'AP', 'Invalid status to activate this index from' );
    end;
  end;
  Passive := oldPassive;
end;

end.
