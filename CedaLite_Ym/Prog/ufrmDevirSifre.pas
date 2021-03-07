unit ufrmDevirSifre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmDevirSifre = class(TForm)
    txtUSER_NAME: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    txtPASS_WORD: TEdit;
    btnCIKIS: TSpeedButton;
    btnTamam: TBitBtn;
    procedure btnCIKISClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDevirSifre: TfrmDevirSifre;

implementation

{$R *.dfm}

procedure TfrmDevirSifre.btnCIKISClick(Sender: TObject);
begin
     ModalResult:=MrCancel;
end;

procedure TfrmDevirSifre.btnTamamClick(Sender: TObject);
begin
     if txtPASS_WORD.Text='Cdea' then
     ModalResult:=MrOk;
end;

procedure TfrmDevirSifre.FormActivate(Sender: TObject);
begin
     txtPASS_WORD.Text:='';
     txtPASS_WORD.SetFocus;
end;

procedure TfrmDevirSifre.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     if txtPASS_WORD.Text<>'Cdea' then
     ModalResult:=MrCancel;
end;

end.
