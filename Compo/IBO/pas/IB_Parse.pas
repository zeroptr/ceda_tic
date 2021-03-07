
{                                                                              }
{ IB_Parse                                                                     }
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
{  Jason Wharton <jwharton@ibobjects.com>                                      }
{  06-Jun-2003                                                                 }
{     Optimized and simplified Daniel's corrections                            }
{                                                                              }
{  Daniel Rail <daniel@accra.ca>                                               }
{  24-Apr-2003                                                                 }
{     Made some corrections in the procedure GetSQLFirstAndSkip, so that the   }
{     field names and parameters that contain the keywords FIRST and SKIP are  }
{     recognized properly.                                                     }
{                                                                              }
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  10-Feb-02                                                                   }
{     TrimLeftPrevOrdChar added                                                }
{                                                                              }
{ Dirk Schiffler <ds@rcs.de>                                                   }
{ 11/11/2001                                                                   }
{    in function get_IBDateLiteral I set the solid format 'MM"/"dd"/"yyyy' to  }
{    constant declared in IB_Constants                                         }
{                                                                              }
{  Marco Menardi <mmenaz@lycosmail.com>                                        }
{  03-Nov-01                                                                   }
{      Somewhere strip_chars_xxx functions are used like AStr: were a variable }
{      parameter, not a constant one                                           }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_Parse;

interface

uses
  SysUtils, Classes,

  IB_Constants,
  IB_Header,
  IB_Session,
  IB_Components;

const
  ParseLineBegin = 1;
  ParseLineEnd = 0;
  ParseLineInvalid = 0;
  ParseLineAbsent = -1;

  CharDelimiter = '\';
  HighCharDelimiter = '#';

type
  TWordProc = procedure( var str: string );
  TSubMacroProc = function ( const ATextBlock: string ): string of object;

function SubstMacros( const AStr: string;
                            GetMacroProc: TSubMacroProc;
                            BeginChar, EndChar: string ): string;
function SQLTypesEqual( AType1, AType2: integer ): boolean;
function GetBuffer( PSQLVAR: PXSQLVAR ): string;
function GetParamBuffers( PSQLDA: PXSQLDA; ShowOwner: boolean ): string;
procedure SetXSQLVAR( const AVarDef: string;
                            ASQLDialect: integer;
                        var AXSQLVAR: XSQLVAR );

function ParseStr( const AString: string;
                   const KeyWord: string;
                         IsFirstToken: boolean;
                         TermKeys: array of PChar;
                     var BegPos,
                         EndPos: longint;
                     var TermKeyWord: string;
                         IsPureToken,
                         IsDblToken: boolean ): boolean;

function PadRight( const InStr: string;
                         PadCh: char;
                         LenStr: integer;
                         Trim: boolean ): string;
function PadLeft( const InStr: string;
                        PadCh: char;
                        LenStr: integer;
                        Trim: boolean ): string;
procedure RTrim( var AString: string );

function TrimLeftPrevOrdChar( const InStr: string; AFirstOk: char ): string;

function GetSQLFirstAndSkip( const SQL: string): string;
procedure SetSQLSelect   ( var   SQL:          string;
                           const SQLSelect:    string );
procedure GetSQLSelect   ( const SQL:          string;
                           var   SQLSelect:    string;
                           var   BegPos, EndPos: longint );
procedure SetSQLFrom     ( var   SQL:          string;
                           const SQLFrom:      string );
procedure GetSQLFrom     ( const SQL:          string;
                           var   SQLFrom:      string;
                           var   BegPos, EndPos: longint );
procedure SetSQLWhere    ( var   SQL:          string;
                           const SQLWhere:     string );
procedure GetSQLWhere    ( const SQL:          string;
                           var   SQLWhere:     string;
                           var   BegPos, EndPos: longint );
procedure SetSQLGroup    ( var   SQL:          string;
                           const SQLGroup:     string );
procedure GetSQLGroup    ( const SQL:          string;
                           var   SQLGroup:     string;
                           var   BegPos, EndPos: longint );
procedure SetSQLHaving   ( var   SQL:          string;
                           const SQLHaving:    string );
procedure GetSQLHaving   ( const SQL:          string;
                           var   SQLHaving:    string;
                           var   BegPos, EndPos: longint );
procedure SetSQLUnion    ( var   SQL:          string;
                           const SQLUnion:     string );
procedure GetSQLUnion    ( const SQL:          string;
                           var   SQLUnion:     string;
                           var   BegPos, EndPos: longint );
procedure SetSQLPlan     ( var   SQL:          string;
                           const SQLPlan:      string );
procedure GetSQLPlan     ( const SQL:          string;
                           var   SQLPlan:      string;
                           var   BegPos, EndPos: longint );
procedure SetSQLOrder    ( var   SQL:          string;
                           const SQLOrder:     string );
procedure GetSQLOrder    ( const SQL:          string;
                           var   SQLOrder:     string;
                           var   BegPos, EndPos: longint );
procedure SetSQLForUpdate( var   SQL:          string;
                           const SQLForUpdate: string );
procedure GetSQLForUpdate( const SQL: string;
                           var   SQLForUpdate: string;
                           var   BegPos, EndPos: longint );
procedure GetSQLForUpdateColumns( const SQL: string;
                                        SQLForUpdateColumns: TStrings );

function IsTriggerOrProcedureDDL( const SQL: string ): boolean;
function IsSQLInsertInto( SQL: string ): boolean;
function IsSQLGrantRevokeSelect( SQL: string ): boolean;
procedure ExtractMacroDefs( const SQL: string;
                            const NewMacroDefs: TStrings;
                                  MacroChar: char );

function ReplaceMacro( const SQL: string;
                       const MacroName,
                             MacroType,
                             MacroValue: string;
                             MacroChar: char ): string;

function StripComments( const ASQL: string ): string;
function StripLitsAndRounds( const AStr: string;
                                   SQLDialect: integer ): string;
function MakeServerSQL(       ClientSQL: string;
                        const Params,
                              Fields,
                              Tables: TStrings;
                        var   ServerSQL: string;
                              ParamChar: char;
                              Comments: boolean;
                        var   CommentLen: longint ): integer;
procedure MakeClientSQL( const ServerSQL: string;
                         var   ClientSQL: string;
                               ParamChar: char );

function isLitCriteria( const AStr: string; lit: char ): Boolean;
function cvLitCriteria( const str: string; ch: char ): string;
function mkLitCriteria( const str: string; ch: char ): string;
function mkIdent(       SQLDialect: integer;
                        ODSMajor, ODSMinor: word;
                  const Identifier: string ): string;
function mkVARIdent(       SQLDialect: integer;
                           ODSMajor, ODSMinor: word;
                     const Identifier: string ): string;
function mkFldLst(       SQLDialect: integer;
                         ODSMajor, ODSMinor: word;
                   const AValue: string): string;
function exIdent(       SQLDialect: integer;
                        ODSMajor, ODSMinor: word;
                  const Identifier: string ): string;
function stLitCriteria( const str: string ): string;
function getLitSafePos(       Ch: char;
                        const AStr: string;
                              StartPos: integer ): integer;
function getLitsRoundSafePos(       Ch: char;
                              const AStr: string;
                                    StartPos: integer ): integer;
function getLitSafePosFromRight(       Ch: char;
                                 const AStr: string;
                                       StartPos: integer;
                                       PassPureTokenOnly: boolean ): integer;
function getLitSafeStrPos( const S: string;
                           const AStr: string;
                                 StartPos: integer ): integer;
function getLitsRoundSafeStrPos(       S: string;
                                 const AStr: string;
                                       StartPos: integer;
                                       IgnoreComments,
                                       TokenOnly: boolean ): integer;
function contains_wildcards( const str: string; escape: char ): Boolean;
function contains_sqlwildcards( const str: string; escape: char ): Boolean;
function convert_wildcards_tosql( const str: string; escape: char ): string;
function strip_escapechar( const str: string; escape: char ): string;
function beginswith_sqllike( const str: string ): Boolean;
function beginswith_sqlsearch( const str: string ): Boolean;
function contains_relational_ops( const str: string ): Boolean;
function rel_op_pos( const str: string ): longint;
function get_00AM: string;
function get_12PM: string;
function get_IBDateLiteral( ADateTime: TDateTime ): string;
function get_IBDateSLiteral( const ADateTime: string;
                                   IncDays: integer ): string;
function get_DateLength( const Text: string ): longint;
function get_HasTime( const Text: string ): boolean;
function get_IBNumericLiteral( const ANumeric: string ): string;
function CharIsDelimiter( Pos: Char ): Boolean;
function strip_char( const AStr: string; AChar: char ): string;
function strip_chars_beg( const AStr: string; AChar: string ): string;
function strip_chars_end( const AStr: string; AChar: string ): string;
procedure parse_word_proc( var wd: string );
procedure parse_word_list( const AWords: string;
                                 MaxWordLen: integer;
                                 AWordList: TStrings );
procedure swap_chars(   var AStr: string;
                        const ACharVals: string;
                              NewChar: char );
procedure replace_string(   var AStr: string;
                          const ATarget, AReplaceText: string );
function replicate_char( AChar: char; ACnt: integer ): string;
function SupplySingleCharDots( const AStr: string ): string;
procedure ExtractWhereClause( IB_Field: TIB_Column;
                              SearchBuffer: string;
                              WhereClause,
                              Parameters,
                              Macros: TStrings );
procedure ExtractFilterClause( BDataset: TIB_BDataset;
                               WhereClause,
                               Parameters: TStrings );
procedure MakeCountSQL( const SQL: string; var CountSQL: string );
function MakeLookupSQL( const SQL: string;
                        const SQLSelect: string;
                        const KeyLinks: TIB_StringList;
                          var LookupSQL: string;
                          var SelectParamCount: integer ): integer;

procedure AddWhereClause( var   SQLWhere: string;
                                WhereClause: string );

procedure AddWhereClauseHigh( var   SQLWhere: string;
                                    WhereClause: string );

function GetNextScriptStatement( const Script: string;
                                 var   Statement, SetItem, SetValue: string;
                                 var   BegPos,
                                       EndPos: longint;
                                 var   TermKeyWord: string ): boolean;

function ExtractDBProp( const Statement,
                              DBProp: string;
                              StmtTypes: array of PChar;
                          var StmtType,
                              DBPropVal: string ): boolean;
function SetConnectionProperties(     ACon: TIB_Connection;
                                      AStmt: string;
                                  var StmtType: string ): boolean;

function GetStoredProcedureSource( SP_Alter: boolean;
                                   SP_Name: string;
                                   SP_DSQL: TIB_Statement;
                                   SP_Body: string ): string;

procedure GetMergeFields( const MemoText: string;
                          const MergeFields: TStrings );

function ExtractFieldName(const Fields: string; var Pos: integer): string;
procedure ExtractFieldsIntoList( FieldNames: string;
                                 Links: TStrings );
procedure SubStrings( const Source: string;
                      var   Dest: string;
                            BegPos: longint;
                            EndPos: longint );
function SetCharValues( AString: string ): string;
function GetCharValues( AString: string ): string;

procedure ExtractListLinkParam(     AStr, AParam: string;
                                var BegPos, EndPos: longint;
                                var Value: string );

procedure ExtractStoredProcedure(       SQL: string;
                                  var   StoredProcName: string;
                                  const ParamNames: TStrings;
                                        ParamChar: char );

{: Method that will strip out a parameter entry in a string that represents
the value portion of a link entry.}
procedure RemoveListLinkParam( var AString: string; AParam: string );
{: Method that will set a parameter entry in a string that represents
the value portion of a link entry.}
function SetListLinkParamValue( var AString: string;
                                    AParam, AValue: string ): boolean;
{: Method that will set a parameter entry in a string that represents
the value portion of a link entry. }
function SetListLinkParamIsSet( var AString: string;
                                    AParam: string;
                                    AIsSet: boolean ): boolean;

function ExtractColSourceFromBLR( BLRCode,
                                  CharLen,
                                  Scale,
                                  SegLen,
                                  SegSubType,
                                  Precision,
                                  SQLDialect: integer ): string;

implementation

uses
  IB_Utils, Windows;

const
  IB_UnassignedCol = '<NIL>';
  IB_NullCol = '<NULL>';

function SubstMacros( const AStr: string;
                            GetMacroProc: TSubMacroProc;
                            BeginChar, EndChar: string ): string;
var
  curFldName: string;
  ii: integer;
  fldFnd: boolean;
  txtLen: integer;
  inQuotes: char;
  tmpStr: string;
begin
  Result := '';
  if not Assigned( GetMacroProc ) then
    Exit;
  fldFnd := false;
  inQuotes := #0;
  txtLen := Length( AStr );
  curFldName := '';
  ii := 1;
  while ii <= txtLen do
  begin
    if fldFnd then
    begin
      if inQuotes <> #0 then // if inside quotes accept any character
      begin
        if AStr[ii] = inQuotes then // turn off quotes when find matching
          inQuotes := #0;
        curFldName := curFldName + AStr[ii];
      end
      else
      if AStr[ii] in ['"'{,#39}] then // turn on quotes if quote found
      begin
        inQuotes := AStr[ii];
        curFldName := curFldName + AStr[ii];
      end
      else
      begin
        if ( ii < txtLen ) and
           ( Copy( AStr, ii, Length( EndChar )) = EndChar ) then
        begin
          Inc( ii );
          tmpStr := GetMacroProc( curFldName );
          Result := Result + SubstMacros( tmpStr,
                                          GetMacroProc, BeginChar, EndChar );
          fldFnd := false;
        end
        else
        if AStr[ii] in [ 'A'..'Z', 'a'..'z', '0'..'9', '_', '.' ] then
          curFldName := curFldName + AStr[ii]
        else
        begin
          fldFnd := false;
          Result := Result + BeginChar + BeginChar + curFldName;
          curFldName := '';
          Continue;
        end;
      end;
    end
    else
    if ( inQuotes = #0 ) and  // only detect macro if not inside quotes
       ( ii < txtLen ) and
       ( Copy( AStr, ii, Length( BeginChar )) = BeginChar ) then
    begin
      fldFnd := true;
      Inc( ii );
      curFldName := '';
    end
    else
    begin
      if (inQuotes <> #0) and (AStr[ii] = inQuotes) then
        inQuotes := #0
      else
      if (inQuotes = #0) and (AStr[ii] in ['"'{,#39}]) then
        inQuotes := AStr[ii];
      Result := Result + AStr[ii];
    end;
    Inc( ii );
  end;
end;

function SQLTypesEqual( AType1, AType2: integer ): boolean;
begin
  AType1 := AType1 - AType1 mod 2;
  AType2 := AType2 - AType2 mod 2;
  Result := AType1 = AType2;
  if not Result then
  begin
    if AType1 = SQL_SHORT then AType1 := SQL_LONG;
    if AType2 = SQL_SHORT then AType2 := SQL_LONG;
//  if AType1 = SQL_VARYING then AType1 := SQL_TEXT;
//  if AType2 = SQL_VARYING then AType2 := SQL_TEXT;
    if AType1 = SQL_DOUBLE then AType1 := SQL_FLOAT;
    if AType2 = SQL_DOUBLE then AType2 := SQL_FLOAT;
    Result := AType1 = AType2;
  end;
end;

{------------------------------------------------------------------------------}

function GetNumericBuffer( PSQLVAR: PXSQLVAR ): string;
var
  ii: smallint;
  tmpVal: extended;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then
    begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else case SQLType of
      SQL_DOUBLE,
      SQL_DOUBLE_: Result := FloatToStr(double(SQLDATA^));
      SQL_FLOAT,
      SQL_FLOAT_: Result := FloatToStr(single(SQLDATA^));
      else begin
        case SQLTYPE of
          SQL_SHORT,
          SQL_SHORT_:  tmpVal := smallint(SQLDATA^);
          SQL_LONG,
          SQL_LONG_:   tmpVal := integer(SQLDATA^);
          SQL_QUAD,
          SQL_QUAD_,
          SQL_INT64,
          SQL_INT64_:
{$IFDEF IBO_VCL40_OR_GREATER}
            tmpVal := int64(SQLDATA^);
{$ELSE}
            tmpVal := comp(SQLDATA^);
{$ENDIF}
          else raise Exception.Create( 'Unsupported column type' );
        end;
        ii := 0;
        while ii < -SQLSCALE do
        begin
          tmpVal := tmpVal / 10;
          Inc( ii );
        end;
        Result := FloatToStr( tmpVal );
      end;
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetFloatBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      Result := FloatToStr( single(SQLDATA^));
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetDoubleBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      Result := FloatToStr( double(SQLDATA^));
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetSmallintBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      Result := IntToStr( smallint(SQLDATA^));
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetBooleanBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      if PShort(SQLDATA)^ = ISC_TRUE then
        Result := 'TRUE'
      else
      if PShort(SQLDATA)^ = ISC_FALSE then
        Result := 'FALSE'
      else
        Result := 'Undefined';
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetIntegerBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      Result := IntToStr( integer(SQLDATA^));
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetInt64Buffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
{$IFDEF IBO_VCL40_OR_GREATER}
      Result := IntToStr( int64(SQLDATA^));
{$ELSE}
      Result := FloatToStrF( comp(SQLDATA^), ffNumber, 18, 0 );
{$ENDIF}
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetDateTimeBuffer( PSQLVAR: PXSQLVAR ): string;
var
  tmpInt: integer;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      case SQLType of
        SQL_TIMESTAMP,
        SQL_TIMESTAMP_: begin
          Result := FormatDateTime( 'dd mmm yyyy',
                                  isc_decode_TDateTime( pisc_quad( SQLDATA )));
          with pisc_quad( SQLDATA )^ do begin
            if isc_quad_low > 0 then begin
              tmpInt := ( isc_quad_low div ( 10000 * 60 * 60 ));
              Result := Result + ' ' + FormatFloat( '00', tmpInt );
              tmpInt := ( isc_quad_low div ( 10000 * 60 )) mod 60;
              Result := Result + ':' + FormatFloat( '00', tmpInt );
              tmpInt := ( isc_quad_low div ( 10000 )) mod 60 mod 60;
              Result := Result + ':' + FormatFloat( '00', tmpInt );
              tmpInt := ( isc_quad_low mod ( 10000 ));
              if tmpInt > 0 then begin
                Result := Result + ' ' + FormatFloat( '0000', tmpInt );
              end;
            end;
          end;
        end;
        SQL_TYPE_DATE,
        SQL_TYPE_DATE_: begin
          Result := FormatDateTime( 'dd mmm yyyy',
                                    pisc_date( SQLDATA )^ - 15018 );
        end;
        SQL_TYPE_TIME,
        SQL_TYPE_TIME_: begin
          tmpInt := ( pisc_time( SQLDATA )^ div ( 10000 * 60 * 60 ));
          Result := FormatFloat( '00', tmpInt );
          tmpInt := ( pisc_time( SQLDATA )^ div ( 10000 * 60 )) mod 60;
          Result := Result + ':' + FormatFloat( '00', tmpInt );
          tmpInt := ( pisc_time( SQLDATA )^ div ( 10000 )) mod 60 mod 60;
          Result := Result + ':' + FormatFloat( '00', tmpInt );
          tmpInt := ( pisc_time( SQLDATA )^ mod ( 10000 ));
          if tmpInt > 0 then begin
            Result := Result + ' ' + FormatFloat( '0000', tmpInt );
          end;
        end;
      end;
      Result := '''' + Result + '''';
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetTextBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end
    else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      Result := mkLitCriteria( Copy(Pchar(SQLDATA), 1, SQLLEN ), '''' );
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetVarTextBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      Result := Copy(Pchar(ptr(longint(SQLDATA)+2)), 1,
                     byte(SQLDATA^) + byte(ptr(longint(SQLDATA)+1)^) * 256 );
      Result := '''' + Result + '''';
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetHexBuffer( PSQLVAR: PXSQLVAR ): string;
var
  ii: smallint;
  tmpBuf: pbyte;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      Result := '$';
      tmpBuf := SQLDATA;
      for ii := 0 to SQLLen - 1 do begin
        if tmpBuf^ div 16 < 10 then begin
          Result := Result + Chr( Ord( '0' ) + tmpBuf^ div 16 );
        end else begin
          Result := Result + Chr( Ord( 'A' ) + tmpBuf^ div 16 - 10 );
        end;
        if tmpBuf^ mod 16 < 10 then begin
          Result := Result + Chr( Ord( '0' ) + tmpBuf^ mod 16 );
        end else begin
          Result := Result + Chr( Ord( 'A' ) + tmpBuf^ mod 16 - 10 );
        end;
         Inc( tmpBuf );
      end;
      if not Odd(SQLType) and (SQLIND <> nil) and (SQLIND^ = IB_NULL) then begin
        Result := '<n> ' + Result;
      end;
    end;
  end;
end;

function GetQUADBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then
    begin
      Result := IB_NullCol;
    end else if not Assigned( SQLDATA ) then begin
      Result := IB_UnassignedCol;
    end else begin
      Result := isc_quad_string( pisc_quad( SQLData )^ );
    end;
  end;
end;

function GetBuffer( PSQLVAR: PXSQLVAR ): string;
begin
  with PSQLVAR^ do
  begin
    if Odd( SQLType ) and ( SQLIND <> nil ) and ( SQLIND^ = IB_NULL ) then
      Result := IB_NullCol
    else
    if not Assigned( SQLDATA ) then
      Result := IB_UnassignedCol
    else
    if ( SQLScale <> 0 ) then
      Result := GetNumericBuffer( PSQLVAR )
    else
    case SQLtype of
      SQL_BOOLEAN,
      SQL_BOOLEAN_: Result := GetBooleanBuffer( PSQLVAR );
      SQL_FLOAT,
      SQL_FLOAT_: Result := GetFloatBuffer( PSQLVAR );
      SQL_DOUBLE,
      SQL_DOUBLE_: Result := GetDoubleBuffer( PSQLVAR );
      SQL_SHORT,
      SQL_SHORT_: Result := GetSmallintBuffer( PSQLVAR );
      SQL_LONG,
      SQL_LONG_: Result := GetIntegerBuffer( PSQLVAR );
      SQL_QUAD,
      SQL_QUAD_: Result := 'QUAD ' + GetQuadBuffer( PSQLVAR );
      SQL_INT64,
      SQL_INT64_: Result := GetInt64Buffer( PSQLVAR );
      SQL_TIMESTAMP,
      SQL_TIMESTAMP_,
      SQL_TYPE_DATE,
      SQL_TYPE_DATE_,
      SQL_TYPE_TIME,
      SQL_TYPE_TIME_: Result := GetDateTimeBuffer( PSQLVAR );
      SQL_TEXT,
      SQL_TEXT_:
        if ( CompareText( SQLName, 'DB_KEY' ) = 0 ) or
           ( CompareText( SQLName, 'RDB$DB_KEY' ) = 0 ) or
           ( CompareText( AliasName, 'DB_KEY' ) = 0 ) or
           ( CompareText( AliasName, 'RDB$DB_KEY' ) = 0 ) then
          Result := 'DB_KEY ' + GetHexBuffer( PSQLVAR )
        else
          Result := GetTextBuffer( PSQLVAR );
      SQL_VARYING,
      SQL_VARYING_: Result := GetVarTextBuffer( PSQLVAR );
      SQL_BLOB,
      SQL_BLOB_: Result := 'BLOB ID ' + GetQuadBuffer( PSQLVAR );
      SQL_ARRAY,
      SQL_ARRAY_: Result := 'ARRAY ID ' + GetQuadBuffer( PSQLVAR );
      else        Result := 'UNKNOWN ' + GetHexBuffer( PSQLVAR );
    end;
  end;
end;

function GetParamBuffers( PSQLDA: PXSQLDA; ShowOwner: boolean ): string;
var
  cnt: integer;
  kk: integer;
  tmpStr: string;
begin
  Result := '';
  if PSQLDA <> nil then with PSQLDA^ do
  begin
    Result := Result + ' Version ' + IntToStr( Version ) +
                       ' SQLd ' + IntToStr( SQLd ) +
                       ' SQLn ' + IntToStr( SQLn );
    if sqld > sqln then
    begin
      cnt := sqln;
    end
    else
    begin
      cnt := sqld;
    end;
    for kk := 0 to cnt - 1 do with SQLVar[kk] do
    begin
      if ShowOwner then
        tmpStr := mkIdent( 3, 0, 0, OwnName )
      else
        tmpStr := '';
      if RelName <> '' then
      begin
        if tmpStr <> '' then
          tmpStr := Trim( tmpStr ) + '.';
        tmpStr := tmpStr + mkIdent( 3, 0, 0, RelName );
      end;
      if SQLName <> '' then
      begin
        if tmpStr <> '' then
          tmpStr := Trim( tmpStr ) + '.';
        tmpStr := tmpStr + mkIdent( 3, 0, 0, SQLName );
      end;
      if AliasName <> '' then
      begin
        if AliasName <> SQLName then
        begin
          if ( SQLName = '' ) and ( tmpStr <> '' ) then
            tmpStr := Trim( tmpStr ) + '.';
          tmpStr := tmpStr + '[' + mkIdent( 3, 0, 0, AliasName ) + ']';
        end;
      end
      else
        if tmpStr = '' then
          tmpStr := '< SQLType: ' + IntToStr( SQLType ) +
                     ' SQLLen: ' + IntToStr( SQLLen ) +
                     ' >';

      Result := Result + #13#10'  ' +
//                         IntToStr( SQLType ) + ', ' +
//                         IntToStr( SQLLen ) + ', ' +
//                         IntToStr( SQLScale ) + ' ' +
                         tmpStr +
                         ' = ' +
                         GetBuffer( @SQLVAR[kk] );
    end;
  end;
end;

procedure SetXSQLVAR( const AVarDef: string;
                            ASQLDialect: integer; var AXSQLVAR: XSQLVAR );
var
  tmpVar, tmpStr: string;
  CurLit: string;
  tmpPos: integer;
  tmpPar: integer;
  procedure GetNextLit;
  begin
    tmpPos := getLitSafePos( ' ', tmpVar, 1 );
    tmpPar := getLitSafePos( '(', tmpVar, 1 );
    if ( tmpPar > 0 ) and (( tmpPos = 0 ) or ( tmpPos > tmpPar )) then begin
      tmpPos := tmpPar;
    end;
    if tmpPos > 0 then begin
      CurLit := Copy( tmpVar, 1, tmpPos - 1 );
      tmpVar := Trim( Copy( tmpVar, tmpPos, MaxInt ));
    end else begin
      CurLit := tmpVar;
      tmpVar := '';
    end;
  end;
  procedure GetNextNum;
  begin
    tmpPar := getLitSafePos( '(', tmpVar, 1 );
    if tmpPar > 0 then begin
      tmpVar := Copy( tmpVar, tmpPar + 1, MaxInt );
    end;
    tmpPos := getLitSafePos( ',', tmpVar, 1 );
    if tmpPos = 0 then begin
      tmpPos := getLitSafePos( ')', tmpVar, 1 );
    end;
    if tmpPos > 0 then begin
      CurLit := Trim( Copy( tmpVar, 1, tmpPos - 1 ));
      tmpVar := Trim( Copy( tmpVar, tmpPos + 1, MaxInt ));
    end else begin
      CurLit := '';
    end;
  end;
  function FixNameForDialect( tmpName: string ): string;
  begin
    if ASQLDialect < 3 then
      Result := AnsiUpperCase(tmpName)
    else
    begin
      if isLitCriteria( tmpName, '"' ) then
        Result := stLitCriteria(tmpName)
      else
        Result := AnsiUpperCase(tmpName);
    end;
  end;
begin
  tmpVar := Trim( AVarDef );//AnsiUpperCase( Trim( AVarDef ))
  tmpPos := getLitSafePos( '=', tmpVar, 1 );
  if tmpPos > 0 then
    tmpVar[ tmpPos ] := ' ';
  with AXSQLVAR do
  begin
    GetNextLit;
    tmpPos := getLitSafePos( '.', CurLit, 1 );
    tmpVar := AnsiUpperCase(tmpVar);
    if tmpPos = 0 then
    begin
      CurLit := FixNameForDialect( CurLit );
      relname_length := 0;
      StrLCopy( aliasname, PChar( CurLit ),
                SizeOf( TIB_Identifier ) - 1 );
      aliasname_length := Length( TrimRight( aliasname ));
      sqlname_length := 0;
    end
    else
    begin
      tmpStr := FixNameForDialect( Copy( CurLit, 1, tmpPos - 1 ) );
      StrLCopy( relname, PChar( tmpStr), SizeOf( TIB_Identifier ) - 1 );
      relname_length := Length( TrimRight( relname ));
      tmpStr := FixNameForDialect( Copy( CurLit, tmpPos + 1, MaxInt ) );
      StrLCopy( sqlname, PChar( tmpStr ), SizeOf( TIB_Identifier ) - 1 );
      sqlname_length := Length( TrimRight( sqlname ));
{ TODO : Also handle the case where an alias name is in square brackets. }
      StrLCopy( aliasname, PChar( Copy( CurLit, tmpPos + 1, MaxInt )),
                SizeOf( TIB_Identifier ) - 1 );
      aliasname_length := Length( TrimRight( aliasname ));
    end;
    ownname_length := 0;
    sqllen := 0;
    sqltype := 0;
    sqlscale := 0;
    sqlsubtype := 0;
    GetNextLit;
    if CurLit = 'FLOAT' then
    begin
      sqltype := SQL_FLOAT;
      sqllen := 4;
    end else if CurLit = 'DOUBLE' then
    begin
      GetNextLit;
      if CurLit = 'PRECISION' then
      begin
        sqltype := SQL_DOUBLE;
        sqllen := 8;
      end;
    end else if CurLit = 'SMALLINT' then
    begin
      sqltype := SQL_SHORT;
      sqllen := 2;
    end else if CurLit = 'INTEGER' then
    begin
      sqltype := SQL_LONG;
      sqllen := 4;
    end else if CurLit = 'DATE' then
    begin
      if ASQLDialect >= 3 then
      begin
        sqltype := SQL_TYPE_DATE;
        sqllen := 4;
      end else
      begin
        sqltype := SQL_TIMESTAMP;
        sqllen := 8;
      end;
    end else if CurLit = 'TIME' then
    begin
      sqltype := SQL_TYPE_TIME;
      sqllen := 4;
    end else if CurLit = 'TIMESTAMP' then
    begin
      sqltype := SQL_TIMESTAMP;
      sqllen := 8;
    end
    else
    if (( CurLit = 'CHAR' ) or
        ( CurLit = 'CHARACTER' )) and
       ( getLitSafeStrPos( 'VAR', tmpVar, 1 ) = 0 ) then
    begin
      sqltype := SQL_TEXT;
      GetNextNum;
      if CurLit <> '' then
        sqllen := StrToInt( CurLit )
      else
        sqllen := 256;
    end else if CurLit = 'VARCHAR' then
    begin
      sqltype := SQL_VARYING;
      GetNextNum;
      if CurLit <> '' then
        sqllen := StrToInt( CurLit )
      else
        sqllen := 256;
    end else if ( CurLit = 'DECIMAL' ) or
                ( CurLit = 'NUMERIC' ) then
    begin
      GetNextNum;
      if CurLit <> '' then
      begin
        sqllen := StrToInt( CurLit );
        case sqllen of
        0..4: begin
            sqltype := SQL_SHORT;
            sqllen := 2;
          end;
        5..9: begin
            sqltype := SQL_LONG;
            sqllen := 4;
          end
        else
          if ASQLDialect >= 3 then
          begin
            sqltype := SQL_INT64;
            sqllen := 8;
          end
          else
          begin
            sqltype := SQL_DOUBLE;
            sqllen := 8;
          end;
        end;
        GetNextNum;
        if CurLit <> '' then
        begin
          sqlscale := - StrToInt( CurLit );
        end else
        begin
          sqlscale := -2;
        end;
      end else
      begin
        sqllen := 4;
        sqlscale := -2;
        sqltype := SQL_LONG
      end;
    end
    else
    if CurLit = 'QUAD' then
    begin
      sqltype := SQL_QUAD;
      sqllen := 8;
    end
    else
    if CurLit = 'MEMO' then
    begin
      sqllen := 8;
      sqltype := SQL_BLOB;
      sqlsubtype := 1;
    end
    else
    if CurLit = 'BLOB' then
    begin
      sqllen := 8;
      sqltype := SQL_BLOB;
      sqlsubtype := 0;
//    Result := '( SUB_TYPE '      + IntToStr( blob_desc_subtype      ) +
//                    'SEGMENT SIZE '  + IntToStr( blob_desc_segment_size ) +
//                    'CHARACTER SET ' + IntToStr( blob_desc_charset      ) +
//                      ' )';
//    Result := 'BLOB( ' + IntToStr( blob_desc_segment_size ) + ', ' +
//                         IntToStr( blob_desc_subtype      ) + ' )';
    end;
{
SQL_D_FLOAT = 530;
SQL_ARRAY   = 540;
}
{
    sqltype:          smallint;
}
{
    sqlscale:         smallint;
    sqlsubtype:       smallint;
    sqllen:           smallint;
}
    if sqltype = 0 then
      raise Exception.Create( 'Invalid XSQLVAR Def string: ' + AVarDef );
  // Allow the nullibility to be defined.
    if ( getLitSafeStrPos( 'NOT ', tmpVar, 1 ) > 0 ) and
       ( getLitSafeStrPos( ' NULL', tmpVar, 1 ) > 0 ) then
    begin
    end
    else
      Inc( sqltype );
  end;
end;

function ExtractFieldName( const Fields: string; var Pos: integer ): string;
var
  ii: Integer;
begin
  if Pos = 0 then
    Pos := 1;
  ii := Pos;
  while (ii <= Length(Fields)) and
        (Fields[ii] <> ',') and
        (Fields[ii] <> ';') and
        (Fields[ii] <> #10) and
        (Fields[ii] <> #13) do Inc(ii);
  Result := Copy( Fields, Pos, ii - Pos );
  if (ii <= Length(Fields)) and (Fields[ii] = ',') then Inc(ii);
  if (ii <= Length(Fields)) and (Fields[ii] = ';') then Inc(ii);
  if (ii <= Length(Fields)) and (Fields[ii] = #10) then Inc(ii);
  if (ii <= Length(Fields)) and (Fields[ii] = #13) then Inc(ii);
  if (ii <= Length(Fields)) and (Fields[ii] = #10) then Inc(ii);
  if (ii <= Length(Fields)) and (Fields[ii] = #13) then Inc(ii);
  Pos := ii;
end;

procedure ExtractFieldsIntoList( FieldNames: string;
                                 Links: TStrings );
var
  ii: integer;
  tmpStr: string;
begin
  ii := 1;
  Links.BeginUpdate;
  try
    Links.Clear;
    repeat
      tmpStr := Trim( ExtractFieldName( FieldNames, ii ));
      if tmpStr <> '' then begin
        Links.Add( tmpStr );
      end;
    until tmpStr = '';
  finally
    Links.EndUpdate;
  end;
end;

procedure SubStrings( const Source: string;
                      var   Dest: string;
                            BegPos: longint;
                            EndPos: longint );
begin
  Dest := '';
  if ( BegPos <> ParseLineInvalid ) and
     ( BegPos <> ParseLineAbsent ) then
  begin
    if EndPos = ParseLineEnd then EndPos := MaxInt;
    if ( BegPos < EndPos ) then Dest := Copy( Source, BegPos, EndPos - BegPos );
  end;
end;

{------------------------------------------------------------------------------}

procedure StuffStrings( var Target: string;
                        const Source: string;
                              BegPos: longint;
                              EndPos: longint );
var
  Temp1: string;
  Temp2: string;
begin
  if BegPos <> ParseLineInvalid then begin
    SubStrings( Target, Temp1, ParseLineBegin, BegPos);
    Temp1 := Trim( Temp1 ) + #13#10;
  end else begin
    Temp1 := '';
  end;
  if EndPos <> ParseLineEnd then begin
    SubStrings( Target, Temp2, EndPos, ParseLineEnd );
  end else begin
    Temp2 := '';
  end;
  Target := Temp1 + Trim( Source ) + #13#10 + Trim( Temp2 );
end;

{------------------------------------------------------------------------------}

procedure UpdateState( const SQL: string;
                       var   CurPos: longint;
                       var   Literal1,
                             Literal2,
                             LineComment,
                             BlockComment: boolean;
                       var   RoundBracketLevel,
                             SquareBracketLevel,
                             SkipIncRequest: integer );
begin
  SkipIncRequest := 0;
  if LineComment then
  begin
    if SQL[ CurPos ] in [ #13, #10 ] then
      LineComment := false;
  end
  else
  if BlockComment then
  begin
    if ( SQL[ CurPos ] = '*' ) and
       ( CurPos < Length( SQL )) and
       ( SQL[ CurPos + 1 ] = '/' ) then
    begin
      BlockComment := false;
      SkipIncRequest := 1;
    end;
  end
  else
  if Literal1 then
  begin
    if SQL[ CurPos ] = '''' then
      Literal1 := false;
  end
  else
  if Literal2 then
  begin
    if SQL[ CurPos ] = '"' then
      Literal2 := false;
  end
  else
  if SQL[ CurPos ] = '''' then
  begin
    Literal1 := true;
  end
  else
  if SQL[ CurPos ] = '"' then
  begin
    Literal2 := true;
  end
  else
  if ( SQL[ CurPos ] = '/' ) and
     ( CurPos < Length( SQL )) and
     ( SQL[ CurPos + 1 ] = '/' ) then
  begin
    LineComment := true;
    SkipIncRequest := 1;
  end
  else
  if ( SQL[ CurPos ] = '/' ) and
     ( CurPos < Length( SQL )) and
     ( SQL[ CurPos + 1 ] = '*' ) then
  begin
    BlockComment := true;
    SkipIncRequest := 1;
  end
  else
  if SQL[ CurPos ] = '(' then
  begin
    if RoundBracketLevel >= 0 then
      Inc(RoundBracketLevel);
  end
  else
  if SQL[ CurPos ] = ')' then
  begin
    if RoundBracketLevel >= 0 then
      Dec(RoundBracketLevel);
  end
  else
  if SQL[ CurPos ] = '[' then
  begin
    if SquareBracketLevel >= 0 then
      Inc(SquareBracketLevel);
  end
  else
  if SQL[ CurPos ] = ']' then
  begin
    if SquareBracketLevel >= 0 then
      Dec(SquareBracketLevel);
  end;
end;

function SDelimiter(Pos: Char): Boolean;
begin
  Result := (( Ord( Pos ) <= Ord( ' ' ))) or ( Pos in [ '(', ')', ';' ] );
end;

function ParseStr2( const AString: string;
                    const KeyWord: string;
                          IsFirstToken: boolean;
                          TermKeys: array of PChar;
                      var BegPos,
                          EndPos,
                          LineNo: longint;
                      var TermKeyWord: string;
                          IsPureToken,
                          IsDblToken: boolean ): boolean;

var
  CurPos: longint;
  SectionFound: Boolean;

  function IsStrFound( AStr: string ): boolean;
  begin
    Result := ((SectionFound and ( IsPureToken or
               (( Length( AStr ) = 1 ) and SDelimiter( AStr[1] )))) or
               ((CurPos + Length(AStr) > EndPos ) or
                (SDelimiter( AString[ CurPos + Length(AStr) ] )))) and
              (CompareText( Copy( AString, CurPos, Length(AStr)), AStr ) = 0);
  end;

var
  Literal1: boolean;
  Literal2: boolean;
  BlockComment: boolean;
  LineComment: boolean;
  RoundBracketLevel: integer;
  SquareBracketLevel: integer;
  SkipIncRequest: integer;
  TermIsLiteral: boolean;
  TermHasSemicolon: boolean;

  procedure IncCurPos( Cnt: longint );
  begin
    Inc( CurPos, Cnt );
    UpdateState( AString,
                 CurPos,
                 Literal1,
                 Literal2,
                 LineComment,
                 BlockComment,
                 RoundBracketLevel,
                 SquareBracketLevel,
                 SkipIncRequest );
    Inc( CurPos, SkipIncRequest );
  end;

var
  SectionStr: array [0..31] of Char;
  ii: integer;

begin { ParseStr }
  Result := false;
  if Length( AString ) = 0 then
    Exit;
  if EndPos = ParseLineEnd then
    EndPos := Length( AString );
  if BegPos = ParseLineInvalid then
  begin
    CurPos := 1;
    LineNo := 1;
  end
  else
    CurPos := BegPos;
  StrPCopy(SectionStr, Keyword);
  if StrLen( SectionStr ) = 0 then
  begin
    SectionFound := true;
    BegPos := CurPos;
  end
  else
    SectionFound := false;
  Literal1 := false;
  Literal2 := false;
  BlockComment := false;
  LineComment := false;
  RoundBracketLevel := 0;
  SquareBracketLevel := 0;
  TermHasSemicolon := false;
  TermIsLiteral := false;
  for ii := 0 to High( TermKeys ) do
  begin
    if ( TermKeys[ii] = '(' ) or
       ( TermKeys[ii] = ')' ) then
      RoundBracketLevel := -1;
    if ( TermKeys[ii] = '[' ) or
       ( TermKeys[ii] = ']' ) then
      SquareBracketLevel := -1;
    if ( TermKeys[ii] = ';' ) then
      TermHasSemicolon := true;
    TermIsLiteral := TermIsLiteral or isLitCriteria( TermKeys[ii], ' ' );
  end;
  IncCurPos( 0 );
  repeat
    if ( LineComment or
         BlockComment or
         ( RoundBracketLevel > 0 ) or
         (( Literal1 or
            Literal2 ) and not ( TermIsLiteral and SectionFound ))) then
    else
    if (( CurPos = 1 ) or
        ( IsPureToken and SectionFound ) or
        ( SDelimiter( AString[ CurPos ] )) or
        ( SDelimiter( AString[ CurPos - 1 ] ))) then
    begin
      if not SectionFound then
      begin
        if IsStrFound( SectionStr ) then
        begin
          SectionFound := true;
          BegPos := CurPos;
          IncCurPos( StrLen( SectionStr ));
          Continue;
        end
        else
        if IsFirstToken and not SDelimiter( AString[ CurPos ] ) then
        begin
          Result := false;
          Exit;
        end
        else
        if TermHasSemicolon and ( AString[ CurPos ] = ';' ) then
        begin
          BegPos := CurPos;
          EndPos := CurPos;
          TermKeyWord := ';';
          Result := true;
          Exit;
        end;
      end
      else
      begin
        for ii := 0 to High( TermKeys ) do
          if IsStrFound( TermKeys[ii] ) then
          begin
            if StrLen( TermKeys[ii] ) > 0 then
            begin
              EndPos := CurPos;
              TermKeyWord := TermKeys[ii];
            end
            else
              Inc( EndPos ); // Put it one char past the end.
            Result := true;
            Exit;
          end;
        if IsDblToken and not SDelimiter( AString[ CurPos ] ) then
        begin
        // The second token of the pair was not found so ignore the first token.
          SectionFound := false;
        // Give it another chance to find the first token.
          Dec( CurPos );
        end;
      end;
    end;
    IncCurPos( 1 );
  until CurPos > EndPos;
  Inc( EndPos ); // Put it one char past the end.
end;

function ParseStr( const AString: string;
                   const KeyWord: string;
                         IsFirstToken: boolean;
                         TermKeys: array of PChar;
                     var BegPos,
                         EndPos: longint;
                     var TermKeyWord: string;
                         IsPureToken,
                         IsDblToken: boolean ): boolean;
var
  LineNo: longint;
begin
  Result := ParseStr2(  AString,
                        KeyWord,
                        IsFirstToken,
                        TermKeys,
                        BegPos,
                        EndPos,
                        LineNo,
                        TermKeyWord,
                        IsPureToken,
                        IsDblToken );
end;

function GetNextLiteral(     AString: string;
                             BegPos,
                             EndPos: longint;
                         var LiteralString: string ): boolean;
var
  CurPos: longint;
  Literal1: boolean;
  Literal2: boolean;
  BlockComment: boolean;
  LineComment: boolean;
  RoundBracketLevel: integer;
  SquareBracketLevel: integer;
  SkipIncRequest: integer;
  SectionFound: boolean;
begin
  Result := false;
  if Length( AString ) = 0 then
    Exit;
  if EndPos = ParseLineEnd then
    EndPos := Length( AString );
  if BegPos = ParseLineInvalid then
    CurPos := 1
  else
    CurPos := BegPos;
  Literal1 := false;
  Literal2 := false;
  BlockComment := false;
  LineComment := false;
  RoundBracketLevel := 0;
  SquareBracketLevel := 0;
  SectionFound := false;
  repeat
    UpdateState( AString,
                 CurPos,
                 Literal1,
                 Literal2,
                 LineComment,
                 BlockComment,
                 RoundBracketLevel,
                 SquareBracketLevel,
                 SkipIncRequest );
    if Literal1 or Literal2 then
    begin
      if SectionFound then
        LiteralString := LiteralString + AString[ CurPos ]
      else
        SectionFound := true;
    end
    else
    if SectionFound then
    begin
      Result := true;
      Exit;
    end;
    Inc( CurPos, 1 );
  until CurPos > EndPos;
end;

{
function StripNextToken( var AString: string;
                             BegPos,
                             EndPos: longint;
                         var TokenString: string ): boolean;
var
  CurPos: longint;
  Literal1: boolean;
  Literal2: boolean;
  BlockComment: boolean;
  LineComment: boolean;
  RoundBracketLevel: integer;
  SquareBracketLevel: integer;
  SkipIncRequest: integer;
  SectionFound: boolean;
  WasLit: boolean;
  WasRaw: boolean;
begin
  Result := false;
  if Length( AString ) = 0 then begin
    Exit;
  end;
  if EndPos = ParseLineEnd then begin
    EndPos := Length( AString );
  end;
  if BegPos = ParseLineInvalid then begin
    CurPos := 1;
  end else begin
    CurPos := BegPos;
  end;
  Literal1 := false;
  Literal2 := false;
  BlockComment := false;
  LineComment := false;
  RoundBracketLevel := 0;
  SquareBracketLevel := 0;
  SectionFound := false;
  WasLit := false;
  WasRaw := false;
  repeat
    UpdateState( AString,
                 CurPos,
                 Literal1,
                 Literal2,
                 LineComment,
                 BlockComment,
                 RoundBracketLevel,
                 SquareBracketLevel,
                 SkipIncRequest );
    TokenString := TokenString + AString[ CurPos ];
    if SectionFound then
    begin
      if WasLit and not ( Literal1 or Literal2 ) then
      begin
        Result := true;
        Break;
      end
      else
      if WasRaw and CharIsDelimiter( AString[ CurPos ] ) then
      begin
        Result := true;
        Break;
      end;
    end
    else
    if not CharIsDelimiter( AString[ CurPos ] ) then
    begin
      WasRaw := true;
      SectionFound := true;
    end
    else
    if Literal1 or Literal2 then
    begin
      WasLit := true;
      SectionFound := true;
    end;
    Inc(CurPos, 1);
  until CurPos > EndPos;
  if not Result and WasRaw then
    Result := true;
  if Result then
  begin
    System.Delete( AString, 1, Length( TokenString ));
    AString := TrimLeft( AString );
    TokenString := Trim( TokenString );
  end
  else
    TokenString := '';
end;
}

{------------------------------------------------------------------------------}

function IsTriggerOrProcedureDDL( const SQL: string ): boolean;
var
  TermKeyWord: string;
  tmpBegin, tmpEnd: longint;
begin
  TermKeyword := '';
  tmpBegin := ParseLineInvalid;
  tmpEnd := ParseLineEnd;
  ParseStr( SQL,
            'CREATE', true,
           ['TRIGGER','PROCEDURE'],
            tmpBegin, tmpEnd, TermKeyWord, false, true );
  if tmpBegin = ParseLineInvalid then begin
    TermKeyword := '';
    tmpEnd := ParseLineEnd;
    ParseStr( SQL,
              'ALTER', true,
             ['TRIGGER','PROCEDURE'],
              tmpBegin, tmpEnd, TermKeyWord, false, true );
  end;
  Result := tmpBegin <> ParseLineInvalid;
end;

procedure FindSQLSelect( const SQL: string;
                           var BegPos,
                               EndPos: longint;
                               PureSelectOnly: boolean );
var
  TermKeyWord: string;
  tmpStr: string;
begin
  TermKeyword := '';
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'SELECT', PureSelectOnly,
      ['FROM','WHERE','GROUP','HAVING','UNION','PLAN','ORDER','ROWS','FOR',';'],
            BegPos, EndPos, TermKeyWord, false, false );
  if ( PureSelectOnly ) and
     ( BegPos <> ParseLineInvalid ) and
     ( BegPos > 5 ) then
  begin
    SubStrings( SQL, tmpStr, 1, BegPos + 7 );
    if IsTriggerOrProcedureDDL( tmpStr ) or
       IsSQLInsertInto( tmpStr ) or
       IsSQLGrantRevokeSelect( tmpStr ) then
    begin
      BegPos := ParseLineInvalid;
      EndPos := ParseLineEnd;
    end;
  end;
end;

function GetSQLFirstAndSkip( const SQL: string ): string;
var
  tmpStr: string;
  PosEnd: longint;
  FirstPos,
  SkipPos: longint;
  FirstStr,
  SkipStr: string;
  BegPos: longint;
  EndPos: longint;

  function getValue( const SQL: string;
                     const BegPos,
                           EndPos: longint ): string;
  Var
    IsFound: boolean;
    IsNumeric: Boolean;
    TermCnt: integer;
    ii: longint;
  begin
    IsFound := False;
    IsNumeric := False;
    TermCnt := 0;
    for ii := BegPos to PosEnd do
      case SQL[ii] of
      '(':
        begin
          Inc( TermCnt );
          Result := Result + SQL[ii];
        end;
      ')':
        if TermCnt=1 then
        begin
          Result := Result + SQL[ii];
          Break;
        end
        else
        begin
          Dec( TermCnt );
          Result := Result + SQL[ii];
        end;
      '*',',':
        Break;
      ' ':
        if IsFound and ( TermCnt = 0 ) then
          Break;
      '0'..'9':
        if not IsFound then
        begin
          IsNumeric := True;
          IsFound := True;
          Result := Result + SQL[ii];
        end
        else
          Result := Result + SQL[ii];
      ':':
        if not IsFound then
        begin
          IsNumeric := False;
          IsFound := True;
          Result := Result + SQL[ii];
        end
        else
          break;
      else
        If IsFound then
        begin
          if IsNumeric then
            Break
          else
            Result := Result + SQL[ii];
        end
        else
        begin
          Result := Result + SQL[ii];
          IsNumeric := False;
        end;
      end;
    Result := Result + ' ';
    if not (( Pos( '(:', Result) > 0 ) or
            ( Pos( ':',  Result) > 0 ) or
            ( Pos( '(',  Result) > 0 ) or
            ( Result[1] in ['0'..'9'] )) then
      Result := '';
    if ( Length( Result ) > 0 ) and ( Result[1] in ['0'..'9'] ) then
      if not ( SQL[BegPos - 1] = ' ' ) then
        Result := '';
  end;

begin
  Result := '';
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  GetSQLSelect( SQL, tmpStr, BegPos, EndPos );
  tmpStr := UpperCase( tmpStr );
  FirstPos := getLitsRoundSafeStrPos( 'FIRST', tmpStr, 1, true, true );
  SkipPos := getLitsRoundSafeStrPos( 'SKIP', tmpStr, 1, true, true );
  if ( FirstPos > 0 ) or ( SkipPos > 0 ) then
  begin
    if ( FirstPos > 0 ) then
    begin
      if ( SkipPos > 0 ) then
        PosEnd := SkipPos - 1
      else
        PosEnd := Length( tmpStr );
      FirstStr := 'FIRST '+ getValue( tmpStr, FirstPos + 5, PosEnd );
    end;
    if ( SkipPos > 0 ) then
      SkipStr := 'SKIP '+ getValue( tmpStr, SkipPos + 4, PosEnd );
    Result := FirstStr + SkipStr;
  end;
end;

{
procedure FindSQLSelectList( const SQLSelect: string;
                               var IsDistinct: boolean;
                               var FirstCnt,
                                   SkipCnt: integer;
                               var BegPos,
                                   EndPos: longint );
var
  TermKeyWord: string;
  tmpStr: string;
begin
  tmpStr := Copy( SQLSelect, 7, MaxInt );
  TermKeyword := '';
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( tmpStr,
            'FIRST', PureSelectOnly,
           ['FROM','WHERE','GROUP','HAVING','UNION','PLAN','ORDER','FOR',';'],
            BegPos, EndPos, TermKeyWord, false, false );
  if ( PureSelectOnly ) and
     ( BegPos <> ParseLineInvalid ) and
     ( BegPos > 5 ) then
  begin
    SubStrings( SQL, tmpStr, 1, BegPos + 7 );
    if IsTriggerOrProcedureDDL( tmpStr ) or
       IsSQLInsertInto( tmpStr ) or
       IsSQLGrantRevokeSelect( tmpStr ) then
    begin
      BegPos := ParseLineInvalid;
      EndPos := ParseLineEnd;
    end;
  end;
end;
}

procedure FindSQLUnion( const SQL: string; var BegPos, EndPos: longint );
var
  TermKeyWord: string;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'UNION', false,
           ['PLAN','ORDER','ROWS','FOR',';'],
            BegPos, EndPos, TermKeyWord, false, false );
end;

procedure FindSQLFrom( const SQL: string; var BegPos, EndPos: longint );
var
  TermKeyWord: string;
  UnionBegPos: longint;
  UnionEndPos: longint;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'FROM', false,
           ['WHERE','GROUP','HAVING','UNION','PLAN','ORDER','ROWS','FOR',';'],
            BegPos, EndPos, TermKeyWord, false, false );
  UnionBegPos := ParseLineInvalid;
  UnionEndPos := ParseLineEnd;
  FindSQLUnion( SQL, UnionBegPos, UnionEndPos );
  if UnionBegPos <> ParseLineInvalid then begin
    if ( BegPos > UnionBegPos ) and ( EndPos <= UnionEndPos ) then
    begin
      BegPos := ParseLineInvalid;
    end;
  end;
end;

procedure FindSQLWhere( const SQL: string; var BegPos, EndPos: longint );
var
  TermKeyWord: string;
  UnionBegPos: longint;
  UnionEndPos: longint;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'WHERE', false,
           ['ORDER','GROUP','HAVING','UNION','PLAN','FOR', ';'],
            BegPos, EndPos, TermKeyWord, false, false );
  UnionBegPos := ParseLineInvalid;
  UnionEndPos := ParseLineEnd;
  FindSQLUnion( SQL, UnionBegPos, UnionEndPos );
  if UnionBegPos <> ParseLineInvalid then begin
    if ( BegPos > UnionBegPos ) and ( EndPos <= UnionEndPos ) then
    begin
      BegPos := ParseLineInvalid;
    end;
  end;
end;

procedure FindSQLGroup( const SQL: string; var BegPos, EndPos: longint );
var
  TermKeyWord: string;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'GROUP', false,
           ['HAVING','UNION','PLAN','ORDER','ROWS','FOR',';'],
            BegPos, EndPos, TermKeyWord, false, false );
end;

procedure FindSQLHaving( const SQL: string; var BegPos, EndPos: longint );
var
  TermKeyWord: string;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'HAVING', false,
           ['UNION','PLAN','ORDER','ROWS','FOR',';'],
            BegPos, EndPos, TermKeyWord, false, false );
end;

procedure FindSQLPlan( const SQL: string; var BegPos, EndPos: longint );
var
  TermKeyWord: string;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'PLAN', false,
           ['ORDER','ROWS','FOR',';'],
            BegPos, EndPos, TermKeyWord, false, false );
end;

procedure FindSQLOrder( const SQL: string; var BegPos, EndPos: longint );
var
  TermKeyWord: string;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'ORDER', false,
            ['FOR','ROWS',';'],
            BegPos, EndPos, TermKeyWord, false, false );
end;

procedure FindSQLForUpdate( const SQL: string; var BegPos, EndPos: longint );
var
  TermKeyWord: string;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'FOR', false,
            [';'],
            BegPos, EndPos, TermKeyWord, false, false );
end;

function IsSQLInsertInto( SQL: string ): boolean;
var
  TermKeyWord: string;
  BegPos: longint;
  EndPos: longint;
begin
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'INSERT', true,
            ['INTO'],
            BegPos, EndPos, TermKeyWord, false, true );
  Result := BegPos <> parseLineInvalid;
end;

function IsSQLGrantRevokeSelect( SQL: string ): boolean;
var
  TermKeyWord: string;
  BegPos: longint;
  EndPos: longint;
begin
  TermKeyWord := '';
  BegPos := ParseLineInvalid;
  EndPos := ParseLineEnd;
  ParseStr( SQL,
            'REVOKE', true,
            ['SELECT'],
            BegPos, EndPos, TermKeyWord, false, false );
  if BegPos = ParseLineInvalid then begin
    TermKeyWord := '';
    EndPos := ParseLineEnd;
    ParseStr( SQL,
              'GRANT', true,
              ['SELECT'],
              BegPos, EndPos, TermKeyWord, false, false );
  end;
  Result := BegPos <> parseLineInvalid;
end;

{------------------------------------------------------------------------------}

procedure GetSQLSelect( const SQL: string;
                        var   SQLSelect: string;
                        var   BegPos, EndPos: longint );
begin
  FindSQLSelect( SQL, BegPos, EndPos, true );
  SubStrings( SQL, SQLSelect, BegPos, EndPos );
  SQLSelect := Trim( SQLSelect );
end;

procedure SetSQLSelect( var SQL: string; const SQLSelect: string );
var
  BegPos: longint;
  EndPos: longint;
begin
  FindSQLSelect( SQL, BegPos, EndPos, true );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLSelect, BegPos, EndPos );
  end else begin
    FindSQLFrom( SQL, BegPos, EndPos );
    if BegPos <> ParseLineInvalid then begin
      StuffStrings( SQL, SQLSelect, 1, BegPos );
    end else begin
      StuffStrings( SQL, SQLSelect, 1, 1 );
    end
  end;
end;

procedure GetSQLFrom( const SQL: string;
                      var   SQLFrom: string;
                      var   BegPos, EndPos: longint );
begin
  FindSQLFrom( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    SubStrings( SQL, SQLFrom, BegPos, EndPos );
  end else begin
    SQLFrom := '';
  end;
  SQLFrom := Trim( SQLFrom );
end;

procedure SetSQLFrom( var SQL: string; const SQLFrom: string );
var
  BegPos:  longint;
  EndPos:  longint;
begin
  FindSQLFrom( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLFrom, BegPos, EndPos );
  end else begin
    FindSQLSelect( SQL, BegPos, EndPos, true );
    if BegPos <> ParseLineInvalid then begin
      StuffStrings( SQL, SQLFrom, EndPos, EndPos );
    end else begin
      StuffStrings( SQL, SQLFrom, 1, 1 );
    end
  end;
end;

procedure GetSQLWhere( const SQL: string;
                       var   SQLWhere: string;
                       var   BegPos, EndPos: longint );
begin
  FindSQLWhere( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    SubStrings( SQL, SQLWhere, BegPos, EndPos );
  end else begin
    SQLWhere := '';
  end;
  SQLWhere := Trim( SQLWhere );
end;

procedure SetSQLWhere( var SQL: string; const SQLWhere: string );
var
  BegPos, EndPos: longint;
begin
  FindSQLWhere( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLWhere, BegPos, EndPos );
  end else begin
    FindSQLFrom( SQL, BegPos, EndPos );
    if BegPos <> ParseLineInvalid then begin
      StuffStrings( SQL, SQLWhere, EndPos, EndPos );
    end else begin
      FindSQLSelect( SQL, BegPos, EndPos, true );
      if BegPos <> ParseLineInvalid then begin
        StuffStrings( SQL, SQLWhere, EndPos, EndPos );
      end else begin
        StuffStrings( SQL, SQLWhere, 1, 1 );
      end;
    end;
  end;
end;

procedure GetSQLGroup( const SQL: string;
                       var   SQLGroup: string;
                       var   BegPos, EndPos: longint );
begin
  FindSQLGroup( SQL, BegPos, EndPos );
  if BegPos = ParseLineInvalid then
    SQLGroup := ''
  else
    SubStrings( SQL, SQLGroup, BegPos, EndPos );
  SQLGroup := Trim( SQLGroup );
end;

procedure SetSQLGroup( var SQL: string; const SQLGroup: string );
var
  BegPos, EndPos: longint;
begin
  FindSQLGroup( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLGroup, BegPos, EndPos );
  end else begin
    FindSQLWhere( SQL, BegPos, EndPos );
    if BegPos <> ParseLineInvalid then begin
      StuffStrings( SQL, SQLGroup, EndPos, EndPos );
    end else begin
      FindSQLFrom( SQL, BegPos, EndPos );
      if BegPos <> ParseLineInvalid then begin
        StuffStrings( SQL, SQLGroup, EndPos, EndPos );
      end else begin
        FindSQLSelect( SQL, BegPos, EndPos, true );
        if BegPos <> ParseLineInvalid then begin
          StuffStrings( SQL, SQLGroup, EndPos, EndPos );
        end else begin
          StuffStrings( SQL, SQLGroup, 1, 1 );
        end;
      end;
    end;
  end;
end;

procedure GetSQLHaving( const SQL: string;
                        var   SQLHaving:  string;
                        var   BegPos, EndPos: longint );
begin
  FindSQLHaving( SQL, BegPos, EndPos );
  if BegPos = ParseLineInvalid then
    SQLHaving := ''
  else
    SubStrings( SQL, SQLHaving, BegPos, EndPos );
  SQLHaving := Trim( SQLHaving );
end;

procedure SetSQLHaving( var SQL: string; const SQLHaving:  string );
var
  BegPos, EndPos: longint;
begin
  FindSQLHaving( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLHaving, BegPos, EndPos );
  end else begin
    FindSQLGroup( SQL, BegPos, EndPos );
    if BegPos <> ParseLineInvalid then begin
      StuffStrings( SQL, SQLHaving, EndPos, EndPos );
    end else begin
      FindSQLWhere( SQL, BegPos, EndPos );
      if BegPos <> ParseLineInvalid then begin
        StuffStrings( SQL, SQLHaving, EndPos, EndPos );
      end else begin
        FindSQLFrom( SQL, BegPos, EndPos );
        if BegPos <> ParseLineInvalid then begin
          StuffStrings( SQL, SQLHaving, EndPos, EndPos );
        end else begin
          FindSQLSelect( SQL, BegPos, EndPos, true );
          if BegPos <> ParseLineInvalid then begin
            StuffStrings( SQL, SQLHaving, EndPos, EndPos );
          end else begin
            StuffStrings( SQL, SQLHaving, 1, 1 );
          end;
        end;
      end;
    end;
  end;
end;

procedure GetSQLUnion ( const SQL: string;
                        var   SQLUnion: string;
                        var   BegPos, EndPos: longint );
begin
  FindSQLUnion( SQL, BegPos, EndPos );
  if BegPos = ParseLineInvalid then
    SQLUnion := ''
  else
    SubStrings( SQL, SQLUnion, BegPos, EndPos );
  SQLUnion := Trim( SQLUnion );
end;

procedure SetSQLUnion ( var SQL: string; const SQLUnion:  string );
var
  BegPos, EndPos: longint;
begin
  FindSQLUnion( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLUnion, BegPos, EndPos );
  end else begin
    FindSQLHaving( SQL, BegPos, EndPos );
    if BegPos <> ParseLineInvalid then begin
      StuffStrings( SQL, SQLUnion, EndPos, EndPos );
    end else begin
      FindSQLGroup( SQL, BegPos, EndPos );
      if BegPos <> ParseLineInvalid then begin
        StuffStrings( SQL, SQLUnion, EndPos, EndPos );
      end else begin
        FindSQLWhere( SQL, BegPos, EndPos );
        if BegPos <> ParseLineInvalid then begin
          StuffStrings( SQL, SQLUnion, EndPos, EndPos );
        end else begin
          FindSQLFrom( SQL, BegPos, EndPos );
          if BegPos <> ParseLineInvalid then begin
            StuffStrings( SQL, SQLUnion, EndPos, EndPos );
          end else begin
            FindSQLSelect( SQL, BegPos, EndPos, true );
            if BegPos <> ParseLineInvalid then begin
              StuffStrings( SQL, SQLUnion, EndPos, EndPos );
            end else begin
              StuffStrings( SQL, SQLUnion, 1, 1 );
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure GetSQLPlan( const SQL: string;
                      var   SQLPlan: string;
                      var   BegPos, EndPos: longint );
begin
  FindSQLPlan( SQL, BegPos, EndPos );
  if BegPos = ParseLineInvalid then
    SQLPlan := ''
  else
    SubStrings( SQL, SQLPlan, BegPos, EndPos );
  SQLPlan := Trim( SQLPlan );
end;

procedure SetSQLPlan  ( var SQL: string; const SQLPlan:  string );
var
  BegPos, EndPos: longint;
begin
  FindSQLPlan( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLPlan, BegPos, EndPos );
  end else begin
    FindSQLUnion( SQL, BegPos, EndPos );
    if BegPos <> ParseLineInvalid then begin
      StuffStrings( SQL, SQLPlan, EndPos, EndPos );
    end else begin
      FindSQLHaving( SQL, BegPos, EndPos );
      if BegPos <> ParseLineInvalid then begin
        StuffStrings( SQL, SQLPlan, EndPos, EndPos );
      end else begin
        FindSQLGroup( SQL, BegPos, EndPos );
        if BegPos <> ParseLineInvalid then begin
          StuffStrings( SQL, SQLPlan, EndPos, EndPos );
        end else begin
          FindSQLWhere( SQL, BegPos, EndPos );
          if BegPos <> ParseLineInvalid then begin
            StuffStrings( SQL, SQLPlan, EndPos, EndPos );
          end else begin
            FindSQLFrom( SQL, BegPos, EndPos );
            if BegPos <> ParseLineInvalid then begin
              StuffStrings( SQL, SQLPlan, EndPos, EndPos );
            end else begin
              FindSQLSelect( SQL, BegPos, EndPos, true );
              if BegPos <> ParseLineInvalid then begin
                StuffStrings( SQL, SQLPlan, EndPos, EndPos );
              end else begin
                StuffStrings( SQL, SQLPlan, 1, 1 );
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure GetSQLOrder( const SQL: string;
                       var   SQLOrder: string;
                       var   BegPos, EndPos: longint );
begin
  FindSQLOrder( SQL, BegPos, EndPos );
  if BegPos = ParseLineInvalid then
    SQLOrder := ''
  else
    SubStrings( SQL, SQLOrder, BegPos, EndPos );
  SQLOrder := Trim( SQLOrder );
end;

procedure SetSQLOrder( var SQL: string; const SQLOrder: string );
var
  BegPos, EndPos: longint;
begin
  FindSQLOrder( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLOrder, BegPos, EndPos );
  end else begin
    FindSQLPlan( SQL, BegPos, EndPos );
    if BegPos <> ParseLineInvalid then begin
      StuffStrings( SQL, SQLOrder, EndPos, EndPos );
    end else begin
      FindSQLUnion( SQL, BegPos, EndPos );
      if BegPos <> ParseLineInvalid then begin
        StuffStrings( SQL, SQLOrder, EndPos, EndPos );
      end else begin
        FindSQLHaving( SQL, BegPos, EndPos );
        if BegPos <> ParseLineInvalid then begin
          StuffStrings( SQL, SQLOrder, EndPos, EndPos );
        end else begin
          FindSQLGroup( SQL, BegPos, EndPos );
          if BegPos <> ParseLineInvalid then begin
            StuffStrings( SQL, SQLOrder, EndPos, EndPos );
          end else begin
              FindSQLWhere( SQL, BegPos, EndPos );
            if BegPos <> ParseLineInvalid then begin
              StuffStrings( SQL, SQLOrder, EndPos, EndPos );
            end else begin
              FindSQLFrom( SQL, BegPos, EndPos );
              if BegPos <> ParseLineInvalid then begin
                StuffStrings( SQL, SQLOrder, EndPos, EndPos );
              end else begin
                FindSQLSelect( SQL, BegPos, EndPos, true );
                if BegPos <> ParseLineInvalid then begin
                  StuffStrings( SQL, SQLOrder, EndPos, EndPos );
                end else begin
                  StuffStrings( SQL, SQLOrder, 1, 1 );
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure SetSQLForUpdate ( var SQL: string; const SQLForUpdate:  string );
var
  BegPos, EndPos: longint;
begin
  FindSQLForUpdate( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then begin
    StuffStrings( SQL, SQLForUpdate, BegPos, EndPos );
  end else begin
    SQL := SQL + #13#10 + SQLForUpdate;
  end;
end;

procedure GetSQLForUpdate( const SQL: string;
                           var   SQLForUpdate: string;
                           var   BegPos, EndPos: longint );
begin
  FindSQLForUpdate( SQL, BegPos, EndPos );
  if BegPos <> ParseLineInvalid then
    SubStrings( SQL, SQLForUpdate, BegPos, EndPos )
  else
    SQLForUpdate := '';
  SQLForUpdate := Trim( SQLForUpdate );
end;

procedure GetSQLForUpdateColumns( const SQL: string;
                                        SQLForUpdateColumns: TStrings );
var
  BegPos, EndPos: longint;
  TermKeyWord: string;
  ForUpdateText: string;
  tmpStr: string;
  tmpBool: boolean;
  tmpLen: longint;
begin
  TermKeyWord := '';
  ForUpdateText := '';
  tmpStr := '';
  MakeServerSQL( SQL, nil, nil, nil, tmpStr, #0, false, tmpLen );
  GetSQLForUpdate( tmpStr, ForUpdateText, BegPos, EndPos );
  if Assigned( SQLForUpdateColumns ) then with SQLForUpdateColumns do
  begin
    BeginUpdate;
    try
      Clear;
      if ForUpdateText <> '' then
      begin
        BegPos := ParseLineInvalid;
        EndPos := ParseLineEnd;
        ParseStr( ForUpdateText,
                  'FOR', false,
                  ['UPDATE'],
                  BegPos, EndPos, TermKeyWord, false, true );
        if BegPos <> ParseLineInvalid then begin
          BegPos := EndPos + Length( 'UPDATE' ) - 1;
          EndPos := ParseLineEnd;
          ParseStr( ForUpdateText,
                    'OF', false,
                    [''],
                    BegPos, EndPos, TermKeyWord, false, false );
          if BegPos <> ParseLineInvalid then
          begin
            ForUpdateText := Copy( ForUpdateText, BegPos + 3, MaxInt );
            tmpBool := false;
            repeat
              BegPos := getLitSafePos( ' ', ForUpdateText, 1 );
              if BegPos > 0 then
                System.Delete( ForUpdateText, BegPos, 1 )
              else
                tmpBool := true;
            until tmpBool;
            CommaText := ForUpdateText;
          end;
        end;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function CharIsDelimiter( Pos: Char ): Boolean;
begin
  Result := (Ord(Pos) <= Ord(' ')) or
            (Pos in ['(',')',':','?',',','/','*','=',';','<','>','!' ]);
             // Don't include a period in here!
end;

procedure ExtractMacroDefs( const SQL: string;
                            const NewMacroDefs: TStrings;
                                  MacroChar: char );
begin
end;

function ReplaceMacro( const SQL: string;
                       const MacroName,
                             MacroType,
                             MacroValue: string;
                             MacroChar: char ): string;
begin
  Result := SQL;
end;

function StripComments( const ASQL: string ): string;
var
  tmpLen: longint;
begin
  MakeServerSQL( ASQL, nil, nil, nil, Result, #0, false, tmpLen );
end;

function StripLitsAndRounds( const AStr: string;
                                   SQLDialect: integer ): string;
var
  ii: integer;
  rndBr: integer;
  lit1, lit2: boolean;
begin
  rndBr := 0;
  lit1 := false;
  lit2 := false;
  Result := '';
  for ii := 0 to Length( AStr ) do
  begin
    if lit1 then
      lit1 := AStr[ ii ] <> ''''
    else
    if lit2 then
      lit2 := AStr[ ii ] <> '"'
    else
    case AStr[ ii ] of
    '''': lit1 := true;
    '(': Inc( rndBr );
    ')': Dec( rndBr );
    else
      if ( AStr[ ii ] = '"' ) and ( SQLDialect < 3 ) then
        lit2 := true
      else
      if rndBr = 0 then
        Result := Result + AStr[ ii ];
    end;
  end;
end;

function MakeServerSQL(       ClientSQL: string;
                        const Params,
                              Fields,
                              Tables: TStrings;
                        var   ServerSQL: string;
                              ParamChar: char;
                              Comments: boolean;
                        var   CommentLen: longint ): integer;
var
  tmpStr: string;
  AggCnt: integer;
  CurPos: longint;
  Literal1: Boolean;
  Literal2: Boolean;
  RoundBracketLevel: integer;
  SquareBracketLevel: integer;
  BlockComment: boolean;
  WasBlockComment: boolean;
  LineComment: boolean;
  WasLineComment: boolean;
  CommentDelimited: boolean;
  CommentBeg: integer;
  CommentEnd: integer;
  LastCommentDelimited: boolean;
  LastCommentBeg: integer;
  LastCommentEnd: integer;
  ParamFound: boolean;
  ParamName: string;
  ParamCount: integer;
  SkipIncRequest: integer;
  SelBegPos,
  SelEndPos: longint;
  tmpParams: TIB_StringList;

  procedure AddParameter;
  begin
    ParamFound := false;
    if ParamName = '' then
      ParamName := IB_PARAMETER + IntToStr( ParamCount );
    ServerSQL := ServerSQL + ' /* ' + ParamName + ' */ ';
    if ( CurPos >= SelBegPos + Length( ParamName ) + 1 ) and
       ( CurPos <= SelEndPos ) then
      tmpParams.Add( ParamName )
    else
    if Assigned( Params ) then
      Params.Add( ParamName );
    ParamName := '';
    Inc( ParamCount );
  end;

var
  tmpFldText: string;

  procedure CheckForFields;
  begin
    if Assigned( Fields ) and
       ( CurPos >= SelBegPos ) and
       ( CurPos <= SelEndPos ) and
       ( RoundBracketLevel = 0 ) then
      if ( ClientSQL[ CurPos ] = ',' ) or ( CurPos = SelEndPos ) then
      begin
        if ( CurPos = SelEndPos ) and
           ( LineComment or BlockComment ) then
          tmpStr := ''
        else
          tmpStr := SetCharValues( Copy( ClientSQL,
                                         SelBegPos,
                                         CurPos - SelBegPos ));
        if tmpFldText <> '' then
        begin
          if CommentDelimited then
            tmpStr := tmpFldText + tmpStr
          else
            tmpStr := tmpFldText + ' ' + tmpStr;
        end;
        Fields.Add( Trim( tmpStr ));
        SelBegPos := CurPos + 1;
        tmpFldText := '';
      end
      else
      if ClientSQL[ CurPos ] = '*' then
      begin
        Fields.Add( '<*>' );
        Inc( AggCnt );
      end;
  end;
var
  totLen: integer;
  function ProcessComment( var Cmt, WasCmt: boolean ): boolean;
  var
    ii: integer;
  begin
    Result := true;
    if not ( Cmt or WasCmt ) then
    begin
      Result := false;
      Exit;
    end;
    if ( Cmt and not WasCmt ) or ( WasCmt and not Cmt ) then
    begin
      if Cmt then
      begin
        LastCommentDelimited := CommentDelimited;
        LastCommentBeg := CommentBeg;
        LastCommentEnd := CommentEnd;
        CommentBeg := CurPos;
        CommentEnd := ParseLineInvalid;
        CommentDelimited := ( CurPos = 1 ) or
                            ( CharIsDelimiter( ClientSQL[CurPos - 1] ));
        if not CommentDelimited and ( tmpFldText <> '' ) then
          tmpFldText := tmpFldText + ' ';// + tmpStr;
        tmpFldText := tmpFldText +
                      SetCharValues(
                        Copy( ClientSQL,
                              SelBegPos,
                              CommentBeg - SelBegPos ));
      end
      else
      begin
        CommentEnd := CurPos + SkipIncRequest + 1;
        CommentDelimited := CommentDelimited or
                            ( CommentEnd >= totLen ) or
                            ( CharIsDelimiter( ClientSQL[ CommentEnd ] ));
        if BlockComment and not Comments and not CommentDelimited then
          ServerSQL := ServerSQL + ' ';
        SelBegPos := CommentEnd;
      end;
    end;
    if LineComment then
      Inc( CurPos, SkipIncRequest )
    else
    begin
      for ii := 0 to SkipIncRequest do
      begin
        if Comments and ( BlockComment or WasBlockComment ) then
        begin
          ServerSQL := ServerSQL + ClientSQL[ CurPos ];
          Inc( CommentLen );
        end;
        Inc(CurPos);
      end;
      Dec(CurPos);
    end;
    WasCmt := Cmt;
  end;
  function IsStrFound( AStr: string; ChkVal: boolean ): boolean;
  var
    WasFnd: boolean;
  begin
    Result := ((( SelBegPos + Length(AStr) > SelEndPos ) or
                (SDelimiter( ClientSQL[ SelBegPos + Length(AStr) ] )))) and
              (CompareText( Copy(ClientSQL, SelBegPos, Length(AStr)), AStr)=0);
    if Result then
    begin
      Inc( SelBegPos, Length( AStr ));
      WasFnd := false;
      if ChkVal then
      begin
        repeat
          if SDelimiter( ClientSQL[ SelBegPos ] ) then
          begin
            if not WasFnd then
              Inc( SelBegPos )
            else
              Break;
          end
          else
          begin
            Inc( SelBegPos );
            WasFnd := true;
          end;
        until SelBegPos >= SelEndPos;
      end;
    end;
  end;
begin { MakeServerSQL }
  ServerSQL := '';
  CommentLen := 0;
  Result := 0;
  totLen := Length( ClientSQL );
  if totLen = 0 then
    Exit;
  tmpParams := TIB_StringList.Create;
  try
  SelEndPos := ParseLineInvalid;
  if Assigned( Params ) then
    Params.Clear;
  if Assigned( Fields ) then
    Fields.Clear;
  FindSQLSelect( ClientSQL, SelBegPos, SelEndPos, false );
  if SelBegPos = ParseLineInvalid then
    SelEndPos := ParseLineInvalid
  else
  begin
    Inc( SelBegPos, 7 );
    while SelBegPos < SelEndPos - 3 do
    begin
      case ClientSQL[SelBegPos] of
        'F', 'f': if not IsStrFound( 'FIRST',    true  ) then Break;
        'S', 's': if not IsStrFound( 'SKIP',     true  ) then Break;
        'D', 'd': if not IsStrFound( 'DISTINCT', false ) then Break;
        'A', 'a': if not IsStrFound( 'ALL',      false ) then Break;
        else
          if CharIsDelimiter( ClientSQL[SelBegPos] ) then
            Inc( SelBegPos )
          else
            Break;
      end;
    end;
  end;
  ParamCount := 0;
  Literal1 := false;
  Literal2 := false;
  RoundBracketLevel := 0;
  SquareBracketLevel := 0;
  BlockComment := false;
  WasBlockComment := false;
  LineComment := false;
  WasLineComment := false;
  CommentDelimited := false;
  CommentBeg := ParseLineInvalid;
  CommentEnd := ParseLineInvalid;
  LastCommentDelimited := false;
  LastCommentBeg := ParseLineInvalid;
  LastCommentEnd := ParseLineInvalid;
  ParamFound := false;
  ParamName := '';
  CurPos := 0;
  AggCnt := 0;
  tmpFldText := '';
  repeat
    Inc( CurPos );
    UpdateState( ClientSQL,
                 CurPos,
                 Literal1,
                 Literal2,
                 LineComment,
                 BlockComment,
                 RoundBracketLevel,
                 SquareBracketLevel,
                 SkipIncRequest );
    if ( BlockComment or WasBlockComment ) or
       ( LineComment or WasLineComment ) then
    begin
      if not ProcessComment( BlockComment, WasBlockComment ) then
      if not ProcessComment( LineComment, WasLineComment ) then
        raise Exception.Create( 'Invalid parser state' );
    end
    else
    if ParamFound then
    begin
      if not Literal2 and CharIsDelimiter( ClientSQL[ CurPos ] ) then
      begin
        AddParameter;
        Dec( CurPos ); //  Go back to continue parsing from the same spot
      end
      else
        ParamName := ParamName + ClientSQL[ CurPos ];
    end
    else
    if Literal1 or Literal2 or ( SquareBracketLevel > 0 ) then
    begin
      CheckForFields;
      ServerSQL := ServerSQL + ClientSQL[ CurPos ];
    end
    else
    if ( ClientSQL[ CurPos ] = '?' ) or
       (( ParamChar <> #0 ) and
        ( ClientSQL[ CurPos ] = ParamChar )) then
    begin
      ParamFound := True;
      ServerSQL := ServerSQL + '?';
    end
    else
    begin
      CheckForFields;
      ServerSQL := ServerSQL + ClientSQL[ CurPos ];
    end;
  until CurPos >= totLen;
  if ParamFound then
    AddParameter;
  if Assigned( Params ) then
    Params.AddStrings( tmpParams );
  finally
    Result := tmpParams.Count;
    tmpParams.Free;
  end;
end;  { MakeServerSQL }

procedure MakeClientSQL( const ServerSQL: string;
                         var   ClientSQL: string;
                               ParamChar: char );
var
  CurPos: longint;
  Literal1: Boolean;
  Literal2: Boolean;
  RoundBracketLevel: integer;
  SquareBracketLevel: integer;
  BlockComment: boolean;
  LineComment: boolean;
  SkipIncRequest: integer;
  ii: integer;
  ParamFound: boolean;
begin { MakeClientSQL }
  ClientSQL := '';
  if Length( ServerSQL ) = 0 then
    Exit;
  Literal1 := false;
  Literal2 := false;
  RoundBracketLevel := 0;
  SquareBracketLevel := 0;
  BlockComment := false;
  LineComment := false;
  CurPos := 0;
  ParamFound := false;
  repeat
    Inc( CurPos );
    UpdateState( ServerSQL,
                 CurPos,
                 Literal1,
                 Literal2,
                 LineComment,
                 BlockComment,
                 RoundBracketLevel,
                 SquareBracketLevel,
                 SkipIncRequest );
    if ParamFound then
    begin
      if CharIsDelimiter( ServerSQL[ CurPos ] ) then
      begin
        ParamFound := false;
        Inc( CurPos, 3 ); // Skip over the block comment end bracket.
      end
      else
        ClientSQL := ClientSQL + ServerSQL[ CurPos ];
    end
    else
    if Literal1 or Literal2 then
      ClientSQL := ClientSQL + ServerSQL[ CurPos ]
    else
    if LineComment then
      Inc( CurPos, SkipIncRequest )
    else
    if BlockComment then
    begin
      ClientSQL := ClientSQL + ServerSQL[ CurPos ];
      for ii := 1 to SkipIncRequest do
      begin
        Inc(CurPos);
        ClientSQL := ClientSQL + ServerSQL[ CurPos ];
      end;
    end
    else
    if ServerSQL[ CurPos ] = '?' then
    begin
      ParamFound := true;
      ClientSQL := ClientSQL + ParamChar;
      Inc( CurPos, 4 ); // Skip over the block comment begin bracket.
    end
    else
      ClientSQL := ClientSQL + ServerSQL[ CurPos ];
  until CurPos >= Length( ServerSQL );
end;  { MakeClientSQL }

{------------------------------------------------------------------------------}

function strip_char( const AStr: string; AChar: char ): string;
var
  ii: integer;
begin
  Result := AStr;
  if Length( Result ) = 0 then Exit;
  ii := 1;
  repeat
    if Result[ii] = AChar then System.Delete( Result, ii, 1 ) else Inc( ii );
  until ii > Length( Result );
end;

function strip_chars_beg( const AStr: string; AChar: string ): string;
begin
  Result := TrimLeft( AStr );
  while ( Length( Result ) > 0 ) and
        ( Pos( Result[ 1 ], AChar ) > 0 ) do
    System.Delete( Result, 1, 1 )
end;

function strip_chars_end( const AStr: string; AChar: string ): string;
begin
  Result := TrimRight( AStr );
  while ( Length( Result ) > 0 ) and
        ( Pos( Result[ Length( Result ) ], AChar ) > 0 ) do
    System.Delete( Result, Length( Result ), 1 )
end;

procedure swap_chars(   var AStr: string;
                        const ACharVals: string;
                              NewChar: char );
var
  ii: integer;
begin
  if Length( AStr ) = 0 then Exit;
  ii := 1;
  repeat
    if Pos( AStr[ii], ACharVals ) <> 0 then
      AStr[ii] := NewChar;
    Inc( ii );
  until ii > Length( AStr );
end;

procedure replace_string(   var AStr: string;
                          const ATarget, AReplaceText: string );
var
  ii: integer;
begin
  if Length( AStr ) = 0 then Exit;
  if Pos( ATarget, AReplaceText ) > 0 then Exit;
  ii := Pos( ATarget, AStr );
  while ii > 0 do
  begin
    System.Delete( AStr, ii, Length( ATarget ));
    System.Insert( AReplaceText, AStr, ii );
    ii := Pos( ATarget, AStr );
  end;
end;

function replicate_char( AChar: char; ACnt: integer ): string;
begin
  SetLength( Result, ACnt );
  FillChar( Result[1], ACnt, AChar );
end;

function SupplySingleCharDots( const AStr: string ): string;
var
  ii: integer;
  tmpLen: integer;
begin
  Result := AStr + '';
  tmpLen := Length( AStr );
  for ii := tmpLen downto 2  do
    if Result[ii] = ' ' then
      if ( ii <= 2 ) or ( Result[ ii - 2 ] = ' ' ) then
        System.Insert( '.', Result, ii );
end;

const
  SplitWordChars = [ '''', '"', '-','.','@','!','#','&','?','<','>','/','\',
                     '%','^','*','(',')','+','=', '~', '`' ];

procedure parse_word_proc( var wd: string );
begin
  wd := AnsiUpperCase( wd );
  if wd = '&'   then wd := 'AND'     else
  if wd = '%'   then wd := 'PERCENT' else
  if wd = '#'   then wd := 'NO'      else
  if wd = '%'   then wd := 'PERCENT' else
  if wd = '@'   then wd := 'AT'      else
  if wd = '+'   then wd := 'PLUS'    else
  if wd = '-N-' then wd := 'AND'     else
  begin
    wd := IB_Parse.strip_chars_beg( wd, '''")([]{}<>`,-/\~*.;:' );
    wd := IB_Parse.strip_chars_end( wd, '''")([]{}<>`,-/\~*' );
  end;
end;

procedure parse_word_list( const AWords: string;
                                 MaxWordLen: integer;
                                 AWordList: TStrings );
var
  SafeStack: TStringList;
  SafeStackCnt: integer;
  tmpWdsCh: string;
  procedure AddWord( wd: string );
  var
    tmpPos: integer;
    procedure SplitWord( ch: char );
    var
      nxtPos, lstPos: integer;
      nxtWd: string;
    begin
      tmpPos := Pos( ch, wd );
      if tmpPos = Length( wd ) then
        AddWord( Copy( wd, 1, tmpPos - 1 ))
      else
      if tmpPos > 0 then
      begin
      // If one of the words is 2 characters or less then process the concatenation of
      // the words without the splitter character in there.
        if ( tmpPos <= 3 ) or ( Length( wd ) - tmpPos < 3 ) then
          AddWord( Strip_Char( wd, ch ));
        lstPos := 1;
        while tmpPos > 0 do
        begin
          AddWord( Copy( wd, 1, tmpPos ));
          if lstPos <> 1 then
            AddWord( Copy( wd, lstPos, tmpPos - lstPos + 1 ));
          nxtWd := Copy( wd, tmpPos + 1, MaxInt );
          AddWord( nxtWd );
          nxtPos := Pos( ch, nxtWd );
          if nxtPos = 0 then
            tmpPos := 0
          else
          begin
            lstPos := tmpPos + 1;
            tmpPos := tmpPos + nxtPos;
          end;
        end;
      end;
    end;
    function SubstituteWord( const AStr, AWord: string ): integer;
    begin
      tmpPos := Pos( AStr, wd );
      if tmpPos > 0 then
        AddWord( Copy( wd, 1, tmpPos - 1 ) + AWord +
                 Copy( wd, tmpPos + Length( AStr ), MaxInt ) );
      Result := tmpPos;
    end;
    function AddNumWord10( ACh: char ): string;
    begin
      case ACh of
        '0': Result := 'ZERO';
        '1': Result := 'ONE';
        '2': Result := 'TWO';
        '3': Result := 'THREE';
        '4': Result := 'FOUR';
        '5': Result := 'FIVE';
        '6': Result := 'SIX';
        '7': Result := 'SEVEN';
        '8': Result := 'EIGHT';
        '9': Result := 'NINE';
        else Result := '';
      end;
    end;
    function AddNumWordTeens( ACh: char ): string;
    begin
      case ACh of
        '.': Result := 'ONE';
        '0': Result := 'TEN';
        '1': Result := 'ELEVEN';
        '2': Result := 'TWELVE';
        '3': Result := 'THIRTEEN';
        '4': Result := 'FOURTEEN';
        '5': Result := 'FIFTEEN';
        '6': Result := 'SIXTEEN';
        '7': Result := 'SEVENTEEN';
        '8': Result := 'EIGHTEEN';
        '9': Result := 'NINTEEN';
        else Result := '';
      end;
    end;
    function AddNumWord20_99( ATCh, ACh: char ): string;
    begin
      case ATCh of
        '2': Result := 'TWENTY';
        '3': Result := 'THIRTY';
        '4': Result := 'FOURTY';
        '5': Result := 'FIFTY';
        '6': Result := 'SIXTY';
        '7': Result := 'SEVENTY';
        '8': Result := 'EIGHTY';
        '9': Result := 'NINTY';
        else Result := '';
      end;
      if Result <> '' then
      begin
        if ACh = '.' then
          Result := AddNumWord10( ATCh )
        else
        if ACh in [ '1'..'9' ] then
          Result := Result + '-' + AddNumWord10( ACh );
      end;
    end;
    procedure AddNumWordUnder1000( AWd: string );
    begin
      AWd := strip_chars_beg( AWd, '0' );
      if Length( AWd ) = 3 then
      begin
        AddWord( AddNumWord10( AWd[ 1 ] ));
        AddWord( 'HUNDRED' );
        System.Delete( AWd, 1, 1 );
      end;
      AWd := strip_chars_beg( AWd, '0' );
      if Length( AWd ) = 1 then
        AddWord( AddNumWord10( AWd[ 1 ] ))
      else
      if Length( AWd ) = 2 then
      begin
        if AWd[ 1 ] = '1' then
          AddWord( AddNumWordTeens( AWd[ 2 ] ))
        else
          AddWord( AddNumWord20_99( AWd[ 1 ], AWd[ 2 ] ));
      end;
    end;
    procedure AddVerBigNumWord( ThPlace: integer; ThName: string );
    var
      ii: integer;
    begin
      ii := Length( wd );
      AddNumWordUnder1000( Copy( wd, 1, ii - ThPlace ));
      AddWord( ThName );
      System.Delete( wd, 1, ii - ThPlace );
      wd := strip_chars_beg( wd, '0' );
    end;

  var
    ii: integer;
    tmpCh: string;
  begin
    wd := AnsiUpperCase( Trim( wd ));
    wd := strip_chars_beg( wd, '''")([]{}<>`,-/\~*.;:' );
    wd := strip_chars_end( wd, '''")([]{}<>`,-/\~*&' );
    if Length( wd ) > 2 then
      wd := strip_chars_end( wd, '.' );
    wd := trim( wd );
    if ( wd = '' ) then Exit;
    SafeStackCnt := SafeStack.Count;
    SafeStack.Add( wd );
    if SafeStack.Count = SafeStackCnt then Exit;
    tmpCh := '';
    if tmpWdsCh <> '' then
    begin
      for ii := 1 to Length( wd ) do
        if ( Pos( wd[ii], tmpWdsCh ) > 0 ) and
           ( Pos( wd[ii], tmpCh ) = 0 ) then
          tmpCh := tmpCh + wd[ii];
      for ii := 1 to Length( tmpCh ) do
        SplitWord( tmpCh[ii] );
      if Pos( '-', tmpCh ) > 0 then
        if SubstituteWord( '-N-', 'AND' ) > 0 then
          AddWord( 'AND' );
      if Pos( '&', tmpCh ) > 0 then
      begin
        SubstituteWord( '&', 'AND' );
        SubstituteWord( '&', '.' );
        AddWord( '&.' );
        AddWord( 'AND' );
      end;
      if Pos( '%', tmpCh ) > 0 then
      begin
        SubstituteWord( '%', 'PERCENT' );
        AddWord( 'PERCENT' );
      end;
      if Pos( '@', tmpCh ) > 0 then
        if SubstituteWord( '@', 'A' ) > 0 then
          AddWord( 'AT' );
      if Pos( '+', tmpCh ) > 0 then
        if SubstituteWord( '+', 'PLUS' ) > 0 then
          AddWord( 'PLUS' );
      if Pos( '#', tmpCh ) > 0 then
        if SubstituteWord( '#', 'NO.' ) > 0 then
        begin
          AddWord( 'NO' );
          AddWord( 'POUND' );
        end;
    end;
    if wd <> '' then
    begin
      begin
        if ( Length( wd ) <= Trunc( MaxWordLen * 0.75 )) or ( tmpCh = '' ) then
          AWordList.Add( Copy( wd, 1, MaxWordLen ));
        wd := strip_chars_beg( wd, ' +-.' );
        wd := strip_chars_end( wd, ' +-.' );
        if wd <> '' then
        begin
          wd := strip_chars_beg( wd, '0' );
          if wd = '' then wd := '0';
          if ( wd = '0' ) or ( StrToIntDef( wd, 0 ) <> 0 ) then
          begin
            if Pos( '-', tmpWdsCh ) = 0 then
              tmpWdsCh := '-' + tmpWdsCh;
            ii := Length( wd );
            if ii > 9 then
              AddVerBigNumWord( 9, 'BILLION' );
            ii := Length( wd );
            if ii > 6 then
              AddVerBigNumWord( 6, 'MILLION' );
            ii := Length( wd );
            if ii > 3 then
              AddVerBigNumWord( 3, 'THOUSAND' );
            ii := Length( wd );
            if ii > 0 then
              AddNumWordUnder1000( wd );
          end
          else
          if Length( wd ) = 1 then
            AddWord( wd + '.' )
          else
          if wd = '1ST' then
            AddWord( 'FIRST' )
          else
          if wd = '2ND' then
            AddWord( 'FIRST' )
          else
          if wd = '3RD' then
            AddWord( 'THIRD' )
          else
          if wd = '4TH' then
            AddWord( 'FOURTH' )
          else
          if wd = '5TH' then
            AddWord( 'FIFTH' )
          else
          if wd = '6TH' then
            AddWord( 'SIXTH' )
          else
          if wd = '7TH' then
            AddWord( 'SEVENTH' )
          else
          if wd = '8TH' then
            AddWord( 'EIGHTH' )
          else
          if wd = '9TH' then
            AddWord( 'NINTH' )
          else
          if wd = '10TH' then
            AddWord( 'TENTH' );
        end;
      end;
    end;
  end;
var
  tmpStr: string;
  tmpLen: integer;
  tmpCh: char;
  lastCh: integer;
  ii: integer;
  SingleCharWord: string;
  SingleCharFlag: boolean;
begin
  if Assigned( AWordList ) then
  begin
    SafeStack := TStringList.Create;
    SafeStack.Duplicates := dupIgnore;
    SafeStack.Sorted := true;
    AWordList.BeginUpdate;
    try
      AWordList.Clear;
      tmpStr := AnsiUpperCase( Trim( AWords ));
      tmpWdsCh := '';
      for ii := 1 to Length( tmpStr ) do
        if ( tmpStr[ii] in SplitWordChars ) and
           ( Pos( tmpStr[ii], tmpWdsCh ) = 0 ) then
          tmpWdsCh := tmpWdsCh + tmpStr[ii];
      if tmpWdsCh <> '' then
      begin
        if Pos( '&', tmpWdsCh ) > 0 then
        begin
          replace_string( tmpStr, ' &', '&' );
          replace_string( tmpStr, '& ', '&' );
        end;
        if Pos( '-', tmpWdsCh ) > 0 then
        begin
          replace_string( tmpStr, ' -', '-' );
          replace_string( tmpStr, '- ', '-' );
        end;
        if Pos( '.', tmpWdsCh ) > 0 then
          replace_string( tmpStr, ' .', '.' );
        if Pos( '+', tmpWdsCh ) > 0 then
        begin
          replace_string( tmpStr, ' +', '+' );
          replace_string( tmpStr, '+ ', '+' );
        end;
      end;
      replace_string( tmpStr, '  ', ' ' );
      tmpStr := SupplySingleCharDots( tmpStr ) + ' ';
      SingleCharWord := '';
      SingleCharFlag := true;
      lastCh := 1;
      tmpLen := Length( tmpStr );
      for ii := 1 to tmpLen do
      begin
        tmpCh := tmpStr[ii];
        if CharIsDelimiter( tmpCh ) then
        begin
          if ii > lastCh then
            AddWord( Trim( Copy( tmpStr, lastCh, ii - lastCh )));
          lastCh := ii;
          if ( not SingleCharFlag ) or ( ii = tmpLen ) then
          begin
            if Pos( '.', tmpWdsCh ) = 0 then
              tmpWdsCh := '.' + tmpWdsCh;
            if SingleCharWord <> '' then
            begin
              AddWord( SingleCharWord );
              SingleCharWord := '';
            end;
          end;
          SingleCharFlag := true;
        end
        else
        if SingleCharFlag then
        begin
          SingleCharFlag := ( ii < tmpLen ) and
                            ( not ( tmpStr[ ii + 1] in ['A'..'Z', '0'..'9'] ));
          if SingleCharFlag then
            if tmpCh in [ 'A'..'Z', '0'..'9' ] then
              SingleCharWord := SingleCharWord + tmpStr[ii] + '.';
        end;
      end;
    finally
      SafeStack.Free;
      AWordList.EndUpdate;
    end;
  end;
end;

procedure GetMergeFields( const MemoText: string;
                          const MergeFields: TStrings );
var
  CurPos: longint;
  ParamFound: boolean;
  ParamName: string;

  procedure AddParameter;
  begin
    ParamFound := false;
    if ( ParamName <> '' ) and
       ( MergeFields.IndexOf( ParamName ) = -1 ) then
      MergeFields.Add( ParamName );
    ParamName := '';
  end;

begin { GetMergeFields }
  if MergeFields = nil then
    Exit;
  MergeFields.Clear;
  if Length( MemoText ) = 0 then
    Exit;
  ParamFound := false;
  ParamName := '';
  CurPos := 0;
  repeat
    Inc( CurPos );
    if ParamFound then
    begin
      if ( MemoText[ CurPos     ] = '>' ) and
         ( MemoText[ CurPos + 1 ] = '>' ) then
      begin
        AddParameter;
        Inc( CurPos );
      end
      else
        ParamName := ParamName + MemoText[ CurPos ];
    end
    else
    if ( MemoText[ CurPos     ] = '<' ) and
       ( MemoText[ CurPos + 1 ] = '<' ) then
    begin
      ParamFound := True;
      Inc(CurPos, 1);
    end;
  until CurPos >= Length( MemoText ) - 1;
  if ParamFound then
    AddParameter;
end;  { GetMergeFields }

{------------------------------------------------------------------------------}


const
  SQLTokenCount = 271;

var
  SQLTokens: array [0..SQLTokenCount-1] of string = (
                           'ACTION' ,
                           'ACTIVE' ,
                           'ADD' ,
                           'ADMIN' ,
                           'AFTER' ,
                           'ALL' ,
                           'ALTER' ,
                           'AND' ,
                           'ANY' ,
                           'AS' ,
                           'ASC' ,
                           'ASCENDING' ,
                           'AT' ,
                           'AUTO' ,
                           'AUTODDL' ,
                           'AVG' ,
                           'BASE_NAME' ,
                           'BASED' ,
                           'BASENAME' ,
                           'BEFORE' ,
                           'BEGIN' ,
                           'BETWEEN' ,
                           'BLOB' ,
                           'BLOBEDIT' ,
                           'BUFFER' ,
                           'BY' ,
                           'CACHE' ,
                           'CASCADE' ,
                           'CAST' ,
                           'CHAR' ,
                           'CHAR_LENGTH' ,
                           'CHARACTER' ,
                           'CHARACTER_LENGTH' ,
                           'CHECK' ,
                           'CHECK_POINT_LEN' ,
                           'CHECK_POINT_LENGTH' ,
                           'CLOSE' ,
                           'COLLATE' ,
                           'COLLATION' ,
                           'COLUMN' ,
                           'COMMIT' ,
                           'COMMITTED' ,
                           'COMPILETIME' ,
                           'COMPUTED' ,
                           'CONDITIONAL' ,
                           'CONNECT' ,
                           'CONSTRAINT' ,
                           'CONTAINING' ,
                           'CONTINUE' ,
                           'COUNT' ,
                           'CREATE' ,
                           'CSTRING' ,
                           'CURRENT' ,
                           'CURSOR' ,
                           'DATABASE' ,
                           'DATE' ,
                           'DAY' ,
//                         'DB_KEY',
                           'DEBUG' ,
                           'DEC' ,
                           'DECIMAL' ,
                           'DECLARE' ,
                           'DEFAULT' ,
                           'DELETE' ,
                           'DESC' ,
                           'DESCENDING' ,
                           'DESCRIBE' ,
                           'DESCRIPTOR' ,
                           'DISCONNECT' ,
                           'DISPLAY' ,
                           'DISTINCT' ,
                           'DO' ,
                           'DOMAIN' ,
                           'DOUBLE' ,
                           'DROP' ,
                           'ECHO' ,
                           'EDIT' ,
                           'ELSE' ,
                           'END' ,
                           'ENTRY_POINT' ,
                           'ESCAPE' ,
                           'EVENT' ,
                           'EXCEPTION' ,
                           'EXECUTE' ,
                           'EXISTS' ,
                           'EXIT' ,
                           'EXTERN' ,
                           'EXTERNAL' ,
                           'EXTRACT' ,
                           'FETCH' ,
                           'FILE' ,
                           'FILTER' ,
                           'FLOAT' ,
                           'FOR' ,
                           'FOREIGN' ,
                           'FOUND' ,
                           'FREE_IT' ,
                           'FROM' ,
                           'FULL' ,
                           'FUNCTION' ,
                           'GDSCODE' ,
                           'GEN_ID' ,
                           'GENERATOR' ,
                           'GLOBAL' ,
                           'GOTO' ,
                           'GRANT' ,
                           'GROUP' ,
                           'GROUP_COMMIT_' ,
                           'GROUP_COMMIT_WAIT' ,
                           'HAVING' ,
                           'HELP' ,
                           'IF' ,
                           'IMMEDIATE' ,
                           'IN' ,
                           'INACTIVE' ,
                           'INDEX' ,
                           'INDICATOR' ,
                           'INIT' ,
                           'INNER' ,
                           'INPUT' ,
                           'INPUT_TYPE' ,
                           'INSERT' ,
                           'INT' ,
                           'INTEGER' ,
                           'INTO' ,
                           'IS' ,
                           'ISOLATION' ,
                           'ISQL' ,
                           'JOIN' ,
                           'KEY' ,
                           'LC_MESSAGES' ,
                           'LC_TYPE' ,
                           'LEFT' ,
                           'LENGTH' ,
                           'LENGTH' ,
                           'LEV' ,
                           'LEVEL' ,
                           'LIKE' ,
                           'LOG_BUF_SIZE' ,
                           'LOG_BUFFER_SIZE' ,
                           'LOGFILE' ,
                           'LONG' ,
                           'MANUAL' ,
                           'MAX' ,
                           'MAX_SEGMENT' ,
                           'MAXIMUM' ,
                           'MAXIMUM_SEGMENT' ,
                           'MENT' ,
                           'MERGE' ,
                           'MESSAGE' ,
                           'MIN' ,
                           'MINIMUM' ,
                           'MODULE_NAME' ,
                           'MONTH' ,
                           'NAMES' ,
                           'NATIONAL' ,
                           'NATURAL' ,
                           'NCHAR' ,
                           'NO' ,
                           'NOAUTO' ,
                           'NOT' ,
                           'NULL' ,
                           'NUM_LOG_BUFFERS' ,
                           'NUM_LOG_BUFS' ,
                           'NUMERIC' ,
                           'OCTET_LENGTH' ,
                           'OF' ,
                           'ON' ,
                           'ONLY' ,
                           'OPEN' ,
                           'OPTION' ,
                           'OR' ,
                           'ORDER' ,
                           'OUTER' ,
                           'OUTPUT' ,
                           'OUTPUT_TYPE' ,
                           'OVERFLOW' ,
                           'PAGE' ,
                           'PAGE_SIZE' ,
                           'PAGES' ,
                           'PARAMETER' ,
                           'PASSWORD' ,
                           'PLAN' ,
                           'POSITION' ,
                           'POST_EVENT' ,
                           'PRECISION' ,
                           'PREPARE' ,
                           'PRIMARY' ,
                           'PRIVILEGES' ,
                           'PROCEDURE' ,
                           'PROTECTED' ,
                           'PUBLIC' ,
                           'QUIT' ,
                           'RAW_PARTITIONS' ,
//                         'RDB$DB_KEY',
                           'READ' ,
                           'REAL' ,
                           'RECORD_VERSION' ,
                           'REFERENCES' ,
                           'RELEASE' ,
                           'RESERV' ,
                           'RESERVING' ,
                           'RESTRICT' ,
                           'RETAIN' ,
                           'RETURN' ,
                           'RETURNING_VALUES' ,
                           'RETURNS' ,
                           'REVOKE' ,
                           'RIGHT' ,
                           'ROLE' ,
                           'ROLLBACK' ,
                           'RUNTIME' ,
                           'SCHEMA' ,
                           'SEGMENT' ,
                           'SELECT' ,
                           'SET' ,
                           'SHADOW' ,
                           'SHARED' ,
                           'SHELL' ,
                           'SHOW' ,
                           'SINGULAR' ,
                           'SIZE' ,
                           'SMALLINT' ,
                           'SNAPSHOT' ,
                           'SOME' ,
                           'SORT' ,
                           'SQL' ,
                           'SQLCODE' ,
                           'SQLERROR' ,
                           'SQLWARNING' ,
                           'STABILITY' ,
                           'STARTING' ,
                           'STARTS' ,
                           'STATE' ,
                           'STATIC' ,
                           'STATISTICS' ,
                           'SUB_TYPE' ,
                           'SUM' ,
                           'SUSPEND' ,
                           'TABLE' ,
                           'TERMINATOR' ,
                           'THEN' ,
                           'TO' ,
                           'TRANSACTION' ,
                           'TRANSLATE' ,
                           'TRANSLATION' ,
                           'TRIGGER' ,
                           'TRIM' ,
                           'TYPE', 
                           'UNCOMMITTED' ,
                           'UNION' ,
                           'UNIQUE' ,
                           'UPDATE' ,
                           'UPPER' ,
                           'USER' ,
                           'USING' ,
                           'VALUE' ,
                           'VALUES' ,
                           'VARCHAR' ,
                           'VARIABLE' ,
                           'VARYING' ,
                           'VERSION' ,
                           'VIEW' ,
                           'WAIT' ,
                           'WAIT_TIME' ,
                           'WHEN' ,
                           'WHENEVER' ,
                           'WHERE' ,
                           'WHILE' ,
                           'WITH' ,
                           'WORK' ,
                           'WRITE',
                           'YEAR' );

function isSQLQuoteToken( AToken: string ): boolean;
var
  ii,
  Low,
  Mid,
  High: integer;
begin
  Result := false;
  if CheckForReservedTokens then
  begin
    if Length( AToken ) = 0 then
      Exit;
    AToken := UpperCase( AToken );
    Low := 0;
    High := SQLTokenCount - 1;
    repeat
      Mid := Low + (( High -Low ) shr 1 );
      if AToken[ 1 ] <> SQLTokens[ Mid ][ 1 ] then
        begin
        if AToken[ 1 ] < SQLTokens[ Mid ][ 1 ] then
          High := Mid - 1
        else
          Low := Mid + 1;
        end
      else
      begin
        ii := StrComp( @AToken[ 1 ], @SQLTokens[ Mid ][ 1 ] );
        if ii = 0 then
          Result := true
        else
        if ii < 0 then
          High := Mid - 1
        else
          Low := Mid + 1;
      end;
    until Result or ( Low > High );
  end;
end;

function mkIdent(       SQLDialect: integer;
                        ODSMajor, ODSMinor: word;
                  const Identifier: string ): string;
var
  ii: integer;
  NeedQuotes: boolean;
begin
  Result := Trim( Identifier );
  if ( Result = '' ) then
  begin
    if ( SQLDialect >= 3 ) then
      Result := '""'
  end
  else
  begin
    if ( SQLDialect < 3 ) {and ( ODSMajor < 10 )} then
      Result := AnsiUpperCase( Result )
    else
    begin
      if not isLitCriteria( Result, '"' ) then
      begin
        NeedQuotes := false;
        if not ( Result[1] in [ 'A'..'Z', 'a'..'z' ] ) then
          NeedQuotes := true
        else
        for ii := 2 to Length( Result ) do
          if not ( Result[ii] in ['0'..'9','_','$','A'..'Z','a'..'z'] ) then
          begin
            NeedQuotes := true;
            Break;
          end;
        if NeedQuotes then
          Result := '"' + cvLitCriteria( Result, '"' ) + '"'
        else
        if isSQLQuoteToken( Result ) then
          Result := '"' + AnsiUpperCase( cvLitCriteria( Result, '"' )) + '"'
        else
          Result := AnsiUpperCase( Result );
      end;
    end;
  end;
end;

function mkVARIdent(       SQLDialect: integer;
                           ODSMajor, ODSMinor: word;
                     const Identifier: string ): string;
var
  ii: integer;
  NeedQuotes: boolean;
begin
  Result := Trim( Identifier );
  if ( Result = '' ) then
  begin
    if ( SQLDialect >= 3 ) then
      Result := '""'
  end
  else
  begin
    if ( SQLDialect < 3 ) {and ( ODSMajor < 10 )} then
      Result := AnsiUpperCase( Result )
    else
    begin
      NeedQuotes := false;
      Result := Identifier;
      if not ( Result[1] in [ 'A'..'Z' ] ) then
        NeedQuotes := true
      else
      for ii := 2 to Length( Result ) do
        if not ( Result[ii] in [ '0'..'9', '_', '$', 'A'..'Z' ] ) then
        begin
          NeedQuotes := true;
          Break;
        end;
      if NeedQuotes then
        Result := '"' + cvLitCriteria( Result, '"' ) + '"'
      else
      if isSQLQuoteToken( Result ) then
        Result := '"' + AnsiUpperCase( cvLitCriteria( Result, '"' )) + '"'
      else
        Result := AnsiUpperCase( Result );
    end;
  end;
end;

function mkFldLst(       SQLDialect: integer;
                         ODSMajor, ODSMinor: word;
                   const AValue: string ): string;
var
  FieldName: string;
  ii: integer;
begin
  Result := '';
  if SQLDialect = 1 then
  begin
    for ii := 1 to Length( AValue ) do
    begin
      if AValue[ii] = ';' then
        Result := Result + ', '
      else
        Result := Result + AValue[ii];
    end;
  end
  else
  begin
    ii := 1;
    while ii <= Length( AValue ) do
    begin
      FieldName := ExtractFieldName( AValue, ii );
      if Result = '' then
        Result := mkIdent( SQLDialect, ODSMajor, ODSMinor, FieldName )
      else
        Result := Result + ', ' + mkIdent( SQLDialect,
                                           ODSMajor,
                                           ODSMinor,
                                           FieldName );
    end;
  end;
end;

function exIdent(       SQLDialect: integer;
                        ODSMajor, ODSMinor: word;
                  const Identifier: string ): string;
begin
  if SQLDialect = 1 then
    Result := AnsiUpperCase( Trim( Identifier ))
  else
    Result := stLitCriteria( TrimRight( Identifier ));
end;

function isLitCriteria( const AStr: string; lit: char ): Boolean;
var
  tmpLen: integer;
  tmpStr: string;
begin
  tmpStr := Trim( AStr );
  tmpLen := Length( tmpStr );
  Result := tmpLen > 1;
  if Result then
    if lit in [ '''', '"' ] then
      Result := (( tmpStr[1] = lit ) and ( tmpStr[ tmpLen ] = lit ))
    else
      Result := (( tmpStr[1] = '''' ) and ( tmpStr[ tmpLen ] = '''' )) or
                (( tmpStr[1] = '"' ) and ( tmpStr[ tmpLen ] = '"' ))
end;

function cvLitCriteria( const str: string; ch: char ): string;
var
  ii: integer;
begin
  Result := '';
  for ii := 1 to Length( str ) do begin
    if str[ii] = ch then begin
      Result := Result + ch + ch;
    end else begin
      Result := Result + str[ii];
    end;
  end;
end;

function mkLitCriteria( const str: string; ch: char ): string;
begin
  if isLitCriteria( str, ch ) then
    Result := str
  else
    Result := ch + cvLitCriteria( str, ch ) + ch;
end;

function rvLitCriteria( const str: string; ch: char ): string;
var
  ii: integer;
begin
  Result := '';
  ii := 1;
  while ii <= Length( str ) do
  begin
    if str[ii] = ch then
    begin
      Result := Result + str[ii];
      if ( ii < Length( str ) ) and ( str[ii + 1 ] = ch ) then
        Inc( ii );
    end
    else
      Result := Result + str[ii];
    Inc( ii );
  end;
end;

function stLitCriteria( const str: string ): string;
var
  ch: char;
begin
  if isLitCriteria( str, ' ' ) then
  begin
    ch := str[1];
    Result := Copy( str, 2, Length( str ) - 2 );
    Result := rvLitCriteria( Result, ch );
  end
  else
    Result := str;
end;

function getLitSafePos(       Ch: char;
                        const AStr: string;
                              StartPos: integer ): integer;
var
  ii: integer;
  Lit: boolean;
begin
  Result := 0;
  Lit := false;
  if StartPos < 1 then
    StartPos := 1;
  for ii := StartPos to Length( AStr ) do
  begin
    if AStr[ii] = '"' then
      Lit := not Lit;
    if not Lit and ( AStr[ii] = Ch ) then
    begin
      Result := ii;
      Break;
    end;
  end;
end;

function getLitsRoundSafePos(       Ch: char;
                              const AStr: string;
                                    StartPos: integer ): integer;
var
  ii: integer;
  Lit1: boolean;
  Lit2: boolean;
  rndCnt: integer;
begin
  rndCnt := 0;
  Result := 0;
  Lit1 := false;
  Lit2 := false;
  if StartPos < 1 then
    StartPos := 1;
  for ii := StartPos to Length( AStr ) do
  begin
    if not Lit2 then
      if AStr[ii] = '"' then
      begin
        Lit1 := not Lit1;
        Continue;
      end;
    if not Lit1 then
      if AStr[ii] = '''' then
      begin
        Lit2 := not Lit2;
        Continue;
      end;
    if not Lit1 and not Lit2 then
    begin
      if ( rndCnt = 0 ) and ( AStr[ii] = Ch ) then
      begin
        Result := ii;
        Break;
      end;
      if AStr[ii] = '(' then Inc( rndCnt ) else
      if AStr[ii] = ')' then Dec( rndCnt );
    end;
  end;
end;

function getLitSafePosFromRight(       Ch: char;
                                 const AStr: string;
                                       StartPos: integer;
                                       PassPureTokenOnly: boolean ): integer;
var
  ii: integer;
  Lit: boolean;
begin
  Result := 0;
  if StartPos = 0 then
    StartPos := Length( AStr );
  if StartPos < 1 then
    Exit;
  Lit := false;
  for ii := StartPos downto 1 do
  begin
    if AStr[ii] = '"' then
      Lit := not Lit;
    if not Lit and ( AStr[ii] = Ch ) then
    begin
      Result := ii;
      Break;
    end
    else
    if PassPureTokenOnly and CharIsDelimiter( AStr[ii] ) then
      Break;
  end;
end;

function getLitSafeStrPos( const S: string;
                           const AStr: string;
                                 StartPos: integer ): integer;
var
  ii, jj: integer;
  Lit: boolean;
begin
  Result := 0;
  Lit := false;
  if S <> '' then
  begin
    if Length( S ) = 1 then
      Result := getLitSafePos( S[1], AStr, StartPos )
    else
    begin
      if StartPos < 1 then
        StartPos := 1;
      for ii := StartPos to Length( AStr ) - Length( S ) + 1 do
      begin
        if AStr[ii] = '"' then
          Lit := not Lit;
        if not Lit and ( AStr[ii] = S[1] ) then
        begin
          for jj := 2 to Length( S ) do
          begin
            if AStr[ii + jj - 1] <> S[jj] then
              Break;
            if jj = Length( S ) then
              Result := ii;
          end;
          if Result <> 0 then
            Break;
        end;
      end;
    end;
  end;
end;

function getLitsRoundSafeStrPos(       S: string;
                                 const AStr: string;
                                       StartPos: integer;
                                       IgnoreComments,
                                       TokenOnly: boolean ): integer;
var
  ii, jj: integer;
  Lit1: boolean;
  Lit2: boolean;
  Cmt1: boolean;
  Cmt2: boolean;
  SkipChar: boolean;
  rndCnt: integer;
begin
  Result := 0;
  rndCnt := 0;
  Lit1 := false;
  Lit2 := false;
  Cmt1 := false;
  Cmt2 := false;
  SkipChar := false;
  if S <> '' then
  begin
    if StartPos < 1 then
      StartPos := 1;
    for ii := StartPos to Length( AStr ) - Length( S ) + 1 do
    begin
      if SkipChar then
      begin
        SkipChar := false;
        Continue;
      end;
      if not Cmt1 and not Cmt2 then
      begin
        if not Lit1 and not Lit2 then
        begin
          if AStr[ii] = '/' then
          begin
            if Length( AStr ) > ii then
            begin
              if AStr[ii+1] = '*' then
              begin
                Cmt1 := true;
                SkipChar := true;
                Continue;
              end;
              if AStr[ii+1] = '/' then
              begin
                Cmt2 := true;
                SkipChar := true;
                Continue;
              end;
            end;
          end;
        end;
        if not Lit2 then
          if AStr[ii] = '"' then
          begin
            Lit1 := not Lit1;
            Continue;
          end;
        if not Lit1 and not Cmt1 and not Cmt2 then
          if AStr[ii] = '''' then
          begin
            Lit2 := not Lit2;
            Continue;
          end;
      end
      else
      if not Lit1 and not Lit2 then
      begin
        if Cmt1 then
        begin
          if AStr[ii] = '*' then
          begin
            if Length( AStr ) > ii then
            begin
              if AStr[ii+1] = '/' then
              begin
                Cmt1 := false;
                SkipChar := true;
                Continue;
              end;
            end;
          end;
        end
        else
        if Cmt2 then
        begin
          if ( AStr[ii] = #10 ) or
             ( AStr[ii] = #13 ) then
          begin
            Cmt2 := false;
            if Length( AStr ) > ii then
            begin
              if ( AStr[ii+1] = #10 ) or
                 ( AStr[ii+1] = #13 ) then
              begin
                SkipChar := true;
              end;
            end;
            Continue;
          end;
        end;
      end;
      if not Cmt1 and not Cmt2 and not Lit1 and not Lit2 then
      begin
        if ( rndCnt = 0 ) then
        begin
          if AStr[ii] = S[1] then
          begin
            if Length( S ) = 1 then
              Result := ii
            else
            begin
              for jj := 2 to Length( S ) do
              begin
                if AStr[ii + jj - 1] <> S[jj] then
                  Break;
                if jj = Length( S ) then
                  Result := ii;
              end;
              if TokenOnly then
              begin
                if (( ii > 1 ) and
                    not CharIsDelimiter( AStr[ ii - 1 ] )) or
                   (( ii < Length( AStr ) - Length( S )) and
                    not CharIsDelimiter( AStr[ ii + Length( S )] )) then
                  Result := 0;
              end;
            end;
            if Result <> 0 then
              Break;
          end;
        end;
        if AStr[ii] = '(' then Inc( rndCnt ) else
        if AStr[ii] = ')' then Dec( rndCnt );
      end;
    end;
  end;
end;

function contains_wildcards( const str: string; escape: char ): Boolean;
var
  ii: integer;
begin
  Result := false;
  ii := 1;
  while ii <= Length( str ) do
  begin
    if str[ii] = escape then
      Inc(ii)
    else
    begin
      if (str[ii] = '%') or
         (str[ii] = '_') or
         (str[ii] = '*') or
         (str[ii] = '?') then
      begin
         Result := true;
         break;
      end;
    end;
    Inc(ii);
  end;
end;

function contains_sqlwildcards( const str: string; escape: char ): Boolean;
var
  ii: integer;
begin
  Result := false;
  ii := 1;
  while ii <= Length( str ) do
  begin
    if str[ii] = escape then
      Inc(ii)
    else
    begin
      if (str[ii] = '%') or
         (str[ii] = '_') then
      begin
         Result := true;
         break;
      end;
    end;
    Inc(ii);
  end;
end;

function convert_wildcards_tosql( const str: string; escape: char ): string;
var
  ii: integer;
begin
  Result := '';
  ii := 1;
  while ii <= Length( str ) do begin
    // If found an escape character before the end of the string
    if (str[ii] = escape) and (ii < Length(str)) then begin
      Inc(ii);
      // If escape for standard sql the pass on both
      // the escape and the sql pattern/escape character
      if (str[ii] = '%') or
         (str[ii] = '_') or
         (str[ii] = escape) then begin
         Result := Result + str[ii-1];
         Result := Result + str[ii];
      // For any other escape sequence (such as the alternate pattern
      // characters) we can just pass on the character without the escape
      end else begin
        Result := Result + str[ii];
      end;
    end else begin
      // if no escape just translate the alternate mask characters
      if str[ii] = '*' then begin
        Result := Result + '%';
      end else if str[ii] = '?' then begin
        Result := Result + '_';
      end else begin
        Result := Result + str[ii];
      end;
    end;
    Inc(ii);
  end;
end;

function strip_escapechar( const str: string; escape: char ): string;
var
  ii: integer;
begin
  Result := '';
  ii := 1;
  while ii <= Length( str ) do begin
    if (str[ii] = escape) and (ii < Length(str)) then
      Inc(ii);
    Result := Result + str[ii];
    Inc(ii);
  end;
end;

function beginswith_sqllike( const str: string ): Boolean;
begin
  Result := (Copy(AnsiLowerCase(str), 1,  5 ) = 'like '          ) or
            (Copy(AnsiLowerCase(str), 1,  9 ) = 'not like '      );
end;

function beginswith_sqlsearch( const str: string ): Boolean;
begin
  Result := false;
  if Length( str ) > 0 then case str[1] of
    'b','B':
      Result := (Copy(AnsiLowerCase(str), 1,  8 ) = 'between '       );
    'c','C':
      Result := (Copy(AnsiLowerCase(str), 1, 11 ) = 'containing '    );
    'i','I':
      Result := (Copy(AnsiLowerCase(str), 1,  3 ) = 'in('            ) or
                (Copy(AnsiLowerCase(str), 1,  7 ) = 'is null'        ) or
                (Copy(AnsiLowerCase(str), 1, 11 ) = 'is not null'    );
    'l','L':
      Result := (Copy(AnsiLowerCase(str), 1,  5 ) = 'like '          );
    'n','N':
      Result := (Copy(AnsiLowerCase(str), 1,  9 ) = 'not like '      ) or
                (Copy(AnsiLowerCase(str), 1, 13 ) = 'not starting '  ) or
                (Copy(AnsiLowerCase(str), 1, 15 ) = 'not containing ') or
                (Copy(AnsiLowerCase(str), 1,  7 ) = 'not in('        ) or
                (Copy(AnsiLowerCase(str), 1, 12 ) = 'not between '   );
    's','S':
      Result := (Copy(AnsiLowerCase(str), 1,  9 ) = 'starting '      );
  end;
end;

function contains_relational_ops( const str: string ): boolean;
begin
  Result := (Pos( '!', str ) <> 0) or
            (Pos( '<', str ) <> 0) or
            (Pos( '>', str ) <> 0) or
            (Pos( '=', str ) <> 0);
end;

function rel_op_pos( const str: string ): longint;
var
  tmpPos: integer;
begin
  Result := 0;
  tmpPos := 1;
  while tmpPos <= Length( str ) do
  begin
    if str[ tmpPos ] in [ '!', '<', '>', '=' ] then
    begin
      Result := tmpPos;
      Break;
    end
    else
    if tmpPos > 3 then
      Break
    else
      Inc( tmpPos );
  end;
end;

function get_00AM: string;
begin
  Result := FormatDateTime( LongTimeFormat, EncodeTime( 0, 0, 0, 0 ));
end;

function get_12PM: string;
begin
  Result := FormatDateTime( LongTimeFormat, EncodeTime( 23, 59, 59, 999 ));
end;

function get_IBDateLiteral( ADateTime: TDateTime ): string;
begin
  if ADateTime = Trunc( ADateTime ) then
    Result := FormatDateTime( DT_DateFormat, ADateTime )
  else
    Result := FormatDateTime( DT_DateFormat + ' ' + DT_TimeFormat, ADateTime );
  Result := '''' + Result + '''';
end;

function get_IBNumericLiteral( const ANumeric: string ): string;
var
  tmpPos: integer;
begin
  Result := ANumeric;
  if DecimalSeparator <> '.' then
  begin
    tmpPos := Pos( DecimalSeparator, Result );
    while tmpPos > 0 do
    begin
      Result[ tmpPos ] := '.';
      tmpPos := Pos( DecimalSeparator, Result );
    end;
  end;
end;

function get_IBDateSLiteral( const ADateTime: string;
                                   IncDays: integer ): string;
var
  tmpStr: string;
begin
  tmpStr := stLitCriteria( ADateTime );
  Result := get_IBDateLiteral( StrToDateTime( tmpStr ) + IncDays );
end;

function get_DateLength( const Text: string ): longint;
begin
  if IsMatch( '[0-9][0-9]'      + DateSeparator +
              '[a-Z][a-Z][a-Z]' + DateSeparator +
              '[0-9][0-9][0-9][0-9]*', Text ) then Result := 11 else
  if IsMatch( '[0-9][0-9]'      + DateSeparator +
              '[0-9][0-9]'      + DateSeparator +
              '[0-9][0-9][0-9][0-9]*', Text ) then Result := 10 else
  if IsMatch( '[0-9]'           + DateSeparator +
              '[A-z][A-z][A-z]' + DateSeparator +
              '[0-9][0-9][0-9][0-9]*', Text ) then Result := 10 else
  if IsMatch( '[0-9][0-9]'      + DateSeparator +
              '[0-9]'           + DateSeparator +
              '[0-9][0-9][0-9][0-9]*', Text ) then Result := 9 else
  if IsMatch( '[0-9][0-9]'      + DateSeparator +
              '[A-z][A-z][A-z]' + DateSeparator +
              '[0-9][0-9]*',           Text ) then Result := 9 else
  if IsMatch( '[0-9]'           + DateSeparator +
              '[0-9][0-9]'      + DateSeparator +
              '[0-9][0-9][0-9][0-9]*', Text ) then Result := 9 else
  if IsMatch( '[0-9]'           + DateSeparator +
              '[A-z][A-z][A-z]' + DateSeparator +
              '[0-9][0-9]*',           Text ) then Result := 8 else
  if IsMatch( '[0-9][0-9]'      + DateSeparator +
              '[0-9][0-9]'      + DateSeparator +
              '[0-9][0-9]*',           Text ) then Result := 8 else
  if IsMatch( '[0-9]'           + DateSeparator +
              '[0-9]'           + DateSeparator +
              '[0-9][0-9][0-9][0-9]*', Text ) then Result := 8 else
  if IsMatch( '[0-9][0-9]'      + DateSeparator +
              '[0-9]'           + DateSeparator +
              '[0-9][0-9]*',           Text ) then Result := 7 else
  if IsMatch( '[0-9]'           + DateSeparator +
              '[0-9][0-9]'      + DateSeparator +
              '[0-9][0-9]*',           Text ) then Result := 7 else
  if IsMatch( '[0-9]'           + DateSeparator +
              '[0-9]'           + DateSeparator +
              '[0-9][0-9]*',           Text ) then Result := 6 else
                                                   Result := 0;
end;

function get_HasTime( const Text: string ): boolean;
var
  tmpStr: string;
begin
  tmpStr := Trim( Text );
  tmpStr := Trim( Copy( tmpStr, get_DateLength( tmpStr ) + 1, 255 ));
  if IsMatch( '[0-9][0-9]' + TimeSeparator +
              '[0-9][0-9]*', tmpStr ) then Result := true else
  if IsMatch( '[0-9]'      + TimeSeparator +
              '[0-9][0-9]*', tmpStr ) then Result := true else
  if IsMatch( '[0-9]'      + TimeSeparator +
              '[0-9][0-9]*', tmpStr ) then Result := true else
  if IsMatch( '[0-9]'      + TimeSeparator +
              '[0-9]*',      tmpStr ) then Result := true
                                      else Result := false;
end;

function GetRelOps( var AText: string ): string;
var
  ii: integer;
  tmpPos1: integer;
  tmpPos2: integer;
  tmpPos3: integer;
begin
  Result := '';
  if contains_relational_ops( Copy( Trim( AText ), 1, 3 )) then
  begin
    ii := rel_op_pos( AText );
    if Trim( Copy( AText, 1, ii - 1 )) <> '' then
      Exit;
    repeat
      ii := rel_op_pos( AText );
      if (ii > 0) and ( Length( Result ) < 2 ) then
      begin
        if Result <> AText[ii] then
          Result := Result + AText[ii];
        Delete( AText, ii, 1 );
        if ii <> rel_op_pos( AText ) then
          Break;
      end;
    until ( ii = 0 ) or ( Length( Result ) = 2 );
  end
  else
  begin
    tmpPos1 := getLitSafeStrPos( 'IS ', UpperCase( AText ), 1 );
    if tmpPos1 > 0 then
    begin
      tmpPos2 := getLitSafeStrPos( ' NULL', UpperCase( AText ), 1 );
      if tmpPos2 > tmpPos1 then
      begin
        tmpPos3 := getLitSafeStrPos( ' NOT ', UpperCase( AText ), 1 );
        if ( tmpPos3 > tmpPos1 ) and ( tmpPos2 > tmpPos3 ) then
          Result := 'IS NOT NULL'
        else
          Result := 'IS NULL';
        if Trim( Copy( AText, 1, tmpPos1 - 1 )) = '' then
          Delete( AText, tmpPos1, tmpPos2 - tmpPos1 + 5 )
        else
          Result := '';
      end;
    end;
  end;
end;

type
  THackConnection = class ( TIB_Connection )
  end;

procedure ExtractWhereClause( IB_Field: TIB_Column;
                              SearchBuffer: string;
                              WhereClause,
                              Parameters,
                              Macros: TStrings );

  function GetPName( S: integer ): string;
  begin
    Result := IB_QBE_PARAMETER + IntToStr( S ) + IntToStr( IB_Field.FieldNo ) +
              '_' + IntToStr( longint( @SearchBuffer ));
  end;

  function SetParameterAttributes( S: integer ): boolean;
  begin
    Result := false;
  end;

var
  fld,
  sxfld,  // Stores SoundEx attribute field name if available
  sxval,  // stores a DoSoundExParse result
  sxmax,  // stores a DoSoundExMaxParse result
  text_str,
  tmp_str,
  alt_str,
  ops: string;
  EscChar: char;
  tmp_int: integer;
  ii: integer;
  DefaultHandling: boolean;
  DecimalLength: integer;
begin  { ExtractWhereClause }
  if Parameters = nil then Exit;
  if IB_Field = nil then Exit;
  if SearchBuffer = '' then Exit;
  DefaultHandling := true;
  with THackConnection( IB_Field.Statement.IB_Connection ) do
  begin
    EscChar := EscapeCharacter;
    DoProcessSearchBuffer( IB_Field,
                           SearchBuffer,
                           WhereClause,
                           Parameters,
                           Macros,
                           DefaultHandling );
  end;
  if not DefaultHandling then Exit;
  with IB_Field do
  begin
    fld := '';
    if ( SQLName <> '' ) then
    begin
      if ( SQLType = SQL_VARYING  ) or
         ( SQLType = SQL_VARYING_ ) or
         ( SQLType = SQL_TEXT     ) or
         ( SQLType = SQL_TEXT_    ) then
      begin
        fld := NoCaseFieldName;
        if fld = '' then
          fld := FullFieldName
        else
          SearchBuffer := AnsiUpperCase( SearchBuffer );
      end
      else
        fld := BestFieldName
    end;
    if fld = '' then
      fld := GetCharValues( Statement.SysFieldNames[FieldNo] );
  end;
  text_str := Trim( SearchBuffer );
  if ( Copy( AnsiLowerCase( text_str ), 1,  7 ) = 'is null'     ) or
     ( Copy( AnsiLowerCase( text_str ), 1, 11 ) = 'is not null' ) then
  begin
    WhereClause.Add( fld + ' ' + text_str );
  end else if Copy( AnsiLowerCase( text_str ), 1,  3 ) = 'in(' then
  begin
    if ( IB_Field.SQLType = SQL_TIMESTAMP  ) or
       ( IB_Field.SQLType = SQL_TIMESTAMP_ ) or
       ( IB_Field.SQLType = SQL_TYPE_DATE  ) or
       ( IB_Field.SQLType = SQL_TYPE_DATE_ ) or
       ( IB_Field.IsNumeric ) then
    begin
      text_str := Trim( AnsiUpperCase( Copy( text_str, 4,  MaxInt )));
      tmp_int := Length( text_str );
      if ( tmp_int > 0 ) and ( text_str[ tmp_int ] = ')' ) then
      begin
        System.Delete( text_str, Length( text_str ), 1 );
        text_str := Trim( text_str );
      end else
        raise Exception.Create( 'Invalid SearchBuffer IN() clause' );
      alt_str := '';
      ii := 0;
      repeat
        if ii > 0 then alt_str := alt_str + ', ';
        if ( DecimalSeparator = ',' ) and IB_Field.IsNumeric then
        begin
          tmp_int := Pos( ', ', text_str );
          DecimalLength := 2;
        end
        else
        begin
          tmp_int := Pos( ',', text_str );
          DecimalLength := 1;
        end;
        if tmp_int > 0 then
        begin
          tmp_str := Trim( Copy( text_str, 1, tmp_int - 1 ));
          text_str := Trim( Copy( text_str, tmp_int + DecimalLength, MaxInt ));
        end
        else
        begin
          tmp_str := text_str;
          text_str := '';
        end;
        if ( IB_Field.SQLType = SQL_TIMESTAMP  ) or
           ( IB_Field.SQLType = SQL_TIMESTAMP_ ) or
           ( IB_Field.SQLType = SQL_TYPE_DATE  ) or
           ( IB_Field.SQLType = SQL_TYPE_DATE_ ) then
        begin
          alt_str := alt_str + get_IBDateSLiteral( tmp_str, 0 );
        end
        else
        if (( IB_Field.SQLType = SQL_DOUBLE  ) or
            ( IB_Field.SQLType = SQL_DOUBLE_ )) and
           SetParameterAttributes(ii) then
        begin
          alt_str := alt_str + '?' + GetPName(ii);
          Parameters.Values[ GetPName(ii) ] := tmp_str;
        end
        else
          alt_str := alt_str + get_IBNumericLiteral( tmp_str );
        Inc( ii );
      until text_str = '';
      text_str := 'IN( ' + alt_str + ' )';
    end;
    WhereClause.Add( fld + ' ' + text_str );
  end
  else
  if Copy( AnsiLowerCase( text_str ), 1,  8 ) = 'between ' then
  begin
    if ( IB_Field.SQLType = SQL_TIMESTAMP    ) or
       ( IB_Field.SQLType = SQL_TIMESTAMP_   ) or
       ( IB_Field.SQLType = SQL_TYPE_DATE    ) or
       ( IB_Field.SQLType = SQL_TYPE_DATE_   ) or
       ( IB_Field.IsNumeric ) then
    begin
      text_str := AnsiUpperCase( Copy( text_str, 8,  MaxInt ));
      tmp_int := Pos( ' AND ', text_str );
      if tmp_int <> 0 then
      begin
        tmp_str := Trim( Copy( text_str, 1, tmp_int ));
        alt_str := Trim( Copy( text_str, tmp_int + 5, MaxInt ));
        if ( IB_Field.SQLType = SQL_TIMESTAMP  ) or
           ( IB_Field.SQLType = SQL_TIMESTAMP_ ) or
           ( IB_Field.SQLType = SQL_TYPE_DATE  ) or
           ( IB_Field.SQLType = SQL_TYPE_DATE_ ) then
        begin
          text_str := get_IBDateSLiteral( tmp_str, 0 ) + ' AND ' +
                      get_IBDateSLiteral( alt_str, 0 );
        end
        else
        if SetParameterAttributes(0) and
           SetParameterAttributes(1) then
        begin
          text_str := '?' + GetPName(0) + ' AND ?' + GetPName(1);
          Parameters.Values[ GetPName(0)] := tmp_str;
          Parameters.Values[ GetPName(1)] := alt_str;
        end
        else
        begin
          text_str := get_IBNumericLiteral( tmp_str ) + ' AND ' +
                      get_IBNumericLiteral( alt_str );
        end;
        text_str := 'BETWEEN ' + text_str;
      end else begin
        raise EIB_Error.Create( E_INVALID_QBE_BETWEEN );
      end;
    end;
    WhereClause.Add( fld + ' ' + text_str );
  end else if beginswith_sqllike( text_str ) then begin
    text_str := convert_wildcards_tosql( text_str, EscChar );
    // If the escape character is used we need the escape clause
    if Pos( EscChar, text_str ) <> 0 then begin
      WhereClause.Add( fld + ' ' +
                       text_str + ' ESCAPE ''' + EscChar + '''' );
    end else WhereClause.Add( fld + ' ' + text_str );
  end else if beginswith_sqlsearch( text_str ) then begin
    WhereClause.Add( fld + ' ' + text_str );
  end
  else
  begin
    if contains_relational_ops( text_str ) then
      ops := GetRelOps( text_str )
    else
      ops := '';
    case IB_Field.SQLType of
      SQL_TYPE_TIME,
      SQL_TYPE_TIME_: begin
        if ops = '' then ops := '=';
        text_str := mkLitCriteria( text_str, '''' );
        WhereClause.Add( fld + ' ' +
                         ops + ' ' + text_str );
      end;
      SQL_TIMESTAMP,
      SQL_TIMESTAMP_,
      SQL_TYPE_DATE,
      SQL_TYPE_DATE_: begin
        if ops = '' then ops := '=';
        if ( get_HasTime( text_str )) or
           ( IB_Field.SQLType = SQL_TYPE_DATE ) or
           ( IB_Field.SQLType = SQL_TYPE_DATE_ ) then begin
          WhereClause.Add( fld + ' ' +
                           ops + ' ' + get_IBDateSLiteral( text_str, 0 ));
        end else begin
          if CompareText( Copy( text_str,1,3 ), 'TOD' ) = 0 then begin
            text_str := DateToStr( now );
          end else if CompareText( Copy( text_str,1,3 ), 'YES' ) = 0 then begin
            text_str := DateToStr( now - 1 );
          end;
          if (ops = '<>') or (ops = '!=' ) then begin
            WhereClause.Add( '(' );
            WhereClause.Add( fld +
                             ' < ' + get_IBDateSLiteral( text_str, 0 ));
            WhereClause.Add( 'OR' );
            WhereClause.Add( fld +
                             ' >= ' + get_IBDateSLiteral( text_str, 1 ));
            WhereClause.Add( ')' );
          end else if (ops = '>=') then begin
            WhereClause.Add( fld +
                             ' >= ' + get_IBDateSLiteral( text_str, 0 ));
          end else if (ops = '<=') then begin
            WhereClause.Add( fld + ' < ' +
                             get_IBDateSLiteral( text_str, 1 ));
          end else if (ops = '>') then begin
            WhereClause.Add( fld + ' >= ' +
                             get_IBDateSLiteral( text_str, 1 ));
          end else if (ops = '=') then begin
            WhereClause.Add( fld + ' >= ' +
                             get_IBDateSLiteral( text_str, 0 ));
            WhereClause.Add( fld + ' <  ' +
                             get_IBDateSLiteral( text_str, 1 ));
          end else begin
            WhereClause.Add( fld + ' ' +
                             ops + ' ' + get_IBDateSLiteral( text_str, 0 ));
          end;
        end;
      end;
      SQL_VARYING,
      SQL_VARYING_,
      SQL_TEXT,
      SQL_TEXT_: begin
        // When we get to here the situation is such that the user has not
        // explicitely defined the type of search (between, like, in etc etc)
        // So the actual search performed is dependant upon the default
        // processing of the particular domain/field.  Since the user is not
        // to know what this may be, it is best if support the use of wildcard
        // characters (and so the escape character as well) in all cases
        // and simply strip the escape character if a "like" is not to be
        // performed.
        text_str := mkLitCriteria( text_str, '''' );
        // Convert to sql wild cards...
        if ops = '' then
        begin
          tmp_str := convert_wildcards_tosql( text_str, EscChar );
          // Strip all escape characters on the presumption that the string
          // will not contain wildcards - and so will not be a "like" comparison.
          text_str := strip_escapechar( tmp_str, EscChar );
        end;
        // If it is a like comparison that we want then reset the search str
        // back to what it was with escape characters and all...
        if (ops = '') and contains_sqlwildcards( tmp_str, EscChar ) then
        begin
          if Pos( EscChar, tmp_str ) <> 0 then
            text_str := tmp_str + ' ESCAPE ''' + EscChar + ''''
          else
            text_str := tmp_str;
          // now redundant code, if want NOT LIKE must say NOT NOT.
          //if ( ops = '!=' ) or
          //   ( ops = '<>' ) or
          //   ( UpperCase( ops ) = 'NOT' ) or
          //   ( UpperCase( ops ) = 'NOT LIKE' ) then
          //  ops := 'NOT LIKE'
          //else
            ops := 'LIKE';
        end
        else
        // Inappropriate - if no trailing is required and set, then dont
        // specify an operator.  Thus allowing the user to override notrailing
        // and get an exact match if required.
        //if ( ops = '=' ) and ( IB_Field.IsAttributeSet[ IB_NOTRAILING ] ) then
        //  ops := 'STARTING'
        //else
        if ops = '' then
        begin
          // SoundEx processing takes precedence over NOCASE/NOTRAILING
          // Get SoundEx field
          sxfld := IB_Field.AttributeParams[ IB_SOUNDEX ];
          // I stick the SoundEx stuff here, working on the assumption
          // that if the user entered any operators they are looking
          // for something pretty specific - and SoundEx is not helpful
          // in that situation.  Of course the problem here is that
          // you may be stuck with having to provide both an uppercase
          // index and a soundex index to get the best of both worlds.
          // Still, I can think of no other way to do this - SoundEx
          // just isn't made for wildcards and so forth.  And letting
          // the user specify an "=" is an easy way to let them avoid
          // the wider selection given by SoundEx.
          if sxfld <> '' then
          begin // If SoundEx duplicate available...
            if ( IB_Field.IsAttributeSet[ IB_NOSOUNDEX ] ) then
              sxfld := ''; // allow SoundEx to be turned off
            if ( sxfld <> '' ) then
            begin
              with THackConnection( IB_Field.Statement.IB_Connection ) do begin
                DoSoundExParse( SearchBuffer, sxval );
              end;
              if ( sxval <> '' ) then
              begin
                // If NOTRAILING has been specified then we use a SoundEx
                // range selection.  If the given algorithm does not
                // directly support this then the result set will be the
                // same as if NOTRAILING was not specified.
                fld := ''; // Clear fld so it wont get added to the clause
                ops := ''; // Clear operators as well
                with THackConnection( IB_Field.Statement.IB_Connection ) do
                begin
                  if IB_Field.IsAttributeSet[ IB_NOTRAILING ] then
                  begin
                    DoSoundExMaxParse( SearchBuffer, sxmax );
                    text_str := mkIdent( sxfld ) + ' >= ' +
                                sxval + ' AND ' + mkIdent( sxfld ) +
                                ' <= ' + sxmax;
                  end
                  else
                    text_str := mkIdent( sxfld ) + ' = ' + sxval;
                end;
              end;
            end;
          end;
          if ( fld <> '' ) then
          begin
            if IB_Field.IsAttributeSet[ IB_NOTRAILING ] then
              ops := 'STARTING'
            else if IB_Field.IsAttributeSet[ IB_YESLIKE ] then
            begin
              if ( AnsiCompareStr( text_str,
                                   AnsiUpperCase( text_str )) = 0 ) or
                 ( AnsiCompareStr( text_str,
                                   AnsiLowerCase( text_str )) = 0 ) then
              begin
                ops := 'CONTAINING';
              end else
              begin
                ops := 'LIKE';
                text_str := mkLitCriteria( '%' + stLitCriteria( text_str ) +
                                           '%', '''' );
              end;
            end else
              ops := '=';
          end;
        end;
        WhereClause.Add( fld + ' ' +
                         Trim( ops ) + ' ' + text_str );
      end;
      SQL_DOUBLE,
      SQL_DOUBLE_: begin
        if ops = '' then ops := '=';
        if SetParameterAttributes(0) then begin
          WhereClause.Add( fld + ' ' +
                           ops + ' ?' + GetPName(0));
          Parameters.Values[ GetPName( 0 ) ] := text_str;
        end else begin
          WhereClause.Add( fld + ' ' + ops + ' ' +
                           get_IBNumericLiteral( text_str ));
        end;
      end;
      SQL_BLOB,
      SQL_BLOB_: begin
        if ops = '' then ops := '=';
        if IB_Field.IsText then begin
          text_str := mkLitCriteria( text_str, '''' );
          if ops = '=' then
          begin
            WhereClause.Add( fld + ' CONTAINING ' + text_str );
          end
          else
          begin
            // Should raise an exception ???
            WhereClause.Add( fld + ' ' +
                             ops + ' ' + text_str );
          end;
        end
        else
        begin
          WhereClause.Add( fld + ' ' + ops + ' ' + text_str );
        end;
      end
      else
      begin
        if ops = '' then ops := '=';
        if IB_Field.IsNumeric then
        begin
          WhereClause.Add( fld + ' ' + ops + ' ' +
                           get_IBNumericLiteral( text_str ));
        end
        else
        begin
          WhereClause.Add( fld + ' ' + ops + ' ' + text_str );
        end;
      end;
    end;
  end;
end;  { ExtractWhereClause }

procedure ExtractFilterClause( BDataset: TIB_BDataset;
                               WhereClause,
                               Parameters: TStrings );
//var
//  NestLevel: integer;
  procedure ProcessParenthesis( var AStr: string );
  begin
    AStr := Trim( AStr );
    while ( Length( AStr ) > 0 ) and ( AStr[1] in [ '(', ')' ] ) do
    begin
      WhereClause.Add( AStr[1] );
      Delete( AStr, 1, 1 );
      AStr := Trim( AStr );
    end;
  end;

  procedure ProcessCmpOper( var AStr: string );
  var
    tmpStr: string;
  begin
    AStr := Trim( AStr );
    tmpStr := Copy( AStr, 1, 4 );
    if Pos( 'AND', UpperCase( tmpStr )) = 1 then
    begin
      if ( Length( tmpStr ) = 3 ) or CharIsDelimiter( tmpStr[ 4 ] ) then
      begin
        WhereClause.Add( 'AND' );
        Delete( AStr, 1, 3 );
      end;
    end
    else
    if Pos( 'OR', UpperCase( tmpStr )) = 1 then
    begin
      if ( Length( tmpStr ) = 2 ) or CharIsDelimiter( tmpStr[ 3 ] ) then
      begin
        WhereClause.Add( 'OR' );
        Delete( AStr, 1, 2 );
      end;
    end;
  end;

  function GetNextToken( var AStr: string; WantIdent, WantOp: boolean ):string;
  var
    ii: integer;
    tmpPos: integer;
    tmpStr: string;
    lit1, lit2: boolean;
  begin
    Result := '';
    if AStr = '' then Exit;
    if WantIdent and ( AStr[1] = '[' ) then
    begin
      tmpPos := getLitSafePos( ']', AStr, 1 );
      if tmpPos > 0 then
      begin
        Result := Copy( AStr, 2, tmpPos - 2 );
        Delete( AStr, 1, tmpPos );
        AStr := Trim( AStr );
        Exit;
      end;
    end
    else
    if not WantOp then
    begin
      if AStr[1] in [ '+', '-' ] then
      begin
        Result := Result + AStr[1];
        Delete( AStr, 1, 1 );
        AStr := Trim( AStr );
      end;
    end;
    if AStr = '' then Exit;
    ii := 1;
    lit1 := false;
    lit2 := false;
    while ii <= Length( AStr ) do
    begin
      if not lit2 then
        if AStr[ii] = '"' then
          lit1 := not lit1;
      if not lit1 then
        if AStr[ii] = '''' then
          lit2 := not lit2;
      if not lit1 and not lit2 then
      begin
        if CharIsDelimiter( AStr[ii] ) then
        begin
          if ( AStr[ii] > ' ' ) and ( ii = 1 ) then Inc( ii );
          Break;
        end;
      end;
      Inc( ii );
    end;
    if lit1 or lit2 then
      raise EIB_Error.Create( 'Invalid Filter syntax' );
    Result := Result + Copy( AStr, 1, ii - 1 );
    AStr := Trim( Copy( AStr, ii, MaxInt ));
    if WantIdent then
    begin
      if Length( AStr ) > 0 then
      begin
        if ( AStr[1] = '(' ) then
        begin
          tmpPos := getLitsRoundSafePos( ')', AStr, 2 );
          if tmpPos > 0 then
          begin
            tmpStr := Copy( AStr, 1, tmpPos );
            Delete( AStr, 1, tmpPos );
            AStr := Trim( AStr );
            Result := Result + tmpStr;
          end;
        end;
      end;
    end
    else
    if not WantOp then
    begin
    // Check for sign indicator or concatenators.
    end;
  end;

  procedure ProcessItem( var AFilter: string );
  var
    tmpCol: TIB_Column;
    AName: string;
    AOper: string;
    AItem: string;
    tmpStr: string;
    tmpNOT: boolean;
    procedure ProcessExpr( var AExpr: string );
    begin
      if Assigned( tmpCol ) then
      begin
        if tmpCol.IsText then
        begin
          if IsLitCriteria( AExpr, '"' ) then
            AExpr := mkLitCriteria( stLitCriteria( AExpr ), '''' );
          if not ( fopNoPartialCompare in BDataset.FilterOptions ) and
                 ( Pos( '*''', AExpr ) = Length( AExpr ) - 1 ) and
                 ( AOper = '=' ) then
          begin
            Delete( AExpr, Length( AExpr ) - 1, 1 );
            AOper := 'STARTING';
          end;
          if fopCaseInsensitive in BDataset.FilterOptions then
          begin
            AName := tmpCol.NoCaseFieldName;
            if AName = '' then
              AName := 'UPPER( ' + tmpCol.FullFieldName + ' )';
            AExpr := 'UPPER( ' + AExpr + ' )';
          end;
        end
        else
        if tmpCol.IsDateTime and ( Pos( DateSeparator, AExpr ) > 0 ) then
        begin
          AExpr := stLitCriteria( AExpr );
          try
            AExpr := get_IBDateLiteral( StrToDateTime( AExpr ));
          except
            AExpr := mkLitCriteria( AExpr, '''' );
          end;
        end
        else
        if tmpCol.IsNumeric and ( Pos( DecimalSeparator, AExpr ) > 0 ) then
        begin
          AExpr := stLitCriteria( AExpr );
          try
            AExpr := get_IBNumericLiteral( AExpr );
          except
            AExpr := mkLitCriteria( AExpr, '''' );
          end;
        end;
      end
      else
        if IsLitCriteria( AExpr, '"' ) then
          AExpr := mkLitCriteria( stLitCriteria( AExpr ), '''' );
    end;
  var
    tmpCnt: integer;
  begin { ProcessItem }
    AName := GetNextToken( AFilter, true, false );
    tmpCol := BDataset.FindField( AName );
    AOper := GetRelOps( AFilter );
    AFilter := Trim( AFilter );
    tmpNOT := false;
    if AOper = '' then
    begin
      AOper := GetNextToken( AFilter, false, true );
      if UpperCase( AOper ) = 'NOT' then
      begin
        tmpNOT := true;
        AOper := GetNextToken( AFilter, false, true );
      end;
    end;
    if UpperCase( Copy( AOper, 1, 3 )) = 'IS ' then
      tmpStr := ''
    else
      tmpStr := GetNextToken( AFilter, false, false );
    AItem := '';
    if UpperCase( AOper ) = 'BETWEEN' then
    begin
      ProcessExpr( tmpStr );
      AItem := tmpStr;
      tmpStr := GetNextToken( AFilter, false, false );
      if UpperCase( tmpStr ) = 'AND' then
        AItem := AItem + ' AND '
      else
        raise EIB_Error.Create( 'Invalid Filter syntax: BETWEEN' );
      tmpStr := GetNextToken( AFilter, false, false );
      ProcessExpr( tmpStr );
      AItem := AItem + tmpStr;
    end
    else
    if UpperCase( AOper ) = 'IN' then
    begin
      if tmpStr <> '(' then
        raise EIB_Error.Create( 'Invalid Filter syntax: IN()' );
      tmpCnt := 0;
      AItem := '( ';
      tmpStr := GetNextToken( AFilter, false, false );
      while Length( AFilter ) > 0 do
      begin
        if tmpStr <> ',' then
        begin
          ProcessExpr( tmpStr );
          if ( tmpCnt > 0 ) then
            AItem := AItem + ', ';
          AItem := AItem + tmpStr;
        end;
        tmpStr := GetNextToken( AFilter, false, false );
        Inc( tmpCnt );
        if tmpStr = ')' then
          Break;
      end;
      if tmpStr = ')' then
        AItem := AItem + ' )'
      else
        raise EIB_Error.Create( 'Invalid Filter syntax: IN()' );
    end
    else
    if UpperCase( AOper ) = 'STARTING' then
    begin
      if Trim( UpperCase( tmpStr )) = 'WITH' then
        tmpStr := GetNextToken( AFilter, false, false );
      ProcessExpr( tmpStr );
      AItem := tmpStr;
    end
    else
    if UpperCase( AOper ) = 'LIKE' then
    begin
      ProcessExpr( tmpStr );
      AItem := tmpStr;
      if Pos( 'ESCAPE', AFilter ) = 1 then
      begin
        tmpStr := GetNextToken( AFilter, false, false );
        AItem := AItem + ' ESCAPE ';
        tmpStr := GetNextToken( AFilter, false, false );
        AItem := AItem + tmpStr;
      end;
    end
    else
    if tmpStr <> '' then
    begin
      ProcessExpr( tmpStr );
      AItem := tmpStr;
    end;
    if tmpNOT then
      AOper := 'NOT ' + AOper;
    WhereClause.Add( Trim( AName + ' ' + AOper + ' ' + AItem ));
  end;
  procedure ProcessFilterPiece( var AFiltPiece: string );
  var
    lstFilt: string;
  begin
    if AFiltPiece <> '' then
    begin
//      Inc( NestLevel );
//      try
        while AFiltPiece <> '' do
        begin
          lstFilt := AFiltPiece;
          ProcessParenthesis( AFiltPiece );
          ProcessItem( AFiltPiece );
          if AFiltPiece = '' then Break;
          ProcessParenthesis( AFiltPiece );
          if AFiltPiece = '' then Break;
          ProcessCmpOper( AFiltPiece );
          if lstFilt = AFiltPiece then
            raise Exception.Create( 'Invalid Filter Syntax: ' + AFiltPiece );
        end;
//      finally
//        Dec( NestLevel );
//      end;
    end;
  end;
var
  tmpFilt: string;
begin
//  NestLevel := 0;
  tmpFilt := Trim( BDataset.Filter );
  if tmpFilt <> '' then
  begin
    WhereClause.Add( '(' );
    if UpperCase( Copy( tmpFilt, 1, 7 )) = '::SQL::' then
      WhereClause.Add( Copy( tmpFilt, 8, MaxInt ))
    else
      ProcessFilterPiece( tmpFilt );
    WhereClause.Add( ')' );
  end;
end;

{------------------------------------------------------------------------------}

procedure MakeCountSQL( const SQL: string; var CountSQL: string );
var
  cntSQL: string;
  tmpsql: string;
  bp, ep: integer;
begin
  cntSQL := 'SELECT COUNT( * )';
  CountSQL := SQL;
  GetSQLSelect( CountSQL, tmpSQL, bp, ep );
  if bp <> ParseLineInvalid then
  begin
    ep := getLitSafeStrPos( 'DISTINCT', AnsiUpperCase( tmpSql ), 1 );
    if ep > 1 then
    begin
//!!! Fix it in here so that it will handle SELECT DISTINCT AField AS xAField
      System.Delete( tmpSql, 1, ep + 8 );
      tmpSQL := Trim( tmpSQL );
      repeat
        ep := getLitSafeStrPos( ',', AnsiUpperCase( tmpSql ), 1 );
        if ep >= 1 then
        begin
          tmpSQL[ ep ] := ' ';
          System.Insert( '|| ''.zZz.'' ||' , tmpSQL, ep + 1 );
        end
        else
          Break;
      until false;                               
      cntSQL := 'SELECT COUNT( DISTINCT ''.zZz.'' || ' + Trim( tmpSQL ) + ' )';
    end;
  end;
  SetSQLSelect( CountSQL, cntSQL ); // Leave spaces by asterisk.
  SetSQLPlan( CountSQL, '' );
  SetSQLOrder( CountSQL, '' );
  SetSQLForUpdate( CountSQL, '' );
  CountSQL := Trim( CountSQL );
end;

function MakeLookupSQL( const SQL: string;
                        const SQLSelect: string;
                        const KeyLinks: TIB_StringList;
                          var LookupSQL: string;
                          var SelectParamCount: integer ): integer;
var
  ii: integer;
  OldWhere: string;
  NewWhere: string;
  tmpFrom: string;
  tmpSelect: string;
  tmpPrms: TIB_StringList;
  tmpLen: longint;
  BegPos, EndPos: longint;
begin
  NewWhere := '';
  OldWhere := '';
  LookupSQL := SQL;
  GetSQLSelect( SQL, tmpSelect, BegPos, EndPos );
  SetSQLSelect( LookupSQL, SQLSelect );
  SetSQLPlan( LookupSQL, '' );
  SetSQLOrder( LookupSQL, '' );
  SetSQLForUpdate( LookupSQL, '' );
  GetSQLWhere( LookupSQL, OldWhere, BegPos, EndPos );
  for ii := 0 to KeyLinks.Count - 1 do
  begin
    if ii > 0 then
      NewWhere := NewWhere + IB_AND;
    NewWhere := NewWhere + KeyLinks.IndexNames[ii] + '=?';
  end;
  AddWhereClauseHigh( OldWhere, NewWhere );
  SetSQLWhere( LookupSQL, OldWhere );
  GetSQLFrom( LookupSQL, tmpFrom, BegPos, EndPos );
  tmpPrms := TIB_StringList.Create;
  try
    MakeServerSQL( tmpFrom, tmpPrms, nil, nil, tmpFrom, #0, true, tmpLen );
    Result := tmpPrms.Count;
    MakeServerSQL( tmpSelect, tmpPrms, nil, nil, tmpSelect, #0, true, tmpLen );
    SelectParamCount := tmpPrms.Count;
  finally
    tmpPrms.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure AddWhereClause( var SQLWhere: string;
                              WhereClause: string );
var
  tmpStr: string;
begin
  WhereClause := Trim( WhereClause );
  SQLWhere := Trim( SQLWhere );
  if WhereClause <> '' then
  begin
    if SQLWhere <> '' then
    begin
      tmpStr := Copy( SQLWhere, 7, MaxInt );
      if ( Pos( '//', tmpStr ) > 0 ) or
         ( Pos( 'OR', UpperCase( tmpStr )) > 0 ) or
         ( Pos( '//', WhereClause ) > 0 ) or
         ( Pos( 'OR', UpperCase( WhereClause ) ) > 0 ) then
      begin
        SQLWhere := ' WHERE ('#13#10'      ' +
                    tmpStr + #13#10 + '      )' +
                    IB_AND + WhereClause;
      end
      else
        SQLWhere := SQLWhere + IB_AND + WhereClause;
    end
    else
      SQLWhere := 'WHERE ' + WhereClause;
  end;
end;

procedure AddWhereClauseHigh( var SQLWhere: string;
                                  WhereClause: string );
var
  tmpStr: string;
begin
  WhereClause := Trim( WhereClause );
  SQLWhere := Trim( SQLWhere );
  if WhereClause <> '' then
  begin
    if SQLWhere <> '' then
    begin
      tmpStr := Trim( Copy( SQLWhere, 7, MaxInt ));
      if ( Pos( '//', tmpStr ) > 0 ) or
         ( Pos( 'OR', UpperCase( tmpStr ) ) > 0 ) or
         ( Pos( '//', WhereClause ) > 0 ) or
         ( Pos( 'OR', UpperCase( WhereClause ) ) > 0 ) then
        SQLWhere := 'WHERE ' + '( ' + WhereClause + ' ) ' + IB_AND + ' ( ' +
                    tmpStr + #13#10 + ')'
      else
        SQLWhere := 'WHERE ' + WhereClause + IB_AND + tmpStr;
    end
    else
      SQLWhere := 'WHERE ' + WhereClause;
  end;
end;

{------------------------------------------------------------------------------}

function GetNextScriptStatement( const Script: string;
                                 var   Statement, SetItem, SetValue: string;
                                 var   BegPos,
                                       EndPos: longint;
                                 var   TermKeyWord: string ): boolean;
var
  tmpBegPos,
  tmpEndPos: longint;
  tmpLen: longint;
begin
  Result := false;
  tmpLen := 0;
  if Script <> '' then
  begin
    while not Result and ( BegPos <= Length( Script )) do
    begin
      Statement := '';
      SetItem := '';
      SetValue := '';
      if TermKeyWord = '' then
        TermKeyWord := ';';
      Result := ParseStr( Script,
                          '', false,
                          [ PChar( TermKeyWord ) ],
                          BegPos, EndPos, TermKeyWord, true, false ) or
                ( BegPos < EndPos );
      if Result then
      begin
        SubStrings( Script, Statement, BegPos, EndPos );
        Inc( EndPos, Length( TermKeyWord ));
        MakeServerSQL( Statement, nil, nil, nil, Statement, #0, true, tmpLen );
        Statement := Trim( Statement );
        Result := Length( Statement ) > 0;
        BegPos := EndPos;
        EndPos := ParseLineEnd;
      end;
      if Result and ( Length( Statement ) <= 128 + tmpLen ) then
      begin
        tmpBegPos := ParseLineBegin;
        tmpEndPos := ParseLineEnd;
        if ParseStr( Statement,
                     'SET', true,
                      [ 'AUTODDL','BLOBDISPLAY','COUNT','ECHO','LIST',
                        'NAMES','PLAN','STATS','TERM','TIME',
                        'SQLDIALECT', 'SQL', 'IGNOREEXCEPTCNT' ],
                     tmpBegPos, tmpEndPos, SetItem, false, true ) then
        begin
          Inc( tmpEndPos, Length( SetItem ));
          if SetItem = 'TERM' then
          begin
            TermKeyWord := Trim( Copy( Statement, tmpEndPos, MaxInt ));
            Result := false;
          end
          else
            SetValue := Trim( Copy( Statement, tmpEndPos, MaxInt ));
        end;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

function ExtractDBProp( const Statement,
                              DBProp: string;
                              StmtTypes: array of PChar;
                          var StmtType,
                              DBPropVal: string ): boolean;
var
  BegPos,
  EndPos: longint;
  TermKeyWord: string;
  ii: integer;
begin
  BegPos := ParseLineBegin;
  EndPos := ParseLineEnd;
  TermKeyWord := '';
  StmtType := '';
  DBPropVal := '';
  ii := Low( StmtTypes );
  while ii <= High( StmtTypes ) do
  begin
    if ParseStr( Statement,
                 StmtTypes[ii], true,
                 ['DATABASE', 'SCHEMA',
                  'USER', 'PASSWORD', ';'],
                 BegPos,
                 EndPos,
                 TermKeyWord,
                 false,
                 true ) then
    begin
      StmtType := StmtTypes[ii];
      if ( TermKeyWord <> 'DATABASE' ) and
         ( TermKeyWord <> 'SCHEMA' ) then TermKeyWord := '';
      Break;
    end
    else
      Inc( ii );
  end;
  Result := StmtType <> '';
  if Result then
  begin
    if AnsiUpperCase( DBProp ) = 'DATABASE' then
    begin
      if Length( TermKeyWord ) > 0 then
        BegPos := EndPos + Length( TermKeyWord )
      else
        Inc( BegPos, Length( StmtType ) + 1 );
    end
    else
    begin
      BegPos := ParseLineBegin;
      EndPos := ParseLineEnd;
      if ParseStr( Statement,
                   StmtType, true,
                   [PChar(DBProp)],
                   BegPos,
                   EndPos,
                   TermKeyWord,
                   false,
                   false ) then
        BegPos := EndPos + Length( TermKeyWord )
      else
        Exit;
    end;
    EndPos := ParseLineEnd;
    GetNextLiteral( Statement, BegPos, EndPos, DBPropVal );
  end;
end;

function SetConnectionProperties(     ACon: TIB_Connection;
                                      AStmt: string;
                                  var StmtType: string ): boolean;
var
  tmpStr: string;
begin
  StmtType := '';
  if ExtractDBProp( AStmt, 'DATABASE', ['CREATE',
                                        'CONNECT',
                                        'DISCONNECT',
                                        'DROP'], StmtType, tmpStr ) then
  begin
    Result := true;
    if StmtType = 'DISCONNECT' then
      Exit;
    if ( StmtType = 'DROP' ) and ( ACon.Connected ) then
      Exit;
    if ( tmpStr <> '' ) then
      ACon.Database := tmpStr;
    ExtractDBProp( AStmt, 'USER', ['CREATE',
                                   'CONNECT',
                                   'DROP'], StmtType, tmpStr );
    if ( tmpStr <> '' ) or ( StmtType <> 'DROP' ) then
      ACon.Username := tmpStr;
    ExtractDBProp( AStmt, 'PASSWORD', ['CREATE',
                                       'CONNECT',
                                       'DROP'], StmtType, tmpStr );
    if ( tmpStr <> '' ) or ( StmtType <> 'DROP' ) then
      ACon.Password := tmpStr;
    ExtractDBProp( AStmt, 'ROLE', ['CREATE',
                                   'CONNECT',
                                   'DROP'], StmtType, tmpStr );
    if ( tmpStr <> '' ) or ( StmtType <> 'DROP' ) then
      ACon.SQLRole := tmpStr;
  end
  else
    Result := false;
end;

{------------------------------------------------------------------------------}

function PadRight( const InStr: string;
                         PadCh: char;
                         LenStr: integer;
                         Trim: boolean ): string;
var
  CurLen: integer;
begin
  if Trim then
    Result := Copy( InStr, 1, LenStr )
  else
    Result := InStr;
  CurLen := Length( Result );
  if CurLen < LenStr then
  begin
    SetLength( Result, LenStr );
    FillChar( Result[ CurLen + 1 ], LenStr - CurLen, PadCh );
  end;
end;

function PadLeft( const InStr: string;
                        PadCh: char;
                        LenStr: integer;
                        Trim: boolean ): string;
var
  CurLen: integer;
begin
  if Trim then
    Result := Copy( InStr, 1, LenStr )
  else
    Result := InStr;
  CurLen := Length( Result );
  if CurLen < LenStr then
    Result := Replicate_Char( PadCh, LenStr - CurLen ) + Result;
end;

procedure RTrim( var AString: string );
begin
  AString := TrimRight( AString );
end;

{ removes from the left part of the string all the chars that have ascii
  value lesser than the specified (AFirstOk) }
function TrimLeftPrevOrdChar( const InStr: string; AFirstOk: char ): string;
var
  x: integer;
begin
  x := 1;
  while (x < length( InStr )) and (InStr[x] < AFirstOk ) do
    inc(x);
  Result := copy( InStr, x, (length(InStr) - x) + 1);
end;


function GetStoredProcedureSource( SP_Alter: boolean;
                                   SP_Name: string;
                                   SP_DSQL: TIB_Statement;
                                   SP_Body: string ): string;
var
  ii: integer;
  HeaderLen: integer;
begin
  with SP_DSQL do
  begin
    Prepared := true;
    with IB_Connection do
    begin
      if SP_Alter then
        Result :=  'ALTER PROCEDURE  ' + mkIdent( SP_Name )
      else
        Result :=  'CREATE PROCEDURE ' + mkIdent( SP_Name );
      with SP_DSQL.Params do
      begin
        HeaderLen := 0;
        for ii := 0 to ColumnCount - 1 do
          with Columns[ii] do
          begin
            if ii = 0 then
            begin
              HeaderLen := Length( Result );
              Result := Result + '( ';
            end
            else
              Result := Result + #13#10 +
                                 PadRight( '', ' ', HeaderLen, true ) +
                                 ', ';
            Result := Result + PadRight( mkIdent( FieldName ),
                                         ' ', 33, true ) + SQLTypeSource;
          end;
        if HeaderLen > 0 then
          Result := Result + ' )';
      end;
      with Fields do
      begin
        HeaderLen := 0;
        for ii := 0 to ColumnCount - 1 do
          with Columns[ii] do
          begin
            if ii = 0 then
            begin
              HeaderLen := Length( 'RETURNS ( ');
              Result := Result + #13#10'RETURNS ( ';
            end
            else
              Result := Result + #13#10 +
                        PadRight( '', ' ', HeaderLen - 2, true ) + ', ';
            Result := Result + PadRight( mkIdent( FieldName ),
                                         ' ', 33, true ) + SQLTypeSource;
          end;
        if HeaderLen > 0 then
          Result := Result + ' )';
      end;
    end;
  end;
  Result := Result + #13#10'AS'#13#10 + Trim( SP_Body );
end;

{------------------------------------------------------------------------------}

function GetCharValue( AChar: char ): string;
begin
  case AChar of
    'A'..'[': Result := Chr( Ord(AChar) - Ord('A'));
    else      Result := AChar;
  end;
end;

function SetCharValues( AString: string ): string;
var
  ii, jj: longint;
  ch: char;
begin
  Result := '';
  jj := Length( Astring );
  for ii := 1 to jj do
  begin
    ch := AString[ii];
    case ch of
      #0..#31: Result := Result + CharDelimiter + Chr( Ord(ch) + Ord('A'));
      ';', '=', '\', '#': Result := Result + CharDelimiter + ch;
      #128..#255: Result := Result + '#' + IntToStr( Ord( ch ));
      else Result := Result + ch;
    end;
  end;
end;

function GetCharValues( AString: string ): string;
var
  ii, jj: integer;
  CharFnd: boolean;
  HighFnd: boolean;
  tmpStr: string;
  ch: char;

  procedure CheckHigh;
  begin
    if tmpStr <> '' then
      Result := Result + Chr( StrToInt( tmpStr ))
    else
      Result := Result + #0;
    HighFnd := false;
  end;

begin
  Result := '';
  CharFnd := false;
  HighFnd := false;
  jj := Length( AString );
  for ii := 1 to jj do
  begin
    ch := AString[ii];
    if HighFnd then
    begin
      if ( ch in [ '0'..'9' ] ) and
         ( Length( tmpStr ) < 3 ) then
      begin
        tmpStr := tmpStr + ch;
        Continue;
      end
      else
        CheckHigh;
    end;
    if CharFnd then
    begin
      CharFnd := false;
      Result := Result + GetCharValue( ch );
    end
    else
    begin
      if ch = CharDelimiter then
        CharFnd := true
      else
      if ch = HighCharDelimiter then
      begin
        HighFnd := true;
        tmpStr := '';
      end
      else
        Result := Result + ch;
    end;
  end;
  if HighFnd then
    CheckHigh;
end;

procedure ExtractListLinkParam(     AStr, AParam: string;
                                var BegPos, EndPos: longint;
                                var Value: string );
var
  CurPos: longint;
  ParamFound: boolean;
  ValueFound: boolean;
  tmpChr: string;
begin
  ParamFound := false;
  ValueFound := false;
  EndPos := Length( AStr );
  BegPos := ParseLineInvalid;
  CurPos := 1;
  Value := '';
  if ( Trim( AParam ) <> '' ) and ( Trim( AStr ) <> '' ) then
  repeat
    if not ParamFound then
    begin
      if ((CurPos = 1) or (AStr[CurPos - 1] in [';', ' '])) and
         (CompareText( Copy( AStr, CurPos, Length(AParam)), AParam ) = 0) and
         ((CurPos + Length(AParam) >= Length( Astr )) or
          (AStr[CurPos + Length(AParam)] in [';', '=', ' '] )) then
      begin
        ParamFound := True;
        BegPos := CurPos;
        Inc( CurPos, Length(AParam) );
        Continue;
      end;
    end
    else
    if not ValueFound then
    begin
      if AStr[CurPos] = '=' then
        ValueFound := true
      else
      if AStr[ CurPos ] <> ' ' then
      begin
        EndPos := CurPos;
        Exit;
      end;
    end
    else
    if AStr[ CurPos ] = CharDelimiter then
    begin
      Inc( CurPos );
      if CurPos <= EndPos then
        Value := Value + GetCharValue( AStr[ CurPos ] );
    end
    else
    if AStr[ CurPos ] = HighCharDelimiter then
    begin
      Inc( CurPos );
      tmpChr := '';
      while ( CurPos <= EndPos ) and ( AStr[ CurPos ] in [ '0'..'9' ] ) do
      begin
        tmpChr := tmpChr + AStr[ CurPos ];
        Inc( CurPos );
      end;
      Value := Value + Chr( StrToInt( tmpChr ));
    end
    else
    if AStr[ CurPos ] = ';' then
    begin
      EndPos := CurPos;
      Exit;
    end
    else
      Value := Value +  AStr[ CurPos ];
    Inc( CurPos );
  until CurPos > EndPos;
  Inc( EndPos );
end;

procedure RemoveListLinkParam( var AString: string; AParam: string );
var
  tmpStr: string;
  BegPos,
  EndPos: longint;
  TermFound: boolean;
begin
  if AParam <> '' then begin
    ExtractListLinkParam( AString, AParam, BegPos, EndPos, tmpStr );
    if BegPos <> ParseLineInvalid then begin
      TermFound := false;
      if BegPos > 1 then begin
        while BegPos > 1 do begin
          if AString[ BegPos - 1 ] = ' ' then begin
            Dec( BegPos );
          end else if AString[ BegPos - 1 ] = ';' then begin
            Dec( BegPos );
            TermFound := true;
            Break;
          end else begin
            Break;
          end;
        end;
      end;
      if not TermFound then begin
        while EndPos <= Length( AString ) do begin
          if AString[ EndPos ] = ' ' then begin
            Inc( EndPos );
          end else if AString[ EndPos ] = ';' then begin
            Inc( EndPos );
            Break;
          end else begin
            Break;
          end;
        end;
      end;
      System.Delete( AString, BegPos, EndPos - BegPos );
    end;
  end;
end;

function SetListLinkParamValue( var AString: string;
                                    AParam, AValue: string ): boolean;
var
  tmpStr: string;
  BegPos, EndPos: longint;
begin
  ExtractListLinkParam( AString, AParam, BegPos, EndPos, tmpStr );
  Result := tmpStr <> AValue;
  if Result then begin
    tmpStr := AString;
    RemoveListLinkParam( tmpStr, AParam );
    if AValue <> '' then begin
      if ( tmpStr <> '' ) and
         ( tmpStr[ Length( tmpStr ) ] <> ';' ) then begin
        tmpStr := tmpStr + ';';
      end;
      tmpStr := tmpStr + AParam + '=' + SetCharValues( AValue );
    end;
    AString := tmpStr;
  end;
end;

function SetListLinkParamIsSet( var AString: string;
                                    AParam: string;
                                    AIsSet: boolean ): boolean;
var
  tmpStr: string;
  BegPos, EndPos: longint;
begin
  ExtractListLinkParam( AString, AParam, BegPos, EndPos, tmpStr );
  Result := ( BegPos <> ParseLineInvalid ) <> AIsSet;
  if Result then
  begin
    RemoveListLinkParam( AString, AParam );
    if AIsSet then
    begin
      if AString = '' then
        AString := AParam
      else
      if AString[ Length( AString ) ] = ';' then
        AString := AString + AParam
      else
        AString := AString + ';' + AParam;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure ExtractStoredProcedure(       SQL: string;
                                  var   StoredProcName: string;
                                  const ParamNames: TStrings;
                                        ParamChar: char );
var
  BegPos, EndPos: longint;
  TermKey: string;
  tmpLen: longint;
begin
  BegPos := ParseLineBegin;
  EndPos := ParseLineEnd;
  TermKey := '';
  StoredProcName := '';
  if ParseStr( SQL,
               'EXECUTE', true,
               ['PROCEDURE'], BegPos, EndPos, TermKey, false, true ) then
  begin
    ParamNames.Clear;
    Inc( EndPos, Length( TermKey ));
    while ( EndPos <= Length( SQL )) and CharIsDelimiter( SQL[EndPos] ) do
      Inc( EndPos );
    while ( EndPos <= Length( SQL )) and
          not CharIsDelimiter( SQL[ EndPos ] ) do
    begin
      StoredProcName := StoredProcName + SQL[ EndPos ];
      Inc( EndPos );
    end;
    MakeServerSQL( SQL,
                   ParamNames,
                   nil,
                   nil,
                   TermKey,
                   ParamChar,
                   false,
                   tmpLen );
  end else begin
  end;
end;

function ExtractColSourceFromBLR( BLRCode,
                                  CharLen,
                                  Scale,
                                  SegLen,
                                  SegSubType,
                                  Precision,
                                  SQLDialect: integer ): string;
var
  prec: String;
begin
  if Scale < 0 then
    Scale := -Scale;
  case BLRCode of
    0: Result := '';
    blr_text: Result := 'CHAR( ' + IntToStr( CharLen ) + ' )';
    blr_text2: Result := 'CHAR2( ' + IntToStr( CharLen ) + ' )';
    blr_short:
      if (Scale > 0) or (Precision > 0) then
      begin
        if Precision > 0
        then prec := IntToStr(Precision) + ', '
        else prec := '4, ';
        if SegSubType = 2
        then Result := 'DECIMAL( ' + prec + IntToStr( Scale ) + ' )'
        else Result := 'NUMERIC( ' + prec + IntToStr( Scale ) + ' )'
      end
      else
        Result := 'SMALLINT';
    blr_long:
      if (Scale > 0) or (Precision > 0) then
      begin
        if Precision > 0
        then prec := IntToStr(Precision) + ', '
        else prec := '9, ';
        if SegSubType = 2
        then Result := 'DECIMAL( ' + prec + IntToStr( Scale ) + ' )'
        else Result := 'NUMERIC( ' + prec + IntToStr( Scale ) + ' )'
      end
      else
        Result := 'INTEGER';
    blr_quad:
      Result := 'QUAD';
    blr_int64:
      begin
        if Precision > 0
        then prec := IntToStr(Precision) + ', '
        else prec := '18, ';
        if SegSubType = 2
        then Result := 'DECIMAL( ' + prec + IntToStr( Scale ) + ' )'
        else Result := 'NUMERIC( ' + prec + IntToStr( Scale ) + ' )'
      end;
    blr_float:
      if Scale > 0 then
        Result := 'NUMERIC( 9, ' + IntToStr( Scale ) + ' )'
      else
        Result := 'SINGLE';
    blr_double:
      if Scale > 0 then
        Result := 'NUMERIC( 15, ' + IntToStr( Scale ) + ' )'
      else
        Result := 'DOUBLE PRECISION';
    blr_d_float: ;
    blr_timestamp: if SQLDialect >= 3 then
      Result := 'TIMESTAMP'
    else
      Result := 'DATE';
    blr_varying: Result := 'VARCHAR( ' + IntToStr( CharLen ) + ' )';
    blr_varying2: Result := 'VARCHAR2( ' + IntToStr( CharLen ) + ' )';
    blr_blob: Result := 'BLOB( ' +
                        IntToStr( SegLen ) + ', ' +
                        IntToStr( SegSubType ) + ' )';
    blr_cstring: Result := 'CSTRING( ' + IntToStr( CharLen ) + ' )';
    blr_cstring2: Result := 'CSTRING2( ' + IntToStr( CharLen ) + ' )';
    blr_blob_id:;
    blr_sql_date:
      Result := 'DATE';
    blr_sql_time:
      Result := 'TIME';
    else
      raise Exception.Create( 'Unrecognized BLR type' );
  end;
end;

end.
