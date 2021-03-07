object frmRaporFatura_Sefer: TfrmRaporFatura_Sefer
  Left = 289
  Top = 155
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sefer Fatura Ba'#287'lant'#305'lar'#305
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
    Width = 46
    Height = 13
    Caption = 'Cari Kodu'
  end
  object Label19: TLabel
    Left = 234
    Top = 7
    Width = 319
    Height = 13
    AutoSize = False
    Caption = 'Cari Ad'#305
  end
  object TxtMazotcu: TEdit
    Left = 81
    Top = 4
    Width = 127
    Height = 21
    TabOrder = 0
    OnEnter = TxtMazotcuEnter
    OnExit = TxtMazotcuExit
  end
  object Button7: TButton
    Left = 210
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
    Left = 584
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Bul'
    TabOrder = 3
    OnClick = Btn_BulClick
  end
  object IB_Grid1: TIB_Grid
    Left = 8
    Top = 72
    Width = 649
    Height = 329
    CustomGlyphsSupplied = []
    DataSource = IB_DataSource1
    TabOrder = 5
  end
  object Button1: TButton
    Left = 584
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Kapat'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Rg_Fatura_Tipi: TRadioGroup
    Left = 8
    Top = 32
    Width = 545
    Height = 33
    Columns = 4
    ItemIndex = 1
    Items.Strings = (
      'Al'#305#351' Faturas'#305
      'Sat'#305#351' Faturas'#305
      'Bekleme Faturas'#305
      'Sat'#305'c'#305' Bekleme Faturas'#305)
    TabOrder = 2
  end
  object Button2: TButton
    Left = 8
    Top = 407
    Width = 169
    Height = 25
    Caption = '&Fatura Kayd'#305'na Git'
    Enabled = False
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 494
    Top = 407
    Width = 161
    Height = 25
    Caption = '&Sefer Kayd'#305'na Git'
    Enabled = False
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 183
    Top = 407
    Width = 129
    Height = 25
    Caption = '&Fatura Sefer Ba'#287'lant'#305'lar'#305
    Enabled = False
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 335
    Top = 407
    Width = 129
    Height = 25
    Caption = '&Fatura Sefer Ba'#287'lant'#305'lar'#305' E'
    Enabled = False
    TabOrder = 9
    OnClick = Button5Click
  end
  object qrySefer: TIB_Query
    ColumnAttributes.Strings = (
      'BEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SEFER_ALIS_FAT_ALINDI=BOOLEAN=1,0'
      'SEFER_SATIS_FAT_KESILDI=BOOLEAN=1,0'
      'SECIM=BOOLEAN=1,0'
      'BEKLEME_FATURASI_KESILDI=BOOLEAN=1,0'
      'SEFER_TAMAMLANDI=BOOLEAN=1,0'
      'SBEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SBEKLEME_FATURASI_KESILDI=BOOLEAN=1,0')
    DatabaseName = 'C:\ekinci_data\EKINCI2012.FDB'
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
      'BEK_FAT_URUN_HAR_ID=Bekleme Faturas'#305' Al'#305#351' Hareket No'
      'FAT_IRS_ID=Fatura Fi'#351' no'
      'FAT_IRS_SERI=Fatura Seri No'
      'BELGE_NO=Fatura Belge No'
      'GENEL_TOP=Fatura Toplam Tutar'#305' Vpb'
      'DARAC_PLAKA=Dorse Plaka'
      'URUNHAR_ID=Fatura Har No'
      'SBEKLEME_FAT_VAR=Sat'#305'c'#305' Bekleme Faturas'#305' Var'
      'SBEKLEME_FAT_VPB=Sat'#305'c'#305' Bekleme Faturas'#305' Tutar'
      'SBEKLEME_FATURASI_KESILDI=Sat'#305'c'#305' Bekleme Faturas'#305' Kesildi')
    FieldsDisplayWidth.Strings = (
      'BELGE_NO=83'
      'FAT_IRS_SERI=73'
      'FAT_IRS_ID=71'
      'GENEL_TOP=132'
      'BEKLEME_FAT_VPB=129'
      'SEFER_ID=49'
      'URUNHAR_ID=75')
    FieldsIndex.Strings = (
      'FAT_IRS.FAT_IRS_SERI'
      'FAT_IRS.BELGE_NO'
      'FAT_IRS.FAT_IRS_ID'
      'URUNHAR.URUNHAR_ID'
      'FAT_IRS.GENEL_TOP'
      'SEFER.SEFER_ID'
      'SEFER.ARAC_KOD'
      'ARAC_PLAKA'
      'SEFER.ALICI_KOD'
      'ALICI_ADI'
      'SEFER.SATICI_KOD'
      'SATICI_ADI'
      'SEFER.DORSE_KOD'
      'DARAC_PLAKA'
      'SEFER.PERSONEL_KOD'
      'PERSONEL_ADI'
      'SEFER.ALICI_BORC_VPB'
      'SEFER.SATICI_ALACAK_VPB'
      'SEFER.BEKLEME_FAT_VPB'
      'FAT_IRS.FAT_IRS_TIP'
      'FAT_IRS.FAT_IRS_SID'
      'FAT_IRS.FAT_IRS_SEP')
    FieldsVisible.Strings = (
      'FAT_IRS_TIP=FALSE'
      'FAT_IRS_SID=FALSE'
      'FAT_IRS_SEP=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT'
      'S.SEFER_ID'
      ',S.ARAC_KOD'
      
        ',(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ' +
        'ARAC_PLAKA'
      ',S.DORSE_KOD'
      
        ',(SELECT PLAKA FROM ARAC AR WHERE AR.ARAC_KOD=SEFER.DORSE_KOD) A' +
        'S DARAC_PLAKA'
      ',S.ALICI_KOD'
      
        ',(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) ' +
        'AS ALICI_ADI'
      ',S.SATICI_KOD'
      
        ',(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD)' +
        ' AS SATICI_ADI'
      ',S.PERSONEL_KOD'
      
        ',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SE' +
        'FER.PERSONEL_KOD) AS PERSONEL_ADI'
      ',S.ALICI_BORC_VPB'
      ',S.SATICI_ALACAK_VPB'
      ''
      ''
      ',S.SEFER_ALIS_FAT_ALINDI '
      ',S.SEFER_SATIS_FAT_KESILDI '
      '   ,S.BEKLEME_FAT_VAR'
      '    ,S.BEKLEME_FAT_VPB '
      '    ,S.BEKLEME_FATURASI_KESILDI '
      '    ,S.SBEKLEME_FAT_VAR '
      '    ,S.SBEKLEME_FAT_VPB '
      '    ,S.SBEKLEME_FATURASI_KESILDI  '
      ',S.SEFER_SAY'
      ',FAT_IRS.FAT_IRS_SERI'
      ',FAT_IRS.BELGE_NO'
      ',FAT_IRS.FAT_IRS_ID'
      ',FAT_IRS.GENEL_TOP'
      ',FAT_IRS.FAT_IRS_TIP'
      ',FAT_IRS.FAT_IRS_SID'
      ',FAT_IRS.FAT_IRS_SEP'
      ',URUNHAR.URUNHAR_ID'
      ''
      'FROM SEFER S'
      
        'INNER JOIN URUNHAR ON (URUNHAR.URUNHAR_ID=SEFER.BEK_FAT_URUN_HAR' +
        '_ID)'
      
        'INNER JOIN FAT_IRS ON (URUNHAR.FATURA_ID=FAT_IRS.FAT_IRS_ID AND ' +
        'FAT_IRS_SEP=1);')
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
    OrderingItems.Strings = (
      'Fatura Seri No=FAT_IRS.FAT_IRS_SERI;FAT_IRS.FAT_IRS_SERI DESC'
      'Fatura Belge No=FAT_IRS.BELGE_NO;FAT_IRS.BELGE_NO DESC'
      'Fatura Fi'#351' no=FAT_IRS.FAT_IRS_ID;FAT_IRS.FAT_IRS_ID DESC'
      'Fatura Har No=URUNHAR.URUNHAR_ID;URUNHAR.URUNHAR_ID DESC'
      
        'Fatura Toplam Tutar'#305' Vpb=FAT_IRS.GENEL_TOP;FAT_IRS.GENEL_TOP DES' +
        'C'
      'Sefer No=SEFER.SEFER_ID;SEFER.SEFER_ID DESC'
      'Ara'#231' Kodu=SEFER.ARAC_KOD;SEFER.ARAC_KOD DESC'
      'Al'#305'c'#305' Kodu=SEFER.ALICI_KOD;SEFER.ALICI_KOD DESC'
      'Sat'#305'c'#305' Kodu=SEFER.SATICI_KOD;SEFER.SATICI_KOD DESC'
      'Dorse Kodu=SEFER.DORSE_KOD;SEFER.DORSE_KOD DESC'
      'Personel Kodu=SEFER.PERSONEL_KOD;SEFER.PERSONEL_KOD DESC'
      'Bor'#231' Vpb=SEFER.ALICI_BORC_VPB;SEFER.ALICI_BORC_VPB DESC'
      'Alacak Vpb=SEFER.SATICI_ALACAK_VPB;SEFER.SATICI_ALACAK_VPB DESC'
      'Tutar Vpb=SEFER.BEKLEME_FAT_VPB;SEFER.BEKLEME_FAT_VPB DESC'
      'FAT_IRS_TIP=FAT_IRS.FAT_IRS_TIP;FAT_IRS.FAT_IRS_TIP DESC'
      'FAT_IRS_SID=FAT_IRS.FAT_IRS_SID;FAT_IRS.FAT_IRS_SID DESC'
      'FAT_IRS_SEP=FAT_IRS.FAT_IRS_SEP;FAT_IRS.FAT_IRS_SEP DESC')
    OrderingLinks.Strings = (
      'FAT_IRS_SERI=ITEM=1'
      'BELGE_NO=ITEM=2'
      'FAT_IRS_ID=ITEM=3'
      'URUNHAR_ID=ITEM=4'
      'GENEL_TOP=ITEM=5'
      'SEFER_ID=ITEM=6'
      'ARAC_KOD=ITEM=7'
      'ALICI_KOD=ITEM=8'
      'SATICI_KOD=ITEM=9'
      'DORSE_KOD=ITEM=10'
      'PERSONEL_KOD=ITEM=11'
      'ALICI_BORC_VPB=ITEM=12'
      'SATICI_ALACAK_VPB=ITEM=13'
      'BEKLEME_FAT_VPB=ITEM=14'
      'FAT_IRS_TIP=ITEM=15'
      'FAT_IRS_SID=ITEM=16'
      'FAT_IRS_SEP=ITEM=17')
    RequestLive = True
    SearchingLinks.Strings = (
      'FAT_IRS_ID=FAT_IRS_ID'
      'BELGE_NO=BELGE_NO'
      'FAT_IRS_SERI=FAT_IRS_SERI'
      'SEFER_ID=SEFER_ID'
      'ALICI_KOD=ALICI_KOD'
      'SATICI_KOD=SATICI_KOD'
      'ARAC_KOD=ARAC_KOD'
      'ALICI_BORC_VPB=ALICI_BORC_VPB'
      'SATICI_ALACAK_VPB=SATICI_ALACAK_VPB'
      'BEKLEME_FAT_VPB=BEKLEME_FAT_VPB'
      'GENEL_TOP=GENEL_TOP'
      'PERSONEL_KOD=PERSONEL_KOD')
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 136
    Top = 144
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = qrySefer
    Left = 232
    Top = 144
  end
  object frxReport1: TfrxReport
    Version = '4.7.181'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39147.622621701400000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 324
    Top = 83
  end
  object frxIBODataset1: TfrxIBODataset
    UserName = 'frxIBODataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SECIM=SECIM'
      'SEFER_ID=SEFER_ID'
      'SEFER_SID=SEFER_SID'
      'SEFER_SAY=SEFER_SAY'
      'ARAC_KOD=ARAC_KOD'
      'ARAC_PLAKA=ARAC_PLAKA'
      'DORSE_KOD=DORSE_KOD'
      'ALICI_KOD=ALICI_KOD'
      'ALICI_ADI=ALICI_ADI'
      'SATICI_KOD=SATICI_KOD'
      'SATICI_ADI=SATICI_ADI'
      'PERSONEL_KOD=PERSONEL_KOD'
      'PERSONEL_ADI=PERSONEL_ADI'
      'OLCU_TIP=OLCU_TIP'
      'OLCU_BIRIM=OLCU_BIRIM'
      'TASINAN_ESYA=TASINAN_ESYA'
      'BAS_TAR=BAS_TAR'
      'BIT_TAR=BIT_TAR'
      'CIK_YER=CIK_YER'
      'BIT_YER=BIT_YER'
      'ALICI_BORC_BIRIM_FIY=ALICI_BORC_BIRIM_FIY'
      'ALICI_B_DOVKOD=ALICI_B_DOVKOD'
      'ALICI_BORC=ALICI_BORC'
      'ALICI_BORC_VPB=ALICI_BORC_VPB'
      'SATICI_ALACAK_BIRIM_FIY=SATICI_ALACAK_BIRIM_FIY'
      'SATICI_A_DOVKOD=SATICI_A_DOVKOD'
      'SATICI_ALACAK=SATICI_ALACAK'
      'SATICI_ALACAK_VPB=SATICI_ALACAK_VPB'
      'BEKLEME_FAT_TUTAR=BEKLEME_FAT_TUTAR'
      'BEKLEME_FAT_DOV_KOD=BEKLEME_FAT_DOV_KOD'
      'BEKLEME_FAT_VPB=BEKLEME_FAT_VPB'
      'SEFER_NOTLARI=SEFER_NOTLARI'
      'MASRAF_MERK=MASRAF_MERK'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'ALICI_B_DOV_BAZ_TAR=ALICI_B_DOV_BAZ_TAR'
      'SATICI_A_DOV_BAZ_TAR=SATICI_A_DOV_BAZ_TAR'
      'BEKLEME_FAT_DOV_BAZ_TAR=BEKLEME_FAT_DOV_BAZ_TAR'
      'ALICI_B_DOVKUR=ALICI_B_DOVKUR'
      'SATICI_A_DOVKUR=SATICI_A_DOVKUR'
      'BEKLEME_FAT_DOVKUR=BEKLEME_FAT_DOVKUR'
      'SEFER_TAMAMLANDI=SEFER_TAMAMLANDI'
      'SEFER_ALIS_FAT_ALINDI=SEFER_ALIS_FAT_ALINDI'
      'ALIS_URUN_HAR_ID=ALIS_URUN_HAR_ID'
      'SEFER_SATIS_FAT_KESILDI=SEFER_SATIS_FAT_KESILDI'
      'SATIS_URUN_HAR_ID=SATIS_URUN_HAR_ID'
      'BEKLEME_FAT_VAR=BEKLEME_FAT_VAR'
      'BEKLEME_FATURASI_KESILDI=BEKLEME_FATURASI_KESILDI'
      'BEK_FAT_URUN_HAR_ID=BEK_FAT_URUN_HAR_ID'
      'MIKTAR=MIKTAR'
      'KONTEYNER_NO=KONTEYNER_NO'
      'SBEKLEME_FAT_VPB=SBEKLEME_FAT_VPB')
    DataSet = IB_Query1
    Left = 356
    Top = 147
  end
  object IB_Query1: TIB_Query
    ColumnAttributes.Strings = (
      'BEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SEFER_ALIS_FAT_ALINDI=BOOLEAN=1,0'
      'SEFER_SATIS_FAT_KESILDI=BOOLEAN=1,0'
      'SECIM=BOOLEAN=1,0'
      'BEKLEME_FATURASI_KESILDI=BOOLEAN=1,0'
      'SEFER_TAMAMLANDI=BOOLEAN=1,0')
    DatabaseName = 'C:\ekinci_data\EKINCI2012.FDB'
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
    SQL.Strings = (
      'SELECT SEFER_ID'
      '     , SEFER_SID'
      '     , SEFER_SAY'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD' +
        ') AS ARAC_PLAKA'
      '     , ALICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_' +
        'KOD) AS ALICI_ADI'
      '     , SATICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI' +
        '_KOD) AS SATICI_ADI'
      '     , PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI'
      '     , OLCU_TIP'
      '     , OLCU_BIRIM'
      '     , TASINAN_ESYA'
      '     , BAS_TAR'
      '     , BIT_TAR'
      '     , CIK_YER'
      '     , BIT_YER'
      '     , ALICI_BORC_BIRIM_FIY'
      '     , ALICI_B_DOVKOD'
      '     , ALICI_BORC'
      '     , ALICI_BORC_VPB'
      '     , SATICI_ALACAK_BIRIM_FIY'
      '     , SATICI_A_DOVKOD'
      '     , SATICI_ALACAK'
      '     , SATICI_ALACAK_VPB'
      '     , BEKLEME_FAT_VAR'
      '     , BEKLEME_FAT_TUTAR'
      '     , BEKLEME_FAT_DOV_KOD'
      '     , BEKLEME_FAT_VPB'
      '     , SEFER_NOTLARI'
      '     , SEFER_ALIS_FAT_ALINDI'
      '     , SEFER_SATIS_FAT_KESILDI'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , ALICI_B_DOV_BAZ_TAR'
      '     , SATICI_A_DOV_BAZ_TAR'
      '     , BEKLEME_FAT_DOV_BAZ_TAR'
      '     , ALICI_B_DOVKUR'
      '     , SATICI_A_DOVKUR'
      '     , BEKLEME_FAT_DOVKUR'
      '     , SEFER_TAMAMLANDI'
      '     , DORSE_KOD'
      '     , ALIS_URUN_HAR_ID'
      '     , SATIS_URUN_HAR_ID'
      '     , SECIM'
      '     , BEKLEME_FATURASI_KESILDI'
      '     , BEK_FAT_URUN_HAR_ID'
      '     , MIKTAR  '
      '    , KONTEYNER_NO'
      '     , SBEKLEME_FAT_VPB '
      'FROM SEFER'
      '/*WHERE SEFER_ID=:PRM_SEFER_ID AND SEFER_SID=:PRM_SEFER_SID*/')
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
      'SEFER.SEFER_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 320
    Top = 192
  end
end
