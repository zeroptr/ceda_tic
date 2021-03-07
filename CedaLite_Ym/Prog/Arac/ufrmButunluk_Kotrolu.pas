unit ufrmButunluk_Kotrolu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, IB_Grid, IB_Components;

type
  TfrmButunluk_Kotrolu = class(TForm)
    IB_DataSource1: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    cbSql: TComboBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Button1: TButton;
    IB_Query1: TIB_Query;
    Memo5: TMemo;
    Memo6: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmButunluk_Kotrolu: TfrmButunluk_Kotrolu;

implementation

uses unDataMod;

{$R *.dfm}

procedure TfrmButunluk_Kotrolu.Button1Click(Sender: TObject);
begin
     IB_Query1.Active:=False;
     if cbSql.ItemIndex=0 then IB_Query1.Sql.Text:=Memo1.Lines.Text;
     if cbSql.ItemIndex=1 then IB_Query1.Sql.Text:=Memo2.Lines.Text;
     if cbSql.ItemIndex=2 then IB_Query1.Sql.Text:=Memo3.Lines.Text;
     if cbSql.ItemIndex=3 then IB_Query1.Sql.Text:=Memo4.Lines.Text;
     if cbSql.ItemIndex=4 then IB_Query1.Sql.Text:=Memo6.Lines.Text;
     if cbSql.ItemIndex=5 then IB_Query1.Sql.Text:=Memo7.Lines.Text;
     if cbSql.ItemIndex=6 then IB_Query1.Sql.Text:=Memo8.Lines.Text;
     Memo5.Lines.Text:=IB_Query1.Sql.Text;
     IB_Query1.Active:=True;
end;

procedure TfrmButunluk_Kotrolu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
