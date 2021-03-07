unit ufrmKullaniciTanimlama;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, IB_Controls, IB_Components, Grids, IB_Grid,
  ComCtrls;

type
  Tfrm_Kullanici_Tanimlama = class(TForm)
    Panel1: TPanel;
    btnCikis: TBitBtn;
    qry_Kullanici: TIB_Query;
    dts_Kullanici: TIB_DataSource;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    qrySUBE: TIB_Query;
    dtsSUBE: TIB_DataSource;
    dtsSIRKET: TIB_DataSource;
    qrySIRKET: TIB_Query;
    qrySIRKETHAK: TIB_Query;
    dtsSIRKETHAK: TIB_DataSource;
    qryHAKDEL: TIB_Query;
    qryHAKINS: TIB_Query;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    txtSifre: TIB_Edit;
    txtTekrarSifre: TEdit;
    IB_CheckBox1: TIB_CheckBox;
    cboSUBE: TIB_LookupCombo;
    grdKULLANICI: TIB_Grid;
    qrySIRKETDONEM: TIB_Query;
    dtsSIRKETDONEM: TIB_DataSource;
    qryDONEMHAK: TIB_Query;
    dtsDONEMHAK: TIB_DataSource;
    qryDONEMINS: TIB_Query;
    qryDONEMDEL: TIB_Query;
    IB_CheckBox4: TIB_CheckBox;
    qrySrkKasa: TIB_Query;
    dtsSrkKasa: TIB_DataSource;
    qryKulKasa: TIB_Query;
    dtsKulKasa: TIB_DataSource;
    qryKASAINS: TIB_Query;
    qryKASADEL: TIB_Query;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    grdSirket: TIB_Grid;
    GroupBox4: TGroupBox;
    grdHakSirket: TIB_Grid;
    btnSirketEkle: TButton;
    btnSirketSil: TButton;
    btnSrktInsAll: TButton;
    btnSrktDelAll: TButton;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    grdDonem: TIB_Grid;
    GroupBox8: TGroupBox;
    grdHakDonem: TIB_Grid;
    btnDonemEkle: TButton;
    btnDonemSil: TButton;
    btnDnmInsAll: TButton;
    btnDnmDelAll: TButton;
    grpKasaKisit: TGroupBox;
    GroupBox11: TGroupBox;
    grdSrkKasa: TIB_Grid;
    GroupBox12: TGroupBox;
    grdKulKasa: TIB_Grid;
    btnKasaEkle: TButton;
    btnKasaSil: TButton;
    Button3: TButton;
    Button4: TButton;
    btnVarsayilan: TButton;
//****************************************************************************//
    function Form_Open(Menu:Boolean):Integer;
//****************************************************************************//
    procedure qry_KullaniciAfterInsert(IB_Dataset: TIB_Dataset);
    procedure qry_KullaniciBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qry_KullaniciBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure txtTekrarSifreExit(Sender: TObject);
    procedure txtTekrarSifreEnter(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure qry_KullaniciAfterScroll(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure dts_KullaniciStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure IB_Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnSirketEkleClick(Sender: TObject);
    procedure btnSirketSilClick(Sender: TObject);
    procedure btnSrktInsAllClick(Sender: TObject);
    procedure btnSrktDelAllClick(Sender: TObject);
    procedure qrySIRKETHAKAfterScroll(IB_Dataset: TIB_Dataset);
    procedure btnDonemEkleClick(Sender: TObject);
    procedure btnDonemSilClick(Sender: TObject);
    procedure btnDnmInsAllClick(Sender: TObject);
    procedure btnDnmDelAllClick(Sender: TObject);
    procedure btnKasaEkleClick(Sender: TObject);
    procedure btnKasaSilClick(Sender: TObject);
    procedure btnVarsayilanClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
  private
    my_Active_Comp:TWinControl;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Kullanici_Tanimlama: Tfrm_Kullanici_Tanimlama;

implementation
uses unDataMod,unFunc;
{$R *.DFM}

{ Tfrm_Kullanici_Tanimlama }

function Tfrm_Kullanici_Tanimlama.Form_Open(Menu: Boolean): Integer;
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Application.CreateForm(Tfrm_Kullanici_Tanimlama,frm_Kullanici_Tanimlama);
  with frm_Kullanici_Tanimlama do
  begin
    if glb_SUBELI then
    begin
      with qrySUBE do
      begin
        Close;
        ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
        Open;
      end;
      cboSUBE.Visible := True;
    end
    else
    begin
      cboSUBE.Visible := False;
    end;
    qry_Kullanici.Active := True;
//****************************************************************************//
    if glb_KASA_KISIT_UYG then
       grpKasaKisit.Visible := True
    else
       grpKasaKisit.Visible := False;
//****************************************************************************//
    PageControl1.ActivePageIndex := 0;
    ShowModal;
    qry_Kullanici.Active := False;
    qrySIRKET.Active := False;
    qrySIRKETHAK.Active := False;
    Release;
  end;
end;

procedure Tfrm_Kullanici_Tanimlama.qry_KullaniciAfterInsert(IB_Dataset: TIB_Dataset);
begin
  qry_Kullanici.FieldByName('KULLANICI_SID').AsInteger := glb_SID;
  qry_Kullanici.FieldByName('SUBE_ID').AsInteger := glb_SID;
end;

procedure Tfrm_Kullanici_Tanimlama.qry_KullaniciBeforeDelete(IB_Dataset: TIB_Dataset);
begin
  if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Abort;
end;

procedure Tfrm_Kullanici_Tanimlama.qry_KullaniciBeforePost(IB_Dataset: TIB_Dataset);
var
  qryUser : TIB_Query;
begin
  if Length(qry_Kullanici.FieldByName('PASS_WORD').AsString) < 5 then
  begin
    Application.MessageBox('Verdiðiniz þifre beþ karakterden az olamaz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;

  if (qry_Kullanici.State in [dssInsert]) then
  begin
    if (txtSifre.Text<>txtTekrarSifre.Text) then
    begin
      Application.MessageBox('Þifreyi kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
      Abort;
    end;
////////////////////////////////////////////////////////////////////////////////
    try
      DataMod.CreateQuery(qryUser,nil,False,datamod.dbaANA);
      with qryUser do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT KULLANICI_ID FROM KULLANICI WHERE USER_NAME=' + SQL_Katar(qry_Kullanici.FieldByName('USER_NAME').AsString)
              + ' AND KULLANICI.KULLANICI_SID=' + qry_Kullanici.FieldByName('KULLANICI_SID').AsString);
        Active := True;
      end;
      if not ((qryUser.Bof) and (qryUser.Eof)) then
      begin
        Application.MessageBox('Kullanýcý Adýný Deðiþtirip Tekrar Yazýnýz.','Dikkat',MB_ICONWARNING);
        IB_Edit2.Text := '';
        IB_Edit2.SetFocus;
        Abort;
      end;
    finally
      DataMod.ReleaseQuery(qryUser);
    end;
////////////////////////////////////////////////////////////////////////////////
  end;
end;

procedure Tfrm_Kullanici_Tanimlama.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure Tfrm_Kullanici_Tanimlama.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz deðiþiklikleri kaydeniz yada iptal ediniz.','Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure Tfrm_Kullanici_Tanimlama.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure Tfrm_Kullanici_Tanimlama.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure Tfrm_Kullanici_Tanimlama.txtTekrarSifreExit(Sender: TObject);
begin
  txtTekrarSifre.Color := clWindow;
end;

procedure Tfrm_Kullanici_Tanimlama.txtTekrarSifreEnter(Sender: TObject);
begin
  txtTekrarSifre.Color := clAqua;
end;

procedure Tfrm_Kullanici_Tanimlama.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Kullanici_Tanimlama.qry_KullaniciAfterScroll(IB_Dataset: TIB_Dataset);
begin
  txtTekrarSifre.Text := '';
//****************************************************************************//
  with qrySIRKET do
  begin
    Close;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    Open;
  end;
//****************************************************************************//
  with qrySIRKETHAK do
  begin
    Close;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    Open;
  end;
//****************************************************************************//
  with qrySrkKasa do
  begin
    Close;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    Open;
  end;
//****************************************************************************//
  with qryKulKasa do
  begin
    Close;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    Open;
  end;
//****************************************************************************//
  frm_Kullanici_Tanimlama.Caption := 'Kullanýcý Tanýmlama ve Düzenleme Ýþlemleri - '+qry_Kullanici.FieldByName('AD_SOY').AsString;
end;

procedure Tfrm_Kullanici_Tanimlama.btnYeniClick(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  IB_Edit1.SetFocus;
  qry_Kullanici.Append;
end;

procedure Tfrm_Kullanici_Tanimlama.btnKaydetClick(Sender: TObject);
begin
  if qry_Kullanici.FieldByName('SUBE_ID').IsNull then
  begin
    Application.MessageBox('Lütfen kullanýcýnýn baðlý oldugu subeyi seçiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  qry_Kullanici.Post;
end;

procedure Tfrm_Kullanici_Tanimlama.btnIPTALClick(Sender: TObject);
begin
  qry_Kullanici.Cancel;
end;

procedure Tfrm_Kullanici_Tanimlama.btnSilClick(Sender: TObject);
begin
  qry_Kullanici.Delete;
end;

procedure Tfrm_Kullanici_Tanimlama.dts_KullaniciStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
    grdKULLANICI.Enabled := False;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if not ((ADataset.Eof) and (ADataset.Bof)) then btnSil.Enabled := True
    else btnSil.Enabled := False;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
    grdKULLANICI.Enabled := True;
  end;
end;

procedure Tfrm_Kullanici_Tanimlama.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    case Key of
    83: //s kaydet
      begin
        if btnKAYDET.Enabled then btnKAYDETClick(Self);
      end; //83 end
    80: //p iptal
      begin
        if btnIptal.Enabled Then btnIptalClick(Self);
      end;
    46: // del delete
      begin
        if btnSIL.Enabled Then btnSILClick(self);
      end;
    end; // case end;
  end//Shift = [ssCtrl] then end
  else
  if Shift = [] then
  begin
    case Key of
    45: //ins kaydet
      begin
        if btnYeni.Enabled then btnYeniClick(Self);
      end;
    VK_ESCAPE: if btnCikis.Enabled then Close;
    end;//acase end
  end; ///if Shift = [] then ENd
end;

procedure Tfrm_Kullanici_Tanimlama.IB_Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure Tfrm_Kullanici_Tanimlama.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frm_Kullanici_Tanimlama);
  TabSheet3.TabVisible:=False;
  TabSheet4.TabVisible:=False;
end;

procedure Tfrm_Kullanici_Tanimlama.btnSirketEkleClick(Sender: TObject);
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden þirket atayamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qrySIRKET.RecordCount = 0 then
  begin
    Application.MessageBox('Eklenilecek þirket bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  with qryHAKINS do
  begin
    Close;
    ParamByName('PRM_SIRKET_ID').AsInteger := qrySIRKET.FieldByName('SIRKET_ID').AsInteger;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    Execute;
  end;
  qrySIRKET.Refresh;
  qrySIRKETHAK.Refresh;
  qrySIRKETHAK.First;
  
end;

procedure Tfrm_Kullanici_Tanimlama.btnSirketSilClick(Sender: TObject);
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden þirket silemezsiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qrySIRKETHAK.RecordCount = 0 then
  begin
    Application.MessageBox('Silinecek þirket bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  with qryHAKDEL do
  begin
    Close;
    ParamByName('PRM_SIRKET_ID').AsInteger := qrySIRKETHAK.FieldByName('SIRKET_ID').AsInteger;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qrySIRKETHAK.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qrySIRKETHAK.FieldByName('KULLANICI_SID').AsSmallint;
    Execute;
  end;
  qrySIRKET.Refresh;
  qrySIRKETHAK.Refresh;
  qrySIRKET.First;
end;

procedure Tfrm_Kullanici_Tanimlama.btnSrktInsAllClick(Sender: TObject);
var
  qryEkle : TIB_Query;
  strSQL : String;
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden þirket atayamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qrySIRKET.RecordCount = 0 then
  begin
    Application.MessageBox('Eklenilecek þirket bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataMod.CreateQuery(qryEkle,nil,False,DataMod.dbaANA);
  qrySIRKET.First;
  repeat
    strSQL := 'INSERT INTO SIRKETHAK (SIRKET_ID,KULLANICI_ID,KULLANICI_SID) VALUES ('
              +qrySIRKET.FieldByName('SIRKET_ID').AsString+','
              +qry_Kullanici.FieldByName('KULLANICI_ID').AsString+','
              +qry_Kullanici.FieldByName('KULLANICI_SID').AsString+')';
    with qryEkle do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Execute;
    end;
    qrySIRKET.Next;
  until qrySIRKET.Eof;
  DataMod.ReleaseQuery(qryEkle);
  qrySIRKET.Refresh;
  qrySIRKETHAK.Refresh;
  qrySIRKETHAK.First;
end;

procedure Tfrm_Kullanici_Tanimlama.btnSrktDelAllClick(Sender: TObject);
var
  qrySil : TIB_Query;
  strSQL : String;
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden þirket silemezsiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qrySIRKETHAK.RecordCount = 0 then
  begin
    Application.MessageBox('Silinecek þirket bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataMod.CreateQuery(qrySil,nil,False,DataMod.dbaANA);
  qrySIRKETHAK.First;
  repeat
    strSQL := 'DELETE FROM SIRKETHAK WHERE KULLANICI_ID = '+qry_Kullanici.FieldByName('KULLANICI_ID').AsString
             +' AND KULLANICI_SID = '+qry_Kullanici.FieldByName('KULLANICI_SID').AsString;
    with qrySil do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Execute;
    end;
    qrySIRKETHAK.Next;
  until qrySIRKETHAK.Eof;
  DataMod.ReleaseQuery(qrySil);
  qrySIRKET.Refresh;
  qrySIRKET.First;
  qrySIRKETHAK.Refresh;
end;

procedure Tfrm_Kullanici_Tanimlama.qrySIRKETHAKAfterScroll(IB_Dataset: TIB_Dataset);
begin
  with qrySIRKETDONEM do
  begin
    Close;
    ParamByName('PRM_SIRKET_ID').AsInteger := qrySIRKETHAK.FieldByName('SIRKET_ID').AsInteger;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_SID').AsInteger;
    Open;
  end;

  with qryDONEMHAK do
  begin
    Close;
    ParamByName('PRM_SIRKET_ID').AsInteger := qrySIRKETHAK.FieldByName('SIRKET_ID').AsInteger;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_SID').AsInteger;
    Open;
  end;

end;

procedure Tfrm_Kullanici_Tanimlama.btnDonemEkleClick(Sender: TObject);
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden dönem atayamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qrySIRKETDONEM.RecordCount = 0 then
  begin
    Application.MessageBox('Eklenilecek dönem bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  with qryDONEMINS do
  begin
    Close;
    ParamByName('PRM_SIRKET_ID').AsInteger := qrySIRKETHAK.FieldByName('SIRKET_ID').AsInteger;
    ParamByName('PRM_DONEM_NO').AsInteger := qrySIRKETDONEM.FieldByName('DONEM_NO').AsInteger;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    Execute;
  end;
  qrySIRKETDONEM.Refresh;
  qryDONEMHAK.Refresh;
  qryDONEMHAK.First;
end;

procedure Tfrm_Kullanici_Tanimlama.btnDonemSilClick(Sender: TObject);
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden dönem silemezsiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryDONEMHAK.RecordCount = 0 then
  begin
    Application.MessageBox('Silinecek dönem bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  with qryDONEMDEL do
  begin
    Close;
    ParamByName('PRM_SIRKET_ID').AsInteger := qrySIRKETHAK.FieldByName('SIRKET_ID').AsInteger;
    ParamByName('PRM_DONEM_NO').AsInteger := qryDONEMHAK.FieldByName('DONEM_NO').AsInteger;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    Execute;
  end;
  qrySIRKETDONEM.Refresh;
  qryDONEMHAK.Refresh;
  qrySIRKETDONEM.First;
end;

procedure Tfrm_Kullanici_Tanimlama.btnDnmInsAllClick(Sender: TObject);
var
  qryEkle : TIB_Query;
  strSQL : String;
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden dönem atayamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qrySIRKETDONEM.RecordCount = 0 then
  begin
    Application.MessageBox('Eklenilecek dönem bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataMod.CreateQuery(qryEkle,nil,False,DataMod.dbaANA);
  qrySIRKETDONEM.First;
  repeat
    strSQL := 'INSERT INTO DONEMHAK (SIRKET_ID,DONEM_NO,KULLANICI_ID,KULLANICI_SID) VALUES ('
              +qrySIRKETHAK.FieldByName('SIRKET_ID').AsString+','
              + qrySIRKETDONEM.FieldByName('DONEM_NO').AsString+','
              +qry_Kullanici.FieldByName('KULLANICI_ID').AsString+','
              +qry_Kullanici.FieldByName('KULLANICI_SID').AsString+')';
    with qryEkle do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Execute;
    end;
    qrySIRKETDONEM.Next;
  until qrySIRKETDONEM.Eof;
  DataMod.ReleaseQuery(qryEkle);
  qrySIRKETDONEM.Refresh;
  qryDONEMHAK.Refresh;
  qryDONEMHAK.First;
end;

procedure Tfrm_Kullanici_Tanimlama.btnDnmDelAllClick(Sender: TObject);
var
  qrySil : TIB_Query;
  strSQL : String;
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden dönem silemezsiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryDONEMHAK.RecordCount = 0 then
  begin
    Application.MessageBox('Silinecek dönem bulunamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataMod.CreateQuery(qrySil,nil,False,DataMod.dbaANA);
  qryDONEMHAK.First;
  repeat
    strSQL := 'DELETE FROM DONEMHAK WHERE '
            + ' SIRKET_ID = ' +  qrySIRKETHAK.FieldByName('SIRKET_ID').AsString
            + ' AND DONEM_NO = ' + qryDONEMHAK.FieldByName('DONEM_NO').AsString
            + ' AND KULLANICI_ID = ' + qry_Kullanici.FieldByName('KULLANICI_ID').AsString
            + ' AND KULLANICI_SID = ' + qry_Kullanici.FieldByName('KULLANICI_SID').AsString;
    with qrySil do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Execute;
    end;
    qryDONEMHAK.Next;
  until qryDONEMHAK.Eof;
  DataMod.ReleaseQuery(qrySil);
  qrySIRKETDONEM.Refresh;
  qryDONEMHAK.Refresh;
  qrySIRKETDONEM.First;
end;

procedure Tfrm_Kullanici_Tanimlama.btnKasaEkleClick(Sender: TObject);
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden kasa atayamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qrySrkKasa.RecordCount = 0 then
  begin
    exit;
  end;

  with qryKASAINS do
  begin
    Close;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    ParamByName('PRM_KASA_SID').AsSmallint := qrySrkKasa.FieldByName('KASA_SID').AsSmallint;
    ParamByName('PRM_KASA_KOD').AsString := qrySrkKasa.FieldByName('KASA_KOD').AsString;
    ParamByName('PRM_VARSAYILAN').AsSmallint := 0;
    Execute;
  end;

  qrySrkKasa.Refresh;
  qryKulKasa.Refresh;
  qryKulKasa.First;

end;

procedure Tfrm_Kullanici_Tanimlama.btnKasaSilClick(Sender: TObject);
begin
  if qry_Kullanici.State in [dssEdit,dssInsert] then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden kasa atayamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryKulKasa.RecordCount = 0 then
  begin
    exit;
  end;

  with qryKASADEL do
  begin
    Close;
    ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
    ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
    ParamByName('PRM_KASA_SID').AsSmallint := qryKulKasa.FieldByName('KASA_SID').AsSmallint;
    ParamByName('PRM_KASA_KOD').AsString := qryKulKasa.FieldByName('KASA_KOD').AsString;
    Execute;
  end;
  qryKulKasa.Refresh;
  qrySrkKasa.Refresh;
  qrySrkKasa.First;
end;

procedure Tfrm_Kullanici_Tanimlama.btnVarsayilanClick(Sender: TObject);
var
  qryUpdate : TIB_Query;
  strSQL : String;
begin
  if qryKulKasa.RecordCount = 0 then
  begin
    Application.MessageBox('Olmayan bir kasayý varsayýlan kasa olarak atayamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateQuery(qryUpdate,nil,False,DataMod.dbaMain);

  strSQL := 'UPDATE KASAHAK SET VARSAYILAN = 0 WHERE '
          + ' (KULLANICI_ID = ' + qry_Kullanici.FieldByName('KULLANICI_ID').AsString + ')'
          + ' AND (KULLANICI_SID = '+ qry_Kullanici.FieldByName('KULLANICI_SID').AsString +')';
          
  with qryUpdate do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Execute;
  end;

  strSQL := 'UPDATE KASAHAK SET VARSAYILAN = 1 WHERE '
          + ' (KULLANICI_ID = ' + qry_Kullanici.FieldByName('KULLANICI_ID').AsString + ')'
          + ' AND (KULLANICI_SID = '+ qry_Kullanici.FieldByName('KULLANICI_SID').AsString +')'
          + ' AND (KASA_KOD = '+ SQL_Katar(qryKulKasa.FieldByName('KASA_KOD').AsString)+')'
          + ' AND (KASA_SID = '+ qryKulKasa.FieldByName('KASA_SID').AsString + ')';

  with qryUpdate do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Execute;
  end;

  qryKulKasa.Refresh;

end;

procedure Tfrm_Kullanici_Tanimlama.Button4Click(Sender: TObject);
begin
  if qryKulKasa.RecordCount <> 0 then
  begin
    qryKulKasa.First;
    repeat
      with qryKASADEL do
      begin
        Close;
        ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
        ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
        ParamByName('PRM_KASA_SID').AsSmallint := qryKulKasa.FieldByName('KASA_SID').AsSmallint;
        ParamByName('PRM_KASA_KOD').AsString := qryKulKasa.FieldByName('KASA_KOD').AsString;
        Execute;
      end;
      qryKulKasa.Next;
    until qryKulKasa.Eof;
    qryKulKasa.Refresh;
    qrySrkKasa.Refresh;
    qrySrkKasa.First;
  end;
end;

procedure Tfrm_Kullanici_Tanimlama.Button3Click(Sender: TObject);
begin
  if qrySrkKasa.RecordCount <> 0 then
  begin
    qrySrkKasa.First;
    repeat
      with qryKASAINS do
      begin
        Close;
        ParamByName('PRM_KULLANICI_ID').AsInteger := qry_Kullanici.FieldByName('KULLANICI_ID').AsInteger;
        ParamByName('PRM_KULLANICI_SID').AsSmallint := qry_Kullanici.FieldByName('KULLANICI_SID').AsSmallint;
        ParamByName('PRM_KASA_SID').AsSmallint := qrySrkKasa.FieldByName('KASA_SID').AsSmallint;
        ParamByName('PRM_KASA_KOD').AsString := qrySrkKasa.FieldByName('KASA_KOD').AsString;
        ParamByName('PRM_VARSAYILAN').AsSmallint := 0;
        Execute;
      end;
      qrySrkKasa.Next;
    until qrySrkKasa.Eof;
    qrySrkKasa.Refresh;
    qryKulKasa.Refresh;
    qryKulKasa.First;
  end;
end;

procedure Tfrm_Kullanici_Tanimlama.PageControl1Changing(Sender: TObject;  var AllowChange: Boolean);
var
  Buldum : Boolean;
begin
  case PageControl1.ActivePageIndex of
  0:
    begin
      if qry_Kullanici.State in [dssEdit,dssInsert] then
      begin
        Application.MessageBox('Yaptýðýnýz iþlemleri kaydetmeden diðer bölüme geçemezsiniz.','Dikkat',MB_ICONWARNING);
        AllowChange := False;
      end;
    end;
  2:
    begin
      Buldum := False;
      qryKulKasa.DisableControls;
      qryKulKasa.First;
      while not qryKulKasa.Eof do
      begin
        if qryKulKasa.FieldByName('VARSAYILAN').AsInteger = 1 then Buldum := True;
        qryKulKasa.Next;
      end;
      if not buldum then AllowChange := False;
    end;
  end;

end;

end.
