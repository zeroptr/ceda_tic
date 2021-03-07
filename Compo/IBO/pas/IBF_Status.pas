{                                                                              }
{ IBF_Status                                                                   }
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
{  Original Author: Goeff Worboys                                              }
{                                                                              }
// A form showing various statistics and states of IBO objects within an
// application.  Note that this form builds its own list of objects for
// the application - where it could have used the existing lists for the
// default application TIB_Session component.  This is done for two reasons...
//  1. It is possible to add other non-ibo components into the code
//     created here, potentially expanding the usefulness of the form.
//  2. The summary section shows the counts from the TIB_Session.DefaultSession
//     which can be used as a cross-reference check.  Differences may
//     highlight the use of alternative sessions.
//
// The form is not derived from TfrmBase in order to minimise its impact upon
// the reported state information.
//
// The form intentionally collects all the state information in a single hit.
// Whereas conceivably it could refresh the state every time a tree node is
// selected.  However I have not setup any monitoring for the destruction or
// creation of the monitored class, which means that the references used within
// the monitor may not be valid after initialisation.  Also, the all-at-once
// approach allows you to collect the entire state at a point in time and
// then browse this information at your leisure.
//
// If you want to add additional information to the status form the following
// guidelines may help...
//
// * If you want to add additional information to existing class details
//   find the appropriate TInteresting*.BuildState function in the
//   implementation and add the extra state information to the StateStrs
//   property. (Add the state in the form  'Property=Value')
//   Existing monitored classes include...
//       TInterestingSummary - special case for summary application data
//       TInterestingForm  - for TCustomForm modules
//       TInterestingDataModule - for TDataModule modules
//       TInterestingConnection - for TIB_Connection
//       TInterestingTransaction - for TIB_Transaction
//       TInterestingStatement - for TIB_Statement
//       TInterestingDataSource - for TIB_DataSource
//
// * If you want to add a whole new class of items to the monitor you need
//   to...
//      1. Create a derivation of TInterestingItem in the implementation and
//         fill-out the the ListTitle, AddInterests and BuildState functions
//         appropriately.  (Use TInterestingConnection or another of the
//         existing classes for examples).  Preferrably do not use the
//         TInterestingSummary, TInterestingForm or TInterestingDataModules
//         as examples since these tend to be special cases.)
//         ListTitle - is used to give tree label for a list of classes
//                   eg. '[ Connections ]'
//         AddInterests - is used to define additional branches to the parent
//                   node given as the parameter.  For example,
//                   TInterestingTransaction adds a list of transactions and
//                   a list of datasets relating to the connection.
//                   Be careful not to introduce recursive relationships
//                   when adding interests.
//         BuildState - is used to add the state information to a stringlist
//                   ready for display in the StateGrid when then item
//                   is selected.
//      2. Add an additional PAIR of class definitions to the
//         InterestingClasses global variable.  The first is class identity
//         of the class you want to monitor, the second is the TInteresting*
//         class that you created in step 1.
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IBF_Status;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ComCtrls, ExtCtrls, StdCtrls, Buttons, IBF_Base, IB_Components,
  IB_ConnectionSource, IB_TransactionSource;

type
  TfrmStatus = class(TfrmBase)
    BackingPnl: TPanel;
    StateTreePnl: TPanel;
    StateTree: TTreeView;
    GridPnl: TPanel;
    StateGrid: TStringGrid;
    Splitter1: TSplitter;
    ButtonPnl: TPanel;
    RefreshBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure StateTreeChange(Sender: TObject; Node: TTreeNode);
    procedure RefreshBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StateTreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StateTreeKeyPress(Sender: TObject; var Key: Char);
    procedure btApplyClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FFirstShow: boolean;
    FInteresting: TList;
    procedure AddInterestBranch( PNode: TTreeNode; IClass: TClass );
    procedure AddInterestChildren( PNode: TTreeNode; AOwner: TComponent );
    function GetInterestObject( AComp: TComponent ): TObject;
    procedure RefreshStateGrid;
    procedure CollectInterestingItems;
    function GetInterestClass( AComp: TComponent ): TClass;
    procedure ClearInterestingItems;
  public
    { Public declarations }
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure Refresh;
  end;

var
  frmStatus: TfrmStatus;

implementation

{$R *.DFM}

uses
  IB_Constants, IB_Session,
  IB_SessionProps;

type

    TInterestingItem = class( TObject )
    public
        // no point in hiding this stuff behind private/protected
        // since it is private to this unit anyway...
        StatusForm: TfrmStatus;
        Component: TComponent;
        Module: TComponent;
        StateStrs: TStringList;
        destructor Destroy; override;
        procedure Init( AForm: TfrmStatus; AComp, AModule: TComponent );
        class function ListTitle: string; virtual;
        procedure AddInterests( PNode: TTreeNode ); virtual;
        procedure BuildState; virtual;
        procedure AddSummaryStateItems( AModule: TComponent );
    end;

    TInterestingSummary = class( TInterestingItem )
    public
        class function ListTitle: string; override;
        procedure AddInterests( PNode: TTreeNode ); override;
        procedure BuildState; override;
    end;

    TInterestingForm = class( TInterestingItem )
    public
        class function ListTitle: string; override;
        procedure AddInterests( PNode: TTreeNode ); override;
        procedure BuildState; override;
    end;

    TInterestingDataModule = class( TInterestingItem )
    public
        class function ListTitle: string; override;
        procedure AddInterests( PNode: TTreeNode ); override;
        procedure BuildState; override;
    end;

    TInterestingConnection = class( TInterestingItem )
    public
        class function ListTitle: string; override;
        procedure AddInterests( PNode: TTreeNode ); override;
        procedure BuildState; override;
    end;

    TInterestingTransaction = class( TInterestingItem )
    public
        class function ListTitle: string; override;
        procedure AddInterests( PNode: TTreeNode ); override;
        procedure BuildState; override;
    end;

    TInterestingStatement = class( TInterestingItem )
    public
        class function ListTitle: string; override;
        procedure AddInterests( PNode: TTreeNode ); override;
        procedure BuildState; override;
    end;

    TInterestingDataSource = class( TInterestingItem )
    public
        class function ListTitle: string; override;
        procedure AddInterests( PNode: TTreeNode ); override;
        procedure BuildState; override;
    end;


const

    InterestingClasses: array [1..12] of TClass =
        (TCustomForm, TInterestingForm,
         TDataModule, TInterestingDataModule,
         TIB_Connection, TInterestingConnection,
         TIB_Transaction, TInterestingTransaction,
         TIB_Statement, TInterestingStatement,
         TIB_DataSource, TInterestingDataSource );

    // State Grid Constant strings
    sgcSummary = 'Summary';
    sgcDefault = 'Default';
    sgcReference = 'Reference';
    sgcLastRefresh = 'Last Refresh';
    sgcProperty = 'Property';
    sgcName = 'Name';
    sgcInstance = 'Instance';
    sgcTotal = 'Total';
    sgcActive = 'Active';
    sgcStarted = 'Started';
    sgcConnected = 'Connected';
    sgcVisible = 'Visible';
    sgcData = 'Data';
    sgcMaxBuf = 'Max_Buffer';
    sgcOAT = 'OAT';
    sgcComponent = 'Component';
    sgcClass = 'Class';
    sgcOwner = 'Owner';
    sgcForms = 'Forms';
    sgcSession = 'Session';
    sgcDataModules = 'DataModules';
    sgcConnections = 'Connections';
    sgcTransactions = 'Transactions';
    sgcDatasets = 'Datasets';
    sgcDataSources = 'DataSources';
    sgcStatements = 'Statements';
    sgcDataLinks = 'Data Links';
    sgcConnection = 'Connection';
    sgcTransaction = 'Transaction';
    sgcDataset = 'Dataset';
    sgcDataSource = 'DataSource';
    sgcStatement = 'Statement';
    sgcNil = '_nil_ ';
    sgcNoName = '_unnamed_';
    sgcDays = 'Days';
    sgcBuffer = 'Buffer';
    sgcServer = 'Server';
    sgcPath = 'Path';
    sgcProtocol = 'Protocol';
    sgcLocal = 'Local';
    sgcNetBEUI = 'NetBEUI';
    sgcTCPIP = 'TCP/IP';
    sgcNovell = 'Novell';
    sgcUsername = 'Username';
    sgcIBObjects = 'IBObjects';
    sgcVersion = 'Version';
    sgcPageSize = 'Page Size';
    sgcSweepInterval = 'Sweep Interval';
    sgcIsolation = 'Isolation';
    sgcCommitted = 'Read-Committed';
    sgcConcurrency = 'Concurrency/Snapshot';
    sgcConsistency = 'Consistency/Exclusive';
    sgcPostPendingCount = 'Post Pending Count';
    sgcPaused = 'Paused';
    sgcPauseDisabled = 'Pause Disabled';
    sgcAutoCommit = 'AutoCommit';
    sgcTrue = 'True';
    sgcFalse = 'False';
    sgcState = 'State';
    sgcNone = 'None';
    sgcUnknown = 'Unknown';
    sgcInactivePending = 'InactivePending';
    sgcInactive = 'Inactive';
    sgcActivePending = 'ActivePending';
    sgcCommitRetainingPending = 'CommitRetainingPending';
    sgcCommitPending = 'CommitPending';
    sgcCommitRefreshPending = 'CommitRefreshPending';
    sgcRollbackRetainingPending = 'RollbackRetainingPending';
    sgcRollbackPending = 'RollbackPending';
    sgcRollbackRefreshPending = 'RollbackRefreshPending';
    sgcTimeActive = 'Time Active';
    sgcPrepared = 'Prepared';
    sgcSearch = 'Search';
    sgcBrowse = 'Browse';
    sgcEdit = 'Edit';
    sgcInsert = 'Insert';
    sgcDelete = 'Delete';
    sgcCompiler = 'Compiler';
    sgcStmtHandle = 'Statement Handle';


function GetTrueFalseText( AVal: boolean ): string;
begin
if AVal then
    Result := sgcTrue
else Result := sgcFalse;
end;


function GetIntervalString( Interval: TDateTime ): string;
begin
Result := '';
if Interval > 0 then begin
    if Int(Interval) >= 1 then begin
        Result := FloatToStr(Int(Interval)) + '+';
        end;
    Interval := 24 * Frac(Interval);
    Result := Result + FloatToStr(Int(Interval)) + ':';
    Interval := 60 * Frac(Interval);
    Result := Result + FloatToStr(Int(Interval)) + ':';
    Interval := 60 * Frac(Interval);
    Result := Result + FloatToStr(Int(Interval));
    end;
end;

function GetComponentDesc( Comp: TComponent ): string;
begin
if Comp = nil then begin
    Result := sgcNil;
    end
else begin
    if Comp.Name = '' then begin
        Result := '  (' + Comp.ClassName + ')';
        end
    else Result := Comp.Name;
    end;
end;

function GetComponentDescEx( Comp: TComponent ): string;
begin
if Comp = nil then begin
    Result := sgcNil;
    end
else begin
    Result := GetComponentDesc( Comp )  + ': ' + Comp.ClassName;
    end;
end;

function GetComponentNamePath( Comp: TComponent ): string;
var
    tmpName: string;

    procedure GetNameRecurs( AComp: TComponent );
    begin
    // Only gather names up to owner form/datamodule
    if not( (AComp is TCustomForm) or (AComp is TDataModule)
        or (AComp.Owner = nil) ) then begin
        GetNameRecurs( AComp.Owner );
        tmpName := tmpName + '.';
        end;
    if AComp.Name = '' then
        tmpName := tmpName + '(' + AComp.ClassName + ')'
    else tmpName := tmpName + AComp.Name;
    end;

begin
if Comp = nil then begin
    Result := sgcNil;
    end
else begin
    tmpName := '';
    GetNameRecurs( Comp );
    if tmpName = '' then
        Result := sgcNoName
    else Result := tmpName;
    end;
end;


function GetComponentIdentity( Comp: TComponent; WithName: boolean ): string;
begin
  if Comp = nil then
  begin
    Result := sgcNil;
  end
  else
  begin
    Result := '$' + IntToHex( integer(Comp), 8 );
    if WithName then
    begin
      if Comp.Name = '' then
        Result := Result + ' (' + sgcNoName + ')'
      else
        Result := Result + ' (' + Comp.Name + ')';
    end;
  end;
end;



destructor TInterestingItem.Destroy;
begin
if StateStrs <> nil then
    StateStrs.Free;
inherited;
end;

procedure TInterestingItem.Init( AForm: TfrmStatus; AComp, AModule: TComponent );
begin
  StatusForm := AForm;
  Component := AComp;
  Module := AModule;
  if StateStrs = nil then
    StateStrs := TStringList.Create
  else
    StateStrs.Clear;
end;

class function TInterestingItem.ListTitle: string;
begin
  Result := '[?]';
end;

procedure TInterestingItem.AddInterests( PNode: TTreeNode );
begin
// do nothing at lowest level
end;

procedure TInterestingItem.BuildState;
begin
// Component class...
  if Component <> nil then
  begin
    StateStrs.Add( sgcName + '=' + GetComponentDesc( Component ) );
    StateStrs.Add( sgcClass + '=' + Component.ClassName +
        '  (' + sgcInstance + '=' + GetComponentIdentity(Component,false) + ')' );
    StateStrs.Add( sgcOwner + '=' + GetComponentDescEx(Component.Owner) );
    if Component is TIB_Component then
    begin
      StateStrs.Add( sgcSession + '=' +
        GetComponentIdentity( TIB_Component(Component).IB_Session, true) );
    end;
  end;
end;

procedure TInterestingItem.AddSummaryStateItems( AModule: TComponent );
var
    i: integer;
    FTot, FAct, DMTot: integer;
    CTot, CAct: integer;
    TTot, TAct: integer;
    OAT: TDateTime;
    STot, SAct: integer;
    DTot, DAct, DMaxBuf: integer;
    DSTot, DSLnk: integer;
    tmpComp: TComponent;
begin
  inherited;
  FTot := 0; FAct := 0;
  DMTot := 0;
  CTot := 0; CAct := 0;
  TTot := 0; TAct := 0; OAT := 0;
  STot := 0; SAct := 0;
  DTot := 0; DAct := 0; DMaxBuf := 0;
  DSTot := 0;  DSLnk := 0;
  with StatusForm do
  begin
    for i := 0 to FInteresting.Count - 1 do
    begin
      if (FInteresting.Items[i] <> nil) and
          (TInterestingItem(FInteresting.Items[i]).Component <> nil) and
          ((TInterestingItem(FInteresting.Items[i]).Module = AModule) or
          (AModule = nil) ) then
      begin
        tmpComp := TInterestingItem(FInteresting.Items[i]).Component;
        if tmpComp is TCustomForm then
        begin
          Inc(FTot);
          if TCustomForm(tmpComp).Visible then
              Inc(FAct);
        end
        else
        if tmpComp is TDataModule then
        begin
          Inc(DMTot);
        end
        else
        if tmpComp is TIB_Connection then
        begin
          Inc(CTot);
          if TIB_Connection(tmpComp).Connected then
              Inc(CAct);
        end
        else
        if tmpComp is TIB_Transaction then
        begin
          Inc(TTot);
          if TIB_Transaction(tmpComp).Started then
              Inc(TAct);
          if TIB_Transaction(tmpComp).TimeActive > OAT then
              OAT := TIB_Transaction(tmpComp).TimeActive;
        end
        else
        if tmpComp is TIB_Dataset then
        begin
          Inc(DTot);
          if TIB_Dataset(tmpComp).Active then
              Inc(DAct);
          if TIB_Dataset(tmpComp).BufferRowCount > DMaxBuf then
              DMaxBuf := TIB_Dataset(tmpComp).BufferRowCount;
        end
        else
        if tmpComp is TIB_Statement then
        begin
          Inc(STot);
          if TIB_Statement(tmpComp).Active then
              Inc(SAct);
        end
        else
        if tmpComp is TIB_DataSource then
        begin
          Inc(DSTot);
          Inc(DSLnk, (TIB_DataSource(tmpComp).DataLinkCount) );
        end;
      end;
    end;
  end;

  StateStrs.Add( sgcConnections + '=' +
      IntToStr(CTot) + ' (' + sgcConnected + '=' + IntToStr(CAct) + ')' );

  StateStrs.Add( sgcTransactions + '=' +
      IntToStr(TTot) + ' (' + sgcStarted + '=' + IntToStr(TAct) +
      ')  OAT=' + GetIntervalString( OAT ) );

  StateStrs.Add( sgcDatasets + '=' +
      IntToStr(DTot) + ' (' + sgcActive + '=' + IntToStr(DAct) +
      ')  Max_Buffer=' + IntToStr( DMaxBuf ) );

  StateStrs.Add( sgcStatements + '=' +
      IntToStr(STot) + ' (' + sgcActive + '=' + IntToStr(SAct) + ')' );

  StateStrs.Add( sgcDataSources + '=' +
      IntToStr(DSTot) + ' (' + sgcDataLinks + '=' + IntToStr(DSLnk) + ')' );


// NB. Function is called by summary and form/datamodule derivations.
// So checking for AModule = nil means that we ONLY display the
// following information when called by the summary.
  if AModule = nil then
  begin
    StateStrs.Add( sgcForms + '=' +
        IntToStr(FTot) + ' (' + sgcVisible + '=' + IntToStr(FAct) + ')' );
    StateStrs.Add( sgcDataModules + '=' + IntToStr(DMTot) );
  end;

  StateStrs.Add( sgcLastRefresh + '=' + DateTimeToStr( now ) );

  if AModule = nil then
  begin
    // Add a divider to separate out the following cross reference details
    StateStrs.Add( '- - - - -' + '=' + '- - - - -' );
    // The cross-check counts with the session lists, looking for descrepencies
    // (possibly alternative session have been created).
    StateStrs.Add( sgcDefault + ' ' + sgcSession + '=' +
        GetComponentIdentity(StatusForm.csBase.IB_Session, true) );
    StateStrs.Add( sgcSession + ' ' + sgcConnections + '=' +
        IntToStr(StatusForm.csBase.IB_Session.Session_Connections.Count) );
    StateStrs.Add( sgcSession + ' ' + sgcTransactions + '=' +
        IntToStr(StatusForm.csBase.IB_Session.Session_Transactions.Count) );
    StateStrs.Add( sgcSession + ' ' + sgcDatasets + '=' +
        IntToStr(StatusForm.csBase.IB_Session.Session_Datasets.Count) );
    StateStrs.Add( sgcSession + ' ' + sgcStatements + '=' +
        IntToStr(StatusForm.csBase.IB_Session.Session_Statements.Count -
        StatusForm.csBase.IB_Session.Session_Datasets.Count) );
    StateStrs.Add( sgcSession + ' ' + sgcDataSources + '=' +
        IntToStr(StatusForm.csBase.IB_Session.Session_DataSources.Count) );
    StateStrs.Add( sgcSession + ' ' + sgcDataLinks + '=' +
        IntToStr(StatusForm.csBase.IB_Session.Session_DataLinks.Count) );
  end;
end;

class function TInterestingSummary.ListTitle: string;
begin
  Result := '< ' + sgcSummary + ' >';
end;

procedure TInterestingSummary.AddInterests( PNode: TTreeNode );
begin
  inherited;
  StatusForm.AddInterestBranch( PNode, TInterestingForm );
  StatusForm.AddInterestBranch( PNode, TInterestingDataModule );
  StatusForm.AddInterestBranch( PNode, TInterestingConnection );
  StatusForm.AddInterestBranch( PNode, TInterestingTransaction );
  StatusForm.AddInterestBranch( PNode, TInterestingStatement );
end;

procedure TInterestingSummary.BuildState;
begin
  inherited;
  AddSummaryStateItems( nil );
  // Add a divider to separate out the following version information
  StateStrs.Add( '- - - - -' + '=' + '- - - - -' );
  StateStrs.Add( sgcIBObjects + ' ' + sgcVersion + '=' +
      IB_Version_Major + '.' + IB_Version_Minor + '.' +
      IB_Version_Build + IB_VERSION_SUB_RELEASE );
  {$IFDEF VER80}
  StateStrs.Add( sgcCompiler + '=Delphi v1.0' );
  {$ENDIF}
  {$IFDEF VER90}
  StateStrs.Add( sgcCompiler + '=Delphi v2.0' );
  {$ENDIF}
  {$IFDEF VER93}
  StateStrs.Add( sgcCompiler + '=C++Builder v1.0' );
  {$ENDIF}
  {$IFDEF VER100}
  StateStrs.Add( sgcCompiler + '=Delphi v3.0' );
  {$ENDIF}
  {$IFDEF VER110}
  StateStrs.Add( sgcCompiler + '=C++Builder v3.0' );
  {$ENDIF}
  {$IFDEF VER120}
  StateStrs.Add( sgcCompiler + '=Delphi v4.0' );
  {$ENDIF}
  {$IFDEF VER125}
  StateStrs.Add( sgcCompiler + '=C++Builder v4.0' );
  {$ENDIF}
  {$IFDEF VER130}
  StateStrs.Add( sgcCompiler + '=Delphi v5.0' );
  {$ENDIF}
  {$IFDEF VER135}
  //??? Maybe ...
  StateStrs.Add( sgcCompiler + '=C++Builder v5.0' );
  {$ENDIF}
end;

class function TInterestingForm.ListTitle: string;
begin
  Result := '[ ' + sgcForms + ' ]';
end;

procedure TInterestingForm.AddInterests( PNode: TTreeNode );
begin
  inherited;
end;

procedure TInterestingForm.BuildState;
begin
inherited;
AddSummaryStateItems( Component );
end;

class function TInterestingDataModule.ListTitle: string;
begin
Result := '[ ' + sgcDataModules + ' ]';
end;

procedure TInterestingDataModule.AddInterests( PNode: TTreeNode );
begin
inherited;
end;

procedure TInterestingDataModule.BuildState;
begin
inherited;
AddSummaryStateItems( Component );
end;

class function TInterestingConnection.ListTitle: string;
begin
// Title to be used in the state tree
Result := '[ ' + sgcConnections + ' ]';
end;

procedure TInterestingConnection.AddInterests( PNode: TTreeNode );
var
    tmpNode: TTreeNode;
    tmpInterest: TInterestingItem;
    i, Cnt: integer;
begin
inherited;
// Add a list of the transactions associated with this connection...
tmpNode := StatusForm.StateTree.Items.AddChild( PNode, TInterestingTransaction.ListTitle );
Cnt := 0;
// Cycle through the connection transactions collecting references to the
// TInteresting* derivation that has already been created for the instance.
with Component as TIB_Connection do begin
    for i := 0 to TransactionCount - 1 do begin
        tmpInterest := TInterestingItem(StatusForm.GetInterestObject(Transactions[i]));
        if tmpInterest <> nil then // check for instance of an unowned transaction
            StatusForm.StateTree.Items.AddChildObject( tmpNode,
                GetComponentDesc(tmpInterest.Component), tmpInterest );
        Inc( Cnt );
        end;
    end;
// If no transactions were found then delete the list title node
if Cnt <= 0 then
    tmpNode.Delete;
// Add a list of the statements associated with this connection...
tmpNode := StatusForm.StateTree.Items.AddChild( PNode, TInterestingStatement.ListTitle );
Cnt := 0;
// Cycle through the connection statements collecting references to the
// TInteresting* derivation that has already been created for the instance.
with Component as TIB_Connection do begin
    for i := 0 to StatementCount - 1 do begin
        tmpInterest := TInterestingItem(StatusForm.GetInterestObject(Statements[i]));
        if tmpInterest <> nil then // check for instance of an unowned transaction
            StatusForm.StateTree.Items.AddChildObject( tmpNode,
                GetComponentDesc(tmpInterest.Component), tmpInterest );
        Inc( Cnt );
        end;
    end;
// If no statements were found then delete the list title node
if Cnt <= 0 then
    tmpNode.Delete;
end;

procedure TInterestingConnection.BuildState;
var
    i: integer;
    Tot, Act, MaxBuf: integer;
    OAT, tmpAT: TDateTime;
    STTot, STAct: integer;
begin
// Add standard properties first
inherited;
// Then add Connection specific state information
with Component as TIB_Connection do
begin
    StateStrs.Add( sgcConnected + '=' + GetTrueFalseText( Connected ) );
    StateStrs.Add( sgcServer + '=' + Server );
    StateStrs.Add( sgcPath + '=' + Path );
    case Protocol of
        cpLocal:
            StateStrs.Add( sgcProtocol + '=' + sgcLocal );
        cpNetBEUI:
            StateStrs.Add( sgcProtocol + '=' + sgcNetBEUI );
        cpTCP_IP:
            StateStrs.Add( sgcProtocol + '=' + sgcTCPIP );
        cpNovell:
            StateStrs.Add( sgcProtocol + '=' + sgcNovell );
    else
        StateStrs.Add( sgcProtocol + '=' + sgcUnknown );
        end;
    StateStrs.Add( sgcUsername + '=' + Username );
    StateStrs.Add( sgcVersion + '=' + Version );
    StateStrs.Add( sgcPageSize + '=' + IntToStr(PageSize) );
    StateStrs.Add( sgcSweepInterval + '=' + IntToStr(SweepInterval) );
    // Transactions...
    Tot := 0;  Act := 0; OAT := 0;
    for i := 0 to TransactionCount - 1 do begin
        Inc( Tot );
        if Transactions[i].Started then
            Inc( Act );
        tmpAT := Transactions[i].TimeActive;
        if tmpAT > OAT then
            OAT := tmpAT;
        end;
    StateStrs.Add( sgcTransactions + '=' +
        IntToStr(Tot) + ' (' + sgcActive + '=' + IntToStr(Act) +
        ')  OAT=' + GetIntervalString( OAT ) );
    Tot := 0;  Act := 0; MaxBuf := 0;
    STTot := 0; STAct := 0;
    for i := 0 to StatementCount - 1 do begin
        if Statements[i] is TIB_Dataset then
            with Statements[i] as TIB_Dataset do begin
            Inc(Tot);
            if Active then
                Inc(Act);
            if BufferRowCount > MaxBuf then
                MaxBuf := BufferRowCount;
            end
        else begin
            Inc(STTot);
            if Statements[i].Active then
                Inc(STAct);
            end;
        end;
    // Datasets...
    StateStrs.Add( sgcDatasets + '=' +
        IntToStr(Tot) + ' (' + sgcActive + '=' + IntToStr(Act) +
        ')  Max_Buffer=' + IntToStr( MaxBuf ) );
    // Statements...
    StateStrs.Add( sgcStatements + '=' +
        IntToStr(STTot) + ' (' + sgcActive + '=' + IntToStr(STAct) + ')' );
    end;
end;

class function TInterestingTransaction.ListTitle: string;
begin
Result := '[ ' + sgcTransactions + ' ]';
end;

procedure TInterestingTransaction.AddInterests( PNode: TTreeNode );
var
    tmpNode: TTreeNode;
    tmpInterest: TInterestingItem;
    i, Cnt: integer;
begin
inherited;
tmpNode := StatusForm.StateTree.Items.AddChild( PNode, TInterestingConnection.ListTitle );
Cnt := 0;
with Component as TIB_Transaction do begin
    for i := 0 to ConnectionCount - 1 do begin
        tmpInterest := TInterestingItem(StatusForm.GetInterestObject(Connections[i]));
        if tmpInterest <> nil then // check for instance of an unowned transaction
            StatusForm.StateTree.Items.AddChildObject( tmpNode,
                GetComponentDesc(tmpInterest.Component), tmpInterest );
        Inc( Cnt );
        end;
    end;
if Cnt <= 0 then
    tmpNode.Delete;
tmpNode := StatusForm.StateTree.Items.AddChild( PNode, TInterestingStatement.ListTitle );
Cnt := 0;
with Component as TIB_Transaction do begin
    for i := 0 to StatementCount - 1 do begin
        tmpInterest := TInterestingItem(StatusForm.GetInterestObject(Statements[i]));
        if tmpInterest <> nil then // check for instance of an unowned statement
            StatusForm.StateTree.Items.AddChildObject( tmpNode,
                GetComponentDesc(tmpInterest.Component), tmpInterest );
        Inc( Cnt );
        end;
    end;
if Cnt <= 0 then
    tmpNode.Delete;
end;

procedure TInterestingTransaction.BuildState;
var
    i: integer;
    Tot, Act, MaxBuf: integer;
    STTot, STAct: integer;
begin
inherited;
with Component as TIB_Transaction do begin
    StateStrs.Add( sgcStarted + '=' + GetTrueFalseText( Started ) );
    case Isolation of
        tiCommitted: StateStrs.Add( sgcIsolation + '=' + sgcCommitted );
        tiConcurrency: StateStrs.Add( sgcIsolation + '=' + sgcConcurrency );
        tiConsistency: StateStrs.Add( sgcIsolation + '=' + sgcConsistency );
    else StateStrs.Add( sgcIsolation + '=' + sgcUnknown );
        end;
    StateStrs.Add( sgcPostPendingCount + '=' + IntToStr( PostPendingCount ) );
    StateStrs.Add( sgcPaused + '=' + GetTrueFalseText( IsPaused ) );
    StateStrs.Add( sgcPauseDisabled + '=' + GetTrueFalseText( IsPauseDisabled ) );
    StateStrs.Add( sgcAutoCommit + '=' + GetTrueFalseText( AutoCommit ) );
    case TransactionState of
        tsNone: StateStrs.Add( sgcState + '=' + sgcNone );
        tsInactivePending: StateStrs.Add( sgcState + '=' + sgcInactivePending );
        tsInactive: StateStrs.Add( sgcState + '=' + sgcInactive );
        tsActivePending: StateStrs.Add( sgcState + '=' + sgcActivePending );
        tsActive: StateStrs.Add( sgcState + '=' + sgcActive );
        tsCommitRetainingPending: StateStrs.Add( sgcState + '=' + sgcCommitRetainingPending );
        tsCommitPending: StateStrs.Add( sgcState + '=' + sgcCommitPending );
        tsCommitRefreshPending: StateStrs.Add( sgcState + '=' + sgcCommitRefreshPending );
        tsRollbackRetainingPending: StateStrs.Add( sgcState + '=' + sgcRollbackRetainingPending );
        tsRollbackPending: StateStrs.Add( sgcState + '=' + sgcRollbackPending );
        tsRollbackRefreshPending: StateStrs.Add( sgcState + '=' + sgcRollbackRefreshPending );
    else StateStrs.Add( sgcState + '=' + sgcUnknown );
        end;
    StateStrs.Add( sgcTimeActive + '=' + GetIntervalString( TimeActive ) );
    // Transactions...
    Tot := 0;  Act := 0;
    for i := 0 to ConnectionCount - 1 do begin
        Inc( Tot );
        if Connections[i].Connected then
            Inc( Act );
        end;
    StateStrs.Add( sgcConnections + '=' +
        IntToStr(Tot) + ' (' + sgcActive + '=' + IntToStr(Act) + ')' );
    Tot := 0;  Act := 0; MaxBuf := 0;
    STTot := 0; STAct := 0;
    for i := 0 to StatementCount - 1 do begin
        if Statements[i] is TIB_Dataset then
            with Statements[i] as TIB_Dataset do begin
            Inc(Tot);
            if Active then
                Inc(Act);
            if BufferRowCount > MaxBuf then
                MaxBuf := BufferRowCount;
            end
        else begin
            Inc(STTot);
            if Statements[i].Active then
                Inc(STAct);
            end;
        end;
    // Datasets...
    StateStrs.Add( sgcDatasets + '=' +
        IntToStr(Tot) + ' (' + sgcActive + '=' + IntToStr(Act) +
        ')  Max_Buffer=' + IntToStr( MaxBuf ) );
    // Statements...
    StateStrs.Add( sgcStatements + '=' +
        IntToStr(STTot) + ' (' + sgcActive + '=' + IntToStr(STAct) + ')' );
    end;

end;

class function TInterestingStatement.ListTitle: string;
begin
Result := '[ ' + sgcStatements + ' ]';
end;

procedure TInterestingStatement.AddInterests( PNode: TTreeNode );
var
    tmpNode, tmpChild: TTreeNode;
    tmpInterest: TInterestingItem;
    i, Cnt: integer;
begin
inherited;
tmpNode := StatusForm.StateTree.Items.AddChild( PNode, TInterestingDataSource.ListTitle );
Cnt := 0;
if Component is TIB_Dataset then with Component as TIB_Dataset do begin
    for i := 0 to DataSourceCount - 1 do begin
        tmpInterest := TInterestingItem(StatusForm.GetInterestObject(DataSources[i]));
        tmpChild := StatusForm.StateTree.Items.AddChildObject( tmpNode,
            GetComponentDesc(tmpInterest.Component), tmpInterest );
        StatusForm.AddInterestChildren( tmpChild, tmpInterest.Component );
        Inc( Cnt );
        end;
    end;
if Cnt <= 0 then
    tmpNode.Delete;
end;

procedure TInterestingStatement.BuildState;
begin
inherited;
with Component as TIB_Statement do begin
    StateStrs.Add( sgcActive + '=' + GetTrueFalseText( Active ) );
    StateStrs.Add( sgcPrepared + '=' + GetTrueFalseText( Prepared ) );
    StateStrs.Add( sgcStmtHandle + '=' + IntToStr( integer(stHandle) )); 
    StateStrs.Add( sgcConnection + '=' + GetComponentNamePath( IB_Connection ));
    StateStrs.Add( sgcTransaction + '=' + GetComponentNamePath( IB_Transaction ));
    end;
if Component is TIB_Dataset then with Component as TIB_Dataset do begin
    StateStrs.Add( sgcBuffer + '=' + IntToStr(BufferRowCount) );
    case State of
        dssInactive: StateStrs.Add( sgcState + '=' + sgcInactive );
        dssPrepared: StateStrs.Add( sgcState + '=' + sgcPrepared );
        dssSearch: StateStrs.Add( sgcState + '=' + sgcSearch );
        dssBrowse: StateStrs.Add( sgcState + '=' + sgcBrowse );
        dssEdit: StateStrs.Add( sgcState + '=' + sgcEdit );
        dssInsert: StateStrs.Add( sgcState + '=' + sgcInsert );
        dssDelete: StateStrs.Add( sgcState + '=' + sgcDelete );
    else StateStrs.Add( sgcState + '=' + sgcUnknown );
        end;
    StateStrs.Add( sgcDataSources + '=' + IntToStr(DataSourceCount) );
    end;
end;

class function TInterestingDataSource.ListTitle: string;
begin
Result := '[ ' + sgcDataSources + ' ]';
end;

procedure TInterestingDataSource.AddInterests( PNode: TTreeNode );
begin
inherited;
end;

procedure TInterestingDataSource.BuildState;
begin
inherited;
with Component as TIB_DataSource do begin
    StateStrs.Add( sgcDataset + '=' + GetComponentNamePath( Dataset ) );
    StateStrs.Add( sgcDataLinks + '=' + IntToStr(DataLinkCount) );
    end;
end;



constructor TfrmStatus.Create( AOwner: TComponent );
begin
inherited;
  FInteresting := TList.Create;
end;


destructor TfrmStatus.Destroy;
begin
  ClearInterestingItems;
  FInteresting.Free;
  FInteresting := nil;
  inherited;
end;

procedure TfrmStatus.Refresh;
var
    i: integer;
    tmpInterest: TInterestingItem;
    tmpNode: TTreeNode;
begin
// Clear the old list
StateTree.Items.Clear;
ClearInterestingItems;
// Add the summary item to the tree...
tmpInterest := TInterestingSummary.Create;
tmpInterest.Init( Self, nil, nil );
FInteresting.Add( tmpInterest );
tmpNode := StateTree.Items.AddObject( nil, sgcSummary, tmpInterest );
// Collect all the other items of interest...
CollectInterestingItems;
for i := 0 to FInteresting.Count - 1 do begin
    TInterestingItem(FInteresting.Items[i]).BuildState;
    end;
// Build the tree of interest...
tmpInterest.AddInterests( tmpNode );
// Re-select a tree node
if (StateTree.Selected = nil) and (tmpNode <> nil) then begin
    tmpNode.Selected := true;
    tmpNode.Expanded := true;
    end;
// Refresh the grid
RefreshStateGrid;
end;

procedure TfrmStatus.AddInterestBranch( PNode: TTreeNode; IClass: TClass );
var
    tmpNode, tmpChild: TTreeNode;
    tmpInterest: TInterestingItem;
    i, Cnt: integer;
begin
tmpInterest := TInterestingItem(IClass.Create);
try
    tmpNode := StateTree.Items.AddChild( PNode, tmpInterest.ListTitle );
finally
    tmpInterest.Free;
    end;
Cnt := 0;
for i := 0 to FInteresting.Count - 1 do begin
    tmpInterest := TInterestingItem(FInteresting.Items[i]);
    if tmpInterest is IClass then begin
        tmpChild := StateTree.Items.AddChildObject( tmpNode,
            GetComponentNamePath( tmpInterest.Component ), tmpInterest );
        AddInterestChildren( tmpChild, tmpInterest.Component );
        tmpInterest.AddInterests( tmpChild );
        Inc( Cnt );
        end;
    end;
if Cnt <= 0 then
    tmpNode.Delete;
end;

procedure TfrmStatus.AddInterestChildren( PNode: TTreeNode; AOwner: TComponent );
var
    tmpChild: TTreeNode;
    tmpInterest: TInterestingItem;
    i: integer;
begin
for i := 0 to FInteresting.Count - 1 do begin
    tmpInterest := TInterestingItem(FInteresting.Items[i]);
    if (tmpInterest.Component <> nil) and
        (tmpInterest.Component.Owner = AOwner) then begin
        tmpChild := StateTree.Items.AddChildObject( PNode,
            GetComponentDesc(tmpInterest.Component), tmpInterest );
        AddInterestChildren( tmpChild, tmpInterest.Component );
        tmpInterest.AddInterests( tmpChild );
        end;
    end;
end;

function TfrmStatus.GetInterestObject( AComp: TComponent ): TObject;
var
    tmpInterest: TInterestingItem;
    i: integer;
begin
Result := nil;
for i := 0 to FInteresting.Count - 1 do begin
    tmpInterest := TInterestingItem(FInteresting.Items[i]);
    if tmpInterest.Component = AComp then begin
        Result := tmpInterest;
        break
        end;
    end;
end;

// In this procedure we scan all components in the system and add them to
// our list of interesting items...
procedure TfrmStatus.CollectInterestingItems;
var
    i: integer;
    InterestClass: TClass;
    tmpInterest: TInterestingItem;

    procedure CollectComponents( AOwner, AModule: TComponent );
    var
        ii: integer;
    begin
        for ii := 0 to AOwner.ComponentCount - 1 do begin
            InterestClass := GetInterestClass( AOwner.Components[ii] );
            if InterestClass <> nil then begin
                tmpInterest := TInterestingItem(InterestClass.Create);
                tmpInterest.Init( Self, AOwner.Components[ii], AModule );
                FInteresting.Add( tmpInterest );
                end;
            if (AOwner.Components[ii] is TCustomForm) or
                (AOwner.Components[ii] is TDataModule) then
                CollectComponents( AOwner.Components[ii], AOwner.Components[ii] )
            else CollectComponents( AOwner.Components[ii], AModule );
            end;
    end;

begin
for i := 0 to Screen.CustomFormCount - 1 do begin
    // Owned forms will be picked up later
    if Screen.CustomForms[i].Owner = nil then begin
        tmpInterest := TInterestingForm.Create;
        tmpInterest.Init( Self, Screen.CustomForms[i], Screen.CustomForms[i] );
        FInteresting.Add( tmpInterest );
        CollectComponents( Screen.CustomForms[i], Screen.CustomForms[i] );
        end;
    end;
for i := 0 to Screen.DataModuleCount - 1 do begin
    // Owned forms will be picked up later
    if Screen.DataModules[i].Owner = nil then begin
        tmpInterest := TInterestingForm.Create;
        tmpInterest.Init( Self, Screen.DataModules[i], Screen.DataModules[i] );
        FInteresting.Add( tmpInterest );
        CollectComponents( Screen.DataModules[i], Screen.DataModules[i] );
        end;
    end;
CollectComponents( Application, nil );
end;

function TfrmStatus.GetInterestClass( AComp: TComponent ): TClass;
var
    i: integer;
begin
Result := nil;
i := Low(InterestingClasses);
while i < High(InterestingClasses) do begin
    if AComp is InterestingClasses[i] then begin
        Result := InterestingClasses[i+1];
        break;
        end;
    Inc( i, 2 );
    end;
end;

procedure TfrmStatus.ClearInterestingItems;
var
    i: integer;
begin
  if Assigned( FInteresting ) then
  begin
    for i := 0 to FInteresting.Count - 1 do
    begin
      TInterestingItem(FInteresting.Items[i]).Free;
      FInteresting.Items[i] := nil;
    end;
    FInteresting.Clear;
  end;
end;

procedure TfrmStatus.RefreshStateGrid;
var
    StateData: TInterestingItem;
    i, r, p: integer;
    tmpStr: string;
    tmpNode: TTreeNode;
begin
StateGrid.Cols[0].Clear;
StateGrid.Cols[1].Clear;
StateGrid.ColCount := 2;
StateGrid.RowCount := 2;
StateGrid.FixedRows := 1;
StateGrid.Cells[0,0] := sgcProperty;
StateGrid.Cells[1,0] := sgcData;
if StateTree.Selected <> nil then begin
    // If no state data, just list the components for the lower level...
    if StateTree.Selected.Data = nil then begin
        StateGrid.Cells[0,0] := sgcComponent;
        StateGrid.Cells[1,0] := sgcClass;
        tmpNode := StateTree.Selected.GetFirstChild;
        r := 1;
        while tmpNode <> nil do begin
            if tmpNode.Data <> nil then begin
                StateData := TInterestingItem(tmpNode.Data);
                // make sure we have room for the next entry
                while StateGrid.RowCount < (r + 1) do
                    StateGrid.RowCount := StateGrid.RowCount + 1;
                StateGrid.Cells[0,r] := GetComponentDesc(StateData.Component);
                StateGrid.Cells[1,r] := StateData.Component.ClassName;
                Inc(r);
                end;
            tmpNode := StateTree.Selected.GetNextChild( tmpNode );
            end;
        end
    else begin
        StateData := TInterestingItem(StateTree.Selected.Data);
        if StateData.StateStrs.Count > 1 then
            StateGrid.RowCount := (StateData.StateStrs.Count) + 1;
        for i := 0 to StateData.StateStrs.Count - 1 do begin
            r := i + 1;
            tmpStr := StateData.StateStrs.Strings[i];
            p := Pos( '=', tmpStr );
            if p <= 0 then begin
                StateGrid.Cells[0,r] := tmpStr;
                StateGrid.Cells[1,r] := '';
                end
            else begin
                StateGrid.Cells[0,r] := Copy( tmpStr, 1, p - 1 );
                StateGrid.Cells[1,r] := Copy( tmpStr, p + 1, maxint );
                end;
            end;
        end;
    end;
end;

procedure TfrmStatus.FormCreate(Sender: TObject);
begin
FFirstShow := true;
StateGrid.ColWidths[0] := 100;
StateGrid.ColWidths[1] := 180;
end;

procedure TfrmStatus.StateTreeChange(Sender: TObject; Node: TTreeNode);
begin
RefreshStateGrid;
end;

procedure TfrmStatus.RefreshBtnClick(Sender: TObject);
begin
Refresh;
end;

procedure TfrmStatus.FormShow(Sender: TObject);
begin
if FFirstShow then begin
    SetDefaultBounds( 0, 0, 500, 300 );
    Refresh;
    FFirstShow := false;
    end;
end;

procedure TfrmStatus.StateTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
// Let enter expand/collapse a branch
if Key = VK_RETURN then begin
    if StateTree.Selected <> nil then begin
        StateTree.Selected.Expanded := not StateTree.Selected.Expanded;
        end;
    Key := 0;
    end;
end;

procedure TfrmStatus.StateTreeKeyPress(Sender: TObject;
  var Key: Char);
begin
// Stop beeping on enter key
if (Key = #13) or (Key = #10) then
    Key := #0;
end;

procedure TfrmStatus.btApplyClick(Sender: TObject);
begin
  Refresh;
end;

procedure TfrmStatus.FormDestroy(Sender: TObject);
begin
  ClearInterestingItems;
end;

end.
