
{                                                                              }
{ IB_StoredProc                                                                }
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

{: This unit contains the TIB_StoredProc component.}
unit
  IB_StoredProc;

interface

uses
  SysUtils, Windows, Classes, Forms,

  IB_Header,
  IB_Constants,
  IB_Components,
  IB_Session;

type
{: This component is designed to execute stored procedures that return a
single row of output, if any. It will also behave like a TIB_Cursor for
procedures that return multiple rows.
<br><br>
Results of this component, if any, are found in the Fields[] array and not in
the Params[] array.}
TIB_StoredProc = class(TIB_Dataset)
{$I IBA_Statement.PBL }
private
  FParamNames: TIB_StringList;
  FStoredProcName: string;
  FStoredProcForSelect: boolean;
  FAutoDefineParams: boolean;
  FUpdatingSQL: boolean;
  function GetParamNames: TStrings;
  procedure ParamNamesChange( AValue: TObject );
  procedure SetParamNames( AValue: TStrings );
  procedure SetStoredProcName( AValue: string );
  procedure SetStoredProcForSelect( AValue: boolean );
protected
  function GetSQL: TStrings; override;
  procedure SysSQLChange( Sender: TObject; var Unprepare: boolean ); override;
  procedure SysExecute; override;
  function SysAfterFetchCursorRow: boolean; override;
  procedure UpdateSQL; virtual;
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{$IFNDEF HELPSCAN}
  procedure Execute; override;
  function ParamByName( const AFieldName: string ): TIB_Column; override;
  property CallbackInc default 1;
{$ENDIF}
  
{: This method will execute the procedure.
<br><br>
It is not necessary to close the stored procedure before calling ExecProc again.
It will be closed automatically.}
  procedure ExecProc; 

published

{ New Properties }

{: If you do not know the names of the input parameters then set this to
true amd have them defined for you internally. This will cause the system
metadata to be queried in order to figure it out so it is to your advantage
to provide them if you can in order to avoid this extra piece of work.}
  property AutoDefineParams: boolean read FAutoDefineParams
                                     write FAutoDefineParams
                                     default true;
{: Provides a list of input parameter names to use when the statement is
Prepared. Be sure to set AutoDefineParams to false if you know these.
Otherwise, the metadata will be queried and this property will be ignored.}
  property ParamNames: TStrings read GetParamNames write SetParamNames;
{: If the stored procedure is for the purpose of selecting multiple records or
for selecting a single record where the SUSPEND statement has been used in the
stored procedure then set this property to true. Then, use this just like you
would an IB_Cursor to navigate through the records in a unidirectional fashion.
<BR><BR>
When this is false the ExecProc method should be called to execute the stored
procedure. This will properly handle the output row when SUSPEND is not used
in the body of the stored procedure.}
  property StoredProcForSelect: boolean read FStoredProcForSelect
                                        write SetStoredProcForSelect
                                        default false;
{: The name of the stored procedure to be executed.}
  property StoredProcName: string read FStoredProcName write SetStoredProcName;
{: After the stored procedure is executed it is necessary to inform the
IB_Transaction component if any DML was performed so that it can become active.
<br><br>
If this is set at false and DML is performed the transaction status will not
be updated to tsActive and changes made in the stored procedure could be lost
depending on how the transaction is closed.
<br><br>
Set this to false for procedures that are returning information only.}
  property StoredProcHasDML;

{ Events }

{$IFNDEF HELPSCAN}
  property BeforePrepare;
  property AfterPrepare;
  property BeforeUnprepare;
  property AfterUnprepare;
{$ENDIF}  
end;

implementation

uses
  IB_Parse;

constructor TIB_StoredProc.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FParamNames := TIB_StringList.Create;
  FParamNames.OnChange := ParamNamesChange;
  FAutoDefineParams := true;
  inherited CallbackInc := 1;
end;

destructor TIB_StoredProc.Destroy;
begin
  Destroying;
  try
    IB_Connection := nil;
  except
  end;
  inherited Destroy;
  FParamNames.Free;
  FParamNames := nil;
end;

function TIB_StoredProc.ParamByName( const AFieldName: string ): TIB_Column;
begin
  Prepare;
  Result := FindParam( AFieldName );
  if not Assigned( Result ) then
    Result := Fields.ByName( AFieldName );
  if not Assigned( Result ) then
    Result := inherited ParamByName( AFieldName );
end;

procedure TIB_StoredProc.ExecProc;
begin
  Prepare;
  if StatementType = stExecProcedure then
    Execute
  else
  if StatementType = stSelect then
  begin
    if Active then
      Close;
    Open;
  end
  else
    raise EIB_StatementError.Create( E_InvalidStatementType );
end;

procedure TIB_StoredProc.Execute;
begin
  if Active then
    Close;
  inherited Execute;
end;

procedure TIB_StoredProc.SysExecute;
begin
  inherited SysExecute;
  if ( StatementType <> stExecProcedure ) and Bof then
    SysMoveBy( 1 );
end;

function TIB_StoredProc.SysAfterFetchCursorRow: boolean;
begin
  Result := inherited SysAfterFetchCursorRow;
  if StoredProcHasDML and ( not IB_Transaction.ServerAutoCommit ) then 
    IB_Transaction.Activate;
end;

function TIB_StoredProc.GetParamNames: TStrings;
begin
  Result := FParamNames;
end;

procedure TIB_StoredProc.SetParamNames( AValue: TStrings );
begin
  FParamNames.Assign( AValue );
end;

procedure TIB_StoredProc.ParamNamesChange( AValue: TObject );
begin
  if not PreparingSQL then
  begin
    Prepared := false;
    UpdateSQL;
  end;
end;

procedure TIB_StoredProc.SetStoredProcName( AValue: string );
begin
  AValue := Trim( AValue );
  if StoredProcName <> AValue then
  begin
    FStoredProcName := AValue;
    Prepared := false;
    UpdateSQL;
  end;
end;

procedure TIB_StoredProc.SetStoredProcForSelect( AValue: boolean );
var
  WasPrepared: boolean;
begin
  if StoredProcForSelect <> AValue then
  begin
    FStoredProcForSelect := AValue;
    WasPrepared := Prepared;
    Prepared := false;
    UpdateSQL;
    Prepared := WasPrepared;
  end;
end;

function TIB_StoredProc.GetSQL: TStrings; 
begin
  if not SQLIsValid then
    UpdateSQL;
  Result := inherited GetSQL; 
end;

procedure TIB_StoredProc.UpdateSQL;
var
  ii: integer;
  FieldNames: TIB_StringList;
  tmpIdent: string;
begin
  if not FUpdatingSQL then
  begin
    FUpdatingSQL := true;
    try
      tmpIdent := Trim( StoredProcName );
      if tmpIdent = '' then
        SQL.Clear
      else
      begin
        FieldNames := TIB_StringList.Create;
        try
          if not ( csReading in ComponentState ) then
            CheckConnection( PreparingSQL );
          if Assigned( IB_Connection ) and IB_Connection.Connected then
          begin
            if AutoDefineParams then
              IB_Connection.
                SchemaCache.
                  GetProcedureParamNames( tmpIdent,
                                          true,
                                          TIB_StringList( ParamNames ));
            IB_Connection.SchemaCache.GetProcedureParamNames( tmpIdent,
                                                              false,
                                                              FieldNames );
          end;
          with SQL do
          begin
            BeginUpdate;
            try
              Clear;
              if ( FieldNames.Count > 0 ) and StoredProcForSelect then
              begin
                if ParamNames.Count = 0 then
                  Add( 'SELECT * FROM ' + tmpIdent )
                else
                begin
                  Add( 'SELECT * FROM ' + tmpIdent + '( ' );
                  for ii := 0 to ParamNames.Count - 1 do
                  begin
                    if ii = ParamNames.Count - 1 then
                      Add( '  ?' + Trim( ParamNames[ ii ] ))
                    else
                      Add( '  ?' + Trim( ParamNames[ ii ] ) + ',' );
                  end;
                  Add( '  )' );
                end;
              end
              else
              begin
                Add( 'EXECUTE PROCEDURE ' + tmpIdent );
                for ii := 0 to ParamNames.Count - 1 do
                begin
                  if ii = ParamNames.Count - 1 then
                    Add( '  ?' + Trim( ParamNames[ ii ] ))
                  else
                    Add( '  ?' + Trim( ParamNames[ ii ] ) + ',' );
                end;
              end;
            finally
              EndUpdate;
            end;
          end;
        finally
          FieldNames.Free;
        end;
      end;
    finally
      FUpdatingSQL := false;
    end;
  end;
end;

procedure TIB_StoredProc.SysSQLChange(     Sender: TObject;
                                       var Unprepare: boolean );
var
  tmpProc: string;
  tmpLen: longint;
begin
  if not PreparingSQL and not FUpdatingSQL then
  begin
    FUpdatingSQL := true;
    try
      if not ( csLoading in ComponentState ) then
        FAutoDefineParams := false;
      ExtractStoredProcedure( SQL.Text,
                              tmpProc,
                              FParamNames,
                              ParamChar );
      if tmpProc <> '' then
      begin
        FStoredProcName := tmpProc;
        FStoredProcForSelect := false;
      end
      else
      if IsSelectSQL then
      begin
        FStoredProcName := SysKeyRelation;
        FStoredProcForSelect := true;
        MakeServerSQL( SQL.Text,
                       FParamNames,
                       nil,
                       nil,
                       tmpProc,
                       ParamChar,
                       true,
                       tmpLen );
      end
      else
        FParamNames.Clear;
    finally
      FUpdatingSQL := false;
    end;
  end;
end;

end.
