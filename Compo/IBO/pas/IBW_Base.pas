
{                                                                              }
{ IBW_Base                                                                     }
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
  IBW_Base;

interface

uses
  Windows, Messages, SysUtils, Classes,

  HTTPApp,

{$IFDEF IBO_VCL60_OR_GREATER}
  HTTPProd,
{$ENDIF}

  IB_Session,
  IB_Components, IB_Monitor;

type
  TWebObject = class( TObject )
  private
    FCaption: string;
    FItemLabel: string;
    FVarName: string;
    FVarValue: string;
    function GetCaption: string; virtual;
    function GetVarValue: string; virtual;
    procedure SetVarValue( AValue: string ); virtual;
  public
    constructor Create( AVarName: string ); 
    property Caption: string read GetCaption write FCaption;
    property ItemLabel: string read FItemLabel write FItemLabel;
    property VarName: string read FVarName;
    property VarValue: string read GetVarValue write SetVarValue;
  end;

  TwmBase = class;
  TWebInputItem = class;
  TWebOutputItem = class;
  TWebInputGroup = class;
  TWebOutputGroup = class;

  TWebOutputItemCustomHTML = procedure (     Sender: TWebOutputItem;
                                         var ResultText: string ) of object;
  TWebInputItem = class( TWebObject )
  private
    FWebGroup: TWebInputGroup;
    FControlClass: string;
    FFieldName: string;
    FPickListData: string;
    FPickListSeparator: string;
    FSearchClass: string;
    FStartNewRow: boolean;
  public
    constructor Create( AVarName: string; AWebInputGroup: TWebInputGroup );
    destructor Destroy; override;
    property ControlClass: string read FControlClass write FControlClass;
    property FieldName: string read FFieldName write FFieldName;
    property Group: TWebInputGroup read FWebGroup;
    property PickListData: string read FPickListData write FPickListData;
    property PickListSeparator: string read FPickListSeparator
                                       write FPickListSeparator;
    property SearchClass: string read FSearchClass write FSearchClass;
    property StartNewRow: boolean read FStartNewRow write FStartNewRow;
  end;

  TWebInputGroup = class( TWebObject )
  private
    FWebForm: TwmBase;
    FWebInputItems: TList;
    FTableTags: string;
    FSearchOutputGroups: string;
    function GeTWebInputItem( AIndex: integer ): TWebInputItem;
    function GetWebInputItemCount: integer;
  public
    constructor Create( AVarName: string );
    destructor Destroy; override;
    function AddWebInputItem( AVarName: string ): TWebInputItem;
    property TableTags: string read FTableTags write FTableTags;
    property WebForm: TwmBase read FWebForm;
    property WebInputItems[Index: integer]: TWebInputItem read GetWebInputItem;
    property WebInputItemCount: integer read GetWebInputItemCount;
    property SearchOutputGroups: string read FSearchOutputGroups
                                        write FSearchOutputGroups;
  end;

  TWebOutputItem = class( TWebObject )
  private
    FWebGroup: TWebOutputGroup;
    FOutputQuery: TIB_Cursor;
    FEofMessage: string;
    FTableTags: string;
    FSingleRecord: boolean;
    FCustomLinkItems: TIB_StringList;
    FOnCustomHTML: TWebOutputItemCustomHTML;
  protected
    property Group: TWebOutputGroup read FWebGroup;
  public
    constructor Create( AVarName: string; AWebOutputGroup: TWebOutputGroup ); 
    destructor Destroy; override;
    function FormatItemCell(       ARow, ACol: integer;
                                   CellData: string;
                             const Tag: string;
                                   BgColor: THTMLBgColor;
                                   Align: THTMLAlign;
                                   VAlign: THTMLVAlign;
                                   Custom: string ): string;
    function GetOutputHTML: string;
    property OutputQuery: TIB_Cursor read FOutputQuery;
    property EofMessage: string read FEofMessage write FEofMessage;
    property TableTags: string read FTableTags write FTableTags;
    property SingleRecord: boolean read FSingleRecord write FSingleRecord;
    property CustomLinkItems: TIB_StringList read FCustomLinkItems;
    property OnCustomHTML: TWebOutputItemCustomHTML read FOnCustomHTML
                                                    write FOnCustomHTML;
  end;

  TWebOutputGroup = class( TWebObject )
  private
    FWebForm: TwmBase;
    FWebOutputItems: TList;
    FFieldName: string;
    FSearchMode: boolean;
    function GetWebOutputItem( AIndex: integer ): TWebOutputItem;
    function GetWebOutputItemCount: integer;
  public
    constructor Create( AVarName: string; ASearchMode: boolean );
    destructor Destroy; override;
    function AddWebOutputItem( AVarName: string ): TWebOutputItem;
    function GetOutputHTML: string;
    property WebForm: TwmBase read FWebForm;
    property FieldName: string read FFieldName write FFieldName;
    property WebOutputItems[Index: integer]: TWebOutputItem
      read GetWebOutputItem;
    property WebOutputItemCount: integer read GetWebOutputItemCount;
    property SearchMode: boolean read FSearchMode;
  end;

  TwmBase = class(TWebModule)
    se: TIB_Session;
    mn: TIB_Monitor;
    ppHdr: TPageProducer;
    ppFtr: TPageProducer;
    cn: TIB_Connection;
    tr: TIB_Transaction;
    procedure wmAfterDispatch(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmBeforeDispatch(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure wmCreate(Sender: TObject);
    procedure wmDestroy(Sender: TObject);
    procedure mnMonitorOutputItem(Sender: TObject;
      const NewString: String);
    procedure cnNMEError(Sender: TObject; const ERRCODE: Integer;
      ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer;
      SQLMessage, SQL: TStringList; var RaiseException: Boolean);
    procedure ProcessHTMLTag(       Sender: TObject;
                                    Tag: TTag;
                              const TagString: String;
                                    TagParams: TStrings;
                                var ReplaceText: String );
  private
    FWebInputItems: TList;
    FWebOutputItems: TList;
    FWebInputGroups: TList;
    FWebOutputGroups: TList;
    FSearchFormProducer: TPageProducer;
    FtmpProducer: TPageProducer;
    FSearchFormTableTags: string;
    FDefaultTableTags: string;
  protected
    procedure FormatCell(     AWOI: TWebOutputItem;
                              CellRow, CellColumn: Integer;
                          var BgColor: THTMLBgColor;
                          var Align: THTMLAlign;
                          var VAlign: THTMLVAlign;
                          var CustomAttrs, CellData: String );
    function GetWebInputGroup( AIndex: integer ): TWebInputGroup;
    function GetWebInputItem( AIndex: integer ): TWebInputItem;
    function GetWebOutputGroup( AIndex: integer ): TWebOutputGroup;
    function GetWebOutputItem( AIndex: integer ): TWebOutputItem;
    function GetWebInputGroupCount: integer;
    function GetWebInputItemCount: integer;
    function GetWebOutputGroupCount: integer;
    function GetWebOutputItemCount: integer;
    procedure SearchQueryPrepareSQL( AStatement: TIB_Statement );
    procedure ValidateWebItems;
    procedure InitializeFromData( AWebAppName: string );
  public
    constructor Create( AObject: TComponent ); override;
    destructor Destroy; override;
    function AddWebInputGroup( AVarName: string ): TWebInputGroup;
    function AddWebOutputGroup( AVarName: string;
                                ASearchMode: boolean ): TWebOutputGroup;
    procedure SetWebItemValues( ASource: TStrings; Erase: boolean );
    function WebInputItemByName( AVarName: string ): TWebInputItem;
    function WebInputItemByFieldName( AVarName: string ): TWebInputItem;
    function WebOutputGroupByName( AVarName: string ): TWebOutputGroup;
    function WebOutputGroupByFieldName( AVarName: string ): TWebOutputGroup;
    function GetSearchResultCaption: string;
    function GetSearchInputHTML: string;
    property SearchFormProducer: TPageProducer read FSearchFormProducer;
    property SearchFormTableTags: string read FSearchFormTableTags
                                         write FSearchFormTableTags;
    property WebInputGroups[Index: integer]: TWebInputGroup
      read GetWebInputGroup;
    property WebInputItems[Index: integer]: TWebInputItem
      read GetWebInputItem;
    property WebOutputGroups[Index: integer]: TWebOutputGroup
      read GetWebOutputGroup;
    property WebOutputItems[Index: integer]: TWebOutputItem
      read GetWebOutputItem;
    property WebInputGroupCount: integer read GetWebInputGroupCount;
    property WebInputItemCount: integer read GetWebInputItemCount;
    property WebOutputGroupCount: integer read GetWebOutputGroupCount;
    property WebOutputItemCount: integer read GetWebOutputItemCount;
  private
    { Private declarations }
    function GetScriptExt: string;
  protected
    ErrMsgs: TStringList;
    MonitorStrings: TIB_StringList;
    ScriptFile: string;
    ScriptName: string;
    ScriptVersion: string;
    procedure DoBeforeDispatch(     Sender: TObject;
                                    Request: TWebRequest;
                                    Response: TWebResponse;
                                var Handled: Boolean ); virtual;
    procedure DoAfterDispatch(     Sender: TObject;
                                   Request: TWebRequest;
                                   Response: TWebResponse;
                               var Handled: Boolean ); virtual;
    procedure DoInitializeModule; virtual;
    procedure DoFinalizeModule; virtual;
    property ScriptExt: string read GetScriptExt;
    function GetErrMsgsAsHTML: string;
  public
    { Public declarations }
    procedure AddErrorMsg( const AMsg: string );
    procedure GetSpaceText( var Text: string; DisplayText: Boolean );
    procedure GetBlankText( var Text: string; DisplayText: Boolean );
    procedure GetSizedText( var Text: string; DisplayText: Boolean );
    procedure GetTagString(       Sender: TObject;
                                  Tag: TTag;
                            const TagString: string;
                                  TagParams: TStrings;
                            var   ReplaceText: string );
  end;

  const

  // Control classes
    WEBCC_PICKEDIT = 'PICKEDIT';
    WEBCC_PICKLIST = 'PICKLIST';
    WEBCC_DT_RNG_BEG = 'DATE_RNG_BEG';
    WEBCC_DT_RNG_END = 'DATE_RNG_END';

  // Search Classes
    WEBSC_EXACT = 'EXACT';
    WEBSC_LIKE = 'LIKE';
    WEBSC_CONT = 'CONT';

  procedure IB_DumpRecord(       ADS: TIB_Dataset;
                           const ACaption,
                                 AEofMessage,
                                 ATblTags: string;
                             var ARetVal: string );

implementation

{$R *.DFM}

uses
  Forms,

  IB_Parse, IB_Utils;

procedure IB_DumpRecord(       ADS: TIB_Dataset;
                         const ACaption,
                               AEofMessage,
                               ATblTags: string;
                           var ARetVal: string );
var
  ii: integer;
begin
  with ADS do
  begin
    ARetVal := ARetVal + '<table ' + ATblTags + '>';
    if ACaption <> '' then
      ARetVal := ARetVal + '<caption>' + ACaption + '</caption>';
      
    if Eof then
      ARetVal := ARetVal + '<tr><td>' + AEofMessage + '</td></tr></table>'
    else
    begin
      for ii := 0 to FieldCount - 1 do
        with Fields[ ii] do
        begin
          if Visible and ( Trim( AsString ) <> '' ) then
          begin
            ARetVal := ARetVal + '<tr><th>' + DisplayName + '</th>';
            if IsBlob then
              ARetVal := ARetVal + '<td>' + AsString + '</td></tr>'#13#10
            else
              ARetVal := ARetVal + '<td>' + DisplayText + '</td></tr>'#13#10;
          end;
        end;
    end;
    ARetVal := ARetVal + '</table>';
  end;
end;

procedure TwmBase.AddErrorMsg( const AMsg: string );
begin
  ErrMsgs.Add( AMsg );
end;

procedure TwmBase.DoBeforeDispatch(     Sender: TObject;
                                        Request: TWebRequest;
                                        Response: TWebResponse;
                                    var Handled: Boolean );
begin
// Abstract
end;

procedure TwmBase.DoAfterDispatch(     Sender: TObject;
                                       Request: TWebRequest;
                                       Response: TWebResponse;
                                   var Handled: Boolean );
begin
// Abstract
end;

function ModuleName: string;
var
  FileName : array[0..MAX_PATH] of char;
begin
  FillChar( FileName, SizeOf( FileName ), #0 );
  GetModuleFileName( HInstance, FileName, SizeOf( FileName ));
  Result := FileName;
end;

procedure TwmBase.wmCreate(Sender: TObject);
var
  tmpS: string;
begin
  ErrMsgs := TStringList.Create;
  MonitorStrings := TIB_StringList.Create;
  tmpS := ChangeFileExt( ExtractFilename( ModuleName ), '' );
  ScriptFile := '/scripts/' + tmpS;
  replace_string( tmpS,'_', ' ' );
  ScriptName := tmpS;
  ScriptVersion := 'Script Version Here';
  mn.Enabled := not IsLibrary;
  DoInitializeModule;
end;

procedure TwmBase.wmDestroy(Sender: TObject);
begin
  DoFinalizeModule;
  ErrMsgs.Free;
  MonitorStrings.Free;
  ErrMsgs := nil;
  MonitorStrings := nil;
end;

procedure TwmBase.DoInitializeModule;
begin
// Virtual to be overridden.
end;

procedure TwmBase.DoFinalizeModule;
begin
// Virtual to be overridden.
end;

procedure TwmBase.wmBeforeDispatch(     Sender: TObject;
                                        Request: TWebRequest;
                                        Response: TWebResponse;
                                    var Handled: Boolean );
var
  ii: integer;
  tmpPathInfo: string;
  tmpWI: TWebInputItem;
  tmpWO: TWebOutputGroup;
  SuppressSearchForm: boolean;
begin
  ErrMsgs.Clear;
// Check for a failed connection and clear it out.
  for ii := 0 to se.Session_Connections.Count - 1 do
    with TIB_Connection( se.Session_Connections[ ii ] ) do
      if not VerifyConnection then
        Disconnect;

  if WebInputGroupCount + WebOutputGroupCount > 0 then
  begin 
  Response.Content := ppHdr.Content;
  try
  SuppressSearchForm := false;
  if Request.QueryFields.Count > 0 then
    SetWebItemValues( Request.QueryFields, true )
  else
    SetWebItemValues( Request.ContentFields, true );

  tmpPathInfo := Request.PathInfo;
  if ( Length( tmpPathInfo ) > 0 ) and ( tmpPathInfo[1] = '/' ) then
    System.Delete( tmpPathInfo, 1, 1 );

  if tmpPathInfo = '__SearchList' then
  begin
    tmpWI := nil;
    tmpWO := nil;
    try
      ValidateWebItems;
      if ErrMsgs.Count = 0 then
      begin
        SuppressSearchForm := true;
        for ii := 0 to WebOutputGroupCount - 1 do
        begin
          tmpWO := WebOutputGroups[ ii ];
          tmpWI := WebInputItemByFieldName( tmpWO.FieldName );
          if Assigned( tmpWI ) and ( tmpWI.VarValue <> '' ) then
            Break
          else
            tmpWI := nil;
        end;
        if not Assigned( tmpWI ) then
          tmpWO := nil;
        if not Assigned( tmpWO ) then
        begin
          for ii := 0 to WebInputItemCount - 1 do
          begin
            tmpWI := WebInputItems[ ii ];
            if ( tmpWI.VarValue <> '' ) then
            begin
              tmpWO := WebOutputGroupByName( tmpWI.Group.SearchOutputGroups );
              if Assigned( tmpWO ) then
                Break;
            end;
          end;
        end;
        if Assigned( tmpWO ) then
          Response.Content := Response.Content + tmpWO.GetOutputHTML
        else
          ErrMsgs.Add( 'Unable to locate module to process search request.' );
      end;
    except
      on E: Exception do
      begin
        ErrMsgs.Add( 'Error producing content:' );
        ErrMsgs.Add( E.Message );
        ErrMsgs.Add( #13#10'Please try your search again in a few minutes.' );
        if Assigned( tmpWO ) and
           Assigned( tmpWO.WebOutputItems[ 0 ] ) and
           Assigned( tmpWO.WebOutputItems[ 0 ].OutputQuery.IB_Connection ) then
          tmpWO.WebOutputItems[ 0 ].OutputQuery.IB_Connection.ForceDisconnect;
      end;
    end;
    if ErrMsgs.Count > 0 then
    begin
      if SuppressSearchForm then
      begin
        Response.Content := Response.Content +
                            '<font face="Arial" size=2 color=red><b>';
        Response.Content := Response.Content + 'Errors:<br>';
        for ii := 0 to ErrMsgs.Count - 1 do
          Response.Content := Response.Content + ErrMsgs.Strings[ ii ] + '<br>';
        Response.Content := Response.Content + '</b></font>';
      end
      else
      begin
        SearchFormProducer.HTMLDoc.Text := GetSearchInputHTML;
        Response.Content := Response.Content + SearchFormProducer.Content;
      end;
    end;
  end
  else
  begin
    tmpWO := WebOutputGroupByName( tmpPathInfo );
    if Assigned( tmpWO ) then
    begin
      Response.Content := Response.Content + tmpWO.GetOutputHTML;
      if ErrMsgs.Count > 0 then
      begin
        Response.Content := Response.Content +
                            '<font face="Arial" size=2 color=red><b>';
        Response.Content := Response.Content + 'Errors:<br>';
        for ii := 0 to ErrMsgs.Count - 1 do
          Response.Content := Response.Content + ErrMsgs.Strings[ ii ] + '<br>';
        Response.Content := Response.Content + '</b></font>';
      end;
    end
    else
    begin
      if tmpPathInfo <> '' then
        Response.Content := Response.Content + 'tmpPathInfo: ' +
                                               tmpPathInfo + '<br>';
      SearchFormProducer.HTMLDoc.Text := GetSearchInputHTML;
      Response.Content := Response.Content + SearchFormProducer.Content;
    end;
  end;
  finally
    Response.Content := Response.Content + ppFtr.Content;
  end;
  Handled := true;
  end;

  DoBeforeDispatch( Sender, Request, Response, Handled );
end;

procedure TwmBase.wmAfterDispatch(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  ii: integer;
begin
  try
    DoAfterDispatch( Sender, Request, Response, Handled );
  finally
    ErrMsgs.Clear;
// Force all transactions to end between session hits.
    for ii := 0 to se.Session_Transactions.Count - 1 do
      TIB_Transaction( se.Session_Transactions[ ii ] ).Close;
  end;
  MonitorStrings.Clear;
end;

procedure TwmBase.mnMonitorOutputItem(Sender: TObject;
  const NewString: String);
var
  tmpStr: string;
begin
  if Assigned( MonitorStrings ) then
  begin
    tmpStr := NewString;
    if ( mn.Ticks > 250 ) then
      tmpStr := #13#10'<font color=RED>'#13#10 + tmpStr +
                #13#10'</font>'#13#10;
    MonitorStrings.Text := MonitorStrings.Text + Trim( tmpStr ) + #13#10;
  end;
end;

procedure TwmBase.GetTagString(       Sender: TObject;
                                      Tag: TTag;
                                const TagString: String;
                                      TagParams: TStrings;
                                var   ReplaceText: String );
var
  ii: integer;
begin
  if CompareText( TagString, 'ERRMSG' ) = 0 then
    ReplaceText := GetErrMsgsAsHTML
  else
  if CompareText( TagString, 'SCRIPTFILE' ) = 0 then
    ReplaceText := ScriptFile
  else
  if CompareText( TagString, 'SCRIPTNAME' ) = 0 then
    ReplaceText := ScriptName
  else
  if CompareText( TagString, 'SCRIPTVERSION' ) = 0 then
    ReplaceText := ScriptVersion
  else
  if CompareText( TagString, 'SCRIPTEXT' ) = 0 then
    ReplaceText := GetScriptExt
  else
  if CompareText( TagString, 'DATEFMT' ) = 0 then
    ReplaceText := ShortDateFormat
  else
  if CompareText( TagString, 'MONSTR' ) = 0 then
  begin
    if not mn.Enabled then Exit;
//    if Pos( '65.106.117.', Request.RemoteAddr ) +
//       Pos( '159.87.34.',  Request.RemoteAddr ) = 0 then Exit;
    ReplaceText := ReplaceText + '<br>IP:' + Request.RemoteAddr + '<br>';
    if Request.QueryFields.Count > 0 then
    begin
      ReplaceText := ReplaceText +
                     '<p align=left>' +
                     '<LEFT><br><br>QueryFields</LEFT>' +
                     '<br><br>'#13#10'<LEFT><font face=Courier>';
      for ii := 0 to Request.QueryFields.Count - 1 do
        ReplaceText := ReplaceText + #10#13'<br>' + Request.QueryFields[ii];
      ReplaceText := ReplaceText +
                     #13#10'</LEFT></font>' +
                     '<LEFT><br><br>End QueryFields<br><br></LEFT></P>';
    end;
    if Request.ContentFields.Count > 0 then
    begin
      ReplaceText := ReplaceText +
                     '<p align=left>' +
                     '<LEFT><br><br>ContentFields</LEFT>' +
                     '<br><br>'#13#10'<LEFT><font face=Courier>';
      for ii := 0 to Request.ContentFields.Count - 1 do
        ReplaceText := ReplaceText + #10#13'<br>' + Request.ContentFields[ii];
      ReplaceText := ReplaceText +
                     #13#10'</LEFT></font>' +
                     '<LEFT><br><br>End ContentFields<br><br></LEFT></P>';
    end;
    if MonitorStrings.Count > 0 then
    begin
      ReplaceText := ReplaceText +
                     '<p align=left>' +
                     '<LEFT><br><br>Start Monitor</LEFT>' +
                     '<br><br>'#13#10'<LEFT><font face=Courier>';
      for ii := 0 to MonitorStrings.Count - 1 do
        ReplaceText := ReplaceText + #10#13'<br>' + MonitorStrings[ii];
      ReplaceText := ReplaceText +
                     #13#10'</LEFT></font>' +
                     '<LEFT><br><br>End Monitor<br><br></LEFT></P>';
    end;
  end;
end;

function TwmBase.GetErrMsgsAsHTML: string;
var
  ii: integer;
begin
  Result := '';
  if ErrMsgs.Count > 0 then
  begin
    Result := Result + 'Errors:<br>';
    for ii := 0 to ErrMsgs.Count - 1 do
      Result := Result + ErrMsgs.Strings[ ii ] + '<br>';
  end;
end;

function TwmBase.GetScriptExt: string;
begin
  if IsLibrary then Result := 'dll' else Result := 'cgi';
end;

procedure TwmBase.cnNMEError(Sender: TObject; const ERRCODE: Integer;
  ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer;
  SQLMessage, SQL: TStringList; var RaiseException: Boolean);
begin
  ErrMsgs.AddStrings( ErrorMessage );
end;

procedure TwmBase.GetSpaceText( var Text: String; DisplayText: Boolean );
begin
  Text := Trim( Text );
  replace_string( Text, ' ', '%20' );
end;

procedure TwmBase.GetBlankText( var Text: String; DisplayText: Boolean );
begin
  if Text = '' then Text := '&nbsp';
end;

procedure TwmBase.GetSizedText( var Text: String; DisplayText: Boolean );
begin
  if Length( Text ) >= 20 then Text := '<font size=-1>' + Text + '</font>';
  if Length( Text ) >= 60 then Text := '<font size=-1>' + Text + '</font>';
  if Length( Text ) >= 90 then Text := '<font size=-1>' + Text + '</font>';
end;

{ TWebObject }

constructor TWebObject.Create( AVarName: string );
begin
  FVarName := AVarName;
  inherited Create;
end;

function TWebObject.GetCaption: string;
begin
  Result := FCaption;
  if Result = '' then
    Result := ItemLabel;
end;

function TWebObject.GetVarValue: string;
begin
  Result := FVarValue;
end;

procedure TWebObject.SetVarValue( AValue: string );
begin
  FVarValue := AValue;
end;

{ TWebInputItem }

constructor TWebInputItem.Create( AVarName: string;
                                  AWebInputGroup: TWebInputGroup );
begin
  FWebGroup := AWebInputGroup;
  inherited Create( AVarName );
  FPickListSeparator := ';';
  FStartNewRow := true;
end;

destructor TWebInputItem.Destroy;
begin
  FWebGroup.FWebInputItems.Remove( Self );
  FWebGroup.FWebForm.FWebInputItems.Remove( Self );
  inherited Destroy;
end;

{ TWebOutputItem }

constructor TWebOutputItem.Create( AVarName: string;
                                   AWebOutputGroup: TWebOutputGroup );

begin
  FWebGroup := AWebOutputGroup;
  inherited Create( AVarName );
  FCustomLinkItems := TIB_StringList.Create;
  FOutputQuery := TIB_Cursor.Create( FWebGroup.FWebForm );
  if Group.SearchMode then
    FOutputQuery.OnPrepareSQL := Group.WebForm.SearchQueryPrepareSQL;
end;

destructor TWebOutputItem.Destroy;
begin
  FWebGroup.FWebOutputItems.Remove( Self );
  FWebGroup.FWebForm.FWebOutputItems.Remove( Self );
  inherited Destroy;
  FOutputQuery.Free;
  FOutputQuery := nil;
  FCustomLinkItems.Free;
  FCustomLinkItems := nil;
end;

function TWebOutputItem.FormatItemCell(       ARow, ACol: integer;
                                              CellData: string;
                                        const Tag: string;
                                              BgColor: THTMLBgColor;
                                              Align: THTMLAlign;
                                              VAlign: THTMLVAlign;
                                              Custom: string ): string;
var
  CellAlign: THTMLAlign;
  CellVAlign: THTMLVAlign;
  CellBg: THTMLBgColor;
  CustomAttrs: string;
begin
  Result := Format('<%s', [Tag]);
  CellBg := BgColor;
  CellAlign := Align;
  CellVAlign := VAlign;
  CustomAttrs := Custom;
  Group.WebForm.FormatCell( Self, ARow, ACol, BgColor, Align, VAlign,
                                                             Custom, CellData );
  Result := Result + HTMLAlign[CellAlign];
  Result := Result + HTMLVAlign[CellVAlign];
  if CellBg <> '' then
    Result := Format('%s BgColor="%s"', [Result, CellBg]);
  if CustomAttrs <> '' then
    Result := Format('%s %s', [Result, CustomAttrs]);
  Result := Result + Format('>%s</%s>', [CellData, Tag]);
end;

function TWebOutputItem.GetOutputHTML: string;
  function GetEofMsg: string;
  begin
                              Result := '<tr><td>';
    if EofMessage <> '' then Result := Result + EofMessage
                        else Result := Result + 'End Of File';
                             Result := Result + '</td></tr></table>';
  end;
var
  ii: integer;
  bk: string;
  wa: boolean;
  tmpB: THTMLBgColor;
  tmpA, tmpC: string;
  tmpAl: THTMLAlign;
  tmpVAl: THTMLVAlign;
begin
  Result := '';
  if Assigned( OnCustomHTML ) then
    OnCustomHTML( Self, Result )
  else
  with OutputQuery do
  begin
    wa := Active;
    try
    if not wa then Open;
    bk := Bookmark;
    Result := Result + #13#10'<table ' + TableTags + '>'#13#10;
    if Group.SearchMode then
      tmpC := '<br>' + Group.WebForm.GetSearchResultCaption
    else
      tmpC := '';
    if Caption <> '' then
      Result := Result + '<caption>' + Caption + tmpC + '</caption>'#13#10;
    if Eof then
      Result := Result + GetEofMsg
    else
    begin
      if SingleRecord then
      begin
        for ii := 0 to FieldCount - 1 do
          with Fields[ ii] do
          begin
            if Visible then
            begin
              Result := Result + '<tr>';
              tmpAl := haCenter;
              tmpVAl := haVDefault;
              tmpB := '';
              Result := Result + FormatItemCell( 0, ii, DisplayLabel, 'TH',
                                                 tmpB, tmpAl, tmpVAl, tmpA );
              case Alignment of
                taLeftJustify: tmpAl := haLeft;
                taRightJustify: tmpAl := haRight;
                taCenter: tmpAl := haCenter;
              end;
              tmpVAl := haVDefault;
              tmpB := '';
              if IsBlob then
                Result := Result + FormatItemCell( 1, ii, AsString, 'TD',
                                                   tmpB, tmpAl, tmpVAl, tmpA )
              else
                Result := Result + FormatItemCell( 1, ii, DisplayText, 'TD',
                                                   tmpB, tmpAl, tmpVAl, tmpA );
              Result := Result + '</tr>'#13#10;
            end;
          end;
      end
      else
      begin
        First;
        Result := Result + '<tr>'#13#10;
        for ii := 0 to FieldCount - 1 do
          with Fields[ ii] do
          begin
            tmpAl := haCenter;
            tmpVAl := haVDefault;
            tmpB := '';
            Result := Result + FormatItemCell( 0, ii, DisplayLabel, 'TH', tmpB,
                                               tmpAl, tmpVAl, tmpA ) + #13#10;
          end;
        Result := Result + '</tr>'#13#10;
        if Eof then
          Result := Result + GetEofMsg
        else
          while not Eof do
          begin
            Result := Result + '<tr>'#13#10;
            for ii := 0 to FieldCount - 1 do
              with Fields[ii] do
              begin
                tmpAl := haCenter;
                tmpVAl := haVDefault;
                tmpB := '';
                case Alignment of
                  taLeftJustify: tmpAl := haLeft;
                  taRightJustify: tmpAl := haRight;
                  taCenter: tmpAl := haCenter;
                end;

                if IsBlob then
                  Result := Result + FormatItemCell( RecNo, ii, AsString, 'TD',
                                                     tmpB, tmpAl, tmpVAl, tmpA ) +
                                                     #13#10
                else
                  Result := Result + FormatItemCell( RecNo, ii, DisplayText, 'TD',
                                                     tmpB, tmpAl, tmpVAl, tmpA ) +
                                                     #13#10;
              end;
            Result := Result + '</tr>'#13#10;
            Next;
          end;
      end;
    end;
    Result := Result + '</table>'#13#10;
    finally
      if wa then Bookmark := bk else Close;
    end;
  end;
end;

{ TWebInputGroup }

constructor TWebInputGroup.Create( AVarName: string );
begin
  inherited Create( AVarName );
  FWebInputItems := TList.Create;
end;

destructor TWebInputGroup.Destroy;
begin
  FWebForm.FWebInputGroups.Remove( Self );
  while WebInputItemCount > 0 do WebInputItems[0].Free;  
  inherited Destroy;
  FWebInputItems.Free;
  FWebInputItems := nil;
end;

function TWebInputGroup.AddWebInputItem( AVarName: string ): TWebInputItem;
begin
  Result := TWebInputItem.Create( AVarName, Self );
  Result.FWebGroup := Self;
  FWebInputItems.Add( Result );
  FWebForm.FWebInputItems.Add( Result );
end;

function TWebInputGroup.GetWebInputItem( AIndex: integer ): TWebInputItem;
begin
  Result := FWebInputItems[ AIndex ];
end;

function TWebInputGroup.GetWebInputItemCount: integer;
begin
  Result := FWebInputItems.Count;
end;

{ TWebOutputGroup }

constructor TWebOutputGroup.Create( AVarName: string; ASearchMode: boolean );
begin
  FSearchMode := ASearchMode;
  inherited Create( AVarName );
  FWebOutputItems := TList.Create;
end;

destructor TWebOutputGroup.Destroy;
begin
  FWebForm.FWebOutputGroups.Remove( Self );
  while WebOutputItemCount > 0 do WebOutputItems[0].Free;
  inherited Destroy;
  FWebOutputItems.Free;
  FWebOutputItems := nil;
end;

function TWebOutputGroup.AddWebOutputItem( AVarName: string ): TWebOutputItem;
begin
  Result := TWebOutputItem.Create( AVarName, Self );
  Result.FWebGroup := Self;
  FWebOutputItems.Add( Result );
  FWebForm.FWebOutputItems.Add( Result );
end;

function TWebOutputGroup.GetWebOutputItem( AIndex: integer ): TWebOutputItem;
begin
  Result := FWebOutputItems[ AIndex ];
end;

function TWebOutputGroup.GetWebOutputItemCount: integer;
begin
  Result := FWebOutputItems.Count;
end;

function TWebOutputGroup.GetOutputHTML: string;
var
  ii, jj: integer;
  tmpS: string;
  tmpWI: TWebInputItem;
  tmpWOI: TWebOutputItem;
begin
  Result := '';
  tmpWOI := nil;
  try
    for ii := 0 to WebOutputItemCount - 1 do
    begin
      tmpWOI := WebOutputItems[ii];
      if SearchMode then tmpWOI.OutputQuery.UnPrepare;
      try
        if tmpWOI.OutputQuery.SQL.Count > 0 then
        begin
          tmpWOI.OutputQuery.Prepare;
          for jj := 0 to tmpWOI.OutputQuery.ParamCount - 1 do
          begin
            tmpS := tmpWOI.OutputQuery.Params[jj].FieldName;
            tmpWI := WebForm.WebInputItemByName( tmpS );
            if Assigned( tmpWI ) then
              tmpWOI.OutputQuery.Params[ jj ].AsString := tmpWI.VarValue
            else
            begin
              tmpWOI.OutputQuery.Params[ jj ].AsString :=
                stLitCriteria( WebForm.Request.QueryFields.Values[ tmpS ] );
            end;
          end;
        end;
        tmpS := ''; // Not sure why this is needed...
        tmpS := tmpWOI.GetOutputHTML;
        WebForm.FtmpProducer.HTMLDoc.Text := tmpS;
        tmpS := ''; // Not sure why this is needed...
        Result := Result + '<br>' + WebForm.FtmpProducer.Content;
      finally
        WebForm.FtmpProducer.HTMLDoc.Clear;
        if SearchMode then tmpWOI.OutputQuery.UnPrepare;
      end;
    end;
    Result := Result + '<br>';
  except
    on E: Exception do
    begin
      WebForm.ErrMsgs.Add( 'Error producing content for table.<br>' ); 
      WebForm.ErrMsgs.Add( E.Message );
      if Assigned( tmpWOI ) and
         Assigned( tmpWOI.FOutputQuery.IB_Connection ) then
        tmpWOI.FOutputQuery.IB_Connection.ForceDisconnect;
    end;
  end;
end;

{ TwmBase }

constructor TwmBase.Create( AObject: TComponent );
begin
  FtmpProducer := TPageProducer.Create( Self );
  FtmpProducer.OnHTMLTag := ProcessHTMLTag;
  FSearchFormProducer := TPageProducer.Create( Self );
  FSearchFormProducer.OnHTMLTag := ProcessHTMLTag;
  FWebInputGroups := TList.Create;
  FWebInputItems := TList.Create;
  FWebOutputGroups := TList.Create;
  FWebOutputItems := TList.Create;
  inherited Create( AObject );
end;

destructor TwmBase.Destroy;
begin
  while WebInputGroupCount > 0 do WebInputGroups[0].Free;
  while WebOutputGroupCount > 0 do WebOutputGroups[0].Free;
  inherited Destroy;
  FWebInputGroups.Free;
  FWebInputGroups := nil;
  FWebInputItems.Free;
  FWebInputItems := nil;
  FWebOutputGroups.Free;
  FWebOutputGroups := nil;
  FWebOutputItems.Free;
  FWebOutputItems := nil;
end;

function TwmBase.AddWebInputGroup( AVarName: string ): TWebInputGroup;
begin
  Result := TWebInputGroup.Create( AVarName );
  Result.FWebForm := Self;
  FWebInputGroups.Add( Result );
end;

function TwmBase.AddWebOutputGroup( AVarName: string;
                                    ASearchMode: boolean ): TWebOutputGroup;
begin
  Result := TWebOutputGroup.Create( AVarName, ASearchMode );
  Result.FWebForm := Self;
  FWebOutputGroups.Add( Result );
end;

function TwmBase.GetWebInputGroup( AIndex: integer ): TWebInputGroup;
begin Result := FWebInputGroups[ AIndex ]; end;
function TwmBase.GeTWebInputItem( AIndex: integer ): TWebInputItem;
begin Result := FWebInputItems[ AIndex ]; end;
function TwmBase.GetWebInputItemCount: integer;
begin Result := FWebInputItems.Count; end;
function TwmBase.GetWebInputGroupCount: integer;
begin Result := FWebInputGroups.Count; end;
function TwmBase.GetWebOutputGroup( AIndex: integer ): TWebOutputGroup;
begin Result := FWebOutputGroups[ AIndex ]; end;
function TwmBase.GeTWebOutputItem( AIndex: integer ): TWebOutputItem;
begin Result := FWebOutputItems[ AIndex ]; end;
function TwmBase.GetWebOutputItemCount: integer;
begin Result := FWebOutputItems.Count; end;
function TwmBase.GetWebOutputGroupCount: integer;
begin Result := FWebOutputGroups.Count; end;
procedure TwmBase.SetWebItemValues( ASource: TStrings; Erase: boolean );
var
  ii: integer;
  tmpS: string;
begin
  for ii := 0 to FWebInputItems.Count - 1 do
    with TWebInputItem( FWebInputItems[ii] ) do
    begin
      tmpS := UpperCase( stLitCriteria( ASource.Values[ VarName ] ));
      if Erase or ( tmpS <> '' ) then VarValue := tmpS;
    end;
end;

function TwmBase.WebInputItemByName( AVarName: string ): TWebInputItem;
var
  ii: integer;
  tmpResult: TWebInputItem;
begin
  Result := nil;
  for ii := 0 to FWebInputItems.Count - 1 do
  begin
    tmpResult := TWebInputItem( FWebInputItems[ii] );
    if CompareText( AVarName, tmpResult.VarName ) = 0 then
    begin
      Result := tmpResult;
      Break;
    end;
  end;
end;

function TwmBase.WebInputItemByFieldName( AVarName: string): TWebInputItem;
var
  ii: integer;
  tmpResult: TWebInputItem;
begin
  Result := nil;
  for ii := 0 to FWebInputItems.Count - 1 do
  begin
    tmpResult := TWebInputItem( FWebInputItems[ii] );
    if CompareText( AVarName, tmpResult.FieldName ) = 0 then
    begin
      Result := tmpResult;
      Break;
    end;
  end;
end;

function TwmBase.WebOutputGroupByName( AVarName: string ): TWebOutputGroup;
var
  ii: integer;
  tmpResult: TWebOutputGroup;
begin
  Result := nil;
  for ii := 0 to FWebOutputGroups.Count - 1 do
  begin
    tmpResult := TWebOutputGroup( FWebOutputGroups[ii] );
    if CompareText( AVarName, tmpResult.VarName ) = 0 then
    begin
      Result := tmpResult;
      Break;
    end;
  end;
end;

function TwmBase.WebOutputGroupByFieldName( AVarName: string ): TWebOutputGroup;
var
  ii: integer;
  tmpResult: TWebOutputGroup;
begin
  Result := nil;
  for ii := 0 to FWebOutputGroups.Count - 1 do
  begin
    tmpResult := TWebOutputGroup( FWebOutputGroups[ii] );
    if CompareText( AVarName, tmpResult.FieldName ) = 0 then
    begin
      Result := tmpResult;
      Break;
    end;
  end;
end;

procedure TwmBase.ValidateWebItems;
var
  RangeBeg: string;
  ii: integer;
  valFnd: boolean;
  lstS: string;
begin
  valFnd := false;
  for ii := 0 to WebInputItemCount - 1 do
    with WebInputItems[ii] do
    begin
      if ControlClass = WEBCC_DT_RNG_BEG then
        RangeBeg := VarValue
      else
      if ControlClass = WEBCC_DT_RNG_END then
      begin
        if (( VarValue = '' ) and ( RangeBeg = '' )) or
           (( VarValue <> '' ) and ( RangeBeg <> '' )) then
        else
          ErrMsgs.Add( Caption + ': Date range is invalid.' );
      end
      else
        RangeBeg := '';
      if VarValue <> '' then
      begin
        valFnd := true;
        if ( ControlClass = WEBCC_PICKLIST ) then
        begin
          if ( Pos( VarValue + PickListSeparator,
                    PickListData + PickListSeparator ) = 0 ) then
            ErrMsgs.Add( Caption + ': Value not in picklist: ' + VarValue );
        end;
      end;
      lstS := VarValue;
    end;
  if not valFnd then
    ErrMsgs.Add( 'Please enter some search criteria!' );
end;

procedure TwmBase.SearchQueryPrepareSQL( AStatement: TIB_Statement );
var
  RangeBeg: string;
  ADataset: TIB_Dataset;
  procedure AddSome( AVar: TWebInputItem );
  var
    tmpS: string;
    tmpPos: integer;
  begin
    tmpS := AVar.VarValue;
    if tmpS <> '' then
    begin
      if AVar.ControlClass = WEBCC_DT_RNG_BEG then
        RangeBeg := tmpS
      else
      if AVar.ControlClass = WEBCC_DT_RNG_END then
      begin
        ADataset.SQLWhereItems.Add( AVar.FieldName + ' BETWEEN ' +
          get_IBDateLiteral( StrToDate( RangeBeg )) + ' AND ' +
          get_IBDateLiteral( StrToDate( tmpS )));
        RangeBeg := '';
      end
      else
      if AVar.SearchClass = WEBSC_LIKE then
      begin
        if Pos( '%', tmpS ) = 0 then
          tmpS := tmpS + '%';
        ADataset.SQLWhereItems.Add( AVar.FieldName + ' LIKE ' +
                                    mkLitCriteria( tmpS, '''' ));
      end
      else
      if AVar.SearchClass = WEBSC_CONT then
      begin
        if Pos( '%', tmpS ) > 0 then
          ADataset.SQLWhereItems.Add( AVar.FieldName + ' LIKE ' +
                                      mkLitCriteria( tmpS, '''' ))
        else
        begin
          tmpPos := Pos( ' ', tmpS );
          while tmpPos > 0 do
          begin
            ADataset.SQLWhereItems.Add( AVar.FieldName + ' CONTAINING ' +
                            mkLitCriteria( Copy( tmpS, 1, tmpPos - 1 ), '''' ));
            tmpS := Trim( Copy( tmpS, tmpPos + 1, MaxInt ));
            tmpPos := Pos( ' ', tmpS );
          end;
          if tmpS <> '' then
            ADataset.SQLWhereItems.Add( AVar.FieldName + ' CONTAINING ' +
                                        mkLitCriteria( tmpS, '''' ));
        end;
      end
      else
        ADataset.SQLWhereItems.Add( AVar.FieldName + ' = ' +
                                    mkLitCriteria( tmpS, '''' ));
    end;
  end;
var
  ii: integer;
begin
  if AStatement is TIB_Dataset then
  begin
    ADataset := TIB_Dataset( AStatement );
    RangeBeg := '';
    for ii := 0 to FWebInputItems.Count - 1 do
      AddSome( TWebInputItem( FWebInputItems[ii] ));
  end;
end;

function TwmBase.GetSearchResultCaption: string;
var
  RangeBeg: string;
  procedure AddSome( AVar: TWebInputItem );
  var
    tmpS: string;
  begin
    tmpS := AVar.VarValue;
    if tmpS <> '' then
    begin
      if AVar.ControlClass = WEBCC_DT_RNG_BEG then
        RangeBeg := tmpS
      else
      if AVar.ControlClass = WEBCC_DT_RNG_END then
      begin
        if Result <> '' then
          Result := Result + ' AND<br>'#13#10;
        Result := Result + AVar.Caption + ' BETWEEN ' +
          get_IBDateLiteral( StrToDate( RangeBeg )) + ' AND ' +
          get_IBDateLiteral( StrToDate( tmpS ));
        RangeBeg := tmpS;
      end
      else
      if AVar.SearchClass = WEBSC_LIKE then
      begin
        if Result <> '' then
          Result := Result + ' AND<br>'#13#10;
        Result := Result + AVar.Caption + ' LIKE ''' + tmpS + '''';
      end
      else
      if AVar.SearchClass = WEBSC_CONT then
      begin
        if Result <> '' then
          Result := Result + ' AND<br>'#13#10;

        if Pos( '%', tmpS ) > 0 then
          Result := Result + AVar.Caption + ' LIKE ''' + tmpS + ''''
        else
          Result := Result + AVar.Caption + ' CONTAINING ''' + tmpS + '''';
      end
      else
      begin
        if Result <> '' then
          Result := Result + ' AND<br>'#13#10;
        Result := Result + AVar.Caption + ' IS ''' + tmpS + '''';
      end;
    end;
  end;
var
  ii: integer;
begin
  Result := '';
  RangeBeg := '';
  for ii := 0 to WebInputItemCount - 1 do
    AddSome( WebInputItems[ii] );
end;

function TwmBase.GetSearchInputHTML: string;
var
  ii, jj, tmpPos: integer;
  WG: TWebInputGroup;
  WI: TWebInputItem;
  tmpStr, tmpVal: string;
begin
  Result := '<form METHOD="POST" ACTION="';
  tmpVal := '';
  ProcessHTMLTag( Self, tgCustom, 'SCRIPTFILE', nil, tmpVal );
  Result := Result + tmpVal + '.';
  tmpVal := '';
  ProcessHTMLTag( Self, tgCustom, 'SCRIPTEXT', nil, tmpVal );
  Result := Result + tmpVal + '/__SearchList">'#13#10 +
            '<table ' + SearchFormTableTags + ' >';
  Result := Result + #13#10 + '<tr><td>';
  for ii := 0 to FWebInputGroups.Count - 1 do
  begin
    WG := WebInputGroups[ ii ];
    Result := Result + #13#10 + '<table ' + WG.TableTags + '>';
    if WG.Caption <> '' then
      Result := Result + #13#10 + '<caption>' + WG.Caption + '</caption>';
    Result := Result + #13#10'<tr>';
    for jj := 0 to WG.FWebInputItems.Count - 1 do
    begin
      WI := WG.WebInputItems[ jj ];
      Result := Result + #13#10'<td align=left><font face="Arial" size=2>' +
                WI.ItemLabel + ':</font></td>';
      Result := Result + #13#10'<td align=left><font face="Arial" size=2>';
      if WI.ControlClass = WEBCC_PICKLIST then
      begin
        Result := Result + '<SELECT name="' + WI.VarName + '">'#13#10;
        tmpStr := WI.PickListData;
        tmpPos := Pos( WI.PickListSeparator, tmpStr );
        while tmpPos > 0 do
        begin
          tmpVal := Copy( tmpStr, 1, tmpPos - 1 );
          System.Delete( tmpStr, 1, tmpPos );
          Result := Result + '<option value="' + tmpVal + '">' +
                                                 tmpVal + '</option>'#13#10;
          tmpPos := Pos( WI.PickListSeparator, tmpStr );
        end;
        if tmpStr <> '' then
          Result := Result + '<option value="' + tmpStr + '">' +
                                                 tmpStr + '</option>'#13#10;
        Result := Result + '</SELECT>'#13#10; 
      end
      else
        Result := Result + #13#10'<input type=text size=40 name="' +
                  WI.VarName + '" value="<#' + WI.VarName + '>">';
      Result := Result + #13#10'</font></td>';
      if WI.StartNewRow then
        Result := Result + #13#10'</tr>'#13#10'<tr>';
    end;
    Result := Result + #13#10'</tr>';
    Result := Result + #13#10'</table>';
  end;
  Result := Result + #13#10 + '</td></tr><tr><td>';
  Result := Result + #13#10'<font face="Arial" size=2 color=red>';
  Result := Result + #13#10'<b><#ERRMSG></b>';
  Result := Result + #13#10'</font></td></tr><br>';
  Result := Result + #13#10 + '<tr><td align=center><font face="Arial" size=2>';
  Result := Result + #13#10 + '<input type=submit value="Start Search">';
  Result := Result + #13#10 + '<input type=reset value="Reset Search">';
  Result := Result + #13#10 + '</font></td></tr></table>';
  Result := Result + #13#10 + '</form>';
end;

procedure TwmBase.FormatCell(     AWOI: TWebOutputItem;
                                  CellRow, CellColumn: Integer;
                              var BgColor: THTMLBgColor;
                              var Align: THTMLAlign;
                              var VAlign: THTMLVAlign;
                              var CustomAttrs, CellData: String );
var
  tmpWO: TWebOutputGroup;
  function GetLinkStart: string;
  var
    tmpVal: string;
  begin
    Result := '<a href="';
    tmpVal := '';
    ProcessHTMLTag( Self, tgCustom, 'SCRIPTFILE', nil, tmpVal );
    Result := Result + tmpVal + '.';
    tmpVal := '';
    ProcessHTMLTag( Self, tgCustom, 'SCRIPTEXT', nil, tmpVal );
    Result := Result + tmpVal + '/';
    Result := Result + tmpWO.VarName + '?';
  end;
var
  ii: integer;
  tmpS: string;
  tmpFld: string;
  tmpVal: string;
  tmpPos: integer;
  tmpCol: TIB_Column;
  tmpStr: TIB_StringList;
begin
  if ( CellData <> '' ) and ( CellRow > 0 ) then
  begin
    with AWOI.OutputQuery.Fields[CellColumn] do
    begin
      if ( RelName <> '' ) and
         ( SQLName <> '' ) then
        tmpS := RelName + '.' + SQLName
      else
        tmpS := FieldName;
    end;
    tmpWO := WebOutputGroupByFieldName( tmpS );
    if not Assigned( tmpWO ) then
    begin
      tmpPos := getLitSafePos( '.', tmpS, 1 );
      if tmpPos > 0 then
      begin
        System.Delete( tmpS, 1, tmpPos );
        tmpWO := WebOutputGroupByFieldName( tmpS );
      end;
    end;
    if Assigned( tmpWO ) then
    begin
      tmpS := GetLinkStart + tmpWO.FieldName + '=' + CellData +
                             '">' + CellData + '</a>';
      CellData := tmpS;
    end
    else
    if AWOI.CustomLinkItems.Count > 0 then
    begin
      tmpS := '';
      tmpFld := AWOI.OutputQuery.Fields[ CellColumn ].FieldName;
      tmpPos := AWOI.CustomLinkItems.LinkIndex[ tmpFld ];
      if tmpPos < 0 then
      begin
        tmpFld := AWOI.OutputQuery.Fields[ CellColumn ].SQLName;
        tmpPos := AWOI.CustomLinkItems.LinkIndex[ tmpFld ];
      end;
      if tmpPos < 0 then
      begin
        tmpFld := AWOI.OutputQuery.Fields[ CellColumn ].FullFieldName;
        tmpPos := AWOI.CustomLinkItems.LinkIndex[ tmpFld ];
      end;
      if tmpPos >= 0 then
        tmpS := AWOI.CustomLinkItems.IndexValues[ tmpPos ];
      if tmpS <> '' then
      begin
        tmpWO := WebOutputGroupByFieldName( tmpS );
        if Assigned( tmpWO ) then
        begin
          tmpStr := TIB_StringList.Create;
          try
            ExtractFieldsIntoList( tmpS, tmpStr );
            tmpS := GetLinkStart;
            for ii := 0 to tmpStr.Count - 1 do
            begin
              if ii > 0 then
                tmpS := tmpS + '&';
              tmpCol := AWOI.OutputQuery.FindField( tmpStr[ ii ] );
              if Assigned( tmpCol ) then
                tmpS := tmpS + tmpStr[ ii ] + '=' + tmpCol.AsString + ''
              else
              begin
                tmpVal := Request.QueryFields.Values[ tmpStr[ ii ]];
                if tmpVal <> '' then
                begin
                  tmpVal := stLitCriteria( tmpVal );
                  tmpS := tmpS + tmpStr[ ii ] + '=' + tmpVal + '';
                end
                else
                begin
                  tmpVal := Request.ContentFields.Values[ tmpStr[ ii ]];
                  if tmpVal <> '' then
                  begin
                    tmpVal := stLitCriteria( tmpVal );
                    tmpS := tmpS + tmpStr[ ii ] + '=' + tmpVal + '';
                  end
                  else
                    tmpS := tmpS + tmpStr[ ii ] + '=' + CellData + '';
                end;
              end;
            end;
            tmpS := tmpS + '">' + CellData + '</a>';
          finally
            tmpStr.Free;
          end;
          CellData := tmpS;
        end;
      end;
    end;
  end;
  if CellData = '' then CellData := '&nbsp';
end;

procedure TwmBase.ProcessHTMLTag(       Sender: TObject;
                                        Tag: TTag;
                                  const TagString: String;
                                        TagParams: TStrings;
                                    var ReplaceText: String );
var
  tmpWI: TWebInputItem;
begin
  tmpWI := WebInputItemByName( TagString );
  if Assigned( tmpWI ) then
    ReplaceText := tmpWI.VarValue
  else
    GetTagString( Sender, Tag, TagString, TagParams, ReplaceText );
end;

procedure TwmBase.InitializeFromData( AWebAppName: string );
var
  tmpInt: integer;
  tmpStr: string;
  cr1: TIB_Cursor;
  cr2: TIB_Cursor;
  cr3: TIB_Cursor;
  cr5: TIB_Cursor;
  cr4: TIB_Cursor;
  ds1: TIB_DataSource;
  ds2: TIB_DataSource;
  ds4: TIB_DataSource;
begin
  cr1 := TIB_Cursor.Create( cn );
  cr1.IB_Connection := cn;
  cr1.SQL.Text := 'SELECT * FROM WEB$APP WHERE WEB$APP_NAME = :APP_NAME';
  ds1 := TIB_DataSource.Create( cn );
  ds1.Dataset := cr1;
  cr2 := TIB_Cursor.Create( cn );
  cr2.IB_Connection := cn;
  cr2.SQL.Text := 'SELECT * FROM WEB$GRP_INPUT ORDER BY WEB$GRP_POSITION';
  cr2.MasterSource := ds1;
  cr2.MasterLinks.Text := 'WEB$APP_ID=WEB$APP_ID';
  ds2 := TIB_DataSource.Create( cn );
  ds2.Dataset := cr2;
  cr3 := TIB_Cursor.Create( cn );
  cr3.IB_Connection := cn;
  cr3.SQL.Text := 'SELECT * FROM WEB$ITM_INPUT ORDER BY WEB$ITM_POSITION';
  cr3.MasterSource := ds2;
  cr3.MasterLinks.Add( 'WEB$APP_ID=WEB$APP_ID' );
  cr3.MasterLinks.Add( 'WEB$GRP_NAME=WEB$GRP_NAME' );
  cr4 := TIB_Cursor.Create( cn );
  cr4.IB_Connection := cn;
  cr4.SQL.Text := 'SELECT * FROM WEB$GRP_OUTPUT ORDER BY WEB$GRP_POSITION';
  cr4.MasterSource := ds1;
  cr4.MasterLinks.Text := 'WEB$APP_ID=WEB$APP_ID';
  ds4 := TIB_DataSource.Create( cn );
  ds4.Dataset := cr4;
  cr5 := TIB_Cursor.Create( cn );
  cr5.IB_Connection := cn;
  cr5.SQL.Text := 'SELECT * FROM WEB$ITM_OUTPUT ORDER BY WEB$ITM_POSITION';
  cr5.MasterSource := ds4;
  cr5.MasterLinks.Add( 'WEB$APP_ID=WEB$APP_ID' );
  cr5.MasterLinks.Add( 'WEB$GRP_NAME=WEB$GRP_NAME' );
  try
  cr1.ParamByName( 'APP_NAME' ).AsString := 'CHARITY_SEARCH';
  cr1.First;
  if cr1.Eof then
    raise Exception.Create( 'Web App: ' + 'CHARITY_SEARCH' + ' Not found!' );
  ScriptVersion := cr1.FieldByName( 'WEB$APP_VERSION' ).AsString;
  FDefaultTableTags := cr1.FieldByName( 'WEB$APP_DEFAULT_TABLE_TAGS' ).AsString;
  tmpStr := cr1.FieldByName( 'WEB$APP_SRCH_FRM_TABLE_TAGS' ).AsString;
  tmpInt := Pos( '<#DEFAULT_TABLE_TAGS>', tmpStr );
  if tmpInt > 0 then
  begin
    System.Delete( tmpStr, tmpInt, Length( '<#DEFAULT_TABLE_TAGS>' ));
    System.Insert( FDefaultTableTags, tmpStr, tmpInt );
  end;
  SearchFormTableTags := tmpStr;
  cr2.First;
  while not cr2.Eof do
  begin
    with AddWebInputGroup( cr2.FieldByName( 'WEB$GRP_NAME' ).AsString ) do
    begin
      Caption := cr2.FieldByName( 'WEB$GRP_CAPTION' ).AsString;
      SearchOutputGroups := cr2.FieldByName( 'WEB$GRP_SRCH_OUT_GRP_NAME' ).AsString;
      cr3.First;
      while not cr3.Eof do
      begin
        with AddWebInputItem( cr3.FieldByName( 'WEB$ITM_NAME' ).AsString ) do
        begin
          Caption := cr3.FieldByName( 'WEB$ITM_CAPTION' ).AsString;
          ItemLabel := cr3.FieldByName( 'WEB$ITM_ITEMLABEL' ).AsString;
          FieldName := cr3.FieldByName( 'WEB$ITM_FIELDNAME' ).AsString;
          SearchClass := cr3.FieldByName( 'WEB$ITM_SEARCHCLASS' ).AsString;
        end;
        cr3.Next;
      end;
      cr3.Close;
    end;
    cr2.Next;
  end;
  cr2.Close;
  cr4.First;
  while not cr4.Eof do
  begin
    with AddWebOutputGroup( cr4.FieldByName( 'WEB$GRP_NAME' ).AsString,
                            cr4.FieldByName( 'WEB$GRP_SEARCH_MODE' ).AsString = 'T' ) do
    begin
      cr5.First;
      while not cr5.Eof do
      begin
        with AddWebOutputItem( cr5.FieldByName( 'WEB$ITM_NAME' ).AsString ) do
        begin
          Caption := cr5.FieldByName( 'WEB$ITM_CAPTION' ).AsString;
          EofMessage := cr5.FieldByName( 'WEB$ITM_EOF_MESSAGE' ).AsString;
          FieldName :=  cr5.FieldByName( 'WEB$ITM_FIELDNAME' ).AsString;
          SingleRecord := cr5.FieldByName( 'WEB$ITM_SINGLE_RECORD' ).AsString = 'T';
          OutputQuery.SQL.Text := cr5.FieldByName( 'WEB$ITM_QUERY_TEXT' ).AsString;
          tmpStr := cr5.FieldByName( 'WEB$ITM_TABLE_TAGS' ).AsString;
          tmpInt := Pos( '<#DEFAULT_TABLE_TAGS>', tmpStr );
          if tmpInt > 0 then
          begin
            System.Delete( tmpStr, tmpInt, Length( '<#DEFAULT_TABLE_TAGS>' ));
            System.Insert( FDefaultTableTags, tmpStr, tmpInt );
          end;
          TableTags := tmpStr;
        end;
        cr5.Next;
      end;
      cr5.Close;
    end;
    cr4.Next;
  end;
  cr4.Close;
  cr1.Close;
  cr5.Unprepare;
  cr4.Unprepare;
  cr3.Unprepare;
  cr2.Unprepare;
  cr1.Unprepare;
  finally
    cr1.Free;
    cr2.Free;
    cr3.Free;
    cr4.Free;
    cr5.Free;
    ds1.Free;
    ds2.Free;
    ds4.Free;
  end;
end;

end.

