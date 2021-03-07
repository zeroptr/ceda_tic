
{                                                                              }
{ IB_Web                                                                       }
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

{: This unit contains the components for working with the HTML components.}
unit
  IB_Web;

interface

uses
  SysUtils, Windows, Classes, HTTPApp,

{$IFDEF IBO_VCL60_OR_GREATER}
  HTTPProd,
{$ENDIF}

  Dialogs,

  IB_Session,
  IB_Components;

type
  TIB_CustomChunkProducer = class;

  TIB_CustomChunkProvider = class( TIB_ConnectionLink )
  private
    FChunkProducerList: TList;
    FChunkTransaction: TIB_Transaction;
    FChunkQuery: TIB_BDataset;
    FChunkTableName: string;
    FChunkGroupName: string;
    FChunkGroupColumn: string;
    FChunkIDColumn: string;
    FChunkIDGenerator: string;
    FChunkNameColumn: string;
    FChunkTextColumn: string;
    FChunkDateColumn: string;
    FShowHTMLDocInDFM: boolean;
    FPreparing: boolean;
    FPrepared: boolean;
    FStoring: boolean;
    FLoading: boolean;
    FOnHTMLTag: THTMLTagEvent;
    procedure SetPrepared( AValue: boolean );
  protected
    FGenerationLevel: DWORD;
    function GetChunkFilter: string;
    procedure SetChunkFilter( AValue: string );
    procedure SetChunkTableName( AValue: string ); virtual;
    procedure SetChunkGroupName( AValue: string ); virtual;
    procedure SetChunkGroupColumn( AValue: string ); virtual;
    procedure SetChunkIDColumn( AValue: string ); virtual;
    procedure SetChunkIDGenerator( AValue: string ); virtual;
    procedure SetChunkNameColumn( AValue: string ); virtual;
    procedure SetChunkTextColumn( AValue: string ); virtual;
    procedure SetChunkDateColumn( AValue: string ); virtual;
    function LoadChunk(     AName: string;
                            AValue: TStrings;
                        var ADate: TDateTime;
                        var RecFound: boolean ): boolean; virtual;
    function StoreChunk(       AName: string;
                               AValue: TStrings;
                         const ADate: TDateTime ): boolean; virtual;
    procedure PrepareChunkProvider; virtual;
    procedure UnprepareChunkProvider; virtual;
    procedure ProcessEvent( AEvent: TIB_ConnectionEventType ); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InvalidateChunkProducers;

    property ChunkTextColumn: string read FChunkTextColumn
                                     write SetChunkTextColumn;
    property ChunkDateColumn: string read FChunkDateColumn
                                     write SetChunkDateColumn;
    property ChunkFilter: string read GetChunkFilter
                                 write SetChunkFilter;
    property ChunkIDColumn: string read FChunkIDColumn
                                   write SetChunkIDColumn;
    property ChunkIDGenerator: string read FChunkIDGenerator
                                      write SetChunkIDGenerator;
    property ChunkNameColumn: string read FChunkNameColumn
                                     write SetChunkNameColumn;
    property ChunkTableName: string read FChunkTableName
                                    write SetChunkTableName;
    property ChunkGroupName: string read FChunkGroupName
                                    write SetChunkGroupName;
    property ChunkGroupColumn: string read FChunkGroupColumn
                                      write SetChunkGroupColumn;
    property Prepared: boolean read FPrepared write SetPrepared stored false;
    property ShowHTMLDocInDFM: boolean read FShowHTMLDocInDFM
                                       write FShowHTMLDocInDFM stored false;
    property OnHTMLTag: THTMLTagEvent read FOnHTMLTag write FOnHTMLTag;
  end;

  TIB_CustomChunkProducer = class( TCustomPageProducer )
  private
    FChunkProvider: TIB_CustomChunkProvider;
    FChunkFromProvider: boolean;
    FChunkFromUser: boolean;
    FChunkLoading: boolean;
    FChunkStoring: boolean;
    FChunkMerging: boolean;
    FSettingRef: boolean;
    FInvalidatingChunk: boolean;
    FChunkName: string;
    FChunkDate: TDateTime;
    FIB_Dataset: TIB_Dataset;
    function GetHTMLDoc: TStrings;
    procedure SetHTMLDoc( AValue: TStrings );
    function IsHTMLDocStored: boolean;
    function ContainsUnpreparedMsg: boolean;
{$IFNDEF IBO_VCL60_OR_GREATER}
  private
    FOnHTMLTag: THTMLTagEvent;
  protected
    function HandleTag( const TagString: string;
                              TagParams: TStrings ): string; override;
    procedure DoTagEvent(       Tag: TTag;
                          const TagString: string;
                                TagParams: TStrings;
                            var ReplaceText: string ); dynamic;
{$ELSE}
  public
    procedure DoTagEvent(       Tag: TTag;
                          const TagString: string;
                                TagParams: TStrings;
                            var ReplaceText: string ); override;
{$ENDIF}
  protected
    FGenerationLevel: DWORD;
    procedure SetName( const NewName: TComponentName ); override;
    procedure Notification( AComponent: TComponent;
                            Operation: TOperation ); override;
    procedure HTMLDocChange( ASender: TObject );
    function GetDataset: TIB_Dataset; virtual;
    procedure SetDataset( AValue: TIB_Dataset); virtual;
    function IsChunkNameStored: boolean; virtual;
    function GetChunkName: string; virtual;
    procedure SetChunkName( AValue: string ); virtual;
    procedure SetChunkDate( AValue: TDateTime );
    property ChunkFromProvider: boolean read FChunkFromProvider;
    property ChunkFromUser: boolean read FChunkFromUser;
    property HTMLDoc: TStrings read GetHTMLDoc
                               write SetHTMLDoc stored IsHTMLDocStored;
    function LoadChunk: boolean;
    function StoreChunk: boolean;
    function MergeChunk: boolean;
    procedure CheckProvider( RequestPrepare: boolean );
    procedure SetChunkProvider( AValue: TIB_CustomChunkProvider );
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Content: string; override;
    procedure InvalidateChunk;
  public
    property ChunkDate: TDateTime read FChunkDate
                                  write SetChunkDate
                                  stored IsHTMLDocStored;
    property ChunkName: string read GetChunkName
                               write SetChunkName
                               stored IsChunkNameStored;
    property ChunkProvider: TIB_CustomChunkProvider read FChunkProvider
                                                    write SetChunkProvider;
    property Dataset: TIB_Dataset read GetDataset write SetDataset;
{$IFNDEF IBO_VCL60_OR_GREATER}
    property OnHTMLTag: THTMLTagEvent read FOnHTMLTag write FOnHTMLTag;
{$ENDIF}    
  end;

  TIB_ChunkProvider = class( TIB_CustomChunkProvider )
  published
    property ChunkTextColumn;
    property ChunkDateColumn;
    property ChunkFilter;
    property ChunkIDColumn;
    property ChunkIDGenerator;
    property ChunkNameColumn;
    property ChunkTableName;
    property ChunkGroupName;
    property ChunkGroupColumn;
    property IB_Connection;
    property Prepared;
    property ShowHTMLDocInDFM;
    property OnHTMLTag;
  end;

  TIB_ChunkProducer = class( TIB_CustomChunkProducer )
  published
    property HTMLDoc;
    property ChunkDate; // Keep after HTMLDoc.
    property ChunkName;
    property ChunkProvider;
    property Dataset;
{$IFDEF IBO_VCL50_OR_GREATER}    
    property StripParamQuotes;
{$ENDIF}
    property OnHTMLTag;
  end;

implementation

uses
  Forms, IB_Parse;

const
  CHNK_MSG_UNPREPARED = 'Unprepared chunk provider. ';
  PrFmt = 'yymmddhhnnsszzz';

constructor TIB_CustomChunkProvider.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );
  FChunkProducerList := TList.Create;
  FChunkTransaction := TIB_Transaction.Create( Self );
  FChunkTransaction.AutoCommit := true;
  FChunkTransaction.Isolation := tiCommitted;
  FChunkQuery := TIB_BDataset.Create( Self );
  FChunkQuery.KeyLinksAutoDefine := false;
  FChunkQuery.IB_Transaction := FChunkTransaction;
  FChunkQuery.CheckRequired := false;
  FChunkQuery.RequestLive := true;
  FChunkQuery.CallbackInc := -1;
  FChunkQuery.AutoFetchAll := true;
  FGenerationLevel := 1;
end;

destructor TIB_CustomChunkProvider.Destroy;
var
  tmpPr: TIB_CustomChunkProducer;
begin

////showmessage( 'Name: ' + Name + ' Destroy Begin 0' );

  if Assigned( FChunkProducerList ) then
    while FChunkProducerList.Count > 0 do
    begin
      tmpPr := TIB_CustomChunkProducer(FChunkProducerList.Items[0]);
      tmpPr.ChunkProvider := nil;
    end;

//showmessage( 'Name: ' + Name + ' Destroy Begin 1' );

  Prepared := false;
//showmessage( 'Name: ' + Name + ' Destroy Begin 2' );

  IB_Connection := nil;
//showmessage( 'Name: ' + Name + ' Destroy Begin 3' );

  inherited Destroy;
////showmessage( 'Name: ' + Name + ' Destroy Begin 4' );

//  FChunkQuery.Free;
//  FChunkQuery := nil;

//showmessage( 'Name: ' + Name + ' Destroy Begin 5' );

  if Assigned( FChunkProducerList ) then
  begin
    FChunkProducerList.Free;
    FChunkProducerList := nil;
  end;

//showmessage( 'Name: ' + Name + ' Destroy End' );

end;

procedure TIB_CustomChunkProvider.SetChunkTableName( AValue: string );
begin
  if FChunkTableName <> AValue then
  begin
    Prepared := false;
    FChunkTableName := AValue;
  end;
end;

procedure TIB_CustomChunkProvider.SetChunkGroupName( AValue: string );
begin
  if FChunkGroupName <> AValue then
  begin
    Prepared := false;
    FChunkGroupName := AValue;
  end;
end;

procedure TIB_CustomChunkProvider.SetChunkGroupColumn( AValue: string );
begin
  if FChunkGroupName <> AValue then
  begin
    Prepared := false;
    FChunkGroupColumn := AValue;
  end;
end;

procedure TIB_CustomChunkProvider.SetChunkIDColumn( AValue: string );
begin
  if FChunkIDColumn <> AValue then
  begin
    Prepared := false;
    FChunkIDColumn := AValue;
  end;
end;

procedure TIB_CustomChunkProvider.SetChunkIDGenerator( AValue: string );
begin
  if FChunkIDGenerator <> AValue then
  begin
    Prepared := false;
    FChunkIDGenerator := AValue;
  end;
end;

procedure TIB_CustomChunkProvider.SetChunkNameColumn( AValue: string );
begin
  if FChunkNameColumn <> AValue then
  begin
    Prepared := false;
    FChunkNameColumn := AValue;
  end;
end;

procedure TIB_CustomChunkProvider.SetChunkTextColumn( AValue: string );
begin
  if FChunkTextColumn <> AValue then
  begin
    Prepared := false;
    FChunkTextColumn := AValue;
  end;
end;

procedure TIB_CustomChunkProvider.SetChunkDateColumn( AValue: string );
begin
  if FChunkDateColumn <> AValue then
  begin
    Prepared := false;
    FChunkDateColumn := AValue;
  end;
end;

function TIB_CustomChunkProvider.GetChunkFilter: string;
begin
  if Assigned( FChunkQuery ) then
    Result := FChunkQuery.Filter
  else
    Result := '';
end;

procedure TIB_CustomChunkProvider.SetChunkFilter( AValue: string );
begin
  if Assigned( FChunkQuery ) then
    FChunkQuery.Filter := AValue;
end;

function TIB_CustomChunkProvider.LoadChunk(
      AName: string;
      AValue: TStrings;
  var ADate: TDateTime;
  var RecFound: boolean ): boolean;
begin
  RecFound := false;
  Result := false;
  if Assigned( FChunkQuery ) then  
  if not FLoading and not FStoring then
    try
      FLoading := true;
      Prepared := true;
      if Prepared then
      begin
        FChunkQuery.Open;
//        if csDesigning in ComponentState then
        FChunkQuery.FetchAll;
        RecFound := FChunkQuery.Locate( ChunkNameColumn, AName, [] );
        if RecFound then
        begin
          FChunkQuery.FieldByName( ChunkTextColumn ).AssignTo( AValue );
          ADate := FChunkQuery.FieldByName( ChunkDateColumn ).AsDateTime;
        end
        else
        begin
          AValue.Clear;
          ADate := 1;
        end;
        Result := true;
      end;
    finally
      FLoading := false;
    end;
end;

function TIB_CustomChunkProvider.StoreChunk(
        AName: string;
        AValue: TStrings;
  const ADate: TDateTime ): boolean;
var
  tmpStrings: TIB_StringList;
  RecFound: boolean;
begin
  Result := false;
  if not FStoring and not FLoading then
    try
      FStoring := true;
      Prepared := true;
      if Assigned( FChunkQuery ) then
      if Prepared then
        with FChunkQuery do
        begin
          Open;
          try
            RecFound := Locate( ChunkNameColumn, AName, [] );
            tmpStrings := TIB_StringList.Create;
            try
              if RecFound then
                FieldByName( ChunkTextColumn ).AssignTo( tmpStrings );
              if not RecFound or not AValue.Equals( tmpStrings ) then
              begin
                if ( Fields.RowState <> rsNone ) and RecFound then
                  Edit
                else
                  Insert;
                FieldByName( ChunkNameColumn ).AsString := AName;
                FieldByName( ChunkGroupColumn ).AsString := ChunkGroupName;
                FieldByName( ChunkTextColumn ).Assign( AValue );
                FieldByName( ChunkDateColumn ).AsDateTime := ADate;
                Post;
              end;
            finally
              tmpStrings.Free;
            end;
            Result := true;
          except
            if NeedToPost then
              Cancel;
            Close;
            raise;
          end;
        end;
    finally
      FStoring := false;
    end;
end;

procedure TIB_CustomChunkProvider.PrepareChunkProvider;
begin
  if Assigned( FChunkQuery ) then
  if not FPrepared and not FPreparing then
    try
      FPreparing := true;
      FChunkQuery.SQL.Clear;
      FChunkQuery.KeyLinks.Text := ChunkIDColumn;
      FChunkQuery.GeneratorLinks.Text := ChunkIDColumn + '=' + ChunkIDGenerator;
      FChunkQuery.SQL.Add( 'SELECT ' + ChunkIDColumn + ', ' +
                                       ChunkNameColumn + ', ' +
                                       ChunkGroupColumn + ', ' +
                                       ChunkTextColumn + ', ' +
                                       ChunkDateColumn );
      FChunkQuery.SQL.Add( 'FROM ' + ChunkTableName );
      FChunkQuery.SQL.Add( 'WHERE ' + ChunkGroupColumn + ' = ' +
                                      mkLitCriteria( ChunkGroupName, '''' ));
      if not Assigned( IB_Connection ) or not IB_Connection.Connected then
      begin
        FChunkQuery.CheckConnection( true );
        IB_Connection := FChunkQuery.IB_Connection;
      end;
      if Assigned( IB_Connection ) and ( IB_Connection.Connected ) then
      begin
        try
          FChunkQuery.Prepare;
        except
          on E: Exception do
          begin
            if csDesigning in ComponentState then
              Application.HandleException( E )
            else
              raise;
            FChunkQuery.Unprepare;
          end;
        end;
      end;
    finally
      FPreparing := false;
      FPrepared := FChunkQuery.Prepared;
    end;
end;

procedure TIB_CustomChunkProvider.UnprepareChunkProvider;
begin
  if Assigned( FChunkQuery ) then
  if Prepared then
    try
      InvalidateChunkProducers;
      FPrepared := false;
      FChunkTransaction.Close;
      FChunkQuery.Unprepare;
    finally
      FPrepared := FChunkQuery.Prepared;
    end;  
end;

procedure TIB_CustomChunkProvider.InvalidateChunkProducers;
begin
  if Assigned( FChunkQuery ) then
  if FChunkQuery.Active then
    FChunkQuery.Close;
  try
    Inc( FGenerationLevel );
  except
    FGenerationLevel := 1;
  end;
end;

procedure TIB_CustomChunkProvider.SetPrepared( AValue: boolean );
begin
  if FPrepared <> AValue then
  begin
    if AValue then PrepareChunkProvider
              else UnprepareChunkProvider;
  end;
end;

procedure TIB_CustomChunkProvider.ProcessEvent(
  AEvent: TIB_ConnectionEventType );
begin
  case AEvent of
    cetBeforeDisconnect,
    cetBeforeDropDatabase: Prepared := false;
    cetBeforeAssignment:
    begin
      Prepared := false;
      FChunkTransaction.IB_Connection := nil;
      if Assigned( FChunkQuery ) then
        FChunkQuery.IB_Connection := nil;
    end;
    cetAfterAssignment:
    begin
      FChunkTransaction.IB_Connection := IB_Connection;
      if Assigned( FChunkQuery ) then
        FChunkQuery.IB_Connection := IB_Connection;
    end;
  end;
end;

{ Custom Chunk Producer }

constructor TIB_CustomChunkProducer.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  TStringList( inherited HTMLDoc ).OnChange := HTMLDocChange;
  FChunkDate := now;
  FGenerationLevel := 0;
  FChunkFromUser := false;
  FChunkFromProvider := false;
end;

destructor TIB_CustomChunkProducer.Destroy;
begin

//showmessage( 'Name: ' + Name + ' Destroy Begin' );

  TStringList( inherited HTMLDoc ).OnChange := nil;
  if Assigned( FChunkProvider ) then
    ChunkProvider := nil;
  inherited Destroy;

//showmessage( 'Name: ' + Name + ' Destroy End' );

end;

procedure TIB_CustomChunkProducer.Notification( AComponent: TComponent;
                                                Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if (( AComponent = FIB_Dataset ) and ( Operation = opRemove )) then
    Dataset := nil;
  if (( AComponent = ChunkProvider ) and ( Operation = opRemove )) then
    ChunkProvider := nil;
end;

procedure TIB_CustomChunkProducer.SetName( const NewName: TComponentName );
begin
  if Name <> NewName then
  begin
    inherited SetName( NewName );
    if FChunkName = '' then
      InvalidateChunk;
  end;
end;

function TIB_CustomChunkProducer.GetDataset: TIB_Dataset;
begin
  Result := FIB_Dataset;
end;

procedure TIB_CustomChunkProducer.SetDataset( AValue: TIB_Dataset);
begin
  if FIB_Dataset <> AValue then
  begin
    FIB_Dataset := AValue;
    if AValue <> nil then
      AValue.FreeNotification( Self );
  end;
end;

function TIB_CustomChunkProducer.IsChunkNameStored: boolean;
begin
  Result := FChunkName <> '';
end;

function TIB_CustomChunkProducer.GetChunkName: string;
begin
  Result := FChunkName;
  if Result = '' then
    Result := Name;
end;

procedure TIB_CustomChunkProducer.SetChunkName( AValue: string );
begin
  if ChunkName <> AValue then
  begin
    if AValue = Name then
      FChunkName := ''
    else
      FChunkName := AValue;
    InvalidateChunk;
  end;
end;

function TIB_CustomChunkProducer.GetHTMLDoc: TStrings;
//var
//  ii: integer;
//  tmpProv: TIB_CustomChunkProvider;
begin
{
  if ( csDesigning in ComponentState ) and
     not ( csReading in ComponentState ) and
     not ( csWriting in ComponentState ) and
     not ( Assigned( ChunkProvider )) and
     ( Assigned( Owner )) then
  begin
    tmpProv := nil;
    for ii := 0 to Owner.ComponentCount - 1 do
      if Owner.Components[ ii ] is TIB_CustomChunkProvider then
      begin
        if Assigned( tmpProv ) then
        begin
          tmpProv := nil;
          Break;
        end;
        tmpProv := TIB_CustomChunkProvider( Owner.Components[ ii ] );
      end;
    if Assigned( tmpProv ) then
      ChunkProvider := tmpProv;
  end;
}
  if not FChunkLoading then
    LoadChunk;
  Result := inherited HTMLDoc;
end;

procedure TIB_CustomChunkProducer.SetHTMLDoc( AValue: TStrings );
begin
  inherited HTMLDoc.Assign( AValue );
end;

function TIB_CustomChunkProducer.Content: string;
var
  tmpDataset: TIB_Dataset;
begin
  CheckProvider( true );
  LoadChunk;
  tmpDataset := Dataset;
  if Assigned( tmpDataset ) and not tmpDataset.Active then
    tmpDataset.Open;
  Result := inherited Content;
end;

function TIB_CustomChunkProducer.ContainsUnpreparedMsg: boolean;
begin
  Result := ( csDesigning in ComponentState ) and
            (( inherited HTMLDoc.Count = 1 ) and
             ( inherited HTMLDoc[ 0 ] = '<!-- ' + CHNK_MSG_UNPREPARED + ' ' +
                                        FormatDateTime( PrFmt, FChunkDate ) +
                                        ' -->' ));
end;

function TIB_CustomChunkProducer.IsHTMLDocStored: boolean;
begin
  if ContainsUnpreparedMsg then
    Result := false
  else
    Result := ChunkFromUser or
              not Assigned( FChunkProvider ) or
              ChunkProvider.ShowHTMLDocInDFM;
end;

procedure TIB_CustomChunkProducer.HTMLDocChange( ASender: TObject );
var
  NeedCompare: boolean;
begin
  if not FInvalidatingChunk and
     not FChunkLoading and
     not FChunkStoring and
     not FChunkMerging and
     not ContainsUnpreparedMsg then
  begin
    NeedCompare := not FChunkFromProvider;
    FChunkFromProvider := false;
    FChunkFromUser := true;
    if not (( csReading in ComponentState ) or
            ( csWriting in ComponentState )) then
      FChunkDate := now;
    if NeedCompare then
      MergeChunk
    else
      StoreChunk;
  end;
end;

procedure TIB_CustomChunkProducer.SetChunkDate( AValue: TDateTime );
begin
  if (( csReading in ComponentState ) or
      ( csWriting in ComponentState )) then
    FChunkDate := AValue;
end;

procedure TIB_CustomChunkProducer.SetChunkProvider(
  AValue: TIB_CustomChunkProvider );
begin
  if ( FChunkProvider <> AValue ) and ( not FSettingRef ) then
    try
      FSettingRef := true;
      if Assigned( FChunkProvider ) then
      begin
        if FChunkProvider.ShowHTMLDocInDFM and FChunkProvider.Prepared then
          LoadChunk;
        FChunkProvider.FChunkProducerList.Remove( Self );
      end;
      FChunkProvider := AValue;
      if Assigned( FChunkProvider ) then
      begin
        FChunkProvider.FChunkProducerList.Add( Self );
        FChunkProvider.FreeNotification( Self );
        if FChunkFromProvider then
        begin
          FChunkFromProvider := false;
          if not FChunkFromUser then
            FChunkFromUser := ( inherited HTMLDoc.Count > 0 ) and
                              not ContainsUnpreparedMsg;
        end;
      end;
    finally
      FSettingRef := false;
    end;
end;

function TIB_CustomChunkProducer.LoadChunk: boolean;
var
  tmpChunkGen: DWORD;
  tmpFnd: boolean;
begin
  Result := false;
  if not FChunkLoading and
     not FChunkStoring and
     not FChunkMerging and
     Assigned( ChunkProvider ) and
     (( not ChunkFromProvider ) or
      ( ChunkProvider.FGenerationLevel <> FGenerationLevel )) then
    try
      FChunkLoading := true;
      tmpChunkGen := ChunkProvider.FGenerationLevel;
      if ContainsUnpreparedMsg then
      begin
        inherited HTMLDoc.Clear;
        FChunkFromProvider := false; // Just in case.
        FChunkFromUser := false; // Just in case.
      end;
      if ( ChunkProvider.Prepared ) and
         ( ChunkFromUser ) and
         ( csDesigning in ComponentState ) then
      begin
        if not MergeChunk then
          Exit;
      end
      else
      if ( not ChunkProvider.Prepared ) or
         ( not ChunkProvider.LoadChunk( ChunkName,
                                        inherited HTMLDoc,
                                        FChunkDate,
                                        tmpFnd )) then
      begin
        if (( csDesigning in ComponentState ) and
            ( inherited HTMLDoc.Count = 0 )) then
          inherited HTMLDoc.Text := '<!-- ' + CHNK_MSG_UNPREPARED + ' ' +
                                    FormatDateTime( PrFmt, FChunkDate ) +
                                    ' -->';
        Exit;
      end;
      Result := true;
      FChunkFromUser := false;
      FChunkFromProvider := true;
      FGenerationLevel := tmpChunkGen;
    finally
      FChunkLoading := false;
    end;
end;

function TIB_CustomChunkProducer.StoreChunk: boolean;
begin
  Result := false;
  if not FChunkLoading and
     not FChunkStoring and
     ( Assigned( ChunkProvider )) and
     ( not ( csLoading in ComponentState )) then
  try
    FChunkStoring := true;
    try
      if ChunkProvider.StoreChunk( ChunkName,
                                   inherited HTMLDoc,
                                   FChunkDate ) then
      begin
        FChunkFromUser := false;
        FChunkFromProvider := true;
        Result := true;
      end;
    except
      on E: Exception do
      begin
        if csDesigning in ComponentState then
          Forms.Application.HandleException( E )
        else
          raise;
      end;
    end;
  finally
    FChunkStoring := false;
  end;
end;

function TIB_CustomChunkProducer.MergeChunk: boolean;
var
  tmpStrings: TStringList;
  tmpName: string;
  tmpChunkGen: DWORD;
  tmpDate: TDateTime;
  tmpFnd: boolean;
begin
  Result := false;
  if not FChunkMerging and
     not FChunkStoring and
     ChunkFromUser and
     Assigned( ChunkProvider ) and
     ChunkProvider.Prepared then
  try
    FChunkMerging := true;
    tmpChunkGen := ChunkProvider.FGenerationLevel;
    tmpStrings := TStringList.Create;
    try
      if ChunkProvider.LoadChunk( ChunkName,
                                  tmpStrings,
                                  tmpDate,
                                  tmpFnd ) then
      begin
        if tmpFnd then
        begin
          if inherited HTMLDoc.Equals( tmpStrings ) then
            Result := true
          else
          begin
            if FChunkDate >= tmpDate then
            begin
              tmpName := ChunkName + '_POD_' +
                         PadLeft( IntToStr( GetTickCount ), '0', 9, true );
              if FChunkProvider.StoreChunk( tmpName,
                                            tmpStrings,
                                            tmpDate ) then
              if FChunkProvider.StoreChunk( ChunkName,
                                            inherited HTMLDoc,
                                            FChunkDate ) then
                Result := true;
            end
            else
            begin
              tmpName := ChunkName + '_PMC_' +
                         PadLeft( IntToStr( GetTickCount ), '0', 9, true );
              if FChunkProvider.StoreChunk( tmpName,
                                            inherited HTMLDoc,
                                            FChunkDate ) then
              begin
                inherited HTMLDoc.Assign( tmpStrings );
                FChunkDate := tmpDate;
                Result := true;
              end;
            end;
          end;
        end
        else
        if FChunkProvider.StoreChunk( ChunkName,
                                      inherited HTMLDoc,
                                      FChunkDate ) then
          Result := true;
      end;
      if Result then
      begin
        FChunkFromProvider := true;
        FChunkFromUser := false;
        FGenerationLevel := tmpChunkGen;
      end;
    finally
      tmpStrings.Free;
    end;
  finally
    FChunkMerging := false;
  end;
end;

procedure TIB_CustomChunkProducer.InvalidateChunk;
begin
  if not FInvalidatingChunk then
    try
      FInvalidatingChunk := true;
      if Assigned( ChunkProvider ) and
         ChunkProvider.Prepared and
         not ChunkFromUser then
      begin
        inherited HTMLDoc.Clear;
        FChunkDate := now;
      end;
      FGenerationLevel := 0;
      FChunkFromProvider := false;
    finally
      FInvalidatingChunk := false;
    end;
end;

procedure TIB_CustomChunkProducer.CheckProvider( RequestPrepare: boolean );
begin
  if not Assigned( FChunkProvider ) then
    raise Exception.Create( 'Unassigned Chunk Provider' )
  else
  if RequestPrepare then
    ChunkProvider.Prepared := true;
end;

{$IFNDEF IBO_VCL60_OR_GREATER}
function TIB_CustomChunkProducer.HandleTag( const TagString: string;
                                                  TagParams: TStrings ): string;
const
  TagSymbols: array[TTag] of string =
    ('', 'LINK', 'IMAGE', 'TABLE', 'IMAGEMAP', 'OBJECT', 'EMBED');
var
  Tag: TTag;
begin
  Tag := High( TTag );
  while Tag >= Low( TTag ) do
  begin
    if ( Tag = tgCustom ) or
       ( CompareText( TagSymbols[Tag], TagString ) = 0 ) then
      Break;
    Dec( Tag );
  end;
  Result := '';
  DoTagEvent( Tag, TagString, TagParams, Result );
end;
{$ENDIF}

procedure TIB_CustomChunkProducer.DoTagEvent(       Tag: TTag;
                                              const TagString: string;
                                                    TagParams: TStrings;
                                                var ReplaceText: string );
var
  tmpField: TIB_Column;
  tmpDataset: TIB_Dataset;                                                
begin
  tmpField := nil;
  if ( TagParams.Count = 0 ) then
  begin
    tmpDataset := Dataset;
    while Assigned( tmpDataset ) and not Assigned( tmpField ) do
    begin
      tmpField := tmpDataset.FindField( TagString );
      if Assigned( tmpDataset.MasterSource ) then
        tmpDataset := tmpDataset.MasterSource.Dataset
      else
        Break;
    end;
  end;
  if Assigned( tmpField ) then
    ReplaceText := tmpField.DisplayText;
{$IFDEF IBO_VCL60_OR_GREATER}
  inherited DoTagEvent( Tag, TagString, TagParams, ReplaceText );
{$ELSE}
  if Assigned( FOnHTMLTag ) then
    FOnHTMLTag( Self, Tag, TagString, TagParams, ReplaceText );
{$ENDIF}
  if not Assigned( tmpField ) and
     ( Length( ReplaceText ) = 0 ) and
     ( Assigned( ChunkProvider )) and
     ( Assigned( ChunkProvider.FOnHtmlTag )) then
    ChunkProvider.FOnHtmlTag( Self, Tag, TagString, TagParams, ReplaceText );
end;

end.

