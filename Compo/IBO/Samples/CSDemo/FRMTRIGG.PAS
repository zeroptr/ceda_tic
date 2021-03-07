unit
  Frmtrigg;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, Buttons, Grids, ExtCtrls,

  IB_NavigationBar,
  IB_UpdateBar,
  IB_Grid;

type
  TFrmTriggerDemo = class(TForm)
    DBGrid1: TIB_Grid;
    DBGrid2: TIB_Grid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmTriggerDemo: TFrmTriggerDemo;

implementation

uses
  DmCSDemo;

{$R *.DFM}

procedure TFrmTriggerDemo.FormShow(Sender: TObject);
begin
// Open the tables.
  DmEmployee.ibEmployeeTable.Open;
  DmEmployee.ibSalaryHistoryTable.Open;
end;

procedure TFrmTriggerDemo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
// Resolve the transaction if any changes were made.
  CanClose := DmEmployee.cnEmployee.CloseWithConfirm = mrOk;
end;

end.


