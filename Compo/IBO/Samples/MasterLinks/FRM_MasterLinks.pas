
{                                                                              }
{ FRM_MasterLinks                                                              }
{                                                                              }

unit
  FRM_MasterLinks;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Buttons, StdCtrls, ExtCtrls, Registry,

  IB_Session,
  IB_Constants,
  IB_Components,
  IB_Grid,
  IB_UpdateBar,
  IB_DataSetBar,
  IB_UtilityBar;

type
  TfrmMasterLinks = class(TForm)
    cnMasterLink: TIB_Connection;
    trMasterLink: TIB_Transaction;
    qrCust: TIB_Query;
    dsCust: TIB_DataSource;
    pnCust: TPanel;
    grCust: TIB_Grid;
    dbCust: TIB_DataSetBar;
    nbCust: TIB_UpdateBar;
    qrOrders: TIB_Query;
    dsOrders: TIB_DataSource;
    pnOrders: TPanel;
    grItems: TIB_Grid;
    nbOrders: TIB_UpdateBar;
    odGDB: TOpenDialog;
    Panel1: TPanel;
    IB_UpdateBar1: TIB_UpdateBar;
    grOrders: TIB_Grid;
    dsItems: TIB_DataSource;
    qrItems: TIB_Query;
    IB_UtilityBar1: TIB_UtilityBar;
    procedure qrCustActiveChange(Sender: TIB_Statement);
    procedure FormCreate(Sender: TObject);
    procedure cnMasterLinkConnect(Sender: TIB_Connection);
    procedure qrCustAfterClose(IB_Dataset: TIB_Dataset);
    procedure grCustGetCellProps(Sender: TObject; ACol, ARow: Integer;
      AState: TGridDrawState; var AColor: TColor; AFont: TFont);
    procedure grOrdersGetCellProps(Sender: TObject; ACol, ARow: Integer;
      AState: TGridDrawState; var AColor: TColor; AFont: TFont);
    procedure grItemsGetCellProps(Sender: TObject; ACol, ARow: Integer;
      AState: TGridDrawState; var AColor: TColor; AFont: TFont);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMasterLinks: TfrmMasterLinks;

implementation

{$R *.DFM}

procedure TfrmMasterLinks.FormCreate(Sender: TObject);
begin
  qrCust.Active := true;
end;

procedure TfrmMasterLinks.qrCustActiveChange(Sender: TIB_Statement);
begin
  qrOrders.Active := qrCust.Active;
  qrItems.Active := qrCust.Active;
end;

procedure TfrmMasterLinks.cnMasterLinkConnect(
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

procedure TfrmMasterLinks.qrCustAfterClose(IB_Dataset: TIB_Dataset);
begin
// This is necessary in order to cycle transactions so if a user is working all
// day with this application a transaction won't be held all day long.
  if trMasterLink.Started and not trMasterLink.InTransaction then
    trMasterLink.Commit;
end;

procedure TfrmMasterLinks.grCustGetCellProps(Sender: TObject; ACol,
  ARow: Integer; AState: TGridDrawState; var AColor: TColor; AFont: TFont);
var
  tmpFld: TIB_Column;
begin
// This provides an example of how colors can be customized on an
// individual cell basis.
  with grCust do
  begin
    if ARow >= FixedRows then
    if Assigned( DataSource ) and
       Assigned( DataSource.Dataset ) and
       ( DataSource.Dataset.RowNum = DataRow[ ARow ] ) then
    begin
      tmpFld := GridFields[ DataCol[ ACol ]];
      if Assigned( tmpFld ) and ( tmpFld.FieldName = 'CUSTNO' ) then
      begin
        if ( DataSource.Dataset.BufferRowCount > 0 ) then
        begin
          AColor := clRed;
          if Assigned( AFont ) then
            AFont.Color := clBlack;
        end;
      end
    end;
  end;
end;

procedure TfrmMasterLinks.grOrdersGetCellProps(Sender: TObject; ACol,
  ARow: Integer; AState: TGridDrawState; var AColor: TColor; AFont: TFont);
var
  tmpFld: TIB_Column;
begin
// This provides an example of how colors can be customized on an
// individual cell basis.
  with grOrders do
  begin
    if ARow >= FixedRows then
    begin
      tmpFld := qrOrders.Fields[ DataCol[ ACol ]];
      if Assigned( tmpFld ) then
      begin
        if ( tmpFld.FieldName = 'CUSTNO' ) then
        begin
          if ( DataSource.Dataset.BufferRowCount > 0 ) then
          begin
            AColor := clRed;
            if Assigned( AFont ) then
              AFont.Color := clBlack;
          end;
        end
        else
        if ( tmpFld.FieldName = 'ORDERNO' ) then
        begin
          if Assigned( DataSource ) and
             Assigned( DataSource.Dataset ) and
             ( DataSource.Dataset.BufferRowCount > 0 ) and
             ( DataSource.Dataset.RowNum = DataRow[ ARow ] ) then
          begin
            AColor := clLime;
            if Assigned( AFont ) then
              AFont.Color := clBlack;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmMasterLinks.grItemsGetCellProps(Sender: TObject; ACol,
  ARow: Integer; AState: TGridDrawState; var AColor: TColor; AFont: TFont);
var
  tmpFld: TIB_Column;
begin
// This provides an example of how colors can be customized on an
// individual cell basis.
  with grItems do
  begin
    if ARow >= FixedRows then
    begin
      tmpFld := qrItems.Fields[ DataCol[ ACol ]];
      if Assigned( tmpFld ) then
      begin
        if ( tmpFld.FieldName = 'ORDERNO' ) then
        begin
          if ( DataSource.Dataset.BufferRowCount > 0 ) then
          begin
            AColor := clLime;
            if Assigned( AFont ) then
              AFont.Color := clBlack;
          end;
        end;
      end;
    end;
  end;
end;

end.


