unit
  FRM_Employee;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, ComCtrls, StdCtrls, Mask, Buttons,

  IB_UpdateBar,
  IB_NavigationBar,
  IB_DataSetBar,
  IB_SearchBar,
  IB_Components,
  IB_Grid,
  IB_TransactionBar,
  IB_Controls;

type
  TfrmEmployee = class(TForm)
    HeaderPanel: TPanel;
    IB_SearchBar1: TIB_SearchBar;
    IB_DataSetBar1: TIB_DataSetBar;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    trEmp: TIB_Transaction;
    qrEmp: TIB_Query;
    dsEmp: TIB_DataSource;
    qrBranch: TIB_Query;
    qrDept: TIB_Query;
    dsBranch: TIB_DataSource;
    dsDept: TIB_DataSource;
    BrowseGrid: TIB_Grid;
    lcDEPTDESCRIPTION: TIB_LookupCombo;
    lcBRANCHDESCRIPTION: TIB_LookupCombo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dsEmpDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
  private
  public
  end;

var
  frmEmployee: TfrmEmployee;

implementation

uses
  FRM_Company;

{$R *.DFM}

procedure TfrmEmployee.FormCreate(Sender: TObject);
begin
  qrEmp.Open;
  qrBranch.Open;
  qrDept.Open;
  {$IFDEF VER100}
  // Embedding controls in the grid is not supported in  Delphi 3.
  // Borland didn't implement interfaces correctly until Delphi 4.
  lcBRANCHDESCRIPTION.Parent := nil;
  lcBRANCHDESCRIPTION.Visible := false;
  lcDEPTDESCRIPTION.Parent := nil;
  lcDEPTDESCRIPTION.Visible := false;
  {$ENDIF}
  Show;
end;

procedure TfrmEmployee.FormShow(Sender: TObject);
begin
  BrowseGrid.SetFocus;
end;

procedure TfrmEmployee.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := trEmp.CloseWithConfirm = mrOk;
end;

procedure TfrmEmployee.dsEmpDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
var
  ii: integer;
begin
// Here is an example of how you can determine which fields actually changed.
  if not Assigned( Field ) and
     not Statement.Fields.UpdatedWholeRow and
    ( Statement.Fields.UpdatedColumnCount > 0 ) then
  begin
    for ii := 0 to Statement.Fields.UpdatedColumnCount - 1 do
    begin
//  ShowMessage( TIB_Column( Statement.Fields.UpdatedColumns[ii] ).FieldName );
    end;
  end;
end;

end.

