unit Form_Order;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, Mask, ExtCtrls, Grids, ComCtrls,

  IB_Components,
  IB_Controls,
  IB_Grid,
  IB_ParamEdit,
  IB_SearchEdit;

type
  TfrmOrder = class(TForm)
    qrOrders: TIB_Query;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    IB_CursorGrid1: TIB_Grid;
    ScrollBox: TScrollBox;
    Label1: TLabel;
    EditORDERNO: TIB_Edit;
    dsOrders: TIB_DataSource;
    Label2: TLabel;
    edCUSTNO: TIB_Edit;
    IB_LookupList1: TIB_Grid;
    qrCust: TIB_Query;
    dsCust: TIB_DataSource;
    procedure dsOrdersGainFocus(Sender: TIB_DataSource;
      AIB_DataSet: TIB_DataSet);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmOrder: TfrmOrder;

implementation

{$R *.DFM}

procedure TfrmOrder.dsOrdersGainFocus(Sender: TIB_DataSource;
  AIB_DataSet: TIB_DataSet);
begin
  qrOrders.Active := true;
  qrCust.Active := true;
end;

end.

