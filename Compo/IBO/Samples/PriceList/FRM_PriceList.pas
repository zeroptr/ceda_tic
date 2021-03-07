unit
  FRM_PriceList;

{-------------------------------------------------------------------------------

This sample has been provided compliments of:

Mr. Phil Cain
Orelle Corporation
Box 643
LaGrande, IL 60525
USA

Email: philcain@orelle.com
Tel: 708/ 352-3020

Minor revisions and alterations have been made by myself to make it a more
generic example for general understanding.

-------------------------------------------------------------------------------}

(*

The object of this form is to run the following SQL:

SELECT
   Products.NAME,
   Products.UofM,
   Prices.PRICE,
   Products.DESCRIPTION,
   Prices.PriceCat,
   Prices.ProductID,
   Products.id
FROM PRICES right outer join PRODUCTS
  on Prices.PRODUCTID=Products.ID and Prices.PriceCat=:NAME

In this case :Name is the value supplied by the lookup combo
and is a valid price category name which can be derived by

  Select Name from Pricecat
  - or -
  Select distinct PriceCat from Prices

The action of the form should be that the user selects a
price category in the lookup and the grid responds by displaying
the proper price list.

 *)
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Mask, ExtCtrls,

  IB_Session,
  IB_Components,
  IB_Parse,
  IB_Grid,
  IB_UpdateBar,
  IB_Process,
  IB_Script,
  IB_UtilityBar;

type
  TfrmPriceList = class(TForm)
    cnPriceList: TIB_Connection;
    dsPriceCat: TIB_DataSource;
    qrPriceCat: TIB_Query;
    grPriceList: TIB_Grid;
    qrPriceList: TIB_Query;
    dsPriceList: TIB_DataSource;
    pnPriceCategory: TPanel;
    lcPriceCategory: TIB_LookupCombo;
    btSQLMonitor: TIB_UtilityBar;
    lbPriceCategory: TLabel;
    scPriceList: TIB_Script;
    trPriceList: TIB_Transaction;
    IB_UpdateBar1: TIB_UpdateBar;
    procedure FormCreate(Sender: TObject);
    procedure cnPriceListBeforeConnect(Sender: TIB_Connection);
  private
    { Private declarations }
    procedure HandleException( Sender: TObject; E: Exception );
  public
    { Public declarations }
  end;

var
  frmPriceList: TfrmPriceList;

implementation

{$R *.DFM}

procedure TfrmPriceList.FormCreate(Sender: TObject);
begin
  Application.OnException := HandleException;
  SetBounds( Left, Top, 543, 395 );
  qrPriceCat.Open;
  qrPriceList.Open;
end;

procedure TfrmPriceList.HandleException( Sender: TObject; E: Exception );
begin
  if E is EIB_ISCError then
    EIB_ISCError(E).ShowDialog
  else
    Application.ShowException( E );
end;

procedure TfrmPriceList.cnPriceListBeforeConnect(Sender: TIB_Connection);
begin
  with cnPriceList do
    if ( Protocol = cpLocal ) and not FileExists( DatabaseName ) then
      scPriceList.Execute;
end;

end.


