
{                                                                              }
{ IB_RPL_Base                                                                  }
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
{  Bertrand Lescouët <blescouet@jes.fr>                                        }
{  09/18/2002                                                                  }
{     bug fixes in WalkFields                                                  }
{     Ignoring blob fields in stored procedure and trigger's code generation   }
{     if they don't have to be replicated (MacroSubstitute procedure)          }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_RPL_Base;

interface

uses
  Windows, Messages, SysUtils, Classes,

  IB_Constants,
  IB_Components,
  IB_Process;
//IB_RPL_Meta
//IB_RPL_Search
//IB_RPL_Sync

type
  TIB_RPL_Base = class( TIB_ConnectionProcess )
  private
    FReplicatorIndexName: string;
    FSrcCL: TIB_ConnectionLink;
    crSRC: TIB_Cursor;
    crDST: TIB_Cursor;
    trSRC: TIB_Transaction;
    trDST: TIB_Transaction;
    function GetSrcConnection: TIB_Connection;
    procedure SetSrcConnection( AValue: TIB_Connection );
    function GetDST_TBL_SRC: string;
    function GetDST_CLS: string;
    function GetSRC_CLS: string;
    function GetDST_KEY_CLS: string;
    function GetDST_SRC_CLS: string;
    function GetDST_SRC_CLS_MAP: string;
    function GetDST_SRC_KEY_CLS: string;
    function GetDST_BLA_CLS: string;
    function GetSRC_BLA_CLS: string;
  protected
    FBaseLoaded: boolean;
    Exp_Set: string;
    WalkCol: TIB_Column;
    WalkIndex: integer;
    WalkSL: TIB_StringList;
    WalkBlobArray: boolean;
    function WalkInfoMacroProc( const ATextBlock: string ): string;
    function WalkFields( ACursors: array of TIB_Cursor;
                         const Cols,
                               BodyText,
                               TermText: string;
                               TermType: integer ): string;
    function GetSharedFields( IsKeys: boolean ): string;
  protected
    _IND_NME: string;
    _SRC_TBL_NME: string;
    _SRC_KEY_CLS: string;
    _SRC_ADD_EXP: string;
    _SRC_UPD_EXP: string;
    _SRC_TRG_DEC_VAR: STRING;
    _SRC_TRG_INS_Q: STRING;
    _SRC_TRG_UPD_Q: STRING;
    _SRC_TRG_DEL_Q: STRING;
    _SRC_PRC_DEC_VAR: string;
    _SRC_PRC_VAR_INIT: string;
    _SRC_PRC_SRC_Q: string;
    _SRC_PRC_SRC_FULL: string;
    _DST_TBL_NME: string;
    _DST_TBL_CREATE: string;
    _DST_KEY_CLS: string;
    _DST_SRC_CLS: string;
    _DST_SRC_CLS_MAP: string;
    _DST_SRC_KEY_CLS: string;
    _DST_TBL_SRC: string;
    _DST_CLS: string;
    _SRC_CLS: string;
    _DST_DEL_EXP: string;
    _DST_BLA_CLS: string;
    _SRC_BLA_CLS: string;
    _STATUS: string;
    _LOG: boolean;
    procedure ClearVariables;
    procedure DoStatusChange; override;
    function SysNeedToExecute: boolean; override;
    procedure SysExecute( var IsDone: boolean ); override;
    procedure SysMacroSubstitute(       Sender: TIB_Component;
                                  const ATextBlock: string;
                                    var ATextResult: string ); 
  { Property Methods }
    function GetIsMetaLoaded: boolean;
    function GetIsActivated: boolean;
    function GetIsCorrupted: boolean;
    function GetIsPending: boolean;
    procedure SetReplicatorIndexName( AValue: string ); virtual;
  { System Methods }
    procedure SysPrepare; override;
    procedure SysUnprepare; override;
    procedure ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                    AEvent: TIB_ConnectionEventType ); override;
  { Properties }
    property IND_NME:string read _IND_NME;
    property SRC_TBL_NME: string read _SRC_TBL_NME;
    property SRC_KEY_CLS: string read _SRC_KEY_CLS;
    property SRC_ADD_EXP: string read _SRC_ADD_EXP;
    property SRC_UPD_EXP: string read _SRC_UPD_EXP;
    property SRC_TRG_DEC_VAR: STRING read _SRC_TRG_DEC_VAR;
    property SRC_TRG_INS_Q: STRING read _SRC_TRG_INS_Q;
    property SRC_TRG_UPD_Q: STRING read _SRC_TRG_UPD_Q;
    property SRC_TRG_DEL_Q: STRING read _SRC_TRG_DEL_Q;
    property SRC_PRC_DEC_VAR: string read _SRC_PRC_DEC_VAR;
    property SRC_PRC_VAR_INIT: string read _SRC_PRC_VAR_INIT;
    property SRC_PRC_SRC_Q: string read _SRC_PRC_SRC_Q;
    property SRC_PRC_SRC_FULL: string read _SRC_PRC_SRC_FULL;
    property DST_TBL_NME: string read _DST_TBL_NME;
    property DST_TBL_CREATE: string read _DST_TBL_CREATE;
    property DST_KEY_CLS: string read GetDST_KEY_CLS;
    property DST_SRC_CLS: string read GetDST_SRC_CLS;
    property DST_SRC_CLS_MAP: string read GetDST_SRC_CLS_MAP;
    property DST_SRC_KEY_CLS: string read GetDST_SRC_KEY_CLS;
    property DST_TBL_SRC: string read GetDST_TBL_SRC;
    property DST_CLS: string read GetDST_CLS;
    property SRC_CLS: string read GetSRC_CLS;
    property DST_DEL_EXP: string read _DST_DEL_EXP;
    property DST_BLA_CLS: string read GetDST_BLA_CLS;
    property SRC_BLA_CLS: string read GetSRC_BLA_CLS;
    property STATUS: string read _STATUS;
    property LOG: boolean read _LOG;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
  { Methods }
    procedure CheckLoaded;
    procedure MacroSubstitute( const ATextBlock: string;
                                 var ATextResult: string ); virtual;
    procedure ResetVariables;
    procedure ExportIndexDefinitions( AStrings: TStrings );
  { Properties }
    property BaseLoaded: boolean read FBaseLoaded;
    property IsMetaLoaded: boolean read GetIsMetaLoaded;
    property IsActivated: boolean read GetIsActivated;
    property IsCorrupted: boolean read GetIsCorrupted;
    property IsPending: boolean read GetIsPending;
  published
    property Passive;
    property BeforePrepare;
    property AfterPrepare;
    property AfterUnprepare;
    property BeforeExecute;
    property AfterExecute;
    property OnStatusChange;
    property IB_ConnectionSrc: TIB_Connection read GetSrcConnection
                                              write SetSrcConnection;
    property ReplicatorIndexName: string read FReplicatorIndexName
                                         write SetReplicatorIndexName;
  end;

implementation

uses
  IB_Parse;

constructor TIB_RPL_Base.Create( AOwner: TComponent );
begin
  FSrcCL := TIB_ConnectionLink.Create( Self );
  inherited Create( AOwner );
  FSrcCL.OnProcessEvent := ProcessConnectionEvent;
  trSRC := TIB_Transaction.Create( Self );
  trSRC.Name := 'trSRC';
  trSRC.AutoCommit := true;
  trSRC.Isolation := tiCommitted;
  trDST := TIB_Transaction.Create( Self );
  trDST.Name := 'trDST';
  trDST.AutoCommit := true;
  trDST.Isolation := tiCommitted;
  crSRC := TIB_Cursor.Create( Self );
  crSRC.IB_Transaction := trSRC;
  crSRC.SQL.Text := 'SELECT * FROM <<SRC_TBL_NME>>';
  crSRC.Name := 'crSRC';
  crSRC.OnMacroSubstitute := SysMacroSubstitute;
  crDST := TIB_Cursor.Create( Self );
  crDST.IB_Transaction := trDST;
  crDST.SQL.Text := 'SELECT * FROM <<DST_TBL_NME>>';
  crDST.Name := 'crDST';
  crDST.OnMacroSubstitute := SysMacroSubstitute;
  WalkSL := TIB_StringList.Create;
  WalkBlobArray := true;
end;

destructor TIB_RPL_Base.Destroy;
begin
  FSrcCL.OnProcessEvent := nil;
  WalkSL.Free;
  WalkSL := nil;
  inherited Destroy;
end;

function TIB_RPL_Base.GetSrcConnection: TIB_Connection;
begin
  Result := FSrcCL.IB_Connection;
end;

procedure TIB_RPL_Base.SetSrcConnection( AValue: TIB_Connection );
begin
  FSrcCL.IB_Connection := AValue;
end;

procedure TIB_RPL_Base.ProcessConnectionEvent(
  AConnectionLink: TIB_ConnectionLink;
  AEvent: TIB_ConnectionEventType );
begin
  inherited ProcessConnectionEvent( AConnectionLink, AEvent );
  if not AConnectionLink.Connected then
    FBaseLoaded := false
  else
    case AEvent of
      cetBeforeAssignment,
      cetBeforeConnect,
      cetBeforeDisconnect: Unprepare;
      cetAfterAssignment,
      cetAfterConnect,
      cetAfterDisconnect: with IB_Connection.SchemaCache.TableNames do
        FBaseLoaded := IndexOf( 'RPL$_IND' ) >= 0;
    end;
  if AEvent = cetAfterAssignment then
  begin
    trSRC.IB_Connection := IB_ConnectionSrc;
    trDST.IB_Connection := IB_Connection;
    crSRC.IB_Connection := IB_ConnectionSrc;
    crDST.IB_Connection := IB_Connection;
  end;
end;

procedure TIB_RPL_Base.SetReplicatorIndexName( AValue: string );
var
  WasPrepared: boolean;
begin
  if FReplicatorIndexName <> Trim( AValue ) then
  begin
    WasPrepared := Prepared;
    Unprepare;
    FReplicatorIndexName := Trim( AValue );
    if WasPrepared then Prepare;
  end;
end;

procedure TIB_RPL_Base.SysPrepare;
begin
  ResetVariables;
  inherited SysPrepare;
end;

procedure TIB_RPL_Base.SysUnprepare;
begin
  inherited SysUnprepare;
  ClearVariables;
end;

function TIB_RPL_Base.WalkInfoMacroProc( const ATextBlock: string ): string;
begin
  if CompareText( ATextBlock, 'FLD_NME' ) = 0 then
    Result := WalkSL[ WalkIndex ]
  else
  if CompareText( ATextBlock, 'OLD_FLD_NME' ) = 0 then
  begin
    if Assigned( WalkCol ) then
      Result := WalkCol.Row.Statement.IB_Connection.mkIdent(
        'OLD_' + StLitCriteria( WalkCol.FieldName ))
    else
      Result := 'OLD_' + WalkSL[ WalkIndex ]
  end
  else
  if CompareText( ATextBlock, 'TMP_FLD_NME' ) = 0 then
  begin
    if Assigned( WalkCol ) then
      Result := WalkCol.Row.Statement.IB_Connection.mkIdent(
        'tmp' + StLitCriteria( WalkCol.FieldName ))
    else
      Result := 'tmp' + WalkSL[ WalkIndex ]
  end
  else
  if CompareText( ATextBlock, 'RPL_FLD_NME' ) = 0 then
  begin
    if Assigned( WalkCol ) then
      Result := WalkCol.Row.Statement.IB_Connection.mkIdent(
        'RPL$' + StLitCriteria( WalkCol.FieldName ))
    else
      Result := 'RPL$' + WalkSL[ WalkIndex ]
  end
  else
  if Assigned( WalkCol ) then
  begin
    if CompareText( ATextBlock, 'DOM_NME' ) = 0 then
    begin
      if WalkCol.DomainName = '' then
        Result := WalkCol.SQLTypeSource
      else
        Result := WalkCol.DomainName;
    end
    else
    if CompareText( ATextBlock, 'TYP_NME' ) = 0 then
      Result := WalkCol.SQLTypeSource
    else
    if CompareText( ATextBlock, 'EXP' ) = 0 then
      Result := Exp_Set
    else
    if CompareText( ATextBlock, 'FLD_CHANGED' ) = 0 then
    begin
      Result :=
        '((( NEW.<<FLD_NME>> IS NOT NULL ) AND ( OLD.<<FLD_NME>> IS NULL )) OR ' +
         '(( NEW.<<FLD_NME>> IS NULL ) AND ( OLD.<<FLD_NME>> IS NOT NULL )) OR ';
      if WalkCol.IsBlob then
      Result := Result +
          '( F_BLOBBINCMP( NEW.<<FLD_NME>>, OLD.<<FLD_NME>> ) <> 0 ))'
      else
      Result := Result +
          '( NEW.<<FLD_NME>> <> OLD.<<FLD_NME>> ))';
    end
    else
      MacroSubstitute( ATextBlock, Result );
  end
  else
    MacroSubstitute( ATextBlock, Result );
end;

function TIB_RPL_Base.WalkFields(        ACursors: array of TIB_Cursor;
                                   const Cols,
                                         BodyText,
                                         TermText: string;
                                         TermType: integer ): string;
var
  ii, jj: integer;
  tmpStr: string;
//  WasPrepared: boolean;
begin
//  WasPrepared := ACursor.Prepared;
//  try
    for ii := low( ACursors ) to high( ACursors ) do
      ACursors[ ii ].Prepare;
    WalkIndex := 0;
    ExtractFieldsIntoList( Cols, WalkSL );
    Result := '';
    jj := 0;
    while WalkIndex < WalkSL.Count do
    begin
      for ii := low( ACursors ) to high( ACursors ) do
      begin
        WalkCol := ACursors[ ii ].FindField( WalkSL[ WalkIndex ] );
        if Assigned( WalkCol ) then Break;
      end;
      if WalkBlobArray or
         not Assigned( WalkCol ) or ( not WalkCol.IsBlob and
                                      not WalkCol.IsArray ) then
      begin
        tmpStr := BodyText;
        if ( TermType < 0 ) and ( jj = 0 ) then
          tmpStr := TermText + tmpStr;
        tmpStr := tmpStr + TermText;
        Result := Result + SubstMacros( tmpStr,
                                        WalkInfoMacroProc,
                                        '<<',
                                        '>>' );
        Inc( jj );
      end;
      Inc( WalkIndex );
    end;
    if ( TermType <> 0 ) and ( jj > 0 ) then
      SetLength( Result, Length( Result ) - Length( TermText ));
    WalkSL.Clear;
//  finally
//    if not WasPrepared then
//    begin
//      ACursor.Unprepare;
//      ACursor.IB_Transaction.Close;
//    end;
//  end;
  for ii := low( ACursors ) to high( ACursors ) do
    if ACursors[ii].IB_Transaction.Started then
      ACursors[ii].IB_Transaction.Close;
end;

function TIB_RPL_Base.GetDST_TBL_SRC: string;
var
  ii, jj: integer;
begin
  if Prepared and BaseLoaded and ( _DST_TBL_SRC = '' ) then
    with TIB_Cursor.Create( Self ) do
      try
        if DST_TBL_CREATE = 'T' then
        begin
          IB_Connection := Self.IB_ConnectionSrc;
          IB_Transaction := Self.trSRC;
          SQL.Text := 'SELECT * FROM ' + SRC_TBL_NME;
          Prepare;
          jj := 0;
          for ii := 0 to FieldCount - 1 do
            with Fields[ ii ] do
              if ( FieldName <> 'RPL$KEY_ID' ) and
                 ( FieldName <> 'RPL$SYNC_ID' ) and
                 not Computed then
              begin
                _DST_TBL_SRC := _DST_TBL_SRC + '  ' + FieldSource[ true ] +
                                               ','#13#10;
                Inc( jj );
              end;
        end
        else
        begin
          IB_Connection := Self.IB_Connection;
          IB_Transaction := Self.trDST;
          SQL.Text := 'SELECT * FROM ' + DST_TBL_NME;
          Prepare;
          jj := 0;
          for ii := 0 to FieldCount - 1 do
            with Fields[ ii ] do
              if ( FieldName <> 'RPL$KEY_ID' ) and
                 ( FieldName <> 'RPL$SYNC_ID' ) and
                 not Computed then
              begin
                _DST_TBL_SRC := _DST_TBL_SRC + '  ' + FieldSource[ true ] +
                                               ','#13#10;
                Inc( jj );
              end;
        end;
        if jj > 0 then
          System.Delete( _DST_TBL_SRC, Length( _DST_TBL_SRC ) - 2, 3 );
    finally
      Free;
    end;
  Result := _DST_TBL_SRC;
end;

function TIB_RPL_Base.GetDST_CLS: string;
var
  ii, jj: integer;
begin
  if Prepared and BaseLoaded and ( _DST_CLS = '' ) then
    with TIB_Cursor.Create( Self ) do
      try
        IB_Connection := Self.IB_Connection;
        IB_Transaction := Self.trDST;
        SQL.Text := 'SELECT * FROM ' + DST_TBL_NME;
        Prepare;
        jj := 0;
        for ii := 0 to FieldCount - 1 do
          with Fields[ ii ] do
            if ( FieldName <> 'RPL$KEY_ID' ) and
               ( FieldName <> 'RPL$SYNC_ID' ) and
               not Computed then
            begin
              _DST_CLS := _DST_CLS + FieldName + ', ';
              Inc( jj );
            end;
        if jj > 0 then
          System.Delete( _DST_CLS, Length( _DST_CLS ) - 1, 2 );
      finally
        Free;
      end;
  Result := _DST_CLS;
end;

function TIB_RPL_Base.GetSRC_CLS: string;
var
  ii, jj: integer;
begin
  if Prepared and BaseLoaded and ( _SRC_CLS = '' ) then
    with TIB_Cursor.Create( Self ) do
      try
        IB_Connection := Self.IB_ConnectionSrc;
        IB_Transaction := Self.trSRC;
        SQL.Text := 'SELECT * FROM ' + SRC_TBL_NME;
        Prepare;
        jj := 0;
        for ii := 0 to FieldCount - 1 do
          with Fields[ ii ] do
            if ( FieldName <> 'RPL$KEY_ID' ) and
               ( FieldName <> 'RPL$SYNC_ID' ) and
               not Computed then
            begin
              _SRC_CLS := _SRC_CLS + FieldName + ', ';
              Inc( jj );
            end;
        if jj > 0 then
          System.Delete( _SRC_CLS, Length( _SRC_CLS ) - 1, 2 );
      finally
        Free;
      end;
  Result := _SRC_CLS;
end;

function TIB_RPL_Base.GetDST_BLA_CLS: string;
var
  ii, jj: integer;
begin
  if Prepared and BaseLoaded and ( _DST_BLA_CLS = '' ) then
  begin
    with TIB_Cursor.Create( Self ) do
      try
        IB_Connection := Self.IB_Connection;
        IB_Transaction := Self.trDST;
        SQL.Text := 'SELECT * FROM ' + DST_TBL_NME;
        Prepare;
        jj := 0;
        for ii := 0 to FieldCount - 1 do
          with Fields[ ii ] do
            if ( FieldName <> 'RPL$KEY_ID' ) and
               ( FieldName <> 'RPL$SYNC_ID' ) and
               not Computed and
               ( IsBlob or IsArray ) then
            begin
              _DST_BLA_CLS := _DST_BLA_CLS + FieldName + ', ';
              Inc( jj );
            end;
        if jj > 0 then
          System.Delete( _DST_BLA_CLS, Length( _DST_BLA_CLS ) - 1, 2 );
      finally
        Free;
      end;
    if _DST_BLA_CLS = '' then
      _DST_BLA_CLS := '*';
  end;
  if _DST_BLA_CLS = '*' then
    Result := ''
  else
    Result := _DST_BLA_CLS;
end;

function TIB_RPL_Base.GetSRC_BLA_CLS: string;
var
  ii, jj: integer;
begin
  if Prepared and BaseLoaded and ( _SRC_BLA_CLS = '' ) then
  begin
    with TIB_Cursor.Create( Self ) do
      try
        IB_Connection := Self.IB_ConnectionSrc;
        IB_Transaction := Self.trSRC;
        SQL.Text := 'SELECT * FROM ' + SRC_TBL_NME;
        Prepare;
        jj := 0;
        for ii := 0 to FieldCount - 1 do
          with Fields[ ii ] do
            if ( FieldName <> 'RPL$KEY_ID' ) and
               ( FieldName <> 'RPL$SYNC_ID' ) and
               not Computed and
               ( IsBlob or IsArray ) then
            begin
              _SRC_BLA_CLS := _SRC_BLA_CLS + FieldName + ', ';
              Inc( jj );
            end;
        if jj > 0 then
          System.Delete( _SRC_BLA_CLS, Length( _SRC_BLA_CLS ) - 1, 2 );
      finally
        Free;
      end;
    if _SRC_BLA_CLS = '' then
      _SRC_BLA_CLS := '*';
  end;
  if _SRC_BLA_CLS = '*' then
    Result := ''
  else
    Result := _SRC_BLA_CLS;
end;

function TIB_RPL_Base.GetDST_KEY_CLS: string;
begin
  if Prepared and BaseLoaded and ( _DST_KEY_CLS = '' ) then
    _DST_KEY_CLS := SRC_KEY_CLS;
  Result := _DST_KEY_CLS;
end;

function TIB_RPL_Base.GetDST_SRC_CLS: string;
begin
  if Prepared and BaseLoaded and ( _DST_SRC_CLS = '' ) then
  begin
    _DST_SRC_CLS := GetSharedFields( false );
    if _DST_SRC_CLS = '' then
      _DST_SRC_CLS := '*';
  end;
  if _DST_SRC_CLS = '*' then
    Result := ''
  else
    Result := _DST_SRC_CLS;
end;

function TIB_RPL_Base.GetDST_SRC_CLS_MAP: string;
begin
  if Prepared and BaseLoaded and ( _DST_SRC_CLS_MAP = '' ) then
  begin
    if _DST_SRC_CLS_MAP = '' then
      _DST_SRC_CLS_MAP := '*';
  end;
  if _DST_SRC_CLS_MAP = '*' then
    Result := ''
  else
    Result := _DST_SRC_CLS_MAP;
end;

function TIB_RPL_Base.GetDST_SRC_KEY_CLS: string;
begin
  if Prepared and BaseLoaded and ( _DST_SRC_KEY_CLS = '' ) then
  begin
    _DST_SRC_KEY_CLS := GetSharedFields( true );
    if _DST_SRC_KEY_CLS = '' then
      _DST_SRC_KEY_CLS := '*';
  end;
  if _DST_SRC_KEY_CLS = '*' then
    Result := ''
  else
    Result := _DST_SRC_KEY_CLS;
end;

function TIB_RPL_Base.GetSharedFields( IsKeys: boolean ): string;
var
  ii, jj: integer;
  tmpDST, tmpSRC: TIB_Cursor;
begin
  Result := '';
  tmpDST := TIB_Cursor.Create( Self );
  tmpSRC := TIB_Cursor.Create( Self );
  try
    tmpDST.IB_Connection := IB_Connection;
    tmpSRC.IB_Connection := IB_ConnectionSrc;
    tmpDST.IB_Transaction := Self.trDST;
    tmpSRC.IB_Transaction := Self.trSRC;
    tmpDST.OnMacroSubstitute := SysMacroSubstitute;
    tmpSRC.OnMacroSubstitute := SysMacroSubstitute;
    if IsKeys then
    begin
      tmpDST.SQL.Text := 'SELECT <<DST_KEY_CLS>> FROM <<DST_TBL_NME>>';
      tmpSRC.SQL.Text := 'SELECT <<SRC_KEY_CLS>> FROM <<SRC_TBL_NME>>';
    end
    else
    begin
      tmpDST.SQL.Text := 'SELECT <<DST_CLS>> FROM <<DST_TBL_NME>>';
      tmpSRC.SQL.Text := 'SELECT <<SRC_CLS>> FROM <<SRC_TBL_NME>>';
    end;
    tmpDST.Prepare;
    tmpSRC.Prepare;
    jj := 0;
    for ii := 0 to tmpDST.FieldCount - 1 do
      if Assigned( tmpSRC.FindField( tmpDST.Fields[ ii ].FieldName )) then
      begin
        Result := Result + tmpDST.Fields[ ii ].FieldName + ', ';
        Inc( jj );
      end;
      if jj > 0 then
        System.Delete( Result, Length( Result ) - 1, 2 );
  finally
    tmpDST.Free;
    tmpSRC.Free;
  end;
end;

procedure TIB_RPL_Base.ClearVariables;
begin
  crSRC.Unprepare;
  crDST.Unprepare;
  _IND_NME := '';
  _SRC_TBL_NME := '';
  _SRC_KEY_CLS := '';
  _SRC_ADD_EXP := '';
  _SRC_UPD_EXP := '';
  _SRC_TRG_DEC_VAR := '';
  _SRC_TRG_INS_Q := '';
  _SRC_TRG_UPD_Q := '';
  _SRC_TRG_DEL_Q := '';
  _SRC_PRC_DEC_VAR := '';
  _SRC_PRC_VAR_INIT := '';
  _SRC_PRC_SRC_Q := '';
  _SRC_PRC_SRC_FULL := '';
  _DST_TBL_NME := '';
  _DST_TBL_CREATE := '';
  _DST_KEY_CLS := '';
  _DST_SRC_CLS := '';
  _DST_SRC_CLS_MAP := '';
  _DST_SRC_KEY_CLS := '';
  _DST_TBL_SRC := '';
  _DST_CLS := '';
  _SRC_CLS := '';
  _DST_BLA_CLS := '';
  _SRC_BLA_CLS := '';
  _DST_DEL_EXP := '';
  _STATUS := '';
  _LOG := false;
end;

procedure TIB_RPL_Base.CheckLoaded;
begin
  if not Prepared then
    raise Exception.Create( 'RPL Index ' + ReplicatorIndexName +
                            ' is not prepared' );
  if not BaseLoaded then
    raise Exception.Create( 'RPL Index ' + ReplicatorIndexName +
                            ' base table is not loaded' );
  if not IsMetaLoaded then
    raise Exception.Create( 'RPL Index ' + ReplicatorIndexName +
                            ' metadata is not loaded' );
end;

procedure TIB_RPL_Base.ResetVariables;
begin
  crSRC.BeginBusy( false );
  try
  crSRC.Unprepare;
  crDST.Unprepare;
  if Assigned( IB_Connection ) then
    IB_Connection.Connect
  else
    raise Exception.Create( 'No connection assigned' );
  if not IB_Connection.Connected then
    raise Exception.Create( 'No connection made' );
  ClearVariables;
  if BaseLoaded and ( ReplicatorIndexName <> '' ) then
    with TIB_Cursor.Create( Self ) do
      try
        IB_Connection := Self.IB_Connection;
        IB_Transaction := Self.trDST;
        SQL.Text := 'SELECT * ' +
                    'FROM RPL$_IND ' +
                    'WHERE RPL$IND_NME = ' +
                    mkLitCriteria( ReplicatorIndexName, '''' );
        Prepare;
        if not Assigned( FindField( 'RPL$SRC_CLS' )) then
        begin
          Unprepare;
          try
            ExecuteImmediate( 'CREATE DOMAIN RPL$STRINGLIST_DM ' +
                              'AS BLOB SUB_TYPE TEXT SEGMENT SIZE 256', nil );
            ExecuteImmediate( 'ALTER TABLE RPL$_IND ' +
                              'ADD RPL$SRC_CLS RPL$IDENT_LIST_DM,' +
                              'ADD RPL$DST_CLS RPL$IDENT_LIST_DM,' +
                              'ADD RPL$DST_SRC_CLS_MAP RPL$STRINGLIST_DM,' +
                              'ADD RPL$SRC_TRG_DEC_VAR RPL$SOURCE_DM,' +
                              'ADD RPL$SRC_TRG_INS_Q RPL$SOURCE_DM,' +
                              'ADD RPL$SRC_TRG_UPD_Q RPL$SOURCE_DM,' +
                              'ADD RPL$SRC_TRG_DEL_Q RPL$SOURCE_DM', nil );
            trDST.Commit;
          except
            // Ignore an error here.
          end;
          Prepare;
        end;
        First;
        if not Eof then
        begin
          _IND_NME     := FieldByName( 'RPL$IND_NME'     ).AsString;
          _SRC_TBL_NME := FieldByName( 'RPL$SRC_TBL_NME' ).AsString;
          _SRC_KEY_CLS := FieldByName( 'RPL$SRC_KEY_CLS' ).AsString;
          _SRC_ADD_EXP := FieldByName( 'RPL$SRC_ADD_EXP' ).AsString;
          _SRC_UPD_EXP := FieldByName( 'RPL$SRC_UPD_EXP' ).AsString;
          _SRC_PRC_DEC_VAR := FieldByName( 'RPL$SRC_PRC_DEC_VAR' ).AsString;
          _SRC_PRC_VAR_INIT := FieldByName( 'RPL$SRC_PRC_VAR_INIT' ).AsString;
          _SRC_PRC_SRC_Q := FieldByName( 'RPL$SRC_PRC_SRC_Q' ).AsString;
          _SRC_PRC_SRC_FULL := FieldByName( 'RPL$SRC_PRC_SRC_FULL' ).AsString;
          _DST_TBL_NME := FieldByName( 'RPL$DST_TBL_NME' ).AsString;
          _DST_TBL_CREATE := FieldByName( 'RPL$DST_TBL_CREATE' ).AsString;
          _DST_KEY_CLS := FieldByName( 'RPL$DST_KEY_CLS' ).AsString;
          _DST_TBL_SRC := FieldByName( 'RPL$DST_TBL_SRC' ).AsString;
          _DST_DEL_EXP := FieldByName( 'RPL$DST_DEL_EXP' ).AsString;
          if Assigned( FindField( 'RPL$SRC_CLS' ) ) then
          begin
            _SRC_CLS := FieldByName( 'RPL$SRC_CLS' ).AsString;
            _DST_CLS := FieldByName( 'RPL$DST_CLS' ).AsString;
            _DST_SRC_CLS_MAP := FieldByName( 'RPL$DST_SRC_CLS_MAP' ).AsString;
            _SRC_TRG_DEC_VAR := FieldByName( 'RPL$SRC_TRG_DEC_VAR' ).AsString;
            _SRC_TRG_INS_Q := FieldByName( 'RPL$SRC_TRG_INS_Q' ).AsString;
            _SRC_TRG_UPD_Q := FieldByName( 'RPL$SRC_TRG_UPD_Q' ).AsString;
            _SRC_TRG_DEL_Q := FieldByName( 'RPL$SRC_TRG_DEL_Q' ).AsString;
          end;
          _STATUS := FieldByName( 'RPL$STATUS' ).AsString;
          _LOG := FieldByName( 'RPL$LOG' ).AsBoolean;
          _DST_BLA_CLS := '';
          _SRC_BLA_CLS := '';
          _DST_SRC_KEY_CLS := '';
        end
        else
          ClearVariables;
      finally
        Free;
      end;
  finally
    crSRC.EndBusy;
  end;
end;

procedure TIB_RPL_Base.ExportIndexDefinitions( AStrings: TStrings );
  procedure AddItem( ItemName, ItemValue: string );
  begin
    AStrings.Add( '<' + ItemName + '>' );
    AStrings.Add( ItemValue );
    AStrings.Add( '</' + ItemName + '>' );
  end;
begin
  AStrings.Clear;
  if Prepared then
  begin
    ResetVariables;
    AStrings.Add( '' );
    AStrings.Add( '<! Simple Replication Index Definition Export >' );
    AStrings.Add( '' );
    AddItem( 'IND_NME', IND_NME );

    AddItem( 'SRC_TBL_NME', SRC_TBL_NME );
    AddItem( 'SRC_KEY_CLS', SRC_KEY_CLS );
    AddItem( 'SRC_CLS', SRC_CLS );

    AddItem( 'DST_TBL_NME', DST_TBL_NME );
    AddItem( 'DST_KEY_CLS', DST_KEY_CLS );
    AddItem( 'DST_CLS', DST_CLS );
    AddItem( 'DST_SRC_CLS_MAP', DST_SRC_CLS_MAP );

    AddItem( 'DST_TBL_SRC', DST_TBL_SRC );
    AddItem( 'DST_TBL_CREATE', DST_TBL_CREATE );

    AddItem( 'SRC_ADD_EXP', SRC_ADD_EXP );
    AddItem( 'SRC_UPD_EXP', SRC_UPD_EXP );
    AddItem( 'DST_DEL_EXP', DST_DEL_EXP );
    
    AddItem( 'SRC_TRG_DEC_VAR', SRC_TRG_DEC_VAR );
    AddItem( 'SRC_TRG_INS_Q', SRC_TRG_INS_Q );
    AddItem( 'SRC_TRG_UPD_Q', SRC_TRG_UPD_Q );
    AddItem( 'SRC_TRG_DEL_Q', SRC_TRG_DEL_Q );

    AddItem( 'SRC_PRC_DEC_VAR', SRC_PRC_DEC_VAR );
    AddItem( 'SRC_PRC_VAR_INIT', SRC_PRC_VAR_INIT );
    AddItem( 'SRC_PRC_SRC_Q', SRC_PRC_SRC_Q );
    AddItem( 'SRC_PRC_SRC_FULL', SRC_PRC_SRC_FULL );

    AddItem( 'STATUS', STATUS           );
    if LOG then
    AddItem( 'LOG', 'T' ) else
    AddItem( 'LOG', 'F' )
    
  end;
end;

procedure TIB_RPL_Base.DoStatusChange;
begin
  inherited DoStatusChange;
  if IsCorrupted or IsPending or not IsMetaLoaded or not Prepared then
  begin
    if crDST.Prepared then
      crDST.Unprepare;
    if crSRC.Prepared then
      crSRC.Unprepare;
    if Assigned( IB_Connection ) then
      IB_Connection.SchemaCache.FreeResources;
    if Assigned( IB_ConnectionSrc ) then
      IB_ConnectionSrc.SchemaCache.FreeResources;
  end;
end;

function TIB_RPL_Base.SysNeedToExecute: boolean;
begin
  Result := inherited SysNeedToExecute;
  if not Result then
    Result := trSRC.Started or trDST.Started;
end;

procedure TIB_RPL_Base.SysExecute( var IsDone: boolean );
begin
  inherited SysExecute( IsDone );
  if IsDone then
  begin
    if trSRC.Started then trSRC.Commit;
    if trDST.Started then trDST.Commit;
  end;
end;

function TIB_RPL_Base.GetIsMetaLoaded: boolean;
begin
  Result := ( Status = 'IC' ) or
            ( Status = 'M'  ) or
            ( Status = 'MC' ) or IsActivated;
end;

function TIB_RPL_Base.GetIsActivated: boolean;
begin
  Result := Pos( 'A', Status ) = 1;
end;

function TIB_RPL_Base.GetIsCorrupted: boolean;
begin
  Result := Pos( 'C', Status ) > 1;
end;

function TIB_RPL_Base.GetIsPending: boolean;
begin
  Result := Pos( 'P', Status ) > 1;
end;

procedure TIB_RPL_Base.SysMacroSubstitute(       Sender: TIB_Component;
                                           const ATextBlock: string;
                                             var ATextResult: string );
begin
  MacroSubstitute( ATextBlock, ATextResult );
end;

procedure TIB_RPL_Base.MacroSubstitute( const ATextBlock: string;
                                          var ATextResult: string );
  function Get_BLA_CLSUsed(BLA_CLS, CLS : string) : string;
  var
    Lst_BLA_CLS, Lst_CLS : TStringList;
    ii : Integer;
  begin
    Result := '';
    Lst_BLA_CLS := nil;
    Lst_CLS := nil;
    try
      Lst_BLA_CLS := TStringList.Create;
      Lst_CLS := TStringList.Create;
      ExtractFieldsIntoList(BLA_CLS, Lst_BLA_CLS);
      ExtractFieldsIntoList(CLS, Lst_CLS);
      for ii := 0 to Lst_BLA_CLS.Count - 1 do
        if Lst_CLS.IndexOf(Lst_BLA_CLS[ii]) >= 0 then
        begin
          if Result <> '' then
            Result := Result+',';
          Result := Result+Lst_BLA_CLS[ii];
        end;
    finally
      Lst_BLA_CLS.Free;
      Lst_CLS.Free;
    end;
  end;

  function Get_BLA_CLSNotUsed(BLA_CLS, CLS : string) : string;
  var
    Lst_BLA_CLS, Lst_CLS : TStringList;
    ii : Integer;
  begin
    Result := '';
    Lst_BLA_CLS := nil;
    Lst_CLS := nil;
    try
      Lst_BLA_CLS := TStringList.Create;
      Lst_CLS := TStringList.Create;
      ExtractFieldsIntoList(BLA_CLS, Lst_BLA_CLS);
      ExtractFieldsIntoList(CLS, Lst_CLS);
      for ii := 0 to Lst_BLA_CLS.Count - 1 do
        if Lst_CLS.IndexOf(Lst_BLA_CLS[ii]) < 0 then
        begin
          if Result <> '' then
            Result := Result+',';
          Result := Result+Lst_BLA_CLS[ii];
        end;
    finally
      Lst_BLA_CLS.Free;
      Lst_CLS.Free;
    end;
  end;

var
  tmpStr : string;
begin
  if CompareText( ATextBlock, 'SET_EXP_NEW' ) = 0 then
  begin
    Exp_Set := 'NEW.';
    ATextResult := '';
  end
  else
  if CompareText( ATextBlock, 'SET_EXP_OLD' ) = 0 then
  begin
    Exp_Set := 'OLD.';
    ATextResult := '';
  end
  else
  if CompareText( ATextBlock, 'SET_EXP_N' ) = 0 then
  begin
    Exp_Set := 'n.';
    ATextResult := '';
  end
  else
  if CompareText( ATextBlock, 'SET_EXP_OFF' ) = 0 then
  begin
    Exp_Set := '';
    ATextResult := '';
  end
  else
  if CompareText( ATextBlock, 'EXP' ) = 0 then
    ATextResult := Exp_Set
  else
  if CompareText( ATextBlock, 'IND_NME' ) = 0 then
    ATextResult := IND_NME
  else
  if CompareText( ATextBlock, 'SRC_TBL_NME' ) = 0 then
    ATextResult := SRC_TBL_NME
  else
  if CompareText( ATextBlock, 'SRC_KEY_CLS' ) = 0 then
    ATextResult := SRC_KEY_CLS
  else
  if CompareText( ATextBlock, 'SRC_ADD_EXP' ) = 0 then
  begin
    ATextResult := SRC_ADD_EXP;
    if Trim( ATextResult ) = '' then
      ATextResult := '1=1';
  end
  else
  if CompareText( ATextBlock, 'SRC_UPD_EXP' ) = 0 then
  begin
    ATextResult := SRC_UPD_EXP;
    if Trim( ATextResult ) = '' then
      ATextResult := '1=1';
  end
  else
  if CompareText( ATextBlock, 'DST_DEL_EXP' ) = 0 then
  begin
    ATextResult := DST_DEL_EXP;
    if Trim( ATextResult ) = '' then
      ATextResult := '1=1';
  end
  else
  if CompareText( ATextBlock, 'SRC_PRC_SRC_Q' ) = 0 then  {!!!}
  begin
    ATextResult := SRC_PRC_SRC_Q;
    if Trim( ATextResult ) = '' then
      ATextResult := #13#10 +
                     '    SELECT <<DST_CLS_N>>'#13#10 +
                     '    FROM <<SRC_TBL_NME>> n'#13#10 +
                     '    WHERE <<TMP_SRC_KEY_WHERE>>'#13#10 +
                     '    INTO <<DST_CLS_VARS>>;'#13#10 +
                     '    IF (( RPL$Q_TYP <> ''D'' ) AND ( ' +
                                      '<<SRC_KEY_IS_NULL>>' + ' )) THEN'#13#10 +
                     '      RPL$SEND_Q_ITEM = ''F'';'#13#10;

  end
  else
  if CompareText( ATextBlock, 'SRC_PRC_SRC_FULL' ) = 0 then  {!!!}
  begin
    ATextResult := SRC_PRC_SRC_FULL;
    if Trim( ATextResult ) = '' then
      ATextResult := #13#10 +
                     '  FOR SELECT <<DST_CLS_N>>'#13#10 +
                     '      FROM <<SRC_TBL_NME>> n'#13#10 +
                     '      WHERE <<SET_EXP_N>>(<<SRC_ADD_EXP>>)'#13#10 +
                     '      ORDER BY <<SRC_KEY_CLS_N>>'#13#10 +
                     '      INTO <<DST_CLS_VARS>> DO'#13#10 +
                     '  BEGIN'#13#10 +
                     '    SUSPEND;'#13#10 +
                     '  END'#13#10;
  end
  else
  if CompareText( ATextBlock, 'SRC_PRC_DEC_VAR' ) = 0 then
    ATextResult := SRC_PRC_DEC_VAR  else
  if CompareText( ATextBlock, 'SRC_PRC_VAR_INIT' ) = 0 then
    ATextResult := SRC_PRC_VAR_INIT else
  if CompareText( ATextBlock, 'DST_TBL_NME' ) = 0 then
    ATextResult := DST_TBL_NME else
  if CompareText( ATextBlock, 'UK_DST_TBL_NME' ) = 0 then
    ATextResult := IB_Connection.mkIdent( 'UK_' + stLitCriteria( DST_TBL_NME ))
  else
  if CompareText( ATextBlock, 'PK_DST_TBL_NME' ) = 0 then
    ATextResult := IB_Connection.mkIdent( 'PK_' + stLitCriteria( DST_TBL_NME ))
  else
  if CompareText( ATextBlock, 'DST_KEY_CLS' ) = 0 then
    ATextResult := DST_KEY_CLS else
  if CompareText( ATextBlock, 'DST_SRC_CLS' ) = 0 then
    ATextResult := DST_SRC_CLS else
  if CompareText( ATextBlock, 'DST_SRC_CLS_MAP' ) = 0 then
    ATextResult := DST_SRC_CLS_MAP else
  if CompareText( ATextBlock, 'DST_SRC_KEY_CLS' ) = 0 then
    ATextResult := DST_SRC_KEY_CLS else
  if CompareText( ATextBlock, 'DST_TBL_SRC' ) = 0 then
    ATextResult := DST_TBL_SRC else
  if CompareText( ATextBlock, 'DST_CLS' ) = 0 then
    ATextResult := DST_CLS else
  if CompareText( ATextBlock, 'SRC_CLS' ) = 0 then
    ATextResult := SRC_CLS else
  if CompareText( ATextBlock, 'DST_BLA_CLS' ) = 0 then
    ATextResult := DST_BLA_CLS else
  if CompareText( ATextBlock, 'SRC_BLA_CLS' ) = 0 then
    ATextResult := SRC_BLA_CLS else
  if CompareText( ATextBlock, 'STATUS' ) = 0 then
    ATextResult := STATUS else
  if CompareText( ATextBlock, 'LOG' ) = 0 then
  begin
    if LOG then
      ATextResult := 'T'
    else
      ATextResult := 'F';
  end
  else
  if CompareText( ATextBlock, 'SRC_OLD_KEY_CLS' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_KEY_CLS, '<<OLD_FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'SRC_KEY_CLS_N' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_KEY_CLS, 'n.<<FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'DST_OLD_KEY_CLS' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_KEY_CLS, '<<OLD_FLD_NME>>', ', ', 1 )
  else

  if CompareText( ATextBlock, 'SRC_KEY_COL_Q' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_KEY_CLS,
                       '  <<FLD_NME>> <<DOM_NME>> NOT NULL', ','#13#10, 0 )
  else
  if CompareText( ATextBlock, 'SRC_OLD_KEY_Q' ) = 0 then
    ATextResult :=
    WalkFields( crSRC,
                SRC_KEY_CLS,
                '  <<OLD_FLD_NME>> <<DOM_NME>> NOT NULL', ','#13#10, 0 )
  else
  if CompareText( ATextBlock, 'SRC_BLA_COL_Q' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_BLA_CLS, '  <<RPL_FLD_NME>> CHAR(1) NOT NULL',
                                    ','#13#10, 0 )
  else

{!}
  if CompareText( ATextBlock, 'SRC_BLA_DEC_VAR' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_BLA_CLS, 'DECLARE VARIABLE <<RPL_FLD_NME>> CHAR(1)',
                                    ';'#13#10, 0 )
  else
  if CompareText( ATextBlock, 'SRC_BLA_INIT_VAR' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_BLA_CLS, '      <<RPL_FLD_NME>> = ''F'';'#13#10, ''
                                  , 0 )
  else
  if CompareText( ATextBlock, 'SRC_BLA_SET_VAL_AI' ) = 0 then
    ATextResult :=
    WalkFields( crSRC,
                SRC_BLA_CLS, '    IF ( NEW.<<FLD_NME>> IS NOT NULL ) THEN ' +
                             '<<RPL_FLD_NME>> = ''T'';'#13#10, '', 0 )
  else
  if CompareText( ATextBlock, 'SRC_BLA_SET_VAL_AU' ) = 0 then
  begin
    tmpStr := Get_BLA_CLSUsed( SRC_BLA_CLS, SRC_CLS );
    ATextResult :=
    WalkFields( crSRC,
                tmpStr,
                '      IF (<<FLD_CHANGED>>) THEN'#13#10 +
                '        <<RPL_FLD_NME>> = ''T'';'#13#10, '', 0 )
  end
  else
  if CompareText( ATextBlock, 'SRC_BLA_Q_B' ) = 0 then
  begin
    tmpStr := Get_BLA_CLSUsed( SRC_BLA_CLS, SRC_CLS );
    if tmpStr = '' then
      ATextResult := WalkFields( crSRC, SRC_BLA_CLS,
                                 '  NEW.<<RPL_FLD_NME>> = ''F'';'#13#10,  '',
                                 0 )
    else begin
      ATextResult :=
      WalkFields( crSRC, tmpStr,
                  '  IF ( NEW.RPL$Q_TYP = ''I'' ) THEN'#13#10 +
                  '    NEW.<<RPL_FLD_NME>> = ''T'';'#13#10 +
                  '  ELSE'#13#10 +
                  '  IF ( NEW.RPL$Q_TYP = ''D'' ) THEN'#13#10 +
                  '    NEW.<<RPL_FLD_NME>> = ''F'';'#13#10, '', 0 );
      tmpStr := Get_BLA_CLSNotUsed( SRC_BLA_CLS, SRC_CLS );
      ATextResult := ATextResult +
      WalkFields( crSRC, tmpStr, '  NEW.<<RPL_FLD_NME>> = ''F'';'#13#10,  '',
                  0 );
    end;
  end
  else
  if CompareText( ATextBlock, 'SRC_BLA_CLS_INS' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_BLA_CLS, '<<RPL_FLD_NME>>',
                                    #13#10'                 , ', -1 )

  else
  if CompareText( ATextBlock, 'SRC_BLA_CLS_VAL' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_BLA_CLS, ':<<RPL_FLD_NME>>',
                                    #13#10'           , ', -1 )
  else
  if CompareText( ATextBlock, 'OLD_KEY_SEND_Q' ) = 0 then
  begin
    if ( _SRC_KEY_CLS = '' ) or ( _SRC_KEY_CLS = '*' ) then
      ATextResult :=
      WalkFields( crDST, DST_KEY_CLS,
                  '  <<OLD_FLD_NME>> <<TYP_NME>>', ','#13#10, 1 )
    else
      ATextResult :=
      WalkFields( crSRC, SRC_KEY_CLS,
                  '  <<OLD_FLD_NME>> <<TYP_NME>>', ','#13#10, 1 )
  end
  else
  if CompareText( ATextBlock, 'SRC_CLS_SEND_Q' ) = 0 then
  begin
    if ( _SRC_KEY_CLS = '' ) or ( _SRC_KEY_CLS = '*' ) then
      ATextResult :=
      WalkFields( crDST, DST_CLS,
                  '  <<FLD_NME>> <<TYP_NME>>', ','#13#10, 1 )
    else
      ATextResult :=
      WalkFields( crSRC, SRC_CLS,
                  '  <<FLD_NME>> <<TYP_NME>>', ','#13#10, 1 )
  end
  else
  if CompareText( ATextBlock, 'SRC_BLA_SEND_Q' ) = 0 then
  begin
    if ( _SRC_BLA_CLS = '' ) or ( _SRC_BLA_CLS = '*' ) then
      ATextResult := '<<DST_BLA_SEND_Q>>'
    else
      ATextResult :=
      WalkFields( crSRC, SRC_BLA_CLS,
                  '  <<RPL_FLD_NME>> CHAR(1)', ','#13#10, -1 )
  end
  else
  if CompareText( ATextBlock, 'DST_BLA_SEND_Q' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_BLA_CLS,
                '  <<RPL_FLD_NME>> CHAR(1)', ','#13#10, -1 )
  else                         
  if CompareText( ATextBlock, 'SRC_KEY_CLS_VAL' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_KEY_CLS, '<<EXP>><<FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_DEC_VARS' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS,
                       'DECLARE VARIABLE <<TMP_FLD_NME>> <<TYP_NME>>;',
                       #13#10, 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_SET_NULL' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, '  <<TMP_FLD_NME>> = NULL;', #13#10, 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_N' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, 'n.<<FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'DST_KEY_CLS_N' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_KEY_CLS, 'n.<<FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_INTO_VARS' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, ':<<TMP_FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_INSERT_VARS' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, ':<<FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_INSERT_TMP_VARS' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, ':<<TMP_FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_VARS' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, ':<<FLD_NME>>', ', ', 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_UPDATE' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, 'n.<<FLD_NME>> = :<<FLD_NME>>',
                                ','#13#10'            ', 1 )
  else
  if CompareText( ATextBlock, 'DST_KEY_OLD_WHERE' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_KEY_CLS, 'n.<<FLD_NME>> = :<<OLD_FLD_NME>>',
                                    #13#10'      AND ', 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_WAS_CHANGED' ) = 0 then
  begin
    WalkBlobArray := false;
    try
      ATextResult :=
        WalkFields( crDST, DST_CLS, '(' +
                                     '( <<FLD_NME>>' +
                                     ' <> :<<TMP_FLD_NME>>' +
                                     ' ) OR ' +

                                     '(' +
                                       '( <<FLD_NME>> IS NULL ) AND ' +
                                       '( :<<TMP_FLD_NME>> IS NOT NULL )' +
                                     ')' +

                                     ' OR ' +
                                     '(' +
                                       '( <<FLD_NME>> IS NOT NULL ) AND ' +
                                       '( :<<TMP_FLD_NME>> IS NULL )' +
                                     ')' +
                                    ')',
                                    ' OR'#13#10'        ', 1 );
      if Trim( ATextResult ) = '' then
        ATextResult := '1=0';
    finally
      WalkBlobArray := true;
    end;
  end
  else
  if CompareText( ATextBlock, 'DST_CLS_ASSIGN_VARS' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, 'n.<<FLD_NME>> = :<<FLD_NME>>',
                                ','#13#10'        ', 1 )
  else
  if CompareText( ATextBlock, 'DST_KEY_WHERE' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_KEY_CLS, 'n.<<FLD_NME>> = :<<FLD_NME>>',
                                    #13#10'    AND ', 1 )
  else
  if CompareText( ATextBlock, 'SRC_KEY_WHERE' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_KEY_CLS, 'n.<<FLD_NME>> = :<<FLD_NME>>',
                                    #13#10'    AND ', 1 )
  else
  if CompareText( ATextBlock, 'TMP_SRC_KEY_WHERE' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_KEY_CLS, 'n.<<FLD_NME>> = :<<TMP_FLD_NME>>',
                                    #13#10'    AND ', 1 )
  else
  if CompareText( ATextBlock, 'SRC_KEY_IS_NULL' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_KEY_CLS, ':<<FLD_NME>> IS NULL', ' AND ', 1 )
  else
  if CompareText( ATextBlock, 'DST_CLS_SYNC_PROC_PRM' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, '  <<FLD_NME>> <<TYP_NME>>', ','#13#10, 1 )
  else
  if CompareText( ATextBlock, 'DST_KEY_OLD_SYNC_PROC_PRM' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_KEY_CLS, '  <<OLD_FLD_NME>> <<TYP_NME>>',
                                    ','#13#10, 1 )
  else
  if CompareText( ATextBlock, 'DST_BLA_SYNC_PROC_PRM' ) = 0 then
  begin
    ATextResult :=
    WalkFields( crDST, DST_BLA_CLS, '<<RPL_FLD_NME>> CHAR(1)', ','#13#10, 1 );
    if Trim( ATextResult ) <> '' then
      ATextResult := ', ' + ATextResult;
  end
  else
  if CompareText( ATextBlock, 'SYNC_Q_SET_BLA_CLS_UPDATE' ) = 0 then
  begin
    tmpStr := Get_BLA_CLSUsed(DST_BLA_CLS, DST_CLS);
    ATextResult :=
    WalkFields( crDST, tmpStr,
      '      IF ( <<RPL_FLD_NME>> = ''F'' ) THEN'#13#10 +
      '        SELECT n.<<FLD_NME>> FROM <<DST_TBL_NME>> n ' +
              'WHERE n.RDB$DB_KEY = :aDB_KEY ' +
              'INTO :<<FLD_NME>>;', #13#10, 1 );
  end
  else
  if CompareText( ATextBlock, 'DST_OLD_KEY_CLS_INPUT_PRM' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_KEY_CLS, '?<<OLD_FLD_NME>>', ', ', 1 )
  else

  if CompareText( ATextBlock, 'SRC_CLS_INPUT_PRM' ) = 0 then
  begin
    if ( _SRC_CLS = '' ) or ( _SRC_CLS = '*' ) then
      ATextResult := '<<DST_CLS_INPUT_PRM>>'
    else
      ATextResult :=
      WalkFields( crSRC, SRC_CLS, '?<<FLD_NME>>', ', ', 1 )
  end
  else

  if CompareText( ATextBlock, 'DST_CLS_INPUT_PRM' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_CLS, '?<<FLD_NME>>', ', ', 1 )
  else

  if CompareText( ATextBlock, 'SRC_BLA_INPUT_PRM' ) = 0 then
  begin
    if ( _SRC_CLS = '' ) or ( _SRC_CLS = '*' ) then
      ATextResult := '<<DST_BLA_INPUT_PRM>>'
    else
      ATextResult :=
      WalkFields( crSRC, SRC_BLA_CLS, '?<<RPL_FLD_NME>>', ', ', -1 )
  end
  else

  if CompareText( ATextBlock, 'DST_BLA_INPUT_PRM' ) = 0 then
    ATextResult :=
    WalkFields( crDST, DST_BLA_CLS, '?<<RPL_FLD_NME>>', ', ', -1 )
  else
  if CompareText( ATextBlock, 'DST_BLA_CLS_SELECT' ) = 0 then  //???
    ATextResult :=
    WalkFields( crDST, DST_BLA_CLS, '<<RPL_FLD_NME>>', ', ', -1 )
  else
  if CompareText( ATextBlock, 'DST_TBL_DROP' ) = 0 then
  begin
    if DST_TBL_CREATE = 'T' then
      ATextResult := 'DROP TABLE <<DST_TBL_NME>>'
    else
      ATextResult := 'COMMIT /* DROP TABLE <<DST_TBL_NME>> */';
  end
  else
  if CompareText( ATextBlock, 'SRC_BLA_Q_CLS' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_BLA_CLS, 'q.<<RPL_FLD_NME>>',
                                    ','#13#10'             ', -1 )
  else
  if CompareText( ATextBlock, 'SRC_BLA_Q_VARS' ) = 0 then
    ATextResult :=
    WalkFields( crSRC, SRC_BLA_CLS, ':<<RPL_FLD_NME>>',
                                    ','#13#10'           ', -1 )
  else
  if CompareText( ATextBlock, 'SRC_SELECT_SEND_Q' ) = 0 then
  begin
    if DST_SRC_KEY_CLS <> '' then
      ATextResult := 'q.RPL$Q_KEY,'#13#10 +
        '             q.RPL$Q_TYP,'#13#10 +
        '             ' +
      WalkFields( crSRC, SRC_KEY_CLS, 'q.<<OLD_FLD_NME>>',','#13#10 +
        '             ', 0 ) +
      WalkFields( crSRC, SRC_KEY_CLS, 'q.<<FLD_NME>>', ','#13#10 +
        '             ', 1 ) +
                     '<<SRC_BLA_Q_CLS>>'
    else
      ATextResult := 'q.RPL$Q_KEY, q.RPL$Q_TYP';
  end
  else
  if CompareText( ATextBlock, 'SRC_PRC_VAR_INIT_SEND_Q' ) = 0 then
  begin
    if ( _SRC_KEY_CLS = '' ) or ( _SRC_KEY_CLS = '*' ) then
      ATextResult :=
      WalkFields( crDST, DST_CLS,
                  '  <<FLD_NME>> = NULL;', #13#10, 1 )
    else
      ATextResult :=
      WalkFields( crSRC, SRC_CLS,
                  '  <<FLD_NME>> = NULL;', #13#10, 1 )
  end
  else
  if CompareText( ATextBlock, 'SRC_PRC_DEC_VAR_SEND_Q' ) = 0 then
  begin
    ATextResult :=
      WalkFields( crSRC,
                  SRC_KEY_CLS,
                  'DECLARE VARIABLE <<TMP_FLD_NME>> <<TYP_NME>>;', #13#10, 1 )
  end
  else
  if CompareText( ATextBlock, 'SRC_INTO_SEND_Q' ) = 0 then
  begin
    if DST_SRC_KEY_CLS <> '' then
      ATextResult := ':RPL$Q_KEY,'#13#10 +
          '           :RPL$Q_TYP,'#13#10 +
          '           ' +
      WalkFields( crSRC, SRC_KEY_CLS, ':<<OLD_FLD_NME>>',','#13#10 +
          '           ', 0 ) +
      WalkFields( crSRC, SRC_KEY_CLS, ':<<TMP_FLD_NME>>',','#13#10 +
          '           ', 1 ) +
                     '<<SRC_BLA_Q_VARS>>'
    else
      ATextResult := ':RPL$Q_KEY, :RPL$Q_TYP';
  end
  else
  if CompareText( ATextBlock, 'CUSTOM_SRC_Q_INS_TRG' ) = 0 then
  begin
    if SRC_TRG_INS_Q = '' then
      ATextResult := '<<SRC_Q_INS_TRG>>'
    else
      ATextResult := SRC_TRG_INS_Q;
  end
  else
  if CompareText( ATextBlock, 'CUSTOM_SRC_Q_DEL_TRG' ) = 0 then
  begin
    if SRC_TRG_INS_Q = '' then
      ATextResult := '<<SRC_Q_DEL_TRG>>'
    else
      ATextResult := SRC_TRG_DEL_Q;
  end
  else
  if CompareText( ATextBlock, 'CUSTOM_SRC_Q_UPD_TRG' ) = 0 then
  begin
    if SRC_TRG_INS_Q = '' then
      ATextResult := '<<SRC_Q_UPD_TRG>>'
    else
      ATextResult := SRC_TRG_UPD_Q;
  end
  else
  if CompareText( ATextBlock, 'SRC_TRG_DEC_VAR' ) = 0 then
    ATextResult := SRC_TRG_DEC_VAR
  else
  if CompareText( ATextBlock, 'SRC_Q_INS_TRG' ) = 0 then
    ATextResult := '    INSERT INTO RPL$<<IND_NME>>$Q ('#13#10 +
                   '      RPL$Q_TYP, <<SRC_OLD_KEY_CLS>>'#13#10 +
                   '               , <<SRC_KEY_CLS>> )'#13#10 +
                   '    VALUES ( <<SET_EXP_NEW>>'#13#10 +
                   '      ''I'', <<SRC_KEY_CLS_VAL>>'#13#10 +
                   '         , <<SRC_KEY_CLS_VAL>> );'#13#10
  else
  if CompareText( ATextBlock, 'SRC_Q_DEL_TRG' ) = 0 then
    ATextResult := '    INSERT INTO RPL$<<IND_NME>>$Q ('#13#10 +
                   '      RPL$Q_TYP, <<SRC_OLD_KEY_CLS>>'#13#10 +
                   '               , <<SRC_KEY_CLS>> )'#13#10 +
                   '    VALUES ( <<SET_EXP_OLD>>'#13#10 +
                   '      ''D'', <<SRC_KEY_CLS_VAL>>'#13#10 +
                   '         , <<SRC_KEY_CLS_VAL>> );'#13#10
  else
  if CompareText( ATextBlock, 'SRC_Q_UPD_TRG' ) = 0 then
    ATextResult :=
  '      INSERT INTO RPL$<<IND_NME>>$Q ('#13#10 +
  '        RPL$Q_TYP, <<SRC_OLD_KEY_CLS>>'#13#10 +
  '                 , <<SRC_KEY_CLS>><<SRC_BLA_CLS_INS>> )'#13#10 +
  '      VALUES ('#13#10 +
  '        ''U'', <<SET_EXP_OLD>><<SRC_KEY_CLS_VAL>>'#13#10 +
  '           , <<SET_EXP_NEW>><<SRC_KEY_CLS_VAL>><<SRC_BLA_CLS_VAL>> );'#13#10

end;

end.

