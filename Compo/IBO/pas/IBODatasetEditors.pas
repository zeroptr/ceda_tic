
{                                                                              }
{  IBODatasetEditors                                                           }
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
  IBODatasetEditors;

interface

uses
  Classes, Windows, Controls, Dialogs, Graphics,

{$IFDEF IBO_VCL60_OR_GREATER}
  DesignIntf, DesignMenus, DesignEditors, DesignWindows,
  ToolsAPI,
  DBReg,
  DSDesign,
{$ELSE}
  DsgnIntf,
{$ENDIF}

  Forms, Consts, ComCtrls, TypInfo,

  IB_Constants,
  IB_Components,
  IBODataset;
//IB_Editors

type

{$IFDEF IBO_VCL40_OR_GREATER}
TStoredProcNameProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;
{$ENDIF}

TDatabaseNameProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

TTableNameProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

TVersionProperty = class(TStringProperty)
public
  procedure Edit; override;
  function GetAttributes: TPropertyAttributes; override;
end;

TIBOBaseQuerySQLProperty = class(TPropertyEditor)
public
  procedure Edit; override;
  function GetAttributes: TPropertyAttributes; override;
  function GetValue: string; override;
end;

TSessionProperty = class(TComponentProperty)
public
  function GetValue: string; override;
  procedure SetValue( const AValue: string ); override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

TConnectionProperty = class(TComponentProperty)
public
  function GetValue: string; override;
  procedure SetValue( const AValue: string ); override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

TTransactionProperty = class(TComponentProperty)
public
  function GetValue: string; override;
  procedure SetValue( const AValue: string ); override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

TIBOBaseQueryEditor = class( TComponentEditor )
private
// TComponentEditor has no virtual destructor and no destructor at all
{$IFDEF IBO_VCL60_OR_GREATER}
  FDBDatasetEditor: TDatasetEditor;
{$ELSE}
  FDBDatasetEditor: TComponentEditor;
{$ENDIF}
public
  constructor Create( AComponent: TComponent;
{$IFDEF IBO_VCL60_OR_GREATER}
                      ADesigner: IDesigner ); override;
{$ELSE}
{$IFDEF IBO_VCL40_OR_GREATER}
                      ADesigner: IFormDesigner ); override;
{$ELSE}
                      ADesigner: TFormDesigner ); override;
{$ENDIF}
{$ENDIF}
  function GetVerbCount: integer; override;
  function GetVerb( Index: integer ): string; override;
  procedure ExecuteVerb( Index: integer ); override;
  procedure Edit2; // don't override;
  destructor Destroy; override;
end;

procedure Register;

implementation

uses
{$IFDEF IBO_VCL60_OR_GREATER}
  StrEdit,
  StFilSys,
  SysUtils,
{$ENDIF}
  IBD_About,
  IBF_Base,
  IBF_Query;

function TIBOBaseQuerySQLProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paDialog ];
end;

function TIBOBaseQuerySQLProperty.GetValue: string;
begin
  Result := '(SQL)';
end;

procedure TIBOBaseQuerySQLProperty.Edit;
var
  AIBOBaseQuery: TIBOBaseQuery;
  ABDataset: TIB_BDataset;
begin
  if GetComponent(0) is TIBOBaseQuery then
  begin
    AIBOBaseQuery := GetComponent(0) as TIBOBaseQuery;
    ABDataset := AIBOBaseQuery.InternalDataset;
    with TfrmQuery.Create( Application ) do
      try
        Caption := AIBOBaseQuery.Owner.Name + '.' +
                   AIBOBaseQuery.Name       + ' - ' +
                   Caption;
        pnClose.Visible := true;
        StatusBar.Visible := false;
        tsHints.TabVisible := false;
        tsMasterLinks.TabVisible := false;
        tsCalculatedFields.TabVisible := false;
        cbSearchedEdits.Visible := false;
        cbSearchedDeletes.Visible := false;
        cbPreparedEdits.Visible := false;
        lbCharCase.Enabled := false;
        cbFieldCharCase.Enabled := false;
        lbDisplayWidth.Enabled := false;
        edFieldDispWidth.Enabled := false;
        lbGridLabel.Enabled := false;
        edFieldGridLabel.Enabled := false;
        lbTrimming.Enabled := false;
        cbFieldTrim.Enabled := false;
        cbFieldCharCase.Color := clSilver;
        edFieldDispWidth.Color := clSilver;
        edFieldGridLabel.Color := clSilver;
        cbFieldTrim.Color := clSilver;
        dsQuerySource.Dataset := ABDataset;
        with ABDataset do
        begin
          if Assigned( MasterSource ) then
            dsMasterSource.Dataset := MasterSource.Dataset;
          BaseConnection := IB_Connection;
          BaseTransaction := IB_Transaction;
        end;
        BaseKey := IB_BASEKEY + '\Editors\IBOBaseQuery';
        btOk.Default := false;
        pcQuery.ActivePage := tsSQLProperties;
        pcQuerySQL.ActivePage := tsSQL;
        ShowModal;
        if ( SaveSettings or SettingsSaved ) and Assigned( Self.Designer ) then
          Self.Designer.Modified;
      finally
        Free;
      end;
  end;
end;

{$IFDEF IBO_VCL40_OR_GREATER}
function TStoredProcNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [ paValueList, paSortList ];
end;

procedure TStoredProcNameProperty.GetValues( Proc: TGetStrProc );
var
  AConnection: TIB_Connection;
  ii: integer;
begin
  AConnection := nil;
  if GetComponent(0) is TIBOStoredProc then
  begin
    (GetComponent(0) as TIBOStoredProc).InternalDataset.CheckConnection( true );
    AConnection := (GetComponent(0) as TIBOStoredProc).IB_Connection;
  end;
  if Assigned( AConnection ) then
    with AConnection.SchemaCache.ProcedureNames do
      for ii := 0 to Count - 1 do
        Proc( Strings[ ii ] );
end;
{$ENDIF}

function TTableNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [ paValueList, paSortList ];
end;

procedure TTableNameProperty.GetValues( Proc: TGetStrProc );
var
  AConnection: TIB_Connection;
  ii: integer;
begin
  AConnection := nil;
  if GetComponent(0) is TIBOBaseTable then
    AConnection := (GetComponent(0) as TIBOBaseTable).IB_Connection;
  if Assigned( AConnection ) then
  begin
    try
      AConnection.Connect;
    except
      // Do nothing.
    end;
    with AConnection.SchemaCache.TableNames do
      for ii := 0 to Count - 1 do
        Proc( Strings[ ii ] );
    with AConnection.SchemaCache.ViewNames do
      for ii := 0 to Count - 1 do 
        Proc( Strings[ ii ] );
  end;
end;

function TDatabaseNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [ paValueList, paSortList ];
end;

procedure TDatabaseNameProperty.GetValues( Proc: TGetStrProc );
var
  ASession: TIB_Session;
  ii: integer;
begin
  ASession := nil;
  if GetComponent(0) is TIBODataset then
    ASession := (GetComponent(0) as TIBODataset).IB_Session;
  if Assigned( ASession ) then with ASession do
    if Assigned( Session_Connections ) then
      for ii := 0 to Session_Connections.Count - 1 do
        with TIB_Connection( Session_Connections.Items[ ii ] ) do
          Proc( DatabaseName );
end;

function TSessionProperty.GetValue: string;
begin
  Result := inherited GetValue;
end;

procedure TSessionProperty.SetValue( const AValue: string );
begin
  if AValue = '<default>' then
    inherited SetValue( '' )
  else
    inherited SetValue( AValue );
end;

procedure TSessionProperty.GetValues( Proc: TGetStrProc );
begin
  Proc( '<default>' );
  inherited GetValues( Proc );
end;

//------------------------------------------------------------------------------

function TConnectionProperty.GetValue: string;
begin
  Result := inherited GetValue;
  if GetComponent( 0 ) is TIBODataset then
    with GetComponent( 0 ) as TIBODataset do
      if IB_Session.AllowDefaultConnection then
        if Result = '' then
          Result := '<default>';
end;

procedure TConnectionProperty.SetValue( const AValue: string );
begin
  if ( AValue = '<default>' ) then
    inherited SetValue( '' )
  else
    inherited SetValue( AValue );
end;

procedure TConnectionProperty.GetValues( Proc: TGetStrProc );
begin
  if GetComponent( 0 ) is TIBODataset then
    with GetComponent( 0 ) as TIBODataset do
    begin
      if IB_Session.AllowDefaultConnection then
        Proc( '<default>' );
    end;
  inherited GetValues( Proc );
end;

{------------------------------------------------------------------------------}

function TTransactionProperty.GetValue: string;
begin
  Result := inherited GetValue;
  if GetComponent( 0 ) is TIBODataset then
    with GetComponent( 0 ) as TIBODataset do
    begin
      if IB_Session.AllowDefaultTransaction and
        ((Result = '') or InternalDataset.UsingDefaultTransaction or
         ( Result = Name + '.tr' + Name ) ) then
        Result := '<default>';
      Exit;
    end;
end;

procedure TTransactionProperty.SetValue( const AValue: string );
begin
  if ( AValue = '<default>' ) then
    inherited SetValue( '' )
  else
    inherited SetValue( AValue );
end;

procedure TTransactionProperty.GetValues( Proc: TGetStrProc );
begin
  if GetComponent( 0 ) is TIBODataset then
    with GetComponent( 0 ) as TIBODataset do
    begin
      if IB_Session.AllowDefaultTransaction then
        Proc( '<default>' );
    end;
  inherited GetValues( Proc );
end;

{------------------------------------------------------------------------------}

procedure TVersionProperty.Edit;
begin
  with TdlgAbout.Create( Application ) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

function TVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

// Warning: This editor should be defined for TIBOBaseQuery
// and maybe for TIBOBaseTable;
// but if you define it for TIBODataset, you will cause infinite recursion.
constructor TIBOBaseQueryEditor.Create( AComponent: TComponent;
{$IFDEF IBO_VCL60_OR_GREATER}
                                        ADesigner: IDesigner );
{$ELSE}
{$IFDEF IBO_VCL40_OR_GREATER}
                                        ADesigner: IFormDesigner );
{$ELSE}
                                        ADesigner: TFormDesigner );
{$ENDIF}
var
  td: TIBODataset;
  ce: TComponentEditor;
  tec: TComponentEditorClass;
{$ENDIF}
begin
  inherited Create( AComponent, ADesigner );
{$IFDEF IBO_VCL60_OR_GREATER}
  FDBDatasetEditor := TDatasetEditor.Create( AComponent, ADesigner );
{$ELSE}
  td := TIBODataset.Create( nil );
  try
    //GetComponentEditor(AComponent, ADesigner) would get this same editor!
    ce := GetComponentEditor( td, ADesigner );
    if Assigned( ce ) then
      try
        tec := TComponentEditorClass( ce.ClassType );
        FDBDatasetEditor := tec.Create( AComponent, ADesigner );
      finally
        ce.Free;
      end;
  finally
    td.Free
  end
{$ENDIF}
end;

function TIBOBaseQueryEditor.GetVerbCount: integer;
var
  rc: Integer;
begin
  if Assigned( FDBDatasetEditor ) then
    rc := FDBDatasetEditor.GetVerbCount
  else
    rc := 0;
  Result := 1 + rc;
end;

function TIBOBaseQueryEditor.GetVerb( Index: integer ): string;
var
  rc: Integer;
begin
  Result := '';
  if Assigned( FDBDatasetEditor ) then
    rc := FDBDatasetEditor.GetVerbCount
  else
    rc := 0;
  if ( Index < rc ) and ( Index > -1 ) then
    Result := FDBDatasetEditor.GetVerb( Index )
  else
    case Index - rc of
      0: Result := 'Edit &Query';
    end;
end;

procedure TIBOBaseQueryEditor.ExecuteVerb( Index: integer );
var
  rc: Integer;
begin
  if Assigned( FDBDatasetEditor ) then
    rc := FDBDatasetEditor.GetVerbCount
  else
    rc := 0;
  if (Index < rc) and (Index > -1) then
    FDBDatasetEditor.ExecuteVerb( Index )
  else
    case Index - rc of
      0: Edit2;
    end;
end;

procedure TIBOBaseQueryEditor.Edit2;
var
  AIBOBaseQuery: TIBOBaseQuery;
  ABDataset: TIB_BDataset;
begin
  if Component is TIBOBaseQuery then
  begin
    AIBOBaseQuery := Component as TIBOBaseQuery;
    ABDataset := AIBOBaseQuery.InternalDataset;
    with TfrmQuery.Create( Application ) do
      try
        Caption := AIBOBaseQuery.Owner.Name + '.' +
                   AIBOBaseQuery.Name       + ' - ' +
                   Caption;
        pnClose.Visible := true;
        StatusBar.Visible := false;
        tsHints.TabVisible := false;
        tsMasterLinks.TabVisible := false;
        tsCalculatedFields.TabVisible := false;
        cbSearchedEdits.Visible := false;
        cbSearchedDeletes.Visible := false;
        cbPreparedEdits.Visible := false;
        dsQuerySource.Dataset := ABDataset;
        with ABDataset do
        begin
          if Assigned( MasterSource ) then
            dsMasterSource.Dataset := MasterSource.Dataset;
          BaseConnection := IB_Connection;
          BaseTransaction := IB_Transaction;
        end;
        BaseKey := IB_BASEKEY + '\Editors\IBOBaseQuery';
        btOk.Default := false;
        pcQuery.ActivePage := tsSQLProperties;
        pcQuerySQL.ActivePage := tsSQL;
        ShowModal;
        if ( SaveSettings or SettingsSaved ) and Assigned( Self.Designer ) then
          Self.Designer.Modified;
      finally
        Free;
      end;
  end;
end;

destructor TIBOBaseQueryEditor.Destroy;
begin
  FDBDatasetEditor.Free;
  FDBDatasetEditor := nil;
  inherited Destroy
end;

{                                                                              }
{   Component Registration                                                     }
{                                                                              }

procedure Register;
begin
  RegisterComponentEditor( TIBOBaseQuery, TIBOBaseQueryEditor );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIBODataset,
                          'DatabaseName',
                          TDatabaseNameProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIBOBaseTable,
                          'TableName',
                          TTableNameProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Transaction ),
                          TIBODataset,
                          'IB_Transaction',
                          TTransactionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Connection ),
                          TIBODataset,
                          'IB_Connection',
                          TConnectionProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIBODataset,
                          'Version',
                          TVersionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Session ),
                          TIBODataset,
                          'IB_Session',
                          TSessionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Transaction ),
                          TIBODataset,
                          'IB_Transaction',
                          TTransactionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Connection ),
                          TIBODataset,
                          'IB_Connection',
                          TConnectionProperty );

{$IFDEF IBO_VCL40_OR_GREATER}
  RegisterPropertyEditor( TypeInfo( string ),
                          TIBODataset,
                          'StoredProcName',
                          TStoredProcNameProperty );
{$ENDIF}

end;

end.
