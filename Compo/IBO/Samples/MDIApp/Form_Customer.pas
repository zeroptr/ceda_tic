unit Form_Customer;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, Mask, ExtCtrls, Grids, ComCtrls,

  IB_Components,
  IB_Controls,
  IB_Grid,
  IB_ParamEdit,
  IB_SearchEdit,
  IB_IncSearch;

type
  TfrmCustomer = class(TForm)
    qrCust: TIB_Query;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    IB_CursorGrid1: TIB_Grid;
    ScrollBox: TScrollBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    EditCUSTNO: TIB_Edit;
    EditCOMPANY: TIB_Edit;
    EditADDR: TIB_Edit;
    EditADDR2: TIB_Edit;
    EditCITY: TIB_Edit;
    EditSTATE: TIB_Edit;
    EditZIP: TIB_Edit;
    EditCOUNTRY: TIB_Edit;
    EditPHONE: TIB_Edit;
    EditFAX: TIB_Edit;
    EditTAXRATE: TIB_Edit;
    EditCONTACT: TIB_Edit;
    EditLASTINVOICEDATE: TIB_Edit;
    dsCust: TIB_DataSource;
    Panel1: TPanel;
    IB_SearchEdit1: TIB_SearchEdit;
    IB_IncSearch1: TIB_IncSearch;
    IB_LookupCombo2: TIB_LookupCombo;
    IB_IncSearch: TIB_IncSearch;
    lbLookupCombo: TLabel;
    lbIncSearch: TLabel;
    lbSearchEdit: TLabel;
    procedure dsCustGainFocus(Sender: TIB_DataSource;
      AIB_DataSet: TIB_DataSet);
    procedure qrCustOrderingChange(IB_DataSet: TIB_DataSet);
    procedure qrCustAfterUnprepare(Sender: TIB_Statement);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCustomer: TfrmCustomer;

implementation

{$R *.DFM}

procedure TfrmCustomer.dsCustGainFocus(Sender: TIB_DataSource;
  AIB_DataSet: TIB_DataSet);
begin
  AIB_DataSet.Active := true;
end;

procedure TfrmCustomer.qrCustOrderingChange(IB_DataSet: TIB_DataSet);
begin
  lbLookupCombo.Caption := 'LookupCombo for ' + qrCust.OrderingLink;
end;

procedure TfrmCustomer.qrCustAfterUnprepare(Sender: TIB_Statement);
begin
  lbLookupCombo.Caption := 'LookupCombo';
end;

end.

