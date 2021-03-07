unit
  FRM_IBOQuery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Grids,

  DB,
  DBCtrls,
  DBGrids,
  DBTables,

  IBF_Base,

  IB_Header,
  IB_Session,
  IB_Components,
  IBODataSet,
  IB_ConnectionSource,
  IB_TransactionSource,
  IB_UtilityBar; //IB_FieldDataLink

type
  TfrmIBOQuery = class(TfrmBase)
    DataSource: TDataSource;
    Panel3: TPanel;
    btOpen: TButton;
    btClose: TButton;
    DBNavigator1: TDBNavigator;
    BDEQuery: TQuery;
    Database: TDatabase;
    btDB: TButton;
    pcDBGrid: TPageControl;
    tsGrid: TTabSheet;
    DBGrid1: TDBGrid;
    tsSQL: TTabSheet;
    tsDatabase: TTabSheet;
    Panel1: TPanel;
    meSQL: TMemo;
    lbDatabase: TLabel;
    lbUsername: TLabel;
    lbPassword: TLabel;
    edDatabase: TEdit;
    edUsername: TEdit;
    edPassword: TEdit;
    cbRemember: TCheckBox;
    IBOQuery: TIBOQuery;
    trDemo: TIB_Transaction;
    cnDemo: TIB_Connection;
    IB_UtilityBar1: TIB_UtilityBar;
    cbRequestLive: TCheckBox;
    btAppend: TButton;
    tsMemo: TTabSheet;
    DBMemo1: TDBMemo;
    cbFiltered: TCheckBox;
    edFilter: TEdit;
    lbFilter: TLabel;
    Button1: TButton;
    cbNoPartial: TCheckBox;
    cbNoCase: TCheckBox;
    procedure btOpenClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btDBClick(Sender: TObject);
    procedure edDatabaseChange(Sender: TObject);
    procedure meSQLChange(Sender: TObject);
    procedure cnDemoBeforeConnect(Sender: TIB_Connection);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbRequestLiveClick(Sender: TObject);
    procedure btAppendClick(Sender: TObject);
    procedure IBOQueryBeforePrepare(Sender: TObject);
    procedure edFilterChange(Sender: TObject);
    procedure cbFilteredClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbNoPartialClick(Sender: TObject);
    procedure cbNoCaseClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure DoReadSettings; override;
    procedure DoWriteSettings; override;
  public
    { Public declarations }
  end;

var
  frmIBOQuery: TfrmIBOQuery;

implementation

{$R *.DFM}

procedure TfrmIBOQuery.FormCreate(Sender: TObject);
begin
  SetDefaultBounds( 0, 0, 400, 350 );
{$IFDEF CPPBUILDER3}
  BaseKey := 'Software\Apps\IBOQuery';
{$ENDIF}
  btDB.Click;
  cbRequestLive.Checked := true;
end;

procedure TfrmIBOQuery.FormDestroy(Sender: TObject);
begin
{$IFDEF CPPBUILDER3}
  BaseKey := '';
{$ENDIF}
end;

procedure TfrmIBOQuery.DoReadSettings;
begin
  with RegDB do begin
    edDatabase.Text := ReadString( 'Settings',
                                   'Database',
                   'c:\Program Files\Borland\Delphi 3\Demos\DATA\Mastsql.gdb' );
    edUsername.Text := ReadString( 'Settings', 'Username', 'SYSDBA' );
    edPassword.Text := ReadString( 'Settings', 'Password', 'masterkey' );
    cbRemember.Checked := ReadBool( 'Settings', 'cbRemember', false );
    edFilter.Text := ReadString( 'Settings', 'Filter', '' );
    cbFiltered.Checked := ReadBool( 'Settings', 'Filtered', false );
    cbRequestLive.Checked := ReadBool( 'Settings', 'RequestLive', false );
    ReadStrings( 'meBDESQL', meSQL.Lines );
    if meSQL.Lines.Count = 0 then begin
      meSQL.Lines.Text := 'SELECT * FROM CUSTOMER ORDER BY CUSTNO';
    end;
  end;
end;

procedure TfrmIBOQuery.DoWriteSettings;
begin
  with RegDB do begin
    WriteString( 'Settings', 'Database', edDatabase.Text );
    WriteString( 'Settings', 'Username', edUsername.Text );
    WriteBool( 'Settings', 'cbRemember', cbRemember.Checked );
    WriteBool( 'Settings', 'Filtered', cbFiltered.Checked );
    WriteBool( 'Settings', 'RequestLive', cbRequestLive.Checked );
    if cbRemember.Checked then begin
      WriteString( 'Settings', 'Password', edPassword.Text );
    end else begin
      WriteString( 'Settings', 'Password', '' );
    end;
    WriteString( 'Settings', 'Filter', edFilter.Text );
    WriteStrings( 'meBDESQL', meSQL.Lines );
  end;
end;

{------------------------------------------------------------------------------}

procedure TfrmIBOQuery.btOpenClick(Sender: TObject);
begin
  try
  if not IBOQuery.Prepared then IBOQuery.Prepare;
  except
  end;
  try
  if not BDEQuery.Prepared then BDEQuery.Prepare;
  except
  end;
  pcDBGrid.ActivePage := tsGrid;
  DataSource.DataSet.Active := true;
end;

procedure TfrmIBOQuery.btCloseClick(Sender: TObject);
begin
  DataSource.DataSet.Active := false;
end;

procedure TfrmIBOQuery.btDBClick(Sender: TObject);
begin
  with DataSource do
  begin
    if DataSet = IBOQuery then
    begin
      DataSet := BDEQuery;
      btDB.caption := 'BDE';
      DBGrid1.Color := clInfoBK;
    end
    else
    begin
      DataSet := IBOQuery;
      btDB.caption := 'IBO';
      DBGrid1.Color := clWindow;
    end;
  end;
end;

procedure TfrmIBOQuery.edDatabaseChange(Sender: TObject);
begin
  IBOQuery.Active := false;
  Database.Connected := false;
  cnDemo.Connected := false;
end;

procedure TfrmIBOQuery.meSQLChange(Sender: TObject);
begin
  IBOQuery.Prepared := false;
  BDEQuery.Active := false;
end;

procedure TfrmIBOQuery.cnDemoBeforeConnect(Sender: TIB_Connection);
begin
  Database.Params.Values[ 'SERVER NAME' ] := edDatabase.Text;
  Database.Params.Values[ 'USER NAME'   ] := edUsername.Text;
  Database.Params.Values[ 'PASSWORD'    ] := edPassword.Text;
  cnDemo.Database := edDatabase.Text;
  cnDemo.Username := edUsername.Text;
  cnDemo.Password := edPassword.Text;
end;

procedure TfrmIBOQuery.cbRequestLiveClick(Sender: TObject);
begin
  IBOQuery.Unprepare;
  BDEQuery.Unprepare;
  IBOQuery.RequestLive := cbRequestLive.Checked;
  BDEQuery.RequestLive := cbRequestLive.Checked;
end;

procedure TfrmIBOQuery.btAppendClick(Sender: TObject);
begin
  DataSource.DataSet.Append;
end;

procedure TfrmIBOQuery.IBOQueryBeforePrepare(Sender: TObject);
begin
  BDEQuery.SQL.Text := meSQL.Lines.Text;
  IBOQuery.SQL.Text := meSQL.Lines.Text;
  BDEQuery.Filter := edFilter.Text;
  IBOQuery.Filter := edFilter.Text;
  BDEQuery.Filtered := cbFiltered.Checked;
  IBOQuery.Filtered := cbFiltered.Checked;
end;

procedure TfrmIBOQuery.edFilterChange(Sender: TObject);
begin
  if cbFiltered.Checked then begin
    cbFiltered.Checked := false;
  end;
end;

procedure TfrmIBOQuery.cbFilteredClick(Sender: TObject);
begin
  if cbFiltered.Checked then begin
    BDEQuery.Filter := edFilter.Text;
    IBOQuery.Filter := edFilter.Text;
  end;
  BDEQuery.Filtered := cbFiltered.Checked;
  IBOQuery.Filtered := cbFiltered.Checked;
  if not cbFiltered.Checked then begin
    BDEQuery.Filter := edFilter.Text;
    IBOQuery.Filter := edFilter.Text;
  end;
end;

procedure TfrmIBOQuery.cbNoPartialClick(Sender: TObject);
begin
  if cbNoPartial.Checked then begin
    BDEQuery.FilterOptions := BDEQuery.FilterOptions + [ foNoPartialCompare ];
    IBOQuery.FilterOptions := IBOQuery.FilterOptions + [ foNoPartialCompare ];
  end else begin
    BDEQuery.FilterOptions := BDEQuery.FilterOptions - [ foNoPartialCompare ];
    IBOQuery.FilterOptions := IBOQuery.FilterOptions - [ foNoPartialCompare ];
  end;
end;

procedure TfrmIBOQuery.cbNoCaseClick(Sender: TObject);
begin
  if cbNoCase.Checked then begin
    BDEQuery.FilterOptions := BDEQuery.FilterOptions + [ foCaseInsensitive ];
    IBOQuery.FilterOptions := IBOQuery.FilterOptions + [ foCaseInsensitive ];
  end else begin
    BDEQuery.FilterOptions := BDEQuery.FilterOptions - [ foCaseInsensitive ];
    IBOQuery.FilterOptions := IBOQuery.FilterOptions - [ foCaseInsensitive ];
  end;
end;

procedure TfrmIBOQuery.Button1Click(Sender: TObject);
var
  MyBookmark: TBookmark;
begin
  with DataSource.Dataset do
  begin
    MyBookmark := GetBookmark;
    GotoBookmark( MyBookmark );
    FreeBookmark( MyBookmark );
  end;
end;

end.


