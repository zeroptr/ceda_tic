{$INCLUDE directive.inc}

unit ufrmTERM_FF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, StdCtrls, IB_Controls, Mask,
  Buttons, ExtCtrls;

type
  TfrmTERM_FF = class(TForm)
    qrySIRKET: TIB_Query;
    qryTERMS: TIB_Query;
    dtsSIRKET: TIB_DataSource;
    dtsTERMS: TIB_DataSource;
    grdSIRKET: TIB_Grid;
    grdTERMS: TIB_Grid;
    IB_Edit1: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_Date2: TIB_Date;
    IB_Edit2: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnCikis: TBitBtn;
    dlgFileOpen: TOpenDialog;
    txtPath: TIB_Edit;
    mnuTEST: TButton;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    IB_CheckBox2: TIB_CheckBox;
    btnSirketYarat: TButton;
    btnDonemDevir: TButton;
    procedure qryTERMSAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dtsTERMSStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Form_Open(Menu:Boolean;Islem:Byte);
    procedure IB_CheckBox1Click(Sender: TObject);
    procedure txtPathButtonClick(Sender: TObject);
    procedure mnuTESTClick(Sender: TObject);
    procedure btnSirketYaratClick(Sender: TObject);
    procedure btnDonemDevirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTERM_FF: TfrmTERM_FF;

implementation

uses unDATAMOD,unFunc, main,unDmYonet, ufrmDEVIRKAY, ufrmDevirSifre;

{$R *.dfm}

procedure TfrmTERM_FF.Form_Open(Menu:Boolean;Islem:Byte);
//0:Yeni DÖnem oluþtur.
//1:Varolan dönemi test et.
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmTERM_FF') then
    begin
      Application.CreateForm(TfrmTERM_FF, frmTERM_FF);
      if not Menu then
      begin
        with frmTERM_FF do
        begin
          FormStyle := fsNormal;
          Visible := False;
          frmTERM_FF.qrySIRKET.Open;
          frmTERM_FF.qryTERMS.Open;
          ShowModal;
          frmTERM_FF.qrySIRKET.Close;
          frmTERM_FF.qryTERMS.Close;
          Release;
        end;
      end;
    end
    else
    begin
      Application.MessageBox('Þirket Dönem Ýþlemleri modulu açýk.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    case Islem of
    0:
      begin
        with frmTERM_FF do
        begin
          mnuTEST.Visible := False;
//          btnOlustur.Visible := True;
//          btnOlustur.Top := 328;
//          btnYeni.Visible := False;
          btnKaydet.Visible := False;
          btnIPTAL.Visible := False;
          btnSil.Visible := False;
          txtPath.ButtonStyle := ebsNone;
        end;
      end;
    1:
      begin
        with frmTERM_FF do
        begin
          btnSirketYarat.Visible := False;
          btnDonemDevir.Visible := False;
        end;  
      end;
    end;
    frmTERM_FF.qrySIRKET.Open;
    frmTERM_FF.qryTERMS.Open;
  end;
end;

procedure TfrmTERM_FF.qryTERMSAfterInsert(IB_Dataset: TIB_Dataset);
var
  qryTEMP:TIB_Query;
begin
  DataMod.CreateQuery(qryTEMP,Nil,False,DataMod.dbaANA);
  qryTEMP.SQL.Add('SELECT MAX(DONEM_NO) AS DON FROM TERMS WHERE SIRKET_ID = ' + qrySIRKET.FieldByName('SIRKET_ID').AsString);
  qryTEMP.Active := True;
  qryTERMS.FieldByName('SIRKET_ID').AsInteger := qrySIRKET.FieldByName('SIRKET_ID').AsInteger;
  qryTERMS.FieldByName('DONEM_NO').AsInteger := qryTEMP.FieldByName('DON').AsInteger + 1;
  qryTERMS.FieldByName('CONN_LOCAL').AsInteger := 1;
  qryTERMS.FieldByName('USER_NAME').AsString := 'SYSDBA';
  qryTERMS.FieldByName('PASS_WORD').AsString := 'masterkey';
  qryTERMS.FieldByName('AKTIF').AsInteger := 1;
  DataMod.ReleaseQuery(qryTEMP);
end;

procedure TfrmTERM_FF.dtsTERMSStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
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

procedure TfrmTERM_FF.btnYeniClick(Sender: TObject);
begin
  if qrySIRKET.RecordCount <> 0 then qryTERMS.Append;
end;

procedure TfrmTERM_FF.btnKaydetClick(Sender: TObject);
begin
  if qryTERMS.State in [DssInsert,DssEdit] then 
  qryTERMS.Post;
end;

procedure TfrmTERM_FF.btnIPTALClick(Sender: TObject);
begin
  qryTERMS.Cancel;
end;

procedure TfrmTERM_FF.btnSilClick(Sender: TObject);
begin
   if Application.MessageBox('Dönemi silmek istediðinizden emin misiniz ?','Dikkat',MB_ICONQUESTION+ MB_YESNO)= ID_NO then Exit;
   qryTERMS.Delete;
end;

procedure TfrmTERM_FF.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTERM_FF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmTERM_FF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[ssCtrl,ssAlt,ssShift] then
begin
  if key=VK_SPACE then
  begin
    frmDevirSifre.ShowModal;
    if frmDevirSifre.ModalResult=MrOk then
    begin
         btnSirketYarat.Visible:=True;
         btnDonemDevir.Visible:=True;
    end;
    //frmDevirSifre.Release;
  end;
end;
end;

procedure TfrmTERM_FF.IB_CheckBox1Click(Sender: TObject);
begin
  if IB_CheckBox1.Checked then
     IB_Edit2.Enabled := False
  else
     IB_Edit2.Enabled := True;
end;

procedure TfrmTERM_FF.txtPathButtonClick(Sender: TObject);
begin
  dlgFileOpen.execute;
  if dlgFileOpen.FileName <> '' then qryTERMS.FieldByName('DB_PATH').AsString :=dlgFileOpen.FileName ;
end;

procedure TfrmTERM_FF.mnuTESTClick(Sender: TObject);
begin
  DataMod.TestConnection((qryTERMS.FieldByName('CONN_LOCAL').AsInteger = 1),
                          qryTERMS.FieldByName('SERVER_NAME').AsString,
                          qryTERMS.FieldByName('DB_PATH').AsString,
                          qryTERMS.FieldByName('USER_NAME').AsString,
                          qryTERMS.FieldByName('PASS_WORD').AsString,
                          True);
end;

procedure TfrmTERM_FF.btnSirketYaratClick(Sender: TObject);
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



//****************************************************************************//
      if not DmYonet.GEN_AYARLA(DmYonet.ScriptExecutive,DmYonet.qryHedef1) then
      begin
        Application.MessageBox('GenAyarlama iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
        exit;
      end;
//****************************************************************************//

  DmYonet.dbaCreate.Close;
//****************************************************************************//
  ShowMessage('Dönem Oluþturma iþlemi baþarýyla tamamlandý.');
//****************************************************************************//
  btnKaydetClick(Self);
  mnuTESTClick(Self);
end;

procedure TfrmTERM_FF.btnDonemDevirClick(Sender: TObject);
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
       // ShowMessage('Cari grup uye kopyalama iþleminde hata oluþtu.');
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


// karanak devir //

  {$IfDef TRANSPORT}

//****************************************************************************//
  if not DmYonet.CopyEsyaToTerm then
  begin
    ShowMessage('Esya kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//

//****************************************************************************//
  if not DmYonet.CopyPersonelToTerm then
  begin
    ShowMessage('Personel kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopySoforToTerm then
  begin
    ShowMessage('Þöför kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//

//****************************************************************************//
  if not DmYonet.CopyAracToTerm then
  begin
    ShowMessage('Araç kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopyAracRuhsatToTerm then
  begin
    ShowMessage('Araç Ruhsat kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//

  {$EndIf}



  {$IfDef SERVIS}
//****************************************************************************//
  if not DmYonet.CopyPersonelToTerm then
  begin
    ShowMessage('Personel kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopySoforToTerm then
  begin
    ShowMessage('Þöför kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopyBayiToTerm then
  begin
    ShowMessage('Bayi kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopyMarkaToTerm then
  begin
    ShowMessage('Marka kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//

//****************************************************************************//
  if not DmYonet.CopyMarkaTipToTerm then
  begin
    ShowMessage('Marka Tipi kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopySigortaToTerm then
  begin
    ShowMessage('Sigorta Þirketi kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//

//****************************************************************************//
  if not DmYonet.CopyArizaTipToTerm then
  begin
    ShowMessage('Arýza Tipi kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopyGelisNedenTipToTerm then
  begin
    ShowMessage('Geliþ Nedenleri kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//
//****************************************************************************//
  if not DmYonet.CopySrvAracToTerm then
  begin
    ShowMessage('Servis Araç kopyalama iþleminde hata oluþtu.');
  end;
//****************************************************************************//




  {$EndIf}

  //****************************************************************************//
  if not DmYonet.CopySayaclarToTerm then
  begin
    ShowMessage('Sayaclar Tablosu kopyalama iþleminde hata oluþtu.');
    //exit;
  end;


  //****************************************************************************//
  if not DmYonet.CopySayaclarNuToTerm then
  begin
    ShowMessage('SayaclarNu Tablosu kopyalama iþleminde hata oluþtu.');
    //exit;
  end;


  {$IfDef ANTREPO}
  if not DmYonet.Antrep then
  begin
    ShowMessage('ANTREPO kopyalama iþleminde hata oluþtu.');
  end;

  {$EndIf}





//****************************************************************************//
      if not DmYonet.GEN_AYARLA(DmYonet.ScriptExecutive,DmYonet.qryHedef1) then
      begin
        Application.MessageBox('GenAyarlama iþleminde hata oluþtu.','Dikkat',MB_ICONERROR);
       // exit;
      end;
//****************************************************************************//


// karanak devir son //


  DmYonet.dbaCreate.Close;
//****************************************************************************//
  ShowMessage('Þirket yaratýlarak önceki dönemden devir iþlemi baþarýyla tamamlandý.');
//****************************************************************************//
  btnKaydetClick(Self);
  mnuTESTClick(Self);
end;

end.
