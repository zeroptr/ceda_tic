unit
  DmCSDemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry,

  IB_Session,
  ib_cONSTANTS,
  IB_Components,
  IB_StoredProc;

type
  TDmEmployee = class(TDataModule)
    ibSalesTable: TIB_Query;
    ibSalesSource: TIB_DataSource;
    ibCustomerTable: TIB_Query;
    ibCustomerSource: TIB_DataSource;
    ibEmployeeTable: TIB_Query;
    ibEmployeeSource: TIB_DataSource;
    ibSalaryHistoryTable: TIB_Query;
    ibSalaryHistorySource: TIB_DataSource;
    cnEmployee: TIB_Database;
    odGDB: TOpenDialog;
    spShipOrderProc: TIB_StoredProc;
    spDeleteEmployee: TIB_StoredProc;
    procedure ibEmployeeTableAfterPost(IB_DataSet: TIB_DataSet);
    procedure cnOnConnect(Sender: TIB_Connection);
    procedure ibEmployeeTableCustomDelete(IB_DataSet: TIB_DataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmEmployee: TDmEmployee;

implementation

{$R *.DFM}

{ Note: Business rules go in the data model. Here is an example, used by
  the transaction editing demo.  Deletes for the employee table are done
  with a stored procedure rather than the normal record delete mechanism,
  so an audit trail could be provided, etc... }

{ The database, EmployeeDatabase, is the InterBase example EMPLOYEE.GDB database
  accessed thru the BDE alias IBLOCAL.  This database contains examples
  of stored procedures, triggers, check constraints, views, etc., many of
  which are used within this demo project. }

procedure TDmEmployee.ibEmployeeTableCustomDelete(IB_DataSet: TIB_DataSet);
begin
// Assign the current employee's id to the stored procedure's parameter.
  with spDeleteEmployee do begin
    Prepared := true;
    ParamByName( 'EMP_NUM' ).Assign( ibEmployeeTable.FieldByName( 'EMP_NO' ));
    ExecProc;
  end;
end;

procedure TDmEmployee.ibEmployeeTableAfterPost(IB_DataSet: TIB_DataSet);
begin
// A change in an employee salary triggers a change in the salary history,
// so if that table is open, it needs to be refreshed now.
  with ibSalaryHistoryTable do begin
    if Active then begin
      Refresh;
    end;
  end;
end;

procedure TDmEmployee.cnOnConnect(Sender: TIB_Connection);
var
  MyReg: TRegINIFile;
begin
  MyReg := TRegIniFile.Create( IB_BASEKEY + '\Samples\Connections' );
  with Sender, odGDB do
  try
    if ConnectionStatus = csConnectPending then
    begin
      Database := MyReg.ReadString( 'Connections', 'Employee', Database );
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
      MyReg.WriteString( 'Connections', 'Employee', Database );
  finally
    MyReg.Free;
  end;
end;

end.

