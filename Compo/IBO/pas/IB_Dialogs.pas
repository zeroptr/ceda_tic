
{                                                                              }
{  IB_Dialogs                                                                  }
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
  IB_Dialogs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,

  IB_Constants,
  IB_Components,
  IB_Monitor,
  IB_Profiler,
  IBF_Base;

// IB_Registration

type

TIB_BaseDialog = class;

TIB_InitDialog = procedure( Sender: TIB_BaseDialog;
                            ADialog: TfrmBase ) of object;

TIB_BaseDialog = class( TComponent )
private
  FCaption: string;
  FBaseKey: string;
  FBaseConnection: TIB_Connection;
  FBaseTransaction: TIB_Transaction;
  FOnInitDialog: TIB_InitDialog;
  procedure SetBaseConnection( AValue: TIB_Connection );
  procedure SetBaseTransaction( AValue: TIB_Transaction );
protected
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation ); override;
  function CreateBaseForm: TfrmBase; virtual;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); virtual;
  property BaseConnection: TIB_Connection read FBaseConnection
                                          write SetBaseConnection;
  property BaseTransaction: TIB_Transaction read FBaseTransaction
                                            write SetBaseTransaction;
  property OnInitDialog: TIB_InitDialog read FOnInitDialog write FOnInitDialog;
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
{: This method presents the dialog form using ShowModal and its result is
whether or not mrOK was returned.
<br><br>
If a modal form is undesirable then use the Show method which will launch a new
instance of the from in a non-modal state.}
  function Execute: boolean;
{: This method launces a new instance of the form and uses its Show method
to make it appear in a non-modal state. Each form uses a CloseAction of caFree
so that when the dialog is closed it will free itself automatically.
<br><br>
If a modal dialog is desired then use the Execute method.}
  procedure Show;
{: This method launces a new instance of the form if there isn't one already
created and uses its Show method to make it appear in a non-modal state. If
there is already an instance of the dialog it will Show that one instead of
creating a new one. Each form uses a CloseAction of caFree so that when the
dialog is closed it will free itself automatically.
<br><br>
If a modal dialog is desired then use the Execute method.}
  procedure ShowOnlyOne;
published
{: Most all IBO dialogs store and retreive settings to and from the system
registry. This property stores the registry key under which the settings are to
be saved.
<br><br>
If the Owner of the Dialog component is a TfrmBase form then it is possible to
have the dialog's form instance nest its registry entry in the registry entry
of the current form. Just preface it with a '\' character and it will append
the BaseKey of the dialog's owner before it when executed or showed.}
  property BaseKey: string read FBaseKey write FBaseKey;
{: This is the caption of the form that the dialog brings up.}
  property Caption: string read FCaption write FCaption;
end;

TIB_LookupDialog = class( TIB_BaseDialog )
private
  FPostOnClose: boolean;
  FPanelStates: TIB_DatasetStateSet;
  FMaxSearchEditWidth: integer;
  FLookupDataset: TIB_Dataset;
  FTrackGridRow: boolean;
  FTabMovesOut: boolean;
  FListBoxStyle: boolean;
  FStretchColumn: string;
  FRowSelect: boolean;
  procedure SetLookupDataset( AValue: TIB_Dataset );
protected
  procedure Notification( AComponent: TComponent;
                          Operation: TOperation ); override;
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
  constructor Create( AOwner: TComponent ); override;
published
  property ListBoxStyle: boolean read FListBoxStyle
                                write FListBoxStyle
                                default false;
  property LookupDataset: TIB_Dataset read FLookupDataset
                                      write SetLookupDataset;
  property MaxSearchEditWidth: integer read FMaxSearchEditWidth
                                       write FMaxSearchEditWidth
                                       default 300;
  property PanelStates: TIB_DatasetStateSet read FPanelStates
                                            write FPanelStates
                                            default [ dssSearch ];
  property PostOnClose: boolean read FPostOnClose
                                write FPostOnClose
                                default false;
  property StretchColumn: string read FStretchColumn
                                 write FStretchColumn;
  property TabMovesOut: boolean read FTabMovesOut
                                write FTabMovesOut
                                default true;
  property TrackGridRow: boolean read FTrackGridRow
                                 write FTrackGridRow
                                 default true;
  property RowSelect: boolean read FRowSelect
                              write FRowSelect
                              default false;
  property OnInitDialog;
end;

TIB_SQLDialog = class( TIB_BaseDialog )
private
  FSQL: TStrings;
  FParamValueLinks: TIB_StringProperty;
  procedure SetSQL( AValue: TStrings );
  procedure SetParamValueLinks( AValue: TIB_StringProperty );
protected
  property ParamValueLinks: TIB_StringProperty read FParamValueLinks
                                               write SetParamValueLinks;
  property SQL: TStrings read FSQL write SetSQL;
public
  constructor Create( AOwner: TComponent ); override;
  destructor Destroy; override;
end;

TIB_DSQLDialog = class( TIB_SQLDialog )
private
  FParams: boolean;
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
published
  property BaseConnection;
  property BaseTransaction;
  property Params: boolean read FParams write FParams;
  property SQL;
end;

TIB_MonitorDialog = class( TIB_BaseDialog )
private
  FMonitorGroups: TIB_MonitorGroupSet;
  FStatementGroups: TIB_StatementGroupSet;
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
  constructor Create( AOwner: TComponent ); override;
published
  property BaseConnection;
{
  property MonitorGroups: TIB_MonitorGroupSet
      read FMonitorGroups
     write FMonitorGroups
   default [ mgConnection, mgTransaction, mgStatement ];
  property StatementGroups: TIB_StatementGroupSet
      read FStatementGroups
     write FStatementGroups
   default [ sgPrepare, sgExecute, sgExecuteImmediate ];
}
end;

TIB_ProfilerDialog = class( TIB_BaseDialog )
private
  FProfilerGroups: TIB_ProfilerGroupSet;
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
  constructor Create( AOwner: TComponent ); override;
published
  property BaseConnection;
end;

TIB_BrowseDialog = class( TIB_BaseDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
published
  property BaseConnection;
  property BaseTransaction;
end;

TIB_ScriptDialog = class( TIB_BaseDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
published
  property BaseConnection;
  property BaseTransaction;
end;

TIB_MetadataDialog = class( TIB_BaseDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
published
  property BaseConnection;
  property BaseTransaction;
end;

TIB_DDL_ExtractDialog = class( TIB_BaseDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
published
  property BaseConnection;
  property BaseTransaction;
end;

TIB_EventsDialog = class( TIB_BaseDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
published
  property BaseConnection;
  property BaseTransaction;
end;

TIB_ExportDialog = class( TIB_SQLDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
published
  property BaseConnection;
  property BaseTransaction;
  property SQL;
end;

TIB_DataDumpDialog = class( TIB_BaseDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
published
  property BaseConnection;
  property BaseTransaction;
end;

TIB_DataPumpDialog = class( TIB_BaseDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
public
published
  property BaseConnection;
  property BaseTransaction;
end;

TIB_StatusDialog = class( TIB_BaseDialog )
private
protected
  function CreateBaseForm: TfrmBase; override;
  procedure InitializeBaseForm( ABaseFrm: TfrmBase ); override;
end;

implementation

uses
  IBF_Lookup, IBF_DSQL, IBF_Monitor, IBF_Profiler,
  IBF_Browse, IBF_Script, IBF_Export,
  IBF_DataDump, IBF_DataPump, IBF_Events, IBF_Status, IBF_DDL_Extract,
  IBF_Metadata;

constructor TIB_BaseDialog.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FBaseKey := '';
end;

destructor TIB_BaseDialog.Destroy;
begin
  BaseConnection := nil;
  BaseTransaction := nil;
  inherited Destroy;
end;

function TIB_BaseDialog.CreateBaseForm: TfrmBase;
begin
  Result := TFrmBase.Create( Self ); //Application );
end;

function TIB_BaseDialog.Execute: boolean;
var
  tmpFrm: TFrmBase;
begin
  tmpFrm := CreateBaseForm;
  try
    InitializeBaseForm( tmpFrm );
    Result := tmpFrm.ShowModal = mrOk;
  finally
    tmpFrm.Free;
  end;
end;

procedure TIB_BaseDialog.Show;
var
  tmpFrm: TFrmBase;
begin
  tmpFrm := CreateBaseForm;
  try
    InitializeBaseForm( tmpFrm );
  except
    tmpFrm.Free;
    raise;
  end;
  tmpFrm.Show;
end;

procedure TIB_BaseDialog.ShowOnlyOne;
var
  tmpFrm: TFrmBase;
  i: integer;
begin
  tmpFrm := nil;
  // if form already created then re-use it.
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TfrmBase then
    begin
      tmpFrm := TfrmBase(Components[i]);
      break;
    end;
  end;
  if tmpFrm = nil then
  begin
    tmpFrm := CreateBaseForm;
    try
      InitializeBaseForm( tmpFrm );
    except
      tmpFrm.Free;
      raise;
    end;
  end;
  tmpFrm.Show;
end;

procedure TIB_BaseDialog.SetBaseConnection( AValue: TIB_Connection );
begin
  if FBaseConnection <> AValue then
  begin
    FBaseConnection := AValue;
    if Assigned( FBaseConnection ) then
      FBaseConnection.FreeNotification( Self );
  end;
end;

procedure TIB_BaseDialog.SetBaseTransaction( AValue: TIB_Transaction );
begin
  if FBaseTransaction <> AValue then
  begin
    FBaseTransaction := AValue;
    if Assigned( AValue ) then
      AValue.FreeNotification( Self );
  end;
end;

procedure TIB_BaseDialog.Notification( AComponent: TComponent;
                                       Operation: TOperation );
begin
  if ( Operation = opRemove ) and ( AComponent = FBaseConnection ) then
    FBaseConnection := nil;
  if ( Operation = opRemove ) and ( AComponent = FBaseTransaction ) then
    FBaseTransaction := nil;
  inherited Notification( AComponent, Operation );
end;

procedure TIB_BaseDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  ABaseFrm.BaseConnection := BaseConnection;
  ABaseFrm.BaseTransaction := BaseTransaction;
  if Caption <> '' then
    ABaseFrm.Caption := Caption;
  if BaseKey <> '' then
  begin
    if ( BaseKey[1] = '\' ) and ( Owner is TfrmBase ) then
      ABaseFrm.BaseKey := ( Owner as TfrmBase ).BaseKey + BaseKey
    else
      ABaseFrm.BaseKey := BaseKey;
  end;
  if Assigned( OnInitDialog ) then
    OnInitDialog( Self, ABaseFrm );
end;

{------------------------------------------------------------------------------}

constructor TIB_LookupDialog.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FPostOnClose := false;
  FPanelStates := [ dssSearch ];
  FMaxSearchEditWidth := 300;
  FTrackGridRow := true;
  FTabMovesOut := true;
end;

function TIB_LookupDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmLookup.Create( Self );
end;

procedure TIB_LookupDialog.Notification( AComponent: TComponent;
                                         Operation: TOperation );
begin
  inherited Notification( AComponent, Operation );
  if ( Operation = opRemove ) and ( AComponent = FLookupDataset ) then
    FLookupDataset := nil;
end;

procedure TIB_LookupDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
var
  tmpFrm: TfrmLookup absolute ABaseFrm;
begin
  tmpFrm.PanelStates := PanelStates;
  tmpFrm.MaxSearchEditWidth := MaxSearchEditWidth;
  tmpFrm.grLookup.TrackGridRow := TrackGridRow;
  tmpFrm.grLookup.TabMovesOut := TabMovesOut;
  tmpFrm.grLookup.ListBoxStyle := ListBoxStyle;
  tmpFrm.grLookup.StretchColumn := StretchColumn;
  tmpFrm.grLookup.RowSelect := RowSelect;
  inherited InitializeBaseForm( ABaseFrm );
  tmpFrm.StateUponOpen := dssInactive;
  if Assigned( LookupDataset ) then
  begin
    tmpFrm.LookupDataset := LookupDataset;
    LookupDataset.ShowNearest( -1 );
    if Assigned( LookupDataset.KeyDataset ) then
      tmpFrm.StateUponOpen := LookupDataset.KeyDataset.State;
  end;
end;

procedure TIB_LookupDialog.SetLookupDataset( AValue: TIB_Dataset );
begin
  if FLookupDataset <> AValue then
  begin
    FLookupDataset := AValue;
    if Assigned( FLookupDataset ) then
      FLookupDataset.FreeNotification( Self );
  end;
end;

{------------------------------------------------------------------------------}

constructor TIB_SQLDialog.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FSQL := TIB_StringList.Create;
  FParamValueLinks := TIB_StringProperty.Create;
end;

destructor TIB_SQLDialog.Destroy;
begin
  FSQL.Free;
  FSQL := nil;
  FParamValueLinks.Free;
  FParamValueLinks := nil;
  inherited Destroy;
end;

procedure TIB_SQLDialog.SetSQL( AValue: TStrings );
begin
  FSQL.Assign( AValue );
end;

procedure TIB_SQLDialog.SetParamValueLinks( AValue: TIB_StringProperty );
begin
  FParamValueLinks.Assign( AValue );
end;

{------------------------------------------------------------------------------}

function TIB_DSQLDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmDSQL.Create( Self ); //Application );
end;

procedure TIB_DSQLDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmDSQL do begin
    cbParams.Checked := Self.Params;
    meDSQL.Lines.Assign( Self.SQL );
  end;
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}

constructor TIB_MonitorDialog.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FMonitorGroups := [ mgConnection, mgTransaction, mgStatement ];
  FStatementGroups := [ sgPrepare, sgExecute, sgExecuteImmediate ];
end;

function TIB_MonitorDialog.CreateBaseForm: TfrmBase;
begin
  if csDesigning in ComponentState then
    Result := TfrmMonitor.Create( Application )
  else
    Result := TfrmMonitor.Create( Self );
end;

procedure TIB_MonitorDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmMonitor do begin
    IB_Monitor.MonitorGroups := FMonitorGroups;
    IB_Monitor.StatementGroups := FStatementGroups;
  end;
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}

constructor TIB_ProfilerDialog.Create( AOwner: TComponent );
begin
  inherited Create( AOwner );
  FProfilerGroups := [ pgMemory, pgPages, pgRead, pgRecord, pgVersionRemoval ];
end;

function TIB_ProfilerDialog.CreateBaseForm: TfrmBase;
begin
  if csDesigning in ComponentState then
    Result := TfrmProfiler.Create( Application )
  else
    Result := TfrmProfiler.Create( Self );
end;

procedure TIB_ProfilerDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmProfiler do begin
    IB_Profiler.ProfilerGroups := FProfilerGroups;
  end;
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}

function TIB_BrowseDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmBrowse.Create( Self ); //Application );
end;

procedure TIB_BrowseDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmBrowse do begin
//    cbParams.Checked := Self.Params;
//    meDSQL.Lines.Assign( Self.SQL );
  end;
  inherited InitializeBaseForm( ABaseFrm );
  with ABaseFrm as TfrmBrowse do
    ReadInitialSettings;
end;

{------------------------------------------------------------------------------}

function TIB_ScriptDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmScript.Create( Self ); //Application );
end;

procedure TIB_ScriptDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmScript do begin
//    cbParams.Checked := Self.Params;
//    meDSQL.Lines.Assign( Self.SQL );
  end;
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}

function TIB_MetadataDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmMetadataExtract.Create( Self ); //Application );
end;

procedure TIB_MetadataDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmMetadataExtract do begin
  end;
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}

function TIB_DDL_ExtractDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmDDLExtract.Create( Self ); //Application );
end;

procedure TIB_DDL_ExtractDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmDDLExtract do begin
  end;
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}

function TIB_EventsDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmEvents.Create( Self ); //Application );
end;

procedure TIB_EventsDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmEvents do begin
//    cbParams.Checked := Self.Params;
//    meDSQL.Lines.Assign( Self.SQL );
  end;
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}

function TIB_ExportDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmExport.Create( Self ); //Application );
end;

procedure TIB_ExportDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  inherited InitializeBaseForm( ABaseFrm );
  with ABaseFrm as TfrmExport do
    if Self.SQL.Count > 0 then
      meSQL.Lines.Assign( Self.SQL );
end;

{------------------------------------------------------------------------------}

function TIB_DataDumpDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmDataDump.Create( Self ); //Application );
end;

procedure TIB_DataDumpDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmDataDump do begin
//    cbParams.Checked := Self.Params;
//    meDSQL.Lines.Assign( Self.SQL );
  end;
  inherited InitializeBaseForm( ABaseFrm );
  with ABaseFrm as TfrmDataDump do
    ReadInitialSettings;
end;

{------------------------------------------------------------------------------}

function TIB_DataPumpDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmDataPump.Create( Self ); //Application );
end;

procedure TIB_DataPumpDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  with ABaseFrm as TfrmDataPump do begin
//    cbParams.Checked := Self.Params;
//    meDSQL.Lines.Assign( Self.SQL );
  end;
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}

function TIB_StatusDialog.CreateBaseForm: TfrmBase;
begin
  Result := TfrmStatus.Create( Self );
end;

procedure TIB_StatusDialog.InitializeBaseForm( ABaseFrm: TfrmBase );
begin
  inherited InitializeBaseForm( ABaseFrm );
end;

{------------------------------------------------------------------------------}
(*
    wbWho: with TfrmWho.Create( Owner ) do begin
      BaseConnection := Self.BaseConnection;
      BaseKey := Self.FullKey + '\Who';
      Show;
    end;
    wbUsers: with TfrmUsers.Create( Owner ) do try
      csUsers.IB_Connection := Self.BaseConnection;
      ShowModal;
    finally
      Free;
    end;
*)

end.

