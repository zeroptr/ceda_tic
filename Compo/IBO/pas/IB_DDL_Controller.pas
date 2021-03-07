
{                                                                              }
{ IB_DDL_Controller                                                            }
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
  IB_DDL_Controller;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  IB_Components,
  IB_Process,

  IB_DDL_EntityList,
  IB_DDL_ParamList;
//IB_DDL_Entity
//IB_DDL_Utility

type
  TIB_DDL_Sections = ( ddlDatabase,
                       ddlException,
                       ddlBlobFilter,
                       ddlUDF,
                       ddlGenerator,
                       ddlDomain,
                       ddlIndex,
                       ddlTrigger,
                       ddlTable,
                       ddlView,
                       ddlProcedure,
                       ddlRole,
                       ddlPermission );
  TIB_DDL_SectionSet = set of TIB_DDL_Sections;

  TIB_DDL_ExtractOption = ( mcoFixFirstExceptionNumber,
                               mcoAdjustCharsetAlways,
                               mcoExtractGenValues,
                               mcoShowSYSDBARights );
                           
  TIB_DDL_ExtractOptions = set of TIB_DDL_ExtractOption;
  TIB_DDL_ExtractFormatType = ( mcfText, mcfHTML );

  TIB_DDL_Extract = class( TIB_ConnectionProcess )
  private
    FListArray: array[0..13] of TIB_DDL_EntityList;
    FListIdx, FDomainIdx, FIndexIdx, FTriggerIdx: Integer;
    FIB_Transaction: TIB_Transaction;
    FFormatterType: TIB_DDL_ExtractFormatType;
    FTerminatorToken: string;
    FActivateDebug: Boolean;
    FOptions: TIB_DDL_ExtractOptions;
    FColorForIdentifiers: TColor;
    FColorForLiteralStrings: TColor;
    FSkipDoubleQuotes: Boolean;
    FIndentationDepth: SmallInt;
    FDDL_Sections: TIB_DDL_SectionSet;
    procedure I( el: TIB_DDL_EntityList );
    procedure O( s, s2: TStrings );
    procedure SetTerminatorToken( const S: string );
  protected
    procedure SysPrepare; override;
    procedure SysUnprepare; override;
    procedure SetConnection( AValue: TIB_Connection ); override;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure ExecuteStream( DDL_Stream, ERR_Stream: TStream );
    procedure ExecuteStrings( DDL_Strings, ERR_Strings: TStrings );
  published
    property DDL_Sections: TIB_DDL_SectionSet read FDDL_Sections
                                              write FDDL_Sections
                                              default [ ddlDatabase,
                                                        ddlException,
                                                        ddlBlobFilter,
                                                        ddlUDF,
                                                        ddlGenerator,
                                                        ddlDomain,
                                                        ddlIndex,
                                                        ddlTrigger,
                                                        ddlTable,
                                                        ddlView,
                                                        ddlProcedure,
                                                        ddlRole,
                                                        ddlPermission ];
    property FormatterType: TIB_DDL_ExtractFormatType read FFormatterType
                                                         write FFormatterType
                                                         default mcfText;
    property TerminatorToken: String read FTerminatorToken
                                     write SetTerminatorToken;
    property ActivateDebug: Boolean read FActivateDebug
                                    write FActivateDebug
                                    default False;
    property Options: TIB_DDL_ExtractOptions read FOptions
                                                write FOptions
                                                default [];
    property ColorForIdentifiers: TColor read FColorForIdentifiers
                                         write FColorForIdentifiers
                                         default clBlue;
    property ColorForLiteralStrings: TColor read FColorForLiteralStrings
                                            write FColorForLiteralStrings
                                            default clOlive;
    property SkipDoubleQuotes: Boolean read FSkipDoubleQuotes
                                       write FSkipDoubleQuotes
                                       default False;
    property IndentationDepth: SmallInt read FIndentationDepth
                                        write FIndentationDepth
                                        default 3;
  end;

implementation

uses
  IB_DDL_Formatter;

constructor TIB_DDL_Extract.Create(AOwner: TComponent); 
begin
  inherited Create( AOwner );
  FIB_Transaction := TIB_Transaction.Create( Self );
  FIB_Transaction.Isolation := tiCommitted;
  SetTerminatorToken( ';' );
  FFormatterType := mcfText;
  FColorForIdentifiers := clBlue;
  FColorForLiteralStrings := clOlive;
  FActivateDebug := false;
  FSkipDoubleQuotes := false;
  FIndentationDepth := 3;
  FDDL_Sections := [ ddlDatabase,
                     ddlException,
                     ddlBlobFilter,
                     ddlUDF,
                     ddlGenerator,
                     ddlDomain,
                     ddlIndex,
                     ddlTrigger,
                     ddlTable,
                     ddlView,
                     ddlProcedure,
                     ddlRole,
                     ddlPermission ];
end;

destructor TIB_DDL_Extract.Destroy; 
begin
  inherited Destroy;
end;

procedure TIB_DDL_Extract.SetConnection( AValue: TIB_Connection );
begin
  inherited SetConnection( AValue );
  FIB_Transaction.IB_Connection := AValue;
end;
procedure TIB_DDL_Extract.I(el: TIB_DDL_EntityList);
begin
  // Assumes TIB_DDL_Database always at zero pos.
  el._DatabaseList := FListArray[0] as TIB_DDL_DatabaseList;
  FListArray[FListIdx] := el;
  if el is TIB_DDL_DomainList  then FDomainIdx  := FListIdx else
  if el is TIB_DDL_IndexList   then FIndexIdx   := FListIdx else
  if el is TIB_DDL_TriggerList then FTriggerIdx := FListIdx;
  Inc( FListIdx );
  el.IB_Connection := IB_Connection;
  el.IB_Transaction := FIB_Transaction;
  el.FormatterType := TIB_DDL_FormatterType(FFormatterType);
  if el is TIB_DDL_ExceptionList then
  begin
    TIB_DDL_ExceptionList(el).FixFirstExceptionNumber :=
      mcoFixFirstExceptionNumber in FOptions;
    TIB_DDL_ExceptionList(el).AdjustCharsetAlways :=
      mcoAdjustCharsetAlways in FOptions;
  end
  else
  if el is TIB_DDL_GeneratorList then
    TIB_DDL_GeneratorList(el).ExtractGenValues :=
      mcoExtractGenValues in FOptions
  else
  if el is TIB_DDL_PermissionList then
    TIB_DDL_PermissionList(el).ShowSysdbaRights :=
      mcoShowSysdbaRights in FOptions
  else
  if el is TIB_DDL_EntListWithParams then
  begin
    if FDomainIdx > -1 then
      TIB_DDL_EntListWithParams(el)._DomainList :=
        TIB_DDL_DomainList(FListArray[FDomainIdx]);
    if FIndexIdx > -1 then
      TIB_DDL_EntListWithParams(el)._IndexList :=
        TIB_DDL_IndexList(FListArray[FIndexIdx]);
    if FTriggerIdx > -1 then
      TIB_DDL_EntListWithParams(el)._TriggerList :=
        TIB_DDL_TriggerList(FListArray[FTriggerIdx]);
  end;
  el.LoadMetadata();
  if el.NeedSecondLoad() then el.LoadMetadata2();
  if el.NeedParamLoad() then el.LoadParams();
  if el.NeedParamCheck() then el.CheckParams();
  Application.ProcessMessages
end;

procedure TIB_DDL_Extract.O( s, s2: TStrings );
const
  idxs: array [0..12] of integer = ( 0, 1, 2, 3, 4, 5, 8, 6, 9, 10, 7, 11, 12 );
var
  iter: Integer;
  el: TIB_DDL_EntityList;
  formatElist: TIB_DDL_EntityList;
begin
{for iter := 0 to High(idxs) do
  begin
    el := listArray[idxs[iter]];
    if Assigned(el)
    then el.FormatterType := mftText
  end;}
  formatElist := nil;
  for iter := 0 to High(idxs) do
  begin
    if ( iter = 11 ) and
       ( IB_Connection.Characteristics.dbODS_Version < 9 ) then
    else
    begin
      el := FListArray[idxs[iter]];
      if Assigned(el) then
      begin
        formatElist := el;
        break;
      end;
    end;
  end;
  if Assigned(formatElist) then
    with TIB_DDL_EntityListHack(formatElist).Formatter do
    begin
      s.Add( WritePreamBle( 'Metadata report' ));
      if SetIBTerminator(True) <> EmptyStr then
        s.Add( SetIBTerminator(True));
    end;
  for iter := 0 to High(idxs) do
  begin
    if TIB_DDL_Sections( idxs[iter] ) in FDDL_Sections then
    begin
      el := FListArray[idxs[iter]];
      if not Assigned(el) then continue;
      el.Write( s );
      if Assigned( s2 ) then
        el.WriteErrors(s2, True)
    end;
  end;
  if Assigned(formatElist) then
    with TIB_DDL_EntityListHack(formatElist).Formatter do
    begin
      if ResetIBTerminator(True) <> EmptyStr then
        s.Add( ResetIBTerminator(True));
      s.Add( WriteEpilog );
    end;
end;

procedure TIB_DDL_Extract.SysPrepare;
begin
  FListIdx := 0;
  FdomainIdx := -1;
  FindexIdx := -1;
  FtriggerIdx := -1;
  try
    BeginBusy( false );
    I(TIB_DDL_DatabaseList.Create(Self));   //  0 .
    I(TIB_DDL_ExceptionList.Create(Self));  //  1 .
    I(TIB_DDL_BlobFilterList.Create(Self)); //  2 .
    I(TIB_DDL_UDFList.Create(Self));        //  3 .
    I(TIB_DDL_GeneratorList.Create(Self));  //  4 .
    I(TIB_DDL_DomainList.Create(Self));     //  5 .
    I(TIB_DDL_IndexList.Create(Self));      //  6 .
    I(TIB_DDL_TriggerList.Create(Self));    //  7 .
    I(TIB_DDL_TableList.Create(Self));      //  8 .
    I(TIB_DDL_ViewList.Create(Self));       //  9 .
    I(TIB_DDL_ProcedureList.Create(Self));  // 10 .
    if IB_Connection.Characteristics.dbODS_Version >= 9 then
      I(TIB_DDL_RoleList.Create(Self));       // 11 .
    I(TIB_DDL_PermissionList.Create(Self)); // 12 .
  finally
    EndBusy;
  end;
  inherited SysPrepare;
end;

procedure TIB_DDL_Extract.SysUnprepare;
var
  iter: Integer;
begin
  for iter := 0 to 13 do
  begin
    FListArray[iter].Free;
    FListArray[iter] := nil;
  end;
  inherited SysUnprepare;
end;

procedure TIB_DDL_Extract.ExecuteStream( DDL_Stream, ERR_Stream: TStream );
var
  ss,
  s2s: TStringList;
begin
  if not Assigned( DDL_Stream ) then Exit;
  ss := TStringList.Create;
  s2s := TStringList.Create;
  try
    ExecuteStrings( ss, s2s );
    ss.SaveToStream( DDL_Stream );
    if Assigned( ERR_Stream ) then
      s2s.SaveToStream( ERR_Stream );
  finally
    ss.Free;
    s2s.Free;
  end;
end;

procedure TIB_DDL_Extract.ExecuteStrings( DDL_Strings, ERR_Strings: TStrings );
begin
  if not Prepared then
    Prepare;
  try
    DDL_Strings.BeginUpdate;
    if Assigned( ERR_Strings ) then
    begin
      ERR_Strings.BeginUpdate;
      ERR_Strings.Clear;
    end;
    DDL_Strings.Clear;
    O( DDL_Strings, ERR_Strings );
  finally
    DDL_Strings.EndUpdate;
    if Assigned( ERR_Strings ) then
      ERR_Strings.EndUpdate;
  end;
end;

procedure TIB_DDL_Extract.SetTerminatorToken(const S: String);
begin
  if Trim(S) = EmptyStr then
    FTerminatorToken := ';'
  else
    FTerminatorToken := Trim(S);
end;

end.



