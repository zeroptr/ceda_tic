{                                                                              }
{ IB_FTS_Search                                                                }
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
  IB_FTS_Search;

interface

uses
  Windows, Messages, SysUtils, Classes,

  IB_Constants,
  IB_Session,
  IB_Components,
  IB_Profiler,

  IB_FTS_Base;

type
{: This class is used to encapsulate the logic and processing necessary to
conduct a full text search by setting a few properties and hooking method calls
at the right time for a dataset.}
  TIB_FTS_Search = class( TIB_FTS_Base )
  private
    tSLog: TIB_Transaction;
    crSCH_CNT: TIB_Cursor;
    dSLogBefore: TIB_DSQL;
    dSLogAfter: TIB_DSQL;
    prNames: TIB_Profiler;
    FSearchWords: TIB_StringList;
    SearchTicks: DWORD;
    FSearchUserName: string;
    FSearchResultsMinCount: integer;
    StatList: TIB_StringList;
    procedure InitStatementSQL;
  protected
  { Property Methods }
    procedure SetSearchWords( AValue: TIB_StringList );
    procedure SysUnprepare; override;
    procedure ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                      AEvent: TIB_ConnectionEventType ); override;
  public
{$IFNDEF HELPSCAN}
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
{$ENDIF}
  { Methods }
{: Call this method during the OnPrepare of the dataset that is being used in
the full text search. Typically this is done in the OnPrepareSQL event of the
edit control so that it will also disable the default search buffer processing
for that control.}
    procedure PrepareSQL( ABDataset: TIB_Dataset );
{: Call this method during the BeforeExecute event of the dataset involved in
the full text search. This will mark the beginning of the search and place an
initial entry in the search log.}
    procedure BeforeExecute( ABDataset: TIB_Dataset );
{: Call this method during the AfterExecute event of the dataset involved in
the full text search. This will mark the ending of the search and update the
entry in the search log with the results and server profile data for the
search.}
    procedure AfterExecute( ABDataset: TIB_Dataset );
{: If the user is only presented a simple choice of a default search type this
is a way to plug it into the SearchWords list with the specified type added to
each word for the default formatting.}
    procedure SetSearchWordsString( var ASearchString: string;
                                        ASearchType: TIB_FullTextSearchType );
  { Properties }
{: If this property is left blank then the LoginUsername of the connection
will be used in the search log statistics that are kept for each search.
<br><br>
I usually plug in the IP address of the client when allowing searched via the
internet.}
    property SearchUserName: string read FSearchUserName write FSearchUserName;
{: List of words that are used in order define the search request.
<br><br>
Use the strings returned by the constant array SearchTypeWords to identify
which type of search for each word included is desired.
<br>
<br>
For example:<br>
MIKE=WRDP
PIZZA=WRDE
<br><br>
This will do a search based upon a partialmatch for MIKE and an exact match
for PIZZA.}
    property SearchWords: TIB_StringList read FSearchWords write SetSearchWords;
  published
{: This property will ensure that the search return up to a certain amount of
matching records as a minimum. In other words, if there are 100 matches to a
search you have the opprotunity to ensure that a certain amount of them will
be brought to the client.
<br><br>
If this value isn't at least 1 then the profiling results in the log will not
be properly representative of the work for the query since it will take place
after the query was marked completed.}
    property SearchResultsMinCount: integer read FSearchResultsMinCount
                                            write FSearchResultsMinCount
                                            default 20;
    property OnModifySearchWords;
  end;

{: This function will take a string representing one of the search types and
return the respective ordinal value.}
  function GetFullTextSearchType( AString: string ): TIB_FullTextSearchType;

implementation

uses
  IB_Parse,
  IB_Utils;

constructor TIB_FTS_Search.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  StatList := TIB_StringList.Create;
  prNames := TIB_Profiler.Create( Self );
  crSCH_CNT := TIB_Cursor.Create( Self );
  tSLog := TIB_Transaction.Create( Self );
  tSLog.AutoCommit := true;
  tSLog.Isolation := tiCommitted;
  dSLogBefore := TIB_DSQL.Create( Self );
  dSLogAfter := TIB_DSQL.Create( Self );
  dSLogAfter.IB_Transaction := tSLog;
  dSLogBefore.IB_Transaction := tSLog;
  crSCH_CNT.OnMacroSubstitute := SysMacroSubstitute;
  dSLogBefore.OnMacroSubstitute := SysMacroSubstitute;
  dSLogAfter.OnMacroSubstitute := SysMacroSubstitute;
  FSearchWords := TIB_StringList.Create;
  FSearchUserName := '';
  FSearchResultsMinCount := 20;
  InitStatementSQL;
end;

destructor TIB_FTS_Search.Destroy;
begin
  StatList.Free;
  StatList := nil;
  FSearchWords.Free;
  FSearchWords := nil;
  inherited Destroy;
end;

procedure TIB_FTS_Search.InitStatementSQL;
var
  ii: integer;
  ss, tt: string;
  tmpStr: string;
begin
  crSCH_CNT.SQL.Text := 'SELECT FTS$WRD_CNT, FTS$WRD_NEW'#13#10 +
                        'FROM FTS$<<IND_NME>>$CNT_SCH_WRD( ' +
                        ':FTS$SCH_WRD, :FTS$SCH_TYP )';
  dSLogAfter.SQL.Text :=
    'UPDATE FTS$<<IND_NME>>$SCH_LOG' + #13#10 +
    '  SET FTS$TICKS        = :FTS$TICKS'        + #13#10 +
    '    , FTS$BUFFERREADS  = :FTS$BUFFERREADS'  + #13#10 +
    '    , FTS$PAGEREADS    = :FTS$PAGEREADS'    + #13#10 +
    '    , FTS$MATCHES      = :FTS$MATCHES'      + #13#10 +
    '  WHERE FTS$SCH_KEY    = :FTS$SCH_KEY;'     + #13#10;
  ss := 'INSERT INTO FTS$<<IND_NME>>$SCH_LOG (' + #13#10 +
        '  FTS$SCH_KEY,'   + #13#10 +
        '  FTS$SCH_DATE,'  + #13#10 +
        '  FTS$USERNAME,'  + #13#10 +
        '  FTS$WORDS,'     + #13#10;
  tt := 'VALUES ('        + #13#10 +
        '  :FTS$SCH_KEY,'  + #13#10 +
        '  :FTS$SCH_DATE,' + #13#10 +
        '  :FTS$USERNAME,' + #13#10 +
        '  :FTS$WORDS,'    + #13#10;
  for ii := 1 to 10 do
  begin
    tmpStr := PadLeft( IntToStr( ii ), '0', 2, true );
    ss := ss + '  FTS$WRD_' + tmpStr + ','#13#10 +
               '  FTS$SCH_' + tmpStr + ','#13#10 +
               '  FTS$CNT_' + tmpStr + ','#13#10 +
               '  FTS$TYP_' + tmpStr;
    if ii < 10 then
      ss := ss + ','#13#10;
    tt := tt + '  :FTS$WRD_' + tmpStr + ','#13#10 +
               '  :FTS$SCH_' + tmpStr + ','#13#10 +
               '  :FTS$CNT_' + tmpStr + ','#13#10 +
               '  :FTS$TYP_' + tmpStr;
    if ii < 10 then
      tt := tt + ','#13#10;
  end;
  dSLogBefore.SQL.Text := ss + ' )'#13#10 + tt + ' )'#13#10;
end;

procedure TIB_FTS_Search.SetSearchWordsString( var ASearchString: string;
                                                   ASearchType: TIB_FullTextSearchType );
var
  ii: integer;
  tmpCh: char;
  tmpStr: string;
  tmpPos: integer;
begin
  with FSearchWords do
  begin
    BeginUpdate;
    try
      Clear;
      tmpStr := '';
      if Assigned( OnModifySearchWords ) then
        OnModifySearchWords( Self, ASearchString, ''{!!!AUX!!!} );
      ASearchString := ASearchString + ' ';
      for ii := 1 to Length( ASearchString ) do
      begin
        tmpCh := ASearchString[ ii ];
        if CharIsDelimiter( tmpCh ) then
        begin
          if tmpStr <> '' then
          begin
            if Length( tmpStr ) = 1 then
              tmpStr := tmpStr + '.';
            tmpStr := mkLitCriteria( tmpStr, '''' );
            tmpPos := LinkIndex[ tmpStr ];
            if tmpPos = -1 then
              Add( tmpStr + '=TYP=' + SearchTypeWords[ ASearchType ] )
            else
              IndexParamValue[ tmpPos,'TYP' ] := SearchTypeWords[ ASearchType ];
            tmpStr := '';
          end;
        end
        else
          tmpStr := tmpStr + tmpCh;
      end;
      ASearchString := Trim( ASearchString );
    finally
      EndUpdate;
    end;
  end;
end;

procedure TIB_FTS_Search.SetSearchWords( AValue: TIB_StringList );
begin
  FSearchWords.Assign( AValue );
end;

function GetFullTextSearchType( AString: string ): TIB_FullTextSearchType;
begin
  if Trim( AString ) = '' then Result := tstWordPartial else
  if AString = 'WRDE'     then Result := tstWordExact else
  if AString = 'EW'       then Result := tstWordExact else
  if AString = 'WRDP'     then Result := tstWordPartial else
  if AString = 'PW'       then Result := tstWordPartial else
  if AString = 'MTPE'     then Result := tstMetaphoneExact else
  if AString = 'EM'       then Result := tstMetaphoneExact else
  if AString = 'MTPP'     then Result := tstMetaphonePartial else
  if AString = 'PM'       then Result := tstMetaphonePartial else
  if AString = 'SDXE'     then Result := tstSoundex else
  if AString = 'ES'       then Result := tstSoundex else
  if AString = 'SMXE'     then Result := tstSoundexMax else
  if AString = 'PS'       then Result := tstSoundexMax else
  if AString = 'ANTE'     then Result := tstAntonym else
  if AString = 'SYNE'     then Result := tstSynonym else
    raise Exception.Create( 'Invalid FullTextSearchType string: ' + AString )
end;

procedure TIB_FTS_Search.SysUnprepare;
begin
  crSCH_CNT.Unprepare;
  dSLogBefore.Unprepare;
  dSLogAfter.Unprepare;
  tSLog.Close;
  inherited SysUnprepare;
end;

procedure TIB_FTS_Search.ProcessConnectionEvent( AConnectionLink: TIB_ConnectionLink;
                                                 AEvent: TIB_ConnectionEventType );
begin
  if AEvent = cetAfterAssignment then
  begin
    tSLog.IB_Connection := IB_Connection;
    crSCH_CNT.IB_Connection := IB_Connection;
    dSLogBefore.IB_Connection := IB_Connection;
    dSLogAfter.IB_Connection := IB_Connection;
    prNames.IB_Connection := IB_Connection;
  end;
  inherited ProcessConnectionEvent( AConnectionLink, AEvent );
end;

procedure TIB_FTS_Search.PrepareSQL( ABDataset: TIB_Dataset );
var
  ii: integer;
  tmpStr: string;
  newWRD: string;
  schWRD: string;
  tmpCNT: integer;
  tmpTYP: TIB_FullTextSearchType;
  sii: string;
  tmpIdent: string;
  tmpTBL: string;
  tmpCOL: string;
  tmpKey: string;
  tmpOp: string;
begin
  if SearchWords.Count < 1 then Exit;
  if not Assigned( ABDataset ) then
    raise Exception.Create( 'Dataset parameter must be assigned' );
  ABDataset.CheckConnection( true );
  if IB_Connection <> ABDataset.IB_Connection then
    raise Exception.Create( 'Connection must match dataset''s connection' );
  if not ABDataset.PreparingSQL then
    raise Exception.Create( 'Dataset must be in PrepareSQL phase' );
  if not Prepared then Prepare;
  with SearchWords do
  begin
    for ii := 0 to Count - 1 do
    begin
      newWRD := stLitCriteria( IndexNames[ ii ] );
      tmpTYP := GetFullTextSearchType( IndexParamValue[ ii, 'TYP' ] );
      schWRD := Trim( newWRD );
      parse_word_proc( schWRD );
      if Trim( schWRD ) <> '' then
      begin
        if tmpTYP = tstWordExact then
          schWRD := PadRight( schWRD, '.', MIN_LEN, false );
        newWRD := mkLitCriteria( schWRD, '''' );
        case tmpTYP of
          tstMetaPhoneExact,
          tstMetaPhonePartial:
            schWRD := MetaPh( schWRD, 30 );
          tstSoundex:
            schWRD := ABDataset.IB_Connection.GetSoundex( schWRD );
          tstSoundexMax:
            schWRD := ABDataset.IB_Connection.GetSoundexMax( schWRD );
        end;
        tmpCNT := 0;
        crSCH_CNT.Prepare;
        crSCH_CNT.Params[0].AsString := schWRD;
        crSCH_CNT.Params[1].AsString := SearchTypeWords[ tmpTYP ];
        crSCH_CNT.First;
        try
          if not crSCH_CNT.Eof then
          begin
            tmpCNT := crSCH_CNT.Fields[0].AsInteger;
            if not crSCH_CNT.Fields[1].IsNull then
              schWRD := crSCH_CNT.Fields[1].AsString;
          end;
        finally
          crSCH_CNT.Close;
        end;
        if schWRD = '' then
          tmpCNT := -1
        else
          schWRD := mkLitCriteria( schWRD, '''' );
      end
      else
      begin
        newWRD := '';
        schWRD := '';
        tmpCNT := -1;
      end;
      IndexParamValue[ ii, 'WRD' ] := newWRD;  // Word stats are based on.
      IndexParamValue[ ii, 'SCH' ] := schWRD;  // Value to be searched on.
      IndexParamValue[ ii, 'CNT' ] := IntToStr( tmpCNT );  // Count stats.
    end;
  end;
  tmpTBL := 'FTS$' + SearchIndexName + '$WRD';
  with StatList do
  begin
    Assign( SearchWords );
    for ii := Count - 1 downto 0 do
      if IndexParamValue[ ii, 'SCH' ] = '' then
        Delete( ii );
    ParamQuickSort( 'CNT', true );
    for ii := 0 to Count - 1 do
    begin
      case GetFullTextSearchType( IndexParamValue[ ii, 'TYP' ] ) of
        tstWordExact,
        tstMetaphoneExact,
        tstAntonym,
        tstSynonym,
        tstSoundex,
        tstSoundexMax: tmpOp := ' = ';
        tstWordPartial,
        tstMetaphonePartial: tmpOp := ' STARTING ';
      end;
      sii := IntToStr( ii );
      tmpTYP := GetFullTextSearchType( IndexParamValue[ ii, 'TYP' ] );
      tmpIdent := Copy( SearchTypeWords[ tmpTYP ], 1, 3 );
      tmpCol := tmpTBL + sii + '.' + 'FTS$' + tmpIdent;
      tmpKey := tmpTBL + sii + '.' + 'FTS$' + KEY_COL;
      schWRD := IndexParamValue[ ii, 'SCH' ];
      with ABDataset.SQLFrom do
      begin
        Add( 'JOIN ' + tmpTBL + ' ' + tmpTBL + sii );
        Add( '  ON ' + tmpCol + tmpOp + schWRD );
        Add( ' AND ' + tmpKey + ' = ' + TBL_NME + '.' + KEY_COL );
      end;
    end;
    tmpStr := 'PLAN JOIN ('#13#10'  ' + tmpTBL + '0 INDEX ( ' +
              'FTS$' + SearchIndexName + '$' + tmpIdent + ' ),'#13#10'  ' +
              TBL_NME + ' INDEX ( ' + KEY_IND + ' )';
    for ii := Count - 1 downto 1 do
    begin
      sii := IntToStr( ii );
      tmpTYP := GetFullTextSearchType( IndexParamValue[ ii, 'TYP' ] );
      tmpIdent := Copy( SearchTypeWords[ tmpTYP ], 1, 3 );
      tmpStr := tmpStr + ','#13#10'  ' + tmpTBL + sii + ' INDEX ( ' +
                         'FTS$' + SearchIndexName + '$KEY_' + tmpIdent + ' )';
    end;
    tmpsTR := tmpsTR + ' )';
    ABDataset.SQLPlan.Text := tmpsTR;
  end;
end;

procedure TIB_FTS_Search.BeforeExecute( ABDataset: TIB_Dataset );
var
  ii: integer;
  ss: string;
begin
  if not Assigned( ABDataset ) then
    raise Exception.Create( 'Dataset parameter must be assigned' );
  ABDataset.CheckConnection( true );
  if IB_Connection <> ABDataset.IB_Connection then
    raise Exception.Create( 'Connection must match dataset''s connection' );
  if not Prepared then Prepare;
  ss := SearchUserName;
  if ss = '' then
    ss := ABDataset.IB_Connection.LoginUsername;
  with dSLogBefore do
  begin
    ParamByName( 'FTS$SCH_DATE' ).AsString := 'NOW';
    ParamByName( 'FTS$USERNAME' ).AsString := ss;
    ss := '';
    for ii := 0 to SearchWords.Count - 1 do
      ss := ss + stLitCriteria( SearchWords.IndexNames[ ii ] ) + ' ';
    ParamByName( 'FTS$WORDS' ).AsString := Trim( ss );
    ParamByName( 'FTS$SCH_KEY' ).AsExtended := Gen_ID( 'FTS$SCH_KEY',1 );
    dSLogAfter.ParamByName( 'FTS$SCH_KEY' ).Assign(
      ParamByName( 'FTS$SCH_KEY' ));
    for ii := 1 to 10 do
    begin
      ss := PadLeft( IntToStr( ii ), '0', 2, false );
      if StatList.Count >= ii then
      begin
        with ParamByName( 'FTS$WRD_' + ss ) do
          AsString := stLitCriteria( StatList.IndexParamValue[ii - 1, 'WRD'] );
        with ParamByName( 'FTS$SCH_' + ss ) do
          AsString := stLitCriteria( StatList.IndexParamValue[ii - 1, 'SCH'] );
        with ParamByName( 'FTS$CNT_' + ss ) do
          AsString := StatList.IndexParamValue[ ii - 1, 'CNT' ];
        with ParamByName( 'FTS$TYP_' + ss ) do
          AsString := StatList.IndexParamValue[ ii - 1, 'TYP' ];
      end
      else
      begin
        ParamByName( 'FTS$WRD_' + ss ).AsString := '';
        ParamByName( 'FTS$SCH_' + ss ).AsString := '';
        ParamByName( 'FTS$CNT_' + ss ).Clear;
        ParamByName( 'FTS$CNT_' + ss ).Clear;
      end;
    end;
    ExecSQL;
  end;
  prNames.Mark;
  SearchTicks := GetTickCount;
end;

procedure TIB_FTS_Search.AfterExecute( ABDataset: TIB_Dataset );
var
  tmpTicks: integer;
begin
  if not Assigned( ABDataset ) then
    raise Exception.Create( 'Dataset parameter must be assigned' );
  ABDataset.CheckConnection( true );
  if IB_Connection <> ABDataset.IB_Connection then
    raise Exception.Create( 'Connection must match dataset''s connection' );
  if not Prepared then Prepare;
  ABDataset.ValidateRows( 1, SearchResultsMinCount );
  tmpTicks := GetTickCount - SearchTicks;
  with prNames do
  begin
    Grab;
    with dSLogAfter do
    begin
      ParamByName( 'FTS$TICKS'        ).AsInteger := tmpTicks;
      ParamByName( 'FTS$MATCHES'      ).AsInteger := ABDataset.BufferRowCount;
      ParamByName( 'FTS$BUFFERREADS'  ).AsInteger := BufferReadsDelta;
      ParamByName( 'FTS$PAGEREADS'    ).AsInteger := PageReadsDelta;
      ExecSQL;
    end;
  end;
end;

end.


