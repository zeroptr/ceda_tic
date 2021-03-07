unit
  Frmexesp;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, Buttons, Mask, Grids, ExtCtrls,

  IB_UpdateBar,
  IB_NavigationBar,
  IB_Components,
  IB_Controls,
  IB_Grid;

type
  TFrmExecProc = class(TForm)
    DBGrid1: TIB_Grid;
    ScrollBox: TScrollBox;
    Label1: TLabel;
    EditCUST_NO: TIB_Edit;
    Label2: TLabel;
    EditCUSTOMER: TIB_Edit;
    Label3: TLabel;
    EditCONTACT_FIRST: TIB_Edit;
    EditCONTACT_LAST: TIB_Edit;
    EditPHONE_NO: TIB_Edit;
    Label6: TLabel;
    EditADDRESS_LINE: TIB_Edit;
    EditADDRESS_LINE2: TIB_Edit;
    EditCITY: TIB_Edit;
    EditSTATE_PROVINCE: TIB_Edit;
    EditCOUNTRY: TIB_Edit;
    EditPOSTAL_CODE: TIB_Edit;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Label4: TLabel;
    BtnShipOrder: TSpeedButton;
    BitBtn1: TBitBtn;
    SalesSource: TIB_DataSource;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    DBCheckBox1: TIB_CheckBox;
    procedure BtnShipOrderClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure SalesSourceDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmExecProc: TFrmExecProc;

implementation

uses
  DmCSDemo;

{$R *.DFM}

procedure TFrmExecProc.FormShow(Sender: TObject);
begin
  with DmEmployee do
  begin
    spShipOrderProc.Prepared := true;
    ibCustomerTable.Open;
    ibSalesTable.Open;
    SalesSource.DataSet := ibSalesTable;
  end;
end;

procedure TFrmExecProc.FormHide(Sender: TObject);
begin
  SalesSource.DataSet := nil;
end;

procedure TFrmExecProc.SalesSourceDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  with DmEmployee do
  begin
    BtnShipOrder.Enabled := ibSalesTable.Active and
      ( CompareText( ibSalesTable.FieldByName('ORDER_STATUS').AsString,
                     'SHIPPED') <> 0 );
  end;
end;

procedure TFrmExecProc.BtnShipOrderClick(Sender: TObject);
begin
  with DmEmployee do begin
    spShipOrderProc.Params[0].Assign( ibSalesTable.FieldByName('PO_NUMBER'));
    spShipOrderProc.ExecProc;
  // Only the single row affected by the stored procedure is refreshed instead
  // of the entire dataset.
    ibSalesTable.InvalidateRowNum( ibSalesTable.RowNum );
  end;
end;

procedure TFrmExecProc.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := DmEmployee.cnEmployee.CloseWithConfirm = mrOk;
end;

end.


