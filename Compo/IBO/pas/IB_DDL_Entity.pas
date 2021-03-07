
{                                                                              }
{ IB_DDL_Entity                                                                }
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
  IB_DDL_Entity;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  IB_Components,

  IB_DDL_Formatter;

type
  EMetadataError = class(Exception);

  // Forward declaration.
  TIB_DDL_Entity = class;

  // This class is intended to allow safe storage of TIB_DDL_Entity objects
  TIB_DDL_StringList = class(TStringList)
  private
    function GetEntity( Index: Integer ): TIB_DDL_Entity;
    procedure PutEntity( Index: Integer; AObject: TIB_DDL_Entity );
  public
    destructor Destroy; override;
    // Add a new pair(entity's name, entity)
    function AddEntity( const S: string; AObject: TIB_DDL_Entity ): Integer;
    // Get the entity at position Index
    property Entities[Index: Integer]: TIB_DDL_Entity read GetEntity
                                                  write PutEntity; default;
  end;

  TIB_DDL_EntityAttribute = ( meaTwoPhases,
                          meaSelfReferencing,
                          meaVoid,
                          meaUnique );
                          
  TIB_DDL_EntityAttributes = set of TIB_DDL_EntityAttribute;

  TIB_DDL_Entity = class
  private
    FDescendants: TIB_DDL_StringList;
    FAncestors: TIB_DDL_StringList;
    function GetPassNumber: integer;
  protected
    FIB_Row: TIB_Row;
    FName: String;
    FEntityAttributes: TIB_DDL_EntityAttributes;
    FEntityList: TComponent;
    procedure AddLine(S: String);
    procedure AddBug(S: String);
    //function GetDatabaseCharsetNormal: String; virtual;
    function GetFormatter: TIB_DDL_FormatterText;
    function DoWrite: Boolean; virtual; abstract;
    procedure DoWritePreamble; virtual;
    procedure DoWriteEpilog(DoWriteOk: Boolean); virtual;
    property NewLine: String write AddLine;
    property NewBug: String write AddBug;
    property Formatter: TIB_DDL_FormatterText read GetFormatter;
  public
    property OwnerEntityList: TComponent read FEntityList;
    // Create the main SQL that queries the system table for this type of entity
    // We need a class procedure to call it before any entity has been created
    // The second line has the column with the name of the entity
    // One column's name will be specified per line in the SQL property
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); virtual;
    class procedure BuildSQL2(s: TStrings; p: TComponent); virtual;
    // The parent list will pass the row while looping in the result set
    constructor Create( ARow: TIB_Row ); virtual;
    destructor Destroy; override;
    // Analyzes the row from the parent list and fills internal values
    // Simple for some objects, nightmare for others.
    procedure ParseMetadata; virtual; abstract;
    procedure ParseMetadata2(R: TIB_Row); virtual;
    function Priority: SmallInt; virtual; abstract;
    function Write: Boolean;
    function IsTopEntity: Boolean;
    // The only general property that's common for all entities
    property Name: String read FName;
    property PassNumber: integer read GetPassNumber;
  end;

  // This is needed to keep a safe reference to the needed entity class
  // in the parent list.
  TIB_DDL_EntityClass = Class of TIB_DDL_Entity;


  // These cannot depend on other things.

  TIB_DDL_Database = class(TIB_DDL_Entity)
  private
    FOwnerName: String;
    FCharacterSetName: String;
    FCharacterSetNormal: String;
    FCharacterSetId: SmallInt;
    FUserExceptionCount: Integer;
    FBaseLevel: Byte;  // byte
    FODSVersion: Word; // word
    FVersionString: String; // string
    FDialect: SmallInt;
  protected
    //function GetDatabaseCharsetNormal: String; override;
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property OwnerName: String read           FOwnerName;
    property CharacterSetName: String read    FCharacterSetName;
    property CharacterSetNormal: String read  FCharacterSetNormal;
    property CharacterSetId: SmallInt read    FCharacterSetId;
    property UserExceptionCount: Integer read FUserExceptionCount;
    property BaseLevel: Byte read             FBaseLevel;
    property ODSVersion: Word read            FODSVersion;
    property Dialect: SmallInt read           FDialect;
  end;

  TIB_DDL_Exception = class(TIB_DDL_Entity)
  private
    FExceptionNumber: Integer;
    FMessage: String;
  protected
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    class procedure BuildSQL2(s: TStrings; p: TComponent); override;
    constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property ExceptionNumber: Integer read FExceptionNumber;
    property Message: String read FMessage;
  end;

  TIB_DDL_BlobFilter = class(TIB_DDL_Entity)
  private
    FModuleName: String;
    FEntryPoint: String;
    FInputSubType: Smallint;
    FOutputSubType: SmallInt;
  protected
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    //constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property ModuleName: String read      FModuleName;
    property EntryPoint: String read      FEntryPoint;
    property InputSubType: Smallint read  FInputSubType;
    property OutputSubType: SmallInt read FOutputSubType;
  end;

  TIB_DDL_GeneratorValue = Extended;

  TIB_DDL_Generator = class(TIB_DDL_Entity)
  private
    FGeneratorName: String;
    FGeneratorId: SmallInt;
    FGeneratorValue: TIB_DDL_GeneratorValue;
    FValueWasRetrieved: Boolean;
  protected
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    // We have ParseMetadata2 but we don't define BuildSQL2.
    //class procedure BuildSQL2(s: TStrings; p: TComponent); override;
    constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property GeneratorName: String read               FGeneratorName;
    property GeneratorId: SmallInt read               FGeneratorId;
    property GeneratorValue: TIB_DDL_GeneratorValue read  FGeneratorValue;
    property ValueWasRetrieved: Boolean read          FValueWasRetrieved;
  end;


  // These can depend on other things.

  TIB_DDL_Domain = class(TIB_DDL_Entity)
  private
    FValidationSource: String;
    FComputedSource: String;
    FDefaultSource: String;
    FFieldLength: SmallInt;
    FFieldScale: SmallInt;
    FFieldType: SmallInt;
    FFieldSubType: SmallInt;
    FSegmentLength: SmallInt;
    FExternalLength: SmallInt;
    FExternalScale: SmallInt;
    FExternalType: SmallInt;
    FDimensions: SmallInt;
    FIsMandatory: Boolean; //FNullFlag: SmallInt;
    FCharacterLength: SmallInt;
    FCollationId: SmallInt;
    FCharacterSetId: SmallInt;
    FFieldPrecision: SmallInt;
    FTypeName: String;
    FSubTypeName: String;
    FCharacterSetName: String;
    FCollationName: String;
    FIsNumericOrDecimal: Boolean;
    FIsImplicitDomain: Boolean;
    FBytesPerCharacter: SmallInt;
    FDimensionsLine: String;
    FIsArrayBased: Boolean;
    FIsExternalDomain: Boolean;
    FIsComputed: Boolean;
  protected
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    class procedure BuildSQL2(s: TStrings; p: TComponent); override;
    constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property ValidationSource: String read      FValidationSource;
    property ComputedSource: String read        FComputedSource;
    property DefaultSource: String read         FDefaultSource;
    property FieldLength: SmallInt read         FFieldLength;
    property FieldScale: SmallInt read          FFieldScale;
    property FieldType: SmallInt read           FFieldType;
    property FieldSubType: SmallInt read        FFieldSubType;
    property SegmentLength: SmallInt read       FSegmentLength;
    property ExternalLength: SmallInt read      FExternalLength;
    property ExternalScale: SmallInt read       FExternalScale;
    property ExternalType: SmallInt read        FExternalType;
    property Dimensions: SmallInt read          FDimensions;
    property IsMandatory: Boolean read          FIsMandatory;
    property CharacterLength: SmallInt read     FCharacterLength;
    property CollationId: SmallInt read         FCollationId;
    property CharacterSetId: SmallInt read      FCharacterSetId;
    property FieldPrecision: SmallInt read      FFieldPrecision;
    property TypeName: String read              FTypeName;
    property SubTypeName: String read           FSubTypeName;
    property CharacterSetName: String read      FCharacterSetName;
    property CollationName: String read         FCollationName;
    property IsNumericOrDecimal: Boolean read   FIsNumericOrDecimal;
    property IsImplicitDomain: Boolean read     FIsImplicitDomain;
    property BytesPerCharacter: SmallInt read   FBytesPerCharacter;
    property DimensionsLine: String read        FDimensionsLine;
    property IsArrayBased: Boolean read         FIsArrayBased;
    property IsExternalDomain: Boolean read     FIsExternalDomain;
    property IsComputed: Boolean read           FIsComputed;
    function DoWriteTypeCharset: String;
    function DoWriteComputed( ForceOutput: Boolean ): String;
    function DoWriteDefault(newDefault: String): String;
    function DoWriteMandatory(newMandatory: Boolean): String;
    function DoWriteConstraint( ForceOutput: boolean ): String;
    function DoWriteCollation(newCollationId: SmallInt;
      newCollationName: String): String;
  end;

  TIB_DDL_Index = class(TIB_DDL_Entity)
  private
    FIndexName: String;
    FRelationName: String;
    FIndexId: SmallInt;
    FIsUnique: Boolean; // FUniqueFlag: SmallInt;
    FSegmentCount: SmallInt;
    FIndexInactive: Boolean; //FIndexInactive: SmallInt;
    FIsAscending: Boolean; //FIndexType: SmallInt;
    FForeignKey: String;
    FIndexConstraintCount: SmallInt;
    FIndexFKeyCount: SmallInt;
    FIsImplicitIndex: Boolean;
    FFieldsList: TStringList;
    function GetFieldsLine: String;
    function GetFormattedFieldsLine: String;
  protected
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    class procedure BuildSQL2(s: TStrings; p: TComponent); override;
    constructor Create(row: TIB_Row); override;
    destructor Destroy; override;
    procedure ParseMetadata; override;
    procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property IndexName: String read               FIndexName;
    property RelationName: String read            FRelationName;
    property IndexId: SmallInt read               FIndexId;
    property IsUnique: Boolean read               FIsUnique;
    property SegmentCount: SmallInt read          FSegmentCount;
    property IndexInactive: Boolean read          FIndexInactive;
    property IsAscending: Boolean read            FIsAscending;
    property ForeignKey: String read              FForeignKey;
    property IndexConstraintCount: SmallInt read  FIndexConstraintCount;
    property IndexFKeyCount: SmallInt read        FIndexFKeyCount;
    property IsImplicitIndex: Boolean read        FIsImplicitIndex;
    property FieldsLine: String read              GetFieldsLine;
    property FormattedFieldsLine: String read     GetFormattedFieldsLine;
    procedure GetFieldsList(target: TStrings);
  end;

  TIB_DDL_Trigger = class(TIB_DDL_Entity)
  private
    FRelationName: String;
    FTriggerSequence: SmallInt;
    FTriggerType: SmallInt;
    FTriggerSource: String;
    FTriggerBlr: String;
    FTriggerInactive: Boolean;
    FTriggerUsageCount: SmallInt;
    FTriggerFullUsageCount: SmallInt;
    FTriggerCheckCount: SmallInt;
    FIsForView: Boolean;
    FIsImplicitTrigger: Boolean;
    FIsBinaryTrigger: Boolean;
    FIsFaultyTrigger: Boolean;
    procedure WipeOutAS;
  protected
    function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    //constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property RelationName: String read            FRelationName;
    property TriggerSequence: SmallInt read       FTriggerSequence;
    property TriggerType: SmallInt read           FTriggerType;
    property TriggerSource: String read           FTriggerSource;
    property TriggerBlr: String read              FTriggerBlr;
    property TriggerInactive: Boolean read        FTriggerInactive;
    property TriggerUsageCount: SmallInt read     FTriggerUsageCount;
    property TriggerFullUsageCount: SmallInt read FTriggerFullUsageCount;
    property TriggerCheckCount: SmallInt read     FTriggerCheckCount;
    property IsForView: Boolean read              FIsForView;
    property IsImplicitTrigger: Boolean read      FIsImplicitTrigger;
    property IsBinaryTrigger: Boolean read        FIsBinaryTrigger;
    property IsFaultyTrigger: Boolean read        FIsFaultyTrigger;
  end;

  TIB_DDL_Role = class(TIB_DDL_Entity)
  private
    FOwnerName: String;
  protected
    function DoWrite: Boolean; override;
    //procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    //constructor Create(row: TIB_Row); override;
    procedure ParseMetadata; override;
    //procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property OwnerName: String read FOwnerName;
  end;

  TIB_DDL_Permission = class(TIB_DDL_Entity)
  private
    //FGrantor: String; => FName
    FUserName: String;
    FUserType: SmallInt;
    FObjectName: String; // why FRelationName if it can contain a proc'name?
    FObjectType: SmallInt;
    FGrantOrAdminOption: Boolean;
    //FPrivilege: String; => managed as list
    //FFieldName: String; => managed as list
    FFieldsList: array [-1..1] of TStringList;
    FPartialGrantOrAdminOption: SmallInt;
    FPartialGrantOrAdminUpdate: SmallInt;
    FPartialGrantOrAdminReferences: SmallInt;
    FSingleUpdate, FSingleReferences: Boolean;
    function GetFieldsLine(dim: Integer): String;
    function GetFormattedFieldsLine(dim: Integer): String;
    function GetFormattedFieldsLineGrAdOpt(dim: Integer; GrAdOpt: Boolean):
      String;
    function CheckPartialRights(listIdx: Integer): Integer;
    procedure OrderPrivileges(p: Char; NewIdx: SmallInt);
    function GetShowSysdbaRights: Boolean;
  protected
    function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog(DoWriteOk: Boolean); override;
  public
    class procedure BuildSQL(s: TStrings;Connection: TIB_Connection); override;
    class procedure BuildSQL2(s: TStrings; p: TComponent); override;
    constructor Create(row: TIB_Row); override;
    destructor Destroy; override;
    procedure ParseMetadata; override;
    procedure ParseMetadata2(R: TIB_Row); override;
    function Priority: SmallInt; override;
    property UserName: String read                    FUserName;
    property UserType: SmallInt read                  FUserType;
    property ObjectName: String read                  FObjectName;
    property ObjectType: SmallInt read                FObjectType;
    property PrivilegesLine: String index -1 read     GetFieldsLine;
    property FormattedPrivilegesLine: String index -1 read GetFormattedFieldsLine;
    procedure GetPrivilegesList(target: TStrings);
    property GrantOrAdminOption: Boolean read         FGrantOrAdminOption;
    property UpdateLine: String index 0 read          GetFieldsLine;
    property FormattedUpdateLine: String index 0 read GetFormattedFieldsLine;
    property ReferencesLine: String index 1 read      GetFieldsLine;
    property FormattedReferencesLine: String index 1
                                                 read GetFormattedFieldsLine;
    procedure GetFieldsList(idx: Boolean; target: TStrings);
    property PartialGrantOrAdminOption: SmallInt read FPartialGrantOrAdminOption;
    property PartialGrantOrAdminUpdate: SmallInt read FPartialGrantOrAdminUpdate;
    property PartialGrantOrAdminReferences: SmallInt
                                            read FPartialGrantOrAdminReferences;
    function DoWritePrivilege(GrAdOpt: Boolean): String;
    function DoWriteUser: String;
    function DoWriteGrantAdmin(GrAdOpt: Boolean): string;
  end;

  procedure MetadataError(const fname, clname, obname, msg: String);


implementation

uses
  IB_Utils,

  IB_DDL_EntityList,
  IB_DDL_Utility;


procedure MetadataError(const fname, clname, obname, msg: String);
begin
  raise EMetadataError.CreateFmt('%s - %s(%s) %s.',
    [fname, clname, obname, msg])
end;


// ----------------------------------------------------------
// TIB_DDL_StringList

function TIB_DDL_StringList.GetEntity(Index: Integer): TIB_DDL_Entity;
begin
  Result := inherited GetObject(Index) as TIB_DDL_Entity
end;

procedure TIB_DDL_StringList.PutEntity(Index: Integer; AObject: TIB_DDL_Entity);
begin
  inherited PutObject(Index, AObject)
end;

destructor TIB_DDL_StringList.Destroy;
var
  iter: Integer;
begin
  for iter := GetCount - 1 downto 0 do
  begin
    GetObject(iter).Free;
    PutObject(iter, nil)
  end;
  inherited Destroy
end;

function TIB_DDL_StringList.AddEntity(const S: string; AObject: TIB_DDL_Entity): Integer;
begin
  Result := inherited AddObject(S, AObject)
end;


// ----------------------------------------------------------
// TIB_DDL_Entity

class procedure TIB_DDL_Entity.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  MetadataError('BuildSQL', ClassName, '', 'did not define it')
end;

class procedure TIB_DDL_Entity.BuildSQL2(s: TStrings; p: TComponent);
begin
  MetadataError('BuildSQL2', ClassName, '', 'did not define it')
end;

constructor TIB_DDL_Entity.Create( ARow: TIB_Row );
begin
  inherited Create;
  FIB_Row := ARow;
  if not Assigned( ARow ) then
    MetadataError('Create', ClassName, '', 'Row cannot be nil');
  FEntityList := ARow.Statement.Owner as TIB_DDL_EntityList;
  if not Assigned(FEntityList) then
    MetadataError('Create', ClassName, '', 'EntityList cannot be nil');
  FDescendants := TIB_DDL_StringList.Create;
  FAncestors := TIB_DDL_StringList.Create;
  // By convention, the first field will be the entity's name
  FName := ARow[0].AsString;
  FEntityAttributes := []
end;

destructor TIB_DDL_Entity.Destroy;
begin
  FIB_Row := nil;
  FDescendants.Free;
  FAncestors.Free;
  inherited Destroy
end;

procedure TIB_DDL_Entity.ParseMetadata2(R: TIB_Row); //virtual;
begin
  MetadataError('ParseMetadata2', ClassName, '', 'did not define it')
end;

function TIB_DDL_Entity.GetPassNumber: integer;
begin
  Result := TIB_DDL_EntityList( OwnerEntityList ).PassNumber; 
end;

procedure TIB_DDL_Entity.AddLine(S: String);
begin
  TIB_DDL_EntityListHack(FEntityList).NewLine := S
end;

procedure TIB_DDL_Entity.AddBug(S: String);
begin
  TIB_DDL_EntityListHack(FEntityList).NewBug := S
end;
(*
function TIB_DDL_Entity.GetDatabaseCharsetNormal: String; //virtual;
begin
  With TIB_DDL_EntityList(FEntityList) do
    if Assigned(_DatabaseList)
    then Result := _DatabaseList.GetCharsetNormal
    else Result := 'NONE'
end;
*)
function TIB_DDL_Entity.GetFormatter: TIB_DDL_FormatterText;
begin
  Result := TIB_DDL_EntityListHack(FEntityList).Formatter
end;

//function TIB_DDL_Entity.DoWrite: Boolean; virtual; abstract;

function TIB_DDL_Entity.Write: Boolean;
begin
  DoWritePreamble;
  Result := DoWrite;
  DoWriteEpilog( Result )
end;

procedure TIB_DDL_Entity.DoWritePreamble;
begin
  // Nothing to do at this level
end;

procedure TIB_DDL_Entity.DoWriteEpilog(DoWriteOk: Boolean);
begin
  // Nothing to do at this level
end;

function TIB_DDL_Entity.IsTopEntity: Boolean;
begin
  Result := (Priority = 0) or (FAncestors.Count = 0);
end;


// ----------------------------------------------------------
// TIB_DDL_Database

class procedure TIB_DDL_Database.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('R.RDB$OWNER_NAME,');
  s.Add('D.RDB$CHARACTER_SET_NAME,');
  s.Add('CS.RDB$CHARACTER_SET_NAME AS CHARSET_NORMAL,');
  s.Add('CS.RDB$CHARACTER_SET_ID,');
  s.Add('   (SELECT CAST(COUNT(*) AS INTEGER) FROM RDB$EXCEPTIONS E');
  s.Add('   WHERE E.RDB$SYSTEM_FLAG IS NULL OR E.RDB$SYSTEM_FLAG = 0)');
  s.Add('   AS USER_EXCEPTION_COUNT');
  s.Add('FROM RDB$RELATIONS R JOIN RDB$DATABASE D');
  s.Add('ON R.RDB$RELATION_NAME = ' + QuotedStr('RDB$DATABASE'));
  s.Add('LEFT JOIN (RDB$TYPES T JOIN RDB$CHARACTER_SETS CS');
  s.Add('   ON CS.RDB$CHARACTER_SET_ID = T.RDB$TYPE)');
  s.Add('ON T.RDB$TYPE_NAME = D.RDB$CHARACTER_SET_NAME');
  s.Add('AND RDB$FIELD_NAME = ' + QuotedStr('RDB$CHARACTER_SET_NAME'))
end;

constructor TIB_DDL_Database.Create(row: TIB_Row);
begin
  inherited Create(row);
  Include(FEntityAttributes, meaUnique)
end;

procedure TIB_DDL_Database.ParseMetadata;
begin
  with FIB_Row do
  begin
    // Beware: name is not in the field list!
    //FName := BySQLNo(0).AsString;
    FName := FIB_Row.Statement.IB_Connection.Path;
    FOwnerName := BySQLNo(0).AsString;
    FCharacterSetName := BySQLNo(1).AsString;
    FCharacterSetNormal := BySQLNo(2).AsString;
    FCharacterSetId := BySQLNo(3).AsSmallInt;
    FUserExceptionCount := BySQLNo(4).AsInteger
  end;
  if FCharacterSetName = EmptyStr then
  begin
    FCharacterSetName := 'NONE';
    FCharacterSetNormal := 'NONE'
  end
  else
  if FCharacterSetNormal = EmptyStr then
  begin
    // Call not needed. Already calculated in the SQL statement.
    //FCharacterSetName := NormalizedCharset(FCharacterSetName)
    NewBug := 'Database ' + FName + ' Character set ' + FCharacterSetName
      + ' was not found to get its canonic name';
    FCharacterSetNormal := FCharacterSetName;
  end;
  with FIB_Row.Statement.IB_Connection.Characteristics do
  begin
    FBaseLevel := dbBase_Level;  // byte
    FODSVersion := dbODS_Version; // word
    FVersionString := dbVersion // string
  end;
  if (FBaseLevel >= 6) or
     (Copy(FVersionString, 1, 2) = 'FB') or
     (FDialect > 1) then
    FDialect := FIB_Row.Statement.SQLDialect
  else
    FDialect := -1
end;

function TIB_DDL_Database.Priority: SmallInt;
begin
  Result := 0
end;
(*
function TIB_DDL_Database.GetDatabaseCharsetNormal: String; //override;
begin
  // Just to avoid recursion.
  Result := FCharacterSetNormal
end;
*)
function TIB_DDL_Database.DoWrite: Boolean;
begin
  with Formatter do
  begin
    //NewLine := DebugOutput('This is "debug" testing');
    NewLine := IBComment( 'Connect using owner = ' + FOwnerName );
    NewLine := IBComment( 'Using server ' + FVersionString );
    if FDialect > 0 then
      NewLine := MFormat('B N;', ['SET SQL DIALECT ', IntToStr(FDialect)]);
    NewLine := MFormat('B N;', ['SET AUTODDL ', 'ON']);
    NewLine := MFormat('B S B N;', ['CREATE DATABASE', FName,
      'DEFAULT CHARACTER SET', FCharacterSetNormal])
  end;
  Result := True
end;
(*
procedure TIB_DDL_Database.DoWritePreamble;
begin
  With Formatter do
end;

procedure TIB_DDL_Database.DoWriteEpilog(DoWriteOk: Boolean);
begin
  With Formatter do
end;
*)

// ----------------------------------------------------------
// TIB_DDL_Exception

class procedure TIB_DDL_Exception.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$EXCEPTION_NAME,');
  s.Add('M.RDB$EXCEPTION_NUMBER,');
  s.Add('M.RDB$MESSAGE');
  s.Add('FROM RDB$EXCEPTIONS M')
end;

class procedure TIB_DDL_Exception.BuildSQL2(s: TStrings; p: TComponent); //override;
begin
  s.Add('SELECT');
  s.Add('M.RDB$EXCEPTION_NAME,');
  s.Add('M.RDB$EXCEPTION_NUMBER');
  s.Add('FROM RDB$EXCEPTIONS M')
end;

constructor TIB_DDL_Exception.Create(row: TIB_Row);
begin
  inherited Create(row);
  Include( FEntityAttributes, meaTwoPhases )
end;

procedure TIB_DDL_Exception.ParseMetadata;
var
  hdr: String;
begin
  with FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FExceptionNumber := BySQLNo(1).AsInteger;
    FMessage := BySQLNo(2).AsString
  end;
  hdr := 'Exception ' + FName;
  if FExceptionNumber < 0 then
    NewBug := hdr + ' Exception number should be >=0 but is ' +
              IntToStr( FExceptionNumber );
  if Trim(FMessage) = EmptyStr then
    NewBug := hdr + ' Exception message is empty';
  with (FEntityList as TIB_DDL_ExceptionList) do
    if FixFirstExceptionNumber then
      _SetMinExceptionNumberValue( FExceptionNumber )
end;

procedure TIB_DDL_Exception.ParseMetadata2(R: TIB_Row); //override;
begin
  if FExceptionNumber <> R.BySQLNo(1).AsInteger
  then MetadataError('ParseMetadata2', ClassName, FName,
    'Exception numbers do not match');
  FName := R.BySQLNo(0).AsString; // Get name again but with the correct charset
  with R.Statement as TIB_Cursor do
    if not Eof then
      APINext
end;

function TIB_DDL_Exception.Priority: SmallInt;
begin
  Result := 0
end;

function TIB_DDL_Exception.DoWrite: Boolean;
begin
  with Formatter do
  begin
    NewLine := MFormat( 'B D', ['CREATE EXCEPTION', FName] );
    NewLine := MFormat( '> S;', [FMessage] );
  end;
  Result := True
end;
(*
procedure TIB_DDL_Exception.DoWritePreamble;
begin
  With Formatter do
end;

procedure TIB_DDL_Exception.DoWriteEpilog(DoWriteOk: Boolean);
begin
  With Formatter do
end;
*)

// ----------------------------------------------------------
// TIB_DDL_BlobFilter

class procedure TIB_DDL_BlobFilter.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$FUNCTION_NAME,');
  s.Add('M.RDB$MODULE_NAME,');
  s.Add('M.RDB$ENTRYPOINT,');
  s.Add('M.RDB$INPUT_SUB_TYPE,');  //SMALLINT,
  s.Add('M.RDB$OUTPUT_SUB_TYPE');  //SMALLINT,
  s.Add('FROM RDB$FILTERS M')
end;

procedure TIB_DDL_BlobFilter.ParseMetadata;
var
  hdr: String;
begin
  with FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FModuleName := BySQLNo(1).AsString;
    FEntryPoint := BySQLNo(2).AsString;
    FInputSubType := BySQLNo(3).AsSmallInt;
    FOutputSubType := BySQLNo(4).AsSmallInt
  end;
  hdr := 'Blob Filter ' + FName;
  if Trim(FModuleName) = EmptyStr then
    NewBug := hdr + ' Module name is empty';
  if Trim(FEntryPoint) = EmptyStr then
    NewBug := hdr + ' Entry point is empty'
end;

function TIB_DDL_BlobFilter.Priority: SmallInt;
begin
  Result := 0
end;

function TIB_DDL_BlobFilter.DoWrite: Boolean;
begin
  with Formatter do
    Newline := MFormat('B D B N B N B S B S;', ['DECLARE FILTER', FName,
      'INPUT_TYPE', IntToStr(FInputSubType),
      'OUTPUT_TYPE', IntToStr(FOutputSubType),
      'ENTRY_POINT', FEntryPoint,
      'MODULE_NAME', FModuleName]);
  Result := True;
end;
(*
procedure TIB_DDL_BlobFilter.DoWritePreamble;
begin
  With Formatter do
end;
*)
procedure TIB_DDL_BlobFilter.DoWriteEpilog(DoWriteOk: Boolean);
begin
  //With Formatter do
    AddLine(EmptyStr)
end;


// ----------------------------------------------------------
// TIB_DDL_Generator

class procedure TIB_DDL_Generator.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$GENERATOR_NAME,');
  s.Add('M.RDB$GENERATOR_ID');  //SMALLINT
  s.Add('FROM RDB$GENERATORS M')
end;

// We have ParseMetadata2 but we don't define BuildSQL2.

constructor TIB_DDL_Generator.Create(row: TIB_Row);
begin
  inherited Create( row );
  Include( FEntityAttributes, meaTwoPhases )
end;

procedure TIB_DDL_Generator.ParseMetadata;
var
  hdr: String;
begin
  with FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FGeneratorId := BySQLNo(1).AsSmallInt;
  end;
  hdr := 'Generator ' + FName;
  if FGeneratorId < 0 then
    NewBug := hdr + ' Generator Id should be >=0 but is ' +
              IntToStr(FGeneratorId)
end;

// We have ParseMetadata2 but we don't define BuildSQL2.
procedure TIB_DDL_Generator.ParseMetadata2(R: TIB_Row); //override;
begin
  if FName <> R.BySQLNo(0).AsString then
    MetadataError( 'ParseMetadata2',
                   ClassName,
                   FName,
                   'Generator names do not match' );
  FGeneratorValue := R.BySQLNo(1).AsExtended;
  FValueWasRetrieved := True;
end;

function TIB_DDL_Generator.Priority: SmallInt;
begin
  Result := 0
end;

function TIB_DDL_Generator.DoWrite: Boolean;
begin
  With Formatter do
  begin
    NewLine := MFormat('B D;', ['CREATE GENERATOR', FName]);
    if FValueWasRetrieved then
      NewLine := MFormat( 'B D B N;', ['SET GENERATOR', FName,
                          'TO', ExtendedAsNumeric19(FGeneratorValue)])
  end;
  Result := True
end;
(*
procedure TIB_DDL_Generator.DoWritePreamble;
begin
  With Formatter do
end;

procedure TIB_DDL_Generator.DoWriteEpilog(DoWriteOk: Boolean);
begin
  With Formatter do
end;
*)

// ----------------------------------------------------------
// TIB_DDL_Domain

class procedure TIB_DDL_Domain.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$FIELD_NAME,');
  s.Add('M.RDB$VALIDATION_SOURCE,'); //The manual is wrong, this field is used!
  s.Add('M.RDB$COMPUTED_SOURCE,');
  s.Add('M.RDB$DEFAULT_SOURCE,');
  s.Add('M.RDB$FIELD_LENGTH,');	//SMALLINT,
  s.Add('M.RDB$FIELD_SCALE,');	//SMALLINT,
  s.Add('M.RDB$FIELD_TYPE,');	//SMALLINT,
  s.Add('M.RDB$FIELD_SUB_TYPE,');	//SMALLINT,
  s.Add('M.RDB$SEGMENT_LENGTH,');	//SMALLINT,
  s.Add('M.RDB$EXTERNAL_LENGTH,');	//SMALLINT,
  s.Add('M.RDB$EXTERNAL_SCALE,');	//SMALLINT,
  s.Add('M.RDB$EXTERNAL_TYPE,');	//SMALLINT,
  s.Add('M.RDB$DIMENSIONS,');	//SMALLINT,
  s.Add('M.RDB$NULL_FLAG,');	//SMALLINT,
  s.Add('M.RDB$CHARACTER_LENGTH,');	//SMALLINT,
  s.Add('M.RDB$COLLATION_ID,');	//SMALLINT,
  s.Add('M.RDB$CHARACTER_SET_ID,');	//SMALLINT,
  if Connection.Characteristics.dbODS_Version >= 10 then
  s.Add('M.RDB$FIELD_PRECISION,')            //SMALLINT,
  else
  s.Add('null as RDB$FIELD_PRECISION,');     //SMALLINT,
  s.Add('T.RDB$TYPE_NAME,');
  s.Add('   (SELECT T2.RDB$TYPE_NAME FROM RDB$TYPES T2');
  s.Add('   WHERE M.RDB$FIELD_SUB_TYPE = T2.RDB$TYPE');
  s.Add('   AND T2.RDB$FIELD_NAME = ' + QuotedStr('RDB$FIELD_SUB_TYPE') + ')');
  s.Add('   AS RDB$SUB_TYPE_NAME,');
  s.Add('CS.RDB$CHARACTER_SET_NAME,');
  s.Add('CS.RDB$BYTES_PER_CHARACTER,');
  s.Add('   (SELECT C.RDB$COLLATION_NAME FROM RDB$COLLATIONS C');
  s.Add('   WHERE M.RDB$COLLATION_ID = C.RDB$COLLATION_ID');
  s.Add('   AND M.RDB$CHARACTER_SET_ID = C.RDB$CHARACTER_SET_ID)');
  s.Add('   AS RDB$COLLATION_NAME,');
  s.Add('CS.RDB$DEFAULT_COLLATE_NAME');
  // Thanks Borland for not including type=16 INT64 in system tables of IB6.
  // You make life harder and force the use of a LEFT JOIN.
  s.Add('FROM RDB$FIELDS M LEFT JOIN RDB$TYPES T');
  s.Add('ON M.RDB$FIELD_TYPE = T.RDB$TYPE');
  s.Add('AND T.RDB$FIELD_NAME = ' + QuotedStr('RDB$FIELD_TYPE'));
  s.Add('LEFT JOIN RDB$CHARACTER_SETS CS');
  s.Add('ON M.RDB$CHARACTER_SET_ID = CS.RDB$CHARACTER_SET_ID')
end;

class procedure TIB_DDL_Domain.BuildSQL2(s: TStrings; p: TComponent); //override;
begin
  s.Add('SELECT');
  s.Add('M.RDB$FIELD_NAME,');
  s.Add('M.RDB$DIMENSION,');
  s.Add('M.RDB$LOWER_BOUND,');
  s.Add('M.RDB$UPPER_BOUND');
  s.Add('FROM RDB$FIELD_DIMENSIONS M');
  s.Add('ORDER BY M.RDB$FIELD_NAME, M.RDB$DIMENSION')
end;

constructor TIB_DDL_Domain.Create(row: TIB_Row);
begin
  inherited Create(row);
  Include(FEntityAttributes, meaTwoPhases)
end;

procedure TIB_DDL_Domain.ParseMetadata;
var
  hdr: String;
  charsetWasNull: Boolean;
  defCollateName: String;
begin
  With FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FValidationSource := BySQLNo(1).AsString;
    FComputedSource := Trim(BySQLNo(2).AsString);
    FIsComputed := BySQLNo(2).IsNotNull;
    FDefaultSource := BySQLNo(3).AsString;
    FFieldLength := BySQLNo(4).AsSmallInt;
    FFieldScale := BySQLNo(5).AsSmallInt;
    FFieldType := BySQLNo(6).AsSmallInt;
    FFieldSubType := BySQLNo(7).AsSmallInt;
    FSegmentLength := BySQLNo(8).AsSmallInt;
    FExternalLength := BySQLNo(9).AsSmallInt;
    FExternalScale := BySQLNo(10).AsSmallInt;
    FExternalType := BySQLNo(11).AsSmallInt;
    FIsExternalDomain :=
      BySQLNo(9).IsNotNull or BySQLNo(10).IsNotNull or BySQLNo(11).IsNotNull;
    // This is a hack due to IB's weird external domain behavior.
    if FIsExternalDomain then
    begin
      if BySQLNo(4).IsNull and BySQLNo(9).IsNotNull // FieldLength
      then FFieldLength := FExternalLength;
      if BySQLNo(5).IsNull and BySQLNo(10).IsNotNull // FieldScale
      then FFieldScale := FExternalScale;
      if BySQLNo(6).IsNull and BySQLNo(11).IsNotNull // FieldType
      then FFieldType := FExternalType
    end;
    // End hack
    FDimensions := BySQLNo(12).AsSmallInt;
    FIsArrayBased := FDimensions > 0;
    FIsMandatory := BySQLNo(13).AsBoolean;
    FCharacterLength := BySQLNo(14).AsSmallInt;
    FCollationId := BySQLNo(15).AsSmallInt;
    FCharacterSetId := BySQLNo(16).AsSmallInt;
    charsetWasNull := BySQLNo(16).IsNull;
    FFieldPrecision := BySQLNo(17).AsSmallInt;
    FTypeName := IB_DDL_Utility.FieldTypeAsChar( FFieldType,
                                                 BySQLNo(18).AsString );
    FSubTypeName := IB_DDL_Utility.AdjustField(
      FFieldType, FFieldSubType,
      FFieldPrecision, FTypeName,
      BySQLNo(19).AsString, FFieldScale, FIsNumericOrDecimal,
      True);
    if FFieldType-14 in [14-14, 37-14, 40-14, 261-14] then
    begin
      FCharacterSetName := BySQLNo(20).AsString;
      if FFieldType <> 261 then
        FBytesPerCharacter := BySQLNo(21).AsSmallInt;
      if FFieldType in [14, 37, 40] then
      begin
        FCollationName := BySQLNo(22).AsString;
        defCollateName := BySQLNo(23).AsString;
      end;
    end;
  end;
  if (Copy(FName, 1, 4) = 'RDB$') and
     (Length(FName) > 4) and (FName[5] in ['1'..'9']) and
     (StrToIntDef(Copy(FName, 5, 31), 0) > 0) then
    FIsImplicitDomain := True;
  hdr := 'Domain ' + FName;
  if not FIsImplicitDomain then
  begin
    if (Copy(FName, 1, 4) = 'RDB$') then
      NewBug :=  hdr + ' Not a typical user defined domain';
    if FIsExternalDomain then
      NewBug := hdr + ' External domain only can be implicit'
  end;
  if (FFieldType = 16) and (FFieldSubType = 0) and (FTypeName[1] = '_') then
    NewBug := hdr + ' Type 16 can be only NUMERIC or DECIMAL';
  if FFieldType-14 in [14-14, 37-14, 40-14, 261-14] then
  begin
    if charsetWasNull then
    begin
      FCharacterSetName := 'NONE';
      FBytesPerCharacter := 1;
      NewBug := hdr + ' Charset Id was NULL, assuming NONE'
    end
    else
    if FCharacterSetName = EmptyStr then
    begin
      FCharacterSetName := 'NONE';
      NewBug := hdr + ' Missing name for charset ID ' +
        IntToStr(FCharacterSetId) + ' Assuming NONE'
    end
  end;
  if FFieldType in [14, 37, 40] then
  begin
    if FCharacterLength = 0 then
    try
      FCharacterLength := FFieldLength div FBytesPerCharacter
    except
      NewBug := hdr +
        ' BytesPerCharacter was zero in charset name ' + FCharacterSetName
    end;
    if ((FCharacterLength = 0) or (FFieldLength mod FCharacterLength <> 0))
    then NewBug := hdr + ' FieldLength ' + IntToStr(FFieldLength)
      + ' should be multiple of CharacterLength ' + IntToStr(FCharacterLength)
      + ' in charset name ' + FCharacterSetName;
    if FCollationId < 0
    then NewBug := hdr +
      ' Collation Id cannot be < 0 but is ' + IntToStr(FCollationId)
    else
    if (FCollationName = EmptyStr) and not FIsImplicitDomain then
    begin
      if charsetWasNull then
        FCollationName := 'NONE'
      else
      if (defCollateName = EmptyStr) then
        FCollationName := FCharacterSetName
      else
        FCollationName := defCollateName;
      NewBug := hdr + ' Collation Id was NULL, assuming ' + FCollationName;
    end;
  end;
  if not (FFieldType in [14, 11, 27, 10, 16, 8, 9, 7, 12, 13, 35, 37, 40])
    and (FFieldType <> 261)
  then NewBug := hdr + ' Unknown FieldType ' + IntToStr(FFieldType);
  if FFieldType = 40
  then NewBug := hdr + ' FieldType CSTRING is not accepted by DSQL'
  else if FFieldType = 9
  then NewBug := hdr + ' FieldType QUAD is not accepted by DSQL';
  if FValidationSource <> EmptyStr then
    if Copy(Trim(UpperCase(FValidationSource)), 1, 5) <> 'CHECK'
    then NewBug := hdr + ' Suspicious check: ' + FValidationSource
    else
    begin
      FValidationSource :=
        Trim(Copy(Trim(FValidationSource), 6, Length(FValidationSource)));
      if Length(FValidationSource) = 0 then
        NewBug := hdr + ' Declared but void check constraint'
      else
        FValidationSource :=
          Formatter.NormalizeToCurrentLineBreak(FValidationSource );
    end;
  if FIsComputed then
  begin
    if not FIsImplicitDomain then
      NewBug := hdr + ' Explicit domain cannot be COMPUTED';
    if FComputedSource = EmptyStr then
    begin
      FIsComputed := False;
      NewBug := hdr + ' Declared but void COMPUTED BY clause';
    end
    else
      FComputedSource :=
        Formatter.NormalizeToCurrentLineBreak( FComputedSource );
  end;
  if FDefaultSource <> EmptyStr then
    if Copy(Trim(UpperCase(FDefaultSource)), 1, 7) <> 'DEFAULT' then
      NewBug := hdr + ' Suspicious default: ' + FDefaultSource
    else
    begin
      FDefaultSource := Trim( Copy( Trim( FDefaultSource ),
                                    8,
                                    Length( FDefaultSource )));
      if Length(FDefaultSource) = 0 then
        NewBug := hdr + ' Declared but void default'
      else
        FDefaultSource :=
          Formatter.NormalizeToCurrentLineBreak( FDefaultSource );
    end
end;

procedure TIB_DDL_Domain.ParseMetadata2(R: TIB_Row); //override;
var
  iterations: SmallInt;
begin
  if FName <> R.BySQLNo(0).AsString
  then MetadataError('ParseMetadata2', ClassName, FName,
    'Domain names do not match');
  iterations := 0;
  With R.Statement as TIB_Cursor do
    While Not Eof do
    begin
      if FName <> R.BySQLNo(0).AsString
      then break;
      if R.BySQLNo(1).AsSmallInt > 0
      then FDimensionsLine := FDimensionsLine + ', ';
      if R.BySQLNo(2).AsInteger = 1
      then FDimensionsLine :=
        FDimensionsLine + R.BySQLNo(3).AsString
      else FDimensionsLine :=
        FDimensionsLine + R.BySQLNo(2).AsString + ':' + R.BySQLNo(3).AsString;
      APINext;
      Inc(iterations)
    end;
  if (iterations <> FDimensions)
  then NewBug := 'Domain ' + FName + ' Declared ' + IntToStr(FDimensions)
    + ' but details for ' + IntToStr(iterations) + ' dimensions where found'
end;

function TIB_DDL_Domain.Priority: SmallInt;
begin
  Result := 1
end;

function TIB_DDL_Domain.DoWriteTypeCharset: String;
begin
  With Formatter do
  begin
    Result := Normal(FTypeName);
    if FFieldType in [14, 37, 40]
    then Result := Result + Normal('(' + IntToStr(FCharacterLength) + ')')
    else if FIsNumericOrDecimal
    then begin
      if FieldScale <> 0
      then Result := Result +
        MFormat('(N,N)', [IntToStr(FFieldPrecision), IntToStr(-FieldScale)])
      else Result := Result + Normal('(' + IntToStr(FFieldPrecision) + ')')
    end;
    if FDimensions > 0
    then Result := Result + Normal('[' + FDimensionsLine + ']')
    else if FFieldType = 261 {FieldIsBlob}
    then Result := Result + MFormat(' B N B N',
      ['SUB_TYPE', FSubTypeName, 'SEGMENT SIZE', IntToStr(FSegmentLength)]);
    if FFieldType-14 in [14-14, 37-14, 40-14, 261-14]
    then Result :=
      Result + MFormat(' B N', ['CHARACTER SET', FCharacterSetName])
  end
end;

function TIB_DDL_Domain.DoWriteComputed(ForceOutput: Boolean): String;
begin
  with Formatter do
  begin
    if not FIsComputed then
      Result := EmptyStr
    else
    if ForceOutput then
      Result := MFormat( 'B N', ['COMPUTED BY', FComputedSource] )
    else
    if FIsImplicitDomain then
      if FComputedSource = EmptyStr then
        Result := EmptyStr
      else
        Result := IBComment('COMPUTED BY ' + FComputedSource )
    else
      Result := IBComment('COMPUTED BY ' + FComputedSource )
  end
end;
function TIB_DDL_Domain.DoWriteDefault(newDefault: String ): String;
begin
  With Formatter do
  begin
    if newDefault <> EmptyStr then
      Result := MFormat('B N', ['DEFAULT', newDefault])
    else
    if FDefaultSource <> EmptyStr then
      Result := MFormat('B N', ['DEFAULT', FDefaultSource])
    else
      Result := EmptyStr;
  end;
end;
function TIB_DDL_Domain.DoWriteMandatory(newMandatory: Boolean): String;
begin
  With Formatter do
  begin
    if FIsMandatory xor newMandatory then
      Result := Bold('NOT NULL')
    else
      Result := EmptyStr;
  end;
end;
function TIB_DDL_Domain.DoWriteConstraint( ForceOutput: boolean ): String;
begin
  with Formatter do
  begin
    if FValidationSource <> EmptyStr then
    begin
      if ForceOutput then
        Result := MFormat('B N', ['CHECK', FValidationSource])
      else
//        Result := IBComment( #13#10'CHECK ' + FValidationSource );
        Result := IBComment( 'CHECK' );
    end
    else
      Result := EmptyStr;
  end;
end;
function TIB_DDL_Domain.DoWriteCollation(newCollationId: SmallInt;
  newCollationName: String): String;
begin
  with Formatter do
  begin
    if FFieldType in [14, 37, 40] then
    begin
      if (NewCollationId > -1) and (FCharacterSetID > 0) then
        Result := MFormat('B N', ['COLLATE', newCollationName])
      else
      if FCollationId > 0 then
        Result := MFormat('B N', ['COLLATE', FCollationName])
      else
        Result := EmptyStr
    end
    else
      Result := EmptyStr
  end
end;

function TIB_DDL_Domain.DoWrite: Boolean;
var
  AuxLine: array[1..6] of String;
  iter: Integer;
begin
  if FIsImplicitDomain then
  begin
    Result := False;
    Exit
  end;
  with Formatter do
  begin
    NewLine := MFormat('B D B', ['CREATE DOMAIN', FName, 'AS']);
    AuxLine[1] := DoWriteTypeCharset;
    AuxLine[2] := DoWriteComputed(False);
    AuxLine[3] := DoWriteDefault(EmptyStr);
    AuxLine[4] := DoWriteMandatory(False);
    //If there's a check constraint print check
    AuxLine[5] := DoWriteConstraint( true );
    AuxLine[6] := DoWriteCollation(-1, EmptyStr);
    for iter := High(AuxLine) downto Low(AuxLine) do
      if AuxLine[iter] <> EmptyStr then
      begin
        AuxLine[iter] := AuxLine[iter] + MFormat(';', ['']);
        break
      end;
    for iter := Low(AuxLine) to High(AuxLine) do
      if AuxLine[iter] <> EmptyStr then
        NewLine := AuxLine[iter];
  end;
  Result := True
end;
(*
procedure TIB_DDL_Domain.DoWritePreamble;
begin
  With Formatter do
end;
*)
procedure TIB_DDL_Domain.DoWriteEpilog(DoWriteOk: Boolean);
begin
  if not DoWriteOk
  then Exit;
  //With Formatter do
    AddLine(EmptyStr)
end;


// ----------------------------------------------------------
// TIB_DDL_Index

class procedure TIB_DDL_Index.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$INDEX_NAME,');
  s.Add('M.RDB$RELATION_NAME,');
  s.Add('M.RDB$INDEX_ID,');
  s.Add('M.RDB$UNIQUE_FLAG,');
  s.Add('M.RDB$SEGMENT_COUNT,');
  s.Add('M.RDB$INDEX_INACTIVE,');
  s.Add('M.RDB$INDEX_TYPE,'); //The manual is wrong, this field is used!
  s.Add('M.RDB$FOREIGN_KEY,');
  s.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM RDB$RELATION_CONSTRAINTS T');
  s.Add('   WHERE M.RDB$RELATION_NAME = T.RDB$RELATION_NAME');
  s.Add('   AND M.RDB$INDEX_NAME = T.RDB$INDEX_NAME)');
  s.Add('   AS CONSTRAINT_COUNT,');
  s.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM RDB$RELATION_CONSTRAINTS T2');
  s.Add('   WHERE M.RDB$RELATION_NAME = T2.RDB$RELATION_NAME');
  s.Add('   AND M.RDB$INDEX_NAME = T2.RDB$INDEX_NAME');
  s.Add('   AND T2.RDB$CONSTRAINT_TYPE = ' + QuotedStr('FOREIGN KEY') + ')');
  s.Add('   AS FK_COUNT');
  s.Add('FROM RDB$INDICES M')
end;

class procedure TIB_DDL_Index.BuildSQL2(s: TStrings; p: TComponent); //override;
begin
  s.Add('SELECT');
  s.Add('S.RDB$INDEX_NAME,');
  s.Add('S.RDB$FIELD_POSITION,');
  s.Add('S.RDB$FIELD_NAME');
  s.Add('FROM RDB$INDEX_SEGMENTS S LEFT JOIN RDB$INDICES M');
  s.Add('ON S.RDB$INDEX_NAME = M.RDB$INDEX_NAME');
  s.Add('ORDER BY S.RDB$INDEX_NAME, S.RDB$FIELD_POSITION')
end;

constructor TIB_DDL_Index.Create(row: TIB_Row); //override;
begin
  inherited Create(row);
  Include(FEntityAttributes, meaTwoPhases);
  FFieldsList := TStringList.Create
end;

destructor TIB_DDL_Index.Destroy; //override;
begin
  FFieldsList.Free;
  inherited Destroy
end;

function TIB_DDL_Index.GetFieldsLine: String;
begin
  Result := FFieldsList.CommaText
end;

function TIB_DDL_Index.GetFormattedFieldsLine: String;
var iter: Integer;
begin
  Result := EmptyStr;
  With Formatter do
    for iter := FFieldsList.Count - 1 downto 0 do
      if Result = EmptyStr
      then Result := IBIdentifier(FFieldsList[iter])
      else Result := MFormat('D, R', [FFieldsList[iter], Result]);
end;

procedure TIB_DDL_Index.GetFieldsList(target: TStrings);
begin
  if Assigned(target)
  then target.Assign(FFieldsList)
end;

procedure TIB_DDL_Index.ParseMetadata;
var
  hdr: String;
  IndexIdIsNull: Boolean;
begin
  With FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FRelationName := BySQLNo(1).AsString;
    FIndexId := BySQLNo(2).AsSmallInt;
    IndexIdIsNull := BySQLNo(2).IsNull;
    FIsUnique := BySQLNo(3).AsBoolean;
    FSegmentCount := BySQLNo(4).AsSmallInt;
    FIndexInactive := BySQLNo(5).AsBoolean;
    FIsAscending := not BySQLNo(6).AsBoolean;
    FForeignKey := BySQLNo(7).AsString;
    FIndexConstraintCount := BySQLNo(8).AsSmallInt;
    FIndexFKeyCount := BySQLNo(9).AsSmallInt
  end;
  FIsImplicitIndex := (FForeignKey <> EmptyStr) or (FIndexConstraintCount > 0);
  hdr := 'Index ' + FName;
  if IndexIdIsNull
  then begin
    if FIndexInactive
    then NewBug := hdr + ' Id is NULL and index is inactive (warning)'
    else begin
      //FIsFaultyIndex := True;
      NewBug := hdr + ' Id is NULL but index is active'
    end
  end
  else if FIndexId < 1
  then NewBug := hdr + ' Id should start at 1 not at ' + IntToStr(FIndexId);
  if (FForeignKey <> EmptyStr) and (FIndexFKeyCount = 0)
  then NewBug := hdr
    + ' Declares foreign key but it is not found in relation constraints'
    + ' as FK index'
  else if (FForeignKey = EmptyStr) and (FIndexFKeyCount > 0)
  then NewBug := hdr
    + ' Does not declare foreign key but it is found in relation constraints'
    + ' as FK index';
  if (FIndexConstraintCount > 1)
  then NewBug := hdr + ' Used in ' + IntToStr(FIndexConstraintCount)
    + ' relation constraints at the same time';
  if FSegmentCount < 1
  then NewBug := hdr + ' Uses ' + IntToStr(FSegmentCount) + ' fields'
end;

procedure TIB_DDL_Index.ParseMetadata2(R: TIB_Row); //override;
var
  iterations: SmallInt;
begin
  if FName <> R.BySQLNo(0).AsString
  then MetadataError('ParseMetadata2', ClassName, FName,
    'Index names do not match');
  iterations := 0;
  With R.Statement as TIB_Cursor do
    While Not Eof do
    begin
      if FName <> R.BySQLNo(0).AsString
      then break;
      FFieldsList.Add(R.BySQLNo(2).AsString);
      APINext;
      Inc(iterations)
    end;
  if (iterations <> FSegmentCount)
  then NewBug := 'Index ' + FName + ' Declared ' + IntToStr(FSegmentCount)
    + ' but details for ' + IntToStr(iterations) + ' segments where found'
end;

function TIB_DDL_Index.Priority: SmallInt;
begin
  Result := 5
end;

function TIB_DDL_Index.DoWrite: Boolean;
var
  AuxLine: array[1..2] of String;
begin
  if FIsImplicitIndex and not FIndexInactive then
  begin
    Result := False;
    Exit
  end;
  if FIsUnique then
    AuxLine[1] := 'UNIQUE'
  else
    AuxLine[1] := EmptyStr;
  if not FIsAscending then
    if AuxLine[1] = EmptyStr then
      AuxLine[1] := AuxLine[1] + ' DESCENDING'
    else
      AuxLine[1] := 'DESCENDING';
  with Formatter do
  begin
    AuxLine[1] := MFormat('B N B D', ['CREATE', AuxLine[1], 'INDEX', FName]);
    AuxLine[2] := MFormat('>B D(R);', ['ON', FRelationName,
      GetFormattedFieldsLine]);
    if FIsImplicitIndex then
    begin
      if DebugOutputRaw('*') <> EmptyStr then
      begin
        NewLine := DebugOutput('Implicit index has been deactivated.');
        NewLine := DebugOutputRaw(AuxLine[1]);
        NewLine := DebugOutputRaw(AuxLine[2])
      end
    end
    else
    begin
      AddLine(AuxLine[1]);
      AddLine(AuxLine[2])
    end;
    if FIndexInactive then
      NewLine := MFormat( 'B D B;', ['ALTER INDEX', FName, 'INACTIVE'] );
  end;
  Result := True
end;
(*
procedure TIB_DDL_Index.DoWritePreamble;
begin
  With Formatter do
end;
*)
procedure TIB_DDL_Index.DoWriteEpilog(DoWriteOk: Boolean); //override;
begin
  //With Formatter do
    if DoWriteOk and FIndexInactive then
      AddLine(EmptyStr)
end;

// ----------------------------------------------------------
// TIB_DDL_Trigger

class procedure TIB_DDL_Trigger.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$TRIGGER_NAME,');
  s.Add('M.RDB$RELATION_NAME,');
  s.Add('M.RDB$TRIGGER_SEQUENCE,');
  s.Add('M.RDB$TRIGGER_TYPE,');
  s.Add('M.RDB$TRIGGER_SOURCE,');
  s.Add('M.RDB$TRIGGER_BLR,');
  s.Add('M.RDB$TRIGGER_INACTIVE,');
  s.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM RDB$DEPENDENCIES D');
  s.Add('   WHERE M.RDB$TRIGGER_NAME = D.RDB$DEPENDENT_NAME');
  s.Add('   AND M.RDB$RELATION_NAME = D.RDB$DEPENDED_ON_NAME');
  s.Add('   AND RDB$DEPENDENT_TYPE = 2 AND RDB$DEPENDED_ON_TYPE IN(0,1))');
//  s.Add('   AND RDB$FIELD_NAME IS NULL)');
  s.Add('   AS USAGE_COUNT,');
 s.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM RDB$DEPENDENCIES D');
  s.Add('   WHERE M.RDB$TRIGGER_NAME = D.RDB$DEPENDENT_NAME');
//  s.Add('   AND M.RDB$RELATION_NAME = D.RDB$DEPENDED_ON_NAME');
  s.Add('   AND RDB$DEPENDENT_TYPE = 2 AND RDB$DEPENDED_ON_TYPE IN(0,1))');
//  s.Add('   AND RDB$FIELD_NAME IS NULL)');
  s.Add('   AS FULL_USAGE_COUNT,');
  // I had to do the join just in case we are "blessed" with someone having a
  // domain NOT NULL with the same name than a trigger! Murphy doesn't sleep.
  s.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM RDB$CHECK_CONSTRAINTS C');
  s.Add('   JOIN RDB$RELATION_CONSTRAINTS RC');
  s.Add('   ON M.RDB$TRIGGER_NAME = C.RDB$TRIGGER_NAME');
  s.Add('   AND C.RDB$CONSTRAINT_NAME = RC.RDB$CONSTRAINT_NAME');
  s.Add('   AND RC.RDB$CONSTRAINT_TYPE = ' + QuotedStr('CHECK') + ')');
  s.Add('   AS CHECK_COUNT,');
  s.Add('   (SELECT 1 FROM RDB$DATABASE');
  s.Add('   WHERE EXISTS(SELECT * FROM RDB$VIEW_RELATIONS V');
  s.Add('   WHERE V.RDB$VIEW_NAME = M.RDB$RELATION_NAME))');
  s.Add('   AS IS_FOR_VIEW');
  s.Add('FROM RDB$TRIGGERS M')
end;

procedure TIB_DDL_Trigger.WipeOutAS;
const
  PossibleSeparators = #13#10#32#9;
var
  ipos, fpos: Integer;
begin
  if FIsBinaryTrigger or FIsImplicitTrigger then Exit;
  // The ugly anomaly exists only with explicit triggers.
  // Maybe any control character qualifies, but I will be simple for now.
  ipos := 1;
  while (ipos <= Length(FTriggerSource)) and
        (Pos(FTriggerSource[ipos], PossibleSeparators) > 0) do
    Inc(ipos);
  fpos := ipos + 2;
  if (Length(FTriggerSource) > fpos) and
    (UpperCase(Copy(FTriggerSource, ipos, 2)) = 'AS') and
    (Pos(FTriggerSource[fpos], PossibleSeparators) > 0) then
  begin
    while (fpos <= Length(FTriggerSource)) and
          (Pos(FTriggerSource[fpos], PossibleSeparators) > 0) do
      Inc(fpos);
    Delete(FTriggerSource, 1, fpos - 1);
  end;
  FTriggerSource :=
    Formatter.NormalizeToCurrentLineBreak( FTriggerSource );
end;

procedure TIB_DDL_Trigger.ParseMetadata;
var
  hdr: String;
begin
  With FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FRelationName := BySQLNo(1).AsString;
    FTriggerSequence := BySQLNo(2).AsSmallInt;
    FTriggerType := BySQLNo(3).AsSmallInt;
    FTriggerSource := Trim(BySQLNo(4).AsString);
    FTriggerBlr := BySQLNo(5).AsString;
    FTriggerInactive := BySQLNo(6).AsBoolean;
    FTriggerUsageCount := BySQLNo(7).AsSmallInt;
    FTriggerFullUsageCount := BySQLNo(8).AsSmallInt;
    FTriggerCheckCount := BySQLNo(9).AsSmallInt;
    FIsForView := BySQLNo(10).AsBoolean
  end;
  FIsImplicitTrigger := FTriggerCheckCount > 0;
  FIsBinaryTrigger := FTriggerSource = EmptyStr;
  hdr := 'Trigger ' + FName;
  if FIsBinaryTrigger
  then begin
    if FIsForView
    then NewBug := hdr
      + ' Has no source code available, possibly used for view '
      + FRelationName + ' with check option'
    else {if FIsImplicitTrigger
    then}
    begin
      FIsFaultyTrigger := True;
      NewBug := hdr + ' Has no source code available'
    end
  end
  else
  begin
    WipeOutAS;
    if FTriggerSource = EmptyStr then // cannot use FIsBinaryTrigger here
    begin
      FIsFaultyTrigger := True;
      NewBug := hdr + ' Has only the "AS" keywork in the body'
    end
    else
    if not FIsImplicitTrigger then
    begin
      if (UpperCase(Copy(FTriggerSource, 1, 5)) = 'CHECK') then
      begin
        FIsFaultyTrigger := True;
        NewBug := hdr + ' Starts with "CHECK" keyword. ' +
        'It is used by a check constraint that has been lost'
      end
      else
      if (UpperCase(Copy(FTriggerSource, 1, 5)) <> 'BEGIN') and
         (UpperCase(Copy(FTriggerSource, 1, 7)) <> 'DECLARE') then
      begin
        FIsFaultyTrigger := True;
        NewBug := hdr + ' Lacks the "BEGIN" keyword. ' +
          'It may be an implicit trigger spoiled due to database corruption';
      end;
    end;
  end;
  if not (FTriggerType in [1..6]) then
  begin
    FIsFaultyTrigger := True;
    NewBug := hdr + ' Unknown trigger type ' + IntToStr(FTriggerType)
  end;
  if FTriggerBlr = EmptyStr then
    NewBug := hdr + ' Has no BLR available';
  if FTriggerSequence < 0 then
    NewBug := hdr + ' Has negative sequence ' + IntToStr(FTriggerSequence);
  if (FRelationName = EmptyStr) then
    NewBug := hdr + ' Target table or view is not specified';
  if (FTriggerFullUsageCount = 0) then
    NewBug := hdr + ' Declared but not found in dependencies. ' +
    'It is not a bug in some special cases'
  else
  if FTriggerUsageCount = 0 then
    NewBug := hdr + ' Suspicious trigger depends on other tables ' +
                    'but not on the one it is attached to';
  if FIsImplicitTrigger then
  begin
    if FTriggerSequence <> 0 then
      NewBug := hdr + ' Trigger sequence is ' + IntToStr(FTriggerSequence)
                    + ' but should be zero for an implicit trigger';
  end;
end;

function TIB_DDL_Trigger.Priority: SmallInt;
begin
  Result := 6;
end;

function TIB_DDL_Trigger.DoWrite: Boolean;
var
  AuxLine: String;
begin
  if FIsImplicitTrigger or FIsBinaryTrigger
  then begin
    Result := False;
    Exit
  end;
  With Formatter do
  begin
    if FIsFaultyTrigger
    then NewLine := Normal('/* This is a faulty trigger');
    NewLine :=
      MFormat('B D B D', ['CREATE TRIGGER', FName, 'FOR', FRelationName]);
    if FTriggerInactive
    then NewLine := Bold('INACTIVE');
    case FTriggerType of // rdb$types description is not suitable for DSQL
      1: AuxLine := 'BEFORE INSERT';
      2: AuxLine := 'AFTER INSERT';
      3: AuxLine := 'BEFORE UPDATE';
      4: AuxLine := 'AFTER UPDATE';
      5: AuxLine := 'BEFORE DELETE';
      6: AuxLine := 'AFTER DELETE'
      else AuxLine := 'UNKNOWN'
    end;
    NewLine := Bold(AuxLine);
    if FTriggerSequence > 0
    then NewLine := MFormat('B N', ['POSITION', IntToStr(FTriggerSequence)]);
    NewLine := Bold('AS');
    NewLine := MFormat('N;', [NormalizeToCurrentLineBreak(FTriggerSource)]);
    if IsFaultyTrigger
    then NewLine := Normal('End of faulty trigger */')
  end;
  Result := True
end;

procedure TIB_DDL_Trigger.DoWritePreamble;
var
  rc: String;
begin
  if FIsImplicitTrigger or FIsBinaryTrigger or FIsFaultyTrigger
  then Exit;
  With Formatter do
    rc := SetIBTerminator(false);
  if rc <> EmptyStr
  then AddLine(rc)
end;

procedure TIB_DDL_Trigger.DoWriteEpilog(DoWriteOk: Boolean);
var
  rc: String;
begin
  if not DoWriteOk
  then Exit;
  With Formatter do
    if IsFaultyTrigger
    then rc := EmptyStr
    else rc := ResetIBTerminator(false);
  if rc <> EmptyStr
  then AddLine(rc);
  AddLine(EmptyStr)
end;


// ----------------------------------------------------------
// TIB_DDL_Role

class procedure TIB_DDL_Role.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT');
  s.Add('M.RDB$ROLE_NAME,');
  s.Add('M.RDB$OWNER_NAME');
  s.Add('FROM RDB$ROLES M')
end;

procedure TIB_DDL_Role.ParseMetadata;
var
  hdr: String;
begin
  With FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FOwnerName := BySQLNo(1).AsString
  end;
  hdr := 'Role ' + FName;
  if (FOwnerName = EmptyStr)
  then NewBug := hdr + ' Owner name is not specified'
end;

function TIB_DDL_Role.Priority: SmallInt;
begin
  Result := 7
end;

function TIB_DDL_Role.DoWrite: Boolean;
begin
  With Formatter do
    NewLine := MFormat('B D; *', ['CREATE ROLE', FName, 'BY ' + FOwnerName]);
  Result := True
end;
(*
procedure TIB_DDL_Role.DoWritePreamble;
begin
  With Formatter do
end;

procedure TIB_DDL_Role.DoWriteEpilog(DoWriteOk: Boolean);
begin
  With Formatter do
end;
*)


// ----------------------------------------------------------
// TIB_DDL_Permission

class procedure TIB_DDL_Permission.BuildSQL(s: TStrings;Connection: TIB_Connection);
begin
  s.Add('SELECT DISTINCT');
  s.Add('M.RDB$GRANTOR,');
  s.Add('M.RDB$USER,');
  s.Add('M.RDB$USER_TYPE,');
  s.Add('M.RDB$RELATION_NAME as RDB$OBJECT_NAME,');
  s.Add('M.RDB$OBJECT_TYPE');
  s.Add('FROM RDB$USER_PRIVILEGES M');
  // Here we need special ordering, so let's add it.
  s.Add('ORDER BY M.RDB$GRANTOR, M.RDB$USER, M.RDB$USER_TYPE,'
    + 'M.RDB$RELATION_NAME, M.RDB$OBJECT_TYPE')
end;

class procedure TIB_DDL_Permission.BuildSQL2(s: TStrings; p: TComponent); //override;
begin
  s.Add('SELECT');
  s.Add('M.RDB$GRANTOR,');
  s.Add('M.RDB$USER,');
  s.Add('M.RDB$USER_TYPE,');
  s.Add('M.RDB$RELATION_NAME as RDB$OBJECT_NAME,');
  s.Add('M.RDB$OBJECT_TYPE,');
  s.Add('M.RDB$GRANT_OPTION,');
  s.Add('M.RDB$PRIVILEGE,');
  s.Add('M.RDB$FIELD_NAME');
  s.Add('FROM RDB$USER_PRIVILEGES M');
  s.Add('ORDER BY M.RDB$GRANTOR, M.RDB$USER, M.RDB$USER_TYPE,'
    + 'M.RDB$RELATION_NAME, M.RDB$OBJECT_TYPE')
end;

constructor TIB_DDL_Permission.Create(row: TIB_Row);
var
  iter: Integer;
begin
  inherited Create(row);
  Include(FEntityAttributes, meaTwoPhases);
  for iter := -1 to 1 do
    FFieldsList[iter] := TStringList.Create
end;

destructor TIB_DDL_Permission.Destroy; //override;
var
  iter: Integer;
begin
  for iter := -1 to 1 do
    FFieldsList[iter].Free;
  inherited Destroy
end;

function TIB_DDL_Permission.GetFieldsLine(dim: Integer): String;
begin
  if dim in [0, 1]
  then Result := FFieldsList[dim].CommaText
  else Result := EmptyStr
end;

function TIB_DDL_Permission.GetFormattedFieldsLine(dim: Integer): String;
var
  iter: Integer;
begin
  Result := EmptyStr;
  if (dim < 0) or (dim > 1)
  then Exit;
  With Formatter, FFieldsList[dim] do
    for iter := Count - 1 downto 0 do
      if Result = EmptyStr
      then Result := IBIdentifier(Strings[iter])
      else Result := MFormat('D, R', [Strings[iter], Result]);
end;

function TIB_DDL_Permission.GetFormattedFieldsLineGrAdOpt(dim: Integer;
  GrAdOpt: Boolean): String;
var
  iter: Integer;
begin
  Result := EmptyStr;
  if (dim < 0) or (dim > 1)
  then Exit;
  With Formatter, FFieldsList[dim] do
    for iter := Count - 1 downto 0 do
      if ((Integer(Objects[iter]) = 0) and not GrAdOpt)
      or ((Integer(Objects[iter]) > 0) and GrAdOpt)
      then begin
        if Result = EmptyStr
        then Result := IBIdentifier(Strings[iter])
        else Result := MFormat('D, R', [Strings[iter], Result])
      end
end;

procedure TIB_DDL_Permission.GetPrivilegesList(target: TStrings);
begin
  if Assigned(target)
  then target.Assign(FFieldsList[-1])
end;

procedure TIB_DDL_Permission.GetFieldsList(idx: Boolean; target: TStrings);
begin
  if Assigned(target)
  then target.Assign(FFieldsList[Ord(idx)])
end;

procedure TIB_DDL_Permission.ParseMetadata;
var
  hdr: String;
begin
  With FIB_Row do
  begin
    //FName := BySQLNo(0).AsString;
    FUserName := BySQLNo(1).AsString;
    FUserType := BySQLNo(2).AsSmallInt;
    FObjectName := BySQLNo(3).AsString;
    FObjectType := BySQLNo(4).AsSmallInt
  end;
  hdr := 'Permission granted by ' + FName + ' to ' + FUserName;
  if (FName = EmptyStr)
  then NewBug := hdr + ' Grantor name is not specified'
end;

function TIB_DDL_Permission.CheckPartialRights(listIdx: Integer): Integer;
var
  grantAdmin, idxPriv: SmallInt;
begin
  // Can we assume we have full grant/admin option?
  Result := 0;
  if (listIdx < -1) or (listIdx > 1)
  then Exit;
  With FFieldsList[listIdx] do
  begin
    if Count = 0
    then Exit;
    grantAdmin := 0;
    for idxPriv := 0 to Count - 1 do
      if Integer(Objects[idxPriv]) > 0
      then Inc(grantAdmin);
    if grantAdmin = Count
    then Result := 2
    else if grantAdmin > 0
    then Result := 1
  end
end;

procedure TIB_DDL_Permission.OrderPrivileges(p: Char; NewIdx: SmallInt);
var
  ci: SmallInt;
begin
  With FFieldsList[-1] do
  begin
    ci := IndexOf(p);
    if ci > NewIdx
    then Move(ci, NewIdx)
  end
end;

procedure TIB_DDL_Permission.ParseMetadata2(R: TIB_Row); //override;
var
  priv, fldName: String;
  grantAdmin, idxPriv, idxFld: SmallInt;
  hdr: String;
begin
  if (FName <> R.BySQLNo(0).AsString)
  or (FUserName <> R.BySQLNo(1).AsString)
  or (FUserType <> R.BySQLNo(2).AsSmallInt)
  or (FObjectName <> R.BySQLNo(3).AsString)
  or (FObjectType <> R.BySQLNo(4).AsSmallInt)
  then MetadataError('ParseMetadata2', ClassName, FName,
    'Permission names do not match');
  //iterations := 0;
  hdr := 'Permission granted by ' + FName + ' to ' + FUserName;
  With R.Statement as TIB_Cursor do
  begin
    While Not Eof do
    begin
      if (FName <> R.BySQLNo(0).AsString)
      or (FUserName <> R.BySQLNo(1).AsString)
      or (FUserType <> R.BySQLNo(2).AsSmallInt)
      or (FObjectName <> R.BySQLNo(3).AsString)
      or (FObjectType <> R.BySQLNo(4).AsSmallInt)
      then break;
      With Fields do
      begin
        grantAdmin := BySQLNo(5).AsSmallInt;
        if not (grantAdmin in [0..2])
        then NewBug := hdr +
          ' Grant/Admin option out of 0..2 range: ' + IntToStr(grantAdmin);
        if (grantAdmin > 0) and (FUserType <> 8) // 8=User
        then NewBug := hdr + ' Grant/Admin option given to user type '
          + IntToStr(FUserType);
        //FGrantOrAdminOption :=  (grantAdmin > 0) or FGrantOrAdminOption;
        priv := BySQLNo(6).AsString;
        With FFieldsList[-1] do
        begin
          idxPriv := IndexOf(priv);
          if idxPriv < 0
          then begin
            if BySQLNo(7).IsNull
            then begin
              AddObject(priv, TObject(grantAdmin));
              if priv = 'U'
              then FSingleUpdate := True
              else if priv = 'R'
              then FSingleReferences := True
            end
            else Add(priv)
          end
          else if BySQLNo(7).IsNull
          then begin
            if Integer(Objects[idxPriv]) < grantAdmin
            then Objects[idxPriv] := TObject(grantAdmin);
            NewBug := hdr + ' Duplicated ' + priv + ' on ' + FObjectName
          end
        end;
        if (priv = 'X') and (FObjectType <> 5) // 5=proc
        then NewBug := hdr + ' Assigning EXECUTE on object type '
          + IntToStr(FObjectType) + ' that should be 5 (proc) instead';
        if (priv <> 'X') and (FObjectType = 5)
        then NewBug := hdr +
          ' Assigning ' + priv + ' on procedure' + FObjectName;
        if (priv = 'M') and (FObjectType <> 13) // 13=role
        then NewBug := hdr + ' Assigning membership on object type '
          + IntToStr(FObjectType) + ' that should be 13 (role) instead';
        if (priv <> 'M') and (FObjectType = 13)
        then NewBug := hdr +
          ' Assigning ' + priv + ' on role ' + FObjectName;
        if BySQLNo(7).IsNotNull
        then begin
          fldName := BySQLNo(7).AsString;
          case priv[1] of
            'U':
              With FFieldsList[0] do
              begin
                idxFld := IndexOf(fldName);
                if idxFld < 0
                then AddObject(fldName, TObject(grantAdmin))
                else begin
                  if Integer(Objects[idxFld]) < grantAdmin
                  then Objects[idxFld] := TObject(grantAdmin);
                  NewBug := hdr + ' Duplicated field ' + fldName + ' with '
                    + priv + ' on ' + FObjectName
                end
              end;
            'R':
              With FFieldsList[1] do
              begin
                idxFld := IndexOf(fldName);
                if idxFld < 0
                then AddObject(fldName, TObject(grantAdmin))
                else begin
                  if Integer(Objects[idxFld]) < grantAdmin
                  then Objects[idxFld] := TObject(grantAdmin);
                  NewBug := hdr + ' Duplicated field ' + fldName + ' with '
                    + priv + ' on ' + FObjectName
                end
              end;
            else NewBug := hdr +
              ' Trying to set specific fields but the privilege is not U or R'
          end
        end
      end;
      APINext
    end
  end; //With
  // Discover if several lines are needed for output.
  if FObjectType = 5
  then With FFieldsList[-1] do
  begin
    if (Count = 1) and (Strings[0] = 'X') and (Integer(Objects[0]) > 0)
    then FGrantOrAdminOption := True
  end
  else begin
    FPartialGrantOrAdminOption := CheckPartialRights(-1);
    if FPartialGrantOrAdminOption = 2
    then FGrantOrAdminOption := True;
    FPartialGrantOrAdminUpdate := CheckPartialRights(0);
    FPartialGrantOrAdminReferences := CheckPartialRights(1);
  end;
  //Go to order the privileges by brute force.
  // S I U D R X, but X only can exist alone.
  OrderPrivileges('X', 0); // Just in case we collected junk.
  OrderPrivileges('S', 0);
  OrderPrivileges('I', 1);
  OrderPrivileges('U', 2);
  OrderPrivileges('D', 3);
  OrderPrivileges('R', 4) // redundant
end;

function TIB_DDL_Permission.Priority: SmallInt;
begin
  Result := 8
end;

function TIB_DDL_Permission.GetShowSysdbaRights: Boolean;
begin
  Result := (FEntityList as TIB_DDL_PermissionList).ShowSysdbaRights;
end;

function TIB_DDL_Permission.DoWritePrivilege(GrAdOpt: Boolean): String;
var
  iter: Integer;
  AuxLine: String;
begin
  Result := EmptyStr;
  With Formatter, FFieldsList[-1] do
  begin
    if (CommaText = 'S,I,U,D,R') and
      (((FPartialGrantOrAdminOption = 0) and not GrAdOpt) or
       ((FPartialGrantOrAdminOption = 2) and GrAdOpt))
    then Result := Normal('ALL')
    else for iter := 0 to Count - 1 do
    begin
      if ((Integer(Objects[iter]) = 0) and not GrAdOpt)
      or ((Integer(Objects[iter]) > 0) and GrAdOpt)
      then begin
        case Strings[iter][1] of
          //'A': It doesn't exist in system tables but can be used in DDL.
          'S': AuxLine := Normal('SELECT');
          'D': AuxLine := Normal('DELETE');
          'I': AuxLine := Normal('INSERT');
          'U':
            {if FFieldsList[0].Count > 0
            then AuxLine := MFormat('N(R)', ['UPDATE', FormattedUpdateLine])
            else }
            if FSingleUpdate
            then AuxLine := Normal('UPDATE')
            else Continue;
          'R':
            {if FFieldsList[1].Count > 0
            then AuxLine := MFormat('N(R)', ['REFERENCES', FormattedReferencesLine])
            else }
            if FSingleReferences
            then AuxLine := Normal('REFERENCES')
            else Continue;
          'M': AuxLine := IBComment('MEMBER OF');
          'X': AuxLine := Normal('EXECUTE');
          else AuxLine := Normal(Strings[iter][1]) // let the user catch the bug.
        end;
        if Result = EmptyStr
        then Result := AuxLine
        else Result := Result + Normal(','#32) + AuxLine
      end
    end; //for
    if (FFieldsList[0].Count > 0) and
      (((FPartialGrantOrAdminUpdate < 2) and not GrAdOpt) or
       ((FPartialGrantOrAdminUpdate > 0) and GrAdOpt))
    then begin
      AuxLine :=MFormat('N(R)', ['UPDATE',
        GetFormattedFieldsLineGrAdOpt(0, GrAdOpt)]);
      if Result = EmptyStr
      then Result := AuxLine
      else Result := Result + Normal(','#32) + AuxLine
    end;
    if (FFieldsList[1].Count > 0) and
      (((FPartialGrantOrAdminReferences < 2) and not GrAdOpt) or
       ((FPartialGrantOrAdminReferences > 0) and GrAdOpt))
    then begin
      AuxLine := MFormat('N(R)', ['REFERENCES',
        GetFormattedFieldsLineGrAdOpt(1, GrAdOpt)]);
      if Result = EmptyStr
      then Result := AuxLine
      else Result := Result + Normal(','#32) + AuxLine
    end
  end
end;
function TIB_DDL_Permission.DoWriteUser: String;
begin
  case FUserType of
    0: Result := ''; // Relation
    1: Result := 'VIEW';
    2: Result := 'TRIGGER';
    5: Result := 'PROCEDURE';
    8: Result := 'USER';
    13: Result := '*' + 'ROLE'; // Role keyword is not accepted.
    else Result := '*' + 'User type ' + IntToStr(FUserType)
  end;
  With Formatter do
    if Result = EmptyStr
    then Result := IBIdentifier(FUserName)
    else if Result[1] = '*'
    then Result := MFormat('* D', [Copy(Result, 2, Length(Result)), FUserName])
    else Result := MFormat('B D', [Result, FUserName])
end;
function TIB_DDL_Permission.DoWriteGrantAdmin(GrAdOpt: Boolean): string;
begin
  With Formatter do
    if GrAdOpt
    then if ObjectType = 13 // Role.
      then Result := Normal(#32) + Bold('WITH ADMIN OPTION')
      else Result := Normal(#32) + Bold('WITH GRANT OPTION')
    else Result := EmptyStr
end;

function TIB_DDL_Permission.DoWrite: Boolean;
var
  AuxLine, OnClause: String;
begin
  if (FUserName = 'SYSDBA') and not GetShowSysdbaRights
  then begin
    Result := False;
    Exit
  end;
  case FObjectType of
    0,1: OnClause := 'ON TABLE'; // Tables and views.
    5: OnClause := 'ON PROCEDURE';
    13:OnClause := ''; // Role.
    else OnClause := 'ON'
  end;
  Result := False;
  With Formatter do
  begin
    AuxLine := DoWritePrivilege(True);
    if AuxLine <> EmptyStr
    then begin
      NewLine := MFormat('B R B D B RR;', ['GRANT',
        AuxLine, OnClause,
        FObjectName, 'TO', DoWriteUser,
        DoWriteGrantAdmin(True)]);
      Result := True
    end;
    AuxLine := DoWritePrivilege(False);
    if AuxLine <> EmptyStr
    then begin
      NewLine := MFormat('B R B D B RR;', ['GRANT',
        AuxLine, OnClause,
        FObjectName, 'TO', DoWriteUser,
        DoWriteGrantAdmin(False)]);
      Result := True
    end
  end
end;

procedure TIB_DDL_Permission.DoWritePreamble;
begin
  if (FUserName = 'SYSDBA') and not GetShowSysdbaRights
  then Exit;
  With Formatter, FEntityList as TIB_DDL_PermissionList do
    if (_PrevGrantor <> FName) // Grantor
    then begin
      AddLine(IBComment('Granted by ' + FName));
      _PrevGrantor := FName
    end
end;
(*
procedure TIB_DDL_Permission.DoWriteEpilog(DoWriteOk: Boolean);
begin
  With Formatter do
end;
*)

end.
