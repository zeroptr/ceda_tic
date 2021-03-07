
{                                                                              }
{ TIB_Script                                                                   }
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
{  07-Nov-2001                                                                 }
{     Made the current script position (BeginPos) available for readonly       }
{     public access, so that it can be used to give progress indication.       }
{                                                                              }
{  Don Shoeman <ds@cellpt.co.za>                                               }
{  07/27/2001                                                                  }
{     Changed the Macro delimiter characters to strings for more flexibility.  }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

{: This unit contains the TIB_Script component.}
unit IB_Script;

interface

uses
  Classes, SysUtils, Forms,

  IB_Header,
  IB_Session,
  IB_Constants,
  IB_Components,
  IB_Process,
  IB_Parse;
//IBF_Base
//IBF_Script

type
TIB_Script = class;

{: This event allows a little bit of extra control over statements that the
script is executing.
<br><br>
It is possible to do your won custom processing and then set SkipIt to true so
that no action will be take with this statement and then next one in the script
will be processed.
<br><br>
It is also possible to alter the statement as well since it is passed by
reference.
<br><br>
SET TERM is supported as in an ISQL script too. Other ISQL SET commands are
simply ignored and no error will result by them being in the script.}
TIB_ScriptStatementEvent = procedure(     Sender: TIB_Script;
                                      var Statement: string;
                                      var SkipIt: boolean ) of object;

{: This component allows multiple consecutive DML, DDL, etc. statements to
be executed sequentially.
<br><br>
This is very useful for creating database files or for performing batch
updates.
<br><br>
During the process of execution if the API returns an error code the
OnError event gives an opportunity to override or handle it and determine if
execution of the Script should continue or not. To examine the statement that
caused the error check the CurrentSQL property.
<br><br>
It is also possible to provide custom handling per each individual statement
that will be processed. Use the OnStatement event for this.}
TIB_Script = class(TIB_Process)
private
{ Property storage variables }
  FDSQL: TIB_DSQL;
  FCurrentSQL: string;
  FSetItem: string;
  FSetValue: string;
  FIgnoreExceptionCount: integer;
  FIgnoredExceptions: integer;
  FMacroBegin: string;
  FMacroEnd: string;
  FOnStatement: TIB_ScriptStatementEvent;
  FBeginPos: integer;
  FEndPos: integer;
{ Property Access Methods }
  function GetSQL: TStrings;
  procedure SetSQL( AStrings: TStrings );
  function GetConnection: TIB_Connection;
  function GetTransaction: TIB_Transaction;
  procedure SetConnection( AValue: TIB_Connection );
  procedure SetTransaction( AValue: TIB_Transaction );
  function GetMacroBegin: string;
  function GetMacroEnd: string;
  procedure SetMacroBegin( AValue: string);
  procedure SetMacroEnd( AValue: string);
  function GetOnMacroSubstitute: TIB_MacroSubstituteEvent;
  procedure SetOnMacroSubstitute( AValue: TIB_MacroSubstituteEvent );
  function IsMacroBeginStored: boolean;
  function IsMacroEndStored: boolean;
protected
  property InternalDSQL: TIB_DSQL read FDSQL;
  procedure SysExecute( var IsDone: boolean ); override;
  procedure DoHandleError(       Sender: TObject;
                           const errcode: longint;
                                 ErrorMessage,
                                 ErrorCodes: TStringList;
                           const SQLCODE: longint;
                                 SQLMessage,
                                 SQL: TStringList;
                             var RaiseException: boolean); override;
  procedure DoStatement( var AStatement, ASetItem, ASetValue: string;
                         var SkipIt: boolean ); virtual;
public
{$IFNDEF HELPSCAN}
  constructor Create( AOwner: TComponent ); override;
{: Tell whether the default transaction of the connection is being used.}
  function UsingDefaultTransaction: boolean;
{$ENDIF}
{: The individual statement that is currently being sent to the API.
<br><br>
If an error occurs and the OnError event has been tapped into then this
property tells you which statement the error has occurred on.}
  property CurrentSQL: string read FCurrentSQL;
{: This property tells how many exceptions were ignored as a result of using
the SET IGNOREEXCEPTCNT n setting. This is used to tell how many lines ahead an
exception should be ignored with.}
  property IgnoredExceptions: integer read FIgnoredExceptions;
{: When parsing through a script there are various SET statements that are
valid ISQL syntax. I have attempted to isolate these and prepare then so
that it is possible to even embed your own SET commands in the script and then
provide some sort of custom behavior in the event or an overriden method.}
  property SetItem: string read FSetItem;
{: When parsing through a script there are various SET statements that are
valid ISQL syntax. I have attempted to isolate these and prepare then so
that it is possible to even embed your own SET commands in the script and then
provide some sort of custom behavior in the event or an overriden method.}
  property SetValue: string read FSetValue;
{: Only valid/useful while the script is executing.  Can be read to give
an indication of the progress through the script.  This property indicates
the start position of the statement (in the script) about to be executed.
This can be compared against the length of the script to give a progress
indicator.}
  property BeginPos: integer read FBeginPos;

{$I IB_Process.PBL}

published

{: Stores the statements to be executed.
<br><br>
SET TERM is supported as in an ISQL script.
<br><br>
Note: Use the Delphi code editor for files that end in SQL to take advantage
of Delphi's great editor and SQL syntax color highlighting.}
  property SQL: TStrings read GetSQL write SetSQL;
{: This is just to provide a design-time editor.}
//property SQLEditor: TStrings read GetSQL write SetSQL stored false;
{: Connection for which this script will be executed.}
  property IB_Connection: TIB_Connection read GetConnection
                                         write SetConnection;
{: Transaction for which the script will be executed in.}
  property IB_Transaction: TIB_Transaction read GetTransaction
                                           write SetTransaction;
{: Text to signify the beginning of a macro.}
  property MacroBegin: string read GetMacroBegin
                              write SetMacroBegin
                              stored IsMacroBeginStored;
{: Text to signify the end of a macro.}
  property MacroEnd: string read GetMacroEnd
                            write SetMacroEnd
                            stored IsMacroEndStored;
{: Property which will allow macros embedded in the script to be processed.}
  property OnMacroSubstitute: TIB_MacroSubstituteEvent
    read GetOnMacroSubstitute
    write SetOnMacroSubstitute;
{: This event allows a little bit more control over how statements are
executed by the script.
<br><br>
The text of the statement can be altered or the statement can be skipped all
together if desired. This allows another action to be taken and does not
force that a valid statement be executed per each parsed statement.}
  property OnStatement: TIB_ScriptStatementEvent read FOnStatement
                                                 write FOnStatement;
end;

implementation

constructor TIB_Script.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FDSQL := TIB_DSQL.Create( Self );
  FDSQL.OnError := DoHandleError;
  FCurrentSQL := '';
  FMacroBegin := '';
  FMacroEnd := '';
end;

function TIB_Script.GetConnection: TIB_Connection;
begin Result := FDSQL.IB_Connection; end;
function TIB_Script.GetTransaction: TIB_Transaction;
begin Result := FDSQL.IB_Transaction; end;
procedure TIB_Script.SetConnection( AValue: TIB_Connection );
begin FDSQL.IB_Connection := AValue; end;
procedure TIB_Script.SetTransaction( AValue: TIB_Transaction );
begin FDSQL.IB_Transaction := AValue; end;
function TIB_Script.GetSQL: TStrings;
begin Result := FDSQL.SQL; end;
procedure TIB_Script.SetSQL( AStrings: TStrings );
begin FDSQL.SQL.Assign( AStrings ); end;
function TIB_Script.GetOnMacroSubstitute: TIB_MacroSubstituteEvent;
begin Result := FDSQL.OnMacroSubstitute; end;
procedure TIB_Script.SetOnMacroSubstitute( AValue: TIB_MacroSubstituteEvent );
begin FDSQL.OnMacroSubstitute := AValue; end;
function TIB_Script.UsingDefaultTransaction: boolean;
begin
  Result := FDSQL.UsingDefaultTransaction;
end;

procedure TIB_Script.SysExecute;
var
  SQLText: string;
  TermKeyWord: string;
  tmpPos: longint;
  SkipIt: boolean;
  WasExecuted: boolean;
begin
  FIgnoredExceptions := 0;
  FIgnoreExceptionCount := 0;
  WasExecuted := false;
  SQLText := SQL.Text;
  FBeginPos := ParseLineInvalid;
  FEndPos := ParseLineEnd;
  TermKeyWord := '';
  FCurrentSQL := '';
  FDSQL.CheckTransaction( false );
  if not Assigned( IB_Transaction ) then
    raise Exception.Create( E_NO_TRANSACTION );
  IB_Transaction.UpdateStatus;
  try
    while not ExecutingAborted and
          GetNextScriptStatement( SQLText,
                                  FCurrentSQL, FSetItem, FSetValue,
                                  FBeginPos,
                                  FEndPos,
                                  TermKeyWord ) do
    begin
      SkipIt := false;
      DoStatement( FCurrentSQL, FSetItem, FSetValue, SkipIt );
      if CurrentSQL = '' then
        SkipIt := true;
      if not SkipIt then
      begin
        if FSetItem = '' then
        begin
          FDSQL.ExecuteImmediate( CurrentSQL, nil );
          WasExecuted := true;
          if FIgnoreExceptionCount > 0 then
            Dec( FIgnoreExceptionCount );
        end
        else
        if FSetItem = 'IGNOREEXCEPTCNT' then
        begin
          tmpPos := StrToInt( Trim( FSetValue ));
          if tmpPos > 0 then
            FIgnoreExceptionCount := tmpPos;
        end
        else
        if FSetItem = 'AUTODDL' then
          IB_Transaction.ServerAutoCommit := UpperCase( FSetValue ) = 'ON'
        else
        if FSetItem = 'SQLDIALECT' then
          IB_Connection.SQLDialect := StrToInt( Trim( FSetValue ))
        else
        if FSetItem = 'SQL' then
        begin
          tmpPos := Pos( 'DIALECT', UpperCase( FSetValue ));
          if tmpPos > 0 then
            FSetValue := Trim( Copy( FSetValue, tmpPos + 7, MaxInt ));
          IB_Connection.SQLDialect := StrToInt( Trim( FSetValue ));
        end;
      end;
      DoProcessYield;
    end;
  finally
    FCurrentSQL := '';
    if ( WasExecuted ) and
       ( IB_Transaction.TransactionState <> tsActive ) and
       ( IB_Transaction.Started ) and
       ( not IB_Transaction.ServerAutoCommit ) then
      IB_Transaction.Activate
    else
      IB_Transaction.UpdateStatus;
  end;
end;

procedure TIB_Script.DoStatement( var AStatement, ASetItem, ASetValue: string;
                                  var SkipIt: boolean );
begin
  if Assigned( FOnStatement ) then
    FOnStatement( Self, AStatement, SkipIt );
end;

function TIB_Script.GetMacroBegin: string;
begin
  if Assigned(IB_Connection) then
  begin
    if FMacroBegin = '' then
      Result := IB_Connection.MacroBegin
    else
      Result := FMacroBegin;
  end
  else
    Result := FMacroBegin;
end;

function TIB_Script.GetMacroEnd: string;
begin
  if Assigned(IB_Connection) then
  begin
    if FMacroEnd = '' then
      Result := IB_Connection.MacroEnd
    else
      Result := FMacroEnd;
  end
  else
    Result := FMacroEnd;
end;

procedure TIB_Script.SetMacroBegin( AValue: string );
begin
  if (AValue <> FMacroBegin) then
  begin
    if Assigned(IB_Connection) then
    begin
      if AValue = IB_Connection.MacroBegin then
        FMacroBegin := ''
      else
        FMacroBegin := Trim(AValue);
    end
    else
      FMacroBegin := Trim(AValue);
  end;
end;

procedure TIB_Script.SetMacroEnd( AValue: string );
begin
  if (AValue <> FMacroEnd) then
  begin
    if Assigned(IB_Connection) then
    begin
      if AValue = IB_Connection.MacroEnd then
        FMacroEnd := ''
      else
        FMacroEnd := Trim(AValue);
    end
    else
      FMacroEnd := Trim(AValue);
  end;
end;


function TIB_Script.IsMacroBeginStored: boolean;
begin
  Result := (FMacroBegin <> '');
  if Result and Assigned(IB_Connection) then
  begin
    Result := (FMacroBegin <> IB_Connection.MacroBegin)
  end;
end;

function TIB_Script.IsMacroEndStored: boolean;
begin
  Result := (FMacroEnd <> '');
  if Result and Assigned(IB_Connection) then
  begin
    Result := (FMacroEnd <> IB_Connection.MacroEnd)
  end;
end;


procedure TIB_Script.DoHandleError(       Sender: TObject;
                                    const errcode: isc_long;
                                          ErrorMessage,
                                          ErrorCodes: TStringList;
                                    const SQLCODE: isc_long;
                                          SQLMessage,
                                          SQL: TStringList;
                                      var RaiseException: boolean);
var
  tmpStr: string;
  tmpLen: longint;
begin
  if SQLCODE = -104 then
  begin
    MakeServerSQL( CurrentSQL, nil, nil, nil, tmpStr, #0, false, tmpLen );
    tmpStr := Trim( tmpStr );
  end
  else
    tmpStr := CurrentSQL;
  if Length( tmpStr ) = 0 then
    RaiseException := false
  else
  begin
    if RaiseException and ( FIgnoreExceptionCount > 0 ) then
      RaiseException := false;
    SQL.Add( CurrentSQL );
    inherited DoHandleError( Self,
                             errcode,
                             ErrorMessage,
                             ErrorCodes,
                             SQLCODE,
                             SQLMessage,
                             SQL,
                             RaiseException );
  end;
end;

end.

