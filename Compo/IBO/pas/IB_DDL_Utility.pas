
{                                                                              }
{ IB_DDL_Utility                                                               }
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
{  Claudio Valderrama is the original author of this unit.                     }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IB_DDL_Utility;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  IB_DDL_Entity;

type
  (*
  TDependenciesNode = record
    e: TIB_DDL_Entity;
    p: SmallInt;
  end;
  const DependenciesChunkSize = 25;
  TDependenciesArray = array[0..DependenciesChunkSize] of TDependenciesNode;
  *)
  TDependenciesList = class
  private
    FList: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(Item: TIB_DDL_Entity): Integer;
    function Get(Index: Integer): TIB_DDL_Entity;
    procedure SortByPriority;
  end;

// Returns adjusted TypeName.
function FieldTypeAsChar(FFieldType: SmallInt; FTypeName: String): String;
// Returns adjusted SubTypeName.
function AdjustField(FFieldType, FFieldSubType: SmallInt;
  var FFieldPrecision: SmallInt; var FTypeName: String;
  FSubTypeName: String; FFieldScale: SmallInt; var FIsNumericOrDecimal: Boolean;
  ProcessBLOB: Boolean): String;
// Fixes the comma problem when building SQL from inherited functions.
procedure DeleteLastCommaFromStrings(s: TStrings);
// Overcomes the problem with gen values between 1+18 and 2^63-1.
function ExtendedAsNumeric19(f: Extended): String;

implementation

constructor TDependenciesList.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TDependenciesList.Destroy;
begin
  FList.Free
end;

function TDependenciesList.Add(Item: TIB_DDL_Entity): Integer;
begin
  Result := FList.Add(Item)
end;

function TDependenciesList.Get(Index: Integer): TIB_DDL_Entity;
begin
  Result := FList.Items[Index]
end;

function PriorityCompare(Item1, Item2: Pointer): Integer;
begin
  Result := TIB_DDL_Entity(Item1).Priority - TIB_DDL_Entity(Item2).Priority
end;

procedure TDependenciesList.SortByPriority;
begin
  FList.Sort(PriorityCompare)
end;

function FieldTypeAsChar(FFieldType: SmallInt; FTypeName: String): String;
begin
  Result := 'UNKNOWN';
  case FFieldType of
    14: Result := 'CHAR';
    7: Result := 'SMALLINT';
    8: Result := 'INTEGER';
    16: if FTypeName = EmptyStr then
      Result := '_INT64'
    else
      Result := FTypeName;
    37: Result := 'VARCHAR';
    27: Result := FTypeName + ' PRECISION';
    else
    if FTypeName <> EmptyStr then
      Result := FTypeName
  end
end;

function AdjustField(FFieldType, FFieldSubType: SmallInt;
  var FFieldPrecision: SmallInt; var FTypeName: String;
  FSubTypeName: String; FFieldScale: SmallInt; var FIsNumericOrDecimal: Boolean;
  ProcessBLOB: Boolean): String;
begin
  Result := 'UNKNOWN';
  case FFieldType of
    261: if ProcessBlob then
    begin
      if (FFieldSubType > 0) and (FSubTypeName <> EmptyStr) then
        Result := FSubTypeName
      else
      if FFieldSubType = 0 then
        Result := '0'
      else
        Result := IntToStr(FFieldSubType);
    end;
    7, 8, 16:
    begin
      case FFieldSubType of
        1:
        begin
          FTypeName := 'NUMERIC';
          FIsNumericOrDecimal := True
        end;
        2:
        begin
          FTypeName := 'DECIMAL';
          FIsNumericOrDecimal := True
        end
        else
        if FFieldScale > 0 then
        begin
          FTypeName := 'NUMERIC';
          FIsNumericOrDecimal := True
        end
      end;
      if FIsNumericOrDecimal and (FFieldPrecision = 0) then
        case FFieldType of
          7: FFieldPrecision := 4;
          8: FFieldPrecision := 9;
          16: FFieldPrecision := 18;
        end;
    end;
  end;
end;

procedure DeleteLastCommaFromStrings(s: TStrings);
var
  xpos: Integer;
begin
  xpos := Length(s[s.Count - 1]);
  if s[s.Count - 1][xpos] = ',' then
    s[s.Count - 1] := Copy(s[s.Count - 1], 1, xpos - 1);
end;

function ExtendedAsNumeric19( f: Extended ): String;
var
  fa, fx: Extended;
  fd: Char;
begin
// Abs() operates on a real type, thus a loss of precision.
  if f > 0 then
    fa := f
  else
    fa := -f;
  if fa < 1E+18 then
    Result := FloatToStrF( f, ffFixed, 20, 0 )
  else
  begin
    fd := FloatToStr(fa)[1];
    fx := StrToFloat(fd) * 1E18;
    Result := fd + FloatToStrF( fa - fx, ffFixed, 20, 0);
    if f < 0 then
      Insert('-', Result, 1);
  end;
end;


end.
