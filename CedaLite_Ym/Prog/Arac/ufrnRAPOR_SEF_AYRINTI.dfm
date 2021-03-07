object frnRAPOR_SEF_AYRINTI: TfrnRAPOR_SEF_AYRINTI
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sefer Ayr'#305'nt'#305' Raporu'
  ClientHeight = 225
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnRapor: TButton
    Left = 8
    Top = 190
    Width = 77
    Height = 25
    Caption = '& Excel Rapor'
    TabOrder = 0
    OnClick = btnRaporClick
  end
  object Button3: TButton
    Left = 228
    Top = 190
    Width = 75
    Height = 25
    Caption = #199#305'&k'#305#351
    TabOrder = 1
    OnClick = Button3Click
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 370
    Height = 46
    Align = alTop
    Caption = 'Tarih Aral'#305#287#305
    TabOrder = 2
    ExplicitLeft = -117
    ExplicitWidth = 420
    object dtpIslemTar1: TDateTimePicker
      Left = 26
      Top = 15
      Width = 100
      Height = 21
      Date = 37554.733220983800000000
      Time = 37554.733220983800000000
      Checked = False
      TabOrder = 0
    end
    object dtpIslemTar2: TDateTimePicker
      Left = 219
      Top = 15
      Width = 100
      Height = 21
      Date = 37554.733416122690000000
      Time = 37554.733416122690000000
      Checked = False
      TabOrder = 1
    end
  end
  object qrySEFER_AYRINTI: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayFormat.Strings = (
      'FARK=dd')
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=Hareket A'#231#305'klamas'#305
      'KASA_AD=Kasa Ad'#305
      'CH_ACIKLAMA=C/H A'#231#305'klama'
      'YEV_ACIKLAMA=Yevmiye Defteri A'#231#305'klama'
      'KASAHAR_ID=FIS NO'
      'ARAC_KOD=Ara'#231' Kodu'
      'SEFER_SAY=Sefer Say'#305's'#305
      'ARAC_PLAKA=Ara'#231' Plaka'
      'ALICI_KOD=Al'#305'c'#305' Kodu'
      'ALICI_ADI=Al'#305'c'#305' Ad'#305
      'SATICI_KOD=Sat'#305'c'#305' Kodu'
      'SATICI_ADI=Sat'#305'c'#305' Ad'#305
      'PERSONEL_KOD=Personel Kodu'
      'PERSONEL_ADI=Personel Ad'#305
      'OLCU_TIP='#214'l'#231#252' Tip'
      'OLCU_BIRIM='#214'l'#231#252' Birim'
      'TASINAN_ESYA=Ta'#351#305'nan E'#351'ya'
      'BAS_TAR=Ba'#351'lama Tarihi'
      'BIT_TAR=Biti'#351' Tarihi'
      'CIK_YER='#199#305'k'#305#351' Yeri'
      'BIT_YER=Var'#305#351' Yeri'
      'ALICI_BORC_BIRIM_FIY=Birim Fiyat'#305
      'ALICI_B_DOVKOD=D'#246'viz Kodu'
      'ALICI_BORC=Bor'#231
      'ALICI_BORC_VPB=Bor'#231' Vpb'
      'SATICI_ALACAK_BIRIM_FIY=Birim Fiyat'#305
      'SATICI_A_DOVKOD=D'#246'viz Kodu'
      'SATICI_ALACAK=Alacak'
      'SATICI_ALACAK_VPB=Alacak Vpb'
      'BEKLEME_FAT_VAR=Bekleme Faturas'#305
      'BEKLEME_FAT_TUTAR=Tutar'
      'BEKLEME_FAT_DOV_KOD=D'#246'viz Kodu'
      'BEKLEME_FAT_VPB=Tutar Vpb'
      'SEFER_NOTLARI=Sefer Notlar'#305
      'SEFER_ALIS_FAT_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305
      'SEFER_SATIS_FAT_KESILDI=Sat'#305#351' Faturas'#305' Kesildi'
      'SEFER_ID=Sefer No'
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4'
      'ALICI_B_DOV_BAZ_TAR=Al'#305'c'#305' D'#246'v.Baz.Tar'
      'SATICI_A_DOV_BAZ_TAR=Sat'#305'c'#305' D'#246'v.Baz.Tar'
      'BEKLEME_FAT_DOV_BAZ_TAR=Fatura D'#246'v.Baz.Tar'
      'SEFER_TAMAMLANDI=Sefer Tamamland'#305
      'DORSE_KOD=Dorse Kodu'
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'SATIS_URUN_HAR_ID=Sat'#305#351' Faturas'#305' Hareket No'
      'SECIM=Se'#231'im'
      'BEKLEME_FATURASI_KESILDI=Bekleme Faturas'#305' Kesildi'
      'BEK_FAT_URUN_HAR_ID=Bekleme Faturas'#305' Al'#305#351' Hareket No')
    FieldsIndex.Strings = (
      'SECIM'
      'SEFER_ID'
      'SEFER_SID'
      'SEFER_SAY'
      'ARAC_KOD'
      'ARAC_PLAKA'
      'DORSE_KOD'
      'ALICI_KOD'
      'ALICI_ADI'
      'SATICI_KOD'
      'SATICI_ADI'
      'PERSONEL_KOD'
      'PERSONEL_ADI'
      'OLCU_TIP'
      'OLCU_BIRIM'
      'TASINAN_ESYA'
      'BAS_TAR'
      'BIT_TAR'
      'CIK_YER'
      'BIT_YER'
      'ALICI_BORC_BIRIM_FIY'
      'ALICI_B_DOVKOD'
      'ALICI_BORC'
      'ALICI_BORC_VPB'
      'SATICI_ALACAK_BIRIM_FIY'
      'SATICI_A_DOVKOD'
      'SATICI_ALACAK'
      'SATICI_ALACAK_VPB'
      'BEKLEME_FAT_TUTAR'
      'BEKLEME_FAT_DOV_KOD'
      'BEKLEME_FAT_VPB'
      'SEFER_NOTLARI'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'ALICI_B_DOV_BAZ_TAR'
      'SATICI_A_DOV_BAZ_TAR'
      'BEKLEME_FAT_DOV_BAZ_TAR'
      'ALICI_B_DOVKUR'
      'SATICI_A_DOVKUR'
      'BEKLEME_FAT_DOVKUR'
      'SEFER_TAMAMLANDI'
      'SEFER_ALIS_FAT_ALINDI'
      'ALIS_URUN_HAR_ID'
      'SEFER_SATIS_FAT_KESILDI'
      'SATIS_URUN_HAR_ID'
      'BEKLEME_FAT_VAR'
      'BEKLEME_FATURASI_KESILDI'
      'BEK_FAT_URUN_HAR_ID')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'SEFER_SID=FALSE'
      'ALICI_B_DOVKUR=FALSE'
      'SATICI_A_DOVKUR=FALSE'
      'BEKLEME_FAT_DOVKUR=FALSE')
    IB_Connection = DataMod.dbaMain
    AutoFetchAll = True
    ColorScheme = False
    DefaultValues.Strings = (
      'BELGE_SID=1'
      'BELGE_ID=0'
      'TIP=G'
      'KASADEGER=0'
      'ISLEM_TIP=1'
      'MC=C'
      'DOVKUR=0'
      'TUTAR=0'
      'TUTAR_VPB=0'
      'MIKTAR=0')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 288
    Top = 76
  end
end
