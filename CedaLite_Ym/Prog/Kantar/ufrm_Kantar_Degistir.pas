unit ufrm_Kantar_Degistir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IB_Controls, Mask, ExtCtrls;

type
  Tfrm_Kantar_Degistir = class(TForm)
    Pnl_Giris: TPanel;
    txtPlaka_No: TIB_Edit;
    txtCari_Kod: TIB_Edit;
    IB_Edit3: TIB_Edit;
    txtUrun_Kod: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_ComboBox1: TIB_ComboBox;
    IB_Edit2: TIB_Edit;
    BitBtn1: TBitBtn;
    Cb_Geldigi_Yer: TIB_ComboBox;
    Cb_Gittigi_Yer: TIB_ComboBox;
    Cb_Aciklama: TIB_ComboBox;
    IB_Date4: TIB_Date;
    Btn_Cikis_Yap: TBitBtn;
    grpRapKod: TGroupBox;
    IB_Edit1: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit24: TIB_Edit;
    IB_Edit25: TIB_Edit;
    txtKasaKod: TIB_Edit;
    txtKasaAd: TIB_Edit;
    Btn_Giris_Yaz: TBitBtn;
    Pnl_Cikis: TPanel;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Date3: TIB_Date;
    IB_Edit4: TIB_Edit;
    BitBtn2: TBitBtn;
    IB_Date2: TIB_Date;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Kantar_Degistir: Tfrm_Kantar_Degistir;

implementation

uses ufrm_Kantar;

{$R *.dfm}

procedure Tfrm_Kantar_Degistir.FormCreate(Sender: TObject);
begin
//
end;

end.
