
{                                                                              }
{  IB_DataPump                                                                 }
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

{: This unit contains the TIB_DataPump component.}
unit
  IB_DataPump;

interface

uses
  Classes, SysUtils,

  IB_Header,
  IB_Session,
  IB_Constants,
  IB_Components,
  IB_Process,
  IB_DataScan;

// IBF_DataPump

type
TIB_DataPump = class;

{$I IB_DataPumpItems.INT}

{: This event type is used to get the instance of the data pump item to be
used to handle the class being requested.}
TIB_GetDPItemEvent = procedure (     Sender: TIB_DataPump;
                                     AIndex: integer;
                                     ADstLink: TIB_Column;
                                     AClass: string;
                                 var ADPItem: TIB_DPItemBase ) of object;
{: This event is used to get the names of available data pump item classes.}
TIB_GetDPItemClassesEvent = procedure ( Sender: TIB_DataPump;
                                        AClassList: TStrings ) of object;
{: This component is used to move data from a query into a prepared
statement with input parameters where each input parameter is handled as a
data pump item.
<br><br>
There are four modes of item handling:
<br><br>
<br>1) Direct binding to the same point as the source fetching buffers.
<br>2) Assigning using default type conversion.
<br>3) Customized item handling.
<br>4) AfterFetchRow event processing.
<br><br>
Use the AfterFetchRow event to finish assigning values to the input
parameters that need customized attention. Be sure to NOT refer to the
Dataset SrcDataset since it is NOT the actual dataset being used to feed the
process. It is using an internal cursor that is passed in as a parameter
the the event. You should refer to the Statement though.}
TIB_DataPump = class(TIB_DataScan)
private
  FIB_StatementLink: TIB_StatementLink;
  FDPItemList: TList;
  FDstLinks: TIB_StringList;
  FDPItemAttributes: TIB_StringList;
  FDPItemActions: TIB_StringList;
  FDstIsSingleton: boolean;
  FOnGetDPItem: TIB_GetDPItemEvent;
  FOnGetDPItemClasses: TIB_GetDPItemClassesEvent;
  FBeforeExecuteItems: TNotifyEvent;
  FAfterExecuteItems: TNotifyEvent;
  procedure SetDstLinks( AValue: TIB_StringList );
  procedure SetDPItemAttributes( AValue: TIB_StringList );
  procedure SetSrcDataset( AValue: TIB_Dataset );
  procedure SetDstStatement( AValue: TIB_Statement );
  function GetSrcDataset: TIB_Dataset;
  function GetDstStatement: TIB_Statement;
  function GetDstRow: TIB_Row;
  procedure SetDstIsSingleton( AValue: boolean );
protected
  procedure SysPrepare; override;
  procedure SysUnprepare; override;
  procedure SysInitialize; override;
  procedure SysExecute( var IsDone: boolean ); override;
  procedure SysFinalize; override;
  procedure DoBeforeFetchFirstRow( ARow: TIB_Row ); override;
  procedure DoAfterFetchLastRow( ARow: TIB_Row ); override;
  procedure DoAfterFetchRow( ARow: TIB_Row ); override;
  procedure SysItemInfoChange( Sender: TObject ); virtual;
  procedure SysInitItems; virtual;
  procedure SysPrepareItems; virtual;
  procedure SysExecuteItems; virtual;
  procedure SysClearItems; virtual;
  procedure DoGetDPItem(     AIndex: integer;
                             ADstLink: TIB_Column;
                             AClass: string;
                         var ADataPumpItem: TIB_DPItemBase ); virtual;
  procedure DoGetDefaultItem(     AIndex: integer;
                                  ADstLink: TIB_Column;
                                  AClass: string;
                              var ADataPumpItem: TIB_DPItemBase ); virtual;
  procedure DoGetDPItemClasses( AClassList: TStrings ); virtual;
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{: This method will populate a TStrings with the names of the classes
that are available to the data pump component.
<br><br>
To add in custom data pump item classes use the OnGetDPItemClasses event to
make them show up in this method call.}
  procedure GetDPItemClasses( AClassList: TStrings );
{: Row used to receive the stream of data.}
  property DstRow: TIB_Row read GetDstRow;
{: This property tells how the column assignments were made upon preparing
the process. Call Prepare and then analize the contents of this property to
make sure that everything lines up as expected.
<br><br>
It's format is a standard list of link entries with the columns of the input
row as the link entries.
<br><br>
There are four possible results:
<br><br>
DIRECT is the best which means that the output and input SQLData & SQLInd
pointers are referencing the same point in memory such that no processing
needs to occur between the fetch for the output row and the execute to submit
the data from the input row.
<br><br>
ASSIGNMENT is the next best which means that a DataPumpItem has been assigned
to handle the conversion of the data from the output buffer to the input
buffer. By default the Assign() method is used so that generic data type
conversions can automatically be performed. Specialized alternate classes of
TIB_DPItemBase can be used to handle non-standard data conversions. These
will also show up in this category.
<br><br>
UNASSIGNED means that it was unable to associate the input column with any
data in the output column. This either means that your DstLinks
property has a typo in it or that you intend to handle the data conversion
manually by writing an event handler in the AfterFetchRow event.
<br><br>
SKIPPED means that it is not possible to make any association for the
specified column and that it will not be processed. This will only happen if
you are using a SELECT statement that includes a readonly or COMPUTED column.}
  property DPItemActions: TIB_StringList read FDPItemActions;

{$I IB_Process.PBL}
{$I IB_DataScan.PBL}

published

{: If the destination is a dataset with a select statement it will normally
consider that it needs to perform an Insert but if the select is a singleton
then it should bind to the parameters and perform a singleton fetch upon
execution of each item.}
  property DstIsSingleton: boolean read FDstIsSingleton
                                   write SetDstIsSingleton
                                   default false;
{: This stores the input parameter names and the corresponding field
names from the output dataset that line up field to field.}
  property DstLinks: TIB_StringList read FDstLinks write SetDstLinks;
{: Special flags to create custom data handling like trimming the strings,
etc.
<br><br>
This will be enhanced and expanded in the future as I have need of more
routines. For now this property has not been implemented.}
  property DPItemAttributes: TIB_StringList read FDPItemAttributes
                                            write SetDPItemAttributes;
{: Reference to the Statement that is to be DataPumped into.
<br><br>
It is being kept generic so that a stored procedure or an INSERT statement
can be used to process the data stream.
<br><br>
It is possible to also use an }
  property DstStatement: TIB_Statement read GetDstStatement
                                       write SetDstStatement;
{: SrcDataset dataset to get the input data from.}
  property SrcDataset: TIB_Dataset read GetSrcDataset write SetSrcDataset;
{: Event hook just prior to processing the record from the source.}
  property BeforeExecuteItems: TNotifyEvent read FBeforeExecuteItems
                                            write FBeforeExecuteItems;
{: Event hook just after processing the record from the source.}
  property AfterExecuteItems: TNotifyEvent read FAfterExecuteItems
                                           write FAfterExecuteItems;
{: This event allows a custom designed class to be provided in order to
process a data pump item. Define your own classes in code and then make use
of them at run-time using this mechanism.}
  property OnGetDPItem: TIB_GetDPItemEvent
      read FOnGetDPItem
     write FOnGetDPItem;
{: This event is used to supply the names of classes available to the
datapump.}
  property OnGetDPItemClasses: TIB_GetDPItemClassesEvent
      read FOnGetDPItemClasses
     write FOnGetDPItemClasses;
end;

implementation

uses
  IB_Utils, IB_Parse;
  
{$I IB_DataPumpItems.IMP}

constructor TIB_DataPump.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIB_StatementLink := TIB_StatementLink.Create( Self );
  FIB_StatementLink.OnPreparedChanged := PreparedChanged;
  FDPItemList := TList.Create;
  FDstLinks := TIB_StringList.Create;
  FDstLinks.OnChange := SysItemInfoChange;
  FDstLinks.Duplicates := dupIgnore;
  FDPItemAttributes := TIB_StringList.Create;
  FDPItemAttributes.OnChange := SysItemInfoChange;
  FDPItemActions := TIB_StringList.Create;
end;

destructor TIB_DataPump.Destroy;
begin
  Prepared := false;
  FIB_StatementLink.OnPreparedChanged := nil;
  FDstLinks.Free;
  FDstLinks := nil;
  FDPItemAttributes.Free;
  FDPItemAttributes := nil;
  FDPItemActions.Free;
  FDPItemActions := nil;
  FDPItemList.Free;
  FDPItemList := nil;
  inherited Destroy;
end;

procedure TIB_DataPump.SetDstLinks( AValue: TIB_StringList );
begin FDstLinks.Assign( AValue ); end;
procedure TIB_DataPump.SetDPItemAttributes( AValue: TIB_StringList );
begin FDPItemAttributes.Assign( AValue ); end;
procedure TIB_DataPump.SetDstStatement( AValue: TIB_Statement );
begin FIB_StatementLink.Statement := AValue; end;
function TIB_DataPump.GetDstStatement: TIB_Statement;
begin Result := FIB_StatementLink.Statement; end;
procedure TIB_DataPump.SetSrcDataset( AValue: TIB_Dataset );
begin Dataset := AValue; end;
function TIB_DataPump.GetSrcDataset: TIB_Dataset;
begin Result := Dataset; end;

procedure TIB_DataPump.SetDstIsSingleton( AValue: boolean );
begin
  if DstIsSingleton <> AValue then
  begin
    if Prepared then
      raise Exception.Create( 'Cannot change while prepared' );
    FDstIsSingleton := AValue;
  end;
end;

function TIB_DataPump.GetDstRow: TIB_Row;
begin
  Result := nil;
  if Assigned( DstStatement ) then
    with DstStatement do
    begin
      case StatementType of
        stInsert,
        stUpdate,
        stDelete,
        stExecProcedure: Result := Params;
        stSelect,
        stSelectForUpdate: if DstIsSingleton then
          Result := Params
        else
          Result := Fields;
      end;
    end;
end;

procedure TIB_DataPump.SysPrepare;
begin
  inherited SysPrepare;
  if Assigned( DstStatement ) then
  begin
    with DstStatement do
    begin
      Prepared := true;
      if ( StatementType in [ stInsert,
                              stUpdate,
                              stDelete,
                              stExecProcedure ] ) or
         (( StatementType in [ stSelect,
                               stSelectForUpdate ] ) and
          ( DstStatement is TIB_Dataset )) then
      begin
        try
          SysInitItems;
          SysPrepareItems;
        except
          SysClearItems;
          raise;
        end;
      end
      else
        raise EIB_Error.Create( E_Invalid_DataPump_Statement );
    end;
  end
  else
    raise EIB_Error.Create( E_NOT_PREPARED );
end;

procedure TIB_DataPump.SysUnprepare;
begin
  SysClearItems;
  inherited SysUnprepare;
end;

procedure TIB_DataPump.SysItemInfoChange( Sender: TObject );
begin
  Unprepare;
end;

procedure TIB_DataPump.SysInitialize;
begin
  inherited SysInitialize;
  if ( DstStatement.StatementType in [ stSelect, stSelectForUpdate ] ) and
     not DstIsSingleton then
    ( DstStatement as TIB_Dataset ).Insert;
end;

procedure TIB_DataPump.SysFinalize;
begin
  if ( DstStatement.StatementType in [ stSelect, stSelectForUpdate ] ) and
     not DstIsSingleton then
    with DstStatement as TIB_Dataset do
    // Do a cancel here because the buffers were set into Insert mode ahead of
    // time but there isn't another record to insert because it is finished.
      if NeedToPost then
        Cancel;
  inherited SysFinalize;
end;

procedure TIB_DataPump.GetDPItemClasses( AClassList: TStrings );
begin
  if Assigned( AClassList ) then
    with AClassList do
    begin
      BeginUpdate;
      try
        Clear;
        Add( 'TRIMSPACES' );
        Add( 'SUBSTR' );
        Add( 'SPLITTER' );
        Add( 'PHONE' );
        Add( 'ZIP' );
        DoGetDPItemClasses( AClassList );
      finally
        EndUpdate;
      end;
    end;
end;

procedure TIB_DataPump.DoGetDPItemClasses( AClassList: TStrings );
begin
  if Assigned( FOnGetDPItemClasses ) then
    FOnGetDPItemClasses( Self, AClassList );
end;

procedure TIB_DataPump.DoGetDPItem(     AIndex: integer;
                                        ADstLink: TIB_Column;
                                        AClass: string;
                                    var ADataPumpItem: TIB_DPItemBase );
begin
  if Assigned( OnGetDPItem ) then
    OnGetDPItem( Self, AIndex, ADstLink, AClass, ADataPumpItem );
end;

procedure TIB_DataPump.DoGetDefaultItem(    AIndex: integer;
                                            ADstLink: TIB_Column;
                                            AClass: string;
                                        var ADataPumpItem: TIB_DPItemBase );
begin
  if AClass = 'SUBSTR' then
    ADataPumpItem := TIB_DPItemSubStr.Create( Self )
  else
  if AClass = 'SPLITTER' then
    ADataPumpItem := TIB_DPItemSplitter.Create( Self )
  else
  if AClass = 'TRIMSPACES' then
    ADataPumpItem := TIB_DPItemTrimSpaces.Create( Self )
  else
  if AClass = 'PHONE' then
    ADataPumpItem := TIB_DPItemPhone.Create( Self )
  else
  if AClass = 'ZIP' then
    ADataPumpItem := TIB_DPItemZIP.Create( Self )
  else
    ADataPumpItem := TIB_DPItemBase.Create( Self );
end;

procedure TIB_DataPump.SysInitItems;
var
  ii: integer;
  tmpItem: TIB_DPItemBase;
  DName: string;
  SName: string;
  CName: string;
  tmpSrc: TIB_Column;
  tmpDst: TIB_Column;
begin
  FDPItemActions.Clear;
  if Assigned( DstRow ) then with DstRow do
  begin
    for ii := 0 to ColumnCount - 1 do
    begin
      tmpDst := Columns[ ii ];
      DName := tmpDst.FullFieldName;
      if (( tmpDst.ReadOnly or tmpDst.Computed ) and ( RowType = rtField )) then
        FDPItemActions.LinkValues[ DName ] := 'SKIPPED'
      else
      if DPItemAttributes.LinkParamIsSet[DName, 'NOASSIGN'] then
        FDPItemActions.LinkValues[ DName ] := 'UNASSIGNED'
      else
      begin
        CName := DPItemAttributes.LinkParamValue[ DName, 'CLASS' ]; 
        SName := DstLinks.LinkValues[ DName ];
        if SName = '' then
          SName := DName;
        if FSrcRow.GetByName( SName, tmpSrc ) and
           not tmpDst.IsBlob and not tmpDst.IsArray and
           SQLTypesEqual( tmpDst.PSQLVAR.SQLType, tmpSrc.PSQLVAR.SQLType ) and
           ( tmpDst.BooleanTrue = tmpSrc.BooleanTrue ) and
           ( tmpDst.BooleanFalse = tmpSrc.BooleanFalse ) and
           ( DPItemAttributes.LinkValues[ DName ] = '' ) then
          FDPItemActions.LinkValues[ DName ] := 'DIRECT'
        else
        begin
          tmpItem := nil;
          try
            DoGetDPItem( ii, tmpDst, CName, tmpItem );
            if not Assigned( tmpItem ) then
              DoGetDefaultItem( ii, tmpDst, CName, tmpItem );
          except
            if Assigned( tmpItem ) then
              tmpItem.Free;
            raise;
          end;
          if Assigned( tmpItem ) then
            with tmpItem do
            begin
              FDstRow := Self.DstRow;
              FSrcRow := Self.FSrcRow;
              FDstColumn := tmpDst;
              FSrcColumn := tmpSrc;
              FDPItemList.Add( tmpItem );
            end
          else
            FDPItemActions.LinkValues[ DName ] := 'UNASSIGNED';
        end;
      end;
    end;
  end;
end;

procedure TIB_DataPump.SysPrepareItems;
var
  ii: integer;
begin
  with FDPItemList do
    for ii := 0 to Count - 1 do
      with TIB_DPItemBase(Items[ ii ]) do
      begin
        Prepare;
        DPItemActions.LinkValues[ DstColumn.FullFieldName ] :=
          Copy( ClassName, 11, MaxInt ) + ': ' + Attributes;
      end;
end;

procedure TIB_DataPump.SysExecuteItems;
var
  ii: integer;
begin
  with FDPItemList do
    for ii := 0 to Count - 1 do
      with TIB_DPItemBase(Items[ ii ]) do
        if Assigned( OnExecute ) then
          OnExecute( Self.Dataset )
        else
          Execute;
end;

procedure TIB_DataPump.SysClearItems;
var
  ii: integer;
begin
  FDPItemActions.Clear;
  with FDPItemList do
  begin
    for ii := 0 to Count - 1 do
      TIB_DPItemBase(Items[ ii ]).Free;
    Clear;
  end;
end;

procedure TIB_DataPump.DoBeforeFetchFirstRow( ARow: TIB_Row );
var
  ii: integer;
  DName: string;
  SName: string;
  tmpSrc: TIB_Column;
  tmpDst: TIB_Column;
begin
  if FSrcRow <> ARow then
    FSrcRow := ARow;
  if Assigned( DstRow ) then
    with DstRow do
    begin
      for ii := 0 to ColumnCount - 1 do
      begin
        tmpDst := Columns[ ii ];
        tmpDst.IsNull := false;
        DName := tmpDst.FullFieldName;
        SName := DstLinks.LinkValues[ DName ];
        if SName = '' then
          SName := DName;
        if FSrcRow.GetByName( SName, tmpSrc ) and
           DPItemActions.LinkParamIsSet[ DName, 'DIRECT' ] then
        begin
          if tmpDst.SQLLen <= tmpSrc.SQLLen then
          begin
            tmpDst.PSQLVAR.SQLInd := tmpSrc.PSQLVAR.SQLInd;
            tmpDst.PSQLVAR.SQLData := tmpSrc.PSQLVAR.SQLData;
          end
          else
          begin
            tmpSrc.PSQLVAR.SQLInd := tmpDst.PSQLVAR.SQLInd;
            tmpSrc.PSQLVAR.SQLData := tmpDst.PSQLVAR.SQLData;
          end;
        end;
      end;
    end;
  FSrcRow.CleanBuffers( true );
  with DstStatement.Params do
  begin
    SetDuplicateBufferPointers;
    CleanBuffers( true );
  end;
  inherited DoBeforeFetchFirstRow( ARow );
end;

procedure TIB_DataPump.DoAfterFetchLastRow( ARow: TIB_Row );
begin
  inherited DoAfterFetchLastRow( ARow ); 
  FSrcRow := nil;
  if Assigned( SrcDataset ) then
    SrcDataset.Fields.UpdateBufferPointers;
  if Assigned( Cursor ) then
    Cursor.Fields.UpdateBufferPointers;
  if Assigned( DstStatement ) then
    DstStatement.Params.UpdateBufferPointers;
end;

procedure TIB_DataPump.DoAfterFetchRow( ARow: TIB_Row );
var
  RaiseExc: boolean;
  tmpStrings: TIB_StringList;
begin
  RaiseExc := true;
  if Assigned( FBeforeExecuteItems ) then
    FBeforeExecuteItems( Self );
  try
    if FDPItemList.Count > 0 then
      SysExecuteItems;
    inherited DoAfterFetchRow( ARow );
    with DstStatement do
      case StatementType of
        stInsert,
        stUpdate,
        stDelete,
        stExecProcedure: Execute;
        stSelect,
        stSelectForUpdate: with DstStatement as TIB_Dataset do
        if DstIsSingleton then
        begin
          First;
          KillCursor;
        end
        else
        begin
          Post;
          Insert;
        end;
      end;
  except
    on E: Exception do
    begin
      if E is EIB_ISCError then
        raise
      else
      begin
        tmpStrings := TIB_StringList.Create;
        tmpStrings.Text := e.Message;
        try
          DoHandleError( Self, 0, tmpStrings, nil, 0, nil, nil, RaiseExc );
        finally
          tmpStrings.Free;
        end;
        if RaiseExc then
          raise;
      end;
    end;
  end;
  if RaiseExc and Assigned( FAfterExecuteItems ) then
    FAfterExecuteItems( Self );
end;

procedure TIB_DataPump.SysExecute( var IsDone: boolean );
var
  tmpBool: boolean;
begin
  DstStatement.CheckTransaction( true );
  if Passive then
    inherited SysExecute( IsDone )
  else
  begin
    with DstStatement.IB_Transaction do
    begin
      tmpBool := AutoCommit and not InTransaction and not TransactionIsActive;
      if tmpBool then
        StartTransaction;
      try
        inherited SysExecute( IsDone );
        if tmpBool then
          CommitRetaining;
      except
        if tmpBool then
          RollbackRetaining;
        raise;
      end;
    end;
  end;
end;

end.
