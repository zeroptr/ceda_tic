
{                                                                              }
{ IB_DDL_EntityList                                                            }
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
  IB_DDL_EntityList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  IB_Components,

  IB_DDL_Formatter,
  IB_DDL_Entity;

type
  ELocateEntityError = class( EMetadataError );

  TIB_DDL_ExtractionState = ( mxsBeforeLoad,
                              mxsAfterLoad,
                              mxsAfterLoad2,
                              mxsAfterParams,
                              mxsPartialExtraction,
                              mxsFullExtraction );

  TIB_DDL_FormatterChangedEvent = TNotifyEvent;
  TIB_DDL_DatabaseList = class; // Forward declaration.

  TIB_DDL_EntityList = class(TComponent)
  private
    FEntityClass: TIB_DDL_EntityClass;
    FEntities: TIB_DDL_StringList;
    FErrors: TStringList;
    FExtractionState: TIB_DDL_ExtractionState;
    FIB_Cursor: TIB_Cursor;
    FSingle: Boolean;
    FSingleEntity: String;
    FFormatter: TIB_DDL_FormatterText;
    FTempStrings: TStrings;
    FFormatterChangedEvent: TIB_DDL_FormatterChangedEvent;
    FDatabaseList: TIB_DDL_DatabaseList;
    FAddBrOnHTML: Boolean;
    FCPtr: TObject;
    function GetFormatterType: TIB_DDL_FormatterType;
    procedure SetFormatterType(AFormatterType: TIB_DDL_FormatterType);
    procedure DoInitSQL(s: TStrings);
    procedure DoInitSQL2(s: TStrings; p: TIB_DDL_EntityList);
    function CreateEntity(const R: TIB_Row): TIB_DDL_Entity;
  protected
    FPassesNeeded: integer;
    FPassNumber: integer;
    property _EntityClass: TIB_DDL_EntityClass read FEntityClass write FEntityClass;
    property _IB_Cursor: TIB_Cursor read FIB_Cursor;
    property _FormatterChanged: TIB_DDL_FormatterChangedEvent
      read FFormatterChangedEvent write FFormatterChangedEvent;
    property WExtractionState: TIB_DDL_ExtractionState write FExtractionState;
    property AddBrOnHTML: Boolean write FAddBrOnHTML default True;
    function DoGetEntityClass: TIB_DDL_EntityClass; virtual; abstract;
    procedure DoAppendSQL(s: TStrings); virtual;
    function SystemEntityCanExist: Boolean; virtual;
  public
    function GetEntityCount: Integer;
    function GetEntities(i: Integer): TIB_DDL_Entity;
    function GetEntityNames(i: Integer): String;
    function GetEntityByName(const ename: String): TIB_DDL_Entity;
    function GetExtractionState: TIB_DDL_ExtractionState;
    property _DatabaseList: TIB_DDL_DatabaseList read FDatabaseList
                                             write FDatabaseList;
    property _CPtr: TObject read FCPtr;
  protected
    function LocateEntity(R: TIB_Row): TIB_DDL_Entity; virtual;
    procedure AddLine(S: String);
    property NewLine: String write AddLine;
    procedure AddBug(S: String); virtual;
    property NewBug: String write AddBug;
    // This method will raise an exception if the entity needs some condition
    // that's not met. Only a few entity lists need it.
    procedure CheckPrerequisite; virtual;
    function DoWrite: Boolean; virtual;
    procedure DoWritePreamble; virtual;
    procedure DoWriteEpilog; virtual;
    function GetIB_Connection: TIB_Connection;
    procedure SetIB_Connection(ic: TIB_Connection);
    function GetIB_Transaction: TIB_Transaction;
    procedure SetIB_Transaction(it: TIB_Transaction);
    property Formatter: TIB_DDL_FormatterText read FFormatter;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure _MoveEntity(CurIndex, NewIndex: Integer);
    function LoadMetadata: Integer;
    function NeedSecondLoad: Boolean; virtual;
    function LoadMetadata2: Integer; virtual;
    function LoadMetadataSingle(AEntityName: String): Integer;
    function NeedParamLoad: Boolean; virtual;
    function LoadParams: Integer; virtual;
    function NeedParamCheck: Boolean; virtual;
    function CheckParams: Integer; virtual;
    function GetErrorCount: Integer;
    function GetErrors(i: Integer): String;
    function WriteErrors(sList: TStrings; Append: Boolean): Boolean;
    function CalculateDependencies: Boolean; virtual;
    function CanOrderByNameSafely: Boolean;
    function Write(sList: TStrings): Boolean;
    function IsTopList: Boolean;
    function SysWrite( SList: TStrings;
                       NewPassNumber: integer ): Boolean; virtual;
    //function GenOutputAlpha: Integer;
    property FormatterType: TIB_DDL_FormatterType read GetFormatterType
                                              write SetFormatterType;
    property IB_Connection: TIB_Connection read GetIB_Connection
                                           write SetIB_Connection;
    property IB_Transaction: TIB_Transaction read GetIB_Transaction
                                             write SetIB_Transaction;
    property PassNumber: integer read FPassNumber;
  end;

  TIB_DDL_EntityListHack = class(TIB_DDL_EntityList)
  public
    property Formatter;
    property NewLine;
    property NewBug;
    property _FormatterChanged;
  end;

  // These cannot depend on other things

  TIB_DDL_DatabaseList = class(TIB_DDL_EntityList)
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    function SystemEntityCanExist: Boolean; override;
    function LocateEntity(R: TIB_Row): TIB_DDL_Entity; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    function GetCharsetNormal: String;
    function GetUserExceptionCount: Integer;
  end;

  TIB_DDL_ExceptionList = class(TIB_DDL_EntityList)
  private
    FFixFirstExceptionNumber: Boolean;
    FFirstExceptionNumber: Integer;
    FAdjustCharsetAlways: Boolean;
    function GetExceptionByNumber(xnum: Integer): TIB_DDL_Exception;
    procedure SetFirstExceptionNumber(aVal: Boolean);
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    // Every rose has its thorn... RDB$MESSAGE uses charset NONE
    function LocateEntity( R: TIB_Row ): TIB_DDL_Entity; override;
    procedure CheckPrerequisite; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    function NeedSecondLoad: Boolean; override;
    //function CalculateDependencies: Boolean; override;
    property FixFirstExceptionNumber: Boolean read FFixFirstExceptionNumber
                                              write SetFirstExceptionNumber
                                              stored False
                                              default False;
    procedure _SetFirstExceptionNumberValue(aNum: Integer);
    procedure _SetMinExceptionNumberValue(aNum: Integer);
    property AdjustCharsetAlways: Boolean read FAdjustCharsetAlways
                                          write FAdjustCharsetAlways
                                          default False;
  end;

  TIB_DDL_BlobFilterList = class(TIB_DDL_EntityList)
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  end;

  TIB_DDL_GeneratorList = class(TIB_DDL_EntityList)
  private
    FExtractGenValues: Boolean;
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    function NeedSecondLoad: Boolean; override;
    function LoadMetadata2: Integer; override;
    property ExtractGenValues: Boolean read FExtractGenValues
                                       write FExtractGenValues
                                       default False;
  end;

  // These can depend on other things.

  TIB_DDL_DomainList = class(TIB_DDL_EntityList)
  private
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    function SystemEntityCanExist: Boolean; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    function NeedSecondLoad: Boolean; override;
    //function CalculateDependencies: Boolean; override;
  end;

  TIB_DDL_IndexList = class(TIB_DDL_EntityList)
  private
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //function SystemEntityCanExist: Boolean; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    function NeedSecondLoad: Boolean; override;
    //function CalculateDependencies: Boolean; override;
  end;


  TIB_DDL_TriggerList = class(TIB_DDL_EntityList)
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  end;

  TIB_DDL_RoleList = class(TIB_DDL_EntityList)
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    function SystemEntityCanExist: Boolean; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  end;

  TIB_DDL_PermissionList = class(TIB_DDL_EntityList)
  private
    FPrevGrantor: String;
    FShowSysdbaRights: Boolean;
    function GetPermissionByGrantorUserUTypeONameOType(const AGrantor,
      AUser: String; AUserType: SmallInt; AObjectName: String;
      AObjectType: SmallInt): TIB_DDL_Permission;
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    function SystemEntityCanExist: Boolean; override;
    function LocateEntity(R: TIB_Row): TIB_DDL_Entity; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    function NeedSecondLoad: Boolean; override;
    //function CalculateDependencies: Boolean; override;
    property _PrevGrantor: String read      FPrevGrantor
      write FPrevGrantor stored False;
    property ShowSysdbaRights: Boolean read FShowSysdbaRights
      write FShowSysdbaRights default False;
  end;

  procedure LocateEntityError( const fname, clname, obname, msg: string );


implementation

uses
  IB_Parse,
  
  IB_DDL_Controller;

procedure LocateEntityError(const fname, clname, obname, msg: String);
begin
  raise ELocateEntityError.CreateFmt( '%s - %s(%s) %s.',
                                      [fname, clname, obname, msg] )
end;

// ----------------------------------------------------------
// TIB_DDL_EntityList

constructor TIB_DDL_EntityList.Create(AOwner: TComponent);
begin
  if AOwner is TIB_DDL_Extract then
    FCPtr := AOwner
  else
    raise Exception.Create( 'Owner must be a TIB_DDL_Extract' );
  inherited Create(AOwner);
  FPassesNeeded := 1;
  FEntities := TIB_DDL_StringList.Create;
  FErrors := TStringList.Create;
  FExtractionState := mxsBeforeLoad;
  FIB_Cursor := TIB_Cursor.Create( Self );
  SetFormatterType(mftText);
  FAddBrOnHTML := True
end;

destructor TIB_DDL_EntityList.Destroy;
begin
  FEntities.Free;
  FEntities := nil;
  FErrors.Free;
  FErrors := nil;
  inherited Destroy
end;

procedure TIB_DDL_EntityList.DoInitSQL(s: TStrings);
begin
  FEntityClass := DoGetEntityClass;
  if not Assigned(FEntityClass) then
    MetadataError( 'DoInitSQL', ClassName, '', 'EntityClass not assigned' );
  s.Clear;
  FEntityClass.BuildSQL(s,IB_Connection);
  if s.Count = 0 then
    MetadataError( 'DoInitSQL',
                   ClassName,
                   '',
                   'EntityClass ' + FEntityClass.ClassName +
                   ' did not return SQL' );
end;

procedure TIB_DDL_EntityList.DoInitSQL2(s: TStrings; p: TIB_DDL_EntityList);
begin
  //FEntityClass := DoGetEntityClass;
  if not Assigned(FEntityClass) then
    MetadataError('DoInitSQL2', ClassName, '', 'EntityClass not assigned');
  s.Clear;
  FEntityClass.BuildSQL2(s, p);
  if s.Count = 0 then
    MetadataError('DoInitSQL2', ClassName, '',
    'EntityClass ' + FEntityClass.ClassName + ' did not return SQL')
end;

function TIB_DDL_EntityList.CreateEntity(const R: TIB_Row): TIB_DDL_Entity;
begin
  if not Assigned(FEntityClass) then
    MetadataError('CreateEntity', ClassName, '', 'EntityClass not assigned');
  Result := FEntityClass.Create(R);
end;

//function TIB_DDL_EntityList.DoGetEntityClass: TIB_DDL_EntityClass; virtual; abstract;

procedure TIB_DDL_EntityList.DoAppendSQL(s: TStrings); // virtual
var
  auxFieldName: String;
begin
  if not Assigned(FEntityClass) then
    MetadataError( 'DoAppendSQL', ClassName, '', 'EntityClass not assigned' );
  if s.Count = 0 then
    MetadataError( 'DoAppendSQL',
                   ClassName, '',
                   'EntityClass ' + FEntityClass.ClassName +
                     ' did not return SQL');
  // We know the first line is SELECT, the second is the object name
   with FIB_Cursor do
   begin
    if FSingle then
    begin
      AuxFieldName := SQL.Strings[1];
      if AuxFieldName[Length(AuxFieldName)] = ',' then
        AuxFieldName[Length(AuxFieldName)] := #32;
      AddSQLWhereClause(AuxFieldName + ' = ' + QuotedStr(FSingleEntity))
    end
    else
    if SystemEntityCanExist() then
      AddSQLWhereClause('(M.RDB$SYSTEM_FLAG IS NULL OR M.RDB$SYSTEM_FLAG = 0)');
    if not FSingle and (SQLOrder.Count = 0) then
      SQLOrder.Add('ORDER BY 1')
   end
end;

function TIB_DDL_EntityList.SystemEntityCanExist: Boolean; // virtual
begin
  Result := True
end;

function TIB_DDL_EntityList.GetEntityCount: Integer;
begin
  Result := FEntities.Count
end;

function TIB_DDL_EntityList.GetEntities(i: Integer): TIB_DDL_Entity;
begin
  Result := FEntities[i]
end;

function TIB_DDL_EntityList.GetEntityNames(i: Integer): String;
begin
  Result := FEntities[i].Name
end;

function TIB_DDL_EntityList.GetEntityByName(const ename: String): TIB_DDL_Entity;
var
  iter: Integer;
begin
  Result := nil;
  for iter := GetEntityCount - 1 downto 0 do
    if GetEntities(iter).Name = ename then
    begin
      Result := GetEntities(iter);
      Exit
    end
end;

function TIB_DDL_EntityList.GetExtractionState: TIB_DDL_ExtractionState;
begin
  Result := FExtractionState
end;

function TIB_DDL_EntityList.LocateEntity(R: TIB_Row): TIB_DDL_Entity; //virtual;
var
  ename: String;
begin
  Result := nil;
  if Assigned(R) then
  begin
    ename := R.BySQLNo(0).AsString;
    Result := GetEntityByName(ename);
    if not Assigned(Result) then
      LocateEntityError('LocateEntity', FEntityClass.ClassName, ename,
      ' not found but ' + R.RelationNames[0] + ' has it');
  end
  else
    LocateEntityError( 'LocateEntity',
                       FEntityClass.ClassName,
                       '?',
                       'Row is NULL' );
end;

procedure TIB_DDL_EntityList._MoveEntity(CurIndex, NewIndex: Integer);
begin
  FEntities.Move(CurIndex, NewIndex)
end;

procedure TIB_DDL_EntityList.AddLine(S: String);
begin
  if Assigned(FTempStrings) then
  begin
    if FAddBrOnHTML and (GetFormatterType = mftHTML) then
      FTempStrings.Add(S + '<br>')
    else
      FTempStrings.Add(S)
  end;
end;

procedure TIB_DDL_EntityList.AddBug(S: String); // virtual
begin
  FErrors.Add(S)
end;

procedure TIB_DDL_EntityList.CheckPrerequisite;
begin
  // Nothing to do at this level
end;

function TIB_DDL_EntityList.GetFormatterType: TIB_DDL_FormatterType;
begin
  if not Assigned(FFormatter) then
    MetadataError('GetFormatterType', ClassName, '', 'Formatter not created');
  if FFormatter.ClassType = TIB_DDL_FormatterHTML then
    Result := mftHTML
  else
    Result := mftText;
end;

procedure TIB_DDL_EntityList.SetFormatterType(AFormatterType: TIB_DDL_FormatterType);
var
  tmpSQLDialect: integer;
begin
  if Assigned(FFormatter) then
  begin
    if GetFormatterType = AFormatterType then Exit;
    FFormatter.Free;
    FFormatter := nil
  end;
  with TIB_DDL_Extract( FCPtr ) do
  begin
    IB_Connection.Connect;
    tmpSQLDialect := IB_Connection.SQLDialect;
  end;
  case AFormatterType of
    mftText: FFormatter := TIB_DDL_FormatterText.Create( FCPtr, tmpSQLDialect );
    mftHTML: FFormatter := TIB_DDL_FormatterHTML.Create( FCPtr, tmpSQLDialect );
    else MetadataError('SetFormatterType', ClassName, '', 'Bad formatter type');
  end;
  if Assigned( FFormatterChangedEvent ) then
    FFormatterChangedEvent(Self)
end;

function TIB_DDL_EntityList.LoadMetadata: Integer;
var
  ent: TIB_DDL_Entity;
begin
  Result := 0;
  FErrors.Clear;
  with FIB_Cursor do
  begin
    CheckPrerequisite;
    if not IB_Connection.Connected then
      IB_Connection.Connect;
    SQL.Clear;
    DoInitSQL(SQL);
    DoAppendSQL(SQL);
    Prepare;
    First;
    while not Eof do
    begin
      try
        ent := CreateEntity( Fields );
        ent.ParseMetadata;
        FEntities.AddEntity( ent.Name, ent )
      except
        on E: Exception do
          FErrors.Add(E.Message)
      end;
      APINext;
      Inc(Result)
    end;
    Unprepare
  end;
  FExtractionState := mxsAfterLoad
end;

function TIB_DDL_EntityList.NeedSecondLoad: Boolean; //virtual;
begin
  Result := False
end;

function TIB_DDL_EntityList.LoadMetadata2: Integer; //override;
var
  ent: TIB_DDL_Entity;
  rn: longint;
begin
  if FExtractionState <> mxsAfterLoad then
    MetadataError( 'LoadMetadata2',
                   ClassName,
                   '',
                   'LoadMetadata required first' );
  Result := 0;
  with FIB_Cursor do
  begin
    CheckPrerequisite;
    if not IB_Connection.Connected then
      IB_Connection.Connect;
    SQL.Clear;
    DoInitSQL2(SQL, Self);
    DoAppendSQL(SQL);
    Prepare;
    First;
    if not Eof then
      while TRUE do
      begin
        rn := 0;
        try
          rn := CursorRowNum;
          ent := LocateEntity(Fields);
          ent.ParseMetadata2(Fields);
        except
          on E: Exception do
          begin
            FErrors.Add(E.Message);
            FErrors.Add('LoadMetadata2 - Error while locating or parsing.');
            if rn = CursorRowNum then
              APINext // Or let ParseMetadata2 handle the scrolling
          end
        end;
        Inc(Result);
        if Eof then break;
      end;
    Unprepare
  end;
  FExtractionState := mxsAfterLoad2
end;

function TIB_DDL_EntityList.LoadMetadataSingle(AEntityName: String): Integer;
begin
  FSingle := True;
  FSingleEntity := AEntityName;
  Result := LoadMetadata
end;

function TIB_DDL_EntityList.NeedParamLoad: Boolean; //virtual;
begin
  Result := False
end;

function TIB_DDL_EntityList.LoadParams: Integer; //virtual;
begin
  Result := 0;
  MetadataError('LoadParams', ClassName, '', 'did not define it')
end;

function TIB_DDL_EntityList.NeedParamCheck: Boolean; //virtual;
begin
  Result := False;
end;

function TIB_DDL_EntityList.CheckParams: Integer; //virtual;
begin
  Result := 0;
  MetadataError('CheckParams', ClassName, '', 'did not define it')
end;

function TIB_DDL_EntityList.GetErrorCount: Integer;
begin
  Result := FErrors.Count;
end;

function TIB_DDL_EntityList.GetErrors(i: Integer): String;
begin
  Result := FErrors[i];
end;

function TIB_DDL_EntityList.WriteErrors(sList: TStrings; Append: Boolean): Boolean;
begin
  if Assigned(sList) then
  begin
    if Append then
    begin
      sList.AddStrings(FErrors);
      Result := sList.Count - FErrors.Count > 0;
    end
    else
    begin
      sList.Assign(FErrors);
      Result := sList.Count > 0;
    end;
  end
  else
    Result := False;
end;

function TIB_DDL_EntityList.CalculateDependencies: Boolean;
begin
  Result := False; // override at lower levels
end;

function TIB_DDL_EntityList.CanOrderByNameSafely: Boolean;
begin
  Result := IsTopList;
end;

function TIB_DDL_EntityList.Write(SList: TStrings): Boolean;
var
  tmpResult: boolean;
begin
  Result := false;
  FPassNumber := 0;
  repeat
    tmpResult := Result;
    Result := SysWrite( SList, FPassNumber + 1 ) or tmpResult;
  until FPassNumber >= FPassesNeeded;
end;

function TIB_DDL_EntityList.SysWrite( SList: TStrings;
                                  NewPassNumber: integer ): boolean;
begin
  FTempStrings := SList;
  try
    FPassNumber := NewPassNumber;
    DoWritePreamble;
    Result := DoWrite;
    DoWriteEpilog;
  finally
    FTempStrings := nil;
  end;
end;

function TIB_DDL_EntityList.DoWrite: Boolean;
var
  iter: Integer;
begin
  // We provide here a placeholder. Override it if you need more.
  Result := False;
  for iter := 0 to GetEntityCount - 1 do
    Result := GetEntities(iter).Write or Result
end;

procedure TIB_DDL_EntityList.DoWritePreamble;
begin
  // Nothing to do at this level
end;

procedure TIB_DDL_EntityList.DoWriteEpilog;
begin
  AddLine( EmptyStr );
end;

function TIB_DDL_EntityList.GetIB_Connection: TIB_Connection;
begin
  FIB_Cursor.CheckConnection( false );
  Result := FIB_Cursor.IB_Connection;
end;

procedure TIB_DDL_EntityList.SetIB_Connection(ic: TIB_Connection);
begin
  FIB_Cursor.IB_Connection := ic
end;

function TIB_DDL_EntityList.GetIB_Transaction: TIB_Transaction;
begin
  FIB_Cursor.CheckTransaction( false );
  Result := FIB_Cursor.IB_Transaction;
end;

procedure TIB_DDL_EntityList.SetIB_Transaction(it: TIB_Transaction);
begin
  FIB_Cursor.IB_Transaction := it
end;

function TIB_DDL_EntityList.IsTopList: Boolean;
var
  iter: Integer;
begin
  Result := True;
  iter := FEntities.Count -1;
  if (iter >- 1) and (FEntities[0].Priority = 0) then Exit;
  while (iter > -1) and Result do
  begin
    Result := Result and FEntities[iter].IsTopEntity;
    Dec(iter)
  end
end;

// ----------------------------------------------------------
// TIB_DDL_DatabaseList

function TIB_DDL_DatabaseList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Database
end;

function TIB_DDL_DatabaseList.SystemEntityCanExist: Boolean; // override
begin
  Result := False
end;

function TIB_DDL_DatabaseList.LocateEntity(R: TIB_Row): TIB_DDL_Entity; //override;
begin
  Result := nil;
  LocateEntityError( 'LocateEntity',
                     FEntityClass.ClassName,
                     '?',
                     'cannot be used')
end;

(*
function TIB_DDL_DatabaseList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_DatabaseList.DoWritePreamble;
begin
  AddLine(EmptyStr);
  NewLine := Formatter.IBComment('Started at ' + DateTimeToStr(Now))
end;
{
procedure TIB_DDL_DatabaseList.DoWriteEpilog;
begin
end;
}
function TIB_DDL_DatabaseList.GetCharsetNormal: String;
begin
  with FEntities[0] as TIB_DDL_Database do
    Result := CharacterSetNormal
end;

function TIB_DDL_DatabaseList.GetUserExceptionCount: Integer;
begin
  with FEntities[0] as TIB_DDL_Database do
    Result := UserExceptionCount
end;


// ----------------------------------------------------------
// TIB_DDL_ExceptionList

function TIB_DDL_ExceptionList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Exception
end;

procedure TIB_DDL_ExceptionList.CheckPrerequisite;
var
  dbcharset: String;
begin
  if Assigned(FDatabaseList) and
     (FDatabaseList.GetUserExceptionCount = 0) and
     not FAdjustCharsetAlways then Exit;
  with FIB_Cursor.IB_Connection do
  case FExtractionState of
    mxsBeforeLoad:
      if (CharSet = EmptyStr) or (CharSet = 'NONE') then // nothing
      else
      begin
        if Connected then Disconnect;
        CharSet := 'NONE'
        //Exception.Create('CheckPrerequisite - Charset should be NONE')
      end;
    mxsAfterLoad:
      if Assigned(FDatabaseList) then
      begin
        dbcharset := FDatabaseList.GetCharsetNormal;
        if (CharSet = dbcharset) or
           (CharSet = EmptyStr) and (dbcharset = 'NONE') then // nothing
        else
        begin
          if Connected then Disconnect;
          CharSet := dbcharset
        //Exception.Create('CheckPrerequisite - Charset should be ' + dbcharset)
        end
      end
  end
end;
(*
function TIB_DDL_ExceptionList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_ExceptionList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('Exception List.'));
  if FFixFirstExceptionNumber then
    NewLine := Formatter.MFormat( 'B D B N;', ['SET GENERATOR',
      'RDB$EXCEPTIONS', 'TO', IntToStr(FFirstExceptionNumber - 1)])
end;
{
procedure TIB_DDL_ExceptionList.DoWriteEpilog;
begin
end;
}
function TIB_DDL_ExceptionList.NeedSecondLoad: Boolean; //override;
begin
  Result := True;
end;

function TIB_DDL_ExceptionList.GetExceptionByNumber(xnum: Integer): TIB_DDL_Exception;
var
  iter: Integer;
begin
  Result := nil;
  for iter := GetEntityCount - 1 downto 0 do
    if TIB_DDL_Exception(GetEntities(iter)).ExceptionNumber = xnum then
    begin
      Result := GetEntities(iter) as TIB_DDL_Exception;
      Exit;
    end;
end;

function TIB_DDL_ExceptionList.LocateEntity(R: TIB_Row): TIB_DDL_Entity; //override;
var
  xname: String;
  xnum: Integer;
begin
  xname := R.BySQLNo(0).AsString;
  xnum := R.BySQLNo(1).AsInteger;
  Result := GetExceptionByNumber(xnum);
  if not Assigned(Result) then
    LocateEntityError( 'LocateEntity',
                       FEntityClass.ClassName,
                       xname,
                       'not found');
end;

procedure TIB_DDL_ExceptionList.SetFirstExceptionNumber(aVal: Boolean);
begin
  FFixFirstExceptionNumber := aVal;
  FFirstExceptionNumber := MaxInt
end;

procedure TIB_DDL_ExceptionList._SetFirstExceptionNumberValue(aNum: Integer);
begin
  FFirstExceptionNumber := aNum
end;

procedure TIB_DDL_ExceptionList._SetMinExceptionNumberValue(aNum: Integer);
begin
  if FFirstExceptionNumber > aNum then
    FFirstExceptionNumber := aNum
end;


// ----------------------------------------------------------
// TIB_DDL_BlobFilterList

function TIB_DDL_BlobFilterList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_BlobFilter
end;
(*
function TIB_DDL_BlobFilterList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_BlobFilterList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('BlobFilter List.'))
end;
{
procedure TIB_DDL_BlobFilterList.DoWriteEpilog;
begin
end;
}


// ----------------------------------------------------------
// TIB_DDL_GeneratorList

function TIB_DDL_GeneratorList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Generator
end;
(*
function TIB_DDL_GeneratorList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_GeneratorList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('Generator List.'))
end;
{
procedure TIB_DDL_GeneratorList.DoWriteEpilog;
begin
end;
}
function TIB_DDL_GeneratorList.NeedSecondLoad: Boolean; //override;
begin
  Result := FExtractGenValues;
end;

function TIB_DDL_GeneratorList.LoadMetadata2: Integer; //override;
var
  ent: TIB_DDL_Entity;
  iter: Integer;
  AuxFmt: TIB_DDL_FormatterText;
begin
  if FExtractionState <> mxsAfterLoad then
    MetadataError( 'LoadMetadata2',
                   ClassName,
                   '',
                   'LoadMetadata required first' );
  Result := 0;
  with FIB_Cursor do
  begin
    if not IB_Connection.Connected then IB_Connection.Connect;
    if GetFormatterType <> mftText then
      AuxFmt := TIB_DDL_FormatterText.Create( FCPtr, IB_Connection.SQLDialect )
    else
      AuxFmt := FFormatter;
    try
      for iter := 0 to GetEntityCount - 1 do
      begin
        SQL.Clear;
        // We don't follow the typical structures.
        try
          ent := GetEntities(iter);
          // Use enclose directly to avoid traps with DQuote()
          // and the global SkipDoubleQuotes setting.
          SQL.Add( 'SELECT ' + mkLitCriteria( ent.Name, '''' ) + ', ' +
                   'GEN_ID( ' + IB_Connection.mkIdent( ent.Name ) + ', 0 ) ' +
                   'FROM RDB$DATABASE' );
          First;
          ent.ParseMetadata2( Fields );
          Close
        except
          on E: Exception do
          begin
            FErrors.Add(E.Message);
            FErrors.Add('LoadMetadata2 - Error while locating or parsing.')
          end
        end;
        Inc(Result)
      end
    finally
      if AuxFmt <> FFormatter then
        AuxFmt.Free;
    end;
  end;
  FExtractionState := mxsAfterLoad2
end;


// ----------------------------------------------------------
// TIB_DDL_DomainList

function TIB_DDL_DomainList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Domain
end;

function TIB_DDL_DomainList.SystemEntityCanExist: Boolean; // override
begin
  if FExtractionState = mxsAfterLoad then
    Result := False
  else
    Result := True;
end;

(*
function TIB_DDL_DomainList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_DomainList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('Domain List.'))
end;
{
procedure TIB_DDL_DomainList.DoWriteEpilog;
begin
end;
}
function TIB_DDL_DomainList.NeedSecondLoad: Boolean; //override;
begin
  Result := True
end;


// ----------------------------------------------------------
// TIB_DDL_IndexList

function TIB_DDL_IndexList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Index
end;
(*
function TIB_DDL_IndexList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_IndexList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('Index List.'))
end;
{
procedure TIB_DDL_IndexList.DoWriteEpilog;
begin
end;
}
function TIB_DDL_IndexList.NeedSecondLoad: Boolean; //override;
begin
  Result := True
end;


// ----------------------------------------------------------
// TIB_DDL_TriggerList

function TIB_DDL_TriggerList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Trigger
end;
(*
function TIB_DDL_TriggerList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_TriggerList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('Trigger List.'))
end;
{
procedure TIB_DDL_TriggerList.DoWriteEpilog;
begin
end;
}

// ----------------------------------------------------------
// TIB_DDL_RoleList

function TIB_DDL_RoleList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Role
end;

function TIB_DDL_RoleList.SystemEntityCanExist: Boolean; //override
begin
  // He, he, developers were shortsighted.
  // Now we need a new ODS if we want system roles!
  Result := False
end;
(*
function TIB_DDL_RoleList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_RoleList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('Role List.'))
end;
{
procedure TIB_DDL_RoleList.DoWriteEpilog;
begin
end;
}


// ----------------------------------------------------------
// TIB_DDL_PermissionList

function TIB_DDL_PermissionList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Permission
end;

function TIB_DDL_PermissionList.SystemEntityCanExist: Boolean; //override
begin
  Result := False
end;
(*
function TIB_DDL_PermissionList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_PermissionList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('Permission List.'));
  FPrevGrantor := EmptyStr;
end;
{
procedure TIB_DDL_PermissionList.DoWriteEpilog;
begin
end;
}
function TIB_DDL_PermissionList.NeedSecondLoad: Boolean; //override;
begin
  Result := True
end;

function TIB_DDL_PermissionList.GetPermissionByGrantorUserUTypeONameOType(
  const AGrantor, AUser: String; AUserType: SmallInt; AObjectName: String;
  AObjectType: SmallInt): TIB_DDL_Permission;
var
  iter: Integer;
begin
  Result := nil;
  for iter := GetEntityCount - 1 downto 0 do
    With TIB_DDL_Permission(GetEntities(iter)) do
      if (Name = AGrantor) and
         (UserName = AUser) and
         (UserType = AUserType) and
         (ObjectName = AObjectName) and
         (ObjectType = AObjectType) then
      begin
        Result := GetEntities(iter) as TIB_DDL_Permission;
        Exit
      end
end;

function TIB_DDL_PermissionList.LocateEntity(R: TIB_Row): TIB_DDL_Entity; //override;
var
  gname, uname, oname: String;
  utype, otype: SmallInt;
begin
  gname := R.BySQLNo(0).AsString;
  uname := R.BySQLNo(1).AsString;
  utype := R.BySQLNo(2).AsSmallInt;
  oname := R.BySQLNo(3).AsString;
  otype := R.BySQLNo(4).AsSmallInt;
  Result := GetPermissionByGrantorUserUTypeONameOType( gname,
                                                       uname,
                                                       utype,
                                                       oname,
                                                       otype );
  if not Assigned(Result) then
    LocateEntityError( 'LocateEntity',
                       FEntityClass.ClassName,
                       Formatter.MFormat( 'R -> R{R}:R',
                                          [gname, uname, IntToStr(utype),
                       IntToStr(otype)]),
                       'not found' );
end;

end.
