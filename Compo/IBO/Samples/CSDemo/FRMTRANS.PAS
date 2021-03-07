unit
  Frmtrans;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  StdCtrls, Forms, Buttons, Grids, ExtCtrls, Dialogs,

  IB_UpdateBar,
  IB_NavigationBar,
  IB_Grid,
  IB_Components,
  IB_TransactionSource;

type
  TFrmTransDemo = class(TForm)
    DBGrid1: TIB_Grid;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BtnUndoEdits: TSpeedButton;
    BtnCommitEdits: TSpeedButton;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    tsBrowser: TIB_TransactionSource;
    procedure BtnCommitEditsClick(Sender: TObject);
    procedure BtnUndoEditsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tsBrowserStatusChanged(Sender: TIB_TransactionLink;
      ATransaction: TIB_Transaction);
    procedure FormHide(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmTransDemo: TFrmTransDemo;

implementation

uses
  DmCSDemo;

{$R *.DFM}

procedure TFrmTransDemo.FormShow(Sender: TObject);
begin
  with DmEmployee do begin
    tsBrowser.IB_Transaction := cnEmployee.IB_Transaction;
    ibEmployeeTable.Active := true;
  end;
end;

procedure TFrmTransDemo.FormHide(Sender: TObject);
begin
  tsBrowser.IB_Transaction := nil;
end;

procedure TFrmTransDemo.BtnCommitEditsClick(Sender: TObject);
begin
  with DmEmployee do begin
    if cnEmployee.TransactionIsActive and
       (MessageDlg('Are you sure you want to commit your changes?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      cnEmployee.Commit;
    end;
  end;
end;

procedure TFrmTransDemo.BtnUndoEditsClick(Sender: TObject);
begin
  with DmEmployee do begin
    if cnEmployee.TransactionIsActive and
      (MessageDlg('Are you sure you want to undo all changes made during the ' +
         'current transaction?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    begin
      cnEmployee.Rollback;
    end;
  end;
end;

procedure TFrmTransDemo.tsBrowserStatusChanged(Sender: TIB_TransactionLink;
  ATransaction: TIB_Transaction);
begin
  BtnUndoEdits.Enabled := Assigned( ATransaction ) and
                          ATransaction.TransactionIsActive;
  BtnCommitEdits.Enabled := BtnUndoEdits.Enabled;
end;

procedure TFrmTransDemo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
// Resolve the transaction if any changes are made.
  CanClose := DmEmployee.cnEmployee.CloseWithConfirm = mrOk;
end;

end.

