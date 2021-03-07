
{                                                                              }
{  IBF_SQL                                                                     }
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
  IBF_SQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Grids, Buttons, Dialogs, ComCtrls, Mask, Registry,
  Menus,
  XSpin,

  IB_Header,
  IB_Session,
  IB_SessionProps,
  IB_Constants,
  IB_Components,
  IB_Utils,
  IB_TransactionSource,
  IB_StatementSource,
  IB_ConnectionSource,
  IB_Grid,
  IB_CursorGrid,
  IB_StatementGrid,
  IB_SearchPanel,
  IB_StatementBar,
  IB_SearchBar,
  IB_UpdateBar,
  IB_NavigationBar,
  IB_DatasetBar,
  IB_TransactionBar,
  IB_ConnectionBar,
  IB_UtilityBar,
  IB_Dialogs,
  IB_Events,
  IB_StoredProc,
  IB_IncSearch,
  IBF_Base, ImgList;
//IB_Editors

type
  TfrmSQL = class(TfrmBase)
    pcIB_SQL: TPageControl;
    tsCursor: TTabSheet;
    tsConnection: TTabSheet;
    Panel2: TPanel;
    CursorStatementPanel: TPanel;
    cbConnection: TIB_ConnectionBar;
    tsDSQL: TTabSheet;
    DSQLStatementPanel: TPanel;
    btSQLPrev: TSpeedButton;
    btSQLNext: TSpeedButton;
    Panel4: TPanel;
    pcCursor: TPageControl;
    tsCursorSQL: TTabSheet;
    meCursor: TMemo;
    tsCursorInput: TTabSheet;
    tsCursorFields: TTabSheet;
    sbStatementBar: TIB_StatementBar;
    dsbCursorBar: TIB_DatasetBar;
    Panel6: TPanel;
    btSQLNew: TSpeedButton;
    stIB_Cursor: TIB_StatementSource;
    stIB_DSQL: TIB_StatementSource;
    dsIB_Cursor: TIB_DataSource;
    pcDSQL: TPageControl;
    tsDSQLStatement: TTabSheet;
    tsDSQLInput: TTabSheet;
    tsDSQLOutput: TTabSheet;
    meDSQL: TMemo;
    IB_StatementGrid1: TIB_StatementGrid;
    IB_StatementGrid2: TIB_StatementGrid;
    IB_CursorParameterGrid: TIB_StatementGrid;
    nbNavigationBar: TIB_NavigationBar;
    ubUpdateBar: TIB_UpdateBar;
    sbSearchBar: TIB_SearchBar;
    tsTransaction: TTabSheet;
    Panel3: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel11: TPanel;
    Panel14: TPanel;
    odGDB: TOpenDialog;
    tsCursorData: TTabSheet;
    grCursor: TIB_CursorGrid;
    IB_CursorStatementGrid: TIB_StatementGrid;
    tsQueryForms: TTabSheet;
    tsLayouts: TTabSheet;
    meCursorPlan: TMemo;
    crEdit: TIB_Cursor;
    dsqlEdit: TIB_DSQL;
    IB_TransactionBar: TIB_TransactionBar;
    tbDSQL: TIB_TransactionBar;
    ssForEdit: TIB_StatementSource;
    dsForEdit: TIB_DataSource;
    csForEdit: TIB_ConnectionSource;
    tsForEdit: TIB_TransactionSource;
    cnEdit: TIB_Connection;
    trEdit: TIB_Transaction;
    pnCursor: TIB_SearchPanel;
    cbParams: TCheckBox;
    UtilityBar: TIB_UtilityBar;
    tsKeyLinks: TTabSheet;
    meKeyLinks: TMemo;
    sp: TIB_SessionProps;
    tsFieldNames: TTabSheet;
    meFieldList: TMemo;
    Label4: TLabel;
    pnLayout: TPanel;
    btGroup: TSpeedButton;
    btLayout: TSpeedButton;
    btDelete: TSpeedButton;
    imLayout: TImageList;
    btAbout: TSpeedButton;
    Panel10: TPanel;
    Panel13: TPanel;
    Panel15: TPanel;
    btLaunchQueryForm: TSpeedButton;
    btNewQueryForm: TSpeedButton;
    btRemoveQueryForm: TSpeedButton;
    pnLayoutTreeView: TPanel;
    tvLayout: TTreeView;
    Panel17: TPanel;
    lbQueryFormNames: TListBox;
    sbExpandAll: TSpeedButton;
    sbCollapseAll: TSpeedButton;
    tmScroll: TTimer;
    pmLayout: TPopupMenu;
    miCreateGroup: TMenuItem;
    miCreateLayout: TMenuItem;
    miDeleteItem: TMenuItem;
    N2: TMenuItem;
    miCopy: TMenuItem;
    miCut: TMenuItem;
    miPaste: TMenuItem;
    tmExpand: TTimer;
    meDSQLPlan: TMemo;
    sbStatus: TSpeedButton;
    btSQLRemove: TSpeedButton;
    cbLiveCursor: TCheckBox;
    imTabs: TImageList;
    Panel12: TPanel;
    pcConnection: TPageControl;
    tsCharacteristics: TTabSheet;
    Panel16: TPanel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    lbSweepInterval: TLabel;
    lbPageBuffers: TLabel;
    edAllocatedpages: TEdit;
    edImplementation: TEdit;
    edLevel: TEdit;
    edODS: TEdit;
    edVersion: TEdit;
    edPageSize: TEdit;
    cbForcedWrites: TCheckBox;
    cbSweep: TCheckBox;
    edSweepInterval: TEdit;
    cbSweepInterval: TCheckBox;
    edPageBuffers: TEdit;
    cbPageBuffers: TCheckBox;
    cbReservePageSpace: TCheckBox;
    tsColumnAttributes: TTabSheet;
    Panel18: TPanel;
    Panel19: TPanel;
    meColumnAttributes: TMemo;
    tsLoginProperties: TTabSheet;
    Panel20: TPanel;
    cbDomainEntries: TCheckBox;
    cbSQLTypeEntries: TCheckBox;
    Label11: TLabel;
    Label13: TLabel;
    cbDefaultNoCase: TCheckBox;
    cbDefaultNoTrailing: TCheckBox;
    tsFieldsProperties: TTabSheet;
    Panel21: TPanel;
    Panel22: TPanel;
    meFieldProperties: TMemo;
    ComboBox1: TComboBox;
    tsMiscProperties: TTabSheet;
    Panel23: TPanel;
    tsLogin: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    lbSQLDialect: TLabel;
    lbCharSet: TLabel;
    lbSQLRole: TLabel;
    Label10: TLabel;
    SpeedButton2: TSpeedButton;
    edUsername: TEdit;
    edPassword: TEdit;
    cbDatabase: TComboBox;
    cbRemember: TCheckBox;
    cbCharSet: TComboBox;
    edSQLRole: TEdit;
    seSQLDialect: TXSpinEdit;
    edSchemaCacheDir: TEdit;
    Button1: TButton;
    pcTransactionSettings: TPageControl;
    tsTransSettings: TTabSheet;
    tsTimeoutProps: TTabSheet;
    Panel5: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    XSpinEdit1: TXSpinEdit;
    XSpinEdit2: TXSpinEdit;
    XSpinEdit3: TXSpinEdit;
    XSpinEdit4: TXSpinEdit;
    XSpinEdit5: TXSpinEdit;
    XSpinEdit6: TXSpinEdit;
    XSpinEdit7: TXSpinEdit;
    XSpinEdit8: TXSpinEdit;
    XSpinEdit9: TXSpinEdit;
    Panel24: TPanel;
    cbReadOnly: TCheckBox;
    rgIsolation: TRadioGroup;
    cbLockWait: TCheckBox;
    cbAutoCommit: TCheckBox;
    cbServerAutoCommit: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure sbNewConnection(Sender: TObject);
    procedure IB_ConnectionSourceBeforeConnect(Sender: TIB_ConnectionLink;
      IB_Connection: TIB_Connection);
    procedure IB_ConnectionSourceConnectedChanged(
      Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
    procedure IB_ConnectionSourceBeforeDropDatabase(
      Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
    procedure stIB_CursorBeforePrepare(
      Sender: TIB_StatementLink; IB_Statement: TIB_Statement);
    procedure stIB_DSQLBeforePrepare(Sender: TIB_StatementLink;
      IB_Statement: TIB_Statement);
    procedure meCursorChange(Sender: TObject);
    procedure btSQLClick(Sender: TObject);
    procedure stIB_DSQLAfterUnprepare(Sender: TIB_StatementLink;
      IB_Statement: TIB_Statement);
    procedure cbDatabaseChange(Sender: TObject);
    procedure IB_ConnectionSourceAfterConnect(Sender: TIB_ConnectionLink;
      IB_Connection: TIB_Connection);
    procedure IB_ConnectionSourceBeforeCreateDatabase(
      Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
    procedure btAboutClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsIB_CursorStateChanged(Sender: TIB_DataSource;
      AIB_Dataset: TIB_Dataset);
    procedure IB_TransactionSourceBeforeStart(Sender: TIB_TransactionLink;
      T: TIB_Transaction);
    procedure TransactionPropChanged(Sender: TObject);
    procedure cbAutoCommitClick(Sender: TObject);
    procedure nbNavigationBarBeforeAction(Sender: TObject);
    procedure btNewQueryFormClick(Sender: TObject);
    procedure lbQueryFormNamesDblClick(Sender: TObject);
    procedure IB_ConnectionSourceBeforeDisconnect(Sender: TIB_ConnectionLink;
      IB_Connection: TIB_Connection);
    procedure btRemoveQueryFormClick(Sender: TObject);
    procedure IB_ConnectionSourceAfterAssignment(
      Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure IB_TransactionSourceAfterAssignment(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure meDSQLChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbSearchBarRowCount(Sender: TObject; RowCount: Longint);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure stIB_DSQLAfterExecDML(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure stIB_CursorPreparedChanged(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure stIB_DSQLPreparedChanged(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure stIB_DSQLBeforeExecDML(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure dsbCursorBarBeforeAction(Sender: TObject);
    procedure cnEditCustomizeDPB(Sender: TIB_Connection;
      var BufPtr: Integer; var Buffer: array of Char);
    procedure cbSweepIntervalClick(Sender: TObject);
    procedure csBaseAfterDisconnect(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure FormDestroy(Sender: TObject);
    procedure meMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbPageBuffersClick(Sender: TObject);
    procedure crEditAfterFetchEof(IB_Dataset: TIB_Dataset);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tvLayoutChange(Sender: TObject; Node: TTreeNode);
    procedure btDeleteClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btLayoutClick(Sender: TObject);
    procedure tvLayoutEdited(Sender: TObject; Node: TTreeNode;
      var S: string );
    procedure tvLayoutEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure tvLayoutDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure tvLayoutDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvLayoutKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbExpandAllClick(Sender: TObject);
    procedure tmScrollTimer(Sender: TObject);
    procedure pmLayoutPopup(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miCutClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure tvLayoutEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure tvLayoutMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tvLayoutStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure tvLayoutKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tvLayoutCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure tmExpandTimer(Sender: TObject);
    procedure dsqlEditAfterPrepare(Sender: TIB_Statement);
    procedure sbStatusClick(Sender: TObject);
    procedure cnEditBeforeDisconnect(Sender: TIB_Connection);
    procedure cnEditBeforeConnect(Sender: TIB_Connection);
  private
    FFixedCaption: string;
    procedure SetFixedCaption( AValue: string );
    procedure UpdateDSQLButtons;
    function CloseChildForms: boolean;
    procedure HandleException(Sender: TObject; E: Exception);
  private
    FReg: TRegistry;
    LayoutsLoaded: boolean;
    LastActiveNode: TTreeNode;
    PasswordInEnv: boolean;
    UsernameInEnv: boolean;
    DatabaseInEnv: boolean;
    function LoadLayoutNames( BaseKey, AKey: string ): boolean;
    function InsertGroup( const AGroupName: string;
                                target: TTreeNode  ): TTreeNode;
    function InsertLayout( const ALayoutName: string;
                           target: TTreeNode ): TTreeNode;
    function Exists(       Node: TTreeNode;
                     const ANodeName: string;
                           Select: boolean ): boolean;
    function AssemblePath( Node: TTreeNode ): string;
    function AssembleCaption( Node: TTreeNode ): string;
    function AssembleLayout( Node: TTreeNode ): string;
    function CheckName( AName: string ): boolean;
    procedure CheckLayouts;
    procedure DeleteNode( Node: TTreeNode );
    procedure FillImageList;
  private
    SourceNode: TTreeNode;
    PasteNode: TTreeNode;
    _ExpandNode: TTreeNode;
    Direction: THitTest;
    VisibleCount: integer;
    Items_Count: integer;
    RightPoint: TPoint;
    CTRLPressed: boolean;
    AlreadyFinishDrag: Boolean; // To overcome control.EndDrag bug
    procedure SetDragCursor;
    procedure SafeDeleteKey( const fullpath: String );
    procedure SafeCopyKey( const oldpath, newpath: String );
    procedure SafeMoveKey( const oldpath, newpath: String );
    procedure StartTimer( Y: integer );
    procedure StopTimer;
    function GetVisibleCount(TreeView: TTreeView): Integer;
    function DuplicatedName(       Node: TTreeNode;
                             const ANodeName: string;
                                   Select: boolean ): Boolean;
    function CanDrop( X, Y: Integer; fromNode: TTreeNode ): boolean;
    procedure Dropped( X, Y: Integer; fromNode: TTreeNode );
    procedure CopyTreeViewBranch( source, dest: TTreeNode );
    procedure MarkExpanding( Node: TTreeNode );
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
    procedure SetLayout( AValue: string ); override;
    procedure DoReadLayout; override;
    procedure DoWriteLayout; override;
  public
    property FixedCaption: string read FFixedCaption write SetFixedCaption;
    procedure UpdateCaption;
  end;

{$IFDEF IBO_CPPB}
var
  frmSQL: TfrmSQL;
{$ENDIF}

function OsNeedDeepRegOp: Boolean;

implementation

{$R *.DFM}
{$R IB_SQL_IMAGES.RES}

uses
  IB_Schema,
  IB_Parse,
  IBD_About,
  IBD_Error,
  IBD_USearch,
  IBF_Browse,
  IBF_Events,
  IBF_Monitor,
  IBF_Users,
  IBF_Export,
  IBF_DataDump,
  IBF_DataPump,
  IBF_Who,
  IBF_Script,
  IBF_Query,
  IBF_Status,
  FileCtrl;

// To circunvent a bug in declaration in D3/Windows.pas
// Bug in D3: TOsVersionInfoEx not defined.
type
  TOSVersionInfoExA = record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of AnsiChar; {Maintenance string for PSS usage}
    wServicePackMajor: Word;
    wServicePackMinor: Word;
    wReserved: array [0..1] of Word;
  end;

function GetVersionExA( var lpVersionInformation: TOSVersionInfoExA ): BOOL;
  stdcall;
  external kernel32 name 'GetVersionExA';

var
  NeedRecurseRegistry: Boolean;

function OsNeedDeepRegOp: Boolean;
{$IFDEF IBO_VCL30_OR_GREATER}
var
  OsVIex: TOsVersionInfoExA;
{$ENDIF}
begin
// I don't know how this should be configured for Delphi 2.
{$IFDEF IBO_VCL30_OR_GREATER}
  if (Win32Platform = VER_PLATFORM_WIN32_NT) then begin
  if (Win32MajorVersion <= 3) then Result := True
  else if (Win32MajorVersion > 4) then Result := False
  else begin
  //(Win32MajorVersion = 4)
    osVIex.dwOSVersionInfoSize := sizeof(osVIex);
    if GetVersionExA( OsVIex ) and ( OsVIex.wServicePackMajor > 4 ) then
      Result := False else Result := True
    end
  end else Result := False
{$ELSE}
  Result := true;
{$ENDIF}
end;
{
function OsNeedDeepRegOp: Boolean;
begin
  if (Win32Platform = VER_PLATFORM_WIN32_NT)
  then Result := (Win32MajorVersion <= 4)
  else Result := False
end;
}
const
  TV_FIRST = $01100;
  TVM_GETVISIBLECOUNT = ( TV_FIRST + 16 );

function TfrmSQL.GetVisibleCount( TreeView: TTreeView ): Integer;
begin
  Result := TreeView.Perform( TVM_GetVisibleCount, 0, 0 );
end;

{                                                                              }
{   Form                                                                       }
{                                                                              }

const
  RootKey = '\Software\CPS\IB_WISQL';
  LayoutKeyName = 'LAYOUTS';
  LayoutKey = '\' + LayoutKeyName;
  DefaultGroupName = 'Default Group';
  QueryKeyName = 'QUERIES';
  QueryKey = '\' + QueryKeyName;
  GroupImageIndex = 0;
  LayoutImageIndex = 2;
  crDragCopy = -39;

procedure TfrmSQL.FormCreate(Sender: TObject);
begin
  PasswordInEnv := GetEnvVariable( 'ISC_PASSWORD' ) <> '';
  UsernameInEnv := GetEnvVariable( 'ISC_USER' ) <> '';
  DatabaseInEnv := GetEnvVariable( 'ISC_DATABASE' ) <> '';
  Direction := htNowhere;
  FillImageList;
  tvLayout.Items.Clear;
  FReg := TRegistry.Create;
  Application.OnException := HandleException;
  if ParamStr(1) <> '' then begin
    tsLayouts.TabVisible := false;
    cbDatabase.Text := ParamStr(1);
    if ParamStr(2) <> '' then begin
      edUserName.Text := ParamStr(2);
    end else if UsernameInEnv then begin
      edUserName.Text := '';
    end else begin
      edUserName.Text := 'SYSDBA';
    end;
    if ParamStr(3) <> '' then begin
      edPassword.Text := ParamStr(3);
    end else if PasswordInEnv then begin
      edPassword.Text := '';
    end else begin
      edPassword.Text := 'masterkey';
    end;
    if ParamStr(4) <> '' then begin
      cbCharSet.Text := ParamStr(4);
    end else begin
      cbCharSet.Text := '';
    end;
  end;
{$IFDEF IBO_VCL40_OR_GREATER}
  Constraints.MinHeight := 360;
  Constraints.MinWidth := 540;
  pcIB_SQL.Images := imTabs;
  tsConnection.ImageIndex := 2;
  tsTransaction.ImageIndex := 4;
  tsDSQL.ImageIndex := 8;
  tsCursor.ImageIndex := 10;
  tsQueryForms.ImageIndex := 6;
{$ENDIF}
{$IFDEF IBO_VCL30_OR_GREATER}
  btGroup.Flat := true;
  btLayout.Flat := true;
  btDelete.Flat := true;
  btAbout.Flat := true;
  sbStatus.Flat := true;
  btSQLPrev.Flat := true;
  btSQLNext.Flat := true;
  btSQLNew.Flat := true;
  btSQLRemove.Flat := true;
  btNewQueryForm.Flat := true;
  btLaunchQueryForm.Flat := true;
  btRemoveQueryForm.Flat := true;
  sbExpandAll.Flat := true;
  sbCollapseAll.Flat := true;
{$ENDIF}
  grCursor.Align := alClient;
  pcDSQL.ActivePage := tsDSQLStatement;
  pcCursor.ActivePage := tsCursorSQL;
  BaseConnection := cnEdit;
  BaseTransaction := trEdit;
  Screen.Cursors[crDragCopy] := LoadCursor( hInstance, 'IDC_CURSOR_DRAGCOPY' );
{$IFDEF VER90}
  Screen.Cursors[-21] := LoadCursor( hInstance, 'IDC_CURSOR_HANDPOINT' );
{$ENDIF}
  Screen.Cursors[-25] := LoadCursor( hInstance, 'IDC_CURSOR_IBO_BUSY' );
  Screen.Cursors[-26] := LoadCursor( hInstance, 'IDC_CURSOR_IBO_YIELD' );
  tsFieldsProperties.TabVisible := false;
  tsLoginProperties.TabVisible := false;
  tsMiscProperties.TabVisible := false;
  pcConnection.ActivePage := tsLogin;
  pcTransactionSettings.ActivePage := tsTransSettings;
end;

procedure TfrmSQL.FormDestroy( Sender: TObject );
begin
  Application.OnException := nil;
  FReg.Free;
  FReg := nil;
  inherited;
end;

procedure TfrmSQL.HandleException(Sender: TObject; E: Exception);
begin
  if E is EIB_ISCError then with E as EIB_ISCError do
    ShowDialog
  else
    Application.ShowException( E );
end;

procedure TfrmSQL.FormShow(Sender: TObject);
begin
  CheckLayouts;
  SetDefaultBounds( 0, 0, 550, 350 );
end;

procedure TfrmSQL.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  UtilityBar.BaseConnection := AConnection;
  cbConnection.IB_Connection := AConnection;
  crEdit.IB_Connection := AConnection;
  dsqlEdit.IB_Connection := AConnection;
  trEdit.IB_Connection := AConnection;
end;

procedure TfrmSQL.IB_TransactionSourceAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  UtilityBar.BaseTransaction := ATransaction;
  IB_TransactionBar.IB_Transaction := ATransaction;
  tbDSQL.IB_Transaction := ATransaction;
  crEdit.IB_Transaction := ATransaction;
  dsqlEdit.IB_Transaction := ATransaction;
end;

procedure TfrmSQL.FormClose( Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned( BaseTransaction ) then begin
    if BaseTransaction.CloseWithConfirm <> mrCancel then begin
      if Assigned( BaseConnection ) then begin
        BaseConnection.Connected := false;
      end;
    end else begin
      Action := caNone;
    end;
  end;
  if Action <> caNone then StopTimer;
end;

procedure TfrmSQL.DoReadSettings;
begin
  with RegDB, pcIB_SQL do
    ActivePage := Pages[ ReadInteger('Settings', 'Page Index', 0) ];
  if Assigned( csForEdit.IB_Connection ) then
    pcIB_SQL.ActivePage := tsConnection;
  if Assigned( tsForEdit.IB_Transaction ) then
    pcIB_SQL.ActivePage := tsTransaction;
  if ssForEdit.Statement <> nil then with ssForEdit.Statement do
    pcIB_SQL.ActivePage := tsDSQL;
  if dsForEdit.Dataset <> nil then with dsForEdit.Dataset do
    pcIB_SQL.ActivePage := tsCursor;
  if ( ParamStr(1) <> '' ) then
    RegDB.WriteString( 'Settings', 'LAYOUT', '' );
  if ( csForEdit.IB_Connection <> nil ) or
     ( tsForEdit.IB_Transaction <> nil ) or
     ( ssForEdit.Statement <> nil ) or
     ( dsForEdit.Dataset <> nil ) then
    RegDB.WriteString( 'Settings', 'LAYOUT', 'Editor' );
//  UpdateLayoutList;
end;

procedure TfrmSQL.DoWriteSettings;
begin
  with RegDB, pcIB_SQL do begin
    WriteInteger( 'Settings', 'Page Index', ActivePage.PageIndex );
  end;
end;

procedure TfrmSQL.SetLayout( AValue: string );
var
  OldCursor: TCursor;
begin
  if Layout <> AValue then begin
    CloseChildForms;
    OldCursor := Screen.Cursor;
    try
      Screen.Cursor := crHourglass;
      inherited SetLayout( AValue );
      CheckLayouts;
      UpdateCaption;
    finally
      Screen.Cursor := OldCursor;
    end;
  end;
end;

procedure TfrmSQL.SetFixedCaption( AValue: string );
begin
  FFixedCaption := AValue;
  UpdateCaption;
end;

{                                                                              }
{  Layout tab                                                                  }
{                                                                              }

procedure TfrmSQL.UpdateCaption;
begin
  if FixedCaption <> '' then begin
    Caption := FixedCaption;
  end else begin
    if csBase.Connected then begin
      Caption := BaseConnection.Database;
    end else begin
      Caption := AssembleCaption( tvLayout.Selected );
    end;
    if Assigned( ssForEdit.Statement ) then begin
      Caption := ssForEdit.Statement.Owner.Name + '.' +
                 ssForEdit.Statement.Name + ' - Editor';
    end else if dsForEdit.Dataset <> nil then begin
      Caption := dsForEdit.Dataset.Owner.Name + '.' +
                 dsForEdit.Dataset.Name + ' - Editor';
    end else if csForEdit.IB_Connection <> nil then begin
      Caption := csForEdit.IB_Connection.Owner.Name + '.' +
                 csForEdit.IB_Connection.Name + ' - Editor';
    end else if tsForEdit.IB_Transaction <> nil then begin
      Caption := tsForEdit.IB_Transaction.Owner.Name + '.' +
                 tsForEdit.IB_Transaction.Name + ' - Editor';
    end;
  end;
end;

function TfrmSQL.CloseChildForms: boolean;
var
  ii, jj: integer;
begin
  ii := 0;
  jj := 0;
  while ii < Screen.FormCount do
  begin
    try
      if ( Screen.Forms[ ii ].Owner = Self ) and
         (( Screen.Forms[ ii ] is TfrmQuery  ) or
          ( Screen.Forms[ ii ] is TfrmBrowse ) or
          ( Screen.Forms[ ii ] is TfrmEvents ) or
          ( Screen.Forms[ ii ] is TfrmExport ) or
          ( Screen.Forms[ ii ] is TfrmDataDump ) or
          ( Screen.Forms[ ii ] is TfrmDataPump ) or
          ( Screen.Forms[ ii ] is TfrmWho )) then
      begin
        if Screen.Forms[ ii ].CloseQuery then
        begin
          Screen.Forms[ ii ].Close;
          Screen.Forms[ ii ].Free;
          Dec( ii );
        end
        else
          MessageBeep( 0 );
      end
      else
        Inc( jj );
    except
      Application.HandleException( Self );
    end;
    Inc( ii );
  end;
  Result := Screen.FormCount - jj = 0;
end;

procedure TfrmSQL.DoReadLayout;
begin
  ReadStrings( 'Connections', cbDatabase.Items );
  if FReg.OpenKey( FullKey + QueryKey, False ) then
  try
    if FReg.HasSubKeys then
      FReg.GetKeyNames( lbQueryFormNames.Items )
    else
      lbQueryFormNames.Items.Clear;
  finally
    FReg.CloseKey;
  end
  else
    lbQueryFormNames.Items.Clear;
  with cbDatabase do
  begin
    Text := '';
    if Items.Count > 0 then
      ItemIndex := 0;
  end;
  if csForEdit.IB_Connection <> nil then with csForEdit.IB_Connection do
  begin
    cbDatabase.Text := Database;
    edPassword.Text := Password;
    cbCharSet.Text  := CharSet;
    edUsername.Text := Username;
    edSQLRole.Text  := SQLRole;
    edSchemaCacheDir.Text := SchemaCacheDir;
    cbRemember.Checked := false;
    seSQLDialect.Value := SQLDialect;
    if ( edPassword.Text = '' ) and not PasswordInEnv then begin
      edPassword.Text := 'masterkey';
    end;
    if ( edUsername.Text = '' ) and not UsernameInEnv then begin
      edUsername.Text := 'SYSDBA';
    end;
    case ForcedWrites of
      dpbTrue: cbForcedWrites.State := cbChecked;
      dpbFalse: cbForcedWrites.State := cbUnchecked;
      dpbDefault: cbForcedWrites.State := cbGrayed;
    end;
    case ReservePageSpace of
      dpbTrue: cbReservePageSpace.State := cbChecked;
      dpbFalse: cbReservePageSpace.State := cbUnchecked;
      dpbDefault: cbReservePageSpace.State := cbGrayed;
    end;
    meColumnAttributes.Lines.Assign( ColumnAttributes );
    cbDomainEntries.Checked := fetDomainName in FieldEntryTypes;
    cbSQLTypeEntries.Checked := fetSQLType in FieldEntryTypes;
    cbDefaultNoCase.Checked := DefaultNoCase;
    cbDefaultNoTrailing.Checked := DefaultNoTrailing;
  end
  else
  with RegDB do
  begin
    if cbDatabase.Text = '' then
      cbDatabase.Text := ReadString( 'Settings', 'Database', '' );
    edPassword.Text := UnJumbleString(
      ReadString( 'Settings', 'PASSWORD', 'masterkey' ), GetJumbleKey );
    cbCharSet.Text := ReadString( 'Settings', 'CHARSET', '' );
    edUserName.Text := ReadString( 'Settings', 'USER NAME', 'SYSDBA' );
    edSQLRole.Text  := ReadString( 'Settings', 'SQL ROLE', '' );
    edSchemaCacheDir.Text := ReadString( 'Settings', 'SCHEMA CACHE DIR', '' );
    cbRemember.Checked := ReadString( 'Settings', 'PASSWORD', '' ) <> '';
    seSQLDialect.Value := ReadInteger( 'Settings', 'SQLDialect', 1 );
    cbForcedWrites.State := cbGrayed;
    cbReservePageSpace.State := cbGrayed;
    meColumnAttributes.Lines.Clear;
    ReadStrings( 'ColumnAttributes', meColumnAttributes.Lines );
    cbDomainEntries.Checked := ReadBool( 'Settings', 'DomainEntryType', false );
    cbSQLTypeEntries.Checked := ReadBool( 'Settings',
                                          'SQLTypeEntryType', false );
    cbDefaultNoCase.Checked := ReadBool( 'Settings', 'DefaultNoCase', false );
    cbDefaultNoTrailing.Checked := ReadBool( 'Settings',
                                             'DefaultNoTrailing', false );
  end;
  if tsForEdit.IB_Transaction <> nil then with tsForEdit.IB_Transaction do begin
    cbAutoCommit.Checked := AutoCommit;
    cbServerAutoCommit.Checked := ServerAutoCommit;
    cbReadOnly.Checked := ReadOnly;
    cbLockWait.Checked := LockWait;
    case Isolation of
      tiConcurrency: rgIsolation.ItemIndex := 0;
      tiConsistency: rgIsolation.ItemIndex := 1;
      tiCommitted: if RecVersion then rgIsolation.ItemIndex := 2
                                 else rgIsolation.ItemIndex := 3;
    end;
  end else with RegDB do begin
    cbAutoCommit.Checked := ReadBool( 'Settings', 'AutoCommit', false );
    cbServerAutoCommit.Checked := ReadBool( 'Settings',
                                            'ServerAutoCommit', false );
    cbReadOnly.Checked := ReadBool( 'Settings', 'ReadOnly', false );
    cbLockWait.Checked := ReadBool( 'Settings', 'LockWait', false );
    rgIsolation.ItemIndex := ReadInteger( 'Settings', 'Isolation', 2 );
  end;
  if ( ssForEdit.Statement <> nil ) then with ssForEdit.Statement do begin
    meDSQL.Lines.Text := SQL.Text;
    cbParams.Checked := ParamCheck;
  end
  else
  with RegDB do begin
    ReadStrings( 'DSQL', meDSQL.Lines );
    cbParams.Checked := ReadBool( 'Settings', 'DSQLParamCheck', true );
  end;
  if ( dsForEdit.Dataset <> nil ) then
  with dsForEdit.Dataset do
  begin
    meCursor.Lines.Text := SQL.Text;
    meKeyLinks.Lines.Text := KeyLinks.Text;
    cbLiveCursor.Checked := RequestLive;
  end
  else
  begin
    ReadStrings( 'Cursor', meCursor.Lines );
    ReadStrings( 'CursorKeyLinks', meKeyLinks.Lines );
    cbLiveCursor.Checked := RegDB.ReadBool( 'Settings', 'CursorLive', false );
  end;
end;

procedure TfrmSQL.DoWriteLayout;
var
  ii: integer;
begin
  ii := 0;
  while ii < Screen.FormCount do begin
    if ( Screen.Forms[ ii ].Owner = Self ) and
       ( Screen.Forms[ ii ] is TfrmScript ) then begin
      Screen.Forms[ ii ].Free;
    end else begin
      Inc( ii );
    end;
  end;
  WriteStrings( 'Connections', cbDatabase.Items );
  if csForEdit.IB_Connection <> nil then with csForEdit.IB_Connection do begin
    Connected := false;
    Database := cbDatabase.Text;
    if cbRemember.Checked then begin
      Password := edPassword.Text;
    end;
    CharSet := cbCharSet.Text;
    Username := edUserName.Text;
    SQLRole := edSQLRole.Text;
    SchemaCacheDir := edSchemaCacheDir.Text;
    SQLDialect := seSQLDialect.Value;
    case cbForcedWrites.State of
      cbChecked: ForcedWrites := dpbTrue;
      cbUnchecked: ForcedWrites := dpbFalse;
      cbGrayed: ForcedWrites := dpbDefault;
    end;
    case cbReservePageSpace.State of
      cbChecked: ReservePageSpace := dpbTrue;
      cbUnchecked: ReservePageSpace := dpbFalse;
      cbGrayed: ReservePageSpace := dpbDefault;
    end;
    ColumnAttributes.Assign( meColumnAttributes.Lines );
    if cbDomainEntries.Checked then
      FieldEntryTypes := FieldEntryTypes + [ fetDomainName ]
    else
      FieldEntryTypes := FieldEntryTypes - [ fetDomainName ];

    if cbSQLTypeEntries.Checked then
      FieldEntryTypes := FieldEntryTypes + [ fetSQLType ]
    else
      FieldEntryTypes := FieldEntryTypes - [ fetSQLType ];
    DefaultNoCase := cbDefaultNoCase.Checked;
    DefaultNoTrailing := cbDefaultNoTrailing.Checked;
  end
  else
  with RegDB do
  begin
    WriteString( 'Settings', 'Database', cbDatabase.Text );
    if cbRemember.Checked then
    begin
      WriteString( 'Settings',
                   'PASSWORD',
                   JumbleString( edPassword.Text, GetJumbleKey ));
    end
    else
    begin
      edPassword.Text := '';
      WriteString( 'Settings', 'PASSWORD', '' );
    end;
    WriteString( 'Settings', 'CHARSET', cbCharSet.Text );
    WriteString( 'Settings', 'USER NAME', edUsername.Text );
    WriteString( 'Settings', 'SQL ROLE', edSQLRole.Text );
    WriteString( 'Settings', 'SCHEMA CACHE DIR', edSchemaCacheDir.Text );
    WriteInteger( 'Settings', 'SQLDialect', seSQLDialect.Value );
    WriteStrings( 'ColumnAttributes', meColumnAttributes.Lines );
    WriteBool( 'Settings', 'DomainEntryType', cbDomainEntries.Checked );
    WriteBool( 'Settings', 'SQLTypeEntryType', cbSQLTypeEntries.Checked );
    WriteBool( 'Settings', 'DefaultNoCase', cbDefaultNoCase.Checked );
    WriteBool( 'Settings', 'DefaultNoTrailing', cbDefaultNoTrailing.Checked );
  end;
  if tsForEdit.IB_Transaction <> nil then with tsForEdit.IB_Transaction do begin
    AutoCommit := cbAutoCommit.Checked;
    ServerAutoCommit := cbServerAutoCommit.Checked;
    ReadOnly := cbReadOnly.Checked;
    LockWait := cbLockWait.Checked;
    case rgIsolation.ItemIndex of
    0: Isolation := tiConcurrency;
    1: Isolation := tiConsistency;
    2,
    3: Isolation := tiCommitted;
    end;
    RecVersion := rgIsolation.ItemIndex = 2;
  end
  else
    with RegDB do
    begin
      WriteBool( 'Settings', 'AutoCommit', cbAutoCommit.Checked );
      WriteBool( 'Settings', 'ServerAutoCommit', cbServerAutoCommit.Checked );
      WriteBool( 'Settings', 'ReadOnly', cbReadOnly.Checked );
      WriteBool( 'Settings', 'LockWait', cbLockWait.Checked );
      WriteInteger( 'Settings', 'Isolation', rgIsolation.ItemIndex );
    end;
  if ssForEdit.Statement <> nil then
    with ssForEdit.Statement do
    begin
      SQL.Text := meDSQL.Lines.Text;
      ParamCheck := cbParams.Checked;
    end
  else
    with RegDB do
    begin
      WriteStrings( 'DSQL', meDSQL.Lines );
      WriteBool( 'Settings', 'DSQLParamCheck', cbParams.Checked );
    end;
  if ( dsForEdit.Dataset <> nil ) then
  with dsForEdit.Dataset do
  begin
    SQL.Text := meCursor.Lines.Text;
    KeyLinks.Text := meKeyLinks.Lines.Text;
    RequestLive := cbLiveCursor.Checked;
  end
  else
  begin;
    WriteStrings( 'Cursor', meCursor.Lines );
    WriteStrings( 'CursorKeyLinks', meKeyLinks.Lines );
    RegDb.WriteBool( 'Settings', 'CursorLive', cbLiveCursor.Checked );
  end;
end;

procedure TfrmSQL.btAboutClick(Sender: TObject);
begin
  with TdlgAbout.Create( Application ) do try
    ShowModal;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------------------}
{   Connection tab                                                             }
{------------------------------------------------------------------------------}

procedure TfrmSQL.IB_ConnectionSourceBeforeDisconnect(
  Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
begin
  CloseChildForms;
end;

procedure TfrmSQL.IB_ConnectionSourceBeforeConnect(
  Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
begin
  if IB_Connection <> nil then with IB_Connection do begin
    if ConnectionStatus = csConnectPending then
    begin
    // This is invoked when a database is created in the connection tab.
      Database := cbDatabase.Text;
      Password := edPassword.Text;
      CharSet  := cbCharSet.Text;
      Username := edUsername.Text;
      SQLRole  := edSQLRole.Text;
      SchemaCacheDir := edSchemaCacheDir.Text;
      SQLDialect  := seSQLDialect.Value;
      case cbForcedWrites.State of
        cbChecked: ForcedWrites := dpbTrue;
        cbUnchecked: ForcedWrites := dpbFalse;
        cbGrayed: ForcedWrites := dpbDefault;
      end;
      case cbReservePageSpace.State of
        cbChecked: ReservepageSpace := dpbTrue;
        cbUnchecked: ReservepageSpace := dpbFalse;
        cbGrayed: ReservepageSpace := dpbDefault;
      end;
    end
    else
    begin
    // This is invoked when a script creates a new database.
      cbDatabase.Text := Database;
      edPassword.Text := Password;
      cbCharSet.Text  := CharSet;
      edUsername.Text := Username;
//      edSQLRole.Text  := SQLRole;
//      edSchemaCacheDir.Text := SchemaCacheDir;
      seSQLDialect.Value := SQLDialect;
    end;
  end;
end;

procedure TfrmSQL.cbDatabaseChange(Sender: TObject);
begin
//  if csBase.Connected then
//    BaseConnection.Connected := false;
end;

procedure TfrmSQL.sbNewConnection(Sender: TObject);
var
  s: TFileName;
begin
  if Assigned( BaseConnection ) then
    with BaseConnection do
    begin
      Connected := false;
      if cbDatabase.Text <> '' then
      begin
        Database := cbDatabase.Text;
        odGDB.FileName := Path;
      end
      else
        odGDB.FileName := '*.GDB';
      if IBD_USearch.ModalSearchEx( Trim( odGDB.Filename ), s ) then
      begin
        Database := s;
        cbDatabase.Text := s;
      end;
    end;
end;

procedure TfrmSQL.IB_ConnectionSourceAfterConnect(
  Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
var
  ii: integer;
begin
  edSweepInterval.ReadOnly := true;
  edSweepInterval.Color := clSilver;
  edPageBuffers.ReadOnly := true;
  edPageBuffers.Color := clSilver;
  with cbDatabase, Items, BaseConnection do begin
    cbDatabase.OnChange := nil;
    try
      ii := IndexOf( Database );
      if ii <> -1 then begin
        Delete( ii );
      end;
      Insert( 0, Database );
      cbDatabase.Text := Database;
      edPassword.Text := Password;
      cbCharSet.Text  := CharSet;
      edUsername.Text := Username;
      edSQLRole.Text  := SQLRole;
      edSchemaCacheDir.Text := SchemaCacheDir;
    finally
      cbDatabase.OnChange := cbDatabaseChange;
    end;
  end;
end;

procedure TfrmSQL.IB_ConnectionSourceConnectedChanged(
  Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
begin
  if ( csDestroying in ComponentState ) then Exit;
  UpdateCaption;
  seSQLDialect.Value := IB_Connection.SQLDialect;
  cbSweep.Enabled := not IB_Connection.Connected;
  cbSweepInterval.Enabled := not IB_Connection.Connected;
  cbPageBuffers.Enabled := not IB_Connection.Connected;
  if IB_Connection.Connected then begin
    with IB_Connection.Characteristics do begin
      edAllocatedPages.Text := IntToStr( dbAllocation );
      edLevel.Text := IntToStr( dbLevelPrefix ) + '.' +
                      IntToStr( dbBase_Level );
      edImplementation.Text := IntToStr( dbImplementationPrefix ) + '.' +
                               IntToStr( dbImplementation ) + '.' +
                               IntToStr( dbClass );
      with cbForcedWrites do begin
        OnClick := nil;
        try
          Checked := dbForced_writes <> 0;
        finally
          OnClick := cbDatabaseChange;
        end;
      end;
      with cbReservePageSpace do begin
        OnClick := nil;
        try
          Checked := dbNo_Reserve = 0;
        finally
          OnClick := cbDatabaseChange;
        end;
      end;
      edODS.Text := IntToStr( dbODS_Version ) + '.' +
                    IntToStr( dbODS_Minor_Version );
      edPageSize.Text := IntToStr( dbPage_Size );
      edSweepInterval.Text := IntToStr( dbSweep_Interval );
      edPageBuffers.Text := IntToStr( dbPage_Buffers );
      edVersion.Text := dbVersion;
    end;
  end else begin
    edAllocatedPages.Text    := '';
    edLevel.Text             := '';
    edImplementation.Text    := '';
    cbReservePageSpace.State := cbGrayed;
    cbForcedWrites.State     := cbGrayed;
    cbSweep.State            := cbUnchecked;
    edODS.Text               := '';
    edPageSize.Text          := '';
    edSweepInterval.Text     := '';
    edPageBuffers.Text       := '';
    edVersion.Text           := '';
  end;
end;

procedure TfrmSQL.IB_ConnectionSourceBeforeCreateDatabase(
  Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
begin
  if MessageDlg( M_SQL_ConfirmDBCreation,
                 mtConfirmation,
                 mbOkCancel,
                 0 ) <> mrOk then begin
    SysUtils.Abort;
  end else if MessageDlg( M_SQL_ConfirmNoOtherDBSameName,
                          mtWarning,
                          mbOkCancel,
                          0 ) <> mrOk then begin
    SysUtils.Abort;
  end;
end;

procedure TfrmSQL.IB_ConnectionSourceBeforeDropDatabase(
  Sender: TIB_ConnectionLink; IB_Connection: TIB_Connection);
begin
  if MessageDlg( M_SQL_ConfirmDBDrop,
                 mtConfirmation,
                 mbOkCancel,
                 0 ) <> mrOk then begin
    SysUtils.Abort;
  end else if MessageDlg( M_SQL_ReConfirmDBDrop,
                          mtWarning,
                          mbOkCancel,
                          0 ) <> mrOk then begin
    SysUtils.Abort;
  end;
end;

{------------------------------------------------------------------------------}
{ Transaction tab                                                              }
{------------------------------------------------------------------------------}

procedure TfrmSQL.cbAutoCommitClick(Sender: TObject);
begin
  if Assigned( BaseTransaction ) then begin
    BaseTransaction.AutoCommit := cbAutoCommit.Checked;
    BaseTransaction.ServerAutoCommit := cbServerAutoCommit.Checked;
  end;
end;

procedure TfrmSQL.IB_TransactionSourceBeforeStart(
  Sender: TIB_TransactionLink; T: TIB_Transaction);
begin
  with T do
  begin
    AutoCommit := cbAutoCommit.Checked;
    ServerAutoCommit := cbServerAutoCommit.Checked;
    ReadOnly := cbReadOnly.Checked;
    LockWait := cbLockWait.Checked;
    case rgIsolation.ItemIndex of
      0: Isolation := tiConcurrency;
      1: Isolation := tiConsistency;
      2,
      3: Isolation := tiCommitted;
    end;
    RecVersion := rgIsolation.ItemIndex = 2;
  end;
end;

procedure TfrmSQL.TransactionPropChanged(Sender: TObject);
begin
  with tsBase do
    if Started then
      IB_Transaction.Close;
end;

{------------------------------------------------------------------------------}
{   DSQL tab                                                                   }
{------------------------------------------------------------------------------}

procedure TfrmSQL.stIB_DSQLBeforePrepare(
  Sender: TIB_StatementLink; IB_Statement: TIB_Statement);
begin
  dsqlEdit.SQL.Text := meDSQL.Lines.Text;
  dsqlEdit.ParamCheck := cbParams.Checked;
end;

procedure TfrmSQL.meDSQLChange(Sender: TObject);
begin
  dsqlEdit.Prepared := false;
end;

procedure TfrmSQL.btSQLClick(Sender: TObject);
begin
  with dsqlEdit do
  begin
    if Sender = btSQLNew then
    begin
      AddSQLHistory( meDSQL.Lines, SQLHistoryRef );
      Prepared := false;
      SQLHistoryRef := SQLHistory.Count;
      meDSQL.Lines.Clear;
    end;
    if Sender = btSQLPrev then
    begin
      if ( AddSQLHistory( meDSQL.Lines, SQLHistoryRef )) and
         ( SQLHistoryRef = SQLHistory.Count ) then
        SQLHistoryRef := SQLHistoryRef - 2
      else
        SQLHistoryRef := SQLHistoryRef - 1;
      meDSQL.Lines.Text := SQL.Text;
    end;
    if Sender = btSQLNext then
    begin
      AddSQLHistory( meDSQL.Lines, SQLHistoryRef );
      SQLHistoryRef := SQLHistoryRef + 1;
      meDSQL.Lines.Text := SQL.Text;
    end;
    if Sender = btSQLRemove then
    begin
      dsqlEdit.RemoveSQLHistory( dsqlEdit.SQLHistoryRef );
      meDSQL.Lines.Text := SQL.Text;
    end;
  end;
  pcDSQL.ActivePage := tsDSQLStatement;
  meDSQL.SetFocus;
  UpdateDSQLButtons;
end;

procedure TfrmSQL.UpdateDSQLButtons;
begin
  with dsqlEdit do
  begin
    btSQLPrev.Enabled := ( SQLHistory.Count > 0 ) and ( SQLHistoryRef > 0 );
    btSQLNext.Enabled := ( SQLHistory.Count > SQLHistoryRef + 1 );
    btSQLRemove.Enabled := SQLHistoryRef < SQLHistory.Count;
  end;
end;

procedure TfrmSQL.stIB_DSQLPreparedChanged(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin
  case dsqlEdit.StatementType of
    stSelect,
    stInsert,
    stUpdate,
    stDelete,
    stSelectForUpdate: meDSQLPlan.Lines.Text := dsqlEdit.StatementPlan
    else               meDSQLPlan.Lines.Text := '';
  end;
end;

procedure TfrmSQL.stIB_DSQLAfterUnprepare(
  Sender: TIB_StatementLink; IB_Statement: TIB_Statement);
begin
  UpdateDSQLButtons;
end;

{------------------------------------------------------------------------------}
{   Cursor tab                                                                 }
{------------------------------------------------------------------------------}

procedure TfrmSQL.stIB_CursorBeforePrepare(
  Sender: TIB_StatementLink; IB_Statement: TIB_Statement);
begin
  crEdit.SQL.Text := meCursor.Lines.Text;
  crEdit.KeyLinks.Text := meKeyLinks.Lines.Text;
end;

procedure TfrmSQL.meCursorChange(Sender: TObject);
begin
  crEdit.Prepared := false;
end;

procedure TfrmSQL.dsIB_CursorStateChanged(
  Sender: TIB_DataSource; AIB_Dataset: TIB_Dataset);
begin
  if AIB_Dataset <> nil then with AIB_Dataset do begin
    grCursor.Visible := not ( State in [ dssInsert, dssEdit, dssSearch ] );
    pnCursor.Visible := State in [ dssInsert, dssEdit, dssSearch ];
    if NeedToPost then begin
      pcCursor.ActivePage := tsCursorData;
    end;
  end else begin
    pnCursor.Visible := false;
    grCursor.Visible := true;
  end;
  if ( AIB_Dataset <> nil ) and
     ( AIB_Dataset.State = dssSearch ) then begin
    pcCursor.ActivePage := tsCursorData;
  end;
end;

procedure TfrmSQL.crEditAfterFetchEof(IB_Dataset: TIB_Dataset);
begin
  if StatusBar.Visible then begin
    Statusbar.SimpleText := M_SQL_RowsFetched + IntToStr( crEdit.RowNum );
  end;
end;

procedure TfrmSQL.stIB_CursorPreparedChanged(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin
  case crEdit.StatementType of
    stSelect,
    stInsert,
    stUpdate,
    stDelete,
    stSelectForUpdate: meCursorPlan.Lines.Text := crEdit.StatementPlan
    else               meCursorPlan.Lines.Text := '';
  end;
  with Statement do begin
    if Prepared then begin
      GetFieldNamesList( meFieldList.Lines );
    end else begin
      meFieldList.Lines.Clear;
    end;
  end;
end;

procedure TfrmSQL.nbNavigationBarBeforeAction(Sender: TObject);
begin
  if nbNavigationBar.FocusedButton = nbLast then begin
    pcCursor.ActivePage := tsCursorData;
  end;
end;

{------------------------------------------------------------------------------}
{  Query Forms                                                                 }
{------------------------------------------------------------------------------}

procedure TfrmSQL.lbQueryFormNamesDblClick(Sender: TObject);
var
  tmpQueryForm: TfrmQuery;
  ii: integer;
begin
  tmpQueryForm := nil;
  for ii := 0 to Screen.FormCount - 1 do begin
    if Screen.Forms[ ii ] is TfrmQuery then begin
      with Screen.Forms[ ii ] as TfrmQuery do begin
        with lbQueryFormNames do if QueryForm = Items[ ItemIndex ] then begin
          tmpQueryForm := Screen.Forms[ ii ] as TfrmQuery;
          Break;
        end;
      end;
    end;
  end;
  if not Assigned( tmpQueryForm ) then
  begin
    tmpQueryForm := TfrmQuery.Create( Self );
    with tmpQueryForm do
    begin
      BaseConnection := Self.BaseConnection;
      BaseTransaction := Self.BaseTransaction;
      dsMasterSource.Dataset := crEdit;
      with lbQueryFormNames do
      begin
        QueryForm := '';
        if ItemIndex >= 0 then
        begin
          QueryForm := Items[ ItemIndex ];
        end;
        if QueryForm = '' then
        begin
          QueryForm := 'Default Query';
        end;
      end;
      Caption := QueryForm;
      BaseKey := Self.FullKey + '\QUERIES\' + QueryForm;
    end;
  end;
  tmpQueryForm.Show;
end;

procedure TfrmSQL.btNewQueryFormClick(Sender: TObject);
var
  s: string;
begin
  if InputQuery( M_SQL_AskFormName, '', s ) and
     (Trim(s) <> '') then
  begin
    if CheckName( s ) then with lbQueryFormNames do
    begin
      if Items.IndexOf( s ) = -1 then
      begin
        Items.Insert( 0, s );
        ItemIndex := 0;
        if FReg.OpenKey( FullKey + QueryKey + '\' + s, true ) then
          FReg.CloseKey;
      end
      else
        ItemIndex := Items.IndexOf( s );
    end;
  end;
end;

procedure TfrmSQL.btRemoveQueryFormClick(Sender: TObject);
var
  tmpQueryForm: TfrmQuery;
  ii: integer;
begin
  tmpQueryForm := nil;
  for ii := 0 to Screen.FormCount - 1 do
    if Screen.Forms[ ii ] is TfrmQuery then
      with Screen.Forms[ ii ] as TfrmQuery do
        with lbQueryFormNames do if QueryForm = Items[ ItemIndex ] then
        begin
          tmpQueryForm := Screen.Forms[ ii ] as TfrmQuery;
          Break;
        end;
  if tmpQueryForm <> nil then
    tmpQueryForm.Free;
  with lbQueryFormNames do
  begin
    if ( ItemIndex >= 0 ) and ( Items[ ItemIndex ] <> '' ) then
    begin
      SafeDeleteKey( FullKey + QueryKey + '\' + Items[ ItemIndex ] );
      Items.Delete( ItemIndex );
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TfrmSQL.stIB_DSQLAfterExecDML(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin
  if StatusBar.Visible then begin
    Statusbar.SimpleText := M_SQL_RowsAffected +
                            IntToStr(Statement.RowsAffected);
  end else begin
    ShowMessage( M_SQL_RowsAffected + IntToStr(Statement.RowsAffected));
  end;
end;

procedure TfrmSQL.sbSearchBarRowCount(Sender: TObject;
  RowCount: Longint);
begin
  if StatusBar.Visible then begin
    Statusbar.SimpleText := M_SQL_RowsCounted + IntToStr( RowCount );
  end else begin
    ShowMessage( M_SQL_RowsCounted + IntToStr( RowCount ));
  end;
end;

procedure TfrmSQL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if csBase.IB_Session.IsYielding then
  begin
    MessageBeep( 0 );
    ShowMessage( M_SQL_SessionBusy );
    CanClose := false;
  end
  else
  if cnEdit.HasActiveTransaction then
  begin
    ShowMessage( M_SQL_CompleteTransaction );
    CanClose := false;
  end
  else
    CanClose := CloseChildForms;
end;

procedure TfrmSQL.stIB_DSQLBeforeExecDML(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin
  if StatusBar.Visible then
    Statusbar.SimpleText := '';
end;

procedure TfrmSQL.dsbCursorBarBeforeAction(Sender: TObject);
begin
  if dsbCursorBar.FocusedButton = dbOpen then
    pcCursor.Activepage := tsCursorData;
end;

procedure TfrmSQL.cnEditCustomizeDPB(Sender: TIB_Connection;
  var BufPtr: Integer; var Buffer: array of Char);
var
  tmpInt: integer;
  tmpStr: string;
begin
  if cbSweepInterval.Checked then begin
    tmpInt := StrToInt( edSweepInterval.Text );
    tmpInt := isc_vax_integer( @tmpInt, SizeOf( integer ));
    SetLength( tmpStr, SizeOf( integer ));
    Move( tmpInt, pchar( tmpStr )^, SizeOf( integer ));
    Sender.BuildDPB( BufPtr, Buffer, isc_dpb_sweep_interval, tmpStr );
  end;
  if cbPageBuffers.Checked then begin
    tmpInt := StrToInt( edPageBuffers.Text );
    tmpInt := isc_vax_integer( @tmpInt, SizeOf( integer ));
    SetLength( tmpStr, SizeOf( integer ));
    Move( tmpInt, pchar( tmpStr )^, SizeOf( integer ));
    Sender.BuildDPB( BufPtr, Buffer, isc_dpb_set_page_buffers, tmpStr );
  end;
  if cbSweep.Checked then begin
    Sender.BuildDPB( BufPtr, Buffer, isc_dpb_sweep, char(isc_dpb_records) );
  end;
end;

procedure TfrmSQL.cbSweepIntervalClick(Sender: TObject);
begin
  if cbSweepInterval.Checked then begin
    edSweepInterval.ReadOnly := false;
    edSweepInterval.Color := clWindow;
  end else begin
    edSweepInterval.ReadOnly := true;
    edSweepInterval.Color := clSilver;
  end;
end;

procedure TfrmSQL.cbPageBuffersClick(Sender: TObject);
begin
  if cbPageBuffers.Checked then begin
    edPageBuffers.ReadOnly := false;
    edPageBuffers.Color := clWindow;
  end else begin
    edPageBuffers.ReadOnly := true;
    edPageBuffers.Color := clSilver;
  end;
end;

procedure TfrmSQL.csBaseAfterDisconnect(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
  cbSweep.State := cbUnchecked;
  cbSweepInterval.State := cbUnchecked;
  cbPageBuffers.State := cbUnchecked;
end;

procedure TfrmSQL.meMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( ssCtrl in Shift ) and ( Key = VK_RETURN ) then begin
    if Sender = meDSQL then begin
      try
        dsqlEdit.ExecSQL;
      finally
        Key := 0;
      end;
    end else if Sender = meCursor then begin
      try
        crEdit.ExecSQL;
      finally
        Key := 0;
      end;
    end;
  end;
end;

procedure TfrmSQL.SpeedButton2Click(Sender: TObject);
var
  s: string;
begin
  s := edSchemaCacheDir.Text;
  if SelectDirectory( s, [ sdAllowCreate, sdPerformCreate, sdPrompt ], 0 ) then
    edSchemaCacheDir.Text := s;
end;

procedure TfrmSQL.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IB_SQL.HLP';
end;

procedure TfrmSQL.CheckLayouts;
begin
  if tsLayouts.TabVisible and not LayoutsLoaded then
  begin
    LayoutsLoaded := true;
    LastActiveNode := nil;
    with tvLayout do
    begin
      Items.BeginUpdate;
      OnChange := nil;
      try
        LoadLayoutNames( '', '' );
        if Items.Count = 0 then
          Selected := InsertGroup( DefaultGroupName, Selected );
        AlphaSort;
        FullCollapse;
        Items.GetFirstNode.Expand( false );
        OnChange := tvLayoutChange;
        if Assigned( LastActiveNode ) then
          Selected := LastActiveNode
        else
          Selected := Items.GetFirstNode;
        Selected.Expand( false );
      finally
        OnChange := tvLayoutChange;
        Items.EndUpdate;
      end;
    end;
  end;
end;

function TfrmSQL.LoadLayoutNames( BaseKey, AKey: string ): boolean;
var
  strG: TStrings;
  ii: integer;
  tmpStr: string;
  node: TTreeNode;
  newnode: TTreeNode;
begin
  Result := false;
  strG := TStringList.Create;
  if AKey = '' then begin
    BaseKey := BaseKey + LayoutKey;
  end else begin
    BaseKey := BaseKey + '\' + AKey + LayoutKey;
  end;
  try
    if FReg.OpenKey( RootKey + BaseKey, false ) then begin
      FReg.GetKeyNames( strG );
      FReg.CloseKey;
      if AKey = '' then begin
        node := InsertGroup( DefaultGroupName, tvLayout.Selected );
      end else begin
        node := InsertGroup( AKey, tvLayout.Selected );
      end;
      if Assigned( node ) then
      begin
        if not Assigned( LastActiveNode ) and
          ( AssembleLayout( Node ) = Layout ) then
          LastActiveNode := Node;
        tvLayout.Selected := node;
        for ii := 0 to strG.Count - 1 do
        begin
          tmpStr := strG[ii];
          if ( tmpStr <> '' ) and
             ( tmpStr <> QueryKeyName ) and
             ( tmpStr <> LayoutKeyName ) then
          begin
            if not LoadLayoutNames( BaseKey, tmpStr ) then
            begin
              if Assigned( node ) then
                tvLayout.Selected := node
              else
                node := node;
              newNode := InsertLayout( tmpStr, node );
              if not Assigned( LastActiveNode ) and
                ( AssembleLayout( newNode ) = Layout ) then
                LastActiveNode := newNode;
            end;
          end;
        end;
        tvLayout.Selected := node.Parent;
      end
      else
        tvLayout.Selected := nil;
      Result := true;
    end;
  finally
    strG.Free;
  end;
end;

function TfrmSQL.InsertGroup( const AGroupName: string;
                                      target: TTreeNode  ): TTreeNode;
begin
  with tvLayout do
  begin
    if not Assigned( target ) then
      target := Items.GetFirstNode;
    if not Assigned( target ) or
       (( target.ImageIndex = GroupImageIndex ) and
        ( target.Text <> DefaultGroupName )) then
      Result := Items.AddChild( target, AGroupName )
    else
      Result := Items.Add( target, AGroupName );
    Result.ImageIndex := GroupImageIndex;
    Result.SelectedIndex := Result.ImageIndex + 1;
  end;
end;

function TfrmSQL.InsertLayout( const ALayoutName: string;
                                       target: TTreeNode ): TTreeNode;
begin
  with tvLayout do
  begin
    while Assigned( target ) and
         ( target.ImageIndex = LayoutImageIndex ) do
      target := target.Parent;
    Result := Items.AddChild( target, ALayoutName );
    Result.ImageIndex := LayoutImageIndex;
    Result.SelectedIndex := Result.ImageIndex + 1;
  end;
end;

procedure TfrmSQL.btGroupClick( Sender: TObject );
var
  s: string;
  node: TTreeNode;
begin
  with tvLayout do begin
    if InputQuery( M_SQL_AskGroupName, '', s ) and
       CheckName( s ) then begin
      if Sender = miCreateGroup then begin
        node := SourceNode;
        SourceNode := nil;
      end else begin
        node := Selected;
      end;
      if not Assigned( node ) or
         not Exists( node.Parent, s, true ) then begin
        node := InsertGroup( Trim( s ), node );
        if Assigned( node ) then begin
          FReg.CreateKey( AssemblePath( node ) + LayoutKey );
          tvLayout.AlphaSort;
          tvLayout.Selected := node;
        end;
      end;
    end;
  end;
end;

procedure TfrmSQL.btLayoutClick(Sender: TObject);
var
  S: string;
  node: TTreeNode;
begin
  with tvLayout do begin
    if InputQuery( M_SQL_AskLayoutName, '', S ) and
       CheckName( S ) then begin
      if Sender = miCreateLayout then begin
        node := SourceNode;
        SourceNode := nil;
      end else begin
        node := Selected;
      end;
      if not Assigned( node ) or
         not Exists( node.Parent, s, true ) then begin
        node := InsertLayout( Trim( s ), node );
        if Assigned( node ) then begin
          FReg.CreateKey( AssemblePath( node ));
          tvLayout.AlphaSort;
          tvLayout.Selected := node;
        end;
      end;
    end;
  end;
end;

procedure TfrmSQL.btDeleteClick(Sender: TObject);
var
  node: TTreeNode;
  st: string;
begin
  if Sender = miDeleteItem then begin
    node := SourceNode;
    SourceNode := nil;
  end else begin
    node := tvLayout.Selected;
  end;
  if Assigned( node ) then begin
    if node.ImageIndex = GroupImageIndex then begin
      st := Format (M_SQL_ConfirmGroupDeletion, [node.Text]);
    end else begin
      st := Format (M_SQL_ConfirmLayoutDeletion, [node.Text]);
    end;
    if MessageDlg( st, mtConfirmation, [mbYes, mbNo], 0 ) = mrYes then begin
      DeleteNode( node );
      if tvLayout.Items.Count = 1 then begin
        btDelete.Enabled := false
      end;
    end;
  end;
end;

function TfrmSQL.Exists(       Node: TTreeNode;
                           const ANodeName: string;
                                 Select: boolean ): Boolean;
begin
  Result := False;
  while not Result and Assigned( Node ) do begin
    Result := AnsiCompareText( Node.Text, ANodeName ) = 0;
    if Result then begin
      if Select then begin
        Node.TreeView.Selected := Node;
      end;
    end else begin
      Node := Node.GetNextSibling
    end;
  end;
end;

procedure TfrmSQL.tvLayoutChange( Sender: TObject; Node: TTreeNode );
begin
  btDelete.Enabled := Assigned( Node ) and ( Node.Text <> DefaultGroupName );
  if csBase.Connected then begin
    BaseConnection.Connected := false;
  end;
  Layout := AssembleLayout( Node );
end;

procedure TfrmSQL.DeleteNode( Node: TTreeNode );
begin
  if Node.Text = DefaultGroupName then
  begin
    MessageBeep( 0 );
    ShowMessage( M_SQL_CannotDeleteDefaultGroup );
    SysUtils.Abort;
  end
  else
  begin
    Layout := '';
    SafeDeleteKey( AssemblePath( Node ));
    if Node = SourceNode then
    begin
      SourceNode.Cut := false;
      SourceNode := nil;
    end;
    Node.Delete
  end;
end;

procedure TfrmSQL.SafeDeleteKey( const fullpath: string );
var
  st: TStrings;
  ii: Integer;
begin
  if FReg.OpenKey( fullpath, False ) then try
    if NeedRecurseRegistry and FReg.HasSubKeys then
    begin
      st := TStringList.Create;
      try
        if FReg.HasSubKeys then
        begin
          FReg.GetKeyNames( st );
          FReg.CloseKey;
          for ii := 0 to st.Count - 1 do
            SafeDeleteKey( fullpath + '\' + st[ii] );
        end
        else
          FReg.CloseKey;
      finally
        st.Free;
      end;
    end else
      FReg.CloseKey;
  finally
    FReg.DeleteKey( fullpath );
  end
end;

procedure TfrmSQL.SafeCopyKey( const oldpath, newpath: String );
var
    st: TStrings;
  ii: Integer;
  IsClosed: boolean;
begin
  if oldPath = Copy( newPath, 1, Length( oldPath )) then
    raise Exception.Create( M_SQL_RecursiveCopyNotAllowed );
  IsClosed := true;
  if FReg.OpenKey( oldpath, False ) then
    try
      IsClosed := false;
      if NeedRecurseRegistry and FReg.HasSubKeys then
      begin
        st := TStringList.Create;
        try
          FReg.GetKeyNames( st );
          FReg.CloseKey;
          IsClosed := true;
          FReg.MoveKey( oldpath, newpath, false );
          for ii := 0 to st.Count - 1 do
            SafeCopyKey( oldpath + '\' + st[ii], newpath + '\' + st[ii] );
        finally
          st.Free;
        end;
      end
      else
      begin
        FReg.CloseKey;
        IsClosed := true;
        FReg.MoveKey( oldpath, newpath, false );
      end;
    finally
      if not IsClosed then
        FReg.CloseKey;
    end
end;

procedure TfrmSQL.SafeMoveKey( const oldpath, newpath: String );
var
  ChangeCase: boolean;
begin
  ChangeCase := AnsiUpperCase( oldPath ) = AnsiUpperCase( newPath );
  if NeedRecurseRegistry then
  begin
    if ChangeCase then
    begin
      SafeCopyKey( oldPath, newPath + 'NEWCASE_0' );
      SafeDeleteKey( oldPath );
      SafeCopyKey( newPath + 'NEWCASE_0', newPath );
      SafeDeleteKey( newPath + 'NEWCASE_0' );
    end
    else
    if oldPath <> newPath then
    begin
      SafeCopyKey( oldPath, newPath );
      SafeDeleteKey( oldPath );
    end;
  end
  else
    if ChangeCase then
    begin
      FReg.MoveKey( oldPath, newPath + 'NEWCASE_0', true );
      FReg.MoveKey( newPath + 'NEWCASE_0', newPath, true );
    end
    else
    if oldPath <> newPath then
      FReg.MoveKey( oldPath, newPath, true );
end;

function TfrmSQL.AssemblePath( Node: TTreeNode ): string;
begin
  if not Assigned( Node ) or ( Node.Text = DefaultGroupName ) then
    Result := ''
  else
  begin
    Result := '\' + Node.Text;
    while Assigned ( Node.Parent ) do
    begin
      if ( Node.Parent.Text <> DefaultGroupName ) then
        Result := LayoutKey + Result;
      Node := Node.Parent;
      if Node.Text <> DefaultGroupName then
        Result := '\' + Node.Text + Result;
    end;
    Result := LayoutKey + Result;
  end;
  Result := RootKey + Result;
end;

function TfrmSQL.AssembleLayout( Node: TTreeNode ): string;
begin
  Result := AssemblePath( Node );
  System.Delete( Result, 1, Length( RootKey ));
  if Pos( LayoutKey, Result ) = 1 then
    System.Delete( Result, 1, Length( LayoutKey ));
  if Result <> '' then
    if Result[1] = '\' then
      System.Delete( Result, 1, 1 );
end;

function TfrmSQL.AssembleCaption( Node: TTreeNode ): string;
var
  tmpPos: integer;
begin
  Result := AssembleLayout( Node );
  tmpPos := Pos( LayoutKey, Result );
  while tmpPos > 0 do
  begin
    System.Delete( Result, tmpPos, Length( LayoutKey ));
    tmpPos := Pos( LayoutKey, Result )
  end;
  for tmpPos := 1 to Length( Result ) do
    if Result[tmpPos] = '\' then
      Result[tmpPos] := '.';
  if Result = '' then
    Result := DefaultGroupName;
  Result := 'IB_SQL - ' + Result;
end;

function TfrmSQL.CheckName( AName: string ): boolean;
begin
  Result := true;
  if ( UpperCase( AName ) = UpperCase( DefaultGroupName )) or
     ( UpperCase( AName ) = UpperCase( LayoutKeyName )) or
     ( UpperCase( AName ) = UpperCase( QueryKeyName )) then
  begin
    Result := false;
    MessageBeep( 0 );
    ShowMessage( M_SQL_ReservedName + AName );
  end
  else if ( Pos( '\', AName ) > 0 ) then
  begin
    Result := false;
    MessageBeep( 0 );
    ShowMessage( M_SQL_BackSlashNotAllowed );
  end
  else if AName = '' then
  begin
    Result := false;
    MessageBeep( 0 );
    ShowMessage( M_SQL_BlankNameNotAllowed );
  end;
end;

procedure TfrmSQL.tvLayoutEdited(     Sender: TObject;
                                      Node: TTreeNode;
                                  var S: string );
var
  newPath: string;
begin
  S := Trim(S);
  if Assigned( Node ) then
  begin
    if not CheckName( S ) or DuplicatedName( Node, S, true ) then
      S := Node.Text
    else
    begin
      newPath := AssemblePath( Node.Parent ) + LayoutKey + '\' + S;
      SafeMoveKey( AssemblePath( Node ), newPath );
      Node.Text := S;
      FLayout := AssembleLayout( Node );
      UpdateCaption;
      if Assigned( Node.Parent ) then
        Node.Parent.AlphaSort
      else
        tvLayout.AlphaSort;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TfrmSQL.tvLayoutDragDrop( Sender, Source: TObject; X,
  Y: Integer );
begin
  StopTimer;
  if not AlreadyFinishDrag then
    Dropped( X, Y, SourceNode );
end;

procedure TfrmSQL.tvLayoutDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  StopTimer;
  if AlreadyFinishDrag then
    Accept := false
  else if GetAsyncKeyState( VK_ESCAPE ) <> 0 then
  begin
    AlreadyFinishDrag := True;
  //tvLayout.EndDrag(False); Bug in control.EndDrag(false)
    Accept := false;
  end
  else if Assigned( SourceNode ) then
  begin
    Accept := CanDrop( X, Y, SourceNode );
  // MSB is interpreted as a negative value.
  // Assume GetAsyncKeyState is not required for this test
    CtrlPressed := GetKeyState( VK_CONTROL ) < 0;
    SetDragCursor;
  end
  else
    Accept := false;
end;

procedure TfrmSQL.tvLayoutEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit := Node.Text <> DefaultGroupName;
end;

procedure TfrmSQL.tvLayoutKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
// This event doesn't fire when dragging, so changes in Ctrl's state
// cannot be detected here.
  CTRLPressed := false;
  if not tvLayout.IsEditing then
    if ( Key = VK_DELETE ) then
      btDelete.Click
    else if ( Key = VK_INSERT ) then
      btLayout.Click;
end;

procedure TfrmSQL.sbExpandAllClick(Sender: TObject);
begin
  with tvLayout do
  begin
    Items.BeginUpdate;
    if Sender = sbExpandAll then
      FullExpand
    else
      FullCollapse;
    Items.EndUpdate;
  end;
end;

// I have to do this in order to overcome the Delphi 2 incompatibility with
// how bitmap resources are stored in the TImageList component.
procedure TfrmSQL.FillImageList;
var
  B: TBitmap;
begin
  B := TBitmap.Create;
  try
    with imLayout do
    begin
      B.LoadFromResourceName( HInstance, 'IB_SQL_GROUP' );
      InsertMasked( 0, B, clPurple );
      B.LoadFromResourceName( HInstance, 'IB_SQL_GROUP_SEL' );
      InsertMasked( 1, B, clPurple );
      B.LoadFromResourceName( HInstance, 'IB_SQL_LAYOUT' );
      InsertMasked( 2, B, clPurple );
      B.LoadFromResourceName( HInstance, 'IB_SQL_LAYOUT_SEL' );
      InsertMasked( 3, B, clPurple );
    end;
  finally
    B.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure TfrmSQL.StartTimer( Y: integer );
begin
  with tvLayout do
  begin
    if ( Y <= Top ) and ( TopItem.AbsoluteIndex > 0 ) then
    begin
      Direction := htAbove;
      tmScroll.Enabled := True
    end
    else
    if ( Y >= Top + Height - 1 ) and
       ( TopItem.AbsoluteIndex + VisibleCount < Items_Count ) then
    begin
      Direction := htBelow;
      tmScroll.Enabled := True;
    end
    else
      Direction := htNowhere;
  end;
end;

procedure TfrmSQL.StopTimer;
begin
  tmScroll.Enabled := False;
  Direction := htNowhere;
end;

procedure TfrmSQL.tmScrollTimer( Sender: TObject );
begin
  case Direction of
    htAbove: tvLayout.TopItem := tvLayout.TopItem.GetPrev;
    htBelow: tvLayout.TopItem := tvLayout.TopItem.GetNext;
    htNowhere: StopTimer;
  end;
end;

procedure TfrmSQL.pmLayoutPopup( Sender: TObject );
begin
  if Assigned( SourceNode ) then
  begin
    miDeleteItem.Enabled := SourceNode.Text <> DefaultGroupName;
    miCopy.Enabled := miDeleteItem.Enabled;
    miCut.Enabled := miDeleteItem.Enabled;
    miPaste.Enabled := Assigned( PasteNode ) and
      CanDrop( RightPoint.X, RightPoint.Y, PasteNode );
  end;
end;

procedure TfrmSQL.miCopyClick(Sender: TObject);
begin
  PasteNode := SourceNode;
  PasteNode.Cut := false;
end;

procedure TfrmSQL.miCutClick(Sender: TObject);
begin
  PasteNode := SourceNode;
  PasteNode.Cut := true;
end;

procedure TfrmSQL.miPasteClick(Sender: TObject);
begin
  Dropped( RightPoint.X, RightPoint.Y, PasteNode );
end;

function TfrmSQL.CanDrop( X, Y: Integer; fromNode: TTreeNode ): Boolean;
var
  targetNode: TTreeNode;
begin
  with tvLayout do
  begin
    targetnode := GetNodeAt( X, Y );
    Result := Assigned( fromNode ) and
              Assigned( targetNode ) and
              ( fromNode <> targetNode ) and
              ( fromNode.Text <> DefaultGroupName ) and
              ( targetNode.ImageIndex = GroupImageIndex ) and
              ( fromNode.Parent <> targetNode ) and
              not ( targetNode.HasAsParent( fromNode )) and
              not DuplicatedName( targetNode.GetFirstChild,
                                  fromNode.Text,
                                  false ) and
              not (( targetNode.Text = DefaultGroupName ) and
                   ( fromNode.Level = 0 ));
  end;
  if Result then
    MarkExpanding( targetNode );
end;

function TfrmSQL.DuplicatedName(       Node: TTreeNode;
                                   const ANodeName: string;
                                         Select: boolean ): Boolean;
begin
  Result := Assigned( Node ) and
            (( Node.Level = 0 ) and Exists( tvLayout.Items.GetFirstNode,
                                            ANodeName,
                                            Select ) or
             ( Node.Level > 0 ) and Exists( Node.Parent.GetFirstChild,
                                            ANodeName,
                                            Select ));
end;

procedure TfrmSQL.Dropped( X, Y: Integer; fromNode: TTreeNode );
var
  oldPath, NewPath: string;
  targetNode: TTreeNode;
begin
  StopTimer;
  _ExpandNode := nil;
  with tvLayout do
  begin
    OnChange := nil;
    Items.BeginUpdate;
    try
      targetNode := GetNodeAt( X, Y );
      if Assigned( targetNode ) and
         ( targetNode.ImageIndex = GroupImageIndex ) then
      begin
        oldPath := AssemblePath( fromNode );
        newPath := AssemblePath( targetNode ) + LayoutKey + '\' + fromNode.Text;
        if fromNode.Cut then
        begin
          SafeMoveKey( oldPath, newPath );
          if ( targetNode.Text = DefaultGroupName ) and
             ( fromNode.ImageIndex = GroupImageIndex ) then
            fromNode.MoveTo( targetNode, naAdd )
          else
            fromNode.MoveTo( targetNode, naAddChild );
          FLayout := AssembleLayout( fromNode );
          Selected := fromNode;
        end
        else
        begin
          SafeCopyKey( oldPath, newPath );
          CopyTreeViewBranch( fromNode, targetNode );
          targetNode.Expand( false );
        end;
        targetNode.AlphaSort;
      end;
    finally
      Items.EndUpdate;
      OnChange := tvLayoutChange;
    end;
  end;
  if Assigned( SourceNode ) then
  begin
    SourceNode.Cut := false;
    SourceNode := nil;
  end;
end;

procedure TfrmSQL.CopyTreeViewBranch( source, dest: TTreeNode );
var
  newNode,
  loopNode: TTreeNode;
begin
  newNode := tvLayout.Items.AddChild( dest, source.Text );
  newNode.Assign( source );
  loopNode := source.GetFirstChild;
  while Assigned( loopNode ) do begin
    CopyTreeViewBranch( loopNode, newNode );
    loopNode := source.GetNextChild( loopNode );
  end;
end;

procedure TfrmSQL.tvLayoutEndDrag( Sender, Target: TObject; X,
  Y: Integer );
begin
  StopTimer;
  if Assigned( SourceNode ) then begin
    SourceNode.Cut := False;
    SourceNode := nil;
  end;
  tvLayout.Repaint;
end;

procedure TfrmSQL.tvLayoutMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  tempPoint: TPoint;
begin
  with tvLayout do begin
    if Assigned( SourceNode ) and ( Button = mbLeft ) then begin
      SourceNode.Cut := false;
      SourceNode := nil
    end;
    SourceNode := GetNodeAt( X, Y );
    if Assigned( SourceNode ) then begin
      if ( Button = mbLeft ) then begin
        VisibleCount := GetVisibleCount( tvLayout );
        Items_Count := Items.Count;
      end else if ( Button = mbRight ) then begin
        RightPoint := Point( X, Y );
        tempPoint := ClientToScreen( RightPoint );
        pmLayout.Popup( tempPoint.X, tempPoint.Y );
      end;
    end;
  end;
end;

procedure TfrmSQL.FormDragOver( Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Sender = pnLayout then begin
    Inc( Y, pnLayout.Top );
  end else if Sender = pcIB_SQL then begin
    Inc( Y, pcIB_SQL.Top );
  end else if Sender = StatusBar then begin
    Inc( Y, StatusBar.Top );
  end else if Sender = pnClose then begin
    Inc( Y, pnClose.Top );
  end;
  if Source = tvLayout then begin
    Accept := false;
    StartTimer( Y - pnLayoutTreeView.Top );
  end;
end;

procedure TfrmSQL.tvLayoutStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  _ExpandNode := nil;
  AlreadyFinishDrag := false;
  SetDragCursor
end;

procedure TfrmSQL.SetDragCursor;
begin
  if Assigned( SourceNode ) then begin
    SourceNode.Cut := not CTRLPressed;
    if CTRLPressed then tvLayout.DragCursor := crDragCopy
                   else tvLayout.DragCursor := crDrag;
  end;
end;

procedure TfrmSQL.tvLayoutKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CTRLPressed := ssCtrl in Shift;
{ This doesn't work: Delphi cannot trap key events while dragging.
It's an oddity for me, but there's nothing I can do at this time.}
end;

procedure TfrmSQL.tvLayoutCompare( Sender: TObject; Node1,
  Node2: TTreeNode; Data: Integer; var Compare: Integer );
begin
  if Node1.ImageIndex = Node2.ImageIndex then begin
    Compare := AnsiCompareText( Node1.Text, Node2.Text );
  end else if Node1.ImageIndex = GroupImageIndex then begin
    Compare := 1;
  end else begin
    Compare := -1;
  end;
end;

procedure TfrmSQL.tmExpandTimer(Sender: TObject);
var
  p: TPoint;
  r: TRect;
  n: TTreeNode;
begin
  if Assigned(_ExpandNode) and GetCursorPos(p) then With tvLayout do begin
    p := ScreenToClient(p);
    if _ExpandNode = GetNodeAt( p.X, p.Y ) then begin
      _ExpandNode.Expand( false );
         { D3 has refresh problems, test in D4 and higher
         Calling Refresh each time is overwhelming
         If you don't care, erase the "//" in the next two lines.}
         //Refresh;
         //{
         r := _ExpandNode.DisplayRect(False);
         if _ExpandNode.Count > 1 then begin // Childs need ad-hoc repainting
            Inc(r.Bottom, (r.Bottom - r.Top) * 3);
            InvalidateRect(Handle, @r, True);
            Update;
            n := _ExpandNode.GetFirstChild;
            if Assigned(n) then begin
               n.MakeVisible;
               n := n.GetNextSibling;
               if Assigned( n ) then n.MakeVisible;
            end;
         end;
      // Sibling needs repainting
         n := _ExpandNode.GetNextSibling;
         if Assigned(n) then begin
           n.MakeVisible;
           r := n.DisplayRect(False);
           Inc(r.Bottom, (r.Bottom - r.Top) * 2);
           InvalidateRect(Handle, @r, True);
           Update;
         end;
      //}
      end;
   end;
   tmExpand.Enabled := False;
   _ExpandNode := nil
end;

procedure TfrmSQL.MarkExpanding( Node: TTreeNode );
begin
  if (Node <> _ExpandNode) and Node.HasChildren and not Node.Expanded then begin
    _ExpandNode := Node;
    tmExpand.Enabled := true;
  end;
end;

procedure TfrmSQL.dsqlEditAfterPrepare(Sender: TIB_Statement);
begin
  inherited;
  if dsqlEdit.ParamCount > 0 then
    pcDSQL.ActivePage := tsDSQLInput;
end;

procedure TfrmSQL.sbStatusClick(Sender: TObject);
begin
  inherited;
  if not Assigned( frmStatus ) then
    Application.CreateForm( TfrmStatus, frmStatus );
  frmStatus.Show;
end;

procedure TfrmSQL.cnEditBeforeConnect(Sender: TIB_Connection);
begin
  cnEdit.ColumnAttributes.Assign( meColumnAttributes.Lines );
  if cbDomainEntries.Checked then
    cnEdit.FieldEntryTypes := cnEdit.FieldEntryTypes + [ fetDomainName ]
  else
    cnEdit.FieldEntryTypes := cnEdit.FieldEntryTypes - [ fetDomainName ];
  if cbSQLTypeEntries.Checked then
    cnEdit.FieldEntryTypes := cnEdit.FieldEntryTypes + [ fetSQLType ]
  else
    cnEdit.FieldEntryTypes := cnEdit.FieldEntryTypes - [ fetSQLType ];
  cnEdit.DefaultNoCase := cbDefaultNoCase.Checked;
  cnEdit.DefaultNoTrailing := cbDefaultNoTrailing.Checked;
end;

procedure TfrmSQL.cnEditBeforeDisconnect(Sender: TIB_Connection);
var
  CanClose: boolean;
begin
  FormCloseQuery( Self, CanClose );
  if not CanClose then
    SysUtils.Abort;
end;

initialization
  NeedRecurseRegistry := OsNeedDeepRegOp;

end.
