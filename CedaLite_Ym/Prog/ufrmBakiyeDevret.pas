unit ufrmBakiyeDevret;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, ExtCtrls, Grids, IB_Grid, IB_Process,
  IB_Script;

type
  TfrmBakiyeDevret = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    IB_Grid2: TIB_Grid;
    Panel1: TPanel;
    btnCikis: TButton;
    btnAktar: TButton;
    qryHedef: TIB_Query;
    dtsHedef: TIB_DataSource;
    qrySIRKET: TIB_Query;
    qryKaynak: TIB_Query;
    dtsSIRKET: TIB_DataSource;
    dtsKaynak: TIB_DataSource;
    GroupBox3: TGroupBox;
    IB_Grid1: TIB_Grid;
    IB_Grid3: TIB_Grid;
    dbaHedef: TIB_Connection;
    scriptBakiye: TIB_Script;
    dbaKaynak: TIB_Connection;
    trnHedef: TIB_Transaction;
    MemoCikti: TMemo;
    GroupBox4: TGroupBox;
    chkUrun: TCheckBox;
    chkCari: TCheckBox;
    chkMasraf: TCheckBox;
    chkKasa: TCheckBox;
    GroupBox5: TGroupBox;
    chkCariRst: TCheckBox;
    chkUrunRst: TCheckBox;
    chkMasrafRst: TCheckBox;
    chkKasaRst: TCheckBox;
    btnSifirla: TButton;
    trnKaynak: TIB_Transaction;
    chk_Plasiyer: TCheckBox;
    chk_Proje: TCheckBox;
    chkProjeRst: TCheckBox;
    chkPlasiyerRst: TCheckBox;
    chk_Arac: TCheckBox;
    chk_Personel: TCheckBox;
    CheckBox3: TCheckBox;
    chkAracRst: TCheckBox;
    chkPersonelRst: TCheckBox;
    qryHedef1: TIB_Query;
    cb_Karsi: TCheckBox;
//****************************************************************************//
    function Form_Open:Boolean;
//****************************************************************************//
    function SetConnection(Cn:TIB_Connection;ConnLocal:Boolean;ServerName,DbName,UserName,Password: String): Boolean;
//****************************************************************************//
    function CariMuhaskodKarsilastir():Boolean;
    function MasrafMuhaskodKarsilastir():Boolean;
    function UrunKarsilastir():Boolean;
    function KasaKarsilastir():Boolean;

    function ProjeKarsilastir: Boolean;
    function PlasiyerKarsilastir: Boolean;
    function AracKarsilastir: Boolean;
    function PersonelKarsilastir: Boolean;

    function TutarHesapla(var PRM_TUTAR : Currency):Boolean;

//****************************************************************************//
    procedure btnSifirlaClick(Sender: TObject);
    procedure btnAktarClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//****************************************************************************//
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_bakiye_devret = 19;
var
  frmBakiyeDevret: TfrmBakiyeDevret;

implementation

uses unDataMod,unFunc,Main, DateUtils, unDmYonet, ufrmDevirSifre;

{$R *.dfm}

{ TfrmBakiyeDevret }

procedure TfrmBakiyeDevret.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[ssCtrl,ssAlt,ssShift] then
begin
  if key=VK_SPACE then
  begin
    frmDevirSifre.ShowModal;
    if frmDevirSifre.ModalResult=MrOk then
    begin
         btnAktar.Visible:=True;
         //btnDonemDevir.Visible:=True;
    end;
    //frmDevirSifre.Release;

  end;
end;
end;

function TfrmBakiyeDevret.Form_Open: Boolean;
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_bakiye_devret,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005'))=0 then
    begin
      Application.MessageBox('Yeni dönem üzerinden bakiye aktarým iþlemi yapýlamaz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    Application.CreateForm(TfrmBakiyeDevret,frmBakiyeDevret);
    with frmBakiyeDevret do
    begin
      with qrySIRKET do
      begin
        ParamByName('PRM_KULLANICI_ID').AsInteger := glb_USER_ID;
        ParamByName('PRM_KULLANICI_SID').AsSmallint := glb_USER_SID;
        Active := True;
      end;
      qryKaynak.Active := True;
      qryHedef.Active := True;
      ShowModal;
      qryHedef.Active := False;
      qryKaynak.Active := False;
      qrySIRKET.Active := False;
      Release;
    end;
  end;
end;

function TfrmBakiyeDevret.SetConnection(Cn:TIB_Connection;ConnLocal:Boolean;ServerName,DbName,UserName,Password: String): Boolean;
begin
  try
    DataMod.AssignConnProps(Cn,ConnLocal,ServerName,DbName,UserName,Password);
    if not Cn.Connected then
       Cn.Connected := True;
  except
    Result := False;
    exit;
  end;
  Result := True;
end;


procedure TfrmBakiyeDevret.btnAktarClick(Sender: TObject);
begin
 { if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005'))=0 then
  begin
    Application.MessageBox('Yeni dönem üzerinden bakiye aktarým iþlemi yapýlamaz.','Dikkat',MB_ICONWARNING);
    exit;
  end;  }
MemoCikti.Lines.Clear;
  if qryKaynak.FieldByName('DONEM_NO').AsInteger=qryHedef.FieldByName('DONEM_NO').AsInteger then
  begin
      Application.MessageBox('Farklý Dönemler Seçiniz.','Dikkat',MB_ICONWARNING);
      Exit;
  end;

//****************************************************************************//
  if qryKaynak.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönem olmadan karþýlaþtýrma iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if qryHedef.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönem olmadan karþýlaþtýrma iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if not SetConnection(dbaKaynak,
                       qryKaynak.FieldByName('CONN_LOCAL').AsBoolean,
                       qryKaynak.FieldByName('SERVER_NAME').AsString,
                       qryKaynak.FieldByName('DB_PATH').AsString,
                       qryKaynak.FieldByName('USER_NAME').AsString,
                       qryKaynak.FieldByName('PASS_WORD').AsString) then
  begin
    Application.MessageBox('Kaynak database baðlantýsý yapýlamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if not SetConnection(dbaHedef,
                       qryHedef.FieldByName('CONN_LOCAL').AsBoolean,
                       qryHedef.FieldByName('SERVER_NAME').AsString,
                       qryHedef.FieldByName('DB_PATH').AsString,
                       qryHedef.FieldByName('USER_NAME').AsString,
                       qryHedef.FieldByName('PASS_WORD').AsString) then
  begin
    Application.MessageBox('Hedef database baðlantýsý yapýlamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DmYonet.Donem_Bas:=qryHedef.FieldByName('DONEM_BAS').AsString;
  DmYonet.Donem_Son:=qryHedef.FieldByName('DONEM_SON').AsString;
//****************************************************************************//
  MemoCikti.Clear;
//****************************************************************************//
  if cb_Karsi.Checked then
  begin


  if chkCari.Checked then
  begin
    if not CariMuhaskodKarsilastir then
    begin
      Application.MessageBox('Gerekli düzeltmeleri yaparak aktarým iþlemini tekrar deneyiniz.','Cari ve Muhasebe Kodu karþýlaþtýrma - Aktarým yapýlmadý.',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//
  if chkUrun.Checked then
  begin
    if not UrunKarsilastir then
    begin
      Application.MessageBox('Gerekli düzeltmeleri yaparak aktarým iþlemini tekrar deneyiniz.','Ürün Kodu karþýlaþtýrma - Aktarým yapýlmadý.',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//
  if chkKasa.Checked then
  begin
    if not KasaKarsilastir then
    begin
      Application.MessageBox('Gerekli düzeltmeleri yaparak aktarým iþlemini tekrar deneyiniz.','Kasa ve Muhasebe Kodu karþýlaþtýrma - Aktarým yapýlmadý.',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//
  if chkMasraf.Checked then
  begin
    if not MasrafMuhaskodKarsilastir then
    begin
      Application.MessageBox('Gerekli düzeltmeleri yaparak aktarým iþlemini tekrar deneyiniz.','Masraf ve Muhasebe Kodu karþýlaþtýrma - Aktarým yapýlmadý.',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//



//****************************************************************************//
  if chk_Proje.Checked then
  begin
    if not ProjeKarsilastir then
    begin
      Application.MessageBox('Gerekli düzeltmeleri yaparak aktarým iþlemini tekrar deneyiniz.','Proje kodu karþýlaþtýrma - Aktarým yapýlmadý.',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//

//****************************************************************************//
  if chk_Plasiyer.Checked then
  begin
    if not PlasiyerKarsilastir then
    begin
      Application.MessageBox('Gerekli düzeltmeleri yaparak aktarým iþlemini tekrar deneyiniz.','Plasiyer kodu karþýlaþtýrma - Aktarým yapýlmadý.',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//


//****************************************************************************//
  if chk_Arac.Checked then
  begin
    if not AracKarsilastir then
    begin
      Application.MessageBox('Gerekli düzeltmeleri yaparak aktarým iþlemini tekrar deneyiniz.','Araç kodu karþýlaþtýrma - Aktarým yapýlmadý.',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//


//****************************************************************************//
  if chk_Personel.Checked then
  begin
    if not PersonelKarsilastir then
    begin
      Application.MessageBox('Gerekli düzeltmeleri yaparak aktarým iþlemini tekrar deneyiniz.','Personel kodu karþýlaþtýrma - Aktarým yapýlmadý.',MB_ICONWARNING);
      exit;
    end;
  end;
//****************************************************************************//


  end;// karsi

  if Application.MessageBox('Aktarým iþlemine baþlamak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO) = ID_NO then exit;
//****************************************************************************//
  try
    try
      if trnHedef.InTransaction then
         trnHedef.Rollback;
      trnHedef.StartTransaction;
//****************************************************************************//
      //Application.MessageBox('Sýfýrlama basladý.','Dikkat',MB_ICONERROR);
      if not DmYonet.UpdateTablesSetSifir(scriptBakiye,chkCariRst.Checked,chkUrunRst.Checked,chkMasrafRst.Checked,chkKasaRst.Checked,chkProjeRst.Checked,chkPlasiyerRst.Checked,chkAracRst.Checked,chkPersonelRst.Checked) then
      begin
        Application.MessageBox('UpdateTablesSetSifir iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        trnHedef.Rollback;
        exit;
      end;
//****************************************************************************//
     if chkCari.Checked then
      begin
      //Application.MessageBox('Cari basladý.','Dikkat',MB_ICONERROR);
        if not DmYonet.CopyCariMuhfisDevToTerm(scriptBakiye,dbaKaynak) then
        begin
          Application.MessageBox('Cari update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
          trnHedef.Rollback;
          exit;
        end;


//****************************************************************************//
      //sadece bankalar aktarýlýyor.
      if not DmYonet.CopyCariDovDevToTerm(scriptBakiye,dbaKaynak,dbaHedef) then
      begin
        Application.MessageBox('CariDov update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        trnHedef.Rollback;
        exit;
      end;

      end;

//****************************************************************************//
      if chkUrun.Checked then
      begin
        if not DmYonet.CopyUrunDevToTerm(scriptBakiye,dbaKaynak) then
        begin
          Application.MessageBox('Urun update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
          trnHedef.Rollback;
          exit;
        end;

        if not DmYonet.CopyDepoUrunDevToTerm(scriptBakiye,dbaKaynak) then
        begin
          Application.MessageBox('DepoUrun update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
          trnHedef.Rollback;
          exit;
        end;
      end;

//****************************************************************************//
      if chkMasraf.Checked then
      begin
//        if not DmYonet.CopyMasrafMuhFisDevToTerm(scriptBakiye,dbaKaynak) then
        if not DmYonet.CopyMasrafDevToTerm(scriptBakiye,dbaKaynak) then
        begin
          Application.MessageBox('Masraf update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
          trnHedef.Rollback;
          exit;
        end;
      end;

//****************************************************************************//

      if chkKasa.Checked then
      begin
        if not DmYonet.CopyKasaDevToTerm(scriptBakiye,dbaKaynak) then
        begin
          Application.MessageBox('Kasa update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
          trnHedef.Rollback;
          exit;
        end;
      end;

//****************************************************************************//
      if chk_Proje.Checked then
      begin
      if not DmYonet.CopyProjeDevToTerm(scriptBakiye,dbaKaynak) then
      begin
        Application.MessageBox('Proje update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        trnHedef.Rollback;
        exit;
      end;
      end;
//****************************************************************************//
      if chk_Plasiyer.Checked then
      begin
      if not DmYonet.CopyPlasiyerDevToTerm(scriptBakiye,dbaKaynak) then
      begin
        Application.MessageBox('Plasiyer update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        trnHedef.Rollback;
        exit;
      end;
      end;
//****************************************************************************//


//****************************************************************************//
      if chk_Arac.Checked then
      begin
      if not DmYonet.CopyAracDevToTerm(scriptBakiye,dbaKaynak) then
      begin
        Application.MessageBox('Araç update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        trnHedef.Rollback;
        exit;
      end;
      end;
//****************************************************************************//

//****************************************************************************//
      if chk_Personel.Checked then
      begin
      if not DmYonet.CopyPersonelDevToTerm(scriptBakiye,dbaKaynak) then
      begin
        Application.MessageBox('Personel update iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        trnHedef.Rollback;
        exit;
      end;
      end;
//****************************************************************************//


{
//****************************************************************************//
      if not DmYonet.GEN_AYARLA(scriptBakiye,qryHedef1) then
      begin
        Application.MessageBox('GenAyarlama iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        trnHedef.Rollback;
        exit;
      end;
//****************************************************************************//
 }


      trnHedef.Commit;
      Application.MessageBox('Devir iþlemi baþarýyla tamamlandý.','Dikkat',MB_ICONINFORMATION);
    except
      trnHedef.Rollback;
      Application.MessageBox('Devir iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
    end;
  finally
    if dbaHedef.Connected then
       dbaHedef.Connected := False;
    if dbaKaynak.Connected then
       dbaKaynak.Connected := False;
  end;
//****************************************************************************//
end;

procedure TfrmBakiyeDevret.btnCikisClick(Sender: TObject);
begin
  Close;
end;

function TfrmBakiyeDevret.CariMuhaskodKarsilastir: Boolean;
type
  TCari = Record
    CARI_KOD : string[15];
    MUHASKOD : string[30];
  end;
var
  KaynakCariArr : array of TCari;
  HedefCariArr : array of TCari;
  qryKaynakCari : TIB_Cursor;
  qryHedefCari : TIB_Cursor;
  qryCopyCari : TIB_Cursor;
  KayitSayisi,HedefKayitSayisi : Integer;
  Buldum : Boolean;
  Borc,Alacak : Currency;
begin
  Result := True;
//****************************************************************************//
  DataMod.CreateCursor(qryKaynakCari,nil,False,dbaKaynak);
  with qryKaynakCari do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CARI_KOD FROM CARI ORDER BY CARI_KOD');
    Open;
  end;
//****************************************************************************//
  if qryKaynakCari.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönemde cari bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  DataMod.CreateCursor(qryHedefCari,nil,False,dbaHedef);
  with qryHedefCari do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CARI_KOD FROM CARI ORDER BY CARI_KOD');
    Open;
  end;
//****************************************************************************//
  if qryHedefCari.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönemde cari bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  KaynakCariArr := nil;
  SetLength(KaynakCariArr,0);
//****************************************************************************//
{  DataMod.CreateCursor(qryCopyCari,nil,False,DataMod.dbaMain);
  qryKaynakCari.First;
  KayitSayisi := 0;
//****************************************************************************//
  repeat
    with qryCopyCari do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT BA,SUM(TUTAR_VPB) AS TOPLAM FROM MUH_FIS');
      SQL.Add('WHERE ISLEM_TAR >='+SQL_Tarih(qryKaynak.FieldByName('DONEM_BAS').AsDate)+' AND ISLEM_TAR <= '+SQL_Tarih(qryKaynak.FieldByName('DONEM_SON').AsDate));
      SQL.Add('AND HESAP_KOD = '+SQL_Katar(qryKaynakCari.FieldByName('MUHASKOD').AsString));
      SQL.Add('GROUP BY BA');
      Open;
    end;
//****************************************************************************//
    alacak := 0;
    borc := 0;
    qryCopyCari.First;
    while not qryCopyCari.Eof do
    begin
      if qryCopyCari.FieldByName('BA').AsString = 'A' then
      begin
        alacak := qryCopyCari.FieldByName('TOPLAM').AsCurrency;
      end
      else
      if qryCopyCari.FieldByName('BA').AsString = 'B' then
      begin
        borc := qryCopyCari.FieldByName('TOPLAM').AsCurrency;
      end;
      qryCopyCari.Next;
    end;

    if borc <> alacak then
    begin
      inc(KayitSayisi);
      SetLength(KaynakCariArr,KayitSayisi);
      KaynakCariArr[KayitSayisi-1].CARI_KOD := qryKaynakCari.FieldByName('CARI_KOD').AsString;
      KaynakCariArr[KayitSayisi-1].MUHASKOD := qryKaynakCari.FieldByName('MUHASKOD').AsString;
    end;

    qryKaynakCari.Next;
  until qryKaynakCari.Eof;
  qryKaynakCari.Close;
}
//  KayitSayisi := 0;
//  repeat
//    KaynakCariArr[KayitSayisi].CARI_KOD := qryKaynakCari.FieldByName('CARI_KOD').AsString;
//    KaynakCariArr[KayitSayisi].MUHASKOD := qryKaynakCari.FieldByName('MUHASKOD').AsString;
//    inc(KayitSayisi);
//    qryKaynakCari.Next;
//  until qryKaynakCari.Eof;
//
////////////////////////////////////////////////////////////////////////////////
  HedefCariArr := nil;
  SetLength(HedefCariArr,qryHedefCari.RecordCount);
  qryHedefCari.First;
  KayitSayisi := 0;
  repeat
    HedefCariArr[KayitSayisi].CARI_KOD := qryHedefCari.FieldByName('CARI_KOD').AsString;
//    HedefCariArr[KayitSayisi].MUHASKOD := qryHedefCari.FieldByName('MUHASKOD').AsString;
    inc(KayitSayisi);
    qryHedefCari.Next;
  until qryHedefCari.Eof;
  qryHedefCari.Close;
////////////////////////////////////////////////////////////////////////////////
  for KayitSayisi := 0 to Length(KaynakCariArr)-1 do
  begin
    Buldum := False;
    for HedefKayitSayisi := 0 to Length(HedefCariArr)-1 do
    begin
      if KaynakCariArr[KayitSayisi].CARI_KOD = HedefCariArr[HedefKayitSayisi].CARI_KOD then
      begin
        {if KaynakCariArr[KayitSayisi].MUHASKOD <> HedefCariArr[HedefKayitSayisi].MUHASKOD then
        begin
          MemoCikti.Lines.Add(KaynakCariArr[KayitSayisi].CARI_KOD+' kodlu carinin muhasebe kodlarý birbirini tutmuyor.');
          Result := False;
        end;}
        Buldum := True;
        Break;
      end;
    end;
    if not Buldum then
    begin
      MemoCikti.Lines.Add(KaynakCariArr[KayitSayisi].CARI_KOD+' kodlu cari hedef dönemde bulunamadý.');
      Result := False;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
end;



function TfrmBakiyeDevret.MasrafMuhaskodKarsilastir: Boolean;
type
  TMasraf = Record
    MASRAF_KOD : string[15];
    MUHASKOD : string[30];
  end;
var
  KaynakMasrafArr : array of TMasraf;
  HedefMasrafArr : array of TMasraf;
  qryKaynakMasraf : TIB_Cursor;
  qryHedefMasraf : TIB_Cursor;
  qryCopyMasraf : TIB_Cursor;
  KayitSayisi,HedefKayitSayisi : Integer;
  Buldum : Boolean;
  Borc,Alacak : Currency;
begin
  Result := True;
  DataMod.CreateCursor(qryKaynakMasraf,nil,False,dbaKaynak);
  with qryKaynakMasraf do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MASRAF_KOD FROM MASRAF WHERE DEVIR = 1 ORDER BY MASRAF_KOD');
    Open;
  end;
  if qryKaynakMasraf.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönemde masraf bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateCursor(qryHedefMasraf,nil,False,dbaHedef);
  with qryHedefMasraf do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT MASRAF_KOD FROM MASRAF ORDER BY MASRAF_KOD');
    Open;
  end;
  if qryHedefMasraf.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönemde masraf bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  KaynakMasrafArr := nil;
  SetLength(KaynakMasrafArr,0);
//****************************************************************************//
{
  DataMod.CreateCursor(qryCopyMasraf,nil,False,DataMod.dbaMain);
  qryKaynakMasraf.First;
  KayitSayisi := 0;
//****************************************************************************//
  repeat
    with qryCopyMasraf do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT BA,SUM(TUTAR_VPB) AS TOPLAM FROM MUH_FIS');
      SQL.Add('WHERE ISLEM_TAR >='+SQL_Tarih(qryKaynak.FieldByName('DONEM_BAS').AsDate)+' AND ISLEM_TAR <= '+SQL_Tarih(qryKaynak.FieldByName('DONEM_SON').AsDate));
      SQL.Add('AND HESAP_KOD = '+SQL_Katar(qryKaynakMasraf.FieldByName('MUHASKOD').AsString));
      SQL.Add('GROUP BY BA');
      Open;
    end;
//****************************************************************************//
    alacak := 0;
    borc := 0;
    qryCopyMasraf.First;
    while not qryCopyMasraf.Eof do
    begin
      if qryCopyMasraf.FieldByName('BA').AsString = 'A' then
      begin
        alacak := qryCopyMasraf.FieldByName('TOPLAM').AsCurrency;
      end
      else
      if qryCopyMasraf.FieldByName('BA').AsString = 'B' then
      begin
        borc := qryCopyMasraf.FieldByName('TOPLAM').AsCurrency;
      end;
      qryCopyMasraf.Next;
    end;

    if borc <> alacak then
    begin
      inc(KayitSayisi);
      SetLength(KaynakMasrafArr,KayitSayisi);
      KaynakMasrafArr[KayitSayisi-1].MASRAF_KOD := qryKaynakMasraf.FieldByName('MASRAF_KOD').AsString;
      KaynakMasrafArr[KayitSayisi-1].MUHASKOD := qryKaynakMasraf.FieldByName('MUHASKOD').AsString;
    end;

    qryKaynakMasraf.Next;
  until qryKaynakMasraf.Eof;
  qryKaynakMasraf.Close;
}
//****************************************************************************//
//
//  SetLength(KaynakMasrafArr,qryKaynakMasraf.RecordCount);
//  qryKaynakMasraf.First;
//  KayitSayisi := 0;
//  repeat
//    KaynakMasrafArr[KayitSayisi].MASRAF_KOD := qryKaynakMasraf.FieldByName('MASRAF_KOD').AsString;
//    KaynakMasrafArr[KayitSayisi].MUHASKOD := qryKaynakMasraf.FieldByName('MUHASKOD').AsString;
//    inc(KayitSayisi);
//    qryKaynakMasraf.Next;
//  until qryKaynakMasraf.Eof;
//  qryKaynakMasraf.Close;

////////////////////////////////////////////////////////////////////////////////
  HedefMasrafArr := nil;
  SetLength(HedefMasrafArr,qryHedefMasraf.RecordCount);
  qryHedefMasraf.First;
  KayitSayisi := 0;
  repeat
    HedefMasrafArr[KayitSayisi].MASRAF_KOD := qryHedefMasraf.FieldByName('MASRAF_KOD').AsString;
//    HedefMasrafArr[KayitSayisi].MUHASKOD := qryHedefMasraf.FieldByName('MUHASKOD').AsString;
    inc(KayitSayisi);
    qryHedefMasraf.Next;
  until qryHedefMasraf.Eof;
  qryHedefMasraf.Close;
////////////////////////////////////////////////////////////////////////////////
  for KayitSayisi := 0 to Length(KaynakMasrafArr)-1 do
  begin
    Buldum := False;
    for HedefKayitSayisi := 0 to Length(HedefMasrafArr)-1 do
    begin
      if KaynakMasrafArr[KayitSayisi].MASRAF_KOD = HedefMasrafArr[HedefKayitSayisi].MASRAF_KOD then
      begin
        {if KaynakMasrafArr[KayitSayisi].MUHASKOD <> HedefMasrafArr[HedefKayitSayisi].MUHASKOD then
        begin
          MemoCikti.Lines.Add(KaynakMasrafArr[KayitSayisi].MASRAF_KOD+' kodlu masrafýn muhasebe kodlarý birbirini tutmuyor.');
          Result := False;
        end;}
        Buldum := True;
        Break;
      end;
    end;
    if not Buldum then
    begin
      MemoCikti.Lines.Add(KaynakMasrafArr[KayitSayisi].MASRAF_KOD+' kodlu masraf hedef dönemde bulunamadý.');
      Result := False;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
end;


function TfrmBakiyeDevret.UrunKarsilastir: Boolean;
type
  TUrun = Record
    URUN_KOD : string[35];
  end;
var
  KaynakUrunArr : array of TUrun;
  HedefUrunArr : array of TUrun;
  qryKaynakUrun : TIB_Cursor;
  qryHedefUrun : TIB_Cursor;
  KayitSayisi,HedefKayitSayisi : Integer;
  Buldum : Boolean;
begin
  Result := True;
  DataMod.CreateCursor(qryKaynakUrun,nil,False,dbaKaynak);
  with qryKaynakUrun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_KOD FROM URUN WHERE HIZMET = 0 ORDER BY URUN_KOD');
    Open;
  end;
  if qryKaynakUrun.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönemde ürün bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateCursor(qryHedefUrun,nil,False,dbaHedef);
  with qryHedefUrun do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT URUN_KOD FROM URUN WHERE HIZMET = 0 ORDER BY URUN_KOD');
    Open;
  end;
  if qryHedefUrun.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönemde ürün bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
  SetLength(KaynakUrunArr,qryKaynakUrun.RecordCount);
  qryKaynakUrun.First;
  KayitSayisi := 0;
  repeat
    KaynakUrunArr[KayitSayisi].URUN_KOD := qryKaynakUrun.FieldByName('URUN_KOD').AsString;
    inc(KayitSayisi);
    qryKaynakUrun.Next;
  until qryKaynakUrun.Eof;
  qryKaynakUrun.Close;
////////////////////////////////////////////////////////////////////////////////
  SetLength(HedefUrunArr,qryHedefUrun.RecordCount);
  qryHedefUrun.First;
  KayitSayisi := 0;
  repeat
    HedefUrunArr[KayitSayisi].URUN_KOD := qryHedefUrun.FieldByName('URUN_KOD').AsString;
    inc(KayitSayisi);
    qryHedefUrun.Next;
  until qryHedefUrun.Eof;
  qryHedefUrun.Close;
////////////////////////////////////////////////////////////////////////////////
  for KayitSayisi := 0 to Length(KaynakUrunArr)-1 do
  begin
    Buldum := False;
    for HedefKayitSayisi := 0 to Length(HedefUrunArr)-1 do
    begin
      if KaynakUrunArr[KayitSayisi].URUN_KOD = HedefUrunArr[HedefKayitSayisi].URUN_KOD then
      begin
        Buldum := True;
        Break;
      end;
    end;
    if not Buldum then
    begin
      MemoCikti.Lines.Add(KaynakUrunArr[KayitSayisi].URUN_KOD+' kodlu ürün hedef dönemde bulunamadý.');
      Result := False;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
end;






function TfrmBakiyeDevret.AracKarsilastir: Boolean;
type
  TArac = Record
    ARAC_KOD : string[15];
  end;
var
  KaynakAracArr : array of TArac;
  HedefAracArr : array of TArac;
  qryKaynakArac : TIB_Cursor;
  qryHedefArac : TIB_Cursor;
  KayitSayisi,HedefKayitSayisi : Integer;
  Buldum : Boolean;
begin
  Result := True;
  DataMod.CreateCursor(qryKaynakArac,nil,False,dbaKaynak);
  with qryKaynakArac do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ARAC_KOD FROM ARAC ORDER BY ARAC_KOD');
    Open;
  end;
  if qryKaynakArac.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönemde Araç bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateCursor(qryHedefArac,nil,False,dbaHedef);
  with qryHedefArac do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ARAC_KOD FROM ARAC ORDER BY ARAC_KOD');
    Open;
  end;
  if qryHedefArac.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönemde Araç bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
  SetLength(KaynakAracArr,qryKaynakArac.RecordCount);
  qryKaynakArac.First;
  KayitSayisi := 0;
  repeat
    KaynakAracArr[KayitSayisi].ARAC_KOD := qryKaynakArac.FieldByName('ARAC_KOD').AsString;
    inc(KayitSayisi);
    qryKaynakArac.Next;
  until qryKaynakArac.Eof;
  qryKaynakArac.Close;
////////////////////////////////////////////////////////////////////////////////
  SetLength(HedefAracArr,qryHedefArac.RecordCount);
  qryHedefArac.First;
  KayitSayisi := 0;
  repeat
    HedefAracArr[KayitSayisi].ARAC_KOD := qryHedefArac.FieldByName('ARAC_KOD').AsString;
    inc(KayitSayisi);
    qryHedefArac.Next;
  until qryHedefArac.Eof;
  qryHedefArac.Close;
////////////////////////////////////////////////////////////////////////////////
  for KayitSayisi := 0 to Length(KaynakAracArr)-1 do
  begin
    Buldum := False;
    for HedefKayitSayisi := 0 to Length(HedefAracArr)-1 do
    begin
      if KaynakAracArr[KayitSayisi].ARAC_KOD = HedefAracArr[HedefKayitSayisi].ARAC_KOD then
      begin
        Buldum := True;
        Break;
      end;
    end;
    if not Buldum then
    begin
      MemoCikti.Lines.Add(KaynakAracArr[KayitSayisi].ARAC_KOD+' kodlu Arac hedef dönemde bulunamadý.');
      Result := False;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
end;


function TfrmBakiyeDevret.PersonelKarsilastir: Boolean;
type
  TPersonel = Record
    PERSONEL_KOD : string[15];
  end;
var
  KaynakPersonelArr : array of TPersonel;
  HedefPersonelArr : array of TPersonel;
  qryKaynakPersonel : TIB_Cursor;
  qryHedefPersonel : TIB_Cursor;
  KayitSayisi,HedefKayitSayisi : Integer;
  Buldum : Boolean;
begin
  Result := True;
  DataMod.CreateCursor(qryKaynakPersonel,nil,False,dbaKaynak);
  with qryKaynakPersonel do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PERSONEL_KOD FROM PERSONEL ORDER BY PERSONEL_KOD');
    Open;
  end;
  if qryKaynakPersonel.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönemde Personel bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateCursor(qryHedefPersonel,nil,False,dbaHedef);
  with qryHedefPersonel do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PERSONEL_KOD FROM PERSONEL ORDER BY PERSONEL_KOD');
    Open;
  end;
  if qryHedefPersonel.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönemde Personel bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
  SetLength(KaynakPersonelArr,qryKaynakPersonel.RecordCount);
  qryKaynakPersonel.First;
  KayitSayisi := 0;
  repeat
    KaynakPersonelArr[KayitSayisi].PERSONEL_KOD := qryKaynakPersonel.FieldByName('PERSONEL_KOD').AsString;
    inc(KayitSayisi);
    qryKaynakPersonel.Next;
  until qryKaynakPersonel.Eof;
  qryKaynakPersonel.Close;
////////////////////////////////////////////////////////////////////////////////
  SetLength(HedefPersonelArr,qryHedefPersonel.RecordCount);
  qryHedefPersonel.First;
  KayitSayisi := 0;
  repeat
    HedefPersonelArr[KayitSayisi].PERSONEL_KOD := qryHedefPersonel.FieldByName('PERSONEL_KOD').AsString;
    inc(KayitSayisi);
    qryHedefPersonel.Next;
  until qryHedefPersonel.Eof;
  qryHedefPersonel.Close;
////////////////////////////////////////////////////////////////////////////////
  for KayitSayisi := 0 to Length(KaynakPersonelArr)-1 do
  begin
    Buldum := False;
    for HedefKayitSayisi := 0 to Length(HedefPersonelArr)-1 do
    begin
      if KaynakPersonelArr[KayitSayisi].PERSONEL_KOD = HedefPersonelArr[HedefKayitSayisi].PERSONEL_KOD then
      begin
        Buldum := True;
        Break;
      end;
    end;
    if not Buldum then
    begin
      MemoCikti.Lines.Add(KaynakPersonelArr[KayitSayisi].Personel_KOD+' kodlu Personel hedef dönemde bulunamadý.');
      Result := False;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
end;


function TfrmBakiyeDevret.ProjeKarsilastir: Boolean;
type
  TProje = Record
    PROJE_KOD : string[15];
  end;
var
  KaynakProjeArr : array of TProje;
  HedefProjeArr : array of TProje;
  qryKaynakProje : TIB_Cursor;
  qryHedefProje : TIB_Cursor;
  KayitSayisi,HedefKayitSayisi : Integer;
  Buldum : Boolean;
begin
  Result := True;
  DataMod.CreateCursor(qryKaynakProje,nil,False,dbaKaynak);
  with qryKaynakProje do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PROJE_KOD FROM PROJE ORDER BY PROJE_KOD');
    Open;
  end;
  if qryKaynakProje.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönemde Proje bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateCursor(qryHedefProje,nil,False,dbaHedef);
  with qryHedefProje do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PROJE_KOD FROM PROJE ORDER BY PROJE_KOD');
    Open;
  end;
  if qryHedefProje.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönemde Proje bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
  SetLength(KaynakProjeArr,qryKaynakProje.RecordCount);
  qryKaynakProje.First;
  KayitSayisi := 0;
  repeat
    KaynakProjeArr[KayitSayisi].PROJE_KOD := qryKaynakProje.FieldByName('PROJE_KOD').AsString;
    inc(KayitSayisi);
    qryKaynakProje.Next;
  until qryKaynakProje.Eof;
  qryKaynakProje.Close;
////////////////////////////////////////////////////////////////////////////////
  SetLength(HedefProjeArr,qryHedefProje.RecordCount);
  qryHedefProje.First;
  KayitSayisi := 0;
  repeat
    HedefProjeArr[KayitSayisi].PROJE_KOD := qryHedefProje.FieldByName('PROJE_KOD').AsString;
    inc(KayitSayisi);
    qryHedefProje.Next;
  until qryHedefProje.Eof;
  qryHedefProje.Close;
////////////////////////////////////////////////////////////////////////////////
  for KayitSayisi := 0 to Length(KaynakProjeArr)-1 do
  begin
    Buldum := False;
    for HedefKayitSayisi := 0 to Length(HedefProjeArr)-1 do
    begin
      if KaynakProjeArr[KayitSayisi].PROJE_KOD = HedefProjeArr[HedefKayitSayisi].PROJE_KOD then
      begin
        Buldum := True;
        Break;
      end;
    end;
    if not Buldum then
    begin
      MemoCikti.Lines.Add(KaynakProjeArr[KayitSayisi].PROJE_KOD+' kodlu Proje hedef dönemde bulunamadý.');
      Result := False;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
end;



function TfrmBakiyeDevret.PlasiyerKarsilastir: Boolean;
type
  TProje = Record
    PLASIYER_KOD : string[15];
  end;
var
  KaynakPlasiyerArr : array of TProje;
  HedefPlasiyerArr : array of TProje;
  qryKaynakPlasiyer : TIB_Cursor;
  qryHedefPlasiyer : TIB_Cursor;
  KayitSayisi,HedefKayitSayisi : Integer;
  Buldum : Boolean;
begin
  Result := True;
  DataMod.CreateCursor(qryKaynakPlasiyer,nil,False,dbaKaynak);
  with qryKaynakPlasiyer do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PLASIYER_KOD FROM PLASIYER ORDER BY PLASIYER_KOD');
    Open;
  end;
  if qryKaynakPlasiyer.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönemde Plasiyer bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateCursor(qryHedefPlasiyer,nil,False,dbaHedef);
  with qryHedefPlasiyer do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PLASIYER_KOD FROM PLASIYER ORDER BY PLASIYER_KOD');
    Open;
  end;
  if qryHedefPlasiyer.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönemde Plasiyer bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
  SetLength(KaynakPlasiyerArr,qryKaynakPlasiyer.RecordCount);
  qryKaynakPlasiyer.First;
  KayitSayisi := 0;
  repeat
    KaynakPlasiyerArr[KayitSayisi].PLASIYER_KOD := qryKaynakPlasiyer.FieldByName('PLASIYER_KOD').AsString;
    inc(KayitSayisi);
    qryKaynakPlasiyer.Next;
  until qryKaynakPlasiyer.Eof;
  qryKaynakPlasiyer.Close;
////////////////////////////////////////////////////////////////////////////////
  SetLength(HedefPlasiyerArr,qryHedefPlasiyer.RecordCount);
  qryHedefPlasiyer.First;
  KayitSayisi := 0;
  repeat
    HedefPlasiyerArr[KayitSayisi].PLASIYER_KOD := qryHedefPlasiyer.FieldByName('PLASIYER_KOD').AsString;
    inc(KayitSayisi);
    qryHedefPlasiyer.Next;
  until qryHedefPlasiyer.Eof;
  qryHedefPlasiyer.Close;
////////////////////////////////////////////////////////////////////////////////
  for KayitSayisi := 0 to Length(KaynakPlasiyerArr)-1 do
  begin
    Buldum := False;
    for HedefKayitSayisi := 0 to Length(HedefPlasiyerArr)-1 do
    begin
      if KaynakPlasiyerArr[KayitSayisi].PLASIYER_KOD = HedefPlasiyerArr[HedefKayitSayisi].PLASIYER_KOD then
      begin
        Buldum := True;
        Break;
      end;
    end;
    if not Buldum then
    begin
      MemoCikti.Lines.Add(KaynakPlasiyerArr[KayitSayisi].PLASIYER_KOD+' kodlu Plasiyer hedef dönemde bulunamadý.');
      Result := False;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
end;





function TfrmBakiyeDevret.KasaKarsilastir: Boolean;
type
  TKasa = Record
    KASA_KOD : string[15];
    MUHASKOD : string[30];
  end;
var
  KaynakKasaArr : array of TKasa;
  HedefKasaArr : array of TKasa;
  qryKaynakKasa : TIB_Cursor;
  qryHedefKasa : TIB_Cursor;
  KayitSayisi,HedefKayitSayisi : Integer;
  Buldum : Boolean;
begin
  Result := True;
  DataMod.CreateCursor(qryKaynakKasa,nil,False,dbaKaynak);
  with qryKaynakKasa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT KASA_KOD FROM KASA ORDER BY KASA_KOD');
    Open;
  end;
  if qryKaynakKasa.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönemde kasa bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  DataMod.CreateCursor(qryHedefKasa,nil,False,dbaHedef);
  with qryHedefKasa do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT KASA_KOD FROM KASA ORDER BY KASA_KOD');
    Open;
  end;
  if qryHedefKasa.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönemde kasa bulunamadý.Karþýlaþtýrma iþlemi yapýlmayacaktýr.','Dikkat',MB_ICONWARNING);
    exit;
  end;
////////////////////////////////////////////////////////////////////////////////
  SetLength(KaynakKasaArr,qryKaynakKasa.RecordCount);
  qryKaynakKasa.First;
  KayitSayisi := 0;
  repeat
    KaynakKasaArr[KayitSayisi].KASA_KOD := qryKaynakKasa.FieldByName('KASA_KOD').AsString;
    //KaynakKasaArr[KayitSayisi].MUHASKOD := qryKaynakKasa.FieldByName('MUHASKOD').AsString;
    inc(KayitSayisi);
    qryKaynakKasa.Next;
  until qryKaynakKasa.Eof;
  qryKaynakKasa.Close;
////////////////////////////////////////////////////////////////////////////////
  SetLength(HedefKasaArr,qryHedefKasa.RecordCount);
  qryHedefKasa.First;
  KayitSayisi := 0;
  repeat
    HedefKasaArr[KayitSayisi].KASA_KOD := qryHedefKasa.FieldByName('KASA_KOD').AsString;
    //HedefKasaArr[KayitSayisi].MUHASKOD := qryHedefKasa.FieldByName('MUHASKOD').AsString;
    inc(KayitSayisi);
    qryHedefKasa.Next;
  until qryHedefKasa.Eof;
  qryHedefKasa.Close;
////////////////////////////////////////////////////////////////////////////////
  for KayitSayisi := 0 to Length(KaynakKasaArr)-1 do
  begin
    Buldum := False;
    for HedefKayitSayisi := 0 to Length(HedefKasaArr)-1 do
    begin
      if KaynakKasaArr[KayitSayisi].KASA_KOD = HedefKasaArr[HedefKayitSayisi].KASA_KOD then
      begin
        {if KaynakKasaArr[KayitSayisi].MUHASKOD <> HedefKasaArr[HedefKayitSayisi].MUHASKOD then
        begin
          MemoCikti.Lines.Add(KaynakKasaArr[KayitSayisi].KASA_KOD+' kodlu kasanýn muhasebe kodlarý birbirini tutmuyor.');
          Result := False;
        end;
        }
        Buldum := True;
        Break;
      end;
    end;
    if not Buldum then
    begin
      MemoCikti.Lines.Add(KaynakKasaArr[KayitSayisi].KASA_KOD+' kodlu kasa hedef dönemde bulunamadý.');
      Result := False;
    end;
  end;
////////////////////////////////////////////////////////////////////////////////
end;


procedure TfrmBakiyeDevret.btnSifirlaClick(Sender: TObject);
begin
  {if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005'))=0 then
  begin
    Application.MessageBox('Yeni dönem üzerinden bakiye aktarým iþlemi yapýlamaz.','Dikkat',MB_ICONWARNING);
    exit;
  end;  }
//****************************************************************************//
  if qryKaynak.RecordCount = 0 then
  begin
    Application.MessageBox('Kaynak dönem olmadan karþýlaþtýrma iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if qryHedef.RecordCount = 0 then
  begin
    Application.MessageBox('Hedef dönem olmadan karþýlaþtýrma iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if not SetConnection(dbaKaynak,
                       qryKaynak.FieldByName('CONN_LOCAL').AsBoolean,
                       qryKaynak.FieldByName('SERVER_NAME').AsString,
                       qryKaynak.FieldByName('DB_PATH').AsString,
                       qryKaynak.FieldByName('USER_NAME').AsString,
                       qryKaynak.FieldByName('PASS_WORD').AsString) then
  begin
    Application.MessageBox('Kaynak database baðlantýsý yapýlamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if not SetConnection(dbaHedef,
                       qryHedef.FieldByName('CONN_LOCAL').AsBoolean,
                       qryHedef.FieldByName('SERVER_NAME').AsString,
                       qryHedef.FieldByName('DB_PATH').AsString,
                       qryHedef.FieldByName('USER_NAME').AsString,
                       qryHedef.FieldByName('PASS_WORD').AsString) then
  begin
    Application.MessageBox('Hedef database baðlantýsý yapýlamadý.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  MemoCikti.Clear;
//****************************************************************************//
  if Application.MessageBox('Bakiye sýfýrlama iþlemi yapmak istediðinize emin misiniz?','Dikkat',MB_ICONQUESTION+MB_YESNO) = ID_NO then exit;
//****************************************************************************//
  try
    try
      if trnHedef.InTransaction then
         trnHedef.Rollback;
      trnHedef.StartTransaction;
//****************************************************************************//
      if not DmYonet.UpdateTablesSetSifir(scriptBakiye,chkCariRst.Checked,chkUrunRst.Checked,chkMasrafRst.Checked,chkKasaRst.Checked,chkProjeRst.Checked,chkPlasiyerRst.Checked,chkAracRst.Checked,chkPersonelRst.Checked) then
      begin
        Application.MessageBox('UpdateTablesSetSifir iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        trnHedef.Rollback;
        exit;
      end;
//****************************************************************************//
      trnHedef.Commit;
      Application.MessageBox('Bakiye sýfýrlama iþlemi baþarýyla tamamlandý.','Dikkat',MB_ICONINFORMATION);
    except
      trnHedef.Rollback;
      Application.MessageBox('Bakiye sýfýrlama iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
    end;
  finally
    if dbaHedef.Connected then
       dbaHedef.Connected := False;
    if dbaKaynak.Connected then
       dbaKaynak.Connected := False;
  end;
//****************************************************************************//
end;

function TfrmBakiyeDevret.TutarHesapla(var PRM_TUTAR:Currency): Boolean;
var
  ISLENEN:Currency;
begin
  Result := False;
  ISLENEN := Frac(PRM_TUTAR);
  if Length(FloatToStr(ISLENEN)) > 2 then
  begin
    if ISLENEN >= 0.5 then
    begin
      PRM_TUTAR := (PRM_TUTAR - ISLENEN) + 1;
    end
    else
    begin
      PRM_TUTAR := (PRM_TUTAR - ISLENEN);
    end;
  end;
  Result := True;
end;



end.
