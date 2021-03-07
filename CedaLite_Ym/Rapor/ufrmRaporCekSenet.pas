unit ufrmRaporCekSenet;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Controls, Buttons, StdCtrls, ExtCtrls,
  ComCtrls, IB_Components,Mask, frxClass, frxIBOSet,cxSSTypes,cxSSHeaders ;

type
  TfrmRaporCekSenet = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryRapor: TIB_Cursor;
    chk_Sirket: TCheckBox;
    GroupBox1: TGroupBox;
    tanzim_Tarihi: TGroupBox;
    TanzimTar1: TDateTimePicker;
    TanzimTar2: TDateTimePicker;
    tanzim_ekle: TCheckBox;
    vade_Tarihi: TGroupBox;
    VadeTar1: TDateTimePicker;
    VadeTar2: TDateTimePicker;
    vade_ekle: TCheckBox;
    GroupBox2: TGroupBox;
    durum: TRadioGroup;
    yer_kodu: TRadioGroup;
    GroupBox3: TGroupBox;
    tip: TRadioGroup;
    grp_Banka: TGroupBox;
    txt_Banka: TEdit;
    btnBankaKod: TButton;
    sadece_banka: TCheckBox;
    GroupBox4: TGroupBox;
    tutar: TGroupBox;
    Label1: TLabel;
    tutar1: TIB_Currency;
    tutar2: TIB_Currency;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    GroupBox5: TGroupBox;
    lbl_CARIKOD: TLabel;
    lbl_CARI: TLabel;
    btnCARI: TButton;
    chkCARI: TCheckBox;
    GroupBox6: TGroupBox;
    txtBelgeNo: TEdit;
    cmbTIPSEC: TComboBox;
    frxReport1: TfrxReport;
    frxIBODts_Cek_Har: TfrxIBODataset;
    IB_Query1: TIB_Query;
    frxIBODts_Senet_Har: TfrxIBODataset;
    IB_Query2: TIB_Query;
    Btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure yaz(rapor_tipi:byte);
    procedure baslik_ekle(rapor_tipi:Byte);
    procedure rapor_hazirla;
    procedure Form_Open(tip : SmallInt);
////////////////////////////////////////////////////////////////////////////////
    procedure btnRaporClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure tutar1KeyPress(Sender: TObject; var Key: Char);
    procedure tutar2KeyPress(Sender: TObject; var Key: Char);
    procedure frmRaporCiktisi_Open(strSQL:String);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnBankaKodClick(Sender: TObject);
    procedure txt_BankaKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txt_BankaExit(Sender: TObject);
    procedure TanzimTar1Enter(Sender: TObject);
    procedure TanzimTar1Exit(Sender: TObject);
    procedure tanzim_ekleEnter(Sender: TObject);
    procedure tanzim_ekleExit(Sender: TObject);
    procedure durumEnter(Sender: TObject);
    procedure durumExit(Sender: TObject);
    procedure txt_BankaEnter(Sender: TObject);
    procedure tutar1Enter(Sender: TObject);
    procedure tutar1Exit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure btnCARIClick(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    Islem_Tipi :SmallInt;
    row,col:Integer;
    prv_Cari_KOD:String;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    deger : SmallInt;
    { Public declarations }
  end;
  const cns_rapor_cek = 5;
  const cns_rapor_senet = 6;
var
//  ChildForm : TfrmRaporCekSenet;
  frmRaporCekSenet: TfrmRaporCekSenet;
  frmRaporMusteriCek:TfrmRaporCekSenet;
  frmRaporBorcCek:TfrmRaporCekSenet;
  frmRaporMusteriSenet:TfrmRaporCekSenet;
  frmRaporBorcSenet:TfrmRaporCekSenet;
implementation

uses unDataMod, ufrmRaporCiktisi, ufrmCariSDLG, main, unFunc, DateUtils;

{$R *.dfm}

procedure TfrmRaporCekSenet.Form_Open(tip : SmallInt);
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  case tip of
  1://müþteri çekleri
    begin
      if DataMod.Modul_Hak(cns_rapor_cek,local_CanUpdate,local_CanDelete) = False then
      begin
        Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if not MainForm.FindChildFrm(Application,'frmRaporMusteriCek') then
        begin
          Application.CreateForm(TfrmRaporCekSenet,frmRaporMusteriCek);
          with frmRaporMusteriCek do
          begin
            Caption := 'Müþteri Çekleri Raporu';
            grp_Banka.Visible := False;
            Islem_Tipi := 1;
            deger := 0;

            if glb_SUBELI then
            begin
              if glb_SUBE_MUDAHALE then
              begin
                DataMod.FillSubeStr(cmbSube.Items);
                cmbSube.ItemIndex := 0;
                grpSube.Visible := True;
              end
              else
              begin
                with cmbSube do
                begin
                  Clear;
                  Items.Add(DataMod.SubeID2Ad(False,glb_SID));
                  ItemIndex := 0;
                  Enabled := False;
                end;
              end;
            end
            else
            begin
              grpSube.Visible := False;
            end;//end if glb_SUBELI then

          end;
        end
        else
        begin
          frmRaporMusteriCek.Show;
        end;
      end;
    end;
  2://borç çekleri
    begin
      if DataMod.Modul_Hak(cns_rapor_cek,local_CanUpdate,local_CanDelete)=False Then
      begin
        Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if not MainForm.FindChildFrm(Application,'frmRaporBorcCek') then
        begin
          Application.CreateForm(TfrmRaporCekSenet,frmRaporBorcCek);
          with frmRaporBorcCek do
          begin
            Caption := 'Borç Çekleri Raporu';
            tip.Enabled := false;
            grp_Banka.Visible := True;
            Islem_Tipi := 2;
            deger := 0;

            if glb_SUBELI then
            begin
              if glb_SUBE_MUDAHALE then
              begin
                DataMod.FillSubeStr(cmbSube.Items);
                cmbSube.ItemIndex := 0;
                grpSube.Visible := True;
              end
              else
              begin
                with cmbSube do
                begin
                  Clear;
                  Items.Add(DataMod.SubeID2Ad(False,glb_SID));
                  ItemIndex := 0;
                  Enabled := False;
                end;
              end;
            end
            else
            begin
              grpSube.Visible := False;
            end;//end if glb_SUBELI then
          end;
        end
        else
        begin
          frmRaporBorcCek.Show;
        end;
      end;
    end;
  3://müþteri senetleri
    begin
      if DataMod.Modul_Hak(cns_rapor_senet,local_CanUpdate,local_CanDelete)=False Then
      begin
        Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if not MainForm.FindChildFrm(Application,'frmRaporMusteriSenet') then
        begin
          Application.CreateForm(TfrmRaporCekSenet,frmRaporMusteriSenet);
          with frmRaporMusteriSenet do
          begin
            Caption := 'Müþteri Senetleri Raporu';
            grp_Banka.Visible := False;
            Islem_Tipi := 3;
            with cmbTIPSEC do
            begin
              Items.Clear;
              Items.Add('Fiþ Numarasý');
              ItemIndex := 0;
            end;

            if glb_SUBELI then
            begin
              if glb_SUBE_MUDAHALE then
              begin
                DataMod.FillSubeStr(cmbSube.Items);
                cmbSube.ItemIndex := 0;
                grpSube.Visible := True;
              end
              else
              begin
                with cmbSube do
                begin
                  Clear;
                  Items.Add(DataMod.SubeID2Ad(False,glb_SID));
                  ItemIndex := 0;
                  Enabled := False;
                end;
              end;
            end
            else
            begin
              grpSube.Visible := False;
            end;//end if glb_SUBELI then

          end;
        end
        else
        begin
          frmRaporMusteriSenet.Show;
        end;
      end;
    end;
  4://borç senetleri
    begin //start
      if DataMod.Modul_Hak(cns_rapor_senet,local_CanUpdate,local_CanDelete)=False Then
      begin
        Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
        exit;
      end
      else
      begin
        if not MainForm.FindChildFrm(Application,'frmRaporBorcSenet') then
        begin
          Application.CreateForm(TfrmRaporCekSenet,frmRaporBorcSenet);
          with frmRaporBorcSenet do
          begin
            Caption := 'Borç Senetleri Raporu';
            tip.Visible := false;
            GroupBox3.Visible := false;
            grp_Banka.Visible := false;
            with cmbTIPSEC do
            begin
              Items.Clear;
              Items.Add('Fiþ Numarasý');
              ItemIndex := 0;
            end;
            deger := 0;
            Islem_Tipi := 4;

            if glb_SUBELI then
            begin
              if glb_SUBE_MUDAHALE then
              begin
                DataMod.FillSubeStr(cmbSube.Items);
                cmbSube.ItemIndex := 0;
                grpSube.Visible := True;
              end
              else
              begin
                with cmbSube do
                begin
                  Clear;
                  Items.Add(DataMod.SubeID2Ad(False,glb_SID));
                  ItemIndex := 0;
                  Enabled := False;
                end;
              end;
            end
            else
            begin
              grpSube.Visible := False;
            end;//end if glb_SUBELI then

          end;
        end
        else
        begin
          frmRaporBorcSenet.Show;
        end;
      end;
    end;//stop
  end;//case end
end;



procedure TfrmRaporCekSenet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryRapor.Close;
  action := caFree;
end;

procedure TfrmRaporCekSenet.btnRaporClick(Sender: TObject);
var
  banka_Ad,strSQL,SQLSelect,SQLWhere,SQLBetween,SQLOrderBy:String;
  where_ek,order_ek : Boolean;
  SubeID : String;
begin
  if (TanzimTar1.Date>TanzimTar2.Date) then
  begin
    Application.MessageBox('Ýkinci iþlem tarihi birinci tarihten küçük olamaz.Lütfen iþlem tarihlerini kontrol ediniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  where_ek := false;
  order_ek := false;
  strSQL := '';
  SQLSelect := '';
  SQLWhere := '';
  SQLBetween := '';
  SQLOrderBy := '';
  case Islem_Tipi of
  1:
    begin
      SQLSelect := 'SELECT CEK_ID,CARI_KOD,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = CEK.CARI_KOD) AS CARI_AD,CEK.TANZIMTAR,CEK.VADETAR,CEK.CEK_SAHIBI,CEK.ACIKLAMA,CEK.BANKA_AD,CEK.CEK_NUM,CEK.DOVKOD,CEK.DOVKUR,CEK.TUTAR,CEK.TUTAR_VPB FROM CEK';
      SQLWhere := ' WHERE TIP = 1';
      case cmbTIPSEC.ItemIndex of
      0:
        begin
          if Trim(txtBelgeNo.Text) <> '' then
          begin
            SQLWhere := SQLWhere + ' AND CEK.CEK_ID = '+ txtBelgeNo.Text;
          end;
        end;
      1:
        begin
          if Trim(txtBelgeNo.Text) <> '' then
          begin
            SQLWhere := SQLWhere + ' AND CEK.CEK_NUM = '+ SQL_Katar(txtBelgeNo.Text);
          end;
        end;
      end;//end case
      if chkCARI.Checked then
      begin
        SQLWhere := SQLWhere + ' AND CEK.CARI_KOD = '+SQL_Katar(lbl_CARIKOD.Caption);
      end;
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          SQLWhere := SQLWhere + ' AND CEK.CEK_SID = ' + SubeID;
        end;
      end
      else
      begin
        SQLWhere := SQLWhere + ' AND CEK.CEK_SID = ' + inttostr(glb_SID);
      end;
      where_ek := True;
    end;
  2:
    begin
       SQLSelect := 'SELECT CEK_ID,CARI_KOD,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = CEK.CARI_KOD) AS CARI_AD,CEK.TANZIMTAR,CEK.VADETAR,CEK.ACIKLAMA,CEK.BANKA_AD,CEK.CEK_NUM,CEK.DOVKOD,CEK.DOVKUR,CEK.TUTAR,CEK.TUTAR_VPB FROM CEK';
       SQLWhere := ' WHERE TIP = 2';
       case cmbTIPSEC.ItemIndex of
       0:
         begin
           if Trim(txtBelgeNo.Text) <> '' then
           begin
             SQLWhere := SQLWhere + ' AND CEK.CEK_ID = '+ txtBelgeNo.Text;
           end;
         end;
       1:
         begin
           if Trim(txtBelgeNo.Text) <> '' then
           begin
             SQLWhere := SQLWhere + ' AND CEK.CEK_NUM = '+ SQL_Katar(txtBelgeNo.Text);
           end;
         end;//end case
       end;
       if chkCARI.Checked then
       begin
         SQLWhere := SQLWhere + ' AND CEK.CARI_KOD = '+SQL_Katar(lbl_CARIKOD.Caption);
       end;
       if glb_SUBELI then
       begin
         SubeID := DataMod.SubeAd2ID(cmbSube.Text);
         if SubeID <> '0' then
         begin
           SQLWhere := SQLWhere + ' AND CEK.CEK_SID = ' + SubeID;
         end;
       end
       else
       begin
         SQLWhere := SQLWhere + ' AND CEK.CEK_SID = ' + inttostr(glb_SID);
       end;
       where_ek := True;
    end;
  3:
    begin
      SQLSelect := 'SELECT SENET_ID,SENET.TANZIMTAR,SENET.VADETAR,SENET.SENET_SAHIBI,SENET.ACIKLAMA,SENET.TANZIM_YER,SENET.SENET_ID,SENET.DOVKOD,SENET.DOVKUR,SENET.TUTAR,SENET.TUTAR_VPB FROM SENET';
      SQLWhere := ' WHERE TIP = 1';

      if Trim(txtBelgeNo.Text) <> '' then
      begin
        SQLWhere := SQLWhere + ' AND SENET.SENET_ID = '+ txtBelgeNo.Text;
      end;

      if chkCARI.Checked then
      begin
        SQLWhere := SQLWhere + ' AND SENET.CARI_KOD = '+SQL_Katar(lbl_CARIKOD.Caption);
      end;
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          SQLWhere := SQLWhere + ' AND SENET.SENET_SID = ' + SubeID;
        end;
      end
      else
      begin
        SQLWhere := SQLWhere + ' AND SENET.SENET_SID = ' + inttostr(glb_SID);
      end;
      where_ek := True;
    end;
  4:
    begin
      SQLSelect := 'SELECT SENET_ID,SENET.TANZIMTAR,SENET.VADETAR,SENET.ACIKLAMA,SENET.TANZIM_YER,SENET.SENET_ID,SENET.DOVKOD,SENET.DOVKUR,SENET.TUTAR,SENET.TUTAR_VPB FROM SENET';
      SQLWhere := ' WHERE TIP = 2';
      if Trim(txtBelgeNo.Text) <> '' then
      begin
        SQLWhere := SQLWhere + ' AND SENET.SENET_ID = '+ txtBelgeNo.Text;
      end;
      if chkCARI.Checked then
      begin
        SQLWhere := SQLWhere + ' AND SENET.CARI_KOD = '+SQL_Katar(lbl_CARIKOD.Caption);
      end;
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          SQLWhere := SQLWhere + ' AND SENET.SENET_SID = ' + SubeID;
        end;
      end
      else
      begin
        SQLWhere := SQLWhere + ' AND SENET.SENET_SID = ' + inttostr(glb_SID);
      end;
      where_ek := True;
    end;
  end;

  case durum.ItemIndex of
  0://Beklemede
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND DURUM = 1';
      end
      else
      begin
        SQLWhere := ' WHERE DURUM = 1';
        where_ek := true;
      end;
    end;
  1://Ödenmiþ
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND DURUM = 2';
      end
      else
      begin
        SQLWhere := ' WHERE DURUM = 2';
        where_ek := true;
      end;
    end;
  2://Protestolu
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND DURUM = 3';
      end
      else
      begin
        SQLWhere := ' WHERE DURUM = 3';
        where_ek := true;
      end;
    end;
  3://iptal
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND DURUM = 4';
      end
      else
      begin
        SQLWhere := ' WHERE DURUM = 4';
        where_ek := true;
      end;
    end;
  4://hepsi
    begin
    end;
  end;//end case

  case yer_kodu.ItemIndex of
  0://portfoyde
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND YER_KOD = 1';
      end
      else
      begin
        SQLWhere := ' WHERE YER_KOD = 1';
        where_ek := true;
      end;
    end;
  1://ciro
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND YER_KOD = 2';
      end
      else
      begin
        SQLWhere := ' WHERE YER_KOD = 2';
        where_ek := true;
      end;
    end;
  2://tahsil
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND YER_KOD = 3';
      end
      else
      begin
        SQLWhere := ' WHERE YER_KOD = 3';
        where_ek := true;
      end;
    end;
  3://teminat
    begin
      if where_ek then
      begin
        SQLWhere := SQLWhere + ' AND YER_KOD = 4';
      end
      else
      begin
        SQLWhere := ' WHERE YER_KOD = 4';
        where_ek := true;
      end;
    end;
  4://hepsi
    begin
    end;
  end;//end case

  case Islem_Tipi of
  1,3:
     begin
       case tip.ItemIndex of
       0:
        begin
          if where_ek then
          begin
            SQLWhere := SQLWhere + ' AND ASIL = 0';
          end
          else
          begin
            SQLWhere := ' WHERE ASIL = 0';
            where_ek := true;
          end;
        end;
       1:
        begin
          if where_ek then
          begin
            SQLWhere := SQLWhere + ' AND ASIL = 1';
          end
          else
          begin
            SQLWhere := ' WHERE ASIL = 1';
            where_ek := true;
          end;
        end;
       end;//end case tip
     end;
  end;//end case Islem_Tipi

  if (tutar1.value <> 0) then
  begin
    if where_ek then
    begin
      SQLWhere := SQLWhere + ' AND TUTAR_VPB > ' + CurrToStr(tutar1.value);
    end
    else
    begin
      SQLWhere := ' WHERE TUTAR_VPB > ' + CurrToStr(tutar1.value);
      where_ek := true;
    end;
  end;


  if (tutar2.value <> 0) then
  begin
    if where_ek then
    begin
      SQLWhere := SQLWhere + ' AND TUTAR_VPB < ' + CurrToStr(tutar2.value);
    end
    else
    begin
      SQLWhere := ' WHERE TUTAR_VPB < ' + CurrToStr(tutar2.value);
      where_ek := true;
    end;
  end;

  if tanzim_ekle.Checked then
  begin
    if where_ek then
    begin
      SQLBetween := ' AND TANZIMTAR BETWEEN ' + SQL_Tarih(TanzimTar1.Date) + ' AND ' + SQL_Tarih(TanzimTar2.Date);
    end
    else
    begin
      SQLBetween := ' WHERE TANZIMTAR BETWEEN ' + SQL_Tarih(TanzimTar1.Date) + ' AND ' + SQL_Tarih(TanzimTar2.Date);
    end;
  end;

  if vade_ekle.Checked then
  begin
    if where_ek then
    begin
      SQLBetween := SQLBetween + ' AND VADETAR BETWEEN ' + SQL_Tarih(VadeTar1.Date) + ' AND ' + SQL_Tarih(VadeTar2.Date);
    end
    else
    begin
      SQLBetween := SQLBetween + ' WHERE VADETAR BETWEEN ' + SQL_Tarih(VadeTar1.Date) + ' AND ' + SQL_Tarih(VadeTar2.Date);
    end;
  end;

  if sadece_banka.Checked then
  begin
    if Length(trim(txt_Banka.Text)) <> 0 then
    begin
      if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txt_Banka.Text,banka_Ad) then
      begin
        if where_ek then
        begin
          SQLWhere := SQLWhere + ' AND BANKA_KOD = ' + SQL_Katar(txt_Banka.Text);
        end
        else
        begin
          SQLWhere := SQLWhere + ' WHERE BANKA_KOD = ' + SQL_Katar(txt_Banka.Text);
        end;
      end;
    end;
  end;

  if tanzim_ekle.Checked then
  begin
    if order_ek then
    begin
      SQLOrderBy := SQLOrderBy + ',TANZIMTAR';
    end
    else
    begin
      SQLOrderBy := SQLOrderBy + ' ORDER BY TANZIMTAR';
      order_ek := true;
    end;
  end;

  if vade_ekle.Checked then
  begin
    if order_ek then
    begin
      SQLOrderBy := SQLOrderBy + ',VADETAR';
    end
    else
    begin
      SQLOrderBy := SQLOrderBy + ' ORDER BY VADETAR';
    end;
  end;
  strSQL := SQLSelect+SQLWhere+SQLBetween+SQLOrderBy;





       if Sender=Btn_Fast then
       begin
          Prv_Yazdirildi:=False;
         case Islem_Tipi of
         1,2:begin
                with IB_Query1 do
                begin
                  Active := false;
                  SQL.Clear;
                  SQL.Add(strSQL);
                  Active := True;
                end;

                if ((IB_Query1.Eof) and (IB_Query1.bof))then
                begin
                  Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
                  qryRapor.Close;
                  Exit;
                end;

                if Islem_Tipi=1 then
                 frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cek_Mus_Listesi.fr3');
                if Islem_Tipi=2 then
                 frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cek_Listesi.fr3');

             end;

         3,4:Begin
                with IB_Query2 do
                begin
                  Active := false;
                  SQL.Clear;
                  SQL.Add(strSQL);
                  Active := True;
                end;

                if ((IB_Query2.Eof) and (IB_Query2.bof))then
                begin
                  Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
                  qryRapor.Close;
                  Exit;
                end;

                if Islem_Tipi=3 then
                 frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Senet_Mus_Listesi.fr3');
                if Islem_Tipi=4 then
                 frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Senet_Listesi.fr3');


          end;
          end;



          {if chk_Sayfalar.Checked then
          begin
          a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
          a.StartNewPage:=True;
          end;
          }
          //frxReport1.PrepareReport();
          frxReport1.showReport;
          Exit;
      end;


  frmRaporCiktisi_Open(strSQL);
  SQLSelect := '';
  SQLWhere := '';
  SQLBetween := '';
  SQLOrderBy := '';
  strSQL := '';
end;


procedure TfrmRaporCekSenet.frmRaporCiktisi_Open(strSQL:String);
//rapor tipi 1 ise glb_defcur seçilidir.
//rapor tipi 2 ise takipli kurlardan birisi seçilidir.
begin
  with qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((qryRapor.Eof) and (qryRapor.bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    rapor_hazirla;
    if chk_Sirket.Checked then
    begin
      frmRaporCiktisi.SetCellFont(0,2,12,2,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(0,2,1,2,haRight,vaCenter);
      case Islem_Tipi of
      1:
        begin
          frmRaporCiktisi.SetCellAlignment(4,2,6,2,haLEFT,vaCenter);
          frmRaporCiktisi.SetCellAlignment(5,2,5,2,haRight,vaCenter);
        end;
      2:
        begin
          frmRaporCiktisi.SetCellAlignment(4,2,8,2,haRight,vaCenter);
          frmRaporCiktisi.SetCellAlignment(5,2,5,2,haLEFT,vaCenter);
        end;
      3:
        begin
          frmRaporCiktisi.SetCellAlignment(5,2,9,2,haRight,vaCenter);
          frmRaporCiktisi.SetCellAlignment(6,2,6,2,haLEFT,vaCenter);
        end;
      4:
        begin
          frmRaporCiktisi.SetCellAlignment(4,2,8,2,haRight,vaCenter);
          frmRaporCiktisi.SetCellAlignment(5,2,5,2,haLEFT,vaCenter);
        end;
      end;//end case
      frmRaporCiktisi.SetCellAlignment(7,2,9,2,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,9,1,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(0,1,1,1,haRight,vaCenter);
      case Islem_Tipi of
      1:
        begin
          frmRaporCiktisi.SetCellAlignment(4,1,6,1,haLEFT,vaCenter);
          frmRaporCiktisi.SetCellAlignment(5,1,5,1,haRight,vaCenter);
        end;
       2:
         begin
           frmRaporCiktisi.SetCellAlignment(4,1,8,1,haRight,vaCenter);
           frmRaporCiktisi.SetCellAlignment(5,1,5,1,haLEFT,vaCenter);
         end;
       3:
         begin
          frmRaporCiktisi.SetCellAlignment(5,1,9,1,haRight,vaCenter);
          frmRaporCiktisi.SetCellAlignment(6,1,6,1,haLEFT,vaCenter);
         end;
       4:
         begin
           frmRaporCiktisi.SetCellAlignment(4,1,8,1,haRight,vaCenter);
           frmRaporCiktisi.SetCellAlignment(5,1,5,1,haLEFT,vaCenter);
          end;
      end;//end case
      frmRaporCiktisi.SetCellAlignment(7,1,9,1,haRight,vaCenter);
    end;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporCekSenet.rapor_hazirla;
var
  res_Cari : TStringList;
  grup_adi : String;
begin
  grup_adi := '';
  row := 0;
  col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 1;
  end;
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  case Islem_Tipi of
  1:
    begin
      frmRaporCiktisi.SetCellText(row,col+2,'Müþteri Çekleri Raporu');
      frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
      baslik_ekle(1);
      yaz(1);
    end;
  2:
    begin
      frmRaporCiktisi.SetCellText(row,col+2,'Borç Çekleri Raporu');
      frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
      baslik_ekle(2);
      yaz(2);
    end;
  3:
    begin
      frmRaporCiktisi.SetCellText(row,col+2,'Müþteri Senetleri Raporu');
      frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
      baslik_ekle(3);
      yaz(3);
    end;
  4:
    begin
      frmRaporCiktisi.SetCellText(row,col+2,'Borç Senetleri Raporu');
      frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
      baslik_ekle(4);
      yaz(4);
    end;
  end;
end;//procedure end

procedure TfrmRaporCekSenet.yaz(rapor_tipi:byte);
begin
  col := 0;
  qryRapor.First;
  while not qryRapor.Eof do
  begin

    DataMod.Rapor_Satir_Renklendir(col,row,15);

    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TANZIMTAR').AsDateTime);
    inc(col);
    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('VADETAR').AsDateTime);
    inc(col);
    case rapor_tipi of
    1:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CEK_SAHIBI').AsString);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_KOD').AsString);
        frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_AD').AsString);
        inc(col);
      end;
    3:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SENET_SAHIBI').AsString);
        inc(col);
      end;
    end;
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    inc(col);

    case rapor_tipi of
    1,2:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BANKA_AD').AsString);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CEK_ID').AsString);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CEK_NUM').AsString);
      end;
    3,4:
      begin
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TANZIM_YER').AsString);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SENET_ID').AsString);
      end;
    end;

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKUR').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    if qryRapor.FieldByName('DOVKOD').AsString <> glb_DEFCUR then
    begin
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR').AsString);
      frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end
    else
    begin
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR').AsString);
      frmRaporCiktisi.format_ayarla(col,row,col,row);
    end;
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
    inc(col);
    col := 0;
    inc(row);
    qryRapor.Next;
  end;
end;


procedure TfrmRaporCekSenet.baslik_ekle(rapor_tipi:Byte);
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Tanzim Tarihi');
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Vade Tarihi');
  case rapor_tipi of
  1:
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Çek Sahibi');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Cari Kod');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Cari Ad');
    end;
  3:
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Senet Sahibi');
    end;
  end;
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Açýklama');
  case rapor_tipi of
  1,2:
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Banka Adý');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Belge Numarasý');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Çek Numarasý');
    end;
  3,4:
    begin
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Senet Tanzim Yeri');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'Senet Numarasý');
    end;
  end;
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Para Birimi');
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Döviz Kuru');
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Tutar');
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,'Tutar VPB');
  inc(col);
  inc(row);
end;

procedure TfrmRaporCekSenet.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  TanzimTar1.DateTime := glb_DONEM_BAS;
  VadeTar1.DateTime := glb_DONEM_BAS;
  TanzimTar2.Date := DataMod.GET_SERVER_DATE;
  VadeTar2.Date := TanzimTar2.Date;
  lbl_CARI.Caption := '';
  lbl_CARIKOD.Caption := '';
end;

procedure TfrmRaporCekSenet.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporCekSenet.tutar1KeyPress(Sender: TObject; var Key: Char);
var
  tutar : String;
begin
  if not (Key = #8) then
  begin
    if Trim(Key)='' then Key := #0;
  end;
  tutar := tutar1.text;
  if (Length(currtostr(tutar1.value)) > 14) then
  begin
    Application.MessageBox('Bu deðerden fazla bir deðer giremezsiniz','Dikkat',MB_ICONWARNING);
    tutar1.Text := tutar;
    Key := #0;
  end;
end;

procedure TfrmRaporCekSenet.tutar2KeyPress(Sender: TObject; var Key: Char);
var
  tutar : String;
begin
  if not (Key = #8) then
  begin
    if Trim(Key)='' then Key := #0;
  end;
  tutar := tutar2.Text;
  if (Length(currtostr(tutar2.value)) > 14) then
  begin
    Application.MessageBox('Bu deðerden fazla bir deðer giremezsiniz','Dikkat',MB_ICONWARNING);
    tutar2.Text := tutar;
    Key := #0;
  end;
end;


procedure TfrmRaporCekSenet.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    close;
  end;
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmRaporCekSenet.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(Self);
end;

procedure TfrmRaporCekSenet.btnBankaKodClick(Sender: TObject);
var
  banka_Kod,banka_Ad:String;
begin
  if frmCariSDLG.Form_Open(False,banka_Kod,banka_Ad,0) Then
  begin
    txt_Banka.Text := banka_Kod;
  end;
end;

procedure TfrmRaporCekSenet.txt_BankaKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnRaporClick(Self);
end;

procedure TfrmRaporCekSenet.txt_BankaExit(Sender: TObject);
var
  banka_Ad:String;
begin
  if Trim(txt_Banka.Text) <> '' then
  begin
    if not DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txt_Banka.Text,banka_Ad) then
    begin
      txt_Banka.SetFocus;
    end
    else
    begin
      (Sender as TEdit).Color := clWindow;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmRaporCekSenet.TanzimTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCekSenet.TanzimTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporCekSenet.tanzim_ekleEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCekSenet.tanzim_ekleExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporCekSenet.durumEnter(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCekSenet.durumExit(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := clBtnFace;
end;

procedure TfrmRaporCekSenet.txt_BankaEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCekSenet.tutar1Enter(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCekSenet.tutar1Exit(Sender: TObject);
begin
  (Sender as TIB_Currency).Color := clWindow;
end;

procedure TfrmRaporCekSenet.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCekSenet.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporCekSenet.btnCARIClick(Sender: TObject);
var
  CARI_KOD,CARI_AD : String;
begin
  if frmCariSDLG.Form_Open(False,CARI_KOD,CARI_AD,1) Then
  begin
    chkCARI.Checked := True;
    lbl_CARIKOD.Caption := CARI_KOD;
    lbl_CARI.Caption := CARI_AD;
    prv_Cari_KOD := CARI_KOD;
  end;
end;

procedure TfrmRaporCekSenet.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin
       if chk_Sirket.Checked then
       begin
         res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;
       end
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);

      {
       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
        }

       Prv_Yazdirildi:=True;
    end;




end;

end.
