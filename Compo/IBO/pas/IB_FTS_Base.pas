
{                                                                              }
{ IB_FTS_Base                                                                  }
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
  IB_FTS_Base;

interface

uses
  Windows, Messages, SysUtils, Classes,

  IB_Components,
  IB_Process;
//IB_FTS_Meta
//IB_FTS_Search
//IB_FTS_Sync

type
{: This type is used in order to indicate which type of full text search
should be perforrmed.}
TIB_FullTextSearchType = ( tstWordExact,
                           tstWordPartial,
                           tstMetaphoneExact,
                           tstMetaphonePartial,
                           tstSoundex,
                           tstSoundexMax,
                           tstSynonym,
                           tstAntonym );

{: This event is used to provide a hook so that the words being indexed can
be manipulated prior to the routine that parses them out.}
TIB_ModifySearchWords = procedure (       Sender: TObject;
                                    var   AWords: string;
                                    const Aux: string ) of object;

const
{: Provide the textual representation of the different types of searches that
can be performed at the word level.}
  SearchTypeWords: array[ TIB_FullTextSearchType ] of string = (
    'WRDE',  // WORD (EXACT)        .
    'WRDP',  // WORD (PARTIAL)      .
    'MTPE',  // METAPHONE (EXACT)   .
    'MTPP',  // METAPHONE (PARTIAL) .
    'SDXE',  // SOUNDEX             .
    'SMXE',  // SOUNDEXMAX          .
    'SYNE',  // EXACT SYNONYM       .
    'ANTE'); // EXACT ANTONYM       .

type
  TIB_FTS_Base = class( TIB_ConnectionProcess )
  private
    FBaseLoaded: boolean;
    FSearchIndexName: string;
    FOnModifySearchWords: TIB_ModifySearchWords;
  protected
    _TBL_NME: string;
    _KEY_COL: string;
    _AUX_COL: string;
    _SCH_COL: string;
    _SCH_LEN: integer;
    _WRD_LEN: integer;
    _USR_LEN: integer;
    _MIN_LEN: integer;
    _KEY_DM: string;
    _KEY_TYP: string;
    _KEY_IND: string;
    _WDS_TYP: string;
    _STATUS: string;
    _LOG: boolean;
    procedure ClearVariables;
    procedure SysMacroSubstitute(       Sender: TIB_Component;
                                  const ATextBlock: string;
                                    var ATextResult: string);
  { Property Methods }
    function GetIsMetaLoaded: boolean;
    function GetIsPopulated: boolean;
    function GetIsActivated: boolean;
    function GetIsCorrupted: boolean;
    procedure SetSearchIndexName( AValue: string ); virtual;
  { System Methods }
    procedure SysPrepare; override;
    procedure SysUnprepare; override;
    procedure ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                    AEvent: TIB_ConnectionEventType ); override;
  { Properties }
    property TBL_NME: string  read _TBL_NME;
    property KEY_COL: string  read _KEY_COL;
    property AUX_COL: string  read _AUX_COL;
    property SCH_COL: string  read _SCH_COL;
    property SCH_LEN: integer read _SCH_LEN;
    property WRD_LEN: integer read _WRD_LEN;
    property USR_LEN: integer read _USR_LEN;
    property MIN_LEN: integer read _MIN_LEN;
    property KEY_DM: string   read _KEY_DM;
    property KEY_TYP: string  read _KEY_TYP;
    property KEY_IND: string  read _KEY_IND;
    property WDS_TYP: string  read _WDS_TYP;
    property STATUS: string   read _STATUS;
    property LOG: boolean     read _LOG;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
  { Methods }
    procedure MacroSubstitute( const ATextBlock: string;
                                 var ATextResult: string ); virtual;
    procedure ResetVariables;
  { Properties }
    property BaseLoaded: boolean read FBaseLoaded;
    property IsMetaLoaded: boolean read GetIsMetaLoaded;
    property IsPopulated: boolean read GetIsPopulated;
    property IsActivated: boolean read GetIsActivated;
    property IsCorrupted: boolean read GetIsCorrupted;
    property OnModifySearchWords: TIB_ModifySearchWords
        read FOnModifySearchWords
       write FOnModifySearchWords;
  published
    property SearchIndexName: string read FSearchIndexName
                                     write SetSearchIndexName;
  end;

implementation

uses
  IB_Parse;

constructor TIB_FTS_Base.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
end;

destructor TIB_FTS_Base.Destroy;
begin
  inherited Destroy;
end;

procedure TIB_FTS_Base.ProcessConnectionEvent(
  AConnectionLink: TIB_ConnectionLink;
  AEvent: TIB_ConnectionEventType );
begin
  inherited ProcessConnectionEvent( AConnectionLink, AEvent );
  if not AConnectionLink.Connected then
    FBaseLoaded := false
  else
    case AEvent of
      cetBeforeAssignment,
      cetBeforeConnect,
      cetBeforeDisconnect: Unprepare;
      cetAfterAssignment,
      cetAfterConnect,
      cetAfterDisconnect: with IB_Connection.SchemaCache.TableNames do
        FBaseLoaded := IndexOf( 'FTS$_IND' ) >= 0;
    end;
end;

procedure TIB_FTS_Base.SetSearchIndexName( AValue: string );
var
  WasPrepared: boolean;
begin
  if FSearchIndexName <> Trim( AValue ) then
  begin
    WasPrepared := Prepared;
    Unprepare;
    FSearchIndexName := Trim( AValue );
    if WasPrepared then Prepare;
  end;
end;

procedure TIB_FTS_Base.SysPrepare;
begin
  ResetVariables;
  inherited SysPrepare;
end;

procedure TIB_FTS_Base.SysUnprepare;
begin
  ClearVariables;
  inherited SysUnprepare;
end;

procedure TIB_FTS_Base.ClearVariables;
begin
  _TBL_NME := '';
  _KEY_COL := '';
  _AUX_COL := '';
  _SCH_COL := '';
  _SCH_LEN := 0;
  _WRD_LEN := 0;
  _USR_LEN := 0;
  _MIN_LEN := 0;
  _KEY_DM  := '';
  _KEY_TYP := '';
  _KEY_IND := '';
  _WDS_TYP := '';
  _STATUS  := '';
  _LOG     := false;
end;

procedure TIB_FTS_Base.ResetVariables;
begin
  if Assigned( IB_Connection ) then
    IB_Connection.Connect
  else
    raise Exception.Create( 'No connection assigned' );
  if not IB_Connection.Connected then
    raise Exception.Create( 'No connection made' );
  if not BaseLoaded or ( SearchIndexName = '' ) then
    ClearVariables
  else
    with TIB_Cursor.Create( Self ) do
      try
        IB_Connection := Self.IB_Connection;
        SQL.Text := 'SELECT *' +
                    'FROM FTS$_IND ' +
                    'WHERE FTS$IND_NME = ' +
                    mkLitCriteria( SearchIndexName, '''' );
        First;
        if not Eof then
        begin
          _TBL_NME := FieldByName( 'FTS$TBL_NME' ).AsString;
          _KEY_COL := FieldByName( 'FTS$KEY_COL' ).AsString;
          _AUX_COL := FieldByName( 'FTS$AUX_COL' ).AsString;
          _SCH_COL := FieldByName( 'FTS$SCH_COL' ).AsString;
          _SCH_LEN := FieldByName( 'FTS$SCH_LEN' ).AsInteger;
          _WRD_LEN := FieldByName( 'FTS$WRD_LEN' ).AsInteger;
          _USR_LEN := FieldByName( 'FTS$USR_LEN' ).AsInteger;
          _MIN_LEN := FieldByName( 'FTS$MIN_LEN' ).AsInteger;
          _KEY_DM  := FieldByName( 'FTS$KEY_DM'  ).AsString;
          _KEY_TYP := FieldByName( 'FTS$KEY_TYP' ).AsString;
          _KEY_IND := FieldByName( 'FTS$KEY_IND' ).AsString;
          _WDS_TYP := FieldByName( 'FTS$WDS_TYP' ).AsString;
          _STATUS  := FieldByName( 'FTS$STATUS'  ).AsString;
          _LOG     := FieldByName( 'FTS$LOG'     ).AsBoolean;
        end
        else
          ClearVariables;
      finally
        Free;
      end;
end;

function TIB_FTS_Base.GetIsMetaLoaded: boolean;
begin
  Result := ( Status = 'IC' ) or
            ( Status = 'M'  ) or
            ( Status = 'MC' ) or IsPopulated;
end;

function TIB_FTS_Base.GetIsPopulated: boolean;
begin
  Result := ( Status = 'L' ) or ( Status = 'LC' ) or IsActivated;
end;

function TIB_FTS_Base.GetIsActivated: boolean;
begin
  Result := ( Status = 'A' ) or ( Status = 'AC' );
end;

function TIB_FTS_Base.GetIsCorrupted: boolean;
begin
  Result := Pos( 'C', Status ) > 1;
end;

procedure TIB_FTS_Base.SysMacroSubstitute(       Sender: TIB_Component;
                                           const ATextBlock: string;
                                             var ATextResult: string );
begin
  MacroSubstitute( ATextBlock, ATextResult );
end;

procedure TIB_FTS_Base.MacroSubstitute( const ATextBlock: string;
                                          var ATextResult: string );
begin
  if ATextBlock = 'IND_NME' then ATextResult := SearchIndexName else
  if ATextBlock = 'TBL_NME' then ATextResult := TBL_NME else
  if ATextBlock = 'KEY_COL' then ATextResult := KEY_COL else
  if ATextBlock = 'AUX_COL' then
  begin
    if Trim( AUX_COL ) = '' then
      ATextResult := ''''''
    else
      ATextResult := AUX_COL;
  end
  else
  if ATextBlock = 'SCH_COL' then ATextResult := SCH_COL else
  if ATextBlock = 'SCH_LEN' then ATextResult := IntToStr( SCH_LEN ) else
  if ATextBlock = 'WRD_LEN' then ATextResult := IntToStr( WRD_LEN ) else
  if ATextBlock = 'USR_LEN' then ATextResult := IntToStr( USR_LEN ) else
  if ATextBlock = 'MIN_LEN' then ATextResult := IntToStr( MIN_LEN ) else
  if ATextBlock = 'KEY_DM'  then ATextResult := KEY_DM  else
  if ATextBlock = 'KEY_TYP' then ATextResult := KEY_TYP else
  if ATextBlock = 'KEY_IND' then ATextResult := KEY_IND else
  if ATextBlock = 'WDS_TYP' then ATextResult := WDS_TYP else
  if ATextBlock = 'STATUS'  then ATextResult := STATUS  else
  if ATextBlock = 'LOG'     then
  begin
    if LOG then
      ATextResult := 'T'
    else
      ATextResult := 'F';
  end;
end;

end.
