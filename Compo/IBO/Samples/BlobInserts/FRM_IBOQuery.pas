unit
  FRM_IBOQuery;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, ExtCtrls, StdCtrls, Grids, Buttons,

  IB_Session,
  IB_Components,
  IB_Script,
  IB_Process,
  IB_Grid,
  IB_Controls,
  IB_LocateEdit,
  IB_NavigationBar,
  IB_DatasetBar,
  IB_UpdateBar,
  IB_SearchBar,

  DB,
  DBGrids,
  IBODataset;

type
  TfrmBlobInserts = class(TForm)
    cn: TIB_Connection;
    tr: TIB_Transaction;
    qr: TIBOQuery;
    ds: TDataSource;
    IB_Grid1: TDBGrid;
    Panel1: TPanel;
    sbFiltered: TSpeedButton;
    btFindFirst: TButton;
    btFindNext: TButton;
    btFindPrior: TButton;
    btFindLast: TButton;
    Button1: TButton;
    Button3: TButton;
    procedure sbFilteredClick(Sender: TObject);
    procedure btFindClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure qrFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure qrBeforeOpen(DataSet: TDataSet);
  private
    tmpID: integer;
  public
  end;

var
  frmBlobInserts: TfrmBlobInserts;

implementation

{$R *.DFM}

procedure TfrmBlobInserts.Button3Click(Sender: TObject);
begin
  qr.Close;
  qr.Open;
end;

procedure TfrmBlobInserts.qrBeforeOpen(DataSet: TDataSet);
begin
  tmpID := 4;
end;

procedure TfrmBlobInserts.qrFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
//  Accept := qr.FieldByName( 'ID' ).AsInteger mod 5 = 3;
  Accept := qr.FieldByName( 'ID' ).AsInteger <> tmpID;
//  Accept := qr.FieldByName( 'STRING_FIELD' ).AsString = 'Some Stuff';
end;

procedure TfrmBlobInserts.sbFilteredClick(Sender: TObject);
begin
  qr.Filtered := sbFiltered.Down;
end;

procedure TfrmBlobInserts.Button1Click(Sender: TObject);
begin
  Inc( tmpID );
  qr.RefreshFilteredRows;
end;

procedure TfrmBlobInserts.btFindClick(Sender: TObject);
begin
  if Sender = btFindFirst then qr.FindFirst else
  if Sender = btFindNext  then qr.FindNext  else
  if Sender = btFindPrior then qr.FindPrior else
  if Sender = btFindLast  then qr.FindLast;
end;

end.


