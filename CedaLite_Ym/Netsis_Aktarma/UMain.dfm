object FrmMain: TFrmMain
  Left = 132
  Top = 102
  Width = 858
  Height = 606
  Caption = 'Netsis Sat'#305#351' Faturalar'#305' Aktar'#305'm'#305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object IB_Grid2: TIB_Grid
    Left = 0
    Top = 177
    Width = 850
    Height = 189
    CustomGlyphsSupplied = []
    DataSource = dtsFAT_IRS
    Align = alClient
    TabOrder = 0
    RowSelect = True
  end
  object IB_Grid3: TIB_Grid
    Left = 0
    Top = 366
    Width = 850
    Height = 145
    CustomGlyphsSupplied = []
    DataSource = Dts_Asl_Urun_Har
    Align = alBottom
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 511
    Width = 850
    Height = 68
    Align = alBottom
    TabOrder = 2
    object lbl_Fatura_Id: TLabel
      Left = 88
      Top = 15
      Width = 89
      Height = 13
      AutoSize = False
      Caption = '0'
    end
    object Label3: TLabel
      Left = 16
      Top = 15
      Width = 42
      Height = 13
      Caption = 'Fatura Id'
    end
    object btn_Fatura_Aktar_Tek: TButton
      Left = 536
      Top = 11
      Width = 297
      Height = 25
      Caption = 'Tek Aktif Faturay'#305' Netsis e Aktar'
      Enabled = False
      TabOrder = 0
      Visible = False
      OnClick = btn_Fatura_Aktar_TekClick
    end
    object btn_Fatura_Aktar: TButton
      Left = 16
      Top = 35
      Width = 273
      Height = 25
      Caption = 'T'#252'm Faturalar'#305'n Aktarma '#304#351'lemini Ba'#351'lat'
      Enabled = False
      TabOrder = 1
      Visible = False
      OnClick = btn_Fatura_AktarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 850
    Height = 177
    Align = alTop
    TabOrder = 3
    object IB_Grid1: TIB_Grid
      Left = 16
      Top = 16
      Width = 369
      Height = 120
      CustomGlyphsSupplied = []
      DataSource = Dts_Query_Dosya
      TabOrder = 0
    end
    object Button2: TButton
      Left = 16
      Top = 144
      Width = 369
      Height = 25
      Caption = 'Aktar'#305'lacak D'#246'nem Se'#231
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 520
      Top = 144
      Width = 313
      Height = 25
      Caption = 'Aktar'#305'lanlar'#305' Faturalar'#305' G'#246'ster '
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object Query_Dosya: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'DONEM_NO=D'#246'nem No'
      'DONEM_BAS=D'#246'nem Ba'#351'lang'#305#231' Tarihi'
      'DONEM_SON=D'#246'nem Biti'#351' Tarihi')
    FieldsDisplayWidth.Strings = (
      'DONEM_BAS=113')
    FieldsIndex.Strings = (
      'CONN_LOCAL'
      'SERVER_NAME'
      'DB_PATH'
      'USER_NAME'
      'PASS_WORD'
      'DONEM_NO'
      'DONEM_BAS'
      'DONEM_SON'
      'DB_KEY')
    FieldsVisible.Strings = (
      'DB_KEY=FALSE'
      'USER_NAME=FALSE'
      'PASS_WORD=FALSE'
      'CONN_LOCAL=FALSE'
      'SERVER_NAME=FALSE'
      'DB_PATH=FALSE')
    IB_Connection = IB_Conn
    SQL.Strings = (
      
        'Select CONN_LOCAL,SERVER_NAME,DB_PATH,USER_NAME,PASS_WORD,DONEM_' +
        'BAS,DONEM_SON,DONEM_NO'
      'from TERMS')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 72
    Top = 88
  end
  object IB_Conn: TIB_Connection
    SQLDialect = 3
    Params.Strings = (
      'CHARACTER SET=WIN1254'
      'USER NAME=sysdba'
      'SQL DIALECT=3'
      'PAGE SIZE=8192'
      'PATH=C:\CedaLite\Trans_Db\MAIN.FDB')
    Left = 160
    Top = 32
  end
  object Dts_Query_Dosya: TIB_DataSource
    Dataset = Query_Dosya
    Left = 72
    Top = 40
  end
  object IB_Conn_Data: TIB_Connection
    SQLDialect = 3
    Params.Strings = (
      'CHARACTER SET=WIN1254'
      'USER NAME=sysdba'
      'SQL DIALECT=3'
      'PAGE SIZE=8192'
      'PATH=C:\transport\Db\TRANSPORT.FDB'
      'SERVER=dilsad2'
      'PROTOCOL=TCP/IP')
    Left = 240
    Top = 32
  end
  object qryFAT_IRS: TIB_Query
    ColumnAttributes.Strings = (
      'IPTAL=BOOLEAN=1,0'
      'YAZILDI=BOOLEAN=1,0')
    DatabaseName = 'dilsad2:C:\transport\Db\TRANSPORT.FDB'
    FieldsDisplayFormat.Strings = (
      'KDV1=#,##'
      'KDV2=#,##'
      'KDV3=#,##'
      'KDV4=#,##'
      'KDV5=#,##'
      'BRUTTOP=#,.00'
      'NETTOP=#,.00'
      'GENELTOP=#,.00'
      'KDVTOP=#,.00'
      'INDIRIMTOP=#,##'
      'KALEM_ISKONTO_TOPLAMVBP=#,##.00'
      'FATURA_ISKONTO_TUTARVPB=#,##.00'
      'ISKONTO_TOPLAMIVPB=#,##.00'
      'OTV=#,##'
      'BRUT_TOP=#,.00'
      'NET_TOP=#,.00'
      'GENEL_TOP=#,.00'
      'KDV_TOP=#,.00')
    FieldsDisplayLabel.Strings = (
      'FATSERI=Seri No'
      'FATURA_KOD=Kodu'
      'REF_BELGE_TUR=Belge T'#252'r'#252
      'PLASIYER_KOD=Plasiyer Kodu'
      'VADE_TARIH=Vade Tarihi'
      'VADE_GUN=Vade G'#252'n'
      'TARIH='#304#351'lem Tarih'
      'FATURA_TIP=Fatura Tipi'
      'ACIKLAMA=A'#231#305'klama'
      'FATURA_ISKONTO_ORAN='#304'skonto Oran'
      'FATURA_ISKONTO_TUTARVPB='#304'skonto Tutar'
      'FIILI_TAR=Fiili Tarih'
      'DOV_BAZ_TAR=D'#246'v Baz Tarih'
      'OTV='#214'TV'
      'DEPO_KOD=Depo Kodu'
      'DEPO_AD=Depo Ad'
      'PLASIYER_AD=Plasiyer Ad'
      'KASA_KOD=Kasa Kodu'
      'KASA_AD=Kasa Ad'#305
      'CARI_KOD=Cari Kodu'
      'PROJE_KOD=Proje Kodu'
      'PROJE_AD=Proje Ad'#305
      'YEV_ACIKLAMA=Yevmiye ACK'
      'FAT_IRS_ID=Fi'#351' No'
      'TIP=Tipi'
      'ISKONTO_ORAN='#304'skonto Oran'
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar VPB'
      'FAT_IRS_TIP=Tipi'
      'SEVK_ADRES_KOD=Sevk Adresi'
      'CARI_AD=Cari Ad'#305
      'FAT_IRS_SID=Sid'
      'BELGE_NO=Belge No'
      'FAT_IRS_SERI=Seri'
      'BRUT_TOP=B'#252'r'#252't Top'
      'NET_TOP=Net Top'
      'GENEL_TOP=Genel Top'
      'KDV_TOP=Kdv Top'
      'YAZILDI=Yaz'#305'ld'#305)
    FieldsDisplayWidth.Strings = (
      'FAT_IRS_SID=22'
      'FAT_IRS_ID=45'
      'CARI_KOD=74'
      'FAT_IRS_SERI=25'
      'BELGE_NO=51'
      'TARIH=64'
      'BRUT_TOP=78'
      'NET_TOP=74'
      'GENEL_TOP=78'
      'KDV_TOP=79'
      'YAZILDI=45'
      'CARI_AD=156'
      'ACIKLAMA=165')
    FieldsIndex.Strings = (
      'FAT_IRS_SEP'
      'FAT_IRS_ID'
      'FAT_IRS_SID'
      'CARI_KOD'
      'CARI_AD'
      'FAT_IRS_SERI'
      'BELGE_NO'
      'TARIH'
      'REF_BELGE_TUR'
      'REF_BELGE_ID'
      'REF_BELGE_SID'
      'ACIKLAMA'
      'BRUT_TOP'
      'NET_TOP'
      'KDV_TOP'
      'GENEL_TOP'
      'TIP'
      'YAZILDI'
      'IPTAL'
      'PLASIYER_KOD'
      'DEPO_KOD'
      'SAAT'
      'KALEM_ISKONTO_TOPLAM_VPB'
      'ISKONTO_TIP'
      'ISKONTO_ORAN'
      'ISKONTO_TUTAR_VPB'
      'ISKONTO_TOPLAM_VPB'
      'KDV1'
      'KDV2'
      'KDV3'
      'KDV4'
      'KDV5'
      'OTV'
      'VADE_GUN'
      'VADE_TARIH'
      'FAT_IRS_TIP'
      'KDV1_ORAN'
      'KDV2_ORAN'
      'KDV3_ORAN'
      'KDV4_ORAN'
      'KDV5_ORAN'
      'DOV_BAZ_TAR'
      'MUHTELIF'
      'KASA_KOD'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'KASA_AD'
      'DEPO_AD'
      'PLASIYER_AD'
      'PROJE_KOD'
      'PROJE_AD'
      'YEV_ACIKLAMA'
      'KAPANDI'
      'SEVK_ADRES_KOD')
    FieldsVisible.Strings = (
      'FAT_IRS_SEP=FALSE'
      'FAT_IRS_SID=TRUE'
      'IPTAL=FALSE'
      'PLASIYER_KOD=FALSE'
      'DEPO_KOD=FALSE'
      'SAAT=FALSE'
      'KALEM_ISKONTO_TOPLAM_VPB=FALSE'
      'ISKONTO_TIP=FALSE'
      'ISKONTO_ORAN=FALSE'
      'ISKONTO_TUTAR_VPB=FALSE'
      'ISKONTO_TOPLAM_VPB=FALSE'
      'KDV1=FALSE'
      'KDV2=FALSE'
      'KDV3=FALSE'
      'KDV4=FALSE'
      'KDV5=FALSE'
      'OTV=FALSE'
      'VADE_GUN=FALSE'
      'VADE_TARIH=FALSE'
      'FAT_IRS_TIP=FALSE'
      'KDV1_ORAN=FALSE'
      'KDV2_ORAN=FALSE'
      'KDV3_ORAN=FALSE'
      'KDV4_ORAN=FALSE'
      'KDV5_ORAN=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'MUHTELIF=FALSE'
      'KASA_KOD=FALSE'
      'MASRAF_MERK=FALSE'
      'KOD1=FALSE'
      'KOD2=FALSE'
      'KOD3=FALSE'
      'KOD4=FALSE'
      'KASA_AD=FALSE'
      'CARI_AD=TRUE'
      'DEPO_AD=FALSE'
      'PLASIYER_AD=FALSE'
      'PROJE_KOD=FALSE'
      'PROJE_AD=FALSE'
      'YEV_ACIKLAMA=FALSE'
      'KAPANDI=FALSE'
      'SEVK_ADRES_KOD=FALSE'
      'TIP=FALSE'
      'REF_BELGE_TUR=FALSE'
      'REF_BELGE_ID=FALSE'
      'REF_BELGE_SID=FALSE')
    IB_Connection = IB_Conn_Data
    SQL.Strings = (
      'SELECT f.FAT_IRS_SEP'
      '     , f.FAT_IRS_ID'
      '     , f.FAT_IRS_SID'
      '     , f.CARI_KOD'
      '     , f.FAT_IRS_SERI'
      '     , f.BELGE_NO'
      '     , f.TARIH'
      '     , f.REF_BELGE_TUR'
      '     , f.REF_BELGE_ID'
      '     , f.REF_BELGE_SID'
      '     , f.ACIKLAMA'
      '     , f.BRUT_TOP'
      '     , f.NET_TOP'
      '     , f.GENEL_TOP'
      '     , f.KDV_TOP'
      '     , f.TIP'
      '     , f.YAZILDI'
      '     , f.IPTAL'
      '     , f.PLASIYER_KOD  '
      '     , f.DEPO_KOD'
      '     , f.SAAT'
      '     , f.KALEM_ISKONTO_TOPLAM_VPB'
      '     , f.ISKONTO_TIP'
      '     , f.ISKONTO_ORAN'
      '     , f.ISKONTO_TUTAR_VPB'
      '     , f.ISKONTO_TOPLAM_VPB'
      '     , f.KDV1'
      '     , f.KDV2'
      '     , f.KDV3'
      '     , f.KDV4'
      '     , f.KDV5'
      '     , f.OTV'
      '     , f.VADE_GUN'
      '     , f.VADE_TARIH'
      '     , f.FAT_IRS_TIP'
      '     , f.KDV1_ORAN'
      '     , f.KDV2_ORAN'
      '     , f.KDV3_ORAN'
      '     , f.KDV4_ORAN'
      '     , f.KDV5_ORAN'
      '     , f.DOV_BAZ_TAR'
      '     , f.MUHTELIF'
      '     , f.KASA_KOD'
      '     , f.MASRAF_MERK'
      '     , f.KOD1'
      '     , f.KOD2'
      '     , f.KOD3'
      '     , f.KOD4      '
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=FAT_I' +
        'RS.KASA_KOD) as KASA_AD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=FAT_IR' +
        'S.CARI_KOD) As CARI_AD   '
      
        '     , (Select DEPO.ADI From DEPO Where DEPO.DEPO_KOD=FAT_IRS.DE' +
        'PO_KOD ) As DEPO_AD'
      
        '     , (Select PLASIYER.ADISOY from PLASIYER Where PLASIYER.PLAS' +
        'IYER_KOD=FAT_IRS.PLASIYER_KOD) AS PLASIYER_AD'
      '     , f.PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=F' +
        'AT_IRS.PROJE_KOD) As PROJE_AD'
      '     , f.YEV_ACIKLAMA'
      '     , f.KAPANDI'
      '     , f.SEVK_ADRES_KOD'
      'FROM FAT_IRS f'
      'WHERE'
      'f.TIP=1'
      
        'and not (f.FAT_IRS_ID in (SELECT a.FAT_IRS_ID FROM fat_irs_aktar' +
        ' a'
      
        'WHERE f.FAT_IRS_SEP=a.FAT_IRS_SEP AND f.FAT_IRS_ID=a.FAT_IRS_ID ' +
        'AND f.FAT_IRS_SID=a.FAT_IRS_SID))'
      'Order By f.FAT_IRS_ID'
      '')
    ColorScheme = False
    DefaultValues.Strings = (
      'FATURA_ID=0'
      'FATURA_SID=0'
      'CARI_ID=0'
      'CARI_SID=0'
      'REF_BELGE_ID=0'
      'REF_BELGE_SID=0'
      'BRUTTOP=0'
      'NETTOP=0'
      'GENELTOP=0'
      'KDVTOP=0'
      'YAZILDI=0'
      'PLASIYER_ID=0'
      'PLASIYER_SID=0'
      'DEPO_ID=0'
      'DEPO_SID=0'
      'KALEM_ISKONTO_TOPLAMVBP=0'
      'FATURA_ISKONTO_TUTARVPB=0'
      'ISKONTO_TOPLAMIVPB=0'
      'KDV1=0'
      'KDV2=0'
      'KDV3=0'
      'KDV4=0'
      'KDV5=0'
      'OTV=0'
      'IPTAL=0')
    KeyLinks.Strings = (
      'FAT_IRS.FAT_IRS_SEP'
      'FAT_IRS.FAT_IRS_ID'
      'FAT_IRS.FAT_IRS_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      'Fi'#351' No=FAT_IRS_ID;FAT_IRS_ID DESC'
      'Cari Kodu=CARI_KOD;CARI_KOD DESC'
      'Seri=FAT_IRS_SERI;FAT_IRS_SERI DESC'
      'Belge No=BELGE_NO;BELGE_NO DESC'
      #304#351'lem Tarih=TARIH;TARIH DESC'
      'A'#231#305'klama=ACIKLAMA;ACIKLAMA DESC'
      'Yaz'#305'ld'#305'=YAZILDI;YAZILDI DESC')
    OrderingLinks.Strings = (
      'FAT_IRS_ID=ITEM=1'
      'CARI_KOD=ITEM=2'
      'FAT_IRS_SERI=ITEM=3'
      'BELGE_NO=ITEM=4'
      'TARIH=ITEM=5'
      'ACIKLAMA=ITEM=6'
      'YAZILDI=ITEM=7')
    RequestLive = True
    AfterScroll = qryFAT_IRSAfterScroll
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 416
    Top = 168
  end
  object Qry_Asl_Urun_Har: TIB_Query
    DatabaseName = 'dilsad2:C:\transport\Db\TRANSPORT.FDB'
    FieldsDisplayFormat.Strings = (
      'MIKTAR=#,##.00'
      'TUTARDOV=#,##.00'
      'TUTARVPB=#,##.00'
      'DOVKUR=#,##.00'
      'ISKONTO_TUTAR=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'BIRIMFIY=#,##.00'
      'KDV_TUTAR=#,##.00'
      'TUTAR=#,.00'
      'TUTAR_VPB=#,.00'
      'BIRIM_FIY=#,.00'
      'KDV=#,.00')
    FieldsDisplayLabel.Strings = (
      'ACIKLAMA=Ac'#305'klama'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'MIKTAR=Miktar'
      'BIRIMFIY=Birim Fiyat'
      'DOVKOD=Para Birimi'
      'DOVKUR=D'#246'viz Kuru'
      'TUTARDOV=Tutar'
      'TUTARVPB=Tutar VPB'
      'TARIH=Tarih'
      'DEPO_KOD=Depo Kodu'
      'DEPO_AD=Depo Ad'#305
      'KDV=KDV'
      'ISKONTO_ORAN= '#304's. Oran'
      'ISKONTO_TUTAR='#304's.Tutar'
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar VPB'
      'ISKONTO_TIP='#304'skonto Tip'
      'KDV_TUTAR=KDV Tutar'
      'BIRIM_FIY=Birim Fiyat'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar VPB')
    FieldsDisplayWidth.Strings = (
      'URUN_KOD=83'
      'BIRIMFIY=86'
      'DOVKOD=55'
      'MIKTAR=45'
      'OLCUBIRIM=56'
      'TUTARDOV=92'
      'TUTARVPB=107'
      'ACIKLAMA=182'
      'KDV_TUTAR=71'
      'BIRIM_FIY=74'
      'TUTAR=101'
      'TUTAR_VPB=118')
    FieldsEditMask.Strings = (
      'KDV_TUTAR=#,##.00')
    FieldsIndex.Strings = (
      'FATURA_ID'
      'FATURA_SID'
      'URUN_KOD'
      'ACIKLAMA'
      'BIRIM_FIY'
      'DOVKOD'
      'MIKTAR'
      'OLCUBIRIM'
      'URUN_AD'
      'DOVKUR'
      'TARIH'
      'DEPO_KOD'
      'DEPO_AD'
      'KDV'
      'ISKONTO_ORAN'
      'ISKONTO_TUTAR'
      'ISKONTO_TUTAR_VPB'
      'ISKONTO_TIP'
      'URUNHAR_ID'
      'URUNHAR_SID'
      'FIILI_TAR'
      'DOV_BAZ_TAR'
      'TIP'
      'BELGE_TUR'
      'BELGE_ID'
      'BELGE_SID'
      'BELGE_SIRA_NO'
      'OLCUBIRIM_URN_OB'
      'MIKTAR_URN_OB'
      'TUTAR'
      'TUTAR_VPB'
      'URUN_DOVKOD'
      'TUTAR_URUN_DOVKOD'
      'BIRIM_FIY_VPB'
      'BIRIM_FIY_URN_DOVKOD'
      'IRSALIYE_ID'
      'IRSALIYE_SID'
      'MASRAF_MERK'
      'KDV_TUTAR'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4')
    FieldsVisible.Strings = (
      'FATURA_D_ID=FALSE'
      'FATURA_D_SID=FALSE'
      'FATURA_ID=FALSE'
      'FATURA_SID=FALSE'
      'URUN_AD=FALSE'
      'DOVKUR=FALSE'
      'TARIH=FALSE'
      'REF_BELGE_ID=FALSE'
      'REF_BELGE_TUR=FALSE'
      'DEPO_KOD=FALSE'
      'DEPO_AD=FALSE'
      'KDV=FALSE'
      'ISKONTO_ORAN=FALSE'
      'ISKONTO_TUTAR=FALSE'
      'ISKONTO_TUTAR_VPB=FALSE'
      'ISKONTO_TIP=FALSE'
      'SIRA_NO=FALSE'
      'KDV_TUTAR=FALSE'
      'KOD4=FALSE'
      'KOD3=FALSE'
      'KOD2=FALSE'
      'KOD1=FALSE'
      'MASRAF_MERK=FALSE'
      'IRSALIYE_SID=FALSE'
      'IRSALIYE_ID=FALSE'
      'BIRIM_FIY_URN_DOVKOD=FALSE'
      'BIRIM_FIY_VPB=FALSE'
      'BIRIM_FIY=TRUE'
      'TUTAR_URUN_DOVKOD=FALSE'
      'URUN_DOVKOD=FALSE'
      'MIKTAR_URN_OB=FALSE'
      'OLCUBIRIM_URN_OB=FALSE'
      'BELGE_SIRA_NO=FALSE'
      'BELGE_SID=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_TUR=FALSE'
      'TIP=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'FIILI_TAR=FALSE'
      'URUNHAR_SID=FALSE'
      'URUNHAR_ID=FALSE'
      'BIRIM_FIY_URN_OB=FALSE'
      'SECIM=FALSE'
      'CIKIS_MIKTAR=FALSE'
      'SEFER_ID=FALSE'
      'MAZOT_FISI_ID=FALSE'
      'SEFER_BEKLEME=FALSE')
    IB_Connection = IB_Conn_Data
    SQL.Strings = (
      'SELECT URUNHAR_ID'
      '     , URUNHAR_SID'
      '     , TARIH'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=URUNH' +
        'AR.URUN_KOD) AS URUN_AD'
      '     , ACIKLAMA'
      '     , TIP'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , BELGE_SIRA_NO'
      '     , OLCUBIRIM'
      '     , OLCUBIRIM_URN_OB'
      '     , MIKTAR'
      '     , MIKTAR_URN_OB'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , URUN_DOVKOD'
      '     , TUTAR_URUN_DOVKOD'
      '     , BIRIM_FIY'
      '     , BIRIM_FIY_VPB'
      '     , BIRIM_FIY_URN_DOVKOD'
      '     , ISKONTO_TIP'
      '     , ISKONTO_ORAN'
      '     , ISKONTO_TUTAR'
      '     , ISKONTO_TUTAR_VPB'
      '     , DEPO_KOD'
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = URUNHAR.' +
        'DEPO_KOD) AS DEPO_AD'
      '     , FATURA_ID'
      '     , FATURA_SID'
      '     , IRSALIYE_ID'
      '     , IRSALIYE_SID'
      '     , MASRAF_MERK'
      '     , KDV'
      '     , KDV_TUTAR'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , BIRIM_FIY_URN_OB'
      '     , SECIM'
      '     , CIKIS_MIKTAR'
      '     , SEFER_ID'
      '     , MAZOT_FISI_ID'
      '     , SEFER_BEKLEME'
      'FROM URUNHAR'
      'WHERE FATURA_ID=:PRM_FATURA_ID And FATURA_SID=:PRM_FATURA_SID'
      'ORDER BY URUNHAR_ID;')
    ColorScheme = False
    MasterSource = dtsFAT_IRS
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 728
    Top = 168
    ParamValues = (
      'PRM_FATURA_ID=0')
  end
  object dtsFAT_IRS: TIB_DataSource
    AutoInsert = False
    Dataset = qryFAT_IRS
    Left = 416
    Top = 216
  end
  object qryFAT_IRS_MUH_CARI: TIB_Query
    DatabaseName = 'dilsad2:C:\transport\Db\TRANSPORT.FDB'
    FieldsDisplayLabel.Strings = (
      'CARI_AD=Cari Ad'#305
      'YETKISI=Yetkilisi'
      'VERDAIRE=V. Dairesi'
      'VERNO=V. Nosu'
      'ADRES_1=Adres 1'
      'ADRES_2=Adres 2'
      'ILCE='#304'l'#231'e'
      'SEHIR='#350'ehir'
      'POSTA_KOD=P.K.'
      'TEL_NO_1=Tel 1'
      'TEL_NO_2=Tel 2'
      'FAX=Fax'
      'E_MAIL=E-Mail')
    FieldsVisible.Strings = (
      'FATURA_ID=FALSE'
      'FATURA_SID=FALSE')
    IB_Connection = IB_Conn_Data
    SQL.Strings = (
      'SELECT FAT_IRS_SEP'
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , CARI_AD'
      '     , YETKISI'
      '     , VERDAIRE'
      '     , VERNO'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , POSTA_KOD'
      '     , TEL_NO_1'
      '     , TEL_NO_2'
      '     , FAX'
      '     , E_MAIL'
      'FROM FAT_IRS_MUH_CARI '
      'WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND '
      '      FAT_IRS_ID=:PRM_FAT_IRS_ID AND '
      '      FAT_IRS_SID=:PRM_FAT_IRS_SID;')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 520
    Top = 168
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object dtsFAT_IRS_MUH_CARI: TIB_DataSource
    Dataset = qryFAT_IRS_MUH_CARI
    Left = 520
    Top = 216
  end
  object qryFAT_IRS_ACK: TIB_Query
    DatabaseName = 'dilsad2:C:\transport\Db\TRANSPORT.FDB'
    IB_Connection = IB_Conn_Data
    SQL.Strings = (
      'SELECT FAT_IRS_SEP'
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , ACK_30K_1'
      '     , ACK_30K_2'
      '     , ACK_30K_3'
      '     , ACK_50K_1'
      '     , ACK_50K_2'
      '     , ACK_50K_3'
      '     , ACK_50K_4'
      '     , ACK_50K_5'
      '     , ACK_100K_1'
      '     , ACK_100K_2'
      '     , ACK_100K_3'
      '     , ACK_100K_4'
      '     , ACK_100K_5'
      '     , ACK_30K_1_CAP'
      '     , ACK_30K_2_CAP'
      '     , ACK_30K_3_CAP'
      '     , ACK_50K_1_CAP'
      '     , ACK_50K_2_CAP'
      '     , ACK_50K_3_CAP'
      '     , ACK_50K_4_CAP'
      '     , ACK_50K_5_CAP'
      '     , ACK_100K_1_CAP'
      '     , ACK_100K_2_CAP'
      '     , ACK_100K_3_CAP'
      '     , ACK_100K_4_CAP'
      '     , ACK_100K_5_CAP'
      
        'FROM FAT_IRS_ACK  WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND FAT_IRS' +
        '_ID=:PRM_FAT_IRS_ID AND FAT_IRS_SID=:PRM_FAT_IRS_SID;')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 632
    Top = 168
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object dtsFAT_IRS_ACK: TIB_DataSource
    Dataset = qryFAT_IRS_ACK
    Left = 632
    Top = 216
  end
  object qry_Aktarilanlar: TIB_Query
    DatabaseName = 'dilsad2:C:\transport\Db\TRANSPORT.FDB'
    IB_Connection = IB_Conn_Data
    SQL.Strings = (
      'SELECT FAT_IRS_SEP'
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , TIP'
      '     , TARIH'
      'FROM FAT_IRS_AKTAR')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 320
    Top = 40
  end
  object Dts_Asl_Urun_Har: TIB_DataSource
    Dataset = Qry_Asl_Urun_Har
    Left = 728
    Top = 216
  end
  object qry_Temp: TIB_Query
    DatabaseName = 'dilsad2:C:\transport\Db\TRANSPORT.FDB'
    IB_Connection = IB_Conn_Data
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 552
    Top = 80
  end
end
