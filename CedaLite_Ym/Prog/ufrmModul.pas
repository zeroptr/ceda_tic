unit ufrmModul;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, IB_Grid, ExtCtrls, IB_UpdateBar, IB_NavigationBar, IB_Components,
  StdCtrls, Buttons;

type
  TfrmModul = class(TForm)
    Grid_Panel: TPanel;
    Modul_Grid: TIB_Grid;
    qry_Modul: TIB_Query;
    dts_Modul: TIB_DataSource;
    Panel2: TPanel;
    btnExit: TBitBtn;
    IB_Grid1: TIB_Grid;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    qry_Prg: TIB_Query;
    dts_Prg: TIB_DataSource;
    IB_NavigationBar2: TIB_NavigationBar;
    IB_UpdateBar2: TIB_UpdateBar;
    Function Form_Open(Menu:Boolean):Integer;
    procedure Modul_GridKeyPress(Sender: TObject; var Key: Char);
    procedure btnExitClick(Sender: TObject);
    procedure IB_Grid1Exit(Sender: TObject);
    procedure IB_Grid1Enter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qry_ModulAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qry_ModulBeforePost(IB_Dataset: TIB_Dataset); /// Menuden Giriþler için True
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmModul: TfrmModul;

implementation
uses unDataMod,unFunc;


{$R *.DFM}

function TfrmModul.Form_Open(Menu:Boolean):Integer;
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Application.CreateForm(TfrmModul, frmModul);
  with frmModul do
  begin
    qry_Prg.Active := True;
    qry_Modul.Active := True;
    ShowModal;
    qry_Prg.Active := False;
    qry_Modul.Active := False;
    Release;
  end;
end;


procedure TfrmModul.Modul_GridKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmModul.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmModul.IB_Grid1Exit(Sender: TObject);
begin
  if qry_Prg.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Lütfen önce yapýlan iþlemi kayýt ediniz ya da iptal ediniz.','Dikkat',MB_ICONWARNING);
    IB_NavigationBar1.Enabled := False;
    IB_UpdateBar1.Enabled := False;
    IB_Grid1.SetFocus;
  end
  else
  begin
    IB_NavigationBar1.Enabled := True;
    IB_UpdateBar1.Enabled := True;
  end;
end;

procedure TfrmModul.IB_Grid1Enter(Sender: TObject);
begin
  IB_NavigationBar1.Enabled := False;
  IB_UpdateBar1.Enabled := False;
end;

procedure TfrmModul.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if qry_Prg.State in [dssEdit,dssInsert] then
    begin
        Application.MessageBox('Lütfen yaptýðýnýz deðiþiklikleri kayýt ediniz ya da iptal ediniz.','Dikkat',MB_ICONWARNING);
        Abort;
    end;
    if qry_Modul.State in [dssEdit,dssInsert] then
    begin
        Application.MessageBox('Lütfen yaptýðýnýz deðiþiklikleri kayýt ediniz ya da iptal ediniz.','Dikkat',MB_ICONWARNING);
        Abort;
    end;
end;

procedure TfrmModul.qry_ModulAfterInsert(IB_Dataset: TIB_Dataset);
var
  MaxNum:Integer;
  qryMaxModul : TIB_Query;
begin
   DataMod.CreateQuery(qryMaxModul,nil,False,DataMod.dbaANA);
   with qryMaxModul do
   Begin
     Active := False;
     sql.Clear;
     sql.Add('SELECT MAX(MODUL_ID) from MODUL');
     Active := True;
     MaxNum := Fields[0].asInteger;
   end;
   qry_Modul.FieldByName('MODUL_ID').AsInteger := MaxNum + 1;
end;

procedure TfrmModul.qry_ModulBeforePost(IB_Dataset: TIB_Dataset);
begin
   if (trim(qry_Modul.FieldByName('MODUL_ADI').AsString) = '') then
   begin
    ShowMessage ('Modul Adýný yazmadýnýz');
    abort;
   end;


end;

end.
