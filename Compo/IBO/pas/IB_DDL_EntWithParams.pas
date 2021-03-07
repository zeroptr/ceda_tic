
{                                                                              }
{ IB_DDL_EntWithParams                                                         }
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
  IB_DDL_EntWithParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  IB_Header,
  IB_Components,

  IB_DDL_Entity,
  IB_DDL_EntityList,
  IB_DDL_ParamList,
  IB_DDL_Formatter;

type
  // Forward declaration.
  TIB_DDL_EntWithParams = class;
  TIB_DDL_Table_Param = class;

  // These are the innermost units, subcomponents of main entities with params.
  TIB_DDL_Param = class(TIB_DDL_Entity)
  protected
    FOwnerName: String;
    //function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
    function GetParamList: TIB_DDL_ParamList;
    function GetMasterEntity: TIB_DDL_EntWithParams;
    function GetMasterEntityList: TIB_DDL_EntListWithParams;
  public
    //class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    //constructor Create(row: TIB_Row); override;
    //procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row);
    function LocateAssociatedDomain(const dn: String): TIB_DDL_Domain;
    function LocateAssociatedIndex(const ixn: String): TIB_DDL_Index;
  end;

  TIB_DDL_UDF_Param = class(TIB_DDL_Param)
  private
    FArgumentPosition: SmallInt;
    FMechanism: SmallInt;
    FFieldType: SmallInt;
    FFieldScale: SmallInt;
    FFieldLength: SmallInt;
    FFieldSubType: SmallInt;
    FCharacterSetId: SmallInt;
    FFieldPrecision: SmallInt;
    FCharacterLength: SmallInt;
    FTypeName: String;
    FSubTypeName: String;
    FCharacterSetName: String;
    //FCollationName: String;
    FIsNumericOrDecimal: Boolean;
    //FIsImplicitDomain: Boolean;
    FBytesPerCharacter: SmallInt;
    FIsOutputParameter: Boolean;
    FIsFreeIt: Boolean;
    FPositionalReturn: Boolean;
  protected
    function DoWrite: Boolean; override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    procedure ParseMetadata; override;
    property ArgumentPosition: SmallInt read          FArgumentPosition;
    property Mechanism: SmallInt read                 FMechanism;
    property FieldType: SmallInt read                 FFieldType;
    property FieldScale: SmallInt read                FFieldScale;
    property FieldLength: SmallInt read               FFieldLength;
    property FieldSubType: SmallInt read              FFieldSubType;
    property CharacterSetId: SmallInt read            FCharacterSetId;
    property FieldPrecision: SmallInt read            FFieldPrecision;
    property CharacterLength: SmallInt read           FCharacterLength;
    property TypeName: String read                    FTypeName;
    property SubTypeName: String read                 FSubTypeName;
    property CharacterSetName: String read            FCharacterSetName;
    property IsNumericOrDecimal: Boolean read         FIsNumericOrDecimal;
    property BytesPerCharacter: SmallInt read         FBytesPerCharacter;
    property IsOutputParameter: Boolean read          FIsOutputParameter;
    property IsFreeIt: Boolean read                   FIsFreeIt;
    property PositionalReturn: Boolean read           FPositionalReturn;
  end;

  TIB_DDL_TableViewProc_Param = class(TIB_DDL_Param)
  protected
    FFieldSource: String;
    FSystemFlag: Boolean;
    FAssociatedDomainPtr: TIB_DDL_Domain;
  protected
    //function DoWrite: Boolean; override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    procedure ParseMetadata; override;
    property FieldSource: String read FFieldSource;
    property SystemFlag: Boolean read FSystemFlag;
  end;

  TIB_DDL_Proc_Param = class(TIB_DDL_TableViewProc_Param)
  private
    //FProcedureName: String; => OwnerName
    //FParameterName: String; => Name
    FParameterNumber: SmallInt;
    FParameterType: SmallInt;
    FIsInputParameter: Boolean;
    FIsOutputParameter: Boolean;
  protected
    function DoWrite: Boolean; override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    procedure ParseMetadata; override;
    //property ProcedureName: String read         FProcedureName;
    //property ParameterName: String read         FParameterName;
    property ParameterNumber: SmallInt read     FParameterNumber;
    property ParameterType: SmallInt read       FParameterType;
    property IsInputParameter: Boolean read     FIsInputParameter;
    property IsOutputParameter: Boolean read    FIsOutputParameter;
  end;

  TIB_DDL_TableView_Param = class(TIB_DDL_TableViewProc_Param)
  protected
    //FRelationName: String; => OwnerName
    //FFieldName: String; => Name
    //FQueryName: String; => useless.
    FBaseField: String;
    FFieldPosition: SmallInt;
    FFieldId: SmallInt;
    FViewContext: SmallInt;
    FSecurityClass: String;
    FIsMandatory: Boolean; //NullFlag: SmallInt;
    FBaseFieldWasEmpty: Boolean;    // Not available as property.
    FViewContextWasEmpty: Boolean;  // Not available as property.
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    procedure ParseMetadata; override;
    //property RelationName: String read        FRelationName;
    //property FieldName: String read           FFieldName;
    //property QueryName: String read           FQueryName; => of no use
    property BaseField: String read           FBaseField;
    property FieldPosition: SmallInt read     FFieldPosition;
    property FieldId: SmallInt read           FFieldId;
    property ViewContext: SmallInt read       FViewContext;
    property SecurityClass: String read       FSecurityClass;
    property IsMandatory: Boolean read        FIsMandatory;
  end;

  TIB_DDL_Table_Param = class(TIB_DDL_TableView_Param)
  private
    FDefaultSource: String;
    FCollationId: SmallInt;
    FCollationName: String;
    FOverridesMandatory: Boolean;
    FOverridesDefault: Boolean;
    FOverridesCollation: Boolean;
  protected
    function DoWrite: Boolean; override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    procedure ParseMetadata; override;
    property DefaultSource: String read       FDefaultSource;
    property CollationId: SmallInt read       FCollationId;
    property CollationName: String read       FCollationName;
    property OverridesMandatory: Boolean read FOverridesMandatory;
    property OverridesDefault: Boolean read   FOverridesDefault;
    property OverridesCollation: Boolean read FOverridesCollation;
  end;

  TIB_DDL_View_Param = class(TIB_DDL_TableView_Param)
  private
    FIsImplicitField: Boolean;
  protected
    function DoWrite: Boolean; override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    procedure ParseMetadata; override;
    property IsImplicitField: Boolean read FIsImplicitField;
  end;

  TIB_DDL_ConstraintType = ( mctPrimary,
                         mctUnique,
                         mctForeign,
                         mctNotNull,
                         mctCheck,
                         mctNone );

  TIB_DDL_UpdateDeleteRule = ( murRestrict,
                           murCascade,
                           murSetNull,
                           murSetDefault,
                           murNone );

  TIB_DDL_Table_Constraint = class(TIB_DDL_Param)
  private
    //FRelationName: String;  => OwnerName
    //FConstraintName: String; => Name
    FConstraintTypeName: String;
    FIndexName: String;
    FConstNameUq: String;
    FUpdateRuleName: String;
    FDeleteRuleName: String;
    FTriggerOrFieldName: String;
    FRelationUq: String;
    FConstraintType: TIB_DDL_ConstraintType;
    FUpdateRule: TIB_DDL_UpdateDeleteRule;
    FDeleteRule: TIB_DDL_UpdateDeleteRule;
    FIsImplicitConstraint: Boolean;
    FIsFaultyConstraint: Boolean;
    FAssociatedIndexPtr: TIB_DDL_Index;
    FAssociatedFieldPtr: TIB_DDL_Table_Param;
    FAssociatedTriggerPtr: TIB_DDL_Trigger;
    FAssociatedMasterIndexPtr: TIB_DDL_Index;
    function ParseFKRule(const udrname: String): TIB_DDL_UpdateDeleteRule;
  protected
    function DoWrite: Boolean; override;
    function LocateAssociatedField(const fn: String): TIB_DDL_Table_Param;
    function LocateAssociatedTrigger(const tn: String): TIB_DDL_Trigger;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    procedure ParseMetadata; override;
    procedure BindToField;
    property ConstraintTypeName: String read          FConstraintTypeName;
    property IndexName: String read                   FIndexName;
    property ConstNameUq: String read                 FConstNameUq;
    property UpdateRuleName: String read              FUpdateRuleName;
    property DeleteRuleName: String read              FDeleteRuleName;
    property TriggerOrFieldName: String read          FTriggerOrFieldName;
    property RelationUq: String read                  FRelationUq;
    property ConstraintType: TIB_DDL_ConstraintType read  FConstraintType;
    property UpdateRule: TIB_DDL_UpdateDeleteRule read    FUpdateRule;
    property DeleteRule: TIB_DDL_UpdateDeleteRule read    FDeleteRule;
    property IsImplicitConstraint: Boolean read       FIsImplicitConstraint;
    property IsFaultyConstraint: Boolean read         FIsFaultyConstraint;
    function DoWriteFKRule(ARule: TIB_DDL_UpdateDeleteRule;
      const OnClause: String): String;
  end;

  // These are the entities that need parameters (above).
  TIB_DDL_EntWithParams = class(TIB_DDL_Entity)
  private
    FParams: array[0..1] of TIB_DDL_ParamList;
    FAuxOutputStrings: TStringList;
  protected
    FSystemFlag: Boolean;
    function DoGetEntityClassForList(pnum: Integer): TIB_DDL_EntityClass;
      virtual; abstract;
    procedure DoAfterParams(pnum: Integer); virtual;
    //procedure DoWritePreamble; override;
    procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    //class procedure BuildSQL2(s: TStrings); override;
    // The parent list will pass the row while looping in the result set
    constructor Create(row: TIB_Row); override;
    destructor Destroy; override;
    procedure _OnFormatterChanged(ft: TIB_DDL_FormatterType);
    //procedure ParseMetadata2(R: TIB_Row); override;
    procedure ParseParams(R: TIB_Row); //override;
    function GetParamCount(dimension: Boolean): Integer;
    function GetParams(dimension: Boolean; i: Integer): TIB_DDL_Param;
    function GetParamByName(dimension: Boolean; const pname: String): TIB_DDL_Param;
    function LocateParam(dimension: Boolean; const pname: String): TIB_DDL_Param;
    property SystemFlag: Boolean read FSystemFlag;
  end;

  // These cannot depend on other things.

  TIB_DDL_UDF = class(TIB_DDL_EntWithParams)
  private
    FFunctionType: Smallint;
    FModuleName: String;
    FEntryPoint: String;
    FReturnArgumentPos: SmallInt;
  protected
    function DoGetEntityClassForList(pnum: Integer): TIB_DDL_EntityClass; override;
    procedure DoAfterParams(pnum: Integer); override;
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    //constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row);
    function Priority: SmallInt; override;
    property FunctionType: SmallInt read        FFunctionType;
    property ModuleName: String read            FModuleName;
    property EntryPoint: String read            FEntryPoint;
    property ReturnArgumentPos: SmallInt read   FReturnArgumentPos;
  end;


  // These can depend on other things.

  TIB_DDL_TableView = class(TIB_DDL_EntWithParams)
  protected
    FViewBlr: String;
    FViewSource: String;
    FRelationId: SmallInt;
    FDbkeyLength: SmallInt;
    FFormatVersion: SmallInt;
    FFieldCount: SmallInt;
    FSecurityClass: String;
    FExternalFile: String;
    FOwnerName: String;
    FDefaultClass: String;
    FFlags: SmallInt;
    FViewCount: Integer;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    //constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    property ViewBlr: String read              FViewBlr;
    property ViewSource: String read           FViewSource;
    property RelationId: SmallInt read         FRelationId;
    property DbkeyLength: SmallInt read        FDbkeyLength;
    property FormatVersion: SmallInt read      FFormatVersion;
    property FieldCount: SmallInt read         FFieldCount;
    property SecurityClass: String read        FSecurityClass;
    property ExternalFile: String read         FExternalFile;
    property OwnerName: String read            FOwnerName;
    property DefaultClass: String read         FDefaultClass;
    property Flags: SmallInt read              FFlags;
    property ViewCount: Integer read           FViewCount;
  end;

  TIB_DDL_Table = class(TIB_DDL_TableView)
  private
    FIsExternal: Boolean;
  protected
    function DoGetEntityClassForList(pnum: Integer): TIB_DDL_EntityClass; override;
    procedure DoAfterParams(pnum: Integer); override;
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row);
    function Priority: SmallInt; override;
    property IsExternal: Boolean read FIsExternal;
  end;

  TIB_DDL_View = class(TIB_DDL_TableView)
  private
    FIsBinaryView: Boolean;
    FIsFaultyView: Boolean;
    FShowFieldNames: Boolean;
    FRelationCount: SmallInt;
    function CompleteWithCheckOption: Boolean;
  protected
    function DoGetEntityClassForList(pnum: Integer): TIB_DDL_EntityClass; override;
    procedure DoAfterParams(pnum: Integer); override;
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    //constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row);
    function Priority: SmallInt; override;
    property IsBinaryView: Boolean read   FIsBinaryView;
    property IsFaultyView: Boolean read   FIsFaultyView;
    property ShowFieldNames: Boolean read FShowFieldNames;
    property RelationCount: SmallInt read FRelationCount;
  end;

  TIB_DDL_Procedure = class(TIB_DDL_EntWithParams)
  private
    FProcedureId: SmallInt;
    FProcedureInputs: SmallInt;
    FProcedureOutputs: SmallInt;
    FProcedureSource: String;
    FProcedureBlr: String;
    FSecurityClass: String;
    FOwnerName: String;
    //FRuntime: String;
    FIsBinaryProcedure: Boolean;
    FIsFaultyProcedure: Boolean;
    FEffectiveInputs: SmallInt;
    FEffectiveOutputs: SmallInt;
  protected
    function DoGetEntityClassForList(pnum: Integer): TIB_DDL_EntityClass; override;
    procedure DoAfterParams(pnum: Integer); override;
    function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row);
    function Priority: SmallInt; override;
    property ProcedureId: SmallInt read             FProcedureId;
    property ProcedureInputs: SmallInt read         FProcedureInputs;
    property ProcedureOutputs: SmallInt read        FProcedureOutputs;
    property ProcedureSource: String read           FProcedureSource;
    property ProcedureBlr: String read              FProcedureBlr;
    property SecurityClass: String read             FSecurityClass;
    property OwnerName: String read                 FOwnerName;
    property IsBinaryProcedure: Boolean read        FIsBinaryProcedure;
    property IsFaultyProcedure: Boolean read        FIsFaultyProcedure;
    property EffectiveInputs: SmallInt read         FEffectiveInputs;
    property EffectiveOutputs: SmallInt read        FEffectiveOutputs;
  end;

implementation

uses
  IB_DDL_Utility, IB_DDL_Controller;

// ----------------------------------------------------------
// TIB_DDL_Param

function TIB_DDL_Param.GetParamList: TIB_DDL_ParamList;
begin
  Result := FEntityList as TIB_DDL_ParamList
end;

function TIB_DDL_Param.GetMasterEntity: TIB_DDL_EntWithParams;
begin
  With TIB_DDL_ParamListHack(FEntityList as TIB_DDL_ParamList) do
    Result := (OwnerEntity as TIB_DDL_EntWithParams)
end;

function TIB_DDL_Param.GetMasterEntityList: TIB_DDL_EntListWithParams;
begin
  With TIB_DDL_ParamListHack(FEntityList as TIB_DDL_ParamList) do
    With (OwnerEntity as TIB_DDL_EntWithParams) do
      Result := (FEntityList as TIB_DDL_EntListWithParams)
end;

function TIB_DDL_Param.LocateAssociatedDomain(const dn: String): TIB_DDL_Domain;
begin
  With GetMasterEntityList do
    Result := GetDomainByName(dn);
  if not Assigned(Result)
  then LocateEntityError('LocateAssociatedDomain', ClassName,
    FOwnerName + '.' + FName + ' -> ' + dn, ' not found')
end;

function TIB_DDL_Param.LocateAssociatedIndex(const ixn: String): TIB_DDL_Index;
begin
  With GetMasterEntityList do
    Result := GetIndexByName(ixn);
  if not Assigned(Result)
  then LocateEntityError('LocateAssociatedIndex', ClassName,
    FOwnerName + '.' + FName + ' -> ' + ixn, ' not found')
end;


// ----------------------------------------------------------
// TIB_DDL_UDF_Param

class procedure TIB_DDL_UDF_Param.BuildSQL(s: TStrings;Connection: TIB_Connection); //override;
begin
  s.Add('SELECT');
  s.Add('M.RDB$FUNCTION_NAME,');
  s.Add('M.RDB$ARGUMENT_POSITION,');         //SMALLINT,
  s.Add('M.RDB$MECHANISM,');                 //SMALLINT,
  s.Add('M.RDB$FIELD_TYPE,');                //SMALLINT,
  s.Add('M.RDB$FIELD_SCALE,');               //SMALLINT,
  s.Add('M.RDB$FIELD_LENGTH,');              //SMALLINT,
  s.Add('M.RDB$FIELD_SUB_TYPE,');            //SMALLINT,
  s.Add('M.RDB$CHARACTER_SET_ID,');          //SMALLINT,
  if Connection.Characteristics.dbODS_Version >= 10 then
  s.Add('M.RDB$FIELD_PRECISION,')            //SMALLINT,
  else
  s.Add('null as RDB$FIELD_PRECISION,');     //SMALLINT,
  s.Add('M.RDB$CHARACTER_LENGTH,');          //SMALLINT,
  s.Add('T.RDB$TYPE_NAME,');
  s.Add('   (SELECT T2.RDB$TYPE_NAME FROM RDB$TYPES T2');
  s.Add('   WHERE M.RDB$FIELD_SUB_TYPE = T2.RDB$TYPE');
  s.Add('   AND T2.RDB$FIELD_NAME = ' + QuotedStr('RDB$FIELD_SUB_TYPE') + ')');
  s.Add('   AS RDB$SUB_TYPE_NAME,');
  s.Add('CS.RDB$CHARACTER_SET_NAME,');
  s.Add('CS.RDB$BYTES_PER_CHARACTER');
  // Thanks Borland for not including type=16 INT64 in system tables of IB6.
  // You make life harder and force the use of a LEFT JOIN.
  s.Add('FROM RDB$FUNCTION_ARGUMENTS M LEFT JOIN RDB$TYPES T');
  s.Add('ON M.RDB$FIELD_TYPE = T.RDB$TYPE');
  s.Add('AND T.RDB$FIELD_NAME = ' + QuotedStr('RDB$FIELD_TYPE'));
  s.Add('LEFT JOIN RDB$CHARACTER_SETS CS');
  s.Add('ON M.RDB$CHARACTER_SET_ID = CS.RDB$CHARACTER_SET_ID');
  s.Add('ORDER BY M.RDB$FUNCTION_NAME, M.RDB$ARGUMENT_POSITION')
end;

procedure TIB_DDL_UDF_Param.ParseMetadata; //override;
var
  hdr: String;
  charsetWasNull: Boolean;
begin
  With FIB_Row do
  begin
    FName := EmptyStr; // Because UDF parameters are unnamed.
    FOwnerName := BySQLNo(0).AsString;
    FArgumentPosition := BySQLNo(1).AsSmallInt;
    FMechanism := BySQLNo(2).AsSmallInt;
    FFieldType := BySQLNo(3).AsSmallInt;
    FFieldScale := BySQLNo(4).AsSmallInt;
    FFieldLength := BySQLNo(5).AsSmallInt;
    FFieldSubType := BySQLNo(6).AsSmallInt;
    FCharacterSetId := BySQLNo(7).AsSmallInt;
    charsetWasNull := BySQLNo(7).IsNull;
    FFieldPrecision := BySQLNo(8).AsSmallInt;
    FCharacterLength := BySQLNo(9).AsSmallInt;
    FTypeName := IB_DDL_Utility.FieldTypeAsChar( FFieldType,
                                                 BySQLNo(10).AsString );
    FSubTypeName := IB_DDL_Utility.AdjustField( FFieldType,
                                                FFieldSubType,
                                                FFieldPrecision,
                                                FTypeName,
                                                BySQLNo(11).AsString,
                                                FFieldScale,
                                                FIsNumericOrDecimal,
                                                False );
    // Very "interesting": here BLOBs don't accept a collation.
    if FFieldType-14 in [14-14, 37-14, 40-14{, 261-14}]
    then begin
      FCharacterSetName := BySQLNo(12).AsString;
      FBytesPerCharacter := BySQLNo(13).AsSmallInt;
      { UDFs don't have Collation
      if FFieldType in [14, 37, 40]
      then FCollationName := BySQLNo(21).AsString
      }
    end
  end;
  FIsOutputParameter :=
    TIB_DDL_ParamListHack(FEntityList).SpecialTag = FArgumentPosition;
  if FIsOutputParameter
  then FIsFreeIt := FMechanism < 0;
  hdr := 'UDF ' + FOwnerName + #39 + 's';
  if FIsOutputParameter
    then hdr := hdr + ' return parameter at internal Argument Pos '
    else hdr := hdr + ' input parameter at internal Argument Pos ';
  hdr := hdr + IntToStr(FArgumentPosition);
  if FArgumentPosition < 0
  then NewBug := hdr + ' Argument position must be >=0 but is '
    + IntToStr(FArgumentPosition);
  if (FFieldType = 16) and (FFieldSubType = 0) and (FTypeName[1] = '_')
  then NewBug := hdr + ' Type 16 can be only NUMERIC or DECIMAL';
  if FFieldType-14 in [14-14, 37-14, 40-14, 261-14]
  then begin
    if charsetWasNull
    then begin
      FCharacterSetName := 'NONE';
      FBytesPerCharacter := 1;
      NewBug := hdr + ' Charset Id was NULL, assuming NONE'
    end
    else if FCharacterSetName = EmptyStr
    then begin
      FCharacterSetName := 'NONE';
      NewBug := hdr + ' Missing name for charset ID '
        + IntToStr(FCharacterSetId) + ' Assuming NONE'
    end
  end;
    // Very "interesting": here BLOBs don't accept a collation.
  if (FFieldType in [14, 37, 40])
  then begin
    if FCharacterLength = 0
    then try
      FCharacterLength := FFieldLength div FBytesPerCharacter
    except
      NewBug := hdr +
        ' BytesPerCharacter was zero in charset name ' + FCharacterSetName
    end;
    if ((FCharacterLength = 0) or (FFieldLength mod FCharacterLength <> 0))
    then NewBug := hdr + ' FieldLength ' + IntToStr(FFieldLength)
      + ' should be multiple of CharacterLength ' + IntToStr(FCharacterLength)
      + ' in charset name ' + FCharacterSetName
  end;
  if not (FFieldType in [14, 11, 27, 10, 16, 8, 9, 7, 12, 13, 35, 37, 40])
    and (FFieldType <> 261)
  then NewBug := hdr + ' Unknown FieldType ' + IntToStr(FFieldType);
  { Here we accept happily CSTRING
  if FFieldType = 40
  then NewBug := AuxS + ' FieldType CSTRING is not accepted by DSQL'
  else} if FFieldType = 9
  then NewBug := hdr + ' FieldType QUAD is not accepted by DSQL'
end;

function TIB_DDL_UDF_Param.DoWrite: Boolean; //override;
var
  AuxLine, MechanismName: String;
begin
  // UDF params don't have name
  With Formatter do
  begin
    AuxLine := Normal(FTypeName);
    if FFieldType in [14, 37, 40] then
      AuxLine := AuxLine + Normal('(' + IntToStr(FCharacterLength) + ')')
    else
    if FIsNumericOrDecimal then
    begin
      if FFieldPrecision = 0 then
      if FFieldType = blr_short then FFieldPrecision := 5 else
      if FFieldType = blr_long then FFieldPrecision := 9 else
      if FFieldType = blr_quad then FFieldPrecision := 18 else
      if FFieldType = blr_int64 then FFieldPrecision := 18 else
      if FFieldType = blr_float then FFieldPrecision := 11 else
      if FFieldType = blr_double then FFieldPrecision := 15;        
      AuxLine := AuxLine +
           MFormat('(N,N)', [IntToStr(FFieldPrecision), IntToStr(-FieldScale)]);
    end;
    {if FDimensions > 0
    then AuxLine := AuxLine + Normal('[' + FDimensionsLine + ']')
    else} (*if FFieldType = 261 {FieldIsBlob}
    then AuxLine := AuxLine + MFormat('B N'{ B N'},
     [' SUB_TYPE', FSubTypeName{, 'SEGMENT SIZE', IntToStr(FSegmentLength)}]);*)
    if FFieldType-14 in [14-14, 37-14, 40-14{, 261-14}] then
      AuxLine := AuxLine +
                 MFormat('B N', [' CHARACTER SET', FCharacterSetName]);
    if FMechanism = 0 then
      MechanismName := 'BY VALUE'
    else
    if Mechanism < 0 then
      MechanismName := 'FREE_IT'
    else
      MechanismName := EmptyStr;
    if IsOutputParameter then
    begin
      if FPositionalReturn then
      begin
        NewLine := AuxLine;
        AuxLine := MFormat('B N', ['RETURNS PARAMETER',
          IntToStr(TIB_DDL_ParamListHack(FEntityList).SpecialTag + 1)])
      end
      else
        AuxLine := MFormat('B R B', ['RETURNS', AuxLine, MechanismName])
    end;
    NewLine := AuxLine;
  end;
  Result := True
end;


// ----------------------------------------------------------
// TIB_DDL_TableViewProc_Param

class procedure TIB_DDL_TableViewProc_Param.BuildSQL(s: TStrings;Connection: TIB_Connection); //override;
begin
  s.Add('SELECT');
  s.Add('M.RDB$PROCEDURE/TABLE_NAME,');
  s.Add('M.RDB$PARAMETER/FIELD_NAME,');
  s.Add('M.RDB$FIELD_SOURCE,');
  s.Add('M.RDB$SYSTEM_FLAG,');  // SmallInt => Boolean
end;

procedure TIB_DDL_TableViewProc_Param.ParseMetadata; //override;
begin
  With FIB_Row do
  begin
    FOwnerName := BySQLNo(0).AsString;
    FName := BySQLNo(1).AsString; // First parameter now is the owner.
    FFieldSource := BySQLNo(2).AsString;
    FSystemFlag:= BySQLNo(3).AsBoolean
  end;
  try
    FAssociatedDomainPtr := LocateAssociatedDomain(FFieldSource)
  except
    on E: Exception do
    begin
      AddBug(E.Message);
      AddBug('ParseMetadata - Error while locating or parsing.')
    end
  end;
  { Not needed since we don't load system domains
  if Assigned(FAssociatedDomainPtr) and FAssociatedDomainPtr.SystemFlag
  then NewBug := FOwnerName + '.' + FName + ' -> ' + FAssociatedDomainPtr.Name
    + ' Has system flag set'
  }
end;


// ----------------------------------------------------------
// TIB_DDL_Proc_Param

class procedure TIB_DDL_Proc_Param.BuildSQL(s: TStrings;Connection: TIB_Connection); //override;
begin
  inherited BuildSQL(s,Connection);
  s[1] := ('M.RDB$PROCEDURE_NAME,');
  s[2] := ('M.RDB$PARAMETER_NAME,');
  s.Add('M.RDB$PARAMETER_NUMBER,');        //SMALLINT
  s.Add('M.RDB$PARAMETER_TYPE');           //SMALLINT
  s.Add('FROM RDB$PROCEDURE_PARAMETERS M');
  s.Add('ORDER BY M.RDB$PROCEDURE_NAME, ' +
                 'M.RDB$PARAMETER_TYPE, ' +
                 'M.RDB$PARAMETER_NUMBER')
end;

procedure TIB_DDL_Proc_Param.ParseMetadata; //override;
var
  hdr: String;
begin
  inherited ParseMetadata;
  with FIB_Row do
  begin
    FParameterNumber := BySQLNo(4).AsSmallInt;
    FParameterType := BySQLNo(5).AsSmallInt;
    FIsInputParameter := FParameterType = 0;
    FIsOutputParameter := FParameterType = 1
  end;
  hdr := 'Procedure ' + FOwnerName + #39 + 's';
  if FIsInputParameter then
    hdr := hdr + ' input parameter ' + FName
  else
  if FIsOutputParameter then
    hdr := hdr + ' output parameter ' + FName
  else
  begin
    hdr := hdr + ' parameter ' + FName;
    NewBug := hdr +
      ' Parameter type ' + IntToStr(FParameterType) + ' is out of range'
  end;
  if FParameterNumber < 0 then
    NewBug := hdr + ' Parameter number must be >=0 but is '
              + IntToStr(FParameterNumber);
  if FSystemFlag then
    NewBug := hdr + ' Has system flag set';
  if Assigned(FAssociatedDomainPtr) then
  with FAssociatedDomainPtr do
  begin
    if IsExternalDomain then
      NewBug := hdr + ' -> ' + Name +
              ' Procedure cannot be external but associated domain is external';
    if not IsImplicitDomain then
      NewBug := hdr + ' -> ' + Name +
        ' Procedure uses implicit domains but associated domain is not implicit'
  end
end;

function TIB_DDL_Proc_Param.DoWrite: Boolean; //override;
begin
  if not Assigned(FAssociatedDomainPtr) then
  begin
    Result := False;
    Exit
  end;
  with Formatter, FAssociatedDomainPtr do
  begin
    if FIsInputParameter or FIsOutputParameter then
      NewLine := MFormat('D # R', [FName, FFieldSource, DoWriteTypeCharset])
    else
      NewLine := IBCommentRaw( Normal(FName + #32 + FFieldSource + #32) +
                               DoWriteTypeCharset )
  end;
  Result := True
end;


// ----------------------------------------------------------
// TIB_DDL_TableView_Param

class procedure TIB_DDL_TableView_Param.BuildSQL(s: TStrings;Connection: TIB_Connection); //override;
begin
  inherited BuildSQL(s,Connection);
  s[1] := ('M.RDB$RELATION_NAME,');
  s[2] := ('RDB$FIELD_NAME,');
  //s.Add('M.RDB$QUERY_NAME,');
  s.Add('M.RDB$BASE_FIELD,');
  s.Add('M.RDB$FIELD_POSITION,');
  s.Add('M.RDB$FIELD_ID,');
  s.Add('M.RDB$VIEW_CONTEXT,');
  s.Add('M.RDB$SECURITY_CLASS,');
  s.Add('M.RDB$NULL_FLAG,')
end;

procedure TIB_DDL_TableView_Param.ParseMetadata; //override;
begin
  inherited ParseMetadata;
  With FIB_Row do
  begin
    //FQueryName := BySQLNo(4).AsString;
    FBaseField := BySQLNo(4).AsString;
    FBaseFieldWasEmpty := BySQLNo(4).IsNull;
    FFieldPosition := BySQLNo(5).AsSmallInt;
    FFieldId := BySQLNo(6).AsSmallInt;
    FViewContext := BySQLNo(7).AsSmallInt;
    FViewContextWasEmpty := BySQLNo(7).IsNull;
    FSecurityClass := BySQLNo(8).AsString;
    FIsMandatory := BySQLNo(9).AsBoolean
  end
end;


// ----------------------------------------------------------
// TIB_DDL_Table_Param

class procedure TIB_DDL_Table_Param.BuildSQL(s: TStrings;Connection: TIB_Connection); //override;
begin
  inherited BuildSQL(s,Connection);
  s.Add('M.RDB$DEFAULT_SOURCE,');
  s.Add('M.RDB$COLLATION_ID,');
  s.Add('   (SELECT C.RDB$COLLATION_NAME FROM RDB$COLLATIONS C');
  s.Add('   JOIN RDB$FIELDS F');
  s.Add('   ON F.RDB$CHARACTER_SET_ID = C.RDB$CHARACTER_SET_ID');
  s.Add('   AND M.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME');
  s.Add('   AND M.RDB$COLLATION_ID = C.RDB$COLLATION_ID)');
  s.Add('   AS RDB$COLLATION_NAME');
  s.Add('FROM RDB$RELATION_FIELDS M');
  s.Add('ORDER BY M.RDB$RELATION_NAME, M.RDB$FIELD_POSITION')
end;

procedure TIB_DDL_Table_Param.ParseMetadata; //override;
var
  hdr: String;
begin
  inherited ParseMetadata;
  With FIB_Row do
  begin
    FDefaultSource := BySQLNo(10).AsString;
    FCollationId := BySQLNo(11).AsSmallInt;
    FOverridesMandatory := BySQLNo(9).IsNotNull;
    FOverridesDefault := BySQLNo(10).IsNotNull;
    FOverridesCollation := BySQLNo(11).IsNotNull;
    if {Assigned(FAssociatedDomainPtr) and
      (FAssociatedDomainPtr.FieldType in [14, 37, 40]) and} FOverridesCollation
    then FCollationName := BySQLNo(12).AsString
  end;
  hdr := 'Table ' + FOwnerName + #39 + 's field ' + FName;
  if FFieldId < 0 then
    NewBug := hdr + ' Field Id must be >=0 but is ' + IntToStr(FFieldId);
  if FFieldPosition < 0 then
    NewBug := hdr + ' Field position must be >=0 but is '
              + IntToStr(FFieldPosition);
  if FSystemFlag then
    NewBug := hdr + ' Has system flag set';
  if FOverridesDefault then
  begin
    if Copy(Trim(UpperCase(FDefaultSource)), 1, 7) <> 'DEFAULT' then
      NewBug := hdr + ' Suspicious default: ' + FDefaultSource
    else
    begin
      FDefaultSource :=
        Trim(Copy(Trim(FDefaultSource), 8, Length(FDefaultSource)));
      if Length(FDefaultSource) = 0 then
      begin
        NewBug := hdr + ' Declared but void default';
        FOverridesDefault := False
      end
    end
  end;
  if Assigned(FAssociatedDomainPtr) then
  with FAssociatedDomainPtr do
  begin
    {
    if IsImplicitDomain
    then begin
      if FOverridesMandatory
      then NewBug := hdr + ' -> ' + Name
        + ' Adds NOT NULL clause to implicit domain';
      if FOverridesDefault
      then NewBug := hdr + ' -> ' + Name
        + ' Overrides default value of an implicit domain';
      if FOverridesCollation
      then NewBug := hdr + ' -> ' + Name
        + ' Overrides collation of an implicit domain'
    end;
    }
    if IsExternalDomain and not (GetMasterEntity as TIB_DDL_Table).IsExternal then
      NewBug := hdr + ' -> ' + Name
                + ' Table is not external but associated domain is external'
    else
    if not IsExternalDomain and (GetMasterEntity as TIB_DDL_Table).IsExternal then
      NewBug := hdr + ' -> ' + Name
                + ' Table is external but associated domain is not external';
    if FOverridesCollation then
    begin
      if not (FieldType in [14, 37, 40]) then
      begin
        FCollationName := EmptyStr;
        NewBug := hdr + ' -> ' + Name +
          ' Field of type ' + IntToStr(FieldType) + ' cannot override collation'
      end
      else
      if FCollationId < 0 then
        NewBug := hdr +
                 ' Collation Id cannot be < 0 but is ' + IntToStr(FCollationId)
      else
      if FCollationName = EmptyStr then
      begin
        {if charsetWasNull
        then} FCollationName := 'NONE'
        {else if (defCollateName = EmptyStr)
        then FCollationName := FCharacterSetName
        else FCollationName := defCollateName};
        NewBug := hdr + ' Collation Id was NULL, assuming ' + FCollationName
      end
    end
  end;
  if not FBaseFieldWasEmpty then
    NewBug := hdr + ' BaseField should be empty for tables but is ' +
              FBaseField;
  if not FViewContextWasEmpty then
    NewBug := hdr + ' ViewContext should be empty for tables but is ' +
              IntToStr(FViewContext)
end;

function TIB_DDL_Table_Param.DoWrite: Boolean; //override;
var
  AuxLine: array[1..6] of String;
  ResLine: String;
  iter: Integer;
begin
  if not Assigned(FAssociatedDomainPtr) then
  begin
    Result := False;
    Exit
  end;
  With Formatter, FAssociatedDomainPtr do
  begin
    if IsComputed then
      AuxLine[1] := MFormat('D !', [FName, Normal(FFieldSource + #32) +
                    DoWriteTypeCharset] )
    else
    if IsImplicitDomain then
      AuxLine[1] := MFormat('D # R', [FName, FFieldSource, DoWriteTypeCharset])
    else
      AuxLine[1] := MFormat('D D !', [FName, FFieldSource, DoWriteTypeCharset]);
    AuxLine[1] := Trim(AuxLine[1]);
    //AuxLine[1] := DoWriteTypeCharset;
    AuxLine[2] := DoWriteComputed(True);
    AuxLine[3] := DoWriteDefault(FDefaultSource);
    AuxLine[4] := DoWriteMandatory(FIsMandatory);
    //If there's a check constraint print check
    AuxLine[5] := DoWriteConstraint( false );
    if FOverridesCollation then
      AuxLine[6] := DoWriteCollation(FCollationId, FCollationName)
    else
    if IsImplicitDomain then
      AuxLine[6] := DoWriteCollation(-1, EmptyStr)
    else
      AuxLine[6] := EmptyStr;
    {
    for iter := High(AuxLine) downto Low(AuxLine) do
      if AuxLine[iter] <> EmptyStr
      then begin
        AuxLine[iter] := AuxLine[iter] + MFormat(';', ['']);
        break
      end;
    }
    ResLine := EmptyStr;
    for iter := Low(AuxLine) + 1 + Ord(IsComputed) to High(AuxLine) do
      if AuxLine[iter] <> EmptyStr then
      begin
        if ResLine = EmptyStr then
          ResLine := AuxLine[iter]
        else
          ResLine := MFormat('R R', [ResLine, AuxLine[iter]])
      end;
    if IsComputed then
    begin
      if ResLine = EmptyStr then
        NewLine := AuxLine[Low(AuxLine)] + Normal(#32) +
                   AuxLine[Low(AuxLine) + 1]
      else
        NewLine := AuxLine[Low(AuxLine)] + Normal(#32) +
                   AuxLine[Low(AuxLine) + 1] + Normal(#32) +
                   DebugOutputRaw(ResLine)
    end
    else
    begin
      if ResLine = EmptyStr then
        NewLine := AuxLine[Low(AuxLine)]
      else
        NewLine := AuxLine[Low(AuxLine)] + Normal(#32) + ResLine;
    end;
  end;
  Result := True;
end;


// ----------------------------------------------------------
// TIB_DDL_View_Param

class procedure TIB_DDL_View_Param.BuildSQL(s: TStrings;Connection: TIB_Connection); //override;
begin
  inherited BuildSQL(s,Connection);
  DeleteLastCommaFromStrings(s);
  s.Add('FROM RDB$RELATION_FIELDS M');
  s.Add('ORDER BY M.RDB$RELATION_NAME, M.RDB$FIELD_POSITION')
end;

procedure TIB_DDL_View_Param.ParseMetadata; //override;
var
  hdr: String;
begin
  inherited ParseMetadata;
  { Nothing extra to do here.
  With FIB_Row do
  begin
  end;
  }
  FIsImplicitField := (FViewContext > 0) and (FName = FBaseField);
  hdr := 'View ' + FOwnerName + #39 + 's field ' + FName;
  if FFieldId < 0
  then NewBug := hdr + ' Field Id must be >=0 but is ' + IntToStr(FFieldId);
  if FFieldPosition < 0
  then NewBug := hdr + ' Field position must be >=0 but is '
    + IntToStr(FFieldPosition);
  if FSystemFlag
  then NewBug := hdr + ' Has system flag set';
  if IsMandatory
  then NewBug := hdr + ' Cannot be mandatory in a view';
  if Assigned(FAssociatedDomainPtr)
  then with FAssociatedDomainPtr do
  begin
    {
    if not IsImplicitDomain
    then NewBug := hdr + ' -> ' + Name
      + ' View uses implicit domains but associated domain is not implicit';
    }
    if IsExternalDomain then
    NewBug := hdr + ' -> ' + Name
              + ' View cannot be external but associated domain is external'
  end;
  if FBaseFieldWasEmpty and (FViewCOntext > 0)
  then NewBug := hdr
     + ' BaseField should not be empty for views if ViewContext > 0';
  if FViewContextWasEmpty
  then NewBug := hdr
    + ' ViewContext cannot be empty for views';
  if FViewContext < 0
  then NewBug := hdr + ' ViewContext should be >= 0 for views'
end;

function TIB_DDL_View_Param.DoWrite: Boolean; //override;
var
  ResLine: String;
begin
  { It becomes a moot point here. We can output but can't calculate dependencies.
  if not Assigned(FAssociatedDomainPtr)
  then begin
    Result := False;
    Exit
  end;
  }
  With Formatter, FAssociatedDomainPtr do
  begin
    if Assigned(FAssociatedDomainPtr)
    then begin
      // Let the parent decide, since it has the info about all fields.
      {if FIsImplicitField
      then ResLine :=
        MFormat('* * *', [FName, FFieldSource, DoWriteTypeCharset])
      else} ResLine :=
        MFormat('D !', [FName, Normal(FFieldSource + #32) + DoWriteTypeCharset])
    end
    else begin
      {if FIsImplicitField
      then ResLine := EmptyStr
      else} ResLine := IBIdentifier(FName)
    end;
    NewLine := ResLine
  end;
  Result := True
end;


// ----------------------------------------------------------
// TIB_DDL_View_Param

class procedure TIB_DDL_Table_Constraint.BuildSQL(s: TStrings;Connection: TIB_Connection); //override;
begin
  s.Add('SELECT');
  s.Add('M.RDB$RELATION_NAME,');
  s.Add('M.RDB$CONSTRAINT_NAME,');
  s.Add('M.RDB$CONSTRAINT_TYPE,');
  s.Add('M.RDB$INDEX_NAME,');
  s.Add('RC.RDB$CONST_NAME_UQ,');
  s.Add('RC.RDB$UPDATE_RULE,');
  s.Add('RC.RDB$DELETE_RULE,');
  // This MAX is a trick to avoid "multiple records in singleton select error
  // msg and operates in the assumption that implicit triggers for check
  // constraints are the same for update and delete operations, by design.
  s.Add('(SELECT MAX(CC.RDB$TRIGGER_NAME) FROM RDB$CHECK_CONSTRAINTS CC');
  s.Add('WHERE M.RDB$CONSTRAINT_NAME = CC.RDB$CONSTRAINT_NAME)');
  s.Add('AS TRIGGERorFIELD_NAME,');
  s.Add('RCUQ.RDB$RELATION_NAME AS RDB$RELATION_UQ');
  s.Add('FROM RDB$RELATION_CONSTRAINTS M');
  s.Add('LEFT JOIN RDB$REF_CONSTRAINTS RC');
  s.Add('ON M.RDB$CONSTRAINT_NAME = RC.RDB$CONSTRAINT_NAME');
  s.Add('LEFT JOIN RDB$RELATION_CONSTRAINTS RCUQ');
  s.Add('ON RC.RDB$CONST_NAME_UQ = RCUQ.RDB$CONSTRAINT_NAME');
  s.Add('ORDER BY M.RDB$RELATION_NAME, M.RDB$CONSTRAINT_NAME')
end;

function TIB_DDL_Table_Constraint.ParseFKRule(const udrname: String):
  TIB_DDL_UpdateDeleteRule;
begin
  if udrname = 'RESTRICT' then Result := murRestrict else
  if udrname = 'CASCADE' then Result := murCascade else
  if udrname = 'SET NULL' then Result := murSetNull else
  if udrname = 'SET DEFAULT' then Result := murSetDefault else
                                  Result := murNone
end;

procedure TIB_DDL_Table_Constraint.ParseMetadata; //override;
var
  hdr: String;
begin
  With FIB_Row do
  begin
    FOwnerName := BySQLNo(0).AsString;
    FName := BySQLNo(1).AsString;
    FConstraintTypeName := BySQLNo(2).AsString;
    FIndexName := BySQLNo(3).AsString;
    FConstNameUq := BySQLNo(4).AsString;
    FUpdateRuleName := BySQLNo(5).AsString;
    FDeleteRuleName := BySQLNo(6).AsString;
    FTriggerOrFieldName := BySQLNo(7).AsString;
    FRelationUq := BySQLNo(8).AsString;
  end;
  if (Copy(FName, 1, 6) = 'INTEG_') and
     (Length(FName) > 6) and (FName[7] in ['1'..'9']) and
     (StrToIntDef(Copy(FName, 7, 31), 0) > 0) then
    FIsImplicitConstraint := True;
  hdr := 'Table ' + FOwnerName + #39 + 's constraint ' + FName;
  if (FConstraintTypeName = 'PRIMARY KEY') then FConstraintType := mctPrimary
  else
  if (FConstraintTypeName = 'UNIQUE') then FConstraintType := mctUnique
  else
  if (FConstraintTypeName = 'FOREIGN KEY') then FConstraintType := mctForeign
  else
  if (FConstraintTypeName = 'NOT NULL') then FConstraintType := mctNotNull
  else
  if (FConstraintTypeName = 'CHECK') then FConstraintType := mctCheck
  else
  begin
    FConstraintType := mctNone;
    FIsFaultyConstraint := True;
    NewBug := hdr + 'Constraint type ' + FConstraintTypeName
              + ' is out of range'
  end;
  if (FConstraintType in [mctNotNull, mctCheck]) then
  begin
    if FIndexName <> EmptyStr then
      NewBug := hdr + 'Constraint type ' + FConstraintTypeName +
                ' should not use an index but is using index ' + FIndexName;
    if FConstraintType = mctNotNull then
      try
        FAssociatedFieldPtr := LocateAssociatedField( FTriggerOrFieldName );
        // Give the constraint to the field itself, IB doesn't support
        // full syntax regarding NULL constraints.
        FAssociatedFieldPtr.FIsMandatory := True
      except
        on E: Exception do
        begin
          AddBug(E.Message);
          AddBug('ParseMetadata - Error while locating or parsing.')
        end
      end
    else
      try // mctCheck
        FAssociatedTriggerPtr := LocateAssociatedTrigger(FTriggerOrFieldName)
      except
        on E: Exception do
        begin
          AddBug(E.Message);
          AddBug('ParseMetadata - Error while locating or parsing.')
        end
      end
  end
  else
  if FConstraintType <> mctNone then // fk, uk, pk
  begin
    if FIndexName = EmptyStr then
      NewBug := hdr + 'Constraint type ' + FConstraintTypeName +
                ' should use an index but is not using one'
    else
    begin
      try
        FAssociatedIndexPtr := LocateAssociatedIndex(FIndexName)
      except
        on E: Exception do
        begin
          AddBug(E.Message);
          AddBug('ParseMetadata - Error while locating or parsing.')
        end
      end
    end
  end;
  if FConstraintType = mctForeign then
  begin
    FUpdateRule := ParseFKRule(FUpdateRuleName);
    if FUpdateRule = murNone then
    begin
      FIsFaultyConstraint := True;
      NewBug := hdr + ' Update rule ' + FUpdateRuleName + ' is out of range'
    end;
    FDeleteRule := ParseFKRule(FDeleteRuleName);
    if FDeleteRule = murNone then
    begin
      FIsFaultyConstraint := True;
      NewBug := hdr + ' Delete rule ' + FDeleteRuleName + ' is out of range'
    end;
    if FConstNameUq = EmptyStr then
    begin
      FIsFaultyConstraint := True;
      NewBug := hdr + ' Constraint name for parent relation is empty'
    end
  end
  else
  begin
    if FConstNameUq <> EmptyStr then
      NewBug := hdr + ' Constraint name for parent relation should be empty'
      + ' but is ' + FConstNameUq;
    if FUpdateRuleName <> EmptyStr
    then NewBug := hdr +
      ' Update rule should be empty but is ' + FUpdateRuleName;
    if FDeleteRuleName <> EmptyStr
    then NewBug := hdr +
      ' Delete rule should be empty but is ' + FDeleteRuleName
  end
end;

function TIB_DDL_Table_Constraint.LocateAssociatedField(const fn: String):
  TIB_DDL_Table_Param;
begin
  With GetMasterEntity do
    Result := GetParamByName(False, fn) as TIB_DDL_Table_Param;
  if not Assigned(Result) then
    LocateEntityError( 'LocateAssociatedField',
                       ClassName,
                       FOwnerName + '.' + FName + ' -> ' + fn,
                       ' not found')
end;

function TIB_DDL_Table_Constraint.LocateAssociatedTrigger(const tn: String):
  TIB_DDL_Trigger;
begin
  With GetMasterEntityList do
    Result := GetTriggerByName(tn);
  if not Assigned(Result) then
    LocateEntityError( 'LocateAssociatedTrigger', ClassName,
                       FOwnerName + '.' + FName + ' -> ' + tn,
                       ' not found')
end;

procedure TIB_DDL_Table_Constraint.BindToField;
var
  cuq: TIB_DDL_Table_Constraint;
  mrel: TIB_DDL_Table;
begin
  case FConstraintType of
    mctPrimary:; // en ParseMetadata
    mctUnique:; // en ParseMetadata
    mctForeign:
      try
        FAssociatedMasterIndexPtr :=
          LocateAssociatedIndex(FAssociatedIndexPtr.ForeignKey);
        mrel := GetMasterEntityList.GetEntityByName(
          FAssociatedMasterIndexPtr.RelationName) as TIB_DDL_Table;
        if not Assigned(mrel) then
          AddBug('BindToField - Referenced table ' + FName + ' -> '
                 + FAssociatedMasterIndexPtr.RelationName + ' not found')
        else
        begin
          cuq := mrel.GetParamByName(True, FConstNameUq) as TIB_DDL_Table_Constraint;
          if not Assigned(cuq) then
            AddBug( 'BindToField - Referenced constraint ' + FName + ' -> '
                    + FConstNameUq + ' not found')
          else
          if cuq.FIndexName <> FAssociatedMasterIndexPtr.Name then
            AddBug('BindToField - Index in constraint ' +
                   'and referenced constraint do not match')
        end
      except
        on E: Exception do
        begin
          AddBug(E.Message);
          AddBug('BindToField - Error while locating or parsing.')
        end
      end;
    mctNotNull:; // en ParseMetadata
    mctCheck:; // en ParseMetadata
    mctNone:; // nothing to do
  end
end;

function TIB_DDL_Table_Constraint.DoWriteFKRule(ARule: TIB_DDL_UpdateDeleteRule;
  const OnClause: String): String;
begin
  case ARule of
    murRestrict: Result := 'NO ACTION';
    murCascade: Result := 'CASCADE';
    murSetNull: Result := 'SET DEFAULT';
    murSetDefault: Result := 'SET NULL';
    murNone: Result := EmptyStr
  end;
  if Result <> EmptyStr then
    if ARule = murRestrict then
      Result := Formatter.DebugOutput(OnClause + #32 + Result)
    else
      Result := Formatter.MFormat('B B', [OnClause, Result]);
end;

function TIB_DDL_Table_Constraint.DoWrite: Boolean; //override;
var
  iter: Integer;
  AuxLine: array[1..4] of String;
  ResLine: String;
begin
  Result := False;
  if (not Assigned(FAssociatedIndexPtr) and
     (FConstraintType in [mctPrimary, mctUnique, mctForeign])) then
    Exit;
  if (not Assigned(FAssociatedMasterIndexPtr) and
     (FConstraintType in [mctForeign])) then
    Exit;
  if (not Assigned(FAssociatedFieldPtr) and
     (FConstraintType = mctNotNull)) then
    Exit;
  if (not Assigned(FAssociatedTriggerPtr) and
     (FConstraintType = mctCheck)) then
    Exit;
  if (( PassNumber = 1 ) and ( FConstraintType = mctForeign )) or
     (( PassNumber = 2 ) and ( FConstraintType <> mctForeign )) then
    Exit;  

  with Formatter, FAssociatedIndexPtr do
  begin
    if FIsImplicitConstraint then
      AuxLine[1] := MFormat('B D B', ['ALTER TABLE', FOwnerName, 'ADD'])
    else
      AuxLine[1] := MFormat('B D B D', ['ALTER TABLE', FOwnerName,
        'ADD CONSTRAINT', FName]);
    AuxLine[3] := EmptyStr;
    AuxLine[4] := EmptyStr;
    case FConstraintType of
      mctPrimary:
        AuxLine[2] := MFormat('B (R)', ['PRIMARY KEY', FormattedFieldsLine]);
      mctUnique:
        AuxLine[2] := MFormat('B (R)', ['UNIQUE', FormattedFieldsLine]);
      mctForeign:
        begin
          AuxLine[2] := MFormat('B (R) B D (R)', ['FOREIGN KEY',
            FormattedFieldsLine, 'REFERENCES',
            FAssociatedMasterIndexPtr.RelationName,
            FAssociatedMasterIndexPtr.FormattedFieldsLine]);
          AuxLine[3] := DoWriteFKRule(FUpdateRule, 'ON UPDATE');
          AuxLine[4] := DoWriteFKRule(FDeleteRule, 'ON DELETE');
        end;
      mctNotNull:
        AuxLine[2] := MFormat('D B', [FAssociatedFieldPtr.Name, 'NOT NULL']);
      mctCheck:
        AuxLine[2] := Normal(FAssociatedTriggerPtr.TriggerSource);
      mctNone:
        AuxLine[2] := ''
    end;
    ResLine := AuxLine[Low(AuxLine)];
    for iter := Low(AuxLine) + 1 to High(AuxLine) do
      if AuxLine[iter] <> EmptyStr then
        ResLine := ResLine + LineBreakStr + Indent + AuxLine[iter];
    if FConstraintType in [mctNotNull, mctNone] then
//      ResLine := DebugOutputRaw(ResLine);
      ResLine := '';
    if ResLine <> EmptyStr then
    begin
      ResLine := ResLine + MFormat(';', ['']);
      NewLine := ResLine;
    end;
  end;
  Result := True
end;


// ----------------------------------------------------------
// TIB_DDL_EntWithParams

(*
class procedure TIB_DDL_EntWithParams.BuildSQL2(s: TStrings); //override
begin
  MetadataError('BuildSQL2', ClassName, '', 'did not define it.')
end;
*)

constructor TIB_DDL_EntWithParams.Create(row: TIB_Row); //override;
begin
  inherited Create(row);
  FParams[0] := TIB_DDL_ParamList.Create( TIB_DDL_Extract(
                                      TIB_DDL_EntityList(OwnerEntityList)._CPtr ));
  FParams[0]._SetOwnerEntity(Self);
  _OnFormatterChanged(TIB_DDL_EntListWithParams(FEntityList).FormatterType);
  FAuxOutputStrings := TStringList.Create;
end;

destructor TIB_DDL_EntWithParams.Destroy; //override;
var
  iter: Integer;
begin
  for iter := 0 to 1 do
    FParams[iter].Free;
  FAuxOutputStrings.Free;
  inherited Destroy
end;

procedure TIB_DDL_EntWithParams._OnFormatterChanged(ft: TIB_DDL_FormatterType);
var
  iter: Integer;
begin
  for iter := 0 to 1 do
    if Assigned(FParams[iter]) then
      FParams[iter].FormatterType := ft
end;

procedure TIB_DDL_EntWithParams.ParseParams(R: TIB_Row);
var
  iter: Integer;
begin
{  With FEntityList as TIB_DDL_EntityList do
    if NeedSecondLoad and (GetExtractionState = mxsAfterLoad)
    then Exit;}
  for iter := 0 to 1 do
    if Assigned(FParams[iter]) then
      with FParams[iter] do
        try
          IB_Connection := R.Statement.IB_Connection;
          IB_Transaction := R.Statement.IB_Transaction;
          TIB_DDL_ParamListHack(FParams[iter]).SetEntityClass(
                                                 DoGetEntityClassForList(iter));
          LoadMetadataSingle( FName );
          DoAfterParams( iter );
        except
          on E: Exception do
            AddBug(E.Message);
        end;
end;

procedure TIB_DDL_EntWithParams.DoAfterParams(pnum: Integer); //virtual;
begin
  // Nothing to do at this level
end;

procedure TIB_DDL_EntWithParams.DoWriteEpilog(DoWriteOk: Boolean); //override;
begin
  //With Formatter do
    AddLine(EmptyStr)
end;

function TIB_DDL_EntWithParams.GetParamCount(dimension: Boolean): Integer;
begin
  if Assigned(FParams[Ord(dimension)]) then
    Result := FParams[Ord(Dimension)].GetParamCount
  else
    Result := -1;
end;

function TIB_DDL_EntWithParams.GetParams(dimension: Boolean; i: Integer): TIB_DDL_Param;
begin
  if Assigned(FParams[Ord(dimension)]) then
    Result := FParams[Ord(Dimension)].GetParams(i) as TIB_DDL_Param
  else
    Result := nil;
end;

function TIB_DDL_EntWithParams.GetParamByName(dimension: Boolean;
  const pname: String): TIB_DDL_Param;
begin
  if Assigned(FParams[Ord(dimension)]) then
    Result := FParams[Ord(Dimension)].GetParamByName(pname) as TIB_DDL_Param
  else
    Result := nil;
end;

function TIB_DDL_EntWithParams.LocateParam(dimension: Boolean; const pname: String): TIB_DDL_Param;
begin
  Result := GetParamByName(dimension, pname);
  if not Assigned(Result) then
    LocateEntityError('LocateParam', ClassName,
    {FOwnerName + '.' +} FName + ' -> ' + pname, ' not found')
end;


// ----------------------------------------------------------
// TIB_DDL_UDF

class procedure TIB_DDL_UDF.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$FUNCTION_NAME,');
  s.Add('M.RDB$FUNCTION_TYPE,');  //SMALLINT,
  s.Add('M.RDB$MODULE_NAME,');
  s.Add('M.RDB$ENTRYPOINT,');
  s.Add('M.RDB$RETURN_ARGUMENT,');  //SMALLINT,
  s.Add('M.RDB$SYSTEM_FLAG');
  s.Add('FROM RDB$FUNCTIONS M')
end;

procedure TIB_DDL_UDF.ParseMetadata;
var
  hdr: String;
begin
  With FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FFunctionType := BySQLNo(1).AsSmallInt;
    FModuleName := BySQLNo(2).AsString;
    FEntryPoint := BySQLNo(3).AsString;
    FReturnArgumentPos := BySQLNo(4).AsSmallInt;
    FSystemFlag := BySQLNo(5).AsBoolean
  end;
  TIB_DDL_ParamListHack(FParams[0] as TIB_DDL_ParamList).SpecialTag := FReturnArgumentPos;
  hdr := 'UDF ' + FName;
  {We filter it in SQL.
  if FSystemFlag
  then NewBug := hdr + ' Has system flag set'}
  if Trim(FModuleName) = EmptyStr
  then NewBug := hdr + ' Module name is empty';
  if Trim(FEntryPoint) = EmptyStr
  then NewBug := hdr + ' Entry point is empty'
end;

function TIB_DDL_UDF.Priority: SmallInt;
begin
  Result := 0
end;

function TIB_DDL_UDF.DoGetEntityClassForList(pnum: Integer): TIB_DDL_EntityClass; //override;
begin
  if pnum = 0
  then Result := TIB_DDL_UDF_Param
  else Result := nil
end;

procedure TIB_DDL_UDF.DoAfterParams(pnum: Integer); //override
var
  iter, topc: Integer;
  OutputFound: Boolean;
begin
  if pnum > 0
  then Exit;
  OutputFound := False;
  topc := FParams[pnum].GetParamCount -1;
  for iter := 0 to topc do
    With TIB_DDL_UDF_Param(FParams[pnum].GetParams(iter)) do
    if IsOutputParameter
    then begin
      if (iter < topc)
      then FParams[pnum]._MoveEntity(iter, topc);
      TIB_DDL_ParamListHack(FParams[pnum]).SpecialTag := topc;
      if (((FFieldType in [14, 37, 40]) and (FMechanism > 0))
        or (FFieldType = 261)) and (FReturnArgumentPos > 0)
      then FPositionalReturn := True;
      OutputFound := True;
      break
    end;
  if not OutputFound
  then NewBug := 'UDF ' + FName + ' No output parameter found'
end;

function TIB_DDL_UDF.DoWrite: Boolean;
var
  iter, topc, ioffset: Integer;
begin
  With Formatter do
  begin
    NewLine := MFormat('B D', ['DECLARE EXTERNAL FUNCTION', FName]);
    // Parameters

    FAuxOutputStrings.Clear;
    FParams[0].Write( FAuxOutputStrings );

    topc := FAuxOutputStrings.Count - 1;
    if FParams[0].GetParamCount <= 0 then
      ioffset := -1
    else
    with TIB_DDL_UDF_Param( FParams[0].GetParams(
                            FParams[0].GetParamCount - 1 )) do
      ioffset := Ord(IsOutputParameter);
    for iter := 0 to topc do
      if (iter < topc - ioffset) then
        NewLine := MFormat('>R,', [FAuxOutputStrings[iter]])
      else
      if (iter < topc) then
        NewLine := Indent() + FAuxOutputStrings[iter]
      else
        NewLine := FAuxOutputStrings[iter];
    //NewLine := MFormat('B N', ['RETURNS', 'SomeArg', 'BY VALUE', 'FREE_IT']);
    NewLine := MFormat('B S B S;',
      [ 'ENTRY_POINT', FEntryPoint, 'MODULE_NAME', FModuleName ]);
  end;
  Result := True;
end;
(*
procedure TIB_DDL_UDF.DoWritePreamble;
begin
  With Formatter do
end;

procedure TIB_DDL_UDF.DoWriteEpilog(DoWriteOk: Boolean);
begin
  With Formatter do
end;
*)


// ----------------------------------------------------------
// TIB_DDL_TableView

class procedure TIB_DDL_TableView.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$RELATION_NAME,');
  s.Add('M.RDB$VIEW_BLR,');
  s.Add('M.RDB$VIEW_SOURCE,');
  s.Add('M.RDB$RELATION_ID,');  // smallint
  s.Add('M.RDB$SYSTEM_FLAG,');  // smallint => Boolean
  s.Add('M.RDB$DBKEY_LENGTH,'); // smallint
  s.Add('M.RDB$FORMAT,');       // smallint
  s.Add('M.RDB$FIELD_ID,');     // smallint
  s.Add('M.RDB$SECURITY_CLASS,');
  s.Add('M.RDB$EXTERNAL_FILE,');
  s.Add('M.RDB$OWNER_NAME,');
  s.Add('M.RDB$DEFAULT_CLASS,');
  s.Add('M.RDB$FLAGS,');        // smallint
  s.Add('   (SELECT CAST(COUNT(*) AS INT) FROM RDB$VIEW_RELATIONS V');
  s.Add('   WHERE V.RDB$VIEW_NAME = M.RDB$RELATION_NAME)');
  s.Add('   AS VIEW_COUNT,');
end;

procedure TIB_DDL_TableView.ParseMetadata; //override;
begin
  With FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FViewBlr := BySQLNo(1).AsString;
    FViewSource := Trim(BySQLNo(2).AsString);
    FRelationId := BySQLNo(3).AsSmallInt;
    FSystemFlag := BySQLNo(4).AsBoolean;
    FDbkeyLength := BySQLNo(5).AsSmallInt;
    FFormatVersion := BySQLNo(6).AsSmallInt;
    FFieldCount := BySQLNo(7).AsSmallInt;
    FSecurityClass := BySQLNo(8).AsString;
    FExternalFile := BySQLNo(9).AsString;
    FOwnerName := BySQLNo(10).AsString;
    FDefaultClass := BySQLNo(11).AsString;
    FFlags := BySQLNo(12).AsSmallInt;
    FViewCount := BySQLNo(13).AsInteger
  end
end;


// ----------------------------------------------------------
// TIB_DDL_Table

class procedure TIB_DDL_Table.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  inherited BuildSQL(s,Connection);
  DeleteLastCommaFromStrings(s);
  s.Add('FROM RDB$RELATIONS M');
  s.Add('WHERE M.RDB$VIEW_BLR IS NULL')
end;

constructor TIB_DDL_Table.Create(row: TIB_Row); //override;
begin
  inherited Create(row);
  Include(FEntityAttributes, meaSelfReferencing);
  FParams[1] := TIB_DDL_ParamList.Create( TIB_DDL_Extract(
                                   TIB_DDL_EntityList(OwnerEntityList)._CPtr ));
  FParams[1]._SetOwnerEntity(Self);
  FParams[1].FormatterType := FParams[0].FormatterType;
  //_OnFormatterChanged(TIB_DDL_EntListWithParams(FEntityList).FormatterType)
end;

procedure TIB_DDL_Table.ParseMetadata; // override;
var
  hdr: String;
begin
  inherited ParseMetadata;
{
  With FIB_Row do
  begin
  end
}
  FIsExternal := FExternalFile <> EmptyStr;
  hdr := 'Table ' + FName;
  if FViewCount > 0 then
    NewBug := hdr
           + ' Has not view_blr but it appears in rdb$view_relations as a VIEW';
  if (FOwnerName = EmptyStr) then
    NewBug := hdr + ' Owner name is not specified';
  if FFormatVersion > 200 then
    NewBug := hdr + ' Format version at ' + IntToStr(FFormatVersion);
  if FDbKeyLength <> 8 then
    NewBug := hdr + 'DbKey_Length should be 8 but is ' + IntToStr(FDbKeyLength)
end;

function TIB_DDL_Table.Priority: SmallInt;
begin
  Result := 2
end;

function TIB_DDL_Table.DoGetEntityClassForList( pnum: Integer ): TIB_DDL_EntityClass; //override;
begin
  if pnum = 0 then
    Result := TIB_DDL_Table_Param else
  if pnum = 1 then
    Result := TIB_DDL_Table_Constraint
  else
    Result := nil
end;

procedure TIB_DDL_Table.DoAfterParams(pnum: Integer); //override
//var
//  iter, topc: Integer;
begin
  if pnum = 0 then
  begin
    if FFieldCount <> FParams[0].GetParamCount then
      NewBug := 'Table ' + FName + ' FieldCount is ' + IntToStr(FFieldCount)
                + ' but found fields are ' + IntToStr(FParams[0].GetParamCount)
  end
  else
  begin
    // Try to bind fields to constraints.
    // Done in TIB_DDL_Table_Constraint.BindToField
    // called by TIB_DDL_TableList.CheckParams after all tables are loaded.
  end
end;

function TIB_DDL_Table.DoWrite: Boolean;
var
  iter, topc: Integer;
begin
  Result := False;
  with Formatter do
  begin
    if FIsExternal and ( PassNumber = 2 ) then
      Exit
    else
    if FIsExternal then
    begin
      NewLine := MFormat('B D', ['CREATE TABLE', FName]);
      NewLine := MFormat('B S (', ['EXTERNAL FILE', FExternalFile])
    end
    else
    if PassNumber = 1 then
    begin
      NewLine := MFormat('B D (', ['CREATE TABLE', FName]);
      // Fields.
      FAuxOutputStrings.Clear;
      FParams[0].Write( FAuxOutputStrings );
      topc := FAuxOutputStrings.Count - 1;
      for iter := 0 to topc do
        if (iter < topc) then
          NewLine := MFormat('>R,', [FAuxOutputStrings[iter]])
        else
          NewLine := Indent() + FAuxOutputStrings[iter];
      NewLine := MFormat(');', ['']);
    end;
    // Constraints.
    FAuxOutputStrings.Clear;
    FParams[1].SysWrite( FAuxOutputStrings, PassNumber );
    topc := FAuxOutputStrings.Count - 1;
    for iter := 0 to topc do
      NewLine := FAuxOutputStrings[ iter ];
  end;
  Result := True;
end;
(*
procedure TIB_DDL_Table.DoWritePreamble;
begin
  With Formatter do
end;

procedure TIB_DDL_Table.DoWriteEpilog(DoWriteOk: Boolean);
begin
  With Formatter do
end;
*)


// ----------------------------------------------------------
// TIB_DDL_View

class procedure TIB_DDL_View.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  inherited BuildSQL(s,Connection);
  s.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM RDB$VIEW_RELATIONS V');
  s.Add('   WHERE V.RDB$VIEW_NAME = M.RDB$RELATION_NAME)');
  s.Add('   AS RELATION_COUNT');
  s.Add('FROM RDB$RELATIONS M');
  s.Add('WHERE M.RDB$VIEW_BLR IS NOT NULL')
end;

function TIB_DDL_View.CompleteWithCheckOption;
const
  PossibleSeparators = #13#10#32#9;
var
  ipos, fpos: Integer;
begin
  Result := False;
  if FIsBinaryView
  then Exit;
  // The ugly anomaly exists only with views made with check option.
  fpos := Length(FViewSource);
  while (fpos > 0) and
    (Pos(FViewSource[fpos], PossibleSeparators) > 0) do
    Dec(fpos);
  ipos := fpos - 5;
  if (ipos > 0) and
    (UpperCase(Copy(FViewSource, ipos + 1, 5)) = 'CHECK') and
    (Pos(FViewSource[ipos], PossibleSeparators) > 0)
  then begin
    While (ipos > 0) and
      (Pos(ViewSource[ipos], PossibleSeparators) > 0) do
      Dec(ipos);
    While (ipos > 0) and
      (Pos(FViewSource[ipos], PossibleSeparators + #34#39) = 0) do
      Dec(ipos);
    if (ipos > 0) and
      (UpperCase(Copy(FViewSource, ipos + 1, 4)) = 'WITH')
    then begin
      Delete(FViewSource, ipos + 1, Length(FViewSource));
      FViewSource := FViewSource + 'WITH CHECK OPTION';
      Result := True
    end
  end
end;

procedure TIB_DDL_View.ParseMetadata; // override;
var
  hdr: String;
begin
  inherited ParseMetadata;
  With FIB_Row do
  begin
    FRelationCount := BySQLNo(14).AsSmallInt
  end;
  hdr := 'View ' + FName;
  if FViewCount = 0
  then NewBug := hdr +
    ' Has view_blr but it doesn''t appear in rdb$view_relations as a VIEW';
  FIsBinaryView := FViewSource = EmptyStr;
  if FIsBinaryView
  then NewBug := hdr + ' Has no source code available'
  else begin
    if CompleteWithCheckOption
    then NewBug := hdr + ' "With check" completed to "with check option"'
    {if (UpperCase(Copy(FProcedureSource, 1, 5)) <> 'BEGIN')
    and (UpperCase(Copy(FProcedureSource, 1, 7)) <> 'DECLARE')
  then begin
    FIsFaultyView := True;
    NewBug := hdr + ' Lacks the "BEGIN" keyword. ' +
      'It may be due to database corruption'}
  end;
  if FViewBlr = EmptyStr
  then NewBug := hdr + ' Has no BLR available';
  if (FOwnerName = EmptyStr)
  then NewBug := hdr + ' Owner name is not specified';
  if FFormatVersion > 200
  then NewBug := hdr + ' Format version at ' + IntToStr(FFormatVersion);
  if FDbKeyLength <> 8 * FRelationCount
  then NewBug := hdr +
    'DbKey_Length should be ' + IntToStr(8 * FRelationCount) + ' but is ' +
    IntToStr(FDbKeyLength)
end;

function TIB_DDL_View.Priority: SmallInt;
begin
  Result := 3
end;

function TIB_DDL_View.DoGetEntityClassForList(pnum: Integer): TIB_DDL_EntityClass; //override;
begin
  if pnum = 0
  then Result := TIB_DDL_View_Param
  else Result := nil
end;

procedure TIB_DDL_View.DoAfterParams(pnum: Integer); //override
var
  iter, topc: Integer;
begin
  if pnum = 0
  then begin
    if FFieldCount <> FParams[0].GetParamCount
    then NewBug := 'View ' + FName + ' FieldCount is ' + IntToStr(FFieldCount)
      + ' but found fields are ' + IntToStr(FParams[0].GetParamCount);
    // Determine if we need to show the field names of the view.
    // One not Implicit is enough to force the full list to be displayed.
    topc := FParams[0].GetParamCount -1;
    for iter := 0 to topc do
      With TIB_DDL_View_Param(FParams[0].GetParams(iter)) do
      if not IsImplicitField
      then begin
        FShowFieldNames := True;
        break
      end
  end
  else begin
    // Try to bind fields to constraints.
    // Probably superflous here.
  end
end;

function TIB_DDL_View.DoWrite: Boolean;
var
  iter, topc: Integer;
  AuxLine: String;
begin
  With Formatter do
  begin
    AuxLine := MFormat('B D', ['CREATE VIEW', FName]);
    if FShowFieldNames
    then begin
      // Fields
      FAuxOutputStrings.Clear;
      FParams[0].Write(FAuxOutputStrings);
      topc := FAuxOutputStrings.Count - 1;
      if (topc >= 0)
      then NewLine := MFormat('R (', [AuxLine])
      else NewLine := AuxLine;
      for iter := 0 to topc do
        if (iter < topc)
        then NewLine := MFormat('>R,', [FAuxOutputStrings[iter]])
        else NewLine := MFormat('>R )', [FAuxOutputStrings[iter]]);
      //if (topc >= 0)
      //then NewLine := MFormat(')', [''])
    end
    else NewLine := AuxLine;
    NewLine := Bold('AS');
    NewLine := MFormat('N;', [NormalizeToCurrentLineBreak( FViewSource )]);
  end;
  Result := True
end;
(*
procedure TIB_DDL_View.DoWritePreamble;
begin
  With Formatter do
end;

procedure TIB_DDL_View.DoWriteEpilog(DoWriteOk: Boolean);
begin
  With Formatter do
end;
*)


// ----------------------------------------------------------
// TIB_DDL_StoredProc

class procedure TIB_DDL_Procedure.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$PROCEDURE_NAME,');
  s.Add('M.RDB$PROCEDURE_ID,');              //SMALLINT,
  s.Add('M.RDB$PROCEDURE_INPUTS,');          //SMALLINT,
  s.Add('M.RDB$PROCEDURE_OUTPUTS,');         //SMALLINT,
  s.Add('M.RDB$PROCEDURE_SOURCE,');
  s.Add('M.RDB$PROCEDURE_BLR,');
  s.Add('M.RDB$SECURITY_CLASS,');
  s.Add('M.RDB$OWNER_NAME');
  s.Add('FROM RDB$PROCEDURES M')
end;

constructor TIB_DDL_Procedure.Create(row: TIB_Row);
begin
  inherited Create(row);
  Include(FEntityAttributes, meaSelfReferencing)
end;

procedure TIB_DDL_Procedure.ParseMetadata;
var
  hdr: String;
begin
  With FIB_Row do
  begin
    //FName:= BySQLNo(0).AsString;
    FProcedureId:= BySQLNo(1).AsSmallInt;
    FProcedureInputs := BySQLNo(2).AsSmallInt;
    FProcedureOutputs := BySQLNo(3).AsSmallInt;
    FProcedureSource := Trim(BySQLNo(4).AsString);
    FProcedureBlr := BySQLNo(5).AsString;
    FSecurityClass := BySQLNo(6).AsString;
    FOwnerName := BySQLNo(7).AsString;
  end;
  FIsBinaryProcedure := FProcedureSource = EmptyStr;
  hdr := 'Procedure ' + FName;
  if FIsBinaryProcedure
  then NewBug := hdr + ' Has no source code available'
  else if (UpperCase(Copy(FProcedureSource, 1, 5)) <> 'BEGIN')
    and (UpperCase(Copy(FProcedureSource, 1, 7)) <> 'DECLARE')
  then begin
    FIsFaultyProcedure := True;
    NewBug := hdr + ' Lacks the "BEGIN" keyword. ' +
      'It may be due to database corruption'
  end;
  if FProcedureBlr = EmptyStr
  then NewBug := hdr + ' Has no BLR available';
  if (FOwnerName = EmptyStr)
  then NewBug := hdr + ' Owner name is not specified'
end;

function TIB_DDL_Procedure.Priority: SmallInt;
begin
  Result := 4
end;

function TIB_DDL_Procedure.DoGetEntityClassForList(pnum: Integer): TIB_DDL_EntityClass; //override;
begin
  if pnum = 0 then
    Result := TIB_DDL_Proc_Param
  else
    Result := nil;
end;

procedure TIB_DDL_Procedure.DoAfterParams(pnum: Integer); //override
var
  iter, topc: Integer;
begin
  if pnum > 0 then
    Exit;
  topc := FParams[0].GetParamCount - 1;
  for iter := 0 to topc do
    with TIB_DDL_Proc_Param(FParams[0].GetParams(iter)) do
    if IsInputParameter then
      Inc(FEffectiveInputs)
    else
    if IsOutputParameter then
      Inc(FEffectiveOutputs)
    else
      FIsFaultyProcedure := True;
  if FProcedureInputs <> FEffectiveInputs then
    NewBug := 'Table ' + FName + ' Input ParamCount is ' +
              IntToStr(FProcedureInputs) + ' but found fields are ' +
              IntToStr(FEffectiveInputs);
  if FProcedureOutputs <> FEffectiveOutputs then
    NewBug := 'Table ' + FName + ' Output ParamCount is ' +
              IntToStr(FProcedureOutputs) + ' but found fields are ' +
              IntToStr(FEffectiveOutputs)
end;

function TIB_DDL_Procedure.DoWrite: Boolean;
var
  iter, topc, aux: Integer;
  AuxLine: String;
begin
  if FIsBinaryProcedure then
  begin
    Result := False;
    Exit
  end;
  with Formatter do
  begin
    if FIsFaultyProcedure then
      NewLine := Normal('/* This is a faulty procedure');
    if PassNumber = 1 then  
      AuxLine := MFormat('B D', ['CREATE PROCEDURE', FName])
    else
      AuxLine := MFormat('B D', ['ALTER PROCEDURE', FName]);
    FAuxOutputStrings.Clear;  
    FParams[0].Write( FAuxOutputStrings );
    topc := FAuxOutputStrings.Count - 1;
    if FEffectiveInputs > 0 then
    begin
      NewLine := MFormat('R (', [AuxLine]);
      aux := FEffectiveInputs;
      for iter := 0 to topc do
      begin
        with TIB_DDL_Proc_Param(FParams[0].GetParams(iter)) do
        if IsInputParameter then
        begin
          Dec(aux);
          if aux > 0 then
            Self.NewLine := MFormat('>R,', [FAuxOutputStrings[iter]])
          else
            Self.NewLine := MFormat('>R )', [FAuxOutputStrings[iter]])
        end
        else
        if not IsOutputParameter then
          Self.NewLine := FAuxOutputStrings[iter]
      end;
    end
    else
      NewLine := AuxLine;
    if FEffectiveOutputs > 0 then
    begin
      NewLine := MFormat('B (', ['RETURNS']);
      aux := FEffectiveOutputs;
      for iter := 0 to topc do
      begin
        with TIB_DDL_Proc_Param(FParams[0].GetParams(iter)) do
        if IsOutputParameter then
        begin
          Dec(aux);
          if aux > 0 then
            Self.NewLine := MFormat('>R,', [FAuxOutputStrings[iter]])
          else
            Self.NewLine := MFormat('>R )', [FAuxOutputStrings[iter]])
        end;
      end;
    end;
    NewLine := MFormat( 'B', ['AS'] );
    if PassNumber = 1 then
    begin
      NewLine := MFormat( 'B', ['BEGIN'] );
      NewLine := MFormat( '>B', [ 'EXIT;' ] );
      NewLine := MFormat( 'B;', [ 'END' ] );
    end
    else
    begin
      NewLine := MFormat('N;', [NormalizeToCurrentLineBreak(FProcedureSource)]);
      if IsFaultyProcedure then
        NewLine := Normal('End of faulty procedure */')
    end;
  end;
  Result := True
end;

procedure TIB_DDL_Procedure.DoWritePreamble;
var
  rc: String;
begin
  if FIsBinaryProcedure or FIsFaultyProcedure then Exit;
  with Formatter do
    rc := SetIBTerminator(false);
  if rc <> EmptyStr then
    AddLine(rc)
end;

procedure TIB_DDL_Procedure.DoWriteEpilog(DoWriteOk: Boolean);
var
  rc: String;
begin
  if FIsBinaryProcedure or FIsFaultyProcedure then
  begin
    if FIsFaultyProcedure then
      AddLine(EmptyStr);
    Exit
  end;
  with Formatter do
    rc := ResetIBTerminator(false);
  if rc <> EmptyStr then
    AddLine(rc);
  AddLine(EmptyStr)
end;

end.
