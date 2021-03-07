
{                                                                              }
{  IB_Editors                                                                  }
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
  IB_Editors;

interface

uses
  Classes, Windows, Controls, Dialogs,

{$IFDEF IBO_VCL60_OR_GREATER}
  DesignIntf, DesignMenus, DesignEditors, VCLEditors,
{$ELSE}
  DsgnIntf,
{$ENDIF}

  Forms, Consts, IB_Constants,
  ComCtrls,

  IB_Components;

type

TStoredProcNameProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

TPasswordProperty = class(TStringProperty)
public
  function GetValue: string; override;
  procedure SetValue(const Value: string); override;
  function GetAttributes: TPropertyAttributes; override;
end;

TCharSetProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

TAliasNameProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

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

TDataFieldProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValues( Proc: TGetStrProc ); override;
end;

TVersionProperty = class(TStringProperty)
public
  procedure Edit; override;
  function GetAttributes: TPropertyAttributes; override;
end;

{
TScriptSQLProperty = class(TPropertyEditor)
public
  procedure Edit; override;
  function GetAttributes: TPropertyAttributes; override;
  function GetValue: string; override;
end;
}

TDestinationProperty = class(TComponentProperty)
public
//  function GetAttributes: TPropertyAttributes; override;
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

TParametersProperty = class(TPropertyEditor)
public
  procedure Edit; override;
  function GetValue: string; override;
  function GetAttributes: TPropertyAttributes; override;
end;

{------------------------------------------------------------------------------}

TIB_ComponentEditor = class(TComponentEditor)
public
  function GetVerbCount: integer; override;
  function GetVerb( Index: integer ): string; override;
  procedure ExecuteVerb( Index: integer ); override;
  procedure Edit; override;
end;

TIB_ConnectionEditor = class(TIB_ComponentEditor)
public
  procedure Edit; override;
  procedure ImportDefaults;
  function GetVerbCount: integer; override;
  function GetVerb( Index: integer ): string; override;
  procedure ExecuteVerb( Index: integer ); override;
end;

TIB_TransactionEditor = class(TIB_ComponentEditor)
public
  procedure Edit; override;
end;

TIB_StatementEditor = class(TIB_ComponentEditor)
public
  procedure Edit; override;
end;

TIB_DatasetEditor = class(TIB_ComponentEditor)
public
  procedure Edit; override;
  procedure ImportDefaults;
  function GetVerbCount: integer; override;
  function GetVerb( Index: integer ): string; override;
  procedure ExecuteVerb( Index: integer ); override;
end;

TIB_BDatasetEditor = class(TIB_DatasetEditor)
public
  procedure Edit; override;
end;

TIB_ScriptEditor = class(TIB_ComponentEditor)
public
  procedure Edit; override;
end;

TIB_DataPumpEditor = class(TIB_ComponentEditor)
public
  procedure Edit; override;
end;

procedure Register;

procedure RegisterDataFieldPropertyEditor( AClass: TComponentClass );

implementation

uses
  Registry,
  IB_Controls,
  IB_Grid,
  IB_StoredProc,
  IB_Script,
  IB_Schema,
  IB_DataPump,
  IB_ArrayGrid,
{$IFDEF IBO_VCL30_OR_GREATER}
  IB_Ledger,
  IB_LedgerEditor,
{$ENDIF}
  IBD_About,
//IBD_StringList,
  IBF_Base,
  IBF_Query,
  IBF_Script,
  IBF_DataPump,
  IBF_SQL,
  IBF_Parameters,
  IB_SessionProps;

function FixRegEntries( OldKey, NewKey: string ): string;
begin
  with TRegistry.Create do try
    MoveKey( OldKey, NewKey, False );
    DeleteKey( OldKey );
  finally
    Free;
  end;
  Result := NewKey;
end;

{
function TScriptSQLProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paDialog ];
end;

function TScriptSQLProperty.GetValue: string;
begin
  Result := '(SQL)';
end;
}
{
procedure TScriptSQLProperty.Edit;
var
  Ident: string;
  Component: TComponent;
  Module: IOTAModule;
  Editor: IOTAEditor;
  ModuleServices: IOTAModuleServices;
  Stream: TStringStream;
  Age: TDateTime;
var
  AStrings: TStrings;
begin
  if GetComponent(0) is TIB_Script then begin
    AStrings := (GetComponent(0) as TIB_Script).SQL;
  end else begin
    AStrings := nil;
  end;
  if Assigned( AStrings ) then
  begin
    Component := TComponent(GetComponent(0));
    ModuleServices := BorlandIDEServices as IOTAModuleServices;
    if (TObject(Component) is TComponent) and
       (Component.Owner = Self.Designer.GetRoot) then
    begin
      Ident := Self.Designer.GetRoot.Name + DotSep +
        Component.Name + DotSep + GetName;
      Module := ModuleServices.FindModule(Ident);
    end
    else
      Module := nil;

    if (Module <> nil) and (Module.GetModuleFileCount > 0) then
      Module.GetModuleFileEditor(0).Show
    else
    begin
      Stream := TStringStream.Create('');
      AStrings.SaveToStream(Stream);
      Stream.Position := 0;
      Age := Now;
      Module := ModuleServices.CreateModule(
        TStringsModuleCreator.Create( Ident, Stream, Age ));
      if Module <> nil then
      begin
        with StringsFileSystem.GetTStringsProperty( Ident,
                                                    Component,
                                                    GetName ) do
          DiskAge := DateTimeToFileDate( Age );
        Editor := Module.GetModuleFileEditor( 0 );
        if FModified then
          Editor.MarkModified;
        Editor.Show;
        SettingsSaved := false;
      end;
    end;
  end;
end;
}

function TPasswordProperty.GetValue: string;
var
  ii: integer;
begin
  Result := inherited GetValue;
  for ii := 1 to Length( Result ) do Result[ ii ] := '*';
end;

procedure TPasswordProperty.SetValue(const Value: string);
var
  ii: integer;
begin
  if Length( Value ) = 0 then
  begin
    inherited SetValue( Value );
  end
  else for ii := 1 to Length( Value ) do
  begin
    if Value[ ii ] <> '*' then
    begin
      inherited SetValue( Value );
      Break;
    end;
  end;
end;

function TPasswordProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paAutoUpdate];
end;

function TCharSetProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList,paSortList];
end;

procedure TCharSetProperty.GetValues( Proc: TGetStrProc );
begin
  Proc( '' );
  Proc( 'NONE' );
  Proc( 'OCTETS' );
  Proc( 'ASCII' );
  Proc( 'UNICODE_FSS' );
  Proc( 'SJIS_0208' );
  Proc( 'EUCJ_0208' );
  Proc( 'DOS437' );
  Proc( 'DOS850' );
  Proc( 'DOS865' );
  Proc( 'ISO8859_1' );
  Proc( 'DOS852' );
  Proc( 'DOS857' );
  Proc( 'DOS860' );
  Proc( 'DOS861' );
  Proc( 'DOS863' );
  Proc( 'CYRL' );
  Proc( 'WIN1250' );
  Proc( 'WIN1251' );
  Proc( 'WIN1252' );
  Proc( 'WIN1253' );
  Proc( 'WIN1254' );
  Proc( 'NEXT' );
  Proc( 'KSC_5601' );
  Proc( 'BIG_5' );
  Proc( 'GB_2312' );
end;

function TAliasNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList,paSortList];
end;

procedure TAliasNameProperty.GetValues( Proc: TGetStrProc );
var
  ii: integer;
  tmpStrings: TIB_StringList;
begin
  Proc( '' );
  tmpStrings := TIB_StringList.Create;
  try
    try
      GetBDEAliasInfo( 'DRIVER', 'INTRBASE', tmpStrings );
    except
      // Prevent interruption from a missing alias.
    end;
    for ii := 0 to tmpStrings.Count - 1 do
      Proc( tmpStrings[ii] );
  finally
    tmpStrings.Free;
  end;
end;

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
  if GetComponent(0) is TIB_Statement then begin
    (GetComponent(0) as TIB_Statement).CheckConnection( true );
    AConnection := (GetComponent(0) as TIB_Statement).IB_Connection;
  end;
  if Assigned( AConnection ) then begin
    with AConnection.SchemaCache.ProcedureNames do begin
      for ii := 0 to Count - 1 do begin
        Proc( Strings[ ii ] );
      end;
    end;
  end;
end;

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
  if GetComponent(0) is TIB_Statement then begin
    AConnection := (GetComponent(0) as TIB_Statement).IB_Connection;
{$IFDEF IBO_VCL30_OR_GREATER}
{
  end else if GetComponent(0) is TIBOBaseTable then
  begin
    AConnection := (GetComponent(0) as TIBOBaseTable).IB_Connection;
}
{$ENDIF}
  end;
  if Assigned( AConnection ) then begin
    try
      AConnection.Connect;
    except
      // Do nothing.
    end;
    with AConnection.SchemaCache.TableNames do begin
      for ii := 0 to Count - 1 do begin
        Proc( Strings[ ii ] );
      end;
    end;
    with AConnection.SchemaCache.ViewNames do begin
      for ii := 0 to Count - 1 do begin
        Proc( Strings[ ii ] );
      end;
    end;
  end;
end;

function TDataFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [ paValueList, paSortList ];
end;

procedure TDataFieldProperty.GetValues( Proc: TGetStrProc );
var
  AControl: TControl;
  AObject: TObject;
  ADataLink: TIB_DataLink;
  ii: integer;
begin
  AControl := nil;
  AObject := nil;
  ADataLink := nil;
  if GetComponent(0) is TControl then
    AControl := GetComponent(0) as TControl;
  if Assigned( AControl ) then
    AObject := TObject( AControl.Perform(CM_GETDATALINK, 0, 0));
  if AObject is TIB_DataLink then
    ADataLink := AObject as TIB_DataLink;
  if Assigned( ADataLink ) and Assigned( ADataLink.Dataset ) then
    with ADataLink.Dataset do
      if Assigned( IB_Connection ) and IB_Connection.Connected then
        try
          Prepare;
          for ii := 0 to Fields.ColumnCount - 1 do
            Proc( Fields[ ii ].BestFieldName );
        except
        // Ignore the exception.
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
  if GetComponent(0) is TIB_Statement then
    ASession := (GetComponent(0) as TIB_Statement).IB_Session;
{$IFDEF IBO_VCL30_OR_GREATER}
{
  if GetComponent(0) is TIBODataset then
    ASession := (GetComponent(0) as TIBODataset).IB_Session;
}
{$ENDIF}
  if Assigned( ASession ) then with ASession do
    if Assigned( Session_Connections ) then
      for ii := 0 to Session_Connections.Count - 1 do
        with TIB_Connection( Session_Connections.Items[ ii ] ) do
          Proc( DatabaseName );
end;

//function TDestinationProperty.GetAttributes: TPropertyAttributes;
//begin
//  Result := inherited GetAttributes;
//end;

function TSessionProperty.GetValue: string;
begin
  Result := inherited GetValue;
//  if Result = TIB_Session.DefaultSession.Name then
//    Result := '<default>';
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
  if GetComponent( 0 ) is TIB_Statement then
    with GetComponent( 0 ) as TIB_Statement do
    begin
      if IB_Session.AllowDefaultConnection then
      begin
        if Result = '' then
          Result := '<default>';
//        else
//        if UsingDefaultConnection then
//          Result := '<default>';
      end;
    end;
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
  if GetComponent( 0 ) is TIB_Statement then
    with GetComponent( 0 ) as TIB_Statement do
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
  if GetComponent( 0 ) is TIB_Statement then
    with GetComponent( 0 ) as TIB_Statement do
    begin
      if IB_Session.AllowDefaultTransaction and
        ((Result = '') or (UsingDefaultTransaction) or
        (Result = Name + '.tr' + Name) ) then
        Result := '<default>';
      Exit;
    end;
  if GetComponent( 0 ) is TIB_Script then
    with GetComponent( 0 ) as TIB_Script do
    begin
      if IB_Session.AllowDefaultTransaction and
        ((Result = '') or UsingDefaultTransaction or
         (Result = Name + '.tr' + Name)) then
        Result := '<default>';
      Exit;
    end;
  // Anything else use defaultransactions ???
  //if Result = '' then
  //begin
  //  Result := '<default>';
  //  Exit;
  //end;
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
  if GetComponent( 0 ) is TIB_Statement then
  begin
    with GetComponent( 0 ) as TIB_Statement do
    begin
      if IB_Session.AllowDefaultTransaction then
        Proc( '<default>' );
    end;
  end
  else if GetComponent( 0 ) is TIB_Script then
  begin
    with GetComponent( 0 ) as TIB_Script do
    begin
      if IB_Session.AllowDefaultTransaction then
        Proc( '<default>' );
    end;
  end;
  inherited GetValues( Proc );
end;

{------------------------------------------------------------------------------}

procedure TVersionProperty.Edit;
begin
  with TdlgAbout.Create( Application ) do try
    ShowModal;
  finally
    Free;
  end;
end;

function TVersionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{------------------------------------------------------------------------------}

function TParametersProperty.GetValue: string;
begin
  Result := '(TIB_XSQLDA)';
end;

function TParametersProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [ paDialog, paReadOnly ];
end;

procedure TParametersProperty.Edit;
var
  Statement: TIB_Statement;
  IsChanged: boolean;
begin
  IsChanged := false;
  Statement := nil;
  if GetComponent(0) is TIB_Statement then begin
    Statement := GetComponent(0) as TIB_Statement;
    if not Statement.Prepared then begin
      try
        Statement.Prepare;
      except
        { Do not show any exception! }
      end;
    end;
  end;
  if Assigned( Statement ) and Statement.Prepared then begin
    if Statement.ParamCount > 0 then begin
      with TfrmParameters.Create( nil ) do try
        Caption := Statement.Owner.Name + '.' +
                   Statement.Name + ' - ' +
                   Caption;
        BaseKey := FixRegEntries( 'Software\IB Objects\Params Editor',
                                  IB_BASEKEY + '\Editors\Params' );
        sgParameters.Statement := Statement;
        if ShowModal = idOK then begin
          sgParameters.PostChanges;
          IsChanged := true;
        end;
        sgParameters.Statement := nil;
      finally
        Free;
      end;
    end else begin
      MessageBeep( 1 );
      ShowMessage( 'Statement has no Params' );
    end;
    if IsChanged then begin
      Designer.Modified;
    end;
  end else begin
    MessageBeep( 1 );
    ShowMessage( 'Statement failed to prepare' );
  end;
end;

{------------------------------------------------------------------------------}

function TIB_ComponentEditor.GetVerbCount: integer;
begin
  Result := 1;
end;

function TIB_ComponentEditor.GetVerb( Index: integer ): string;
begin
  Result := '';
  case Index of
    0: Result := 'E&dit Component';
  end;
end;

procedure TIB_ComponentEditor.ExecuteVerb( Index: integer );
begin
  case Index of
    0: Edit;
  end;
end;

procedure TIB_ComponentEditor.Edit;
begin
  ShowMessage( 'Unassigned Edit method' );
end;

function TIB_ConnectionEditor.GetVerbCount: integer;
begin
  Result := inherited GetVerbCount + 1;
end;

function TIB_ConnectionEditor.GetVerb( Index: integer ): string;
begin
  Result := '';
  case Index of
    1: Result := '&Import Server Defaults';
  else
    Result := inherited GetVerb( Index );
  end;
end;

procedure TIB_ConnectionEditor.ExecuteVerb( Index: integer );
begin
  case Index of
    1: ImportDefaults;
  else inherited ExecuteVerb( Index );
  end;
end;

procedure TIB_ConnectionEditor.ImportDefaults;
begin
  if (Component is TIB_Connection) and (Component<>nil) then (Component as TIB_Connection).ImportServerDefaults;
end;

procedure TIB_ConnectionEditor.Edit;
begin
  with TfrmSQL.Create( Application ) do try
    pnClose.Visible := true;
    tsLayouts.TabVisible := false;
    StatusBar.Visible := false;
    csForEdit.IB_Connection := Component as TIB_Connection;
    BaseKey := FixRegEntries( 'Software\IB Objects\Editor',
                              IB_BASEKEY + '\Editors\Connection' );
    ShowModal;
    if SaveSettings or SettingsSaved then begin
      Self.Designer.Modified;
    end;
  finally
    Free;
  end;
end;

procedure TIB_TransactionEditor.Edit;
begin
  with TfrmSQL.Create( Application ) do try
    pnClose.Visible := true;
    tsLayouts.TabVisible := false;
    StatusBar.Visible := false;
    tsForEdit.IB_Transaction := Component as TIB_Transaction;
    BaseKey := FixRegEntries( 'Software\IB Objects\Editor',
                              IB_BASEKEY + '\Editors\Transaction' );
    ShowModal;
    if SaveSettings or SettingsSaved then begin
      Self.Designer.Modified;
    end;
  finally
    Free;
  end;
end;

procedure TIB_StatementEditor.Edit;
begin
  with TfrmSQL.Create( Application ) do try
    pnClose.Visible := true;
    StatusBar.Visible := false;
    tsLayouts.TabVisible := false;
    ssForEdit.Statement := Component as TIB_Statement;
    with Component as TIB_Statement do begin
      csForEdit.IB_Connection := IB_Connection;
      tsForEdit.IB_Transaction := IB_Transaction;
    end;
    BaseKey := FixRegEntries( 'Software\IB Objects\Editor',
                              IB_BASEKEY + '\Editors\Statement' );
    ShowModal;
    if SaveSettings or SettingsSaved then begin
      Self.Designer.Modified;
    end;
  finally
    Free;
  end;
end;

// *************** start change by Wassim Haddad 22-Aug-2001 ****************
function TIB_DatasetEditor.GetVerbCount: integer;
begin
  Result := inherited GetVerbCount + 1;
end;

function TIB_DatasetEditor.GetVerb( Index: integer ): string;
begin
  Result := '';
  case Index of
    1: Result := '&Import Server Defaults';
  else
    Result := inherited GetVerb( Index );
  end;
end;

procedure TIB_DatasetEditor.ExecuteVerb( Index: integer );
begin
  case Index of
    1: ImportDefaults;
  else inherited ExecuteVerb( Index );
  end;
end;

procedure TIB_DatasetEditor.ImportDefaults;
begin
  if (Component is TIB_Dataset) and (Component<>nil) then (Component as TIB_Dataset).ImportServerDefaults;
end;
// *************** end change by Wassim Haddad 22-Aug-2001 ****************

procedure TIB_DatasetEditor.Edit;
begin
  with TfrmSQL.Create( Application ) do try
    pnClose.Visible := true;
    StatusBar.Visible := false;
    tsLayouts.TabVisible := false;
    dsForEdit.Dataset := Component as TIB_Dataset;
    with Component as TIB_Statement do begin
      csForEdit.IB_Connection := IB_Connection;
      tsForEdit.IB_Transaction := IB_Transaction;
    end;
    BaseKey := FixRegEntries( 'Software\IB Objects\Editor',
                              IB_BASEKEY + '\Editors\Dataset' );
    ShowModal;
    if SaveSettings or SettingsSaved then begin
      Self.Designer.Modified;
    end;
  finally
    Free;
  end;
end;

procedure TIB_BDatasetEditor.Edit;
begin
  with TfrmQuery.Create( Application ) do try
    Caption := Component.Owner.Name + '.' +
               Component.Name       + ' - ' +
               Caption;
    pnClose.Visible := true;
    StatusBar.Visible := false;
    dsQuerySource.Dataset := Component as TIB_BDataset;
    with Component as TIB_BDataset do begin
      if Assigned( MasterSource ) then begin
        dsMasterSource.Dataset := MasterSource.Dataset;
      end;
      BaseConnection := IB_Connection;
      BaseTransaction := IB_Transaction;
    end;
    BaseKey := FixRegEntries( 'Software\IB Objects\BDataset Editor',
                              IB_BASEKEY + '\Editors\BDataset' );
    btOk.Default := false;
    ShowModal;
    if ( SaveSettings or SettingsSaved ) and
       Assigned( Self.Designer ) then begin
      Self.Designer.Modified;
    end;
  finally
    Free;
  end;
end;

procedure TIB_ScriptEditor.Edit;
begin
  with TfrmScript.Create( Application ) do try
    Caption := Component.Owner.Name + '.' +
               Component.Name       + ' - ' +
               Caption;
    pnClose.Visible := true;
    StatusBar.Visible := false;
    cbStore.Visible := false;
    ScriptForEdit := Component as TIB_Script;
    BaseConnection := (Component as TIB_Script).IB_Connection;
    BaseTransaction := (Component as TIB_Script).IB_Transaction;
    BaseKey := FixRegEntries( 'Software\IB Objects\Script Editor',
                              IB_BASEKEY + '\Editors\Script' );
    ShowModal;
    if SaveSettings or SettingsSaved then begin
      Self.Designer.Modified;
    end;
  finally
    Free;
  end;
end;

procedure TIB_DataPumpEditor.Edit;
begin
  with TfrmDataPump.Create( Application ) do try
    Caption := Component.Owner.Name + '.' +
               Component.Name       + ' - ' +
               Caption;
    pnClose.Visible := true;
    StatusBar.Visible := false;
    pnDstSQL.Visible := false;
    pnDstSpacer.Visible := false;
    pnSrcSQL.Visible := false;
    pnSrcSpacer.Visible := false;
    tsExecute.TabVisible := false;
    DataPumpForEdit := Component as TIB_DataPump;
    SrcForEdit := DataPumpForEdit.SrcDataset;
    DstForEdit := DataPumpForEdit.DstStatement;
    if Assigned( SrcForEdit ) then begin
      csSrc.IB_Connection := SrcForEdit.IB_Connection;
      tsSrc.IB_Transaction := SrcForEdit.IB_Transaction;
    end;
    if Assigned( DstForEdit ) then begin
      csDst.IB_Connection := DstForEdit.IB_Connection;
      tsDst.IB_Transaction := DstForEdit.IB_Transaction;
    end;
    BaseKey := FixRegEntries( 'Software\IB Objects\DataPump Editor',
                              IB_BASEKEY + '\Editors\DataPump' );
    ShowModal;
    if SaveSettings or SettingsSaved then begin
      Self.Designer.Modified;
    end;
  finally
    Free;
  end;
end;

procedure RegisterDataFieldPropertyEditor( AClass: TComponentClass );
begin
  RegisterPropertyEditor( TypeInfo( string ),
                          AClass,
                          'DataField',
                          TDataFieldProperty );
end;

procedure Register;
begin
  RegisterComponentEditor( TIB_Connection, TIB_ConnectionEditor );
  RegisterComponentEditor( TIB_Transaction, TIB_TransactionEditor );
  RegisterComponentEditor( TIB_Statement, TIB_StatementEditor );
  RegisterComponentEditor( TIB_Dataset, TIB_DatasetEditor );
  RegisterComponentEditor( TIB_BDataset, TIB_BDatasetEditor );
  RegisterComponentEditor( TIB_Script, TIB_ScriptEditor );
  RegisterComponentEditor( TIB_DataPump, TIB_DataPumpEditor );
{
  RegisterPropertyEditor( TypeInfo( TStrings ),
                          TIB_Script,
                          'SQLEditor',
                          TScriptSQLProperty );
}
  RegisterPropertyEditor( TypeInfo( TIB_Row ),
                          TIB_Statement,
                          'Params',
                          TParametersProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_Connection,
                          'Password',
                          TPasswordProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_Connection,
                          'CharSet',
                          TCharSetProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_Connection,
                          'AliasName',
                          TAliasNameProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_Statement,
                          'DatabaseName',
                          TDatabaseNameProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_Component,
                          'Version',
                          TVersionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Session ),
                          TIB_Component,
                          'IB_Session',
                          TSessionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Transaction ),
                          TIB_Statement,
                          'IB_Transaction',
                          TTransactionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Connection ),
                          TIB_Statement,
                          'IB_Connection',
                          TConnectionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Transaction ),
                          TIB_Script,
                          'IB_Transaction',
                          TTransactionProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Connection ),
                          TIB_Script,
                          'IB_Connection',
                          TConnectionProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_Statement,
                          'StoredProcName',
                          TStoredProcNameProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_Statement,
                          'StoredProcName',
                          TStoredProcNameProperty );

  RegisterPropertyEditor( TypeInfo( TIB_Statement ),
                          TIB_DataPump,
                          'Destination',
                          TDestinationProperty );

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_CustomCombo,
                          'DisplayField',
                          TDataFieldProperty );

  RegisterDataFieldPropertyEditor( TIB_ArrayGrid );
  RegisterDataFieldPropertyEditor( TIB_CustomText );
  RegisterDataFieldPropertyEditor( TIB_CustomDate );
  RegisterDataFieldPropertyEditor( TIB_CustomEdit );
  RegisterDataFieldPropertyEditor( TIB_CustomMemo );
  RegisterDataFieldPropertyEditor( TIB_CustomRichEdit );
  RegisterDataFieldPropertyEditor( TIB_CustomImage );
  RegisterDataFieldPropertyEditor( TIB_CustomListBox );
  RegisterDataFieldPropertyEditor( TIB_CustomComboBox );
  RegisterDataFieldPropertyEditor( TIB_CustomCheckBox );
  RegisterDataFieldPropertyEditor( TIB_CustomRadioGroup );
{$IFDEF IBO_VCL30_OR_GREATER}
  RegisterDataFieldPropertyEditor( TIB_CustomDateTimePicker );
{$ENDIF}

  RegisterPropertyEditor( TypeInfo( string ),
                          TIB_CustomGrid,
                          'StretchColumn',
                          TDataFieldProperty );

{$IFDEF IBO_VCL50}//_OR_GREATER}
  RegisterPropertiesInCategory( TDatabaseCategory, [ 'BufferSynchroFlags',
                                                     'ColumnAttributes',
                                                     'DatabaseName',
                                                     'DefaultValues',
                                                     'DeleteSQL',
                                                     'EditSQL',
                                                     'FetchWholeRows',
                                                     'FieldsAlignment',
                                                     'FieldsCharCase',
                                                     'FieldsDisplayFormat',
                                                     'FieldsDisplayLabel',
                                                     'FieldsDisplayWidth',
                                                     'FieldsEditMask',
                                                     'FieldsGridlabel',
                                                     'FieldsReadOnly',
                                                     'FieldsTrimming',
                                                     'FieldsVisible',
                                                     'GeneratorLinks',
                                                     'InsertSQL',
                                                     'KeyLinks',
                                                     'KeyLinksAutoDefine',
                                                     'KeyRelation',
                                                     'PessimisticLocking' ] );

  RegisterPropertiesInCategory( TLocalizableCategory, [ 'CallbackCaption' ] );
{$ENDIF}

{$IFDEF IBO_VCL30_OR_GREATER}
  RegisterComponentEditor( TIB_Ledger, TIB_LedgerEditor );
  RegisterPropertyEditor( TypeInfo( TIB_LedgerRowDefs ),
                          TIB_Ledger,
                          '',
                          TIB_LedgerRowDefsProperty );
{$ENDIF}

  RegisterPropertyEditor( TypeInfo( TIB_ScreenCursor ),
                          TIB_SessionProps,
                          'BusyCursor',
                          TCursorProperty );
  RegisterPropertyEditor( TypeInfo( TIB_ScreenCursor ),
                          TIB_SessionProps,
                          'YieldCursor',
                          TCursorProperty );
end;

end.
