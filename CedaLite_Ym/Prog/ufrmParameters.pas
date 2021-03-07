unit ufrmParameters;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, StdCtrls, Mask, IB_Controls, ExtCtrls, IB_UpdateBar,
  IB_NavigationBar, Grids, IB_Grid, Buttons;

type
  TfrmParameters = class(TForm)
    Panel1: TPanel;
    qry_Modul: TIB_Query;
    dts_Modul: TIB_DataSource;
    qry_Parameters: TIB_Query;
    dts_Parameters: TIB_DataSource;
    GroupBox1: TGroupBox;
    IB_Grid1: TIB_Grid;
    Panel3: TPanel;
    IB_Grid2: TIB_Grid;
    dlgColor: TColorDialog;
    IB_Memo1: TIB_Memo;
    Label4: TLabel;
    Panel2: TPanel;
    btnExit: TBitBtn;
    function Form_Open(Menu:Boolean):Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure IB_Grid2KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure btnExitClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmParameters: TfrmParameters;

implementation
uses unDataMod,unFunc;
{$R *.DFM}

{ TfrmParameters }

function TfrmParameters.Form_Open(Menu: Boolean): Boolean;
begin
  Result := False;
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Application.CreateForm(TfrmParameters, frmParameters);
  if glb_YONETICI then
  begin
    with frmParameters do
    begin
      qry_Modul.RequestLive := True;
      qry_Parameters.RequestLive := True;
    end;
  end
  else
  begin
    with frmParameters do
    begin
      qry_Modul.RequestLive := False;
      qry_Parameters.RequestLive := False;
    end;
  end;

  with frmParameters do
  begin
    qry_Modul.Active := True;
    qry_Parameters.Active := True;
    ShowModal;
    Release;
  end;
  Result := True;
end;


procedure TfrmParameters.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qry_Modul.Active := False;
  qry_Parameters.Active := False;
end;

procedure TfrmParameters.BitBtn1Click(Sender: TObject);
begin
  qry_Modul.Active := False;
  Close;
end;

procedure TfrmParameters.IB_Grid2KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if Key = VK_F4 then
   begin
     if qry_Parameters.FieldByName('PARAM_NAME').AsString='ART_AL_RENK' then
     begin
       dlgColor.Execute;
       qry_Parameters.Edit;
       qry_Parameters.FieldByName('DEGER').AsString :=ColorToString( dlgColor.Color);
       qry_Parameters.Post;
     end
     else if qry_Parameters.FieldByName('PARAM_NAME').AsString='YAZI_RENK' then
     begin
       dlgColor.Execute;
       qry_Parameters.Edit;
       qry_Parameters.FieldByName('DEGER').AsString :=ColorToString( dlgColor.Color);
       qry_Parameters.Post;
     end;
   end;
end;

procedure TfrmParameters.btnExitClick(Sender: TObject);
begin
  Close;
end;

end.
