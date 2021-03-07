
{                                                                              }
{ IBF_Browse                                                                   }
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
{  Geoff Worboys <geoff@telesiscomputing.com.au>                               }
{  04-May-2002                                                                 }
{     Altered pcBrowseChange so that on ISC errors it will display the error   }
{     dialog and then continue.  The problem was that a database exception     }
{     while opening the dialog was preventing the window from being displayed  }
{     at all - it was created (and not destroyed until disconnect/exit) but    }
{     it would not display.  This change allows the dialog to display, but     }
{     you may continue to get the exception if you continually select the item }
{     with the problem (such as selecting a relation with an invalid trigger   }
{     giving the "Implementation Limit Exceeded" error).                       }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IBF_Browse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Grids, ExtCtrls, ComCtrls, Registry, Menus,

  IBF_Base,

  IB_Header,
  IB_Session,
  IB_Constants,
  IB_Components,
  IB_TransactionSource,
  IB_ConnectionSource,
  IB_Schema,
  IB_CursorGrid,
  IB_StatementGrid,
  IB_SearchPanel,
  IB_Controls,
  IB_TransactionBar,
  IB_StatementBar,
  IB_SearchBar,
  IB_NavigationBar,
  IB_StoredProc,
  IB_UpdateBar,
  IB_Dialogs,

  IBD_Loading,
  IB_Grid;

type
  TfrmBrowse = class(TfrmBase)
    pcBrowse: TPageControl;
    tsRelations: TTabSheet;
    pnRelInf: TPanel;
    Panel22: TPanel;
    IB_NavigationBar2: TIB_NavigationBar;
    cbTables: TCheckBox;
    cbViews: TCheckBox;
    cbSystem: TCheckBox;
    cbDomainInfo: TCheckBox;
    IB_SearchBar1: TIB_SearchBar;
    Panel18: TPanel;
    pcRelExtract: TPageControl;
    tsRelFields: TTabSheet;
    sgExtractFields: TIB_StatementGrid;
    tsData: TTabSheet;
    grBrowse: TIB_Grid;
    tsIndexes: TTabSheet;
    lbIndices: TIB_LookupList;
    tsConstraints: TTabSheet;
    tsTriggers: TTabSheet;
    lbTriggers: TIB_LookupList;
    pnSizerTriggers: TPanel;
    Panel19: TPanel;
    meTriggers: TIB_Memo;
    Panel35: TPanel;
    Label10: TLabel;
    edTriggerSequence: TIB_Edit;
    btEditTrigger: TButton;
    tsSource: TTabSheet;
    tsRelDesc: TTabSheet;
    meRelDesc: TIB_Memo;
    Panel36: TPanel;
    lbRelations: TIB_LookupList;
    pnSizerRelations: TPanel;
    tsProcedures: TTabSheet;
    pnSizerProcedures: TPanel;
    Panel24: TPanel;
    Panel21: TPanel;
    btEditProc: TButton;
    sbExec: TIB_StatementBar;
    tbProcExtract: TIB_TransactionBar;
    Panel33: TPanel;
    Panel34: TPanel;
    pcProcExtract: TPageControl;
    tsProcSource: TTabSheet;
    meProcudureSource: TIB_Memo;
    tsProcedureInputs: TTabSheet;
    IB_StatementGrid5: TIB_StatementGrid;
    tsProcedureOutputs: TTabSheet;
    IB_StatementGrid6: TIB_StatementGrid;
    tsProcDesc: TTabSheet;
    meProcDesc: TIB_Memo;
    tsDomains: TTabSheet;
    pnSizerDomains: TPanel;
    tsGenerators: TTabSheet;
    lbGenerators: TIB_Grid;
    qrTriggerInf: TIB_Query;
    qrProcInf: TIB_Query;
    dsProcInf: TIB_DataSource;
    qrRelInf: TIB_Query;
    dsRelInf: TIB_DataSource;
    dsTriggerInf: TIB_DataSource;
    dsRelations: TIB_DataSource;
    spBrowse: TIB_SearchPanel;
    Panel1: TPanel;
    qrIndexInf: TIB_Query;
    dsIndexInf: TIB_DataSource;
    pnSizerIndex: TPanel;
    meIndexFields: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    Panel3: TPanel;
    pnSizerConstraints: TPanel;
    tsProcDepend: TTabSheet;
    IB_CursorGrid1: TIB_Grid;
    qrProcDepend: TIB_Query;
    dsProcDepend: TIB_DataSource;
    crRelDepend: TIB_Query;
    dsRelDepend: TIB_DataSource;
    tsRelDepend: TTabSheet;
    spExtract: TIB_StoredProc;
    qrRelations: TIB_Query;
    IB_UpdateBar1: TIB_UpdateBar;
    tsFieldList: TTabSheet;
    meFieldList: TMemo;
    Panel4: TPanel;
    meSource: TMemo;
    btNewProc: TButton;
    dsqlEditTrigger: TIB_DSQLDialog;
    dsqlEditProc: TIB_DSQLDialog;
    cbForSelect: TCheckBox;
    tsSPData: TTabSheet;
    cgProcExtract: TIB_CursorGrid;
    dsExtract: TIB_DataSource;
    cbHasDML: TCheckBox;
    IB_Edit3: TIB_CheckBox;
    btNewTrigg: TButton;
    cbTriggerType: TIB_ComboBox;
    tsBLR: TTabSheet;
    meBLR: TIB_RichEdit;
    IB_CursorGrid2: TIB_Grid;
    qrConstraintInf: TIB_Query;
    dsConstraintInf: TIB_DataSource;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    IB_Edit2: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_Edit9: TIB_Edit;
    lbConstraints: TIB_LookupList;
    tsExceptions: TTabSheet;
    qrExcpInf: TIB_Query;
    dsExcp: TIB_DataSource;
    ibExcp: TIB_Grid;
    meExceptionDescription: TIB_Memo;
    pmShowMain: TPopupMenu;
    meDomainSource: TMemo;
    qrDomainInf: TIB_Query;
    dsDomainInf: TIB_DataSource;
    lbDomains: TIB_LookupList;
    lbProcedures: TIB_LookupList;
    qrGenInf: TIB_Query;
    dsGenInf: TIB_DataSource;
    Panel5: TPanel;
    ibGenProc: TIB_Grid;
    ibGenTrig: TIB_Grid;
    qrGenTrig: TIB_Query;
    qrGenProc: TIB_Query;
    dsGenProc: TIB_DataSource;
    dsGenTrig: TIB_DataSource;
    gbFKInf: TGroupBox;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    tsUDFs: TTabSheet;
    ibUDFs: TIB_Grid;
    qrUDFs: TIB_Query;
    dsUDFs: TIB_DataSource;
    Dialogs1: TMenuItem;
    CpNamesClipb: TMenuItem;
    CpRowClipb: TMenuItem;
    CpTableClipb: TMenuItem;
    IB_Edit1: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    miShowFTSInfo: TMenuItem;
    miShowTMPInfo: TMenuItem;
    Label8: TLabel;
    IB_Edit12: TIB_Edit;
    rgFieldNamesLayout: TRadioGroup;
    tbRelations: TIB_TransactionBar;
    miDeleteselectedrecords: TMenuItem;
    miShowRPLInfo: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure IB_ConnectionSourceAfterExecDDL(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure cbDomainInfoClick(Sender: TObject);
    procedure btEditTriggerClick(Sender: TObject);
    procedure btEditProcClick(Sender: TObject);
    procedure pcRelExtractChange(Sender: TObject);
    procedure RelationsClick(Sender: TObject);
    procedure IB_TransactionSourceAfterAssignment(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure IB_ConnectionSourceAfterAssignment(
      Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure pnSizerRelationsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure pnSizerRelationsMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure pnSizerRelationsMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure dsRelationsStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure IB_SearchBar1AfterAction(Sender: TObject);
    procedure dsTriggerInfStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure dsProcInfStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure IB_TransactionSourceAfterCommit(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure qrRelationsPreparedChanged(Sender: TIB_Statement);
    procedure dsRelInfDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure crCallback(IB_Dataset: TIB_Dataset;
      Status: TIB_CallbackStatus; CursorRowNum: Longint;
      var Abort: Boolean);
    procedure cbForSelectClick(Sender: TObject);
    procedure spExtractAfterExecute(Sender: TIB_Statement);
    procedure pcBrowseChange(Sender: TObject);
    procedure tbProcExtractAfterAction(Sender: TObject);
    procedure IB_StatementGrid5KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qrRelationsAfterSearch(IB_Dataset: TIB_Dataset);
    procedure qrRelationsAfterOpen(IB_Dataset: TIB_Dataset);
    procedure FormActivate(Sender: TObject);
    procedure qrRelInfAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qrExcpCustomEID(IB_Dataset: TIB_Dataset);
    procedure qrProcInfBeforeScroll(IB_Dataset: TIB_Dataset);
    procedure qrDomainInfAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qrProcInfAfterScroll(IB_Dataset: TIB_Dataset);
    procedure pcProcExtractChange(Sender: TObject);
    procedure qrRelInfPrepareSQL(Sender: TIB_Statement);
    procedure qrIndexInfAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qrRelationsAfterInsert(IB_Dataset: TIB_Dataset);
    procedure edSetGeneratorKeyPress(Sender: TObject; var Key: Char);
    procedure qrGenInfCalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
    procedure qrGenInfCustomModify(IB_Dataset: TIB_Dataset);
    procedure qrGenInfAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qrUDFsCalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
    procedure pmShowMainPopup(Sender: TObject);
    procedure CopyItemsToClipboard1Click(Sender: TObject);
    procedure CpNamesClipbClick(Sender: TObject);
    procedure CpRowClipbClick(Sender: TObject);
    procedure CpTableClipbClick(Sender: TObject);
    procedure qrDomainInfBeforePrepare(Sender: TIB_Statement);
    procedure IB_Edit9DblClick(Sender: TObject);
    procedure IB_Edit1DblClick(Sender: TObject);
    procedure qrConstraintInfAfterScroll(IB_Dataset: TIB_Dataset);
    procedure IB_Edit12DblClick(Sender: TObject);
    procedure rgFieldNamesLayoutClick(Sender: TObject);
    procedure lbGeneratorsGetCellProps(Sender: TObject; ACol,
      ARow: Integer; AState: TGridDrawState; var AColor: TColor;
      AFont: TFont);
    procedure qrRelInfFilterRecord(ARow: TIB_Row; var Accept: Boolean);
    procedure miShowInfoClick(Sender: TObject);
    procedure miDeleteselectedrecordsClick(Sender: TObject);
  private
    { Private declarations }
    PanelSizing: boolean;
    NeedRefresh: boolean;
    LoadingDialog: TdlgLoading;
    SettingProcedureAttributes: boolean;
    BrowseIsSearching: boolean;
    PopupTarget: TWinControl;
    // Highlights the index, if available, in the Indexes tab.
    procedure LocateIndex(IndexName: string);
    // Highlights the constraint, if available, in the Constraints tab.
    procedure LocateConstraint(ConstraintName: string);
    // Fills meFieldList according to the preferred layout in rgFieldNamesLayout.
    procedure DisplayFieldNamesList;
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
    procedure DialogChildrenClick(Sender: TObject);
    procedure UpdateSource;
  public
    { Public declarations }
    procedure Initialize; override;
    procedure ReadInitialSettings;
  end;

implementation

uses
  IB_Parse, IB_Utils, Clipbrd;

{$R *.DFM}

procedure TfrmBrowse.FormCreate(Sender: TObject);
begin
  inherited;
  BrowseIsSearching := true;
  pcBrowse.ActivePage := tsRelations;
  pcRelExtract.ActivePage := tsRelFields;
  pcProcExtract.ActivePage := tsProcSource;
  grBrowse.Align := alClient;
  lbRelations.AllowLockSession := false;
  lbProcedures.AllowLockSession := false;
end;

procedure TfrmBrowse.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 600, 400 );
end;

procedure TfrmBrowse.Initialize;
begin
  inherited Initialize;
  if ConstructingLevel = 0 then
    ReadInitialSettings;
end;

procedure TfrmBrowse.DoReadSettings;
begin
  with RegDB do
  begin
    lbRelations.Width   := ReadInteger( 'Settings', 'lbRelations.Width',  120 );
    lbTriggers.Width    := ReadInteger( 'Settings', 'lbTriggers.Width',   120 );
    lbIndices.Width     := ReadInteger( 'Settings', 'lbIndices.Width',    120 );
    lbProcedures.Width  := ReadInteger( 'Settings', 'lbProcedures.Width', 120 );
    lbDomains.Width     := ReadInteger( 'Settings', 'lbDomains.Width',    120 );
    lbDomains.Height    := 1;
    lbGenerators.Width  := ReadInteger( 'Settings', 'lbGenerators.Width', 200 );
    lbGenerators.Height := 1;
    lbConstraints.Width := ReadInteger( 'Settings', 'lbConstraints.Width', 120);
    miShowFTSInfo.Checked := ReadBool( 'Settings', 'miShowFTSInfo', true );
    miShowRPLInfo.Checked := ReadBool( 'Settings', 'miShowRPLInfo', true );
    miShowTMPInfo.Checked := ReadBool( 'Settings', 'miShowTMPInfo', true );
    with pcBrowse do
      ActivePage := Pages[ ReadInteger( 'Settings', 'Page Index', 0) ];
    rgFieldNamesLayout.ItemIndex := ReadInteger( 'Settings', 'rgFieldNamesLayout.ItemIndex', 0);
  end;
end;

procedure TfrmBrowse.DoWriteSettings;
begin
  if Assigned( RegDB ) then
  with RegDB do
  begin
    WriteInteger( 'Settings', 'lbRelations.Width', lbRelations.Width );
    WriteInteger( 'Settings', 'lbTriggers.Width', lbTriggers.Width );
    WriteInteger( 'Settings', 'lbIndices.Width', lbIndices.Width );
    WriteInteger( 'Settings', 'lbProcedures.Width', lbProcedures.Width );
    WriteInteger( 'Settings', 'lbDomains.Width', lbDomains.Width );
    WriteInteger( 'Settings', 'lbConstraints.Width', lbConstraints.Width);
    WriteInteger( 'Settings', 'lbGenerators.Width', lbGenerators.Width );
    WriteBool( 'Settings', 'miShowFTSInfo', miShowFTSInfo.Checked );
    WriteBool( 'Settings', 'miShowRPLInfo', miShowRPLInfo.Checked );
    WriteBool( 'Settings', 'miShowTMPInfo', miShowTMPInfo.Checked );
    if ( pcBrowse.ActivePage = tsGenerators ) or
       ( pcBrowse.ActivePage = tsExceptions ) then
      WriteInteger( 'Settings', 'Page Index', 0 )
    else
      WriteInteger( 'Settings', 'Page Index', pcBrowse.ActivePage.PageIndex );
    WriteInteger( 'Settings', 'rgFieldNamesLayout.ItemIndex',
                              rgFieldNamesLayout.ItemIndex);
  end;
end;

procedure TfrmBrowse.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  qrRelations.IB_Connection := AConnection;
  qrTriggerInf.IB_Connection := AConnection;
  qrIndexInf.IB_Connection := AConnection;
  qrProcInf.IB_Connection := AConnection;
  spExtract.IB_Connection := AConnection;
  qrProcDepend.IB_Connection := AConnection;
  crRelDepend.IB_Connection := AConnection;
  qrRelInf.IB_Connection := AConnection;
  qrDomainInf.IB_Connection := AConnection;
  qrGenInf.IB_Connection := AConnection;
  qrGenProc.IB_Connection := AConnection;
  qrGenTrig.IB_Connection := AConnection;
  qrConstraintInf.IB_Connection := AConnection;
  qrExcpInf.IB_Connection := AConnection;
  dsqlEditTrigger.BaseConnection := AConnection;
  dsqlEditProc.BaseConnection := AConnection;
  qrUDFs.IB_Connection := AConnection;
end;

procedure TfrmBrowse.IB_TransactionSourceAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  qrRelations.IB_Transaction := ATransaction;
  qrTriggerInf.IB_Transaction := ATransaction;
  qrIndexInf.IB_Transaction := ATransaction;
  qrProcInf.IB_Transaction := ATransaction;
  qrProcDepend.IB_Transaction := ATransaction;
  crRelDepend.IB_Transaction := ATransaction;
  spExtract.IB_Transaction := ATransaction;
  qrRelInf.IB_Transaction := ATransaction;
  tbProcExtract.IB_Transaction := ATransaction;
  qrExcpInf.IB_Transaction := ATransaction;
  qrDomainInf.IB_Transaction := ATransaction;
  qrGenInf.IB_Transaction := ATransaction;
  qrGenProc.IB_Transaction := ATransaction;
  qrGenTrig.IB_Transaction := ATransaction;
  qrConstraintInf.IB_Transaction := ATransaction;
  qrExcpInf.IB_Transaction := ATransaction;
  dsqlEditTrigger.BaseTransaction := ATransaction;
  dsqlEditProc.BaseTransaction := ATransaction;
  qrUDFs.IB_Transaction := ATransaction;
  tbRelations.IB_Transaction := ATransaction;
end;

{------------------------------------------------------------------------------}

procedure TfrmBrowse.ReadInitialSettings;
begin
  if BaseConnection <> nil then
    with BaseConnection do
    begin
      BeginBusy( true );
      try
        LoadingDialog := TdlgLoading.Create( Self );
        LoadingDialog.lbLoading.Caption := M_Loading_Caption;
        LoadingDialog.Visible := true;
        Application.ProcessMessages;
        try
          Connected := true;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrRelInf.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrIndexInf.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrConstraintInf.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrTriggerInf.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrProcInf.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrDomainInf.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrGenInf.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrGenProc.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrGenTrig.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          qrUDFs.Prepare;
          Application.ProcessMessages;
          if LoadingDialog.Cancelled then SysUtils.Abort;
          pcBrowseChange( nil );
        finally
          LoadingDialog.Free;
          LoadingDialog := nil;
        end;
      finally
        EndBusy;
      end;
    end;
end;

procedure TfrmBrowse.IB_ConnectionSourceAfterExecDDL(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  NeedRefresh := true;
end;

procedure TfrmBrowse.cbDomainInfoClick(Sender: TObject);
begin
  sgExtractFields.DomainInfo := cbDomainInfo.Checked;
  UpdateSource;
end;

procedure TfrmBrowse.qrProcInfAfterScroll(IB_Dataset: TIB_Dataset);
begin
  with qrProcInf do
  begin
    spExtract.StoredProcName :=
      IB_Connection.mkVarIdent( FieldByName( 'RDB$PROCEDURE_NAME' ).AsString );
    pcProcExtractChange( IB_Dataset );
    if Fields.RowState <> rsNone then
      spExtract.Prepare;
  end;
end;

procedure TfrmBrowse.pcProcExtractChange(Sender: TObject);
begin
  if ( pcProcExtract.ActivePage = tsProcDepend ) then
    qrProcDepend.Open;
  meBLR.AutoDisplay := pcProcExtract.ActivePage = tsBLR;
  if not SettingProcedureAttributes then
  begin
    SettingProcedureAttributes := true;
    try
      if qrProcInf.Fields.RowState <> rsNone then
      begin
        if ( spExtract.StoredProcName = '' ) and
           ( spExtract.SQLDialect >= 3 ) then
          spExtract.StoredProcName := '""';
        SubKey := 'Current';
        with RegDB do try
          cbForSelect.Checked := ReadBool( 'ForSelect',
                                           spExtract.StoredProcName,
                                           false );
          cbHasDML.Checked := ReadBool( 'HasDML',
                                        spExtract.StoredProcName,
                                        false );
        finally
          SubKey := '';
        end;
      end
      else
      begin
        cbForSelect.Checked := false;
        cbHasDML.Checked := false;
      end;
    finally
      SettingProcedureAttributes := false;
    end;
  end;
end;

procedure TfrmBrowse.btEditTriggerClick(Sender: TObject);
begin
  if Sender = btNewTrigg then
  begin
    dsqlEditProc.Caption := 'Create Trigger';
    dsqlEditProc.SQL.Clear;
    dsqlEditProc.SQL.Add( 'CREATE TRIGGER NEWTRIGGER FOR ' +
      qrRelInf.IB_Connection.mkVarIdent( 
                  qrRelInf.FieldByName( 'RDB$RELATION_NAME' ).AsString ));
    dsqlEditProc.SQL.Add( '//BEFORE AFTER ' );
    dsqlEditProc.SQL.Add( '//INSERT UPDATE DELETE ' );
    dsqlEditProc.SQL.Add( '//IN ACTIVE' );
    dsqlEditProc.SQL.Add( 'AS' );
    dsqlEditProc.SQL.Add( '//DECLARE VARIABLE ' );
    dsqlEditProc.SQL.Add( 'BEGIN' );
    dsqlEditProc.SQL.Add( '' );
    dsqlEditProc.SQL.Add( 'END' );
    dsqlEditProc.Show;
  end
  else
  begin
    with qrTriggerInf do if Active and not Bof and not Eof then
    begin
      FieldByName('RDB$TRIGGER_SOURCE').AssignTo( dsqlEditTrigger.SQL );
{
      if FieldByName( 'RDB$TRIGGER_INACTIVE' ).AsBoolean then
        dsqlEditTrigger.SQL.Insert( 0, 'INACTIVE' )
      else
        dsqlEditTrigger.SQL.Insert( 0, 'ACTIVE' );
}
      dsqlEditTrigger.SQL.Insert( 0,
        'POSITION ' + FieldByName( 'RDB$TRIGGER_SEQUENCE' ).AsString );
      dsqlEditTrigger.SQL.Insert( 0, cbTriggerType.Text );
      dsqlEditTrigger.SQL.Insert( 0,
        'ALTER TRIGGER ' +
        qrRelInf.IB_Connection.mkVarIdent(
          FieldByName('RDB$TRIGGER_NAME').AsString ));
      dsqlEditTrigger.Show;
    end
    else
      ShowMessage( 'Invalid trigger source' );
  end;
end;

procedure TfrmBrowse.btEditProcClick(Sender: TObject);
begin
  if Sender = btNewProc then
  begin
    dsqlEditProc.Caption := 'Create Stored Procedure';
    dsqlEditProc.SQL.Clear;
    dsqlEditProc.SQL.Add( 'CREATE PROCEDURE NEWPROC //(   )' );
    dsqlEditProc.SQL.Add( '//RETURNS (   )' );
    dsqlEditProc.SQL.Add( 'AS' );
    dsqlEditProc.SQL.Add( '//DECLARE VARIABLE ' );
    dsqlEditProc.SQL.Add( 'BEGIN' );
    dsqlEditProc.SQL.Add( ' SUSPEND;' );
    dsqlEditProc.SQL.Add( 'END' );
    dsqlEditProc.Show;
  end
  else with qrProcInf, Fields do if Active and not Eof then
  begin
    with FieldByName('RDB$PROCEDURE_SOURCE') do
    begin
      dsqlEditProc.Caption := 'Edit Stored Procedure';
      dsqlEditProc.SQL.Text :=
        IB_Parse.GetStoredProcedureSource(
          true, // Is an ALTER PROCEDURE statement
          IB_Connection.mkVarIdent(
            FieldByName( 'RDB$PROCEDURE_NAME' ).AsString ),
          spExtract,
          AsString );
      dsqlEditProc.Show;
    end;
  end
  else
    ShowMessage( 'Invalid procedure source' );
end;

procedure TfrmBrowse.cbForSelectClick(Sender: TObject);
begin
  if Sender = cbForSelect then
  begin
    spExtract.StoredProcForSelect := cbForSelect.Checked;
    spExtract.AutoFetchAll := cbForSelect.Checked;
  end
  else
  if Sender = cbHasDML then
    spExtract.StoredProcHasDML := cbHasDML.Checked;
  tsSPData.TabVisible := cbForSelect.Checked;
  if ( spExtract.StoredProcName <> '' ) and not SettingProcedureAttributes then
  begin
    SubKey := 'Current';
    with RegDB do
      try
        WriteBool( 'ForSelect', spExtract.StoredProcName, cbForSelect.Checked );
        WriteBool( 'HasDML', spExtract.StoredProcName, cbHasDML.Checked );
      finally
        SubKey := '';
      end;
  end;
end;

procedure TfrmBrowse.RelationsClick(Sender: TObject);
begin
  qrRelInf.InvalidateSQL;
  qrRelInf.RefreshKeys;
end;

procedure TfrmBrowse.qrRelInfPrepareSQL(Sender: TIB_Statement);
begin
  with qrRelInf do
  begin
    if not cbSystem.Checked then
      SQLWhereItems.Add( 'RDB$RELATION_NAME NOT STARTING WITH ''RDB$''' );
    if not cbTables.Checked then
      SQLWhereItems.Add( 'RDB$VIEW_BLR IS NOT NULL' );
    if not cbViews.Checked then
      SQLWhereItems.Add( 'RDB$VIEW_BLR IS NULL' );
  end;
end;

procedure TfrmBrowse.pcRelExtractChange(Sender: TObject);
begin
  with qrRelations, lbRelations, csBase, BaseConnection do begin
    if pcRelExtract.Activepage = tsIndexes then
      qrIndexInf.Open;
    if pcRelExtract.Activepage = tsConstraints then
      qrConstraintInf.Open;
    if pcRelExtract.Activepage = tsTriggers then
      qrTriggerInf.Open;
    if pcRelExtract.Activepage = tsRelDepend then
      crRelDepend.Open;
    if pcRelExtract.Activepage = tsData then
      if not ( qrRelations.Active ) and
         ( qrRelInf.Fields.RowState <> rsNone ) then
        if BrowseIsSearching then
          qrRelations.Search
        else
          qrRelations.Open;
  end;
end;

procedure TfrmBrowse.pnSizerRelationsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PanelSizing := true;
end;

procedure TfrmBrowse.pnSizerRelationsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if PanelSizing then
    if Sender = pnSizerRelations then
    begin
      if lbRelations.Width + X < 80 then
        X := 80 - lbRelations.Width;
      lbRelations.Width := lbRelations.Width + X;
    end
    else if Sender = pnSizerTriggers then
    begin
      if lbTriggers.Width + X < 80 then
        X := 80 - lbTriggers.Width;
      lbTriggers.Width := lbTriggers.Width + X;
    end
    else if Sender = pnSizerIndex then
    begin
      if lbIndices.Width + X < 80 then
        X := 80 - lbIndices.Width;
      lbIndices.Width := lbIndices.Width + X;
    end
    else if Sender = pnSizerProcedures then
    begin
      if lbProcedures.Width + X < 80 then
        X := 80 - lbProcedures.Width;
      lbProcedures.Width := lbProcedures.Width + X;
    end
    else if Sender = pnSizerDomains then
    begin
      if lbDomains.Width + X < 80 then
        X := 80 - lbDomains.Width;
      lbDomains.Width := lbDomains.Width + X;
    end
    else if Sender = pnSizerConstraints then
    begin
      if lbConstraints.Width + X < 80 then
        X := 80 - lbConstraints.Width;
      lbConstraints.Width := lbConstraints.Width + X;
    end;
end;

procedure TfrmBrowse.pnSizerRelationsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PanelSizing := false;
end;

procedure TfrmBrowse.FormDestroy(Sender: TObject);
  procedure StripDataSource( AControl: TWinControl );
  var
    ii: integer;
    Aob: TObject;
    Adl: TIB_DataLink;
  begin
    Aob := TObject( AControl.Perform(CM_GETDATALINK, 0, 0));
    if Aob is TIB_DataLink then
    begin
      Adl := Aob as TIB_DataLink;
      if Adl.DataSource <> nil then
        Adl.DataSource := nil;
    end;
    for ii := 0 to AControl.ControlCount -1 do
      if AControl.Controls[ ii ] is TWinControl then
        StripDataSource( TWinControl( AControl.Controls[ ii ] ));
  end;
var
  ii: integer;
begin
  try
    WriteOutSettings;
  except
    Application.HandleException( Self );
  end;
  for ii := 0 to ComponentCount -1 do
  begin
    if Components[ ii ] is TIB_Dataset then
      TIB_Dataset( Components[ ii ] ).Close;
  end;
  for ii := 0 to ComponentCount -1 do
  begin
    if Components[ ii ] is TIB_Statement then
      TIB_Statement( Components[ ii ] ).Unprepare;
  end;
  for ii := 0 to ComponentCount -1 do
  begin
    if Components[ ii ] is TIB_Dataset then
      with TIB_Dataset( Components[ ii ] ) do
      begin
        KeySource := nil;
        MasterSource := nil;
      end
  end;
  StripDataSource( Self );
  inherited;
end;

procedure TfrmBrowse.dsRelationsStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if ADataset <> nil then with ADataset do begin
    grBrowse.Visible := ( State in [ dssBrowse,
                                     dssDelete,
                                     dssEdit,
                                     dssInsert ] ) or
                       (( State in [ dssInactive, dssPrepared ] ) and
                        ( not BrowseIsSearching ));
    spBrowse.Visible := not grBrowse.Visible;
    if NeedToPost then begin
      pcRelExtract.ActivePage := tsData;
    end;
  end else begin
    grBrowse.Visible := false;
    spBrowse.Visible := true;
  end;
end;

procedure TfrmBrowse.IB_SearchBar1AfterAction(Sender: TObject);
begin
  if dsrelations.State = dssSearch then begin
    pcRelExtract.Activepage := tsData;
  end;
end;

procedure TfrmBrowse.dsTriggerInfStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  inherited;
  with qrTriggerInf do
    btEditTrigger.Enabled := Active and not Eof and not Bof;
end;

procedure TfrmBrowse.dsProcInfStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  with qrProcInf do
    btEditProc.Enabled := Active and not Eof and not Bof;
end;

procedure TfrmBrowse.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if qrRelations.Fetching then begin
    qrRelations.AbortFetching;
    MessageBeep( 0 );
    CanClose := false;
  end else begin
    CanClose := true;
  end;
end;

procedure TfrmBrowse.qrProcInfBeforeScroll(IB_Dataset: TIB_Dataset);
begin
  if ( pcProcExtract.ActivePage <> tsProcDepend ) and qrProcDepend.Active then
    qrProcDepend.Close;
end;

procedure TfrmBrowse.IB_TransactionSourceAfterCommit(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  if NeedRefresh then
  begin
    qrRelInf.Refresh;
    qrRelations.Refresh;
    qrTriggerInf.Refresh;
    qrIndexInf.Refresh;
    qrConstraintInf.Refresh;
    qrProcInf.Refresh;
    qrDomainInf.Refresh;
    qrGenInf.Refresh;
    qrExcpInf.Refresh;
    qrUDFs.Refresh;
    NeedRefresh := false;
  end;
end;

procedure TfrmBrowse.qrRelationsPreparedChanged(Sender: TIB_Statement);
begin
  if qrRelations.Prepared then
    DisplayFieldNamesList
  else
    meFieldList.Lines.Clear;
end;

procedure TfrmBrowse.dsRelInfDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  if not ( csDestroying in ComponentState ) then
    UpdateSource;
end;

procedure TfrmBrowse.crCallback(IB_Dataset: TIB_Dataset;
  Status: TIB_CallbackStatus; CursorRowNum: Longint; var Abort: Boolean);
begin
  if Assigned( LoadingDialog ) then
  begin
    if LoadingDialog.Cancelled then
    begin
      Abort := true;
      MessageBeep(0);
    end
    else
      LoadingDialog.Visible := true;
  end
  else
    IB_Dataset.DefaultProcessCallback( Status );
end;

procedure TfrmBrowse.spExtractAfterExecute(Sender: TIB_Statement);
begin
  if ( spExtract.ParamCount > 0 ) and
     ( spExtract.FieldCount > 0 ) and
     ( pcProcExtract.ActivePage = tsProcedureInputs ) then
  begin
    if spExtract.StoredProcForSelect then
      pcProcExtract.ActivePage := tsSPData
    else
      pcProcExtract.ActivePage := tsProcedureOutputs;
  end;
end;

procedure TfrmBrowse.pcBrowseChange(Sender: TObject);
begin
  try
    if ( pcBrowse.ActivePage = tsRelations ) then
      qrRelInf.Open
    else
    if ( pcBrowse.ActivePage = tsProcedures ) then
      qrProcInf.Open
    else
    if ( pcBrowse.ActivePage = tsDomains ) then
      qrDomainInf.Open
    else
    if ( pcBrowse.ActivePage = tsGenerators ) then
    begin
      qrGenInf.Open;
      qrGenProc.Open;
      qrGenTrig.Open;
    end
    else
    if ( pcBrowse.ActivePage = tsExceptions ) then
      qrExcpInf.Open
    else
    if ( pcBrowse.ActivePage = tsUDFs ) then
      qrUDFs.Open;
  except
    on E: EIB_ISCError do
      E.ShowDialog;
  end;
end;

procedure TfrmBrowse.tbProcExtractAfterAction(Sender: TObject);
begin
  if tbProcExtract.FocusedButton = tbCommitRetaining then
    if ( spExtract.ParamCount > 0 ) and
       ( spExtract.FieldCount > 0 ) and
       ( pcProcExtract.ActivePage = tsProcedureOutputs ) then
      pcProcExtract.ActivePage := tsProcedureInputs;
end;

procedure TfrmBrowse.IB_StatementGrid5KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( Key = VK_RETURN ) and ( ssCtrl in Shift ) then
    spExtract.ExecProc;
end;

procedure TfrmBrowse.qrRelationsAfterSearch(IB_Dataset: TIB_Dataset);
begin
  BrowseIsSearching := true;
end;

procedure TfrmBrowse.qrRelationsAfterOpen(IB_Dataset: TIB_Dataset);
begin
  BrowseIsSearching := IB_Dataset.SQLWhereChanged;
end;

procedure TfrmBrowse.qrRelationsAfterInsert(IB_Dataset: TIB_Dataset);
begin
  BrowseIsSearching := false;
end;

procedure TfrmBrowse.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

procedure TfrmBrowse.UpdateSource;
var
  tmpCol: TIB_Column;
  tmpStrings: TIB_StringList;
begin
  if ( csDestroying in ComponentState ) then Exit;
  with qrRelInf do
  begin
    tmpCol := FieldByName( 'RDB$VIEW_SOURCE' );
    if ( Fields.RowState = rsNone ) or ( not qrRelations.Prepared ) then
      meSource.Lines.Clear
    else
    begin
      if tmpCol.IsNull then
      begin
        qrRelations.GetCreateTableSQL( meSource.Lines,
                                       cbDomainInfo.Checked,
                                       true );
        tmpStrings := TIB_StringList.Create;
        try
          qrRelations.GetAlterTableSQL( tmpStrings );
          if tmpStrings.Count > 0 then
          begin
            meSource.Lines.Add( EmptyStr );
            meSource.Lines.AddStrings( tmpStrings );
          end;
        finally
          tmpStrings.Free;
        end;
      end
      else
        tmpCol.AssignTo( meSource.Lines );
    end;
  end;
end;

procedure TfrmBrowse.qrRelInfAfterScroll(IB_Dataset: TIB_Dataset);
var
  tmpVal: longbool;
  ii, jj: integer;
  tmpStr: string;
  tmpStrings: TIB_StringList;
  tmpBool: boolean;
begin
  tmpBool := false;
  tmpVal := LockWindowUpdate( pnRelInf.Handle );
  try
    with qrRelInf do
    begin
      if ( stLitCriteria( qrRelations.KeyRelation ) <>
           FieldByName( 'RDB$RELATION_NAME' ).AsString ) or
         ( qrRelations.KeyRelation = '' ) then
      begin
        qrRelations.Unprepare;
        qrRelations.KeyRelation :=
          qrRelations.IB_Connection.mkVarIdent(
            FieldByName( 'RDB$RELATION_NAME' ).AsString );
        if Fields.RowState <> rsNone then
        begin
          qrRelations.SQLFrom.Text := 'FROM ' + qrRelations.KeyRelation;
          qrRelations.OrderingItems.Clear;
          qrRelations.OrderingLinks.Clear;
          qrRelations.OrderingItemNo := 0;
          with qrRelations, IB_Connection.SchemaCache.IndexDefs do
          begin
            for ii := 0 to Count - 1 do
            begin
              if IndexParamValue[ ii, 'REL' ] = KeyRelation then
              begin
                if IndexParamIsSet[ ii, 'PK' ] then
                begin
                  OrderingItems.Insert( 0, IndexNames[ ii ] + '=' +
                                           IndexParamValue[ ii, 'SEGS' ] );
                  tmpBool := true;
                end
                else
                  OrderingItems.Add( IndexNames[ ii ] + '=' +
                                     IndexParamValue[ ii, 'SEGS' ] );
              end;
            end;
          end;
          with qrRelations do
          begin
            with IB_Connection.SchemaCache.TableFields do
              tmpStr := LinkValues[ KeyRelation ];
            if tmpStr <> '' then
            begin
              jj := OrderingItems.Count;
              tmpStrings := TIB_StringList.Create;
              try
                ExtractFieldsIntoList( tmpStr, tmpStrings );
                for ii := 0 to tmpStrings.Count - 1 do
                begin
                  Inc( jj );
                  OrderingItems.Add( tmpStrings[ii] + '=' +
                                     tmpStrings[ii] + ' ASC;' +
                                     tmpStrings[ii] + ' DESC' );
                  OrderingLinks.Add( tmpStrings[ii] + '=ITEM=' + IntToStr(jj));
                end;
              finally
                tmpStrings.Free;
              end;
            end;
          end;
          if ( qrRelations.OrderingItems.Count > 0 ) and tmpBool then
            qrRelations.OrderingItemNo := 1;
          qrRelations.KeyLinksAutoDefine := true;
          try
            qrRelations.Prepare;
          except
            qrRelations.KeyLinksAutoDefine := false;
            qrRelations.Prepare;
          end;
        end
        else
          qrRelations.SQLFrom.Text := 'FROM <NO TABLE>';
      end;
      UpdateSource;
    end;
    if pcRelExtract.Activepage <> tsRelDepend then
      crRelDepend.Close;
    pcRelExtractChange( nil );
  finally
    if tmpVal then
      LockWindowUpdate( 0 );
  end;
end;

procedure TfrmBrowse.qrExcpCustomEID(IB_Dataset: TIB_Dataset);
begin
  inherited;
  with qrExcpInf do
  begin
    case State of
      dssEdit:
        if FieldByName( 'RDB$EXCEPTION_NAME' ).IsModified then
        begin
          ExecuteImmediate( 'DROP EXCEPTION ' +
                            IB_Connection.mkVarIdent(
                              FieldByName( 'RDB$EXCEPTION_NAME' ).OldAsString ),
                              nil );
          ExecuteImmediate( 'CREATE EXCEPTION ' +
                            IB_Connection.mkVarIdent(
                              FieldByName( 'RDB$EXCEPTION_NAME' ).AsString ) +
                            ' ''' +
                            FieldByName( 'RDB$MESSAGE' ).AsString +
                            '''',
                            nil );
        end
        else
        if FieldByName( 'RDB$MESSAGE' ).IsModified then
        begin
          ExecuteImmediate( 'ALTER EXCEPTION ' +
                            IB_Connection.mkVarIdent( 
                             FieldByName( 'RDB$EXCEPTION_NAME' ).OldAsString ) +
                            ' ''' +
                            FieldByName( 'RDB$MESSAGE' ).AsString +
                            '''',
                            nil );
        end;
      dssInsert:
        ExecuteImmediate( 'CREATE EXCEPTION ' +
                          IB_Connection.mkVarIdent( 
                            FieldByName( 'RDB$EXCEPTION_NAME' ).AsString ) +
                          ' ''' +
                          FieldByName( 'RDB$MESSAGE' ).AsString +
                          '''',
                          nil );
      dssDelete:
        ExecuteImmediate( 'DROP EXCEPTION ' +
                          IB_Connection.mkVarIdent(
                            FieldByName( 'RDB$EXCEPTION_NAME' ).AsString ),
                          nil );
    end;
    IB_Transaction.Activate;
  end;
end;

procedure TfrmBrowse.qrDomainInfAfterScroll(IB_Dataset: TIB_Dataset);
begin
  with meDomainSource.Lines, qrDomainInf do if not Eof then
  begin
    BeginUpdate;
    try
      Clear;
      Add( 'CREATE DOMAIN ' +
            IB_Connection.mkVarIdent(
              FieldByName( 'RDB$FIELD_NAME' ).AsString ) + ' ' +
            ExtractColSourceFromBLR(
              FieldByName( 'RDB$FIELD_TYPE' ).AsInteger,
              FieldByName( 'RDB$CHARACTER_LENGTH' ).AsInteger,
              FieldByName( 'RDB$FIELD_SCALE' ).AsInteger,
              FieldByName( 'RDB$SEGMENT_LENGTH' ).AsInteger,
              FieldByName( 'RDB$FIELD_SUB_TYPE' ).AsInteger,
              FieldByName( 'RDB$FIELD_PRECISION' ).AsInteger,
              IB_Connection.SQLDialect ));
      with FieldByName( 'CHARACTER_SET_NAME' ) do
        if IsNotNull and ( AsString <> 'NONE' ) then
          Add( '  CHARACTER SET ' + AsString );
      with FieldByName( 'RDB$COMPUTED_SOURCE' ) do
        if IsNotNull then
          Add( '  ' + AsString );
      with FieldByName( 'RDB$DEFAULT_SOURCE' ) do
        if IsNotNull then
          Add( '  ' + AsString );
      with FieldByName( 'RDB$NULL_FLAG' ) do
        if AsInteger = 1 then
          Add( '  NOT NULL' );
      with FieldByName( 'RDB$VALIDATION_SOURCE' ) do
        if IsNotNull then
          Add( '  ' + AdjustLineBreaks( AsString ));
      if FieldByName( 'RDB$COLLATION_ID' ).AsInteger > 0
      then With FieldByName( 'COLLATION_NAME' ) do
        if IsNotNull then
          Add( '  COLLATE ' + AsString );
    finally
      EndUpdate;
    end;
  end;
end;

procedure TfrmBrowse.qrIndexInfAfterScroll(IB_Dataset: TIB_Dataset);
begin
  SchemaIndexSegmentsInfo( qrIndexInf.IB_Connection,
                           qrIndexInf.IB_Transaction,
                           meIndexFields.Lines,
    qrIndexInf.IB_Connection.mkVarIdent( 
                qrIndexInf.FieldByName('RDB$INDEX_NAME').AsString ));
end;

procedure TfrmBrowse.edSetGeneratorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not ( Key in [ #0..#31, '0'..'9', '+', '-' ] ) then
    Key := #0;
end;

procedure TfrmBrowse.qrGenInfCalculateField(Sender: TIB_Statement;
  ARow: TIB_Row; AField: TIB_Column);
var
  ii: integer;
  tmpStr: string;
  tmpLen: integer;
  tmpInt64: ISC_INT64;
begin
  if Assigned( AField ) and ( AField.FieldName = 'GEN_VALUE' ) then
    with qrGenInf do
      if ( State <> dssInsert ) then
      begin
        tmpStr := IB_Connection.mkVarIdent(
          TrimRight( ARow.ByName('RDB$GENERATOR_NAME').AsString ));
        if ( tmpStr <> '' ) and GetGeneratorValue( IB_Connection,
                                                   IB_Transaction,
                                                   tmpStr,
                                                   0,
                                                   tmpInt64 ) then
          AField.AsInt64 := tmpInt64
        else
          AField.AsString := '';
        tmpStr := AField.AsString;
        tmpLen := Length( tmpStr );
        ii := tmpLen - 3;
        while ii >= 1 do
        begin
          if tmpStr[ii] in ['0'..'9'] then
            System.Insert( ThousandSeparator, tmpStr, ii + 1 );
          Dec( ii, 3 );
        end;
        AField.AsString := tmpStr;
      end;
end;

procedure TfrmBrowse.lbGeneratorsGetCellProps(Sender: TObject; ACol,
  ARow: Integer; AState: TGridDrawState; var AColor: TColor; AFont: TFont);
var
  tmpCol: TIB_Column;
begin
  if dsGenInf.Active and Assigned( AFont ) then
    with lbGenerators do
      if ARow >= FixedRows then
      begin
        tmpCol := GridFields[ DataCol[ ACol ]];
        if Assigned( tmpCol ) and ( tmpCol.FieldName = 'GEN_VALUE' ) then
          AFont.Name := 'Courier New';
      end;
end;

procedure TfrmBrowse.qrGenInfCustomModify(IB_Dataset: TIB_Dataset);
var
  tmpStr: string;
begin
  with qrGenInf do
  begin
    tmpStr := Trim( strip_char( FieldByName( 'GEN_VALUE' ).AsString,
                                ThousandSeparator ));
    if tmpStr = '' then
      tmpStr := '0';
    if State = dssInsert then
      qrRelations.ExecuteImmediate(
        'CREATE GENERATOR ' +
        IB_Connection.mkVarIdent(
          FieldByName( 'RDB$GENERATOR_NAME' ).AsString ),
          nil );
    try
      qrRelations.ExecuteImmediate(
        'SET GENERATOR ' +
        IB_Connection.mkVarIdent(
          FieldByName( 'RDB$GENERATOR_NAME' ).AsString ) +
        ' TO ' + tmpStr, nil );
    except
      Application.HandleException( Self );
    end;
  end;
end;

procedure TfrmBrowse.qrGenInfAfterScroll(IB_Dataset: TIB_Dataset);
var
  tmpStr: string;
begin
  if qrGenInf.Fields.RowState <> rsNone then
  begin
    tmpStr := qrGenInf.IB_Connection.mkVarIdent( 
                        qrGenInf.FieldByName( 'RDB$GENERATOR_NAME' ).AsString );
    tmpStr := chr( blr_gen_id ) + chr( Length( tmpStr )) + tmpStr;
    if qrGenProc.ParamByName( 'name' ).AsString <> tmpStr then
    begin
      qrGenProc.ParamByName( 'name' ).AsString := tmpStr;
      qrGenTrig.ParamByName( 'name' ).AsString := tmpStr;
    end;
    qrGenProc.Open;
    qrGenTrig.Open;
  end
  else
  begin
    qrGenProc.Close;
    qrGenTrig.Close;
  end;
end;

procedure TfrmBrowse.qrUDFsCalculateField(Sender: TIB_Statement;
  ARow: TIB_Row; AField: TIB_Column);
begin
  inherited;
  // Beware: optimization assumes only these two fields are calculated.
  	if ARow.ByName('RDB$ARGUMENT_POSITION').AsSmallInt
   	= ARow.ByName('Z').AsSmallInt
	//if (AField.FieldName = 'FUNCTION_NAME')
   //or (AField.FieldName = 'ENTRYPOINT')
   then AField.AsString := ARow.ByName('RDB$' + AField.FieldName ).AsString
   else AField.Clear;
   if ARow.ByName('MECHANISM').IsNull
   then ARow.ByName('MECHANISM').AsString := 'FREE IT'
end;

procedure TfrmBrowse.pmShowMainPopup(Sender: TObject);
var
  p: TPoint;
  b: Boolean;
  loop: Integer;
  mi: TMenuItem;
{$IFNDEF VER90}    
  cf: TCustomForm;
{$ELSE}
  cf: TForm;
{$ENDIF}
begin
  inherited;
  if not GetCursorPos( p ) then
    Exit;
  PopupTarget := FindVCLWindow( p );
  b := Assigned( PopupTarget ) and ( PopupTarget is TIB_CustomGrid );
    with PopupTarget as TIB_CustomGrid do
  begin
    if b then
      b := Assigned( DataSource ) and
           Assigned( DataSource.Dataset ) and
           DataSource.Dataset.BufferActive;
// CopyItemsToClipboard1.Enabled := b;
   CpNamesClipb.Enabled := b;
   CpRowClipb.Enabled := b;
   CpTableClipb.Enabled := b;
   miDeleteselectedrecords.Enabled := b and DataSource.Dataset.CanDelete;
  end;
  //Dialogs1.Delete
  while Dialogs1.Count > 0 do
    Dialogs1.Items[0].Free;
{$IFNDEF VER90}    
  for loop := Screen.CustomFormCount - 1 downto 0 do
  begin
    cf := Screen.CustomForms[loop];
{$ELSE}
  for loop := Screen.FormCount - 1 downto 0 do
  begin
    cf := Screen.Forms[loop];
{$ENDIF}
    if cf.Visible and cf.Enabled then
    begin
       mi := TMenuItem.Create(Self);
       try
         if cf = Application.MainForm then
           mi.Caption := 'Main'
         else
           mi.Caption := cf.Caption;
         mi.GroupIndex := 1;
         mi.Checked := cf = Self;
         mi.Tag := loop;
         mi.OnClick := DialogChildrenClick;
         Dialogs1.Add( mi )
       except
         mi.Free;
       end;
    end;
  end;
end;

procedure TfrmBrowse.CopyItemsToClipboard1Click(Sender: TObject);
var
  sl: TStringList;
  ii: integer;
  ss: string;
  WasVisible: Boolean;
begin
  with ( PopupTarget as TIB_CustomGrid ), DataSource.Dataset do
  begin
    FetchAll;
    if FetchingAborted then
      Exit;
    sl := TIB_StringList.Create;
    try
      BufferFirst;
      while not BufferEof do
      begin
        ss := '';
        WasVisible := False;
        for ii := 0 to BufferFields.ColumnCount - 1 do
          with BufferFields[ ii ] do
            if Visible then
            begin
              if (ii > 0) and WasVisible then
                ss := ss + ',';
              WasVisible := True;
              if IsNotNull then
              begin
                if IsText then
                  ss := ss + '"' +
                             cvLitCriteria(
                             getCharValues( BufferFields[ii].AsString ), '"' ) +
                             '"'
                else
                if IsDateTime then
                  ss := ss + '"' +
                             cvLitCriteria( BufferFields[ii].AsString, '"' ) +
                             '"'
                else
                  ss := ss + BufferFields[ii].AsString;
              end
              else
                 ss := ss + 'NULL';
            end;
        sl.Add( ss );
        BufferNext;
        if sl.Count > BufferRowCount then
          Break;
      end;
      clipboard.AsText := sl.Text;
    finally
      sl.Free;
    end;
  end;
end;

procedure TfrmBrowse.miDeleteselectedrecordsClick(Sender: TObject);
var
  sl: TStringList;
  ii: integer;
  ss: string;
  rn: integer;
begin
  with ( PopupTarget as TIB_CustomGrid ), DataSource.Dataset as TIB_BDataset do
  begin
    if Fetching then Exit;
    rn := RowNum;
    ss := Bookmark;
    sl := TIB_StringList.Create;
    try
      SelectedBookmarks( sl );
      for ii := 0 to sl.Count -1 do
      begin
        Bookmark := sl[ ii ];
        if Bookmark = sl[ ii ] then
          Delete
        else
          raise Exception.Create( 'Failed to locate record.' );
      end;
    finally
      sl.Free;
      Bookmark := ss;
      if Bookmark <> ss then RowNum := rn;
    end;
  end;
end;

procedure TfrmBrowse.DialogChildrenClick(Sender: TObject);
begin
  if Sender is TMenuItem then
    with TMenuItem(Sender) do
    begin
      if (Parent <> Dialogs1) or (Checked) then
        Exit;
      // Incredible, no native Restore method and API's OpenICon doesn't work.
{$IFNDEF VER90}
      with Screen.CustomForms[Tag] do
{$ELSE}
      with Screen.Forms[Tag] do
{$ENDIF}
      	if WindowState = wsMinimized then
          ShowWindow( Handle, SW_RESTORE )
        else
          SetFocus;
    end;
end;

procedure TfrmBrowse.CpNamesClipbClick(Sender: TObject);
var
  sl: TStringList;
  tmpCol: TIB_Column;
begin
  with TIB_CustomGrid( PopupTarget ), DataSource.Dataset do
  begin
    if Assigned( SelectedField ) then
    begin
      tmpCol := BufferFieldByName( SelectedField.BestFieldName );
      FetchAll;
      if FetchingAborted then
        Exit;
      sl := TStringList.Create;
      try
        BufferFirst;
        while not BufferEof do
        begin
          with tmpCol do
            if IsNull then
              sl.Add( 'NULL' )
            else
            if IsText then
              sl.Add( '"' +
                      cvLitCriteria(
                      getCharValues( AsString ), '"' ) +
                      '"' )
            else
            if IsDateTime then
              sl.Add( '"' +
                      cvLitCriteria( AsString, '"' ) +
                      '"' )
            else
              sl.Add( AsString );
          BufferNext;
        end;
        Clipboard.AsText := sl.Text;
      finally
        sl.Free
      end;
    end;
  end
end;

procedure TfrmBrowse.CpRowClipbClick(Sender: TObject);
var
  sl: TStringList;
  loop: integer;
begin
  inherited;
  sl := TStringList.Create;
  with TIB_CustomGrid( PopupTarget ), DataSource.Dataset as TIB_BDataset do
    try
      if IsEmpty then
        Exit;
      BufferRowNum := RowNum; // Sorry, I don't know another workaround.
      for loop := 0 to GridFieldCount - 1 do
        with BuffFields[loop] do
          if IsNull then
            sl.Add( 'NULL' )
          else
          if IsText then
            sl.Add( '"' +
                    cvLitCriteria(
                    getCharValues( AsString ), '"' ) +
                    '"' )
          else
          if IsDateTime then
            sl.Add( '"' +
                    cvLitCriteria( AsString, '"' ) +
                    '"' )
          else
            sl.Add( AsString );
      Clipboard.AsText := sl.Text;
    finally
      sl.Free
    end;
end;

procedure TfrmBrowse.CpTableClipbClick(Sender: TObject);
var
  sl,
  s2: TStringList;
  loop: integer;
begin
  sl := TStringList.Create;
  s2 := TStringList.Create;
  with TIB_CustomGrid( PopupTarget ), DataSource.Dataset do
    try
      BufferFirst;
      while not BufferEof do
      begin
      	s2.Clear;
      	for loop := 0 to GridFieldCount - 1 do
         	s2.Add( BuffFields[loop].AsString );
        sl.Add( s2.CommaText );
        BufferNext;
      end;
      Clipboard.AsText := sl.Text;
    finally
      sl.Free;
      s2.Free;
    end;
end;

procedure TfrmBrowse.qrDomainInfBeforePrepare(Sender: TIB_Statement);
const
	s1: String = ',F.RDB$FIELD_PRECISION';
   s2: String = ',cast(0 as integer) as RDB$FIELD_PRECISION';
begin
  inherited;
  With Sender as TIB_Dataset, SQLSelect do
    if IB_Connection.Characteristics.dbODS_Version >= 10
    then begin
      if IndexOf(s1) < 0
      then Add(s1);
      if IndexOf(s2) > 0
      then Delete(IndexOf(s2))
    end
    else begin
      if IndexOf(s2) < 0
    	then Add(s2);
      if IndexOf(s1) > 0
      then Delete(IndexOf(s1))
    end
end;

procedure TfrmBrowse.IB_Edit9DblClick(Sender: TObject);
begin
  inherited;
  with Sender as TIB_Edit do begin
    if Text <> '' then
      LocateIndex(Text);
  end;
end;

procedure TfrmBrowse.IB_Edit1DblClick(Sender: TObject);
var
  ConstraintName: string;
begin
  inherited;
  with Sender as TIB_Edit do begin
    ConstraintName := Text;
    if ConstraintName <> '' then begin
      if qrRelInf.Locate('RDB$RELATION_NAME',
                        qrConstraintInf.FieldByName('PARENT_RELATION').AsString,
                         [lopCaseInsensitive]) then
        LocateConstraint(ConstraintName);
    end;
  end;
end;

procedure TfrmBrowse.IB_Edit12DblClick(Sender: TObject);
begin
  inherited;
  with Sender as TIB_Edit do begin
    if Text <> '' then
      qrRelInf.Locate('RDB$RELATION_NAME', Text, [lopCaseInsensitive]);
  end;
end;

procedure TfrmBrowse.LocateIndex(IndexName: string);
var
  WasOpen: Boolean;
begin
  WasOpen := qrIndexInf.Active;
  if not WasOpen then
    qrIndexInf.Open;
  if qrIndexInf.Locate('RDB$INDEX_NAME', IndexName, [lopCaseInsensitive]) then
    pcRelExtract.ActivePage := tsIndexes
  else if not WasOpen then
    // Leave the query in the state it was before.
    qrIndexInf.Close;
end;

procedure TfrmBrowse.LocateConstraint(ConstraintName: string);
var
  WasOpen: Boolean;
begin
  WasOpen := qrConstraintInf.Active;
  if not WasOpen then
    qrConstraintInf.Open;
  if qrConstraintInf.Locate( 'RDB$CONSTRAINT_NAME',
                             ConstraintName, [lopCaseInsensitive] ) then
    pcRelExtract.ActivePage := tsConstraints
  else if not WasOpen then
    // Leave the query in the state it was before.
    qrConstraintInf.Close;
end;

procedure TfrmBrowse.qrConstraintInfAfterScroll(IB_Dataset: TIB_Dataset);
begin
  inherited;
  gbFKInf.Visible :=
    CompareText( IB_DataSet.FieldByName( 'RDB$CONSTRAINT_TYPE').AsString,
                                         'FOREIGN KEY' ) = 0;
end;

procedure TfrmBrowse.DisplayFieldNamesList;
var
  FieldNames: TStrings;
  S, Separator: string;
  g: Integer;
begin
  // I could have used StringReplace, but I don't know if
  // it's available in all supported Delphi versions.
  FieldNames := TStringList.Create;
  try
    qrRelations.GetFieldNamesList(FieldNames);
    case rgFieldNamesLayout.ItemIndex of
      0: Separator := #13#10;
      1: Separator := ';';
      2: Separator := ', ';
    end;
    S := '';
    for g := 0 to FieldNames.Count - 1 do
      if S = '' then
        S := FieldNames[g]
      else
        S := S + Separator + FieldNames[g];
    meFieldList.Lines.Text := S;
  finally
    FieldNames.Free;
  end;
end;

procedure TfrmBrowse.rgFieldNamesLayoutClick(Sender: TObject);
begin
  inherited;
  DisplayFieldNamesList;
end;

procedure TfrmBrowse.miShowInfoClick(Sender: TObject);
begin
  inherited;
  with Sender as TMenuItem do
    Checked := not Checked;
  qrRelInf.RefreshFilteredRows;
  qrDomainInf.RefreshFilteredRows;
  qrTriggerInf.RefreshFilteredRows;
  qrProcInf.RefreshFilteredRows;
  qrGenInf.RefreshFilteredRows;
  qrExcpInf.RefreshFilteredRows;
  qrConstraintInf.RefreshFilteredRows;
end;

procedure TfrmBrowse.qrRelInfFilterRecord(ARow: TIB_Row;
  var Accept: Boolean);
var
  tmpCol: TIB_Column;
begin
  inherited;
  if not miShowFTSInfo.Checked or
     not miShowRPLInfo.Checked or
     not miShowTMPInfo.Checked then
  begin
    if ARow.GetByName( 'RDB$RELATION_NAME', tmpCol ) or
       ARow.GetByName( 'RDB$FIELD_NAME', tmpCol ) or
       ARow.GetByName( 'RDB$TRIGGER_NAME', tmpCol ) or
       ARow.GetByName( 'RDB$PROCEDURE_NAME', tmpCol ) or
       ARow.GetByName( 'RDB$GENERATOR_NAME', tmpCol ) or
       ARow.GetByName( 'RDB$EXCEPTION_NAME', tmpCol ) or
       ARow.GetByName( 'RDB$CONSTRAINT_NAME', tmpCol ) then
    begin
      if not miShowFTSInfo.Checked then
        if Copy( tmpCol.AsString, 1, 4 ) = 'FTS$' then Accept := false;
      if not miShowRPLInfo.Checked then
        if Copy( tmpCol.AsString, 1, 4 ) = 'RPL$' then Accept := false;
      if not miShowTMPInfo.Checked then
        if Copy( tmpCol.AsString, 1, 4 ) = 'TMP$' then Accept := false;
    end;
  end;
end;

end.

