
{                                                                              }
{ FRM_KeyLinks                                                                 }
{                                                                              }

unit
  FRM_KeyLinks;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls, Mask, Registry,

  IB_Header,
  IB_Session,
  IB_Constants,
  IB_Components,
  IB_Grid,
  IB_NavigationBar,
  IB_Controls,
  IB_UpdateBar,
  IB_DataSetBar;

type
  TfrmKeyLinks = class(TForm)
    cnKeyLinks: TIB_Connection;
    qrCustomer: TIB_Query;
    dsOrders: TIB_DataSource;
    dsCustomer: TIB_DataSource;
    Panel1: TPanel;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    grLookup: TIB_Grid;
    qrOrders: TIB_Query;
    Panel3: TPanel;
    odGDB: TOpenDialog;
    IB_DataSetBar1: TIB_DataSetBar;
    grParent: TIB_Grid;
    trKeyLinks: TIB_Transaction;
    procedure cnKeyLinksConnect(Sender: TIB_Connection);
    procedure qrOrdersActiveChange(Sender: TIB_Statement);
    procedure FormCreate(Sender: TObject);
    procedure qrOrdersAfterClose(IB_Dataset: TIB_Dataset);
    procedure grLookupGetCellProps(Sender: TObject; ACol, ARow: Integer;
      AState: TGridDrawState; var AColor: TColor; AFont: TFont);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmKeyLinks: TfrmKeyLinks;

implementation

{$R *.DFM}

procedure TfrmKeyLinks.FormCreate(Sender: TObject);
begin
  qrOrders.Open;
end;

procedure TfrmKeyLinks.cnKeyLinksConnect(Sender: TIB_Connection);
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

procedure TfrmKeyLinks.qrOrdersActiveChange(Sender: TIB_Statement);
begin
  qrCustomer.Active := qrOrders.Active;
end;

procedure TfrmKeyLinks.grLookupGetCellProps(Sender: TObject; ACol,
  ARow: Integer; AState: TGridDrawState; var AColor: TColor; AFont: TFont);
var
  tmpFld: TIB_Column;
begin
// This provides an example of how colors can be customized on an
// individual cell basis.
  with Sender as TIB_Grid do
    if ( Assigned( DataSource )) and
       ( DataSource.Prepared ) and
       ( DataSource.Dataset.RowNum = DataRow[ ARow ] ) and
       not ( gdFixed in AState ) then
    begin
      tmpFld := GridFields[ DataCol[ ACol ]];
      if Assigned( tmpFld ) and ( tmpFld.FieldName = 'CUSTNO' ) then
      begin
        AColor := clRed;
        if Assigned( AFont ) then
          AFont.Color := clBlack;
      end;
    end;
end;

procedure TfrmKeyLinks.qrOrdersAfterClose(IB_Dataset: TIB_Dataset);
begin
  if trKeyLinks.Started and not trKeyLinks.InTransaction then
    trKeyLinks.Commit;
end;

end.

