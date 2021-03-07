object frmIrsaliye_Fatura: TfrmIrsaliye_Fatura
  Left = 327
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #304'rsaliye Faturala'#351't'#305'rma'
  ClientHeight = 456
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 16
    Width = 36
    Height = 13
    Caption = 'Cari Ad'#305
  end
  object lblCariAD: TLabel
    Left = 96
    Top = 16
    Width = 43
    Height = 13
    Caption = 'lblCariAD'
  end
  object Label2: TLabel
    Left = 48
    Top = 48
    Width = 147
    Height = 13
    Caption = 'Cariye Ait '#304'rsaliyeler ve detaylar'#305
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 72
    Width = 780
    Height = 150
    CustomGlyphsSupplied = []
    DataSource = dtsFAT_IRS
    Align = alBottom
    OnDblClick = IB_Grid1DblClick
    ReadOnly = True
    TabOrder = 0
    OnExit = IB_Grid1Exit
    OnKeyDown = IB_Grid1KeyDown
    RowSelect = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 424
    Width = 780
    Height = 32
    Align = alBottom
    TabOrder = 1
    object SpeedButton2: TSpeedButton
      Left = 8
      Top = 3
      Width = 153
      Height = 25
      Caption = 'Se'#231'ilen '#304'rsaliyeleri Faturala'#351't'#305'r'
      OnClick = SpeedButton1Click
    end
    object btnCikis: TBitBtn
      Left = 696
      Top = 3
      Width = 61
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 0
      OnClick = btnCikisClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
  end
  object IB_Grid2: TIB_Grid
    Left = 0
    Top = 222
    Width = 780
    Height = 202
    CustomGlyphsSupplied = []
    DataSource = dtsURUNHAR
    Align = alBottom
    OnDblClick = IB_Grid2DblClick
    ReadOnly = True
    TabOrder = 2
    OnExit = IB_Grid2Exit
    OnKeyDown = IB_Grid2KeyDown
    RowSelect = True
  end
  object trnFAT_IRS: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 148
    Top = 202
  end
  object qry: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 480
    Top = 152
  end
  object qryFAT_IRS1: TIB_Query
    ColumnAttributes.Strings = (
      'IPTAL=BOOLEAN=1,0'
      'YAZILDI=BOOLEAN=1,0'
      'SECIM=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsDisplayFormat.Strings = (
      'KDV1=#,##'
      'KDV2=#,##'
      'KDV3=#,##'
      'KDV4=#,##'
      'KDV5=#,##'
      'BRUTTOP=#,##.00'
      'NETTOP=#,##'
      'GENELTOP=#,##'
      'KDVTOP=#,##'
      'INDIRIMTOP=#,##'
      'KALEM_ISKONTO_TOPLAMVBP=#,##.00'
      'FATURA_ISKONTO_TUTARVPB=#,##.00'
      'ISKONTO_TOPLAMIVPB=#,##.00'
      'OTV=#,##')
    FieldsDisplayLabel.Strings = (
      'FATSERI=Seri No'
      'FATURA_KOD=Kodu'
      'REF_BELGE_TUR=Belge T'#252'r'#252
      'PLASIYER_KOD=Plasiyer Kodu'
      'VADE_TARIH=Vade Tarihi'
      'VADE_GUN=Vade G'#252'n'
      'TARIH='#304#351'lem Tarih'
      'FATURA_TIP=Fatura Tipi'
      'ACIKLAMA=Ac'#305'klama'
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
      'YEV_ACIKLAMA=Yevmiye ACK')
    FieldsIndex.Strings = (
      'FAT_IRS_SEP'
      'FAT_IRS_ID'
      'FAT_IRS_SID'
      'SECIM'
      'TIP'
      'CARI_KOD'
      'FAT_IRS_SERI'
      'BELGE_NO'
      'TARIH'
      'REF_BELGE_TUR'
      'REF_BELGE_ID'
      'REF_BELGE_SID'
      'ACIKLAMA'
      'BRUT_TOP'
      'NET_TOP'
      'GENEL_TOP'
      'KDV_TOP'
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
      'CARI_AD')
    FieldsVisible.Strings = (
      'FAT_IRS_SEP=FALSE'
      'FAT_IRS_ID=FALSE'
      'FAT_IRS_SID=FALSE'
      'REF_BELGE_ID=FALSE'
      'REF_BELGE_SID=FALSE'
      'YAZILDI=FALSE'
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
      'DEPO_AD=FALSE'
      'PLASIYER_AD=FALSE'
      'PROJE_KOD=FALSE'
      'PROJE_AD=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT FAT_IRS_SEP     '
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , CARI_KOD'
      '     , FAT_IRS_SERI'
      '     , BELGE_NO'
      '     , TARIH'
      '     , REF_BELGE_TUR'
      '     , REF_BELGE_ID'
      '     , REF_BELGE_SID'
      '     , ACIKLAMA'
      '     , BRUT_TOP'
      '     , NET_TOP'
      '     , GENEL_TOP'
      '     , KDV_TOP'
      '     , TIP'
      '     , YAZILDI'
      '     , IPTAL'
      '     , PLASIYER_KOD  '
      '     , DEPO_KOD'
      '     , SAAT'
      '     , KALEM_ISKONTO_TOPLAM_VPB'
      '     , ISKONTO_TIP'
      '     , ISKONTO_ORAN'
      '     , ISKONTO_TUTAR_VPB'
      '     , ISKONTO_TOPLAM_VPB'
      '     , KDV1'
      '     , KDV2'
      '     , KDV3'
      '     , KDV4'
      '     , KDV5'
      '     , OTV'
      '     , VADE_GUN'
      '     , VADE_TARIH'
      '     , FAT_IRS_TIP'
      '     , KDV1_ORAN'
      '     , KDV2_ORAN'
      '     , KDV3_ORAN'
      '     , KDV4_ORAN'
      '     , KDV5_ORAN'
      '     , DOV_BAZ_TAR'
      '     , MUHTELIF'
      '     , KASA_KOD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4      '
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=FAT_I' +
        'RS.KASA_KOD) as KASA_AD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=FAT_IR' +
        'S.CARI_KOD) As CARI_AD   '
      
        '     , (Select DEPO.ADI From DEPO Where DEPO.DEPO_KOD=FAT_IRS.DE' +
        'PO_KOD ) As DEPO_AD'
      
        '     , (Select PLASIYER.ADISOY from PLASIYER Where PLASIYER.PLAS' +
        'IYER_KOD=FAT_IRS.PLASIYER_KOD) AS PLASIYER_AD'
      '     , PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=F' +
        'AT_IRS.PROJE_KOD) As PROJE_AD'
      '     , YEV_ACIKLAMA'
      '     ,SECIM   '
      'FROM FAT_IRS '
      
        'WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND CARI_KOD=:PRM_CARI_KOD AN' +
        'D TIP=:TIP AND (KAPANDI IS NULL OR KAPANDI='#39'0'#39')'
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
    RequestLive = True
    AfterScroll = qryFAT_IRS1AfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 148
    Top = 268
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object dtsFAT_IRS: TIB_DataSource
    AutoInsert = False
    Dataset = qryFAT_IRS1
    Left = 150
    Top = 318
  end
  object qryURUNHAR1: TIB_Query
    ColumnAttributes.Strings = (
      'SECIM=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsDisplayFormat.Strings = (
      'MIKTAR=#,##.00'
      'TUTARDOV=#,##.00'
      'TUTARVPB=#,##.00'
      'DOVKUR=#,##.00'
      'ISKONTO_TUTAR=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'BIRIMFIY=#,##.00'
      'KDV_TUTAR=#,##.00')
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
      'TUTAR=114'
      'TUTAR_VPB=118')
    FieldsEditMask.Strings = (
      'KDV_TUTAR=#,##.00')
    FieldsIndex.Strings = (
      'FATURA_ID'
      'FATURA_SID'
      'SECIM'
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
      'SECIM=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
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
      '     ,SECIM   '
      'FROM URUNHAR'
      
        'WHERE IRSALIYE_ID=:PRM_IRSALIYE_ID And IRSALIYE_SID=:PRM_IRSALIY' +
        'E_SID'
      'ORDER BY URUNHAR_ID;')
    ColorScheme = False
    KeyLinks.Strings = (
      'URUNHAR.URUNHAR_ID'
      'URUNHAR.URUNHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 222
    Top = 268
    ParamValues = (
      'PRM_IRSALIYE_ID=0')
  end
  object dtsURUNHAR: TIB_DataSource
    AutoInsert = False
    Dataset = qryURUNHAR1
    Left = 228
    Top = 320
  end
  object IB_Query1: TIB_Query
    ColumnAttributes.Strings = (
      'SECIM=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsDisplayFormat.Strings = (
      'MIKTAR=#,##.00'
      'TUTARDOV=#,##.00'
      'TUTARVPB=#,##.00'
      'DOVKUR=#,##.00'
      'ISKONTO_TUTAR=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'BIRIMFIY=#,##.00'
      'KDV_TUTAR=#,##.00')
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
      'TUTAR=114'
      'TUTAR_VPB=118')
    FieldsEditMask.Strings = (
      'KDV_TUTAR=#,##.00')
    FieldsIndex.Strings = (
      'FATURA_ID'
      'FATURA_SID'
      'SECIM'
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
      'SECIM=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
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
      '     ,SECIM   '
      'FROM URUNHAR'
      
        'WHERE IRSALIYE_ID=:PRM_IRSALIYE_ID And IRSALIYE_SID=:PRM_IRSALIY' +
        'E_SID'
      'ORDER BY URUNHAR_ID;')
    ColorScheme = False
    KeyLinks.Strings = (
      'URUNHAR.URUNHAR_ID'
      'URUNHAR.URUNHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 270
    Top = 268
    ParamValues = (
      'PRM_IRSALIYE_ID=0')
  end
end
