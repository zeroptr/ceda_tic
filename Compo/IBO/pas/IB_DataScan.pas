
{                                                                              }
{  IB_DataScan                                                                 }
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

{: This unit contains the TIB_DataScan component class.} 
unit
  IB_DataScan;

interface

uses
  Classes, SysUtils,

  IB_Constants,
  IB_Session,
  IB_Components,
  IB_Process;
//IB_Export
//IB_Script
//IB_DataPump

//IB_DataScan.PBL

type
TIB_DataScan = class;

{: This event is designed to give access to the internal cursor that is used
in order to perform the actual scanning of the data when cloning the dataset.}
TIB_AdjustCursorEvent = procedure( Sender: TIB_DataScan;
                                   ADataset: TIB_Dataset ) of object;
{: This is a base class that performs a scan of a dataset using an internal
cursor of its own. }
TIB_DataScan = class(TIB_Process)
private
  FIB_DataSource: TIB_DataSource;
  FIB_Cursor: TIB_Cursor;
  FCloneCursor: boolean;
  FAbortGen: integer;
  FOnAdjustCursor: TIB_AdjustCursorEvent;
  FBeforeFetchFirstRow: TIB_RowEvent;
  FAfterFetchLastRow: TIB_RowEvent;
  FAfterFetchRow: TIB_RowEvent;
  FAfterFetchEof: TIB_RowEvent;
  tmpAfterFetchRow: TIB_DatasetEvent;
  tmpAfterFetchEof: TIB_DatasetEvent;
  FOnCursorWasReset: TIB_DatasetEvent;
  function GetDataset: TIB_Dataset;
  procedure SetDataset( AValue: TIB_Dataset );
  procedure SysAfterCursorFetchRow( IB_Dataset: TIB_Dataset );
  procedure SysAfterCursorFetchEof( IB_Dataset: TIB_Dataset ); 
protected
  FSrcRow: TIB_Row;
  procedure PreparedChanged( ASender: TIB_StatementLink;
                             AStatement: TIB_Statement ); virtual;
  procedure SysInitialize; override;
  procedure SysFinalize; override;
  function SysWasCompleted: boolean; override; 
  procedure SysExecute( var IsDone: boolean ); override;
  function SysNeedToExecute: boolean; override; 
  procedure SysPrepare; override;
  procedure DoBeforeFetchFirstRow( ARow: TIB_Row ); virtual;
  procedure DoAfterFetchLastRow( ARow: TIB_Row ); virtual;
  procedure DoAfterFetchRow( ARow: TIB_Row ); virtual;
  procedure DoAfterFetchEof( ARow: TIB_Row ); virtual;
  procedure DoCursorWasReset( ADataset: TIB_Dataset ); virtual;
{ Protected Properties }
  property Cursor: TIB_Cursor read FIB_Cursor;
public
{: Reference to the dataset that is to be cloned or scanned.}
  property Dataset: TIB_Dataset read GetDataset write SetDataset;
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
  procedure ResetCursor;
{$IFDEF HELPSCAN}
published
{$ELSE}
public
{$ENDIF}

{: This determines whether or not the source cursor will be used directly or if
its dataset will be cloned into an internal cursor.
<br><br>
Cloning into an internal cursor is desirable when using a potentially very
large dataset and the source is a buffered dataset.
This way it will use a TIB_Cursor instead which will not buffer more
than one record at a time. So, no matter how large the dataset is it won't
use up a lot of memory.
<br><br>
It is necessary to set this to true when using Passive mode with buffered
datasets as the source.}   
  property CloneCursor: boolean read FCloneCursor
                                write FCloneCursor
                                default true;
{: This event gives access to the internal cursor that is used to perform
the data scan when the source dataset is cloned.
<br><br>
It could be used to make alterations to the cloned cursor's SQL statement.}
  property OnAdjustCursor: TIB_AdjustCursorEvent read FOnAdjustCursor
                                                 write FOnAdjustCursor;
{: This event gives a hook so that when the scanning is reset some action can
be taken in response.}                                                 
  property OnCursorWasReset: TIB_DatasetEvent read FOnCursorWasReset
                                              write FOnCursorWasReset;
{: Event in which an action can be taken before the first row of the data has
been fetched.}
  property BeforeFetchFirstRow: TIB_RowEvent read FBeforeFetchFirstRow
                                             write FBeforeFetchFirstRow;
{: Event in which an action can be taken after the last row of the data has
been fetched.
<br><br>
This event will be triggered even if there was an exception or if the
process was aborted.}
  property AfterFetchLastRow: TIB_RowEvent read FAfterFetchLastRow
                                           write FAfterFetchLastRow;
{: Event in which an action can be taken after a row of data has been fetched.}
  property AfterFetchRow: TIB_RowEvent read FAfterFetchRow write FAfterFetchRow;
{: Event in which an action can be taken once all data has been fetched.}
  property AfterFetchEof: TIB_RowEvent read FAfterFetchEof write FAfterFetchEof;
end;

implementation

constructor TIB_DataScan.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FIB_DataSource := TIB_DataSource.Create( Self );
  FIB_DataSource.OnPreparedChanged := PreparedChanged;
  FIB_Cursor := TIB_Cursor.Create( Self );
  FIB_Cursor.OnError := DoHandleError;
  FIB_Cursor.Name := 'Cursor';
  FCloneCursor := true;
  FPreventPassive := false;
end;

destructor TIB_DataScan.Destroy;
begin
  with FIB_Cursor do
    if Fetching then
      AbortFetching;
  Prepared := false;
  FIB_DataSource.OnPreparedChanged := nil;
  inherited Destroy;
end;

procedure TIB_DataScan.PreparedChanged( ASender: TIB_StatementLink;
                                        AStatement: TIB_Statement);
begin
  if not Assigned( AStatement ) or not AStatement.Prepared then
    Unprepare;
end;

procedure TIB_DataScan.SysPrepare;
begin
  if not Assigned( Dataset ) then
    raise EIB_Error.Create( E_NOT_PREPARED );
  Dataset.Prepare;
  if CloneCursor then
  begin
    with Cursor do
    begin
      IB_Connection := Dataset.IB_Connection;
      IB_Transaction := Dataset.IB_Transaction;
      AssignSQLWithSearch( Self.Dataset );
      ReadOnly := true;
      Active := false;
      InvalidateSQL;
      if Assigned( FOnAdjustCursor ) then
        FOnAdjustCursor( Self, Cursor );
      Prepare;
      FSrcRow := Fields;
    end;
  end
  else
  if Dataset is TIB_BDataset then
    FSrcRow := Dataset.BufferFields
  else
    FSrcRow := Dataset.Fields;
  inherited SysPrepare;
end;

procedure TIB_DataScan.ResetCursor;
begin
  if Prepared and Executing then
  begin
    if CloneCursor then
    begin
      Cursor.Close;
      Cursor.Open;
      DoCursorWasReset( Cursor );
    end
    else
    if Dataset is TIB_BDataset then
    begin
      Dataset.BufferFirst;
      DoCursorWasReset( Dataset );
    end
    else
    begin
      Dataset.Close;
      Dataset.Open;
      DoCursorWasReset( Dataset );
    end;
  end;
end;

procedure TIB_DataScan.DoCursorWasReset( ADataset: TIB_Dataset );
begin
  if Assigned( FOnCursorWasReset ) then FOnCursorWasReset( ADataset );
end;

procedure TIB_DataScan.SysInitialize;
begin
  inherited SysInitialize;
  if CloneCursor then
  begin
    Cursor.Close;
    FAbortGen := Cursor.FetchingAbortedGen;
  end
  else
  if Dataset is TIB_BDataset then
  begin
    FAbortGen := Dataset.FetchingAbortedGen;
  end
  else
  begin
    Dataset.Close;
    FAbortGen := Dataset.FetchingAbortedGen;
  end;
end;

procedure TIB_DataScan.SysFinalize;
begin
  inherited SysFinalize;
  if CloneCursor then
    Cursor.Close
  else
  if Dataset is TIB_BDataset then
  else
    Dataset.Close;
end;

function TIB_DataScan.SysWasCompleted: boolean;
begin
  if CloneCursor then
    Result := Cursor.Active and Cursor.Eof
  else
  if Dataset is TIB_BDataset then
    Result := Dataset.Active and Dataset.BufferEof
  else
    Result := Dataset.Active and Dataset.Eof;
end;

function TIB_DataScan.SysNeedToExecute: boolean;
begin
  if Passive then
  begin
    if CloneCursor then
      Result := Cursor.Active
    else
      Result := Dataset.Active;
  end
  else
    Result := inherited SysNeedToExecute;
end;

procedure TIB_DataScan.SysExecute( var IsDone: boolean );
var
  IsYielding: boolean;
  procedure InitClonedCursor;
  var
    ii: integer;
    tmpCol: TIB_Column;
  begin
    with Cursor do
      for ii := 0 to ParamCount - 1 do
        with Params[ ii ] do
        begin
          tmpCol := Self.Dataset.FindParam( FieldName );
          if Assigned( tmpCol ) and
             ( tmpCol.IsNull or
               tmpCol.IsBlob or
               tmpCol.IsArray or
               ( tmpCol.AsString <> AsString )) then
            Assign( tmpCol );
        end;
  end;
  procedure ProcessDataset( ADS: TIB_Dataset );
  begin
    with ADS do
    begin
      try
        tmpAfterFetchRow := AfterFetchRow;
        tmpAfterFetchEof := AfterFetchEof;
        AfterFetchRow := SysAfterCursorFetchRow;
        AfterFetchEof := SysAfterCursorFetchEof;
        if Passive then
        begin
          IsDone := false;
          if not Active then
          begin
            if CloneCursor then
              InitClonedCursor;
            DoBeforeFetchFirstRow( ADS.Fields );
            Open;
          end
          else
          if Eof then
            IsDone := true
          else
            Next;
        end
        else
        begin
          try
            if not IsYielding then
              BeginCallbackFreeze;
            try
              if CloneCursor then
                InitClonedCursor;
              DoBeforeFetchFirstRow( ADS.Fields );
              Open;
              if not Eof then
                FetchAll;
            finally
              DoAfterFetchLastRow( ADS.Fields );
            end;
            IsDone := true;
          finally
            if not IsYielding then
              EndCallbackFreeze;
          end;
        end;
      finally
        AfterFetchRow := tmpAfterFetchRow;
        AfterFetchEof := tmpAfterFetchEof;
        tmpAfterFetchRow := nil;
        tmpAfterFetchEof := nil;
        if FAbortGen <> ADS.FetchingAbortedGen then
          AbortExecuting;
      end;
    end;
  end;
begin
  IsYielding := Yield;
  if CloneCursor then
    ProcessDataset( Cursor )
  else
  if Dataset is TIB_BDataset then
  begin
    if Passive then
      raise Exception.Create( 'Passive mode not supported with buffered ' +
                              'datasets: Set CloneCursor to true instead' );
    DoBeforeFetchFirstRow( DataSet.BufferFields );
    try
      if not IsYielding then
        Dataset.BeginCallbackFreeze;
      try
        Dataset.FetchAll;
      finally
        if not IsYielding then
          Dataset.EndCallbackFreeze;
      end;
      if FAbortGen = Dataset.FetchingAbortedGen then
      begin
        DataSet.BufferFirst;
        while not Dataset.BufferEof and
              ( FAbortGen = Dataset.FetchingAbortedGen ) do
        begin
          DoAfterFetchRow( Dataset.BufferFields );
          Dataset.BufferNext;
        end;
        DoAfterFetchEof( Dataset.BufferFields );
      end;
    finally
      DoAfterFetchLastRow( Dataset.BufferFields );
    end;
    IsDone := true;
    if FAbortGen <> Dataset.FetchingAbortedGen then
      AbortExecuting;
  end
  else
    ProcessDataset( Dataset );
end;

procedure TIB_DataScan.SetDataset( AValue: TIB_Dataset );
begin
  FIB_DataSource.Dataset := AValue;
end;

function TIB_DataScan.GetDataset: TIB_Dataset;
begin
  Result := FIB_DataSource.Dataset;
end;

procedure TIB_DataScan.SysAfterCursorFetchRow( IB_Dataset: TIB_Dataset );
begin
  DoAfterFetchRow( IB_Dataset.Fields );
  if Assigned( tmpAfterFetchRow ) then tmpAfterFetchRow( IB_Dataset );
end;

procedure TIB_DataScan.SysAfterCursorFetchEof( IB_Dataset: TIB_Dataset );
begin
  DoAfterFetchEof( IB_Dataset.Fields );
  if Assigned( tmpAfterFetchEof ) then tmpAfterFetchEof( IB_Dataset );
end;

procedure TIB_DataScan.DoBeforeFetchFirstRow( ARow: TIB_Row );
begin
  if Assigned( FBeforeFetchFirstRow ) then FBeforeFetchFirstRow( ARow );
end;

procedure TIB_DataScan.DoAfterFetchLastRow( ARow: TIB_Row );
begin
  if Assigned( FAfterFetchLastRow ) then FAfterFetchLastRow( ARow );
end;

procedure TIB_DataScan.DoAfterFetchRow( ARow: TIB_Row );
begin
  if Assigned( FAfterFetchRow ) then FAfterFetchRow( ARow );
end;

procedure TIB_DataScan.DoAfterFetchEof( ARow: TIB_Row );
begin
  if Assigned( FAfterFetchEof ) then FAfterFetchEof( ARow );
end;

end.
