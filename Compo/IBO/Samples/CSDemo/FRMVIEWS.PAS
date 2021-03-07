unit
  Frmviews;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, Buttons, Grids, ExtCtrls, Dialogs,

  IB_Components,
  IB_Grid,
  IB_NavigationBar,
  IB_UpdateBar;

type
  TFrmViewDemo = class(TForm)
    DBGrid1: TIB_Grid;
    DBNavigator: TIB_NavigationBar;
    Panel1: TPanel;
    dsTable: TIB_DataSource;
    Panel2: TPanel;
    EmpTable: TIB_Query;
    BitBtn1: TBitBtn;
    BtnShowEmployee: TSpeedButton;
    BtnShowPhoneList: TSpeedButton;
    PhoneTable: TIB_Query;
    IB_UpdateBar1: TIB_UpdateBar;
    procedure BtnShowEmployeeClick(Sender: TObject);
    procedure BtnShowPhoneListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EmpTableAfterPost(IB_DataSet: TIB_DataSet);
    procedure EmpTableOrderingChange(IB_DataSet: TIB_DataSet);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmViewDemo: TFrmViewDemo;

implementation

uses
  DmCSDemo;

{$R *.DFM}

procedure TFrmViewDemo.FormShow(Sender: TObject);
begin
// Open the tables.
  EmpTable.Open;
  PhoneTable.Open;
end;

procedure TFrmViewDemo.BtnShowEmployeeClick(Sender: TObject);
begin
// Keep pointing to the same employee record.
  EmpTable.Bookmark := PhoneTable.Bookmark;
// Display the employee table.
  dsTable.DataSet := EmpTable;
end;

procedure TFrmViewDemo.BtnShowPhoneListClick(Sender: TObject);
begin
// Make sure that any changes made get posted.
  EmpTable.CheckBrowseMode;
// Keep pointing to the same employee record.
  PhoneTable.Bookmark := EmpTable.Bookmark;
// Display the employee phone list view.
  dsTable.DataSet := PhoneTable;
end;

procedure TFrmViewDemo.EmpTableAfterPost(IB_DataSet: TIB_DataSet);
begin
// Make sure when changes are made that the phone view is efficiently updated.
// It will refresh only the row that was changed instead of the entire dataset.
  if EmpTable.State = dssEdit then begin
    PhoneTable.InvalidateBookmark( EmpTable.Bookmark );
  end;
end;

procedure TFrmViewDemo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
// Resolve that transaction if any changes were made.
  CanClose := DmEmployee.cnEmployee.CloseWithConfirm = mrOk;
end;

procedure TFrmViewDemo.EmpTableOrderingChange(IB_DataSet: TIB_DataSet);
begin
// If either table is reordered make the other table match the new ordering.
  if IB_DataSet = EmpTable then begin
    PhoneTable.OrderingItemNo := EmpTable.OrderingItemNo;
  end else begin
    EmpTable.OrderingItemNo := PhoneTable.OrderingItemNo;
  end;
// Something similar can be doe to keep field widths and ordering the same too.
// For this you would use the OnLayoutChange method. Be sure not to invoke an
// infinite loop doing it with OnLayoutChange though.
end;

end.


