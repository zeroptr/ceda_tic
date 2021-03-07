
{                                                                              }
{ IB_Metadata                                                                  }
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
{  27-Apr-2003                                                                 }
{     * Added support for Firebird v1.5 universal triggers.                    }
{     * As part of the above I added the ExtractVersionInfo procedure to       }
{       the TIB_DDLDatabase class - which assigns the various new FB and IB    }
{       properties on this class.  This method makes some assumptions about    }
{       the format of the version string returned by database_info, so it may  }
{       need checking against future versions of Firebird.                     }
{     * Added the coUseBigInt option.                                          }
{     * Added support for user defined constraint index names as provided      }
{       by Firebird v1.5 and later.  See also the help notes for the code      }
{       option coKeepCustomIndexNames.                                         }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  01-Oct-2002                                                                 }
{     * Isolated all the text that can be localised into resourcestring values }
{       and moved these into the IB_Constants.pas unit.                        }
{     * The Index duplication check now checks for partial matches             }
{     * Added tracking of minor versus significant problem messages (to allow  }
{       reporting of status according to whether anything significant found).  }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  27-Sep-2002                                                                 }
{     * Trigger and procedure checking needed to allow for prefixing comments. }
{     * Removed checking of dbkey for view, the situation is more complicated  }
{       that it is practical to check in the current code.                     }
{     * No longer report "assuming NONE" for null character set details,       }
{       provided the database default is NONE.  There were just too many of    }
{       messages occuring and they tend to distract from real issues.          }
{     * Added a check for non-system entities named with RDB$.  This can be    }
{       used to detect problems like orphaned primary key indexes.             }
{     * Added a check for duplicate indexes.                                   }
{     * Added the coKeepCustomIndexNames option.                               }
{     With thanks to Nando Dessena and Paul Hope for their help in finding,    }
{     isolating and testing these issues via my DBak application.              }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  22-Sep-2002                                                                 }
{     The system table RDB$FUNCTION_ARGUMENTS does not have the field          }
{     RDB$CHARACTER_LENGTH in IB v5.6 and earlier.                             }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  21-May-2002                                                                 }
{     Changed the description processing to ensure that descriptions against   }
{     fields and parameters will result in Metadata.OnHasDescription events.   }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  04-May-2002                                                                 }
{     Added some special processing for views so that they will extract in the }
{     order of dependancy.  So if VIEWA depends on VIEWB then VIEWB will be    }
{     extracted before VIEWA.  Made it so that most computed fields will be    }
{     created when the table is created, I only exclude those that have        }
{     dependency on external entities (views and tables).  This means that     }
{     Views can be created on normal computed fields, but dependency problems  }
{     will occur if your views use computed columns contained embedded selects.}
{     Many thanks to John Hill for his assistance in this update.              }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  28-Apr-2002                                                                 }
{     Added coIgnoreDependancies option to allow extract of custom triggers    }
{     etc attached to system metadata entities.                                }
{                                                                              }
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  07-Jan-2002                                                                 }
{     Original Author.  Based on code written by Claudio Valderrama in the     }
{     IB_DDL_* units, but this variation written as a replacement to support   }
{     my DBak application.                                                     }
{                                                                              }
{------------------------------------------------------------------------------}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_Metadata component and related classes.}
unit IB_Metadata;

interface

uses Classes,
  Sysutils,
  IB_Header,
  IB_Session,
  IB_Components,
  IB_CodeFormatter;


// ---------------------------------------------------------------------------
// Interface details for the supporting metadata extract classes
// (see below for actual TIB_Metadata component).

type

{: Full range of possible different types of entities managed by the
TIB_Metadata and related classes.  See TIB_CustomMetadata for more detail.}
  TIB_EntityType = (
    etDatabase,                         // First and last level 0 type
    etException,                        // First level 1 entity type
    etBlobFilter,
    etUDF,
    etGenerator,
    etDomain,
    etTable,
    etView,
    etProcedure,
    etRole,                             // Last level 1 entity type
    etPrimaryKey,                       // First level 2 entity type
    etUniqueKey,
    etIndex,                            // has to be in before foreign keys!
    etForeignKey,
    etConstraint,                       // constraints other than PK / FK
    etTrigger,
    etPermission,                       // Last level 2 entity type
    etUDFParam,                         // First level 3 entity type
    etTableField,
    etViewField,
    etProcParam                         // Last level 3 entity type
    );

  TIB_EntityTypes = set of TIB_EntityType;

{: Set of Level 0 entity types.  See TIB_CustomMetadata for more detail.}
  TIB_L0EntityType = etDatabase..etDatabase;
  TIB_L0EntityTypes = set of TIB_L0EntityType;

{: Set of Level 1 entity types.  See TIB_CustomMetadata for more detail.}
  TIB_L1EntityType = etException..etRole;
  TIB_L1EntityTypes = set of TIB_L1EntityType;

{: Set of Level 2 entity types.  See TIB_CustomMetadata for more detail.}
  TIB_L2EntityType = etPrimaryKey..etPermission;
  TIB_L2EntityTypes = set of TIB_L2EntityType;

{: Set of Level 0 entity types.  See TIB_CustomMetadata for more detail.}
  TIB_L3EntityType = etUDFParam..etProcParam;
  TIB_L3EntityTypes = set of TIB_L3EntityType;

const
{: Constant containing full set of Level 1 entity types.}
  IB_L1EntityTypes: TIB_L1EntityTypes = [etException..etRole];
{: Constant containing full set of Level 2 entity types.}
  IB_L2EntityTypes: TIB_L2EntityTypes = [etPrimaryKey..etPermission];

{: Constant giving 'RDB$' - the standard prefix for IB/FB metadata entities.}
  IB_DefaultRDBPrefix: string = 'RDB$';  // do not localise

type

{: Enumeration of options to control what DDL is generated by TIB_Metadata
and related classes.
<br>
coCreateDatabase - generate CREATE DATABASE statements.<br>
<br>
coSecondaryFiels - include any defined secondary files in DDL<br>
<br>
coDefineShadows - include any defined shadow files in DDL<br>
<br>
coSetGeneratorVal - include SET GENERATOR statements to set the generator
to the currently value of the generator from the source database.<br>
<br>
coResetExceptionNo - include DDL which alters the exception number to match
the unique number from the source database.<br>
<br>
coRawFieldDefs - define all fields using raw IB/FB data types (otherwise
domain names will be used).<br>
<br>
coIsolateAllComputed - this option is ignored by CodePass cpFull.  Check this
option to have all computed fields ignored during cpInit CodePass and isolated
to separate alter table statements during cpFinal.  Such isolation happens
automatically for computed fields containing embedded selects regardless of
this setting.  Isolating computed fields allow the statements to be manually
reordered if necessary to work around computed field dependency issues.
Note that turning this option on may prevent creation of views that refer to
computed columns unless the isolated statements are moved to the appropriate
position within the script.<br>
<br>
coReportMinor - have error listing include minor/possible problems.<br>
<br>
coAlwaysQuoted - have all DDL entity names enclosed in double quotes.  Do
not set this option is using dialect 1.<br>
<br>
coAlwaysCharSet - always include the character set declaration with all field
and domain declarations.  If not set then the character set will only be
declared if it is different to the database default.<br>
<br>
coIncludeDebug - include additional (debug) comments in the output.<br>
<br>
coDescripAsComment - if entities have a description in the metadata definition
then setting this option will include that description as a comment above the
declaration of the entity.<br>
<br>
coIgnoreDependencies - when this option is off (the default) then the extract
will automatically ignore all dependant (level 2) entities for any level 1
entities that have been filtered.  So if you filter TableA then the extract
will automatically filter all triggers and indexes etc for TableA.  When this
option is turned on the extract will still produce the level 2 entities
(triggers, indexes permissions etc) unless you have explicit filters to exclude
them.  This option can be useful to allow the extraction of custom triggers etc
applied to metadata tables.<br>
<br>
coKeepCustomIndexNames - if the source database was constructed with specially
named indexes behind the primary key, foreign key and unique constraints the
default processing will lose those customisations - letting the server rename
those indexes automatically.  Check this option to have the component try to
generate the appropriate direct metadata updates required to maintain the
custom names.  Note that this is not supported by the server, nor by me.  It
is simply an option that may help for those occassions that required this level
of customisation.  Note also that the constraint itself should also be manually
named or name conflicts may result with other automatically named
constraints.<br>
<br>
Note: Firebird v1.5 and later provide the "USING INDEX ..." directive with
constraints.  What I have done is kept this option active even with FB v1.5.
When turned on it disables the "USING INDEX" directive and uses the direct
metadata table updates described above.  In theory this may allow custom index
names to be extracted from FB v1.5 and later databases, in a script that can be
applied to earlier versions (but I dont guarantee it will work).<br>
<br>
coUseBigInt - have NUMERIC(18,0) field and domain definitions output as BIGINT
(type 16 fields with 0 scale).  The script will have to be executed on a
server that recognises this keyword (Firebird v1.5 or later).}
  TIB_DDLCodeOption = (
    coCreateDatabase,                   // write the create database statement
    coSecondaryFiles,                   // define of secondary files in DB DDL
    coDefineShadows,                    // include shadow definitions in DB DDL
    coSetGeneratorVal,                  // value generator value set
    coResetExceptionNo, // have exception number reset to original value
    coRawFieldDefs,                     // ignore domains on table output
    coIsolateAllComputed,               // isolate all computed fields from tables
    coReportMinor,                      // report minor problems
    coAlwaysQuoted, // all identities quoted in dialect 3 whether needed or not
    coAlwaysCharSet, // set true to always define character set
    coIncludeDebug,                     // include debug comments
    coDescripAsComment,                 // include descriptions as comments
    coIgnoreDependencies,               // ignore hierarchical dependancies
    coKeepCustomIndexNames,             // do direct updates to keep spc names
    coUseBigInt                         // use BIGINT not NUMERIC
    );
  TIB_DDLCodeOptions = set of TIB_DDLCodeOption;


{: Enumeration of different passes through the metadata made by TIB_Metadata
and related classes.
<br>
cpFull - will generate all DDL SQL without regard to dependancies.<br>
<br>
cpInit - will generate prefixing DDL SQL (no constraint information unless
it is just empty shells.<br>
<br>
cpFinal - will generate all the DDL SQL needed to complete a database that
has had DDL defined using the cpInit code pass.<br>
<br>
cpAuto - automatically generates cpInit code followed by cpFinal code.  To save
having to run two separate passes over the code.  The resulting script should
have minimal dependancy problems.  See notes for IB_CustomMetadata.
}
  TIB_DDLCodePassBase = (
    cpFull,
    cpInit,
    cpFinal,
    cpAuto
    );
{: Enumeration of possible TIB_DDLCodePassBase values that can be passed
to the various extract methods. }
  TIB_DDLCodePass = cpFull..cpFinal;

{: Enumeration of problem message types. }
  TIB_DDLProblemLevel = (
    plNone,
    plMinor,
    plSuspicious,
    plWarning,
    plError
    );

{: Stores information about secondary or shadow files associated with database.
Could have just been a record, but TObjects can be more useful.}
  TIB_DDLExtraFile = class(TObject)
  public
    Name: string;
    Sequence: smallint;
    Start: integer;
    Length: integer;
    Flags: smallint;
    ShadowNumber: smallint;
  end;

  TIB_DDLDatabase = class;
  TIB_DDLEntity = class;
  TIB_DDLEntityClass = class of TIB_DDLEntity;

{: Event procedure for TIB_DDLDatabase.  During AddCode calls any entities
that have descriptions will generate this event against the database to
allow external processing of the description information.}
  TIB_DDLEntityDescriptionEvent = procedure(Sender: TIB_DDLDatabase;
    AType: TIB_EntityType; AEntity: TIB_DDLEntity) of object;

{: Base class for metadata entities extracted by TIB_Metadata.
See TIB_CustomMetadata for more details.}
  TIB_DDLEntity = class(TObject)
  private
    FDatabase: TIB_DDLDatabase; // will be assigned internally when created
    FParent: TIB_DDLEntity;
    FInitialised: boolean;

    FName: string;
    FSystemFlag: boolean;
    FIsImplicit: Boolean;
    FNewName: string;
    FDescription: string;
    FTag: integer;

  protected
    function GetCursor: TIB_Cursor; virtual;
    procedure AssignFromFields(ARow: TIB_Row); virtual;
    function GetEntityList(EType: TIB_EntityType): TStringList; virtual;

    procedure Initialise(AName, AParent: string);
    function GetEntityClass(EType: TIB_EntityType): TIB_DDLEntityClass;
    function GetEntityCount(EType: TIB_EntityType): integer;
    function GetEntityName(EType: TIB_EntityType; Idx: integer): string;
    function GetEntity(EType: TIB_EntityType; Idx: integer): TIB_DDLEntity;
    function GetEntityByName(EType: TIB_EntityType;
      AName: string): TIB_DDLEntity;
    procedure AddDescription(ACode: TIB_CodeFormatter);

  public
    constructor Create(ADatabase: TIB_DDLDatabase; AParent: TIB_DDLEntity);
    destructor Destroy; override;

    function RDB: string;
    procedure Reset; virtual;
    procedure AddProblem(lvl: TIB_DDLProblemLevel; AStr: string);
    function OutputName: string;
    function MkIdent(AName: string): string;

    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; virtual;

    property Database: TIB_DDLDatabase read FDatabase;
    property Parent: TIB_DDLEntity read FParent;
    property Initialised: boolean read FInitialised;

    property Count[EType: TIB_EntityType]: integer read GetEntityCount;
    property Names[EType: TIB_EntityType;
      Idx: integer]: string read GetEntityName;
    property Entity[EType: TIB_EntityType;
      Idx: integer]: TIB_DDLEntity read GetEntity;
    property EntityByName[EType: TIB_EntityType;
      AName: string]: TIB_DDLEntity read GetEntityByName;

    property Name: string read FName;
    property NewName: string read FNewName write FNewName;
    property Description: string read FDescription write FDescription;
    property SystemFlag: boolean read FSystemFlag;
    property IsImplicit: boolean read FIsImplicit;
    property Tag: integer read FTag write FTag;

  end;

{: Store the database DDL description
and all the DDL descriptions of all entities within the databsae.
See TIB_CustomMetadata for more details.}
  TIB_DDLDatabase = class(TIB_DDLEntity)
  private
    FConnection: TIB_Connection;
    FIntTransaction: TIB_Transaction;
    FExtTransaction: TIB_Transaction;
    FRDBPrefix: string;
    FProblems: TStrings;
    FProblemCounts: array [plNone..plError] of integer;
    FCodeOptions: TIB_DDLCodeOptions;
    FOnDescription: TIB_DDLEntityDescriptionEvent;

    FDatabaseCsr: TIB_Cursor;
    FExtraFileCsr: TIB_Cursor;
    FExceptionCsr: TIB_Cursor;
    FExceptions: TStringList;
    FBlobFilterCsr: TIB_Cursor;
    FBlobFilters: TStringList;
    FUDFCsr: TIB_Cursor;
    FUDFs: TStringList;
    FGeneratorCsr: TIB_Cursor;
    FGenerators: TStringList;
    FDomainCsr: TIB_Cursor;
    FDomainDimCsr: TIB_Cursor;
    FDomainImplicitCsr: TIB_Cursor;
    FDomains: TStringList;
    FTableCsr: TIB_Cursor;
    FTables: TStringList;
    FViewCsr: TIB_Cursor;
    FViews: TStringList;
    FProcedureCsr: TIB_Cursor;
    FProcedures: TStringList;
    FRoleCsr: TIB_Cursor;
    FRoles: TStringList;
    FConstraintCsr: TIB_Cursor;
    FIndexCsr: TIB_Cursor;
    FIndexFieldsCsr: TIB_Cursor;
    FTriggerCsr: TIB_Cursor;
    FPermissionCsr: TIB_Cursor;
    FTriggerListCsr: TIB_Cursor;
    FConstraintListCsr: TIB_Cursor;
    FIndexListCsr: TIB_Cursor;
    FFieldListCsr: TIB_Cursor;
    FUDFParamCsr: TIB_Cursor;
    FTableFieldCsr: TIB_Cursor;
    FViewFieldCsr: TIB_Cursor;
    FProcParamCsr: TIB_Cursor;
    FProcParamListCsr: TIB_Cursor;

    FOwnerName: string;
    FCharacterSetName: string;
    FCharacterSetNormal: string;
    FCharacterSetId: SmallInt;
    FUserExceptionCount: Integer;
    FBaseLevel: Byte;                   // byte
    FODSVersion: Word;                  // word
    FVersionString: string;             // string
    FDialect: SmallInt;
    FSecondaryFiles: TList;
    FShadowFiles: TList;

    FFBVersion: integer; // mmmnnnrrr or 0 = not Firebird
    FFBBuild: integer;   // bbbbbbbbb or 0 = not Firebird
    FIBVersion: integer; // mmmnnnrrr or 0 = not Interbase
    FIBBuild: integer;   // bbbbbbbbb or 0 = not Firebird
    FPlatform: string;
    FBuildType: string;
    FBuildInfo: string;

    procedure SetConnection(AVal: TIB_Connection);
    procedure SetTransaction(AVal: TIB_Transaction);

  protected
    function GetSecondaryFileCount: integer;
    function GetSecondaryFile(Idx: integer): TIB_DDLExtraFile;
    function GetShadowFileCount: integer;
    function GetShadowFile(Idx: integer): TIB_DDLExtraFile;
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
    function GetEntityList(EType: TIB_EntityType): TStringList; override;
    function GetEntityListSQL(EType: TIB_EntityType): string;
    function BuildEntityList(EType: TIB_EntityType): TStringList;
    procedure ResortViews( ViewList: TStringList );
    function CreateCursor: TIB_Cursor;
    procedure DoDescription( AEntity: TIB_DDLEntity );
    function GetSeverity: TIB_DDLProblemLevel;
    function GetProblemCount(idx: TIB_DDLProblemLevel): integer;
    procedure ExtractVersionInfo(ISCVer: string; FBVer: string);

  public
    constructor Create;
    destructor Destroy; override;

    // public access to initialise
    procedure Init;
    procedure Reset; override;
    procedure ClearCursors;
    procedure CloseTransaction(ACommit: boolean);
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;

    procedure AddSecondaryFile( AName: string; ASequence: smallint;
      AStart: integer; ALength: integer; AFlags: smallint );
    procedure RemoveSecondaryFile( Idx: integer );
    procedure ClearSecondaryFiles;
    procedure AddShadowFile( AName: string; ASequence: smallint;
      AStart: integer; ALength: integer; AFlags: smallint; AShadow: smallint );
    procedure RemoveShadowFile( Idx: integer );
    procedure ClearShadowFiles;

    property Connection: TIB_Connection read FConnection write SetConnection;
    property Transaction: TIB_Transaction read FExtTransaction
      write SetTransaction;
    property RDBPrefix: string read FRDBPrefix write FRDBPrefix;
    property Problems: TStrings read FProblems;
    property Severity: TIB_DDLProblemLevel read GetSeverity;
    property ProblemCount[idx: TIB_DDLProblemLevel]: integer read GetProblemCount;
    property CodeOptions: TIB_DDLCodeOptions read FCodeOptions write FCodeOptions
      default [coSetGeneratorVal];

    property OwnerName: string read FOwnerName;
    property CharacterSetName: string read FCharacterSetName;
    property CharacterSetNormal: string read FCharacterSetNormal;
    property CharacterSetId: SmallInt read FCharacterSetId;
    property UserExceptionCount: Integer read FUserExceptionCount;
    property BaseLevel: Byte read FBaseLevel;
    property ODSVersion: Word read FODSVersion;
    property Dialect: SmallInt read FDialect;
    property SecondaryFileCount: integer read GetSecondaryFileCount;
    property SecondaryFiles[Idx: integer]: TIB_DDLExtraFile read GetSecondaryFile;
    property ShadowFileCount: integer read GetShadowFileCount;
    property ShadowFiles[Idx: integer]: TIB_DDLExtraFile read GetShadowFile;

    property FBVersion: integer read FFBVersion;
    property FBBuild: integer read FFBBuild;
    property IBVersion: integer read FIBVersion;
    property IBBuild: integer read FIBBuild;
    property ServerPlatform: string read FPlatform;
    property BuildType: string read FBuildType;
    property BuildInfo: string read FBuildInfo;

    property OnDescription: TIB_DDLEntityDescriptionEvent read FOnDescription
      write FOnDescription;

  end;

{: Store database exception DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLException = class(TIB_DDLEntity)
  private
    FExceptionNumber: Integer;
    FMessage: string;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
      override;
    property ExceptionNumber: Integer read FExceptionNumber;
    property Message: string read FMessage;
  end;

{: Store blob filter DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLBlobFilter = class(TIB_DDLEntity)
  private
    FModuleName: string;
    FEntryPoint: string;
    FInputSubType: Smallint;
    FOutputSubType: SmallInt;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ModuleName: string read FModuleName;
    property EntryPoint: string read FEntryPoint;
    property InputSubType: smallint read FInputSubType;
    property OutputSubType: smallint read FOutputSubType;
  end;

{: Store generator DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLGenerator = class(TIB_DDLEntity)
  private
    FID: Smallint;
    FValue: ISC_INT64;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ID: Smallint read FID;
    property Value: ISC_INT64 read FValue;
  end;

{: Store domain DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLDomain = class(TIB_DDLEntity)
  private
    FValidationSource: string;
    FComputedSource: string;
    FDefaultSource: string;
    FFieldLength: SmallInt;
    FFieldScale: SmallInt;
    FFieldType: SmallInt;
    FFieldSubType: SmallInt;
    FSegmentLength: integer;//SmallInt; (we need unsigned smallint support)
    FExternalLength: integer;
    FExternalScale: SmallInt;
    FExternalType: SmallInt;
    FDimensions: SmallInt;
    FIsMandatory: Boolean;              //FNullFlag: SmallInt;
    FCharacterLength: SmallInt;
    FCollationId: SmallInt;
    FCharacterSetId: SmallInt;
    FFieldPrecision: SmallInt;
    FTypeName: string;
    FSubTypeName: string;
    FCharacterSetName: string;
    FCollationName: string;
    FIsNumericOrDecimal: Boolean;
    FBytesPerCharacter: SmallInt;
    FDimensionsLine: string;
    FIsArrayBased: Boolean;
    FIsExternalDomain: Boolean;
    FIsComputed: Boolean;
    FHaveImplicitField: boolean;
    FImplicitRelation: string;
    FImplicitField: string;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
    procedure AssignImplicitField;
    function GetImplicitRelation: string;
    function GetImplicitField:string;
    function GetImplicitDesc: string;
    function AddTypeCode(ACode: TIB_CodeFormatter): boolean;
    function AddCharSetCode(ACode: TIB_CodeFormatter; DoNewLine: boolean): boolean;
    function AddComputedCode(ACode: TIB_CodeFormatter; AsComment: boolean;
      DoNewLine: boolean): boolean;
    function AddDefaultCode(ACode: TIB_CodeFormatter; DefaultStr: string;
      DoNewLine: boolean): boolean;
    function AddMandatoryCode(ACode: TIB_CodeFormatter; NewMandatory: boolean;
      DoNewLine: boolean): boolean;
    function AddCheckCode(ACode: TIB_CodeFormatter; ACheckStr: string;
      DoNewLine: boolean): boolean;
    function AddCollationCode(ACode: TIB_CodeFormatter; NewCID: smallint;
      NewCName: string; DoNewLine: boolean): boolean;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ValidationSource: string read FValidationSource;
    property ComputedSource: string read FComputedSource;
    property DefaultSource: string read FDefaultSource;
    property FieldLength: SmallInt read FFieldLength;
    property FieldScale: SmallInt read FFieldScale;
    property FieldType: SmallInt read FFieldType;
    property FieldSubType: SmallInt read FFieldSubType;
    property SegmentLength: integer read FSegmentLength;
    property ExternalLength: integer read FExternalLength;
    property ExternalScale: SmallInt read FExternalScale;
    property ExternalType: SmallInt read FExternalType;
    property Dimensions: SmallInt read FDimensions;
    property IsMandatory: Boolean read FIsMandatory;
    property CharacterLength: SmallInt read FCharacterLength;
    property CollationId: SmallInt read FCollationId;
    property CharacterSetId: SmallInt read FCharacterSetId;
    property FieldPrecision: SmallInt read FFieldPrecision;
    property TypeName: string read FTypeName;
    property SubTypeName: string read FSubTypeName;
    property CharacterSetName: string read FCharacterSetName;
    property CollationName: string read FCollationName;
    property IsNumericOrDecimal: Boolean read FIsNumericOrDecimal;
    property BytesPerCharacter: SmallInt read FBytesPerCharacter;
    property DimensionsLine: string read FDimensionsLine;
    property IsArrayBased: Boolean read FIsArrayBased;
    property IsExternalDomain: Boolean read FIsExternalDomain;
    property IsComputed: Boolean read FIsComputed;
    property ImplicitRelation: string read GetImplicitRelation;
    property ImplicitField: string read GetImplicitField;
  end;

{: Store UDF DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLUDF = class(TIB_DDLEntity)
  private
    FFunctionType: Smallint;
    FModuleName: string;
    FEntryPoint: string;
    FReturnArgumentPos: SmallInt;
    FParams: TStringList;
  protected
    procedure BuildParamList;
    function GetEntityList(EType: TIB_EntityType): TStringList; override;
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property FunctionType: SmallInt read FFunctionType;
    property ModuleName: string read FModuleName;
    property EntryPoint: string read FEntryPoint;
    property ReturnArgumentPos: SmallInt read FReturnArgumentPos;
  end;

{: Base class for entities that support permissions.
See TIB_CustomMetadata for more details.}
  TIB_DDLEntityWithPermit = class(TIB_DDLEntity)
  private
    FPermissions: TStringList;
  protected
    procedure BuildPermissionList;
    function GetEntityList(EType: TIB_EntityType): TStringList; override;
  public
    procedure Reset; override;
  end;

{: Store stored procedure DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLProcedure = class(TIB_DDLEntityWithPermit)
  private
    FProcedureId: SmallInt;
    FProcedureInputs: SmallInt;
    FProcedureOutputs: SmallInt;
    FProcedureSource: string;
    FProcedureBlr: string;
    FSecurityClass: string;
    FOwnerName: string;
    //FRuntime: String;
    FIsBinaryProcedure: Boolean;
    FIsFaultyProcedure: Boolean;
    FParams: TStringList;
  protected
    procedure BuildParamList;
    function GetEntityList(EType: TIB_EntityType): TStringList; override;
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ProcedureId: SmallInt read FProcedureId;
    property ProcedureInputs: SmallInt read FProcedureInputs;
    property ProcedureOutputs: SmallInt read FProcedureOutputs;
    property ProcedureSource: string read FProcedureSource;
    property ProcedureBlr: string read FProcedureBlr;
    property SecurityClass: string read FSecurityClass;
    property OwnerName: string read FOwnerName;
    property IsBinaryProcedure: Boolean read FIsBinaryProcedure;
    property IsFaultyProcedure: Boolean read FIsFaultyProcedure;
  end;

{: Store role DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLRole = class(TIB_DDLEntityWithPermit)
  private
    FOwnerName: string;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property OwnerName: string read FOwnerName;
  end;

{: Base class to manage all entities that support triggers
See TIB_CustomMetadata for more details.}
  TIB_DDLEntityWithTrigger = class(TIB_DDLEntityWithPermit)
  // and also with Fields
  private
    FFields: TStringList;
    FTriggers: TStringList;
  protected
    procedure BuildFieldList;
    procedure BuildTriggerList;
    function GetEntityList(EType: TIB_EntityType): TStringList; override;
  public
    procedure Reset; override;
  end;

{: Store table DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLTable = class(TIB_DDLEntityWithTrigger)
  private
    FPrimaryKeys: TStringList;
    FUniqueKeys: TStringList;
    FForeignKeys: TStringList;
    FConstraints: TStringList;
    FIndexes: TStringList;
    FIndexDupList: TStringList;

    FViewBlr: string;
    FViewSource: string;
    FRelationId: SmallInt;
    FDbkeyLength: SmallInt;
    FFormatVersion: SmallInt;
    FFieldCount: SmallInt;
    FSecurityClass: string;
    FExternalFile: string;
    FOwnerName: string;
    FDefaultClass: string;
    FFlags: SmallInt;
    FViewCount: Integer;
    FIsExternal: Boolean;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
    procedure CreateConstraintCsr;
    procedure BuildPrimaryKeyList;
    procedure BuildUniqueKeyList;
    procedure BuildForeignKeyList;
    procedure BuildConstraintList;
    procedure BuildIndexList;
    function GetEntityList(EType: TIB_EntityType): TStringList; override;
    function AddIndexDef(fldlist: string): boolean;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ViewBlr: string read FViewBlr;
    property ViewSource: string read FViewSource;
    property RelationId: SmallInt read FRelationId;
    property DbkeyLength: SmallInt read FDbkeyLength;
    property FormatVersion: SmallInt read FFormatVersion;
    property FieldCount: SmallInt read FFieldCount;
    property SecurityClass: string read FSecurityClass;
    property ExternalFile: string read FExternalFile;
    property OwnerName: string read FOwnerName;
    property DefaultClass: string read FDefaultClass;
    property Flags: SmallInt read FFlags;
    property ViewCount: Integer read FViewCount;
    property IsExternal: Boolean read FIsExternal write FIsExternal;
  end;

{: Store view DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLView = class(TIB_DDLEntityWithTrigger)
  private
    FViewBlr: string;
    FViewSource: string;
    FRelationId: SmallInt;
    FDbkeyLength: SmallInt;
    FFormatVersion: SmallInt;
    FFieldCount: SmallInt;
    FSecurityClass: string;
    FExternalFile: string;
    FOwnerName: string;
    FDefaultClass: string;
    FFlags: SmallInt;
    FViewCount: Integer;
    FIsBinaryView: Boolean;
    FIsFaultyView: Boolean;
    FRelationCount: SmallInt;
    function CompleteWithCheckOption: Boolean;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ViewBlr: string read FViewBlr;
    property ViewSource: string read FViewSource;
    property RelationId: SmallInt read FRelationId;
    property DbkeyLength: SmallInt read FDbkeyLength;
    property FormatVersion: SmallInt read FFormatVersion;
    property FieldCount: SmallInt read FFieldCount;
    property SecurityClass: string read FSecurityClass;
    property ExternalFile: string read FExternalFile;
    property OwnerName: string read FOwnerName;
    property DefaultClass: string read FDefaultClass;
    property Flags: SmallInt read FFlags;
    property ViewCount: Integer read FViewCount;
    property IsBinaryView: Boolean read FIsBinaryView;
    property IsFaultyView: Boolean read FIsFaultyView;
    property RelationCount: SmallInt read FRelationCount;
  end;

{: Store index DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLIndex = class(TIB_DDLEntity)
  private
    FRelationName: string;
    FIndexId: SmallInt;
    FIsUnique: Boolean;                 // FUniqueFlag: SmallInt;
    FSegmentCount: SmallInt;
    FIndexInactive: Boolean;            //FIndexInactive: SmallInt;
    FIsAscending: Boolean;              //FIndexType: SmallInt;
    FForeignKey: string;
    FIndexConstraintCount: SmallInt;
    FIndexFKeyCount: SmallInt;
    FFieldsList: TStrings;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property RelationName: string read FRelationName;
    property IndexId: SmallInt read FIndexId;
    property IsUnique: Boolean read FIsUnique write FIsUnique;
    property SegmentCount: SmallInt read FSegmentCount;
    property IndexInactive: Boolean read FIndexInactive;
    property IsAscending: Boolean read FIsAscending;
    property ForeignKey: string read FForeignKey;
    property IndexConstraintCount: SmallInt read FIndexConstraintCount;
    property IndexFKeyCount: SmallInt read FIndexFKeyCount;
    property FieldsList: TStrings read FFieldsList;
  end;

{: Base class to manage all constraint entities.
See TIB_CustomMetadata for more details.}
  TIB_DDLConstraintBase = class(TIB_DDLEntity)
  private
    FRelationName: string;
    FIndexName: string;
    FForeignTable: string;
    FForeignIndex: string;
    FIsFaultyConstraint: Boolean;
    FIsAutoNamed: boolean;
    function GetIndex: TIB_DDLIndex;
  protected
    FConstraintTypeName: string;
    FConstNameUq: string;
    FTriggerOrFieldName: string;
    FRelationUq: string;
    FUpdateRuleName: string;
    FDeleteRuleName: string;
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
    property ForeignTable: string read FForeignTable;
    property ForeignIndex: string read FForeignIndex;
  public
    procedure Reset; override;
    property Index: TIB_DDLIndex read GetIndex;
    property RelationName: string read FRelationName;
    property IndexName: string read FIndexName;
    property IsFaultyConstraint: Boolean read FIsFaultyConstraint;
    property IsAutoNamed: boolean read FIsAutoNamed;
  end;

{: Store primary key DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLPrimaryKey = class(TIB_DDLConstraintBase)
  public
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ConstraintTypeName: string read FConstraintTypeName;
    property ConstNameUq: string read FConstNameUq;
    property TriggerOrFieldName: string read FTriggerOrFieldName;
    property RelationUq: string read FRelationUq;
  end;

{: Store unique key DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLUniqueKey = class(TIB_DDLConstraintBase)
  public
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ConstraintTypeName: string read FConstraintTypeName;
    property ConstNameUq: string read FConstNameUq;
    property TriggerOrFieldName: string read FTriggerOrFieldName;
    property RelationUq: string read FRelationUq;
  end;

{: Store foreign key DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLForeignKey = class(TIB_DDLConstraintBase)
  public
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ConstraintTypeName: string read FConstraintTypeName;
    property ConstNameUq: string read FConstNameUq;
    property UpdateRuleName: string read FUpdateRuleName;
    property DeleteRuleName: string read FDeleteRuleName;
    property TriggerOrFieldName: string read FTriggerOrFieldName;
    property RelationUq: string read FRelationUq;
  end;

{: Store constraint DDL description (other than primary key, unique key and
foreign keys which have their own specialised classes).
See TIB_CustomMetadata for more details.}
  TIB_DDLConstraint = class(TIB_DDLConstraintBase)
  public
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property ConstraintTypeName: string read FConstraintTypeName;
    property ConstNameUq: string read FConstNameUq;
    property TriggerOrFieldName: string read FTriggerOrFieldName;
    property RelationUq: string read FRelationUq;
  end;

{: Store trigger DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLTrigger = class(TIB_DDLEntityWithPermit)
  private
    FRelationName: string;
    FTriggerSequence: SmallInt;
    FTriggerType: SmallInt;
    FTriggerSource: string;
    FTriggerBlr: string;
    FTriggerInactive: Boolean;
    FTriggerUsageCount: SmallInt;
    FTriggerFullUsageCount: SmallInt;
    FTriggerCheckCount: SmallInt;
    FIsForView: Boolean;
    FIsBinaryTrigger: Boolean;
    FIsFaultyTrigger: Boolean;
    procedure WipeOutAS;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
    function AddTriggerCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property RelationName: string read FRelationName;
    property TriggerSequence: SmallInt read FTriggerSequence;
    property TriggerType: SmallInt read FTriggerType;
    property TriggerSource: string read FTriggerSource;
    property TriggerBlr: string read FTriggerBlr;
    property TriggerInactive: Boolean read FTriggerInactive;
    property TriggerUsageCount: SmallInt read FTriggerUsageCount;
    property TriggerFullUsageCount: SmallInt read FTriggerFullUsageCount;
    property TriggerCheckCount: SmallInt read FTriggerCheckCount;
    property IsForView: Boolean read FIsForView;
    property IsBinaryTrigger: Boolean read FIsBinaryTrigger;
    property IsFaultyTrigger: Boolean read FIsFaultyTrigger;
  end;

{: Store permission DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLPermission = class(TIB_DDLEntity)
  private
    //FGrantor: String; => FName
    FUserName: string;
    FUserType: SmallInt;
    FObjectName: string; // why FRelationName if it can contain a proc'name?
    FObjectType: SmallInt;
    FGrantOrAdminOption: Boolean;
    FPrivilege: string;
    FFieldName: string;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property UserName: string read FUserName;
    property UserType: SmallInt read FUserType;
    property ObjectName: string read FObjectName;
    property ObjectType: SmallInt read FObjectType;
    property GrantOrAdminOption: Boolean read FGrantOrAdminOption;
    property Privilege: string read FPrivilege;
    property FieldName: string read FFieldName;
  end;

{: Store UDF Parameter DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLUDFParam = class(TIB_DDLEntity)
  private
    FFunctionName: string;
    FArgumentPosition: SmallInt;
    FMechanism: SmallInt;
    FFieldType: SmallInt;
    FFieldScale: SmallInt;
    FFieldLength: SmallInt;
    FFieldSubType: SmallInt;
    FCharacterSetId: SmallInt;
    FFieldPrecision: SmallInt;
    FCharacterLength: SmallInt;
    FTypeName: string;
    FSubTypeName: string;
    FCharacterSetName: string;
    //FCollationName: String;
    FIsNumericOrDecimal: Boolean;
    FBytesPerCharacter: SmallInt;
    FIsOutputParameter: Boolean;
    FIsFreeIt: Boolean;
    FPositionalReturn: Boolean;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
    function GetParamDesc: string;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    function AddCodeReturns(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
    property FunctionName: string read FFunctionName;
    property ArgumentPosition: SmallInt read FArgumentPosition;
    property Mechanism: SmallInt read FMechanism;
    property FieldType: SmallInt read FFieldType;
    property FieldScale: SmallInt read FFieldScale;
    property FieldLength: SmallInt read FFieldLength;
    property FieldSubType: SmallInt read FFieldSubType;
    property CharacterSetId: SmallInt read FCharacterSetId;
    property FieldPrecision: SmallInt read FFieldPrecision;
    property CharacterLength: SmallInt read FCharacterLength;
    property TypeName: string read FTypeName;
    property SubTypeName: string read FSubTypeName;
    property CharacterSetName: string read FCharacterSetName;
    property IsNumericOrDecimal: Boolean read FIsNumericOrDecimal;
    property BytesPerCharacter: SmallInt read FBytesPerCharacter;
    property IsOutputParameter: Boolean read FIsOutputParameter;
    property IsFreeIt: Boolean read FIsFreeIt;
    property PositionalReturn: Boolean read FPositionalReturn;
  end;

{: Store table field DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLTableField = class(TIB_DDLEntity)
  private
    FFieldSource: string;
    FTableName: string;
    //FQueryName: String; => useless.
    FBaseField: string;
    FFieldPosition: SmallInt;
    FFieldId: SmallInt;
    FViewContext: SmallInt;
    FSecurityClass: string;
    FIsMandatory: Boolean;              //NullFlag: SmallInt;
    FBaseFieldWasEmpty: Boolean;        // Not available as property.
    FViewContextWasEmpty: Boolean;      // Not available as property.
    FDefaultSource: string;
    FCollationId: SmallInt;
    FCollationName: string;
    FOverridesMandatory: Boolean;
    FOverridesDefault: Boolean;
    FOverridesCollation: Boolean;
    FExternalDepends: boolean;
    function GetDomain: TIB_DDLDomain;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property FieldSource: string read FFieldSource;
    property TableName: string read FTableName;
    //property QueryName: String read           FQueryName; => of no use
    property BaseField: string read FBaseField;
    property FieldPosition: SmallInt read FFieldPosition;
    property FieldId: SmallInt read FFieldId;
    property ViewContext: SmallInt read FViewContext;
    property SecurityClass: string read FSecurityClass;
    property IsMandatory: Boolean read FIsMandatory;
    property DefaultSource: string read FDefaultSource;
    property CollationId: SmallInt read FCollationId;
    property CollationName: string read FCollationName;
    property OverridesMandatory: Boolean read FOverridesMandatory;
    property OverridesDefault: Boolean read FOverridesDefault;
    property OverridesCollation: Boolean read FOverridesCollation;
    property ExternalDepends: boolean read FExternalDepends;
    property Domain: TIB_DDLDomain read GetDomain;
  end;

{: Store view field DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLViewField = class(TIB_DDLEntity)
  private
    FFieldSource: string;
    FViewName: string;
    //FQueryName: String; => useless.
    FBaseField: string;
    FFieldPosition: SmallInt;
    FFieldId: SmallInt;
    FViewContext: SmallInt;
    FSecurityClass: string;
    FIsMandatory: Boolean;              //NullFlag: SmallInt;
    FBaseFieldWasEmpty: Boolean;        // Not available as property.
    FViewContextWasEmpty: Boolean;      // Not available as property.
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property FieldSource: string read FFieldSource;
    property ViewName: string read FViewName;
    //property QueryName: String read           FQueryName; => of no use
    property BaseField: string read FBaseField;
    property FieldPosition: SmallInt read FFieldPosition;
    property FieldId: SmallInt read FFieldId;
    property ViewContext: SmallInt read FViewContext;
    property SecurityClass: string read FSecurityClass;
    property IsMandatory: Boolean read FIsMandatory;
  end;

{: Store stored procedure parameter DDL description.
See TIB_CustomMetadata for more details.}
  TIB_DDLProcParam = class(TIB_DDLEntity)
  private
    FFieldSource: string;
    FProcedureName: string;
    //FParameterName: String; => Name
    FParameterNumber: SmallInt;
    FParameterType: SmallInt;
    FIsInputParameter: Boolean;
    FIsOutputParameter: Boolean;
    function GetDomain: TIB_DDLDomain;
  protected
    function GetCursor: TIB_Cursor; override;
    procedure AssignFromFields(ARow: TIB_Row); override;
  public
    procedure Reset; override;
    function AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer; override;
    property FieldSource: string read FFieldSource;
    property ProcedureName: string read FProcedureName;
    property ParameterNumber: SmallInt read FParameterNumber;
    property ParameterType: SmallInt read FParameterType;
    property IsInputParameter: Boolean read FIsInputParameter;
    property IsOutputParameter: Boolean read FIsOutputParameter;
  end;


// ---------------------------------------------------------------------------
// Interface details for the actual TIB_Metadata component

type
{: Enumeration of types that can be specified in the extract functions of
TIB_Metadata and related classes.
See TIB_CustomMetadata for more details.}
  TIB_DDLExtractType = etDatabase..etPermission;
  TIB_DDLExtractTypes = set of TIB_DDLExtractType;

const
{: Constant containing all valid extract types.}
  IB_DDLExtractTypes: TIB_DDLExtractTypes = [etDatabase..etPermission];
{: Constant containing all level 1 extract types.}
  IB_DDLExtractL1Types: TIB_DDLExtractTypes = [etDatabase..etRole];
{: Constant containing all level 2 extract types.}
  IB_DDLExtractL2Types: TIB_DDLExtractTypes = [etPrimaryKey..etPermission];
{: Constant containing extract types that do not require cpInit code pass.
(Used for optimisation of extract requests.)}
  IB_DDLNoInitEntityTypes: TIB_DDLExtractTypes = [
    etPrimaryKey,
    etUniqueKey,
    etIndex,
    etForeignKey,
    etConstraint,
    etTrigger,   // views may generate trigger "init" code but do so directly
    etPermission];
{: Constant containing extract types that do not require cpFinal code pass.
(Used for optimisation of extract requests.)}
  IB_DDLNoFinalEntityTypes: TIB_DDLExtractTypes = [
      etDatabase,
      etException,
      etBlobFilter,
      etUDF,
      etGenerator];


type

  TIB_CustomMetadata = class;

  TIB_DDLFilterByNameEvent = procedure(Sender: TIB_CustomMetadata;
    AType: TIB_EntityType; AName: string;
    var AInclude: boolean) of object;

  TIB_DDLFilterByEntityEvent = procedure(Sender: TIB_CustomMetadata;
    AType: TIB_EntityType; AEntity: TIB_DDLEntity;
    var AInclude: boolean) of object;

  TIB_DDLProgressEvent = procedure(Sender: TIB_CustomMetadata;
    var Proceed: boolean) of object;

  TIB_DDLHasDescriptionEvent = procedure(Sender: TIB_CustomMetadata;
    AType: TIB_EntityType; AEntity: TIB_DDLEntity) of object;

  TIB_DDLDefineFilesEvent = procedure(Sender: TIB_CustomMetadata;
    ADatabase: TIB_DDLDatabase) of object;

{: Enumeration used to indicate whether commits should be inserted into
the extracted DDL.}
  TIB_DDLInsertCommit = (
    icAfterInitPass,   // After cpInit pass
    icAfterFinalPass,  // After cpFinal pass
    icAfterLevel1,     // After processing Level1 entities
    icAfterLevel2,     // After processing Level2 entities
    icAfterEachType ); // After every entity type

  TIB_DDLInsertCommits = set of TIB_DDLInsertCommit;


{ This class is used to extract Metadata SQL DDL (data definition language)
from the specified connection.
<br>
You can manage which entities are extracted using the CodeOptions and Entities
properties and also the OnFilter* events.<br>
<br>
The CodePass property can be used to have DDL extracted as two separate
Init and Final sections (rather than all at once).  The Auto option produces
the Init and Final scripts together.  The result is script with a minimal
number of dependency problems.<br>
<br>
In most instances entities are extracted in alphabetic order within each
category of entity, however special processing is performed against views so
that they will be listed in the order of dependency. (If VIEWA depends on
VIEWB then VIEWB will be listed first.)<br>
<br>
The component offers basic filtering capabilities (OnFilterByName and
OnFilterByEntity) to allow various parts of the database to be extracted
more specifically.  Note that these filters do not attempt to do any
sophisticated dependency checking. For example; if you filter out ProcedureA
it will not check whether this procedure is needed by other procedures or
triggers that you have not filtered.  However it will (by default)
automatically exclude triggers and permissions etc that apply to filtered
entities.  (See also the coIgnoreDependencies option of the CodeOptions.)<br>
<br>
<br>
Note that, by default, the script will use only SQL DDL statements to construct
the various database entities.  For various reasons (such as reliability of
explicit plans) some developers perform unsupported direct updates of the
metadata tables to construct constraints with specially named indexes (rather
than the automatic names usually provided).  Such names will be lost with the
default script generated by this component.  To have this component attempt to
maintain these names (by generating direct metadata updates rather than SQL DDL
statements) check the coKeepCustomIndexNames option.
<br>
<br>
The CodePass cpFull option produces a more traditional metadata extract, where
all entities are defined in full with little regard for dependency between
entities.  For example entire procedures are defined in one hit, without
regard for whether other procedures that it calls have already been defined.
This is useful to see what is in the database, it is not very useful for
producing a script for execution.<br>
<br>
You can use the other CodePass options to create a more useful DDL script.
Either a single script (to create the definition all at once) or a script that
is split into different parts.<br>
<br>
To create a single script that will recreate the entire database structure
you would select all entity types from the Entities property.  Then set
the CodePass to cpAuto and call ExtractToStrings.  Internally this will call
cpInit for all entities, and then cpFinal for all entities resulting in a
single script that should be able recreate the entire database structure.<br>
<br>
If you want to be able to transfer data into your new database you may prefer
to create two separate scripts.  The first script you run to prepare the
database for data (but not install any constraints for triggers), the second
script you run after performing your data transfer to complete the
database.<br>
<br>
To produce the first script select all Entities in the range etDatabase to
etRole (and clear all other selections).  Set CodePass = cpAuto and then
call ExtractToStrings.  This will produce the script needed to initialise your
database - remember that this script does NOT install any real triggers (it
may install some dummy triggers for views) so any data transfers that you do
must be done directly against tables and will not have any trigger actions
applied. (This can be good or bad depending on what you want.)<br>
<br>
To preduce the second script select all Entities in the range etPrimaryKey to
etPermission (and clear all other selections).  Set CodePass = cpAuto and
then call ExtractToStrings.  This will produce the script needed to complete
the database definition.<br>
<br>
Note that you can use the cpInit and cpFinal CodePass options directly if
you want to extract separately parts of the code that normally appear in
one script using cpAuto.<br>
<br>
<br>
WARNING: The component attempts to resolve most dependancies between objects
when you use the cpInit and cpFinal code pass mechanism.  However some problems
can still occur, resulting in script errors if the entities are not created in
the correct order.<br>
<br>
For example; If you have a computed field that performs a select on a table
or view then it will not be defined during a cpInit CodePass (but will be
defined as an ALTER TABLE statement during cpFinal CodePass).  If you also
happen to have another computed field, or a view, which references that
field then that definition will fail (and need to be reapplied later.)<br>
<br>
If you experience such a problem then you may need to edit your script to move
the offending definitions.  To assist with editing the script you can use the
coIsolateAllComputed option, which ensures that all computed fields (not just
those containing embedded selects) are isolated into their own ALTER TABLE
statements in the cpFinal CodePass.  This allows you to manually move computed
field definitions within the script if necessary to work around dependency
problems.  Note that any views that depend on computed columns will fail to
be created unless the necessary computed field statements are moved in front
of the offending CREATE VIEW statements.<br>
<br>
The special handling of computed columns using coIsolateAllComputed option was
provided because it is computed columns that cause the most difficulty in
regard to dependency issues.  You can avoid such difficulties by being very
careful with your computed field declarations.  For example; Dont use embedded
selects in computed fields, if such access is required provide it via a view.
I also recommend that you dont write computed fields that reference other
computed fields.<br>
<br>
NOTE:  It is possible to setup the TIB_Script component so that it catches the
failing statements and retries them when the remainder of the script has
completed, repeating this process until all statements succeed or no progress
is made (in which case you have a permanent problem that needs to be fixed).
Via this process it is usually possible to successfully execute an entire
script produced by this component without editing to resolve dependency
problems - but you may need to turn on the coIsolateAllComputed to make it
work.<br>
<br>
<br>
<br>
Technical Notes:<br>
<br>
TIB_CustomMetadata is essentially just a wrapper around the TIB_DDLDatabase
class, which is setup to extract and hold all the relevant metadata details in
internal lists. This information is then accessed to generate the necessary
SQL code.<br>
<br>
The process extracts and stores the metadata information in a heirarchy of
metadata definition objects where...<br>
<br>
- Level 0: the database itself<br>
<br>
- Level 1: entities that can be extracted directly from the database
without reference to other entities.  There may be dependancies
between the objects but these will be handled separately.<br>
<br>
- Level 2: entities that are those that are created in reference to another
entity.  That is, the entities are really subordinate to a parent.
Such things as indexes, constraints and permissions.<br>
<br>
- Level 3: entities that are an integral part of another entity definition
(what claudio referred to as Params).  These should not normally
be extracted directly but left as part of the owning entity
definition.<br>
<br>
The above represents the instantiation heirarchy.  The class heirarchy is
designed according to the matching property intersections.}
  TIB_CustomMetadata = class(TComponent)
  private
    FDatabase: TIB_DDLDatabase;
    FCode: TIB_CodeFormatter;
    FCodePass: TIB_DDLCodePassBase;
    FInsertCommits: TIB_DDLInsertCommits;
    FInternalPass: TIB_DDLCodePass;
    FL1List: TList;
    FEntities: TIB_DDLExtractTypes;
    FShowProblems: boolean;
    FOnProgress: TIB_DDLProgressEvent;
    FOnFilterByName: TIB_DDLFilterByNameEvent;
    FOnFilterByEntity: TIB_DDLFilterByEntityEvent;
    FOnHasDescription: TIB_DDLHasDescriptionEvent;
    FOnDefineFiles: TIB_DDLDefineFilesEvent;

    FRunning: boolean;
    FTypeCount: integer;
    FTypesDone: integer;
    FCurrType: TIB_EntityType;
    FCurrEntity: TIB_DDLEntity;
    FCurrCount: integer;
    FCurrDone: integer;

    function GetConnection: TIB_Connection;
    procedure SetConnection(AVal: TIB_Connection);
    function GetTransaction: TIB_Transaction;
    procedure SetTransaction(AVal: TIB_Transaction);
    function GetRDBPrefix: string;
    procedure SetRDBPrefix(AVal: string);
    function IsRDBPrefixStored: boolean;
    function GetCodeOptions: TIB_DDLCodeOptions;
    procedure SetCodeOptions(AVal: TIB_DDLCodeOptions);
    function GetIntTerminator: string;
    procedure SetIntTerminator(AVal: string);
    function IsIntTerminatorStored: boolean;
    function GetTerminator: string;
    procedure SetTerminator(AVal: string);
    function IsTerminatorStored: boolean;
    function GetIndentSize: integer;
    procedure SetIndentSize(AVal: integer);
    function GetProblems: TStrings;
    function IsEntitiesStored: boolean;

  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function DoProgress: boolean;
    function GetProgressPerc: smallint;
    function IncludeEntityByName(AType: TIB_EntityType; AName: string): boolean;
    function IncludeEntityCode(AType: TIB_EntityType; AEntity: TIB_DDLEntity): boolean;
    procedure ExtractTypes(AEntities: TIB_DDLExtractTypes; AStrs: TStrings);
    function ExtractL1Type(AType: TIB_EntityType; AStrs: TStrings): boolean;
    function ExtractL2Type(AType: TIB_EntityType; AStrs: TStrings): boolean;
    procedure WriteProblems(AStrs: TStrings);
    procedure DoHasDescription( ADatabase: TIB_DDLDatabase;
      AType: TIB_EntityType; AEntity: TIB_DDLEntity );

    property Database: TIB_DDLDatabase read FDatabase;
    property Problems: TStrings read GetProblems;

    // TIB_DDLDatabase properties
{: The connection from which the metadata is extracted.}
    property IB_Connection: TIB_Connection read GetConnection
      write SetConnection;
{: If defined then this is the transaction used during extract processing.
If not defined then the component will create its own internal (tiConcurrency)
transaction from which to perform the extract.}
    property IB_Transaction: TIB_Transaction read GetTransaction
      write SetTransaction;
{: The standard IB/FB metadata object name prefix - should always be 'RDB$'.}
    property RDBPrefix: string read GetRDBPrefix write SetRDBPrefix
      stored IsRDBPrefixStored;
{: Options to control the output DDL script.  See the explanation for the
TIB_DDLCodeOption type for details.}
    property CodeOptions: TIB_DDLCodeOptions read GetCodeOptions
      write SetCodeOptions default [coSetGeneratorVal];
{: Controls how much script is generated in a particular pass through the
metadata.  The cpFull option is similar to what you will have found in other
extract utilities - everything is extracted without much regard for whether
one object is dependant on another.  Such scripts are good for viewing what
is defined in the database, but pretty useless as a script to create a
new database.<br>
<br>
The cpInit, cpFinal and cpAuto CodePass options can be used to generate a DDL
script with minimal dependency problems.  Please
<See class=TIB_CustomMetadata> for more information on how to use
these features.}
    property CodePass: TIB_DDLCodePassBase read FCodePass write FCodePass
      default cpFull;
{: The component will insert COMMIT statements into the script at various
intervals.}
    property InsertCommits: TIB_DDLInsertCommits read FInsertCommits
      write FInsertCommits default [];
    // TIB_DDLCode properties
{: What terminator character to use inside procedures and triggers.  This
only applies to lines created by this script, it cannot change what is
defined inside existing procedures and triggers - so this property should
normally remain as the default (';') }
    property IntTerminator: string read GetIntTerminator write SetIntTerminator
      stored IsIntTerminatorStored;
{: What terminator character to use for primary DDL statements.}
    property Terminator: string read GetTerminator write SetTerminator
      stored IsTerminatorStored;
{: What size indentation to use in the DDL script.}
    property IndentSize: integer read GetIndentSize write SetIndentSize
      default 2;
    // Local properties
{: When true then detected (possible) problems will be listed in a comment at
the bottom of the generated script.}
    property ShowProblems: boolean read FShowProblems write FShowProblems
      default true;
{: Control which types of entities to extract.}
    property Entities: TIB_DDLExtractTypes read FEntities write FEntities
      stored IsEntitiesStored;
{: Attach code here to update the client form to show progress.}
    property OnProgress: TIB_DDLProgressEvent read FOnProgress write FOnProgress;
{: Attach code here to filter the output according to entity name.
This event is called BEFORE OnFilterByEntity, at the time this event is called
only the name of the entity is known.  By filtering at this point you can
improve performance because the full details of the entity will not need to
be extracted.}
    property OnFilterByName: TIB_DDLFilterByNameEvent read FOnFilterByName
      write FOnFilterByName;
{: Attach code here to filter the extract (see also OnFilterByName).  When this
event is called the full entity detail is available for examination.}
    property OnFilterByEntity: TIB_DDLFilterByEntityEvent read FOnFilterByEntity
      write FOnFilterByEntity;
{: This event is called if there is descriptive text associated with a
particular entity.  You can use this store the information for later use
(such as re-inserting into a newly created database).}
    property OnHasDescription: TIB_DDLHasDescriptionEvent read FOnHasDescription
      write FOnHasDescription;
{: This event is called when the extract needs to define secondary and
shadow file information for the script.  You can use this to define new
secondary or shadow file details before the script writes the information.}
    property OnDefineFiles: TIB_DDLDefineFilesEvent read FOnDefineFiles
      write FOnDefineFiles;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

{: Used to extract cpInit and then cpFinal for the entities specified
in a single call (with appropriate progress indication).
ie. Ignores the Entities and CodePass properties of the component.<br>
<br>
Note that new code will be ADDED to the given AStrs parameter, so you may
need to clear the strings parameter before calling this method if you want
AStrs to contain just the code extracted by this single call. }
    procedure Extract(AInit, AFinal: TIB_DDLExtractTypes; AStrs: TStrings);
{: Used to extract cpFull for the entities specified
ie. Ignores the Entities and CodePass properties of the component.<br>
<br>
Note that new code will be ADDED to the given AStrs parameter, so you may
need to clear the strings parameter before calling this method if you want
AStrs to contain just the code extracted by this single call.}
    procedure ExtractFull(AEntities: TIB_DDLExtractTypes; AStrs: TStrings);
{: Extract code according to the Entities and CodePass properties
of the component.<br>
<br>
Note that new code will be ADDED to the given AStrs parameter, so you may
need to clear the strings parameter before calling this method if you want
AStrs to contain just the code extracted by this single call. }
    procedure ExtractToStrings(AStrs: TStrings);

{: Resets/clears the internal cache of DDL (but not the cached metadata
information).  Use this if you want to rerun the DDL generation with
different options. }
    procedure Reset;
{: Resets and clears all cached information.  Use this if you want to rerun
the DDL generation and force all information to be re-read from the database. }
    procedure ResetAll;

{: Whether an extract is currently in progress. }
    property Running: boolean read FRunning;
{: The type of the entity currently being processed.
Defined only while the ExtractCode procedure is running.
values reset on start - not on completion, so you can
tell where the processing finished.}
    property CurrType: TIB_EntityType read FCurrType;
{: The entity currently being processed.
Defined only while the ExtractCode procedure is running.
values reset on start - not on completion, so you can
tell where the processing finished.}
    property CurrEntity: TIB_DDLEntity read FCurrEntity;
{: ProgressPerc provides an approximate percentage completion value
(that is, a value between 0 and 100).  You can use this inside
the OnProgress event to get an idea of the progress.
It is very approximate, some parts will proceed quickly and others
more slowly. }
    property ProgressPerc: smallint read GetProgressPerc;

  end;



  TIB_Metadata = class(TIB_CustomMetadata)
  public
    property Database;

  published
    property IB_Connection;
    property IB_Transaction;
    property RDBPrefix;
    property CodeOptions;
    property CodePass;
    property InsertCommits;
    property IntTerminator;
    property Terminator;
    property IndentSize;
    property ShowProblems;
    property Entities;
    property OnProgress;
    property OnFilterByName;
    property OnFilterByEntity;
    property OnHasDescription;
    property OnDefineFiles;
  end;


function EntityTypeToText(EType: TIB_EntityType): string;
function CodeOptionToText(AOpt: TIB_DDLCodeOption): string;
function CodePassToText(APass: TIB_DDLCodePassBase): string;
function ProblemLevelToText(PLvl: TIB_DDLProblemLevel): string;
function ProblemLevelToShortText(PLvl: TIB_DDLProblemLevel): string;
function GetTypeFromEntity(AEntity: TIB_DDLEntity): TIB_EntityType;
function MatchingPrefix(AName, APrefix: string): boolean;
function ReplacePrefix(AName, APrefix, BPrefix: string): string;


implementation

uses IB_Parse,
  IB_Constants;


// Since not all IBO supported versions of Delphi/BCB have the FreeAndNil
// I use this small utility - its much simpler that writing this time and
// time again through the code.  Note that due to the way most of this
// code is constructed the check for Assigned is needed.
procedure FreeObj( var Obj );
begin
  if Assigned(TObject(Obj)) then
  begin
    TObject(Obj).Free;
    TObject(Obj) := nil;
  end;
end;

// ---------------------------------------------------------------------------
// Implementation details for the supporting metadata extract classes
// (see below for actual TIB_Metadata component).


function FieldTypeAsChar(FFieldType: SmallInt; FTypeName: string): string;
begin
  Result := 'UNKNOWN';
  case FFieldType of
    7: Result := 'SMALLINT';
    8: Result := 'INTEGER';
    14: Result := 'CHAR';
    16:
      if FTypeName = EmptyStr then
        Result := '_INT64'
      else
        Result := FTypeName;
    27: Result := FTypeName + ' PRECISION';
    37: Result := 'VARCHAR';
  else
    if FTypeName <> EmptyStr then
      Result := FTypeName
  end
end;

function AdjustField(FFieldType, FFieldSubType: SmallInt;
  var FFieldPrecision: SmallInt; var FTypeName: string;
  FSubTypeName: string; FFieldScale: SmallInt; var FIsNumericOrDecimal: Boolean;
  ProcessBLOB: Boolean; UseBigInt: boolean): string;
begin
  Result := 'UNKNOWN';
  case FFieldType of
    7, 8, 16, 27:
      begin
        case FFieldSubType of
          1:
            begin
              FTypeName := 'NUMERIC';
              FIsNumericOrDecimal := True;
            end;
          2:
            begin
              FTypeName := 'DECIMAL';
              FIsNumericOrDecimal := True;
            end;
        else
          if FFieldScale <> 0 then
          begin
            FTypeName := 'NUMERIC';
            FIsNumericOrDecimal := True;
          end;
        end;
        if FIsNumericOrDecimal and (FFieldPrecision = 0) then
          case FFieldType of
            7: FFieldPrecision := 4;
            8: FFieldPrecision := 9;
            16: FFieldPrecision := 18;
            27: FFieldPrecision := 15;
          end;
        if FIsNumericOrDecimal and (FFieldPrecision = 18) and
          (FFieldScale = 0) and UseBigInt then
        begin
          FTypeName := 'BIGINT';
          FIsNumericOrDecimal := false;
          FFieldPrecision := 0;
        end;
      end;
    261:
      if ProcessBlob then
      begin
        if (FFieldSubType > 0) and (FSubTypeName <> EmptyStr) then
          Result := FSubTypeName
        else
          if FFieldSubType = 0 then
            Result := '0'
          else
            Result := IntToStr(FFieldSubType);
      end;
  end;
end;

procedure FreeListAndObjects(var Strs: TStringList);
var
  ii: integer;
begin
  if Strs <> nil then
    for ii := 0 to Strs.Count - 1 do
    begin
      Strs.Objects[ii].Free;
      Strs.Objects[ii] := nil;
    end;
  FreeObj(Strs);
end;


constructor TIB_DDLEntity.Create(ADatabase: TIB_DDLDatabase; AParent:
  TIB_DDLEntity);
begin
  FDatabase := ADatabase;
  FParent := AParent;
  inherited Create;
  Reset;
end;

destructor TIB_DDLEntity.Destroy;
begin
  Reset;
  inherited Destroy;
end;

function TIB_DDLEntity.OutputName: string;
begin
  if NewName = '' then
    Result := Name
  else
    Result := NewName;
end;

function TIB_DDLEntity.GetCursor: TIB_Cursor;
begin
  Result := nil;
end;

procedure TIB_DDLEntity.AssignFromFields(ARow: TIB_Row);
begin
  // abstract
end;

procedure TIB_DDLEntity.Initialise(AName, AParent: string);
var
  tmpCsr: TIB_Cursor;
begin
  if Initialised then
    Reset;
  FName := AName;
  if Trim(FName) = EmptyStr then
    AddProblem(plError, E_DDL_BLANK_NAME);
  FInitialised := true;
  tmpCsr := GetCursor;
  if tmpCsr = nil then
  begin
    FInitialised := false;
    AddProblem(plError, E_DDL_CURSOR_NOT_CREATED);
  end
  else
  begin
    with tmpCsr do
    begin
      if Params.ColumnCount > 0 then
      begin
        if Params.ColumnCount > 1 then
        begin
          Params.Columns[0].AsString := AParent;
          Params.Columns[1].AsString := AName;
        end
        else
          Params.Columns[0].AsString := AName;
      end;
      APIFirst;
      if Eof then
        AddProblem(plError, E_DDL_ENTITY_NOT_FOUND)
      else
      begin
        AssignFromFields(tmpCsr.Fields);
        if (not SystemFlag) and (not IsImplicit) and
          MatchingPrefix(AName, IB_DefaultRDBPrefix) then
          AddProblem(plWarning, E_DDL_RESERVED_NAME);
      end;
    end;
  end;
end;

function TIB_DDLEntity.GetEntityList(EType: TIB_EntityType): TStringList;
begin
  Result := nil;
end;

function TIB_DDLEntity.GetEntityClass(EType: TIB_EntityType):
  TIB_DDLEntityClass;
begin
  Result := nil;
  case EType of
    etDatabase: Result := TIB_DDLDatabase;
    etException: Result := TIB_DDLException;
    etBlobFilter: Result := TIB_DDLBlobFilter;
    etUDF: Result := TIB_DDLUDF;
    etGenerator: Result := TIB_DDLGenerator;
    etDomain: Result := TIB_DDLDomain;
    etTable: Result := TIB_DDLTable;
    etView: Result := TIB_DDLView;
    etProcedure: Result := TIB_DDLProcedure;
    etRole: Result := TIB_DDLRole;
    etPrimaryKey: Result := TIB_DDLPrimaryKey;
    etUniqueKey: Result := TIB_DDLUniqueKey;
    etForeignKey: Result := TIB_DDLForeignKey;
    etConstraint: Result := TIB_DDLConstraint;
    etIndex: Result := TIB_DDLIndex;
    etTrigger: Result := TIB_DDLTrigger;
    etPermission: Result := TIB_DDLPermission;
    etUDFParam: Result := TIB_DDLUDFParam;
    etTableField: Result := TIB_DDLTableField;
    etViewField: Result := TIB_DDLViewField;
    etProcParam: Result := TIB_DDLProcParam;
  end;
end;

function TIB_DDLEntity.GetEntityCount(EType: TIB_EntityType): integer;
var
  tmpList: TStringList;
begin
  Result := 0;
  tmpList := GetEntityList(EType);
  if tmpList <> nil then
    Result := tmpList.Count;
end;

function TIB_DDLEntity.GetEntityName(EType: TIB_EntityType; Idx: integer):
  string;
var
  tmpList: TStringList;
begin
  Result := '';
  tmpList := GetEntityList(EType);
  if (tmpList <> nil) and (Idx >= 0) and (Idx < tmpList.Count) then
    Result := tmpList.Strings[Idx];
end;

function TIB_DDLEntity.GetEntity(EType: TIB_EntityType; Idx: integer):
  TIB_DDLEntity;
var
  tmpList: TStringList;
begin
  Result := nil;
  tmpList := GetEntityList(EType);
  if (tmpList <> nil) and (Idx >= 0) and (Idx < tmpList.Count) then
  begin
    Result := tmpList.Objects[Idx] as TIB_DDLEntity;
    if Result = nil then
    begin
      try
        Result := GetEntityClass(EType).Create(Database, Self);
        Result.Initialise(tmpList.Strings[Idx], Name);
        tmpList.Objects[Idx] := Result;
      except
        FreeObj( Result );
        raise;
      end;
    end;
  end;
end;

function TIB_DDLEntity.GetEntityByName(EType: TIB_EntityType; AName: string):
  TIB_DDLEntity;
var
  tmpList: TStringList;
  tmpIdx: integer;
begin
  Result := nil;
  tmpList := GetEntityList(EType);
  if tmpList.Sorted then
  begin
    if tmpList.Find(AName, tmpIdx) then
      Result := GetEntity(EType, tmpIdx);
  end
  else
  begin
    tmpIdx := tmpList.IndexOf(AName);
    if tmpIdx >= 0 then
      Result := GetEntity(EType, tmpIdx);
  end;
end;

procedure TIB_DDLEntity.AddDescription(ACode: TIB_CodeFormatter);
begin
  with ACode do
  begin
    if Length(Description) > 0 then
    begin
      Database.DoDescription( Self );
      if coDescripAsComment in Database.CodeOptions then
        AddWords(wtComment, Description, ttEndLine);
    end;
  end;
end;

function TIB_DDLEntity.RDB: string;
begin
  Result := Database.RDBPrefix;
end;

procedure TIB_DDLEntity.Reset;
begin
  FInitialised := false;
  FName := '';
  FNewName := '';
  FDescription := '';
  FSystemFlag := false;
  FIsImplicit := false;
end;

procedure TIB_DDLEntity.AddProblem(lvl: TIB_DDLProblemLevel; AStr: string);
begin
  Database.FProblemCounts[lvl] := Database.FProblemCounts[lvl] + 1;
  Database.Problems.Add('[' + ProblemLevelToShortText(lvl) + '] ' +
    EntityTypeToText(GetTypeFromEntity(Self)) + '.' + Name +
    ': ' + AStr);
end;

function TIB_DDLEntity.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := 0;                          // abstract
end;

function TIB_DDLEntity.MkIdent(AName: string): string;
begin
  if Database.Connection.SQLDialect >= 3 then
  begin
    if coAlwaysQuoted in Database.CodeOptions then
      Result := '"' + cvLitCriteria(AName, '"') + '"'
    else
      Result := Database.Connection.MkVarIdent(AName);
  end
  else
    Result := AnsiUpperCase(AName);
end;



constructor TIB_DDLDatabase.Create;
begin
  FConnection := nil;
  FIntTransaction := nil;
  FExtTransaction := nil;
  FRDBPrefix := IB_DefaultRDBPrefix;
  FProblems := TStringList.Create;
  inherited Create(Self, nil);
  FOwnerName := '';
  FCharacterSetName := '';
  FCharacterSetNormal := '';
  FCharacterSetId := 0;
  FUserExceptionCount := 0;
  FBaseLevel := 0;
  FODSVersion := 0;
  FVersionString := '';
  FDialect := 0;
  FFBVersion := 0;
  FFBBuild := 0;
  FIBVersion := 0;
  FIBBuild := 0;
  FPlatform := '';
  FBuildType := '';
  FBuildInfo := '';
  FCodeOptions := [coSetGeneratorVal];
end;

destructor TIB_DDLDatabase.Destroy;
begin
  FreeObj( FProblems );
  inherited;
end;

procedure TIB_DDLDatabase.SetConnection(AVal: TIB_Connection);
begin
  if AVal <> FConnection then
  begin
    Reset;
    FConnection := AVal;
  end;
end;

procedure TIB_DDLDatabase.SetTransaction(AVal: TIB_Transaction);
begin
  if AVal <> FExtTransaction then
  begin
    if AVal <> nil then
      Reset;
    FExtTransaction := AVal;
  end;
end;

function TIB_DDLDatabase.GetSecondaryFileCount: integer;
begin
  if FSecondaryFiles <> nil then
    Result := FSecondaryFiles.Count
  else
    Result := 0;
end;

function TIB_DDLDatabase.GetSecondaryFile(Idx: integer): TIB_DDLExtraFile;
begin
  if (FSecondaryFiles <> nil) and (Idx < FSecondaryFiles.Count) then
    Result := TIB_DDLExtraFile(FSecondaryFiles.Items[Idx])
  else
    Result := nil;
end;

procedure TIB_DDLDatabase.AddSecondaryFile( AName: string; ASequence: smallint;
  AStart: integer; ALength: integer; AFlags: smallint );
var
  tmpFile: TIB_DDLExtraFile;
  i: integer;
begin
  tmpFile := TIB_DDLExtraFile.Create;
  try
    tmpFile.Name := AName;
    tmpFile.Sequence := ASequence;
    tmpFile.Start := AStart;
    tmpFile.Length := ALength;
    tmpFile.Flags := AFlags;
    tmpFile.ShadowNumber := 0;
    if FSecondaryFiles = nil then
      FSecondaryFiles := TList.Create;
    // Insert the new item to maintain a specific order in the list
    // Ordering by: Sequence
    i := 0;
    while i < SecondaryFileCount do
    begin
      with SecondaryFiles[i] do
      begin
        if Sequence > ASequence then
          break;
      end;
      Inc( i );
    end;
    FSecondaryFiles.Insert( i, tmpFile );
  except
    FreeObj( tmpFile );
    raise;
  end;
end;

procedure TIB_DDLDatabase.RemoveSecondaryFile( Idx: integer );
begin
  if (FSecondaryFiles <> nil) and (Idx < FSecondaryFiles.Count) then
  begin
    SecondaryFiles[Idx].Free;
    FSecondaryFiles.Delete(Idx);
  end;
end;

procedure TIB_DDLDatabase.ClearSecondaryFiles;
begin
  while SecondaryFileCount > 0 do
    RemoveSecondaryFile( SecondaryFileCount - 1 );
  FreeObj( FSecondaryFiles );
end;

function TIB_DDLDatabase.GetShadowFileCount: integer;
begin
  if FShadowFiles <> nil then
    Result := FShadowFiles.Count
  else
    Result := 0;
end;

function TIB_DDLDatabase.GetShadowFile(Idx: integer): TIB_DDLExtraFile;
begin
  if (FShadowFiles <> nil) and (Idx < FShadowFiles.Count) then
    Result := TIB_DDLExtraFile(FShadowFiles.Items[Idx])
  else
    Result := nil;
end;

procedure TIB_DDLDatabase.AddShadowFile( AName: string; ASequence: smallint;
  AStart: integer; ALength: integer; AFlags: smallint; AShadow: smallint );
var
  tmpFile: TIB_DDLExtraFile;
  i: integer;
begin
  tmpFile := TIB_DDLExtraFile.Create;
  try
    tmpFile.Name := AName;
    tmpFile.Sequence := ASequence;
    tmpFile.Start := AStart;
    tmpFile.Length := ALength;
    tmpFile.Flags := AFlags;
    tmpFile.ShadowNumber := AShadow;
    if FShadowFiles = nil then
      FShadowFiles := TList.Create;
    // Insert the new item to maintain a specific order in the list
    // Ordering by: ShadowNumber, Sequence
    i := 0;
    while i < ShadowFileCount do
    begin
      with ShadowFiles[i] do
      begin
        if (ShadowNumber > AShadow) or
          ((ShadowNumber = AShadow) and (Sequence > ASequence)) then
          break;
      end;
      Inc( i );
    end;
    FShadowFiles.Insert( i, tmpFile );
  except
    FreeObj( tmpFile );
    raise;
  end;
end;

procedure TIB_DDLDatabase.RemoveShadowFile( Idx: integer );
begin
  if (FShadowFiles <> nil) and (Idx < FShadowFiles.Count) then
  begin
    ShadowFiles[Idx].Free;
    FShadowFiles.Delete(Idx);
  end;
end;

procedure TIB_DDLDatabase.ClearShadowFiles;
begin
  while ShadowFileCount > 0 do
    RemoveShadowFile( ShadowFileCount - 1 );
  FreeObj( FShadowFiles );
end;


function TIB_DDLDatabase.GetCursor: TIB_Cursor;
begin
  if FDatabaseCsr = nil then
  begin
    FDatabaseCsr := CreateCursor;
    with FDatabaseCsr do
    begin
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('R.RDB$OWNER_NAME,');
      SQL.Add('D.RDB$CHARACTER_SET_NAME,');
      SQL.Add('CS.RDB$CHARACTER_SET_NAME AS CHARSET_NORMAL,');
      SQL.Add('CS.RDB$CHARACTER_SET_ID,');
      SQL.Add('   (SELECT CAST(COUNT( * ) AS INTEGER) FROM ' + RDB +
        'EXCEPTIONS E');
      SQL.Add('   WHERE E.RDB$SYSTEM_FLAG IS NULL OR E.RDB$SYSTEM_FLAG = 0)');
      SQL.Add('   AS USER_EXCEPTION_COUNT,');
      SQL.Add('D.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'RELATIONS R JOIN ' + RDB + 'DATABASE D');
      SQL.Add('ON R.RDB$RELATION_NAME = ' + QuotedStr('RDB$DATABASE'));
      SQL.Add('LEFT JOIN (' + RDB + 'TYPES T JOIN ' + RDB +
        'CHARACTER_SETS CS');
      SQL.Add('   ON CS.RDB$CHARACTER_SET_ID = T.RDB$TYPE)');
      SQL.Add('ON T.RDB$TYPE_NAME = D.RDB$CHARACTER_SET_NAME');
      SQL.Add('AND RDB$FIELD_NAME = ' + QuotedStr('RDB$CHARACTER_SET_NAME'));
      Prepare;
    end;
  end;
  if FExtraFileCsr = nil then
  begin
    FExtraFileCsr := CreateCursor;
    with FExtraFileCsr do
    begin
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('M.RDB$FILE_NAME,');
      SQL.Add('M.RDB$FILE_SEQUENCE,');
      SQL.Add('M.RDB$FILE_START,');
      SQL.Add('M.RDB$FILE_LENGTH,');
      SQL.Add('M.RDB$FILE_FLAGS,');
      SQL.Add('M.RDB$SHADOW_NUMBER');
      SQL.Add('FROM ' + RDB + 'FILES M');
      SQL.Add('ORDER BY RDB$SHADOW_NUMBER, RDB$FILE_SEQUENCE');
      Prepare;
    end;
  end;
  Result := FDatabaseCsr;
end;

procedure TIB_DDLDatabase.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FOwnerName := Columns[0].AsString;
    FCharacterSetName := Columns[1].AsString;
    FCharacterSetNormal := Columns[2].AsString;
    FCharacterSetId := Columns[3].AsSmallInt;
    FUserExceptionCount := Columns[4].AsInteger;
    FDescription := Columns[5].AsString;
  end;
  if FCharacterSetName = EmptyStr then
  begin
    FCharacterSetName := 'NONE';
    FCharacterSetNormal := 'NONE';
  end
  else
  begin
    if FCharacterSetNormal = EmptyStr then
    begin
      AddProblem(plWarning,
        Format(E_DDL_DB_CHARSET_NOT_FOUND, [FCharacterSetName]));
      FCharacterSetNormal := FCharacterSetName;
    end;
  end;
  with Connection.Characteristics do
  begin
    FBaseLevel := dbBase_Level;         // byte
    FODSVersion := dbODS_Version;       // word
    FVersionString := dbVersion         // string
  end;
  if (FBaseLevel >= 6) or
    (Copy(FVersionString, 1, 2) = 'FB') or
    (FDialect > 1) then
    FDialect := ARow.Statement.SQLDialect
  else
    FDialect := -1;
  ExtractVersionInfo(FVersionString, Connection.Characteristics.dbFBVersion);
  // Also extract the details about the extra files...
  with FExtraFileCsr do
  begin
    // only one database - no parameters need to be set
    APIFirst;
    while not Eof do
    begin
      if Fields.Columns[5].AsSmallint = 0 then
        AddSecondaryFile(
          Fields.Columns[0].AsString,
          Fields.Columns[1].AsSmallint,
          Fields.Columns[2].AsInteger,
          Fields.Columns[3].AsInteger,
          Fields.Columns[4].AsSmallint )
      else
        AddShadowFile(
          Fields.Columns[0].AsString,
          Fields.Columns[1].AsSmallint,
          Fields.Columns[2].AsInteger,
          Fields.Columns[3].AsInteger,
          Fields.Columns[4].AsSmallint,
          Fields.Columns[5].AsSmallint );
      APINext;
    end;
  end;
end;

function TIB_DDLDatabase.GetEntityList(EType: TIB_EntityType): TStringList;
begin
  case EType of
    etException: Result := FExceptions;
    etBlobFilter: Result := FBlobFilters;
    etUDF: Result := FUDFs;
    etGenerator: Result := FGenerators;
    etDomain: Result := FDomains;
    etTable: Result := FTables;
    etView: Result := FViews;
    etProcedure: Result := FProcedures;
    etRole: Result := FRoles;
  else
    Result := inherited GetEntityList(EType);
  end;
  if (Result = nil) and
    (EType >= Low(TIB_L1EntityType)) and
    (EType <= High(TIB_L1EntityType)) then
  begin
    Result := BuildEntityList(EType);
    case EType of
      etException: FExceptions := Result;
      etBlobFilter: FBlobFilters := Result;
      etUDF: FUDFs := Result;
      etGenerator: FGenerators := Result;
      etDomain: FDomains := Result;
      etTable: FTables := Result;
      etView:
        begin
          FViews := Result;
          if FViews.Count > 1 then
            ResortViews( FViews );
        end;
      etProcedure: FProcedures := Result;
      etRole: FRoles := Result;
    end;
  end;
end;

function TIB_DDLDatabase.GetEntityListSQL(EType: TIB_EntityType): string;
begin
  case EType of
    etException:
      Result := 'SELECT M.RDB$EXCEPTION_NAME ' +
        'FROM ' + RDB + 'EXCEPTIONS M';
    etBlobFilter:
      Result := 'SELECT M.RDB$FUNCTION_NAME ' +
        'FROM ' + RDB + 'FILTERS M';
    etUDF:
      Result := 'SELECT M.RDB$FUNCTION_NAME ' +
        'FROM ' + RDB + 'FUNCTIONS M';
    etGenerator:
      Result := 'SELECT M.RDB$GENERATOR_NAME ' +
        'FROM ' + RDB + 'GENERATORS M';
    etDomain:
      Result := 'SELECT M.RDB$FIELD_NAME ' +
        'FROM ' + RDB + 'FIELDS M';
    etTable:
      Result := 'SELECT M.RDB$RELATION_NAME ' +
        'FROM ' + RDB + 'RELATIONS M ' +
        'WHERE M.RDB$VIEW_BLR IS NULL';
    etView:
      Result := 'SELECT M.RDB$RELATION_NAME ' +
        'FROM ' + RDB + 'RELATIONS M ' +
        'WHERE M.RDB$VIEW_BLR IS NOT NULL';
    etProcedure:
      Result := 'SELECT M.RDB$PROCEDURE_NAME ' +
        'FROM ' + RDB + 'PROCEDURES M';
    etRole:
      Result := 'SELECT M.RDB$ROLE_NAME ' +
        'FROM ' + RDB + 'ROLES M';
  else
    Result := '';
  end;
end;

function TIB_DDLDatabase.BuildEntityList(EType: TIB_EntityType): TStringList;
var
  tmpList: TStringList;
begin
  tmpList := TStringList.Create;
  with Database.CreateCursor do
  try
    SQL.Text := GetEntityListSQL(EType);
    Prepare;
    APIFirst;
    while not Eof do
    begin
      tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    tmpList.Sorted := true;
    Free;
    Result := tmpList;
  except
    Free;
    FreeObj( tmpList );
    raise;
  end;
end;

procedure TIB_DDLDatabase.ResortViews( ViewList: TStringList );
var
  i, j, chk: integer;
  tmpList: TStringList;
  Dependant: boolean;
  tmpName: string;
begin
  if ViewList.Count <= 1 then
    Exit;
  with Database.CreateCursor do
  try
    ViewList.Sorted := false; // we dont want sorting on the result
    // We move everything from ViewList into our temporary list, in reverse
    // order to optimise performance.
    tmpList := TStringList.Create;
    for i := ViewList.Count - 1 downto 0 do
      tmpList.AddObject( ViewList.Strings[i], ViewList.Objects[i] );
    ViewList.Clear; // empty the original list
    // setup the search for view dependancies
    SQL.Add('SELECT');
    SQL.Add('M.RDB$RELATION_NAME');
    SQL.Add('FROM ' + RDB + 'VIEW_RELATIONS M');
    SQL.Add('JOIN ' + RDB + 'RELATIONS R');
    SQL.Add('ON R.RDB$RELATION_NAME = M.RDB$RELATION_NAME');
    SQL.Add('WHERE (M.RDB$VIEW_NAME=:ENTITY_NAME)');
    SQL.Add('AND (R.RDB$VIEW_BLR IS NOT NULL)');
    SQL.Add('ORDER BY M.RDB$RELATION_NAME');
    Prepare;
    chk := tmpList.Count;
    i := tmpList.Count - 1;
    // Each type we cycle through the tmpList we move any names that do
    // not depend on views still in the list back to the ViewList.  The result
    // should be that ViewList ends up with a list of views in order of
    // dependancy.  Additional checks are inserted ensure we dont get a
    // runaway loop.  The reverse order is just to keep the names sorted
    // by name within their dependancy groups, but still allow removal
    // from the end of the list.
    repeat
      // Set the param to the view we want to check for dependancy
      Params.Columns[0].AsString := tmpList.Strings[i];
      Dependant := false;
      // loop through all views that the current selection depends on.
      // Dependant flag will be set to true if such a view exists (and we
      // can break as soon as we find the first match).
      APIFirst;
      while not Eof do
      begin
        tmpName := Fields.Columns[0].AsString;
        for j := 0 to tmpList.Count - 1 do
        begin
          if (j <> i) and (tmpName = tmpList.Strings[j]) then
          begin
            Dependant := true;
            break;
          end;
        end;
        if Dependant then
          break;
        APINext;
      end;
      // if no dependancies still exist in the tmpList then either no
      // dependancy exists (in which case it is safe to create the view), or
      // the dependant view has already been moved to ViewList (in which case
      // it will be created earlier and so it will be safe to create this one
      // now).
      if not Dependant then
      begin
        ViewList.AddObject( tmpList.Strings[i], tmpList.Objects[i] );
        tmpList.Delete( i );
      end;
      Dec( i );
      if i < 0 then
      begin
        // avoid runaway loop - if we did a full cycle through without
        // finding dependancies then we are not going to get anywhere
        // so may as well break now.
        if chk = tmpList.Count then
          break;
        // otherwise go back to the top and try again.
        i := tmpList.Count - 1;
        chk := tmpList.Count;
      end;
    until tmpList.Count <= 0;
    // If we broke out of the above loop early we may have some views not
    // processed (whatever the reason) so load them up now.
    while tmpList.Count > 0 do
    begin
      i := tmpList.Count - 1;
      ViewList.AddObject( tmpList.Strings[i], tmpList.Objects[i] );
      tmpList.Delete( i );
    end;
    FreeObj(tmpList);
    Free;
  except
    Free;
    FreeObj(tmpList);
  end;
end;

function TIB_DDLDatabase.CreateCursor: TIB_Cursor;
begin
  if (FExtTransaction = nil) and (FIntTransaction = nil) then
  begin
    FIntTransaction := TIB_Transaction.CreateForSession(Connection,
      Connection.IB_Session);
    FIntTransaction.IB_Connection := Connection;
    FIntTransaction.AutoCommit := false;
    FIntTransaction.Isolation := tiConcurrency;
  end;
  Result := TIB_Cursor.CreateForSession(Connection, Connection.IB_Session);
  Result.IB_Connection := Connection;
  Result.CallBackInc := -1; // prevent callbacks - will take care of separately
  if FExtTransaction = nil then
    Result.IB_Transaction := FIntTransaction
  else
    Result.IB_Transaction := FExtTransaction;
end;

procedure TIB_DDLDatabase.DoDescription( AEntity: TIB_DDLEntity );
begin
  if Assigned(OnDescription) then
    OnDescription( Self, GetTypeFromEntity(AEntity), AEntity );
end;

function TIB_DDLDatabase.GetSeverity: TIB_DDLProblemLevel;
begin
  for Result := plError downto plNone do
  begin
    if FProblemCounts[Result] > 0 then
      break;
  end;
end;

function TIB_DDLDatabase.GetProblemCount(idx: TIB_DDLProblemLevel): integer;
begin
  Result := FProblemCounts[idx];
end;

procedure TIB_DDLDatabase.ExtractVersionInfo(ISCVer: string; FBVer: string);
var
  i, len: integer;
  VerString, tmpstr: string;
  maj, min, rel, bld: integer;
begin
  FFBVersion := 0;
  FFBBuild := 0;
  FIBVersion := 0;
  FIBBuild := 0;
  FPlatform := '';
  FBuildType := '';
  FBuildInfo := '';
  if length(FBVer) > 0 then
    VerString := FBVer
  else
    VerString := ISCVer;
  maj := 0;
  min := 0;
  rel := 0;
  bld := 0;
  len := length(VerString);
  i := 1;
  // collect platform details (until '-' character)
  while ((i <= len) and (VerString[i] <> '-')) do
  begin
    FPlatform := FPlatform + VerString[i];
    Inc(i);
  end;
  Inc(i);
  // collect build type details (until first numeric)
  while ((i <= len) and not(VerString[i] in ['0'..'9'])) do
  begin
    FBuildType := FBuildType + VerString[i];
    Inc(i);
  end;
  // try for the major version
  tmpstr := '';
  while ((i <= len) and (VerString[i] in ['0'..'9'])) do
  begin
    tmpstr := tmpstr + VerString[i];
    Inc(i);
  end;
  if length(tmpstr) > 0 then
    maj := StrToInt(tmpstr);
  // try for the minor version
  if ((i <= len) and (VerString[i] = '.')) then
  begin
    Inc(i);
    tmpstr := '';
    while ((i <= len) and (VerString[i] in ['0'..'9'])) do
    begin
      tmpstr := tmpstr + VerString[i];
      Inc(i);
    end;
    if length(tmpstr) > 0 then
      min := StrToInt(tmpstr);
  end;
  // try for the release
  if ((i <= len) and (VerString[i] = '.')) then
  begin
    Inc(i);
    tmpstr := '';
    while ((i <= len) and (VerString[i] in ['0'..'9'])) do
    begin
      tmpstr := tmpstr + VerString[i];
      Inc(i);
    end;
    if length(tmpstr) > 0 then
      rel := StrToInt(tmpstr);
  end;
  // try for the build
  if ((i <= len) and (VerString[i] = '.')) then
  begin
    Inc(i);
    tmpstr := '';
    while ((i <= len) and (VerString[i] in ['0'..'9'])) do
    begin
      tmpstr := tmpstr + VerString[i];
      Inc(i);
    end;
    if length(tmpstr) > 0 then
      bld := StrToInt(tmpstr);
  end
  else
  begin
    // some versions did not show a release value, only a build (I think)
    bld := rel;
    rel := 0;
  end;
  // skip any blanks
  while ((i <= len) and (VerString[i] = ' ')) do
    Inc(i);
  // and everything else into the build info
  while (i <= len) do
  begin
    FBuildInfo := FBuildInfo + VerString[i];
    Inc(i);
  end;
  // We also check for 'Firebird' in the build info in order to catch the
  // pre-release versions of FB that did not provide the specific version
  // information in isc_database_info.
  if ((length(FBVer) > 0) or (pos('Firebird', FBuildInfo) > 0)) then
  begin
    FFBVersion := (maj * 1000000) + (min * 1000) + rel;
    // we make up the IB Version equivalent to go with the FB version
    if (maj = 0) then
      FIBVersion := 6001000 // pre-release FB is effectively IB 6.1
    else if (maj >= 1) then
    begin
      case (min) of
      0: FIBVersion := 6002000; // IB 6.2.0
      5: FIBVersion := 6003000; // IB 6.3.0
      else
        // for everything else lets just inc the release until we know
        FIBVersion := 6003001; // IB 6.3.1
      end;
    end;
    FFBBuild := bld;
  end
  else
  begin
    FIBVersion := (maj * 1000000) + (min * 1000) + rel;
    FIBBuild := bld;
  end;
end;


procedure TIB_DDLDatabase.Init;
begin
  if not Connection.Connected then
    Connection.Connected := true;
  Initialise(Connection.DatabaseName, '');
  FreeObj( FDatabaseCsr );
  FreeObj( FExtraFileCsr );
end;

procedure TIB_DDLDatabase.Reset;
var
  idx: TIB_DDLProblemLevel;
begin
  inherited Reset;
  FOwnerName := '';
  FCharacterSetName := '';
  FCharacterSetNormal := '';
  FCharacterSetId := 0;
  FUserExceptionCount := 0;
  FBaseLevel := 0;
  FODSVersion := 0;
  FVersionString := '';
  FDialect := 0;
  FFBVersion := 0;
  FFBBuild := 0;
  FIBVersion := 0;
  FIBBuild := 0;
  FPlatform := '';
  FBuildType := '';
  FBuildInfo := '';
  ClearCursors;
  ClearSecondaryFiles;
  ClearShadowFiles;
  FreeListAndObjects(FExceptions);
  FreeListAndObjects(FBlobFilters);
  FreeListAndObjects(FUDFs);
  FreeListAndObjects(FGenerators);
  FreeListAndObjects(FDomains);
  FreeListAndObjects(FTables);
  FreeListAndObjects(FViews);
  FreeListAndObjects(FProcedures);
  FreeListAndObjects(FRoles);
  FreeObj( FIntTransaction );
  if FProblems <> nil then
    FProblems.Clear;
  for idx := plNone to plError do
    FProblemCounts[idx] := 0;
end;

procedure TIB_DDLDatabase.ClearCursors;
begin
  FreeObj( FDatabaseCsr );
  FreeObj( FExtraFileCsr );
  FreeObj( FExceptionCsr );
  FreeObj( FBlobFilterCsr );
  FreeObj( FUDFCsr );
  FreeObj( FGeneratorCsr );
  FreeObj( FDomainCsr );
  FreeObj( FDomainDimCsr );
  FreeObj( FDomainImplicitCsr );
  FreeObj( FTableCsr );
  FreeObj( FViewCsr );
  FreeObj( FProcedureCsr );
  FreeObj( FRoleCsr );
  FreeObj( FConstraintCsr );
  FreeObj( FIndexCsr );
  FreeObj( FIndexFieldsCsr );
  FreeObj( FTriggerCsr );
  FreeObj( FPermissionCsr );
  FreeObj( FTriggerListCsr );
  FreeObj( FConstraintListCsr );
  FreeObj( FIndexListCsr );
  FreeObj( FFieldListCsr );
  FreeObj( FUDFParamCsr );
  FreeObj( FTableFieldCsr );
  FreeObj( FViewFieldCsr );
  FreeObj( FProcParamCsr );
  FreeObj( FProcParamListCsr );
end;

procedure TIB_DDLDatabase.CloseTransaction(ACommit: boolean);
var
  tmpTran: TIB_Transaction;
begin
  if FExtTransaction <> nil then
    tmpTran := FExtTransaction
  else
    tmpTran := FIntTransaction;
  if tmpTran <> nil then
  begin
    if ACommit then
      tmpTran.Commit;
    tmpTran.Close;
  end;
end;

function TIB_DDLDatabase.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass):
  integer;
var
  tmpExcNo: ISC_INT64;
  i, ShadowSet: integer;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      // Basic database definition
      // -----------------------------
      AddDescription( ACode );
      AddWords(wtComment, Format(C_DDL_CONNECT_USERNAME, [OwnerName]), ttEndLine);
      AddWords(wtComment, Format(C_DDL_CONNECT_SERVER_VER, [FVersionString]), ttEndLine);
      // These two lines here to help when testing the ExtractVersionInfo proc
      //AddWords(wtComment, 'FB: ' + IntToStr(FBVersion) + ', ' + IntToStr(FBBuild) + ', ' + ServerPlatform + ', ' + BuildType + ', ' + BuildInfo, ttEndLine);
      //AddWords(wtComment, 'IB: ' + IntToStr(IBVersion) + ', ' + IntToStr(IBBuild) + ', ' + ServerPlatform + ', ' + BuildType + ', ' + BuildInfo, ttEndLine);
      if coCreateDatabase in CodeOptions then
      begin
        AddWords(wtReserved, 'SET SQL DIALECT', ttNone);
        AddWords(wtNumber, IntToStr(Dialect), ttTermLine);
        AddWords(wtReserved, 'SET AUTODDL', ttNone);
        AddWords(wtNormal, 'ON', ttTermLine);
        AddWords(wtReserved, 'CREATE DATABASE', ttNone);
        AddWords(wtString, Name, ttEndLine);
        IncIndent;
        AddWords(wtReserved, 'USER', ttNone);
        AddWords(wtString, Connection.Username, ttNone);
        AddWords(wtReserved, 'PASSWORD', ttNone);
        AddWords(wtString, 'masterkey', ttEndLine);
        AddWords(wtReserved, 'DEFAULT CHARACTER SET', ttNone);
        AddWords(wtNormal, CharacterSetNormal, ttTermLine);
        DecIndent;
      end
      else
      begin
        if coIncludeDebug in CodeOptions then
        begin
          AddWords(wtComment, Format(C_DDL_SQL_DIALECT, [IntToStr(Dialect)]),
            ttEndLine);
          if not (coAlwaysCharSet in CodeOptions) then
            AddWords(wtComment, Format(C_DDL_CHARACTER_SET, [CharacterSetNormal]),
              ttEndLine);
        end;
      end;
      // Secondary File definition
      // -----------------------------
      if coSecondaryFiles in CodeOptions then
      begin
        if SecondaryFileCount > 0 then
        begin
          AddWords(wtReserved, 'ALTER DATABASE', ttEndLine);
          IncIndent;
          for i := 0 to SecondaryFileCount - 1 do
          begin
            AddWords(wtReserved, 'ADD FILE', ttNone);
            AddWords(wtString, SecondaryFiles[i].Name, ttEndLine);
            if SecondaryFiles[i].Start > 0 then
            begin
              AddWords(wtReserved, 'STARTING', ttNone);
              AddWords(wtNumber, IntToStr(SecondaryFiles[i].Start), ttNone);
            end;
            if SecondaryFiles[i].Length > 0 then
            begin
              AddWords(wtReserved, 'LENGTH', ttNone);
              AddWords(wtNumber, IntToStr(SecondaryFiles[i].Length), ttNone);
            end;
            StartNewLine;
          end;
          TerminateLine;
          DecIndent;
        end
        else
        begin
          if coIncludeDebug in CodeOptions then
            AddWords(wtComment, C_DDL_NO_SEC_FILES, ttEndLine);
        end;
      end
      else
      begin
        if coIncludeDebug in CodeOptions then
        begin
          if SecondaryFileCount > 0 then
          begin
            AddWords(wtComment, C_DDL_SEC_FILES, ttEndLine);
            IncIndent;
            for i := 0 to SecondaryFileCount - 1 do
            begin
              AddWords(wtComment,
                Format(C_DDL_SEC_FILE_DESC, [
                  QuotedStr(SecondaryFiles[i].Name),
                  IntToStr(SecondaryFiles[i].Start),
                  IntToStr(SecondaryFiles[i].Length)]),
                ttEndLine);
            end;
            DecIndent;
          end
          else
            AddWords(wtComment, C_DDL_NO_SEC_FILES, ttEndLine);
        end;
      end;
      // Shadow File definitions
      // -----------------------------
      if coDefineShadows in CodeOptions then
      begin
        if ShadowFileCount > 0 then
        begin
          ShadowSet := 0; // flag no shadow set to start
          for i := 0 to ShadowFileCount - 1 do
          begin
            // As each shadow set definition starts begin the new definition
            if ShadowFiles[i].ShadowNumber <> ShadowSet then
            begin
              if i > 0 then
              begin
                TerminateLine;
                DecIndent;
              end;
              AddWords(wtReserved, 'CREATE SHADOW', ttNone);
              AddWords(wtNumber, IntToStr(ShadowFiles[i].ShadowNumber), ttNone);
              // Flags for RDB$FILE_FLAGS
              // Had to go to the source for this information, not documented.
              // FILE_shadow   = $01;
              // FILE_inactive    = $02;    ??? is there any support for this
              // FILE_manual   = $04;
              // FILE_cache    = $08;
              // FILE_conditional = $10;
              if (ShadowFiles[i].Flags and 4) = 0 then
                AddWords(wtReserved, 'AUTO', ttNone)
              else
                AddWords(wtReserved, 'MANUAL', ttNone);
              if (ShadowFiles[i].Flags and $10) <> 0 then
                AddWords(wtReserved, 'CONDITIONAL', ttNone);
              StartNewLine;
              IncIndent;
              AddWords(wtString, ShadowFiles[i].Name, ttEndLine);
            end
            else  // No point defining START/LENGTH on first shadow file
            begin
              AddWords(wtReserved, 'FILE', ttNone);
              AddWords(wtString, ShadowFiles[i].Name, ttEndLine);
              if ShadowFiles[i].Start > 0 then
              begin
                AddWords(wtReserved, 'STARTING', ttNone);
                AddWords(wtNumber, IntToStr(ShadowFiles[i].Start), ttNone);
              end;
              if ShadowFiles[i].Length > 0 then
              begin
                AddWords(wtReserved, 'LENGTH', ttNone);
                AddWords(wtNumber, IntToStr(ShadowFiles[i].Length), ttNone);
              end;
              StartNewLine;
            end;
            ShadowSet := ShadowFiles[i].ShadowNumber;
          end;
          TerminateLine;
          DecIndent;
        end
        else
        begin
          if coIncludeDebug in CodeOptions then
            AddWords(wtComment, C_DDL_NO_SHADOW_FILES, ttEndLine);
        end;
      end
      else
      begin
        if coIncludeDebug in CodeOptions then
        begin
          if ShadowFileCount > 0 then
          begin
            AddWords(wtComment, C_DDL_SHADOW_FILES, ttEndLine);
            IncIndent;
            for i := 0 to ShadowFileCount - 1 do
            begin
              AddWords(wtComment,
                Format(C_DDL_SHADOW_FILE_DESC, [
                  IntToStr(ShadowFiles[i].ShadowNumber),
                  QuotedStr(ShadowFiles[i].Name),
                  IntToStr(ShadowFiles[i].Start),
                  IntToStr(ShadowFiles[i].Length)]),
                ttEndLine);
            end;
            DecIndent;
          end
          else
            AddWords(wtComment, C_DDL_NO_SHADOW_FILES, ttEndLine);
        end;
      end;
      // Exception Management definition
      // ----------------------------------
      if coResetExceptionNo in CodeOptions then
      begin
        tmpExcNo := Connection.Gen_ID('RDB$EXCEPTIONS', 0);
        StartNewLine;
        AddWords(wtReserved, 'SET GENERATOR', ttNone);
        AddWords(wtIdentity, MkIdent('RDB$EXCEPTIONS'), ttNone);
        AddWords(wtReserved, 'TO', ttNone);
{$IFDEF IBO_VCL40_OR_GREATER}
        AddWords(wtNumber, IntToStr(tmpExcNo), ttTermLine);
{$ELSE}
        AddWords(wtNumber, FloatToStr(tmpExcNo), ttTermLine);
{$ENDIF}
      end;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLException.GetCursor: TIB_Cursor;
begin
  if Database.FExceptionCsr = nil then
  begin
    Database.FExceptionCsr := Database.CreateCursor;
    with Database.FExceptionCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$EXCEPTION_NUMBER,');
      SQL.Add('M.RDB$MESSAGE,');
      SQL.Add('M.RDB$SYSTEM_FLAG,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'EXCEPTIONS M');
      SQL.Add('WHERE M.RDB$EXCEPTION_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FExceptionCsr;
end;

procedure TIB_DDLException.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FExceptionNumber := Columns[0].AsInteger;
    FMessage := Columns[1].AsString;
    FSystemFlag := (Columns[2].AsSmallint = 1);
    FDescription := Columns[3].AsString;
  end;
end;

procedure TIB_DDLException.Reset;
begin
  inherited Reset;
  FExceptionNumber := -1;
  FMessage := '';
end;

function TIB_DDLException.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      if (coIncludeDebug in Database.CodeOptions) and
        not (coResetExceptionNo in Database.CodeOptions) then
        AddWords(wtComment, Format(C_DDL_EXCEPTION_DESC, [
          QuotedStr(Name), IntToStr(ExceptionNumber)]), ttEndLine);
      AddWords(wtReserved, 'CREATE EXCEPTION', ttNone);
      AddWords(wtIdentity, MkIdent(OutputName), ttEndLine);
      IncIndent;
      AddWords(wtString, Message, ttTermLine);
      DecIndent;
      if coResetExceptionNo in Database.CodeOptions then
      begin
        AddWords(wtReserved, 'UPDATE', ttNone);
        AddWords(wtIdentity, MkIdent('RDB$EXCEPTIONS'), ttEndLine);
        IncIndent;
        AddWords(wtReserved, 'SET', ttNone);
        AddWords(wtIdentity, MkIdent('RDB$EXCEPTION_NUMBER'), ttNone);
        AddWords(wtOperate, '=', ttNone);
        AddWords(wtNumber, IntToStr(ExceptionNumber), ttEndLine);
        AddWords(wtReserved, 'WHERE', ttNone);
        AddWords(wtIdentity, MkIdent('RDB$EXCEPTION_NAME'), ttNone);
        AddWords(wtOperate, '=', ttNone);
        AddWords(wtString, OutputName, ttTermLine);
        DecIndent;
      end;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLBlobFilter.GetCursor: TIB_Cursor;
begin
  if Database.FBlobFilterCsr = nil then
  begin
    Database.FBlobFilterCsr := Database.CreateCursor;
    with Database.FBlobFilterCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$MODULE_NAME,');
      SQL.Add('M.RDB$ENTRYPOINT,');
      SQL.Add('M.RDB$INPUT_SUB_TYPE,'); //SMALLINT,
      SQL.Add('M.RDB$OUTPUT_SUB_TYPE'); //SMALLINT,
      SQL.Add('M.RDB$SYSTEM_FLAG,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'FILTERS M');
      SQL.Add('WHERE M.RDB$FUNCTION_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FBlobFilterCsr;
end;

procedure TIB_DDLBlobFilter.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FModuleName := Columns[0].AsString;
    FEntryPoint := Columns[1].AsString;
    FInputSubType := Columns[2].AsSmallint;
    FOutputSubType := Columns[3].AsSmallint;
    FSystemFlag := (Columns[4].AsSmallint = 1);
    FDescription := Columns[5].AsString;
  end;
  if Trim(FModuleName) = EmptyStr then
    AddProblem(plError, E_DDL_MODULE_NAME_EMPTY);
  if Trim(FEntryPoint) = EmptyStr then
    AddProblem(plError, E_DDL_ENTRY_POINT_EMPTY);
end;

procedure TIB_DDLBlobFilter.Reset;
begin
  inherited Reset;
  FModuleName := '';
  FEntryPoint := '';
  FInputSubType := 0;
  FOutputSubType := 0;
end;

function TIB_DDLBlobFilter.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'DECLARE FILTER', ttNone);
      AddWords(wtIdentity, MkIdent(OutputName), ttEndLine);
      IncIndent;
      AddWords(wtReserved, 'INPUT_TYPE', ttNone);
      AddWords(wtNumber, IntToStr(InputSubType), ttNone);
      AddWords(wtReserved, 'OUTPUT_TYPE', ttNone);
      AddWords(wtNumber, IntToStr(OutputSubType), ttEndLine);
      AddWords(wtReserved, 'ENTRY_POINT', ttNone);
      AddWords(wtString, EntryPoint, ttNone);
      AddWords(wtReserved, 'MODULE_NAME', ttNone);
      AddWords(wtString, ModuleName, ttTermLine);
      DecIndent;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLGenerator.GetCursor: TIB_Cursor;
begin
  if Database.FGeneratorCsr = nil then
  begin
    Database.FGeneratorCsr := Database.CreateCursor;
    with Database.FGeneratorCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$GENERATOR_ID,');   //SMALLINT
      SQL.Add('M.RDB$SYSTEM_FLAG');
      SQL.Add('FROM ' + RDB + 'GENERATORS M');
      SQL.Add('WHERE M.RDB$GENERATOR_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FGeneratorCsr;
end;

procedure TIB_DDLGenerator.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FID := Columns[0].AsSmallint;
    FSystemFlag := (Columns[1].AsSmallint = 1);
    FValue := 0;
    if coSetGeneratorVal in Database.CodeOptions then
    begin
      if RDB = IB_DefaultRDBPrefix then
        FValue := Self.Database.Connection.Gen_ID(Self.Name, 0)
      else
        FValue := 0;
    end;
  end;
end;

procedure TIB_DDLGenerator.Reset;
begin
  inherited Reset;
  FID := 0;
  FValue := 0;
end;

function TIB_DDLGenerator.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'CREATE GENERATOR', ttNone);
      AddWords(wtIdentity, MkIdent(OutputName), ttTermLine);
      if coSetGeneratorVal in Database.CodeOptions then
      begin
        AddWords(wtReserved, 'SET GENERATOR', ttNone);
        AddWords(wtIdentity, MkIdent(OutputName), ttNone);
        AddWords(wtReserved, 'TO', ttNone);
{$IFDEF IBO_VCL40_OR_GREATER}
        AddWords(wtNumber, IntToStr(Value), ttTermLine);
{$ELSE}
        AddWords(wtNumber, FloatToStr(Value), ttTermLine);
{$ENDIF}
      end
      else
      begin
        if coIncludeDebug in Database.CodeOptions then
          AddWords(wtComment, 'SET GENERATOR ' +
{$IFDEF IBO_VCL40_OR_GREATER}
            MkIdent(OutputName) + ' TO ' + IntToStr(Value), ttEndLine);
{$ELSE}
            MkIdent(OutputName) + ' TO ' + FloatToStr(Value), ttEndLine);
{$ENDIF}
      end;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLDomain.GetCursor: TIB_Cursor;
begin
  if Database.FDomainCsr = nil then
  begin
    Database.FDomainCsr := Database.CreateCursor;
    with Database.FDomainCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$VALIDATION_SOURCE,');  //The manual is wrong, this field is used!
      SQL.Add('M.RDB$COMPUTED_SOURCE,');
      SQL.Add('M.RDB$DEFAULT_SOURCE,');
      SQL.Add('M.RDB$FIELD_LENGTH,');   //SMALLINT,
      SQL.Add('M.RDB$FIELD_SCALE,');    //SMALLINT,
      SQL.Add('M.RDB$FIELD_TYPE,');     //SMALLINT,
      SQL.Add('M.RDB$FIELD_SUB_TYPE,'); //SMALLINT,
      SQL.Add('M.RDB$SEGMENT_LENGTH,'); //SMALLINT,
      SQL.Add('M.RDB$EXTERNAL_LENGTH,'); //SMALLINT,
      SQL.Add('M.RDB$EXTERNAL_SCALE,'); //SMALLINT,
      SQL.Add('M.RDB$EXTERNAL_TYPE,');  //SMALLINT,
      SQL.Add('M.RDB$DIMENSIONS,');     //SMALLINT,
      SQL.Add('M.RDB$NULL_FLAG,');      //SMALLINT,
      SQL.Add('M.RDB$CHARACTER_LENGTH,'); //SMALLINT,
      SQL.Add('M.RDB$COLLATION_ID,');   //SMALLINT,
      SQL.Add('M.RDB$CHARACTER_SET_ID,'); //SMALLINT,
      SQL.Add('M.RDB$SYSTEM_FLAG,');    //SMALLINT,
      if Self.Database.Connection.Characteristics.dbODS_Version >= 10 then
        SQL.Add('M.RDB$FIELD_PRECISION,') //SMALLINT,
      else
        SQL.Add('null as RDB$FIELD_PRECISION,'); //SMALLINT,
      SQL.Add('T.RDB$TYPE_NAME,');
      SQL.Add('   (SELECT T2.RDB$TYPE_NAME FROM ' + RDB + 'TYPES T2');
      SQL.Add('   WHERE M.RDB$FIELD_SUB_TYPE = T2.RDB$TYPE');
      SQL.Add('   AND T2.RDB$FIELD_NAME = ' + QuotedStr('RDB$FIELD_SUB_TYPE') +
        ')');
      SQL.Add('   AS RDB$SUB_TYPE_NAME,');
      SQL.Add('CS.RDB$CHARACTER_SET_NAME,');
      SQL.Add('CS.RDB$BYTES_PER_CHARACTER,');
      SQL.Add('   (SELECT C.RDB$COLLATION_NAME FROM ' + RDB + 'COLLATIONS C');
      SQL.Add('   WHERE M.RDB$COLLATION_ID = C.RDB$COLLATION_ID');
      SQL.Add('   AND M.RDB$CHARACTER_SET_ID = C.RDB$CHARACTER_SET_ID)');
      SQL.Add('   AS RDB$COLLATION_NAME,');
      SQL.Add('CS.RDB$DEFAULT_COLLATE_NAME,');
      SQL.Add('M.RDB$DESCRIPTION');
      // Thanks Borland for not including type=16 INT64 in system tables of IB6.
      // You make life harder and force the use of a LEFT JOIN.
      SQL.Add('FROM ' + RDB + 'FIELDS M LEFT JOIN ' + RDB + 'TYPES T');
      SQL.Add('ON M.RDB$FIELD_TYPE = T.RDB$TYPE');
      SQL.Add('AND T.RDB$FIELD_NAME = ' + QuotedStr('RDB$FIELD_TYPE'));
      SQL.Add('LEFT JOIN ' + RDB + 'CHARACTER_SETS CS');
      SQL.Add('ON M.RDB$CHARACTER_SET_ID = CS.RDB$CHARACTER_SET_ID');
      SQL.Add('WHERE M.RDB$FIELD_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FDomainCsr;
  // We also need the dimensions...
  if Database.FDomainDimCsr = nil then
  begin
    Database.FDomainDimCsr := Database.CreateCursor;
    with Database.FDomainDimCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$DIMENSION,');
      SQL.Add('M.RDB$LOWER_BOUND,');
      SQL.Add('M.RDB$UPPER_BOUND');
      SQL.Add('FROM ' + RDB + 'FIELD_DIMENSIONS M');
      SQL.Add('WHERE M.RDB$FIELD_NAME=:ENTITY_NAME');
      SQL.Add('ORDER BY M.RDB$DIMENSION');
      Prepare;
    end;
  end;
end;

procedure TIB_DDLDomain.AssignFromFields(ARow: TIB_Row);
var
  charsetWasNull: Boolean;
  defCollateName: string;
  iterations: SmallInt;
begin
  with ARow do
  begin
    FValidationSource := Columns[0].AsString;
    FComputedSource := Trim(Columns[1].AsString);
    FIsComputed := Columns[1].IsNotNull;
    FDefaultSource := Columns[2].AsString;
    FFieldLength := Columns[3].AsSmallInt;
    FFieldScale := Columns[4].AsSmallInt;
    FFieldType := Columns[5].AsSmallInt;
    FFieldSubType := Columns[6].AsSmallInt;
    FSegmentLength := word(Columns[7].AsSmallInt);
    FExternalLength := word(Columns[8].AsSmallInt);
    FExternalScale := Columns[9].AsSmallInt;
    FExternalType := Columns[10].AsSmallInt;
    FIsExternalDomain := Columns[8].IsNotNull or
      Columns[9].IsNotNull or
      Columns[10].IsNotNull;
    // This is a hack due to IB's weird external domain behavior.
    if FIsExternalDomain then
    begin
      if Columns[3].IsNull and Columns[8].IsNotNull then
        FFieldLength := FExternalLength;
      if Columns[4].IsNull and Columns[9].IsNotNull then
        FFieldScale := FExternalScale;
      if Columns[5].IsNull and Columns[10].IsNotNull then
        FFieldType := FExternalType
    end;
    FDimensions := Columns[11].AsSmallInt;
    FIsArrayBased := FDimensions > 0;
    FIsMandatory := Columns[12].AsBoolean;
    FCharacterLength := Columns[13].AsSmallInt;
    FCollationId := Columns[14].AsSmallInt;
    FCharacterSetId := Columns[15].AsSmallInt;
    charsetWasNull := Columns[15].IsNull;
    FSystemFlag := (Columns[16].AsSmallint = 1);
    FFieldPrecision := Columns[17].AsSmallInt;
    FTypeName := FieldTypeAsChar(FFieldType, Columns[18].AsString);
    FSubTypeName := AdjustField(FFieldType, FFieldSubType, FFieldPrecision,
      FTypeName, Columns[19].AsString, FFieldScale,
      FIsNumericOrDecimal, True, (coUseBigInt in Database.CodeOptions));
    // Character sets can be defined for blob subtype 0 but we dont
    // insist on it in later code.
    if (FFieldType in [14,37,40]) or
      ((FFieldType = 261) and (FFieldSubType in [0,1])) then
    begin
      FCharacterSetName := Columns[20].AsString;
      if FFieldType <> 261 then
        FBytesPerCharacter := Columns[21].AsSmallInt;
      if FFieldType in [14, 37, 40] then
      begin
        FCollationName := Columns[22].AsString;
        defCollateName := Columns[23].AsString;
      end;
    end;
    FDescription := Columns[24].AsString;
  end;
  if MatchingPrefix(FName, IB_DefaultRDBPrefix) and
    (Length(FName) > length(IB_DefaultRDBPrefix)) and
    (FName[length(IB_DefaultRDBPrefix) + 1] in ['1'..'9']) and
    (StrToIntDef(Copy(FName, length(IB_DefaultRDBPrefix) + 1, 31), 0) > 0) then
    FIsImplicit := True;
  if (not IsImplicit) and not (SystemFlag) then
  begin
    if FIsExternalDomain then
      AddProblem(plError, E_DDL_DOMAIN_MUST_BE_EXPLICIT);
  end;
  if (FFieldType = 16) and (FFieldSubType = 0) and (FTypeName[1] = '_') and
    (not IsComputed) then
    AddProblem(plError, E_DDL_DOMAIN_TYPE_16 + GetImplicitDesc);
  // Was checking all blob subtypes, then just 0,1 (0 also supports a
  // charset declaration) but reverted to checking 1 (TEXT).  This avoids
  // the common problem of no character set defined for blob subtype 0, which
  // should not be defaulted to NONE anyway.
  if (FFieldType in [14,37,40]) or
    ((FFieldType = 261) and (FFieldSubType = 1)) then
  begin
    if charsetWasNull then
    begin
      FCharacterSetName := 'NONE';
      FBytesPerCharacter := 1;
      // I was reporting charset assumed none whenever ReportMinor was selected
      // However the problem occurs so often that I have reverted to reporting
      // when none is being assumed and the database default is not none.
      if (CharacterSetName <> Database.CharacterSetNormal) then
        AddProblem(plWarning, E_DDL_CHARSET_NULL_ASSUME_NONE + GetImplicitDesc);
    end
    else
    begin
      if FCharacterSetName = EmptyStr then
      begin
        FCharacterSetName := 'NONE';
        AddProblem(plWarning, Format(E_DDL_CHARSET_BLANK_ASSUME_NONE,
          [IntToStr(FCharacterSetId)]) + GetImplicitDesc);
      end;
    end;
  end;
  if FFieldType in [14, 37, 40] then
  begin
    if FCharacterLength = 0 then
    try
      FCharacterLength := FFieldLength div FBytesPerCharacter
    except
      AddProblem(plError,
        Format(E_DDL_BPC_ZERO_IN_CHARSET, [FCharacterSetName]) +
        GetImplicitDesc);
    end;
    if ((FCharacterLength = 0) or
      ((FFieldLength mod FBytesPerCharacter) <> 0)) then
    begin
      //if (coReportMinor in Database.CodeOptions) or (not SystemFlag) then
      // I was reporting this as minor for system entities, but that seemed
      // like a waste and also a confusion.  So leaving out since all
      // system varchars have this problem.
      if (not SystemFlag) then
        AddProblem(plWarning, Format(E_DDL_FIELDLEN_MISMATCH,
          [IntToStr(FFieldLength), IntToStr(FBytesPerCharacter),
          FCharacterSetName]) + GetImplicitDesc);
      if FBytesPerCharacter = 0 then
      begin
        FFieldLength := FBytesPerCharacter;
        FCharacterLength := 1;
      end
      else
      begin
        // ensure enough room is allocated for full FieldLenth of data
        Inc(FFieldLength, (FBytesPerCharacter - (FFieldLength mod
          FBytesPerCharacter)));
        FCharacterLength := FFieldLength div FBytesPerCharacter
      end;
    end;
    if FCollationId < 0 then
    begin
      AddProblem(plError,
        Format(E_DDL_INVALID_COLLATIONID, [IntToStr(FCollationId)]) +
        GetImplicitDesc);
    end
    else
    begin
      if (FCollationName = EmptyStr) and not IsImplicit then
      begin
        if charsetWasNull then
          FCollationName := 'NONE'
        else
        begin
          if (defCollateName = EmptyStr) then
            FCollationName := FCharacterSetName
          else
            FCollationName := defCollateName;
        end;
        AddProblem(plWarning,
          Format(E_DDL_COLLATION_NULL_ASSUME, [FCollationName]) +
          GetImplicitDesc);
      end;
    end;
  end;
  if not (FFieldType in [14, 11, 27, 10, 16, 8, 9, 7, 12, 13, 35, 37, 40])
    and (FFieldType <> 261) then
    AddProblem(plError,
      Format(E_DDL_UNKNOWN_FIELD_TYPE, [IntToStr(FFieldType)]) +
      GetImplicitDesc);
  if FFieldType = 40 then
    AddProblem(plError, E_DDL_CSTRING_IN_DSQL + GetImplicitDesc)
  else
  begin
    if FFieldType = 9 then
      AddProblem(plError, E_DDL_QUAD_IN_DSQL + GetImplicitDesc);
  end;
  if FValidationSource <> EmptyStr then
  begin
    if Copy(Trim(UpperCase(FValidationSource)), 1, 5) <> 'CHECK' then
      AddProblem(plSuspicious,
        Format(E_DDL_SUSPICIOUS_CHECK, [FValidationSource]) +
        GetImplicitDesc)
    else
    begin
      FValidationSource := Trim(Copy(Trim(FValidationSource), 6,
        Length(FValidationSource)));
      if Length(FValidationSource) = 0 then
        AddProblem(plError, E_DDL_VOID_CHECK_CONSTRAINT + GetImplicitDesc);
    end;
  end;
  if FIsComputed then
  begin
    if not IsImplicit then
      AddProblem(plError, E_DDL_EXPLICIT_COMPUTED + GetImplicitDesc);
    if FComputedSource = EmptyStr then
    begin
      FIsComputed := False;
      AddProblem(plError, E_DDL_VOID_COMPUTED + GetImplicitDesc);
    end;
  end;
  if FDefaultSource <> EmptyStr then
  begin
    if Copy(Trim(UpperCase(FDefaultSource)), 1, 7) <> 'DEFAULT' then
      AddProblem(plSuspicious,
        Format(E_DDL_SUSPICIOUS_DEFAULT, [FDefaultSource]) +
        GetImplicitDesc)
    else
    begin
      FDefaultSource := Trim(Copy(Trim(FDefaultSource), 8,
        Length(FDefaultSource)));
      if Length(FDefaultSource) = 0 then
        AddProblem(plError, E_DDL_VOID_DEFAULT + GetImplicitDesc);
    end;
  end;
  with Database.FDomainDimCsr do
  begin
    Params.Columns[0].AsString := Self.Name;
    FDimensionsLine := '';
    iterations := 0;
    APIFirst;
    while not Eof do
    begin
      if Fields.Columns[0].AsSmallint > 0 then
        FDimensionsLine := FDimensionsLine + ', ';
      if Fields.Columns[1].AsInteger = 1 then
        FDimensionsLine := FDimensionsLine + Fields.Columns[2].AsString
      else
        FDimensionsLine := FDimensionsLine + Fields.Columns[1].AsString +
          ':' + Fields.Columns[2].AsString;
      APINext;
      Inc(iterations)
    end;
    if (iterations <> FDimensions) then
      AddProblem(plError,
        Format(E_DDL_DIMENSIONS_MISMATCH, [IntToStr(FDimensions),
        IntToStr(iterations)]) + GetImplicitDesc);
  end;
end;

procedure TIB_DDLDomain.Reset;
begin
  inherited Reset;
  FValidationSource := '';
  FComputedSource := '';
  FDefaultSource := '';
  FFieldLength := 0;
  FFieldScale := 0;
  FFieldType := 0;
  FFieldSubType := 0;
  FSegmentLength := 0;
  FExternalLength := 0;
  FExternalScale := 0;
  FExternalType := 0;
  FDimensions := 0;
  FIsMandatory := false;                //FNullFlag: SmallInt;
  FCharacterLength := 0;
  FCollationId := 0;
  FCharacterSetId := 0;
  FFieldPrecision := 0;
  FTypeName := '';
  FSubTypeName := '';
  FCharacterSetName := '';
  FCollationName := '';
  FIsNumericOrDecimal := false;
  FBytesPerCharacter := 0;
  FDimensionsLine := '';
  FIsArrayBased := false;
  FIsExternalDomain := false;
  FIsComputed := false;
  FHaveImplicitField := false;
  FImplicitRelation := '';
  FImplicitField := '';
end;

procedure TIB_DDLDomain.AssignImplicitField;
begin
  if not IsImplicit then
    Exit;
  // NOTE: For performance reasons this is only called when the
  // ImplicitRelation or ImplicitField properties are referenced.
  // In such cases the get methods call this function (if not already
  // called) to obtain the required details.  Generally this is
  // only necessary when reporting problems (to give the relation.field
  // details for an implicit field).
  if Database.FDomainImplicitCsr = nil then
  begin
    Database.FDomainImplicitCsr := Database.CreateCursor;
    with Database.FDomainImplicitCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('R.RDB$RELATION_NAME,');
      SQL.Add('R.RDB$FIELD_NAME,');
      SQL.Add('P.RDB$PROCEDURE_NAME,');
      SQL.Add('P.RDB$PARAMETER_NAME');
      SQL.Add('FROM ' + RDB + 'FIELDS F');
      SQL.Add('LEFT OUTER JOIN ' + RDB + 'RELATION_FIELDS R');
      SQL.Add('ON R.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME');
      SQL.Add('LEFT OUTER JOIN ' + RDB + 'PROCEDURE_PARAMETERS P');
      SQL.Add('ON P.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME');
      SQL.Add('WHERE F.RDB$FIELD_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  with Database.FDomainImplicitCsr do
  begin
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    if not Eof then
    begin
      if Fields.Columns[0].IsNull then
      begin
        FImplicitRelation := Fields.Columns[2].AsString;
        FImplicitField := Fields.Columns[3].AsString;
      end
      else
      begin
        FImplicitRelation := Fields.Columns[0].AsString;
        FImplicitField := Fields.Columns[1].AsString;
      end
    end
    else
      AddProblem(plWarning, E_DDL_IMPLICIT_DOMAIN_NO_RELATION);
  end;
  if (FImplicitRelation = EmptyStr) or (FImplicitField = EmptyStr) then
    AddProblem(plWarning, E_DDL_IMPLICIT_DOMAIN_NO_FIELD);
  FHaveImplicitField := true;
end;

function TIB_DDLDomain.GetImplicitRelation: string;
begin
  if not FHaveImplicitField then
    AssignImplicitField;
  Result := FImplicitRelation;
end;

function TIB_DDLDomain.GetImplicitField:string;
begin
  if not FHaveImplicitField then
    AssignImplicitField;
  Result := FImplicitField;
end;

function TIB_DDLDomain.GetImplicitDesc: string;
begin
  Result := '';
  if IsImplicit then
    Result := ' (' + ImplicitRelation + '.' + ImplicitField + ')';
end;

function TIB_DDLDomain.AddTypeCode(ACode: TIB_CodeFormatter): boolean;
var
  tmpStr: string;
begin
  with ACode do
  begin
    AddWords(wtReserved, TypeName, ttNone);
    Result := true;
    tmpStr := '';
    if FieldType in [14, 37, 40] then
      tmpStr := tmpStr + '(' + IntToStr(CharacterLength) + ')'
    else
    begin
      if IsNumericOrDecimal then
      begin
        if FieldScale <> 0 then
          tmpStr := tmpStr + '(' + IntToStr(FieldPrecision) + ',' +
            IntToStr(-FieldScale) + ')'
        else
          tmpStr := tmpStr + '(' + IntToStr(FieldPrecision) + ')';
      end;
    end;
    if Dimensions > 0 then
      tmpStr := tmpStr + '[' + DimensionsLine + ']'
    else
    begin
      if FieldType = 261 then           //FieldIsBlob
      begin
        AddWords(wtReserved, 'SUB_TYPE', ttNone);
        AddWords(wtNormal, SubTypeName, ttNone);
        AddWords(wtReserved, 'SEGMENT SIZE', ttNone);
        AddWords(wtNumber, IntToStr(SegmentLength), ttNone);
      end;
    end;
    if tmpStr <> '' then
      AddWords(wtNoSpacing, tmpStr, ttNone);
  end;
end;

function TIB_DDLDomain.AddCharSetCode(ACode: TIB_CodeFormatter; DoNewLine: boolean):
  boolean;
begin
  Result := false;
  if (FFieldType in [14,37,40]) or
    ((FFieldType = 261) and (FFieldSubType = 1)) or
    ((FFieldType = 261) and (FFieldSubType = 0) and // only show charset for
     (CharacterSetName <> EmptyStr)) then           // blob 0 if defined
  begin
    with ACode do
    begin
      if (coAlwaysCharSet in Database.CodeOptions) or
        (CharacterSetName <> Database.CharacterSetNormal) then
      begin
        if DoNewLine then
          StartNewLine;
        AddWords(wtReserved, 'CHARACTER SET', ttNone);
        AddWords(wtNormal, CharacterSetName, ttNone);
        Result := true;
      end
      else
      begin
        if coIncludeDebug in Database.CodeOptions then
        begin
          if DoNewLine then
            StartNewLine;
          AddWords(wtComment, 'CHARACTER SET ' + CharacterSetName, ttNone);
          Result := true;
        end;
      end;
    end;
  end;
end;

function TIB_DDLDomain.AddComputedCode(ACode: TIB_CodeFormatter; AsComment: boolean;
  DoNewLine: boolean): boolean;
begin
  Result := false;
  if ComputedSource <> EmptyStr then
  begin
    with ACode do
    begin
      if AsComment then
      begin
        if coIncludeDebug in Database.CodeOptions then
        begin
          if DoNewLine then
            StartNewLine;
          AddWords(wtComment, 'COMPUTED BY', ttNone);
          AddWords(wtComment, ComputedSource, ttNone);
          Result := true;
        end;
      end
      else
      begin
        if DoNewLine then
          StartNewLine;
        AddWords(wtReserved, 'COMPUTED BY', ttNone);
        AddWords(wtNormal, ComputedSource, ttNone);
        Result := true;
      end;
    end;
  end;
end;

function TIB_DDLDomain.AddDefaultCode(ACode: TIB_CodeFormatter; DefaultStr: string;
  DoNewLine: boolean): boolean;
begin
  Result := false;
  with ACode do
  begin
    if DefaultStr <> EmptyStr then
    begin
      if DoNewLine then
        StartNewLine;
      AddWords(wtReserved, 'DEFAULT', ttNone);
      AddWords(wtNormal, DefaultStr, ttNone);
      Result := true;
    end;
  end;
end;

function TIB_DDLDomain.AddMandatoryCode(ACode: TIB_CodeFormatter; NewMandatory: boolean;
  DoNewLine: boolean): boolean;
begin
  Result := false;
  //  This does not work - writes out NOT NULL when not needed
  //  because FIsMandatory is not normally true on fields declared
  //  with NOT NULL domains.
  //if IsMandatory xor NewMandatory then
  // So just use this, still allows NOT NULL to be written when not
  // needed, but result should reflect what user originally defined.
  if NewMandatory then
  begin
    with ACode do
    begin
      if DoNewLine then
        StartNewLine;
      AddWords(wtReserved, 'NOT NULL', ttNone);
      Result := true;
    end;
  end;
end;

function TIB_DDLDomain.AddCheckCode(ACode: TIB_CodeFormatter; ACheckStr: string;
  DoNewLine: boolean): boolean;
begin
  Result := false;
  if ACheckStr <> EmptyStr then
  begin
    with ACode do
    begin
      if DoNewLine then
        StartNewLine;
      AddWords(wtReserved, 'CHECK', ttNone);
      // If spans multiple lines then start it all on a new line
      if Pos(#10, ACheckStr) > 0 then
        StartNewLine;
      AddWords(wtNormal, ACheckStr, ttNone);
      Result := true;
    end;
  end;
end;

function TIB_DDLDomain.AddCollationCode(ACode: TIB_CodeFormatter; NewCID: smallint;
  NewCName: string; DoNewLine: boolean): boolean;
begin
  Result := false;
  if FieldType in [14, 37, 40] then
  begin
    with ACode do
    begin
      if (NewCID > -1) and (CharacterSetID > 0) then
      begin
        if ((NewCID > 0) or (coAlwaysCharSet in Database.CodeOptions)) then
        begin
          if DoNewLine then
            StartNewLine;
          AddWords(wtReserved, 'COLLATE', ttNone);
          AddWords(wtNormal, NewCName, ttNone);
          Result := true;
        end;
      end
      else
      begin
        if CollationId > 0 then
        begin
          if DoNewLine then
            StartNewLine;
          AddWords(wtReserved, 'COLLATE', ttNone);
          AddWords(wtNormal, CollationName, ttNone);
          Result := true;
        end;
      end;
    end;
  end;
end;

function TIB_DDLDomain.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'CREATE DOMAIN', ttNone);
      AddWords(wtIdentity, MkIdent(OutputName), ttEndLine);
      IncIndent;
      AddWords(wtReserved, 'AS', ttNone);
      AddTypeCode(ACode);
      AddCharSetCode(ACode, true);
      AddComputedCode(ACode, true, true);
      if AddDefaultCode(ACode, DefaultSource, true) then
        AddMandatoryCode(ACode, IsMandatory, false)
      else
        AddMandatoryCode(ACode, IsMandatory, true);
      // exclude Check from cpInit - in case it uses selects
      if APass = cpFull then
        AddCheckCode(ACode, ValidationSource, true);
      AddCollationCode(ACode, -1, EmptyStr, true);
      TerminateLine;
      DecIndent;
    end;
  end
  else // APass = cpFinal
  begin
    if ValidationSource <> EmptyStr then
    begin
      with ACode do
      begin
        AddWords(wtReserved, 'ALTER DOMAIN', ttNone);
        AddWords(wtIdentity, MkIdent(OutputName), ttEndLine);
        IncIndent;
        AddWords(wtReserved, 'ADD ', ttNone);
        AddCheckCode(ACode, ValidationSource, true);
        TerminateLine;
        DecIndent;
      end;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



procedure TIB_DDLUDF.BuildParamList;
var
  tmpList: TStringList;
  tmpUDFParam: TIB_DDLUDFParam;
begin
  // UDF Params are not named either.  I contemplated using the position
  // as the name but not sure if that field is forced unique so instead
  // I will build all the entries while building the list.
  tmpList := TStringList.Create;
  try
    if Database.FUDFParamCsr = nil then
    begin
      tmpUDFParam := TIB_DDLUDFParam.Create(Database, Self);
      tmpUDFParam.GetCursor;            // forces creation of udfparamcsr
      FreeObj(tmpUDFParam);
    end;
    with Database.FUDFParamCsr do
    begin
      Params.Columns[0].AsString := Self.Name;
      APIFirst;
      while not Eof do
      begin
        tmpUDFParam := TIB_DDLUDFParam.Create(Database, Self);
        // DO NOT call Initialise - we setup assignments here instead.
        with tmpUDFParam do // this section replaces what base init stuff
        begin
          if Initialised then
            Reset;
          FName := Fields.Columns[0].AsString; // position
        end;
        tmpList.AddObject(Fields.Columns[1].AsString, tmpUDFParam);
        tmpUDFParam.AssignFromFields(Fields);
        APINext;
      end;
    end;
    //tmpList.Sorted := true;  Keep then in order retrieved
    FParams := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

function TIB_DDLUDF.GetEntityList(EType: TIB_EntityType): TStringList;
begin
  if EType = etUDFParam then
  begin
    if FParams = nil then
      BuildParamList;
    Result := FParams;
  end
  else
    Result := inherited GetEntityList(EType);
end;

function TIB_DDLUDF.GetCursor: TIB_Cursor;
begin
  if Database.FUDFCsr = nil then
  begin
    Database.FUDFCsr := Database.CreateCursor;
    with Database.FUDFCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$FUNCTION_TYPE,');  //SMALLINT,
      SQL.Add('M.RDB$MODULE_NAME,');
      SQL.Add('M.RDB$ENTRYPOINT,');
      SQL.Add('M.RDB$RETURN_ARGUMENT,'); //SMALLINT,
      SQL.Add('M.RDB$SYSTEM_FLAG,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'FUNCTIONS M');
      SQL.Add('WHERE M.RDB$FUNCTION_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FUDFCsr;
end;

procedure TIB_DDLUDF.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FFunctionType := Columns[0].AsSmallint;
    FModuleName := Columns[1].AsString;
    FEntryPoint := Columns[2].AsString;
    FReturnArgumentPos := Columns[3].AsSmallint;
    FSystemFlag := (Columns[4].AsSmallint = 1);
    FDescription := Columns[5].AsString;
  end;
  if Trim(FModuleName) = EmptyStr then
    AddProblem(plError, E_DDL_MODULE_NAME_EMPTY);
  if Trim(FEntryPoint) = EmptyStr then
    AddProblem(plError, E_DDL_ENTRY_POINT_EMPTY);
end;

procedure TIB_DDLUDF.Reset;
begin
  inherited Reset;
  FFunctionType := 0;
  FModuleName := '';
  FEntryPoint := '';
  FReturnArgumentPos := 0;
  FreeListAndObjects(FParams);
end;

function TIB_DDLUDF.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  i, tmpCount: integer;
  tmpParam, outParam: TIB_DDLUDFParam;
  OnceThru: boolean;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'DECLARE EXTERNAL FUNCTION', ttNone);
      AddWords(wtIdentity, mkIdent(OutputName), ttEndLine);
      IncIndent;
      tmpCount := Self.Count[etUDFParam];
      i := 0;
      outParam := nil;
      while i < tmpCount do
      begin
        tmpParam := (Self.Entity[etUDFParam, i] as TIB_DDLUDFParam);
        with tmpParam do
        begin
          if IsOutputParameter then
          begin
            if (((FieldType in [14, 37, 40]) and (Mechanism > 0))
              or (FieldType = 261)) and (ReturnArgumentPos > 0) then
              FPositionalReturn := True;
            outParam := tmpParam;
          end;
        end;
        Inc(i);
      end;
      i := 0;
      OnceThru := false;
      while i < tmpCount do
      begin
        tmpParam := (Self.Entity[etUDFParam, i] as TIB_DDLUDFParam);
        if (tmpParam <> outParam) or tmpParam.PositionalReturn then
        begin
          if OnceThru then
            AddWords(wtDelimit, ',', ttEndLine);
          tmpParam.AddCode(ACode, APass);
          OnceThru := true;
        end;
        Inc(i);
      end;
      if outParam <> nil then
      begin
        StartNewLine;
        outParam.AddCodeReturns(ACode, APass);
      end
      else
      begin
        AddProblem(plWarning, E_DDL_NO_OUTPUT_PARAMETER);
        StartNewLine;
        AddWords(wtComment, E_DDL_NO_OUTPUT_PARAMETER, ttNone);
      end;
      StartNewLine;
      AddWords(wtReserved, 'ENTRY_POINT', ttNone);
      AddWords(wtString, EntryPoint, ttNone);
      AddWords(wtReserved, 'MODULE_NAME', ttNone);
      AddWords(wtString, ModuleName, ttTermLine);
      DecIndent;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



procedure TIB_DDLEntityWithPermit.BuildPermissionList;
var
  tmpList: TStringList;
  tmpPermit: TIB_DDLPermission;
begin
  // Permissions are one of the few things without a name.  This makes
  // it difficult to perform an incremental selection so we load the
  // list and create all instances at the same time.
  // Taking a slightly simplified approach over the one used by Claudio's
  // initial code, by handling every permission entry individually rather
  // than attempting to re-join individual field privileges back into
  // a single list.
  tmpList := TStringList.Create;
  try
    if Database.FPermissionCsr = nil then
    begin
      tmpPermit := TIB_DDLPermission.Create(Database, Self);
      tmpPermit.GetCursor;              // forces creation of permissioncsr
      FreeObj( tmpPermit );
    end;
    with Database.FPermissionCsr do
    begin
      Params.Columns[0].AsString := Self.Name;
      APIFirst;
      while not Eof do
      begin
        tmpPermit := TIB_DDLPermission.Create(Database, Self);
        // DO NOT call Initialise - we setup assignments here instead.
        with tmpPermit do // this section replaces what base init stuff
        begin
          if Initialised then
            Reset;
          FName := Fields.Columns[0].AsString;
          if Trim(FName) = EmptyStr then
            AddProblem(plWarning, E_DDL_NO_GRANTOR);
        end;
        tmpList.AddObject(Fields.Columns[0].AsString, tmpPermit);
        tmpPermit.AssignFromFields(Fields);
        APINext;
      end;
    end;
    //tmpList.Sorted := true;  Keep then in order retrieved
    FPermissions := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

function TIB_DDLEntityWithPermit.GetEntityList(EType: TIB_EntityType):
  TStringList;
begin
  if EType = etPermission then
  begin
    if FPermissions = nil then
      BuildPermissionList;
    Result := FPermissions;
  end
  else
    Result := inherited GetEntityList(EType);
end;

procedure TIB_DDLEntityWithPermit.Reset;
begin
  inherited Reset;
  FreeListAndObjects(FPermissions);
end;



procedure TIB_DDLEntityWithTrigger.BuildFieldList;
var
  tmpList: TStringList;
begin
  tmpList := TStringList.Create;
  if Database.FFieldListCsr = nil then
  begin
    Database.FFieldListCsr := Database.CreateCursor;
    with Database.FFieldListCsr do
    begin
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('M.RDB$FIELD_NAME');
      SQL.Add('FROM ' + RDB + 'RELATION_FIELDS M');
      SQL.Add('WHERE M.RDB$RELATION_NAME=:ENTITY_NAME');
      SQL.Add('ORDER BY M.RDB$FIELD_POSITION');
      Prepare;
    end;
  end;
  with Database.FFieldListCsr do
  try
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    while not Eof do
    begin
      tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    //tmpList.Sorted := true;  Keep them in order retrieved
    FFields := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

procedure TIB_DDLEntityWithTrigger.BuildTriggerList;
var
  tmpList: TStringList;
begin
  tmpList := TStringList.Create;
  if Database.FTriggerListCsr = nil then
  begin
    Database.FTriggerListCsr := Database.CreateCursor;
    with Database.FTriggerListCsr do
    begin
      SQL.Clear;
      SQL.Add('SELECT M.RDB$TRIGGER_NAME');
      SQL.Add('FROM ' + RDB + 'TRIGGERS M');
      SQL.Add('WHERE RDB$RELATION_NAME=:ENTITY_NAME');
      // We have to avoid extracting the automatic "check" triggers rather
      // than relying on the names we just avoid triggers that also exist in
      // the CHECK_CONSTRAINTS table.  As Claudio pointed out we need to be
      // careful of check constraints due to not-null fields that have the same
      // name as a trigger.  I think this does it :-)
      SQL.Add('AND NOT EXISTS( SELECT RDB$TRIGGER_NAME');
      SQL.Add('  FROM ' + RDB + 'CHECK_CONSTRAINTS C');
      SQL.Add('  JOIN ' + RDB + 'RELATION_CONSTRAINTS R');
      SQL.Add('  ON R.RDB$CONSTRAINT_NAME=C.RDB$CONSTRAINT_NAME');
      SQL.Add('  WHERE C.RDB$TRIGGER_NAME=M.RDB$TRIGGER_NAME');
      SQL.Add('  AND R.RDB$CONSTRAINT_NAME IS NULL )');
      SQL.Add('ORDER BY RDB$TRIGGER_TYPE, RDB$TRIGGER_SEQUENCE');
      Prepare;
    end;
  end;
  with Database.FTriggerListCsr do
  try
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    while not Eof do
    begin
      tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    //tmpList.Sorted := true;  Keep them in order retrieved
    FTriggers := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

function TIB_DDLEntityWithTrigger.GetEntityList(EType: TIB_EntityType): TStringList;
begin
  case EType of
    etTrigger:
      begin
        if FTriggers = nil then
          BuildTriggerList;
        Result := FTriggers;
      end;
    etTableField, etViewField:
      begin
        if FFields = nil then
          BuildFieldList;
        Result := FFields;
      end;
  else
    Result := inherited GetEntityList(EType);
  end;
end;

procedure TIB_DDLEntityWithTrigger.Reset;
begin
  inherited Reset;
  FreeListAndObjects(FFields);
  FreeListAndObjects(FTriggers);
end;



function TIB_DDLTable.GetCursor: TIB_Cursor;
begin
  if Database.FTableCsr = nil then
  begin
    Database.FTableCsr := Database.CreateCursor;
    with Database.FTableCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$VIEW_BLR,');
      SQL.Add('M.RDB$VIEW_SOURCE,');
      SQL.Add('M.RDB$RELATION_ID,');    // smallint
      SQL.Add('M.RDB$SYSTEM_FLAG,');    // smallint => Boolean
      SQL.Add('M.RDB$DBKEY_LENGTH,');   // smallint
      SQL.Add('M.RDB$FORMAT,');         // smallint
      SQL.Add('M.RDB$FIELD_ID,');       // smallint
      SQL.Add('M.RDB$SECURITY_CLASS,');
      SQL.Add('M.RDB$EXTERNAL_FILE,');
      SQL.Add('M.RDB$OWNER_NAME,');
      SQL.Add('M.RDB$DEFAULT_CLASS,');
      SQL.Add('M.RDB$FLAGS,');          // smallint
      SQL.Add('   (SELECT CAST(COUNT(*) AS INT) FROM ' + RDB +
        'VIEW_RELATIONS V');
      SQL.Add('   WHERE V.RDB$VIEW_NAME = M.RDB$RELATION_NAME)');
      SQL.Add('   AS VIEW_COUNT,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'RELATIONS M');
      SQL.Add('WHERE M.RDB$RELATION_NAME=:ENTITY_NAME');
      SQL.Add('AND M.RDB$VIEW_BLR IS NULL');
      Prepare;
    end;
  end;
  Result := Database.FTableCsr;
end;

procedure TIB_DDLTable.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FViewBlr := Columns[0].AsString;
    FViewSource := Trim(Columns[1].AsString);
    FRelationId := Columns[2].AsSmallInt;
    FSystemFlag := (Columns[3].AsSmallint = 1);
    FDbkeyLength := Columns[4].AsSmallInt;
    FFormatVersion := Columns[5].AsSmallInt;
    FFieldCount := Columns[6].AsSmallInt;
    FSecurityClass := Columns[7].AsString;
    FExternalFile := Columns[8].AsString;
    FOwnerName := Columns[9].AsString;
    FDefaultClass := Columns[10].AsString;
    FFlags := Columns[11].AsSmallInt;
    FViewCount := Columns[12].AsInteger;
    FDescription := Columns[13].AsString;
  end;
  FIsExternal := FExternalFile <> EmptyStr;
  if FViewCount > 0 then
    AddProblem(plWarning, E_DDL_VIEW_NO_BLR);
  if (FOwnerName = EmptyStr) then
    AddProblem(plMinor, E_DDL_NO_OWNER);
  if FFormatVersion > 200 then
    AddProblem(plWarning,
      Format(E_DDL_FORMAT_VERSION, [IntToStr(FFormatVersion)]));
  if FDbKeyLength <> 8 then
    AddProblem(plError, Format(E_DDL_DBKEY_LEN, [IntToStr(FDbKeyLength)]));
end;

procedure TIB_DDLTable.CreateConstraintCsr;
begin
  Database.FConstraintListCsr := Database.CreateCursor;
  with Database.FConstraintListCsr do
  begin
    SQL.Clear;
    SQL.Add('SELECT M.RDB$CONSTRAINT_NAME,');
    SQL.Add('M.RDB$CONSTRAINT_TYPE');
    SQL.Add('FROM ' + RDB + 'RELATION_CONSTRAINTS M');
    SQL.Add('WHERE RDB$RELATION_NAME=:ENTITY_NAME');
    Prepare;
  end;
end;

procedure TIB_DDLTable.BuildPrimaryKeyList;
var
  tmpList: TStringList;
begin
  tmpList := TStringList.Create;
  if Database.FConstraintListCsr = nil then
    CreateConstraintCsr;
  with Database.FConstraintListCsr do
  try
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    while not Eof do
    begin
      if Fields.Columns[1].AsString = 'PRIMARY KEY' then
        tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    //tmpList.Sorted := true;  Redundant - there should be only one
    FPrimaryKeys := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

procedure TIB_DDLTable.BuildUniqueKeyList;
var
  tmpList: TStringList;
begin
  tmpList := TStringList.Create;
  if Database.FConstraintListCsr = nil then
    CreateConstraintCsr;
  with Database.FConstraintListCsr do
  try
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    while not Eof do
    begin
      if Fields.Columns[1].AsString = 'UNIQUE' then
        tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    tmpList.Sorted := true;
    FUniqueKeys := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

procedure TIB_DDLTable.BuildForeignKeyList;
var
  tmpList: TStringList;
begin
  tmpList := TStringList.Create;
  if Database.FConstraintListCsr = nil then
    CreateConstraintCsr;
  with Database.FConstraintListCsr do
  try
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    while not Eof do
    begin
      if Fields.Columns[1].AsString = 'FOREIGN KEY' then
        tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    tmpList.Sorted := true;
    FForeignKeys := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

procedure TIB_DDLTable.BuildConstraintList;
var
  tmpList: TStringList;
  tmpStr: string;
begin
  tmpList := TStringList.Create;
  if Database.FConstraintListCsr = nil then
    CreateConstraintCsr;
  with Database.FConstraintListCsr do
  try
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    while not Eof do
    begin
      tmpStr := Fields.Columns[1].AsString;
      if not (
        (tmpStr = 'PRIMARY KEY') or
        (tmpStr = 'UNIQUE') or
        (tmpStr = 'FOREIGN KEY')
        ) then
        tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    tmpList.Sorted := true;
    FConstraints := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

procedure TIB_DDLTable.BuildIndexList;
var
  tmpList: TStringList;
begin
  tmpList := TStringList.Create;
  if Database.FIndexListCsr = nil then
  begin
    Database.FIndexListCsr := Database.CreateCursor;
    with Database.FIndexListCsr do
    begin
      // Avoid selecting indexes automatically defined for constraints.
      SQL.Clear;
      SQL.Add('SELECT M.RDB$INDEX_NAME ');
      SQL.Add('FROM ' + RDB + 'INDICES M');
      SQL.Add('WHERE RDB$RELATION_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  with Database.FIndexListCsr do
  try
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    while not Eof do
    begin
      tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    tmpList.Sorted := true;
    FIndexes := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

function TIB_DDLTable.GetEntityList(EType: TIB_EntityType): TStringList;
begin
  case EType of
    etPrimaryKey:
      begin
        if FPrimaryKeys = nil then
          BuildPrimaryKeyList;
        Result := FPrimaryKeys;
      end;
    etUniqueKey:
      begin
        if FUniqueKeys = nil then
          BuildUniqueKeyList;
        Result := FUniqueKeys;
      end;
    etForeignKey:
      begin
        if FForeignKeys = nil then
          BuildForeignKeyList;
        Result := FForeignKeys;
      end;
    etConstraint:
      begin
        if FConstraints = nil then
          BuildConstraintList;
        Result := FConstraints;
      end;
    etIndex:
      begin
        if FIndexes = nil then
          BuildIndexList;
        Result := FIndexes;
      end;
  else
    Result := inherited GetEntityList(EType);
  end;
end;

function TIB_DDLTable.AddIndexDef(fldlist: string): boolean;
var
  i, idx: integer;
  tmpstr: string;
begin
  if FIndexDupList = nil then
  begin
    FIndexDupList := TStringList.Create;
{$IFDEF IBO_VCL60_OR_GREATER}
    FIndexDupList.CaseSensitive := true;
{$ENDIF}
  end;
  idx := -1;
  for i := 0 to FIndexDupList.Count - 1 do
  begin
    if Length(FIndexDupList[i]) > Length(fldlist) then
    begin
      tmpstr := Copy(FIndexDupList[i], 1, Length(fldlist));
      if (tmpstr = fldlist) and (tmpstr[Length(tmpstr)] = ';') then
      begin
        idx := i;
        break;
      end;
    end
    else
    begin
      if Length(FIndexDupList[i]) < Length(fldlist) then
      begin
        tmpstr := Copy(fldlist, 1, Length(FIndexDupList[i]));
        if (tmpstr = FIndexDupList[i]) and (tmpstr[Length(tmpstr)] = ';') then
        begin
          FIndexDupList[i] := fldlist; // store the longer dup in the list
          idx := i;
        end;
      end
      else
      begin
        if (FIndexDupList[i] = fldlist) then
        begin
          idx := i;
        end;
      end;
    end;
  end;
  if (idx >= 0) then
    Result := false
  else
  begin
    FIndexDupList.Add(fldlist);
    Result := true;
  end;
end;

procedure TIB_DDLTable.Reset;
begin
  inherited Reset;
  FViewBlr := '';
  FViewSource := '';
  FRelationId := 0;
  FDbkeyLength := 0;
  FFormatVersion := 0;
  FFieldCount := 0;
  FSecurityClass := '';
  FExternalFile := '';
  FOwnerName := '';
  FDefaultClass := '';
  FFlags := 0;
  FViewCount := 0;
  FIsExternal := false;
  FreeListAndObjects(FPrimaryKeys);
  FreeListAndObjects(FUniqueKeys);
  FreeListAndObjects(FForeignKeys);
  FreeListAndObjects(FConstraints);
  FreeListAndObjects(FIndexes);
  FreeObj(FIndexDupList);
end;

function TIB_DDLTable.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  i, tmpCount: integer;
  tmpField: TIB_DDLTableField;
  tmpDomain: TIB_DDLDomain;
  OnceThru: boolean;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'CREATE TABLE', ttNone);
      AddWords(wtIdentity, mkIdent(OutputName), ttNone);
      if IsExternal then
      begin
        AddWords(wtReserved, 'EXTERNAL FILE', ttNone);
        AddWords(wtString, ExternalFile, ttNone);
      end;
      AddWords(wtNormal, '(', ttEndLine);
      tmpCount := Self.Count[etTableField];
      IncIndent;
      i := 0;
      OnceThru := false;
      while i < tmpCount do
      begin
        tmpField := (Self.Entity[etTableField, i] as TIB_DDLTableField);
        tmpDomain := tmpField.Domain;
        if tmpDomain = nil then
        begin
          AddProblem(plError,
            Format(E_DDL_NO_DOMAIN_FOR_FIELD, [mkIdent(Name)]));
          AddWords(wtComment,
            Format(E_DDL_NO_DOMAIN_FOR_FIELD, [mkIdent(Name)]), ttEndLine);
        end
        else
        begin
          // Special handling of computed fields.  Exclude when asked
          // and exclude during cpInit if the field has external relation
          // dependencies (such as an embedded select from a table or view).
          if tmpDomain.IsComputed and (
            (coIsolateAllComputed in Database.CodeOptions) or
            ((APass = cpInit) and tmpField.ExternalDepends) ) then
          begin
            // if debug then show the field that has been skipped
            if (coIncludeDebug in Database.CodeOptions) then
            begin
              StartNewLine;
              AddWords(wtComment, 'Computed Field: ' + tmpField.Name,
                ttEndLine);
            end;
          end
          else
          begin
            if OnceThru then
              AddWords(wtDelimit, ',', ttEndLine);
            tmpField.AddCode(ACode, APass);
            OnceThru := true;
          end;
        end;
        Inc(i);
      end;
      AddWords(wtNormal, ')', ttTermLine);
      DecIndent;
    end;
  end
  else                                  // APass = cpFinal
  begin
    // Originally I was trying to add all computed columns in a single
    // ALTER TABLE statement.  But this can present problems when trying to
    // manipulate the script to isolate dependancies.  So instead I issues
    // a separate ALTER TABLE for every computed column.  Ann Harrison says
    // that this wont result in unwanted increments to the versions in the
    // formats table, since these are only incremented on commit.
    with ACode do
    begin
      tmpCount := Self.Count[etTableField];
      i := 0;
      while i < tmpCount do
      begin
        tmpField := (Self.Entity[etTableField, i] as TIB_DDLTableField);
        tmpDomain := tmpField.Domain;
        // If coIsolateAllComputed is defined then all computed columns were
        // skipped during cpInit, so we output all computed columns here,
        // otherwise we only output computed columns with external depends
        // since they are always skipped during cpInit regardless of the
        // coIsolateAllComputing setting.
        if ((tmpDomain <> nil) and tmpDomain.IsComputed) and (
          (coIsolateAllComputed in Database.CodeOptions) or
          (tmpField.ExternalDepends) ) then
        begin
          AddWords(wtReserved, 'ALTER TABLE', ttNone);
          AddWords(wtIdentity, mkIdent(OutputName), ttEndLine);
          IncIndent;
          tmpField.AddCode(ACode, APass);
          TerminateLine;
          DecIndent;
        end;
        Inc(i);
      end;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLView.CompleteWithCheckOption;
const
  PossibleSeparators = #13#10#32#9;
var
  ipos, fpos: Integer;
begin
  Result := False;
  if FIsBinaryView then
    Exit;
  // The ugly anomaly exists only with views made with check option.
  fpos := Length(FViewSource);
  while (fpos > 0) and
    (Pos(FViewSource[fpos], PossibleSeparators) > 0) do
    Dec(fpos);
  ipos := fpos - 5;
  if (ipos > 0) and
    (UpperCase(Copy(FViewSource, ipos + 1, 5)) = 'CHECK') and
    (Pos(FViewSource[ipos], PossibleSeparators) > 0) then
  begin
    while (ipos > 0) and
      (Pos(ViewSource[ipos], PossibleSeparators) > 0) do
      Dec(ipos);
    while (ipos > 0) and
      (Pos(FViewSource[ipos], PossibleSeparators + #34#39) = 0) do
      Dec(ipos);
    if (ipos > 0) and
      (UpperCase(Copy(FViewSource, ipos + 1, 4)) = 'WITH') then
    begin
      Delete(FViewSource, ipos + 1, Length(FViewSource));
      FViewSource := FViewSource + 'WITH CHECK OPTION';
      Result := True;
    end;
  end;
end;

function TIB_DDLView.GetCursor: TIB_Cursor;
begin
  if Database.FViewCsr = nil then
  begin
    Database.FViewCsr := Database.CreateCursor;
    with Database.FViewCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$VIEW_BLR,');
      SQL.Add('M.RDB$VIEW_SOURCE,');
      SQL.Add('M.RDB$RELATION_ID,');    // smallint
      SQL.Add('M.RDB$SYSTEM_FLAG,');    // smallint => Boolean
      SQL.Add('M.RDB$DBKEY_LENGTH,');   // smallint
      SQL.Add('M.RDB$FORMAT,');         // smallint
      SQL.Add('M.RDB$FIELD_ID,');       // smallint
      SQL.Add('M.RDB$SECURITY_CLASS,');
      SQL.Add('M.RDB$EXTERNAL_FILE,');
      SQL.Add('M.RDB$OWNER_NAME,');
      SQL.Add('M.RDB$DEFAULT_CLASS,');
      SQL.Add('M.RDB$FLAGS,');          // smallint
      SQL.Add('   (SELECT CAST(COUNT(*) AS INT) FROM ' + RDB +
        'VIEW_RELATIONS V');
      SQL.Add('   WHERE V.RDB$VIEW_NAME = M.RDB$RELATION_NAME)');
      SQL.Add('   AS VIEW_COUNT,');
      SQL.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM ' + RDB +
        'VIEW_RELATIONS V');
      SQL.Add('   WHERE V.RDB$VIEW_NAME = M.RDB$RELATION_NAME)');
      SQL.Add('   AS RELATION_COUNT,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'RELATIONS M');
      SQL.Add('WHERE M.RDB$RELATION_NAME=:ENTITY_NAME');
      SQL.Add('AND M.RDB$VIEW_BLR IS NOT NULL');
      Prepare;
    end;
  end;
  Result := Database.FViewCsr;
end;

procedure TIB_DDLView.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FViewBlr := Columns[0].AsString;
    FViewSource := Trim(Columns[1].AsString);
    FRelationId := Columns[2].AsSmallInt;
    FSystemFlag := (Columns[3].AsSmallint = 1);
    FDbkeyLength := Columns[4].AsSmallInt;
    FFormatVersion := Columns[5].AsSmallInt;
    FFieldCount := Columns[6].AsSmallInt;
    FSecurityClass := Columns[7].AsString;
    FExternalFile := Columns[8].AsString;
    FOwnerName := Columns[9].AsString;
    FDefaultClass := Columns[10].AsString;
    FFlags := Columns[11].AsSmallInt;
    FViewCount := Columns[12].AsInteger;
    FRelationCount := Columns[13].AsSmallInt;
    FDescription := Columns[14].AsString;
  end;
  if FViewCount = 0 then
    AddProblem(plError, E_DDL_VIEW_NO_VIEW_RELATION);
  FIsBinaryView := FViewSource = EmptyStr;
  if FIsBinaryView then
    AddProblem(plError, E_DDL_NO_SOURCE_CODE)
  else
  begin
    if CompleteWithCheckOption then
      AddProblem(plMinor, E_DDL_WITH_CHECK_COMPLETION);
  end;
  // No BLR is considered minor because we dont actually need it
  // to try and reproduce the required DDL.
  if (FViewBlr = EmptyStr) and (coReportMinor in Database.CodeOptions) then
    AddProblem(plMinor, E_DDL_NO_BLR);
  if (FOwnerName = EmptyStr) then
    AddProblem(plMinor, E_DDL_NO_OWNER);
  if FFormatVersion > 200 then
    AddProblem(plWarning,
      Format(E_DDL_FORMAT_VERSION, [IntToStr(FFormatVersion)]));
  // Had to remove the dbkey length, things are not as simple as all that
  // with views.  Would have to investigate the type of join (eg left outer
  // joins dont get merged into dbkey) and whether any of the relations are
  // other views with different length dbkeys.
  //if FDbKeyLength <> 8 * FRelationCount then
  //  AddProblem('DbKey_Length should be ' + IntToStr(8 * FRelationCount) +
  //    ' but is ' + IntToStr(FDbKeyLength));
end;

procedure TIB_DDLView.Reset;
begin
  inherited Reset;
  FViewBlr := '';
  FViewSource := '';
  FRelationId := 0;
  FDbkeyLength := 0;
  FFormatVersion := 0;
  FFieldCount := 0;
  FSecurityClass := '';
  FExternalFile := '';
  FOwnerName := '';
  FDefaultClass := '';
  FFlags := 0;
  FViewCount := 0;
  FIsBinaryView := false;
  FIsFaultyView := false;
  FRelationCount := 0;
end;

function TIB_DDLView.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  i, tmpCount: integer;
  tmpField: TIB_DDLViewField;
  tmpTrigger: TIB_DDLTrigger;
  OnceThru, ShowFieldNames: boolean;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'CREATE VIEW', ttNone);
      AddWords(wtIdentity, mkIdent(OutputName), ttNone);
      tmpCount := Self.Count[etTableField];
      i := 0;
      ShowFieldNames := false;
      while i < tmpCount do
      begin
        tmpField := (Self.Entity[etViewField, i] as TIB_DDLViewField);
        if not tmpField.IsImplicit then
        begin
          ShowFieldNames := true;
          break;
        end;
        Inc(i);
      end;
      if ShowFieldNames then
      begin
        AddWords(wtNormal, '(', ttEndLine);
        IncIndent;
        i := 0;
        OnceThru := false;
        while i < tmpCount do
        begin
          tmpField := (Self.Entity[etViewField, i] as TIB_DDLViewField);
          if OnceThru then
            AddWords(wtDelimit, ',', ttEndLine);
          tmpField.AddCode(ACode, APass);
          OnceThru := true;
          Inc(i);
        end;
        AddWords(wtNormal, ')', ttEndLine);
        DecIndent;
      end
      else
        StartNewLine;
      AddWords(wtReserved, 'AS', ttEndLine);
      AddWords(wtNormal, ViewSource, ttTermLine);
      // On init passes we generate dummy trigger code as part of the view
      // definition so that it will be recognised as updateable.
      if APass = cpInit then
      begin
        i := 0;
        tmpTrigger := (Self.Entity[etTrigger, i] as TIB_DDLTrigger);
        while tmpTrigger <> nil do
        begin
          StartNewLine;
          tmpTrigger.AddTriggerCode( ACode, cpInit );
          Inc(i);
          tmpTrigger := (Self.Entity[etTrigger, i] as TIB_DDLTrigger);
        end;
      end;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



procedure TIB_DDLProcedure.BuildParamList;
var
  tmpList: TStringList;
begin
  tmpList := TStringList.Create;
  if Database.FProcParamListCsr = nil then
  begin
    Database.FProcParamListCsr := Database.CreateCursor;
    with Database.FProcParamListCsr do
    begin
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('M.RDB$PARAMETER_NAME');
      SQL.Add('FROM ' + RDB + 'PROCEDURE_PARAMETERS M');
      SQL.Add('WHERE M.RDB$PROCEDURE_NAME=:ENTITY_NAME');
      SQL.Add('ORDER BY M.RDB$PARAMETER_TYPE, M.RDB$PARAMETER_NUMBER');
      Prepare;
    end;
  end;
  with Database.FProcParamListCsr do
  try
    Params.Columns[0].AsString := Self.Name;
    APIFirst;
    while not Eof do
    begin
      tmpList.Add(Fields.Columns[0].AsString);
      APINext;
    end;
    //tmpList.Sorted := true;  Keep them in order retrieved
    FParams := tmpList;
  except
    FreeObj( tmpList );
    raise;
  end;
end;

function TIB_DDLProcedure.GetEntityList(EType: TIB_EntityType): TStringList;
begin
  if EType = etProcParam then
  begin
    if FParams = nil then
      BuildParamList;
    Result := FParams;
  end
  else
    Result := inherited GetEntityList(EType);
end;

function TIB_DDLProcedure.GetCursor: TIB_Cursor;
begin
  if Database.FProcedureCsr = nil then
  begin
    Database.FProcedureCsr := Database.CreateCursor;
    with Database.FProcedureCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$PROCEDURE_ID,');   //SMALLINT,
      SQL.Add('M.RDB$PROCEDURE_INPUTS,'); //SMALLINT,
      SQL.Add('M.RDB$PROCEDURE_OUTPUTS,'); //SMALLINT,
      SQL.Add('M.RDB$PROCEDURE_SOURCE,');
      SQL.Add('M.RDB$PROCEDURE_BLR,');
      SQL.Add('M.RDB$SECURITY_CLASS,');
      SQL.Add('M.RDB$OWNER_NAME,');
      SQL.Add('M.RDB$SYSTEM_FLAG,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'PROCEDURES M');
      SQL.Add('WHERE RDB$PROCEDURE_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FProcedureCsr;
end;

procedure TIB_DDLProcedure.AssignFromFields(ARow: TIB_Row);
var
  tmpSource: string;
begin
  with ARow do
  begin
    FProcedureId := Columns[0].AsSmallInt;
    FProcedureInputs := Columns[1].AsSmallInt;
    FProcedureOutputs := Columns[2].AsSmallInt;
    FProcedureSource := Columns[3].AsString;
    FProcedureBlr := Columns[4].AsString;
    FSecurityClass := Columns[5].AsString;
    FOwnerName := Columns[6].AsString;
    FSystemFlag := (Columns[7].AsSmallint = 1);
    FDescription := Columns[8].AsString;
  end;
  tmpSource := Trim(ProcedureSource);
  FIsBinaryProcedure := (tmpSource = EmptyStr);
  if FIsBinaryProcedure then
    AddProblem(plError, E_DDL_NO_SOURCE_CODE)
  else
  begin
    // short of writing a whole SQL parse this is the simplest useable test
    // to check for valid procedure body.
    if (UpperCase(Copy(tmpSource, 1, 5)) <> 'BEGIN') and
      (UpperCase(Copy(tmpSource, 1, 7)) <> 'DECLARE') and
      (UpperCase(Copy(tmpSource, 1, 2)) <> '/*') and
      (UpperCase(Copy(tmpSource, 1, 2)) <> '--') then
    begin
      FIsFaultyProcedure := True;
      AddProblem(plWarning, E_DDL_CORRUPT_SOURCE);
    end;
  end;
  // Null BLR is considered minor because we dont use it to
  // reproduce the DDL.
  if (FProcedureBlr = EmptyStr) and (coReportMinor in Database.CodeOptions) then
    AddProblem(plMinor, E_DDL_NO_BLR);
  if (FOwnerName = EmptyStr) then
    AddProblem(plMinor, E_DDL_NO_OWNER);
end;

procedure TIB_DDLProcedure.Reset;
begin
  inherited Reset;
  FProcedureId := 0;
  FProcedureInputs := 0;
  FProcedureOutputs := 0;
  FProcedureSource := '';
  FProcedureBlr := '';
  FSecurityClass := '';
  FOwnerName := '';
  //FRuntime: String;
  FIsBinaryProcedure := false;
  FIsFaultyProcedure := false;
  FreeListAndObjects(FParams);
end;

function TIB_DDLProcedure.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  i, tmpCount: integer;
  tmpParam: TIB_DDLProcParam;
  OnceThru, HasInput, HasOutput: boolean;
begin
  if IsBinaryProcedure then
  begin
    Result := 0;
    Exit;
  end;
  Result := ACode.EntryCount;
  with ACode do
  begin
    if (APass = cpInit) or (APass = cpFull) then
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'CREATE PROCEDURE', ttNone);
    end
    else
      AddWords(wtReserved, 'ALTER PROCEDURE', ttNone);
    AddWords(wtIdentity, mkIdent(OutputName), ttNone);
    tmpCount := Self.Count[etProcParam];
    i := 0;
    HasInput := false;
    HasOutput := false;
    while i < tmpCount do
    begin
      tmpParam := (Self.Entity[etProcParam, i] as TIB_DDLProcParam);
      if tmpParam.IsInputParameter then
        HasInput := true
      else
        if tmpParam.IsOutputParameter then
          HasOutput := true;
      if HasInput and HasOutput then
        break;
      Inc(i);
    end;
    if HasInput then
    begin
      AddWords(wtNormal, '(', ttEndLine);
      IncIndent;
      i := 0;
      OnceThru := false;
      while i < tmpCount do
      begin
        tmpParam := (Self.Entity[etProcParam, i] as TIB_DDLProcParam);
        if tmpParam.IsInputParameter then
        begin
          if OnceThru then
            AddWords(wtDelimit, ',', ttEndLine);
          tmpParam.AddCode(ACode, APass);
          OnceThru := true;
        end;
        Inc(i);
      end;
      AddWords(wtNormal, ')', ttEndLine);
      DecIndent;
    end
    else
      StartNewLine;
    if HasOutput then
    begin
      AddWords(wtReserved, 'RETURNS', ttNone);
      AddWords(wtNormal, '(', ttEndLine);
      IncIndent;
      i := 0;
      OnceThru := false;
      while i < tmpCount do
      begin
        tmpParam := (Self.Entity[etProcParam, i] as TIB_DDLProcParam);
        if tmpParam.IsOutputParameter then
        begin
          if OnceThru then
            AddWords(wtDelimit, ',', ttEndLine);
          tmpParam.AddCode(ACode, APass);
          OnceThru := true;
        end;
        Inc(i);
      end;
      AddWords(wtNormal, ')', ttEndLine);
      DecIndent;
    end
    else
    begin
      if not HasInput then
        StartNewLine;
    end;
    AddWords(wtReserved, 'AS', ttEndLine);
    if APass = cpInit then
    begin
      AddWords(wtReserved, 'BEGIN', ttEndLine);
      AddWords(wtNormal, 'EXIT', ttIntTermLine);
      AddWords(wtReserved, 'END', ttTermLine);
    end
    else
    begin
      AddWords(wtNormal, ProcedureSource, ttTermLine);
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLRole.GetCursor: TIB_Cursor;
begin
  if Database.FRoleCsr = nil then
  begin
    Database.FRoleCsr := Database.CreateCursor;
    with Database.FRoleCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$OWNER_NAME');
      SQL.Add('FROM ' + RDB + 'ROLES M');
      SQL.Add('WHERE M.RDB$ROLE_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FRoleCsr;
end;

procedure TIB_DDLRole.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FOwnerName := Columns[0].AsString;
  end;
  if (FOwnerName = EmptyStr) then
    AddProblem(plMinor, E_DDL_NO_OWNER);
end;

procedure TIB_DDLRole.Reset;
begin
  inherited Reset;
  FOwnerName := '';
end;

function TIB_DDLRole.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := ACode.EntryCount;
  if (APass = cpInit) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      if coIncludeDebug in Database.CodeOptions then
        AddWords(wtComment, 'Owner Was: ' + OwnerName, ttEndLine);
      AddWords(wtReserved, 'CREATE ROLE', ttNone);
      AddWords(wtIdentity, mkIdent(OutputName), ttTermLine);
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLIndex.GetCursor: TIB_Cursor;
begin
  if Database.FIndexCsr = nil then
  begin
    Database.FIndexCsr := Database.CreateCursor;
    with Database.FIndexCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$RELATION_NAME,');
      SQL.Add('M.RDB$INDEX_ID,');
      SQL.Add('M.RDB$UNIQUE_FLAG,');
      SQL.Add('M.RDB$SEGMENT_COUNT,');
      SQL.Add('M.RDB$INDEX_INACTIVE,');
      SQL.Add('M.RDB$INDEX_TYPE,'); //The manual is wrong, this field is used!
      SQL.Add('M.RDB$FOREIGN_KEY,');
      SQL.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM ' + RDB +
        'RELATION_CONSTRAINTS T');
      SQL.Add('   WHERE M.RDB$RELATION_NAME = T.RDB$RELATION_NAME');
      SQL.Add('   AND M.RDB$INDEX_NAME = T.RDB$INDEX_NAME)');
      SQL.Add('   AS CONSTRAINT_COUNT,');
      SQL.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM ' + RDB +
        'RELATION_CONSTRAINTS T2');
      SQL.Add('   WHERE M.RDB$RELATION_NAME = T2.RDB$RELATION_NAME');
      SQL.Add('   AND M.RDB$INDEX_NAME = T2.RDB$INDEX_NAME');
      SQL.Add('   AND T2.RDB$CONSTRAINT_TYPE = ' + QuotedStr('FOREIGN KEY') +
        ')');
      SQL.Add('   AS FK_COUNT,');
      SQL.Add('M.RDB$SYSTEM_FLAG,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'INDICES M');
      SQL.Add('WHERE M.RDB$INDEX_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  // We also need the dimensions...
  if Database.FIndexFieldsCsr = nil then
  begin
    Database.FIndexFieldsCsr := Database.CreateCursor;
    with Database.FIndexFieldsCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('S.RDB$FIELD_POSITION,');
      SQL.Add('S.RDB$FIELD_NAME');
      SQL.Add('FROM ' + RDB + 'INDEX_SEGMENTS S');
      SQL.Add('WHERE S.RDB$INDEX_NAME=:ENTITY_NAME');
      SQL.Add('ORDER BY S.RDB$FIELD_POSITION');
      Prepare;
    end;
  end;
  Result := Database.FIndexCsr;
end;

procedure TIB_DDLIndex.AssignFromFields(ARow: TIB_Row);
var
  IndexIdIsNull: Boolean;
  iterations: SmallInt;
  tmpflds: string;
begin
  with ARow do
  begin
    FRelationName := Columns[0].AsString;
    FIndexId := Columns[1].AsSmallInt;
    IndexIdIsNull := Columns[1].IsNull;
    FIsUnique := Columns[2].AsBoolean;
    FSegmentCount := Columns[3].AsSmallInt;
    FIndexInactive := Columns[4].AsBoolean;
    FIsAscending := not Columns[5].AsBoolean;
    FForeignKey := Columns[6].AsString;
    FIndexConstraintCount := Columns[7].AsSmallInt;
    FIndexFKeyCount := Columns[8].AsSmallInt;
    FSystemFlag := (Columns[9].AsSmallint = 1);
    FDescription := Columns[10].AsString;
  end;
  FIsImplicit := (FForeignKey <> EmptyStr) or (FIndexConstraintCount > 0);
  if IndexIdIsNull then
  begin
    if FIndexInactive then
      AddProblem(plWarning, E_DDL_INDEX_ID_NULL_INACTIVE)
    else
      AddProblem(plError, E_DDL_INDEX_ID_NULL_ACTIVE);
  end
  else
  begin
    if FIndexId < 1 then
      AddProblem(plError, Format(E_DDL_INVALID_INDEX_ID, [IntToStr(FIndexId)]));
  end;
  if (FForeignKey <> EmptyStr) and (FIndexFKeyCount = 0) then
    AddProblem(plWarning, E_DDL_FK_INDEX_NO_CONSTRAINT)
  else
  begin
    if (FForeignKey = EmptyStr) and (FIndexFKeyCount > 0) then
      AddProblem(plWarning, E_DDL_CONSTRAINT_NO_FK_INDEX);
  end;
  if (FIndexConstraintCount > 1) then
    AddProblem(plWarning,
      Format(E_DDL_INDEX_MULTI_USE, [IntToStr(FIndexConstraintCount)]));
  if FSegmentCount < 1 then
    AddProblem(plError, Format(E_DDL_INDEX_NO_FIELDS, [IntToStr(FSegmentCount)]));
  iterations := 0;
  if IsAscending then
    tmpflds := 'ASC;'
  else
    tmpflds := 'DES;';
  with Database.FIndexFieldsCsr do
  begin
    Params.Columns[0].AsString := Self.Name;
    if FFieldsList = nil then
      FFieldsList := TStringList.Create;
    FFieldsList.Clear;
    APIFirst;
    while not Eof do
    begin
      FFieldsList.Add(Fields.Columns[1].AsString);
      tmpflds := tmpflds + Fields.Columns[1].AsString + ';';
      APINext;
      Inc(iterations)
    end;
  end;
  if not(Parent as TIB_DDLTable).AddIndexDef(tmpflds) and
    (coReportMinor in Database.CodeOptions) then
    AddProblem(plMinor, Format(E_DDL_INDEX_DUPLICATE, [Parent.OutputName]));
  if (iterations <> FSegmentCount) then
    AddProblem(plError, Format(E_DDL_INDEX_SEG_MISMATCH, [Parent.OutputName,
      IntToStr(FSegmentCount), IntToStr(iterations)]));
end;

procedure TIB_DDLIndex.Reset;
begin
  inherited Reset;
  FRelationName := '';
  FIndexId := 0;
  FIsUnique := false;
  FSegmentCount := 0;
  FIndexInactive := false;
  FIsAscending := true;
  FForeignKey := '';
  FIndexConstraintCount := 0;
  FIndexFKeyCount := 0;
  FreeObj( FFieldsList );
end;

function TIB_DDLIndex.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  i: integer;
  tmpField: TIB_DDLEntity;
begin
  Result := ACode.EntryCount;
  if (APass = cpFinal) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'CREATE', ttNone);
      if IsUnique then
        AddWords(wtReserved, 'UNIQUE', ttNone);
      if not IsAscending then
        AddWords(wtReserved, 'DESCENDING', ttNone);
      AddWords(wtReserved, 'INDEX', ttNone);
      AddWords(wtIdentity, mkIdent(OutputName), ttEndLine);
      IncIndent;
      AddWords(wtReserved, 'ON', ttNone);
      AddWords(wtIdentity, mkIdent(Parent.OutputName), ttNone);
      AddWords(wtNormal, '(', ttNone);
      for i := 0 to FieldsList.Count - 1 do
      begin
        if i > 0 then
          AddWords(wtDelimit, ',', ttNone);
        tmpField := Parent.EntityByName[etTableField, FieldsList.Strings[i]];
        if tmpField = nil then
          AddWords(wtComment,
            Format(C_DDL_FIELD_NOT_FOUND, [FieldsList.Strings[i]]),
            ttNone)
        else
          AddWords(wtIdentity, mkIdent(tmpField.OutputName), ttNone)
      end;
      AddWords(wtNormal, ')', ttTermLine);
      DecIndent;
      if IndexInactive then
      begin
        AddWords(wtReserved, 'ALTER INDEX', ttNone);
        AddWords(wtIdentity, mkIdent(OutputName), ttEndLine);
        AddWords(wtReserved, 'INACTIVE', ttTermLine);
      end;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLConstraintBase.GetIndex: TIB_DDLIndex;
begin
  Result := (Parent.EntityByName[etIndex, IndexName] as TIB_DDLIndex);
end;

function TIB_DDLConstraintBase.GetCursor: TIB_Cursor;
begin
  if Database.FConstraintCsr = nil then
  begin
    Database.FConstraintCsr := Database.CreateCursor;
    with Database.FConstraintCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$RELATION_NAME,');
      SQL.Add('M.RDB$CONSTRAINT_TYPE,');
      SQL.Add('M.RDB$INDEX_NAME,');
      SQL.Add('RC.RDB$CONST_NAME_UQ,');
      SQL.Add('RC.RDB$UPDATE_RULE,');
      SQL.Add('RC.RDB$DELETE_RULE,');
      // This MAX is a trick to avoid "multiple records in singleton select error
      // msg and operates in the assumption that implicit triggers for check
      // constraints are the same for update and delete operations, by design.
      SQL.Add('(SELECT MAX(CC.RDB$TRIGGER_NAME) FROM ' + RDB +
        'CHECK_CONSTRAINTS CC');
      SQL.Add('WHERE M.RDB$CONSTRAINT_NAME = CC.RDB$CONSTRAINT_NAME)');
      SQL.Add('AS TRIGGERorFIELD_NAME,');
      SQL.Add('RCUQ.RDB$RELATION_NAME AS RDB$RELATION_UQ,');
      SQL.Add('IDXF.RDB$RELATION_NAME AS RDB$FOREIGN_TABLE,');
      SQL.Add('IDX.RDB$FOREIGN_KEY AS RDB$FOREIGN_INDEX');
      SQL.Add('FROM ' + RDB + 'RELATION_CONSTRAINTS M');
      SQL.Add('LEFT JOIN ' + RDB + 'REF_CONSTRAINTS RC');
      SQL.Add('ON M.RDB$CONSTRAINT_NAME = RC.RDB$CONSTRAINT_NAME');
      SQL.Add('LEFT JOIN ' + RDB + 'RELATION_CONSTRAINTS RCUQ');
      SQL.Add('ON RC.RDB$CONST_NAME_UQ = RCUQ.RDB$CONSTRAINT_NAME');
      SQL.Add('LEFT JOIN ' + RDB + 'INDICES IDX');
      SQL.Add('ON IDX.RDB$INDEX_NAME = M.RDB$INDEX_NAME');
      SQL.Add('LEFT JOIN ' + RDB + 'INDICES IDXF');
      SQL.Add('ON IDXF.RDB$INDEX_NAME = IDX.RDB$FOREIGN_KEY');
      SQL.Add('WHERE M.RDB$CONSTRAINT_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FConstraintCsr;
end;

procedure TIB_DDLConstraintBase.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FRelationName := Columns[0].AsString;
    FConstraintTypeName := Columns[1].AsString;
    FIndexName := Columns[2].AsString;
    FConstNameUq := Columns[3].AsString;
    FUpdateRuleName := Columns[4].AsString;
    FDeleteRuleName := Columns[5].AsString;
    FTriggerOrFieldName := Columns[6].AsString;
    FRelationUq := Columns[7].AsString;
    FForeignTable := Columns[8].AsString;
    FForeignIndex := Columns[9].AsString;
  end;
  if (Copy(FName, 1, 6) = 'INTEG_') and
    (Length(FName) > 6) and (FName[7] in ['1'..'9']) and
    (StrToIntDef(Copy(FName, 7, 31), 0) > 0) then
  begin
    // The INTEG_ prefix does not necessarily mean implicit just
    // that the constraint was not specifically named (or at least we
    // hope that is the case)
    FIsAutoNamed := true;
    // NOT NULL constraints should always be implicit and autonamed since
    // adding a not null constraint is not supported by the add constraint
    // syntax (at least it is not documented).
    // Still working on check constraints
    if (
      (FConstraintTypeName = 'NOT NULL')// or
      //(FConstraintTypeName = 'CHECK')
      ) then
      FIsImplicit := True;
  end;
  if not (
    (FConstraintTypeName = 'PRIMARY KEY') or
    (FConstraintTypeName = 'UNIQUE') or
    (FConstraintTypeName = 'FOREIGN KEY') or
    (FConstraintTypeName = 'NOT NULL') or
    (FConstraintTypeName = 'CHECK')
    ) then
  begin
    FIsFaultyConstraint := True;
    AddProblem(plError,
      Format(E_DDL_CONSTRAINT_OUT_OF_RANGE, [FConstraintTypeName]));
  end;
  if (FConstraintTypeName = 'NOT NULL') or
    (FConstraintTypeName = 'CHECK') then
  begin
    if FIndexName <> EmptyStr then
      AddProblem(plWarning,
        Format(E_DDL_CONSTRAINT_USING_INDEX, [FConstraintTypeName,
        FIndexName]));
  end
  else                                  // type is pk, uk or fk
  begin
    if FIndexName = EmptyStr then
      AddProblem(plWarning,
        Format(E_DDL_CONSTRAINT_NO_INDEX, [FConstraintTypeName]));
  end;
  if FConstraintTypeName = 'FOREIGN KEY' then
  begin
    if not (
      (FUpdateRuleName = 'RESTRICT') or
      (FUpdateRuleName = 'CASCADE') or
      (FUpdateRuleName = 'SET NULL') or
      (FUpdateRuleName = 'SET DEFAULT')
      ) then
    begin
      FIsFaultyConstraint := True;
      AddProblem(plError, Format(E_DDL_UPDATE_RULE_INVALID, [FUpdateRuleName]));
    end;
    if not (
      (FDeleteRuleName = 'RESTRICT') or
      (FDeleteRuleName = 'CASCADE') or
      (FDeleteRuleName = 'SET NULL') or
      (FDeleteRuleName = 'SET DEFAULT')
      ) then
    begin
      FIsFaultyConstraint := True;
      AddProblem(plError, Format(E_DDL_DELETE_RULE_INVALID, [FDeleteRuleName]));
    end;
    if FConstNameUq = EmptyStr then
    begin
      FIsFaultyConstraint := True;
      AddProblem(plError, E_DDL_PARENT_CONSTRAINT_EMPTY);
    end;
    if (ForeignTable = '') or (ForeignIndex = '') then
    begin
      FIsFaultyConstraint := True;
      AddProblem(plError, E_DDL_FOREIGN_NOT_DEFINED);
    end;
  end
  else                                  // not foreign key
  begin
    if FConstNameUq <> EmptyStr then
      AddProblem(plWarning, Format(E_DDL_PARENT_SHOULD_BE_EMPTY, [FConstNameUq]));
    if FUpdateRuleName <> EmptyStr then
      AddProblem(plWarning, Format(E_DDL_UPDATE_SHOULD_BE_EMPTY, [FUpdateRuleName]));
    if FDeleteRuleName <> EmptyStr then
      AddProblem(plWarning, Format(E_DDL_DELETE_SHOULD_BE_EMPTY, [FDeleteRuleName]));
  end;
end;

procedure TIB_DDLConstraintBase.Reset;
begin
  inherited Reset;
  FRelationName := '';
  FConstraintTypeName := '';
  FIndexName := '';
  FConstNameUq := '';
  FUpdateRuleName := '';
  FDeleteRuleName := '';
  FTriggerOrFieldName := '';
  FRelationUq := '';
  FIsFaultyConstraint := false;
end;



function TIB_DDLPrimaryKey.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  i: integer;
  tmpIdx: TIB_DDLIndex;
  tmpField: TIB_DDLEntity;
  IdxName: string;
begin
  Result := ACode.EntryCount;
  if (APass = cpFinal) or (APass = cpFull) then
  begin
    if Index = nil then
      IdxName := ''
    else
      IdxName := Index.OutputName;
    // no need to check systemflag or isimplicit, primary key index names
    // are always implicit
    if (not MatchingPrefix(IdxName, IB_DefaultRDBPrefix)) and
      (coKeepCustomIndexNames in Database.CodeOptions) and
      (Length(IdxName) > 0) then
    with ACode do
    begin
      Index.AddCode(ACode, cpFull);
      AddDescription( ACode );
      AddWords(wtReserved, 'INSERT INTO RDB$RELATION_CONSTRAINTS', ttEndLine);
      IncIndent;
      AddWords(wtNormal, '(RDB$CONSTRAINT_NAME, RDB$CONSTRAINT_TYPE, RDB$RELATION_NAME,', ttEndLine);
      AddWords(wtNormal, 'RDB$DEFERRABLE, RDB$INITIALLY_DEFERRED, RDB$INDEX_NAME)', ttEndLine);
      AddWords(wtReserved, 'VALUES', ttNone);
      AddWords(wtNormal, '(', ttNone);
      AddWords(wtString, OutputName, ttNone);
      AddWords(wtNormal, ', ''PRIMARY KEY'',', ttNone);
      AddWords(wtString, Parent.OutputName, ttNone);
      AddWords(wtNormal, ',', ttEndLine);
      AddWords(wtNormal, '''NO'', ''NO'', ', ttNone);
      AddWords(wtString, IdxName, ttNone);
      AddWords(wtNormal, ')', ttTermLine);
      DecIndent;
    end
    else
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'ALTER TABLE', ttNone);
      AddWords(wtIdentity, mkIdent(Parent.OutputName), ttEndLine);
      IncIndent;
      AddWords(wtReserved, 'ADD', ttNone);
      if IsImplicit or IsAutoNamed then
      begin
        if coIncludeDebug in Database.CodeOptions then
          AddWords(wtComment, 'CONSTRAINT ' + mkIdent(OutputName), ttEndLine);
      end
      else
      begin
        AddWords(wtReserved, 'CONSTRAINT ', ttNone);
        AddWords(wtIdentity, mkIdent(OutputName), ttEndLine);
      end;
      AddWords(wtReserved, 'PRIMARY KEY', ttNone);
      AddWords(wtNormal, '(', ttNone);
      tmpIdx := Index;
      if Index = nil then
        AddWords(wtComment, C_DDL_INDEX_NOT_FOUND, ttNone)
      else
      begin
        for i := 0 to tmpIdx.FieldsList.Count - 1 do
        begin
          if i > 0 then
            AddWords(wtDelimit, ',', ttNone);
          tmpField := Parent.EntityByName[etTableField,
            tmpIdx.FieldsList.Strings[i]];
          if tmpField = nil then
            AddWords(wtComment,
              Format(C_DDL_FIELD_NOT_FOUND, [tmpIdx.FieldsList.Strings[i]]),
              ttNone)
          else
            AddWords(wtIdentity, mkIdent(tmpField.OutputName), ttNone);
        end;
      end;
      // nb. In FB 1.5 and later the constraint index name defaults to the
      // same value as the constraint name, so there is no need to use the
      // 'USING' directive if there is already a match.
      if (not MatchingPrefix(IdxName, IB_DefaultRDBPrefix)) and
        (Database.FBVersion >= 1005000) and
        (Length(IdxName) > 0) and
        (IdxName <> OutputName) and
        not (coKeepCustomIndexNames in Database.CodeOptions) then
      begin
        AddWords(wtNormal, ')', ttEndLine);
        AddWords(wtReserved, 'USING', ttNone);
        if (Index.IsAscending) then
          AddWords(wtReserved, 'ASCENDING', ttNone)
        else
          AddWords(wtReserved, 'DESCENDING', ttNone);
        AddWords(wtReserved, 'INDEX', ttNone);
        AddWords(wtIdentity, mkIdent(IdxName), ttTermLine);
      end
      else
        AddWords(wtNormal, ')', ttTermLine);
      DecIndent;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLUniqueKey.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass):
  integer;
var
  i: integer;
  tmpIdx: TIB_DDLIndex;
  tmpField: TIB_DDLEntity;
  IdxName: string;
begin
  Result := ACode.EntryCount;
  if (APass = cpFinal) or (APass = cpFull) then
  begin
    if Index = nil then
      IdxName := ''
    else
      IdxName := Index.OutputName;
    // no need to check systemflag or isimplicit, foreign key index names
    // are always implicit
    if (not MatchingPrefix(IdxName, IB_DefaultRDBPrefix)) and
      (coKeepCustomIndexNames in Database.CodeOptions) and
      (Database.FBVersion < 1005000) and
      (Length(IdxName) > 0) then
    with ACode do
    begin
      Index.AddCode(ACode, cpFull);
      AddDescription( ACode );
      AddWords(wtReserved, 'INSERT INTO RDB$RELATION_CONSTRAINTS', ttEndLine);
      IncIndent;
      AddWords(wtNormal, '(RDB$CONSTRAINT_NAME, RDB$CONSTRAINT_TYPE, RDB$RELATION_NAME,', ttEndLine);
      AddWords(wtNormal, 'RDB$DEFERRABLE, RDB$INITIALLY_DEFERRED, RDB$INDEX_NAME)', ttEndLine);
      AddWords(wtReserved, 'VALUES', ttNone);
      AddWords(wtNormal, '(', ttNone);
      AddWords(wtString, OutputName, ttNone);
      AddWords(wtNormal, ', ''UNIQUE'',', ttNone);
      AddWords(wtString, Parent.OutputName, ttNone);
      AddWords(wtNormal, ',', ttEndLine);
      AddWords(wtNormal, '''NO'', ''NO'', ', ttNone);
      AddWords(wtString, IdxName, ttNone);
      AddWords(wtNormal, ')', ttTermLine);
      DecIndent;
    end
    else
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'ALTER TABLE', ttNone);
      AddWords(wtIdentity, mkIdent(Parent.OutputName), ttEndLine);
      IncIndent;
      AddWords(wtReserved, 'ADD', ttNone);
      if IsImplicit or IsAutoNamed then
      begin
        if coIncludeDebug in Database.CodeOptions then
          AddWords(wtComment, 'CONSTRAINT ' + mkIdent(OutputName), ttEndLine);
      end
      else
      begin
        AddWords(wtReserved, 'CONSTRAINT ', ttNone);
        AddWords(wtIdentity, mkIdent(OutputName), ttEndLine);
      end;
      AddWords(wtReserved, 'UNIQUE', ttNone);
      AddWords(wtNormal, '(', ttNone);
      tmpIdx := Index;
      if Index = nil then
        AddWords(wtComment, C_DDL_INDEX_NOT_FOUND, ttNone)
      else
      begin
        for i := 0 to tmpIdx.FieldsList.Count - 1 do
        begin
          if i > 0 then
            AddWords(wtDelimit, ',', ttNone);
          tmpField := Parent.EntityByName[etTableField,
            tmpIdx.FieldsList.Strings[i]];
          if tmpField = nil then
            AddWords(wtComment,
              Format(C_DDL_FIELD_NOT_FOUND, [tmpIdx.FieldsList.Strings[i]]),
              ttNone)
          else
            AddWords(wtIdentity, mkIdent(tmpField.OutputName), ttNone);
        end;
      end;
      // nb. In FB 1.5 and later the constraint index name defaults to the
      // same value as the constraint name, so there is no need to use the
      // 'USING' directive if there is already a match.
      if (not MatchingPrefix(IdxName, IB_DefaultRDBPrefix)) and
        (Database.FBVersion >= 1005000) and
        (Length(IdxName) > 0) and
        (IdxName <> OutputName) and
        not (coKeepCustomIndexNames in Database.CodeOptions) then
      begin
        AddWords(wtNormal, ')', ttEndLine);
        AddWords(wtReserved, 'USING', ttNone);
        if (Index.IsAscending) then
          AddWords(wtReserved, 'ASCENDING', ttNone)
        else
          AddWords(wtReserved, 'DESCENDING', ttNone);
        AddWords(wtReserved, 'INDEX', ttNone);
        AddWords(wtIdentity, mkIdent(IdxName), ttTermLine);
      end
      else
        AddWords(wtNormal, ')', ttTermLine);
      DecIndent;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLForeignKey.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  i: integer;
  tmpIdx: TIB_DDLIndex;
  tmpEnt, tmpField: TIB_DDLEntity;
  IdxName: string;
begin
  Result := ACode.EntryCount;
  if (APass = cpFinal) or (APass = cpFull) then
  begin
    if Index = nil then
      IdxName := ''
    else
      IdxName := Index.OutputName;
    // no need to check systemflag or isimplicit, foreign key index names
    // are always implicit
    if (not MatchingPrefix(IdxName, IB_DefaultRDBPrefix)) and
      (coKeepCustomIndexNames in Database.CodeOptions) and
      (Database.FBVersion < 1005000) and
      (Length(IdxName) > 0) then
    with ACode do
    begin
      Index.AddCode(ACode, cpFull);
      AddDescription( ACode );
      AddWords(wtReserved, 'INSERT INTO RDB$RELATION_CONSTRAINTS', ttEndLine);
      IncIndent;
      AddWords(wtNormal, '(RDB$CONSTRAINT_NAME, RDB$CONSTRAINT_TYPE, RDB$RELATION_NAME,', ttEndLine);
      AddWords(wtNormal, 'RDB$DEFERRABLE, RDB$INITIALLY_DEFERRED, RDB$INDEX_NAME)', ttEndLine);
      AddWords(wtReserved, 'VALUES', ttNone);
      AddWords(wtNormal, '(', ttNone);
      AddWords(wtString, OutputName, ttNone);
      AddWords(wtNormal, ', ''FOREIGN KEY'',', ttNone);
      AddWords(wtString, Parent.OutputName, ttNone);
      AddWords(wtNormal, ',', ttEndLine);
      AddWords(wtNormal, '''NO'', ''NO'', ', ttNone);
      AddWords(wtString, IdxName, ttNone);
      AddWords(wtNormal, ')', ttTermLine);
      DecIndent;
      AddWords(wtReserved, 'INSERT INTO RDB$REF_CONSTRAINTS', ttEndLine);
      IncIndent;
      AddWords(wtNormal, '(RDB$CONSTRAINT_NAME, RDB$CONST_NAME_UQ, RDB$MATCH_OPTION,', ttEndLine);
      AddWords(wtNormal, 'RDB$UPDATE_RULE, RDB$DELETE_RULE)', ttEndLine);
      AddWords(wtReserved, 'VALUES', ttNone);
      AddWords(wtNormal, '(', ttNone);
      AddWords(wtString, OutputName, ttNone);
      AddWords(wtNormal, ', ', ttNone );
      AddWords(wtString, ConstNameUq, ttNone);
      AddWords(wtNormal, ', ''FULL'', ', ttEndLine);
      AddWords(wtString, UpdateRuleName, ttNone);
      AddWords(wtNormal, ', ', ttEndLine );
      AddWords(wtString, DeleteRuleName, ttNone);
      AddWords(wtNormal, ')', ttTermLine);
      DecIndent;
    end
    else
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'ALTER TABLE', ttNone);
      AddWords(wtIdentity, mkIdent(Parent.OutputName), ttEndLine);
      IncIndent;
      AddWords(wtReserved, 'ADD', ttNone);
      if IsImplicit or IsAutoNamed then
      begin
        if coIncludeDebug in Database.CodeOptions then
          AddWords(wtComment, 'CONSTRAINT ' + mkIdent(OutputName), ttEndLine);
      end
      else
      begin
        AddWords(wtReserved, 'CONSTRAINT ', ttNone);
        AddWords(wtIdentity, mkIdent(OutputName), ttEndLine);
      end;
      AddWords(wtReserved, 'FOREIGN KEY', ttNone);
      AddWords(wtNormal, '(', ttNone);
      tmpIdx := Index;
      if tmpIdx = nil then
        AddWords(wtComment, C_DDL_INDEX_NOT_FOUND, ttNone)
      else
      begin
        for i := 0 to tmpIdx.FieldsList.Count - 1 do
        begin
          if i > 0 then
            AddWords(wtDelimit, ',', ttNone);
          tmpField := Parent.EntityByName[etTableField,
            tmpIdx.FieldsList.Strings[i]];
          if tmpField = nil then
            AddWords(wtComment,
              Format(C_DDL_FIELD_NOT_FOUND, [tmpIdx.FieldsList.Strings[i]]),
              ttNone)
          else
            AddWords(wtIdentity, mkIdent(tmpField.OutputName), ttNone);
        end;
      end;
      AddWords(wtNormal, ')', ttEndLine);
      if (ForeignTable = '') or (ForeignIndex = '') then
        AddWords(wtComment, C_DDL_NO_FOREIGN_RELATION, ttEndLine)
      else
      begin
        tmpEnt := Database.EntityByName[etTable, ForeignTable];
        if tmpEnt = nil then
          AddWords(wtComment, Format(C_DDL_FOREIGN_NOT_FOUND, [ForeignTable]),
            ttEndLine)
        else
        begin
          tmpIdx := (tmpEnt.EntityByName[etIndex, ForeignIndex] as TIB_DDLIndex);
          if tmpIdx = nil then
            AddWords(wtComment,
              Format(C_DDL_FOREIGN_IDX_NOT_FOUND, [ForeignIndex]), ttEndLine)
          else
          begin
            AddWords(wtReserved, 'REFERENCES', ttNone);
            AddWords(wtIdentity, mkIdent(tmpIdx.Parent.OutputName), ttNone);
            AddWords(wtNormal, '(', ttNone);
            for i := 0 to tmpIdx.FieldsList.Count - 1 do
            begin
              if i > 0 then
                AddWords(wtDelimit, ',', ttNone);
                // By getting the actual field reference we support renaming
                // on output.
              tmpField := tmpEnt.EntityByName[etTableField,
                tmpIdx.FieldsList.Strings[i]];
              if tmpField = nil then
                AddWords(wtComment,
                  Format(C_DDL_FIELD_NOT_FOUND, [tmpIdx.FieldsList.Strings[i]]),
                  ttNone)
              else
                AddWords(wtIdentity, mkIdent(tmpField.OutputName), ttNone);
            end;
            AddWords(wtNormal, ')', ttEndLine);
          end;
        end;
      end;
        // Restrict is the default
      if UpdateRuleName <> 'RESTRICT' then
        AddWords(wtReserved, 'ON UPDATE ' + UpdateRuleName, ttEndLine);
      if DeleteRuleName <> 'RESTRICT' then
        AddWords(wtReserved, 'ON DELETE ' + DeleteRuleName, ttEndLine);
      // nb. In FB 1.5 and later the constraint index name defaults to the
      // same value as the constraint name, so there is no need to use the
      // 'USING' directive if there is already a match.
      if (not MatchingPrefix(IdxName, IB_DefaultRDBPrefix)) and
        (Database.FBVersion >= 1005000) and
        (Length(IdxName) > 0) and
        (IdxName <> OutputName) and
        not (coKeepCustomIndexNames in Database.CodeOptions) then
      begin
        AddWords(wtNormal, ')', ttEndLine);
        AddWords(wtReserved, 'USING', ttNone);
        if (Index.IsAscending) then
          AddWords(wtReserved, 'ASCENDING', ttNone)
        else
          AddWords(wtReserved, 'DESCENDING', ttNone);
        AddWords(wtReserved, 'INDEX', ttNone);
        AddWords(wtIdentity, mkIdent(IdxName), ttTermLine);
      end
      else
        TerminateLine;
      DecIndent;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLConstraint.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  tmpField: TIB_DDLEntity;
  tmpTrig: TIB_DDLTrigger;
begin
  Result := ACode.EntryCount;
  if (APass = cpFinal) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'ALTER TABLE', ttNone);
      AddWords(wtIdentity, mkIdent(Parent.OutputName), ttEndLine);
      IncIndent;
      AddWords(wtReserved, 'ADD', ttNone);
      if IsImplicit or IsAutoNamed then
      begin
        if coIncludeDebug in Database.CodeOptions then
          AddWords(wtComment, 'CONSTRAINT ' + mkIdent(OutputName), ttEndLine);
      end
      else
      begin
        AddWords(wtReserved, 'CONSTRAINT', ttNone);
        AddWords(wtIdentity, mkIdent(OutputName), ttEndLine);
      end;
      if ConstraintTypeName = 'NOT NULL' then
      begin
        tmpField := Parent.EntityByName[etTableField, TriggerOrFieldName];
        if tmpField = nil then
          AddWords(wtComment, Format(C_DDL_FIELD_NOT_FOUND, [TriggerOrFieldName]),
            ttNone)
        else
        begin
          AddWords(wtReserved, 'CHECK', ttNone);
          AddWords(wtNormal, '(', ttNone);
          AddWords(wtIdentity, mkIdent(tmpField.OutputName), ttNone);
          AddWords(wtReserved, 'IS NOT NULL', ttNone);
          AddWords(wtNormal, ')', ttTermLine);
        end;
      end
      else
      begin
        if ConstraintTypeName = 'CHECK' then
        begin
          tmpTrig := (Parent.EntityByName[etTrigger, TriggerOrFieldName] as
            TIB_DDLTrigger);
          if tmpTrig = nil then
            AddWords(wtComment, Format(C_DDL_TRIGGER_NOT_FOUND, [TriggerOrFieldName]),
              ttTermLine)
          else
          begin
            AddWords(wtNormal, tmpTrig.TriggerSource, ttTermLine);
          end;
        end
        else
          AddWords(wtComment, Format(C_DDL_INVALID_CONSTRAINT_TYPE,
            [ConstraintTypeName]), ttTermLine);
      end;
      DecIndent;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



// Not sure what this is about but Claudio set this up and it sounds important

procedure TIB_DDLTrigger.WipeOutAS;
const
  PossibleSeparators = #13#10#32#9;
var
  ipos, fpos: Integer;
begin
  if FIsBinaryTrigger or IsImplicit then Exit;
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
    // Dont remove the white space it may be intentional!
    //while (fpos <= Length(FTriggerSource)) and
    //      (Pos(FTriggerSource[fpos], PossibleSeparators) > 0) do
    //  Inc(fpos);
    Delete(FTriggerSource, 1, fpos - 1);
  end;
end;

function TIB_DDLTrigger.GetCursor: TIB_Cursor;
begin
  if Database.FTriggerCsr = nil then
  begin
    Database.FTriggerCsr := Database.CreateCursor;
    with Database.FTriggerCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$RELATION_NAME,');
      SQL.Add('M.RDB$SYSTEM_FLAG,');
      SQL.Add('M.RDB$TRIGGER_SEQUENCE,');
      SQL.Add('M.RDB$TRIGGER_TYPE,');
      SQL.Add('M.RDB$TRIGGER_SOURCE,');
      SQL.Add('M.RDB$TRIGGER_BLR,');
      SQL.Add('M.RDB$TRIGGER_INACTIVE,');
      SQL.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM ' + RDB +
        'DEPENDENCIES D');
      SQL.Add('   WHERE M.RDB$TRIGGER_NAME = D.RDB$DEPENDENT_NAME');
      SQL.Add('   AND M.RDB$RELATION_NAME = D.RDB$DEPENDED_ON_NAME');
      SQL.Add('   AND RDB$DEPENDENT_TYPE = 2 AND RDB$DEPENDED_ON_TYPE IN(0,1))');
      //  s.Add('   AND RDB$FIELD_NAME IS NULL)');
      SQL.Add('   AS USAGE_COUNT,');
      SQL.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM ' + RDB +
        'DEPENDENCIES D');
      SQL.Add('   WHERE M.RDB$TRIGGER_NAME = D.RDB$DEPENDENT_NAME');
      //  s.Add('   AND M.RDB$RELATION_NAME = D.RDB$DEPENDED_ON_NAME');
      SQL.Add('   AND RDB$DEPENDENT_TYPE = 2 AND RDB$DEPENDED_ON_TYPE IN(0,1))');
      //  s.Add('   AND RDB$FIELD_NAME IS NULL)');
      SQL.Add('   AS FULL_USAGE_COUNT,');
      // I had to do the join just in case we are "blessed" with someone having a
      // domain NOT NULL with the same name than a trigger! Murphy doesn't sleep.
      SQL.Add('   (SELECT CAST(COUNT(*) AS SMALLINT) FROM ' + RDB +
        'CHECK_CONSTRAINTS C');
      SQL.Add('   JOIN ' + RDB + 'RELATION_CONSTRAINTS RC');
      SQL.Add('   ON M.RDB$TRIGGER_NAME = C.RDB$TRIGGER_NAME');
      SQL.Add('   AND C.RDB$CONSTRAINT_NAME = RC.RDB$CONSTRAINT_NAME)');
      // Can also be FOREIGN KEY constraint types!
      //SQL.Add('   AND RC.RDB$CONSTRAINT_TYPE = ' + QuotedStr('CHECK') + ')');
      SQL.Add('   AS CHECK_COUNT,');
      SQL.Add('   (SELECT 1 FROM ' + RDB + 'DATABASE');
      SQL.Add('   WHERE EXISTS(SELECT * FROM ' + RDB + 'VIEW_RELATIONS V');
      SQL.Add('   WHERE V.RDB$VIEW_NAME = M.RDB$RELATION_NAME))');
      SQL.Add('   AS IS_FOR_VIEW,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'TRIGGERS M');
      SQL.Add('WHERE M.RDB$TRIGGER_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FTriggerCsr;
end;

procedure TIB_DDLTrigger.AssignFromFields(ARow: TIB_Row);
var
  tmpSource: string;
begin
  with ARow do
  begin
    FRelationName := Columns[0].AsString;
    FSystemFlag := (Columns[1].AsSmallInt <> 0);
    FTriggerSequence := Columns[2].AsSmallInt;
    FTriggerType := Columns[3].AsSmallInt;
    FTriggerSource := Trim(Columns[4].AsString);
    FTriggerBlr := Columns[5].AsString;
    FTriggerInactive := Columns[6].AsBoolean;
    FTriggerUsageCount := Columns[7].AsSmallInt;
    FTriggerFullUsageCount := Columns[8].AsSmallInt;
    FTriggerCheckCount := Columns[9].AsSmallInt;
    FIsForView := Columns[10].AsBoolean;
    FDescription := Columns[11].AsString;
  end;
  FIsImplicit := (FTriggerCheckCount > 0);
  WipeOutAS;
  tmpSource := Trim(TriggerSource);
  FIsBinaryTrigger := (tmpSource = EmptyStr);
  if FIsBinaryTrigger then
  begin
    if not(IsImplicit or SystemFlag) then
    begin
      if FIsForView then
        AddProblem(plWarning, Format(E_DDL_NO_BLR_WITH_CHECK, [FRelationName]))
      else                              //if IsImplicit then
      begin
        FIsFaultyTrigger := True;
        AddProblem(plError, E_DDL_NO_SOURCE_CODE);
      end;
    end;
  end
  else                                  // not binary trigger
  begin
    if tmpSource = EmptyStr then        // cannot use FIsBinaryTrigger here
    begin
      FIsFaultyTrigger := True;
      AddProblem(plError, E_DDL_NO_SOURCE_CODE);
    end
    else
    begin
      if not IsImplicit then
      begin
        if (UpperCase(Copy(tmpSource, 1, 5)) = 'CHECK') then
        begin
          FIsFaultyTrigger := True;
          AddProblem(plError, E_DDL_TRIGGER_LOST_CHECK);
        end
        else
        begin
          if (UpperCase(Copy(tmpSource, 1, 5)) <> 'BEGIN') and
            (UpperCase(Copy(tmpSource, 1, 7)) <> 'DECLARE') and
            (UpperCase(Copy(tmpSource, 1, 2)) <> '/*') and
            (UpperCase(Copy(tmpSource, 1, 2)) <> '--') then
          begin
            FIsFaultyTrigger := True;
            AddProblem(plWarning, E_DDL_CORRUPT_SOURCE);
          end;
        end;
      end;
    end;
  end;
  // Trigger type in FB 1.5 and later can be any non-zero
  // combination of bits 0..6 (minus 1)
  if (((Database.FBVersion < 1005000) and not (FTriggerType in [1..6])) or
    ((Database.FBVersion >= 1005000) and not (FTriggerType in [1..126]))) then
  begin
    FIsFaultyTrigger := True;
    AddProblem(plError, Format(E_DDL_UNKNOWN_TRIGGER_TYPE, [IntToStr(FTriggerType)]));
  end;
  // No BLR is considered minor because we dont use it to produce DDL
  if (FTriggerBlr = EmptyStr) and (coReportMinor in Database.CodeOptions) then
    AddProblem(plMinor, E_DDL_NO_BLR);
  if FTriggerSequence < 0 then
    AddProblem(plWarning, Format(E_DDL_NEGATIVE_SEQUENCE, [IntToStr(FTriggerSequence)]));
  if (FRelationName = EmptyStr) then
    AddProblem(plWarning, E_DDL_NO_TARGET_RELATION);
  if (FTriggerFullUsageCount = 0) and not SystemFlag then
    AddProblem(plSuspicious, E_DDL_NOT_IN_DEPENDENCIES)
  else
  begin
    if (FTriggerUsageCount = 0) and not SystemFlag then
      AddProblem(plSuspicious, E_DDL_SUSPICIOUS_TRIGGER);
  end;
  if IsImplicit then
  begin
    // Was test for zero, but foreign key implicit triggers can apparently be 1
    if FTriggerSequence > 1 then
      AddProblem(plWarning,
        Format(E_DDL_INVALID_TRIGGER_SEQ, [IntToStr(FTriggerSequence)]));
  end;
end;

// This is a specially isolated AddCode method in a manner not consistent
// with most of the other AddCode methods.  This method is called by the
// TIB_DDLView class to create dummy triggers as part of generating the actual
// view definition (so that the view is recognised as updateable ready for
// use inside procedures).  In this method the APass was set specifically
// by the caller and may not be consistent with the pass being performed
// by the encapsulating IB_Metadata component.  For example Views created
// during cpFinal pass will still call this using APass=cpInit when the view
// itself is generated.  The Trigger.AddCode method will call this method
// with cpFinal for views during cpFinal and cpFull for tables.
function TIB_DDLTrigger.AddTriggerCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := ACode.EntryCount;
  if IsBinaryTrigger then
  begin
    ACode.AddWords(wtComment, Format(C_DDL_NO_TRIGGER_SOURCE, [Name]),
      ttEndLine);
    Result := ACode.EntryCount - Result; // return number of additions
    Exit;
  end;
  with ACode do
  begin
    if (APass = cpInit) or (APass = cpFull) then
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'CREATE TRIGGER', ttNone);
      AddWords(wtIdentity, mkIdent(OutputName), ttNone);
      AddWords(wtReserved, 'FOR', ttNone);
      AddWords(wtIdentity, mkIdent(Parent.OutputName), ttEndLine);
    end
    else // APass = cpFinal
    begin
      AddWords(wtReserved, 'ALTER TRIGGER', ttNone);
      AddWords(wtIdentity, mkIdent(OutputName), ttNone);
    end;
    IncIndent;
    if TriggerInactive then
      AddWords(wtReserved, 'INACTIVE', ttEndLine);
    // trigger pre/post type
    if ((TriggerType + 1) and $01) = $00 then
      AddWords(wtReserved, 'BEFORE', ttNone)
    else
      AddWords(wtReserved, 'AFTER', ttNone);
    // trigger action type - slot 1 (only slot in FB < 1.5)
    case (((TriggerType + 1) shr 1) and 3) of
      0: AddWords(wtComment, Format(C_DDL_BAD_TRIGGER_TYPE,
        [IntToStr(TriggerType)]), ttEndLine);
      1: AddWords(wtReserved, 'INSERT', ttNone);
      2: AddWords(wtReserved, 'UPDATE', ttNone);
      3: AddWords(wtReserved, 'DELETE', ttNone);
    end;
    if Database.FBVersion >= 1005000 then
    begin
      case (((TriggerType + 1) shr 3) and 3) of
        1: AddWords(wtReserved, 'OR INSERT', ttNone);
        2: AddWords(wtReserved, 'OR UPDATE', ttNone);
        3: AddWords(wtReserved, 'OR DELETE', ttNone);
      end;
      case (((TriggerType + 1) shr 5) and 3) of
        1: AddWords(wtReserved, 'OR INSERT', ttNone);
        2: AddWords(wtReserved, 'OR UPDATE', ttNone);
        3: AddWords(wtReserved, 'OR DELETE', ttNone);
      end;
    end
    else
    begin
      if (not TriggerType in [1..6]) then
        AddWords(wtComment, Format(C_DDL_BAD_TRIGGER_TYPE,
          [IntToStr(TriggerType)]), ttEndLine);
    end;
    StartNewLine;
    if TriggerSequence > 0 then
    begin
      AddWords(wtReserved, 'POSITION', ttNone);
      AddWords(wtNumber, IntToStr(TriggerSequence), ttEndLine);
    end;
    DecIndent;
    AddWords(wtReserved, 'AS', ttEndLine);
    // If doing an Init pass we define an empty body, just like we do with
    // procedures - except that EXIT is not valid in triggers so to avoid
    // compilation errors we create a dummy variable and assign a value
    // to it.  (Just something so its not empty.)  We define an empty trigger
    // to avoid dependancy problems with updateable views.  By having the
    // triggers actually defined IB/FB will think a view is updateable and
    // so not causing problems with other triggers and procedures that may
    // have view update code in their bodies.  The main problem with doing it
    // this way is that it will generally add another increment to the table
    // format version (hopefully this will be resolved in the engine sometime).
    if APass = cpInit then
    begin
      AddWords(wtNormal, '  DECLARE VARIABLE DUMMY INTEGER;', ttEndLine);
      AddWords(wtNormal, 'BEGIN', ttEndLine);
      AddWords(wtNormal, '  DUMMY = 0;', ttEndLine);
      AddWords(wtNormal, 'END', ttTermLine);
    end
    else // APass is cpFinal or cpFull
    begin
      AddWords(wtNormal, TriggerSource, ttTermLine);
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;

procedure TIB_DDLTrigger.Reset;
begin
  inherited Reset;
  FRelationName := '';
  FTriggerSequence := 0;
  FTriggerType := 0;
  FTriggerSource := '';
  FTriggerBlr := '';
  FTriggerInactive := false;
  FTriggerUsageCount := 0;
  FTriggerFullUsageCount := 0;
  FTriggerCheckCount := 0;
  FIsForView := false;
  FIsBinaryTrigger := false;
  FIsFaultyTrigger := false;
end;

function TIB_DDLTrigger.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := 0;
  // No code generated during cpInit (views handle this directly).
  if APass = cpFull then
    Result := AddTriggerCode(ACode, cpFull)
  else
  begin
    if APass = cpFinal then
    begin
      if IsForView then
        Result := AddTriggerCode(ACode, cpFinal)
      else
        Result := AddTriggerCode(ACode, cpFull);
    end;
  end;
end;

function TIB_DDLPermission.GetCursor: TIB_Cursor;
begin
  // Beware: implemented and used differently than most
  // - see TIB_DDLEntityWithPermit.GetEntityList
  if Database.FPermissionCsr = nil then
  begin
    Database.FPermissionCsr := Database.CreateCursor;
    with Database.FPermissionCsr do
    begin
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('M.RDB$GRANTOR,');
      SQL.Add('M.RDB$USER,');
      SQL.Add('M.RDB$USER_TYPE,');
      SQL.Add('M.RDB$RELATION_NAME as RDB$OBJECT_NAME,');
      SQL.Add('M.RDB$OBJECT_TYPE,');
      SQL.Add('M.RDB$GRANT_OPTION,');
      SQL.Add('M.RDB$PRIVILEGE,');
      SQL.Add('M.RDB$FIELD_NAME');
      SQL.Add('FROM ' + RDB + 'USER_PRIVILEGES M');
      SQL.Add('WHERE RDB$RELATION_NAME=:ENTITY_NAME');
      SQL.Add('ORDER BY M.RDB$GRANTOR, M.RDB$USER, M.RDB$USER_TYPE,'
        + ' M.RDB$OBJECT_TYPE');
      Prepare;
    end;
  end;
  Result := Database.FPermissionCsr;
end;

procedure TIB_DDLPermission.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FUserName := Columns[1].AsString;
    FUserType := Columns[2].AsSmallInt;
    FObjectName := Columns[3].AsString;
    FObjectType := Columns[4].AsSmallInt;
    FGrantOrAdminOption := (Columns[5].AsSmallInt <> 0);
    if not (Columns[5].AsSmallInt in [0..2]) then
      AddProblem(plError, Format(E_DDL_GRANT_OUT_OF_RANGE, [
        IntToStr(Columns[5].AsSmallInt)]));
    if (Columns[5].AsSmallInt > 0) and
      not ((FUserType = 8) or (FUserType = 13)) then //8=user 13=role
      AddProblem(plWarning,
        Format(E_DDL_GRANT_TO_USER_TYPE, [IntToStr(FUserType)]));
    FPrivilege := Columns[6].AsString;
    FFieldName := Columns[7].AsString;
    if (Columns[7].IsNotNull) and
      not ((FPrivilege = 'U') or (FPrivilege = 'R')) then
      AddProblem(plWarning, E_DDL_GRANT_FIELDS);
  end;
  if (FPrivilege = 'X') and (FObjectType <> 5) then // 5=proc
    AddProblem(plWarning, Format(E_DDL_EXECUTE_TO_OBJECT, [IntToStr(FObjectType)]));
  if (FPrivilege <> 'X') and (FObjectType = 5) then
    AddProblem(plWarning, Format(E_DDL_BAD_PRIV_ON_PROC, [FPrivilege, FObjectName]));
  if (FPrivilege = 'M') and (FObjectType <> 13) then // 13=role
    AddProblem(plWarning, Format(E_DDL_MEMBER_TO_OBJECT, [IntToStr(FObjectType)]));
  if (FPrivilege <> 'M') and (FObjectType = 13) then
    AddProblem(plWarning, Format(E_DDL_BAD_PRIV_ON_ROLE, [FPrivilege, FObjectName]));
  // we simulate "implicit" for all SYSDBA privileges since such privileges
  // are indeed implicit in any object definition.
  if FUserName = 'SYSDBA' then
    FIsImplicit := true;
  // Note - because of simplified extraction from Claudio's original I am not
  // picking up any possible duplicates.  Perhaps this can be done when it
  // comes to writing out???
end;

procedure TIB_DDLPermission.Reset;
begin
  inherited Reset;
  FUserName := '';
  FUserType := 0;
  FObjectName := '';
  FObjectType := 0;
  FGrantOrAdminOption := false;
  FPrivilege := '';
  FFieldName := '';
end;

function TIB_DDLPermission.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  tmpEnt: TIB_DDLEntity;
begin
  Result := ACode.EntryCount;
  if (APass = cpFinal) or (APass = cpFull) then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      AddWords(wtReserved, 'GRANT', ttNone);
      case Privilege[1] of
        'S': AddWords(wtReserved, 'SELECT', ttNone);
        'D': AddWords(wtReserved, 'DELETE', ttNone);
        'I': AddWords(wtReserved, 'INSERT', ttNone);
        'U': AddWords(wtReserved, 'UPDATE', ttNone);
        'R': AddWords(wtReserved, 'REFERENCES', ttNone);
        'M': AddWords(wtComment, 'MEMBER OF', ttNone);
        'X': AddWords(wtReserved, 'EXECUTE', ttNone);
      else
        AddWords(wtComment, Format(C_DDL_BAD_PRIVILEGE, [Privilege]), ttNone);
      end;
      // we dont support renaming of field references at the moment
      if (FieldName <> '') and
        ((Privilege = 'U') or (Privilege = 'R')) then
      begin
        AddWords(wtNormal, '(', ttNone);
        AddWords(wtIdentity, mkIdent(FieldName), ttNone);
        AddWords(wtNormal, ')', ttNone);
      end;
      case ObjectType of
        0, 1: AddWords(wtReserved, 'ON TABLE', ttNone);
        5: AddWords(wtReserved, 'ON PROCEDURE', ttNone);
        13: ;                           // role
      else
        AddWords(wtReserved, 'ON', ttNone);
      end;
      AddWords(wtIdentity, mkIdent(Parent.OutputName), ttEndLine);
      IncIndent;
      AddWords(wtReserved, 'TO', ttNone);
      case UserType of
        0: AddWords(wtComment, 'TABLE', ttNone);
        1: AddWords(wtReserved, 'VIEW', ttNone);
        2: AddWords(wtReserved, 'TRIGGER', ttNone);
        5: AddWords(wtReserved, 'PROCEDURE', ttNone);
        8: AddWords(wtReserved, 'USER', ttNone);
        13: AddWords(wtComment, 'ROLE', ttNone);
      else
        AddWords(wtComment, 'UserType: ' + IntToStr(UserType), ttNone);
      end;
      tmpEnt := nil;
      case UserType of
        0: tmpEnt := Database.EntityByName[etTable, UserName];
        1: tmpEnt := Database.EntityByName[etView, UserName];
          //2:  // simply output the trigger name, dont support rename
        5: tmpEnt := Database.EntityByName[etProcedure, UserName];
          //8:  // simply output the user name
        13: tmpEnt := Database.EntityByName[etRole, UserName];
      end;
      if tmpEnt = nil then
        AddWords(wtIdentity, mkIdent(UserName), ttEndLine)
      else
        AddWords(wtIdentity, mkIdent(tmpEnt.OutputName), ttEndLine);
      if GrantOrAdminOption then
      begin
        if ObjectType = 13 then
          AddWords(wtReserved, 'WITH ADMIN OPTION', ttTermLine)
        else
          AddWords(wtReserved, 'WITH GRANT OPTION', ttTermLine);
      end
      else
        TerminateLine;
      DecIndent;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLUDFParam.GetCursor: TIB_Cursor;
begin
  // Beware: implemented and used differently than most
  // - see TIB_DDLUDF.GetEntityList
  if Database.FUDFParamCsr = nil then
  begin
    Database.FUDFParamCsr := Database.CreateCursor;
    with Database.FUDFParamCsr do
    begin
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('M.RDB$FUNCTION_NAME,');
      SQL.Add('M.RDB$ARGUMENT_POSITION,'); //SMALLINT,
      SQL.Add('M.RDB$MECHANISM,');      //SMALLINT,
      SQL.Add('M.RDB$FIELD_TYPE,');     //SMALLINT,
      SQL.Add('M.RDB$FIELD_SCALE,');    //SMALLINT,
      SQL.Add('M.RDB$FIELD_LENGTH,');   //SMALLINT,
      SQL.Add('M.RDB$FIELD_SUB_TYPE,'); //SMALLINT,
      SQL.Add('M.RDB$CHARACTER_SET_ID,'); //SMALLINT,
      if Database.Connection.Characteristics.dbODS_Version >= 10 then
        SQL.Add('M.RDB$FIELD_PRECISION,') //SMALLINT,
      else
        SQL.Add('null as RDB$FIELD_PRECISION,'); //SMALLINT,
      if Database.Connection.Characteristics.dbODS_Version >= 10 then
          SQL.Add('M.RDB$CHARACTER_LENGTH,') //SMALLINT,
      else
          SQL.Add('null as RDB$CHARACTER_LENGTH,'); //SMALLINT,
      SQL.Add('T.RDB$TYPE_NAME,');
      SQL.Add('   (SELECT T2.RDB$TYPE_NAME FROM ' + RDB + 'TYPES T2');
      SQL.Add('   WHERE M.RDB$FIELD_SUB_TYPE = T2.RDB$TYPE');
      SQL.Add('   AND T2.RDB$FIELD_NAME = ' + QuotedStr('RDB$FIELD_SUB_TYPE') +
        ')');
      SQL.Add('   AS RDB$SUB_TYPE_NAME,');
      SQL.Add('CS.RDB$CHARACTER_SET_NAME,');
      SQL.Add('CS.RDB$BYTES_PER_CHARACTER');
      // Thanks Borland for not including type=16 INT64 in system tables of IB6.
      // You make life harder and force the use of a LEFT JOIN.
      SQL.Add('FROM ' + RDB + 'FUNCTION_ARGUMENTS M LEFT JOIN ' + RDB +
        'TYPES T');
      SQL.Add('ON M.RDB$FIELD_TYPE = T.RDB$TYPE');
      SQL.Add('AND T.RDB$FIELD_NAME = ' + QuotedStr('RDB$FIELD_TYPE'));
      SQL.Add('LEFT JOIN ' + RDB + 'CHARACTER_SETS CS');
      SQL.Add('ON M.RDB$CHARACTER_SET_ID = CS.RDB$CHARACTER_SET_ID');
      SQL.Add('WHERE M.RDB$FUNCTION_NAME=:ENTITY_NAME');
      SQL.Add('ORDER BY M.RDB$ARGUMENT_POSITION');
      Prepare;
    end;
  end;
  Result := Database.FUDFParamCsr;
end;

procedure TIB_DDLUDFParam.AssignFromFields(ARow: TIB_Row);
var
  charsetWasNull: Boolean;
begin
  with ARow do
  begin
    FFunctionName := Columns[0].AsString;
    FArgumentPosition := Columns[1].AsSmallInt;
    FMechanism := Columns[2].AsSmallInt;
    FFieldType := Columns[3].AsSmallInt;
    FFieldScale := Columns[4].AsSmallInt;
    FFieldLength := Columns[5].AsSmallInt;
    FFieldSubType := Columns[6].AsSmallInt;
    FCharacterSetId := Columns[7].AsSmallInt;
    charsetWasNull := Columns[8].IsNull;
    FFieldPrecision := Columns[8].AsSmallInt;
    FCharacterLength := Columns[9].AsSmallInt;
    FTypeName := FieldTypeAsChar(FFieldType, Columns[10].AsString);
    FSubTypeName := AdjustField(FFieldType, FFieldSubType,
      FFieldPrecision, FTypeName, Columns[11].AsString,
      FFieldScale, FIsNumericOrDecimal, false,
      (coUseBigInt in Database.CodeOptions));
    // Very "interesting": here BLOBs don't accept a collation.
    if (FFieldType in [14,37,40]) //or
      //((FFieldType = 261) and (FFieldSubType in [0,1]))
      then
    begin
      FCharacterSetName := Columns[12].AsString;
      FBytesPerCharacter := Columns[13].AsSmallInt;
      { UDFs don't have Collation
      if FFieldType in [14, 37, 40]
      then FCollationName := BySQLNo(21).AsString }
    end
  end;
  FIsOutputParameter :=
    ((Parent as TIB_DDLUDF).FReturnArgumentPos = FArgumentPosition);
  if FIsOutputParameter then
    FIsFreeIt := (FMechanism < 0);
  if FArgumentPosition < 0 then
    AddProblem(plWarning, Format(E_DDL_BAD_ARG_POS, [IntToStr(FArgumentPosition)]));
  if (FFieldType = 16) and (FFieldSubType = 0) and (FTypeName[1] = '_') then
    AddProblem(plWarning, E_DDL_DOMAIN_TYPE_16 + GetParamDesc);
  // Was checking all blob subtypes, then just 0,1 (0 also supports a
  // charset declaration) but reverted to checking 1 (TEXT).  This avoids
  // the common problem of no character set defined for blob subtype 0, which
  // should not be defaulted to NONE anyway.
  if (FFieldType in [14,37,40]) or
    ((FFieldType = 261) and (FFieldSubType = 1)) then
  begin
    if charsetWasNull then
    begin
      FCharacterSetName := 'NONE';
      FBytesPerCharacter := 1;
      if (CharacterSetName <> Database.CharacterSetNormal) then
        AddProblem(plWarning, E_DDL_CHARSET_NULL_ASSUME_NONE + GetParamDesc);
    end
    else
    begin
      if FCharacterSetName = EmptyStr then
      begin
        FCharacterSetName := 'NONE';
        AddProblem(plWarning, E_DDL_CHARSET_BLANK_ASSUME_NONE + GetParamDesc);
      end;
    end;
  end;
  // Very "interesting": here BLOBs don't accept a collation.
  if (FFieldType in [14, 37, 40]) then
  begin
    if FCharacterLength = 0 then
    try
      FCharacterLength := FFieldLength div FBytesPerCharacter
    except
      AddProblem(plError, Format(E_DDL_BPC_ZERO_IN_CHARSET, [FCharacterSetName]) +
         GetParamDesc);
    end;
    if ((FCharacterLength = 0) or (FFieldLength mod FBytesPerCharacter <> 0))
      then
    begin
      AddProblem(plError, Format(E_DDL_FIELDLEN_MISMATCH,
        [IntToStr(FFieldLength), IntToStr(FBytesPerCharacter),
        FCharacterSetName]) + GetParamDesc);
      if FBytesPerCharacter = 0 then
      begin
        FFieldLength := FBytesPerCharacter;
        FCharacterLength := 1;
      end
      else
      begin
        // ensure enough room is allocated for full FieldLenth of data
        Inc(FFieldLength, (FBytesPerCharacter - (FFieldLength mod
          FBytesPerCharacter)));
        FCharacterLength := FFieldLength div FBytesPerCharacter
      end;
    end;
  end;
  if not (FFieldType in [14, 11, 27, 10, 16, 8, 9, 7, 12, 13, 35, 37, 40]) and
    (FFieldType <> 261) then
    AddProblem(plError, Format(E_DDL_UNKNOWN_FIELD_TYPE, [IntToStr(FFieldType)]) +
      GetParamDesc);
  // Here we accept happily CSTRING
  if FFieldType = 9 then
    AddProblem(plError, E_DDL_QUAD_IN_DSQL + GetParamDesc);
end;

function TIB_DDLUDFParam.GetParamDesc: string;
begin
  Result := ' (' + FFunctionName + '.' + IntToStr(FArgumentPosition) + ')';
end;

procedure TIB_DDLUDFParam.Reset;
begin
  inherited Reset;
  FFunctionName := '';
  FArgumentPosition := 0;
  FMechanism := 0;
  FFieldType := 0;
  FFieldScale := 0;
  FFieldLength := 0;
  FFieldSubType := 0;
  FCharacterSetId := 0;
  FFieldPrecision := 0;
  FCharacterLength := 0;
  FTypeName := '';
  FSubTypeName := '';
  FCharacterSetName := '';
  //FCollationName := '';
  FIsNumericOrDecimal := false;
  FBytesPerCharacter := 0;
  FIsOutputParameter := false;
  FIsFreeIt := false;
  FPositionalReturn := false;
end;

function TIB_DDLUDFParam.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := ACode.EntryCount;
  // No checking of APass - leave that to the parent object
  with ACode do
  begin
    AddDescription( ACode );
    AddWords(wtReserved, TypeName, ttNone);
    if FieldType in [14, 37, 40] then
      AddWords(wtNormal, '(' + IntToStr(CharacterLength) + ')', ttNone)
    else
    begin
      if IsNumericOrDecimal then
      begin
        if FieldPrecision = 0 then
        begin
          if FieldType = blr_short then
            FFieldPrecision := 4
          else
            if FieldType = blr_long then
              FFieldPrecision := 9
            else
              if FieldType = blr_quad then
                FFieldPrecision := 18
              else
                if FieldType = blr_int64 then
                  FFieldPrecision := 18
                else
                  if FieldType = blr_float then
                    FFieldPrecision := 11
                  else
                    if FieldType = blr_double then
                      FFieldPrecision := 15;
        end;
        AddWords(wtNormal, '(' + IntToStr(FieldPrecision) + ',' +
          IntToStr(-FieldScale) + ')', ttNone);
      end;
    end;
    //if FDimensions > 0 then
    //  AuxLine := AuxLine + Normal('[' + FDimensionsLine + ']')
    //else
    //begin
    //   if FFieldType = 261 then //FieldIsBlob
    //     [' SUB_TYPE', FSubTypeName, 'SEGMENT SIZE', IntToStr(FSegmentLength)]);
    if (FFieldType in [14,37,40]) //or
      //((FFieldType = 261) and (FFieldSubType in [0,1]))
      then
    begin
      if (coAlwaysCharSet in Database.CodeOptions) or
        (CharacterSetName <> Database.CharacterSetNormal) then
      begin
        AddWords(wtReserved, 'CHARACTER SET', ttNone);
        AddWords(wtNormal, CharacterSetName, ttNone);
      end
      else
      begin
        if coIncludeDebug in Database.CodeOptions then
          AddWords(wtComment, 'CHARACTER SET ' + CharacterSetName, ttNone);
      end;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;

function TIB_DDLUDFParam.AddCodeReturns(ACode: TIB_CodeFormatter; APass:
  TIB_DDLCodePass): integer;
var
  MechanismName: string;
begin
  Result := ACode.EntryCount;
  // No checking of APass - leave that to the parent object
  with ACode do
  begin
    if IsOutputParameter then
    begin
      AddDescription( ACode );
      if PositionalReturn then
      begin
        AddWords(wtReserved, 'RETURNS PARAMETER', ttNone);
        AddWords(wtNumber, IntToStr(ArgumentPosition), ttNone);
      end
      else
      begin
        AddWords(wtReserved, 'RETURNS', ttNone);
        Self.AddCode(ACode, APass);
      end;
      MechanismName := '';
      if FMechanism = 0 then
        MechanismName := 'BY VALUE'
      else
      begin
        if Mechanism < 0 then
          MechanismName := 'FREE_IT'
        else
          MechanismName := EmptyStr;
      end;
      if MechanismName <> '' then
        AddWords(wtReserved, MechanismName, ttNone);
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLTableField.GetDomain: TIB_DDLDomain;
begin
  Result := Database.EntityByName[etDomain, FieldSource] as TIB_DDLDomain;
end;

function TIB_DDLTableField.GetCursor: TIB_Cursor;
begin
  if Database.FTableFieldCsr = nil then
  begin
    Database.FTableFieldCsr := Database.CreateCursor;
    with Database.FTableFieldCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$RELATION_NAME,');
      SQL.Add('M.RDB$FIELD_SOURCE,');
      SQL.Add('M.RDB$SYSTEM_FLAG,');    // SmallInt => Boolean
      SQL.Add('M.RDB$BASE_FIELD,');
      SQL.Add('M.RDB$FIELD_POSITION,');
      SQL.Add('M.RDB$FIELD_ID,');
      SQL.Add('M.RDB$VIEW_CONTEXT,');
      SQL.Add('M.RDB$SECURITY_CLASS,');
      SQL.Add('M.RDB$NULL_FLAG,');
      SQL.Add('M.RDB$DEFAULT_SOURCE,');
      SQL.Add('M.RDB$COLLATION_ID,');
      SQL.Add('   (SELECT C.RDB$COLLATION_NAME FROM ' + RDB + 'COLLATIONS C');
      SQL.Add('   JOIN ' + RDB + 'FIELDS F');
      SQL.Add('   ON F.RDB$CHARACTER_SET_ID = C.RDB$CHARACTER_SET_ID');
      SQL.Add('   AND M.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME');
      SQL.Add('   AND M.RDB$COLLATION_ID = C.RDB$COLLATION_ID)');
      SQL.Add('   AS RDB$COLLATION_NAME,');
      SQL.Add('   (SELECT COUNT(RDB$DEPENDENT_NAME) FROM ' + RDB + 'DEPENDENCIES D');
      SQL.Add('   WHERE D.RDB$DEPENDENT_NAME = M.RDB$FIELD_SOURCE');
      SQL.Add('   AND D.RDB$DEPENDED_ON_TYPE = 0');
      SQL.Add('   AND D.RDB$DEPENDED_ON_NAME <> M.RDB$RELATION_NAME )');
      SQL.Add('   AS RDB$EXTERNAL_DEPEND_COUNT,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'RELATION_FIELDS M');
      SQL.Add('WHERE M.RDB$RELATION_NAME=:PARENT_NAME');
      SQL.Add('AND M.RDB$FIELD_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FTableFieldCsr;
end;

procedure TIB_DDLTableField.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FTableName := Columns[0].AsString;
    FFieldSource := Columns[1].AsString;
    FSystemFlag := Columns[2].AsBoolean;
    FBaseField := Columns[3].AsString;
    FBaseFieldWasEmpty := Columns[3].IsNull;
    FFieldPosition := Columns[4].AsSmallInt;
    FFieldId := Columns[5].AsSmallInt;
    FViewContext := Columns[6].AsSmallInt;
    FViewContextWasEmpty := Columns[6].IsNull;
    FSecurityClass := Columns[6].AsString;
    FIsMandatory := Columns[8].AsBoolean;
    FDefaultSource := Columns[9].AsString;
    FCollationId := Columns[10].AsSmallInt;
    FOverridesMandatory := Columns[8].IsNotNull;
    FOverridesDefault := Columns[9].IsNotNull;
    FOverridesCollation := Columns[10].IsNotNull;
    if FOverridesCollation then
      FCollationName := Columns[11].AsString;
    FExternalDepends := (Columns[12].AsInteger <> 0);
    FDescription := Columns[13].AsString;
  end;
  if (FSystemFlag and not Parent.SystemFlag) or
    (Parent.SystemFlag and not FSystemFlag) then
    AddProblem(plWarning, E_DDL_SYSTEM_FLAG_MISMATCH);
  if FFieldId < 0 then
    AddProblem(plWarning, Format(E_DDL_BAD_FIELD_ID, [IntToStr(FFieldId)]));
  if FFieldPosition < 0 then
    AddProblem(plError, Format(E_DDL_BAD_FIELD_POS, [IntToStr(FFieldPosition)]));
  if FOverridesDefault then
  begin
    if Copy(Trim(UpperCase(FDefaultSource)), 1, 7) <> 'DEFAULT' then
      AddProblem(plSuspicious, Format(E_DDL_SUSPICIOUS_DEFAULT, [FDefaultSource]))
    else
    begin
      FDefaultSource :=
        Trim(Copy(Trim(FDefaultSource), 8, Length(FDefaultSource)));
      if Length(FDefaultSource) = 0 then
      begin
        AddProblem(plError, E_DDL_VOID_DEFAULT);
        FOverridesDefault := false;
      end;
    end;
  end;
  if not FBaseFieldWasEmpty then
    AddProblem(plWarning, Format(E_DDL_BAD_TABLE_BASEFIELD, [FBaseField]));
  if not FViewContextWasEmpty then
    AddProblem(plWarning, Format(E_DDL_BAD_TABLE_VIEWCONTEXT, [IntToStr(FViewContext)]));
end;

procedure TIB_DDLTableField.Reset;
begin
  inherited Reset;
  FFieldSource := '';
  FSystemFlag := false;
  FTableName := '';
  //FQueryName := ''; // useless
  FBaseField := '';
  FFieldPosition := 0;
  FFieldId := 0;
  FViewContext := 0;
  FSecurityClass := '';
  FIsMandatory := false;                //NullFlag: SmallInt;
  FBaseFieldWasEmpty := false;          // Not available as property.
  FViewContextWasEmpty := false;        // Not available as property.
  FDefaultSource := '';
  FCollationId := 0;
  FCollationName := '';
  FOverridesMandatory := false;
  FOverridesDefault := false;
  FOverridesCollation := false;
end;

function TIB_DDLTableField.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  tmpDomain: TIB_DDLDomain;
  tmpCheck, tmpDefault: string;
  tmpNewLine: boolean;
begin
  Result := ACode.EntryCount;
  tmpDomain := GetDomain;
  // The only checking of APass is whether an 'ADD' prefix is
  // required for a presumed 'alter' statement if cpFinal.
  if tmpDomain <> nil then
  begin
    with ACode do
    begin
      AddDescription( ACode );
      if APass = cpFinal then
        AddWords(wtReserved, 'ADD', ttNone);
      AddWords(wtIdentity, mkIdent(OutputName), ttNone);
      IncIndent;
      if coRawFieldDefs in Database.CodeOptions then
      begin
        tmpNewLine := false;
        if coIncludeDebug in Database.CodeOptions then
          AddWords(wtComment, FieldSource, ttNone);
        if not tmpDomain.IsComputed then
        begin
          tmpDomain.AddTypeCode(ACode);
          tmpNewLine := tmpDomain.AddCharSetCode(ACode, false);
        end;
        if tmpDomain.AddComputedCode(ACode, false, tmpNewLine) then
          tmpNewLine := true;
        if OverridesCollation then
          tmpDomain.AddCollationCode(ACode, CollationId, CollationName,
            tmpNewLine)
        else
          if tmpDomain.IsImplicit then
            tmpDomain.AddCollationCode(ACode, -1, EmptyStr, tmpNewLine);
      end
      else
      begin
        tmpCheck := '';
        tmpDefault := '';
        tmpNewLine := false;
        if tmpDomain.IsImplicit or tmpDomain.IsComputed then
        begin
          if coIncludeDebug in Database.CodeOptions then
            AddWords(wtComment, FieldSource, ttNone);
          if not tmpDomain.IsComputed then
          begin
            tmpCheck := tmpDomain.ValidationSource;
            tmpDefault := tmpDomain.DefaultSource;
            tmpDomain.AddTypeCode(ACode);
            tmpNewLine := tmpDomain.AddCharSetCode(ACode, false);
          end;
        end
        else
          AddWords(wtIdentity, FieldSource, ttNone);
        if tmpDomain.AddComputedCode(ACode, false, tmpNewLine) then
          tmpNewLine := true;
        if DefaultSource <> '' then
          tmpDefault := DefaultSource;
        if tmpDomain.AddDefaultCode(ACode, tmpDefault, tmpNewLine) then
        begin
          tmpNewLine := true;
          tmpDomain.AddMandatoryCode(ACode, IsMandatory, false)
        end
        else
        begin
          if tmpDomain.AddMandatoryCode(ACode, IsMandatory, tmpNewLine) then
            tmpNewLine := true;
        end;
        if tmpDomain.AddCheckCode(ACode, tmpCheck, tmpNewLine) then
          tmpNewLine := true;
        if OverridesCollation then
          tmpDomain.AddCollationCode(ACode, CollationId, CollationName,
            tmpNewLine)
        else
          if tmpDomain.IsImplicit then
            tmpDomain.AddCollationCode(ACode, -1, EmptyStr, tmpNewLine);
      end;
      DecIndent;
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLViewField.GetCursor: TIB_Cursor;
begin
  if Database.FViewFieldCsr = nil then
  begin
    Database.FViewFieldCsr := Database.CreateCursor;
    with Database.FViewFieldCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$RELATION_NAME,');
      SQL.Add('M.RDB$FIELD_SOURCE,');
      SQL.Add('M.RDB$SYSTEM_FLAG,');    // SmallInt => Boolean
      SQL.Add('M.RDB$BASE_FIELD,');
      SQL.Add('M.RDB$FIELD_POSITION,');
      SQL.Add('M.RDB$FIELD_ID,');
      SQL.Add('M.RDB$VIEW_CONTEXT,');
      SQL.Add('M.RDB$SECURITY_CLASS,');
      SQL.Add('M.RDB$NULL_FLAG,');
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'RELATION_FIELDS M');
      SQL.Add('WHERE M.RDB$RELATION_NAME=:PARENT_NAME');
      SQL.Add('AND M.RDB$FIELD_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FViewFieldCsr;
end;

procedure TIB_DDLViewField.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FViewName := Columns[0].AsString;
    FFieldSource := Columns[1].AsString;
    FSystemFlag := Columns[2].AsBoolean;
    FBaseField := Columns[3].AsString;
    FBaseFieldWasEmpty := Columns[3].IsNull;
    FFieldPosition := Columns[4].AsSmallInt;
    FFieldId := Columns[5].AsSmallInt;
    FViewContext := Columns[6].AsSmallInt;
    FViewContextWasEmpty := Columns[6].IsNull;
    FSecurityClass := Columns[7].AsString;
    FIsMandatory := Columns[8].AsBoolean;
    FDescription := Columns[9].AsString;
  end;
  if (FSystemFlag and not Parent.SystemFlag) or
    (Parent.SystemFlag and not FSystemFlag) then
    AddProblem(plWarning, E_DDL_SYSTEM_FLAG_MISMATCH);
  FIsImplicit := (FViewContext > 0) and (FName = FBaseField);
  if FFieldId < 0 then
    AddProblem(plWarning, Format(E_DDL_BAD_FIELD_ID, [IntToStr(FFieldId)]));
  if FFieldPosition < 0 then
    AddProblem(plError, Format(E_DDL_BAD_FIELD_POS, [IntToStr(FFieldPosition)]));
  if IsMandatory then
    AddProblem(plMinor, E_DDL_MANDATORY_IN_VIEW);
  if FBaseFieldWasEmpty and (FViewCOntext > 0) then
    AddProblem(plWarning, E_DDL_BASEFIELD_EMPTY);
  if FViewContextWasEmpty then
    AddProblem(plWarning, E_DDL_VIEWCONTEXT_EMPTY);
  if FViewContext < 0 then
    AddProblem(plWarning, E_DDL_VIEWCONTEXT_NEGATIVE);
end;

procedure TIB_DDLViewField.Reset;
begin
  inherited Reset;
  FFieldSource := '';
  FSystemFlag := false;
  FViewName := '';
  //FQueryName := ''; // useless
  FBaseField := '';
  FFieldPosition := 0;
  FFieldId := 0;
  FViewContext := 0;
  FSecurityClass := '';
  FIsMandatory := false;                //NullFlag: SmallInt;
  FBaseFieldWasEmpty := false;          // Not available as property.
  FViewContextWasEmpty := false;        // Not available as property.
end;

function TIB_DDLViewField.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
begin
  Result := ACode.EntryCount;
  // No checking of APass - leave that to the parent object
  with ACode do
  begin
    AddDescription( ACode );
    AddWords(wtIdentity, mkIdent(OutputName), ttNone);
    if coIncludeDebug in Database.CodeOptions then
      AddWords(wtComment, FieldSource, ttNone);
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;



function TIB_DDLProcParam.GetDomain: TIB_DDLDomain;
begin
  Result := Database.EntityByName[etDomain, FieldSource] as TIB_DDLDomain;
end;

function TIB_DDLProcParam.GetCursor: TIB_Cursor;
begin
  if Database.FProcParamCsr = nil then
  begin
    Database.FProcParamCsr := Database.CreateCursor;
    with Database.FProcParamCsr do
    begin
      SQL.Add('SELECT');
      SQL.Add('M.RDB$PROCEDURE_NAME,');
      SQL.Add('M.RDB$FIELD_SOURCE,');
      SQL.Add('M.RDB$SYSTEM_FLAG,');    // SmallInt => Boolean
      SQL.Add('M.RDB$PARAMETER_NUMBER,'); //SMALLINT
      SQL.Add('M.RDB$PARAMETER_TYPE,'); //SMALLINT
      SQL.Add('M.RDB$DESCRIPTION');
      SQL.Add('FROM ' + RDB + 'PROCEDURE_PARAMETERS M');
      SQL.Add('WHERE M.RDB$PROCEDURE_NAME=:PARENT_NAME');
      SQL.Add('AND M.RDB$PARAMETER_NAME=:ENTITY_NAME');
      Prepare;
    end;
  end;
  Result := Database.FProcParamCsr;
end;

procedure TIB_DDLProcParam.AssignFromFields(ARow: TIB_Row);
begin
  with ARow do
  begin
    FProcedureName := Columns[0].AsString;
    FFieldSource := Columns[1].AsString;
    FSystemFlag := Columns[2].AsBoolean;
    FParameterNumber := Columns[3].AsSmallInt;
    FParameterType := Columns[4].AsSmallInt;
    FIsInputParameter := (FParameterType = 0);
    FIsOutputParameter := (FParameterType = 1);
    FDescription := Columns[5].AsString;
  end;
  if (FSystemFlag and not Parent.SystemFlag) or
    (Parent.SystemFlag and not FSystemFlag) then
    AddProblem(plWarning, E_DDL_SYSTEM_FLAG_MISMATCH);
  if not (FParameterType in [0..1]) then
    AddProblem(plError, Format(E_DDL_BAD_PARAM_TYPE, [IntToStr(FParameterType)]));
  if FParameterNumber < 0 then
    AddProblem(plWarning, Format(E_DDL_BAD_PARAM_NUM, [IntToStr(FParameterNumber)]));
end;

procedure TIB_DDLProcParam.Reset;
begin
  inherited Reset;
  FFieldSource := '';
  FSystemFlag := false;
  FProcedureName := '';
  FParameterNumber := 0;
  FParameterType := 0;
  FIsInputParameter := false;
  FIsOutputParameter := false;
end;

function TIB_DDLProcParam.AddCode(ACode: TIB_CodeFormatter; APass: TIB_DDLCodePass): integer;
var
  tmpDomain: TIB_DDLDomain;
begin
  Result := ACode.EntryCount;
  tmpDomain := GetDomain;
  // No checking of APass - leave that to the parent object
  if tmpDomain <> nil then
  begin
    with ACode do
    begin
      // only include the description on CREATE PROCEDURE
      if (APass = cpInit) or (APass = cpFull) then
        AddDescription( ACode );
      AddWords(wtIdentity, mkIdent(OutputName), ttNone);
      if coIncludeDebug in Database.CodeOptions then
        AddWords(wtComment, FieldSource, ttNone);
      tmpDomain.AddTypeCode(ACode);
      tmpDomain.AddCharSetCode(ACode, false);
    end;
  end;
  Result := ACode.EntryCount - Result;  // return number of additions
end;


// ---------------------------------------------------------------------------
// Implementation details for the actual TIB_Metadata component


constructor TIB_CustomMetadata.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDatabase := TIB_DDLDatabase.Create;
  FDatabase.RDBPrefix := IB_DefaultRDBPrefix;
  FDatabase.CodeOptions := [coSetGeneratorVal];
  FDatabase.OnDescription := DoHasDescription;
  FCode := TIB_CodeFormatter.Create;
  FCodePass := cpFull;
  FInsertCommits := [];
  FL1List := TList.Create;
  FCode.IntTerminator := IBCF_IntTerminatorDefault;
  FCode.Terminator := IBCF_TerminatorDefault;
  FCode.IndentSize := IBCF_IndentSizeDefault;
  FEntities := IB_DDLExtractTypes;
  FOnProgress := nil;
  FOnFilterByName := nil;
  FOnFilterByEntity := nil;
  FRunning := false;
  FTypeCount := 0;
  FTypesDone := 0;
  FCurrType := etDatabase;
  FCurrEntity := nil;
  FCurrCount := 0;
  FCurrDone := 0;
  FShowProblems := true;
end;

destructor TIB_CustomMetadata.Destroy;
begin
  FDatabase.OnDescription := nil;
  FreeObj( FL1List );
  FreeObj( FCode );
  FreeObj( FDatabase );
  inherited Destroy;
end;

function TIB_CustomMetadata.GetConnection: TIB_Connection;
begin
  Result := FDatabase.Connection;
end;

procedure TIB_CustomMetadata.SetConnection(AVal: TIB_Connection);
begin
  {$IFDEF IBO_VCL50_OR_GREATER}
  if (FDatabase.Connection <> nil) and
    (FDatabase.Connection.Owner <> Owner) then
    FDatabase.Connection.RemoveFreeNotification(Self);
  {$ENDIF}
  FDatabase.Connection := AVal;
  if (FDatabase.Connection <> nil) and
    (FDatabase.Connection.Owner <> Owner) then
    FDatabase.Connection.FreeNotification(Self);
end;

function TIB_CustomMetadata.GetTransaction: TIB_Transaction;
begin
  Result := FDatabase.Transaction;
end;

procedure TIB_CustomMetadata.SetTransaction(AVal: TIB_Transaction);
begin
  {$IFDEF IBO_VCL50_OR_GREATER}
  if (FDatabase.Transaction <> nil) and
    (FDatabase.Transaction.Owner <> Owner) then
    FDatabase.Transaction.RemoveFreeNotification(Self);
  {$ENDIF}
  FDatabase.Transaction := AVal;
  if (FDatabase.Transaction <> nil) and
    (FDatabase.Transaction.Owner <> Owner) then
    FDatabase.Transaction.FreeNotification(Self);
end;

function TIB_CustomMetadata.GetRDBPrefix: string;
begin
  Result := FDatabase.RDBPrefix;
end;

procedure TIB_CustomMetadata.SetRDBPrefix(AVal: string);
begin
  FDatabase.RDBPrefix := AVal;
end;

function TIB_CustomMetadata.IsRDBPrefixStored: boolean;
begin
  Result := not ((FDatabase.RDBPrefix = '') or
    (FDatabase.RDBPrefix = IB_DefaultRDBPrefix));
end;

function TIB_CustomMetadata.GetCodeOptions: TIB_DDLCodeOptions;
begin
  Result := FDatabase.CodeOptions;
end;

procedure TIB_CustomMetadata.SetCodeOptions(AVal: TIB_DDLCodeOptions);
begin
  FDatabase.CodeOptions := AVal;
end;

function TIB_CustomMetadata.GetIntTerminator: string;
begin
  Result := FCode.IntTerminator;
end;

procedure TIB_CustomMetadata.SetIntTerminator(AVal: string);
begin
  FCode.IntTerminator := AVal;
end;

function TIB_CustomMetadata.IsIntTerminatorStored: boolean;
begin
  Result := not ((IntTerminator = '') or
    (IntTerminator = IBCF_IntTerminatorDefault));
end;

function TIB_CustomMetadata.GetTerminator: string;
begin
  Result := FCode.Terminator;
end;

procedure TIB_CustomMetadata.SetTerminator(AVal: string);
begin
  FCode.Terminator := AVal;
end;

function TIB_CustomMetadata.IsTerminatorStored: boolean;
begin
  Result := not ((Terminator = '') or
    (Terminator = IBCF_TerminatorDefault));
end;

function TIB_CustomMetadata.GetIndentSize: integer;
begin
  Result := FCode.IndentSize;
end;

procedure TIB_CustomMetadata.SetIndentSize(AVal: integer);
begin
  FCode.IndentSize := AVal;
end;

function TIB_CustomMetadata.GetProblems: TStrings;
begin
  Result := FDatabase.Problems;
end;

function TIB_CustomMetadata.IsEntitiesStored: boolean;
begin
  Result := FEntities <> IB_DDLExtractTypes;
end;

procedure TIB_CustomMetadata.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (FDatabase <> nil) then
  begin
    if AComponent = IB_Connection then
      IB_Connection := nil
    else
      if AComponent = IB_Transaction then
        IB_Transaction := nil;
  end;
end;

function TIB_CustomMetadata.DoProgress: boolean;
begin
  Result := true;
  if Assigned(OnProgress) then
    OnProgress(Self, Result);
end;

function TIB_CustomMetadata.GetProgressPerc: smallint;
var
  tmpInc, tmpVal: integer;
begin
  Result := 0;
  if FTypeCount > 0 then
  begin
    // We base our calculations on 10000 for greater accuracy to begin
    // with and then divide the result by 100 to give a percentage.
    // We split 10000 by the number of types to be processed
    tmpInc := 10000 div FTypeCount;
    // And advance the result by the number of types already processed:
    tmpVal := tmpInc * FTypesDone;
    if FCurrCount > 0 then
      // Then use the FCurrCount and FCurrDone to show the appropriate
      // portion of the next section completed...
      tmpVal := tmpVal + ((tmpInc * FCurrDone) div FCurrCount);
    Result := smallint(tmpVal div 100);
  end;
end;

function TIB_CustomMetadata.IncludeEntityByName(AType: TIB_EntityType;
  AName: string): boolean;
begin
  Result := true;
  if Assigned(OnFilterByName) then
    OnFilterByName(Self, AType, AName, Result);
end;

function TIB_CustomMetadata.IncludeEntityCode(AType: TIB_EntityType;
  AEntity: TIB_DDLEntity): boolean;
begin
  if AEntity.IsImplicit or AEntity.SystemFlag then
    Result := false
  else
    Result := true;
  if Assigned(OnFilterByEntity) then
    OnFilterByEntity(Self, AType, AEntity, Result);
end;

procedure TIB_CustomMetadata.ExtractTypes(AEntities: TIB_DDLExtractTypes;
  AStrs: TStrings);
var
  et: TIB_EntityType;
  tmpBreak: boolean;
  oldCount: integer;
begin
  tmpBreak := false;
  IB_Connection.BeginBusy(true);
  try
    // Prefix the code with a terminator declaration - only if no code
    // already existing.  So if user has there own code to begin the
    // script they must also define the terminator declaration.
    if (Terminator <> ';') and (AStrs.Count <= 0) then
    begin
      FCode.AddWords(wtReserved, 'SET TERM', ttNone);
      FCode.AddWords(wtNormal, Terminator + ' ;', ttEndLine);
    end;
    // We need the database initialised to have the default character set
    if not FDatabase.Initialised then
      FDatabase.Init;
    oldCount := AStrs.Count;
    if etDatabase in AEntities then
    begin
      // give an opportunity to override secondary and shadow file
      // definitions before extracting the code
      if Assigned(OnDefineFiles) then
        OnDefineFiles(Self, FDatabase);
      if FDatabase.AddCode(FCode, FInternalPass) > 0 then
        FCode.StartNewLine;
      Inc(FTypesDone);
    end;
    if DoProgress then
    begin
      // Process level 1 entites first and in order of type definition
      for et := Low(TIB_L1EntityType) to High(TIB_L1EntityType) do
      begin
        if et in AEntities then
        begin
          if not ExtractL1Type(et, AStrs) then
          begin
            tmpBreak := true;
            break;
          end;
          Inc(FTypesDone);
        end;
      end;
      if ((AEntities * IB_DDLExtractL1Types) <> []) and
        ((InsertCommits * [icAfterLevel1,icAfterEachType]) = [icAfterLevel1])
        and (oldCount < AStrs.Count) then
      begin
        // Issue a commit between init and final
        FCode.AddWords(wtReserved, 'COMMIT', ttTermLine);
        FCode.StartNewLine;
        FCode.WriteText(AStrs);
        FCode.Clear;
      end;
      oldCount := AStrs.Count;
      if not tmpBreak then
      begin
        // Level 2 items are only accessible via their L1 parents.
        // We keep a list of extracted L1 items so that we can always
        // restrict our L2 extraction to those of actual interest.
        for et := Low(TIB_L2EntityType) to High(TIB_L2EntityType) do
        begin
          if et in AEntities then
          begin
            if not ExtractL2Type(et, AStrs) then
              break;
            Inc(FTypesDone);
          end;
        end;
      end;
      if ((AEntities * IB_DDLExtractL2Types) <> []) and
        ((InsertCommits * [icAfterLevel2,icAfterEachType]) = [icAfterLevel2])
        and (oldCount < AStrs.Count) then
      begin
        // Issue a commit between init and final
        FCode.AddWords(wtReserved, 'COMMIT', ttTermLine);
        FCode.StartNewLine;
        FCode.WriteText(AStrs);
        FCode.Clear;
      end;
    end;
    // Just to be sure it has all been written
    FCode.WriteText(AStrs);
    FCode.Clear;
  finally
    IB_Connection.EndBusy;
  end;
end;

function TIB_CustomMetadata.ExtractL1Type(AType: TIB_EntityType;
  AStrs: TStrings): boolean;
var
  i: integer;
  GotCode: boolean;
begin
  Result := true;                       // set to false if aborting early
  FCurrType := AType;
  FCurrEntity := nil;
  FCurrCount := FDatabase.Count[AType];
  FCurrDone := 0;
  GotCode := false;
  for i := 0 to FCurrCount - 1 do
  begin
    if IncludeEntityByName(AType, FDatabase.Names[AType, i]) then
    begin
      FCurrEntity := FDatabase.Entity[AType, i];
      if not DoProgress then
      begin
        Result := false;
        break;
      end;
      if IncludeEntityCode(AType, FCurrEntity) then
      begin
        // track processed entities for L2 extraction.
        if FL1List.IndexOf(FCurrEntity) < 0 then
          FL1List.Add(FCurrEntity);
        if FCurrEntity.AddCode(FCode, FInternalPass) > 0 then
        begin
          FCode.StartNewLine;           // add some spacing
          FCode.WriteText(AStrs);
          FCode.Clear;
          GotCode := true;
        end;
      end
      else
      begin
        // if ignoring dependancies then add to tracking list anyway
        if (coIgnoreDependencies in CodeOptions) and
          (FL1List.IndexOf(FCurrEntity) < 0) then
          FL1List.Add(FCurrEntity);
      end;
      FCurrEntity := nil;
    end
    else
    begin
      // if ignoring dependancies then add to tracking list anyway
      if (coIgnoreDependencies in CodeOptions) and
        (FL1List.IndexOf(FCurrEntity) < 0) then
        FL1List.Add(FCurrEntity);
    end;
    Inc(FCurrDone);
  end;
  if (icAfterEachType in InsertCommits) and GotCode then
  begin
    // Issue a commit between init and final
    FCode.AddWords(wtReserved, 'COMMIT', ttTermLine);
    FCode.StartNewLine;
    FCode.WriteText(AStrs);
    FCode.Clear;
  end;
end;

function TIB_CustomMetadata.ExtractL2Type(AType: TIB_EntityType;
  AStrs: TStrings): boolean;
var
  i, j, lim: integer;
  tmpEnt: TIB_DDLEntity;
  GotCode: boolean;
begin
  Result := true;                       // set to false if aborting early
  FCurrType := AType;
  FCurrEntity := nil;
  // note that FCurrCount/FCurrDone are using the full list of
  // processed L1 entities (not the actual count of the current
  // entity type).  So while this does not give an accurate count,
  // it does give a reasonable indication of progress.
  FCurrCount := FL1List.Count;
  FCurrDone := 0;
  GotCode := false;
  for i := 0 to FCurrCount - 1 do
  begin
    tmpEnt := TIB_DDLEntity(FL1List.Items[i]);
    FCurrEntity := nil;
    lim := tmpEnt.Count[AType] - 1;
    for j := 0 to lim do
    begin
      if IncludeEntityByName(AType, tmpEnt.Names[AType, j]) then
      begin
        FCurrEntity := tmpEnt.Entity[AType, j];
        if not DoProgress then
        begin
          Result := false;
          break;
        end;
        if IncludeEntityCode(AType, FCurrEntity) then
        begin
          if FCurrEntity.AddCode(FCode, FInternalPass) > 0 then
          begin
            FCode.StartNewLine;         // add some spacing
            FCode.WriteText(AStrs);
            FCode.Clear;
            GotCode := true;
          end;
        end;
        FCurrEntity := nil;
      end;
    end;
    Inc(FCurrDone);
  end;
  if (icAfterEachType in InsertCommits) and GotCode then
  begin
    // Issue a commit between init and final
    FCode.AddWords(wtReserved, 'COMMIT', ttTermLine);
    FCode.StartNewLine;
    FCode.WriteText(AStrs);
    FCode.Clear;
  end;
end;

procedure TIB_CustomMetadata.WriteProblems(AStrs: TStrings);
begin
  FCode.AddWords(wtNormal, '/* - - - - - - - - - - - - - - - -', ttEndLine);
  FCode.AddWords(wtNormal, 'List of possible problems detected', ttEndLine);
  FCode.AddWords(wtNormal, ' - - - - - - - - - - - - - - - - -', ttEndLine);
  if Problems.Count > 0 then
    FCode.AddWords(wtNormal, Problems.Text, ttEndLine)
  else
    FCode.AddWords(wtNormal, 'None', ttEndLine);
  FCode.AddWords(wtNormal, '- - - - - - - - - - - - - - - - */', ttEndLine);
  FCode.WriteText(AStrs);
  FCode.Clear;
end;

procedure TIB_CustomMetadata.DoHasDescription( ADatabase: TIB_DDLDatabase;
  AType: TIB_EntityType; AEntity: TIB_DDLEntity );
begin
  if Assigned( OnHasDescription ) then
    OnHasDescription( Self, AType, AEntity );
end;

procedure TIB_CustomMetadata.Extract(AInit, AFinal: TIB_DDLExtractTypes; AStrs:
  TStrings);
var
  et: TIB_EntityType;
  oldCount: integer;
begin
  if Running then
    Exit;
  FRunning := true;
  try
    // We can skip a fair amount of processing by removing various entity
    // types from AInit - since these types never produce any cpInit code.
    AInit := AInit - IB_DDLNoInitEntityTypes;
    // Similarly we can remove certain types from AFinal that dont produce
    // final phase output - remember to remove any items from this list that
    // end-up getting permissions (as these are produced in final phase).
    AFinal := AFinal - IB_DDLNoFinalEntityTypes;
    // Reset all the progress variables
    FTypeCount := 0;
    FTypesDone := 0;
    for et := Low(TIB_DDLExtractType) to High(TIB_DDLExtractType) do
    begin
      if et in AInit then
        Inc(FTypeCount);
      if et in AFinal then
        Inc(FTypeCount);
    end;
    FCurrType := etDatabase;
    FCurrEntity := nil;
    FCurrCount := 0;
    FCurrDone := 0;
    FCode.ResetIndent;
    if AInit <> [] then
    begin
      oldCount := AStrs.Count;
      // Set the internal pass flag to extract cpInit code
      FInternalPass := cpInit;
      // And perform the actual extract
      ExtractTypes(AInit, AStrs);
      if ((InsertCommits * [icAfterInitPass,icAfterEachType])=[icAfterInitPass])
        and (oldCount < AStrs.Count) then
      begin
        // Issue a commit between init and final
        FCode.AddWords(wtReserved, 'COMMIT', ttTermLine);
        FCode.StartNewLine;
        FCode.WriteText(AStrs);
        FCode.Clear;
      end;
    end;
    if AFinal <> [] then
    begin
      oldCount := AStrs.Count;
      // Set the internal pass flag to extract cpFinal code
      FInternalPass := cpFinal;
      // And perform the actual extract
      ExtractTypes(AFinal, AStrs);
      if ((InsertCommits*[icAfterFinalPass,icAfterEachType])=[icAfterFinalPass])
        and (oldCount < AStrs.Count) then
      begin
        // Issue a commit between init and final
        FCode.AddWords(wtReserved, 'COMMIT', ttTermLine);
        FCode.StartNewLine;
        FCode.WriteText(AStrs);
        FCode.Clear;
      end;
    end;
    if ShowProblems then
      WriteProblems(AStrs);
  finally
    FRunning := false;
  end;
end;

procedure TIB_CustomMetadata.ExtractFull(AEntities: TIB_DDLExtractTypes; AStrs:
  TStrings);
var
  et: TIB_EntityType;
begin
  if Running then
    Exit;
  FRunning := true;
  try
    // Reset all the progress variables
    FTypeCount := 0;
    FTypesDone := 0;
    for et := Low(TIB_DDLExtractType) to High(TIB_DDLExtractType) do
    begin
      if et in AEntities then
        Inc(FTypeCount);
    end;
    FCurrType := etDatabase;
    FCurrEntity := nil;
    FCurrCount := 0;
    FCurrDone := 0;
    FCode.ResetIndent;
    // Set the internal pass flag to control the extract process
    FInternalPass := cpFull;
    // And perform the actual extract
    ExtractTypes(AEntities, AStrs);
    if ShowProblems then
      WriteProblems(AStrs);
  finally
    FRunning := false;
  end;
end;

procedure TIB_CustomMetadata.ExtractToStrings(AStrs: TStrings);
begin
  if CodePass = cpFull then
    ExtractFull(Entities, AStrs)
  else
  begin
    if CodePass = cpInit then
      Extract(Entities, [], AStrs)
    else
    begin
      if CodePass = cpFinal then
        Extract([], Entities, AStrs)
      else // CodePass = cpAuto
        Extract(Entities, Entities, AStrs);
    end;
  end;
end;

procedure TIB_CustomMetadata.Reset;
begin
  FCode.Clear;
  FL1List.Clear;
end;

procedure TIB_CustomMetadata.ResetAll;
begin
  Reset;
  FDatabase.Reset;
end;




function EntityTypeToText(EType: TIB_EntityType): string;
begin
  Result := STR_DDL_UnnamedItem;
  case EType of
    etDatabase: Result := STR_DDL_etDatabase;
    etException: Result := STR_DDL_etException;
    etBlobFilter: Result := STR_DDL_etBlobFilter;
    etUDF: Result := STR_DDL_etUDF;
    etGenerator: Result := STR_DDL_etGenerator;
    etDomain: Result := STR_DDL_etDomain;
    etTable: Result := STR_DDL_etTable;
    etView: Result := STR_DDL_etView;
    etProcedure: Result := STR_DDL_etProcedure;
    etRole: Result := STR_DDL_etRole;
    etPrimaryKey: Result := STR_DDL_etPrimaryKey;
    etUniqueKey: Result := STR_DDL_etUniqueKey;
    etForeignKey: Result := STR_DDL_etForeignKey;
    etConstraint: Result := STR_DDL_etConstraint;
    etIndex: Result := STR_DDL_etIndex;
    etTrigger: Result := STR_DDL_etTrigger;
    etPermission: Result := STR_DDL_etPermission;
    etUDFParam: Result := STR_DDL_etUDFParam;
    etTableField: Result := STR_DDL_etTableField;
    etViewField: Result := STR_DDL_etViewField;
    etProcParam: Result := STR_DDL_etProcParam;
  end;
end;

function CodeOptionToText(AOpt: TIB_DDLCodeOption): string;
begin
  Result := STR_DDL_UnnamedItem;
  case AOpt of
    coCreateDatabase: Result := STR_DDL_coCreateDatabase;
    coSecondaryFiles: Result := STR_DDL_coSecondaryFiles;
    coDefineShadows: Result := STR_DDL_coDefineShadows;
    coSetGeneratorVal: Result := STR_DDL_coSetGeneratorVal;
    coResetExceptionNo: Result := STR_DDL_coResetExceptionNo;
    coRawFieldDefs: Result := STR_DDL_coRawFieldDefs;
    coIsolateAllComputed: Result := STR_DDL_coIsolateAllComputed;
    coReportMinor: Result := STR_DDL_coReportMinor;
    coAlwaysQuoted: Result := STR_DDL_coAlwaysQuoted;
    coAlwaysCharSet: Result := STR_DDL_coAlwaysCharSet;
    coIncludeDebug: Result := STR_DDL_coIncludeDebug;
    coDescripAsComment: Result := STR_DDL_coDescripAsComment;
    coIgnoreDependencies: Result := STR_DDL_coIgnoreDependencies;
    coKeepCustomIndexNames: Result := STR_DDL_coKeepCustomIndexNames;
    coUseBigInt: Result := STR_DDL_coUseBigInt;
  end;
end;

function CodePassToText(APass: TIB_DDLCodePassBase): string;
begin
  Result := STR_DDL_UnnamedItem;
  case APass of
    cpFull: Result := STR_DDL_cpFull;
    cpInit: Result := STR_DDL_cpInit;
    cpFinal: Result := STR_DDL_cpFinal;
    cpAuto: Result := STR_DDL_cpAuto;
  end;
end;

function ProblemLevelToText(PLvl: TIB_DDLProblemLevel): string;
begin
  Result := STR_DDL_UnnamedItem;
  case PLvl of
    plNone:       Result := STD_DDL_plNone;
    plMinor:      Result := STD_DDL_plMinor;
    plSuspicious: Result := STD_DDL_plSuspicious;
    plWarning:    Result := STD_DDL_plWarning;
    plError:      Result := STD_DDL_plError;
  end;
end;

function ProblemLevelToShortText(PLvl: TIB_DDLProblemLevel): string;
begin
  Result := STR_DDL_UnnamedItem;
  case PLvl of
    plNone:       Result := STD_DDL_plNone_s;
    plMinor:      Result := STD_DDL_plMinor_s;
    plSuspicious: Result := STD_DDL_plSuspicious_s;
    plWarning:    Result := STD_DDL_plWarning_s;
    plError:      Result := STD_DDL_plError_s;
  end;
end;

function GetTypeFromEntity(AEntity: TIB_DDLEntity): TIB_EntityType;
begin
  Result := etDatabase;                 // got to return something!
  if AEntity is TIB_DDLException then
    Result := etException
  else
    if AEntity is TIB_DDLBlobFilter then
      Result := etBlobFilter
    else
      if AEntity is TIB_DDLUDF then
        Result := etUDF
      else
        if AEntity is TIB_DDLGenerator then
          Result := etGenerator
        else
          if AEntity is TIB_DDLDomain then
            Result := etDomain
          else
            if AEntity is TIB_DDLTable then
              Result := etTable
            else
              if AEntity is TIB_DDLView then
                Result := etView
              else
                if AEntity is TIB_DDLProcedure then
                  Result := etProcedure
                else
                  if AEntity is TIB_DDLRole then
                    Result := etRole
                  else
                    if AEntity is TIB_DDLPrimaryKey then
                      Result := etPrimaryKey
                    else
                      if AEntity is TIB_DDLUniqueKey then
                        Result := etUniqueKey
                      else
                        if AEntity is TIB_DDLForeignKey then
                          Result := etForeignKey
                        else
                          if AEntity is TIB_DDLConstraint then
                            Result := etConstraint
                          else
                            if AEntity is TIB_DDLIndex then
                              Result := etIndex
                            else
                              if AEntity is TIB_DDLTrigger then
                                Result := etTrigger
                              else
                                if AEntity is TIB_DDLPermission then
                                  Result := etPermission
                                else
                                  if AEntity is TIB_DDLUDFParam then
                                    Result := etUDFParam
                                  else
                                    if AEntity is TIB_DDLTableField then
                                      Result := etTableField
                                    else
                                      if AEntity is TIB_DDLViewField then
                                        Result := etViewField
                                      else
                                        if AEntity is TIB_DDLProcParam then
                                          Result := etProcParam;
end;

function MatchingPrefix(AName, APrefix: string): boolean;
begin
  Result := false;
  if APrefix = Copy(AName, 1, Length(APrefix)) then
    Result := true;
end;

function ReplacePrefix(AName, APrefix, BPrefix: string): string;
begin
  Result := BPrefix + Copy(AName, Length(APrefix) + 1, MAXINT);
end;


end.
