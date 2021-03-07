unit ufrmESYA_TAN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, ExtCtrls, IB_UpdateBar, Grids, IB_Grid;

type
  TfrmESYA_TAN = class(TForm)
    qryESYA: TIB_Query;
    dtsESYA: TIB_DataSource;
    IB_Grid1: TIB_Grid;
    IB_UpdateBar1: TIB_UpdateBar;
    procedure Form_Open(Menu:Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryESYAAfterInsert(IB_Dataset: TIB_Dataset);
    procedure IB_Grid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmESYA_TAN: TfrmESYA_TAN;

implementation
uses unDATAMOD, main, unFUNC;
{$R *.dfm}
procedure TfrmESYA_TAN.Form_Open(Menu:Boolean);
begin
  if not MainForm.FindChildFrm(Application,'frmESYA_TAN') then
  begin
    Application.CreateForm(TfrmESYA_TAN, frmESYA_TAN);
    frmESYA_TAN.qryESYA.Open;
  end
  else
  begin
    Application.MessageBox('Eþya Tanýmlama formu açýk.','Dikkat',MB_ICONINFORMATION);
    Exit;
  end;
////////////////////////////////////////////////////////////////////////////////
end;

procedure TfrmESYA_TAN.IB_Grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmESYA_TAN.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmESYA_TAN.qryESYAAfterInsert(IB_Dataset: TIB_Dataset);
begin
   qryESYA.FieldByName('ESYA_ID').AsInteger := DataMod.GET_SAYAC_NUM('ESYA',True,False,0);
end;

end.
