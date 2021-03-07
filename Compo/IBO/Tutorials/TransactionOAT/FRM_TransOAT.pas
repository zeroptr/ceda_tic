unit
  FRM_TransOAT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, IB_UpdateBar, IB_DatasetBar, IB_TransactionBar, ExtCtrls,
  IB_ConnectionBar, Grids, IB_Grid, IB_NavigationBar,

  IBF_Status,

  StdCtrls,
  IB_Session, IB_SessionProps, IB_CursorGrid, IB_Process, IB_Script;

type
  TfrmOAT = class(TForm)
    tr: TIB_Transaction;
    cn: TIB_Connection;
    IB_ConnectionBar1: TIB_ConnectionBar;
    IB_TransactionBar1: TIB_TransactionBar;
    IB_DatasetBar1: TIB_DatasetBar;
    IB_UpdateBar1: TIB_UpdateBar;
    IB_NavigationBar1: TIB_NavigationBar;
    Button1: TButton;
    Timer: TTimer;
    sp: TIB_SessionProps;
    GroupBox1: TGroupBox;
    lbInTransaction: TLabel;
    lbStarted: TLabel;
    lbTransactionIsActive: TLabel;
    lbTransactionState: TLabel;
    cbAutoCommit: TCheckBox;
    lbAttemptMaxRows: TLabel;
    lbAllowCheckOAT: TLabel;
    lbAttemptTicks: TLabel;
    lbAttempt: TLabel;
    lbAttemptRetry: TLabel;
    sc: TIB_Script;
    btLaunch: TButton;
    procedure Button1Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure cbAutoCommitClick(Sender: TObject);
    procedure cnBeforeConnect(Sender: TIB_Connection);
    procedure btLaunchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmOAT: TfrmOAT;

implementation

{$R *.DFM}

uses
  FRM_Dataset;
  
procedure TfrmOAT.Button1Click(Sender: TObject);
begin
  with TfrmStatus.Create(Self) do
  begin
    FormStyle:=fsStayOnTop;
    Show;
  end;
end;

procedure TfrmOAT.TimerTimer(Sender: TObject);
  function GetStateText( Tran: TIB_Transaction ): string;
  begin
    case Tran.TransactionState of
      tsNone: Result := 'tsNone';
      tsInactivePending: Result := 'tsInactivePending';
      tsInactive: Result := 'tsInactive';
      tsActivePending: Result := 'tsActivePending';
      tsActive: Result := 'tsActive';
      tsCommitRetainingPending: Result := 'tsCommitRetainingPending';
      tsCommitPending: Result := 'tsCommitPending';
      tsCommitRefreshPending: Result := 'tsCommitRefreshPending';
      tsRollbackRetainingPending: Result := 'tsRollbackRetainingPending';
      tsRollbackPending: Result := 'tsRollbackPending';
      tsRollbackRefreshPending: Result := 'tsRollbackRefreshPending';
      else Result := '<Unknown>';
    end;
  end;
  function GetBoolStr( ABool: boolean ): string;
  begin
    if ABool then Result := ': True' else Result := ' = False';
  end;

var
  tmpStr: string;
begin
  with tr do
  begin
    DateTimeToString( tmpStr, 'hh:nn:ss', TimeActive );
    lbStarted.Caption := 'Started' + GetBoolStr( Started ) +
                         '  ( ' + tmpStr +
                         ' )';
    lbTransactionIsActive.Caption := 'TransactionIsActive' +
                                     GetBoolStr( TransactionIsActive );
    lbInTransaction.Caption := 'InTransaction' + GetBoolStr( InTransaction );
  end;
  with tr.TimeOutProps do
  begin
    lbAttemptMaxRows.Caption := 'AttemptMaxRows: ' + IntToStr( AttemptMaxRows );
    lbAllowCheckOAT.Caption  := 'AllowCheckOAT: ' + IntToStr( AllowCheckOAT );
    lbAttemptTicks.Caption   := 'AttemptTicks: ' + IntToStr( AttemptTicks );
    lbAttempt.Caption        := 'Attempt: ' + IntToStr( Attempt );
    lbAttemptRetry.Caption   := 'AttemptRetry: ' + IntToStr( AttemptRetry );
  end;
  lbTransactionState.Caption := 'State: ' + GetStateText( tr );
end;

procedure TfrmOAT.cbAutoCommitClick(Sender: TObject);
begin
  tr.AutoCommit := cbAutoCommit.Checked;
end;

procedure TfrmOAT.cnBeforeConnect(Sender: TIB_Connection);
begin
// Dynamically create the sample GDB if it does not exist.
  with cn do
    if ( Protocol = cpLocal ) and not FileExists( Database ) then
      sc.Execute;
end;

procedure TfrmOAT.btLaunchClick(Sender: TObject);
begin
  TfrmDataset.Create( Self ).Show;
end;

procedure TfrmOAT.FormCreate(Sender: TObject);
begin
  btLaunch.Click;
end;

end.
