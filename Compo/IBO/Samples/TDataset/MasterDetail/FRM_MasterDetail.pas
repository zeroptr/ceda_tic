
{                                                                              }
{ FRM_MasterLinks                                                              }
{                                                                              }

unit
  FRM_MasterDetail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Buttons, StdCtrls, ExtCtrls, DBGrids, DBCtrls, Mask,

  Db,
//DBTables,

  IB_Session,
  IB_Constants,
  IB_Components,

  IBODataSet,
  IB_Dialogs;

type
  TfrmMasterDetail = class(TForm)
    cnMasterDetail: TIB_Connection;
    trMasterDetail: TIB_Transaction;
    tbCust: TIBOTable;
    dsCust: TDataSource;
    pnCust: TPanel;
    grCust: TDBGrid;
    dsOrders: TDataSource;
    pnOrders: TPanel;
    grItems: TDBGrid;
    odGDB: TOpenDialog;
    Panel1: TPanel;
    grOrders: TDBGrid;
    dsItems: TDataSource;
    qrItems: TIBOQuery;
    DBNavigator1: TDBNavigator;
    btCloseOpen: TButton;
    tbParts: TIBOTable;
    qrItemsITEMNO: TFloatField;
    qrItemsORDERNO: TFloatField;
    qrItemsPARTNO: TFloatField;
    qrItemsQTY: TIntegerField;
    qrItemsDISCOUNT: TFloatField;
    qrItemsPartDesc: TStringField;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
    md: TIB_MonitorDialog;
    btMonitor: TButton;
    tbOrders: TIBOTable;
    btSetRange: TButton;
    btCancelRange: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    tbCustCUSTNO2: TFloatField;
    tbCustCOMPANY2: TStringField;
    tbCustADDR12: TStringField;
    tbCustADDR22: TStringField;
    tbCustCITY2: TStringField;
    tbCustSTATE2: TStringField;
    tbCustZIP2: TStringField;
    tbCustCOUNTRY2: TStringField;
    tbCustPHONE2: TStringField;
    tbCustFAX2: TStringField;
    tbCustTAXRATE2: TFloatField;
    tbCustCONTACT2: TStringField;
    tbCustLASTINVOICEDATE2: TDateTimeField;
    btToggle: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cnMasterDetailBeforeConnect(Sender: TIB_Connection);
    procedure btCloseOpenClick(Sender: TObject);
    procedure btMonitorClick(Sender: TObject);
    procedure btSetRangeClick(Sender: TObject);
    procedure btCancelRangeClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure NewEvent(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure grCustTitleClick(Column: TColumn);
    procedure grOrdersTitleClick(Column: TColumn);
    procedure tbOrdersAfterPrepare(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMasterDetail: TfrmMasterDetail;

implementation

uses
  IBF_Monitor,   Registry;

{$R *.DFM}

procedure TfrmMasterDetail.btMonitorClick(Sender: TObject);
begin
  md.Show;
end;

procedure TfrmMasterDetail.cnMasterDetailBeforeConnect(
  Sender: TIB_Connection);
var
  MyReg: TRegINIFile;
begin
  MyReg := TRegIniFile.Create( IB_BASEKEY + '\Samples\Connections' );
  with Sender, odGDB do
  try
    if ConnectionStatus = csConnectPending then
    begin
      Database := MyReg.ReadString( 'Connections', 'MastSQL', Database );
// Allow a quick change of path if the file about to be opened is not found.
// Do not try and supply a GDB file over a mapped drive! If you do be sure to
// change it's path so that the server process can resolve the file's location.
      if ( Protocol = cpLocal ) and not FileExists( Database ) then
      begin
        FileName := Database;
        if Execute then
          Database := FileName
        else
          SysUtils.Abort;
      end;
    end
    else
    if ConnectionStatus = csConnected then
      MyReg.WriteString( 'Connections', 'MastSQL', Database );
  finally
    MyReg.Free;
  end;
end;

procedure TfrmMasterDetail.FormCreate(Sender: TObject);
begin
  tbCust.Open;
  tbParts.Open;
  tbOrders.Open;
  qrItems.Open;
  if tbCust.Active then
    btCloseOpen.Caption := 'Close';
end;

procedure TfrmMasterDetail.btCloseOpenClick(Sender: TObject);
begin
  if tbCust.Active then
  begin
    tbCust.Close;
    btCloseOpen.Caption := 'Open';
  end
  else
  begin
    tbCust.Open;
    btCloseOpen.Caption := 'Close';
  end;
end;

procedure TfrmMasterDetail.btSetRangeClick(Sender: TObject);
begin
  if ( tbOrders.IndexFieldNames = 'ORDERNO' ) then
    tbOrders.SetRange( [1050], [1200] )
  else
  if ( tbOrders.IndexFieldNames = 'SALEDATE' ) then
    tbOrders.SetRange( ['1/1/1994'], ['1/1/1995'] )
end;

procedure TfrmMasterDetail.grCustTitleClick(Column: TColumn);
var
  tmpStr: string;
  dscPos: integer;
begin
  tmpStr := tbCust.IndexFieldNames;
  dscPos := Pos( ' DESC', tmpStr );
  if dscPos > 0 then
    System.Delete( tmpStr, dscPos, 5 );
  if tbCust.IndexFieldNames <> Column.DisplayName then
    tbCust.IndexFieldNames := Column.DisplayName
  else
    tbCust.IndexFieldNames := Column.DisplayName + ' DESC';
end;

procedure TfrmMasterDetail.grOrdersTitleClick(Column: TColumn);
var
  tmpStr: string;
  dscPos: integer;
begin
  if ( tbOrders.IndexFieldNames <> Column.DisplayName ) and
     ( tbOrders.IndexFieldNames <> Column.DisplayName + ' DESC' ) then
    tbOrders.CancelRange;

  tmpStr := tbOrders.IndexFieldNames;
  dscPos := Pos( ' DESC', tmpStr );
  if dscPos > 0 then
    System.Delete( tmpStr, dscPos, 5 );
  if tbOrders.IndexFieldNames <> Column.DisplayName then
    tbOrders.IndexFieldNames := Column.DisplayName
  else
    tbOrders.IndexFieldNames := Column.DisplayName + ' DESC';
end;

procedure TfrmMasterDetail.btCancelRangeClick(Sender: TObject);
begin
  tbOrders.CancelRange;
end;

procedure TfrmMasterDetail.SpeedButton1Click(Sender: TObject);
begin
  qrItems.ExecuteImmediate( 'DELETE FROM ITEMS ' +
                            'WHERE ITEMNO = 2 AND ORDERNO = ' +
                            tbOrders.FieldByName( 'OrderNo' ).AsString, nil );
  qrItems.Refresh;
end;

procedure TfrmMasterDetail.SpeedButton2Click(Sender: TObject);
begin
  qrItems.ExecuteImmediate( 'INSERT INTO ITEMS ( ITEMNO, ORDERNO ) ' +
                            'VALUES ( 2, ' +
                            tbOrders.FieldByName( 'OrderNo' ).AsString + ' )',
                            nil );
  qrItems.Refresh;
end;

procedure TfrmMasterDetail.Button3Click(Sender: TObject);
var
  abk: string;
begin
  grorders.Datasource := nil;
  tbCust.First;
  tbOrders.MoveBy(1);
  abk := tbOrders.Bookmark;
  tbCust.First;
  tbOrders.Bookmark := abk;
end;

procedure TfrmMasterDetail.NewEvent(Sender: TObject);
begin
  tbCust.IndexName := 'COMPANY';
end;

procedure TfrmMasterDetail.Button4Click(Sender: TObject);
begin
  tbCust.IndexName := '';
  tbCust.IndexFieldNames := '';
  tbCust.IndexFieldNames := 'CUSTNO';
end;

procedure TfrmMasterDetail.tbOrdersAfterPrepare(Sender: TObject);
begin
  if ( tbOrders.IndexFieldNames = 'ORDERNO' ) or
     ( tbOrders.IndexFieldNames = 'SALEDATE' ) or
     ( tbOrders.IndexFieldNames = 'ORDERNO DESC' ) or
     ( tbOrders.IndexFieldNames = 'SALEDATE DESC' ) then
  begin
    btSetRange.Enabled := true;
    btCancelRange.Enabled := true;
  end
  else
  begin
    btSetRange.Enabled := false;
    btCancelRange.Enabled := false;
  end;
end;

end.

