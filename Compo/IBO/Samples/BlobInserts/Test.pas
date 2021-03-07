unit
  Test;

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
  IB_IncSearch;

type
  TfrmBlobInserts = class(TForm)
    cn: TIB_Connection;
    tr: TIB_Transaction;
    qr: TIB_Query;
    ds: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    Panel1: TPanel;
    IB_DatasetBar1: TIB_DatasetBar;
    IB_NavigationBar1: TIB_NavigationBar;
    sbFiltered: TSpeedButton;
    btFindFirst: TButton;
    btFindNext: TButton;
    btFindPrior: TButton;
    btFindLast: TButton;
    IB_UpdateBar1: TIB_UpdateBar;
    Button1: TButton;
    IB_SearchBar1: TIB_SearchBar;
    Panel2: TPanel;
    Edit1: TEdit;
    cbBof: TCheckBox;
    cbEof: TCheckBox;
    sbTGR: TSpeedButton;
    IB_IncSearch1: TIB_IncSearch;
    IB_LocateEdit1: TIB_LocateEdit;
    procedure qrFilterRecord(ARow: TIB_Row; var Accept: Boolean);
    procedure sbFilteredClick(Sender: TObject);
    procedure btFindClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure qrBeforeOpen(IB_Dataset: TIB_Dataset);
    procedure dsDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure sbTGRClick(Sender: TObject);
  private
    tmpID: integer;
  public
  end;

var
  frmBlobInserts: TfrmBlobInserts;

implementation

{$R *.DFM}

procedure TfrmBlobInserts.qrFilterRecord(ARow: TIB_Row;
  var Accept: Boolean);
begin
// Experiment with these different scenarios.

//  Accept := ARow.ByName( 'ID' ).AsInteger mod 5 = 3;
  Accept := ARow.ByName( 'ID' ).AsInteger <> tmpID;
//  Accept := ARow.ByName( 'STRING_FIELD' ).AsString = 'Some Stuff';
end;

procedure TfrmBlobInserts.sbFilteredClick(Sender: TObject);
begin
  qr.Filtered := sbFiltered.Down;
end;

procedure TfrmBlobInserts.btFindClick(Sender: TObject);
begin
  if Sender = btFindFirst then qr.FindFirst else
  if Sender = btFindNext  then qr.FindNext  else
  if Sender = btFindPrior then qr.FindPrior else
  if Sender = btFindLast  then qr.FindLast;
end;

procedure TfrmBlobInserts.Button1Click(Sender: TObject);
begin
  Inc( tmpID );
  qr.RefreshFilteredRows;
end;

procedure TfrmBlobInserts.qrBeforeOpen(IB_Dataset: TIB_Dataset);
begin
  tmpID := 4;
end;

procedure TfrmBlobInserts.dsDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  Edit1.Text := IntToStr( qr.BufferRowCount );
  cbBof.Checked := qr.Bof;
  cbEof.Checked := qr.Eof;
end;

procedure TfrmBlobInserts.sbTGRClick(Sender: TObject);
begin
  IB_Grid1.TrackGridRow := sbTGR.Down;
end;

end.

