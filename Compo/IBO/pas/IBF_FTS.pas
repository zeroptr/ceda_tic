
{                                                                              }
{ IBF_FTS                                                                      }
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
  IBF_FTS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Grids, Mask, ComCtrls, Buttons, XSpin, 

  //DBGrids 

  IB_Constants,
  IB_Session,
  IB_Components,
  IB_Process,
  IB_UtilityBar,
  IB_Grid,
  IB_Controls,

  IB_FTS_Base,
  IB_FTS_Meta,
  IB_FTS_Search,
  IB_FTS_Sync,

  IBF_Base,

  IB_ConnectionSource,
  IB_TransactionSource,
  IB_UpdateBar,
  IB_StatementSource,
  IB_Ledger,
  IB_Events,
  IB_SessionProps,
  IB_ConnectionBar,
  IB_SearchPanel,
  IB_TransactionBar,
  IB_NavigationBar,
  IB_SearchBar;

type
  TfrmFTS = class(TfrmBase)
    cFTS: TIB_Connection;
    qFTS: TIB_Query;
    dsFTS: TIB_DataSource;
    pcFTS: TPageControl;
    tsLoadFTSBase: TTabSheet;
    tsSearchFTS: TTabSheet;
    grNameSearch: TIB_Grid;
    pnNameSearch: TPanel;
    Label1: TLabel;
    edNameSearch: TIB_Edit;
    cbSoundex: TCheckBox;
    cbMetaphone: TCheckBox;
    cbSynonym: TCheckBox;
    cbPartial: TCheckBox;
    cbAntonym: TCheckBox;
    Panel2: TPanel;
    btLoadBase: TSpeedButton;
    IB_UtilityBar1: TIB_UtilityBar;
    IB_ConnectionBar1: TIB_ConnectionBar;
    tsMaintainFTS: TTabSheet;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    lbCharSet: TLabel;
    lbSQLRole: TLabel;
    edUsername: TEdit;
    edPassword: TEdit;
    cbDatabase: TComboBox;
    cbCharSet: TComboBox;
    edSQLRole: TEdit;
    Panel3: TPanel;
    tFTS: TIB_Transaction;
    btReplaceGDB: TButton;
    crTXT: TIB_Cursor;
    tsLoadIndex: TTabSheet;
    Panel6: TPanel;
    btLoadMeta: TSpeedButton;
    IB_UpdateBar1: TIB_UpdateBar;
    Panel7: TPanel;
    Panel4: TPanel;
    lbTbl: TLabel;
    lbTxt: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    cbTbl: TComboBox;
    cbTxt: TIB_ComboBox;
    IB_Grid1: TIB_Grid;
    tsPopulateFTS: TTabSheet;
    tsSearchLog: TTabSheet;
    lbUSR_LEN: TLabel;
    Panel5: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Label6: TLabel;
    sbPopulate: TSpeedButton;
    sbActiveIndex: TSpeedButton;
    lgSearchLog: TIB_Ledger;
    odGDB: TOpenDialog;
    cbRemember: TCheckBox;
    lbSQLDialect: TLabel;
    tsThesaurus: TTabSheet;
    grTHS: TIB_Grid;
    tsSyncEvents: TTabSheet;
    meSyncEvLog: TMemo;
    qIND: TIB_Query;
    dIND: TIB_DataSource;
    qLOG: TIB_Query;
    qTHS: TIB_Query;
    dsLOG: TIB_DataSource;
    dsTHS: TIB_DataSource;
    lbSTATUS: TIB_Text;
    Label7: TLabel;
    lbAuxCol: TLabel;
    cbAux: TIB_ComboBox;
    sp: TIB_SessionProps;
    seWRD_LEN: TXSpinEdit;
    seSCH_LEN: TXSpinEdit;
    seUSR_LEN: TXSpinEdit;
    seMIN_LEN: TXSpinEdit;
    seSQLDialect: TXSpinEdit;
    ftsSync: TIB_FTS_Sync;
    ftsSearch: TIB_FTS_Search;
    ftsMeta: TIB_FTS_Meta;
    Panel10: TPanel;
    Panel11: TPanel;
    trTHS: TIB_Transaction;
    spTHS: TIB_SearchPanel;
    IB_SearchBar1: TIB_SearchBar;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar2: TIB_UpdateBar;
    IB_TransactionBar1: TIB_TransactionBar;
    Panel12: TPanel;
    Panel13: TPanel;
    sbResyncQueue: TSpeedButton;
    sbResyncIndex: TSpeedButton;
    sbCleanIndex: TSpeedButton;
    sbClearSyncLog: TSpeedButton;
    cbListen: TCheckBox;
    procedure btLoadBaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure scFTSError(Sender: TObject; const ERRCODE: Integer;
      ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer;
      SQLMessage, SQL: TStringList; var RaiseException: Boolean);
    procedure edNameSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edNameSearchPrepareSQL(Sender: TIB_DataLink;
      ADataSource: TIB_DataSource);
    procedure cbTypeClick(Sender: TObject);
    procedure pcFTSChange(Sender: TObject);
    procedure cFTSBeforeConnect(Sender: TIB_Connection);
    procedure cFTSAfterConnect(Sender: TIB_Connection);
    procedure btReplaceGDBClick(Sender: TObject);
    procedure dINDUpdateData(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure dINDDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure btLoadMetaClick(Sender: TObject);
    procedure sbPopulateClick(Sender: TObject);
    procedure sbActiveIndexClick(Sender: TObject);
    procedure qINDBeforePost(IB_Dataset: TIB_Dataset);
    procedure qFTSAfterExecute(Sender: TIB_Statement);
    procedure qFTSBeforeExecute(Sender: TIB_Statement);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pcFTSChanging(Sender: TObject; var AllowChange: Boolean);
    procedure cbDatabaseChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cFTSAfterDisconnect(Sender: TIB_Connection);
    procedure qINDGetCanModify(Sender: TIB_Dataset;
      Action: TIB_DatasetCanModify; var CanModify: Boolean);
    procedure qINDAfterScroll(IB_Dataset: TIB_Dataset);
    procedure qINDAfterPost(IB_Dataset: TIB_Dataset);
    procedure qINDAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormDestroy(Sender: TObject);
    procedure DoModifySearchWords(       Sender: TObject;
                                   var   Wrds: string;
                                   const Aux: string ); virtual;
    procedure LogSyncItem( Sender: TObject );
    procedure dsTHSStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure sbResyncQueueClick(Sender: TObject);
    procedure sbResyncIndexClick(Sender: TObject);
    procedure sbCleanIndexClick(Sender: TObject);
    procedure qFTSCallback(IB_Dataset: TIB_Dataset;
      Status: TIB_CallbackStatus; CursorRowNum: Integer;
      var Abort: Boolean);
    procedure seTblChange(Sender: TObject);
    procedure seKeyPress(Sender: TObject; var Key: Char);
    procedure seMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbListenClick(Sender: TObject);
  private
    { Private declarations }
    Adjusting: boolean;
    procedure HandleException( Sender: TObject; E: Exception );
    procedure DoAppIsIdle( Sender: TObject; var Done: boolean );
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  public
    { Public declarations }
    procedure RefreshButtons; override;
  end;

var
  frmFTS: TfrmFTS;

implementation

{$R *.DFM}

uses
  IBD_USearch,
  FileCtrl,
  IB_Parse,
  IB_Utils;

const
  Pth = 'd:\ibdb\';
//  Pth = 'c:\cps-data\ibdb\';

procedure TfrmFTS.btReplaceGDBClick(Sender: TObject);
var
  tmpF: TFileStream;
begin
  cFTS.Disconnect;
  tmpF := TFileStream.Create( Pth + 'Felons.gdb', fmOpenRead );
  try
    with TFileStream.Create( Pth + 'FelonsFTS.gdb', fmCreate ) do
      try
        CopyFrom( tmpF, 0 );
      finally
        Free;
      end;
  finally
    tmpF.Free;
  end;
  cFTS.Connect;
end;

procedure TfrmFTS.HandleException( Sender: TObject; E: Exception );
begin
  if E is EIB_ISCError then with E as EIB_ISCError do
    ShowDialog
  else
    Application.ShowException( E );
end;

procedure TfrmFTS.FormCreate(Sender: TObject);
begin
  inherited;
{$IFDEF IBO_VCL40_OR_GREATER}
  Constraints.MinHeight := 320;
  Constraints.MinWidth := 600;
{$ENDIF}
  ftsSync.Interval := 0;
  ftsSync.UseDefaultWakeup := false;
  Application.OnException := HandleException;
  Application.OnIdle := DoAppIsIdle;
  qTHS.FilterDeletedRecords := false;
  grTHS.Align := alClient;
  spTHS.Align := alClient;
  pcFTS.ActivePage := tsLoadFTSBase;
  RefreshButtons;
end;

procedure TfrmFTS.FormDestroy(Sender: TObject);
begin
  inherited;
  Application.OnException := nil;
  Application.OnIdle := nil;
end;

procedure TfrmFTS.btLoadBaseClick(Sender: TObject);
begin
  if not ftsMeta.BaseLoaded then ftsMeta.LoadBase
                           else ftsMeta.DropBase;
  if ftsMeta.BaseLoaded then
  begin
    qIND.Open;
    pcFTS.ActivePage := tsLoadIndex;
  end
  else
    qIND.Close;
  RefreshButtons;
end;

procedure TfrmFTS.sbPopulateClick(Sender: TObject);
begin
  ftsMeta.PopulateIndex;
  qIND.Refresh;
  RefreshButtons;
end;

procedure TfrmFTS.sbActiveIndexClick(Sender: TObject);
begin
  if qIND.IB_Session.IsBusy then
  begin
    MessageBeep( 0 );
    Exit;
  end;
  if not ftsMeta.IsPopulated then
    sbPopulateClick(Sender);
  ftsMeta.ActivateIndex;
  ShowMessage( 'Activation complete. Now disconnecting.' );
  cFTS.Disconnect;
  qIND.Refresh;
  RefreshButtons;
end;

procedure TfrmFTS.DoModifySearchWords(       Sender: TObject;
                                       var   Wrds: string;
                                       const Aux: string );
//var
//  tmpPos: integer;
begin
//Abstract.
//  tmpPos := Pos( 'JASON', Wrds );
//  if tmpPos > 0 then
//    System.Delete( Wrds, tmpPos, 5 );
end;

procedure TfrmFTS.scFTSError(Sender: TObject; const ERRCODE: Integer;
  ErrorMessage, ErrorCodes: TStringList; const SQLCODE: Integer;
  SQLMessage, SQL: TStringList; var RaiseException: Boolean);
begin
  if RaiseException then
    RaiseException := MessageDlg( ErrorMessage.Text +
                                  #13#10 +
                                  M_SCRIPT_CONTINUE_EXECUTING,
                                  mtConfirmation, [mbYes, mbNo], 0) <> mrYes;
end;

procedure TfrmFTS.edNameSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    if qFTS.Active then
    begin
      qFTS.UpdateData;
      qFTS.Refresh;
    end
    else
      qFTS.Open;
end;

procedure TfrmFTS.edNameSearchPrepareSQL(Sender: TIB_DataLink;
  ADataSource: TIB_DataSource);
var
  tmpStr: string;
  tmpTyp: TIB_FullTextSearchType;
begin
  if cbSynonym.Checked then tmpTyp := tstSynonym else
  if cbAntonym.Checked then tmpTyp := tstAntonym else
  begin
    if cbSoundex.Checked then tmpTyp := tstSoundex else
    if cbMetaphone.Checked then tmpTyp := tstMetaPhoneExact else
                                tmpTyp := tstWordExact;
    if cbPartial.Checked then Inc( tmpTyp );
  end;
  ftsSearch.Prepare;
  tmpStr := edNameSearch.SearchBuffer;
  ftsSearch.SetSearchWordsString( tmpStr, tmpTyp );
  edNameSearch.SearchBuffer := tmpStr;
  ftsSearch.PrepareSQL( qFTS );
end;

procedure TfrmFTS.qFTSBeforeExecute(Sender: TIB_Statement);
begin
  ftsSearch.BeforeExecute( qFTS );
end;

procedure TfrmFTS.qFTSAfterExecute(Sender: TIB_Statement);
begin
  ftsSearch.AfterExecute( qFTS );
end;

procedure TfrmFTS.cbTypeClick(Sender: TObject);
begin
  if not Adjusting then
  begin
    Adjusting := true;
    try
      if ( Sender = cbSoundex ) and ( cbSoundex.Checked ) then
      begin
        cbMetaphone.Checked := false;
        cbSynonym.Checked := false;
        cbAntonym.Checked := false;
      end
      else
      if ( Sender = cbMetaphone ) and cbMetaphone.Checked then
      begin
        cbSoundex.Checked := false;
        cbSynonym.Checked := false;
        cbAntonym.Checked := false;
      end
      else
      if ( Sender = cbSynonym ) and cbSynonym.Checked then
      begin
        cbSoundex.Checked := false;
        cbMetaphone.Checked := false;
        cbAntonym.Checked := false;
      end
      else
      if ( Sender = cbAntonym ) and cbAntonym.Checked then
      begin
        cbSoundex.Checked := false;
        cbMetaphone.Checked := false;
        cbSynonym.Checked := false;
      end;
      cbPartial.Enabled := not cbSynonym.Checked and not cbAntonym.Checked;
      qFTS.InvalidateSQL;
      if qFTS.Active then
      begin
        qFTS.UpdateData;
        qFTS.Refresh;
      end;
    finally
      Adjusting := false;
    end;
  end;
end;

procedure TfrmFTS.pcFTSChange(Sender: TObject);
begin
  if pcFTS.ActivePage = tsSearchFTS then
  begin
    cFTS.Connect;
    qFTS.SuppressDuplicates := true;
    qFTS.Search;
  end
  else
  if pcFTS.ActivePage = tsSearchLog then
  begin
    cFTS.Connect;
    if qLOG.Active then
      qLOG.Refresh
    else
      qLOG.Open;
  end
  else
  if pcFTS.ActivePage = tsThesaurus then
  begin
    cFTS.Connect;
    qTHS.Open;
  end;
end;

procedure TfrmFTS.cFTSBeforeConnect(Sender: TIB_Connection);
begin
  cFTS.Database := cbDatabase.Text;
  cFTS.Username := edUsername.Text;
  cFTS.Password := edPassword.Text;
  cFTS.SQLRole := edSQLRole.Text;
  cFTS.CharSet := cbCharSet.Text;
end;

procedure TfrmFTS.cFTSAfterConnect(Sender: TIB_Connection);
var
  ii: integer;
  tmpStrings: TIB_StringList;
  tmpStr: string;
  tmpTbl: string;
  tmpPos: integer;
begin
  tmpStrings := TIB_StringList.Create;
  try
    tmpStrings.Assign( cFTS.SchemaCache.TableKeys );
    for ii := tmpStrings.Count - 1 downto 0 do
    begin
      tmpTbl := tmpStrings.IndexNames[ ii ];
      if Copy( tmpTbl, 1, 4 ) = 'FTS$' then
        tmpStrings.Delete( ii )
      else
      begin
        tmpStr := tmpStrings.IndexValues[ ii ];
        tmpPos := getLitSafePos( ',', tmpStr, 1 );
        if tmpPos = 0 then
          tmpStrings[ ii ] := tmpTbl + '.' + tmpStr
        else
          tmpStrings.Delete( ii );
      end;
    end;
    tmpStrings.Sorted := true;
    tmpStrings.Sorted := false;
    tmpStrings.Insert( 0, '' );
    cbTbl.Items.Assign( tmpStrings );
    if ftsMeta.BaseLoaded then
      qIND.Open;
    RefreshButtons;
  finally
    tmpStrings.Free;
  end;
  ii := cbDatabase.Items.IndexOf( cFTS.Database );
  if ii = -1 then cbDatabase.Items.Insert( 0, cFTS.Database ) else
  if ii <> 0 then cbDatabase.Items.Exchange( ii, 0 );
  cbDatabase.Text := cFTS.Database;
  RefreshButtons;
end;

procedure TfrmFTS.cFTSAfterDisconnect(Sender: TIB_Connection);
begin
  RefreshButtons;
end;

procedure TfrmFTS.dINDUpdateData(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
var
  tmpPos: integer;
  tmpStr: string;
  tmpTyp: string;
  tmpCol: TIB_Column;
begin
  tmpPos := getLitSafePos( '.', cbTbl.Text, 1 );
  qInd.Fields.BeginUpdate;
  try
    qIND.FieldByName( 'FTS$SCH_LEN' ).AsInteger := seSCH_LEN.Value;
    qIND.FieldByName( 'FTS$WRD_LEN' ).AsInteger := seWRD_LEN.Value;
    qIND.FieldByName( 'FTS$MIN_LEN' ).AsInteger := seMIN_LEN.Value;
    qIND.FieldByName( 'FTS$USR_LEN' ).AsInteger := seUSR_LEN.Value;
    tmpStr := Copy( cbTbl.Text, 1, tmpPos - 1 );
    if tmpStr <> qIND.FieldByName( 'FTS$TBL_NME' ).AsString then
      qIND.FieldByName( 'FTS$TBL_NME' ).AsString := tmpStr;
    tmpStr := Copy( cbTbl.Text, tmpPos + 1, MaxInt );
    if tmpStr <> qIND.FieldByName( 'FTS$KEY_COL' ).AsString then
      qIND.FieldByName( 'FTS$KEY_COL' ).AsString := tmpStr;
    tmpCol := crTXT.FindField( tmpStr );
    if Assigned( tmpCol ) then
    begin
      tmpTyp := tmpCol.SQLTypeSource;
      qIND.FieldByName( 'FTS$KEY_TYP' ).AsString := tmpTyp;
      tmpStr := tmpCol.DomainName;
      if ( tmpStr = '' ) or ( Copy( tmpStr, 1, 4 ) <> 'RDB$' ) then
        tmpStr := tmpTyp;
      qIND.FieldByName( 'FTS$KEY_DM' ).AsString := tmpStr;
      qIND.FieldByName( 'FTS$WDS_TYP' ).AsString := 'VARCHAR( ' +
                                                          seSCH_LEN.Text + ' )';
    end
    else
    if qIND.Prepared then
    begin
      qIND.FieldByName( 'FTS$KEY_TYP' ).Clear;
      qIND.FieldByName( 'FTS$WDS_TYP' ).Clear;
    end;
  finally
    qInd.Fields.EndUpdate( false );
  end;
end;

procedure TfrmFTS.dINDDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
var
  tmpTbl: string;
  tmpKey: string;
  tmpSch: string;
  ii: integer;
begin
  tmpTbl := qIND.FieldByName( 'FTS$TBL_NME' ).AsString;
  tmpKey := tmpTbl + '.' + qIND.FieldByName( 'FTS$KEY_COL' ).AsString;
  cbTbl.ItemIndex := cbTbl.Items.IndexOf( tmpKey );
  tmpSch := qIND.FieldByName( 'FTS$SCH_COL' ).AsString;
  ftsSearch.SearchIndexName := qIND.FieldByName( 'FTS$IND_NME' ).AsString;
  ftsMeta.SearchIndexName := qIND.FieldByName( 'FTS$IND_NME' ).AsString;
  ftsSync.SearchIndexName := qIND.FieldByName( 'FTS$IND_NME' ).AsString;
  seSCH_LEN.Value := qIND.FieldByName( 'FTS$SCH_LEN' ).AsInteger;
  seWRD_LEN.Value := qIND.FieldByName( 'FTS$WRD_LEN' ).AsInteger;
  seMIN_LEN.Value := qIND.FieldByName( 'FTS$MIN_LEN' ).AsInteger;
  seUSR_LEN.Value := qIND.FieldByName( 'FTS$USR_LEN' ).AsInteger;
  edNameSearch.DataField := tmpSch;
  if crTXT.KeyRelation <> tmpTbl then
  begin
    crTXT.Unprepare;
    crTXT.KeyRelation := tmpTbl;
    crTXT.SQL.Text := 'SELECT * FROM ' + tmpTbl;
    if tmpTbl <> '' then
      crTXT.Prepare;
    cbTxt.Items.BeginUpdate;
    cbAux.Items.BeginUpdate;
    try
      cbTxt.Items.Clear;
      cbAux.Items.Clear;
      for ii := 0 to crTXT.Fields.ColumnCount - 1 do
        with crTXT.Fields[ ii ] do
        begin
          if IsText and (( DataSize >= 30 ) or IsBlob ) then
            cbTxt.Items.Add( crTXT.Fields[ ii ].FieldName );
          cbAux.Items.Add( crTXT.Fields[ ii ].FieldName );
        end;
    finally
      cbTxt.Items.EndUpdate;
      cbAux.Items.EndUpdate;
    end;
  end;
  if ( Trim( qFTS.KeyLinks.Text ) <> tmpKey ) or
     ( Trim( qFTS.Filter ) <> tmpSch ) then
  begin
    qFTS.Unprepare;
    qFTS.Filter := tmpSch; // I'm not really filtering here.
    qFTS.KeyRelation := tmpTbl;
    qFTS.KeyLinks.Text := tmpKey;
    qFTS.SQL.Text := 'SELECT ' + tmpKey + ', ' +
                     qIND.FieldByName('FTS$SCH_COL').AsString +
                     ' FROM ' + tmpTbl;
    qLOG.SQL.Text := 'SELECT * FROM FTS$' + ftsSearch.SearchIndexName +
                     '$SCH_LOG ' +
                     'ORDER BY FTS$SCH_DATE DESCENDING';
    qTHS.SQL.Text := 'SELECT * FROM FTS$' + ftsSearch.SearchIndexName + '$THS ' +
                     'ORDER BY FTS$WRD ASCENDING';
  end;
  RefreshButtons;
end;

procedure TfrmFTS.btLoadMetaClick(Sender: TObject);
begin
  qIND.CheckBrowseMode;
  if ftsMeta.IsMetaLoaded then
  begin
    ftsSearch.Unprepare;
    ftsSync.Unprepare;
    qFTS.Unprepare;
    qLOG.Unprepare;
    ftsMeta.DropIndexMeta;
  end
  else
    ftsMeta.LoadIndexMeta;
  qIND.Refresh;
  RefreshButtons;
end;

procedure TfrmFTS.RefreshButtons;
begin
  inherited RefreshButtons;
  if cFTS.Connected then ftsMeta.Prepare;
  if ftsMeta.BaseLoaded then btLoadBase.Caption := 'Drop FTS Base'
                       else btLoadBase.Caption := 'Load FTS Base';
  if ftsMeta.IsMetaLoaded then btLoadMeta.Caption := 'Drop Metadata'
                         else btLoadMeta.Caption := 'Load Metadata';
  btLoadBase.Enabled := cFTS.Connected and not ftsMeta.IsMetaLoaded;
  btLoadMeta.Enabled := qIND.Fields.RowState <> rsNone;
  sbPopulate.Enabled := ftsMeta.IsMetaLoaded and
                        not ftsMeta.IsPopulated and
                        not ftsMeta.IsCorrupted;
  sbActiveIndex.Enabled := ftsMeta.IsPopulated and
                        not ftsMeta.IsActivated and
                        not ftsMeta.IsCorrupted;
  tsLoadIndex.TabVisible := ftsMeta.BaseLoaded;
  tsSearchFTS.TabVisible := ftsMeta.IsActivated;
  tsSearchLog.TabVisible := ftsMeta.IsActivated;
  tsThesaurus.TabVisible := ftsMeta.IsActivated;
  tsSyncEvents.TabVisible := ftsMeta.IsActivated or
                             ( meSyncEvLog.Lines.Count > 0 );
  if ftsMeta.IsActivated then
    try
      ftsSync.Prepare;
    except
      on E: Exception do
        Application.HandleException( E );
    end;
end;

procedure TfrmFTS.qINDBeforePost(IB_Dataset: TIB_Dataset);
var
  tmpTbl: string;
  tmpKey: string;
begin
  if ( IB_Dataset.State in [ dssEdit, dssInsert ] ) and
     ( Trim( qIND.FieldByName( 'FTS$IND_NME' ).AsString ) = '' ) then
    raise Exception.Create( 'Search Index Name cannot be blank' );
  tmpTbl := qIND.FieldByName('FTS$TBL_NME').AsString;
  tmpKey := qIND.FieldByName('FTS$KEY_COL').AsString;
  if qIND.State = dssInsert then 
    with TIB_Cursor.Create( Self ) do
      try
        IB_Connection := BaseConnection;
        IB_Transaction := BaseTransaction;
        SQL.Add( 'SELECT S.RDB$INDEX_NAME' );
        SQL.Add( 'FROM RDB$INDEX_SEGMENTS S' );
        SQL.Add( 'JOIN RDB$INDICES I' );
        SQL.Add( '  ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME' );
        SQL.Add( 'WHERE I.RDB$RELATION_NAME = ''' + stLitCriteria( tmpTbl ) +
                 '''' );
        SQL.Add( '  AND S.RDB$FIELD_NAME = ''' + stLitCriteria( tmpKey ) +
                 '''' );
        SQL.Add( '  AND S.RDB$FIELD_POSITION = 0' );
        First;
        qIND.FieldByName( 'FTS$KEY_IND' ).AsString :=
          Trim( BaseConnection.mkVarIdent( Fields[0].AsString ));
      finally
        Free;
      end;
end;

procedure TfrmFTS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if qIND.IB_Session.IsBusy then
  begin
    MessageBeep( 0 );
    CanClose := false;
  end;
end;

procedure TfrmFTS.pcFTSChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  AllowChange := not qIND.IB_Session.IsBusy;
end;

procedure TfrmFTS.cbDatabaseChange(Sender: TObject);
begin
  if csBase.Connected then
    BaseConnection.Connected := false;
end;

procedure TfrmFTS.SpeedButton1Click(Sender: TObject);
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

procedure TfrmFTS.DoReadSettings;
begin
  ReadStrings( 'Connections', cbDatabase.Items );
  with cbDatabase do
  begin
    Text := '';
    if Items.Count > 0 then
      ItemIndex := 0;
  end;
  with RegDB do
  begin
    if cbDatabase.Text = '' then
      cbDatabase.Text := ReadString( 'Settings', 'Database', '' );
    edPassword.Text := UnJumbleString(
      ReadString( 'Settings','PASSWORD','masterkey' ), GetJumbleKey );
    cbCharSet.Text := ReadString( 'Settings', 'CHARSET', '' );
    edUserName.Text := ReadString( 'Settings', 'USER NAME', 'SYSDBA' );
    edSQLRole.Text  := ReadString( 'Settings', 'SQL ROLE', '' );
    cbRemember.Checked := ReadString( 'Settings', 'PSSWORD', '' ) <> '';
    seSQLDialect.Value := ReadInteger( 'Settings', 'SQLDialect', 1 );
  end;
end;

procedure TfrmFTS.DoWriteSettings;
begin
  WriteStrings( 'Connections', cbDatabase.Items );
  with RegDB do
  begin
    WriteString( 'Settings', 'Database', cbDatabase.Text );
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
    WriteString( 'Settings', 'USER NAME', edUsername.Text );
    WriteString( 'Settings', 'SQL ROLE', edSQLRole.Text );
    WriteInteger( 'Settings', 'SQLDialect', seSQLDialect.Value );
  end;
end;

procedure TfrmFTS.qINDGetCanModify(Sender: TIB_Dataset;
  Action: TIB_DatasetCanModify; var CanModify: Boolean);
begin
  inherited;
  if Action = cmDelete then CanModify := not ftsMeta.IsMetaLoaded;
  if Action = cmEdit then CanModify := not ftsMeta.IsMetaLoaded;
end;

procedure TfrmFTS.qINDAfterScroll(IB_Dataset: TIB_Dataset);
begin
  ftsMeta.SearchIndexName := qIND.FieldByName( 'FTS$IND_NME' ).AsString;
  ftsSearch.SearchIndexName := qIND.FieldByName( 'FTS$IND_NME' ).AsString;
end;

procedure TfrmFTS.qINDAfterPost(IB_Dataset: TIB_Dataset);
begin
  ftsMeta.ResetVariables;
  ftsSearch.ResetVariables;
end;

procedure TfrmFTS.qINDAfterInsert(IB_Dataset: TIB_Dataset);
begin
  inherited;
  if cbTbl.Items.Count > 1 then cbTbl.ItemIndex := 1;
  qIND.UpdateData;
  if cbTxt.Items.Count > 0 then
    qIND.FieldByName( 'FTS$SCH_COL' ).AsString := cbTxt.Items[0];
  if qIND.BufferRowCount = 1 then
    qIND.FieldByName( 'FTS$IND_NME' ).AsString := cbTxt.Items[0];
end;

procedure TfrmFTS.LogSyncItem( Sender: TObject );
begin
  if not ( csDestroying in ComponentState ) then
    if ftsSync.LogList.Count > 0 then
      with meSyncEvLog.Lines do
      begin
        BeginUpdate;
        try
          Insert( 0, ftsSync.LogList.Text );
          while Count > 250 do
            Delete( 250 );
        finally
          EndUpdate;
        end;
      end;
end;

procedure TfrmFTS.dsTHSStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  grTHS.Visible := ADataset.State <> dssSearch;
  spTHS.Visible := ADataset.State = dssSearch;
end;

procedure TfrmFTS.sbResyncQueueClick(Sender: TObject);
begin
  ftsSync.ResyncQueue;
end;

procedure TfrmFTS.sbResyncIndexClick(Sender: TObject);
begin
  ftsSync.ResyncIndex;
end;

procedure TfrmFTS.sbCleanIndexClick(Sender: TObject);
begin
  ftsSync.CleanIndex;
end;

procedure TfrmFTS.DoAppIsIdle( Sender: TObject; var Done: boolean );
var
  IsWaiting, Terminated: boolean;
begin
// Buried inside of the session is a mechanism to process all passive work items
// The TIB_FTS_Sync object has been designed to do all of its work on the idle
// CPU cycles of your application.
  if ftsSync.NeedToExecute then ftsSync.Execute;
  cFTS.IB_Session.ProcessPassiveTasks( Done, IsWaiting, Terminated );
end;

procedure TfrmFTS.qFTSCallback(IB_Dataset: TIB_Dataset;
  Status: TIB_CallbackStatus; CursorRowNum: Integer; var Abort: Boolean);
begin
  inherited;
{}
end;

procedure TfrmFTS.seTblChange(Sender: TObject);
begin
  qIND.UpdateData;
end;

procedure TfrmFTS.seKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    qIND.UpdateData;
end;

procedure TfrmFTS.seMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  qIND.UpdateData;
end;

procedure TfrmFTS.cbListenClick(Sender: TObject);
begin
  ftsSync.UseDefaultWakeup := cbListen.Checked;
end;

end.

