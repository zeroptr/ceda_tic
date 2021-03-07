unit ufrmSirket_Expert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Grids, IB_Grid,
  IB_Controls, ExtDlgs, IB_Components, Mask;

type
  TfrmSirket_Expert = class(TForm)
    PageControl1: TPageControl;
    Tab_Basla: TTabSheet;
    Tab_Yeni_Sirket: TTabSheet;
    Tab_Don_Yen_Deg: TTabSheet;
    Tab_Yeni_Donem: TTabSheet;
    Panel1: TPanel;
    Btn_geri: TBitBtn;
    Btn_ileri: TBitBtn;
    Rg_Basla: TRadioGroup;
    Tab_Donem_Sec: TTabSheet;
    Tab_Sirketler: TTabSheet;
    Tab_Sirket_Sor: TTabSheet;
    Rg_Sirket_Son_Devam: TRadioGroup;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit8: TIB_Edit;
    edt_Pk: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Image1: TIB_Image;
    edt_Ver_No: TIB_Edit;
    Button1: TButton;
    IB_Edit2: TIB_Edit;
    IB_Edit1: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit14: TIB_Edit;
    Button2: TButton;
    IB_CheckBox1: TIB_CheckBox;
    qry_Sirket: TIB_Query;
    dts_Sirket: TIB_DataSource;
    OpenPictureDialog1: TOpenPictureDialog;
    IB_Edit15: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_Date2: TIB_Date;
    IB_Edit16: TIB_Edit;
    IB_CheckBox2: TIB_CheckBox;
    txtPath: TIB_Edit;
    IB_Edit17: TIB_Edit;
    IB_Edit18: TIB_Edit;
    IB_CheckBox3: TIB_CheckBox;
    mnuTEST: TButton;
    btnSirketYarat: TButton;
    btnDonemDevir: TButton;
    grdSIRKET: TIB_Grid;
    qryTERMS: TIB_Query;
    dtsTERMS: TIB_DataSource;
    grdTERMS: TIB_Grid;
    Rg_Sirket: TRadioGroup;
    Rg_Donem_Sec: TRadioGroup;
    btnEKLE: TButton;
    btnKaydet: TButton;
    btnIptal: TButton;
    btnSil: TButton;
    Rg_Donem: TRadioGroup;
    BtnEkle1: TButton;
    BtnKaydet1: TButton;
    BtnIptal1: TButton;
    BtnSil1: TButton;
    procedure PageControl1Change(Sender: TObject);
    procedure Btn_ileriClick(Sender: TObject);
    procedure Btn_geriClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEkle1Click(Sender: TObject);
    procedure BtnKaydet1Click(Sender: TObject);
    procedure BtnIptal1Click(Sender: TObject);
    procedure BtnSil1Click(Sender: TObject);
    procedure btnEKLEClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure dts_SirketStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure dtsTERMSStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure btnSirketYaratClick(Sender: TObject);
    procedure mnuTESTClick(Sender: TObject);
    procedure btnDonemDevirClick(Sender: TObject);
    procedure qry_SirketBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure qry_SirketBeforePost(IB_Dataset: TIB_Dataset);
    procedure qry_SirketAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function Form_Before_Post: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSirket_Expert: TfrmSirket_Expert;

implementation

uses unDmYonet, unDataMod;

{$R *.dfm}

procedure TfrmSirket_Expert.PageControl1Change(Sender: TObject);
begin
     case PageControl1.ActivePageIndex of

     0:begin
        Btn_geri.Visible:=False;
        Btn_geri.Caption:='Ýptal - Çýkýþ';
     end;

     6:begin
        Btn_ileri.Caption:='Son - Çýkýþ';
     end;


     end;
end;

procedure TfrmSirket_Expert.Btn_ileriClick(Sender: TObject);
var
   Ilk_Index:Integer;
begin
     Ilk_Index:=PageControl1.ActivePageIndex;

     //Tab_Sirketler
     if PageControl1.ActivePage=Tab_Sirketler then
     begin
         if Rg_Sirket.ItemIndex=0 then
         begin
              PageControl1.ActivePage:=Tab_Yeni_Sirket;
              PageControl1.Pages[PageControl1.ActivePageIndex].TabVisible:=True;
              PageControl1.Pages[Ilk_Index].TabVisible:=False;
              Exit;
         end;
     end;

     //Tab_Don_Yen_Deg
     if PageControl1.ActivePage=Tab_Don_Yen_Deg then
     begin
         if Rg_Donem.ItemIndex=1 then
         begin
              PageControl1.ActivePage:=Tab_Donem_Sec;
              PageControl1.Pages[PageControl1.ActivePageIndex].TabVisible:=True;
              PageControl1.Pages[Ilk_Index].TabVisible:=False;
              Exit;
         end;
     end;

     //Tab_Donem_Sec
     if PageControl1.ActivePage=Tab_Donem_Sec then
     begin
         if Rg_Donem_Sec.ItemIndex=0 then
         begin
         ModalResult:=MrOk;
         Close;
         end;

         if Rg_Donem_Sec.ItemIndex=1 then
         begin
              PageControl1.ActivePage:=Tab_Yeni_Donem;
              PageControl1.Pages[PageControl1.ActivePageIndex].TabVisible:=True;
              PageControl1.Pages[Ilk_Index].TabVisible:=False;
              Exit;
         end;
     end;

     if PageControl1.ActivePage=Tab_Basla then
     begin
         if Rg_Basla.ItemIndex=1 then
         begin
              PageControl1.ActivePage:=Tab_Sirketler;
              PageControl1.Pages[PageControl1.ActivePageIndex].TabVisible:=True;
              PageControl1.Pages[Ilk_Index].TabVisible:=False;
              Exit;
         end;
     end;

     if PageControl1.ActivePage=Tab_Sirket_Sor then
     begin
         if Rg_Sirket_Son_Devam.ItemIndex=0 then
         begin
              ModalResult:=MrOk;
              Close;
         end;
     end;

     if PageControl1.ActivePageIndex<=5 then
     begin
          PageControl1.ActivePageIndex:=PageControl1.ActivePageIndex+1;
          PageControl1.Pages[PageControl1.ActivePageIndex].TabVisible:=True;
          PageControl1.Pages[Ilk_Index].TabVisible:=False;
     end;

end;

procedure TfrmSirket_Expert.Btn_geriClick(Sender: TObject);
var
   Ilk_Index:Integer;
begin
     Ilk_Index:=PageControl1.ActivePageIndex;
     if PageControl1.ActivePageIndex>=1 then
     begin
          PageControl1.ActivePageIndex:=PageControl1.ActivePageIndex-1;
          PageControl1.Pages[PageControl1.ActivePageIndex].TabVisible:=True;
          PageControl1.Pages[Ilk_Index].TabVisible:=False;
     end;
end;

procedure TfrmSirket_Expert.FormShow(Sender: TObject);
var
   a:Integer;
begin
     for a:=0 to PageControl1.PageCount-1 do
     begin
          PageControl1.Pages[a].TabVisible:=False;
     end;
          PageControl1.Pages[0].TabVisible:=True;
end;

procedure TfrmSirket_Expert.BtnEkle1Click(Sender: TObject);
begin
     if not (qryTERMS.State in [DssEdit,DssInsert]) then
     qryTERMS.Append;
end;

procedure TfrmSirket_Expert.BtnKaydet1Click(Sender: TObject);
begin
     if qryTERMS.State in [DssEdit,DssInsert] then
     qryTERMS.Post;
end;

procedure TfrmSirket_Expert.BtnIptal1Click(Sender: TObject);
begin
     if qryTERMS.State in [DssEdit,DssInsert] then
     qryTERMS.Cancel;
end;

procedure TfrmSirket_Expert.BtnSil1Click(Sender: TObject);
begin
     if not (qryTERMS.State in [DssEdit,DssInsert]) then
     qryTERMS.Delete;
end;

procedure TfrmSirket_Expert.btnEKLEClick(Sender: TObject);
begin
     if not (qry_Sirket.State in [DssEdit,DssInsert]) then
     qry_Sirket.Append;
end;

procedure TfrmSirket_Expert.btnKaydetClick(Sender: TObject);
begin
     if qry_Sirket.State in [DssEdit,DssInsert] then
     qry_Sirket.Post;
end;

procedure TfrmSirket_Expert.btnIptalClick(Sender: TObject);
begin
     if qry_Sirket.State in [DssEdit,DssInsert] then
     qry_Sirket.Cancel;
end;

procedure TfrmSirket_Expert.btnSilClick(Sender: TObject);
begin
     if qry_Sirket.State in [DssEdit,DssInsert] then
     qry_Sirket.Delete;
end;

procedure TfrmSirket_Expert.dts_SirketStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if ADataset.State in [dssINSERT,dssEDIT] then
  begin
    btnEKLE.Enabled := False;
    btnSIL.Enabled := False;
    btnKAYDET.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnEKLE.Enabled := True;
    if not ((qry_Sirket.Eof) and (qry_Sirket.Bof)) then
    begin
      btnSil.Enabled := True
    end
    else
    begin
      btnSil.Enabled := False;
    end;

    btnKAYDET.Enabled := False;
    btnIPTAL.Enabled := False;
  end;

end;

procedure TfrmSirket_Expert.dtsTERMSStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin


  if ADataset.State in [dssINSERT,dssEDIT] then
  begin
    btnEKLE1.Enabled := False;
    btnSIL1.Enabled := False;
    btnKAYDET1.Enabled := True;
    btnIPTAL1.Enabled := True;
  end
  else
  begin
    btnEKLE1.Enabled := True;
    if not ((qryTERMS.Eof) and (qryTERMS.Bof)) then
    begin
      btnSil1.Enabled := True
    end
    else
    begin
      btnSil1.Enabled := False;
    end;

    btnKAYDET1.Enabled := False;
    btnIPTAL1.Enabled := False;
  end;
end;

procedure TfrmSirket_Expert.btnSirketYaratClick(Sender: TObject);
begin

  if (qryTERMS.FieldByName('DONEM_BAS').IsNull or qryTERMS.FieldByName('DONEM_SON').IsNull) then
  begin
    Application.MessageBox('Dönem baþlangýç ve bitiþ tarihlerini belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryTERMS.FieldByName('CONN_LOCAL').AsInteger = 0 then
  begin
    if Trim(qryTERMS.FieldByName('SERVER_NAME').AsString) = '' then
    begin
      Application.MessageBox('Bir server adý belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;

  if Trim(qryTERMS.FieldByName('DB_PATH').AsString) = '' then
  begin
    Application.MessageBox('Bir db pathi belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryTERMS.FieldByName('CONN_LOCAL').AsInteger = 1 then
  begin
    if FileExists(qryTERMS.FieldByName('DB_PATH').AsString) then
    begin
      Application.MessageBox('Belirttiðiniz yerde ayný isimli bir veritabaný var,ayný isimde veritabaný yaratamazsýnýz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;

  if Trim(qryTERMS.FieldByName('USER_NAME').AsString) = '' then
  begin
    Application.MessageBox('User Name belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryTERMS.FieldByName('PASS_WORD').AsString) = '' then
  begin
    Application.MessageBox('Password belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if qryTERMS.FieldByName('CONN_LOCAL').AsInteger = 0 then
  begin
    if not DmYonet.CreateTermFile(False,qryTERMS.FieldByName('SERVER_NAME').AsString,qryTERMS.FieldByName('DB_PATH').AsString,qryTERMS.FieldByName('USER_NAME').AsString,qryTERMS.FieldByName('PASS_WORD').AsString) then
    begin
      Application.MessageBox('Veritabaný yaratýlýrken hata oluþtu.','Dikkat',MB_ICONERROR);
      exit;
    end;
  end
  else
  begin
    if not DmYonet.CreateTermFile(True,qryTERMS.FieldByName('SERVER_NAME').AsString,qryTERMS.FieldByName('DB_PATH').AsString,qryTERMS.FieldByName('USER_NAME').AsString,qryTERMS.FieldByName('PASS_WORD').AsString) then
    begin
      Application.MessageBox('Veritabaný yaratýlýrken hata oluþtu.','Dikkat',MB_ICONERROR);
      exit;
    end;
  end;
//****************************************************************************//
  if not DmYonet.ExecuteScript('NEW_DB.SQL') then
  begin
    exit;
  end;
//****************************************************************************//
  if not DmYonet.ExecuteScript('DEFAULTS.SQL') then
  begin
    exit;
  end;
//****************************************************************************//

  DmYonet.dbaCreate.Close;
//****************************************************************************//
  ShowMessage('Dönem yaratma iþlemi baþarýyla tamamlandý.');
//****************************************************************************//
  btnKaydetClick(Self);
  mnuTESTClick(Self);

end;

procedure TfrmSirket_Expert.mnuTESTClick(Sender: TObject);
begin
  DataMod.TestConnection((qryTERMS.FieldByName('CONN_LOCAL').AsInteger = 1),
                          qryTERMS.FieldByName('SERVER_NAME').AsString,
                          qryTERMS.FieldByName('DB_PATH').AsString,
                          qryTERMS.FieldByName('USER_NAME').AsString,
                          qryTERMS.FieldByName('PASS_WORD').AsString,
                          True);

end;

procedure TfrmSirket_Expert.btnDonemDevirClick(Sender: TObject);
begin
  if Application.MessageBox('Þu an baðlý olduðunuz dönem üzerindeki bilgiler kullanýlarak yeni dönem üzerinde devir iþlemi yapýlacaktýr.Bakiyeler devretmeyecektir.Devam etmek istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO) = ID_NO then
  begin
    exit;
  end;

  if (qryTERMS.FieldByName('DONEM_BAS').IsNull or qryTERMS.FieldByName('DONEM_SON').IsNull) then
  begin
    Application.MessageBox('Dönem baþlangýç ve bitiþ tarihlerini belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryTERMS.FieldByName('CONN_LOCAL').AsInteger = 0 then
  begin
    if Trim(qryTERMS.FieldByName('SERVER_NAME').AsString) = '' then
    begin
      Application.MessageBox('Bir server adý belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;

  if Trim(qryTERMS.FieldByName('DB_PATH').AsString) = '' then
  begin
    Application.MessageBox('Bir db pathi belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if qryTERMS.FieldByName('CONN_LOCAL').AsInteger = 1 then
  begin
    if FileExists(qryTERMS.FieldByName('DB_PATH').AsString) then
    begin
      Application.MessageBox('Belirttiðiniz yerde ayný isimli bir veritabaný var,ayný isimde veritabaný yaratamazsýnýz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;

  if Trim(qryTERMS.FieldByName('USER_NAME').AsString) = '' then
  begin
    Application.MessageBox('User Name belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Trim(qryTERMS.FieldByName('PASS_WORD').AsString) = '' then
  begin
    Application.MessageBox('Password belirtmek zorundasýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if qryTERMS.FieldByName('CONN_LOCAL').AsInteger = 0 then
  begin
    if not DmYonet.CreateTermFile(False,qryTERMS.FieldByName('SERVER_NAME').AsString,qryTERMS.FieldByName('DB_PATH').AsString,qryTERMS.FieldByName('USER_NAME').AsString,qryTERMS.FieldByName('PASS_WORD').AsString) then
    begin
      Application.MessageBox('Veritabaný yaratýlýrken hata oluþtu.','Dikkat',MB_ICONERROR);
      exit;
    end;
  end
  else
  begin
    if not DmYonet.CreateTermFile(True,qryTERMS.FieldByName('SERVER_NAME').AsString,qryTERMS.FieldByName('DB_PATH').AsString,qryTERMS.FieldByName('USER_NAME').AsString,qryTERMS.FieldByName('PASS_WORD').AsString) then
    begin
      Application.MessageBox('Veritabaný yaratýlýrken hata oluþtu.','Dikkat',MB_ICONERROR);
      exit;
    end;
  end;
//****************************************************************************//
  if not DmYonet.ExecuteScript('NEW_DB.SQL') then
  begin
    exit;
  end;
//****************************************************************************//
  if not DmYonet.CopyBelgeTurToTerm then
  begin
    ShowMessage('Belge Tür Tablosu kopyalama iþleminde hata oluþtu.');
    exit;
  end;
//****************************************************************************//
  if not DmYonet.CopyBelgeYazToTerm then
  begin
    ShowMessage('BelgeYaz kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
  if not DmYonet.CopyDovKartToTerm then
  begin
    ShowMessage('Dovkart kopyalama iþleminde hata oluþtu.');
    exit;
  end;
//****************************************************************************//
  if not DmYonet.CopyOlcuTipToTerm then
  begin
    ShowMessage('Ölçü tipi kopyalama iþleminde hata oluþtu.');
    exit;
  end;
//****************************************************************************//
  if not DmYonet.CopyOlcuBirToTerm then
  begin
    ShowMessage('Ölçü birimi kopyalama iþleminde hata oluþtu.');
    exit;
  end;
//****************************************************************************//
  if not DmYonet.CopyParametersToTerm then
  begin
    ShowMessage('Parametre kopyalama iþleminde hata oluþtu.');
    exit;
  end;
//****************************************************************************//
  if not DmYonet.CopyFatParamsToTerm then
  begin
    ShowMessage('Fat Params Tablosu kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//

  if not DmYonet.CopyRapKodToTerm then
  begin
    ShowMessage('Rapor kodlarý kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
  if not DmYonet.CopyRapKodParamsToTerm then
  begin
    ShowMessage('Rapor kod parametreleri kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//


//****************************************************************************//
  if not DmYonet.CopyPaketToTerm then
  begin
    ShowMessage('Paket Tablosu kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopyPaket_DToTerm then
  begin
    ShowMessage('Paket_D Tablosu kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//



  if DmYonet.CopyCariToTerm then
  begin

    if not DmYonet.CopyCariSevkToTerm then
    begin
      ShowMessage('Sevk Adresleri kopyalama iþleminde hata oluþtu.');
    end;

    if not DmYonet.CopyCariDovToTerm then
    begin
      ShowMessage('CariDov kopyalama iþleminde hata oluþtu.');
    end;
    if DmYonet.CopyCariGrupToTerm then
    begin
      if not DmYonet.CopyCariGrupUyeToTerm then
      begin
        ShowMessage('Cari grup uye kopyalama iþleminde hata oluþtu.');
      end;
    end
    else
    begin
      ShowMessage('Cari grup kopyalama iþleminde hata oluþtu.');
    end;
  end
  else
  begin
    ShowMessage('Cari kopyalama iþleminde hata oluþtu.');
  end;

        if not DmYonet.CopyDepoToTerm then
        begin
          ShowMessage('Depo kopyalama iþleminde hata oluþtu.');
        end;


          if DmYonet.CopyUrunToTerm then
          begin
            if not DmYonet.CopyDepoUrunToTerm then
            begin
              ShowMessage('DepoUrun kopyalama iþleminde hata oluþtu.');
            end;
            if not DmYonet.CopyUrunTedarikToTerm then
            begin
              ShowMessage('Urun Tedarik kopyalama iþleminde hata oluþtu.');
            end;
            if not DmYonet.CopyUrunCariFiyToTerm then
            begin
              ShowMessage('Urun Cari Fiy kopyalama iþleminde hata oluþtu.');
            end;

            if DmYonet.CopyUrunGrupToTerm then
            begin
              if DmYonet.CopyUrunGrupUyeToTerm then
              begin
                if not DmYonet.CopyUrunCGrupFiyToTerm then
                begin
                  ShowMessage('Urun CGrup Fiy kopyalama iþleminde hata oluþtu.');
                end;
              end
              else
              begin
                ShowMessage('Urun Grup Uye kopyalama iþleminde hata oluþtu.');
              end;
            end
            else
            begin
              ShowMessage('Urun Grup kopyalama iþleminde hata oluþtu.');
            end;
          end
          else
          begin
            ShowMessage('Urun kopyalama iþleminde hata oluþtu.');
          end;

//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopyMasrafToTerm then
  begin
    ShowMessage('Masraf kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
  if not DmYonet.CopyKasaToTerm then
  begin
    ShowMessage('Kasa kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
  if not DmYonet.CopyProjeToTerm then
  begin
    ShowMessage('Proje kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
  if not DmYonet.CopyPlasiyerToTerm then
  begin
    ShowMessage('Plasiyer kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//

  DmYonet.dbaCreate.Close;
//****************************************************************************//
  ShowMessage('Þirket yaratýlarak önceki dönemden devir iþlemi baþarýyla tamamlandý.');
//****************************************************************************//
  btnKaydet1Click(Self);
  mnuTESTClick(Self);

end;

procedure TfrmSirket_Expert.qry_SirketBeforeDelete(
  IB_Dataset: TIB_Dataset);
begin
  if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Abort;

end;


function TfrmSirket_Expert.Form_Before_Post: Boolean;
//vergi numarasýnýn uzunluðunu kontrol ediyor.Aslýnda boþluk karakteri ile birlikte
//12 karakter yaptýðý için burada 10 karakter yerine 12 karakter kontrol ediyor
//kullanýcý aslýnda 10 karakter girmeye zorlanýyor.
begin
  Result := False;
  if (Length(Trim(qry_Sirket.FieldByName('VERNO').AsString)))<>12 then
  begin
    edt_Ver_No.SetFocus;
    Application.MessageBox('Vergi Numarasý 10 karakterden oluþmalýdýr.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Result := True;
end;


procedure TfrmSirket_Expert.qry_SirketBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not Form_Before_Post then
  begin
    Abort;
  end;

end;

procedure TfrmSirket_Expert.qry_SirketAfterInsert(IB_Dataset: TIB_Dataset);
var
  qryTEMP:TIB_Query;
begin
  DataMod.CreateQuery(qryTEMP,Nil,False,DataMod.dbaANA);
  qryTEMP.SQL.Add('SELECT MAX(SIRKET_ID) AS SIR_ID FROM SIRKET');
  qryTEMP.Active := True;
  IB_Dataset.FieldByName('SIRKET_ID').AsInteger := qryTEMP.FieldByName('SIR_ID').AsInteger + 1;
end;

procedure TfrmSirket_Expert.FormCreate(Sender: TObject);
begin
     qry_Sirket.Active:=True;
     qryTERMS.Active:=True;
  DataMod.Form_Comp_Color(frmSirket_Expert);
end;

procedure TfrmSirket_Expert.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     qryTERMS.Active:=False;
     qry_Sirket.Active:=False;
end;

procedure TfrmSirket_Expert.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute<>False then qry_Sirket.FieldByName('LOGO').LoadFromFile(OpenPictureDialog1.FileName);
end;

procedure TfrmSirket_Expert.Button2Click(Sender: TObject);
begin
  qry_Sirket.FieldByName('LOGO').AsString :='';
end;

end.
