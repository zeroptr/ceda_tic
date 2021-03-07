unit ufrmLisans;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,Registry,FMTBcd;

type
  TfrmLisans = class(TForm)
    Label1: TLabel;
    txtUrunKodu: TEdit;
    Label2: TLabel;
    txtSifre: TEdit;
    btnCIKIS: TSpeedButton;
    btnTamam: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    function Form_Open(Reg:TRegistry): boolean;
    procedure btnTamamClick(Sender: TObject);
    procedure btnCIKISClick(Sender: TObject);

  private
    { Private declarations }
    prv_Kontrol:Boolean;
    prv_Reg:TRegistry;
  public
    { Public declarations }
  end;

var
  frmLisans: TfrmLisans;

implementation

uses unsec;

{$R *.dfm}

function TfrmLisans.Form_Open(Reg:TRegistry):boolean;
begin
  Application.CreateForm(TfrmLisans, frmLisans);
  frmLisans.txtUrunKodu.Text :=  GET_HDDNUMBER;
  frmLisans.prv_Reg := Reg;
  frmLisans.ShowModal;
  Result := frmLisans.prv_Kontrol;
end;


procedure TfrmLisans.btnTamamClick(Sender: TObject);
var
   IHDD_ID:LongWord;
   Sifre:LongWord;
begin
   IHDD_ID := HexToInt(txtUrunKodu.Text);
   IHDD_ID := (IHDD_ID - 5) * 7  ;
   Sifre := HexToInt(txtSifre.Text);
   if IHDD_ID=Sifre  then begin
      prv_Reg.WriteString('D',SIFRELE(txtSifre.Text));
      prv_Kontrol := true;
      Application.Terminate;
      Close;
   end
   else begin
      ShowMessage('Þifre Yanlýþ Lütfen Tekrar Deneyiniz ..!');
   end;
end;

procedure TfrmLisans.btnCIKISClick(Sender: TObject);
begin
  prv_Kontrol := false;
  Close;
end;

end.
