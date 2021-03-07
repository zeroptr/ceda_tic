unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmMain = class(TForm)
    txtKod: TLabeledEdit;
    txtSifre: TLabeledEdit;
    btnCIKIS: TSpeedButton;
    btnTamam: TBitBtn;
    procedure btnCIKISClick(Sender: TObject);
    procedure btnTamamClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnCIKISClick(Sender: TObject);
begin
  Close;
end;


function HexToInt(s: string): Longword;
var
  b: Byte;
  c: Char;
begin
  Result := 0;
  s := UpperCase(s);
  for b := 1 to Length(s) do
  begin
    Result := Result * 16;
    c := s[b];
    case c of
      '0'..'9': Inc(Result, Ord(c) - Ord('0'));
      'A'..'F': Inc(Result, Ord(c) - Ord('A') + 10);
      else
        raise EConvertError.Create('No Hex-Number');
    end;
  end;
end;


procedure TfrmMain.btnTamamClick(Sender: TObject);
var
  UrunKod:LongWord;
begin
    UrunKod := HexToInt(txtKod.Text);
    UrunKod := (UrunKod - 5) * 7  ;
    txtSifre.Text := IntToHex(UrunKod,10);
end;

end.
