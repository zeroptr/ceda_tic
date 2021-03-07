unit
  MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, Buttons,

  IB_Constants,
  IB_Components,
  IB_NavigationBar,
  IB_DatasetBar,
  IB_UpdateBar,
  IB_TransactionBar,
  IB_ConnectionBar,
  IB_Grid,
  IB_SessionProps;

type
  TTransactionMainForm = class(TForm)
    ToolbarsPnl: TPanel;
    ConnectionBar: TIB_ConnectionBar;
    TransactionBar: TIB_TransactionBar;
    UpdateBar: TIB_UpdateBar;
    DatasetBar: TIB_DatasetBar;
    NavigationBar: TIB_NavigationBar;
    IBConnection: TIB_Connection;
    trControlled: TIB_Transaction;
    qrControlled: TIB_Query;
    dsControlled: TIB_DataSource;
    AutoDataSource: TIB_DataSource;
    ConnectionBarLbl: TLabel;
    TransactionBarLbl: TLabel;
    Label2: TLabel;
    ControlledQueryPnl: TPanel;
    AutoQueryPnl: TPanel;
    ControlledQueryGrid: TIB_Grid;
    ControlledQueryTitlePnl: TPanel;
    AutoQueryTitlePnl: TPanel;
    AutoQueryGrid: TIB_Grid;
    AutoQuery: TIB_Query;
    TransactionStatePnl: TPanel;
    TransactionStateTitlePnl: TPanel;
    TransactionStateGrid: TStringGrid;
    TransactionTimer: TTimer;
    ControlledQueryOptionsPnl: TPanel;
    ControlTransactionIsolationCB: TComboBox;
    ControlTransactionPauseEnabledCB: TCheckBox;
    HelpBtn: TBitBtn;
    IB_SessionProps1: TIB_SessionProps;
    procedure FormCreate(Sender: TObject);
    procedure TransactionTimerTimer(Sender: TObject);
    procedure PauseEnabledChange(Sender: TObject);
    procedure TransactionIsolationChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure trControlledSessionTimer(Sender: TComponent; var IsDone,
      IsWaiting, Terminate: Boolean);
  private
    { Private declarations }
//    FMessageVisible: boolean;
//    FLastActivity: TDateTime;
//    procedure CheckTransactions;
//    procedure DoAppMessage(var Msg: TMsg; var Handled: Boolean);
//    procedure ShowPauseMessage( var Msg: TMessage ); message ( WM_APP + 1 );
  public
    { Public declarations }
    constructor Create( AOwner: TComponent ); override;
  end;

var
  TransactionMainForm: TTransactionMainForm;

implementation

{$R *.DFM}

constructor TTransactionMainForm.Create( AOwner: TComponent );
begin
//  FLastActivity := SysUtils.Now;
//  Application.OnMessage := DoAppMessage;
  inherited;
end;

procedure TTransactionMainForm.FormCreate(Sender: TObject);
begin
  // Initialise the Transaction display grid
  TransactionStateGrid.ColCount := 7; // Name, Started, Paused, TimeActive
  TransactionStateGrid.RowCount := 4; // Title-Row, Internal, Controlled, Query
  TransactionStateGrid.FixedRows := 1;
  TransactionStateGrid.FixedCols := 0;
  TransactionStateGrid.ColWidths[0] := 120;
  TransactionStateGrid.Cells[0,0] := 'Transaction';
  TransactionStateGrid.ColWidths[1] := 40;
  TransactionStateGrid.Cells[1,0] := 'Started';
  TransactionStateGrid.ColWidths[2] := 40;
  TransactionStateGrid.Cells[2,0] := 'Paused';
  TransactionStateGrid.ColWidths[3] := 80;
  TransactionStateGrid.Cells[3,0] := 'TimeActive';
  TransactionStateGrid.ColWidths[4] := 90;
  TransactionStateGrid.Cells[4,0] := 'TransactionState';
  TransactionStateGrid.ColWidths[5] := 40;
  TransactionStateGrid.Cells[5,0] := 'InTransaction';
  TransactionStateGrid.ColWidths[6] := 50;
  TransactionStateGrid.Cells[6,0] := 'PostPendingCount';
  // Initialise ControlQuery options...
  ControlTransactionPauseEnabledCB.Checked :=
    not trControlled.IsPauseDisabled;
  case trControlled.Isolation of
    tiCommitted: ControlTransactionIsolationCB.ItemIndex := 0;
    tiConcurrency: ControlTransactionIsolationCB.ItemIndex := 1;
    tiConsistency: ControlTransactionIsolationCB.ItemIndex := 2;
    else ControlTransactionIsolationCB.ItemIndex := -1;
  end;
end;

procedure TTransactionMainForm.FormResize(Sender: TObject);
begin
// Keep the two grids of equal width (just aesthetics)
  ControlledQueryPnl.Width := ClientWidth div 2;
end;

procedure TTransactionMainForm.TransactionTimerTimer(Sender: TObject);
var
  i: integer;
  iList: TList;
  iTran: TIB_Transaction;
  function GetCompDesc( Comp: TComponent ): string;
  begin
    if Comp.Name = '' then
      Result := Comp.ClassName
    else
      Result := Comp.Name;
  end;
  function GetBoolText( Val: boolean ): string;
  begin
    if Val then
      Result := 'True'
    else
      Result := 'False';
  end;
  function GetTimeText( Interval: TDateTime ): string;
  var
    tmpStr: string;
  begin
    Result := '';
    if Interval > 0 then
    begin
      if Int(Interval) >= 1 then
        Result := FloatToStr(Int(Interval)) + '+';
      Interval := 24 * Frac(Interval);
      tmpStr := FloatToStrF(Int(Interval), ffFixed, 0, 0 );
      if Length( tmpStr ) = 1 then tmpStr := '0' + tmpStr;
      Result := Result + tmpStr + ':';
      Interval := 60 * Frac(Interval);
      tmpStr := FloatToStrF(Int(Interval), ffFixed, 0, 0 );
      if Length( tmpStr ) = 1 then tmpStr := '0' + tmpStr;
      Result := Result + tmpStr + ':';
      Interval := 60 * Frac(Interval);
      tmpStr := FloatToStrF(Int(Interval), ffFixed, 0, 0 );
      if Length( tmpStr ) = 1 then tmpStr := '0' + tmpStr;
      Result := Result + tmpStr;
    end;
  end;
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
begin
  iList := TIB_Session.DefaultSession.Session_Transactions;
  TransactionStateGrid.RowCount := iList.Count + 1;
  for i := 0 to iList.Count - 1 do
  begin
    iTran := TIB_Transaction(iList.Items[i]);
    TransactionStateGrid.Cells[0,i+1] := GetCompDesc( iTran );
    TransactionStateGrid.Cells[1,i+1] := GetBoolText( iTran.Started );
    TransactionStateGrid.Cells[2,i+1] := GetBoolText( iTran.IsPaused );
    TransactionStateGrid.Cells[3,i+1] := GetTimeText( iTran.TimeActive );
    TransactionStateGrid.Cells[4,i+1] := GetStateText( iTran );
    TransactionStateGrid.Cells[5,i+1] := GetBoolText( iTran.InTransaction );
    TransactionStateGrid.Cells[6,i+1] := IntToStr( iTran.PostPendingCount );
  end;
end;

procedure TTransactionMainForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpFile := 'Transactions.HLP';
  Application.HelpCommand( HELP_CONTENTS, 0 );
end;

procedure TTransactionMainForm.PauseEnabledChange(Sender: TObject);
begin
  try
    if trControlled.IsPauseDisabled then
      trControlled.EnablePause
    else
      trControlled.DisablePause;
  finally
    ControlTransactionPauseEnabledCB.Checked :=
      not trControlled.IsPauseDisabled;
  end;
end;

procedure TTransactionMainForm.TransactionIsolationChange(Sender: TObject);
begin
  try
    case ControlTransactionIsolationCB.ItemIndex of
      0: trControlled.ChangeIsolation( tiCommitted, false );
      1: trControlled.ChangeIsolation( tiConcurrency, false );
      2: trControlled.ChangeIsolation( tiConsistency, false );
      else trControlled.ChangeIsolation( tiCommitted, false );
    end;
  finally
    case trControlled.Isolation of
      tiCommitted: ControlTransactionIsolationCB.ItemIndex := 0;
      tiConcurrency: ControlTransactionIsolationCB.ItemIndex := 1;
      tiConsistency: ControlTransactionIsolationCB.ItemIndex := 2;
      else ControlTransactionIsolationCB.ItemIndex := -1;
    end;
  end;
end;

{
procedure TTransactionMainForm.DoAppMessage( var Msg: TMsg;
                                             var Handled: Boolean );
begin
  if ((Msg.message >= WM_KEYFIRST) and (Msg.message <= WM_KEYLAST)) or
     ((Msg.message >= WM_MOUSEFIRST) and (Msg.message <= WM_MOUSELAST)) then
    FLastActivity := SysUtils.Now;
  // DO NOT set Handled to true, because we want default processing.
end;

procedure TTransactionMainForm.ShowPauseMessage( var Msg: TMessage );
var
  ii: integer;
  iList: TList;
  IsTrnPaused: boolean;
begin
  if not FMessageVisible then
  begin
    FMessageVisible := true;
    try
      IsTrnPaused := false;
      iList := TIB_Session.DefaultSession.Session_Transactions;
      for ii := 0 to iList.Count - 1 do
        with TIB_Transaction(iList.Items[ii]) do
          IsTrnPaused := IsTrnPaused or IsPaused;

      if IsTrnPaused then
      begin
        Application.MessageBox( 'Transactions Paused.  Click OK to Resume',
                                'Paused',
                                MB_OK );
        for ii := 0 to iList.Count - 1 do
          with TIB_Transaction(iList.Items[ii]) do
            Resume( true );
      end;
    finally
      FMessageVisible := false;
    end;
  end;
end;
}

procedure TTransactionMainForm.trControlledSessionTimer(Sender: TComponent;
  var IsDone, IsWaiting, Terminate: Boolean);
{
var
  i: integer;
  iList: TList;
  iTran: TIB_Transaction;
  OAT: TDateTime;
  PauseEnabled: boolean;
}
begin
{  iList := TIB_Session.DefaultSession.Session_Transactions;
  OAT := 0;
  PauseEnabled := true;
  for i := 0 to iList.Count - 1 do
  begin
    iTran := TIB_Transaction(iList.Items[i]);
    if iTran.Started then
    begin
      if OAT < iTran.TimeActive then
        OAT := iTran.TimeActive;
      if iTran.IsPauseDisabled or iTran.IsPaused then
        PauseEnabled := false;
    end;
  end;
{
  if PauseEnabled and ((OAT * 86400) > 15) and
    (((SysUtils.Now - FLastActivity) * 86400) > 15) then
  begin
    for i := 0 to iList.Count - 1 do
      TIB_Transaction(iList.Items[i]).Pause( false );
  end;
  PostMessage( Handle, WM_APP + 1, 0, 0 );
}
end;

end.


