unit
  Frmqrysp;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, Grids, ExtCtrls, Dialogs, Buttons, Mask, ComCtrls,

  IB_UpdateBar,
  IB_NavigationBar,
  IB_Components,
  IB_Grid,
  IB_CursorGrid;

type
  TFrmQueryProc = class(TForm)
    DBGrid1: TIB_Grid;
    DBGrid2: TIB_CursorGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    EmployeeProjectsQuery: TIB_Cursor;
    EmployeeProjectsSource: TIB_DataSource;
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    EmployeeSource: TIB_DataSource;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure EmployeeProjectsQueryAfterFetchEOF(IB_DataSet: TIB_DataSet);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmQueryProc: TFrmQueryProc;

implementation

uses
  DmCSDemo;

{$R *.DFM}

procedure TFrmQueryProc.FormShow(Sender: TObject);
begin
  EmployeeProjectsQuery.Prepare;
  DmEmployee.ibEmployeeTable.Open;
  EmployeeSource.DataSet := DmEmployee.ibEmployeeTable;
  EmployeeProjectsQuery.Open;
end;

procedure TFrmQueryProc.FormHide(Sender: TObject);
begin
  EmployeeSource.DataSet := nil;
end;

procedure TFrmQueryProc.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := DmEmployee.cnEmployee.CloseWithConfirm = mrOk;
end;

procedure TFrmQueryProc.EmployeeProjectsQueryAfterFetchEOF(
  IB_DataSet: TIB_DataSet);
begin
  with DmEmployee, ibEmployeeTable do begin
    StatusBar1.SimpleText :=  'Employee ' +
                              FieldByName( 'Emp_No' ).AsString +
                              ' is assigned to ' +
                              IntToStr( EmployeeProjectsQuery.RowNum ) +
                              ' project(s).';
  end;
end;

end.
