
{                                                                              }
{ IB_DDL_ParamList                                                             }
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
  IB_DDL_ParamList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  IB_DDL_Entity,
  IB_DDL_EntityList;

type
  TIB_DDL_EntListWithParams = class(TIB_DDL_EntityList)
  private
    FDomainList: TIB_DDL_DomainList;
    FIndexList: TIB_DDL_IndexList;
    FTriggerList: TIB_DDL_TriggerList;
    procedure OnFormatterChanged(Sender: TObject);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    //function NeedSecondLoad: Boolean; override;
    {function LoadMetadata2: integer; override;}
    function NeedParamLoad: Boolean; override;
    function LoadParams: Integer; override;
    function GetDomainByName(const dname: String): TIB_DDL_Domain;
    function GetIndexByName(const iname: String): TIB_DDL_Index;
    function GetTriggerByName(const tname: String): TIB_DDL_Trigger;
    property _DomainList: TIB_DDL_DomainList read FDomainList write FDomainList;
    property _IndexList: TIB_DDL_IndexList read FIndexList write FIndexList;
    property _TriggerList: TIB_DDL_TriggerList read FTriggerList write FTriggerList;
  end;

  TIB_DDL_ParamList = class(TIB_DDL_EntityList)
  private
    FSpecialTag: Integer;
    FOwnerEntity: TIB_DDL_Entity;
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //procedure DoAppendSQL(s: TStrings); virtual;
    function SystemEntityCanExist: Boolean; override;
    procedure AddBug(S: String); override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    procedure DoWriteEpilog; override;
    property SpecialTag: Integer read FSpecialTag write FSpecialTag;
    property OwnerEntity: TIB_DDL_Entity read FOwnerEntity;
  public
    constructor Create(AOwner: TComponent); override;
    //destructor Destroy; override;
    procedure _SetOwnerEntity(aOwner: TIB_DDL_Entity);
    //function LoadMetadata(R: TIB_Row): Integer;
    {
    function LoadMetadataSingle(AEntityName: String): Integer;
    function ErrorCount: Integer;
    function Errors(i: Integer): String;
    }
    function GetParamCount: Integer;
    function GetParams(i: Integer): TIB_DDL_Entity;
    function GetParamByName(const pname: String): TIB_DDL_Entity;
    function CalculateDependencies: Boolean; override;
    function CanOrderByNameSafely: Boolean;
    //function Write(sList: TStrings): Boolean;
    //function IsTopList: Boolean;
    //function GenOutputAlpha: Integer;
  end;

  TIB_DDL_ParamListHack = class(TIB_DDL_ParamList)
  public
    procedure SetEntityClass(ec: TIB_DDL_EntityClass);
    property SpecialTag;
    property OwnerEntity;
  end;

  // These cannot depend on other things

  TIB_DDL_UDFList = class(TIB_DDL_EntListWithParams)
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    //function NeedSecondLoad: Boolean; override;
  end;

  // These can depend on other things.

  TIB_DDL_TableList = class(TIB_DDL_EntListWithParams)
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    constructor Create(AOwner: TComponent); override;
    //function NeedSecondLoad: Boolean; override;
    function NeedParamCheck: Boolean; override;
    function CheckParams: Integer; override;
  end;

  TIB_DDL_ViewList = class(TIB_DDL_EntListWithParams)
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    //function NeedSecondLoad: Boolean; override;
  end;

  TIB_DDL_ProcedureList = class(TIB_DDL_EntListWithParams)
  protected
    function DoGetEntityClass: TIB_DDL_EntityClass; override;
    //function DoWrite: Boolean; override;
    procedure DoWritePreamble; override;
    //procedure DoWriteEpilog; override;
  public
    constructor Create(AOwner: TComponent); override;
    //function NeedSecondLoad: Boolean; override;
  end;


implementation

uses
  IB_DDL_Formatter,
  IB_DDL_EntWithParams;

// ----------------------------------------------------------
// TIB_DDL_EntListWithParams

constructor TIB_DDL_EntListWithParams.Create(AOwner: TComponent); //override;
begin
  inherited Create(AOwner);
  _FormatterChanged := OnFormatterChanged
end;

procedure TIB_DDL_EntListWithParams.OnFormatterChanged(Sender: TObject);
var
  iter: Integer;
begin
  for iter := 0 to GetEntityCount - 1 do
  begin
    try
      TIB_DDL_EntWithParams(GetEntities(iter))._OnFormatterChanged(FormatterType)
    except
      on E: Exception do
        AddBug(E.Message);
    end;
  end;
end;
(*
function TIB_DDL_EntListWithParams.NeedSecondLoad: Boolean; //override;
begin
  Result := True
end;
*)
function TIB_DDL_EntListWithParams.NeedParamLoad: Boolean; //override;
begin
  Result := True
end;

function TIB_DDL_EntListWithParams.LoadParams: integer; //override;
var
  iter: Integer;
begin
  if NeedSecondLoad then
  begin
    if (GetExtractionState <> mxsAfterLoad2) then
      MetadataError( 'LoadParams',
                     ClassName,
                     '',
                     'LoadMetadata2 required first' );
  end
  else
  if GetExtractionState <> mxsAfterLoad then
    MetadataError( 'LoadParams',
                   ClassName,
                   '',
                   'LoadMetadata required first' );
  Result := 0;
  for iter := 0 to GetEntityCount - 1 do
  begin
    try
      (GetEntities(iter) as TIB_DDL_EntWithParams).ParseParams(_IB_Cursor.Fields);
    except
      on E: Exception do
        AddBug(E.Message);
    end;
    Inc(Result)
  end;
  WExtractionState := mxsAfterParams
end;

function TIB_DDL_EntListWithParams.GetDomainByName(const dname: String): TIB_DDL_Domain;
begin
  if Assigned(FDomainList)
  then Result := FDomainList.GetEntityByName(dname) as TIB_DDL_Domain
  else Result := nil
end;

function TIB_DDL_EntListWithParams.GetIndexByName(const iname: String): TIB_DDL_Index;
begin
  if Assigned(FIndexList)
  then Result := FIndexList.GetEntityByName(iname) as TIB_DDL_Index
  else Result := nil
end;

function TIB_DDL_EntListWithParams.GetTriggerByName(const tname: String): TIB_DDL_Trigger;
begin
  if Assigned(FTriggerList)
  then Result := FtriggerList.GetEntityByName(tname) as TIB_DDL_Trigger
  else Result := nil
end;
(*
function TIB_DDL_EntListWithParams.LoadMetadata2: integer; //override;
var
  e: TIB_DDL_Entity;
begin
  if FExtractionState <> mxsAfterLoad
  then raise Exception.Create('LoadMetadata2 - LoadMetadata required first');
  Result := 0;
  with _IB_Cursor do
  begin
    if not IB_Connection.Connected
    then IB_Connection.Connect;
    if not Assigned(FEntityClass)
    then raise Exception.Create('LoadMetadata2 - EntityClass not assigned.');
    SQL.Clear;
    FEntityClass.BuildSQL2(SQL);
    if SQL.Count = 0
    then raise Exception.Create('LoadMetadata2 - Entity did not return SQL.');
    DoAppendSQL(SQL);
    Prepare;
    First;
    if not Eof
    then While TRUE do
    begin
      try
        e := LocateEntity(Fields);
        e.ParseMetadata2(Fields);
      except
        on E: Exception do
        begin
          FErrors.Add(E.Message)
        end
      end;
      Inc(Result);
      if Eof
      then break;
      {APINext} // Let ParseMetadata2 handle the scrolling
    end
  end;
  //FExtractionState := mxsAfterLoad2
end;
}      *)


// ----------------------------------------------------------
// TIB_DDL_ParamList

procedure TIB_DDL_ParamListHack.SetEntityClass(ec: TIB_DDL_EntityClass);
begin
  _EntityClass := ec;
end;

constructor TIB_DDL_ParamList.Create(AOwner: TComponent); //override;
begin
  inherited Create(AOwner);
  AddBrOnHTML := False;
end;
(*
destructor TIB_DDL_ParamList.Destroy;
begin
  //FIB_Cursor.Free;
  inherited Destroy
end;
*)

procedure TIB_DDL_ParamList._SetOwnerEntity(aOwner: TIB_DDL_Entity);
begin
  FOwnerEntity := aOwner as TIB_DDL_EntWithParams
end;

function TIB_DDL_ParamList.DoGetEntityClass: TIB_DDL_EntityClass; //override;
begin
  Result := _EntityClass
end;

function TIB_DDL_ParamList.SystemEntityCanExist: Boolean; // override;
begin
  Result := False
end;

procedure TIB_DDL_ParamList.AddBug(S: String); //override;
begin
  inherited AddBug(s);
  with (FOwnerEntity as TIB_DDL_EntWithParams) do
    with (OwnerEntityList as TIB_DDL_EntListWithParams) do
      AddBug( s )
end;

{procedure TIB_DDL_ParamList.AddLine(S: String);
begin
  if Assigned(FTempStrings)
  then if GetFormatterType = mftHTML
  then FTempStrings.Add(S + '<br>')
  else FTempStrings.Add(S)
end;
}

(*
function TIB_DDL_ParamList.LoadMetadata(R: TIB_Row): Integer;
var
  e: TIB_DDL_Entity;
begin
{
  Result := 0;
  FErrors.Clear;
  with _IB_Cursor do
  begin
    if not IB_Connection.Connected
    then IB_Connection.Connect;
    CheckPrerequisite;
    SQL.Clear;
    DoInitSQL(SQL);
    if SQL.Count > 0 then
    begin
      DoAppendSQL(SQL);
      Prepare;
      First;
      While not Eof do
      try
        e := CreateEntity(Fields);
        e.ParseMetadata;
        FEntities.AddEntity(e.Name, e);
        APINext;
        Inc(Result)
      except
        on E: Exception do
        begin
          FErrors.Add(E.Message)
        end
      end
    end
  end;
  FExtractionState := mxsAfterLoad
  }
end;
*)


function TIB_DDL_ParamList.GetParamCount: Integer;
begin
  Result := inherited GetEntityCount;
end;

function TIB_DDL_ParamList.GetParams(i: Integer): TIB_DDL_Entity;
begin
  Result := inherited GetEntities(i);
end;

function TIB_DDL_ParamList.GetParamByName(const pname: String): TIB_DDL_Entity;
begin
  Result := inherited GetEntityByName(pname);
end;

function TIB_DDL_ParamList.CalculateDependencies: Boolean;
begin
  Result := False; // override at lower levels
end;

function TIB_DDL_ParamList.CanOrderByNameSafely: Boolean;
begin
  Result := IsTopList;
end;
(*
function TIB_DDL_ParamList.Write(SList: TStrings): Boolean;
begin
  {FTempStrings := SList;
  try
    DoWritePreamble;
    Result := DoWrite;
    DoWriteEpilog;
  finally
    FTempStrings := nil
  end
  }
end;
*)
{
function TIB_DDL_ParamList.DoWrite: Boolean; // override;
var
  iter: Integer;
begin
  // We provide here a placeholder. Override it if you need more.
  Result := False;
  for iter := 0 to EntityCount - 1 do
    Result := Entities(iter).Write or Result
end;
}

procedure TIB_DDL_ParamList.DoWritePreamble;
begin
  // Nothing to do at this level
end;

procedure TIB_DDL_ParamList.DoWriteEpilog;
begin
  // Nothing to do at this level
end;
(*
function TIB_DDL_ParamList.IsTopList: Boolean;
{var
  iter: Integer;}
begin
{  Result := True;
  iter := FEntities.Count -1;
  if (iter >- 1) and (FEntities[0].Priority = 0)
  then Exit;
  While (iter > -1) and Result do
  begin
    Result := Result and FEntities[iter].IsTopEntity;
    Dec(iter)
  end
  }
end;
*)

// ----------------------------------------------------------
// TIB_DDL_UDFList

function TIB_DDL_UDFList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_UDF;
end;
(*
function TIB_DDL_UDFList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_UDFList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('UDF List.'));
end;
(*
procedure TIB_DDL_UDFList.DoWriteEpilog;
begin
end;
*)(*
function TIB_DDL_UDFList.NeedSecondLoad: Boolean; //override;
begin
  Result := False
end;
*)

// ----------------------------------------------------------
// TIB_DDL_TableList

constructor TIB_DDL_TableList.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  FPassesNeeded := 2;
end;

function TIB_DDL_TableList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Table;
end;
(*
function TIB_DDL_TableList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_TableList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('Table List. ' + IntToStr( PassNumber )));
end;
(*
procedure TIB_DDL_TableList.DoWriteEpilog;
begin
end;
*)(*
function TIB_DDL_TableList.NeedSecondLoad: Boolean; //override;
begin
  Result := False
end;
*)
function TIB_DDL_TableList.NeedParamCheck: Boolean; //override;
begin
  Result := True;
end;

function TIB_DDL_TableList.CheckParams: Integer; //override;
const
  relfieldIndex = False;
  constraintIndex = True;
var
  entiter, exiter: Integer;
  paramConst: TIB_DDL_Table_Constraint;
begin
  Result := 0;
  for entiter := 0 to GetEntityCount - 1 do
    with TIB_DDL_EntWithParams(GetEntities(entiter)) do
    for exiter := 0 to GetParamCount(constraintIndex) - 1 do
    begin
      paramConst := GetParams(constraintIndex, exiter) as TIB_DDL_Table_Constraint;
      try
        paramConst.BindToField;
      except
        on E: Exception do
          AddBug(E.Message)
      end;
      Inc(Result)
    end
end;


// ----------------------------------------------------------
// TIB_DDL_ViewList

function TIB_DDL_ViewList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_View
end;
(*
function TIB_DDL_ViewList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_ViewList.DoWritePreamble;
begin
  AddLine(Formatter.IBComment('View List.'))
end;
(*
procedure TIB_DDL_ViewList.DoWriteEpilog;
begin
end;
*)(*
function TIB_DDL_ViewList.NeedSecondLoad: Boolean; //override;
begin
  Result := False
end;
*)

// ----------------------------------------------------------
// TIB_DDL_StoredProcList

constructor TIB_DDL_ProcedureList.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  FPassesNeeded := 2;
end;

function TIB_DDL_ProcedureList.DoGetEntityClass: TIB_DDL_EntityClass;
begin
  Result := TIB_DDL_Procedure
end;
(*
function TIB_DDL_ProcedureList.DoWrite: Boolean;
begin
end;
*)
procedure TIB_DDL_ProcedureList.DoWritePreamble;
begin
  AddLine( Formatter.IBComment( 'Procedure List. ' + IntToStr( PassNumber )));
end;
(*
procedure TIB_DDL_ProcedureList.DoWriteEpilog;
begin
end;
*)(*
function TIB_DDL_ProcedureList.NeedSecondLoad: Boolean; //override;
begin
  Result := False
end;
*)

end.
