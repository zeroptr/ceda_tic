
{                                                                              }
{ IBF_Query                                                                    }
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
{  ADDED the REFINEMENT POSSIBILITY to the CREATE-ORDER Dialog                 }
{                       there's also ITEM=added to the OrderingLinks ALWAYS!   }
{                       - luc, Nov 21st 2001                                   }
{                                                                              }
{  Herbert Senner <HSENNER@WEB.DE>                                             }
{  02/20/2002                                                                  }
{  Modification of the sbGenTableSQLClick-Method to correct wrong EditSQL-     }
{  and InsertSQL-Properties if they are related to tables with KeyFields only  }
{                                                                              }
{  Herbert Senner <HSENNER@WEB.DE>                                             }
{  04/08/2002                                                                  }
{  I have enabled MultiSelection of ColumnAttributes- and FieldProperties      }
{  and made it possible to assign a property to more than one Field in one     }
{  step.                                                                       }
{  I introduced a const E_UPDATESQL_NOT_NECESSARY                              }
{  The UpdateSQL-Properties are closer linked to the SQL-Property of the query }
{  so that only relations can be selected that are included in the query.      }
{                                                                              }
{******************************************************************************}

{$INCLUDE IB_Directives.inc}

unit
  IBF_Query;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Buttons,
  ExtCtrls, Grids, ComCtrls, Registry, Mask, Dialogs, Messages, Clipbrd,

  IBF_Base,

  IB_Header,
  IB_Constants,
  IB_Components,
  IB_StatementGrid,
  IB_TransactionBar,
  IB_UpdateBar,
  IB_SearchBar,
  IB_DatasetBar,
  IB_NavigationBar,
  IB_StatementSource,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_Grid,
  IB_SearchPanel,
  IB_IncSearch,
  IB_Dialogs,

	IBD_CreateOrdering,	// luc...

  XSpin, Menus;

const
  E_UPDATESQL_NOT_NECESSARY = 'UpdateSQL not necessary';

type
  TfrmQuery = class(TfrmBase)
    tsDataset: TPanel;
    Panel26: TPanel;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_SearchBar2: TIB_SearchBar;
    IB_UpdateBar1: TIB_UpdateBar;
    IB_DatasetBar2: TIB_DatasetBar;
    IB_TransactionBar: TIB_TransactionBar;
    sbNew: TSpeedButton;
    Panel39: TPanel;
    dsQuery: TIB_DataSource;
    qrQuery: TIB_Query;
    slQuery: TIB_StatementSource;
    dsMasterSource: TIB_DataSource;
    pcQuery: TPageControl;
    tsSQLProperties: TTabSheet;
    pcQuerySQL: TPageControl;
    tsSQL: TTabSheet;
    tsMasterLinks: TTabSheet;
    tsKeyLinks: TTabSheet;
    tsOrdering: TTabSheet;
    tsFieldProperties: TTabSheet;
    tsParams: TTabSheet;
    IB_StatementGrid3: TIB_StatementGrid;
    tsFields: TTabSheet;
    sgQueryFields: TIB_StatementGrid;
    tsData: TTabSheet;
    grQuery: TIB_Grid;
    dsQuerySource: TIB_DataSource;
    tsHints: TTabSheet;
    spQuery: TIB_SearchPanel;
    tsColumnAttributes: TTabSheet;
    Panel4: TPanel;
    meMasterLinks: TMemo;
    Panel5: TPanel;
    pnSearch: TPanel;
    tsFieldList: TTabSheet;
    meFieldList: TMemo;
    meMasterParamLinks: TMemo;
    isQuery: TIB_IncSearch;
    Label3: TLabel;
    cbKeyByKey: TCheckBox;
    IB_DatasetBar1: TIB_DatasetBar;
    Panel3: TPanel;
    cbFetchWholeRows: TCheckBox;
    tsCalculatedFields: TTabSheet;
    meCalculatedFields: TMemo;
    cbTimeout: TCheckBox;
    Panel6: TPanel;
    meKeyLinks: TMemo;
    meKeyDescLinks: TMemo;
    sbExport: TSpeedButton;
    expQuery: TIB_ExportDialog;
    sbDSQL: TSpeedButton;
    sbMonitor: TSpeedButton;
    dsqlDlg: TIB_DSQLDialog;
    monDlg: TIB_MonitorDialog;
    cbSeekNearest: TCheckBox;
    cbKeyLinksAutoDefine: TCheckBox;
    Panel7: TPanel;
    meSQL: TMemo;
    mePlan: TMemo;
    pnVSizer: TPanel;
    pnSzrTablesFields: TPanel;
    pnTablesFields: TPanel;
    pnTables: TPanel;
    lbTables: TListBox;
    Panel9: TPanel;
    btTable: TButton;
    FieldsPanel: TPanel;
    lbFields: TListBox;
    Panel10: TPanel;
    imCPos: TImage;
    btField: TButton;
    pnSzrTableFields: TPanel;
    meJoinLinks: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    edKeyRelation: TEdit;
    Panel1: TPanel;
    Panel8: TPanel;
    meGeneratorLinks: TMemo;
    pnGeneratorLinks: TPanel;
    tsUpdateSQL: TTabSheet;
    PanelUpdateSQL: TPanel;
    cbSearchedEdits: TCheckBox;
    cbSearchedDeletes: TCheckBox;
    cbPreparedEdits: TCheckBox;
    cbPessimisticLocking: TCheckBox;
    cbReadOnly: TCheckBox;
    Panel12: TPanel;
    cbRequestLive: TCheckBox;
    cbCachedUpdates: TCheckBox;
    pnOrderingItems: TPanel;
    meOrderingItems: TMemo;
    pnOrderingItemNo: TPanel;
    Label14: TLabel;
    seOrderingItemNo: TXSpinEdit;
    Label4: TLabel;
    pcOrderingSearching: TPageControl;
    tsOrderingLinks: TTabSheet;
    meOrderingLinks: TMemo;
    tsSearchingLinks: TTabSheet;
    meSearchingLinks: TMemo;
    Label2: TLabel;
    Label5: TLabel;
    Panel13: TPanel;
    Panel14: TPanel;
    lbFldList: TListBox;
    pnSzrFieldProps: TPanel;
    PanelFieldProperties: TScrollBox;
    sgHints: TStringGrid;
    lbAlign: TLabel;
    lbCharCase: TLabel;
    lbDefaultValue: TLabel;
    lbDisplayFormat: TLabel;
    lbDisplayLabel: TLabel;
    lbDisplayWidth: TLabel;
    lbEditMask: TLabel;
    lbGridLabel: TLabel;
    lbReadOnly: TLabel;
    lbTrimming: TLabel;
    lbVisible: TLabel;
    cbFieldAlign: TComboBox;
    cbFieldCharCase: TComboBox;
    edFieldDispFormat: TEdit;
    edFieldDispLabel: TEdit;
    edFieldDispWidth: TEdit;
    edFieldGridLabel: TEdit;
    edFieldEditMask: TEdit;
    edFieldDefValue: TEdit;
    cbFieldTrim: TComboBox;
    cbFieldVisible: TComboBox;
    gbReadOnly: TPanel;
    cbRO1: TCheckBox;
    cbRO2: TCheckBox;
    cbRO3: TCheckBox;
    cbRO4: TCheckBox;
    lbColList: TListBox;
    pnSzrColAttr: TPanel;
    sbColumnAttributes: TScrollBox;
    cbBlankIsNull: TCheckBox;
    cbBoolean: TCheckBox;
    cbComputed: TCheckBox;
    cbNoDate: TCheckBox;
    cbNoTime: TCheckBox;
    cbNoCase: TCheckBox;
    cbNoTrailing: TCheckBox;
    cbRequired: TCheckBox;
    cbSoundex: TCheckBox;
    cbYesCase: TCheckBox;
    cbYesLike: TCheckBox;
    cbYesTrailing: TCheckBox;
    Label6: TLabel;
    edTrueText: TEdit;
    edFalseText: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edUpperCaseEq: TEdit;
    Label9: TLabel;
    edSoundexEq: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edColAttrMisc: TEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Panel15: TPanel;
    sbNewColAttr: TSpeedButton;
    sbRemoveColAttr: TSpeedButton;
    Panel16: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    cbCurrency: TCheckBox;
    sbProfiler: TSpeedButton;
    profDlg: TIB_ProfilerDialog;
    lbIndex: TLabel;
    cbSyncBeforeEdit: TCheckBox;
    cbSyncAfterEdit: TCheckBox;
    cbSyncAfterInsert: TCheckBox;
    pmTables: TPopupMenu;
    ShowProcNames1: TMenuItem;
    ShowViewNames1: TMenuItem;
    miUseTableAlias: TMenuItem;
    sbGenTableSQL: TSpeedButton;
    sbGenProcSQL: TSpeedButton;
    pmOrderingCalcFields: TPopupMenu;
    LoadOrderingDefaults1: TMenuItem;
    CreateCalculatedField1: TMenuItem;
    cbBCD: TCheckBox;
    Label20: TLabel;
    btnCreateOrdering: TButton;
    pnlDelSQL: TPanel;
    pnDeleteSQL: TPanel;
    meDeleteSQL: TMemo;
    pnlInsertSQL: TPanel;
    meInsertSQL: TMemo;
    pnInsertSQL: TPanel;
    pnlEditSQL: TPanel;
    pnEditSQL: TPanel;
    meEditSQL: TMemo;
    pmCollumnAttributes: TPopupMenu;
    CopyFieldsToClipboard: TMenuItem;
    CreateSearchingLinks: TMenuItem;
    sbBrowseColAttr: TSpeedButton;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    Splitter2: TSplitter;
    Splitter1: TSplitter;
    cbGenEditSQL: TCheckBox;
    cbGenInsertSQL: TCheckBox;
    cbGenDeleteSQL: TCheckBox;	// luc
    procedure meSQLChange(Sender: TObject);
    procedure pcQueryChange(Sender: TObject);
    procedure meQueryPropertyExit(Sender: TObject);
    procedure seOrderingItemNoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbNewClick(Sender: TObject);
    procedure slQueryBeforePrepare(Sender: TIB_StatementLink;
      Statement: TIB_Statement);
    procedure meQueryMemoEnter(Sender: TObject);
    procedure meQueryMemoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dsQueryStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure meHintsEnter(Sender: TObject);
    procedure meHintsExit(Sender: TObject);
    procedure edKeyRelationChange(Sender: TObject);
    procedure IB_ConnectionSourceAfterAssignment(
      Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
    procedure IB_TransactionSourceAfterAssignment(
      Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
    procedure grQueryDblClick(Sender: TObject);
    procedure IB_SearchBar2RowCount(Sender: TObject; RowCount: Longint);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qrQueryOrderingChanged(IB_Dataset: TIB_Dataset);
    procedure pcQuerySQLChange(Sender: TObject);
    procedure cbKeyByKeyClick(Sender: TObject);
    procedure IB_DatasetBar1AfterAction(Sender: TObject);
    procedure cbQuerySettingsClick(Sender: TObject);
    procedure pnSizerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnSizerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pnSizerMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbExportClick(Sender: TObject);
    procedure csBaseConnectedChanged(Sender: TIB_ConnectionLink;
      AConnection: TIB_Connection);
    procedure btTableClick(Sender: TObject);
    procedure meSQLEnter(Sender: TObject);
    procedure btFieldClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbTablesClick(Sender: TObject);
    procedure lbTablesDblClick(Sender: TObject);
    procedure lbFieldsDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lbFldListClick(Sender: TObject);
    procedure cbFieldAlignChange(Sender: TObject);
    procedure cbFieldCharCaseChange(Sender: TObject);
    procedure edFieldsChange(Sender: TObject);
    procedure edFieldsEnter(Sender: TObject);
    procedure edFieldsExit(Sender: TObject);
    procedure cbFieldTrimChange(Sender: TObject);
    procedure cbFieldVisibleChange(Sender: TObject);
    procedure cbChangedClick(Sender: TObject);
    procedure gbReadOnlyExit(Sender: TObject);
    procedure qrQueryAfterPrepare(Sender: TIB_Statement);
    procedure sgHintsSelectCell(Sender: TObject; ACol, ARow: longint;
      var CanSelect: Boolean);
    procedure lbFldLabelClick(Sender: TObject);
    procedure lbColListClick(Sender: TObject);
    procedure cbColAttrClick(Sender: TObject);
    procedure sbNewColAttrClick(Sender: TObject);
    procedure sbRemoveColAttrClick(Sender: TObject);
    procedure edColAttrChange(Sender: TObject);
    procedure edColAttrEnter(Sender: TObject);
    procedure edColAttrExit(Sender: TObject);
    procedure qrQueryPreparedChanged(Sender: TIB_Statement);
    procedure ShowProcNames1Click(Sender: TObject);
    procedure lbTablesFieldsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure meSQLDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure meSQLDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbFieldsClick(Sender: TObject);
    procedure lbTableFieldsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure sbGenTableSQLClick(Sender: TObject);
    procedure sbGenProcSQLClick(Sender: TObject);
    procedure LoadOrderingDefaults1Click(Sender: TObject);
    procedure pmOrderingCalcFieldsPopup(Sender: TObject);
    procedure CreateCalculatedField1Click(Sender: TObject);
		procedure btnCreateOrderingClick(Sender: TObject);
    procedure CopyFieldsToClipboardClick(Sender: TObject);
    procedure CreateSearchingLinksClick(Sender: TObject);
    procedure miUseTableAliasClick(Sender: TObject);
    procedure sbBrowseColAttrClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbGenUpdateSQLForTablesClick(Sender: TObject);
    procedure meQueryPropertyChange(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
  private
    { Private declarations }
    MemoWasChanged: boolean;
    PanelSizing: boolean;
    CharHeight: Integer;
    SQLCanvas: TControlCanvas;
    CurTable, CurField: string;
    SettingFldVals: boolean;
    SettingColAttr: boolean;
    WasRightClick: Boolean;
    procedure InitHints;
    procedure ReadHints;
    procedure WriteHints;
    procedure ResetFieldLists;
    procedure DiscardComputedCols(tname: String; slFields: TStringList);
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  public
    { Public declarations }
    QueryForm: string;
  end;

implementation

uses
  IBD_MemoEdit, IB_Schema, IBF_GenCustomSQL, IB_Parse, IBF_GenCalcFields;

{$R *.DFM}

var
  FldEditChanged: boolean;
  ColEditChanged: boolean;

procedure TfrmQuery.FormCreate(Sender: TObject);
begin
  inherited;
{$IFDEF IBO_VCL30_OR_GREATER}
  sbNew.Flat := true;
  sbExport.Flat := true;
  sbDSQL.Flat := true;
  sbMonitor.Flat := true;
  sbProfiler.Flat := true;
  sbRemoveColAttr.Flat := true;
  sbNewColAttr.Flat := true;
  sbBrowseColAttr.Flat := true;
{$ENDIF}
  grQuery.Align := alClient;
  InitHints;
  lbAlign.Cursor := -21; //crHandPoint
  lbCharCase.Cursor := -21;
  lbDefaultValue.Cursor := -21;
  lbDisplayFormat.Cursor := -21;
  lbDisplayLabel.Cursor := -21;
  lbDisplayWidth.Cursor := -21;
  lbEditMask.Cursor := -21;
  lbGridLabel.Cursor := -21;
  lbReadOnly.Cursor := -21;
  lbTrimming.Cursor := -21;
  lbVisible.Cursor := -21;
end;

procedure TfrmQuery.FormShow(Sender: TObject);
begin
  inherited;
  SetDefaultBounds(0, 0, 600, 400);
  if not Assigned(SQLCanvas) then begin
    SQLCanvas := TControlCanvas.Create;
    SQLCanvas.Control := meSQL;
    SQLCanvas.Font := meSQL.Font;
  end;
  CharHeight := SQLCanvas.TextHeight('0');
  pcQueryChange(nil);
end;

procedure TfrmQuery.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qrQuery.IB_Session.IsYielding then
  begin
    MessageBeep( 0 );
    ShowMessage( M_SQL_SessionBusy );
    CanClose := false;
  end;
  if CanClose then
    edFieldsExit( nil );
end;

procedure TfrmQuery.IB_ConnectionSourceAfterAssignment(
  Sender: TIB_ConnectionLink; AConnection: TIB_Connection);
begin
  qrQuery.IB_Connection := AConnection;
  expQuery.BaseConnection := AConnection;
  dsqlDlg.BaseConnection := AConnection;
  monDlg.BaseConnection := AConnection;
  profDlg.BaseConnection := AConnection;
  if Assigned(AConnection) then
  begin
    try
      if AConnection.Connected then
      begin
        lbTables.Items.Assign(AConnection.SchemaCache.TableNames);
        if ShowViewNames1.Checked then
          lbTables.Items.AddStrings(AConnection.SchemaCache.ViewNames);
        if ShowProcNames1.Checked then
          lbTables.Items.AddStrings(AConnection.SchemaCache.ProcedureNames);
      end
      else
      begin;
        AConnection.Connect;
      end;
    except
      // Squelch any exception here.
    end;
  end;
end;

procedure TfrmQuery.IB_TransactionSourceAfterAssignment(
  Sender: TIB_TransactionLink; ATransaction: TIB_Transaction);
begin
  qrQuery.IB_Transaction := ATransaction;
  IB_TransactionBar.IB_Transaction := ATransaction;
  expQuery.BaseTransaction := ATransaction;
  dsqlDlg.BaseTransaction := ATransaction;
end;

procedure TfrmQuery.csBaseConnectedChanged(Sender: TIB_ConnectionLink;
  AConnection: TIB_Connection);
begin
  if Assigned(AConnection) and AConnection.Connected then
  begin
    lbTables.Items.Assign(AConnection.SchemaCache.TableNames);
    if ShowViewNames1.Checked then
      lbTables.Items.AddStrings(AConnection.SchemaCache.ViewNames);
    if ShowProcNames1.Checked then
      lbTables.Items.AddStrings(AConnection.SchemaCache.ProcedureNames);
  end
  else
    lbTables.Items.Clear;
end;

procedure TfrmQuery.DoReadSettings;
var
  tmpInt: integer;
begin
  with RegDB do begin
    mePlan.Height := ReadInteger('Settings', 'mePlan.Heigth', 60);
    pnTables.Height := ReadInteger('Settings', 'pnTables.Height', 120);
    pnTablesFields.Width := ReadInteger('Settings', 'pnTablesFields.Width',160);
    lbFldList.Width := ReadInteger('Settings', 'lbFldList.Width',120);
    lbColList.Width := ReadInteger('Settings', 'lbColList.Width',120);

    meKeyLinks.Height := ReadInteger('Settings', 'meKeyLinks.Height',80);
    meKeyDescLinks.Height := ReadInteger('Settings', 'meKeyDescLinks.Height',80);
    meGeneratorLinks.Height := ReadInteger('Settings', 'meGeneratorLinks.Height',80);
    meMasterLinks.Height := ReadInteger('Settings', 'meMasterLinks.Height',80);
    pnOrderingItems.Width := ReadInteger('Settings', 'pnOrderingItems.Width',321);
    pnlEditSQL.Height := ReadInteger('Settings', 'pnlEditSQL.Height',154);
    pnlInsertSQL.Height := ReadInteger('Settings', 'pnlInsertSQL.Height',154);

    cbGenEditSQL.Checked := ReadBool('Settings', 'cbGenEditSQL.Checked', True);
    cbGenInsertSQL.Checked := ReadBool('Settings', 'cbGenInsertSQL.Checked', True);
    cbGenDeleteSQL.Checked := ReadBool('Settings', 'cbGenDeleteSQL.Checked', True);

    btTable.Width := pnTablesFields.Width - 6;
    btField.Width := pnTablesFields.Width - 6;
    ShowViewNames1.Checked := ReadBool( 'Settings','ShowViewNames',true);
    ShowProcNames1.Checked := ReadBool( 'Settings','ShowProcNames',false);
    with pcQuery do
    begin
      try
        tmpInt := ReadInteger( 'Settings', 'Query', 0 );
        if tmpInt >= PageCount then
          tmpInt := PageCount - 1;
        ActivePage := Pages[ tmpInt ];
      except
        ActivePage := Pages[0];
      end;
    end;
    with pcQuerySQL do
    begin
      try
        tmpInt := ReadInteger( 'Settings', 'SQL', 0 );
        if tmpInt >= PageCount then
          tmpInt := PageCount - 1;
        ActivePage := Pages[ tmpInt ];
      except
        ActivePage := Pages[0];
      end;
    end;
    cbKeyByKey.Checked := ReadBool('Settings', 'KeyByKey', true);
    cbTimeout.Checked := ReadBool('Settings', 'Timeout', true);
    cbSeekNearest.Checked := ReadBool('Settings', 'SeekNearest', true);
  end;
  if dsQuerySource.Dataset <> nil then
  begin
    with dsQuerySource.Dataset as TIB_BDataset do
    begin
      qrQuery.IB_Connection := IB_Connection;
      qrQuery.IB_Transaction := IB_Transaction;
      qrQuery.SQL.Assign(SQL);
      qrQuery.ColumnAttributes.Assign(ColumnAttributes);
      ReadHints;
      qrQuery.DefaultValues.Assign(DefaultValues);
      meGeneratorLinks.Lines.Assign(GeneratorLinks);
      meMasterLinks.Lines.Assign(MasterLinks);
      meMasterParamLinks.Lines.Assign(MasterParamLinks);
      meJoinLinks.Lines.Assign(JoinLinks);
      meSQL.Lines.Assign(SQL);
      meKeyLinks.Lines.Assign(KeyLinks);
      meKeyDescLinks.Lines.Assign(KeyDescLinks);
      meOrderingItems.Lines.Assign(OrderingItems);
      meOrderingLinks.Lines.Assign(OrderingLinks);
      meSearchingLinks.Lines.Assign(SearchingLinks);
      meEditSQL.Lines.Assign(EditSQL);
      meInsertSQL.Lines.Assign(InsertSQL);
      meDeleteSQL.Lines.Assign(DeleteSQL);
      meCalculatedFields.Lines.Assign(CalculatedFields);
      edKeyRelation.Text := KeyRelation;
      cbFetchWholeRows.Checked :=
        (dsQuerySource.Dataset as TIB_BDataset).FetchWholeRows;
      cbCachedUpdates.Checked :=
        (dsQuerySource.Dataset as TIB_BDataset).CachedUpdates;
      cbKeyLinksAutoDefine.Checked :=
        (dsQuerySource.Dataset as TIB_BDataset).KeyLinksAutoDefine;
      cbPessimisticLocking.Checked := PessimisticLocking;
      cbPreparedEdits.Checked := PreparedEdits;
      cbSearchedDeletes.Checked := SearchedDeletes;
      cbSearchedEdits.Checked := SearchedEdits;
      cbSyncBeforeEdit.Checked := ( bsBeforeEdit in BufferSynchroFlags );
      cbSyncAfterEdit.Checked := ( bsAfterEdit in BufferSynchroFlags );
      cbSyncAfterInsert.Checked := ( bsAfterInsert in BufferSynchroFlags );
      cbReadOnly.Checked := ReadOnly;
      seOrderingItemNo.Value := OrderingItemNo;
    end;
  end else begin
    miUseTableAlias.Checked := RegDB.ReadBool('Settings', 'TableAlias', False);
    ReadStrings('SQL', meSQL.Lines);
    ReadStrings('KeyLinks', meKeyLinks.Lines);
    ReadStrings('KeyDescLinks', meKeyDescLinks.Lines);
    ReadStrings('JoinLinks', meJoinLinks.Lines);
    ReadStrings('MasterLinks', meMasterLinks.Lines);
    ReadStrings('MasterParamLinks', meMasterParamLinks.Lines);
    ReadStrings('GeneratorLinks', meGeneratorLinks.Lines);
    ReadStrings('OrderingItems', meOrderingItems.Lines);
    ReadStrings('OrderingLinks', meOrderingLinks.Lines);
    ReadStrings('SearchingLinks', meSearchingLinks.Lines);
    ReadStrings('EditSQL', meEditSQL.Lines);
    ReadStrings('InsertSQL', meInsertSQL.Lines);
    ReadStrings('DeleteSQL', meDeleteSQL.Lines);
    ReadStrings('CalculatedFields', meCalculatedFields.Lines);
    ReadStrings('ColumnAttributes', qrQuery.ColumnAttributes);
    with qrQuery do begin
      BeginLayout;
      try
        ReadStrings('DefaultValues', DefaultValues);
        ReadStrings('Hints', Hints);
        ReadHints;
        ReadStrings('FieldsAlignment', FieldsAlignment);
        ReadStrings('FieldsCharCase', FieldsCharCase);
        ReadStrings('FieldsDisplayFormat', FieldsDisplayFormat);
        ReadStrings('FieldsDisplayLabel', FieldsDisplayLabel);
        ReadStrings('FieldsDisplayWidth', FieldsDisplayWidth);
        ReadStrings('FieldsEditMask', FieldsEditMask);
        ReadStrings('FieldsGridLabel', FieldsGridLabel);
        ReadStrings('FieldsIndex', FieldsIndex);
        ReadStrings('FieldsReadOnly', FieldsReadOnly);
        ReadStrings('FieldsVisible', FieldsVisible);
      finally
        EndLayout;
      end;
    end;
    with RegDB do
    begin
      cbCachedUpdates.Checked := ReadBool('Settings', 'CachedUpdates',
        false);
      cbKeyLinksAutoDefine.Checked := ReadBool('Settings', 'KeyLinksAutoDefine',
        true);
      cbFetchWholeRows.Checked := ReadBool('Settings', 'FetchWholeRows', true);
      cbPessimisticLocking.Checked := ReadBool('Settings', 'PessimisticLocking',
        false);
      cbPreparedEdits.Checked := ReadBool('Settings', 'PreparedEdits', false);
      cbReadOnly.Checked := ReadBool('Settings', 'ReadOnly', false);
      cbSearchedDeletes.Checked := ReadBool('Settings', 'SearchedDeletes',
        true);
      cbSearchedEdits.Checked := ReadBool('Settings', 'SearchedEdits', true);
      cbSyncBeforeEdit.Checked := ReadBool('Settings', 'bsBeforeEdit', false);
      cbSyncAfterEdit.Checked := ReadBool('Settings', 'bsAfterEdit', false);
      cbSyncAfterInsert.Checked := ReadBool('Settings', 'bsAfterInsert', false);
      edKeyRelation.Text := ReadString('Settings', 'KeyRelation', '');
      seOrderingItemNo.Value := ReadInteger('Settings', 'OrderingItemNo', 0);
// Requested to be left alone to avoid long delays on start-up.
//      try
//        qrQuery.Active := ReadBool('Settings', 'Active', false);
//      except
//        Application.HandleException( Self );
//      end;
    end;
  end;
  ResetFieldLists;
  lbColListClick( lbColList );
  lbFldListClick( lbFldList );

  btApply.Enabled := False;
end;

procedure TfrmQuery.DoWriteSettings;
begin
  with RegDB do begin
    WriteInteger('Settings', 'mePlan.Heigth', mePlan.Height);
    WriteInteger('Settings', 'pnTables.Height', pnTables.Height);
    WriteInteger('Settings', 'pnTablesFields.Width', pnTablesFields.Width);
    WriteInteger('Settings', 'lbFldList.Width', lbFldList.Width);
    WriteInteger('Settings', 'lbColList.Width', lbColList.Width);

    WriteInteger('Settings', 'meKeyLinks.Height', meKeyLinks.Height);
    WriteInteger('Settings', 'meKeyDescLinks.Height', meKeyDescLinks.Height);
    WriteInteger('Settings', 'meGeneratorLinks.Height', meGeneratorLinks.Height);
    WriteInteger('Settings', 'meMasterLinks.Height', meMasterLinks.Height);
    WriteInteger('Settings', 'pnOrderingItems.Width', pnOrderingItems.Width);
    WriteInteger('Settings', 'pnlEditSQL.Height', pnlEditSQL.Height);
    WriteInteger('Settings', 'pnlInsertSQL.Height', pnlInsertSQL.Height);

    WriteBool('Settings', 'cbGenEditSQL.Checked', cbGenEditSQL.Checked);
    WriteBool('Settings', 'cbGenInsertSQL.Checked', cbGenInsertSQL.Checked);
    WriteBool('Settings', 'cbGenDeleteSQL.Checked', cbGenDeleteSQL.Checked);

    WriteBool( 'Settings', 'ShowViewNames', ShowViewNames1.Checked);
    WriteBool( 'Settings', 'ShowProcNames', ShowProcNames1.Checked);
    with pcQuery do begin
      WriteInteger('Settings', 'Query', ActivePage.PageIndex);
    end;
    with pcQuerySQL do begin
      WriteInteger('Settings', 'SQL', ActivePage.PageIndex);
    end;
    WriteBool('Settings', 'KeyByKey', cbKeyByKey.Checked);
    WriteBool('Settings', 'Timeout', cbTimeout.Checked);
    WriteBool('Settings', 'SeekNearest', cbSeekNearest.Checked);
  end;
  qrQuery.ColumnAttributes.RemoveBlankEntries;
  if dsQuerySource.Dataset <> nil then begin
    with dsQuerySource.Dataset as TIB_BDataset do begin
      SQL.Assign(qrQuery.SQL);
      SQL.Text := meSQL.Lines.Text;
//      DefaultValues.Text := meDefaultValues.Lines.Text;
      WriteHints;
//      Hints.Text := meHints.Lines.Text;
      KeyLinks.Text := meKeyLinks.Lines.Text;
      KeyDescLinks.Text := meKeyDescLinks.Lines.Text;
      KeyRelation := edKeyRelation.Text;
      CachedUpdates := cbCachedUpdates.Checked;
      KeyLinksAutoDefine := cbKeyLinksAutoDefine.Checked;
      FetchWholeRows := cbFetchWholeRows.Checked;
      PessimisticLocking := cbPessimisticLocking.Checked;
      PreparedEdits := cbPreparedEdits.Checked;
      ReadOnly := cbReadOnly.Checked;
      SearchedDeletes := cbSearchedDeletes.Checked;
      SearchedEdits := cbSearchedEdits.Checked;
      if cbSyncBeforeEdit.Checked then
        BufferSynchroFlags := [ bsBeforeEdit ]
      else
        BufferSynchroFlags := [];
      if cbSyncAfterEdit.Checked then
        BufferSynchroFlags := BufferSynchroFlags + [ bsAfterEdit ];
      if cbSyncAfterInsert.Checked then
        BufferSynchroFlags := BufferSynchroFlags + [ bsAfterInsert ];
      JoinLinks.Text := meJoinLinks.Lines.Text;
      MasterLinks.Text := meMasterLinks.Lines.Text;
      MasterParamLinks.Text := meMasterParamLinks.Lines.Text;
      GeneratorLinks.Text := meGeneratorLinks.Lines.Text;
      OrderingItems.Text := meOrderingItems.Lines.Text;
      OrderingLinks.Text := meOrderingLinks.Lines.Text;
      SearchingLinks.Text := meSearchingLinks.Lines.Text;
      EditSQL.Text := meEditSQL.Lines.Text;
      InsertSQL.Text := meInsertSQL.Lines.Text;
      DeleteSQL.Text := meDeleteSQL.Lines.Text;
      CalculatedFields.Text := meCalculatedFields.Lines.Text;
      OrderingItemNo := seOrderingItemNo.Value;
    end;
  end else begin
    RegDB.WriteBool('Settings', 'TableAlias', miUseTableAlias.Checked);
    WriteStrings('SQL', meSQL.Lines);
    WriteStrings('KeyLinks', meKeyLinks.Lines);
    WriteStrings('KeyDescLinks', meKeyDescLinks.Lines);
    WriteStrings('JoinLinks', meJoinLinks.Lines);
    WriteStrings('MasterLinks', meMasterLinks.Lines);
    WriteStrings('MasterParamLinks', meMasterParamLinks.Lines);
    WriteStrings('GeneratorLinks', meGeneratorLinks.Lines);
    WriteStrings('OrderingItems', meOrderingItems.Lines);
    WriteStrings('OrderingLinks', meOrderingLinks.Lines);
    WriteStrings('CalculatedFields', meCalculatedFields.Lines);
    WriteStrings('ColumnAttributes', qrQuery.ColumnAttributes);
    with qrQuery do begin
      WriteStrings('DefaultValues', DefaultValues);
      WriteHints;
      WriteStrings('Hints', Hints);
      WriteStrings('SearchingLinks', SearchingLinks);
      WriteStrings('EditSQL', EditSQL);
      WriteStrings('InsertSQL', InsertSQL);
      WriteStrings('DeleteSQL', DeleteSQL);
      WriteStrings('FieldsAlignment', FieldsAlignment);
      WriteStrings('FieldsCharCase', FieldsCharCase);
      WriteStrings('FieldsDisplayFormat', FieldsDisplayFormat);
      WriteStrings('FieldsDisplayLabel', FieldsDisplayLabel);
      WriteStrings('FieldsDisplayWidth', FieldsDisplayWidth);
      WriteStrings('FieldsEditMask', FieldsEditMask);
      WriteStrings('FieldsGridLabel', FieldsGridLabel);
      WriteStrings('FieldsIndex', FieldsIndex);
      WriteStrings('FieldsReadOnly', FieldsReadOnly);
      WriteStrings('FieldsVisible', FieldsVisible);
    end;
    with RegDB do begin
      WriteString('Settings', 'KeyRelation', edKeyRelation.Text);
      WriteInteger('Settings', 'OrderingItemNo', seOrderingItemNo.Value);
      WriteBool('Settings', 'CachedUpdates', cbCachedUpdates.Checked);
      WriteBool('Settings', 'KeyLinksAutoDefine', cbKeyLinksAutoDefine.Checked);
      WriteBool('Settings', 'FetchWholeRows', cbFetchWholeRows.Checked);
      WriteBool('Settings', 'PessimisticLocking', cbPessimisticLocking.Checked);
      WriteBool('Settings', 'PreparedEdits', cbPreparedEdits.Checked);
      WriteBool('Settings', 'ReadOnly', cbReadOnly.Checked);
      WriteBool('Settings', 'SearchedDeletes', cbSearchedDeletes.Checked);
      WriteBool('Settings', 'SearchedEdits', cbSearchedEdits.Checked);

      WriteBool('Settings', 'bsBeforeEdit',  cbSyncBeforeEdit.Checked  );
      WriteBool('Settings', 'bsAfterEdit',   cbSyncAfterEdit.Checked   );
      WriteBool('Settings', 'bsAfterInsert', cbSyncAfterInsert.Checked );

      WriteBool('Settings', 'Active', qrQuery.Active);
    end;
  end;
end;

procedure TfrmQuery.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with qrQuery do if Fetching or NeedToPost then
  begin
    MessageBeep(1);
    Action := caNone;
  end
  else
    inherited;
end;

procedure TfrmQuery.pcQuerySQLChange(Sender: TObject);
begin
  if seOrderingItemNo.Value <> qrQuery.OrderingItemNo then
    seOrderingItemNo.Value := qrQuery.OrderingItemNo;
end;

procedure TfrmQuery.pcQueryChange(Sender: TObject);
begin
  if pcQuery.ActivePage = tsFieldProperties then
  begin
    if ( lbFldList.ItemIndex = -1 ) and ( lbFldList.Items.Count > 0 ) then
      lbFldList.ItemIndex := 0
    else
      lbFldListClick( Sender );
  end;
  if pcQuery.ActivePage = tsColumnAttributes then
  begin
    if ( lbColList.ItemIndex = -1 ) and ( lbColList.Items.Count > 0 ) then
      lbColList.ItemIndex := 0
    else
      lbColListClick( Sender );
  end;
end;

procedure TfrmQuery.meSQLChange(Sender: TObject);
begin
  qrQuery.SQL.Clear;
  if Sender = meOrderingItems then begin
    seOrderingItemNo.MaxValue := meOrderingItems.Lines.Count;
    seOrderingItemNo.MinValue := -meOrderingItems.Lines.Count;
  end;
  btApply.Enabled := True;
end;

procedure TfrmQuery.meQueryPropertyExit(Sender: TObject);
begin
  if Sender = meOrderingLinks then begin
    qrQuery.OrderingLinks.Text := meOrderingLinks.Text;
  end else if Sender = meSearchingLinks then begin
    qrQuery.SearchingLinks.Text := meSearchingLinks.Text;
  end else if Sender = meEditSQL then begin
    qrQuery.EditSQL.Text := meEditSQL.Text;
  end else if Sender = meInsertSQL then begin
    qrQuery.InsertSQL.Text := meInsertSQL.Text;
  end else if Sender = meDeleteSQL then begin
    qrQuery.DeleteSQL.Text := meDeleteSQL.Text;
  end;
end;

procedure TfrmQuery.sbNewClick(Sender: TObject);
begin
  if MessageDlg('Clear current query?',
    mtConfirmation, mbOkCancel, 0) = mrOk then
  begin
    qrQuery.Prepared := false;
    qrQuery.SQL.Assign(nil);
    qrQuery.DefaultValues.Clear;
    qrQuery.Hints.Clear;
    qrQuery.BufferSynchroFlags := [];

    meSQL.Lines.Clear;
    meJoinLinks.Lines.Clear;
    meKeyLinks.Lines.Clear;
    edKeyRelation.Text := '';
    meKeyDescLinks.Lines.Clear;
    meMasterLinks.Lines.Clear;
    meMasterParamLinks.Lines.Clear;
    meGeneratorLinks.Lines.Clear;
    seOrderingItemNo.Value := 0;
    meOrderingItems.Lines.Clear;
    meOrderingLinks.Lines.Clear;
    meSearchingLinks.Lines.Clear;
    meEditSQL.Lines.Clear;
    meInsertSQL.Lines.Clear;
    meDeleteSQL.Lines.Clear;
    meCalculatedFields.Lines.Clear;

    cbCachedUpdates.Checked := false;
    cbKeyLinksAutoDefine.Checked := true;
    cbFetchWholeRows.Checked := true;
    cbPessimisticLocking.Checked := false;
    cbPreparedEdits.Checked := true;
    cbReadOnly.Checked := false;
    cbSearchedDeletes.Checked := true;
    cbSearchedEdits.Checked := true;

    cbSyncBeforeEdit.Checked := false;
    cbSyncAfterEdit.Checked := false;
    cbSyncAfterInsert.Checked := false;
    pcQuery.ActivePage := tsSQLProperties;     // HWS
    pcQuerySQL.ActivePage := tsSQL;  // HWS
  end;
end;

procedure TfrmQuery.slQueryBeforePrepare(Sender: TIB_StatementLink;
  Statement: TIB_Statement);
begin
  with qrQuery do
    if not RepreparingSQL then
    begin
      JoinLinks.Assign(meJoinLinks.Lines);
      MasterLinks.Assign(meMasterLinks.Lines);
      MasterParamLinks.Assign(meMasterParamLinks.Lines);
      if (MasterLinks.Count > 0) or
        (MasterParamLinks.Count > 0) then
      begin
        if MasterSource = nil then
          MasterSource := dsMasterSource;
      end
      else
        MasterSource := nil;
      SQL.Text := meSQL.Lines.Text; // Do NOT use Assign here.
      KeyLinks.Assign(meKeyLinks.Lines);
      KeyDescLinks.Assign(meKeyDescLinks.Lines);
      GeneratorLinks.Assign(meGeneratorLinks.Lines);
      OrderingItems.Assign(meOrderingItems.Lines);
      OrderingLinks.Assign(meOrderingLinks.Lines);
      SearchingLinks.Assign(meSearchingLinks.Lines);
      EditSQL.Assign(meEditSQL.Lines);
      InsertSQL.Assign(meInsertSQL.Lines);
      DeleteSQL.Assign(meDeleteSQL.Lines);
      CalculatedFields.Assign(meCalculatedFields.Lines);
      OrderingItemNo := seOrderingItemNo.Value;
    end;
end;

procedure TfrmQuery.meQueryMemoEnter(Sender: TObject);
begin
  MemoWasChanged := false;
end;

procedure TfrmQuery.meQueryMemoChange(Sender: TObject);
begin
  MemoWasChanged := true;
end;

procedure TfrmQuery.dsQueryStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if ADataset <> nil then with ADataset do
  begin
    spQuery.Visible := State in [dssSearch];
    grQuery.Visible := not spQuery.Visible;
    if NeedToPost then
      pcQuery.ActivePage := tsData;
  end
  else
  begin
    spQuery.Visible := false;
    grQuery.Visible := true;
  end;
  pnSearch.Visible := grQuery.Visible;
  mePlan.Text := qrQuery.StatementPlan;
end;

procedure TfrmQuery.meHintsEnter(Sender: TObject);
begin
  ReadHints;
end;

procedure TfrmQuery.meHintsExit(Sender: TObject);
begin
  WriteHints;
end;

procedure TfrmQuery.edKeyRelationChange(Sender: TObject);
begin
  qrQuery.KeyRelation := edKeyRelation.Text;
  btApply.Enabled := True;
end;

procedure TfrmQuery.cbQuerySettingsClick(Sender: TObject);
begin
  if Sender = cbCachedUpdates then begin
    qrQuery.CachedUpdates := cbCachedUpdates.Checked;
  end else if Sender = cbKeyLinksAutoDefine then begin
    qrQuery.KeyLinksAutoDefine := cbKeyLinksAutoDefine.Checked;
  end else if Sender = cbFetchWholeRows then begin
    qrQuery.FetchWholeRows := cbFetchWholeRows.Checked;
  end else if Sender = cbPessimisticLocking then begin
    qrQuery.PessimisticLocking := cbPessimisticLocking.Checked;
  end else if Sender = cbPreparedEdits then begin
    qrQuery.PreparedEdits := cbPreparedEdits.Checked;
  end else if Sender = cbReadOnly then begin
    qrQuery.ReadOnly := cbReadOnly.Checked;
  end else if Sender = cbSearchedDeletes then begin
    qrQuery.SearchedDeletes := cbSearchedDeletes.Checked;
  end else if Sender = cbSearchedEdits then begin
    qrQuery.SearchedEdits := cbSearchedEdits.Checked;
  end else if Sender = cbSyncBeforeEdit then begin
    if cbSyncBeforeEdit.Checked then
      qrQuery.BufferSynchroFlags := qrQuery.BufferSynchroFlags + [bsBeforeEdit]
    else
      qrQuery.BufferSynchroFlags := qrQuery.BufferSynchroFlags - [bsBeforeEdit];
  end else if Sender = cbSyncAfterEdit then begin
    if cbSyncAfterEdit.Checked then
      qrQuery.BufferSynchroFlags := qrQuery.BufferSynchroFlags + [bsAfterEdit]
    else
      qrQuery.BufferSynchroFlags := qrQuery.BufferSynchroFlags - [bsAfterEdit];
  end else if Sender = cbSyncAfterInsert then begin
    if cbSyncAfterInsert.Checked then
      qrQuery.BufferSynchroFlags := qrQuery.BufferSynchroFlags + [bsAfterInsert]
    else
      qrQuery.BufferSynchroFlags := qrQuery.BufferSynchroFlags -[bsAfterInsert];
  end;
  btApply.Enabled := True;
end;

procedure TfrmQuery.ResetFieldLists;
  procedure AddNames( AStr: TIB_StringList );
  var
    ii: integer;
  begin
    for ii := 0 to AStr.Count - 1 do
      if lbFldList.Items.IndexOf( AStr.Names[ ii ] ) = - 1 then
        lbFldList.Items.Add( AStr.Names[ ii ] );
  end;
var
  ii: integer;
begin
  with qrQuery do
  begin
    if Prepared then
    begin
      GetFieldNamesList( lbFldList.Items );
      ColumnAttributes.RemoveBlankEntries;
      for ii := 0 to lbFldList.Items.Count - 1 do
        ColumnAttributes.LinkValues[ lbFldList.Items[ ii ]] :=
          ColumnAttributes.LinkValues[ lbFldList.Items[ ii ]];
      for ii := 0 to Params.ColumnCount - 1 do
        ColumnAttributes.LinkValues[ Params[ ii ].BestFieldName ] :=
          ColumnAttributes.LinkValues[ Params[ ii ].BestFieldName ];
      mePlan.Lines.Text := StatementPlan;
    end else
    begin
      lbFldList.Items.BeginUpdate;
      try
        lbFldList.Items.Clear;
        AddNames( DefaultValues );
        AddNames( FieldsAlignment );
        AddNames( FieldsCharCase );
        AddNames( FieldsDisplayFormat );
        AddNames( FieldsDisplayLabel );
        AddNames( FieldsDisplayWidth );
        AddNames( FieldsEditMask );
        AddNames( FieldsGridLabel );
        AddNames( FieldsReadOnly );
        AddNames( FieldsTrimming );
        AddNames( FieldsVisible );
      finally
        lbFldList.Items.EndUpdate;
      end;
      mePlan.Lines.Text := '';
    end;
    lbColList.Items.BeginUpdate;
    try
      lbColList.Clear;
      for ii := 0 to ColumnAttributes.Count - 1 do
        lbColList.Items.Add( ColumnAttributes.Names[ ii ] );
    finally
      lbColList.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmQuery.grQueryDblClick(Sender: TObject);
begin
  with qrQuery, grQuery do
    if Assigned(SelectedField) and not SelectedField.ReadOnly then
      if (State in [dssBrowse, dssEdit]) and CanEdit then
      begin
        Edit;
        SelectedField.FocusControl;
      end;
end;

procedure TfrmQuery.IB_SearchBar2RowCount(Sender: TObject;
  RowCount: Longint);
begin
  if StatusBar.Visible then
    Statusbar.SimpleText := 'Rows Counted: ' + IntToStr(RowCount)
  else
    ShowMessage( 'Rows Counted: ' + IntToStr(RowCount));
end;

procedure TfrmQuery.seOrderingItemNoChange(Sender: TObject);
begin
  if Assigned(qrQuery)
  then
  if qrQuery.OrderingItemNo <> seOrderingItemNo.Value then
    qrQuery.OrderingItemNo := seOrderingItemNo.Value;
  btApply.Enabled := True;    
end;

procedure TfrmQuery.qrQueryOrderingChanged(IB_Dataset: TIB_Dataset);
begin
  if seOrderingItemNo.Value <> qrQuery.OrderingItemNo then
    seOrderingItemNo.Value := qrQuery.OrderingItemNo;
end;

procedure TfrmQuery.cbKeyByKeyClick(Sender: TObject);
begin
  with isQuery do
  begin
    SearchKeyByKey := cbKeyByKey.Checked;
    AllowTimeout := cbTimeout.Checked;
    SeekNearest := cbSeekNearest.Checked;
    if qrQuery.Prepared then
      SetFocus;
    SelectAll;
  end;
end;

procedure TfrmQuery.IB_DatasetBar1AfterAction(Sender: TObject);
begin
  if IB_DatasetBar1.FocusedButton = dbOpen then
    pcQuery.ActivePage := tsData;
end;

procedure TfrmQuery.pnSizerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  PanelSizing := true;
end;

procedure TfrmQuery.pnSizerMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  tmpInt: integer;
begin
  if PanelSizing then
    if Sender = pnVSizer then
    begin
      tmpInt := mePlan.Height - Y;
      if tmpInt < 50 then tmpInt := 50;
      mePlan.Height := tmpInt;
    end else if Sender = pnSzrTableFields then
    begin
      tmpInt := pnTables.Height + Y;
      if tmpInt < 100 then tmpInt := 100;
      pnTables.Height := tmpInt;
    end else if Sender = pnSzrFieldProps then
    begin
      tmpInt := lbFldList.Width + X;
      if tmpInt < 80 then tmpInt := 80;
      if tmpInt > 300 then tmpInt := 300;
      lbFldList.Width := tmpInt;
    end else if Sender = pnSzrColAttr then
    begin
      tmpInt := lbColList.Width + X;
      if tmpInt < 80 then tmpInt := 80;
      if tmpInt > 300 then tmpInt := 300;
      lbColList.Width := tmpInt;
    end else if Sender = pnSzrTablesFields then
    begin
      tmpInt := pnTablesFields.Width + X;
      if tmpInt < 120 then tmpInt := 120;
      pnTablesFields.Width := tmpInt;
      btTable.Width := pnTablesFields.Width - 6;
      btField.Width := pnTablesFields.Width - 6;
    end;
end;

procedure TfrmQuery.pnSizerMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PanelSizing := false;
end;

procedure TfrmQuery.sbExportClick(Sender: TObject);
begin
  if not Assigned( BaseConnection ) and IB_Session.AllowDefaultConnection then
    BaseConnection := IB_Session.DefaultConnection;
  if Sender = sbExport then
  begin
    expQuery.SQL.Text := qrQuery.ClientSQL;
    expQuery.Show;
  end
  else
  if Sender = sbDSQL then
    dsqlDlg.Show
  else
  if Sender = sbMonitor then
    monDlg.Show
  else
  if Sender = sbProfiler then
    profDlg.Show;
end;

procedure TfrmQuery.btTableClick(Sender: TObject);
var
	strAlias: String;
begin
  with lbTables, qrQuery do
    if ItemIndex > -1 then
    begin
      SQL.Text := meSQL.Text;
      if miUseTableAlias.Checked then
        strAlias := ' T' + IntToStr(ItemIndex)
      else
        strAlias := '';
      if Trim(SQLFrom.Text) = '' then
        SQLFrom.Text := 'FROM ' + Items[ItemIndex] + strAlias
      else
        SQLFrom.Add('JOIN ' + Items[ItemIndex] + strAlias);
      meSQL.Text := SQL.Text;
    end;
end;

procedure TfrmQuery.meSQLEnter(Sender: TObject);
begin
  meSQL.Invalidate;
end;

procedure TfrmQuery.btFieldClick(Sender: TObject);
var
  ii: integer;
  NewSelect: string;
  strAlias: String;
begin
  with lbFields, qrQuery do
  begin
    if miUseTableAlias.Checked then
      strAlias := 'T' + IntToStr(lbTables.ItemIndex) + '.'
    else
      strAlias := '';
    SQL.Text := meSQL.Text;
    if ItemIndex = 0 then
    begin
      SQLSelect.Text := 'SELECT ' + strAlias + '*';
      NewSelect := Trim( SQLSelect.Text );
    end
    else
    if ItemIndex > 0 then
    begin
      NewSelect := Trim(SQLSelect.Text);
      if (NewSelect <> '') and WasRightClick then
      begin
        NewSelect := NewSelect + #13#10'     , '
          + '(SELECT IT.' + CurField + ' FROM ' + Curtable + ' IT'
          + #13#10'     ' + 'WHERE IT.#link# = #tbl#.#link#) AS '
          + CurField;
      end
      else
        for ii := 0 to Items.Count - 1 do
        begin
          if lbFields.Selected[ii] then
          begin
            if NewSelect = '' then
            begin
              NewSelect := 'SELECT ' + strAlias + Items[ii];
            end
            else
            begin
              NewSelect := NewSelect + #13#10'     , ' + strAlias + Items[ii];
            end;
          end;
        end;
    end;
    SQLSelect.Text := NewSelect;
    meSQL.Text := Trim(SQL.Text);
  end;
end;

procedure TfrmQuery.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(SQLCanvas) then
  begin
    SQLCanvas.Free;
    SQLCanvas := nil;
  end;
end;

procedure TfrmQuery.lbTablesClick(Sender: TObject);
begin
  With lbTables do
  if ( ItemIndex = -1 ) or not Assigned( BaseConnection ) then
  begin
    CurTable := '';
    lbFields.Items.Clear;
  end
  else
  if CurTable <> Items[ItemIndex] then
  begin
    CurTable := Items[ItemIndex];
    BaseConnection.SchemaCache.GetTableFields( CurTable, lbFields.Items );
    lbFields.Items.Insert( 0, '*' );
  end;
end;

procedure TfrmQuery.lbTablesDblClick(Sender: TObject);
begin
  btTable.Click;
end;

procedure TfrmQuery.lbFieldsDblClick(Sender: TObject);
begin
  btField.Click;
end;

procedure TfrmQuery.FormActivate(Sender: TObject);
begin
  inherited;
  HelpFile := 'IBO.HLP';
end;

procedure TfrmQuery.lbFieldsClick(Sender: TObject);
begin
  inherited;
  with lbFields do
    if ItemIndex < 0 then
      CurField := ''
    else
      CurField := Items[ItemIndex];
end;


procedure TfrmQuery.lbTablesFieldsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
	idx: Integer;
begin
  inherited;
  if (Shift * [ssShift, ssCtrl] <> []) or (Button <> mbLeft)
  then Exit;
  with Sender as TListBox do
  begin
    idx := ItemAtPos(Point(X, Y), True);
    if idx >= 0 then
    begin
      //ItemIndex := idx;
      OnClick( Sender );
      WasRightClick := ssAlt in Shift;
      BeginDrag( False )
    end;
  end;
end;

procedure TfrmQuery.meSQLDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := (Source = lbTables) or (Source = lbFields);
end;

procedure TfrmQuery.meSQLDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  inherited;
  if Source = lbTables
  then btTable.Click
  else if Source = lbFields
  then btField.Click
end;

procedure TfrmQuery.lbTableFieldsEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  inherited;
  WasRightClick := False
end;


{------------------------------------------------------------------------------}

procedure TfrmQuery.lbFldListClick( Sender: TObject );
var
  SFld,
  x: string;
  ii: integer;
begin
  if not SettingFldVals then
  begin
    SettingFldVals := true;
    try
      if lbFldList.Items.Count > 0 then
      begin
        if lbFldList.ItemIndex = -1 then
        begin
          lbFldList.ItemIndex := 0;
          Exit;
        end;
        SFld := lbFldList.Items[ lbFldList.ItemIndex ];
        with qrQuery do
        begin
          with cbFieldAlign do
          begin
            x := AnsiUpperCase( FieldsAlignment.LinkValues[ SFld ] );
            if x = '' then
              ItemIndex := -1
            else
            begin
              ii := Items.IndexOf( x );
              if ( ii = -1 ) then case x[1] of
                'R': ii := Items.IndexOf( 'RIGHT' );
                'L': ii := Items.IndexOf( 'LEFT' );
                'C': ii := Items.IndexOf( 'CENTER' );
              end;
              ItemIndex := ii;
            end;
          end;
          with cbFieldCharCase do
          begin
            x := AnsiUpperCase( FieldsCharCase.LinkValues[ SFld ] );
            if x = '' then
              ItemIndex := -1
            else
            begin
              ii := Items.IndexOf( x );
              if ( ii = -1 ) then case x[1] of
                'U': ii := Items.IndexOf( 'UPPER' );
                'L': ii := Items.IndexOf( 'LOWER' );
                'P': ii := Items.IndexOf( 'PROPER' );
                'N': ii := Items.IndexOf( 'NORMAL' );
              end;
              ItemIndex := ii;
            end;
          end;
          with cbFieldTrim do
          begin
            x := AnsiUpperCase( FieldsTrimming.LinkValues[ SFld ] );
            if x = '' then
              ItemIndex := -1
            else
            begin
              ii := Items.IndexOf( x );
              if ( ii = -1 ) then case x[1] of
                'N': ii := Items.IndexOf( 'NONE' );
                'A': ii := Items.IndexOf( 'ALL' );
                'B': ii := Items.IndexOf( 'BOTH' );
                'L': ii := Items.IndexOf( 'LEFT' );
                'R': ii := Items.IndexOf( 'RIGHT' );
                'S': ii := Items.IndexOf( 'SENTENCE' );
              end;
              ItemIndex := ii;
            end;
          end;
          with cbFieldVisible do
          begin
            x := AnsiUpperCase( FieldsVisible.LinkValues[ SFld ] );
            if x = '' then
              ItemIndex := -1
            else
            begin
              ii := Items.IndexOf( x );
              if ( ii = -1 ) then case x[1] of
                'T': ii := Items.IndexOf( 'TRUE' );
                'F': ii := Items.IndexOf( 'FALSE' );
              end;
              ItemIndex := ii;
            end;
          end;
          edFieldDispFormat.Text := FieldsDisplayFormat.LinkValues[ SFld ];
          edFieldDispLabel.Text := FieldsDisplayLabel.LinkValues[ SFld ];
          edFieldDispWidth.Text := FieldsDisplayWidth.LinkValues[ SFld ];
          edFieldEditMask.Text := FieldsEditMask.LinkValues[ SFld ];
          edFieldGridLabel.Text := FieldsGridLabel.LinkValues[ SFld ];
          edFieldDefValue.Text := DefaultValues.LinkValues[ SFld ];
          x := FieldsReadOnly.LinkValues[ SFld ];
        end;
        cbRO1.checked := Pos( cbRO1.Caption, x ) <> 0;
        cbRO2.checked := Pos( cbRO2.Caption, x ) <> 0;
        cbRO3.checked := Pos( cbRO3.Caption, x ) <> 0;
        cbRO4.checked := Pos( cbRO4.Caption, x ) <> 0;
      end
      else
      begin
        cbFieldAlign.ItemIndex := -1;
        cbFieldCharCase.ItemIndex := -1;
        cbFieldTrim.ItemIndex := -1;
        cbFieldVisible.ItemIndex := -1;
        edFieldDispFormat.Text := '';
        edFieldDispLabel.Text := '';
        edFieldDispWidth.Text := '';
        edFieldEditMask.Text := '';
        edFieldGridLabel.Text := '';
        edFieldDefValue.Text := '';
        cbRO1.State := cbGrayed;
        cbRO2.State := cbGrayed;
        cbRO3.State := cbGrayed;
        cbRO4.State := cbGrayed;
      end;
    finally
      SettingFldVals := false;
    end;
  end;
end;

procedure TfrmQuery.cbFieldAlignChange(Sender: TObject);
var
  ii: integer;
begin
  if SettingFldVals then Exit;
// Allow MultiSelect
  with qrQuery.FieldsAlignment do
  begin
    if lbFldList.SelCount > 0 then
      for ii := 0 to lbFldList.Items.Count - 1 do
      if lbFldList.Selected[ii] then
        LinkValues[ lbFldList.Items[ ii ]] := cbFieldAlign.Text;
    RemoveBlankEntries;
  end;
  btApply.Enabled := True;  
end;

procedure TfrmQuery.cbFieldCharCaseChange(Sender: TObject);
var
  ii: integer;
begin
  if SettingFldVals then Exit;
  with qrQuery.FieldsCharCase do
  begin
    if lbFldList.SelCount > 0 then
      for ii := 0 to lbFldList.Items.Count - 1 do
      if lbFldList.Selected[ii] then
        LinkValues[ lbFldList.Items[ ii ]] := cbFieldCharCase.Text;
    RemoveBlankEntries;
  end;
end;

procedure TfrmQuery.edFieldsChange(Sender: TObject);
begin
  FldEditChanged := true;
end;

procedure TfrmQuery.edFieldsEnter(Sender: TObject);
begin
  FldEditChanged := false;
end;

procedure TfrmQuery.cbChangedClick(Sender: TObject);
begin
  FldEditChanged := true;
  btApply.Enabled := True;
end;

procedure TfrmQuery.edFieldsExit( Sender: TObject );
  procedure SetProp( ALst: TIB_StringList; AStr: string );
  var ii: integer;
  begin
    if lbFldList.SelCount > 0 then
      for ii := 0 to lbFldList.Items.Count - 1 do
      if lbFldList.Selected[ii] then
        ALst.LinkValues[ lbFldList.Items[ii]] := AStr;
    ALst.RemoveBlankEntries;
  end;
begin
  if SettingFldVals then Exit;
  if not FldEditChanged then exit;
  if ( Sender = edFieldDispFormat ) or
     ( edFieldDispFormat.Modified ) then SetProp( qrQuery.FieldsDisplayFormat,
                                                  edFieldDispFormat.Text );
  if ( Sender = edFieldDispLabel ) or
     ( edFieldDispLabel.Modified ) then SetProp( qrQuery.FieldsDisplayLabel,
                                                 edFieldDispLabel.Text );
  if ( Sender = edFieldDispWidth ) or
     ( edFieldDispWidth.Modified ) then SetProp( qrQuery.FieldsDisplayWidth,
                                                 edFieldDispWidth.Text );
  if ( Sender = edFieldEditMask ) or
     ( edFieldEditMask.Modified ) then SetProp( qrQuery.FieldsEditMask,
                                                edFieldEditMask.Text );
  if ( Sender = edFieldGridLabel ) or
     ( edFieldGridLabel.Modified ) then SetProp( qrQuery.FieldsGridLabel,
                                                 edFieldGridLabel.Text );
  if ( Sender = edFieldDefValue ) or
     ( edFieldDefValue.Modified ) then SetProp( qrQuery.DefaultValues,
                                                edFieldDefValue.Text );
  if ( Sender = edFieldDispWidth ) or
     ( edFieldDispWidth.Modified ) then qrQuery.UpdateLayout;
  if not Assigned( Sender ) then
    gbReadOnlyExit( nil );

  btApply.Enabled := True;
end;

procedure TfrmQuery.cbFieldTrimChange(Sender: TObject);
var
  ii: integer;
begin
  if SettingFldVals then Exit;
  with qrQuery.FieldsTrimming do
  begin
    if lbFldList.SelCount > 0 then
      for ii := 0 to lbFldList.Items.Count - 1 do
        if lbFldList.Selected[ii] then
          LinkValues[ lbFldList.Items[ii]] := cbFieldTrim.Text;
    RemoveBlankEntries;
  end;
end;

procedure TfrmQuery.cbFieldVisibleChange(Sender: TObject);
var
  ii: integer;
begin
  if SettingFldVals then Exit;
  with qrQuery.FieldsVisible do
  begin
    if lbFldList.SelCount > 0 then
      for ii := 0 to lbFldList.Items.Count - 1 do
        if lbFldList.Selected[ii] then
          LinkValues[ lbFldList.Items[ii]] := cbFieldVisible.Text;
    RemoveBlankEntries;
  end;
end;

procedure TfrmQuery.gbReadOnlyExit(Sender: TObject);
var x: string;
  ii: integer;
begin
  if FldEditChanged and ( lbFldList.SelCount > 0 ) then
  begin
    for ii := 0 to lbFldList.Items.Count - 1 do
    if lbFldList.Selected[ii] then
    begin
      x := '';
      if cbRO1.Checked then x := x + cbRO1.Caption + ';';
      if cbRO2.Checked then x := x + cbRO2.Caption + ';';
      if cbRO3.Checked then x := x + cbRO3.Caption + ';';
      if cbRO4.Checked then x := x + cbRO4.Caption + ';';
      if Length( x ) > 0 then x := Copy( x, 1, Length( x ) - 1 );
      qrQuery.FieldsReadOnly.LinkValues[ lbFldList.Items[ ii ]] := x;
    end;
    qrQuery.FieldsReadOnly.RemoveBlankEntries ;
  end;
end;

procedure TfrmQuery.qrQueryAfterPrepare(Sender: TIB_Statement);
begin
  lbColListClick( Sender );
  lbFldListClick( Sender );
end;

const
  HintStr: array [ 1..29 ] of string = ( 'EDIT',
                                         'INSERT',
                                         'DELETE',
                                         'REFRESH',
                                         'REFRESHKEYS',
                                         'REFRESHROWS',
                                         'POSTSEARCH',
                                         'CANCELSEARCH',
                                         'POSTEDIT',
                                         'CANCELEDIT',
                                         'POSTINSERT',
                                         'CANCELINSERT',
                                         'POSTDELETE',
                                         'CANCELDELETE',
                                         'POST',
                                         'CANCEL',
                                         'FIRST',
                                         'PRIOR',
                                         'NEXT',
                                         'LAST',
                                         'JUMPBCK',
                                         'JUMPFWD',
                                         'ORDER',
                                         'LAST_CRITERIA',
                                         'SEARCH',
                                         'SAVE_CRITERIA',
                                         'CLEAR_CRITERIA',
                                         'RECALL_CRITERIA',
                                         'COUNT' );

procedure TfrmQuery.InitHints;
var
  ii: integer;
begin
  sgHints.RowCount := High( HintStr ) - Low( HintStr ) + 2;
  sgHints.Cells[ 0, 0 ] := 'Action';
  sgHints.Cells[ 1, 0 ] := 'Hint Text';
  for ii := Low( HintStr ) to High( HintStr ) do
    sgHints.Cells[ 0, ii ] := HintStr[ ii ];
end;

procedure TfrmQuery.ReadHints;
var
  ii: integer;
begin
  for ii := Low( HintStr ) to High( HintStr ) do
    sgHints.Cells[ 1, ii ] := qrQuery.Hints.Values[ HintStr[ ii ]];
end;

procedure TfrmQuery.WriteHints;
var
  ii: integer;
begin
  for ii := Low( HintStr ) to High( HintStr ) do
    qrQuery.Hints.Values[ HintStr[ ii ]] := sgHints.Cells[ 1, ii ];
  qrQuery.StateChanged;
end;

procedure TfrmQuery.sgHintsSelectCell( Sender: TObject; ACol, ARow: longint;
  var CanSelect: Boolean );
begin
  WriteHints;
end;

procedure TfrmQuery.lbFldLabelClick(Sender: TObject);
var
  tmpStrings: TIB_StringList;
begin
  edFieldsExit( nil );
  tmpStrings := nil;
  with qrQuery do
  begin
    if Sender = lbAlign         then tmpStrings := FieldsAlignment else
    if Sender = lbCharCase      then tmpStrings := FieldsCharCase else
    if Sender = lbDefaultValue  then tmpStrings := DefaultValues else
    if Sender = lbDisplayFormat then tmpStrings := FieldsDisplayFormat else
    if Sender = lbDisplayLabel  then tmpStrings := FieldsDisplayLabel else
    if Sender = lbDisplayWidth  then tmpStrings := FieldsDisplayWidth else
    if Sender = lbEditMask      then tmpStrings := FieldsEditMask else
    if Sender = lbGridLabel     then tmpStrings := FieldsGridLabel else
    if Sender = lbReadOnly      then tmpStrings := FieldsReadOnly else
    if Sender = lbTrimming      then tmpStrings := FieldsTrimming else
    if Sender = lbVisible       then tmpStrings := FieldsVisible else
    if Sender = lbIndex         then tmpStrings := FieldsIndex;
  end;
  if Assigned( tmpStrings ) then
    with TdlgMemoEdit.Create( Self ) do
      try
        Caption := (Sender as TLabel).Caption;
        qrQuery.GetFieldNamesList( LinkList );
        SourceList := tmpStrings;
        if ShowModal = mrOk then
          pcQueryChange( Sender );
      finally
        Free;
      end;
end;

procedure TfrmQuery.lbColListClick(Sender: TObject);
var
  SFld: string;
  tmpStr: string;
  tmpPos: integer;
begin
  if not SettingColAttr then
  begin
    SettingColAttr := true;
    try
      if lbColList.Items.Count > 0 then
      begin
        if lbColList.ItemIndex = -1 then
        begin
          lbColList.ItemIndex := 0;
          Exit;
        end;
        SFld := lbColList.Items[ lbColList.ItemIndex ];
        with qrQuery.ColumnAttributes do
        begin
          cbBlankIsNull.Checked := LinkParamIsSet[ SFld, IB_BLANKISNULL ];
          cbBoolean.Checked := LinkParamIsSet[ SFld, IB_BOOLEAN ];
          cbNoCase.Checked := LinkParamIsSet[ SFld, IB_NOCASE ];
          cbComputed.Checked := LinkParamIsSet[ SFld, IB_COMPUTED ];
          cbCurrency.Checked := LinkParamIsSet[ SFld, IB_CURRENCY ];
          cbNoDate.Checked := LinkParamIsSet[ SFld, IB_NODATE ];
          cbNoTime.Checked := LinkParamIsSet[ SFld, IB_NOTIME ];
          cbNoTrailing.Checked := LinkParamIsSet[ SFld, IB_NOTRAILING ];
          if LinkParamIsSet[ SFld, IB_REQUIRED ] then
            cbRequired.State := cbChecked
          else
          if LinkParamIsSet[ SFld, IB_NOTREQUIRED ] then
            cbRequired.State := cbUnchecked
          else
            cbRequired.State := cbGrayed;
          if LinkParamIsSet[ SFld, IB_SOUNDEX ] then
            cbSoundex.State := cbChecked
          else
          if LinkParamIsSet[ SFld, IB_NOSOUNDEX ] then
            cbSoundex.State := cbUnchecked
          else
            cbSoundex.State := cbGrayed;

          if LinkParamIsSet[ SFld, IB_BCD ] then
            cbBCD.State := cbChecked
          else
          if LinkParamIsSet[ SFld, IB_NOBCD ] then
            cbBCD.State := cbUnchecked
          else
            cbBCD.State := cbGrayed;

          cbYesCase.Checked := LinkParamIsSet[ SFld, IB_YESCASE ];
          cbYesLike.Checked := LinkParamIsSet[ SFld, IB_YESLIKE ];
          cbYesTrailing.Checked := LinkParamIsSet[ SFld, IB_YESTRAILING ];
          if LinkParamIsSet[ SFld, IB_BOOLEAN ] then
          begin
            tmpStr := LinkParamValue[ SFld, IB_BOOLEAN ];
            tmpPos := Pos( ',', tmpStr );
            if tmpPos > 0 then
            begin
              edTrueText.Text := Copy( tmpStr, 1, tmpPos - 1 );
              edFalseText.Text := Copy( tmpStr, tmpPos + 1, MaxInt );
            end
            else
            begin
              edTrueText.Text := '';
              edFalseText.Text := '';
            end;
          end
          else
          begin
            edTrueText.Text := '';
            edFalseText.Text := '';
          end;
          edUpperCaseEq.Text := LinkParamValue[ SFld, IB_NOCASE ];
          edSoundexEq.Text := LinkParamValue[ SFld, IB_SOUNDEX ];
        end;
      end
      else
      begin
        cbBlankIsNull.State := cbUnchecked;
        cbBoolean.State := cbUnchecked;
        cbNoCase.State := cbUnchecked;
        cbComputed.State := cbUnchecked;
        cbCurrency.State := cbUnchecked;
        cbNoDate.State := cbUnchecked;
        cbNoTime.State := cbUnchecked;
        cbNoTrailing.State := cbUnchecked;
        cbRequired.State := cbGrayed;
        cbSoundex.State := cbGrayed;
        cbBCD.State := cbGrayed;
        cbYesCase.State := cbUnchecked;
        cbYesLike.State := cbUnchecked;
        cbYesTrailing.State := cbUnchecked;
        edTrueText.Text := '';
        edFalseText.Text := '';
        edUpperCaseEq.Text := '';
        edSoundexEq.Text := '';
      end;
    finally
      SettingColAttr := false;
    end;
  end;
end;

procedure TfrmQuery.cbColAttrClick(Sender: TObject);
var
  ii: integer;
  SFld: string;
  procedure AssignColAttr(SFld : string);
  begin
    with qrQuery.ColumnAttributes do
    begin
      LinkParamIsSet[ SFld, IB_BLANKISNULL ] := cbBlankIsNull.Checked;
      LinkParamIsSet[ SFld, IB_BOOLEAN ] := cbBoolean.Checked;
      LinkParamIsSet[ SFld, IB_NOCASE ] := cbNoCase.Checked;
      LinkParamIsSet[ SFld, IB_COMPUTED ] := cbComputed.Checked;
      LinkParamIsSet[ SFld, IB_CURRENCY ] := cbCurrency.Checked;
      LinkParamIsSet[ SFld, IB_NODATE ] := cbNoDate.Checked;
      LinkParamIsSet[ SFld, IB_NOTIME ] := cbNoTime.Checked;
      LinkParamIsSet[ SFld, IB_NOTRAILING ] := cbNoTrailing.Checked;
      if cbRequired.State = cbChecked then
      begin
        LinkParamIsSet[ SFld, IB_REQUIRED ] := true;
        LinkParamIsSet[ SFld, IB_NOTREQUIRED ] := false;
      end
      else
      if cbRequired.State = cbUnchecked then
      begin
        LinkParamIsSet[ SFld, IB_REQUIRED ] := false;
        LinkParamIsSet[ SFld, IB_NOTREQUIRED ] := true;
      end
      else
      begin
        LinkParamIsSet[ SFld, IB_REQUIRED ] := false;
        LinkParamIsSet[ SFld, IB_NOTREQUIRED ] := false;
      end;
      if cbSoundex.State = cbChecked then
      begin
        LinkParamIsSet[ SFld, IB_SOUNDEX ] := true;
        LinkParamIsSet[ SFld, IB_NOSOUNDEX ] := false;
      end
      else
      if cbSoundex.State = cbUnchecked then
      begin
        LinkParamIsSet[ SFld, IB_SOUNDEX ] := false;
        LinkParamIsSet[ SFld, IB_NOSOUNDEX ] := true;
      end
      else
      begin
        LinkParamIsSet[ SFld, IB_SOUNDEX ] := false;
        LinkParamIsSet[ SFld, IB_NOSOUNDEX ] := false;
      end;
      if cbBCD.State = cbChecked then
      begin
        LinkParamIsSet[ SFld, IB_BCD ] := true;
        LinkParamIsSet[ SFld, IB_NOBCD ] := false;
      end
      else
      if cbBCD.State = cbUnchecked then
      begin
        LinkParamIsSet[ SFld, IB_BCD ] := false;
        LinkParamIsSet[ SFld, IB_NOBCD ] := true;
      end
      else
      begin
        LinkParamIsSet[ SFld, IB_BCD ] := false;
        LinkParamIsSet[ SFld, IB_NOBCD ] := false;
      end;
      LinkParamIsSet[ SFld, IB_YESCASE ] := cbYesCase.Checked;
      LinkParamIsSet[ SFld, IB_YESLIKE ] := cbYesLike.Checked;
      LinkParamIsSet[ SFld, IB_YESTRAILING ] := cbYesTrailing.Checked;
    end;
  end;
begin
  if SettingColAttr then Exit;
  with lbColList do
    if (SelCount > 0) then
      for ii := 0 to Items.Count - 1 do
      if Selected[ii] then
      begin
        SFld := Items[ii];
        AssignColAttr(SFld);
      end;
  btApply.Enabled := True;      
end;

procedure TfrmQuery.sbNewColAttrClick(Sender: TObject);
var
  s: string;
  tmpInt: integer;
begin
  edColAttrExit( Sender );
  if InputQuery( 'New ColumnAttribute entry:', '', s ) and
     ( s <> '' ) then
  begin
    tmpInt := lbColList.Items.IndexOf( s );
    if tmpInt < 0 then
      tmpInt := lbColList.Items.Add( s );
    lbColList.ItemIndex := tmpInt;
    lbColListClick( lbColList );
  end;
end;

procedure TfrmQuery.sbRemoveColAttrClick(Sender: TObject);
var
  s: string;
  tmpInt: integer;
begin
  edColAttrExit( Sender );
  if lbColList.ItemIndex >= 0 then
  begin
    s := lbColList.Items[ lbColList.ItemIndex ];
    qrQuery.ColumnAttributes.LinkValues[ s ] := '';
    tmpInt := lbColList.ItemIndex;
    lbColList.Items.Delete( lbColList.ItemIndex );
    if tmpInt >= lbColList.Items.Count then
      tmpInt := lbColList.Items.Count - 1;
    lbColList.ItemIndex := tmpInt;
    lbColListClick( lbColList );
  end;
end;

procedure TfrmQuery.sbBrowseColAttrClick(Sender: TObject);
begin
  with TdlgMemoEdit.Create( Self ) do
    try
      Caption := 'Browse/Edit Column Attributes';
      SourceList := qrQuery.ColumnAttributes;
      if ShowModal = mrOk then
        pcQueryChange( Sender );
    finally
      Free;
    end;
end;

procedure TfrmQuery.edColAttrChange(Sender: TObject);
begin
  ColEditChanged := true;
end;

procedure TfrmQuery.edColAttrEnter(Sender: TObject);
begin
  ColEditChanged := false;
end;

procedure TfrmQuery.edColAttrExit(Sender: TObject);
var
  s: string;
  ii: integer;
begin
  if not ColEditChanged then exit;
  if lbColList.SelCount > 0 then
    for ii := 0 to lbColList.Items.Count - 1 do
      if lbColList.Selected[ii] then
      begin
        s := lbColList.Items[ ii ];
        with qrQuery.ColumnAttributes do
        if ( Sender = edTrueText ) or
           ( Sender = edFalseText ) then
          LinkParamValue[ s, IB_BOOLEAN ] := edTrueText.Text + ',' +
                                           edFalseText.Text
        else
        if Sender = edUpperCaseEq then
          LinkParamValue[ s, IB_NOCASE ] := edUpperCaseEq.Text
        else
        if Sender = edSoundexEq then
          LinkParamValue[ s, IB_SOUNDEX ] := edSoundexEq.Text;
      end;
  btApply.Enabled := True;    
end;

procedure TfrmQuery.qrQueryPreparedChanged(Sender: TIB_Statement);
begin
  ResetFieldLists;
  lbColListClick( Sender );
  lbFldListClick( Sender );
end;

procedure TfrmQuery.ShowProcNames1Click(Sender: TObject);
begin
  if Sender = ShowViewNames1 then
    ShowViewNames1.Checked := not ShowViewNames1.Checked;
  if Sender = ShowProcNames1 then
    ShowProcNames1.Checked := not ShowProcNames1.Checked;
  csBaseConnectedChanged( csBase, BaseConnection );
end;

procedure TfrmQuery.DiscardComputedCols(tname: String; slFields: TStringList);
var
  slComp: TStringList;
  iter, idx: Integer;
begin
  // If someone is able to define a computed field as part of the PK,
  // then it's his/her problem!
  slComp := TStringList.Create;
  try
    SchemaComputedCols(BaseConnection, nil, true, tname, slComp);
    for iter := 0 to slComp.Count - 1 do
    begin
      idx := slFields.IndexOf(slComp[iter]);
      if idx > -1
      then slFields.Delete(idx);
    end;
  finally
    slComp.Free
  end;
end;

procedure TfrmQuery.sbGenTableSQLClick(Sender: TObject);
var
  tname, aux: string;
  lbTemp: TListBox;
  slfields, slKeys, slTemp: TStringList;
  iter, idx, iPos : Integer;
begin
  inherited;

  // be sure to have a valid query
  if not qrQuery.Prepared then
    qrQuery.Prepare;

  tname := '';

  slFields := TStringList.Create;
  slTemp := TStringList.Create;
  slKeys := TStringList.Create;
  try
    qrQuery.GetFieldNamesList(slFields);
// if the result of the GetFieldNamesList is like "Table1.Field1 ...,
// Table2.FieldA ...", we have obviously a joined query and we can
// extract the TableNames from the list. They are collected in slTemp.
    if Pos('.', slFields.Text) > 0 then
    begin
      for iter := 0 to slFields.Count - 1 do
      begin
        aux := slFields[iter];
        iPos := Pos('.', aux);
        if iPos > 0 then
        begin
          slTemp.BeginUpdate;
          aux := Copy(aux, 1, iPos - 1);
          if (slTemp.IndexOf(aux)) = -1 then
            slTemp.Add(aux);
          slTemp.EndUpdate;
        end;
      end;

      with IBF_GenCustomSQL.CreateDialogOnDemand(PanelUpdateSQL, lbTemp) do
      try
        lbTemp.Items.Assign(slTemp{BaseConnection.SchemaCache.TableName});
        if ShowModal = mrOk then
          tname := lbTemp.Items[lbTemp.ItemIndex]
        else
          Exit;
      finally
        Free;
      end;
    end else
    if Pos('FOR UPDATE', UpperCase(qrQuery.SQL.Text)) > 0 then
      raise Exception.Create(E_UPDATESQL_NOT_NECESSARY)
    else
    begin
      tname := qrQuery.Fields[0].RelName;
      // don't like this: adding the RelationName and then deleting it again
      // but because non-editable fields like calculated fields from subselects
      // must be eliminated later the lsFields must be FullFieldNames
      with slfields do
      try
        BeginUpdate;
        Clear;
        for iter := 0 to qrQuery.Fields.ColumnCount - 1 do
          Add(qrQuery.Fields[iter].FullFieldName);
      finally
        EndUpdate;
      end;
    end;

    if tname = '' then
      Exit;

// after selecting the table that should be updated we want the FieldNames
// of that table. We get them again from the FieldNamesList.
// Those fields that have no table-extension
// are presumed to be calculated fields and therefore are eliminated.
// We want "pure" FieldNames without the Table-extension:
// not Table1.Field1 but: Field1.

    for iter := slFields.Count - 1 downto 0 do
      if Pos(tname + '.', slFields[iter]) > 0 then
        slFields[iter] := Copy(slFields[iter], Pos('.', slFields[iter]) + 1,
                    Length(slFields[iter]))
      else
        slFields.Delete(iter);

      DiscardComputedCols(tname, slFields);
//  BaseConnection.SchemaCache.GetTableFields( tname, slFields );
//  Cannot use below call because it prepends table name to field names
//  BaseConnection.SchemaCache.GetTableKeys(tname, slKeys);

// SchemaPrimaryKeyInfo fills a List with the Table's KeyFields
// but may be KeyFields are not or only partially included in the SQL-Statement
    slTemp.Clear;
    SchemaPrimaryKeyInfo( BaseConnection, nil, tname, slTemp);
// fill the slKeys-List and remove the KeyFields from the slFields-List
    slKeys.BeginUpdate;
    try
      for iter := 0 to slTemp.Count - 1 do
      begin
        idx := slfields.IndexOf(slTemp[iter]);
        if idx > -1 then
        begin
          slKeys.Add(slTemp[iter]);
          slfields.Delete(idx);
        end;
      end;
    finally
      slKeys.EndUpdate;
    end;
  // Build common part for both EditSQL and DeleteSQL
    with slTemp do
    begin
      BeginUpdate;
      Clear;
      Add('WHERE');
    // Magic for dialect 3 syntax.
      for iter := 0 to slKeys.Count - 1 do
      begin
        aux := BaseConnection.MkVarIdent( 'OLD_' +
                                        stLitCriteria(slKeys[iter]));
        Add('   ' + slKeys[iter] + ' = :' + aux + ' AND');
      end;
      if slKeys.Count > 0 then
      begin
        aux := Strings[Count - 1];
        SetLength(aux, Length(aux) - 4);
        Strings[Count - 1] := aux;
      end
      else
        Add( 'RDB$DB_KEY = :DB_KEY' );
      EndUpdate;
    end;
  // Go for edit
    if cbGenEditSQL.Checked then With meEditSQL.Lines do
    try
      BeginUpdate;
      Clear;
      Add('UPDATE ' + tname + ' SET');
// Here are the two lines, that solve the problem
      for iter := 0 to slKeys.Count - 1 do
        Add('   ' + slKeys[iter] + ' = :'+slKeys[iter]+', /*PK*/');
      if slFields.Count = 0 then                           // Added by H.S.
      begin                                                // Added by H.S.
        aux := Strings[Count - 1];                         // Added by H.S.
        aux[length(aux) - 7] := ' ';                       // Added by H.S.
        Strings[Count - 1] := aux;                         // Added by H.S.
      end else                                             // Added by H.S.
      begin                                                // Added by H.S.
        for iter := 0 to slFields.Count - 1 do
          Add('   ' + slFields[iter] + ' = :' + slFields[iter] + ',');
        aux := Strings[Count - 1];
        SetLength(aux, Length(aux) - 1);
        Strings[Count - 1] := aux;
      end;                                                 // Added by H.S.
        AddStrings(slTemp);
    finally
      EndUpdate;
    end;
  // Go for insert
    if cbGenInsertSQL.Checked then With meInsertSQL.Lines do
    try
      BeginUpdate;
      Clear;
      Add('INSERT INTO ' + tname + '(');
      for iter := 0 to slKeys.Count - 1 do
        Add('   ' + slKeys[iter] + ', /*PK*/');
      if slFields.Count = 0 then                           // Added by H.S.
      begin                                                // Added by H.S.
        aux := Strings[Count - 1];                         // Added by H.S.
        aux[length(aux) - 7] := ')';                       // Added by H.S.
        Strings[Count - 1] := aux;                         // Added by H.S.
      end else                                             // Added by H.S.
      begin                                                // Added by H.S.
        for iter := 0 to slFields.Count - 1 do
          Add('   ' + slFields[iter] + ',');
        aux := Strings[Count - 1];
        aux[length(aux)] := ')';
        Strings[Count - 1] := aux;
      end;                                                 // Added by H.S.
      Add('VALUES (');
      for iter := 0 to slKeys.Count - 1 do
        Add('   :' + slKeys[iter] + ',');
      for iter := 0 to slFields.Count - 1 do
        Add('   :' + slFields[iter] + ',');
      aux := Strings[Count - 1];
      aux[length(aux)] := ')';
      Strings[Count - 1] := aux;
    finally
      EndUpdate;
    end;
  // Go for delete
    if cbGenDeleteSQL.Checked then With meDeleteSQL.Lines do
    try
      BeginUpdate;
      Clear;
      Add('DELETE FROM ' + tname);
      AddStrings(slTemp);
    finally
      EndUpdate;
    end;
  finally
    slKeys.Free;
    slFields.Free;
    slTemp.Free;
  end;
end;

procedure TfrmQuery.sbGenProcSQLClick(Sender: TObject);
begin
  inherited;
  With TfrmGenCustomSQL.Create(Self) do
  try
    InitValues(BaseConnection, meEditSQL, meInsertSQL, meDeleteSQL);
    ShowModal
  finally
    Free
  end
end;

procedure TfrmQuery.LoadOrderingDefaults1Click(Sender: TObject);
var
  iter, iter2, inspos: Integer;
  s, fn: String;
  sl_oi, sl_sl: TStringList;
  ibc: TIB_Column;
  qualified: Boolean;
begin
  inherited;
  With qrQuery do
  begin
    meOrderingItems.Clear;
    Prepare;
    qualified := Fields.RelationCount > 1;
    sl_oi := TStringList.Create;
    sl_sl := TStringList.Create;
    With sl_oi do
    try
      for iter := 0 to Fields.ColumnCount - 1 do
      begin
        ibc := Fields[iter];
        if ibc.IsCalculated or ibc.IsBlob or not ibc.Visible
        then continue;
        if ibc.RelName = EmptyStr
        then fn := IntToStr(ibc.FieldNo)
        else if qualified
        then fn := ibc.FullFieldName + ';' + ibc.FullFieldName + ' DESC'
        else fn := ibc.FieldName + ';' + ibc.FieldName + ' DESC';
        s := AnsiUpperCase(stLitCriteria(ibc.FieldName));
        for iter2 := 1 to Length(s) do
          if not (s[iter2] in ['0'..'9', 'A'..'Z']) then
            s[iter2] := '_';
        //inspos := -1;
        if Values[s] = EmptyStr then
          inspos := Add(s + '=' + fn)
        else
        begin
          iter2 := 1;
          while Values[s + IntToStr(iter2)] <> EmptyStr do
            Inc(iter2);
          inspos := Add(s + IntToStr(iter2) + '=' + fn)
        end;
        // We cannot search in server-side expressions or aggregate columns
        if not ibc.PreventSearching and (ibc.RelName <> EmptyStr) then
        begin
          {if qualified
          then sl_sl.Add(ibc.FullFieldName + '=' + Names[inspos])
          else sl_sl.Add(ibc.FieldName + '=' + Names[inspos])}
          sl_sl.Add(Names[inspos] + '=' + Names[inspos]);
        end
      end;
      meOrderingItems.Lines.Assign(sl_oi);
      meOrderingLinks.Lines.BeginUpdate;
      try
        meOrderingLinks.Clear;
        for iter := 0 to Count - 1 do
          meOrderingLinks.Lines.Add(Names[iter] + '=' + IntToStr(iter + 1));
      finally
        meOrderingLinks.Lines.EndUpdate;
      end;
      meSearchingLinks.Lines.Assign(sl_sl);
    finally
      Free;
      sl_sl.Free;
    end; // with sl_oi
  end;
end;

procedure TfrmQuery.pmOrderingCalcFieldsPopup(Sender: TObject);
var
  iter: Integer;
begin
  inherited;
  With pmOrderingCalcFields.Items do
    for iter := 0 to Count - 1 do
      Items[iter].Visible := False;
  With pcQuerySQL do
  begin
    if ActivePage = tsOrdering
    then begin
      LoadOrderingDefaults1.Visible := True;
      if pcOrderingSearching.ActivePage = tsSearchingLinks then
        CreateSearchingLinks.Visible := True;
    end;
    if ActivePage = tsCalculatedFields
    then CreateCalculatedField1.Visible := True
  end
end;

procedure TfrmQuery.CreateCalculatedField1Click(Sender: TObject);
begin
  inherited;
  With TfrmGenCalcFields.Create(Self) do
  try
    InitValues(BaseConnection, meCalculatedFields);
    ShowModal
  finally
    Free
  end
end;

// this procedure added by luc
procedure TfrmQuery.btnCreateOrderingClick(Sender: TObject);
var
	tmpStrings: TIB_StringList;
	obyList		: TIB_StringList;
	doIt			: Boolean;
	useDesc		: Boolean;
	useDNames	: Boolean;
	fdName		: String;
	ii				: Integer;
	refineNo	: Integer;
	refVals		: String;
  qualified : Boolean;
  QFName    : string;
begin
	inherited;
	qrQuery.Prepare;
  qualified := qrQuery.Fields.RelationCount > 1;
	tmpStrings := TIB_StringList.Create;
	obyList := TIB_StringList.Create;
	try
		for ii := 0 to qrQuery.OrderingLinks.Count -1 do
			obyList.Add ( qrQuery.OrderingLinks.Names[ii] );


		// if refinement is already used, try to get the number of it otherwise set it to -1
		refineNo := -1;
		if meOrderingLinks.Lines.Count > 0 then
		begin
			refVals := copy ( trim( meOrderingLinks.Lines[0] ),
											 length ( meOrderingLinks.Lines[0]) -4, 4 );
			if refVals = 'POS=' then
			begin
				refVals := copy ( trim( meOrderingLinks.Lines[0] ),
											 length ( meOrderingLinks.Lines[0]), 1 )[1];
				if refVals[1] in [ '0'..'9' ] then refineNo := StrToInt ( refVals[1] );
			end;
		end;

		doIt := FALSE;
		useDesc := FALSE;
		useDNames := FALSE;
		with TdlgCLBoxEdit.Create( Self ) do
		begin
			try
				Caption := 'Set ordering items';
				qrQuery.GetFieldNamesList( LinkList );
				CurrentOrderBy := obyList;
				SourceList := tmpStrings;
				seRefine.Value := refineNo;
				if ShowModal = mrOk then
				begin
					doIT := TRUE;
					useDesc := AddDescLinks;
					useDNames := useDisplayNames;
					refineNo := seRefine.Value;
				end;
			finally
				Free;
			end;
		end;
		doIt := doIt AND
						( MessageDlg ( M_QRY_ASSIGN_ORDERING_ITEMS,
													 mtConfirmation, [mbYes, mbNo], 0 ) = mrYes );
		if doIt then
		begin
			meOrderingItems.Clear;
			meOrderingLinks.Clear;
			for ii := 0 to tmpStrings.Count - 1 do
			begin
				fdName := tmpStrings[ii];
				if useDNames then begin
					fdName := qrQuery.FieldsDisplayLabel.Values[fdName];
          if fdName = '' then
            fdName := qrQuery.IB_Connection.FieldsDisplayLabel.Values[qrQuery.FieldByName(tmpStrings[ii]).FullFieldName]; {RelName + '.' + tmpStrings[ii]];}
          if fdName = '' then
            fdName := qrQuery.IB_Connection.FieldsDisplayLabel.Values[tmpStrings[ii]];
        end;
				if fdName = '' then
					fdName := tmpStrings[ii];
        if qualified then
          QFName := qrQuery.FieldByName(tmpStrings[ii]).FullFieldName
        else
          QFName := tmpStrings[ii];
				if useDesc then
					meOrderingItems.Lines.Add( fdName + '=' +
																		 QFName + ';' +
																		 QFName + ' DESC' )
				else
					meOrderingItems.Lines.Add( fdName + '=' +
																		 QFName );
				if refineNo >= 0
					then meOrderingLinks.Lines.Add( tmpStrings[ii] + '=ITEM=' + IntToStr ( ii + 1 )
																					+ ';POS=' + IntToStr ( refineNo ) )	// use Refinement
					else meOrderingLinks.Lines.Add( tmpStrings[ii] + '=ITEM=' + IntToStr ( ii + 1 ) );	// don't use it
			end;
			// set current ordering item into range, if necessary
			seOrderingItemNo.MaxValue := meOrderingItems.Lines.Count;
			seOrderingItemNo.MinValue := -meOrderingItems.Lines.Count;
			if seOrderingItemNo.Value > seOrderingItemNo.MaxValue then
				seOrderingItemNo.Value := seOrderingItemNo.MaxValue
			else
			if seOrderingItemNo.Value < seOrderingItemNo.MinValue then
				seOrderingItemNo.Value := seOrderingItemNo.MinValue
		end;
	finally
		tmpStrings.Free;
		obyList.Free;
	end;
end;

procedure TfrmQuery.CopyFieldsToClipboardClick(Sender: TObject);
var
  i: integer;
  ClipStr: string;
begin
  inherited;
  ClipStr := '';
  for i := 0 to qrQuery.FieldCount-1 do begin
    ClipStr := ClipStr + qrQuery.Fields[i].FieldName + #13#10;
  end;
  Clipboard.AsText := ClipStr;
end;

procedure TfrmQuery.CreateSearchingLinksClick(Sender: TObject);
var
  iter: Integer;
  fn: String;
  ibc: TIB_Column;
//  qualified: Boolean;
  fname: String;
begin
  inherited;
  With qrQuery do
  begin
    Prepare;
//    qualified := Fields.RelationCount > 1;
    meSearchingLinks.Lines.Clear;
    for iter := 0 to meOrderingLinks.Lines.Count-1 {Fields.ColumnCount - 1} do
    begin
      fname := meOrderingLinks.Lines.Names[iter];
      ibc := FieldByName(fname);
      if ibc.IsCalculated or ibc.IsBlob or not ibc.Visible
      then continue;
      if ibc.RelName = EmptyStr
      then fn := IntToStr(ibc.FieldNo)
      {else if qualified
      then fn := ibc.FullFieldName + '=' + ibc.FullFieldName}
      else fn := ibc.FieldName + '=' + ibc.FieldName;
      // We cannot search in server-side expressions or aggregate columns
      if not ibc.PreventSearching and (ibc.RelName <> EmptyStr) then
      begin
        meSearchingLinks.Lines.Add(fn);
      end
    end;
  end;
end;

procedure TfrmQuery.miUseTableAliasClick(Sender: TObject);
begin
  inherited;
  miUseTableAlias.Checked := not miUseTableAlias.Checked
end;

procedure TfrmQuery.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) and
     not qrQuery.Fetching and not qrQuery.NeedToPost and
     (not btApply.Enabled or (MessageDlg('Cancel changes ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes)) then btCancel.Click;
end;

procedure TfrmQuery.cbGenUpdateSQLForTablesClick(Sender: TObject);
begin
  inherited;
  sbGenTableSQL.Enabled := cbGenEditSQL.Checked or cbGenInsertSQL.Checked or cbGenDeleteSQL.Checked;
end;

procedure TfrmQuery.meQueryPropertyChange(Sender: TObject);
begin
  inherited;
  btApply.Enabled := True;
end;

procedure TfrmQuery.btApplyClick(Sender: TObject);
begin
  inherited;
  btApply.Enabled := False;
end;

end.
