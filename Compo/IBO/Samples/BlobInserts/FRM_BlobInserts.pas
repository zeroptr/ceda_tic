unit
  FRM_BlobInserts;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Grids, Buttons,

  IB_Session,
  IB_Components,
  IB_Script,
  IB_Process;

type
  TfrmBlobInserts = class(TForm)
    Label1: TLabel;
    lbl_Counter: TLabel;
    Label2: TLabel;
    lbRecPerSec: TLabel;
    btn_TestIt: TBitBtn;
    btn_Cancel: TBitBtn;
    cn: TIB_Connection;
    dsql: TIB_DSQL;
    tr: TIB_Transaction;
    Script: TIB_Script;
    Memo1: TMemo;
    cr: TIB_Cursor;
    procedure btn_TestItClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cnBeforeConnect(Sender: TIB_Connection);
  private
    fProcessRunning: boolean;
    fCancelled: boolean;
  public
  end;

var
  frmBlobInserts: TfrmBlobInserts;

implementation

{$R *.DFM}

procedure TfrmBlobInserts.btn_TestItClick(Sender: TObject);
var
  bModulo: byte;
  StringBLOB: TIB_Column; // Store static reference for performance.
  iRecCounter: DWORD;
  Ticks: DWORD;
  Seconds: DWORD;
begin
  fProcessRunning := true;
  fCancelled := false;
  btn_Cancel.SetFocus;
  btn_Cancel.Caption := 'Cancel';
  btn_TestIt.Enabled := false;
  TICKS := GetTickCount;
  Seconds := 0;
  iRecCounter := 0;

  with dsql do
  begin

    // Make the cursor on the screen not twiddle for each insert.
    // The true parameter means that the process to fllow contains a call
    // to Application.ProcessMessages() and that it should be considered a
    // yielding process.
    BeginBusy( true );

    try

      // Open up the "PIPE" to pour in the data.
      Prepare;

      // Constant parameter values defined only once.
      ParamByName('STRING_FIELD').AsString := 'Some Stuff';

      // Use a direct pointer instead of ParamByName for every insert.
      StringBLOB := DSQL.ParamByName('BLOB_FIELD');

      // Loop until the user clicks cancel or 25000 inserts are done.
      while not fCancelled and ( iRecCounter < 25000 ) do
      begin

      // Alternate between a BLOB and a NULL for some variety.
        bModulo := iRecCounter mod 2;
        case bModulo of
          0: StringBLOB.AsString := 'Blob Stuff: ' + IntToStr( iRecCounter );
          1: StringBLOB.Clear;
        end;

      // Perform the INSERT.
        DSQL.ExecSQL;
        inc (iRecCounter);

      // Uddate the caption every second.
        if GetTickCount > Ticks + 1000 then
        begin
          Ticks := Ticks + 1000;
          Inc( Seconds );
          lbl_Counter.Caption := IntToStr( iRecCounter );
          lbRecPerSec.Caption := IntToStr( iRecCounter div Seconds );
        end;

      // Provide response to mouse clicks.
        Application.ProcessMessages;

      end;

      // Commit if no exception was raised.
      IB_Transaction.Commit;

      // Put the final whole count of records on the screen.
      lbl_Counter.Caption := IntToStr( iRecCounter );
    finally

    // Complete the process and return the screen cursor to normal.
      EndBusy;
      fProcessRunning := false;
      btn_TestIt.Enabled := true;
      btn_Cancel.Caption := 'Close';
    end;
  end
end;

procedure TfrmBlobInserts.btn_CancelClick(Sender: TObject);
begin
  // Allow the process to be cancelled if it is running.
  if fProcessRunning then
    fcancelled := true
  else
    Close;
end;

procedure TfrmBlobInserts.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Don't allow the form to be closed if the process is running.
  if FProcessRunning then
  begin
    CanClose := false;
    MessageBeep( 0 );
  end;
end;

procedure TfrmBlobInserts.cnBeforeConnect(
  Sender: TIB_Connection);
begin
  // Make sure that the database file exists.
  with cn do
    if ( Protocol = cpLocal ) and not FileExists( Database ) then
      Script.Execute;
end;

end.


