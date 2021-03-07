unit ufrm_Kantar_Cikis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IB_Controls, Mask, ExtCtrls, IB_Components;

type
  Tfrm_Kantar_Cikis = class(TForm)
    Pnl_Cikis: TPanel;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Date3: TIB_Date;
    IB_Date4: TIB_Date;
    IB_Edit4: TIB_Edit;
    Btn_Cikis_Kilo: TBitBtn;
    IB_Text1: TIB_Text;
    Label1: TLabel;
    Label2: TLabel;
    IB_Text2: TIB_Text;
    Label3: TLabel;
    IB_Text3: TIB_Text;
    Label4: TLabel;
    IB_Text4: TIB_Text;
    Label5: TLabel;
    IB_Text5: TIB_Text;
    IB_Text6: TIB_Text;
    Label6: TLabel;
    Label7: TLabel;
    IB_Text7: TIB_Text;
    Label8: TLabel;
    IB_Text8: TIB_Text;
    Label9: TLabel;
    IB_Text9: TIB_Text;
    Label10: TLabel;
    IB_Text10: TIB_Text;
    btnCikis: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    procedure btnCikisClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Kantar_Cikis: Tfrm_Kantar_Cikis;

implementation

uses ufrm_Kantar;

{$R *.dfm}

procedure Tfrm_Kantar_Cikis.btnCikisClick(Sender: TObject);
begin
     if Frm_Kantar.qry_Kantar.State=DssEdit then
     Frm_Kantar.qry_Kantar.Cancel;
     ModalResult:=MrOk;
end;

procedure Tfrm_Kantar_Cikis.BitBtn1Click(Sender: TObject);
begin
     Frm_Kantar.qry_Kantar.Post;
end;

procedure Tfrm_Kantar_Cikis.BitBtn3Click(Sender: TObject);
begin
     if Frm_Kantar.qry_Kantar.State=DssEdit then
     Frm_Kantar.qry_Kantar.Post;

     frm_Kantar.BtnYazdirClick(frm_Kantar.BtnYazdir);
end;

end.
