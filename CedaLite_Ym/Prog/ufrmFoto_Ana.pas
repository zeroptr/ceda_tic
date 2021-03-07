unit ufrmFoto_Ana;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Controls, ExtCtrls, IB_Components;

type
  TfrmFoto_Ana = class(TForm)
    qry_Sirket: TIB_Query;
    dts_Sirket: TIB_DataSource;
    IB_Image1: TIB_Image;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure IB_Image1DblClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
  private
    FWallpaper: TBitmap;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFoto_Ana: TfrmFoto_Ana;

implementation

uses unDataMod;

{$R *.dfm}

procedure TfrmFoto_Ana.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qry_Sirket.Active:=False;
  Action := caFree;
end;

procedure TfrmFoto_Ana.FormShow(Sender: TObject);
begin
     Left:=0;
     Top:=0;
   qry_Sirket.Active:=False;
   qry_Sirket.ParamByName('PRM_SIRKET_ID').AsInteger:=glb_SIRKET_ID;
   qry_Sirket.Active:=True;
{   qry_Sirket.FieldByName('LOGO').s
    if not Assigned(FWallpaper) then
      FWallpaper := TBitmap.Create;
FWallpaper.LoadFromStream();}
end;

procedure TfrmFoto_Ana.IB_Image1DblClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmFoto_Ana.FormDblClick(Sender: TObject);
begin
     Close;
end;

end.
