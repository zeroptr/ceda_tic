unit ufrmRaporSkAracHareketleriRaporu;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  IB_Components,cxSSTypes,cxSSHeaders, frxClass, frxIBOSet;

type
  TfrmRaporSkAracHareketleriRaporu = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    cmb_sirala: TComboBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    qryRapor: TIB_Cursor;
    GroupBox1: TGroupBox;
    txtAracKod1: TEdit;
    Button1: TButton;
    txtAracKod2: TEdit;
    Button2: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    qryRaporH: TIB_Cursor;
    Label22: TLabel;
    txtAlanPers: TEdit;
    Button8: TButton;
    Label18: TLabel;
    frxReport1: TfrxReport;
    frxIBODataset1: TfrxIBODataset;
    qrySefer: TIB_Query;
    Btn_Fast: TButton;
    frxIBODataset2: TfrxIBODataset;
    IB_Query1: TIB_Query;
    Cb_Yeni_Sayfa: TCheckBox;
    Label1: TLabel;
    LblPlaka: TLabel;
    Label36: TLabel;
    Label19: TLabel;
    txtArac: TEdit;
    Button9: TButton;
    TxtMazotcu: TEdit;
    Button7: TButton;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    cb_Satici: TCheckBox;
    Cb_Alici: TCheckBox;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Tip:String);
    procedure frmRaporCiktisi_Open(strSQL : String);
    procedure alan_isimlerini_ekle;
    procedure yaz;
    procedure kod_cikis(kod : TEdit);
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure txtAracKod1Exit(Sender: TObject);
    procedure txtAracKod2Exit(Sender: TObject);
    procedure txtAracKod1KeyPress(Sender: TObject; var Key: Char);
    procedure txtAracKod1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure txtAracKod2KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtAracKod1Enter(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure txtAracExit(Sender: TObject);
    procedure txtAlanPersExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtAracEnter(Sender: TObject);
    procedure frxReport1AfterPrint(Sender: TfrxReportComponent);
    procedure TxtMazotcuExit(Sender: TObject);
  private
    row,col:integer;
    prv_Tip:String;
    Gnl_Alacak,Gnl_Borc:Double;
    Prv_Yazdirildi:Boolean;
    procedure alan_isimlerini_ekleH;
    procedure yazH;
    function Alt_Ac: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_Arac_listesi = 34 ;
var
  frmRaporSkAracHareketleriRaporu: TfrmRaporSkAracHareketleriRaporu;

implementation

uses unDataMod, unFunc, ufrmRaporCiktisi,main, ufrmCariSDLG;

{$R *.dfm}

procedure TfrmRaporSkAracHareketleriRaporu.Form_Open(Tip:String);
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Arac_listesi,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporAracHareketleriListesi') then
    begin
      Application.CreateForm(TfrmRaporSkAracHareketleriRaporu, frmRaporSkAracHareketleriRaporu);
      frmRaporSkAracHareketleriRaporu.prv_Tip:=Tip;

      if frmRaporSkAracHareketleriRaporu.prv_Tip='Sirket' then
      begin
       frmRaporSkAracHareketleriRaporu.cb_Satici.Visible:=False;
       frmRaporSkAracHareketleriRaporu.Cb_Yeni_Sayfa.Caption:='Her Araç Yeni Sayfada';
      end;

      if frmRaporSkAracHareketleriRaporu.prv_Tip='Kiralýk' then
      begin
           frmRaporSkAracHareketleriRaporu.Label36.Visible:=True;
           frmRaporSkAracHareketleriRaporu.TxtMazotcu.Visible:=True;
           frmRaporSkAracHareketleriRaporu.Button7.Visible:=True;
           frmRaporSkAracHareketleriRaporu.Label19.Visible:=True;
      end;

      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporSkAracHareketleriRaporu.cmbSube.Items);
          with frmRaporSkAracHareketleriRaporu do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporSkAracHareketleriRaporu.cmbSube do
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
        frmRaporSkAracHareketleriRaporu.grpSube.Visible := False;
        //frmRaporCariBakiyeliHareket.cmbSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryRapor.Close;
  Action := caFree;
end;

procedure TfrmRaporSkAracHareketleriRaporu.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporSkAracHareketleriRaporu.txtAracKod1Exit(Sender: TObject);
begin
  kod_cikis(txtAracKod1);
end;

procedure TfrmRaporSkAracHareketleriRaporu.txtAracKod2Exit(Sender: TObject);
begin
  kod_cikis(txtAracKod2);
end;

procedure TfrmRaporSkAracHareketleriRaporu.kod_cikis(kod : TEdit);
var
 ARAC_KOD:String;
begin
  if Length(Trim(kod.Text))=0 then
  begin
    kod.Color := clWindow;
    exit;
  end;

  if not DataMod.FN_KOD2AD('ARAC','ARAC_KOD','ARAC_KOD',kod.Text,ARAC_KOD) then
  begin
    Application.MessageBox('Araç Kodu Bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.txtAracKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporSkAracHareketleriRaporu.txtAracKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporSkAracHareketleriRaporu.txtAracKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporSkAracHareketleriRaporu.Button1Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      txtAracKod1.Text := ARAC_KOD;
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.Button2Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      txtAracKod2.Text := ARAC_KOD;
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.btnRaporClick(Sender: TObject);
var
  strSQL,SubeID:String;
  W_strSQL,W_strSQLs:String;
  where_ek : Boolean;
  a:TfrxGroupHeader;//TfrxComponent;  
begin
  where_ek := false;

  strSQL :=
  'SELECT ARAC_KOD '+
  '     , PLAKA '+
  '     , ARAC_TIP '+
  '     , OZ_MAL '+
  '     , CARI_KOD '+
  '     ,(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KOD) AS CARI_ADI '+
  '     , ACIKLAMA '+
  '     , BORC '+
  '     , ALACAK '+
  '     , AKTIF_DEGIL '+
  '     , YAKIT_LITRE '+
  '     , TRF_SIG_GEC_TAR '+
  '     , KASKO_SIG_GEC_TAR '+
  '     , PERSONEL_KOD '+
  '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=ARAC.PERSONEL_KOD) AS PERSONEL_ADI '+
  'FROM ARAC ';


  W_strSQL:='';
  W_strSQLs:='';

  if ((Length(Trim(txtAracKod1.Text)) <> 0) and (Length(Trim(txtAracKod2.Text))<>0)) then
  begin
    strSQL := strSQL + ' WHERE ARAC.ARAC_KOD BETWEEN ' + SQL_Katar(txtAracKod1.Text) + ' AND ' + SQL_Katar(txtAracKod2.Text);
    W_strSQL:= ' and SEFER.ARAC_KOD BETWEEN ' + SQL_Katar(txtAracKod1.Text) + ' AND ' + SQL_Katar(txtAracKod2.Text);
    W_strSQLs:= W_strSQLs + ' and ARAC.ARAC_KOD BETWEEN ' + SQL_Katar(txtAracKod1.Text) + ' AND ' + SQL_Katar(txtAracKod2.Text);
    where_ek := true;
  end
  else
  if txtAracKod1.Text<>'' then
  begin
    strSQL := strSQL + ' WHERE ARAC.ARAC_KOD = ' + SQL_Katar(txtAracKod1.Text);
    W_strSQL := W_strSQL + ' and SEFER.ARAC_KOD = ' + SQL_Katar(txtAracKod1.Text);
    W_strSQLs := W_strSQLs + ' and ARAC.ARAC_KOD = ' + SQL_Katar(txtAracKod1.Text);
    where_ek := true;
  end
  else

  if txtArac.Text<>'' then
  begin
    strSQL := strSQL + ' WHERE ARAC.ARAC_KOD = ' + SQL_Katar(txtArac.Text);
    W_strSQL:= W_strSQL+ ' and SEFER.ARAC_KOD = ' + SQL_Katar(txtArac.Text);
    W_strSQLs := W_strSQLs + ' and ARAC.ARAC_KOD = ' + SQL_Katar(txtArac.Text);
    where_ek := true;
  end;


  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      if where_ek then
      begin
        strSQL := strSQL + ' AND ARAC.ARAC_SID = ' + SubeID;
        W_strSQL:= W_strSQL+' AND SEFER.SEFER_SID = ' + SubeID;
        W_strSQLs := W_strSQLs + ' AND ARAC.ARAC_SID = ' + SubeID;
      end
      else
      begin
        strSQL := strSQL + ' WHERE ARAC.ARAC_SID = ' + SubeID;
        W_strSQL:= W_strSQL+' and SEFER.SEFER_SID = ' + SubeID;
        W_strSQLs := W_strSQLs + ' and ARAC.ARAC_SID = ' + SubeID;
        where_ek := true;
      end;
    end
  end
  else
  begin
    if where_ek then
    begin
      strSQL := strSQL + ' AND ARAC.ARAC_SID = ' + inttostr(glb_SID);
      W_strSQL:= W_strSQL+' AND SEFER.SEFER_SID = ' + inttostr(glb_SID);
      W_strSQLs := W_strSQLs + ' AND ARAC.ARAC_SID = ' + inttostr(glb_SID);
    end
    else
    begin
      strSQL := strSQL + ' WHERE ARAC.ARAC_SID = ' + inttostr(glb_SID);
      W_strSQL:= W_strSQL+' and SEFER.SEFER_SID = ' + inttostr(glb_SID);
      W_strSQLs := W_strSQLs + ' and ARAC.ARAC_SID = ' + inttostr(glb_SID);
      where_ek := true;
    end;
  end;


  if prv_Tip='Sirket' then
  if where_ek then
  begin
    strSQL := strSQL + ' AND ARAC.OZ_MAL =1 ';
    W_strSQL:= W_strSQL+' AND SEFER.SATICI_KOD = ''''';
    W_strSQLs := W_strSQLs + ' AND ARAC.OZ_MAL =1 ';
  end
  else
  begin
    strSQL := strSQL + ' WHERE ARAC.OZ_MAL =1 ';
    W_strSQL:= W_strSQL+' and SEFER.SATICI_KOD = ''''';
    W_strSQLs := W_strSQLs + ' and ARAC.OZ_MAL =1 ';
    where_ek := true;
  end;


  if prv_Tip='Kiralýk' then
  if where_ek then
  begin
    strSQL := strSQL + ' AND ARAC.OZ_MAL =0 ';
    W_strSQLs := W_strSQLs + ' AND ARAC.OZ_MAL =0 ';
    W_strSQL:= W_strSQL+' AND SEFER.SATICI_KOD <> ''''';
  end
  else
  begin
    strSQL := strSQL + ' WHERE ARAC.OZ_MAL =0 ';
    W_strSQLs := W_strSQLs + ' and ARAC.OZ_MAL =0 ';
    W_strSQL:= W_strSQL+' and SEFER.SATICI_KOD <> ''''';
    where_ek := true;
  end;


  if Trim(TxtMazotcu.Text)<>'' then
  begin
      if where_ek then
      begin
        strSQL := strSQL + ' AND ARAC.CARI_KOD ='+SQL_Katar(Trim(TxtMazotcu.Text));
        w_strSQLs := W_strSQLs + ' AND ARAC.CARI_KOD ='+SQL_Katar(Trim(TxtMazotcu.Text));
        W_strSQL:= W_strSQL+' AND SEFER.SATICI_KOD ='+SQL_Katar(Trim(TxtMazotcu.Text));;
      end
      else
      begin
        strSQL := strSQL + ' WHERE ARAC.CARI_KOD ='+SQL_Katar(Trim(TxtMazotcu.Text));
        W_strSQLs := W_strSQLs + ' and ARAC.CARI_KOD ='+SQL_Katar(Trim(TxtMazotcu.Text));
        W_strSQL:= W_strSQL+' and SEFER.SATICI_KOD ='+SQL_Katar(Trim(TxtMazotcu.Text));;
        where_ek := true;
      end;

  end;


  if where_ek then
  begin
     //strSQL:= strSQL+' AND BIT_TAR BETWEEN '+Sql_Tarih(dtpIslemTar1.date)+' AND '+Sql_Tarih(dtpIslemTar2.date)+' ';
     W_strSQLs:= W_strSQLs+' AND TARIH BETWEEN :TAR1 AND :TAR2 ';
     W_strSQL:= W_strSQL+' AND BIT_TAR BETWEEN :TAR1 AND :TAR2 ';
  end
  else
  begin
     //strSQL:= strSQL+' AND BIT_TAR BETWEEN '+Sql_Tarih(dtpIslemTar1.date)+' AND '+Sql_Tarih(dtpIslemTar2.date)+' ';
     W_strSQLs:= W_strSQLs+' AND TARIH BETWEEN :TAR1 AND :TAR2 ';
     W_strSQL:= W_strSQL+' AND BIT_TAR BETWEEN :TAR1 AND :TAR2 ';
  end;


  case cmb_sirala.ItemIndex of
  0:
    begin
      strSQL := strSQL + ' ORDER BY ARAC.ARAC_KOD';
      //W_strSQLs := W_strSQLs + ' ORDER BY ARAC.ARAC_KOD';
     // W_strSQL:= W_strSQL+' ORDER BY SEFER.ARAC_KOD';
    end;
  1:
    begin
      strSQL := strSQL + ' ORDER BY ARAC.PLAKA';
      //W_strSQLs := W_strSQLs + ' ORDER BY ARAC.PLAKA';
      //W_strSQL:= W_strSQL+' ORDER BY ARAC.PLAKA';
    end;
  end;




  if sender=Btn_Fast then
  begin

       Prv_Yazdirildi:=False;


       if prv_Tip='Kiralýk' then
       begin
           qrySefer.Close;
           qrySefer.Sql.Clear;
           qrySefer.Sql.Add(
           ' SELECT K.SEFER_ID '+#13+
           '     , K.SEFER_SID '+#13+
           '     , K.SEFER_SAY '+#13+
           '     , K.ARAC_KOD '+#13+
           //'     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ARAC_PLAKA '+#13+
           '     , ARAC.PLAKA '+#13+
           '     , ARAC.PLAKA  AS ARAC_PLAKA'+#13+
           '     , K.ALICI_KOD '+#13+
           '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI '+#13+
           '     , K.SATICI_KOD '+#13+
           '     ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD) AS SATICI_ADI '+#13+
           '     , ARAC.CARI_KOD '+#13+
           '     , K.PERSONEL_KOD '+#13+
           '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI '+#13+
           '     , K.OLCU_TIP '+#13+
           '     , K.OLCU_BIRIM '+#13+
           '     , K.TASINAN_ESYA '+#13+
           '     , K.BAS_TAR '+#13+
           '     , K.BIT_TAR '+#13+
           '     , K.CIK_YER '+#13+
           '     , K.BIT_YER '+#13+
           '     , K.ALICI_BORC_BIRIM_FIY '+#13+
           '     , K.ALICI_B_DOVKOD '+#13+
           '     , K.ALICI_BORC '+#13+
           '     , K.ALICI_BORC_VPB '+#13+
           '     , K.SATICI_ALACAK_BIRIM_FIY '+#13+
           '     , K.SATICI_A_DOVKOD '+#13+
           '     , K.SATICI_ALACAK '+#13+
           '     , K.SATICI_ALACAK_VPB '+#13+
           '     , K.BEKLEME_FAT_VAR '+#13+
           '     , K.BEKLEME_FAT_TUTAR '+#13+
           '     , K.BEKLEME_FAT_DOV_KOD '+#13+
           '     , K.BEKLEME_FAT_VPB '+#13+
           '     , K.SEFER_NOTLARI '+#13+
           '     , K.SEFER_ALIS_FAT_ALINDI '+#13+
           '     , K.SEFER_SATIS_FAT_KESILDI '+#13+
           '     , K.MASRAF_MERK '+#13+
           '     , K.KOD1 '+#13+
           '     , K.KOD2 '+#13+
           '     , K.KOD3 '+#13+
           '     , K.KOD4 '+#13+
           '     , K.ALICI_B_DOV_BAZ_TAR '+#13+
           '     , K.SATICI_A_DOV_BAZ_TAR '+#13+
           '     , K.BEKLEME_FAT_DOV_BAZ_TAR '+#13+
           '     , K.ALICI_B_DOVKUR '+#13+
           '     , K.SATICI_A_DOVKUR '+#13+
           '     , K.BEKLEME_FAT_DOVKUR '+#13+
           '     , K.SEFER_TAMAMLANDI '+#13+
           '     , K.DORSE_KOD '+#13+
           '     , K.ALIS_URUN_HAR_ID '+#13+
           '     , K.SATIS_URUN_HAR_ID '+#13+
           '     , K.SECIM '+#13+
           '     , K.BEKLEME_FATURASI_KESILDI '+#13+
           '     , K.BEK_FAT_URUN_HAR_ID '+#13+
           '     , K.MIKTAR '+#13+
           ' FROM SEFER K'+#13+
           ' LEFT OUTER JOIN ARAC ON (ARAC.ARAC_KOD=SEFER.ARAC_KOD ) '+#13+
           ' WHERE K.SEFER_ID>0 AND ARAC.OZ_MAL=0 ');

           qrySefer.Sql.Add(W_strSQL);
            {if cmb_sirala.ItemIndex<0 then
            begin
            qrySefer.Sql.Add(' ORDER BY ARAC.PLAKA,K.BAS_TAR,K.BIT_TAR');
            end;
            }

            if not Cb_Satici.Checked then
            begin
                if cmb_sirala.ItemIndex=0 then
                qrySefer.Sql.Add(' ORDER BY ARAC.ARAC_KOD,K.BAS_TAR,K.BIT_TAR')
                else
                qrySefer.Sql.Add(' ORDER BY ARAC.PLAKA,K.BAS_TAR,K.BIT_TAR');

            end
            else
            begin

                //if cmb_sirala.ItemIndex=0 then
                qrySefer.Sql.Add(' ORDER BY ARAC.CARI_KOD,K.BAS_TAR,K.BIT_TAR')
                //qrySefer.Sql.Add(' ORDER BY ARAC.CARI_KOD')
                {else
                qrySefer.Sql.Add(' ORDER BY K.SATICI_ADI,K.BAS_TAR,K.BIT_TAR');
                }

            end;

           qrySefer.ParamByName('TAR1').AsDate:=dtpIslemTar1.date;
           qrySefer.ParamByName('TAR2').AsDate:=dtpIslemTar2.date;
           qrySefer.Open;


           if not Cb_Alici.Checked then
           begin
              if not Cb_Satici.Checked then
              frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Ma_Kiralik_Alacak.fr3');

              if Cb_Satici.Checked then
              frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Ma_Kiralik_Alacak_cari_grup.fr3');
           end
           else
           begin
              if not Cb_Satici.Checked then
              frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Ma_Kiralik_Alacak_Alici.fr3');

              if Cb_Satici.Checked then
              frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Ma_Kiralik_Alacak_cari_grup_Alici.fr3');
           end;

          if Cb_Yeni_Sayfa.Checked then
          begin
            a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
            a.StartNewPage:=True;
          end;


         if not Cb_Satici.Checked then
         begin

            if cmb_sirala.ItemIndex<0 then
            begin
               a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
               a.Condition:='frxIBODataset1."PLAKA"';
            end;

            case cmb_sirala.ItemIndex of
            1:begin
               a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
               a.Condition:='frxIBODataset1."PLAKA"';
            end;
            0:begin
               a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
               a.Condition:='frxIBODataset1."ARAC_KOD"';
            end;

            end;
         end
         else
         begin
               a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
               a.Condition:='frxIBODataset1."CARI_KOD"';
         end;
         frxReport1.showReport;
         Exit;

       end;

       if prv_Tip='Sirket' then
       begin
            IB_Query1.Close;
            IB_Query1.Sql.Clear;
            IB_Query1.Sql.Add(
            ' Select '+#13+
            '     arachar.ARACHAR_ID '+#13+
            '     ,arachar.ARACHAR_SID '+#13+
            '     ,arachar.ARAC_KOD '+#13+
            '     ,arachar.BA '+#13+
            '     ,arachar.TARIH '+#13+
            '     ,arachar.DOVKOD '+#13+
            '     ,arachar.DOVKUR '+#13+
            '     ,arachar.TUTAR '+#13+
            '     ,arachar.TUTAR_VPB '+#13+
            '     ,arachar.ACIKLAMA '+#13+
            '     ,arachar.BELGE_TUR '+#13+
            '     ,arachar.BELGE_ID '+#13+
            '     ,arachar.BELGE_SID '+#13+
            '     ,arachar.SIRA_NO '+#13+
            '     ,arachar.MASRAF_MERK '+#13+
            '     ,arachar.KOD1 '+#13+
            '     ,arachar.KOD2 '+#13+
            '     ,arachar.KOD3 '+#13+
            '     ,arachar.KOD4 '+#13+
            '     ,ARAC.PLAKA '+#13+
            //'     ,SEFER.ALICI_KOD '+#13+
            '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=ARACHAR.ARAC_KOD) AS ARAC_PLAKA '+#13+
            '     ,(select (SELECT CARI_AD FROM CARI WHERE SEFER.ALICI_KOD=CARI.CARI_KOD) FROM SEFER '+#13+
            '     WHERE SEFER.sefer_id=ARACHAR.BELGE_ID AND ARACHAR.belge_tur=41)  AS ALICI_ADI '+#13+
            '     ,(CASE '+#13+
            '     WHEN arachar.BA=''B'' THEN  arachar.TUTAR_VPB '+#13+
            '     ELSE 0 '+#13+
            '     END) BORC '+#13+
            '     ,(CASE '+#13+
            '     WHEN arachar.BA=''A'' THEN  arachar.TUTAR_VPB '+#13+
            '     ELSE 0 '+#13+
            '     END) ALACAK '+#13+
            '     from ARACHAR '+#13+
            '     LEFT OUTER JOIN ARAC ON (ARAC.ARAC_KOD=ARACHAR.ARAC_KOD ) '+#13+
            //'     LEFT OUTER JOIN SEFER ON (ARAC.ARAC_KOD=SEFER.ARAC_KOD) '+#13+
            '     WHERE  arachar.ARACHAR_ID>0 AND ARAC.OZ_MAL=1');

            IB_Query1.Sql.Add(W_strSQLs);
            {if cmb_sirala.ItemIndex<0 then
            begin
            IB_Query1.Sql.Add(' ORDER BY ARAC.PLAKA,arachar.TARIH');
            end;
            }

            if cmb_sirala.ItemIndex=0 then
            IB_Query1.Sql.Add(' ORDER BY ARAC.ARAC_KOD,arachar.TARIH ')
            else
            IB_Query1.Sql.Add(' ORDER BY ARAC.PLAKA,arachar.TARIH ');


            IB_Query1.ParamByName('TAR1').AsDate:=dtpIslemTar1.date;
            IB_Query1.ParamByName('TAR2').AsDate:=dtpIslemTar2.date;
            IB_Query1.Open;

            frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Ma_Sirket_Alacak.fr3');

            if cmb_sirala.ItemIndex<0 then
            begin
               a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
               a.Condition:='<frxIBODataset2."PLAKA">';
            end;


            if Cb_Yeni_Sayfa.Checked then
            begin
               a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
               a.StartNewPage:=True;
            end;


            case cmb_sirala.ItemIndex of
            1:begin
               a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
               a.Condition:='frxIBODataset2."PLAKA"';
            end;
            0:begin
               a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
               a.Condition:='<frxIBODataset2."ARAC_KOD">';
            end;

            end;

            //frxReport1.PrepareReport();
            frxReport1.showReport;
            Exit;
       end;
  end;


  qrySefer.Open;


  frmRaporCiktisi_Open(strSQL);
  strSQL := '';
end;


procedure TfrmRaporSkAracHareketleriRaporu.frmRaporCiktisi_Open(strSQL : String);
var
  CHeader : TcxSSHeader;
begin
  with frmRaporSkAracHareketleriRaporu.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporSkAracHareketleriRaporu.qryRapor.Eof) and (frmRaporSkAracHareketleriRaporu.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;
    if chk_Sirket.Checked then
    begin
      frmRaporCiktisi.SetCellFont(0,2,14,2,[fsBold],8,'MS Sans Serif',4);
//      frmRaporCiktisi.SetCellAlignment(5,2,6,2,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,14,1,[fsBold],8,'MS Sans Serif',4);
//      frmRaporCiktisi.SetCellAlignment(5,1,6,1,haRight,vaCenter);
    end;

    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    if prv_Tip='Sirket' then
    begin
      CHeader.Size[1] := 200;
    end;

    CHeader.Size[2] := 250;
    CHeader.Size[5] := 250;

    frmRaporCiktisi.Rapor_Ayarlari(2);

    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporSkAracHareketleriRaporu.yaz;
var
  res_Cari : TStringList;
  Deger:String;
begin
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
  if prv_Tip='Kiralýk' then
  frmRaporCiktisi.SetCellText(row,col+2,'KIRALIK ARAÇ ALACAK RAPORU');

  if prv_Tip='Sirket' then
  frmRaporCiktisi.SetCellText(row,col+2,'ÞÝRKET ARAÇLARI MALÝYET RAPORU');

  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+3,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+3,row,col+3,row,[fsBold],8,'MS Sans Serif',0);
  alan_isimlerini_ekle;
  qryRapor.First;
  while not qryRapor.Eof do
  begin



    if not Alt_Ac then
    begin
      qryRapor.Next;
      Continue;
    end;

    inc(row);
    col := 0;
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ARAC_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PLAKA').AsString);
    inc(col);


    {

    if qryRapor.FieldByName('ARAC_TIP').AsString='0' then Deger:='Kamyon';
    if qryRapor.FieldByName('ARAC_TIP').AsString='1' then Deger:='Týr';
    if qryRapor.FieldByName('ARAC_TIP').AsString='2' then Deger:='Dorse';
    if qryRapor.FieldByName('ARAC_TIP').AsString='3' then Deger:='Binek';
    if qryRapor.FieldByName('ARAC_TIP').AsString='4' then Deger:='Diðer';

    frmRaporCiktisi.SetCellText(row,col,Deger);
    inc(col);
    if qryRapor.FieldByName('OZ_MAL').AsString='1' then Deger:='Öz Mal';
    if qryRapor.FieldByName('OZ_MAL').AsString='0' then Deger:='Öz Mal Deðil';

    frmRaporCiktisi.SetCellText(row,col,Deger);

  if prv_Tip='Kiralýk' then
  begin
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_ADI').AsString);
  end;

  if prv_Tip='Sirket' then
  begin
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PERSONEL_KOD').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PERSONEL_ADI').AsString);
  end;

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
    frmRaporCiktisi.format_ayarla(col-1,row,col,row);

    frmRaporCiktisi.SetCellFont(0,row,col+8,row,[fsBold],8,'MS Sans Serif',0);

}
    {
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TRF_SIG_GEC_TAR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('KASKO_SIG_GEC_TAR').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('YAKIT_LITRE').AsString);
    inc(col);

    if qryRapor.FieldByName('AKTIF_DEGIL').AsString='1' then Deger:='Aktif Deðil';
    if qryRapor.FieldByName('AKTIF_DEGIL').AsString='0' then Deger:='Aktif';

    frmRaporCiktisi.SetCellText(row,col,Deger);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    }
    {
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC').AsString);
    if (qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR) then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK').AsString);
    if (qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR) then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BORC_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ALACAK_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);
     }




    YazH;
//    inc(row);
    qryRapor.Next;
  end;

    inc(row);


    frmRaporCiktisi.SetCellText(row,2,'Gnl Toplam');
    if prv_Tip='Sirket' then
    begin
       //frmRaporCiktisi.SetCellText(row,3,'Borc Toplamý');
       frmRaporCiktisi.SetCellText(row,3,Floattostr(Gnl_Borc));
       frmRaporCiktisi.format_ayarla(3,row,3,row);
       //frmRaporCiktisi.SetCellText(row,5,'Alacak Toplamý');
       frmRaporCiktisi.SetCellText(row,4,Floattostr(Gnl_Alacak));
       frmRaporCiktisi.format_ayarla(4,row,4,row);

       frmRaporCiktisi.SetCellFont(2,row,2+2,row,[fsBold],8,'MS Sans Serif',0);
    end;

    if prv_Tip='Kiralýk' then
    begin
      frmRaporCiktisi.SetCellText(row,3,Floattostr(Gnl_Alacak-Gnl_Borc));
      frmRaporCiktisi.SetCellFont(2,row,2+1,row,[fsBold],8,'MS Sans Serif',0);
      frmRaporCiktisi.format_ayarla(3,row,3,row);
    end;

end;




function TfrmRaporSkAracHareketleriRaporu.Alt_Ac:Boolean;
begin
     Result:=False;

  qryRaporH.Close;
  qryRaporH.SQl.Text:=
  ' Select '+
  '    ARACHAR_ID '+
  '    ,ARACHAR_SID '+
  '    ,ARAC_KOD '+
  '    ,BA '+
  '    ,TARIH '+
  '    ,DOVKOD   '+
  '    ,DOVKUR '+
  '    ,TUTAR '+
  '    ,TUTAR_VPB '+
  '    ,ACIKLAMA '+
  '    ,BELGE_TUR '+
  '    ,BELGE_ID '+
  '    ,BELGE_SID '+
  '    ,SIRA_NO '+
  '    ,MASRAF_MERK '+
  '    ,KOD1 '+
  '    ,KOD2 '+
  '    ,KOD3 '+
  '    ,KOD4 '+
  '    from ARACHAR '+
  ' WHERE ARAC_KOD=:PRM_ARAC_KOD '+
  ' AND TARIH BETWEEN :TAR1 AND :TAR2 ';

  qryRaporH.ParamByName('PRM_ARAC_KOD').AsString:=qryRapor.FieldByName('ARAC_KOD').AsString;
  qryRaporH.ParamByName('TAR1').AsDate:=dtpIslemTar1.date;
  qryRaporH.ParamByName('TAR2').AsDate:=dtpIslemTar2.date;

  qryRaporH.Open;
  if qryRaporH.FieldByName('ARACHAR_ID').AsInteger>0 then
  Result :=True;
  qryRaporH.First;

end;

procedure TfrmRaporSkAracHareketleriRaporu.yazH;
var
  res_Cari : TStringList;
  Deger:String;
  Borc,Alacak:Double;
  sql:String;
begin
     Borc:=0;
     Alacak:=0;
  {
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
  frmRaporCiktisi.SetCellText(row,col+2,'ARAÇ LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+5,row,col+5,row,[fsBold],8,'MS Sans Serif',0);
  }
  alan_isimlerini_ekleH;




  while not qryRaporH.Eof do
  begin
    col := 0;
    inc(row);


    if prv_Tip='Sirket' then
    DataMod.Rapor_Satir_Renklendir(col,row,4);
    if prv_Tip='Kiralýk' then
    DataMod.Rapor_Satir_Renklendir(col,row,3);


    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('TARIH').AsString);

    if prv_Tip='Sirket' then
    begin
         inc(col);
         frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('ACIKLAMA').AsString);


         if qryRaporH.FieldByName('BELGE_TUR').AsInteger=BT_SEFER then
         Sql:= ' SELECT (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) AS ALICI_ADI FROM SEFER '+
         'WHERE SEFER_ID='+InttoStr(qryRaporH.FieldByName('BELGE_ID').AsInteger)+' AND SEFER_SID='
         +InttoStr(qryRaporH.FieldByName('BELGE_SID').AsInteger);

         if qryRaporH.FieldByName('BELGE_TUR').AsInteger=BT_MAZOT then
         Sql:= ' SELECT (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=MAZOT_FISI.MAZOTCU_CARI_KOD) AS ALICI_ADI FROM MAZOT_FISI '+
         'WHERE MAZOT_FIS_ID='+InttoStr(qryRaporH.FieldByName('BELGE_ID').AsInteger)+' AND MAZOT_FIS_SID='
         +InttoStr(qryRaporH.FieldByName('BELGE_SID').AsInteger);


         inc(col);
         frmRaporCiktisi.SetCellText(row,col,DataMod.Get_Ib_RecordTextQry(Sql));
    end;

    if prv_Tip='Kiralýk' then
    begin
         inc(col);
         frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('BELGE_ID').AsString);
         inc(col);
         frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('ACIKLAMA').AsString);
    end;
    {
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRaporH.FieldByName('BELGE_TUR').AsInteger));
    }
    inc(col);
    if qryRaporH.FieldByName('BA').AsString='B' then
    begin
       //Deger:='Borç';
       Borc:=Borc+qryRaporH.FieldByName('TUTAR_VPB').AsFloat;
    end;

    if qryRaporH.FieldByName('BA').AsString='A' then
    begin
       //Deger:='Alacak';
       Alacak:=Alacak+qryRaporH.FieldByName('TUTAR_VPB').AsFloat;
       if prv_Tip='Sirket' then Inc(col);
    end;
    //frmRaporCiktisi.SetCellText(row,col,Deger);

    frmRaporCiktisi.SetCellText(row,col,qryRaporH.FieldByName('TUTAR_VPB').AsString);
    frmRaporCiktisi.format_ayarla(col,row,col,row);

    qryRaporH.Next;
  end;

  inc(Row);

    frmRaporCiktisi.SetCellText(row,2,'Toplam');
    if prv_Tip='Sirket' then
    begin
       //frmRaporCiktisi.SetCellText(row,3,'Borc Toplamý');
       frmRaporCiktisi.SetCellText(row,3,Floattostr(Borc));
       frmRaporCiktisi.format_ayarla(3,row,3,row);
       //frmRaporCiktisi.SetCellText(row,5,'Alacak Toplamý');
       frmRaporCiktisi.SetCellText(row,4,Floattostr(Alacak));
       frmRaporCiktisi.format_ayarla(4,row,4,row);

       frmRaporCiktisi.SetCellFont(2,row,2+2,row,[fsBold],8,'MS Sans Serif',0);
    end;

    if prv_Tip='Kiralýk' then
    begin
      frmRaporCiktisi.SetCellText(row,3,Floattostr(Alacak-borc));
      frmRaporCiktisi.SetCellFont(2,row,2+1,row,[fsBold],8,'MS Sans Serif',0);
      frmRaporCiktisi.format_ayarla(3,row,3,row);
    end;

    Gnl_Borc:=Gnl_Borc +Borc;
    Gnl_Alacak:=Gnl_Alacak +Alacak;

  inc(Row);
end;



procedure TfrmRaporSkAracHareketleriRaporu.alan_isimlerini_ekle;
begin

  inc(row);

  frmRaporCiktisi.SetCellText(row,col,'Araç Kodu');
  frmRaporCiktisi.SetCellText(row,col+1,'Plaka');
 { frmRaporCiktisi.SetCellText(row,col+2,'Araç Tipi');
  frmRaporCiktisi.SetCellText(row,col+3,'Öz Mal');
  }
  if prv_Tip='Kiralýk' then
  begin
  {frmRaporCiktisi.SetCellText(row,col+4,'Cari Kodu');
  frmRaporCiktisi.SetCellText(row,col+5,'Cari Adý');
  frmRaporCiktisi.SetCellText(row,col+6,'Borç');
  frmRaporCiktisi.SetCellText(row,col+7,'Alacak');
  }
  end;


  if prv_Tip='Sirket' then
  begin
  {frmRaporCiktisi.SetCellText(row,col+4,'Personel Kodu');
  frmRaporCiktisi.SetCellText(row,col+5,'Personel Adý');
  frmRaporCiktisi.SetCellText(row,col+6,'Borç');
  frmRaporCiktisi.SetCellText(row,col+7,'Alacak');
  }
  end;
{
  frmRaporCiktisi.SetCellText(row,col+10,'Trafik. Sig.Geç.Sür.');
  frmRaporCiktisi.SetCellText(row,col+11,'Kasko Sig.Geç.Sür.');
  frmRaporCiktisi.SetCellText(row,col+12,'Litre/Km Deðeri');
  frmRaporCiktisi.SetCellText(row,col+13,'Aktif Deðil');
  frmRaporCiktisi.SetCellText(row,col+14,'Açýklama');
}
  frmRaporCiktisi.SetCellFont(0,row,col+14,row,[fsBold],8,'MS Sans Serif',4);

end;


procedure TfrmRaporSkAracHareketleriRaporu.alan_isimlerini_ekleH;
begin
  col := 0;
  inc(row);

  if prv_Tip='Sirket' then
  begin
       frmRaporCiktisi.SetCellText(row,col,'Tarih');
       frmRaporCiktisi.SetCellText(row,col+1,'Açýklama');
       frmRaporCiktisi.SetCellText(row,col+2,'Cari Adý');
       //  frmRaporCiktisi.SetCellText(row,col+1,'Belge No');
       //  frmRaporCiktisi.SetCellText(row,col+2,'Belge Türü');
       //  frmRaporCiktisi.SetCellText(row,col+3,'Borç/Alacak');
       frmRaporCiktisi.SetCellText(row,col+3,'Gider');
       frmRaporCiktisi.SetCellText(row,col+4,'Gelir');
       //  frmRaporCiktisi.SetCellText(row,col+5,'Tutar');
       frmRaporCiktisi.SetCellFont(0,row,col+4,row,[fsBold],8,'MS Sans Serif',4);
  end;


  if prv_Tip='Kiralýk' then
  begin
       frmRaporCiktisi.SetCellText(row,col,'Tarih');
       frmRaporCiktisi.SetCellText(row,col+1,'Sefer Kodu');
       frmRaporCiktisi.SetCellText(row,col+2,'Açýklama');
       //  frmRaporCiktisi.SetCellText(row,col+1,'Belge No');
       //  frmRaporCiktisi.SetCellText(row,col+2,'Belge Türü');
       //  frmRaporCiktisi.SetCellText(row,col+3,'Borç/Alacak');
       frmRaporCiktisi.SetCellText(row,col+3,'Tutar');
       //  frmRaporCiktisi.SetCellText(row,col+5,'Tutar');
       frmRaporCiktisi.SetCellFont(0,row,col+3,row,[fsBold],8,'MS Sans Serif',4);
  end;
end;



procedure TfrmRaporSkAracHareketleriRaporu.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporSkAracHareketleriRaporu.txtAracKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSkAracHareketleriRaporu.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSkAracHareketleriRaporu.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporSkAracHareketleriRaporu.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSkAracHareketleriRaporu.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporSkAracHareketleriRaporu.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporSkAracHareketleriRaporu);
end;

procedure TfrmRaporSkAracHareketleriRaporu.Button9Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      txtArac.Text := ARAC_KOD;
      LblPlaka.Caption:= PLAKA;
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.Button8Click(Sender: TObject);
var
  PERSONEL_KOD, PERSONEL_AD :String;
begin
  if DataMod.LS_Personel(PERSONEL_KOD, PERSONEL_AD) then
  begin
    txtAlanPers.Text:=PERSONEL_KOD;
    Label18.Caption:=PERSONEL_AD;
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.Button7Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      TxtMazotcu.Text := Cari_KOD;
      Label19.Caption := Cari_AD;
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.txtAracExit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 SATICI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
begin
  if Trim(txtArac.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PLAKA',txtArac.Text,PLAKA) then
    begin
      LblPlaka.Caption := PLAKA;
      {if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','OZ_MAL',txtArac.Text,OZ_MAL) then
      begin
      end;
      }
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txtArac.SetFocus;
    end;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
    LblPlaka.Caption := '';
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.txtAlanPersExit( Sender: TObject);
var
  PERSONEL_AD:String;
begin
  txtAlanPers.Color := clWindow;
  if Trim(txtAlanPers.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PERSONEL','PERSONEL_KOD','ADI_SOYADI',txtAlanPers.Text,PERSONEL_AD) then
    begin
      Label18.Caption := PERSONEL_AD
    end
    else
    begin
      txtAlanPers.SetFocus;
    end
  end
  else
  begin
    Label18.Caption := '';
  end;
end;

procedure TfrmRaporSkAracHareketleriRaporu.FormShow(Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporSkAracHareketleriRaporu.txtAracEnter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporSkAracHareketleriRaporu.frxReport1AfterPrint(
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
       c.memo.Text:=DateToStr(dtpIslemTar2.Date);

       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);

       Prv_Yazdirildi:=True;
    end;

end;

procedure TfrmRaporSkAracHareketleriRaporu.TxtMazotcuExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(TxtMazotcu.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',TxtMazotcu.Text,CARI_AD) then
    begin
      Label19.Caption := CARI_AD;
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      TxtMazotcu.SetFocus;
    end;
  end
  else
  begin
    if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
    Label19.Caption := '';
  end;
end;

end.









{Select 
    arachar.ARACHAR_ID
    ,arachar.ARACHAR_SID 
    ,arachar.ARAC_KOD
    ,arachar.BA 
    ,arachar.TARIH 
    ,arachar.DOVKOD   
    ,arachar.DOVKUR 
    ,arachar.TUTAR 
    ,arachar.TUTAR_VPB 
    ,arachar.ACIKLAMA 
    ,arachar.BELGE_TUR 
    ,arachar.BELGE_ID 
    ,arachar.BELGE_SID 
    ,arachar.SIRA_NO 
    ,arachar.MASRAF_MERK 
    ,arachar.KOD1 
    ,arachar.KOD2 
    ,arachar.KOD3 
    ,arachar.KOD4 
    ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=ARACHAR.ARAC_KOD) AS ARAC_PLAKA
    ,(select (SELECT CARI_AD FROM CARI WHERE SEFER.ALICI_KOD=CARI.CARI_KOD) FROM SEFER
    WHERE SEFER.sefer_id=ARACHAR.BELGE_ID AND ARACHAR.belge_tur=41)  AS ALICI_ADI


    from ARACHAR 

    LEFT OUTER JOIN ARAC ON (ARAC.ARAC_KOD=ARACHAR.ARAC_KOD)
    WHERE ARAC.oz_mal=1;
}
