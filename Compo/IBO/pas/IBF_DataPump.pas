
{                                                                              }
{ IBF_DataPump                                                                 }
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
  IBF_DataPump;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, StdCtrls, ExtCtrls, Grids,

  IBF_Base,

  IB_Constants,
  IB_Header,
  IB_Session,
  IB_Components,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_StatementSource,
  IB_Process,
  IB_DataScan,
  IB_DataPump,
  IB_StatementBar,
  IB_TransactionBar,
  IB_StoredProc;

type
  TfrmDataPump = class(TfrmBase)
    Panel30: TPanel;
    crSrc: TIB_Cursor;
    pcDataPump: TPageControl;
    tsSource: TTabSheet;
    tsDestination: TTabSheet;
    crDst: TIB_Cursor;
    tsDstLinks: TTabSheet;
    tsItemAttributes: TTabSheet;
    meSrcSQL: TMemo;
    meDstSQL: TMemo;
    meDstLinks: TMemo;
    meItemAttributes: TMemo;
    ssDst: TIB_StatementSource;
    cnSrc: TIB_Connection;
    csSrc: TIB_ConnectionSource;
    tsSrc: TIB_TransactionSource;
    trSrc: TIB_Transaction;
    pnSrcSQL: TPanel;
    pnSrcSpacer: TPanel;
    rbSeparateSrcDatabase: TCheckBox;
    btSrcDatabase: TButton;
    cnDst: TIB_Connection;
    trDst: TIB_Transaction;
    csDst: TIB_ConnectionSource;
    tsDst: TIB_TransactionSource;
    pnDstSQL: TPanel;
    rbSeparateDstDatabase: TCheckBox;
    btDstDatabase: TButton;
    pnDstSpacer: TPanel;
    dpBase: TIB_DataPump;
    sbDst: TIB_StatementBar;
    IB_StatementBar1: TIB_StatementBar;
    ssSrc: TIB_StatementSource;
    tsExecute: TTabSheet;
    ScrollBox1: TScrollBox;
    tbSrc: TIB_TransactionBar;
    Label1: TLabel;
    Label2: TLabel;
    tbDst: TIB_TransactionBar;
    Label3: TLabel;
    lbRowCount: TLabel;
    Label4: TLabel;
    lbRowPerSec: TLabel;
    pbDataPump: TProgressBar;
    lb0: TLabel;
    lbRecCount: TLabel;
    tsItemActions: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    meItemActions: TMemo;
    btPrepare: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    btExecute: TButton;
    Panel5: TPanel;
    btClasses: TButton;
    Panel6: TPanel;
    Label6: TLabel;
    lbErrors: TLabel;
    spDst: TIB_StoredProc;
    Label7: TLabel;
    lbRowsAffected: TLabel;
    cbIgnoreErrors: TCheckBox;
    cbIgnoreCount: TCheckBox;
    cbIgnoreRowsAffected: TCheckBox;
    procedure IB_ConnectionSourceAfterAssignment(
      Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure IB_TransactionSourceAfterAssignment(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure rbSeparateSrcDatabaseClick(Sender: TObject);
    procedure csSrcAfterAssignment(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure tsSrcAfterAssignment(Sender: TIB_TransactionLink;
      ATransaction: TIB_Transaction);
    procedure csDstAfterAssignment(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure tsDstAfterAssignment(Sender: TIB_TransactionLink;
      ATransaction: TIB_Transaction);
    procedure ssSrcBeforePrepare(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure meSrcSQLChange(Sender: TObject);
    procedure meDstSQLChange(Sender: TObject);
    procedure dpBaseAdjustCursor(Sender: TIB_DataScan;
      ACursor: TIB_Dataset);
    procedure btExecuteClick(Sender: TObject);
    procedure ssDstBeforePrepare(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure btDatabaseClick(Sender: TObject);
    procedure btPrepareClick(Sender: TObject);
    procedure dpBaseBeforePrepare(Sender: TObject);
    procedure meItemInfoChange(Sender: TObject);
    procedure ssDstAfterPrepare(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure btClassesClick(Sender: TObject);
    procedure ssDstAfterAssignment(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure dpBaseError(Sender: TObject; const ERRCODE: Longint;
      ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Longint;
      SQLMessage, SQL: TStringList; var RaiseException: Boolean);
    procedure cbIgnoreCountClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dpBaseAfterExecuteItems(Sender: TObject);
    procedure cbIgnoreRowsAffectedClick(Sender: TObject);
  private
    { Private declarations }
    ErrCount: longint;
    RowsAffected: longint;
    CntRowsAffected: boolean;
    RowCount: longint;
    procedure CursorCallback(IB_Dataset: TIB_Dataset;
      Status: TIB_CallbackStatus; CursorRowNum: longint;
      var Abort: Boolean);
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  public
    { Public declarations }
    DataPumpForEdit: TIB_DataPump;
    SrcForEdit: TIB_Dataset;
    DstForEdit: TIB_Statement;
  end;

implementation

uses
  IBF_SQL,
  IB_UtilityBar,
  IB_Utils;

{$R *.DFM}

procedure TfrmDataPump.FormCreate(Sender: TObject);
begin
  inherited;
  DataPumpForEdit := nil;
  SrcForEdit := nil;
  DstForEdit := nil;
  pcDataPump.ActivePage := tsSource;
end;

procedure TfrmDataPump.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if dpBase.Executing then
  begin
    CanClose := false;
    MessageBeep( 0 );
    ShowMessage( M_DP_STILL_ACTIVE );
  end
  else
    CanClose := not Assigned( ssDst.Statement ) or
                not Assigned( ssDst.Statement.IB_Transaction ) or
                ( ssDst.Statement.IB_Transaction.CloseWithConfirm = mrOk );
end;

procedure TfrmDataPump.FormShow(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 440, 330 );
end;

procedure TfrmDataPump.DoReadSettings;
begin
  if Assigned( DataPumpForEdit ) then
  begin
    dpBase.DstLinks.Assign( DataPumpForEdit.DstLinks );
    dpBase.DPItemAttributes.Assign( DataPumpForEdit.DPItemAttributes );
    meDstLinks.Lines.Assign( DataPumpForEdit.DstLinks );
    meItemAttributes.Lines.Assign( DataPumpForEdit.DPItemAttributes );
    if Assigned( SrcForEdit ) then
      meSrcSQL.Lines.Assign( SrcForEdit.SQL )
    else
      meSrcSQL.Lines.Text := '';
    if Assigned( DstForEdit ) then
      meDstSQL.Lines.Assign( DstForEdit.SQL )
    else
      meDstSQL.Lines.Text := '';
  end
  else
  with RegDB do
  begin
    with cnSrc do
    begin
      Database := ReadString( 'Settings', 'SrcDatabase', '' );
      Username := ReadString( 'Settings', 'SrcUsername', 'SYSDBA' );
      Password := UnJumbleString(
        ReadString( 'Settings', 'SrcPassword', 'masterkey' ), GetJumbleKey );
    end;
    with cnDst do
    begin
      Database := ReadString( 'Settings', 'DstDatabase', '' );
      Username := ReadString( 'Settings', 'DstUsername', 'SYSDBA' );
      Password := UnJumbleString(
        ReadString( 'Settings', 'DstPassword', 'masterkey' ), GetJumbleKey );
    end;
    rbSeparateSrcDatabase.Checked := ReadBool( 'Settings', 'SrcBaseDB', false );
    rbSeparateDstDatabase.Checked := ReadBool( 'Settings', 'DstBaseDB', false );
    ReadStrings( 'SrcSQL', meSrcSQL.Lines );
    ReadStrings( 'DstSQL', meDstSQL.Lines );
    ReadStrings( 'DstLinks', meDstLinks.Lines );
    ReadStrings( 'ItemAttributes', meItemAttributes.Lines );
    cbIgnoreErrors.Checked := ReadBool( 'Settings', 'IgnoreErrors', false );
    cbIgnoreCount.Checked := ReadBool( 'Settings', 'IgnoreCount', false );
    cbIgnoreRowsAffected.Checked := ReadBool( 'Settings', 'IgnoreRowsAffected',
                                              true );
  end;
end;

procedure TfrmDataPump.DoWriteSettings;
begin
  if Assigned( DataPumpForEdit ) then
  begin
    DataPumpForEdit.DstLinks.Assign( meDstLinks.Lines );
    DataPumpForEdit.DPItemAttributes.Assign( meItemAttributes.Lines );
    if Assigned( SrcForEdit ) then
    begin
      SrcForEdit.SQL := meSrcSQL.Lines;
    end;
    if Assigned( DstForEdit ) then
    begin
      DstForEdit.SQL := meDstSQL.Lines;
    end;
  end
  else
  with RegDB do
  begin
    WriteBool( 'Settings', 'SrcBaseDB', rbSeparateSrcDatabase.Checked );
    WriteBool( 'Settings', 'DstBaseDB', rbSeparateDstDatabase.Checked );
    with cnSrc do
    begin
      WriteString( 'Settings', 'SrcDatabase', Database );
      WriteString( 'Settings', 'SrcUsername', Username );
      WriteString( 'Settings', 'SrcPassword', JumbleString( Password,
                                                      GetJumbleKey));
    end;
    with cnDst do
    begin
      WriteString( 'Settings', 'DstDatabase', Database );
      WriteString( 'Settings', 'DstUsername', Username );
      WriteString( 'Settings', 'DstPassword', JumbleString( Password,
                                                      GetJumbleKey));
    end;
    WriteStrings( 'SrcSQL', meSrcSQL.Lines );
    WriteStrings( 'DstSQL', meDstSQL.Lines );
    WriteStrings( 'DstLinks', meDstLinks.Lines );
    WriteStrings( 'ItemAttributes', meItemAttributes.Lines );
    WriteBool( 'Settings', 'IgnoreErrors', cbIgnoreErrors.Checked );
    WriteBool( 'Settings', 'IgnoreCount', cbIgnoreCount.Checked );
    WriteBool( 'Settings', 'IgnoreRowsAffected', cbIgnoreRowsAffected.Checked );
  end;
end;

procedure TfrmDataPump.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  if csSrc.IB_Connection <> cnSrc then
    csSrc.IB_Connection := AConnection;
  if csDst.IB_Connection <> cnDst then
    csDst.IB_Connection := AConnection;
end;

procedure TfrmDataPump.IB_TransactionSourceAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  if tsSrc.IB_Transaction <> trSrc then
    tsSrc.IB_Transaction := ATransaction;
  if tsDst.IB_Transaction <> trDst then
    tsDst.IB_Transaction := ATransaction;
end;

procedure TfrmDataPump.rbSeparateSrcDatabaseClick(Sender: TObject);
begin
  btSrcDatabase.Enabled := rbSeparateSrcDatabase.Checked;
  if rbSeparateSrcDatabase.Checked then
  begin
    csSrc.IB_Connection := cnSrc;
    tsSrc.IB_Transaction := trSrc;
  end
  else
  begin
    csSrc.IB_Connection := BaseConnection;
    tsSrc.IB_Transaction := BaseTransaction
  end;
  btDstDatabase.Enabled := rbSeparateDstDatabase.Checked;
  if rbSeparateDstDatabase.Checked then
  begin
    csDst.IB_Connection := cnDst;
    tsDst.IB_Transaction := trDst;
  end
  else
  begin
    csDst.IB_Connection := BaseConnection;
    tsDst.IB_Transaction := BaseTransaction
  end;
end;

procedure TfrmDataPump.csSrcAfterAssignment(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
  crSrc.IB_Connection := AConnection;
end;

procedure TfrmDataPump.tsSrcAfterAssignment(Sender: TIB_TransactionLink;
  ATransaction: TIB_Transaction);
begin
  crSrc.IB_Transaction := ATransaction;
  tbSrc.IB_Transaction := ATransaction;
end;

procedure TfrmDataPump.csDstAfterAssignment(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
  crDst.IB_Connection := AConnection;
  spDst.IB_Connection := AConnection;
end;

procedure TfrmDataPump.tsDstAfterAssignment(Sender: TIB_TransactionLink;
  ATransaction: TIB_Transaction);
begin
  crDst.IB_Transaction := ATransaction;
  spDst.IB_Transaction := ATransaction;
  tbDst.IB_Transaction := ATransaction;
end;

procedure TfrmDataPump.ssSrcBeforePrepare(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin crSrc.SQL.Assign( meSrcSQL.Lines ); end;
procedure TfrmDataPump.meSrcSQLChange(Sender: TObject);
begin crSrc.Prepared := false; end;
procedure TfrmDataPump.ssDstBeforePrepare(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin Statement.SQL.Assign( meDstSQL.Lines ); end;
procedure TfrmDataPump.meDstSQLChange(Sender: TObject);
begin ssDst.Statement.Prepared := false; end;
procedure TfrmDataPump.dpBaseAdjustCursor(Sender: TIB_DataScan;
  ACursor: TIB_Dataset);
begin ACursor.OnCallback := CursorCallback; end;

procedure TfrmDataPump.CursorCallback(IB_Dataset: TIB_Dataset;
  Status: TIB_CallbackStatus; CursorRowNum: longint; var Abort: Boolean);
var
  tmpCnt: longint;
begin
  if Status = csInit then
  begin
    if dpBase.Yield then
      btExecute.Caption := C_BF_CANCEL;
    with pbDataPump do
    begin
      if cbIgnoreCount.Checked then
      begin
        RowCount := 0;
        lbRecCount.Caption := '?';
      end
      else
      begin
        RowCount := crSrc.RecordCount;
        lbRecCount.Caption := IntToStr( RowCount );
      end;
      Position := 0;
    end;
  end;
  if Status = csFinal then
    btExecute.Caption := C_BF_EXECUTE;
  lbRowCount.Caption := IntToStr( CursorRowNum );
  if Status in [ csRefresh, csFinal ] then
  begin
    with IB_Dataset do
    begin
      tmpCnt := ( GetTickCount - CallbackInitTick ) div 1000;
      if tmpCnt = 0 then
        tmpCnt := 1;
      lbRowPerSec.Caption := IntToStr( CursorRowNum div tmpCnt );
      if RowCount > 0 then
        pbDataPump.Position := Trunc(( CursorRowNum / RowCount ) * 100 );
    end;
  end;
end;

procedure TfrmDataPump.dpBaseBeforePrepare(Sender: TObject);
begin
  meItemActions.Lines.Clear;
  with dpBase do
  begin
    DPItemAttributes.Assign( meItemAttributes.Lines );
    DstLinks.Assign( meDstLinks.Lines );
  end;
end;

procedure TfrmDataPump.btPrepareClick(Sender: TObject);
begin
  try
    dpBase.Prepare;
  finally
    meItemActions.Lines.Assign( dpBase.DPItemActions );
  end;
end;

procedure TfrmDataPump.btExecuteClick(Sender: TObject);
var
  DstTrans: boolean;
begin
  with dpBase do
  begin
    if Executing then
    begin
      if MessageDlg( M_DP_ARE_YOU_SURE,
                     mtConfirmation,
                     [mbYes, mbNo],
                     0 ) = mrYes then
        AbortExecuting;
    end
    else
    begin
      ErrCount := 0;
      RowsAffected := 0;
      lbErrors.Caption := '0';
      if cbIgnoreCount.Checked then
        lbRecCount.Caption := '?'
      else
        lbRecCount.Caption := '0';
      CntRowsAffected := not cbIgnoreRowsAffected.Checked;
      if CntRowsAffected then
        lbRowsAffected.Caption := '0'
      else
        lbRowsAffected.Caption := '?';
      pbDataPump.Position := 0;
      dstStatement.CheckTransaction( true );
      with dstStatement.IB_Transaction do
      begin
        DstTrans := AutoCommit and not InTransaction and
                                   not TransactionIsActive;
        if DstTrans then
          StartTransaction;
      end;
      try
        cbIgnoreRowsAffected.Enabled := false;
        cbIgnoreCount.Enabled := false;
        Execute;
      finally
        cbIgnoreRowsAffected.Enabled := true;
        cbIgnoreCount.Enabled := true;
        with dstStatement.IB_Transaction do
          if DstTrans and InTransaction then
            Commit;
      end;
    end;
  end;
end;

procedure TfrmDataPump.btDatabaseClick(Sender: TObject);
begin
  if csBase.IB_Session.IsBusy then
  begin
    MessageBeep(0);
    ShowMessage( M_SQL_SessionBusy );
  end
  else
  with TfrmSQL.Create( Self ) do
  try
    pnClose.Visible := true;
    StatusBar.Visible := false;
    tsLayouts.TabVisible := false;
    tsQueryForms.TabVisible := false;
    UtilityBar.VisibleButtons := [ wbBrowse, wbScript, wbWho ];
    UtilityBar.Width := 150;
    if Sender = btSrcDatabase then
    begin
      csForEdit.IB_Connection := cnSrc;
      tsForEdit.IB_Transaction := trSrc;
    end
    else
    begin
      csForEdit.IB_Connection := cnDst;
      tsForEdit.IB_Transaction := trDst;
    end;
    BaseKey := Self.FullKey + 'DataPump\Database';
    if Sender = btSrcDatabase then
      FixedCaption := M_DP_SELECT_SOURCE_DB
    else
      FixedCaption := M_DP_SELECT_DEST_DB;
    pcIB_SQL.ActivePage := tsConnection;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmDataPump.meItemInfoChange(Sender: TObject);
begin
  dpBase.Unprepare;
end;

procedure TfrmDataPump.ssDstAfterPrepare(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
var
  ii: integer;
  tmpCol: TIB_Column;
  tmpInd: integer;
begin
  if Assigned( dpBase.DstRow ) then with dpBase, DstRow do
  begin
    DstLinks.Assign( meDstLinks.Lines );
    for ii:= 0 to ColumnCount - 1 do with Columns[ ii ] do
    begin
      if DstLinks.LinkValues[ FullFieldName ] = '' then
      begin
{: TODO I need to make it so that the SQL Dialect columns will still match
up when pumping from dialect 3 to 1 databases.}
        if Assigned( ssSrc.Statement ) and
           ( ssSrc.Statement.Fields.GetByName( FullFieldName, tmpCol ) or
             ssSrc.Statement.Fields.GetByName( FieldName, tmpCol )) then
        begin
          DstLinks.LinkValues[ FullFieldName ] := tmpCol.FullFieldName;
        end
        else
        begin
          tmpInd := DstLinks.LinkIndex[ FullFieldName ];
          if tmpInd >= 0 then
            DstLinks.IndexValues[ tmpInd ] := ''
          else
            DstLinks.Add( FullFieldName + '=' );
        end;
      end;
    end;
    meDstLinks.Lines.Assign( DstLinks );
  end;
end;

procedure TfrmDataPump.btClassesClick(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  tmpStrings := TIB_StringList.Create;
  try
    dpBase.GetDPItemClasses( tmpStrings );
    ShowMessage( tmpStrings.Text );
  finally
    tmpStrings.Free;
  end;
end;

procedure TfrmDataPump.ssDstAfterAssignment(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin
  dpBase.DstStatement := Statement;
end;

procedure TfrmDataPump.dpBaseError(Sender: TObject; const ERRCODE: Longint;
  ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Longint;
  SQLMessage, SQL: TStringList; var RaiseException: Boolean);
var
  dlg: TModalResult;
begin
  Inc( ErrCount );
  lbErrors.Caption := IntToStr( ErrCount );
  if cbIgnoreErrors.Checked then
    RaiseException := false
  else
  begin
    dlg := MessageDlg( ErrorMessage.Text, mtConfirmation, [ mbAbort,
                                                            mbIgnore,
                                                            mbAll], 0 );
    RaiseException := dlg = mrAbort;
    cbIgnoreErrors.Checked := dlg = mrAll;
  end;
end;

procedure TfrmDataPump.cbIgnoreCountClick(Sender: TObject);
begin
  lbRecCount.Caption := '?';
  pbDataPump.Enabled := not cbIgnoreCount.Checked;
//  lb0.Visible := not cbIgnoreCount.Checked;
//  lbRecCount.Visible := not cbIgnoreCount.Checked;
//  pbDataPump.Visible := not cbIgnoreCount.Checked;
end;

procedure TfrmDataPump.cbIgnoreRowsAffectedClick(Sender: TObject);
begin
  if cbIgnoreRowsAffected.Checked then
    lbRowsAffected.Caption := '?'
  else
    lbRowsAffected.Caption := '0';
end;

procedure TfrmDataPump.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

procedure TfrmDataPump.dpBaseAfterExecuteItems(Sender: TObject);
begin
  if CntRowsAffected then
  begin
    if dpBase.DstStatement.StatementType in [ stSelect, stSelectForUpdate ] then
      RowsAffected := RowsAffected + 1
    else
      RowsAffected := RowsAffected + dpBase.DstStatement.RowsAffected;
    lbRowsAffected.Caption := IntToStr( RowsAffected );
  end;
end;

end.
