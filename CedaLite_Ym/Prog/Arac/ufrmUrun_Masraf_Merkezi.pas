unit ufrmUrun_Masraf_Merkezi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, IB_Grid, IB_Components, StdCtrls, Buttons, ExtCtrls,
  Mask, IB_Controls;

type
  TfrmUrun_Masraf_Merkezi = class(TForm)
    dts_Netsis_Aktarma: TIB_DataSource;
    Qry_Netsis_Aktarma: TIB_Query;
    IB_Grid1: TIB_Grid;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnCikis: TBitBtn;
    txtUrunKodu: TIB_Edit;
    IB_Edit23: TIB_Edit;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit3: TIB_Edit;
    Button1: TButton;
    procedure btnCikisClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Form_Open(Menu: Boolean);
    procedure dts_Netsis_AktarmaStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure IB_Grid1DblClick(Sender: TObject);
    procedure txtUrunKoduButtonClick(Sender: TObject);
    procedure IB_Edit3Enter(Sender: TObject);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure txtUrunKoduExit(Sender: TObject);
    procedure IB_Edit1ButtonClick(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure IB_Edit5ButtonClick(Sender: TObject);
    procedure IB_Edit5Exit(Sender: TObject);
    procedure txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
    procedure txtUrunKoduKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IB_Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtUrunKoduEnter(Sender: TObject);
    procedure IB_Edit5Enter(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private

    { Private declarations }
  public
    Muh_Kod,Aciklama:String;
    { Public declarations }
  end;

var
  frmUrun_Masraf_Merkezi: TfrmUrun_Masraf_Merkezi;

implementation

uses unDataMod, main, ufrmUrunSDLG, UnFunc;

{$R *.dfm}

procedure TfrmUrun_Masraf_Merkezi.Form_Open(Menu:Boolean);
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmUrun_Masraf_Merkezi') then
    begin
      Application.CreateForm(TfrmUrun_Masraf_Merkezi, frmUrun_Masraf_Merkezi);
      frmUrun_Masraf_Merkezi.Qry_Netsis_Aktarma.Open;
    end;
  end;
end;


procedure TfrmUrun_Masraf_Merkezi.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUrun_Masraf_Merkezi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmUrun_Masraf_Merkezi.dts_Netsis_AktarmaStateChanged( Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
//    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if not ((ADataset.Eof) And (ADataset.Bof)) then
    begin
      btnSil.Enabled := True;
    end
    else
    begin
      btnSil.Enabled := False;
    end;
//    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmUrun_Masraf_Merkezi.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Qry_Netsis_Aktarma.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Formdan çýkmak için yaptýðýnýz iþlemi kaydetmeli ya da iptal etmelisiniz.','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Grid1DblClick(Sender: TObject);
begin
//   if IB_Grid1.SelectedField= Qry_Netsis_Aktarma.FieldByName('URUN_KOD') then txtUrunKoduButtonClick(Self);
end;

procedure TfrmUrun_Masraf_Merkezi.txtUrunKoduButtonClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad:String;
begin
  if not (Qry_Netsis_Aktarma.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_AD,True) then
  begin
     Qry_Netsis_Aktarma.FieldByName('URUN_KOD').AsString := Urun_Kod;
     Qry_Netsis_Aktarma.FieldByName('URUN_AD').AsString := Urun_Ad;
  end;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit3Enter(Sender: TObject);
begin
  (Sender as TIb_Edit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit3Exit(Sender: TObject);
begin
    IB_Edit3.Color := clWindow;
end;

procedure TfrmUrun_Masraf_Merkezi.txtUrunKoduExit(Sender: TObject);
var
  UrunAd : String;
begin
  if Length(Trim(txtUrunKodu.Text))=0 then
  begin
    txtUrunKodu.Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',txtUrunKodu.Text,UrunAd)) then
  begin
    Application.MessageBox('Ürün Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    txtUrunKodu.Clear;
    txtUrunKodu.SetFocus;
  end
  else
  begin
    txtUrunKodu.Color := clWindow;
  end;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit1ButtonClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad:String;
begin
  if not (Qry_Netsis_Aktarma.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_AD,True) then
  begin
     Qry_Netsis_Aktarma.FieldByName('YENI_URUN_KOD').AsString := Urun_Kod;
     Qry_Netsis_Aktarma.FieldByName('YENI_URUN_AD').AsString := Urun_Ad;
  end;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit1Exit(Sender: TObject);
var
  UrunAd : String;
begin
  if Length(Trim(IB_Edit1.Text))=0 then
  begin
    txtUrunKodu.Color := clWindow;
    exit;
  end;
  if not (DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',IB_Edit1.Text,UrunAd)) then
  begin
    Application.MessageBox('Ürün Kodu bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    IB_Edit1.Clear;
    IB_Edit1.SetFocus;
  end
  else
  begin
    IB_Edit1.Color := clWindow;
  end;
end;

procedure TfrmUrun_Masraf_Merkezi.btnYeniClick(Sender: TObject);
begin
     Qry_Netsis_Aktarma.Append;
end;

procedure TfrmUrun_Masraf_Merkezi.btnKaydetClick(Sender: TObject);
var
   FuncDeger:String;
begin

  FuncDeger:=DataMod.Before_Post_Kontrol(Qry_Netsis_Aktarma,'NETSIS_AKTARMA','ID,URUN_KOD,MASRAF_MERKEZI,YENI_URUN_KOD','ID');
  if funcDeger<> '' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if Qry_Netsis_Aktarma.State in [DssEdit,DssInsert] then
  Qry_Netsis_Aktarma.Post;


end;

procedure TfrmUrun_Masraf_Merkezi.btnIPTALClick(Sender: TObject);
begin
     Qry_Netsis_Aktarma.Cancel;
end;

procedure TfrmUrun_Masraf_Merkezi.btnSilClick(Sender: TObject);
begin
     Qry_Netsis_Aktarma.Delete;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit5ButtonClick(Sender: TObject);
begin
  if not (Qry_Netsis_Aktarma.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    Qry_Netsis_Aktarma.FieldByName('MASRAF_MERKEZI').AsString := Muh_Kod;
  end;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit5Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit5.Text)) = 0 then
  begin
    IB_Edit5.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit5,nil,0) then
  begin
    IB_Edit5.Color := clWindow;
  end
  else
  begin
    IB_Edit5.SetFocus;
  end;
    IB_Edit5.Color := clWindow;
end;

procedure TfrmUrun_Masraf_Merkezi.txtUrunKoduKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmUrun_Masraf_Merkezi.txtUrunKoduKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txtUrunKoduButtonClick(Self);
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then IB_Edit1ButtonClick(Self);
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then IB_Edit5ButtonClick(Self);
end;

procedure TfrmUrun_Masraf_Merkezi.txtUrunKoduEnter(Sender: TObject);
begin
    txtUrunKodu.Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit5Enter(Sender: TObject);
begin
    IB_Edit5.Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrun_Masraf_Merkezi.IB_Edit1Enter(Sender: TObject);
begin
    IB_Edit1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmUrun_Masraf_Merkezi.Button1Click(Sender: TObject);
begin
     Qry_Netsis_Aktarma.Edit;
end;

end.
