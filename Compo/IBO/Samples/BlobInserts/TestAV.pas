unit
  TestAV;

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
  IB_SearchBar;

type
  TfrmBlobIn = class(TForm)
    cn: TIB_Connection;
    tr: TIB_Transaction;
    qr: TIB_Query;
    ds: TIB_DataSource;
    Panel1: TPanel;
    IB_DatasetBar1: TIB_DatasetBar;
    procedure qrFilterRecord(ARow: TIB_Row; var Accept: Boolean);
    procedure sbFilteredClick(Sender: TObject);
    procedure btFindClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure qrBeforeOpen(IB_Dataset: TIB_Dataset);
    procedure dsDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
  private
    tmpID: integer;
  public
  end;

var
  frmBlobIn: TfrmBlobIn;

implementation

{$R *.DFM}

procedure TfrmBlobIn.qrFilterRecord(ARow: TIB_Row;
  var Accept: Boolean);
begin
//  Accept := ARow.ByName( 'ID' ).AsInteger mod 5 = 3;
  Accept := ARow.ByName( 'ID' ).AsInteger <> tmpID;
//  Accept := ARow.ByName( 'STRING_FIELD' ).AsString = 'Some Stuff';
end;

procedure TfrmBlobIn.sbFilteredClick(Sender: TObject);
begin
//  qr.Filtered := sbFiltered.Down;
end;

procedure TfrmBlobIn.btFindClick(Sender: TObject);
begin
{
  if Sender = btFindFirst then qr.FindFirst else
  if Sender = btFindNext  then qr.FindNext  else
  if Sender = btFindPrior then qr.FindPrior else
  if Sender = btFindLast  then qr.FindLast;
}
end;

procedure TfrmBlobIn.Button1Click(Sender: TObject);
begin
  Inc( tmpID );
  qr.RefreshFilteredRows;
end;

procedure TfrmBlobIn.qrBeforeOpen(IB_Dataset: TIB_Dataset);
begin
  tmpID := 4;
end;

procedure TfrmBlobIn.dsDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
{
  Edit1.Text := IntToStr( qr.BufferRowCount );
  cbBof.Checked := qr.Bof;
  cbEof.Checked := qr.Eof;
}
end;

end.

object IB_Grid1: TIB_Grid
  Left = 0
  Top = 41
  Width = 507
  Height = 154
  CustomGlyphsSupplied = []
  DataSource = ds
  Align = alClient
  TabOrder = 0
  DefaultRowHeight = 17
  Ctl3DShallow = True
end

