unit FRM_Dataset;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, ExtCtrls, Grids, IB_Grid;

type
  TfrmDataset = class(TForm)
    IB_Grid1: TIB_Grid;
    cbPessimisticLocking: TCheckBox;
    rgSize: TRadioGroup;
    BufferRowCount: TLabel;
    rgCommitAction: TRadioGroup;
    rgRefreshAction: TRadioGroup;
    qr: TIB_Query;
    ds: TIB_DataSource;
    Timer: TTimer;
    procedure rgCommitActionClick(Sender: TObject);
    procedure cbPessimisticLockingClick(Sender: TObject);
    procedure rgRefreshActionClick(Sender: TObject);
    procedure rgSizeClick(Sender: TObject);
    procedure qrPrepareSQL(Sender: TIB_Statement);
    procedure FormActivate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDataset: TfrmDataset;

implementation

{$R *.DFM}

uses
  FRM_TransOAT;

procedure TfrmDataset.rgCommitActionClick(Sender: TObject);
begin
  case rgCommitAction.ItemIndex of
    0: qr.CommitAction := caClose;
    1: qr.CommitAction := caInvalidateCursor;
    2: qr.CommitAction := caRefresh;
    3: qr.CommitAction := caRefreshKeys;
    4: qr.CommitAction := caFetchAll;
  end;
end;

procedure TfrmDataset.cbPessimisticLockingClick(Sender: TObject);
begin
  qr.PessimisticLocking := cbPessimisticLocking.Checked;
end;

procedure TfrmDataset.rgRefreshActionClick(Sender: TObject);
begin
  case rgRefreshAction.ItemIndex of
    0: qr.RefreshAction := raKeepDataPos;
    1: qr.RefreshAction := raKeepRowNum;
    2: qr.RefreshAction := raOpen;
  end;
end;

procedure TfrmDataset.rgSizeClick(Sender: TObject);
begin
  qr.InvalidateSQL;
  if qr.Active then
    qr.Refresh;
end;

procedure TfrmDataset.qrPrepareSQL(Sender: TIB_Statement);
begin
  case rgSize.ItemIndex of
    0: qr.SQLWhereItems.Add( 'FIELD < 10' );
    1: qr.SQLWhereItems.Add( 'FIELD < 100' );
    2: qr.SQLWhereItems.Add( 'FIELD < 1000' );
    3: qr.SQLWhereItems.Add( 'FIELD < 10000' );
    4: qr.SQLWhereItems.Add( 'FIELD < 100000' );
  end;
end;

procedure TfrmDataset.FormActivate(Sender: TObject);
begin
  ds.SetFocus;
end;

procedure TfrmDataset.TimerTimer(Sender: TObject);
begin
  BufferRowCount.Caption := 'Rec: '+
                            IntToStr( qr.RowNum )+' of '+
                            IntToStr( qr.BufferRowCount );
  if not qr.BufferHasEof then
    BufferRowCount.Caption := BufferRowCount.Caption+'+';
end;

end.
