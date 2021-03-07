object frmRaporFatura_Mazot: TfrmRaporFatura_Mazot
  Left = 251
  Top = 155
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mazot Fatura Ba'#287'lant'#305'lar'#305
  ClientHeight = 436
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label36: TLabel
    Left = 10
    Top = 7
    Width = 90
    Height = 13
    Caption = 'Mazotcu Cari Kodu'
  end
  object Label19: TLabel
    Left = 338
    Top = 7
    Width = 319
    Height = 13
    AutoSize = False
    Caption = 'Cari Ad'#305
  end
  object TxtMazotcu: TEdit
    Left = 185
    Top = 4
    Width = 127
    Height = 21
    TabOrder = 0
    OnEnter = TxtMazotcuEnter
    OnExit = TxtMazotcuExit
  end
  object Button7: TButton
    Left = 314
    Top = 4
    Width = 17
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button7Click
  end
  object Btn_Bul: TButton
    Left = 8
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Bul'
    TabOrder = 2
    OnClick = Btn_BulClick
  end
  object IB_Grid1: TIB_Grid
    Left = 8
    Top = 72
    Width = 649
    Height = 329
    CustomGlyphsSupplied = []
    DataSource = IB_DataSource1
    TabOrder = 4
  end
  object Button1: TButton
    Left = 584
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Kapat'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 408
    Width = 137
    Height = 25
    Caption = '&Fatura Kayd'#305'na Git'
    Enabled = False
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 520
    Top = 408
    Width = 137
    Height = 25
    Caption = '&Mazot Fi'#351'ine Git'
    Enabled = False
    TabOrder = 6
    OnClick = Button3Click
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = qrySefer
    Left = 232
    Top = 144
  end
  object qrySefer: TIB_Query
    ColumnAttributes.Strings = (
      'SECIM=BOOLEAN=1,0'
      'ALIS_FATURASI_ALINDI=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=A'#231#305'klama'
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
      'SATICI_ADI=Sat'#305'c'#305' Kodu'
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
      'MAZOT_FIS_ID=S'#305'ra No'
      'SAAT=Saat'
      'VEREN_PERSONEL_KOD=Veren Personel'
      'ALAN_PERSONEL_KOD=Alan Personel'
      'ALAN_CARI_KOD=Alan Cari Kodu'
      'MAZOTCU_CARI_KOD=Mazot'#231'u Cari Kod'
      'KM=Km'
      'LITRE=Litre'
      'LITRE_FIYAT=Litre Fiyat'#305
      'DOVKOD=D'#246'viz Kodu'
      'DOVKUR=D'#246'viz Kuru'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar Vpb'
      'VEREN_PERSONEL_ADI=Veren Personel Ad'#305
      'ALAN_PERSONEL_ADI=Alan Personel Ad'#305
      'MAZOTCU_CARI_ADI=Mazot'#231'u Cari Ad'#305
      'ALAN_CARI_ADI=Alan Cari Ad'#305
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'SECIM=Se'#231'im'
      'ALIS_FATURASI_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305
      'FAT_IRS_SERI=Fatura Seri no'
      'BELGE_NO=Fatura Belge No'
      'FAT_IRS_ID=Fatura Fi'#351' No'
      'GENEL_TOP=Fatura Genel Toplam')
    FieldsDisplayWidth.Strings = (
      'MAZOT_FIS_ID=50')
    FieldsIndex.Strings = (
      'MAZOT_FISI.SECIM'
      'MAZOT_FISI.MAZOT_FIS_ID'
      'MAZOT_FISI.MAZOT_FIS_SID'
      'MAZOT_FISI.ARAC_KOD'
      'ARAC_PLAKA'
      'MAZOT_FISI.ALAN_CARI_KOD'
      'ALAN_CARI_ADI'
      'MAZOT_FISI.MAZOTCU_CARI_KOD'
      'MAZOTCU_CARI_ADI'
      'MAZOT_FISI.SEFER_ID'
      'MAZOT_FISI.FIS_NO'
      'MAZOT_FISI.TARIH'
      'MAZOT_FISI.SAAT'
      'MAZOT_FISI.VEREN_PERSONEL_KOD'
      'VEREN_PERSONEL_ADI'
      'MAZOT_FISI.ALAN_PERSONEL_KOD'
      'ALAN_PERSONEL_ADI'
      'MAZOT_FISI.KM'
      'MAZOT_FISI.LITRE'
      'MAZOT_FISI.LITRE_FIYAT'
      'MAZOT_FISI.DOVKOD'
      'MAZOT_FISI.DOV_BAZ_TAR'
      'MAZOT_FISI.DOVKUR'
      'MAZOT_FISI.TUTAR'
      'MAZOT_FISI.TUTAR_VPB'
      'MAZOT_FISI.ACIKLAMA'
      'MAZOT_FISI.MASRAF_MERK'
      'MAZOT_FISI.KOD1'
      'MAZOT_FISI.KOD2'
      'MAZOT_FISI.KOD3'
      'MAZOT_FISI.KOD4'
      'MAZOT_FISI.ALIS_FATURASI_ALINDI'
      'MAZOT_FISI.ALIS_URUN_HAR_ID'
      'FAT_IRS.FAT_IRS_SERI'
      'FAT_IRS.BELGE_NO'
      'FAT_IRS.FAT_IRS_ID'
      'FAT_IRS.GENEL_TOP'
      'FAT_IRS.FAT_IRS_TIP'
      'FAT_IRS.FAT_IRS_SID'
      'FAT_IRS.FAT_IRS_SEP')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'MAZOT_FIS_SID=FALSE'
      'FAT_IRS_TIP=FALSE'
      'FAT_IRS_SID=FALSE'
      'FAT_IRS_SEP=FALSE'
      'SECIM=FALSE'
      'SAAT=FALSE'
      'KM=FALSE'
      'LITRE=FALSE'
      'LITRE_FIYAT=FALSE'
      'DOVKOD=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'DOVKUR=FALSE'
      'TUTAR=FALSE'
      'ACIKLAMA=FALSE'
      'MASRAF_MERK=FALSE'
      'KOD1=FALSE'
      'KOD2=FALSE'
      'KOD3=FALSE'
      'KOD4=FALSE'
      'ALIS_FATURASI_ALINDI=FALSE'
      'ALIS_URUN_HAR_ID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT S.MAZOT_FIS_ID'
      '     , S.MAZOT_FIS_SID'
      '     , S.ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=MAZOT_FISI.ARA' +
        'C_KOD) AS ARAC_PLAKA'
      '     , S.FIS_NO'
      '     , S.TARIH'
      '     , S.SAAT'
      '     , S.VEREN_PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=MAZOT_FISI.VEREN_PERSONEL_KOD) AS VEREN_PERSONEL_ADI    '
      '     , S.ALAN_PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=MAZOT_FISI.ALAN_PERSONEL_KOD) AS ALAN_PERSONEL_ADI    '
      '     , S.ALAN_CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.ALAN_CARI_KOD=C' +
        'ARI.CARI_KOD) AS ALAN_CARI_ADI    '
      '     , S.MAZOTCU_CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.MAZOTCU_CARI_KO' +
        'D=CARI.CARI_KOD) AS MAZOTCU_CARI_ADI    '
      '     , S.KM'
      '     , S.LITRE'
      '     , S.LITRE_FIYAT'
      '     , S.DOVKOD'
      '     , S.DOV_BAZ_TAR'
      '     , S.DOVKUR'
      '     , S.TUTAR'
      '     , S.TUTAR_VPB'
      '     , S.ACIKLAMA'
      '     , S.MASRAF_MERK'
      '     , S.KOD1'
      '     , S.KOD2'
      '     , S.KOD3'
      '     , S.KOD4'
      '     , S.SEFER_ID'
      '     , S.ALIS_URUN_HAR_ID'
      '     , S.SECIM'
      '     , S.ALIS_FATURASI_ALINDI'
      '    ,FAT_IRS.FAT_IRS_SERI '
      '    ,FAT_IRS.BELGE_NO '
      '    ,FAT_IRS.FAT_IRS_ID '
      '    ,FAT_IRS.GENEL_TOP '
      '    ,FAT_IRS.FAT_IRS_TIP '
      '    ,FAT_IRS.FAT_IRS_SID '
      '    ,FAT_IRS.FAT_IRS_SEP '
      '    FROM MAZOT_FISI S '
      
        'INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=MAZOT_FISI.ALIS_URUN_H' +
        'AR_ID) '
      
        'INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND ' +
        'FAT_IRS_SEP=1)'
      ''
      ''
      '')
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
    KeyLinks.Strings = (
      'MAZOT_FISI.MAZOT_FIS_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 152
    Top = 304
  end
end
