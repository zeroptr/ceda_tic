
{                                                                              }
{ IB_FTS_Meta                                                                  }
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
  IB_FTS_Meta;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms,

  IB_Constants,
  IB_Session,
  IB_Components,

  IB_FTS_Base,
  IB_FTS_Scripts;

type
  TIB_FTS_Meta = class( TIB_FTS_Base )
  private
    crTBL: TIB_Cursor;
    dWRD: TIB_DSQL;
    clNameKEY: TIB_Column;
    clNameTXT: TIB_Column;
    clNameAUX: TIB_Column;
    clFTWRD: TIB_Column;
    clFTKEY: TIB_Column;
    clFTMPH: TIB_Column;
    clFTSND: TIB_Column;
    clFTSMX: TIB_Column;
    FWordList: TIB_StringList;
    dmFTS_Scripts: TdmFTS_Scripts;
    procedure crTBLAfterFetchRow( IB_Dataset: TIB_Dataset );
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
    procedure PopulateIndex;
    procedure ActivateIndex;
  end;

implementation

uses
  IB_Parse,
  IB_Utils;

constructor TIB_FTS_Meta.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  crTBL := TIB_Cursor.Create( Self );
  crTBL.AfterFetchRow := crTBLAfterFetchRow;
  dWRD := TIB_DSQL.Create( Self );
  FWordList := TIB_StringList.Create;
  FWordList.Sorted := true;
  FWordList.Duplicates := dupIgnore;
  dmFTS_Scripts := TdmFTS_Scripts.Create( IB_Session );
  dmFTS_Scripts.SetMacroEvent( SysMacroSubstitute );
end;

destructor TIB_FTS_Meta.Destroy;
begin
  FWordList.Free;
  FWordList := nil;
  dmFTS_Scripts.Free;
  dmFTS_Scripts := nil;
  inherited Destroy;
end;

procedure TIB_FTS_Meta.ProcessConnectionEvent(
  AConnectionLink: TIB_ConnectionLink;
  AEvent: TIB_ConnectionEventType );
begin
  inherited ProcessConnectionEvent( AConnectionLink, AEvent );
  if AEvent = cetAfterAssignment then
  begin
    dmFTS_Scripts.SetConnection( IB_Connection );
    crTbl.IB_Connection := IB_Connection;
    dWRD.IB_Connection := IB_Connection;
  end;
end;

procedure TIB_FTS_Meta.ChangeStatus( const NewStatus,
                                           PrevStatus,
                                           ErrorMessage: string );
var
  tmpStatus: string;
  tmpPos: integer;
  tmpTxt: string;
  tmpItm: string;
begin
  tmpTxt := '';
  tmpStatus := PrevStatus;
  tmpPos := Pos( '.', tmpStatus );
  while tmpPos > 0 do
  begin
    if tmpTxt <> '' then
      tmpTxt := tmpTxt + ' OR'#13#10'        ';
    tmpItm := Copy( tmpStatus, 1, tmpPos - 1 );
    tmpTxt := tmpTxt + 'FTS$STATUS = ' + mkLitCriteria( tmpItm, '''' );
    tmpStatus := Copy( tmpStatus, tmpPos + 1, MaxInt );
    tmpPos := Pos( '.', tmpStatus );
  end;
  if tmpTxt <> '' then
    tmpTxt := tmpTxt + ' OR'#13#10'        ';
  tmpTxt := tmpTxt + 'FTS$STATUS = ' + mkLitCriteria( tmpStatus, '''' );
  tmpTxt := 'UPDATE FTS$_IND'#13#10 +
            '   SET FTS$STATUS = ' + mkLitCriteria( NewStatus, '''' ) +
            #13#10 +
            'WHERE ( ' +
            tmpTxt +
            ' )'#13#10 +
            '  AND FTS$IND_NME = ' + mkLitCriteria( SearchIndexName, '''' );
  with TIB_DSQL.Create( Self ) do
    try
      IB_Connection := Self.IB_Connection;
      SQL.Text := tmpTxt;
      ExecSQL;
      if RowsAffected = 1 then
      begin
         _STATUS := NewStatus;
        if Assigned( OnStatusChange ) then
          OnStatusChange( Self );
      end
      else
        raise Exception.Create( ErrorMessage );
    finally
      Free;
    end;
end;

procedure TIB_FTS_Meta.LoadBase;
begin
  if Assigned( IB_Connection ) then
  begin
    Prepare;
    if not BaseLoaded then dmFTS_Scripts.scLoadBase.Execute;
    IB_Connection.Disconnect;
    IB_Connection.Connect;
  end;
end;

procedure TIB_FTS_Meta.DropBase;
begin
  Prepare;
  if BaseLoaded then
  begin
    IB_Connection.DeallocateStatements;
    dmFTS_Scripts.scDropBase.Execute;
  end;
  IB_Connection.Disconnect;
  IB_Connection.Connect;
end;

procedure TIB_FTS_Meta.LoadIndexMeta;
begin
  Prepare;
  ChangeStatus( 'MP', 'I', 'Invalid status to load this index metadata from' );
  try
    dmFTS_Scripts.scLoadMeta.Execute;
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

procedure TIB_FTS_Meta.DropIndexMeta;
begin
  Prepare;
  ChangeStatus( 'IP','IC.M.MC.L.LC.A.AC',
                'Invalid status to drop this index metadata from' );
  try
    dmFTS_Scripts.scDropMeta.Execute;
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

procedure TIB_FTS_Meta.ActivateIndex;
begin
  Prepare;
  ChangeStatus( 'AP', 'L', 'Invalid status to activate this index from' );
  try
    dmFTS_Scripts.scLoadIndx.Execute;
    ChangeStatus( 'A', 'AP', 'Invalid status to activate this index from' );
  except
    on E: Exception do
    begin
      Application.HandleException( E );
      ChangeStatus( 'AC', 'AP', 'Invalid status to activate this index from' );
    end;
  end;
end;

procedure TIB_FTS_Meta.PopulateIndex;
var
  tmpInd: string;
  tmpTbl: string;
  tmpKey: string;
  tmpTxt: string;
begin
  if IsPopulated then Exit;
  Prepare;
  ChangeStatus( 'LP', 'M', 'Invalid status to populate this index from' );
  try
    tmpInd := SearchIndexName;
    tmpTbl := TBL_NME;
    tmpKey := KEY_COL;
    tmpTxt := SCH_COL;
    crTBL.SQL.Text := 'SELECT ' + tmpTbl + '.' + tmpKey + ', ' +
                                  tmpTbl + '.' + tmpTxt + ', ' +
                                  tmpTbl + '.' + AUX_COL + //', ' +
                      ' FROM ' +
                                  tmpTbl;
    clNameKEY := crTBL.FieldByName( tmpKey );
    clNameTXT := crTBL.FieldByName( tmpTxt );
    clNameAUX := crTBL.FieldByName( AUX_COL );
    dWRD.SQL.Text := 'EXECUTE PROCEDURE FTS$' + tmpInd + '$' + 'ADD_WRD ' +
                        ':FTS$KEY, :FTS$WRD, :FTS$MTP, :FTS$SDX, :FTS$SMX';
    clFTKEY := dWRD.ParamByName( 'FTS$key' );
    clFTWRD := dWRD.ParamByName( 'FTS$wrd' );
    clFTMPh := dWRD.ParamByName( 'FTS$mtp' );
    clFTSnd := dWRD.ParamByName( 'FTS$sdx' );
    clFTSmx := dWRD.ParamByName( 'FTS$smx' );
    crTBL.IB_Transaction.StartTransaction;
    try
      crTBL.FetchAll;
      ChangeStatus( 'L', 'LP', 'Invalid status to populate this index from' );
      crTBL.IB_Transaction.Commit;
    except
      crTBL.IB_Transaction.Rollback;
      raise;
    end;
  except
    on E: Exception do
    begin
      Application.HandleException( E );
      ChangeStatus( 'LC', 'LP', 'Invalid status to populate this index from' );
    end; 
  end;
end;

procedure TIB_FTS_Meta.crTBLAfterFetchRow( IB_Dataset: TIB_Dataset );
var
  tmpS: string;
  jj: integer;
begin
  tmpS := clNameTXT.AsString;
  if Assigned( OnModifySearchWords ) then
    OnModifySearchWords( Self, tmpS, clNameAUX.AsString );
  parse_word_list( tmpS, WRD_LEN, FWordList );
  clFTKEY.AsString := clNameKEY.AsString;
  for jj := 0 to FWordList.Count - 1 do
  begin
    tmpS := Trim( FWordList[jj] );
    if Length( tmpS ) > 1 then
    begin
      clFTWRD.AsString := tmpS;
      clFTMPh.AsString := metaph( tmpS, WRD_LEN );
      clFTSnd.AsString := IB_Connection.GetSoundex( tmpS );
      clFTSmx.AsString := IB_Connection.GetSoundexMax( tmpS );
      dWRD.ExecSQL;
    end;
  end;
end;

end.
