
{                                                                              }
{ IBF_RPL                                                                      }
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
  IBF_RPL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Grids, Mask, ComCtrls, Buttons,

  XSpin, 

  IB_Header,
  IB_Constants,
  IB_SessionProps,
  IB_Session,
  IB_Components,
  IB_Process,
  IB_Events,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_StatementSource,

  IB_Controls,
  IB_SearchPanel,
  IB_Grid,
  IB_Ledger,
  IB_UpdateBar,
  IB_ConnectionBar,
  IB_TransactionBar,
  IB_NavigationBar,
  IB_SearchBar,
  IB_UtilityBar,

  IB_RPL_Base,
  IB_RPL_Sync,
  IB_RPL_Meta,

  IBF_Base;

type
  TfrmRPL = class(TfrmBase)
    cRPL: TIB_Connection;
    pcRPL: TPageControl;
    tsLoadRPLBase: TTabSheet;
    Panel2: TPanel;
    btLoadBase: TSpeedButton;
    ubRPL: TIB_UtilityBar;
    IB_ConnectionBar1: TIB_ConnectionBar;
    tsMaintainRPL: TTabSheet;
    Panel3: TPanel;
    tsLoadIndex: TTabSheet;
    Panel6: TPanel;
    btLoadMeta: TSpeedButton;
    IB_UpdateBar1: TIB_UpdateBar;
    Panel7: TPanel;
    tsActivateRPL: TTabSheet;
    Panel5: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    sbActivate: TSpeedButton;
    odGDB: TOpenDialog;
    tsSyncEvents: TTabSheet;
    meSyncEvLog: TMemo;
    qIND: TIB_Query;
    dIND: TIB_DataSource;
    sp: TIB_SessionProps;
    Panel12: TPanel;
    Panel13: TPanel;
    sbResyncQueue: TSpeedButton;
    sbResyncIndex: TSpeedButton;
    sbClearSyncLog: TSpeedButton;
    Panel11: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    sbSourceDB: TSpeedButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Button1: TButton;
    edSrcUsername: TEdit;
    edSrcPassword: TEdit;
    cbSrcDatabase: TComboBox;
    cbSrcCharSet: TComboBox;
    edSrcSQLRole: TEdit;
    cbSrcRemember: TCheckBox;
    seSrcSQLDialect: TXSpinEdit;
    pnColAttr: TPanel;
    Panel15: TPanel;
    Panel1: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    sbTargetDB: TSpeedButton;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Button2: TButton;
    edUsername: TEdit;
    edPassword: TEdit;
    cbDatabase: TComboBox;
    cbCharSet: TComboBox;
    edSQLRole: TEdit;
    cbRemember: TCheckBox;
    seSQLDialect: TXSpinEdit;
    Panel10: TPanel;
    Panel16: TPanel;
    ubSRC: TIB_UtilityBar;
    IB_ConnectionBar2: TIB_ConnectionBar;
    Panel17: TPanel;
    cSrc: TIB_Connection;
    Label8: TLabel;
    Label1: TLabel;
    rplMeta: TIB_RPL_Meta;
    grIND: TIB_Grid;
    Panel21: TPanel;
    pnTargetColAttr: TPanel;
    meColAttr: TMemo;
    Panel23: TPanel;
    meSrcColAttr: TMemo;
    Panel24: TPanel;
    tIND: TIB_Transaction;
    cbListen: TCheckBox;
    pcMetadata: TPageControl;
    tsColumnMappings: TTabSheet;
    tsRowColExpr: TTabSheet;
    tsCustomProcs: TTabSheet;
    Panel20: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label22: TLabel;
    edSrcAddExp: TIB_Memo;
    edSrcUpdExp: TIB_Memo;
    edDstDelExp: TIB_Memo;
    pnCustSendProcDecVars: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    meSrcProcVars: TIB_Memo;
    meSrcPrcVarInit: TIB_Memo;
    pnSource: TPanel;
    lbTbl: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lbStatus: TIB_Text;
    lbSrcDataColumns: TLabel;
    edSrcTableName: TIB_Edit;
    edSrcKeyColumns: TIB_Edit;
    edSrcDataColumns: TIB_Edit;
    Panel4: TPanel;
    lbDstTblNme: TLabel;
    lbDstKeyColumns: TLabel;
    lbTargetDataColumns: TLabel;
    lbDst2SrcMap: TLabel;
    edDstTblNme: TIB_Edit;
    edDstKeyColumns: TIB_Edit;
    edTargetDataColumns: TIB_Edit;
    meDst2SrcMap: TIB_Memo;
    Panel14: TPanel;
    IB_CheckBox1: TIB_CheckBox;
    Label5: TLabel;
    meDstTblSrc: TIB_Memo;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    pnCustSendQProc: TPanel;
    Label4: TLabel;
    meSrcPrcSrcQ: TIB_Memo;
    pnCustSendFullProc: TPanel;
    Label21: TLabel;
    meSrcPrcSrcFull: TIB_Memo;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    cbUseSourceDomains: TIB_CheckBox;
    tsCustTrigger: TTabSheet;
    pnCustTrigDecVar: TPanel;
    Label24: TLabel;
    meCustTrigDecVar: TIB_Memo;
    pnCustTrigInsQ: TPanel;
    Label26: TLabel;
    meCustTrigInsQ: TIB_Memo;
    Splitter5: TSplitter;
    pnCustTrigDelQ: TPanel;
    Label27: TLabel;
    meCustTrigDelQ: TIB_Memo;
    Splitter6: TSplitter;
    pnCustTrigUpdQ: TPanel;
    Label28: TLabel;
    meCustTrigUpdQ: TIB_Memo;
    Splitter7: TSplitter;
    sbExport: TSpeedButton;
    procedure btLoadBaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cRPLBeforeConnect(Sender: TIB_Connection);
    procedure cRPLAfterConnect(Sender: TIB_Connection);
    procedure dINDDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure btLoadMetaClick(Sender: TObject);
    procedure sbActivateClick(Sender: TObject);
    procedure qINDBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pcRPLChanging(Sender: TObject; var AllowChange: Boolean);
    procedure cbSrcDatabaseChange(Sender: TObject);
    procedure sbTargetDBClick(Sender: TObject);
    procedure cAfterDisconnect(Sender: TIB_Connection);
    procedure qINDGetCanModify(Sender: TIB_Dataset;
      Action: TIB_DatasetCanModify; var CanModify: Boolean);
    procedure qINDAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qINDAfterPost(IB_Dataset: TIB_Dataset);
    procedure FormDestroy(Sender: TObject);
    procedure LogSyncItem( Sender: TObject );
    procedure sbResyncQueueClick(Sender: TObject);
    procedure sbResyncIndexClick(Sender: TObject);
    procedure cbDatabaseChange(Sender: TObject);
    procedure cSrcAfterConnect(Sender: TIB_Connection);
    procedure cSrcBeforeConnect(Sender: TIB_Connection);
    procedure sbClearSyncLogClick(Sender: TObject);
    procedure meColAttrChange(Sender: TObject);
    procedure cbListenClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sbExportClick(Sender: TObject);
  private
    { Private declarations }
    procedure HandleException( Sender: TObject; E: Exception );
    procedure DoAppIsIdle( Sender: TObject; var Done: boolean );
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
    procedure DoHelpClick; override;
  public
    { Public declarations }
    procedure RefreshButtons; override;
  end;

var
  frmRPL: TfrmRPL;

const
  Pth = 'd:\ibdb\';
//  Pth = 'c:\cps-data\ibdb\';

implementation

{$R *.DFM}

uses
  Clipbrd,
  IBD_USearch,
  IB_Parse,
  IB_Utils;

procedure TfrmRPL.HandleException( Sender: TObject; E: Exception );
begin
  if E is EIB_ISCError then
    with E as EIB_ISCError do
      ShowDialog
  else
    Application.ShowException( E );
end;

procedure TfrmRPL.FormCreate(Sender: TObject);
begin
  inherited;
  Application.OnException := HandleException;
  Application.OnIdle := DoAppIsIdle;
  pcRPL.ActivePage := tsLoadRPLBase;
  RefreshButtons;
end;

procedure TfrmRPL.FormDestroy(Sender: TObject);
begin
  inherited;
  Application.OnException := nil;
  Application.OnIdle := nil;
end;

procedure TfrmRPL.btLoadBaseClick(Sender: TObject);
begin
  if not rplMeta.BaseLoaded then
  begin
    rplMeta.LoadBase;
    qIND.Open;
    qIND.Insert;
    pcRPL.ActivePage := tsLoadIndex;
    grIND.SetFocus;
    grIND.EditorMode := true;
  end
  else
  begin
    if qIND.NeedToPost then
      qIND.Cancel;
    qIND.Unprepare;
    tIND.Close;
    rplMeta.DropBase;
  end;
  RefreshButtons;
end;

procedure TfrmRPL.sbActivateClick(Sender: TObject);
begin
  rplMeta.ActivateIndex;
  qIND.Refresh;
  RefreshButtons;
end;

procedure TfrmRPL.cRPLBeforeConnect(Sender: TIB_Connection);
begin
  cRPL.Database := cbDatabase.Text;
  cRPL.Username := edUsername.Text;
  cRPL.Password := edPassword.Text;
  cRPL.SQLRole := edSQLRole.Text;
  cRPL.CharSet := cbCharSet.Text;
end;

procedure TfrmRPL.cSrcBeforeConnect(Sender: TIB_Connection);
begin
  cSrc.Database := cbSrcDatabase.Text;
  cSrc.Username := edSrcUsername.Text;
  cSrc.Password := edSrcPassword.Text;
  cSrc.SQLRole := edSrcSQLRole.Text;
  cSrc.CharSet := cbSrcCharSet.Text;
end;

procedure TfrmRPL.cRPLAfterConnect(Sender: TIB_Connection);
var
  ii: integer;
begin
  if rplMeta.BaseLoaded then
  begin
    qIND.Open;
    if qIND.BufferHasEof and ( qIND.BufferRowCount = 0 ) then
      qIND.Insert;
  end;
  RefreshButtons;
  ii := cbDatabase.Items.IndexOf( cRPL.Database );
  if ii = -1 then cbDatabase.Items.Insert( 0, cRPL.Database ) else
  if ii <> 0 then cbDatabase.Items.Exchange( ii, 0 );
  RefreshButtons;
end;

procedure TfrmRPL.cSrcAfterConnect(Sender: TIB_Connection);
var
  ii: integer;
begin
  ii := cbSrcDatabase.Items.IndexOf( cSrc.Database );
  if ii = -1 then cbSrcDatabase.Items.Insert( 0, cSrc.Database ) else
  if ii <> 0 then cbSrcDatabase.Items.Exchange( ii, 0 );
end;

procedure TfrmRPL.cAfterDisconnect(Sender: TIB_Connection);
begin
  RefreshButtons;
end;

procedure TfrmRPL.dINDDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  if qIND.FieldByName( 'RPL$IND_NME' ).AsString <> '' then
    rplMeta.ReplicatorIndexName := qIND.FieldByName( 'RPL$IND_NME' ).AsString;
  RefreshButtons;
end;

procedure TfrmRPL.btLoadMetaClick(Sender: TObject);
var
  bk: string;
begin
  qIND.CheckBrowseMode;
  qIND.BeginBusy( false );
  try
    if rplMeta.IsMetaLoaded then
    begin
      try
        qIND.DisableControls;
        bk := qIND.Bookmark;
        cSRC.Disconnect;
        cSRC.Connect;
        qIND.FreeServerResources;
        tIND.Commit;
        rplMeta.DropIndexMeta;
      finally
        qIND.Open;
        qIND.Bookmark := bk;
        qIND.EnableControls;
      end;
    end
    else
    begin
      cSrc.Connect;
      rplMeta.LoadIndexMeta;
    end;
    qIND.InvalidateRowNum( qIND.RowNum );
    RefreshButtons;
  finally
    qIND.EndBusy;
  end;
end;

procedure TfrmRPL.RefreshButtons;
begin
  inherited RefreshButtons;
  if ( cRPL.Connected ) and
     ( rplMeta.ReplicatorIndexName <> '' ) and
     ( not ( cRPL.ConnectionStatus in [ csDisconnectPending,
                                        csDropPending ] )) then rplMeta.Prepare;
  if rplMeta.BaseLoaded then btLoadBase.Caption := 'Drop RPL Base'
                        else btLoadBase.Caption := 'Load RPL Base';
  if rplMeta.IsMetaLoaded then btLoadMeta.Caption := 'Drop Metadata'
                          else btLoadMeta.Caption := 'Load Metadata';
  if not cRPL.Connected then
    btLoadBase.Enabled := false
  else
  if not rplMeta.BaseLoaded then
    btLoadBase.Enabled := true
  else
    btLoadBase.Enabled :=  (
                            (
                             ( qIND.Active ) and
                             ( qIND.BufferRowCount = 0 )
                            )
                            or
                            (
                             ( qIND.BufferRowCount = 1 ) and
                             ( qInd.State = dssInsert ) and
                             ( not qIND.Modified )
                            )
                           );
  btLoadMeta.Enabled := qIND.Fields.RowState <> rsNone;
  sbActivate.Enabled := ( rplMeta.IsMetaLoaded and not rplMeta.IsCorrupted and
                                                   not rplMeta.IsActivated ) or
                        ( rplMeta.IsActivated and ( rplMeta.IsCorrupted or
                                                    rplMeta.IsPending ));
  tsLoadIndex.TabVisible := rplMeta.BaseLoaded;
  tsSyncEvents.TabVisible := rplMeta.IsActivated or
                             ( meSyncEvLog.Lines.Count > 0 );
end;

procedure TfrmRPL.qINDBeforePost(IB_Dataset: TIB_Dataset);
var
  ii: integer;
  tmpPos: integer;
  tmpCol: string;
  tmpStr: string;
  tmpStrings: TIB_StringList;
begin
  cSRC.Connect;
  if ( IB_Dataset.State in [ dssEdit, dssInsert ] ) then
  begin
    with qIND.FieldByName( 'RPL$IND_NME' ) do
      if ( Trim( AsString ) = '' ) then
      begin
        FocusControl;
        raise Exception.Create( 'Search Index Name cannot be blank' );
      end;
    with qIND.FieldByName( 'RPL$SRC_TBL_NME' ) do
      if ( Trim( AsString ) = '' ) then
      begin
        FocusControl;
        raise Exception.Create( 'Source Table Name cannot be blank' );
      end
      else
        AsString := cSrc.mkIdent( AsString );
    with qIND.FieldByName( 'RPL$SRC_KEY_CLS' ) do
      if Trim( AsString ) = '' then
      begin
        tmpStr := '';
        tmpStrings := TIB_StringList.Create;
        try
          cSrc.SchemaCache.GetTableKeys(
            cSrc.mkIdent( qIND.FieldByName( 'RPL$SRC_TBL_NME' ).AsString ),
            tmpStrings );
          for ii := 0 to tmpStrings.Count - 1 do
          begin
            tmpCol := tmpStrings[ ii ];
            tmpPos := getLitSafePos( '.', tmpCol, 1 );
            tmpStr := tmpStr + Copy( tmpCol, tmpPos + 1, MaxInt );
            if ii < tmpStrings.Count - 1 then
             tmpStr := tmpStr + ', ';
          end;
        finally
          tmpStrings.Free;
        end;
        AsString := tmpStr;
      end;
    with qIND.FieldByName( 'RPL$DST_TBL_NME' ) do
      if Trim( AsString ) = '' then
      begin
        AsString := qIND.FieldByName( 'RPL$SRC_TBL_NME' ).AsString;
        qIND.FieldByName( 'RPL$DST_KEY_CLS' ).AsString :=
          qIND.FieldByName( 'RPL$SRC_KEY_CLS' ).AsString;  
      end;
  end;
end;

procedure TfrmRPL.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if qIND.IB_Session.IsBusy then
  begin
    MessageBeep( 0 );
    CanClose := false;
  end;
end;

procedure TfrmRPL.pcRPLChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  AllowChange := not qIND.IB_Session.IsBusy;
end;

procedure TfrmRPL.cbDatabaseChange(Sender: TObject);
begin
  if cRPL.Connected then
    cRPL.Connected := false;
end;

procedure TfrmRPL.cbSrcDatabaseChange(Sender: TObject);
begin
  if cSrc.Connected then
    cSrc.Connected := false;
end;

procedure TfrmRPL.sbTargetDBClick(Sender: TObject);
var
  s: TFileName;
  c: TIB_Connection;
begin
  if Sender = sbSourceDB then
    s := cbSrcDatabase.Text
  else
    s := cbDatabase.Text;
  if Sender = sbSourceDB then
    c := cSrc
  else
    c := cRPL;
  with c do
  begin
    Connected := false;
    if s <> '' then
    begin
      Database := s;
      odGDB.FileName := Path;
    end
    else
      odGDB.FileName := '*.GDB';
    if IBD_USearch.ModalSearchEx( Trim( odGDB.Filename ), s ) then
    begin
      Database := s;
      if Sender = sbSourceDB then
        cbSrcDatabase.Text := s
      else
        cbDatabase.Text := s;
    end;
  end;
end;

procedure TfrmRPL.DoReadSettings;
begin
  ReadStrings( 'Connections', cbDatabase.Items );
  ReadStrings( 'SrcConnections', cbSrcDatabase.Items );
  with cbDatabase do
  begin
    Text := '';
    if Items.Count > 0 then
      ItemIndex := 0;
  end;
  with cbSrcDatabase do
  begin
    Text := '';
    if Items.Count > 0 then
      ItemIndex := 0;
  end;
  with RegDB do
  begin
    cbDatabase.Text := ReadString( 'Settings', 'DATABASE', '' );
    cbSrcDatabase.Text := ReadString( 'Settings', 'SRC DATABASE', '' );
    edPassword.Text := UnJumbleString(
      ReadString( 'Settings','PASSWORD', 'masterkey' ), GetJumbleKey );
    edSrcPassword.Text := UnJumbleString(
      ReadString( 'Settings','SRC PASSWORD', 'masterkey' ), GetJumbleKey );
    cbCharSet.Text := ReadString( 'Settings', 'CHARSET', '' );
    cbSrcCharSet.Text := ReadString( 'Settings', 'SRC CHARSET', '' );
    edUsername.Text := ReadString( 'Settings', 'USER NAME', 'SYSDBA' );
    edSrcUsername.Text := ReadString( 'Settings', 'SRC USER NAME', 'SYSDBA' );
    edSQLRole.Text  := ReadString( 'Settings', 'SQL ROLE', '' );
    edSrcSQLRole.Text  := ReadString( 'Settings', 'SRC SQL ROLE', '' );
    cbRemember.Checked := ReadString( 'Settings', 'PASSWORD', '' ) <> '';
    cbSrcRemember.Checked := ReadString( 'Settings', 'SRC PASSWORD', '' ) <> '';
    seSQLDialect.Value := 1;
    seSrcSQLDialect.Value := 1;
    ReadStrings( 'ColAttr', meColAttr.Lines );
    ReadStrings( 'SrcColAttr', meSrcColAttr.Lines );
  end;
end;

procedure TfrmRPL.DoWriteSettings;
begin
  WriteStrings( 'Connections', cbDatabase.Items );
  WriteStrings( 'SrcConnections', cbSrcDatabase.Items );
  with RegDB do
  begin
    WriteString( 'Settings', 'DATABASE', cbDatabase.Text );
    WriteString( 'Settings', 'SRC DATABASE', cbSrcDatabase.Text );
    if cbSrcRemember.Checked then
      WriteString( 'Settings',
                   'SRC PASSWORD',
                   JumbleString( edSrcPassword.Text, GetJumbleKey ))
    else
    begin
      edSrcPassword.Text := '';
      WriteString( 'Settings', 'SRC PASSWORD', '' );
    end;
    if cbRemember.Checked then
      WriteString( 'Settings',
                   'PASSWORD',
                   JumbleString( edPassword.Text, GetJumbleKey ))
    else
    begin
      edPassword.Text := '';
      WriteString( 'Settings', 'PASSWORD', '' );
    end;
    WriteString( 'Settings', 'CHARSET', cbCharSet.Text );
    WriteString( 'Settings', 'SRC CHARSET', cbSrcCharSet.Text );
    WriteString( 'Settings', 'USER NAME', edUsername.Text );
    WriteString( 'Settings', 'SRC USER NAME', edSrcUsername.Text );
    WriteString( 'Settings', 'SQL ROLE', edSQLRole.Text );
    WriteString( 'Settings', 'SRC SQL ROLE', edSrcSQLRole.Text );
    WriteStrings( 'ColAttr', meColAttr.Lines );
    WriteStrings( 'SrcColAttr', meSrcColAttr.Lines );
  end;
end;

procedure TfrmRPL.DoHelpClick;
begin
  Application.HelpContext( 1600 );
end;

procedure TfrmRPL.qINDGetCanModify(Sender: TIB_Dataset;
  Action: TIB_DatasetCanModify; var CanModify: Boolean);
begin
  inherited;
  if Action = cmDelete then CanModify := not rplMeta.IsMetaLoaded;
  if Action = cmEdit then CanModify := not rplMeta.IsMetaLoaded;
end;

procedure TfrmRPL.qINDAfterScroll(IB_Dataset: TIB_Dataset);
begin
  rplMeta.ReplicatorIndexName := qIND.FieldByName( 'RPL$IND_NME' ).AsString;
end;

procedure TfrmRPL.qINDAfterPost(IB_Dataset: TIB_Dataset);
begin
  rplMeta.ResetVariables;
end;

procedure TfrmRPL.LogSyncItem( Sender: TObject );
begin
  if not ( csDestroying in ComponentState ) then
    if rplMeta.LogList.Count > 0 then
      with meSyncEvLog.Lines do
      begin
        BeginUpdate;
        try
          Insert( 0, rplMeta.LogList.Text );
          while Count > 250 do
            Delete( 250 );
        finally
          EndUpdate;
        end;
      end;
end;

procedure TfrmRPL.sbResyncQueueClick(Sender: TObject);
begin
  rplMeta.ResyncQueue;
end;

procedure TfrmRPL.sbResyncIndexClick(Sender: TObject);
begin
  rplMeta.ResyncIndex;
end;

procedure TfrmRPL.DoAppIsIdle( Sender: TObject; var Done: boolean );
var
  IsWaiting, Terminated: boolean;
begin
// Buried inside of the session is a mechanism to process all passive work items
// The TIB_RPL_Sync object has been designed to do all of its work on the idle
// CPU cycles of your application.
  cRPL.IB_Session.ProcessPassiveTasks( Done, IsWaiting, Terminated );
end;

procedure TfrmRPL.sbClearSyncLogClick(Sender: TObject);
begin
  meSyncEvLog.Lines.Clear;
end;

procedure TfrmRPL.meColAttrChange(Sender: TObject);
begin
//cRPL.Disconnect;
//cSRC.Disconnect;
  cRPL.ColumnAttributes.Assign( meColAttr.Lines );
  cSRC.ColumnAttributes.Assign( meSrcColAttr.Lines );
end;

procedure TfrmRPL.cbListenClick(Sender: TObject);
begin
  rplMeta.UseDefaultWakeup := cbListen.Checked;
end;

procedure TfrmRPL.FormResize(Sender: TObject);
begin
  pnTargetColAttr.Width := pnColAttr.Width div 2;
end;

procedure TfrmRPL.sbExportClick(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  tmpStrings := TIB_StringList.Create;
  try
    rplMeta.ExportIndexDefinitions( tmpStrings );
    ClipBoard.AsText := tmpStrings.Text;
  finally
    tmpStrings.Free;
  end;
end;

end.


