
{                                                                              }
{ IB_SCHEMA                                                                    }
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
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  10-Aug-2001                                                                 }
{     Altered GetGeneratorValue so that it always expects the supplied         }
{     generator name parameter to be fully specified - including quotes        }
{     if quotes are required.  Previously it tried to reprocess the            }
{     the supplied name but this produces inconsistent results.                }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Schema;

interface

uses
  Classes, SysUtils, Dialogs,

  IB_Header,
  IB_Components;

procedure SchemaVersionInfo( Cn: TIB_Connection;
                             Tr: TIB_Transaction;
                             VersionInfo: TStrings );

procedure SchemaDomainNames( Cn: TIB_Connection;
                             Tr: TIB_Transaction;
                             System: boolean;
                             Names: TStrings );

procedure SchemaFieldDomains( Cn: TIB_Connection;
                              Tr: TIB_Transaction;
                              FieldDomains: TStrings );

procedure SchemaGeneratorNames( Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                System: boolean;
                                Names: TStrings );

procedure SchemaRelationNames( Cn: TIB_Connection;
                               Tr: TIB_Transaction;
                               System,
                               Tables,
                               Views: boolean;
                               Names: TStrings );

procedure SchemaRelationsByID( Cn: TIB_Connection;
                               Tr: TIB_Transaction;
                               Views: boolean;
                               RelationsByID: TStrings );

procedure SchemaFieldNames( Cn: TIB_Connection;
                            Tr: TIB_Transaction;
                            Names: TStrings;
                            RelationName: string );

procedure SchemaProcedureInfo( Cn: TIB_Connection;
                               Tr: TIB_Transaction;
                               Names: TStrings );

procedure SchemaConstraintInfo( Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                System: boolean;
                                Names: TStrings;
                                RelationName: string );

procedure SchemaTriggerInfo( Cn: TIB_Connection;
                             Tr: TIB_Transaction;
                             System: boolean;
                             Names: TStrings;
                             RelationName: string );

procedure SchemaIndexDefinitions( Cn: TIB_Connection;
                                  Tr: TIB_Transaction;
                                  SystemTables: boolean;
                                  Definitions: TStrings );

procedure SchemaIndexInfo( Cn: TIB_Connection;
                           Tr: TIB_Transaction;
                           System: boolean;
                           Names: TStrings;
                           RelationName: string );

procedure SchemaIndexSegmentsInfo( Cn: TIB_Connection;
                                   Tr: TIB_Transaction;
                                   Names: TStrings;
                                   IndexName: string );

procedure SchemaPrimaryKeyInfo( Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                RelationName: string;
                                PrimaryKeys: TStrings );

procedure SchemaForeignKeyInfo( Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                RelationName: string;
                                TargetRelationNames: boolean;
                                ForeignKeys: TStrings );

procedure SchemaRequiredCols( Cn: TIB_Connection;
                              Tr: TIB_Transaction;
                              System: boolean;
                              RelationName: string;
                              RequiredCols: TStrings );

procedure SchemaComputedCols( Cn: TIB_Connection;
                              Tr: TIB_Transaction;
                              System: boolean;
                              RelationName: string;
                              ComputedCols: TStrings );

procedure SchemaDefaultedCols( Cn: TIB_Connection;
                               Tr: TIB_Transaction;
                               ASystem,
                               AIncludeValues: boolean;
                               RelationName: string;
                               DefaultedCols: TStrings );

function GetGeneratorValue(     Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                GeneratorName: string;
                                Increment: longint;
                            var GeneratorValue: ISC_INT64 ): boolean;

type
  TIB_SchemaCursor = class( TIB_Dataset )
  public
    function CheckTransaction( RequestStart: boolean ): boolean; override;
  end;

procedure GetBDEAliasInfo( TargetType, TargetName: string; AStrings: TStrings );


implementation

uses
  Registry, Windows, IB_Parse;

procedure GetBDEAliasInfo( TargetType, TargetName: string; AStrings: TStrings );

  function GetIDAPI: string;
  begin
    Result := '';
    with TRegistry.Create do
      try
        RootKey := HKEY_LOCAL_MACHINE;
        if OpenKey( '\SOFTWARE\Borland\Database Engine', True ) then
          Result := ReadString( 'CONFIGFILE01' );
      finally
        CloseKey;
        Free;
      end;
  end;

  function XReadln( fin: TFileStream; var S: string ): boolean;
  { Special version of Readln, reads IDAPI.CFG-Line
    Every line in IDAPI.CFG starts with 0300. To make our
    life easier, we skip the first occurence and look
    at 0300 as CR/LF. When writing we automatically add
    0300 }
  var
    c: char;
    EOR: boolean;
  begin
    s := '';
    EOR := false;
    while ( fin.Read( c, 1 ) > 0 ) and not EOR do
    begin
      if c = #3 then
      begin
        EOR := true;
        fin.Read( c, 1 ); { skip 00 following 03 }
      end
      else
        s := s + c;
    end;
    Result := EOR or ( s <> '' );
  end;

var
  s: string;
  fin: TFileStream;
  inDBSection,
  inDBInfoSection,
  inAliasSection: boolean;
  tmpPos: integer;
  tmpStr: string;
  AliasName: string;
begin
  fin := TFileStream.Create( GetIDAPI, fmOpenRead );
  AStrings.BeginUpdate;
  try
    AStrings.Clear;
    { we look at 0300 as CRLF so we skip the first occurence }
    fin.Position := 2;
    inDBSection := false;
    while XReadln( fin, s ) do
    begin
      { Check for end of DATABASES section }
      if inDBSection then
      begin
        if ( pos( #2#0#2#0#2#0, s ) > 0 ) then
          Exit;
      end
      else
        { Check for start of DATABASES section }
        if pos( #0 + 'DATABASES' + #0#1#0, s ) > 0 then
        begin
          inDBSection := true;
          Continue;
        end;
      if inDBSection then
      begin
        AliasName := Trim( s );
        inDBInfoSection := false;
        inAliasSection := ( TargetType = 'ALIAS' ) and
                          ( CompareText( TargetName, AliasName ) = 0 );
        while XReadln( fin, s ) and ( pos( #2#0#2#0, s ) = 0 ) do
        begin
          if not inDBInfoSection then
            inDBInfoSection := pos( #0 + 'DB INFO' + #0#1#0, s ) = 1
          else
          begin
            if not inAliasSection then
            begin
              tmpPos := pos( #0 + 'TYPE' + #0#4#0, s );
              if tmpPos > 0 then
              begin
                s := Trim( Copy( s, 9, MaxInt ));
                if ( CompareText( s, TargetName ) = 0 ) or
                   ( TargetName = '' ) then
                begin
                  AStrings.Add( AliasName );
                end;
              end;
            end
            else
            begin
              tmpPos := pos( #0#4#0, s );
              if tmpPos > 0 then
              begin
                tmpStr := Trim( Copy( s, 1, tmpPos - 1 )) + '=' +
                          Trim( Copy( s, tmpPos + 3, MaxInt ));
              end
              else
                tmpStr := Trim( s ) + '=';
              AStrings.Add( tmpStr );
            end;
          end;
        end;
      end;
    end;
  finally
    fin.Free;
    AStrings.EndUpdate;
  end;
end;

function TIB_SchemaCursor.CheckTransaction( RequestStart: boolean ): boolean;
begin
  KeyLinksAutoDefine := false;
  if not Assigned( IB_Transaction ) and Assigned( IB_Connection ) then
    IB_Transaction := IB_Connection.SchemaCache.Transaction;
  Result := inherited CheckTransaction( RequestStart );
end;

procedure SchemaVersionInfo( Cn: TIB_Connection;
                             Tr: TIB_Transaction;
                             VersionInfo: TStrings );
begin
  if VersionInfo = nil then begin
    Exit;
  end else begin
    VersionInfo.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    RetrieveDomainNames := false;
    ParamCheck := false;
    IB_Connection := Cn;
    IB_Transaction := Tr;
    {
    Note: Grab a calculated string result here as the *only* selected data
          to make it so that IBO does not try to get any other schema cache
          info. If this is not done, an infinite loop will result in the
          TIB_SchemaCache.GetSchemaCacheList method.
    Note: VERSION_NUMBER should be defined NOT NULL such that a string result
          is always returned for all items (a NULL value would remove the item
          from the result set, and cause version checking headaches).  See
          TIB_SchemaCache.CheckSchemaVersionTable for required table definition.
    }
    SQL.Add( 'SELECT SCHEMA_ITEM || ''='' || VERSION_NUMBER' );
    SQL.Add( 'FROM IBO$SCHEMA_VERSION' );
    SQL.Add( 'ORDER BY 1' );  // Grab in sorted list order.
    try
      Prepare;
      First;
      while not Eof do begin
        VersionInfo.Add( Fields[ 0 ].AsString );
        Next;
      end;
    except
      // Throw away exception for missing table IBO$SCHEMAVERSION
    end;
  finally
    Free;
  end;
end;

procedure SchemaDomainNames( Cn: TIB_Connection;
                             Tr: TIB_Transaction;
                             System: boolean;
                             Names: TStrings );
begin
  if Names = nil then begin
    Exit;
  end else begin
    Names.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$FIELD_NAME' );
    SQL.Add( 'FROM RDB$FIELDS' );
    if not System then begin
      SQL.Add( 'WHERE ( RDB$SYSTEM_FLAG <> 1 OR RDB$SYSTEM_FLAG IS NULL )' );
    end;
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    First;
    while not Eof do
    begin
      Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaFieldDomains( Cn: TIB_Connection;
                              Tr: TIB_Transaction;
                              FieldDomains: TStrings );
begin
  if FieldDomains = nil then begin
    Exit;
  end else begin
    FieldDomains.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$RELATION_NAME, RDB$FIELD_NAME, RDB$FIELD_SOURCE' );
    SQL.Add( 'FROM RDB$RELATION_FIELDS R' );
    SQL.Add( 'WHERE ( RDB$SYSTEM_FLAG <> 1 OR RDB$SYSTEM_FLAG IS NULL )' );
    SQL.Add( '  AND NOT RDB$RELATION_NAME STARTING ''RDB$''' );
    SQL.Add( '  AND NOT RDB$FIELD_NAME STARTING ''RDB$''' );
    SQL.Add( '  AND NOT RDB$FIELD_SOURCE STARTING ''RDB$''' );
    SQL.Add( 'ORDER BY 1, 2' );
    Prepare;
    First;
    while not Eof do
    begin
      FieldDomains.Add( IB_Connection.mkVARIdent( Fields[0].AsString ) + '.' +
                        IB_Connection.mkVARIdent( Fields[1].AsString ) + '=' +
                        IB_Connection.mkVARIdent( Fields[2].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaGeneratorNames( Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                System: boolean;
                                Names: TStrings );
begin
  if Names = nil then begin
    Exit;
  end else begin
    Names.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$GENERATOR_NAME' );
    SQL.Add( 'FROM RDB$GENERATORS' );
    if not System then
      SQL.Add( 'WHERE ( RDB$SYSTEM_FLAG <> 1 OR RDB$SYSTEM_FLAG IS NULL )' );
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    First;
    while not Eof do
    begin
      Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaRelationNames( Cn: TIB_Connection;
                               Tr: TIB_Transaction;
                               System,
                               Tables,
                               Views: boolean;
                               Names: TStrings );
begin
  if Names = nil then begin
    Exit;
  end else begin
    Names.Clear;
  end;
  if Assigned( Cn ) then
  with TIB_SchemaCursor.Create( cn.IB_Session ) do
  try
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT R.RDB$RELATION_NAME' );
    SQL.Add( 'FROM RDB$RELATIONS R' );
    if not Views and not Tables then begin
      SQL.Add( 'WHERE 0=1' );
    end else if System then begin
      SQL.Add( 'WHERE 1=1' );
    end else begin
      SQL.Add( 'WHERE ( R.RDB$SYSTEM_FLAG <> 1 OR ' +
                      ' R.RDB$SYSTEM_FLAG IS NULL )' );
    end;
    if Views and not Tables then begin
    SQL.Add( ' AND EXISTS ( SELECT V.RDB$VIEW_CONTEXT' );
    SQL.Add( '              FROM RDB$VIEW_RELATIONS V' );
    SQL.Add( '              WHERE R.RDB$RELATION_NAME=V.RDB$VIEW_NAME )' );
    end;
    if Tables and not Views then begin
    SQL.Add( ' AND NOT EXISTS ( SELECT V.RDB$VIEW_CONTEXT' );
    SQL.Add( '                  FROM RDB$VIEW_RELATIONS V' );
    SQL.Add( '                  WHERE R.RDB$RELATION_NAME=V.RDB$VIEW_NAME )');
    end;
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    First;
    while not Eof do
    begin
      Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaRelationsByID( Cn: TIB_Connection;
                               Tr: TIB_Transaction;
                               Views: boolean;
                               RelationsByID: TStrings );
begin
  if RelationsByID = nil then begin
    Exit;
  end else begin
    RelationsByID.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    RetrieveDomainNames := false;
    ParamCheck := false;
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT R.RDB$RELATION_ID || ''='', R.RDB$RELATION_NAME' );
    SQL.Add( 'FROM RDB$RELATIONS R' );
    if not Views then begin
    SQL.Add( 'WHERE NOT EXISTS ( SELECT V.RDB$VIEW_CONTEXT' );
    SQL.Add( '                   FROM RDB$VIEW_RELATIONS V' );
    SQL.Add( '                   WHERE R.RDB$RELATION_NAME=V.RDB$VIEW_NAME )');
    end;
    SQL.Add( 'ORDER BY 1' );  // Grab in sorted list order.
    Prepare;
    First;
    while not Eof do begin
      RelationsByID.Add( Fields[ 0 ].AsString +
                         IB_Connection.mkVARIdent( Fields[ 1 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaProcedureInfo( Cn: TIB_Connection;
                               Tr: TIB_Transaction;
                               Names: TStrings );
begin
  if Names = nil then
    Exit
  else
    Names.Clear;
  if Assigned( Cn ) then
    with TIB_SchemaCursor.Create( cn.IB_Session ) do
      try
        IB_Connection := Cn;
        IB_Transaction := Tr;
        SQL.Add( 'SELECT RDB$PROCEDURE_NAME' );
        SQL.Add( 'FROM RDB$PROCEDURES' );
        SQL.Add( 'ORDER BY RDB$PROCEDURE_NAME' );
        Prepare;
        First;
        while not Eof do
        begin
          Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
          Next;
        end;
      finally
        Free;
      end;
end;

procedure SchemaFieldNames( Cn: TIB_Connection;
                            Tr: TIB_Transaction;
                            Names: TStrings;
                            RelationName: string );
var
  ByTable: boolean;
  tmpTbl: string;
  tmpStr: string;
  tmpPos: integer;
  OldSorted: boolean;
begin
  if Names = nil then begin
    Exit;
  end;
  Names.BeginUpdate;
  OldSorted :=  ( Names is TStringList ) and
                ( Names as TStringList ).Sorted;
  if OldSorted then begin
   ( Names as TStringList ).Sorted := false;
  end;
  try
  Names.Clear;
  ByTable := RelationName = '<BY TABLE>';
  tmpTbl := '';
  tmpStr := '';
  tmpPos := -1;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT R.RDB$RELATION_NAME, RDB$FIELD_NAME' );
    SQL.Add( 'FROM RDB$RELATION_FIELDS R' );
{ TODO : Use proper handling for detecting system settings. }
    SQL.Add( 'WHERE R.RDB$RELATION_NAME NOT STARTING WITH ''RDB$''' );
    if not ByTable and ( RelationName <> '' ) then begin
      SQL.Add( '  AND R.RDB$RELATION_NAME = ' + mkLitCriteria(
                                                stLitCriteria( RelationName ),
                                                               '''' ));
      SQL.Add( 'ORDER BY R.RDB$FIELD_POSITION' );
    end else begin
      SQL.Add( 'ORDER BY R.RDB$RELATION_NAME, R.RDB$FIELD_POSITION' );
    end;
    Prepare;
    First;
{ TODO : Handle the sql dialog 3 formats...}
    while not Eof do
    begin
      if RelationName <> '' then
      begin
        if ByTable then
        begin
          if ( tmpTbl <> IB_Connection.mkVARIdent( Fields[0].AsString )) or
             ( tmpPos = -1 ) then
          begin
            tmpStr := IB_Connection.mkVARIdent( Fields[1].AsString );
            tmpTbl := IB_Connection.mkVARIdent( Fields[0].AsString );
            tmpPos := Names.Add( tmpTbl + '=' + tmpStr );
          end
          else
          begin
            tmpStr := tmpStr + ',' + IB_Connection.mkVARIdent(
                      Fields[1].AsString );
            Names.Strings[ tmpPos ] := tmpTbl + '=' + tmpStr;
          end;
        end
        else
        begin
          Names.Add( IB_Connection.mkVARIdent( Fields[ 1 ].AsString ));
        end;
      end
      else
      begin
        Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ) + '.' +
                   IB_Connection.mkVARIdent( Fields[ 1 ].AsString ));
      end;
      Next;
    end;
  finally
    Free;
  end;
  finally
    if OldSorted then
    begin
      ( Names as TStringList ).Sorted := true;
    end;
    Names.EndUpdate;
  end;
end;

procedure SchemaConstraintInfo( Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                System: boolean;
                                Names: TStrings;
                                RelationName: string );
begin
  if Names = nil then begin
    Exit;
  end else begin
    Names.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$CONSTRAINT_NAME' );
    SQL.Add( 'FROM RDB$RELATION_CONSTRAINTS C' );
    SQL.Add( 'WHERE 1=1' );
    if RelationName <> '' then begin
    SQL.Add( '  AND C.RDB$RELATION_NAME = ' + mkLitCriteria(
                                              stLitCriteria( RelationName ),
                                                             '''' ));
    end;
    if not System then begin
{ TODO : Use proper handling for detecting system settings. }
    SQL.Add( '  AND NOT C.RDB$RELATION_NAME STARTING WITH ''RDB$''' );
    end;
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    First;
    while not Eof do begin
      Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaTriggerInfo( Cn: TIB_Connection;
                             Tr: TIB_Transaction;
                             System: boolean;
                             Names: TStrings;
                             RelationName: string );
begin
  if Names = nil then begin
    Exit;
  end else begin
    Names.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$TRIGGER_NAME' );
    SQL.Add( 'FROM RDB$TRIGGERS T' );
    SQL.Add( 'WHERE 1=1' );
    if RelationName <> '' then begin
    SQL.Add( '  AND T.RDB$RELATION_NAME = ' + mkLitCriteria(
                                              stLitCriteria( RelationName ),
                                                             '''' ));
    end;
    if not System then begin
{ TODO : Use proper handling for detecting system settings. }
    SQL.Add( '  AND NOT T.RDB$RELATION_NAME STARTING WITH ''RDB$''' );
    end;
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    First;
    while not Eof do begin
      Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaIndexInfo( Cn: TIB_Connection;
                           Tr: TIB_Transaction;
                           System: boolean;
                           Names: TStrings;
                           RelationName: string );
begin
  if Names = nil then begin
    Exit;
  end else begin
    Names.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$INDICES.RDB$INDEX_NAME' );
    SQL.Add( '     , RDB$INDICES.RDB$RELATION_NAME' );
    SQL.Add( 'FROM RDB$INDICES I' );
    SQL.Add( 'WHERE 1=1' );
    if RelationName <> '' then begin
    SQL.Add( '  AND I.RDB$RELATION_NAME = ' + mkLitCriteria(
                                              stLitCriteria( RelationName ),
                                                             '''' ));
    end;
    if not System then begin
{ TODO : Use proper handling for detecting system settings. }
    SQL.Add( '  AND NOT I.RDB$RELATION_NAME STARTING WITH ''RDB$''' );
    end;
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    First;
    while not Eof do begin
      if RelationName <> '' then begin
        Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
      end else begin
        Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ) + ',' +
                   IB_Connection.mkVARIdent( Fields[ 1 ].AsString ));
      end;
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaIndexSegmentsInfo( Cn: TIB_Connection;
                                   Tr: TIB_Transaction;
                                   Names: TStrings;
                                   IndexName: string );
begin
  if Names = nil then begin
    Exit;
  end else begin
    Names.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME' );
    SQL.Add( 'FROM RDB$INDEX_SEGMENTS S' );
    SQL.Add( 'WHERE S.RDB$INDEX_NAME = ''' + IndexName + '''' );
    SQL.Add( 'ORDER BY S.RDB$FIELD_POSITION' );
    Prepare;
    First;
    while not Eof do begin
      Names.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaPrimaryKeyInfo( Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                RelationName: string;
                                PrimaryKeys: TStrings );
var
  ByTable: boolean;
  tmpTbl: string;
  tmpStr: string;
  tmpPos: integer;
  OldSorted: boolean;
begin
  if PrimaryKeys = nil then begin
    Exit;
  end;
  PrimaryKeys.BeginUpdate;
  OldSorted :=  ( PrimaryKeys is TStringList ) and
                ( PrimaryKeys as TStringList ).Sorted;
  if OldSorted then begin
   ( PrimaryKeys as TStringList ).Sorted := false;
  end;
  try
  PrimaryKeys.Clear;
  ByTable := RelationName = '<BY TABLE>';
  tmpTbl := '';
  tmpStr := '';
  tmpPos := -1;
  if Assigned( Cn ) then
  with TIB_SchemaCursor.Create( cn.IB_Session ) do
  try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT S.RDB$FIELD_NAME' );
    SQL.Add( '     , I.RDB$RELATION_NAME' );
    SQL.Add( 'FROM RDB$RELATION_CONSTRAINTS C' );
    SQL.Add( '   , RDB$INDICES I' );
    SQL.Add( '   , RDB$INDEX_SEGMENTS S' );
    SQL.Add( 'WHERE C.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY''' );
    SQL.Add( '  AND C.RDB$RELATION_NAME = I.RDB$RELATION_NAME' );
    SQL.Add( '  AND C.RDB$INDEX_NAME = I.RDB$INDEX_NAME' );
    SQL.Add( '  AND I.RDB$INDEX_NAME = S.RDB$INDEX_NAME' );
    if ( RelationName <> '' ) and not ByTable then
    SQL.Add( '  AND I.RDB$RELATION_NAME = ' + mkLitCriteria(
                                              stLitCriteria( RelationName ),
                                                             '''' ));
    if ByTable then
      SQL.Add( 'ORDER BY I.RDB$RELATION_NAME, S.RDB$FIELD_POSITION' )
    else
      SQL.Add( 'ORDER BY S.RDB$FIELD_NAME, I.RDB$RELATION_NAME' );
    Prepare;
    First;
    while not Eof do
    begin
      if RelationName <> '' then
      begin
        if ByTable then
        begin
          if ( tmpTbl <> Fields[1].AsString ) or ( tmpPos = -1 ) then
          begin
            tmpStr := IB_Connection.mkVARIdent( Fields[0].AsString );
            tmpTbl := IB_Connection.mkVARIdent( Fields[1].AsString );
            tmpPos := PrimaryKeys.Add( tmpTbl + '=' + tmpStr );
          end else begin
            tmpStr := tmpStr + ',' + IB_Connection.mkVARIdent(
                      Fields[0].AsString );
            PrimaryKeys.Strings[ tmpPos ] := tmpTbl + '=' + tmpStr;
          end;
        end
        else
          PrimaryKeys.Add( IB_Connection.mkVARIdent( Fields[ 0 ].AsString ));
      end else begin
        PrimaryKeys.Add( IB_Connection.mkVARIdent(
                           Fields[0].AsString ) + ',' +
                         IB_Connection.mkVARIdent(
                           Fields[ 1 ].AsString ));
      end;
      Next;
    end;
  finally
    Free;
  end;
  finally
    if OldSorted then begin
      ( PrimaryKeys as TStringList ).Sorted := true;
    end;
    PrimaryKeys.EndUpdate;
  end;
end;

procedure SchemaForeignKeyInfo( Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                RelationName: string;
                                TargetRelationNames: boolean;
                                ForeignKeys: TStrings );
begin
  if ForeignKeys = nil then begin
    Exit;
  end else begin
    ForeignKeys.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME' );
    SQL.Add( '     , RDB$INDICES.RDB$RELATION_NAME' );
    SQL.Add( 'FROM RDB$RELATION_CONSTRAINTS C' );
    SQL.Add( '   , RDB$INDICES I' );
    SQL.Add( '   , RDB$INDEX_SEGMENTS S' );
    SQL.Add( 'WHERE RDB$CONSTRAINT_TYPE = ''FOREIGN KEY''' );
    SQL.Add( '  AND C.RDB$RELATION_NAME = I.RDB$RELATION_NAME' );
    SQL.Add( '  AND C.RDB$INDEX_NAME = I.RDB$INDEX_NAME' );
    SQL.Add( '  AND I.RDB$INDEX_NAME = S.RDB$INDEX_NAME' );
    if RelationName <> '' then begin
      SQL.Add( '  AND I.RDB$RELATION_NAME = ' + mkLitCriteria(
                                                stLitCriteria( RelationName ),
                                                               '''' ));
    end;
    SQL.Add( 'ORDER BY 1, S.RDB$FIELD_POSITION' );
    Prepare;
    First;
    while not Eof do
    begin
      if TargetRelationNames then
        ForeignKeys.Add( IB_Connection.mkVARIdent( Fields[0].AsString ) + ',' +
                         IB_Connection.mkVARIdent( Fields[1].AsString ))
      else
        ForeignKeys.Add( IB_Connection.mkVARIdent( Fields[0].AsString ) + ',' +
                         IB_Connection.mkVARIdent( Fields[1].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaRequiredCols( Cn: TIB_Connection;
                              Tr: TIB_Transaction;
                              System: boolean;
                              RelationName: string;
                              RequiredCols: TStrings );
begin
  if RequiredCols = nil then begin
    Exit;
  end else begin
    RequiredCols.Clear;
  end;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT RDB$FIELD_NAME'    );
    SQL.Add( '     , RDB$RELATION_NAME' );
    SQL.Add( 'FROM RDB$RELATION_FIELDS F' );
    SQL.Add( 'WHERE RDB$NULL_FLAG = 1'  );
    if RelationName <> '' then
    SQL.Add( '  AND F.RDB$RELATION_NAME = ' + mkLitCriteria(
                                              stLitCriteria( RelationName ),
                                                             '''' ));
    if not System then
{ TODO : Use proper handling for detecting system settings. }
    SQL.Add( '  AND NOT F.RDB$RELATION_NAME STARTING WITH ''RDB$''' );
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    First;
    while not Eof do
    begin
      if RelationName = '' then
        RequiredCols.Add( Cn.mkVARIdent( Fields[ 0 ].AsString ) + ',' +
                          Cn.mkVARIdent( Fields[ 1 ].AsString ))
      else
        RequiredCols.Add( Cn.mkVARIdent( Fields[ 0 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaComputedCols( Cn: TIB_Connection;
                              Tr: TIB_Transaction;
                              System: boolean;
                              RelationName: string;
                              ComputedCols: TStrings );
begin
  if ComputedCols = nil then
    Exit
  else
    ComputedCols.Clear;
  if Cn = nil then Exit;
  if Assigned( Cn ) then with TIB_SchemaCursor.Create( cn.IB_Session ) do try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add( 'SELECT R.RDB$FIELD_NAME' );
    SQL.Add( '     , R.RDB$RELATION_NAME' );
    SQL.Add( 'FROM RDB$RELATION_FIELDS R, RDB$FIELDS F' );
    SQL.Add( 'WHERE R.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME' );
    SQL.Add( '  AND F.RDB$COMPUTED_SOURCE IS NOT NULL' );
    if RelationName <> '' then
    SQL.Add( '  AND R.RDB$RELATION_NAME = ' + mkLitCriteria(
                                              stLitCriteria( RelationName ),
                                                             '''' ));
{ TODO : Use proper handling for detecting system settings. }
    if not System then
    SQL.Add( '  AND NOT R.RDB$RELATION_NAME STARTING WITH ''RDB$''' );
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    First;
    while not Eof do begin
      if RelationName = '' then
        ComputedCols.Add( Cn.mkVARIdent( Fields[ 0 ].AsString ) + ',' +
                          Cn.mkVARIdent( Fields[ 1 ].AsString ))
      else
        ComputedCols.Add( Cn.mkVARIdent( Fields[ 0 ].AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure SchemaDefaultedCols( Cn: TIB_Connection;
                               Tr: TIB_Transaction;
                               ASystem,
                               AIncludeValues: boolean;
                               RelationName: string;
                               DefaultedCols: TStrings );
var
  F_FIELDNAME: TIB_Column;
  F_RELATIONNAME: TIB_Column;
  F_DEFAULTSOURCE: TIB_Column;
  D_DEFAULTSOURCE: TIB_Column;
  D_FIELDTYPE: TIB_Column;
  FieldType: Word;
  DefaultValue: string;
  tmpExtended: extended;
  tmpDouble: double;
  tmpFloat: single;
begin
  if DefaultedCols = nil then
    Exit
  else
    DefaultedCols.Clear;
  if Assigned( Cn ) then
    with TIB_SchemaCursor.Create( cn.IB_Session ) do
      try
    if cn.SQLDialect < 3 then
      RelationName := UpperCase( RelationName );
    IB_Connection := Cn;
    IB_Transaction := Tr;
    SQL.Add('SELECT F.RDB$FIELD_NAME F_FieldName');
    SQL.Add('     , F.RDB$RELATION_NAME F_RelationName');
    if AIncludeValues then
    begin
    SQL.Add('     , F.RDB$DEFAULT_SOURCE F_DefaultSource');
    SQL.Add('     , D.RDB$DEFAULT_SOURCE D_DefaultSource');
    SQL.Add('     , D.RDB$FIELD_TYPE D_FieldType');
    end;
    SQL.Add('FROM RDB$RELATION_FIELDS F' );
    SQL.Add('INNER JOIN RDB$FIELDS D' );
    SQL.Add('  ON D.RDB$FIELD_NAME = F.RDB$FIELD_SOURCE');
    SQL.Add('WHERE (( F.RDB$DEFAULT_SOURCE IS NOT NULL ) OR ' +
                   '( D.RDB$DEFAULT_SOURCE IS NOT NULL ))');
    if not ASystem then
{ TODO : Use proper handling for detecting system settings. }
    SQL.Add( '  AND NOT F.RDB$RELATION_NAME STARTING WITH ''RDB$''' );
    if RelationName <> '' then
    SQL.Add( '  AND F.RDB$RELATION_NAME = ' + mkLitCriteria(
                                              stLitCriteria( RelationName ),
                                                             '''' ));
    SQL.Add( 'ORDER BY 1' );
    Prepare;
    F_FIELDNAME := FieldByName('F_FIELDNAME');
    F_RELATIONNAME := FieldByName('F_RELATIONNAME');
    F_DEFAULTSOURCE := FindField('F_DEFAULTSOURCE');
    D_DEFAULTSOURCE := FindField('D_DEFAULTSOURCE');
    D_FIELDTYPE := FindField('D_FIELDTYPE');
    First;
    while not Eof do
    begin
      if AIncludeValues then
      begin
        FieldType := D_FIELDTYPE.AsInteger;
        if not F_DEFAULTSOURCE.IsNull then
          DefaultValue := Trim( F_DEFAULTSOURCE.AsString )
        else
          DefaultValue := Trim( D_DEFAULTSOURCE.AsString );
        DefaultValue := Trim( TrimLeftPrevOrdChar( DefaultValue,
                                                   Char( Ord(' ') + 1 )));
        DefaultValue := TrimLeftPrevOrdChar( DefaultValue,
                                             Char( Ord(' ') + 1 ));
        if UpperCase( Copy( DefaultValue, 1, 7 )) = 'DEFAULT' then
          DefaultValue := Trim( Copy( DefaultValue, 8, maxint ))
        else
          DefaultValue := '';
        if (DefaultValue <> '')
          And (DefaultValue <> 'NULL') then
        case FieldType of
          blr_sql_date, // DATE (Dialect 3)
          blr_sql_time, // TIME (Dialect 3)
          blr_timestamp: // DATE (Dialect 1) / TIMESTAMP (Dialect 3)
            DefaultValue := stLitCriteria( DefaultValue );
          blr_text,
          blr_text2,
          blr_cstring,
          blr_cstring2,
          blr_varying,
          blr_varying2:
            if isLitCriteria( DefaultValue, '''' ) or
               isLitCriteria( DefaultValue, '"' ) then
              DefaultValue := stLitCriteria( DefaultValue )
            else
            // How to handle things like USER, CURRENT_USER, etc.?
              DefaultValue := '';  // Just to be safe for now!!!
          blr_short,
          blr_long,
          blr_quad,
          blr_int64: ;
          blr_float: // FLOAT
          begin
            if isLitCriteria( DefaultValue, '''' ) or
               isLitCriteria( DefaultValue, '"' ) then
              DefaultValue := stLitCriteria( DefaultValue );
            if DecimalSeparator <> '.' then
              swap_chars( DefaultValue, '.', DecimalSeparator );
            try
              tmpExtended := StrToFloat(DefaultValue);
              tmpFloat := tmpExtended;
              if FormatFloat('#.######E-0', tmpFloat) =
                 FormatFloat('#.######E-0', tmpExtended) then
                DefaultValue := FloatToStr(tmpExtended)
              else
                DefaultValue := '';
            except
              DefaultValue := '';
            end;
          end;
          blr_d_float, // D_FLOAT
          blr_double: // DOUBLE
          begin
            if isLitCriteria( DefaultValue, '''' ) or
               isLitCriteria( DefaultValue, '"' ) then
              DefaultValue := stLitCriteria( DefaultValue );
            if DecimalSeparator <> '.' then
              swap_chars( DefaultValue, '.', DecimalSeparator );
            try
              tmpExtended := StrToFloat( DefaultValue );
              tmpDouble := tmpExtended;
              if FormatFloat( '#.##############E-0', tmpDouble) =
                 FormatFloat( '#.##############E-0', tmpExtended ) then
                DefaultValue := FloatToStr( tmpDouble )
              else
                DefaultValue := '';
            except
              DefaultValue := '';
            end;
          end;
          blr_blob: // BLOB
            DefaultValue := '';
          {blr_blob_id = 45;}
        end;
        DefaultedCols.Add( Cn.mkVARIdent( F_RELATIONNAME.AsString ) + '.' +
                           Cn.mkVARIdent( F_FIELDNAME.AsString ) +
                           '=' + DefaultValue )
      end
      else
        DefaultedCols.Add( Cn.mkVARIdent( F_RELATIONNAME.AsString ) + '.' +
                           Cn.mkVARIdent( F_FIELDNAME.AsString ));
      Next;
    end;
  finally
    Free;
  end;
end;

function GetGeneratorValue(     Cn: TIB_Connection;
                                Tr: TIB_Transaction;
                                GeneratorName: string;
                                Increment: longint;
                            var GeneratorValue: ISC_INT64 ): boolean;
var
  POut_DA: PXSQLDA;
  GeneratorSQL: string;
  nullind: smallint;
  tmpInt: integer;
  tmpVal: ISC_INT64;
begin
  Result := false;
  GeneratorValue := -1;
  if Assigned( cn ) then
  try
    if not Assigned( Tr ) then
      Tr := Cn.SchemaCache.Transaction;
    with TIB_DSQL.Create( cn.IB_Session ) do
      try
        RetrieveDomainNames := false;
        IB_Connection := Cn;
        IB_Transaction := Tr;
        CheckTransaction( true );
        GetMem( POut_DA, XSQLDA_LENGTH( 1 ));
        try
          with POut_DA^ do
          begin
            version := SQLDA_VERSION1;
            sqln := 1;
            sqld := 1;
            with sqlvar[ 0 ] do
            begin
              if ( Cn.SQLDialect >= 3 ) or
                 ( Cn.Characteristics.dbODS_Version >= 10 ) then
              begin
                sqltype  := SQL_INT64;
                sqllen   := 8;
                sqldata  := @tmpVal;
              end
              else
              begin
                sqltype  := SQL_LONG;
                sqllen   := 4;
                sqldata  := @tmpInt;
              end;
              sqlscale := 0;
              sqlind := @nullind;
              relname := '';
              relname_length := 0;
              sqlname := '';
              sqlname_length := 0;
              aliasname := 'GEN_ID';
              aliasname_length := 6;
              ownname := '';
              ownname_length := 0;
            end;
          end;
          GeneratorSQL := 'SELECT GEN_ID ( ' +
                          GeneratorName + ', ' +
                          IntToStr( Increment ) + ' )'#13#10 +
                          'FROM RDB$DATABASE';
          ExecImmed2( GeneratorSQL, nil, POut_DA );
        finally
          FreeMem( POut_DA );
          if Assigned( Tr ) then
            Tr.CheckOat;
        end;
      finally
        Free;
      end;
    Result := true;
  except
    // Throw away the exception of a generator not found.
  end;
  if ( Cn.SQLDialect >= 3 ) or
     ( Cn.Characteristics.dbODS_Version >= 10 ) then
    GeneratorValue := tmpVal
  else
    GeneratorValue := tmpInt;
end;

procedure SchemaIndexDefinitions( Cn: TIB_Connection;
                                  Tr: TIB_Transaction;
                                  SystemTables: boolean;
                                  Definitions: TStrings );
var
  crIndexDefs: TIB_SchemaCursor;
  crIndexSegs: TIB_SchemaCursor;
  INDEX_NAME: TIB_Column;
  UNIQUE_FLAG: TIB_Column;
  INDEX_TYPE: TIB_Column;
  FIELD_NAME: TIB_Column;
  REL_NAME: TIB_Column;
  CNST_NAME: TIB_Column;
  FGN_KEY: TIB_Column;
  UR: TIB_Column;
  DR: TIB_Column;
  tmpStr: string;
  s: string;
begin
  Definitions.Clear;
  crIndexDefs := TIB_SchemaCursor.Create( cn.IB_Session );
  crIndexSegs := TIB_SchemaCursor.Create( cn.IB_Session );
  Definitions.BeginUpdate;
  try
{
CREATE TABLE RDB$REF_CONSTRAINTS (
  RDB$CONSTRAINT_NAME    CHAR( 31 )
, RDB$CONST_NAME_UQ      CHAR( 31 )
, RDB$MATCH_OPTION       CHAR( 7 )
, RDB$UPDATE_RULE        CHAR( 11 )
, RDB$DELETE_RULE        CHAR( 11 )
)
}
    with crIndexSegs do begin
      IB_Connection := cn;
      IB_Transaction := tr;
      SQL.Add( 'SELECT RDB$FIELD_NAME' );
      SQL.Add( 'FROM RDB$INDEX_SEGMENTS' );
      SQL.Add( 'WHERE RDB$INDEX_NAME = ?Name' );
      SQL.Add( 'ORDER BY RDB$FIELD_POSITION' );
      Prepare;
      FIELD_NAME := FieldByName( 'RDB$FIELD_NAME' );
    end;
    with crIndexDefs do begin
      IB_Connection := cn;
      IB_Transaction := tr;
      SQL.Add( 'SELECT I.RDB$RELATION_NAME' );
      SQL.Add( '     , I.RDB$INDEX_NAME' );
      SQL.Add( '     , I.RDB$UNIQUE_FLAG' );
      SQL.Add( '     , I.RDB$INDEX_TYPE' );
      SQL.Add( '     , I.RDB$FOREIGN_KEY' );
      SQL.Add( '     , ( SELECT C.RDB$CONSTRAINT_NAME' );
      SQL.Add( '         FROM RDB$RELATION_CONSTRAINTS C' );
      SQL.Add( '         WHERE C.RDB$INDEX_NAME = I.RDB$INDEX_NAME ) AS CNST' );
      SQL.Add( '     , ( SELECT R.RDB$UPDATE_RULE' );
      SQL.Add( '         FROM RDB$REF_CONSTRAINTS R' );
      SQL.Add( '         WHERE R.RDB$CONSTRAINT_NAME = ' );
      SQL.Add( '       ( SELECT C.RDB$CONSTRAINT_NAME' );
      SQL.Add( '         FROM RDB$RELATION_CONSTRAINTS C' );
      SQL.Add( '         WHERE C.RDB$INDEX_NAME = I.RDB$INDEX_NAME )) AS UR' );
      SQL.Add( '     , ( SELECT R.RDB$DELETE_RULE' );
      SQL.Add( '         FROM RDB$REF_CONSTRAINTS R' );
      SQL.Add( '         WHERE R.RDB$CONSTRAINT_NAME = ' );
      SQL.Add( '       ( SELECT C.RDB$CONSTRAINT_NAME' );
      SQL.Add( '         FROM RDB$RELATION_CONSTRAINTS C' );
      SQL.Add( '         WHERE C.RDB$INDEX_NAME = I.RDB$INDEX_NAME )) AS DR' );
      SQL.Add( 'FROM RDB$INDICES I' );
      if not SystemTables then
      begin
{ TODO : Use proper handling for detecting system settings. }
      SQL.Add( 'WHERE NOT I.RDB$RELATION_NAME STARTING WITH ''RDB$''' );
      end;
      Prepare;
      REL_NAME := FieldByName( 'RDB$RELATION_NAME' );
      INDEX_NAME := FieldByName( 'RDB$INDEX_NAME' );
      UNIQUE_FLAG := FieldByName( 'RDB$UNIQUE_FLAG' );
      INDEX_TYPE := FieldByName( 'RDB$INDEX_TYPE' );
      CNST_NAME := FieldByName( 'CNST' );
      FGN_KEY := FieldByName( 'RDB$FOREIGN_KEY' );
      UR := FieldByName( 'UR' );
      DR := FieldByName( 'DR' );
      First;
      while not EOF do
      begin
        tmpStr := IB_Connection.mkVARIdent( INDEX_NAME.AsString ) + '=';
        if Pos ( 'RDB$PRIMARY', tmpStr ) = 1 then
          tmpStr := tmpStr + 'PK;'
        else
        if UNIQUE_FLAG.AsInteger = 1 then
          tmpStr := tmpStr + 'UN;';
        if INDEX_TYPE.AsInteger = 1  then
          tmpStr := tmpStr + 'DESC;';
        tmpStr := tmpStr + 'REL=' +
                           IB_Connection.mkVARIdent( REL_NAME.AsString ) + ';';
        if CNST_NAME.AsString <> EmptyStr then
          tmpStr := tmpStr + 'CNST=' +
                           IB_Connection.mkVARIdent( CNST_NAME.AsString ) + ';';
        if FGN_KEY.AsString <> EmptyStr then
        begin
          tmpStr := tmpStr + 'FK=' +
                             IB_Connection.mkVARIdent( FGN_KEY.AsString ) + ';';
          if ( UR.AsString <> '' ) and
             ( UR.AsString <> 'RESTRICT' ) then
            tmpStr := tmpStr + 'UR=' +
                               IB_Connection.mkVARIdent( UR.AsString ) + ';';
          if ( DR.AsString <> EmptyStr ) and
             ( DR.AsString <> 'RESTRICT' ) then
            tmpStr := tmpStr + 'DR=' +
                               IB_Connection.mkVARIdent( DR.AsString ) + ';';
        end;
        crIndexSegs.Params[0].AsString := INDEX_NAME.AsString;
        crIndexSegs.First;
        while not crIndexSegs.EOF do
        begin
          s := IB_Connection.mkVARIdent( FIELD_NAME.AsString );
          if crIndexSegs.RowNum = 1 then tmpStr := tmpStr + 'SEGS=' + s
                                    else tmpStr := tmpStr + ','     + s;
          crIndexSegs.Next;
        end;
        crIndexSegs.Close;
        Definitions.Add( tmpStr );
        Next;
      end;
      Close;
    end;
  finally
    Definitions.EndUpdate;
    crIndexDefs.Free;
    crIndexSegs.Free;
  end;
end;

end.
